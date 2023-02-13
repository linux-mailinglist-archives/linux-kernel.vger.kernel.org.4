Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16CD069434C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 11:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbjBMKnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 05:43:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbjBMKnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 05:43:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05FAF166ED;
        Mon, 13 Feb 2023 02:43:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EFCA860F99;
        Mon, 13 Feb 2023 10:43:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C65B6C4332A;
        Mon, 13 Feb 2023 10:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676284996;
        bh=Li97/YgeF5lNpH4d55UxuUf7f/JYiOm3QypdwJ3bK/M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xr/Uof0gPLSgXaMwhLwpbTTOlTEfM6FWo+mvV8Bujzy+R/41KRCOOXfLRX3sy3rU0
         Y86aZN/wwMl6jD3gyZ2DcH5n3NLMMJDQq7qXOSuaZpJrivlwqpgYoDkoZtt+IWpIFl
         8TpgSQ3yl42J8KpTUkti2uArRiCfZ61+UlitRI05H0+b31cNBZ4rrtxGVHI8vL1BXO
         MZZyLw2xt+MfPk04WT8FRSNWYi9DKiM4nznsObyDt9GusQnzTjCe853A1ph65RIuZh
         zpiRr9AC8AVnRuQ4HrnRz157JQOmhcqXLpgCcuQLEjGUXBo+qOqVcGZZodA1/bFwAt
         c/o7LnrH7z15g==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pRWJb-0004Wj-QP; Mon, 13 Feb 2023 11:44:07 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc:     x86@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Subject: [PATCH v6 10/20] irqdomain: Drop leftover brackets
Date:   Mon, 13 Feb 2023 11:42:52 +0100
Message-Id: <20230213104302.17307-11-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230213104302.17307-1-johan+linaro@kernel.org>
References: <20230213104302.17307-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Hsin-Yi Wang <hsinyi@chromium.org>
Tested-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 kernel/irq/irqdomain.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 9bba31de6928..7785b3352e60 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -210,9 +210,8 @@ static struct irq_domain *__irq_domain_create(struct fwnode_handle *fwnode,
 	domain->host_data = host_data;
 	domain->hwirq_max = hwirq_max;
 
-	if (direct_max) {
+	if (direct_max)
 		domain->flags |= IRQ_DOMAIN_FLAG_NO_MAP;
-	}
 
 	domain->revmap_size = size;
 
@@ -652,9 +651,8 @@ void irq_domain_associate_many(struct irq_domain *domain, unsigned int irq_base,
 	pr_debug("%s(%s, irqbase=%i, hwbase=%i, count=%i)\n", __func__,
 		of_node_full_name(of_node), irq_base, (int)hwirq_base, count);
 
-	for (i = 0; i < count; i++) {
+	for (i = 0; i < count; i++)
 		irq_domain_associate(domain, irq_base + i, hwirq_base + i);
-	}
 }
 EXPORT_SYMBOL_GPL(irq_domain_associate_many);
 
-- 
2.39.1

