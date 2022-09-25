Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C094F5E952B
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 19:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232142AbiIYR5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 13:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbiIYR5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 13:57:10 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6760E27CF1;
        Sun, 25 Sep 2022 10:57:09 -0700 (PDT)
Received: from g550jk.. (2a02-8388-6582-fe80-0000-0000-0000-0006.cable.dynamic.v6.surfer.at [IPv6:2a02:8388:6582:fe80::6])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 91113C6FA5;
        Sun, 25 Sep 2022 17:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1664128597; bh=Kc0NJqkKtqH6tjfWTTCzXyBx6K9bYu22ZzH8VqMyDBw=;
        h=From:To:Cc:Subject:Date;
        b=e0/cmwa5Y9X0BrY9ODgSr1SGVIV9pVmqZC5/nuzWZOlCIJDBSFnMJmINKVwI7xk7p
         9cBJ9kvVLYaXMrv2RzPiROKgBa+owaxnnSNGSw/2z4WQ9fw+1O8TkyzPD+6Z5JcBde
         t5F4Whi3IphBoiiTuV9MLmo3v8K+HKbfxCpjjMd8=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: qcom: msm8974-sony-*: fix multi-led node name
Date:   Sun, 25 Sep 2022 19:56:30 +0200
Message-Id: <20220925175631.103535-1-luca@z3ntu.xyz>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        FROM_SUSPICIOUS_NTLD_FP,SPF_HELO_NONE,SPF_PASS,T_PDS_OTHER_BAD_TLD
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The name rgb-led is not allowed, multi-led is supposed to be used.

<snip>/arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine-amami.dtb: pm8941@1: pwm: 'rgb-led' does not match any of the regexes: '^led@[0-9a-f]$', 'pinctrl-[0-9]+'
        From schema: <snip>/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine.dtsi           | 2 +-
 .../arm/boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dts | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine.dtsi b/arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine.dtsi
index 5a70683d9103..c1d97190ea71 100644
--- a/arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine.dtsi
@@ -178,7 +178,7 @@ &pm8941_lpg {
 
 	qcom,power-source = <1>;
 
-	rgb-led {
+	multi-led {
 		color = <LED_COLOR_ID_RGB>;
 		function = LED_FUNCTION_STATUS;
 
diff --git a/arch/arm/boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dts b/arch/arm/boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dts
index 85348562e861..94daa1a3240a 100644
--- a/arch/arm/boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dts
+++ b/arch/arm/boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dts
@@ -295,7 +295,7 @@ &pm8941_lpg {
 
 	qcom,power-source = <1>;
 
-	rgb-led {
+	multi-led {
 		color = <LED_COLOR_ID_RGB>;
 		function = LED_FUNCTION_STATUS;
 
-- 
2.37.3

