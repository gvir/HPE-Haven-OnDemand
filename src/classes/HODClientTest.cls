/**
 * Test HODClient class
 * 
 * @author Topcoder
 * @version 1.0
 */
@isTest
public class HODClientTest {

    /**
     * Get API Key for the tests
     */
    private static String getAPIKeyForTest()
    {
        return '4c21b279-8916-495b-9166-74876394bcdb';
    }
    
    /**
     * Get API version for the tests
     */
    private static String getAPIVersion()
    {
        return 'v2';
    }
    
    /**
     *  ASync success test speech recognition
     */
    @isTest
    private static void testSpeechRecognition() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        Map<String,object> params = new Map<String,Object>(); 
        params.put('url','https://test.com');
        Map<String,Object> data = client.postRequest(params, HODAPP.SPEECH_RECOGNITION, HODClientConstants.REQ_MODE.ASYNC);
        System.assert(data.get(HODClientConstants.JOB_ID) == '1');
        Test.stopTest();
    }
    
    
    /**
     *  ASync success test extraction
     */
    @isTest
    private static void testTextExtraction() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        HODClient client = new HODClient(apiKey, version);
        List<Multipart> params = new List<Multipart>(); 
        params.add(new Multipart('test.pdf',Blob.toPdf('sample value'),'application/pdf'));
        Map<String,Object> data= client.postRequestWithAttachment(params, HODAPP.TEXT_EXTRACTION, HODClientConstants.REQ_MODE.ASYNC);
        System.assert(data.get(HODClientConstants.JOB_ID) == '2');
        Test.stopTest();
    }
    
    /**
     *  ASync success test prediction api
     */
    @isTest
    private static void testPredictAPI() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        HODClient client = new HODClient(apiKey, version);
        List<Multipart> params = new List<Multipart>(); 
        params.add(new Multipart('test.pdf',Blob.toPdf('sample value'),'application/pdf'));
        params.add(new Multipart('service_name','test'));
        Map<String,Object> data = client.postRequestWithAttachment(params, HODAPP.PREDICT, HODClientConstants.REQ_MODE.ASYNC);
        System.assert(data.get(HODClientConstants.JOB_ID) == '3');
        Test.stopTest();
    }
    
    /**
     *  ASync success test recommend api
     */
    @isTest
    private static void testRecommendAPI() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        HODClient client = new HODClient(apiKey, version);
        List<Multipart> params = new List<Multipart>(); 
        params.add(new Multipart('test.pdf',Blob.toPdf('sample value'),'application/pdf'));
        params.add(new Multipart('service_name','test'));
        params.add(new Multipart('required_label','test'));
        Map<String,Object> data= client.postRequestWithAttachment(params, HODAPP.RECOMMEND, HODClientConstants.REQ_MODE.ASYNC);
        System.assert(data.get(HODClientConstants.JOB_ID) == '4');
        Test.stopTest();
    }
    
    /**
     *  ASync success test recommend api
     */
    @isTest
    private static void testTrainPredictionAPI() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        HODClient client = new HODClient(apiKey, version);
        List<Multipart> params = new List<Multipart>(); 
        params.add(new Multipart('test.pdf',Blob.toPdf('sample value'),'application/pdf'));
        params.add(new Multipart('service_name','test'));
        Map<String,Object> data= client.postRequestWithAttachment(params, HODAPP.TRAIN_PREDICTION, HODClientConstants.REQ_MODE.ASYNC);
        System.assert(data.get(HODClientConstants.JOB_ID) == '5');
        Test.stopTest();
    }
    
    /**
     *  Sync success index status
     */
    @isTest
    private static void testIndexStatus() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // create client
        HODClient client = new HODClient(apiKey, version);
        // create map
		Map<String,object> params = new Map<String,Object>(); 
		// add parameters to be passed
        params.put('index','test');
        // get response, it is json response
        Map<String,Object> data = client.postRequest(params, HODAPP.INDEX_STATUS, HODClientConstants.REQ_MODE.SYNC);
        System.assert(data.get('total_documents') == 3);
        Test.stopTest();
    }
    
    
    /**
     *  Sync success list resouces
     */
    @isTest
    private static void testListResources() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // create client
        HODClient client = new HODClient(apiKey, version);
        // set params
		Map<String,object> params = new Map<String,Object>(); 
        params.put('flavor',new List<String>{'standard','explorer'});
        params.put('type',new List<String>{'content','connector'});
        // get response
        Map<String,Object> data = client.postRequest(params, HODAPP.LIST_RESOURCES, HODClientConstants.REQ_MODE.SYNC);
        System.assert(data.containsKey('private_resources'));
        Test.stopTest();
    }
    
    
    
    
    /**
     *  Sync failure index status
     */
    @isTest
    private static void testIndexStatusFailure() {
        testSetup(false);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        HODClient client = new HODClient(apiKey, version);
		Map<String,object> params = new Map<String,Object>(); 
        params.put('index','test');
        try
        {
            Map<String,Object> data= client.postRequest(params, HODAPP.INDEX_STATUS, HODClientConstants.REQ_MODE.SYNC);
        }
        catch(HODClientException ex)
        {
             String response = ex.getMessage();
             System.assert(response.contains('4004'));
        }
        Test.stopTest();
    }
    
    /**
     *  Get job status
     */
    @isTest
    
    private static void testGetJobStatus() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        HODClient client = new HODClient(apiKey, version);
        Map<String,Object> data = client.getJobStatus('1');
        System.assert(data.get(HODClientConstants.JOB_RESPONSE_STATUS) == HODClientConstants.JOB_RESPONSE_FINISHED);
        Test.stopTest();
    }
    
    /**
     *  Get job result speech recognition
     */
    @isTest
    private static void testGetJobResultSpeechRecognition() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        HODClient client = new HODClient(apiKey, version);
        Map<String,Object> data = client.getJobResult('1');
        System.assert(data.get(HODClientConstants.JOB_ID) == '1');
        Test.stopTest();
    }
    
    /**
     *  Get job result text extraction
     */
    @isTest
    private static void testGetJobResultTextExtraction() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        HODClient client = new HODClient(apiKey, version);
        Map<String,Object> data = client.getJobResult('2');
        System.assert(data.containsKey('document'));
        Test.stopTest();
    }
    
    /**
     *  Get job result predict api
     */
    @isTest
    private static void testGetJobResultPredict() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        HODClient client = new HODClient(apiKey, version);
        Map<String,Object> data = client.getJobResult('3');
        System.assert(data.containsKey('file'));
        System.assert(data.get('status') == 200);
        Test.stopTest();
    }
    
    /**
     *  Get job result recommend api
     */
    @isTest
    private static void testGetJobResultRecommend() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        HODClient client = new HODClient(apiKey, version);
        Map<String,Object> data= client.getJobResult('4');
        System.assert(data.containsKey('allRecommendations'));
        Test.stopTest();
    }
    
    /**
     *  Get job result train prediction api
     */
    @isTest
    private static void testGetJobResultTrainPrediction() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        Test.startTest();
        HODClient client = new HODClient(apiKey);
        Map<String,Object> data= client.getJobResult('5');
        System.assert(data.get('service') == 'my-service');
        System.assert(data.get('status') == 'Ready');
        Test.stopTest();
    }
    
  
    
    // sets the mock service
    // if false : then error mock service is binded
    // if true : then success mock service is binded
    private static void testSetup(Boolean successful) { 
        // set mock callout class implementing the HttpCalloutMock Interface
        if (successful) {
            // set successful response mock
            Test.setMock(HttpCalloutMock.class, new HODClientTestHelper.MockIDOLSuccessResponseGenerator());
        } else {
            // set failure response mock
            Test.setMock(HttpCalloutMock.class, new HODClientTestHelper.MockIDOLFailureResponseGenerator());
        }
    }
}