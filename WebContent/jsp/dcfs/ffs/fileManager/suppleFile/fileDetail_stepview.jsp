<%
/**   
 * @Title: fileDetail_stepview.jsp
 * @Description:  文件详细信息查看页面
 * @author yangrt   
 * @date 2014-9-11 上午11:03:34 
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="hx.database.databean.Data"%>
<%@ page import="com.dcfs.common.atttype.AttConstants" %>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%
	String package_id = (String)request.getAttribute("PACKAGE_ID");
%>
<BZ:html>
	<BZ:head language="CN">
		<title>文件详细信息查看页面</title>
		<BZ:webScript edit="true"/>
		<up:uploadResource isImage="true"/>
		<style>
			.base .bz-edit-data-title{
				line-height:20px;
			}
		</style>
	</BZ:head>
	<script>
		$(document).ready(function() {
			//根据性别判断要显示的信息
			var sex_flag = $("#R_ADOPTER_SEX").val();
			if(sex_flag == "0"){
				$(".male").show();
				$(".female").hide();
				
				//设置男收养人的显示年龄
				var male_birth = $("#R_MALE_BIRTHDAY").val();
				if(male_birth != ""){
					$("#MALE_AGE").text(_getAge(male_birth));
				}
				
			}else{
				$(".female").show();
				$(".male").hide();
				
				//设置女收养人的显示年龄
				var female_birth = $("#R_FEMALE_BIRTHDAY").val();
				if(female_birth != ""){
					$("#FEMALE_AGE").text(_getAge(female_birth));
				}
				
			}
			
			//有效期限
			var valid_period = $("#R_VALID_PERIOD").val();
			if(valid_period != "-1"){
				$("#R_PERIOD").text(valid_period + " 月(Month)");
			}else{
				$("#R_PERIOD").text("长期");
			}
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
	<BZ:body property="filedata" codeNames="WJLX;SYLX;GJ;ETXB;BCZL;WJSHYJ;">
		<!-- 隐藏区域begin -->
		<BZ:input type="hidden" prefix="R_" field="MALE_BIRTHDAY" id="R_MALE_BIRTHDAY" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="FEMALE_BIRTHDAY" id="R_FEMALE_BIRTHDAY" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="VALID_PERIOD" id="R_VALID_PERIOD" defaultValue=""/>
		<BZ:input type="hidden" prefix="R_" field="ADOPTER_SEX" id="R_ADOPTER_SEX" defaultValue=""/>
		<!-- 隐藏区域end -->
		<!-- 编辑区域begin -->
		<div class="bz-edit clearfix" desc="查看区域" style="width: 100%">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- 内容区域 begin -->
				<div class="bz-edit-data-content clearfix" desc="内容体">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="20%">收养组织(CN)<br>Agency(CN)</td>
							<td class="bz-edit-data-value" colspan="3">
								<BZ:dataValue field="NAME_CN" hrefTitle="收养组织(CN)" defaultValue="" />
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" width="20%">收养组织(EN)<br>Agency(EN)</td>
							<td class="bz-edit-data-value" colspan="3">
								<BZ:dataValue field="NAME_EN" hrefTitle="收养组织(EN)" defaultValue="" />
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" width="20%">文件类型<br>Document type</td>
							<td class="bz-edit-data-value" width="30%">
								<BZ:dataValue field="FILE_TYPE" codeName="WJLX" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title" width="20%">收养类型<br>Adoption type</td>
							<td class="bz-edit-data-value" width="30%">
								<BZ:dataValue field="FAMILY_TYPE" codeName="SYLX" defaultValue=""/>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<div class="bz-edit clearfix" desc="编辑区域" style="width: 100%">
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
							<td class="bz-edit-data-title" width="15%">外文姓名<br>Name</td>
							<td class="bz-edit-data-value" width="25%">
								<span class="male"><BZ:dataValue field="MALE_NAME" defaultValue=""/></span>
								<span class="female"><BZ:dataValue field="FEMALE_NAME" defaultValue=""/></span>
							</td>
							<td class="bz-edit-data-title" width="15%">性别<br>Sex</td>
							<td class="bz-edit-data-value" width="25%">
								<BZ:dataValue field="SEX_FLAG" checkValue="0=Male;1=Female;" defaultValue=""/>
							</td>
							<td class="bz-edit-data-value" width="20%" rowspan="4">
								<span class="male"><img src='<up:attDownload attTypeCode="AF" packageId="<%=(String)request.getAttribute("MALE_PHOTO") %>" smallType="<%=AttConstants.AF_MALEPHOTO %>"/>'/></span>
								<span class="female"><img src='<up:attDownload attTypeCode="AF" packageId="<%=(String)request.getAttribute("MALE_PHOTO") %>" smallType="<%=AttConstants.AF_FEMALEPHOTO %>"/>'/></span>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">出生日期<br>D.O.B</td>
							<td class="bz-edit-data-value">
								<span class="male"><BZ:dataValue field="MALE_BIRTHDAY" type="Date" defaultValue=""/></span>
								<span class="female"><BZ:dataValue field="FEMALE_BIRTHDAY" type="Date" defaultValue=""/></span>
							</td>
							<td class="bz-edit-data-title">年龄<br>Age</td>
							<td class="bz-edit-data-value">
								<span id="MALE_AGE"></span>
								<span id="FEMALE_AGE"></span>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">国籍<br>Nationality</td>
							<td class="bz-edit-data-value">
								<span class="male"><BZ:dataValue field="MALE_NATION" defaultValue="" codeName="GJ"/></span>
								<span class="female"><BZ:dataValue field="FEMALE_NATION" defaultValue="" codeName="GJ"/></span>
							</td>
							<td class="bz-edit-data-title">护照号码<br>Passport No.</td>
							<td class="bz-edit-data-value">
								<span class="male"><BZ:dataValue field="MALE_PASSPORT_NO" defaultValue=""/></span>
								<span class="female"><BZ:dataValue field="FEMALE_PASSPORT_NO" defaultValue=""/></span>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title">婚姻状况<br>Marital status</td>
							<td class="bz-edit-data-value">Married</td>
							<td class="bz-edit-data-title">结婚日期<br>Date of the present marriage</td>
							<td class="bz-edit-data-value">
								<BZ:dataValue field="MARRY_DATE" defaultValue="" type="Date"/>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<div class="bz-edit clearfix" desc="编辑区域" style="width: 100%">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- 标题区域 begin -->
				<div class="ui-state-default bz-edit-title" desc="标题">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>政府批准信息(Government approval information)</div>
				</div>
				<!-- 标题区域 end -->
				<!-- 内容区域 begin -->
				<div class="bz-edit-data-content clearfix" desc="内容体">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="20%">批准日期<br>Date of Approval</td>
							<td class="bz-edit-data-value" width="30%">
								<BZ:dataValue field="GOVERN_DATE" type="Date" defaultValue=""/>
							</td>
							<td class="bz-edit-data-title" width="20%">有效期限<br>Validity period</td>
							<td class="bz-edit-data-value" width="30%">
								<span id="R_PERIOD"></span>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<div class="bz-edit clearfix" desc="编辑区域" style="width: 100%">
			<div class="ui-widget-content ui-corner-all bz-edit-warper">
				<!-- 标题区域 begin -->
				<div class="ui-state-default bz-edit-title" desc="标题">
					<div class="bz-editbz-action-title-prefix ui-icon-stop"></div>
					<div>附件信息(Attachment)</div>
				</div>
				<!-- 标题区域 end -->
				<!-- 内容区域 begin -->
				<div class="bz-edit-data-content clearfix" desc="内容体">
					<table class="bz-edit-data-table" border="0">
						<tr>
							<td class="bz-edit-data-title" width="15%">跨国收养申请书<br>Inter-country adoption application</td>
							<td class="bz-edit-data-value" width="35%">
								<up:uploadList attTypeCode="AF" id="R_ADOPTION_APPLICATION" packageId="<%=package_id %>" smallType="<%=AttConstants.AF_KGSY %>"/>
							</td>
							<td class="bz-edit-data-title" width="15%">出生证明<br>Birth certificate</td>
							<td class="bz-edit-data-value" width="35%">
								<up:uploadList attTypeCode="AF" id="R_BIRTH_CERTIFICATE" packageId="<%=package_id %>" smallType="<%=AttConstants.AF_CSZM %>"/>
							</td>
						</tr>
						<tr>
							<td class="bz-edit-data-title" width="15%">婚姻状况证明<br>Marital status certificate</td>
							<td class="bz-edit-data-value" width="35%">
								<up:uploadList attTypeCode="AF" id="R_MARITAL_STATUS" packageId="<%=package_id %>" smallType="<%=AttConstants.AF_HYZK %>"/>
							</td>
							<td class="bz-edit-data-title" width="15%">收养申请人所在国主管机关同意其跨国收养子女的证明<br>Approval letter of adoption from the competent authority of receiving country</td>
							<td class="bz-edit-data-value" width="35%">
								<up:uploadList attTypeCode="AF" id="R_INTERCOUNTRY_ADOPTION" packageId="<%=package_id %>" smallType="<%=AttConstants.AF_KGSYZM %>"/>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<!-- 编辑区域end -->
	</BZ:body>
</BZ:html>