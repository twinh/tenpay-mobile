<%@ page language="java" contentType="text/html;charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.tenpay.util.TenpayUtil" %>
<%@ page import="com.tenpay.ResponseHandler"%>    
<%
//---------------------------------------------------------
//财付通wap支付后台回调处理示例，商户按照此文档进行开发即可
//---------------------------------------------------------

//密钥
String key = "8934e7d15453e97507ef794cf7b0519d";


//创建实例
ResponseHandler resHandler = 
	new ResponseHandler(request, response);

resHandler.setKey(key);

//uri编码,tomcat需要
resHandler.setUriEncoding("ISO-8859-1");

//判断签名
if(resHandler.isTenpaySign()) {
	//支付结果
	String pay_result = resHandler.getParameter("pay_result");
	String sp_billno = resHandler.getParameter("sp_billno");
	
	if(pay_result.equals("0")) {
		//------------------------------
		//处理业务开始
		//------------------------------ 
			
			
		//------------------------------
		//处理业务完毕
		//------------------------------
		out.println("success");
		System.out.println("后台通知，支付成功,sp_billno=" + sp_billno);
		
	}else {
		out.println("fail");
		System.out.println("后台通知，支付失败,pay_result=" + pay_result);
	}

	
} else {
	out.println("fail");
	System.out.println("后台通知，验证签名失败");
	
}
String debugInfo = resHandler.getDebugInfo();
System.out.println("debugInfo:" + debugInfo);
%>