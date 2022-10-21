Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60D87607202
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 10:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbiJUIU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 04:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbiJUIUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 04:20:48 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43452F88C5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 01:20:35 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20221021082033epoutp023d8f6c556d700c62d11cd901478fa571~gB8vBtO821244412444epoutp02U
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 08:20:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20221021082033epoutp023d8f6c556d700c62d11cd901478fa571~gB8vBtO821244412444epoutp02U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1666340433;
        bh=NEmzyG40D6V67T9OdqDwh31QW7XcUcQomgyp6OulFoY=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=HemcUWofVlayCc5XaKGPtGDQZa436H8EXcexzbY3NHaLCHDIQr5LTG5Xf/a9A0Fcr
         SIi6qDR/aGx9Z7i7roRsCoBAZBLn82dr3FnoRbP4YmZSnLTVta7xKlvsXCb5UPTyok
         oMOwGo+/IAFnBPkOIy2V6pd0AB1AuW1QgyKTnYbk=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20221021082033epcas5p1d08f78d69db768c702d87acb10c265dc~gB8uXkI-k0512605126epcas5p1W;
        Fri, 21 Oct 2022 08:20:33 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.181]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4Mty8G3FqVz4x9Px; Fri, 21 Oct
        2022 08:20:30 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        AA.B2.39477.E4652536; Fri, 21 Oct 2022 17:20:30 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20221021081000epcas5p250ed19d2d5d5f8aaab16e58efa6ba55a~gBzhiSuh-3190231902epcas5p2M;
        Fri, 21 Oct 2022 08:10:00 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20221021081000epsmtrp1f856df0695d9733021717151e5022ce9~gBzhhHnwz0171601716epsmtrp1-;
        Fri, 21 Oct 2022 08:10:00 +0000 (GMT)
X-AuditID: b6c32a4a-259fb70000019a35-34-6352564e2bc2
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        CB.E6.14392.8D352536; Fri, 21 Oct 2022 17:10:00 +0900 (KST)
Received: from FDSFTE070 (unknown [107.116.189.86]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20221021080958epsmtip1e96578caf7d275b8408bc4b9fe2fffa8~gBzferLqN0838308383epsmtip1W;
        Fri, 21 Oct 2022 08:09:58 +0000 (GMT)
From:   "Padmanabhan Rajanbabu" <p.rajanbabu@samsung.com>
To:     "'Alim Akhtar'" <alim.akhtar@samsung.com>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <s.nawrocki@samsung.com>,
        <perex@perex.cz>, <tiwai@suse.com>, <pankaj.dubey@samsung.com>,
        <rcsekar@samsung.com>, <aswani.reddy@samsung.com>
Cc:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-samsung-soc@vger.kernel.org>
In-Reply-To: <00c201d8dfd0$3bc6b720$b3542560$@samsung.com>
Subject: RE: [PATCH 5/6] arm64: dts: fsd: Add I2S DAI node for Tesla FSD
Date:   Fri, 21 Oct 2022 13:39:57 +0530
Message-ID: <04a901d8e524$841bd6f0$8c5384d0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKFI9qd/qMOsyXBjKz4d8Q6MS4QvwIMhU34AXuYdz8CKOxuxaySeNqQ
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCJsWRmVeSWpSXmKPExsWy7bCmhq5fWFCywcL7bBYP5m1js7hy8RCT
        xaHNW9ktpj58wmYx/8g5Vou+Fw+ZLb5d6WCyuLxrDpvFjPP7mCwWbf3CbtG5q5/VYtaFHawW
        rXuPsFscftPOarHh+1pGB36PDZ+b2Dx2zrrL7rFpVSebx51re9g89r1dxubRt2UVo8f6LVdZ
        PD5vkgvgiMq2yUhNTEktUkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXL
        zAG6XkmhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYFKgV5yYW1yal66Xl1piZWhg
        YGQKVJiQnXH4wlL2gp/qFY3nnzM3MJ5U6GLk5JAQMJG4vPcYYxcjF4eQwG5GiR//FrFAOJ8Y
        JQ5c/c0O4XxjlPg6YxUzTEvXkS2sEIm9jBJdP2dBtbwAqvrYxAJSxSZgLrFo71KwwSICq5gk
        5vWtAatiFmhjlNh7cS0jSBWngJXEpFffWUFsYQEPiaY/e8FsFgFViSszJoBN4hWwlDgw/Ssz
        hC0ocXLmE7A4s4C8xPa3c6BuUpD4+XQZUC8H0DY3if07hSBKxCWO/uxhBtkrIfCGQ2La0xXs
        EPUuEh1f3zNC2MISr45vgYpLSbzsb4Oy8yWmfWxmg7ArJNo+bmCCsO0lDlyZwwKyi1lAU2L9
        Ln2IsKzE1FPrmCD28kn0/n4CVc4rsWMejK0qsX75Jqi10hL7ru9lnMCoNAvJZ7OQfDYLyQuz
        ELYtYGRZxSiZWlCcm55abFpglJdaDo/y5PzcTYzg5K3ltYPx4YMPeocYmTgYDzFKcDArifAW
        vAtIFuJNSaysSi3Kjy8qzUktPsRoCgzuicxSosn5wPyRVxJvaGJpYGJmZmZiaWxmqCTOu3iG
        VrKQQHpiSWp2ampBahFMHxMHp1QDk6mmxBfPUMY+3ZBdsxfwvhH+//wW95Q5nBNS7z6Y8M2v
        bZWVfoDxF+PGcr6dibu3fWHJ5668nWk9yYIxdRH/6T2yhivrGUxkXXWfhATt4OTr1trHfidj
        Imt+b//jjVU5r3TFH+1T3lHhwln47afV//dzihz2TwoynFrLzLmwyZb9fF+TVqBeqIHu9KXx
        bzkNzsvLHZix0uacf+tXWY9zWQte3D7Z4LrANfed75Vuj0J2O6+pKu0OcQbbg/wcb9Tve2+p
        KnFw4yrvuB+Wt9xs41TnHnJ44beEe2JX+8L0zu9LJjyvvLKnrPvVAlfFW67av4w7tY6+ldEJ
        PhjCuWvbLYl5O66eubj9SqbcLv/pSizFGYmGWsxFxYkAAa5D3GcEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNIsWRmVeSWpSXmKPExsWy7bCSnO6N4KBkgw/HDSwezNvGZnHl4iEm
        i0Obt7JbTH34hM1i/pFzrBZ9Lx4yW3y70sFkcXnXHDaLGef3MVks2vqF3aJzVz+rxawLO1gt
        WvceYbc4/Kad1WLD97WMDvweGz43sXnsnHWX3WPTqk42jzvX9rB57Hu7jM2jb8sqRo/1W66y
        eHzeJBfAEcVlk5Kak1mWWqRvl8CVcfjCUvaCn+oVjeefMzcwnlToYuTkkBAwkeg6soUVxBYS
        2M0oMa9BCSIuLTG9fw8bhC0ssfLfc/YuRi6gmmeMEsc3/GcCSbAJmEss2ruUESQhIrCNSeLX
        gR1gVcwCXUBVf1cyQ7S8Z5R4uvkwO0gLp4CVxKRX38H2CQt4SDT92QtmswioSlyZMYEFxOYV
        sJQ4MP0rM4QtKHFy5hOwOLOAtkTvw1ZGCFteYvvbOcwQ9ylI/Hy6DGgOB9AZbhL7dwpBlIhL
        HP3ZwzyBUXgWkkmzkEyahWTSLCQtCxhZVjFKphYU56bnFhsWGOallusVJ+YWl+al6yXn525i
        BMevluYOxu2rPugdYmTiYDzEKMHBrCTCW/AuIFmINyWxsiq1KD++qDQntfgQozQHi5I474Wu
        k/FCAumJJanZqakFqUUwWSYOTqkGJmXxIxl/psW5tjIxrzoi2lzPOX/L9iWzFI/eSBKy/urx
        ybBs2b2LpV/F+3Z/8F7PMFVj5+Q5NtEOxst+J4S93mrwiaHIXl4gcUqF0JGfOTeWFNUdvi7z
        p+lz5g/Vtvt3mAO6ftm+FeDt0Xlht5u11vP4Zekq/S9fixebrlaNm2o65VbFlmXZXu5xTtX+
        qZUv58x8w7uAu/eNyea34ZdO7qnSOPWnYFKCf0ZfQ7IKk5H8U7mIo6fOPxNhqwx4qM5hf3Pd
        kxvu4rf3vp4QFSt20WZDnVaz3C7u8lj97e+ups9fdWPai6TCgNtN4ee2XLvQeo93gYhJdt70
        J0dF5jfELgrYcHzt+Sj26us1+w7NOa7EUpyRaKjFXFScCABWRnPATgMAAA==
X-CMS-MailID: 20221021081000epcas5p250ed19d2d5d5f8aaab16e58efa6ba55a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221014104911epcas5p394100ff6ed53be32c4d64c7e23e48833
References: <20221014102151.108539-1-p.rajanbabu@samsung.com>
        <CGME20221014104911epcas5p394100ff6ed53be32c4d64c7e23e48833@epcas5p3.samsung.com>
        <20221014102151.108539-6-p.rajanbabu@samsung.com>
        <00c201d8dfd0$3bc6b720$b3542560$@samsung.com>
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Alim Akhtar [mailto:alim.akhtar@samsung.com]
> Sent: 14 October 2022 06:54 PM
> To: 'Padmanabhan Rajanbabu' <p.rajanbabu@samsung.com>;
> lgirdwood@gmail.com; broonie@kernel.org; robh+dt@kernel.org;
> krzysztof.kozlowski+dt@linaro.org; s.nawrocki@samsung.com;
> perex@perex.cz; tiwai@suse.com; pankaj.dubey@samsung.com;
> rcsekar@samsung.com; aswani.reddy@samsung.com
> Cc: alsa-devel@alsa-project.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-samsung-soc@vger.kernel.org
> Subject: RE: [PATCH 5/6] arm64: dts: fsd: Add I2S DAI node for Tesla FSD
> 
> 
> 
> >-----Original Message-----
> >From: Padmanabhan Rajanbabu [mailto:p.rajanbabu@samsung.com]
> >Sent: Friday, October 14, 2022 3:52 PM
> >To: lgirdwood@gmail.com; broonie@kernel.org; robh+dt@kernel.org;
> >krzysztof.kozlowski+dt@linaro.org; s.nawrocki@samsung.com;
> >perex@perex.cz; tiwai@suse.com; pankaj.dubey@samsung.com;
> >alim.akhtar@samsung.com; rcsekar@samsung.com;
> aswani.reddy@samsung.com
> >Cc: alsa-devel@alsa-project.org; devicetree@vger.kernel.org; linux-
> >kernel@vger.kernel.org; linux-samsung-soc@vger.kernel.org;
> Padmanabhan
> >Rajanbabu <p.rajanbabu@samsung.com>
> >Subject: [PATCH 5/6] arm64: dts: fsd: Add I2S DAI node for Tesla FSD
> >
> >Add device tree node for I2S0 and I2S1 CPU DAI instances for Tesla FSD
> >board
> >
> >Signed-off-by: Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
> >---
> > arch/arm64/boot/dts/tesla/fsd-evb.dts      |  8 +++++
> > arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi | 14 ++++++++
> > arch/arm64/boot/dts/tesla/fsd.dtsi         | 38 ++++++++++++++++++++++
> > 3 files changed, 60 insertions(+)
> >
> >diff --git a/arch/arm64/boot/dts/tesla/fsd-evb.dts
> >b/arch/arm64/boot/dts/tesla/fsd-evb.dts
> >index 1db6ddf03f01..c0a4509499ab 100644
> >--- a/arch/arm64/boot/dts/tesla/fsd-evb.dts
> >+++ b/arch/arm64/boot/dts/tesla/fsd-evb.dts
> >@@ -41,3 +41,11 @@
> > &ufs {
> > 	status = "okay";
> > };
> >+
> >+&tdm_0 {
> >+	status = "okay";
> >+};
> >+
> >+&tdm_1 {
> >+	status = "okay";
> >+};
> >diff --git a/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi
> >b/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi
> >index e3852c946352..ff6f5d4b16dd 100644
> >--- a/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi
> >+++ b/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi
> >@@ -339,6 +339,20 @@
> > 		samsung,pin-pud = <FSD_PIN_PULL_UP>;
> > 		samsung,pin-drv = <FSD_PIN_DRV_LV4>;
> > 	};
> >+
> >+	i2s0_bus: i2s0-bus {
> >+		samsung,pins = "gpd1-0", "gpd1-1", "gpd1-2", "gpd1-3",
> >"gpd1-4";
> >+		samsung,pin-function = <FSD_PIN_FUNC_2>;
> >+		samsung,pin-pud = <FSD_PIN_PULL_DOWN>;
> >+		samsung,pin-drv = <FSD_PIN_DRV_LV4>;
> >+	};
> >+
> >+	i2s1_bus: i2s1-bus {
> >+		samsung,pins = "gpd2-0", "gpd2-1", "gpd2-2", "gpd2-3",
> >"gpd2-4";
> >+		samsung,pin-function = <FSD_PIN_FUNC_2>;
> >+		samsung,pin-pud = <FSD_PIN_PULL_DOWN>;
> >+		samsung,pin-drv = <FSD_PIN_DRV_LV4>;
> >+	};
> > };
> >
> > &pinctrl_pmu {
> >diff --git a/arch/arm64/boot/dts/tesla/fsd.dtsi
> >b/arch/arm64/boot/dts/tesla/fsd.dtsi
> >index f35bc5a288c2..5decad45a1b6 100644
> >--- a/arch/arm64/boot/dts/tesla/fsd.dtsi
> >+++ b/arch/arm64/boot/dts/tesla/fsd.dtsi
> >@@ -32,6 +32,8 @@
> > 		spi0 = &spi_0;
> > 		spi1 = &spi_1;
> > 		spi2 = &spi_2;
> >+		tdm0 = &tdm_0;
> >+		tdm1 = &tdm_1;
> > 	};
> >
> > 	cpus {
> >@@ -809,6 +811,42 @@
> > 			status = "disabled";
> > 		};
> >
> >+		tdm_0: tdm@140e0000 {
> >+			compatible = "samsung,exynos7-i2s";
> >+			reg = <0x0 0x140E0000 0x0 0x100>;
> Address should be all in small caps
> Make sure you have run 'make dtbs_check'
Okay
> 
> >+			interrupts = <GIC_SPI 206 IRQ_TYPE_LEVEL_HIGH>;
> >+			dmas = <&pdma1 14>, <&pdma1 13>, <&pdma1 12>;
> >+			dma-names = "tx", "rx", "tx-sec";
> >+			#clock-cells = <1>;
> >+			#sound-dai-cells = <1>;
> >+			clocks = <&clock_peric PERIC_HCLK_TDM0>,
> >+				 <&clock_peric PERIC_HCLK_TDM0>,
> >+				 <&clock_peric PERIC_PCLK_TDM0>;
> >+			clock-names = "i2s_opclk0", "i2s_opclk1", "iis";
> >+			pinctrl-names = "default";
> >+			pinctrl-0 = <&i2s0_bus>;
> >+			samsung,sec-dai-id = <0>;
> >+			status = "disabled";
> >+		};
> >+
> >+		tdm_1: tdm@140f0000 {
> >+			compatible = "samsung,exynos7-i2s";
> >+			reg = <0x0 0x140F0000 0x0 0x100>;
> Same as above
Okay
> 
> >+			interrupts = <GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH>;
> >+			dmas = <&pdma1 17>, <&pdma1 16>, <&pdma1 15>;
> >+			dma-names = "tx", "rx", "tx-sec";
> >+			#clock-cells = <1>;
> >+			#sound-dai-cells = <1>;
> >+			clocks = <&clock_peric PERIC_HCLK_TDM1>,
> >+				 <&clock_peric PERIC_HCLK_TDM1>,
> >+				 <&clock_peric PERIC_PCLK_TDM1>;
> >+			clock-names = "i2s_opclk0", "i2s_opclk1", "iis";
> >+			pinctrl-names = "default";
> >+			pinctrl-0 = <&i2s1_bus>;
> >+			samsung,sec-dai-id = <1>;
> >+			status = "disabled";
> >+		};
> >+
> > 		timer@10040000 {
> > 			compatible = "tesla,fsd-mct", "samsung,exynos4210-
> mct";
> > 			reg = <0x0 0x10040000 0x0 0x800>;
> >--
> >2.17.1
> 


