Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8D5F639635
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 14:35:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbiKZNfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 08:35:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiKZNfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 08:35:20 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 001882181E
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 05:34:49 -0800 (PST)
Date:   Sat, 26 Nov 2022 13:34:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669469688;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yKxbvGFi6opj3Xg8bXiFsfp4VHNmZocIRZNkr9A0bO4=;
        b=EQlsAelWBp7fd3i12vQnqGg1ZmHkS01f004xEGmE/tGW8ysY2lSud7eaSDLtBoONO8OXZl
        nPk+Ek3OxYI+gmowXrud+SRApbODuHssGJQgZi+MdAoE5tu+P4XnS5n+KTsfFVEt3nNFJT
        Bbt20ALHiH/8qKofqv0FVaPHecXX3n1/uJ1QMIEdP0tQb6Mkf3NLP9nkAiAi2CZSRifLYK
        aumdZoPNjfS0x2/5qaFoCCJN2lDokAG8i41xHrQMNVnFNirTwYHGUTt9fxP5yq829djjWP
        o5PioD9vA30poeJKJvpjR/WsmdAusLDtJ0uHtRmsczS6Zf2GfZqjHP8yn2sAwg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669469688;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yKxbvGFi6opj3Xg8bXiFsfp4VHNmZocIRZNkr9A0bO4=;
        b=/6kTGYFXKJqAHCCmPHuW4uUZckQ4iVlN+oMM3jAenE24RZVf/ZRn8CKcLeqnwFWf4T4cbj
        XRJ2Ph/Ep6tTqGAA==
From:   "irqchip-bot for Liu Peibao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip: loongarch-cpu: add DT support
Cc:     Liu Peibao <liupeibao@loongson.cn>, Marc Zyngier <maz@kernel.org>,
        tglx@linutronix.de
In-Reply-To: <20221114113824.1880-2-liupeibao@loongson.cn>
References: <20221114113824.1880-2-liupeibao@loongson.cn>
MIME-Version: 1.0
Message-ID: <166946968726.4906.11156861205994702462.tip-bot2@tip-bot2>
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

Commit-ID:     855d4ca4bdb366aab3d43408b74e02ab629d1d55
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/855d4ca4bdb366aab3d43408b74e02ab629d1d55
Author:        Liu Peibao <liupeibao@loongson.cn>
AuthorDate:    Mon, 14 Nov 2022 19:38:23 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sat, 26 Nov 2022 11:54:11 

irqchip: loongarch-cpu: add DT support

LoongArch is coming to support booting with FDT, so DT
support of this driver is desired.

Signed-off-by: Liu Peibao <liupeibao@loongson.cn>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20221114113824.1880-2-liupeibao@loongson.cn
---
 drivers/irqchip/irq-loongarch-cpu.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/irqchip/irq-loongarch-cpu.c b/drivers/irqchip/irq-loongarch-cpu.c
index 741612b..a28b7c5 100644
--- a/drivers/irqchip/irq-loongarch-cpu.c
+++ b/drivers/irqchip/irq-loongarch-cpu.c
@@ -92,6 +92,25 @@ static const struct irq_domain_ops loongarch_cpu_intc_irq_domain_ops = {
 	.xlate = irq_domain_xlate_onecell,
 };
 
+#ifdef CONFIG_OF
+int __init loongarch_cpu_irq_of_init(struct device_node *of_node,
+				struct device_node *parent)
+{
+	cpuintc_handle = of_node_to_fwnode(of_node);
+
+	irq_domain = irq_domain_create_linear(cpuintc_handle, EXCCODE_INT_NUM,
+				&loongarch_cpu_intc_irq_domain_ops, NULL);
+	if (!irq_domain)
+		panic("Failed to add irqdomain for loongarch CPU");
+
+	set_handle_irq(&handle_cpu_irq);
+
+	return 0;
+}
+IRQCHIP_DECLARE(cpu_intc, "loongson,cpu-interrupt-controller",
+					loongarch_cpu_irq_of_init);
+#endif
+
 static int __init
 liointc_parse_madt(union acpi_subtable_headers *header,
 		       const unsigned long end)
