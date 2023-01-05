Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25F7D65EC41
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 14:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbjAENHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 08:07:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234157AbjAENHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 08:07:00 -0500
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7555C5AC6B;
        Thu,  5 Jan 2023 05:06:58 -0800 (PST)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3058te4E026036;
        Thu, 5 Jan 2023 14:06:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=TSIzgbHtncvPwUqh2BWBdQd6A+F2LEY+VIn6KnADCj8=;
 b=0zC/6MuW7LZGEEmbcs0c6uGgzutsoy8p/FY4BsXA3FK36aAZQAAOw1NrZQZAp3QLqyy2
 hcfOMOtPCxlFM1PNN7HS/pXKczblIOKZnKQGF0MRTuM+AMK7uGvWemo+QJ4PfFytT9r+
 PVCPEH4XzLwcesWrZ2hK5f/Is8U0XRQRRAbgpT/LoHGSQmdPpaxC4/3+4oJUX8YPdvIE
 1nsi/QCSHs0MsVFPYlbxh8ksJOzRKcqEqXxBJDU6htKInuFQ12VXoXHqWKQ3oUmJyin7
 EusllzXZabqSMtK6htheMyrHozWIlisyELinrug6i+PkIz5PeqWvvEBZQAoIrj8P/BcY Hw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3mtbcq94y9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Jan 2023 14:06:50 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id AABB710002A;
        Thu,  5 Jan 2023 14:06:49 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A4F3523BDEB;
        Thu,  5 Jan 2023 14:06:49 +0100 (CET)
Received: from localhost (10.201.20.178) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.13; Thu, 5 Jan
 2023 14:06:49 +0100
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
Subject: [PATCH 2/3] ARM: dts: stm32: add timer pins muxing for stm32mp135f-dk
Date:   Thu, 5 Jan 2023 14:06:10 +0100
Message-ID: <20230105130612.330155-3-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230105130612.330155-1-olivier.moysan@foss.st.com>
References: <20230105130612.330155-1-olivier.moysan@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.20.178]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-05_04,2023-01-04_02,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add timer pins muxing for stm32mp135f-dk board.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
---
 arch/arm/boot/dts/stm32mp13-pinctrl.dtsi | 60 ++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp13-pinctrl.dtsi b/arch/arm/boot/dts/stm32mp13-pinctrl.dtsi
index d377d4c0bef5..b2dce3a29f39 100644
--- a/arch/arm/boot/dts/stm32mp13-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stm32mp13-pinctrl.dtsi
@@ -54,6 +54,66 @@ pins {
 		};
 	};
 
+	pwm3_pins_a: pwm3-0 {
+		pins {
+			pinmux = <STM32_PINMUX('B', 1, AF2)>; /* TIM3_CH4 */
+			bias-pull-down;
+			drive-push-pull;
+			slew-rate = <0>;
+		};
+	};
+
+	pwm3_sleep_pins_a: pwm3-sleep-0 {
+		pins {
+			pinmux = <STM32_PINMUX('B', 1, ANALOG)>; /* TIM3_CH4 */
+		};
+	};
+
+	pwm4_pins_a: pwm4-0 {
+		pins {
+			pinmux = <STM32_PINMUX('D', 13, AF2)>; /* TIM4_CH2 */
+			bias-pull-down;
+			drive-push-pull;
+			slew-rate = <0>;
+		};
+	};
+
+	pwm4_sleep_pins_a: pwm4-sleep-0 {
+		pins {
+			pinmux = <STM32_PINMUX('D', 13, ANALOG)>; /* TIM4_CH2 */
+		};
+	};
+
+	pwm8_pins_a: pwm8-0 {
+		pins {
+			pinmux = <STM32_PINMUX('E', 5, AF3)>; /* TIM8_CH3 */
+			bias-pull-down;
+			drive-push-pull;
+			slew-rate = <0>;
+		};
+	};
+
+	pwm8_sleep_pins_a: pwm8-sleep-0 {
+		pins {
+			pinmux = <STM32_PINMUX('E', 5, ANALOG)>; /* TIM8_CH3 */
+		};
+	};
+
+	pwm14_pins_a: pwm14-0 {
+		pins {
+			pinmux = <STM32_PINMUX('F', 9, AF9)>; /* TIM14_CH1 */
+			bias-pull-down;
+			drive-push-pull;
+			slew-rate = <0>;
+		};
+	};
+
+	pwm14_sleep_pins_a: pwm14-sleep-0 {
+		pins {
+			pinmux = <STM32_PINMUX('F', 9, ANALOG)>; /* TIM14_CH1 */
+		};
+	};
+
 	sdmmc1_b4_pins_a: sdmmc1-b4-0 {
 		pins {
 			pinmux = <STM32_PINMUX('C', 8, AF12)>, /* SDMMC1_D0 */
-- 
2.25.1

