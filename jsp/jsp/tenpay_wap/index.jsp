<?xml version="1.0" encoding="utf-8"?>
 <!DOCTYPE wml PUBLIC "-//WAPFORUM//DTD WML 1.1//EN"
 "http://www.wapforum.org/DTD/wml_1.1.xml">
<%@ page language="java" contentType="text/vnd.wap.wml;charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.tenpay.util.TenpayUtil" %>
<%@page import="com.tenpay.wap.*"%>
<%@page import="com.tenpay.client.*"%>

   <wml>
     <head>
       <meta http-equiv="Cache-Control" content="max-age=0" forua="true"/>
       <meta http-equiv="Cache-control" content="must-revalidate" />
       <meta http-equiv="Cache-control" content="private" />
       <meta http-equiv="Cache-control" content="no-cache" />
     </head>
     <card id="wappay" title="财付通wap手机支付示例">
     <p>
<%
//帐号(财付通商户号或者财付通帐号)
String bargainor_id = "1900000109";

//密钥
String key = "8934e7d15453e97507ef794cf7b0519d";





//创建支付初始化请求示例
WapPayInitRequestHandler reqHandler = new WapPayInitRequestHandler(request, response);

//初始化
reqHandler.init();
//设置密钥
reqHandler.setKey(key);

//-----------------------------
//设置请求参数
//-----------------------------
//当前时间 yyyyMMddHHmmss
String currTime = TenpayUtil.getCurrTime();
//订单号，必须保持唯一。此处 用 时间+4个随机数 模拟 ，商户可自行替换
String strReq = currTime + TenpayUtil.buildRandom(4);
reqHandler.setParameter("sp_billno", strReq);		
reqHandler.setParameter("desc", "wap测试");		
reqHandler.setParameter("bargainor_id", bargainor_id);					
reqHandler.setParameter("total_fee", "1");
reqHandler.setParameter("notify_url", "http://10.6.30.38:8080/tenpay_wap/notify_url.jsp");
reqHandler.setParameter("callback_url", "http://10.6.30.38:8080/tenpay_wap/callback_url.jsp");
//获取请求带参数的url
String requestUrl = reqHandler.getRequestURL();

//获取debug信息
String debuginfo = reqHandler.getDebugInfo();
System.out.println("debuginfo:" + debuginfo);
System.out.println("requestUrl:" + requestUrl);

//创建TenpayHttpClient，后台通信
TenpayHttpClient httpClient = new TenpayHttpClient();

//设置请求内容
httpClient.setReqContent(requestUrl);
//远程调用
if(httpClient.call()) {
	String resContent = httpClient.getResContent();
	System.out.println("responseContent:" + resContent);
	
	//----------------------
	//应答处理,获取token_id
	//----------------------
	XMLClientResponseHandler resHandler = new XMLClientResponseHandler();
	resHandler.setContent(resContent);
	String token_id = resHandler.getParameter("token_id");
	if(!token_id.equals("")) {
		//生成支付请求
		WapPayRequestHandler wapPayRequestHandler = new WapPayRequestHandler(request, response);
		wapPayRequestHandler.init();
		wapPayRequestHandler.setParameter("token_id", token_id);
		String wapPayRequestUrl = wapPayRequestHandler.getRequestURL();
		
		out.println("<br /><a href=\"" + wapPayRequestUrl + "\">财付通wap支付</a><br />");
	} else {
		//获取token_id调用失败 ，显示错误 页面
		out.println("获取token_id调用失败:" + resHandler.getParameter("err_info"));
	}
} else {
	System.out.println("后台调用失败:" + httpClient.getResponseCode() + httpClient.getErrInfo());
	//后台调用失败 ，显示错误 页面
	out.println("后台调用失败!");

}


%>

</p>
</card>
</wml>