<%
nr=Request.Form("DNAseq") 
if nr<>"" then
nr0=nr
Set fs=Server.CreateObject("Scripting.FileSystemObject") 
Set f=fs.OpenTextFile(Server.MapPath("/db/wenben_hb_chushi.txt"), 2) 
f.write(nr) 
f.Close 
Set f=Nothing 
Set fs=Nothing




Set fs=Server.CreateObject("Scripting.FileSystemObject") 
Set f=fs.OpenTextFile(Server.MapPath("/db/wenben_hb_chushi.txt"), 1) 

Set fs222=Server.CreateObject("Scripting.FileSystemObject") 
Set f222=fs222.OpenTextFile(Server.MapPath("/db/wenben_hb_jieguo.txt"), 2) 

do while f.AtEndOfStream = false
	line_bb_ms=f.Line 
	line_bb_ms_xx=f.ReadLine
	line_bb_xl=f.Line 
	line_bb_xl_xx=f.ReadLine		
	nr=Ucase(line_bb_xl_xx) 
	
	Yy=Yy & line_bb_ms_xx &"<br>" & Ucase(line_bb_xl_xx) & "<br>"
	
	nr=UCase(nr)
	nr=StrReverse(nr)
	nr=Replace(nr,"A","m")
	nr=Replace(nr,"T","A")
	nr=Replace(nr,"m","T")
	nr=Replace(nr,"C","m")
	nr=Replace(nr,"G","C")
	nr=Replace(nr,"m","G")
	f222.writeline(line_bb_ms_xx) 
	f222.writeline(nr)
	hb=hb & line_bb_ms_xx &"<br>" & "(原DNA链为5'--3')" & "<br>" &"原有DNA链:"& Ucase(line_bb_xl_xx) & "<br>" & "互补的DNA:" & StrReverse(nr) & "<br>"
	hb53=hb53 & line_bb_ms_xx &"<br>" & nr & "<br>"
	
	
	
loop

f222.Close 
Set f222=Nothing 
Set fs222=Nothing
f.Close 
Set f=Nothing 
Set fs=Nothing

end if 
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>获互补链结果</title>
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
     
<div   style="color:#FFF; background-color: #93C;">DNA的原有链</div>
  <div   align="left" style="color:#FFF; background-color: #360;">(5'--3')</div>
	<div   style="color:#FFF; text-align: left; width: 100%; overflow: scroll; max-height: 100px;"><pre><% =Yy %></pre></div>
<div   style="color:#FFF; background-color: #93C;">DNA的互补链</div>
<div   align="left" style="color:#FFF; background-color: #360;">(5'--3')</div>
  <div style=" text-align: left;overflow: scroll; max-height: 100px;"><pre><%=hb53%></pre></div>
<div   style="color:#FFF; background-color: #93C;">DNA碱基配对</div>
  <div style=" text-align: left;overflow: scroll; max-height: 100px;"><pre><%=hb%></pre></div>

</div>
</body>
</html>