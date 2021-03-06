
<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%@page import="hx.database.databean.Data"%>
<%
String APP_ID=(String)request.getAttribute("APP_ID");
if(APP_ID==null){
	APP_ID="";
}
String MODULE_ID=(String)request.getAttribute("MODULE_ID");
if(MODULE_ID==null){
	MODULE_ID="";
}
Data data=(Data)request.getAttribute("data");
%>

<BZ:html>
<BZ:head>
<title>资源修改页面</title>
<BZ:script isEdit="true" />
<script>
$(document).ready(function() {
	dyniframesize(['mainFrame','mainFrame']);
});
	function tijiao()
	{
		if(!runFormVerify(document.srcForm,false)){
			return;
		}
		document.srcForm.action=path+"resource/resourcesModify.action";
 		document.srcForm.submit();
	}
	function _back(){
 		document.srcForm.action=path+"resource/resourcesList.action?APP_ID=<%=APP_ID%>&MODULE_ID=<%=MODULE_ID%>";
 		document.srcForm.submit();
	}
	function _change(bl){
		if(bl=='1'){
			document.getElementById("CTR_URL").disabled = false;
		}
		if(bl=='2'){
			document.getElementById("CTR_URL").disabled = true;
		}
	}
</script>
</BZ:head>
<BZ:body property="data">
<BZ:form name="srcForm" method="post">
<input type="hidden" name="P_APP_ID" value="<%=APP_ID%>"/>
<input type="hidden" name="P_MODULE_ID" value="<%=MODULE_ID%>"/>
<div class="kuangjia">
<BZ:input field="ID" type="hidden" prefix="P_" defaultValue=""/>
<div class="heading">资源修改</div>
<table class="contenttable">
<tr>
<td width="10%"></td>
<td width="20%">资源名称</td>
<td width="60%" colspan="3"><BZ:input field="CNAME" type="String" prefix="P_" notnull="请输入资源名称" formTitle="资源名称"/></td>
<td width="10%"></td>
</tr>
<tr>
<td></td>
<td>资源URL</td>
<td colspan="3"><BZ:input field="RES_URL" type="String" prefix="P_" size="50" notnull="请输入资源名称" formTitle="资源名称"/></td>
<td></td>
</tr>
<tr>
<td></td>
<td >是否权限控制</td>
<td colspan="3">是&nbsp;<BZ:radio field="IS_VERIFY_AUTH" prefix="P_" formTitle="是否需要权限控制" value="1" property="data"  onclick="_change('1')"/>&nbsp;&nbsp;否&nbsp;<BZ:radio field="IS_VERIFY_AUTH" prefix="P_" formTitle="是否需要权限控制" value="0" property="data"  onclick="_change('2')"/></td>
<td></td>
</tr>
<tr>
<td></td>
<td>资源权限控制URL</td>
<td colspan="3"><BZ:input id="CTR_URL" field="CTR_URL" type="String" prefix="P_" size="50" formTitle="资源权限控制URL" defaultValue=""/></td>
<td></td>
</tr>
<tr>
<td width="10%"></td>
<td width="10%">是否菜单入口</td>
<td width="30%">是&nbsp;<BZ:radio field="IS_NAVIGATE" prefix="P_" formTitle="菜单入口" value="1" property="data" />&nbsp;&nbsp;否&nbsp;<BZ:radio field="IS_NAVIGATE" prefix="P_" formTitle="菜单入口" value="0" property="data" /></td>
<td width="10%">状态</td>
<td width="30%"><BZ:select field="STATUS" formTitle="状态" property="data" prefix="P_"><BZ:option value="1">启用</BZ:option><BZ:option value="0">停用</BZ:option></BZ:select></td>
<td width="10%"></td>
<td></td>
</tr>
<tr>
<td></td>
<td>描述</td>
<td colspan="4"><textarea rows="6" style="width:80%" name="P_MEMO"><%=data.getString("MEMO","") %></textarea></td>
</tr>
</table>
<table border="0" cellpadding="0" cellspacing="0" class="operation">
<tr>
<td align="center" style="padding-right:30px" colspan="2"><input type="button" value="保存" class="button_add" onclick="tijiao()"/>&nbsp;&nbsp;<input type="button" value="返回" class="button_back" onclick="_back()"/></td>
</tr>
</table>
</div>
</BZ:form>
</BZ:body>
</BZ:html>