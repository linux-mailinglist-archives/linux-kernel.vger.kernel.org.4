Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E13496DB235
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 19:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbjDGR6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 13:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231210AbjDGR6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 13:58:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6805C648;
        Fri,  7 Apr 2023 10:58:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D76460FA4;
        Fri,  7 Apr 2023 17:58:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73820C433D2;
        Fri,  7 Apr 2023 17:58:23 +0000 (UTC)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 06/10] arm64: dts: qcom: sdm845: remove superfluous "input-enable"
Date:   Fri,  7 Apr 2023 19:58:03 +0200
Message-Id: <20230407175807.124394-6-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230407175807.124394-1-krzysztof.kozlowski@linaro.org>
References: <20230407175807.124394-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pin configuration property "input-enable" was used with the intention to
disable the output, but this is done by default by Linux drivers.  Since
patch ("dt-bindings: pinctrl: qcom: tlmm should use output-disable, not
input-enable") the property is not accepted anymore.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi  | 3 ---
 arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts    | 2 --
 arch/arm64/boot/dts/qcom/sdm845-wcd9340.dtsi         | 1 -
 arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts   | 2 --
 arch/arm64/boot/dts/qcom/sdm845.dtsi                 | 5 -----
 arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts | 5 -----
 6 files changed, 18 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
index 0c268c560d37..e0c0c9090211 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
@@ -773,7 +773,6 @@ hall_sensor_default: hall-sensor-default-state {
 		function = "gpio";
 		drive-strength = <2>;
 		bias-disable;
-		input-enable;
 	};
 
 	tri_state_key_default: tri-state-key-default-state {
@@ -802,7 +801,6 @@ panel_te_pin: panel-te-state {
 		function = "mdp_vsync";
 		drive-strength = <2>;
 		bias-disable;
-		input-enable;
 	};
 
 	panel_esd_pin: panel-esd-state {
@@ -810,7 +808,6 @@ panel_esd_pin: panel-esd-state {
 		function = "gpio";
 		drive-strength = <2>;
 		bias-pull-down;
-		input-enable;
 	};
 
 	speaker_default: speaker-default-state {
diff --git a/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts b/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
index b54e304abf71..9d2ebb61b464 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
@@ -608,7 +608,6 @@ ts_int_active: ts-int-active-state {
 		function = "gpio";
 		drive-strength = <8>;
 		bias-pull-up;
-		input-enable;
 	};
 
 	ts_int_suspend: ts-int-suspend-state {
@@ -616,7 +615,6 @@ ts_int_suspend: ts-int-suspend-state {
 		function = "gpio";
 		drive-strength = <2>;
 		bias-pull-down;
-		input-enable;
 	};
 
 	ts_reset_active: ts-reset-active-state {
diff --git a/arch/arm64/boot/dts/qcom/sdm845-wcd9340.dtsi b/arch/arm64/boot/dts/qcom/sdm845-wcd9340.dtsi
index 0d7c37f39176..c15d48860646 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-wcd9340.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-wcd9340.dtsi
@@ -80,7 +80,6 @@ wcd_intr_default: wcd-intr-default-state {
 		pins = "gpio54";
 		function = "gpio";
 
-		input-enable;
 		bias-pull-down;
 		drive-strength = <2>;
 	};
diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
index 1b7fdbae6a2b..37844ecfbc2b 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
@@ -586,7 +586,6 @@ ts_int_default: ts-int-default-state {
 		function = "gpio";
 		bias-pull-down;
 		drive-strength = <16>;
-		input-enable;
 	};
 
 	ts_reset_sleep: ts-reset-sleep-state {
@@ -601,7 +600,6 @@ ts_int_sleep: ts-int-sleep-state {
 		function = "gpio";
 		bias-pull-down;
 		drive-strength = <2>;
-		input-enable;
 	};
 
 	sde_dsi_active: sde-dsi-active-state {
diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index da4b200281d8..d6a786c8b99f 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -3174,7 +3174,6 @@ quat_mi2s_sleep: quat-mi2s-sleep-state {
 				function = "gpio";
 				drive-strength = <2>;
 				bias-pull-down;
-				input-enable;
 			};
 
 			quat_mi2s_active: quat-mi2s-active-state {
@@ -3190,7 +3189,6 @@ quat_mi2s_sd0_sleep: quat-mi2s-sd0-sleep-state {
 				function = "gpio";
 				drive-strength = <2>;
 				bias-pull-down;
-				input-enable;
 			};
 
 			quat_mi2s_sd0_active: quat-mi2s-sd0-active-state {
@@ -3205,7 +3203,6 @@ quat_mi2s_sd1_sleep: quat-mi2s-sd1-sleep-state {
 				function = "gpio";
 				drive-strength = <2>;
 				bias-pull-down;
-				input-enable;
 			};
 
 			quat_mi2s_sd1_active: quat-mi2s-sd1-active-state {
@@ -3220,7 +3217,6 @@ quat_mi2s_sd2_sleep: quat-mi2s-sd2-sleep-state {
 				function = "gpio";
 				drive-strength = <2>;
 				bias-pull-down;
-				input-enable;
 			};
 
 			quat_mi2s_sd2_active: quat-mi2s-sd2-active-state {
@@ -3235,7 +3231,6 @@ quat_mi2s_sd3_sleep: quat-mi2s-sd3-sleep-state {
 				function = "gpio";
 				drive-strength = <2>;
 				bias-pull-down;
-				input-enable;
 			};
 
 			quat_mi2s_sd3_active: quat-mi2s-sd3-active-state {
diff --git a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
index 5c688cb6a7ce..1326c171fe72 100644
--- a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
+++ b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
@@ -606,7 +606,6 @@ i2c3_hid_active: i2c2-hid-active-state {
 		pins = "gpio37";
 		function = "gpio";
 
-		input-enable;
 		bias-pull-up;
 		drive-strength = <2>;
 	};
@@ -615,7 +614,6 @@ i2c5_hid_active: i2c5-hid-active-state {
 		pins = "gpio125";
 		function = "gpio";
 
-		input-enable;
 		bias-pull-up;
 		drive-strength = <2>;
 	};
@@ -624,7 +622,6 @@ i2c11_hid_active: i2c11-hid-active-state {
 		pins = "gpio92";
 		function = "gpio";
 
-		input-enable;
 		bias-pull-up;
 		drive-strength = <2>;
 	};
@@ -633,7 +630,6 @@ lid_pin_active: lid-pin-state {
 		pins = "gpio124";
 		function = "gpio";
 
-		input-enable;
 		bias-disable;
 	};
 
@@ -641,7 +637,6 @@ mode_pin_active: mode-pin-state {
 		pins = "gpio95";
 		function = "gpio";
 
-		input-enable;
 		bias-disable;
 	};
 };
-- 
2.34.1

