Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69185607B90
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 17:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbiJUPyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 11:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbiJUPyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 11:54:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 806C727D4D8
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 08:54:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6A56CB82A47
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 15:54:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2BF1C433D6;
        Fri, 21 Oct 2022 15:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666367654;
        bh=YIHBEzPM9Cv9Y2LCFh9IV1aRzulaJHiC6d8jP3aN1Yg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RbX06NgPeDyB+ufxvzRhFAo+EHJM4scQeiYnN/uCSMJ6PEcGf9i2rk6sQOtrE0xlC
         LPFLrkn5qFcvRCLLB0wK+E2O2aG4Y0svXdW1x1m8po8IZul12ist1Y2L2I347TiMn5
         rk8iynnm3bdoS3gmyjOqjWYzelf9NKP1BLoIHvuSEq6r1Rxnu+1fwv6IOeancbOT99
         HyVhdu5qSzDBI3xXmFuuAZjJrvci7qg1s3m0rKaMlQHUPRvgmhi3O+lRi5TIchl+Qt
         j3O95PfdfqU/6ERLNpaI04GbROfLV1vB6jz/NFXzCBu35fIx9jc6zLdhZQpBpzdNMi
         J1iZv7qeI6n6w==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-arm-kernel@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lubomir Rintel <lkundrak@v3.sk>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 03/11] ARM: sa1100: remove irda references
Date:   Fri, 21 Oct 2022 17:49:33 +0200
Message-Id: <20221021155000.4108406-4-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20221021155000.4108406-1-arnd@kernel.org>
References: <20221021155000.4108406-1-arnd@kernel.org>
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

IRDA support is long gone, so there is no need to declare the
platform device structure.

See-also: d64c2a76123f ("staging: irda: remove the irda network stack and drivers")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-sa1100/assabet.c            |  1 -
 arch/arm/mach-sa1100/collie.c             |  1 -
 arch/arm/mach-sa1100/h3600.c              |  1 -
 include/linux/platform_data/irda-sa11x0.h | 17 -----------------
 4 files changed, 20 deletions(-)
 delete mode 100644 include/linux/platform_data/irda-sa11x0.h

diff --git a/arch/arm/mach-sa1100/assabet.c b/arch/arm/mach-sa1100/assabet.c
index 9919e0f32c4b..a71bdc634876 100644
--- a/arch/arm/mach-sa1100/assabet.c
+++ b/arch/arm/mach-sa1100/assabet.c
@@ -38,7 +38,6 @@
 
 #include <asm/mach/arch.h>
 #include <asm/mach/flash.h>
-#include <linux/platform_data/irda-sa11x0.h>
 #include <asm/mach/map.h>
 #include <mach/assabet.h>
 #include <linux/platform_data/mfd-mcp-sa11x0.h>
diff --git a/arch/arm/mach-sa1100/collie.c b/arch/arm/mach-sa1100/collie.c
index 14c33ed05318..92c9ea7d7d25 100644
--- a/arch/arm/mach-sa1100/collie.c
+++ b/arch/arm/mach-sa1100/collie.c
@@ -44,7 +44,6 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/flash.h>
 #include <asm/mach/map.h>
-#include <linux/platform_data/irda-sa11x0.h>
 
 #include <asm/hardware/scoop.h>
 #include <asm/mach/sharpsl_param.h>
diff --git a/arch/arm/mach-sa1100/h3600.c b/arch/arm/mach-sa1100/h3600.c
index baf529117b26..05aa707e239e 100644
--- a/arch/arm/mach-sa1100/h3600.c
+++ b/arch/arm/mach-sa1100/h3600.c
@@ -14,7 +14,6 @@
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
-#include <linux/platform_data/irda-sa11x0.h>
 
 #include <mach/h3xxx.h>
 #include <mach/irqs.h>
diff --git a/include/linux/platform_data/irda-sa11x0.h b/include/linux/platform_data/irda-sa11x0.h
deleted file mode 100644
index 7db59c917575..000000000000
--- a/include/linux/platform_data/irda-sa11x0.h
+++ /dev/null
@@ -1,17 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- *  arch/arm/include/asm/mach/irda.h
- *
- *  Copyright (C) 2004 Russell King.
- */
-#ifndef __ASM_ARM_MACH_IRDA_H
-#define __ASM_ARM_MACH_IRDA_H
-
-struct irda_platform_data {
-	int (*startup)(struct device *);
-	void (*shutdown)(struct device *);
-	int (*set_power)(struct device *, unsigned int state);
-	void (*set_speed)(struct device *, unsigned int speed);
-};
-
-#endif
-- 
2.29.2

