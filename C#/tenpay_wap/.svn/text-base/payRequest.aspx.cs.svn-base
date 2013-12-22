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

public partial class payRequest : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //商户号
        string bargainor_id = "1900000109";

        //密钥
        string key = "8934e7d15453e97507ef794cf7b0519d";


        //创建请求对象
        RequestHandler reqHandler = new RequestHandler(Context);

        //通信对象
        TenpayHttpClient httpClient = new TenpayHttpClient();

        //应答对象
        ClientResponseHandler resHandler = new ClientResponseHandler();

        
        //当前时间 yyyyMMdd
        string date = DateTime.Now.ToString("yyyyMMdd");
        //订单号，此处用时间和随机数生成，商户根据自己调整，保证唯一
        string sp_billno = "" + DateTime.Now.ToString("HHmmss") + TenpayUtil.BuildRandomStr(4);


        reqHandler.init();
        //设置密钥
        reqHandler.setKey(key);
        reqHandler.setGateUrl("https://wap.tenpay.com/cgi-bin/wappayv2.0/wappay_init.cgi");



        //-----------------------------
        //设置支付初始化参数
        //-----------------------------
        reqHandler.setParameter("ver", "2.0");
        reqHandler.setParameter("charset", "1");
        reqHandler.setParameter("bank_type", "0");
        reqHandler.setParameter("desc", "测试");
        reqHandler.setParameter("bargainor_id", bargainor_id);
        reqHandler.setParameter("sp_billno", sp_billno);
        reqHandler.setParameter("total_fee", "1");
        reqHandler.setParameter("fee_type", "1");
        reqHandler.setParameter("notify_url", "http://localhost:2939/tenpay_wap/payNotifyUrl.aspx");
        reqHandler.setParameter("callback_url", "http://localhost:2939/tenpay_wap/payCallbackUrl.aspx");
        reqHandler.setParameter("attach", "attach");

        string initRequestUrl = reqHandler.getRequestURL();
        //设置请求内容
        httpClient.setReqContent(initRequestUrl);
        //设置超时
        httpClient.setTimeOut(5);

        string rescontent = "";
        string payRequestUrl = "";
        //后台调用
        if (httpClient.call())
        {
            //获取结果
            rescontent = httpClient.getResContent();

            //设置结果参数
            resHandler.setContent(rescontent);

            string token_id = resHandler.getParameter("token_id");

            //成功，则token_id有只
            if (token_id != "")
            {
                //生成支付请求
                payRequestUrl = "https://wap.tenpay.com/cgi-bin/wappayv2.0/wappay_gate.cgi?token_id=" + TenpayUtil.UrlEncode(token_id, Request.ContentEncoding.BodyName);

                //Get的实现方式
                string a_link = "<a target=\"_blank\" href=\"" + payRequestUrl + "\">" + "财付通手机支付" + "</a><br>";
                Response.Write(a_link);

            }
            else
            {
                //获取token_id调用失败 ，显示错误 页面
                Response.Write("支付初始化错误:" + resHandler.getParameter("err_info") + "<br>");
            }

        }
        else
        {
            //后台调用通信失败
            Response.Write("call err:" + httpClient.getErrInfo() + "<br>" + httpClient.getResponseCode() + "<br>");
            //有可能因为网络原因，请求已经处理，但未收到应答。
        }


        //获取debug信息,建议把请求、应答内容、debug信息，通信返回码写入日志，方便定位问题
        /*
        Response.Write("http res:" + httpClient.getResponseCode() + "," + httpClient.getErrInfo() + "<br>");
        Response.Write("req url:" + initRequestUrl + "<br/>");
        Response.Write("req debug:" + reqHandler.getDebugInfo() + "<br/>");
        Response.Write("res content:" + Server.HtmlEncode(rescontent) + "<br/>");
        Response.Write("res debug:" + Server.HtmlEncode(resHandler.getDebugInfo()) + "<br/>");
        Response.Write("pay req url:" + payRequestUrl + "<br/>");
         */
    }
}
