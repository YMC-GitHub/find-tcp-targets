<!--
时间：2016/5/1
版本：16.5.1.1.0
-->


<!--语句作用：引用外部文件lianjieshujuku.asp-->
<!--#include file="lianjieshujuku.asp"-->

<%
'脚本超时时间
Server.ScriptTimeOut=9999

'获取表单内容
'dna=Request.Form("DNAseq") 
'bb=Request.Form("babiaoseq")

'存储表单中的基因序列
dna=Request.Form("DNAseq") 
Set fs=Server.CreateObject("Scripting.FileSystemObject") 
Set f=fs.OpenTextFile(Server.MapPath("/db/wenben_seq_gene.txt"), 2) 
'1为只读，2为可写，8为追加，此处为2
f.write(dna) 
f.Close 
Set f=Nothing 
Set fs=Nothing

'存储表单中的靶标序列
bb=Request.Form("babiaoseq") 
Set fs=Server.CreateObject("Scripting.FileSystemObject") 
Set f=fs.OpenTextFile(Server.MapPath("/db/wenben_seq_babiao.txt"), 2) 
f.write(bb) 
f.Close 
Set f=Nothing 
Set fs=Nothing
%>


<%
'操作表单内容


'将表单中的回车符转换为空格,chr(13)为回车符
dna=replace(dna,chr(13),"")
bb=replace(bb,chr(13),"")
'开始将表单中的内容存放在数组中，以换行符为标志
dna_yx = Split(dna,Chr(10))
bb_yx = Split(bb,Chr(10))
'结果为：表单中的每一行内容被存放在了数组的每一项中

'开始声明一些数组,分别用于存放基因、靶标
xiabiao1=(Ubound(dna_yx)-1)/2				
xiabiao2=(Ubound(bb_yx)-1)/2			
redim dna_a(xiabiao1) 					'定义的数组dna_a及其大小，用于存放基因序列
redim bb_a(xiabiao2)   					'定义的数组bb_a及其大小，用于存放靶标序列
redim dna_b(xiabiao1) 					'定义的数组dna_b及其大小，用于存放基因描述信息
redim bb_b(xiabiao2)   					'定义的数组bb_b及其大小，用于存放靶标描述信息
'结束声明一些数组,分别用于存放基因、靶标

'读取数组dna_yx中的奇数下标内容放在数组dna_a中,数组下标从0开始，此处调用了程序sub_suzhu_fuzhi_jishuxiang（canshu1,canshu2）
call sub_suzhu_fuzhi_jishuxiang(dna_yx,dna_a)
'读取数组bb_yx中的奇数下标内容放在数组bb_a中，数组下标从0开始，此处调用了程序sub_suzhu_fuzhi_jishuxiang（canshu1,canshu2）
call sub_suzhu_fuzhi_jishuxiang(bb_yx,bb_a)
call sub_suzhu_fuzhi_oushuxiang(dna_yx,dna_b)
call sub_suzhu_fuzhi_oushuxiang(dna_yx,bb_b)
'声明一些数组，用于存储查找结果
redim dna_YN_bb(xiabiao1,xiabiao2)			'用于存放第i个基因序列第j个靶标序列是否存在
redim dna_cz_bb_cs(xiabiao1,xiabiao2)			'用于存放第i个基因序列第j个靶标序列存在次数
redim dna_cz_bb_wz(xiabiao1,xiabiao2)			'用于存放第i个基因序列第j个靶标序列存在的开始位置
redim dna_cz_bb_xl(xiabiao1,xiabiao2)			'用于存放第i个基因序列第j个靶标序列存在的序列内容
redim dna_YN_bb_cszhihe(xiabiao1) 			'用于存放第i个基因序列是否存在靶标序列
redim dna_cz_bb_cszhihe(xiabiao1) 			'用于存放第i个基因序列所有靶标序列总共存在次数
redim dna_cz_bb_wzzhihe(xiabiao1) 			'用于存放第i个基因序列所有靶标序列的存在位置
redim dna_cz_bb_xlzhihe(xiabiao1) 			'用于存放第i个基因序列所有靶标序列的序列内容
redim dna_YN_bb_cs(xiabiao1) 

'查找数组bb_a中的每一项内容（即每个靶标序列）在数组dna_a中的每一项内容（即每个基因序列）中的存在情况，此处调用的程序为
'sub_zifu_chazhao(canshu1,canshu2,canshu3,canshu4,canshu5,canshu6,canshu7,canshu8,canshu9,canshu10)
call sub_zifu_chazhao(dna_a,bb_a,dna_YN_bb,dna_cz_bb_cs,dna_cz_bb_wz,dna_cz_bb_xl,dna_YN_bb_cs,dna_YN_bb_cszhihe,dna_cz_bb_wzzhihe,dna_cz_bb_xlzhihe)

'对查找结果进行处理
for ki =Lbound(dna_cz_bb_xlzhihe)to Ubound(dna_cz_bb_xlzhihe)
	if  dna_YN_bb_cs(ki) = 1 then
		tzt1 =  trim(dna_cz_bb_wzzhihe(ki))
		tzt2 =  trim(dna_cz_bb_xlzhihe(ki))
		'ceshi = ceshi & dna_b(ki) &" "
		ceshi = ceshi & dna_babiao_tushi(tzt1,tzt2)
	else
		ceshi = ceshi & chr(10)
	end if
next 
%>


<%
'用到的程序


'名字：
'功能：复制另一个数组中的奇数下标的值到一个数组中(输入2个数组名)
'传入2个数组名，将shuzu1的奇数下标内容复制到shuzu2中
'代码：
Sub sub_suzhu_fuzhi_jishuxiang(shuzu1,shuzu2)
	for sub_suzhu_fuzhi_jishuxiang_i = lbound(shuzu1) to ubound(shuzu1)
		shuzu2(sub_suzhu_fuzhi_jishuxiang_i)=shuzu1(sub_suzhu_fuzhi_jishuxiang_i * 2 + 1)
	next
End Sub
'名字：
'功能：查找数组2中的每一项内容在数组1中的每一项内容中的存在情况(输入几个数组名)
'传入几个二维数组名
'dna_a为带有字符串1的一维数组
'bb_a为带有字符串2的一维数组
'dna_YN_bb是一个二维数组名，存储dna_a中的第i个字符串1中是否存在bb_a中第j个字符串2；取值为0则不存在，取值为1为存在。
'dna_cz_bb_wz是一个二维数组名，存储dna_a中的第i字符串1中存在bb_a中第j个字符串2的位置（坐标从1开始，从右往左数字逐渐变大）；取值为0则不存在
'dna_cz_bb_xl是一个二维数组名，存储dna_a中的第i字符串1中存在bb_a中第j个字符串2的内容
'dna_cz_bb_cs是一个二维数组名，存储dna_a中的第i字符串1中存在bb_a中第j个字符串2的次数
'dna_YN_bb_cs
'dna_YN_bb_cszhihe
'dna_cz_bb_wzzhihe
'dna_cz_bb_xlzhihe
'
'
'
Sub sub_zifu_chazhao(dna_a,bb_a,dna_YN_bb,dna_cz_bb_cs,dna_cz_bb_wz,dna_cz_bb_xl,dna_YN_bb_cs,dna_YN_bb_cszhihe,dna_cz_bb_wzzhihe,dna_cz_bb_xlzhihe)
'开始循环读取基因序列数组中的多条序列
for dna_a_i= Lbound(dna_a) to Ubound(dna_a)
	'信息行
	dna_a(dna_a_i)=Trim(dna_a(dna_a_i))
	line_xl_xx=dna_a(dna_a_i)
	string1=Ucase(line_xl_xx)
	
	'开始循环读取靶标序列
	for bb_a_i= Lbound(bb_a) to Ubound(bb_a)
		bb_a(bb_a_i)=Trim(bb_a(bb_a_i))
		line_bb_xl_xx=bb_a(bb_a_i)
		string2=Ucase(line_bb_xl_xx)             '靶标序列：string2 DNA序列：string1
			
		'开始查找第dna_a_i个基因序列中是否存在第bb_a_i个靶标序列
		if inStr(string1,string2) then
			'存在，则设置为1
			dna_YN_bb(dna_a_i,bb_a_i)=1
			for sub_1605020013001_n =1 to Len(string1)
				if Mid(string1,sub_1605020013001_n,Len(string2))=string2 then   
					'获得存在位置
		dna_cz_bb_wz(dna_a_i,bb_a_i)=dna_cz_bb_wz(dna_a_i,bb_a_i) & len(string1)-(sub_1605020013001_n-1)-(len(string2)) & " "
					'dna_cz_bb_wz(dna_a_i,bb_a_i)内容为"靶标序列i位置1 靶标序列i位置2 靶标序列i位置3 "
					'获得存在序列
					dna_cz_bb_xl(dna_a_i,bb_a_i)=dna_cz_bb_xl(dna_a_i,bb_a_i) & string2 & " "
					'dna_cz_bb_xl(dna_a_i,bb_a_i)内容为"靶标序列i位置1序列 靶标序列i位置2序列 靶标序列i位置3序列 "
					'获得存在次数
					dna_cz_bb_cs(dna_a_i,bb_a_i)=dna_cz_bb_cs(dna_a_i,bb_a_i) +1
					'dna_cz_bb_cs(dna_a_i,bb_a_i)内容为0或1或2...
				End if
			next
			'对滴i个基因序列中不同的靶标序列的结果进行连接，使其不会出现两个空格，而只为一个空格
			dna_cz_bb_wz(dna_a_i,bb_a_i) = trim(dna_cz_bb_wz(dna_a_i,bb_a_i))
			dna_cz_bb_xl(dna_a_i,bb_a_i) = trim(dna_cz_bb_xl(dna_a_i,bb_a_i))
		else
			dna_YN_bb(dna_a_i,bb_a_i)=0
			'获得存在位置
			'dna_cz_bb_wz(dna_a_i,bb_a_i)="" '设置不存在时的取值为空
			 dna_cz_bb_wz(dna_a_i,bb_a_i)=0  '设置不存在时的取值为0
			'获得存在序列
			'dna_cz_bb_xl(dna_a_i,bb_a_i)="" '设置不存在时的取值为空	
			'获得存在次数
			dna_cz_bb_cs(dna_a_i,bb_a_i)=0	 '设置不存在时的取值为0
		end if
		'结束查找第dna_a_i个基因序列中是否存在第bb_a_i个靶标序列
		
	next
	'结束循环读取靶标序列
next	
'结束循环读取基因序列文件中的多条序列

for i =Lbound(dna_a) to Ubound(dna_a)
	for j = Lbound(bb_a) to Ubound(bb_a)
		'若第i个基因中存在第j个靶标序列
		if   dna_YN_bb(i,j) = 1 then
			'则第i个基因中存在所输入的靶标序列
			dna_YN_bb_cs(i) =1
			'第i个基因中存在所输入的靶标序列数目
			dna_cz_bb_cszhihe(i) =dna_cz_bb_cszhihe(i) + dna_cz_bb_cs(i,j)
			'第i个基因中哪些靶标序列存在，哪些不存在
			dna_YN_bb_cszhihe(i) = dna_YN_bb_cszhihe(i) &  dna_YN_bb(i,j) & " "
			
			'第i个基因中存在的靶标序列位置
			dna_cz_bb_wzzhihe(i) = dna_cz_bb_wzzhihe(i) & dna_cz_bb_wz(i,j) & " "
			'"靶标序列i位置1 靶标序列i位置2 靶标序列i位置3 靶标序列i+1位置1 靶标序列i+1位置2 靶标序列i+1位置3 "
			'第i个基因中存在的靶标序列内容
			dna_cz_bb_xlzhihe(i) = dna_cz_bb_xlzhihe(i) & dna_cz_bb_xl(i,j)	& " "
			'"靶标序列i位置1序列 靶标序列i位置2序列 靶标序列i位置3序列 靶标序列i+1位置1序列 靶标序列i+1位置2序列 靶标序列i+1位置3序列 "
		else
			dna_YN_bb_cszhihe(i) = dna_YN_bb_cszhihe(i) &  dna_YN_bb(i,j) & " "
		end if

	next
	if dna_YN_bb_cs(i)="" then
		dna_YN_bb_cs(i)=0
		dna_cz_bb_cszhihe(i)=0
	end if	
	dna_YN_bb_cszhihe(i)=trim(dna_YN_bb_cszhihe(i))
	dna_cz_bb_wzzhihe(i) = trim(dna_cz_bb_wzzhihe(i))
	dna_cz_bb_xlzhihe(i) = trim(dna_cz_bb_xlzhihe(i))
next
End sub

'名字：sub_suzhu_bianli(suzu_wz)
'功能：遍历数组每项内容，并以变量ceshi结果
'代码：
Sub sub_suzhu_bianli(suzu_wz)
for sub_suzhu_bianli_i = Lbound(suzu_wz) to Ubound(suzu_wz)
	ceshi = ceshi & suzu_wz(sub_suzhu_bianli_i) & " "
next
End Sub
'名字：sub_suzhu_bianli_2d(suzu_wz,ceshi)
'功能：输入二维数组的名字，遍历二维数组的每项内容,结果赋值给参数2ceshi
'代码：
Sub sub_suzhu_bianli_2d(suzu_wz,ceshi)
  for sub_suzhu_bianli_2d_i = Lbound(suzu_wz) to Ubound(suzu_wz)
	for sub_suzhu_bianli_2d_j =  Lbound(suzu_wz,2) to Ubound(suzu_wz,2)
		ceshi = ceshi & suzu_wz(sub_suzhu_bianli_2d_i,sub_suzhu_bianli_2d_j) & " "	
	next
	ceshi = ceshi & chr(10)
  next
End Sub



'用到的函数

'名字：
'功能：输入2个特定格式的字符串，返回靶标在基因中的存在情况
'txt1为某一序列上存在的内容，txt2为txt1中相应内容在某一序列上存在的开始位置（序列坐标以1开始，从右往左，数字逐渐变大）
Function dna_babiao_tushi(txt1,txt2)
'清空空格
txt1=trim(txt1)
txt2=trim(txt2)

'以空格为标志，生成数组
suzu_jg_wz = split(txt1)
suzu_jg_bb = split(txt2)
suzu_jg_wz_a = split(txt1)
suzu_jg_bb_a = split(txt2)

'删除数组每一项内容中左右两边的空格空格
call sub_suzu_qingchukongge(suzu_jg_wz)
call sub_suzu_qingchukongge(suzu_jg_bb)
call sub_suzu_qingchukongge(suzu_jg_wz_a)
call sub_suzu_qingchukongge(suzu_jg_bb_a)
'排序数组内容
call sub_suzhu_paixu(suzu_jg_wz,suzu_jg_bb)
call sub_suzhu_paixu(suzu_jg_wz_a,suzu_jg_bb_a)

'遍历数组内容，测试时，检查正确与否
'ceshi= fun_suzhu_bianli(suzu_jg_wz)
'ceshi= fun_suzhu_bianli(suzu_jg_bb)
'ceshi= fun_suzhu_bianli(suzu_jg_wz_a)
'ceshi= fun_suzhu_bianli(suzu_jg_bb_a)

'拼接字符
for i = Lbound(suzu_jg_wz) to Ubound(suzu_jg_wz)-1
	'i为存储前一靶标位点数据的数组下标
	'j为存储后一靶标位点数据的数组下标
	j=i+1
	'前一序列的开始位置
	qian_ks = suzu_jg_wz(i)*1
	'前一序列的结束位置
	qian_js=suzu_jg_wz(i)*1+len(suzu_jg_bb(i))
	'后一序列的开始位置
	hou_ks=suzu_jg_wz(j)*1
	'后一序列的结束位置
	hou_js=suzu_jg_wz(j)*1+len(suzu_jg_bb(j))
	
	'ceshi = ceshi & qian_ks &" " & qian_js & " "

	'相邻靶标位点的开始位置是否相同
	if qian_ks>hou_ks then
		'远离，即序列没有交接，即前一靶标位点的开始位置大于后一靶标位点的结束位置
		if qian_ks>hou_js then
			'中间隔有其他碱基，相隔的碱基数目为
			ab_jj=qian_ks-hou_js
			'因为间隔不为0，前后两个靶标位点的序列及位置不需要修改
			'用-代替碱基，用一定的数字表示相隔的碱基个数
			'设置输出结果
		 	suzu_jg_wz_a(i)="-" & ab_jj & "-"
		'相接，即直接相连
		elseif qian_ks=hou_ks then
			'序列应该直接相连
			'将两个靶标位点合并成一个
			'合并后的靶标序列为前一个靶标位点的序列直接连上前一个靶标位点的序列，此处把合并后的靶标位点放到了后一个靶标位点的存储变量中
			suzu_jg_bb(j)=suzu_jg_bb(i) & suzu_jg_bb(j)
			'即后一个靶标位点的开始位置是有效的，而前一个靶标位点的开始位置是无效的
			'suzu_jg_wz(j)= suzu_jg_wz(j)	'本身就是有效的，不需要多余的操作一次
			suzu_jg_wz(i)= ""
			'前一个靶标位点的结束位置始是有效的，后一靶标位点的结束位置是无效的
			'后一靶标位点的序列已经修改以及开始位置已经修改，则相应的后一靶标位点的结束位置已经确定也修改了
			'靶标位点的开始位置确定，靶标序列确定，结束位置也就是确定的了。
			
			'两个靶标位点合并成了一个，原先有两个，需要清空不需要的数据
			'清空前一靶标位点，即清空存储变量中的数据
			suzu_jg_bb(i)=""
			'suzu_jg_wz(i)=""
			
			'设置输出结果
			suzu_jg_wz_a(j)=suzu_jg_wz_a(i)
			suzu_jg_wz_a(i)=""
			suzu_jg_bb_a(j)=suzu_jg_bb(j)
			suzu_jg_bb_a(i)=""
		'相交，即有重叠序列
		elseif qian_ks<hou_js then
			'因为相交，序列也应该相连，不过需要在两个序列中去掉重复序列中的一个。另外，还需要考虑两个序列的长短对各自的影响
			suzu_jg_wz_a(i)=""
			if hou_js<qian_js then
			'即前一个靶标位点不在后一个靶标位点内
				'前一个靶标位点不在后一个靶标位点内
				'将两个靶标位点进行合并成一个
				'后一个靶标位点的开始位置是有效的，前一个靶标位点的开始位置是无效的
				'suzu_jg_wz(j)=suzu_jg_wz(j)  '自身就是有效的，不需要多余操作一次
				suzu_jg_wz(i)=""
				'合并后的靶标位点为前一靶标位点自己有的序列+共同拥有的靶标序列+后一靶标位点自己有的序列
				gonggong_cd=(hou_js-hou_ks)+(qian_js-qian_ks)-(qian_js-hou_ks)
				'合并后的靶标序列为
				suzu_jg_bb(j)=suzu_jg_bb(i) & Mid(suzu_jg_bb_a(j),gonggong_cd+1)
				suzu_jg_bb(i)=""
				'设置输出结果
				suzu_jg_wz_a(j)=suzu_jg_wz_a(j)
				suzu_jg_wz_a(i)=""
				suzu_jg_bb_a(i)=""
				suzu_jg_bb_a(j)=suzu_jg_bb(j)
			elseif  hou_js>=qian_js then
			'即前一个靶标位点在后一个靶标位点内
				'前一个靶标位点在后一个靶标位点内
				'将两个靶标位点进行合并成一个
				'前一个靶标位点在前一个靶标位点内，所以合并后的靶标位点其实就是后一个靶标位点。
				'suzu_jg_bb(j)=suzu_jg_bb(j) '本身就是有效的，不需要修改
				suzu_jg_bb(i)=""
				'suzu_jg_wz(j)=suzu_jg_wz(j) '本身就是有效的，不需要修改
				suzu_jg_wz(i)=""
				'设置输出结果
				'suzu_jg_wz_a(j)=suzu_jg_wz_a(j)  '本身就是有效的，不需要修改
				suzu_jg_wz_a(i)=""
				suzu_jg_bb_a(i)=""
				'suzu_jg_bb_a(j)=suzu_jg_bb(j)   '本身就是有效的，不需要修改
				end if
 		end if	
	'相邻靶标位点的开始位置是否相同
	'数组从大到小排序过了，因此不会出现hou_ks>qian_ks的情况
	elseif hou_ks=qian_ks then
		'前一靶标位点的序列长度
		bb_cd_i=len(suzu_jg_bb(i))
		'后一靶标位点的序列长度
		bb_cd_j=len(suzu_jg_bb(j))
		if bb_cd_i>=bb_cd_j then
		'即后一靶标位点在前一靶标位点内
			'即合并后的靶标位点为前一靶标位点
			suzu_jg_bb(j)=suzu_jg_bb(i)
			suzu_jg_bb(i)=""
			'后一靶标位点的开始位置与前一靶标位点的开始位置相同，无需修改后一靶标位点的开始位置
			'suzu_jg_wz(j)=suzu_jg_wz(j) '不需要多余操作一次
			suzu_jg_wz(i)=""
			'设置输出格式
			'suzu_jg_wz_a(j)=suzu_jg_wz_a(j)  '本身就是有效的，不需要修改
			 suzu_jg_wz_a(i)=""
			 suzu_jg_bb_a(j)=suzu_jg_bb_a(i)
			 suzu_jg_bb_a(i)=""
		else
		'即前一靶标位点在后一靶标位点内
			'即合并后的靶标位点为后一靶标位点
			suzu_jg_bb(i)=""
			suzu_jg_wz(i)=""
			'设置输出格式
			'suzu_jg_wz_a(j)=suzu_jg_wz_a(j)  '本身就是有效的，不需要修改
			'suzu_jg_bb_a(j)=suzu_jg_bb_a(j)  '本身就是有效的，不需要修改
			 suzu_jg_wz_a(i)=""
			 suzu_jg_bb_a(i)=""
		end if
	end if
next

result_f="5' "
for i = Lbound(suzu_jg_wz) to Ubound(suzu_jg_wz)
			if  i= Ubound(suzu_jg_wz) then
				suzu_jg_wz(i)="-" & suzu_jg_wz(i) & "-"
				suzu_jg_wz_a(i)="-" & suzu_jg_wz_a(i) & "-"
			end if
			result_f=result_f & suzu_jg_bb_a(i) & suzu_jg_wz_a(i)	
next
result_f=result_f & " 3'"
result2=result2 & result_f & "<br>"
'函数名：dna_babiao_tushi 
dna_babiao_tushi = result2
'ceshi = result2


'清空内容
'txt1=""
'txt2=""
'suzu_jg_wz = split(txt1)
'suzu_jg_bb = split(txt2)
'suzu_jg_wz_a = split(txt1)
'suzu_jg_bb_a = split(txt2)
End Function

'名字：fun_suzhu_bianli(suzu_wz)
'功能：输入一维数组的名字，遍历数组每项内容,并返回内容
Function fun_suzhu_bianli(suzu_wz)
	for fun_suzhu_bianli_i = Lbound(suzu_wz) to Ubound(suzu_wz)
		'fun_suzhu_bianli = fun_suzhu_bianli & suzu_wz(fun_suzhu_bianli_i) & "<br>"
		fun_suzhu_bianli = fun_suzhu_bianli & suzu_wz(fun_suzhu_bianli_i) & chr(10)
	next
End Function
'名字：fun_suzhu_bianli_2d(suzu_wz)
'功能：输入二维数组的名字，遍历数组每项内容,并返回内容
Function fun_suzhu_bianli_2d(suzu_wz)
	for fun_suzhu_bianli_i = Lbound(suzu_wz) to Ubound(suzu_wz)
	    for fun_suzhu_bianli_j = Lbound(suzu_wz,2) to Ubound(suzu_wz,2)
		fun_suzhu_bianli_2d = fun_suzhu_bianli_2d & suzu_wz(fun_suzhu_bianli_i,fun_suzhu_bianli_j) & " "
	    next
	'fun_suzhu_bianli_2d = fun_suzhu_bianli_2d & "<br>"
	fun_suzhu_bianli_2d = fun_suzhu_bianli_2d & chr(10)	
	next
End Function


'名字：fun_zifu_suzu_shuzi_paixu(txt)
'功能：输入一串固定格式的数字字符串 "字符1 字符2 字符3 字符i "，对字符内容按照数字从大到小进行排序,返回一个字符串结果
Function fun_zifu_suzu_shuzi_paixu(txt)
	txt=Trim(txt)
	suzhu=split(txt)
	'排序内容
	call sub_suzhu_paixu(suzhu)
	'遍历内容
	'dim ceshi
	'call sub_suzhu_bianli(suzhu)
	ceshi=fun_suzhu_bianli(suzhu)
	fun_zifu_suzu_shuzi_paixu=ceshi
End Function


'名字：
'功能：在程序外定义一个全局变量数组 ，传入数组名字，清空数组的每一项内容中左右两边存在的空格
'定义的全局变量数组名字为suzu_jg_wz
Sub sub_suzu_qingchukongge(suzu_jg_wz) 
   for i = Lbound(suzu_jg_wz) to Ubound(suzu_jg_wz)
	suzu_jg_wz(i)=Trim(suzu_jg_wz(i))
   next
End sub

'数组-------排序
'名字：sub_suzhu_paixu_2d(suzu_wz)
'功能：输入二维数组名，将二维数组的第二维的值从大到小排序
Sub sub_suzhu_paixu_2d(suzu_wz)
for n = Lbound(suzu_wz) to Ubound(suzu_wz)
	for i = Lbound(suzu_wz,2) to Ubound(suzu_wz,2)
		for j = i to Ubound(suzu_wz,2)
			if suzu_wz(n,i)*1<suzu_wz(n,j)*1 then
		 	jh_wz=suzu_wz(n,i)
			suzu_wz(n,i)=suzu_wz(n,j)
			suzu_wz(n,j)=jh_wz
			end if		
		next
	next
next
End Sub
'名字：sub_suzhu_paixu(suzu_wz)
'功能：一维数组从大到小排序
Sub sub_suzhu_paixu(suzu_wz)
for i = Lbound(suzu_wz) to Ubound(suzu_wz)
	for j = i to Ubound(suzu_wz)
		if suzu_wz(i)*1<suzu_wz(j)*1 then
		 	jh_wz=suzu_wz(i)
			suzu_wz(i)=suzu_wz(j)
			suzu_wz(j)=jh_wz
		end if		
	next
next
End Sub
'名字：sub_suzhu_paixu(suzu_wz,suzu_bb)
'功能：一维数组从大到小排序，输入2个数组名，第一个数组为数字型数组，数组的大小相同，第二个数组与第一个数组的元素一一对应
Sub sub_suzhu_paixu(suzu_wz,suzu_bb)
for i = Lbound(suzu_wz) to Ubound(suzu_wz)
	for j = i to Ubound(suzu_wz)
		if suzu_wz(i)*1<suzu_wz(j)*1 then
		 	jh_wz=suzu_wz(i)
			suzu_wz(i)=suzu_wz(j)
			suzu_wz(j)=jh_wz
			jh_wz=suzu_bb(i)
			suzu_bb(i)=suzu_bb(j)
			suzu_bb(j)=jh_wz
		end if		
	next
next
End Sub
'名字sub_zifu_suzu_shuzi_paixu(txt)
'功能：在程序外定义一个全局变量"dim ceshi"，输入一串固定格式的数字字符串 "字符1 字符2 字符3 字符i "，对字符内容按照数字从大到小进行排序,返回的字符赋值给变量ceshi
Sub sub_zifu_suzu_shuzi_paixu(txt)
	txt=Trim(txt)
	'生成数组
	suzhu=split(txt)
	'排序内容
	call sub_suzhu_paixu(suzhu)
	ceshi=fun_suzhu_bianli(suzhu)
End Sub

'数组----复制数组的值
'名字：sub_suzhu_fuzhi(suzhu1,suzhu2)
'功能：输入2个数组名，复制suzhu1中的值到suzhu2中
Sub sub_suzhu_fuzhi(suzhu1,suzhu2)
	for sub_suzhu_fuzhi_i = lbound(suzhu1) to ubound(suzhu1)
		suzhu2(sub_suzhu_fuzhi_i)=suzhu1(sub_suzhu_fuzhi_i)
	next
End Sub
'名字：sub_suzhu_fuzhi_jishuxiang(suzhu1,suzhu2)
'功能：输入2个数组名，复制suzhu1中的奇数下标的值到suzhu2中
Sub sub_suzhu_fuzhi_jishuxiang(suzhu1,suzhu2)
	for sub_suzhu_fuzhi_jishuxiang_i = lbound(suzhu1) to ubound(suzhu1)
		suzhu2(sub_suzhu_fuzhi_jishuxiang_i)=suzhu1(sub_suzhu_fuzhi_jishuxiang_i * 2 + 1)
	next
End Sub
'名字：sub_suzhu_fuzhi_oushuxiang(suzhu1,suzhu_2)
'功能：输入2个数组名，复制suzhu1中的偶数下标的值到suzhu_2中
Sub sub_suzhu_fuzhi_oushuxiang(suzhu1,suzhu_2)
	for sub_suzhu_fuzhi_oushuxiang_i = lbound(suzhu1) to ubound(suzhu1)
		suzhu_2(sub_suzhu_fuzhi_oushuxiang_i)=suzhu1(sub_suzhu_fuzhi_oushuxiang_i*2)
	next
End Sub
%>





<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    	<title>寻找靶标</title>
	<link href="css/css_body_2.css" rel="stylesheet" type="text/css" />
<%
dim geshi
geshi=Request.Form("geshi")
%>
</head>
<body   bgcolor="#CCFFCC">
<div id="d_bd_bd">
 	 <p>&nbsp;</p>
 	 <p>&nbsp;</p>
 	 <p>&nbsp;</p>
  	 <p>&nbsp;</p>
  	 <p>&nbsp;</p> 
  


<div   style="color:#FFF; background-color: #93C;">查找结果</div>
  <div style=" text-align: left;overflow:auto;">是否存在：<pre><%=fun_suzhu_bianli(dna_YN_bb_cs)%></pre></div>
  	<div style=" text-align: left;overflow:auto; ">哪些存在：<pre><%=fun_suzhu_bianli_2d(dna_YN_bb) %></pre></div>
  	<div style=" text-align: left;overflow:auto; ">存在次数：<pre><%=fun_suzhu_bianli_2d(dna_cz_bb_cs) %></pre></div>
  <div style=" text-align: left;overflow:auto; ">存在位置：<pre><%=ceshi %></pre></div>

<div   style="color:#FFF; background-color: #93C;">输入内容</div>
  <div   align="left" style="color:#FFF; background-color: #360;">DNA序列：</div>
	<div   style="color:#FFF; text-align: left; width: 100%;overflow: auto; max-height: 100px;"><pre><% =dna %></pre></div>
	<div   align="left" style="color:#FFF; background-color: #360;">靶标序列：</div>
	<div   style="color:#FFF; text-align: left; width: 100%; overflow: auto;max-height: 100px;"><pre><% =bb %></pre></div>


</body>
</html>