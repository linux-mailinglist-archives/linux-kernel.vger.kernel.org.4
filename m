Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B34C6CBEFC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 14:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbjC1M1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 08:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232191AbjC1M1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 08:27:04 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16BE7902D;
        Tue, 28 Mar 2023 05:27:00 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32S9siE8000676;
        Tue, 28 Mar 2023 14:26:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=vQJyBdogS7caFFni3BiMJMfnNRw3F1q4T8Gou8pNges=;
 b=B6TaUwHbLSZ5OQwcc1LdnonVrSWWiDcyfeLik235jFNIaTt9C1rvUre60tWxw1F4xfou
 FDDyzQTHgx9p04elXUJqeJ6sbHE1nrmwurIm8cniDNo2XeKENGxIFrmvUFvSY2IIQz5o
 CrmUZmrQIztMdT16DXzYhuZbEpO2+g7ICpXfIiqF+uvOlSzuCTi/xjzFAfERuqWfW2bv
 AzEVNaRLUSGiirr3akhsQNRt+GQGrq47El/RjCS9yugBZPA5lBRhQj3ucXf+tyCUCMQQ
 TwrzIpZJiVB/bo4ndwQ59gx99lQ4lX8eI8aycTFlKEYjLD1fcsZa8IfPkSx2QcK8Dcx+ 7w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3pkvs4smsm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Mar 2023 14:26:51 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 11BF2100034;
        Tue, 28 Mar 2023 14:26:47 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 06C7E215122;
        Tue, 28 Mar 2023 14:26:47 +0200 (CEST)
Received: from localhost (10.48.0.175) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Tue, 28 Mar
 2023 14:26:46 +0200
From:   Christophe Kerello <christophe.kerello@foss.st.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <alexandre.torgue@foss.st.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Christophe Kerello <christophe.kerello@foss.st.com>
Subject: [PATCH] ARM: dts: stm32: add FMC support on STM32MP13x SoC family
Date:   Tue, 28 Mar 2023 14:26:06 +0200
Message-ID: <20230328122606.191211-1-christophe.kerello@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.48.0.175]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-28_01,2023-02-09_01
X-Spam-Status: No, score=-0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the FMC support on STM32MP13x SoC family.

Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
---
 arch/arm/boot/dts/stm32mp131.dtsi | 34 +++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp131.dtsi b/arch/arm/boot/dts/stm32mp131.dtsi
index 5949473cbbfd..7af3eb15c204 100644
--- a/arch/arm/boot/dts/stm32mp131.dtsi
+++ b/arch/arm/boot/dts/stm32mp131.dtsi
@@ -1137,6 +1137,40 @@ mdma: dma-controller@58000000 {
 			dma-requests = <48>;
 		};
 
+		fmc: memory-controller@58002000 {
+			#address-cells = <2>;
+			#size-cells = <1>;
+			compatible = "st,stm32mp1-fmc2-ebi";
+			reg = <0x58002000 0x1000>;
+			clocks = <&rcc FMC_K>;
+			resets = <&rcc FMC_R>;
+			status = "disabled";
+
+			ranges = <0 0 0x60000000 0x04000000>, /* EBI CS 1 */
+				 <1 0 0x64000000 0x04000000>, /* EBI CS 2 */
+				 <2 0 0x68000000 0x04000000>, /* EBI CS 3 */
+				 <3 0 0x6c000000 0x04000000>, /* EBI CS 4 */
+				 <4 0 0x80000000 0x10000000>; /* NAND */
+
+			nand-controller@4,0 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "st,stm32mp1-fmc2-nfc";
+				reg = <4 0x00000000 0x1000>,
+				      <4 0x08010000 0x1000>,
+				      <4 0x08020000 0x1000>,
+				      <4 0x01000000 0x1000>,
+				      <4 0x09010000 0x1000>,
+				      <4 0x09020000 0x1000>;
+				interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
+				dmas = <&mdma 24 0x2 0x12000a02 0x0 0x0>,
+				       <&mdma 24 0x2 0x12000a08 0x0 0x0>,
+				       <&mdma 25 0x2 0x12000a0a 0x0 0x0>;
+				dma-names = "tx", "rx", "ecc";
+				status = "disabled";
+			};
+		};
+
 		sdmmc1: mmc@58005000 {
 			compatible = "st,stm32-sdmmc2", "arm,pl18x", "arm,primecell";
 			arm,primecell-periphid = <0x20253180>;
-- 
2.25.1

