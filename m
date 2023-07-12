Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3E0D750930
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 15:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233622AbjGLNET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 09:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233532AbjGLNDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 09:03:54 -0400
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DEF4213F;
        Wed, 12 Jul 2023 06:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
        s=default2211; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
        Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References;
        bh=gxB8tGPeDa3sr1zb5LyksqQoFxN4QnIufb+q5PKXGEI=; b=HJcLri3XxqrSM6i1xdHaQNZivm
        +rUVIjapD7TL2EIzPXzRmzcrxCGpiVF46MSqo5wpqRnf2jRIAbnHO8bqPZUzAer0x7/JzhevmIDnj
        tret5xZOY/qaPR4iuNJXMooHYrQ7F4yOPot6dtaOAhovf0LEJ9rKz7B81ZUfKaiwbSd0jNIESuwiO
        yGnvlA1LewT67dQCccAzN32WTgEHAe6is7T4pWFfeNwjZ+6mWxNkZOS24r5z9DfZSQZFruITgGmTu
        aEzSANaP9QBWId83pN3qfJ+Tspoi/pXG8xKfsgkZo1QpTemy8COopoi1VXV/0TZUUykW6kCq1c3P1
        l3RjX83g==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <sean@geanix.com>)
        id 1qJZBe-000NLh-2t; Wed, 12 Jul 2023 14:43:18 +0200
Received: from [185.17.218.86] (helo=zen..)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sean@geanix.com>)
        id 1qJZBd-000L9W-FH; Wed, 12 Jul 2023 14:43:17 +0200
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
Subject: [PATCH v4 1/9] ARM: dts: stm32: Add alternate pinmux for i2s pins
Date:   Wed, 12 Jul 2023 14:42:39 +0200
Message-Id: <20230712124248.2400862-1-sean@geanix.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.8/26967/Wed Jul 12 09:28:32 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add another mux option for i2s pins, this is used on Octavo OSD32MP1-RED board.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
Reviewed-by: Olivier Moysan <olivier.moysan@foss.st.com>
---
 arch/arm/boot/dts/st/stm32mp15-pinctrl.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/st/stm32mp15-pinctrl.dtsi b/arch/arm/boot/dts/st/stm32mp15-pinctrl.dtsi
index 098153ee99a3..92726ad7285f 100644
--- a/arch/arm/boot/dts/st/stm32mp15-pinctrl.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp15-pinctrl.dtsi
@@ -787,6 +787,25 @@ pins {
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

