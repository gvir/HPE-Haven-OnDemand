/**
 * Class for holding multipart objects
 * Copied from https://github.com/HPE-Haven-OnDemand/iod-force.com/blob/master/src/classes/HttpClient.cls
 * Old salesforce library
 * 
 * @version 1.0
 * @author Topcoder
 */
public class Multipart {
 		private String name;
        private String contents;
        private String contentType;
        private Blob blobContents;
		/**
		 * Constructor
		 * 
		 * @param name key
		 * @param contents value
		 */
        public Multipart(String name, String contents) {
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
        public Multipart(String name, Blob blobContents, String contentType) {
            this.name = name;
            this.blobContents = blobContents;
            this.contentType = contentType;
        }
		
    	// get name
        public String getName() {
            return this.name;
        }
		
    	// get contents
        public String getContents() {
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