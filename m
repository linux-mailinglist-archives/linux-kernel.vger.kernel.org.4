Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB387416C0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 18:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231831AbjF1Qsk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 12:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbjF1QsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 12:48:20 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC95210B;
        Wed, 28 Jun 2023 09:48:19 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1b7e6512973so1044625ad.3;
        Wed, 28 Jun 2023 09:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687970898; x=1690562898;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wp97cGGpKr64bUZG2HsIrRL1H4FjGhOC/kMVFyCMzf8=;
        b=FSGDU7NlG8PeyFJEJEEBv6tE/GDYvudPVH7ysSaPc/LdPy9v0r0hxtd3TMbIkGkjCB
         9WDL7pA6Gvd166G2iHQNMGmHcsROaQul3p68o6dnGZIdJl7K6H9Ps7wpsoywYF+ZCp/f
         GKgShm/+vT3YalEz52rY+g2TqEu/XrJrBzXab0IJccy7W2CxvwSnpRPxrSTdjWOy1JQC
         +sYAz7WYDe5H7R+xlWQ6OF9rt1C+2U6Q5T49TosC0l+qpZMrnOWy+c6reDxC+ZR7dZ9F
         esoTtAaLJBoahP5T2b6RY/hqzTlPu31YMfuTK1TKnkyC0LMZEBPnNiKIj3W9LP75hfxl
         ItVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687970898; x=1690562898;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wp97cGGpKr64bUZG2HsIrRL1H4FjGhOC/kMVFyCMzf8=;
        b=bOBxV5m2B/tvXHk7b1cwwPD3ZYKo2XR2hwU7jqwPYbry6mzS2p+D4uKXItbG5BzCsO
         FCTL04OVDtRB8PLKwB3Y6nMdZsL7OrucgY9Mz+RH/wVuMReOGUGM8NV0gvXEcBxx1cWY
         G17az/cDVaqd8xUkJLdSxbJnSYg0kDK+HqaiN77dGe331jdr6sNW9NWj0Rf9z2N7/hGq
         yot5Q/ZomLAoSVq6WxLpsqNEEhLXjLIQQ8WGbzZTzH5FidBCGyPBpSXuFN/3ykUB6qTy
         cKmhtBdXiOrXF9DHLyl83COnzhy+WSPHyVNL7ZTeEFjhpbmZF2KqRZ7CiFED2inAl0E9
         lyBg==
X-Gm-Message-State: AC+VfDw+a7sP1eD5/niwPHKXuAtignO3HbLYsmMHEPWTeZ0k8YiHDZiM
        pDV4/Z4FmBSd+s0oKmlZhow=
X-Google-Smtp-Source: ACHHUZ5yIpKRZwCdR+tbijRQabMXEhbZXBA+ET3pD1NIQ5tWmMWdS5ewR9m0gZpDIpBRIhrcdegezA==
X-Received: by 2002:a17:90a:1999:b0:25e:ad19:5f46 with SMTP id 25-20020a17090a199900b0025ead195f46mr23301757pji.12.1687970898452;
        Wed, 28 Jun 2023 09:48:18 -0700 (PDT)
Received: from 377044c6c369.cse.ust.hk (191host097.mobilenet.cse.ust.hk. [143.89.191.97])
        by smtp.gmail.com with ESMTPSA id ob11-20020a17090b390b00b00262dc783974sm6733914pjb.31.2023.06.28.09.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 09:48:17 -0700 (PDT)
From:   Chengfeng Ye <dg573847474@gmail.com>
To:     krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com,
        wim@linux-watchdog.org, linux@roeck-us.net
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chengfeng Ye <dg573847474@gmail.com>
Subject: [PATCH] watchdog: s3c2410: Fix potential deadlock on &wdt->lock
Date:   Wed, 28 Jun 2023 16:47:59 +0000
Message-Id: <20230628164759.67594-1-dg573847474@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As &wdt->lock is acquired by hard irq s3c2410wdt_irq(),
other acquisition of the same lock under process context should
disable irq, otherwise deadlock could happen if the
irq preempt the execution while the lock is held in process context
on the same CPU.

  [Interrupt]: s3c2410wdt_irq
    -->/root/linux/drivers/watchdog/s3c2410_wdt.c:547
    -->/root/linux/drivers/watchdog/s3c2410_wdt.c:383
    -->spin_lock(&wdt->lock);

  [Process Context]: s3c2410wdt_suspend
    -->/root/linux/drivers/watchdog/s3c2410_wdt.c:764
    -->/root/linux/drivers/watchdog/s3c2410_wdt.c:403
    -->spin_lock(&wdt->lock);

  [Process Context]: s3c2410wdt_probe
    -->/root/linux/drivers/watchdog/s3c2410_wdt.c:710
    -->/root/linux/drivers/watchdog/s3c2410_wdt.c:415
    -->spin_lock(&wdt->lock);

This flaw was found by an experimental static analysis tool I am
developing for irq-related deadlock, which reported the above
warning when analyzing the linux kernel 6.4-rc7 release.

The tentative patch fix the potential deadlock by spin_lock_irqsave().

Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
---
 drivers/watchdog/s3c2410_wdt.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
index 95416a9bdd4b..2dfc0d6a3004 100644
--- a/drivers/watchdog/s3c2410_wdt.c
+++ b/drivers/watchdog/s3c2410_wdt.c
@@ -399,10 +399,11 @@ static void __s3c2410wdt_stop(struct s3c2410_wdt *wdt)
 static int s3c2410wdt_stop(struct watchdog_device *wdd)
 {
 	struct s3c2410_wdt *wdt = watchdog_get_drvdata(wdd);
+	unsigned long flags;
 
-	spin_lock(&wdt->lock);
+	spin_lock_irqsave(&wdt->lock, flags);
 	__s3c2410wdt_stop(wdt);
-	spin_unlock(&wdt->lock);
+	spin_unlock_irqrestore(&wdt->lock, flags);
 
 	return 0;
 }
@@ -411,8 +412,9 @@ static int s3c2410wdt_start(struct watchdog_device *wdd)
 {
 	unsigned long wtcon;
 	struct s3c2410_wdt *wdt = watchdog_get_drvdata(wdd);
+	unsigned long flags;
 
-	spin_lock(&wdt->lock);
+	spin_lock_irqsave(&wdt->lock, flags);
 
 	__s3c2410wdt_stop(wdt);
 
@@ -433,7 +435,7 @@ static int s3c2410wdt_start(struct watchdog_device *wdd)
 	writel(wdt->count, wdt->reg_base + S3C2410_WTDAT);
 	writel(wdt->count, wdt->reg_base + S3C2410_WTCNT);
 	writel(wtcon, wdt->reg_base + S3C2410_WTCON);
-	spin_unlock(&wdt->lock);
+	spin_unlock_irqrestore(&wdt->lock, flags);
 
 	return 0;
 }
-- 
2.17.1

