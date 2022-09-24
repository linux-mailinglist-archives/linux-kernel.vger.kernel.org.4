Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 130B95E8E23
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 17:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233589AbiIXPq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 11:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbiIXPq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 11:46:26 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35FB33378;
        Sat, 24 Sep 2022 08:46:25 -0700 (PDT)
Received: from g550jk.fritz.box (212095005231.public.telering.at [212.95.5.231])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 85591C5454;
        Sat, 24 Sep 2022 15:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1664034384; bh=2qVah0NTVzbzDmE2/bG0X7crY2tbomDl2Bsriq7bfVM=;
        h=From:To:Cc:Subject:Date;
        b=ZCmY2e/dvACM4fMeFCaj/E8z8TMVUQFogGUwlMrcGwz5EOznVbct/ROW5QOe01KTc
         iGBVBXGp06ZruhwGCOHYMFKBcvCEFZz1peZUjBK2kxNkqr2FnqbnKrjI4D8AiYGQdP
         pYT4e/walVnXFzEB6r9mf6m8Dv/J1l0qYijhz/Ys=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: qcom: add 'chassis-type' property
Date:   Sat, 24 Sep 2022 17:44:22 +0200
Message-Id: <20220924154422.9896-1-luca@z3ntu.xyz>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        FROM_SUSPICIOUS_NTLD_FP,SPF_HELO_NONE,SPF_PASS,T_PDS_OTHER_BAD_TLD,
        URIBL_BLACK autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the chassis-type property to arm32 Qualcomm watches, phones and
tablets.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 arch/arm/boot/dts/qcom-apq8026-lg-lenok.dts                      | 1 +
 arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dts               | 1 +
 arch/arm/boot/dts/qcom-apq8064-sony-xperia-lagan-yuga.dts        | 1 +
 arch/arm/boot/dts/qcom-msm8226-samsung-s3ve3g.dts                | 1 +
 arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts         | 1 +
 arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine-amami.dts       | 1 +
 arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine-honami.dts      | 1 +
 arch/arm/boot/dts/qcom-msm8974pro-fairphone-fp2.dts              | 1 +
 arch/arm/boot/dts/qcom-msm8974pro-samsung-klte.dts               | 1 +
 arch/arm/boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dts | 1 +
 10 files changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8026-lg-lenok.dts b/arch/arm/boot/dts/qcom-apq8026-lg-lenok.dts
index 193569f0ca5f..bda9f6d84510 100644
--- a/arch/arm/boot/dts/qcom-apq8026-lg-lenok.dts
+++ b/arch/arm/boot/dts/qcom-apq8026-lg-lenok.dts
@@ -13,6 +13,7 @@
 / {
 	model = "LG G Watch R";
 	compatible = "lg,lenok", "qcom,apq8026";
+	chassis-type = "watch";
 	qcom,board-id = <132 0x0a>;
 	qcom,msm-id = <199 0x20000>;
 
diff --git a/arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dts b/arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dts
index fee278e32cb6..94fbc94dc7c8 100644
--- a/arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dts
+++ b/arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dts
@@ -6,6 +6,7 @@
 / {
 	model = "Asus Nexus7(flo)";
 	compatible = "asus,nexus7-flo", "qcom,apq8064";
+	chassis-type = "tablet";
 
 	aliases {
 		serial0 = &gsbi7_serial;
diff --git a/arch/arm/boot/dts/qcom-apq8064-sony-xperia-lagan-yuga.dts b/arch/arm/boot/dts/qcom-apq8064-sony-xperia-lagan-yuga.dts
index c07c5474750d..dcf735c6a842 100644
--- a/arch/arm/boot/dts/qcom-apq8064-sony-xperia-lagan-yuga.dts
+++ b/arch/arm/boot/dts/qcom-apq8064-sony-xperia-lagan-yuga.dts
@@ -8,6 +8,7 @@
 / {
 	model = "Sony Xperia Z";
 	compatible = "sony,xperia-yuga", "qcom,apq8064";
+	chassis-type = "handset";
 
 	aliases {
 		serial0 = &gsbi5_serial;
diff --git a/arch/arm/boot/dts/qcom-msm8226-samsung-s3ve3g.dts b/arch/arm/boot/dts/qcom-msm8226-samsung-s3ve3g.dts
index 290e1df631f0..6a082ad4418a 100644
--- a/arch/arm/boot/dts/qcom-msm8226-samsung-s3ve3g.dts
+++ b/arch/arm/boot/dts/qcom-msm8226-samsung-s3ve3g.dts
@@ -8,6 +8,7 @@
 / {
 	model = "Samsung Galaxy S III Neo";
 	compatible = "samsung,s3ve3g", "qcom,msm8226";
+	chassis-type = "handset";
 
 	aliases {
 		serial0 = &blsp1_uart3;
diff --git a/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts b/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
index 6daceaa87802..fdbcf84f173c 100644
--- a/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
+++ b/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
@@ -9,6 +9,7 @@
 / {
 	model = "LGE MSM 8974 HAMMERHEAD";
 	compatible = "lge,hammerhead", "qcom,msm8974";
+	chassis-type = "handset";
 
 	aliases {
 		serial0 = &blsp1_uart1;
diff --git a/arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine-amami.dts b/arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine-amami.dts
index 68d5626bf491..9f2ab5c122d0 100644
--- a/arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine-amami.dts
+++ b/arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine-amami.dts
@@ -4,6 +4,7 @@
 / {
 	model = "Sony Xperia Z1 Compact";
 	compatible = "sony,xperia-amami", "qcom,msm8974";
+	chassis-type = "handset";
 };
 
 &smbb {
diff --git a/arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine-honami.dts b/arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine-honami.dts
index ea6a941d8f8c..9028f17e5c4a 100644
--- a/arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine-honami.dts
+++ b/arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine-honami.dts
@@ -4,4 +4,5 @@
 / {
 	model = "Sony Xperia Z1";
 	compatible = "sony,xperia-honami", "qcom,msm8974";
+	chassis-type = "handset";
 };
diff --git a/arch/arm/boot/dts/qcom-msm8974pro-fairphone-fp2.dts b/arch/arm/boot/dts/qcom-msm8974pro-fairphone-fp2.dts
index ff6e0066768b..c4680358aaa3 100644
--- a/arch/arm/boot/dts/qcom-msm8974pro-fairphone-fp2.dts
+++ b/arch/arm/boot/dts/qcom-msm8974pro-fairphone-fp2.dts
@@ -9,6 +9,7 @@
 / {
 	model = "Fairphone 2";
 	compatible = "fairphone,fp2", "qcom,msm8974";
+	chassis-type = "handset";
 
 	aliases {
 		mmc0 = &sdhc_1;
diff --git a/arch/arm/boot/dts/qcom-msm8974pro-samsung-klte.dts b/arch/arm/boot/dts/qcom-msm8974pro-samsung-klte.dts
index 983e10c3d863..08c43bf86b92 100644
--- a/arch/arm/boot/dts/qcom-msm8974pro-samsung-klte.dts
+++ b/arch/arm/boot/dts/qcom-msm8974pro-samsung-klte.dts
@@ -8,6 +8,7 @@
 / {
 	model = "Samsung Galaxy S5";
 	compatible = "samsung,klte", "qcom,msm8974";
+	chassis-type = "handset";
 
 	aliases {
 		serial0 = &blsp1_uart1;
diff --git a/arch/arm/boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dts b/arch/arm/boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dts
index 3f45f5c5d37b..85348562e861 100644
--- a/arch/arm/boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dts
+++ b/arch/arm/boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dts
@@ -9,6 +9,7 @@
 / {
 	model = "Sony Xperia Z2 Tablet";
 	compatible = "sony,xperia-castor", "qcom,msm8974";
+	chassis-type = "tablet";
 
 	aliases {
 		serial0 = &blsp1_uart2;
-- 
2.37.3

