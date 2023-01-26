Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56EDA67C8BE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 11:40:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236894AbjAZKkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 05:40:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbjAZKj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 05:39:58 -0500
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7851E56491;
        Thu, 26 Jan 2023 02:39:57 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grimler.se; s=key1;
        t=1674729595;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mDsZ7CmuBAkMxigCyOthMYIyyRStE/Y8QZvA7AhNAkU=;
        b=WFcuya1+mDxRpeah511R76HAjFL/HuIKpM/bgRXd9ebbmeD4Zyh6xPLJ5TMyOKtaZz2fvZ
        h1i5jZa5Qi2bGShoktvQuTyKry4k89aYMgYjmiRZjQZiEEl26Z+BjARW6I8tCx6pgFvEfr
        HgSCJcvkzhFeyUZ13d/Y368CQbYDbkw=
From:   Henrik Grimler <henrik@grimler.se>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        alim.akhtar@samsung.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Cc:     Henrik Grimler <henrik@grimler.se>
Subject: [PATCH 1/6] ARM: dts: exynos: add mmc aliases for Exynos3250
Date:   Thu, 26 Jan 2023 11:38:23 +0100
Message-Id: <20230126103828.481441-2-henrik@grimler.se>
In-Reply-To: <20230126103828.481441-1-henrik@grimler.se>
References: <20230126103828.481441-1-henrik@grimler.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So that mmcblk numbering is fixed for the eMMC and sdcard, no matter
if a storage device is attached or not.  Also remove old, no longer
used, mshc alias while we are at it.

Signed-off-by: Henrik Grimler <henrik@grimler.se>
---
 arch/arm/boot/dts/exynos3250.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
index 54bb323186e4..119fbe4208cd 100644
--- a/arch/arm/boot/dts/exynos3250.dtsi
+++ b/arch/arm/boot/dts/exynos3250.dtsi
@@ -28,9 +28,9 @@ / {
 	aliases {
 		pinctrl0 = &pinctrl_0;
 		pinctrl1 = &pinctrl_1;
-		mshc0 = &mshc_0;
-		mshc1 = &mshc_1;
-		mshc2 = &mshc_2;
+		mmc0 = &mshc_0;
+		mmc1 = &mshc_1;
+		mmc2 = &mshc_2;
 		spi0 = &spi_0;
 		spi1 = &spi_1;
 		i2c0 = &i2c_0;
-- 
2.39.1

