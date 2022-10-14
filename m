Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7098A5FE6A4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 03:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbiJNBlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 21:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiJNBlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 21:41:21 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA37A19C050
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 18:41:19 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20221014014118epoutp037a429bd6d20ac77b2681705834874479~dy-IiaDfi1145111451epoutp03I
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 01:41:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20221014014118epoutp037a429bd6d20ac77b2681705834874479~dy-IiaDfi1145111451epoutp03I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1665711678;
        bh=7GCAjE9tjy28HC3OTlNKmEUhB5JdRGWyQsKXuNJmycg=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=QxLRR6Lh60HnN9cQGLjmvPgYT0RuVov49CVrCdBY+O7MbT3FG2/JCOmuGEqt3tshh
         b4y7KhD7H9n3RFqcofmgmOiLdOwdmopHSpd3k/BfCcvPoOyhEsv04rOHdhZg5me2RW
         49k2CJycgLX+5m/kMpF9fXqB8hhYF4rzRlp+Q8k0=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20221014014117epcas5p38069fc4d443cc447b0207e1896976d9d~dy-HnWbng2155621556epcas5p3b;
        Fri, 14 Oct 2022 01:41:17 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.176]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4MpTcp4q01z4x9Q3; Fri, 14 Oct
        2022 01:41:14 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        BF.87.39477.A3EB8436; Fri, 14 Oct 2022 10:41:14 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20221014014113epcas5p3d8c3073dc01c370d48584d5fef8aff42~dy-Em0jEQ2431624316epcas5p3k;
        Fri, 14 Oct 2022 01:41:13 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20221014014113epsmtrp1a2f201b04e0d89ef24c64cd29ff4e2a7~dy-ElF6i-2981729817epsmtrp19;
        Fri, 14 Oct 2022 01:41:13 +0000 (GMT)
X-AuditID: b6c32a4a-007ff70000019a35-a6-6348be3ab1b9
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        D1.36.18644.93EB8436; Fri, 14 Oct 2022 10:41:13 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20221014014112epsmtip277b57441d40ddce332b16b4a865f5efa~dy-DPOOpr0983509835epsmtip2K;
        Fri, 14 Oct 2022 01:41:12 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Padmanabhan Rajanbabu'" <p.rajanbabu@samsung.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <chanho61.park@samsung.com>, <linus.walleij@linaro.org>,
        <pankaj.dubey@samsung.com>
Cc:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-samsung-soc@vger.kernel.org>
In-Reply-To: <20221013104024.50179-4-p.rajanbabu@samsung.com>
Subject: RE: [PATCH v3 3/4] arm64: dts: fix UART drive strength values as
 per FSD HW UM
Date:   Fri, 14 Oct 2022 07:11:11 +0530
Message-ID: <000201d8df6e$0b3c2fc0$21b48f40$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKobzBT6PrpQ/yNZITJ48yEumYi1gJKJz4oASEeVd+sUqMlsA==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLJsWRmVeSWpSXmKPExsWy7bCmlq7VPo9kg+8TVSwu79e2mH/kHKtF
        34uHzBZT/ixnsri8aw6bxYzz+5gsjm4Mtli09Qu7ReveI+wOnB6bVnWyedy5tofNo2/LKkaP
        z5vkAliism0yUhNTUosUUvOS81My89JtlbyD453jTc0MDHUNLS3MlRTyEnNTbZVcfAJ03TJz
        gC5RUihLzCkFCgUkFhcr6dvZFOWXlqQqZOQXl9gqpRak5BSYFOgVJ+YWl+al6+WlllgZGhgY
        mQIVJmRnrH/3krngPX/F748vmBsYb/J2MXJySAiYSEzeuYuli5GLQ0hgN6PEy5Mr2SCcT4wS
        dy6fg3I+M0r8nTifFaZl8cv1UIldjBLbuh+xQjgvGSUWXfjADFLFJqArsWNxG1iViMBZRomV
        J86zgCSYBdIlTs6ezQ5icwrYSsy/cRqsQVggUuLYvptANRwcLAKqEo9nOYKEeQUsJfq6vzND
        2IISJ2c+gRqjLbFs4WtmiIsUJH4+XQZ2nYiAk8TzqccZIWrEJV4ePcIOcoOEwFwOiXVbt7NB
        NLhIbN4+GeodYYlXx7ewQ9hSEi/729hBbpAQ8JBY9EcKIpwh8Xb5ekYI217iwJU5YGcyC2hK
        rN+lD7GKT6L39xMmiE5eiY42IYhqVYnmd1dZIGxpiYnd3VBLPST2z1vCOIFRcRaSx2YheWwW
        kgdmISxbwMiyilEytaA4Nz212LTAKC+1HB7fyfm5mxjB6VTLawfjwwcf9A4xMnEwHmKU4GBW
        EuF1CXFLFuJNSaysSi3Kjy8qzUktPsRoCgzsicxSosn5wISeVxJvaGJpYGJmZmZiaWxmqCTO
        u3iGVrKQQHpiSWp2ampBahFMHxMHp1QDU5bNlnvnJQ4xrPjC49TEtlL5d/WN53Wrpiyp8k0L
        uf/QyvL07W03brXxrFmiduhLtXmYkk++q43IMsbamZU/b8Rq1wYmvHlqfCdv2ZNTCpFcEVdc
        WQ5vzX0ouervTS39Noaf308GJvBUvbmUe+b25veNTp2TUqY+3p+sv2zL0cqkfQeku/l3XFVZ
        2xjDryES8CEufWdXgdueqg0b7lfv7DysYyO9hk+/gEGuiUXCUPzIs2crw3457Ln99vJiaWmV
        X1xBu2QiQzZ4C1+ZvGfvn90iuuFZaXzfI+P7vrTpFKx/vmfRxXsfQ5ocV01bnWbx7q56fNe+
        W766pV5lW9jynl37qTHn66uzAtESznbbfimxFGckGmoxFxUnAgD1aoMzMAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnkeLIzCtJLcpLzFFi42LZdlhJXtdyn0eywaSDGhaX92tbzD9yjtWi
        78VDZospf5YzWVzeNYfNYsb5fUwWRzcGWyza+oXdonXvEXYHTo9NqzrZPO5c28Pm0bdlFaPH
        501yASxRXDYpqTmZZalF+nYJXBn/Hq9gK1jLX7H7y2K2BsbJvF2MnBwSAiYSi1+uZ+ti5OIQ
        EtjBKHH61002iIS0xPWNE9ghbGGJlf+es0MUPWeUuHThMitIgk1AV2LH4jawbhGBi4wS137M
        BetgFsiU6D56lAWiYz+jxNWHd1hAEpwCthLzb5xmBrGFBcIlpj5oB7I5OFgEVCUez3IECfMK
        WEr0dX9nhrAFJU7OfMICMVNb4unNp3D2soWvmSGuU5D4+XQZ2EEiAk4Sz6ceZ4SoEZd4efQI
        +wRG4VlIRs1CMmoWklGzkLQsYGRZxSiZWlCcm55bbFhglJdarlecmFtcmpeul5yfu4kRHFda
        WjsY96z6oHeIkYmD8RCjBAezkgivS4hbshBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHeC10n44UE
        0hNLUrNTUwtSi2CyTBycUg1MgTqWDRd5Bd7KfWZ03DChKdl6tvarv5ybxeMX+mddnm2Y2cU9
        p+D8tcke3RkchiaXt3ZplH9eOVlr+7WmsK9bn7/I/lE/R1TkxZ0t90+sOWT/Zc2ZD95GUybf
        mSrHOv3AhI3TrRdyZtzhEYlW+bBd66Lvp4Wn1j/uqNrRxXciRnKecdNbI+5IrpVfDj9uefzQ
        15K5YUeoWIy/28n6W5s/hcl1Jtc3+Lpf3svZ+VXR8M7XR2o7Q+6WH0nUWS36tn8T09684EPL
        LizhWv922vf+bz2VU+5vaO9nf8kqJujB0vfEW2nRiXOtOx+svyRQEbbL021L5XXpYx0/Hj3M
        tMn5uXpl/+8tSUk9UoeCOM3+eyqxFGckGmoxFxUnAgDOGF4eGgMAAA==
X-CMS-MailID: 20221014014113epcas5p3d8c3073dc01c370d48584d5fef8aff42
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221013110728epcas5p22fb8b83f6cfb4b6a035a9fbb5a38546f
References: <20221013104024.50179-1-p.rajanbabu@samsung.com>
        <CGME20221013110728epcas5p22fb8b83f6cfb4b6a035a9fbb5a38546f@epcas5p2.samsung.com>
        <20221013104024.50179-4-p.rajanbabu@samsung.com>
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
>Subject: =5BPATCH v3 3/4=5D arm64: dts: fix UART drive strength values as =
per FSD
>HW UM
>
>Drive strength values used for UART is not reflecting the default values
>recommended by FSD HW UM.
>
>Fix the drive strength values for UART, thereby ensuring that the existing
>device tree file is using default drive strength values recommended by UM =
for
>FSD SoC.
>
>Fixes: 684dac402f21 (=22arm64: dts: fsd: Add initial pinctrl support=22)
>Signed-off-by: Padmanabhan Rajanbabu <p.rajanbabu=40samsung.com>
>---

Reviewed-by: Alim Akhtar <alim.akhtar=40samsung.com>

> arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi =7C 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi
>b/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi
>index 09a492b1fd6e..a2634e70925a 100644
>--- a/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi
>+++ b/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi
>=40=40 -309,14 +309,14 =40=40
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
>--
>2.17.1


