Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34059737B5D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 08:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbjFUGeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 02:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjFUGdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 02:33:55 -0400
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B6E10CE;
        Tue, 20 Jun 2023 23:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
        s=default2211; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
        Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References;
        bh=T0dcoPCLaDYQMrHuXNE7wQ+1ki8yqQNoSM6auWBUDjc=; b=E9h898lDjNjzK8lBzgMNtgVZW7
        Q1u8bz6YxAzXDmDK5Uk9I4+mxh96D3YqWlRCe6T4SyoWk+IfVC0rVKcxgKOTWwbcDJCqNRGRYiSte
        ObFhLtecXOwsv3n/nec6/6/xRSDkUkFiAdL9CihZjDeF3a/L4i9MWKO9Lm0jyOrAQUjXgU7Zo56kb
        /X3XESgafWZPxDJoBuOi3Yl9iHPVLVhuYUfm3w95YjiqZij0zTbzl1FGj7jrB1tocC+gxlGpIIT72
        M0lReCenj3AnXFFn01nTbHoSF+zgXuyMnbw4IQyaF3HIBqfhaVKijUULZ2CD2gp/fcGTYVGxCT9ON
        yAYj21+g==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <sean@geanix.com>)
        id 1qBrPa-000Mcq-6U; Wed, 21 Jun 2023 08:33:50 +0200
Received: from [185.17.218.86] (helo=zen..)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sean@geanix.com>)
        id 1qBrPZ-0008i1-LM; Wed, 21 Jun 2023 08:33:49 +0200
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
Subject: [PATCH v2 1/8] ARM: dts: stm32: Add alternate pinmux for i2s pins
Date:   Wed, 21 Jun 2023 08:33:31 +0200
Message-Id: <20230621063339.1361073-1-sean@geanix.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.8/26945/Tue Jun 20 09:30:24 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add another mux option for i2s pins, this is used on Octavo OSD32MP1-RED board.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
Reviewed-by: Olivier Moysan <olivier.moysan@foss.st.com>
---
 arch/arm/boot/dts/stm32mp15-pinctrl.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi b/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
index e86d989dd351..d79f89f37bc7 100644
--- a/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
@@ -686,6 +686,25 @@ pins {
 		};
 	};
 
+	i2s2_pins_b: i2s2-1 {
+		pins {
+			pinmux = <STM32_PINMUX('C',  3, AF5)>, /* I2S2_SDO */
+				 <STM32_PINMUX('B', 12, AF5)>, /* I2S2_WS */
+				 <STM32_PINMUX('B', 13, AF5)>; /* I2S2_CK */
+			bias-disable;
+			drive-push-pull;
+			slew-rate = <1>;
+		};
+	};
+
+	i2s2_sleep_pins_b: i2s2-sleep-1 {
+		pins {
+			pinmux = <STM32_PINMUX('C', 3, ANALOG)>, /* I2S2_SDO */
+				 <STM32_PINMUX('B', 12, ANALOG)>, /* I2S2_WS */
+				 <STM32_PINMUX('B', 13, ANALOG)>; /* I2S2_CK */
+		};
+	};
+
 	ltdc_pins_a: ltdc-0 {
 		pins {
 			pinmux = <STM32_PINMUX('G',  7, AF14)>, /* LCD_CLK */
-- 
2.40.0

