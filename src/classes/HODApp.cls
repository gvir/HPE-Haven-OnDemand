/**
 * Contains all the end points of HPE Haven OnDemand API
 *
 * @version 1.0
 * @author Topcoder
 */
public class HODApp {
    
    // connectors APIS
    public static final String CANCEL_CONNECTOR_SCHEDULE = '/cancelconnectorschedule';
    public static final String CONNECTOR_HISTORY = '/connectorhistory';
    public static final String CONNECTOR_STATUS = '/connectorstatus';
    public static final String CREATE_CONNECTOR = '/createconnector';
    public static final String DELETE_CONNECTOR = '/deleteconnector';
    public static final String START_CONNECTOR = '/startconnector';
    public static final String STOP_CONNECTOR = '/stopconnector';
    public static final String UPDATE_CONNECTOR = '/extracttext';
    public static final String RETRIEVE_CONFIG = '/updateconnector';

    // Format Conversion APIs
    public static final String EXPAND_CONTAINER = '/expandcontainer';
    public static final String OCR_DOCUMENT = '/ocrdocument';
    public static final String STORE_OBJECT = '/storeobject';
    public static final String TEXT_EXTRACTION = '/extracttext';
    public static final String VIEW_DOCUMENT = '/viewdocument';
    
  
    // Graph Analysis APIs
    public static final String GET_COMMON_NEIGHBORS = '/getcommonneighbors';
    public static final String GET_NEIGHBORS = '/getneighbors';
    public static final String GET_NODES = '/getnodes';
    public static final String GET_SHORTEST_PATH = '/getshortestpath';
    public static final String GET_SUBGRAPH = '/getsubgraph';
	public static final String SUGGEST_LINKS = '/suggestlinks';
    public static final String SUMMARIZE_GRAPH = '/summarizegraph';
    
    // image analysis APIs
    public static final String BARCODE_RECOGNITION = '/recognizebarcodes';
    public static final String FACE_DETECTION = '/detectfaces';
    public static final String IMAGE_RECOGNITION = '/recognizeimages';
	// ocr document already defined in format conversion
	
    
    // policy APIs
    public static final String CREATE_CLASSIFICATION = '/createclassificationobjects';
    public static final String CREATE_POLICY = '/createpolicyobjects';
    public static final String DELETE_CLASSIFICATION = '/deleteclassificationobjects';
    public static final String DELETE_POLICY = '/deletepolicyobjects';
    public static final String RETRIEVE_CLASSIFICATION = '/retrieveclassificationobjects';
	public static final String RETRIEVE_POLICY = '/retrievepolicyobjects';
    public static final String UPDATE_CLASSIFICATION = '/updateclassificationobjects';
    public static final String UPDATE_POLICY = '/updatepolicyobjects';
    
    // Prediction APIs
    public static final String PREDICT = '/predict';
    public static final String RECOMMEND = '/recommend';
    public static final String TRAIN_PREDICTION = '/trainpredictor';
    
    // Query profile and manipulation APIs
    public static final String CREATE_QUERY_PROFILE = '/createqueryprofile';
    public static final String DELETE_QUERY_PROFILE = '/deletequeryprofile';
    public static final String RETRIEVE_QUERY_PROFILE = '/retrievequeryprofile';
    public static final String UPDATE_QUERY_PROFILE = '/updatequeryprofile';
    
    // Search APIs
    public static final String FIND_RELATED_CONCEPTS = '/findrelatedconcepts';
    public static final String FIND_SIMILAR = '/findsimilar';
    public static final String GET_CONTENT = '/getcontent';
    public static final String GET_PARAMETRIC_VALUES = '/getparametricvalues';
    public static final String QUERY_TEXT_INDEX = '/querytextindex';
    public static final String RETRIEVE_INDEX_FIELDS = '/retrieveindexfields';
   
    // text analysis APIs
    public static final String AUTO_COMPLETE = '/autocomplete';
    public static final String CLASSIFY_DOCUMENT = '/classifydocument';
    public static final String CONCEPT_EXTRACTION = '/extractconcepts';
    public static final String DOCUMENT_CATEGORIZATION = '/categorizedocument';
    public static final String ENTITY_EXTRACTION = '/extractentities';
    public static final String EXPAND_TERMS = '/expandterms';
    public static final String HIGHLIGHT_TEXT = '/highlighttext';
    public static final String LANGUAGE_IDENTIFICATION = '/identifylanguage';
    public static final String SENTIMENT_ANALYSIS = '/analyzesentiment';
    public static final String TEXT_TOKENIZATION = '/tokenizetext';
    
    // unstructured text indexing
    public static final String ADD_TO_TEXT_INDEX = '/addtotextindex';
    public static final String CREATE_TEXT_INDEX = '/createtextindex';
    public static final String DELETE_TEXT_INDEX = '/deletetextindex';
    public static final String DELETE_FROMP_TEXT_INDEX = '/deletefromtextindex';
    public static final String INDEX_STATUS = '/indexstatus';
    public static final String LIST_RESOURCES = '/listresources';
    public static final String RESTORE_TEXT_INDEX = '/restoretextindex';
    
    // audio video analytics API
    public static final String SPEECH_RECOGNITION = '/recognizespeech';

 }