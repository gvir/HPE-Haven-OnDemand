/**
 * Demo API calls to some end points
 * 
 * @version 1.0
 * @author Topcoder
 */
public class HelloWorldController{
    public static String apiKey = '4c21b279-8916-495b-9166-74876394bcdb';
    public static String version = 'v1';
	
    /*
     * Call speech recognition end point in async mode
     * 
     * @param data base64 encoded string
     * @param contentType type of content
     * @param fileName file name
     * @return response
     */
	@RemoteAction    
    public static String callSpeechRecognition(String data, String contentType, String fileName)
    {
        HODClient hodClient = new HODClient(apiKey,version);
        List<Multipart> parts = new List<Multipart>();
        Blob dataValue = EncodingUtil.base64Decode(data);
        parts.add(new Multipart(fileName,dataValue, contentType));
        return JSON.serialize(hodClient.postRequestWithAttachment(parts, HODApp.SPEECH_RECOGNITION,HODClientConstants.REQ_Mode.ASYNC));
    }
    
     /*
     * Call text extraction end point in async mode
     * 
     * @param data base64 encoded string
     * @param contentType type of content
     * @param fileName file name
     * @return response
     */
	@RemoteAction    
    public static String callTextExtraction(String data, String contentType, String fileName)
    {
        HODClient hodClient = new HODClient(apiKey,version);
        List<Multipart> parts = new List<Multipart>();
        Blob dataValue = EncodingUtil.base64Decode(data);
        parts.add(new Multipart(fileName,dataValue, contentType));
        return JSON.serialize(hodClient.postRequestWithAttachment(parts, HODApp.TEXT_EXTRACTION,HODClientConstants.REQ_Mode.ASYNC));
    }
    
    
    /**
     * Get status of the job
     * 
     * @param jobId job id of the request
     * @return string
	 */
    @RemoteAction
    public static String getJobStatus(String jobId)
    {
        HODClient hodClient = new HODClient(apiKey,version);
        return JSON.serialize(hodClient.getJobStatus(jobId));
        
    }
    /**
     * Get result of the job
     * 
     * @param jobId job id of the request
     * @return string
	 */
    @RemoteAction
    public static String getJobResult(String jobId)
    {
        HODClient hodClient = new HODClient(apiKey,version);
        return JSON.serialize(hodClient.getJobResult(jobId));
        
    }
}