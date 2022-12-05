Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51BF564304E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 19:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233149AbiLES2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 13:28:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232543AbiLESZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 13:25:21 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4798320F76;
        Mon,  5 Dec 2022 10:25:19 -0800 (PST)
Date:   Mon, 05 Dec 2022 18:25:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670264717;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GTxF5El7XZo0jkgPnt0ryEz4o1sd+rbMFDXn6j4Y/YE=;
        b=PBD4GX3G7iUTaMydzsFKifq8ZRy1IdzaHTEItt4EEpkqOVpci3/CRkRalHlKIX+6B6tDPl
        W8f+wmkZaS2tpLGN9tVfAIivej0Sa+/TvaSBgaW4i/08fyLIAjubnxqldtHeX4a9Gn8EiR
        oSs+qBgUsGpKXv/YmUxDqvd5we6ZzP1S0NmvLA861mGQT1uX5MkZ6txmRM7LuwY3lUsFJ4
        RnYN0zADw7RfBvY4hRIZ1L/+cHC/fPT0hWscaYicJTBR33xE7KpJ/P8qg+CDQSDQC/WQT8
        7tkhdjkI6IV6ra0eQvf/dVDz9t5puYANIJK1sYce8JMisYURAXVO9Nsp1orZSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670264717;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GTxF5El7XZo0jkgPnt0ryEz4o1sd+rbMFDXn6j4Y/YE=;
        b=QegLR2ICQGxVoXoKM51PtNwAXD40TSE+hBHwxh3z53vi8GUNNf/3cB3OJIjmNe3x1V5Oeq
        hpipMljRO0CNhhAQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/msi: Remove unused alloc/free interfaces
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Kevin Tian <kevin.tian@intel.com>,
        Marc Zyngier <maz@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221124230314.694291814@linutronix.de>
References: <20221124230314.694291814@linutronix.de>
MIME-Version: 1.0
Message-ID: <167026471748.4906.1917357826290879515.tip-bot2@tip-bot2>
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

Commit-ID:     c459f11f32a022d0f97694030419d16816275a9d
Gitweb:        https://git.kernel.org/tip/c459f11f32a022d0f97694030419d16816275a9d
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 25 Nov 2022 00:24:43 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 05 Dec 2022 19:21:00 +01:00

genirq/msi: Remove unused alloc/free interfaces

Now that all users are converted remove the old interfaces.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Acked-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20221124230314.694291814@linutronix.de

---
 include/linux/msi.h |  7 +----
 kernel/irq/msi.c    | 73 +--------------------------------------------
 2 files changed, 80 deletions(-)

diff --git a/include/linux/msi.h b/include/linux/msi.h
index 611707d..43b8866 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -487,13 +487,6 @@ int msi_domain_set_affinity(struct irq_data *data, const struct cpumask *mask,
 struct irq_domain *msi_create_irq_domain(struct fwnode_handle *fwnode,
 					 struct msi_domain_info *info,
 					 struct irq_domain *parent);
-int msi_domain_alloc_irqs_descs_locked(struct irq_domain *domain, struct device *dev,
-				       int nvec);
-int msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
-			  int nvec);
-
-void msi_domain_free_irqs_descs_locked(struct irq_domain *domain, struct device *dev);
-void msi_domain_free_irqs(struct irq_domain *domain, struct device *dev);
 
 int msi_domain_alloc_irqs_range_locked(struct device *dev, unsigned int domid,
 				       unsigned int first, unsigned int last);
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index f857295..8e653f0 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -1140,51 +1140,6 @@ int msi_domain_alloc_irqs_all_locked(struct device *dev, unsigned int domid, int
 	return msi_domain_alloc_locked(dev, &ctrl);
 }
 
-/**
- * msi_domain_alloc_irqs_descs_locked - Allocate interrupts from a MSI interrupt domain
- * @domain:	The domain to allocate from
- * @dev:	Pointer to device struct of the device for which the interrupts
- *		are allocated
- * @nvec:	The number of interrupts to allocate
- *
- * Must be invoked from within a msi_lock_descs() / msi_unlock_descs()
- * pair. Use this for MSI irqdomains which implement their own vector
- * allocation/free.
- *
- * Return: %0 on success or an error code.
- */
-int msi_domain_alloc_irqs_descs_locked(struct irq_domain *domain, struct device *dev,
-				       int nvec)
-{
-	struct msi_ctrl ctrl = {
-		.domid	= MSI_DEFAULT_DOMAIN,
-		.first	= 0,
-		.last	= MSI_MAX_INDEX,
-		.nirqs	= nvec,
-	};
-
-	return msi_domain_alloc_locked(dev, &ctrl);
-}
-
-/**
- * msi_domain_alloc_irqs - Allocate interrupts from a MSI interrupt domain
- * @domain:	The domain to allocate from
- * @dev:	Pointer to device struct of the device for which the interrupts
- *		are allocated
- * @nvec:	The number of interrupts to allocate
- *
- * Return: %0 on success or an error code.
- */
-int msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev, int nvec)
-{
-	int ret;
-
-	msi_lock_descs(dev);
-	ret = msi_domain_alloc_irqs_descs_locked(domain, dev, nvec);
-	msi_unlock_descs(dev);
-	return ret;
-}
-
 static void __msi_domain_free_irqs(struct device *dev, struct irq_domain *domain,
 				   struct msi_ctrl *ctrl)
 {
@@ -1310,34 +1265,6 @@ void msi_domain_free_irqs_all(struct device *dev, unsigned int domid)
 }
 
 /**
- * msi_domain_free_irqs_descs_locked - Free interrupts from a MSI interrupt @domain associated to @dev
- * @domain:	The domain to managing the interrupts
- * @dev:	Pointer to device struct of the device for which the interrupts
- *		are free
- *
- * Must be invoked from within a msi_lock_descs() / msi_unlock_descs()
- * pair. Use this for MSI irqdomains which implement their own vector
- * allocation.
- */
-void msi_domain_free_irqs_descs_locked(struct irq_domain *domain, struct device *dev)
-{
-	msi_domain_free_irqs_range_locked(dev, MSI_DEFAULT_DOMAIN, 0, MSI_MAX_INDEX);
-}
-
-/**
- * msi_domain_free_irqs - Free interrupts from a MSI interrupt @domain associated to @dev
- * @domain:	The domain to managing the interrupts
- * @dev:	Pointer to device struct of the device for which the interrupts
- *		are free
- */
-void msi_domain_free_irqs(struct irq_domain *domain, struct device *dev)
-{
-	msi_lock_descs(dev);
-	msi_domain_free_irqs_descs_locked(domain, dev);
-	msi_unlock_descs(dev);
-}
-
-/**
  * msi_get_domain_info - Get the MSI interrupt domain info for @domain
  * @domain:	The interrupt domain to retrieve data from
  *
