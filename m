Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2B86E181A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 01:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjDMXS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 19:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbjDMXST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 19:18:19 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A2BE1;
        Thu, 13 Apr 2023 16:18:18 -0700 (PDT)
Received: from [192.168.178.23] (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 4364BD0C54;
        Thu, 13 Apr 2023 23:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1681427895; bh=w9CMcpt8FL5D9w8gvtXVGIn+tTYwLetgcp8M0Diuyuc=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=GA3IvBxpJAo6GKEnnPNYlKRFUkbIsQmunIxLvJ75WuHm2ku1FsOaOjRJkljxzDczc
         KZt+DnRj5QkC8FdVou9jI55Hxnb5+mRT7+CQJmgMRSLb685c84gCM67ewZJ2FMhkwX
         KfNHfnqpak4Sp7t/Dx/NrdpBdH7NfoRmrKD5BA9s=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Fri, 14 Apr 2023 01:17:52 +0200
Subject: [PATCH 8/8] arm64: dts: qcom: sdm632-fairphone-fp3: Add
 notification LED
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230414-pmi632-v1-8-fe94dc414832@z3ntu.xyz>
References: <20230414-pmi632-v1-0-fe94dc414832@z3ntu.xyz>
In-Reply-To: <20230414-pmi632-v1-0-fe94dc414832@z3ntu.xyz>
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
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-iio@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1288; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=w9CMcpt8FL5D9w8gvtXVGIn+tTYwLetgcp8M0Diuyuc=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBkOI20vqSS20Hu+GzwUyPjrcf5yFn3OwoDcK3SW
 sCaPClRAjWJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZDiNtAAKCRBy2EO4nU3X
 VvGHEACde5l9XMhZEVg2BizwgTL7EgMa+l/mV+OnlBR0T1B8F5Z/mOM9azW5C1zJDKjzalN1uwT
 2mRnvm6OhVPvbtxZei4j2QtPattb1X3aPgz3mqtN+vplnMx+gaAk7XK/0Hq2J9vRyNfmgWhzzC0
 mV7gbGAHpnxPDjfnqIsX7rqfMPV4ZAP+ealRuPv/fo+H2tVzQC8UhgmX0ZBjHTDCWZDtWaiSkFz
 P7A2MqaHylCGawKs3U6rf1URhYIIM7EwWGkOcClWAyNPSb/oefqPUu6LYe5+wzzikG2b5zCsW46
 a4I0s1OblXvu7CMETCM6DJ91OAMgN6Qip+cjRnUYW6oiBvkMve5y0u7FkwSN3iwTALZ7L3JtW/g
 YnEIickkiqu5R2JKvM4UJZHfgQXIVdKJNHirhUKFNxPsXYFzO/ohvWPhjKG0r+ymUyVqbYm6MpO
 XsVEzCGwnIOBitQEYnAyhyIwb5vINMLDSTR5f4bMgxaShAFQHu4Ht+7ofZouyhsEayoihq8C1yJ
 zZ0CBwEZYb9xUOOpQSqvWFqJqZqr4pRW+kL6zCTeJsSupgfXLApStp10r//gnLVSFPIS1TmP04s
 Hoa/fMA0zklHXUqdNQb3sBUSUJOFcEijJGc85k8us+qxKaQGRlanda3yuZrI+utIkUFVxJXs9Ia
 UZvTK1LJCYvXaVg==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The phone features a notification LED connected to the pmi632. Configure
the RGB led found on it.

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
2.40.0

