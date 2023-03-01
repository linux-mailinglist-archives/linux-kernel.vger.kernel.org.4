Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63E926A6948
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 09:57:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbjCAI5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 03:57:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjCAI5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 03:57:45 -0500
X-Greylist: delayed 129 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 01 Mar 2023 00:57:40 PST
Received: from out203-205-221-210.mail.qq.com (out203-205-221-210.mail.qq.com [203.205.221.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E50339CE5;
        Wed,  1 Mar 2023 00:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1677661058;
        bh=JZCUr280TVXOzIU/SeraWYs3TeNzUiZ+HfvsNis9eW0=;
        h=From:To:Cc:Subject:Date;
        b=mo4D/VvIpXd7CoGk2vBu+tIzKk6b1/bGZRHhwby+4AKk5+Tu+fOjk0cvbllGOpJRG
         vx89SXXOY8OPoE8MsPXXAICYL9UsJJjmKgvrLEdMYM8/FY9kpHborI4RzbXMTfL52b
         EBTfxft+gNaWlfSHu1t/6xmOFFRFMP/QfXWHJmGI=
Received: from DESKTOP-ZMX.localdomain ([115.156.140.94])
        by newxmesmtplogicsvrszc2-1.qq.com (NewEsmtp) with SMTP
        id D7505019; Wed, 01 Mar 2023 16:53:53 +0800
X-QQ-mid: xmsmtpt1677660833tmme4ifea
Message-ID: <tencent_7036BCA256055D05F8C49D86DF7F0E2D1A05@qq.com>
X-QQ-XMAILINFO: MjPUT8lqGkgpRDW5LrkbLrR2FcGhaYdB26ailGldwavnWDIoQSdYBMY78Msis2
         5+7xbQJIFDBIw0+1Uwbn5Cn485VI6egZDNqM09fi/lzykWmSqnng2llksq71fISVYfYbX+15a7nW
         153euhMqZ6PoinVGdlLK0sGPPVWhwk4Cmg9L4aRstc9MnAwqZmJ8z41bcbr5CA+Hq2ctcNzu8ewN
         FUklrhQyIiU54Pu7ll3P4IzA5NdCIPL9/6ejcus8MjaFVIOFKdm/jmTvFGp4jR6Sj6gqFyf+t0Dc
         Fi/g8GBXpyvXTbHkr/PAQPnC6Qo57cTGzpMhLvi4BJ1PdIVbv2HrEhgZo0v/lBvbzSZSsv4MMil2
         ArL7zmhGv7L/b0X3/4gdvaJ+jhiVKBpdOWcgXNfq953Jc8A4jQ2WSVg5IczbyEKDu3rquJauTYUV
         q026jA0Aa9uPn0UtoNx31ocWFzqe9URUQIe9KqKfs97wlVc/zSzuwc7VMtZ+feoHgfF7M3AjUnJY
         xWwsasIfXE1iFaf1XD6hA9AN+fv4Yrg/M6CPVmXyPtJrGGJjgUe//blUUIYI29dyhuasJUJ7TwDA
         UWPr8dbJiCPXVaQPn7vyYsvFfBYUWWcahSwn1P11P/jx+exqv8JVMBkRcrJsnA8u8nJubZvaYMk0
         wSYUwchl8WeupGgtKYSx1i3JN8uym0vGh8fOFgFqPAAHmrA5zF5C6Y2+ls9X+Y5VQQn9848FyUuU
         au1J/vKb47o6l6n67wvzfwjEHDeUBf59WVJ5RRqM7sCUznEhweK/iP96PMapHZhLYpWxXx+bDmwz
         a/t2HF1hZSfd7MtxyBsxaDWiBigmalF9oXvmFp/9JpfwV8QlUqao6QixQyvSu6L/fBN1VfeaS0HI
         O65a9PwLBRBbhSGTVuTipGqBEG3ZEUd3VS+2VNbHjFOctWM+FPLV3ip83NpSSFuzrZUKz5R7Odmc
         P3MT4PX5Dfc8u7KqodyQwqs7qY0EvxkFYn2Dcp0d+dIus5UsQ3SGUqKdeQx/bw
From:   Yang Xiwen <forbidden405@foxmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jaime Breva <jbreva@nayarsystems.com>,
        Yang Xiwen <forbidden405@foxmail.com>,
        Nikita Travkin <nikita@trvn.ru>,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: [PATCH] arm64: dts: qcom: msm8916-ufi: Fix sim card selection pinctrl
Date:   Wed,  1 Mar 2023 16:53:50 +0800
X-OQ-MSGID: <20230301085350.15512-1-forbidden405@foxmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        RCVD_IN_SBL_CSS,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The previous commit mistakenly introduced sim_ctrl_default as pinctrl,
this is incorrect, the interface for sim card selection varies between
different devices and should not be placed in the dtsi.

This commit selects external SIM card slot for ufi001c as default.
uf896 selects the correct SIM card slot automatically, thus does not need
this pinctrl node.

Fixes: faf69431464b ("arm64: dts: qcom: msm8916-thwc: Add initial device trees")
Signed-off-by: Yang Xiwen <forbidden405@foxmail.com>
---
 .../boot/dts/qcom/msm8916-thwc-uf896.dts      |  4 ---
 .../boot/dts/qcom/msm8916-thwc-ufi001c.dts    | 28 +++++++++++++++++--
 arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi     | 10 -------
 3 files changed, 26 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-thwc-uf896.dts b/arch/arm64/boot/dts/qcom/msm8916-thwc-uf896.dts
index c492db8561904..82e260375174d 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-thwc-uf896.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-thwc-uf896.dts
@@ -33,7 +33,3 @@ &button_default {
 &gpio_leds_default {
 	pins = "gpio81", "gpio82", "gpio83";
 };
-
-&sim_ctrl_default {
-	pins = "gpio1", "gpio2";
-};
diff --git a/arch/arm64/boot/dts/qcom/msm8916-thwc-ufi001c.dts b/arch/arm64/boot/dts/qcom/msm8916-thwc-ufi001c.dts
index 700cf81cbf8c0..8433c9710b1cf 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-thwc-ufi001c.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-thwc-ufi001c.dts
@@ -25,6 +25,11 @@ &led_b {
 	gpios = <&msmgpio 20 GPIO_ACTIVE_HIGH>;
 };
 
+&mpss {
+	pinctrl-0 = <&sim_ctrl_default>;
+	pinctrl-names = "default";
+};
+
 &button_default {
 	pins = "gpio37";
 	bias-pull-down;
@@ -34,6 +39,25 @@ &gpio_leds_default {
 	pins = "gpio20", "gpio21", "gpio22";
 };
 
-&sim_ctrl_default {
-	pins = "gpio1", "gpio2";
+/* This selects the external SIM card slot by default */
+&msmgpio {
+	sim_ctrl_default: sim-ctrl-default-state {
+		esim-sel-pins {
+			pins = "gpio0", "gpio3";
+			bias-disable;
+			output-low;
+		};
+
+		sim-en-pins {
+			pins = "gpio1";
+			bias-disable;
+			output-low;
+		};
+
+		sim-sel-pins {
+			pins = "gpio2";
+			bias-disable;
+			output-high;
+		};
+	};
 };
diff --git a/arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi b/arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi
index 790a9696da9de..cdf34b74fa8fa 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi
@@ -92,9 +92,6 @@ &gcc {
 };
 
 &mpss {
-	pinctrl-0 = <&sim_ctrl_default>;
-	pinctrl-names = "default";
-
 	status = "okay";
 };
 
@@ -240,11 +237,4 @@ gpio_leds_default: gpio-leds-default-state {
 		drive-strength = <2>;
 		bias-disable;
 	};
-
-	sim_ctrl_default: sim-ctrl-default-state {
-		function = "gpio";
-		drive-strength = <2>;
-		bias-disable;
-		output-low;
-	};
 };
-- 
2.39.1

