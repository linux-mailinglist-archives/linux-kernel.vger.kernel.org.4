Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E11F63962F
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 14:35:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiKZNfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 08:35:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiKZNe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 08:34:56 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554EF20BF1
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 05:34:43 -0800 (PST)
Date:   Sat, 26 Nov 2022 13:34:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669469681;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Sbt/kK8bIabC+5W5cW+6ugUd7DVL9JumZyAtbKIdl1Y=;
        b=J74CDiBDDwI9yCJVt4NPkPmZqfAxzdYMKQP5f5zALlvCvS77rQAa46MowDNpY+Ue/ZjTJS
        t8YRETglydouSn+ADfJG+qfXGKfrc36oWRqmkH8yBWxlR5Cbp1OnDLXiSQoROHEoxJTCZG
        7Qkuoy430mrZnvmr2kFk+1oC5uVL4CKmYGA6hbf/++ZV2ZzG9xP97WMLthFdK49sxSxvDF
        Hfvz69n1MFpUciKe+1EHUAzxaH2EQduL4sVrT0fZ49ZKplp6J5W44AkHOJu+RNoh+v7bjm
        OUSUqSdTgVav7zou/hmmfF1N12rahjYHlGtutLiEuVDIbkvWPcfOk9uWljnozQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669469681;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Sbt/kK8bIabC+5W5cW+6ugUd7DVL9JumZyAtbKIdl1Y=;
        b=zs9H/QFGPL6BBIckfHyhnnpfkW2uBcbNXFVsH42bAjqPWudgCnioVd18q0rCRGaSlrgsBO
        7Xb8ZzVzRX2j/hCg==
From:   "irqchip-bot for Huacai Chen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/loongson-htvec: Add ACPI init support
Cc:     Jianmin Lv <lvjianmin@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20221020142535.1725573-1-chenhuacai@loongson.cn>
References: <20221020142535.1725573-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Message-ID: <166946968053.4906.6486158229846009954.tip-bot2@tip-bot2>
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

Commit-ID:     70f7b6c008b37a0beb956e25a6c167edfd4b259e
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/70f7b6c008b37a0beb956e25a6c167edfd4b259e
Author:        Huacai Chen <chenhuacai@loongson.cn>
AuthorDate:    Thu, 20 Oct 2022 22:25:35 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sat, 26 Nov 2022 13:07:47 

irqchip/loongson-htvec: Add ACPI init support

HTVECINTC stands for "HyperTransport Interrupts" that described in
Section 14.3 of "Loongson 3A5000 Processor Reference Manual". For more
information please refer Documentation/loongarch/irq-chip-model.rst.

Though the extended model is the recommended one, there are still some
legacy model machines. So we add ACPI init support for HTVECINTC.

Co-developed-by: Jianmin Lv <lvjianmin@loongson.cn>
Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20221020142535.1725573-1-chenhuacai@loongson.cn
---
 arch/loongarch/include/asm/irq.h       |   2 +-
 drivers/irqchip/Kconfig                |   1 +-
 drivers/irqchip/irq-loongson-htvec.c   | 149 ++++++++++++++++++------
 drivers/irqchip/irq-loongson-liointc.c |  25 +++-
 4 files changed, 141 insertions(+), 36 deletions(-)

diff --git a/arch/loongarch/include/asm/irq.h b/arch/loongarch/include/asm/irq.h
index d06d454..9d3d36e 100644
--- a/arch/loongarch/include/asm/irq.h
+++ b/arch/loongarch/include/asm/irq.h
@@ -93,7 +93,7 @@ int liointc_acpi_init(struct irq_domain *parent,
 int eiointc_acpi_init(struct irq_domain *parent,
 					struct acpi_madt_eio_pic *acpi_eiointc);
 
-struct irq_domain *htvec_acpi_init(struct irq_domain *parent,
+int htvec_acpi_init(struct irq_domain *parent,
 					struct acpi_madt_ht_pic *acpi_htvec);
 int pch_lpc_acpi_init(struct irq_domain *parent,
 					struct acpi_madt_lpc_pic *acpi_pchlpc);
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 7ef9f5e..17396e6 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -576,6 +576,7 @@ config IRQ_LOONGARCH_CPU
 	select GENERIC_IRQ_CHIP
 	select IRQ_DOMAIN
 	select GENERIC_IRQ_EFFECTIVE_AFF_MASK
+	select LOONGSON_HTVEC
 	select LOONGSON_LIOINTC
 	select LOONGSON_EIOINTC
 	select LOONGSON_PCH_PIC
diff --git a/drivers/irqchip/irq-loongson-htvec.c b/drivers/irqchip/irq-loongson-htvec.c
index 60a335d..8b06082 100644
--- a/drivers/irqchip/irq-loongson-htvec.c
+++ b/drivers/irqchip/irq-loongson-htvec.c
@@ -20,7 +20,6 @@
 /* Registers */
 #define HTVEC_EN_OFF		0x20
 #define HTVEC_MAX_PARENT_IRQ	8
-
 #define VEC_COUNT_PER_REG	32
 #define VEC_REG_IDX(irq_id)	((irq_id) / VEC_COUNT_PER_REG)
 #define VEC_REG_BIT(irq_id)	((irq_id) % VEC_COUNT_PER_REG)
@@ -32,6 +31,8 @@ struct htvec {
 	raw_spinlock_t		htvec_lock;
 };
 
+static struct htvec *htvec_priv;
+
 static void htvec_irq_dispatch(struct irq_desc *desc)
 {
 	int i;
@@ -155,64 +156,144 @@ static void htvec_reset(struct htvec *priv)
 	}
 }
 
-static int htvec_of_init(struct device_node *node,
-				struct device_node *parent)
+static int htvec_init(phys_addr_t addr, unsigned long size,
+		int num_parents, int parent_irq[], struct fwnode_handle *domain_handle)
 {
+	int i;
 	struct htvec *priv;
-	int err, parent_irq[8], i;
 
 	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
+	priv->num_parents = num_parents;
+	priv->base = ioremap(addr, size);
 	raw_spin_lock_init(&priv->htvec_lock);
-	priv->base = of_iomap(node, 0);
-	if (!priv->base) {
-		err = -ENOMEM;
-		goto free_priv;
-	}
-
-	/* Interrupt may come from any of the 8 interrupt lines */
-	for (i = 0; i < HTVEC_MAX_PARENT_IRQ; i++) {
-		parent_irq[i] = irq_of_parse_and_map(node, i);
-		if (parent_irq[i] <= 0)
-			break;
-
-		priv->num_parents++;
-	}
 
-	if (!priv->num_parents) {
-		pr_err("Failed to get parent irqs\n");
-		err = -ENODEV;
-		goto iounmap_base;
-	}
-
-	priv->htvec_domain = irq_domain_create_linear(of_node_to_fwnode(node),
+	/* Setup IRQ domain */
+	priv->htvec_domain = irq_domain_create_linear(domain_handle,
 					(VEC_COUNT_PER_REG * priv->num_parents),
 					&htvec_domain_ops, priv);
 	if (!priv->htvec_domain) {
-		pr_err("Failed to create IRQ domain\n");
-		err = -ENOMEM;
-		goto irq_dispose;
+		pr_err("loongson-htvec: cannot add IRQ domain\n");
+		goto iounmap_base;
 	}
 
 	htvec_reset(priv);
 
-	for (i = 0; i < priv->num_parents; i++)
+	for (i = 0; i < priv->num_parents; i++) {
 		irq_set_chained_handler_and_data(parent_irq[i],
 						 htvec_irq_dispatch, priv);
+	}
+
+	htvec_priv = priv;
 
 	return 0;
 
-irq_dispose:
-	for (; i > 0; i--)
-		irq_dispose_mapping(parent_irq[i - 1]);
 iounmap_base:
 	iounmap(priv->base);
-free_priv:
 	kfree(priv);
 
-	return err;
+	return -EINVAL;
+}
+
+#ifdef CONFIG_OF
+
+static int htvec_of_init(struct device_node *node,
+				struct device_node *parent)
+{
+	int i, err;
+	int parent_irq[8];
+	int num_parents = 0;
+	struct resource res;
+
+	if (of_address_to_resource(node, 0, &res))
+		return -EINVAL;
+
+	/* Interrupt may come from any of the 8 interrupt lines */
+	for (i = 0; i < HTVEC_MAX_PARENT_IRQ; i++) {
+		parent_irq[i] = irq_of_parse_and_map(node, i);
+		if (parent_irq[i] <= 0)
+			break;
+
+		num_parents++;
+	}
+
+	err = htvec_init(res.start, resource_size(&res),
+			num_parents, parent_irq, of_node_to_fwnode(node));
+	if (err < 0)
+		return err;
+
+	return 0;
 }
 
 IRQCHIP_DECLARE(htvec, "loongson,htvec-1.0", htvec_of_init);
+
+#endif
+
+#ifdef CONFIG_ACPI
+static int __init pch_pic_parse_madt(union acpi_subtable_headers *header,
+					const unsigned long end)
+{
+	struct acpi_madt_bio_pic *pchpic_entry = (struct acpi_madt_bio_pic *)header;
+
+	return pch_pic_acpi_init(htvec_priv->htvec_domain, pchpic_entry);
+}
+
+static int __init pch_msi_parse_madt(union acpi_subtable_headers *header,
+					const unsigned long end)
+{
+	struct acpi_madt_msi_pic *pchmsi_entry = (struct acpi_madt_msi_pic *)header;
+
+	return pch_msi_acpi_init(htvec_priv->htvec_domain, pchmsi_entry);
+}
+
+static int __init acpi_cascade_irqdomain_init(void)
+{
+	int r;
+
+	r = acpi_table_parse_madt(ACPI_MADT_TYPE_BIO_PIC, pch_pic_parse_madt, 0);
+	if (r < 0)
+		return r;
+
+	r = acpi_table_parse_madt(ACPI_MADT_TYPE_MSI_PIC, pch_msi_parse_madt, 0);
+	if (r < 0)
+		return r;
+
+	return 0;
+}
+
+int __init htvec_acpi_init(struct irq_domain *parent,
+				   struct acpi_madt_ht_pic *acpi_htvec)
+{
+	int i, ret;
+	int num_parents, parent_irq[8];
+	struct fwnode_handle *domain_handle;
+
+	if (!acpi_htvec)
+		return -EINVAL;
+
+	num_parents = HTVEC_MAX_PARENT_IRQ;
+
+	domain_handle = irq_domain_alloc_fwnode(&acpi_htvec->address);
+	if (!domain_handle) {
+		pr_err("Unable to allocate domain handle\n");
+		return -ENOMEM;
+	}
+
+	/* Interrupt may come from any of the 8 interrupt lines */
+	for (i = 0; i < HTVEC_MAX_PARENT_IRQ; i++)
+		parent_irq[i] = irq_create_mapping(parent, acpi_htvec->cascade[i]);
+
+	ret = htvec_init(acpi_htvec->address, acpi_htvec->size,
+			num_parents, parent_irq, domain_handle);
+
+	if (ret == 0)
+		ret = acpi_cascade_irqdomain_init();
+	else
+		irq_domain_free_fwnode(domain_handle);
+
+	return ret;
+}
+
+#endif
diff --git a/drivers/irqchip/irq-loongson-liointc.c b/drivers/irqchip/irq-loongson-liointc.c
index 838c8fa..a4a7ccc 100644
--- a/drivers/irqchip/irq-loongson-liointc.c
+++ b/drivers/irqchip/irq-loongson-liointc.c
@@ -354,6 +354,26 @@ IRQCHIP_DECLARE(loongson_liointc_2_0, "loongson,liointc-2.0", liointc_of_init);
 #endif
 
 #ifdef CONFIG_ACPI
+static int __init htintc_parse_madt(union acpi_subtable_headers *header,
+					const unsigned long end)
+{
+	struct acpi_madt_ht_pic *htintc_entry = (struct acpi_madt_ht_pic *)header;
+	struct irq_domain *parent = irq_find_matching_fwnode(liointc_handle, DOMAIN_BUS_ANY);
+
+	return htvec_acpi_init(parent, htintc_entry);
+}
+
+static int __init acpi_cascade_irqdomain_init(void)
+{
+	int r;
+
+	r = acpi_table_parse_madt(ACPI_MADT_TYPE_HT_PIC, htintc_parse_madt, 0);
+	if (r < 0)
+		return r;
+
+	return 0;
+}
+
 int __init liointc_acpi_init(struct irq_domain *parent, struct acpi_madt_lio_pic *acpi_liointc)
 {
 	int ret;
@@ -370,9 +390,12 @@ int __init liointc_acpi_init(struct irq_domain *parent, struct acpi_madt_lio_pic
 		pr_err("Unable to allocate domain handle\n");
 		return -ENOMEM;
 	}
+
 	ret = liointc_init(acpi_liointc->address, acpi_liointc->size,
 			   1, domain_handle, NULL);
-	if (ret)
+	if (ret == 0)
+		ret = acpi_cascade_irqdomain_init();
+	else
 		irq_domain_free_fwnode(domain_handle);
 
 	return ret;
