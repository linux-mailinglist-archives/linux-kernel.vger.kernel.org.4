Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9763B750900
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 15:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233171AbjGLNBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 09:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232140AbjGLNBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 09:01:33 -0400
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A42171989;
        Wed, 12 Jul 2023 06:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
        s=default2211; h=Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=+Y4kSu2wkVxXryiUAVNTGzlJavNWW4dxpm+lqNsJ2EE=; b=Pkq5l5tQM/PlW5MiaisDw6foC+
        1q4aZELHRHizJ8wSYZ3nuxf4IZXYvgzYrzVqgheFEDnWmN0Ua3JU1VtQzBs3v+xaEJ/HhshC4Mgui
        p0uZ7oDb0+8pQ99EA8wIaijaxVHjD86x4e6IN0ZKKE9twJuaK9TOjT9QruNGz7abg/GBhESFC7zmz
        ehiISRdpq0DTR7dQGEDFRAtRIcUA3N+v2kANkrxZuAtag0GSbTl1xdbvvat6KAL8PWQg27WG++MLB
        gv8c46q04tnv9dodY1uyHoZlWnISQquC8nPp+Bryv5duz5vDnJuHdKWLv1Pgx1MUnpXiToxmTCAWl
        fyur0mtA==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <sean@geanix.com>)
        id 1qJZBf-000NLy-1o; Wed, 12 Jul 2023 14:43:19 +0200
Received: from [185.17.218.86] (helo=zen..)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sean@geanix.com>)
        id 1qJZBe-000L9W-B1; Wed, 12 Jul 2023 14:43:18 +0200
From:   Sean Nyekjaer <sean@geanix.com>
To:     l.goehrs@pengutronix.de, a.fatoum@pengutronix.de,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     Sean Nyekjaer <sean@geanix.com>, dantuguf14105@gmail.com,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/9] ARM: dts: stm32: Add alternate pinmux for ldtc pins
Date:   Wed, 12 Jul 2023 14:42:40 +0200
Message-Id: <20230712124248.2400862-2-sean@geanix.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230712124248.2400862-1-sean@geanix.com>
References: <20230712124248.2400862-1-sean@geanix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.8/26967/Wed Jul 12 09:28:32 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add another mux option for ltdc pins, this is used on Octavo OSD32MP1-RED
board.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
Reviewed-by: Olivier Moysan <olivier.moysan@foss.st.com>
---
 arch/arm/boot/dts/st/stm32mp15-pinctrl.dtsi | 75 +++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/arch/arm/boot/dts/st/stm32mp15-pinctrl.dtsi b/arch/arm/boot/dts/st/stm32mp15-pinctrl.dtsi
index 92726ad7285f..5de4ec547411 100644
--- a/arch/arm/boot/dts/st/stm32mp15-pinctrl.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp15-pinctrl.dtsi
@@ -1080,6 +1080,81 @@ pins {
 		};
 	};
 
+	ltdc_pins_e: ltdc-4 {
+		pins1 {
+			pinmux = <STM32_PINMUX('H',  2, AF14)>, /* LTDC_R0 */
+				 <STM32_PINMUX('H',  3, AF14)>, /* LTDC_R1 */
+				 <STM32_PINMUX('H',  8, AF14)>, /* LTDC_R2 */
+				 <STM32_PINMUX('H',  9, AF14)>, /* LTDC_R3 */
+				 <STM32_PINMUX('H', 10, AF14)>, /* LTDC_R4 */
+				 <STM32_PINMUX('C',  0, AF14)>, /* LTDC_R5 */
+				 <STM32_PINMUX('H', 12, AF14)>, /* LTDC_R6 */
+				 <STM32_PINMUX('E', 15, AF14)>, /* LTDC_R7 */
+				 <STM32_PINMUX('E', 14, AF13)>, /* LTDC_G0 */
+				 <STM32_PINMUX('E',  6, AF14)>, /* LTDC_G1 */
+				 <STM32_PINMUX('H', 13, AF14)>, /* LTDC_G2 */
+				 <STM32_PINMUX('H', 14, AF14)>, /* LTDC_G3 */
+				 <STM32_PINMUX('H',  4, AF14)>, /* LTDC_G4 */
+				 <STM32_PINMUX('I',  0, AF14)>, /* LTDC_G5 */
+				 <STM32_PINMUX('I',  1, AF14)>, /* LTDC_G6 */
+				 <STM32_PINMUX('I',  2, AF14)>, /* LTDC_G7 */
+				 <STM32_PINMUX('D',  9, AF14)>, /* LTDC_B0 */
+				 <STM32_PINMUX('G', 12, AF14)>, /* LTDC_B1 */
+				 <STM32_PINMUX('G', 10, AF14)>, /* LTDC_B2 */
+				 <STM32_PINMUX('D', 10, AF14)>, /* LTDC_B3 */
+				 <STM32_PINMUX('E', 12, AF14)>, /* LTDC_B4 */
+				 <STM32_PINMUX('A',  3, AF14)>, /* LTDC_B5 */
+				 <STM32_PINMUX('B',  8, AF14)>, /* LTDC_B6 */
+				 <STM32_PINMUX('D',  8, AF14)>, /* LTDC_B7 */
+				 <STM32_PINMUX('F', 10, AF14)>, /* LTDC_DE */
+				 <STM32_PINMUX('I',  9, AF14)>, /* LTDC_VSYNC */
+				 <STM32_PINMUX('I', 10, AF14)>; /* LTDC_HSYNC */
+			bias-disable;
+			drive-push-pull;
+			slew-rate = <0>;
+		};
+
+		pins2 {
+			pinmux = <STM32_PINMUX('G', 7, AF14)>; /* LTDC_CLK */
+			bias-disable;
+			drive-push-pull;
+			slew-rate = <1>;
+		};
+	};
+
+	ltdc_sleep_pins_e: ltdc-sleep-4 {
+		pins {
+			pinmux = <STM32_PINMUX('H',  2, ANALOG)>, /* LTDC_R0 */
+				 <STM32_PINMUX('H',  3, ANALOG)>, /* LTDC_R1 */
+				 <STM32_PINMUX('H',  8, ANALOG)>, /* LTDC_R2 */
+				 <STM32_PINMUX('H',  9, ANALOG)>, /* LTDC_R3 */
+				 <STM32_PINMUX('H', 10, ANALOG)>, /* LTDC_R4 */
+				 <STM32_PINMUX('C',  0, ANALOG)>, /* LTDC_R5 */
+				 <STM32_PINMUX('H', 12, ANALOG)>, /* LTDC_R6 */
+				 <STM32_PINMUX('E', 15, ANALOG)>, /* LTDC_R7 */
+				 <STM32_PINMUX('D',  9, ANALOG)>, /* LTDC_B0 */
+				 <STM32_PINMUX('G', 12, ANALOG)>, /* LTDC_B1 */
+				 <STM32_PINMUX('G', 10, ANALOG)>, /* LTDC_B2 */
+				 <STM32_PINMUX('D', 10, ANALOG)>, /* LTDC_B3 */
+				 <STM32_PINMUX('E', 12, ANALOG)>, /* LTDC_B4 */
+				 <STM32_PINMUX('A',  3, ANALOG)>, /* LTDC_B5 */
+				 <STM32_PINMUX('B',  8, ANALOG)>, /* LTDC_B6 */
+				 <STM32_PINMUX('D',  8, ANALOG)>, /* LTDC_B7 */
+				 <STM32_PINMUX('E', 14, ANALOG)>, /* LTDC_G0 */
+				 <STM32_PINMUX('E',  6, ANALOG)>, /* LTDC_G1 */
+				 <STM32_PINMUX('H', 13, ANALOG)>, /* LTDC_G2 */
+				 <STM32_PINMUX('H', 14, ANALOG)>, /* LTDC_G3 */
+				 <STM32_PINMUX('H',  4, ANALOG)>, /* LTDC_G4 */
+				 <STM32_PINMUX('I',  0, ANALOG)>, /* LTDC_G5 */
+				 <STM32_PINMUX('I',  1, ANALOG)>, /* LTDC_G6 */
+				 <STM32_PINMUX('I',  2, ANALOG)>, /* LTDC_G7 */
+				 <STM32_PINMUX('F', 10, ANALOG)>, /* LTDC_DE */
+				 <STM32_PINMUX('I',  9, ANALOG)>, /* LTDC_VSYNC */
+				 <STM32_PINMUX('I', 10, ANALOG)>, /* LTDC_HSYNC */
+				 <STM32_PINMUX('G',  7, ANALOG)>; /* LTDC_CLK */
+		};
+	};
+
 	mco1_pins_a: mco1-0 {
 		pins {
 			pinmux = <STM32_PINMUX('A', 13, AF2)>; /* MCO1 */
-- 
2.40.0

