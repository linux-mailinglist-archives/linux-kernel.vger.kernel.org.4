Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C08A768A3C4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 21:47:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbjBCUrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 15:47:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233008AbjBCUqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 15:46:54 -0500
X-Greylist: delayed 381 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 03 Feb 2023 12:46:51 PST
Received: from out-53.mta1.migadu.com (out-53.mta1.migadu.com [IPv6:2001:41d0:203:375::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F029D07F
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 12:46:50 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grimler.se; s=key1;
        t=1675456830;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RUkDWn+Iwl+u4RZAdasEeGOVl9/XR1YbpJwm+77E16E=;
        b=jJlBz//aUa1u40cS7EMk3lb7MSryr1TAiJvnDRooGw2vp4OYWme4MQGzeUSI7qDFrwh4cl
        TaRPSmcoRwFc27qtpitioNoFiqamsJZZE66hzQKvsDA4y/Tq6hr93hW/u+qjlCewdtAsC5
        Oo7CuInO77Q0+3ovQnNwYGG4Qlhzr2A=
From:   Henrik Grimler <henrik@grimler.se>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        alim.akhtar@samsung.com, m.szyprowski@samsung.com,
        virag.david003@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Cc:     Henrik Grimler <henrik@grimler.se>
Subject: [PATCH 1/2] arm64: dts: exynos: drop mshc aliases
Date:   Fri,  3 Feb 2023 21:39:59 +0100
Message-Id: <20230203204000.14410-2-henrik@grimler.se>
In-Reply-To: <20230203204000.14410-1-henrik@grimler.se>
References: <20230203204000.14410-1-henrik@grimler.se>
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
 arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi | 2 --
 arch/arm64/boot/dts/exynos/exynos7-espresso.dts       | 2 --
 2 files changed, 4 deletions(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
index f54f30633417..c895b70b3cec 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
@@ -40,8 +40,6 @@ aliases {
 		spi2 = &spi_2;
 		spi3 = &spi_3;
 		spi4 = &spi_4;
-		mshc0 = &mshc_0;
-		mshc2 = &mshc_2;
 	};
 
 	chosen {
diff --git a/arch/arm64/boot/dts/exynos/exynos7-espresso.dts b/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
index f3f4a6ab4b49..686f0923a4a7 100644
--- a/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
+++ b/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
@@ -18,8 +18,6 @@ / {
 
 	aliases {
 		serial0 = &serial_2;
-		mshc0 = &mmc_0;
-		mshc2 = &mmc_2;
 	};
 
 	chosen {
-- 
2.39.1

