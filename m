Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC1F62F736
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 15:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242364AbiKROVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 09:21:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242331AbiKROV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 09:21:27 -0500
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75CF3A444;
        Fri, 18 Nov 2022 06:21:25 -0800 (PST)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AICIEUD025054;
        Fri, 18 Nov 2022 15:21:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=GbL8DKhmJ0QOd/FVvW+SZTH310AuG5Om3taa3DQGiOY=;
 b=lLAnQMT75MQuGgAmh+1ahWCNSUCIPoUVCwuLX3kSCmXPZVTdLwnNE+1W1XqiRx9CncMT
 BogeYPIvL9Lkq17+Kv9ExpXyOHdrHGB1ZYdKVl9zvfJV+T5y0BPV98kOpWB1+d66K3FX
 3AXwd8xQNFnoZyMsSsmaTNTIQ7iQ2iirqkiF+tU850BLli2CVBz+AybhoX8RGb2bzvua
 CkEaV6KKC+XktKo3VY1C2zerRg97jr2P5YGJ/jWm0L/P22j9BfBdCVNxXvHTQ5oEF39T
 DcEBmzaCLZHHH/uLlhFJb0ebV0DUXf0h+WSq9mqncECj/HCdn7N3kxQ31E7UL+gX7Nce XQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3kx0my47s3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Nov 2022 15:21:05 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9997710003A;
        Fri, 18 Nov 2022 15:21:00 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 92FEC231DE0;
        Fri, 18 Nov 2022 15:21:00 +0100 (CET)
Received: from localhost (10.201.20.178) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.32; Fri, 18 Nov
 2022 15:21:00 +0100
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
Subject: [PATCH 4/4] ARM: dts: stm32: add dfsdm node on stm32mp131
Date:   Fri, 18 Nov 2022 15:20:06 +0100
Message-ID: <20221118142006.479138-5-olivier.moysan@foss.st.com>
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

Add DFSDM peripheral support for the STM32MP13 SoC family.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
---
 arch/arm/boot/dts/stm32mp131.dtsi | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp131.dtsi b/arch/arm/boot/dts/stm32mp131.dtsi
index 5dd5bf47c92b..42be0e3176ae 100644
--- a/arch/arm/boot/dts/stm32mp131.dtsi
+++ b/arch/arm/boot/dts/stm32mp131.dtsi
@@ -316,6 +316,36 @@ sai2b: audio-controller@4400b024 {
 			};
 		};
 
+		dfsdm: dfsdm@4400d000 {
+			compatible = "st,stm32mp1-dfsdm";
+			reg = <0x4400d000 0x800>;
+			clocks = <&rcc DFSDM_K>;
+			clock-names = "dfsdm";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+
+			dfsdm0: filter@0 {
+				compatible = "st,stm32-dfsdm-adc";
+				reg = <0>;
+				#io-channel-cells = <1>;
+				interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
+				dmas = <&dmamux1 101 0x400 0x01>;
+				dma-names = "rx";
+				status = "disabled";
+			};
+
+			dfsdm1: filter@1 {
+				compatible = "st,stm32-dfsdm-adc";
+				reg = <1>;
+				#io-channel-cells = <1>;
+				interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>;
+				dmas = <&dmamux1 102 0x400 0x01>;
+				dma-names = "rx";
+				status = "disabled";
+			};
+		};
+
 		dma1: dma-controller@48000000 {
 			compatible = "st,stm32-dma";
 			reg = <0x48000000 0x400>;
-- 
2.25.1

