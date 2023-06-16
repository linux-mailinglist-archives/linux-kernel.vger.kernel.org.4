Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 595D0732FCF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 13:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345646AbjFPLZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 07:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbjFPLZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 07:25:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71BF91BF8
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 04:25:28 -0700 (PDT)
Date:   Fri, 16 Jun 2023 11:25:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686914726;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1cuNySetNojI9OmJ0j5cezEnA9razppVCvsqmKhnzHI=;
        b=gV2yQl8SzEwOx8y1wbiNu3UNlr5/VDoDPI6OGKlzCRG9cK5zrcxf/oPVJoX8toTHIhvjI5
        bbTyoUo6niVKcjzpXikfJhrO+z7cuoFvaBSsonAPNE341iASsNwQ5gE27gBPwn2T9zfCxW
        dM3fbhEaxVlogI7ZxMSNfTg8fhF84uPvek8FlapGFWj4Kdz0n+sKyXxNrZwoYiLVuPrlma
        LMFHNK8H1Qs2tgh0ruY31kfKbjtJVKZITC12KI5JVXo5asiqoz3VT6/BpBi4uJAbQMrC6+
        lrGT1ugsh09rczO5eCMXesA7DOIMFC+B0smmJX6pxTlNirQWAqhyrwUDDApG+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686914726;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1cuNySetNojI9OmJ0j5cezEnA9razppVCvsqmKhnzHI=;
        b=OtsPe7X1oeLIHasHoBJcun1mOe2hqVT4Euv7GvF4Iq2bFqa1ccTl3Fhf1GIfnwf6niTdJb
        4T1IMoq9XwqQSkDA==
From:   "irqchip-bot for James Gowans" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] genirq: Expand doc for PENDING and REPLAY flags
Cc:     James Gowans <jgowans@amazon.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Liao Chang <liaochang1@huawei.com>
In-Reply-To: <20230608120021.3273400-2-jgowans@amazon.com>
References: <20230608120021.3273400-2-jgowans@amazon.com>
MIME-Version: 1.0
Message-ID: <168691472619.404.8619258903421103207.tip-bot2@tip-bot2>
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

Commit-ID:     7cc148a32f1e7496e22c0005dd113a31d4a3b3d4
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/7cc148a32f1e7496e22c0005dd113a31d4a3b3d4
Author:        James Gowans <jgowans@amazon.com>
AuthorDate:    Thu, 08 Jun 2023 14:00:19 +02:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Fri, 16 Jun 2023 12:22:05 +01:00

genirq: Expand doc for PENDING and REPLAY flags

Adding a bit more info about what the flags are used for may help future
code readers.

Signed-off-by: James Gowans <jgowans@amazon.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Liao Chang <liaochang1@huawei.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20230608120021.3273400-2-jgowans@amazon.com
---
 kernel/irq/internals.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index 5fdc0b5..c443a0d 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -47,9 +47,12 @@ enum {
  *				  detection
  * IRQS_POLL_INPROGRESS		- polling in progress
  * IRQS_ONESHOT			- irq is not unmasked in primary handler
- * IRQS_REPLAY			- irq is replayed
+ * IRQS_REPLAY			- irq has been resent and will not be resent
+ * 				  again until the handler has run and cleared
+ * 				  this flag.
  * IRQS_WAITING			- irq is waiting
- * IRQS_PENDING			- irq is pending and replayed later
+ * IRQS_PENDING			- irq needs to be resent and should be resent
+ * 				  at the next available opportunity.
  * IRQS_SUSPENDED		- irq is suspended
  * IRQS_NMI			- irq line is used to deliver NMIs
  * IRQS_SYSFS			- descriptor has been added to sysfs
