Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FFBE66C031
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 14:51:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbjAPNvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 08:51:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231425AbjAPNun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 08:50:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A315A21974;
        Mon, 16 Jan 2023 05:50:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C52860FC7;
        Mon, 16 Jan 2023 13:50:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C0A8C433F2;
        Mon, 16 Jan 2023 13:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673877040;
        bh=Oycgtjbj5Je/2GUULN931D+KpOMY5u4TF17SbiYzKnc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MCQANLu5lUMIayX0woy6ZFaEDn1mFl7y9QyW1Zksz0ZsxxCzmLeChINV4ZcbsucPs
         Ukk1k03scIziJ1c+gqy9tkrjFAUh7QAS6YvpS0PHxe/wB4Lo4n/KVWVMYFrDGpgidr
         K/IxXlyPsyZJfS3JkiaeZnph0OIyrsfZbzb3a5p4I2xG2P2HW0uBgDPGjCpmu0vLnu
         Ibkye6ETKn8m5wN89rbhv5Ptq9gKhoUwYjayNOOcgoIE/H/a/4l85/PVIql8WytZu3
         lEjQAkBxlXxZguotXXTPBUeLOaVnjx/3sMD/kN6APt40RaILS+IdfeXQ3pMmJrnToK
         hxvtjSydPg1oA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pHPt5-0003uo-NM; Mon, 16 Jan 2023 14:50:59 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc:     x86@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Subject: [PATCH v4 03/19] irqdomain: Drop leftover brackets
Date:   Mon, 16 Jan 2023 14:50:28 +0100
Message-Id: <20230116135044.14998-4-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.38.2
In-Reply-To: <20230116135044.14998-1-johan+linaro@kernel.org>
References: <20230116135044.14998-1-johan+linaro@kernel.org>
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
2.38.2

