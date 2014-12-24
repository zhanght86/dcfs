
<%@ page language="java" contentType="text/html; charset=GBK"
		pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@page import="hx.database.databean.DataList"%>
<%@page import="com.hx.framework.sync.vo.TargetSys"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%
Data data = (Data)request.getAttribute("data");
DataList sysList = (DataList)request.getAttribute("sysList");
%>
<BZ:html>
<BZ:head>
<title>ͬ����������ҳ��</title>
<BZ:script isEdit="true" tree="true"/>
<script type="text/javascript" language="javascript">

$(document).ready(function() {
	dyniframesize(['mainFrame','mainFrame']);
});
	function tijiao()
	{
		if (!runFormVerify(document.srcForm, false)) {
			return;
		}
		selectValue();
		document.srcForm.action=path+"sync/saveSyncConfig.action";
		document.srcForm.submit();
	}
	//���á���ѡ��select�ؼ�������optionΪ��ѡ״̬:
	function selectValue(){
		var sysIdObj = document.getElementById("P_TARGET_ID");
		var len = sysIdObj.length;
		for(var i=0;i<len;i++){
			sysIdObj.options[i].selected=true;
		}
		var eventObj = document.getElementById("P_EVENT_TYPE");
		var len = eventObj.length;
		for(var i=0;i<len;i++){
			eventObj.options[i].selected=true;
		}
	}
	function _back(){
		document.srcForm.action=path+"sync/SyncConfig.action";
		document.srcForm.submit();
	}
	/* ����ѡ�����--���ƶ� */
	function add(src, dist) {
		if(src.selectedIndex != '-1'){
			//�ж��ұ��Ƿ����ȫ��
			if(dist.options.length > 0){
				for(var i=0;i<dist.options.length;i++){
					var opt = dist.options[i];
					if(opt.value == '0'){
						alert("ȫ�ֺ�����Ӧ�ò���ͬʱ����!");
						return;
					}
				}
			}
			for(var i=0;i<src.options.length;i++){
				if(src.options[i].selected){
					var opt = src.options[i];
					if(dist.options.length > 0){
						if(opt.value == '0'){
							alert("ȫ�ֺ�����Ӧ�ò���ͬʱ����!");
							break;
						}
					}
					dist.options.add(new Option(opt.text, opt.value));
					src.remove(i);
					i=i-1;
				}
			}
		}
		}

		/* ����ѡ�����----���ƶ� */
		function back(src, dist) {
			for(var i=0;i<src.options.length;i++){
				if(src.options[i].selected){
					var opt = src.options[i];
					dist.options.add(new Option(opt.text, opt.value));
					src.remove(i);
					i=i-1;
				}
			}
		}

		/* ����ȫ�� */
		function addAll(src, dist) {

			if(dist.options.length > 0){
			if(dist.options[dist.options.length - 1].value == '0'){
				alert("ȫ�ֺ�����Ӧ�ò���ͬʱ����!");
				dist.remove(dist.options.length - 1);
			}
		}

			for(var i=0;i<src.options.length;i++){
			var opt = src.options[i];
			dist.options.add(new Option(opt.text, opt.value));
			src.remove(i);
			i=i-1;
			}
		}
</script>
</BZ:head>
<BZ:body property="data">
<BZ:form name="srcForm" method="post" token="positionGradeAdd">
<div class="kuangjia">
<div class="heading">ͬ����������</div>
<table class="contenttable">
<tr>
<td></td>
<td width="200px">
	��ѡĿ��ϵͳ<br>
	<select id="SOURCE_TARGET_ID" style="width: 200px" name="SOURCE_TARGET_ID" size="14" multiple="multiple">

			<%
				for(int i=0;i<sysList.size();i++){
					Data sys = sysList.getData(i);
					String targetId = sys.getString(TargetSys.TARGET_ID);
					String targetName = sys.getString(TargetSys.TARGET_NAME);
					%>
					<option value="<%=targetId %>"><%=targetName %></option>
					<%
				}
			%>
		</select>
</td>
<td valign="middle" width="50px">
	<input type="button" value="&gt;" style="width: 50px" onclick="add(document.getElementById('SOURCE_TARGET_ID'),document.getElementById('P_TARGET_ID'))" /><br />
	<input type="button" value="&gt;&gt;" style="width: 50px" onclick="addAll(document.getElementById('SOURCE_TARGET_ID'),document.getElementById('P_TARGET_ID'))" /><br />
	<input type="button" value="&lt;&lt;" style="width: 50px" onclick="addAll(document.getElementById('P_TARGET_ID'),document.getElementById('SOURCE_TARGET_ID'))" /><br />
		<input type="button" value="&lt;" style="width: 50px" onclick="back(document.getElementById('P_TARGET_ID'),document.getElementById('SOURCE_TARGET_ID'))" /><br />
</td>
<td>
	��ѡĿ��ϵͳ<br>
	<select style="width: 200px" id="P_TARGET_ID" name="P_TARGET_ID" size="14" multiple="multiple">
	</select>
</td>
</tr>
<tr>
<td></td>
<td width="200px">
	��ѡ�¼�����<br>

	<select id="SOURCE_EVENT_TYPE" style="width: 200px" name="SOURCE_EVENT_TYPE" size="14" multiple="multiple">
		<option value="addUser">�����û�</option>
			<option value="updateUser">�����û�</option>
			<option value="deleteUser">ɾ���û�</option>
			<option value="addOrg">������֯����</option>
			<option value="updateOrg">������֯����</option>
			<option value="deleteOrg">ɾ����֯����</option>
			<option value="modifyPwd">�޸��û�����</option>
		</select>
</td>
<td valign="middle" width="50px">
	<input type="button" value="&gt;" style="width: 50px" onclick="add(document.getElementById('SOURCE_EVENT_TYPE'),document.getElementById('P_EVENT_TYPE'))" /><br />
	<input type="button" value="&gt;&gt;" style="width: 50px" onclick="addAll(document.getElementById('SOURCE_EVENT_TYPE'),document.getElementById('P_EVENT_TYPE'))" /><br />
	<input type="button" value="&lt;&lt;" style="width: 50px" onclick="addAll(document.getElementById('P_EVENT_TYPE'),document.getElementById('SOURCE_EVENT_TYPE'))" /><br />
		<input type="button" value="&lt;" style="width: 50px" onclick="back(document.getElementById('P_EVENT_TYPE'),document.getElementById('SOURCE_EVENT_TYPE'))" /><br />
</td>
<td>
	��ѡ�¼�����<br>
	<select style="width: 200px" id="P_EVENT_TYPE" name="P_EVENT_TYPE" size="14" multiple="multiple">

	</select>
</td>
</tr>
</table>
<table border="0" cellpadding="0" cellspacing="0" class="operation">
<tr>
<td align="center" style="padding-right:30px" colspan="2"><input type="button" value="����" class="button_add" onclick="tijiao()"/>&nbsp;&nbsp;<input type="button" value="����" class="button_back" onclick="_back()"/></td>
</tr>
</table>
</div>
</BZ:form>
</BZ:body>
</BZ:html>