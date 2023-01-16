Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39B1C66C32F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 16:02:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233053AbjAPPCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 10:02:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232952AbjAPPAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 10:00:38 -0500
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 736DA22DDE;
        Mon, 16 Jan 2023 06:51:08 -0800 (PST)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 12EC2419BE;
        Mon, 16 Jan 2023 19:51:05 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1673880665; bh=urfMhxWEasdlUysIhKYeaqjGbBy/8LF6MobVrm0Cr/s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MPTHHxbsQl+duwdTH4sZwUByTn2qxo3qwAzgWuGJtEiJpfWQdvw4Itn3JDpgJ+gd3
         zTVTxUnh/oD9keXL1Y2xSSgeKlhwQw9X98+vIVPPdmCmb/H8GjOd0Hr2r6gK0HkbmY
         +ofpHCoGSP2vAv2xSdgPBDhGAsUdkIzW/3acZ3iQLmtF2Od6fc58kOXfyEDGq4t1+k
         Cr9UZCrHSDJLJaeBzZ2GTotG7i5GEirEJ5ggf12xJ9wwP6ZHMay+m4HjBxoVU2pzlZ
         Y0WpzYXuvcFuMEHWEg/JAvgKHVuv63r32i8F/dduVkvMvOC6G+1ASkFx2zGpSHTc4E
         aNUNePPbTbCBg==
From:   Nikita Travkin <nikita@trvn.ru>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Nikita Travkin <nikita@trvn.ru>
Subject: [PATCH v2 4/4] arm64: dts: qcom: msm/apq8x16-*: Reorder some regulator properties
Date:   Mon, 16 Jan 2023 19:50:53 +0500
Message-Id: <20230116145053.1412501-5-nikita@trvn.ru>
In-Reply-To: <20230116145053.1412501-1-nikita@trvn.ru>
References: <20230116145053.1412501-1-nikita@trvn.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's agreed that these properties should be ordered in the
reverse-Christmas-tree order. Reorder them to give a better example.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Nikita Travkin <nikita@trvn.ru>
---
 arch/arm64/boot/dts/qcom/apq8016-sbc.dts                   | 2 +-
 arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts       | 2 +-
 arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dts             | 2 +-
 arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts             | 2 +-
 arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts       | 2 +-
 arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dts       | 2 +-
 arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi | 2 +-
 arch/arm64/boot/dts/qcom/msm8916-samsung-j5.dts            | 2 +-
 arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts     | 2 +-
 arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dts      | 2 +-
 10 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
index f0abb40d0c98..9dfe175607dc 100644
--- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
@@ -506,8 +506,8 @@ l10 {
 	l11 {
 		regulator-min-microvolt = <1750000>;
 		regulator-max-microvolt = <3337000>;
-		regulator-allow-set-load;
 		regulator-system-load = <200000>;
+		regulator-allow-set-load;
 	};
 
 	l12 {
diff --git a/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts b/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts
index bc40721e4cbf..2555e920d7fd 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts
@@ -254,8 +254,8 @@ l10 {
 	l11 {
 		regulator-min-microvolt = <1800000>;
 		regulator-max-microvolt = <2950000>;
-		regulator-allow-set-load;
 		regulator-system-load = <200000>;
+		regulator-allow-set-load;
 	};
 
 	l12 {
diff --git a/arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dts b/arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dts
index 13b51d310940..c99aa80e52dc 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dts
@@ -223,8 +223,8 @@ l10 {
 	l11 {
 		regulator-min-microvolt = <1800000>;
 		regulator-max-microvolt = <2950000>;
-		regulator-allow-set-load;
 		regulator-system-load = <200000>;
+		regulator-allow-set-load;
 	};
 
 	l12 {
diff --git a/arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts b/arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts
index a4dfb2ce7893..b1d01f7cc316 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts
@@ -375,8 +375,8 @@ l10 {
 	l11 {
 		regulator-min-microvolt = <1800000>;
 		regulator-max-microvolt = <2950000>;
-		regulator-allow-set-load;
 		regulator-system-load = <200000>;
+		regulator-allow-set-load;
 	};
 
 	l12 {
diff --git a/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts b/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts
index 2596896e4a61..b0b2634b7f1d 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts
@@ -326,8 +326,8 @@ l10 {
 	l11 {
 		regulator-min-microvolt = <1800000>;
 		regulator-max-microvolt = <2950000>;
-		regulator-allow-set-load;
 		regulator-system-load = <200000>;
+		regulator-allow-set-load;
 	};
 
 	l12 {
diff --git a/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dts b/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dts
index 135b38c67da1..fc5e846dad3b 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dts
@@ -193,8 +193,8 @@ l10 {
 	l11 {
 		regulator-min-microvolt = <1800000>;
 		regulator-max-microvolt = <2950000>;
-		regulator-allow-set-load;
 		regulator-system-load = <200000>;
+		regulator-allow-set-load;
 	};
 
 	l12 {
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi b/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi
index d59587d42c0a..11e0930b1764 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi
@@ -346,8 +346,8 @@ l10 {
 	l11 {
 		regulator-min-microvolt = <1800000>;
 		regulator-max-microvolt = <2950000>;
-		regulator-allow-set-load;
 		regulator-system-load = <200000>;
+		regulator-allow-set-load;
 	};
 
 	l12 {
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-j5.dts b/arch/arm64/boot/dts/qcom/msm8916-samsung-j5.dts
index 9d5d84c0f9f6..6a4a40ca9dca 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-j5.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-j5.dts
@@ -158,8 +158,8 @@ l10 {
 	l11 {
 		regulator-min-microvolt = <1800000>;
 		regulator-max-microvolt = <2950000>;
-		regulator-allow-set-load;
 		regulator-system-load = <200000>;
+		regulator-allow-set-load;
 	};
 
 	l12 {
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts b/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts
index 84a4713886c1..98e63d414974 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts
@@ -383,8 +383,8 @@ l10 {
 	l11 {
 		regulator-min-microvolt = <1800000>;
 		regulator-max-microvolt = <2950000>;
-		regulator-allow-set-load;
 		regulator-system-load = <200000>;
+		regulator-allow-set-load;
 	};
 
 	l12 {
diff --git a/arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dts b/arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dts
index 9e3351ceb752..6610cd0f8a0b 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dts
@@ -247,8 +247,8 @@ l10 {
 	l11 {
 		regulator-min-microvolt = <2950000>;
 		regulator-max-microvolt = <2950000>;
-		regulator-allow-set-load;
 		regulator-system-load = <200000>;
+		regulator-allow-set-load;
 	};
 
 	l12 {
-- 
2.38.1

