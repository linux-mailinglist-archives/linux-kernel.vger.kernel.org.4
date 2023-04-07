Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4536DB22C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 19:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbjDGR6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 13:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjDGR6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 13:58:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDFA45B8B;
        Fri,  7 Apr 2023 10:58:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5950F6536A;
        Fri,  7 Apr 2023 17:58:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1251C433D2;
        Fri,  7 Apr 2023 17:58:15 +0000 (UTC)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 03/10] arm64: dts: qcom: msm8998: remove superfluous "input-enable"
Date:   Fri,  7 Apr 2023 19:58:00 +0200
Message-Id: <20230407175807.124394-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230407175807.124394-1-krzysztof.kozlowski@linaro.org>
References: <20230407175807.124394-1-krzysztof.kozlowski@linaro.org>
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
 arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dts           | 1 -
 arch/arm64/boot/dts/qcom/msm8998-oneplus-common.dtsi      | 1 -
 arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi | 2 --
 arch/arm64/boot/dts/qcom/msm8998-xiaomi-sagit.dts         | 3 ---
 4 files changed, 7 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dts b/arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dts
index 8b71b1f8f300..b35e2d9f428c 100644
--- a/arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dts
+++ b/arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dts
@@ -640,7 +640,6 @@ hall_sensor1_default: hall-sensor1-def-state {
 		function = "gpio";
 		bias-disable;
 		drive-strength = <2>;
-		input-enable;
 	};
 
 	ts_int_n: ts-int-n-state {
diff --git a/arch/arm64/boot/dts/qcom/msm8998-oneplus-common.dtsi b/arch/arm64/boot/dts/qcom/msm8998-oneplus-common.dtsi
index ce03c7c239e5..062d56c42385 100644
--- a/arch/arm64/boot/dts/qcom/msm8998-oneplus-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998-oneplus-common.dtsi
@@ -501,7 +501,6 @@ hall_sensor_default: hall-sensor-default-state {
 		function = "gpio";
 		drive-strength = <2>;
 		bias-disable;
-		input-enable;
 	};
 
 	ts_int_active: ts-int-active-state {
diff --git a/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi b/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi
index 8e1c25b15f57..687e96068cb2 100644
--- a/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi
@@ -844,7 +844,6 @@ tof_int_n: tof-int-n-state {
 		function = "gpio";
 		bias-pull-up;
 		drive-strength = <2>;
-		input-enable;
 	};
 
 	chat_cam_pwr_en: chat-cam-pwr-en-default-state {
@@ -873,7 +872,6 @@ acc_cover_open: acc-cover-open-state {
 		function = "gpio";
 		bias-disable;
 		drive-strength = <2>;
-		input-enable;
 	};
 
 	ts_int_n: ts-int-n-state {
diff --git a/arch/arm64/boot/dts/qcom/msm8998-xiaomi-sagit.dts b/arch/arm64/boot/dts/qcom/msm8998-xiaomi-sagit.dts
index 7956b151c7a4..2444b87fddf7 100644
--- a/arch/arm64/boot/dts/qcom/msm8998-xiaomi-sagit.dts
+++ b/arch/arm64/boot/dts/qcom/msm8998-xiaomi-sagit.dts
@@ -528,7 +528,6 @@ hall_sensor_default_state: hall-sensor-default-state {
 		function = "gpio";
 		drive-strength = <2>;
 		bias-disable;
-		input-enable;
 	};
 
 	mdss_dsi_active_state: mdss-dsi-active-state {
@@ -620,7 +619,6 @@ ts_active_state: ts-active-state {
 		function = "gpio";
 		drive-strength = <16>;
 		bias-pull-up;
-		input-enable;
 	};
 
 	ts_int_suspend_state: ts-int-suspend-state {
@@ -642,7 +640,6 @@ wcd_int_n_state: wcd-int-n-state {
 		function = "gpio";
 		bias-pull-down;
 		drive-strength = <2>;
-		input-enable;
 	};
 
 	wsa_leftspk_pwr_n_state: wsa-leftspk-pwr-n-state {
-- 
2.34.1

