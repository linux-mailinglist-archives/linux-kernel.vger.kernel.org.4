Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4576C2ADC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 07:55:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbjCUGzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 02:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbjCUGzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 02:55:05 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F15AD2F;
        Mon, 20 Mar 2023 23:55:03 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32L6suvN069928;
        Tue, 21 Mar 2023 01:54:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1679381696;
        bh=vh9bxu0G3DnVYUFcXgl/1jVScKuNjH1dp3xz6scAKvs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=lBkryeyYCJhaXigQ+KodvCY56YwmM8fN3VoCNYiN+ESAgcPXuLBEPO5HTFzTbpjWf
         bKE48nLkFDJkByUfnTbY25nWFzPOZDgUxj1LcEY742T0Hex6yCPbIAMwZ1bH49rvi9
         wpwcf+9w5JrR3k3bmUOMh5QxAHKddBcXZ6vpexZI=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32L6subF016593
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 21 Mar 2023 01:54:56 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 21
 Mar 2023 01:54:56 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 21 Mar 2023 01:54:56 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32L6st3M000989;
        Tue, 21 Mar 2023 01:54:55 -0500
From:   Vaishnav Achath <vaishnav.a@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <j-keerthy@ti.com>, <u-kumar1@ti.com>, <j-luthra@ti.com>,
        <vaishnav.a@ti.com>
Subject: [PATCH v2 4/4] arm64: dts: ti: k3-j784s4: Add MCSPI nodes
Date:   Tue, 21 Mar 2023 12:24:47 +0530
Message-ID: <20230321065447.6997-5-vaishnav.a@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230321065447.6997-1-vaishnav.a@ti.com>
References: <20230321065447.6997-1-vaishnav.a@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

J784S4 has 8 MCSPI instances in the main domain and 3 instances
in the MCU domain. Add the DT nodes for all the 11 instances and
keep them disabled.

Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
---

V1->V2: 
  * Combine main, mcu domain, MCSPI node addition changes
  to single commit.

 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi    | 88 +++++++++++++++++++
 .../boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi     | 33 +++++++
 2 files changed, 121 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
index 80a1b08c51a8..432592ef3bc4 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
@@ -1005,4 +1005,92 @@
 		bosch,mram-cfg = <0x00 128 64 64 64 64 32 32>;
 		status = "disabled";
 	};
+
+	main_spi0: spi@2100000 {
+		compatible = "ti,am654-mcspi","ti,omap4-mcspi";
+		reg = <0x00 0x02100000 0x00 0x400>;
+		interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		power-domains = <&k3_pds 376 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 376 1>;
+		status = "disabled";
+	};
+
+	main_spi1: spi@2110000 {
+		compatible = "ti,am654-mcspi","ti,omap4-mcspi";
+		reg = <0x00 0x02110000 0x00 0x400>;
+		interrupts = <GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		power-domains = <&k3_pds 377 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 377 1>;
+		status = "disabled";
+	};
+
+	main_spi2: spi@2120000 {
+		compatible = "ti,am654-mcspi","ti,omap4-mcspi";
+		reg = <0x00 0x02120000 0x00 0x400>;
+		interrupts = <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		power-domains = <&k3_pds 378 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 378 1>;
+		status = "disabled";
+	};
+
+	main_spi3: spi@2130000 {
+		compatible = "ti,am654-mcspi","ti,omap4-mcspi";
+		reg = <0x00 0x02130000 0x00 0x400>;
+		interrupts = <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		power-domains = <&k3_pds 379 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 379 1>;
+		status = "disabled";
+	};
+
+	main_spi4: spi@2140000 {
+		compatible = "ti,am654-mcspi","ti,omap4-mcspi";
+		reg = <0x00 0x02140000 0x00 0x400>;
+		interrupts = <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		power-domains = <&k3_pds 380 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 380 1>;
+		status = "disabled";
+	};
+
+	main_spi5: spi@2150000 {
+		compatible = "ti,am654-mcspi","ti,omap4-mcspi";
+		reg = <0x00 0x02150000 0x00 0x400>;
+		interrupts = <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		power-domains = <&k3_pds 381 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 381 1>;
+		status = "disabled";
+	};
+
+	main_spi6: spi@2160000 {
+		compatible = "ti,am654-mcspi","ti,omap4-mcspi";
+		reg = <0x00 0x02160000 0x00 0x400>;
+		interrupts = <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		power-domains = <&k3_pds 382 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 382 1>;
+		status = "disabled";
+	};
+
+	main_spi7: spi@2170000 {
+		compatible = "ti,am654-mcspi","ti,omap4-mcspi";
+		reg = <0x00 0x02170000 0x00 0x400>;
+		interrupts = <GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		power-domains = <&k3_pds 383 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 383 1>;
+		status = "disabled";
+	};
 };
diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
index 64bd3dee14aa..f04fcb614cbe 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
@@ -204,6 +204,39 @@
 		status = "disabled";
 	};
 
+	mcu_spi0: spi@40300000 {
+		compatible = "ti,am654-mcspi", "ti,omap4-mcspi";
+		reg = <0x00 0x040300000 0x00 0x400>;
+		interrupts = <GIC_SPI 848 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		power-domains = <&k3_pds 384 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 384 0>;
+		status = "disabled";
+	};
+
+	mcu_spi1: spi@40310000 {
+		compatible = "ti,am654-mcspi", "ti,omap4-mcspi";
+		reg = <0x00 0x040310000 0x00 0x400>;
+		interrupts = <GIC_SPI 849 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		power-domains = <&k3_pds 385 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 385 0>;
+		status = "disabled";
+	};
+
+	mcu_spi2: spi@40320000 {
+		compatible = "ti,am654-mcspi", "ti,omap4-mcspi";
+		reg = <0x00 0x040320000 0x00 0x400>;
+		interrupts = <GIC_SPI 850 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		power-domains = <&k3_pds 386 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 386 0>;
+		status = "disabled";
+	};
+
 	mcu_navss: bus@28380000{
 		compatible = "simple-bus";
 		#address-cells = <2>;
-- 
2.17.1

