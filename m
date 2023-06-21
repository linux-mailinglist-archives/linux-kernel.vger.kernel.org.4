Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D73F737B7C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 08:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbjFUGeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 02:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjFUGdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 02:33:55 -0400
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D6E10D5;
        Tue, 20 Jun 2023 23:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
        s=default2211; h=Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=2CrDY7R+Zqndz7jiijGinHpgv4VdmR4fNUdaajMT4/0=; b=YzirQapaEBcwUEGqksc279sAZg
        hlI2WIqWdigyPJsBP25Yt+6ilDyGd4GCtjpY/R6Z9/5huk5nDuyTcBP9FvkJ6UV9xjDF190hdHT17
        k1za3codVCjPJB1GzpVJdpbAbwZSCOEke8FQrfwbUmWqjbgsQgq9FFuXhdZe3os4uZ0c4rVMqx21W
        jl8rdEhQwRlis8TxdgKH9U4CfZ72YokELRWfPBAxN1c8SRtiv4wyVzDK2mcdjt9a7HwQSRdBEBm+S
        VRIyj1WHYZUt0lpDDBoQlna3oZsuaAMD/tK9YpJYZosqwe4H0ki+tJA9u0dzMoXEUsEkGY8xysmPW
        xiKlXWFQ==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <sean@geanix.com>)
        id 1qBrPb-000Mcx-2Y; Wed, 21 Jun 2023 08:33:51 +0200
Received: from [185.17.218.86] (helo=zen..)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sean@geanix.com>)
        id 1qBrPa-0008i1-G3; Wed, 21 Jun 2023 08:33:50 +0200
From:   Sean Nyekjaer <sean@geanix.com>
To:     a.fatoum@pengutronix.de, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     Sean Nyekjaer <sean@geanix.com>, dantuguf14105@gmail.com,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/8] ARM: dts: stm32: Add alternate pinmux for ldtc pins
Date:   Wed, 21 Jun 2023 08:33:32 +0200
Message-Id: <20230621063339.1361073-2-sean@geanix.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230621063339.1361073-1-sean@geanix.com>
References: <20230621063339.1361073-1-sean@geanix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.8/26945/Tue Jun 20 09:30:24 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
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
 arch/arm/boot/dts/stm32mp15-pinctrl.dtsi | 75 ++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi b/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
index d79f89f37bc7..422db6dd466c 100644
--- a/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
@@ -979,6 +979,81 @@ pins {
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

