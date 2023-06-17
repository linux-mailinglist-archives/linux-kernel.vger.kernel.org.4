Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3E8F733EC5
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 08:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346072AbjFQGkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 02:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233973AbjFQGkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 02:40:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4313E30E3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 23:39:59 -0700 (PDT)
Date:   Sat, 17 Jun 2023 06:39:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686983992;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=URXJVp5fcBliHTlD/Pusnw6mYGY9loFIHgngRew5FsQ=;
        b=15betSu+n5B2qQkCqG5CtbU1+j3tkGBXWzLNYGrpWSihnvr55NsuYrc/jnz/mJWloXGjBP
        EQaJ2zfC46CD/n47Tg3asPItzlcLCNPR6jErg4+hSf1oghQFS2lE+2CytxzXrVNsRPkthw
        etHygr8Af6SRxL6IUYez9VvAYpiFrOQ6yazmjxIHJMMATTXDoTO8Ouso7oKptZNVGWLfzq
        SFysjehRZg7YDaiuRAeloT5yIn6Uc+UqZCKEQhId7bQRR60mYfUAw8Edb3EAYR57t2TmUk
        6k6t2mP2V+X6rT4uWkDQzTQSCxgf5qW1r578NJbOVWjd+CE+KsO7a0TaXhTv+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686983992;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=URXJVp5fcBliHTlD/Pusnw6mYGY9loFIHgngRew5FsQ=;
        b=sQQt445l4QXAnTJu3MIxSZHO2yZ9qulHaEKtin8TJm2uNdHty9RJ9RGUYTK9YnY5aULLBg
        z+5aslSrC/+7qIAg==
From:   "irqchip-bot for Arnd Bergmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/mmp: Remove non-DT codepath
Cc:     Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <maz@kernel.org>,
        tglx@linutronix.de
In-Reply-To: <20230516200516.554663-2-arnd@kernel.org>
References: <20230516200516.554663-2-arnd@kernel.org>
MIME-Version: 1.0
Message-ID: <168698399168.404.4889246423165214875.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     f1771b85e3086c9506c3de81e993330bca568ba5
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/f1771b85e3086c9506c3de81e993330bca568ba5
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Tue, 16 May 2023 22:05:05 +02:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sat, 17 Jun 2023 07:21:02 +01:00

irqchip/mmp: Remove non-DT codepath

Building with "W=1" warns about missing declarations for
two functions in the mmp irqchip driver:

drivers/irqchip/irq-mmp.c:248:13: error: no previous prototype for 'icu_init_irq'
drivers/irqchip/irq-mmp.c:271:13: error: no previous prototype for 'mmp2_init_icu'

The declarations are present in an unused header, but since there is no
caller, it's best to just remove the functions and the header completely,
making the driver DT-only to match the state of the platform.

Fixes: 77acc85ce797 ("ARM: mmp: remove device definitions")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20230516200516.554663-2-arnd@kernel.org
---
 drivers/irqchip/irq-mmp.c   | 127 +-----------------------------------
 include/linux/irqchip/mmp.h |  10 +---
 2 files changed, 137 deletions(-)
 delete mode 100644 include/linux/irqchip/mmp.h

diff --git a/drivers/irqchip/irq-mmp.c b/drivers/irqchip/irq-mmp.c
index 83455ca..25cf4f8 100644
--- a/drivers/irqchip/irq-mmp.c
+++ b/drivers/irqchip/irq-mmp.c
@@ -244,132 +244,6 @@ static void __exception_irq_entry mmp2_handle_irq(struct pt_regs *regs)
 	generic_handle_domain_irq(icu_data[0].domain, hwirq);
 }
 
-/* MMP (ARMv5) */
-void __init icu_init_irq(void)
-{
-	int irq;
-
-	max_icu_nr = 1;
-	mmp_icu_base = ioremap(0xd4282000, 0x1000);
-	icu_data[0].conf_enable = mmp_conf.conf_enable;
-	icu_data[0].conf_disable = mmp_conf.conf_disable;
-	icu_data[0].conf_mask = mmp_conf.conf_mask;
-	icu_data[0].nr_irqs = 64;
-	icu_data[0].virq_base = 0;
-	icu_data[0].domain = irq_domain_add_legacy(NULL, 64, 0, 0,
-						   &irq_domain_simple_ops,
-						   &icu_data[0]);
-	for (irq = 0; irq < 64; irq++) {
-		icu_mask_irq(irq_get_irq_data(irq));
-		irq_set_chip_and_handler(irq, &icu_irq_chip, handle_level_irq);
-	}
-	irq_set_default_host(icu_data[0].domain);
-	set_handle_irq(mmp_handle_irq);
-}
-
-/* MMP2 (ARMv7) */
-void __init mmp2_init_icu(void)
-{
-	int irq, end;
-
-	max_icu_nr = 8;
-	mmp_icu_base = ioremap(0xd4282000, 0x1000);
-	icu_data[0].conf_enable = mmp2_conf.conf_enable;
-	icu_data[0].conf_disable = mmp2_conf.conf_disable;
-	icu_data[0].conf_mask = mmp2_conf.conf_mask;
-	icu_data[0].nr_irqs = 64;
-	icu_data[0].virq_base = 0;
-	icu_data[0].domain = irq_domain_add_legacy(NULL, 64, 0, 0,
-						   &irq_domain_simple_ops,
-						   &icu_data[0]);
-	icu_data[1].reg_status = mmp_icu_base + 0x150;
-	icu_data[1].reg_mask = mmp_icu_base + 0x168;
-	icu_data[1].clr_mfp_irq_base = icu_data[0].virq_base +
-				icu_data[0].nr_irqs;
-	icu_data[1].clr_mfp_hwirq = 1;		/* offset to IRQ_MMP2_PMIC_BASE */
-	icu_data[1].nr_irqs = 2;
-	icu_data[1].cascade_irq = 4;
-	icu_data[1].virq_base = icu_data[0].virq_base + icu_data[0].nr_irqs;
-	icu_data[1].domain = irq_domain_add_legacy(NULL, icu_data[1].nr_irqs,
-						   icu_data[1].virq_base, 0,
-						   &irq_domain_simple_ops,
-						   &icu_data[1]);
-	icu_data[2].reg_status = mmp_icu_base + 0x154;
-	icu_data[2].reg_mask = mmp_icu_base + 0x16c;
-	icu_data[2].nr_irqs = 2;
-	icu_data[2].cascade_irq = 5;
-	icu_data[2].virq_base = icu_data[1].virq_base + icu_data[1].nr_irqs;
-	icu_data[2].domain = irq_domain_add_legacy(NULL, icu_data[2].nr_irqs,
-						   icu_data[2].virq_base, 0,
-						   &irq_domain_simple_ops,
-						   &icu_data[2]);
-	icu_data[3].reg_status = mmp_icu_base + 0x180;
-	icu_data[3].reg_mask = mmp_icu_base + 0x17c;
-	icu_data[3].nr_irqs = 3;
-	icu_data[3].cascade_irq = 9;
-	icu_data[3].virq_base = icu_data[2].virq_base + icu_data[2].nr_irqs;
-	icu_data[3].domain = irq_domain_add_legacy(NULL, icu_data[3].nr_irqs,
-						   icu_data[3].virq_base, 0,
-						   &irq_domain_simple_ops,
-						   &icu_data[3]);
-	icu_data[4].reg_status = mmp_icu_base + 0x158;
-	icu_data[4].reg_mask = mmp_icu_base + 0x170;
-	icu_data[4].nr_irqs = 5;
-	icu_data[4].cascade_irq = 17;
-	icu_data[4].virq_base = icu_data[3].virq_base + icu_data[3].nr_irqs;
-	icu_data[4].domain = irq_domain_add_legacy(NULL, icu_data[4].nr_irqs,
-						   icu_data[4].virq_base, 0,
-						   &irq_domain_simple_ops,
-						   &icu_data[4]);
-	icu_data[5].reg_status = mmp_icu_base + 0x15c;
-	icu_data[5].reg_mask = mmp_icu_base + 0x174;
-	icu_data[5].nr_irqs = 15;
-	icu_data[5].cascade_irq = 35;
-	icu_data[5].virq_base = icu_data[4].virq_base + icu_data[4].nr_irqs;
-	icu_data[5].domain = irq_domain_add_legacy(NULL, icu_data[5].nr_irqs,
-						   icu_data[5].virq_base, 0,
-						   &irq_domain_simple_ops,
-						   &icu_data[5]);
-	icu_data[6].reg_status = mmp_icu_base + 0x160;
-	icu_data[6].reg_mask = mmp_icu_base + 0x178;
-	icu_data[6].nr_irqs = 2;
-	icu_data[6].cascade_irq = 51;
-	icu_data[6].virq_base = icu_data[5].virq_base + icu_data[5].nr_irqs;
-	icu_data[6].domain = irq_domain_add_legacy(NULL, icu_data[6].nr_irqs,
-						   icu_data[6].virq_base, 0,
-						   &irq_domain_simple_ops,
-						   &icu_data[6]);
-	icu_data[7].reg_status = mmp_icu_base + 0x188;
-	icu_data[7].reg_mask = mmp_icu_base + 0x184;
-	icu_data[7].nr_irqs = 2;
-	icu_data[7].cascade_irq = 55;
-	icu_data[7].virq_base = icu_data[6].virq_base + icu_data[6].nr_irqs;
-	icu_data[7].domain = irq_domain_add_legacy(NULL, icu_data[7].nr_irqs,
-						   icu_data[7].virq_base, 0,
-						   &irq_domain_simple_ops,
-						   &icu_data[7]);
-	end = icu_data[7].virq_base + icu_data[7].nr_irqs;
-	for (irq = 0; irq < end; irq++) {
-		icu_mask_irq(irq_get_irq_data(irq));
-		if (irq == icu_data[1].cascade_irq ||
-		    irq == icu_data[2].cascade_irq ||
-		    irq == icu_data[3].cascade_irq ||
-		    irq == icu_data[4].cascade_irq ||
-		    irq == icu_data[5].cascade_irq ||
-		    irq == icu_data[6].cascade_irq ||
-		    irq == icu_data[7].cascade_irq) {
-			irq_set_chip(irq, &icu_irq_chip);
-			irq_set_chained_handler(irq, icu_mux_irq_demux);
-		} else {
-			irq_set_chip_and_handler(irq, &icu_irq_chip,
-						 handle_level_irq);
-		}
-	}
-	irq_set_default_host(icu_data[0].domain);
-	set_handle_irq(mmp2_handle_irq);
-}
-
-#ifdef CONFIG_OF
 static int __init mmp_init_bases(struct device_node *node)
 {
 	int ret, nr_irqs, irq, i = 0;
@@ -548,4 +422,3 @@ err:
 	return -EINVAL;
 }
 IRQCHIP_DECLARE(mmp2_mux_intc, "mrvl,mmp2-mux-intc", mmp2_mux_of_init);
-#endif
diff --git a/include/linux/irqchip/mmp.h b/include/linux/irqchip/mmp.h
deleted file mode 100644
index aa18137..0000000
--- a/include/linux/irqchip/mmp.h
+++ /dev/null
@@ -1,10 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef	__IRQCHIP_MMP_H
-#define	__IRQCHIP_MMP_H
-
-extern struct irq_chip icu_irq_chip;
-
-extern void icu_init_irq(void);
-extern void mmp2_init_icu(void);
-
-#endif	/* __IRQCHIP_MMP_H */
