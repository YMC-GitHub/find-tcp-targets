
<%Server.ScriptTimeOut=100%> 
<%
'获取表单内容
nr=Request.Form("DNAseq") 
'打开文本文件：wenben_yh_chushi.txt
'写入表单内容
Set fs=Server.CreateObject("Scripting.FileSystemObject") 
Set f=fs.OpenTextFile(Server.MapPath("/db/wenben_yh_chushi.txt"), 2) 
f.write(nr) 
f.Close 
Set f=Nothing 
Set fs=Nothing
%>

<%
'打开本文件：chushi.txt，
'进行修改
Set fgene=Server.CreateObject("Scripting.FileSystemObject")
Set fg=fgene.OpenTextFile(Server.MapPath("/db/wenben_yh_chushi.txt"), 1)

'打开文本，写入修改内容
set fsss=Server.CreateObject("Scripting.FileSystemObject")
set fs=fsss.OpenTextFile(Server.MapPath("/db/wenben_yh_jieguo.txt"),2)

do while fg.AtEndOfStream = false
	string1=fg.ReadLine
	string2=">"
	if inStr(string1,string2)=false then        '若没有含有>符号      
		line_xg_xl_xinxi=line_xg_xl_xinxi & string1
	else
		'设置怎么将多段序列安排好
		'第一次line_xg_ms_xinxi是空的
		if  line_xg_xl_xinxi="" then
			line_xg_ms_xinxi=string1
					'fs.WriteLine:把修改内容写入文本
					fs.WriteLine(string1)
		else 
		'第一次line_xg_ms_xinxi不是空的
			line_xg_ms_xinxi=line_xg_ms_xinxi &  "<br>" &line_xg_xl_xinxi  &  "<br>" &string1
					'fs.WriteLine:把修改内容写入文本
				 	fs.WriteLine(line_xg_xl_xinxi)
					fs.WriteLine(string1)
			
		'把line_xg_xl_xinxi清空，避免与其他基因序列相连
			line_xg_xl_xinxi=""
		end if
	end if 
loop
	 '最后一段序号后面没有序列了，所以后面没有>符号，还需要加上最后一段的序列
	 line_xg_ms_xinxi=line_xg_ms_xinxi & "<br>" &line_xg_xl_xinxi
	 				'fs.WriteLine:把修改内容写入文本
	 				fs.WriteLine(line_xg_xl_xinxi)
fs.Close
Set fs=Nothing
Set fsss=Nothing
	 'xiugai=replace(xiugai,">","<br>>") '把字符串中间的>变成<br>>
	 'xiugai=line_xg_ms_xinxi & "<br>" &line_xg_xl_xinxi
     xiugai=line_xg_ms_xinxi
%>
<%
fg.Close
Set fg=Nothing
Set fgene=Nothing
'关闭初始的文本文件
%>

<%
'readAll
'打开初始的文本文件：
Set fgene=Server.CreateObject("Scripting.FileSystemObject")
Set fg=fgene.OpenTextFile(Server.MapPath("/db/wenben_yh_chushi.txt"), 1)
	chushi=fg.ReadAll
fg.Close
Set fg=Nothing
Set fgene=Nothing
'关闭初始的文本文件
%>


<%
'打开存储结果文本文件：
Set fgene=Server.CreateObject("Scripting.FileSystemObject")
Set fg=fgene.OpenTextFile(Server.MapPath("/db/wenben_yh_jieguo.txt"), 1)
	jieguo=fg.ReadAll
fg.Close
Set fg=Nothing
Set fgene=Nothing
'关闭存储结果文本文件
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>多变一结果</title>
	<link href="css/css_body_2.css" rel="stylesheet" type="text/css" /></head>
	<body   bgcolor="#CCFFCC">
	<div id="d_bd_bd">
 	 <p>&nbsp;</p>
 	 <p>&nbsp;</p>
 	 <p>&nbsp;</p>
  	 <p>&nbsp;</p>
  	 <p>&nbsp;</p>
    <div   style="color:#FFF; background-color:#F3C; font-size:24px">文本内容修改前情况</div>
	<div align="left" style=" height:300px;overflow:scroll" ><pre><%=chushi%></pre></div>   
	<!--把初始文本写入页面:<pre> </pre>;ReadLine;Readall;Read(5)-->

 	<div  style="color:#FFF; background-color:#F3C; font-size:24px">文本内容改后情况</div>
	<div name="xiugai"align="left" style="overflow:scroll"><pre><%=jieguo%></pre></div> 
    <!--显示修改后的内容-->
</div>
</body>
</html>
