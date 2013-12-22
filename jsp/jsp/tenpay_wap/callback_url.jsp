<?xml version="1.0" encoding="utf-8"?>
 <!DOCTYPE wml PUBLIC "-//WAPFORUM//DTD WML 1.1//EN"
 "http://www.wapforum.org/DTD/wml_1.1.xml">
<%@ page language="java" contentType="text/vnd.wap.wml;charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.tenpay.util.TenpayUtil" %>
<%@ page import="com.tenpay.wap.WapPayPageResponseHandler"%>       

   <wml>
     <head>
       <meta http-equiv="Cache-Control" content="max-age=0" forua="true"/>
       <meta http-equiv="Cache-control" content="must-revalidate" />
       <meta http-equiv="Cache-control" content="private" />
       <meta http-equiv="Cache-control" content="no-cache" />
     </head>
     <card id="wappay" title="财付通wap手机支付示例——前台结果">
     <p>
<%
//---------------------------------------------------------
//财付通wap支付前台回调处理示例，商户按照此文档进行开发即可
//---------------------------------------------------------

//密钥
String key = "8934e7d15453e97507ef794cf7b0519d";

//创建实例
WapPayPageResponseHandler resHandler = 
	new WapPayPageResponseHandler(request, response);

resHandler.setKey(key);

//uri编码，tomcat需要
resHandler.setUriEncoding("ISO-8859-1");

//判断签名
if(resHandler.isTenpaySign()) {
	//支付结果
	String pay_result = resHandler.getParameter("pay_result");
	String sp_billno = resHandler.getParameter("sp_billno");
	
	if(pay_result.equals("0")) {
		
		//------------------------------
		//显示成功
		//------------------------------
		
		out.println("支付成功,sp_billno=" + sp_billno);
		
	}else {
		
		out.println("支付失败,pay_result=" + pay_result);
	}

	
} else {
	out.println("验证签名失败");
	
}
String debugInfo = resHandler.getDebugInfo();
System.out.println("debugInfo:" + debugInfo);
%>

</p>
</card>
</wml>