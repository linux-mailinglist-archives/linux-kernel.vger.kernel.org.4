Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE0DE733EA5
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 08:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232741AbjFQGYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 02:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbjFQGY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 02:24:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72ADB2686
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 23:24:27 -0700 (PDT)
Date:   Sat, 17 Jun 2023 06:24:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686983065;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=69UGg4ZkI7u6JGrySSM/4IA+RKwfZzIoBoMRLqYhAMs=;
        b=eF1/Z2ZVyYeKXl6Q34b5do8wpNV92vRdZot6NJmTZlu+2SBSL0dl2SwHgY82gvb5j2gNEi
        ikQTGX2cfpDmQ7buP8r2rvE37QtiikvunFuVl0yt+wwlML1xA3yTj4zc6fkIFKj0avLG3Z
        dX1eK2qUCHpkShf9PLlVfLCeeGCYMdSzFcORt4jm6VXyxljbipBITewS1nQGFeVqFbGAgV
        I5+vvDZScXYnTumpub4d4bz9NTWjgSkGlKDUHWbfyMHa4+MSQc7gNsPVfoNFEcCt39I856
        JOkSVzOHgVl13S0H4toqrbqe0N23fEGv7ydCPkE4+Se0uhefut4S5pWbxQExhw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686983065;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=69UGg4ZkI7u6JGrySSM/4IA+RKwfZzIoBoMRLqYhAMs=;
        b=ez/BX7VDbZYjH/r3NJzjaJ62Rw8a8tA9UEp6QnOyx3W1nMXl001L8RwkdYA2F3c+Q1yXqt
        LmET9ya1YIs0S3CA==
From:   "irqchip-bot for Binbin Zhou" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/loongson-eiointc: Add DT init support
Cc:     Binbin Zhou <zhoubinbin@loongson.cn>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: =?utf-8?q?=3C764e02d924094580ac0f1d15535f4b98308705c6=2E16832?=
 =?utf-8?q?79769=2Egit=2Ezhoubinbin=40loongson=2Ecn=3E?=
References: =?utf-8?q?=3C764e02d924094580ac0f1d15535f4b98308705c6=2E168327?=
 =?utf-8?q?9769=2Egit=2Ezhoubinbin=40loongson=2Ecn=3E?=
MIME-Version: 1.0
Message-ID: <168698306422.404.17387805169218815935.tip-bot2@tip-bot2>
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

Commit-ID:     a3f1132c4c6be3ab5af1a2ae1885deda81539277
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/a3f1132c4c6be3ab5af1a2ae1885deda81539277
Author:        Binbin Zhou <zhoubinbin@loongson.cn>
AuthorDate:    Fri, 05 May 2023 17:46:49 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sat, 17 Jun 2023 07:16:09 +01:00

irqchip/loongson-eiointc: Add DT init support

Add EIOINTC irqchip DT support, which is needed for Loongson chips
based on DT and supporting EIOINTC, such as the Loongson-2K0500 SOC.

Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/764e02d924094580ac0f1d15535f4b98308705c6.1683279769.git.zhoubinbin@loongson.cn
---
 drivers/irqchip/irq-loongson-eiointc.c | 133 +++++++++++++++++-------
 1 file changed, 98 insertions(+), 35 deletions(-)

diff --git a/drivers/irqchip/irq-loongson-eiointc.c b/drivers/irqchip/irq-loongson-eiointc.c
index a7fcde3..92d8aa2 100644
--- a/drivers/irqchip/irq-loongson-eiointc.c
+++ b/drivers/irqchip/irq-loongson-eiointc.c
@@ -36,6 +36,7 @@ static int nr_pics;
 
 struct eiointc_priv {
 	u32			node;
+	u32			vec_count;
 	nodemask_t		node_map;
 	cpumask_t		cpuspan_map;
 	struct fwnode_handle	*domain_handle;
@@ -153,18 +154,18 @@ static int eiointc_router_init(unsigned int cpu)
 	if ((cpu_logical_map(cpu) % CORES_PER_EIO_NODE) == 0) {
 		eiointc_enable();
 
-		for (i = 0; i < VEC_COUNT / 32; i++) {
+		for (i = 0; i < eiointc_priv[0]->vec_count / 32; i++) {
 			data = (((1 << (i * 2 + 1)) << 16) | (1 << (i * 2)));
 			iocsr_write32(data, EIOINTC_REG_NODEMAP + i * 4);
 		}
 
-		for (i = 0; i < VEC_COUNT / 32 / 4; i++) {
+		for (i = 0; i < eiointc_priv[0]->vec_count / 32 / 4; i++) {
 			bit = BIT(1 + index); /* Route to IP[1 + index] */
 			data = bit | (bit << 8) | (bit << 16) | (bit << 24);
 			iocsr_write32(data, EIOINTC_REG_IPMAP + i * 4);
 		}
 
-		for (i = 0; i < VEC_COUNT / 4; i++) {
+		for (i = 0; i < eiointc_priv[0]->vec_count / 4; i++) {
 			/* Route to Node-0 Core-0 */
 			if (index == 0)
 				bit = BIT(cpu_logical_map(0));
@@ -175,7 +176,7 @@ static int eiointc_router_init(unsigned int cpu)
 			iocsr_write32(data, EIOINTC_REG_ROUTE + i * 4);
 		}
 
-		for (i = 0; i < VEC_COUNT / 32; i++) {
+		for (i = 0; i < eiointc_priv[0]->vec_count / 32; i++) {
 			data = 0xffffffff;
 			iocsr_write32(data, EIOINTC_REG_ENABLE + i * 4);
 			iocsr_write32(data, EIOINTC_REG_BOUNCE + i * 4);
@@ -195,7 +196,7 @@ static void eiointc_irq_dispatch(struct irq_desc *desc)
 
 	chained_irq_enter(chip, desc);
 
-	for (i = 0; i < VEC_REG_COUNT; i++) {
+	for (i = 0; i < eiointc_priv[0]->vec_count / VEC_COUNT_PER_REG; i++) {
 		pending = iocsr_read64(EIOINTC_REG_ISR + (i << 3));
 		iocsr_write64(pending, EIOINTC_REG_ISR + (i << 3));
 		while (pending) {
@@ -310,7 +311,7 @@ static void eiointc_resume(void)
 	eiointc_router_init(0);
 
 	for (i = 0; i < nr_pics; i++) {
-		for (j = 0; j < VEC_COUNT; j++) {
+		for (j = 0; j < eiointc_priv[0]->vec_count; j++) {
 			desc = irq_resolve_mapping(eiointc_priv[i]->eiointc_domain, j);
 			if (desc && desc->handle_irq && desc->handle_irq != handle_bad_irq) {
 				raw_spin_lock(&desc->lock);
@@ -375,11 +376,47 @@ static int __init acpi_cascade_irqdomain_init(void)
 	return 0;
 }
 
+static int __init eiointc_init(struct eiointc_priv *priv, int parent_irq,
+			       u64 node_map)
+{
+	int i;
+
+	node_map = node_map ? node_map : -1ULL;
+	for_each_possible_cpu(i) {
+		if (node_map & (1ULL << (cpu_to_eio_node(i)))) {
+			node_set(cpu_to_eio_node(i), priv->node_map);
+			cpumask_or(&priv->cpuspan_map, &priv->cpuspan_map,
+				   cpumask_of(i));
+		}
+	}
+
+	priv->eiointc_domain = irq_domain_create_linear(priv->domain_handle,
+							priv->vec_count,
+							&eiointc_domain_ops,
+							priv);
+	if (!priv->eiointc_domain) {
+		pr_err("loongson-extioi: cannot add IRQ domain\n");
+		return -ENOMEM;
+	}
+
+	eiointc_priv[nr_pics++] = priv;
+	eiointc_router_init(0);
+	irq_set_chained_handler_and_data(parent_irq, eiointc_irq_dispatch, priv);
+
+	if (nr_pics == 1) {
+		register_syscore_ops(&eiointc_syscore_ops);
+		cpuhp_setup_state_nocalls(CPUHP_AP_IRQ_LOONGARCH_STARTING,
+					  "irqchip/loongarch/intc:starting",
+					  eiointc_router_init, NULL);
+	}
+
+	return 0;
+}
+
 int __init eiointc_acpi_init(struct irq_domain *parent,
 				     struct acpi_madt_eio_pic *acpi_eiointc)
 {
-	int i, ret, parent_irq;
-	unsigned long node_map;
+	int parent_irq, ret;
 	struct eiointc_priv *priv;
 	int node;
 
@@ -394,37 +431,14 @@ int __init eiointc_acpi_init(struct irq_domain *parent,
 		goto out_free_priv;
 	}
 
+	priv->vec_count = VEC_COUNT;
 	priv->node = acpi_eiointc->node;
-	node_map = acpi_eiointc->node_map ? : -1ULL;
-
-	for_each_possible_cpu(i) {
-		if (node_map & (1ULL << cpu_to_eio_node(i))) {
-			node_set(cpu_to_eio_node(i), priv->node_map);
-			cpumask_or(&priv->cpuspan_map, &priv->cpuspan_map, cpumask_of(i));
-		}
-	}
-
-	/* Setup IRQ domain */
-	priv->eiointc_domain = irq_domain_create_linear(priv->domain_handle, VEC_COUNT,
-					&eiointc_domain_ops, priv);
-	if (!priv->eiointc_domain) {
-		pr_err("loongson-eiointc: cannot add IRQ domain\n");
-		goto out_free_handle;
-	}
-
-	eiointc_priv[nr_pics++] = priv;
-
-	eiointc_router_init(0);
 
 	parent_irq = irq_create_mapping(parent, acpi_eiointc->cascade);
-	irq_set_chained_handler_and_data(parent_irq, eiointc_irq_dispatch, priv);
 
-	if (nr_pics == 1) {
-		register_syscore_ops(&eiointc_syscore_ops);
-		cpuhp_setup_state_nocalls(CPUHP_AP_IRQ_LOONGARCH_STARTING,
-				  "irqchip/loongarch/intc:starting",
-				  eiointc_router_init, NULL);
-	}
+	ret = eiointc_init(priv, parent_irq, acpi_eiointc->node_map);
+	if (ret < 0)
+		goto out_free_handle;
 
 	if (cpu_has_flatmode)
 		node = cpu_to_node(acpi_eiointc->node * CORES_PER_EIO_NODE);
@@ -432,7 +446,10 @@ int __init eiointc_acpi_init(struct irq_domain *parent,
 		node = acpi_eiointc->node;
 	acpi_set_vec_parent(node, priv->eiointc_domain, pch_group);
 	acpi_set_vec_parent(node, priv->eiointc_domain, msi_group);
+
 	ret = acpi_cascade_irqdomain_init();
+	if (ret < 0)
+		goto out_free_handle;
 
 	return ret;
 
@@ -444,3 +461,49 @@ out_free_priv:
 
 	return -ENOMEM;
 }
+
+static int __init eiointc_of_init(struct device_node *of_node,
+				  struct device_node *parent)
+{
+	int parent_irq, ret;
+	struct eiointc_priv *priv;
+
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	parent_irq = irq_of_parse_and_map(of_node, 0);
+	if (parent_irq <= 0) {
+		ret = -ENODEV;
+		goto out_free_priv;
+	}
+
+	ret = irq_set_handler_data(parent_irq, priv);
+	if (ret < 0)
+		goto out_free_priv;
+
+	/*
+	 * In particular, the number of devices supported by the LS2K0500
+	 * extended I/O interrupt vector is 128.
+	 */
+	if (of_device_is_compatible(of_node, "loongson,ls2k0500-eiointc"))
+		priv->vec_count = 128;
+	else
+		priv->vec_count = VEC_COUNT;
+
+	priv->node = 0;
+	priv->domain_handle = of_node_to_fwnode(of_node);
+
+	ret = eiointc_init(priv, parent_irq, 0);
+	if (ret < 0)
+		goto out_free_priv;
+
+	return 0;
+
+out_free_priv:
+	kfree(priv);
+	return ret;
+}
+
+IRQCHIP_DECLARE(loongson_ls2k0500_eiointc, "loongson,ls2k0500-eiointc", eiointc_of_init);
+IRQCHIP_DECLARE(loongson_ls2k2000_eiointc, "loongson,ls2k2000-eiointc", eiointc_of_init);
