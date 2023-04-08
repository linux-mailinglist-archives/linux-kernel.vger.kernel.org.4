Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0306DBA33
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 12:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbjDHKs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 06:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbjDHKso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 06:48:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50922CC0A
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 03:48:06 -0700 (PDT)
Date:   Sat, 08 Apr 2023 10:45:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1680950716;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cl686Q9wQUjCqkyYPZeUOap60JNb3wqV6Kj5yMUk6Bw=;
        b=rKul6jiVDtYKPxe07eJzUxAkaw2lKkLAVzcTrESC+yJIVLtiyBoTcaZgBBdRN/pTq/BPZM
        E/N2pGRLrZ27kEN6EP2MywIFWykHgx3sQXQh5Vd3wBCG9z2Wyh0sZshsLxqIoyaUFgAcPI
        fb22mZDslIDA86vsqUgHOz3HEQHwMKNoG3eyhkLNgy5Zo1nYyqqnfg63dxVoWiNhJnAFD6
        kbkyKnrQ4mjWo93Jc4Z7Um33x85tMoJ9NO+5EQD45X6D4AcHUXCV6OaC+hTwtkGpoWs2EK
        3YTXZ1jsxJvSNY4qaSv2Wd9fkhhJ1pNW9GRo0oE3amLFqNs2rdvDeIehULioDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1680950716;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cl686Q9wQUjCqkyYPZeUOap60JNb3wqV6Kj5yMUk6Bw=;
        b=Y0WAqcZNs6azwxU+R+vZ6RtnqDIIvbRiAfeeMhQRg1lzgH3OErrJVlFOxa9faZTpYvKV9b
        9rDkbp5zG2RuBEBw==
From:   "irqchip-bot for Anup Patel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/riscv-intc: Add empty irq_eoi()
 for chained irq handlers
Cc:     Anup Patel <apatel@ventanamicro.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20230328035223.1480939-8-apatel@ventanamicro.com>
References: <20230328035223.1480939-8-apatel@ventanamicro.com>
MIME-Version: 1.0
Message-ID: <168095071647.404.805771641857569861.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     f8415f2def181c63486e93c511b82692e0914d9e
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/f8415f2def181c63486e93c511b82692e0914d9e
Author:        Anup Patel <apatel@ventanamicro.com>
AuthorDate:    Tue, 28 Mar 2023 09:22:23 +05:30
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sat, 08 Apr 2023 11:26:24 +01:00

irqchip/riscv-intc: Add empty irq_eoi() for chained irq handlers

We add empty irq_eoi() in RISC-V INTC driver for child irqchip
drivers (such as PLIC, SBI IPI, CLINT, APLIC, IMSIC, etc) which
implement chained handlers for parent per-HART local interrupts.
This hels us avoid unnecessary mask/unmask of per-HART local
interrupts at the time of handling interrupts.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20230328035223.1480939-8-apatel@ventanamicro.com
---
 drivers/irqchip/irq-riscv-intc.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv-intc.c
index 784d256..f229e3e 100644
--- a/drivers/irqchip/irq-riscv-intc.c
+++ b/drivers/irqchip/irq-riscv-intc.c
@@ -46,10 +46,27 @@ static void riscv_intc_irq_unmask(struct irq_data *d)
 	csr_set(CSR_IE, BIT(d->hwirq));
 }
 
+static void riscv_intc_irq_eoi(struct irq_data *d)
+{
+	/*
+	 * The RISC-V INTC driver uses handle_percpu_devid_irq() flow
+	 * for the per-HART local interrupts and child irqchip drivers
+	 * (such as PLIC, SBI IPI, CLINT, APLIC, IMSIC, etc) implement
+	 * chained handlers for the per-HART local interrupts.
+	 *
+	 * In the absence of irq_eoi(), the chained_irq_enter() and
+	 * chained_irq_exit() functions (used by child irqchip drivers)
+	 * will do unnecessary mask/unmask of per-HART local interrupts
+	 * at the time of handling interrupts. To avoid this, we provide
+	 * an empty irq_eoi() callback for RISC-V INTC irqchip.
+	 */
+}
+
 static struct irq_chip riscv_intc_chip = {
 	.name = "RISC-V INTC",
 	.irq_mask = riscv_intc_irq_mask,
 	.irq_unmask = riscv_intc_irq_unmask,
+	.irq_eoi = riscv_intc_irq_eoi,
 };
 
 static int riscv_intc_domain_map(struct irq_domain *d, unsigned int irq,
