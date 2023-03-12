Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF2416B6A53
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 19:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbjCLSrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 14:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjCLSrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 14:47:18 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50501AD31
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 11:47:11 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id j19-20020a05600c1c1300b003e9b564fae9so9482518wms.2
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 11:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678646829;
        h=cc:to:subject:date:from:in-reply-to:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rC/o1AQDcGAyPZ0tU6+VZIwVNayEqqDcPKH36IGj0wI=;
        b=WnfjUVoY5i5FXj5EyFEWpWv9pLhB0JX2mgxMb825AxYGmV8VgqcJRUjirJ2YhDFyet
         QCh8flVc1zL9puODjAE4JzziN11EPL3ShvFEE9p0C/K46DRiZ1iu2uXU1k0WENsheYkC
         L0SZhRF+hwdLLDeEGEA1hfjsS0PPeJVfNEH8XvEnzAoxgGjxGfAin7EzLf2+G/8YimCD
         p+lmpLNtiexT6H55N5d2o+/ZABuJQ0mdN1b+TmkKKYEBq1mgYIyKax1cfFHZ/EpGo2N/
         dwl9wyed099xr9CJg8rqmFms8dml0HrL/fw7sq0XUnbu468mjOymY9BxJtmCAQZ5sDfF
         2cog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678646829;
        h=cc:to:subject:date:from:in-reply-to:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rC/o1AQDcGAyPZ0tU6+VZIwVNayEqqDcPKH36IGj0wI=;
        b=d2sQuEPLxCReLsJpvwUXtWqtZbk1n0dkFIx9lpTP1qMKI07e87PQPSay13BVC0f7y6
         6P0ARmtxQafEmlVREdgo2/ntFDMDOjCRznHULvQxF5sQQmk/XM15op+i3abPlU6/79wm
         YAA9cWcgwDdG0PauW7GVgQZnBigU+NEuGluRBeQzxEzq8eYlK8LpwESSgUZhQTD1rdrv
         3DRa2vhtnZaRgc+KDzEkNZ0XcLWDFZ2JgJtd493PeckTQB3CzP5uX5EQ/opm0mkBtQVh
         XjI5OLqnQehjb36WR4gQG4RYkdlxFpv7ZZleSomckscViI/a3+SlJ3myuKrnGD02MgIS
         13ow==
X-Gm-Message-State: AO0yUKWr5RcaaKLoyy+OGZNEmnrljqCmOVXZxrSgafr+VpkvjLhKMyVR
        lJi08pR9dNshbQxm6X8d9l4x8iDadBrDvh2c
X-Google-Smtp-Source: AK7set/yD55p9ta+GbXMhzBj/rpZCWjM8k0udMfT6R9YlZhoHm+TVeuL+ioz3JcoczkO1jwgbsEQYw==
X-Received: by 2002:ac2:4473:0:b0:4dd:a053:3baf with SMTP id y19-20020ac24473000000b004dda0533bafmr8577530lfl.35.1678644705260;
        Sun, 12 Mar 2023 11:11:45 -0700 (PDT)
Received: from 0003-arm64-dts-exynos-fix-wrong-mmc-compatible-in-exynos7.patch (46-138-144-249.dynamic.spd-mgts.ru. [46.138.144.249])
        by smtp.gmail.com with ESMTPSA id g27-20020ac2539b000000b004d37d647637sm716805lfh.64.2023.03.12.11.11.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 11:11:44 -0700 (PDT)
Message-Id: <1678644516.665314-3-sleirsgoevy@gmail.com>
In-Reply-To: <1678644516.665314-0-sleirsgoevy@gmail.com>
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


