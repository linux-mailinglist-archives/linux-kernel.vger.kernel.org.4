Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4B946B0BE4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 15:53:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbjCHOxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 09:53:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbjCHOxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 09:53:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5540B2B286;
        Wed,  8 Mar 2023 06:53:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 100CCB81D17;
        Wed,  8 Mar 2023 14:53:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20E12C433EF;
        Wed,  8 Mar 2023 14:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678287189;
        bh=KY/P29fSceY4YvXg19e8r4ZqvqGUxtI5Al1OzNjEDLg=;
        h=From:To:Cc:Subject:Date:From;
        b=VQ3fO86u6OdqktIbxmE/h79bUox/WkF9hZaHnrvT2ASJ9AWtEXXk+3DmZuA/uwYQ1
         FyJooH+oXcu+6CtrG6ISDOH0rcOkBR1L9yPqtLQyoMslNdzE4smzQ7dx4tHIeAkcUF
         QaQyJ6Thk5dICrs9f4nftyimHojT9WlWov0R2bWB40PTYq2uzGpxeu5l9lbSM3s194
         KDiqkBfWUnRjpRaOD4GeRUHlxlgsCmqBUQbu/xPKWz4nH9thD9o2bUWJR1X20AFlFb
         OAd59ROppC7HF+4NEVXGFF7eqQyfCcdPLwYblp5NxB1PJAZlICM33kNsWeDNdAknbi
         anYT2UL+z7oNA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mips: ar71: include linux/gpio/driver.h
Date:   Wed,  8 Mar 2023 15:52:53 +0100
Message-Id: <20230308145303.826942-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The change to remove the implicit gpio/driver.h include was done
after fixing all the other users, but the ar7 file still needs
the same change.

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Fixes: 21d9526d13b5 ("gpiolib: Make the legacy <linux/gpio.h> consumer-only")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/mips/ar7/gpio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/ar7/gpio.c b/arch/mips/ar7/gpio.c
index ae0e01b9438f..4ed833b9cc2f 100644
--- a/arch/mips/ar7/gpio.c
+++ b/arch/mips/ar7/gpio.c
@@ -7,7 +7,7 @@
 
 #include <linux/init.h>
 #include <linux/export.h>
-#include <linux/gpio.h>
+#include <linux/gpio/driver.h>
 
 #include <asm/mach-ar7/ar7.h>
 
-- 
2.39.2

