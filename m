Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD0BA67F5DE
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 09:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233502AbjA1IGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 03:06:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbjA1IGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 03:06:14 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C9A086258
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 00:06:11 -0800 (PST)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230128080608epoutp0436d555139870d5995de239f998b3eb1d~_anZ_AAOC1010710107epoutp04X
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 08:06:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230128080608epoutp0436d555139870d5995de239f998b3eb1d~_anZ_AAOC1010710107epoutp04X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1674893168;
        bh=TWf9lzvirf35dO4oA2W1RhJPrVzqSUzkzFALa1aULJ8=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=hvbUzBGMj/zJP9KT0TDJfTIBrIjj9CsCXw0rJb8ZwOdeMwcqK+nsOf4PU+ym2JYfF
         dzFU61JCtoA0Yll/nlmn1Uy6im0TaHwtwCHOqRf4FZlzE7WHHeWk8OYkE7fl5U4nfL
         ULDw7zPqUvceFFqwkwuKzG+NLS7KOO4+X1aRU3vE=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20230128080607epcas5p3e3a264c3e18c3b18ebd53a49901415aa~_anZDpqe42786027860epcas5p3b;
        Sat, 28 Jan 2023 08:06:07 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.176]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4P3n7x6FSNz4x9Px; Sat, 28 Jan
        2023 08:06:05 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        83.F1.06765.D67D4D36; Sat, 28 Jan 2023 17:06:05 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20230128080605epcas5p39994bb472119a1bfa23ddeb8f6396039~_anW3L29k2786127861epcas5p3Y;
        Sat, 28 Jan 2023 08:06:05 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230128080605epsmtrp275930f74f82d18032add9cc6e69ee75d~_anWx30n_2023420234epsmtrp2J;
        Sat, 28 Jan 2023 08:06:05 +0000 (GMT)
X-AuditID: b6c32a4b-46dfa70000011a6d-d7-63d4d76dbcba
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        CE.70.17995.C67D4D36; Sat, 28 Jan 2023 17:06:05 +0900 (KST)
Received: from alimakhtar04 (unknown [107.122.12.5]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230128080602epsmtip15c7bed1e1a4e15e2f7110e02758824c1~_anUkigXs0554005540epsmtip18;
        Sat, 28 Jan 2023 08:06:02 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        "'Rob Herring'" <robh+dt@kernel.org>,
        "'Krzysztof Kozlowski'" <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Cc:     <replicant@osuosl.org>, <phone-devel@vger.kernel.org>,
        <~postmarketos/upstreaming@lists.sr.ht>,
        =?utf-8?Q?'Martin_J=C3=BCcker'?= <martin.juecker@gmail.com>,
        "'Henrik Grimler'" <henrik@grimler.se>,
        "'Sam Protsenko'" <semen.protsenko@linaro.org>,
        "'Chanho Park'" <chanho61.park@samsung.com>,
        "'Marek Szyprowski'" <m.szyprowski@samsung.com>,
        "'Chanwoo Choi'" <cw00.choi@samsung.com>
In-Reply-To: <20230127212713.267014-4-krzysztof.kozlowski@linaro.org>
Subject: RE: [RFT PATCH v3 4/4] arm64: dts: exynos: add unit address to DWC3
 node wrapper in Exynos7
Date:   Sat, 28 Jan 2023 13:36:01 +0530
Message-ID: <001201d932ef$5e74dd70$1b5e9850$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFzvEVwWLN0sEUdJm8gcJkigxsA0gKyTjLNAakoc06vW4NzgA==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGJsWRmVeSWpSXmKPExsWy7bCmum7u9SvJBvMmaVtc3q9tcf3Lc1aL
        +UfOsVq8XbKL0aLvxUNmi72vt7JbbHp8jdXi8q45bBYzzu9jslh75C67xZl/U1ksFvyxs1i3
        RtCide8RdovnfUC5zd//MjoIeOycdZfd4+iVe6wem1Z1snncubaHzWPzknqP/3fWsnt8ae5m
        9ejbsorR4/MmuQDOqGybjNTElNQihdS85PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTcVFsl
        F58AXbfMHKAflBTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkFJgV6xYm5xaV56Xp5
        qSVWhgYGRqZAhQnZGfs3P2Is+CBXsfrEEtYGxoeyXYycHBICJhI/1k1n7GLk4hAS2M0oMeXt
        ZVYI5xOjRMuVq8wQzmdGifOzpzDBtOzetJEdIrGLUWLGlINQzkug/v5zYFVsAroSOxa3sYEk
        RAQ2MUl82b8XrIpZoJNZYsHyp6wgVZwCrhL/nq8E6xAWSJPonfIbaCEHB4uAqkTDlnIQk1fA
        UuLnRGOQCl4BQYmTM5+wgNjMAtoSyxa+Zoa4SEHi59NlYBNFBJwk+u4vhqoRl3h59Ag7RM0H
        DomTTbkQtovEhI5VbBC2sMSr41ugaqQkPr/bywayVkLAQ2LRHymIcIbE2+XrGSFse4kDV+aw
        gJQwC2hKrN+lD7GJT6L39xMmiE5eiY42IYhqVYnmd1dZIGxpiYnd3awQtofEvIlbWCcwKs5C
        8tcsJH/NQnL/LIRlCxhZVjFKphYU56anFpsWGOellsOjOzk/dxMjOIFree9gfPTgg94hRiYO
        xkOMEhzMSiK8Wx0vJQvxpiRWVqUW5ccXleakFh9iNAUG9URmKdHkfGAOySuJNzSxNDAxMzMz
        sTQ2M1QS51W3PZksJJCeWJKanZpakFoE08fEwSnVwFQyubT+nYntHPvNTDbMBUtyj6ZdTv62
        OVPb+oud7dTQ9L95h8xmy71dKlnQuHfJ8cUz6874TF4m/THXc8GkB+sXHt9X974ysnBD1O+k
        gOfqNbmrX3eHmpj+vyBSNlvC4NyOuuCkn/HNpnvM3UNim3RZImzcN7CJmkZvXXZmMbPAHouS
        K/brF5ckH8yY62nt8/CehStXRbyU4Awdp23C2t/KY5LP2VTFXI7knrROZOmPGIH6Asmb1/w3
        27xYKfmobWHJ1U2NhmqRcZXFK00ubk+Vvbt3//N/+wv3s7hN2hC2JvH/KaW9myXdVD6JuNw7
        cl76RzGz3uaZ695JXm2Pjl960+dYZEvyhadCP7lsO5VYijMSDbWYi4oTATz1WAdpBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAIsWRmVeSWpSXmKPExsWy7bCSnG7u9SvJBi/3MVlc3q9tcf3Lc1aL
        +UfOsVq8XbKL0aLvxUNmi72vt7JbbHp8jdXi8q45bBYzzgPVrj1yl93izL+pLBYL/thZrFsj
        aNG69wi7xfM+oNzm738ZHQQ8ds66y+5x9Mo9Vo9NqzrZPO5c28PmsXlJvcf/O2vZPb40d7N6
        9G1ZxejxeZNcAGcUl01Kak5mWWqRvl0CV8byLV1sBX9FK168ncPUwNgu1MXIySEhYCKxe9NG
        9i5GLg4hgR2MEvPePWKFSEhLXN84gR3CFpZY+e85mC0k8JxR4t3WdBCbTUBXYsfiNjaQZhGB
        bUwSq5r/gDnMAv3MEm/PbmaDGHueUeLe/QtMIC2cAq4S/56vBLOFBVIkJs+YzNzFyMHBIqAq
        0bClHMTkFbCU+DnRGKSCV0BQ4uTMJywgNrOAtsTTm0/h7GULXzNDHKcg8fPpMrCjRQScJPru
        L4aqEZd4efQI+wRG4VlIRs1CMmoWklGzkLQsYGRZxSiZWlCcm55bbFhglJdarlecmFtcmpeu
        l5yfu4kRHMlaWjsY96z6oHeIkYmD8RCjBAezkgjvVsdLyUK8KYmVValF+fFFpTmpxYcYpTlY
        lMR5L3SdjBcSSE8sSc1OTS1ILYLJMnFwSjUwMWTvexG3es6kd7un96x0sTgsZBuhP4fn3cHP
        q01n8j/ex27b6xJ56bjd96LHVtc/M+iFOv3cb+omEqTU8D/8cO49b8WXt2VW6gdaZp63PLqn
        NOmM7FuX3m8qy3xPmfH2JW3b/KrnFZ+3SdipM7pmD2acvZleN+/sZlWzkyuvlt2+7tGuz/G1
        oXKPu/m9tuqAPWuXxd1f7cP2uWDhhQX1+2xv+UdsDv90Q6dUdbG4vtk/+90n6r9wzN2ax7dO
        JEA+N8Q/THinQPDT0pCmU4KNU2wU7gcst7jAZPfVYPchrz17+0sK/4cVn5j1lD/emmFXPqfm
        K02NFJGtMmXM52Z8ndOQYmL19Wjgj1KZ4yX/lViKMxINtZiLihMBaT4+LlMDAAA=
X-CMS-MailID: 20230128080605epcas5p39994bb472119a1bfa23ddeb8f6396039
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230127212733epcas5p24868be035c0f2c3190b8cfe4a6310ccd
References: <20230127212713.267014-1-krzysztof.kozlowski@linaro.org>
        <CGME20230127212733epcas5p24868be035c0f2c3190b8cfe4a6310ccd@epcas5p2.samsung.com>
        <20230127212713.267014-4-krzysztof.kozlowski@linaro.org>
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
> Sent: Saturday, January 28, 2023 2:57 AM
> To: Rob Herring <robh+dt=40kernel.org>; Krzysztof Kozlowski
> <krzysztof.kozlowski+dt=40linaro.org>; Alim Akhtar
> <alim.akhtar=40samsung.com>; devicetree=40vger.kernel.org; linux-arm-
> kernel=40lists.infradead.org; linux-samsung-soc=40vger.kernel.org; linux-
> kernel=40vger.kernel.org
> Cc: replicant=40osuosl.org; phone-devel=40vger.kernel.org;
> =7Epostmarketos/upstreaming=40lists.sr.ht; Martin J=C3=BCcker=0D=0A>=20<m=
artin.juecker=40gmail.com>;=20Henrik=20Grimler=20<henrik=40grimler.se>;=20S=
am=0D=0A>=20Protsenko=20<semen.protsenko=40linaro.org>;=20Chanho=20Park=0D=
=0A>=20<chanho61.park=40samsung.com>;=20Marek=20Szyprowski=0D=0A>=20<m.szyp=
rowski=40samsung.com>;=20Chanwoo=20Choi=0D=0A>=20<cw00.choi=40samsung.com>;=
=20Krzysztof=20Kozlowski=0D=0A>=20<krzysztof.kozlowski=40linaro.org>=0D=0A>=
=20Subject:=20=5BRFT=20PATCH=20v3=204/4=5D=20arm64:=20dts:=20exynos:=20add=
=20unit=20address=20to=20DWC3=0D=0A>=20node=20wrapper=20in=20Exynos7=0D=0A>=
=20=0D=0A>=20Neither=20simple-bus=20bindings=20nor=20dtc=20W=3D1=20accept=
=20device=20nodes=20in=20soc=40=20node=0D=0A>=20which=20do=20not=20have=20u=
nit=20address.=20=20Therefore=20usethe=20address=20space=20of=20child=0D=0A=
>=20device=20(actual=20DWC3=20Controller)=20as=20the=20wrapper's=20address=
=20to=0D=0A>=20fix:=0D=0A>=20=0D=0A>=20=20=20exynos7-espresso.dtb:=20soc=40=
0:=20usb:=20=7B'compatible':=20=5B'samsung,exynos7-=0D=0A>=20dwusb3'=5D,=20=
...=0D=0A>=20=20=20=20=20should=20not=20be=20valid=20under=20=7B'type':=20'=
object'=7D=0D=0A>=20=0D=0A>=20Signed-off-by:=20Krzysztof=20Kozlowski=20<krz=
ysztof.kozlowski=40linaro.org>=0D=0A>=20=0D=0A>=20---=0D=0AReviewed-by:=20A=
lim=20Akhtar=20<alim.akhtar=40samsung.com>=0D=0A=0D=0ATested=20on=20exynos7=
-espresso=20and=20xHCI=20driver=20still=20gets=20probed,=20so=20=0D=0A=0D=
=0ATested-by:=20Alim=20Akhtar=20<alim.akhtar=40samsung.com>=0D=0A=0D=0A=0D=
=0A>=20=0D=0A>=20Changes=20since=20v1:=0D=0A>=201.=20New=20patch=0D=0A>=20-=
--=0D=0A>=20=20arch/arm64/boot/dts/exynos/exynos7.dtsi=20=7C=208=20++++----=
=0D=0A>=20=201=20file=20changed,=204=20insertions(+),=204=20deletions(-)=0D=
=0A>=20=0D=0A>=20diff=20--git=20a/arch/arm64/boot/dts/exynos/exynos7.dtsi=
=0D=0A>=20b/arch/arm64/boot/dts/exynos/exynos7.dtsi=0D=0A>=20index=2082fee1=
b7caab..b1fa68835b09=20100644=0D=0A>=20---=20a/arch/arm64/boot/dts/exynos/e=
xynos7.dtsi=0D=0A>=20+++=20b/arch/arm64/boot/dts/exynos/exynos7.dtsi=0D=0A>=
=20=40=40=20-690,7=20+690,7=20=40=40=20usbdrd_phy:=20phy=4015500000=20=7B=
=0D=0A>=20=20=09=09=09=23phy-cells=20=3D=20<1>;=0D=0A>=20=20=09=09=7D;=0D=
=0A>=20=0D=0A>=20-=09=09usbdrd:=20usb=20=7B=0D=0A>=20+=09=09usbdrd:=20usb=
=4015400000=20=7B=0D=0A>=20=20=09=09=09compatible=20=3D=20=22samsung,exynos=
7-dwusb3=22;=0D=0A>=20=20=09=09=09clocks=20=3D=20<&clock_fsys0=20ACLK_USBDR=
D300>,=0D=0A>=20=20=09=09=09=20=20=20=20=20=20=20<&clock_fsys0=20SCLK_USBDR=
D300_SUSPENDCLK>,=0D=0A>=20=40=40=20-699,11=20+699,11=20=40=40=20usbdrd:=20=
usb=20=7B=0D=0A>=20=20=09=09=09=09=22usbdrd30_axius_clk=22;=0D=0A>=20=20=09=
=09=09=23address-cells=20=3D=20<1>;=0D=0A>=20=20=09=09=09=23size-cells=20=
=3D=20<1>;=0D=0A>=20-=09=09=09ranges;=0D=0A>=20+=09=09=09ranges=20=3D=20<0x=
0=200x15400000=200x10000>;=0D=0A>=20=0D=0A>=20-=09=09=09usb=4015400000=20=
=7B=0D=0A>=20+=09=09=09usb=400=20=7B=0D=0A>=20=20=09=09=09=09compatible=20=
=3D=20=22snps,dwc3=22;=0D=0A>=20-=09=09=09=09reg=20=3D=20<0x15400000=200x10=
000>;=0D=0A>=20+=09=09=09=09reg=20=3D=20<0x0=200x10000>;=0D=0A>=20=20=09=09=
=09=09interrupts=20=3D=20<GIC_SPI=20223=0D=0A>=20IRQ_TYPE_LEVEL_HIGH>;=0D=
=0A>=20=20=09=09=09=09phys=20=3D=20<&usbdrd_phy=200>,=20<&usbdrd_phy=201>;=
=0D=0A>=20=20=09=09=09=09phy-names=20=3D=20=22usb2-phy=22,=20=22usb3-phy=22=
;=0D=0A>=20--=0D=0A>=202.34.1=0D=0A=0D=0A=0D=0A
