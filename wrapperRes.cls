public with sharing class wrapperRes {
	public string statusCode;
    public string status;
    public string sfid;
    public List<errors> error=new List<errors>();
    public wrapperRes(){
        statusCode='';
        status='';
        sfid='';
    }
    
    public class errors {
        public string errorCode;
    	public string errorMsg; 
        
        public errors() {
            errorCode='';
            errorMsg='';
        }
	}
}