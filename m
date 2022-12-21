Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F678653556
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 18:35:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234905AbiLURfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 12:35:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234983AbiLURef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 12:34:35 -0500
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 543A726541;
        Wed, 21 Dec 2022 09:34:01 -0800 (PST)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BLDfZAV026755;
        Wed, 21 Dec 2022 18:33:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=HvbZMt9uDmeIHEq1F2d8b531XzccYnOXXCh8BRejkHI=;
 b=3yUqYuSGUg0LL4zh4C8lg89qTfFHir/zGsqXh+B+R8Qo/7iPE0pRBdm/PWoT2RG+4bti
 YP9ju3xiB0ZesegmdQv5WKT1H33yi4LXfdtboQqB4pjfnuBo2FVwruXy+htiDQEv85Ih
 BK9Rvn+PaMweHGxwoCnJZV5APmRasT9XlajWe/LxbfQE8wJVpIemPB8Zjb1WAM4R8sHC
 N3n1Y3tYD2G8JJHTCZ7IOB73OKckSeA2mvzQxfbXu+g8Acr1bdL9QR5WU3Z6T39ChdUc
 jD2ryU7Iehd7x0An08FXPhUyNE/hX7xsd9zYaAI+qrXjpPG7IR8hEeOZjQ3ePYHIvBT9 xQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3mka9xapwg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Dec 2022 18:33:44 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3D23410002A;
        Wed, 21 Dec 2022 18:33:44 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 35FF325222D;
        Wed, 21 Dec 2022 18:33:44 +0100 (CET)
Received: from localhost (10.201.21.217) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.13; Wed, 21 Dec
 2022 18:33:43 +0100
From:   Gatien Chevallier <gatien.chevallier@foss.st.com>
To:     <alexandre.torgue@foss.st.com>, <robh+dt@kernel.org>,
        <Oleksii_Moisieiev@epam.com>, <linus.walleij@linaro.org>,
        <gregkh@linuxfoundation.org>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <loic.pallardy@st.com>,
        <devicetree@vger.kernel.org>, <mark.rutland@arm.com>,
        <arnd@arndb.de>, <gatien.chevallier@foss.st.com>
Subject: [RFC PATCH 7/7] ARM: dts: stm32: add ETZPC as a system bus for STM32MP13x boards
Date:   Wed, 21 Dec 2022 18:30:55 +0100
Message-ID: <20221221173055.11719-8-gatien.chevallier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221221173055.11719-1-gatien.chevallier@foss.st.com>
References: <20221221173055.11719-1-gatien.chevallier@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.21.217]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-21_10,2022-12-21_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The STM32 System Bus is an internal bus on which devices are connected.
ETZPC is a peripheral overseeing the firewall bus that configures
and control access to the peripherals connected on it.

For more information on which peripheral is securable, please read
the STM32MP13 reference manual.

Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
---
 arch/arm/boot/dts/stm32mp131.dtsi | 242 ++++++++++++++++--------------
 1 file changed, 130 insertions(+), 112 deletions(-)

diff --git a/arch/arm/boot/dts/stm32mp131.dtsi b/arch/arm/boot/dts/stm32mp131.dtsi
index dd35a607073d..0b3934fe6c34 100644
--- a/arch/arm/boot/dts/stm32mp131.dtsi
+++ b/arch/arm/boot/dts/stm32mp131.dtsi
@@ -3,6 +3,7 @@
  * Copyright (C) STMicroelectronics 2021 - All Rights Reserved
  * Author: Alexandre Torgue <alexandre.torgue@foss.st.com> for STMicroelectronics.
  */
+#include <dt-bindings/bus/stm32mp13_sys_bus.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/stm32mp13-clks.h>
 #include <dt-bindings/reset/stm32mp13-resets.h>
@@ -231,88 +232,6 @@ dmamux1: dma-router@48002000 {
 			dma-channels = <16>;
 		};
 
-		spi4: spi@4c002000 {
-			compatible = "st,stm32h7-spi";
-			reg = <0x4c002000 0x400>;
-			interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&rcc SPI4_K>;
-			resets = <&rcc SPI4_R>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			dmas = <&dmamux1 83 0x400 0x01>,
-			       <&dmamux1 84 0x400 0x01>;
-			dma-names = "rx", "tx";
-			status = "disabled";
-		};
-
-		spi5: spi@4c003000 {
-			compatible = "st,stm32h7-spi";
-			reg = <0x4c003000 0x400>;
-			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&rcc SPI5_K>;
-			resets = <&rcc SPI5_R>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			dmas = <&dmamux1 85 0x400 0x01>,
-			       <&dmamux1 86 0x400 0x01>;
-			dma-names = "rx", "tx";
-			status = "disabled";
-		};
-
-		i2c3: i2c@4c004000 {
-			compatible = "st,stm32mp13-i2c";
-			reg = <0x4c004000 0x400>;
-			interrupt-names = "event", "error";
-			interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&rcc I2C3_K>;
-			resets = <&rcc I2C3_R>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			dmas = <&dmamux1 73 0x400 0x1>,
-			       <&dmamux1 74 0x400 0x1>;
-			dma-names = "rx", "tx";
-			st,syscfg-fmp = <&syscfg 0x4 0x4>;
-			i2c-analog-filter;
-			status = "disabled";
-		};
-
-		i2c4: i2c@4c005000 {
-			compatible = "st,stm32mp13-i2c";
-			reg = <0x4c005000 0x400>;
-			interrupt-names = "event", "error";
-			interrupts = <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&rcc I2C4_K>;
-			resets = <&rcc I2C4_R>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			dmas = <&dmamux1 75 0x400 0x1>,
-			       <&dmamux1 76 0x400 0x1>;
-			dma-names = "rx", "tx";
-			st,syscfg-fmp = <&syscfg 0x4 0x8>;
-			i2c-analog-filter;
-			status = "disabled";
-		};
-
-		i2c5: i2c@4c006000 {
-			compatible = "st,stm32mp13-i2c";
-			reg = <0x4c006000 0x400>;
-			interrupt-names = "event", "error";
-			interrupts = <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&rcc I2C5_K>;
-			resets = <&rcc I2C5_R>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			dmas = <&dmamux1 115 0x400 0x1>,
-			       <&dmamux1 116 0x400 0x1>;
-			dma-names = "rx", "tx";
-			st,syscfg-fmp = <&syscfg 0x4 0x10>;
-			i2c-analog-filter;
-			status = "disabled";
-		};
-
 		rcc: rcc@50000000 {
 			compatible = "st,stm32mp13-rcc", "syscon";
 			reg = <0x50000000 0x1000>;
@@ -349,36 +268,6 @@ mdma: dma-controller@58000000 {
 			dma-requests = <48>;
 		};
 
-		sdmmc1: mmc@58005000 {
-			compatible = "st,stm32-sdmmc2", "arm,pl18x", "arm,primecell";
-			arm,primecell-periphid = <0x20253180>;
-			reg = <0x58005000 0x1000>, <0x58006000 0x1000>;
-			interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "cmd_irq";
-			clocks = <&rcc SDMMC1_K>;
-			clock-names = "apb_pclk";
-			resets = <&rcc SDMMC1_R>;
-			cap-sd-highspeed;
-			cap-mmc-highspeed;
-			max-frequency = <130000000>;
-			status = "disabled";
-		};
-
-		sdmmc2: mmc@58007000 {
-			compatible = "st,stm32-sdmmc2", "arm,pl18x", "arm,primecell";
-			arm,primecell-periphid = <0x20253180>;
-			reg = <0x58007000 0x1000>, <0x58008000 0x1000>;
-			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "cmd_irq";
-			clocks = <&rcc SDMMC2_K>;
-			clock-names = "apb_pclk";
-			resets = <&rcc SDMMC2_R>;
-			cap-sd-highspeed;
-			cap-mmc-highspeed;
-			max-frequency = <130000000>;
-			status = "disabled";
-		};
-
 		iwdg2: watchdog@5a002000 {
 			compatible = "st,stm32mp1-iwdg";
 			reg = <0x5a002000 0x400>;
@@ -414,6 +303,135 @@ ts_cal2: calib@5e {
 			};
 		};
 
+		etzpc: etzpc@5c007000 {
+			compatible = "st,stm32mp13-sys-bus";
+			reg = <0x5c007000 0x400>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			feature-domain-controller;
+			#feature-domain-cells = <2>;
+			ranges;
+
+			spi4: spi@4c002000 {
+				compatible = "st,stm32h7-spi";
+				reg = <0x4c002000 0x400>;
+				interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&rcc SPI4_K>;
+				resets = <&rcc SPI4_R>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				dmas = <&dmamux1 83 0x400 0x01>,
+				       <&dmamux1 84 0x400 0x01>;
+				dma-names = "rx", "tx";
+				feature-domains = <&etzpc STM32MP1_ETZPC_SPI4_ID>;
+				status = "disabled";
+			};
+
+			spi5: spi@4c003000 {
+				compatible = "st,stm32h7-spi";
+				reg = <0x4c003000 0x400>;
+				interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&rcc SPI5_K>;
+				resets = <&rcc SPI5_R>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				dmas = <&dmamux1 85 0x400 0x01>,
+				       <&dmamux1 86 0x400 0x01>;
+				dma-names = "rx", "tx";
+				feature-domains = <&etzpc STM32MP1_ETZPC_SPI5_ID>;
+				status = "disabled";
+			};
+
+			i2c3: i2c@4c004000 {
+				compatible = "st,stm32mp13-i2c";
+				reg = <0x4c004000 0x400>;
+				interrupt-names = "event", "error";
+				interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&rcc I2C3_K>;
+				resets = <&rcc I2C3_R>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				dmas = <&dmamux1 73 0x400 0x1>,
+				       <&dmamux1 74 0x400 0x1>;
+				dma-names = "rx", "tx";
+				st,syscfg-fmp = <&syscfg 0x4 0x4>;
+				i2c-analog-filter;
+				feature-domains = <&etzpc STM32MP1_ETZPC_I2C3_ID>;
+				status = "disabled";
+			};
+
+			i2c4: i2c@4c005000 {
+				compatible = "st,stm32mp13-i2c";
+				reg = <0x4c005000 0x400>;
+				interrupt-names = "event", "error";
+				interrupts = <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&rcc I2C4_K>;
+				resets = <&rcc I2C4_R>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				dmas = <&dmamux1 75 0x400 0x1>,
+				       <&dmamux1 76 0x400 0x1>;
+				dma-names = "rx", "tx";
+				st,syscfg-fmp = <&syscfg 0x4 0x8>;
+				i2c-analog-filter;
+				feature-domains = <&etzpc STM32MP1_ETZPC_I2C4_ID>;
+				status = "disabled";
+			};
+
+			i2c5: i2c@4c006000 {
+				compatible = "st,stm32mp13-i2c";
+				reg = <0x4c006000 0x400>;
+				interrupt-names = "event", "error";
+				interrupts = <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&rcc I2C5_K>;
+				resets = <&rcc I2C5_R>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				dmas = <&dmamux1 115 0x400 0x1>,
+				       <&dmamux1 116 0x400 0x1>;
+				dma-names = "rx", "tx";
+				st,syscfg-fmp = <&syscfg 0x4 0x10>;
+				i2c-analog-filter;
+				feature-domains = <&etzpc STM32MP1_ETZPC_I2C5_ID>;
+				status = "disabled";
+			};
+
+			sdmmc1: mmc@58005000 {
+				compatible = "st,stm32-sdmmc2", "arm,pl18x", "arm,primecell";
+				arm,primecell-periphid = <0x20253180>;
+				reg = <0x58005000 0x1000>, <0x58006000 0x1000>;
+				interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names = "cmd_irq";
+				clocks = <&rcc SDMMC1_K>;
+				clock-names = "apb_pclk";
+				resets = <&rcc SDMMC1_R>;
+				cap-sd-highspeed;
+				cap-mmc-highspeed;
+				max-frequency = <130000000>;
+				feature-domains = <&etzpc STM32MP1_ETZPC_SDMMC1_ID>;
+				status = "disabled";
+			};
+
+			sdmmc2: mmc@58007000 {
+				compatible = "st,stm32-sdmmc2", "arm,pl18x", "arm,primecell";
+				arm,primecell-periphid = <0x20253180>;
+				reg = <0x58007000 0x1000>, <0x58008000 0x1000>;
+				interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names = "cmd_irq";
+				clocks = <&rcc SDMMC2_K>;
+				clock-names = "apb_pclk";
+				resets = <&rcc SDMMC2_R>;
+				cap-sd-highspeed;
+				cap-mmc-highspeed;
+				max-frequency = <130000000>;
+				feature-domains = <&etzpc STM32MP1_ETZPC_SDMMC2_ID>;
+				status = "disabled";
+			};
+
+		};
 		/*
 		 * Break node order to solve dependency probe issue between
 		 * pinctrl and exti.
-- 
2.25.1

