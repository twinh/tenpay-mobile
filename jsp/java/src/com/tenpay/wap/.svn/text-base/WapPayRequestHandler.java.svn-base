package com.tenpay.wap;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.tenpay.RequestHandler;
import com.tenpay.util.TenpayUtil;

/**
 * wap手机支付请求类
 * ============================================================================
 * api说明：
 * init(),初始化函数，默认给一些参数赋值，如cmdno,date等。
 * getGateURL()/setGateURL(),获取/设置入口地址,不包含参数值
 * getKey()/setKey(),获取/设置密钥
 * getParameter()/setParameter(),获取/设置参数值
 * getAllParameters(),获取所有参数
 * getRequestURL(),获取带参数的请求URL
 * doSend(),重定向到财付通支付
 * getDebugInfo(),获取debug信息
 * 
 * ============================================================================
 *
 */
public class WapPayRequestHandler extends RequestHandler  {

	public WapPayRequestHandler(HttpServletRequest request,
			HttpServletResponse response) {
		super(request, response);
		
		this.setGateUrl("https://wap.tenpay.com/cgi-bin/wappayv2.0/wappay_gate.cgi");
	}
	
public String getRequestURL() throws UnsupportedEncodingException {
		
		StringBuffer sb = new StringBuffer();
		String enc = TenpayUtil.getCharacterEncoding(this.getHttpServletRequest(), this.getHttpServletResponse());
		Set es = this.getAllParameters().entrySet();
		Iterator it = es.iterator();
		while(it.hasNext()) {
			Map.Entry entry = (Map.Entry)it.next();
			String k = (String)entry.getKey();
			String v = (String)entry.getValue();
			sb.append(k + "=" + URLEncoder.encode(v, enc) + "&");
		}
		
		//去掉最后一个&
		String reqPars = sb.substring(0, sb.lastIndexOf("&"));
		
		return this.getGateUrl() + "?" + reqPars;
		
	}


	
	

}
