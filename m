Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5213F67C8C8
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 11:40:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237105AbjAZKkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 05:40:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236982AbjAZKkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 05:40:07 -0500
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D2A367D3;
        Thu, 26 Jan 2023 02:40:05 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grimler.se; s=key1;
        t=1674729604;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ehHG0agnVWr1E1xr0nOFkM6+aF48oEGwbR19XxQGOeg=;
        b=WI2X3dm+sj4+isE6DIZ/HXqZWn06/gRlk8G0DxvCiZUwMmh/6MtsbeDLFBOpggT/61fixi
        vPJ3MRoBPMACMr84h+DxCJJO6E5IGTIy2VZovKqxdUZetuMaaYrfmKwqDJ6W1SSf3tntt7
        EIjkJcP5FZZes9Jk0xiIY2ZDAReeOfQ=
From:   Henrik Grimler <henrik@grimler.se>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        alim.akhtar@samsung.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Cc:     Henrik Grimler <henrik@grimler.se>
Subject: [PATCH 4/6] ARM: dts: exynos: add mmc aliases for Exynos5250
Date:   Thu, 26 Jan 2023 11:38:26 +0100
Message-Id: <20230126103828.481441-5-henrik@grimler.se>
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
 arch/arm/boot/dts/exynos5250.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index 97e89859ba3d..d030020c5d46 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -30,10 +30,10 @@ aliases {
 		gsc1 = &gsc_1;
 		gsc2 = &gsc_2;
 		gsc3 = &gsc_3;
-		mshc0 = &mmc_0;
-		mshc1 = &mmc_1;
-		mshc2 = &mmc_2;
-		mshc3 = &mmc_3;
+		mmc0 = &mmc_0; /* eMMC */
+		mmc1 = &mmc_1;
+		mmc2 = &mmc_2; /* uSD */
+		mmc3 = &mmc_3;
 		i2c4 = &i2c_4;
 		i2c5 = &i2c_5;
 		i2c6 = &i2c_6;
-- 
2.39.1

