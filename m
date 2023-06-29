Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 005AD7420EE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 09:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232146AbjF2H1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 03:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232124AbjF2H0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 03:26:30 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFAC12705;
        Thu, 29 Jun 2023 00:26:27 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-51d5569e4d1so359908a12.2;
        Thu, 29 Jun 2023 00:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688023586; x=1690615586;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bwd8c3qXwoH1vFVBqWX6B3qa2lR9FJmw4aF8E8qCwNg=;
        b=dTXi1f7xlD0Ie/gaDiuFQj/Hw8qCXx3/DCXiW7SlI2WkVFyk0JWhudAqELJglAIjRR
         UwNoA43JoQ28lWlFLf830FKyDG6piDFGZm/90IquO1K1b3dICxfIF6bzI69K1HOWvfFg
         g6iTAgh3PfRELcwLNJkdO78DFFMiU4g+MlrZc/SFHlLFcQM9uVxAa57omWgLIh63J9pp
         qUbzal9TKNlJkWJwGarJPA9g4ELvNOI34BCeDZZCBaYTlPhcO+d12o+0TfqCTxmSsYcV
         GlmMnJ3hvsjEounX5CD+YzbtwiyrTQFWYsW0jmk271AHoBhNBPlAo86JlTQu/lA+Ghyz
         ZSHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688023586; x=1690615586;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bwd8c3qXwoH1vFVBqWX6B3qa2lR9FJmw4aF8E8qCwNg=;
        b=O+7pOhvINZ7jEeAeM+erol3C8oCpt4udGSp3uOCm25MCHvvaWrlNRQWzCwlu9paI5F
         q6+OZC2ihMUfa5wMkS12wheQl7SG49g4iLaUupTQtmUUQto2N0t6wTiaFp/IjtZD7OFU
         VVEbmymIm+ucxHJrrW7x173ovtBIRi72Qlj94jd1y3npOC74YokY/bHV7HgAtSJkfVBH
         AMztfdw6lYApWZi56n30+ux/Bf5/fYpum8ZMqiwcmvQ/WL1f8d2zqnhem6uGN6Md0ZvB
         EcgSFyTCJtrTNkTA67N4KNIvCwJCdWzTNxhzqmX7HPHICKRD/3XQk6hr3NXEVHgDcWTX
         45GQ==
X-Gm-Message-State: AC+VfDxhUqzrvByATU7OZBUMAPyE19haCJdmzM9/r3L5L9XqrN4YcR0P
        Db2KhncYaYWDqZTLcEZ4T8Y=
X-Google-Smtp-Source: ACHHUZ4vwC0hNGyj9xa+pU3QuPUItbnkmq3FHWMi2GRg1PQt5aKy7aR89OjqeYmZkqKgzr+Q2J8grQ==
X-Received: by 2002:a17:907:3605:b0:96a:52e:5379 with SMTP id bk5-20020a170907360500b0096a052e5379mr26518474ejc.63.1688023586078;
        Thu, 29 Jun 2023 00:26:26 -0700 (PDT)
Received: from localhost (dslb-094-220-187-252.094.220.pools.vodafone-ip.de. [94.220.187.252])
        by smtp.gmail.com with ESMTPSA id qc23-20020a170906d8b700b0098dfec235ccsm6101756ejb.47.2023.06.29.00.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 00:26:25 -0700 (PDT)
From:   Jonas Gorski <jonas.gorski@gmail.com>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Simon Arlott <simon@octiron.net>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] irq-bcm6345-l1: do not assume a fixed block to cpu mapping
Date:   Thu, 29 Jun 2023 09:26:20 +0200
Message-Id: <20230629072620.62527-1-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The irq to block mapping is fixed, and interrupts from the first block
will always be routed to the first parent IRQ. But the parent interrupts
themselves can be routed to any available CPU.

This is used by the bootloader to map the first parent interrupt to the
boot CPU, regardless wether the boot CPU is the first one or the second
one.

When booting from the second CPU, the assumption that the first block's
IRQ is mapped to the first CPU breaks, and the system hangs because
interrupts do not get routed correctly.

Fix this by passing the appropriate bcm6434_l1_cpu to the interrupt
handler instead of the chip itself, so the handler always has the right
block.

Fixes: c7c42ec2baa1 ("irqchips/bmips: Add bcm6345-l1 interrupt controller")
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 drivers/irqchip/irq-bcm6345-l1.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/irqchip/irq-bcm6345-l1.c b/drivers/irqchip/irq-bcm6345-l1.c
index fa113cb2529a..6341c0167c4a 100644
--- a/drivers/irqchip/irq-bcm6345-l1.c
+++ b/drivers/irqchip/irq-bcm6345-l1.c
@@ -82,6 +82,7 @@ struct bcm6345_l1_chip {
 };
 
 struct bcm6345_l1_cpu {
+	struct bcm6345_l1_chip	*intc;
 	void __iomem		*map_base;
 	unsigned int		parent_irq;
 	u32			enable_cache[];
@@ -115,17 +116,11 @@ static inline unsigned int cpu_for_irq(struct bcm6345_l1_chip *intc,
 
 static void bcm6345_l1_irq_handle(struct irq_desc *desc)
 {
-	struct bcm6345_l1_chip *intc = irq_desc_get_handler_data(desc);
-	struct bcm6345_l1_cpu *cpu;
+	struct bcm6345_l1_cpu *cpu = irq_desc_get_handler_data(desc);
+	struct bcm6345_l1_chip *intc = cpu->intc;
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	unsigned int idx;
 
-#ifdef CONFIG_SMP
-	cpu = intc->cpus[cpu_logical_map(smp_processor_id())];
-#else
-	cpu = intc->cpus[0];
-#endif
-
 	chained_irq_enter(chip, desc);
 
 	for (idx = 0; idx < intc->n_words; idx++) {
@@ -253,6 +248,7 @@ static int __init bcm6345_l1_init_one(struct device_node *dn,
 	if (!cpu)
 		return -ENOMEM;
 
+	cpu->intc = intc;
 	cpu->map_base = ioremap(res.start, sz);
 	if (!cpu->map_base)
 		return -ENOMEM;
@@ -271,7 +267,7 @@ static int __init bcm6345_l1_init_one(struct device_node *dn,
 		return -EINVAL;
 	}
 	irq_set_chained_handler_and_data(cpu->parent_irq,
-						bcm6345_l1_irq_handle, intc);
+						bcm6345_l1_irq_handle, cpu);
 
 	return 0;
 }
-- 
2.34.1

