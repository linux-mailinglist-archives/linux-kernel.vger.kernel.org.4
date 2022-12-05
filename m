Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D66264305E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 19:29:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233578AbiLES3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 13:29:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232688AbiLESZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 13:25:24 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5EF4209BA;
        Mon,  5 Dec 2022 10:25:23 -0800 (PST)
Date:   Mon, 05 Dec 2022 18:25:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670264722;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4raCAOAHtLFE2VxTLU6b32oB5I+eqLXcRyBlc7VcnGk=;
        b=BK/T2QWUyqtu2QEU5y+6kbpQCPDk0UTSf7Pu0jfMpe1wFqLlEIohPqyILbmOr+G3iNjj6c
        uCHByGN/6GLGzlI53FIi0WObch20FUASPBrpO8yWCpUDUfsgKHrWIH8vvFNRCXSg9p/LW0
        eqzsoArU/PTp/ilFqAPZ5DCWjWi2DJx8nfnESLcvOyRYFsIT/gxbELB5rcIxDeIrH9FItk
        sugyhynstWOhFFkL/hEA4cOV1Efh+5OXds5erIOJNBCQk+w1cQnmDa99xICtcZSuEHUeG/
        4CLuTaCfwZH8eC7wDDodRDbubX3QygwzxCQ/SK2GVeu0bhy21/kIhEVf+u6aEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670264722;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4raCAOAHtLFE2VxTLU6b32oB5I+eqLXcRyBlc7VcnGk=;
        b=FybjhAIHTokDhbrJko+/+Z4zWbhH+vGedi7gauCf9GhZoX3pvPbDW6AicVin+BFzIjsTSu
        xLJHfXyit/P40kCw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/irqdomain: Make struct irqdomain readable
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Kevin Tian <kevin.tian@intel.com>,
        Marc Zyngier <maz@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221124230313.514944367@linutronix.de>
References: <20221124230313.514944367@linutronix.de>
MIME-Version: 1.0
Message-ID: <167026472207.4906.6277292417329349370.tip-bot2@tip-bot2>
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

Commit-ID:     f876ea3b7969329d6472ae4126496bb03c89d89a
Gitweb:        https://git.kernel.org/tip/f876ea3b7969329d6472ae4126496bb03c89d89a
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 25 Nov 2022 00:24:10 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 05 Dec 2022 19:20:58 +01:00

genirq/irqdomain: Make struct irqdomain readable

Tabular alignment of both kernel-doc and the actual struct declaration make
visual parsing way more conveniant.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Acked-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20221124230313.514944367@linutronix.de

---
 include/linux/irqdomain.h | 74 +++++++++++++++++++-------------------
 1 file changed, 37 insertions(+), 37 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index c42c369..b1fdd8d 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -117,53 +117,53 @@ struct irq_domain_chip_generic;
 
 /**
  * struct irq_domain - Hardware interrupt number translation object
- * @link: Element in global irq_domain list.
- * @name: Name of interrupt domain
- * @ops: pointer to irq_domain methods
- * @host_data: private data pointer for use by owner.  Not touched by irq_domain
- *             core code.
- * @flags: host per irq_domain flags
- * @mapcount: The number of mapped interrupts
+ * @link:	Element in global irq_domain list.
+ * @name:	Name of interrupt domain
+ * @ops:	Pointer to irq_domain methods
+ * @host_data:	Private data pointer for use by owner.  Not touched by irq_domain
+ *		core code.
+ * @flags:	Per irq_domain flags
+ * @mapcount:	The number of mapped interrupts
  *
- * Optional elements
- * @fwnode: Pointer to firmware node associated with the irq_domain. Pretty easy
- *          to swap it for the of_node via the irq_domain_get_of_node accessor
- * @gc: Pointer to a list of generic chips. There is a helper function for
- *      setting up one or more generic chips for interrupt controllers
- *      drivers using the generic chip library which uses this pointer.
- * @dev: Pointer to a device that the domain represent, and that will be
- *       used for power management purposes.
- * @parent: Pointer to parent irq_domain to support hierarchy irq_domains
+ * Optional elements:
+ * @fwnode:	Pointer to firmware node associated with the irq_domain. Pretty easy
+ *		to swap it for the of_node via the irq_domain_get_of_node accessor
+ * @gc:		Pointer to a list of generic chips. There is a helper function for
+ *		setting up one or more generic chips for interrupt controllers
+ *		drivers using the generic chip library which uses this pointer.
+ * @dev:	Pointer to a device that can be utilized for power management
+ *		purposes related to the irq domain.
+ * @parent:	Pointer to parent irq_domain to support hierarchy irq_domains
  *
- * Revmap data, used internally by irq_domain
- * @revmap_size: Size of the linear map table @revmap[]
- * @revmap_tree: Radix map tree for hwirqs that don't fit in the linear map
- * @revmap_mutex: Lock for the revmap
- * @revmap: Linear table of irq_data pointers
+ * Revmap data, used internally by the irq domain code:
+ * @revmap_size:	Size of the linear map table @revmap[]
+ * @revmap_tree:	Radix map tree for hwirqs that don't fit in the linear map
+ * @revmap_mutex:	Lock for the revmap
+ * @revmap:		Linear table of irq_data pointers
  */
 struct irq_domain {
-	struct list_head link;
-	const char *name;
-	const struct irq_domain_ops *ops;
-	void *host_data;
-	unsigned int flags;
-	unsigned int mapcount;
+	struct list_head		link;
+	const char			*name;
+	const struct irq_domain_ops	*ops;
+	void				*host_data;
+	unsigned int			flags;
+	unsigned int			mapcount;
 
 	/* Optional data */
-	struct fwnode_handle *fwnode;
-	enum irq_domain_bus_token bus_token;
-	struct irq_domain_chip_generic *gc;
-	struct device *dev;
+	struct fwnode_handle		*fwnode;
+	enum irq_domain_bus_token	bus_token;
+	struct irq_domain_chip_generic	*gc;
+	struct device			*dev;
 #ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
-	struct irq_domain *parent;
+	struct irq_domain		*parent;
 #endif
 
 	/* reverse map data. The linear map gets appended to the irq_domain */
-	irq_hw_number_t hwirq_max;
-	unsigned int revmap_size;
-	struct radix_tree_root revmap_tree;
-	struct mutex revmap_mutex;
-	struct irq_data __rcu *revmap[];
+	irq_hw_number_t			hwirq_max;
+	unsigned int			revmap_size;
+	struct radix_tree_root		revmap_tree;
+	struct mutex			revmap_mutex;
+	struct irq_data __rcu		*revmap[];
 };
 
 /* Irq domain flags */
