Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72738725DD6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 13:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240492AbjFGL6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 07:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240484AbjFGL6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 07:58:04 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33EA81BE8
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 04:57:59 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lgo@pengutronix.de>)
        id 1q6rnP-0000Ng-Bo; Wed, 07 Jun 2023 13:57:47 +0200
Received: from [2a0a:edc0:0:1101:1d::39] (helo=dude03.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <lgo@pengutronix.de>)
        id 1q6rnN-005jGH-Lv; Wed, 07 Jun 2023 13:57:45 +0200
Received: from lgo by dude03.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <lgo@pengutronix.de>)
        id 1q6rnM-00CTeO-Jl; Wed, 07 Jun 2023 13:57:44 +0200
From:   =?UTF-8?q?Leonard=20G=C3=B6hrs?= <l.goehrs@pengutronix.de>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     kernel@pengutronix.de,
        =?UTF-8?q?Leonard=20G=C3=B6hrs?= <l.goehrs@pengutronix.de>,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 6/8] ARM: dts: stm32: Add pinmux groups for Linux Automation GmbH TAC
Date:   Wed,  7 Jun 2023 13:55:05 +0200
Message-Id: <20230607115508.2964574-6-l.goehrs@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230607115508.2964574-1-l.goehrs@pengutronix.de>
References: <20230607115508.2964574-1-l.goehrs@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: lgo@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pinmux groups required for the Linux Automation GmbH TAC.

Signed-off-by: Leonard Göhrs <l.goehrs@pengutronix.de>
---
 arch/arm/boot/dts/stm32mp15-pinctrl.dtsi | 129 +++++++++++++++++++++++
 1 file changed, 129 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi b/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
index e86d989dd351d..0c864461ca449 100644
--- a/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
@@ -6,6 +6,17 @@
 #include <dt-bindings/pinctrl/stm32-pinfunc.h>
 
 &pinctrl {
+	adc1_ain_pins_a: adc1-ain-0 {
+		pins {
+			pinmux = <STM32_PINMUX('F', 11, ANALOG)>, /* ADC1_INP2 */
+				 <STM32_PINMUX('B', 1, ANALOG)>, /* ADC1_INP5 */
+				 <STM32_PINMUX('B', 0, ANALOG)>, /* ADC1_INP9 */
+				 <STM32_PINMUX('C', 0, ANALOG)>, /* ADC1_INP10 */
+				 <STM32_PINMUX('C', 3, ANALOG)>, /* ADC1_INP13 */
+				 <STM32_PINMUX('A', 3, ANALOG)>; /* ADC1_INP15 */
+		};
+	};
+
 	adc1_in6_pins_a: adc1-in6-0 {
 		pins {
 			pinmux = <STM32_PINMUX('F', 12, ANALOG)>;
@@ -341,6 +352,46 @@ pins1 {
 		};
 	};
 
+	ethernet0_rgmii_pins_d: rgmii-1 {
+		pins1 {
+			pinmux = <STM32_PINMUX('G', 4, AF11)>, /* ETH_RGMII_GTX_CLK */
+				 <STM32_PINMUX('G', 13, AF11)>, /* ETH_RGMII_TXD0 */
+				 <STM32_PINMUX('G', 14, AF11)>, /* ETH_RGMII_TXD1 */
+				 <STM32_PINMUX('C', 2, AF11)>, /* ETH_RGMII_TXD2 */
+				 <STM32_PINMUX('E', 2, AF11)>, /* ETH_RGMII_TXD3 */
+				 <STM32_PINMUX('B', 11, AF11)>; /* ETH_RGMII_TX_CTL */
+			bias-disable;
+			drive-push-pull;
+			slew-rate = <2>;
+		};
+		pins2 {
+			pinmux = <STM32_PINMUX('C', 4, AF11)>, /* ETH_RGMII_RXD0 */
+				 <STM32_PINMUX('C', 5, AF11)>, /* ETH_RGMII_RXD1 */
+				 <STM32_PINMUX('H', 6, AF11)>, /* ETH_RGMII_RXD2 */
+				 <STM32_PINMUX('H', 7, AF11)>, /* ETH_RGMII_RXD3 */
+				 <STM32_PINMUX('A', 1, AF11)>, /* ETH_RGMII_RX_CLK */
+				 <STM32_PINMUX('A', 7, AF11)>; /* ETH_RGMII_RX_CTL */
+			bias-disable;
+		};
+	};
+
+	ethernet0_rgmii_sleep_pins_d: rgmii-sleep-1 {
+		pins1 {
+			pinmux = <STM32_PINMUX('G', 4, ANALOG)>, /* ETH_RGMII_GTX_CLK */
+				 <STM32_PINMUX('G', 13, ANALOG)>, /* ETH_RGMII_TXD0 */
+				 <STM32_PINMUX('G', 14, ANALOG)>, /* ETH_RGMII_TXD1 */
+				 <STM32_PINMUX('C', 2, ANALOG)>, /* ETH_RGMII_TXD2 */
+				 <STM32_PINMUX('E', 2, ANALOG)>, /* ETH_RGMII_TXD3 */
+				 <STM32_PINMUX('B', 11, ANALOG)>, /* ETH_RGMII_TX_CTL */
+				 <STM32_PINMUX('C', 4, ANALOG)>, /* ETH_RGMII_RXD0 */
+				 <STM32_PINMUX('C', 5, ANALOG)>, /* ETH_RGMII_RXD1 */
+				 <STM32_PINMUX('H', 6, ANALOG)>, /* ETH_RGMII_RXD2 */
+				 <STM32_PINMUX('H', 7, ANALOG)>, /* ETH_RGMII_RXD3 */
+				 <STM32_PINMUX('A', 1, ANALOG)>, /* ETH_RGMII_RX_CLK */
+				 <STM32_PINMUX('A', 7, ANALOG)>; /* ETH_RGMII_RX_CTL */
+		 };
+	};
+
 	ethernet0_rmii_pins_a: rmii-0 {
 		pins1 {
 			pinmux = <STM32_PINMUX('G', 13, AF11)>, /* ETH1_RMII_TXD0 */
@@ -1104,6 +1155,20 @@ pins {
 		};
 	};
 
+	pwm1_pins_c: pwm1-2 {
+		pins {
+			pinmux = <STM32_PINMUX('E', 11, AF1)>; /* TIM1_CH2 */
+			drive-push-pull;
+			slew-rate = <0>;
+		};
+	};
+
+	pwm1_sleep_pins_c: pwm1-sleep-2 {
+		pins {
+			pinmux = <STM32_PINMUX('E', 11, ANALOG)>; /* TIM1_CH2 */
+		};
+	};
+
 	pwm2_pins_a: pwm2-0 {
 		pins {
 			pinmux = <STM32_PINMUX('A', 3, AF1)>; /* TIM2_CH4 */
@@ -1230,6 +1295,26 @@ pins {
 		};
 	};
 
+	pwm8_pins_b: pwm8-1 {
+		pins {
+			pinmux = <STM32_PINMUX('I', 5, AF3)>, /* TIM8_CH1 */
+				 <STM32_PINMUX('I', 6, AF3)>, /* TIM8_CH2 */
+				 <STM32_PINMUX('I', 7, AF3)>, /* TIM8_CH3 */
+				 <STM32_PINMUX('C', 9, AF3)>; /* TIM8_CH4 */
+			drive-push-pull;
+			slew-rate = <0>;
+		};
+	};
+
+	pwm8_sleep_pins_b: pwm8-sleep-1 {
+		pins {
+			pinmux = <STM32_PINMUX('I', 5, ANALOG)>, /* TIM8_CH1 */
+				 <STM32_PINMUX('I', 6, ANALOG)>, /* TIM8_CH2 */
+				 <STM32_PINMUX('I', 7, ANALOG)>, /* TIM8_CH3 */
+				 <STM32_PINMUX('C', 9, ANALOG)>; /* TIM8_CH4 */
+		};
+	};
+
 	pwm12_pins_a: pwm12-0 {
 		pins {
 			pinmux = <STM32_PINMUX('H', 6, AF2)>; /* TIM12_CH1 */
@@ -1925,6 +2010,20 @@ pins2 {
 		};
 	};
 
+	spi2_pins_c: spi2-2 {
+		pins1 {
+			pinmux = <STM32_PINMUX('I', 1, AF5)>, /* SPI2_SCK */
+				 <STM32_PINMUX('I', 3, AF5)>; /* SPI2_MOSI */
+			bias-disable;
+			drive-push-pull;
+		};
+
+		pins2 {
+			pinmux = <STM32_PINMUX('I', 2, AF5)>; /* SPI2_MISO */
+			bias-pull-down;
+		};
+	};
+
 	spi4_pins_a: spi4-0 {
 		pins {
 			pinmux = <STM32_PINMUX('E', 12, AF5)>, /* SPI4_SCK */
@@ -1939,6 +2038,21 @@ pins2 {
 		};
 	};
 
+	spi5_pins_a: spi5-0 {
+		pins1 {
+			pinmux = <STM32_PINMUX('F', 7, AF5)>, /* SPI5_SCK */
+				 <STM32_PINMUX('F', 9, AF5)>; /* SPI5_MOSI */
+			bias-disable;
+			drive-push-pull;
+			slew-rate = <1>;
+		};
+
+		pins2 {
+			pinmux = <STM32_PINMUX('F', 8, AF5)>; /* SPI5_MISO */
+			bias-disable;
+		};
+	};
+
 	stusb1600_pins_a: stusb1600-0 {
 		pins {
 			pinmux = <STM32_PINMUX('I', 11, GPIO)>;
@@ -2385,6 +2499,21 @@ pins {
 		};
 	};
 
+	usart3_pins_f: usart3-5 {
+		pins1 {
+			pinmux = <STM32_PINMUX('B', 10, AF7)>, /* USART3_TX */
+				 <STM32_PINMUX('D', 12, AF7)>; /* USART3_RTS */
+			bias-disable;
+			drive-push-pull;
+			slew-rate = <0>;
+		};
+		pins2 {
+			pinmux = <STM32_PINMUX('B', 12, AF8)>, /* USART3_RX */
+				 <STM32_PINMUX('D', 11, AF7)>; /* USART3_CTS_NSS */
+			bias-disable;
+		};
+	};
+
 	usbotg_hs_pins_a: usbotg-hs-0 {
 		pins {
 			pinmux = <STM32_PINMUX('A', 10, ANALOG)>; /* OTG_ID */
-- 
2.39.2

