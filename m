Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16B3267F4BD
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 05:41:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbjA1Ele (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 23:41:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjA1Elb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 23:41:31 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173371A489
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 20:41:29 -0800 (PST)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230128044127epoutp0394b756b61cf93c96e51f1c95b9046b13~_X0sa07Vr0547105471epoutp03S
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 04:41:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230128044127epoutp0394b756b61cf93c96e51f1c95b9046b13~_X0sa07Vr0547105471epoutp03S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1674880887;
        bh=YfplP/QfBt6troAfrGhbUyHm/TzJdzy215O9uqnLf7A=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=iwpl5BQk5/tyN14QviBL0hbFRO5mmB6tcMXX2jpJEG/4zYINlkWWi2NYLVVVOFZTE
         N8y72nTqqBhnycMOhRcjjKwvopuXYLZKdz0aGnlHyPfiabhQbnZR7f58K/2svJAXoF
         AV+4z/sfVHPERiMfuT/IXyn7JtbmuAQ/46jp8/cs=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20230128044127epcas5p1d722bbb3f82082361e1a586ce8087f89~_X0r65wMU0811808118epcas5p18;
        Sat, 28 Jan 2023 04:41:27 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.182]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4P3hbn3Djdz4x9Pv; Sat, 28 Jan
        2023 04:41:25 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        EF.3B.55678.577A4D36; Sat, 28 Jan 2023 13:41:25 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20230128044124epcas5p4660e32fcd93a8757a35ceb879364227e~_X0pxixEI3219332193epcas5p4f;
        Sat, 28 Jan 2023 04:41:24 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230128044124epsmtrp22c71720e9183a9ae090ee23e87b318f6~_X0pwt2rM2743727437epsmtrp2E;
        Sat, 28 Jan 2023 04:41:24 +0000 (GMT)
X-AuditID: b6c32a4a-909fc7000000d97e-85-63d4a775112f
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        0B.3C.17995.477A4D36; Sat, 28 Jan 2023 13:41:24 +0900 (KST)
Received: from alimakhtar04 (unknown [107.122.12.5]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230128044122epsmtip20a4d2d692fd238733734d88a665aca10~_X0np_fQY3243432434epsmtip27;
        Sat, 28 Jan 2023 04:41:22 +0000 (GMT)
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
In-Reply-To: <20230120155404.323386-9-krzysztof.kozlowski@linaro.org>
Subject: RE: [PATCH 08/11] ARM: dts: exynos: align HSOTG/USB node names
Date:   Sat, 28 Jan 2023 10:11:20 +0530
Message-ID: <000401d932d2$c6bd3570$5437a050$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHNuRkKafHieBmUHCY1mc35yYPTTQIXmSO2Ak/jORGupvddwA==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIJsWRmVeSWpSXmKPExsWy7bCmlm7p8ivJBgsPiFvMP3KO1eLtkl2M
        FpPuT2Cx6H/8mtmi78VDZou9r7eyW5xtesNusenxNVaLy7vmsFnMOL+PyeLMv6ksFgv+2Fms
        WyNo0br3CLvF5u9/GR34PXbOusvucfTKPVaPTas62TzuXNvD5rF5Sb3H/ztr2T2+NHezevRt
        WcXo8XmTXABnVLZNRmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZgaGuoaWFuZJCXmJuqq2Si0+A
        rltmDtD9SgpliTmlQKGAxOJiJX07m6L80pJUhYz84hJbpdSClJwCkwK94sTc4tK8dL281BIr
        QwMDI1OgwoTsjM3XNjEV3JKo6Nr1h72B8bp4FyMnh4SAicTnjqcsXYxcHEICuxklNuycxQaS
        EBL4xChx5AgPROIzo8T6i6uYYTqe7j7JBJHYxSix48khRoiOl4wST9cbgNhsAroSOxa3sYEU
        iQisZZY4sGUbmMMscJpR4srKbWAdnAKuEv07r4HZwgLuEn2734DZLAKqEpf6jrKD2LwClhIv
        t39kgbAFJU7OfAJmMwtoSyxb+BrqJAWJn0+XsXYxcgBtc5I4dy4OokRc4uXRI+wgeyUEXnBI
        nN72lB2i3kViRv98KFtY4tXxLVC2lMTnd3vZQOZICHhILPojBRHOkHi7fD0jhG0vceDKHBaQ
        EmYBTYn1u/QhVvFJ9P5+wgTRySvR0SYEUa0q0fzuKguELS0xsbubFWb4hjdpExgVZyF5axaS
        t2YhuX8Wwq4FjCyrGCVTC4pz01OLTQuM8lLL4bGdnJ+7iRGctrW8djA+fPBB7xAjEwfjIUYJ
        DmYlEd6tjpeShXhTEiurUovy44tKc1KLDzGaAsN6IrOUaHI+MHPklcQbmlgamJiZmZlYGpsZ
        KonzqtueTBYSSE8sSc1OTS1ILYLpY+LglGpgsg/VvMmey95q8PuOzgrVxvn2gTcmVE+aPlNw
        34F1O6Y+uDnvb0/RXtl7305rzW162Pawf+X8EhcDL+mFMWY7ZGLcG1TlZhXfkpnZufnCk9kX
        Mop3L/xYnvNE43zViTP9BTuNWLUCfNu/ivkVHHp1JXxeT/+MfVKO9evvK7654+f9wT5DyuPk
        pGLupKrLR1fP2Z9531Pn2NKfTitSQvy9r/0ViL2/8++VC5ub5COyCz6aveDxTMgVvCxoWJh4
        7IJkqWFv2todi5jaTLblu+6Zu9N49i1Nzej5GXdjKpstc0Ifml2pKi3uFbif08we1mOS3Pl4
        QmK4884z79YacSqbisU/2HRddrnmt82qb0NMlViKMxINtZiLihMBs8op9GQEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLIsWRmVeSWpSXmKPExsWy7bCSvG7J8ivJBv0r1CzmHznHavF2yS5G
        i0n3J7BY9D9+zWzR9+Ihs8Xe11vZLc42vWG32PT4GqvF5V1z2CxmnN/HZHHm31QWiwV/7CzW
        rRG0aN17hN1i8/e/jA78Hjtn3WX3OHrlHqvHplWdbB53ru1h89i8pN7j/5217B5fmrtZPfq2
        rGL0+LxJLoAzissmJTUnsyy1SN8ugSvj+rX7rAWbhCqWrt/E3MB4ir+LkZNDQsBE4unuk0wg
        tpDADkaJdZsrIeLSEtc3TmCHsIUlVv57DmRzAdU8Z5S49mIPC0iCTUBXYsfiNjaQhIjAZmaJ
        45MOMoM4zALnGSVuzDjACtEC5Jzcv5IRpIVTwFWif+c1MFtYwF2ib/cbMJtFQFXiUt9RsH28
        ApYSL7d/ZIGwBSVOznwCZjMLaEs8vfkUzl628DUzxH0KEj+fLgNaxgF0hpPEuXNxECXiEi+P
        HmGfwCg8C8mkWUgmzUIyaRaSlgWMLKsYJVMLinPTc4sNC4zyUsv1ihNzi0vz0vWS83M3MYJj
        WEtrB+OeVR/0DjEycTAeYpTgYFYS4d3qeClZiDclsbIqtSg/vqg0J7X4EKM0B4uSOO+FrpPx
        QgLpiSWp2ampBalFMFkmDk6pBqZJij27L0ma7V2gyKgmn/12Bd8Bh+7tlpdrnc8suLPly4Ef
        u70FvyUKpBrLsiysl3Rg8k3KqLOfU7bzzfnzz8RXf3g8e8eaVNNbV4IOb9i68pn9yXXVv4p/
        7Wd7lmU0L/V7HdOBfUkrGdrF7URcDit6vjmbu6uvMTXqwzmd2Qt+KR8XKkn0u79t1rfz1rP7
        ipeVOR7esiDdTEFS/SjDzRe1Wf2e7/af15Cr/drNws3R6Z0Uy9XLqR2R5rv8p8McPS8jxmrD
        WO7+1fcuhK27LfTKbNeOQK02zusPjkhf/TVj9/fwkyxe87T2JF0TO9fNlXtlxVmrhduef1K9
        lz5/ccyBW0JVP+8vvc5TMVM0gHmSEktxRqKhFnNRcSIAGdN3DlADAAA=
X-CMS-MailID: 20230128044124epcas5p4660e32fcd93a8757a35ceb879364227e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230120155427epcas5p443f8ebc8eaef2be4416b550659a3131a
References: <20230120155404.323386-1-krzysztof.kozlowski@linaro.org>
        <CGME20230120155427epcas5p443f8ebc8eaef2be4416b550659a3131a@epcas5p4.samsung.com>
        <20230120155404.323386-9-krzysztof.kozlowski@linaro.org>
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
Subject:=20=5BPATCH=2008/11=5D=20ARM:=20dts:=20exynos:=20align=20HSOTG/USB=
=20node=20names=0D=0A>=20=0D=0A>=20The=20DT=20schema=20expect=20HSOTG=20nod=
e=20names=20to=20be=20named=20=22usb=22:=0D=0A>=20=0D=0A>=20=20=20exynos421=
0-smdkv310.dtb:=20hsotg=4012480000:=20=24nodename:0:=0D=0A>=20'hsotg=401248=
0000'=20does=20not=20match=20'=5Eusb(=40.*)?'=0D=0A>=20=0D=0A>=20Signed-off=
-by:=20Krzysztof=20Kozlowski=20<krzysztof.kozlowski=40linaro.org>=0D=0A>=20=
---=0D=0AReviewed-by:=20Alim=20Akhtar=20<alim.akhtar=40samsung.com>=0D=0A=
=0D=0A>=20=20arch/arm/boot/dts/exynos3250.dtsi=20=7C=202=20+-=0D=0A>=20=20a=
rch/arm/boot/dts/exynos4.dtsi=20=20=20=20=7C=202=20+-=0D=0A>=20=202=20files=
=20changed,=202=20insertions(+),=202=20deletions(-)=0D=0A>=20=0D=0A>=20diff=
=20--git=20a/arch/arm/boot/dts/exynos3250.dtsi=0D=0A>=20b/arch/arm/boot/dts=
/exynos3250.dtsi=0D=0A>=20index=209b25449d5311..36b47c2c1663=20100644=0D=0A=
>=20---=20a/arch/arm/boot/dts/exynos3250.dtsi=0D=0A>=20+++=20b/arch/arm/boo=
t/dts/exynos3250.dtsi=0D=0A>=20=40=40=20-365,7=20+365,7=20=40=40=20sysmmu_f=
imd0:=20sysmmu=4011e20000=20=7B=0D=0A>=20=20=09=09=09=23iommu-cells=20=3D=
=20<0>;=0D=0A>=20=20=09=09=7D;=0D=0A>=20=0D=0A>=20-=09=09hsotg:=20hsotg=401=
2480000=20=7B=0D=0A>=20+=09=09hsotg:=20usb=4012480000=20=7B=0D=0A>=20=20=09=
=09=09compatible=20=3D=20=22samsung,s3c6400-hsotg=22;=0D=0A>=20=20=09=09=09=
reg=20=3D=20<0x12480000=200x20000>;=0D=0A>=20=20=09=09=09interrupts=20=3D=
=20<GIC_SPI=20141=20IRQ_TYPE_LEVEL_HIGH>;=0D=0A>=20diff=20--git=20a/arch/ar=
m/boot/dts/exynos4.dtsi=0D=0A>=20b/arch/arm/boot/dts/exynos4.dtsi=20index=
=205c4ecda27a47..55afe9972460=0D=0A>=20100644=0D=0A>=20---=20a/arch/arm/boo=
t/dts/exynos4.dtsi=0D=0A>=20+++=20b/arch/arm/boot/dts/exynos4.dtsi=0D=0A>=
=20=40=40=20-362,7=20+362,7=20=40=40=20exynos_usbphy:=20exynos-usbphy=40125=
b0000=20=7B=0D=0A>=20=20=09=09=09status=20=3D=20=22disabled=22;=0D=0A>=20=
=20=09=09=7D;=0D=0A>=20=0D=0A>=20-=09=09hsotg:=20hsotg=4012480000=20=7B=0D=
=0A>=20+=09=09hsotg:=20usb=4012480000=20=7B=0D=0A>=20=20=09=09=09compatible=
=20=3D=20=22samsung,s3c6400-hsotg=22;=0D=0A>=20=20=09=09=09reg=20=3D=20<0x1=
2480000=200x20000>;=0D=0A>=20=20=09=09=09interrupts=20=3D=20<GIC_SPI=2071=
=20IRQ_TYPE_LEVEL_HIGH>;=0D=0A>=20--=0D=0A>=202.34.1=0D=0A=0D=0A=0D=0A
