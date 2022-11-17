Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9282262DF4A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 16:11:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240638AbiKQPLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 10:11:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240311AbiKQPJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 10:09:43 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA0492EF76;
        Thu, 17 Nov 2022 07:08:30 -0800 (PST)
Date:   Thu, 17 Nov 2022 15:08:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668697708;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BKniEgEXioy+RXBgPJqKcO/E+dS8s+LeeUc+K/0paPw=;
        b=bvQaBklFWoWcYt7s2CpxrIvFnK9hKgpuhtPSX+mH35QWIJwW4NvSqrbkBTLv4zrZGD+N4I
        BPp92v+e7gEwUYHlYT2pypsuD+X4hiMbW5GlUfedCnoKyq01oSt5FanlPp9attoCvbeC74
        +rniTQXBINCMeaHeLiRihSsSqfDvn9YncNQBuDjhNH+1GWJfmveugsPRUBRW9QqNuhYHlR
        dRVYdFbROX4Z1iDwq4+43KzQXws4BsvIS00yP36eLVFPC+1dUznbJdJ0j8GdVbej/FSJiK
        QiT+9NfRZM5pkH6ecm5Yq7ngZmMCqCNlwho5Sd86BtQ1x8d8uUiH/BTdjeDIgw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668697708;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BKniEgEXioy+RXBgPJqKcO/E+dS8s+LeeUc+K/0paPw=;
        b=CPlHtuVDoqaJM+sw4a1dg5Zk5inKduYQzJoEIXYTngLMdm4s+5Ysk9FdyCq9L2DF7+xFwI
        wHs49xp3Va3vA9CA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/msi: Add missing kernel doc to msi_next_desc()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ashok Raj <ashok.raj@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20221111122013.947071142@linutronix.de>
References: <20221111122013.947071142@linutronix.de>
MIME-Version: 1.0
Message-ID: <166869770742.4906.5383632337615817376.tip-bot2@tip-bot2>
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

Commit-ID:     fdd5340411b25450612767270ac3cd0d8454183c
Gitweb:        https://git.kernel.org/tip/fdd5340411b25450612767270ac3cd0d8454183c
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 11 Nov 2022 14:54:23 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 17 Nov 2022 15:15:18 +01:00

genirq/msi: Add missing kernel doc to msi_next_desc()

W=1 complains about this.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/20221111122013.947071142@linutronix.de

---
 kernel/irq/msi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 1ca4846..8a6d0dc 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -282,6 +282,7 @@ EXPORT_SYMBOL_GPL(msi_first_desc);
 /**
  * msi_next_desc - Get the next MSI descriptor of a device
  * @dev:	Device to operate on
+ * @filter:	Descriptor state filter
  *
  * The first invocation of msi_next_desc() has to be preceeded by a
  * successful invocation of __msi_first_desc(). Consecutive invocations are
