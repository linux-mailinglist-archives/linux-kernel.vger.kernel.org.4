Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE86963962E
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 14:35:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbiKZNfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 08:35:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiKZNez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 08:34:55 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515E7201AD
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 05:34:42 -0800 (PST)
Date:   Sat, 26 Nov 2022 13:34:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669469680;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mXOIxOU5S4iAL8STg1FjNoj61k10eRhE7jyQtctu3Fs=;
        b=vWWy48A7HqEio0mnSCmv7vFBdxSZsBN0CNdQc+SSvoFjPZ7vOJjF0uzKFUz40DUapfMUB3
        VAfnVPHHrw6jCuVze8Dyx+pnd6uzmsLwlBhyBHPUU/x0mh5gQaFxox73FQ3hMs8zezvyfC
        6d7Pzn2jZQKgXsF1SQG8+/GqF5xzLYHuSGxgkuNKli5LGt1oEJ8N6ELi1Nddu2FNjWsZN8
        kXp0WGLCNKar5OFHe3lj0y5gbGY7B6gmTKvmDmdqKf2NOaFTZBN6lv9IQxc5ez1nEm5uem
        Fat0VVLnlFwsSHcZX8C3FDrT2wb/ZRScIBhBb+6R5bwJAnLAaGhdq3n0TG+UGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669469680;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mXOIxOU5S4iAL8STg1FjNoj61k10eRhE7jyQtctu3Fs=;
        b=s/z2NoQjnxKP2X5o4Uhad8kLXa4qzWS3KQUtaMMZSNylOKqizrN9+5+O/PMGMOLb59oEp7
        2xiZPM7jRV+Qq1CQ==
From:   "irqchip-bot for Huacai Chen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/loongson-htvec: Add
 suspend/resume support
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20221020073527.541845-2-chenhuacai@loongson.cn>
References: <20221020073527.541845-2-chenhuacai@loongson.cn>
MIME-Version: 1.0
Message-ID: <166946967944.4906.6915919359278946026.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     1be356c9326d68c9b0161ca004a41f203864d7ee
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/1be356c9326d68c9b0161ca004a41f203864d7ee
Author:        Huacai Chen <chenhuacai@loongson.cn>
AuthorDate:    Thu, 20 Oct 2022 15:35:24 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sat, 26 Nov 2022 13:09:25 

irqchip/loongson-htvec: Add suspend/resume support

Add suspend/resume support for HTVEC irqchip, which is needed for
upcoming suspend/hibernation.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20221020073527.541845-2-chenhuacai@loongson.cn
---
 drivers/irqchip/irq-loongson-htvec.c | 27 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+)

diff --git a/drivers/irqchip/irq-loongson-htvec.c b/drivers/irqchip/irq-loongson-htvec.c
index 8b06082..fc8bf1f 100644
--- a/drivers/irqchip/irq-loongson-htvec.c
+++ b/drivers/irqchip/irq-loongson-htvec.c
@@ -16,6 +16,7 @@
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
+#include <linux/syscore_ops.h>
 
 /* Registers */
 #define HTVEC_EN_OFF		0x20
@@ -29,6 +30,7 @@ struct htvec {
 	void __iomem		*base;
 	struct irq_domain	*htvec_domain;
 	raw_spinlock_t		htvec_lock;
+	u32			saved_vec_en[HTVEC_MAX_PARENT_IRQ];
 };
 
 static struct htvec *htvec_priv;
@@ -156,6 +158,29 @@ static void htvec_reset(struct htvec *priv)
 	}
 }
 
+static int htvec_suspend(void)
+{
+	int i;
+
+	for (i = 0; i < htvec_priv->num_parents; i++)
+		htvec_priv->saved_vec_en[i] = readl(htvec_priv->base + HTVEC_EN_OFF + 4 * i);
+
+	return 0;
+}
+
+static void htvec_resume(void)
+{
+	int i;
+
+	for (i = 0; i < htvec_priv->num_parents; i++)
+		writel(htvec_priv->saved_vec_en[i], htvec_priv->base + HTVEC_EN_OFF + 4 * i);
+}
+
+static struct syscore_ops htvec_syscore_ops = {
+	.suspend = htvec_suspend,
+	.resume = htvec_resume,
+};
+
 static int htvec_init(phys_addr_t addr, unsigned long size,
 		int num_parents, int parent_irq[], struct fwnode_handle *domain_handle)
 {
@@ -188,6 +213,8 @@ static int htvec_init(phys_addr_t addr, unsigned long size,
 
 	htvec_priv = priv;
 
+	register_syscore_ops(&htvec_syscore_ops);
+
 	return 0;
 
 iounmap_base:
