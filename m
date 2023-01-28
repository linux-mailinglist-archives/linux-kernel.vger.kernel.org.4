Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF29467F4A2
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 05:26:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbjA1E0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 23:26:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjA1E0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 23:26:17 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EEE147435
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 20:26:14 -0800 (PST)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230128042609epoutp040bb4624d94054582bdaa7bc371ca568c~_XnVkh87G0364703647epoutp04h
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 04:26:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230128042609epoutp040bb4624d94054582bdaa7bc371ca568c~_XnVkh87G0364703647epoutp04h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1674879969;
        bh=8ccD9UJt6vKihn8EhsWbq86Y0nDtnM3sCEUaPwFJiyY=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=Q4VDD1aRT5iNBRyzm7O9HnNwWB/oaLMzcsrFU4YqBdsowQAYI7oTHNY3G4TkzSsjL
         LGOGmZWCX9O9uo3kUr4xMF+sEz0uqY7CoUbO9pzWETweKISsF3bSxjuhhfiEB8FtZQ
         l2/KfMvf5wUmvooPprnPVsUZalrmnLhKzGEQ3WOI=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20230128042608epcas5p42bd0fc3996d8056853cf9596a66eb05a~_XnUv-CJn3217632176epcas5p4P;
        Sat, 28 Jan 2023 04:26:08 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.183]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4P3hG71fbtz4x9Pt; Sat, 28 Jan
        2023 04:26:07 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A0.08.10528.FD3A4D36; Sat, 28 Jan 2023 13:26:07 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20230128042606epcas5p4e110dea83182c0711f802656cb3db515~_XnSQ6yqC3202832028epcas5p4V;
        Sat, 28 Jan 2023 04:26:06 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230128042606epsmtrp167298a1b9a1d3400cbb39caf1d2d948d~_XnSPwjbL1668016680epsmtrp1T;
        Sat, 28 Jan 2023 04:26:06 +0000 (GMT)
X-AuditID: b6c32a49-c17ff70000012920-9e-63d4a3df02d3
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        FD.2D.05839.DD3A4D36; Sat, 28 Jan 2023 13:26:06 +0900 (KST)
Received: from alimakhtar04 (unknown [107.122.12.5]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230128042603epsmtip1b2b266661c2d2dfa10b55919285e0500~_XnPd7Wfm1209812098epsmtip1W;
        Sat, 28 Jan 2023 04:26:03 +0000 (GMT)
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
In-Reply-To: <20230120155404.323386-2-krzysztof.kozlowski@linaro.org>
Subject: RE: [PATCH 01/11] ARM: dts: exynos: correct wr-active property in
 Exynos3250 Rinato
Date:   Sat, 28 Jan 2023 09:56:01 +0530
Message-ID: <000001d932d0$a3362000$e9a26000$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHNuRkKafHieBmUHCY1mc35yYPTTQKTfc43Ai4xyQmupCEE4A==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEJsWRmVeSWpSXmKPExsWy7bCmlu79xVeSDV6+4rCYf+Qcq8XbJbsY
        LSbdn8Bi0f/4NbNF34uHzBZ7X29ltzjb9IbdYtPja6wWl3fNYbOYcX4fk8WZf1NZLBb8sbNY
        t0bQonXvEXaLzd//Mjrwe+ycdZfd4+iVe6wem1Z1snncubaHzWPzknqP/3fWsnt8ae5m9ejb
        sorR4/MmuQDOqGybjNTElNQihdS85PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTcVFslF58A
        XbfMHKD7lRTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkFJgV6xYm5xaV56Xp5qSVW
        hgYGRqZAhQnZGcd7pjIXbBWqaJh1lrWB8ZhgFyMnh4SAicSSXc/Yuxi5OIQEdjNKXHqymwkk
        ISTwiVHi8XQziMQ3RomtB9cyw3RM/7yCEaJoL6PE4hOSEPZLRokVd4JAbDYBXYkdi9vYQJpF
        BNYySxzYsg3MYRY4zShxZeU2sG5OAVeJw2/3sYDYwgJxEqc2fQKzWQRUJTpXgXRzcvAKWEpM
        ff+bGcIWlDg58wlYDbOAtsSyha+hLlKQ+Pl0GSuILSLgJLFu3zcmiBpxiZdHj4D9JiHwhkPi
        4dSNLBANLhKHD82BsoUlXh3fwg5hS0m87G8DsjmAbA+JRX+kIMIZEm+Xr2eEsO0lDlwBaeUA
        mq8psX6XPsQqPone30+YIDp5JTrahCCqVSWa312FWiQtMbG7mxXC9pC4fmMXywRGxVlIHpuF
        5LFZSB6YhbBsASPLKkbJ1ILi3PTUYtMCw7zUcnh0J+fnbmIEJ24tzx2Mdx980DvEyMTBeIhR
        goNZSYR3q+OlZCHelMTKqtSi/Pii0pzU4kOMpsDQnsgsJZqcD8wdeSXxhiaWBiZmZmYmlsZm
        hkrivOq2J5OFBNITS1KzU1MLUotg+pg4OKUamLbn+YftNXQ3Wvovob/lafbW6xfDf85x8zi4
        +04C++H+3dOnpFQzzTabuvRSwK4ZD15dWX9Z65DIg4lsepxaJypLzHcF7+oznfd70nqfGbq5
        Ztqza2T+XjGU0F75/LJ46Jyo9ecvsU14e+KJ+OFcO4WYmD2+am4LFFpNrTY+ucRUW7Hhi090
        6q6a4+a/pt3kSm46krb4n0iAlF1LkmiEgmbqA84XEQs9zXLkeGOlNm/YlZX+zdt0b1QRv4i/
        sUx+m93DbQ9i+z2iglbbSrHJ2zc5nSwySra8dWx2cJb01g+hLUJMRy1Zta2nMO3RE7zVupQ/
        Lels5rRTz/qO7L3Y+1d75Q5Rk/Q3dfOU13CcUWIpzkg01GIuKk4EAKvd9WNlBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDIsWRmVeSWpSXmKPExsWy7bCSnO69xVeSDTZeZ7SYf+Qcq8XbJbsY
        LSbdn8Bi0f/4NbNF34uHzBZ7X29ltzjb9IbdYtPja6wWl3fNYbOYcX4fk8WZf1NZLBb8sbNY
        t0bQonXvEXaLzd//Mjrwe+ycdZfd4+iVe6wem1Z1snncubaHzWPzknqP/3fWsnt8ae5m9ejb
        sorR4/MmuQDOKC6blNSczLLUIn27BK6MtV8TCmbyVTz/dY6xgbGTp4uRk0NCwERi+ucVjCC2
        kMBuRomHzbIQcWmJ6xsnsEPYwhIr/z0HsrmAap4zSpzdeJkJJMEmoCuxY3EbG0hCRGAzs8Tx
        SQeZQRxmgfOMEjdmHGCFaAFyzp+8xwzSwingKnH47T6WLkYODmGBGIk/nx1AwiwCqhKdq0Am
        cXLwClhKTH3/mxnCFpQ4OfMJC4jNLKAt8fTmUzh72cLXzBDnKUj8fLqMFcQWEXCSWLfvGxNE
        jbjEy6NH2CcwCs9CMmoWklGzkIyahaRlASPLKkbJ1ILi3PTcYsMCw7zUcr3ixNzi0rx0veT8
        3E2M4AjW0tzBuH3VB71DjEwcjIcYJTiYlUR4tzpeShbiTUmsrEotyo8vKs1JLT7EKM3BoiTO
        e6HrZLyQQHpiSWp2ampBahFMlomDU6qBqWOhQtfluMaw2+7Xv6/Sk/kftfP17+3uedemX8+I
        m5adx7zErn3RxEDm/69qUjY9DFjU6BHV8vNC2jtFllNKXI31x/4ciomq8vX+tGiVQFqdYnPa
        2aPeUp87E8Jac2apXWVeoMs1NVez0q9n27FdM66+YeZaGzevIC3z08XYkr5Pzw6VrfrTnV/x
        6pjq6yd3L2qtfXgs49HZn+vb5i+ac+5Qip1Q6dSyx2+DUuw10rnP20nz50jKnl5WVmNy77xN
        oNJTzY22ejo6XSdnbauY0Oho9CdBied3+XcmmRv3YvsuhNscusH3J1Ozl1uKddukj3ERW6sr
        Fn/XEt4kX2meX3jSoDU/WDJvpozUm0fdSizFGYmGWsxFxYkAWaF1VE8DAAA=
X-CMS-MailID: 20230128042606epcas5p4e110dea83182c0711f802656cb3db515
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230120155418epcas5p1b9c0be73ebb6d20545208f45414ba861
References: <20230120155404.323386-1-krzysztof.kozlowski@linaro.org>
        <CGME20230120155418epcas5p1b9c0be73ebb6d20545208f45414ba861@epcas5p1.samsung.com>
        <20230120155404.323386-2-krzysztof.kozlowski@linaro.org>
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
Subject:=20=5BPATCH=2001/11=5D=20ARM:=20dts:=20exynos:=20correct=20wr-activ=
e=20property=20in=0D=0A>=20Exynos3250=20Rinato=0D=0A>=20=0D=0A>=20The=20pro=
perty=20is=20wr-active:=0D=0A>=20=0D=0A>=20=20=20exynos3250-rinato.dtb:=20f=
imd=4011c00000:=20i80-if-timings:=20'wr-act'=20does=20not=0D=0A>=20match=20=
any=20of=20the=20regexes:=20'pinctrl-=5B0-9=5D+'=0D=0A>=20=0D=0A>=20Fixes:=
=20b59b3afb94d4=20(=22ARM:=20dts:=20add=20fimd=20device=20support=20for=20e=
xynos3250-=0D=0A>=20rinato=22)=0D=0A>=20Signed-off-by:=20Krzysztof=20Kozlow=
ski=20<krzysztof.kozlowski=40linaro.org>=0D=0A>=20---=0D=0A=0D=0AReviewed-b=
y:=20Alim=20Akhtar=20<alim.akhtar=40samsung.com>=0D=0A=0D=0A>=20=20arch/arm=
/boot/dts/exynos3250-rinato.dts=20=7C=202=20+-=0D=0A>=20=201=20file=20chang=
ed,=201=20insertion(+),=201=20deletion(-)=0D=0A>=20=0D=0A>=20diff=20--git=
=20a/arch/arm/boot/dts/exynos3250-rinato.dts=0D=0A>=20b/arch/arm/boot/dts/e=
xynos3250-rinato.dts=0D=0A>=20index=206d2c7bb19184..2eb682009815=20100644=
=0D=0A>=20---=20a/arch/arm/boot/dts/exynos3250-rinato.dts=0D=0A>=20+++=20b/=
arch/arm/boot/dts/exynos3250-rinato.dts=0D=0A>=20=40=40=20-250,7=20+250,7=
=20=40=40=20&fimd=20=7B=0D=0A>=20=20=09i80-if-timings=20=7B=0D=0A>=20=20=09=
=09cs-setup=20=3D=20<0>;=0D=0A>=20=20=09=09wr-setup=20=3D=20<0>;=0D=0A>=20-=
=09=09wr-act=20=3D=20<1>;=0D=0A>=20+=09=09wr-active=20=3D=20<1>;=0D=0A>=20=
=20=09=09wr-hold=20=3D=20<0>;=0D=0A>=20=20=09=7D;=0D=0A>=20=20=7D;=0D=0A>=
=20--=0D=0A>=202.34.1=0D=0A=0D=0A=0D=0A
