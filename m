Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E47615F1640
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 00:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232666AbiI3Wlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 18:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232447AbiI3Wlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 18:41:46 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D5C1A0D25
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 15:41:44 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id j7so6243749vsr.13
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 15:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=kLMtBHE1SobS5J1i+DMR/xQLtQIgTYH1RsWrA96Sp0o=;
        b=g1yYt4wwrKXhoQhp6Q5+mhs3/+ttTJEJiR5ix9RndxpO7YrO6rKG2lCufG8DoXwRp6
         yPh3ARjjL3a+xk8G+CQmih3/8uJMyuzgRH0B0ieDNkrmUsF8CCdRcuvvuPG1kzCbT2fF
         ZAhjTXw3cWidSYl6+oL0XeqV4aNHKDrRWms51tbhYuwcFPyZ7cz7q5eYyQG4nZQTVWYL
         RqHW5h4X4HYjc2/PLrVmBU6FrsxsBeWhIGXm/MTRSqzlZ8F20uHJfJxCtmsyxfKWMcGW
         QnnOrTVmhjWiABBt/yL/FGhKyAn+J32mKeLBji6fVW719wmhaNe5qksiEzW1IT5y0zDp
         onsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=kLMtBHE1SobS5J1i+DMR/xQLtQIgTYH1RsWrA96Sp0o=;
        b=itQgtbgCxjVY4MnIwv9J05uUSqKRNRN8oi/+s4CifCJ3S2Q/pkItikHK8Dk61O9xYB
         8m6n7r3HiHIfRpXsUdphEe8Za5l2kCqOg3yWHoNna8IZZA+yHUJZskMk+i3XM0GcO+fd
         98dg2QtjHxmHSzMBdtbWiStv4kVCuh/t/uAGqjv0qt8g12gzhouNXp4vP84vVxx/8KC2
         DJp88+bCsPcIZMBUtBGjoZFOsdDWxL5iwEMwfr6W6UmIHvnRtRRiLRsiJhCe7A06NiyP
         /e12+rlcI5af2aADuSrQWX1MzhpmHnRaoFBjE9sV6DYZDdsvlV+zpLni/AjDF2U1X6Tq
         ZSLw==
X-Gm-Message-State: ACrzQf0mQbMbpG1z9cV9GlxvQLkGtS3Cb4KU/txdJ6Br7wywGpz9X2/V
        DWSGW+hh63QBd0NJw51XN6I=
X-Google-Smtp-Source: AMsMyM4ekJqwaFMSQQG57o0Fq/ZtDs7RaBKjgfYbgrCT0YMl+Vm9UvMyXk1wh5FwQxFQyxkrRXjhqA==
X-Received: by 2002:a05:6102:758:b0:398:d470:9541 with SMTP id v24-20020a056102075800b00398d4709541mr5408891vsg.28.1664577703669;
        Fri, 30 Sep 2022 15:41:43 -0700 (PDT)
Received: from macondo.. ([2804:431:e7cc:d13c:46d7:2f3e:5663:520a])
        by smtp.gmail.com with ESMTPSA id t12-20020ab0688c000000b0039f94d9d39fsm2445973uar.6.2022.09.30.15.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 15:41:43 -0700 (PDT)
From:   Rafael Mendonca <rafaelmendsr@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        "Hans J. Koch" <hjk@hansjkoch.de>,
        Damian Hobson-Garcia <dhobsong@igel.co.jp>
Cc:     Rafael Mendonca <rafaelmendsr@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] uio: uio_dmem_genirq: Fix deadlock between irq config and handling
Date:   Fri, 30 Sep 2022 19:40:58 -0300
Message-Id: <20220930224100.816175-3-rafaelmendsr@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220930224100.816175-1-rafaelmendsr@gmail.com>
References: <20220930224100.816175-1-rafaelmendsr@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes a concurrency issue addressed in commit 34cb27528398 ("UIO: Fix
concurrency issue"):

  "In a SMP case there was a race condition issue between
  Uio_pdrv_genirq_irqcontrol() running on one CPU and irq handler on
  another CPU. Fix it by spin_locking shared resources access inside irq
  handler."

The implementation of "uio_dmem_genirq" was based on "uio_pdrv_genirq" and
it is used in a similar manner to the "uio_pdrv_genirq" driver with respect
to interrupt configuration and handling. At the time "uio_dmem_genirq" was
merged, both had the same implementation of the 'uio_info' handlers
irqcontrol() and handler(), thus, both had the same concurrency issue
mentioned by the above commit. However, the above patch was only applied to
the "uio_pdrv_genirq" driver.

Split out from commit 34cb27528398 ("UIO: Fix concurrency issue").

Fixes: 0a0c3b5a24bd ("Add new uio device for dynamic memory allocation")
Signed-off-by: Rafael Mendonca <rafaelmendsr@gmail.com>
---
 drivers/uio/uio_dmem_genirq.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/uio/uio_dmem_genirq.c b/drivers/uio/uio_dmem_genirq.c
index cb283ee36eaa..792c3e9c9ce5 100644
--- a/drivers/uio/uio_dmem_genirq.c
+++ b/drivers/uio/uio_dmem_genirq.c
@@ -110,8 +110,10 @@ static irqreturn_t uio_dmem_genirq_handler(int irq, struct uio_info *dev_info)
 	 * remember the state so we can allow user space to enable it later.
 	 */
 
+	spin_lock(&priv->lock);
 	if (!test_and_set_bit(0, &priv->flags))
 		disable_irq_nosync(irq);
+	spin_unlock(&priv->lock);
 
 	return IRQ_HANDLED;
 }
@@ -125,7 +127,8 @@ static int uio_dmem_genirq_irqcontrol(struct uio_info *dev_info, s32 irq_on)
 	 * in the interrupt controller, but keep track of the
 	 * state to prevent per-irq depth damage.
 	 *
-	 * Serialize this operation to support multiple tasks.
+	 * Serialize this operation to support multiple tasks and concurrency
+	 * with irq handler on SMP systems.
 	 */
 
 	spin_lock_irqsave(&priv->lock, flags);
-- 
2.34.1

