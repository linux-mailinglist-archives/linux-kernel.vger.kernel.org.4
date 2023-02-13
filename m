Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06A096950D8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 20:41:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbjBMTlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 14:41:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbjBMTkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 14:40:47 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFFB21ABF7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 11:40:45 -0800 (PST)
Date:   Mon, 13 Feb 2023 19:40:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676317244;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0ey95PcH3gvAht5TBXYP/ZcYBkv73pjM1L2rul30pnw=;
        b=ebb0Drv1wAMKRwtOhF7uc/YatHqxfKYRXGOfUoUhf1D0BKb7MPSHM1fLQQAPpCkaxAbicv
        lmvwUemYylVV9LISY4ys7tBNi2YJeGOmAv74zyyjEcbUEbFiRm4IDJPTWco78YSWtyzQ1E
        /5cJFKO88HsNyeIsqI798Q5z5asYkERTmTWQ4/HETyAnrZcuZR5jiieMFFStPUMAcgfgIT
        dZ8ooTcVfCZ/WtvFrND7xap2vlGx8/WoySy30ArjlY9K2rPKmPl1yNOoPZN5X1cTBan+2Q
        UEHGGt8YD8Dyti2vPYl2K4E427JFP/FQ7URRA9aIrHhvvZvKyzsDbRDfYGYaTA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676317244;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0ey95PcH3gvAht5TBXYP/ZcYBkv73pjM1L2rul30pnw=;
        b=VXCPBT+f6Sd8ctJq7nLn+BjSrC3LXi5hH4ikDsldktBNh6u9GPfD0qG1g778EdEqb+AWD/
        xP8ukAaVEq7utEAg==
From:   "irqchip-bot for Johan Hovold" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqdomain: Drop leftover brackets
Cc:     philmd@linaro.org, "Hsin-Yi Wang" <hsinyi@chromium.org>,
        "Mark-PK Tsai" <mark-pk.tsai@mediatek.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20230213104302.17307-11-johan+linaro@kernel.org>
References: <20230213104302.17307-11-johan+linaro@kernel.org>
MIME-Version: 1.0
Message-ID: <167631724416.4906.16844523664103140772.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqc=
hip:

Commit-ID:     4e0d86df9344bfd1951eb2571e4ef8f3d37000a4
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platfo=
rms/4e0d86df9344bfd1951eb2571e4ef8f3d37000a4
Author:        Johan Hovold <johan+linaro@kernel.org>
AuthorDate:    Mon, 13 Feb 2023 11:42:52 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Mon, 13 Feb 2023 19:31:24=20

irqdomain: Drop leftover brackets

Drop some unnecessary brackets that were left in place when the
corresponding code was updated.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
Tested-by: Hsin-Yi Wang <hsinyi@chromium.org>
Tested-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20230213104302.17307-11-johan+linaro@kernel.o=
rg
---
 kernel/irq/irqdomain.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 6bd6b61..3a3213d 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -210,9 +210,8 @@ static struct irq_domain *__irq_domain_create(struct fwno=
de_handle *fwnode,
 	domain->host_data =3D host_data;
 	domain->hwirq_max =3D hwirq_max;
=20
-	if (direct_max) {
+	if (direct_max)
 		domain->flags |=3D IRQ_DOMAIN_FLAG_NO_MAP;
-	}
=20
 	domain->revmap_size =3D size;
=20
@@ -652,9 +651,8 @@ void irq_domain_associate_many(struct irq_domain *domain,=
 unsigned int irq_base,
 	pr_debug("%s(%s, irqbase=3D%i, hwbase=3D%i, count=3D%i)\n", __func__,
 		of_node_full_name(of_node), irq_base, (int)hwirq_base, count);
=20
-	for (i =3D 0; i < count; i++) {
+	for (i =3D 0; i < count; i++)
 		irq_domain_associate(domain, irq_base + i, hwirq_base + i);
-	}
 }
 EXPORT_SYMBOL_GPL(irq_domain_associate_many);
=20
