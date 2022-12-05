Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4541642765
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 12:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbiLELVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 06:21:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbiLELVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 06:21:10 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A32118365
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 03:21:06 -0800 (PST)
Date:   Mon, 05 Dec 2022 11:21:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670239265;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EucvsWG3iZGhLlMAVtu7fPQuqYisFZKYh9GYfk5mMp0=;
        b=I9ApIXV7ESuAGa0BdBRvi1XpR6d1BjwFYb5n30IDMSFh9voyQppZSCkGwAIlfzg42atI6s
        hDdY/U4u8xhCOGpt+xpboE9OZUH+HvnzO5tBp3QYVhRpj1tFkcRR0zco2bDbfGj3bM62NZ
        pU6srsjh0lqrxht2YXckFYeTpHM7MQxlq0k+jMdwPRUSLTnZcAvZAXnxBOFAW6ZqC1C8Qf
        tWqW3wu4STD9lQxoNuvzz2jDVfSWUvTwUXD+LIX4w3DpxpUzYrKUuQqKiL9NIrzaqN7ilC
        IrfjhgplB99uo1UrET4A4CkLR8G2emUgfpv/aWuYLz3mbm3KHOtdiX9nE2wOvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670239265;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EucvsWG3iZGhLlMAVtu7fPQuqYisFZKYh9GYfk5mMp0=;
        b=jWt/K7PTq6QiBau9ksAZwSUBbUGW/cLNF3ZdhVGNem8YyS7L3YB048yZ0PzGz6EqL8BQ96
        4BgDiRLPuvu9YeCg==
From:   "irqchip-bot for Huacai Chen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/loongarch-cpu: Fix a missing
 prototype warning
Cc:     kernel test robot <lkp@intel.com>,
        Peibao Liu <liupeibao@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20221205044708.2054022-1-chenhuacai@loongson.cn>
References: <20221205044708.2054022-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Message-ID: <167023926441.4906.3148172344753409393.tip-bot2@tip-bot2>
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

Commit-ID:     065abd13a63f40318162eeca6c0215fc5cbb9b0a
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/065abd13a63f40318162eeca6c0215fc5cbb9b0a
Author:        Huacai Chen <chenhuacai@loongson.cn>
AuthorDate:    Mon, 05 Dec 2022 12:47:08 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Mon, 05 Dec 2022 10:42:35 

irqchip/loongarch-cpu: Fix a missing prototype warning

1, Rename loongarch_cpu_irq_of_init() to cpuintc_of_init() in order to
   keep the same style as the ACPI version.
2, Fix a missing prototype warning by adding a "static" modifier.

Fixes: 855d4ca4bdb366aab3d4 ("irqchip: loongarch-cpu: add DT support")
Reported-by: kernel test robot <lkp@intel.com>
Cc: Peibao Liu <liupeibao@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20221205044708.2054022-1-chenhuacai@loongson.cn
---
 drivers/irqchip/irq-loongarch-cpu.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-loongarch-cpu.c b/drivers/irqchip/irq-loongarch-cpu.c
index a28b7c5..738d69c 100644
--- a/drivers/irqchip/irq-loongarch-cpu.c
+++ b/drivers/irqchip/irq-loongarch-cpu.c
@@ -93,7 +93,7 @@ static const struct irq_domain_ops loongarch_cpu_intc_irq_domain_ops = {
 };
 
 #ifdef CONFIG_OF
-int __init loongarch_cpu_irq_of_init(struct device_node *of_node,
+static int __init cpuintc_of_init(struct device_node *of_node,
 				struct device_node *parent)
 {
 	cpuintc_handle = of_node_to_fwnode(of_node);
@@ -107,8 +107,7 @@ int __init loongarch_cpu_irq_of_init(struct device_node *of_node,
 
 	return 0;
 }
-IRQCHIP_DECLARE(cpu_intc, "loongson,cpu-interrupt-controller",
-					loongarch_cpu_irq_of_init);
+IRQCHIP_DECLARE(cpu_intc, "loongson,cpu-interrupt-controller", cpuintc_of_init);
 #endif
 
 static int __init
