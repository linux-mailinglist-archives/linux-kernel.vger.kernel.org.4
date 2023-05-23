Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6845870E6B2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 22:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238556AbjEWUls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 16:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbjEWUlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 16:41:44 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21BFFCA;
        Tue, 23 May 2023 13:41:43 -0700 (PDT)
Received: from [192.168.122.1] (84-115-214-73.cable.dynamic.surfer.at [84.115.214.73])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id CC7EFCFBBC;
        Tue, 23 May 2023 20:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1684874501; bh=TJ542YLeCftA/8fhg2JNrraJTBnWbaZkPbFnUwRol6g=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=R2/gMkK/PfFPy6GWRI1+HF3H+f1tCi0OIO/sVowniDPPouJuJwQ9Qg02BT4pFZNTQ
         62RRBGYRz2pLtyJFGo+PBzLQRcF/MLppm9OenHSBXUgru6Tp7BE7Oj1xjko+vPGopx
         /dpPFtqNduCw67zrz2vMp1t7+yuRcQ4/hPHDjisE=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Tue, 23 May 2023 22:41:29 +0200
Subject: [PATCH v3 2/3] arm64: dts: qcom: sdm632-fairphone-fp3: Add
 notification LED
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230414-pmi632-v3-2-079d2cada699@z3ntu.xyz>
References: <20230414-pmi632-v3-0-079d2cada699@z3ntu.xyz>
In-Reply-To: <20230414-pmi632-v3-0-079d2cada699@z3ntu.xyz>
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-doc@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1343; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=TJ542YLeCftA/8fhg2JNrraJTBnWbaZkPbFnUwRol6g=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBkbSUAAyJdMMoOpSMaz9C3Sn99T7YCw8ToXq945
 4IsslXJObKJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZG0lAAAKCRBy2EO4nU3X
 VkJVD/9YaYeyX9jGqe7/y/4fgdOOuMfD8EwIgbX9nwu5DF5ZjmGZB+zBdyGMWhQhLbw7PBh7QYb
 qIUjbeCRp6yhQUDaQmx7dLIW8EkhYtFnWnpPuZoeJuathLOggZ1LelZn9yoIGSEKNurIL6ZmK9D
 hg5lRqs5DAmrz7j9MJNLkXad/UoBWdZcyAxUrUOWd3UX2haujPhVkgg7K23qt+hpLKD0TyoBWvU
 WnYHJ7QME34UHsR0CXpkmVTfIZAugH4gwBgY3joI3S4ejXy/LVU8ibpmMUGdAyG7kgymVqHYmzr
 gRuW0FH44DHpcNL2ZYZUwbkfnZfHgQyC3gAhPkMvrnJI0Nw8H/DO9ZpqU77uKPsQ40sbKDBgCZ1
 Y5D7pO1e4kNu9e5cgfK1NoL7GP7YotlpUtWghsrBwfTA9oUedPcKieCFpC2Tktu9jWNTCCA/3z5
 4bdNf6/SjiEpypd3+XcJsBuumnPgsjJRNS2qUvT6ebEO7QFiF8YoXad28bEdo1D7HbkA9MyceAr
 DG3hujx4NyOiqcsG29b58fvG9HIscwL2U08/E3CRUPkMwg8sDsYsc3Mit31pRYxFo+4NIo2r7QK
 qrdedQ6cMy9rL3rLtagFVgBf2UKuVNpAeDxhXINoG17ON54iHyAFXygKvT+bBNq5+g33ZzaoUmK
 wjTL3OqBuLjqB1w==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The phone features a notification LED connected to the pmi632. Configure
the RGB led found on it.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 arch/arm64/boot/dts/qcom/sdm632-fairphone-fp3.dts | 29 +++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm632-fairphone-fp3.dts b/arch/arm64/boot/dts/qcom/sdm632-fairphone-fp3.dts
index 70e683b7e4fc..301eca9a4f31 100644
--- a/arch/arm64/boot/dts/qcom/sdm632-fairphone-fp3.dts
+++ b/arch/arm64/boot/dts/qcom/sdm632-fairphone-fp3.dts
@@ -4,8 +4,10 @@
  */
 /dts-v1/;
 
+#include <dt-bindings/leds/common.h>
 #include "sdm632.dtsi"
 #include "pm8953.dtsi"
+#include "pmi632.dtsi"
 
 / {
 	model = "Fairphone 3";
@@ -83,6 +85,33 @@ &pm8953_resin {
 	linux,code = <KEY_VOLUMEDOWN>;
 };
 
+&pmi632_lpg {
+	status = "okay";
+
+	multi-led {
+		color = <LED_COLOR_ID_RGB>;
+		function = LED_FUNCTION_STATUS;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		led@1 {
+			reg = <1>;
+			color = <LED_COLOR_ID_RED>;
+		};
+
+		led@2 {
+			reg = <2>;
+			color = <LED_COLOR_ID_GREEN>;
+		};
+
+		led@3 {
+			reg = <3>;
+			color = <LED_COLOR_ID_BLUE>;
+		};
+	};
+};
+
 &sdhc_1 {
 	status = "okay";
 	vmmc-supply = <&pm8953_l8>;

-- 
2.40.1

