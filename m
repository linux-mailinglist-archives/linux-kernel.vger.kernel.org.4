Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49FE260E554
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 18:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234693AbiJZQN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 12:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234672AbiJZQNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 12:13:22 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 358EC95267;
        Wed, 26 Oct 2022 09:13:20 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29QGD49X093126;
        Wed, 26 Oct 2022 11:13:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1666800784;
        bh=5AJeBJwCUa9BWZZmmaVkzM9xz4RJkm0ZLGTqRR/eOmw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=YtGiPvDzyF011cv9vW1Ybp2fhPwkuwc1cl6kROrS64ChDBHA6YdXDe12Syb0ufqkc
         51qmMzkPj8YY1uY/vgQvpZP//i/XOYsQQGgVCIRRxjCQUtMr70zW9EvohF/5ArO4KU
         W4ByBsoFUJZvSBrH83f/ucr9Ul+OH9nucUrjammQ=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29QGD4c6012465
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 Oct 2022 11:13:04 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Wed, 26
 Oct 2022 11:13:03 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Wed, 26 Oct 2022 11:13:04 -0500
Received: from ula0226330.dal.design.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29QGD28D006482;
        Wed, 26 Oct 2022 11:13:03 -0500
From:   Andrew Davis <afd@ti.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Daniel Tang <dt.tangr@gmail.com>,
        Fabian Vogt <fabian@ritter-vogt.de>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Andrew Davis <afd@ti.com>
Subject: [PATCH v2 2/2] ARM: nspire: Remove unused header file mmio.h
Date:   Wed, 26 Oct 2022 11:13:02 -0500
Message-ID: <20221026161302.5319-3-afd@ti.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221026161302.5319-1-afd@ti.com>
References: <20221026161302.5319-1-afd@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Nspire boardfile platform drivers have all been converted. None
of the definitions in this header are used anymore. Remove it.

While here lets remove all the other unused headers and the file
name from in the file itself.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm/mach-nspire/mmio.h   | 13 -------------
 arch/arm/mach-nspire/nspire.c | 14 --------------
 2 files changed, 27 deletions(-)
 delete mode 100644 arch/arm/mach-nspire/mmio.h

diff --git a/arch/arm/mach-nspire/mmio.h b/arch/arm/mach-nspire/mmio.h
deleted file mode 100644
index 2ce0656139ec..000000000000
--- a/arch/arm/mach-nspire/mmio.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- *	linux/arch/arm/mach-nspire/mmio.h
- *
- *	Copyright (C) 2013 Daniel Tang <tangrs@tangrs.id.au>
- */
-
-#define NSPIRE_PWR_PHYS_BASE		0x900B0000
-#define NSPIRE_PWR_VIRT_BASE		0xFEEB0000
-#define NSPIRE_PWR_BUS_DISABLE1		0x18
-#define NSPIRE_PWR_BUS_DISABLE2		0x20
-
-#define NSPIRE_LCD_PHYS_BASE		0xC0000000
diff --git a/arch/arm/mach-nspire/nspire.c b/arch/arm/mach-nspire/nspire.c
index 1e13337972dd..2fbfc23237ff 100644
--- a/arch/arm/mach-nspire/nspire.c
+++ b/arch/arm/mach-nspire/nspire.c
@@ -1,23 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- *	linux/arch/arm/mach-nspire/nspire.c
- *
  *	Copyright (C) 2013 Daniel Tang <tangrs@tangrs.id.au>
  */
-#include <linux/init.h>
-#include <linux/of_irq.h>
-#include <linux/of_address.h>
-#include <linux/of_platform.h>
-#include <linux/irqchip.h>
-#include <linux/irqchip/arm-vic.h>
-#include <linux/clkdev.h>
-#include <linux/amba/bus.h>
 
 #include <asm/mach/arch.h>
-#include <asm/mach-types.h>
-#include <asm/mach/map.h>
-
-#include "mmio.h"
 
 static const char *const nspire_dt_match[] __initconst = {
 	"ti,nspire",
-- 
2.37.3

