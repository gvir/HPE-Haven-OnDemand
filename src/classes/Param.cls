/**
 * Class for holding input params
 * Copied from https://github.com/HPE-Haven-OnDemand/iod-force.com/blob/master/src/classes/HttpClient.cls
 * Old salesforce library
 * 
 * @version 1.0
 * @author Topcoder
 */
public class Param {
 		private String name;
        private Object contents;
        private String contentType;
        private Blob blobContents;
		/**
		 * Constructor
		 * 
		 * @param name key
		 * @param contents value
		 */
        public Param(String name, Object contents) {
            this.name = name;
            this.contents = contents;
        }
		
    	/**
		 * Constructor
		 * 
		 * @param name file name
		 * @param blobContents blob value of file
		 * @param contentType type of the content
		 */
        public Param(String name, Blob blobContents, String contentType) {
            this.name = name;
            this.blobContents = blobContents;
            this.contentType = contentType;
        }
		
    	// get name
        public String getName() {
            return this.name;
        }
		
    	// get contents
        public Object getContents() {
            return this.contents;
        }

        public Blob getBlobContents() {
            return this.blobContents;
        }
		
    	// get blob contents
        public String getContentType() {
            return this.contentType;
        }
		
    	// check is multipart file type or not
        public Boolean isFile() {
            return this.blobContents != null;
        }
}