Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E69E46A197E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 11:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbjBXKFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 05:05:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbjBXKEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 05:04:32 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F7C4A1E1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 02:03:35 -0800 (PST)
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230224100327epoutp0161483e0cc141692c82b203486e543bc8~GuojJUwu30614206142epoutp01d
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 10:03:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230224100327epoutp0161483e0cc141692c82b203486e543bc8~GuojJUwu30614206142epoutp01d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1677233007;
        bh=OGGS/OiaVcKLs/4uGbnlJJJWFoc1IOX5eSSpqquuZR0=;
        h=Subject:Reply-To:From:To:In-Reply-To:Date:References:From;
        b=iILtMVYkytnOTnrTqj4WRfpQOjI6sc5NwvJDR8AyWwDXI8OwPULdo7tCuczVb09Mr
         MQ3dJRnYV0EnVwsbaxxeJ72D1IgW1S34TaqqSpx4GKiEW/zfWdWoBK0ACk5GFT5TL8
         kB+MZbKg2ZDwULZQShx3qVkPtv0yCuXEXiH44GXU=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20230224100327epcas1p4f4669ccb5268fcb4d91b8835355fd4d6~Guoi7ZLVp3237732377epcas1p4w;
        Fri, 24 Feb 2023 10:03:27 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.38.234]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4PNQSt2H7qz4x9Pt; Fri, 24 Feb
        2023 10:03:26 +0000 (GMT)
X-AuditID: b6c32a36-e59fa70000023112-ac-63f88b6e9df1
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        90.E5.12562.E6B88F36; Fri, 24 Feb 2023 19:03:26 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH v2 2/4] extcon: Added extcon_alloc_cables to simplify
 extcon register function
Reply-To: myungjoo.ham@samsung.com
Sender: MyungJoo Ham <myungjoo.ham@samsung.com>
From:   MyungJoo Ham <myungjoo.ham@samsung.com>
To:     Bumwoo Lee <bw365.lee@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20230220054513.27385-3-bw365.lee@samsung.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230224100325epcms1p3e8886e278e23f610c8490cb69f1d452d@epcms1p3>
Date:   Fri, 24 Feb 2023 19:03:25 +0900
X-CMS-MailID: 20230224100325epcms1p3e8886e278e23f610c8490cb69f1d452d
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDKsWRmVeSWpSXmKPExsWy7bCmgW5e949kg0+TOC1OrFnEZHH9y3NW
        i8u75rA5MHv0bVnF6PF5k1wAU1S2TUZqYkpqkUJqXnJ+SmZeuq2Sd3C8c7ypmYGhrqGlhbmS
        Ql5ibqqtkotPgK5bZg7QDiWFssScUqBQQGJxsZK+nU1RfmlJqkJGfnGJrVJqQUpOgWmBXnFi
        bnFpXrpeXmqJlaGBgZEpUGFCdsbOL6uYC2apVuzpq2lgnKnSxcjJISFgIvF803HmLkYuDiGB
        HYwSV9cfZu1i5ODgFRCU+LtDGKRGWCBFYurmG+wgtpCAkkTDzX3MEHF9iY4H2xhBbDYBXYmt
        G+6ygMwREehnBHL+MkMs4JWY0f6UBcKWlti+fCtYA6eAtcShZ8+YIOKiEjdXv2WHsd8fm88I
        YYtItN47CzVHUOLBz91QcSmJJzsns4EskxCYzChx8sRxRghnDqPEtA3v2CCq9CXOzD0JZvMK
        +Eq8PXSaGeQzFgFViWWTskFMCQEXid7j9iAVzALaEssWvgarYBbQlFi/Sx8izCfx7msPK8wr
        O+Y9gTpZTeLQ7iVQJ8tInJ6+EOpMD4lJ506wQsJzM6PEzyWzmSYwys1CBOksJNtmIWxbwMi8
        ilEstaA4Nz212LDACB6Jyfm5mxjByUrLbAfjpLcf9A4xMnEwHmKU4GBWEuGdyvQ9WYg3JbGy
        KrUoP76oNCe1+BCjKdCXE5mlRJPzgekyryTe0MTSwMTMyNjEwtDMUEmcV9z2ZLKQQHpiSWp2
        ampBahFMHxMHp1QDU82c6W/au9+JfQ37/fut7Fm3GVtceD6/ON7nyK4p8nbdPsnV5mquQs+T
        hIxVDv7JbtPc21W258LFW29aQ+Z8W3LnGn/MFSXGkqmhvwK0fk1rMH69bpZ2svlC4QqWqrLl
        R+PeO7xPvbRLueg/u41mVvlcj4RrexIuZpZ3u7YeU3x4/7GBTIPc5pWqMYUH1C/H+L2cwbLi
        QF7zh4ysnpsfbB1z0hj//pzgJXSiVemJor/ju0Olp590NxxYG3bj6FrLbMtUAT0zTg2DrRVi
        1ZJrSvNtV5ieVFwp6j1fXNByUXdjw/PAg6U9u9MCbwg/O+H+s+72Ci3zqdN+3Z1/ySaudNel
        uuY7KTP0z1h8s1y1X4mlOCPRUIu5qDgRAAd4MOffAwAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230220054545epcas1p34e5575ffdfd1dcef55bdee3c3563c925
References: <20230220054513.27385-3-bw365.lee@samsung.com>
        <20230220054513.27385-1-bw365.lee@samsung.com>
        <CGME20230220054545epcas1p34e5575ffdfd1dcef55bdee3c3563c925@epcms1p3>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>--------- Original Message ---------
>Sender : =EC=9D=B4=EB=B2=94=EC=9A=B0=C2=A0<bw365.lee=40samsung.com>Product=
=20S/W=20Lab(VD)/=EC=82=BC=EC=84=B1=EC=A0=84=EC=9E=90=0D=0A>Date=20:=202023=
-02-20=2014:45=20(GMT+9)=0D=0A>Title=20:=20=5BPATCH=20v2=202/4=5D=20extcon:=
=20Added=20extcon_alloc_cables=20to=20simplify=20extcon=20register=20functi=
on=0D=0A>=C2=A0=0D=0A>The=20cable=20allocation=20part=20is=20functionalized=
=20from=20extcon_dev_register.=0D=0A>=0D=0A>Signed-off-by:=20Bumwoo=20Lee=
=20<bw365.lee=40samsung.com>=0D=0A>---=0D=0A>=20drivers/extcon/extcon.c=20=
=7C=20104=20+++++++++++++++++++++++-----------------=0D=0A>=201=20file=20ch=
anged,=2059=20insertions(+),=2045=20deletions(-)=0D=0A>=0D=0A>diff=20--git=
=20a/drivers/extcon/extcon.c=20b/drivers/extcon/extcon.c=0D=0A>index=20adcf=
01132f70..3c2f540785e8=20100644=0D=0A>---=20a/drivers/extcon/extcon.c=0D=0A=
>+++=20b/drivers/extcon/extcon.c=0D=0A>=40=40=20-1070,6=20+1070,61=20=40=40=
=20void=20extcon_dev_free(struct=20extcon_dev=20*edev)=0D=0A>=20=7D=0D=0A>=
=20EXPORT_SYMBOL_GPL(extcon_dev_free);=0D=0A>=C2=A0=0D=0A>+/**=0D=0A>+=20*=
=20extcon_alloc_cables()=20-=20alloc=20the=20cables=20for=20extcon=20device=
=0D=0A>+=20*=20=40edev:=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0extcon=20device=
=20which=20has=20cables=0D=0A>+=20*=0D=0A>+=20*=20Returns=200=20if=20succes=
s=20or=20error=20number=20if=20fail.=0D=0A>+=20*/=0D=0A>+static=20int=20ext=
con_alloc_cables(struct=20extcon_dev=20*edev)=0D=0A>+=7B=0D=0A>+=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0int=20index;=0D=0A>+=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0char=20*str;=0D=0A>+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0struct=20e=
xtcon_cable=20*cable;=0D=0A>+=0D=0A>+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0if=
=20(=21edev->max_supported)=0D=0A>+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0return=200;=0D=0A>+=0D=0A>+=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0edev->cables=20=3D=20kcalloc(edev->max_supported,=0D=
=0A>+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20sizeof=
(struct=20extcon_cable),=0D=0A>+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20GFP_KERNEL);=0D=0A>+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0if=20(=21edev->cables)=0D=0A>+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0return=20-ENOMEM;=0D=0A>+=0D=0A>+=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0for=20(index=20=3D=200;=20index=20<=20edev->max_sup=
ported;=20index++)=20=7B=0D=0A>+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0cable=20=3D=20&edev->cables=5Bindex=5D;=0D=0A=
>+=0D=0A>+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0str=20=3D=20kasprintf(GFP_KERNEL,=20=22cable.%d=22,=20index);=0D=
=0A>+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0if=20(=21str)=20=7B=0D=0A>+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0for=20(index=
--;=20index=20>=3D=200;=20index--)=20=7B=0D=0A>+=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0cable=20=3D=20&edev->cables=5Bind=
ex=5D;=0D=0A>+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0kfree(cable->attr_g.name);=0D=0A>+=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=7D=0D=0A>+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0return=20-ENOMEM;=0D=0A=0D=
=0AYou=20have=20a=20memory=20leak.=0D=0Aedev->cables=20is=20allocated=20and=
=0D=0Ayou=20are=20not=20freeing=20it.=0D=0A=0D=0AIn=20the=20previous=20code=
,=20it=20was=20freed=20by=0D=0Ahaving=20different=20err-goto=20labels.=0D=
=0A=0D=0APlease=20check=20if=20you=20have=20similar=20errors=0D=0Ain=20othe=
r=20patches=20of=20this=20series.=0D=0A=0D=0A...=0D=0A=0D=0A>=40=40=20-1282=
,7=20+1296,7=20=40=40=20int=20extcon_dev_register(struct=20extcon_dev=20*ed=
ev)=0D=0A>=20err_alloc_cables:=0D=0A>=20=C2=A0=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0if=20(edev->max_supported)=0D=0A>=20=C2=A0=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0kfree(edev->cables);=0D=0A>-err_s=
ysfs_alloc:=0D=0A>+=0D=0A>=20=C2=A0=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0return=
=20ret;=0D=0A>=20=7D=0D=0A>=20EXPORT_SYMBOL_GPL(extcon_dev_register);=0D=0A=
>--=20=0D=0A>2.35.1=0D=0A>=0D=0A>=0D=0A=0D=0ACheers,=0D=0AMyungJoo.=0D=0A
