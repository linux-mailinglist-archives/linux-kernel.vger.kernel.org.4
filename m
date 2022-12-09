Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F824648353
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 15:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbiLIOFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 09:05:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbiLIOFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 09:05:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B925278697;
        Fri,  9 Dec 2022 06:05:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 56E77B8287A;
        Fri,  9 Dec 2022 14:05:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78FADC433A8;
        Fri,  9 Dec 2022 14:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670594713;
        bh=62Hsw3IDekfs4Ib+zf3Eg7ZV2PJkMIizx7ANGAPQ61c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oUW10l3cUR5KCjF/GgIMN/DD1OxWuDSXZVQ9RNkRUS/Asgqsh1VdeRrLQSK3pynpz
         XKWY39K9d7/kdxFvjgrK7M9ooqQe5hrXWOw26WLX3M64Bax7q7qGNgLtAb/j6oX5s4
         ljnvHXGKiuEPWUJAF2Tds8yM4sscPbl9lPIwfVJAavmMFGq1pnTEFxdngmrlFv/eiY
         Oh7LAZIABdXx46wqT5m71kfss0mEX1nDulIyEYtm9tsp4kuPYOuxGe5nOX6iibIvuC
         HMM48lcKLBtgPRwyPlT8iscJlNYXSUZURGu7TzkXaY3YT6FrR8kLkNAmn9mr2W905j
         6ve63l3AI9GDA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1p3e0I-0000RT-CB; Fri, 09 Dec 2022 15:05:30 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v3 03/19] irqdomain: Drop leftover brackets
Date:   Fri,  9 Dec 2022 15:01:34 +0100
Message-Id: <20221209140150.1453-4-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221209140150.1453-1-johan+linaro@kernel.org>
References: <20221209140150.1453-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop some unnecessary brackets that were left in place when the
corresponding code was updated.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 kernel/irq/irqdomain.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index fe9ec53fe7aa..dfd60bd49109 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -219,9 +219,8 @@ struct irq_domain *__irq_domain_add(struct fwnode_handle *fwnode, unsigned int s
 	domain->host_data = host_data;
 	domain->hwirq_max = hwirq_max;
 
-	if (direct_max) {
+	if (direct_max)
 		domain->flags |= IRQ_DOMAIN_FLAG_NO_MAP;
-	}
 
 	domain->revmap_size = size;
 
@@ -615,9 +614,8 @@ void irq_domain_associate_many(struct irq_domain *domain, unsigned int irq_base,
 	pr_debug("%s(%s, irqbase=%i, hwbase=%i, count=%i)\n", __func__,
 		of_node_full_name(of_node), irq_base, (int)hwirq_base, count);
 
-	for (i = 0; i < count; i++) {
+	for (i = 0; i < count; i++)
 		irq_domain_associate(domain, irq_base + i, hwirq_base + i);
-	}
 }
 EXPORT_SYMBOL_GPL(irq_domain_associate_many);
 
-- 
2.37.4

