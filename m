Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA2D960802B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 22:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbiJUUsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 16:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbiJUUrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 16:47:48 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0485210325B;
        Fri, 21 Oct 2022 13:47:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A3714CE2BD3;
        Fri, 21 Oct 2022 20:47:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DE63C433D6;
        Fri, 21 Oct 2022 20:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666385232;
        bh=03jM+N/itfs6Ls3v3FEsqDtVBOyJZhtZFr6zqJXmPkE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=spyV1d3PJkZo9sze+sHHjFp9Yjay83rvxDF1iI+ukct/IyMicVrqXkWh8WrxicZCX
         V9yJPXSaNk92ByrZJAcA83wak/5lGLif23xsj2nIlE5i+WPijEmglqvU82g2e6wX28
         vMMNmGtoMjXjTz1Y1IR44E2pwHNYE25eWffPQCWXh9OjD6Y5rpYs7rma/UnXpIAaAP
         U8Vz1qjuuxraqcQhQPz6Nom9DAnNQKar53Bm7u0PWPrcta3aOLoKa17p8Q7rXx1kBS
         56VK+i4rggdEPCjlOcaDhVexSuap/rszkJZM4hIZDzNWhWUe7unaWQIbPSSVa7ZjTZ
         BQikFUEGwfCOw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Pavel Machek <pavel@ucw.cz>
Cc:     linux-kernel@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>,
        Simtec Linux Team <linux@simtec.co.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        linux-leds@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Subject: [PATCH 12/21] leds: remove s3c24xx driver
Date:   Fri, 21 Oct 2022 22:27:45 +0200
Message-Id: <20221021203329.4143397-12-arnd@kernel.org>
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

The s3c24xx platform is gone, so the led driver can be
removed as well.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/leds/Kconfig                       |  8 ---
 drivers/leds/Makefile                      |  1 -
 drivers/leds/leds-s3c24xx.c                | 83 ----------------------
 include/linux/platform_data/leds-s3c24xx.h | 18 -----
 4 files changed, 110 deletions(-)
 delete mode 100644 drivers/leds/leds-s3c24xx.c
 delete mode 100644 include/linux/platform_data/leds-s3c24xx.h

diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index 3642ed8a75b4..9dbce09eabac 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -244,14 +244,6 @@ config LEDS_MT6323
 	  This option enables support for on-chip LED drivers found on
 	  Mediatek MT6323 PMIC.
 
-config LEDS_S3C24XX
-	tristate "LED Support for Samsung S3C24XX GPIO LEDs"
-	depends on LEDS_CLASS
-	depends on ARCH_S3C24XX || COMPILE_TEST
-	help
-	  This option enables support for LEDs connected to GPIO lines
-	  on Samsung S3C24XX series CPUs, such as the S3C2410 and S3C2440.
-
 config LEDS_NET48XX
 	tristate "LED Support for Soekris net48xx series Error LED"
 	depends on LEDS_CLASS
diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
index 0c1543a4a7a8..d30395d11fd8 100644
--- a/drivers/leds/Makefile
+++ b/drivers/leds/Makefile
@@ -73,7 +73,6 @@ obj-$(CONFIG_LEDS_PM8058)		+= leds-pm8058.o
 obj-$(CONFIG_LEDS_POWERNV)		+= leds-powernv.o
 obj-$(CONFIG_LEDS_PWM)			+= leds-pwm.o
 obj-$(CONFIG_LEDS_REGULATOR)		+= leds-regulator.o
-obj-$(CONFIG_LEDS_S3C24XX)		+= leds-s3c24xx.o
 obj-$(CONFIG_LEDS_SC27XX_BLTC)		+= leds-sc27xx-bltc.o
 obj-$(CONFIG_LEDS_SUNFIRE)		+= leds-sunfire.o
 obj-$(CONFIG_LEDS_SYSCON)		+= leds-syscon.o
diff --git a/drivers/leds/leds-s3c24xx.c b/drivers/leds/leds-s3c24xx.c
deleted file mode 100644
index 3c0c7aa63b8c..000000000000
diff --git a/include/linux/platform_data/leds-s3c24xx.h b/include/linux/platform_data/leds-s3c24xx.h
deleted file mode 100644
index 64f8d14876e0..000000000000
-- 
2.29.2

