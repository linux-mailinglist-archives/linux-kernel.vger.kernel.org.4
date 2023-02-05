Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E82CA68AF86
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 12:30:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjBELaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 06:30:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjBEL35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 06:29:57 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B27CA1E5EC
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 03:29:55 -0800 (PST)
Date:   Sun, 05 Feb 2023 11:29:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1675596592;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=62wSWH+oIYn4GwlDkxZYPwHC9ACp7YcRKrnuaghqHD8=;
        b=I9WWSjQyCL+fTyDwLM4zJwwE15FuLTW9LfG3oOW0Ccj2D8krdVqvQaGOn74acayVew9RqS
        1IFsCAwNpnaDQjRyol8zoHThOUkI7jT6OWrqpx4jug96FgpZ1joDKGohU335xhn2Kjs7/a
        6ekRe82zC8KjVIlhkRWWNHkNIqFhpe4K7Mczp+zG95zTnHV/ex7DO2LHGQPxqZeA+P0NWq
        9Z4tRB1qULFjIeSrOE8azsfjMvGEx9XJBKnDLCTA0Mz+2f+dtHeBD6cWepVfptubgllZFN
        Giu/jCpgixXrxZLxgvUdAs7UHrJJ7yADJj1gJcnFwKYjnGr+rpEHYroKP5FuoQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1675596592;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=62wSWH+oIYn4GwlDkxZYPwHC9ACp7YcRKrnuaghqHD8=;
        b=Z2+QXqCOKl5aMU6UhVS5a2a3dlAtxTvp874ZOI4jlhSLYe8q7IBt8MgAZD54P1CpiE3qFC
        Wvra1IxzmJpb0rAQ==
From:   "irqchip-bot for Lukas Bulwahn" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/ls-scfg-msi: Simplify Kconfig
 dependencies
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20230111100554.24500-1-lukas.bulwahn@gmail.com>
References: <20230111100554.24500-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Message-ID: <167559659183.4906.12881958670325527864.tip-bot2@tip-bot2>
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

Commit-ID:     9c1a7bfc2993112cfb3056b18301fcafe5c2fde5
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/9c1a7bfc2993112cfb3056b18301fcafe5c2fde5
Author:        Lukas Bulwahn <lukas.bulwahn@gmail.com>
AuthorDate:    Wed, 11 Jan 2023 11:05:54 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sun, 05 Feb 2023 11:19:03 

irqchip/ls-scfg-msi: Simplify Kconfig dependencies

Having both PCI_MSI and PCI is redundant. Drop PCI.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
[maz: cut commit message extra verbosity]
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20230111100554.24500-1-lukas.bulwahn@gmail.com
---
 drivers/irqchip/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index caa952c..f3d88e9 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -389,7 +389,7 @@ config LS_EXTIRQ
 
 config LS_SCFG_MSI
 	def_bool y if SOC_LS1021A || ARCH_LAYERSCAPE
-	depends on PCI && PCI_MSI
+	depends on PCI_MSI
 
 config PARTITION_PERCPU
 	bool
