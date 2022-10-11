Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5915FABE3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 07:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbiJKFXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 01:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiJKFXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 01:23:22 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 739158053F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 22:23:18 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20221011052313epoutp02d5022afe8988643e79b818d901691fe3~c7FC7NAQ32361323613epoutp02w
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 05:23:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20221011052313epoutp02d5022afe8988643e79b818d901691fe3~c7FC7NAQ32361323613epoutp02w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1665465793;
        bh=qo4uTsqjB1XWtG7EvV3lp+LW93qWKdFmNASF8vkKxGs=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=lV1/Ud3POOakx1Jt9Zsavzg44+ZMi1tokv1EqGymGRwhuKklfRjk0qap8AKXyk2RY
         lNJ5dtHf9Ng3lXj2WwfQb05sH26ZLUtg3wZu3jUsetaJ6oft81FpfalTdLFjB5aLYn
         ilG8KnA8YMnrBQGsrr4biNVdkdLIuctmgVPx2Drw=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20221011052313epcas5p3ce1246cda3ec3c131e0704d43bd1a423~c7FCmpiiO3219932199epcas5p3e;
        Tue, 11 Oct 2022 05:23:13 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.182]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4MmkhG47Lhz4x9Q6; Tue, 11 Oct
        2022 05:23:10 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        AB.FD.39477.EBDF4436; Tue, 11 Oct 2022 14:23:10 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20221011052310epcas5p18d8f7a6184e73e39a712e0734e0cbac8~c7E-fGexW2698226982epcas5p1P;
        Tue, 11 Oct 2022 05:23:10 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20221011052309epsmtrp15753f83d0d52459d1dc5f3735b46abf4~c7E-eNoKN1986019860epsmtrp1R;
        Tue, 11 Oct 2022 05:23:09 +0000 (GMT)
X-AuditID: b6c32a4a-007ff70000019a35-a0-6344fdbed68c
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B7.70.14392.DBDF4436; Tue, 11 Oct 2022 14:23:09 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20221011052308epsmtip19cde4d8139e5f0fa5916066cb71be940~c7E9-LNju1256512565epsmtip1p;
        Tue, 11 Oct 2022 05:23:08 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Padmanabhan Rajanbabu'" <p.rajanbabu@samsung.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <chanho61.park@samsung.com>, <linus.walleij@linaro.org>,
        <pankaj.dubey@samsung.com>
Cc:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-samsung-soc@vger.kernel.org>
In-Reply-To: <20221010120438.80680-1-p.rajanbabu@samsung.com>
Subject: RE: [PATCH] arm64: dts: fix drive strength macros as per FSD HW UM
Date:   Tue, 11 Oct 2022 10:53:06 +0530
Message-ID: <000001d8dd31$8d079510$a716bf30$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJKGaiSsiqhKxku7uYTSPaoJqYSAAESoaKbrR2ZcyA=
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLJsWRmVeSWpSXmKPExsWy7bCmhu6+vy7JBht+i1hc3q9tMf/IOVaL
        vhcPmS2m/FnOZHF51xw2ixnn9zFZHN0YbLFo6xd2i9a9R9gdOD02repk87hzbQ+bR9+WVYwe
        nzfJBbBEZdtkpCampBYppOYl56dk5qXbKnkHxzvHm5oZGOoaWlqYKynkJeam2iq5+AToumXm
        AF2ipFCWmFMKFApILC5W0rezKcovLUlVyMgvLrFVSi1IySkwKdArTswtLs1L18tLLbEyNDAw
        MgUqTMjO+PX1L0vBQbOKx427mBoYf+l2MXJySAiYSMy/uJGli5GLQ0hgN6PE3lNboZxPjBK/
        PyxhhnC+MUo8nHCUFaZlxvHHUFV7GSUuXzzCDuG8ZJQ4cu8JI0gVm4CuxI7FbWwgCRGBs4wS
        K0+cZwFJMAukS5ycPZsdxOYUsJV4NvUiWIOwgLdEz+VHYCtYBFQl+rZMYQKxeQUsJZZ1zWCB
        sAUlTs58AjVHW2LZwtfMECcpSPx8ugysV0TASuLvvUZWiBpxiZdHIa6TEJjJIbG2vZENosFF
        Yu3D91C2sMSr41vYIWwpiZf9bUA2B5DtIbHojxREOEPi7fL1jBC2vcSBK3NYQEqYBTQl1u/S
        h1jFJ9H7+wkTRCevREebEES1qkTzu6ssELa0xMTublaY4bfu80xgVJyF5K9ZSP6aheT+WQi7
        FjCyrGKUTC0ozk1PLTYtMMpLLYfHd3J+7iZGcDrV8trB+PDBB71DjEwcjIcYJTiYlUR4Gec7
        JQvxpiRWVqUW5ccXleakFh9iNAUG9kRmKdHkfGBCzyuJNzSxNDAxMzMzsTQ2M1QS5108QytZ
        SCA9sSQ1OzW1ILUIpo+Jg1OqgWmvxNPP4WxXqy8FR7xm1P3AG7I+svZx5ofFqZd2F2Tl+l/z
        sc0y3ns05Z/KebWXm96//sHim/SvbMtivtsXRIXuLrsX3OXYY3Vh+fwyNTvr4GP3bt4/1cxv
        E/Xl1uo5V3gOftNd1iXKUJL2WyDFZL2bzBXHC/EiypbWq5wfBv436mm5V8zwZkaQ46zvPRu8
        tRwvRD66ZLlPruPql7O29+6lPTP0ecWp51DJw3Hvx4tjClyzVTMTZu2YabKtZMpMh/0uj50N
        9pTEvZy55tkzV3+2a/9XfLOY/lSZ1e6buc6v1omxCloFT7mvXFWUqz8uvIK7OEPy0oqTsXd3
        L9FmE/ifpy9XdHtN1XVG/bjVumeUWIozEg21mIuKEwGfhRKMMAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnkeLIzCtJLcpLzFFi42LZdlhJTnfvX5dkg+t7jC0u79e2mH/kHKtF
        34uHzBZT/ixnsri8aw6bxYzz+5gsjm4Mtli09Qu7ReveI+wOnB6bVnWyedy5tofNo2/LKkaP
        z5vkAliiuGxSUnMyy1KL9O0SuDLmPGliLVhmUnFqsUkD40PtLkZODgkBE4kZxx+zdDFycQgJ
        7GaUaNq1kxEiIS1xfeMEdghbWGLlv+fsEEXPGSXONK9hAUmwCehK7FjcxgaSEBG4yChx7cdc
        sA5mgUyJ7qNHocb2MUqsXLwJLMEpYCvxbOpFsBXCAt4SPZcfsYLYLAKqEn1bpjCB2LwClhLL
        umawQNiCEidnPmGBGKot8fTmUzh72cLXzBDnKUj8fLoMbI6IgJXE33uNrBA14hIvjx5hn8Ao
        PAvJqFlIRs1CMmoWkpYFjCyrGCVTC4pz03OLDQsM81LL9YoTc4tL89L1kvNzNzGC40pLcwfj
        9lUf9A4xMnEwHmKU4GBWEuFlnO+ULMSbklhZlVqUH19UmpNafIhRmoNFSZz3QtfJeCGB9MSS
        1OzU1ILUIpgsEwenVAPT+jfhKhl7+J0Vvv7qZD0gMytNgOlSjORc121PHCxWuqz4OyPiBg/L
        O5s/kUfkfhnfWbF5JZNlz82NwqntG7/LRfXP/rtNqEM9ucH0/YaS4z+PrMo16Mv8JbUzf9a0
        rTe5j8qU3DT19NF6tuLit+ddf05/PTX5+d2ja/hKo/ff2GI7Qa9GaUq04dalhezVPw7cOLT7
        38Z2ztrn0459eWNVd/qOgYf0vSfcVlU31PfmeahWf23Vuji9QGlO8ftJMSmbVraVNrZPSZO9
        NaP55psTXybM2pj213JP3I11iZM+y8S8ff4s8VGh+anXH5R733s3Gp/66Ouw0S28a5fqFp1q
        0WKJm/IHj96OtHu162f0LGclluKMREMt5qLiRAD00ng+GgMAAA==
X-CMS-MailID: 20221011052310epcas5p18d8f7a6184e73e39a712e0734e0cbac8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221010123120epcas5p3ba947a3a982bc6a78310472c2a65ebfe
References: <CGME20221010123120epcas5p3ba947a3a982bc6a78310472c2a65ebfe@epcas5p3.samsung.com>
        <20221010120438.80680-1-p.rajanbabu@samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>-----Original Message-----
>From: Padmanabhan Rajanbabu =5Bmailto:p.rajanbabu=40samsung.com=5D
>Sent: Monday, October 10, 2022 5:35 PM
>To: robh+dt=40kernel.org; krzysztof.kozlowski+dt=40linaro.org;
>alim.akhtar=40samsung.com; chanho61.park=40samsung.com;
>linus.walleij=40linaro.org; pankaj.dubey=40samsung.com
>Cc: devicetree=40vger.kernel.org; linux-kernel=40vger.kernel.org; linux-sa=
msung-
>soc=40vger.kernel.org; Padmanabhan Rajanbabu <p.rajanbabu=40samsung.com>
>Subject: =5BPATCH=5D arm64: dts: fix drive strength macros as per FSD HW U=
M
>
>In FSD pinctrl implementation, the pinctrl driver is using drive strength =
MACROs,
>which are deviating from the actual values specified in FSD HW UM
>
>This patch adds the right pinctrl drive strength values for FSD SoC. This =
patch also
>ensures that the peripherals are using right drive strength MACROs in-orde=
r to
>function as expected
>

Please simply the commit message

And a Fixes: tag (the original commit which introduce this change)

>Signed-off-by: Padmanabhan Rajanbabu <p.rajanbabu=40samsung.com>
>---
> arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi =7C 34 +++++++++++-----------
> arch/arm64/boot/dts/tesla/fsd-pinctrl.h    =7C  6 ++--
> 2 files changed, 20 insertions(+), 20 deletions(-)
>
>diff --git a/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi
>b/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi
>index d0abb9aa0e9e..e3852c946352 100644
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
>=40=40 -239,105 +239,105 =40=40
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
> 		samsung,pins =3D =22gpb7-0=22, =22gpb7-1=22;
> 		samsung,pin-function =3D <FSD_PIN_FUNC_2>;
> 		samsung,pin-pud =3D <FSD_PIN_PULL_NONE>;
>-		samsung,pin-drv =3D <FSD_PIN_DRV_LV1>;
>+		samsung,pin-drv =3D <FSD_PIN_DRV_LV4>;
> 	=7D;
>
> 	uart1_data: uart1-data-pins =7B
> 		samsung,pins =3D =22gpb7-4=22, =22gpb7-5=22;
> 		samsung,pin-function =3D <FSD_PIN_FUNC_2>;
> 		samsung,pin-pud =3D <FSD_PIN_PULL_NONE>;
>-		samsung,pin-drv =3D <FSD_PIN_DRV_LV1>;
>+		samsung,pin-drv =3D <FSD_PIN_DRV_LV4>;
> 	=7D;
>
> 	spi0_bus: spi0-bus-pins =7B
> 		samsung,pins =3D =22gpb4-0=22, =22gpb4-2=22, =22gpb4-3=22;
> 		samsung,pin-function =3D <FSD_PIN_FUNC_2>;
> 		samsung,pin-pud =3D <FSD_PIN_PULL_UP>;
>-		samsung,pin-drv =3D <FSD_PIN_DRV_LV1>;
>+		samsung,pin-drv =3D <FSD_PIN_DRV_LV4>;
> 	=7D;
>
> 	spi1_bus: spi1-bus-pins =7B
> 		samsung,pins =3D =22gpb4-4=22, =22gpb4-6=22, =22gpb4-7=22;
> 		samsung,pin-function =3D <FSD_PIN_FUNC_2>;
> 		samsung,pin-pud =3D <FSD_PIN_PULL_UP>;
>-		samsung,pin-drv =3D <FSD_PIN_DRV_LV1>;
>+		samsung,pin-drv =3D <FSD_PIN_DRV_LV4>;
> 	=7D;
>
> 	spi2_bus: spi2-bus-pins =7B
> 		samsung,pins =3D =22gpb5-0=22, =22gpb5-2=22, =22gpb5-3=22;
> 		samsung,pin-function =3D <FSD_PIN_FUNC_2>;
> 		samsung,pin-pud =3D <FSD_PIN_PULL_UP>;
>-		samsung,pin-drv =3D <FSD_PIN_DRV_LV1>;
>+		samsung,pin-drv =3D <FSD_PIN_DRV_LV4>;
> 	=7D;
> =7D;
>
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
I cross checked with update UM, this is the correct DRV levels. Thanks

> =23define FSD_PIN_FUNC_INPUT		0
> =23define FSD_PIN_FUNC_OUTPUT		1
>--
>2.17.1


