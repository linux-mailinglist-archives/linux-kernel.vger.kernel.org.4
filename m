Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE8169BA6E
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 15:28:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbjBRO2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 09:28:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjBRO2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 09:28:37 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3241315CBD
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 06:28:36 -0800 (PST)
Date:   Sat, 18 Feb 2023 14:28:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676730513;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vl6n7PSDf8dH46gyX7pAqYpLt9UJYFedNkQQ0eBRhEU=;
        b=gnsmQQdfNYA8G/+Rq89gSRO09u+KcGL/04uUNPc4Px1cPzd1xBQy2gyDGIrFV846SHjsLe
        kRONRsa/1+fmw5tdhgsf8LWMDqft3eh5yBsYTxkUH4qyi+Pp48btR/6hQ2YCtHKCMMQxpC
        tGPfh5OlpSfOJvJYdCnSWa585jHmin8dSOuAV7uDR7nZzhXE9Dla7NrQWTfpbl6+tMItRX
        xEIYxijSVDIBrUXNgLgQRsQWDAlx9nBRtzTgcoDcXBsXZK7nurNScFf5KmWXvG6C27pmQD
        KiBOknVBnqUhJ51vGa5DLcCwWHpnEQhNHYg/W43WQ5mFCC9fGI4DDVtcwThyRQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676730513;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vl6n7PSDf8dH46gyX7pAqYpLt9UJYFedNkQQ0eBRhEU=;
        b=+n64HUILg6xmzUfembODqvkXUeBk8yWEo9XUaORQaOiXGAzH306d+NCm8NvLm5YNKwlRdA
        ndqyqbE2ANvnnhCw==
From:   "irqchip-bot for Florian Fainelli" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/irq-bcm7120-l2: Set IRQ_LEVEL for
 level triggered interrupts
Cc:     Florian Fainelli <f.fainelli@gmail.com>, philmd@linaro.org,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20221216230934.2478345-3-f.fainelli@gmail.com>
References: <20221216230934.2478345-3-f.fainelli@gmail.com>
MIME-Version: 1.0
Message-ID: <167673051273.4906.12544908266625513650.tip-bot2@tip-bot2>
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

Commit-ID:     13a157b38ca5b4f9eed81442b8821db293755961
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platfo=
rms/13a157b38ca5b4f9eed81442b8821db293755961
Author:        Florian Fainelli <f.fainelli@gmail.com>
AuthorDate:    Fri, 16 Dec 2022 15:09:34 -08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sat, 18 Feb 2023 14:23:41=20

irqchip/irq-bcm7120-l2: Set IRQ_LEVEL for level triggered interrupts

When support for the interrupt controller was added with a5042de2688d,
we forgot to update the flags to be set to contain IRQ_LEVEL. While the
flow handler is correct, the output from /proc/interrupts does not show
such interrupts as being level triggered when they are, correct that.

Fixes: a5042de2688d ("irqchip: bcm7120-l2: Add Broadcom BCM7120-style Level 2=
 interrupt controller")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20221216230934.2478345-3-f.fainelli@gmail.com
---
 drivers/irqchip/irq-bcm7120-l2.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-bcm7120-l2.c b/drivers/irqchip/irq-bcm7120-l=
2.c
index bb6609c..1e9dab6 100644
--- a/drivers/irqchip/irq-bcm7120-l2.c
+++ b/drivers/irqchip/irq-bcm7120-l2.c
@@ -279,7 +279,8 @@ static int __init bcm7120_l2_intc_probe(struct device_nod=
e *dn,
 		flags |=3D IRQ_GC_BE_IO;
=20
 	ret =3D irq_alloc_domain_generic_chips(data->domain, IRQS_PER_WORD, 1,
-				dn->full_name, handle_level_irq, clr, 0, flags);
+				dn->full_name, handle_level_irq, clr,
+				IRQ_LEVEL, flags);
 	if (ret) {
 		pr_err("failed to allocate generic irq chip\n");
 		goto out_free_domain;
