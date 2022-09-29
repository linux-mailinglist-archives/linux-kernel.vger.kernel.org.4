Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CBB65EF358
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 12:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbiI2KVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 06:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234810AbiI2KVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 06:21:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4483422C7
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 03:21:02 -0700 (PDT)
Date:   Thu, 29 Sep 2022 10:20:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1664446860;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nOkppqVWP04eAOKaM3/EteJDC35cBnhcQHP+19Dp/rs=;
        b=OA3F82X4qMKgCsF37uxmg8JxS/k+FgMykCFvY4kyDCMNuyUBAOsEGb1jqT196OX4VwQDJI
        /Db40ffd7IEA/cxmehv0vbHJeWzpESKcVVsBCNeaeOCptw9Aik5uRbzmABFGrACsHcM7jR
        ute6hPxvX1KxQDeVMVUi/OvOyLpmskrYSbpekP1blQ9axfDqc+DVnTspco/m4rPPkdRwZW
        6Lh3/RjWLRKz0seSneLJsBPQJ2QfUKe3V8ychSzSjjpo1t+Wq9QqaApOVc8/TwIB2Rg4aF
        e8blZPoOlyi9krHGlmfB3QVEx9Fd96eFb+q9qqRB9RtPfwlRPJ5gDkzi+OvlYA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1664446860;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nOkppqVWP04eAOKaM3/EteJDC35cBnhcQHP+19Dp/rs=;
        b=nmJH57cCe/7PAeXQQ7IyZrpz9U0f5FlPi+KC7YzlYB4tUTUh4/8z3ziI2a6Zv2lRzir5Xg
        E9uVissaqoPrYDCA==
From:   "irqchip-bot for Zhiyuan Dai" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/gic-v3: Fix typo in comment
Cc:     Zhiyuan Dai <daizhiyuan@phytium.com.cn>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <1664332767-6909-1-git-send-email-daizhiyuan@phytium.com.cn>
References: <1664332767-6909-1-git-send-email-daizhiyuan@phytium.com.cn>
MIME-Version: 1.0
Message-ID: <166444685891.401.4015328203300304560.tip-bot2@tip-bot2>
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

Commit-ID:     4d96829774b7bd70ed81b5e2830afb9d97b9fea2
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/4d96829774b7bd70ed81b5e2830afb9d97b9fea2
Author:        Zhiyuan Dai <daizhiyuan@phytium.com.cn>
AuthorDate:    Wed, 28 Sep 2022 10:39:27 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 29 Sep 2022 11:15:36 +01:00

irqchip/gic-v3: Fix typo in comment

Fix typo in comment (cleanip/cleanup).

Signed-off-by: Zhiyuan Dai <daizhiyuan@phytium.com.cn>
[maz: commit message]
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/1664332767-6909-1-git-send-email-daizhiyuan@phytium.com.cn
---
 drivers/irqchip/irq-gic-v3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 262658f..34d5856 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -978,7 +978,7 @@ static int __gic_update_rdist_properties(struct redist_region *region,
 	u64 typer = gic_read_typer(ptr + GICR_TYPER);
 	u32 ctlr = readl_relaxed(ptr + GICR_CTLR);
 
-	/* Boot-time cleanip */
+	/* Boot-time cleanup */
 	if ((typer & GICR_TYPER_VLPIS) && (typer & GICR_TYPER_RVPEID)) {
 		u64 val;
 
