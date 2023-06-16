Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1543D7330AE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 14:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345083AbjFPMDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 08:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234512AbjFPMDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 08:03:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F9AE4
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 05:03:10 -0700 (PDT)
Date:   Fri, 16 Jun 2023 12:03:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686916989;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UjMg9W2029+6XwcA4Xug4OSXNP1m2xFIw7T+baEWEVU=;
        b=uKprTJ1Z1ts3v4s7Y05cSCd8BaWuTR+00laMS4fofnLHfaBs4IIq+EJ/KvEWkCnGXIqyfJ
        umlq/eRz9KRjnR8hvReE+HdFRJdr3ae5I2jcDzj3VAP1RL6lfGLqNcp13ZLXRYa+uiyb0d
        Ny3ZDNTsiPaPx5pP5my0Fh5Xba5IkUvguJn5L3sJElogvq/tKNnmpjBM6koZdTsiHJwRyt
        oImpa33HJy+0upGO+ome9DvBNwE+Pfpu3UTxylq800ly1nSZbx7cWacyWdURh1vDJ6TEPH
        qvdQMNzDmiToOE5Cs+iP9HiMIpQTICVXIuSaPunv+ocl8+EbPdwBJL1KVb+Frg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686916989;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UjMg9W2029+6XwcA4Xug4OSXNP1m2xFIw7T+baEWEVU=;
        b=AwMrgbRrrB9C6mhs8XRE0Ls+icUuvhsdkybqKjU4eadxQT1sFRTdevca2dh10tTv1Il/uK
        Ed7ffMDNKe5NMLCg==
From:   "irqchip-bot for Yinbo Zhu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/loongson-liointc: Add
 IRQCHIP_SKIP_SET_WAKE flag
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        Yinbo Zhu <zhuyinbo@loongson.cn>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20230614115936.5950-5-lvjianmin@loongson.cn>
References: <20230614115936.5950-5-lvjianmin@loongson.cn>
MIME-Version: 1.0
Message-ID: <168691698876.404.4049861054836666260.tip-bot2@tip-bot2>
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

Commit-ID:     e01f9882f6fdbe0fa8ae39fe7691db2964e9fda6
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/e01f9882f6fdbe0fa8ae39fe7691db2964e9fda6
Author:        Yinbo Zhu <zhuyinbo@loongson.cn>
AuthorDate:    Wed, 14 Jun 2023 19:59:35 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Fri, 16 Jun 2023 12:59:28 +01:00

irqchip/loongson-liointc: Add IRQCHIP_SKIP_SET_WAKE flag

LIOINTC doesn't require specific logic to work with wakeup IRQs,
and no irq_set_wake callback is needed. To allow registered IRQs
from LIOINTC to be used as a wakeup-source, and ensure irq_set_irq_wake()
works well, the flag IRQCHIP_SKIP_SET_WAKE should be added.

Reviewed-by: Huacai Chen <chenhuacai@kernel.org>
Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20230614115936.5950-5-lvjianmin@loongson.cn
---
 drivers/irqchip/irq-loongson-liointc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/irqchip/irq-loongson-liointc.c b/drivers/irqchip/irq-loongson-liointc.c
index 5dd9db8..e4b33ae 100644
--- a/drivers/irqchip/irq-loongson-liointc.c
+++ b/drivers/irqchip/irq-loongson-liointc.c
@@ -295,6 +295,7 @@ static int liointc_init(phys_addr_t addr, unsigned long size, int revision,
 	ct->chip.irq_mask = irq_gc_mask_disable_reg;
 	ct->chip.irq_mask_ack = irq_gc_mask_disable_reg;
 	ct->chip.irq_set_type = liointc_set_type;
+	ct->chip.flags = IRQCHIP_SKIP_SET_WAKE;
 
 	gc->mask_cache = 0;
 	priv->gc = gc;
