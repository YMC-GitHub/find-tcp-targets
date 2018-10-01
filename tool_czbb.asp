<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>查找靶标</title>
	<link href="css/css_body_2.css" rel="stylesheet" type="text/css" />
     <script language="javascript">
	function CheckForm(frm)
{
    if(frm.DNAseq.value=="")
    {
        alert("DNA序列不能为空！");
        frm.DNAseq.focus();
        return false;
     }
	 if(frm.babiaoseq.value=="")
    {
        alert("靶标序列不能为空！");
        frm.babiaoseq.focus();
        return false;
     }
}
	</script>
</head>
<body   bgcolor="#CCFFCC">
<div id="d_bd_bd">
 	 <p>&nbsp;功能：在某一序列中查找是否存在另一序列<br></p>
 	 <p>&nbsp;</p>
 	 <p>&nbsp;</p>
  	 <p>&nbsp;</p>
  	 <p>&nbsp;</p>
<!--DNA序列输入表单-->

<div>
 	<form name="DNAseq_find_babiao"  action="result_czbb.asp" method="post" onsubmit="return CheckForm(this);">
    <div>
<div style="text-align:left">
在此输入DNA序列：（FASTA格式）
</div>
    <textarea name="DNAseq" cols="100" rows="20"></textarea>
<div style="text-align:left">
在此输入靶标序列：（FASTA格式）
</div>
    <textarea name="babiaoseq" cols="100" rows="10"></textarea>
    <input name="form_name" type="hidden" value="DNAseq_find_babiao" />
    </div>
    <div>
    <input name="search" type="submit"  value="Search"/>
    </div>
    </form>
</div>
<div   style="text-align:left">
说明：（FASTA格式）
<br>fasta文件开始于位于行首的&gt;。
<br>fasta文件结束语于另一个&gt;或输入内容结尾。
<br>在fasta文件内，以&gt;所在的一行作为序列的描述。
<br>在fasta文件内，&gt;的下一行开始为序列的内容。
<br>一个序列的内容需要写在一行。
</div>
<div  style="text-align:left; overflow:scroll">
</div>
</div>
</body>
</html>
