<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@page import="com.hx.cms.article.vo.Article"%>
<%@page import="com.hx.cms.channel.vo.Channel"%>
<%@page import="hx.database.databean.DataList"%>
<%@page import="com.hx.upload.sdk.AttHelper"%>
<%@ taglib prefix="cms" uri="/WEB-INF/taglib/cms"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ taglib uri="/WEB-INF/upload-tag/upload" prefix="up"%>
<%
	String path = request.getContextPath();
	Data parent = (Data)request.getAttribute("parent");
	Data currentChannel = (Data)request.getAttribute("currentChannel");
	DataList channelList = (DataList) request.getAttribute("channelList");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"> 
<cms:html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK" /> 
<title></title> 
<meta name="description" content="" /> 
<meta name="keywords" content="" /> 
<cms:script />
<link href="<BZ:resourcePath/>/nw/css/npage.css" type="text/css" rel="stylesheet" />
<!--Բ��JS start--> 
<script type="text/JavaScript" src="<BZ:resourcePath />/main/js/curvycorners.src.js"></script> 
<!--Բ��JS end--> 
<!-- ������꾭����ʼ -->
<script type="text/JavaScript">
function _mover(o){
	o.style.backgroundColor="#EEEEEE";
}
function _out(o){
	o.style.backgroundColor="#FFFFFF";
}
</script>
<!-- ������꾭������ -->
<!-- ����ҳ��Ŀ���νṹ��ʼ -->
<script language="javascript" type="text/javascript">
function w(vd,o)
{
	_removeMenuStyle(o);
  var ob=document.getElementById(vd);
  if(ob.style.display=="block" || ob.style.display=="")
  {
     ob.style.display="none";
     //var ob2=document.getElementById('s'+vd);
     //ob2.style.backgroundImage="url(images/npic_1.jpg)";
  }
  else
  {
	  o.className="fblod_sel";
    ob.style.display="block";
    //var ob2=document.getElementById('s'+vd);
    //ob2.style.backgroundImage="url(images/npic_2.jpg)";
  }
}
function k(vd)
{
  var ob=document.getElementById(vd);  
  if(ob.style.display=="block")
  {
     ob.style.display="none";
     //var ob2=document.getElementById('s'+vd);
     //ob2.style.backgroundImage="url(images/npic_1.jpg)";
  }
  else
  {
    ob.style.display="block";
    //var ob2=document.getElementById('s'+vd);
    //ob2.style.backgroundImage="url(images/npic_2.jpg)";
  }
}
function _removeMenuStyle(o){
	var divs = document.getElementsByTagName("DIV");
	for(var i=0;i<divs.length;i++){
		if(divs[i].className=="fblod_sel"){
			divs[i].className="fblod";
		}
		if(o!=divs[i]){
			var cid = divs[i].getAttribute("cid");
			if(cid!=null){
				var c = document.getElementById(cid);
				if(c!=null){
					c.style.display="none";
				}
			}
		}
	}
}
function _loadMenuStyle(){
	var dh = document.getElementById("daohang");
	var u = document.location;
	var menus = dh.getElementsByTagName("A");
	var len = menus.length;
	for(var i=0;i<len;i++){
		var menu = menus[i];
		if(menu.tagName=="A"){
			var url = menu.href;
			if (u==url){
				var div = menu.parentNode;
				if (div.tagName=="DIV"){
					if(div.className=="fblod"){
						div.className="fblod_sel";
						break;
					}
					if (div.className=="o"){
						_clearMenuStyle("sanji","o");
						div.className="sanji";
						var ps = div.parentNode;
						if (ps.tagName=="DIV"){
							if(ps.className=="ps"){
								ps.style.display="block";
								var id = ps.id;
								var ddd = dh.getElementsByTagName("DIV");
								for(var j=0;j<ddd.length;j++){
									var cid = ddd[j].getAttribute("cid");
									if (cid==id){
										ddd[j].className="fblod_sel";
										break;
									}
								}
								break;
							}
						}
					}
					
				}
			}
		}
	}
}
function _clearMenuStyle(c,n){
	var dh = document.getElementById("daohang");
	var ddd = dh.getElementsByTagName("DIV");
	for(var j=0;j<ddd.length;j++){
		var d = ddd[j];
		if(d.className==c){
			d.className=n;
		}
	}
}
function _selMe(o){
	_clearMenuStyle("sanji","o");
	o.className="sanji";
}
function _clickMenu(o){
	var a = o.getElementsByTagName("A");
	if(a!=null && a.length>0){
		a[0].click();
	}
}


</script>
<!-- ����ҳ��Ŀ���νṹ���� -->

<!-- ȫ�ļ�����ʼ -->
<script type="text/javascript">
function submitSearchForm(){

	var cont = document.getElementById("CONTENT").value;
	if(cont == null || cont.length == 0 || cont.trim().length == 0){
		alert("�������ݲ���Ϊ��!");
		return false;
	}

	document.searchForm.target = "frmright";
	document.searchForm.action = "<BZ:url/>/article/FullTextNei.action";
	document.searchForm.submit();
	document.searchForm.target = "_self";
}
</script>
<!-- ȫ�ļ������� -->

<!-- ���ص��ͳ�ƿ�ʼ -->
<script type="text/javascript" src="<BZ:resourcePath />/main/js/jquery.js"></script>
<script type="text/javascript">
function downNum(id){
	$.ajax({
		type: "post",
		url: "<%=path%>/article/Article!statDownNum.action?ID="+id,
		data: "time=" + new Date().valueOf(),
		success:function(){}
	});
}
</script>
<!-- ���ص��ͳ�ƽ��� -->
</head> 
<body style="margin: 0" > 
<div class="bodybg">
	<!--search start--> 
	<div class="header">
	<form id="searchForm" name="searchForm" action="<BZ:url/>/article/FullTextNei.action" method="post">
		    <div class="hdbot">
		            	<div class="hdbotL">
		                	<input id="CONTENT" type="text" name="CONTENT" value="������ؼ���" class="left" />
		                    <select name="SEARCH_TYPE" class="left">
					        	<option value="1" selected="selected">ȫ�ļ���</option>
					        	<option value="2">����</option>
					        </select>
		                    <select name="CHANNEL_ID" class="left">
		                    	<option title="������Ŀ" value="0">������Ŀ</option>
					        	<%
					        		if(channelList != null){
					        			for(int i = 0; i < channelList.size(); i++){
					        			    Data data = channelList.getData(i);
					        			    if("0".equals(data.getString(Channel.PARENT_ID))){
					        			        for(int k = 0; k < channelList.size(); k++){
					        			            Data first = channelList.getData(k);
													if(data.getString(Channel.ID).equals(first.getString(Channel.PARENT_ID))){
														//�ڶ���
														%>
														<option value="<%=first.getString(Channel.ID) %>" title="<%=first.getString(Channel.NAME) %>">&nbsp;�� <%=first.getString(Channel.NAME) %></option>
														<%
														for(int j = 0; j < channelList.size(); j++){
														    Data second = channelList.getData(j);
														    if(first.getString(Channel.ID).equals(second.getString(Channel.PARENT_ID))){
														        %>
														        <option value="<%=second.getString(Channel.ID) %>" title="<%=second.getString(Channel.NAME) %>">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�� <%=second.getString(Channel.NAME) %></option>
														        <%
														        for(int m = 0; m < channelList.size(); m++){
														            Data third = channelList.getData(m);
														            //ȥ��������ʾ����Ŀ���������
										            				if(second.getString(Channel.ID).equals(third.getString(Channel.PARENT_ID)) && !"ea8c8775-204c-4da2-bc25-69d919cd7b77,fb7b0d8f-acaa-4f50-be8a-ab08631fbb1c".contains(third.getString(Channel.PARENT_ID))){
														                //���ļ�
																		%>
																		<option value="<%=third.getString(Channel.ID) %>" title="<%=third.getString(Channel.NAME) %>">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�� <%=third.getString(Channel.NAME) %></option>
																		<%										                
														            }
														        }
														    }
														}
													}	        			            
					        			        }
					        			    }
					        			}
					        		}
								%>
		                    </select>
		                    <a onclick="submitSearchForm();" style="cursor: pointer;"><img src="<BZ:resourcePath/>/nw/images/button_3.jpg" alt="" class="left" /></a>
		                </div>
		                <div class="hdbotR">��ǰλ�ã�<a href="#">��ҳ</a>&nbsp;&gt;&nbsp;<%=currentChannel.getString(Channel.NAME) %></div>
		     </div>
		     </form>
	</div>
	<!--search end--> 
	<div class="main"> 
    <!--part1 start--> 
      
	    <div class="mainL">
             <div class="mainLt">
             	<div class="mainLtT">����</div>
                 <div class="mainB_Lt" style="float:left;" id="daohang">
                     <div><img src="<BZ:resourcePath/>/nw/images/part_bg4.gif" /></div>  
		              
		               <cms:channelList channelId="<%=parent.getString(Channel.ID) %>" orderName="SEQ_NUM" orderType="ASC">
		            	<div class="fblod" onclick="_clickMenu(this);">
		            		<cms:channelTitle titleLength="10" total="true" link="true" href="channel/Channel!channelDownload.action" params="PARENT_ID" paramValues="<%=parent.getString(Channel.ID) %>" target="_self"/>
		            	</div>
		                </cms:channelList>
                	 <!-- ��Ŀѭ������ -->
                     <div><img src="<BZ:resourcePath/>/nw/images/part_bg6.gif" /></div>
                 </div>
             </div>
	    </div>
	    <script type="text/javascript">
	    _loadMenuStyle();
	    </script>
        <div class="mainR">
	            <div> 
	               <table width="100%" height="33" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td style="width:52px">
								<img src="<BZ:resourcePath/>/nw/images/menu_01.jpg" width="52" height="33" alt=""></td>
							<td style="background-image: url('<BZ:resourcePath/>/nw/images/menu_03.jpg')" nowrap class="mainRbt">
								<%=currentChannel.getString(Channel.NAME) %></td>
							<td style="width:58px">
								<img src="<BZ:resourcePath/>/nw/images/menu_05.jpg" width="58" height="33" alt=""></td>
							<td style="background-image: url('<BZ:resourcePath/>/nw/images/menu_07.jpg');width:100%"></td>
							<td style="width:14px">
								<img src="<BZ:resourcePath/>/nw/images/menu_09.jpg" width="14" height="33" alt=""></td>
						</tr>
					</table>
	            </div> 
	            <div class="mainB_Rf"> 
            <cms:form id="channelList" action="channel/Channel!channelDownload.action">
            	<div class="list_sd"> 
					<input name="ID" type="hidden" value="<%=currentChannel.getString(Channel.ID) %>"/>
					<input name="PARENT_ID" type="hidden" value="<%=parent.getString(Channel.ID) %>"/>
                    <ul> 
                    <cms:infoList channelId="<%=currentChannel.getString(Channel.ID) %>" type="page" forData="art" orderName="SEQ_NUM;CREATE_TIME" orderType="ASC;DESC">
					<%
						Data article = (Data)pageContext.findAttribute("art");
						int i = article.getInt("i");
						if("a43cd452-f7ed-448c-830d-b847c224d687".equals(article.getString(Article.CHANNEL_ID)) && i == 0){
					%>
					<li>
                    	<h1 class="radius1">
                    		<a href="http://43.1.160.1:6868" target="_blank" title='��ɽ����'>
								��ɽ����
							</a>
                    	</h1>
                    	<div class="list_sdF">
                        	<div class="list_sdFL">
                            	<table border="0" cellspacing="0" cellpadding="0" width="100%" height="65">
                            		<tr>
                                    	<td align="center" valign="top"><a href='http://43.1.160.1:6868' target="_blank"><img width="36px" height="36px" src='<BZ:url/>/userfiles/images/jinshanduba.jpg'/></a></td>
                                    </tr>
                                </table>
                            </div>
                            <div class="list_sdFM">
                            	<p>��ɽ�������߰�װ����</p>
                            </div>
                            <div class="list_sdFR">
                            	
                                <a href="http://43.1.160.1:6868" target="_blank"><img src="<BZ:resourcePath />/nw/images/sd_btn2.gif" /></a>
                            </div>
                            <div class="clr"></div>
                        </div>
                    </li>
					<%	
						}
					%>
	                <li>
                    	<h1 class="radius1">

				<table width="100%" boder="0" cellspacing="0" cellpadding="0">
					<tr>
						<td align="left"><a href="<BZ:url/>/article/Article!detailArt.action?ID=<%=article.getString(Article.ID) %>" target="_blank" title='<cms:infoTitle />'>
								<cms:infoTop src='<%=path + "/jsp/cms/images/top.gif" %>' width="15px" height="9px"/>
								<cms:infoTitle/>
								<cms:artSecurityInfo left="[" right="]" periodCodeName="SECURITY_XX" securityLevelCodeName="SECURITY_LEVEL"/>
							</a></td>
						<td align="right" style="padding-right:6px">���ش���: <%=article.getInt(Article.DOWN_NUM)%>��</td>
					</tr>
				</table>
                    	</h1>
                    	<div class="list_sdF">
                        	<div class="list_sdFL">
                            	<table border="0" cellspacing="0" cellpadding="0" width="100%" height="65">
                            		<tr>
                                    	<td align="center" valign="top"><a href='<up:attDownload packageId="<%=article.getString(Article.PACKAGE_ID) %>"/>' onclick="downNum('<%=article.getString(Article.ID) %>');"><img width="36px" height="36px" src='<cms:infoAttIcon attTypeCode="CMS_ARTICLE_ATT_ICON"/>'/></a></td>
                                    </tr>
                                </table>
                            </div>
                            <div class="list_sdFM">
                            	<p><cms:infoSummary filter="false"/></p>
                            </div>
                            <div class="list_sdFR">
                            	<%
                            		boolean isHas = AttHelper.hasAttsByPackageId(article.getString(Article.ATT_DESC));
                            		if(isHas){
                            	%>
                            	<a href='<up:attDownload packageId="<%=article.getString(Article.ATT_DESC) %>"/>'><img src="<BZ:resourcePath />/main/images/sd_btn1.gif" /></a>
                            	<%
                            		}
                            	%>
                                <a href='<up:attDownload packageId="<%=article.getString(Article.PACKAGE_ID) %>"/>' onclick="downNum('<%=article.getString(Article.ID) %>');"><img src="<BZ:resourcePath />/nw/images/sd_btn2.gif" /></a>
                            </div>
                            <div class="clr"></div>
                        </div>
                    </li>
					</cms:infoList>
                    </ul> 
                    <div class="clr"></div> 
                </div> 
                <!-- page start--> 
                <cms:infoPage formId="channelList" channelId="<%=currentChannel.getString(Channel.ID) %>">
                <div class="page">
                	��&nbsp;<cms:totalSize/>��&nbsp;
                    <a style="cursor: pointer;" onclick="<cms:pageHead/>">��ҳ</a> 
                    <a style="cursor: pointer;" onclick="<cms:pagePrevious/>">��һҳ</a>
                    <a style="cursor: pointer;" onclick="<cms:pageNext/>">��һҳ</a>
                    <a style="cursor: pointer;" onclick="<cms:pageTail/>">βҳ</a>
                    &nbsp;ת����<input type="text" id="gotoPage" value="<cms:page/>" size="3" />/<cms:pageTotal/>ҳ
                    &nbsp;<input type="button" value="�ύ" onclick="_pageGoto('channelList','',document.getElementById('gotoPage').value,<cms:pageTotal/>)"/>
                </div> 
                </cms:infoPage>
              </cms:form>
               <!-- page end--> 
            </div>
         </div> 
    </div> 
    <!--part1 end--> 
    <!--footer start--> 
    <BZ:tail />
    <!--footer end--> 
</div>
</body> 
</cms:html>