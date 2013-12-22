<?php
//---------------------------------------------------------
//财付通即时到帐支付请求示例，商户按照此文档进行开发即可
//---------------------------------------------------------

require_once ("classes/RequestHandler.class.php");
require ("classes/client/ClientResponseHandler.class.php");
require ("classes/client/TenpayHttpClient.class.php");
/* 商户号 */
$partner = "1900000109";

/* 密钥 */
$key = "8934e7d15453e97507ef794cf7b0519d";


/* 创建支付请求对象 */
$reqHandler = new RequestHandler();
$reqHandler->init();
$reqHandler->setKey($key);
$reqHandler->setGateUrl("http://wap.tenpay.com/cgi-bin/wapmainv2.0/wm_query_order.cgi");


$httpClient = new TenpayHttpClient();
//应答对象
$resHandler = new ClientResponseHandler();
//----------------------------------------
//设置支付参数 
//----------------------------------------
$reqHandler->setParameter("ver", "2.0");  //版本号
$reqHandler->setParameter("bargainor_id", $partner);  //商户号

//transaction_id、sp_billno两项有一项必填，都存在则以transaction_id为准
$reqHandler->setParameter("transaction_id", "1900000109201010200898845817");  //财付通的交易单号
//$reqHandler->setParameter("sp_billno", "201010200898845817");  //商户内部产生的订单号
$reqHandler->setParameter("attach", iconv('UTF-8','GBK',"中文"));  //商户附加信息，如果包含中文字符，需要转换为GBK
$reqHandler->setParameter("charset", 1);  //商户号



$httpClient->setReqContent($reqHandler->getRequestURL());

//后台调用
if($httpClient->call()) {
	$resHandler->setContent($httpClient->getResContent());
	$resHandler->setKey($key);
	if ($resHandler->isTenpaySign() && 0 == $resHandler->getParameter("pay_result")) {
		$bank_type   = $resHandler->getParameter("bank_type");
		$bank_billno = $resHandler->getParameter("bank_billno");
		$pay_result = $resHandler->getParameter("pay_result");
		$pay_info = $resHandler->getParameter("pay_info");
		$purchase_alias = $resHandler->getParameter("purchase_alias");
		$bargainor_id = $resHandler->getParameter("bargainor_id");
		$transaction_id = $resHandler->getParameter("transaction_id");
		$total_fee = $resHandler->getParameter("total_fee");
		$fee_type = $resHandler->getParameter("fee_type");
		$time_end = $resHandler->getParameter("time_end");
		$attach = $resHandler->getParameter("attach");
		
		echo "bank_type: ".$bank_type." <br/>";
		echo "bank_billno: ".$bank_billno." <br/>";
		echo "pay_info: ".$pay_info." <br/>";
		echo "purchase_alias: ".$purchase_alias." <br/>";
		echo "bargainor_id: ".$bargainor_id." <br/>";
		echo "transaction_id: ".$transaction_id." <br/>";
		echo "total_fee: ".$total_fee." <br/>";
		echo "fee_type: ".$fee_type." <br/>";
		echo "time_end: ".$time_end." <br/>";
		echo "attach: ".$attach." <br/>";
	}
	
}