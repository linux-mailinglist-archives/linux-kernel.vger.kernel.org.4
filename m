Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6751862DF05
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 16:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240016AbiKQPH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 10:07:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbiKQPHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 10:07:55 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D4F59876;
        Thu, 17 Nov 2022 07:07:54 -0800 (PST)
Date:   Thu, 17 Nov 2022 15:07:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668697673;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aKFoUwAiMO5fsxBWJlAcCHc5lmCkjHrwDLhNDwM8/yk=;
        b=YtMeYNuyNGuDR4+/fvtzxchyYP3UMdy7cKZyLAIXRAZxor4GryFrC/zwVjObEXo1eSx6n9
        coEf3UWH3iDAz/66+xlD/2Fja1axufLTHodxhiHkQdO47R1uVPBIgZgJjT92KWOIqTDXRu
        my28q8/AQYMyR0f1f8qMo599JaCYqkSkFE5YeVZuq1JT3FZQPhZLobfha8kxb4xxlSBikI
        SLRDEXSmmWNC+vpex4qPpQ/oLXHE5rwDHA0R7x/9txLA9cFfHt/AfQYE32kbA2pm0lorGt
        kSzdCNQQtDfq9iAweROIxRRPR9ldfj2wGrRm1Zt3KFQXMyK9pHVDmco5Fv+rrg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668697673;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aKFoUwAiMO5fsxBWJlAcCHc5lmCkjHrwDLhNDwM8/yk=;
        b=yYDmm0aflvLr2CkYVLAw14Zyg+SpwxJQpcTzONStfYriorgDJpIUYsNBRaOcziNMxqgLT+
        sb+8iPmNBOB8K6Bg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/msi: Remove msi_domain_ops:: Msi_check()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Gunthorpe <jgg@nvidia.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20221111122015.807616900@linutronix.de>
References: <20221111122015.807616900@linutronix.de>
MIME-Version: 1.0
Message-ID: <166869767181.4906.10080889603936468444.tip-bot2@tip-bot2>
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

Commit-ID:     2569f62ca473584a8ba389f455fc00805389f7da
Gitweb:        https://git.kernel.org/tip/2569f62ca473584a8ba389f455fc00805389f7da
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 11 Nov 2022 14:55:15 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 17 Nov 2022 15:15:22 +01:00

genirq/msi: Remove msi_domain_ops:: Msi_check()

No more users.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/20221111122015.807616900@linutronix.de

---
 include/linux/msi.h |  4 ----
 kernel/irq/msi.c    | 17 +----------------
 2 files changed, 1 insertion(+), 20 deletions(-)

diff --git a/include/linux/msi.h b/include/linux/msi.h
index 8b28714..1ce9d5e 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -292,7 +292,6 @@ struct msi_domain_info;
  * @get_hwirq:		Retrieve the resulting hw irq number
  * @msi_init:		Domain specific init function for MSI interrupts
  * @msi_free:		Domain specific function to free a MSI interrupts
- * @msi_check:		Callback for verification of the domain/info/dev data
  * @msi_prepare:	Prepare the allocation of the interrupts in the domain
  * @set_desc:		Set the msi descriptor for an interrupt
  * @domain_alloc_irqs:	Optional function to override the default allocation
@@ -330,9 +329,6 @@ struct msi_domain_ops {
 	void		(*msi_free)(struct irq_domain *domain,
 				    struct msi_domain_info *info,
 				    unsigned int virq);
-	int		(*msi_check)(struct irq_domain *domain,
-				     struct msi_domain_info *info,
-				     struct device *dev);
 	int		(*msi_prepare)(struct irq_domain *domain,
 				       struct device *dev, int nvec,
 				       msi_alloc_info_t *arg);
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 4fde917..4b99f37 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -617,17 +617,9 @@ static int msi_domain_ops_init(struct irq_domain *domain,
 	return 0;
 }
 
-static int msi_domain_ops_check(struct irq_domain *domain,
-				struct msi_domain_info *info,
-				struct device *dev)
-{
-	return 0;
-}
-
 static struct msi_domain_ops msi_domain_ops_default = {
 	.get_hwirq		= msi_domain_ops_get_hwirq,
 	.msi_init		= msi_domain_ops_init,
-	.msi_check		= msi_domain_ops_check,
 	.msi_prepare		= msi_domain_ops_prepare,
 	.set_desc		= msi_domain_ops_set_desc,
 	.domain_alloc_irqs	= __msi_domain_alloc_irqs,
@@ -655,8 +647,6 @@ static void msi_domain_update_dom_ops(struct msi_domain_info *info)
 		ops->get_hwirq = msi_domain_ops_default.get_hwirq;
 	if (ops->msi_init == NULL)
 		ops->msi_init = msi_domain_ops_default.msi_init;
-	if (ops->msi_check == NULL)
-		ops->msi_check = msi_domain_ops_default.msi_check;
 	if (ops->msi_prepare == NULL)
 		ops->msi_prepare = msi_domain_ops_default.msi_prepare;
 	if (ops->set_desc == NULL)
@@ -707,13 +697,8 @@ int msi_domain_prepare_irqs(struct irq_domain *domain, struct device *dev,
 {
 	struct msi_domain_info *info = domain->host_data;
 	struct msi_domain_ops *ops = info->ops;
-	int ret;
-
-	ret = ops->msi_check(domain, info, dev);
-	if (ret == 0)
-		ret = ops->msi_prepare(domain, dev, nvec, arg);
 
-	return ret;
+	return ops->msi_prepare(domain, dev, nvec, arg);
 }
 
 int msi_domain_populate_irqs(struct irq_domain *domain, struct device *dev,
