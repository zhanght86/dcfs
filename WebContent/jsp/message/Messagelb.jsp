<%@page import="hx.util.DateUtility"%>
<%@page import="hx.message.OAConstants"%>
<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@page import="hx.database.databean.*"%>
<%@page import="hx.taglib.TagTools"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%@ taglib uri="/WEB-INF/taglib/oa" prefix="OA" %>
<%
String resourcepath=TagTools.getResourcePath(request,"");
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
DataList dataMsg=(DataList)request.getAttribute("dataMsg")==null?new DataList():(DataList)request.getAttribute("dataMsg");
DataList yddataMsg=(DataList)request.getAttribute("yddataMsg")==null?new DataList():(DataList)request.getAttribute("yddataMsg");
String language=(String)session.getAttribute("language");
  if(language == null){ 
  language="zh-CN";
  }
String boxname=(String)request.getAttribute("boxname");
if(boxname.equals(OAConstants.SJX_CN))
{
boxname="收件箱";
}else if(boxname.equals(OAConstants.FJX_CN)){
boxname="发件箱";
}else if(boxname.equals(OAConstants.LJX_CN))
{
boxname="垃圾箱";
}
String boxuuid=(String)request.getAttribute("boxuuid");
String type=(String)request.getParameter("type")==null?"":(String)request.getParameter("type");
String uuid = request.getParameter("uuid");
if(uuid==null){
	uuid = "";
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" >
<BZ:html>
  <BZ:head>  
    <title>短消息</title>
   <link rel="stylesheet" type="text/css" href="<%=resourcepath %>/message/css/newStyle.css"/>
  <BZ:script isList="true" />
  </BZ:head>
  <style>
  	#popdiv{
	font-size:12px;
	position:absolute;
	z-index:100;
	width:200px;
	height:80px;
	}
  </style>
<script type="text/javascript" >

function _loadlist(){
   initTable("tableId");
   <%if(!"".equals(uuid)){%>
   read('<%=uuid%>');
   <%}%>
}

var sForm="srcForm";
var pageaction="<%=path%>/MessageServlet?method=receivemessage";
function restoredl()
{
if (!hasSelectedOne('uuidbox'))
    {
     alert('请选择一条记录');
     return;
    }else{
    var uuid_zp=selectValue('uuidbox').split('ш');
    document.getElementById("uuid").value=uuid_zp[0];
    document.srcForm.action="<%=path%>?method=huifudl";
	document.srcForm.submit();
	}
}
function restore()
{
if (!hasSelectedOne('uuidbox'))
    {
     alert('请选择一条记录');
     return;
    }else{
    var uuid_zp=selectValue('uuidbox').split('ш');
    document.getElementById("uuid").value=uuid_zp[0];
    document.srcForm.action="<%=path%>/MessageServlet?method=huifu&xians=duanxx";
	document.srcForm.submit();
	}
}
function _delete()
{
 var j=0;
 var checkBoxObj = document.getElementsByName("uuidbox");
 for(var i=0;i<checkBoxObj.length;i++)
		 {
		 if(checkBoxObj[i].checked)
		 {
		 j++;
		 }		 
		 }
		 if(j==0)
		  {
		     alert('请选中至少一条有效数据');
		     return;
		  }else
		 {
		 if(confirm('确实要删除?'))
		 {
		 document.srcForm.action="<%=path%>/MessageServlet?method=gbbox";
         document.srcForm.submit();
		 }
		 }
}
function yidongxj()
{
   var j=0;
   var checkBoxObj = document.getElementsByName("uuidbox");
   var mbbox=document.getElementById("zcwjj").value;
    for(var i=0;i<checkBoxObj.length;i++)
		 {
		 if(checkBoxObj[i].checked)
		 {
		 j++;
		 }		 
		 }
		 if(j==0)
		  {
		     alert('请选中至少一条有效数据');
		     document.getElementById("zcwjj").value="";
		     return;
		  }else
		  if(mbbox=="")
		  {
		  alert('请选择一个目标文件夹');
		  return;
		  }else{
		  if(confirm('确实要移动?'))
		  {
		  document.srcForm.action="<%=path%>/MessageServlet?method=xidongxj";
          document.srcForm.submit();     
		  }else
		  {
		  document.getElementById("zcwjj").value="";
		  return;
		  }
		  }
   window.parent.leftFrame.location.reload();
}
function add()
{
	document.srcForm.action="<%=path%>/MessageServlet?method=tiaozhuan";
	document.srcForm.submit();
}
function adddl()
{
	document.srcForm.action="<%=path%>?method=tiaozhuandl";
	document.srcForm.submit();
}
function hzdetail(uuid)
{
 window.open('<%=path %>/MessageServlet?method=hzdetail&uuid='+uuid,'回执情况','location=0,status=0,scrollbars=0,width=400,height=315');
}
 function read(uuid)
 {  
    document.getElementById("uuid").value=uuid;
    document.srcForm.action="<%=path%>/MessageServlet?method=readmessage";
	document.srcForm.submit();
}
var num_c=0;
function selectAll(){
	var obj_uuidboxs=document.getElementsByName("uuidbox");
	//全部勾选上
	if(num_c==0){
	for(var i=0;i<obj_uuidboxs.length;i++){
		if(obj_uuidboxs[i].checked){
			
		}else{
			obj_uuidboxs[i].checked=true;
		}
	}
	num_c=1;
	//全部不选
	}else{
	for(var j=0;j<obj_uuidboxs.length;j++){
		if(obj_uuidboxs[j].checked){
		    obj_uuidboxs[j].checked=false;
		}else{
			
		}
	}
	num_c=0;
	}
}


function seluuidbox(method){
    var obj_uuidboxs=document.getElementsByName("uuidbox");
   if(method=="reverse"){
		for(var j=0;j<obj_uuidboxs.length;j++){
			if(obj_uuidboxs[j].checked){
			    obj_uuidboxs[j].checked=false;
			}else{
				obj_uuidboxs[j].checked=true;
			}
		}
   }else if(method=="readed"){
        var readflags=document.getElementsByName("readflags");
        for(var j=0;j<readflags.length;j++){
			if(readflags[j].value=="1"){
			    obj_uuidboxs[j].checked=true;
			}else{
				obj_uuidboxs[j].checked=false;
			}  
		}
   }else if(method=="notreaded"){
        var readflags=document.getElementsByName("readflags");
        for(var j=0;j<readflags.length;j++){
			if(readflags[j].value=="1"){
			    obj_uuidboxs[j].checked=false;
			}else{
				obj_uuidboxs[j].checked=true;
			}  
		}
   }
}

function checkAll(obj) {
	//document.getElementsByName("uuid_box")[0].checked;
	//alert(obj.checked);
	var obj_uuidboxs=document.getElementsByName("uuidbox");
	for(var i=0;i<obj_uuidboxs.length;i++){
		obj_uuidboxs[i].checked = obj.checked;
	}
}
</script>
   <body id="body" style="margin-left: 0px;margin-top: 0px;margin-right: 0px;margin-bottom: 0px;" onload="_loadlist()">
  <form  name="srcForm" method="post" action="MessageServlet?method=receivemessage&boxuuid=<%=boxuuid%>">
    <input type="hidden" name="uuid" id="uuid" >
  <input type="hidden" name="boxuuid" id="boxuuid" value="<%=boxuuid %>" >
  <!--用来存放数据库排序标示(不存在数据库排序可以不加)-->
		<input type="hidden" name="compositor" id="compositor" value="" />
		<input type="hidden" name="ordertype" id="ordertype" value="" />
   <div class="titleContent" align="left" style="background:url(<%=resourcepath%>/message/images/bg_title2.gif);height:35px;line-height:35px;vertical-align:middle;">&nbsp;&nbsp;<%=boxname %></div>
	<OA:table tableid="tableId" tableclass="table_c">
	<OA:thead theadclass="">
	<th width="4%" onmouseout="thmoveout(this)" onmouseover="thmovrover(this)" id="titleth_"  >
		<input type="checkbox" name="uuid_box" onclick="checkAll(this);return;"/>
	</th>
	<OA:th name="发件人" width="10%" sortType="none" />
	<OA:th name="收件人" width="15%" sortType="none" />
	<OA:th name="抄送人" width="10%" sortType="none" />
	<OA:th name="主题" width="25%" sortType="none" />
	<OA:th name="短消息时间" width="15%" sortType="none" />
	<OA:th name="消息状态" width="15%" sortType="none" />
	</OA:thead>
	<OA:tbody>
	<%int i;
	    for(i=0;i<dataMsg.size();i++){
	    Data data=dataMsg.getData(i);
	   %>
	  <tr>
	    <td><div>
	        <input type="checkbox" name="uuidbox" value="<%=data.getString("UUID","")%>" />
	        <input style="display:none" type="input"  name='readflags' value="<%=data.getString("READSTATE","")%>" />
	    </div></td>
	    <td><a href="#;" onClick="read('<%=data.getString("UUID","")%>');"><%=data.getString("SENDER","&nbsp;") %></a></td>
	    <td><p><%=data.getString("RECEIVER","&nbsp;") %>&nbsp;</p></td>
	    <td><%=data.getString("COPYFORER","&nbsp;") %>&nbsp;</td>
	    <td><a href="#;" onClick="read('<%=data.getString("UUID","")%>');"><%=data.getString("MAILTITLE","&nbsp;") %></a></td>
		<td><%=data.getString("MESSAGETIME","") %>&nbsp;</td>
		<td>
		<%=data.getString("READSTATE","").equals("0")?"<img src='"+resourcepath+"/message/images/mail.gif' width='14' height='12' alt='未读'/>":"<img src='"+resourcepath+"/message/images/mail_open.gif' width='14' height='12' alt='已读'/>"%>
	    <%=data.getString("ACCESSORY","").equals("0")?"<img src='"+resourcepath+"/message/images/zhanwei.gif' width='14' height='14'/>":"<img src='"+resourcepath+"/message/images/icon_att.gif' width='14' height='14' alt='附件'/>"%>
	    <%if(data.getString("RECEIPT","").equals("1")) {%><%=data.getString("RECEIPTSTATE","").equals("1")?"<img src='"+resourcepath+"/message/images/tick.gif' width='16' height='16' alt='已回执'/>":"<img src='"+resourcepath+"/message/images/cross.gif' width='15' height='14' alt='未回执'/>"%>
	    <%}else if(data.getString("RECEIPT","").equals("2")){%><a href="#" onclick="hzdetail('<%=data.getString("UUID","") %>');">查看详情</a><%}else{ %><img src="<%=resourcepath%>/message/images/zhanwei.gif" width='14' height='14'/><%} %>
	    
	    </td>
	    </tr>
	  <%} %>
	      <% for(int j=i;j<10;j++)
	           {
	           %>
	           <tr>
			   <td>&nbsp;</td>
			   <td>&nbsp;</td>
			   <td>&nbsp;</td>
			   <td>&nbsp;</td>
			   <td>&nbsp;</td>
			   <td>&nbsp;</td>
			   <td>&nbsp;</td>
	           </tr>
	           <% 
	           }
	           %> 
	</OA:tbody>
	</OA:table>
  <table width="100%">
      <tr style="font-size:12px;background-color: #F7F7F7">
      <td style="padding-left:20px;">选择:
       <a href='#' onclick="num_c=0;selectAll();return false;" onmouseover=this.style.cursor="hand" onmouseout=this.style.cursor="default" >全部</a>
        -
       <a href='#' onclick="seluuidbox('notreaded');return false;" onmouseover=this.style.cursor="hand" onmouseout=this.style.cursor="default" >未读</a>
        -  
       <a href='#' onclick="seluuidbox('readed');return false;" onmouseover=this.style.cursor="hand" onmouseout=this.style.cursor="default" >已读</a>
        -
       <a href='#' onclick="seluuidbox('reverse');return false;" onmouseover=this.style.cursor="hand" onmouseout=this.style.cursor="default" >反选</a>
        -
       <a href='#' onclick="num_c=1;selectAll();return false;" onmouseover=this.style.cursor="hand" onmouseout=this.style.cursor="default" >不选</a>
			</td>
	  <td align="right"></td>
      </tr>
      <tr>
      <td>
		<input type="button" name="Submit22" value="新建" onclick="<%if(type.equals("duli")) {%>adddl();<%}else{ %>add();<%} %>" class="btn2"/>&nbsp;
		<input type="button" name="Submit22" value="回复" onclick="<%if(type.equals("duli")) {%>restoredl();<%}else{ %>restore();<%} %>" class="btn2"/>
		<input type="button" name="Submit22" value="删除" onclick="_delete();" class="btn2"/>&nbsp; 
		<select name="zcwjj" id="zcwjj" onchange="yidongxj();">
		<option value="">移动到....</option>
		<%for(int j=0;j<yddataMsg.size();j++)
		{
		Data data=yddataMsg.getData(j);
		 %>
		 <option value="<%=data.getString("UUID","") %>"><%=data.getString("NAME","") %></option>
		 <%} %>
		</select>
	</td>
	<td><BZ:page form="srcForm" property="dataMsg"/></td>
      </tr>
  </table>
</form>
  </body>
</BZ:html>
