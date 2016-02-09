/* @class Constants Contains constants used in the Library
 *
 * @version 1.0
 * @author Topcoder
 */
global class HODClientConstants {
    // url
    public static String HOD_URL = 'https://api.havenondemand.com';
    public static String HOD_API_URL = '/1/api';
    
    // call types
    public static String GET_REQUEST = 'GET';
    public static String POST_REQUEST = 'POST';
    
    // field or other type names
    public static String API_KEY  = 'apikey';
    
    // salesforce types
    public static String SALESFORCE_TYPES_BOOLEAN_TYPE = 'Boolean';
    public static String SALESFORCE_TYPES_ID_TYPE = 'Id';
    public static String SALESFORCE_TYPES_STRING_TYPE = 'String';
    public static String SALESFORCE_TYPES_BLOB_TYPE = 'Blob';
    public static String SALESFORCE_TYPES_DATE_TYPE = 'Date';
    public static String SALESFORCE_TYPES_DATETIME_TYPE = 'Datetime';
    public static String SALESFORCE_TYPES_TIME_TYPE = 'Time';
    public static String SALESFORCE_TYPES_INTEGER_TYPE = 'Integer';
    public static String SALESFORCE_TYPES_LONG_TYPE = 'Long';
    public static String SALESFORCE_TYPES_DECIMAL_TYPE = 'Decimal';
    public static String SALESFORCE_TYPES_DOUBLE_TYPE = 'Double';
    public static String SALESFORCE_TYPES_LIST_TYPE = 'List';
    
    // Request mode enum
    public enum REQ_MODE{ASYNC , SYNC}
  
    // version
    public static String DEFAULT_VERSION = 'v1';
    public static String VERSION_2 = 'v2';
    
    // messages
    public static String ERROR_INPUT_PARAMS = 'Input params can be string or List<String>';


    // file key
    public static String FILE_KEY = 'file';
    
    // multi part boundary
    public static String BOUNDARY_MULTIPART = 'dshdjshjdhjshd9989rwhfLBSlAAJ9BKQU';
        
    // status code
    public static Integer STATUS_200_OK = 200;
    

    // time out in ms
    public static Integer TIME_OUT = 120000;
    
    // job status string
    public static String JOB_STATUS = '1/job/status/';
    public static String JOB_RESULT = '1/job/result/';
    
    // error object keys
    public static String ERROR_NO = 'error';
    public static String ERROR_REASON = 'reason';
    
    // API response field  constants
    public static String JOB_ID = 'jobID'; 
    public static String JOB_RESPONSE_FINISHED = 'finished';
    public static String JOB_RESPONSE_STATUS = 'status';
}