/**
 * HODClientHTTPClient This class is wrapper on HTTPClient , it contains Business logic for the API
 * 
 * @author Topcoder
 * @version 1.0
 * 
 */
public with sharing class HODClientHTTPClient {
    
    /*
     * Get the type of Salesforce object
     * 
     * @param o Object for which type has to be determined
     * @return type of the object 
     * */
     public static string getType(Object o) {
         if(o==null) return '';            
    	 if(o instanceof SObject)            return ((SObject)o).getSObjectType().getDescribe().getName()+''; 
    	 if(o instanceof Boolean)            return HODClientConstants.SALESFORCE_TYPES_BOOLEAN_TYPE;
    	 if(o instanceof Id)                 return HODClientConstants.SALESFORCE_TYPES_ID_TYPE;
    	 if(o instanceof Blob)               return HODClientConstants.SALESFORCE_TYPES_BLOB_TYPE;
    	 if(o instanceof Date)               return HODClientConstants.SALESFORCE_TYPES_DATE_TYPE;
    	 if(o instanceof Datetime)           return HODClientConstants.SALESFORCE_TYPES_DATETIME_TYPE;
    	 if(o instanceof Time)               return HODClientConstants.SALESFORCE_TYPES_TIME_TYPE;
    	 if(o instanceof Integer)            return HODClientConstants.SALESFORCE_TYPES_INTEGER_TYPE;
     	 if(o instanceof Long)               return HODClientConstants.SALESFORCE_TYPES_LONG_TYPE;
    	 if(o instanceof Decimal)            return HODClientConstants.SALESFORCE_TYPES_DECIMAL_TYPE; 
    	 if(o instanceof Double)             return HODClientConstants.SALESFORCE_TYPES_DOUBLE_TYPE;   
         if(o instanceof String)             return HODClientConstants.SALESFORCE_TYPES_STRING_TYPE;
    	 if(o instanceof List<object>)       return HODClientConstants.SALESFORCE_TYPES_LIST_TYPE;
    	 return 'Object';                    
  	}
    
    
    /**
     * Get Query String for key and value
     * Depending upon value type query string is generated
     * Currently only two types are supported String and List
     *
     * @param key key name
     * @param value value for the key
     */
     private static String getQueryStringForParameter(String key, Object value)
     {
     	 String queryParam = '';
         String valueType = GetType(value);
         // string type
         if(valueType == HODClientConstants.SALESFORCE_TYPES_STRING_TYPE)
         {
         	String stringValue = (String)value;
         	if(stringValue.length() != 0)
         	{
         		queryParam = key+'='+stringValue; 
         	}
         }
         // list type
         else if(valueType == HODClientConstants.SALESFORCE_TYPES_LIST_TYPE)
         {
         	List<String> listValue = (List<String>)value;
         	if(listValue.size() != 0)
         	{
         		for(String item : listValue)
         		{
         			queryParam = queryParam + key + '='+item+'&';
         		}
                // removing last dangling character &
         		queryParam = queryParam.subString(0, queryParam.length()-1);
         	}
         	
         }
         else
         {
             throw new HODClientException(HODClientConstants.ERROR_INPUT_PARAMS);
         }
         // return query param
         return queryParam;
     }
    
    
    /**
     * Get complete path with query string
     *
     * @param path url for the end point
     * @param params list of param 
     */
     private static String getPathWithQueryParameters(String path, List<Param>params)
     {
         // there will always be key
         path = path + '?';
         for (Param part : params)
         {
             path = path + getQueryStringForParameter(part.getName() , part.getContents()); 
             path = path + '&';
         }
         path = path.substring(0, path.length()-1);
         return path;
     }
    
    
    /**
     * Checks if file type object is passed
     * @param params to be passed
     * @return boolean true if exists else false
     */
    private static boolean checkIsFileExists(List<Param> params)
    {
        boolean isFileExists = false;
        for (Param part : params) {
            if(part.isFile())
            {
                isFileExists = true;
            }
        }
        return isFileExists;
    }
    
    /**
     * Creates pay load string for multipart type
     * 
     * @param params List of Param to create the payload
     * @return payload as string
     */ 
    private static string getPayLoad(List<Param> params)
    {
        String body = ''; 
        // add each part
        for (Param part : params) {
            body+= '--' + HODClientConstants.BOUNDARY_MULTIPART + '\r\n';
            if (!part.isFile()) {
                // if type is not file
                body+='Content-Disposition: form-data; name="' + part.getName() + '"\r\n\r\n';
                body+=(String)part.getContents();
            } else {
                // if it is file type
                body+='Content-Disposition: form-data; name="'+HODClientConstants.FILE_KEY+'"; filename="' + part.getName() + '"\r\n';
                body+='Content-Transfer-Encoding: base64\r\n';
                body+='Content-Type: ' + part.getContentType() + '\r\n\r\n';
                body+=EncodingUtil.base64Encode(part.getBlobContents());
            }
            body+='\r\n';
        }
        body+='--' + HODClientConstants.BOUNDARY_MULTIPART  + '--';
        body+='\r\n';
		return body;
    }
    
    /**
     * Send request to HOD API server
     * Call appropiate end point  method 
     * All the calls are passed through this method
     * @param path Path for the API, it does not contain query string
     * @param call  POST/GET
     * @param apiKey API Key of the user
     * @param params data to be passed
     * @throws HODClientException
     */	
    
    public static Map<String,Object> invokeHODApi(String path, String call, String apiKey, List<Param> params)
    {
        HttpResponse resp = null;
        params.add(new Param(HODClientConstants.API_KEY, apiKey));
        if(call == HODClientConstants.POST_REQUEST)
        {
           
            if(checkIsFileExists(params))
            {
                // post with payload
                String load = getPayLoad(params);
                resp = HttpClient.postRequest(path,load);
            }
            else
            {
                path = getPathWithQueryParameters(path , params);
                resp = HttpClient.postRequest(path,'');
            }
        }
        String responseBody  = '';
        // check for response status
        if(resp.getStatusCode() == HODClientConstants.STATUS_200_OK)
        {
            // success
            responseBody = resp.getBody();
        }
        else
        {
            Map<String,Object> data = (Map<String,Object>)JSON.deserializeUntyped(resp.getBody());
            String message = String.valueOf(data.get(HODClientConstants.ERROR_NO))+':'+String.valueOf(data.get(HODClientConstants.ERROR_REASON));
            //throw error
            throw new HODClientException(message);
        }
        
        
        return (Map<String,Object>)JSON.deserializeUntyped(responseBody);
        
    }
}