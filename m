Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C956F6F0D40
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 22:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344303AbjD0UfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 16:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344257AbjD0Uez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 16:34:55 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78FA43C16;
        Thu, 27 Apr 2023 13:34:54 -0700 (PDT)
Received: from [192.168.178.23] (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id C09CDCEC29;
        Thu, 27 Apr 2023 20:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1682627692; bh=u0OfrZ8JQA1K+eu8S043JANNKuvEBNwR1oXhG9a518k=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=mV7fmCgl5zkebzcbzU1H4v++iAKjmTa2v7aq56EgSEyyzJ97V5M2XdGoXxdc5bB3l
         WMkVXNQnlJKGtIew/BwWWRUR8pTxhnKNg8LfpmZ/X8jHlRbB7N4umQsvhsOousVKzV
         ZpzI6N/ZteBxGLVMjzo5h/e2jfFHDgBAl4EoaV8s=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Thu, 27 Apr 2023 22:34:29 +0200
Subject: [PATCH 4/4] ARM: dts: qcom: msm8974-hammerhead: Add vibrator
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230427-hammerhead-vibra-v1-4-e87eeb94da51@z3ntu.xyz>
References: <20230427-hammerhead-vibra-v1-0-e87eeb94da51@z3ntu.xyz>
In-Reply-To: <20230427-hammerhead-vibra-v1-0-e87eeb94da51@z3ntu.xyz>
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Brian Masney <masneyb@onstation.org>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1621; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=u0OfrZ8JQA1K+eu8S043JANNKuvEBNwR1oXhG9a518k=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBkStxqdiW+kWCefNLPPzqQpnvWWzkWAPLg7kJEW
 kuWJkM6I++JAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZErcagAKCRBy2EO4nU3X
 VhquEACXKd8YsE0/iZG3aV/sz4f2rfDYg2ZFsLJSkAmDG8FYnsH7qHaUf0AdidkoLUMrWGntbcJ
 zzTCUvbyr7fNXKKZhFMW/Y5RQot/4L7zGviNsyVyw7L8apKqyAnskyWbkWxg32feNKHkp924Z3f
 y0c2saXLto1l7SHskHaTPEohkM//l0gwcou+OcN3il4Iej3HvP5dQW7FOwcrGY4D82INL59x1Hz
 WYXomaitIzGgwcl1Qgs3rYAopoHwUk/PZzE/DI142JFU0d+3Swb00I9XovXIml/yMWOIfbKB8tq
 H8hl5Ja+z/v8FosPET5fAa6nZ7xtccXQXD/V1JC/C2puZhHGx3zfGjISuueILHpwyOMqZHo9QOl
 sA2o+u4Fzb+/mcDEDruM4A/bvDIpryN2HVHLQbjAnt+TIg1/CdM1ApmKQxJ6rdQ/+GLeD/Y+jXZ
 2CFthrIKmZ9rxHtuj9Px40dXCRJelef5Hyw21V1XKbEET/lvrkwtTlM8StP5VlRhHpCKHLuAyvS
 sCm/+3BXQnBoSd7mC+2m+B50OD4NdDErZe2eFW8max6E7GhN2bhtOmwg2EFPHjzPitVWgsX5t7z
 2MkVYKxlN20laGSY+Hqa+crLf968IMZr2cKH0I/IJfXOn/IIkungRbwBPIpRuaEUgkhTYaPBfP2
 KTIbBaABkLs6UqQ==
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

The Nexus 5 has a vibrator connected to the clock output of GP1_CLK
which we can use with the clk-pwm driver, then we can use that pwm with
pwm-vibrator to get haptics functionality.

This patch is based on Brian Masney's previous patch with clk-vibrator.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 .../dts/qcom-msm8974-lge-nexus5-hammerhead.dts     | 35 ++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts b/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
index ab35f2d644c0..fea8a6be9021 100644
--- a/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
+++ b/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
@@ -41,6 +41,25 @@ key-volume-down {
 		};
 	};
 
+	clk_pwm: pwm {
+		compatible = "clk-pwm";
+		clocks = <&mmcc CAMSS_GP1_CLK>;
+
+		pinctrl-0 = <&vibrator_pin>;
+		pinctrl-names = "default";
+
+		#pwm-cells = <2>;
+	};
+
+	vibrator {
+		compatible = "pwm-vibrator";
+		pwms = <&clk_pwm 0 100000>;
+		pwm-names = "enable";
+
+		vcc-supply = <&pm8941_l19>;
+		enable-gpios = <&tlmm 60 GPIO_ACTIVE_HIGH>;
+	};
+
 	vreg_wlan: wlan-regulator {
 		compatible = "regulator-fixed";
 
@@ -637,6 +656,22 @@ shutdown-pins {
 			function = "gpio";
 		};
 	};
+
+	vibrator_pin: vibrator-state {
+		core-pins {
+			pins = "gpio27";
+			function = "gp1_clk";
+			drive-strength = <6>;
+			bias-disable;
+		};
+
+		enable-pins {
+			pins = "gpio60";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-disable;
+		};
+	};
 };
 
 &usb {

-- 
2.40.0

