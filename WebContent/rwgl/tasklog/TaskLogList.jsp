<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/common/jstl.jsp"%> 
<jsp:directive.page import="java.util.ArrayList"/>
<jsp:directive.page import="java.util.List"/>
<jsp:directive.page import="base.task.util.StringUtil"/>

<jsp:directive.page import="java.util.Hashtable"/>
<jsp:directive.page import="base.task.monitor.log.vo.TaskLogVO"/>
<jsp:directive.page import="base.resource.util.page.Pagination"/>
<jsp:directive.page import="base.common.page.Page"/>
<%
    String contextPath= request.getContextPath();
    List list = ((Page)request.getAttribute("page")).getDataList();

	String taskName = (String) request.getAttribute("taskName");
	String TIME1 = (String)request.getAttribute("TIME1");
    if (TIME1.length() >= 10) {
      TIME1 = TIME1.substring(0, 10);
    }
    String TIME2 = (String)request.getAttribute("TIME2");
    if (TIME2.length() >= 10) {
      TIME2 = TIME2.substring(0, 10);
    }
    
    String RUN_STATE= (String)request.getAttribute("RUN_STATE");
    if (RUN_STATE==null) {
      RUN_STATE="";
    }
  String navigation = "�������-&gt;������ʷ��־��ѯ";

  
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="<%=contextPath%>/rwgl/css/style.css" rel="stylesheet" type="text/css" />

<script LANGUAGE="javascript" SRC="<%=contextPath%>/rwgl/js/jcommon.js"></script>
<script type="text/javascript" src="<%=contextPath%>/rwgl/js/customString.js"></script>
<script type="text/javascript" src="<%=contextPath%>/rwgl/js/formVerify2.js"></script>
<script type="text/javascript" src="<%=contextPath%>/rwgl/js/verify.js"></script>
<script LANGUAGE="javascript" SRC="<%=contextPath%>/rwgl/js/page.js"></script>
<link href="<%= contextPath %>/rwgl/css/calendar.css" rel="stylesheet" type="text/css" />
<script language="JavaScript" type="text/javascript" src="<%= contextPath %>/rwgl/js/calendar-setup.js"></script>
<script language="JavaScript" type="text/javascript" src="<%= contextPath %>/rwgl/js/calendar.js"></script>
<script language="JavaScript" type="text/javascript" src="<%= contextPath %>/rwgl/js/calendar-zh.js"></script>

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
<title></title>
<!-- �������� begin -->
<SCRIPT LANGUAGE="JavaScript">
<!--
function _submit()
{   
    var date= document.getElementById("TIME1");
    var edate= document.getElementById("TIME2");
    if(date.value.atrim() !=""){
       if(!date.value.isDate()){
	       alert("[��ʼʱ��]���������ڸ�ʽ��׼�����磺2007-09-25");
	       date.select();
	       date.focus();
	       return;
       }
    }
    if(edate.value.atrim() !=""){
       if(!edate.value.isDate()){
	       alert("[����ʱ��]���������ڸ�ʽ��׼�����磺2007-09-25");
	       edate.select();
	       edate.focus();
	       return;
       }
    }
    
	var sForm = document.frmSub;
	if(sForm.TIME1.value != "")
	{
	   if (!_compareTwoDateForString(sForm.TIME1.value, _getCurrentDate(0)))
	   {
		   alert("��ʼ���ڲ����ڵ�ǰ����֮��");
		   sForm.TIME1.focus();
		   return;
	   }
	}
	//if(sForm.TIME2.value != "")
	//{
	//   if (!_compareTwoDateForString(sForm.TIME2.value, _getCurrentDate(0)))
	//   {
	//	   alert("��ֹ���ڲ����ڵ�ǰ����֮��");
	//	   sForm.TIME2.focus();
	//	   return;
	//   }
	//}
    if (sForm.TIME1.value != "" && sForm.TIME2.value != "")
    {
		if (!_compareTwoDateForString(sForm.TIME1.value, sForm.TIME2.value))
		{
			alert("���ڷ�Χѡ��Ӧ�ð����Ⱥ�˳����д��");
			sForm.TIME1.focus();
			return;
	     }
   }
   if(_check(frmSub)){ 
	 sForm.action = "<%=contextPath%>/base/task/monitor/log/TaskLogListServlet";
     sForm.submit();
	}else{
	return}
   
}

//-->
</SCRIPT>
</head>
<body>
<form name="frmSub" method="post">
<table width="100%" border="0" cellspacing="0" cellpadding="1" class="text01" >
  <tr>
    <td height="18"  valign="middle"><img src="<%=contextPath%>/images/currentpositionbg.jpg" width="8" height="18" id="positionimg"/><div class="currentposition"><strong>&nbsp;��ǰλ��-&gt;<%=navigation%></strong></div></td>
    <td  class="currentposition" align="right"><strong></strong></td>
    <td width="4%" align="right"> 
     </td>
    <td width="9%"> 
       </td>
  </tr>
  
<tr>
        <td height="25" colspan="4">
				 <div id="query">
				 &nbsp;�������ƣ�
                  <input type="text" name="taskName" fieldTitle="��������" fieldType ="hasSpecialChar" size="25" class="queryinput" value="<%=taskName%>">
                  &nbsp;���н����
                  <select name="RUN_STATE" id="RUN_STATE">
                     <option value="">��--ȫ��--��</option>
                     <option value="0">��������</option>
                     <option value="1">�ɹ�</option>
                     <option value="2">ʧ��</option>
                     <option value="3">�쳣</option>
                  </select>
                 &nbsp;��&nbsp;&nbsp;�ڣ�
                 <input id="TIME1" name="TIME1" type="text" class="queryinput" size="10" value="<%=TIME1%>" ><img src="<%=contextPath%>/images/datetime.gif" style="cursor:hand;" alt="�������������˵�" width="16" height="16" onclick="return showCalendar('TIME1', '%Y-%m-%d');"/>

                    ��
				<input id="TIME2" name="TIME2" type="text" class="queryinput" size="10" value="<%=TIME2%>" ><img src="<%=contextPath%>/images/datetime.gif" style="cursor:hand;" alt="�������������˵�" onClick="return showCalendar('TIME2', '%Y-%m-%d');">
                 &nbsp;<input type=button name="button3" value="�� ѯ" class="input01"  onclick="_submit()">
                 </div>		  
		</td>
</tr>	
 
<tr>
      <td colspan="4">
		<div id="primarydata" style="width:100%; overflow:hidden" >
              <table id="listTable" width="100%" border="0" align="center" cellpadding="3" cellspacing="1" bgcolor="#9CC6F7" class="text01">
                 <tr bgcolor="EAEAEA">
                    <th width="5%" align="center" nowrap>���</th>
                    <th width="20%" align="center" nowrap>��������</th>
                    <th width="15%" align="center" nowrap>��ʼʱ��</th>
                    <th width="15%" align="center" nowrap>����ʱ��</th>
                    <th width="10%" align="center" nowrap>���н��</th>
                    <th width="35%" align="center" nowrap>�����Ϣ</th>
                </tr>
              <%
                                    for(int i=0 ;i<list.size(); i++){
                                    TaskLogVO tlvo= (TaskLogVO)list.get(i); 
                                    String TL_TASK_ID = tlvo.getTASK_ID();
                                    String TI_TASK_NAME = tlvo.getTaskname();
                                    String TL_START_TIME = tlvo.getSTART_TIME();
                                    String TL_END_TIME = tlvo.getEND_TIME();
                                    TL_END_TIME="null".equals(TL_END_TIME)?"":TL_END_TIME;
                                    String TL_RUN_STATE = tlvo.getRUN_STATE();
                                    String TL_RUN_MSG = tlvo.getRUN_MSG();
                                    String TL_LOG_ID = tlvo.getID();
                                    if (TL_RUN_STATE.equals("0"))
                                    {
                                      TL_RUN_STATE = "��������";
                                    }
                                    else if (TL_RUN_STATE.equals("1"))
                                    {
                                      TL_RUN_STATE = "�ɹ�";
                                    }
                                    else if (TL_RUN_STATE.equals("2"))
                                    {
                                      TL_RUN_STATE = "ʧ��";
                                    }
                                    else if (TL_RUN_STATE.equals("3"))
                                    {
                                      TL_RUN_STATE = "�쳣";
                                    }
              %>
                  <tr bgcolor="#FFFFFF">
                    <td align="center" width="39" nowrap> <%=i+1%> </td>
                    <td width="147" nowrap>&nbsp;<a href="<%=contextPath%>/base/task/monitor/log/TaskLogDetailServlet?TL_LOG_ID=<%=TL_LOG_ID%>&TIME1=<%=TIME1%>&TIME2=<%=TIME2%>"><%=StringUtil.escapeHTMLTags(TI_TASK_NAME)%></a></td>
                    <td align="center" width="142" nowrap><%=TL_START_TIME%></td>
                    <td width="140" align="center" nowrap><%=TL_END_TIME%></td>
                    <td align="center" width="118" nowrap><%=TL_RUN_STATE%></td>
                    <td width="871" nowrap>&nbsp;<%=StringUtil.HTMLEncode(TL_RUN_MSG)%> </td>
                </tr>
                <%
                    }
                  %>
              
              </table>
  </div>
  </td>
  </tr>

  <tr>
				<td colspan="4" height="20">
   			         <c:import url="/common/pageControl.jsp" charEncoding="GBK">
					       <c:param name="formAction">
					       		<c:url value='/base/task/monitor/log/TaskLogListServlet'/>
					       </c:param>
				       </c:import> 
					</td>
				</tr>
  <!--  
  <tr align="center"> 
    <td colspan="4"> 
      <input type=hidden name="currentPage" value="1">
      <input type=button name="button2" value="ɾ ��" class="input01" onClick="_del()" >
    </td>
  </tr>
  -->    
</table>
</form>
<script type="text/javascript">
	document.getElementById("RUN_STATE").value="<%=RUN_STATE%>";
</script>
</body>
</html>