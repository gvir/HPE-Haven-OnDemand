/**
 * HODClient class to consume HPE Haven OnDemand API
 * 1.1 : Added getRequest method
 *
 * @version 1.1
 * @author: Topcoder

 */
public class HODClient {
   
    private String apiKey = '';
    private String version = '';
    private String url = '';
   
    /**
     * Get URL to call the end point
     * 
     * @param hodApp method to call
     * @param version version no 
     * @mode SYNC/ASYNC
     */
    private static String getUrlString(String hodApp,String version,HODClientConstants.REQ_MODE mode)
    {
    	String callMode = mode.name().toLowerCase();
        return HODClientConstants.HOD_URL+HODClientConstants.HOD_API_URL+'/'+callMode+hodApp+'/'+version;
    }
    
    /**
     * Get URL to get job status
     */
    private static String getJobStatusURLString()
    {
        return  HODClientConstants.HOD_URL+'/'+HODClientConstants.JOB_STATUS;
    }
    
    /**
     * Get URL to get job result
     */
    private static String getJobResultURLString()
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
     * @param params params to be passed
     * @param hodApp end point to be called
     * @param mode sync/async
     * @return data deserialized response
     * @throws HODClientException
     */ 
    public Map<String,Object> postRequest(List<Param> params, String hodApp, HODClientConstants.REQ_Mode mode)
    {
        String url = HODClient.GetUrlString(hodApp, this.version, mode);
        return HODClientHTTPClient.invokeHODApi(url, 
                                                HODClientConstants.POST_REQUEST, 
                                                this.apiKey,
                                                params);
    }

    
    
    /**
     * calls GET Request 
     *
     * @param params params to be passed
     * @param hodApp end point to be called
     * @param mode sync/async
     * @return data deserialized response
     * @throws HODClientException
     */ 
    public Map<String,Object> getRequest(List<Param> params, String hodApp, HODClientConstants.REQ_Mode mode)
    {
        String url = HODClient.GetUrlString(hodApp, this.version, mode);
        return HODClientHTTPClient.invokeHODApi(url, 
                                                HODClientConstants.GET_REQUEST, 
                                                this.apiKey,
                                                params);
    }
  	
    
    /**
     * Get status of the job submitted
     * @param jobId id of the job submitted
     * @throws HODClientException
     */
    public Map<String,Object> getJobStatus(String jobId)
    {
      String url = getJobStatusURLString()+ jobId;
      return HODClientHTTPClient.invokeHODApi(url, 
                                              HODClientConstants.POST_REQUEST, 
                                              this.apiKey,
                                              new List<Param>());
    }
    
    /**
     * Get result of the job submitted
     * @param jobId id of the job submitted
     * @throws HODClientException
     */
    public Map<String,Object> getJobResult(String jobId)
    {
      String url = getJobResultURLString()+ jobId;
      return HODClientHTTPClient.invokeHODApi(url, 
                                              HODClientConstants.POST_REQUEST, 
                                              this.apiKey,
                                              new List<Param>());
      
    }
}