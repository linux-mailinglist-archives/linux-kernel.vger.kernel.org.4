Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC24A67F811
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 14:32:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234343AbjA1NcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 08:32:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233744AbjA1NcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 08:32:09 -0500
Received: from out-130.mta0.migadu.com (out-130.mta0.migadu.com [IPv6:2001:41d0:1004:224b::82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E64B611DC
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 05:32:07 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grimler.se; s=key1;
        t=1674912725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=faNgDxicPnolPKGeqPG46tJAmGJItTu7gNpxYxG5i8Y=;
        b=IuYUhBjhKuJBOOIAjuiCfCHtoDa2uJrhTEYLLCM3abywMz8gzYB5xzuGsEwJrEKR8PtGfH
        A7+1VRnrVp53n8lwzh2twV3rAbgB+rG94EG1+5w+M479dTLOIZoACTiicOmnK7dd401AYW
        nDTR66DahsH9Smh07gmfvpJh5KKafTc=
From:   Henrik Grimler <henrik@grimler.se>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        alim.akhtar@samsung.com, m.szyprowski@samsung.com,
        jenneron@protonmail.com, markuss.broks@gmail.com,
        martin.juecker@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Cc:     Henrik Grimler <henrik@grimler.se>
Subject: [PATCH v2 1/2] ARM: dts: exynos: drop mshc aliases
Date:   Sat, 28 Jan 2023 14:31:50 +0100
Message-Id: <20230128133151.29471-2-henrik@grimler.se>
In-Reply-To: <20230128133151.29471-1-henrik@grimler.se>
References: <20230128133151.29471-1-henrik@grimler.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

They are no longer needed after commit a13e8ef6008d ("mmc: dw_mmc:
exynos: use common_caps").

Signed-off-by: Henrik Grimler <henrik@grimler.se>
---
 arch/arm/boot/dts/exynos3250.dtsi | 3 ---
 arch/arm/boot/dts/exynos4412.dtsi | 1 -
 arch/arm/boot/dts/exynos5250.dtsi | 4 ----
 arch/arm/boot/dts/exynos5420.dtsi | 3 ---
 4 files changed, 11 deletions(-)

diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
index 54bb323186e4..2d7771c1043b 100644
--- a/arch/arm/boot/dts/exynos3250.dtsi
+++ b/arch/arm/boot/dts/exynos3250.dtsi
@@ -28,9 +28,6 @@ / {
 	aliases {
 		pinctrl0 = &pinctrl_0;
 		pinctrl1 = &pinctrl_1;
-		mshc0 = &mshc_0;
-		mshc1 = &mshc_1;
-		mshc2 = &mshc_2;
 		spi0 = &spi_0;
 		spi1 = &spi_1;
 		i2c0 = &i2c_0;
diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos4412.dtsi
index 7b4e2c442888..9e97b42638e9 100644
--- a/arch/arm/boot/dts/exynos4412.dtsi
+++ b/arch/arm/boot/dts/exynos4412.dtsi
@@ -28,7 +28,6 @@ aliases {
 		pinctrl3 = &pinctrl_3;
 		fimc-lite0 = &fimc_lite_0;
 		fimc-lite1 = &fimc_lite_1;
-		mshc0 = &mshc_0;
 	};
 
 	cpus {
diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index 97e89859ba3d..6ea8a090f602 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -30,10 +30,6 @@ aliases {
 		gsc1 = &gsc_1;
 		gsc2 = &gsc_2;
 		gsc3 = &gsc_3;
-		mshc0 = &mmc_0;
-		mshc1 = &mmc_1;
-		mshc2 = &mmc_2;
-		mshc3 = &mmc_3;
 		i2c4 = &i2c_4;
 		i2c5 = &i2c_5;
 		i2c6 = &i2c_6;
diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index b1051a7d07af..6862cbabc172 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -19,9 +19,6 @@ / {
 	compatible = "samsung,exynos5420", "samsung,exynos5";
 
 	aliases {
-		mshc0 = &mmc_0;
-		mshc1 = &mmc_1;
-		mshc2 = &mmc_2;
 		pinctrl0 = &pinctrl_0;
 		pinctrl1 = &pinctrl_1;
 		pinctrl2 = &pinctrl_2;
-- 
2.39.1

