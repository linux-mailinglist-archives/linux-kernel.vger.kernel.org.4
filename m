Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC5036E69E8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 18:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232604AbjDRQn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 12:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232566AbjDRQnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 12:43:49 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0129173F;
        Tue, 18 Apr 2023 09:43:46 -0700 (PDT)
Received: from [192.168.178.23] (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id AAF81CB3AD;
        Tue, 18 Apr 2023 16:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1681836224; bh=w9CMcpt8FL5D9w8gvtXVGIn+tTYwLetgcp8M0Diuyuc=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=ZnDSLBBFeLdQ0Gm7dpIBk2y1Bt1WIOZsPvLP3SvHAMWXzOfgOhR/iUJxVdqrnUoWv
         omVXdNbDtxBqnS8Dray8d+uh4KOSWP6cc9A1BETDpEMVFe38meEhwwxa6sbcOF36KN
         9v8ILuCt60xYjHmNNQ7T+V3vfNLUFJPhR0fMwa/A=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Tue, 18 Apr 2023 18:43:23 +0200
Subject: [PATCH v2 7/8] arm64: dts: qcom: sdm632-fairphone-fp3: Add
 notification LED
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230414-pmi632-v2-7-98bafa909c36@z3ntu.xyz>
References: <20230414-pmi632-v2-0-98bafa909c36@z3ntu.xyz>
In-Reply-To: <20230414-pmi632-v2-0-98bafa909c36@z3ntu.xyz>
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
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-doc@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1288; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=w9CMcpt8FL5D9w8gvtXVGIn+tTYwLetgcp8M0Diuyuc=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBkPsi8vYlpY7wKs390Rhf/aagKnfQMiUzXfdHHy
 7gQbQcBUF6JAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZD7IvAAKCRBy2EO4nU3X
 VhIOD/9iI3TQwsiXjbb7iG6g7WlZ5/5asS7XXLBR4yCppvJErjPP6Rt84vrpk95AvNthJlf4mM0
 BshKczxyS7Fl5mJY/IYwVtvglJcdpiXhKhQFoOTlz1gR2qJCmyJrf0N1Ijlc1urgG2HdH4g+OLl
 zW4p7rfrfXxo9n8oWMUlpUmCf2dkbw6hq+1KqY92WGIkVzZlrSsoq8Uy38VUNrStzW2ZY3qAmQp
 dKd4omuTGDd58I2jVA1zfsGEPa8VrwRGaX/BpmxNmrNLtVMBi1wH+T53wiZ/dEnhMB/3EuMhDT7
 HpbnNeL6JARNTl9uNvJuz7DtTPY2CG0jW6skgUioeClH7Rfyccryh+HWjKAtnoWkgeATPGu5Xbj
 ZaE8s2DUurjnhgGbJk/KurFSVSnI3AekqP0TzNYhFOSwyjSyfhRhsEFz71nnpksFjVBCr5E5z+R
 1wwHKu+sLJroOZw+RM96RTRG18UAi8Q8ophnPYLni1+jeQWK9VNdGIEoo2+8uiJBaidpkz2svjY
 fk0LTzPnFcKRaBqO7phSPF976KSq4Dh9vVc1/tOIw4w+0T9qglWC5wiSbLBSsTyuW0H3V8IOw2q
 1K8Wmym+/7nJTjyWeQPWL25bjyEZmiimMM/h2wZAqObk0O6bcjYpAFe8sFly4j9zIomspgt3N6d
 /TM9W1RDCD3OhxA==
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

