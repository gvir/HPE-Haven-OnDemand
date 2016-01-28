/**
 * HODClient class to consume HPE Haven OnDemand API
 *
 * @version 1.0
 * @author Topcoder
 */
public class HODClient {
   
    String apiKey = '';
    String version = '';
    String url = '';
   
    /**
     * Get URL to call the end point
     * 
     * @param hodApp method to call
     * @param version version no 
     * @mode SYNC/ASYNC
     */
    private static String getUrlString(String hodApp, String version,HODClientConstants.REQ_MODE mode)
    {
    	String callMode = mode.name().toLowerCase();
        return HODClientConstants.HOD_URL+HODClientConstants.HOD_API_URL+'/'+callMode+hodApp+'/'+version;
    }
    
    /**
     * Get URL to get job status
     */
    public static String getJobStatusURLString()
    {
        return  HODClientConstants.HOD_URL+'/'+HODClientConstants.JOB_STATUS;
    }
    
    /**
     * Get URL to get job result
     */
    public static STring getJobResultURLString()
    {
        return HODClientConstants.HOD_URL+'/'+HODClientConstants.JOB_RESULT;
    }
    
   /**
    * Constructor
    *
    * @param apiKey Api Key of the user
    * @param version Version of the api call should be made
    */
    public HODClient(String apiKey,String version)
    {
        this.apiKey = apiKey;
        this.version = version;
    }
    
   /**
    * Constructor
    *
    * @param apiKey Api Key of the user
    */
    public HODClient(String apiKey)
    {
    	this.apiKey = apiKey;
        this.version = HODClientConstants.DEFAULT_VERSION;
    }
    
    /**
     * calls POST Request
     *
     * @param params params to be passed in query string
     * @param hodApp end point to be called
     * @param mode sync/async
     * @return string response
     * @throws HODClientException 
     */ 
    public String postRequest(Map<String,Object> params, String hodApp, HODClientConstants.REQ_Mode mode)
    {
        String url = HODClient.GetUrlString(hodApp, this.version, mode);
        
        return HODClientHTTPClient.invokeHODApi(url, 
                                                HODClientConstants.POST_REQUEST, 
                                                this.apiKey,
                                                params);
    }
    
    /**
     * calls POST Request with file attachments
     *
     * @param params params to be passed in post body
     * @param hodApp end point to be called
     * @param mode sync/async
     * @return string response 
     * @throws HODClientException
     */ 
    public String postRequestWithAttachment(List<Multipart> params, String hodApp, HODClientConstants.REQ_Mode mode)
    {
        String url = HODClient.GetUrlString(hodApp, this.version, mode);
        System.debug('started');
        return HODClientHTTPClient.invokeHODApi(url, 
                                                HODClientConstants.POST_REQUEST, 
                                                this.apiKey,
                                                params);
    }
  	
    /**
     * Get status of the job submitted
     * @param jobId id of the job submitted
     * @throws HODClientException
     */
    public String getJobStatus(String jobId)
    {
      String url = getJobStatusURLString()+ jobId;
      return HODClientHTTPClient.invokeHODApi(url, 
                                              HODClientConstants.POST_REQUEST, 
                                              this.apiKey,
                                              new Map<String,Object>());
    }
    
    /**
     * Get result of the job submitted
     * @param jobId id of the job submitted
     * @throws HODClientException
     */
    public String getJobResult(String jobId)
    {
      String url = getJobResultURLString()+ jobId;
      return HODClientHTTPClient.invokeHODApi(url, 
                                              HODClientConstants.POST_REQUEST, 
                                              this.apiKey,
                                              new Map<String,Object>());
      
    }
}