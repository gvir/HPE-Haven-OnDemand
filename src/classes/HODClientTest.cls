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
        return '4c21b279-8916-878787-909- 166-dsddsd';
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
        HODClient client = new HODClient(apiKey, version);
        Map<String,object> params = new Map<String,Object>(); 
        params.put('url','https://test.com');
        String response= client.postRequest(params, HODAPP.SPEECH_RECOGNITION, HODClientConstants.REQ_MODE.ASYNC);
        Map<String,Object> data = (Map<String,Object>)JSON.deserializeUntyped(response);
        System.assert(data.get('jobID') == '1');
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
        String response= client.postRequestWithAttachment(params, HODAPP.TEXT_EXTRACTION, HODClientConstants.REQ_MODE.ASYNC);
        Map<String,Object> data = (Map<String,Object>)JSON.deserializeUntyped(response);
        System.assert(data.get('jobID') == '2');
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
        String response= client.postRequestWithAttachment(params, HODAPP.PREDICT, HODClientConstants.REQ_MODE.ASYNC);
        Map<String,Object> data = (Map<String,Object>)JSON.deserializeUntyped(response);
        System.assert(data.get('jobID') == '3');
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
        String response= client.postRequestWithAttachment(params, HODAPP.RECOMMEND, HODClientConstants.REQ_MODE.ASYNC);
        Map<String,Object> data = (Map<String,Object>)JSON.deserializeUntyped(response);
        System.assert(data.get('jobID') == '4');
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
        String response= client.postRequestWithAttachment(params, HODAPP.TRAIN_PREDICTION, HODClientConstants.REQ_MODE.ASYNC);
        Map<String,Object> data = (Map<String,Object>)JSON.deserializeUntyped(response);
        System.assert(data.get('jobID') == '5');
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
        HODClient client = new HODClient(apiKey, version);
		Map<String,object> params = new Map<String,Object>(); 
        params.put('index','test');
        String response= client.postRequest(params, HODAPP.INDEX_STATUS, HODClientConstants.REQ_MODE.SYNC);
        Map<String,Object> data = (Map<String,Object>)JSON.deserializeUntyped(response);
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
        HODClient client = new HODClient(apiKey, version);
		Map<String,object> params = new Map<String,Object>(); 
        params.put('flavor',new List<String>{'standard','explorer'});
        params.put('type',new List<String>{'content','connector'});
        String response= client.postRequest(params, HODAPP.LIST_RESOURCES, HODClientConstants.REQ_MODE.SYNC);
        Map<String,Object> data = (Map<String,Object>)JSON.deserializeUntyped(response);
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
            String response= client.postRequest(params, HODAPP.INDEX_STATUS, HODClientConstants.REQ_MODE.SYNC);
        }
        catch(HODClientException ex)
        {
             String response = ex.getMessage();
             Map<String,Object> data = (Map<String,Object>)JSON.deserializeUntyped(response);
             System.assert(data.get('error') == 4004);
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
        String response= client.getJobStatus('1');
        Map<String,Object> data = (Map<String,Object>)JSON.deserializeUntyped(response);
        System.assert(data.get('status') == 'finished');
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
        String response= client.getJobResult('1');
        Map<String,Object> data = (Map<String,Object>)JSON.deserializeUntyped(response);
        System.assert(data.get('jobID') == '1');
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
        String response= client.getJobResult('2');
        Map<String,Object> data = (Map<String,Object>)JSON.deserializeUntyped(response);
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
        String response= client.getJobResult('3');
        Map<String,Object> data = (Map<String,Object>)JSON.deserializeUntyped(response);
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
        String response= client.getJobResult('4');
        Map<String,Object> data = (Map<String,Object>)JSON.deserializeUntyped(response);
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
        String response= client.getJobResult('5');
        Map<String,Object> data = (Map<String,Object>)JSON.deserializeUntyped(response);
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