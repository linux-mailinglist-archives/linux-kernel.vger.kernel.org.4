Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08406639630
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 14:35:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbiKZNfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 08:35:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiKZNe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 08:34:57 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA0520BC9
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 05:34:44 -0800 (PST)
Date:   Sat, 26 Nov 2022 13:34:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669469682;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6cMHiTnnsZa8gELtbjnBDsj91d3PQ2avyOLhJDfd1PY=;
        b=3Ahz5lhXSUvUlL7WSQD9WPaqLQRfQ+Z7Ttb6nD7jcxXbdoXa+wbXV90aHRoZaN+Y4omV5v
        4K+63fBE30s10/w+b5O6Q7/tRKTa2lgd4pg3vR8grHUDoofvJ3q9Sxivgb6D9vfjueoEKT
        xfkNqHNhRVSOck8Jr2cKPNCXKIuTBCr4cLOZjKa19yzrfUXIHCyWi7ifQxdP7XuC+eaJft
        Lzc9XCcNpW19Lo1Svm5XEhSZWwFdFnMEzif3u+EOUFNasP/sIlazIH5JiWs43xFhZ4ZFQt
        bGrT616K4M8BdC/41Dwz/PSgmtI9QcSxV7nWB1SYCr1n8qlWH5s+JP9C1J1uFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669469682;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6cMHiTnnsZa8gELtbjnBDsj91d3PQ2avyOLhJDfd1PY=;
        b=W61D3nBXa7eFt6vQSEKB79m3VTQ5fFi39BfidOmvPOUYz64yQQo8mw8jSYMylfHQ3kMCmv
        ggIu9gC4Lnh4pRAQ==
From:   "irqchip-bot for Jianmin Lv" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/loongson-liointc: Support to set
 IRQ type for ACPI path
Cc:     Jianmin Lv <lvjianmin@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20221022075955.11726-5-lvjianmin@loongson.cn>
References: <20221022075955.11726-5-lvjianmin@loongson.cn>
MIME-Version: 1.0
Message-ID: <166946968164.4906.15023749604647332635.tip-bot2@tip-bot2>
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

Commit-ID:     17343d0b4039196517ab5c40d8fce3e8d394c526
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/17343d0b4039196517ab5c40d8fce3e8d394c526
Author:        Jianmin Lv <lvjianmin@loongson.cn>
AuthorDate:    Sat, 22 Oct 2022 15:59:55 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sat, 26 Nov 2022 13:05:49 

irqchip/loongson-liointc: Support to set IRQ type for ACPI path

For ACPI path, the xlate callback used IRQ_TYPE_NONE and ignored
the IRQ type in intspec[1]. For supporting to set type for
IRQs of the irqdomain, intspec[1] should be used to get IRQ
type.

Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20221022075955.11726-5-lvjianmin@loongson.cn
---
 drivers/irqchip/irq-loongson-liointc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-loongson-liointc.c b/drivers/irqchip/irq-loongson-liointc.c
index 0da8716..838c8fa 100644
--- a/drivers/irqchip/irq-loongson-liointc.c
+++ b/drivers/irqchip/irq-loongson-liointc.c
@@ -167,7 +167,12 @@ static int liointc_domain_xlate(struct irq_domain *d, struct device_node *ctrlr,
 	if (WARN_ON(intsize < 1))
 		return -EINVAL;
 	*out_hwirq = intspec[0] - GSI_MIN_CPU_IRQ;
-	*out_type = IRQ_TYPE_NONE;
+
+	if (intsize > 1)
+		*out_type = intspec[1] & IRQ_TYPE_SENSE_MASK;
+	else
+		*out_type = IRQ_TYPE_NONE;
+
 	return 0;
 }
 
