<%
/**   
 * @Title: addmaterial_revise_singleinfo.jsp
 * @Description:  Ԥ��������Ϣ�޸ģ�����������
 * @author panfeng   
 * @date 2014-11-4 15:41:15 
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="hx.database.databean.Data"%>
<%@ page import="com.dcfs.common.TokenProcessor" %>
<%@ page import="com.dcfs.common.atttype.AttConstants" %>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%
	TokenProcessor processor = TokenProcessor.getInstance();
	String token = processor.getToken(request);
	String path = request.getContextPath();
	String MALE_PUNISHMENT_FLAG = (String)request.getAttribute("MALE_PUNISHMENT_FLAG");	//��������Υ����Ϊ�����´�����ʶ,0=�ޣ�1=��
	String MALE_ILLEGALACT_FLAG = (String)request.getAttribute("MALE_ILLEGALACT_FLAG");	//�����������޲����Ⱥñ�ʶ,0=�ޣ�1=��
	String FEMALE_PUNISHMENT_FLAG = (String)request.getAttribute("FEMALE_PUNISHMENT_FLAG");	//Ů������Υ����Ϊ�����´�����ʶ,0=�ޣ�1=��
	String FEMALE_ILLEGALACT_FLAG = (String)request.getAttribute("FEMALE_ILLEGALACT_FLAG");	//Ů���������޲����Ⱥñ�ʶ,0=�ޣ�1=��
	String CONABITA_PARTNERS = (String)request.getAttribute("CONABITA_PARTNERS");	//ͬ�ӻ��,0=�ޣ�1=��
	String ADOPTER_SEX = (String)request.getAttribute("ADOPTER_SEX");	//�������Ա�
%>
<BZ:html>
	<BZ:head language="EN">
		<title>Ԥ��������Ϣ�޸ģ�����������</title>
		<up:uploadResource isImage="true" cancelJquerySupport="true"/>
		<BZ:webScript edit="true"/>
		<script type="text/javascript"  src="/dcfs/resource/js/jquery-1.9.1.min.js"></script>
		<style>
			.base .bz-edit-data-title{
				line-height:20px;
			}
		</style>
	</BZ:head>
	<script>
		$(document).ready(function() {
			
			var sex = "<%=ADOPTER_SEX%>";
			if(sex == "1"){
				$("#femaleinfo").hide();
				//���ݳ������ڳ�ʼ������
				var male_briDate = $("#R_MALE_BIRTHDAY").val();	//�������˵ĳ�������
				if(male_briDate != ""){
					$("#MALE_AGE").text(_getAge(male_briDate));
				}
				
				//��ʼ������״��˵������ʾ������
				var male_health = $("#R_MALE_HEALTH").find("option:selected").val();	//�������˵Ľ���״��
				if(male_health == "2"){
					$("#R_MALE_HEALTH_CONTENT_EN").show();
				}else{
					$("#R_MALE_HEALTH_CONTENT_EN").hide();
				}
				
				//��ʼ��Υ����Ϊ�����´���˵������ʾ������
				var MALE_PUNISHMENT_FLAG = "<%=MALE_PUNISHMENT_FLAG%>";
				if(MALE_PUNISHMENT_FLAG == "1"){
					$("#R_MALE_PUNISHMENT_EN").show();
				}else{
					$("#R_MALE_PUNISHMENT_EN").hide();
				}
				
				//��ʼ�������Ⱥ�˵������ʾ������
				var MALE_ILLEGALACT_FLAG = "<%=MALE_ILLEGALACT_FLAG%>";
				if(MALE_ILLEGALACT_FLAG == "1"){
					$("#R_MALE_ILLEGALACT_EN").show();
				}else{
					$("#R_MALE_ILLEGALACT_EN").hide();
				}
				
				$("#R_FEMALE_YEAR_INCOME").hide();
				$("#R_MALE_NAME").attr("notnull", "Please write the name of adoptive father!");
				$("#R_MALE_BIRTHDAY").attr("notnull", "Please select the DOB of adoptive father!");
				$("#R_MALE_NATION").attr("notnull", "Please select the nationality of adoptive father!");
				$("#R_MALE_EDUCATION").attr("notnull", "Please select the education of adoptive father!");
				$("#R_MALE_JOB_EN").attr("notnull", "����д��������ְҵ��");
				$("#R_MALE_HEALTH").attr("notnull", "Please select the health status of adoptive father!");
				$("#R_MALE_YEAR_INCOME").attr("notnull", "Please write the annual income of adoptive father!");
			}else if(sex == "2"){
				$("#maleinfo").hide();
				//���ݳ������ڳ�ʼ������
				var female_briDate = $("#R_FEMALE_BIRTHDAY").val();	//Ů�����˵ĳ�������
				if(female_briDate != ""){
					$("#FEMALE_AGE").text(_getAge(female_briDate));
				}
				
				//��ʼ������״��˵������ʾ������
				var female_health = $("#R_FEMALE_HEALTH").find("option:selected").val();	//Ů�����˵Ľ���״��
				if(female_health == "2"){
					$("#R_FEMALE_HEALTH_CONTENT_EN").show();
				}else{
					$("#R_FEMALE_HEALTH_CONTENT_EN").hide();
				}
				
				//��ʼ��Υ����Ϊ�����´���˵������ʾ������
				var FEMALE_PUNISHMENT_FLAG = "<%=FEMALE_PUNISHMENT_FLAG%>";
				if(FEMALE_PUNISHMENT_FLAG == "1"){
					$("#R_FEMALE_PUNISHMENT_EN").show();
				}else{
					$("#R_FEMALE_PUNISHMENT_EN").hide();
				}
				
				//��ʼ�������Ⱥ�˵������ʾ������
				var FEMALE_ILLEGALACT_FLAG = "<%=FEMALE_ILLEGALACT_FLAG%>";
				if(FEMALE_ILLEGALACT_FLAG == "1"){
					$("#R_FEMALE_ILLEGALACT_EN").show();
				}else{
					$("#R_FEMALE_ILLEGALACT_EN").hide();
				}
				
				$("#R_MALE_YEAR_INCOME").hide();
				$("#R_FEMALE_NAME").attr("notnull", "Please write the name of adoptive mother!");
				$("#R_FEMALE_BIRTHDAY").attr("notnull", "Please select the DOB of adoptive mother!");
				$("#R_FEMALE_NATION").attr("notnull", "Please select the nationality of adoptive mother!");
				$("#R_FEMALE_EDUCATION").attr("notnull", "Please select the education of adoptive mother!");
				$("#R_FEMALE_JOB_EN").attr("notnull", "����дŮ������ְҵ��");
				$("#R_FEMALE_HEALTH").attr("notnull", "Please select the health status of adoptive mother!");
				$("#R_FEMALE_YEAR_INCOME").attr("notnull", "Please write the annual income of adoptive mother!");
			}
			
			//��ʼ��ͬ��ʱ������ʾ������
			var CONABITA_PARTNERS = "<%=CONABITA_PARTNERS %>";
			if(CONABITA_PARTNERS == "1"){
				$("#conabita_partners_time1").show();
				$("#conabita_partners_time2").show();
			}else{
				$("#conabita_partners_time1").hide();
				$("#conabita_partners_time2").hide();
			}
			
			//��ʼ����ͥ���ʲ�
			_setTotalManny();
			
		});
		
		//�������
		function _save() {
			//ҳ�����У��
			if (!runFormVerify(document.srcForm, false)) {
				return;
			}else{
				if (confirm("ȷ��������")) {
					document.srcForm.action = path + "sce/addMaterial/modInfoSave.action?type=info";
					document.srcForm.submit();
					//window.opener.open_tijiao();
					window.close();
				}
			}
		}
		
		//�����������˵ĳ������ڻ�ȡ����
		function _setMaleAge(obj){
			var date = obj.value;
			var age = _getAge(date);
			$("#MALE_AGE").text(age);
		}
		
		//����Ů�����˵ĳ������ڻ�ȡ����
		function _setFemaleAge(obj){
			var date = obj.value;
			var age = _getAge(date);
			$("#FEMALE_AGE").text(age);
		}
		
		//������ʾ������Ů�����˵Ľ���״������
		function _setFemaleHealthContent(){
			var val = $("#R_FEMALE_HEALTH").find("option:selected").val();
			if(val == 2){
				$("#R_FEMALE_HEALTH_CONTENT_EN").show();
				$("#R_FEMALE_HEALTH_CONTENT_EN").attr("notnull","Please input the description of the adoptive mother's health condition!");
			}else{
				$("#R_FEMALE_HEALTH_CONTENT_EN").hide();
				$("#R_FEMALE_HEALTH_CONTENT_EN").val("");
				$("#R_FEMALE_HEALTH_CONTENT_EN").removeAttr("notnull");
			}
		}
		
		//��ʩŮ������Υ����Ϊ�����´�����������ʾ������
		function _setFemalePunishment(obj){
			var val = obj.value;
			if(val == 0){
				$("#R_FEMALE_PUNISHMENT_EN").hide();
				$("#R_FEMALE_PUNISHMENT_EN").val("");
				$("#R_FEMALE_PUNISHMENT_EN").removeAttr("notnull");
			}else{
				$("#R_FEMALE_PUNISHMENT_EN").show();
				$("#R_FEMALE_PUNISHMENT_EN").attr("notnull","Please fill in the adoptive mother's criminal records!");
			}
		}
		
		//��ʩŮ�����˲����Ⱥ���������ʾ������
		function _setFemaleIllegalact(obj){
			var val = obj.value;
			if(val == 0){
				$("#R_FEMALE_ILLEGALACT_EN").hide();
				$("#R_FEMALE_ILLEGALACT_EN").val("");
				$("#R_FEMALE_ILLEGALACT_EN").removeAttr("notnull");
			}else{
				$("#R_FEMALE_ILLEGALACT_EN").show();
				$("#R_FEMALE_ILLEGALACT_EN").attr("notnull","Please fill in the adoptive father's bad habits.");
			}
		}
		
		//������ʾ�������������˵Ľ���״������
		function _setMaleHealthContent(){
			var val = $("#R_MALE_HEALTH").find("option:selected").val();
			if(val == 2){
				$("#R_MALE_HEALTH_CONTENT_EN").show();
				$("#R_MALE_HEALTH_CONTENT_EN").attr("notnull","Please input the description of the adoptive father's health condition!");
			}else{
				$("#R_MALE_HEALTH_CONTENT_EN").hide();
				$("#R_MALE_HEALTH_CONTENT_EN").val("");
				$("#R_MALE_HEALTH_CONTENT_EN").removeAttr("notnull");
			}
		}
		
		//��ʩ��������Υ����Ϊ�����´�����������ʾ������
		function _setMalePunishment(obj){
			var val = obj.value;
			if(val == 0){
				$("#R_MALE_PUNISHMENT_EN").hide();
				$("#R_MALE_PUNISHMENT_EN").val("");
				$("#R_MALE_PUNISHMENT_EN").removeAttr("notnull");
			}else{
				$("#R_MALE_PUNISHMENT_EN").show();
				$("#R_MALE_PUNISHMENT_EN").attr("notnull","please fill in male adopter's illegal act and criminal penalty!");
			}
		}
		
		//��ʩ�������˲����Ⱥ���������ʾ������
		function _setMaleIllegalact(obj){
			var val = obj.value;
			if(val == 0){
				$("#R_MALE_ILLEGALACT_EN").hide();
				$("#R_MALE_ILLEGALACT_EN").val("");
				$("#R_MALE_ILLEGALACT_EN").removeAttr("notnull");
			}else{
				$("#R_MALE_ILLEGALACT_EN").show();
				$("#R_MALE_ILLEGALACT_EN").attr("notnull","Please fill in the adoptive father's bad habits.");
			}
		}
		
		//����ͬ��ʱ����������ʾ������
		function _setConabitaPartnersTime(obj){
			var val = obj.value;
			if(val == "0"){
				$("#conabita_partners_time1").hide();
				$("#conabita_partners_time2").hide();
				$("#R_CONABITA_PARTNERS_TIME").val("");
			}else{
				$("#conabita_partners_time1").show();
				$("#conabita_partners_time2").show();
			}
		}
		
		//���ݼ�ͥ���ʲ�����ծ����㾻�ʲ�
		function _setTotalManny(){
			var total_asset = $("#R_TOTAL_ASSET").val();	//���ʲ�
			var total_debt = $("#R_TOTAL_DEBT").val();	//��ծ��
			if(total_asset == ""){
				$("#TOTAL_MANNY").text("");
			}else{
				if(total_debt == ""){
					$("R_TOTAL_DEBT").val(0);
					$("R_TOTAL_DEBT").text(0);
					total_debt = 0;
				}
				$("#TOTAL_MANNY").text(total_asset - total_debt);
			}
		}
		
		//���ݳ������ڻ�ȡ��������
		function _getAge(strBirthday)
		{       
		    var returnAge;
		    var strBirthdayArr=strBirthday.split("-");
		    var birthYear = strBirthdayArr[0];
		    var birthMonth = strBirthdayArr[1];
		    var birthDay = strBirthdayArr[2];
		    
		    d = new Date();
		    var nowYear = d.getFullYear();
		    var nowMonth = d.getMonth() + 1;
		    var nowDay = d.getDate();
		    
		    if(nowYear == birthYear){
		        returnAge = 0;//ͬ�� ��Ϊ0��
		    }else{
		        var ageDiff = nowYear - birthYear ; //��֮��
		        if(ageDiff > 0){
		            if(nowMonth == birthMonth){
		                var dayDiff = nowDay - birthDay;//��֮��
		                if(dayDiff < 0){
		                    returnAge = ageDiff - 1;
		                }else{
		                    returnAge = ageDiff ;
		                }
		            }else{
		                var monthDiff = nowMonth - birthMonth;//��֮��
		                if(monthDiff < 0){
		                    returnAge = ageDiff - 1;
		                }else{
		                    returnAge = ageDiff ;
		                }
		            }
		        }else{
		            returnAge = -1;//����-1 ��ʾ��������������� ���ڽ���
		        }
		    }
		    return returnAge;//������������
		}
		
	</script>
	<BZ:body property="data" codeNames="GJ;ADOPTER_EDU;ADOPTER_HEALTH;ADOPTER_MARRYCOND;HBBZ;">
		<BZ:form name="srcForm" method="post" token="<%=token %>">
		<BZ:input prefix="R_" field="RI_ID" type="hidden" defaultValue="" />
		<!-- ��������begin -->
		<BZ:input type="hidden" prefix="R_" field="MALE_NAME" id="R_MALE_NAME" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="FEMALE_NAME" id="R_FEMALE_NAME" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="ADOPTER_SEX" id="R_ADOPTER_SEX" defaultValue=""/>
		<!-- ��������end -->
		<!-- �༭����begin -->
		<div class="bz-edit clearfix" desc="�༭����" style="width: 100%;">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- �������� begin -->
				<div class="ui-state-default bz-edit-title" desc="����">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>�����˻�����Ϣ(Information about the adoptive parents)</div>
				</div>
				<!-- �������� end -->
				<!-- �������� begin -->
				<div class="bz-edit-data-content clearfix" desc="������">
					<table class="bz-edit-data-table" border="0" id="femaleinfo">
						<tr>
							<td class="bz-edit-data-title" width="15%">��������<br>Name</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:dataValue field="FEMALE_NAME" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="15%">�Ա�<br>Sex</td>
							<td class="bz-edit-data-value" width="18%">Female</td>
							<td class="bz-edit-data-title" width="15%">&nbsp;</td>
							<td class="bz-edit-data-value" width="19%" rowspan="4">
								<up:uploadImage attTypeCode="AF" id="R_FEMALE_PHOTO" name="R_FEMALE_PHOTO" packageId='<%=(String)request.getAttribute("FEMALE_PHOTO") %>' autoUpload="true" imageStyle="width:100%;height:100%" hiddenProcess="false" proContainerStyle="width:50%;" hiddenList="true" smallType="<%=AttConstants.AF_FEMALEPHOTO %>"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">��������<br>D.O.B</td>
							<td class="bz-edit-data-value">
								<BZ:input prefix="R_" field="FEMALE_BIRTHDAY" id="R_FEMALE_BIRTHDAY" type="Date" formTitle="" defaultValue="" dateExtend="maxDate:'%y-%M-%d'" onchange="_setFemaleAge(this)"/>
							</td>
							<td class="bz-edit-data-title">����<br>Age</td>
							<td class="bz-edit-data-value">
								<span id="FEMALE_AGE"></span>
							</td>
							<td class="bz-edit-data-title" width="15%">&nbsp;</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title"><font color="red">*</font>����<br>Nationality</td>
							<td class="bz-edit-data-value">
								<BZ:select prefix="R_" field="FEMALE_NATION" id="R_FEMALE_NATION" formTitle="����" defaultValue="" isCode="true" codeName="GJ" isShowEN="true" width="70%">
									<BZ:option value="">--Please select--</BZ:option>
								</BZ:select>
							</td>
							<td class="bz-edit-data-title">���պ���<br>Passport No.</td>
							<td class="bz-edit-data-value">
								<BZ:input prefix="R_" field="FEMALE_PASSPORT_NO" id="R_FEMALE_PASSPORT_NO" formTitle="" defaultValue="" maxlength="100"/>
							</td>
							<td class="bz-edit-data-title" width="15%">&nbsp;</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title"><font color="red">*</font>�ܽ������<br>Education</td>
							<td class="bz-edit-data-value">
								<BZ:select prefix="R_" field="FEMALE_EDUCATION" id="R_FEMALE_EDUCATION" formTitle="" isCode="true" codeName="ADOPTER_EDU" isShowEN="true" defaultValue="" width="70%">
									<BZ:option value="">--Please select--</BZ:option>
								</BZ:select>
							</td>
							<td class="bz-edit-data-title"><font color="red">*</font>ְҵ<br>Occupation</td>
							<td class="bz-edit-data-value">
								<BZ:input prefix="R_" field="FEMALE_JOB_EN" id="R_FEMALE_JOB_EN" formTitle="" defaultValue="" maxlength="100"/>
							</td>
							<td class="bz-edit-data-title" width="15%">&nbsp;</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title"><font color="red">*</font>����״��<br>Health condition</td>
							<td class="bz-edit-data-value">
								<BZ:select prefix="R_" field="FEMALE_HEALTH" id="R_FEMALE_HEALTH" formTitle="" isCode="true" codeName="ADOPTER_HEALTH" isShowEN="true" defaultValue="" onchange="_setFemaleHealthContent()">
									<BZ:option value="">--Please select--</BZ:option>
								</BZ:select>
								<BZ:input prefix="R_" field="FEMALE_HEALTH_CONTENT_EN" id="R_FEMALE_HEALTH_CONTENT_EN" formTitle="" type="textarea" defaultValue="" maxlength="1000" style="display:none"/>
							</td>
							<td class="bz-edit-data-title"><font color="red">*</font>Υ����Ϊ�����´���<br>Criminal records</td>
							<td class="bz-edit-data-value">
								<BZ:radio prefix="R_" field="FEMALE_PUNISHMENT_FLAG" value="0" formTitle="" defaultChecked="true" onclick="_setFemalePunishment(this)">No</BZ:radio>
								<BZ:radio prefix="R_" field="FEMALE_PUNISHMENT_FLAG" value="1" formTitle="" onclick="_setFemalePunishment(this)">Yes</BZ:radio>
								<BZ:input prefix="R_" field="FEMALE_PUNISHMENT_EN" id="R_FEMALE_PUNISHMENT_EN" formTitle="" defaultValue="" type="textarea" maxlength="1000" style="display:none"/>
							</td>
							<td class="bz-edit-data-title"><font color="red">*</font>���޲����Ⱥ�<br>Any bad habits</td>
							<td class="bz-edit-data-value">
								<BZ:radio prefix="R_" field="FEMALE_ILLEGALACT_FLAG" value="0" formTitle="" defaultChecked="true" onclick="_setFemaleIllegalact(this)">No</BZ:radio>
								<BZ:radio prefix="R_" field="FEMALE_ILLEGALACT_FLAG" value="1" formTitle="" onclick="_setFemaleIllegalact(this)">Yes</BZ:radio>
								<BZ:input prefix="R_" field="FEMALE_ILLEGALACT_EN" id="R_FEMALE_ILLEGALACT_EN" formTitle="" defaultValue="" type="textarea" maxlength="500" style="display:none"/>
							</td>
						</tr>
					</table>
					<table class="bz-edit-data-table" border="0" id="maleinfo">
						<tr>
							<td class="bz-edit-data-title" width="15%">��������<br>Name</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:dataValue field="MALE_NAME" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="15%">�Ա�<br>Sex</td>
							<td class="bz-edit-data-value" width="18%">Male</td>
							<td class="bz-edit-data-title" width="15%">&nbsp;</td>
							<td class="bz-edit-data-value" width="19%" rowspan="4">
								<up:uploadImage attTypeCode="AF" id="R_MALE_PHOTO" name="R_MALE_PHOTO" packageId='<%=(String)request.getAttribute("MALE_PHOTO") %>' autoUpload="true" imageStyle="width:100%;height:100%" hiddenProcess="false" proContainerStyle="width:50%;" hiddenList="true" smallType="<%=AttConstants.AF_MALEPHOTO %>"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">��������<br>D.O.B</td>
							<td class="bz-edit-data-value">
								<BZ:input prefix="R_" field="MALE_BIRTHDAY" id="R_MALE_BIRTHDAY" type="Date" formTitle="" defaultValue="" dateExtend="maxDate:'%y-%M-%d'" onchange="_setMaleAge(this)"/>
							</td>
							<td class="bz-edit-data-title">����<br>Age</td>
							<td class="bz-edit-data-value">
								<span id="MALE_AGE"></span>
							</td>
							<td class="bz-edit-data-title" width="15%">&nbsp;</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title"><font color="red">*</font>����<br>Nationality</td>
							<td class="bz-edit-data-value">
								<BZ:select prefix="R_" field="MALE_NATION" id="R_MALE_NATION" formTitle="����" defaultValue="" isCode="true" codeName="GJ" isShowEN="true" width="70%">
									<BZ:option value="">--Please select--</BZ:option>
								</BZ:select>
							</td>
							<td class="bz-edit-data-title">���պ���<br>Passport No.</td>
							<td class="bz-edit-data-value">
								<BZ:input prefix="R_" field="MALE_PASSPORT_NO" id="R_MALE_PASSPORT_NO" formTitle="" defaultValue="" maxlength="100"/>
							</td>
							<td class="bz-edit-data-title" width="15%">&nbsp;</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title"><font color="red">*</font>�ܽ������<br>Education</td>
							<td class="bz-edit-data-value">
								<BZ:select prefix="R_" field="MALE_EDUCATION" id="R_MALE_EDUCATION" formTitle="" isCode="true" codeName="ADOPTER_EDU" isShowEN="true" defaultValue="" width="70%">
									<BZ:option value="">--Please select--</BZ:option>
								</BZ:select>
							</td>
							<td class="bz-edit-data-title"><font color="red">*</font>ְҵ<br>Occupation</td>
							<td class="bz-edit-data-value">
								<BZ:input prefix="R_" field="MALE_JOB_EN" id="R_MALE_JOB_EN" formTitle="" defaultValue="" maxlength="100"/>
							</td>
							<td class="bz-edit-data-title" width="15%">&nbsp;</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title"><font color="red">*</font>����״��<br>Health condition</td>
							<td class="bz-edit-data-value">
								<BZ:select prefix="R_" field="MALE_HEALTH" id="R_MALE_HEALTH" formTitle="" isCode="true" codeName="ADOPTER_HEALTH" isShowEN="true" defaultValue="" onchange="_setMaleHealthContent()">
									<BZ:option value="">--Please select--</BZ:option>
								</BZ:select>
								<BZ:input prefix="R_" field="MALE_HEALTH_CONTENT_EN" id="R_MALE_HEALTH_CONTENT_EN" formTitle="" type="textarea" defaultValue="" maxlength="1000" style="display:none"/>
							</td>
							<td class="bz-edit-data-title"><font color="red">*</font>Υ����Ϊ�����´���<br>Criminal records</td>
							<td class="bz-edit-data-value">
								<BZ:radio prefix="R_" field="MALE_PUNISHMENT_FLAG" value="0" formTitle="" defaultChecked="true" onclick="_setMALEPunishment(this)">��</BZ:radio>
								<BZ:radio prefix="R_" field="MALE_PUNISHMENT_FLAG" value="1" formTitle="" onclick="_setMALEPunishment(this)">��</BZ:radio>
								<BZ:input prefix="R_" field="MALE_PUNISHMENT_EN" id="R_MALE_PUNISHMENT_EN" formTitle="" defaultValue="" type="textarea" maxlength="1000" style="display:none"/>
							</td>
							<td class="bz-edit-data-title"><font color="red">*</font>���޲����Ⱥ�<br>Any bad habits</td>
							<td class="bz-edit-data-value">
								<BZ:radio prefix="R_" field="MALE_ILLEGALACT_FLAG" value="0" formTitle="" defaultChecked="true" onclick="_setMaleIllegalact(this)">��</BZ:radio>
								<BZ:radio prefix="R_" field="MALE_ILLEGALACT_FLAG" value="1" formTitle="" onclick="_setMALEIllegalact(this)">��</BZ:radio>
								<BZ:input prefix="R_" field="MALE_ILLEGALACT_EN" id="R_MALE_ILLEGALACT_EN" formTitle="" defaultValue="" type="textarea" maxlength="500" style="display:none"/>
							</td>
						</tr>
					</table>
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="15%"><font color="red">*</font>����״��<br>Marital status</td>
							<td class="bz-edit-data-value" width="17%">
								<BZ:select prefix="R_" field="MARRY_CONDITION" id="R_MARRY_CONDITION" formTitle="" defaultValue="" isCode="true" codeName="ADOPTER_MARRYCOND" isShowEN="true" notnull="Please select the Marital status!" width="72%">
									<BZ:option value="">--Please select--</BZ:option>
								</BZ:select>
							</td>
							<td class="bz-edit-data-title" width="15%"><font color="red">*</font>ͬ�ӻ��<br>Cohabitant partner</td>
							<td class="bz-edit-data-value" width="17%">
								<BZ:radio prefix="R_" field="CONABITA_PARTNERS" value="0" formTitle="" defaultChecked="true" onclick="_setConabitaPartnersTime(this)">No</BZ:radio>
								<BZ:radio prefix="R_" field="CONABITA_PARTNERS" value="1" formTitle="" onclick="_setConabitaPartnersTime(this)">Yes</BZ:radio>
							</td>
							<td class="bz-edit-data-title" width="15%" id="conabita_partners_time1" style="display:none">ͬ��ʱ��<br>Cohabitation period</td>
							<td class="bz-edit-data-value" width="21%" id="conabita_partners_time2" style="display:none">
								<BZ:input prefix="R_" field="CONABITA_PARTNERS_TIME" id="R_CONABITA_PARTNERS_TIME" formTitle="" defaultValue="" restriction="number" maxlength="22" />��(Year)
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title"><font color="red">*</font>��ͬ��������<br>Non-Homosexual statement</td>
							<td class="bz-edit-data-value">
								<BZ:radio prefix="R_" field="GAY_STATEMENT" value="0" formTitle="" defaultChecked="true">No</BZ:radio>
								<BZ:radio prefix="R_" field="GAY_STATEMENT" value="1" formTitle="" >Yes</BZ:radio>
							</td>
							<td class="bz-edit-data-title"><font color="red">*</font>���ҵ�λ<br>Currency</td>
							<td class="bz-edit-data-value">
								<BZ:select prefix="R_" field="CURRENCY" id="R_CURRENCY" formTitle="" defaultValue="" isCode="true" codeName="HBBZ"  isShowEN="true" notnull="Please select the Currency Unit!" width="72%">
									<BZ:option value="">--Please select--</BZ:option>
								</BZ:select>
							</td>
							<td class="bz-edit-data-title"><font color="red">*</font>������<br>Annual income</td>
							<td class="bz-edit-data-value">
								<BZ:input prefix="R_" field="FEMALE_YEAR_INCOME" id="R_FEMALE_YEAR_INCOME" formTitle="" defaultValue="" restriction="number" maxlength="22"/>
								<BZ:input prefix="R_" field="MALE_YEAR_INCOME" id="R_MALE_YEAR_INCOME" formTitle="" defaultValue="" restriction="number" maxlength="22"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title"><font color="red">*</font>��ͥ���ʲ�<br>Assets</td>
							<td class="bz-edit-data-value">
								<BZ:input prefix="R_" field="TOTAL_ASSET" id="R_TOTAL_ASSET" formTitle="" defaultValue="" restriction="int" notnull="Please write the asset of family!" onblur="_setTotalManny()"/>
							</td>
							<td class="bz-edit-data-title"><font color="red">*</font>��ͥ��ծ��<br>Debts</td>
							<td class="bz-edit-data-value">
								<BZ:input prefix="R_" field="TOTAL_DEBT" id="R_TOTAL_DEBT" formTitle="" defaultValue="" restriction="int" notnull="Please write the debt of family!" onblur="_setTotalManny()"/>
							</td>
							<td class="bz-edit-data-title">��ͥ���ʲ�<br>Net assets</td>
							<td class="bz-edit-data-value">
								<span id="TOTAL_MANNY"></span>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title"><font color="red">*</font>18����������Ů����<br>Number and age of children under 18 years old</td>
							<td class="bz-edit-data-value">
								<BZ:input prefix="R_" field="UNDERAGE_NUM" id="R_UNDERAGE_NUM" formTitle="" defaultValue="" restriction="int" notnull="Please write the number and age of children under 18 years old!" />��
							</td>
							<td class="bz-edit-data-title">&nbsp;</td>
							<td class="bz-edit-data-value">&nbsp;</td>
							<td class="bz-edit-data-title">&nbsp;</td>
							<td class="bz-edit-data-value">&nbsp;</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title"><font color="red">*</font>��Ů���������<br>Number of children</td>
							<td class="bz-edit-data-value" colspan="5">
								<BZ:input prefix="R_" field="CHILD_CONDITION_EN" id="R_CHILD_CONDITION_EN" formTitle="" defaultValue="" type="textarea" notnull="Please write the number of children!" maxlength="1000" style="width:80%"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title"><font color="red">*</font>��ͥסַ<br>Address</td>
							<td class="bz-edit-data-value" colspan="5">
								<BZ:input prefix="R_" field="ADDRESS" id="R_ADDRESS" formTitle="" defaultValue="" notnull="Please write the family address!" maxlength="500" style="width:80%"/>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<!-- �༭����end -->
		<!-- ��ť����begin -->
		<div class="bz-action-frame">
			<div class="bz-action-edit" desc="��ť��">
				<input type="button" value="Save" class="btn btn-sm btn-primary" onclick="_save()"/>
				<input type="button" value="Close" class="btn btn-sm btn-primary" onclick="window.close();"/>
			</div>
		</div>
		<!-- ��ť����end -->
		</BZ:form>
	</BZ:body>
</BZ:html>