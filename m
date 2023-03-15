Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C75D36BBF12
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 22:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233104AbjCOV2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 17:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232642AbjCOV2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 17:28:45 -0400
Received: from out-60.mta0.migadu.com (out-60.mta0.migadu.com [IPv6:2001:41d0:1004:224b::3c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 329CCBDD1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 14:28:37 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grimler.se; s=key1;
        t=1678915715;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vAKBsvws71kJTHTxaksOf1+WTTkfvDgnY5I/sW6xXf0=;
        b=RRpZJfxnUBdMfHaEsrfKDDKh87jLgL6H26X87WRndkHucVOt3LI20ooqentwY1tPj6KdI2
        5ZxnF7gW2K39pmSB3uxRU6i3JmhonP6jVgoTF7G6lAyQoo4Mi6yO+rPWCGNsNAxTbbO8k1
        hvWBUgIxqXHuB20x6AiqwY4iY1bFnts=
From:   Henrik Grimler <henrik@grimler.se>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        alim.akhtar@samsung.com, m.szyprowski@samsung.com,
        virag.david003@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Cc:     Henrik Grimler <henrik@grimler.se>
Subject: [PATCH v2 2/2] arm64: dts: exynos: add mmc aliases
Date:   Wed, 15 Mar 2023 22:28:14 +0100
Message-Id: <20230315212814.15908-3-henrik@grimler.se>
In-Reply-To: <20230315212814.15908-1-henrik@grimler.se>
References: <20230315212814.15908-1-henrik@grimler.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add aliases for eMMC and SD card where applicable, so that
assigned mmc indeces are always the same.

Signed-off-by: Henrik Grimler <henrik@grimler.se>
---

Changes since v1:
* None

 arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi | 2 ++
 arch/arm64/boot/dts/exynos/exynos7-espresso.dts       | 2 ++
 arch/arm64/boot/dts/exynos/exynos7885-jackpotlte.dts  | 1 +
 3 files changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
index 868f7b98a637..e4ed788413fe 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
@@ -21,6 +21,8 @@ aliases {
 		gsc0 = &gsc_0;
 		gsc1 = &gsc_1;
 		gsc2 = &gsc_2;
+		mmc0 = &mshc_0;
+		mmc2 = &mshc_2;
 		pinctrl0 = &pinctrl_alive;
 		pinctrl1 = &pinctrl_aud;
 		pinctrl2 = &pinctrl_cpif;
diff --git a/arch/arm64/boot/dts/exynos/exynos7-espresso.dts b/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
index 35d949099166..1f2eddcebdd9 100644
--- a/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
+++ b/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
@@ -17,6 +17,8 @@ / {
 	compatible = "samsung,exynos7-espresso", "samsung,exynos7";
 
 	aliases {
+		mmc0 = &mmc_0;
+		mmc2 = &mmc_2;
 		serial0 = &serial_2;
 	};
 
diff --git a/arch/arm64/boot/dts/exynos/exynos7885-jackpotlte.dts b/arch/arm64/boot/dts/exynos/exynos7885-jackpotlte.dts
index 5db9a81ac7bb..47a389d9ff7d 100644
--- a/arch/arm64/boot/dts/exynos/exynos7885-jackpotlte.dts
+++ b/arch/arm64/boot/dts/exynos/exynos7885-jackpotlte.dts
@@ -18,6 +18,7 @@ / {
 	chassis-type = "handset";
 
 	aliases {
+		mmc0 = &mmc_0;
 		serial0 = &serial_0;
 		serial1 = &serial_1;
 		serial2 = &serial_2;
-- 
2.30.2

