<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>获取序列</title>
	<link href="css/css_body_2.css" rel="stylesheet" type="text/css" />
    <script language="javascript">
	function CheckForm(frm)
{
    if(frm.DNAseqweizhi.value=="")
    {
        alert("序列位置不能为空！");
        frm.DNAseqweizhi.focus();
        return false;
     }
}
	</script>
</head>
<body   bgcolor="#CCFFCC">


<div id="d_bd_bd">
 	 <p>&nbsp;功能：获取特定位置的DNA序列<br></p>
 	 <p>&nbsp;</p>
 	 <p>&nbsp;</p>
  	 <p>&nbsp;</p>
  	 <p>&nbsp;</p>
<!--DNA序列输入表单-->
<div style="text-align:left">
在此输入DNA序列在染色体上的位置：
</div>
<div>
 	<form name="DNAseq_get_seq"  action="result_hqxx.asp" method="post" onsubmit="return CheckForm(this);">
    <div>
    <textarea name="DNAseqweizhi" cols="100" rows="20"></textarea>
    <input name="form_name" type="hidden" value="DNAseq_get_seq" />
    </div>
    <div>
    <input name="search" type="submit"  value="Get"/>
    </div>
    </form>
</div>

<div   style="text-align:left">
举例：
<br>Chr10:628000..678650 
<br>Chr10:628000..678650 
<br>chr10:18,935,690..18,942,571
</div>
<div  style="text-align:left; overflow:scroll">
</div>
</div>
</body>
</html>
