Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 895A06D1870
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 09:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbjCaHUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 03:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231415AbjCaHUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 03:20:04 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA9730F5;
        Fri, 31 Mar 2023 00:19:44 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32V6evYu022072;
        Fri, 31 Mar 2023 09:19:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=uTVIHoKwQl0AIaI1qqIaSYKE4Q0LkMlPuiRteO4iDxc=;
 b=X/NWdlUV+WDIn+rQqTmVB0bJvXzgzuMwctnciTLc54vhtEUw2yPLx7v6KTV1oIIor1/M
 UusfBjQFq9pMgSyhgTSmmeI5ZBXyP8VoMw5ScS9nbCvhHqscmxKNblsy4/MwQan/4rt2
 l7aLAxv+GLE8lzH0hdRAjG+oZCmKs3nGP7UU7vC1nQuZcH6MzOPWTUgTf9UOlYtxmq4J
 AlKvJ/foS4HQg25x1PrToesqIWMFQN62Xd1rA1ZAwnLJoa5PdpMBCCjv2OtjLmD4D3DL
 HLBu67LComEGMZANVhwsOGZJvcTHFlP4Czfg4dHVxlAfDctAVf4q1OHVljv3Ej27eM/g Tw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3pn8jwe53r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 31 Mar 2023 09:19:14 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7A6E3100040;
        Fri, 31 Mar 2023 09:19:12 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 64CD72115ED;
        Fri, 31 Mar 2023 09:19:12 +0200 (CEST)
Received: from localhost (10.201.21.26) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Fri, 31 Mar
 2023 09:19:12 +0200
From:   <patrice.chotard@foss.st.com>
To:     <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <alexandre.torgue@foss.st.com>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>
Subject: [PATCH] ARM: dts: stm32: Add QSPI support on STM32MP13x SoC family
Date:   Fri, 31 Mar 2023 09:19:07 +0200
Message-ID: <20230331071907.4127388-1-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.21.26]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-31_02,2023-03-30_04,2023-02-09_01
X-Spam-Status: No, score=-0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrice Chotard <patrice.chotard@foss.st.com>

Add QSPI support on STM32MP13x SoC family

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 arch/arm/boot/dts/stm32mp131.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp131.dtsi b/arch/arm/boot/dts/stm32mp131.dtsi
index 5949473cbbfd..544c755b6e67 100644
--- a/arch/arm/boot/dts/stm32mp131.dtsi
+++ b/arch/arm/boot/dts/stm32mp131.dtsi
@@ -1137,6 +1137,21 @@ mdma: dma-controller@58000000 {
 			dma-requests = <48>;
 		};
 
+		qspi: spi@58003000 {
+			compatible = "st,stm32f469-qspi";
+			reg = <0x58003000 0x1000>, <0x70000000 0x10000000>;
+			reg-names = "qspi", "qspi_mm";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
+			dmas = <&mdma 26 0x2 0x10100002 0x0 0x0>,
+			       <&mdma 26 0x2 0x10100008 0x0 0x0>;
+			dma-names = "tx", "rx";
+			clocks = <&rcc QSPI_K>;
+			resets = <&rcc QSPI_R>;
+			status = "disabled";
+		};
+
 		sdmmc1: mmc@58005000 {
 			compatible = "st,stm32-sdmmc2", "arm,pl18x", "arm,primecell";
 			arm,primecell-periphid = <0x20253180>;
-- 
2.25.1

