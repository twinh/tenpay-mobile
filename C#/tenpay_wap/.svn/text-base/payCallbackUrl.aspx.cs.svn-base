using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using tenpay;

public partial class payCallbackUrl : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //密钥
        string key = "8934e7d15453e97507ef794cf7b0519d";


        //创建ResponseHandler实例
        WapPayPageResponseHandler resHandler = new WapPayPageResponseHandler(Context);
        resHandler.setKey(key);

        //判断签名
        if (resHandler.isTenpaySign())
        {

            //支付结果
            string pay_result = resHandler.getParameter("pay_result");
            //商户订单号
            string sp_billno = resHandler.getParameter("sp_billno");
            //财付通订单号
            string transaction_id = resHandler.getParameter("transaction_id");
            //金额,以分为单位
            string total_fee = resHandler.getParameter("total_fee");

            if ("0".Equals(pay_result))
            {
                //------------------------------
                //处理业务开始
                //------------------------------

                //注意交易单不要重复处理
                //注意判断返回金额

                //------------------------------
                //处理业务完毕
                //------------------------------	
                Response.Write("支付成功,sp_billno=" + sp_billno);
            }
            else
            {
                //当做不成功处理
                Response.Write("支付失败");
            }

        }
        else
        {
            Response.Write("认证签名失败");

        }

        //获取debug信息,建议把debug信息写入日志，方便定位问题
        //string debuginfo = resHandler.getDebugInfo();
        //Response.Write("<br/>debuginfo:" + debuginfo + "<br/>");


    }
}
