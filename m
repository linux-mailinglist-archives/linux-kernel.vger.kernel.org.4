Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2022A63D4AF
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 12:34:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234767AbiK3Ld5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 06:33:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232226AbiK3LdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 06:33:12 -0500
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3C32B24F;
        Wed, 30 Nov 2022 03:32:12 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 964EBF53EF;
        Wed, 30 Nov 2022 03:31:42 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 4wOaUqSW06EL; Wed, 30 Nov 2022 03:31:41 -0800 (PST)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=puri.sm; s=comms;
        t=1669807901; bh=6x67qmLJQCj3lbasXYSdmsQWomk0eqRrMSoej+wwECc=;
        h=From:To:Cc:Subject:Date:From;
        b=LPIC92+jA0DV34i/vgAYFARuJsFlzYZqZ3/qMpv3Dj1r1Ecxm3G8TZTeJxwcFREKU
         8nNfMDvRxh4nvRjL5Ifly+VCs4wtRjqFxMYQxxcb4w5uthAmmyHOAAUHFNP8IWxCLL
         CEWfa9Fbw7TqQwC/R+wE4qEcjzEme1ONwEwpAhPtYc60zphCTYQLlYO8GfAmpaYZ4l
         dL9jTkfV/3PgEtfvfYIhZW9yu2ZEo2m/y9EkuOfczOuvnhcQUXafp8SVaV8BBXadSg
         c3nM3Pxb/JxLBqHobW71tLS202C46yNVHX/1+Fl9wRBCGXVwkAbcMvlOAqOlZTpstD
         xHXHRyKoiyiRw==
To:     robh@kernel.org, krzysztof.kozlowski@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com
Cc:     linux-imx@nxp.com, kernel@puri.sm, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, phone-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH v1] arm64: dts: imx8mq-librem5: use multicolor leds description for RGB led
Date:   Wed, 30 Nov 2022 12:31:24 +0100
Message-Id: <20221130113124.1558335-1-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As Documentation/leds/well-known-leds.txt says, "Phones usually have
multi-color status LED." Fix that for the Librem 5 mobile phone board.

Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---
 .../boot/dts/freescale/imx8mq-librem5.dtsi    | 32 +++++++++----------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
index ddf0e330dc7c..6895bcc12165 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
@@ -56,27 +56,27 @@ key-vol-up {
 	};
 
 	led-controller {
-		compatible = "pwm-leds";
+		compatible = "pwm-leds-multicolor";
 
-		led-0 {
+		multi-led {
+			color = <LED_COLOR_ID_RGB>;
 			function = LED_FUNCTION_STATUS;
-			color = <LED_COLOR_ID_BLUE>;
 			max-brightness = <248>;
-			pwms = <&pwm2 0 50000 0>;
-		};
 
-		led-1 {
-			function = LED_FUNCTION_STATUS;
-			color = <LED_COLOR_ID_GREEN>;
-			max-brightness = <248>;
-			pwms = <&pwm4 0 50000 0>;
-		};
+			led-0 {
+				color = <LED_COLOR_ID_BLUE>;
+				pwms = <&pwm2 0 50000 0>;
+			};
 
-		led-2 {
-			function = LED_FUNCTION_STATUS;
-			color = <LED_COLOR_ID_RED>;
-			max-brightness = <248>;
-			pwms = <&pwm3 0 50000 0>;
+			led-1 {
+				color = <LED_COLOR_ID_GREEN>;
+				pwms = <&pwm4 0 50000 0>;
+			};
+
+			led-2 {
+				color = <LED_COLOR_ID_RED>;
+				pwms = <&pwm3 0 50000 0>;
+			};
 		};
 	};
 
-- 
2.30.2

