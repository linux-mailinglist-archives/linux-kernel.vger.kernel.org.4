Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8205742BE4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 20:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233751AbjF2S3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 14:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233732AbjF2S3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 14:29:51 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B363511F
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 11:29:50 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-1b056276889so837885fac.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 11:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688063390; x=1690655390;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yzlCooZrySxX3D5B/BDO0IhQKKmLaPMvfVToW+n+i3k=;
        b=Np5XJWjCoPNH2CXEhpS5LUVIDURBItN+Upeyi7iPZDw05LkpAIRZQ8kRqNPl+Av0Jf
         sl5C3UHdBKg8tHZ94kIkwCxOjSAeqRtOc87WSJLduhgQL9rX9m1rd1U5PGV/wJjoNTGJ
         K1+YSpIkshVDclw0V2Kf/AqP+yYiEyC5S1AojZcZ1lhqYBetR1yrgcdt61jnJkwQcRmQ
         F9SGJvgD2pFp8WNlRmJhx0gWsICS/oWT76WWgbIXsBDyj7HGp7Ibde9WeoUQVRfMHUh1
         9/i/62WAbLUm/7BAa6MrEe5mhrPk248UHot0+PATJd8lclYsxvL0yVxAraNBqrm7BZbX
         LILg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688063390; x=1690655390;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yzlCooZrySxX3D5B/BDO0IhQKKmLaPMvfVToW+n+i3k=;
        b=SXqr4FINaa1wKP+wuO3yp4P2+QXO3kvMxOJvOgv3VmxdL4VJylQo4fmHF9NLrBWDZm
         zfZcHs7nFgbcTB39QAmrIZmaUjFDqHHAxvfCt647Ny7q4yvq6Zqcxq5JaEI44GbBRO2m
         nAXEc0BW1DXJ2VZZr1aY4DvwmBVZ5GshZuHUj2zQuATm3CKEdFQulhXzqAMYziGgaWrq
         C9Pgn/bc3783lmMuhTYz7ySYzXlIMsMDUMtQeIUkdMf5dPL2kkE8OwWcg/xgk2y3Woq8
         xQ9ym8yDsEXCCfKCxbJuvnbhr1q4lumpMEIXgWC8RBRJDVUgyRcjyg3BgQJMVw3G5iDs
         keIg==
X-Gm-Message-State: ABy/qLay2mDbWVjxamVWdDzUCwFVD4rBUo7Bb1F9Xi7ovsxbqm2YyF/u
        5Wvwp3APG2n5guUfD04EbUTbXtcHKMEyGQ==
X-Google-Smtp-Source: ACHHUZ7Oubk7JiwXaYP0AhYdpZqMDTWJRKL1deEKjB59Q3mnLIdpQWCCsACCsGFgjGQJllzBkrhYHQ==
X-Received: by 2002:a05:6871:28d:b0:1ac:de6c:5534 with SMTP id i13-20020a056871028d00b001acde6c5534mr827426oae.54.1688063389966;
        Thu, 29 Jun 2023 11:29:49 -0700 (PDT)
Received: from 377044c6c369.cse.ust.hk (191host097.mobilenet.cse.ust.hk. [143.89.191.97])
        by smtp.gmail.com with ESMTPSA id a18-20020a056870b15200b001b3538afd01sm10787oal.51.2023.06.29.11.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 11:29:49 -0700 (PDT)
From:   Chengfeng Ye <dg573847474@gmail.com>
To:     scott.branden@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Chengfeng Ye <dg573847474@gmail.com>
Subject: [PATCH v3] misc: bcm_vk: Fix potential deadlock on &vk->ctx_lock
Date:   Thu, 29 Jun 2023 18:29:41 +0000
Message-Id: <20230629182941.13045-1-dg573847474@gmail.com>
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

As &vk->ctx_lock is acquired by timer bcm_vk_hb_poll() under softirq
context, other process context code should disable irq or bottom-half
before acquire the same lock, otherwise deadlock could happen if the
timer preempt the execution while the lock is held in process context
on the same CPU.

Possible deadlock scenario
bcm_vk_open()
    -> bcm_vk_get_ctx()
    -> spin_lock(&vk->ctx_lock)
	<timer iterrupt>
	-> bcm_vk_hb_poll()
	-> bcm_vk_blk_drv_access()
	-> spin_lock_irqsave(&vk->ctx_lock, flags) (deadlock here)

This flaw was found using an experimental static analysis tool we are
developing for irq-related deadlock, which reported the following
warning when analyzing the linux kernel 6.4-rc7 release.

[Deadlock]: &vk->ctx_lock
  [Interrupt]: bcm_vk_hb_poll
    -->/root/linux/drivers/misc/bcm-vk/bcm_vk_msg.c:176
    -->/root/linux/drivers/misc/bcm-vk/bcm_vk_dev.c:512
  [Locking Unit]: bcm_vk_ioctl
    -->/root/linux/drivers/misc/bcm-vk/bcm_vk_dev.c:1181
    -->/root/linux/drivers/misc/bcm-vk/bcm_vk_dev.c:512

[Deadlock]: &vk->ctx_lock
  [Interrupt]: bcm_vk_hb_poll
    -->/root/linux/drivers/misc/bcm-vk/bcm_vk_msg.c:176
    -->/root/linux/drivers/misc/bcm-vk/bcm_vk_dev.c:512
  [Locking Unit]: bcm_vk_ioctl
    -->/root/linux/drivers/misc/bcm-vk/bcm_vk_dev.c:1169

[Deadlock]: &vk->ctx_lock
  [Interrupt]: bcm_vk_hb_poll
    -->/root/linux/drivers/misc/bcm-vk/bcm_vk_msg.c:176
    -->/root/linux/drivers/misc/bcm-vk/bcm_vk_dev.c:512
  [Locking Unit]: bcm_vk_open
    -->/root/linux/drivers/misc/bcm-vk/bcm_vk_msg.c:216

[Deadlock]: &vk->ctx_lock
  [Interrupt]: bcm_vk_hb_poll
    -->/root/linux/drivers/misc/bcm-vk/bcm_vk_msg.c:176
    -->/root/linux/drivers/misc/bcm-vk/bcm_vk_dev.c:512
  [Locking Unit]: bcm_vk_release
    -->/root/linux/drivers/misc/bcm-vk/bcm_vk_msg.c:306

As suggested by Arnd, the tentative patch fix the potential deadlocks
by replacing the timer with delay workqueue. x86_64 allyesconfig using
GCC shows no new warning. Note that no runtime testing was performed
due to no device on hand.

Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
---
 drivers/misc/bcm-vk/bcm_vk.h     |  2 +-
 drivers/misc/bcm-vk/bcm_vk_msg.c | 14 +++++++-------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/bcm-vk/bcm_vk.h b/drivers/misc/bcm-vk/bcm_vk.h
index 25d51222eedf..386884c2a263 100644
--- a/drivers/misc/bcm-vk/bcm_vk.h
+++ b/drivers/misc/bcm-vk/bcm_vk.h
@@ -340,7 +340,7 @@ struct bcm_vk_proc_mon_info {
 };
 
 struct bcm_vk_hb_ctrl {
-	struct timer_list timer;
+	struct delayed_work work;
 	u32 last_uptime;
 	u32 lost_cnt;
 };
diff --git a/drivers/misc/bcm-vk/bcm_vk_msg.c b/drivers/misc/bcm-vk/bcm_vk_msg.c
index 3c081504f38c..e17d81231ea6 100644
--- a/drivers/misc/bcm-vk/bcm_vk_msg.c
+++ b/drivers/misc/bcm-vk/bcm_vk_msg.c
@@ -137,11 +137,11 @@ void bcm_vk_set_host_alert(struct bcm_vk *vk, u32 bit_mask)
 #define BCM_VK_HB_TIMER_VALUE (BCM_VK_HB_TIMER_S * HZ)
 #define BCM_VK_HB_LOST_MAX (27 / BCM_VK_HB_TIMER_S)
 
-static void bcm_vk_hb_poll(struct timer_list *t)
+static void bcm_vk_hb_poll(struct work_struct *work)
 {
 	u32 uptime_s;
-	struct bcm_vk_hb_ctrl *hb = container_of(t, struct bcm_vk_hb_ctrl,
-						 timer);
+	struct bcm_vk_hb_ctrl *hb = container_of(to_delayed_work(work), struct bcm_vk_hb_ctrl,
+						 work);
 	struct bcm_vk *vk = container_of(hb, struct bcm_vk, hb_ctrl);
 
 	if (bcm_vk_drv_access_ok(vk) && hb_mon_is_on()) {
@@ -177,22 +177,22 @@ static void bcm_vk_hb_poll(struct timer_list *t)
 		bcm_vk_set_host_alert(vk, ERR_LOG_HOST_HB_FAIL);
 	}
 	/* re-arm timer */
-	mod_timer(&hb->timer, jiffies + BCM_VK_HB_TIMER_VALUE);
+	schedule_delayed_work(&hb->work, BCM_VK_HB_TIMER_VALUE);
 }
 
 void bcm_vk_hb_init(struct bcm_vk *vk)
 {
 	struct bcm_vk_hb_ctrl *hb = &vk->hb_ctrl;
 
-	timer_setup(&hb->timer, bcm_vk_hb_poll, 0);
-	mod_timer(&hb->timer, jiffies + BCM_VK_HB_TIMER_VALUE);
+	INIT_DELAYED_WORK(&hb->work, bcm_vk_hb_poll);
+	schedule_delayed_work(&hb->work, BCM_VK_HB_TIMER_VALUE);
 }
 
 void bcm_vk_hb_deinit(struct bcm_vk *vk)
 {
 	struct bcm_vk_hb_ctrl *hb = &vk->hb_ctrl;
 
-	del_timer(&hb->timer);
+	cancel_delayed_work_sync(&hb->work);
 }
 
 static void bcm_vk_msgid_bitmap_clear(struct bcm_vk *vk,
-- 
2.17.1

