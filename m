Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23CEF608028
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 22:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbiJUUrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 16:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbiJUUrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 16:47:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6692315711;
        Fri, 21 Oct 2022 13:46:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 99856B82D23;
        Fri, 21 Oct 2022 20:46:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 757ECC433D6;
        Fri, 21 Oct 2022 20:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666385187;
        bh=r4rs+gBLRR2XnC/iBTUpmvw8Y1/CAN6bIqgMsnCS3+M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bEUU8QrTiTFvPH3Zs3lk4BYlQrncBQ27b3JEZ7yaGj50xGf//DsfDHZOPKOyFufVa
         6nMW5QVb8ee2kX8yYQ4luotFom6IwrY+xE1qUt3yvhg0LPb81AaSj8Hjz6d6F177Ru
         lZi8jSduBpDBFd0G6P8jl3epKd/ckixBVvwQlHY6w8t+tc3UkcU5USD4fUdzlfdSG/
         x4Nr5rm65+P+QtI5jkg720jIM+qyrp4IRhkj/LVLS7NwJ8CwNe0qUOaFjN0aQHy55H
         m7pyWO9Mc4H3h8+ox4O34LhmQhCJSxO476RkcFhRYlNbtmxDum5e1aJAeUEC7PTd/5
         vbYBD2zsrbKYw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>,
        Simtec Linux Team <linux@simtec.co.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH 11/21] clk: remove s3c24xx driver
Date:   Fri, 21 Oct 2022 22:27:44 +0200
Message-Id: <20221021203329.4143397-11-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20221021202254.4142411-1-arnd@kernel.org>
References: <20221021202254.4142411-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The s3c24xx platform is gone, so the clk driver can be removed as
well.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 MAINTAINERS                               |   1 -
 drivers/clk/samsung/Kconfig               |  32 --
 drivers/clk/samsung/Makefile              |   4 -
 drivers/clk/samsung/clk-s3c2410-dclk.c    | 440 ---------------------
 drivers/clk/samsung/clk-s3c2410.c         | 446 ----------------------
 drivers/clk/samsung/clk-s3c2412.c         | 254 ------------
 drivers/clk/samsung/clk-s3c2443.c         | 438 ---------------------
 include/linux/platform_data/clk-s3c2410.h |  19 -
 8 files changed, 1634 deletions(-)
 delete mode 100644 drivers/clk/samsung/clk-s3c2410-dclk.c
 delete mode 100644 drivers/clk/samsung/clk-s3c2410.c
 delete mode 100644 drivers/clk/samsung/clk-s3c2412.c
 delete mode 100644 drivers/clk/samsung/clk-s3c2443.c
 delete mode 100644 include/linux/platform_data/clk-s3c2410.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 503ebd9800db..caf196041e3a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18078,7 +18078,6 @@ F:	include/dt-bindings/clock/s3c*.h
 F:	include/dt-bindings/clock/s5p*.h
 F:	include/dt-bindings/clock/samsung,*.h
 F:	include/linux/clk/samsung.h
-F:	include/linux/platform_data/clk-s3c2410.h
 
 SAMSUNG SPI DRIVERS
 M:	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
diff --git a/drivers/clk/samsung/Kconfig b/drivers/clk/samsung/Kconfig
index 8e8245ab3fd1..c07bb50513bf 100644
--- a/drivers/clk/samsung/Kconfig
+++ b/drivers/clk/samsung/Kconfig
@@ -94,38 +94,6 @@ config EXYNOS_CLKOUT
 	  status of the certains clocks from SoC, but it could also be tied to
 	  other devices as an input clock.
 
-# For S3C24XX platforms, select following symbols:
-config S3C2410_COMMON_CLK
-	bool "Samsung S3C2410 clock controller support" if COMPILE_TEST
-	select COMMON_CLK_SAMSUNG
-	help
-	  Support for the clock controller present on the Samsung
-	  S3C2410/S3C2440/S3C2442 SoCs. Choose Y here only if you build for
-	  this SoC.
-
-config S3C2410_COMMON_DCLK
-	bool
-	select COMMON_CLK_SAMSUNG
-	select REGMAP_MMIO
-	help
-	  Support for the dclk clock controller present on the Samsung
-	  S3C2410/S3C2412/S3C2440/S3C2443 SoCs. Choose Y here only if you build
-	  for this SoC.
-
-config S3C2412_COMMON_CLK
-	bool "Samsung S3C2412 clock controller support" if COMPILE_TEST
-	select COMMON_CLK_SAMSUNG
-	help
-	  Support for the clock controller present on the Samsung S3C2412 SoCs.
-	  Choose Y here only if you build for this SoC.
-
-config S3C2443_COMMON_CLK
-	bool "Samsung S3C2443 clock controller support" if COMPILE_TEST
-	select COMMON_CLK_SAMSUNG
-	help
-	  Support for the clock controller present on the Samsung
-	  S3C2416/S3C2443 SoCs. Choose Y here only if you build for this SoC.
-
 config TESLA_FSD_COMMON_CLK
 	bool "Tesla FSD clock controller support" if COMPILE_TEST
 	depends on COMMON_CLK_SAMSUNG
diff --git a/drivers/clk/samsung/Makefile b/drivers/clk/samsung/Makefile
index 239d9eead77f..ebbeacabe88f 100644
--- a/drivers/clk/samsung/Makefile
+++ b/drivers/clk/samsung/Makefile
@@ -21,10 +21,6 @@ obj-$(CONFIG_EXYNOS_ARM64_COMMON_CLK)	+= clk-exynos7.o
 obj-$(CONFIG_EXYNOS_ARM64_COMMON_CLK)	+= clk-exynos7885.o
 obj-$(CONFIG_EXYNOS_ARM64_COMMON_CLK)	+= clk-exynos850.o
 obj-$(CONFIG_EXYNOS_ARM64_COMMON_CLK)	+= clk-exynosautov9.o
-obj-$(CONFIG_S3C2410_COMMON_CLK)+= clk-s3c2410.o
-obj-$(CONFIG_S3C2410_COMMON_DCLK)+= clk-s3c2410-dclk.o
-obj-$(CONFIG_S3C2412_COMMON_CLK)+= clk-s3c2412.o
-obj-$(CONFIG_S3C2443_COMMON_CLK)+= clk-s3c2443.o
 obj-$(CONFIG_S3C64XX_COMMON_CLK)	+= clk-s3c64xx.o
 obj-$(CONFIG_S5PV210_COMMON_CLK)	+= clk-s5pv210.o clk-s5pv210-audss.o
 obj-$(CONFIG_TESLA_FSD_COMMON_CLK)	+= clk-fsd.o
diff --git a/drivers/clk/samsung/clk-s3c2410-dclk.c b/drivers/clk/samsung/clk-s3c2410-dclk.c
deleted file mode 100644
index f5e0a6ba2d12..000000000000
diff --git a/drivers/clk/samsung/clk-s3c2410.c b/drivers/clk/samsung/clk-s3c2410.c
deleted file mode 100644
index 3d152a46169b..000000000000
diff --git a/drivers/clk/samsung/clk-s3c2412.c b/drivers/clk/samsung/clk-s3c2412.c
deleted file mode 100644
index 724ef642f048..000000000000
diff --git a/drivers/clk/samsung/clk-s3c2443.c b/drivers/clk/samsung/clk-s3c2443.c
deleted file mode 100644
index a827d63766d1..000000000000
diff --git a/include/linux/platform_data/clk-s3c2410.h b/include/linux/platform_data/clk-s3c2410.h
deleted file mode 100644
index 7eb1cfa5409b..000000000000
-- 
2.29.2

