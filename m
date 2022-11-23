Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4D8C635F9B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 14:29:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236199AbiKWN3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 08:29:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237411AbiKWN3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 08:29:20 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A85759FE8
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 05:08:20 -0800 (PST)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20221123130817epoutp02e49ff9ca488449cde980e069f9b3fa84~qOKX7YZ5s2257322573epoutp02u
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 13:08:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20221123130817epoutp02e49ff9ca488449cde980e069f9b3fa84~qOKX7YZ5s2257322573epoutp02u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1669208897;
        bh=SdiCq1URJCgHFlw7QN8TKmZiE7TBXuD6RlRMm2NVzCY=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=DYfDBxm069rRVNTx73azef5AJeU/cYIH8DGTq89QkhcFN2Xk6IJyzcszA6pyiZ0Se
         D8By1uXqNewYPOtYXzf0zZ/RtxAKfaehbF2y0udpZaP6ygKIis6/60/KVC3/ItdLxw
         k/iRJzCsRr6+1riY5uEQal2CUf8tXAyM476Bnow0=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20221123130816epcas5p261f5ce86b5401ff5400c8f1bf70dd31f~qOKW9Djxz1283812838epcas5p2V;
        Wed, 23 Nov 2022 13:08:16 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.179]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4NHLz25XbCz4x9Pt; Wed, 23 Nov
        2022 13:08:14 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        56.8D.01710.E3B1E736; Wed, 23 Nov 2022 22:08:14 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20221123115738epcas5p20dfd32bcdfa4b1ba1fbc2d725c8b4f18~qNMslAH3n0827808278epcas5p2-;
        Wed, 23 Nov 2022 11:57:38 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221123115738epsmtrp234d9475075d2fb42c7a8061ef86f3782~qNMskUVsb1452814528epsmtrp2x;
        Wed, 23 Nov 2022 11:57:38 +0000 (GMT)
X-AuditID: b6c32a49-a41ff700000006ae-47-637e1b3e3ad5
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        ED.BD.14392.2BA0E736; Wed, 23 Nov 2022 20:57:38 +0900 (KST)
Received: from FDSFTE302 (unknown [107.122.81.78]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20221123115737epsmtip20523ae6360a10cfce48573c8e88cde87~qNMrP-aKX0213202132epsmtip2P;
        Wed, 23 Nov 2022 11:57:37 +0000 (GMT)
From:   "Sriranjani P" <sriranjani.p@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <lee@kernel.org>, <devicetree@vger.kernel.org>,
        <alim.akhtar@samsung.com>, <pankaj.dubey@samsung.com>,
        <ravi.patel@samsung.com>
Cc:     <linux-kernel@vger.kernel.org>
In-Reply-To: <a98ac5d7-0c0e-110e-5405-83a09c77ceac@linaro.org>
Subject: RE: [PATCH 2/2] arm64: dts: fsd: add sysreg device node
Date:   Wed, 23 Nov 2022 17:27:35 +0530
Message-ID: <000001d8ff32$c8b78e30$5a26aa90$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGtZdCQDJwhTh87CLfF3yzsQrDlqwDaao/AAgr8Mq4BlHJjc65/yl5A
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAJsWRmVeSWpSXmKPExsWy7bCmuq6ddF2ywZ05WhYP5m1js5h/5Byr
        Rd+Lh8wWe19vZbfY0baQxeLyrjlsFou2fmG3ePhhD7tF694j7A6cHptWdbJ53Lm2h82jb8sq
        Ro/Pm+QCWKKybTJSE1NSixRS85LzUzLz0m2VvIPjneNNzQwMdQ0tLcyVFPISc1NtlVx8AnTd
        MnOAblFSKEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX2CqlFqTkFJgU6BUn5haX5qXr5aWWWBka
        GBiZAhUmZGf03XzLVtAoWXH86jTWBsZfYl2MnBwSAiYSO9b2MoLYQgK7GSX+rsjoYuQCsj8x
        Smx4/5kFwvnGKLHox34WmI6m7u3sEIm9jBKPlt1jgnCeM0osPLAIrIpNQF/i9Yr5bCAJEYF/
        jBLHFp0Ecjg4mAWUJK6ekgOp4RSwk9i+fQ0TiC0s4CCxaekVVhCbRUBV4lPbDDCbV8BS4nPn
        dGYIW1Di5MwnYPOZBbQlli18zQxxkYLEz6fLwOpFBNwkDjdsYIWoEZc4+rOHGeQGCYGZHBK3
        5r5jgmhwkWiZuJkdwhaWeHV8C5QtJfH53V42CDtdYvORzawQdo5ER1Mz1DJ7iQNX5rBA/KIp
        sX6XPkRYVmLqqXVMEHv5JHp/P4FaxSuxYx6MrSax+FEnlC0jsfbRJ9YJjEqzkLw2C8lrs5C8
        MAth2wJGllWMkqkFxbnpqcWmBYZ5qeXwCE/Oz93ECE6qWp47GO8++KB3iJGJg/EQowQHs5II
        b71nTbIQb0piZVVqUX58UWlOavEhRlNgeE9klhJNzgem9bySeEMTSwMTMzMzE0tjM0Mlcd7F
        M7SShQTSE0tSs1NTC1KLYPqYODilGphWP8xlSnE5zyoSHF/BGSHhnNhY/EVX9IwI16MaHqFr
        T+a7fT9wVWzStD4B6VvforZqJE8t0ej4l2W55GyRhrzHhN/LHgjK8+73DBM/FmlvXzujW/zv
        o2s3lExiuH/VnjHvcbjK4+rEsGOSm3Cq8bEddbUnJx5+Zyle2r772GX/XRP9rsRxs265kNz5
        qSuqttCdY8fDXsFFbyP+vz69YK3Z4ZMvnYr/LeuPMJu1/946fxF/oSOeilM2rHaS2L+qKX8a
        Z8Wd8GtnOc8kmXB4XZgR+cjqWbVgwRKBmp3rbLTiZt+IudlQUr3qm0vZm9sJJU+99l06cfCK
        gGKqhM5Czq2OvZrxj2f4W/5JP5m/5bESS3FGoqEWc1FxIgCWOfh7MwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkkeLIzCtJLcpLzFFi42LZdlhJXncTV12ywdfp5hYP5m1js5h/5Byr
        Rd+Lh8wWe19vZbfY0baQxeLyrjlsFou2fmG3ePhhD7tF694j7A6cHptWdbJ53Lm2h82jb8sq
        Ro/Pm+QCWKK4bFJSczLLUov07RK4Mv5/X8NasEOk4uru7WwNjHcEuhg5OSQETCSaurezdzFy
        cQgJ7GaU+PNkDRNEQkbi5IMlzBC2sMTKf8+hip4ySvQ/72YFSbAJ6Eu8XjGfDSQhItDGJLF2
        3lagbg4OZgEliaun5CAaPjNKfNvxEmwqp4CdxPbtEBuEBRwkNi29AjaIRUBV4lPbDDCbV8BS
        4nPndGYIW1Di5MwnLCA2s4C2xNObT+HsZQtfQ12nIPHz6TKwXhEBN4nDDRtYIWrEJY7+7GGe
        wCg8C8moWUhGzUIyahaSlgWMLKsYJVMLinPTc4sNCwzzUsv1ihNzi0vz0vWS83M3MYJjS0tz
        B+P2VR/0DjEycTAeYpTgYFYS4a33rEkW4k1JrKxKLcqPLyrNSS0+xCjNwaIkznuh62S8kEB6
        YklqdmpqQWoRTJaJg1OqgWmuiDv/l3NVkw/pTBUzk/7Q01RlYb991Y3wjKPs6xVcvy7cdPWW
        iRXP675J++N92wz+RzrqtBuu81+98qU657ts/pDSqdx1S3IWHfMR6zH/5n9wl/rpPVsnzJBd
        lxga5P1NOlM/6XZJ6tJw74ALE05e0gusWHDrjZFvxtQlAh9/bn5RePPBdRnzArld3wsqd9X2
        lD3UkXrhzyXu9DBX48rRYr7jq6XMpPRenX5Sx7pfXCnUTXMR09dnj7j3BoXdXJcoenCZ2Y3v
        KctOpEz6MH3mj8iZElttNct3bmP+GyzLff2R8rnvcsm8fguezC5tYjGfWui1Z/aUm7NS5zVc
        2Hxb+WLN8XdCemmnL96XPHFSiaU4I9FQi7moOBEAfpXaXRwDAAA=
X-CMS-MailID: 20221123115738epcas5p20dfd32bcdfa4b1ba1fbc2d725c8b4f18
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221121090647epcas5p439dc84f0c4f435a703a1f8396a11202f
References: <20221121091118.48628-1-sriranjani.p@samsung.com>
        <CGME20221121090647epcas5p439dc84f0c4f435a703a1f8396a11202f@epcas5p4.samsung.com>
        <20221121091118.48628-3-sriranjani.p@samsung.com>
        <a98ac5d7-0c0e-110e-5405-83a09c77ceac@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Krzysztof Kozlowski =5Bmailto:krzysztof.kozlowski=40linaro.org=5D
> Sent: 21 November 2022 17:58
> To: Sriranjani P <sriranjani.p=40samsung.com>; robh+dt=40kernel.org;
> krzysztof.kozlowski+dt=40linaro.org; lee=40kernel.org;
> devicetree=40vger.kernel.org; alim.akhtar=40samsung.com;
> pankaj.dubey=40samsung.com; ravi.patel=40samsung.com
> Cc: linux-kernel=40vger.kernel.org
> Subject: Re: =5BPATCH 2/2=5D arm64: dts: fsd: add sysreg device node
>=20
> On 21/11/2022 10:11, Sriranjani P wrote:
> > Add SYSREG controller device node, which is available in PERIC, FSYS0
> > and
> > FSYS1 block of FSD SoC.
> >
> > Signed-off-by: Alim Akhtar <alim.akhtar=40samsung.com>
> > Signed-off-by: Pankaj Dubey <pankaj.dubey=40samsung.com>
> > Signed-off-by: Sriranjani P <sriranjani.p=40samsung.com>
> > ---
> >  arch/arm64/boot/dts/tesla/fsd.dtsi =7C 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/tesla/fsd.dtsi
> > b/arch/arm64/boot/dts/tesla/fsd.dtsi
> > index f35bc5a288c2..db78816ba0bf 100644
> > --- a/arch/arm64/boot/dts/tesla/fsd.dtsi
> > +++ b/arch/arm64/boot/dts/tesla/fsd.dtsi
> > =40=40 -518,6 +518,21 =40=40
> >  				=22dout_cmu_fsys1_shared0div4=22;
> >  		=7D;
> >
> > +		sysreg_peric: syscon=4014030000 =7B
>=20
> Node name system-controller
=5BSriranjani P=5D Will fix it in the next version. We added =E2=80=9Csysco=
n=E2=80=9D=20since=20I=20referred=20other=20dtsi=20files=20in=20mainline=20=
for=20example=20exynosautov9.dtsi=20used=20syscon=20as=20node=20name.=20If=
=20this=20is=20the=20name=20we=20should=20add=20then=20I=E2=80=99ll=20post=
=20few=20more=20patches=20fixing=20this=20node=20name=20in=20other=20Exynos=
=20dtsi=20files.=0D=0A>=20and=20either=20put=20it=20next=20to=20existing=20=
one=20or=20next=20to=20functional=20block=20(peric=0D=0A>=20clocks?)=20orde=
red=20by=20unit=20address.=0D=0A=5BSriranjani=20P=5D=20We=20thought=20of=20=
it=20but=20as=20I=20saw=20current=20fsd.dtsi=20file=20and=20other=20exynos=
=20file=20like=20exynosautov9.dtsi,=20in=20that=20nodes=20are=20not=20prope=
rly=20arranged=20as=20per=20unit=20address.=0D=0A=0D=0ASo=20I=20can=20think=
=20of=20following=20two=20approaches:=20=0D=0A1:=20For=20the=20time=20being=
=20I=20will=20put=20this=20sysreg=20node=20in=20between=20clock_peric=20nod=
e=20and=20clock_fysys0=20node=20and=20clock_fsys1=20node=20as=20per=20incre=
asing=20unit=20address.=20I=20will=20clean=20up=20other=20exynos=20and=20FS=
D=20DTSI=20files=20and=20post=20a=20new=20patch=20=0D=0A2:=20First=20I=20wi=
ll=20clean=20up=20exynos=20and=20FSD=20DTSI=20files=20and=20then=20post=20t=
his=20sysreg=20patch=20keeping=20it=20at=20appropriate=20place.=20=0D=0A=0D=
=0APlease=20let=20me=20know=20which=20way=20it=20will=20be=20more=20appropr=
iate.=0D=0A>=20=0D=0A>=20>=20+=09=09=09compatible=20=3D=20=22tesla,fsd-sysr=
eg=22,=20=22syscon=22;=0D=0A>=20>=20+=09=09=09reg=20=3D=20<0x0=200x14030000=
=200x0=200x1000>;=0D=0A>=20>=20+=09=09=7D;=0D=0A>=20=0D=0A>=20Best=20regard=
s,=0D=0A>=20Krzysztof=0D=0A=5BSriranjani=20P=5D=20Thank=20you=20for=20revie=
wing=20the=20patch.=0D=0A=0D=0A=0D=0A
