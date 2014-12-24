<%
/**   
 * @Title: childlock_confirm.jsp
 * @Description:  ��ͯ��������ҳ��
 * @author yangrt   
 * @date 2014-09-16 20:01:34 
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="hx.database.databean.Data"%>
<%@ page import="com.dcfs.common.TokenProcessor" %>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
	TokenProcessor processor = TokenProcessor.getInstance();
	String token = processor.getToken(request);
	Data data = (Data)request.getAttribute("data");
%>
<BZ:html>
	<BZ:head language="EN">
		<title>��ͯ��������ҳ��</title>
		<BZ:webScript edit="true" isAjax="true"/>
		<script>
			$(document).ready(function() {
				dyniframesize(['mainFrame']);//�������ܣ����Ԫ������Ӧ
			});
			
			function _submit(){
				if(confirm("Are you sure to lock this child?")){
					document.srcForm.action=path+"sce/lockchild/InitPreApproveApply.action";
					document.srcForm.submit();
				}
			}
			
			function _goBack(){
				var lock_type = "";
				var lock_mode = $("#R_LOCK_MODE").val();
				if(lock_mode == "1"){
					lock_type = "A";
				}else if(lock_mode == "3"){
					lock_type = "B";
				}else if(lock_mode == "4"){
					lock_type = "C";
				}else if(lock_mode == "5"){
					lock_type = "E";
				}else if(lock_mode == "6"){
					lock_type = "F";
				}
				document.srcForm.action=path+"sce/lockchild/FileInfoSelect.action?type=" + lock_type;
				document.srcForm.submit();
			}
		</script>
	</BZ:head>
	<BZ:body property="childdata" codeNames="SDFS;ADOPTER_CHILDREN_SEX;">
		<BZ:form name="srcForm" method="post" token="<%=token %>">
		<!-- ��������begin -->
		<BZ:input type="hidden" field="CI_ID" prefix="R_" id="R_CI_ID" property="data" defaultValue=""/>
		<BZ:input type="hidden" field="PUB_ID" prefix="R_" id="R_PUB_ID" property="data" defaultValue=""/>
		<BZ:input type="hidden" field="FILE_TYPE" prefix="R_" id="R_FILE_TYPE" property="data" defaultValue=""/>
		<BZ:input type="hidden" field="LOCK_MODE" prefix="R_" id="R_LOCK_MODE" property="data" defaultValue=""/>
		<BZ:input type="hidden" field="AF_ID" prefix="R_" id="R_AF_ID" property="data" defaultValue=""/>
		<BZ:input type="hidden" field="RI_ID" prefix="R_" id="R_RI_ID" property="data" defaultValue=""/>
		<BZ:input type="hidden" field="PRE_REQ_NO" prefix="R_" id="R_PRE_REQ_NO" property="data" defaultValue=""/>
		<!-- ��������end -->
		<!-- ������begin -->
		<div class="stepflex" style="margin-right: 30px;">
	        <dl id="payStepFrist" class="first done">
	            <dt class="s-num">1</dt>
	            <dd class="s-text" style="margin-left: 3px;">Step one: Choose a locking method</dd>
	        </dl>
	        <dl id="payStepNormal" class="normal doing">
	            <dt class="s-num">2</dt>
	            <dd class="s-text" style="margin-left: 3px;">Step two: Choose the family file <s></s>
	                <b></b>
	            </dd>
	        </dl>
	        <dl id="payStepLast" class="last">
	            <dt class="s-num">3</dt>
	            <dd class="s-text" style="margin-left: 3px;">Step three: lock<s></s>
	                <b></b>
	            </dd>
	        </dl>
		</div>
		<!-- ������end -->
		<div>
			<table cellspacing="0" cellpadding="0">
				<tr style="height: 2px;"></tr>
			</table>
		</div>
		<!-- �����Ķ�ͯ��Ϣbegin -->
		<div class="bz-edit clearfix" desc="�༭����">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<div class="ui-state-default bz-edit-title" desc="����">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>��ͯ��Ϣ(Child basic Inf.)</div>
				</div>
				<!-- �������� begin -->
				<div class="bz-edit-data-content clearfix" desc="������">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" style="text-align: center;line-height: 20px;" width="10%">����<br>Name</td>
							<td class="bz-edit-data-value" width="12%">
								<BZ:dataValue field="NAME_PINYIN" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" style="text-align: center;line-height: 20px;" width="10%">�Ա�<br>Sex</td>
							<td class="bz-edit-data-value" width="13%">
								<BZ:dataValue field="SEX" codeName="ADOPTER_CHILDREN_SEX" isShowEN="true" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" style="text-align: center;line-height: 20px;" width="10%">��������<br>D.O.B</td>
							<td class="bz-edit-data-value" width="12%">
								<BZ:dataValue field="BIRTHDAY" type="Date" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" style="text-align: center;line-height: 20px;" width="10%">�ر��ע<br>Special focus</td>
							<td class="bz-edit-data-value" width="13%">
								<BZ:dataValue field="SPECIAL_FOCUS" checkValue="0=No;1=Yes;" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<BZ:for property="attachList" fordata="attachData">
						<tr>
							<td class="bz-edit-data-title" style="text-align: center;" width="10%">����<br>Name</td>
							<td class="bz-edit-data-value" width="12%">
								<BZ:dataValue field="NAME_PINYIN" property="attachData" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" style="text-align: center;" width="10%">�Ա�<br>Sex</td>
							<td class="bz-edit-data-value" width="13%">
								<BZ:dataValue field="SEX" codeName="ADOPTER_CHILDREN_SEX" isShowEN="true" property="attachData" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" style="text-align: center;" width="10%">��������<br>D.O.B</td>
							<td class="bz-edit-data-value" width="12%">
								<BZ:dataValue field="BIRTHDAY" type="Date" property="attachData" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" style="text-align: center;" width="10%">�ر��ע<br>Special focus</td>
							<td class="bz-edit-data-value" width="13%">
								<BZ:dataValue field="SPECIAL_FOCUS" checkValue="0=No;1=Yes;" property="attachData" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						</BZ:for>
					</table>
				</div>
				<!-- �������� end -->
			</div>
		</div>
		<!-- �����Ķ�ͯ��Ϣend -->
		<!-- ������ʽbegin -->
		<div class="bz-edit clearfix" desc="�༭����" style="margin-top: 0px;">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<div class="ui-state-default bz-edit-title" desc="����">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>������ʽ(Lock type)</div>
				</div>
				<!-- �������� begin -->
				<div class="bz-edit-data-content clearfix" desc="������">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-value" style="line-height: 20px;">
								<BZ:dataValue field="" codeName="SDFS" defaultValue='<%=(String)data.getString("LOCK_MODE","") %>' onlyValue="true"/><br>
								<BZ:dataValue field="" codeName="SDFS" defaultValue='<%=(String)data.getString("LOCK_MODE","") %>' isShowEN="true" onlyValue="true"/>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<!-- ������ʽend -->
		<!-- ��������Ϣbegin -->
		<div class="bz-edit clearfix" desc="�༭����" style="margin-top: 0px;">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<div class="ui-state-default bz-edit-title" desc="����">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>����ȷ��(Confirm)</div>
				</div>
				<!-- �������� begin -->
				<div class="bz-edit-data-content clearfix" desc="������">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" style="text-align: center;line-height: 20px;" width="20%;" >��������<br>Adoptive father</td>
							<td class="bz-edit-data-value" width="30%">
								<%=(String)data.getString("MALE_NAME","") %>
							</td>
							<td class="bz-edit-data-title" style="text-align: center;line-height: 20px;" width="20%">Ů������<br>Adoptive mother</td>
							<td class="bz-edit-data-value" width="30%">
								<%=(String)data.getString("FEMALE_NAME","") %>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<!-- ��������Ϣend -->
		<br/>
		<!-- ��ť����begin -->
		<div class="bz-action-frame">
			<div class="bz-action-edit" desc="��ť��">
				<input type="button" value="Confirm" class="btn btn-sm btn-primary" onclick="_submit();"/>
				<input type="button" value="Back" class="btn btn-sm btn-primary" onclick="_goBack();"/>
			</div>
		</div>
		<!-- ��ť����end -->
		</BZ:form>
	</BZ:body>
</BZ:html>