Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06F3C65EDBC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 14:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232917AbjAENsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 08:48:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231823AbjAENrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 08:47:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E26C7392DE
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 05:47:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E1D361A8A
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 13:47:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47080C433F1;
        Thu,  5 Jan 2023 13:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672926435;
        bh=hn3HISdXEY51xtvJzrgO8TbVIWPbUwezVx/zrFwoZfY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OOu0etm9SyEPsON530cLE3M9D98J3SXv/oR6KUshtU9XE18FvozfgoE70ywh2tbUv
         pz2z0yAokfqjdCZ/WxKmHbcIOhCjVr0ZaGz5uAWYNWIoJ6pgRq+348PUoX20nTJxYc
         IfeZtuZBRUEDGNbImoRFZ3LLnR2M3RJuYA7s+zLC4fPuIORSSI9bhHrDUBtdLsutu6
         1cpoVtEJQxCmcUzLr7cA2qIrcXm+HIVgQY9NynVYJ9qqJ+/AoZdBKpKg2Chw0PyjVm
         ZVLKmE1pjRpXjzk9Mmz5HDcB3wF1CndfduKTM5FPC3wmYSCfwYF2Hkwu2DZNP3N/7R
         Yn4LhhgsSdrvQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Robert Jarzmik <robert.jarzmik@free.fr>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 13/27] pcmcia: remove unused pxa/sa1100 drivers
Date:   Thu,  5 Jan 2023 14:46:08 +0100
Message-Id: <20230105134622.254560-14-arnd@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230105134622.254560-1-arnd@kernel.org>
References: <20230105134622.254560-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

A number of boards got removed, so this code is now orphaned.

Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/pcmcia/Kconfig            |  12 +--
 drivers/pcmcia/Makefile           |   5 -
 drivers/pcmcia/pxa2xx_mainstone.c | 122 -----------------------
 drivers/pcmcia/sa1100_simpad.c    | 115 ----------------------
 drivers/pcmcia/sa1111_badge4.c    | 158 ------------------------------
 drivers/pcmcia/sa1111_lubbock.c   | 155 -----------------------------
 6 files changed, 2 insertions(+), 565 deletions(-)
 delete mode 100644 drivers/pcmcia/pxa2xx_mainstone.c
 delete mode 100644 drivers/pcmcia/sa1100_simpad.c
 delete mode 100644 drivers/pcmcia/sa1111_badge4.c
 delete mode 100644 drivers/pcmcia/sa1111_lubbock.c

diff --git a/drivers/pcmcia/Kconfig b/drivers/pcmcia/Kconfig
index 1525023e49b6..44c16508ef14 100644
--- a/drivers/pcmcia/Kconfig
+++ b/drivers/pcmcia/Kconfig
@@ -194,10 +194,8 @@ config PCMCIA_SA1111
 	tristate "SA1111 support"
 	depends on ARM && SA1111 && PCMCIA
 	select PCMCIA_SOC_COMMON
-	select PCMCIA_SA11XX_BASE if ARCH_SA1100
-	select PCMCIA_PXA2XX if ARCH_LUBBOCK && SA1111
+	select PCMCIA_SA11XX_BASE
 	select PCMCIA_MAX1600 if ASSABET_NEPONSET
-	select PCMCIA_MAX1600 if ARCH_LUBBOCK && SA1111
 	help
 	  Say Y  here to include support for SA1111-based PCMCIA or CF
 	  sockets, found on the Jornada 720, Graphicsmaster and other
@@ -207,14 +205,8 @@ config PCMCIA_SA1111
 
 config PCMCIA_PXA2XX
 	tristate "PXA2xx support"
-	depends on ARM && ARCH_PXA && PCMCIA
-	depends on (ARCH_LUBBOCK || MACH_MAINSTONE || PXA_SHARPSL \
-		    || ARCH_PXA_PALM || TRIZEPS_PCMCIA \
-		    || ARCOM_PCMCIA || ARCH_PXA_ESERIES \
-		    || MACH_VPAC270 || MACH_BALLOON3 || MACH_COLIBRI \
-		    || MACH_COLIBRI320 || MACH_H4700)
+	depends on ARM && ARCH_PXA && PCMCIA && PXA_SHARPSL
 	select PCMCIA_SOC_COMMON
-	select PCMCIA_MAX1600 if MACH_MAINSTONE
 	help
 	  Say Y here to include support for the PXA2xx PCMCIA controller
 
diff --git a/drivers/pcmcia/Makefile b/drivers/pcmcia/Makefile
index b3a2accf47af..c9d51b150682 100644
--- a/drivers/pcmcia/Makefile
+++ b/drivers/pcmcia/Makefile
@@ -36,17 +36,12 @@ obj-$(CONFIG_PCMCIA_MAX1600)			+= max1600.o
 
 sa1111_cs-y					+= sa1111_generic.o
 sa1111_cs-$(CONFIG_ASSABET_NEPONSET)		+= sa1111_neponset.o
-sa1111_cs-$(CONFIG_SA1100_BADGE4)		+= sa1111_badge4.o
 sa1111_cs-$(CONFIG_SA1100_JORNADA720)		+= sa1111_jornada720.o
-sa1111_cs-$(CONFIG_ARCH_LUBBOCK)		+= sa1111_lubbock.o
 
 sa1100_cs-y					+= sa1100_generic.o
 sa1100_cs-$(CONFIG_SA1100_COLLIE)		+= pxa2xx_sharpsl.o
-sa1100_cs-$(CONFIG_SA1100_H3100)		+= sa1100_h3600.o
 sa1100_cs-$(CONFIG_SA1100_H3600)		+= sa1100_h3600.o
-sa1100_cs-$(CONFIG_SA1100_SIMPAD)		+= sa1100_simpad.o
 
-pxa2xx-obj-$(CONFIG_MACH_MAINSTONE)		+= pxa2xx_mainstone.o
 pxa2xx-obj-$(CONFIG_PXA_SHARPSL)		+= pxa2xx_sharpsl.o
 obj-$(CONFIG_PCMCIA_PXA2XX)			+= pxa2xx_base.o $(pxa2xx-obj-y)
 obj-$(CONFIG_PCMCIA_XXS1500)			+= xxs1500_ss.o
diff --git a/drivers/pcmcia/pxa2xx_mainstone.c b/drivers/pcmcia/pxa2xx_mainstone.c
deleted file mode 100644
index a076e4108452..000000000000
diff --git a/drivers/pcmcia/sa1100_simpad.c b/drivers/pcmcia/sa1100_simpad.c
deleted file mode 100644
index 784ada5b8c4f..000000000000
diff --git a/drivers/pcmcia/sa1111_badge4.c b/drivers/pcmcia/sa1111_badge4.c
deleted file mode 100644
index e76d5ba921dd..000000000000
diff --git a/drivers/pcmcia/sa1111_lubbock.c b/drivers/pcmcia/sa1111_lubbock.c
deleted file mode 100644
index f1b5160cb8fa..000000000000
-- 
2.39.0

