<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>获互补链</title>
	<link href="css/css_body_2.css" rel="stylesheet" type="text/css" />
    <script language="javascript">
	function CheckForm(frm)
{
    if(frm.DNAseq.value=="")
    {
        alert("序列不能为空！");
        frm.DNAseq.focus();
        return false;
     }
}
	</script>
</head>
<body   bgcolor="#CCFFCC">


<div id="d_bd_bd">
 	 <p>&nbsp;功能：获取DNA一条链的互补链<br></p>
 	 <p>&nbsp;</p>
 	 <p>&nbsp;</p>
  	 <p>&nbsp;</p>
  	 <p>&nbsp;</p>
<!--DNA序列输入表单-->
<div style="text-align:left">
在此输入DNA、蛋白质序列：（FASTA格式）
</div>
<div>
 	<form name="DNAseq_find_hubulian"  action="result_hhbl.asp" method="post" onsubmit="return CheckForm(this);">
    <div>
    <textarea name="DNAseq" cols="100" rows="20"></textarea>
    <input name="form_name" type="hidden" value="DNAseq_find_hubulian" />
    </div>
    <div>
    <input name="search" type="submit"  value="Get"/>
    </div>
    </form>
</div>

<div   style="text-align:left">
说明：（FASTA格式）
<br>一个序列开始于位于行首的&gt;，结束语于另一个&gt;或输入内容结尾。
<br>以&gt;所在的一行作为序列的描述介绍，另起一行到下一个&gt;或输入内容结尾为序列内容。
</div>
<div  style="text-align:left; overflow:scroll">
举例：
</div>
</div>
</body>
</html>
