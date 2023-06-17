Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA4DA733EC4
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 08:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346050AbjFQGke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 02:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244736AbjFQGkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 02:40:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B0CA30E4
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 23:39:59 -0700 (PDT)
Date:   Sat, 17 Jun 2023 06:39:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686983993;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+M+jgNslwOffrhOtRzAqmK+dEZ4JhlGxgK8jKZicVkY=;
        b=oHGpF9bUpBxDCBYH/z1tmA4rIFiJnlnp8QtsiTLAg8fp1T3sEgvqbFCTBjmQ/yYb1t1lFJ
        Uvt7NP+kAJ7ef34V7GW/czhvqB54jHLfTAMSFOQ0g86w9qYrbZWlLHNKXgLtg9dDoJ5w3X
        W6TGTFp2mlyu/3fv07g4uCN0gZ4i9/HMgldLqQ7m28GeAeA9k0NuJmDHOHe46yDST2/FDm
        KlmnuN27MzbmP0rzM9BieTeKH8POiaxhltKhkCUfxX8vHxWtw7PbCB9DexqwTxhtZJZLVq
        kmNcgxpYRrKMKDMAe8+IoQKouIsgXhsLweGRYU0yB/4nDzCTViRu/Im0ry0oYg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686983993;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+M+jgNslwOffrhOtRzAqmK+dEZ4JhlGxgK8jKZicVkY=;
        b=eqVWz9/fo4G8ZBER8Cr7tJTacIXEmXwUilHL5MH7dlWYdmlWLXtC1bakFHAvjGGcdkeKjr
        A1o83b6p5wWa1kDg==
From:   "irqchip-bot for Arnd Bergmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqdomain: Include internals.h for
 function prototypes
Cc:     Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <maz@kernel.org>,
        tglx@linutronix.de
In-Reply-To: <20230516200432.554240-1-arnd@kernel.org>
References: <20230516200432.554240-1-arnd@kernel.org>
MIME-Version: 1.0
Message-ID: <168698399300.404.14766017008629151052.tip-bot2@tip-bot2>
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

Commit-ID:     8091f56ee4e51037662590edc0b0e44807fbab4d
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/8091f56ee4e51037662590edc0b0e44807fbab4d
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Tue, 16 May 2023 22:04:28 +02:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sat, 17 Jun 2023 07:20:45 +01:00

irqdomain: Include internals.h for function prototypes

irq_domain_debugfs_init() is defined in irqdomain.c, but the
declaration is in a header that is not included here:

kernel/irq/irqdomain.c:1965:13: error: no previous prototype for 'irq_domain_debugfs_init' [-Werror=missing-prototypes]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20230516200432.554240-1-arnd@kernel.org
---
 kernel/irq/irqdomain.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index f34760a..5bd0162 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -1915,6 +1915,8 @@ static void irq_domain_check_hierarchy(struct irq_domain *domain)
 #endif	/* CONFIG_IRQ_DOMAIN_HIERARCHY */
 
 #ifdef CONFIG_GENERIC_IRQ_DEBUGFS
+#include "internals.h"
+
 static struct dentry *domain_dir;
 
 static void
