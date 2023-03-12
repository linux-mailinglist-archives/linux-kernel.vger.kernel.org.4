Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAA9F6B688D
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 18:03:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbjCLRDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 13:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjCLRDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 13:03:11 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9781F136C7
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 10:03:09 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id b10so10350134ljr.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 10:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678640587;
        h=cc:to:subject:date:from:in-reply-to:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yNccjh9ehO5GzEa2MK08HfZDjH6EdpZB9/Uqslpa9j8=;
        b=kqxQc/lcfo4O3IVrgdqCwnLQ5D9feVCpykVHIU24WhenM+Qth3A/LcFZ62Y9ObaAE/
         /l4+V3B5Qia7SHqTU+onjX2c4spNndhX45Q85vRSaAk2eaBMM/wygg2xrVN9+ydkslcc
         4xxuYHayRBE54rpDftHLSzST4lAWUuyzyx8oLqpZ1LUD32itTU8EzOzJVe5tshwSIb+d
         qMcW0KMD9pi96gz0qVnB42T0ZarjOCLJV4s+phGdTrGY9cTs+Hl+7/rrK2o2BG0u04HT
         yu2lAH9XI8Cu4m8bTPRrTqIjw2xKsZEiAx+hsrS8YB8voocwj8v6pEwNQ/8jLabEumpX
         pZGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678640587;
        h=cc:to:subject:date:from:in-reply-to:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yNccjh9ehO5GzEa2MK08HfZDjH6EdpZB9/Uqslpa9j8=;
        b=hRrt7P69RVmeatTMMX4H05wDiJC20sLFvL6WfYYFTX5fSpm/hmTPrdC4e+vvB2Zt8V
         oq0QghkGOVs8HrDzSs7m+clfjHo+7WLgP5eaB/wUZDBm3yI4N24XX1M7DOiqz0WQ6doz
         nJcptCbacAJxW5+ljsEyv4R7tsPWtdgNkSNwNkCsxAtXwFRvvR9zJBT3pHB9W4xK8Uey
         pWGVV3DTouYiKaBRyKD+dF2M+jHD/jVDnqaIDSi5RH0ritTsgQ0jEMHwWc2ElogogN2u
         FsBPWkth0M3aPw6p/mtVe7zJ7fupY+yOAWoyVdH8xjY3t5JCRWZNOlt3bgGoBuQQBL/1
         lEig==
X-Gm-Message-State: AO0yUKVBVAEZeCt0ZV3iL5I7yF9TwJ3H4OdMFzpGDCWEjcoo0z0PBnsx
        DWugpmKmrk1FSF3WGRoNoxBxZ4rqZP0wTdud
X-Google-Smtp-Source: AK7set8BOLzpIW3pOLVKY2LIne3PACEnL5Yfe+3qT6YltcHnreYWCJZUEWsddE1w9TwwulfaHa9GLg==
X-Received: by 2002:a2e:a586:0:b0:298:39fa:b04d with SMTP id m6-20020a2ea586000000b0029839fab04dmr11384348ljp.33.1678640587405;
        Sun, 12 Mar 2023 10:03:07 -0700 (PDT)
Received: from 0002-arm64-dts-exynos-fix-wrong-mmc-compatible-in-exynos7.patch (46-138-144-249.dynamic.spd-mgts.ru. [46.138.144.249])
        by smtp.gmail.com with ESMTPSA id r2-20020a2e94c2000000b0029335c12997sm704396ljh.58.2023.03.12.10.03.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 10:03:07 -0700 (PDT)
Message-Id: <1678640497.9030156-2-sleirsgoevy@gmail.com>
In-Reply-To: <1678640497.9030156-0-sleirsgoevy@gmail.com>
From:   Sergey Lisov <sleirsgoevy@gmail.com>
Date:   Sun, 12 Mar 2023 19:59:29 +0300
Subject: [PATCH v4 2/3] arm64: dts: exynos: fix wrong mmc compatible in
 exynos7885.dtsi
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Jaehoon Chung <jh80.chung@samsung.com>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This DW-MMC variant is not actually compatible with
"samsung,exynos7-dw-mshc-smu", and requires an additional quirk to handle
very short data transfers. Update the compatible string to
"samsung,exynos78xx-dw-mshc-smu" to reflect this fact.
---
 arch/arm64/boot/dts/exynos/exynos7885.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos7885.dtsi b/arch/arm64/boot/dts/exynos/exynos7885.dtsi
index 23c2e0bb0..4b94ac9da 100644
--- a/arch/arm64/boot/dts/exynos/exynos7885.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos7885.dtsi
@@ -294,7 +294,7 @@ pmu_system_controller: system-controller@11c80000 {
 		};
 
 		mmc_0: mmc@13500000 {
-			compatible = "samsung,exynos7-dw-mshc-smu";
+			compatible = "samsung,exynos78xx-dw-mshc-smu";
 			reg = <0x13500000 0x2000>;
 			interrupts = <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
-- 
2.38.3


