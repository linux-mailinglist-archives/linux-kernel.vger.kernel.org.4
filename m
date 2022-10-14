Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63E065FEE8C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 15:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbiJNNYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 09:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiJNNYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 09:24:17 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA6F1ABEF4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 06:24:12 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20221014132410epoutp0474dc2172d8eaa127096ac1c30103113f~d8k0To_IZ1585015850epoutp04a
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 13:24:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20221014132410epoutp0474dc2172d8eaa127096ac1c30103113f~d8k0To_IZ1585015850epoutp04a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1665753850;
        bh=yrOuse1uUrQ+ezg3S++UP/Ig12MY3vHjDOvlv7f8hzk=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=FuOF8Jn1ODCIbwLJEvyznzgDeFoQzUr1IjsOsrZnunmqcJc0tJFZuW+esGRDtS34a
         iSfDt8KTumbKFDp7yht15LEm//a1mT41IDmKdJCcR+oHy9l0w6BJ/JhCby8dQcLGXY
         58EKWa9fqUgohKwoejtLC4YbsIlvuduHal8y20AU=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20221014132409epcas5p2c0fbdfdb5df2772baecbb2f28aed29ed~d8kztFSwi2551225512epcas5p2A;
        Fri, 14 Oct 2022 13:24:09 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.179]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4MpnCp3Dpgz4x9Pt; Fri, 14 Oct
        2022 13:24:06 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        86.FB.39477.6F269436; Fri, 14 Oct 2022 22:24:06 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20221014132405epcas5p307221ed06f17f2c5773726611fd627fe~d8kwgzyfK2888628886epcas5p3W;
        Fri, 14 Oct 2022 13:24:05 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20221014132405epsmtrp17dd1e064b39e2c506f7b940eba1f3f8e~d8kwfqxo92627326273epsmtrp1e;
        Fri, 14 Oct 2022 13:24:05 +0000 (GMT)
X-AuditID: b6c32a4a-007ff70000019a35-32-634962f68e6d
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        F1.82.18644.5F269436; Fri, 14 Oct 2022 22:24:05 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20221014132403epsmtip11ed64f79d840cf37673db40038970179~d8kuZpC6q2986329863epsmtip1C;
        Fri, 14 Oct 2022 13:24:03 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Padmanabhan Rajanbabu'" <p.rajanbabu@samsung.com>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <s.nawrocki@samsung.com>,
        <perex@perex.cz>, <tiwai@suse.com>, <pankaj.dubey@samsung.com>,
        <rcsekar@samsung.com>, <aswani.reddy@samsung.com>
Cc:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-samsung-soc@vger.kernel.org>
In-Reply-To: <20221014102151.108539-6-p.rajanbabu@samsung.com>
Subject: RE: [PATCH 5/6] arm64: dts: fsd: Add I2S DAI node for Tesla FSD
Date:   Fri, 14 Oct 2022 18:54:02 +0530
Message-ID: <00c201d8dfd0$3bc6b720$b3542560$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKFI9qd/qMOsyXBjKz4d8Q6MS4QvwIMhU34AXuYdz+smRZmYA==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHJsWRmVeSWpSXmKPExsWy7bCmuu63JM9kg01vhCyuXDzEZHFo81Z2
        i6kPn7BZzD9yjtWi78VDZotvVzqYLC7vmsNmMeP8PiaLoxuDLRZt/cJu0bmrn9Vi1oUdrBat
        e4+wWxx+085qseH7WkYHfo8Nn5vYPHbOusvusWlVJ5vHnWt72Dz2vV3G5tG3ZRWjx/otV1k8
        Pm+SC+CIyrbJSE1MSS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQwV1LIS8xNtVVy8QnQdcvM
        ATpeSaEsMacUKBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQklNgUqBXnJhbXJqXrpeXWmJlaGBg
        ZApUmJCdse7Na/aCpwoVvfNnsTYwTpDuYuTkkBAwkVh14j17FyMXh5DAbkaJeUc/M0E4nxgl
        ZvbuYgKpEhL4zCixs60EpmPp3EZWiKJdjBJPpz+D6njJKLH3y19mkCo2AV2JHYvb2EBsEYEt
        TBJ7N8WAFDELtAEVXVzL2MXIwcEpYCfRsK8UpEZYwEOi6c9eVpAwi4CqxNcT/iBhXgFLic0v
        r7NA2IISJ2c+AbOZBeQltr+dwwxxkILEz6fLWCFWOUlMfvKVGaJGXOLl0SNgr0kIvOCQ2H/t
        PjtEg4vEzwn7oZqFJV4d3wIVl5J42d/GDnKDBNA9i/5IQYQzJN4uX88IYdtLHLgyhwWkhFlA
        U2L9Ln2IVXwSvb+fMEF08kp0tAlBVKtKNL+7ygJhS0tM7O5mhbA9JOZuW8Y+gVFxFpLHZiF5
        bBaSB2YhLFvAyLKKUTK1oDg3PbXYtMAoL7UcHtvJ+bmbGMEJW8trB+PDBx/0DjEycTAeYpTg
        YFYS4X2t5JksxJuSWFmVWpQfX1Sak1p8iNEUGNgTmaVEk/OBOSOvJN7QxNLAxMzMzMTS2MxQ
        SZx38QytZCGB9MSS1OzU1ILUIpg+Jg5OqQambTELVet/7gm/fOVkuZWb42/b2IA1jxe/Om32
        LSpscuc8D7+390/HH7XPzT23SVVkfrK72jmd0wz353hwXW1s2CPPVX3r7sa/dm767FtmNP/K
        j9BquD6x/vsq81WfGNZMPPAyNNDd8lF4nEDZjktLgyvuaO60Z83T7g/czhOcLrfkGveZB3um
        bzj1kzVP2v75opQLQduntnJV8k6elPD/4uevh5n7ZJ8fi11wxCm9al21u4Y058+kr1cZv+jx
        ldyI/DPnyO7l+wNLZzv09bP+DV7bcSQ+/7zCPl+9d4ti3NQLFvm90XE/Zznz9JH7a9kXqgsq
        lN7YPMNd6TbH1DnPnu51SRIy2MLE78ht5xOdrcRSnJFoqMVcVJwIABXfGUthBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFIsWRmVeSWpSXmKPExsWy7bCSnO7XJM9kg/WHDCyuXDzEZHFo81Z2
        i6kPn7BZzD9yjtWi78VDZotvVzqYLC7vmsNmMeP8PiaLoxuDLRZt/cJu0bmrn9Vi1oUdrBat
        e4+wWxx+085qseH7WkYHfo8Nn5vYPHbOusvusWlVJ5vHnWt72Dz2vV3G5tG3ZRWjx/otV1k8
        Pm+SC+CI4rJJSc3JLEst0rdL4MpY9+Y1e8FThYre+bNYGxgnSHcxcnJICJhILJ3byNrFyMUh
        JLCDUeLW8TcsEAlpiesbJ7BD2MISK/89Z4coes4ocarvJ1gRm4CuxI7FbWwgCRGBA0wSHb83
        gI1iFuhilDj+dyUzRMtBRokvx/cDZTg4OAXsJBr2lYJ0Cwt4SDT92QsWZhFQlfh6wh8kzCtg
        KbH55XUWCFtQ4uTMJ2A2s4C2RO/DVkYIW15i+9s5zBDXKUj8fLqMFcQWEXCSmPzkKzNEjbjE
        y6NH2CcwCs9CMmoWklGzkIyahaRlASPLKkbJ1ILi3PTcYsMCo7zUcr3ixNzi0rx0veT83E2M
        4OjV0trBuGfVB71DjEwcjIcYJTiYlUR4Xyt5JgvxpiRWVqUW5ccXleakFh9ilOZgURLnvdB1
        Ml5IID2xJDU7NbUgtQgmy8TBKdXAlK7Irjv96f9dwq+dzCI4tRqmy79JMa57LLQmcqesCL/r
        roAor4oQm5kXX+9/ffN0Cv+hvwLfe2Z/j7fZ9CJpvVIf54FnqrtmWQb/7O991/ew7mRH5scq
        ztilrnVrXJI5+7niOFoDDWe78/xItVRft/15lPzeHoPy3e1TvuZdKfFikT8pJbBgSeH0I2es
        YxstUp5yLFs86f3LmWKXVzLrVVeXvc+quWHp2bFmUmpo8qQYz6gr5osLXxoriGtE1d9p/lLe
        bn+idDZvTOfB/yu+GLY4Hovwc7tSXWiWFL53gb7Nqlp16RDV92ElNz5McTH/OX/aZr3Uvff1
        Z6YLnL3+ev+i5WGbVunqirt77vFRYinOSDTUYi4qTgQAmI2UPk0DAAA=
X-CMS-MailID: 20221014132405epcas5p307221ed06f17f2c5773726611fd627fe
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221014104911epcas5p394100ff6ed53be32c4d64c7e23e48833
References: <20221014102151.108539-1-p.rajanbabu@samsung.com>
        <CGME20221014104911epcas5p394100ff6ed53be32c4d64c7e23e48833@epcas5p3.samsung.com>
        <20221014102151.108539-6-p.rajanbabu@samsung.com>
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
>From: Padmanabhan Rajanbabu [mailto:p.rajanbabu@samsung.com]
>Sent: Friday, October 14, 2022 3:52 PM
>To: lgirdwood@gmail.com; broonie@kernel.org; robh+dt@kernel.org;
>krzysztof.kozlowski+dt@linaro.org; s.nawrocki@samsung.com;
>perex@perex.cz; tiwai@suse.com; pankaj.dubey@samsung.com;
>alim.akhtar@samsung.com; rcsekar@samsung.com;
>aswani.reddy@samsung.com
>Cc: alsa-devel@alsa-project.org; devicetree@vger.kernel.org; linux-
>kernel@vger.kernel.org; linux-samsung-soc@vger.kernel.org; Padmanabhan
>Rajanbabu <p.rajanbabu@samsung.com>
>Subject: [PATCH 5/6] arm64: dts: fsd: Add I2S DAI node for Tesla FSD
>
>Add device tree node for I2S0 and I2S1 CPU DAI instances for Tesla FSD board
>
>Signed-off-by: Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
>---
> arch/arm64/boot/dts/tesla/fsd-evb.dts      |  8 +++++
> arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi | 14 ++++++++
> arch/arm64/boot/dts/tesla/fsd.dtsi         | 38 ++++++++++++++++++++++
> 3 files changed, 60 insertions(+)
>
>diff --git a/arch/arm64/boot/dts/tesla/fsd-evb.dts
>b/arch/arm64/boot/dts/tesla/fsd-evb.dts
>index 1db6ddf03f01..c0a4509499ab 100644
>--- a/arch/arm64/boot/dts/tesla/fsd-evb.dts
>+++ b/arch/arm64/boot/dts/tesla/fsd-evb.dts
>@@ -41,3 +41,11 @@
> &ufs {
> 	status = "okay";
> };
>+
>+&tdm_0 {
>+	status = "okay";
>+};
>+
>+&tdm_1 {
>+	status = "okay";
>+};
>diff --git a/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi
>b/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi
>index e3852c946352..ff6f5d4b16dd 100644
>--- a/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi
>+++ b/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi
>@@ -339,6 +339,20 @@
> 		samsung,pin-pud = <FSD_PIN_PULL_UP>;
> 		samsung,pin-drv = <FSD_PIN_DRV_LV4>;
> 	};
>+
>+	i2s0_bus: i2s0-bus {
>+		samsung,pins = "gpd1-0", "gpd1-1", "gpd1-2", "gpd1-3",
>"gpd1-4";
>+		samsung,pin-function = <FSD_PIN_FUNC_2>;
>+		samsung,pin-pud = <FSD_PIN_PULL_DOWN>;
>+		samsung,pin-drv = <FSD_PIN_DRV_LV4>;
>+	};
>+
>+	i2s1_bus: i2s1-bus {
>+		samsung,pins = "gpd2-0", "gpd2-1", "gpd2-2", "gpd2-3",
>"gpd2-4";
>+		samsung,pin-function = <FSD_PIN_FUNC_2>;
>+		samsung,pin-pud = <FSD_PIN_PULL_DOWN>;
>+		samsung,pin-drv = <FSD_PIN_DRV_LV4>;
>+	};
> };
>
> &pinctrl_pmu {
>diff --git a/arch/arm64/boot/dts/tesla/fsd.dtsi
>b/arch/arm64/boot/dts/tesla/fsd.dtsi
>index f35bc5a288c2..5decad45a1b6 100644
>--- a/arch/arm64/boot/dts/tesla/fsd.dtsi
>+++ b/arch/arm64/boot/dts/tesla/fsd.dtsi
>@@ -32,6 +32,8 @@
> 		spi0 = &spi_0;
> 		spi1 = &spi_1;
> 		spi2 = &spi_2;
>+		tdm0 = &tdm_0;
>+		tdm1 = &tdm_1;
> 	};
>
> 	cpus {
>@@ -809,6 +811,42 @@
> 			status = "disabled";
> 		};
>
>+		tdm_0: tdm@140e0000 {
>+			compatible = "samsung,exynos7-i2s";
>+			reg = <0x0 0x140E0000 0x0 0x100>;
Address should be all in small caps
Make sure you have run 'make dtbs_check' 

>+			interrupts = <GIC_SPI 206 IRQ_TYPE_LEVEL_HIGH>;
>+			dmas = <&pdma1 14>, <&pdma1 13>, <&pdma1 12>;
>+			dma-names = "tx", "rx", "tx-sec";
>+			#clock-cells = <1>;
>+			#sound-dai-cells = <1>;
>+			clocks = <&clock_peric PERIC_HCLK_TDM0>,
>+				 <&clock_peric PERIC_HCLK_TDM0>,
>+				 <&clock_peric PERIC_PCLK_TDM0>;
>+			clock-names = "i2s_opclk0", "i2s_opclk1", "iis";
>+			pinctrl-names = "default";
>+			pinctrl-0 = <&i2s0_bus>;
>+			samsung,sec-dai-id = <0>;
>+			status = "disabled";
>+		};
>+
>+		tdm_1: tdm@140f0000 {
>+			compatible = "samsung,exynos7-i2s";
>+			reg = <0x0 0x140F0000 0x0 0x100>;
Same as above

>+			interrupts = <GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH>;
>+			dmas = <&pdma1 17>, <&pdma1 16>, <&pdma1 15>;
>+			dma-names = "tx", "rx", "tx-sec";
>+			#clock-cells = <1>;
>+			#sound-dai-cells = <1>;
>+			clocks = <&clock_peric PERIC_HCLK_TDM1>,
>+				 <&clock_peric PERIC_HCLK_TDM1>,
>+				 <&clock_peric PERIC_PCLK_TDM1>;
>+			clock-names = "i2s_opclk0", "i2s_opclk1", "iis";
>+			pinctrl-names = "default";
>+			pinctrl-0 = <&i2s1_bus>;
>+			samsung,sec-dai-id = <1>;
>+			status = "disabled";
>+		};
>+
> 		timer@10040000 {
> 			compatible = "tesla,fsd-mct", "samsung,exynos4210-
>mct";
> 			reg = <0x0 0x10040000 0x0 0x800>;
>--
>2.17.1


