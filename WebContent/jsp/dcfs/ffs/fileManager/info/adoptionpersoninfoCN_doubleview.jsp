<%
/**   
 * @Title: adoptionpersoninfoCN_doubleview.jsp
 * @Description:  收养人基本信息
 * @author yangrt   
 * @date 2014-9-14 上午11:42:34 
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="com.dcfs.common.atttype.AttConstants" %>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ taglib uri="/WEB-INF/upload-tag/upload" prefix="up"%>
<%
	String path = request.getContextPath();
	String af_id = (String)request.getAttribute("AF_ID");
%>
<BZ:html>
	<BZ:head>
		<title>收养人基本信息</title>
		<up:uploadResource isImage="true" cancelJquerySupport="true"/>
		<BZ:webScript edit="true"/>
		<style>
			.base .bz-edit-data-title{
				line-height:20px;
			}
		</style>
		<script type="text/javascript">
		$(document).ready(function() {
			setSigle();
			dyniframesize(['iFrame']);
			/* 初始化查看页面数据   */
			//根据男、女收养人的出生日期计算其年龄
			var male_birth = $("#R_MALE_BIRTHDAY").val();
			var female_birth = $("#R_FEMALE_BIRTHDAY").val();
			if(male_birth != ""){
				$("#MALE_AGE").text(_getAge(male_birth));
			}
			if(female_birth != ""){
				$("#FEMALE_AGE").text(_getAge(female_birth));
			}
			
			
			//初始化健康说明
			var male_health = $("#R_MALE_HEALTH").val();
			var female_health = $("#R_FEMALE_HEALTH").val();
			if(male_health == "2"){
				$("#MALE_HEALTH_CONTENT").text($("#R_MALE_HEALTH_CONTENT_CN").val());
			}
			if(female_health == "2"){
				$("#FEMALE_HEALTH_CONTENT").text($("#R_FEMALE_HEALTH_CONTENT_CN").val());
			}
			
			//初始化身高体重的显示方式
			var measurement = $("#R_MEASUREMENT").val();
			var male_height = $("#R_MALE_HEIGHT").val();	//男收养人身高
			var female_height = $("#R_FEMALE_HEIGHT").val();	//女收养人身高
			if(measurement == "0"){
				$("#MALE_HEIGHT_INCH").hide();
				$("#MALE_HEIGHT_METRE").show();
				$("#FEMALE_HEIGHT_INCH").hide();
				$("#FEMALE_HEIGHT_METRE").show();
				$("#MALE_WEIGHT_POUNDS").hide();
				$("#MALE_WEIGHT_KILOGRAM").show();
				$("#FEMALE_WEIGHT_POUNDS").hide();
				$("#FEMALE_WEIGHT_KILOGRAM").show();
				
			}else{
				$("#MALE_HEIGHT_INCH").show();
				$("#MALE_HEIGHT_METRE").hide();
				$("#FEMALE_HEIGHT_INCH").show();
				$("#FEMALE_HEIGHT_METRE").hide();
				$("#MALE_WEIGHT_POUNDS").show();
				$("#MALE_WEIGHT_KILOGRAM").hide();
				$("#FEMALE_WEIGHT_POUNDS").show();
				$("#FEMALE_WEIGHT_KILOGRAM").hide();
				
				var maletempfeet = parseInt(male_height) / 30.48 + "";
				var malefeet = maletempfeet.split(".")[0];
				var maleinch = maletempfeet.split(".")[1] * 12;
				$("#MALE_HEIGHT_INCH").text(malefeet + " 英尺(Feet)" + maleinch + " 英寸(Inch)");
				
				var femaletempfeet = parseInt(female_height) / 30.48 + "";
				var femalefeet = femaletempfeet.split(".")[0];
				var femaleinch = femaletempfeet.split(".")[1] * 12;
				$("#FEMALE_HEIGHT_INCH").text(femalefeet + " 英尺(Feet)" + femaleinch + " 英寸(Inch)");
				
				var male_weight = $("#R_MALE_WEIGHT").val();	//男收养人体重
				var female_weight = $("#R_FEMALE_WEIGHT").val();	//女收养人体重
				$("#R_MALE_WEIGHT").text(parseFloat(parseInt(male_weight) / 0.45359237).toFixed(2));
				$("#R_FEMALE_WEIGHT").text(parseFloat(parseInt(female_weight) / 0.45359237).toFixed(2));
			}
			
			//违法行为及刑事处罚
			var male_punishment_flag = $("#R_MALE_PUNISHMENT_FLAG").val();
			var female_punishment_flag = $("#R_FEMALE_PUNISHMENT_FLAG").val();
			if(male_punishment_flag == "1"){
				$("#R_MALE_PUNISHMENT_CN").show();
				$("#R_MALE_PUNISHMENT").hide();
			}else{
				$("#R_MALE_PUNISHMENT_CN").hide();
				$("#R_MALE_PUNISHMENT").show();
			}
			if(female_punishment_flag == "1"){
				$("#R_FEMALE_PUNISHMENT_CN").show();
				$("#R_FEMALE_PUNISHMENT").hide();
			}else{
				$("#R_FEMALE_PUNISHMENT_CN").hide();
				$("#R_FEMALE_PUNISHMENT").show();
			}
			
			//不良嗜好
			var male_illegalact_flag = $("#R_MALE_ILLEGALACT_FLAG").val();
			var female_illegalact_flag = $("#R_FEMALE_ILLEGALACT_FLAG").val();
			if(male_illegalact_flag == "1"){
				$("#R_MALE_ILLEGALACT_CN").show();
				$("#R_MALE_ILLEGALACT").hide();
			}else{
				$("#R_MALE_ILLEGALACT_CN").hide();
				$("#R_MALE_ILLEGALACT").show();
			}
			if(female_illegalact_flag == "1"){
				$("#R_FEMALE_ILLEGALACT_CN").show();
				$("#R_FEMALE_ILLEGALACT").hide();
			}else{
				$("#R_FEMALE_ILLEGALACT_CN").hide();
				$("#R_FEMALE_ILLEGALACT").show();
			}
			
			//结婚时长
			var marry_date = $("#R_MARRY_DATE").val();
			$("#MARRY_LENGTH").text(_getAge(marry_date));
			
			//家庭净资产
			var total_asset = $("#R_TOTAL_ASSET").val();
			var total_debt = $("#R_TOTAL_DEBT").val();
			$("#TOTAL_MANNY").text(total_asset - total_debt);
			
		});
		//根据出生日期获取周岁年龄
		function _getAge(strBirthday){     
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
		        returnAge = 0;//同年 则为0岁
		    }else{
		        var ageDiff = nowYear - birthYear ; //年之差
		        if(ageDiff > 0){
		            if(nowMonth == birthMonth){
		                var dayDiff = nowDay - birthDay;//日之差
		                if(dayDiff < 0){
		                    returnAge = ageDiff - 1;
		                }else{
		                    returnAge = ageDiff ;
		                }
		            }else{
		                var monthDiff = nowMonth - birthMonth;//月之差
		                if(monthDiff < 0){
		                    returnAge = ageDiff - 1;
		                }else{
		                    returnAge = ageDiff ;
		                }
		            }
		        }else{
		            returnAge = -1;//返回-1 表示出生日期输入错误 晚于今天
		        }
		    }
		    return returnAge;//返回周岁年龄
		}
		</script>
	</BZ:head>
	<BZ:body property="data" codeNames="SYLX;WJLX;SDFS;GJ;ADOPTER_EDU;ADOPTER_HEALTH;HBBZ;">
	<!-- 隐藏区域begin -->
	<BZ:input type="hidden" prefix="R_" field="MALE_BIRTHDAY" id="R_MALE_BIRTHDAY" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="FEMALE_BIRTHDAY" id="R_FEMALE_BIRTHDAY" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="MALE_HEALTH" id="R_MALE_HEALTH" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="FEMALE_HEALTH" id="R_FEMALE_HEALTH" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="MALE_HEALTH_CONTENT_CN" id="R_MALE_HEALTH_CONTENT_CN" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="FEMALE_HEALTH_CONTENT_CN" id="R_FEMALE_HEALTH_CONTENT_CN" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="MEASUREMENT" id="R_MEASUREMENT" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="MALE_HEIGHT" id="R_MALE_HEIGHT" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="FEMALE_HEIGHT" id="R_FEMALE_HEIGHT" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="MALE_WEIGHT" id="R_MALE_WEIGHT" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="FEMALE_WEIGHT" id="R_FEMALE_WEIGHT" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="MALE_PUNISHMENT_FLAG" id="R_MALE_PUNISHMENT_FLAG" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="FEMALE_PUNISHMENT_FLAG" id="R_FEMALE_PUNISHMENT_FLAG" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="MALE_ILLEGALACT_FLAG" id="R_MALE_ILLEGALACT_FLAG" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="FEMALE_ILLEGALACT_FLAG" id="R_FEMALE_ILLEGALACT_FLAG" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="MARRY_DATE" id="R_MARRY_DATE" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="TOTAL_ASSET" id="R_TOTAL_ASSET" defaultValue=""/>
	<BZ:input type="hidden" prefix="R_" field="TOTAL_DEBT" id="R_TOTAL_DEBT" defaultValue=""/>
	<!-- 隐藏区域end -->
	<!-- 编辑区域begin -->
		<div class="bz-edit clearfix" desc="查看区域" style="width: 100%">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- 标题区域 begin -->
				<div class="ui-state-default bz-edit-title" desc="标题">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>收养人基本信息(Information about the adoptive parents)</div>
				</div>
				<!-- 标题区域 end -->
				<!-- 内容区域 begin -->
				<div class="bz-edit-data-content clearfix" desc="内容体">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="16%">&nbsp;</td>
							<td class="bz-edit-data-title" colspan="2" style="text-align:center">男收养人(Adoptive father)</td>
							<td class="bz-edit-data-title" colspan="2" style="text-align:center">女收养人(Adoptive mother)</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">外文姓名<br>Name</td>
							<td class="bz-edit-data-value" colspan="2">
								<BZ:dataValue field="MALE_NAME" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-value" colspan="2">
								<BZ:dataValue field="FEMALE_NAME" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" width="16%">出生日期<br>D.O.B</td>
							<td class="bz-edit-data-value" width="24%">
								<BZ:dataValue field="MALE_BIRTHDAY" type="Date" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-value" width="20%" rowspan="4">
								<input type="image" src='<up:attDownload attTypeCode="AF" packageId='<%=(String)request.getAttribute("MALE_PHOTO") %>' smallType="<%=AttConstants.AF_MALEPHOTO %>"/>' style="width:150px;height:160px;"/>
							</td>
							<td class="bz-edit-data-value" width="24%">
								<BZ:dataValue field="FEMALE_BIRTHDAY" type="Date" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-value" width="16%" rowspan="4">
								<input type="image" src='<up:attDownload attTypeCode="AF" packageId='<%=(String)request.getAttribute("FEMALE_PHOTO") %>' smallType="<%=AttConstants.AF_FEMALEPHOTO %>"/>' style="width:150px;height:160px;"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">年龄<br>Age</td>
							<td class="bz-edit-data-value">
								<span id="MALE_AGE"></span>
							</td>
							<td class="bz-edit-data-value">
								<span id="FEMALE_AGE"></span>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">国籍<br>Nationality</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="MALE_NATION" codeName="GJ" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="FEMALE_NATION" codeName="GJ" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">护照号码<br>Passport No.</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="MALE_PASSPORT_NO" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="FEMALE_PASSPORT_NO" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">受教育情况<br>Education</td>
							<td class="bz-edit-data-value" colspan="2">
								<BZ:dataValue field="MALE_EDUCATION" codeName="ADOPTER_EDU" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-value" colspan="2">
								<BZ:dataValue field="FEMALE_EDUCATION" codeName="ADOPTER_EDU" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">职业<br>Occupation</td>
							<td class="bz-edit-data-value" colspan="2">
								<BZ:dataValue field="MALE_JOB_CN" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-value" colspan="2">
								<BZ:dataValue field="FEMALE_JOB_CN" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">健康状况<br>Health condition</td>
							<td class="bz-edit-data-value" colspan="2">
								<BZ:dataValue field="MALE_HEALTH" codeName="ADOPTER_HEALTH" defaultValue="" onlyValue="true"/>&nbsp;&nbsp;
								<span id="MALE_HEALTH_CONTENT"></span>
							</td>
							<td class="bz-edit-data-value" colspan="2">
								<BZ:dataValue field="FEMALE_HEALTH" codeName="ADOPTER_HEALTH" defaultValue="" onlyValue="true"/>&nbsp;&nbsp;
								<span id="FEMALE_HEALTH_CONTENT"></span>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">身高<br>Height</td>
							<td class="bz-edit-data-value" colspan="2">
								<BZ:dataValue field="MEASUREMENT" checkValue="0=公制;1=英制;" defaultValue="" onlyValue="true"/>
								<span id="MALE_HEIGHT_INCH"></span>
								<span id="MALE_HEIGHT_METRE">
									<BZ:dataValue field="MALE_HEIGHT" defaultValue="" onlyValue="true"/>厘米
								</span>
							</td>
							<td class="bz-edit-data-value" colspan="2">
								<span id="FEMALE_HEIGHT_INCH"></span>
								<span id="FEMALE_HEIGHT_METRE">
									<BZ:dataValue field="FEMALE_HEIGHT" defaultValue="" onlyValue="true"/>厘米
								</span>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">体重<br>Weight</td>
							<td class="bz-edit-data-value" colspan="2">
								<BZ:dataValue field="MALE_WEIGHT" defaultValue="" onlyValue="true"/>
								<span id="MALE_WEIGHT_POUNDS" style="display: none">磅(Pound)</span>
								<span id="MALE_WEIGHT_KILOGRAM" style="display: none">千克</span>
							</td>
							<td class="bz-edit-data-value" colspan="2">
								<BZ:dataValue field="FEMALE_WEIGHT" defaultValue="" onlyValue="true"/>
								<span id="FEMALE_WEIGHT_POUNDS">磅(Pound)</span>
								<span id="FEMALE_WEIGHT_KILOGRAM">千克</span>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">体重指数<br>BMI</td>
							<td class="bz-edit-data-value" colspan="2">
								<BZ:dataValue field="MALE_BMI" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-value" colspan="2">
								<BZ:dataValue field="FEMALE_BMI" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">违法行为及刑事处罚<br>Criminal records</td>
							<td class="bz-edit-data-value" colspan="2">
								<span id="R_MALE_PUNISHMENT">
									<BZ:dataValue field="MALE_PUNISHMENT_FLAG" checkValue="0=无;1=有;" defaultValue="" onlyValue="true"/>
								</span>
								<span id="R_MALE_PUNISHMENT_CN">
									<BZ:dataValue field="MALE_PUNISHMENT_CN" defaultValue="" onlyValue="true"/>
								</span>
							</td>
							<td class="bz-edit-data-value" colspan="2">
								<span id="R_FEMALE_PUNISHMENT">
									<BZ:dataValue field="FEMALE_PUNISHMENT_FLAG" checkValue="0=无;1=有;" defaultValue="" onlyValue="true"/>
								</span>
								<span id="R_FEMALE_PUNISHMENT_CN">
									<BZ:dataValue field="FEMALE_PUNISHMENT_CN" defaultValue="" onlyValue="true"/>
								</span>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">有无不良嗜好<br>Any bad habits</td>
							<td class="bz-edit-data-value" colspan="2">
								<span id="R_MALE_ILLEGALACT">
									<BZ:dataValue field="MALE_ILLEGALACT_FLAG" checkValue="0=无;1=有;" defaultValue="" onlyValue="true"/>
								</span>
								<span id="R_MALE_ILLEGALACT_CN">
									<BZ:dataValue field="MALE_ILLEGALACT_CN" defaultValue="" onlyValue="true"/>
								</span>
							</td>
							<td class="bz-edit-data-value" colspan="2">
								<span id="R_FEMALE_ILLEGALACT">
									<BZ:dataValue field="FEMALE_ILLEGALACT_FLAG" checkValue="0=无;1=有;" defaultValue="" onlyValue="true"/>
								</span>
								<span id="R_FEMALE_ILLEGALACT_CN">
									<BZ:dataValue field="FEMALE_ILLEGALACT_CN" defaultValue="" onlyValue="true"/>
								</span>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">宗教信仰<br>Religious belief</td>
							<td class="bz-edit-data-value" colspan="2">
								<BZ:dataValue field="MALE_RELIGION_CN" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-value" colspan="2">
								<BZ:dataValue field="FEMALE_RELIGION_CN" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">前婚次数<br>Number of previous marriages</td>
							<td class="bz-edit-data-value" colspan="2">
								<BZ:dataValue field="MALE_MARRY_TIMES" defaultValue="" onlyValue="true"/>次
							</td>
							<td class="bz-edit-data-value" colspan="2">
								<BZ:dataValue field="FEMALE_MARRY_TIMES" defaultValue="" onlyValue="true"/>次
							</td>
						</tr>
					</table>
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="15%">婚姻状况</td>
							<td class="bz-edit-data-value" width="18%">已婚</td>
							<td class="bz-edit-data-title" width="15%">结婚日期<br>Date of the present marriage </td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:dataValue field="MARRY_DATE" defaultValue="" type="Date" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="15%">婚姻时长<br>Length of the present marriage</td>
							<td class="bz-edit-data-value" width="19%">
								<span id="MARRY_LENGTH"></span>年(Year)
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">货币单位<br>Currency</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="CURRENCY" codeName="HBBZ" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title">男收养人年收入<br>Annual income</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="MALE_YEAR_INCOME" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title">女收养人年收入<br>Annual income</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="FEMALE_YEAR_INCOME" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" width="15%">家庭总资产<br>Asset</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:dataValue field="TOTAL_ASSET" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="15%">家庭总债务<br>Debt</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:dataValue field="TOTAL_DEBT" defaultValue="" onlyValue="true"/>
							</td>
							<td class="bz-edit-data-title" width="15%">家庭净资产<br>Net assets</td>
							<td class="bz-edit-data-value" width="19%">
								<span id="TOTAL_MANNY"></span>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" width="15%">18周岁以下子女数量<br>Number and age of children under 18 years old</td>
							<td class="bz-edit-data-value" width="18%">
								<BZ:dataValue field="UNDERAGE_NUM" defaultValue="" onlyValue="true"/>&nbsp;个</td>
							<td class="bz-edit-data-title" width="15%">&nbsp;</td>
							<td class="bz-edit-data-value" width="18%">&nbsp;</td>
							<td class="bz-edit-data-title" width="15%">&nbsp;</td>
							<td class="bz-edit-data-value" width="19%">&nbsp;</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" width="15%">子女数量及情况<br>Number of children</td>
							<td class="bz-edit-data-value" colspan="5">
								<BZ:dataValue field="CHILD_CONDITION_CN" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" width="15%">家庭住址<br>Address</td>
							<td class="bz-edit-data-value" colspan="5">
								<BZ:dataValue field="ADDRESS" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" width="15%">收养要求<br>Adoption preference</td>
							<td class="bz-edit-data-value" colspan="5">
								<BZ:dataValue field="ADOPT_REQUEST_CN" defaultValue="" onlyValue="true"/>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<div class="bz-edit clearfix" desc="编辑区域">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- 标题区域 begin -->
				<div class="ui-state-default bz-edit-title" desc="标题">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>附件信息</div>
				</div>
				<!-- 标题区域 end -->
				<!-- 内容区域 begin -->
				<div class="bz-edit-data-content clearfix" desc="内容体">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-value">
								<IFRAME ID="frmUpload" SRC="<%=path%>/common/batchattmaintain.action?bigType=AF&packID=<%=AttConstants.AF_PARENTS%>&packageID=<%=af_id %>" frameborder=0 width="100%" ></IFRAME>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</BZ:body>
</BZ:html>