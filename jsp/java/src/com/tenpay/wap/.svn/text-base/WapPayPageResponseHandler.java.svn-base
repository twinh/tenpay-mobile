package com.tenpay.wap;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.tenpay.ResponseHandler;

/**
 * wap支付前台应答类
 * ============================================================================
 * api说明：
 * getKey()/setKey(),获取/设置密钥
 * getParameter()/setParameter(),获取/设置参数值
 * getAllParameters(),获取所有参数
 * isTenpaySign(),是否财付通签名,true:是 false:否
 * getDebugInfo(),获取debug信息
 * 
 * ============================================================================
 *
 */
public class WapPayPageResponseHandler extends ResponseHandler {

	public WapPayPageResponseHandler(HttpServletRequest request,
			HttpServletResponse response) {
		super(request, response);
	}
	


	/**
	 * 签名规则,按字母a-z排序,遇到空值不参加签名
	 * @return boolean
	 */
	public boolean isTenpaySign() {
		String[] signParameterArray = {
				"ver",
				"charset",
				"pay_result",
				"transaction_id",
				"sp_billno",
				"total_fee",
				"fee_type",
				"bargainor_id",
				"attach",
				"time_end"
		};
					
			
		
		//按a-z升序排序
		java.util.Arrays.sort(signParameterArray);
		
		return this.isTenpaySign(signParameterArray);
		
	}
	
}
