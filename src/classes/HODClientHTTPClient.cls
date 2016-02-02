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
     * @param params key, value pair that will be appended in query string
     */
     private static String getPathWithQueryParameters(String path, Map<String, Object> params)
     {
         // there will always be key
         path = path + '?';
         for(String key : params.keySet())
         {
             path = path + getQueryStringForParameter(key, params.get(key)); 
             path = path + '&';
         }
         path = path.substring(0, path.length()-1);
         return path;
     }
    
    /**
     * Creates pay load string for multipart type
     * 
     * @param params List of multipart to create the payload
     * @return payload as string
     */ 
    private static string getPayLoad(List<Multipart> params)
    {
        String body = ''; 
        // add each part
        for (Multipart part : params) {
            body+= '--' + HODClientConstants.BOUNDARY_MULTIPART + '\r\n';
            if (!part.isFile()) {
                // if type is not file
                body+='Content-Disposition: form-data; name="' + part.getName() + '"\r\n\r\n';
                body+=part.getContents();
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
     * @param params Query String data
     * @param payLoadData pay load data for POST request
     * @throws HODClientException
     */	
    
    public static Map<String,Object> invokeHODApi(String path, String call, String apiKey, 
                                      Map<String, Object> params, 
                                      List<Multipart> payLoadData)
    {
        HttpResponse resp = null;
        if(call == HODClientConstants.POST_REQUEST)
        {
            if(payLoadData!= null && payLoadData.size() > 0)
            {
                // post with payload
                // multipart call
                payLoadData.add(new Multipart(HODClientConstants.API_KEY, apiKey));
                String load = getPayLoad(payLoadData);
                resp = HttpClient.postRequest(path,load);
            }
            else
            {
                // post wth query string
                
                if(params == null) {
                    params = new Map<String, Object>();
                }
                params.put(HODClientConstants.API_KEY, apiKey);
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
    
  
    /**
     * Send request to HOD API server
     * Call appropiate end point  method 
     * All the calls without payload are passed through this method
     * @param path Path for the API, it does not contain query string
     * @param call  POST/GET
     * @param apiKey API Key of the user
     * @param params Query String data
     * @throws HODClientException
     */
    public static Map<String,Object> invokeHODApi(String path, String call, String apiKey, 
                                     Map<String, Object> params)
    {
        return invokeHODApi(path, call, apiKey, 
                                     params, 
                                     new List<Multipart>());
    }
	
    /**
     * Send request to HOD API server
     * Call appropiate end point  method 
     * All the calls with payload are passed through this method
     * @param path Path for the API, it does not contain query string
     * @param call  POST/GET
     * @param apiKey API Key of the user
     * @param payLoad paylaod for post request
     * @throws HODClientException
     */
    public static Map<String,Object> invokeHODApi(String path, String call, String apiKey, 
                                     List<Multipart> payLoad)
    {
        return invokeHODApi(path, call, apiKey, 
                            		 new Map<String, Object>(),
                                     payLoad);
    }
}