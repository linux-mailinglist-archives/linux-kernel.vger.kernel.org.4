Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE0E67F4C3
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 05:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbjA1Emo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 23:42:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjA1Eml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 23:42:41 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91D51ADCC
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 20:42:39 -0800 (PST)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230128044238epoutp0442e35239043b9db543cb029080c273e4~_X1uQ3Rc22098120981epoutp04u
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 04:42:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230128044238epoutp0442e35239043b9db543cb029080c273e4~_X1uQ3Rc22098120981epoutp04u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1674880958;
        bh=A24HweFkUSJzyN4Yo+qXkWBWdpmC+tvDdXOuOBQIZU4=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=DFtIYjnEo8efwH2xBm4FTK1WiHF7G3QnwSJAtQJzazGTvZQphEWKPm9e+1mfPLnzE
         79BfqBWbmiZIHvVl4ynKMOQ07hN4JJ8TElXGmNLL16k+sxjbVNzphsgwi8CTMQngdT
         aEfrKseLE7iSo2oa9errv3U6PzaIYxXMZDSsDEx0=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20230128044237epcas5p26799a33f27b53c0bc4cec822a215dd70~_X1tFN9iM0594205942epcas5p2b;
        Sat, 28 Jan 2023 04:42:37 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.183]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4P3hd72zYbz4x9Ps; Sat, 28 Jan
        2023 04:42:35 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B5.0A.10528.BB7A4D36; Sat, 28 Jan 2023 13:42:35 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20230128044234epcas5p1634f0515a882a185df14073c736bb6ae~_X1rFMq4q3040630406epcas5p16;
        Sat, 28 Jan 2023 04:42:34 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230128044234epsmtrp1c636ffeacef5c62a65e8bf2ff43fdf22~_X1rETBD_2650226502epsmtrp1d;
        Sat, 28 Jan 2023 04:42:34 +0000 (GMT)
X-AuditID: b6c32a49-c17ff70000012920-1c-63d4a7bb8ec0
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        DE.3C.17995.AB7A4D36; Sat, 28 Jan 2023 13:42:34 +0900 (KST)
Received: from alimakhtar04 (unknown [107.122.12.5]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230128044232epsmtip1b47310e3e88349f7d320858aa4f11c42~_X1orcCIf2407424074epsmtip1G;
        Sat, 28 Jan 2023 04:42:32 +0000 (GMT)
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
In-Reply-To: <20230120155404.323386-10-krzysztof.kozlowski@linaro.org>
Subject: RE: [PATCH 09/11] ARM: dts: exynos: correct SATA clocks in
 Exynos5250
Date:   Sat, 28 Jan 2023 10:12:29 +0530
Message-ID: <000501d932d2$f077e310$d167a930$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHNuRkKafHieBmUHCY1mc35yYPTTQGAawZmAmWaUYGuqwNdwA==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCJsWRmVeSWpSXmKPExsWy7bCmhu7u5VeSDdbMFbaYf+Qcq8XbJbsY
        LSbdn8Bi0f/4NbNF34uHzBZ7X29ltzjb9IbdYtPja6wWl3fNYbOYcX4fk8WZf1NZLBb8sbNY
        t0bQonXvEXaLzd//Mjrwe+ycdZfd4+iVe6wem1Z1snncubaHzWPzknqP/3fWsnt8ae5m9ejb
        sorR4/MmuQDOqGybjNTElNQihdS85PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTcVFslF58A
        XbfMHKD7lRTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkFJgV6xYm5xaV56Xp5qSVW
        hgYGRqZAhQnZGdO69jMXrBGteNv2g72BcbNIFyMnh4SAicTfB49YQWwhgd2MEl8ma3cxcgHZ
        nxglWg8uZYNwPjNK7Ln3mBWm48P2VywQiV2MEgv2N7JCOC8ZJaYs6WABqWIT0JXYsbgNrF1E
        YC2zxIEt28AcZoHTjBJXVm5jBKniFHCTuNi9iA3EFhYIkJh0rg/MZhFQlZhyZzbYJF4BS4ll
        t5+zQtiCEidnPgGLMwtoSyxb+JoZ4iYFiZ9Pl4HViAg4SbzcMpMNokZc4uXRI+wgiyUE3nBI
        3O/7DdXgIvFv2XF2CFtY4tXxLVC2lMTL/jYgmwPI9pBY9EcKIpwh8Xb5ekYI217iwJU5LCAl
        zAKaEut36UOs4pPo/f2ECaKTV6KjTQiiWlWi+d1VFghbWmJidzc0FD0kTj2/zziBUXEWksdm
        IXlsFpIHZiEsW8DIsopRMrWgODc9tdi0wDAvtRwe4cn5uZsYwclby3MH490HH/QOMTJxMB5i
        lOBgVhLh3ep4KVmINyWxsiq1KD++qDQntfgQoykwtCcyS4km5wPzR15JvKGJpYGJmZmZiaWx
        maGSOK+67clkIYH0xJLU7NTUgtQimD4mDk6pBqbpoX+T307fG+qyq5i7PKlUyNmQT7owaONz
        5dSEySkTVq9+27pK7M8yh3S9M5Pmz78849X0d/0cQYcvb1jzu+36QrNnHmJpreev/J4a++zW
        S8u0TdWcYhy/z1zwkp5x/0yR8b99Co2sV6oZpy8T0brzbAHnjadxH7Zavg67bTGFc/Gqzb4K
        R2rDFCw++s76ksFlp5vUu1JoY+c5S4N9SiIc6lrCUn533yeba+12jlXIdOrVW3jj8zrP2iK2
        4rvhZ0xrWuJmLBMtlM9WXr57S9025ws3VlkwPu+r2SC++K86u9GJtf8FRN8byAcJFxxUnVmc
        zFMq5nuihFlb6q2F3b+FNSIJ98VOVudPftC0Vk+JpTgj0VCLuag4EQDh8cwEZwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHIsWRmVeSWpSXmKPExsWy7bCSnO6u5VeSDXo2GlrMP3KO1eLtkl2M
        FpPuT2Cx6H/8mtmi78VDZou9r7eyW5xtesNusenxNVaLy7vmsFnMOL+PyeLMv6ksFgv+2Fms
        WyNo0br3CLvF5u9/GR34PXbOusvucfTKPVaPTas62TzuXNvD5rF5Sb3H/ztr2T2+NHezevRt
        WcXo8XmTXABnFJdNSmpOZllqkb5dAlfGhw2NLAUNAhU3+1YwNzDu5O1i5OSQEDCR+LD9FUsX
        IxeHkMAORoll7zYxQySkJa5vnMAOYQtLrPz3nB2i6DmjxLVL7WBFbAK6EjsWt7GBJEQENjNL
        HJ90kBnEYRY4zyhxY8YBVoiWC4wSJzc+YAVp4RRwk7jYvQiohYNDWMBP4tQVBZAwi4CqxJQ7
        s1lAbF4BS4llt5+zQtiCEidnPgGLMwtoSzy9+RTOXrbwNdSpChI/ny4DqxcRcJJ4uWUmG0SN
        uMTLo0fYJzAKz0IyahaSUbOQjJqFpGUBI8sqRsnUguLc9NxiwwKjvNRyveLE3OLSvHS95Pzc
        TYzgKNbS2sG4Z9UHvUOMTByMhxglOJiVRHi3Ol5KFuJNSaysSi3Kjy8qzUktPsQozcGiJM57
        oetkvJBAemJJanZqakFqEUyWiYNTqoGJm+fv85pFNVcqXCsyDj79sFpk4hfJKxEHf+5R9YuV
        Xifitmlix9r6F5++yX7Pr+F1aVqtlhIQVTCt5PmFCZ1XlThSrqgZGlh9+MK0t3ZZ/P5kh1zT
        y/Pyjj1Lrv8z07slNUeCrX1WcG7ZV+Nl2iYrzsiGZK2aIXJ7380S+c0bLjR5v1R4JNLbEOI/
        W1DEbK3W7o7J+tOfq86ZpS43d/OjR3v3s4cv/tMt7LxcU+iqNK/D8UOLu9enVbtPmPa811P1
        mEX43i/cS958a/2/+NGq5Y0F/F/lfbPip2v+v7p377Rrx/q3H3llFDt5nc65psK9nNZSgRYm
        xUdU/1VMkf2uk/0k4b/UVpPf+RUrZ0qeVGIpzkg01GIuKk4EABlLq5RRAwAA
X-CMS-MailID: 20230128044234epcas5p1634f0515a882a185df14073c736bb6ae
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230120155429epcas5p11dadc6286c7de5f115ed9fc00cbefc9a
References: <20230120155404.323386-1-krzysztof.kozlowski@linaro.org>
        <CGME20230120155429epcas5p11dadc6286c7de5f115ed9fc00cbefc9a@epcas5p1.samsung.com>
        <20230120155404.323386-10-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
Subject:=20=5BPATCH=2009/11=5D=20ARM:=20dts:=20exynos:=20correct=20SATA=20c=
locks=20in=20Exynos5250=0D=0A>=20=0D=0A>=20The=20DT=20schema=20expects=20cl=
ock=20name=20matching=20certain=20patterns:=0D=0A>=20=0D=0A>=20=20=20exynos=
5250-smdk5250.dtb:=20sata=40122f0000:=20clock-names:1:=20'oneOf'=0D=0A>=20c=
onditional=20failed,=20one=20must=20be=20fixed:=0D=0A>=20=20=20=20=20'sclk_=
sata'=20is=20not=20one=20of=20=5B'pclk',=20'aclk',=20'hclk',=20'sata'=5D=0D=
=0A>=20=20=20=20=20'pmalive'=20was=20expected=0D=0A>=20=20=20=20=20'rxoob'=
=20was=20expected=0D=0A>=20=20=20=20=20'ref'=20was=20expected=0D=0A>=20=0D=
=0A>=20Signed-off-by:=20Krzysztof=20Kozlowski=20<krzysztof.kozlowski=40lina=
ro.org>=0D=0A>=20---=0D=0A=0D=0AReviewed-by:=20Alim=20Akhtar=20<alim.akhtar=
=40samsung.com>=0D=0A=0D=0A=0D=0A>=20=20arch/arm/boot/dts/exynos5250.dtsi=
=20=7C=202=20+-=0D=0A>=20=201=20file=20changed,=201=20insertion(+),=201=20d=
eletion(-)=0D=0A>=20=0D=0A>=20diff=20--git=20a/arch/arm/boot/dts/exynos5250=
.dtsi=0D=0A>=20b/arch/arm/boot/dts/exynos5250.dtsi=0D=0A>=20index=20f82f82f=
c803f..9225f3552837=20100644=0D=0A>=20---=20a/arch/arm/boot/dts/exynos5250.=
dtsi=0D=0A>=20+++=20b/arch/arm/boot/dts/exynos5250.dtsi=0D=0A>=20=40=40=20-=
390,7=20+390,7=20=40=40=20sata:=20sata=40122f0000=20=7B=0D=0A>=20=20=09=09=
=09reg=20=3D=20<0x122F0000=200x1ff>;=0D=0A>=20=20=09=09=09interrupts=20=3D=
=20<GIC_SPI=20115=20IRQ_TYPE_LEVEL_HIGH>;=0D=0A>=20=20=09=09=09clocks=20=3D=
=20<&clock=20CLK_SATA>,=20<&clock=0D=0A>=20CLK_SCLK_SATA>;=0D=0A>=20-=09=09=
=09clock-names=20=3D=20=22sata=22,=20=22sclk_sata=22;=0D=0A>=20+=09=09=09cl=
ock-names=20=3D=20=22sata=22,=20=22pclk=22;=0D=0A>=20=20=09=09=09phys=20=3D=
=20<&sata_phy>;=0D=0A>=20=20=09=09=09phy-names=20=3D=20=22sata-phy=22;=0D=
=0A>=20=20=09=09=09ports-implemented=20=3D=20<0x1>;=0D=0A>=20--=0D=0A>=202.=
34.1=0D=0A=0D=0A=0D=0A
