Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB98567C8C7
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 11:40:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237066AbjAZKkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 05:40:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236930AbjAZKkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 05:40:04 -0500
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92AEC66F97;
        Thu, 26 Jan 2023 02:40:02 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grimler.se; s=key1;
        t=1674729601;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nU6JQuJ+2Wwb5CYLg12kj2U2wnCf/z9laSYJN5KzBA0=;
        b=GzlhzEjHH8COW1SHQZEib4icxryX8Z7eNG2XInU5Cu8CUgk+9i2vBXYzeM0AIelILwYq9x
        z5quTCLm38RZ5EipijOwH7dEVzSWO743P0ZgCWr9LeU5wL7sRYCxKfzy1vSuSjh9j3ddvQ
        RAEMGD2iQf15VJUi6pEQORRjPap/JSk=
From:   Henrik Grimler <henrik@grimler.se>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        alim.akhtar@samsung.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Cc:     Henrik Grimler <henrik@grimler.se>
Subject: [PATCH 3/6] ARM: dts: exynos: add mmc aliases for Exynos4412
Date:   Thu, 26 Jan 2023 11:38:25 +0100
Message-Id: <20230126103828.481441-4-henrik@grimler.se>
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
 arch/arm/boot/dts/exynos4412.dtsi | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos4412.dtsi
index 7b4e2c442888..9625e9fe63b1 100644
--- a/arch/arm/boot/dts/exynos4412.dtsi
+++ b/arch/arm/boot/dts/exynos4412.dtsi
@@ -28,7 +28,10 @@ aliases {
 		pinctrl3 = &pinctrl_3;
 		fimc-lite0 = &fimc_lite_0;
 		fimc-lite1 = &fimc_lite_1;
-		mshc0 = &mshc_0;
+		mmc0 = &mshc_0; /* eMMC */
+		mmc1 = &sdhci_1;
+		mmc2 = &sdhci_2; /* uSD */
+		mmc3 = &sdhci_3;
 	};
 
 	cpus {
-- 
2.39.1

