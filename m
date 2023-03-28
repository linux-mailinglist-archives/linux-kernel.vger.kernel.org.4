Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB3F26CC8D4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 19:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbjC1RHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 13:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjC1RHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 13:07:33 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27F926A1;
        Tue, 28 Mar 2023 10:07:31 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32SE0b62013741;
        Tue, 28 Mar 2023 19:07:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=/JFCzUt10vgUA0iE4Gx085JoNqxPpcI3weV0g+exKmA=;
 b=XDCc5TuePvzZlDVEDUg7Ep4ngmPohH+Nurn9JSo/39PE1E0yOTYQB0j10dAr7HQ5xDYx
 mW88WOsre7mDsmrH0g8HSGIoTFGOXM3gfa+8l2ErxzWW7P89TQS8hzVXebUtqQpg5L25
 rCzJQi44znhysUg75LMuTMgL3xzr9WWBl0z4w4lreMLB2/vdBg02hHNQFjqVHUE/33ol
 wPBqQ+gdqZ7Ccbp9+dBwWckwrQ1jgah8jcxMGfd5ZmaHmnFpoSgrTbDYJ6NYn7EIcKT3
 IzoGimuoFSXqYUCJRcFtu+SIYO2nOje5Uch4WO0gukf/WFx/H28wYR549ygpoQb1s0cD eg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3phsqwkn3m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Mar 2023 19:07:19 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 524F710002A;
        Tue, 28 Mar 2023 19:07:18 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id CB78221BF4A;
        Tue, 28 Mar 2023 19:07:18 +0200 (CEST)
Received: from localhost (10.48.0.175) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Tue, 28 Mar
 2023 19:07:18 +0200
From:   Christophe Kerello <christophe.kerello@foss.st.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <alexandre.torgue@foss.st.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Christophe Kerello <christophe.kerello@foss.st.com>
Subject: [PATCH v2] ARM: dts: stm32: add FMC support on STM32MP13x SoC family
Date:   Tue, 28 Mar 2023 19:07:11 +0200
Message-ID: <20230328170711.247745-1-christophe.kerello@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.48.0.175]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-28_02,2023-02-09_01
X-Spam-Status: No, score=-0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add FMC support on STM32MP13x SoC family.

Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
---
Changes in v2:
 - compatible, reg and ranges properties have been moved at the top of each node

 arch/arm/boot/dts/stm32mp131.dtsi | 33 +++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp131.dtsi b/arch/arm/boot/dts/stm32mp131.dtsi
index 9ea61687f023..7ea1fe0cd070 100644
--- a/arch/arm/boot/dts/stm32mp131.dtsi
+++ b/arch/arm/boot/dts/stm32mp131.dtsi
@@ -1232,6 +1232,39 @@ mdma: dma-controller@58000000 {
 			dma-requests = <48>;
 		};
 
+		fmc: memory-controller@58002000 {
+			compatible = "st,stm32mp1-fmc2-ebi";
+			reg = <0x58002000 0x1000>;
+			ranges = <0 0 0x60000000 0x04000000>, /* EBI CS 1 */
+				 <1 0 0x64000000 0x04000000>, /* EBI CS 2 */
+				 <2 0 0x68000000 0x04000000>, /* EBI CS 3 */
+				 <3 0 0x6c000000 0x04000000>, /* EBI CS 4 */
+				 <4 0 0x80000000 0x10000000>; /* NAND */
+			#address-cells = <2>;
+			#size-cells = <1>;
+			clocks = <&rcc FMC_K>;
+			resets = <&rcc FMC_R>;
+			status = "disabled";
+
+			nand-controller@4,0 {
+				compatible = "st,stm32mp1-fmc2-nfc";
+				reg = <4 0x00000000 0x1000>,
+				      <4 0x08010000 0x1000>,
+				      <4 0x08020000 0x1000>,
+				      <4 0x01000000 0x1000>,
+				      <4 0x09010000 0x1000>,
+				      <4 0x09020000 0x1000>;
+				#address-cells = <1>;
+				#size-cells = <0>;
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

