<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@page import="hx.database.databean.Data"%>
<%
	/**   
	 * @Title: childAddition_list_fly.jsp
	 * @Description:  儿童材料补充列表(福利院)
	 * @author furx   
	 * @date 2014-9-4 上午12:12:34 
	 * @version V1.0   
	 */
	 //1 获取排序字段、排序类型(ASC DESC)
	String compositor=(String)request.getAttribute("compositor");
	if(compositor==null){
		compositor="";
	}
	String ordertype=(String)request.getAttribute("ordertype");
	if(ordertype==null){
		ordertype="";
	}
	Data da = (Data)request.getAttribute("data");
	String WELFARE_ID=da.getString("WELFARE_ID","");
%>
<BZ:html>
	<BZ:head>
		<title>儿童材料更新列表(省厅)</title>
		<BZ:webScript list="true" isAjax="true"/>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/page.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
	</BZ:head>
	<script>
		$(document).ready(function() {
			dyniframesize(['mainFrame']);
			initProvOrg();
		});
		//显示查询条件
		function _showSearch(){
			$.layer({
				type : 1,
				title : "查询条件",
				shade : [0.5 , '#D9D9D9' , true],
				border :[2 , 0.3 , '#000', true],
				page : {dom : '#searchDiv'},
				area: ['900px','220px'],
				offset: ['40px' , '0px'],
				closeBtn: [0, true]
			});
		}
		//执行按条件查询操作
		function _search(){
			document.srcForm.action=path+"cms/childupdate/updateAuditListZX.action?page=1";
			document.srcForm.submit();
		}
		//执行重置查询条件操作
		function _reset(){
			document.getElementById("S_PROVINCE_ID").value = "";
			document.getElementById("S_WELFARE_ID").value = "";
			document.getElementById("S_NAME").value = "";
			document.getElementById("S_SEX").value = "";
			document.getElementById("S_CHILD_TYPE").value = "";
			document.getElementById("S_SN_TYPE").value = "";
			document.getElementById("S_UPDATE_STATE").value = "";
			document.getElementById("S_CHECKUP_DATE_START").value = "";
			document.getElementById("S_CHECKUP_DATE_END").value = "";
			document.getElementById("S_BIRTHDAY_START").value = "";
			document.getElementById("S_BIRTHDAY_END").value = "";
			document.getElementById("S_UPDATE_DATE_START").value = "";
			document.getElementById("S_UPDATE_DATE_END").value = "";
			document.getElementById("S_AUDIT_USERNAME").value = "";
			document.getElementById("S_AUDIT_DATE_START").value = "";
			document.getElementById("S_AUDIT_DATE_END").value = "";
			
		}
		//更新申请的审核
		function _audit(){
			var num = 0;
			var CUA_ID = "";
			var OPERATION_STATE="";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					CUA_ID =arrays[i].value.split("#")[0];
					OPERATION_STATE=arrays[i].value.split("#")[1];
					 num++;
				}
			}
			if(num != "1"){
				page.alert("请选择一条要审核的更新记录！");
				return;
			}else{
				if(OPERATION_STATE!="0"){
				   page.alert("该更新申请已审核完毕，请重新选择！");
				   return;
					}
				document.srcForm.action=path+"cms/childupdate/toUpdateAudit.action?"+"CUA_ID="+CUA_ID;
				document.srcForm.submit();
			}
		}	
		
		//查看更新申请详细信息
		function _showDetail(){
			var num = 0;
			var CUI_ID = "";
			var arrays = document.getElementsByName("xuanze");
			for(var i=0; i<arrays.length; i++){
				if(arrays[i].checked){
					CUI_ID =arrays[i].value.split("#")[2];
					 num++;
				}
			}
			if(num != "1"){
				page.alert("请选择一条要查看更新记录！");
				return;
			}else{
			 var url = path + "cms/childupdate/getShowData.action?UUID="+CUI_ID;
				//window.open(url,"window",'height=450,width=1000,top=50,left=160,toolbar=no,menubar=no,scrollbars=yes,resizable=no,location=no,status=no');
				_open(url, "window", 1000, 500);
			}
		}
		//省厅福利院查询条件联动所需方法
		function selectWelfare(node){
			var provinceId = node.value;
			//用于回显得福利机构ID
			var selectedId = '<%=WELFARE_ID%>';
			var dataList = getDataList("com.dcfs.mkr.organesupp.AjaxGetWelfare","ids="+provinceId);
			if(dataList != null && dataList.size() > 0){
				//清空
				document.getElementById("S_WELFARE_ID").options.length=0;
				document.getElementById("S_WELFARE_ID").options.add(new Option("--请选择福利院--",""));
				for(var i=0;i<dataList.size();i++){
					var data = dataList.getData(i);
					if(selectedId==data.getString("ORG_CODE")){
						document.getElementById("S_WELFARE_ID").options.add(new Option(data.getString("CNAME"),data.getString("ORG_CODE")));
						var option = document.getElementById("S_WELFARE_ID");
						document.getElementById("S_WELFARE_ID").value = selectedId;
					}else{					
						document.getElementById("S_WELFARE_ID").options.add(new Option(data.getString("CNAME"),data.getString("ORG_CODE")));
					}
				}
			}else{
				//清空
				document.getElementById("S_WELFARE_ID").options.length=0;
				document.getElementById("S_WELFARE_ID").options.add(new Option("--请选择福利院--",""));
			}
		}
		//省厅福利院查询条件联动所需方法
		function initProvOrg(){
			var str = document.getElementById("S_PROVINCE_ID");
		     selectWelfare(str);
		}
	</script>
	<BZ:body property="data" codeNames="ETXB;BCZL;CHILD_TYPE;UPDATE_STATE;PROVINCE;">
		<BZ:form name="srcForm" method="post" action="cms/childupdate/updateAuditListZX.action">
		<BZ:frameDiv property="clueTo" className="kuangjia">
		<!--用来存放数据库排序标示(不存在数据库排序可以不加) Start-->
		<input type="hidden" name="compositor" value="<%=compositor%>"/>
		<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
		
		<!-- 查询条件区Start -->
		<div class="table-row" id="searchDiv" style="display: none">
			<table cellspacing="0" cellpadding="0">
				<tr>
					<td style="width: 100%;">
						<table>
							<tr>
							    <td class="bz-search-title" style="width: 10%">省份</td>
								<td style="width: 16%">
									<BZ:select prefix="S_"  id="S_PROVINCE_ID" field="PROVINCE_ID" onchange="selectWelfare(this)"  width="95%"  isCode="true"  codeName="PROVINCE" formTitle="省份" defaultValue="">
					 	                <BZ:option value="">--请选择省份--</BZ:option>
					                </BZ:select>
								</td>	
							    
								<td class="bz-search-title" style="width: 12%">姓&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名</td>
								<td style="width: 16%">
									<BZ:input prefix="S_" field="NAME" id="S_NAME" defaultValue="" formTitle="姓名" maxlength="150" style="width: 65%"/>
								</td>
								
	                            <td class="bz-search-title" style="width: 10%">出生日期</td>
								<td style="width: 36%">
									<BZ:input prefix="S_" field="BIRTHDAY_START" id="S_BIRTHDAY_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_BIRTHDAY_END\\')}',readonly:true" defaultValue="" formTitle="起始出生日期" />~
									<BZ:input prefix="S_" field="BIRTHDAY_END" id="S_BIRTHDAY_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_BIRTHDAY_START\\')}',readonly:true" defaultValue="" formTitle="截止出生日期" />
								</td>
							</tr>
							<tr>
							    <td class="bz-search-title" >福利院</td>
								<td >
									<BZ:select prefix="S_" id="S_WELFARE_ID" field="WELFARE_ID" formTitle="福利院" defaultValue="">
						              <BZ:option value="">--请选择福利院--</BZ:option>
					               </BZ:select>
								</td>
								
								<td class="bz-search-title" >性&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;别</td>
								<td >
								    <BZ:select prefix="S_" field="SEX" id="S_SEX" isCode="true" codeName="ETXB" formTitle="性别" defaultValue="" width="70%">
										<BZ:option value="">--请选择--</BZ:option>
									</BZ:select>
								</td>
							
								<td class="bz-search-title">体检日期</td>
								<td>
									<BZ:input prefix="S_" field="CHECKUP_DATE_START" id="S_CHECKUP_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_CHECKUP_DATE_END\\')}',readonly:true" defaultValue="" formTitle="起始体检日期" />~
									<BZ:input prefix="S_" field="CHECKUP_DATE_END" id="S_CHECKUP_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_CHECKUP_DATE_START\\')}',readonly:true" defaultValue="" formTitle="截止体检日期" />
								</td>
							</tr>
							<tr>
							    <td class="bz-search-title" >儿童类型</td>
								<td >
								    <BZ:select prefix="S_" field="CHILD_TYPE" id="S_CHILD_TYPE" isCode="true" codeName="CHILD_TYPE" formTitle="儿童类型" defaultValue="" width="95%">
										<BZ:option value="">--请选择--</BZ:option>
									</BZ:select>
								</td>
									
								<td class="bz-search-title">更新状态</td>
								<td>
									<BZ:select prefix="S_" field="UPDATE_STATE" id="S_UPDATE_STATE" isCode="true" codeName="UPDATE_STATE" formTitle="更新状态" defaultValue="" width="70%" >
										<BZ:option value="">--请选择--</BZ:option>
									</BZ:select>
								</td>
								
								<td class="bz-search-title">申请日期</td>
								<td >
									<BZ:input prefix="S_" field="UPDATE_DATE_START" id="S_UPDATE_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_UPDATE_DATE_END\\')}',readonly:true" defaultValue="" formTitle="起始申请日期" />~
									<BZ:input prefix="S_" field="UPDATE_DATE_END" id="S_UPDATE_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_UPDATE_DATE_START\\')}',readonly:true" defaultValue="" formTitle="截止申请日期" />
								</td>
							</tr>
							<tr>	
					            <td class="bz-search-title">病残种类</td>
								<td>
								    <BZ:select prefix="S_" field="SN_TYPE" id="S_SN_TYPE" isCode="true" codeName="BCZL" formTitle="病残种类" defaultValue="" width="95%">
										<BZ:option value="">--请选择--</BZ:option>
									</BZ:select>
								</td>
								
							    <td class="bz-search-title">审核人</td>
								<td>
								    <BZ:input prefix="S_" field="AUDIT_USERNAME" id="S_AUDIT_USERNAME" defaultValue="" formTitle="审核人" maxlength="150" style="width: 90%"/>
								</td>
								<td class="bz-search-title">审核日期</td>
								<td >
									<BZ:input prefix="S_" field="AUDIT_DATE_START" id="S_AUDIT_DATE_START" type="Date" dateExtend="maxDate:'#F{$dp.$D(\\'S_AUDIT_DATE_END\\')}',readonly:true" defaultValue="" formTitle="起始审核时间" />~
									<BZ:input prefix="S_" field="AUDIT_DATE_END" id="S_AUDIT_DATE_END" type="Date" dateExtend="minDate:'#F{$dp.$D(\\'S_AUDIT_DATE_START\\')}',readonly:true" defaultValue="" formTitle="截止审核时间" />
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr style="height: 5px;"></tr>
				<tr style="height: 5px;"></tr>
				<tr>
					<td style="text-align: center;">
						<div class="bz-search-button">
							<input type="button" value="搜&nbsp;&nbsp;索" onclick="_search();" class="btn btn-sm btn-primary">
							<input type="button" value="重&nbsp;&nbsp;置" onclick="_reset();" class="btn btn-sm btn-primary">
						</div>
					</td>
					<td class="bz-search-right"></td>
				</tr>
			</table>
		</div>
		<!-- 查询条件区End -->
		<div class="page-content">
			<div class="wrapper">
				<!-- 功能按钮操作区Start -->
				<div class="table-row table-btns" style="text-align: left">
					<input type="button" value="查&nbsp;&nbsp;询" class="btn btn-sm btn-primary" onclick="_showSearch();"/>&nbsp;
					<input type="button" value="查&nbsp;&nbsp;看" class="btn btn-sm btn-primary" onclick="_showDetail();"/>&nbsp;
					<input type="button" value="审&nbsp;&nbsp;核" class="btn btn-sm btn-primary" onclick="_audit();"/>&nbsp;
				</div>
				<div class="blue-hr"></div>
				<!-- 功能按钮操作区End -->
				
				<!--查询结果列表区Start -->
				<div class="table-responsive">
					<table class="table table-striped table-bordered table-hover dataTable" adsorb="both" init="true" id="sample-table">
						<thead>
							<tr>
								<th class="center" style="width: 3%;">
									<div class="sorting_disabled">
										<input type="checkbox" class="ace"/>
									</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting_disabled">序号</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="PROVINCE_ID">省份</div>
								</th>
								<th style="width: 10%;">
									<div class="sorting" id="WELFARE_NAME_CN">福利院</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="NAME">姓名</div>
								</th>
								<th style="width: 5%;">
									<div class="sorting" id="SEX">性别</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="BIRTHDAY">出生日期</div>
								</th>
								<th style="width: 8%;">
									<div class="sorting" id="CHILD_TYPE">儿童类型</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="SN_TYPE">病残种类</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="CHECKUP_DATE">体检日期</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="UPDATE_DATE">申请日期</div>
								</th>
								<th style="width: 6%;">
									<div class="sorting" id="AUDIT_USERNAME">审核人</div>
								</th>
								<th style="width: 9%;">
									<div class="sorting" id="AUDIT_DATE">审核日期</div>
								</th>
								<th style="width: 7%;">
									<div class="sorting" id="UPDATE_STATE">更新状态</div>
								</th>
							</tr>
						</thead>
						<tbody>
						<BZ:for property="List">
							<tr class="emptyData">
								<td class="center">
									<input name="xuanze" type="checkbox" value="<BZ:data field="CUA_ID" onlyValue="true"/>#<BZ:data field="OPERATION_STATE" onlyValue="true"/>#<BZ:data field="CUI_ID" onlyValue="true"/>" class="ace">
								</td>
								<td class="center">
									<BZ:i/>
								</td>
								<td class="center"><BZ:data field="PROVINCE_ID" defaultValue="" codeName="PROVINCE" onlyValue="true"/></td>
								<td><BZ:data field="WELFARE_NAME_CN" defaultValue="" onlyValue="true"/></td>
								<td><BZ:data field="NAME" defaultValue="" onlyValue="true"/></td>
								<td class="center"><BZ:data field="SEX" defaultValue="" codeName="ETXB" onlyValue="true"/></td>
								<td class="center"><BZ:data field="BIRTHDAY" defaultValue="" type="Date" onlyValue="true"/></td>
								<td class="center"><BZ:data field="CHILD_TYPE" defaultValue="" codeName="CHILD_TYPE" onlyValue="true"/></td>
								<td class="center"><BZ:data field="SN_TYPE" defaultValue="" codeName="BCZL" onlyValue="true"/></td>
								<td class="center"><BZ:data field="CHECKUP_DATE" defaultValue="" type="Date" onlyValue="true"/></td>
								<td class="center"><BZ:data field="UPDATE_DATE" defaultValue="" type="Date" onlyValue="true"/></td>
								<td><BZ:data field="AUDIT_USERNAME" defaultValue="" onlyValue="true"/></td>
								<td class="center"><BZ:data field="AUDIT_DATE" defaultValue="" type="Date" onlyValue="true"/></td>
								<td class="center"><BZ:data field="UPDATE_STATE" defaultValue=""  codeName="UPDATE_STATE" onlyValue="true"/></td>
							</tr>
						</BZ:for>
						</tbody>
					</table>
				</div>
				<!--查询结果列表区End -->
				<!--分页功能区Start -->
				<div class="footer-frame">
					<table border="0" cellpadding="0" cellspacing="0" class="operation">
						<tr>
							<td><BZ:page form="srcForm" property="List"/></td>
						</tr>
					</table>
				</div>
				<!--分页功能区End -->
			</div>
		</div>
		</BZ:frameDiv>
		</BZ:form>
	</BZ:body>
</BZ:html>