Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF7BB6950DE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 20:41:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbjBMTlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 14:41:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbjBMTkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 14:40:53 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4532A1F91D
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 11:40:46 -0800 (PST)
Date:   Mon, 13 Feb 2023 19:40:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676317245;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aYTKSpozZ9Dms3KK5g6EFO4wHq//fandKtT1knzWqZ4=;
        b=zjXTJ58KZjRRDbtyqwybiTgjl1dzyDaU28Cf79ZkaYzTlS/Yp+4bkwG2oabT6MTMJ8a9aL
        9woZgcQ+DDWoECXfuJOyR3DfifygN5+pKld72VyJvzC9Clg2i3bjDtN8wn8xbtLi6fG6jZ
        u9pX2nGrdg0/V6xZpR0dD8O2XpseydXiRRI9drp7/6tjtf1X7OcMervk2bPVkJpAwNSwqd
        Gr4Iut9P2zmRR6g12Tz5wbLbCFDhhfDxXeyEZz8FkFg6yyLyqkzxx/Y/fBJ5Lg2u2mvJ4i
        1DSyvOf1kWwO2/PetniXxhKQ1367ifdKCxR35gTP06u1gy1yw0kEUU4xwwsQSQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676317245;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aYTKSpozZ9Dms3KK5g6EFO4wHq//fandKtT1knzWqZ4=;
        b=4V+odxnlY0WRnbEgLDhNnKE35gsKtpikJVJ6wmcWJr9lW7Y2GDz2fwuF3EsiA4GRx39Les
        l4SjubnLsFpWdKAA==
From:   "irqchip-bot for Johan Hovold" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqdomain: Drop dead domain-name assignment
Cc:     "Hsin-Yi Wang" <hsinyi@chromium.org>,
        "Mark-PK Tsai" <mark-pk.tsai@mediatek.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20230213104302.17307-10-johan+linaro@kernel.org>
References: <20230213104302.17307-10-johan+linaro@kernel.org>
MIME-Version: 1.0
Message-ID: <167631724456.4906.17248424991679732904.tip-bot2@tip-bot2>
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

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     28a9ff23d8b56db09cb01cef174a205ea5e2ca49
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/28a9ff23d8b56db09cb01cef174a205ea5e2ca49
Author:        Johan Hovold <johan+linaro@kernel.org>
AuthorDate:    Mon, 13 Feb 2023 11:42:51 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Mon, 13 Feb 2023 19:31:24 

irqdomain: Drop dead domain-name assignment

Since commit d59f6617eef0 ("genirq: Allow fwnode to carry name
information only") an IRQ domain is always given a name during
allocation (e.g. used for the debugfs entry).

Drop the leftover name assignment when allocating the first IRQ.

Tested-by: Hsin-Yi Wang <hsinyi@chromium.org>
Tested-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20230213104302.17307-10-johan+linaro@kernel.org
---
 kernel/irq/irqdomain.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index c7113e7..6bd6b61 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -619,10 +619,6 @@ static int irq_domain_associate_locked(struct irq_domain *domain, unsigned int v
 			irq_data->hwirq = 0;
 			return ret;
 		}
-
-		/* If not already assigned, give the domain the chip's name */
-		if (!domain->name && irq_data->chip)
-			domain->name = irq_data->chip->name;
 	}
 
 	domain->mapcount++;
@@ -1182,10 +1178,6 @@ static void irq_domain_insert_irq(int virq)
 
 		domain->mapcount++;
 		irq_domain_set_mapping(domain, data->hwirq, data);
-
-		/* If not already assigned, give the domain the chip's name */
-		if (!domain->name && data->chip)
-			domain->name = data->chip->name;
 	}
 
 	irq_clear_status_flags(virq, IRQ_NOREQUEST);
