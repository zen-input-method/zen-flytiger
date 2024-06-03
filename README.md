# 禅意鹤虎输入法 (zen-flytiger)

本输入法由 pimgeek 基于国标 6763 高频汉字、小鹤双拼编码规则和虎码形码编码规则综合定制生成，其主要优化目标是减少“选择困难”。对于熟练使用双拼打字的用户，可以用虎码形码筛选同音但不同形的单字/词组，从而更少使用候选/翻页等操作，甚至实现单字完全盲打。

## 功能特点

1. 内含国标 6763 高频单字和 535912 个常用词组（来自雾凇拼音基础版）。
1. 单字全码输入：小鹤双拼确定读音，虎码首末字根确定字形，候选列表默认显示 3 项 (设为 0 可练习盲打)
1. 词组全码输入：2 字词采用声韵声韵编码格式，3 字词采用声-声-声-韵，4 词采用声-声-声-声
1. 支持以 `` ` `` 号实现虎码反查
1. 支持以 `~` 号进入英文长句输入模式 (连按两次空格键或一次回车键可退出)
1. 支持以 `;` 引导表情符号输入模式 (编码符号对照表 `shared_emoji.txt`)
1. 支持以 `;rq` 输入当前日期，以 `;zt` 输入当前时间，以 `;zd` 或 `;zz` 在输入日期的同时附加小时分钟

----

## 注意事项

❶ 双拼输入存在单字多音的情况，为 6763 高频汉字分配多种读音后，共有 7223 条单字编码记录

❷ 在这 7223 条单字记录中，有 6476 条记录采用 “声母码+韵母码+首根大码+二根大码” 的编码方式（对于单根字则采用 “声母码+韵母码+字根大码+字根小码” 编码方式），可以完全无冲突地打出来

❸ 排除这 6476 条单字记录，还剩 747 条记录存在形码冲突，绝大部分采用追加末根小码方式完全消除冲突，即采用 “声母码+韵母码+首根大码+末根大码+末根小码” 形式 (对于单根字则采用 “声母码+韵母码+字根大码+字根小码+二次使用字根小码” 形式)，追加末根小码仍然无法去重的单字，采用追加无理码方式

> 例如：北 ➠ bwav，背 ➠ bwavy，模 ➠ muem，木 ➠ muemm

因为引入了无理码，所以这 747 条记录无法简单总结编码规律，文末直接列举了所有去重编码供参考 (必要时可自行设置去重编码，直接修改 flytiger.dict.yaml 文件即可)

❹ 特别常用的汉字被分配了单字母编码，比如 我 ➠ w，你 ➠ n，他 ➠ t 等等，这些被称为一简字，共有 26 个编码

❺ 排除一简字后的常用字，被分配了双字母编码，比如 好 ➠ hc，有 ➠ yz，爱 ➠ ai 等等，这些被称为二简字，共有 407 个编码

❻ 排除一简字/二简字后的常用字，被分配了三字母编码，比如：常 ➠ ihs，读 ➠ dus，书 ➠ uua， 等等，这些被称为三简字，共有 4246 个编码

❼ 无论是否出现在一、二、三简字列表中，所有 6763 高频汉字都拥有独一无二的“全码”，其中有 6834 个四码字，396 个五码字，共有 7230 个编码

❽ 为提高常用词的输入效率，增加了 67880 个常规词组编码，编码形式有 3 种：

> 首字声母+首字韵母+二字声母+二字韵母，比如 走运 ➠ zzyy，猜想 ➠ cdxl，寄托 ➠ jito 等等
> 首字声母+二字声母+三字声母+三字韵母，比如 纪录片 ➠ jlpm，纯净水 ➠ ijuv，连锁店 ➠ lsdm 等等
> 首字声母+二字声母+三字声母+末字声母，比如 刨根问底 ➠ izzx，阿拉伯数字 ➠ albz，俯首甘为孺子牛 ➠ fugn 等等
> 如果输入了 4 位编码后得到的首选项并非真正想要的词组，可以在编码末尾追加形码，比如：
>
> `uiui ➠ 1 实施, 2 事实, 3 实时, 4 试试, 5 时事, ...`
> 
> 为了免于输入候选编号，可以在打词时追加首末字形码：
>
> `uiuifw ➠ 事实, uiuiss ➠ 试试, uiuiof ➠ 时事`


如果对默认的编码方式不满意，可以在 flytiger.dict.yaml 文件中加入自定义编码，格式为：

> 单字	单字编码	顺序号
> 词组	词组编码	顺序号

顺序号为正整数，有顺序号的编码就比无编码的更优先；顺序号越大越优先 (即：出现在候选列表中更靠近眼前的位置)。

----

## 形码有冲突的单字列表

形码有冲突的单字 + 去重前后的编码对比

```diff
氨	anvb		氨	anvb
胺	anvb	|	胺	anvbn
熬	aoac		熬	aoac
螯	aoac	|	螯	aoacc
奥	aotm		奥	aotm
袄	aotm	|	袄	aotmd
耙	baam		耙	baam
疤	baam	|	疤	baamb
茇	bali		茇	bali
菝	bali	|	菝	balid
苞	bclv		苞	bclv
龅	bclv	|	龅	bclvs
曝	bcok		曝	bcok
暴	bcok	|	暴	bcoks
褒	bcte		褒	bcte
褓	bcte	|	褓	bctem
佰	bdju		佰	bdju
伯	bdju	|	伯	bdjub
荸	bilh		荸	bilh
蔽	bilh	|	蔽	bilhp
荜	biln		荜	biln
萆	biln	|	萆	bilns
薜	biln	|	薜	bilnx
篦	birv		篦	birv
笔	birv	|	笔	birvm
毙	bivv		毙	bivv
比	bivv	|	比	bivvb
庇	bixv		庇	bixv
秕	bixv	|	秕	bixvb
瘢	bjar		瘢	bjar
版	bjar	|	版	bjary
舨	bjir		舨	bjir
般	bjir	|	般	bjirs
斑	bjnn		斑	bjnn
班	bjnn	|	班	bjnnw
瓣	bjnn	|	瓣	bjnnx
搬	bjur		搬	bjur
扳	bjur	|	扳	bjury
煸	bmci		煸	bmci
蝙	bmci	|	蝙	bmcic
扁	bmmi		扁	bmmi
碥	bmmi	|	碥	bmmic
辩	bmnn		辩	bmnn
辫	bmnn	|	辫	bmnni
辨	bmnn	|	辨	bmnnp
埔	bugn		埔	bugn
埠	bugn	|	埠	bugns
北	bwav		北	bwav
背	bwav	|	背	bwavy
悖	bwhh		悖	bwhh
惫	bwhh	|	惫	bwhhx
陂	bwtr		陂	bwtr
被	bwtr	|	被	bwtrp
裁	cdnt		裁	cdnt
才	cdnt	|	才	cdntp
彩	cdye		彩	cdye
采	cdye	|	采	cdyem
仓	chjz		仓	chjz
伧	chjz	|	伧	chjzj
粲	cjgp		粲	cjgp
残	cjgp	|	残	cjgpg
骢	csnh		骢	csnh
璁	csnh	|	璁	csnhx
刂	dcpd		刂	dcpd
刀	dcpd	|	刀	dcpdd
殆	ddgd		殆	ddgd
歹	ddgd	|	歹	ddgdd
黛	ddjp		黛	ddjp
代	ddjp	|	代	ddjpi
谠	dhsp		谠	dhsp
党	dhsp	|	党	dhspe
邸	dibt		邸	dibt
娣	dibt	|	娣	dibtf
坻	digi		坻	digi
羝	digi	|	羝	digid
缔	diir		缔	diir
帝	diir	|	帝	diirj
的	diui		的	diui
抵	diui	|	抵	diuid
惮	djhn		惮	djhn
单	djhn	|	单	djhns
眈	djqp		眈	djqp
耽	djqp	|	耽	djqpe
膻	djvf		膻	djvf
胆	djvf	|	胆	djvfi
鼎	dkqa		鼎	dkqa
耵	dkqa	|	耵	dkqae
盯	dkqa	|	盯	dkqam
町	dkqa	|	町	dkqat
貂	dnmd		貂	dnmd
碉	dnmd	|	碉	dnmdk
鲷	dnwd		鲷	dnwd
凋	dnwd	|	凋	dnwdk
懂	dshd		懂	dshd
恫	dshd	|	恫	dshdk
峒	dsvd		峒	dsvd
胴	dsvd	|	胴	dsvdk
岽	dsvy		岽	dsvy
胨	dsvy	|	胨	dsvyx
敦	dvgh		敦	dvgh
憝	dvgh	|	憝	dvghx
墩	dygh		墩	dygh
敦	dygh	|	敦	dyghp
鼢	ffpp		鼢	ffpp
粉	ffpp	|	粉	ffppd
烽	fgca		烽	fgca
蜂	fgca	|	蜂	fgcaf
舫	fhil		舫	fhil
纺	fhil	|	纺	fhilf
鲂	fhwl		鲂	fhwl
彷	fhwl	|	彷	fhwlf
梵	fjei		梵	fjei
繁	fjei	|	繁	fjeis
藩	fjlq		藩	fjlq
蕃	fjlq	|	蕃	fjlqt
畈	fjqr		畈	fjqr
饭	fjqr	|	饭	fjqry
蜉	fuch		蜉	fuch
蚨	fuch	|	蚨	fuchf
蝮	fuch	|	蝮	fuchi
桴	fueh		桴	fueh
复	fueh	|	复	fuehi
斧	fuht		斧	fuht
怫	fuht	|	怫	fuhtf
傅	fujk		傅	fujk
俯	fujk	|	俯	fujkc
付	fujk	|	付	fujkr
莩	fulh		莩	fulh
芙	fulh	|	芙	fulhf
芾	fulr		芾	fulr
菔	fulr	|	菔	fulry
袱	futm		袱	futm
艴	futm	|	艴	futmb
肤	fuvh		肤	fuvh
覆	fuvh	|	覆	fuvhx
腹	fuvh	|	腹	fuvhy
馥	fuxh		馥	fuxh
稃	fuxh	|	稃	fuxhi
凫	fuxo		凫	fuxo
负	fuxo	|	负	fuxob
芾	fwlr		芾	fwlr
菲	fwlr	|	菲	fwlrf
肺	fwvr		肺	fwvr
腓	fwvr	|	腓	fwvrf
盖	gega		盖	gega
圪	gega	|	圪	gegai
泔	gjkz		泔	gjkz
淦	gjkz	|	淦	gjkzj
国	gori		国	gori
帼	gori	|	帼	gorid
冠	grwk		冠	grwk
官	grwk	|	官	grwki
鳏	grwk	|	鳏	grwks
恭	gslh		恭	gslh
共	gslh	|	共	gslhb
攻	gsuh		攻	gsuh
拱	gsuh	|	拱	gsuhb
崮	guvc		崮	guvc
臌	guvc	|	臌	guvci
罟	guyc		罟	guyc
轱	guyc	|	轱	guycc
酤	guyc	|	酤	guycy
锢	guzc		锢	guzc
钴	guzc	|	钴	guzcg
闺	gvag		闺	gvag
鬼	gvag	|	鬼	gvagg
鲑	gvwg		鲑	gvwg
龟	gvwg	|	龟	gvwgg
笱	gzrg		笱	gzrg
篝	gzrg	|	篝	gzrgt
豪	hcgj		豪	hcgj
壕	hcgj	|	壕	hcgjs
咳	hddk		咳	hddk
嗨	hddk	|	嗨	hddkm
胲	hdvk		胲	hdvk
氦	hdvk	|	氦	hdvkh
嗬	hedz		嗬	hedz
呵	hedz	|	呵	hedzk
菏	helz		菏	helz
荷	helz	|	荷	helzk
憨	hjah		憨	hjah
阚	hjah	|	阚	hjahp
鼾	hjoe		鼾	hjoe
旱	hjoe	|	旱	hjoeg
撼	hjuh		撼	hjuh
撖	hjuh	|	撖	hjuhp
蝗	hlcn		蝗	hlcn
蟥	hlcn	|	蟥	hlcnh
煌	hlcn	|	煌	hlcnw
湟	hlkn		湟	hlkn
潢	hlkn	|	潢	hlknh
篁	hlrn		篁	hlrn
簧	hlrn	|	簧	hlrnh
鳇	hlwn		鳇	hlwn
徨	hlwn	|	徨	hlwnw
灬	hoch		灬	hoch
火	hoch	|	火	hochh
蝴	hucv		蝴	hucv
胡	hucv	|	胡	hucvg
煳	hucv	|	煳	hucvy
浒	hukn		浒	hukn
滹	hukn	|	滹	hukns
瓠	humy		瓠	humy
狐	humy	|	狐	humyg
笏	hure		笏	hure
囫	hure	|	囫	hures
虍	huzh		虍	huzh
虎	huzh	|	虎	huzhh
婚	hybo		婚	hybo
昏	hybo	|	昏	hybor
侯	hzjo		侯	hzjo
候	hzjo	|	候	hzjos
嚓	iadf		嚓	iadf
喳	iadf	|	喳	iadfi
楂	iaef		楂	iaef
查	iaef	|	查	iaefi
檫	iaef	|	檫	iaefs
猹	iamf		猹	iamf
碴	iamf	|	碴	iamfi
骋	igna		骋	igna
成	igna	|	成	ignae
盛	igna	|	盛	ignam
哧	iidc		哧	iidc
嗤	iidc	|	嗤	iidcc
饬	iiqs		饬	iiqs
耻	iiqs	|	耻	iiqsi
巛	iroc		巛	iroc
川	iroc	|	川	irocc
椎	iveu		椎	iveu
槌	iveu	|	槌	iveuc
俦	izjk		俦	izjk
仇	izjk	|	仇	izjkj
帱	izrk		帱	izrk
筹	izrk	|	筹	izrkc
烬	jbcw		烬	jbcw
尽	jbcw	|	尽	jbcwb
筋	jbrs		筋	jbrs
劲	jbrs	|	劲	jbrsl
钅	jbzj		钅	jbzj
金	jbzj	|	金	jbzjj
给	jiid		给	jiid
既	jiid	|	既	jiidu
缉	jiiq		缉	jiiq
畿	jiiq	|	畿	jiiqt
芨	jilc		芨	jilc
丌	jilc	|	丌	jilcc
芰	jilc	|	芰	jilci
藉	jilo		藉	jilo
蒺	jilo	|	蒺	jilos
蕺	jilp		蕺	jilp
蓟	jilp	|	蓟	jilpd
赍	jino		赍	jino
玑	jino	|	玑	jinoj
畸	jiqz		畸	jiqz
犄	jiqz	|	犄	jiqzk
鲫	jiwz		鲫	jiwz
寄	jiwz	|	寄	jiwzk
季	jixh		季	jixh
积	jixh	|	积	jixhb
稷	jixh	|	稷	jixhi
急	jixh	|	急	jixhx
稽	jixo		稽	jixo
麂	jixo	|	麂	jixoj
憬	jkhy		憬	jkhy
惊	jkhy	|	惊	jkhyx
浆	jlak		浆	jlak
将	jlak	|	将	jlakc
戋	jmfp		戋	jmfp
戬	jmfp	|	戬	jmfpg
煎	jmhc		煎	jmhc
兼	jmhc	|	兼	jmhch
牮	jmjq		牮	jmjq
件	jmjq	|	件	jmjqn
溅	jmkp		溅	jmkp
湔	jmkp	|	湔	jmkpd
蒹	jmlc		蒹	jmlc
茧	jmlc	|	茧	jmlcc
箭	jmrp		箭	jmrp
笺	jmrp	|	笺	jmrpg
毽	jmvu		毽	jmvu
腱	jmvu	|	腱	jmvuy
剿	jnop		剿	jnop
矫	jnop	|	矫	jnopd
喈	jpdu		喈	jpdu
嗟	jpdu	|	嗟	jpdug
旧	jqgo		旧	jqgo
就	jqgo	|	就	jqgoy
隽	jruv		隽	jruv
捐	jruv	|	捐	jruvy
橘	jued		橘	jued
桔	jued	|	桔	juedk
苴	julf		苴	julf
龃	julf	|	龃	julfq
犋	juqh		犋	juqh
具	juqh	|	具	juqhb
岬	jxvs		岬	jxvs
胛	jxvs	|	胛	jxvsj
喀	kads		喀	kads
咯	kads	|	咯	kadsg
恺	kdhv		恺	kdhv
忾	kdhv	|	忾	kdhvq
棵	keee		棵	keee
窠	keee	|	窠	keeem
钪	khzo		钪	khzo
亢	khzo	|	亢	khzoj
会	kkjb		会	kkjb
侩	kkjb	|	侩	kkjby
诓	klsn		诓	klsn
诳	klsn	|	诳	klsnw
馗	kvko		馗	kvko
溃	kvko	|	溃	kvkob
聩	kvqo		聩	kvqo
馈	kvqo	|	馈	kvqob
粼	lbpo		粼	lbpo
临	lbpo	|	临	lbpor
遴	lbpu		遴	lbpu
躏	lbpu	|	躏	lbpui
嶙	lbvv		嶙	lbvv
膦	lbvv	|	膦	lbvvk
耢	lcas		耢	lcas
痨	lcas	|	痨	lcasl
落	lcls		落	lcls
劳	lcls	|	劳	lclsl
癞	ldao		癞	ldao
赉	ldao	|	赉	ldaob
嘞	leds		嘞	leds
叻	leds	|	叻	ledsl
蒗	lhli		蒗	lhli
莨	lhli	|	莨	lhlig
疠	liap		疠	liap
痢	liap	|	痢	liapd
蜊	licp		蜊	licp
蛎	licp	|	蛎	licpd
哩	lidd		哩	lidd
喱	lidd	|	喱	liddl
俐	lijp		俐	lijp
例	lijp	|	例	lijpd
荔	lils		荔	lils
苈	lils	|	苈	lilsl
砺	limp		砺	limp
猁	limp	|	猁	limpd
璃	linv		璃	linv
骊	linv	|	骊	linvy
厉	lixp		厉	lixp
利	lixp	|	利	lixpd
黧	lixp	|	黧	lixph
历	lixs		历	lixs
励	lixs	|	励	lixsl
伶	lkjk		伶	lkjk
令	lkjk	|	令	lkjks
苓	lklk		苓	lklk
龄	lklk	|	龄	lklks
鲮	lkwh		鲮	lkwh
凌	lkwh	|	凌	lkwhi
踉	llpi		踉	llpi
粮	llpi	|	粮	llpig
珞	lons		珞	lons
骆	lons	|	骆	lonsg
鬣	lppp		鬣	lppp
趔	lppp	|	趔	lpppd
躐	lppp	|	躐	lppps
隆	lstl		隆	lstl
龙	lstl	|	龙	lstll
轳	luyc		轳	luyc
卢	luyc	|	卢	luycs
辘	luyx		辘	luyx
鸬	luyx	|	鸬	luyxn
耧	lzab		耧	lzab
瘘	lzab	|	瘘	lzabn
骂	madn		骂	madn
吗	madn	|	吗	madnm
犸	mamn		犸	mamn
码	mamn	|	码	mamnm
民	mbdm		民	mbdm
黾	mbdm	|	黾	mbdmm
蟊	mcic		蟊	mcic
蝥	mcic	|	蝥	mcicc
耄	mcqv		耄	mcqv
牦	mcqv	|	牦	mcqvm
茫	mhlf		茫	mhlf
芒	mhlf	|	芒	mhlfw
名	mkld		名	mkld
茗	mkld	|	茗	mkldk
耱	moam		耱	moam
瘼	moam	|	瘼	moamd
蘑	molm		蘑	molm
莫	molm	|	莫	molmd
磨	mozm		磨	mozm
镆	mozm	|	镆	mozmd
模	muem		模	muem
木	muem	|	木	muemm
牡	muqg		牡	muqg
睦	muqg	|	睦	muqgt
钼	muzq		钼	muzq
亩	muzq	|	亩	muzqt
梅	mwek		梅	mwek
每	mwek	|	每	mwekm
恁	nbjh		恁	nbjh
您	nbjh	|	您	nbjhx
甯	nkwt		甯	nkwt
凝	nkwt	|	凝	nkwts
怒	nubh		怒	nubh
孥	nubh	|	孥	nubhi
瓯	ounr		瓯	ounr
殴	ounr	|	殴	ounrs
拚	pbul		拚	pbul
拼	pbul	|	拼	pbulc
匏	pcmv		匏	pcmv
狍	pcmv	|	狍	pcmvs
迫	pduu		迫	pduu
拍	pduu	|	拍	pduub
蜱	picn		蜱	picn
辟	picn	|	辟	picnx
屁	picv		屁	picv
蚍	picv	|	蚍	picvb
噼	pidn		噼	pidn
啤	pidn	|	啤	pidns
貔	pimv		貔	pimv
砒	pimv	|	砒	pimvb
裨	pitn		裨	pitn
陴	pitn	|	陴	pitns
霹	pitn	|	霹	pitnx
丬	pjap		丬	pjap
爿	pjap	|	爿	pjapp
襻	pjtu		襻	pjtu
袢	pjtu	|	袢	pjtus
平	pkeh		平	pkeh
枰	pkeh	|	枰	pkehb
萍	pklh		萍	pklh
苹	pklh	|	苹	pklhb
攴	puhp		攴	puhp
攵	puhp	|	攵	puhpp
溥	pukk		溥	pukk
瀑	pukk	|	瀑	pukks
莆	puln		莆	puln
蒲	puln	|	蒲	pulnk
葡	puln	|	葡	pulnn
曝	puok		曝	puok
暴	puok	|	暴	puoks
栖	qiev		栖	qiev
杞	qiev	|	杞	qievj
桤	qiev	|	桤	qievv
祁	qift		祁	qift
祈	qift	|	祈	qiftj
芪	qilb		芪	qilb
萋	qilb	|	萋	qilbn
萁	qilh		萁	qilh
旗	qilh	|	旗	qilhb
荠	qilq		荠	qilq
葺	qilq	|	葺	qilqe
砌	qimp		砌	qimp
亓	qimp	|	亓	qimpd
琪	qinh		琪	qinh
骐	qinh	|	骐	qinhb
琦	qinz		琦	qinz
骑	qinz	|	骑	qinzk
脐	qivq		脐	qivq
气	qivq	|	气	qivqq
岂	qivv		岂	qivv
屺	qivv	|	屺	qivvj
圊	qkrv		圊	qkrv
箐	qkrv	|	箐	qkrvy
肷	qmve		肷	qmve
嵌	qmve	|	嵌	qmveq
憔	qnhc		憔	qnhc
愀	qnhc	|	愀	qnhch
鞒	qntp		鞒	qntp
乔	qntp	|	乔	qntpd
犭	qrmq		犭	qrmq
犬	qrmq	|	犬	qrmqq
辁	qryn		辁	qryn
醛	qryn	|	醛	qrynw
瘸	qtaj		瘸	qtaj
缺	qtaj	|	缺	qtajr
区	qunb		区	qunb
驱	qunb	|	驱	qunbi
亻	rfjr		亻	rfjr
人	rfjr	|	人	rfjrr
衽	rftg		衽	rftg
壬	rftg	|	壬	rftgs
肜	rsve		肜	rsve
嵘	rsve	|	嵘	rsvem
蹂	rzpe		蹂	rzpe
糅	rzpe	|	糅	rzpem
缲	scie		缲	scie
缫	scie	|	缫	sciem
隧	svtu		隧	svtu
随	svtu	|	随	svtuc
瞍	szqr		瞍	szqr
馊	szqr	|	馊	szqry
缇	tiit		缇	tiit
绨	tiit	|	绨	tiitf
毯	tjvc		毯	tjvc
炭	tjvc	|	炭	tjvch
蜓	tkcu		蜓	tkcu
烃	tkcu	|	烃	tkcug
霆	tktu		霆	tktu
廷	tktu	|	廷	tktuy
舔	tmah		舔	tmah
阗	tmah	|	阗	tmahb
龆	tnld		龆	tnld
苕	tnld	|	苕	tnldk
柁	toev		柁	toev
椭	toev	|	椭	toevy
侗	tsjd		侗	tsjd
僮	tsjd	|	僮	tsjdl
裟	uakt		裟	uakt
沙	uakt	|	沙	uaktp
深	ufke		深	ufke
参	ufke	|	参	ufkes
渗	ufke	|	渗	ufkke
矧	ufog		矧	ufog
申	ufog	|	申	ufogs
甥	ugls		甥	ugls
生	ugls	|	生	uglss
墒	uhgd		墒	uhgd
垧	uhgd	|	垧	uhgdk
示	uifs		示	uifs
礻	uifs	|	礻	uifss
贳	uilo		贳	uilo
蓍	uilo	|	蓍	uilor
饣	uiqs		饣	uiqs
食	uiqs	|	食	uiqss
誓	uius		誓	uius
势	uius	|	势	uiusl
逝	uiuu		逝	uiuu
拭	uiuu	|	拭	uiuug
市	uizr		市	uizr
铈	uizr	|	铈	uizrj
潸	ujkv		潸	ujkv
汕	ujkv	|	汕	ujkvs
薯	uulo		薯	uulo
蔬	uulo	|	蔬	uuloc
曙	uuoo		曙	uuoo
暑	uuoo	|	暑	uuoor
水	uvks		水	uvks
氵	uvks	|	氵	uvkss
扌	uzus		扌	uzus
手	uzus	|	手	uzuss
蚱	vacw		蚱	vacw
炸	vacw	|	炸	vacwa
吒	vadr		吒	vadr
咤	vadr	|	咤	vadrq
查	vaef		查	vaef
楂	vaef	|	楂	vaefi
蛰	veuc		蛰	veuc
蜇	veuc	|	蜇	veucc
窒	viey		窒	viey
桎	viey	|	桎	vieyi
栉	viez		栉	viez
栀	viez	|	栀	viezj
殖	vigf		殖	vigf
埴	vigf	|	埴	vigfi
帙	virh		帙	virh
帜	virh	|	帜	virhb
执	viui		执	viui
絷	viui	|	絷	viuis
贽	viuo		贽	viuo
指	viuo	|	指	viuor
肢	vivc		肢	vivc
炙	vivc	|	炙	vivch
脂	vivo		脂	vivo
旨	vivo	|	旨	vivor
致	viyh		致	viyh
轵	viyh	|	轵	viyhb
斩	vjyt		斩	vjyt
辗	vjyt	|	辗	vjyti
奘	vlam		奘	vlam
状	vlam	|	状	vlamq
专	vrmi		专	vrmi
砖	vrmi	|	砖	vrmid
蛀	vucn		蛀	vucn
炷	vucn	|	炷	vucnw
术	vuei		术	vuei
杼	vuei	|	杼	vueiv
舳	vuid		舳	vuid
丶	vuid	|	丶	vuidd
渚	vuko		渚	vuko
潴	vuko	|	潴	vukor
皖	wjup		皖	wjup
挽	wjup	|	挽	wjupe
剜	wjwp		剜	wjwp
完	wjwp	|	完	wjwpe
怃	wuhd		怃	wuhd
悟	wuhd	|	悟	wuhdk
吾	wuwd		吾	wuwd
寤	wuwd	|	寤	wuwdk
伪	wwji		伪	wwji
位	wwji	|	位	wwjil
洧	wwkv		洧	wwkv
渭	wwkv	|	渭	wwkvy
萎	wwlb		萎	wwlb
葳	wwlb	|	葳	wwlbn
帏	wwrg		帏	wwrg
围	wwrg	|	围	wwrgw
嵬	wwva		嵬	wwva
巍	wwva	|	巍	wwvag
忄	xbhx		忄	xbhx
心	xbhx	|	心	xbhxx
熄	xich		熄	xich
蟋	xich	|	蟋	xichx
螅	xich	|	螅	xicoh
鼷	xipm		鼷	xipm
蹊	xipm	|	蹊	xipmd
饩	xiqv		饩	xiqv
牺	xiqv	|	牺	xiqvx
稀	xixr		稀	xixr
席	xixr	|	席	xixrj
惺	xkhl		惺	xkhl
性	xkhl	|	性	xkhls
缃	xliq		缃	xliq
飨	xliq	|	飨	xliqs
痫	xmae		痫	xmae
闲	xmae	|	闲	xmaem
馅	xmqp		馅	xmqp
先	xmqp	|	先	xmqpe
宪	xmwp		宪	xmwp
冼	xmwp	|	冼	xmwpe
啸	xndh		啸	xndh
哮	xndh	|	哮	xndhi
淆	xnkv		淆	xnkv
消	xnkv	|	消	xnkvy
筱	xnrh		筱	xnrh
箫	xnrh	|	箫	xnrhb
泻	xpkf		泻	xpkf
瀣	xpkf	|	瀣	xpkfi
廨	xpxq		廨	xpxq
解	xpxq	|	解	xpxqn
修	xqje		修	xqje
休	xqje	|	休	xqjem
铉	xrzi		铉	xrzi
玄	xrzi	|	玄	xrziy
硖	xxmh		硖	xxmh
狭	xxmh	|	狭	xxmhb
埙	xygo		埙	xygo
殉	xygo	|	殉	xygor
薰	xylp		薰	xylp
熏	xylp	|	熏	xylph
驯	xyno		驯	xyno
旬	xyno	|	旬	xynor
询	xyso		询	xyso
训	xyso	|	训	xysoc
雅	yalu		雅	yalu
迓	yalu	|	迓	yaluc
崾	ycvb		崾	ycvb
要	ycvb	|	要	ycvbx
腰	ycvb	|	腰	ycvby
鳐	ycwa		鳐	ycwa
徭	ycwa	|	徭	ycwaf
烊	yhcg		烊	yhcg
蛘	yhcg	|	蛘	yhcgy
熠	yicu		熠	yicu
遗	yicu	|	遗	yicuc
尾	yicv		尾	yicv
蛇	yicv	|	蛇	yicvb
呓	yida		呓	yida
嗌	yida	|	嗌	yidam
殪	yigz		殪	yigz
壹	yigz	|	壹	yigzd
舣	yiib		舣	yiib
义	yiib	|	义	yiibi
仡	yija		仡	yija
亿	yija	|	亿	yijai
依	yijt		依	yijt
伊	yijt	|	伊	yijtp
溢	yika		溢	yika
益	yika	|	益	yikam
饴	yiqd		饴	yiqd
眙	yiqd	|	眙	yiqdk
衤	yiti		衤	yiti
衣	yiti	|	衣	yitii
胰	yivb		胰	yivb
肄	yivb	|	肄	yivbv
疑	yivt		疑	yivt
嶷	yivt	|	嶷	yivts
钇	yiza		钇	yiza
镒	yiza	|	镒	yizam
翼	yizh		翼	yizh
镱	yizh	|	镱	yizhx
弈	yizl		弈	yizl
羿	yizl	|	羿	yizlc
阎	yjap		阎	yjap
兖	yjap	|	兖	yjape
炎	yjcc		炎	yjcc
焱	yjcc	|	焱	yjcch
讠	yjsy		讠	yjsy
言	yjsy	|	言	yjsyy
腌	yjva		腌	yjva
崦	yjva	|	崦	yjvae
胭	yjvm		胭	yjvm
岩	yjvm	|	岩	yjvms
嬴	ykfi		嬴	ykfi
赢	ykfi	|	赢	ykfid
滢	ykki		滢	ykki
瀛	ykki	|	瀛	ykkid
潆	ykki	|	潆	ykkis
荧	yklc		荧	yklc
萤	yklc	|	萤	yklcc
莹	ykli		莹	ykli
萦	ykli	|	萦	yklis
颖	ykvw		颖	ykvw
颍	ykvw	|	颍	ykvwy
渊	yrkp		渊	yrkp
沅	yrkp	|	沅	yrkpe
俑	ysjt		俑	ysjt
佣	ysjt	|	佣	ysjty
涌	yskt		涌	yskt
甬	yskt	|	甬	yskty
粥	yubb		粥	yubb
妪	yubb	|	妪	yubbi
聿	yubv		聿	yubv
肀	yubv	|	肀	yubvv
育	yubv	|	育	yubvy
窬	yuep		窬	yuep
榆	yuep	|	榆	yuepd
预	yuiw		预	yuiw
豫	yuiw	|	豫	yuiwx
淤	yukw		淤	yukw
渔	yukw	|	渔	yukwv
於	yulw		於	yulw
蓣	yulw	|	蓣	yulwy
禹	yutv		禹	yutv
隅	yutv	|	隅	yutvr
雨	yutv	|	雨	yutvv
寓	yuwv	|	寓	yuwvr
鱼	yuwv	|	鱼	yuwvv
悠	yzjh		悠	yzjh
攸	yzjh	|	攸	yzjhp
尢	yzoy		尢	yzoy
尤	yzoy	|	尤	yzoyy
帻	zero		帻	zero
箦	zero	|	箦	zerob
憎	zgho		憎	zgho
曾	zgho	|	曾	zghor
孜	zihh		孜	zihh
孳	zihh	|	孳	zihhi
兹	zihi		兹	zihi
子	zihi	|	子	zihii
茈	zilv		茈	zilv
龇	zilv	|	龇	zilvb
字	ziwh		字	ziwh
恣	ziwh	|	恣	ziwhx
趱	zjpo		趱	zjpo
糌	zjpo	|	糌	zjpor
粽	zspf		粽	zspf
鬃	zspf	|	鬃	zspfs
踪	zspf	|	踪	zspfz
```
