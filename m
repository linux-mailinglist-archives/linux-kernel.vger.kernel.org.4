Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E257B5FC0D8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 08:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiJLGmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 02:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiJLGmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 02:42:45 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4802AB0B2A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 23:42:40 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20221012064237epoutp02666f6cab0153dcdd6fd009236210087d~dPzqO7JEk2208422084epoutp02B
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 06:42:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20221012064237epoutp02666f6cab0153dcdd6fd009236210087d~dPzqO7JEk2208422084epoutp02B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1665556957;
        bh=8cVwXmXPUtciJSlQgw9CsI5rBeJqMyEkQbHeFkErvcs=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=mSxYoMqfyEsvt/6yoyY7Hyhjzk/CMUAsen3ZudLmL4jP4iV4ZpW+k9fZU+OoCG+rC
         xiwLF46R35AZKrmx7KEvN3kbWbhoQ+cVHXXu2CigtdyQkezY7dfGHmL2/VHDtNTpf7
         vKMFJbwM1sRo0vJjcSiTvYxM4Q0FytgcIyLbHFRQ=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20221012064237epcas5p1dcd062d6d9afc4336f3edaebcb4eafc1~dPzpy7iBG0093300933epcas5p16;
        Wed, 12 Oct 2022 06:42:37 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.175]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4MnNPQ3NLZz4x9Q9; Wed, 12 Oct
        2022 06:42:34 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        52.63.56352.7D166436; Wed, 12 Oct 2022 15:42:31 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20221012064230epcas5p1467d63d8a89b648bb314197240158e97~dPzjtaGa80093300933epcas5p1v;
        Wed, 12 Oct 2022 06:42:30 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221012064230epsmtrp2f9cbd7810440e86fbcc6b1a1317e10e7~dPzjsfhmW0347703477epsmtrp2l;
        Wed, 12 Oct 2022 06:42:30 +0000 (GMT)
X-AuditID: b6c32a4b-5f7fe7000001dc20-13-634661d7d057
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D5.12.14392.6D166436; Wed, 12 Oct 2022 15:42:30 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20221012064229epsmtip279f342b32662a6208301072f5118f851~dPziSoCOW1122711227epsmtip2p;
        Wed, 12 Oct 2022 06:42:29 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Padmanabhan Rajanbabu'" <p.rajanbabu@samsung.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <chanho61.park@samsung.com>, <linus.walleij@linaro.org>,
        <pankaj.dubey@samsung.com>
Cc:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-samsung-soc@vger.kernel.org>
In-Reply-To: <20221011080359.76220-1-p.rajanbabu@samsung.com>
Subject: RE: [PATCH V2] arm64: dts: fix drive strength macros as per FSD HW
 UM
Date:   Wed, 12 Oct 2022 12:12:28 +0530
Message-ID: <013501d8de05$cd3190d0$6794b270$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJk+NbFvx0TMYgY6fQwuHFOTIN1bQKGmwhfrN3kvFA=
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJJsWRmVeSWpSXmKPExsWy7bCmhu71RLdkg5+HBSwu79e2mH/kHKtF
        34uHzBZT/ixnsri8aw6bxYzz+5gsjm4Mtli09Qu7ReveI+wOnB6bVnWyedy5tofNo2/LKkaP
        z5vkAliism0yUhNTUosUUvOS81My89JtlbyD453jTc0MDHUNLS3MlRTyEnNTbZVcfAJ03TJz
        gC5RUihLzCkFCgUkFhcr6dvZFOWXlqQqZOQXl9gqpRak5BSYFOgVJ+YWl+al6+WlllgZGhgY
        mQIVJmRnvHu/hqXgvmXFww2z2RoYrxp0MXJySAiYSBxZPI+ti5GLQ0hgN6NE04l1rBDOJ0aJ
        RyseMoFUCQl8Y5T4v60QpuNo6zwWiKK9jBJv776F6njJKDHz3h52kCo2AV2JHYvbwOaKCJxl
        lFh54jwLSIJZIF3i5OzZYEWcArYSW9fNBVshLBAg8XvOeiCbg4NFQFWiZ4o/iMkrYCnx9RgX
        SAWvgKDEyZlPoKZoSyxb+JoZ4iAFiZ9Pl7GClIsIWEns77OFKBGXeHn0CDvIBRICMzkkLq5+
        yg5R7yKxY94PqF5hiVfHt0DFpSQ+v9vLBjJHQsBDYtEfKYhwhsTb5esZIWx7iQNX5rCAlDAL
        aEqs36UPsYpPovf3EyaITl6JjjYhiGpVieZ3V1kgbGmJid3drDDD/00MnMCoOAvJW7OQvDUL
        yf2zEHYtYGRZxSiZWlCcm55abFpgnJdaDo/r5PzcTYzgNKrlvYPx0YMPeocYmTgYDzFKcDAr
        ifC6hLglC/GmJFZWpRblxxeV5qQWH2I0BYb0RGYp0eR8YCLPK4k3NLE0MDEzMzOxNDYzVBLn
        XTxDK1lIID2xJDU7NbUgtQimj4mDU6qBKSNcvnCL7GmZkFuev9fdVf4f/IOvvjo11aNKvMll
        8yGp454S9eE6Rw8G/hXRSJ1sfy8k0pflRk5fcFKUgXPE16QXfKGzqnVmhr/3nmnxWk/Fzmde
        BtfJ5fdusm1pmq+/6rxlac853v16j9dMyFBof/b51MJdjmn9LqZXXvrENSzb/E9+8e8VcUzt
        nw8HF15gnmUsNseZIa62pjJl9eou/rrmZy+uaT+0f9bjbsX6UJBfITZkTX/e20NBuwSPrCkz
        KpV5eto+eFXgzAlrqpjenwv17X8enPZ/0wZlWwv7jSKv3Czcbx97HrLwXEyUO89Uu1miUsyL
        3gozS+w4OnfXc7Xf7nL1DyqrU39lGmoosRRnJBpqMRcVJwIAD8TwwCwEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplkeLIzCtJLcpLzFFi42LZdlhJXvdaoluywc95BhaX92tbzD9yjtWi
        78VDZospf5YzWVzeNYfNYsb5fUwWRzcGWyza+oXdonXvEXYHTo9NqzrZPO5c28Pm0bdlFaPH
        501yASxRXDYpqTmZZalF+nYJXBntXxeyFBwwr7iy7R1TA+MWvS5GTg4JAROJo63zWLoYuTiE
        BHYzSlya1c8OkZCWuL5xApQtLLHy33N2iKLnjBLHHnxlBUmwCehK7FjcxgaSEBG4yChx7cdc
        sA5mgUyJ7qNHocb2MUoc2DmBGSTBKWArsXXdXCYQW1jAT2J3UxNQEQcHi4CqRM8UfxCTV8BS
        4usxLpAKXgFBiZMzn7BAjNSWeHrzKZy9bOFrZojjFCR+Pl3GCtIqImAlsb/PFqJEXOLl0SPs
        ExiFZyGZNAvJpFlIJs1C0rKAkWUVo2RqQXFuem6xYYFhXmq5XnFibnFpXrpecn7uJkZwTGlp
        7mDcvuqD3iFGJg7GQ4wSHMxKIrwuIW7JQrwpiZVVqUX58UWlOanFhxilOViUxHkvdJ2MFxJI
        TyxJzU5NLUgtgskycXBKNTAtKGTcu6NE/UHMy+2v7A92xJftf2wlcEq3xLqN0c5R6UH64X+C
        BceahJhjPp3bKPsicFuX2c6HPocemSjuyb/g9MbwdrFyWONjmbNzbu/YNOkoc6Z3bOzMTVWF
        bbnZAo9kvBbJzpyufEn2zeNZa5evLf1seDB9f2PsR3dN+zOTv83bmHRYNSePw2d+m9XPoOAb
        Pk9v9bUtOf7dzfUIc/hhu+3JU+auX3WsJeMf3/z1dxgXi+/v8VrBHBqyc1VR+pJfXxYfEVU+
        /fvr7DimN6w9a0MKNXpLg0/xzf3z1noeg8NJ8UPf7IRaWx8cWnXQWbhwSYrizml2u7Yczr58
        7ZH6l7b9Eg6MolUiLxZ9KWO7r8RSnJFoqMVcVJwIAJdn80oYAwAA
X-CMS-MailID: 20221012064230epcas5p1467d63d8a89b648bb314197240158e97
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221011083029epcas5p3cef6047d23d0682a9cb70ba6178067a8
References: <CGME20221011083029epcas5p3cef6047d23d0682a9cb70ba6178067a8@epcas5p3.samsung.com>
        <20221011080359.76220-1-p.rajanbabu@samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>-----Original Message-----
>From: Padmanabhan Rajanbabu =5Bmailto:p.rajanbabu=40samsung.com=5D
>Sent: Tuesday, October 11, 2022 1:34 PM
>To: robh+dt=40kernel.org; krzysztof.kozlowski+dt=40linaro.org;
>alim.akhtar=40samsung.com; chanho61.park=40samsung.com;
>linus.walleij=40linaro.org; pankaj.dubey=40samsung.com
>Cc: devicetree=40vger.kernel.org; linux-kernel=40vger.kernel.org; linux-
>samsung-soc=40vger.kernel.org; Padmanabhan Rajanbabu
><p.rajanbabu=40samsung.com>
>Subject: =5BPATCH V2=5D arm64: dts: fix drive strength macros as per FSD H=
W UM
>
>Drive strength macros defined for FSD platform is not reflecting actual na=
me
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
>HW UM. This also ensures that the existing peripherals in device tree file=
 is
>using correct drive strength MACROs to function as expected.
>
>Fixes: 684dac402f21 (=22arm64: dts: fsd: Add initial pinctrl support=22)
>Signed-off-by: Padmanabhan Rajanbabu <p.rajanbabu=40samsung.com>
>---

Reviewed-by: Alim Akhtar <alim.akhtar=40samsung.com>

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
> =23define FSD_PIN_FUNC_INPUT		0
> =23define FSD_PIN_FUNC_OUTPUT		1
>--
>2.17.1


