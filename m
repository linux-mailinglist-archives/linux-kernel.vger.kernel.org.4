Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACD0A5EE22F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 18:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234182AbiI1Qn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 12:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234443AbiI1Qna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 12:43:30 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED6BE8DB4;
        Wed, 28 Sep 2022 09:43:18 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28SG4hp5005109;
        Wed, 28 Sep 2022 18:42:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=iyz5w+TWRIOyUqxHw7BoijPFfbfPlmmExF0v8d2qvpU=;
 b=oNdailhRN0kKKUE7CdtbnEjwZDcGMsuCPh7CJ5ah/trDpD+AG2lmaNB0DJqVhF6If94F
 NuGWhIiqWtPlm0BgxUvDGtVVk5FLkWGCLrtcoXOrdIPK2FJa8GvF8lMEv+P3fw9N5STH
 I2vbPEaASVW2TzbPUmLyXd404sYLy6L6iV3zKNsyr0iVpYqCYGRITVT1ID+n7Hoec/ei
 X9m+U+gyMfMLytkImPC9kzRzud3IFEA/i3rXlQ75z8miOrajS6TiYOOpe8k83GIjaJ/L
 7s41Qk+yLEo/jOYVQMdRYVr4XpxdCFw31gbWB4SBVNgHvsbZe/QGMjWBm48tgkLlDObn 3A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3jsrsjtp71-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Sep 2022 18:42:56 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E7B3B10002A;
        Wed, 28 Sep 2022 18:42:54 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E10AA23C6B4;
        Wed, 28 Sep 2022 18:42:54 +0200 (CEST)
Received: from localhost (10.75.127.119) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2375.31; Wed, 28 Sep
 2022 18:42:54 +0200
From:   Olivier Moysan <olivier.moysan@foss.st.com>
To:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        <nuno.sa@analog.com>, Olivier Moysan <olivier.moysan@foss.st.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Wan Jiabing <wanjiabing@vivo.com>,
        Yannick Brosseau <yannick.brosseau@gmail.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH 5/8] ARM: dts: stm32: add adc support to stm32mp13
Date:   Wed, 28 Sep 2022 18:41:11 +0200
Message-ID: <20220928164114.48339-6-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220928164114.48339-1-olivier.moysan@foss.st.com>
References: <20220928164114.48339-1-olivier.moysan@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.119]
X-ClientProxiedBy: GPXDAG2NODE4.st.com (10.75.127.68) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-28_07,2022-09-28_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ADC1 and ADC2 support to STM32MP13 SoC family.

The STM32MP131 provides only ADC2, while other STM32MP13 SoCs provide
both ADC1 and ADC2.

Internal channels support limitations:
- VREFINT internal channel requires calibration data from OTP memory.
  The nvmem properties used to access OTP are not defined for time being,
  as OTP support is not yet enabled.

- VBAT internal channel is not defined by default in SoC DT, and
  has be defined in board DT when needed, instead. This avoids unwanted
  current consumption on battery, when ADC conversions are performed
  on any other channels.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
---
 arch/arm/boot/dts/stm32mp131.dtsi | 43 +++++++++++++++++++++++++++++++
 arch/arm/boot/dts/stm32mp133.dtsi | 31 ++++++++++++++++++++++
 2 files changed, 74 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp131.dtsi b/arch/arm/boot/dts/stm32mp131.dtsi
index 3a921db23e9f..5e46234f60f2 100644
--- a/arch/arm/boot/dts/stm32mp131.dtsi
+++ b/arch/arm/boot/dts/stm32mp131.dtsi
@@ -153,6 +153,49 @@ dmamux1: dma-router@48002000 {
 			dma-channels = <16>;
 		};
 
+		adc_2: adc@48004000 {
+			compatible = "st,stm32mp13-adc-core";
+			reg = <0x48004000 0x400>;
+			interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&rcc ADC2>, <&rcc ADC2_K>;
+			clock-names = "bus", "adc";
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+
+			adc2: adc@0 {
+				compatible = "st,stm32mp13-adc";
+				#io-channel-cells = <1>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <0x0>;
+				interrupt-parent = <&adc_2>;
+				interrupts = <0>;
+				dmas = <&dmamux1 10 0x400 0x80000001>;
+				dma-names = "rx";
+				status = "disabled";
+
+				channel@13 {
+					reg = <13>;
+					label = "vrefint";
+				};
+				channel@14 {
+					reg = <14>;
+					label = "vddcore";
+				};
+				channel@16 {
+					reg = <16>;
+					label = "vddcpu";
+				};
+				channel@17 {
+					reg = <17>;
+					label = "vddq_ddr";
+				};
+			};
+		};
+
 		rcc: rcc@50000000 {
 			compatible = "st,stm32mp13-rcc", "syscon";
 			reg = <0x50000000 0x1000>;
diff --git a/arch/arm/boot/dts/stm32mp133.dtsi b/arch/arm/boot/dts/stm32mp133.dtsi
index 531c263c9f46..6bc702fe43af 100644
--- a/arch/arm/boot/dts/stm32mp133.dtsi
+++ b/arch/arm/boot/dts/stm32mp133.dtsi
@@ -8,6 +8,37 @@
 
 / {
 	soc {
+		adc_1: adc@48003000 {
+			compatible = "st,stm32mp13-adc-core";
+			reg = <0x48003000 0x400>;
+			interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&rcc ADC1>, <&rcc ADC1_K>;
+			clock-names = "bus", "adc";
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+
+			adc1: adc@0 {
+				compatible = "st,stm32mp13-adc";
+				#io-channel-cells = <1>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <0x0>;
+				interrupt-parent = <&adc_1>;
+				interrupts = <0>;
+				dmas = <&dmamux1 9 0x400 0x80000001>;
+				dma-names = "rx";
+				status = "disabled";
+
+				channel@18 {
+					reg = <18>;
+					label = "vrefint";
+				};
+			};
+		};
+
 		m_can1: can@4400e000 {
 			compatible = "bosch,m_can";
 			reg = <0x4400e000 0x400>, <0x44011000 0x1400>;
-- 
2.25.1

