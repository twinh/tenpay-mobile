using System;
using System.Collections;
using System.Text;
using System.Web;

namespace tenpay
{
	/// <summary>
	/// WapPayPageResponseHandler 的摘要说明。
	/// </summary>
	/**
	* wap支付页面应答类
	* ============================================================================
	* api说明：
	* getKey()/setKey(),获取/设置密钥
	* getParameter()/setParameter(),获取/设置参数值
	* getAllParameters(),获取所有参数
	* isTenpaySign(),是否财付通签名,true:是 false:否
	* doShow(),显示处理结果
	* getDebugInfo(),获取debug信息
	* 
	* ============================================================================
	*
	*/
	public class WapPayPageResponseHandler:ResponseHandler
	{
		public WapPayPageResponseHandler(HttpContext httpContext) : base(httpContext)
		{
			//
			// TODO: 在此处添加构造函数逻辑
			//
		}

		public override Boolean isTenpaySign() 
		{
			ArrayList akeys=new ArrayList(); 
			akeys.Add("attach");
			akeys.Add("bargainor_id");
			akeys.Add("charset");
			akeys.Add("fee_type"); 
			akeys.Add("pay_result"); 
			akeys.Add("sp_billno");
			akeys.Add("time_end");
			akeys.Add("total_fee");
			akeys.Add("transaction_id");
			akeys.Add("ver");

			akeys.Sort();

			return base._isTenpaySign(akeys);

		} 

	}
}
