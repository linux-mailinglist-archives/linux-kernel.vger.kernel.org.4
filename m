Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 703DC5FE69C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 03:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbiJNBi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 21:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiJNBi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 21:38:26 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 224A119B661
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 18:38:21 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20221014013815epoutp04dc4615e6a888c34382a82df108845a96~dy8eZCS620808208082epoutp04R
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 01:38:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20221014013815epoutp04dc4615e6a888c34382a82df108845a96~dy8eZCS620808208082epoutp04R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1665711495;
        bh=AIBmilQ7GmQKrAJiEwTCkrdgglgHrHlEoV9KQFWL9U0=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=VagusRcSAD+RLkRbYzAZYBcbwuFJlR8HLuHPZI/43HNDQgQOVnbUmwSZrWhaqii9s
         LiwUf+j0X5f05YmHNcQ3P4ZcIcVyqUiCmlXC6vxnBYKB27UVf6k7IxON4UpO8XntSw
         keke93DgSQjRoSX0A0tyEWhnZMzc4vKgkBT44IZo=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20221014013814epcas5p2cb53c3dc74847b69147e8eaab044abd1~dy8dQL6fx0856808568epcas5p2p;
        Fri, 14 Oct 2022 01:38:14 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.177]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4MpTYH2ls5z4x9Pw; Fri, 14 Oct
        2022 01:38:11 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F1.00.56352.38DB8436; Fri, 14 Oct 2022 10:38:11 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20221014013810epcas5p4ef69d2bc0e80dccec1c69fc13db31374~dy8Z9uXiH2473424734epcas5p4B;
        Fri, 14 Oct 2022 01:38:10 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20221014013810epsmtrp1d5483e00385157eb9f5fc0d5087ab7c7~dy8Z87Or52780827808epsmtrp1O;
        Fri, 14 Oct 2022 01:38:10 +0000 (GMT)
X-AuditID: b6c32a4b-383ff7000001dc20-b8-6348bd836e63
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        CF.7F.14392.28DB8436; Fri, 14 Oct 2022 10:38:10 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20221014013809epsmtip1b065933ad66c718b9c57d7779a86fe73~dy8Ylunwd1816218162epsmtip1y;
        Fri, 14 Oct 2022 01:38:08 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Padmanabhan Rajanbabu'" <p.rajanbabu@samsung.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <chanho61.park@samsung.com>, <linus.walleij@linaro.org>,
        <pankaj.dubey@samsung.com>
Cc:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-samsung-soc@vger.kernel.org>
In-Reply-To: <20221013104024.50179-2-p.rajanbabu@samsung.com>
Subject: RE: [PATCH v3 1/4] arm64: dts: fix drive strength macros as per FSD
 HW UM
Date:   Fri, 14 Oct 2022 07:08:07 +0530
Message-ID: <000001d8df6d$9e0337f0$da09a7d0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKobzBT6PrpQ/yNZITJ48yEumYi1gMlBqTOAbnek8msRwVhcA==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNJsWRmVeSWpSXmKPExsWy7bCmlm7zXo9kg+kvRSwu79e2mH/kHKtF
        34uHzBZT/ixnsri8aw6bxYzz+5gsjm4Mtli09Qu7ReveI+wOnB6bVnWyedy5tofNo2/LKkaP
        z5vkAliism0yUhNTUosUUvOS81My89JtlbyD453jTc0MDHUNLS3MlRTyEnNTbZVcfAJ03TJz
        gC5RUihLzCkFCgUkFhcr6dvZFOWXlqQqZOQXl9gqpRak5BSYFOgVJ+YWl+al6+WlllgZGhgY
        mQIVJmRnbD56krVguUzFvO9b2BoY2yS6GDk5JARMJFbP+8nSxcjFISSwm1HiwI5v7BDOJ0aJ
        rVu2s0I43xgleq/9ZoFpeXr5IZgtJLCXUWJbhzFE0UtGiUn/DzCBJNgEdCV2LG5jA0mICJxl
        lFh54jxYB7NAusTJ2bPZQWxOAVuJS6tWA63g4BAWCJHovOgCEmYRUJV48nUt2BxeAUuJ/lXP
        WCFsQYmTM59AjdGWWLbwNTPEQQoSP58uA6sREXCSaOs5yQRRIy7x8ugRsHckBKZySJz5O4sJ
        osFFovXdT1YIW1ji1fEt7BC2lMTL/jZ2kHskBDwkFv2RgghnSLxdvp4RwraXOHBlDgtICbOA
        psT6XfoQq/gken8/YYLo5JXoaBOCqFaVaH53FRps0hITu7tZYYavaA+dwKg4C8lfs5D8NQvJ
        /bMQdi1gZFnFKJlaUJybnlpsWmCcl1oOj+3k/NxNjOBUquW9g/HRgw96hxiZOBgPMUpwMCuJ
        8LqEuCUL8aYkVlalFuXHF5XmpBYfYjQFBvZEZinR5HxgMs8riTc0sTQwMTMzM7E0NjNUEudd
        PEMrWUggPbEkNTs1tSC1CKaPiYNTqoFJ+4Khm/uPz1PPc148fOtHY7p3540L83yfvz6yJFiJ
        +/iuB/cSE70v9u5sfGHbcmvCSqfGK9tOOvyMbBB4vG9H9oV4of2LZzcVOb9kmZovO8fbPf+6
        qP2OGVM6uP4duXvi3G6Z+a522sovVF53b35wivWXldhCj5fPC3nfPH85seVo4eXZnmHl+wPT
        PkpOaVuZKxFgbvv2uZnGOuWDuZXzvqfLK2SdTZCreZOWv/6Yg2f5M6sQ6/SD5mcXmgq+0Tlg
        c5B1u+jPhjlTCvcpcp2ycs6LSdwZERy1wPtuyz7ftzlaAoUXJ3heDZrWkffE9aXz9V+HPq+q
        W6W0LSQp+m3lTvGGx6V/vk/nuWMhaawkrcRSnJFoqMVcVJwIAE5L3awuBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgkeLIzCtJLcpLzFFi42LZdlhJTrdpr0eywa3HkhaX92tbzD9yjtWi
        78VDZospf5YzWVzeNYfNYsb5fUwWRzcGWyza+oXdonXvEXYHTo9NqzrZPO5c28Pm0bdlFaPH
        501yASxRXDYpqTmZZalF+nYJXBlLLy9lLFgnXdGz+wJbA2O3eBcjJ4eEgInE08sPWboYuTiE
        BHYzSnz+2s0IkZCWuL5xAjuELSyx8t9zdoii54wSG89uZQFJsAnoSuxY3MYGkhARuMgoce3H
        XLAOZoFMie6jR6HG7meUWPBjEViCU8BW4tKq1awgtrBAkMSbOz1gcRYBVYknX9cygdi8ApYS
        /auesULYghInZz5hgRiqLfH05lM4e9nC18wQ5ylI/Hy6DKxeRMBJoq3nJBNEjbjEy6NH2Ccw
        Cs9CMmoWklGzkIyahaRlASPLKkbJ1ILi3PTcYsMCw7zUcr3ixNzi0rx0veT83E2M4MjS0tzB
        uH3VB71DjEwcjIcYJTiYlUR4XULckoV4UxIrq1KL8uOLSnNSiw8xSnOwKInzXug6GS8kkJ5Y
        kpqdmlqQWgSTZeLglGpgkpIJXctgb7xij9XzZn/zJVlFxze5ZmVe3iDRdG/yJlXNiJq15km8
        k7axPvpvyXn94PalnzdOUFIpcu0+YWf6RqzJK2dyU2f2z7Vnsmo6215m7BXyvO7qz7SDzVRc
        55dsTgrPlJLAQ0EhM1Rv691YbrfB55KjY0bfy64NF1+Y/DCes8j7X7+nooXv4rv7jcoPxEZv
        e55VJblw5ZHN99e83W71Rzr0ua7a3yu5F6tybna1Tavy7/4skd+9TEkl6NBRH4lr/K9ioo4v
        8em0Cf5heM90b8GiWb3SRpfDp94UXKW4feejX1lcGs8jomcZR7UelXjwNT/gVtjLb4crAn7L
        fXiep7c2quHrgTvb5rGFK7EUZyQaajEXFScCAJTMoyEbAwAA
X-CMS-MailID: 20221014013810epcas5p4ef69d2bc0e80dccec1c69fc13db31374
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221013110721epcas5p44cc7dcc5ac2ab8eaf6c472cc87dea06f
References: <20221013104024.50179-1-p.rajanbabu@samsung.com>
        <CGME20221013110721epcas5p44cc7dcc5ac2ab8eaf6c472cc87dea06f@epcas5p4.samsung.com>
        <20221013104024.50179-2-p.rajanbabu@samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>-----Original Message-----
>From: Padmanabhan Rajanbabu =5Bmailto:p.rajanbabu=40samsung.com=5D
>Sent: Thursday, October 13, 2022 4:10 PM
>To: robh+dt=40kernel.org; krzysztof.kozlowski+dt=40linaro.org;
>alim.akhtar=40samsung.com; chanho61.park=40samsung.com;
>linus.walleij=40linaro.org; pankaj.dubey=40samsung.com
>Cc: devicetree=40vger.kernel.org; linux-kernel=40vger.kernel.org; linux-
>samsung-soc=40vger.kernel.org; Padmanabhan Rajanbabu
><p.rajanbabu=40samsung.com>
>Subject: =5BPATCH v3 1/4=5D arm64: dts: fix drive strength macros as per F=
SD HW
>UM
>
>Drive strength macros defined for FSD platform is not reflecting actual na=
mes
>and values as per HW UM. FSD SoC pinctrl has following four levels of driv=
e-
>strength and their corresponding values:
>Level-1 <-> 0
>Level-2 <-> 1
>Level-4 <-> 2
>Level-6 <-> 3
>
>The commit 684dac402f21 (=22arm64: dts: fsd: Add initial pinctrl support=
=22) used
>drive strength macros defined for Exynos4 SoC family. For some IPs the
>macros values of Exynos4 matched and worked well, but Exynos4 SoC family
>drive-strength (names and values) is not exactly matching with FSD SoC.
>
>Fix the drive strength macros to reflect actual names and values given in =
FSD
>HW UM.
>
>Fixes: 684dac402f21 (=22arm64: dts: fsd: Add initial pinctrl support=22)
>Signed-off-by: Padmanabhan Rajanbabu <p.rajanbabu=40samsung.com>
>---

Reviewed-by: Alim Akhtar <alim.akhtar=40samsung.com>

Thanks=21

> arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi =7C 8 ++++----
> arch/arm64/boot/dts/tesla/fsd-pinctrl.h    =7C 6 +++---
> 2 files changed, 7 insertions(+), 7 deletions(-)
>
>diff --git a/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi
>b/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi
>index d0abb9aa0e9e..4e151d419909 100644
>--- a/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi
>+++ b/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi
>=40=40 -55,14 +55,14 =40=40
> 		samsung,pins =3D =22gpf5-0=22;
> 		samsung,pin-function =3D <FSD_PIN_FUNC_2>;
> 		samsung,pin-pud =3D <FSD_PIN_PULL_NONE>;
>-		samsung,pin-drv =3D <FSD_PIN_DRV_LV2>;
>+		samsung,pin-drv =3D <FSD_PIN_DRV_LV4>;
> 	=7D;
>
> 	ufs_refclk_out: ufs-refclk-out-pins =7B
> 		samsung,pins =3D =22gpf5-1=22;
> 		samsung,pin-function =3D <FSD_PIN_FUNC_2>;
> 		samsung,pin-pud =3D <FSD_PIN_PULL_NONE>;
>-		samsung,pin-drv =3D <FSD_PIN_DRV_LV2>;
>+		samsung,pin-drv =3D <FSD_PIN_DRV_LV4>;
> 	=7D;
> =7D;
>
>=40=40 -239,14 +239,14 =40=40
> 		samsung,pins =3D =22gpb6-1=22;
> 		samsung,pin-function =3D <FSD_PIN_FUNC_2>;
> 		samsung,pin-pud =3D <FSD_PIN_PULL_UP>;
>-		samsung,pin-drv =3D <FSD_PIN_DRV_LV2>;
>+		samsung,pin-drv =3D <FSD_PIN_DRV_LV4>;
> 	=7D;
>
> 	pwm1_out: pwm1-out-pins =7B
> 		samsung,pins =3D =22gpb6-5=22;
> 		samsung,pin-function =3D <FSD_PIN_FUNC_2>;
> 		samsung,pin-pud =3D <FSD_PIN_PULL_UP>;
>-		samsung,pin-drv =3D <FSD_PIN_DRV_LV2>;
>+		samsung,pin-drv =3D <FSD_PIN_DRV_LV4>;
> 	=7D;
>
> 	hs_i2c0_bus: hs-i2c0-bus-pins =7B
>diff --git a/arch/arm64/boot/dts/tesla/fsd-pinctrl.h
>b/arch/arm64/boot/dts/tesla/fsd-pinctrl.h
>index 6ffbda362493..c397d02208a0 100644
>--- a/arch/arm64/boot/dts/tesla/fsd-pinctrl.h
>+++ b/arch/arm64/boot/dts/tesla/fsd-pinctrl.h
>=40=40 -16,9 +16,9 =40=40
> =23define FSD_PIN_PULL_UP			3
>
> =23define FSD_PIN_DRV_LV1			0
>-=23define FSD_PIN_DRV_LV2			2
>-=23define FSD_PIN_DRV_LV3			1
>-=23define FSD_PIN_DRV_LV4			3
>+=23define FSD_PIN_DRV_LV2			1
>+=23define FSD_PIN_DRV_LV4			2
>+=23define FSD_PIN_DRV_LV6			3
>
> =23define FSD_PIN_FUNC_INPUT		0
> =23define FSD_PIN_FUNC_OUTPUT		1
>--
>2.17.1


