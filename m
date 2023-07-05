Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76A2A747E2C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 09:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232261AbjGEHYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 03:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232259AbjGEHX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 03:23:57 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8944510D5;
        Wed,  5 Jul 2023 00:23:53 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-1b06ea7e7beso5935003fac.0;
        Wed, 05 Jul 2023 00:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688541833; x=1691133833;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UtRultwczflx7AHsIym9/WcCjEB4FHHPYH8wgJ+7ZX8=;
        b=V7LGiFMGlYLr2yn2Y0Rzccc4dgCcZ4tSHNjP7HzaTPY7G3TuyCEiD6WeJU+gnysCcf
         NF73WRKgDoZD3cAQOlonlktwqDWlYoeJXwUC5df8A4iB2pUD623LDjHudXB1K+YtCC4Q
         PkThH5LwdetekBVPTjuQ3pLpfaaayKr1q3XaN7swpKAqoukoQh1GmOoGf2VeMv+N6nM7
         ySMNNcwehuOmdrG6bBivGTEN4ieYXCbLKQv0PP1S+ibDF1BXj14CcaElwSjMEraQQphw
         68sabzJuDsW4DXGgWoGDDM76KcpZQUjv5BKJ/ZqU7vi2Mexb7i8IoVbY9G9cwI1ouhGd
         xPCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688541833; x=1691133833;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UtRultwczflx7AHsIym9/WcCjEB4FHHPYH8wgJ+7ZX8=;
        b=Cg79wjuVg05AD20vVE+hT6VB8K9Rr0Emx/MSuD9WZBrDdAQDzTT1Za73cAGmJHJy/7
         5MzSBMgPsTOHtEy4FwxqjPReSYYwn4UOij4e5hbfMao4AJTBhrIL2Ik1mILjPGGGBrTE
         enjo9vw9CAy/TCbaEE+bkHdlB8MQ9DP1dw4g5E05InGF7UjM3zCIG+8cr0eZqdcIRlwR
         BTNIBWolwbN9p+W0ptsUJALtE3GFWYApAh/gOrpZrrzKUFOP3oIuRi/uX21HbdHL8qTF
         sL5bOawvMQ9Mv6iWP1bN3Q7bBEg4mrd2LtgJIAV90dh/ZOpDRJNu6Cm+giYT0ltxZUfm
         80dg==
X-Gm-Message-State: ABy/qLakaqYf7SIP7fuynuvWG4vy2ICewEbc18/Sp6oFf/8GokNtwVkX
        n+FunmVQM1m7fVSeApkINB8=
X-Google-Smtp-Source: APBJJlGKTDdDczDO9DBJTucbfA58+S106cvsp3S/i5Bqu4Q7tkykGKqJvUQTxUZLj0/YpjVamFiLVg==
X-Received: by 2002:a05:6871:4f18:b0:1b3:cee4:cac9 with SMTP id zu24-20020a0568714f1800b001b3cee4cac9mr3731186oab.33.1688541832660;
        Wed, 05 Jul 2023 00:23:52 -0700 (PDT)
Received: from 377044c6c369.cse.ust.hk (191host097.mobilenet.cse.ust.hk. [143.89.191.97])
        by smtp.gmail.com with ESMTPSA id k19-20020a056870d0d300b001b3a5ab6cacsm3781314oaa.16.2023.07.05.00.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 00:23:52 -0700 (PDT)
From:   Chengfeng Ye <dg573847474@gmail.com>
To:     krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com,
        wim@linux-watchdog.org, linux@roeck-us.net
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chengfeng Ye <dg573847474@gmail.com>
Subject: [PATCH v2] watchdog: s3c2410: Fix potential deadlock on &wdt->lock
Date:   Wed,  5 Jul 2023 07:23:04 +0000
Message-Id: <20230705072304.37741-1-dg573847474@gmail.com>
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

As &wdt->lock is acquired by hard irq s3c2410wdt_irq(), other
acquisition of the same lock under process context should
disable irq, otherwise deadlock could happen if the irq preempt
the execution while the lock is held in process context on the
same CPU.

[Deadlock Scenario]
s3c2410wdt_suspend()
    -> s3c2410wdt_stop()
    -> spin_lock(&wdt->lock)
        <irq iterrupt>
        -> s3c2410wdt_irq()
        -> s3c2410wdt_keepalive()
        -> spin_lock(&wdt->lock) (deadlock here)

[Deadlock Scenario]
s3c2410wdt_probe()
    -> s3c2410wdt_start()
    -> spin_lock(&wdt->lock)
        <irq iterrupt>
        -> s3c2410wdt_irq()
        -> s3c2410wdt_keepalive()
        -> spin_lock(&wdt->lock) (deadlock here)

This flaw was found by an experimental static analysis tool I am
developing for irq-related deadlock, which reported the above
warning when analyzing the linux kernel 6.4-rc7 release.

The tentative patch fix the potential deadlock by spin_lock_irqsave()
under process context.

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

