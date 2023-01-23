Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3BC66789F8
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 22:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232225AbjAWVuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 16:50:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231795AbjAWVtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 16:49:50 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599C130EBE;
        Mon, 23 Jan 2023 13:49:49 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 30NLncu8081763;
        Mon, 23 Jan 2023 15:49:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1674510578;
        bh=7XCye61hg/Rgo206QobEiB6A7evWrDxeQJjoMXiyNpE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=A0XqtrLB10MwPNXuRI5f7RX2gTliCwcVyeRtrh2yikb0BAM1coZEjfxBGUDdR5AAo
         UmMweNmI8TBh7jJMLr/8lpJN2WjIoStr/ob55wwl0hQK73DPE9sBunyjQw3HHrQPU5
         KGWuSw2nvLB/AyWmpOuMFEyHBOVjRIuiF+s702YI=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 30NLnc4o043995
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 23 Jan 2023 15:49:38 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 23
 Jan 2023 15:49:38 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 23 Jan 2023 15:49:38 -0600
Received: from ula0226330.dal.design.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 30NLnPZt065237;
        Mon, 23 Jan 2023 15:49:36 -0600
From:   Andrew Davis <afd@ti.com>
To:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Daniel Tang <dt.tangr@gmail.com>,
        Fabian Vogt <fabian@ritter-vogt.de>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH v5 9/9] ARM: nspire: Remove unused header file mmio.h
Date:   Mon, 23 Jan 2023 15:49:24 -0600
Message-ID: <20230123214924.27476-10-afd@ti.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230123214924.27476-1-afd@ti.com>
References: <20230123214924.27476-1-afd@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
2.38.1

