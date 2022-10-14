Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD945FE6A7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 03:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbiJNBl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 21:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiJNBly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 21:41:54 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B43219C075
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 18:41:51 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20221014014149epoutp019eaf0df0b16deeb1798bd86d6c8c9d17~dy-llzTFM2903929039epoutp01X
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 01:41:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20221014014149epoutp019eaf0df0b16deeb1798bd86d6c8c9d17~dy-llzTFM2903929039epoutp01X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1665711709;
        bh=jk/1JAp3QIKFLz2QcsfpoxmIaT8j7iS/QoP6PSTPhfk=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=h3HQjD8Glhhi5oY6SIiazIrQzRKP/y4vQn9B9F572c6HJGhRr23KPvxYH8kEM73E1
         R0mvnk10yrO2TNtAyo0hOrpqbdShvk3wkRtd5Jv9QfCl+OKHZ9vRnsNR7uyptfWA82
         OyZkt9AUTE+uTVamPzdQQFblSURkc6Vms8wkufh0=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20221014014148epcas5p177301fe98b2b231a5e059ec453ef4913~dy-kpoeC91522715227epcas5p1H;
        Fri, 14 Oct 2022 01:41:48 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.183]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4MpTdN2D7Nz4x9Q1; Fri, 14 Oct
        2022 01:41:44 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        34.AE.26992.85EB8436; Fri, 14 Oct 2022 10:41:44 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20221014014142epcas5p2af84f65a5091377e3c44ad8573a1c431~dy-fyQYlL0563305633epcas5p2M;
        Fri, 14 Oct 2022 01:41:42 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20221014014142epsmtrp1c4a02d11050f94e7fd9fd04f47881a6b~dy-fxNeBk2981129811epsmtrp1V;
        Fri, 14 Oct 2022 01:41:42 +0000 (GMT)
X-AuditID: b6c32a49-319fb70000016970-7f-6348be58ef72
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        81.DF.14392.65EB8436; Fri, 14 Oct 2022 10:41:42 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20221014014141epsmtip1302684846a1c83dfac83e52bbf8a463b~dy-eaJisS1866718667epsmtip1c;
        Fri, 14 Oct 2022 01:41:41 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Padmanabhan Rajanbabu'" <p.rajanbabu@samsung.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <chanho61.park@samsung.com>, <linus.walleij@linaro.org>,
        <pankaj.dubey@samsung.com>
Cc:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-samsung-soc@vger.kernel.org>
In-Reply-To: <20221013104024.50179-5-p.rajanbabu@samsung.com>
Subject: RE: [PATCH v3 4/4] arm64: dts: fix SPI drive strength values as per
 FSD HW UM
Date:   Fri, 14 Oct 2022 07:11:40 +0530
Message-ID: <000301d8df6e$1c9d0a00$55d71e00$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKobzBT6PrpQ/yNZITJ48yEumYi1gDVelk9AgL9IW+sVzoHQA==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNJsWRmVeSWpSXmKPExsWy7bCmum7EPo9kg6dbuS0u79e2mH/kHKtF
        34uHzBZT/ixnsri8aw6bxYzz+5gsjm4Mtli09Qu7ReveI+wOnB6bVnWyedy5tofNo2/LKkaP
        z5vkAliism0yUhNTUosUUvOS81My89JtlbyD453jTc0MDHUNLS3MlRTyEnNTbZVcfAJ03TJz
        gC5RUihLzCkFCgUkFhcr6dvZFOWXlqQqZOQXl9gqpRak5BSYFOgVJ+YWl+al6+WlllgZGhgY
        mQIVJmRnnDt/m7WgS6iif6FxA+Mx/i5GDg4JAROJ6d9Nuxi5OIQEdjNKPGt6ygLhfGKUePpt
        CTuE841R4kT7ReYuRk6wjmmtn6ASexklLk+cxgzhvGSUmHPlFitIFZuArsSOxW1sIAkRgbOM
        EitPnGcBSTALpEucnD2bHcTmFLCVmPP+O1hcWCBC4vWJSWwgNouAqsSsa8vBbF4BS4njV9+x
        QNiCEidnPoGaoy2xbOFrqJMUJH4+XQa2WETASeL3xwZGiBpxiZdHj4CdKiEwlUOi/9hSVoiv
        XSS2TmaH6BWWeHV8C5QtJfGyv40dosRDYtEfKYhwhsTb5esZIWx7iQNX5rCAlDALaEqs36UP
        sYlPovf3EyaITl6JjjYhiGpVieZ3V1kgbGmJid3drBC2h0TPn8/MExgVZyH5axaSv2YhuX8W
        wrIFjCyrGCVTC4pz01OLTQsM81LL4bGdnJ+7iRGcSrU8dzDeffBB7xAjEwfjIUYJDmYlEV6X
        ELdkId6UxMqq1KL8+KLSnNTiQ4ymwMCeyCwlmpwPTOZ5JfGGJpYGJmZmZiaWxmaGSuK8i2do
        JQsJpCeWpGanphakFsH0MXFwSjUwyfLtvtTBV79hd+G7r+ub01Zf/bfv5J6K5qaQoC8HPNSm
        f/26/uQqmZzlG/VP2KwSfui6bsq1rV0xPZoBHw4eOSXod+5QiMobsz8982c+P/foSc/KsJsK
        DLdl2no9SsQ/nS9u/5D9/l7Dr/X+r+6bTn2oKRl794GQ2Ia/2bULrtiZFrlcehV+rlgqwVpM
        Sksh2LTGq3+LQfoVpT1CJa7nNuvJVhkJrZ17a5+G9vX36vNvWk3YHj9H+m9jZEnO7d+eL0sK
        f6088VVKs35tzNIwNfurfzfXdD34U8F55v1dH92lf46/naC/Xjv5Fq9p45pH/8yck/KLr+eH
        NgUIxBTFyNQZ/XEq9y+LE3l93bWnV4mlOCPRUIu5qDgRAM7RcYEuBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnkeLIzCtJLcpLzFFi42LZdlhJTjdsn0eyweGXhhaX92tbzD9yjtWi
        78VDZospf5YzWVzeNYfNYsb5fUwWRzcGWyza+oXdonXvEXYHTo9NqzrZPO5c28Pm0bdlFaPH
        501yASxRXDYpqTmZZalF+nYJXBnv/scWrBWs+NT+l7mB8TlfFyMnh4SAicS01k/sXYxcHEIC
        uxklvm3exg6RkJa4vnEClC0ssfLfc6ii54wS/3ZOYAVJsAnoSuxY3MYGkhARuMgoce3HXLAO
        ZoFMie6jR1kgOvYzSrx8MoUNJMEpYCsx5/13FhBbWCBM4t+bk2CTWARUJWZdWw5WwytgKXH8
        6jsWCFtQ4uTMJywQQ7Ulnt58CmcvW/iaGeI8BYmfT5eBzRERcJL4/bGBEaJGXOLl0SPsExiF
        ZyEZNQvJqFlIRs1C0rKAkWUVo2RqQXFuem6xYYFhXmq5XnFibnFpXrpecn7uJkZwXGlp7mDc
        vuqD3iFGJg7GQ4wSHMxKIrwuIW7JQrwpiZVVqUX58UWlOanFhxilOViUxHkvdJ2MFxJITyxJ
        zU5NLUgtgskycXBKNTCJr+swnHbPUdiP48+6r1obymRZhMLCk6In7sy7IDVhptsXGaZ/G9pc
        jxx5s8PAeubqOy+0L71VsJD5y7GwXNNG9tGyWf+VA/v6Dm7cWDZvf/Wu/Jy76eWily45cvn/
        WqvE/bv1//qO2g/dQevPsW9PZnycwtGtO+Pvtm+PWfVOtetpblnd+n36t1M6u6Vn/+MK6Z+Z
        +jX2z6MjuewM26/dKP/B9vtW0vdpNnv1jgWenG2RJHW6IXqLlmn6+cbG6vk7PjDN9nWNcN95
        e0th4JK9yUmfd8/O/vd18cErTmWLLZkCg+/qBJ2enHDoqzVLZ+Xh+OqP+vFd3xQ9ZNVvL+KJ
        3ypw2eL2rogN77Znda0TVGIpzkg01GIuKk4EAIihSUwaAwAA
X-CMS-MailID: 20221014014142epcas5p2af84f65a5091377e3c44ad8573a1c431
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221013110733epcas5p36e0104bfa4da37159da77f9231ff6e2c
References: <20221013104024.50179-1-p.rajanbabu@samsung.com>
        <CGME20221013110733epcas5p36e0104bfa4da37159da77f9231ff6e2c@epcas5p3.samsung.com>
        <20221013104024.50179-5-p.rajanbabu@samsung.com>
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
>Subject: =5BPATCH v3 4/4=5D arm64: dts: fix SPI drive strength values as p=
er FSD
>HW UM
>
>Drive strength values used for SPI is not reflecting the default values
>recommended by FSD HW UM.
>
>Fix the drive strength values for SPI, thereby ensuring that the existing =
device
>tree file is using default drive strength values recommended by UM for FSD
>SoC.
>
>Fixes: 684dac402f21 (=22arm64: dts: fsd: Add initial pinctrl support=22)
>Signed-off-by: Padmanabhan Rajanbabu <p.rajanbabu=40samsung.com>
>---

Reviewed-by: Alim Akhtar <alim.akhtar=40samsung.com>

> arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi =7C 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>
>diff --git a/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi
>b/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi
>index a2634e70925a..e3852c946352 100644
>--- a/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi
>+++ b/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi
>=40=40 -323,21 +323,21 =40=40
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
>--
>2.17.1


