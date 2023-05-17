Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68EA4706774
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 14:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbjEQMCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 08:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbjEQMBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 08:01:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC39A769D;
        Wed, 17 May 2023 05:00:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D138864616;
        Wed, 17 May 2023 12:00:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9165C4339B;
        Wed, 17 May 2023 12:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684324841;
        bh=z2oIfIxHmThhCiWXCVzE2i29nNkzzU8Rs46DNfLMJEA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vcGHHcarxBCeH7JN+KqsAPN0ZaIrIqKVAIS7xa0EBQdTdESzqcEcE7VIxtufAxOoD
         XgdKbUjzw+iRwrHiK9Mp59dvg42EyHU0FjgCQi/FG6IfNbhTC4bEg4IbmzC5cvuoMj
         IDW+d73hWhuHq7tMs9/ytfu0RdlQ6KGi/apI+RlA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.10.180
Date:   Wed, 17 May 2023 14:00:29 +0200
Message-Id: <2023051729-cosponsor-buddhist-1c01@gregkh>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <2023051728-headless-footing-9418@gregkh>
References: <2023051728-headless-footing-9418@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Makefile b/Makefile
index 3ddcade4be8f..c2f8e1644abd 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 10
-SUBLEVEL = 179
+SUBLEVEL = 180
 EXTRAVERSION =
 NAME = Dare mighty things
 
diff --git a/arch/arm/boot/dts/exynos4412-itop-elite.dts b/arch/arm/boot/dts/exynos4412-itop-elite.dts
index f6d0a5f5d339..9a2a49420d4d 100644
--- a/arch/arm/boot/dts/exynos4412-itop-elite.dts
+++ b/arch/arm/boot/dts/exynos4412-itop-elite.dts
@@ -179,7 +179,7 @@ codec: wm8960@1a {
 		compatible = "wlf,wm8960";
 		reg = <0x1a>;
 		clocks = <&pmu_system_controller 0>;
-		clock-names = "MCLK1";
+		clock-names = "mclk";
 		wlf,shared-lrclk;
 		#sound-dai-cells = <0>;
 	};
diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index cc8a378dd076..e61e5ddbf202 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -609,6 +609,22 @@ &i2c3 {
 	clock-frequency = <100000>;
 };
 
+&mcspi1 {
+	status = "disabled";
+};
+
+&mcspi2 {
+	status = "disabled";
+};
+
+&mcspi3 {
+	status = "disabled";
+};
+
+&mcspi4 {
+	status = "disabled";
+};
+
 &usb_otg_hs {
 	interface-type = <0>;
 	usb-phy = <&usb2_phy>;
diff --git a/arch/arm/boot/dts/qcom-ipq4019.dtsi b/arch/arm/boot/dts/qcom-ipq4019.dtsi
index 3defd47fd8fa..037bb8a9b01e 100644
--- a/arch/arm/boot/dts/qcom-ipq4019.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq4019.dtsi
@@ -414,8 +414,8 @@ pcie0: pci@40000000 {
 			#address-cells = <3>;
 			#size-cells = <2>;
 
-			ranges = <0x81000000 0 0x40200000 0x40200000 0 0x00100000>,
-				 <0x82000000 0 0x40300000 0x40300000 0 0x00d00000>;
+			ranges = <0x81000000 0x0 0x00000000 0x40200000 0x0 0x00100000>,
+				 <0x82000000 0x0 0x40300000 0x40300000 0x0 0x00d00000>;
 
 			interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "msi";
diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index c51481405e7f..dca0ed6c8c8d 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -465,8 +465,8 @@ pcie0: pci@1b500000 {
 			#address-cells = <3>;
 			#size-cells = <2>;
 
-			ranges = <0x81000000 0 0x0fe00000 0x0fe00000 0 0x00100000   /* downstream I/O */
-				  0x82000000 0 0x08000000 0x08000000 0 0x07e00000>; /* non-prefetchable memory */
+			ranges = <0x81000000 0x0 0x00000000 0x0fe00000 0x0 0x00010000   /* I/O */
+				  0x82000000 0x0 0x08000000 0x08000000 0x0 0x07e00000>; /* MEM */
 
 			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "msi";
@@ -516,8 +516,8 @@ pcie1: pci@1b700000 {
 			#address-cells = <3>;
 			#size-cells = <2>;
 
-			ranges = <0x81000000 0 0x31e00000 0x31e00000 0 0x00100000   /* downstream I/O */
-				  0x82000000 0 0x2e000000 0x2e000000 0 0x03e00000>; /* non-prefetchable memory */
+			ranges = <0x81000000 0x0 0x00000000 0x31e00000 0x0 0x00010000   /* I/O */
+				  0x82000000 0x0 0x2e000000 0x2e000000 0x0 0x03e00000>; /* MEM */
 
 			interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "msi";
@@ -567,8 +567,8 @@ pcie2: pci@1b900000 {
 			#address-cells = <3>;
 			#size-cells = <2>;
 
-			ranges = <0x81000000 0 0x35e00000 0x35e00000 0 0x00100000   /* downstream I/O */
-				  0x82000000 0 0x32000000 0x32000000 0 0x03e00000>; /* non-prefetchable memory */
+			ranges = <0x81000000 0x0 0x00000000 0x35e00000 0x0 0x00010000   /* I/O */
+				  0x82000000 0x0 0x32000000 0x32000000 0x0 0x03e00000>; /* MEM */
 
 			interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "msi";
diff --git a/arch/arm/boot/dts/s5pv210.dtsi b/arch/arm/boot/dts/s5pv210.dtsi
index eb7e3660ada7..81ab9fe9897f 100644
--- a/arch/arm/boot/dts/s5pv210.dtsi
+++ b/arch/arm/boot/dts/s5pv210.dtsi
@@ -583,7 +583,7 @@ csis0: csis@fa600000 {
 				interrupts = <29>;
 				clocks = <&clocks CLK_CSIS>,
 						<&clocks SCLK_CSIS>;
-				clock-names = "clk_csis",
+				clock-names = "csis",
 						"sclk_csis";
 				bus-width = <4>;
 				status = "disabled";
diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
index e191a7bc532b..f85fcc7c8676 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -609,10 +609,8 @@ pcie1: pci@10000000 {
 			phys = <&pcie_phy1>;
 			phy-names = "pciephy";
 
-			ranges = <0x81000000 0 0x10200000 0x10200000
-				  0 0x10000>,   /* downstream I/O */
-				 <0x82000000 0 0x10220000 0x10220000
-				  0 0xfde0000>; /* non-prefetchable memory */
+			ranges = <0x81000000 0x0 0x00000000 0x10200000 0x0 0x10000>,   /* I/O */
+				 <0x82000000 0x0 0x10220000 0x10220000 0x0 0xfde0000>; /* MEM */
 
 			interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "msi";
@@ -673,10 +671,8 @@ pcie0: pci@20000000 {
 			phys = <&pcie_phy0>;
 			phy-names = "pciephy";
 
-			ranges = <0x81000000 0 0x20200000 0x20200000
-				  0 0x10000>, /* downstream I/O */
-				 <0x82000000 0 0x20220000 0x20220000
-				  0 0xfde0000>; /* non-prefetchable memory */
+			ranges = <0x81000000 0x0 0x00000000 0x20200000 0x0 0x10000>,   /* I/O */
+				 <0x82000000 0x0 0x20220000 0x20220000 0x0 0xfde0000>; /* MEM */
 
 			interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "msi";
diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index bc140269e4cc..02b5f6f1d331 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -744,8 +744,8 @@ pcie0: pcie@600000 {
 
 				#address-cells = <3>;
 				#size-cells = <2>;
-				ranges = <0x01000000 0x0 0x0c200000 0x0c200000 0x0 0x100000>,
-					<0x02000000 0x0 0x0c300000 0x0c300000 0x0 0xd00000>;
+				ranges = <0x01000000 0x0 0x00000000 0x0c200000 0x0 0x100000>,
+					 <0x02000000 0x0 0x0c300000 0x0c300000 0x0 0xd00000>;
 
 				interrupts = <GIC_SPI 405 IRQ_TYPE_LEVEL_HIGH>;
 				interrupt-names = "msi";
@@ -796,8 +796,8 @@ pcie1: pcie@608000 {
 
 				#address-cells = <3>;
 				#size-cells = <2>;
-				ranges = <0x01000000 0x0 0x0d200000 0x0d200000 0x0 0x100000>,
-					<0x02000000 0x0 0x0d300000 0x0d300000 0x0 0xd00000>;
+				ranges = <0x01000000 0x0 0x00000000 0x0d200000 0x0 0x100000>,
+					 <0x02000000 0x0 0x0d300000 0x0d300000 0x0 0xd00000>;
 
 				interrupts = <GIC_SPI 413 IRQ_TYPE_LEVEL_HIGH>;
 				interrupt-names = "msi";
@@ -845,8 +845,8 @@ pcie2: pcie@610000 {
 
 				#address-cells = <3>;
 				#size-cells = <2>;
-				ranges = <0x01000000 0x0 0x0e200000 0x0e200000 0x0 0x100000>,
-					<0x02000000 0x0 0x0e300000 0x0e300000 0x0 0x1d00000>;
+				ranges = <0x01000000 0x0 0x00000000 0x0e200000 0x0 0x100000>,
+					 <0x02000000 0x0 0x0e300000 0x0e300000 0x0 0x1d00000>;
 
 				device_type = "pci";
 
diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index 9e04ac3f596d..7c8d69ca91cf 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -942,7 +942,7 @@ pcie0: pci@1c00000 {
 			phys = <&pciephy>;
 			phy-names = "pciephy";
 
-			ranges = <0x01000000 0x0 0x1b200000 0x1b200000 0x0 0x100000>,
+			ranges = <0x01000000 0x0 0x00000000 0x1b200000 0x0 0x100000>,
 				 <0x02000000 0x0 0x1b300000 0x1b300000 0x0 0xd00000>;
 
 			#interrupt-cells = <1>;
@@ -1187,7 +1187,7 @@ stm: stm@6002000 {
 			compatible = "arm,coresight-stm", "arm,primecell";
 			reg = <0x06002000 0x1000>,
 			      <0x16280000 0x180000>;
-			reg-names = "stm-base", "stm-data-base";
+			reg-names = "stm-base", "stm-stimulus-base";
 			status = "disabled";
 
 			clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 9beb3c34fcdb..71e5b9fdc9e1 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -196,8 +196,8 @@ CPU0: cpu@0 {
 			cpu-idle-states = <&LITTLE_CPU_SLEEP_0
 					   &LITTLE_CPU_SLEEP_1
 					   &CLUSTER_SLEEP_0>;
-			capacity-dmips-mhz = <607>;
-			dynamic-power-coefficient = <100>;
+			capacity-dmips-mhz = <611>;
+			dynamic-power-coefficient = <154>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			operating-points-v2 = <&cpu0_opp_table>;
 			interconnects = <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc SLAVE_EBI1 3>,
@@ -221,8 +221,8 @@ CPU1: cpu@100 {
 			cpu-idle-states = <&LITTLE_CPU_SLEEP_0
 					   &LITTLE_CPU_SLEEP_1
 					   &CLUSTER_SLEEP_0>;
-			capacity-dmips-mhz = <607>;
-			dynamic-power-coefficient = <100>;
+			capacity-dmips-mhz = <611>;
+			dynamic-power-coefficient = <154>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			operating-points-v2 = <&cpu0_opp_table>;
 			interconnects = <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc SLAVE_EBI1 3>,
@@ -243,8 +243,8 @@ CPU2: cpu@200 {
 			cpu-idle-states = <&LITTLE_CPU_SLEEP_0
 					   &LITTLE_CPU_SLEEP_1
 					   &CLUSTER_SLEEP_0>;
-			capacity-dmips-mhz = <607>;
-			dynamic-power-coefficient = <100>;
+			capacity-dmips-mhz = <611>;
+			dynamic-power-coefficient = <154>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			operating-points-v2 = <&cpu0_opp_table>;
 			interconnects = <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc SLAVE_EBI1 3>,
@@ -265,8 +265,8 @@ CPU3: cpu@300 {
 			cpu-idle-states = <&LITTLE_CPU_SLEEP_0
 					   &LITTLE_CPU_SLEEP_1
 					   &CLUSTER_SLEEP_0>;
-			capacity-dmips-mhz = <607>;
-			dynamic-power-coefficient = <100>;
+			capacity-dmips-mhz = <611>;
+			dynamic-power-coefficient = <154>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			operating-points-v2 = <&cpu0_opp_table>;
 			interconnects = <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc SLAVE_EBI1 3>,
@@ -288,7 +288,7 @@ CPU4: cpu@400 {
 			cpu-idle-states = <&BIG_CPU_SLEEP_0
 					   &BIG_CPU_SLEEP_1
 					   &CLUSTER_SLEEP_0>;
-			dynamic-power-coefficient = <396>;
+			dynamic-power-coefficient = <442>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			operating-points-v2 = <&cpu4_opp_table>;
 			interconnects = <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc SLAVE_EBI1 3>,
@@ -310,7 +310,7 @@ CPU5: cpu@500 {
 			cpu-idle-states = <&BIG_CPU_SLEEP_0
 					   &BIG_CPU_SLEEP_1
 					   &CLUSTER_SLEEP_0>;
-			dynamic-power-coefficient = <396>;
+			dynamic-power-coefficient = <442>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			operating-points-v2 = <&cpu4_opp_table>;
 			interconnects = <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc SLAVE_EBI1 3>,
@@ -332,7 +332,7 @@ CPU6: cpu@600 {
 			cpu-idle-states = <&BIG_CPU_SLEEP_0
 					   &BIG_CPU_SLEEP_1
 					   &CLUSTER_SLEEP_0>;
-			dynamic-power-coefficient = <396>;
+			dynamic-power-coefficient = <442>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			operating-points-v2 = <&cpu4_opp_table>;
 			interconnects = <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc SLAVE_EBI1 3>,
@@ -354,7 +354,7 @@ CPU7: cpu@700 {
 			cpu-idle-states = <&BIG_CPU_SLEEP_0
 					   &BIG_CPU_SLEEP_1
 					   &CLUSTER_SLEEP_0>;
-			dynamic-power-coefficient = <396>;
+			dynamic-power-coefficient = <442>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			operating-points-v2 = <&cpu4_opp_table>;
 			interconnects = <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc SLAVE_EBI1 3>,
@@ -1816,8 +1816,8 @@ pcie0: pci@1c00000 {
 			#address-cells = <3>;
 			#size-cells = <2>;
 
-			ranges = <0x01000000 0x0 0x60200000 0 0x60200000 0x0 0x100000>,
-				 <0x02000000 0x0 0x60300000 0 0x60300000 0x0 0xd00000>;
+			ranges = <0x01000000 0x0 0x00000000 0x0 0x60200000 0x0 0x100000>,
+				 <0x02000000 0x0 0x60300000 0x0 0x60300000 0x0 0xd00000>;
 
 			interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "msi";
@@ -1920,7 +1920,7 @@ pcie1: pci@1c08000 {
 			#address-cells = <3>;
 			#size-cells = <2>;
 
-			ranges = <0x01000000 0x0 0x40200000 0x0 0x40200000 0x0 0x100000>,
+			ranges = <0x01000000 0x0 0x00000000 0x0 0x40200000 0x0 0x100000>,
 				 <0x02000000 0x0 0x40300000 0x0 0x40300000 0x0 0x1fd00000>;
 
 			interrupts = <GIC_SPI 307 IRQ_TYPE_EDGE_RISING>;
diff --git a/arch/arm64/boot/dts/renesas/r8a774c0.dtsi b/arch/arm64/boot/dts/renesas/r8a774c0.dtsi
index 4c7d7e8f8e28..c4a6dfae93aa 100644
--- a/arch/arm64/boot/dts/renesas/r8a774c0.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a774c0.dtsi
@@ -49,17 +49,14 @@ cluster1_opp: opp_table10 {
 		opp-shared;
 		opp-800000000 {
 			opp-hz = /bits/ 64 <800000000>;
-			opp-microvolt = <820000>;
 			clock-latency-ns = <300000>;
 		};
 		opp-1000000000 {
 			opp-hz = /bits/ 64 <1000000000>;
-			opp-microvolt = <820000>;
 			clock-latency-ns = <300000>;
 		};
 		opp-1200000000 {
 			opp-hz = /bits/ 64 <1200000000>;
-			opp-microvolt = <820000>;
 			clock-latency-ns = <300000>;
 			opp-suspend;
 		};
diff --git a/arch/arm64/boot/dts/renesas/r8a77990.dtsi b/arch/arm64/boot/dts/renesas/r8a77990.dtsi
index 37159b9408e8..e91d197a4c0b 100644
--- a/arch/arm64/boot/dts/renesas/r8a77990.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77990.dtsi
@@ -60,17 +60,14 @@ cluster1_opp: opp_table10 {
 		opp-shared;
 		opp-800000000 {
 			opp-hz = /bits/ 64 <800000000>;
-			opp-microvolt = <820000>;
 			clock-latency-ns = <300000>;
 		};
 		opp-1000000000 {
 			opp-hz = /bits/ 64 <1000000000>;
-			opp-microvolt = <820000>;
 			clock-latency-ns = <300000>;
 		};
 		opp-1200000000 {
 			opp-hz = /bits/ 64 <1200000000>;
-			opp-microvolt = <820000>;
 			clock-latency-ns = <300000>;
 			opp-suspend;
 		};
diff --git a/arch/arm64/include/asm/debug-monitors.h b/arch/arm64/include/asm/debug-monitors.h
index 657c921fd784..c16ed5b68768 100644
--- a/arch/arm64/include/asm/debug-monitors.h
+++ b/arch/arm64/include/asm/debug-monitors.h
@@ -116,6 +116,7 @@ void user_regs_reset_single_step(struct user_pt_regs *regs,
 void kernel_enable_single_step(struct pt_regs *regs);
 void kernel_disable_single_step(void);
 int kernel_active_single_step(void);
+void kernel_rewind_single_step(struct pt_regs *regs);
 
 #ifdef CONFIG_HAVE_HW_BREAKPOINT
 int reinstall_suspended_bps(struct pt_regs *regs);
diff --git a/arch/arm64/include/asm/scs.h b/arch/arm64/include/asm/scs.h
index eaa2cd92e4c1..7155055a5beb 100644
--- a/arch/arm64/include/asm/scs.h
+++ b/arch/arm64/include/asm/scs.h
@@ -9,15 +9,16 @@
 #ifdef CONFIG_SHADOW_CALL_STACK
 	scs_sp	.req	x18
 
-	.macro scs_load tsk, tmp
-	ldr	scs_sp, [\tsk, #TSK_TI_SCS_SP]
+	.macro scs_load_current
+	get_current_task scs_sp
+	ldr	scs_sp, [scs_sp, #TSK_TI_SCS_SP]
 	.endm
 
 	.macro scs_save tsk, tmp
 	str	scs_sp, [\tsk, #TSK_TI_SCS_SP]
 	.endm
 #else
-	.macro scs_load tsk, tmp
+	.macro scs_load_current
 	.endm
 
 	.macro scs_save tsk, tmp
diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
index fa76151de6ff..38a0213fdbee 100644
--- a/arch/arm64/kernel/debug-monitors.c
+++ b/arch/arm64/kernel/debug-monitors.c
@@ -439,6 +439,11 @@ int kernel_active_single_step(void)
 }
 NOKPROBE_SYMBOL(kernel_active_single_step);
 
+void kernel_rewind_single_step(struct pt_regs *regs)
+{
+	set_regs_spsr_ss(regs);
+}
+
 /* ptrace API */
 void user_enable_single_step(struct task_struct *task)
 {
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index d5bc1dbdd2fd..55e477f73158 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -221,7 +221,7 @@ alternative_else_nop_endif
 
 	ptrauth_keys_install_kernel tsk, x20, x22, x23
 
-	scs_load tsk, x20
+	scs_load_current
 	.else
 	add	x21, sp, #S_FRAME_SIZE
 	get_current_task tsk
@@ -431,9 +431,7 @@ SYM_CODE_END(__swpan_exit_el0)
 
 	.macro	irq_stack_entry
 	mov	x19, sp			// preserve the original sp
-#ifdef CONFIG_SHADOW_CALL_STACK
-	mov	x24, scs_sp		// preserve the original shadow stack
-#endif
+	scs_save tsk			// preserve the original shadow stack
 
 	/*
 	 * Compare sp with the base of the task stack.
@@ -467,9 +465,7 @@ SYM_CODE_END(__swpan_exit_el0)
 	 */
 	.macro	irq_stack_exit
 	mov	sp, x19
-#ifdef CONFIG_SHADOW_CALL_STACK
-	mov	scs_sp, x24
-#endif
+	scs_load_current
 	.endm
 
 /* GPRs used by entry code */
@@ -1025,7 +1021,7 @@ SYM_FUNC_START(cpu_switch_to)
 	msr	sp_el0, x1
 	ptrauth_keys_install_kernel x1, x8, x9, x10
 	scs_save x0, x8
-	scs_load x1, x8
+	scs_load_current
 	ret
 SYM_FUNC_END(cpu_switch_to)
 NOKPROBE(cpu_switch_to)
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index e1c25fa3b8e6..351ee64c7deb 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -747,7 +747,7 @@ SYM_FUNC_START_LOCAL(__secondary_switched)
 	ldr	x2, [x0, #CPU_BOOT_TASK]
 	cbz	x2, __secondary_too_slow
 	msr	sp_el0, x2
-	scs_load x2, x3
+	scs_load_current
 	mov	x29, #0
 	mov	x30, #0
 
diff --git a/arch/arm64/kernel/kgdb.c b/arch/arm64/kernel/kgdb.c
index 1a157ca33262..e4e95821b1f6 100644
--- a/arch/arm64/kernel/kgdb.c
+++ b/arch/arm64/kernel/kgdb.c
@@ -223,6 +223,8 @@ int kgdb_arch_handle_exception(int exception_vector, int signo,
 		 */
 		if (!kernel_active_single_step())
 			kernel_enable_single_step(linux_regs);
+		else
+			kernel_rewind_single_step(linux_regs);
 		err = 0;
 		break;
 	default:
diff --git a/arch/arm64/kvm/psci.c b/arch/arm64/kvm/psci.c
index 20ba5136ac3d..32bb26be8a9b 100644
--- a/arch/arm64/kvm/psci.c
+++ b/arch/arm64/kvm/psci.c
@@ -499,6 +499,8 @@ int kvm_arm_set_fw_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 	u64 val;
 	int wa_level;
 
+	if (KVM_REG_SIZE(reg->id) != sizeof(val))
+		return -ENOENT;
 	if (copy_from_user(&val, uaddr, KVM_REG_SIZE(reg->id)))
 		return -EFAULT;
 
diff --git a/arch/ia64/kernel/salinfo.c b/arch/ia64/kernel/salinfo.c
index a25ab9b37953..bb99b543dc67 100644
--- a/arch/ia64/kernel/salinfo.c
+++ b/arch/ia64/kernel/salinfo.c
@@ -581,7 +581,7 @@ static int salinfo_cpu_pre_down(unsigned int cpu)
  * 'data' contains an integer that corresponds to the feature we're
  * testing
  */
-static int proc_salinfo_show(struct seq_file *m, void *v)
+static int __maybe_unused proc_salinfo_show(struct seq_file *m, void *v)
 {
 	unsigned long data = (unsigned long)v;
 	seq_puts(m, (sal_platform_features & data) ? "1\n" : "0\n");
diff --git a/arch/ia64/mm/contig.c b/arch/ia64/mm/contig.c
index e30e360beef8..c638e012ad05 100644
--- a/arch/ia64/mm/contig.c
+++ b/arch/ia64/mm/contig.c
@@ -79,7 +79,7 @@ void *per_cpu_init(void)
 	return __per_cpu_start + __per_cpu_offset[smp_processor_id()];
 }
 
-static inline void
+static inline __init void
 alloc_per_cpu_data(void)
 {
 	size_t size = PERCPU_PAGE_SIZE * num_possible_cpus();
diff --git a/arch/ia64/mm/hugetlbpage.c b/arch/ia64/mm/hugetlbpage.c
index b331f94d20ac..292a28a2008f 100644
--- a/arch/ia64/mm/hugetlbpage.c
+++ b/arch/ia64/mm/hugetlbpage.c
@@ -57,7 +57,7 @@ huge_pte_offset (struct mm_struct *mm, unsigned long addr, unsigned long sz)
 
 	pgd = pgd_offset(mm, taddr);
 	if (pgd_present(*pgd)) {
-		p4d = p4d_offset(pgd, addr);
+		p4d = p4d_offset(pgd, taddr);
 		if (p4d_present(*p4d)) {
 			pud = pud_offset(p4d, taddr);
 			if (pud_present(*pud)) {
diff --git a/arch/mips/fw/lib/cmdline.c b/arch/mips/fw/lib/cmdline.c
index f24cbb4a39b5..892765b742bb 100644
--- a/arch/mips/fw/lib/cmdline.c
+++ b/arch/mips/fw/lib/cmdline.c
@@ -53,7 +53,7 @@ char *fw_getenv(char *envname)
 {
 	char *result = NULL;
 
-	if (_fw_envp != NULL) {
+	if (_fw_envp != NULL && fw_envp(0) != NULL) {
 		/*
 		 * Return a pointer to the given environment variable.
 		 * YAMON uses "name", "value" pairs, while U-Boot uses
diff --git a/arch/openrisc/kernel/entry.S b/arch/openrisc/kernel/entry.S
index b42d32d79b2e..7257e942731d 100644
--- a/arch/openrisc/kernel/entry.S
+++ b/arch/openrisc/kernel/entry.S
@@ -173,7 +173,6 @@ handler:							;\
 	l.sw    PT_GPR28(r1),r28					;\
 	l.sw    PT_GPR29(r1),r29					;\
 	/* r30 already save */					;\
-/*        l.sw    PT_GPR30(r1),r30*/					;\
 	l.sw    PT_GPR31(r1),r31					;\
 	TRACE_IRQS_OFF_ENTRY						;\
 	/* Store -1 in orig_gpr11 for non-syscall exceptions */	;\
@@ -211,9 +210,8 @@ handler:							;\
 	l.sw    PT_GPR27(r1),r27					;\
 	l.sw    PT_GPR28(r1),r28					;\
 	l.sw    PT_GPR29(r1),r29					;\
-	/* r31 already saved */					;\
-	l.sw    PT_GPR30(r1),r30					;\
-/*        l.sw    PT_GPR31(r1),r31	*/				;\
+	/* r30 already saved */						;\
+	l.sw    PT_GPR31(r1),r31					;\
 	/* Store -1 in orig_gpr11 for non-syscall exceptions */	;\
 	l.addi	r30,r0,-1					;\
 	l.sw	PT_ORIG_GPR11(r1),r30				;\
diff --git a/arch/parisc/kernel/real2.S b/arch/parisc/kernel/real2.S
index 2b16d8d6598f..c37010a13586 100644
--- a/arch/parisc/kernel/real2.S
+++ b/arch/parisc/kernel/real2.S
@@ -248,9 +248,6 @@ ENTRY_CFI(real64_call_asm)
 	/* save fn */
 	copy	%arg2, %r31
 
-	/* set up the new ap */
-	ldo	64(%arg1), %r29
-
 	/* load up the arg registers from the saved arg area */
 	/* 32-bit calling convention passes first 4 args in registers */
 	ldd	0*REG_SZ(%arg1), %arg0		/* note overwriting arg0 */
@@ -262,7 +259,9 @@ ENTRY_CFI(real64_call_asm)
 	ldd	7*REG_SZ(%arg1), %r19
 	ldd	1*REG_SZ(%arg1), %arg1		/* do this one last! */
 
+	/* set up real-mode stack and real-mode ap */
 	tophys_r1 %sp
+	ldo	-16(%sp), %r29			/* Reference param save area */
 
 	b,l	rfi_virt2real,%r2
 	nop
diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
index c2e407a112a2..5976a25c6264 100644
--- a/arch/powerpc/kernel/rtas.c
+++ b/arch/powerpc/kernel/rtas.c
@@ -399,7 +399,7 @@ static char *__fetch_rtas_last_error(char *altbuf)
 				buf = kmalloc(RTAS_ERROR_LOG_MAX, GFP_ATOMIC);
 		}
 		if (buf)
-			memcpy(buf, rtas_err_buf, RTAS_ERROR_LOG_MAX);
+			memmove(buf, rtas_err_buf, RTAS_ERROR_LOG_MAX);
 	}
 
 	return buf;
diff --git a/arch/powerpc/platforms/512x/clock-commonclk.c b/arch/powerpc/platforms/512x/clock-commonclk.c
index 30342b60aa63..42c3d40355d9 100644
--- a/arch/powerpc/platforms/512x/clock-commonclk.c
+++ b/arch/powerpc/platforms/512x/clock-commonclk.c
@@ -984,7 +984,7 @@ static void mpc5121_clk_provide_migration_support(void)
 
 #define NODE_PREP do { \
 	of_address_to_resource(np, 0, &res); \
-	snprintf(devname, sizeof(devname), "%08x.%s", res.start, np->name); \
+	snprintf(devname, sizeof(devname), "%pa.%s", &res.start, np->name); \
 } while (0)
 
 #define NODE_CHK(clkname, clkitem, regnode, regflag) do { \
diff --git a/arch/powerpc/platforms/embedded6xx/flipper-pic.c b/arch/powerpc/platforms/embedded6xx/flipper-pic.c
index d39a9213a3e6..7dd2e2f97aae 100644
--- a/arch/powerpc/platforms/embedded6xx/flipper-pic.c
+++ b/arch/powerpc/platforms/embedded6xx/flipper-pic.c
@@ -144,7 +144,7 @@ static struct irq_domain * __init flipper_pic_init(struct device_node *np)
 	}
 	io_base = ioremap(res.start, resource_size(&res));
 
-	pr_info("controller at 0x%08x mapped to 0x%p\n", res.start, io_base);
+	pr_info("controller at 0x%pa mapped to 0x%p\n", &res.start, io_base);
 
 	__flipper_quiesce(io_base);
 
diff --git a/arch/powerpc/platforms/embedded6xx/hlwd-pic.c b/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
index de10c13de15c..c6b492ebb766 100644
--- a/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
+++ b/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
@@ -173,7 +173,7 @@ static struct irq_domain *hlwd_pic_init(struct device_node *np)
 		return NULL;
 	}
 
-	pr_info("controller at 0x%08x mapped to 0x%p\n", res.start, io_base);
+	pr_info("controller at 0x%pa mapped to 0x%p\n", &res.start, io_base);
 
 	__hlwd_quiesce(io_base);
 
diff --git a/arch/powerpc/platforms/embedded6xx/wii.c b/arch/powerpc/platforms/embedded6xx/wii.c
index a802ef957d63..458a63a30e80 100644
--- a/arch/powerpc/platforms/embedded6xx/wii.c
+++ b/arch/powerpc/platforms/embedded6xx/wii.c
@@ -89,8 +89,8 @@ static void __iomem *wii_ioremap_hw_regs(char *name, char *compatible)
 
 	hw_regs = ioremap(res.start, resource_size(&res));
 	if (hw_regs) {
-		pr_info("%s at 0x%08x mapped to 0x%p\n", name,
-			res.start, hw_regs);
+		pr_info("%s at 0x%pa mapped to 0x%p\n", name,
+			&res.start, hw_regs);
 	}
 
 out_put:
diff --git a/arch/powerpc/sysdev/tsi108_pci.c b/arch/powerpc/sysdev/tsi108_pci.c
index 49f9541954f8..3664ffcbb313 100644
--- a/arch/powerpc/sysdev/tsi108_pci.c
+++ b/arch/powerpc/sysdev/tsi108_pci.c
@@ -216,9 +216,8 @@ int __init tsi108_setup_pci(struct device_node *dev, u32 cfg_phys, int primary)
 
 	(hose)->ops = &tsi108_direct_pci_ops;
 
-	printk(KERN_INFO "Found tsi108 PCI host bridge at 0x%08x. "
-	       "Firmware bus number: %d->%d\n",
-	       rsrc.start, hose->first_busno, hose->last_busno);
+	pr_info("Found tsi108 PCI host bridge at 0x%pa. Firmware bus number: %d->%d\n",
+		&rsrc.start, hose->first_busno, hose->last_busno);
 
 	/* Interpret the "ranges" property */
 	/* This also maps the I/O region and sets isa_io/mem_base */
diff --git a/arch/sh/Kconfig.debug b/arch/sh/Kconfig.debug
index 97b0e26cf05a..7bc1b10b81c9 100644
--- a/arch/sh/Kconfig.debug
+++ b/arch/sh/Kconfig.debug
@@ -18,7 +18,7 @@ config SH_STANDARD_BIOS
 
 config STACK_DEBUG
 	bool "Check for stack overflows"
-	depends on DEBUG_KERNEL
+	depends on DEBUG_KERNEL && PRINTK
 	help
 	  This option will cause messages to be printed if free stack space
 	  drops below a certain limit. Saying Y here will add overhead to
diff --git a/arch/sh/kernel/cpu/sh4/sq.c b/arch/sh/kernel/cpu/sh4/sq.c
index d432164b23b7..c31ec0fea300 100644
--- a/arch/sh/kernel/cpu/sh4/sq.c
+++ b/arch/sh/kernel/cpu/sh4/sq.c
@@ -381,7 +381,7 @@ static int __init sq_api_init(void)
 	if (unlikely(!sq_cache))
 		return ret;
 
-	sq_bitmap = kzalloc(size, GFP_KERNEL);
+	sq_bitmap = kcalloc(size, sizeof(long), GFP_KERNEL);
 	if (unlikely(!sq_bitmap))
 		goto out;
 
diff --git a/arch/sh/kernel/head_32.S b/arch/sh/kernel/head_32.S
index 4adbd4ade319..b603b7968b38 100644
--- a/arch/sh/kernel/head_32.S
+++ b/arch/sh/kernel/head_32.S
@@ -64,7 +64,7 @@ ENTRY(_stext)
 	ldc	r0, r6_bank
 #endif
 
-#ifdef CONFIG_OF_FLATTREE
+#ifdef CONFIG_OF_EARLY_FLATTREE
 	mov	r4, r12		! Store device tree blob pointer in r12
 #endif
 	
@@ -315,7 +315,7 @@ ENTRY(_stext)
 10:		
 #endif
 
-#ifdef CONFIG_OF_FLATTREE
+#ifdef CONFIG_OF_EARLY_FLATTREE
 	mov.l	8f, r0		! Make flat device tree available early.
 	jsr	@r0
 	 mov	r12, r4
@@ -346,7 +346,7 @@ ENTRY(stack_start)
 5:	.long	start_kernel
 6:	.long	cpu_init
 7:	.long	init_thread_union
-#if defined(CONFIG_OF_FLATTREE)
+#if defined(CONFIG_OF_EARLY_FLATTREE)
 8:	.long	sh_fdt_init
 #endif
 
diff --git a/arch/sh/kernel/nmi_debug.c b/arch/sh/kernel/nmi_debug.c
index 11777867c6f5..a212b645b4cf 100644
--- a/arch/sh/kernel/nmi_debug.c
+++ b/arch/sh/kernel/nmi_debug.c
@@ -49,7 +49,7 @@ static int __init nmi_debug_setup(char *str)
 	register_die_notifier(&nmi_debug_nb);
 
 	if (*str != '=')
-		return 0;
+		return 1;
 
 	for (p = str + 1; *p; p = sep + 1) {
 		sep = strchr(p, ',');
@@ -70,6 +70,6 @@ static int __init nmi_debug_setup(char *str)
 			break;
 	}
 
-	return 0;
+	return 1;
 }
 __setup("nmi_debug", nmi_debug_setup);
diff --git a/arch/sh/kernel/setup.c b/arch/sh/kernel/setup.c
index 4144be650d41..556e463a43d2 100644
--- a/arch/sh/kernel/setup.c
+++ b/arch/sh/kernel/setup.c
@@ -244,7 +244,7 @@ void __init __weak plat_early_device_setup(void)
 {
 }
 
-#ifdef CONFIG_OF_FLATTREE
+#ifdef CONFIG_OF_EARLY_FLATTREE
 void __ref sh_fdt_init(phys_addr_t dt_phys)
 {
 	static int done = 0;
@@ -329,7 +329,7 @@ void __init setup_arch(char **cmdline_p)
 	/* Let earlyprintk output early console messages */
 	sh_early_platform_driver_probe("earlyprintk", 1, 1);
 
-#ifdef CONFIG_OF_FLATTREE
+#ifdef CONFIG_OF_EARLY_FLATTREE
 #ifdef CONFIG_USE_BUILTIN_DTB
 	unflatten_and_copy_device_tree();
 #else
diff --git a/arch/sh/math-emu/sfp-util.h b/arch/sh/math-emu/sfp-util.h
index 784f541344f3..bda50762b3d3 100644
--- a/arch/sh/math-emu/sfp-util.h
+++ b/arch/sh/math-emu/sfp-util.h
@@ -67,7 +67,3 @@
   } while (0)
 
 #define abort()	return 0
-
-#define __BYTE_ORDER __LITTLE_ENDIAN
-
-
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 660012ab7bfa..3e9f1c820edb 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -553,6 +553,7 @@ struct kvm_vcpu_arch {
 	u64 ia32_misc_enable_msr;
 	u64 smbase;
 	u64 smi_count;
+	bool at_instruction_boundary;
 	bool tpr_access_reporting;
 	bool xsaves_enabled;
 	u64 ia32_xss;
@@ -663,7 +664,7 @@ struct kvm_vcpu_arch {
 		u8 preempted;
 		u64 msr_val;
 		u64 last_steal;
-		struct gfn_to_pfn_cache cache;
+		struct gfn_to_hva_cache cache;
 	} st;
 
 	u64 l1_tsc_offset;
@@ -1061,6 +1062,8 @@ struct kvm_vcpu_stat {
 	u64 req_event;
 	u64 halt_poll_success_ns;
 	u64 halt_poll_fail_ns;
+	u64 preemption_reported;
+	u64 preemption_other;
 };
 
 struct x86_instruction_info;
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 1c96f2425eaf..25eb69f26e03 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -410,10 +410,9 @@ static unsigned int reserve_eilvt_offset(int offset, unsigned int new)
 		if (vector && !eilvt_entry_is_changeable(vector, new))
 			/* may not change if vectors are different */
 			return rsvd;
-		rsvd = atomic_cmpxchg(&eilvt_offsets[offset], rsvd, new);
-	} while (rsvd != new);
+	} while (!atomic_try_cmpxchg(&eilvt_offsets[offset], &rsvd, new));
 
-	rsvd &= ~APIC_EILVT_MASKED;
+	rsvd = new & ~APIC_EILVT_MASKED;
 	if (rsvd && rsvd != vector)
 		pr_info("LVT offset %d assigned for vector 0x%02x\n",
 			offset, rsvd);
diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 25b1d5c6af96..74794387bf59 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -2442,17 +2442,21 @@ static int io_apic_get_redir_entries(int ioapic)
 
 unsigned int arch_dynirq_lower_bound(unsigned int from)
 {
+	unsigned int ret;
+
 	/*
 	 * dmar_alloc_hwirq() may be called before setup_IO_APIC(), so use
 	 * gsi_top if ioapic_dynirq_base hasn't been initialized yet.
 	 */
-	if (!ioapic_initialized)
-		return gsi_top;
+	ret = ioapic_dynirq_base ? : gsi_top;
+
 	/*
-	 * For DT enabled machines ioapic_dynirq_base is irrelevant and not
-	 * updated. So simply return @from if ioapic_dynirq_base == 0.
+	 * For DT enabled machines ioapic_dynirq_base is irrelevant and
+	 * always 0. gsi_top can be 0 if there is no IO/APIC registered.
+	 * 0 is an invalid interrupt number for dynamic allocations. Return
+	 * @from instead.
 	 */
-	return ioapic_dynirq_base ? : from;
+	return ret ? : from;
 }
 
 #ifdef CONFIG_X86_32
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 4f9b7c1cfc36..cd8db6b9ca2f 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -197,10 +197,10 @@ static DEFINE_PER_CPU(struct threshold_bank **, threshold_banks);
  * A list of the banks enabled on each logical CPU. Controls which respective
  * descriptors to initialize later in mce_threshold_create_device().
  */
-static DEFINE_PER_CPU(unsigned int, bank_map);
+static DEFINE_PER_CPU(u64, bank_map);
 
 /* Map of banks that have more than MCA_MISC0 available. */
-static DEFINE_PER_CPU(u32, smca_misc_banks_map);
+static DEFINE_PER_CPU(u64, smca_misc_banks_map);
 
 static void amd_threshold_interrupt(void);
 static void amd_deferred_error_interrupt(void);
@@ -229,7 +229,7 @@ static void smca_set_misc_banks_map(unsigned int bank, unsigned int cpu)
 		return;
 
 	if (low & MASK_BLKPTR_LO)
-		per_cpu(smca_misc_banks_map, cpu) |= BIT(bank);
+		per_cpu(smca_misc_banks_map, cpu) |= BIT_ULL(bank);
 
 }
 
@@ -492,7 +492,7 @@ static u32 smca_get_block_address(unsigned int bank, unsigned int block,
 	if (!block)
 		return MSR_AMD64_SMCA_MCx_MISC(bank);
 
-	if (!(per_cpu(smca_misc_banks_map, cpu) & BIT(bank)))
+	if (!(per_cpu(smca_misc_banks_map, cpu) & BIT_ULL(bank)))
 		return 0;
 
 	return MSR_AMD64_SMCA_MCx_MISCy(bank, block - 1);
@@ -536,7 +536,7 @@ prepare_threshold_block(unsigned int bank, unsigned int block, u32 addr,
 	int new;
 
 	if (!block)
-		per_cpu(bank_map, cpu) |= (1 << bank);
+		per_cpu(bank_map, cpu) |= BIT_ULL(bank);
 
 	memset(&b, 0, sizeof(b));
 	b.cpu			= cpu;
@@ -1048,7 +1048,7 @@ static void amd_threshold_interrupt(void)
 		return;
 
 	for (bank = 0; bank < this_cpu_read(mce_num_banks); ++bank) {
-		if (!(per_cpu(bank_map, cpu) & (1 << bank)))
+		if (!(per_cpu(bank_map, cpu) & BIT_ULL(bank)))
 			continue;
 
 		first_block = bp[bank]->blocks;
@@ -1525,7 +1525,7 @@ int mce_threshold_create_device(unsigned int cpu)
 		return -ENOMEM;
 
 	for (bank = 0; bank < numbanks; ++bank) {
-		if (!(this_cpu_read(bank_map) & (1 << bank)))
+		if (!(this_cpu_read(bank_map) & BIT_ULL(bank)))
 			continue;
 		err = threshold_create_bank(bp, cpu, bank);
 		if (err) {
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 571220ac8bea..835b948095cd 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -25,17 +25,7 @@
  */
 union fpregs_state init_fpstate __read_mostly;
 
-/*
- * Track whether the kernel is using the FPU state
- * currently.
- *
- * This flag is used:
- *
- *   - by IRQ context code to potentially use the FPU
- *     if it's unused.
- *
- *   - to debug kernel_fpu_begin()/end() correctness
- */
+/* Track in-kernel FPU usage */
 static DEFINE_PER_CPU(bool, in_kernel_fpu);
 
 /*
@@ -43,42 +33,37 @@ static DEFINE_PER_CPU(bool, in_kernel_fpu);
  */
 DEFINE_PER_CPU(struct fpu *, fpu_fpregs_owner_ctx);
 
-static bool kernel_fpu_disabled(void)
-{
-	return this_cpu_read(in_kernel_fpu);
-}
-
-static bool interrupted_kernel_fpu_idle(void)
-{
-	return !kernel_fpu_disabled();
-}
-
-/*
- * Were we in user mode (or vm86 mode) when we were
- * interrupted?
- *
- * Doing kernel_fpu_begin/end() is ok if we are running
- * in an interrupt context from user mode - we'll just
- * save the FPU state as required.
- */
-static bool interrupted_user_mode(void)
-{
-	struct pt_regs *regs = get_irq_regs();
-	return regs && user_mode(regs);
-}
-
 /*
  * Can we use the FPU in kernel mode with the
  * whole "kernel_fpu_begin/end()" sequence?
- *
- * It's always ok in process context (ie "not interrupt")
- * but it is sometimes ok even from an irq.
  */
 bool irq_fpu_usable(void)
 {
-	return !in_interrupt() ||
-		interrupted_user_mode() ||
-		interrupted_kernel_fpu_idle();
+	if (WARN_ON_ONCE(in_nmi()))
+		return false;
+
+	/* In kernel FPU usage already active? */
+	if (this_cpu_read(in_kernel_fpu))
+		return false;
+
+	/*
+	 * When not in NMI or hard interrupt context, FPU can be used in:
+	 *
+	 * - Task context except from within fpregs_lock()'ed critical
+	 *   regions.
+	 *
+	 * - Soft interrupt processing context which cannot happen
+	 *   while in a fpregs_lock()'ed critical region.
+	 */
+	if (!in_irq())
+		return true;
+
+	/*
+	 * In hard interrupt context it's safe when soft interrupts
+	 * are enabled, which means the interrupt did not hit in
+	 * a fpregs_lock()'ed critical region.
+	 */
+	return !softirq_count();
 }
 EXPORT_SYMBOL(irq_fpu_usable);
 
diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 09ec1cda2d68..e03e320847cd 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -1562,16 +1562,19 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *current_vcpu, u64 ingpa,
 
 	cpumask_clear(&hv_vcpu->tlb_flush);
 
-	vcpu_mask = all_cpus ? NULL :
-		sparse_set_to_vcpu_mask(kvm, sparse_banks, valid_bank_mask,
-					vp_bitmap, vcpu_bitmap);
-
 	/*
 	 * vcpu->arch.cr3 may not be up-to-date for running vCPUs so we can't
 	 * analyze it here, flush TLB regardless of the specified address space.
 	 */
-	kvm_make_vcpus_request_mask(kvm, KVM_REQ_TLB_FLUSH_GUEST,
-				    NULL, vcpu_mask, &hv_vcpu->tlb_flush);
+	if (all_cpus) {
+		kvm_make_all_cpus_request(kvm, KVM_REQ_TLB_FLUSH_GUEST);
+	} else {
+		vcpu_mask = sparse_set_to_vcpu_mask(kvm, sparse_banks, valid_bank_mask,
+						    vp_bitmap, vcpu_bitmap);
+
+		kvm_make_vcpus_request_mask(kvm, KVM_REQ_TLB_FLUSH_GUEST,
+					    NULL, vcpu_mask, &hv_vcpu->tlb_flush);
+	}
 
 ret_success:
 	/* We always do full TLB flush, set rep_done = rep_cnt. */
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 5775983fec56..7b2b61309d8a 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3983,6 +3983,8 @@ static int svm_check_intercept(struct kvm_vcpu *vcpu,
 
 static void svm_handle_exit_irqoff(struct kvm_vcpu *vcpu)
 {
+	if (to_svm(vcpu)->vmcb->control.exit_code == SVM_EXIT_INTR)
+		vcpu->arch.at_instruction_boundary = true;
 }
 
 static void svm_sched_in(struct kvm_vcpu *vcpu, int cpu)
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 2c5d8b9f9873..9aedc7b06da7 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6510,6 +6510,7 @@ static void handle_external_interrupt_irqoff(struct kvm_vcpu *vcpu)
 		return;
 
 	handle_interrupt_nmi_irqoff(vcpu, gate_offset(desc));
+	vcpu->arch.at_instruction_boundary = true;
 }
 
 static void vmx_handle_exit_irqoff(struct kvm_vcpu *vcpu)
@@ -7536,6 +7537,21 @@ static int vmx_check_intercept(struct kvm_vcpu *vcpu,
 		/* FIXME: produce nested vmexit and return X86EMUL_INTERCEPTED.  */
 		break;
 
+	case x86_intercept_pause:
+		/*
+		 * PAUSE is a single-byte NOP with a REPE prefix, i.e. collides
+		 * with vanilla NOPs in the emulator.  Apply the interception
+		 * check only to actual PAUSE instructions.  Don't check
+		 * PAUSE-loop-exiting, software can't expect a given PAUSE to
+		 * exit, i.e. KVM is within its rights to allow L2 to execute
+		 * the PAUSE.
+		 */
+		if ((info->rep_prefix != REPE_PREFIX) ||
+		    !nested_cpu_has2(vmcs12, CPU_BASED_PAUSE_EXITING))
+			return X86EMUL_CONTINUE;
+
+		break;
+
 	/* TODO: check more intercepts... */
 	default:
 		break;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 0ccc8d1b972c..5fbae8cc0697 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -231,6 +231,8 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
 	VCPU_STAT("l1d_flush", l1d_flush),
 	VCPU_STAT("halt_poll_success_ns", halt_poll_success_ns),
 	VCPU_STAT("halt_poll_fail_ns", halt_poll_fail_ns),
+	VCPU_STAT("preemption_reported", preemption_reported),
+	VCPU_STAT("preemption_other", preemption_other),
 	VM_STAT("mmu_shadow_zapped", mmu_shadow_zapped),
 	VM_STAT("mmu_pte_write", mmu_pte_write),
 	VM_STAT("mmu_pde_zapped", mmu_pde_zapped),
@@ -3020,51 +3022,95 @@ static void kvm_vcpu_flush_tlb_guest(struct kvm_vcpu *vcpu)
 
 static void record_steal_time(struct kvm_vcpu *vcpu)
 {
-	struct kvm_host_map map;
-	struct kvm_steal_time *st;
+	struct gfn_to_hva_cache *ghc = &vcpu->arch.st.cache;
+	struct kvm_steal_time __user *st;
+	struct kvm_memslots *slots;
+	gpa_t gpa = vcpu->arch.st.msr_val & KVM_STEAL_VALID_BITS;
+	u64 steal;
+	u32 version;
 
 	if (!(vcpu->arch.st.msr_val & KVM_MSR_ENABLED))
 		return;
 
-	/* -EAGAIN is returned in atomic context so we can just return. */
-	if (kvm_map_gfn(vcpu, vcpu->arch.st.msr_val >> PAGE_SHIFT,
-			&map, &vcpu->arch.st.cache, false))
+	if (WARN_ON_ONCE(current->mm != vcpu->kvm->mm))
 		return;
 
-	st = map.hva +
-		offset_in_page(vcpu->arch.st.msr_val & KVM_STEAL_VALID_BITS);
+	slots = kvm_memslots(vcpu->kvm);
+
+	if (unlikely(slots->generation != ghc->generation ||
+		     gpa != ghc->gpa ||
+		     kvm_is_error_hva(ghc->hva) || !ghc->memslot)) {
+		/* We rely on the fact that it fits in a single page. */
+		BUILD_BUG_ON((sizeof(*st) - 1) & KVM_STEAL_VALID_BITS);
 
+		if (kvm_gfn_to_hva_cache_init(vcpu->kvm, ghc, gpa, sizeof(*st)) ||
+		    kvm_is_error_hva(ghc->hva) || !ghc->memslot)
+			return;
+	}
+
+	st = (struct kvm_steal_time __user *)ghc->hva;
 	/*
 	 * Doing a TLB flush here, on the guest's behalf, can avoid
 	 * expensive IPIs.
 	 */
 	if (guest_pv_has(vcpu, KVM_FEATURE_PV_TLB_FLUSH)) {
+		u8 st_preempted = 0;
+		int err = -EFAULT;
+
+		if (!user_access_begin(st, sizeof(*st)))
+			return;
+
+		asm volatile("1: xchgb %0, %2\n"
+			     "xor %1, %1\n"
+			     "2:\n"
+			     _ASM_EXTABLE_UA(1b, 2b)
+			     : "+q" (st_preempted),
+			       "+&r" (err),
+			       "+m" (st->preempted));
+		if (err)
+			goto out;
+
+		user_access_end();
+
+		vcpu->arch.st.preempted = 0;
+
 		trace_kvm_pv_tlb_flush(vcpu->vcpu_id,
-				       st->preempted & KVM_VCPU_FLUSH_TLB);
-		if (xchg(&st->preempted, 0) & KVM_VCPU_FLUSH_TLB)
+				       st_preempted & KVM_VCPU_FLUSH_TLB);
+		if (st_preempted & KVM_VCPU_FLUSH_TLB)
 			kvm_vcpu_flush_tlb_guest(vcpu);
+
+		if (!user_access_begin(st, sizeof(*st)))
+			goto dirty;
 	} else {
-		st->preempted = 0;
-	}
+		if (!user_access_begin(st, sizeof(*st)))
+			return;
 
-	vcpu->arch.st.preempted = 0;
+		unsafe_put_user(0, &st->preempted, out);
+		vcpu->arch.st.preempted = 0;
+	}
 
-	if (st->version & 1)
-		st->version += 1;  /* first time write, random junk */
+	unsafe_get_user(version, &st->version, out);
+	if (version & 1)
+		version += 1;  /* first time write, random junk */
 
-	st->version += 1;
+	version += 1;
+	unsafe_put_user(version, &st->version, out);
 
 	smp_wmb();
 
-	st->steal += current->sched_info.run_delay -
+	unsafe_get_user(steal, &st->steal, out);
+	steal += current->sched_info.run_delay -
 		vcpu->arch.st.last_steal;
 	vcpu->arch.st.last_steal = current->sched_info.run_delay;
+	unsafe_put_user(steal, &st->steal, out);
 
-	smp_wmb();
+	version += 1;
+	unsafe_put_user(version, &st->version, out);
 
-	st->version += 1;
-
-	kvm_unmap_gfn(vcpu, &map, &vcpu->arch.st.cache, true, false);
+ out:
+	user_access_end();
+ dirty:
+	mark_page_dirty_in_slot(ghc->memslot, gpa_to_gfn(ghc->gpa));
 }
 
 int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
@@ -4049,51 +4095,67 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 
 static void kvm_steal_time_set_preempted(struct kvm_vcpu *vcpu)
 {
-	struct kvm_host_map map;
-	struct kvm_steal_time *st;
+	struct gfn_to_hva_cache *ghc = &vcpu->arch.st.cache;
+	struct kvm_steal_time __user *st;
+	struct kvm_memslots *slots;
+	static const u8 preempted = KVM_VCPU_PREEMPTED;
+	gpa_t gpa = vcpu->arch.st.msr_val & KVM_STEAL_VALID_BITS;
+
+	/*
+	 * The vCPU can be marked preempted if and only if the VM-Exit was on
+	 * an instruction boundary and will not trigger guest emulation of any
+	 * kind (see vcpu_run).  Vendor specific code controls (conservatively)
+	 * when this is true, for example allowing the vCPU to be marked
+	 * preempted if and only if the VM-Exit was due to a host interrupt.
+	 */
+	if (!vcpu->arch.at_instruction_boundary) {
+		vcpu->stat.preemption_other++;
+		return;
+	}
 
+	vcpu->stat.preemption_reported++;
 	if (!(vcpu->arch.st.msr_val & KVM_MSR_ENABLED))
 		return;
 
 	if (vcpu->arch.st.preempted)
 		return;
 
-	if (kvm_map_gfn(vcpu, vcpu->arch.st.msr_val >> PAGE_SHIFT, &map,
-			&vcpu->arch.st.cache, true))
+	/* This happens on process exit */
+	if (unlikely(current->mm != vcpu->kvm->mm))
 		return;
 
-	st = map.hva +
-		offset_in_page(vcpu->arch.st.msr_val & KVM_STEAL_VALID_BITS);
+	slots = kvm_memslots(vcpu->kvm);
+
+	if (unlikely(slots->generation != ghc->generation ||
+		     gpa != ghc->gpa ||
+		     kvm_is_error_hva(ghc->hva) || !ghc->memslot))
+		return;
 
-	st->preempted = vcpu->arch.st.preempted = KVM_VCPU_PREEMPTED;
+	st = (struct kvm_steal_time __user *)ghc->hva;
+	BUILD_BUG_ON(sizeof(st->preempted) != sizeof(preempted));
 
-	kvm_unmap_gfn(vcpu, &map, &vcpu->arch.st.cache, true, true);
+	if (!copy_to_user_nofault(&st->preempted, &preempted, sizeof(preempted)))
+		vcpu->arch.st.preempted = KVM_VCPU_PREEMPTED;
+
+	mark_page_dirty_in_slot(ghc->memslot, gpa_to_gfn(ghc->gpa));
 }
 
 void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
 {
 	int idx;
 
-	if (vcpu->preempted)
+	if (vcpu->preempted) {
 		vcpu->arch.preempted_in_kernel = !kvm_x86_ops.get_cpl(vcpu);
 
-	/*
-	 * Disable page faults because we're in atomic context here.
-	 * kvm_write_guest_offset_cached() would call might_fault()
-	 * that relies on pagefault_disable() to tell if there's a
-	 * bug. NOTE: the write to guest memory may not go through if
-	 * during postcopy live migration or if there's heavy guest
-	 * paging.
-	 */
-	pagefault_disable();
-	/*
-	 * kvm_memslots() will be called by
-	 * kvm_write_guest_offset_cached() so take the srcu lock.
-	 */
-	idx = srcu_read_lock(&vcpu->kvm->srcu);
-	kvm_steal_time_set_preempted(vcpu);
-	srcu_read_unlock(&vcpu->kvm->srcu, idx);
-	pagefault_enable();
+		/*
+		 * Take the srcu lock as memslots will be accessed to check the gfn
+		 * cache generation against the memslots generation.
+		 */
+		idx = srcu_read_lock(&vcpu->kvm->srcu);
+		kvm_steal_time_set_preempted(vcpu);
+		srcu_read_unlock(&vcpu->kvm->srcu, idx);
+	}
+
 	kvm_x86_ops.vcpu_put(vcpu);
 	vcpu->arch.last_host_tsc = rdtsc();
 	/*
@@ -9357,6 +9419,13 @@ static int vcpu_run(struct kvm_vcpu *vcpu)
 	vcpu->arch.l1tf_flush_l1d = true;
 
 	for (;;) {
+		/*
+		 * If another guest vCPU requests a PV TLB flush in the middle
+		 * of instruction emulation, the rest of the emulation could
+		 * use a stale page translation. Assume that any code after
+		 * this point can start executing an instruction.
+		 */
+		vcpu->arch.at_instruction_boundary = false;
 		if (kvm_vcpu_running(vcpu)) {
 			r = vcpu_enter_guest(vcpu);
 		} else {
@@ -10242,11 +10311,8 @@ void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
 
 void kvm_arch_vcpu_destroy(struct kvm_vcpu *vcpu)
 {
-	struct gfn_to_pfn_cache *cache = &vcpu->arch.st.cache;
 	int idx;
 
-	kvm_release_pfn(cache->pfn, cache->dirty, cache);
-
 	kvmclock_reset(vcpu);
 
 	kvm_x86_ops.vcpu_free(vcpu);
diff --git a/block/blk-core.c b/block/blk-core.c
index 9afb79b322fb..d0d0dd8151f7 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1444,6 +1444,13 @@ bool blk_update_request(struct request *req, blk_status_t error,
 		req->q->integrity.profile->complete_fn(req, nr_bytes);
 #endif
 
+	/*
+	 * Upper layers may call blk_crypto_evict_key() anytime after the last
+	 * bio_endio().  Therefore, the keyslot must be released before that.
+	 */
+	if (blk_crypto_rq_has_keyslot(req) && nr_bytes >= blk_rq_bytes(req))
+		__blk_crypto_rq_put_keyslot(req);
+
 	if (unlikely(error && !blk_rq_is_passthrough(req) &&
 		     !(req->rq_flags & RQF_QUIET)))
 		print_req_error(req, error, __func__);
diff --git a/block/blk-crypto-internal.h b/block/blk-crypto-internal.h
index 0d36aae538d7..8e0834557620 100644
--- a/block/blk-crypto-internal.h
+++ b/block/blk-crypto-internal.h
@@ -60,6 +60,11 @@ static inline bool blk_crypto_rq_is_encrypted(struct request *rq)
 	return rq->crypt_ctx;
 }
 
+static inline bool blk_crypto_rq_has_keyslot(struct request *rq)
+{
+	return rq->crypt_keyslot;
+}
+
 #else /* CONFIG_BLK_INLINE_ENCRYPTION */
 
 static inline bool bio_crypt_rq_ctx_compatible(struct request *rq,
@@ -93,6 +98,11 @@ static inline bool blk_crypto_rq_is_encrypted(struct request *rq)
 	return false;
 }
 
+static inline bool blk_crypto_rq_has_keyslot(struct request *rq)
+{
+	return false;
+}
+
 #endif /* CONFIG_BLK_INLINE_ENCRYPTION */
 
 void __bio_crypt_advance(struct bio *bio, unsigned int bytes);
@@ -127,14 +137,21 @@ static inline bool blk_crypto_bio_prep(struct bio **bio_ptr)
 	return true;
 }
 
-blk_status_t __blk_crypto_init_request(struct request *rq);
-static inline blk_status_t blk_crypto_init_request(struct request *rq)
+blk_status_t __blk_crypto_rq_get_keyslot(struct request *rq);
+static inline blk_status_t blk_crypto_rq_get_keyslot(struct request *rq)
 {
 	if (blk_crypto_rq_is_encrypted(rq))
-		return __blk_crypto_init_request(rq);
+		return __blk_crypto_rq_get_keyslot(rq);
 	return BLK_STS_OK;
 }
 
+void __blk_crypto_rq_put_keyslot(struct request *rq);
+static inline void blk_crypto_rq_put_keyslot(struct request *rq)
+{
+	if (blk_crypto_rq_has_keyslot(rq))
+		__blk_crypto_rq_put_keyslot(rq);
+}
+
 void __blk_crypto_free_request(struct request *rq);
 static inline void blk_crypto_free_request(struct request *rq)
 {
@@ -173,7 +190,7 @@ static inline blk_status_t blk_crypto_insert_cloned_request(struct request *rq)
 {
 
 	if (blk_crypto_rq_is_encrypted(rq))
-		return blk_crypto_init_request(rq);
+		return blk_crypto_rq_get_keyslot(rq);
 	return BLK_STS_OK;
 }
 
diff --git a/block/blk-crypto.c b/block/blk-crypto.c
index 5ffa9aab49de..87ec55d4354f 100644
--- a/block/blk-crypto.c
+++ b/block/blk-crypto.c
@@ -13,6 +13,7 @@
 #include <linux/blkdev.h>
 #include <linux/keyslot-manager.h>
 #include <linux/module.h>
+#include <linux/ratelimit.h>
 #include <linux/slab.h>
 
 #include "blk-crypto-internal.h"
@@ -216,26 +217,26 @@ static bool bio_crypt_check_alignment(struct bio *bio)
 	return true;
 }
 
-blk_status_t __blk_crypto_init_request(struct request *rq)
+blk_status_t __blk_crypto_rq_get_keyslot(struct request *rq)
 {
 	return blk_ksm_get_slot_for_key(rq->q->ksm, rq->crypt_ctx->bc_key,
 					&rq->crypt_keyslot);
 }
 
-/**
- * __blk_crypto_free_request - Uninitialize the crypto fields of a request.
- *
- * @rq: The request whose crypto fields to uninitialize.
- *
- * Completely uninitializes the crypto fields of a request. If a keyslot has
- * been programmed into some inline encryption hardware, that keyslot is
- * released. The rq->crypt_ctx is also freed.
- */
-void __blk_crypto_free_request(struct request *rq)
+void __blk_crypto_rq_put_keyslot(struct request *rq)
 {
 	blk_ksm_put_slot(rq->crypt_keyslot);
+	rq->crypt_keyslot = NULL;
+}
+
+void __blk_crypto_free_request(struct request *rq)
+{
+	/* The keyslot, if one was needed, should have been released earlier. */
+	if (WARN_ON_ONCE(rq->crypt_keyslot))
+		__blk_crypto_rq_put_keyslot(rq);
+
 	mempool_free(rq->crypt_ctx, bio_crypt_ctx_pool);
-	blk_crypto_rq_set_defaults(rq);
+	rq->crypt_ctx = NULL;
 }
 
 /**
@@ -384,28 +385,38 @@ int blk_crypto_start_using_key(const struct blk_crypto_key *key,
 }
 
 /**
- * blk_crypto_evict_key() - Evict a key from any inline encryption hardware
- *			    it may have been programmed into
- * @q: The request queue who's associated inline encryption hardware this key
- *     might have been programmed into
- * @key: The key to evict
+ * blk_crypto_evict_key() - Evict a blk_crypto_key from a request_queue
+ * @q: a request_queue on which I/O using the key may have been done
+ * @key: the key to evict
  *
- * Upper layers (filesystems) must call this function to ensure that a key is
- * evicted from any hardware that it might have been programmed into.  The key
- * must not be in use by any in-flight IO when this function is called.
+ * For a given request_queue, this function removes the given blk_crypto_key
+ * from the keyslot management structures and evicts it from any underlying
+ * hardware keyslot(s) or blk-crypto-fallback keyslot it may have been
+ * programmed into.
  *
- * Return: 0 on success or if key is not present in the q's ksm, -err on error.
+ * Upper layers must call this before freeing the blk_crypto_key.  It must be
+ * called for every request_queue the key may have been used on.  The key must
+ * no longer be in use by any I/O when this function is called.
+ *
+ * Context: May sleep.
  */
-int blk_crypto_evict_key(struct request_queue *q,
-			 const struct blk_crypto_key *key)
+void blk_crypto_evict_key(struct request_queue *q,
+			  const struct blk_crypto_key *key)
 {
-	if (blk_ksm_crypto_cfg_supported(q->ksm, &key->crypto_cfg))
-		return blk_ksm_evict_key(q->ksm, key);
+	int err;
 
+	if (blk_ksm_crypto_cfg_supported(q->ksm, &key->crypto_cfg))
+		err = blk_ksm_evict_key(q->ksm, key);
+	else
+		err = blk_crypto_fallback_evict_key(key);
 	/*
-	 * If the request queue's associated inline encryption hardware didn't
-	 * have support for the key, then the key might have been programmed
-	 * into the fallback keyslot manager, so try to evict from there.
+	 * An error can only occur here if the key failed to be evicted from a
+	 * keyslot (due to a hardware or driver issue) or is allegedly still in
+	 * use by I/O (due to a kernel bug).  Even in these cases, the key is
+	 * still unlinked from the keyslot management structures, and the caller
+	 * is allowed and expected to free it right away.  There's nothing
+	 * callers can do to handle errors, so just log them and return void.
 	 */
-	return blk_crypto_fallback_evict_key(key);
+	if (err)
+		pr_warn_ratelimited("error %d evicting key\n", err);
 }
diff --git a/block/blk-merge.c b/block/blk-merge.c
index fbba277364f0..f3b016b31af8 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -801,6 +801,8 @@ static struct request *attempt_merge(struct request_queue *q,
 	if (!blk_discard_mergable(req))
 		elv_merge_requests(q, req, next);
 
+	blk_crypto_rq_put_keyslot(next);
+
 	/*
 	 * 'next' is going away, so update stats accordingly
 	 */
diff --git a/block/blk-mq.c b/block/blk-mq.c
index cf66de0f00fd..e153a36c9ba3 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2193,7 +2193,7 @@ blk_qc_t blk_mq_submit_bio(struct bio *bio)
 
 	blk_mq_bio_to_request(rq, bio, nr_segs);
 
-	ret = blk_crypto_init_request(rq);
+	ret = blk_crypto_rq_get_keyslot(rq);
 	if (ret != BLK_STS_OK) {
 		bio->bi_status = ret;
 		bio_endio(bio);
diff --git a/block/keyslot-manager.c b/block/keyslot-manager.c
index 86f8195d8039..17a1f1ba44ef 100644
--- a/block/keyslot-manager.c
+++ b/block/keyslot-manager.c
@@ -305,44 +305,43 @@ bool blk_ksm_crypto_cfg_supported(struct blk_keyslot_manager *ksm,
 	return true;
 }
 
-/**
- * blk_ksm_evict_key() - Evict a key from the lower layer device.
- * @ksm: The keyslot manager to evict from
- * @key: The key to evict
- *
- * Find the keyslot that the specified key was programmed into, and evict that
- * slot from the lower layer device. The slot must not be in use by any
- * in-flight IO when this function is called.
- *
- * Context: Process context. Takes and releases ksm->lock.
- * Return: 0 on success or if there's no keyslot with the specified key, -EBUSY
- *	   if the keyslot is still in use, or another -errno value on other
- *	   error.
+/*
+ * This is an internal function that evicts a key from an inline encryption
+ * device that can be either a real device or the blk-crypto-fallback "device".
+ * It is used only by blk_crypto_evict_key(); see that function for details.
  */
 int blk_ksm_evict_key(struct blk_keyslot_manager *ksm,
 		      const struct blk_crypto_key *key)
 {
 	struct blk_ksm_keyslot *slot;
-	int err = 0;
+	int err;
 
 	blk_ksm_hw_enter(ksm);
 	slot = blk_ksm_find_keyslot(ksm, key);
-	if (!slot)
-		goto out_unlock;
+	if (!slot) {
+		/*
+		 * Not an error, since a key not in use by I/O is not guaranteed
+		 * to be in a keyslot.  There can be more keys than keyslots.
+		 */
+		err = 0;
+		goto out;
+	}
 
 	if (WARN_ON_ONCE(atomic_read(&slot->slot_refs) != 0)) {
+		/* BUG: key is still in use by I/O */
 		err = -EBUSY;
-		goto out_unlock;
+		goto out_remove;
 	}
 	err = ksm->ksm_ll_ops.keyslot_evict(ksm, key,
 					    blk_ksm_get_slot_idx(slot));
-	if (err)
-		goto out_unlock;
-
+out_remove:
+	/*
+	 * Callers free the key even on error, so unlink the key from the hash
+	 * table and clear slot->key even on error.
+	 */
 	hlist_del(&slot->hash_node);
 	slot->key = NULL;
-	err = 0;
-out_unlock:
+out:
 	blk_ksm_hw_exit(ksm);
 	return err;
 }
diff --git a/crypto/algapi.c b/crypto/algapi.c
index 9de27daa98b4..42dca17dc2d9 100644
--- a/crypto/algapi.c
+++ b/crypto/algapi.c
@@ -456,7 +456,9 @@ void crypto_unregister_alg(struct crypto_alg *alg)
 	if (WARN(ret, "Algorithm %s is not registered", alg->cra_driver_name))
 		return;
 
-	BUG_ON(refcount_read(&alg->cra_refcnt) != 1);
+	if (WARN_ON(refcount_read(&alg->cra_refcnt) != 1))
+		return;
+
 	if (alg->cra_destroy)
 		alg->cra_destroy(alg);
 
diff --git a/crypto/drbg.c b/crypto/drbg.c
index a4b5d6dbe99d..ba1fa5cdd90a 100644
--- a/crypto/drbg.c
+++ b/crypto/drbg.c
@@ -1515,6 +1515,14 @@ static int drbg_prepare_hrng(struct drbg_state *drbg)
 		return 0;
 
 	drbg->jent = crypto_alloc_rng("jitterentropy_rng", 0, 0);
+	if (IS_ERR(drbg->jent)) {
+		const int err = PTR_ERR(drbg->jent);
+
+		drbg->jent = NULL;
+		if (fips_enabled)
+			return err;
+		pr_info("DRBG: Continuing without Jitter RNG\n");
+	}
 
 	return 0;
 }
@@ -1570,14 +1578,6 @@ static int drbg_instantiate(struct drbg_state *drbg, struct drbg_string *pers,
 		if (ret)
 			goto free_everything;
 
-		if (IS_ERR(drbg->jent)) {
-			ret = PTR_ERR(drbg->jent);
-			drbg->jent = NULL;
-			if (fips_enabled || ret != -ENOENT)
-				goto free_everything;
-			pr_info("DRBG: Continuing without Jitter RNG\n");
-		}
-
 		reseed = false;
 	}
 
diff --git a/drivers/acpi/processor_pdc.c b/drivers/acpi/processor_pdc.c
index 813f1b78c16a..c0d2d9a2c0d5 100644
--- a/drivers/acpi/processor_pdc.c
+++ b/drivers/acpi/processor_pdc.c
@@ -14,6 +14,8 @@
 #include <linux/acpi.h>
 #include <acpi/processor.h>
 
+#include <xen/xen.h>
+
 #include "internal.h"
 
 #define _COMPONENT              ACPI_PROCESSOR_COMPONENT
@@ -50,6 +52,15 @@ static bool __init processor_physically_present(acpi_handle handle)
 		return false;
 	}
 
+	if (xen_initial_domain())
+		/*
+		 * When running as a Xen dom0 the number of processors Linux
+		 * sees can be different from the real number of processors on
+		 * the system, and we still need to execute _PDC for all of
+		 * them.
+		 */
+		return xen_processor_present(acpi_id);
+
 	type = (acpi_type == ACPI_TYPE_DEVICE) ? 1 : 0;
 	cpuid = acpi_get_cpuid(handle, type, acpi_id);
 
diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index 24dd532c8e5e..33e0526907eb 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -489,7 +489,8 @@ static const struct attribute_group *cpu_root_attr_groups[] = {
 bool cpu_is_hotpluggable(unsigned cpu)
 {
 	struct device *dev = get_cpu_device(cpu);
-	return dev && container_of(dev, struct cpu, dev)->hotpluggable;
+	return dev && container_of(dev, struct cpu, dev)->hotpluggable
+		&& tick_nohz_cpu_hotpluggable(cpu);
 }
 EXPORT_SYMBOL_GPL(cpu_is_hotpluggable);
 
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 497e3d4255c4..503c01d4015d 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -677,7 +677,12 @@ static int really_probe_debug(struct device *dev, struct device_driver *drv)
 	calltime = ktime_get();
 	ret = really_probe(dev, drv);
 	rettime = ktime_get();
-	pr_debug("probe of %s returned %d after %lld usecs\n",
+	/*
+	 * Don't change this to pr_debug() because that requires
+	 * CONFIG_DYNAMIC_DEBUG and we want a simple 'initcall_debug' on the
+	 * kernel commandline to print this all the time at the debug level.
+	 */
+	printk(KERN_DEBUG "probe of %s returned %d after %lld usecs\n",
 		 dev_name(dev), ret, ktime_us_delta(rettime, calltime));
 	return ret;
 }
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index dc333dbe5232..405e09575f08 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -1299,7 +1299,7 @@ static void submit_one_flush(struct drbd_device *device, struct issue_flush_cont
 	bio_set_dev(bio, device->ldev->backing_bdev);
 	bio->bi_private = octx;
 	bio->bi_end_io = one_flush_endio;
-	bio->bi_opf = REQ_OP_FLUSH | REQ_PREFLUSH;
+	bio->bi_opf = REQ_OP_WRITE | REQ_PREFLUSH;
 
 	device->flush_jif = jiffies;
 	set_bit(FLUSH_PENDING, &device->flags);
diff --git a/drivers/bluetooth/btsdio.c b/drivers/bluetooth/btsdio.c
index 7050a16e7efe..199e8f7d426d 100644
--- a/drivers/bluetooth/btsdio.c
+++ b/drivers/bluetooth/btsdio.c
@@ -352,7 +352,6 @@ static void btsdio_remove(struct sdio_func *func)
 
 	BT_DBG("func %p", func);
 
-	cancel_work_sync(&data->work);
 	if (!data)
 		return;
 
diff --git a/drivers/char/ipmi/Kconfig b/drivers/char/ipmi/Kconfig
index 07847d9a459a..f443186269e1 100644
--- a/drivers/char/ipmi/Kconfig
+++ b/drivers/char/ipmi/Kconfig
@@ -126,7 +126,8 @@ config NPCM7XX_KCS_IPMI_BMC
 
 config ASPEED_BT_IPMI_BMC
 	depends on ARCH_ASPEED || COMPILE_TEST
-	depends on REGMAP && REGMAP_MMIO && MFD_SYSCON
+	depends on MFD_SYSCON
+	select REGMAP_MMIO
 	tristate "BT IPMI bmc driver"
 	help
 	  Provides a driver for the BT (Block Transfer) IPMI interface
diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
index 20dc2452815c..a3745fa643f3 100644
--- a/drivers/char/ipmi/ipmi_ssif.c
+++ b/drivers/char/ipmi/ipmi_ssif.c
@@ -564,8 +564,10 @@ static void retry_timeout(struct timer_list *t)
 
 	if (waiting)
 		start_get(ssif_info);
-	if (resend)
+	if (resend) {
 		start_resend(ssif_info);
+		ssif_inc_stat(ssif_info, send_retries);
+	}
 }
 
 static void watch_timeout(struct timer_list *t)
@@ -792,9 +794,9 @@ static void msg_done_handler(struct ssif_info *ssif_info, int result,
 		} else if (data[0] != (IPMI_NETFN_APP_REQUEST | 1) << 2
 			   || data[1] != IPMI_GET_MSG_FLAGS_CMD) {
 			/*
-			 * Don't abort here, maybe it was a queued
-			 * response to a previous command.
+			 * Recv error response, give up.
 			 */
+			ssif_info->ssif_state = SSIF_IDLE;
 			ipmi_ssif_unlock_cond(ssif_info, flags);
 			dev_warn(&ssif_info->client->dev,
 				 "Invalid response getting flags: %x %x\n",
diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index dc56b976d816..d65fff4e2ebe 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -136,16 +136,27 @@ static bool check_locality(struct tpm_chip *chip, int l)
 	return false;
 }
 
-static int release_locality(struct tpm_chip *chip, int l)
+static int __tpm_tis_relinquish_locality(struct tpm_tis_data *priv, int l)
+{
+	tpm_tis_write8(priv, TPM_ACCESS(l), TPM_ACCESS_ACTIVE_LOCALITY);
+
+	return 0;
+}
+
+static int tpm_tis_relinquish_locality(struct tpm_chip *chip, int l)
 {
 	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
 
-	tpm_tis_write8(priv, TPM_ACCESS(l), TPM_ACCESS_ACTIVE_LOCALITY);
+	mutex_lock(&priv->locality_count_mutex);
+	priv->locality_count--;
+	if (priv->locality_count == 0)
+		__tpm_tis_relinquish_locality(priv, l);
+	mutex_unlock(&priv->locality_count_mutex);
 
 	return 0;
 }
 
-static int request_locality(struct tpm_chip *chip, int l)
+static int __tpm_tis_request_locality(struct tpm_chip *chip, int l)
 {
 	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
 	unsigned long stop, timeout;
@@ -186,6 +197,20 @@ static int request_locality(struct tpm_chip *chip, int l)
 	return -1;
 }
 
+static int tpm_tis_request_locality(struct tpm_chip *chip, int l)
+{
+	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
+	int ret = 0;
+
+	mutex_lock(&priv->locality_count_mutex);
+	if (priv->locality_count == 0)
+		ret = __tpm_tis_request_locality(chip, l);
+	if (!ret)
+		priv->locality_count++;
+	mutex_unlock(&priv->locality_count_mutex);
+	return ret;
+}
+
 static u8 tpm_tis_status(struct tpm_chip *chip)
 {
 	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
@@ -638,7 +663,7 @@ static int probe_itpm(struct tpm_chip *chip)
 	if (vendor != TPM_VID_INTEL)
 		return 0;
 
-	if (request_locality(chip, 0) != 0)
+	if (tpm_tis_request_locality(chip, 0) != 0)
 		return -EBUSY;
 
 	rc = tpm_tis_send_data(chip, cmd_getticks, len);
@@ -659,7 +684,7 @@ static int probe_itpm(struct tpm_chip *chip)
 
 out:
 	tpm_tis_ready(chip);
-	release_locality(chip, priv->locality);
+	tpm_tis_relinquish_locality(chip, priv->locality);
 
 	return rc;
 }
@@ -714,25 +739,17 @@ static irqreturn_t tis_int_handler(int dummy, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int tpm_tis_gen_interrupt(struct tpm_chip *chip)
+static void tpm_tis_gen_interrupt(struct tpm_chip *chip)
 {
 	const char *desc = "attempting to generate an interrupt";
 	u32 cap2;
 	cap_t cap;
 	int ret;
 
-	ret = request_locality(chip, 0);
-	if (ret < 0)
-		return ret;
-
 	if (chip->flags & TPM_CHIP_FLAG_TPM2)
 		ret = tpm2_get_tpm_pt(chip, 0x100, &cap2, desc);
 	else
 		ret = tpm1_getcap(chip, TPM_CAP_PROP_TIS_TIMEOUT, &cap, desc, 0);
-
-	release_locality(chip, 0);
-
-	return ret;
 }
 
 /* Register the IRQ and issue a command that will cause an interrupt. If an
@@ -755,52 +772,55 @@ static int tpm_tis_probe_irq_single(struct tpm_chip *chip, u32 intmask,
 	}
 	priv->irq = irq;
 
+	rc = tpm_tis_request_locality(chip, 0);
+	if (rc < 0)
+		return rc;
+
 	rc = tpm_tis_read8(priv, TPM_INT_VECTOR(priv->locality),
 			   &original_int_vec);
-	if (rc < 0)
+	if (rc < 0) {
+		tpm_tis_relinquish_locality(chip, priv->locality);
 		return rc;
+	}
 
 	rc = tpm_tis_write8(priv, TPM_INT_VECTOR(priv->locality), irq);
 	if (rc < 0)
-		return rc;
+		goto restore_irqs;
 
 	rc = tpm_tis_read32(priv, TPM_INT_STATUS(priv->locality), &int_status);
 	if (rc < 0)
-		return rc;
+		goto restore_irqs;
 
 	/* Clear all existing */
 	rc = tpm_tis_write32(priv, TPM_INT_STATUS(priv->locality), int_status);
 	if (rc < 0)
-		return rc;
-
+		goto restore_irqs;
 	/* Turn on */
 	rc = tpm_tis_write32(priv, TPM_INT_ENABLE(priv->locality),
 			     intmask | TPM_GLOBAL_INT_ENABLE);
 	if (rc < 0)
-		return rc;
+		goto restore_irqs;
 
 	priv->irq_tested = false;
 
 	/* Generate an interrupt by having the core call through to
 	 * tpm_tis_send
 	 */
-	rc = tpm_tis_gen_interrupt(chip);
-	if (rc < 0)
-		return rc;
+	tpm_tis_gen_interrupt(chip);
 
+restore_irqs:
 	/* tpm_tis_send will either confirm the interrupt is working or it
 	 * will call disable_irq which undoes all of the above.
 	 */
 	if (!(chip->flags & TPM_CHIP_FLAG_IRQ)) {
-		rc = tpm_tis_write8(priv, original_int_vec,
-				TPM_INT_VECTOR(priv->locality));
-		if (rc < 0)
-			return rc;
-
-		return 1;
+		tpm_tis_write8(priv, original_int_vec,
+			       TPM_INT_VECTOR(priv->locality));
+		rc = -1;
 	}
 
-	return 0;
+	tpm_tis_relinquish_locality(chip, priv->locality);
+
+	return rc;
 }
 
 /* Try to find the IRQ the TPM is using. This is for legacy x86 systems that
@@ -914,8 +934,8 @@ static const struct tpm_class_ops tpm_tis = {
 	.req_complete_mask = TPM_STS_DATA_AVAIL | TPM_STS_VALID,
 	.req_complete_val = TPM_STS_DATA_AVAIL | TPM_STS_VALID,
 	.req_canceled = tpm_tis_req_canceled,
-	.request_locality = request_locality,
-	.relinquish_locality = release_locality,
+	.request_locality = tpm_tis_request_locality,
+	.relinquish_locality = tpm_tis_relinquish_locality,
 	.clk_enable = tpm_tis_clkrun_enable,
 };
 
@@ -949,6 +969,8 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
 	priv->timeout_min = TPM_TIMEOUT_USECS_MIN;
 	priv->timeout_max = TPM_TIMEOUT_USECS_MAX;
 	priv->phy_ops = phy_ops;
+	priv->locality_count = 0;
+	mutex_init(&priv->locality_count_mutex);
 
 	dev_set_drvdata(&chip->dev, priv);
 
@@ -995,14 +1017,14 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
 		   TPM_INTF_DATA_AVAIL_INT | TPM_INTF_STS_VALID_INT;
 	intmask &= ~TPM_GLOBAL_INT_ENABLE;
 
-	rc = request_locality(chip, 0);
+	rc = tpm_tis_request_locality(chip, 0);
 	if (rc < 0) {
 		rc = -ENODEV;
 		goto out_err;
 	}
 
 	tpm_tis_write32(priv, TPM_INT_ENABLE(priv->locality), intmask);
-	release_locality(chip, 0);
+	tpm_tis_relinquish_locality(chip, 0);
 
 	rc = tpm_chip_start(chip);
 	if (rc)
@@ -1062,13 +1084,13 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
 		 * proper timeouts for the driver.
 		 */
 
-		rc = request_locality(chip, 0);
+		rc = tpm_tis_request_locality(chip, 0);
 		if (rc < 0)
 			goto out_err;
 
 		rc = tpm_get_timeouts(chip);
 
-		release_locality(chip, 0);
+		tpm_tis_relinquish_locality(chip, 0);
 
 		if (rc) {
 			dev_err(dev, "Could not get TPM timeouts and durations\n");
@@ -1076,17 +1098,21 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
 			goto out_err;
 		}
 
-		if (irq) {
+		if (irq)
 			tpm_tis_probe_irq_single(chip, intmask, IRQF_SHARED,
 						 irq);
-			if (!(chip->flags & TPM_CHIP_FLAG_IRQ)) {
-				dev_err(&chip->dev, FW_BUG
+		else
+			tpm_tis_probe_irq(chip, intmask);
+
+		if (!(chip->flags & TPM_CHIP_FLAG_IRQ)) {
+			dev_err(&chip->dev, FW_BUG
 					"TPM interrupt not working, polling instead\n");
 
-				disable_interrupts(chip);
-			}
-		} else {
-			tpm_tis_probe_irq(chip, intmask);
+			rc = tpm_tis_request_locality(chip, 0);
+			if (rc < 0)
+				goto out_err;
+			disable_interrupts(chip);
+			tpm_tis_relinquish_locality(chip, 0);
 		}
 	}
 
@@ -1147,28 +1173,27 @@ int tpm_tis_resume(struct device *dev)
 	struct tpm_chip *chip = dev_get_drvdata(dev);
 	int ret;
 
+	ret = tpm_tis_request_locality(chip, 0);
+	if (ret < 0)
+		return ret;
+
 	if (chip->flags & TPM_CHIP_FLAG_IRQ)
 		tpm_tis_reenable_interrupts(chip);
 
 	ret = tpm_pm_resume(dev);
 	if (ret)
-		return ret;
+		goto out;
 
 	/*
 	 * TPM 1.2 requires self-test on resume. This function actually returns
 	 * an error code but for unknown reason it isn't handled.
 	 */
-	if (!(chip->flags & TPM_CHIP_FLAG_TPM2)) {
-		ret = request_locality(chip, 0);
-		if (ret < 0)
-			return ret;
-
+	if (!(chip->flags & TPM_CHIP_FLAG_TPM2))
 		tpm1_do_selftest(chip);
+out:
+	tpm_tis_relinquish_locality(chip, 0);
 
-		release_locality(chip, 0);
-	}
-
-	return 0;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(tpm_tis_resume);
 #endif
diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_core.h
index 3be24f221e32..464ed352ab2e 100644
--- a/drivers/char/tpm/tpm_tis_core.h
+++ b/drivers/char/tpm/tpm_tis_core.h
@@ -90,6 +90,8 @@ enum tpm_tis_flags {
 
 struct tpm_tis_data {
 	u16 manufacturer_id;
+	struct mutex locality_count_mutex;
+	unsigned int locality_count;
 	int locality;
 	int irq;
 	bool irq_tested;
diff --git a/drivers/clk/at91/clk-sam9x60-pll.c b/drivers/clk/at91/clk-sam9x60-pll.c
index 5a9daa3643a7..5fe50ba173a8 100644
--- a/drivers/clk/at91/clk-sam9x60-pll.c
+++ b/drivers/clk/at91/clk-sam9x60-pll.c
@@ -452,7 +452,7 @@ sam9x60_clk_register_frac_pll(struct regmap *regmap, spinlock_t *lock,
 
 		ret = sam9x60_frac_pll_compute_mul_frac(&frac->core, FCORE_MIN,
 							parent_rate, true);
-		if (ret <= 0) {
+		if (ret < 0) {
 			hw = ERR_PTR(ret);
 			goto free;
 		}
diff --git a/drivers/clk/clk-conf.c b/drivers/clk/clk-conf.c
index 2ef819606c41..1a4e6340f95c 100644
--- a/drivers/clk/clk-conf.c
+++ b/drivers/clk/clk-conf.c
@@ -33,9 +33,12 @@ static int __set_clk_parents(struct device_node *node, bool clk_supplier)
 			else
 				return rc;
 		}
-		if (clkspec.np == node && !clk_supplier)
+		if (clkspec.np == node && !clk_supplier) {
+			of_node_put(clkspec.np);
 			return 0;
+		}
 		pclk = of_clk_get_from_provider(&clkspec);
+		of_node_put(clkspec.np);
 		if (IS_ERR(pclk)) {
 			if (PTR_ERR(pclk) != -EPROBE_DEFER)
 				pr_warn("clk: couldn't get parent clock %d for %pOF\n",
@@ -48,10 +51,12 @@ static int __set_clk_parents(struct device_node *node, bool clk_supplier)
 		if (rc < 0)
 			goto err;
 		if (clkspec.np == node && !clk_supplier) {
+			of_node_put(clkspec.np);
 			rc = 0;
 			goto err;
 		}
 		clk = of_clk_get_from_provider(&clkspec);
+		of_node_put(clkspec.np);
 		if (IS_ERR(clk)) {
 			if (PTR_ERR(clk) != -EPROBE_DEFER)
 				pr_warn("clk: couldn't get assigned clock %d for %pOF\n",
@@ -93,10 +98,13 @@ static int __set_clk_rates(struct device_node *node, bool clk_supplier)
 				else
 					return rc;
 			}
-			if (clkspec.np == node && !clk_supplier)
+			if (clkspec.np == node && !clk_supplier) {
+				of_node_put(clkspec.np);
 				return 0;
+			}
 
 			clk = of_clk_get_from_provider(&clkspec);
+			of_node_put(clkspec.np);
 			if (IS_ERR(clk)) {
 				if (PTR_ERR(clk) != -EPROBE_DEFER)
 					pr_warn("clk: couldn't get clock %d for %pOF\n",
diff --git a/drivers/clk/rockchip/clk-rk3399.c b/drivers/clk/rockchip/clk-rk3399.c
index 7df2f1e00347..a9cacbcc1c2a 100644
--- a/drivers/clk/rockchip/clk-rk3399.c
+++ b/drivers/clk/rockchip/clk-rk3399.c
@@ -1261,7 +1261,7 @@ static struct rockchip_clk_branch rk3399_clk_branches[] __initdata = {
 			RK3399_CLKSEL_CON(56), 6, 2, MFLAGS,
 			RK3399_CLKGATE_CON(10), 7, GFLAGS),
 
-	COMPOSITE_NOGATE(SCLK_CIF_OUT, "clk_cifout", mux_clk_cif_p, 0,
+	COMPOSITE_NOGATE(SCLK_CIF_OUT, "clk_cifout", mux_clk_cif_p, CLK_SET_RATE_PARENT,
 			 RK3399_CLKSEL_CON(56), 5, 1, MFLAGS, 0, 5, DFLAGS),
 
 	/* gic */
diff --git a/drivers/clocksource/timer-davinci.c b/drivers/clocksource/timer-davinci.c
index bb4eee31ae08..3dc0c6ceed02 100644
--- a/drivers/clocksource/timer-davinci.c
+++ b/drivers/clocksource/timer-davinci.c
@@ -258,21 +258,25 @@ int __init davinci_timer_register(struct clk *clk,
 				resource_size(&timer_cfg->reg),
 				"davinci-timer")) {
 		pr_err("Unable to request memory region\n");
-		return -EBUSY;
+		rv = -EBUSY;
+		goto exit_clk_disable;
 	}
 
 	base = ioremap(timer_cfg->reg.start, resource_size(&timer_cfg->reg));
 	if (!base) {
 		pr_err("Unable to map the register range\n");
-		return -ENOMEM;
+		rv = -ENOMEM;
+		goto exit_mem_region;
 	}
 
 	davinci_timer_init(base);
 	tick_rate = clk_get_rate(clk);
 
 	clockevent = kzalloc(sizeof(*clockevent), GFP_KERNEL);
-	if (!clockevent)
-		return -ENOMEM;
+	if (!clockevent) {
+		rv = -ENOMEM;
+		goto exit_iounmap_base;
+	}
 
 	clockevent->dev.name = "tim12";
 	clockevent->dev.features = CLOCK_EVT_FEAT_ONESHOT;
@@ -297,7 +301,7 @@ int __init davinci_timer_register(struct clk *clk,
 			 "clockevent/tim12", clockevent);
 	if (rv) {
 		pr_err("Unable to request the clockevent interrupt\n");
-		return rv;
+		goto exit_free_clockevent;
 	}
 
 	davinci_clocksource.dev.rating = 300;
@@ -324,13 +328,27 @@ int __init davinci_timer_register(struct clk *clk,
 	rv = clocksource_register_hz(&davinci_clocksource.dev, tick_rate);
 	if (rv) {
 		pr_err("Unable to register clocksource\n");
-		return rv;
+		goto exit_free_irq;
 	}
 
 	sched_clock_register(davinci_timer_read_sched_clock,
 			     DAVINCI_TIMER_CLKSRC_BITS, tick_rate);
 
 	return 0;
+
+exit_free_irq:
+	free_irq(timer_cfg->irq[DAVINCI_TIMER_CLOCKEVENT_IRQ].start,
+			clockevent);
+exit_free_clockevent:
+	kfree(clockevent);
+exit_iounmap_base:
+	iounmap(base);
+exit_mem_region:
+	release_mem_region(timer_cfg->reg.start,
+			   resource_size(&timer_cfg->reg));
+exit_clk_disable:
+	clk_disable_unprepare(clk);
+	return rv;
 }
 
 static int __init of_davinci_timer_register(struct device_node *np)
diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
index 21bb2bb767a1..89c9cb850a34 100644
--- a/drivers/counter/104-quad-8.c
+++ b/drivers/counter/104-quad-8.c
@@ -62,10 +62,6 @@ struct quad8_iio {
 #define QUAD8_REG_CHAN_OP 0x11
 #define QUAD8_REG_INDEX_INPUT_LEVELS 0x16
 #define QUAD8_DIFF_ENCODER_CABLE_STATUS 0x17
-/* Borrow Toggle flip-flop */
-#define QUAD8_FLAG_BT BIT(0)
-/* Carry Toggle flip-flop */
-#define QUAD8_FLAG_CT BIT(1)
 /* Error flag */
 #define QUAD8_FLAG_E BIT(4)
 /* Up/Down flag */
@@ -104,9 +100,6 @@ static int quad8_read_raw(struct iio_dev *indio_dev,
 {
 	struct quad8_iio *const priv = iio_priv(indio_dev);
 	const int base_offset = priv->base + 2 * chan->channel;
-	unsigned int flags;
-	unsigned int borrow;
-	unsigned int carry;
 	int i;
 
 	switch (mask) {
@@ -117,12 +110,7 @@ static int quad8_read_raw(struct iio_dev *indio_dev,
 			return IIO_VAL_INT;
 		}
 
-		flags = inb(base_offset + 1);
-		borrow = flags & QUAD8_FLAG_BT;
-		carry = !!(flags & QUAD8_FLAG_CT);
-
-		/* Borrow XOR Carry effectively doubles count range */
-		*val = (borrow ^ carry) << 24;
+		*val = 0;
 
 		mutex_lock(&priv->lock);
 
@@ -643,17 +631,9 @@ static int quad8_count_read(struct counter_device *counter,
 {
 	struct quad8_iio *const priv = counter->priv;
 	const int base_offset = priv->base + 2 * count->id;
-	unsigned int flags;
-	unsigned int borrow;
-	unsigned int carry;
 	int i;
 
-	flags = inb(base_offset + 1);
-	borrow = flags & QUAD8_FLAG_BT;
-	carry = !!(flags & QUAD8_FLAG_CT);
-
-	/* Borrow XOR Carry effectively doubles count range */
-	*val = (unsigned long)(borrow ^ carry) << 24;
+	*val = 0;
 
 	mutex_lock(&priv->lock);
 
@@ -1198,8 +1178,8 @@ static ssize_t quad8_count_ceiling_read(struct counter_device *counter,
 
 	mutex_unlock(&priv->lock);
 
-	/* By default 0x1FFFFFF (25 bits unsigned) is maximum count */
-	return sprintf(buf, "33554431\n");
+	/* By default 0xFFFFFF (24 bits unsigned) is maximum count */
+	return sprintf(buf, "16777215\n");
 }
 
 static ssize_t quad8_count_ceiling_write(struct counter_device *counter,
diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index 0a3dd0793f30..dbdee43c6ffc 100644
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -897,6 +897,7 @@ config CRYPTO_DEV_SA2UL
 	select CRYPTO_AES_ARM64
 	select CRYPTO_ALGAPI
 	select CRYPTO_AUTHENC
+	select CRYPTO_DES
 	select CRYPTO_SHA1
 	select CRYPTO_SHA256
 	select CRYPTO_SHA512
diff --git a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c
index 49c7a8b464dd..8a94f812e6d2 100644
--- a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c
+++ b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c
@@ -132,7 +132,7 @@ static int sun8i_ss_setup_ivs(struct skcipher_request *areq)
 		}
 		rctx->p_iv[i] = a;
 		/* we need to setup all others IVs only in the decrypt way */
-		if (rctx->op_dir & SS_ENCRYPTION)
+		if (rctx->op_dir == SS_ENCRYPTION)
 			return 0;
 		todo = min(len, sg_dma_len(sg));
 		len -= todo;
diff --git a/drivers/crypto/caam/ctrl.c b/drivers/crypto/caam/ctrl.c
index f87aa2169e5f..f9a1ec3c8485 100644
--- a/drivers/crypto/caam/ctrl.c
+++ b/drivers/crypto/caam/ctrl.c
@@ -284,6 +284,10 @@ static int instantiate_rng(struct device *ctrldev, int state_handle_mask,
 		const u32 rdsta_if = RDSTA_IF0 << sh_idx;
 		const u32 rdsta_pr = RDSTA_PR0 << sh_idx;
 		const u32 rdsta_mask = rdsta_if | rdsta_pr;
+
+		/* Clear the contents before using the descriptor */
+		memset(desc, 0x00, CAAM_CMD_SZ * 7);
+
 		/*
 		 * If the corresponding bit is set, this state handle
 		 * was initialized by somebody else, so it's left alone.
@@ -327,8 +331,6 @@ static int instantiate_rng(struct device *ctrldev, int state_handle_mask,
 		}
 
 		dev_info(ctrldev, "Instantiated RNG4 SH%d\n", sh_idx);
-		/* Clear the contents before recreating the descriptor */
-		memset(desc, 0x00, CAAM_CMD_SZ * 7);
 	}
 
 	kfree(desc);
diff --git a/drivers/crypto/ccp/psp-dev.c b/drivers/crypto/ccp/psp-dev.c
index ae7b44599914..4bf9eaab4456 100644
--- a/drivers/crypto/ccp/psp-dev.c
+++ b/drivers/crypto/ccp/psp-dev.c
@@ -42,6 +42,9 @@ static irqreturn_t psp_irq_handler(int irq, void *data)
 	/* Read the interrupt status: */
 	status = ioread32(psp->io_regs + psp->vdata->intsts_reg);
 
+	/* Clear the interrupt status by writing the same value we read. */
+	iowrite32(status, psp->io_regs + psp->vdata->intsts_reg);
+
 	/* invoke subdevice interrupt handlers */
 	if (status) {
 		if (psp->sev_irq_handler)
@@ -51,9 +54,6 @@ static irqreturn_t psp_irq_handler(int irq, void *data)
 			psp->tee_irq_handler(irq, psp->tee_irq_data, status);
 	}
 
-	/* Clear the interrupt status by writing the same value we read. */
-	iowrite32(status, psp->io_regs + psp->vdata->intsts_reg);
-
 	return IRQ_HANDLED;
 }
 
diff --git a/drivers/crypto/inside-secure/safexcel.c b/drivers/crypto/inside-secure/safexcel.c
index fbcf52e46d17..7de9b9d20de0 100644
--- a/drivers/crypto/inside-secure/safexcel.c
+++ b/drivers/crypto/inside-secure/safexcel.c
@@ -1634,19 +1634,23 @@ static int safexcel_probe_generic(void *pdev,
 						     &priv->ring[i].rdr);
 		if (ret) {
 			dev_err(dev, "Failed to initialize rings\n");
-			return ret;
+			goto err_cleanup_rings;
 		}
 
 		priv->ring[i].rdr_req = devm_kcalloc(dev,
 			EIP197_DEFAULT_RING_SIZE,
 			sizeof(*priv->ring[i].rdr_req),
 			GFP_KERNEL);
-		if (!priv->ring[i].rdr_req)
-			return -ENOMEM;
+		if (!priv->ring[i].rdr_req) {
+			ret = -ENOMEM;
+			goto err_cleanup_rings;
+		}
 
 		ring_irq = devm_kzalloc(dev, sizeof(*ring_irq), GFP_KERNEL);
-		if (!ring_irq)
-			return -ENOMEM;
+		if (!ring_irq) {
+			ret = -ENOMEM;
+			goto err_cleanup_rings;
+		}
 
 		ring_irq->priv = priv;
 		ring_irq->ring = i;
@@ -1660,7 +1664,8 @@ static int safexcel_probe_generic(void *pdev,
 						ring_irq);
 		if (irq < 0) {
 			dev_err(dev, "Failed to get IRQ ID for ring %d\n", i);
-			return irq;
+			ret = irq;
+			goto err_cleanup_rings;
 		}
 
 		priv->ring[i].irq = irq;
@@ -1672,8 +1677,10 @@ static int safexcel_probe_generic(void *pdev,
 		snprintf(wq_name, 9, "wq_ring%d", i);
 		priv->ring[i].workqueue =
 			create_singlethread_workqueue(wq_name);
-		if (!priv->ring[i].workqueue)
-			return -ENOMEM;
+		if (!priv->ring[i].workqueue) {
+			ret = -ENOMEM;
+			goto err_cleanup_rings;
+		}
 
 		priv->ring[i].requests = 0;
 		priv->ring[i].busy = false;
@@ -1690,16 +1697,26 @@ static int safexcel_probe_generic(void *pdev,
 	ret = safexcel_hw_init(priv);
 	if (ret) {
 		dev_err(dev, "HW init failed (%d)\n", ret);
-		return ret;
+		goto err_cleanup_rings;
 	}
 
 	ret = safexcel_register_algorithms(priv);
 	if (ret) {
 		dev_err(dev, "Failed to register algorithms (%d)\n", ret);
-		return ret;
+		goto err_cleanup_rings;
 	}
 
 	return 0;
+
+err_cleanup_rings:
+	for (i = 0; i < priv->config.rings; i++) {
+		if (priv->ring[i].irq)
+			irq_set_affinity_hint(priv->ring[i].irq, NULL);
+		if (priv->ring[i].workqueue)
+			destroy_workqueue(priv->ring[i].workqueue);
+	}
+
+	return ret;
 }
 
 static void safexcel_hw_reset_rings(struct safexcel_crypto_priv *priv)
diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index b5d691ae45dc..1fe006cc643e 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -212,6 +212,7 @@ struct at_xdmac {
 	int			irq;
 	struct clk		*clk;
 	u32			save_gim;
+	u32			save_gs;
 	struct dma_pool		*at_xdmac_desc_pool;
 	struct at_xdmac_chan	chan[];
 };
@@ -1910,6 +1911,7 @@ static int atmel_xdmac_suspend(struct device *dev)
 		}
 	}
 	atxdmac->save_gim = at_xdmac_read(atxdmac, AT_XDMAC_GIM);
+	atxdmac->save_gs = at_xdmac_read(atxdmac, AT_XDMAC_GS);
 
 	at_xdmac_off(atxdmac);
 	clk_disable_unprepare(atxdmac->clk);
@@ -1946,7 +1948,8 @@ static int atmel_xdmac_resume(struct device *dev)
 			at_xdmac_chan_write(atchan, AT_XDMAC_CNDC, atchan->save_cndc);
 			at_xdmac_chan_write(atchan, AT_XDMAC_CIE, atchan->save_cim);
 			wmb();
-			at_xdmac_write(atxdmac, AT_XDMAC_GE, atchan->mask);
+			if (atxdmac->save_gs & atchan->mask)
+				at_xdmac_write(atxdmac, AT_XDMAC_GE, atchan->mask);
 		}
 	}
 	return 0;
diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index d7ed50f8b929..f91dbf43a598 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -166,7 +166,7 @@ static void vchan_free_desc(struct virt_dma_desc *vdesc)
 	dw_edma_free_desc(vd2dw_edma_desc(vdesc));
 }
 
-static void dw_edma_start_transfer(struct dw_edma_chan *chan)
+static int dw_edma_start_transfer(struct dw_edma_chan *chan)
 {
 	struct dw_edma_chunk *child;
 	struct dw_edma_desc *desc;
@@ -174,16 +174,16 @@ static void dw_edma_start_transfer(struct dw_edma_chan *chan)
 
 	vd = vchan_next_desc(&chan->vc);
 	if (!vd)
-		return;
+		return 0;
 
 	desc = vd2dw_edma_desc(vd);
 	if (!desc)
-		return;
+		return 0;
 
 	child = list_first_entry_or_null(&desc->chunk->list,
 					 struct dw_edma_chunk, list);
 	if (!child)
-		return;
+		return 0;
 
 	dw_edma_v0_core_start(child, !desc->xfer_sz);
 	desc->xfer_sz += child->ll_region.sz;
@@ -191,6 +191,8 @@ static void dw_edma_start_transfer(struct dw_edma_chan *chan)
 	list_del(&child->list);
 	kfree(child);
 	desc->chunks_alloc--;
+
+	return 1;
 }
 
 static int dw_edma_device_config(struct dma_chan *dchan,
@@ -274,9 +276,12 @@ static void dw_edma_device_issue_pending(struct dma_chan *dchan)
 	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
 	unsigned long flags;
 
+	if (!chan->configured)
+		return;
+
 	spin_lock_irqsave(&chan->vc.lock, flags);
-	if (chan->configured && chan->request == EDMA_REQ_NONE &&
-	    chan->status == EDMA_ST_IDLE && vchan_issue_pending(&chan->vc)) {
+	if (vchan_issue_pending(&chan->vc) && chan->request == EDMA_REQ_NONE &&
+	    chan->status == EDMA_ST_IDLE) {
 		chan->status = EDMA_ST_BUSY;
 		dw_edma_start_transfer(chan);
 	}
@@ -497,14 +502,14 @@ static void dw_edma_done_interrupt(struct dw_edma_chan *chan)
 		switch (chan->request) {
 		case EDMA_REQ_NONE:
 			desc = vd2dw_edma_desc(vd);
-			if (desc->chunks_alloc) {
-				chan->status = EDMA_ST_BUSY;
-				dw_edma_start_transfer(chan);
-			} else {
+			if (!desc->chunks_alloc) {
 				list_del(&vd->node);
 				vchan_cookie_complete(vd);
-				chan->status = EDMA_ST_IDLE;
 			}
+
+			/* Continue transferring if there are remaining chunks or issued requests.
+			 */
+			chan->status = dw_edma_start_transfer(chan) ? EDMA_ST_BUSY : EDMA_ST_IDLE;
 			break;
 
 		case EDMA_REQ_STOP:
diff --git a/drivers/dma/mv_xor_v2.c b/drivers/dma/mv_xor_v2.c
index 4800c596433a..9f3e011fbd91 100644
--- a/drivers/dma/mv_xor_v2.c
+++ b/drivers/dma/mv_xor_v2.c
@@ -756,7 +756,7 @@ static int mv_xor_v2_probe(struct platform_device *pdev)
 
 	xor_dev->clk = devm_clk_get(&pdev->dev, NULL);
 	if (PTR_ERR(xor_dev->clk) == -EPROBE_DEFER) {
-		ret = EPROBE_DEFER;
+		ret = -EPROBE_DEFER;
 		goto disable_reg_clk;
 	}
 	if (!IS_ERR(xor_dev->clk)) {
diff --git a/drivers/edac/skx_base.c b/drivers/edac/skx_base.c
index f887e3166651..ba3e83313938 100644
--- a/drivers/edac/skx_base.c
+++ b/drivers/edac/skx_base.c
@@ -509,7 +509,7 @@ static bool skx_rir_decode(struct decoded_addr *res)
 }
 
 static u8 skx_close_row[] = {
-	15, 16, 17, 18, 20, 21, 22, 28, 10, 11, 12, 13, 29, 30, 31, 32, 33
+	15, 16, 17, 18, 20, 21, 22, 28, 10, 11, 12, 13, 29, 30, 31, 32, 33, 34
 };
 
 static u8 skx_close_column[] = {
@@ -517,7 +517,7 @@ static u8 skx_close_column[] = {
 };
 
 static u8 skx_open_row[] = {
-	14, 15, 16, 20, 28, 21, 22, 23, 24, 25, 26, 27, 29, 30, 31, 32, 33
+	14, 15, 16, 20, 28, 21, 22, 23, 24, 25, 26, 27, 29, 30, 31, 32, 33, 34
 };
 
 static u8 skx_open_column[] = {
diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
index d417199f8fe9..96086e7df910 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -1256,8 +1256,7 @@ static int qcom_scm_probe(struct platform_device *pdev)
 static void qcom_scm_shutdown(struct platform_device *pdev)
 {
 	/* Clean shutdown, disable download mode to allow normal restart */
-	if (download_mode)
-		qcom_scm_set_download_mode(false);
+	qcom_scm_set_download_mode(false);
 }
 
 static const struct of_device_id qcom_scm_dt_match[] = {
diff --git a/drivers/firmware/raspberrypi.c b/drivers/firmware/raspberrypi.c
index 9eef49da47e0..45ff03da234a 100644
--- a/drivers/firmware/raspberrypi.c
+++ b/drivers/firmware/raspberrypi.c
@@ -243,6 +243,13 @@ void rpi_firmware_put(struct rpi_firmware *fw)
 }
 EXPORT_SYMBOL_GPL(rpi_firmware_put);
 
+static void devm_rpi_firmware_put(void *data)
+{
+	struct rpi_firmware *fw = data;
+
+	rpi_firmware_put(fw);
+}
+
 static int rpi_firmware_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -338,6 +345,28 @@ struct rpi_firmware *rpi_firmware_get(struct device_node *firmware_node)
 }
 EXPORT_SYMBOL_GPL(rpi_firmware_get);
 
+/**
+ * devm_rpi_firmware_get - Get pointer to rpi_firmware structure.
+ * @firmware_node:    Pointer to the firmware Device Tree node.
+ *
+ * Returns NULL is the firmware device is not ready.
+ */
+struct rpi_firmware *devm_rpi_firmware_get(struct device *dev,
+					   struct device_node *firmware_node)
+{
+	struct rpi_firmware *fw;
+
+	fw = rpi_firmware_get(firmware_node);
+	if (!fw)
+		return NULL;
+
+	if (devm_add_action_or_reset(dev, devm_rpi_firmware_put, fw))
+		return NULL;
+
+	return fw;
+}
+EXPORT_SYMBOL_GPL(devm_rpi_firmware_get);
+
 static const struct of_device_id rpi_firmware_of_match[] = {
 	{ .compatible = "raspberrypi,bcm2835-firmware", },
 	{},
diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index 7dd0ac1a0cfc..78a446cb4348 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -989,8 +989,8 @@ static int stratix10_svc_drv_probe(struct platform_device *pdev)
 		return ret;
 
 	genpool = svc_create_memory_pool(pdev, sh_memory);
-	if (!genpool)
-		return -ENOMEM;
+	if (IS_ERR(genpool))
+		return PTR_ERR(genpool);
 
 	/* allocate service controller and supporting channel */
 	controller = devm_kzalloc(dev, sizeof(*controller), GFP_KERNEL);
diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
index 2deccacc3aa7..851debe32bf0 100644
--- a/drivers/fpga/fpga-bridge.c
+++ b/drivers/fpga/fpga-bridge.c
@@ -115,7 +115,7 @@ static int fpga_bridge_dev_match(struct device *dev, const void *data)
 /**
  * fpga_bridge_get - get an exclusive reference to a fpga bridge
  * @dev:	parent device that fpga bridge was registered with
- * @info:	fpga manager info
+ * @info:	fpga image specific information
  *
  * Given a device, get an exclusive reference to a fpga bridge.
  *
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
index 0da0a0d98672..15c0a3068eab 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
@@ -66,6 +66,7 @@ static int amdgpu_sched_process_priority_override(struct amdgpu_device *adev,
 {
 	struct fd f = fdget(fd);
 	struct amdgpu_fpriv *fpriv;
+	struct amdgpu_ctx_mgr *mgr;
 	struct amdgpu_ctx *ctx;
 	uint32_t id;
 	int r;
@@ -79,8 +80,11 @@ static int amdgpu_sched_process_priority_override(struct amdgpu_device *adev,
 		return r;
 	}
 
-	idr_for_each_entry(&fpriv->ctx_mgr.ctx_handles, ctx, id)
+	mgr = &fpriv->ctx_mgr;
+	mutex_lock(&mgr->lock);
+	idr_for_each_entry(&mgr->ctx_handles, ctx, id)
 		amdgpu_ctx_priority_override(ctx, priority);
+	mutex_unlock(&mgr->lock);
 
 	fdput(f);
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 38f4c7474487..629671f66b31 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -3943,7 +3943,8 @@ static int gfx_v9_0_hw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	amdgpu_irq_put(adev, &adev->gfx.cp_ecc_error_irq, 0);
+	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX))
+		amdgpu_irq_put(adev, &adev->gfx.cp_ecc_error_irq, 0);
 	amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
 	amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 1673bf3bae55..945cbdbc2f99 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1686,7 +1686,6 @@ static int gmc_v9_0_hw_fini(void *handle)
 		return 0;
 	}
 
-	amdgpu_irq_put(adev, &adev->gmc.ecc_irq, 0);
 	amdgpu_irq_put(adev, &adev->gmc.vm_fault, 0);
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 1f2e2460e121..dbcaef3f35da 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -1979,9 +1979,11 @@ static int sdma_v4_0_hw_fini(void *handle)
 	if (amdgpu_sriov_vf(adev))
 		return 0;
 
-	for (i = 0; i < adev->sdma.num_instances; i++) {
-		amdgpu_irq_put(adev, &adev->sdma.ecc_irq,
-			       AMDGPU_SDMA_IRQ_INSTANCE0 + i);
+	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__SDMA)) {
+		for (i = 0; i < adev->sdma.num_instances; i++) {
+			amdgpu_irq_put(adev, &adev->sdma.ecc_irq,
+				       AMDGPU_SDMA_IRQ_INSTANCE0 + i);
+		}
 	}
 
 	sdma_v4_0_ctx_switch_enable(adev, false);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index dbdf0e210522..3ca1ee396e4c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7248,6 +7248,8 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 			continue;
 
 		dc_plane = dm_new_plane_state->dc_state;
+		if (!dc_plane)
+			continue;
 
 		bundle->surface_updates[planes_count].surface = dc_plane;
 		if (new_pcrtc_state->color_mgmt_changed) {
@@ -8562,8 +8564,9 @@ static int dm_update_plane_state(struct dc *dc,
 			return -EINVAL;
 		}
 
+		if (dm_old_plane_state->dc_state)
+			dc_plane_state_release(dm_old_plane_state->dc_state);
 
-		dc_plane_state_release(dm_old_plane_state->dc_state);
 		dm_new_plane_state->dc_state = NULL;
 
 		*lock_and_validation_needed = true;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 1e47afc4ccc1..f1eda1a6496d 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -1502,6 +1502,9 @@ bool dc_remove_plane_from_context(
 	struct dc_stream_status *stream_status = NULL;
 	struct resource_pool *pool = dc->res_pool;
 
+	if (!plane_state)
+		return true;
+
 	for (i = 0; i < context->stream_count; i++)
 		if (context->streams[i] == stream) {
 			stream_status = &context->stream_status[i];
diff --git a/drivers/gpu/drm/bridge/adv7511/adv7533.c b/drivers/gpu/drm/bridge/adv7511/adv7533.c
index f304a5ff8e59..e0bdedf22390 100644
--- a/drivers/gpu/drm/bridge/adv7511/adv7533.c
+++ b/drivers/gpu/drm/bridge/adv7511/adv7533.c
@@ -103,22 +103,19 @@ void adv7533_dsi_power_off(struct adv7511 *adv)
 enum drm_mode_status adv7533_mode_valid(struct adv7511 *adv,
 					const struct drm_display_mode *mode)
 {
-	int lanes;
+	unsigned long max_lane_freq;
 	struct mipi_dsi_device *dsi = adv->dsi;
+	u8 bpp = mipi_dsi_pixel_format_to_bpp(dsi->format);
 
-	if (mode->clock > 80000)
-		lanes = 4;
-	else
-		lanes = 3;
-
-	/*
-	 * TODO: add support for dynamic switching of lanes
-	 * by using the bridge pre_enable() op . Till then filter
-	 * out the modes which shall need different number of lanes
-	 * than what was configured in the device tree.
-	 */
-	if (lanes != dsi->lanes)
-		return MODE_BAD;
+	/* Check max clock for either 7533 or 7535 */
+	if (mode->clock > (adv->type == ADV7533 ? 80000 : 148500))
+		return MODE_CLOCK_HIGH;
+
+	/* Check max clock for each lane */
+	max_lane_freq = (adv->type == ADV7533 ? 800000 : 891000);
+
+	if (mode->clock * bpp > max_lane_freq * adv->num_dsi_lanes)
+		return MODE_CLOCK_HIGH;
 
 	return MODE_OK;
 }
diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index ac5d61e65124..04f2ec2254e9 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -1299,6 +1299,9 @@ int drm_fb_helper_check_var(struct fb_var_screeninfo *var,
 		return -EINVAL;
 	}
 
+	var->xres_virtual = fb->width;
+	var->yres_virtual = fb->height;
+
 	/*
 	 * Workaround for SDL 1.2, which is known to be setting all pixel format
 	 * fields values to zero in some cases. We treat this situation as a
diff --git a/drivers/gpu/drm/drm_probe_helper.c b/drivers/gpu/drm/drm_probe_helper.c
index e5432dcf6999..d3f0d048594e 100644
--- a/drivers/gpu/drm/drm_probe_helper.c
+++ b/drivers/gpu/drm/drm_probe_helper.c
@@ -488,8 +488,9 @@ int drm_helper_probe_single_connector_modes(struct drm_connector *connector,
 		 */
 		dev->mode_config.delayed_event = true;
 		if (dev->mode_config.poll_enabled)
-			schedule_delayed_work(&dev->mode_config.output_poll_work,
-					      0);
+			mod_delayed_work(system_wq,
+					 &dev->mode_config.output_poll_work,
+					 0);
 	}
 
 	/* Re-enable polling in case the global poll config changed. */
diff --git a/drivers/gpu/drm/exynos/exynos5433_drm_decon.c b/drivers/gpu/drm/exynos/exynos5433_drm_decon.c
index 1f79bc2a881e..c277d2fc50c6 100644
--- a/drivers/gpu/drm/exynos/exynos5433_drm_decon.c
+++ b/drivers/gpu/drm/exynos/exynos5433_drm_decon.c
@@ -775,8 +775,8 @@ static int decon_conf_irq(struct decon_context *ctx, const char *name,
 			return irq;
 		}
 	}
-	irq_set_status_flags(irq, IRQ_NOAUTOEN);
-	ret = devm_request_irq(ctx->dev, irq, handler, flags, "drm_decon", ctx);
+	ret = devm_request_irq(ctx->dev, irq, handler,
+			       flags | IRQF_NO_AUTOEN, "drm_decon", ctx);
 	if (ret < 0) {
 		dev_err(ctx->dev, "IRQ %s request failed\n", name);
 		return ret;
diff --git a/drivers/gpu/drm/exynos/exynos_drm_dsi.c b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
index 5b9666fc7af1..afb03de2880f 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_dsi.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
@@ -1353,10 +1353,9 @@ static int exynos_dsi_register_te_irq(struct exynos_dsi *dsi,
 	}
 
 	te_gpio_irq = gpio_to_irq(dsi->te_gpio);
-	irq_set_status_flags(te_gpio_irq, IRQ_NOAUTOEN);
 
 	ret = request_threaded_irq(te_gpio_irq, exynos_dsi_te_irq_handler, NULL,
-					IRQF_TRIGGER_RISING, "TE", dsi);
+				   IRQF_TRIGGER_RISING | IRQF_NO_AUTOEN, "TE", dsi);
 	if (ret) {
 		dev_err(dsi->dev, "request interrupt failed with %d\n", ret);
 		gpio_free(dsi->te_gpio);
@@ -1802,9 +1801,9 @@ static int exynos_dsi_probe(struct platform_device *pdev)
 	if (dsi->irq < 0)
 		return dsi->irq;
 
-	irq_set_status_flags(dsi->irq, IRQ_NOAUTOEN);
 	ret = devm_request_threaded_irq(dev, dsi->irq, NULL,
-					exynos_dsi_irq, IRQF_ONESHOT,
+					exynos_dsi_irq,
+					IRQF_ONESHOT | IRQF_NO_AUTOEN,
 					dev_name(dev), dsi);
 	if (ret) {
 		dev_err(dev, "failed to request dsi irq\n");
diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
index d46011f7a838..9a06bd8cb200 100644
--- a/drivers/gpu/drm/i915/display/intel_display.c
+++ b/drivers/gpu/drm/i915/display/intel_display.c
@@ -5844,7 +5844,7 @@ intel_get_crtc_new_encoder(const struct intel_atomic_state *state,
 		num_encoders++;
 	}
 
-	drm_WARN(encoder->base.dev, num_encoders != 1,
+	drm_WARN(state->base.dev, num_encoders != 1,
 		 "%d encoders for pipe %c\n",
 		 num_encoders, pipe_name(crtc->pipe));
 
diff --git a/drivers/gpu/drm/lima/lima_drv.c b/drivers/gpu/drm/lima/lima_drv.c
index ab460121fd52..65dc0dc2c119 100644
--- a/drivers/gpu/drm/lima/lima_drv.c
+++ b/drivers/gpu/drm/lima/lima_drv.c
@@ -392,8 +392,10 @@ static int lima_pdev_probe(struct platform_device *pdev)
 
 	/* Allocate and initialize the DRM device. */
 	ddev = drm_dev_alloc(&lima_drm_driver, &pdev->dev);
-	if (IS_ERR(ddev))
-		return PTR_ERR(ddev);
+	if (IS_ERR(ddev)) {
+		err = PTR_ERR(ddev);
+		goto err_out0;
+	}
 
 	ddev->dev_private = ldev;
 	ldev->ddev = ddev;
diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
index 6f84db97e20e..0fcba2bc26b8 100644
--- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
@@ -1569,6 +1569,7 @@ struct msm_gpu *a5xx_gpu_init(struct drm_device *dev)
 	struct a5xx_gpu *a5xx_gpu = NULL;
 	struct adreno_gpu *adreno_gpu;
 	struct msm_gpu *gpu;
+	unsigned int nr_rings;
 	int ret;
 
 	if (!pdev) {
@@ -1589,7 +1590,12 @@ struct msm_gpu *a5xx_gpu_init(struct drm_device *dev)
 
 	check_speed_bin(&pdev->dev);
 
-	ret = adreno_gpu_init(dev, pdev, adreno_gpu, &funcs, 4);
+	nr_rings = 4;
+
+	if (adreno_is_a510(adreno_gpu))
+		nr_rings = 1;
+
+	ret = adreno_gpu_init(dev, pdev, adreno_gpu, &funcs, nr_rings);
 	if (ret) {
 		a5xx_destroy(&(a5xx_gpu->base.base));
 		return ERR_PTR(ret);
diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
index 58e03b20e1c7..760687f66ae5 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -301,8 +301,11 @@ struct msm_gpu *adreno_load_gpu(struct drm_device *dev)
 	if (ret)
 		return NULL;
 
-	/* Make sure pm runtime is active and reset any previous errors */
-	pm_runtime_set_active(&pdev->dev);
+	/*
+	 * Now that we have firmware loaded, and are ready to begin
+	 * booting the gpu, go ahead and enable runpm:
+	 */
+	pm_runtime_enable(&pdev->dev);
 
 	ret = pm_runtime_get_sync(&pdev->dev);
 	if (ret < 0) {
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index 78181e2d78a9..11a6a41b4910 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -916,7 +916,6 @@ int adreno_gpu_init(struct drm_device *drm, struct platform_device *pdev,
 	pm_runtime_set_autosuspend_delay(dev,
 		adreno_gpu->info->inactive_period);
 	pm_runtime_use_autosuspend(dev);
-	pm_runtime_enable(dev);
 
 	ret = msm_gpu_init(drm, pdev, &adreno_gpu->base, &funcs->base,
 			adreno_gpu->info->name, &adreno_gpu_config);
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index a0274fcfe9c9..408fc6c8a6df 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -634,7 +634,7 @@ static int dpu_encoder_virt_atomic_check(
 		if (drm_atomic_crtc_needs_modeset(crtc_state)) {
 			dpu_rm_release(global_state, drm_enc);
 
-			if (!crtc_state->active_changed || crtc_state->active)
+			if (!crtc_state->active_changed || crtc_state->enable)
 				ret = dpu_rm_reserve(&dpu_kms->rm, global_state,
 						drm_enc, crtc_state, topology);
 		}
diff --git a/drivers/gpu/drm/panel/panel-orisetech-otm8009a.c b/drivers/gpu/drm/panel/panel-orisetech-otm8009a.c
index 6ac1accade80..b19597b836e3 100644
--- a/drivers/gpu/drm/panel/panel-orisetech-otm8009a.c
+++ b/drivers/gpu/drm/panel/panel-orisetech-otm8009a.c
@@ -458,7 +458,7 @@ static int otm8009a_probe(struct mipi_dsi_device *dsi)
 		       DRM_MODE_CONNECTOR_DSI);
 
 	ctx->bl_dev = devm_backlight_device_register(dev, dev_name(dev),
-						     dsi->host->dev, ctx,
+						     dev, ctx,
 						     &otm8009a_backlight_ops,
 						     NULL);
 	if (IS_ERR(ctx->bl_dev)) {
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
index 62e5d0970525..22ff4a592976 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
@@ -250,9 +250,6 @@ static int rockchip_drm_gem_object_mmap(struct drm_gem_object *obj,
 	else
 		ret = rockchip_drm_gem_object_mmap_dma(obj, vma);
 
-	if (ret)
-		drm_gem_vm_close(vma);
-
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/vgem/vgem_fence.c b/drivers/gpu/drm/vgem/vgem_fence.c
index 17f32f550dd9..575bc331716e 100644
--- a/drivers/gpu/drm/vgem/vgem_fence.c
+++ b/drivers/gpu/drm/vgem/vgem_fence.c
@@ -249,4 +249,5 @@ void vgem_fence_close(struct vgem_file *vfile)
 {
 	idr_for_each(&vfile->fence_idr, __vgem_fence_idr_fini, vfile);
 	idr_destroy(&vfile->fence_idr);
+	mutex_destroy(&vfile->fence_mutex);
 }
diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index afb94b89fc4d..6c64165fae13 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1265,6 +1265,9 @@ static void wacom_intuos_pro2_bt_pen(struct wacom_wac *wacom)
 
 	struct input_dev *pen_input = wacom->pen_input;
 	unsigned char *data = wacom->data;
+	int number_of_valid_frames = 0;
+	int time_interval = 15000000;
+	ktime_t time_packet_received = ktime_get();
 	int i;
 
 	if (wacom->features.type == INTUOSP2_BT ||
@@ -1285,12 +1288,30 @@ static void wacom_intuos_pro2_bt_pen(struct wacom_wac *wacom)
 		wacom->id[0] |= (wacom->serial[0] >> 32) & 0xFFFFF;
 	}
 
+	/* number of valid frames */
 	for (i = 0; i < pen_frames; i++) {
 		unsigned char *frame = &data[i*pen_frame_len + 1];
 		bool valid = frame[0] & 0x80;
+
+		if (valid)
+			number_of_valid_frames++;
+	}
+
+	if (number_of_valid_frames) {
+		if (wacom->hid_data.time_delayed)
+			time_interval = ktime_get() - wacom->hid_data.time_delayed;
+		time_interval /= number_of_valid_frames;
+		wacom->hid_data.time_delayed = time_packet_received;
+	}
+
+	for (i = 0; i < number_of_valid_frames; i++) {
+		unsigned char *frame = &data[i*pen_frame_len + 1];
+		bool valid = frame[0] & 0x80;
 		bool prox = frame[0] & 0x40;
 		bool range = frame[0] & 0x20;
 		bool invert = frame[0] & 0x10;
+		int frames_number_reversed = number_of_valid_frames - i - 1;
+		int event_timestamp = time_packet_received - frames_number_reversed * time_interval;
 
 		if (!valid)
 			continue;
@@ -1303,6 +1324,7 @@ static void wacom_intuos_pro2_bt_pen(struct wacom_wac *wacom)
 			wacom->tool[0] = 0;
 			wacom->id[0] = 0;
 			wacom->serial[0] = 0;
+			wacom->hid_data.time_delayed = 0;
 			return;
 		}
 
@@ -1339,6 +1361,7 @@ static void wacom_intuos_pro2_bt_pen(struct wacom_wac *wacom)
 						 get_unaligned_le16(&frame[11]));
 			}
 		}
+
 		if (wacom->tool[0]) {
 			input_report_abs(pen_input, ABS_PRESSURE, get_unaligned_le16(&frame[5]));
 			if (wacom->features.type == INTUOSP2_BT ||
@@ -1362,6 +1385,9 @@ static void wacom_intuos_pro2_bt_pen(struct wacom_wac *wacom)
 
 		wacom->shared->stylus_in_proximity = prox;
 
+		/* add timestamp to unpack the frames */
+		input_set_timestamp(pen_input, event_timestamp);
+
 		input_sync(pen_input);
 	}
 }
@@ -1853,6 +1879,7 @@ static void wacom_map_usage(struct input_dev *input, struct hid_usage *usage,
 	int fmax = field->logical_maximum;
 	unsigned int equivalent_usage = wacom_equivalent_usage(usage->hid);
 	int resolution_code = code;
+	int resolution = hidinput_calc_abs_res(field, resolution_code);
 
 	if (equivalent_usage == HID_DG_TWIST) {
 		resolution_code = ABS_RZ;
@@ -1875,8 +1902,15 @@ static void wacom_map_usage(struct input_dev *input, struct hid_usage *usage,
 	switch (type) {
 	case EV_ABS:
 		input_set_abs_params(input, code, fmin, fmax, fuzz, 0);
-		input_abs_set_res(input, code,
-				  hidinput_calc_abs_res(field, resolution_code));
+
+		/* older tablet may miss physical usage */
+		if ((code == ABS_X || code == ABS_Y) && !resolution) {
+			resolution = WACOM_INTUOS_RES;
+			hid_warn(input,
+				 "Wacom usage (%d) missing resolution \n",
+				 code);
+		}
+		input_abs_set_res(input, code, resolution);
 		break;
 	case EV_KEY:
 		input_set_capability(input, EV_KEY, code);
diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
index ca172efcf072..88badfbae999 100644
--- a/drivers/hid/wacom_wac.h
+++ b/drivers/hid/wacom_wac.h
@@ -320,6 +320,7 @@ struct hid_data {
 	int bat_connected;
 	int ps_connected;
 	bool pad_input_event_flag;
+	int time_delayed;
 };
 
 struct wacom_remote_data {
diff --git a/drivers/hwmon/adt7475.c b/drivers/hwmon/adt7475.c
index 6b84822e7d93..22e314725def 100644
--- a/drivers/hwmon/adt7475.c
+++ b/drivers/hwmon/adt7475.c
@@ -1515,9 +1515,9 @@ static int adt7475_set_pwm_polarity(struct i2c_client *client)
 	int ret, i;
 	u8 val;
 
-	ret = of_property_read_u32_array(client->dev.of_node,
-					 "adi,pwm-active-state", states,
-					 ARRAY_SIZE(states));
+	ret = device_property_read_u32_array(&client->dev,
+					     "adi,pwm-active-state", states,
+					     ARRAY_SIZE(states));
 	if (ret)
 		return ret;
 
diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index 3bc2551577a3..74a67089ad07 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -74,6 +74,7 @@ static DEFINE_MUTEX(nb_smu_ind_mutex);
 
 #define ZEN_CUR_TEMP_SHIFT			21
 #define ZEN_CUR_TEMP_RANGE_SEL_MASK		BIT(19)
+#define ZEN_CUR_TEMP_TJ_SEL_MASK		GENMASK(17, 16)
 
 #define ZEN_SVI_BASE				0x0005A000
 
@@ -173,7 +174,8 @@ static long get_raw_temp(struct k10temp_data *data)
 
 	data->read_tempreg(data->pdev, &regval);
 	temp = (regval >> ZEN_CUR_TEMP_SHIFT) * 125;
-	if (regval & data->temp_adjust_mask)
+	if ((regval & data->temp_adjust_mask) ||
+	    (regval & ZEN_CUR_TEMP_TJ_SEL_MASK) == ZEN_CUR_TEMP_TJ_SEL_MASK)
 		temp -= 49000;
 	return temp;
 }
diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index bdc34ca449f7..c5698c62b610 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -619,6 +619,7 @@ int __init etm_perf_init(void)
 	etm_pmu.addr_filters_sync	= etm_addr_filters_sync;
 	etm_pmu.addr_filters_validate	= etm_addr_filters_validate;
 	etm_pmu.nr_addr_filters		= ETM_ADDR_CMP_MAX;
+	etm_pmu.module			= THIS_MODULE;
 
 	ret = perf_pmu_register(&etm_pmu, CORESIGHT_ETM_PMU_NAME, -1);
 	if (ret == 0)
diff --git a/drivers/i2c/busses/i2c-cadence.c b/drivers/i2c/busses/i2c-cadence.c
index 50928216b3f2..24987902ca59 100644
--- a/drivers/i2c/busses/i2c-cadence.c
+++ b/drivers/i2c/busses/i2c-cadence.c
@@ -792,8 +792,10 @@ static int cdns_i2c_master_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
 #if IS_ENABLED(CONFIG_I2C_SLAVE)
 	/* Check i2c operating mode and switch if possible */
 	if (id->dev_mode == CDNS_I2C_MODE_SLAVE) {
-		if (id->slave_state != CDNS_I2C_SLAVE_STATE_IDLE)
-			return -EAGAIN;
+		if (id->slave_state != CDNS_I2C_SLAVE_STATE_IDLE) {
+			ret = -EAGAIN;
+			goto out;
+		}
 
 		/* Set mode to master */
 		cdns_i2c_set_mode(CDNS_I2C_MODE_MASTER, id);
diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index d4f6c6d60683..8955f62b497e 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1058,7 +1058,7 @@ omap_i2c_isr(int irq, void *dev_id)
 	u16 stat;
 
 	stat = omap_i2c_read_reg(omap, OMAP_I2C_STAT_REG);
-	mask = omap_i2c_read_reg(omap, OMAP_I2C_IE_REG);
+	mask = omap_i2c_read_reg(omap, OMAP_I2C_IE_REG) & ~OMAP_I2C_STAT_NACK;
 
 	if (stat & mask)
 		ret = IRQ_WAKE_THREAD;
diff --git a/drivers/iio/adc/palmas_gpadc.c b/drivers/iio/adc/palmas_gpadc.c
index f4756671cddb..6ed0d151ad21 100644
--- a/drivers/iio/adc/palmas_gpadc.c
+++ b/drivers/iio/adc/palmas_gpadc.c
@@ -628,7 +628,7 @@ static int palmas_gpadc_probe(struct platform_device *pdev)
 
 static int palmas_gpadc_remove(struct platform_device *pdev)
 {
-	struct iio_dev *indio_dev = dev_to_iio_dev(&pdev->dev);
+	struct iio_dev *indio_dev = dev_get_drvdata(&pdev->dev);
 	struct palmas_gpadc *adc = iio_priv(indio_dev);
 
 	if (adc->wakeup1_enable || adc->wakeup2_enable)
diff --git a/drivers/iio/light/max44009.c b/drivers/iio/light/max44009.c
index 801e5a0ad496..f3648f20ef2c 100644
--- a/drivers/iio/light/max44009.c
+++ b/drivers/iio/light/max44009.c
@@ -528,6 +528,12 @@ static int max44009_probe(struct i2c_client *client,
 	return devm_iio_device_register(&client->dev, indio_dev);
 }
 
+static const struct of_device_id max44009_of_match[] = {
+	{ .compatible = "maxim,max44009" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, max44009_of_match);
+
 static const struct i2c_device_id max44009_id[] = {
 	{ "max44009", 0 },
 	{ }
@@ -537,18 +543,13 @@ MODULE_DEVICE_TABLE(i2c, max44009_id);
 static struct i2c_driver max44009_driver = {
 	.driver = {
 		.name = MAX44009_DRV_NAME,
+		.of_match_table = max44009_of_match,
 	},
 	.probe = max44009_probe,
 	.id_table = max44009_id,
 };
 module_i2c_driver(max44009_driver);
 
-static const struct of_device_id max44009_of_match[] = {
-	{ .compatible = "maxim,max44009" },
-	{ }
-};
-MODULE_DEVICE_TABLE(of, max44009_of_match);
-
 MODULE_AUTHOR("Robert Eshleman <bobbyeshleman@gmail.com>");
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("MAX44009 ambient light sensor driver");
diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 3133b6be6cab..db1a25fbe2fa 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -2924,6 +2924,8 @@ static int cm_send_rej_locked(struct cm_id_private *cm_id_priv,
 	    (ari && ari_length > IB_CM_REJ_ARI_LENGTH))
 		return -EINVAL;
 
+	trace_icm_send_rej(&cm_id_priv->id, reason);
+
 	switch (state) {
 	case IB_CM_REQ_SENT:
 	case IB_CM_MRA_REQ_RCVD:
@@ -2954,7 +2956,6 @@ static int cm_send_rej_locked(struct cm_id_private *cm_id_priv,
 		return -EINVAL;
 	}
 
-	trace_icm_send_rej(&cm_id_priv->id, reason);
 	ret = ib_post_send_mad(msg, NULL);
 	if (ret) {
 		cm_free_msg(msg);
diff --git a/drivers/infiniband/hw/hfi1/ipoib_tx.c b/drivers/infiniband/hw/hfi1/ipoib_tx.c
index ab1eefffc14b..956fc3fd88b9 100644
--- a/drivers/infiniband/hw/hfi1/ipoib_tx.c
+++ b/drivers/infiniband/hw/hfi1/ipoib_tx.c
@@ -15,6 +15,7 @@
 #include "verbs.h"
 #include "trace_ibhdrs.h"
 #include "ipoib.h"
+#include "trace_tx.h"
 
 /* Add a convenience helper */
 #define CIRC_ADD(val, add, size) (((val) + (add)) & ((size) - 1))
@@ -63,12 +64,14 @@ static u64 hfi1_ipoib_used(struct hfi1_ipoib_txq *txq)
 
 static void hfi1_ipoib_stop_txq(struct hfi1_ipoib_txq *txq)
 {
+	trace_hfi1_txq_stop(txq);
 	if (atomic_inc_return(&txq->stops) == 1)
 		netif_stop_subqueue(txq->priv->netdev, txq->q_idx);
 }
 
 static void hfi1_ipoib_wake_txq(struct hfi1_ipoib_txq *txq)
 {
+	trace_hfi1_txq_wake(txq);
 	if (atomic_dec_and_test(&txq->stops))
 		netif_wake_subqueue(txq->priv->netdev, txq->q_idx);
 }
@@ -89,8 +92,10 @@ static void hfi1_ipoib_check_queue_depth(struct hfi1_ipoib_txq *txq)
 {
 	++txq->sent_txreqs;
 	if (hfi1_ipoib_used(txq) >= hfi1_ipoib_ring_hwat(txq) &&
-	    !atomic_xchg(&txq->ring_full, 1))
+	    !atomic_xchg(&txq->ring_full, 1)) {
+		trace_hfi1_txq_full(txq);
 		hfi1_ipoib_stop_txq(txq);
+	}
 }
 
 static void hfi1_ipoib_check_queue_stopped(struct hfi1_ipoib_txq *txq)
@@ -112,8 +117,10 @@ static void hfi1_ipoib_check_queue_stopped(struct hfi1_ipoib_txq *txq)
 	 * to protect against ring overflow.
 	 */
 	if (hfi1_ipoib_used(txq) < hfi1_ipoib_ring_lwat(txq) &&
-	    atomic_xchg(&txq->ring_full, 0))
+	    atomic_xchg(&txq->ring_full, 0)) {
+		trace_hfi1_txq_xmit_unstopped(txq);
 		hfi1_ipoib_wake_txq(txq);
+	}
 }
 
 static void hfi1_ipoib_free_tx(struct ipoib_txreq *tx, int budget)
@@ -244,6 +251,7 @@ static int hfi1_ipoib_build_ulp_payload(struct ipoib_txreq *tx,
 		const skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
 
 		ret = sdma_txadd_page(dd,
+				      NULL,
 				      txreq,
 				      skb_frag_page(frag),
 				      frag->bv_offset,
@@ -405,6 +413,7 @@ static struct ipoib_txreq *hfi1_ipoib_send_dma_common(struct net_device *dev,
 				sdma_select_engine_sc(priv->dd,
 						      txp->flow.tx_queue,
 						      txp->flow.sc5);
+			trace_hfi1_flow_switch(txp->txq);
 		}
 
 		return tx;
@@ -525,6 +534,7 @@ static int hfi1_ipoib_send_dma_list(struct net_device *dev,
 	if (txq->flow.as_int != txp->flow.as_int) {
 		int ret;
 
+		trace_hfi1_flow_flush(txq);
 		ret = hfi1_ipoib_flush_tx_list(dev, txq);
 		if (unlikely(ret)) {
 			if (ret == -EBUSY)
@@ -635,8 +645,10 @@ static int hfi1_ipoib_sdma_sleep(struct sdma_engine *sde,
 			/* came from non-list submit */
 			list_add_tail(&txreq->list, &txq->tx_list);
 		if (list_empty(&txq->wait.list)) {
-			if (!atomic_xchg(&txq->no_desc, 1))
+			if (!atomic_xchg(&txq->no_desc, 1)) {
+				trace_hfi1_txq_queued(txq);
 				hfi1_ipoib_stop_txq(txq);
+			}
 			iowait_queue(pkts_sent, wait->iow, &sde->dmawait);
 		}
 
@@ -659,6 +671,7 @@ static void hfi1_ipoib_sdma_wakeup(struct iowait *wait, int reason)
 	struct hfi1_ipoib_txq *txq =
 		container_of(wait, struct hfi1_ipoib_txq, wait);
 
+	trace_hfi1_txq_wakeup(txq);
 	if (likely(txq->priv->netdev->reg_state == NETREG_REGISTERED))
 		iowait_schedule(wait, system_highpri_wq, WORK_CPU_UNBOUND);
 }
diff --git a/drivers/infiniband/hw/hfi1/mmu_rb.c b/drivers/infiniband/hw/hfi1/mmu_rb.c
index ed8a96ae61ce..d331184ded30 100644
--- a/drivers/infiniband/hw/hfi1/mmu_rb.c
+++ b/drivers/infiniband/hw/hfi1/mmu_rb.c
@@ -167,11 +167,11 @@ int hfi1_mmu_rb_insert(struct mmu_rb_handler *handler,
 	spin_lock_irqsave(&handler->lock, flags);
 	node = __mmu_rb_search(handler, mnode->addr, mnode->len);
 	if (node) {
-		ret = -EINVAL;
+		ret = -EEXIST;
 		goto unlock;
 	}
 	__mmu_int_rb_insert(mnode, &handler->root);
-	list_add(&mnode->list, &handler->lru_list);
+	list_add_tail(&mnode->list, &handler->lru_list);
 
 	ret = handler->ops->insert(handler->ops_arg, mnode);
 	if (ret) {
@@ -184,6 +184,19 @@ int hfi1_mmu_rb_insert(struct mmu_rb_handler *handler,
 	return ret;
 }
 
+/* Caller must hold handler lock */
+struct mmu_rb_node *hfi1_mmu_rb_get_first(struct mmu_rb_handler *handler,
+					  unsigned long addr, unsigned long len)
+{
+	struct mmu_rb_node *node;
+
+	trace_hfi1_mmu_rb_search(addr, len);
+	node = __mmu_int_rb_iter_first(&handler->root, addr, (addr + len) - 1);
+	if (node)
+		list_move_tail(&node->list, &handler->lru_list);
+	return node;
+}
+
 /* Caller must hold handler lock */
 static struct mmu_rb_node *__mmu_rb_search(struct mmu_rb_handler *handler,
 					   unsigned long addr,
@@ -208,32 +221,6 @@ static struct mmu_rb_node *__mmu_rb_search(struct mmu_rb_handler *handler,
 	return node;
 }
 
-bool hfi1_mmu_rb_remove_unless_exact(struct mmu_rb_handler *handler,
-				     unsigned long addr, unsigned long len,
-				     struct mmu_rb_node **rb_node)
-{
-	struct mmu_rb_node *node;
-	unsigned long flags;
-	bool ret = false;
-
-	if (current->mm != handler->mn.mm)
-		return ret;
-
-	spin_lock_irqsave(&handler->lock, flags);
-	node = __mmu_rb_search(handler, addr, len);
-	if (node) {
-		if (node->addr == addr && node->len == len)
-			goto unlock;
-		__mmu_int_rb_remove(node, &handler->root);
-		list_del(&node->list); /* remove from LRU list */
-		ret = true;
-	}
-unlock:
-	spin_unlock_irqrestore(&handler->lock, flags);
-	*rb_node = node;
-	return ret;
-}
-
 void hfi1_mmu_rb_evict(struct mmu_rb_handler *handler, void *evict_arg)
 {
 	struct mmu_rb_node *rbnode, *ptr;
@@ -247,8 +234,7 @@ void hfi1_mmu_rb_evict(struct mmu_rb_handler *handler, void *evict_arg)
 	INIT_LIST_HEAD(&del_list);
 
 	spin_lock_irqsave(&handler->lock, flags);
-	list_for_each_entry_safe_reverse(rbnode, ptr, &handler->lru_list,
-					 list) {
+	list_for_each_entry_safe(rbnode, ptr, &handler->lru_list, list) {
 		if (handler->ops->evict(handler->ops_arg, rbnode, evict_arg,
 					&stop)) {
 			__mmu_int_rb_remove(rbnode, &handler->root);
@@ -260,36 +246,11 @@ void hfi1_mmu_rb_evict(struct mmu_rb_handler *handler, void *evict_arg)
 	}
 	spin_unlock_irqrestore(&handler->lock, flags);
 
-	while (!list_empty(&del_list)) {
-		rbnode = list_first_entry(&del_list, struct mmu_rb_node, list);
-		list_del(&rbnode->list);
+	list_for_each_entry_safe(rbnode, ptr, &del_list, list) {
 		handler->ops->remove(handler->ops_arg, rbnode);
 	}
 }
 
-/*
- * It is up to the caller to ensure that this function does not race with the
- * mmu invalidate notifier which may be calling the users remove callback on
- * 'node'.
- */
-void hfi1_mmu_rb_remove(struct mmu_rb_handler *handler,
-			struct mmu_rb_node *node)
-{
-	unsigned long flags;
-
-	if (current->mm != handler->mn.mm)
-		return;
-
-	/* Validity of handler and node pointers has been checked by caller. */
-	trace_hfi1_mmu_rb_remove(node->addr, node->len);
-	spin_lock_irqsave(&handler->lock, flags);
-	__mmu_int_rb_remove(node, &handler->root);
-	list_del(&node->list); /* remove from LRU list */
-	spin_unlock_irqrestore(&handler->lock, flags);
-
-	handler->ops->remove(handler->ops_arg, node);
-}
-
 static int mmu_notifier_range_start(struct mmu_notifier *mn,
 		const struct mmu_notifier_range *range)
 {
diff --git a/drivers/infiniband/hw/hfi1/mmu_rb.h b/drivers/infiniband/hw/hfi1/mmu_rb.h
index 423aacc67e94..0265d81c6206 100644
--- a/drivers/infiniband/hw/hfi1/mmu_rb.h
+++ b/drivers/infiniband/hw/hfi1/mmu_rb.h
@@ -93,10 +93,8 @@ void hfi1_mmu_rb_unregister(struct mmu_rb_handler *handler);
 int hfi1_mmu_rb_insert(struct mmu_rb_handler *handler,
 		       struct mmu_rb_node *mnode);
 void hfi1_mmu_rb_evict(struct mmu_rb_handler *handler, void *evict_arg);
-void hfi1_mmu_rb_remove(struct mmu_rb_handler *handler,
-			struct mmu_rb_node *mnode);
-bool hfi1_mmu_rb_remove_unless_exact(struct mmu_rb_handler *handler,
-				     unsigned long addr, unsigned long len,
-				     struct mmu_rb_node **rb_node);
+struct mmu_rb_node *hfi1_mmu_rb_get_first(struct mmu_rb_handler *handler,
+					  unsigned long addr,
+					  unsigned long len);
 
 #endif /* _HFI1_MMU_RB_H */
diff --git a/drivers/infiniband/hw/hfi1/sdma.c b/drivers/infiniband/hw/hfi1/sdma.c
index a044bee257f9..061562627dae 100644
--- a/drivers/infiniband/hw/hfi1/sdma.c
+++ b/drivers/infiniband/hw/hfi1/sdma.c
@@ -1635,22 +1635,7 @@ static inline void sdma_unmap_desc(
 	struct hfi1_devdata *dd,
 	struct sdma_desc *descp)
 {
-	switch (sdma_mapping_type(descp)) {
-	case SDMA_MAP_SINGLE:
-		dma_unmap_single(
-			&dd->pcidev->dev,
-			sdma_mapping_addr(descp),
-			sdma_mapping_len(descp),
-			DMA_TO_DEVICE);
-		break;
-	case SDMA_MAP_PAGE:
-		dma_unmap_page(
-			&dd->pcidev->dev,
-			sdma_mapping_addr(descp),
-			sdma_mapping_len(descp),
-			DMA_TO_DEVICE);
-		break;
-	}
+	system_descriptor_complete(dd, descp);
 }
 
 /*
@@ -3170,7 +3155,7 @@ int ext_coal_sdma_tx_descs(struct hfi1_devdata *dd, struct sdma_txreq *tx,
 
 		/* Add descriptor for coalesce buffer */
 		tx->desc_limit = MAX_DESC;
-		return _sdma_txadd_daddr(dd, SDMA_MAP_SINGLE, tx,
+		return _sdma_txadd_daddr(dd, SDMA_MAP_SINGLE, NULL, tx,
 					 addr, tx->tlen);
 	}
 
@@ -3210,10 +3195,12 @@ int _pad_sdma_tx_descs(struct hfi1_devdata *dd, struct sdma_txreq *tx)
 			return rval;
 		}
 	}
+
 	/* finish the one just added */
 	make_tx_sdma_desc(
 		tx,
 		SDMA_MAP_NONE,
+		NULL,
 		dd->sdma_pad_phys,
 		sizeof(u32) - (tx->packet_len & (sizeof(u32) - 1)));
 	_sdma_close_tx(dd, tx);
diff --git a/drivers/infiniband/hw/hfi1/sdma.h b/drivers/infiniband/hw/hfi1/sdma.h
index 7a851191f987..7d4f316ac6e4 100644
--- a/drivers/infiniband/hw/hfi1/sdma.h
+++ b/drivers/infiniband/hw/hfi1/sdma.h
@@ -635,6 +635,7 @@ static inline dma_addr_t sdma_mapping_addr(struct sdma_desc *d)
 static inline void make_tx_sdma_desc(
 	struct sdma_txreq *tx,
 	int type,
+	void *pinning_ctx,
 	dma_addr_t addr,
 	size_t len)
 {
@@ -653,6 +654,7 @@ static inline void make_tx_sdma_desc(
 				<< SDMA_DESC0_PHY_ADDR_SHIFT) |
 			(((u64)len & SDMA_DESC0_BYTE_COUNT_MASK)
 				<< SDMA_DESC0_BYTE_COUNT_SHIFT);
+	desc->pinning_ctx = pinning_ctx;
 }
 
 /* helper to extend txreq */
@@ -685,6 +687,7 @@ static inline void _sdma_close_tx(struct hfi1_devdata *dd,
 static inline int _sdma_txadd_daddr(
 	struct hfi1_devdata *dd,
 	int type,
+	void *pinning_ctx,
 	struct sdma_txreq *tx,
 	dma_addr_t addr,
 	u16 len)
@@ -694,6 +697,7 @@ static inline int _sdma_txadd_daddr(
 	make_tx_sdma_desc(
 		tx,
 		type,
+		pinning_ctx,
 		addr, len);
 	WARN_ON(len > tx->tlen);
 	tx->tlen -= len;
@@ -714,6 +718,7 @@ static inline int _sdma_txadd_daddr(
 /**
  * sdma_txadd_page() - add a page to the sdma_txreq
  * @dd: the device to use for mapping
+ * @pinning_ctx: context to be released at descriptor retirement
  * @tx: tx request to which the page is added
  * @page: page to map
  * @offset: offset within the page
@@ -729,6 +734,7 @@ static inline int _sdma_txadd_daddr(
  */
 static inline int sdma_txadd_page(
 	struct hfi1_devdata *dd,
+	void *pinning_ctx,
 	struct sdma_txreq *tx,
 	struct page *page,
 	unsigned long offset,
@@ -756,8 +762,7 @@ static inline int sdma_txadd_page(
 		return -ENOSPC;
 	}
 
-	return _sdma_txadd_daddr(
-			dd, SDMA_MAP_PAGE, tx, addr, len);
+	return _sdma_txadd_daddr(dd, SDMA_MAP_PAGE, pinning_ctx, tx, addr, len);
 }
 
 /**
@@ -791,7 +796,8 @@ static inline int sdma_txadd_daddr(
 			return rval;
 	}
 
-	return _sdma_txadd_daddr(dd, SDMA_MAP_NONE, tx, addr, len);
+	return _sdma_txadd_daddr(dd, SDMA_MAP_NONE, NULL, tx,
+				 addr, len);
 }
 
 /**
@@ -837,8 +843,7 @@ static inline int sdma_txadd_kvaddr(
 		return -ENOSPC;
 	}
 
-	return _sdma_txadd_daddr(
-			dd, SDMA_MAP_SINGLE, tx, addr, len);
+	return _sdma_txadd_daddr(dd, SDMA_MAP_SINGLE, NULL, tx, addr, len);
 }
 
 struct iowait_work;
@@ -1090,4 +1095,5 @@ extern uint mod_num_sdma;
 
 void sdma_update_lmc(struct hfi1_devdata *dd, u64 mask, u32 lid);
 
+void system_descriptor_complete(struct hfi1_devdata *dd, struct sdma_desc *descp);
 #endif
diff --git a/drivers/infiniband/hw/hfi1/sdma_txreq.h b/drivers/infiniband/hw/hfi1/sdma_txreq.h
index 514a4784566b..4204650cebc2 100644
--- a/drivers/infiniband/hw/hfi1/sdma_txreq.h
+++ b/drivers/infiniband/hw/hfi1/sdma_txreq.h
@@ -61,6 +61,7 @@
 struct sdma_desc {
 	/* private:  don't use directly */
 	u64 qw[2];
+	void *pinning_ctx;
 };
 
 /**
diff --git a/drivers/infiniband/hw/hfi1/trace_mmu.h b/drivers/infiniband/hw/hfi1/trace_mmu.h
index 3b7abbc382c2..c3055cff4d6b 100644
--- a/drivers/infiniband/hw/hfi1/trace_mmu.h
+++ b/drivers/infiniband/hw/hfi1/trace_mmu.h
@@ -78,10 +78,6 @@ DEFINE_EVENT(hfi1_mmu_rb_template, hfi1_mmu_rb_search,
 	     TP_PROTO(unsigned long addr, unsigned long len),
 	     TP_ARGS(addr, len));
 
-DEFINE_EVENT(hfi1_mmu_rb_template, hfi1_mmu_rb_remove,
-	     TP_PROTO(unsigned long addr, unsigned long len),
-	     TP_ARGS(addr, len));
-
 DEFINE_EVENT(hfi1_mmu_rb_template, hfi1_mmu_mem_invalidate,
 	     TP_PROTO(unsigned long addr, unsigned long len),
 	     TP_ARGS(addr, len));
diff --git a/drivers/infiniband/hw/hfi1/trace_tx.h b/drivers/infiniband/hw/hfi1/trace_tx.h
index 769e5e4710c6..d44fc54858b9 100644
--- a/drivers/infiniband/hw/hfi1/trace_tx.h
+++ b/drivers/infiniband/hw/hfi1/trace_tx.h
@@ -53,6 +53,8 @@
 #include "hfi.h"
 #include "mad.h"
 #include "sdma.h"
+#include "ipoib.h"
+#include "user_sdma.h"
 
 const char *parse_sdma_flags(struct trace_seq *p, u64 desc0, u64 desc1);
 
@@ -653,6 +655,80 @@ TRACE_EVENT(hfi1_sdma_user_completion,
 		      __entry->code)
 );
 
+TRACE_EVENT(hfi1_usdma_defer,
+	    TP_PROTO(struct hfi1_user_sdma_pkt_q *pq,
+		     struct sdma_engine *sde,
+		     struct iowait *wait),
+	    TP_ARGS(pq, sde, wait),
+	    TP_STRUCT__entry(DD_DEV_ENTRY(pq->dd)
+			     __field(struct hfi1_user_sdma_pkt_q *, pq)
+			     __field(struct sdma_engine *, sde)
+			     __field(struct iowait *, wait)
+			     __field(int, engine)
+			     __field(int, empty)
+			     ),
+	     TP_fast_assign(DD_DEV_ASSIGN(pq->dd);
+			    __entry->pq = pq;
+			    __entry->sde = sde;
+			    __entry->wait = wait;
+			    __entry->engine = sde->this_idx;
+			    __entry->empty = list_empty(&__entry->wait->list);
+			    ),
+	     TP_printk("[%s] pq %llx sde %llx wait %llx engine %d empty %d",
+		       __get_str(dev),
+		       (unsigned long long)__entry->pq,
+		       (unsigned long long)__entry->sde,
+		       (unsigned long long)__entry->wait,
+		       __entry->engine,
+		       __entry->empty
+		)
+);
+
+TRACE_EVENT(hfi1_usdma_activate,
+	    TP_PROTO(struct hfi1_user_sdma_pkt_q *pq,
+		     struct iowait *wait,
+		     int reason),
+	    TP_ARGS(pq, wait, reason),
+	    TP_STRUCT__entry(DD_DEV_ENTRY(pq->dd)
+			     __field(struct hfi1_user_sdma_pkt_q *, pq)
+			     __field(struct iowait *, wait)
+			     __field(int, reason)
+			     ),
+	     TP_fast_assign(DD_DEV_ASSIGN(pq->dd);
+			    __entry->pq = pq;
+			    __entry->wait = wait;
+			    __entry->reason = reason;
+			    ),
+	     TP_printk("[%s] pq %llx wait %llx reason %d",
+		       __get_str(dev),
+		       (unsigned long long)__entry->pq,
+		       (unsigned long long)__entry->wait,
+		       __entry->reason
+		)
+);
+
+TRACE_EVENT(hfi1_usdma_we,
+	    TP_PROTO(struct hfi1_user_sdma_pkt_q *pq,
+		     int we_ret),
+	    TP_ARGS(pq, we_ret),
+	    TP_STRUCT__entry(DD_DEV_ENTRY(pq->dd)
+			     __field(struct hfi1_user_sdma_pkt_q *, pq)
+			     __field(int, state)
+			     __field(int, we_ret)
+			     ),
+	     TP_fast_assign(DD_DEV_ASSIGN(pq->dd);
+			    __entry->pq = pq;
+			    __entry->state = pq->state;
+			    __entry->we_ret = we_ret;
+			    ),
+	     TP_printk("[%s] pq %llx state %d we_ret %d",
+		       __get_str(dev),
+		       (unsigned long long)__entry->pq,
+		       __entry->state,
+		       __entry->we_ret
+		)
+);
+
 const char *print_u32_array(struct trace_seq *, u32 *, int);
 #define __print_u32_hex(arr, len) print_u32_array(p, arr, len)
 
@@ -858,6 +934,109 @@ DEFINE_EVENT(
 	TP_ARGS(qp, flag)
 );
 
+DECLARE_EVENT_CLASS(/* AIP  */
+	hfi1_ipoib_txq_template,
+	TP_PROTO(struct hfi1_ipoib_txq *txq),
+	TP_ARGS(txq),
+	TP_STRUCT__entry(/* entry */
+		DD_DEV_ENTRY(txq->priv->dd)
+		__field(struct hfi1_ipoib_txq *, txq)
+		__field(struct sdma_engine *, sde)
+		__field(ulong, head)
+		__field(ulong, tail)
+		__field(uint, used)
+		__field(uint, flow)
+		__field(int, stops)
+		__field(int, no_desc)
+		__field(u8, idx)
+		__field(u8, stopped)
+	),
+	TP_fast_assign(/* assign */
+		DD_DEV_ASSIGN(txq->priv->dd)
+		__entry->txq = txq;
+		__entry->sde = txq->sde;
+		__entry->head = txq->tx_ring.head;
+		__entry->tail = txq->tx_ring.tail;
+		__entry->idx = txq->q_idx;
+		__entry->used =
+			txq->sent_txreqs -
+			atomic64_read(&txq->complete_txreqs);
+		__entry->flow = txq->flow.as_int;
+		__entry->stops = atomic_read(&txq->stops);
+		__entry->no_desc = atomic_read(&txq->no_desc);
+		__entry->stopped =
+		 __netif_subqueue_stopped(txq->priv->netdev, txq->q_idx);
+	),
+	TP_printk(/* print  */
+		"[%s] txq %llx idx %u sde %llx head %lx tail %lx flow %x used %u stops %d no_desc %d stopped %u",
+		__get_str(dev),
+		(unsigned long long)__entry->txq,
+		__entry->idx,
+		(unsigned long long)__entry->sde,
+		__entry->head,
+		__entry->tail,
+		__entry->flow,
+		__entry->used,
+		__entry->stops,
+		__entry->no_desc,
+		__entry->stopped
+	)
+);
+
+DEFINE_EVENT(/* queue stop */
+	hfi1_ipoib_txq_template, hfi1_txq_stop,
+	TP_PROTO(struct hfi1_ipoib_txq *txq),
+	TP_ARGS(txq)
+);
+
+DEFINE_EVENT(/* queue wake */
+	hfi1_ipoib_txq_template, hfi1_txq_wake,
+	TP_PROTO(struct hfi1_ipoib_txq *txq),
+	TP_ARGS(txq)
+);
+
+DEFINE_EVENT(/* flow flush */
+	hfi1_ipoib_txq_template, hfi1_flow_flush,
+	TP_PROTO(struct hfi1_ipoib_txq *txq),
+	TP_ARGS(txq)
+);
+
+DEFINE_EVENT(/* flow switch */
+	hfi1_ipoib_txq_template, hfi1_flow_switch,
+	TP_PROTO(struct hfi1_ipoib_txq *txq),
+	TP_ARGS(txq)
+);
+
+DEFINE_EVENT(/* wakeup */
+	hfi1_ipoib_txq_template, hfi1_txq_wakeup,
+	TP_PROTO(struct hfi1_ipoib_txq *txq),
+	TP_ARGS(txq)
+);
+
+DEFINE_EVENT(/* full */
+	hfi1_ipoib_txq_template, hfi1_txq_full,
+	TP_PROTO(struct hfi1_ipoib_txq *txq),
+	TP_ARGS(txq)
+);
+
+DEFINE_EVENT(/* queued */
+	hfi1_ipoib_txq_template, hfi1_txq_queued,
+	TP_PROTO(struct hfi1_ipoib_txq *txq),
+	TP_ARGS(txq)
+);
+
+DEFINE_EVENT(/* xmit_stopped */
+	hfi1_ipoib_txq_template, hfi1_txq_xmit_stopped,
+	TP_PROTO(struct hfi1_ipoib_txq *txq),
+	TP_ARGS(txq)
+);
+
+DEFINE_EVENT(/* xmit_unstopped */
+	hfi1_ipoib_txq_template, hfi1_txq_xmit_unstopped,
+	TP_PROTO(struct hfi1_ipoib_txq *txq),
+	TP_ARGS(txq)
+);
+
 #endif /* __HFI1_TRACE_TX_H */
 
 #undef TRACE_INCLUDE_PATH
diff --git a/drivers/infiniband/hw/hfi1/user_sdma.c b/drivers/infiniband/hw/hfi1/user_sdma.c
index 4a4956f96a7e..1eb5a44a4ae6 100644
--- a/drivers/infiniband/hw/hfi1/user_sdma.c
+++ b/drivers/infiniband/hw/hfi1/user_sdma.c
@@ -65,7 +65,6 @@
 
 #include "hfi.h"
 #include "sdma.h"
-#include "mmu_rb.h"
 #include "user_sdma.h"
 #include "verbs.h"  /* for the headers */
 #include "common.h" /* for struct hfi1_tid_info */
@@ -80,11 +79,7 @@ static unsigned initial_pkt_count = 8;
 static int user_sdma_send_pkts(struct user_sdma_request *req, u16 maxpkts);
 static void user_sdma_txreq_cb(struct sdma_txreq *txreq, int status);
 static inline void pq_update(struct hfi1_user_sdma_pkt_q *pq);
-static void user_sdma_free_request(struct user_sdma_request *req, bool unpin);
-static int pin_vector_pages(struct user_sdma_request *req,
-			    struct user_sdma_iovec *iovec);
-static void unpin_vector_pages(struct mm_struct *mm, struct page **pages,
-			       unsigned start, unsigned npages);
+static void user_sdma_free_request(struct user_sdma_request *req);
 static int check_header_template(struct user_sdma_request *req,
 				 struct hfi1_pkt_header *hdr, u32 lrhlen,
 				 u32 datalen);
@@ -122,6 +117,11 @@ static struct mmu_rb_ops sdma_rb_ops = {
 	.invalidate = sdma_rb_invalidate
 };
 
+static int add_system_pages_to_sdma_packet(struct user_sdma_request *req,
+					   struct user_sdma_txreq *tx,
+					   struct user_sdma_iovec *iovec,
+					   u32 *pkt_remaining);
+
 static int defer_packet_queue(
 	struct sdma_engine *sde,
 	struct iowait_work *wait,
@@ -133,6 +133,7 @@ static int defer_packet_queue(
 		container_of(wait->iow, struct hfi1_user_sdma_pkt_q, busy);
 
 	write_seqlock(&sde->waitlock);
+	trace_hfi1_usdma_defer(pq, sde, &pq->busy);
 	if (sdma_progress(sde, seq, txreq))
 		goto eagain;
 	/*
@@ -157,7 +158,8 @@ static void activate_packet_queue(struct iowait *wait, int reason)
 {
 	struct hfi1_user_sdma_pkt_q *pq =
 		container_of(wait, struct hfi1_user_sdma_pkt_q, busy);
-	pq->busy.lock = NULL;
+
+	trace_hfi1_usdma_activate(pq, wait, reason);
 	xchg(&pq->state, SDMA_PKT_Q_ACTIVE);
 	wake_up(&wait->wait_dma);
 };
@@ -451,6 +453,7 @@ int hfi1_user_sdma_process_request(struct hfi1_filedata *fd,
 		ret = -EINVAL;
 		goto free_req;
 	}
+
 	/* Copy the header from the user buffer */
 	ret = copy_from_user(&req->hdr, iovec[idx].iov_base + sizeof(info),
 			     sizeof(req->hdr));
@@ -525,9 +528,8 @@ int hfi1_user_sdma_process_request(struct hfi1_filedata *fd,
 		memcpy(&req->iovs[i].iov,
 		       iovec + idx++,
 		       sizeof(req->iovs[i].iov));
-		ret = pin_vector_pages(req, &req->iovs[i]);
-		if (ret) {
-			req->data_iovs = i;
+		if (req->iovs[i].iov.iov_len == 0) {
+			ret = -EINVAL;
 			goto free_req;
 		}
 		req->data_len += req->iovs[i].iov.iov_len;
@@ -599,13 +601,17 @@ int hfi1_user_sdma_process_request(struct hfi1_filedata *fd,
 	while (req->seqsubmitted != req->info.npkts) {
 		ret = user_sdma_send_pkts(req, pcount);
 		if (ret < 0) {
+			int we_ret;
+
 			if (ret != -EBUSY)
 				goto free_req;
-			if (wait_event_interruptible_timeout(
+			we_ret = wait_event_interruptible_timeout(
 				pq->busy.wait_dma,
 				pq->state == SDMA_PKT_Q_ACTIVE,
 				msecs_to_jiffies(
-					SDMA_IOWAIT_TIMEOUT)) <= 0)
+					SDMA_IOWAIT_TIMEOUT));
+			trace_hfi1_usdma_we(pq, we_ret);
+			if (we_ret <= 0)
 				flush_pq_iowait(pq);
 		}
 	}
@@ -621,7 +627,7 @@ int hfi1_user_sdma_process_request(struct hfi1_filedata *fd,
 		if (req->seqsubmitted)
 			wait_event(pq->busy.wait_dma,
 				   (req->seqcomp == req->seqsubmitted - 1));
-		user_sdma_free_request(req, true);
+		user_sdma_free_request(req);
 		pq_update(pq);
 		set_comp_state(pq, cq, info.comp_idx, ERROR, ret);
 	}
@@ -733,48 +739,6 @@ static int user_sdma_txadd_ahg(struct user_sdma_request *req,
 	return ret;
 }
 
-static int user_sdma_txadd(struct user_sdma_request *req,
-			   struct user_sdma_txreq *tx,
-			   struct user_sdma_iovec *iovec, u32 datalen,
-			   u32 *queued_ptr, u32 *data_sent_ptr,
-			   u64 *iov_offset_ptr)
-{
-	int ret;
-	unsigned int pageidx, len;
-	unsigned long base, offset;
-	u64 iov_offset = *iov_offset_ptr;
-	u32 queued = *queued_ptr, data_sent = *data_sent_ptr;
-	struct hfi1_user_sdma_pkt_q *pq = req->pq;
-
-	base = (unsigned long)iovec->iov.iov_base;
-	offset = offset_in_page(base + iovec->offset + iov_offset);
-	pageidx = (((iovec->offset + iov_offset + base) - (base & PAGE_MASK)) >>
-		   PAGE_SHIFT);
-	len = offset + req->info.fragsize > PAGE_SIZE ?
-		PAGE_SIZE - offset : req->info.fragsize;
-	len = min((datalen - queued), len);
-	ret = sdma_txadd_page(pq->dd, &tx->txreq, iovec->pages[pageidx],
-			      offset, len);
-	if (ret) {
-		SDMA_DBG(req, "SDMA txreq add page failed %d\n", ret);
-		return ret;
-	}
-	iov_offset += len;
-	queued += len;
-	data_sent += len;
-	if (unlikely(queued < datalen && pageidx == iovec->npages &&
-		     req->iov_idx < req->data_iovs - 1)) {
-		iovec->offset += iov_offset;
-		iovec = &req->iovs[++req->iov_idx];
-		iov_offset = 0;
-	}
-
-	*queued_ptr = queued;
-	*data_sent_ptr = data_sent;
-	*iov_offset_ptr = iov_offset;
-	return ret;
-}
-
 static int user_sdma_send_pkts(struct user_sdma_request *req, u16 maxpkts)
 {
 	int ret = 0;
@@ -806,8 +770,7 @@ static int user_sdma_send_pkts(struct user_sdma_request *req, u16 maxpkts)
 		maxpkts = req->info.npkts - req->seqnum;
 
 	while (npkts < maxpkts) {
-		u32 datalen = 0, queued = 0, data_sent = 0;
-		u64 iov_offset = 0;
+		u32 datalen = 0;
 
 		/*
 		 * Check whether any of the completions have come back
@@ -900,27 +863,17 @@ static int user_sdma_send_pkts(struct user_sdma_request *req, u16 maxpkts)
 				goto free_txreq;
 		}
 
-		/*
-		 * If the request contains any data vectors, add up to
-		 * fragsize bytes to the descriptor.
-		 */
-		while (queued < datalen &&
-		       (req->sent + data_sent) < req->data_len) {
-			ret = user_sdma_txadd(req, tx, iovec, datalen,
-					      &queued, &data_sent, &iov_offset);
-			if (ret)
-				goto free_txreq;
-		}
-		/*
-		 * The txreq was submitted successfully so we can update
-		 * the counters.
-		 */
 		req->koffset += datalen;
 		if (req_opcode(req->info.ctrl) == EXPECTED)
 			req->tidoffset += datalen;
-		req->sent += data_sent;
-		if (req->data_len)
-			iovec->offset += iov_offset;
+		req->sent += datalen;
+		while (datalen) {
+			ret = add_system_pages_to_sdma_packet(req, tx, iovec,
+							      &datalen);
+			if (ret)
+				goto free_txreq;
+			iovec = &req->iovs[req->iov_idx];
+		}
 		list_add_tail(&tx->txreq.list, &req->txps);
 		/*
 		 * It is important to increment this here as it is used to
@@ -957,133 +910,14 @@ static int user_sdma_send_pkts(struct user_sdma_request *req, u16 maxpkts)
 static u32 sdma_cache_evict(struct hfi1_user_sdma_pkt_q *pq, u32 npages)
 {
 	struct evict_data evict_data;
+	struct mmu_rb_handler *handler = pq->handler;
 
 	evict_data.cleared = 0;
 	evict_data.target = npages;
-	hfi1_mmu_rb_evict(pq->handler, &evict_data);
+	hfi1_mmu_rb_evict(handler, &evict_data);
 	return evict_data.cleared;
 }
 
-static int pin_sdma_pages(struct user_sdma_request *req,
-			  struct user_sdma_iovec *iovec,
-			  struct sdma_mmu_node *node,
-			  int npages)
-{
-	int pinned, cleared;
-	struct page **pages;
-	struct hfi1_user_sdma_pkt_q *pq = req->pq;
-
-	pages = kcalloc(npages, sizeof(*pages), GFP_KERNEL);
-	if (!pages)
-		return -ENOMEM;
-	memcpy(pages, node->pages, node->npages * sizeof(*pages));
-
-	npages -= node->npages;
-retry:
-	if (!hfi1_can_pin_pages(pq->dd, current->mm,
-				atomic_read(&pq->n_locked), npages)) {
-		cleared = sdma_cache_evict(pq, npages);
-		if (cleared >= npages)
-			goto retry;
-	}
-	pinned = hfi1_acquire_user_pages(current->mm,
-					 ((unsigned long)iovec->iov.iov_base +
-					 (node->npages * PAGE_SIZE)), npages, 0,
-					 pages + node->npages);
-	if (pinned < 0) {
-		kfree(pages);
-		return pinned;
-	}
-	if (pinned != npages) {
-		unpin_vector_pages(current->mm, pages, node->npages, pinned);
-		return -EFAULT;
-	}
-	kfree(node->pages);
-	node->rb.len = iovec->iov.iov_len;
-	node->pages = pages;
-	atomic_add(pinned, &pq->n_locked);
-	return pinned;
-}
-
-static void unpin_sdma_pages(struct sdma_mmu_node *node)
-{
-	if (node->npages) {
-		unpin_vector_pages(mm_from_sdma_node(node), node->pages, 0,
-				   node->npages);
-		atomic_sub(node->npages, &node->pq->n_locked);
-	}
-}
-
-static int pin_vector_pages(struct user_sdma_request *req,
-			    struct user_sdma_iovec *iovec)
-{
-	int ret = 0, pinned, npages;
-	struct hfi1_user_sdma_pkt_q *pq = req->pq;
-	struct sdma_mmu_node *node = NULL;
-	struct mmu_rb_node *rb_node;
-	struct iovec *iov;
-	bool extracted;
-
-	extracted =
-		hfi1_mmu_rb_remove_unless_exact(pq->handler,
-						(unsigned long)
-						iovec->iov.iov_base,
-						iovec->iov.iov_len, &rb_node);
-	if (rb_node) {
-		node = container_of(rb_node, struct sdma_mmu_node, rb);
-		if (!extracted) {
-			atomic_inc(&node->refcount);
-			iovec->pages = node->pages;
-			iovec->npages = node->npages;
-			iovec->node = node;
-			return 0;
-		}
-	}
-
-	if (!node) {
-		node = kzalloc(sizeof(*node), GFP_KERNEL);
-		if (!node)
-			return -ENOMEM;
-
-		node->rb.addr = (unsigned long)iovec->iov.iov_base;
-		node->pq = pq;
-		atomic_set(&node->refcount, 0);
-	}
-
-	iov = &iovec->iov;
-	npages = num_user_pages((unsigned long)iov->iov_base, iov->iov_len);
-	if (node->npages < npages) {
-		pinned = pin_sdma_pages(req, iovec, node, npages);
-		if (pinned < 0) {
-			ret = pinned;
-			goto bail;
-		}
-		node->npages += pinned;
-		npages = node->npages;
-	}
-	iovec->pages = node->pages;
-	iovec->npages = npages;
-	iovec->node = node;
-
-	ret = hfi1_mmu_rb_insert(req->pq->handler, &node->rb);
-	if (ret) {
-		iovec->node = NULL;
-		goto bail;
-	}
-	return 0;
-bail:
-	unpin_sdma_pages(node);
-	kfree(node);
-	return ret;
-}
-
-static void unpin_vector_pages(struct mm_struct *mm, struct page **pages,
-			       unsigned start, unsigned npages)
-{
-	hfi1_release_user_pages(mm, pages + start, npages, false);
-	kfree(pages);
-}
-
 static int check_header_template(struct user_sdma_request *req,
 				 struct hfi1_pkt_header *hdr, u32 lrhlen,
 				 u32 datalen)
@@ -1425,7 +1259,7 @@ static void user_sdma_txreq_cb(struct sdma_txreq *txreq, int status)
 	if (req->seqcomp != req->info.npkts - 1)
 		return;
 
-	user_sdma_free_request(req, false);
+	user_sdma_free_request(req);
 	set_comp_state(pq, cq, req->info.comp_idx, state, status);
 	pq_update(pq);
 }
@@ -1436,10 +1270,8 @@ static inline void pq_update(struct hfi1_user_sdma_pkt_q *pq)
 		wake_up(&pq->wait);
 }
 
-static void user_sdma_free_request(struct user_sdma_request *req, bool unpin)
+static void user_sdma_free_request(struct user_sdma_request *req)
 {
-	int i;
-
 	if (!list_empty(&req->txps)) {
 		struct sdma_txreq *t, *p;
 
@@ -1452,21 +1284,6 @@ static void user_sdma_free_request(struct user_sdma_request *req, bool unpin)
 		}
 	}
 
-	for (i = 0; i < req->data_iovs; i++) {
-		struct sdma_mmu_node *node = req->iovs[i].node;
-
-		if (!node)
-			continue;
-
-		req->iovs[i].node = NULL;
-
-		if (unpin)
-			hfi1_mmu_rb_remove(req->pq->handler,
-					   &node->rb);
-		else
-			atomic_dec(&node->refcount);
-	}
-
 	kfree(req->tids);
 	clear_bit(req->info.comp_idx, req->pq->req_in_use);
 }
@@ -1484,6 +1301,368 @@ static inline void set_comp_state(struct hfi1_user_sdma_pkt_q *pq,
 					idx, state, ret);
 }
 
+static void unpin_vector_pages(struct mm_struct *mm, struct page **pages,
+			       unsigned int start, unsigned int npages)
+{
+	hfi1_release_user_pages(mm, pages + start, npages, false);
+	kfree(pages);
+}
+
+static void free_system_node(struct sdma_mmu_node *node)
+{
+	if (node->npages) {
+		unpin_vector_pages(mm_from_sdma_node(node), node->pages, 0,
+				   node->npages);
+		atomic_sub(node->npages, &node->pq->n_locked);
+	}
+	kfree(node);
+}
+
+static inline void acquire_node(struct sdma_mmu_node *node)
+{
+	atomic_inc(&node->refcount);
+	WARN_ON(atomic_read(&node->refcount) < 0);
+}
+
+static inline void release_node(struct mmu_rb_handler *handler,
+				struct sdma_mmu_node *node)
+{
+	atomic_dec(&node->refcount);
+	WARN_ON(atomic_read(&node->refcount) < 0);
+}
+
+static struct sdma_mmu_node *find_system_node(struct mmu_rb_handler *handler,
+					      unsigned long start,
+					      unsigned long end)
+{
+	struct mmu_rb_node *rb_node;
+	struct sdma_mmu_node *node;
+	unsigned long flags;
+
+	spin_lock_irqsave(&handler->lock, flags);
+	rb_node = hfi1_mmu_rb_get_first(handler, start, (end - start));
+	if (!rb_node) {
+		spin_unlock_irqrestore(&handler->lock, flags);
+		return NULL;
+	}
+	node = container_of(rb_node, struct sdma_mmu_node, rb);
+	acquire_node(node);
+	spin_unlock_irqrestore(&handler->lock, flags);
+
+	return node;
+}
+
+static int pin_system_pages(struct user_sdma_request *req,
+			    uintptr_t start_address, size_t length,
+			    struct sdma_mmu_node *node, int npages)
+{
+	struct hfi1_user_sdma_pkt_q *pq = req->pq;
+	int pinned, cleared;
+	struct page **pages;
+
+	pages = kcalloc(npages, sizeof(*pages), GFP_KERNEL);
+	if (!pages)
+		return -ENOMEM;
+
+retry:
+	if (!hfi1_can_pin_pages(pq->dd, current->mm, atomic_read(&pq->n_locked),
+				npages)) {
+		SDMA_DBG(req, "Evicting: nlocked %u npages %u",
+			 atomic_read(&pq->n_locked), npages);
+		cleared = sdma_cache_evict(pq, npages);
+		if (cleared >= npages)
+			goto retry;
+	}
+
+	SDMA_DBG(req, "Acquire user pages start_address %lx node->npages %u npages %u",
+		 start_address, node->npages, npages);
+	pinned = hfi1_acquire_user_pages(current->mm, start_address, npages, 0,
+					 pages);
+
+	if (pinned < 0) {
+		kfree(pages);
+		SDMA_DBG(req, "pinned %d", pinned);
+		return pinned;
+	}
+	if (pinned != npages) {
+		unpin_vector_pages(current->mm, pages, node->npages, pinned);
+		SDMA_DBG(req, "npages %u pinned %d", npages, pinned);
+		return -EFAULT;
+	}
+	node->rb.addr = start_address;
+	node->rb.len = length;
+	node->pages = pages;
+	node->npages = npages;
+	atomic_add(pinned, &pq->n_locked);
+	SDMA_DBG(req, "done. pinned %d", pinned);
+	return 0;
+}
+
+static int add_system_pinning(struct user_sdma_request *req,
+			      struct sdma_mmu_node **node_p,
+			      unsigned long start, unsigned long len)
+
+{
+	struct hfi1_user_sdma_pkt_q *pq = req->pq;
+	struct sdma_mmu_node *node;
+	int ret;
+
+	node = kzalloc(sizeof(*node), GFP_KERNEL);
+	if (!node)
+		return -ENOMEM;
+
+	node->pq = pq;
+	ret = pin_system_pages(req, start, len, node, PFN_DOWN(len));
+	if (ret == 0) {
+		ret = hfi1_mmu_rb_insert(pq->handler, &node->rb);
+		if (ret)
+			free_system_node(node);
+		else
+			*node_p = node;
+
+		return ret;
+	}
+
+	kfree(node);
+	return ret;
+}
+
+static int get_system_cache_entry(struct user_sdma_request *req,
+				  struct sdma_mmu_node **node_p,
+				  size_t req_start, size_t req_len)
+{
+	struct hfi1_user_sdma_pkt_q *pq = req->pq;
+	u64 start = ALIGN_DOWN(req_start, PAGE_SIZE);
+	u64 end = PFN_ALIGN(req_start + req_len);
+	struct mmu_rb_handler *handler = pq->handler;
+	int ret;
+
+	if ((end - start) == 0) {
+		SDMA_DBG(req,
+			 "Request for empty cache entry req_start %lx req_len %lx start %llx end %llx",
+			 req_start, req_len, start, end);
+		return -EINVAL;
+	}
+
+	SDMA_DBG(req, "req_start %lx req_len %lu", req_start, req_len);
+
+	while (1) {
+		struct sdma_mmu_node *node =
+			find_system_node(handler, start, end);
+		u64 prepend_len = 0;
+
+		SDMA_DBG(req, "node %p start %llx end %llu", node, start, end);
+		if (!node) {
+			ret = add_system_pinning(req, node_p, start,
+						 end - start);
+			if (ret == -EEXIST) {
+				/*
+				 * Another execution context has inserted a
+				 * conficting entry first.
+				 */
+				continue;
+			}
+			return ret;
+		}
+
+		if (node->rb.addr <= start) {
+			/*
+			 * This entry covers at least part of the region. If it doesn't extend
+			 * to the end, then this will be called again for the next segment.
+			 */
+			*node_p = node;
+			return 0;
+		}
+
+		SDMA_DBG(req, "prepend: node->rb.addr %lx, node->refcount %d",
+			 node->rb.addr, atomic_read(&node->refcount));
+		prepend_len = node->rb.addr - start;
+
+		/*
+		 * This node will not be returned, instead a new node
+		 * will be. So release the reference.
+		 */
+		release_node(handler, node);
+
+		/* Prepend a node to cover the beginning of the allocation */
+		ret = add_system_pinning(req, node_p, start, prepend_len);
+		if (ret == -EEXIST) {
+			/* Another execution context has inserted a conficting entry first. */
+			continue;
+		}
+		return ret;
+	}
+}
+
+static int add_mapping_to_sdma_packet(struct user_sdma_request *req,
+				      struct user_sdma_txreq *tx,
+				      struct sdma_mmu_node *cache_entry,
+				      size_t start,
+				      size_t from_this_cache_entry)
+{
+	struct hfi1_user_sdma_pkt_q *pq = req->pq;
+	unsigned int page_offset;
+	unsigned int from_this_page;
+	size_t page_index;
+	void *ctx;
+	int ret;
+
+	/*
+	 * Because the cache may be more fragmented than the memory that is being accessed,
+	 * it's not strictly necessary to have a descriptor per cache entry.
+	 */
+
+	while (from_this_cache_entry) {
+		page_index = PFN_DOWN(start - cache_entry->rb.addr);
+
+		if (page_index >= cache_entry->npages) {
+			SDMA_DBG(req,
+				 "Request for page_index %zu >= cache_entry->npages %u",
+				 page_index, cache_entry->npages);
+			return -EINVAL;
+		}
+
+		page_offset = start - ALIGN_DOWN(start, PAGE_SIZE);
+		from_this_page = PAGE_SIZE - page_offset;
+
+		if (from_this_page < from_this_cache_entry) {
+			ctx = NULL;
+		} else {
+			/*
+			 * In the case they are equal the next line has no practical effect,
+			 * but it's better to do a register to register copy than a conditional
+			 * branch.
+			 */
+			from_this_page = from_this_cache_entry;
+			ctx = cache_entry;
+		}
+
+		ret = sdma_txadd_page(pq->dd, ctx, &tx->txreq,
+				      cache_entry->pages[page_index],
+				      page_offset, from_this_page);
+		if (ret) {
+			/*
+			 * When there's a failure, the entire request is freed by
+			 * user_sdma_send_pkts().
+			 */
+			SDMA_DBG(req,
+				 "sdma_txadd_page failed %d page_index %lu page_offset %u from_this_page %u",
+				 ret, page_index, page_offset, from_this_page);
+			return ret;
+		}
+		start += from_this_page;
+		from_this_cache_entry -= from_this_page;
+	}
+	return 0;
+}
+
+static int add_system_iovec_to_sdma_packet(struct user_sdma_request *req,
+					   struct user_sdma_txreq *tx,
+					   struct user_sdma_iovec *iovec,
+					   size_t from_this_iovec)
+{
+	struct mmu_rb_handler *handler = req->pq->handler;
+
+	while (from_this_iovec > 0) {
+		struct sdma_mmu_node *cache_entry;
+		size_t from_this_cache_entry;
+		size_t start;
+		int ret;
+
+		start = (uintptr_t)iovec->iov.iov_base + iovec->offset;
+		ret = get_system_cache_entry(req, &cache_entry, start,
+					     from_this_iovec);
+		if (ret) {
+			SDMA_DBG(req, "pin system segment failed %d", ret);
+			return ret;
+		}
+
+		from_this_cache_entry = cache_entry->rb.len - (start - cache_entry->rb.addr);
+		if (from_this_cache_entry > from_this_iovec)
+			from_this_cache_entry = from_this_iovec;
+
+		ret = add_mapping_to_sdma_packet(req, tx, cache_entry, start,
+						 from_this_cache_entry);
+		if (ret) {
+			/*
+			 * We're guaranteed that there will be no descriptor
+			 * completion callback that releases this node
+			 * because only the last descriptor referencing it
+			 * has a context attached, and a failure means the
+			 * last descriptor was never added.
+			 */
+			release_node(handler, cache_entry);
+			SDMA_DBG(req, "add system segment failed %d", ret);
+			return ret;
+		}
+
+		iovec->offset += from_this_cache_entry;
+		from_this_iovec -= from_this_cache_entry;
+	}
+
+	return 0;
+}
+
+static int add_system_pages_to_sdma_packet(struct user_sdma_request *req,
+					   struct user_sdma_txreq *tx,
+					   struct user_sdma_iovec *iovec,
+					   u32 *pkt_data_remaining)
+{
+	size_t remaining_to_add = *pkt_data_remaining;
+	/*
+	 * Walk through iovec entries, ensure the associated pages
+	 * are pinned and mapped, add data to the packet until no more
+	 * data remains to be added.
+	 */
+	while (remaining_to_add > 0) {
+		struct user_sdma_iovec *cur_iovec;
+		size_t from_this_iovec;
+		int ret;
+
+		cur_iovec = iovec;
+		from_this_iovec = iovec->iov.iov_len - iovec->offset;
+
+		if (from_this_iovec > remaining_to_add) {
+			from_this_iovec = remaining_to_add;
+		} else {
+			/* The current iovec entry will be consumed by this pass. */
+			req->iov_idx++;
+			iovec++;
+		}
+
+		ret = add_system_iovec_to_sdma_packet(req, tx, cur_iovec,
+						      from_this_iovec);
+		if (ret)
+			return ret;
+
+		remaining_to_add -= from_this_iovec;
+	}
+	*pkt_data_remaining = remaining_to_add;
+
+	return 0;
+}
+
+void system_descriptor_complete(struct hfi1_devdata *dd,
+				struct sdma_desc *descp)
+{
+	switch (sdma_mapping_type(descp)) {
+	case SDMA_MAP_SINGLE:
+		dma_unmap_single(&dd->pcidev->dev, sdma_mapping_addr(descp),
+				 sdma_mapping_len(descp), DMA_TO_DEVICE);
+		break;
+	case SDMA_MAP_PAGE:
+		dma_unmap_page(&dd->pcidev->dev, sdma_mapping_addr(descp),
+			       sdma_mapping_len(descp), DMA_TO_DEVICE);
+		break;
+	}
+
+	if (descp->pinning_ctx) {
+		struct sdma_mmu_node *node = descp->pinning_ctx;
+
+		release_node(node->rb.handler, node);
+	}
+}
+
 static bool sdma_rb_filter(struct mmu_rb_node *node, unsigned long addr,
 			   unsigned long len)
 {
@@ -1530,8 +1709,7 @@ static void sdma_rb_remove(void *arg, struct mmu_rb_node *mnode)
 	struct sdma_mmu_node *node =
 		container_of(mnode, struct sdma_mmu_node, rb);
 
-	unpin_sdma_pages(node);
-	kfree(node);
+	free_system_node(node);
 }
 
 static int sdma_rb_invalidate(void *arg, struct mmu_rb_node *mnode)
diff --git a/drivers/infiniband/hw/hfi1/user_sdma.h b/drivers/infiniband/hw/hfi1/user_sdma.h
index 1e8c02fe8ad1..9d417aacfa8b 100644
--- a/drivers/infiniband/hw/hfi1/user_sdma.h
+++ b/drivers/infiniband/hw/hfi1/user_sdma.h
@@ -53,6 +53,7 @@
 #include "common.h"
 #include "iowait.h"
 #include "user_exp_rcv.h"
+#include "mmu_rb.h"
 
 /* The maximum number of Data io vectors per message/request */
 #define MAX_VECTORS_PER_REQ 8
@@ -152,16 +153,11 @@ struct sdma_mmu_node {
 struct user_sdma_iovec {
 	struct list_head list;
 	struct iovec iov;
-	/* number of pages in this vector */
-	unsigned int npages;
-	/* array of pinned pages for this vector */
-	struct page **pages;
 	/*
 	 * offset into the virtual address space of the vector at
 	 * which we last left off.
 	 */
 	u64 offset;
-	struct sdma_mmu_node *node;
 };
 
 /* evict operation argument */
diff --git a/drivers/infiniband/hw/hfi1/verbs.c b/drivers/infiniband/hw/hfi1/verbs.c
index 5f3edd255ca3..693922df3543 100644
--- a/drivers/infiniband/hw/hfi1/verbs.c
+++ b/drivers/infiniband/hw/hfi1/verbs.c
@@ -820,8 +820,8 @@ static int build_verbs_tx_desc(
 
 	/* add icrc, lt byte, and padding to flit */
 	if (extra_bytes)
-		ret = sdma_txadd_daddr(sde->dd, &tx->txreq,
-				       sde->dd->sdma_pad_phys, extra_bytes);
+		ret = sdma_txadd_daddr(sde->dd, &tx->txreq, sde->dd->sdma_pad_phys,
+				       extra_bytes);
 
 bail_txadd:
 	return ret;
diff --git a/drivers/infiniband/hw/hfi1/vnic_sdma.c b/drivers/infiniband/hw/hfi1/vnic_sdma.c
index 7d90b900131b..7658c620a125 100644
--- a/drivers/infiniband/hw/hfi1/vnic_sdma.c
+++ b/drivers/infiniband/hw/hfi1/vnic_sdma.c
@@ -106,6 +106,7 @@ static noinline int build_vnic_ulp_payload(struct sdma_engine *sde,
 
 		/* combine physically continuous fragments later? */
 		ret = sdma_txadd_page(sde->dd,
+				      NULL,
 				      &tx->txreq,
 				      skb_frag_page(frag),
 				      skb_frag_off(frag),
diff --git a/drivers/infiniband/hw/mlx4/qp.c b/drivers/infiniband/hw/mlx4/qp.c
index c6a815a705fe..255194029e2d 100644
--- a/drivers/infiniband/hw/mlx4/qp.c
+++ b/drivers/infiniband/hw/mlx4/qp.c
@@ -412,9 +412,13 @@ static int set_user_sq_size(struct mlx4_ib_dev *dev,
 			    struct mlx4_ib_qp *qp,
 			    struct mlx4_ib_create_qp *ucmd)
 {
+	u32 cnt;
+
 	/* Sanity check SQ size before proceeding */
-	if ((1 << ucmd->log_sq_bb_count) > dev->dev->caps.max_wqes	 ||
-	    ucmd->log_sq_stride >
+	if (check_shl_overflow(1, ucmd->log_sq_bb_count, &cnt) ||
+	    cnt > dev->dev->caps.max_wqes)
+		return -EINVAL;
+	if (ucmd->log_sq_stride >
 		ilog2(roundup_pow_of_two(dev->dev->caps.max_sq_desc_sz)) ||
 	    ucmd->log_sq_stride < MLX4_IB_MIN_SQ_STRIDE)
 		return -EINVAL;
diff --git a/drivers/infiniband/hw/mlx5/devx.c b/drivers/infiniband/hw/mlx5/devx.c
index 2f053f48f1be..a56ebdc15723 100644
--- a/drivers/infiniband/hw/mlx5/devx.c
+++ b/drivers/infiniband/hw/mlx5/devx.c
@@ -595,7 +595,21 @@ static bool devx_is_valid_obj_id(struct uverbs_attr_bundle *attrs,
 				      obj_id;
 
 	case MLX5_IB_OBJECT_DEVX_OBJ:
-		return ((struct devx_obj *)uobj->object)->obj_id == obj_id;
+	{
+		u16 opcode = MLX5_GET(general_obj_in_cmd_hdr, in, opcode);
+		struct devx_obj *devx_uobj = uobj->object;
+
+		if (opcode == MLX5_CMD_OP_QUERY_FLOW_COUNTER &&
+		    devx_uobj->flow_counter_bulk_size) {
+			u64 end;
+
+			end = devx_uobj->obj_id +
+				devx_uobj->flow_counter_bulk_size;
+			return devx_uobj->obj_id <= obj_id && end > obj_id;
+		}
+
+		return devx_uobj->obj_id == obj_id;
+	}
 
 	default:
 		return false;
@@ -1416,10 +1430,17 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_DEVX_OBJ_CREATE)(
 		goto obj_free;
 
 	if (opcode == MLX5_CMD_OP_ALLOC_FLOW_COUNTER) {
-		u8 bulk = MLX5_GET(alloc_flow_counter_in,
-				   cmd_in,
-				   flow_counter_bulk);
-		obj->flow_counter_bulk_size = 128UL * bulk;
+		u32 bulk = MLX5_GET(alloc_flow_counter_in,
+				    cmd_in,
+				    flow_counter_bulk_log_size);
+
+		if (bulk)
+			bulk = 1 << bulk;
+		else
+			bulk = 128UL * MLX5_GET(alloc_flow_counter_in,
+						cmd_in,
+						flow_counter_bulk);
+		obj->flow_counter_bulk_size = bulk;
 	}
 
 	uobj->object = obj;
diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 0caff276f2c1..0c47e3e24b2a 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -4164,7 +4164,7 @@ static int mlx5_ib_modify_dct(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 			return -EINVAL;
 
 		if (attr->port_num == 0 ||
-		    attr->port_num > MLX5_CAP_GEN(dev->mdev, num_ports)) {
+		    attr->port_num > dev->num_ports) {
 			mlx5_ib_dbg(dev, "invalid port number %d. number of ports is %d\n",
 				    attr->port_num, dev->num_ports);
 			return -EINVAL;
diff --git a/drivers/infiniband/sw/rdmavt/qp.c b/drivers/infiniband/sw/rdmavt/qp.c
index 585a9c76e518..ddc8825d526e 100644
--- a/drivers/infiniband/sw/rdmavt/qp.c
+++ b/drivers/infiniband/sw/rdmavt/qp.c
@@ -505,8 +505,6 @@ void rvt_qp_exit(struct rvt_dev_info *rdi)
 	if (qps_inuse)
 		rvt_pr_err(rdi, "QP memory leak! %u still in use\n",
 			   qps_inuse);
-	if (!rdi->qp_dev)
-		return;
 
 	kfree(rdi->qp_dev->qp_table);
 	free_qpn_table(&rdi->qp_dev->qpn_table);
diff --git a/drivers/infiniband/sw/siw/siw_main.c b/drivers/infiniband/sw/siw/siw_main.c
index 32a553a1b905..5ba0893f1f01 100644
--- a/drivers/infiniband/sw/siw/siw_main.c
+++ b/drivers/infiniband/sw/siw/siw_main.c
@@ -458,9 +458,6 @@ static int siw_netdev_event(struct notifier_block *nb, unsigned long event,
 
 	dev_dbg(&netdev->dev, "siw: event %lu\n", event);
 
-	if (dev_net(netdev) != &init_net)
-		return NOTIFY_OK;
-
 	base_dev = ib_device_get_by_netdev(netdev, RDMA_DRIVER_SIW);
 	if (!base_dev)
 		return NOTIFY_OK;
diff --git a/drivers/infiniband/sw/siw/siw_qp_tx.c b/drivers/infiniband/sw/siw/siw_qp_tx.c
index df8802b4981c..ccc6d5bb1a27 100644
--- a/drivers/infiniband/sw/siw/siw_qp_tx.c
+++ b/drivers/infiniband/sw/siw/siw_qp_tx.c
@@ -548,7 +548,7 @@ static int siw_tx_hdt(struct siw_iwarp_tx *c_tx, struct socket *s)
 			data_len -= plen;
 			fp_off = 0;
 
-			if (++seg > (int)MAX_ARRAY) {
+			if (++seg >= (int)MAX_ARRAY) {
 				siw_dbg_qp(tx_qp(c_tx), "to many fragments\n");
 				siw_unmap_pages(page_array, kmap_mask);
 				wqe->processed -= c_tx->bytes_unsent;
diff --git a/drivers/infiniband/ulp/isert/ib_isert.c b/drivers/infiniband/ulp/isert/ib_isert.c
index edea37da8a5b..2d0d966fba2c 100644
--- a/drivers/infiniband/ulp/isert/ib_isert.c
+++ b/drivers/infiniband/ulp/isert/ib_isert.c
@@ -1553,12 +1553,12 @@ isert_check_pi_status(struct se_cmd *se_cmd, struct ib_mr *sig_mr)
 		}
 		sec_offset_err = mr_status.sig_err.sig_err_offset;
 		do_div(sec_offset_err, block_size);
-		se_cmd->bad_sector = sec_offset_err + se_cmd->t_task_lba;
+		se_cmd->sense_info = sec_offset_err + se_cmd->t_task_lba;
 
 		isert_err("PI error found type %d at sector 0x%llx "
 			  "expected 0x%x vs actual 0x%x\n",
 			  mr_status.sig_err.err_type,
-			  (unsigned long long)se_cmd->bad_sector,
+			  (unsigned long long)se_cmd->sense_info,
 			  mr_status.sig_err.expected,
 			  mr_status.sig_err.actual);
 		ret = 1;
diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
index c0ed08fcab48..983f59c87b79 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.c
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
@@ -549,6 +549,7 @@ static int srpt_format_guid(char *buf, unsigned int size, const __be64 *guid)
  */
 static int srpt_refresh_port(struct srpt_port *sport)
 {
+	struct ib_mad_agent *mad_agent;
 	struct ib_mad_reg_req reg_req;
 	struct ib_port_modify port_modify;
 	struct ib_port_attr port_attr;
@@ -593,24 +594,26 @@ static int srpt_refresh_port(struct srpt_port *sport)
 		set_bit(IB_MGMT_METHOD_GET, reg_req.method_mask);
 		set_bit(IB_MGMT_METHOD_SET, reg_req.method_mask);
 
-		sport->mad_agent = ib_register_mad_agent(sport->sdev->device,
-							 sport->port,
-							 IB_QPT_GSI,
-							 &reg_req, 0,
-							 srpt_mad_send_handler,
-							 srpt_mad_recv_handler,
-							 sport, 0);
-		if (IS_ERR(sport->mad_agent)) {
+		mad_agent = ib_register_mad_agent(sport->sdev->device,
+						  sport->port,
+						  IB_QPT_GSI,
+						  &reg_req, 0,
+						  srpt_mad_send_handler,
+						  srpt_mad_recv_handler,
+						  sport, 0);
+		if (IS_ERR(mad_agent)) {
 			pr_err("%s-%d: MAD agent registration failed (%ld). Note: this is expected if SR-IOV is enabled.\n",
 			       dev_name(&sport->sdev->device->dev), sport->port,
-			       PTR_ERR(sport->mad_agent));
+			       PTR_ERR(mad_agent));
 			sport->mad_agent = NULL;
 			memset(&port_modify, 0, sizeof(port_modify));
 			port_modify.clr_port_cap_mask = IB_PORT_DEVICE_MGMT_SUP;
 			ib_modify_port(sport->sdev->device, sport->port, 0,
 				       &port_modify);
-
+			return 0;
 		}
+
+		sport->mad_agent = mad_agent;
 	}
 
 	return 0;
diff --git a/drivers/input/touchscreen/raspberrypi-ts.c b/drivers/input/touchscreen/raspberrypi-ts.c
index ef6aaed217cf..45c575df994e 100644
--- a/drivers/input/touchscreen/raspberrypi-ts.c
+++ b/drivers/input/touchscreen/raspberrypi-ts.c
@@ -134,7 +134,7 @@ static int rpi_ts_probe(struct platform_device *pdev)
 		return -ENOENT;
 	}
 
-	fw = rpi_firmware_get(fw_node);
+	fw = devm_rpi_firmware_get(&pdev->dev, fw_node);
 	of_node_put(fw_node);
 	if (!fw)
 		return -EPROBE_DEFER;
@@ -160,7 +160,6 @@ static int rpi_ts_probe(struct platform_device *pdev)
 	touchbuf = (u32)ts->fw_regs_phys;
 	error = rpi_firmware_property(fw, RPI_FIRMWARE_FRAMEBUFFER_SET_TOUCHBUF,
 				      &touchbuf, sizeof(touchbuf));
-
 	if (error || touchbuf != 0) {
 		dev_warn(dev, "Failed to set touchbuf, %d\n", error);
 		return error;
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 690c5976575c..4a8791e037b8 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -897,8 +897,8 @@ struct amd_ir_data {
 	 */
 	struct irq_cfg *cfg;
 	int ga_vector;
-	int ga_root_ptr;
-	int ga_tag;
+	u64 ga_root_ptr;
+	u32 ga_tag;
 };
 
 struct amd_irte_ops {
diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index 56e8198e13d1..ad84be4f6817 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -871,7 +871,7 @@ config LEDS_SPI_BYTE
 config LEDS_TI_LMU_COMMON
 	tristate "LED driver for TI LMU"
 	depends on LEDS_CLASS
-	depends on REGMAP
+	select REGMAP
 	help
 	  Say Y to enable the LED driver for TI LMU devices.
 	  This supports common features between the TI LM3532, LM3631, LM3632,
diff --git a/drivers/leds/leds-tca6507.c b/drivers/leds/leds-tca6507.c
index 225b765830bd..caad9d3e0eac 100644
--- a/drivers/leds/leds-tca6507.c
+++ b/drivers/leds/leds-tca6507.c
@@ -696,8 +696,9 @@ tca6507_led_dt_init(struct device *dev)
 		if (fwnode_property_read_string(child, "label", &led.name))
 			led.name = fwnode_get_name(child);
 
-		fwnode_property_read_string(child, "linux,default-trigger",
-					    &led.default_trigger);
+		if (fwnode_property_read_string(child, "linux,default-trigger",
+						&led.default_trigger))
+			led.default_trigger = NULL;
 
 		led.flags = 0;
 		if (fwnode_property_match_string(child, "compatible",
diff --git a/drivers/macintosh/Kconfig b/drivers/macintosh/Kconfig
index 539a2ed4e13d..a0e717a986dc 100644
--- a/drivers/macintosh/Kconfig
+++ b/drivers/macintosh/Kconfig
@@ -86,6 +86,7 @@ config ADB_PMU_LED
 
 config ADB_PMU_LED_DISK
 	bool "Use front LED as DISK LED by default"
+	depends on ATA
 	depends on ADB_PMU_LED
 	depends on LEDS_CLASS
 	select LEDS_TRIGGERS
diff --git a/drivers/macintosh/windfarm_smu_sat.c b/drivers/macintosh/windfarm_smu_sat.c
index e46e1153a0b4..7d7d6213e32a 100644
--- a/drivers/macintosh/windfarm_smu_sat.c
+++ b/drivers/macintosh/windfarm_smu_sat.c
@@ -171,6 +171,7 @@ static void wf_sat_release(struct kref *ref)
 
 	if (sat->nr >= 0)
 		sats[sat->nr] = NULL;
+	of_node_put(sat->node);
 	kfree(sat);
 }
 
diff --git a/drivers/mailbox/zynqmp-ipi-mailbox.c b/drivers/mailbox/zynqmp-ipi-mailbox.c
index 527204c6d5cd..be06de791c54 100644
--- a/drivers/mailbox/zynqmp-ipi-mailbox.c
+++ b/drivers/mailbox/zynqmp-ipi-mailbox.c
@@ -110,7 +110,7 @@ struct zynqmp_ipi_pdata {
 	unsigned int method;
 	u32 local_id;
 	int num_mboxes;
-	struct zynqmp_ipi_mbox *ipi_mboxes;
+	struct zynqmp_ipi_mbox ipi_mboxes[];
 };
 
 static struct device_driver zynqmp_ipi_mbox_driver = {
@@ -152,7 +152,7 @@ static irqreturn_t zynqmp_ipi_interrupt(int irq, void *data)
 	struct zynqmp_ipi_message *msg;
 	u64 arg0, arg3;
 	struct arm_smccc_res res;
-	int ret, i;
+	int ret, i, status = IRQ_NONE;
 
 	(void)irq;
 	arg0 = SMC_IPI_MAILBOX_STATUS_ENQUIRY;
@@ -170,11 +170,11 @@ static irqreturn_t zynqmp_ipi_interrupt(int irq, void *data)
 				memcpy_fromio(msg->data, mchan->req_buf,
 					      msg->len);
 				mbox_chan_received_data(chan, (void *)msg);
-				return IRQ_HANDLED;
+				status = IRQ_HANDLED;
 			}
 		}
 	}
-	return IRQ_NONE;
+	return status;
 }
 
 /**
@@ -634,8 +634,13 @@ static int zynqmp_ipi_probe(struct platform_device *pdev)
 	struct zynqmp_ipi_mbox *mbox;
 	int num_mboxes, ret = -EINVAL;
 
-	num_mboxes = of_get_child_count(np);
-	pdata = devm_kzalloc(dev, sizeof(*pdata) + (num_mboxes * sizeof(*mbox)),
+	num_mboxes = of_get_available_child_count(np);
+	if (num_mboxes == 0) {
+		dev_err(dev, "mailbox nodes not available\n");
+		return -EINVAL;
+	}
+
+	pdata = devm_kzalloc(dev, struct_size(pdata, ipi_mboxes, num_mboxes),
 			     GFP_KERNEL);
 	if (!pdata)
 		return -ENOMEM;
@@ -649,8 +654,6 @@ static int zynqmp_ipi_probe(struct platform_device *pdev)
 	}
 
 	pdata->num_mboxes = num_mboxes;
-	pdata->ipi_mboxes = (struct zynqmp_ipi_mbox *)
-			    ((char *)pdata + sizeof(*pdata));
 
 	mbox = pdata->ipi_mboxes;
 	for_each_available_child_of_node(np, nc) {
diff --git a/drivers/md/dm-clone-target.c b/drivers/md/dm-clone-target.c
index 0d38ad623534..e3156b30294f 100644
--- a/drivers/md/dm-clone-target.c
+++ b/drivers/md/dm-clone-target.c
@@ -2221,6 +2221,7 @@ static int __init dm_clone_init(void)
 	r = dm_register_target(&clone_target);
 	if (r < 0) {
 		DMERR("Failed to register clone target");
+		kmem_cache_destroy(_hydration_cache);
 		return r;
 	}
 
diff --git a/drivers/md/dm-flakey.c b/drivers/md/dm-flakey.c
index 36a4ef51ecaa..faae360b881b 100644
--- a/drivers/md/dm-flakey.c
+++ b/drivers/md/dm-flakey.c
@@ -124,9 +124,9 @@ static int parse_features(struct dm_arg_set *as, struct flakey_c *fc,
 			 * Direction r or w?
 			 */
 			arg_name = dm_shift_arg(as);
-			if (!strcasecmp(arg_name, "w"))
+			if (arg_name && !strcasecmp(arg_name, "w"))
 				fc->corrupt_bio_rw = WRITE;
-			else if (!strcasecmp(arg_name, "r"))
+			else if (arg_name && !strcasecmp(arg_name, "r"))
 				fc->corrupt_bio_rw = READ;
 			else {
 				ti->error = "Invalid corrupt bio direction (r or w)";
diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index a1c4cc48bf03..7599a122c956 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -4481,11 +4481,13 @@ static int __init dm_integrity_init(void)
 	}
 
 	r = dm_register_target(&integrity_target);
-
-	if (r < 0)
+	if (r < 0) {
 		DMERR("register failed %d", r);
+		kmem_cache_destroy(journal_io_cache);
+		return r;
+	}
 
-	return r;
+	return 0;
 }
 
 static void __exit dm_integrity_exit(void)
diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
index 20171c9d8952..5f9b9178c647 100644
--- a/drivers/md/dm-ioctl.c
+++ b/drivers/md/dm-ioctl.c
@@ -1435,11 +1435,12 @@ static int table_clear(struct file *filp, struct dm_ioctl *param, size_t param_s
 		hc->new_map = NULL;
 	}
 
-	param->flags &= ~DM_INACTIVE_PRESENT_FLAG;
-
-	__dev_status(hc->md, param);
 	md = hc->md;
 	up_write(&_hash_lock);
+
+	param->flags &= ~DM_INACTIVE_PRESENT_FLAG;
+	__dev_status(md, param);
+
 	if (old_map) {
 		dm_sync_table(md);
 		dm_table_destroy(old_map);
diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
index c801f6b93b7b..0c2048d2b847 100644
--- a/drivers/md/dm-verity-target.c
+++ b/drivers/md/dm-verity-target.c
@@ -475,13 +475,14 @@ static int verity_verify_io(struct dm_verity_io *io)
 	struct bvec_iter start;
 	unsigned b;
 	struct crypto_wait wait;
+	struct bio *bio = dm_bio_from_per_bio_data(io, v->ti->per_io_data_size);
 
 	for (b = 0; b < io->n_blocks; b++) {
 		int r;
 		sector_t cur_block = io->block + b;
 		struct ahash_request *req = verity_io_hash_req(v, io);
 
-		if (v->validated_blocks &&
+		if (v->validated_blocks && bio->bi_status == BLK_STS_OK &&
 		    likely(test_bit(cur_block, v->validated_blocks))) {
 			verity_bv_skip_block(v, io, &io->iter);
 			continue;
@@ -529,9 +530,17 @@ static int verity_verify_io(struct dm_verity_io *io)
 		else if (verity_fec_decode(v, io, DM_VERITY_BLOCK_TYPE_DATA,
 					   cur_block, NULL, &start) == 0)
 			continue;
-		else if (verity_handle_err(v, DM_VERITY_BLOCK_TYPE_DATA,
-					   cur_block))
-			return -EIO;
+		else {
+			if (bio->bi_status) {
+				/*
+				 * Error correction failed; Just return error
+				 */
+				return -EIO;
+			}
+			if (verity_handle_err(v, DM_VERITY_BLOCK_TYPE_DATA,
+					      cur_block))
+				return -EIO;
+		}
 	}
 
 	return 0;
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 0e741a8d278d..6a0459f9fafb 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -2212,11 +2212,22 @@ static void recovery_request_write(struct mddev *mddev, struct r10bio *r10_bio)
 {
 	struct r10conf *conf = mddev->private;
 	int d;
-	struct bio *wbio, *wbio2;
+	struct bio *wbio = r10_bio->devs[1].bio;
+	struct bio *wbio2 = r10_bio->devs[1].repl_bio;
+
+	/* Need to test wbio2->bi_end_io before we call
+	 * submit_bio_noacct as if the former is NULL,
+	 * the latter is free to free wbio2.
+	 */
+	if (wbio2 && !wbio2->bi_end_io)
+		wbio2 = NULL;
 
 	if (!test_bit(R10BIO_Uptodate, &r10_bio->state)) {
 		fix_recovery_read_error(r10_bio);
-		end_sync_request(r10_bio);
+		if (wbio->bi_end_io)
+			end_sync_request(r10_bio);
+		if (wbio2)
+			end_sync_request(r10_bio);
 		return;
 	}
 
@@ -2225,14 +2236,6 @@ static void recovery_request_write(struct mddev *mddev, struct r10bio *r10_bio)
 	 * and submit the write request
 	 */
 	d = r10_bio->devs[1].devnum;
-	wbio = r10_bio->devs[1].bio;
-	wbio2 = r10_bio->devs[1].repl_bio;
-	/* Need to test wbio2->bi_end_io before we call
-	 * submit_bio_noacct as if the former is NULL,
-	 * the latter is free to free wbio2.
-	 */
-	if (wbio2 && !wbio2->bi_end_io)
-		wbio2 = NULL;
 	if (wbio->bi_end_io) {
 		atomic_inc(&conf->mirrors[d].rdev->nr_pending);
 		md_sync_acct(conf->mirrors[d].rdev->bdev, bio_sectors(wbio));
@@ -2900,10 +2903,6 @@ static sector_t raid10_sync_request(struct mddev *mddev, sector_t sector_nr,
 	sector_t chunk_mask = conf->geo.chunk_mask;
 	int page_idx = 0;
 
-	if (!mempool_initialized(&conf->r10buf_pool))
-		if (init_resync(conf))
-			return 0;
-
 	/*
 	 * Allow skipping a full rebuild for incremental assembly
 	 * of a clean array, like RAID1 does.
@@ -2919,6 +2918,10 @@ static sector_t raid10_sync_request(struct mddev *mddev, sector_t sector_nr,
 		return mddev->dev_sectors - sector_nr;
 	}
 
+	if (!mempool_initialized(&conf->r10buf_pool))
+		if (init_resync(conf))
+			return 0;
+
  skipped:
 	max_sector = mddev->dev_sectors;
 	if (test_bit(MD_RECOVERY_SYNC, &mddev->recovery) ||
@@ -3615,6 +3618,20 @@ static int setup_geo(struct geom *geo, struct mddev *mddev, enum geo_type new)
 	return nc*fc;
 }
 
+static void raid10_free_conf(struct r10conf *conf)
+{
+	if (!conf)
+		return;
+
+	mempool_exit(&conf->r10bio_pool);
+	kfree(conf->mirrors);
+	kfree(conf->mirrors_old);
+	kfree(conf->mirrors_new);
+	safe_put_page(conf->tmppage);
+	bioset_exit(&conf->bio_split);
+	kfree(conf);
+}
+
 static struct r10conf *setup_conf(struct mddev *mddev)
 {
 	struct r10conf *conf = NULL;
@@ -3697,13 +3714,7 @@ static struct r10conf *setup_conf(struct mddev *mddev)
 	return conf;
 
  out:
-	if (conf) {
-		mempool_exit(&conf->r10bio_pool);
-		kfree(conf->mirrors);
-		safe_put_page(conf->tmppage);
-		bioset_exit(&conf->bio_split);
-		kfree(conf);
-	}
+	raid10_free_conf(conf);
 	return ERR_PTR(err);
 }
 
@@ -3741,6 +3752,9 @@ static int raid10_run(struct mddev *mddev)
 	if (!conf)
 		goto out;
 
+	mddev->thread = conf->thread;
+	conf->thread = NULL;
+
 	if (mddev_is_clustered(conf->mddev)) {
 		int fc, fo;
 
@@ -3753,9 +3767,6 @@ static int raid10_run(struct mddev *mddev)
 		}
 	}
 
-	mddev->thread = conf->thread;
-	conf->thread = NULL;
-
 	if (mddev->queue) {
 		blk_queue_max_discard_sectors(mddev->queue,
 					      mddev->chunk_sectors);
@@ -3909,10 +3920,7 @@ static int raid10_run(struct mddev *mddev)
 
 out_free_conf:
 	md_unregister_thread(&mddev->thread);
-	mempool_exit(&conf->r10bio_pool);
-	safe_put_page(conf->tmppage);
-	kfree(conf->mirrors);
-	kfree(conf);
+	raid10_free_conf(conf);
 	mddev->private = NULL;
 out:
 	return -EIO;
@@ -3920,15 +3928,7 @@ static int raid10_run(struct mddev *mddev)
 
 static void raid10_free(struct mddev *mddev, void *priv)
 {
-	struct r10conf *conf = priv;
-
-	mempool_exit(&conf->r10bio_pool);
-	safe_put_page(conf->tmppage);
-	kfree(conf->mirrors);
-	kfree(conf->mirrors_old);
-	kfree(conf->mirrors_new);
-	bioset_exit(&conf->bio_split);
-	kfree(conf);
+	raid10_free_conf(priv);
 }
 
 static void raid10_quiesce(struct mddev *mddev, int quiesce)
diff --git a/drivers/media/i2c/max9286.c b/drivers/media/i2c/max9286.c
index 79a11c0184c6..62ce27552dd3 100644
--- a/drivers/media/i2c/max9286.c
+++ b/drivers/media/i2c/max9286.c
@@ -899,6 +899,7 @@ static int max9286_v4l2_register(struct max9286_priv *priv)
 static void max9286_v4l2_unregister(struct max9286_priv *priv)
 {
 	fwnode_handle_put(priv->sd.fwnode);
+	v4l2_ctrl_handler_free(&priv->ctrls);
 	v4l2_async_unregister_subdev(&priv->sd);
 	max9286_v4l2_notifier_unregister(priv);
 }
diff --git a/drivers/media/pci/dm1105/dm1105.c b/drivers/media/pci/dm1105/dm1105.c
index 9dce31d2b525..d2e194a24e7e 100644
--- a/drivers/media/pci/dm1105/dm1105.c
+++ b/drivers/media/pci/dm1105/dm1105.c
@@ -1178,6 +1178,7 @@ static void dm1105_remove(struct pci_dev *pdev)
 	struct dvb_demux *dvbdemux = &dev->demux;
 	struct dmx_demux *dmx = &dvbdemux->dmx;
 
+	cancel_work_sync(&dev->ir.work);
 	dm1105_ir_exit(dev);
 	dmx->close(dmx);
 	dvb_net_release(&dev->dvbnet);
diff --git a/drivers/media/pci/saa7134/saa7134-ts.c b/drivers/media/pci/saa7134/saa7134-ts.c
index 6a5053126237..437dbe5e75e2 100644
--- a/drivers/media/pci/saa7134/saa7134-ts.c
+++ b/drivers/media/pci/saa7134/saa7134-ts.c
@@ -300,6 +300,7 @@ int saa7134_ts_start(struct saa7134_dev *dev)
 
 int saa7134_ts_fini(struct saa7134_dev *dev)
 {
+	del_timer_sync(&dev->ts_q.timeout);
 	saa7134_pgtable_free(dev->pci, &dev->ts_q.pt);
 	return 0;
 }
diff --git a/drivers/media/pci/saa7134/saa7134-vbi.c b/drivers/media/pci/saa7134/saa7134-vbi.c
index 3f0b0933eed6..3e773690468b 100644
--- a/drivers/media/pci/saa7134/saa7134-vbi.c
+++ b/drivers/media/pci/saa7134/saa7134-vbi.c
@@ -185,6 +185,7 @@ int saa7134_vbi_init1(struct saa7134_dev *dev)
 int saa7134_vbi_fini(struct saa7134_dev *dev)
 {
 	/* nothing */
+	del_timer_sync(&dev->vbi_q.timeout);
 	return 0;
 }
 
diff --git a/drivers/media/pci/saa7134/saa7134-video.c b/drivers/media/pci/saa7134/saa7134-video.c
index 85d082baaadc..df9e3293015a 100644
--- a/drivers/media/pci/saa7134/saa7134-video.c
+++ b/drivers/media/pci/saa7134/saa7134-video.c
@@ -2153,6 +2153,7 @@ int saa7134_video_init1(struct saa7134_dev *dev)
 
 void saa7134_video_fini(struct saa7134_dev *dev)
 {
+	del_timer_sync(&dev->video_q.timeout);
 	/* free stuff */
 	saa7134_pgtable_free(dev->pci, &dev->video_q.pt);
 	saa7134_pgtable_free(dev->pci, &dev->vbi_q.pt);
diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
index f2a0ef9ee884..aebd4c664bfa 100644
--- a/drivers/media/platform/qcom/venus/core.h
+++ b/drivers/media/platform/qcom/venus/core.h
@@ -283,7 +283,6 @@ enum venus_dec_state {
 	VENUS_DEC_STATE_DRAIN		= 5,
 	VENUS_DEC_STATE_DECODING	= 6,
 	VENUS_DEC_STATE_DRC		= 7,
-	VENUS_DEC_STATE_DRC_FLUSH_DONE	= 8,
 };
 
 struct venus_ts_metadata {
@@ -348,7 +347,7 @@ struct venus_ts_metadata {
  * @priv:	a private for HFI operations callbacks
  * @session_type:	the type of the session (decoder or encoder)
  * @hprop:	a union used as a holder by get property
- * @last_buf:	last capture buffer for dynamic-resoluton-change
+ * @next_buf_last: a flag to mark next queued capture buffer as last
  */
 struct venus_inst {
 	struct list_head list;
@@ -410,7 +409,8 @@ struct venus_inst {
 	union hfi_get_property hprop;
 	unsigned int core_acquired: 1;
 	unsigned int bit_depth;
-	struct vb2_buffer *last_buf;
+	bool next_buf_last;
+	bool drain_active;
 };
 
 #define IS_V1(core)	((core)->res->hfi_version == HFI_VERSION_1XX)
diff --git a/drivers/media/platform/qcom/venus/helpers.c b/drivers/media/platform/qcom/venus/helpers.c
index 50439eb1ffea..5ca3920237c5 100644
--- a/drivers/media/platform/qcom/venus/helpers.c
+++ b/drivers/media/platform/qcom/venus/helpers.c
@@ -1347,6 +1347,12 @@ void venus_helper_vb2_buf_queue(struct vb2_buffer *vb)
 
 	v4l2_m2m_buf_queue(m2m_ctx, vbuf);
 
+	/* Skip processing queued capture buffers after LAST flag */
+	if (inst->session_type == VIDC_SESSION_TYPE_DEC &&
+	    V4L2_TYPE_IS_CAPTURE(vb->vb2_queue->type) &&
+	    inst->codec_state == VENUS_DEC_STATE_DRC)
+		goto unlock;
+
 	cache_payload(inst, vb);
 
 	if (inst->session_type == VIDC_SESSION_TYPE_ENC &&
diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
index de34a87d1130..c437a929a545 100644
--- a/drivers/media/platform/qcom/venus/vdec.c
+++ b/drivers/media/platform/qcom/venus/vdec.c
@@ -495,6 +495,7 @@ static int
 vdec_decoder_cmd(struct file *file, void *fh, struct v4l2_decoder_cmd *cmd)
 {
 	struct venus_inst *inst = to_inst(file);
+	struct vb2_queue *dst_vq;
 	struct hfi_frame_data fdata = {0};
 	int ret;
 
@@ -518,8 +519,17 @@ vdec_decoder_cmd(struct file *file, void *fh, struct v4l2_decoder_cmd *cmd)
 
 		ret = hfi_session_process_buf(inst, &fdata);
 
-		if (!ret && inst->codec_state == VENUS_DEC_STATE_DECODING)
+		if (!ret && inst->codec_state == VENUS_DEC_STATE_DECODING) {
 			inst->codec_state = VENUS_DEC_STATE_DRAIN;
+			inst->drain_active = true;
+		}
+	} else if (cmd->cmd == V4L2_DEC_CMD_START &&
+		   inst->codec_state == VENUS_DEC_STATE_STOPPED) {
+		dst_vq = v4l2_m2m_get_vq(inst->fh.m2m_ctx,
+					 V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE);
+		vb2_clear_last_buffer_dequeued(dst_vq);
+
+		inst->codec_state = VENUS_DEC_STATE_DECODING;
 	}
 
 unlock:
@@ -636,6 +646,7 @@ static int vdec_output_conf(struct venus_inst *inst)
 {
 	struct venus_core *core = inst->core;
 	struct hfi_enable en = { .enable = 1 };
+	struct hfi_buffer_requirements bufreq;
 	u32 width = inst->out_width;
 	u32 height = inst->out_height;
 	u32 out_fmt, out2_fmt;
@@ -711,6 +722,23 @@ static int vdec_output_conf(struct venus_inst *inst)
 	}
 
 	if (IS_V3(core) || IS_V4(core)) {
+		ret = venus_helper_get_bufreq(inst, HFI_BUFFER_OUTPUT, &bufreq);
+		if (ret)
+			return ret;
+
+		if (bufreq.size > inst->output_buf_size)
+			return -EINVAL;
+
+		if (inst->dpb_fmt) {
+			ret = venus_helper_get_bufreq(inst, HFI_BUFFER_OUTPUT2,
+						      &bufreq);
+			if (ret)
+				return ret;
+
+			if (bufreq.size > inst->output2_buf_size)
+				return -EINVAL;
+		}
+
 		if (inst->output2_buf_size) {
 			ret = venus_helper_set_bufsize(inst,
 						       inst->output2_buf_size,
@@ -916,10 +944,6 @@ static int vdec_start_capture(struct venus_inst *inst)
 		return 0;
 
 reconfigure:
-	ret = hfi_session_flush(inst, HFI_FLUSH_OUTPUT, true);
-	if (ret)
-		return ret;
-
 	ret = vdec_output_conf(inst);
 	if (ret)
 		return ret;
@@ -947,15 +971,21 @@ static int vdec_start_capture(struct venus_inst *inst)
 
 	venus_pm_load_scale(inst);
 
+	inst->next_buf_last = false;
+
 	ret = hfi_session_continue(inst);
 	if (ret)
 		goto free_dpb_bufs;
 
 	inst->codec_state = VENUS_DEC_STATE_DECODING;
 
+	if (inst->drain_active)
+		inst->codec_state = VENUS_DEC_STATE_DRAIN;
+
 	inst->streamon_cap = 1;
 	inst->sequence_cap = 0;
 	inst->reconfig = false;
+	inst->drain_active = false;
 
 	return 0;
 
@@ -971,7 +1001,10 @@ static int vdec_start_output(struct venus_inst *inst)
 
 	if (inst->codec_state == VENUS_DEC_STATE_SEEK) {
 		ret = venus_helper_process_initial_out_bufs(inst);
-		inst->codec_state = VENUS_DEC_STATE_DECODING;
+		if (inst->next_buf_last)
+			inst->codec_state = VENUS_DEC_STATE_DRC;
+		else
+			inst->codec_state = VENUS_DEC_STATE_DECODING;
 		goto done;
 	}
 
@@ -987,6 +1020,7 @@ static int vdec_start_output(struct venus_inst *inst)
 	venus_helper_init_instance(inst);
 	inst->sequence_out = 0;
 	inst->reconfig = false;
+	inst->next_buf_last = false;
 
 	ret = vdec_set_properties(inst);
 	if (ret)
@@ -1076,13 +1110,14 @@ static int vdec_stop_capture(struct venus_inst *inst)
 		ret = hfi_session_flush(inst, HFI_FLUSH_ALL, true);
 		fallthrough;
 	case VENUS_DEC_STATE_DRAIN:
-		vdec_cancel_dst_buffers(inst);
 		inst->codec_state = VENUS_DEC_STATE_STOPPED;
+		inst->drain_active = false;
+		fallthrough;
+	case VENUS_DEC_STATE_SEEK:
+		vdec_cancel_dst_buffers(inst);
 		break;
 	case VENUS_DEC_STATE_DRC:
-		WARN_ON(1);
-		fallthrough;
-	case VENUS_DEC_STATE_DRC_FLUSH_DONE:
+		ret = hfi_session_flush(inst, HFI_FLUSH_OUTPUT, true);
 		inst->codec_state = VENUS_DEC_STATE_CAPTURE_SETUP;
 		venus_helper_free_dpb_bufs(inst);
 		break;
@@ -1101,6 +1136,7 @@ static int vdec_stop_output(struct venus_inst *inst)
 	case VENUS_DEC_STATE_DECODING:
 	case VENUS_DEC_STATE_DRAIN:
 	case VENUS_DEC_STATE_STOPPED:
+	case VENUS_DEC_STATE_DRC:
 		ret = hfi_session_flush(inst, HFI_FLUSH_ALL, true);
 		inst->codec_state = VENUS_DEC_STATE_SEEK;
 		break;
@@ -1206,9 +1242,28 @@ static void vdec_buf_cleanup(struct vb2_buffer *vb)
 static void vdec_vb2_buf_queue(struct vb2_buffer *vb)
 {
 	struct venus_inst *inst = vb2_get_drv_priv(vb->vb2_queue);
+	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
+	static const struct v4l2_event eos = { .type = V4L2_EVENT_EOS };
 
 	vdec_pm_get_put(inst);
 
+	mutex_lock(&inst->lock);
+
+	if (inst->next_buf_last && V4L2_TYPE_IS_CAPTURE(vb->vb2_queue->type) &&
+	    inst->codec_state == VENUS_DEC_STATE_DRC) {
+		vbuf->flags |= V4L2_BUF_FLAG_LAST;
+		vbuf->sequence = inst->sequence_cap++;
+		vbuf->field = V4L2_FIELD_NONE;
+		vb2_set_plane_payload(vb, 0, 0);
+		v4l2_m2m_buf_done(vbuf, VB2_BUF_STATE_DONE);
+		v4l2_event_queue_fh(&inst->fh, &eos);
+		inst->next_buf_last = false;
+		mutex_unlock(&inst->lock);
+		return;
+	}
+
+	mutex_unlock(&inst->lock);
+
 	venus_helper_vb2_buf_queue(vb);
 }
 
@@ -1252,20 +1307,15 @@ static void vdec_buf_done(struct venus_inst *inst, unsigned int buf_type,
 		vb->timestamp = timestamp_us * NSEC_PER_USEC;
 		vbuf->sequence = inst->sequence_cap++;
 
-		if (inst->last_buf == vb) {
-			inst->last_buf = NULL;
-			vbuf->flags |= V4L2_BUF_FLAG_LAST;
-			vb2_set_plane_payload(vb, 0, 0);
-			vb->timestamp = 0;
-		}
-
 		if (vbuf->flags & V4L2_BUF_FLAG_LAST) {
 			const struct v4l2_event ev = { .type = V4L2_EVENT_EOS };
 
 			v4l2_event_queue_fh(&inst->fh, &ev);
 
-			if (inst->codec_state == VENUS_DEC_STATE_DRAIN)
+			if (inst->codec_state == VENUS_DEC_STATE_DRAIN) {
+				inst->drain_active = false;
 				inst->codec_state = VENUS_DEC_STATE_STOPPED;
+			}
 		}
 
 		if (!bytesused)
@@ -1321,19 +1371,16 @@ static void vdec_event_change(struct venus_inst *inst,
 	dev_dbg(dev, VDBGM "event %s sufficient resources (%ux%u)\n",
 		sufficient ? "" : "not", ev_data->width, ev_data->height);
 
-	if (sufficient) {
-		hfi_session_continue(inst);
-	} else {
-		switch (inst->codec_state) {
-		case VENUS_DEC_STATE_INIT:
-			inst->codec_state = VENUS_DEC_STATE_CAPTURE_SETUP;
-			break;
-		case VENUS_DEC_STATE_DECODING:
-			inst->codec_state = VENUS_DEC_STATE_DRC;
-			break;
-		default:
-			break;
-		}
+	switch (inst->codec_state) {
+	case VENUS_DEC_STATE_INIT:
+		inst->codec_state = VENUS_DEC_STATE_CAPTURE_SETUP;
+		break;
+	case VENUS_DEC_STATE_DECODING:
+	case VENUS_DEC_STATE_DRAIN:
+		inst->codec_state = VENUS_DEC_STATE_DRC;
+		break;
+	default:
+		break;
 	}
 
 	/*
@@ -1342,19 +1389,17 @@ static void vdec_event_change(struct venus_inst *inst,
 	 * itself doesn't mark the last decoder output buffer with HFI EOS flag.
 	 */
 
-	if (!sufficient && inst->codec_state == VENUS_DEC_STATE_DRC) {
-		struct vb2_v4l2_buffer *last;
+	if (inst->codec_state == VENUS_DEC_STATE_DRC) {
 		int ret;
 
-		last = v4l2_m2m_last_dst_buf(inst->m2m_ctx);
-		if (last)
-			inst->last_buf = &last->vb2_buf;
+		inst->next_buf_last = true;
 
 		ret = hfi_session_flush(inst, HFI_FLUSH_OUTPUT, false);
 		if (ret)
 			dev_dbg(dev, VDBGH "flush output error %d\n", ret);
 	}
 
+	inst->next_buf_last = true;
 	inst->reconfig = true;
 	v4l2_event_queue_fh(&inst->fh, &ev);
 	wake_up(&inst->reconf_wait);
@@ -1397,8 +1442,7 @@ static void vdec_event_notify(struct venus_inst *inst, u32 event,
 
 static void vdec_flush_done(struct venus_inst *inst)
 {
-	if (inst->codec_state == VENUS_DEC_STATE_DRC)
-		inst->codec_state = VENUS_DEC_STATE_DRC_FLUSH_DONE;
+	dev_dbg(inst->core->dev_dec, VDBGH "flush done\n");
 }
 
 static const struct hfi_inst_ops vdec_hfi_ops = {
diff --git a/drivers/media/platform/rcar_fdp1.c b/drivers/media/platform/rcar_fdp1.c
index c9448de885b6..44a57fa06e74 100644
--- a/drivers/media/platform/rcar_fdp1.c
+++ b/drivers/media/platform/rcar_fdp1.c
@@ -2121,9 +2121,7 @@ static int fdp1_open(struct file *file)
 
 	if (ctx->hdl.error) {
 		ret = ctx->hdl.error;
-		v4l2_ctrl_handler_free(&ctx->hdl);
-		kfree(ctx);
-		goto done;
+		goto error_ctx;
 	}
 
 	ctx->fh.ctrl_handler = &ctx->hdl;
@@ -2137,20 +2135,27 @@ static int fdp1_open(struct file *file)
 
 	if (IS_ERR(ctx->fh.m2m_ctx)) {
 		ret = PTR_ERR(ctx->fh.m2m_ctx);
-
-		v4l2_ctrl_handler_free(&ctx->hdl);
-		kfree(ctx);
-		goto done;
+		goto error_ctx;
 	}
 
 	/* Perform any power management required */
-	pm_runtime_get_sync(fdp1->dev);
+	ret = pm_runtime_resume_and_get(fdp1->dev);
+	if (ret < 0)
+		goto error_pm;
 
 	v4l2_fh_add(&ctx->fh);
 
 	dprintk(fdp1, "Created instance: %p, m2m_ctx: %p\n",
 		ctx, ctx->fh.m2m_ctx);
 
+	mutex_unlock(&fdp1->dev_mutex);
+	return 0;
+
+error_pm:
+       v4l2_m2m_ctx_release(ctx->fh.m2m_ctx);
+error_ctx:
+	v4l2_ctrl_handler_free(&ctx->hdl);
+	kfree(ctx);
 done:
 	mutex_unlock(&fdp1->dev_mutex);
 	return ret;
@@ -2255,7 +2260,6 @@ static int fdp1_probe(struct platform_device *pdev)
 	struct fdp1_dev *fdp1;
 	struct video_device *vfd;
 	struct device_node *fcp_node;
-	struct resource *res;
 	struct clk *clk;
 	unsigned int i;
 
@@ -2282,17 +2286,15 @@ static int fdp1_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, fdp1);
 
 	/* Memory-mapped registers */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	fdp1->regs = devm_ioremap_resource(&pdev->dev, res);
+	fdp1->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(fdp1->regs))
 		return PTR_ERR(fdp1->regs);
 
 	/* Interrupt service routine registration */
-	fdp1->irq = ret = platform_get_irq(pdev, 0);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "cannot find IRQ\n");
+	ret = platform_get_irq(pdev, 0);
+	if (ret < 0)
 		return ret;
-	}
+	fdp1->irq = ret;
 
 	ret = devm_request_irq(&pdev->dev, fdp1->irq, fdp1_irq_handler, 0,
 			       dev_name(&pdev->dev), fdp1);
@@ -2315,8 +2317,10 @@ static int fdp1_probe(struct platform_device *pdev)
 
 	/* Determine our clock rate */
 	clk = clk_get(&pdev->dev, NULL);
-	if (IS_ERR(clk))
-		return PTR_ERR(clk);
+	if (IS_ERR(clk)) {
+		ret = PTR_ERR(clk);
+		goto put_dev;
+	}
 
 	fdp1->clk_rate = clk_get_rate(clk);
 	clk_put(clk);
@@ -2325,7 +2329,7 @@ static int fdp1_probe(struct platform_device *pdev)
 	ret = v4l2_device_register(&pdev->dev, &fdp1->v4l2_dev);
 	if (ret) {
 		v4l2_err(&fdp1->v4l2_dev, "Failed to register video device\n");
-		return ret;
+		goto put_dev;
 	}
 
 	/* M2M registration */
@@ -2355,7 +2359,9 @@ static int fdp1_probe(struct platform_device *pdev)
 
 	/* Power up the cells to read HW */
 	pm_runtime_enable(&pdev->dev);
-	pm_runtime_get_sync(fdp1->dev);
+	ret = pm_runtime_resume_and_get(fdp1->dev);
+	if (ret < 0)
+		goto disable_pm;
 
 	hw_version = fdp1_read(fdp1, FD1_IP_INTDATA);
 	switch (hw_version) {
@@ -2384,12 +2390,17 @@ static int fdp1_probe(struct platform_device *pdev)
 
 	return 0;
 
+disable_pm:
+	pm_runtime_disable(fdp1->dev);
+
 release_m2m:
 	v4l2_m2m_release(fdp1->m2m_dev);
 
 unreg_dev:
 	v4l2_device_unregister(&fdp1->v4l2_dev);
 
+put_dev:
+	rcar_fcp_put(fdp1->fcp);
 	return ret;
 }
 
@@ -2401,6 +2412,7 @@ static int fdp1_remove(struct platform_device *pdev)
 	video_unregister_device(&fdp1->vfd);
 	v4l2_device_unregister(&fdp1->v4l2_dev);
 	pm_runtime_disable(&pdev->dev);
+	rcar_fcp_put(fdp1->fcp);
 
 	return 0;
 }
diff --git a/drivers/media/platform/sti/bdisp/bdisp-v4l2.c b/drivers/media/platform/sti/bdisp/bdisp-v4l2.c
index 85288da9d2ae..182e5a4aeb17 100644
--- a/drivers/media/platform/sti/bdisp/bdisp-v4l2.c
+++ b/drivers/media/platform/sti/bdisp/bdisp-v4l2.c
@@ -1310,6 +1310,8 @@ static int bdisp_probe(struct platform_device *pdev)
 	init_waitqueue_head(&bdisp->irq_queue);
 	INIT_DELAYED_WORK(&bdisp->timeout_work, bdisp_irq_timeout);
 	bdisp->work_queue = create_workqueue(BDISP_NAME);
+	if (!bdisp->work_queue)
+		return -ENOMEM;
 
 	spin_lock_init(&bdisp->slock);
 	mutex_init(&bdisp->lock);
diff --git a/drivers/media/rc/gpio-ir-recv.c b/drivers/media/rc/gpio-ir-recv.c
index a56c844d7f81..16795e07dc10 100644
--- a/drivers/media/rc/gpio-ir-recv.c
+++ b/drivers/media/rc/gpio-ir-recv.c
@@ -107,6 +107,8 @@ static int gpio_ir_recv_probe(struct platform_device *pdev)
 		rcdev->map_name = RC_MAP_EMPTY;
 
 	gpio_dev->rcdev = rcdev;
+	if (of_property_read_bool(np, "wakeup-source"))
+		device_init_wakeup(dev, true);
 
 	rc = devm_rc_register_device(dev, rcdev);
 	if (rc < 0) {
diff --git a/drivers/mfd/tqmx86.c b/drivers/mfd/tqmx86.c
index 732013f40e4e..0498f1b7e2e3 100644
--- a/drivers/mfd/tqmx86.c
+++ b/drivers/mfd/tqmx86.c
@@ -16,8 +16,8 @@
 #include <linux/platform_data/i2c-ocores.h>
 #include <linux/platform_device.h>
 
-#define TQMX86_IOBASE	0x160
-#define TQMX86_IOSIZE	0x3f
+#define TQMX86_IOBASE	0x180
+#define TQMX86_IOSIZE	0x20
 #define TQMX86_IOBASE_I2C	0x1a0
 #define TQMX86_IOSIZE_I2C	0xa
 #define TQMX86_IOBASE_WATCHDOG	0x18b
@@ -25,29 +25,33 @@
 #define TQMX86_IOBASE_GPIO	0x18d
 #define TQMX86_IOSIZE_GPIO	0x4
 
-#define TQMX86_REG_BOARD_ID	0x20
+#define TQMX86_REG_BOARD_ID	0x00
 #define TQMX86_REG_BOARD_ID_E38M	1
 #define TQMX86_REG_BOARD_ID_50UC	2
 #define TQMX86_REG_BOARD_ID_E38C	3
 #define TQMX86_REG_BOARD_ID_60EB	4
-#define TQMX86_REG_BOARD_ID_E39M	5
-#define TQMX86_REG_BOARD_ID_E39C	6
-#define TQMX86_REG_BOARD_ID_E39x	7
+#define TQMX86_REG_BOARD_ID_E39MS	5
+#define TQMX86_REG_BOARD_ID_E39C1	6
+#define TQMX86_REG_BOARD_ID_E39C2	7
 #define TQMX86_REG_BOARD_ID_70EB	8
 #define TQMX86_REG_BOARD_ID_80UC	9
-#define TQMX86_REG_BOARD_ID_90UC	10
-#define TQMX86_REG_BOARD_REV	0x21
-#define TQMX86_REG_IO_EXT_INT	0x26
+#define TQMX86_REG_BOARD_ID_110EB	11
+#define TQMX86_REG_BOARD_ID_E40M	12
+#define TQMX86_REG_BOARD_ID_E40S	13
+#define TQMX86_REG_BOARD_ID_E40C1	14
+#define TQMX86_REG_BOARD_ID_E40C2	15
+#define TQMX86_REG_BOARD_REV	0x01
+#define TQMX86_REG_IO_EXT_INT	0x06
 #define TQMX86_REG_IO_EXT_INT_NONE		0
 #define TQMX86_REG_IO_EXT_INT_7			1
 #define TQMX86_REG_IO_EXT_INT_9			2
 #define TQMX86_REG_IO_EXT_INT_12		3
 #define TQMX86_REG_IO_EXT_INT_MASK		0x3
 #define TQMX86_REG_IO_EXT_INT_GPIO_SHIFT	4
+#define TQMX86_REG_SAUC		0x17
 
-#define TQMX86_REG_I2C_DETECT	0x47
+#define TQMX86_REG_I2C_DETECT	0x1a7
 #define TQMX86_REG_I2C_DETECT_SOFT		0xa5
-#define TQMX86_REG_I2C_INT_EN	0x49
 
 static uint gpio_irq;
 module_param(gpio_irq, uint, 0);
@@ -107,7 +111,7 @@ static const struct mfd_cell tqmx86_devs[] = {
 	},
 };
 
-static const char *tqmx86_board_id_to_name(u8 board_id)
+static const char *tqmx86_board_id_to_name(u8 board_id, u8 sauc)
 {
 	switch (board_id) {
 	case TQMX86_REG_BOARD_ID_E38M:
@@ -118,18 +122,26 @@ static const char *tqmx86_board_id_to_name(u8 board_id)
 		return "TQMxE38C";
 	case TQMX86_REG_BOARD_ID_60EB:
 		return "TQMx60EB";
-	case TQMX86_REG_BOARD_ID_E39M:
-		return "TQMxE39M";
-	case TQMX86_REG_BOARD_ID_E39C:
-		return "TQMxE39C";
-	case TQMX86_REG_BOARD_ID_E39x:
-		return "TQMxE39x";
+	case TQMX86_REG_BOARD_ID_E39MS:
+		return (sauc == 0xff) ? "TQMxE39M" : "TQMxE39S";
+	case TQMX86_REG_BOARD_ID_E39C1:
+		return "TQMxE39C1";
+	case TQMX86_REG_BOARD_ID_E39C2:
+		return "TQMxE39C2";
 	case TQMX86_REG_BOARD_ID_70EB:
 		return "TQMx70EB";
 	case TQMX86_REG_BOARD_ID_80UC:
 		return "TQMx80UC";
-	case TQMX86_REG_BOARD_ID_90UC:
-		return "TQMx90UC";
+	case TQMX86_REG_BOARD_ID_110EB:
+		return "TQMx110EB";
+	case TQMX86_REG_BOARD_ID_E40M:
+		return "TQMxE40M";
+	case TQMX86_REG_BOARD_ID_E40S:
+		return "TQMxE40S";
+	case TQMX86_REG_BOARD_ID_E40C1:
+		return "TQMxE40C1";
+	case TQMX86_REG_BOARD_ID_E40C2:
+		return "TQMxE40C2";
 	default:
 		return "Unknown";
 	}
@@ -142,11 +154,15 @@ static int tqmx86_board_id_to_clk_rate(u8 board_id)
 	case TQMX86_REG_BOARD_ID_60EB:
 	case TQMX86_REG_BOARD_ID_70EB:
 	case TQMX86_REG_BOARD_ID_80UC:
-	case TQMX86_REG_BOARD_ID_90UC:
+	case TQMX86_REG_BOARD_ID_110EB:
+	case TQMX86_REG_BOARD_ID_E40M:
+	case TQMX86_REG_BOARD_ID_E40S:
+	case TQMX86_REG_BOARD_ID_E40C1:
+	case TQMX86_REG_BOARD_ID_E40C2:
 		return 24000;
-	case TQMX86_REG_BOARD_ID_E39M:
-	case TQMX86_REG_BOARD_ID_E39C:
-	case TQMX86_REG_BOARD_ID_E39x:
+	case TQMX86_REG_BOARD_ID_E39MS:
+	case TQMX86_REG_BOARD_ID_E39C1:
+	case TQMX86_REG_BOARD_ID_E39C2:
 		return 25000;
 	case TQMX86_REG_BOARD_ID_E38M:
 	case TQMX86_REG_BOARD_ID_E38C:
@@ -158,7 +174,7 @@ static int tqmx86_board_id_to_clk_rate(u8 board_id)
 
 static int tqmx86_probe(struct platform_device *pdev)
 {
-	u8 board_id, rev, i2c_det, io_ext_int_val;
+	u8 board_id, sauc, rev, i2c_det, io_ext_int_val;
 	struct device *dev = &pdev->dev;
 	u8 gpio_irq_cfg, readback;
 	const char *board_name;
@@ -188,14 +204,20 @@ static int tqmx86_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	board_id = ioread8(io_base + TQMX86_REG_BOARD_ID);
-	board_name = tqmx86_board_id_to_name(board_id);
+	sauc = ioread8(io_base + TQMX86_REG_SAUC);
+	board_name = tqmx86_board_id_to_name(board_id, sauc);
 	rev = ioread8(io_base + TQMX86_REG_BOARD_REV);
 
 	dev_info(dev,
 		 "Found %s - Board ID %d, PCB Revision %d, PLD Revision %d\n",
 		 board_name, board_id, rev >> 4, rev & 0xf);
 
-	i2c_det = ioread8(io_base + TQMX86_REG_I2C_DETECT);
+	/*
+	 * The I2C_DETECT register is in the range assigned to the I2C driver
+	 * later, so we don't extend TQMX86_IOSIZE. Use inb() for this one-off
+	 * access instead of ioport_map + unmap.
+	 */
+	i2c_det = inb(TQMX86_REG_I2C_DETECT);
 
 	if (gpio_irq_cfg) {
 		io_ext_int_val =
diff --git a/drivers/misc/vmw_vmci/vmci_host.c b/drivers/misc/vmw_vmci/vmci_host.c
index 2d8328d928d5..4a903770b8e1 100644
--- a/drivers/misc/vmw_vmci/vmci_host.c
+++ b/drivers/misc/vmw_vmci/vmci_host.c
@@ -165,10 +165,16 @@ static int vmci_host_close(struct inode *inode, struct file *filp)
 static __poll_t vmci_host_poll(struct file *filp, poll_table *wait)
 {
 	struct vmci_host_dev *vmci_host_dev = filp->private_data;
-	struct vmci_ctx *context = vmci_host_dev->context;
+	struct vmci_ctx *context;
 	__poll_t mask = 0;
 
 	if (vmci_host_dev->ct_type == VMCIOBJ_CONTEXT) {
+		/*
+		 * Read context only if ct_type == VMCIOBJ_CONTEXT to make
+		 * sure that context is initialized
+		 */
+		context = vmci_host_dev->context;
+
 		/* Check for VMCI calls to this VM context. */
 		if (wait)
 			poll_wait(filp, &context->host_context.wait_queue,
diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index d53374991e13..5b853f651b38 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -126,6 +126,7 @@ static u32 esdhc_readl_fixup(struct sdhci_host *host,
 			return ret;
 		}
 	}
+
 	/*
 	 * The DAT[3:0] line signal levels and the CMD line signal level are
 	 * not compatible with standard SDHC register. The line signal levels
@@ -137,6 +138,16 @@ static u32 esdhc_readl_fixup(struct sdhci_host *host,
 		ret = value & 0x000fffff;
 		ret |= (value >> 4) & SDHCI_DATA_LVL_MASK;
 		ret |= (value << 1) & SDHCI_CMD_LVL;
+
+		/*
+		 * Some controllers have unreliable Data Line Active
+		 * bit for commands with busy signal. This affects
+		 * Command Inhibit (data) bit. Just ignore it since
+		 * MMC core driver has already polled card status
+		 * with CMD13 after any command with busy siganl.
+		 */
+		if (esdhc->quirk_ignore_data_inhibit)
+			ret &= ~SDHCI_DATA_INHIBIT;
 		return ret;
 	}
 
@@ -151,19 +162,6 @@ static u32 esdhc_readl_fixup(struct sdhci_host *host,
 		return ret;
 	}
 
-	/*
-	 * Some controllers have unreliable Data Line Active
-	 * bit for commands with busy signal. This affects
-	 * Command Inhibit (data) bit. Just ignore it since
-	 * MMC core driver has already polled card status
-	 * with CMD13 after any command with busy siganl.
-	 */
-	if ((spec_reg == SDHCI_PRESENT_STATE) &&
-	(esdhc->quirk_ignore_data_inhibit == true)) {
-		ret = value & ~SDHCI_DATA_INHIBIT;
-		return ret;
-	}
-
 	ret = value;
 	return ret;
 }
diff --git a/drivers/mtd/ubi/eba.c b/drivers/mtd/ubi/eba.c
index 0edecfdbd01f..b4cdf2351cac 100644
--- a/drivers/mtd/ubi/eba.c
+++ b/drivers/mtd/ubi/eba.c
@@ -947,7 +947,7 @@ static int try_write_vid_and_data(struct ubi_volume *vol, int lnum,
 				  int offset, int len)
 {
 	struct ubi_device *ubi = vol->ubi;
-	int pnum, opnum, err, vol_id = vol->vol_id;
+	int pnum, opnum, err, err2, vol_id = vol->vol_id;
 
 	pnum = ubi_wl_get_peb(ubi);
 	if (pnum < 0) {
@@ -982,10 +982,19 @@ static int try_write_vid_and_data(struct ubi_volume *vol, int lnum,
 out_put:
 	up_read(&ubi->fm_eba_sem);
 
-	if (err && pnum >= 0)
-		err = ubi_wl_put_peb(ubi, vol_id, lnum, pnum, 1);
-	else if (!err && opnum >= 0)
-		err = ubi_wl_put_peb(ubi, vol_id, lnum, opnum, 0);
+	if (err && pnum >= 0) {
+		err2 = ubi_wl_put_peb(ubi, vol_id, lnum, pnum, 1);
+		if (err2) {
+			ubi_warn(ubi, "failed to return physical eraseblock %d, error %d",
+				 pnum, err2);
+		}
+	} else if (!err && opnum >= 0) {
+		err2 = ubi_wl_put_peb(ubi, vol_id, lnum, opnum, 0);
+		if (err2) {
+			ubi_warn(ubi, "failed to return physical eraseblock %d, error %d",
+				 opnum, err2);
+		}
+	}
 
 	return err;
 }
diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 70155e996f7d..d3b42adef057 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -404,9 +404,9 @@ mt7530_pad_clk_setup(struct dsa_switch *ds, phy_interface_t interface)
 	case PHY_INTERFACE_MODE_TRGMII:
 		trgint = 1;
 		if (priv->id == ID_MT7621) {
-			/* PLL frequency: 150MHz: 1.2GBit */
+			/* PLL frequency: 125MHz: 1.0GBit */
 			if (xtal == HWTRAP_XTAL_40MHZ)
-				ncpo1 = 0x0780;
+				ncpo1 = 0x0640;
 			if (xtal == HWTRAP_XTAL_25MHZ)
 				ncpo1 = 0x0a00;
 		} else { /* PLL frequency: 250MHz: 2.0Gbit */
diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 0b104a90c0d8..321c821876f6 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -4182,6 +4182,7 @@ static const struct mv88e6xxx_ops mv88e6321_ops = {
 	.set_cpu_port = mv88e6095_g1_set_cpu_port,
 	.set_egress_port = mv88e6095_g1_set_egress_port,
 	.watchdog_ops = &mv88e6390_watchdog_ops,
+	.mgmt_rsvd2cpu = mv88e6352_g2_mgmt_rsvd2cpu,
 	.reset = mv88e6352_g1_reset,
 	.vtu_getnext = mv88e6185_g1_vtu_getnext,
 	.vtu_loadpurge = mv88e6185_g1_vtu_loadpurge,
diff --git a/drivers/net/ethernet/amd/nmclan_cs.c b/drivers/net/ethernet/amd/nmclan_cs.c
index 11c0b13edd30..f34881637505 100644
--- a/drivers/net/ethernet/amd/nmclan_cs.c
+++ b/drivers/net/ethernet/amd/nmclan_cs.c
@@ -650,7 +650,7 @@ static int nmclan_config(struct pcmcia_device *link)
     } else {
       pr_notice("mace id not found: %x %x should be 0x40 0x?9\n",
 		sig[0], sig[1]);
-      return -ENODEV;
+      goto failed;
     }
   }
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_qos.c b/drivers/net/ethernet/freescale/enetc/enetc_qos.c
index 5841721c8119..8d92dc6bc994 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_qos.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_qos.c
@@ -1266,7 +1266,7 @@ static int enetc_psfp_parse_clsflower(struct enetc_ndev_priv *priv,
 		int index;
 
 		index = enetc_get_free_index(priv);
-		if (sfi->handle < 0) {
+		if (index < 0) {
 			NL_SET_ERR_MSG_MOD(extack, "No Stream Filter resource!");
 			err = -ENOSPC;
 			goto free_fmi;
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index 55983904b6df..2eb133183473 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -2641,6 +2641,14 @@ static int ixgbe_get_rss_hash_opts(struct ixgbe_adapter *adapter,
 	return 0;
 }
 
+static int ixgbe_rss_indir_tbl_max(struct ixgbe_adapter *adapter)
+{
+	if (adapter->hw.mac.type < ixgbe_mac_X550)
+		return 16;
+	else
+		return 64;
+}
+
 static int ixgbe_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd,
 			   u32 *rule_locs)
 {
@@ -2649,7 +2657,8 @@ static int ixgbe_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd,
 
 	switch (cmd->cmd) {
 	case ETHTOOL_GRXRINGS:
-		cmd->data = adapter->num_rx_queues;
+		cmd->data = min_t(int, adapter->num_rx_queues,
+				  ixgbe_rss_indir_tbl_max(adapter));
 		ret = 0;
 		break;
 	case ETHTOOL_GRXCLSRLCNT:
@@ -3051,14 +3060,6 @@ static int ixgbe_set_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd)
 	return ret;
 }
 
-static int ixgbe_rss_indir_tbl_max(struct ixgbe_adapter *adapter)
-{
-	if (adapter->hw.mac.type < ixgbe_mac_X550)
-		return 16;
-	else
-		return 64;
-}
-
 static u32 ixgbe_get_rxfh_key_size(struct net_device *netdev)
 {
 	return IXGBE_RSS_KEY_SIZE;
@@ -3107,8 +3108,8 @@ static int ixgbe_set_rxfh(struct net_device *netdev, const u32 *indir,
 	int i;
 	u32 reta_entries = ixgbe_rss_indir_tbl_entries(adapter);
 
-	if (hfunc)
-		return -EINVAL;
+	if (hfunc != ETH_RSS_HASH_NO_CHANGE && hfunc != ETH_RSS_HASH_TOP)
+		return -EOPNOTSUPP;
 
 	/* Fill out the redirection table */
 	if (indir) {
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index 161174be51c3..54aeb276b9a0 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -1589,11 +1589,20 @@ int otx2_open(struct net_device *netdev)
 	otx2_config_pause_frm(pf);
 
 	err = otx2_rxtx_enable(pf, true);
-	if (err)
+	/* If a mbox communication error happens at this point then interface
+	 * will end up in a state such that it is in down state but hardware
+	 * mcam entries are enabled to receive the packets. Hence disable the
+	 * packet I/O.
+	 */
+	if (err == EIO)
+		goto err_disable_rxtx;
+	else if (err)
 		goto err_tx_stop_queues;
 
 	return 0;
 
+err_disable_rxtx:
+	otx2_rxtx_enable(pf, false);
 err_tx_stop_queues:
 	netif_tx_stop_all_queues(netdev);
 	netif_carrier_off(netdev);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
index 67fabf265fe6..5310b71795ec 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
@@ -542,7 +542,7 @@ static int otx2vf_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	err = otx2vf_realloc_msix_vectors(vf);
 	if (err)
-		goto err_mbox_destroy;
+		goto err_detach_rsrc;
 
 	err = otx2_set_real_num_queues(netdev, qcount, qcount);
 	if (err)
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
index 35c72d4a78b3..8e5b01af85ed 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
@@ -693,7 +693,7 @@ static int ionic_get_rxnfc(struct net_device *netdev,
 		info->data = lif->nxqs;
 		break;
 	default:
-		netdev_err(netdev, "Command parameter %d is not supported\n",
+		netdev_dbg(netdev, "Command parameter %d is not supported\n",
 			   info->cmd);
 		err = -EOPNOTSUPP;
 	}
diff --git a/drivers/net/ethernet/sfc/mcdi_port_common.c b/drivers/net/ethernet/sfc/mcdi_port_common.c
index c4fe3c48ac46..eccb97a5d938 100644
--- a/drivers/net/ethernet/sfc/mcdi_port_common.c
+++ b/drivers/net/ethernet/sfc/mcdi_port_common.c
@@ -974,12 +974,15 @@ static u32 efx_mcdi_phy_module_type(struct efx_nic *efx)
 
 	/* A QSFP+ NIC may actually have an SFP+ module attached.
 	 * The ID is page 0, byte 0.
+	 * QSFP28 is of type SFF_8636, however, this is treated
+	 * the same by ethtool, so we can also treat them the same.
 	 */
 	switch (efx_mcdi_phy_get_module_eeprom_byte(efx, 0, 0)) {
-	case 0x3:
+	case 0x3: /* SFP */
 		return MC_CMD_MEDIA_SFP_PLUS;
-	case 0xc:
-	case 0xd:
+	case 0xc: /* QSFP */
+	case 0xd: /* QSFP+ */
+	case 0x11: /* QSFP28 */
 		return MC_CMD_MEDIA_QSFP_PLUS;
 	default:
 		return 0;
@@ -1077,7 +1080,7 @@ int efx_mcdi_phy_get_module_info(struct efx_nic *efx, struct ethtool_modinfo *mo
 
 	case MC_CMD_MEDIA_QSFP_PLUS:
 		modinfo->type = ETH_MODULE_SFF_8436;
-		modinfo->eeprom_len = ETH_MODULE_SFF_8436_LEN;
+		modinfo->eeprom_len = ETH_MODULE_SFF_8436_MAX_LEN;
 		break;
 
 	default:
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index e7fbc9b30bf9..d0d47d91b460 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -1194,9 +1194,6 @@ static int phy_power_on(struct rk_priv_data *bsp_priv, bool enable)
 	int ret;
 	struct device *dev = &bsp_priv->pdev->dev;
 
-	if (!ldo)
-		return 0;
-
 	if (enable) {
 		ret = regulator_enable(ldo);
 		if (ret)
@@ -1227,14 +1224,11 @@ static struct rk_priv_data *rk_gmac_setup(struct platform_device *pdev,
 	of_get_phy_mode(dev->of_node, &bsp_priv->phy_iface);
 	bsp_priv->ops = ops;
 
-	bsp_priv->regulator = devm_regulator_get_optional(dev, "phy");
+	bsp_priv->regulator = devm_regulator_get(dev, "phy");
 	if (IS_ERR(bsp_priv->regulator)) {
-		if (PTR_ERR(bsp_priv->regulator) == -EPROBE_DEFER) {
-			dev_err(dev, "phy regulator is not available yet, deferred probing\n");
-			return ERR_PTR(-EPROBE_DEFER);
-		}
-		dev_err(dev, "no regulator found\n");
-		bsp_priv->regulator = NULL;
+		ret = PTR_ERR(bsp_priv->regulator);
+		dev_err_probe(dev, ret, "failed to get phy regulator\n");
+		return ERR_PTR(ret);
 	}
 
 	ret = of_property_read_string(dev->of_node, "clock_in_out", &strings);
diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 47c9118cc92a..119a32f34b53 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2747,6 +2747,27 @@ static void free_receive_page_frags(struct virtnet_info *vi)
 			put_page(vi->rq[i].alloc_frag.page);
 }
 
+static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf)
+{
+	if (!is_xdp_frame(buf))
+		dev_kfree_skb(buf);
+	else
+		xdp_return_frame(ptr_to_xdp(buf));
+}
+
+static void virtnet_rq_free_unused_buf(struct virtqueue *vq, void *buf)
+{
+	struct virtnet_info *vi = vq->vdev->priv;
+	int i = vq2rxq(vq);
+
+	if (vi->mergeable_rx_bufs)
+		put_page(virt_to_head_page(buf));
+	else if (vi->big_packets)
+		give_pages(&vi->rq[i], buf);
+	else
+		put_page(virt_to_head_page(buf));
+}
+
 static void free_unused_bufs(struct virtnet_info *vi)
 {
 	void *buf;
@@ -2754,26 +2775,16 @@ static void free_unused_bufs(struct virtnet_info *vi)
 
 	for (i = 0; i < vi->max_queue_pairs; i++) {
 		struct virtqueue *vq = vi->sq[i].vq;
-		while ((buf = virtqueue_detach_unused_buf(vq)) != NULL) {
-			if (!is_xdp_frame(buf))
-				dev_kfree_skb(buf);
-			else
-				xdp_return_frame(ptr_to_xdp(buf));
-		}
+		while ((buf = virtqueue_detach_unused_buf(vq)) != NULL)
+			virtnet_sq_free_unused_buf(vq, buf);
+		cond_resched();
 	}
 
 	for (i = 0; i < vi->max_queue_pairs; i++) {
 		struct virtqueue *vq = vi->rq[i].vq;
-
-		while ((buf = virtqueue_detach_unused_buf(vq)) != NULL) {
-			if (vi->mergeable_rx_bufs) {
-				put_page(virt_to_head_page(buf));
-			} else if (vi->big_packets) {
-				give_pages(&vi->rq[i], buf);
-			} else {
-				put_page(virt_to_head_page(buf));
-			}
-		}
+		while ((buf = virtqueue_detach_unused_buf(vq)) != NULL)
+			virtnet_rq_free_unused_buf(vq, buf);
+		cond_resched();
 	}
 }
 
diff --git a/drivers/net/wireguard/timers.c b/drivers/net/wireguard/timers.c
index d54d32ac9bc4..91f5d6d2d4e2 100644
--- a/drivers/net/wireguard/timers.c
+++ b/drivers/net/wireguard/timers.c
@@ -46,7 +46,7 @@ static void wg_expired_retransmit_handshake(struct timer_list *timer)
 	if (peer->timer_handshake_attempts > MAX_TIMER_HANDSHAKES) {
 		pr_debug("%s: Handshake for peer %llu (%pISpfsc) did not complete after %d attempts, giving up\n",
 			 peer->device->dev->name, peer->internal_id,
-			 &peer->endpoint.addr, MAX_TIMER_HANDSHAKES + 2);
+			 &peer->endpoint.addr, (int)MAX_TIMER_HANDSHAKES + 2);
 
 		del_timer(&peer->timer_send_keepalive);
 		/* We drop all packets without a keypair and don't try again,
@@ -64,7 +64,7 @@ static void wg_expired_retransmit_handshake(struct timer_list *timer)
 		++peer->timer_handshake_attempts;
 		pr_debug("%s: Handshake for peer %llu (%pISpfsc) did not complete after %d seconds, retrying (try %d)\n",
 			 peer->device->dev->name, peer->internal_id,
-			 &peer->endpoint.addr, REKEY_TIMEOUT,
+			 &peer->endpoint.addr, (int)REKEY_TIMEOUT,
 			 peer->timer_handshake_attempts + 1);
 
 		/* We clear the endpoint address src address, in case this is
@@ -94,7 +94,7 @@ static void wg_expired_new_handshake(struct timer_list *timer)
 
 	pr_debug("%s: Retrying handshake with peer %llu (%pISpfsc) because we stopped hearing back after %d seconds\n",
 		 peer->device->dev->name, peer->internal_id,
-		 &peer->endpoint.addr, KEEPALIVE_TIMEOUT + REKEY_TIMEOUT);
+		 &peer->endpoint.addr, (int)(KEEPALIVE_TIMEOUT + REKEY_TIMEOUT));
 	/* We clear the endpoint address src address, in case this is the cause
 	 * of trouble.
 	 */
@@ -126,7 +126,7 @@ static void wg_queued_expired_zero_key_material(struct work_struct *work)
 
 	pr_debug("%s: Zeroing out all keys for peer %llu (%pISpfsc), since we haven't received a new one in %d seconds\n",
 		 peer->device->dev->name, peer->internal_id,
-		 &peer->endpoint.addr, REJECT_AFTER_TIME * 3);
+		 &peer->endpoint.addr, (int)REJECT_AFTER_TIME * 3);
 	wg_noise_handshake_clear(&peer->handshake);
 	wg_noise_keypairs_clear(&peer->keypairs);
 	wg_peer_put(peer);
diff --git a/drivers/net/wireless/ath/ath5k/eeprom.c b/drivers/net/wireless/ath/ath5k/eeprom.c
index d444b3d70ba2..58d3e86f6256 100644
--- a/drivers/net/wireless/ath/ath5k/eeprom.c
+++ b/drivers/net/wireless/ath/ath5k/eeprom.c
@@ -529,7 +529,7 @@ ath5k_eeprom_read_freq_list(struct ath5k_hw *ah, int *offset, int max,
 		ee->ee_n_piers[mode]++;
 
 		freq2 = (val >> 8) & 0xff;
-		if (!freq2)
+		if (!freq2 || i >= max)
 			break;
 
 		pc[i++].freq = ath5k_eeprom_bin2freq(ee,
diff --git a/drivers/net/wireless/ath/ath6kl/bmi.c b/drivers/net/wireless/ath/ath6kl/bmi.c
index bde5a10d470c..af98e871199d 100644
--- a/drivers/net/wireless/ath/ath6kl/bmi.c
+++ b/drivers/net/wireless/ath/ath6kl/bmi.c
@@ -246,7 +246,7 @@ int ath6kl_bmi_execute(struct ath6kl *ar, u32 addr, u32 *param)
 		return -EACCES;
 	}
 
-	size = sizeof(cid) + sizeof(addr) + sizeof(param);
+	size = sizeof(cid) + sizeof(addr) + sizeof(*param);
 	if (size > ar->bmi.max_cmd_size) {
 		WARN_ON(1);
 		return -EINVAL;
diff --git a/drivers/net/wireless/ath/ath6kl/htc_pipe.c b/drivers/net/wireless/ath/ath6kl/htc_pipe.c
index c68848819a52..9b88d96bfe96 100644
--- a/drivers/net/wireless/ath/ath6kl/htc_pipe.c
+++ b/drivers/net/wireless/ath/ath6kl/htc_pipe.c
@@ -960,8 +960,8 @@ static int ath6kl_htc_pipe_rx_complete(struct ath6kl *ar, struct sk_buff *skb,
 	 * Thus the possibility of ar->htc_target being NULL
 	 * via ath6kl_recv_complete -> ath6kl_usb_io_comp_work.
 	 */
-	if (WARN_ON_ONCE(!target)) {
-		ath6kl_err("Target not yet initialized\n");
+	if (!target) {
+		ath6kl_dbg(ATH6KL_DBG_HTC, "Target not yet initialized\n");
 		status = -EINVAL;
 		goto free_skb;
 	}
diff --git a/drivers/net/wireless/ath/ath9k/hif_usb.c b/drivers/net/wireless/ath/ath9k/hif_usb.c
index f521dfa2f194..e0130beb304d 100644
--- a/drivers/net/wireless/ath/ath9k/hif_usb.c
+++ b/drivers/net/wireless/ath/ath9k/hif_usb.c
@@ -534,6 +534,24 @@ static struct ath9k_htc_hif hif_usb = {
 	.send = hif_usb_send,
 };
 
+/* Need to free remain_skb allocated in ath9k_hif_usb_rx_stream
+ * in case ath9k_hif_usb_rx_stream wasn't called next time to
+ * process the buffer and subsequently free it.
+ */
+static void ath9k_hif_usb_free_rx_remain_skb(struct hif_device_usb *hif_dev)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&hif_dev->rx_lock, flags);
+	if (hif_dev->remain_skb) {
+		dev_kfree_skb_any(hif_dev->remain_skb);
+		hif_dev->remain_skb = NULL;
+		hif_dev->rx_remain_len = 0;
+		RX_STAT_INC(hif_dev, skb_dropped);
+	}
+	spin_unlock_irqrestore(&hif_dev->rx_lock, flags);
+}
+
 static void ath9k_hif_usb_rx_stream(struct hif_device_usb *hif_dev,
 				    struct sk_buff *skb)
 {
@@ -868,6 +886,7 @@ static int ath9k_hif_usb_alloc_tx_urbs(struct hif_device_usb *hif_dev)
 static void ath9k_hif_usb_dealloc_rx_urbs(struct hif_device_usb *hif_dev)
 {
 	usb_kill_anchored_urbs(&hif_dev->rx_submitted);
+	ath9k_hif_usb_free_rx_remain_skb(hif_dev);
 }
 
 static int ath9k_hif_usb_alloc_rx_urbs(struct hif_device_usb *hif_dev)
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 0a069bc7f156..df5970619712 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -5834,6 +5834,11 @@ static s32 brcmf_get_assoc_ies(struct brcmf_cfg80211_info *cfg,
 		(struct brcmf_cfg80211_assoc_ielen_le *)cfg->extra_buf;
 	req_len = le32_to_cpu(assoc_info->req_len);
 	resp_len = le32_to_cpu(assoc_info->resp_len);
+	if (req_len > WL_EXTRA_BUF_MAX || resp_len > WL_EXTRA_BUF_MAX) {
+		bphy_err(drvr, "invalid lengths in assoc info: req %u resp %u\n",
+			 req_len, resp_len);
+		return -EINVAL;
+	}
 	if (req_len) {
 		err = brcmf_fil_iovar_data_get(ifp, "assoc_req_ies",
 					       cfg->extra_buf,
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index 419eaa5cf0b5..79d08e5d9a81 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -1372,13 +1372,13 @@ static void iwl_ini_get_rxf_data(struct iwl_fw_runtime *fwrt,
 	if (!data)
 		return;
 
+	memset(data, 0, sizeof(*data));
+
 	/* make sure only one bit is set in only one fid */
 	if (WARN_ONCE(hweight_long(fid1) + hweight_long(fid2) != 1,
 		      "fid1=%x, fid2=%x\n", fid1, fid2))
 		return;
 
-	memset(data, 0, sizeof(*data));
-
 	if (fid1) {
 		fifo_idx = ffs(fid1) - 1;
 		if (WARN_ONCE(fifo_idx >= MAX_NUM_LMAC, "fifo_idx=%d\n",
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/debugfs.c b/drivers/net/wireless/intel/iwlwifi/fw/debugfs.c
index 267ad4eddb5c..24d6ed3513ce 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/debugfs.c
@@ -344,8 +344,10 @@ static void *iwl_dbgfs_fw_info_seq_next(struct seq_file *seq,
 	const struct iwl_fw *fw = priv->fwrt->fw;
 
 	*pos = ++state->pos;
-	if (*pos >= fw->ucode_capa.n_cmd_versions)
+	if (*pos >= fw->ucode_capa.n_cmd_versions) {
+		kfree(state);
 		return NULL;
+	}
 
 	return state;
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
index 3c931b1b2a0b..fdf2c6ea41d9 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
@@ -191,6 +191,12 @@ static int iwl_dbg_tlv_alloc_buf_alloc(struct iwl_trans *trans,
 	    alloc_id != IWL_FW_INI_ALLOCATION_ID_INTERNAL)
 		goto err;
 
+	if (buf_location == IWL_FW_INI_LOCATION_DRAM_PATH &&
+	    alloc->req_size == 0) {
+		IWL_ERR(trans, "WRT: Invalid DRAM buffer allocation requested size (0)\n");
+		return -EINVAL;
+	}
+
 	trans->dbg.fw_mon_cfg[alloc_id] = *alloc;
 
 	return 0;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
index 3395c4675988..36f75d594630 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
@@ -1885,6 +1885,11 @@ static ssize_t iwl_dbgfs_mem_read(struct file *file, char __user *user_buf,
 	if (ret < 0)
 		return ret;
 
+	if (iwl_rx_packet_payload_len(hcmd.resp_pkt) < sizeof(*rsp)) {
+		ret = -EIO;
+		goto out;
+	}
+
 	rsp = (void *)hcmd.resp_pkt->data;
 	if (le32_to_cpu(rsp->status) != DEBUG_MEM_STATUS_SUCCESS) {
 		ret = -ENXIO;
@@ -1962,6 +1967,11 @@ static ssize_t iwl_dbgfs_mem_write(struct file *file,
 	if (ret < 0)
 		return ret;
 
+	if (iwl_rx_packet_payload_len(hcmd.resp_pkt) < sizeof(*rsp)) {
+		ret = -EIO;
+		goto out;
+	}
+
 	rsp = (void *)hcmd.resp_pkt->data;
 	if (rsp->status != DEBUG_MEM_STATUS_SUCCESS) {
 		ret = -ENXIO;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index daec61a60fec..7f8b7f7697cf 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -620,7 +620,6 @@ static int iwl_pcie_set_hw_ready(struct iwl_trans *trans)
 int iwl_pcie_prepare_card_hw(struct iwl_trans *trans)
 {
 	int ret;
-	int t = 0;
 	int iter;
 
 	IWL_DEBUG_INFO(trans, "iwl_trans_prepare_card_hw enter\n");
@@ -635,6 +634,8 @@ int iwl_pcie_prepare_card_hw(struct iwl_trans *trans)
 	usleep_range(1000, 2000);
 
 	for (iter = 0; iter < 10; iter++) {
+		int t = 0;
+
 		/* If HW is not ready, prepare the conditions to check again */
 		iwl_set_bit(trans, CSR_HW_IF_CONFIG_REG,
 			    CSR_HW_IF_CONFIG_REG_PREPARE);
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c
index 3b3cb3a6e2e8..6d13327d690e 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c
@@ -1702,6 +1702,7 @@ struct rtl8xxxu_fileops rtl8192eu_fops = {
 	.rx_desc_size = sizeof(struct rtl8xxxu_rxdesc24),
 	.has_s0s1 = 0,
 	.gen2_thermal_meter = 1,
+	.needs_full_init = 1,
 	.adda_1t_init = 0x0fc01616,
 	.adda_1t_path_on = 0x0fc01616,
 	.adda_2t_path_on_a = 0x0fc01616,
diff --git a/drivers/net/wireless/realtek/rtlwifi/debug.c b/drivers/net/wireless/realtek/rtlwifi/debug.c
index 0b1bc04cb6ad..9eb26dfe4ca9 100644
--- a/drivers/net/wireless/realtek/rtlwifi/debug.c
+++ b/drivers/net/wireless/realtek/rtlwifi/debug.c
@@ -278,8 +278,8 @@ static ssize_t rtl_debugfs_set_write_reg(struct file *filp,
 
 	tmp_len = (count > sizeof(tmp) - 1 ? sizeof(tmp) - 1 : count);
 
-	if (!buffer || copy_from_user(tmp, buffer, tmp_len))
-		return count;
+	if (copy_from_user(tmp, buffer, tmp_len))
+		return -EFAULT;
 
 	tmp[tmp_len] = '\0';
 
@@ -287,7 +287,7 @@ static ssize_t rtl_debugfs_set_write_reg(struct file *filp,
 	num = sscanf(tmp, "%x %x %x", &addr, &val, &len);
 
 	if (num !=  3)
-		return count;
+		return -EINVAL;
 
 	switch (len) {
 	case 1:
@@ -375,8 +375,8 @@ static ssize_t rtl_debugfs_set_write_rfreg(struct file *filp,
 
 	tmp_len = (count > sizeof(tmp) - 1 ? sizeof(tmp) - 1 : count);
 
-	if (!buffer || copy_from_user(tmp, buffer, tmp_len))
-		return count;
+	if (copy_from_user(tmp, buffer, tmp_len))
+		return -EFAULT;
 
 	tmp[tmp_len] = '\0';
 
@@ -386,7 +386,7 @@ static ssize_t rtl_debugfs_set_write_rfreg(struct file *filp,
 	if (num != 4) {
 		rtl_dbg(rtlpriv, COMP_ERR, DBG_DMESG,
 			"Format is <path> <addr> <mask> <data>\n");
-		return count;
+		return -EINVAL;
 	}
 
 	rtl_set_rfreg(hw, path, addr, bitmask, data);
diff --git a/drivers/net/wireless/realtek/rtw88/mac.c b/drivers/net/wireless/realtek/rtw88/mac.c
index 59028b121b00..a6d554a9dd99 100644
--- a/drivers/net/wireless/realtek/rtw88/mac.c
+++ b/drivers/net/wireless/realtek/rtw88/mac.c
@@ -233,7 +233,7 @@ static int rtw_pwr_seq_parser(struct rtw_dev *rtwdev,
 
 		ret = rtw_sub_pwr_seq_parser(rtwdev, intf_mask, cut_mask, cmd);
 		if (ret)
-			return -EBUSY;
+			return ret;
 
 		idx++;
 	} while (1);
@@ -247,6 +247,7 @@ static int rtw_mac_power_switch(struct rtw_dev *rtwdev, bool pwr_on)
 	const struct rtw_pwr_seq_cmd **pwr_seq;
 	u8 rpwm;
 	bool cur_pwr;
+	int ret;
 
 	if (rtw_chip_wcpu_11ac(rtwdev)) {
 		rpwm = rtw_read8(rtwdev, rtwdev->hci.rpwm_addr);
@@ -270,8 +271,9 @@ static int rtw_mac_power_switch(struct rtw_dev *rtwdev, bool pwr_on)
 		return -EALREADY;
 
 	pwr_seq = pwr_on ? chip->pwr_on_seq : chip->pwr_off_seq;
-	if (rtw_pwr_seq_parser(rtwdev, pwr_seq))
-		return -EINVAL;
+	ret = rtw_pwr_seq_parser(rtwdev, pwr_seq);
+	if (ret)
+		return ret;
 
 	return 0;
 }
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index a4b6aa932a8f..07c41a149328 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4416,11 +4416,19 @@ static void nvme_fw_act_work(struct work_struct *work)
 	nvme_get_fw_slot_info(ctrl);
 }
 
-static void nvme_handle_aen_notice(struct nvme_ctrl *ctrl, u32 result)
+static u32 nvme_aer_type(u32 result)
 {
-	u32 aer_notice_type = (result & 0xff00) >> 8;
+	return result & 0x7;
+}
 
-	trace_nvme_async_event(ctrl, aer_notice_type);
+static u32 nvme_aer_subtype(u32 result)
+{
+	return (result & 0xff00) >> 8;
+}
+
+static void nvme_handle_aen_notice(struct nvme_ctrl *ctrl, u32 result)
+{
+	u32 aer_notice_type = nvme_aer_subtype(result);
 
 	switch (aer_notice_type) {
 	case NVME_AER_NOTICE_NS_CHANGED:
@@ -4451,24 +4459,40 @@ static void nvme_handle_aen_notice(struct nvme_ctrl *ctrl, u32 result)
 	}
 }
 
+static void nvme_handle_aer_persistent_error(struct nvme_ctrl *ctrl)
+{
+	dev_warn(ctrl->device, "resetting controller due to AER\n");
+	nvme_reset_ctrl(ctrl);
+}
+
 void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
 		volatile union nvme_result *res)
 {
 	u32 result = le32_to_cpu(res->u32);
-	u32 aer_type = result & 0x07;
+	u32 aer_type = nvme_aer_type(result);
+	u32 aer_subtype = nvme_aer_subtype(result);
 
 	if (le16_to_cpu(status) >> 1 != NVME_SC_SUCCESS)
 		return;
 
+	trace_nvme_async_event(ctrl, result);
 	switch (aer_type) {
 	case NVME_AER_NOTICE:
 		nvme_handle_aen_notice(ctrl, result);
 		break;
 	case NVME_AER_ERROR:
+		/*
+		 * For a persistent internal error, don't run async_event_work
+		 * to submit a new AER. The controller reset will do it.
+		 */
+		if (aer_subtype == NVME_AER_ERROR_PERSIST_INT_ERR) {
+			nvme_handle_aer_persistent_error(ctrl);
+			return;
+		}
+		fallthrough;
 	case NVME_AER_SMART:
 	case NVME_AER_CSS:
 	case NVME_AER_VS:
-		trace_nvme_async_event(ctrl, aer_type);
 		ctrl->aen_result = result;
 		break;
 	default:
diff --git a/drivers/nvme/host/trace.h b/drivers/nvme/host/trace.h
index aa8b0f86b2be..b258f7b8788e 100644
--- a/drivers/nvme/host/trace.h
+++ b/drivers/nvme/host/trace.h
@@ -127,15 +127,12 @@ TRACE_EVENT(nvme_async_event,
 	),
 	TP_printk("nvme%d: NVME_AEN=%#08x [%s]",
 		__entry->ctrl_id, __entry->result,
-		__print_symbolic(__entry->result,
-		aer_name(NVME_AER_NOTICE_NS_CHANGED),
-		aer_name(NVME_AER_NOTICE_ANA),
-		aer_name(NVME_AER_NOTICE_FW_ACT_STARTING),
-		aer_name(NVME_AER_NOTICE_DISC_CHANGED),
-		aer_name(NVME_AER_ERROR),
-		aer_name(NVME_AER_SMART),
-		aer_name(NVME_AER_CSS),
-		aer_name(NVME_AER_VS))
+		__print_symbolic(__entry->result & 0x7,
+			aer_name(NVME_AER_ERROR),
+			aer_name(NVME_AER_SMART),
+			aer_name(NVME_AER_NOTICE),
+			aer_name(NVME_AER_CSS),
+			aer_name(NVME_AER_VS))
 	)
 );
 
diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index 3da067a8311e..80a208fb34f5 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -570,10 +570,11 @@ fcloop_fcp_recv_work(struct work_struct *work)
 	struct fcloop_fcpreq *tfcp_req =
 		container_of(work, struct fcloop_fcpreq, fcp_rcv_work);
 	struct nvmefc_fcp_req *fcpreq = tfcp_req->fcpreq;
+	unsigned long flags;
 	int ret = 0;
 	bool aborted = false;
 
-	spin_lock_irq(&tfcp_req->reqlock);
+	spin_lock_irqsave(&tfcp_req->reqlock, flags);
 	switch (tfcp_req->inistate) {
 	case INI_IO_START:
 		tfcp_req->inistate = INI_IO_ACTIVE;
@@ -582,11 +583,11 @@ fcloop_fcp_recv_work(struct work_struct *work)
 		aborted = true;
 		break;
 	default:
-		spin_unlock_irq(&tfcp_req->reqlock);
+		spin_unlock_irqrestore(&tfcp_req->reqlock, flags);
 		WARN_ON(1);
 		return;
 	}
-	spin_unlock_irq(&tfcp_req->reqlock);
+	spin_unlock_irqrestore(&tfcp_req->reqlock, flags);
 
 	if (unlikely(aborted))
 		ret = -ECANCELED;
@@ -607,8 +608,9 @@ fcloop_fcp_abort_recv_work(struct work_struct *work)
 		container_of(work, struct fcloop_fcpreq, abort_rcv_work);
 	struct nvmefc_fcp_req *fcpreq;
 	bool completed = false;
+	unsigned long flags;
 
-	spin_lock_irq(&tfcp_req->reqlock);
+	spin_lock_irqsave(&tfcp_req->reqlock, flags);
 	fcpreq = tfcp_req->fcpreq;
 	switch (tfcp_req->inistate) {
 	case INI_IO_ABORTED:
@@ -617,11 +619,11 @@ fcloop_fcp_abort_recv_work(struct work_struct *work)
 		completed = true;
 		break;
 	default:
-		spin_unlock_irq(&tfcp_req->reqlock);
+		spin_unlock_irqrestore(&tfcp_req->reqlock, flags);
 		WARN_ON(1);
 		return;
 	}
-	spin_unlock_irq(&tfcp_req->reqlock);
+	spin_unlock_irqrestore(&tfcp_req->reqlock, flags);
 
 	if (unlikely(completed)) {
 		/* remove reference taken in original abort downcall */
@@ -633,9 +635,9 @@ fcloop_fcp_abort_recv_work(struct work_struct *work)
 		nvmet_fc_rcv_fcp_abort(tfcp_req->tport->targetport,
 					&tfcp_req->tgt_fcp_req);
 
-	spin_lock_irq(&tfcp_req->reqlock);
+	spin_lock_irqsave(&tfcp_req->reqlock, flags);
 	tfcp_req->fcpreq = NULL;
-	spin_unlock_irq(&tfcp_req->reqlock);
+	spin_unlock_irqrestore(&tfcp_req->reqlock, flags);
 
 	fcloop_call_host_done(fcpreq, tfcp_req, -ECANCELED);
 	/* call_host_done releases reference for abort downcall */
@@ -651,11 +653,12 @@ fcloop_tgt_fcprqst_done_work(struct work_struct *work)
 	struct fcloop_fcpreq *tfcp_req =
 		container_of(work, struct fcloop_fcpreq, tio_done_work);
 	struct nvmefc_fcp_req *fcpreq;
+	unsigned long flags;
 
-	spin_lock_irq(&tfcp_req->reqlock);
+	spin_lock_irqsave(&tfcp_req->reqlock, flags);
 	fcpreq = tfcp_req->fcpreq;
 	tfcp_req->inistate = INI_IO_COMPLETED;
-	spin_unlock_irq(&tfcp_req->reqlock);
+	spin_unlock_irqrestore(&tfcp_req->reqlock, flags);
 
 	fcloop_call_host_done(fcpreq, tfcp_req, tfcp_req->status);
 }
@@ -759,13 +762,14 @@ fcloop_fcp_op(struct nvmet_fc_target_port *tgtport,
 	u32 rsplen = 0, xfrlen = 0;
 	int fcp_err = 0, active, aborted;
 	u8 op = tgt_fcpreq->op;
+	unsigned long flags;
 
-	spin_lock_irq(&tfcp_req->reqlock);
+	spin_lock_irqsave(&tfcp_req->reqlock, flags);
 	fcpreq = tfcp_req->fcpreq;
 	active = tfcp_req->active;
 	aborted = tfcp_req->aborted;
 	tfcp_req->active = true;
-	spin_unlock_irq(&tfcp_req->reqlock);
+	spin_unlock_irqrestore(&tfcp_req->reqlock, flags);
 
 	if (unlikely(active))
 		/* illegal - call while i/o active */
@@ -773,9 +777,9 @@ fcloop_fcp_op(struct nvmet_fc_target_port *tgtport,
 
 	if (unlikely(aborted)) {
 		/* target transport has aborted i/o prior */
-		spin_lock_irq(&tfcp_req->reqlock);
+		spin_lock_irqsave(&tfcp_req->reqlock, flags);
 		tfcp_req->active = false;
-		spin_unlock_irq(&tfcp_req->reqlock);
+		spin_unlock_irqrestore(&tfcp_req->reqlock, flags);
 		tgt_fcpreq->transferred_length = 0;
 		tgt_fcpreq->fcp_error = -ECANCELED;
 		tgt_fcpreq->done(tgt_fcpreq);
@@ -832,9 +836,9 @@ fcloop_fcp_op(struct nvmet_fc_target_port *tgtport,
 		break;
 	}
 
-	spin_lock_irq(&tfcp_req->reqlock);
+	spin_lock_irqsave(&tfcp_req->reqlock, flags);
 	tfcp_req->active = false;
-	spin_unlock_irq(&tfcp_req->reqlock);
+	spin_unlock_irqrestore(&tfcp_req->reqlock, flags);
 
 	tgt_fcpreq->transferred_length = xfrlen;
 	tgt_fcpreq->fcp_error = fcp_err;
@@ -848,15 +852,16 @@ fcloop_tgt_fcp_abort(struct nvmet_fc_target_port *tgtport,
 			struct nvmefc_tgt_fcp_req *tgt_fcpreq)
 {
 	struct fcloop_fcpreq *tfcp_req = tgt_fcp_req_to_fcpreq(tgt_fcpreq);
+	unsigned long flags;
 
 	/*
 	 * mark aborted only in case there were 2 threads in transport
 	 * (one doing io, other doing abort) and only kills ops posted
 	 * after the abort request
 	 */
-	spin_lock_irq(&tfcp_req->reqlock);
+	spin_lock_irqsave(&tfcp_req->reqlock, flags);
 	tfcp_req->aborted = true;
-	spin_unlock_irq(&tfcp_req->reqlock);
+	spin_unlock_irqrestore(&tfcp_req->reqlock, flags);
 
 	tfcp_req->status = NVME_SC_INTERNAL;
 
@@ -898,6 +903,7 @@ fcloop_fcp_abort(struct nvme_fc_local_port *localport,
 	struct fcloop_ini_fcpreq *inireq = fcpreq->private;
 	struct fcloop_fcpreq *tfcp_req;
 	bool abortio = true;
+	unsigned long flags;
 
 	spin_lock(&inireq->inilock);
 	tfcp_req = inireq->tfcp_req;
@@ -910,7 +916,7 @@ fcloop_fcp_abort(struct nvme_fc_local_port *localport,
 		return;
 
 	/* break initiator/target relationship for io */
-	spin_lock_irq(&tfcp_req->reqlock);
+	spin_lock_irqsave(&tfcp_req->reqlock, flags);
 	switch (tfcp_req->inistate) {
 	case INI_IO_START:
 	case INI_IO_ACTIVE:
@@ -920,11 +926,11 @@ fcloop_fcp_abort(struct nvme_fc_local_port *localport,
 		abortio = false;
 		break;
 	default:
-		spin_unlock_irq(&tfcp_req->reqlock);
+		spin_unlock_irqrestore(&tfcp_req->reqlock, flags);
 		WARN_ON(1);
 		return;
 	}
-	spin_unlock_irq(&tfcp_req->reqlock);
+	spin_unlock_irqrestore(&tfcp_req->reqlock, flags);
 
 	if (abortio)
 		/* leave the reference while the work item is scheduled */
diff --git a/drivers/of/device.c b/drivers/of/device.c
index 1122daa8e273..3a547793135c 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -264,12 +264,15 @@ int of_device_request_module(struct device *dev)
 	if (size < 0)
 		return size;
 
-	str = kmalloc(size + 1, GFP_KERNEL);
+	/* Reserve an additional byte for the trailing '\0' */
+	size++;
+
+	str = kmalloc(size, GFP_KERNEL);
 	if (!str)
 		return -ENOMEM;
 
 	of_device_get_modalias(dev, str, size);
-	str[size] = '\0';
+	str[size - 1] = '\0';
 	ret = request_module(str);
 	kfree(str);
 
diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index ceb4815379cd..8117f2dad86c 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1272,6 +1272,13 @@ DECLARE_PCI_FIXUP_CLASS_HEADER(PCI_VENDOR_ID_SYNOPSYS, 0xabcd,
 static int __init imx6_pcie_init(void)
 {
 #ifdef CONFIG_ARM
+	struct device_node *np;
+
+	np = of_find_matching_node(NULL, imx6_pcie_of_match);
+	if (!np)
+		return -ENODEV;
+	of_node_put(np);
+
 	/*
 	 * Since probe() can be deferred we need to make sure that
 	 * hook_fault_code is not called after __init memory is freed
diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 5fbd80908a99..c68e14271c02 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1210,11 +1210,9 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
 	val |= BIT(4);
 	writel(val, pcie->parf + PCIE20_PARF_MHI_CLOCK_RESET_CTRL);
 
-	if (IS_ENABLED(CONFIG_PCI_MSI)) {
-		val = readl(pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT);
-		val |= BIT(31);
-		writel(val, pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT);
-	}
+	val = readl(pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT_V2);
+	val |= BIT(31);
+	writel(val, pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT_V2);
 
 	return 0;
 err_disable_clocks:
diff --git a/drivers/pci/hotplug/pciehp_pci.c b/drivers/pci/hotplug/pciehp_pci.c
index d17f3bf36f70..ad12515a4a12 100644
--- a/drivers/pci/hotplug/pciehp_pci.c
+++ b/drivers/pci/hotplug/pciehp_pci.c
@@ -63,7 +63,14 @@ int pciehp_configure_device(struct controller *ctrl)
 
 	pci_assign_unassigned_bridge_resources(bridge);
 	pcie_bus_configure_settings(parent);
+
+	/*
+	 * Release reset_lock during driver binding
+	 * to avoid AB-BA deadlock with device_lock.
+	 */
+	up_read(&ctrl->reset_lock);
 	pci_bus_add_devices(parent);
+	down_read_nested(&ctrl->reset_lock, ctrl->depth);
 
  out:
 	pci_unlock_rescan_remove();
@@ -104,7 +111,15 @@ void pciehp_unconfigure_device(struct controller *ctrl, bool presence)
 	list_for_each_entry_safe_reverse(dev, temp, &parent->devices,
 					 bus_list) {
 		pci_dev_get(dev);
+
+		/*
+		 * Release reset_lock during driver unbinding
+		 * to avoid AB-BA deadlock with device_lock.
+		 */
+		up_read(&ctrl->reset_lock);
 		pci_stop_and_remove_bus_device(dev);
+		down_read_nested(&ctrl->reset_lock, ctrl->depth);
+
 		/*
 		 * Ensure that no new Requests will be generated from
 		 * the device.
diff --git a/drivers/pci/pcie/edr.c b/drivers/pci/pcie/edr.c
index a6b9b479b97a..87734e4c3c20 100644
--- a/drivers/pci/pcie/edr.c
+++ b/drivers/pci/pcie/edr.c
@@ -193,6 +193,7 @@ static void edr_handle_event(acpi_handle handle, u32 event, void *data)
 	 */
 	if (estate == PCI_ERS_RESULT_RECOVERED) {
 		pci_dbg(edev, "DPC port successfully recovered\n");
+		pcie_clear_device_status(edev);
 		acpi_send_edr_status(pdev, edev, EDR_OST_SUCCESS);
 	} else {
 		pci_dbg(edev, "DPC port recovery failed\n");
diff --git a/drivers/phy/tegra/xusb.c b/drivers/phy/tegra/xusb.c
index 181a1be5f491..d07f33ec7939 100644
--- a/drivers/phy/tegra/xusb.c
+++ b/drivers/phy/tegra/xusb.c
@@ -775,6 +775,7 @@ static int tegra_xusb_add_usb2_port(struct tegra_xusb_padctl *padctl,
 	usb2->base.lane = usb2->base.ops->map(&usb2->base);
 	if (IS_ERR(usb2->base.lane)) {
 		err = PTR_ERR(usb2->base.lane);
+		tegra_xusb_port_unregister(&usb2->base);
 		goto out;
 	}
 
@@ -841,6 +842,7 @@ static int tegra_xusb_add_ulpi_port(struct tegra_xusb_padctl *padctl,
 	ulpi->base.lane = ulpi->base.ops->map(&ulpi->base);
 	if (IS_ERR(ulpi->base.lane)) {
 		err = PTR_ERR(ulpi->base.lane);
+		tegra_xusb_port_unregister(&ulpi->base);
 		goto out;
 	}
 
diff --git a/drivers/platform/x86/touchscreen_dmi.c b/drivers/platform/x86/touchscreen_dmi.c
index b96fbc8dba09..55a18cd0c298 100644
--- a/drivers/platform/x86/touchscreen_dmi.c
+++ b/drivers/platform/x86/touchscreen_dmi.c
@@ -327,6 +327,22 @@ static const struct ts_dmi_data dexp_ursus_7w_data = {
 	.properties	= dexp_ursus_7w_props,
 };
 
+static const struct property_entry dexp_ursus_kx210i_props[] = {
+	PROPERTY_ENTRY_U32("touchscreen-min-x", 5),
+	PROPERTY_ENTRY_U32("touchscreen-min-y",  2),
+	PROPERTY_ENTRY_U32("touchscreen-size-x", 1720),
+	PROPERTY_ENTRY_U32("touchscreen-size-y", 1137),
+	PROPERTY_ENTRY_STRING("firmware-name", "gsl1680-dexp-ursus-kx210i.fw"),
+	PROPERTY_ENTRY_U32("silead,max-fingers", 10),
+	PROPERTY_ENTRY_BOOL("silead,home-button"),
+	{ }
+};
+
+static const struct ts_dmi_data dexp_ursus_kx210i_data = {
+	.acpi_name	= "MSSL1680:00",
+	.properties	= dexp_ursus_kx210i_props,
+};
+
 static const struct property_entry digma_citi_e200_props[] = {
 	PROPERTY_ENTRY_U32("touchscreen-size-x", 1980),
 	PROPERTY_ENTRY_U32("touchscreen-size-y", 1500),
@@ -381,6 +397,11 @@ static const struct ts_dmi_data glavey_tm800a550l_data = {
 	.properties	= glavey_tm800a550l_props,
 };
 
+static const struct ts_dmi_data gdix1002_00_upside_down_data = {
+	.acpi_name	= "GDIX1002:00",
+	.properties	= gdix1001_upside_down_props,
+};
+
 static const struct property_entry gp_electronic_t701_props[] = {
 	PROPERTY_ENTRY_U32("touchscreen-size-x", 960),
 	PROPERTY_ENTRY_U32("touchscreen-size-y", 640),
@@ -1118,6 +1139,14 @@ const struct dmi_system_id touchscreen_dmi_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "7W"),
 		},
 	},
+	{
+		/* DEXP Ursus KX210i */
+		.driver_data = (void *)&dexp_ursus_kx210i_data,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "INSYDE Corp."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "S107I"),
+		},
+	},
 	{
 		/* Digma Citi E200 */
 		.driver_data = (void *)&digma_citi_e200_data,
@@ -1227,6 +1256,18 @@ const struct dmi_system_id touchscreen_dmi_table[] = {
 			DMI_MATCH(DMI_BIOS_VERSION, "jumperx.T87.KFBNEEA"),
 		},
 	},
+	{
+		/* Juno Tablet */
+		.driver_data = (void *)&gdix1002_00_upside_down_data,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Default string"),
+			/* Both product- and board-name being "Default string" is somewhat rare */
+			DMI_MATCH(DMI_PRODUCT_NAME, "Default string"),
+			DMI_MATCH(DMI_BOARD_NAME, "Default string"),
+			/* Above matches are too generic, add partial bios-version match */
+			DMI_MATCH(DMI_BIOS_VERSION, "JP2V1."),
+		},
+	},
 	{
 		/* Mediacom WinPad 7.0 W700 (same hw as Wintron surftab 7") */
 		.driver_data = (void *)&trekstor_surftab_wintron70_data,
diff --git a/drivers/power/supply/generic-adc-battery.c b/drivers/power/supply/generic-adc-battery.c
index 58f09314741a..09bb4ff291cb 100644
--- a/drivers/power/supply/generic-adc-battery.c
+++ b/drivers/power/supply/generic-adc-battery.c
@@ -138,6 +138,9 @@ static int read_channel(struct gab *adc_bat, enum power_supply_property psp,
 			result);
 	if (ret < 0)
 		pr_err("read channel error\n");
+	else
+		*result *= 1000;
+
 	return ret;
 }
 
diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index 237bb8e06593..0283163ddbe8 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -424,7 +424,7 @@ static const struct meson_pwm_data pwm_axg_ee_data = {
 };
 
 static const char * const pwm_axg_ao_parent_names[] = {
-	"aoclk81", "xtal", "fclk_div4", "fclk_div5"
+	"xtal", "axg_ao_clk81", "fclk_div4", "fclk_div5"
 };
 
 static const struct meson_pwm_data pwm_axg_ao_data = {
@@ -433,7 +433,7 @@ static const struct meson_pwm_data pwm_axg_ao_data = {
 };
 
 static const char * const pwm_g12a_ao_ab_parent_names[] = {
-	"xtal", "aoclk81", "fclk_div4", "fclk_div5"
+	"xtal", "g12a_ao_clk81", "fclk_div4", "fclk_div5"
 };
 
 static const struct meson_pwm_data pwm_g12a_ao_ab_data = {
@@ -442,7 +442,7 @@ static const struct meson_pwm_data pwm_g12a_ao_ab_data = {
 };
 
 static const char * const pwm_g12a_ao_cd_parent_names[] = {
-	"xtal", "aoclk81",
+	"xtal", "g12a_ao_clk81",
 };
 
 static const struct meson_pwm_data pwm_g12a_ao_cd_data = {
diff --git a/drivers/pwm/pwm-mtk-disp.c b/drivers/pwm/pwm-mtk-disp.c
index 83b8be0209b7..327c780d433d 100644
--- a/drivers/pwm/pwm-mtk-disp.c
+++ b/drivers/pwm/pwm-mtk-disp.c
@@ -74,6 +74,19 @@ static int mtk_disp_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	u64 div, rate;
 	int err;
 
+	err = clk_prepare_enable(mdp->clk_main);
+	if (err < 0) {
+		dev_err(chip->dev, "Can't enable mdp->clk_main: %pe\n", ERR_PTR(err));
+		return err;
+	}
+
+	err = clk_prepare_enable(mdp->clk_mm);
+	if (err < 0) {
+		dev_err(chip->dev, "Can't enable mdp->clk_mm: %pe\n", ERR_PTR(err));
+		clk_disable_unprepare(mdp->clk_main);
+		return err;
+	}
+
 	/*
 	 * Find period, high_width and clk_div to suit duty_ns and period_ns.
 	 * Calculate proper div value to keep period value in the bound.
@@ -87,8 +100,11 @@ static int mtk_disp_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	rate = clk_get_rate(mdp->clk_main);
 	clk_div = div_u64(rate * period_ns, NSEC_PER_SEC) >>
 			  PWM_PERIOD_BIT_WIDTH;
-	if (clk_div > PWM_CLKDIV_MAX)
+	if (clk_div > PWM_CLKDIV_MAX) {
+		clk_disable_unprepare(mdp->clk_mm);
+		clk_disable_unprepare(mdp->clk_main);
 		return -EINVAL;
+	}
 
 	div = NSEC_PER_SEC * (clk_div + 1);
 	period = div64_u64(rate * period_ns, div);
@@ -98,14 +114,17 @@ static int mtk_disp_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	high_width = div64_u64(rate * duty_ns, div);
 	value = period | (high_width << PWM_HIGH_WIDTH_SHIFT);
 
-	err = clk_enable(mdp->clk_main);
-	if (err < 0)
-		return err;
-
-	err = clk_enable(mdp->clk_mm);
-	if (err < 0) {
-		clk_disable(mdp->clk_main);
-		return err;
+	if (mdp->data->bls_debug && !mdp->data->has_commit) {
+		/*
+		 * For MT2701, disable double buffer before writing register
+		 * and select manual mode and use PWM_PERIOD/PWM_HIGH_WIDTH.
+		 */
+		mtk_disp_pwm_update_bits(mdp, mdp->data->bls_debug,
+					 mdp->data->bls_debug_mask,
+					 mdp->data->bls_debug_mask);
+		mtk_disp_pwm_update_bits(mdp, mdp->data->con0,
+					 mdp->data->con0_sel,
+					 mdp->data->con0_sel);
 	}
 
 	mtk_disp_pwm_update_bits(mdp, mdp->data->con0,
@@ -124,8 +143,8 @@ static int mtk_disp_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 					 0x0);
 	}
 
-	clk_disable(mdp->clk_mm);
-	clk_disable(mdp->clk_main);
+	clk_disable_unprepare(mdp->clk_mm);
+	clk_disable_unprepare(mdp->clk_main);
 
 	return 0;
 }
@@ -135,13 +154,16 @@ static int mtk_disp_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 	struct mtk_disp_pwm *mdp = to_mtk_disp_pwm(chip);
 	int err;
 
-	err = clk_enable(mdp->clk_main);
-	if (err < 0)
+	err = clk_prepare_enable(mdp->clk_main);
+	if (err < 0) {
+		dev_err(chip->dev, "Can't enable mdp->clk_main: %pe\n", ERR_PTR(err));
 		return err;
+	}
 
-	err = clk_enable(mdp->clk_mm);
+	err = clk_prepare_enable(mdp->clk_mm);
 	if (err < 0) {
-		clk_disable(mdp->clk_main);
+		dev_err(chip->dev, "Can't enable mdp->clk_mm: %pe\n", ERR_PTR(err));
+		clk_disable_unprepare(mdp->clk_main);
 		return err;
 	}
 
@@ -158,8 +180,8 @@ static void mtk_disp_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 	mtk_disp_pwm_update_bits(mdp, DISP_PWM_EN, mdp->data->enable_mask,
 				 0x0);
 
-	clk_disable(mdp->clk_mm);
-	clk_disable(mdp->clk_main);
+	clk_disable_unprepare(mdp->clk_mm);
+	clk_disable_unprepare(mdp->clk_main);
 }
 
 static const struct pwm_ops mtk_disp_pwm_ops = {
@@ -194,14 +216,6 @@ static int mtk_disp_pwm_probe(struct platform_device *pdev)
 	if (IS_ERR(mdp->clk_mm))
 		return PTR_ERR(mdp->clk_mm);
 
-	ret = clk_prepare(mdp->clk_main);
-	if (ret < 0)
-		return ret;
-
-	ret = clk_prepare(mdp->clk_mm);
-	if (ret < 0)
-		goto disable_clk_main;
-
 	mdp->chip.dev = &pdev->dev;
 	mdp->chip.ops = &mtk_disp_pwm_ops;
 	mdp->chip.base = -1;
@@ -209,44 +223,22 @@ static int mtk_disp_pwm_probe(struct platform_device *pdev)
 
 	ret = pwmchip_add(&mdp->chip);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "pwmchip_add() failed: %d\n", ret);
-		goto disable_clk_mm;
+		dev_err(&pdev->dev, "pwmchip_add() failed: %pe\n", ERR_PTR(ret));
+		return ret;
 	}
 
 	platform_set_drvdata(pdev, mdp);
 
-	/*
-	 * For MT2701, disable double buffer before writing register
-	 * and select manual mode and use PWM_PERIOD/PWM_HIGH_WIDTH.
-	 */
-	if (!mdp->data->has_commit) {
-		mtk_disp_pwm_update_bits(mdp, mdp->data->bls_debug,
-					 mdp->data->bls_debug_mask,
-					 mdp->data->bls_debug_mask);
-		mtk_disp_pwm_update_bits(mdp, mdp->data->con0,
-					 mdp->data->con0_sel,
-					 mdp->data->con0_sel);
-	}
-
 	return 0;
-
-disable_clk_mm:
-	clk_unprepare(mdp->clk_mm);
-disable_clk_main:
-	clk_unprepare(mdp->clk_main);
-	return ret;
 }
 
 static int mtk_disp_pwm_remove(struct platform_device *pdev)
 {
 	struct mtk_disp_pwm *mdp = platform_get_drvdata(pdev);
-	int ret;
 
-	ret = pwmchip_remove(&mdp->chip);
-	clk_unprepare(mdp->clk_mm);
-	clk_unprepare(mdp->clk_main);
+	pwmchip_remove(&mdp->chip);
 
-	return ret;
+	return 0;
 }
 
 static const struct mtk_pwm_data mt2701_pwm_data = {
diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 6dd698b2d0af..47a04c5f7a9b 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -216,6 +216,78 @@ static void regulator_unlock(struct regulator_dev *rdev)
 	mutex_unlock(&regulator_nesting_mutex);
 }
 
+/**
+ * regulator_lock_two - lock two regulators
+ * @rdev1:		first regulator
+ * @rdev2:		second regulator
+ * @ww_ctx:		w/w mutex acquire context
+ *
+ * Locks both rdevs using the regulator_ww_class.
+ */
+static void regulator_lock_two(struct regulator_dev *rdev1,
+			       struct regulator_dev *rdev2,
+			       struct ww_acquire_ctx *ww_ctx)
+{
+	struct regulator_dev *tmp;
+	int ret;
+
+	ww_acquire_init(ww_ctx, &regulator_ww_class);
+
+	/* Try to just grab both of them */
+	ret = regulator_lock_nested(rdev1, ww_ctx);
+	WARN_ON(ret);
+	ret = regulator_lock_nested(rdev2, ww_ctx);
+	if (ret != -EDEADLOCK) {
+		WARN_ON(ret);
+		goto exit;
+	}
+
+	while (true) {
+		/*
+		 * Start of loop: rdev1 was locked and rdev2 was contended.
+		 * Need to unlock rdev1, slowly lock rdev2, then try rdev1
+		 * again.
+		 */
+		regulator_unlock(rdev1);
+
+		ww_mutex_lock_slow(&rdev2->mutex, ww_ctx);
+		rdev2->ref_cnt++;
+		rdev2->mutex_owner = current;
+		ret = regulator_lock_nested(rdev1, ww_ctx);
+
+		if (ret == -EDEADLOCK) {
+			/* More contention; swap which needs to be slow */
+			tmp = rdev1;
+			rdev1 = rdev2;
+			rdev2 = tmp;
+		} else {
+			WARN_ON(ret);
+			break;
+		}
+	}
+
+exit:
+	ww_acquire_done(ww_ctx);
+}
+
+/**
+ * regulator_unlock_two - unlock two regulators
+ * @rdev1:		first regulator
+ * @rdev2:		second regulator
+ * @ww_ctx:		w/w mutex acquire context
+ *
+ * The inverse of regulator_lock_two().
+ */
+
+static void regulator_unlock_two(struct regulator_dev *rdev1,
+				 struct regulator_dev *rdev2,
+				 struct ww_acquire_ctx *ww_ctx)
+{
+	regulator_unlock(rdev2);
+	regulator_unlock(rdev1);
+	ww_acquire_fini(ww_ctx);
+}
+
 static bool regulator_supply_is_couple(struct regulator_dev *rdev)
 {
 	struct regulator_dev *c_rdev;
@@ -343,6 +415,7 @@ static void regulator_lock_dependent(struct regulator_dev *rdev,
 			ww_mutex_lock_slow(&new_contended_rdev->mutex, ww_ctx);
 			old_contended_rdev = new_contended_rdev;
 			old_contended_rdev->ref_cnt++;
+			old_contended_rdev->mutex_owner = current;
 		}
 
 		err = regulator_lock_recursive(rdev,
@@ -1459,8 +1532,8 @@ static int set_machine_constraints(struct regulator_dev *rdev)
 
 /**
  * set_supply - set regulator supply regulator
- * @rdev: regulator name
- * @supply_rdev: supply regulator name
+ * @rdev: regulator (locked)
+ * @supply_rdev: supply regulator (locked))
  *
  * Called by platform initialisation code to set the supply regulator for this
  * regulator. This ensures that a regulators supply will also be enabled by the
@@ -1632,6 +1705,8 @@ static struct regulator *create_regulator(struct regulator_dev *rdev,
 	struct regulator *regulator;
 	int err = 0;
 
+	lockdep_assert_held_once(&rdev->mutex.base);
+
 	if (dev) {
 		char buf[REG_STR_SIZE];
 		int size;
@@ -1659,9 +1734,7 @@ static struct regulator *create_regulator(struct regulator_dev *rdev,
 	regulator->rdev = rdev;
 	regulator->supply_name = supply_name;
 
-	regulator_lock(rdev);
 	list_add(&regulator->list, &rdev->consumer_list);
-	regulator_unlock(rdev);
 
 	if (dev) {
 		regulator->dev = dev;
@@ -1827,6 +1900,7 @@ static int regulator_resolve_supply(struct regulator_dev *rdev)
 {
 	struct regulator_dev *r;
 	struct device *dev = rdev->dev.parent;
+	struct ww_acquire_ctx ww_ctx;
 	int ret = 0;
 
 	/* No supply to resolve? */
@@ -1893,23 +1967,23 @@ static int regulator_resolve_supply(struct regulator_dev *rdev)
 	 * between rdev->supply null check and setting rdev->supply in
 	 * set_supply() from concurrent tasks.
 	 */
-	regulator_lock(rdev);
+	regulator_lock_two(rdev, r, &ww_ctx);
 
 	/* Supply just resolved by a concurrent task? */
 	if (rdev->supply) {
-		regulator_unlock(rdev);
+		regulator_unlock_two(rdev, r, &ww_ctx);
 		put_device(&r->dev);
 		goto out;
 	}
 
 	ret = set_supply(rdev, r);
 	if (ret < 0) {
-		regulator_unlock(rdev);
+		regulator_unlock_two(rdev, r, &ww_ctx);
 		put_device(&r->dev);
 		goto out;
 	}
 
-	regulator_unlock(rdev);
+	regulator_unlock_two(rdev, r, &ww_ctx);
 
 	/*
 	 * In set_machine_constraints() we may have turned this regulator on
@@ -2022,7 +2096,9 @@ struct regulator *_regulator_get(struct device *dev, const char *id,
 		return regulator;
 	}
 
+	regulator_lock(rdev);
 	regulator = create_regulator(rdev, dev, id);
+	regulator_unlock(rdev);
 	if (regulator == NULL) {
 		regulator = ERR_PTR(-ENOMEM);
 		module_put(rdev->owner);
@@ -5800,6 +5876,7 @@ static void regulator_summary_lock(struct ww_acquire_ctx *ww_ctx)
 			ww_mutex_lock_slow(&new_contended_rdev->mutex, ww_ctx);
 			old_contended_rdev = new_contended_rdev;
 			old_contended_rdev->ref_cnt++;
+			old_contended_rdev->mutex_owner = current;
 		}
 
 		err = regulator_summary_lock_all(ww_ctx,
diff --git a/drivers/regulator/stm32-pwr.c b/drivers/regulator/stm32-pwr.c
index 2a42acb7c24e..e5dd4db6403b 100644
--- a/drivers/regulator/stm32-pwr.c
+++ b/drivers/regulator/stm32-pwr.c
@@ -129,17 +129,16 @@ static const struct regulator_desc stm32_pwr_desc[] = {
 
 static int stm32_pwr_regulator_probe(struct platform_device *pdev)
 {
-	struct device_node *np = pdev->dev.of_node;
 	struct stm32_pwr_reg *priv;
 	void __iomem *base;
 	struct regulator_dev *rdev;
 	struct regulator_config config = { };
 	int i, ret = 0;
 
-	base = of_iomap(np, 0);
-	if (!base) {
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base)) {
 		dev_err(&pdev->dev, "Unable to map IO memory\n");
-		return -ENOMEM;
+		return PTR_ERR(base);
 	}
 
 	config.dev = &pdev->dev;
diff --git a/drivers/remoteproc/st_remoteproc.c b/drivers/remoteproc/st_remoteproc.c
index a3268d95a50e..e6bd3c7a950a 100644
--- a/drivers/remoteproc/st_remoteproc.c
+++ b/drivers/remoteproc/st_remoteproc.c
@@ -129,6 +129,7 @@ static int st_rproc_parse_fw(struct rproc *rproc, const struct firmware *fw)
 	while (of_phandle_iterator_next(&it) == 0) {
 		rmem = of_reserved_mem_lookup(it.node);
 		if (!rmem) {
+			of_node_put(it.node);
 			dev_err(dev, "unable to acquire memory-region\n");
 			return -EINVAL;
 		}
@@ -150,8 +151,10 @@ static int st_rproc_parse_fw(struct rproc *rproc, const struct firmware *fw)
 							   it.node->name);
 		}
 
-		if (!mem)
+		if (!mem) {
+			of_node_put(it.node);
 			return -ENOMEM;
+		}
 
 		rproc_add_carveout(rproc, mem);
 		index++;
diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rproc.c
index d2414cc1d90d..24760d8ea637 100644
--- a/drivers/remoteproc/stm32_rproc.c
+++ b/drivers/remoteproc/stm32_rproc.c
@@ -231,11 +231,13 @@ static int stm32_rproc_parse_memory_regions(struct rproc *rproc)
 	while (of_phandle_iterator_next(&it) == 0) {
 		rmem = of_reserved_mem_lookup(it.node);
 		if (!rmem) {
+			of_node_put(it.node);
 			dev_err(dev, "unable to acquire memory-region\n");
 			return -EINVAL;
 		}
 
 		if (stm32_rproc_pa_to_da(rproc, rmem->base, &da) < 0) {
+			of_node_put(it.node);
 			dev_err(dev, "memory region not valid %pa\n",
 				&rmem->base);
 			return -EINVAL;
@@ -262,8 +264,10 @@ static int stm32_rproc_parse_memory_regions(struct rproc *rproc)
 							   it.node->name);
 		}
 
-		if (!mem)
+		if (!mem) {
+			of_node_put(it.node);
 			return -ENOMEM;
+		}
 
 		rproc_add_carveout(rproc, mem);
 		index++;
diff --git a/drivers/rtc/rtc-meson-vrtc.c b/drivers/rtc/rtc-meson-vrtc.c
index e6bd0808a092..18ff8439b5bb 100644
--- a/drivers/rtc/rtc-meson-vrtc.c
+++ b/drivers/rtc/rtc-meson-vrtc.c
@@ -23,7 +23,7 @@ static int meson_vrtc_read_time(struct device *dev, struct rtc_time *tm)
 	struct timespec64 time;
 
 	dev_dbg(dev, "%s\n", __func__);
-	ktime_get_raw_ts64(&time);
+	ktime_get_real_ts64(&time);
 	rtc_time64_to_tm(time.tv_sec, tm);
 
 	return 0;
@@ -96,7 +96,7 @@ static int __maybe_unused meson_vrtc_suspend(struct device *dev)
 		long alarm_secs;
 		struct timespec64 time;
 
-		ktime_get_raw_ts64(&time);
+		ktime_get_real_ts64(&time);
 		local_time = time.tv_sec;
 
 		dev_dbg(dev, "alarm_time = %lus, local_time=%lus\n",
diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
index c20fc7937dfa..18ae2a4f26ea 100644
--- a/drivers/rtc/rtc-omap.c
+++ b/drivers/rtc/rtc-omap.c
@@ -25,6 +25,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/rtc.h>
+#include <linux/rtc/rtc-omap.h>
 
 /*
  * The OMAP RTC is a year/month/day/hours/minutes/seconds BCD clock
diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index 9f26f55e4988..792f8f568808 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -3000,7 +3000,7 @@ static int _dasd_requeue_request(struct dasd_ccw_req *cqr)
 		return 0;
 	spin_lock_irq(&cqr->dq->lock);
 	req = (struct request *) cqr->callback_data;
-	blk_mq_requeue_request(req, false);
+	blk_mq_requeue_request(req, true);
 	spin_unlock_irq(&cqr->dq->lock);
 
 	return 0;
diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index 17200b453cbb..1bb3c96a04bd 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -10477,7 +10477,7 @@ lpfc_sli4_pci_mem_setup(struct lpfc_hba *phba)
 				goto out_iounmap_all;
 		} else {
 			error = -ENOMEM;
-			goto out_iounmap_all;
+			goto out_iounmap_ctrl;
 		}
 	}
 
@@ -10495,7 +10495,7 @@ lpfc_sli4_pci_mem_setup(struct lpfc_hba *phba)
 			dev_err(&pdev->dev,
 			   "ioremap failed for SLI4 HBA dpp registers.\n");
 			error = -ENOMEM;
-			goto out_iounmap_ctrl;
+			goto out_iounmap_all;
 		}
 		phba->pci_bar4_memmap_p = phba->sli4_hba.dpp_regs_memmap_p;
 	}
@@ -10520,9 +10520,11 @@ lpfc_sli4_pci_mem_setup(struct lpfc_hba *phba)
 	return 0;
 
 out_iounmap_all:
-	iounmap(phba->sli4_hba.drbl_regs_memmap_p);
+	if (phba->sli4_hba.drbl_regs_memmap_p)
+		iounmap(phba->sli4_hba.drbl_regs_memmap_p);
 out_iounmap_ctrl:
-	iounmap(phba->sli4_hba.ctrl_regs_memmap_p);
+	if (phba->sli4_hba.ctrl_regs_memmap_p)
+		iounmap(phba->sli4_hba.ctrl_regs_memmap_p);
 out_iounmap_conf:
 	iounmap(phba->sli4_hba.conf_regs_memmap_p);
 
diff --git a/drivers/scsi/megaraid.c b/drivers/scsi/megaraid.c
index daffa36988ae..810d80340676 100644
--- a/drivers/scsi/megaraid.c
+++ b/drivers/scsi/megaraid.c
@@ -1443,6 +1443,7 @@ mega_cmd_done(adapter_t *adapter, u8 completed[], int nstatus, int status)
 		 */
 		if (cmdid == CMDID_INT_CMDS) {
 			scb = &adapter->int_scb;
+			cmd = scb->cmd;
 
 			list_del_init(&scb->list);
 			scb->state = SCB_FREE;
diff --git a/drivers/scsi/qedi/qedi_main.c b/drivers/scsi/qedi/qedi_main.c
index 299d0369e4f0..7df0106f132e 100644
--- a/drivers/scsi/qedi/qedi_main.c
+++ b/drivers/scsi/qedi/qedi_main.c
@@ -2456,6 +2456,9 @@ static void __qedi_remove(struct pci_dev *pdev, int mode)
 		qedi_ops->ll2->stop(qedi->cdev);
 	}
 
+	cancel_delayed_work_sync(&qedi->recovery_work);
+	cancel_delayed_work_sync(&qedi->board_disable_work);
+
 	qedi_free_iscsi_pf_param(qedi);
 
 	rval = qedi_ops->common->update_drv_state(qedi->cdev, false);
diff --git a/drivers/soc/ti/pm33xx.c b/drivers/soc/ti/pm33xx.c
index dc21aa855a45..44ec0048911c 100644
--- a/drivers/soc/ti/pm33xx.c
+++ b/drivers/soc/ti/pm33xx.c
@@ -19,6 +19,7 @@
 #include <linux/of_address.h>
 #include <linux/platform_data/pm33xx.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/rtc.h>
 #include <linux/rtc/rtc-omap.h>
 #include <linux/sizes.h>
@@ -528,7 +529,7 @@ static int am33xx_pm_probe(struct platform_device *pdev)
 
 	ret = am33xx_pm_alloc_sram();
 	if (ret)
-		return ret;
+		goto err_wkup_m3_ipc_put;
 
 	ret = am33xx_pm_rtc_setup();
 	if (ret)
@@ -555,28 +556,41 @@ static int am33xx_pm_probe(struct platform_device *pdev)
 	suspend_wfi_flags |= WFI_FLAG_WAKE_M3;
 #endif /* CONFIG_SUSPEND */
 
+	pm_runtime_enable(dev);
+	ret = pm_runtime_get_sync(dev);
+	if (ret < 0) {
+		pm_runtime_put_noidle(dev);
+		goto err_pm_runtime_disable;
+	}
+
 	ret = pm_ops->init(am33xx_do_sram_idle);
 	if (ret) {
 		dev_err(dev, "Unable to call core pm init!\n");
 		ret = -ENODEV;
-		goto err_put_wkup_m3_ipc;
+		goto err_pm_runtime_put;
 	}
 
 	return 0;
 
-err_put_wkup_m3_ipc:
-	wkup_m3_ipc_put(m3_ipc);
+err_pm_runtime_put:
+	pm_runtime_put_sync(dev);
+err_pm_runtime_disable:
+	pm_runtime_disable(dev);
 err_unsetup_rtc:
 	iounmap(rtc_base_virt);
 	clk_put(rtc_fck);
 err_free_sram:
 	am33xx_pm_free_sram();
 	pm33xx_dev = NULL;
+err_wkup_m3_ipc_put:
+	wkup_m3_ipc_put(m3_ipc);
 	return ret;
 }
 
 static int am33xx_pm_remove(struct platform_device *pdev)
 {
+	pm_runtime_put_sync(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
 	if (pm_ops->deinit)
 		pm_ops->deinit();
 	suspend_set_ops(NULL);
diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 2e1255bf1b42..23d50a19ae27 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1355,17 +1355,30 @@ static int cqspi_remove(struct platform_device *pdev)
 static int cqspi_suspend(struct device *dev)
 {
 	struct cqspi_st *cqspi = dev_get_drvdata(dev);
+	struct spi_master *master = dev_get_drvdata(dev);
+	int ret;
 
+	ret = spi_master_suspend(master);
 	cqspi_controller_enable(cqspi, 0);
-	return 0;
+
+	clk_disable_unprepare(cqspi->clk);
+
+	return ret;
 }
 
 static int cqspi_resume(struct device *dev)
 {
 	struct cqspi_st *cqspi = dev_get_drvdata(dev);
+	struct spi_master *master = dev_get_drvdata(dev);
 
-	cqspi_controller_enable(cqspi, 1);
-	return 0;
+	clk_prepare_enable(cqspi->clk);
+	cqspi_wait_idle(cqspi);
+	cqspi_controller_init(cqspi);
+
+	cqspi->current_cs = -1;
+	cqspi->sclk = 0;
+
+	return spi_master_resume(master);
 }
 
 static const struct dev_pm_ops cqspi__dev_pm_ops = {
diff --git a/drivers/spi/spi-fsl-spi.c b/drivers/spi/spi-fsl-spi.c
index bdf94cc7be1a..1bad0ceac81b 100644
--- a/drivers/spi/spi-fsl-spi.c
+++ b/drivers/spi/spi-fsl-spi.c
@@ -207,8 +207,8 @@ static int mspi_apply_qe_mode_quirks(struct spi_mpc8xxx_cs *cs,
 				struct spi_device *spi,
 				int bits_per_word)
 {
-	/* QE uses Little Endian for words > 8
-	 * so transform all words > 8 into 8 bits
+	/* CPM/QE uses Little Endian for words > 8
+	 * so transform 16 and 32 bits words into 8 bits
 	 * Unfortnatly that doesn't work for LSB so
 	 * reject these for now */
 	/* Note: 32 bits word, LSB works iff
@@ -216,9 +216,11 @@ static int mspi_apply_qe_mode_quirks(struct spi_mpc8xxx_cs *cs,
 	if (spi->mode & SPI_LSB_FIRST &&
 	    bits_per_word > 8)
 		return -EINVAL;
-	if (bits_per_word > 8)
+	if (bits_per_word <= 8)
+		return bits_per_word;
+	if (bits_per_word == 16 || bits_per_word == 32)
 		return 8; /* pretend its 8 bits */
-	return bits_per_word;
+	return -EINVAL;
 }
 
 static int fsl_spi_setup_transfer(struct spi_device *spi,
@@ -248,7 +250,7 @@ static int fsl_spi_setup_transfer(struct spi_device *spi,
 		bits_per_word = mspi_apply_cpu_mode_quirks(cs, spi,
 							   mpc8xxx_spi,
 							   bits_per_word);
-	else if (mpc8xxx_spi->flags & SPI_QE)
+	else
 		bits_per_word = mspi_apply_qe_mode_quirks(cs, spi,
 							  bits_per_word);
 
diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 74b3b6ca15ef..bbc420865f0f 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -1554,9 +1554,8 @@ spi_imx_prepare_message(struct spi_master *master, struct spi_message *msg)
 	struct spi_imx_data *spi_imx = spi_master_get_devdata(master);
 	int ret;
 
-	ret = pm_runtime_get_sync(spi_imx->dev);
+	ret = pm_runtime_resume_and_get(spi_imx->dev);
 	if (ret < 0) {
-		pm_runtime_put_noidle(spi_imx->dev);
 		dev_err(spi_imx->dev, "failed to enable clock\n");
 		return ret;
 	}
@@ -1766,13 +1765,10 @@ static int spi_imx_remove(struct platform_device *pdev)
 	spi_bitbang_stop(&spi_imx->bitbang);
 
 	ret = pm_runtime_get_sync(spi_imx->dev);
-	if (ret < 0) {
-		pm_runtime_put_noidle(spi_imx->dev);
-		dev_err(spi_imx->dev, "failed to enable clock\n");
-		return ret;
-	}
-
-	writel(0, spi_imx->base + MXC_CSPICTRL);
+	if (ret >= 0)
+		writel(0, spi_imx->base + MXC_CSPICTRL);
+	else
+		dev_warn(spi_imx->dev, "failed to enable clock, skip hw disable\n");
 
 	pm_runtime_dont_use_autosuspend(spi_imx->dev);
 	pm_runtime_put_sync(spi_imx->dev);
diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
index f3877eeb3da6..8bf58510cca6 100644
--- a/drivers/spi/spi-qup.c
+++ b/drivers/spi/spi-qup.c
@@ -1276,18 +1276,22 @@ static int spi_qup_remove(struct platform_device *pdev)
 	struct spi_qup *controller = spi_master_get_devdata(master);
 	int ret;
 
-	ret = pm_runtime_resume_and_get(&pdev->dev);
-	if (ret < 0)
-		return ret;
+	ret = pm_runtime_get_sync(&pdev->dev);
 
-	ret = spi_qup_set_state(controller, QUP_STATE_RESET);
-	if (ret)
-		return ret;
+	if (ret >= 0) {
+		ret = spi_qup_set_state(controller, QUP_STATE_RESET);
+		if (ret)
+			dev_warn(&pdev->dev, "failed to reset controller (%pe)\n",
+				 ERR_PTR(ret));
 
-	spi_qup_release_dma(master);
+		clk_disable_unprepare(controller->cclk);
+		clk_disable_unprepare(controller->iclk);
+	} else {
+		dev_warn(&pdev->dev, "failed to resume, skip hw disable (%pe)\n",
+			 ERR_PTR(ret));
+	}
 
-	clk_disable_unprepare(controller->cclk);
-	clk_disable_unprepare(controller->iclk);
+	spi_qup_release_dma(master);
 
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
diff --git a/drivers/spmi/spmi.c b/drivers/spmi/spmi.c
index c16b60f645a4..8ca7e004a53d 100644
--- a/drivers/spmi/spmi.c
+++ b/drivers/spmi/spmi.c
@@ -348,7 +348,8 @@ static int spmi_drv_remove(struct device *dev)
 	const struct spmi_driver *sdrv = to_spmi_driver(dev->driver);
 
 	pm_runtime_get_sync(dev);
-	sdrv->remove(to_spmi_device(dev));
+	if (sdrv->remove)
+		sdrv->remove(to_spmi_device(dev));
 	pm_runtime_put_noidle(dev);
 
 	pm_runtime_disable(dev);
diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index 74adb82f37c3..a19cfb2998c9 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -101,7 +101,7 @@ struct ad2s1210_state {
 static const int ad2s1210_mode_vals[4][2] = {
 	[MOD_POS] = { 0, 0 },
 	[MOD_VEL] = { 0, 1 },
-	[MOD_CONFIG] = { 1, 0 },
+	[MOD_CONFIG] = { 1, 1 },
 };
 
 static inline void ad2s1210_set_mode(enum ad2s1210_mode mode,
diff --git a/drivers/staging/media/rkvdec/rkvdec.c b/drivers/staging/media/rkvdec/rkvdec.c
index e384ea8d7280..f6a29a707862 100644
--- a/drivers/staging/media/rkvdec/rkvdec.c
+++ b/drivers/staging/media/rkvdec/rkvdec.c
@@ -1077,6 +1077,8 @@ static int rkvdec_remove(struct platform_device *pdev)
 {
 	struct rkvdec_dev *rkvdec = platform_get_drvdata(pdev);
 
+	cancel_delayed_work_sync(&rkvdec->watchdog_work);
+
 	rkvdec_v4l2_cleanup(rkvdec);
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 99c27d6b4233..291f98251f7f 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -770,6 +770,7 @@ static int _rtl92e_sta_up(struct net_device *dev, bool is_silent_reset)
 	else
 		netif_wake_queue(dev);
 
+	priv->bfirst_after_down = false;
 	return 0;
 }
 
diff --git a/drivers/target/iscsi/iscsi_target.c b/drivers/target/iscsi/iscsi_target.c
index a237f1cf9bd6..6bb840358072 100644
--- a/drivers/target/iscsi/iscsi_target.c
+++ b/drivers/target/iscsi/iscsi_target.c
@@ -4084,9 +4084,12 @@ static void iscsit_release_commands_from_conn(struct iscsi_conn *conn)
 	list_for_each_entry_safe(cmd, cmd_tmp, &tmp_list, i_conn_node) {
 		struct se_cmd *se_cmd = &cmd->se_cmd;
 
-		if (se_cmd->se_tfo != NULL) {
-			spin_lock_irq(&se_cmd->t_state_lock);
-			if (se_cmd->transport_state & CMD_T_ABORTED) {
+		if (!se_cmd->se_tfo)
+			continue;
+
+		spin_lock_irq(&se_cmd->t_state_lock);
+		if (se_cmd->transport_state & CMD_T_ABORTED) {
+			if (!(se_cmd->transport_state & CMD_T_TAS))
 				/*
 				 * LIO's abort path owns the cleanup for this,
 				 * so put it back on the list and let
@@ -4094,11 +4097,10 @@ static void iscsit_release_commands_from_conn(struct iscsi_conn *conn)
 				 */
 				list_move_tail(&cmd->i_conn_node,
 					       &conn->conn_cmd_list);
-			} else {
-				se_cmd->transport_state |= CMD_T_FABRIC_STOP;
-			}
-			spin_unlock_irq(&se_cmd->t_state_lock);
+		} else {
+			se_cmd->transport_state |= CMD_T_FABRIC_STOP;
 		}
+		spin_unlock_irq(&se_cmd->t_state_lock);
 	}
 	spin_unlock_bh(&conn->cmd_lock);
 
diff --git a/drivers/target/target_core_device.c b/drivers/target/target_core_device.c
index 1eded5c4ebda..4664330fb55d 100644
--- a/drivers/target/target_core_device.c
+++ b/drivers/target/target_core_device.c
@@ -724,11 +724,24 @@ struct se_device *target_alloc_device(struct se_hba *hba, const char *name)
 {
 	struct se_device *dev;
 	struct se_lun *xcopy_lun;
+	int i;
 
 	dev = hba->backend->ops->alloc_device(hba, name);
 	if (!dev)
 		return NULL;
 
+	dev->queues = kcalloc(nr_cpu_ids, sizeof(*dev->queues), GFP_KERNEL);
+	if (!dev->queues) {
+		dev->transport->free_device(dev);
+		return NULL;
+	}
+
+	dev->queue_cnt = nr_cpu_ids;
+	for (i = 0; i < dev->queue_cnt; i++) {
+		INIT_LIST_HEAD(&dev->queues[i].state_list);
+		spin_lock_init(&dev->queues[i].lock);
+	}
+
 	dev->se_hba = hba;
 	dev->transport = hba->backend->ops;
 	dev->transport_flags = dev->transport->transport_flags_default;
@@ -738,9 +751,7 @@ struct se_device *target_alloc_device(struct se_hba *hba, const char *name)
 	INIT_LIST_HEAD(&dev->dev_sep_list);
 	INIT_LIST_HEAD(&dev->dev_tmr_list);
 	INIT_LIST_HEAD(&dev->delayed_cmd_list);
-	INIT_LIST_HEAD(&dev->state_list);
 	INIT_LIST_HEAD(&dev->qf_cmd_list);
-	spin_lock_init(&dev->execute_task_lock);
 	spin_lock_init(&dev->delayed_cmd_lock);
 	spin_lock_init(&dev->dev_reservation_lock);
 	spin_lock_init(&dev->se_port_lock);
@@ -759,6 +770,7 @@ struct se_device *target_alloc_device(struct se_hba *hba, const char *name)
 	spin_lock_init(&dev->t10_alua.lba_map_lock);
 
 	INIT_WORK(&dev->delayed_cmd_work, target_do_delayed_work);
+	mutex_init(&dev->lun_reset_mutex);
 
 	dev->t10_wwn.t10_dev = dev;
 	dev->t10_alua.t10_dev = dev;
@@ -1014,6 +1026,7 @@ void target_free_device(struct se_device *dev)
 	if (dev->transport->free_prot)
 		dev->transport->free_prot(dev);
 
+	kfree(dev->queues);
 	dev->transport->free_device(dev);
 }
 
diff --git a/drivers/target/target_core_sbc.c b/drivers/target/target_core_sbc.c
index eaf8551ebc61..47c5f26e6012 100644
--- a/drivers/target/target_core_sbc.c
+++ b/drivers/target/target_core_sbc.c
@@ -1438,7 +1438,7 @@ sbc_dif_verify(struct se_cmd *cmd, sector_t start, unsigned int sectors,
 			if (rc) {
 				kunmap_atomic(daddr - dsg->offset);
 				kunmap_atomic(paddr - psg->offset);
-				cmd->bad_sector = sector;
+				cmd->sense_info = sector;
 				return rc;
 			}
 next:
diff --git a/drivers/target/target_core_tmr.c b/drivers/target/target_core_tmr.c
index 3efd5a3bd69d..a2b18a98d671 100644
--- a/drivers/target/target_core_tmr.c
+++ b/drivers/target/target_core_tmr.c
@@ -121,57 +121,61 @@ void core_tmr_abort_task(
 	unsigned long flags;
 	bool rc;
 	u64 ref_tag;
-
-	spin_lock_irqsave(&dev->execute_task_lock, flags);
-	list_for_each_entry_safe(se_cmd, next, &dev->state_list, state_list) {
-
-		if (se_sess != se_cmd->se_sess)
-			continue;
-
-		/* skip task management functions, including tmr->task_cmd */
-		if (se_cmd->se_cmd_flags & SCF_SCSI_TMR_CDB)
-			continue;
-
-		ref_tag = se_cmd->tag;
-		if (tmr->ref_task_tag != ref_tag)
-			continue;
-
-		printk("ABORT_TASK: Found referenced %s task_tag: %llu\n",
-			se_cmd->se_tfo->fabric_name, ref_tag);
-
-		spin_lock(&se_sess->sess_cmd_lock);
-		rc = __target_check_io_state(se_cmd, se_sess, 0);
-		spin_unlock(&se_sess->sess_cmd_lock);
-		if (!rc)
-			continue;
-
-		list_move_tail(&se_cmd->state_list, &aborted_list);
-		se_cmd->state_active = false;
-
-		spin_unlock_irqrestore(&dev->execute_task_lock, flags);
-
-		/*
-		 * Ensure that this ABORT request is visible to the LU RESET
-		 * code.
-		 */
-		if (!tmr->tmr_dev)
-			WARN_ON_ONCE(transport_lookup_tmr_lun(tmr->task_cmd) <
-					0);
-
-		if (dev->transport->tmr_notify)
-			dev->transport->tmr_notify(dev, TMR_ABORT_TASK,
-						   &aborted_list);
-
-		list_del_init(&se_cmd->state_list);
-		target_put_cmd_and_wait(se_cmd);
-
-		printk("ABORT_TASK: Sending TMR_FUNCTION_COMPLETE for"
-				" ref_tag: %llu\n", ref_tag);
-		tmr->response = TMR_FUNCTION_COMPLETE;
-		atomic_long_inc(&dev->aborts_complete);
-		return;
+	int i;
+
+	for (i = 0; i < dev->queue_cnt; i++) {
+		spin_lock_irqsave(&dev->queues[i].lock, flags);
+		list_for_each_entry_safe(se_cmd, next, &dev->queues[i].state_list,
+					 state_list) {
+			if (se_sess != se_cmd->se_sess)
+				continue;
+
+			/*
+			 * skip task management functions, including
+			 * tmr->task_cmd
+			 */
+			if (se_cmd->se_cmd_flags & SCF_SCSI_TMR_CDB)
+				continue;
+
+			ref_tag = se_cmd->tag;
+			if (tmr->ref_task_tag != ref_tag)
+				continue;
+
+			pr_err("ABORT_TASK: Found referenced %s task_tag: %llu\n",
+			       se_cmd->se_tfo->fabric_name, ref_tag);
+
+			spin_lock(&se_sess->sess_cmd_lock);
+			rc = __target_check_io_state(se_cmd, se_sess, 0);
+			spin_unlock(&se_sess->sess_cmd_lock);
+			if (!rc)
+				continue;
+
+			list_move_tail(&se_cmd->state_list, &aborted_list);
+			se_cmd->state_active = false;
+			spin_unlock_irqrestore(&dev->queues[i].lock, flags);
+
+			/*
+			 * Ensure that this ABORT request is visible to the LU
+			 * RESET code.
+			 */
+			if (!tmr->tmr_dev)
+				WARN_ON_ONCE(transport_lookup_tmr_lun(tmr->task_cmd) < 0);
+
+			if (dev->transport->tmr_notify)
+				dev->transport->tmr_notify(dev, TMR_ABORT_TASK,
+							   &aborted_list);
+
+			list_del_init(&se_cmd->state_list);
+			target_put_cmd_and_wait(se_cmd);
+
+			pr_err("ABORT_TASK: Sending TMR_FUNCTION_COMPLETE for ref_tag: %llu\n",
+			       ref_tag);
+			tmr->response = TMR_FUNCTION_COMPLETE;
+			atomic_long_inc(&dev->aborts_complete);
+			return;
+		}
+		spin_unlock_irqrestore(&dev->queues[i].lock, flags);
 	}
-	spin_unlock_irqrestore(&dev->execute_task_lock, flags);
 
 	if (dev->transport->tmr_notify)
 		dev->transport->tmr_notify(dev, TMR_ABORT_TASK, &aborted_list);
@@ -198,14 +202,23 @@ static void core_tmr_drain_tmr_list(
 	 * LUN_RESET tmr..
 	 */
 	spin_lock_irqsave(&dev->se_tmr_lock, flags);
-	if (tmr)
-		list_del_init(&tmr->tmr_list);
 	list_for_each_entry_safe(tmr_p, tmr_pp, &dev->dev_tmr_list, tmr_list) {
+		if (tmr_p == tmr)
+			continue;
+
 		cmd = tmr_p->task_cmd;
 		if (!cmd) {
 			pr_err("Unable to locate struct se_cmd for TMR\n");
 			continue;
 		}
+
+		/*
+		 * We only execute one LUN_RESET at a time so we can't wait
+		 * on them below.
+		 */
+		if (tmr_p->function == TMR_LUN_RESET)
+			continue;
+
 		/*
 		 * If this function was called with a valid pr_res_key
 		 * parameter (eg: for PROUT PREEMPT_AND_ABORT service action
@@ -273,7 +286,7 @@ static void core_tmr_drain_state_list(
 	struct se_session *sess;
 	struct se_cmd *cmd, *next;
 	unsigned long flags;
-	int rc;
+	int rc, i;
 
 	/*
 	 * Complete outstanding commands with TASK_ABORTED SAM status.
@@ -297,35 +310,39 @@ static void core_tmr_drain_state_list(
 	 * Note that this seems to be independent of TAS (Task Aborted Status)
 	 * in the Control Mode Page.
 	 */
-	spin_lock_irqsave(&dev->execute_task_lock, flags);
-	list_for_each_entry_safe(cmd, next, &dev->state_list, state_list) {
-		/*
-		 * For PREEMPT_AND_ABORT usage, only process commands
-		 * with a matching reservation key.
-		 */
-		if (target_check_cdb_and_preempt(preempt_and_abort_list, cmd))
-			continue;
-
-		/*
-		 * Not aborting PROUT PREEMPT_AND_ABORT CDB..
-		 */
-		if (prout_cmd == cmd)
-			continue;
-
-		sess = cmd->se_sess;
-		if (WARN_ON_ONCE(!sess))
-			continue;
-
-		spin_lock(&sess->sess_cmd_lock);
-		rc = __target_check_io_state(cmd, tmr_sess, tas);
-		spin_unlock(&sess->sess_cmd_lock);
-		if (!rc)
-			continue;
-
-		list_move_tail(&cmd->state_list, &drain_task_list);
-		cmd->state_active = false;
+	for (i = 0; i < dev->queue_cnt; i++) {
+		spin_lock_irqsave(&dev->queues[i].lock, flags);
+		list_for_each_entry_safe(cmd, next, &dev->queues[i].state_list,
+					 state_list) {
+			/*
+			 * For PREEMPT_AND_ABORT usage, only process commands
+			 * with a matching reservation key.
+			 */
+			if (target_check_cdb_and_preempt(preempt_and_abort_list,
+							 cmd))
+				continue;
+
+			/*
+			 * Not aborting PROUT PREEMPT_AND_ABORT CDB..
+			 */
+			if (prout_cmd == cmd)
+				continue;
+
+			sess = cmd->se_sess;
+			if (WARN_ON_ONCE(!sess))
+				continue;
+
+			spin_lock(&sess->sess_cmd_lock);
+			rc = __target_check_io_state(cmd, tmr_sess, tas);
+			spin_unlock(&sess->sess_cmd_lock);
+			if (!rc)
+				continue;
+
+			list_move_tail(&cmd->state_list, &drain_task_list);
+			cmd->state_active = false;
+		}
+		spin_unlock_irqrestore(&dev->queues[i].lock, flags);
 	}
-	spin_unlock_irqrestore(&dev->execute_task_lock, flags);
 
 	if (dev->transport->tmr_notify)
 		dev->transport->tmr_notify(dev, preempt_and_abort_list ?
@@ -382,14 +399,25 @@ int core_tmr_lun_reset(
 				tmr_nacl->initiatorname);
 		}
 	}
+
+
+	/*
+	 * We only allow one reset or preempt and abort to execute at a time
+	 * to prevent one call from claiming all the cmds causing a second
+	 * call from returning while cmds it should have waited on are still
+	 * running.
+	 */
+	mutex_lock(&dev->lun_reset_mutex);
+
 	pr_debug("LUN_RESET: %s starting for [%s], tas: %d\n",
 		(preempt_and_abort_list) ? "Preempt" : "TMR",
 		dev->transport->name, tas);
-
 	core_tmr_drain_tmr_list(dev, tmr, preempt_and_abort_list);
 	core_tmr_drain_state_list(dev, prout_cmd, tmr_sess, tas,
 				preempt_and_abort_list);
 
+	mutex_unlock(&dev->lun_reset_mutex);
+
 	/*
 	 * Clear any legacy SPC-2 reservation when called during
 	 * LOGICAL UNIT RESET
diff --git a/drivers/target/target_core_transport.c b/drivers/target/target_core_transport.c
index bca3a32a4bfb..2e97937f005f 100644
--- a/drivers/target/target_core_transport.c
+++ b/drivers/target/target_core_transport.c
@@ -650,12 +650,12 @@ static void target_remove_from_state_list(struct se_cmd *cmd)
 	if (!dev)
 		return;
 
-	spin_lock_irqsave(&dev->execute_task_lock, flags);
+	spin_lock_irqsave(&dev->queues[cmd->cpuid].lock, flags);
 	if (cmd->state_active) {
 		list_del(&cmd->state_list);
 		cmd->state_active = false;
 	}
-	spin_unlock_irqrestore(&dev->execute_task_lock, flags);
+	spin_unlock_irqrestore(&dev->queues[cmd->cpuid].lock, flags);
 }
 
 /*
@@ -866,10 +866,7 @@ void target_complete_cmd(struct se_cmd *cmd, u8 scsi_status)
 
 	INIT_WORK(&cmd->work, success ? target_complete_ok_work :
 		  target_complete_failure_work);
-	if (cmd->se_cmd_flags & SCF_USE_CPUID)
-		queue_work_on(cmd->cpuid, target_completion_wq, &cmd->work);
-	else
-		queue_work(target_completion_wq, &cmd->work);
+	queue_work_on(cmd->cpuid, target_completion_wq, &cmd->work);
 }
 EXPORT_SYMBOL(target_complete_cmd);
 
@@ -904,12 +901,13 @@ static void target_add_to_state_list(struct se_cmd *cmd)
 	struct se_device *dev = cmd->se_dev;
 	unsigned long flags;
 
-	spin_lock_irqsave(&dev->execute_task_lock, flags);
+	spin_lock_irqsave(&dev->queues[cmd->cpuid].lock, flags);
 	if (!cmd->state_active) {
-		list_add_tail(&cmd->state_list, &dev->state_list);
+		list_add_tail(&cmd->state_list,
+			      &dev->queues[cmd->cpuid].state_list);
 		cmd->state_active = true;
 	}
-	spin_unlock_irqrestore(&dev->execute_task_lock, flags);
+	spin_unlock_irqrestore(&dev->queues[cmd->cpuid].lock, flags);
 }
 
 /*
@@ -1397,6 +1395,9 @@ void transport_init_se_cmd(
 	cmd->sense_buffer = sense_buffer;
 	cmd->orig_fe_lun = unpacked_lun;
 
+	if (!(cmd->se_cmd_flags & SCF_USE_CPUID))
+		cmd->cpuid = raw_smp_processor_id();
+
 	cmd->state_active = false;
 }
 EXPORT_SYMBOL(transport_init_se_cmd);
@@ -1614,6 +1615,9 @@ int target_submit_cmd_map_sgls(struct se_cmd *se_cmd, struct se_session *se_sess
 	BUG_ON(!se_tpg);
 	BUG_ON(se_cmd->se_tfo || se_cmd->se_sess);
 	BUG_ON(in_interrupt());
+
+	if (flags & TARGET_SCF_USE_CPUID)
+		se_cmd->se_cmd_flags |= SCF_USE_CPUID;
 	/*
 	 * Initialize se_cmd for target operation.  From this point
 	 * exceptions are handled by sending exception status via
@@ -1623,11 +1627,6 @@ int target_submit_cmd_map_sgls(struct se_cmd *se_cmd, struct se_session *se_sess
 				data_length, data_dir, task_attr, sense,
 				unpacked_lun);
 
-	if (flags & TARGET_SCF_USE_CPUID)
-		se_cmd->se_cmd_flags |= SCF_USE_CPUID;
-	else
-		se_cmd->cpuid = WORK_CPU_UNBOUND;
-
 	if (flags & TARGET_SCF_UNKNOWN_SIZE)
 		se_cmd->unknown_data_length = 1;
 	/*
@@ -3131,14 +3130,14 @@ bool transport_wait_for_tasks(struct se_cmd *cmd)
 }
 EXPORT_SYMBOL(transport_wait_for_tasks);
 
-struct sense_info {
+struct sense_detail {
 	u8 key;
 	u8 asc;
 	u8 ascq;
-	bool add_sector_info;
+	bool add_sense_info;
 };
 
-static const struct sense_info sense_info_table[] = {
+static const struct sense_detail sense_detail_table[] = {
 	[TCM_NO_SENSE] = {
 		.key = NOT_READY
 	},
@@ -3238,19 +3237,19 @@ static const struct sense_info sense_info_table[] = {
 		.key = ABORTED_COMMAND,
 		.asc = 0x10,
 		.ascq = 0x01, /* LOGICAL BLOCK GUARD CHECK FAILED */
-		.add_sector_info = true,
+		.add_sense_info = true,
 	},
 	[TCM_LOGICAL_BLOCK_APP_TAG_CHECK_FAILED] = {
 		.key = ABORTED_COMMAND,
 		.asc = 0x10,
 		.ascq = 0x02, /* LOGICAL BLOCK APPLICATION TAG CHECK FAILED */
-		.add_sector_info = true,
+		.add_sense_info = true,
 	},
 	[TCM_LOGICAL_BLOCK_REF_TAG_CHECK_FAILED] = {
 		.key = ABORTED_COMMAND,
 		.asc = 0x10,
 		.ascq = 0x03, /* LOGICAL BLOCK REFERENCE TAG CHECK FAILED */
-		.add_sector_info = true,
+		.add_sense_info = true,
 	},
 	[TCM_COPY_TARGET_DEVICE_NOT_REACHABLE] = {
 		.key = COPY_ABORTED,
@@ -3298,42 +3297,42 @@ static const struct sense_info sense_info_table[] = {
  */
 static void translate_sense_reason(struct se_cmd *cmd, sense_reason_t reason)
 {
-	const struct sense_info *si;
+	const struct sense_detail *sd;
 	u8 *buffer = cmd->sense_buffer;
 	int r = (__force int)reason;
 	u8 key, asc, ascq;
 	bool desc_format = target_sense_desc_format(cmd->se_dev);
 
-	if (r < ARRAY_SIZE(sense_info_table) && sense_info_table[r].key)
-		si = &sense_info_table[r];
+	if (r < ARRAY_SIZE(sense_detail_table) && sense_detail_table[r].key)
+		sd = &sense_detail_table[r];
 	else
-		si = &sense_info_table[(__force int)
+		sd = &sense_detail_table[(__force int)
 				       TCM_LOGICAL_UNIT_COMMUNICATION_FAILURE];
 
-	key = si->key;
+	key = sd->key;
 	if (reason == TCM_CHECK_CONDITION_UNIT_ATTENTION) {
 		if (!core_scsi3_ua_for_check_condition(cmd, &key, &asc,
 						       &ascq)) {
 			cmd->scsi_status = SAM_STAT_BUSY;
 			return;
 		}
-	} else if (si->asc == 0) {
+	} else if (sd->asc == 0) {
 		WARN_ON_ONCE(cmd->scsi_asc == 0);
 		asc = cmd->scsi_asc;
 		ascq = cmd->scsi_ascq;
 	} else {
-		asc = si->asc;
-		ascq = si->ascq;
+		asc = sd->asc;
+		ascq = sd->ascq;
 	}
 
 	cmd->se_cmd_flags |= SCF_EMULATED_TASK_SENSE;
 	cmd->scsi_status = SAM_STAT_CHECK_CONDITION;
 	cmd->scsi_sense_length  = TRANSPORT_SENSE_BUFFER;
 	scsi_build_sense_buffer(desc_format, buffer, key, asc, ascq);
-	if (si->add_sector_info)
+	if (sd->add_sense_info)
 		WARN_ON_ONCE(scsi_set_sense_information(buffer,
 							cmd->scsi_sense_length,
-							cmd->bad_sector) < 0);
+							cmd->sense_info) < 0);
 }
 
 int
diff --git a/drivers/target/tcm_fc/tfc_cmd.c b/drivers/target/tcm_fc/tfc_cmd.c
index a7ed56602c6c..8936a094f846 100644
--- a/drivers/target/tcm_fc/tfc_cmd.c
+++ b/drivers/target/tcm_fc/tfc_cmd.c
@@ -551,7 +551,7 @@ static void ft_send_work(struct work_struct *work)
 	if (target_submit_cmd(&cmd->se_cmd, cmd->sess->se_sess, fcp->fc_cdb,
 			      &cmd->ft_sense_buffer[0], scsilun_to_int(&fcp->fc_lun),
 			      ntohl(fcp->fc_dl), task_attr, data_dir,
-			      TARGET_SCF_ACK_KREF | TARGET_SCF_USE_CPUID))
+			      TARGET_SCF_ACK_KREF))
 		goto err;
 
 	pr_debug("r_ctl %x target_submit_cmd %p\n", fh->fh_r_ctl, cmd);
diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
index 0bd7aa564bc2..9fe169dbed88 100644
--- a/drivers/thermal/mtk_thermal.c
+++ b/drivers/thermal/mtk_thermal.c
@@ -1026,7 +1026,12 @@ static int mtk_thermal_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	auxadc_base = of_iomap(auxadc, 0);
+	auxadc_base = devm_of_iomap(&pdev->dev, auxadc, 0, NULL);
+	if (IS_ERR(auxadc_base)) {
+		of_node_put(auxadc);
+		return PTR_ERR(auxadc_base);
+	}
+
 	auxadc_phys_base = of_get_phys_base(auxadc);
 
 	of_node_put(auxadc);
@@ -1042,7 +1047,12 @@ static int mtk_thermal_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	apmixed_base = of_iomap(apmixedsys, 0);
+	apmixed_base = devm_of_iomap(&pdev->dev, apmixedsys, 0, NULL);
+	if (IS_ERR(apmixed_base)) {
+		of_node_put(apmixedsys);
+		return PTR_ERR(apmixed_base);
+	}
+
 	apmixed_phys_base = of_get_phys_base(apmixedsys);
 
 	of_node_put(apmixedsys);
diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index f5063499f9cf..23b014b8c919 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -50,6 +50,7 @@
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
 #include <linux/gsmmux.h>
+#include "tty.h"
 
 static int debug;
 module_param(debug, int, 0600);
diff --git a/drivers/tty/n_hdlc.c b/drivers/tty/n_hdlc.c
index 48c64e68017c..697199a3ca01 100644
--- a/drivers/tty/n_hdlc.c
+++ b/drivers/tty/n_hdlc.c
@@ -100,6 +100,7 @@
 
 #include <asm/termios.h>
 #include <linux/uaccess.h>
+#include "tty.h"
 
 /*
  * Buffers for individual HDLC frames
diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 12dde01e576b..8e7931d93543 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -49,6 +49,7 @@
 #include <linux/module.h>
 #include <linux/ratelimit.h>
 #include <linux/vmalloc.h>
+#include "tty.h"
 
 /*
  * Until this number of characters is queued in the xmit buffer, select will
diff --git a/drivers/tty/pty.c b/drivers/tty/pty.c
index 16498f5fba64..ca3e5a6c1a49 100644
--- a/drivers/tty/pty.c
+++ b/drivers/tty/pty.c
@@ -29,6 +29,7 @@
 #include <linux/file.h>
 #include <linux/ioctl.h>
 #include <linux/compat.h>
+#include "tty.h"
 
 #undef TTY_DEBUG_HANGUP
 #ifdef TTY_DEBUG_HANGUP
diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index b6dc9003b8c4..0771cd226581 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -330,6 +330,13 @@ extern int serial8250_rx_dma(struct uart_8250_port *);
 extern void serial8250_rx_dma_flush(struct uart_8250_port *);
 extern int serial8250_request_dma(struct uart_8250_port *);
 extern void serial8250_release_dma(struct uart_8250_port *);
+
+static inline bool serial8250_tx_dma_running(struct uart_8250_port *p)
+{
+	struct uart_8250_dma *dma = p->dma;
+
+	return dma && dma->tx_running;
+}
 #else
 static inline int serial8250_tx_dma(struct uart_8250_port *p)
 {
@@ -345,6 +352,11 @@ static inline int serial8250_request_dma(struct uart_8250_port *p)
 	return -1;
 }
 static inline void serial8250_release_dma(struct uart_8250_port *p) { }
+
+static inline bool serial8250_tx_dma_running(struct uart_8250_port *p)
+{
+	return false;
+}
 #endif
 
 static inline int ns16550a_goto_highspeed(struct uart_8250_port *up)
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 1f231fcda657..b19908779e3b 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -15,6 +15,7 @@
 #include <linux/moduleparam.h>
 #include <linux/ioport.h>
 #include <linux/init.h>
+#include <linux/irq.h>
 #include <linux/console.h>
 #include <linux/gpio/consumer.h>
 #include <linux/sysrq.h>
@@ -1889,6 +1890,7 @@ int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
 	unsigned char status;
 	unsigned long flags;
 	struct uart_8250_port *up = up_to_u8250p(port);
+	struct tty_port *tport = &port->state->port;
 	bool skip_rx = false;
 
 	if (iir & UART_IIR_NO_INT)
@@ -1912,6 +1914,8 @@ int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
 		skip_rx = true;
 
 	if (status & (UART_LSR_DR | UART_LSR_BI) && !skip_rx) {
+		if (irqd_is_wakeup_set(irq_get_irq_data(port->irq)))
+			pm_wakeup_event(tport->tty->dev, 0);
 		if (!up->dma || handle_rx_dma(up, iir))
 			status = serial8250_rx_chars(up, status);
 	}
@@ -1967,19 +1971,25 @@ static int serial8250_tx_threshold_handle_irq(struct uart_port *port)
 static unsigned int serial8250_tx_empty(struct uart_port *port)
 {
 	struct uart_8250_port *up = up_to_u8250p(port);
+	unsigned int result = 0;
 	unsigned long flags;
 	unsigned int lsr;
 
 	serial8250_rpm_get(up);
 
 	spin_lock_irqsave(&port->lock, flags);
-	lsr = serial_port_in(port, UART_LSR);
-	up->lsr_saved_flags |= lsr & LSR_SAVE_FLAGS;
+	if (!serial8250_tx_dma_running(up)) {
+		lsr = serial_port_in(port, UART_LSR);
+		up->lsr_saved_flags |= lsr & LSR_SAVE_FLAGS;
+
+		if ((lsr & BOTH_EMPTY) == BOTH_EMPTY)
+			result = TIOCSER_TEMT;
+	}
 	spin_unlock_irqrestore(&port->lock, flags);
 
 	serial8250_rpm_put(up);
 
-	return (lsr & BOTH_EMPTY) == BOTH_EMPTY ? TIOCSER_TEMT : 0;
+	return result;
 }
 
 unsigned int serial8250_do_get_mctrl(struct uart_port *port)
diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index f481c260b704..a2efa81471f3 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1220,7 +1220,7 @@ static inline int lpuart_start_rx_dma(struct lpuart_port *sport)
 	 * 10ms at any baud rate.
 	 */
 	sport->rx_dma_rng_buf_len = (DMA_RX_TIMEOUT * baud /  bits / 1000) * 2;
-	sport->rx_dma_rng_buf_len = (1 << (fls(sport->rx_dma_rng_buf_len) - 1));
+	sport->rx_dma_rng_buf_len = (1 << fls(sport->rx_dma_rng_buf_len));
 	if (sport->rx_dma_rng_buf_len < 16)
 		sport->rx_dma_rng_buf_len = 16;
 
diff --git a/drivers/tty/tty.h b/drivers/tty/tty.h
new file mode 100644
index 000000000000..1908f27a795a
--- /dev/null
+++ b/drivers/tty/tty.h
@@ -0,0 +1,117 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * TTY core internal functions
+ */
+
+#ifndef _TTY_INTERNAL_H
+#define _TTY_INTERNAL_H
+
+#define tty_msg(fn, tty, f, ...) \
+	fn("%s %s: " f, tty_driver_name(tty), tty_name(tty), ##__VA_ARGS__)
+
+#define tty_debug(tty, f, ...)	tty_msg(pr_debug, tty, f, ##__VA_ARGS__)
+#define tty_info(tty, f, ...)	tty_msg(pr_info, tty, f, ##__VA_ARGS__)
+#define tty_notice(tty, f, ...)	tty_msg(pr_notice, tty, f, ##__VA_ARGS__)
+#define tty_warn(tty, f, ...)	tty_msg(pr_warn, tty, f, ##__VA_ARGS__)
+#define tty_err(tty, f, ...)	tty_msg(pr_err, tty, f, ##__VA_ARGS__)
+
+#define tty_info_ratelimited(tty, f, ...) \
+		tty_msg(pr_info_ratelimited, tty, f, ##__VA_ARGS__)
+
+/*
+ * Lock subclasses for tty locks
+ *
+ * TTY_LOCK_NORMAL is for normal ttys and master ptys.
+ * TTY_LOCK_SLAVE is for slave ptys only.
+ *
+ * Lock subclasses are necessary for handling nested locking with pty pairs.
+ * tty locks which use nested locking:
+ *
+ * legacy_mutex - Nested tty locks are necessary for releasing pty pairs.
+ *		  The stable lock order is master pty first, then slave pty.
+ * termios_rwsem - The stable lock order is tty_buffer lock->termios_rwsem.
+ *		   Subclassing this lock enables the slave pty to hold its
+ *		   termios_rwsem when claiming the master tty_buffer lock.
+ * tty_buffer lock - slave ptys can claim nested buffer lock when handling
+ *		     signal chars. The stable lock order is slave pty, then
+ *		     master.
+ */
+enum {
+	TTY_LOCK_NORMAL = 0,
+	TTY_LOCK_SLAVE,
+};
+
+/* Values for tty->flow_change */
+#define TTY_THROTTLE_SAFE	1
+#define TTY_UNTHROTTLE_SAFE	2
+
+static inline void __tty_set_flow_change(struct tty_struct *tty, int val)
+{
+	tty->flow_change = val;
+}
+
+static inline void tty_set_flow_change(struct tty_struct *tty, int val)
+{
+	tty->flow_change = val;
+	smp_mb();
+}
+
+int tty_ldisc_lock(struct tty_struct *tty, unsigned long timeout);
+void tty_ldisc_unlock(struct tty_struct *tty);
+
+int __tty_check_change(struct tty_struct *tty, int sig);
+int tty_check_change(struct tty_struct *tty);
+void __stop_tty(struct tty_struct *tty);
+void __start_tty(struct tty_struct *tty);
+void tty_write_unlock(struct tty_struct *tty);
+int tty_write_lock(struct tty_struct *tty, int ndelay);
+void tty_vhangup_session(struct tty_struct *tty);
+void tty_open_proc_set_tty(struct file *filp, struct tty_struct *tty);
+int tty_signal_session_leader(struct tty_struct *tty, int exit_session);
+void session_clear_tty(struct pid *session);
+void tty_buffer_free_all(struct tty_port *port);
+void tty_buffer_flush(struct tty_struct *tty, struct tty_ldisc *ld);
+void tty_buffer_init(struct tty_port *port);
+void tty_buffer_set_lock_subclass(struct tty_port *port);
+bool tty_buffer_restart_work(struct tty_port *port);
+bool tty_buffer_cancel_work(struct tty_port *port);
+void tty_buffer_flush_work(struct tty_port *port);
+speed_t tty_termios_input_baud_rate(struct ktermios *termios);
+void tty_ldisc_hangup(struct tty_struct *tty, bool reset);
+int tty_ldisc_reinit(struct tty_struct *tty, int disc);
+long tty_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
+long tty_jobctrl_ioctl(struct tty_struct *tty, struct tty_struct *real_tty,
+		       struct file *file, unsigned int cmd, unsigned long arg);
+void tty_default_fops(struct file_operations *fops);
+struct tty_struct *alloc_tty_struct(struct tty_driver *driver, int idx);
+int tty_alloc_file(struct file *file);
+void tty_add_file(struct tty_struct *tty, struct file *file);
+void tty_free_file(struct file *file);
+int tty_release(struct inode *inode, struct file *filp);
+
+#define tty_is_writelocked(tty)  (mutex_is_locked(&tty->atomic_write_lock))
+
+int tty_ldisc_setup(struct tty_struct *tty, struct tty_struct *o_tty);
+void tty_ldisc_release(struct tty_struct *tty);
+int __must_check tty_ldisc_init(struct tty_struct *tty);
+void tty_ldisc_deinit(struct tty_struct *tty);
+
+void tty_sysctl_init(void);
+
+/* tty_audit.c */
+#ifdef CONFIG_AUDIT
+void tty_audit_add_data(struct tty_struct *tty, const void *data, size_t size);
+void tty_audit_tiocsti(struct tty_struct *tty, char ch);
+#else
+static inline void tty_audit_add_data(struct tty_struct *tty, const void *data,
+				      size_t size)
+{
+}
+static inline void tty_audit_tiocsti(struct tty_struct *tty, char ch)
+{
+}
+#endif
+
+ssize_t redirected_tty_write(struct kiocb *, struct iov_iter *);
+
+#endif
diff --git a/drivers/tty/tty_audit.c b/drivers/tty/tty_audit.c
index 9f906a5b8e81..9b30edee71fe 100644
--- a/drivers/tty/tty_audit.c
+++ b/drivers/tty/tty_audit.c
@@ -10,6 +10,7 @@
 #include <linux/audit.h>
 #include <linux/slab.h>
 #include <linux/tty.h>
+#include "tty.h"
 
 struct tty_audit_buf {
 	struct mutex mutex;	/* Protects all data below */
diff --git a/drivers/tty/tty_baudrate.c b/drivers/tty/tty_baudrate.c
index 84fec3c62d6a..9d0093d84e08 100644
--- a/drivers/tty/tty_baudrate.c
+++ b/drivers/tty/tty_baudrate.c
@@ -8,6 +8,7 @@
 #include <linux/termios.h>
 #include <linux/tty.h>
 #include <linux/export.h>
+#include "tty.h"
 
 
 /*
diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
index 5bbc2e010b48..9f2379815557 100644
--- a/drivers/tty/tty_buffer.c
+++ b/drivers/tty/tty_buffer.c
@@ -17,7 +17,7 @@
 #include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/ratelimit.h>
-
+#include "tty.h"
 
 #define MIN_TTYB_SIZE	256
 #define TTYB_ALIGN_MASK	255
diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index c37d2657308c..094e82a12d29 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -108,6 +108,7 @@
 
 #include <linux/kmod.h>
 #include <linux/nsproxy.h>
+#include "tty.h"
 
 #undef TTY_DEBUG_HANGUP
 #ifdef TTY_DEBUG_HANGUP
@@ -941,13 +942,13 @@ static ssize_t tty_read(struct kiocb *iocb, struct iov_iter *to)
 	return i;
 }
 
-static void tty_write_unlock(struct tty_struct *tty)
+void tty_write_unlock(struct tty_struct *tty)
 {
 	mutex_unlock(&tty->atomic_write_lock);
 	wake_up_interruptible_poll(&tty->write_wait, EPOLLOUT);
 }
 
-static int tty_write_lock(struct tty_struct *tty, int ndelay)
+int tty_write_lock(struct tty_struct *tty, int ndelay)
 {
 	if (!mutex_trylock(&tty->atomic_write_lock)) {
 		if (ndelay)
diff --git a/drivers/tty/tty_ioctl.c b/drivers/tty/tty_ioctl.c
index 803da2d111c8..68b07250dcb6 100644
--- a/drivers/tty/tty_ioctl.c
+++ b/drivers/tty/tty_ioctl.c
@@ -21,6 +21,7 @@
 #include <linux/bitops.h>
 #include <linux/mutex.h>
 #include <linux/compat.h>
+#include "tty.h"
 
 #include <asm/io.h>
 #include <linux/uaccess.h>
@@ -397,21 +398,42 @@ static int set_termios(struct tty_struct *tty, void __user *arg, int opt)
 	tmp_termios.c_ispeed = tty_termios_input_baud_rate(&tmp_termios);
 	tmp_termios.c_ospeed = tty_termios_baud_rate(&tmp_termios);
 
-	ld = tty_ldisc_ref(tty);
+	if (opt & (TERMIOS_FLUSH|TERMIOS_WAIT)) {
+retry_write_wait:
+		retval = wait_event_interruptible(tty->write_wait, !tty_chars_in_buffer(tty));
+		if (retval < 0)
+			return retval;
 
-	if (ld != NULL) {
-		if ((opt & TERMIOS_FLUSH) && ld->ops->flush_buffer)
-			ld->ops->flush_buffer(tty);
-		tty_ldisc_deref(ld);
-	}
+		if (tty_write_lock(tty, 0) < 0)
+			goto retry_write_wait;
 
-	if (opt & TERMIOS_WAIT) {
-		tty_wait_until_sent(tty, 0);
-		if (signal_pending(current))
-			return -ERESTARTSYS;
-	}
+		/* Racing writer? */
+		if (tty_chars_in_buffer(tty)) {
+			tty_write_unlock(tty);
+			goto retry_write_wait;
+		}
 
-	tty_set_termios(tty, &tmp_termios);
+		ld = tty_ldisc_ref(tty);
+		if (ld != NULL) {
+			if ((opt & TERMIOS_FLUSH) && ld->ops->flush_buffer)
+				ld->ops->flush_buffer(tty);
+			tty_ldisc_deref(ld);
+		}
+
+		if ((opt & TERMIOS_WAIT) && tty->ops->wait_until_sent) {
+			tty->ops->wait_until_sent(tty, 0);
+			if (signal_pending(current)) {
+				tty_write_unlock(tty);
+				return -ERESTARTSYS;
+			}
+		}
+
+		tty_set_termios(tty, &tmp_termios);
+
+		tty_write_unlock(tty);
+	} else {
+		tty_set_termios(tty, &tmp_termios);
+	}
 
 	/* FIXME: Arguably if tmp_termios == tty->termios AND the
 	   actual requested termios was not tmp_termios then we may
diff --git a/drivers/tty/tty_jobctrl.c b/drivers/tty/tty_jobctrl.c
index aa6d0537b379..95d67613b25b 100644
--- a/drivers/tty/tty_jobctrl.c
+++ b/drivers/tty/tty_jobctrl.c
@@ -11,6 +11,7 @@
 #include <linux/tty.h>
 #include <linux/fcntl.h>
 #include <linux/uaccess.h>
+#include "tty.h"
 
 static int is_ignored(int sig)
 {
diff --git a/drivers/tty/tty_ldisc.c b/drivers/tty/tty_ldisc.c
index fe37ec331289..c23938b8628d 100644
--- a/drivers/tty/tty_ldisc.c
+++ b/drivers/tty/tty_ldisc.c
@@ -19,6 +19,7 @@
 #include <linux/seq_file.h>
 #include <linux/uaccess.h>
 #include <linux/ratelimit.h>
+#include "tty.h"
 
 #undef LDISC_DEBUG_HANGUP
 
diff --git a/drivers/tty/tty_mutex.c b/drivers/tty/tty_mutex.c
index 2640635ee177..393518a24cfe 100644
--- a/drivers/tty/tty_mutex.c
+++ b/drivers/tty/tty_mutex.c
@@ -4,6 +4,7 @@
 #include <linux/kallsyms.h>
 #include <linux/semaphore.h>
 #include <linux/sched.h>
+#include "tty.h"
 
 /* Legacy tty mutex glue */
 
diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
index ea80bf872f54..cbb56f725bc4 100644
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -18,6 +18,7 @@
 #include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/serdev.h>
+#include "tty.h"
 
 static int tty_port_default_receive_buf(struct tty_port *port,
 					const unsigned char *p,
diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index f26dd1f054f2..3d18599c5b9e 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -1090,7 +1090,7 @@ static int ci_hdrc_probe(struct platform_device *pdev)
 	ret = ci_usb_phy_init(ci);
 	if (ret) {
 		dev_err(dev, "unable to init phy: %d\n", ret);
-		return ret;
+		goto ulpi_exit;
 	}
 
 	ci->hw_bank.phys = res->start;
diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index d73f624ed42a..5709b959b1d9 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1567,13 +1567,11 @@ static int dwc3_probe(struct platform_device *pdev)
 	spin_lock_init(&dwc->lock);
 	mutex_init(&dwc->mutex);
 
+	pm_runtime_get_noresume(dev);
 	pm_runtime_set_active(dev);
 	pm_runtime_use_autosuspend(dev);
 	pm_runtime_set_autosuspend_delay(dev, DWC3_DEFAULT_AUTOSUSPEND_DELAY);
 	pm_runtime_enable(dev);
-	ret = pm_runtime_get_sync(dev);
-	if (ret < 0)
-		goto err1;
 
 	pm_runtime_forbid(dev);
 
@@ -1633,12 +1631,10 @@ static int dwc3_probe(struct platform_device *pdev)
 	dwc3_free_event_buffers(dwc);
 
 err2:
-	pm_runtime_allow(&pdev->dev);
-
-err1:
-	pm_runtime_put_sync(&pdev->dev);
-	pm_runtime_disable(&pdev->dev);
-
+	pm_runtime_allow(dev);
+	pm_runtime_disable(dev);
+	pm_runtime_set_suspended(dev);
+	pm_runtime_put_noidle(dev);
 disable_clks:
 	clk_bulk_disable_unprepare(dwc->num_clks, dwc->clks);
 assert_reset:
@@ -1659,6 +1655,7 @@ static int dwc3_remove(struct platform_device *pdev)
 	dwc3_core_exit(dwc);
 	dwc3_ulpi_exit(dwc);
 
+	pm_runtime_allow(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 01cecde76140..4e3b451ed749 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -3726,15 +3726,8 @@ static void dwc3_gadget_interrupt(struct dwc3 *dwc,
 		break;
 	case DWC3_DEVICE_EVENT_EOPF:
 		/* It changed to be suspend event for version 2.30a and above */
-		if (!DWC3_VER_IS_PRIOR(DWC3, 230A)) {
-			/*
-			 * Ignore suspend event until the gadget enters into
-			 * USB_STATE_CONFIGURED state.
-			 */
-			if (dwc->gadget->state >= USB_STATE_CONFIGURED)
-				dwc3_gadget_suspend_interrupt(dwc,
-						event->event_info);
-		}
+		if (!DWC3_VER_IS_PRIOR(DWC3, 230A))
+			dwc3_gadget_suspend_interrupt(dwc, event->event_info);
 		break;
 	case DWC3_DEVICE_EVENT_SOF:
 	case DWC3_DEVICE_EVENT_ERRATIC_ERROR:
diff --git a/drivers/usb/gadget/udc/renesas_usb3.c b/drivers/usb/gadget/udc/renesas_usb3.c
index 601829a6b4ba..a10f41c4a3f2 100644
--- a/drivers/usb/gadget/udc/renesas_usb3.c
+++ b/drivers/usb/gadget/udc/renesas_usb3.c
@@ -2568,6 +2568,7 @@ static int renesas_usb3_remove(struct platform_device *pdev)
 	debugfs_remove_recursive(usb3->dentry);
 	device_remove_file(&pdev->dev, &dev_attr_role);
 
+	cancel_work_sync(&usb3->role_work);
 	usb_role_switch_unregister(usb3->role_sw);
 
 	usb_del_gadget_udc(&usb3->gadget);
diff --git a/drivers/usb/gadget/udc/tegra-xudc.c b/drivers/usb/gadget/udc/tegra-xudc.c
index 3ebc8c5416e3..66d5f6a85c84 100644
--- a/drivers/usb/gadget/udc/tegra-xudc.c
+++ b/drivers/usb/gadget/udc/tegra-xudc.c
@@ -2154,7 +2154,7 @@ static int tegra_xudc_gadget_vbus_draw(struct usb_gadget *gadget,
 
 	dev_dbg(xudc->dev, "%s: %u mA\n", __func__, m_a);
 
-	if (xudc->curr_usbphy->chg_type == SDP_TYPE)
+	if (xudc->curr_usbphy && xudc->curr_usbphy->chg_type == SDP_TYPE)
 		ret = usb_phy_set_power(xudc->curr_usbphy, m_a);
 
 	return ret;
diff --git a/drivers/usb/host/xhci-debugfs.c b/drivers/usb/host/xhci-debugfs.c
index dc832ddf7033..bd40caeeb21c 100644
--- a/drivers/usb/host/xhci-debugfs.c
+++ b/drivers/usb/host/xhci-debugfs.c
@@ -133,6 +133,7 @@ static void xhci_debugfs_regset(struct xhci_hcd *xhci, u32 base,
 	regset->regs = regs;
 	regset->nregs = nregs;
 	regset->base = hcd->regs + base;
+	regset->dev = hcd->self.controller;
 
 	debugfs_create_regset32((const char *)rgs->name, 0444, parent, regset);
 }
diff --git a/drivers/usb/host/xhci-rcar.c b/drivers/usb/host/xhci-rcar.c
index 9888ba7d85b6..cfafa1c50ade 100644
--- a/drivers/usb/host/xhci-rcar.c
+++ b/drivers/usb/host/xhci-rcar.c
@@ -75,7 +75,6 @@ MODULE_FIRMWARE(XHCI_RCAR_FIRMWARE_NAME_V3);
 
 /* For soc_device_attribute */
 #define RCAR_XHCI_FIRMWARE_V2   BIT(0) /* FIRMWARE V2 */
-#define RCAR_XHCI_FIRMWARE_V3   BIT(1) /* FIRMWARE V3 */
 
 static const struct soc_device_attribute rcar_quirks_match[]  = {
 	{
@@ -147,8 +146,6 @@ static int xhci_rcar_download_firmware(struct usb_hcd *hcd)
 
 	if (quirks & RCAR_XHCI_FIRMWARE_V2)
 		firmware_name = XHCI_RCAR_FIRMWARE_NAME_V2;
-	else if (quirks & RCAR_XHCI_FIRMWARE_V3)
-		firmware_name = XHCI_RCAR_FIRMWARE_NAME_V3;
 	else
 		firmware_name = priv->firmware_name;
 
diff --git a/drivers/usb/mtu3/mtu3_qmu.c b/drivers/usb/mtu3/mtu3_qmu.c
index 2ea3157ddb6e..e65586147965 100644
--- a/drivers/usb/mtu3/mtu3_qmu.c
+++ b/drivers/usb/mtu3/mtu3_qmu.c
@@ -210,6 +210,7 @@ static struct qmu_gpd *advance_enq_gpd(struct mtu3_gpd_ring *ring)
 	return ring->enqueue;
 }
 
+/* @dequeue may be NULL if ring is unallocated or freed */
 static struct qmu_gpd *advance_deq_gpd(struct mtu3_gpd_ring *ring)
 {
 	if (ring->dequeue < ring->end)
@@ -484,7 +485,7 @@ static void qmu_done_tx(struct mtu3 *mtu, u8 epnum)
 	dev_dbg(mtu->dev, "%s EP%d, last=%p, current=%p, enq=%p\n",
 		__func__, epnum, gpd, gpd_current, ring->enqueue);
 
-	while (gpd != gpd_current && !GET_GPD_HWO(gpd)) {
+	while (gpd && gpd != gpd_current && !GET_GPD_HWO(gpd)) {
 
 		mreq = next_request(mep);
 
@@ -523,7 +524,7 @@ static void qmu_done_rx(struct mtu3 *mtu, u8 epnum)
 	dev_dbg(mtu->dev, "%s EP%d, last=%p, current=%p, enq=%p\n",
 		__func__, epnum, gpd, gpd_current, ring->enqueue);
 
-	while (gpd != gpd_current && !GET_GPD_HWO(gpd)) {
+	while (gpd && gpd != gpd_current && !GET_GPD_HWO(gpd)) {
 
 		mreq = next_request(mep);
 
diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index da8b7bd39703..5b474efeab6a 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -595,6 +595,11 @@ static void option_instat_callback(struct urb *urb);
 #define SIERRA_VENDOR_ID			0x1199
 #define SIERRA_PRODUCT_EM9191			0x90d3
 
+/* UNISOC (Spreadtrum) products */
+#define UNISOC_VENDOR_ID			0x1782
+/* TOZED LT70-C based on UNISOC SL8563 uses UNISOC's vendor ID */
+#define TOZED_PRODUCT_LT70C			0x4055
+
 /* Device flags */
 
 /* Highest interface number which can be used with NCTRL() and RSVD() */
@@ -2225,6 +2230,7 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_AND_INTERFACE_INFO(OPPO_VENDOR_ID, OPPO_PRODUCT_R11, 0xff, 0xff, 0x30) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(SIERRA_VENDOR_ID, SIERRA_PRODUCT_EM9191, 0xff, 0xff, 0x30) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(SIERRA_VENDOR_ID, SIERRA_PRODUCT_EM9191, 0xff, 0, 0) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(UNISOC_VENDOR_ID, TOZED_PRODUCT_LT70C, 0xff, 0, 0) },
 	{ } /* Terminating entry */
 };
 MODULE_DEVICE_TABLE(usb, option_ids);
diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
index 32d0e1781e63..3cd118281980 100644
--- a/drivers/watchdog/dw_wdt.c
+++ b/drivers/watchdog/dw_wdt.c
@@ -638,7 +638,7 @@ static int dw_wdt_drv_probe(struct platform_device *pdev)
 
 	ret = dw_wdt_init_timeouts(dw_wdt, dev);
 	if (ret)
-		goto out_disable_clk;
+		goto out_assert_rst;
 
 	wdd = &dw_wdt->wdd;
 	wdd->ops = &dw_wdt_ops;
@@ -669,12 +669,15 @@ static int dw_wdt_drv_probe(struct platform_device *pdev)
 
 	ret = watchdog_register_device(wdd);
 	if (ret)
-		goto out_disable_pclk;
+		goto out_assert_rst;
 
 	dw_wdt_dbgfs_init(dw_wdt);
 
 	return 0;
 
+out_assert_rst:
+	reset_control_assert(dw_wdt->rst);
+
 out_disable_pclk:
 	clk_disable_unprepare(dw_wdt->pclk);
 
diff --git a/drivers/xen/pcpu.c b/drivers/xen/pcpu.c
index 9cf7085a260b..4581217e31fe 100644
--- a/drivers/xen/pcpu.c
+++ b/drivers/xen/pcpu.c
@@ -58,6 +58,7 @@ struct pcpu {
 	struct list_head list;
 	struct device dev;
 	uint32_t cpu_id;
+	uint32_t acpi_id;
 	uint32_t flags;
 };
 
@@ -249,6 +250,7 @@ static struct pcpu *create_and_register_pcpu(struct xenpf_pcpuinfo *info)
 
 	INIT_LIST_HEAD(&pcpu->list);
 	pcpu->cpu_id = info->xen_cpuid;
+	pcpu->acpi_id = info->acpi_id;
 	pcpu->flags = info->flags;
 
 	/* Need hold on xen_pcpu_lock before pcpu list manipulations */
@@ -416,3 +418,21 @@ static int __init xen_pcpu_init(void)
 	return ret;
 }
 arch_initcall(xen_pcpu_init);
+
+#ifdef CONFIG_ACPI
+bool __init xen_processor_present(uint32_t acpi_id)
+{
+	const struct pcpu *pcpu;
+	bool online = false;
+
+	mutex_lock(&xen_pcpu_lock);
+	list_for_each_entry(pcpu, &xen_pcpus, list)
+		if (pcpu->acpi_id == acpi_id) {
+			online = pcpu->flags & XEN_PCPU_FLAGS_ONLINE;
+			break;
+		}
+	mutex_unlock(&xen_pcpu_lock);
+
+	return online;
+}
+#endif
diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index 826fae22a8cc..fdca4262f806 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -218,6 +218,7 @@ static void afs_apply_status(struct afs_operation *op,
 			set_bit(AFS_VNODE_ZAP_DATA, &vnode->flags);
 		}
 		change_size = true;
+		data_changed = true;
 	} else if (vnode->status.type == AFS_FTYPE_DIR) {
 		/* Expected directory change is handled elsewhere so
 		 * that we can locally edit the directory and save on a
diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
index bc920afe23bf..eb41dc2f6b40 100644
--- a/fs/btrfs/block-rsv.c
+++ b/fs/btrfs/block-rsv.c
@@ -121,7 +121,8 @@ static u64 block_rsv_release_bytes(struct btrfs_fs_info *fs_info,
 	} else {
 		num_bytes = 0;
 	}
-	if (block_rsv->qgroup_rsv_reserved >= block_rsv->qgroup_rsv_size) {
+	if (qgroup_to_release_ret &&
+	    block_rsv->qgroup_rsv_reserved >= block_rsv->qgroup_rsv_size) {
 		qgroup_to_release = block_rsv->qgroup_rsv_reserved -
 				    block_rsv->qgroup_rsv_size;
 		block_rsv->qgroup_rsv_reserved = block_rsv->qgroup_rsv_size;
diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 5addd1e36a8e..3e55245e54e7 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -5160,10 +5160,12 @@ int btrfs_del_items(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 int btrfs_prev_leaf(struct btrfs_root *root, struct btrfs_path *path)
 {
 	struct btrfs_key key;
+	struct btrfs_key orig_key;
 	struct btrfs_disk_key found_key;
 	int ret;
 
 	btrfs_item_key_to_cpu(path->nodes[0], &key, 0);
+	orig_key = key;
 
 	if (key.offset > 0) {
 		key.offset--;
@@ -5180,8 +5182,36 @@ int btrfs_prev_leaf(struct btrfs_root *root, struct btrfs_path *path)
 
 	btrfs_release_path(path);
 	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
-	if (ret < 0)
+	if (ret <= 0)
 		return ret;
+
+	/*
+	 * Previous key not found. Even if we were at slot 0 of the leaf we had
+	 * before releasing the path and calling btrfs_search_slot(), we now may
+	 * be in a slot pointing to the same original key - this can happen if
+	 * after we released the path, one of more items were moved from a
+	 * sibling leaf into the front of the leaf we had due to an insertion
+	 * (see push_leaf_right()).
+	 * If we hit this case and our slot is > 0 and just decrement the slot
+	 * so that the caller does not process the same key again, which may or
+	 * may not break the caller, depending on its logic.
+	 */
+	if (path->slots[0] < btrfs_header_nritems(path->nodes[0])) {
+		btrfs_item_key(path->nodes[0], &found_key, path->slots[0]);
+		ret = comp_keys(&found_key, &orig_key);
+		if (ret == 0) {
+			if (path->slots[0] > 0) {
+				path->slots[0]--;
+				return 0;
+			}
+			/*
+			 * At slot 0, same key as before, it means orig_key is
+			 * the lowest, leftmost, key in the tree. We're done.
+			 */
+			return 1;
+		}
+	}
+
 	btrfs_item_key(path->nodes[0], &found_key, 0);
 	ret = comp_keys(&found_key, &key);
 	/*
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 10686b494f0a..63bf68e0b006 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -3702,6 +3702,11 @@ static long btrfs_ioctl_scrub(struct file *file, void __user *arg)
 	if (IS_ERR(sa))
 		return PTR_ERR(sa);
 
+	if (sa->flags & ~BTRFS_SCRUB_SUPPORTED_FLAGS) {
+		ret = -EOPNOTSUPP;
+		goto out;
+	}
+
 	if (!(sa->flags & BTRFS_SCRUB_READONLY)) {
 		ret = mnt_want_write_file(file);
 		if (ret)
diff --git a/fs/btrfs/print-tree.c b/fs/btrfs/print-tree.c
index c62771f3af8c..e98ba4e091b3 100644
--- a/fs/btrfs/print-tree.c
+++ b/fs/btrfs/print-tree.c
@@ -147,10 +147,10 @@ static void print_extent_item(struct extent_buffer *eb, int slot, int type)
 			pr_cont("shared data backref parent %llu count %u\n",
 			       offset, btrfs_shared_data_ref_count(eb, sref));
 			/*
-			 * offset is supposed to be a tree block which
-			 * must be aligned to nodesize.
+			 * Offset is supposed to be a tree block which must be
+			 * aligned to sectorsize.
 			 */
-			if (!IS_ALIGNED(offset, eb->fs_info->nodesize))
+			if (!IS_ALIGNED(offset, eb->fs_info->sectorsize))
 				pr_info(
 			"\t\t\t(parent %llu not aligned to sectorsize %u)\n",
 				     offset, eb->fs_info->sectorsize);
diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index 120c7cb11b02..015b7b37edee 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -1784,7 +1784,7 @@ smb2_copychunk_range(const unsigned int xid,
 		pcchunk->SourceOffset = cpu_to_le64(src_off);
 		pcchunk->TargetOffset = cpu_to_le64(dest_off);
 		pcchunk->Length =
-			cpu_to_le32(min_t(u32, len, tcon->max_bytes_chunk));
+			cpu_to_le32(min_t(u64, len, tcon->max_bytes_chunk));
 
 		/* Request server copy to target from src identified by key */
 		kfree(retbuf);
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 67a7ec945686..ce52f708a403 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -232,7 +232,7 @@ struct erofs_inode {
 
 	unsigned char datalayout;
 	unsigned char inode_isize;
-	unsigned short xattr_isize;
+	unsigned int xattr_isize;
 
 	unsigned int xattr_shared_count;
 	unsigned int *xattr_shared_xattrs;
diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 14d2de35110c..f18194fd8d77 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -179,6 +179,10 @@ static int legacy_load_cluster_from_disk(struct z_erofs_maprecorder *m,
 	case Z_EROFS_VLE_CLUSTER_TYPE_PLAIN:
 	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD:
 		m->clusterofs = le16_to_cpu(di->di_clusterofs);
+		if (m->clusterofs >= 1 << vi->z_logical_clusterbits) {
+			DBG_BUGON(1);
+			return -EFSCORRUPTED;
+		}
 		m->pblk = le32_to_cpu(di->di_u.blkaddr);
 		break;
 	default:
diff --git a/fs/ext4/acl.c b/fs/ext4/acl.c
index 68aaed48315f..76f634d185f1 100644
--- a/fs/ext4/acl.c
+++ b/fs/ext4/acl.c
@@ -242,7 +242,6 @@ ext4_set_acl(struct inode *inode, struct posix_acl *acl, int type)
 	handle = ext4_journal_start(inode, EXT4_HT_XATTR, credits);
 	if (IS_ERR(handle))
 		return PTR_ERR(handle);
-	ext4_fc_start_update(inode);
 
 	if ((type == ACL_TYPE_ACCESS) && acl) {
 		error = posix_acl_update_mode(inode, &mode, &acl);
@@ -260,7 +259,6 @@ ext4_set_acl(struct inode *inode, struct posix_acl *acl, int type)
 	}
 out_stop:
 	ext4_journal_stop(handle);
-	ext4_fc_stop_update(inode);
 	if (error == -ENOSPC && ext4_should_retry_alloc(inode->i_sb, &retries))
 		goto retry;
 	return error;
diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
index 1afd60fcd772..50a0e90e8af9 100644
--- a/fs/ext4/balloc.c
+++ b/fs/ext4/balloc.c
@@ -303,6 +303,22 @@ struct ext4_group_desc * ext4_get_group_desc(struct super_block *sb,
 	return desc;
 }
 
+static ext4_fsblk_t ext4_valid_block_bitmap_padding(struct super_block *sb,
+						    ext4_group_t block_group,
+						    struct buffer_head *bh)
+{
+	ext4_grpblk_t next_zero_bit;
+	unsigned long bitmap_size = sb->s_blocksize * 8;
+	unsigned int offset = num_clusters_in_group(sb, block_group);
+
+	if (bitmap_size <= offset)
+		return 0;
+
+	next_zero_bit = ext4_find_next_zero_bit(bh->b_data, bitmap_size, offset);
+
+	return (next_zero_bit < bitmap_size ? next_zero_bit : 0);
+}
+
 /*
  * Return the block number which was discovered to be invalid, or 0 if
  * the block bitmap is valid.
@@ -401,6 +417,15 @@ static int ext4_validate_block_bitmap(struct super_block *sb,
 					EXT4_GROUP_INFO_BBITMAP_CORRUPT);
 		return -EFSCORRUPTED;
 	}
+	blk = ext4_valid_block_bitmap_padding(sb, block_group, bh);
+	if (unlikely(blk != 0)) {
+		ext4_unlock_group(sb, block_group);
+		ext4_error(sb, "bg %u: block %llu: padding at end of block bitmap is not set",
+			   block_group, blk);
+		ext4_mark_group_bitmap_corrupted(sb, block_group,
+						 EXT4_GROUP_INFO_BBITMAP_CORRUPT);
+		return -EFSCORRUPTED;
+	}
 	set_buffer_verified(bh);
 verified:
 	ext4_unlock_group(sb, block_group);
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index bf0872bb34f6..2c2e1cc43e0e 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4694,7 +4694,6 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
 		     FALLOC_FL_INSERT_RANGE))
 		return -EOPNOTSUPP;
 
-	ext4_fc_start_update(inode);
 	inode_lock(inode);
 	ret = ext4_convert_inline_data(inode);
 	inode_unlock(inode);
@@ -4764,7 +4763,6 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
 	inode_unlock(inode);
 	trace_ext4_fallocate_exit(inode, offset, max_blocks, ret);
 exit:
-	ext4_fc_stop_update(inode);
 	return ret;
 }
 
@@ -5807,7 +5805,8 @@ int ext4_clu_mapped(struct inode *inode, ext4_lblk_t lclu)
 	 * mapped - no physical clusters have been allocated, and the
 	 * file has no extents
 	 */
-	if (ext4_test_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA))
+	if (ext4_test_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA) ||
+	    ext4_has_inline_data(inode))
 		return 0;
 
 	/* search for the extent closest to the first block in the cluster */
diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index aa99a3659edf..fee54ab42bba 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -269,14 +269,12 @@ static void __es_find_extent_range(struct inode *inode,
 
 	/* see if the extent has been cached */
 	es->es_lblk = es->es_len = es->es_pblk = 0;
-	if (tree->cache_es) {
-		es1 = tree->cache_es;
-		if (in_range(lblk, es1->es_lblk, es1->es_len)) {
-			es_debug("%u cached by [%u/%u) %llu %x\n",
-				 lblk, es1->es_lblk, es1->es_len,
-				 ext4_es_pblock(es1), ext4_es_status(es1));
-			goto out;
-		}
+	es1 = READ_ONCE(tree->cache_es);
+	if (es1 && in_range(lblk, es1->es_lblk, es1->es_len)) {
+		es_debug("%u cached by [%u/%u) %llu %x\n",
+			 lblk, es1->es_lblk, es1->es_len,
+			 ext4_es_pblock(es1), ext4_es_status(es1));
+		goto out;
 	}
 
 	es1 = __es_tree_search(&tree->root, lblk);
@@ -295,7 +293,7 @@ static void __es_find_extent_range(struct inode *inode,
 	}
 
 	if (es1 && matching_fn(es1)) {
-		tree->cache_es = es1;
+		WRITE_ONCE(tree->cache_es, es1);
 		es->es_lblk = es1->es_lblk;
 		es->es_len = es1->es_len;
 		es->es_pblk = es1->es_pblk;
@@ -934,14 +932,12 @@ int ext4_es_lookup_extent(struct inode *inode, ext4_lblk_t lblk,
 
 	/* find extent in cache firstly */
 	es->es_lblk = es->es_len = es->es_pblk = 0;
-	if (tree->cache_es) {
-		es1 = tree->cache_es;
-		if (in_range(lblk, es1->es_lblk, es1->es_len)) {
-			es_debug("%u cached by [%u/%u)\n",
-				 lblk, es1->es_lblk, es1->es_len);
-			found = 1;
-			goto out;
-		}
+	es1 = READ_ONCE(tree->cache_es);
+	if (es1 && in_range(lblk, es1->es_lblk, es1->es_len)) {
+		es_debug("%u cached by [%u/%u)\n",
+			 lblk, es1->es_lblk, es1->es_len);
+		found = 1;
+		goto out;
 	}
 
 	node = tree->root.rb_node;
diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 0f61e0aa85d6..f42cc1fe0ba1 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -260,7 +260,6 @@ static ssize_t ext4_buffered_write_iter(struct kiocb *iocb,
 	if (iocb->ki_flags & IOCB_NOWAIT)
 		return -EOPNOTSUPP;
 
-	ext4_fc_start_update(inode);
 	inode_lock(inode);
 	ret = ext4_write_checks(iocb, from);
 	if (ret <= 0)
@@ -272,7 +271,6 @@ static ssize_t ext4_buffered_write_iter(struct kiocb *iocb,
 
 out:
 	inode_unlock(inode);
-	ext4_fc_stop_update(inode);
 	if (likely(ret > 0)) {
 		iocb->ki_pos += ret;
 		ret = generic_write_sync(iocb, ret);
@@ -559,9 +557,7 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
 			goto out;
 		}
 
-		ext4_fc_start_update(inode);
 		ret = ext4_orphan_add(handle, inode);
-		ext4_fc_stop_update(inode);
 		if (ret) {
 			ext4_journal_stop(handle);
 			goto out;
diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 0758f606f006..979935c078fb 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -32,6 +32,7 @@ static int get_max_inline_xattr_value_size(struct inode *inode,
 	struct ext4_xattr_ibody_header *header;
 	struct ext4_xattr_entry *entry;
 	struct ext4_inode *raw_inode;
+	void *end;
 	int free, min_offs;
 
 	if (!EXT4_INODE_HAS_XATTR_SPACE(inode))
@@ -55,14 +56,23 @@ static int get_max_inline_xattr_value_size(struct inode *inode,
 	raw_inode = ext4_raw_inode(iloc);
 	header = IHDR(inode, raw_inode);
 	entry = IFIRST(header);
+	end = (void *)raw_inode + EXT4_SB(inode->i_sb)->s_inode_size;
 
 	/* Compute min_offs. */
-	for (; !IS_LAST_ENTRY(entry); entry = EXT4_XATTR_NEXT(entry)) {
+	while (!IS_LAST_ENTRY(entry)) {
+		void *next = EXT4_XATTR_NEXT(entry);
+
+		if (next >= end) {
+			EXT4_ERROR_INODE(inode,
+					 "corrupt xattr in inline inode");
+			return 0;
+		}
 		if (!entry->e_value_inum && entry->e_value_size) {
 			size_t offs = le16_to_cpu(entry->e_value_offs);
 			if (offs < min_offs)
 				min_offs = offs;
 		}
+		entry = next;
 	}
 	free = min_offs -
 		((void *)entry - (void *)IFIRST(header)) - sizeof(__u32);
@@ -348,7 +358,7 @@ static int ext4_update_inline_data(handle_t *handle, struct inode *inode,
 
 	error = ext4_xattr_ibody_get(inode, i.name_index, i.name,
 				     value, len);
-	if (error == -ENODATA)
+	if (error < 0)
 		goto out;
 
 	BUFFER_TRACE(is.iloc.bh, "get_write_access");
@@ -1172,6 +1182,7 @@ static int ext4_finish_convert_inline_dir(handle_t *handle,
 		ext4_initialize_dirent_tail(dir_block,
 					    inode->i_sb->s_blocksize);
 	set_buffer_uptodate(dir_block);
+	unlock_buffer(dir_block);
 	err = ext4_handle_dirty_dirblock(handle, inode, dir_block);
 	if (err)
 		return err;
@@ -1245,6 +1256,7 @@ static int ext4_convert_inline_data_nolock(handle_t *handle,
 	if (!S_ISDIR(inode->i_mode)) {
 		memcpy(data_bh->b_data, buf, inline_size);
 		set_buffer_uptodate(data_bh);
+		unlock_buffer(data_bh);
 		error = ext4_handle_dirty_metadata(handle,
 						   inode, data_bh);
 	} else {
@@ -1252,7 +1264,6 @@ static int ext4_convert_inline_data_nolock(handle_t *handle,
 						       buf, inline_size);
 	}
 
-	unlock_buffer(data_bh);
 out_restore:
 	if (error)
 		ext4_restore_inline_data(handle, inode, iloc, buf, inline_size);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 9bd5f8b0511b..735109b9e88d 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3564,7 +3564,7 @@ static int ext4_iomap_overwrite_begin(struct inode *inode, loff_t offset,
 	 */
 	flags &= ~IOMAP_WRITE;
 	ret = ext4_iomap_begin(inode, offset, length, flags, iomap, srcmap);
-	WARN_ON_ONCE(iomap->type != IOMAP_MAPPED);
+	WARN_ON_ONCE(!ret && iomap->type != IOMAP_MAPPED);
 	return ret;
 }
 
@@ -5437,7 +5437,7 @@ int ext4_setattr(struct dentry *dentry, struct iattr *attr)
 		if (error)
 			return error;
 	}
-	ext4_fc_start_update(inode);
+
 	if ((ia_valid & ATTR_UID && !uid_eq(attr->ia_uid, inode->i_uid)) ||
 	    (ia_valid & ATTR_GID && !gid_eq(attr->ia_gid, inode->i_gid))) {
 		handle_t *handle;
@@ -5461,7 +5461,6 @@ int ext4_setattr(struct dentry *dentry, struct iattr *attr)
 
 		if (error) {
 			ext4_journal_stop(handle);
-			ext4_fc_stop_update(inode);
 			return error;
 		}
 		/* Update corresponding info in inode so that everything is in
@@ -5473,7 +5472,6 @@ int ext4_setattr(struct dentry *dentry, struct iattr *attr)
 		error = ext4_mark_inode_dirty(handle, inode);
 		ext4_journal_stop(handle);
 		if (unlikely(error)) {
-			ext4_fc_stop_update(inode);
 			return error;
 		}
 	}
@@ -5488,12 +5486,10 @@ int ext4_setattr(struct dentry *dentry, struct iattr *attr)
 			struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
 
 			if (attr->ia_size > sbi->s_bitmap_maxbytes) {
-				ext4_fc_stop_update(inode);
 				return -EFBIG;
 			}
 		}
 		if (!S_ISREG(inode->i_mode)) {
-			ext4_fc_stop_update(inode);
 			return -EINVAL;
 		}
 
@@ -5619,7 +5615,6 @@ int ext4_setattr(struct dentry *dentry, struct iattr *attr)
 		ext4_std_error(inode->i_sb, error);
 	if (!error)
 		error = rc;
-	ext4_fc_stop_update(inode);
 	return error;
 }
 
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 53bdc67a815f..1171618f6549 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -1322,13 +1322,7 @@ static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 
 long ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
-	long ret;
-
-	ext4_fc_start_update(file_inode(filp));
-	ret = __ext4_ioctl(filp, cmd, arg);
-	ext4_fc_stop_update(file_inode(filp));
-
-	return ret;
+	return __ext4_ioctl(filp, cmd, arg);
 }
 
 #ifdef CONFIG_COMPAT
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 843840c2aced..a7c42e4bfc5e 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -4250,7 +4250,11 @@ ext4_mb_release_group_pa(struct ext4_buddy *e4b,
 	trace_ext4_mb_release_group_pa(sb, pa);
 	BUG_ON(pa->pa_deleted == 0);
 	ext4_get_group_no_and_offset(sb, pa->pa_pstart, &group, &bit);
-	BUG_ON(group != e4b->bd_group && pa->pa_len != 0);
+	if (unlikely(group != e4b->bd_group && pa->pa_len != 0)) {
+		ext4_warning(sb, "bad group: expected %u, group %u, pa_start %llu",
+			     e4b->bd_group, group, pa->pa_pstart);
+		return 0;
+	}
 	mb_free_blocks(pa->pa_inode, e4b, bit, pa->pa_len);
 	atomic_add(pa->pa_len, &EXT4_SB(sb)->s_mb_discarded);
 	trace_ext4_mballoc_discard(sb, NULL, group, bit, pa->pa_len);
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index e940fb07ef2e..8694be513241 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -2831,11 +2831,9 @@ static __le16 ext4_group_desc_csum(struct super_block *sb, __u32 block_group,
 	crc = crc16(crc, (__u8 *)gdp, offset);
 	offset += sizeof(gdp->bg_checksum); /* skip checksum */
 	/* for checksum of struct ext4_group_desc do the rest...*/
-	if (ext4_has_feature_64bit(sb) &&
-	    offset < le16_to_cpu(sbi->s_es->s_desc_size))
+	if (ext4_has_feature_64bit(sb) && offset < sbi->s_desc_size)
 		crc = crc16(crc, (__u8 *)gdp + offset,
-			    le16_to_cpu(sbi->s_es->s_desc_size) -
-				offset);
+			    sbi->s_desc_size - offset);
 
 out:
 	return cpu_to_le16(crc);
@@ -6030,9 +6028,6 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
 	}
 
 #ifdef CONFIG_QUOTA
-	/* Release old quota file names */
-	for (i = 0; i < EXT4_MAXQUOTAS; i++)
-		kfree(old_opts.s_qf_names[i]);
 	if (enable_quota) {
 		if (sb_any_quota_suspended(sb))
 			dquot_resume(sb, -1);
@@ -6042,6 +6037,9 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
 				goto restore_opts;
 		}
 	}
+	/* Release old quota file names */
+	for (i = 0; i < EXT4_MAXQUOTAS; i++)
+		kfree(old_opts.s_qf_names[i]);
 #endif
 	if (!test_opt(sb, BLOCK_VALIDITY) && sbi->s_system_blks)
 		ext4_release_system_zone(sb);
@@ -6061,6 +6059,13 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
 	return 0;
 
 restore_opts:
+	/*
+	 * If there was a failing r/w to ro transition, we may need to
+	 * re-enable quota
+	 */
+	if ((sb->s_flags & SB_RDONLY) && !(old_sb_flags & SB_RDONLY) &&
+	    sb_any_quota_suspended(sb))
+		dquot_resume(sb, -1);
 	sb->s_flags = old_sb_flags;
 	sbi->s_mount_opt = old_opts.s_mount_opt;
 	sbi->s_mount_opt2 = old_opts.s_mount_opt2;
diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 28fa9a64dc4b..abcba0255109 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -2554,6 +2554,7 @@ static int ext4_xattr_move_to_block(handle_t *handle, struct inode *inode,
 		.in_inode = !!entry->e_value_inum,
 	};
 	struct ext4_xattr_ibody_header *header = IHDR(inode, raw_inode);
+	int needs_kvfree = 0;
 	int error;
 
 	is = kzalloc(sizeof(struct ext4_xattr_ibody_find), GFP_NOFS);
@@ -2576,7 +2577,7 @@ static int ext4_xattr_move_to_block(handle_t *handle, struct inode *inode,
 			error = -ENOMEM;
 			goto out;
 		}
-
+		needs_kvfree = 1;
 		error = ext4_xattr_inode_get(inode, entry, buffer, value_size);
 		if (error)
 			goto out;
@@ -2615,7 +2616,7 @@ static int ext4_xattr_move_to_block(handle_t *handle, struct inode *inode,
 
 out:
 	kfree(b_entry_name);
-	if (entry->e_value_inum && buffer)
+	if (needs_kvfree && buffer)
 		kvfree(buffer);
 	if (is)
 		brelse(is->iloc.bh);
diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 1541da5ace85..1be9de40f0b5 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1391,6 +1391,12 @@ static int f2fs_write_raw_pages(struct compress_ctx *cc,
 		if (!PageDirty(cc->rpages[i]))
 			goto continue_unlock;
 
+		if (PageWriteback(cc->rpages[i])) {
+			if (wbc->sync_mode == WB_SYNC_NONE)
+				goto continue_unlock;
+			f2fs_wait_on_page_writeback(cc->rpages[i], DATA, true, true);
+		}
+
 		if (!clear_page_dirty_for_io(cc->rpages[i]))
 			goto continue_unlock;
 
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index db26e87b8f0d..e9481c940895 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -849,6 +849,8 @@ void f2fs_submit_merged_ipu_write(struct f2fs_sb_info *sbi,
 	bool found = false;
 	struct bio *target = bio ? *bio : NULL;
 
+	f2fs_bug_on(sbi, !target && !page);
+
 	for (temp = HOT; temp < NR_TEMP_TYPE && !found; temp++) {
 		struct f2fs_bio_info *io = sbi->write_io[DATA] + temp;
 		struct list_head *head = &io->bio_list;
@@ -2917,7 +2919,8 @@ int f2fs_write_single_data_page(struct page *page, int *submitted,
 
 	if (unlikely(f2fs_cp_error(sbi))) {
 		f2fs_submit_merged_write(sbi, DATA);
-		f2fs_submit_merged_ipu_write(sbi, bio, NULL);
+		if (bio && *bio)
+			f2fs_submit_merged_ipu_write(sbi, bio, NULL);
 		submitted = NULL;
 	}
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index c03fdda1bddf..62b7848f1f71 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1153,7 +1153,6 @@ struct f2fs_dev_info {
 #ifdef CONFIG_BLK_DEV_ZONED
 	unsigned int nr_blkz;		/* Total number of zones */
 	unsigned long *blkz_seq;	/* Bitmap indicating sequential zones */
-	block_t *zone_capacity_blocks;  /* Array of zone capacity in blks */
 #endif
 };
 
@@ -1422,6 +1421,7 @@ struct f2fs_sb_info {
 	unsigned int meta_ino_num;		/* meta inode number*/
 	unsigned int log_blocks_per_seg;	/* log2 blocks per segment */
 	unsigned int blocks_per_seg;		/* blocks per segment */
+	unsigned int unusable_blocks_per_sec;	/* unusable blocks per section */
 	unsigned int segs_per_sec;		/* segments per section */
 	unsigned int secs_per_zone;		/* sections per zone */
 	unsigned int total_sections;		/* total section count */
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index d56fcace1821..a0d8aa52b696 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3013,15 +3013,16 @@ int f2fs_transfer_project_quota(struct inode *inode, kprojid_t kprojid)
 	struct dquot *transfer_to[MAXQUOTAS] = {};
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct super_block *sb = sbi->sb;
-	int err = 0;
+	int err;
 
 	transfer_to[PRJQUOTA] = dqget(sb, make_kqid_projid(kprojid));
-	if (!IS_ERR(transfer_to[PRJQUOTA])) {
-		err = __dquot_transfer(inode, transfer_to);
-		if (err)
-			set_sbi_flag(sbi, SBI_QUOTA_NEED_REPAIR);
-		dqput(transfer_to[PRJQUOTA]);
-	}
+	if (IS_ERR(transfer_to[PRJQUOTA]))
+		return PTR_ERR(transfer_to[PRJQUOTA]);
+
+	err = __dquot_transfer(inode, transfer_to);
+	if (err)
+		set_sbi_flag(sbi, SBI_QUOTA_NEED_REPAIR);
+	dqput(transfer_to[PRJQUOTA]);
 	return err;
 }
 
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 72b109685db4..98263180c0ea 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -969,12 +969,20 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
 			goto out;
 	}
 
+	/*
+	 * Copied from ext4_rename: we need to protect against old.inode
+	 * directory getting converted from inline directory format into
+	 * a normal one.
+	 */
+	if (S_ISDIR(old_inode->i_mode))
+		inode_lock_nested(old_inode, I_MUTEX_NONDIR2);
+
 	err = -ENOENT;
 	old_entry = f2fs_find_entry(old_dir, &old_dentry->d_name, &old_page);
 	if (!old_entry) {
 		if (IS_ERR(old_page))
 			err = PTR_ERR(old_page);
-		goto out;
+		goto out_unlock_old;
 	}
 
 	if (S_ISDIR(old_inode->i_mode)) {
@@ -1082,6 +1090,9 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
 
 	f2fs_unlock_op(sbi);
 
+	if (S_ISDIR(old_inode->i_mode))
+		inode_unlock(old_inode);
+
 	if (IS_DIRSYNC(old_dir) || IS_DIRSYNC(new_dir))
 		f2fs_sync_fs(sbi->sb, 1);
 
@@ -1096,6 +1107,9 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
 		f2fs_put_page(old_dir_page, 0);
 out_old:
 	f2fs_put_page(old_page, 0);
+out_unlock_old:
+	if (S_ISDIR(old_inode->i_mode))
+		inode_unlock(old_inode);
 out:
 	if (whiteout)
 		iput(whiteout);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 7c90d93f4e43..a27a93429271 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -4957,54 +4957,6 @@ int f2fs_check_write_pointer(struct f2fs_sb_info *sbi)
 	return 0;
 }
 
-static bool is_conv_zone(struct f2fs_sb_info *sbi, unsigned int zone_idx,
-						unsigned int dev_idx)
-{
-	if (!bdev_is_zoned(FDEV(dev_idx).bdev))
-		return true;
-	return !test_bit(zone_idx, FDEV(dev_idx).blkz_seq);
-}
-
-/* Return the zone index in the given device */
-static unsigned int get_zone_idx(struct f2fs_sb_info *sbi, unsigned int secno,
-					int dev_idx)
-{
-	block_t sec_start_blkaddr = START_BLOCK(sbi, GET_SEG_FROM_SEC(sbi, secno));
-
-	return (sec_start_blkaddr - FDEV(dev_idx).start_blk) >>
-						sbi->log_blocks_per_blkz;
-}
-
-/*
- * Return the usable segments in a section based on the zone's
- * corresponding zone capacity. Zone is equal to a section.
- */
-static inline unsigned int f2fs_usable_zone_segs_in_sec(
-		struct f2fs_sb_info *sbi, unsigned int segno)
-{
-	unsigned int dev_idx, zone_idx, unusable_segs_in_sec;
-
-	dev_idx = f2fs_target_device_index(sbi, START_BLOCK(sbi, segno));
-	zone_idx = get_zone_idx(sbi, GET_SEC_FROM_SEG(sbi, segno), dev_idx);
-
-	/* Conventional zone's capacity is always equal to zone size */
-	if (is_conv_zone(sbi, zone_idx, dev_idx))
-		return sbi->segs_per_sec;
-
-	/*
-	 * If the zone_capacity_blocks array is NULL, then zone capacity
-	 * is equal to the zone size for all zones
-	 */
-	if (!FDEV(dev_idx).zone_capacity_blocks)
-		return sbi->segs_per_sec;
-
-	/* Get the segment count beyond zone capacity block */
-	unusable_segs_in_sec = (sbi->blocks_per_blkz -
-				FDEV(dev_idx).zone_capacity_blocks[zone_idx]) >>
-				sbi->log_blocks_per_seg;
-	return sbi->segs_per_sec - unusable_segs_in_sec;
-}
-
 /*
  * Return the number of usable blocks in a segment. The number of blocks
  * returned is always equal to the number of blocks in a segment for
@@ -5017,26 +4969,15 @@ static inline unsigned int f2fs_usable_zone_blks_in_seg(
 			struct f2fs_sb_info *sbi, unsigned int segno)
 {
 	block_t seg_start, sec_start_blkaddr, sec_cap_blkaddr;
-	unsigned int zone_idx, dev_idx, secno;
-
-	secno = GET_SEC_FROM_SEG(sbi, segno);
-	seg_start = START_BLOCK(sbi, segno);
-	dev_idx = f2fs_target_device_index(sbi, seg_start);
-	zone_idx = get_zone_idx(sbi, secno, dev_idx);
-
-	/*
-	 * Conventional zone's capacity is always equal to zone size,
-	 * so, blocks per segment is unchanged.
-	 */
-	if (is_conv_zone(sbi, zone_idx, dev_idx))
-		return sbi->blocks_per_seg;
+	unsigned int secno;
 
-	if (!FDEV(dev_idx).zone_capacity_blocks)
+	if (!sbi->unusable_blocks_per_sec)
 		return sbi->blocks_per_seg;
 
+	secno = GET_SEC_FROM_SEG(sbi, segno);
+	seg_start = START_BLOCK(sbi, segno);
 	sec_start_blkaddr = START_BLOCK(sbi, GET_SEG_FROM_SEC(sbi, secno));
-	sec_cap_blkaddr = sec_start_blkaddr +
-				FDEV(dev_idx).zone_capacity_blocks[zone_idx];
+	sec_cap_blkaddr = sec_start_blkaddr + CAP_BLKS_PER_SEC(sbi);
 
 	/*
 	 * If segment starts before zone capacity and spans beyond
@@ -5068,11 +5009,6 @@ static inline unsigned int f2fs_usable_zone_blks_in_seg(struct f2fs_sb_info *sbi
 	return 0;
 }
 
-static inline unsigned int f2fs_usable_zone_segs_in_sec(struct f2fs_sb_info *sbi,
-							unsigned int segno)
-{
-	return 0;
-}
 #endif
 unsigned int f2fs_usable_blks_in_seg(struct f2fs_sb_info *sbi,
 					unsigned int segno)
@@ -5087,7 +5023,7 @@ unsigned int f2fs_usable_segs_in_sec(struct f2fs_sb_info *sbi,
 					unsigned int segno)
 {
 	if (f2fs_sb_has_blkzoned(sbi))
-		return f2fs_usable_zone_segs_in_sec(sbi, segno);
+		return CAP_SEGS_PER_SEC(sbi);
 
 	return sbi->segs_per_sec;
 }
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index eafd89f0c77e..979296b835b5 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -101,6 +101,12 @@ static inline void sanity_check_seg_type(struct f2fs_sb_info *sbi,
 		GET_SEGNO_FROM_SEG0(sbi, blk_addr)))
 #define BLKS_PER_SEC(sbi)					\
 	((sbi)->segs_per_sec * (sbi)->blocks_per_seg)
+#define CAP_BLKS_PER_SEC(sbi)					\
+	((sbi)->segs_per_sec * (sbi)->blocks_per_seg -		\
+	 (sbi)->unusable_blocks_per_sec)
+#define CAP_SEGS_PER_SEC(sbi)					\
+	((sbi)->segs_per_sec - ((sbi)->unusable_blocks_per_sec >>\
+	(sbi)->log_blocks_per_seg))
 #define GET_SEC_FROM_SEG(sbi, segno)				\
 	(((segno) == -1) ? -1: (segno) / (sbi)->segs_per_sec)
 #define GET_SEG_FROM_SEC(sbi, secno)				\
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 0bba5c72fc77..9a74d60f61db 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1242,7 +1242,6 @@ static void destroy_device_list(struct f2fs_sb_info *sbi)
 		blkdev_put(FDEV(i).bdev, FMODE_EXCL);
 #ifdef CONFIG_BLK_DEV_ZONED
 		kvfree(FDEV(i).blkz_seq);
-		kfree(FDEV(i).zone_capacity_blocks);
 #endif
 	}
 	kvfree(sbi->devs);
@@ -3199,24 +3198,29 @@ static int init_percpu_info(struct f2fs_sb_info *sbi)
 #ifdef CONFIG_BLK_DEV_ZONED
 
 struct f2fs_report_zones_args {
+	struct f2fs_sb_info *sbi;
 	struct f2fs_dev_info *dev;
-	bool zone_cap_mismatch;
 };
 
 static int f2fs_report_zone_cb(struct blk_zone *zone, unsigned int idx,
 			      void *data)
 {
 	struct f2fs_report_zones_args *rz_args = data;
+	block_t unusable_blocks = (zone->len - zone->capacity) >>
+					F2FS_LOG_SECTORS_PER_BLOCK;
 
 	if (zone->type == BLK_ZONE_TYPE_CONVENTIONAL)
 		return 0;
 
 	set_bit(idx, rz_args->dev->blkz_seq);
-	rz_args->dev->zone_capacity_blocks[idx] = zone->capacity >>
-						F2FS_LOG_SECTORS_PER_BLOCK;
-	if (zone->len != zone->capacity && !rz_args->zone_cap_mismatch)
-		rz_args->zone_cap_mismatch = true;
-
+	if (!rz_args->sbi->unusable_blocks_per_sec) {
+		rz_args->sbi->unusable_blocks_per_sec = unusable_blocks;
+		return 0;
+	}
+	if (rz_args->sbi->unusable_blocks_per_sec != unusable_blocks) {
+		f2fs_err(rz_args->sbi, "F2FS supports single zone capacity\n");
+		return -EINVAL;
+	}
 	return 0;
 }
 
@@ -3250,26 +3254,13 @@ static int init_blkz_info(struct f2fs_sb_info *sbi, int devi)
 	if (!FDEV(devi).blkz_seq)
 		return -ENOMEM;
 
-	/* Get block zones type and zone-capacity */
-	FDEV(devi).zone_capacity_blocks = f2fs_kzalloc(sbi,
-					FDEV(devi).nr_blkz * sizeof(block_t),
-					GFP_KERNEL);
-	if (!FDEV(devi).zone_capacity_blocks)
-		return -ENOMEM;
-
+	rep_zone_arg.sbi = sbi;
 	rep_zone_arg.dev = &FDEV(devi);
-	rep_zone_arg.zone_cap_mismatch = false;
 
 	ret = blkdev_report_zones(bdev, 0, BLK_ALL_ZONES, f2fs_report_zone_cb,
 				  &rep_zone_arg);
 	if (ret < 0)
 		return ret;
-
-	if (!rep_zone_arg.zone_cap_mismatch) {
-		kfree(FDEV(devi).zone_capacity_blocks);
-		FDEV(devi).zone_capacity_blocks = NULL;
-	}
-
 	return 0;
 }
 #endif
diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 46c15dd2405c..045a3bd520ca 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -700,7 +700,7 @@ void wbc_detach_inode(struct writeback_control *wbc)
 		 * is okay.  The main goal is avoiding keeping an inode on
 		 * the wrong wb for an extended period of time.
 		 */
-		if (hweight32(history) > WB_FRN_HIST_THR_SLOTS)
+		if (hweight16(history) > WB_FRN_HIST_THR_SLOTS)
 			inode_switch_wbs(inode, max_id);
 	}
 
@@ -884,6 +884,16 @@ static void bdi_split_work_to_wbs(struct backing_dev_info *bdi,
 			continue;
 		}
 
+		/*
+		 * If wb_tryget fails, the wb has been shutdown, skip it.
+		 *
+		 * Pin @wb so that it stays on @bdi->wb_list.  This allows
+		 * continuing iteration from @wb after dropping and
+		 * regrabbing rcu read lock.
+		 */
+		if (!wb_tryget(wb))
+			continue;
+
 		/* alloc failed, execute synchronously using on-stack fallback */
 		work = &fallback_work;
 		*work = *base_work;
@@ -892,13 +902,6 @@ static void bdi_split_work_to_wbs(struct backing_dev_info *bdi,
 		work->done = &fallback_work_done;
 
 		wb_queue_work(wb, work);
-
-		/*
-		 * Pin @wb so that it stays on @bdi->wb_list.  This allows
-		 * continuing iteration from @wb after dropping and
-		 * regrabbing rcu read lock.
-		 */
-		wb_get(wb);
 		last_wb = wb;
 
 		rcu_read_unlock();
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 6689d235de8a..fee325d62bfd 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -757,6 +757,7 @@ int jbd2_fc_begin_commit(journal_t *journal, tid_t tid)
 	}
 	journal->j_flags |= JBD2_FAST_COMMIT_ONGOING;
 	write_unlock(&journal->j_state_lock);
+	jbd2_journal_lock_updates(journal);
 
 	return 0;
 }
@@ -768,6 +769,7 @@ EXPORT_SYMBOL(jbd2_fc_begin_commit);
  */
 static int __jbd2_fc_end_commit(journal_t *journal, tid_t tid, bool fallback)
 {
+	jbd2_journal_unlock_updates(journal);
 	if (journal->j_fc_cleanup_callback)
 		journal->j_fc_cleanup_callback(journal, 0);
 	write_lock(&journal->j_state_lock);
diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index 1923528154b5..1baf2d607268 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -2378,6 +2378,9 @@ static int journal_unmap_buffer(journal_t *journal, struct buffer_head *bh,
 			spin_unlock(&jh->b_state_lock);
 			write_unlock(&journal->j_state_lock);
 			jbd2_journal_put_journal_head(jh);
+			/* Already zapped buffer? Nothing to do... */
+			if (!bh->b_bdev)
+				return 0;
 			return -EBUSY;
 		}
 		/*
diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index 628e030f8e3b..ff6ca05a9d44 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -67,6 +67,8 @@
 
 #define OPENOWNER_POOL_SIZE	8
 
+static void nfs4_state_start_reclaim_reboot(struct nfs_client *clp);
+
 const nfs4_stateid zero_stateid = {
 	{ .data = { 0 } },
 	.type = NFS4_SPECIAL_STATEID_TYPE,
@@ -330,6 +332,8 @@ int nfs41_init_clientid(struct nfs_client *clp, const struct cred *cred)
 	status = nfs4_proc_create_session(clp, cred);
 	if (status != 0)
 		goto out;
+	if (!(clp->cl_exchange_flags & EXCHGID4_FLAG_CONFIRMED_R))
+		nfs4_state_start_reclaim_reboot(clp);
 	nfs41_finish_session_reset(clp);
 	nfs_mark_client_ready(clp, NFS_CS_READY);
 out:
diff --git a/fs/nilfs2/bmap.c b/fs/nilfs2/bmap.c
index 5900879d5693..8ebb69c4ad18 100644
--- a/fs/nilfs2/bmap.c
+++ b/fs/nilfs2/bmap.c
@@ -67,20 +67,28 @@ int nilfs_bmap_lookup_at_level(struct nilfs_bmap *bmap, __u64 key, int level,
 
 	down_read(&bmap->b_sem);
 	ret = bmap->b_ops->bop_lookup(bmap, key, level, ptrp);
-	if (ret < 0) {
-		ret = nilfs_bmap_convert_error(bmap, __func__, ret);
+	if (ret < 0)
 		goto out;
-	}
+
 	if (NILFS_BMAP_USE_VBN(bmap)) {
 		ret = nilfs_dat_translate(nilfs_bmap_get_dat(bmap), *ptrp,
 					  &blocknr);
 		if (!ret)
 			*ptrp = blocknr;
+		else if (ret == -ENOENT) {
+			/*
+			 * If there was no valid entry in DAT for the block
+			 * address obtained by b_ops->bop_lookup, then pass
+			 * internal code -EINVAL to nilfs_bmap_convert_error
+			 * to treat it as metadata corruption.
+			 */
+			ret = -EINVAL;
+		}
 	}
 
  out:
 	up_read(&bmap->b_sem);
-	return ret;
+	return nilfs_bmap_convert_error(bmap, __func__, ret);
 }
 
 int nilfs_bmap_lookup_contig(struct nilfs_bmap *bmap, __u64 key, __u64 *ptrp,
diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index fff2cdc69e5e..cdaca232ac4d 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -2044,6 +2044,9 @@ static int nilfs_segctor_do_construct(struct nilfs_sc_info *sci, int mode)
 	struct the_nilfs *nilfs = sci->sc_super->s_fs_info;
 	int err;
 
+	if (sb_rdonly(sci->sc_super))
+		return -EROFS;
+
 	nilfs_sc_cstage_set(sci, NILFS_ST_INIT);
 	sci->sc_cno = nilfs->ns_cno;
 
@@ -2729,7 +2732,7 @@ static void nilfs_segctor_write_out(struct nilfs_sc_info *sci)
 
 		flush_work(&sci->sc_iput_work);
 
-	} while (ret && retrycount-- > 0);
+	} while (ret && ret != -EROFS && retrycount-- > 0);
 }
 
 /**
diff --git a/fs/notify/inotify/inotify_fsnotify.c b/fs/notify/inotify/inotify_fsnotify.c
index 1901d799909b..66991c7fef9e 100644
--- a/fs/notify/inotify/inotify_fsnotify.c
+++ b/fs/notify/inotify/inotify_fsnotify.c
@@ -64,7 +64,7 @@ int inotify_handle_inode_event(struct fsnotify_mark *inode_mark, u32 mask,
 	struct fsnotify_event *fsn_event;
 	struct fsnotify_group *group = inode_mark->group;
 	int ret;
-	int len = 0;
+	int len = 0, wd;
 	int alloc_len = sizeof(struct inotify_event_info);
 	struct mem_cgroup *old_memcg;
 
@@ -79,6 +79,13 @@ int inotify_handle_inode_event(struct fsnotify_mark *inode_mark, u32 mask,
 	i_mark = container_of(inode_mark, struct inotify_inode_mark,
 			      fsn_mark);
 
+	/*
+	 * We can be racing with mark being detached. Don't report event with
+	 * invalid wd.
+	 */
+	wd = READ_ONCE(i_mark->wd);
+	if (wd == -1)
+		return 0;
 	/*
 	 * Whoever is interested in the event, pays for the allocation. Do not
 	 * trigger OOM killer in the target monitoring memcg as it may have
@@ -109,7 +116,7 @@ int inotify_handle_inode_event(struct fsnotify_mark *inode_mark, u32 mask,
 	fsn_event = &event->fse;
 	fsnotify_init_event(fsn_event, 0);
 	event->mask = mask;
-	event->wd = i_mark->wd;
+	event->wd = wd;
 	event->sync_cookie = cookie;
 	event->name_len = len;
 	if (len)
diff --git a/fs/pstore/pmsg.c b/fs/pstore/pmsg.c
index 18cf94b597e0..d8542ec2f38c 100644
--- a/fs/pstore/pmsg.c
+++ b/fs/pstore/pmsg.c
@@ -7,10 +7,9 @@
 #include <linux/device.h>
 #include <linux/fs.h>
 #include <linux/uaccess.h>
-#include <linux/rtmutex.h>
 #include "internal.h"
 
-static DEFINE_RT_MUTEX(pmsg_lock);
+static DEFINE_MUTEX(pmsg_lock);
 
 static ssize_t write_pmsg(struct file *file, const char __user *buf,
 			  size_t count, loff_t *ppos)
@@ -29,9 +28,9 @@ static ssize_t write_pmsg(struct file *file, const char __user *buf,
 	if (!access_ok(buf, count))
 		return -EFAULT;
 
-	rt_mutex_lock(&pmsg_lock);
+	mutex_lock(&pmsg_lock);
 	ret = psinfo->write_user(&record, buf);
-	rt_mutex_unlock(&pmsg_lock);
+	mutex_unlock(&pmsg_lock);
 	return ret ? ret : count;
 }
 
diff --git a/fs/reiserfs/xattr_security.c b/fs/reiserfs/xattr_security.c
index 59d87f9f72fb..159af6c26f4b 100644
--- a/fs/reiserfs/xattr_security.c
+++ b/fs/reiserfs/xattr_security.c
@@ -81,11 +81,15 @@ int reiserfs_security_write(struct reiserfs_transaction_handle *th,
 			    struct inode *inode,
 			    struct reiserfs_security_handle *sec)
 {
+	char xattr_name[XATTR_NAME_MAX + 1] = XATTR_SECURITY_PREFIX;
 	int error;
-	if (strlen(sec->name) < sizeof(XATTR_SECURITY_PREFIX))
+
+	if (XATTR_SECURITY_PREFIX_LEN + strlen(sec->name) > XATTR_NAME_MAX)
 		return -EINVAL;
 
-	error = reiserfs_xattr_set_handle(th, inode, sec->name, sec->value,
+	strlcat(xattr_name, sec->name, sizeof(xattr_name));
+
+	error = reiserfs_xattr_set_handle(th, inode, xattr_name, sec->value,
 					  sec->length, XATTR_CREATE);
 	if (error == -ENODATA || error == -EOPNOTSUPP)
 		error = 0;
diff --git a/fs/ubifs/dir.c b/fs/ubifs/dir.c
index 6039943877e1..bc562b1072d3 100644
--- a/fs/ubifs/dir.c
+++ b/fs/ubifs/dir.c
@@ -425,6 +425,7 @@ static int do_tmpfile(struct inode *dir, struct dentry *dentry,
 	mutex_unlock(&dir_ui->ui_mutex);
 
 	ubifs_release_budget(c, &req);
+	fscrypt_free_filename(&nm);
 
 	return 0;
 
diff --git a/fs/ubifs/tnc.c b/fs/ubifs/tnc.c
index 07470449b960..2313c7174e3c 100644
--- a/fs/ubifs/tnc.c
+++ b/fs/ubifs/tnc.c
@@ -44,6 +44,33 @@ enum {
 	NOT_ON_MEDIA = 3,
 };
 
+static void do_insert_old_idx(struct ubifs_info *c,
+			      struct ubifs_old_idx *old_idx)
+{
+	struct ubifs_old_idx *o;
+	struct rb_node **p, *parent = NULL;
+
+	p = &c->old_idx.rb_node;
+	while (*p) {
+		parent = *p;
+		o = rb_entry(parent, struct ubifs_old_idx, rb);
+		if (old_idx->lnum < o->lnum)
+			p = &(*p)->rb_left;
+		else if (old_idx->lnum > o->lnum)
+			p = &(*p)->rb_right;
+		else if (old_idx->offs < o->offs)
+			p = &(*p)->rb_left;
+		else if (old_idx->offs > o->offs)
+			p = &(*p)->rb_right;
+		else {
+			ubifs_err(c, "old idx added twice!");
+			kfree(old_idx);
+		}
+	}
+	rb_link_node(&old_idx->rb, parent, p);
+	rb_insert_color(&old_idx->rb, &c->old_idx);
+}
+
 /**
  * insert_old_idx - record an index node obsoleted since the last commit start.
  * @c: UBIFS file-system description object
@@ -69,35 +96,15 @@ enum {
  */
 static int insert_old_idx(struct ubifs_info *c, int lnum, int offs)
 {
-	struct ubifs_old_idx *old_idx, *o;
-	struct rb_node **p, *parent = NULL;
+	struct ubifs_old_idx *old_idx;
 
 	old_idx = kmalloc(sizeof(struct ubifs_old_idx), GFP_NOFS);
 	if (unlikely(!old_idx))
 		return -ENOMEM;
 	old_idx->lnum = lnum;
 	old_idx->offs = offs;
+	do_insert_old_idx(c, old_idx);
 
-	p = &c->old_idx.rb_node;
-	while (*p) {
-		parent = *p;
-		o = rb_entry(parent, struct ubifs_old_idx, rb);
-		if (lnum < o->lnum)
-			p = &(*p)->rb_left;
-		else if (lnum > o->lnum)
-			p = &(*p)->rb_right;
-		else if (offs < o->offs)
-			p = &(*p)->rb_left;
-		else if (offs > o->offs)
-			p = &(*p)->rb_right;
-		else {
-			ubifs_err(c, "old idx added twice!");
-			kfree(old_idx);
-			return 0;
-		}
-	}
-	rb_link_node(&old_idx->rb, parent, p);
-	rb_insert_color(&old_idx->rb, &c->old_idx);
 	return 0;
 }
 
@@ -199,23 +206,6 @@ static struct ubifs_znode *copy_znode(struct ubifs_info *c,
 	__set_bit(DIRTY_ZNODE, &zn->flags);
 	__clear_bit(COW_ZNODE, &zn->flags);
 
-	ubifs_assert(c, !ubifs_zn_obsolete(znode));
-	__set_bit(OBSOLETE_ZNODE, &znode->flags);
-
-	if (znode->level != 0) {
-		int i;
-		const int n = zn->child_cnt;
-
-		/* The children now have new parent */
-		for (i = 0; i < n; i++) {
-			struct ubifs_zbranch *zbr = &zn->zbranch[i];
-
-			if (zbr->znode)
-				zbr->znode->parent = zn;
-		}
-	}
-
-	atomic_long_inc(&c->dirty_zn_cnt);
 	return zn;
 }
 
@@ -233,6 +223,42 @@ static int add_idx_dirt(struct ubifs_info *c, int lnum, int dirt)
 	return ubifs_add_dirt(c, lnum, dirt);
 }
 
+/**
+ * replace_znode - replace old znode with new znode.
+ * @c: UBIFS file-system description object
+ * @new_zn: new znode
+ * @old_zn: old znode
+ * @zbr: the branch of parent znode
+ *
+ * Replace old znode with new znode in TNC.
+ */
+static void replace_znode(struct ubifs_info *c, struct ubifs_znode *new_zn,
+			  struct ubifs_znode *old_zn, struct ubifs_zbranch *zbr)
+{
+	ubifs_assert(c, !ubifs_zn_obsolete(old_zn));
+	__set_bit(OBSOLETE_ZNODE, &old_zn->flags);
+
+	if (old_zn->level != 0) {
+		int i;
+		const int n = new_zn->child_cnt;
+
+		/* The children now have new parent */
+		for (i = 0; i < n; i++) {
+			struct ubifs_zbranch *child = &new_zn->zbranch[i];
+
+			if (child->znode)
+				child->znode->parent = new_zn;
+		}
+	}
+
+	zbr->znode = new_zn;
+	zbr->lnum = 0;
+	zbr->offs = 0;
+	zbr->len = 0;
+
+	atomic_long_inc(&c->dirty_zn_cnt);
+}
+
 /**
  * dirty_cow_znode - ensure a znode is not being committed.
  * @c: UBIFS file-system description object
@@ -265,28 +291,32 @@ static struct ubifs_znode *dirty_cow_znode(struct ubifs_info *c,
 		return zn;
 
 	if (zbr->len) {
-		err = insert_old_idx(c, zbr->lnum, zbr->offs);
-		if (unlikely(err))
-			/*
-			 * Obsolete znodes will be freed by tnc_destroy_cnext()
-			 * or free_obsolete_znodes(), copied up znodes should
-			 * be added back to tnc and freed by
-			 * ubifs_destroy_tnc_subtree().
-			 */
+		struct ubifs_old_idx *old_idx;
+
+		old_idx = kmalloc(sizeof(struct ubifs_old_idx), GFP_NOFS);
+		if (unlikely(!old_idx)) {
+			err = -ENOMEM;
 			goto out;
+		}
+		old_idx->lnum = zbr->lnum;
+		old_idx->offs = zbr->offs;
+
 		err = add_idx_dirt(c, zbr->lnum, zbr->len);
-	} else
-		err = 0;
+		if (err) {
+			kfree(old_idx);
+			goto out;
+		}
 
-out:
-	zbr->znode = zn;
-	zbr->lnum = 0;
-	zbr->offs = 0;
-	zbr->len = 0;
+		do_insert_old_idx(c, old_idx);
+	}
+
+	replace_znode(c, zn, znode, zbr);
 
-	if (unlikely(err))
-		return ERR_PTR(err);
 	return zn;
+
+out:
+	kfree(zn);
+	return ERR_PTR(err);
 }
 
 /**
diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index 9ea83d80eb6f..dcbd41048b4e 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -190,7 +190,7 @@ static inline u64 readq(const volatile void __iomem *addr)
 	u64 val;
 
 	__io_br();
-	val = __le64_to_cpu(__raw_readq(addr));
+	val = __le64_to_cpu((__le64 __force)__raw_readq(addr));
 	__io_ar(val);
 	return val;
 }
@@ -233,7 +233,7 @@ static inline void writel(u32 value, volatile void __iomem *addr)
 static inline void writeq(u64 value, volatile void __iomem *addr)
 {
 	__io_bw();
-	__raw_writeq(__cpu_to_le64(value), addr);
+	__raw_writeq((u64 __force)__cpu_to_le64(value), addr);
 	__io_aw();
 }
 #endif
diff --git a/include/linux/blk-crypto.h b/include/linux/blk-crypto.h
index 69b24fe92cbf..5e96bad54804 100644
--- a/include/linux/blk-crypto.h
+++ b/include/linux/blk-crypto.h
@@ -97,8 +97,8 @@ int blk_crypto_init_key(struct blk_crypto_key *blk_key, const u8 *raw_key,
 int blk_crypto_start_using_key(const struct blk_crypto_key *key,
 			       struct request_queue *q);
 
-int blk_crypto_evict_key(struct request_queue *q,
-			 const struct blk_crypto_key *key);
+void blk_crypto_evict_key(struct request_queue *q,
+			  const struct blk_crypto_key *key);
 
 bool blk_crypto_config_supported(struct request_queue *q,
 				 const struct blk_crypto_config *cfg);
diff --git a/include/linux/mailbox/zynqmp-ipi-message.h b/include/linux/mailbox/zynqmp-ipi-message.h
index 35ce84c8ca02..31d8046d945e 100644
--- a/include/linux/mailbox/zynqmp-ipi-message.h
+++ b/include/linux/mailbox/zynqmp-ipi-message.h
@@ -9,7 +9,7 @@
  * @data: message payload
  *
  * This is the structure for data used in mbox_send_message
- * the maximum length of data buffer is fixed to 12 bytes.
+ * the maximum length of data buffer is fixed to 32 bytes.
  * Client is supposed to be aware of this.
  */
 struct zynqmp_ipi_message {
diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index 6ca97729b54a..88dbb2009080 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -8331,7 +8331,8 @@ struct mlx5_ifc_alloc_flow_counter_in_bits {
 	u8         reserved_at_20[0x10];
 	u8         op_mod[0x10];
 
-	u8         reserved_at_40[0x38];
+	u8         reserved_at_40[0x33];
+	u8         flow_counter_bulk_log_size[0x5];
 	u8         flow_counter_bulk[0x8];
 };
 
diff --git a/include/linux/netfilter/nfnetlink.h b/include/linux/netfilter/nfnetlink.h
index 791d516e1e88..0518ca72b761 100644
--- a/include/linux/netfilter/nfnetlink.h
+++ b/include/linux/netfilter/nfnetlink.h
@@ -39,7 +39,6 @@ struct nfnetlink_subsystem {
 	int (*commit)(struct net *net, struct sk_buff *skb);
 	int (*abort)(struct net *net, struct sk_buff *skb,
 		     enum nfnl_abort_action action);
-	void (*cleanup)(struct net *net);
 	bool (*valid_genid)(struct net *net, u32 genid);
 };
 
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index fe39ed9e9303..f454dd100334 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -602,6 +602,10 @@ enum {
 	NVME_AER_VS			= 7,
 };
 
+enum {
+	NVME_AER_ERROR_PERSIST_INT_ERR	= 0x03,
+};
+
 enum {
 	NVME_AER_NOTICE_NS_CHANGED	= 0x00,
 	NVME_AER_NOTICE_FW_ACT_STARTING = 0x01,
diff --git a/include/linux/posix-timers.h b/include/linux/posix-timers.h
index 913aa60228b1..8e284161b65e 100644
--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -4,6 +4,7 @@
 
 #include <linux/spinlock.h>
 #include <linux/list.h>
+#include <linux/mutex.h>
 #include <linux/alarmtimer.h>
 #include <linux/timerqueue.h>
 #include <linux/task_work.h>
@@ -63,16 +64,18 @@ static inline int clockid_to_fd(const clockid_t clk)
  * cpu_timer - Posix CPU timer representation for k_itimer
  * @node:	timerqueue node to queue in the task/sig
  * @head:	timerqueue head on which this timer is queued
- * @task:	Pointer to target task
+ * @pid:	Pointer to target task PID
  * @elist:	List head for the expiry list
  * @firing:	Timer is currently firing
+ * @handling:	Pointer to the task which handles expiry
  */
 struct cpu_timer {
-	struct timerqueue_node	node;
-	struct timerqueue_head	*head;
-	struct pid		*pid;
-	struct list_head	elist;
-	int			firing;
+	struct timerqueue_node		node;
+	struct timerqueue_head		*head;
+	struct pid			*pid;
+	struct list_head		elist;
+	int				firing;
+	struct task_struct __rcu	*handling;
 };
 
 static inline bool cpu_timer_enqueue(struct timerqueue_head *head,
@@ -129,10 +132,12 @@ struct posix_cputimers {
 /**
  * posix_cputimers_work - Container for task work based posix CPU timer expiry
  * @work:	The task work to be scheduled
+ * @mutex:	Mutex held around expiry in context of this task work
  * @scheduled:  @work has been scheduled already, no further processing
  */
 struct posix_cputimers_work {
 	struct callback_head	work;
+	struct mutex		mutex;
 	unsigned int		scheduled;
 };
 
diff --git a/include/linux/printk.h b/include/linux/printk.h
index fe7eb2351610..344f6da3d4c3 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -623,4 +623,23 @@ static inline void print_hex_dump_debug(const char *prefix_str, int prefix_type,
 #define print_hex_dump_bytes(prefix_str, prefix_type, buf, len)	\
 	print_hex_dump_debug(prefix_str, prefix_type, 16, 1, buf, len, true)
 
+#ifdef CONFIG_PRINTK
+extern void __printk_safe_enter(void);
+extern void __printk_safe_exit(void);
+/*
+ * The printk_deferred_enter/exit macros are available only as a hack for
+ * some code paths that need to defer all printk console printing. Interrupts
+ * must be disabled for the deferred duration.
+ */
+#define printk_deferred_enter __printk_safe_enter
+#define printk_deferred_exit __printk_safe_exit
+#else
+static inline void printk_deferred_enter(void)
+{
+}
+static inline void printk_deferred_exit(void)
+{
+}
+#endif
+
 #endif
diff --git a/include/linux/sunrpc/sched.h b/include/linux/sunrpc/sched.h
index df696efdd675..256dff36cf72 100644
--- a/include/linux/sunrpc/sched.h
+++ b/include/linux/sunrpc/sched.h
@@ -90,8 +90,7 @@ struct rpc_task {
 #endif
 	unsigned char		tk_priority : 2,/* Task priority */
 				tk_garb_retry : 2,
-				tk_cred_retry : 2,
-				tk_rebind_retry : 2;
+				tk_cred_retry : 2;
 };
 
 typedef void			(*rpc_action)(struct rpc_task *);
diff --git a/include/linux/tick.h b/include/linux/tick.h
index 7340613c7eff..a90a8f7759a2 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -211,6 +211,7 @@ extern void tick_nohz_dep_set_signal(struct signal_struct *signal,
 				     enum tick_dep_bits bit);
 extern void tick_nohz_dep_clear_signal(struct signal_struct *signal,
 				       enum tick_dep_bits bit);
+extern bool tick_nohz_cpu_hotpluggable(unsigned int cpu);
 
 /*
  * The below are tick_nohz_[set,clear]_dep() wrappers that optimize off-cases
@@ -275,6 +276,7 @@ static inline void tick_nohz_full_add_cpus_to(struct cpumask *mask) { }
 
 static inline void tick_nohz_dep_set_cpu(int cpu, enum tick_dep_bits bit) { }
 static inline void tick_nohz_dep_clear_cpu(int cpu, enum tick_dep_bits bit) { }
+static inline bool tick_nohz_cpu_hotpluggable(unsigned int cpu) { return true; }
 
 static inline void tick_dep_set(enum tick_dep_bits bit) { }
 static inline void tick_dep_clear(enum tick_dep_bits bit) { }
diff --git a/include/linux/tty.h b/include/linux/tty.h
index 5972f43b9d5a..e51d75f5165b 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -16,30 +16,6 @@
 #include <linux/llist.h>
 
 
-/*
- * Lock subclasses for tty locks
- *
- * TTY_LOCK_NORMAL is for normal ttys and master ptys.
- * TTY_LOCK_SLAVE is for slave ptys only.
- *
- * Lock subclasses are necessary for handling nested locking with pty pairs.
- * tty locks which use nested locking:
- *
- * legacy_mutex - Nested tty locks are necessary for releasing pty pairs.
- *		  The stable lock order is master pty first, then slave pty.
- * termios_rwsem - The stable lock order is tty_buffer lock->termios_rwsem.
- *		   Subclassing this lock enables the slave pty to hold its
- *		   termios_rwsem when claiming the master tty_buffer lock.
- * tty_buffer lock - slave ptys can claim nested buffer lock when handling
- *		     signal chars. The stable lock order is slave pty, then
- *		     master.
- */
-
-enum {
-	TTY_LOCK_NORMAL = 0,
-	TTY_LOCK_SLAVE,
-};
-
 /*
  * (Note: the *_driver.minor_start values 1, 64, 128, 192 are
  * hardcoded at present.)
@@ -374,21 +350,6 @@ struct tty_file_private {
 #define TTY_LDISC_CHANGING	20	/* Change pending - non-block IO */
 #define TTY_LDISC_HALTED	22	/* Line discipline is halted */
 
-/* Values for tty->flow_change */
-#define TTY_THROTTLE_SAFE 1
-#define TTY_UNTHROTTLE_SAFE 2
-
-static inline void __tty_set_flow_change(struct tty_struct *tty, int val)
-{
-	tty->flow_change = val;
-}
-
-static inline void tty_set_flow_change(struct tty_struct *tty, int val)
-{
-	tty->flow_change = val;
-	smp_mb();
-}
-
 static inline bool tty_io_nonblock(struct tty_struct *tty, struct file *file)
 {
 	return file->f_flags & O_NONBLOCK ||
@@ -419,9 +380,6 @@ extern const char *tty_name(const struct tty_struct *tty);
 extern struct tty_struct *tty_kopen(dev_t device);
 extern void tty_kclose(struct tty_struct *tty);
 extern int tty_dev_name_to_number(const char *name, dev_t *number);
-extern int tty_ldisc_lock(struct tty_struct *tty, unsigned long timeout);
-extern void tty_ldisc_unlock(struct tty_struct *tty);
-extern ssize_t redirected_tty_write(struct kiocb *, struct iov_iter *);
 #else
 static inline void tty_kref_put(struct tty_struct *tty)
 { }
@@ -474,11 +432,7 @@ static inline struct tty_struct *tty_kref_get(struct tty_struct *tty)
 
 extern const char *tty_driver_name(const struct tty_struct *tty);
 extern void tty_wait_until_sent(struct tty_struct *tty, long timeout);
-extern int __tty_check_change(struct tty_struct *tty, int sig);
-extern int tty_check_change(struct tty_struct *tty);
-extern void __stop_tty(struct tty_struct *tty);
 extern void stop_tty(struct tty_struct *tty);
-extern void __start_tty(struct tty_struct *tty);
 extern void start_tty(struct tty_struct *tty);
 extern int tty_register_driver(struct tty_driver *driver);
 extern int tty_unregister_driver(struct tty_driver *driver);
@@ -503,23 +457,11 @@ extern int tty_do_resize(struct tty_struct *tty, struct winsize *ws);
 extern int is_current_pgrp_orphaned(void);
 extern void tty_hangup(struct tty_struct *tty);
 extern void tty_vhangup(struct tty_struct *tty);
-extern void tty_vhangup_session(struct tty_struct *tty);
 extern int tty_hung_up_p(struct file *filp);
 extern void do_SAK(struct tty_struct *tty);
 extern void __do_SAK(struct tty_struct *tty);
-extern void tty_open_proc_set_tty(struct file *filp, struct tty_struct *tty);
-extern int tty_signal_session_leader(struct tty_struct *tty, int exit_session);
-extern void session_clear_tty(struct pid *session);
 extern void no_tty(void);
-extern void tty_buffer_free_all(struct tty_port *port);
-extern void tty_buffer_flush(struct tty_struct *tty, struct tty_ldisc *ld);
-extern void tty_buffer_init(struct tty_port *port);
-extern void tty_buffer_set_lock_subclass(struct tty_port *port);
-extern bool tty_buffer_restart_work(struct tty_port *port);
-extern bool tty_buffer_cancel_work(struct tty_port *port);
-extern void tty_buffer_flush_work(struct tty_port *port);
 extern speed_t tty_termios_baud_rate(struct ktermios *termios);
-extern speed_t tty_termios_input_baud_rate(struct ktermios *termios);
 extern void tty_termios_encode_baud_rate(struct ktermios *termios,
 						speed_t ibaud, speed_t obaud);
 extern void tty_encode_baud_rate(struct tty_struct *tty,
@@ -547,27 +489,16 @@ extern int tty_set_termios(struct tty_struct *tty, struct ktermios *kt);
 extern struct tty_ldisc *tty_ldisc_ref(struct tty_struct *);
 extern void tty_ldisc_deref(struct tty_ldisc *);
 extern struct tty_ldisc *tty_ldisc_ref_wait(struct tty_struct *);
-extern void tty_ldisc_hangup(struct tty_struct *tty, bool reset);
-extern int tty_ldisc_reinit(struct tty_struct *tty, int disc);
 extern const struct seq_operations tty_ldiscs_seq_ops;
 
 extern void tty_wakeup(struct tty_struct *tty);
 extern void tty_ldisc_flush(struct tty_struct *tty);
 
-extern long tty_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
 extern int tty_mode_ioctl(struct tty_struct *tty, struct file *file,
 			unsigned int cmd, unsigned long arg);
-extern long tty_jobctrl_ioctl(struct tty_struct *tty, struct tty_struct *real_tty,
-			      struct file *file, unsigned int cmd, unsigned long arg);
 extern int tty_perform_flush(struct tty_struct *tty, unsigned long arg);
-extern void tty_default_fops(struct file_operations *fops);
-extern struct tty_struct *alloc_tty_struct(struct tty_driver *driver, int idx);
-extern int tty_alloc_file(struct file *file);
-extern void tty_add_file(struct tty_struct *tty, struct file *file);
-extern void tty_free_file(struct file *file);
 extern struct tty_struct *tty_init_dev(struct tty_driver *driver, int idx);
 extern void tty_release_struct(struct tty_struct *tty, int idx);
-extern int tty_release(struct inode *inode, struct file *filp);
 extern void tty_init_termios(struct tty_struct *tty);
 extern void tty_save_termios(struct tty_struct *tty);
 extern int tty_standard_install(struct tty_driver *driver,
@@ -575,8 +506,6 @@ extern int tty_standard_install(struct tty_driver *driver,
 
 extern struct mutex tty_mutex;
 
-#define tty_is_writelocked(tty)  (mutex_is_locked(&tty->atomic_write_lock))
-
 extern void tty_port_init(struct tty_port *port);
 extern void tty_port_link_device(struct tty_port *port,
 		struct tty_driver *driver, unsigned index);
@@ -714,10 +643,6 @@ static inline int tty_port_users(struct tty_port *port)
 extern int tty_register_ldisc(int disc, struct tty_ldisc_ops *new_ldisc);
 extern int tty_unregister_ldisc(int disc);
 extern int tty_set_ldisc(struct tty_struct *tty, int disc);
-extern int tty_ldisc_setup(struct tty_struct *tty, struct tty_struct *o_tty);
-extern void tty_ldisc_release(struct tty_struct *tty);
-extern int __must_check tty_ldisc_init(struct tty_struct *tty);
-extern void tty_ldisc_deinit(struct tty_struct *tty);
 extern int tty_ldisc_receive_buf(struct tty_ldisc *ld, const unsigned char *p,
 				 char *f, int count);
 
@@ -731,20 +656,10 @@ static inline void n_tty_init(void) { }
 
 /* tty_audit.c */
 #ifdef CONFIG_AUDIT
-extern void tty_audit_add_data(struct tty_struct *tty, const void *data,
-			       size_t size);
 extern void tty_audit_exit(void);
 extern void tty_audit_fork(struct signal_struct *sig);
-extern void tty_audit_tiocsti(struct tty_struct *tty, char ch);
 extern int tty_audit_push(void);
 #else
-static inline void tty_audit_add_data(struct tty_struct *tty, const void *data,
-				      size_t size)
-{
-}
-static inline void tty_audit_tiocsti(struct tty_struct *tty, char ch)
-{
-}
 static inline void tty_audit_exit(void)
 {
 }
@@ -786,16 +701,4 @@ static inline void proc_tty_register_driver(struct tty_driver *d) {}
 static inline void proc_tty_unregister_driver(struct tty_driver *d) {}
 #endif
 
-#define tty_msg(fn, tty, f, ...) \
-	fn("%s %s: " f, tty_driver_name(tty), tty_name(tty), ##__VA_ARGS__)
-
-#define tty_debug(tty, f, ...)	tty_msg(pr_debug, tty, f, ##__VA_ARGS__)
-#define tty_info(tty, f, ...)	tty_msg(pr_info, tty, f, ##__VA_ARGS__)
-#define tty_notice(tty, f, ...)	tty_msg(pr_notice, tty, f, ##__VA_ARGS__)
-#define tty_warn(tty, f, ...)	tty_msg(pr_warn, tty, f, ##__VA_ARGS__)
-#define tty_err(tty, f, ...)	tty_msg(pr_err, tty, f, ##__VA_ARGS__)
-
-#define tty_info_ratelimited(tty, f, ...) \
-		tty_msg(pr_info_ratelimited, tty, f, ##__VA_ARGS__)
-
 #endif
diff --git a/include/linux/vt_buffer.h b/include/linux/vt_buffer.h
index 848db1b1569f..919d999a8c1d 100644
--- a/include/linux/vt_buffer.h
+++ b/include/linux/vt_buffer.h
@@ -16,7 +16,7 @@
 
 #include <linux/string.h>
 
-#if defined(CONFIG_VGA_CONSOLE) || defined(CONFIG_MDA_CONSOLE)
+#if IS_ENABLED(CONFIG_VGA_CONSOLE) || IS_ENABLED(CONFIG_MDA_CONSOLE)
 #include <asm/vga.h>
 #endif
 
diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 26de0cae2a0a..2fa9b311e566 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -29,7 +29,7 @@ void delayed_work_timer_fn(struct timer_list *t);
 
 enum {
 	WORK_STRUCT_PENDING_BIT	= 0,	/* work item is pending execution */
-	WORK_STRUCT_DELAYED_BIT	= 1,	/* work item is delayed */
+	WORK_STRUCT_INACTIVE_BIT= 1,	/* work item is inactive */
 	WORK_STRUCT_PWQ_BIT	= 2,	/* data points to pwq */
 	WORK_STRUCT_LINKED_BIT	= 3,	/* next work is linked to this one */
 #ifdef CONFIG_DEBUG_OBJECTS_WORK
@@ -42,7 +42,7 @@ enum {
 	WORK_STRUCT_COLOR_BITS	= 4,
 
 	WORK_STRUCT_PENDING	= 1 << WORK_STRUCT_PENDING_BIT,
-	WORK_STRUCT_DELAYED	= 1 << WORK_STRUCT_DELAYED_BIT,
+	WORK_STRUCT_INACTIVE	= 1 << WORK_STRUCT_INACTIVE_BIT,
 	WORK_STRUCT_PWQ		= 1 << WORK_STRUCT_PWQ_BIT,
 	WORK_STRUCT_LINKED	= 1 << WORK_STRUCT_LINKED_BIT,
 #ifdef CONFIG_DEBUG_OBJECTS_WORK
diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index e66fee99ed3e..564fbe0c865f 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -507,6 +507,7 @@ struct nft_set_binding {
 };
 
 enum nft_trans_phase;
+void nf_tables_activate_set(const struct nft_ctx *ctx, struct nft_set *set);
 void nf_tables_deactivate_set(const struct nft_ctx *ctx, struct nft_set *set,
 			      struct nft_set_binding *binding,
 			      enum nft_trans_phase phase);
diff --git a/include/net/scm.h b/include/net/scm.h
index 1ce365f4c256..585adc1346bd 100644
--- a/include/net/scm.h
+++ b/include/net/scm.h
@@ -105,16 +105,27 @@ static inline void scm_passec(struct socket *sock, struct msghdr *msg, struct sc
 		}
 	}
 }
+
+static inline bool scm_has_secdata(struct socket *sock)
+{
+	return test_bit(SOCK_PASSSEC, &sock->flags);
+}
 #else
 static inline void scm_passec(struct socket *sock, struct msghdr *msg, struct scm_cookie *scm)
 { }
+
+static inline bool scm_has_secdata(struct socket *sock)
+{
+	return false;
+}
 #endif /* CONFIG_SECURITY_NETWORK */
 
 static __inline__ void scm_recv(struct socket *sock, struct msghdr *msg,
 				struct scm_cookie *scm, int flags)
 {
 	if (!msg->msg_control) {
-		if (test_bit(SOCK_PASSCRED, &sock->flags) || scm->fp)
+		if (test_bit(SOCK_PASSCRED, &sock->flags) || scm->fp ||
+		    scm_has_secdata(sock))
 			msg->msg_flags |= MSG_CTRUNC;
 		scm_destroy(scm);
 		return;
diff --git a/include/net/xsk_buff_pool.h b/include/net/xsk_buff_pool.h
index c9a47d3d8f50..5a63e3b12335 100644
--- a/include/net/xsk_buff_pool.h
+++ b/include/net/xsk_buff_pool.h
@@ -150,13 +150,8 @@ static inline bool xp_desc_crosses_non_contig_pg(struct xsk_buff_pool *pool,
 	if (likely(!cross_pg))
 		return false;
 
-	if (pool->dma_pages_cnt) {
-		return !(pool->dma_pages[addr >> PAGE_SHIFT] &
-			 XSK_NEXT_PG_CONTIG_MASK);
-	}
-
-	/* skb path */
-	return addr + len > pool->addrs_cnt;
+	return pool->dma_pages_cnt &&
+	       !(pool->dma_pages[addr >> PAGE_SHIFT] & XSK_NEXT_PG_CONTIG_MASK);
 }
 
 static inline u64 xp_aligned_extract_addr(struct xsk_buff_pool *pool, u64 addr)
diff --git a/include/soc/bcm2835/raspberrypi-firmware.h b/include/soc/bcm2835/raspberrypi-firmware.h
index fdfef7fe40df..73ad784fca96 100644
--- a/include/soc/bcm2835/raspberrypi-firmware.h
+++ b/include/soc/bcm2835/raspberrypi-firmware.h
@@ -142,6 +142,8 @@ int rpi_firmware_property_list(struct rpi_firmware *fw,
 			       void *data, size_t tag_size);
 void rpi_firmware_put(struct rpi_firmware *fw);
 struct rpi_firmware *rpi_firmware_get(struct device_node *firmware_node);
+struct rpi_firmware *devm_rpi_firmware_get(struct device *dev,
+					   struct device_node *firmware_node);
 #else
 static inline int rpi_firmware_property(struct rpi_firmware *fw, u32 tag,
 					void *data, size_t len)
@@ -160,6 +162,12 @@ static inline struct rpi_firmware *rpi_firmware_get(struct device_node *firmware
 {
 	return NULL;
 }
+
+static inline struct rpi_firmware *devm_rpi_firmware_get(struct device *dev,
+					struct device_node *firmware_node)
+{
+	return NULL;
+}
 #endif
 
 #endif /* __SOC_RASPBERRY_FIRMWARE_H__ */
diff --git a/include/target/target_core_base.h b/include/target/target_core_base.h
index 18a5dcd275f8..e681c712fcca 100644
--- a/include/target/target_core_base.h
+++ b/include/target/target_core_base.h
@@ -540,7 +540,11 @@ struct se_cmd {
 	struct scatterlist	*t_prot_sg;
 	unsigned int		t_prot_nents;
 	sense_reason_t		pi_err;
-	sector_t		bad_sector;
+	u64			sense_info;
+	/*
+	 * CPU LIO will execute the cmd on. Defaults to the CPU the cmd is
+	 * initialized on. Drivers can override.
+	 */
 	int			cpuid;
 };
 
@@ -761,6 +765,11 @@ struct se_dev_stat_grps {
 	struct config_group scsi_lu_group;
 };
 
+struct se_device_queue {
+	struct list_head	state_list;
+	spinlock_t		lock;
+};
+
 struct se_device {
 	/* RELATIVE TARGET PORT IDENTIFER Counter */
 	u16			dev_rpti_counter;
@@ -794,7 +803,6 @@ struct se_device {
 	atomic_t		dev_qf_count;
 	u32			export_count;
 	spinlock_t		delayed_cmd_lock;
-	spinlock_t		execute_task_lock;
 	spinlock_t		dev_reservation_lock;
 	unsigned int		dev_reservation_flags;
 #define DRF_SPC2_RESERVATIONS			0x00000001
@@ -814,7 +822,6 @@ struct se_device {
 	struct work_struct	qf_work_queue;
 	struct work_struct	delayed_cmd_work;
 	struct list_head	delayed_cmd_list;
-	struct list_head	state_list;
 	struct list_head	qf_cmd_list;
 	/* Pointer to associated SE HBA */
 	struct se_hba		*se_hba;
@@ -841,6 +848,9 @@ struct se_device {
 	/* For se_lun->lun_se_dev RCU read-side critical access */
 	u32			hba_index;
 	struct rcu_head		rcu_head;
+	int			queue_cnt;
+	struct se_device_queue	*queues;
+	struct mutex		lun_reset_mutex;
 };
 
 struct se_hba {
diff --git a/include/trace/events/qrtr.h b/include/trace/events/qrtr.h
index b1de14c3bb93..441132c67133 100644
--- a/include/trace/events/qrtr.h
+++ b/include/trace/events/qrtr.h
@@ -10,15 +10,16 @@
 
 TRACE_EVENT(qrtr_ns_service_announce_new,
 
-	TP_PROTO(__le32 service, __le32 instance, __le32 node, __le32 port),
+	TP_PROTO(unsigned int service, unsigned int instance,
+		 unsigned int node, unsigned int port),
 
 	TP_ARGS(service, instance, node, port),
 
 	TP_STRUCT__entry(
-		__field(__le32, service)
-		__field(__le32, instance)
-		__field(__le32, node)
-		__field(__le32, port)
+		__field(unsigned int, service)
+		__field(unsigned int, instance)
+		__field(unsigned int, node)
+		__field(unsigned int, port)
 	),
 
 	TP_fast_assign(
@@ -36,15 +37,16 @@ TRACE_EVENT(qrtr_ns_service_announce_new,
 
 TRACE_EVENT(qrtr_ns_service_announce_del,
 
-	TP_PROTO(__le32 service, __le32 instance, __le32 node, __le32 port),
+	TP_PROTO(unsigned int service, unsigned int instance,
+		 unsigned int node, unsigned int port),
 
 	TP_ARGS(service, instance, node, port),
 
 	TP_STRUCT__entry(
-		__field(__le32, service)
-		__field(__le32, instance)
-		__field(__le32, node)
-		__field(__le32, port)
+		__field(unsigned int, service)
+		__field(unsigned int, instance)
+		__field(unsigned int, node)
+		__field(unsigned int, port)
 	),
 
 	TP_fast_assign(
@@ -62,15 +64,16 @@ TRACE_EVENT(qrtr_ns_service_announce_del,
 
 TRACE_EVENT(qrtr_ns_server_add,
 
-	TP_PROTO(__le32 service, __le32 instance, __le32 node, __le32 port),
+	TP_PROTO(unsigned int service, unsigned int instance,
+		 unsigned int node, unsigned int port),
 
 	TP_ARGS(service, instance, node, port),
 
 	TP_STRUCT__entry(
-		__field(__le32, service)
-		__field(__le32, instance)
-		__field(__le32, node)
-		__field(__le32, port)
+		__field(unsigned int, service)
+		__field(unsigned int, instance)
+		__field(unsigned int, node)
+		__field(unsigned int, port)
 	),
 
 	TP_fast_assign(
diff --git a/include/trace/events/timer.h b/include/trace/events/timer.h
index 19abb6c3eb73..40e9b5a12732 100644
--- a/include/trace/events/timer.h
+++ b/include/trace/events/timer.h
@@ -368,7 +368,8 @@ TRACE_EVENT(itimer_expire,
 		tick_dep_name(PERF_EVENTS)		\
 		tick_dep_name(SCHED)			\
 		tick_dep_name(CLOCK_UNSTABLE)		\
-		tick_dep_name_end(RCU)
+		tick_dep_name(RCU)			\
+		tick_dep_name_end(RCU_EXP)
 
 #undef tick_dep_name
 #undef tick_dep_mask_name
diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index 2c39d15a2beb..e65300d63d7c 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -181,6 +181,7 @@ struct btrfs_scrub_progress {
 };
 
 #define BTRFS_SCRUB_READONLY	1
+#define BTRFS_SCRUB_SUPPORTED_FLAGS	(BTRFS_SCRUB_READONLY)
 struct btrfs_ioctl_scrub_args {
 	__u64 devid;				/* in */
 	__u64 start;				/* in */
diff --git a/include/uapi/linux/const.h b/include/uapi/linux/const.h
index af2a44c08683..a429381e7ca5 100644
--- a/include/uapi/linux/const.h
+++ b/include/uapi/linux/const.h
@@ -28,7 +28,7 @@
 #define _BITUL(x)	(_UL(1) << (x))
 #define _BITULL(x)	(_ULL(1) << (x))
 
-#define __ALIGN_KERNEL(x, a)		__ALIGN_KERNEL_MASK(x, (typeof(x))(a) - 1)
+#define __ALIGN_KERNEL(x, a)		__ALIGN_KERNEL_MASK(x, (__typeof__(x))(a) - 1)
 #define __ALIGN_KERNEL_MASK(x, mask)	(((x) + (mask)) & ~(mask))
 
 #define __KERNEL_DIV_ROUND_UP(n, d) (((n) + (d) - 1) / (d))
diff --git a/include/xen/xen.h b/include/xen/xen.h
index 43efba045acc..5a6a2ab675be 100644
--- a/include/xen/xen.h
+++ b/include/xen/xen.h
@@ -61,4 +61,15 @@ void xen_free_unpopulated_pages(unsigned int nr_pages, struct page **pages);
 #include <xen/balloon.h>
 #endif
 
+#if defined(CONFIG_XEN_DOM0) && defined(CONFIG_ACPI) && defined(CONFIG_X86)
+bool __init xen_processor_present(uint32_t acpi_id);
+#else
+#include <linux/bug.h>
+static inline bool xen_processor_present(uint32_t acpi_id)
+{
+	BUG();
+	return false;
+}
+#endif
+
 #endif	/* _XEN_XEN_H */
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 6d92e393e1bc..d3593a520bb7 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -1516,7 +1516,7 @@ int __cgroup_bpf_run_filter_getsockopt(struct sock *sk, int level,
 		goto out;
 	}
 
-	if (ctx.optlen > max_optlen || ctx.optlen < 0) {
+	if (optval && (ctx.optlen > max_optlen || ctx.optlen < 0)) {
 		ret = -EFAULT;
 		goto out;
 	}
@@ -1530,8 +1530,11 @@ int __cgroup_bpf_run_filter_getsockopt(struct sock *sk, int level,
 	}
 
 	if (ctx.optlen != 0) {
-		if (copy_to_user(optval, ctx.optval, ctx.optlen) ||
-		    put_user(ctx.optlen, optlen)) {
+		if (optval && copy_to_user(optval, ctx.optval, ctx.optlen)) {
+			ret = -EFAULT;
+			goto out;
+		}
+		if (put_user(ctx.optlen, optlen)) {
 			ret = -EFAULT;
 			goto out;
 		}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5a96a9dd51e4..6876796a8de0 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2775,17 +2775,13 @@ static int check_stack_read(struct bpf_verifier_env *env,
 	}
 	/* Variable offset is prohibited for unprivileged mode for simplicity
 	 * since it requires corresponding support in Spectre masking for stack
-	 * ALU. See also retrieve_ptr_limit().
+	 * ALU. See also retrieve_ptr_limit(). The check in
+	 * check_stack_access_for_ptr_arithmetic() called by
+	 * adjust_ptr_min_max_vals() prevents users from creating stack pointers
+	 * with variable offsets, therefore no check is required here. Further,
+	 * just checking it here would be insufficient as speculative stack
+	 * writes could still lead to unsafe speculative behaviour.
 	 */
-	if (!env->bypass_spec_v1 && var_off) {
-		char tn_buf[48];
-
-		tnum_strn(tn_buf, sizeof(tn_buf), reg->var_off);
-		verbose(env, "R%d variable offset stack access prohibited for !root, var_off=%s\n",
-				ptr_regno, tn_buf);
-		return -EACCES;
-	}
-
 	if (!var_off) {
 		off += reg->var_off.value;
 		err = check_stack_read_fixed_off(env, state, off, size,
@@ -9550,10 +9546,11 @@ static int propagate_precision(struct bpf_verifier_env *env,
 		state_reg = state->regs;
 		for (i = 0; i < BPF_REG_FP; i++, state_reg++) {
 			if (state_reg->type != SCALAR_VALUE ||
-			    !state_reg->precise)
+			    !state_reg->precise ||
+			    !(state_reg->live & REG_LIVE_READ))
 				continue;
 			if (env->log.level & BPF_LOG_LEVEL2)
-				verbose(env, "frame %d: propagating r%d\n", i, fr);
+				verbose(env, "frame %d: propagating r%d\n", fr, i);
 			err = mark_chain_precision_frame(env, fr, i);
 			if (err < 0)
 				return err;
@@ -9564,11 +9561,12 @@ static int propagate_precision(struct bpf_verifier_env *env,
 				continue;
 			state_reg = &state->stack[i].spilled_ptr;
 			if (state_reg->type != SCALAR_VALUE ||
-			    !state_reg->precise)
+			    !state_reg->precise ||
+			    !(state_reg->live & REG_LIVE_READ))
 				continue;
 			if (env->log.level & BPF_LOG_LEVEL2)
 				verbose(env, "frame %d: propagating fp%d\n",
-					(-i - 1) * BPF_REG_SIZE, fr);
+					fr, (-i - 1) * BPF_REG_SIZE);
 			err = mark_chain_precision_stack_frame(env, fr, i);
 			if (err < 0)
 				return err;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index f0df3bc0e641..53f36bbaf0c6 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -8925,8 +8925,8 @@ __perf_event_account_interrupt(struct perf_event *event, int throttle)
 		hwc->interrupts = 1;
 	} else {
 		hwc->interrupts++;
-		if (unlikely(throttle
-			     && hwc->interrupts >= max_samples_per_tick)) {
+		if (unlikely(throttle &&
+			     hwc->interrupts > max_samples_per_tick)) {
 			__this_cpu_inc(perf_throttled_count);
 			tick_dep_set_cpu(smp_processor_id(), TICK_DEP_BIT_PERF_EVENTS);
 			hwc->interrupts = MAX_INTERRUPTS;
diff --git a/kernel/fork.c b/kernel/fork.c
index a5bc0c6a00fd..c6a289317e89 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -441,6 +441,9 @@ void put_task_stack(struct task_struct *tsk)
 
 void free_task(struct task_struct *tsk)
 {
+#ifdef CONFIG_SECCOMP
+	WARN_ON_ONCE(tsk->seccomp.filter);
+#endif
 	scs_release(tsk);
 
 #ifndef CONFIG_THREAD_INFO_IN_TASK
@@ -2248,12 +2251,6 @@ static __latent_entropy struct task_struct *copy_process(
 
 	spin_lock(&current->sighand->siglock);
 
-	/*
-	 * Copy seccomp details explicitly here, in case they were changed
-	 * before holding sighand lock.
-	 */
-	copy_seccomp(p);
-
 	rseq_fork(p, clone_flags);
 
 	/* Don't start children in a dying pid namespace */
@@ -2268,6 +2265,14 @@ static __latent_entropy struct task_struct *copy_process(
 		goto bad_fork_cancel_cgroup;
 	}
 
+	/* No more failure paths after this point. */
+
+	/*
+	 * Copy seccomp details explicitly here, in case they were changed
+	 * before holding sighand lock.
+	 */
+	copy_seccomp(p);
+
 	init_task_pid_links(p);
 	if (likely(p->pid)) {
 		ptrace_init_task(p, (clone_flags & CLONE_PTRACE) || trace);
diff --git a/kernel/kheaders.c b/kernel/kheaders.c
index 8f69772af77b..42163c9e94e5 100644
--- a/kernel/kheaders.c
+++ b/kernel/kheaders.c
@@ -26,15 +26,15 @@ asm (
 "	.popsection				\n"
 );
 
-extern char kernel_headers_data;
-extern char kernel_headers_data_end;
+extern char kernel_headers_data[];
+extern char kernel_headers_data_end[];
 
 static ssize_t
 ikheaders_read(struct file *file,  struct kobject *kobj,
 	       struct bin_attribute *bin_attr,
 	       char *buf, loff_t off, size_t len)
 {
-	memcpy(buf, &kernel_headers_data + off, len);
+	memcpy(buf, &kernel_headers_data[off], len);
 	return len;
 }
 
@@ -48,8 +48,8 @@ static struct bin_attribute kheaders_attr __ro_after_init = {
 
 static int __init ikheaders_init(void)
 {
-	kheaders_attr.size = (&kernel_headers_data_end -
-			      &kernel_headers_data);
+	kheaders_attr.size = (kernel_headers_data_end -
+			      kernel_headers_data);
 	return sysfs_create_bin_file(kernel_kobj, &kheaders_attr);
 }
 
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 9cce4e13af41..30e1d7fedb5f 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -964,6 +964,7 @@ void __rcu_irq_enter_check_tick(void)
 	}
 	raw_spin_unlock_rcu_node(rdp->mynode);
 }
+NOKPROBE_SYMBOL(__rcu_irq_enter_check_tick);
 #endif /* CONFIG_NO_HZ_FULL */
 
 /**
diff --git a/kernel/relay.c b/kernel/relay.c
index 067769b80d4a..f6826dec2103 100644
--- a/kernel/relay.c
+++ b/kernel/relay.c
@@ -1077,7 +1077,8 @@ static size_t relay_file_read_start_pos(struct rchan_buf *buf)
 	size_t subbuf_size = buf->chan->subbuf_size;
 	size_t n_subbufs = buf->chan->n_subbufs;
 	size_t consumed = buf->subbufs_consumed % n_subbufs;
-	size_t read_pos = consumed * subbuf_size + buf->bytes_consumed;
+	size_t read_pos = (consumed * subbuf_size + buf->bytes_consumed)
+			% (n_subbufs * subbuf_size);
 
 	read_subbuf = read_pos / subbuf_size;
 	padding = buf->padding[read_subbuf];
diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 5d76edd0ad9c..bede1e608d95 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -782,6 +782,8 @@ static u64 collect_timerqueue(struct timerqueue_head *head,
 			return expires;
 
 		ctmr->firing = 1;
+		/* See posix_cpu_timer_wait_running() */
+		rcu_assign_pointer(ctmr->handling, current);
 		cpu_timer_dequeue(ctmr);
 		list_add_tail(&ctmr->elist, firing);
 	}
@@ -1097,7 +1099,49 @@ static void handle_posix_cpu_timers(struct task_struct *tsk);
 #ifdef CONFIG_POSIX_CPU_TIMERS_TASK_WORK
 static void posix_cpu_timers_work(struct callback_head *work)
 {
+	struct posix_cputimers_work *cw = container_of(work, typeof(*cw), work);
+
+	mutex_lock(&cw->mutex);
 	handle_posix_cpu_timers(current);
+	mutex_unlock(&cw->mutex);
+}
+
+/*
+ * Invoked from the posix-timer core when a cancel operation failed because
+ * the timer is marked firing. The caller holds rcu_read_lock(), which
+ * protects the timer and the task which is expiring it from being freed.
+ */
+static void posix_cpu_timer_wait_running(struct k_itimer *timr)
+{
+	struct task_struct *tsk = rcu_dereference(timr->it.cpu.handling);
+
+	/* Has the handling task completed expiry already? */
+	if (!tsk)
+		return;
+
+	/* Ensure that the task cannot go away */
+	get_task_struct(tsk);
+	/* Now drop the RCU protection so the mutex can be locked */
+	rcu_read_unlock();
+	/* Wait on the expiry mutex */
+	mutex_lock(&tsk->posix_cputimers_work.mutex);
+	/* Release it immediately again. */
+	mutex_unlock(&tsk->posix_cputimers_work.mutex);
+	/* Drop the task reference. */
+	put_task_struct(tsk);
+	/* Relock RCU so the callsite is balanced */
+	rcu_read_lock();
+}
+
+static void posix_cpu_timer_wait_running_nsleep(struct k_itimer *timr)
+{
+	/* Ensure that timr->it.cpu.handling task cannot go away */
+	rcu_read_lock();
+	spin_unlock_irq(&timr->it_lock);
+	posix_cpu_timer_wait_running(timr);
+	rcu_read_unlock();
+	/* @timr is on stack and is valid */
+	spin_lock_irq(&timr->it_lock);
 }
 
 /*
@@ -1113,6 +1157,7 @@ void clear_posix_cputimers_work(struct task_struct *p)
 	       sizeof(p->posix_cputimers_work.work));
 	init_task_work(&p->posix_cputimers_work.work,
 		       posix_cpu_timers_work);
+	mutex_init(&p->posix_cputimers_work.mutex);
 	p->posix_cputimers_work.scheduled = false;
 }
 
@@ -1191,6 +1236,18 @@ static inline void __run_posix_cpu_timers(struct task_struct *tsk)
 	lockdep_posixtimer_exit();
 }
 
+static void posix_cpu_timer_wait_running(struct k_itimer *timr)
+{
+	cpu_relax();
+}
+
+static void posix_cpu_timer_wait_running_nsleep(struct k_itimer *timr)
+{
+	spin_unlock_irq(&timr->it_lock);
+	cpu_relax();
+	spin_lock_irq(&timr->it_lock);
+}
+
 static inline bool posix_cpu_timers_work_scheduled(struct task_struct *tsk)
 {
 	return false;
@@ -1299,6 +1356,8 @@ static void handle_posix_cpu_timers(struct task_struct *tsk)
 		 */
 		if (likely(cpu_firing >= 0))
 			cpu_timer_fire(timer);
+		/* See posix_cpu_timer_wait_running() */
+		rcu_assign_pointer(timer->it.cpu.handling, NULL);
 		spin_unlock(&timer->it_lock);
 	}
 }
@@ -1434,23 +1493,16 @@ static int do_cpu_nanosleep(const clockid_t which_clock, int flags,
 		expires = cpu_timer_getexpires(&timer.it.cpu);
 		error = posix_cpu_timer_set(&timer, 0, &zero_it, &it);
 		if (!error) {
-			/*
-			 * Timer is now unarmed, deletion can not fail.
-			 */
+			/* Timer is now unarmed, deletion can not fail. */
 			posix_cpu_timer_del(&timer);
+		} else {
+			while (error == TIMER_RETRY) {
+				posix_cpu_timer_wait_running_nsleep(&timer);
+				error = posix_cpu_timer_del(&timer);
+			}
 		}
-		spin_unlock_irq(&timer.it_lock);
 
-		while (error == TIMER_RETRY) {
-			/*
-			 * We need to handle case when timer was or is in the
-			 * middle of firing. In other cases we already freed
-			 * resources.
-			 */
-			spin_lock_irq(&timer.it_lock);
-			error = posix_cpu_timer_del(&timer);
-			spin_unlock_irq(&timer.it_lock);
-		}
+		spin_unlock_irq(&timer.it_lock);
 
 		if ((it.it_value.tv_sec | it.it_value.tv_nsec) == 0) {
 			/*
@@ -1560,6 +1612,7 @@ const struct k_clock clock_posix_cpu = {
 	.timer_del		= posix_cpu_timer_del,
 	.timer_get		= posix_cpu_timer_get,
 	.timer_rearm		= posix_cpu_timer_rearm,
+	.timer_wait_running	= posix_cpu_timer_wait_running,
 };
 
 const struct k_clock clock_process = {
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 724ca7eb1a6e..d089627f2f2b 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -846,6 +846,10 @@ static struct k_itimer *timer_wait_running(struct k_itimer *timer,
 	rcu_read_lock();
 	unlock_timer(timer, *flags);
 
+	/*
+	 * kc->timer_wait_running() might drop RCU lock. So @timer
+	 * cannot be touched anymore after the function returns!
+	 */
 	if (!WARN_ON_ONCE(!kc->timer_wait_running))
 		kc->timer_wait_running(timer);
 
diff --git a/kernel/time/tick-broadcast.c b/kernel/time/tick-broadcast.c
index 36d7464c8962..a9530e866e5f 100644
--- a/kernel/time/tick-broadcast.c
+++ b/kernel/time/tick-broadcast.c
@@ -331,7 +331,7 @@ static void tick_handle_periodic_broadcast(struct clock_event_device *dev)
 	bc_local = tick_do_periodic_broadcast();
 
 	if (clockevent_state_oneshot(dev)) {
-		ktime_t next = ktime_add(dev->next_event, tick_period);
+		ktime_t next = ktime_add_ns(dev->next_event, TICK_NSEC);
 
 		clockevents_program_event(dev, next, true);
 	}
diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
index 6c9c342dd0e5..2b7448ae5b47 100644
--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -30,7 +30,6 @@ DEFINE_PER_CPU(struct tick_device, tick_cpu_device);
  * Tick next event: keeps track of the tick time
  */
 ktime_t tick_next_period;
-ktime_t tick_period;
 
 /*
  * tick_do_timer_cpu is a timer core internal variable which holds the CPU NR
@@ -88,7 +87,7 @@ static void tick_periodic(int cpu)
 		write_seqcount_begin(&jiffies_seq);
 
 		/* Keep track of the next tick event */
-		tick_next_period = ktime_add(tick_next_period, tick_period);
+		tick_next_period = ktime_add_ns(tick_next_period, TICK_NSEC);
 
 		do_timer(1);
 		write_seqcount_end(&jiffies_seq);
@@ -127,7 +126,7 @@ void tick_handle_periodic(struct clock_event_device *dev)
 		 * Setup the next period for devices, which do not have
 		 * periodic mode:
 		 */
-		next = ktime_add(next, tick_period);
+		next = ktime_add_ns(next, TICK_NSEC);
 
 		if (!clockevents_program_event(dev, next, false))
 			return;
@@ -173,7 +172,7 @@ void tick_setup_periodic(struct clock_event_device *dev, int broadcast)
 		for (;;) {
 			if (!clockevents_program_event(dev, next, false))
 				return;
-			next = ktime_add(next, tick_period);
+			next = ktime_add_ns(next, TICK_NSEC);
 		}
 	}
 }
@@ -217,10 +216,19 @@ static void tick_setup_device(struct tick_device *td,
 		 * this cpu:
 		 */
 		if (tick_do_timer_cpu == TICK_DO_TIMER_BOOT) {
+			ktime_t next_p;
+			u32 rem;
+
 			tick_do_timer_cpu = cpu;
 
-			tick_next_period = ktime_get();
-			tick_period = NSEC_PER_SEC / HZ;
+			next_p = ktime_get();
+			div_u64_rem(next_p, TICK_NSEC, &rem);
+			if (rem) {
+				next_p -= rem;
+				next_p += TICK_NSEC;
+			}
+
+			tick_next_period = next_p;
 #ifdef CONFIG_NO_HZ_FULL
 			/*
 			 * The boot CPU may be nohz_full, in which case set
diff --git a/kernel/time/tick-internal.h b/kernel/time/tick-internal.h
index 5294f5b1f955..e61c1244e7d4 100644
--- a/kernel/time/tick-internal.h
+++ b/kernel/time/tick-internal.h
@@ -15,7 +15,6 @@
 
 DECLARE_PER_CPU(struct tick_device, tick_cpu_device);
 extern ktime_t tick_next_period;
-extern ktime_t tick_period;
 extern int tick_do_timer_cpu __read_mostly;
 
 extern void tick_setup_periodic(struct clock_event_device *dev, int broadcast);
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 92fb738813f3..17dc3f53efef 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -53,49 +53,67 @@ static ktime_t last_jiffies_update;
  */
 static void tick_do_update_jiffies64(ktime_t now)
 {
-	unsigned long ticks = 0;
+	unsigned long ticks = 1;
 	ktime_t delta;
 
 	/*
-	 * Do a quick check without holding jiffies_lock:
-	 * The READ_ONCE() pairs with two updates done later in this function.
+	 * Do a quick check without holding jiffies_lock. The READ_ONCE()
+	 * pairs with the update done later in this function.
+	 *
+	 * This is also an intentional data race which is even safe on
+	 * 32bit in theory. If there is a concurrent update then the check
+	 * might give a random answer. It does not matter because if it
+	 * returns then the concurrent update is already taking care, if it
+	 * falls through then it will pointlessly contend on jiffies_lock.
+	 *
+	 * Though there is one nasty case on 32bit due to store tearing of
+	 * the 64bit value. If the first 32bit store makes the quick check
+	 * return on all other CPUs and the writing CPU context gets
+	 * delayed to complete the second store (scheduled out on virt)
+	 * then jiffies can become stale for up to ~2^32 nanoseconds
+	 * without noticing. After that point all CPUs will wait for
+	 * jiffies lock.
+	 *
+	 * OTOH, this is not any different than the situation with NOHZ=off
+	 * where one CPU is responsible for updating jiffies and
+	 * timekeeping. If that CPU goes out for lunch then all other CPUs
+	 * will operate on stale jiffies until it decides to come back.
 	 */
-	delta = ktime_sub(now, READ_ONCE(last_jiffies_update));
-	if (delta < tick_period)
+	if (ktime_before(now, READ_ONCE(tick_next_period)))
 		return;
 
 	/* Reevaluate with jiffies_lock held */
 	raw_spin_lock(&jiffies_lock);
+	if (ktime_before(now, tick_next_period)) {
+		raw_spin_unlock(&jiffies_lock);
+		return;
+	}
+
 	write_seqcount_begin(&jiffies_seq);
 
-	delta = ktime_sub(now, last_jiffies_update);
-	if (delta >= tick_period) {
+	delta = ktime_sub(now, tick_next_period);
+	if (unlikely(delta >= TICK_NSEC)) {
+		/* Slow path for long idle sleep times */
+		s64 incr = TICK_NSEC;
 
-		delta = ktime_sub(delta, tick_period);
-		/* Pairs with the lockless read in this function. */
-		WRITE_ONCE(last_jiffies_update,
-			   ktime_add(last_jiffies_update, tick_period));
+		ticks += ktime_divns(delta, incr);
 
-		/* Slow path for long timeouts */
-		if (unlikely(delta >= tick_period)) {
-			s64 incr = ktime_to_ns(tick_period);
+		last_jiffies_update = ktime_add_ns(last_jiffies_update,
+						   incr * ticks);
+	} else {
+		last_jiffies_update = ktime_add_ns(last_jiffies_update,
+						   TICK_NSEC);
+	}
 
-			ticks = ktime_divns(delta, incr);
+	do_timer(ticks);
 
-			/* Pairs with the lockless read in this function. */
-			WRITE_ONCE(last_jiffies_update,
-				   ktime_add_ns(last_jiffies_update,
-						incr * ticks));
-		}
-		do_timer(++ticks);
+	/*
+	 * Keep the tick_next_period variable up to date.  WRITE_ONCE()
+	 * pairs with the READ_ONCE() in the lockless quick check above.
+	 */
+	WRITE_ONCE(tick_next_period,
+		   ktime_add_ns(last_jiffies_update, TICK_NSEC));
 
-		/* Keep the tick_next_period variable up to date */
-		tick_next_period = ktime_add(last_jiffies_update, tick_period);
-	} else {
-		write_seqcount_end(&jiffies_seq);
-		raw_spin_unlock(&jiffies_lock);
-		return;
-	}
 	write_seqcount_end(&jiffies_seq);
 	raw_spin_unlock(&jiffies_lock);
 	update_wall_time();
@@ -213,6 +231,11 @@ static bool check_tick_dependency(atomic_t *dep)
 		return true;
 	}
 
+	if (val & TICK_DEP_MASK_RCU_EXP) {
+		trace_tick_stop(0, TICK_DEP_MASK_RCU_EXP);
+		return true;
+	}
+
 	return false;
 }
 
@@ -426,7 +449,7 @@ void __init tick_nohz_full_setup(cpumask_var_t cpumask)
 	tick_nohz_full_running = true;
 }
 
-static int tick_nohz_cpu_down(unsigned int cpu)
+bool tick_nohz_cpu_hotpluggable(unsigned int cpu)
 {
 	/*
 	 * The tick_do_timer_cpu CPU handles housekeeping duty (unbound
@@ -434,8 +457,13 @@ static int tick_nohz_cpu_down(unsigned int cpu)
 	 * CPUs. It must remain online when nohz full is enabled.
 	 */
 	if (tick_nohz_full_running && tick_do_timer_cpu == cpu)
-		return -EBUSY;
-	return 0;
+		return false;
+	return true;
+}
+
+static int tick_nohz_cpu_down(unsigned int cpu)
+{
+	return tick_nohz_cpu_hotpluggable(cpu) ? 0 : -EBUSY;
 }
 
 void __init tick_nohz_init(void)
@@ -660,7 +688,7 @@ static void tick_nohz_restart(struct tick_sched *ts, ktime_t now)
 	hrtimer_set_expires(&ts->sched_timer, ts->last_tick);
 
 	/* Forward the time to expire in the future */
-	hrtimer_forward(&ts->sched_timer, now, tick_period);
+	hrtimer_forward(&ts->sched_timer, now, TICK_NSEC);
 
 	if (ts->nohz_mode == NOHZ_MODE_HIGHRES) {
 		hrtimer_start_expires(&ts->sched_timer,
@@ -1222,7 +1250,7 @@ static void tick_nohz_handler(struct clock_event_device *dev)
 	if (unlikely(ts->tick_stopped))
 		return;
 
-	hrtimer_forward(&ts->sched_timer, now, tick_period);
+	hrtimer_forward(&ts->sched_timer, now, TICK_NSEC);
 	tick_program_event(hrtimer_get_expires(&ts->sched_timer), 1);
 }
 
@@ -1259,7 +1287,7 @@ static void tick_nohz_switch_to_nohz(void)
 	next = tick_init_jiffy_update();
 
 	hrtimer_set_expires(&ts->sched_timer, next);
-	hrtimer_forward_now(&ts->sched_timer, tick_period);
+	hrtimer_forward_now(&ts->sched_timer, TICK_NSEC);
 	tick_program_event(hrtimer_get_expires(&ts->sched_timer), 1);
 	tick_nohz_activate(ts, NOHZ_MODE_LOWRES);
 }
@@ -1325,7 +1353,7 @@ static enum hrtimer_restart tick_sched_timer(struct hrtimer *timer)
 	if (unlikely(ts->tick_stopped))
 		return HRTIMER_NORESTART;
 
-	hrtimer_forward(timer, now, tick_period);
+	hrtimer_forward(timer, now, TICK_NSEC);
 
 	return HRTIMER_RESTART;
 }
@@ -1359,13 +1387,13 @@ void tick_setup_sched_timer(void)
 
 	/* Offset the tick to avert jiffies_lock contention. */
 	if (sched_skew_tick) {
-		u64 offset = ktime_to_ns(tick_period) >> 1;
+		u64 offset = TICK_NSEC >> 1;
 		do_div(offset, num_possible_cpus());
 		offset *= smp_processor_id();
 		hrtimer_add_expires_ns(&ts->sched_timer, offset);
 	}
 
-	hrtimer_forward(&ts->sched_timer, now, tick_period);
+	hrtimer_forward(&ts->sched_timer, now, TICK_NSEC);
 	hrtimer_start_expires(&ts->sched_timer, HRTIMER_MODE_ABS_PINNED_HARD);
 	tick_nohz_activate(ts, NOHZ_MODE_HIGHRES);
 }
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 21b07c7c6ee5..f08904914166 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1644,6 +1644,8 @@ static void rb_free_cpu_buffer(struct ring_buffer_per_cpu *cpu_buffer)
 	struct list_head *head = cpu_buffer->pages;
 	struct buffer_page *bpage, *tmp;
 
+	irq_work_sync(&cpu_buffer->irq_work.work);
+
 	free_buffer_page(cpu_buffer->reader_page);
 
 	if (head) {
@@ -1750,6 +1752,8 @@ ring_buffer_free(struct trace_buffer *buffer)
 
 	cpuhp_state_remove_instance(CPUHP_TRACE_RB_PREPARE, &buffer->node);
 
+	irq_work_sync(&buffer->irq_work.work);
+
 	for_each_buffer_cpu(buffer, cpu)
 		rb_free_cpu_buffer(buffer->buffers[cpu]);
 
@@ -5047,6 +5051,9 @@ void ring_buffer_reset_cpu(struct trace_buffer *buffer, int cpu)
 }
 EXPORT_SYMBOL_GPL(ring_buffer_reset_cpu);
 
+/* Flag to ensure proper resetting of atomic variables */
+#define RESET_BIT	(1 << 30)
+
 /**
  * ring_buffer_reset_cpu - reset a ring buffer per CPU buffer
  * @buffer: The ring buffer to reset a per cpu buffer of
@@ -5063,20 +5070,27 @@ void ring_buffer_reset_online_cpus(struct trace_buffer *buffer)
 	for_each_online_buffer_cpu(buffer, cpu) {
 		cpu_buffer = buffer->buffers[cpu];
 
-		atomic_inc(&cpu_buffer->resize_disabled);
+		atomic_add(RESET_BIT, &cpu_buffer->resize_disabled);
 		atomic_inc(&cpu_buffer->record_disabled);
 	}
 
 	/* Make sure all commits have finished */
 	synchronize_rcu();
 
-	for_each_online_buffer_cpu(buffer, cpu) {
+	for_each_buffer_cpu(buffer, cpu) {
 		cpu_buffer = buffer->buffers[cpu];
 
+		/*
+		 * If a CPU came online during the synchronize_rcu(), then
+		 * ignore it.
+		 */
+		if (!(atomic_read(&cpu_buffer->resize_disabled) & RESET_BIT))
+			continue;
+
 		reset_disabled_cpu_buffer(cpu_buffer);
 
 		atomic_dec(&cpu_buffer->record_disabled);
-		atomic_dec(&cpu_buffer->resize_disabled);
+		atomic_sub(RESET_BIT, &cpu_buffer->resize_disabled);
 	}
 
 	mutex_unlock(&buffer->mutex);
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 0cc2a62e88f9..b9041ab881bc 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -207,7 +207,7 @@ struct pool_workqueue {
 						/* L: nr of in_flight works */
 	int			nr_active;	/* L: nr of active works */
 	int			max_active;	/* L: max active works */
-	struct list_head	delayed_works;	/* L: delayed works */
+	struct list_head	inactive_works;	/* L: inactive works */
 	struct list_head	pwqs_node;	/* WR: node on wq->pwqs */
 	struct list_head	mayday_node;	/* MD: node on wq->maydays */
 
@@ -1145,7 +1145,7 @@ static void put_pwq_unlocked(struct pool_workqueue *pwq)
 	}
 }
 
-static void pwq_activate_delayed_work(struct work_struct *work)
+static void pwq_activate_inactive_work(struct work_struct *work)
 {
 	struct pool_workqueue *pwq = get_work_pwq(work);
 
@@ -1153,16 +1153,16 @@ static void pwq_activate_delayed_work(struct work_struct *work)
 	if (list_empty(&pwq->pool->worklist))
 		pwq->pool->watchdog_ts = jiffies;
 	move_linked_works(work, &pwq->pool->worklist, NULL);
-	__clear_bit(WORK_STRUCT_DELAYED_BIT, work_data_bits(work));
+	__clear_bit(WORK_STRUCT_INACTIVE_BIT, work_data_bits(work));
 	pwq->nr_active++;
 }
 
-static void pwq_activate_first_delayed(struct pool_workqueue *pwq)
+static void pwq_activate_first_inactive(struct pool_workqueue *pwq)
 {
-	struct work_struct *work = list_first_entry(&pwq->delayed_works,
+	struct work_struct *work = list_first_entry(&pwq->inactive_works,
 						    struct work_struct, entry);
 
-	pwq_activate_delayed_work(work);
+	pwq_activate_inactive_work(work);
 }
 
 /**
@@ -1185,10 +1185,10 @@ static void pwq_dec_nr_in_flight(struct pool_workqueue *pwq, int color)
 	pwq->nr_in_flight[color]--;
 
 	pwq->nr_active--;
-	if (!list_empty(&pwq->delayed_works)) {
-		/* one down, submit a delayed one */
+	if (!list_empty(&pwq->inactive_works)) {
+		/* one down, submit an inactive one */
 		if (pwq->nr_active < pwq->max_active)
-			pwq_activate_first_delayed(pwq);
+			pwq_activate_first_inactive(pwq);
 	}
 
 	/* is flush in progress and are we at the flushing tip? */
@@ -1290,14 +1290,14 @@ static int try_to_grab_pending(struct work_struct *work, bool is_dwork,
 		debug_work_deactivate(work);
 
 		/*
-		 * A delayed work item cannot be grabbed directly because
+		 * An inactive work item cannot be grabbed directly because
 		 * it might have linked NO_COLOR work items which, if left
-		 * on the delayed_list, will confuse pwq->nr_active
+		 * on the inactive_works list, will confuse pwq->nr_active
 		 * management later on and cause stall.  Make sure the work
 		 * item is activated before grabbing.
 		 */
-		if (*work_data_bits(work) & WORK_STRUCT_DELAYED)
-			pwq_activate_delayed_work(work);
+		if (*work_data_bits(work) & WORK_STRUCT_INACTIVE)
+			pwq_activate_inactive_work(work);
 
 		list_del_init(&work->entry);
 		pwq_dec_nr_in_flight(pwq, get_work_color(work));
@@ -1496,8 +1496,8 @@ static void __queue_work(int cpu, struct workqueue_struct *wq,
 		if (list_empty(worklist))
 			pwq->pool->watchdog_ts = jiffies;
 	} else {
-		work_flags |= WORK_STRUCT_DELAYED;
-		worklist = &pwq->delayed_works;
+		work_flags |= WORK_STRUCT_INACTIVE;
+		worklist = &pwq->inactive_works;
 	}
 
 	debug_work_activate(work);
@@ -2534,7 +2534,7 @@ static int rescuer_thread(void *__rescuer)
 			/*
 			 * The above execution of rescued work items could
 			 * have created more to rescue through
-			 * pwq_activate_first_delayed() or chained
+			 * pwq_activate_first_inactive() or chained
 			 * queueing.  Let's put @pwq back on mayday list so
 			 * that such back-to-back work items, which may be
 			 * being used to relieve memory pressure, don't
@@ -2960,7 +2960,7 @@ void drain_workqueue(struct workqueue_struct *wq)
 		bool drained;
 
 		raw_spin_lock_irq(&pwq->pool->lock);
-		drained = !pwq->nr_active && list_empty(&pwq->delayed_works);
+		drained = !pwq->nr_active && list_empty(&pwq->inactive_works);
 		raw_spin_unlock_irq(&pwq->pool->lock);
 
 		if (drained)
@@ -3714,7 +3714,7 @@ static void pwq_unbound_release_workfn(struct work_struct *work)
  * @pwq: target pool_workqueue
  *
  * If @pwq isn't freezing, set @pwq->max_active to the associated
- * workqueue's saved_max_active and activate delayed work items
+ * workqueue's saved_max_active and activate inactive work items
  * accordingly.  If @pwq is freezing, clear @pwq->max_active to zero.
  */
 static void pwq_adjust_max_active(struct pool_workqueue *pwq)
@@ -3743,9 +3743,9 @@ static void pwq_adjust_max_active(struct pool_workqueue *pwq)
 
 		pwq->max_active = wq->saved_max_active;
 
-		while (!list_empty(&pwq->delayed_works) &&
+		while (!list_empty(&pwq->inactive_works) &&
 		       pwq->nr_active < pwq->max_active) {
-			pwq_activate_first_delayed(pwq);
+			pwq_activate_first_inactive(pwq);
 			kick = true;
 		}
 
@@ -3776,7 +3776,7 @@ static void init_pwq(struct pool_workqueue *pwq, struct workqueue_struct *wq,
 	pwq->wq = wq;
 	pwq->flush_color = -1;
 	pwq->refcnt = 1;
-	INIT_LIST_HEAD(&pwq->delayed_works);
+	INIT_LIST_HEAD(&pwq->inactive_works);
 	INIT_LIST_HEAD(&pwq->pwqs_node);
 	INIT_LIST_HEAD(&pwq->mayday_node);
 	INIT_WORK(&pwq->unbound_release_work, pwq_unbound_release_workfn);
@@ -4363,7 +4363,7 @@ static bool pwq_busy(struct pool_workqueue *pwq)
 
 	if ((pwq != pwq->wq->dfl_pwq) && (pwq->refcnt > 1))
 		return true;
-	if (pwq->nr_active || !list_empty(&pwq->delayed_works))
+	if (pwq->nr_active || !list_empty(&pwq->inactive_works))
 		return true;
 
 	return false;
@@ -4559,7 +4559,7 @@ bool workqueue_congested(int cpu, struct workqueue_struct *wq)
 	else
 		pwq = unbound_pwq_by_node(wq, cpu_to_node(cpu));
 
-	ret = !list_empty(&pwq->delayed_works);
+	ret = !list_empty(&pwq->inactive_works);
 	preempt_enable();
 	rcu_read_unlock();
 
@@ -4755,11 +4755,11 @@ static void show_pwq(struct pool_workqueue *pwq)
 		pr_cont("\n");
 	}
 
-	if (!list_empty(&pwq->delayed_works)) {
+	if (!list_empty(&pwq->inactive_works)) {
 		bool comma = false;
 
-		pr_info("    delayed:");
-		list_for_each_entry(work, &pwq->delayed_works, entry) {
+		pr_info("    inactive:");
+		list_for_each_entry(work, &pwq->inactive_works, entry) {
 			pr_cont_work(comma, work);
 			comma = !(*work_data_bits(work) & WORK_STRUCT_LINKED);
 		}
@@ -4789,7 +4789,7 @@ void show_workqueue_state(void)
 		bool idle = true;
 
 		for_each_pwq(pwq, wq) {
-			if (pwq->nr_active || !list_empty(&pwq->delayed_works)) {
+			if (pwq->nr_active || !list_empty(&pwq->inactive_works)) {
 				idle = false;
 				break;
 			}
@@ -4801,7 +4801,7 @@ void show_workqueue_state(void)
 
 		for_each_pwq(pwq, wq) {
 			raw_spin_lock_irqsave(&pwq->pool->lock, flags);
-			if (pwq->nr_active || !list_empty(&pwq->delayed_works))
+			if (pwq->nr_active || !list_empty(&pwq->inactive_works))
 				show_pwq(pwq);
 			raw_spin_unlock_irqrestore(&pwq->pool->lock, flags);
 			/*
@@ -4816,16 +4816,19 @@ void show_workqueue_state(void)
 	for_each_pool(pool, pi) {
 		struct worker *worker;
 		bool first = true;
+		unsigned long hung = 0;
 
 		raw_spin_lock_irqsave(&pool->lock, flags);
 		if (pool->nr_workers == pool->nr_idle)
 			goto next_pool;
 
+		/* How long the first pending work is waiting for a worker. */
+		if (!list_empty(&pool->worklist))
+			hung = jiffies_to_msecs(jiffies - pool->watchdog_ts) / 1000;
+
 		pr_info("pool %d:", pool->id);
 		pr_cont_pool_info(pool);
-		pr_cont(" hung=%us workers=%d",
-			jiffies_to_msecs(jiffies - pool->watchdog_ts) / 1000,
-			pool->nr_workers);
+		pr_cont(" hung=%lus workers=%d", hung, pool->nr_workers);
 		if (pool->manager)
 			pr_cont(" manager: %d",
 				task_pid_nr(pool->manager->task));
@@ -5176,7 +5179,7 @@ EXPORT_SYMBOL_GPL(work_on_cpu_safe);
  * freeze_workqueues_begin - begin freezing workqueues
  *
  * Start freezing workqueues.  After this function returns, all freezable
- * workqueues will queue new works to their delayed_works list instead of
+ * workqueues will queue new works to their inactive_works list instead of
  * pool->worklist.
  *
  * CONTEXT:
diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 71bdc167a9ee..824337ec36aa 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -219,10 +219,6 @@ static struct debug_obj *__alloc_object(struct hlist_head *list)
 	return obj;
 }
 
-/*
- * Allocate a new object. If the pool is empty, switch off the debugger.
- * Must be called with interrupts disabled.
- */
 static struct debug_obj *
 alloc_object(void *addr, struct debug_bucket *b, const struct debug_obj_descr *descr)
 {
@@ -555,31 +551,74 @@ static void debug_object_is_on_stack(void *addr, int onstack)
 	WARN_ON(1);
 }
 
+static struct debug_obj *lookup_object_or_alloc(void *addr, struct debug_bucket *b,
+						const struct debug_obj_descr *descr,
+						bool onstack, bool alloc_ifstatic)
+{
+	struct debug_obj *obj = lookup_object(addr, b);
+	enum debug_obj_state state = ODEBUG_STATE_NONE;
+
+	if (likely(obj))
+		return obj;
+
+	/*
+	 * debug_object_init() unconditionally allocates untracked
+	 * objects. It does not matter whether it is a static object or
+	 * not.
+	 *
+	 * debug_object_assert_init() and debug_object_activate() allow
+	 * allocation only if the descriptor callback confirms that the
+	 * object is static and considered initialized. For non-static
+	 * objects the allocation needs to be done from the fixup callback.
+	 */
+	if (unlikely(alloc_ifstatic)) {
+		if (!descr->is_static_object || !descr->is_static_object(addr))
+			return ERR_PTR(-ENOENT);
+		/* Statically allocated objects are considered initialized */
+		state = ODEBUG_STATE_INIT;
+	}
+
+	obj = alloc_object(addr, b, descr);
+	if (likely(obj)) {
+		obj->state = state;
+		debug_object_is_on_stack(addr, onstack);
+		return obj;
+	}
+
+	/* Out of memory. Do the cleanup outside of the locked region */
+	debug_objects_enabled = 0;
+	return NULL;
+}
+
+static void debug_objects_fill_pool(void)
+{
+	/*
+	 * On RT enabled kernels the pool refill must happen in preemptible
+	 * context:
+	 */
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || preemptible())
+		fill_pool();
+}
+
 static void
 __debug_object_init(void *addr, const struct debug_obj_descr *descr, int onstack)
 {
 	enum debug_obj_state state;
-	bool check_stack = false;
 	struct debug_bucket *db;
 	struct debug_obj *obj;
 	unsigned long flags;
 
-	fill_pool();
+	debug_objects_fill_pool();
 
 	db = get_bucket((unsigned long) addr);
 
 	raw_spin_lock_irqsave(&db->lock, flags);
 
-	obj = lookup_object(addr, db);
-	if (!obj) {
-		obj = alloc_object(addr, db, descr);
-		if (!obj) {
-			debug_objects_enabled = 0;
-			raw_spin_unlock_irqrestore(&db->lock, flags);
-			debug_objects_oom();
-			return;
-		}
-		check_stack = true;
+	obj = lookup_object_or_alloc(addr, db, descr, onstack, false);
+	if (unlikely(!obj)) {
+		raw_spin_unlock_irqrestore(&db->lock, flags);
+		debug_objects_oom();
+		return;
 	}
 
 	switch (obj->state) {
@@ -605,8 +644,6 @@ __debug_object_init(void *addr, const struct debug_obj_descr *descr, int onstack
 	}
 
 	raw_spin_unlock_irqrestore(&db->lock, flags);
-	if (check_stack)
-		debug_object_is_on_stack(addr, onstack);
 }
 
 /**
@@ -646,24 +683,24 @@ EXPORT_SYMBOL_GPL(debug_object_init_on_stack);
  */
 int debug_object_activate(void *addr, const struct debug_obj_descr *descr)
 {
+	struct debug_obj o = { .object = addr, .state = ODEBUG_STATE_NOTAVAILABLE, .descr = descr };
 	enum debug_obj_state state;
 	struct debug_bucket *db;
 	struct debug_obj *obj;
 	unsigned long flags;
 	int ret;
-	struct debug_obj o = { .object = addr,
-			       .state = ODEBUG_STATE_NOTAVAILABLE,
-			       .descr = descr };
 
 	if (!debug_objects_enabled)
 		return 0;
 
+	debug_objects_fill_pool();
+
 	db = get_bucket((unsigned long) addr);
 
 	raw_spin_lock_irqsave(&db->lock, flags);
 
-	obj = lookup_object(addr, db);
-	if (obj) {
+	obj = lookup_object_or_alloc(addr, db, descr, false, true);
+	if (likely(!IS_ERR_OR_NULL(obj))) {
 		bool print_object = false;
 
 		switch (obj->state) {
@@ -696,24 +733,16 @@ int debug_object_activate(void *addr, const struct debug_obj_descr *descr)
 
 	raw_spin_unlock_irqrestore(&db->lock, flags);
 
-	/*
-	 * We are here when a static object is activated. We
-	 * let the type specific code confirm whether this is
-	 * true or not. if true, we just make sure that the
-	 * static object is tracked in the object tracker. If
-	 * not, this must be a bug, so we try to fix it up.
-	 */
-	if (descr->is_static_object && descr->is_static_object(addr)) {
-		/* track this static object */
-		debug_object_init(addr, descr);
-		debug_object_activate(addr, descr);
-	} else {
-		debug_print_object(&o, "activate");
-		ret = debug_object_fixup(descr->fixup_activate, addr,
-					ODEBUG_STATE_NOTAVAILABLE);
-		return ret ? 0 : -EINVAL;
+	/* If NULL the allocation has hit OOM */
+	if (!obj) {
+		debug_objects_oom();
+		return 0;
 	}
-	return 0;
+
+	/* Object is neither static nor tracked. It's not initialized */
+	debug_print_object(&o, "activate");
+	ret = debug_object_fixup(descr->fixup_activate, addr, ODEBUG_STATE_NOTAVAILABLE);
+	return ret ? 0 : -EINVAL;
 }
 EXPORT_SYMBOL_GPL(debug_object_activate);
 
@@ -867,6 +896,7 @@ EXPORT_SYMBOL_GPL(debug_object_free);
  */
 void debug_object_assert_init(void *addr, const struct debug_obj_descr *descr)
 {
+	struct debug_obj o = { .object = addr, .state = ODEBUG_STATE_NOTAVAILABLE, .descr = descr };
 	struct debug_bucket *db;
 	struct debug_obj *obj;
 	unsigned long flags;
@@ -874,34 +904,25 @@ void debug_object_assert_init(void *addr, const struct debug_obj_descr *descr)
 	if (!debug_objects_enabled)
 		return;
 
+	debug_objects_fill_pool();
+
 	db = get_bucket((unsigned long) addr);
 
 	raw_spin_lock_irqsave(&db->lock, flags);
+	obj = lookup_object_or_alloc(addr, db, descr, false, true);
+	raw_spin_unlock_irqrestore(&db->lock, flags);
+	if (likely(!IS_ERR_OR_NULL(obj)))
+		return;
 
-	obj = lookup_object(addr, db);
+	/* If NULL the allocation has hit OOM */
 	if (!obj) {
-		struct debug_obj o = { .object = addr,
-				       .state = ODEBUG_STATE_NOTAVAILABLE,
-				       .descr = descr };
-
-		raw_spin_unlock_irqrestore(&db->lock, flags);
-		/*
-		 * Maybe the object is static, and we let the type specific
-		 * code confirm. Track this static object if true, else invoke
-		 * fixup.
-		 */
-		if (descr->is_static_object && descr->is_static_object(addr)) {
-			/* Track this static object */
-			debug_object_init(addr, descr);
-		} else {
-			debug_print_object(&o, "assert_init");
-			debug_object_fixup(descr->fixup_assert_init, addr,
-					   ODEBUG_STATE_NOTAVAILABLE);
-		}
+		debug_objects_oom();
 		return;
 	}
 
-	raw_spin_unlock_irqrestore(&db->lock, flags);
+	/* Object is neither tracked nor static. It's not initialized. */
+	debug_print_object(&o, "assert_init");
+	debug_object_fixup(descr->fixup_assert_init, addr, ODEBUG_STATE_NOTAVAILABLE);
 }
 EXPORT_SYMBOL_GPL(debug_object_assert_init);
 
diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index ca770a783a9f..b28f629c3527 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -378,6 +378,15 @@ static void wb_exit(struct bdi_writeback *wb)
 static DEFINE_SPINLOCK(cgwb_lock);
 static struct workqueue_struct *cgwb_release_wq;
 
+static void cgwb_free_rcu(struct rcu_head *rcu_head)
+{
+	struct bdi_writeback *wb = container_of(rcu_head,
+			struct bdi_writeback, rcu);
+
+	percpu_ref_exit(&wb->refcnt);
+	kfree(wb);
+}
+
 static void cgwb_release_workfn(struct work_struct *work)
 {
 	struct bdi_writeback *wb = container_of(work, struct bdi_writeback,
@@ -397,7 +406,7 @@ static void cgwb_release_workfn(struct work_struct *work)
 	fprop_local_destroy_percpu(&wb->memcg_completions);
 	percpu_ref_exit(&wb->refcnt);
 	wb_exit(wb);
-	kfree_rcu(wb, rcu);
+	call_rcu(&wb->rcu, cgwb_free_rcu);
 }
 
 static void cgwb_release(struct percpu_ref *refcnt)
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 1fd41b91a1a8..d85435db35f3 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5973,7 +5973,21 @@ static void __build_all_zonelists(void *data)
 	int nid;
 	int __maybe_unused cpu;
 	pg_data_t *self = data;
+	unsigned long flags;
 
+	/*
+	 * Explicitly disable this CPU's interrupts before taking seqlock
+	 * to prevent any IRQ handler from calling into the page allocator
+	 * (e.g. GFP_ATOMIC) that could hit zonelist_iter_begin and livelock.
+	 */
+	local_irq_save(flags);
+	/*
+	 * Explicitly disable this CPU's synchronous printk() before taking
+	 * seqlock to prevent any printk() from trying to hold port->lock, for
+	 * tty_insert_flip_string_and_push_buffer() on other CPU might be
+	 * calling kmalloc(GFP_ATOMIC | __GFP_NOWARN) with port->lock held.
+	 */
+	printk_deferred_enter();
 	write_seqlock(&zonelist_update_seq);
 
 #ifdef CONFIG_NUMA
@@ -6008,6 +6022,8 @@ static void __build_all_zonelists(void *data)
 	}
 
 	write_sequnlock(&zonelist_update_seq);
+	printk_deferred_exit();
+	local_irq_restore(flags);
 }
 
 static noinline void __init
diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
index 86a1c99025ea..929f85c6cf11 100644
--- a/net/8021q/vlan_dev.c
+++ b/net/8021q/vlan_dev.c
@@ -365,7 +365,7 @@ static int vlan_dev_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 
 	switch (cmd) {
 	case SIOCSHWTSTAMP:
-		if (!net_eq(dev_net(dev), &init_net))
+		if (!net_eq(dev_net(dev), dev_net(real_dev)))
 			break;
 		fallthrough;
 	case SIOCGMIIPHY:
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 73779af2fed6..4dcc1a8a8954 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -996,7 +996,14 @@ static int hci_sock_ioctl(struct socket *sock, unsigned int cmd,
 	if (hci_sock_gen_cookie(sk)) {
 		struct sk_buff *skb;
 
-		if (capable(CAP_NET_ADMIN))
+		/* Perform careful checks before setting the HCI_SOCK_TRUSTED
+		 * flag. Make sure that not only the current task but also
+		 * the socket opener has the required capability, since
+		 * privileged programs can be tricked into making ioctl calls
+		 * on HCI sockets, and the socket should not be marked as
+		 * trusted simply because the ioctl caller is privileged.
+		 */
+		if (sk_capable(sk, CAP_NET_ADMIN))
 			hci_sock_set_flag(sk, HCI_SOCK_TRUSTED);
 
 		/* Send event to monitor */
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 09cdefe5e1c8..fb6b3f2ae192 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -4750,6 +4750,9 @@ void __skb_tstamp_tx(struct sk_buff *orig_skb,
 			skb = alloc_skb(0, GFP_ATOMIC);
 	} else {
 		skb = skb_clone(orig_skb, GFP_ATOMIC);
+
+		if (skb_orphan_frags_rx(skb, GFP_ATOMIC))
+			return;
 	}
 	if (!skb)
 		return;
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 0dbf950de832..1e07df282177 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -1564,9 +1564,19 @@ struct sk_buff *__ip_make_skb(struct sock *sk,
 	cork->dst = NULL;
 	skb_dst_set(skb, &rt->dst);
 
-	if (iph->protocol == IPPROTO_ICMP)
-		icmp_out_count(net, ((struct icmphdr *)
-			skb_transport_header(skb))->type);
+	if (iph->protocol == IPPROTO_ICMP) {
+		u8 icmp_type;
+
+		/* For such sockets, transhdrlen is zero when do ip_append_data(),
+		 * so icmphdr does not in skb linear region and can not get icmp_type
+		 * by icmp_hdr(skb)->type.
+		 */
+		if (sk->sk_type == SOCK_RAW && !inet_sk(sk)->hdrincl)
+			icmp_type = fl4->fl4_icmp_type;
+		else
+			icmp_type = icmp_hdr(skb)->type;
+		icmp_out_count(net, icmp_type);
+	}
 
 	ip_cork_release(cork);
 out:
diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
index 1ce486a9bc07..9806bd56b95f 100644
--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -1094,12 +1094,13 @@ static netdev_tx_t sit_tunnel_xmit(struct sk_buff *skb,
 
 static void ipip6_tunnel_bind_dev(struct net_device *dev)
 {
+	struct ip_tunnel *tunnel = netdev_priv(dev);
+	int t_hlen = tunnel->hlen + sizeof(struct iphdr);
 	struct net_device *tdev = NULL;
-	struct ip_tunnel *tunnel;
+	int hlen = LL_MAX_HEADER;
 	const struct iphdr *iph;
 	struct flowi4 fl4;
 
-	tunnel = netdev_priv(dev);
 	iph = &tunnel->parms.iph;
 
 	if (iph->daddr) {
@@ -1122,14 +1123,15 @@ static void ipip6_tunnel_bind_dev(struct net_device *dev)
 		tdev = __dev_get_by_index(tunnel->net, tunnel->parms.link);
 
 	if (tdev && !netif_is_l3_master(tdev)) {
-		int t_hlen = tunnel->hlen + sizeof(struct iphdr);
 		int mtu;
 
 		mtu = tdev->mtu - t_hlen;
 		if (mtu < IPV6_MIN_MTU)
 			mtu = IPV6_MIN_MTU;
 		WRITE_ONCE(dev->mtu, mtu);
+		hlen = tdev->hard_header_len + tdev->needed_headroom;
 	}
+	dev->needed_headroom = t_hlen + hlen;
 }
 
 static void ipip6_tunnel_update(struct ip_tunnel *t, struct ip_tunnel_parm *p,
diff --git a/net/ncsi/ncsi-aen.c b/net/ncsi/ncsi-aen.c
index b635c194f0a8..62fb1031763d 100644
--- a/net/ncsi/ncsi-aen.c
+++ b/net/ncsi/ncsi-aen.c
@@ -165,6 +165,7 @@ static int ncsi_aen_handler_cr(struct ncsi_dev_priv *ndp,
 	nc->state = NCSI_CHANNEL_INACTIVE;
 	list_add_tail_rcu(&nc->link, &ndp->channel_queue);
 	spin_unlock_irqrestore(&ndp->lock, flags);
+	nc->modes[NCSI_MODE_TX_ENABLE].enable = 0;
 
 	return ncsi_process_next_channel(ndp);
 }
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 2143edafba77..fe51cedd9cc3 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -4479,12 +4479,24 @@ static void nf_tables_unbind_set(const struct nft_ctx *ctx, struct nft_set *set,
 	}
 }
 
+void nf_tables_activate_set(const struct nft_ctx *ctx, struct nft_set *set)
+{
+	if (nft_set_is_anonymous(set))
+		nft_clear(ctx->net, set);
+
+	set->use++;
+}
+EXPORT_SYMBOL_GPL(nf_tables_activate_set);
+
 void nf_tables_deactivate_set(const struct nft_ctx *ctx, struct nft_set *set,
 			      struct nft_set_binding *binding,
 			      enum nft_trans_phase phase)
 {
 	switch (phase) {
 	case NFT_TRANS_PREPARE:
+		if (nft_set_is_anonymous(set))
+			nft_deactivate_next(ctx->net, set);
+
 		set->use--;
 		return;
 	case NFT_TRANS_ABORT:
@@ -7442,6 +7454,8 @@ static int nf_tables_validate(struct net *net)
 			if (nft_table_validate(net, table) < 0)
 				return -EAGAIN;
 		}
+
+		nft_validate_state_update(net, NFT_VALIDATE_SKIP);
 		break;
 	}
 
@@ -8273,11 +8287,6 @@ static int __nf_tables_abort(struct net *net, enum nfnl_abort_action action)
 	return 0;
 }
 
-static void nf_tables_cleanup(struct net *net)
-{
-	nft_validate_state_update(net, NFT_VALIDATE_SKIP);
-}
-
 static int nf_tables_abort(struct net *net, struct sk_buff *skb,
 			   enum nfnl_abort_action action)
 {
@@ -8309,7 +8318,6 @@ static const struct nfnetlink_subsystem nf_tables_subsys = {
 	.cb		= nf_tables_cb,
 	.commit		= nf_tables_commit,
 	.abort		= nf_tables_abort,
-	.cleanup	= nf_tables_cleanup,
 	.valid_genid	= nf_tables_valid_genid,
 	.owner		= THIS_MODULE,
 };
diff --git a/net/netfilter/nfnetlink.c b/net/netfilter/nfnetlink.c
index d3df66a39b5e..edf386a020b9 100644
--- a/net/netfilter/nfnetlink.c
+++ b/net/netfilter/nfnetlink.c
@@ -530,8 +530,6 @@ static void nfnetlink_rcv_batch(struct sk_buff *skb, struct nlmsghdr *nlh,
 			goto replay_abort;
 		}
 	}
-	if (ss->cleanup)
-		ss->cleanup(net);
 
 	nfnl_err_deliver(&err_list, oskb);
 	kfree_skb(skb);
diff --git a/net/netfilter/nft_dynset.c b/net/netfilter/nft_dynset.c
index 8c45e01fecdd..038588d4d80e 100644
--- a/net/netfilter/nft_dynset.c
+++ b/net/netfilter/nft_dynset.c
@@ -233,7 +233,7 @@ static void nft_dynset_activate(const struct nft_ctx *ctx,
 {
 	struct nft_dynset *priv = nft_expr_priv(expr);
 
-	priv->set->use++;
+	nf_tables_activate_set(ctx, priv->set);
 }
 
 static void nft_dynset_destroy(const struct nft_ctx *ctx,
diff --git a/net/netfilter/nft_lookup.c b/net/netfilter/nft_lookup.c
index b0f558b4fea5..8bc008ff00cb 100644
--- a/net/netfilter/nft_lookup.c
+++ b/net/netfilter/nft_lookup.c
@@ -132,7 +132,7 @@ static void nft_lookup_activate(const struct nft_ctx *ctx,
 {
 	struct nft_lookup *priv = nft_expr_priv(expr);
 
-	priv->set->use++;
+	nf_tables_activate_set(ctx, priv->set);
 }
 
 static void nft_lookup_destroy(const struct nft_ctx *ctx,
diff --git a/net/netfilter/nft_objref.c b/net/netfilter/nft_objref.c
index bc104d36d3bb..25157d8cc250 100644
--- a/net/netfilter/nft_objref.c
+++ b/net/netfilter/nft_objref.c
@@ -180,7 +180,7 @@ static void nft_objref_map_activate(const struct nft_ctx *ctx,
 {
 	struct nft_objref_map *priv = nft_expr_priv(expr);
 
-	priv->set->use++;
+	nf_tables_activate_set(ctx, priv->set);
 }
 
 static void nft_objref_map_destroy(const struct nft_ctx *ctx,
diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 2104fbdd63d2..eedb16517f16 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -1744,7 +1744,8 @@ static int netlink_getsockopt(struct socket *sock, int level, int optname,
 {
 	struct sock *sk = sock->sk;
 	struct netlink_sock *nlk = nlk_sk(sk);
-	int len, val, err;
+	unsigned int flag;
+	int len, val;
 
 	if (level != SOL_NETLINK)
 		return -ENOPROTOOPT;
@@ -1756,39 +1757,17 @@ static int netlink_getsockopt(struct socket *sock, int level, int optname,
 
 	switch (optname) {
 	case NETLINK_PKTINFO:
-		if (len < sizeof(int))
-			return -EINVAL;
-		len = sizeof(int);
-		val = nlk->flags & NETLINK_F_RECV_PKTINFO ? 1 : 0;
-		if (put_user(len, optlen) ||
-		    put_user(val, optval))
-			return -EFAULT;
-		err = 0;
+		flag = NETLINK_F_RECV_PKTINFO;
 		break;
 	case NETLINK_BROADCAST_ERROR:
-		if (len < sizeof(int))
-			return -EINVAL;
-		len = sizeof(int);
-		val = nlk->flags & NETLINK_F_BROADCAST_SEND_ERROR ? 1 : 0;
-		if (put_user(len, optlen) ||
-		    put_user(val, optval))
-			return -EFAULT;
-		err = 0;
+		flag = NETLINK_F_BROADCAST_SEND_ERROR;
 		break;
 	case NETLINK_NO_ENOBUFS:
-		if (len < sizeof(int))
-			return -EINVAL;
-		len = sizeof(int);
-		val = nlk->flags & NETLINK_F_RECV_NO_ENOBUFS ? 1 : 0;
-		if (put_user(len, optlen) ||
-		    put_user(val, optval))
-			return -EFAULT;
-		err = 0;
+		flag = NETLINK_F_RECV_NO_ENOBUFS;
 		break;
 	case NETLINK_LIST_MEMBERSHIPS: {
-		int pos, idx, shift;
+		int pos, idx, shift, err = 0;
 
-		err = 0;
 		netlink_lock_table();
 		for (pos = 0; pos * 8 < nlk->ngroups; pos += sizeof(u32)) {
 			if (len - pos < sizeof(u32))
@@ -1805,40 +1784,32 @@ static int netlink_getsockopt(struct socket *sock, int level, int optname,
 		if (put_user(ALIGN(nlk->ngroups / 8, sizeof(u32)), optlen))
 			err = -EFAULT;
 		netlink_unlock_table();
-		break;
+		return err;
 	}
 	case NETLINK_CAP_ACK:
-		if (len < sizeof(int))
-			return -EINVAL;
-		len = sizeof(int);
-		val = nlk->flags & NETLINK_F_CAP_ACK ? 1 : 0;
-		if (put_user(len, optlen) ||
-		    put_user(val, optval))
-			return -EFAULT;
-		err = 0;
+		flag = NETLINK_F_CAP_ACK;
 		break;
 	case NETLINK_EXT_ACK:
-		if (len < sizeof(int))
-			return -EINVAL;
-		len = sizeof(int);
-		val = nlk->flags & NETLINK_F_EXT_ACK ? 1 : 0;
-		if (put_user(len, optlen) || put_user(val, optval))
-			return -EFAULT;
-		err = 0;
+		flag = NETLINK_F_EXT_ACK;
 		break;
 	case NETLINK_GET_STRICT_CHK:
-		if (len < sizeof(int))
-			return -EINVAL;
-		len = sizeof(int);
-		val = nlk->flags & NETLINK_F_STRICT_CHK ? 1 : 0;
-		if (put_user(len, optlen) || put_user(val, optval))
-			return -EFAULT;
-		err = 0;
+		flag = NETLINK_F_STRICT_CHK;
 		break;
 	default:
-		err = -ENOPROTOOPT;
+		return -ENOPROTOOPT;
 	}
-	return err;
+
+	if (len < sizeof(int))
+		return -EINVAL;
+
+	len = sizeof(int);
+	val = nlk->flags & flag ? 1 : 0;
+
+	if (put_user(len, optlen) ||
+	    copy_to_user(optval, &val, len))
+		return -EFAULT;
+
+	return 0;
 }
 
 static void netlink_cmsg_recv_pktinfo(struct msghdr *msg, struct sk_buff *skb)
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 3716797c5564..2e766490a739 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -269,7 +269,8 @@ static void packet_cached_dev_reset(struct packet_sock *po)
 
 static bool packet_use_direct_xmit(const struct packet_sock *po)
 {
-	return po->xmit == packet_direct_xmit;
+	/* Paired with WRITE_ONCE() in packet_setsockopt() */
+	return READ_ONCE(po->xmit) == packet_direct_xmit;
 }
 
 static u16 packet_pick_tx_queue(struct sk_buff *skb)
@@ -1995,7 +1996,7 @@ static int packet_sendmsg_spkt(struct socket *sock, struct msghdr *msg,
 		goto retry;
 	}
 
-	if (!dev_validate_header(dev, skb->data, len)) {
+	if (!dev_validate_header(dev, skb->data, len) || !skb->len) {
 		err = -EINVAL;
 		goto out_unlock;
 	}
@@ -2145,7 +2146,7 @@ static int packet_rcv(struct sk_buff *skb, struct net_device *dev,
 	sll = &PACKET_SKB_CB(skb)->sa.ll;
 	sll->sll_hatype = dev->type;
 	sll->sll_pkttype = skb->pkt_type;
-	if (unlikely(po->origdev))
+	if (unlikely(packet_sock_flag(po, PACKET_SOCK_ORIGDEV)))
 		sll->sll_ifindex = orig_dev->ifindex;
 	else
 		sll->sll_ifindex = dev->ifindex;
@@ -2418,7 +2419,7 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
 	sll->sll_hatype = dev->type;
 	sll->sll_protocol = skb->protocol;
 	sll->sll_pkttype = skb->pkt_type;
-	if (unlikely(po->origdev))
+	if (unlikely(packet_sock_flag(po, PACKET_SOCK_ORIGDEV)))
 		sll->sll_ifindex = orig_dev->ifindex;
 	else
 		sll->sll_ifindex = dev->ifindex;
@@ -2825,7 +2826,8 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
 		packet_inc_pending(&po->tx_ring);
 
 		status = TP_STATUS_SEND_REQUEST;
-		err = po->xmit(skb);
+		/* Paired with WRITE_ONCE() in packet_setsockopt() */
+		err = READ_ONCE(po->xmit)(skb);
 		if (unlikely(err != 0)) {
 			if (err > 0)
 				err = net_xmit_errno(err);
@@ -3028,7 +3030,8 @@ static int packet_snd(struct socket *sock, struct msghdr *msg, size_t len)
 		virtio_net_hdr_set_proto(skb, &vnet_hdr);
 	}
 
-	err = po->xmit(skb);
+	/* Paired with WRITE_ONCE() in packet_setsockopt() */
+	err = READ_ONCE(po->xmit)(skb);
 	if (unlikely(err != 0)) {
 		if (err > 0)
 			err = net_xmit_errno(err);
@@ -3482,7 +3485,7 @@ static int packet_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 		memcpy(msg->msg_name, &PACKET_SKB_CB(skb)->sa, copy_len);
 	}
 
-	if (pkt_sk(sk)->auxdata) {
+	if (packet_sock_flag(pkt_sk(sk), PACKET_SOCK_AUXDATA)) {
 		struct tpacket_auxdata aux;
 
 		aux.tp_status = TP_STATUS_USER;
@@ -3866,9 +3869,7 @@ packet_setsockopt(struct socket *sock, int level, int optname, sockptr_t optval,
 		if (copy_from_sockptr(&val, optval, sizeof(val)))
 			return -EFAULT;
 
-		lock_sock(sk);
-		po->auxdata = !!val;
-		release_sock(sk);
+		packet_sock_flag_set(po, PACKET_SOCK_AUXDATA, val);
 		return 0;
 	}
 	case PACKET_ORIGDEV:
@@ -3880,9 +3881,7 @@ packet_setsockopt(struct socket *sock, int level, int optname, sockptr_t optval,
 		if (copy_from_sockptr(&val, optval, sizeof(val)))
 			return -EFAULT;
 
-		lock_sock(sk);
-		po->origdev = !!val;
-		release_sock(sk);
+		packet_sock_flag_set(po, PACKET_SOCK_ORIGDEV, val);
 		return 0;
 	}
 	case PACKET_VNET_HDR:
@@ -3979,7 +3978,8 @@ packet_setsockopt(struct socket *sock, int level, int optname, sockptr_t optval,
 		if (copy_from_sockptr(&val, optval, sizeof(val)))
 			return -EFAULT;
 
-		po->xmit = val ? packet_direct_xmit : dev_queue_xmit;
+		/* Paired with all lockless reads of po->xmit */
+		WRITE_ONCE(po->xmit, val ? packet_direct_xmit : dev_queue_xmit);
 		return 0;
 	}
 	default:
@@ -4030,10 +4030,10 @@ static int packet_getsockopt(struct socket *sock, int level, int optname,
 
 		break;
 	case PACKET_AUXDATA:
-		val = po->auxdata;
+		val = packet_sock_flag(po, PACKET_SOCK_AUXDATA);
 		break;
 	case PACKET_ORIGDEV:
-		val = po->origdev;
+		val = packet_sock_flag(po, PACKET_SOCK_ORIGDEV);
 		break;
 	case PACKET_VNET_HDR:
 		val = po->has_vnet_hdr;
diff --git a/net/packet/diag.c b/net/packet/diag.c
index 07812ae5ca07..d704c7bf51b2 100644
--- a/net/packet/diag.c
+++ b/net/packet/diag.c
@@ -23,9 +23,9 @@ static int pdiag_put_info(const struct packet_sock *po, struct sk_buff *nlskb)
 	pinfo.pdi_flags = 0;
 	if (po->running)
 		pinfo.pdi_flags |= PDI_RUNNING;
-	if (po->auxdata)
+	if (packet_sock_flag(po, PACKET_SOCK_AUXDATA))
 		pinfo.pdi_flags |= PDI_AUXDATA;
-	if (po->origdev)
+	if (packet_sock_flag(po, PACKET_SOCK_ORIGDEV))
 		pinfo.pdi_flags |= PDI_ORIGDEV;
 	if (po->has_vnet_hdr)
 		pinfo.pdi_flags |= PDI_VNETHDR;
diff --git a/net/packet/internal.h b/net/packet/internal.h
index 7af1e9179385..3938cb413d5d 100644
--- a/net/packet/internal.h
+++ b/net/packet/internal.h
@@ -116,10 +116,9 @@ struct packet_sock {
 	int			copy_thresh;
 	spinlock_t		bind_lock;
 	struct mutex		pg_vec_lock;
+	unsigned long		flags;
 	unsigned int		running;	/* bind_lock must be held */
-	unsigned int		auxdata:1,	/* writer must hold sock lock */
-				origdev:1,
-				has_vnet_hdr:1,
+	unsigned int		has_vnet_hdr:1, /* writer must hold sock lock */
 				tp_loss:1,
 				tp_tx_has_off:1;
 	int			pressure;
@@ -144,4 +143,25 @@ static struct packet_sock *pkt_sk(struct sock *sk)
 	return (struct packet_sock *)sk;
 }
 
+enum packet_sock_flags {
+	PACKET_SOCK_ORIGDEV,
+	PACKET_SOCK_AUXDATA,
+};
+
+static inline void packet_sock_flag_set(struct packet_sock *po,
+					enum packet_sock_flags flag,
+					bool val)
+{
+	if (val)
+		set_bit(flag, &po->flags);
+	else
+		clear_bit(flag, &po->flags);
+}
+
+static inline bool packet_sock_flag(const struct packet_sock *po,
+				    enum packet_sock_flags flag)
+{
+	return test_bit(flag, &po->flags);
+}
+
 #endif
diff --git a/net/rxrpc/sendmsg.c b/net/rxrpc/sendmsg.c
index a670553159ab..1882fea71903 100644
--- a/net/rxrpc/sendmsg.c
+++ b/net/rxrpc/sendmsg.c
@@ -753,7 +753,7 @@ int rxrpc_do_sendmsg(struct rxrpc_sock *rx, struct msghdr *msg, size_t len)
 		fallthrough;
 	case 1:
 		if (p.call.timeouts.hard > 0) {
-			j = msecs_to_jiffies(p.call.timeouts.hard);
+			j = p.call.timeouts.hard * HZ;
 			now = jiffies;
 			j += now;
 			WRITE_ONCE(call->expect_term_by, j);
diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
index 24d561d8d9c9..25dad1921baf 100644
--- a/net/sched/act_mirred.c
+++ b/net/sched/act_mirred.c
@@ -244,7 +244,7 @@ static int tcf_mirred_act(struct sk_buff *skb, const struct tc_action *a,
 		goto out;
 	}
 
-	if (unlikely(!(dev->flags & IFF_UP))) {
+	if (unlikely(!(dev->flags & IFF_UP)) || !netif_carrier_ok(dev)) {
 		net_notice_ratelimited("tc mirred to Houston: device %s is down\n",
 				       dev->name);
 		goto out;
diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index c410a736301b..53d315ed9430 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -1466,6 +1466,7 @@ static int tcf_block_bind(struct tcf_block *block,
 
 err_unroll:
 	list_for_each_entry_safe(block_cb, next, &bo->cb_list, list) {
+		list_del(&block_cb->driver_list);
 		if (i-- > 0) {
 			list_del(&block_cb->list);
 			tcf_block_playback_offloads(block, block_cb->cb,
diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
index 2fb76fc0cc31..5a1274199fe3 100644
--- a/net/sched/sch_fq.c
+++ b/net/sched/sch_fq.c
@@ -779,13 +779,17 @@ static int fq_resize(struct Qdisc *sch, u32 log)
 	return 0;
 }
 
+static struct netlink_range_validation iq_range = {
+	.max = INT_MAX,
+};
+
 static const struct nla_policy fq_policy[TCA_FQ_MAX + 1] = {
 	[TCA_FQ_UNSPEC]			= { .strict_start_type = TCA_FQ_TIMER_SLACK },
 
 	[TCA_FQ_PLIMIT]			= { .type = NLA_U32 },
 	[TCA_FQ_FLOW_PLIMIT]		= { .type = NLA_U32 },
 	[TCA_FQ_QUANTUM]		= { .type = NLA_U32 },
-	[TCA_FQ_INITIAL_QUANTUM]	= { .type = NLA_U32 },
+	[TCA_FQ_INITIAL_QUANTUM]	= NLA_POLICY_FULL_RANGE(NLA_U32, &iq_range),
 	[TCA_FQ_RATE_ENABLE]		= { .type = NLA_U32 },
 	[TCA_FQ_FLOW_DEFAULT_RATE]	= { .type = NLA_U32 },
 	[TCA_FQ_FLOW_MAX_RATE]		= { .type = NLA_U32 },
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index c6e8bd78e35d..e1ce0f261f0b 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -1967,9 +1967,6 @@ call_bind_status(struct rpc_task *task)
 			status = -EOPNOTSUPP;
 			break;
 		}
-		if (task->tk_rebind_retry == 0)
-			break;
-		task->tk_rebind_retry--;
 		rpc_delay(task, 3*HZ);
 		goto retry_timeout;
 	case -ENOBUFS:
diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
index f0f55fbd1375..a00890962e11 100644
--- a/net/sunrpc/sched.c
+++ b/net/sunrpc/sched.c
@@ -796,7 +796,6 @@ rpc_init_task_statistics(struct rpc_task *task)
 	/* Initialize retry counters */
 	task->tk_garb_retry = 2;
 	task->tk_cred_retry = 2;
-	task->tk_rebind_retry = 2;
 
 	/* starting timestamp */
 	task->tk_start = ktime_get();
diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
index 3c7ce60fe9a5..a76d43787549 100644
--- a/net/xdp/xsk_queue.h
+++ b/net/xdp/xsk_queue.h
@@ -155,6 +155,7 @@ static inline bool xp_unaligned_validate_desc(struct xsk_buff_pool *pool,
 		return false;
 
 	if (base_addr >= pool->addrs_cnt || addr >= pool->addrs_cnt ||
+	    addr + desc->len > pool->addrs_cnt ||
 	    xp_desc_crosses_non_contig_pg(pool, addr, desc->len))
 		return false;
 
diff --git a/scripts/gdb/linux/clk.py b/scripts/gdb/linux/clk.py
index 061aecfa294e..7a01fdc3e844 100644
--- a/scripts/gdb/linux/clk.py
+++ b/scripts/gdb/linux/clk.py
@@ -41,6 +41,8 @@ are cached and potentially out of date"""
             self.show_subtree(child, level + 1)
 
     def invoke(self, arg, from_tty):
+        if utils.gdb_eval_or_none("clk_root_list") is None:
+            raise gdb.GdbError("No clocks registered")
         gdb.write("                                 enable  prepare  protect               \n")
         gdb.write("   clock                          count    count    count        rate   \n")
         gdb.write("------------------------------------------------------------------------\n")
diff --git a/scripts/gdb/linux/genpd.py b/scripts/gdb/linux/genpd.py
index 39cd1abd8559..b53649c0a77a 100644
--- a/scripts/gdb/linux/genpd.py
+++ b/scripts/gdb/linux/genpd.py
@@ -5,7 +5,7 @@
 import gdb
 import sys
 
-from linux.utils import CachedType
+from linux.utils import CachedType, gdb_eval_or_none
 from linux.lists import list_for_each_entry
 
 generic_pm_domain_type = CachedType('struct generic_pm_domain')
@@ -70,6 +70,8 @@ Output is similar to /sys/kernel/debug/pm_genpd/pm_genpd_summary'''
             gdb.write('    %-50s  %s\n' % (kobj_path, rtpm_status_str(dev)))
 
     def invoke(self, arg, from_tty):
+        if gdb_eval_or_none("&gpd_list") is None:
+            raise gdb.GdbError("No power domain(s) registered")
         gdb.write('domain                          status          children\n');
         gdb.write('    /device                                             runtime status\n');
         gdb.write('----------------------------------------------------------------------\n');
diff --git a/scripts/gdb/linux/timerlist.py b/scripts/gdb/linux/timerlist.py
index 071d0dd5a634..51def847f1ef 100644
--- a/scripts/gdb/linux/timerlist.py
+++ b/scripts/gdb/linux/timerlist.py
@@ -73,7 +73,7 @@ def print_cpu(hrtimer_bases, cpu, max_clock_bases):
     ts = cpus.per_cpu(tick_sched_ptr, cpu)
 
     text = "cpu: {}\n".format(cpu)
-    for i in xrange(max_clock_bases):
+    for i in range(max_clock_bases):
         text += " clock {}:\n".format(i)
         text += print_base(cpu_base['clock_base'][i])
 
@@ -158,6 +158,8 @@ def pr_cpumask(mask):
     num_bytes = (nr_cpu_ids + 7) / 8
     buf = utils.read_memoryview(inf, bits, num_bytes).tobytes()
     buf = binascii.b2a_hex(buf)
+    if type(buf) is not str:
+        buf=buf.decode()
 
     chunks = []
     i = num_bytes
diff --git a/scripts/gdb/linux/utils.py b/scripts/gdb/linux/utils.py
index ff7c1799d588..db59f986c7fd 100644
--- a/scripts/gdb/linux/utils.py
+++ b/scripts/gdb/linux/utils.py
@@ -89,7 +89,10 @@ def get_target_endianness():
 
 
 def read_memoryview(inf, start, length):
-    return memoryview(inf.read_memory(start, length))
+    m = inf.read_memory(start, length)
+    if type(m) is memoryview:
+        return m
+    return memoryview(m)
 
 
 def read_u16(buffer, offset):
diff --git a/security/selinux/Makefile b/security/selinux/Makefile
index 4d8e0e8adf0b..ee1ddda96447 100644
--- a/security/selinux/Makefile
+++ b/security/selinux/Makefile
@@ -21,8 +21,8 @@ ccflags-y := -I$(srctree)/security/selinux -I$(srctree)/security/selinux/include
 $(addprefix $(obj)/,$(selinux-y)): $(obj)/flask.h
 
 quiet_cmd_flask = GEN     $(obj)/flask.h $(obj)/av_permissions.h
-      cmd_flask = scripts/selinux/genheaders/genheaders $(obj)/flask.h $(obj)/av_permissions.h
+      cmd_flask = $< $(obj)/flask.h $(obj)/av_permissions.h
 
 targets += flask.h av_permissions.h
-$(obj)/flask.h: $(src)/include/classmap.h FORCE
+$(obj)/flask.h $(obj)/av_permissions.h &: scripts/selinux/genheaders/genheaders FORCE
 	$(call if_changed,flask)
diff --git a/sound/oss/dmasound/dmasound.h b/sound/oss/dmasound/dmasound.h
index c1c52b479da2..ad8ce6a1c25c 100644
--- a/sound/oss/dmasound/dmasound.h
+++ b/sound/oss/dmasound/dmasound.h
@@ -88,11 +88,7 @@ static inline int ioctl_return(int __user *addr, int value)
      */
 
 extern int dmasound_init(void);
-#ifdef MODULE
 extern void dmasound_deinit(void);
-#else
-#define dmasound_deinit()	do { } while (0)
-#endif
 
 /* description of the set-up applies to either hard or soft settings */
 
@@ -114,9 +110,7 @@ typedef struct {
     void *(*dma_alloc)(unsigned int, gfp_t);
     void (*dma_free)(void *, unsigned int);
     int (*irqinit)(void);
-#ifdef MODULE
     void (*irqcleanup)(void);
-#endif
     void (*init)(void);
     void (*silence)(void);
     int (*setFormat)(int);
diff --git a/sound/oss/dmasound/dmasound_core.c b/sound/oss/dmasound/dmasound_core.c
index 38f25e97538f..7454b058dda5 100644
--- a/sound/oss/dmasound/dmasound_core.c
+++ b/sound/oss/dmasound/dmasound_core.c
@@ -206,12 +206,10 @@ module_param(writeBufSize, int, 0);
 
 MODULE_LICENSE("GPL");
 
-#ifdef MODULE
 static int sq_unit = -1;
 static int mixer_unit = -1;
 static int state_unit = -1;
 static int irq_installed;
-#endif /* MODULE */
 
 /* control over who can modify resources shared between play/record */
 static fmode_t shared_resource_owner;
@@ -391,9 +389,6 @@ static const struct file_operations mixer_fops =
 
 static void mixer_init(void)
 {
-#ifndef MODULE
-	int mixer_unit;
-#endif
 	mixer_unit = register_sound_mixer(&mixer_fops, -1);
 	if (mixer_unit < 0)
 		return;
@@ -1176,9 +1171,6 @@ static const struct file_operations sq_fops =
 static int sq_init(void)
 {
 	const struct file_operations *fops = &sq_fops;
-#ifndef MODULE
-	int sq_unit;
-#endif
 
 	sq_unit = register_sound_dsp(fops, -1);
 	if (sq_unit < 0) {
@@ -1380,9 +1372,6 @@ static const struct file_operations state_fops = {
 
 static int state_init(void)
 {
-#ifndef MODULE
-	int state_unit;
-#endif
 	state_unit = register_sound_special(&state_fops, SND_DEV_STATUS);
 	if (state_unit < 0)
 		return state_unit ;
@@ -1400,10 +1389,9 @@ static int state_init(void)
 int dmasound_init(void)
 {
 	int res ;
-#ifdef MODULE
+
 	if (irq_installed)
 		return -EBUSY;
-#endif
 
 	/* Set up sound queue, /dev/audio and /dev/dsp. */
 
@@ -1422,9 +1410,7 @@ int dmasound_init(void)
 		printk(KERN_ERR "DMA sound driver: Interrupt initialization failed\n");
 		return -ENODEV;
 	}
-#ifdef MODULE
 	irq_installed = 1;
-#endif
 
 	printk(KERN_INFO "%s DMA sound driver rev %03d installed\n",
 		dmasound.mach.name, (DMASOUND_CORE_REVISION<<4) +
@@ -1438,8 +1424,6 @@ int dmasound_init(void)
 	return 0;
 }
 
-#ifdef MODULE
-
 void dmasound_deinit(void)
 {
 	if (irq_installed) {
@@ -1458,9 +1442,7 @@ void dmasound_deinit(void)
 		unregister_sound_dsp(sq_unit);
 }
 
-#else /* !MODULE */
-
-static int dmasound_setup(char *str)
+static int __maybe_unused dmasound_setup(char *str)
 {
 	int ints[6], size;
 
@@ -1503,8 +1485,6 @@ static int dmasound_setup(char *str)
 
 __setup("dmasound=", dmasound_setup);
 
-#endif /* !MODULE */
-
     /*
      *  Conversion tables
      */
@@ -1591,9 +1571,7 @@ char dmasound_alaw2dma8[] = {
 
 EXPORT_SYMBOL(dmasound);
 EXPORT_SYMBOL(dmasound_init);
-#ifdef MODULE
 EXPORT_SYMBOL(dmasound_deinit);
-#endif
 EXPORT_SYMBOL(dmasound_write_sq);
 EXPORT_SYMBOL(dmasound_catchRadius);
 #ifdef HAS_8BIT_TABLES
diff --git a/sound/soc/codecs/es8316.c b/sound/soc/codecs/es8316.c
index 609459077f9d..bc3d46617a11 100644
--- a/sound/soc/codecs/es8316.c
+++ b/sound/soc/codecs/es8316.c
@@ -807,15 +807,14 @@ static int es8316_i2c_probe(struct i2c_client *i2c_client,
 	es8316->irq = i2c_client->irq;
 	mutex_init(&es8316->lock);
 
-	ret = devm_request_threaded_irq(dev, es8316->irq, NULL, es8316_irq,
-					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
-					"es8316", es8316);
-	if (ret == 0) {
-		/* Gets re-enabled by es8316_set_jack() */
-		disable_irq(es8316->irq);
-	} else {
-		dev_warn(dev, "Failed to get IRQ %d: %d\n", es8316->irq, ret);
-		es8316->irq = -ENXIO;
+	if (es8316->irq > 0) {
+		ret = devm_request_threaded_irq(dev, es8316->irq, NULL, es8316_irq,
+						IRQF_TRIGGER_HIGH | IRQF_ONESHOT | IRQF_NO_AUTOEN,
+						"es8316", es8316);
+		if (ret) {
+			dev_warn(dev, "Failed to get IRQ %d: %d\n", es8316->irq, ret);
+			es8316->irq = -ENXIO;
+		}
 	}
 
 	return devm_snd_soc_register_component(&i2c_client->dev,
diff --git a/sound/soc/fsl/fsl_mqs.c b/sound/soc/fsl/fsl_mqs.c
index 0d4efbed41da..c33439650823 100644
--- a/sound/soc/fsl/fsl_mqs.c
+++ b/sound/soc/fsl/fsl_mqs.c
@@ -204,10 +204,10 @@ static int fsl_mqs_probe(struct platform_device *pdev)
 		}
 
 		mqs_priv->regmap = syscon_node_to_regmap(gpr_np);
+		of_node_put(gpr_np);
 		if (IS_ERR(mqs_priv->regmap)) {
 			dev_err(&pdev->dev, "failed to get gpr regmap\n");
-			ret = PTR_ERR(mqs_priv->regmap);
-			goto err_free_gpr_np;
+			return PTR_ERR(mqs_priv->regmap);
 		}
 	} else {
 		regs = devm_platform_ioremap_resource(pdev, 0);
@@ -236,8 +236,7 @@ static int fsl_mqs_probe(struct platform_device *pdev)
 	if (IS_ERR(mqs_priv->mclk)) {
 		dev_err(&pdev->dev, "failed to get the clock: %ld\n",
 			PTR_ERR(mqs_priv->mclk));
-		ret = PTR_ERR(mqs_priv->mclk);
-		goto err_free_gpr_np;
+		return PTR_ERR(mqs_priv->mclk);
 	}
 
 	dev_set_drvdata(&pdev->dev, mqs_priv);
@@ -246,13 +245,9 @@ static int fsl_mqs_probe(struct platform_device *pdev)
 	ret = devm_snd_soc_register_component(&pdev->dev, &soc_codec_fsl_mqs,
 			&fsl_mqs_dai, 1);
 	if (ret)
-		goto err_free_gpr_np;
-	return 0;
-
-err_free_gpr_np:
-	of_node_put(gpr_np);
+		return ret;
 
-	return ret;
+	return 0;
 }
 
 static int fsl_mqs_remove(struct platform_device *pdev)
diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 8a99cb6dfcd6..9a5ab96f917d 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -393,6 +393,18 @@ static int byt_rt5640_aif1_hw_params(struct snd_pcm_substream *substream,
 
 /* Please keep this list alphabetically sorted */
 static const struct dmi_system_id byt_rt5640_quirk_table[] = {
+	{	/* Acer Iconia One 7 B1-750 */
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Insyde"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "VESPA2"),
+		},
+		.driver_data = (void *)(BYT_RT5640_DMIC1_MAP |
+					BYT_RT5640_JD_SRC_JD1_IN4P |
+					BYT_RT5640_OVCD_TH_1500UA |
+					BYT_RT5640_OVCD_SF_0P75 |
+					BYT_RT5640_SSP0_AIF1 |
+					BYT_RT5640_MCLK_EN),
+	},
 	{	/* Acer Iconia Tab 8 W1-810 */
 		.matches = {
 			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Acer"),
diff --git a/sound/usb/caiaq/input.c b/sound/usb/caiaq/input.c
index 1e2cf2f08eec..84f26dce7f5d 100644
--- a/sound/usb/caiaq/input.c
+++ b/sound/usb/caiaq/input.c
@@ -804,6 +804,7 @@ int snd_usb_caiaq_input_init(struct snd_usb_caiaqdev *cdev)
 
 	default:
 		/* no input methods supported on this device */
+		ret = -EINVAL;
 		goto exit_free_idev;
 	}
 
diff --git a/tools/bpf/bpftool/json_writer.c b/tools/bpf/bpftool/json_writer.c
index 7fea83bedf48..bca5dd0a59e3 100644
--- a/tools/bpf/bpftool/json_writer.c
+++ b/tools/bpf/bpftool/json_writer.c
@@ -80,9 +80,6 @@ static void jsonw_puts(json_writer_t *self, const char *str)
 		case '"':
 			fputs("\\\"", self->out);
 			break;
-		case '\'':
-			fputs("\\\'", self->out);
-			break;
 		default:
 			putc(*str, self->out);
 		}
diff --git a/tools/bpf/bpftool/xlated_dumper.c b/tools/bpf/bpftool/xlated_dumper.c
index 8608cd68cdd0..13d614b16f6c 100644
--- a/tools/bpf/bpftool/xlated_dumper.c
+++ b/tools/bpf/bpftool/xlated_dumper.c
@@ -363,8 +363,15 @@ void dump_xlated_for_graph(struct dump_data *dd, void *buf_start, void *buf_end,
 	struct bpf_insn *insn_start = buf_start;
 	struct bpf_insn *insn_end = buf_end;
 	struct bpf_insn *cur = insn_start;
+	bool double_insn = false;
 
 	for (; cur <= insn_end; cur++) {
+		if (double_insn) {
+			double_insn = false;
+			continue;
+		}
+		double_insn = cur->code == (BPF_LD | BPF_IMM | BPF_DW);
+
 		printf("% 4d: ", (int)(cur - insn_start + start_idx));
 		print_bpf_insn(&cbs, cur, true);
 		if (cur != insn_end)
diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index d3b5f5faf8c1..02e5774cabb6 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -670,7 +670,7 @@ static void create_tasks(struct perf_sched *sched)
 	err = pthread_attr_init(&attr);
 	BUG_ON(err);
 	err = pthread_attr_setstacksize(&attr,
-			(size_t) max(16 * 1024, PTHREAD_STACK_MIN));
+			(size_t) max(16 * 1024, (int)PTHREAD_STACK_MIN));
 	BUG_ON(err);
 	err = pthread_mutex_lock(&sched->start_work_mutex);
 	BUG_ON(err);
diff --git a/tools/perf/pmu-events/arch/powerpc/power9/other.json b/tools/perf/pmu-events/arch/powerpc/power9/other.json
index 3f69422c21f9..f10bd554521a 100644
--- a/tools/perf/pmu-events/arch/powerpc/power9/other.json
+++ b/tools/perf/pmu-events/arch/powerpc/power9/other.json
@@ -1417,7 +1417,7 @@
   {
     "EventCode": "0x45054",
     "EventName": "PM_FMA_CMPL",
-    "BriefDescription": "two flops operation completed (fmadd, fnmadd, fmsub, fnmsub) Scalar instructions only. "
+    "BriefDescription": "two flops operation completed (fmadd, fnmadd, fmsub, fnmsub) Scalar instructions only."
   },
   {
     "EventCode": "0x201E8",
@@ -2017,7 +2017,7 @@
   {
     "EventCode": "0xC0BC",
     "EventName": "PM_LSU_FLUSH_OTHER",
-    "BriefDescription": "Other LSU flushes including: Sync (sync ack from L2 caused search of LRQ for oldest snooped load, This will either signal a Precise Flush of the oldest snooped loa or a Flush Next PPC); Data Valid Flush Next (several cases of this, one example is store and reload are lined up such that a store-hit-reload scenario exists and the CDF has already launched and has gotten bad/stale data); Bad Data Valid Flush Next (might be a few cases of this, one example is a larxa (D$ hit) return data and dval but can't allocate to LMQ (LMQ full or other reason). Already gave dval but can't watch it for snoop_hit_larx. Need to take the “bad dval” back and flush all younger ops)"
+    "BriefDescription": "Other LSU flushes including: Sync (sync ack from L2 caused search of LRQ for oldest snooped load, This will either signal a Precise Flush of the oldest snooped loa or a Flush Next PPC); Data Valid Flush Next (several cases of this, one example is store and reload are lined up such that a store-hit-reload scenario exists and the CDF has already launched and has gotten bad/stale data); Bad Data Valid Flush Next (might be a few cases of this, one example is a larxa (D$ hit) return data and dval but can't allocate to LMQ (LMQ full or other reason). Already gave dval but can't watch it for snoop_hit_larx. Need to take the 'bad dval' back and flush all younger ops)"
   },
   {
     "EventCode": "0x5094",
diff --git a/tools/perf/pmu-events/arch/powerpc/power9/pipeline.json b/tools/perf/pmu-events/arch/powerpc/power9/pipeline.json
index d0265f255de2..723bffa41c44 100644
--- a/tools/perf/pmu-events/arch/powerpc/power9/pipeline.json
+++ b/tools/perf/pmu-events/arch/powerpc/power9/pipeline.json
@@ -442,7 +442,7 @@
   {
     "EventCode": "0x4D052",
     "EventName": "PM_2FLOP_CMPL",
-    "BriefDescription": "DP vector version of fmul, fsub, fcmp, fsel, fabs, fnabs, fres ,fsqrte, fneg "
+    "BriefDescription": "DP vector version of fmul, fsub, fcmp, fsel, fabs, fnabs, fres ,fsqrte, fneg"
   },
   {
     "EventCode": "0x1F142",
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 18452f12510c..41dd4c266cc0 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -2279,6 +2279,7 @@ static int find_entire_kern_cb(void *arg, const char *name __maybe_unused,
 			       char type, u64 start)
 {
 	struct sym_args *args = arg;
+	u64 size;
 
 	if (!kallsyms__is_function(type))
 		return 0;
@@ -2288,7 +2289,9 @@ static int find_entire_kern_cb(void *arg, const char *name __maybe_unused,
 		args->start = start;
 	}
 	/* Don't know exactly where the kernel ends, so we add a page */
-	args->size = round_up(start, page_size) + page_size - args->start;
+	size = round_up(start, page_size) + page_size - args->start;
+	if (size > args->size)
+		args->size = size;
 
 	return 0;
 }
diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
index e4c485f92c02..48fda1a19ab5 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -1639,6 +1639,8 @@ static void intel_pt_calc_cbr(struct intel_pt_decoder *decoder)
 
 	decoder->cbr = cbr;
 	decoder->cbr_cyc_to_tsc = decoder->max_non_turbo_ratio_fp / cbr;
+	decoder->cyc_ref_timestamp = decoder->timestamp;
+	decoder->cycle_cnt = 0;
 
 	intel_pt_mtc_cyc_cnt_cbr(decoder);
 }
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index ac45da0302a7..d322305bc182 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1670,7 +1670,7 @@ static int perf_pmu__new_caps(struct list_head *list, char *name, char *value)
 	return 0;
 
 free_name:
-	zfree(caps->name);
+	zfree(&caps->name);
 free_caps:
 	free(caps);
 
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 5e9e96452b9e..42806102010b 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -873,8 +873,7 @@ static int hist_entry__dso_to_filter(struct hist_entry *he, int type,
 static int64_t
 sort__sym_from_cmp(struct hist_entry *left, struct hist_entry *right)
 {
-	struct addr_map_symbol *from_l = &left->branch_info->from;
-	struct addr_map_symbol *from_r = &right->branch_info->from;
+	struct addr_map_symbol *from_l, *from_r;
 
 	if (!left->branch_info || !right->branch_info)
 		return cmp_null(left->branch_info, right->branch_info);
diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 5221f272f85c..b171d134ce87 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -548,7 +548,7 @@ static int elf_read_build_id(Elf *elf, void *bf, size_t size)
 				size_t sz = min(size, descsz);
 				memcpy(bf, ptr, sz);
 				memset(bf + sz, 0, size - sz);
-				err = descsz;
+				err = sz;
 				break;
 			}
 		}
diff --git a/tools/testing/selftests/bpf/prog_tests/cg_storage_multi.c b/tools/testing/selftests/bpf/prog_tests/cg_storage_multi.c
index 643dfa35419c..48dc5827daa7 100644
--- a/tools/testing/selftests/bpf/prog_tests/cg_storage_multi.c
+++ b/tools/testing/selftests/bpf/prog_tests/cg_storage_multi.c
@@ -56,8 +56,9 @@ static bool assert_storage_noexist(struct bpf_map *map, const void *key)
 
 static bool connect_send(const char *cgroup_path)
 {
-	bool res = true;
 	int server_fd = -1, client_fd = -1;
+	char message[] = "message";
+	bool res = true;
 
 	if (join_cgroup(cgroup_path))
 		goto out_clean;
@@ -70,7 +71,10 @@ static bool connect_send(const char *cgroup_path)
 	if (client_fd < 0)
 		goto out_clean;
 
-	if (send(client_fd, "message", strlen("message"), 0) < 0)
+	if (send(client_fd, &message, sizeof(message), 0) < 0)
+		goto out_clean;
+
+	if (read(server_fd, &message, sizeof(message)) < 0)
 		goto out_clean;
 
 	res = false;
diff --git a/tools/testing/selftests/resctrl/fill_buf.c b/tools/testing/selftests/resctrl/fill_buf.c
index 56ccbeae0638..c20d0a7ecbe6 100644
--- a/tools/testing/selftests/resctrl/fill_buf.c
+++ b/tools/testing/selftests/resctrl/fill_buf.c
@@ -68,6 +68,8 @@ static void *malloc_and_init_memory(size_t s)
 	size_t s64;
 
 	void *p = memalign(PAGE_SIZE, s);
+	if (!p)
+		return NULL;
 
 	p64 = (uint64_t *)p;
 	s64 = s / sizeof(uint64_t);
diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
index 6449fbd96096..6cfddd1d4355 100644
--- a/tools/testing/selftests/resctrl/mba_test.c
+++ b/tools/testing/selftests/resctrl/mba_test.c
@@ -28,6 +28,7 @@ static int mba_setup(int num, ...)
 	struct resctrl_val_param *p;
 	char allocation_str[64];
 	va_list param;
+	int ret;
 
 	va_start(param, num);
 	p = va_arg(param, struct resctrl_val_param *);
@@ -45,7 +46,11 @@ static int mba_setup(int num, ...)
 
 	sprintf(allocation_str, "%d", allocation);
 
-	write_schemata(p->ctrlgrp, allocation_str, p->cpu_no, p->resctrl_val);
+	ret = write_schemata(p->ctrlgrp, allocation_str, p->cpu_no,
+			     p->resctrl_val);
+	if (ret < 0)
+		return ret;
+
 	allocation -= ALLOCATION_STEP;
 
 	return 0;
