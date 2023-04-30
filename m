Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78E356F2A53
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Apr 2023 20:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbjD3SWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 14:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbjD3SWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 14:22:13 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78DA63A95;
        Sun, 30 Apr 2023 11:22:06 -0700 (PDT)
Received: from [192.168.178.23] (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id CB6AFCEC7E;
        Sun, 30 Apr 2023 18:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1682878892; bh=6bCrTKda13xPY5f1VJTbxhuiRyrVSBhJ2Q3JkSdwSwU=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=dpzZ866qVshjzoAdtJ+fwGoSuUs5QhvD5PkvqA3QrW9Ag3VM3jM1AJ8hLhA3XrTW1
         CDv8Df834l/u8zc13slqwInIDK8ERAkxBAGpHpxjFbQiF2TrXD9Q32BlXfuSji8uRR
         ViR/XEc7Vz2OOC7PTvDbmIzl+a7DtUeBwXMp58O0=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Sun, 30 Apr 2023 20:20:57 +0200
Subject: [PATCH 5/5] ARM: dts: qcom: apq8026-huawei-sturgeon: Add vibrator
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230430-drv260x-improvements-v1-5-1fb28b4cc698@z3ntu.xyz>
References: <20230430-drv260x-improvements-v1-0-1fb28b4cc698@z3ntu.xyz>
In-Reply-To: <20230430-drv260x-improvements-v1-0-1fb28b4cc698@z3ntu.xyz>
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Dan Murphy <dmurphy@ti.com>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Raffaele Tranquillini <raffaele.tranquillini@gmail.com>,
        Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1566; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=6bCrTKda13xPY5f1VJTbxhuiRyrVSBhJ2Q3JkSdwSwU=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBkTrGqMepVl5GlUtx/9cga8r2gsT8UvbaoHuuDc
 avyDq94ivuJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZE6xqgAKCRBy2EO4nU3X
 VqkBD/9v3tkZcH5QM/3qIv9jjRP3KRJMxw9KYu+KrkT21uShdAZxRoQ/Q4pztT99sxUcHZFtJpQ
 g6bNcsTKK5TPkiiUL5oJYZpkvFnC04jcQQ2O+r86sy72XmGco/8CN4t49M/1N0LMwaXgo9+IVx/
 y1tsr9//8aiMPsgt196tXGS8zKYFE5M+lD2j2xi7Z4NJGejCNnDMYvFvofz+icifvMouJde5atu
 SDUXwrDRsqSy081qvDilRaN1onJVDcnV0N+RQ4azFSI7uzIoLwwgFNh9aMwS14vmgkV43MIVzq0
 Olj+gjIZtZTBs92jCkN+ji5vku5dTRb2+dbY29SgLkFzQwuGf9PnG+AN2rOZXxG80AGUW3auJsZ
 iTRF5/ylGgln3q3Ff1gCcv5hHmqJsPJe5TZSKeGehJw9/0pzvcAfdeJDb+MLxqaVClz32Qx2BHL
 alFOi/mYdwM5+8J9cKIShzoBsNdHaD/UKJXd1NVJG3afV8Kla+Pi+l3blFf/x1J38caTex1w6Mv
 MKvx8Wri9/ZWp5eAYc8VxlKdgxN8h99kyG/3chOMKqUDWseFrPJ2LjqsVIyRwWTJKTkSwcOkFV8
 mGZHTPhXga32gABrs6vGeMHCu4VokS/vjffQdWNiJPrpIkcbPrtgWNfFhRMLjekTPoydQyhp+WN
 zL0N6RvrXN3eFMw==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The watch has a DRV2605 for haptics. Add a node for it based on the
values found in the downstream board file.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 arch/arm/boot/dts/qcom-apq8026-huawei-sturgeon.dts | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8026-huawei-sturgeon.dts b/arch/arm/boot/dts/qcom-apq8026-huawei-sturgeon.dts
index d64096028ab1..eb73b992a696 100644
--- a/arch/arm/boot/dts/qcom-apq8026-huawei-sturgeon.dts
+++ b/arch/arm/boot/dts/qcom-apq8026-huawei-sturgeon.dts
@@ -7,6 +7,7 @@
 
 #include "qcom-msm8226.dtsi"
 #include "qcom-pm8226.dtsi"
+#include <dt-bindings/input/ti-drv260x.h>
 
 /delete-node/ &adsp_region;
 
@@ -68,6 +69,26 @@ &adsp {
 	status = "okay";
 };
 
+&blsp1_i2c2 {
+	clock-frequency = <384000>;
+
+	status = "okay";
+
+	vibrator@5a {
+		compatible = "ti,drv2605";
+		reg = <0x5a>;
+		enable-gpios = <&tlmm 60 GPIO_ACTIVE_HIGH>;
+
+		mode = <DRV260X_ERM_MODE>;
+		library-sel = <DRV260X_ERM_LIB_D>;
+		vib-rated-mv = <2765>;
+		vib-overdrive-mv = <3525>;
+
+		pinctrl-0 = <&vibrator_default_state>;
+		pinctrl-names = "default";
+	};
+};
+
 &blsp1_i2c5 {
 	clock-frequency = <384000>;
 
@@ -347,6 +368,13 @@ reset-pins {
 		};
 	};
 
+	vibrator_default_state: vibrator-default-state {
+		pins = "gpio59", "gpio60";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-down;
+	};
+
 	wlan_hostwake_default_state: wlan-hostwake-default-state {
 		pins = "gpio66";
 		function = "gpio";

-- 
2.40.1

