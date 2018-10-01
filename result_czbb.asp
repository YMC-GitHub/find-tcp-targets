<%
Server.ScriptTimeOut=9999
%>




<%
if Request.Form("DNAseq") <>"" then

nr=Request.Form("DNAseq") 
Set fs=Server.CreateObject("Scripting.FileSystemObject") 
Set f=fs.OpenTextFile(Server.MapPath("/db/wenben_FindBaBiao_gene.txt"), 2) 
f.write(nr) 
f.Close 
Set f=Nothing 
Set fs=Nothing

bb=Request.Form("babiaoseq") 
Set fs=Server.CreateObject("Scripting.FileSystemObject") 
Set f=fs.OpenTextFile(Server.MapPath("/db/wenben_FindBaBiao_babiao.txt"), 2) 
f.write(bb) 
f.Close 
Set f=Nothing 
Set fs=Nothing

%>

<%
'打开DNA序列文本文件：gene.txt.读取DNA序列内容，显示在网页上
Set fgene=Server.CreateObject("Scripting.FileSystemObject")
Set fg=fgene.OpenTextFile(Server.MapPath("/db/wenben_FindBaBiao_gene.txt"), 1)
do while fg.AtEndOfStream = false
	DNA_seq_ms_xuhao=((fg.Line+1)/2) 
	DNA_seq_ms_xinxi=fg.ReadLine
	DNA_seq_xx_xuhao=fg.Line 
	DNA_seq_xx_xinxi=fg.ReadLine
	DNA_seq_xx=DNA_seq_xx &"<br>" & "DNA序列序号"
	DNA_seq_ms_xuhao_number=len(DNA_seq_ms_xuhao)
	
	select case DNA_seq_ms_xuhao_number
		 	case 1
				DNA_seq_xx=DNA_seq_xx & ("         ")& DNA_seq_ms_xuhao & "："& left(DNA_seq_ms_xinxi,80) & "<br>" & DNA_seq_xx_xinxi
			case 2
				DNA_seq_xx=DNA_seq_xx & ("        ") & DNA_seq_ms_xuhao & "："& left(DNA_seq_ms_xinxi,80) & "<br>" & DNA_seq_xx_xinxi
 			case 3
				DNA_seq_xx=DNA_seq_xx & ("       ") & DNA_seq_ms_xuhao & "："& left(DNA_seq_ms_xinxi,80) & "<br>" & DNA_seq_xx_xinxi
 			case 4
				DNA_seq_xx=DNA_seq_xx & ("      ") & DNA_seq_ms_xuhao & "："& left(DNA_seq_ms_xinxi,80) & "<br>" & DNA_seq_xx_xinxi
 			case 5
				DNA_seq_xx=DNA_seq_xx & ("     ") & DNA_seq_ms_xuhao & "："& left(DNA_seq_ms_xinxi,80) & "<br>" & DNA_seq_xx_xinxi
			case 6
				DNA_seq_xx=DNA_seq_xx & ("    ") & DNA_seq_ms_xuhao & "："& left(DNA_seq_ms_xinxi,80) & "<br>" & DNA_seq_xx_xinxi
 			case 7
				DNA_seq_xx=DNA_seq_xx & ("   ") & DNA_seq_ms_xuhao & "："& left(DNA_seq_ms_xinxi,80) & "<br>" & DNA_seq_xx_xinxi
 			case 8
				DNA_seq_xx=DNA_seq_xx & ("  ") & DNA_seq_ms_xuhao & "："& left(DNA_seq_ms_xinxi,80) & "<br>" & DNA_seq_xx_xinxi
 			case 9
				DNA_seq_xx=DNA_seq_xx & (" ") & DNA_seq_ms_xuhao & "："& left(DNA_seq_ms_xinxi,80) & "<br>" & DNA_seq_xx_xinxi
 			case Else
				DNA_seq_xx=DNA_seq_xx & DNA_seq_ms_xuhao & "："& left(DNA_seq_ms_xinxi,80) & "<br>" & DNA_seq_xx_xinxi
		end select
loop
'此loop为循环DNA序列文件
'关闭DNA序列所在文本
fg.Close
Set fg=Nothing
Set fgene=Nothing

'打开靶标序列文件，读取靶标序列，显示在网页上
Set fs=Server.CreateObject("Scripting.FileSystemObject")
Set f=fs.OpenTextFile(Server.MapPath("/db/wenben_FindBaBiao_babiao.txt"), 1)
	babiao_seq_xx=f.ReadAll
f.Close
Set f=Nothing
Set fs=Nothing










'打开DNA序列文本文件：gene.txt
Set fgene=Server.CreateObject("Scripting.FileSystemObject")
Set fg=fgene.OpenTextFile(Server.MapPath("/db/wenben_FindBaBiao_gene.txt"), 1)


'打开文本文件：wenben_FindBaBiao_jieguo.txt。存储查询结果
Set fgene11111=Server.CreateObject("Scripting.FileSystemObject")
Set fg11111=fgene11111.OpenTextFile(Server.MapPath("/db/wenben_FindBaBiao_jieguo.txt"), 2)
	'在结果文本中写入当前日期
	fg11111.WriteLine(Date)
	'写入存储格式
	fg11111.WriteLine("DNA序列序号            ")

'开始循环读取DNA序列文件中的多条序列	
do while fg.AtEndOfStream = false
	line_ms=fg.Line 
	line_ms_xx=fg.ReadLine
	line_xl=fg.Line 
	line_xl_xx=fg.ReadLine
	alltext=alltext & ((line_ms+1)/2) & line_ms_xx &"<br>" + line_xl_xx + "<br>"
	string1=Ucase(line_xl_xx)   '靶标序列：string2 DNA序列：string1
	
	
	
	
	'在结果文本中写入第一条DNA序列序号
	fg11111.Write("DNA序列序号：")
	'设置DNA序列序号长度为10
	'查询的DNA序列数量长度
	'正在查询DNA的序列序号
	'正在查询DNA的序列长度
	seq_xuhao=((line_ms+1)/2)
	seq_number=len(seq_xuhao)
	seq_changdu=len(line_xl_xx)
	ms=seq_xuhao
	if request.Form(chaozhaobabiao_geshi1)=1 then
		ms=left(line_ms_xx,15)
		fg11111.Write(ms)
	else
		select case seq_number
		 	case 1
				fg11111.Write("         ")
				fg11111.Write(seq_xuhao)
			case 2
				fg11111.Write("        ")
				fg11111.Write(seq_xuhao)
 			case 3
 				fg11111.Write("       ")
				fg11111.Write(seq_xuhao)
 			case 4
				fg11111.Write("      ")
				fg11111.Write(seq_xuhao)
 			case 5
				fg11111.Write("     ")
				fg11111.Write(seq_xuhao)
			case 6
				fg11111.Write("    ")
				fg11111.Write(seq_xuhao)
 			case 7
 				fg11111.Write("   ")
				fg11111.Write(seq_xuhao)
 			case 8
				fg11111.Write("  ")
				fg11111.Write(seq_xuhao)
 			case 9
				fg11111.Write(" ")
				fg11111.Write(seq_xuhao)
 			case Else
				fg11111.Write(right(seq_xuhao))
		end select
		end if

		'打开靶标序列文件：babiao.txt。读取靶标序列，并查找	
		Set fs=Server.CreateObject("Scripting.FileSystemObject")
		Set f=fs.OpenTextFile(Server.MapPath("/db/wenben_FindBaBiao_babiao.txt"), 1)
		do while f.AtEndOfStream = false
			line_bb_ms=f.Line 
			line_bb_ms_xx=f.ReadLine
			line_bb_xl=f.Line 
			line_bb_xl_xx=f.ReadLine
			babiaoxinxi=babiaoxinxi & "靶标序列在文本中的序号："&((line_bb_ms+1)/2) & "<br> "&line_bb_ms_xx &"<br>" + line_bb_xl_xx + "<br>"
			string2=Ucase(line_bb_xl_xx)             '靶标序列：string2 DNA序列：string1

	
		'查找DNA序列中是否存在靶标序列	
	if inStr(string1,string2) then        '若DNA序列中存在靶标序列，查看存在次数      
		for n =1 to Len(string1)
			if Mid(string1,n,Len(string2))=string2 then   
				weizhi_cs=weizhi_cs+1
			End if
		next
	else							'若DNA序列中不存在该靶标序列，设置存在次数weizhi_cs为0
		weizhi_cs=0
	end if
	
	 

	'设置存储结果文件的写入查询结果格式，并写入
	seq_cs_number=len(weizhi_cs)
		select case seq_cs_number
		 	case 1
				fg11111.Write("    ")
				fg11111.Write(weizhi_cs)
			case 2
				fg11111.Write("   ")
				fg11111.Write(weizhi_cs)
 			case 3
 				fg11111.Write("  ")
				fg11111.Write(weizhi_cs)
 			case 4
				fg11111.Write(" ")
				fg11111.Write(weizhi_cs)
 			case 5
				fg11111.Write(weizhi_cs)
 			case Else
				'查询结果中存在次数超过5位数字
				fg11111.Write("55555")
		end select 
	  '将查询结果写入存储文件：wenben_FindBaBiao_jieguo.txt
	  '清空字符串weizhi_cs上一次的次数
	   weizhi_cs=0
	        
	
%>
<%
loop
'此loop为循环靶标序列文件
f.Close
Set f=Nothing
Set fs=Nothing
			'关闭靶标序列所在文本
			'在存储文件：wenben_FindBaBiao_jieguo.txt中写入换行，将每个DNA序列的查询结果分行。
	 		 fg11111.Writeline("")  
			 '清空字符串string1上一次的序列
			 string1=""     
loop
'此loop为循环DNA序列文件
'结束循环读取DNA序列文件中的多条序列



'关闭存储结果文本
fg11111.Close
Set fg11111=Nothing
Set fgene11111=Nothing
'关闭DNA序列所在文本
f.Close
Set fg=Nothing
Set fgene=Nothing





'打开文本文件：wenben_FindBaBiao_jieguo.txt。读取查询结果
Set fgene11111=Server.CreateObject("Scripting.FileSystemObject")
Set fg11111=fgene11111.OpenTextFile(Server.MapPath("/db/wenben_FindBaBiao_jieguo.txt"), 1)
	'在结果文本中写入当前日期
	bb_jieguo=fg11111.ReadAll
fg11111.Close
Set fg11111=Nothing
Set fgene11111=Nothing
end if 
%>











<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=uftf-8" />
    <title>靶标查找</title>
	<link href="css/css_body_2.css" rel="stylesheet" type="text/css" />
	<style type="text/css">
	#apDiv1 {
	position:absolute;
	width:200px;
	height:115px;
	z-index:1;
	left: 988px;
	top: 175px;
}
    </style>
</head>
<body   bgcolor="#CCFFCC">
<div id="d_bd_bd">
 	 <p>&nbsp;</p>
 	 <p>&nbsp;</p>
 	 <p>&nbsp;</p>
  	 <p>&nbsp;</p>
  	 <p>&nbsp;</p>
     



<div   style="color:#FFF; background-color: #93C;">靶标寻找结果</div>
<% if Request.Form("DNAseq") <>"" then%>
  <div style=" text-align: left;overflow: scroll; "><pre>
  <%=bb_jieguo%></pre></div>
<div   style="color:#FFF; background-color: #93C;">输入序列内容</div>
  <div   align="left" style="color:#FFF; background-color: #360;">DNA序列：</div>
	<div   style="color:#FFF; text-align: left; width: 100%; overflow: scroll; max-height: 100px;"><pre><% =DNA_seq_xx %></pre></div>
	<div   align="left" style="color:#FFF; background-color: #360;">靶标序列：</div>
	<div   style="color:#FFF; text-align: left; width: 100%; overflow: scroll; max-height: 100px;"><pre><% =babiao_seq_xx %></pre></div>
    <div   align="left" style="color:#FFF; background-color: #360;"></div>
<% 
end if 
%>

</div>
</body>
</html>