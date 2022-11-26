Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 731FC639627
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 14:34:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbiKZNen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 08:34:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiKZNef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 08:34:35 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C8119021
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 05:34:34 -0800 (PST)
Date:   Sat, 26 Nov 2022 13:34:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669469672;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IumkYiQ9EfgcJn1sHROlqal/ZhzBUid4Jn8OLy+cW6k=;
        b=aAOHknVYR6KCCccSTyYkHDPKLFDM5V05I+zjpSwMMl7s9u3tX49fukacINQFX2Iim2Guo8
        VBCy1c9+j4YlTu27NlLj0lsa9D839u4Hf1mZtTLEqvxJ70QXDPEDxYK3gKRC9CoiMWH0Xk
        /NpUXmIofPVEFiIruLPeMg3uKHH10X4+zQZRha0s10x2f0R8Gm/GdgVUoAOC3TCRYBFst1
        QrEn/O2KRBTG8syHFIpi1PPXHNxsQF3PPP7uloNKBsyNTXFGpwcKF7OeoBdIAlRlSJYzWA
        fdsHan343eF68/OSL5TDuAALeYtM/pmLNWxBrFrihjjQSDcAwrP1QajFgFjgXA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669469672;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IumkYiQ9EfgcJn1sHROlqal/ZhzBUid4Jn8OLy+cW6k=;
        b=aMNllcwkPFLu6NiC5UqotrbEVH7VOcWOAPdFqrOtnMTLCxPNtUcbr0s16KiXs6tHc+uJBW
        TPLSEGu+Ovy+8MDQ==
From:   "irqchip-bot for Jean Delvare" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/al-fic: Drop obsolete dependency
 on COMPILE_TEST
Cc:     Jean Delvare <jdelvare@suse.de>, Talel Shenhar <talel@amazon.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
In-Reply-To: <20221121161622.6294a899@endymion.delvare>
References: <20221121161622.6294a899@endymion.delvare>
MIME-Version: 1.0
Message-ID: <166946967148.4906.692319381666088816.tip-bot2@tip-bot2>
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

Commit-ID:     9869f37aa4ee2a2e08536529dab4ccda9e23ce0c
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/9869f37aa4ee2a2e08536529dab4ccda9e23ce0c
Author:        Jean Delvare <jdelvare@suse.de>
AuthorDate:    Mon, 21 Nov 2022 16:16:22 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sat, 26 Nov 2022 13:29:42 

irqchip/al-fic: Drop obsolete dependency on COMPILE_TEST

Since commit 0166dc11be91 ("of: make CONFIG_OF user selectable"), it
is possible to test-build any driver which depends on OF on any
architecture by explicitly selecting OF. Therefore depending on
COMPILE_TEST as an alternative is no longer needed.

It is actually better to always build such drivers with OF enabled,
so that the test builds are closer to how each driver will actually be
built on its intended target. Building them without OF may not test
much as the compiler will optimize out potentially large parts of the
code. In the worst case, this could even pop false positive warnings.
Dropping COMPILE_TEST here improves the quality of our testing and
avoids wasting time on non-existent issues.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: Talel Shenhar <talel@amazon.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20221121161622.6294a899@endymion.delvare
---
 drivers/irqchip/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 7ef9f5e..de43144 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -86,7 +86,7 @@ config ALPINE_MSI
 
 config AL_FIC
 	bool "Amazon's Annapurna Labs Fabric Interrupt Controller"
-	depends on OF || COMPILE_TEST
+	depends on OF
 	select GENERIC_IRQ_CHIP
 	select IRQ_DOMAIN
 	help
