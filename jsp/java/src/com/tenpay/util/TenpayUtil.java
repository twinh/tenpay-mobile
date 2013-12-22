package com.tenpay.util;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class TenpayUtil {
	
	/**
	 * 把对象转换成字符串
	 * @param obj
	 * @return String 转换成字符串,若对象为null,则返回空字符串.
	 */
	public static String toString(Object obj) {
		if(obj == null)
			return "";
		
		return obj.toString();
	}
	
	/**
	 * 把对象转换为int数值.
	 * 
	 * @param obj
	 *            包含数字的对象.
	 * @return int 转换后的数值,对不能转换的对象返回0。
	 */
	public static int toInt(Object obj) {
		int a = 0;
		try {
			if (obj != null)
				a = Integer.parseInt(obj.toString());
		} catch (Exception e) {

		}
		return a;
	}
	
	/**
	 * 获取当前时间 yyyyMMddHHmmss
	 * @return String
	 */ 
	public static String getCurrTime() {
		Date now = new Date();
		SimpleDateFormat outFormat = new SimpleDateFormat("yyyyMMddHHmmss");
		String s = outFormat.format(now);
		return s;
	}
	
	/**
	 * 获取当前日期 yyyyMMdd
	 * @param date
	 * @return String
	 */
	public static String formatDate(Date date) {
		SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
		String strDate = formatter.format(date);
		return strDate;
	}
	
	/**
	 * 取出一个指定长度大小的随机正整数.
	 * 
	 * @param length
	 *            int 设定所取出随机数的长度。length小于11
	 * @return int 返回生成的随机数。
	 */
	public static int buildRandom(int length) {
		int num = 1;
		double random = Math.random();
		if (random < 0.1) {
			random = random + 0.1;
		}
		for (int i = 0; i < length; i++) {
			num = num * 10;
		}
		return (int) ((random * num));
	}
	
	/**
	 * 获取编码字符集
	 * @param request
	 * @param response
	 * @return String
	 */
	public static String getCharacterEncoding(HttpServletRequest request,
			HttpServletResponse response) {
		
		if(null == request || null == response) {
			return "gbk";
		}
		
		String enc = request.getCharacterEncoding();
		if(null == enc || "".equals(enc)) {
			enc = response.getCharacterEncoding();
		}
		
		if(null == enc || "".equals(enc)) {
			enc = "gbk";
		}
		
		return enc;
	}
	
	/**
	 * 获取unix时间，从1970-01-01 00:00:00开始的秒数
	 * @param date
	 * @return long
	 */
	public static long getUnixTime(Date date) {
		if( null == date ) {
			return 0;
		}
		
		return date.getTime()/1000;
	}
		
	/**
	 * 时间转换成字符串
	 * @param date 时间
	 * @param formatType 格式化类型
	 * @return String
	 */
	public static String date2String(Date date, String formatType) {
		SimpleDateFormat sdf = new SimpleDateFormat(formatType);
		return sdf.format(date);
	}
	
	/**
	 * 把十六进制的字符串转化为字节数据
	 * @param hex
	 * @return
	 */
	public static byte[] hexStringToByte(String hex) { 
	    int len = (hex.length() / 2); 
	    byte[] result = new byte[len]; 
	    char[] srcChars = hex.toUpperCase().toCharArray(); 
	    for (int i = 0; i < len; i++) { 
	     result[i] = (byte) (toByte(srcChars[i*2]) << 4 | toByte(srcChars[i*2 + 1])); 
	    } 
	    return result; 
	} 

	private static byte toByte(char c) { 
	    byte b = (byte) "0123456789ABCDEF".indexOf(c); 
	    return b; 
	} 

	/**
	 * 把字节数组转化为十六进制字符串
	 * @param bArray
	 * @return
	 */
	public static  String bytesToHexString(byte[] bArray) { 
	    StringBuffer sb = new StringBuffer(bArray.length); 
	    String str; 
	    for (int i = 0; i < bArray.length; i++) { 
	    	str = Integer.toHexString(0xFF & bArray[i]); 
	    	
		     if (str.length() < 2) {
		      sb.append(0); 
		     }
		     sb.append(str.toUpperCase()); 
	    } 
	    return sb.toString(); 
	} 

	/**
	 * 字符串转换成Map<br/>
	 * name1=key1&name2=key2&...
	 * @param queryString
	 * @return
	 */
	public static Map str2Map(String str, String split, String subSplit) {
		Map m = new HashMap();
		
		if(null != str && !"".equals(str)) {
			String[] strArray = str.split(split);
			for(int index = 0; index < strArray.length; index++) {
				String[] pair = strArray[index].split(subSplit);
				String v = "";
				if(pair.length > 1) {
					v = pair[1];
				}
				if(!pair[0].equals("")) {
					m.put(pair[0], v);
				}
			
			}
		}
		return m;
		
	}
	
	/**
	 * 对需要出现在HTML属性里的不信任输入进行编码 
	 * @param str
	 * @return
	 * 		< --> &lt;
			> --> &gt;
			' --> &#39;
			" --> &quot;
			& --> &amp;
			= --> &#61;
			` --> &#96;
	 */
	public static String htmlAttributeEncode(String str)
	{
		if(str == null)
		{
			return "";
		}
		// 不用正则表达式替换，直接通过循环，节省cpu时间
		StringBuilder sb = new StringBuilder();
		for(int i = 0; i < str.length(); ++i)
		{
			char c = str.charAt(i);
			switch(c)
			{				
				case '<':
					sb.append("&lt;");
					break;
				case '>':
					sb.append("&gt;");
					break;
				case '\'':
					sb.append("&#39;");
				case '\"':
					sb.append("&quot;");
					break;
				case '&':
					sb.append("&amp;");
					break;
				case '=':
					sb.append("&#61;");
					break;
				case '`':
					sb.append("&#96;");
					break;
				default:
					sb.append(c);
					break;
			}
		}
		return sb.toString();
	}
}
