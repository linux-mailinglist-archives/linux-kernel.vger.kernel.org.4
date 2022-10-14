Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A79B5FE6A1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 03:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiJNBj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 21:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiJNBj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 21:39:56 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82EE516593
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 18:39:49 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20221014013946epoutp033a6fb10161165749fa5f6cde59a04ce0~dy9zDjzUq1145111451epoutp03p
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 01:39:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20221014013946epoutp033a6fb10161165749fa5f6cde59a04ce0~dy9zDjzUq1145111451epoutp03p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1665711586;
        bh=wW2hR6VYUIPD5GNhet3VJG/BDmO5PBF1rwd/dum+50o=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=EbR3+1T/JBzTrTCN1Bsc8i9I/OXp5iuWJ0K5T4ShEba8CygVMsd7LkTkPa8rlRcfi
         H8iWL5ZbeFFJE4/+c3TnE/rPY3UujlzFxBuWwWepXqU3VrL6AdIdKjDMUp/Dmxcr8/
         o/haI5UNZv1GT6jKHjKuUCN6vLu6pr2CbK/wacyU=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20221014013945epcas5p4f0ddafd6159393f302c387f0834e166c~dy9yrawf32763327633epcas5p42;
        Fri, 14 Oct 2022 01:39:45 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.183]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4MpTb216cQz4x9Q3; Fri, 14 Oct
        2022 01:39:42 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        9F.50.56352.EDDB8436; Fri, 14 Oct 2022 10:39:42 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20221014013941epcas5p12a3da00e925568412cae5f479bdff37e~dy9uudaeP1431314313epcas5p1p;
        Fri, 14 Oct 2022 01:39:41 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20221014013941epsmtrp1f20a71e97e0dd09869d73bf368690a1b~dy9utt0GC2917529175epsmtrp1S;
        Fri, 14 Oct 2022 01:39:41 +0000 (GMT)
X-AuditID: b6c32a4b-383ff7000001dc20-db-6348bdde2aee
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        E6.F5.18644.DDDB8436; Fri, 14 Oct 2022 10:39:41 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20221014013940epsmtip2062f5f08363f6b90a8bbfd8a22f67341~dy9tYv-S10982709827epsmtip2V;
        Fri, 14 Oct 2022 01:39:40 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Padmanabhan Rajanbabu'" <p.rajanbabu@samsung.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <chanho61.park@samsung.com>, <linus.walleij@linaro.org>,
        <pankaj.dubey@samsung.com>
Cc:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-samsung-soc@vger.kernel.org>
In-Reply-To: <20221013104024.50179-3-p.rajanbabu@samsung.com>
Subject: RE: [PATCH v3 2/4] arm64: dts: fix HSI2C drive strength values as
 per FSD HW UM
Date:   Fri, 14 Oct 2022 07:09:38 +0530
Message-ID: <000101d8df6d$d448f4d0$7cdade70$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKobzBT6PrpQ/yNZITJ48yEumYi1gOFRAV4Ao1JZc+sPWiB8A==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLJsWRmVeSWpSXmKPExsWy7bCmhu69vR7JBsd6WS0u79e2mH/kHKtF
        34uHzBZT/ixnsri8aw6bxYzz+5gsjm4Mtli09Qu7ReveI+wOnB6bVnWyedy5tofNo2/LKkaP
        z5vkAliism0yUhNTUosUUvOS81My89JtlbyD453jTc0MDHUNLS3MlRTyEnNTbZVcfAJ03TJz
        gC5RUihLzCkFCgUkFhcr6dvZFOWXlqQqZOQXl9gqpRak5BSYFOgVJ+YWl+al6+WlllgZGhgY
        mQIVJmRnLNryiL1gmmzFnZmrWRsYX0h0MXJySAiYSNxYdIeli5GLQ0hgN6PEpodH2CGcT4wS
        l+a3skE4nxklvq5uYIFp+fryDFRiF6PElMYfUM5LRomJV2ezg1SxCehK7FjcBpYQETjLKLHy
        xHmwdmaBdImTsyGKOAVsJfZsnQIWFxaIkth3cQojiM0ioCrx7vsJ1i5GDg5eAUuJP8e9QMK8
        AoISJ2c+gRqjLbFs4WtmiIsUJH4+XcYKYosIOElMW7GICaJGXOLlUYh/JARmckhc3ricFaLB
        RWLl3gNMELawxKvjW9ghbCmJl/1t7CB7JQQ8JBb9kYIIZ0i8Xb6eEcK2lzhwZQ4LSAmzgKbE
        +l36EKv4JHp/P2GC6OSV6GgTgqhWlWh+dxUabtISE7u7oQ7wkHjU9YFtAqPiLCSPzULy2Cwk
        D8xCWLaAkWUVo2RqQXFuemqxaYFxXmo5PL6T83M3MYLTqZb3DsZHDz7oHWJk4mA8xCjBwawk
        wusS4pYsxJuSWFmVWpQfX1Sak1p8iNEUGNgTmaVEk/OBCT2vJN7QxNLAxMzMzMTS2MxQSZx3
        8QytZCGB9MSS1OzU1ILUIpg+Jg5OqQam29t7z7Pcf+e75nvi+diL+qcLHrw/dyptesTaYmH5
        hOXxa9i4pWdx2+uJXlF6Htn8mOtOzf11V4812eftks+68eVjhKdMrG3kj/ZFnr82leUf7ZEO
        26Y06fPVCa9/pu5+2rc1tKvJY+KtaRw9aoKnvry4qrJy+nlXx7bJy9Q5v/erCTxqPXusvSfc
        ojLOUjijt3GqmP6T1awR0fqJL5V5jF4vUl+84mimVtqOb3u77+Swa5W/sMutKP3F6fDx/LrU
        +o8fZmgJVm/YcIWFsXTjBZ3iHGWr53K5nMZsN7uMUi/bxC3/sOhh3k2JA9tEKqcLX32992+B
        cvQ7wQXnGHZX1nsl+E/fn5sR/aerN0pGiaU4I9FQi7moOBEAy4cirTAEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnkeLIzCtJLcpLzFFi42LZdlhJXvfuXo9kg1k/ZSwu79e2mH/kHKtF
        34uHzBZT/ixnsri8aw6bxYzz+5gsjm4Mtli09Qu7ReveI+wOnB6bVnWyedy5tofNo2/LKkaP
        z5vkAliiuGxSUnMyy1KL9O0SuDI+r//NWNApUzH56VfGBsab4l2MnBwSAiYSX1+eYeti5OIQ
        EtjBKHH4dgs7REJa4vrGCVC2sMTKf8/ZIYqeM0rsOf2HCSTBJqArsWNxG1i3iMBFRolrP+aC
        dTALZEp0Hz3KAtGxn1Hi+fQjbCAJTgFbiT1bp7CA2MICERKbvv8Cs1kEVCXefT/B2sXIwcEr
        YCnx57gXSJhXQFDi5MwnLBAztSWe3nwKZy9b+JoZ4joFiZ9Pl7GC2CICThLTVixigqgRl3h5
        9Aj7BEbhWUhGzUIyahaSUbOQtCxgZFnFKJlaUJybnltsWGCUl1quV5yYW1yal66XnJ+7iREc
        V1paOxj3rPqgd4iRiYPxEKMEB7OSCK9LiFuyEG9KYmVValF+fFFpTmrxIUZpDhYlcd4LXSfj
        hQTSE0tSs1NTC1KLYLJMHJxSDUw5185XuLS36rN8uCK9QSUpaL198wolhfk56VU2hvO/z9h0
        Y2NOT3vlHxOnE66bd/Nw7XPYuuGTEpN52BLvgndLFk+5mFXutHKhh/zHbR7qsskWLGE3EqdO
        eVXjsXjpTrdEjc/HU5PUAnsVbbKE5gUf2Nke7nBRQNO+8t4FFTOB2M2zUoM1Uk8fSVZQ7/Bt
        D89QcmhMzdnNvtbvHKv3NaMJ0zw517dKWxUL7Xhb8nm1lJ9yZ9DKc4IvVvv6O6xqDT2+4sLK
        rxGvdJ8/CWjId21icOe6fa/UYLnn0+rjwdvK6353P9rzZO+5uHU2f3qmN/6cc0vOtuQYT11o
        ZdHk0lmMBv6bHez6OxZM233okxJLcUaioRZzUXEiABiXWjUaAwAA
X-CMS-MailID: 20221014013941epcas5p12a3da00e925568412cae5f479bdff37e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221013110725epcas5p1411c422eb2c29494fd5c1e66e09564c5
References: <20221013104024.50179-1-p.rajanbabu@samsung.com>
        <CGME20221013110725epcas5p1411c422eb2c29494fd5c1e66e09564c5@epcas5p1.samsung.com>
        <20221013104024.50179-3-p.rajanbabu@samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
>Subject: =5BPATCH v3 2/4=5D arm64: dts: fix HSI2C drive strength values as=
 per FSD
>HW UM
>
>Drive strength values used for HSI2C is not reflecting the default values
>recommended by FSD HW UM.
>
>Fix the drive strength values for HSI2C, thereby ensuring that the existin=
g
>device tree file is using default drive strength values recommended by UM =
for
>FSD SoC.
>
>Fixes: 684dac402f21 (=22arm64: dts: fsd: Add initial pinctrl support=22)
>Signed-off-by: Padmanabhan Rajanbabu <p.rajanbabu=40samsung.com>
>---

Reviewed-by: Alim Akhtar <alim.akhtar=40samsung.com>


> arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi =7C 16 ++++++++--------
> 1 file changed, 8 insertions(+), 8 deletions(-)
>
>diff --git a/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi
>b/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi
>index 4e151d419909..09a492b1fd6e 100644
>--- a/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi
>+++ b/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi
>=40=40 -253,56 +253,56 =40=40
> 		samsung,pins =3D =22gpb0-0=22, =22gpb0-1=22;
> 		samsung,pin-function =3D <FSD_PIN_FUNC_2>;
> 		samsung,pin-pud =3D <FSD_PIN_PULL_UP>;
>-		samsung,pin-drv =3D <FSD_PIN_DRV_LV1>;
>+		samsung,pin-drv =3D <FSD_PIN_DRV_LV4>;
> 	=7D;
>
> 	hs_i2c1_bus: hs-i2c1-bus-pins =7B
> 		samsung,pins =3D =22gpb0-2=22, =22gpb0-3=22;
> 		samsung,pin-function =3D <FSD_PIN_FUNC_2>;
> 		samsung,pin-pud =3D <FSD_PIN_PULL_UP>;
>-		samsung,pin-drv =3D <FSD_PIN_DRV_LV1>;
>+		samsung,pin-drv =3D <FSD_PIN_DRV_LV4>;
> 	=7D;
>
> 	hs_i2c2_bus: hs-i2c2-bus-pins =7B
> 		samsung,pins =3D =22gpb0-4=22, =22gpb0-5=22;
> 		samsung,pin-function =3D <FSD_PIN_FUNC_2>;
> 		samsung,pin-pud =3D <FSD_PIN_PULL_UP>;
>-		samsung,pin-drv =3D <FSD_PIN_DRV_LV1>;
>+		samsung,pin-drv =3D <FSD_PIN_DRV_LV4>;
> 	=7D;
>
> 	hs_i2c3_bus: hs-i2c3-bus-pins =7B
> 		samsung,pins =3D =22gpb0-6=22, =22gpb0-7=22;
> 		samsung,pin-function =3D <FSD_PIN_FUNC_2>;
> 		samsung,pin-pud =3D <FSD_PIN_PULL_UP>;
>-		samsung,pin-drv =3D <FSD_PIN_DRV_LV1>;
>+		samsung,pin-drv =3D <FSD_PIN_DRV_LV4>;
> 	=7D;
>
> 	hs_i2c4_bus: hs-i2c4-bus-pins =7B
> 		samsung,pins =3D =22gpb1-0=22, =22gpb1-1=22;
> 		samsung,pin-function =3D <FSD_PIN_FUNC_2>;
> 		samsung,pin-pud =3D <FSD_PIN_PULL_UP>;
>-		samsung,pin-drv =3D <FSD_PIN_DRV_LV1>;
>+		samsung,pin-drv =3D <FSD_PIN_DRV_LV4>;
> 	=7D;
>
> 	hs_i2c5_bus: hs-i2c5-bus-pins =7B
> 		samsung,pins =3D =22gpb1-2=22, =22gpb1-3=22;
> 		samsung,pin-function =3D <FSD_PIN_FUNC_2>;
> 		samsung,pin-pud =3D <FSD_PIN_PULL_UP>;
>-		samsung,pin-drv =3D <FSD_PIN_DRV_LV1>;
>+		samsung,pin-drv =3D <FSD_PIN_DRV_LV4>;
> 	=7D;
>
> 	hs_i2c6_bus: hs-i2c6-bus-pins =7B
> 		samsung,pins =3D =22gpb1-4=22, =22gpb1-5=22;
> 		samsung,pin-function =3D <FSD_PIN_FUNC_2>;
> 		samsung,pin-pud =3D <FSD_PIN_PULL_UP>;
>-		samsung,pin-drv =3D <FSD_PIN_DRV_LV1>;
>+		samsung,pin-drv =3D <FSD_PIN_DRV_LV4>;
> 	=7D;
>
> 	hs_i2c7_bus: hs-i2c7-bus-pins =7B
> 		samsung,pins =3D =22gpb1-6=22, =22gpb1-7=22;
> 		samsung,pin-function =3D <FSD_PIN_FUNC_2>;
> 		samsung,pin-pud =3D <FSD_PIN_PULL_UP>;
>-		samsung,pin-drv =3D <FSD_PIN_DRV_LV1>;
>+		samsung,pin-drv =3D <FSD_PIN_DRV_LV4>;
> 	=7D;
>
> 	uart0_data: uart0-data-pins =7B
>--
>2.17.1


