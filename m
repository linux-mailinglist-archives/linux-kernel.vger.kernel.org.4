Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24E6F62F737
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 15:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242336AbiKROVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 09:21:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242333AbiKROV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 09:21:27 -0500
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 762C3A457;
        Fri, 18 Nov 2022 06:21:25 -0800 (PST)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AICNlEX025133;
        Fri, 18 Nov 2022 15:21:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=jP12zWQBN+XsiDIL+l1U4dIV3t9oCSoslQ89hmUsN4Q=;
 b=xNRbMJp0pldFOwXmvBP40cNRHVHA3tj1hF+K4RMmONcZSnMPcOehO02A1ZygIpvHaGZ/
 TG7TciY6fLlSn+P6GWvzMQ03Akv+cSIV2o8TeXTDG9nCNEGDcmRrRJfSRP4wu3YNF90i
 iESKpB9zq3qPpCRsL/7Ynvol66Dy971tT8Qz2YeY5PB57ZMW1o1fROB1PWwX+rm2NXLL
 BLfmT5AEu3Pl2DVkkRAt+R2Gq11cRuAIRsINzQwasLSIM1E1NWB1lxWy4XjezQ7DhEXr
 NK8rf/obGJ9atSvrlsQvD2An3mWHhiGMMRNSgpViY3sElbGnvkO9MK9YwpvJFsVGxafO hg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3kx0my47rq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Nov 2022 15:21:02 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 237DE100038;
        Fri, 18 Nov 2022 15:20:58 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1CF58231DE3;
        Fri, 18 Nov 2022 15:20:58 +0100 (CET)
Received: from localhost (10.201.20.178) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.32; Fri, 18 Nov
 2022 15:20:57 +0100
From:   Olivier Moysan <olivier.moysan@foss.st.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     Olivier Moysan <olivier.moysan@foss.st.com>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/4] ARM: dts: stm32: add i2s nodes on stm32mp131
Date:   Fri, 18 Nov 2022 15:20:03 +0100
Message-ID: <20221118142006.479138-2-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221118142006.479138-1-olivier.moysan@foss.st.com>
References: <20221118142006.479138-1-olivier.moysan@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.20.178]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-18_02,2022-11-18_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add I2S1, I2S2, I2S3 and I2S4 peripherals support for the
STM32MP13 SoC family.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
---
 arch/arm/boot/dts/stm32mp131.dtsi | 44 +++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp131.dtsi b/arch/arm/boot/dts/stm32mp131.dtsi
index 2a9b3a5bba83..b8da3844df94 100644
--- a/arch/arm/boot/dts/stm32mp131.dtsi
+++ b/arch/arm/boot/dts/stm32mp131.dtsi
@@ -121,6 +121,17 @@ scmi_shm: scmi-sram@0 {
 			};
 		};
 
+		i2s2: audio-controller@4000b000 {
+			compatible = "st,stm32h7-i2s";
+			reg = <0x4000b000 0x400>;
+			#sound-dai-cells = <0>;
+			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
+			dmas = <&dmamux1 39 0x400 0x01>,
+			       <&dmamux1 40 0x400 0x01>;
+			dma-names = "rx", "tx";
+			status = "disabled";
+		};
+
 		spi2: spi@4000b000 {
 			compatible = "st,stm32h7-spi";
 			reg = <0x4000b000 0x400>;
@@ -135,6 +146,17 @@ spi2: spi@4000b000 {
 			status = "disabled";
 		};
 
+		i2s3: audio-controller@4000c000 {
+			compatible = "st,stm32h7-i2s";
+			reg = <0x4000c000 0x400>;
+			#sound-dai-cells = <0>;
+			interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
+			dmas = <&dmamux1 61 0x400 0x01>,
+			       <&dmamux1 62 0x400 0x01>;
+			dma-names = "rx", "tx";
+			status = "disabled";
+		};
+
 		spi3: spi@4000c000 {
 			compatible = "st,stm32h7-spi";
 			reg = <0x4000c000 0x400>;
@@ -194,6 +216,17 @@ i2c2: i2c@40013000 {
 			status = "disabled";
 		};
 
+		i2s1: audio-controller@44004000 {
+			compatible = "st,stm32h7-i2s";
+			reg = <0x44004000 0x400>;
+			#sound-dai-cells = <0>;
+			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
+			dmas = <&dmamux1 37 0x400 0x01>,
+			       <&dmamux1 38 0x400 0x01>;
+			dma-names = "rx", "tx";
+			status = "disabled";
+		};
+
 		spi1: spi@44004000 {
 			compatible = "st,stm32h7-spi";
 			reg = <0x44004000 0x400>;
@@ -315,6 +348,17 @@ usbotg_hs: usb@49000000 {
 			status = "disabled";
 		};
 
+		i2s4: audio-controller@4c002000 {
+			compatible = "st,stm32h7-i2s";
+			reg = <0x4c002000 0x400>;
+			#sound-dai-cells = <0>;
+			interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
+			dmas = <&dmamux1 83 0x400 0x01>,
+			       <&dmamux1 84 0x400 0x01>;
+			dma-names = "rx", "tx";
+			status = "disabled";
+		};
+
 		spi4: spi@4c002000 {
 			compatible = "st,stm32h7-spi";
 			reg = <0x4c002000 0x400>;
-- 
2.25.1

