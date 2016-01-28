# HPE Haven OnDemand Salesforce Client Library

----
## Overview
This library can be used to consume [HPE Haven OnDemand - https://dev.havenondemand.com/apis](https://dev.havenondemand.com/apis)in Salesforce. 

----
## What is HAVEN ONDEMAND?
Haven OnDemand is a set of over 70 APIs for handling all sorts of unstructured data. Here are just some of our APIs' capabilities:

- Speech to text
- OCR
- Text extraction
- Indexing documents
- Smart search
- Language identification
- Concept extraction
- Sentiment analysis
- Web crawlers
- Machine learning

For a full list of all the APIs and to try them out, check out [https://www.havenondemand.com/developer/apis](https://dev.havenondemand.com/apis).

----
## Installation

### Using Unmanaged package

- Login in the Salesforce account and install [package](https://login.salesforce.com/packaging/installPackage.apexp?p0=04t280000006Wj6).

### Using ANT

- Make sure ant is installed on the machine. Please check out this [link] (http://ant.apache.org/manual/install.html) to install the ant.
- Set username and password in build.properties. If your password is YYYY and security token in XXXX then password will be YYYYXXXX
- Open a cmd and enter follwing commands
```
ant -version
cd <HPE_Haven_OnDemand folder>
ant deployCode
```
----
## Usage

### Initialization

``` Apex

// with apikey and version
HODClient client = new HODClient(apiKey, version);

// with apikey (version will default to v2)
HODClient client = new HODClient(apiKey);


```
### Sample post sync call (INDEX_STATUS)

``` Apex
// create client
HODClient client = new HODClient(apiKey, version);
// create map
Map<String,object> params = new Map<String,Object>(); 
// add parameters to be passed
params.put('index','test');
// get resposne, it is json response
String response= client.postRequest(params, HODAPP.INDEX_STATUS, HODClientConstants.REQ_MODE.SYNC);
// deserialize the response
Map<String,Object> data = (Map<String,Object>)JSON.deserializeUntyped(response);
```

### Sample post async call (list resources)

``` Apex
// create client get job id
HODClient client = new HODClient(apiKey, version);
// set params
Map<String,object> params = new Map<String,Object>(); 
params.put('flavor',new List<String>{'standard','explorer'});
params.put('type',new List<String>{'content','connector'});
// get response
String response= client.postRequest(params, HODApp.LIST_RESOURCES, HODClientConstants.REQ_MODE.ASYNC);
// deserialize response
Map<String,Object> data = (Map<String,Object>)JSON.deserializeUntyped(response);
String jobId = data.get('jobID');


// check job status
// if it is finished then getJobResult method can be used to get jobResult
HODClient client = new HODClient(apiKey, version);
String response= client.getJobStatus(jobID);
Map<String,Object> data = (Map<String,Object>)JSON.deserializeUntyped(response);
System.assert(data.get('status') == 'finished');

// get job data
HODClient client = new HODClient(apiKey, version);
String response= client.getJobResult(jobID);
Map<String,Object> data = (Map<String,Object>)JSON.deserializeUntyped(response);

```

### Sample post async call with file attachment (PREDICT API)

``` Apex
HODClient client = new HODClient(apiKey, version);
// list of multipart has to be passed for request with file attachment
List<Multipart> params = new List<Multipart>(); 
// add multipart for file type
params.add(new Multipart('test.pdf',Blob.toPdf('sample value'),'application/pdf'));
// add multipart for other param
params.add(new Multipart('service_name','test'));
// call API
String response= client.postRequestWithAttachment(params, HODAPP.PREDICT, HODClientConstants.REQ_MODE.ASYNC);
Map<String,Object> data = (Map<String,Object>)JSON.deserializeUntyped(response);
String jobId = data.get('jobID');

```

### Error Handling

- All the calls throw HODClientException  if there is an error
``` Apex
HODClient client = new HODClient(apiKey, version);
List<Multipart> params = new List<Multipart>(); 
params.add(new Multipart('test.pdf',Blob.toPdf('sample value'),'application/pdf'));
params.add(new Multipart('service_name','test'));
try
{
      String response= client.postRequestWithAttachment(params, HODAPP.PREDICT, HODClientConstants.REQ_MODE.ASYNC);
        
}
catch (HODClientException ex)
{
     String message = ex.getMessage();
     Map<String,Object> error = (Map<String,Object>)JSON.deserializeUntyped(message);
     System.debug(error.error);
     System.debug(error.reason);
}

```
### Parsing Response

- All the class/error return JSON string which can easily be parsed in APEX, below example show parsing CREATE_TEXT_INDEX call respone string (res).

``` Apex

// parsing response in a class
    public class CreateTextIndexResponse {
        public String message;  // optional
        public String index;    // optional
    }
       
       CreateTextIndexResponse deserializedRes= JSON.deserialize(res, CreateTextIndexResponse.class);

 // parsing response in untyped manner
  Map<String,Object> data = (Map<String,Object>)JSON.deserializeUntyped(res);
```

### HODClient Instance Methods

``` Apex

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


```

``` Apex

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


```

``` Apex

    /**
     * Get status of the job submitted
     * @param jobId id of the job submitted
     * @throws HODClientException
     */
    public String getJobStatus(String jobId)
```

``` Apex
   /**
     * Get result of the job submitted
     * @param jobId id of the job submitted
     * @throws HODClientException
     */
    public String getJobResult(String jobId)
```
