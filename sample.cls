@RestResource(urlMapping='/SubmitUser')
global with sharing class sample {
	@HttpPost
    global static void execute() {
        wrapperReq wrpreq=wrapperReq.parse(RestContext.request.requestBody.toString());
        System.debug(wrpreq);
        wrapperRes wrpres=new wrapperRes();
        
        if(checkValidEmail(wrpreq.email)){
            wrpres=postaddition(wrpreq,wrpres);
        }
        else{
            wrapperRes.errors newerror=new wrapperRes.errors();
            newerror.errorCode='I-E';
            newerror.errorMsg='Invalid Email';
            wrpres.error.add(newerror);
        }
        
        RestResponse res=RestContext.response;
        res.addHeader('Content-Type','application/json');
        res.responseBody=blob.valueOf(JSON.serialize(wrpres));
        res.statusCode=200;
    }
    
    public static boolean checkValidEmail(String email){
        String emailRegex='^[a-zA-Z0-9._|\\\\%#~`=?&/$^*!}{+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,4}$';
        Pattern mypattern=Pattern.compile(emailRegex);
        Matcher myMatcher=myPattern.matcher(email);
        return (myMatcher.matches()) ? true:false;
    }
    
    public static wrapperres postaddition(wrapperReq wrpreq,wrapperRes wrpres){
        try{
            Contact test=new Contact();
            test.FirstName=wrpreq.name;
            test.LastName=wrpreq.name;
            test.Email=wrpreq.email;
            test.Phone=wrpreq.contact;
            insert test;
            
            wrpres.status='Success';
            wrpres.statusCode='200';
            wrpres.sfid=test.id;
        }
        catch(exception ex){
            wrapperRes.errors newerror=new wrapperRes.errors();
            newerror.errorCode='I-F';
            newerror.errorMsg='Insert Failed'+ex;
            wrpres.error.add(newerror);
        }
        
        return wrpres;
    }
}