Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 451716B6A4D
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 19:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbjCLSmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 14:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbjCLSl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 14:41:59 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE7D82411A
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 11:41:35 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id z42so10400226ljq.13
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 11:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678646469;
        h=cc:to:subject:date:from:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rC/o1AQDcGAyPZ0tU6+VZIwVNayEqqDcPKH36IGj0wI=;
        b=R4jny8OQXRlwbeWqZ1o0H+mUB9c/iPi4YRBkma0SYHWVXAJ4z6FMz0Vyv4IGDqka4h
         prEiJhEnqJPXaqbA6uyPyrEbluFtAHOqlVM3uF95XPDNAPWg2jeKX85MNp7xNdficDmO
         USyELAbdtGgyDS5a2TcTvVFX7JBRCrUtFq0NQ2aMs/yXAayVl9PX49ToMevB2upFYTbO
         F+o3xy4gFMnxPwejHMaOrqdMqV44zvfv+LvBZGeCE9HxaknzvaNMnclCyURbbN6W63Ok
         kxOiNFEvy24noDVt2ietmOC5vppy4NwrjAi4QpWkUwlaiVHcDa8ERMCNg5NbWAdzF4D1
         n4Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678646469;
        h=cc:to:subject:date:from:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rC/o1AQDcGAyPZ0tU6+VZIwVNayEqqDcPKH36IGj0wI=;
        b=27MvT1dj2+d6rTqoO72ziYzUEFlfMnvxpwYALbCxR+pxhD3B0KEcsZqQi/48KAoyqF
         rk8IUblG1ORwIAuiQ2r2zyWCROxQ0n75GvF05hab8ZcEjaJuzb96L+qc0Z+F0CDusUxp
         VcvwTowd6fludK54WFpln9XR6nGrIXUqzrTgkBH7SCkc8aB+5Es8nVeJ7v4OGcI4qB+U
         P829i1j7HHCx3mYKc4/oeHU0g0p+way8QtVuVlZpIIKGJHJlZAZQ9m8neIciVjRmDDtO
         ke0+lx/kwb9HCJyB2sh2tGoaVBZAwz4yvOpX4LxGQ9i93bwgLLaraRksWuUTvAEYXq93
         evGQ==
X-Gm-Message-State: AO0yUKVeFIEa3iAad6v8sVuMPM6/9/pSNQ26doXdPugrzHaealD1aFWv
        cocR0+gy+XO/81eht6WHW3Ywfpx9s4oNGrRt
X-Google-Smtp-Source: AK7set8k9MSOf/OJ9V6/6lYdkNI2az1Ajf75Yo5+H0rGSONor1biI7/dT8SOpFXkIdyqgjeRdHbyeA==
X-Received: by 2002:a2e:3610:0:b0:295:acb9:8610 with SMTP id d16-20020a2e3610000000b00295acb98610mr10416084lja.25.1678644317855;
        Sun, 12 Mar 2023 11:05:17 -0700 (PDT)
Received: from 0003-arm64-dts-exynos-fix-wrong-mmc-compatible-in-exynos7.patch (46-138-144-249.dynamic.spd-mgts.ru. [46.138.144.249])
        by smtp.gmail.com with ESMTPSA id 125-20020a2e0583000000b00295bbe17b46sm732245ljf.132.2023.03.12.11.05.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 11:05:17 -0700 (PDT)
Message-ID: <640e145d.2e0a0220.ef71f.1a15@mx.google.com>
From:   Sergey Lisov <sleirsgoevy@gmail.com>
Date:   Sun, 12 Mar 2023 20:58:50 +0300
Subject: [PATCH v5 3/3] arm64: dts: exynos: fix wrong mmc compatible in
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
very short data transfers, typically used by SDIO cards. Update the
compatible string to "samsung,exynos7885-dw-mshc-smu" to reflect this fact.
---
 arch/arm64/boot/dts/exynos/exynos7885.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos7885.dtsi b/arch/arm64/boot/dts/exynos/exynos7885.dtsi
index 23c2e0bb0..b0addb0b3 100644
--- a/arch/arm64/boot/dts/exynos/exynos7885.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos7885.dtsi
@@ -294,7 +294,7 @@ pmu_system_controller: system-controller@11c80000 {
 		};
 
 		mmc_0: mmc@13500000 {
-			compatible = "samsung,exynos7-dw-mshc-smu";
+			compatible = "samsung,exynos7885-dw-mshc-smu";
 			reg = <0x13500000 0x2000>;
 			interrupts = <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
-- 
2.38.3


