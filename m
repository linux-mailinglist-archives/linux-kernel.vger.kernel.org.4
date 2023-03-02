Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A23F6A78EC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 02:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbjCBBiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 20:38:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjCBBiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 20:38:16 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E682E2310E
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 17:38:13 -0800 (PST)
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230302013811epoutp03553db3c0793d8153a94455739584b1b1~IdnGHhE1V2858028580epoutp03g
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 01:38:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230302013811epoutp03553db3c0793d8153a94455739584b1b1~IdnGHhE1V2858028580epoutp03g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1677721091;
        bh=Upm4LHqrFj+Ba7ZBgyJPHcoCjI/gROHC2Z7FPc4nVX8=;
        h=From:To:In-Reply-To:Subject:Date:References:From;
        b=lYeEDw0pw+o6LHYmp1W2zwkRRmJV9teMpBuPCiXhfM6XUt3IQC1l7c03mwugtY8la
         uCsQ++hIB4miP3JClMjgbvhRIK29NiQ1IYrWZ6qStlgSijyp4d/ZZeSoyuEsvlNemw
         1HJBYo1O/FBBmMojviwhwmWavpJPvP8BWPJamnk0=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20230302013810epcas1p33430e99dcd3c4e9aec0ad6ec1661fe89~IdnFxhrX-1012510125epcas1p3M;
        Thu,  2 Mar 2023 01:38:10 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.38.248]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4PRtz568wzz4x9QG; Thu,  2 Mar
        2023 01:38:09 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        FB.4C.54823.10EFFF36; Thu,  2 Mar 2023 10:38:09 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230302013809epcas1p1d0c8fac83192cae6fa5efaed17840509~IdnEhhSt71453714537epcas1p14;
        Thu,  2 Mar 2023 01:38:09 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230302013809epsmtrp192b5b2219d935a294d44c9b21bd16744~IdnEgxMoW1351913519epsmtrp1B;
        Thu,  2 Mar 2023 01:38:09 +0000 (GMT)
X-AuditID: b6c32a39-a97ff7000000d627-ca-63fffe018232
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        54.83.05839.10EFFF36; Thu,  2 Mar 2023 10:38:09 +0900 (KST)
Received: from bw365lee03 (unknown [10.88.97.170]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230302013809epsmtip20a9fdf22ca210c6faaea1cb0cfb21007~IdnENq6pk1094910949epsmtip2I;
        Thu,  2 Mar 2023 01:38:09 +0000 (GMT)
From:   "Bumwoo Lee" <bw365.lee@samsung.com>
To:     <myungjoo.ham@samsung.com>,
        "'Chanwoo Choi'" <cw00.choi@samsung.com>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <20230224100325epcms1p3e8886e278e23f610c8490cb69f1d452d@epcms1p3>
Subject: RE: [PATCH v2 2/4] extcon: Added extcon_alloc_cables to simplify
 extcon register function
Date:   Thu, 2 Mar 2023 10:38:08 +0900
Message-ID: <091101d94ca7$a4ad23c0$ee076b40$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQEndo8vt+Nxhu23TcqVP1cSXfBwDwF+DXQiAV3ksbMBRRvN4rApV6YQ
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMKsWRmVeSWpSXmKPExsWy7bCmvi7jv//JBj9eGFpc//Kc1eLyrjls
        FrcbV7A5MHv0bVnF6PF5k1wAU1S2TUZqYkpqkUJqXnJ+SmZeuq2Sd3C8c7ypmYGhrqGlhbmS
        Ql5ibqqtkotPgK5bZg7QDiWFssScUqBQQGJxsZK+nU1RfmlJqkJGfnGJrVJqQUpOgVmBXnFi
        bnFpXrpeXmqJlaGBgZEpUGFCdsacjScZCx6pVzRMf8vUwHhJtYuRk0NCwERi+Yml7F2MXBxC
        AjsYJRZ/n8MIkhAS+MQosa/TCyLxjVHi8py1jDAdt3pWMkIk9jJKHPg7Fcp5ziix/MUCFpAq
        NgEtiYVz5rOB2CICWRJXfrwGszkF/CT23T7ODGILC6RITN18gx3EZhFQkZjwroO1i5GDg1fA
        UqKnURIkzCsgKHFy5hOwkcwC2hLLFr5mhjhCQeLn02WsEOPdJBqnLICqEZGY3dnGDHKPhMAl
        dolbqyZBXe0iMf38RjYIW1ji1fEt7BC2lMTL/jYoO11i5ZU7UHaOxOv77VC9xhLv3q5lBrmN
        WUBTYv0ufYiwosTO33MZIfbySbz72gN2voQAr0RHmxBEibJE94MXTBC2pMTip3egJnpITDp3
        gnUCo+IsJF/OQvLlLCTfzEJYvICRZRWjWGpBcW56arFhgSk8rpPzczcxglOfluUOxulvP+gd
        YmTiYDzEKMHBrCTCu/D2n2Qh3pTEyqrUovz4otKc1OJDjKbAYJ/ILCWanA9Mvnkl8YYmlgYm
        ZkYmFsaWxmZK4rzitieThQTSE0tSs1NTC1KLYPqYODilGphWdD86eyru9+ql/237jojeTpxx
        wuzkj5nlRy6H/POYM9dzxddQ09NtnJJ1peVsza8tnDZmpexcYbNHaPq383omq1Q//En//O9D
        8IK3LxrYeg+wr5f0ONP5QGaa00o+r2v3pdcWxq5azOE2wX3Fj2839igr/tU+xMt+ivfpdpO3
        xxeubZetVUgynuAuqReodOFy49RXs4vXs2W3Hen8ymK59cy1B+k7dH8f/W+ueCvEfovc/eIH
        DndL9deG7doyUdz2e8wR/4VbQmpfV2xYf2sf1zbRbV945US36szt2yWrrrNwmtDsuy932S3b
        L1A9UXZx4oyF1V3epo1HFF8qMUqHZi4/tdD5mNaGew/mz/y1W0aJpTgj0VCLuag4EQBPdaF7
        BgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrILMWRmVeSWpSXmKPExsWy7bCSvC7jv//JBncm8lpc//Kc1eLyrjls
        FrcbV7A5MHv0bVnF6PF5k1wAUxSXTUpqTmZZapG+XQJXxpYdXcwFf6UqtnxezdLAOFWki5GT
        Q0LAROJWz0pGEFtIYDejxNcTkhBxSYmzyx+xdzFyANnCEocPF3cxcgGVPGWUWPtvDRtIDZuA
        lsTCOfPBbBGBHIkD66ewQ8z5yCgxeW8ciM0p4Cex7/ZxZhBbWCBJYsm67WA1LAIqEhPedbCC
        zOcVsJToaQRbyysgKHFy5hMWEJtZQFui92ErI4y9bOFrZojTFCR+Pl3GCrHWTaJxygKoehGJ
        2Z1tzBMYhWYhGTULyahZSEbNQtKygJFlFaNkakFxbnpusWGBYV5quV5xYm5xaV66XnJ+7iZG
        cKhrae5g3L7qg94hRiYOxkOMEhzMSiK8C2//SRbiTUmsrEotyo8vKs1JLT7EKM3BoiTOe6Hr
        ZLyQQHpiSWp2ampBahFMlomDU6qBqXa7zqkvUvUyrTuE9HcFnn8Vvi51YbrFR0nm7sqLlf/v
        qa71ufoox18nhH+S2c4jbLsFfXdzZSnuawu4mbrOq31jg9JX8R0HD0+MOde0RKFq3VwTjxmV
        disuZqca7DW+5739WWaf6wT2bqMLf8QaJ285evPE1fNcorzPWm8b3b0qEhA8s05npcHVO/cW
        ymQ1sp5izRCP+TX71wnLOOt493ONTjeu/ephdrZ74sl4/MiVecU2mvVLxKPUp7+P6DvgdHE/
        zzqFpUGx2/fM/b+L0SjgitEJhoLNTtJCsexLbfwXZ3AIq0o4vX/5yavvnn/e6cn7m2U36i0P
        Wp++qjZywQ1fG89F2w/1uam2P943U4mlOCPRUIu5qDgRAAhkRmTkAgAA
X-CMS-MailID: 20230302013809epcas1p1d0c8fac83192cae6fa5efaed17840509
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230220054545epcas1p34e5575ffdfd1dcef55bdee3c3563c925
References: <20230220054513.27385-3-bw365.lee@samsung.com>
        <20230220054513.27385-1-bw365.lee@samsung.com>
        <CGME20230220054545epcas1p34e5575ffdfd1dcef55bdee3c3563c925@epcms1p3>
        <20230224100325epcms1p3e8886e278e23f610c8490cb69f1d452d@epcms1p3>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

As you can see, edev->cables are freed if extcon_alloc_cables() function re=
turn error handling in extcon_dev_register()
Other added functions are also same.

Because it's functionalized, apart from this, do you want to mention that i=
t should be freed within the function?=20
Please let me know your opinion.

extcon_dev_register(struct extcon_dev *edev)=7B
...

	ret =3D extcon_alloc_cables(edev);
	if (ret)
		goto err_alloc_cables;

...

err_alloc_cables:
 	if (edev->max_supported)
 		kfree(edev->cables);


Regards,
Bumwoo

-----Original Message-----
From: MyungJoo Ham <myungjoo.ham=40samsung.com>=20
Sent: Friday, February 24, 2023 7:03 PM
To: Bumwoo Lee <bw365.lee=40samsung.com>; Chanwoo Choi <cw00.choi=40samsung=
.com>; linux-kernel=40vger.kernel.org
Subject: RE: =5BPATCH v2 2/4=5D extcon: Added extcon_alloc_cables to simpli=
fy extcon register function

>--------- Original Message ---------
>Sender : =EC=9D=B4=EB=B2=94=EC=9A=B0=20<bw365.lee=40samsung.com>Product=20=
S/W=20Lab(VD)/=EC=82=BC=EC=84=B1=EC=A0=84=EC=9E=90=20Date=20:=20=0D=0A>2023=
-02-20=2014:45=20(GMT+9)=20Title=20:=20=5BPATCH=20v2=202/4=5D=20extcon:=20A=
dded=20=0D=0A>extcon_alloc_cables=20to=20simplify=20extcon=20register=20fun=
ction=0D=0A>=20=0D=0A>The=20cable=20allocation=20part=20is=20functionalized=
=20from=20extcon_dev_register.=0D=0A>=0D=0A>Signed-off-by:=20Bumwoo=20Lee=
=20<bw365.lee=40samsung.com>=0D=0A>---=0D=0A>=20drivers/extcon/extcon.c=20=
=7C=20104=20+++++++++++++++++++++++-----------------=0D=0A>=201=20file=20ch=
anged,=2059=20insertions(+),=2045=20deletions(-)=0D=0A>=0D=0A>diff=20--git=
=20a/drivers/extcon/extcon.c=20b/drivers/extcon/extcon.c=20index=20=0D=0A>a=
dcf01132f70..3c2f540785e8=20100644=0D=0A>---=20a/drivers/extcon/extcon.c=0D=
=0A>+++=20b/drivers/extcon/extcon.c=0D=0A>=40=40=20-1070,6=20+1070,61=20=40=
=40=20void=20extcon_dev_free(struct=20extcon_dev=20*edev)=20=20=7D=20=20=0D=
=0A>EXPORT_SYMBOL_GPL(extcon_dev_free);=0D=0A>=20=0D=0A>+/**=0D=0A>+=20*=20=
extcon_alloc_cables()=20-=20alloc=20the=20cables=20for=20extcon=20device=0D=
=0A>+=20*=20=40edev:=20=20=20=20=20=20=20=20extcon=20device=20which=20has=
=20cables=0D=0A>+=20*=0D=0A>+=20*=20Returns=200=20if=20success=20or=20error=
=20number=20if=20fail.=0D=0A>+=20*/=0D=0A>+static=20int=20extcon_alloc_cabl=
es(struct=20extcon_dev=20*edev)=20=7B=0D=0A>+=20=20=20=20=20=20=20=20int=20=
index;=0D=0A>+=20=20=20=20=20=20=20=20char=20*str;=0D=0A>+=20=20=20=20=20=
=20=20=20struct=20extcon_cable=20*cable;=0D=0A>+=0D=0A>+=20=20=20=20=20=20=
=20=20if=20(=21edev->max_supported)=0D=0A>+=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20return=200;=0D=0A>+=0D=0A>+=20=20=20=20=20=20=20=20edev->=
cables=20=3D=20kcalloc(edev->max_supported,=0D=0A>+=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20sizeof=
(struct=20extcon_cable),=0D=0A>+=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20GFP_KERNEL);=0D=0A>+=20=
=20=20=20=20=20=20=20if=20(=21edev->cables)=0D=0A>+=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20return=20-ENOMEM;=0D=0A>+=0D=0A>+=20=20=20=20=20=20=
=20=20for=20(index=20=3D=200;=20index=20<=20edev->max_supported;=20index++)=
=20=7B=0D=0A>+=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20cable=20=3D=
=20&edev->cables=5Bindex=5D;=0D=0A>+=0D=0A>+=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20str=20=3D=20kasprintf(GFP_KERNEL,=20=22cable.%d=22,=20ind=
ex);=0D=0A>+=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20if=20(=21str)=
=20=7B=0D=0A>+=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20for=20(index--;=20index=20>=3D=200;=20index--)=20=7B=0D=0A>+=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20cable=20=3D=20&edev->cables=5Bindex=5D;=0D=0A>+=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20kfree(cable->attr_g.name);=0D=0A>+=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=7D=0D=0A>+=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20return=20-ENOMEM;=0D=
=0A=0D=0AYou=20have=20a=20memory=20leak.=0D=0Aedev->cables=20is=20allocated=
=20and=0D=0Ayou=20are=20not=20freeing=20it.=0D=0A=0D=0AIn=20the=20previous=
=20code,=20it=20was=20freed=20by=0D=0Ahaving=20different=20err-goto=20label=
s.=0D=0A=0D=0APlease=20check=20if=20you=20have=20similar=20errors=0D=0Ain=
=20other=20patches=20of=20this=20series.=0D=0A=0D=0A...=0D=0A=0D=0A>=40=40=
=20-1282,7=20+1296,7=20=40=40=20int=20extcon_dev_register(struct=20extcon_d=
ev=20*edev)=0D=0A>=20err_alloc_cables:=0D=0A>=20=20=20=20=20=20=20=20=20if=
=20(edev->max_supported)=0D=0A>=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20kfree(edev->cables);=0D=0A>-err_sysfs_alloc:=0D=0A>+=0D=0A>=20=20=
=20=20=20=20=20=20=20return=20ret;=0D=0A>=20=7D=0D=0A>=20EXPORT_SYMBOL_GPL(=
extcon_dev_register);=0D=0A>--=0D=0A>2.35.1=0D=0A>=0D=0A>=0D=0A=0D=0ACheers=
,=0D=0AMyungJoo.=0D=0A=0D=0A=0D=0A
