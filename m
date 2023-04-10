Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB3D06DCA81
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 20:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbjDJSKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 14:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbjDJSKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 14:10:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67878CF;
        Mon, 10 Apr 2023 11:10:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 064A261A5A;
        Mon, 10 Apr 2023 18:10:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FEDEC4339E;
        Mon, 10 Apr 2023 18:10:15 +0000 (UTC)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 3/3] ARM: dts: qcom: msm8974: remove superfluous "input-enable"
Date:   Mon, 10 Apr 2023 20:10:05 +0200
Message-Id: <20230410181005.25853-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230410181005.25853-1-krzysztof.kozlowski@linaro.org>
References: <20230410181005.25853-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
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
 arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts      | 2 --
 arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine.dtsi         | 1 -
 arch/arm/boot/dts/qcom-msm8974pro-oneplus-bacon.dts           | 1 -
 arch/arm/boot/dts/qcom-msm8974pro-samsung-klte.dts            | 4 ----
 .../boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dts   | 1 -
 5 files changed, 9 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts b/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
index ab35f2d644c0..861695cecf84 100644
--- a/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
+++ b/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
@@ -592,7 +592,6 @@ mpu6515_pin: mpu6515-state {
 		pins = "gpio73";
 		function = "gpio";
 		bias-disable;
-		input-enable;
 	};
 
 	touch_pin: touch-state {
@@ -602,7 +601,6 @@ int-pins {
 
 			drive-strength = <2>;
 			bias-disable;
-			input-enable;
 		};
 
 		reset-pins {
diff --git a/arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine.dtsi b/arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine.dtsi
index d3bec03b126c..68a2f9094e53 100644
--- a/arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine.dtsi
@@ -433,7 +433,6 @@ ts_int_pin: touch-int-state {
 		function = "gpio";
 		drive-strength = <2>;
 		bias-disable;
-		input-enable;
 	};
 
 	sdc1_on: sdc1-on-state {
diff --git a/arch/arm/boot/dts/qcom-msm8974pro-oneplus-bacon.dts b/arch/arm/boot/dts/qcom-msm8974pro-oneplus-bacon.dts
index 8d2a054d8fee..8230d0e1d95d 100644
--- a/arch/arm/boot/dts/qcom-msm8974pro-oneplus-bacon.dts
+++ b/arch/arm/boot/dts/qcom-msm8974pro-oneplus-bacon.dts
@@ -461,7 +461,6 @@ int-pins {
 			function = "gpio";
 			drive-strength = <2>;
 			bias-disable;
-			input-enable;
 		};
 
 		reset-pins {
diff --git a/arch/arm/boot/dts/qcom-msm8974pro-samsung-klte.dts b/arch/arm/boot/dts/qcom-msm8974pro-samsung-klte.dts
index b9698ffb66ca..eb505d6d7f31 100644
--- a/arch/arm/boot/dts/qcom-msm8974pro-samsung-klte.dts
+++ b/arch/arm/boot/dts/qcom-msm8974pro-samsung-klte.dts
@@ -704,7 +704,6 @@ hostwake-pins {
 			pins = "gpio75";
 			function = "gpio";
 			drive-strength = <16>;
-			input-enable;
 		};
 
 		devwake-pins {
@@ -760,14 +759,12 @@ cmd-data-pins {
 	i2c_touchkey_pins: i2c-touchkey-state {
 		pins = "gpio95", "gpio96";
 		function = "gpio";
-		input-enable;
 		bias-pull-up;
 	};
 
 	i2c_led_gpioex_pins: i2c-led-gpioex-state {
 		pins = "gpio120", "gpio121";
 		function = "gpio";
-		input-enable;
 		bias-pull-down;
 	};
 
@@ -781,7 +778,6 @@ gpioex_pin: gpioex-state {
 	wifi_pin: wifi-state {
 		pins = "gpio92";
 		function = "gpio";
-		input-enable;
 		bias-pull-down;
 	};
 
diff --git a/arch/arm/boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dts b/arch/arm/boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dts
index 04bc58d87abf..0f650ed31005 100644
--- a/arch/arm/boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dts
+++ b/arch/arm/boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dts
@@ -631,7 +631,6 @@ ts_int_pin: ts-int-pin-state {
 		function = "gpio";
 		drive-strength = <2>;
 		bias-disable;
-		input-enable;
 	};
 
 	bt_host_wake_pin: bt-host-wake-state {
-- 
2.34.1

