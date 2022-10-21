Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8879860804F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 22:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbiJUUvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 16:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbiJUUvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 16:51:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5BDE27D4D0;
        Fri, 21 Oct 2022 13:51:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 73D6761F60;
        Fri, 21 Oct 2022 20:51:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D309C43149;
        Fri, 21 Oct 2022 20:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666385490;
        bh=C4YwxPFCdn3Q3GHys925rodFzN+q7UHUwPccx2jNShc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HQtVdqaNmHZ/taeMNFPmG7a4fViYi1t6Imch4kFB2/CtGws0J3W2N4Q70nyTedXD7
         Iaqc1glp/Qqi4RurV3kA6WoH2LIobw1Xw8QtiGGpnSiXTQqJrc4N4zuPpeU6qncgZo
         DEdMG5qvagQdysAk+HyaEpaI0xwUE1Uimdw93Jd9onfytCAW6gUIHJS0d0o0bfGa+p
         IY2aQSiYX7voytQxkxUFpGWLheJe0QrsuZaIL1zFf27gmpNnsb06dtKFqJE2IzCYcJ
         1uqPkZerexOVUpwkd9TkRVwNQlriwBtV5oMVU1VczQKLnYqbpMmaLL9y82+biK/imo
         pNgbo68E+N40A==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>,
        Simtec Linux Team <linux@simtec.co.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: [PATCH 18/21] pinctrl: remove s3c24xx driver
Date:   Fri, 21 Oct 2022 22:27:51 +0200
Message-Id: <20221021203329.4143397-18-arnd@kernel.org>
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

The s3c24xx platform was removed, so this driver has no
remaining users.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/pinctrl/samsung/Kconfig           |   5 -
 drivers/pinctrl/samsung/Makefile          |   1 -
 drivers/pinctrl/samsung/pinctrl-s3c24xx.c | 653 ----------------------
 3 files changed, 659 deletions(-)
 delete mode 100644 drivers/pinctrl/samsung/pinctrl-s3c24xx.c

diff --git a/drivers/pinctrl/samsung/Kconfig b/drivers/pinctrl/samsung/Kconfig
index 7b0576f71376..697ff7812d8e 100644
--- a/drivers/pinctrl/samsung/Kconfig
+++ b/drivers/pinctrl/samsung/Kconfig
@@ -23,11 +23,6 @@ config PINCTRL_EXYNOS_ARM64
 	bool "ARMv8-specific pinctrl driver for Samsung Exynos SoCs" if COMPILE_TEST
 	depends on PINCTRL_EXYNOS
 
-config PINCTRL_S3C24XX
-	bool "Samsung S3C24XX SoC pinctrl driver"
-	depends on ARCH_S3C24XX || (COMPILE_TEST && OF)
-	select PINCTRL_SAMSUNG
-
 config PINCTRL_S3C64XX
 	bool "Samsung S3C64XX SoC pinctrl driver"
 	depends on ARCH_S3C64XX || (COMPILE_TEST && OF)
diff --git a/drivers/pinctrl/samsung/Makefile b/drivers/pinctrl/samsung/Makefile
index ed951df6a112..4dd4a92ab6cc 100644
--- a/drivers/pinctrl/samsung/Makefile
+++ b/drivers/pinctrl/samsung/Makefile
@@ -5,5 +5,4 @@ obj-$(CONFIG_PINCTRL_SAMSUNG)	+= pinctrl-samsung.o
 obj-$(CONFIG_PINCTRL_EXYNOS)	+= pinctrl-exynos.o
 obj-$(CONFIG_PINCTRL_EXYNOS_ARM)	+= pinctrl-exynos-arm.o
 obj-$(CONFIG_PINCTRL_EXYNOS_ARM64)	+= pinctrl-exynos-arm64.o
-obj-$(CONFIG_PINCTRL_S3C24XX)	+= pinctrl-s3c24xx.o
 obj-$(CONFIG_PINCTRL_S3C64XX)	+= pinctrl-s3c64xx.o
diff --git a/drivers/pinctrl/samsung/pinctrl-s3c24xx.c b/drivers/pinctrl/samsung/pinctrl-s3c24xx.c
deleted file mode 100644
index 625cb1065eaf..000000000000
-- 
2.29.2

