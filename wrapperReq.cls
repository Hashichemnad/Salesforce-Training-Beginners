public with sharing class wrapperReq {
	public string name;
    public string email;
    public string contact;
    public wrapperReq(){
        name='';
        email='';
        contact='';
    }
    
    
    public static wrapperReq parse(String json){
        return (wrapperReq) System.JSON.deserialize(json,wrapperReq.class);
    }
}