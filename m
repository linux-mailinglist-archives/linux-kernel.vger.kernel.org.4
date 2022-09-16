Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA63B5BA843
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 10:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbiIPIbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 04:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbiIPIa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 04:30:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D29A2D83
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 01:30:57 -0700 (PDT)
Date:   Fri, 16 Sep 2022 08:30:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1663317054;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oUpJn3EgpekMMpEmFe6TF1EpJp8wOwHCqa4qtIAfLMQ=;
        b=T1wz+SVs8I00Nr8cw6bh79/Z7bWS8QC6IftimVks3ifXMeRw09egJCFI9FyF6UevAOstOe
        F3NPuBVJu43BB5EhLDt1QByTbtA9NjLMoHNWfOtHCw4RmEK93IZJSkj3O4CpjCl77CALSi
        2fK4HngsA4gtL1w9ASklYPkDw/+Sa3bFeOpvWC/bHxmC/DsYRGuJuY1NmYFVaHnL7+9v9Q
        z3zAq694CBb2YRMVpg25+isMrNZILGUEdXr0C6PgB9tZopBl9PWTkJ/UYHplla3lZbON+T
        lZrGBhL/v5NCIV1vgrSdRVkneZiRG8Rz2gNHz6aXEV2gT9SsQGFAuGmvo/7S+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1663317054;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oUpJn3EgpekMMpEmFe6TF1EpJp8wOwHCqa4qtIAfLMQ=;
        b=KjpM8QzS2dtIZObEA8MrQudYrVjxbf+IBTuzmYBIU+h9E2//v3F0nfWBzLrVSe1v5YKtXR
        K43J90duOmP6RvDg==
From:   "irqchip-bot for Jianmin Lv" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-fixes] irqchip/loongson-pch-lpc: Add dependence
 on LoongArch
Cc:     kernel test robot <lkp@intel.com>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20220916071926.28368-1-lvjianmin@loongson.cn>
References: <20220916071926.28368-1-lvjianmin@loongson.cn>
MIME-Version: 1.0
Message-ID: <166331705298.401.6104186181548421193.tip-bot2@tip-bot2>
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

Commit-ID:     e7ccba7728cff0e0f1299951571f209fcadcb7b1
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/e7ccba7728cff0e0f1299951571f209fcadcb7b1
Author:        Jianmin Lv <lvjianmin@loongson.cn>
AuthorDate:    Fri, 16 Sep 2022 15:19:26 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Fri, 16 Sep 2022 09:25:51 +01:00

irqchip/loongson-pch-lpc: Add dependence on LoongArch

The loongson-pch-lpc driver may be selected in a random
configuration, but it is only supported for LoongArch, So,
the dependence on LoongArch is added for it to avoid compile
error for a random configuration of other architetures.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220916071926.28368-1-lvjianmin@loongson.cn
---
 drivers/irqchip/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 2549daa..eb5ea5b 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -628,8 +628,9 @@ config LOONGSON_PCH_MSI
 
 config LOONGSON_PCH_LPC
 	bool "Loongson PCH LPC Controller"
+	depends on LOONGARCH
 	depends on MACH_LOONGSON64
-	default (MACH_LOONGSON64 && LOONGARCH)
+	default MACH_LOONGSON64
 	select IRQ_DOMAIN_HIERARCHY
 	help
 	  Support for the Loongson PCH LPC Controller.
