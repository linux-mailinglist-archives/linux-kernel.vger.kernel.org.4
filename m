Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 990585FC16B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 09:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbiJLHtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 03:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiJLHtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 03:49:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85258AD9A0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 00:49:05 -0700 (PDT)
Date:   Wed, 12 Oct 2022 07:49:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1665560943;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nILnuT5+EWFw6pzt97EzXBIfRzVx4FkNiw7lRp5vR7Q=;
        b=FP7/q2PU1AcVFCgFZ+X/MFtYzyn1ian3BK9l+N3rDu2D5exXg0u0KIhNwcWeHisZrBVom1
        wJpBqNdgWgI79ENTznuLEz1QiibvTwg9RsdxnlQcJEWv7JdLD62uB45F5YnjGMaykpFbp4
        gEyWbeW3X+ynW4ksDSQ8C8/PQA1km8TrmrP0T/LE03aF8tduUo3FHcHZ9frq/8czZHQHh2
        uOs/3xmne5A0oDSrB5xLiRVqgwKN6NLkFNJiQurFaat7N4zVPWiYg9Cw4iuO6rATZkU/wJ
        KpWi6X6Nh1bKwk8qHEP4yBinXg0ZX1wReu5hbB2vuWi6spi9OQL/sLy7H2QfMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1665560943;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nILnuT5+EWFw6pzt97EzXBIfRzVx4FkNiw7lRp5vR7Q=;
        b=MVuFZ2nB7yq6VFUyUnqVWXNiny961uKxiIhtojsD7yfsXbEStnGR10HM26LCoCcDt9JhOF
        15s/xfeVoiky3pDg==
From:   "irqchip-bot for Geert Uytterhoeven" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-fixes] irqchip: IMX_MU_MSI should depend on ARCH_MXC
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: =?utf-8?q?=3C7f3bd932614ddbff46a1b750ef45b231130364ad=2E16649?=
 =?utf-8?q?00434=2Egit=2Egeert+renesas=40glider=2Ebe=3E?=
References: =?utf-8?q?=3C7f3bd932614ddbff46a1b750ef45b231130364ad=2E166490?=
 =?utf-8?q?0434=2Egit=2Egeert+renesas=40glider=2Ebe=3E?=
MIME-Version: 1.0
Message-ID: <166556094146.401.3044335312264028864.tip-bot2@tip-bot2>
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

The following commit has been merged into the irq/irqchip-fixes branch of irqchip:

Commit-ID:     6c9f7434159b96231f5b27ab938f4766e3586b48
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/6c9f7434159b96231f5b27ab938f4766e3586b48
Author:        Geert Uytterhoeven <geert+renesas@glider.be>
AuthorDate:    Tue, 04 Oct 2022 18:22:30 +02:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 12 Oct 2022 08:43:59 +01:00

irqchip: IMX_MU_MSI should depend on ARCH_MXC

The Freescale/NXP i.MX Messaging Unit is only present on Freescale/NXP
i.MX SoCs.  Hence add a dependency on ARCH_MXC, to prevent asking the
user about this driver when configuring a kernel without Freescale/NXP
i.MX SoC family support.

While at it, expand "MU" to "Messaging Unit" in the help text.

Fixes: 70afdab904d2d1e6 ("irqchip: Add IMX MU MSI controller driver")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/7f3bd932614ddbff46a1b750ef45b231130364ad.1664900434.git.geert+renesas@glider.be
---
 drivers/irqchip/Kconfig | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 4d85a18..93d9901 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -484,14 +484,15 @@ config IMX_INTMUX
 config IMX_MU_MSI
 	tristate "i.MX MU used as MSI controller"
 	depends on OF && HAS_IOMEM
+	depends on ARCH_MXC || COMPILE_TEST
 	default m if ARCH_MXC
 	select IRQ_DOMAIN
 	select IRQ_DOMAIN_HIERARCHY
 	select GENERIC_MSI_IRQ_DOMAIN
 	help
-	  Provide a driver for the MU block used as a CPU-to-CPU MSI
-	  controller. This requires a specially crafted DT to make use
-	  of this driver.
+	  Provide a driver for the i.MX Messaging Unit block used as a
+	  CPU-to-CPU MSI controller. This requires a specially crafted DT
+	  to make use of this driver.
 
 	  If unsure, say N
 
