<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<%@page contentType="text/html; charset=gb2312"%>
<%
	String contextpath = request.getContextPath();
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="<%=contextpath%>/rwgl/css/style.css" rel="stylesheet" type="text/css" />
<title>无标题文档</title>
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
	background-color: #F4F9FF;
}
-->
</style>
</head>
<script>
function _retrieve(){
	alert("查询");
}
function newGroup(){
	document.location.href="xjsjy.html";
}
</script>
<body>
<form>
<table width="100%" border="0" cellspacing="0" cellpadding="1" class="text01" >

  
      <tr>
        <td height="25" colspan="4">
				  <div id="query">
					  数据源名称：&nbsp;
					  <input name="enterpriseid" type="text" class="queryinput" size="11" maxlength="9" />
					  &nbsp;
					  数据源类型：&nbsp;
					  <select name="DS_TYPE">
                            <option value="" selected >【-全部-】</option>
                            
                            <option value="DS_TYPE_JDBC" >JDBC数据源</option>
                            
                            <option value="DS_TYPE_JNDI" >JNDI数据源</option>
                            
                            <option value="DS_TYPE_OLAP" >OLAP数据源</option>
                            
                            <option value="DS_TYPE_EXCEL" >EXCEL数据源</option>
                            
                            <option value="DS_TYPE_XML" >XML数据源</option>
                            
                            <option value="DS_TYPE_TXT" >TXT数据源</option>
                            
                            <option value="DS_TYPE_SOCKET" >SOCKET数据源</option>
                            
                            <option value="DS_TYPE_WEBSERVICE" >WEBSERVICE数据源</option>
                            
                            <option value="DS_TYPE_MQ" >MQ数据源</option>
                            			
                    </select>
					  <input type="button" name="submit" value="查询(Q)" class="input01" accesskey="Q" onclick="_retrieve();"/ tabindex="100" Onkeydown="">
				  </div>		  
				</td>
</tr>	
 <tr>
        <td height="18" colspan="4">
			&nbsp;	 	  
		</td>
</tr>
 <tr>
      <td colspan="4">
		<div id="primarydata" style="width:100%; overflow:hidden" >
		<table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#9CC6F7" class="text01">
	    <tr height="22">
		  <th width="5%"><div align="center">&nbsp;</div></th>
	      <th width="5%"><div align="center">序号</div></th>
	      <th width="20%"><div align="center">数据源名称</div></th>
	      <th width="20%"><div align="center">数据源类型</div></th> 
		  <th width="20%"><div align="center">数据源描述</div></th>   
		  <th width="20%"><div align="center">建立时间</div></th>   
		  <th width="10%"><div align="center">连接测试</div></th>         	
      </tr>
      
      <tr height="22" >
         <td class="listdata"><div align="center"><input type="checkbox" name="checkbox" value="checkbox" class="input"></div></td>
        <td class="listdata"><div align="center">1</div></td>
        <td class="listdata"><div align="left">XML适配器</div></td>       
        <td class="listdata"><div align="left">XML数据源</div></td>  
		<td class="listdata"><div align="left">XML适配器</div></td> 
		<td class="listdata"><div align="left">2006-04-20</div></td>
		<td class="listdata"><div align="center"><input type="button" name="test" value="测试" onClick="alert('测试数据源连接');" class="input01"></div></td>        				
     
      </tr>	  		  		  		  
    </table>
		</div>
		</td>
    </tr>
    <tr>
      <td colspan="4" height="24"></td>
    </tr>
  <tr><td align="center" colspan="4"><input type="button" name="addButton" value="新建" class="input01" onClick="newGroup();">&nbsp;<input type="button" name="delButton" value="删除" class="input01" onClick="alert('删除');"></td></tr>
</table>

</form>
</body>
</html>