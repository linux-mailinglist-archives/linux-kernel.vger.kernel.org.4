Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8194D639631
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 14:35:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbiKZNfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 08:35:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbiKZNfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 08:35:09 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8785A20BE7
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 05:34:45 -0800 (PST)
Date:   Sat, 26 Nov 2022 13:34:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669469684;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/dD4R099IYzwcb7CUAjZNrQTVv8HMF9XsuupDZOw5BQ=;
        b=Kx/a2CbgJH6pXM2+l+rKtCk2JYDMpMWMRveLUesWUUKVJos5RmKgJGEYGeknPhkoiloMV1
        BPDuFDTi6lo3miYPi+YSAxb+fjYKWyLF4ktzK29QExb1QAWUus38xBvSD+lDIWSsIQMxvq
        jT8TJsTbf8ojyBCxAnRqgb+Ly2VHzrI9U0vnZvkrH7MD2+nSMW+yhejrGCLlubEBbZnGMw
        82CE5EgbBJp4uycME+O3RdeYeRdxHbDfi6JfTd7jsHAwmR1s4tp8jG5b6UawGJG/gR7CCp
        WPpZ7QD5Z0s3aB1xR0JPbpR/jiqBqLwK5KQoIpEAQOX2XlxyVaOV6Ms1bIGLtg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669469684;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/dD4R099IYzwcb7CUAjZNrQTVv8HMF9XsuupDZOw5BQ=;
        b=OmQ/XiLeqO3q0YOWUDEZyJOsykknvk7YxmkeuEwKRHCmD5z+/v3D2SCNc2qx8lLAUsnnjb
        o+Vw8xKbkPzyUEAQ==
From:   "irqchip-bot for Jianmin Lv" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/loongson-pch-pic: Support to set
 IRQ type for ACPI path
Cc:     Jianmin Lv <lvjianmin@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20221022075955.11726-4-lvjianmin@loongson.cn>
References: <20221022075955.11726-4-lvjianmin@loongson.cn>
MIME-Version: 1.0
Message-ID: <166946968274.4906.12418462636499559107.tip-bot2@tip-bot2>
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

Commit-ID:     25f3514aab3748bfef4a279ed599f836ac83e62a
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/25f3514aab3748bfef4a279ed599f836ac83e62a
Author:        Jianmin Lv <lvjianmin@loongson.cn>
AuthorDate:    Sat, 22 Oct 2022 15:59:54 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sat, 26 Nov 2022 13:05:48 

irqchip/loongson-pch-pic: Support to set IRQ type for ACPI path

For ACPI path, the translate callback used IRQ_TYPE_NONE and ignored
the IRQ type in fwspec->param[1]. For supporting to set type for
IRQs of the irqdomain, fwspec->param[1] should be used to get IRQ
type.

Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20221022075955.11726-4-lvjianmin@loongson.cn
---
 drivers/irqchip/irq-loongson-pch-pic.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-loongson-pch-pic.c b/drivers/irqchip/irq-loongson-pch-pic.c
index 03493cd..a26a3f5 100644
--- a/drivers/irqchip/irq-loongson-pch-pic.c
+++ b/drivers/irqchip/irq-loongson-pch-pic.c
@@ -155,9 +155,6 @@ static int pch_pic_domain_translate(struct irq_domain *d,
 	struct pch_pic *priv = d->host_data;
 	struct device_node *of_node = to_of_node(fwspec->fwnode);
 
-	if (fwspec->param_count < 1)
-		return -EINVAL;
-
 	if (of_node) {
 		if (fwspec->param_count < 2)
 			return -EINVAL;
@@ -165,8 +162,14 @@ static int pch_pic_domain_translate(struct irq_domain *d,
 		*hwirq = fwspec->param[0] + priv->ht_vec_base;
 		*type = fwspec->param[1] & IRQ_TYPE_SENSE_MASK;
 	} else {
+		if (fwspec->param_count < 1)
+			return -EINVAL;
+
 		*hwirq = fwspec->param[0] - priv->gsi_base;
-		*type = IRQ_TYPE_NONE;
+		if (fwspec->param_count > 1)
+			*type = fwspec->param[1] & IRQ_TYPE_SENSE_MASK;
+		else
+			*type = IRQ_TYPE_NONE;
 	}
 
 	return 0;
