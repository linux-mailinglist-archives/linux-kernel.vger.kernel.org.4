Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D76FC690A17
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 14:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbjBINaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 08:30:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbjBINaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 08:30:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A92B65A9F8;
        Thu,  9 Feb 2023 05:30:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B55361A8D;
        Thu,  9 Feb 2023 13:30:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA64FC4331E;
        Thu,  9 Feb 2023 13:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675949443;
        bh=B2RPnBJRsHoCKuF0sSxZmpky7dK6bQqySe9k7JgSzc4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=izkiq/wiSL2iN7Y5//bt5KpdMPFqD8GyC3PntX7820fd2ChrKFcp0S3qB+QHyWrUB
         cENZv3hPIOVBhhQCYvGXcIJWM5zKpX2deERHjg+UqvUvYcu4PLmjuwBZFdhzPARx/C
         AEHDnp22Ef3GNGDgnb05pkIvTU0/s075IKfgKYozlUf4Raxzp5E7x2y5M28gaD3JgB
         hsSN7A15xWCjDIm1tq4GPAPxKvXhktXsN8HqOIcJa+LBii3Uc1HgfrBgNLXNVFta6e
         hdLAngCcV6+cWU+1Rl/9wu5zNBvupahpZL23NUCX59CkBJp1baYROf1PNqFIFYdO5u
         my7XM0BBsYmbg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pQ71G-0001L5-SK; Thu, 09 Feb 2023 14:31:22 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc:     x86@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Subject: [PATCH v5 09/19] irqdomain: Drop leftover brackets
Date:   Thu,  9 Feb 2023 14:23:13 +0100
Message-Id: <20230209132323.4599-10-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230209132323.4599-1-johan+linaro@kernel.org>
References: <20230209132323.4599-1-johan+linaro@kernel.org>
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
index 3d635b8bb465..a1c6e01b395e 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -221,9 +221,8 @@ struct irq_domain *__irq_domain_add(struct fwnode_handle *fwnode, unsigned int s
 	domain->host_data = host_data;
 	domain->hwirq_max = hwirq_max;
 
-	if (direct_max) {
+	if (direct_max)
 		domain->flags |= IRQ_DOMAIN_FLAG_NO_MAP;
-	}
 
 	domain->revmap_size = size;
 
@@ -631,9 +630,8 @@ void irq_domain_associate_many(struct irq_domain *domain, unsigned int irq_base,
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

