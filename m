Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0263E733EC3
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 08:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346021AbjFQGka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 02:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244026AbjFQGkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 02:40:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E4830E1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 23:39:59 -0700 (PDT)
Date:   Sat, 17 Jun 2023 06:39:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686983992;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4vBPwh54TSBsg+uX0bguDNzKVuNDC5f36S3xL87LiSA=;
        b=sjg0gBYFlIO3aw0Evv7wVp99X6jPwx5xnuGCbVMFneJ0qnLqOjropl1OwwybXtPw4miQ9c
        DmbWnBYlIwq8v9lP3IGKwWaaZCxGfCVwXpk71dnHydOVHPkvM7CbrslWN2ExQa4JzxkRnZ
        aLti26uAUMIo3F4Vsb9ytZYIti+QfqLoYpz+eCMQpbKKW7qsLjPnffegj4+A0cWWK8bnrX
        RrZH+ZOw84C3cGDn5f5S6J/Fh/rdYlVTxkeISFAXunhA3tgtdlW8AeOTaNTagbPIYaURaY
        UiJZUEv0/2HRr4nqk+Z46IwN3/2HILH0Fl4eakR2eUgSXGsiaSZtr7NqyGRlDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686983992;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4vBPwh54TSBsg+uX0bguDNzKVuNDC5f36S3xL87LiSA=;
        b=AgzGroEJbTN443xFw0+hkwvWmjJdSsXRs2Rln1gzL28Sh0u3UGbVQzuU6ZzYthUJvMg41E
        geKTwHHd9VEmCZDQ==
From:   "irqchip-bot for Arnd Bergmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/ftintc010: Mark all function static
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20230516200516.554663-1-arnd@kernel.org>
References: <20230516200516.554663-1-arnd@kernel.org>
MIME-Version: 1.0
Message-ID: <168698399235.404.11589915674993340526.tip-bot2@tip-bot2>
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

Commit-ID:     97bb0f8e847c0ea6bf926c4e3b7633dd6acfabf2
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/97bb0f8e847c0ea6bf926c4e3b7633dd6acfabf2
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Tue, 16 May 2023 22:05:04 +02:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sat, 17 Jun 2023 07:20:52 +01:00

irqchip/ftintc010: Mark all function static

Two functions were always global but never had any callers
outside of this file:

drivers/irqchip/irq-ftintc010.c:128:39: error: no previous prototype for 'ft010_irqchip_handle_irq'
drivers/irqchip/irq-ftintc010.c:165:12: error: no previous prototype for 'ft010_of_init_irq'

Fixes: b4d3053c8ce9 ("irqchip: Add a driver for Cortina Gemini")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20230516200516.554663-1-arnd@kernel.org
---
 drivers/irqchip/irq-ftintc010.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-ftintc010.c b/drivers/irqchip/irq-ftintc010.c
index 46a3aa6..359efc1 100644
--- a/drivers/irqchip/irq-ftintc010.c
+++ b/drivers/irqchip/irq-ftintc010.c
@@ -125,7 +125,7 @@ static struct irq_chip ft010_irq_chip = {
 /* Local static for the IRQ entry call */
 static struct ft010_irq_data firq;
 
-asmlinkage void __exception_irq_entry ft010_irqchip_handle_irq(struct pt_regs *regs)
+static asmlinkage void __exception_irq_entry ft010_irqchip_handle_irq(struct pt_regs *regs)
 {
 	struct ft010_irq_data *f = &firq;
 	int irq;
@@ -162,7 +162,7 @@ static const struct irq_domain_ops ft010_irqdomain_ops = {
 	.xlate = irq_domain_xlate_onetwocell,
 };
 
-int __init ft010_of_init_irq(struct device_node *node,
+static int __init ft010_of_init_irq(struct device_node *node,
 			      struct device_node *parent)
 {
 	struct ft010_irq_data *f = &firq;
