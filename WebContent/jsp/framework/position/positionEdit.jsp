
<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%@page import="hx.database.databean.Data"%>
<%
Data data=(Data)request.getAttribute("data");
%>
<BZ:html>
<BZ:head>
<title>职务修改页面</title>
<BZ:script tree="true"/>
<script>
	function tijiao()
	{
		if (!runFormVerify(document.srcForm, false)) {
			return;
		}
	document.srcForm.action=path+"position/positionModify.action";
 	document.srcForm.submit();
	}
	function _back(){
 	document.srcForm.action=path+"position/positionList.action";
 	document.srcForm.submit();
	}
</script>
</BZ:head>
<BZ:body property="data">
<BZ:form name="srcForm" method="post">
<div class="kuangjia">
<BZ:input field="ID" type="hidden" prefix="P_" defaultValue=""/>
<div class="heading">职务修改</div>
<table class="contenttable">
<tr>
<td width="5%"></td>
<td width="10%">职务名称</td>
<td width="20%"><BZ:input field="CNAME" type="String" notnull="请输入职务名称" formTitle="职务名称" prefix="P_" defaultValue=""/></td>
<td width="10%">职务代码</td>
<td width="20%"><BZ:input field="POST_CODE" type="String" notnull="请输入职务代码" formTitle="职务代码" prefix="P_" defaultValue=""/></td>
<td width="5%"></td>
</tr>
<tr>
<td></td>
<td>排序号</td>
<td><BZ:input field="SEQ_NUM" type="String" notnull="请输入排序号" formTitle="排序号" restriction="int" prefix="P_" defaultValue=""/></td>
<td></td>
<td></td>
<td></td>
</tr>
<tr>
<td></td>
<td>职务说明</td>
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