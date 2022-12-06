Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B82E6442C6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 12:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235324AbiLFL7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 06:59:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234960AbiLFL6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 06:58:30 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801EF286F9;
        Tue,  6 Dec 2022 03:57:58 -0800 (PST)
Date:   Tue, 06 Dec 2022 11:57:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670327876;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UHGQJTwsNN6HaBNZBNClbbvaQLAwkpG5ENTqPqpgULE=;
        b=DHRVX/SUYV9Y/dC5uIO/CBIgs5X9NVPCJcdOa5yj7dfc8kJjhMykcHPp18V5lNI4ZaruDH
        tr1q5zZ3QzAIKS1fLeXVPigLkVhmJJ04P9e0ASp3p6T+AfferICWvs1mHaTsW54oi2SoyY
        9GUuzO2KzbqTTtrHHhyGzvnjelMGt+lXWJSMMYBwTVK5pyzeB81jOGTZkqD9eEXQCX28S4
        f/4R5EXUbPsjeOPlgWPuU7qjZnurWJfBquzscZm+tK59c1Tckg8gupgATIN3dCirZn+XIu
        /W4PCIwAQ0tEYvw4+6UhTsospx6b5DzYSds//DcbarQ9feK1KLp11Ya4PdR0rg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670327876;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UHGQJTwsNN6HaBNZBNClbbvaQLAwkpG5ENTqPqpgULE=;
        b=b3qlPPzeWbGPj9qWjbFxTrHnljcoP4SMhL2EqCgsmU2CPd+ccj4oOl7KpBPpGlZBBB+wD9
        Jly6VxEILmQU6jCg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/ti-sci-inta: Fix kernel doc
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221121140048.596303869@linutronix.de>
References: <20221121140048.596303869@linutronix.de>
MIME-Version: 1.0
Message-ID: <167032787599.4906.15535679126278048472.tip-bot2@tip-bot2>
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

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     e6d22108621c837f81d041ec5d61b08d17b151df
Gitweb:        https://git.kernel.org/tip/e6d22108621c837f81d041ec5d61b08d17b151df
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 21 Nov 2022 15:39:34 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 06 Dec 2022 12:50:18 +01:00

irqchip/ti-sci-inta: Fix kernel doc

W=1 build complains:

drivers/irqchip/irq-ti-sci-inta.c:177: warning: Function parameter or member 'vint_id' not described in 'ti_sci_inta_xlate_irq'
drivers/irqchip/irq-ti-sci-inta.c:177: warning: Excess function parameter 'irq' description in 'ti_sci_inta_xlate_irq'

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20221121140048.596303869@linutronix.de

---
 drivers/irqchip/irq-ti-sci-inta.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-ti-sci-inta.c b/drivers/irqchip/irq-ti-sci-inta.c
index 5fdbb43..a6ecc53 100644
--- a/drivers/irqchip/irq-ti-sci-inta.c
+++ b/drivers/irqchip/irq-ti-sci-inta.c
@@ -168,7 +168,7 @@ static void ti_sci_inta_irq_handler(struct irq_desc *desc)
 /**
  * ti_sci_inta_xlate_irq() - Translate hwirq to parent's hwirq.
  * @inta:	IRQ domain corresponding to Interrupt Aggregator
- * @irq:	Hardware irq corresponding to the above irq domain
+ * @vint_id:	Hardware irq corresponding to the above irq domain
  *
  * Return parent irq number if translation is available else -ENOENT.
  */
