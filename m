Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2872D67F4CA
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 05:46:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbjA1Eqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 23:46:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbjA1Eqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 23:46:47 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6170A7FA00
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 20:46:46 -0800 (PST)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230128044644epoutp03848e4b8fe3c4c2cb2cc91b60bda789c5~_X5T_deMJ0547105471epoutp03I
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 04:46:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230128044644epoutp03848e4b8fe3c4c2cb2cc91b60bda789c5~_X5T_deMJ0547105471epoutp03I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1674881204;
        bh=BTc2ZKB9hN5vZuWZXdo3J43sS11Ulza5yyL1B5oNtvk=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=dQb127yN/6T2Acx8BrsDueJKAwM0EMr2iHxB+JTGGIm/QRk53bzpab2avoAeAAeIg
         li1SupTH/dtpU92G5ZeVcrY6bVqyDieyWXvvMrGPfsHoNwk+9JsofWAdCIFNKmgfvl
         PBgTzR6vRITr+3B0BF6P64PnNaof3KdkmVTE1s3w=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20230128044643epcas5p281ead3b782241095a3ae231593b0937e~_X5SmuVKj3093030930epcas5p2p;
        Sat, 28 Jan 2023 04:46:43 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.174]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4P3hjs6Sqlz4x9Pr; Sat, 28 Jan
        2023 04:46:41 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A6.7A.10528.1B8A4D36; Sat, 28 Jan 2023 13:46:41 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20230128044641epcas5p171f3bb0d5e4afc571515752cb42f8b2e~_X5QWOyM52400924009epcas5p1V;
        Sat, 28 Jan 2023 04:46:41 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230128044641epsmtrp11a04da2a76f5b8fe1d3ceed1c5890459~_X5QVa-Ae2898828988epsmtrp1s;
        Sat, 28 Jan 2023 04:46:41 +0000 (GMT)
X-AuditID: b6c32a49-c17ff70000012920-d0-63d4a8b12649
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        58.5C.17995.0B8A4D36; Sat, 28 Jan 2023 13:46:40 +0900 (KST)
Received: from alimakhtar04 (unknown [107.122.12.5]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230128044638epsmtip18c501670b5a4c59d2e15bed090ad5b73~_X5OFnv_u1374213742epsmtip1R;
        Sat, 28 Jan 2023 04:46:38 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        "'Rob Herring'" <robh+dt@kernel.org>,
        "'Krzysztof Kozlowski'" <krzysztof.kozlowski+dt@linaro.org>,
        "'Inki Dae'" <inki.dae@samsung.com>,
        "'Kyungmin Park'" <kyungmin.park@samsung.com>,
        "'Kukjin Kim'" <kgene@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Cc:     <replicant@osuosl.org>, <phone-devel@vger.kernel.org>,
        <~postmarketos/upstreaming@lists.sr.ht>,
        =?utf-8?Q?'Martin_J=C3=BCcker'?= <martin.juecker@gmail.com>,
        "'Henrik Grimler'" <henrik@grimler.se>
In-Reply-To: <20230120155404.323386-12-krzysztof.kozlowski@linaro.org>
Subject: RE: [PATCH 11/11] ARM: dts: exynos: correct HSI2C properties in
 Exynos5410 Odroid XU
Date:   Sat, 28 Jan 2023 10:16:37 +0530
Message-ID: <000701d932d3$834cb170$89e61450$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHNuRkKafHieBmUHCY1mc35yYPTTQKvTNNCAsqGfBCunmYTcA==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEJsWRmVeSWpSXmKPExsWy7bCmhu7GFVeSDa4sM7aYf+Qcq8XbJbsY
        LSbdn8Bi0f/4NbNF34uHzBZ7X29ltzjb9IbdYtPja6wWl3fNYbOYcX4fk8WZf1NZLBb8sbNY
        t0bQonXvEXaLzd//Mjrwe+ycdZfd4+iVe6wem1Z1snncubaHzWPzknqP/3fWsnt8ae5m9ejb
        sorR4/MmuQDOqGybjNTElNQihdS85PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTcVFslF58A
        XbfMHKD7lRTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkFJgV6xYm5xaV56Xp5qSVW
        hgYGRqZAhQnZGVu3fmIr2CFccez7dbYGxqNCXYycHBICJhJL11xj7GLk4hAS2M0osWpTMwtI
        QkjgE6PE/WXcEInPjBIfPj1j6mLkAOvY/TsPIr6LUeL7/GZ2COclo8SezY9YQbrZBHQldixu
        YwNJiAisZZY4sGUbmMMscJpR4srKbYwgVZwCbhJd8zaBdQgLxEt8OP0cbDeLgKrE9vcdbCA2
        r4ClxJmNy5ggbEGJkzOfgNUwC2hLLFv4mhniCQWJn0+Xgc0REXCS+LyqlRWiRlzi5dEjYOdJ
        CHzgkFjRsQjqBxeJD3+zIHqFJV4d38IOYUtJvOxvY4co8ZBY9EcKIpwh8Xb5ekYI217iwJU5
        LCAlzAKaEut36UNs4pPo/f0EajivREcbNHRVJZrfXWWBsKUlJnZ3s0LYHhKNsyaxTGBUnIXk
        r1lI/pqF5P5ZCMsWMLKsYpRMLSjOTU8tNi0wzEsth0d3cn7uJkZw4tby3MF498EHvUOMTByM
        hxglOJiVRHi3Ol5KFuJNSaysSi3Kjy8qzUktPsRoCgzsicxSosn5wNyRVxJvaGJpYGJmZmZi
        aWxmqCTOq257MllIID2xJDU7NbUgtQimj4mDU6qBaVZZalVL9DmGXzfT/q+eIGu4WvjH57Ne
        sekbG22EPDduf+689uPTnFzdH3cvemnqBrqyWP53sT+ScPpsxu9r19qrjXivy9lammprsax2
        f5f0LF6++F/LcdnJ3+PE/7xmDhGeeG/1NnWml6s3Tz/ju+db4r9vaq/FXCTfFrxbz/VW8k7g
        YgU/nwl+on+bHsxf6VX34s/SVyZzZ9y79Dh4fkKerlDx4RSLiVvTYmZf9nCd/K708c4G294v
        cl29zgGHZ7V+yOTTbwi228q17f2Pnd2nlEPVfSsl7IpbF+3yM7t69cT8mMv+hQeYNTQ3139T
        kJvzK1ZxfWJ2ccSrlQ4pt99+drF+tOlfXRz3yeP8h5RYijMSDbWYi4oTAS42OQdlBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLIsWRmVeSWpSXmKPExsWy7bCSnO6GFVeSDS6+t7aYf+Qcq8XbJbsY
        LSbdn8Bi0f/4NbNF34uHzBZ7X29ltzjb9IbdYtPja6wWl3fNYbOYcX4fk8WZf1NZLBb8sbNY
        t0bQonXvEXaLzd//Mjrwe+ycdZfd4+iVe6wem1Z1snncubaHzWPzknqP/3fWsnt8ae5m9ejb
        sorR4/MmuQDOKC6blNSczLLUIn27BK6MqSszCxbyV/z6eIGxgXESbxcjB4eEgInE7t95XYxc
        HEICOxgl7vZOZe5i5ASKS0tc3ziBHcIWllj57zk7RNFzRom1iyeDJdgEdCV2LG5jA0mICGxm
        ljg+6SAziMMscJ5R4saMA6wQLRcYJX5/3MYI0sIp4CbRNW8TK4gtLBArsWJ9ExOIzSKgKrH9
        fQcbiM0rYClxZuMyJghbUOLkzCcsIDazgLbE05tP4exlC19D3aog8fPpMrCZIgJOEp9XtbJC
        1IhLvDx6hH0Co/AsJKNmIRk1C8moWUhaFjCyrGKUTC0ozk3PLTYsMMpLLdcrTswtLs1L10vO
        z93ECI5hLa0djHtWfdA7xMjEwXiIUYKDWUmEd6vjpWQh3pTEyqrUovz4otKc1OJDjNIcLEri
        vBe6TsYLCaQnlqRmp6YWpBbBZJk4OKUamFR2Pnv/uCdUPffYtfaHr5c3Hf919sCaR+0/V5tE
        f9tq7a/3oV9R8MDLfeG5qSGPFsy4XTunesY2hX9Li98Enp3/SunB0yvvHVLKmHZpu+3ZP1lK
        eW3JzCVVFa/Zv58U2nF2/5KK7Ce862JO2L+04nv34qxwZDnfh7OTpFIX/zyXOiXxXpi40NUX
        TctSdy+L4RGYocRaX/Tird3HxvbJJlvKOWdJKJ6/UFM3Mzftz8t1eucKvweFpvuc1Ags3ay9
        YZH0pIviur4T89fPuJamoGRjN1v2rtmR8qf5OhoK3Wpiy3cnfw7nn7Ddtdj9g+bB4/skGh/H
        m3g9NvxvLK94Q1I94ZGYuXPi0ob1qdHcV9YpsRRnJBpqMRcVJwIAb08hoFADAAA=
X-CMS-MailID: 20230128044641epcas5p171f3bb0d5e4afc571515752cb42f8b2e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230120155431epcas5p37731d63d93c501522c4b08515f174ce4
References: <20230120155404.323386-1-krzysztof.kozlowski@linaro.org>
        <CGME20230120155431epcas5p37731d63d93c501522c4b08515f174ce4@epcas5p3.samsung.com>
        <20230120155404.323386-12-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Krzysztof Kozlowski <krzysztof.kozlowski=40linaro.org>
> Sent: Friday, January 20, 2023 9:24 PM
> To: Rob Herring <robh+dt=40kernel.org>; Krzysztof Kozlowski
> <krzysztof.kozlowski+dt=40linaro.org>; Alim Akhtar
> <alim.akhtar=40samsung.com>; Inki Dae <inki.dae=40samsung.com>; Kyungmin
> Park <kyungmin.park=40samsung.com>; Kukjin Kim <kgene=40kernel.org>;
> devicetree=40vger.kernel.org; linux-arm-kernel=40lists.infradead.org; lin=
ux-
> samsung-soc=40vger.kernel.org; linux-kernel=40vger.kernel.org
> Cc: replicant=40osuosl.org; phone-devel=40vger.kernel.org;
> =7Epostmarketos/upstreaming=40lists.sr.ht; Martin J=C3=BCcker=0D=0A>=20<m=
artin.juecker=40gmail.com>;=20Henrik=20Grimler=20<henrik=40grimler.se>;=0D=
=0A>=20Krzysztof=20Kozlowski=20<krzysztof.kozlowski=40linaro.org>=0D=0A>=20=
Subject:=20=5BPATCH=2011/11=5D=20ARM:=20dts:=20exynos:=20correct=20HSI2C=20=
properties=20in=0D=0A>=20Exynos5410=20Odroid=20XU=0D=0A>=20=0D=0A>=20The=20=
HSI2C=20controller=20uses=20clock-frequency=20and=20does=20not=20have=20i2c=
-sda-delay.=0D=0A>=20The=20properties=20were=20copy-pasted=20from=20the=20s=
lower=20S3C-family=20I2C=20controller:=0D=0A>=20=0D=0A>=20=20=20exynos5410-=
odroidxu.dtb:=20i2c=4012ca0000:=20Unevaluated=20properties=20are=20not=0D=
=0A>=20allowed=20('samsung,i2c-max-bus-freq',=20'samsung,i2c-sda-delay'=20w=
ere=0D=0A>=20unexpected)=0D=0A>=20=0D=0A>=20Signed-off-by:=20Krzysztof=20Ko=
zlowski=20<krzysztof.kozlowski=40linaro.org>=0D=0A>=20---=0D=0A=0D=0AReview=
ed-by:=20Alim=20Akhtar=20<alim.akhtar=40samsung.com>=0D=0A=0D=0A>=20=20arch=
/arm/boot/dts/exynos5410-odroidxu.dts=20=7C=203=20+--=0D=0A>=20=201=20file=
=20changed,=201=20insertion(+),=202=20deletions(-)=0D=0A>=20=0D=0A>=20diff=
=20--git=20a/arch/arm/boot/dts/exynos5410-odroidxu.dts=0D=0A>=20b/arch/arm/=
boot/dts/exynos5410-odroidxu.dts=0D=0A>=20index=20d1cbc6b8a570..232561620da=
2=20100644=0D=0A>=20---=20a/arch/arm/boot/dts/exynos5410-odroidxu.dts=0D=0A=
>=20+++=20b/arch/arm/boot/dts/exynos5410-odroidxu.dts=0D=0A>=20=40=40=20-16=
4,8=20+164,7=20=40=40=20map2=20=7B=0D=0A>=20=20=7D;=0D=0A>=20=0D=0A>=20=20&=
hsi2c_4=20=7B=0D=0A>=20-=09samsung,i2c-sda-delay=20=3D=20<100>;=0D=0A>=20-=
=09samsung,i2c-max-bus-freq=20=3D=20<400000>;=0D=0A>=20+=09clock-frequency=
=20=3D=20<400000>;=0D=0A>=20=20=09status=20=3D=20=22okay=22;=0D=0A>=20=0D=
=0A>=20=20=09usb3503:=20usb-hub=408=20=7B=0D=0A>=20--=0D=0A>=202.34.1=0D=0A=
=0D=0A=0D=0A
