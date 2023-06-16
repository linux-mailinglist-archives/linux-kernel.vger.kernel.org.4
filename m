Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC228732FCD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 13:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344947AbjFPLZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 07:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235046AbjFPLZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 07:25:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F511FF5
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 04:25:27 -0700 (PDT)
Date:   Fri, 16 Jun 2023 11:25:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686914725;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jEUn0/f9FVUChE7Kl1tLCWJPDi1svyiHRZIFyQJfrAI=;
        b=u0p1fVB9n4LnPERCTGO+VZ1CcyV9aPXOGxpUi/ox6KqsoQZohb6CTQrTVHfWQxRixZd/Cw
        ljrlKBQk1KBet1qOZ4k0fikonbbWyeMpZ0kThQdrfCHva/Ff4Myp3vI1CAi5bhPs/YzSZg
        3XAhaW9n3Z5/V2uzcYs8qd1BmDP9BKtcerIIzMmaOKQiRCtHcCLlaUr08XypguQ1+xAXX+
        grzPkt2PPcNvXowtNFCblpcMxwrSM9h2UHklqt2iQH/8gR8G1nTxg/UXgw3Rq6ID8PrrX9
        VHymYMV8t2M9GwyON0NBc00L6vHsBVIemx901k0FwyNY2P7kJDGJq1wPX6xSKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686914725;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jEUn0/f9FVUChE7Kl1tLCWJPDi1svyiHRZIFyQJfrAI=;
        b=MYj3kp6Q27WnBrL6hJmIYYl7z9plCfRjRUTsawRabe5C7OipIYt9tjDpfxsIYHbXSxl1dB
        oZt3IM8/cTnyHlBQ==
From:   "irqchip-bot for James Gowans" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/gic-v3-its: Enable
 RESEND_WHEN_IN_PROGRESS for LPIs
Cc:     Marc Zyngier <maz@kernel.org>, James Gowans <jgowans@amazon.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        KarimAllah Raslan <karahmed@amazon.com>,
        Yipeng Zou <zouyipeng@huawei.com>,
        Zhang Jianhua <chris.zjh@huawei.com>
In-Reply-To: <20230608120021.3273400-4-jgowans@amazon.com>
References: <20230608120021.3273400-4-jgowans@amazon.com>
MIME-Version: 1.0
Message-ID: <168691472458.404.8158933098572478728.tip-bot2@tip-bot2>
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

Commit-ID:     8f4b589595d01f882d63d21efe15af4a5ad7c59b
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/8f4b589595d01f882d63d21efe15af4a5ad7c59b
Author:        James Gowans <jgowans@amazon.com>
AuthorDate:    Thu, 08 Jun 2023 14:00:21 +02:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Fri, 16 Jun 2023 12:23:40 +01:00

irqchip/gic-v3-its: Enable RESEND_WHEN_IN_PROGRESS for LPIs

GICv3 LPIs are impacted by an architectural design issue: they do not
have a global active state and as such a given LPI can be delivered to
a new CPU after an affinity change while the previous instance of the
same LPI handler has not yet completed on the original CPU.

If LPIs had an active state, this second LPI would not be delivered
until the first CPU deactivated the initial LPI, just like SPIs.

To solve this issue, use the newly introduced IRQD_RESEND_WHEN_IN_PROGRESS
flag, ensuring that we do not lose an LPI being delivered during that window
by getting the GIC to resend it.

This workaround gets enabled for all LPIs, including the VPE doorbells.

Suggested-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: James Gowans <jgowans@amazon.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>
Cc: KarimAllah Raslan <karahmed@amazon.com>
Cc: Yipeng Zou <zouyipeng@huawei.com>
Cc: Zhang Jianhua <chris.zjh@huawei.com>
[maz: massaged commit message]
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20230608120021.3273400-4-jgowans@amazon.com
---
 drivers/irqchip/irq-gic-v3-its.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 0ec2b1e..1994541 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -3585,6 +3585,7 @@ static int its_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 		irqd = irq_get_irq_data(virq + i);
 		irqd_set_single_target(irqd);
 		irqd_set_affinity_on_activate(irqd);
+		irqd_set_resend_when_in_progress(irqd);
 		pr_debug("ID:%d pID:%d vID:%d\n",
 			 (int)(hwirq + i - its_dev->event_map.lpi_base),
 			 (int)(hwirq + i), virq + i);
@@ -4523,6 +4524,7 @@ static int its_vpe_irq_domain_alloc(struct irq_domain *domain, unsigned int virq
 		irq_domain_set_hwirq_and_chip(domain, virq + i, i,
 					      irqchip, vm->vpes[i]);
 		set_bit(i, bitmap);
+		irqd_set_resend_when_in_progress(irq_get_irq_data(virq + i));
 	}
 
 	if (err) {
