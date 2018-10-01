<!--#include file="lianjieshujuku.asp"-->
<%
nr=Request.Form("DNAseqweizhi") 
if nr<>"" then
nnn0=nr
Set fs=Server.CreateObject("Scripting.FileSystemObject") 
Set f=fs.OpenTextFile(Server.MapPath("/db/wenben_wz_chushi.txt"), 2) 
f.write(nr) 
f.Close 
Set f=Nothing 
Set fs=Nothing




Set fs=Server.CreateObject("Scripting.FileSystemObject") 
Set f=fs.OpenTextFile(Server.MapPath("/db/wenben_wz_chushi.txt"), 1) 

Set fs222=Server.CreateObject("Scripting.FileSystemObject") 
Set f222=fs222.OpenTextFile(Server.MapPath("/db/wenben_wz_jieguo.txt"), 2) 
	xlwz=""
	wz_cs=""
do while f.AtEndOfStream = false
	line_bb_ms=f.Line 
	line_bb_ms_xx=f.ReadLine
	line_bb_ms_xx=LTrim(line_bb_ms_xx)
	line_bb_ms_xx=RTrim(line_bb_ms_xx)	
	line_bb_ms_xx=Replace(line_bb_ms_xx,",","")
	line_bb_ms_xx=Replace(line_bb_ms_xx,"，","")
	nr=line_bb_ms_xx
	wz_cs=wz_cs & "<br>" & nr
	xlwz=xlwz & "<br>" & nr
	if Right(line_bb_ms_xx,1)="0" then	   
	   nr2=Mid(nr,InStr(nr,":")+1,InStr(nr,"..")-6-1)
	   'f222.writeline(nr2)
	   nr1=nr2*1-2000
	   'f222.writeline(nr1)
	   nr2=nr2*1+5
	   'f222.writeline(nr2)
	   nr0=left(nr,6)&nr1& ".."&nr2
	   f222.writeline(nr0)
	   ranseti=Mid(line_bb_ms_xx,4,2)
	   '
		Set fggg=Server.CreateObject("Scripting.FileSystemObject") 
		Set fg=fggg.OpenTextFile(Server.MapPath("/db/chr"& ranseti &".txt"), 1)
		ranseti_seq=fg.ReadAll
		qidongzi_seq=Mid(ranseti_seq,nr1,2006)
		fg.close
		set fg=nothing
		set fggg=nothing
	    qidongzi=qidongzi & "<br>>" & nr0 &"<br>" &qidongzi_seq
	   
	   nr2=""
	   nr1=""
	   nr0=""
	elseif Right(line_bb_ms_xx,1)="1" then
	   nr=Left(nr,len(nr)-1)
	   nr=LTrim(nr)
	   nr=RTrim(nr)
	   nr1=Mid(nr,InStr(nr,".")+2,len(nr)-InStr(nr,".")-1)
	   'f222.writeline(nr1)
	   nr2=nr1*1+2000
	   nr1=nr1*1-5
	   nr0=left(nr,6)&nr1& ".."&nr2
	   f222.writeline(nr0)
	   '
	   ranseti=Mid(line_bb_ms_xx,4,2)
		Set fggg=Server.CreateObject("Scripting.FileSystemObject") 
		Set fg=fggg.OpenTextFile(Server.MapPath("/db/chr"& ranseti &".txt"), 1)
		fg.Readline
		ranseti_seq=fg.ReadAll
		qidongzi_seq=Mid(ranseti_seq,nr1,2006)
		fg.close
		set fg=nothing
		set fggg=nothing
		qidongzi=qidongzi & "<br>>" & nr0 &"<br>" &qidongzi_seq
	   nr2=""
	   nr1=""
	   nr0=""
	end if
	nr=""
	
loop

f222.Close 
Set f222=Nothing 
Set fs222=Nothing
f.Close 
Set f=Nothing 
Set fs=Nothing

Set fs=Server.CreateObject("Scripting.FileSystemObject") 
Set f=fs.OpenTextFile(Server.MapPath("/db/wenben_wz_jieguo.txt"), 1) 
nnn1=f.ReadAll
f.Close 
Set f=Nothing 
Set fs=Nothing











end if 
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>获取序列结果</title>
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
<div   style="color:#FFF; background-color: #93C;">修改前的DNA位置(基因序列位置)</div>
	<div   style="color:#FFF; text-align: left; width: 100%; overflow: scroll; max-height: 100px;"><pre><% =nnn0 %></pre></div>
<div   style="color:#FFF; background-color: #93C;">修改后的DNA位置（上游2000bp区）</div>
	<div   style="color:#FFF; text-align: left; width: 100%; overflow: scroll; max-height: 100px;"><pre><% =nnn1 %></pre></div>
<div   style="color:#FFF; background-color: #93C;">基因上游2000bp位置的DNA序列</div>
<div   align="left" style="color:#FFF; background-color: #360;">(5'--3')</div>
  <div style=" text-align: left;overflow: scroll; max-height: 100px;"><pre><%=qidongzi%></pre></div>
</div>
</body>
</html>