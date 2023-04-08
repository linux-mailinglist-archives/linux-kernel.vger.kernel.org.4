Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBFDA6DBA3A
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 12:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjDHKuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 06:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbjDHKtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 06:49:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F4F113D7
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 03:48:58 -0700 (PDT)
Date:   Sat, 08 Apr 2023 10:45:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1680950721;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YFX2XZ6rPTkBPgbt+bmfi2tBwL0d+qePMLiRgHvH19w=;
        b=35T6t51qir9bQL0EbZWK4k7+FDn+qICCRNJtT/asL9KudsbMZkA16ZROaojmbgOG9AUCqn
        1g6+w8g4LP79kfgFqWjVbBcJ4SIg+rZHWY31+ngygHtPgJZmtv7S6l0c9+g8sk4OcE87aF
        +9Y44UW+HJBWtcyS8vGGlByJ4oZ4WNhrT4jRfETI8VXg+U/HP10zlrZKcCc2W6lAwyT/eT
        o4CHWuOK6uuVvN8keOV/tsfxrDEn7R5PJRV8A4WJ2UUz6WbDpk/Hymn4zdIiukpWVAJ2ID
        i+B03blEL5bIc/PkELm04gq38hoqlFJh23JGFjGKd4ubpWn2o1rP4bzsfhEvaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1680950721;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YFX2XZ6rPTkBPgbt+bmfi2tBwL0d+qePMLiRgHvH19w=;
        b=V4tFp6o6gJbkrfq0Z3t7S3ocgUPxhkE9dkI1PxAoRuyreh/THK9IICjJeA6AMaiyMkY0Ay
        eWKuXKyhHh0AjyBg==
From:   irqchip-bot for =?utf-8?q?=C3=81lvaro_Fern=C3=A1ndez?= Rojas 
        <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/bcm-6345-l1: Request memory region
Cc:     noltari@gmail.com, Florian Fainelli <f.fainelli@gmail.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20230316192833.1603149-1-noltari@gmail.com>
References: <20230316192833.1603149-1-noltari@gmail.com>
MIME-Version: 1.0
Message-ID: <168095072076.404.2128594434310940615.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqc=
hip:

Commit-ID:     23c7ff129cf33dee5f1f4fd9fa729ab440e8f1c5
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platfo=
rms/23c7ff129cf33dee5f1f4fd9fa729ab440e8f1c5
Author:        =C3=81lvaro Fern=C3=A1ndez Rojas <noltari@gmail.com>
AuthorDate:    Thu, 16 Mar 2023 20:28:33 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sat, 08 Apr 2023 11:07:43 +01:00

irqchip/bcm-6345-l1: Request memory region

Request memory region in order to display it in /proc/iomem.
Also stop printing the MMIO address since it just displays (ptrval).

Signed-off-by: =C3=81lvaro Fern=C3=A1ndez Rojas <noltari@gmail.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20230316192833.1603149-1-noltari@gmail.com
---
 drivers/irqchip/irq-bcm6345-l1.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-bcm6345-l1.c b/drivers/irqchip/irq-bcm6345-l=
1.c
index 6899e37..fa113cb 100644
--- a/drivers/irqchip/irq-bcm6345-l1.c
+++ b/drivers/irqchip/irq-bcm6345-l1.c
@@ -257,6 +257,9 @@ static int __init bcm6345_l1_init_one(struct device_node =
*dn,
 	if (!cpu->map_base)
 		return -ENOMEM;
=20
+	if (!request_mem_region(res.start, sz, res.name))
+		pr_err("failed to request intc memory");
+
 	for (i =3D 0; i < n_words; i++) {
 		cpu->enable_cache[i] =3D 0;
 		__raw_writel(0, cpu->map_base + reg_enable(intc, i));
@@ -335,8 +338,7 @@ static int __init bcm6345_l1_of_init(struct device_node *=
dn,
 	for_each_cpu(idx, &intc->cpumask) {
 		struct bcm6345_l1_cpu *cpu =3D intc->cpus[idx];
=20
-		pr_info("  CPU%u at MMIO 0x%p (irq =3D %d)\n", idx,
-				cpu->map_base, cpu->parent_irq);
+		pr_info("  CPU%u (irq =3D %d)\n", idx, cpu->parent_irq);
 	}
=20
 	return 0;
