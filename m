Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E71555EDDD4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 15:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234089AbiI1Nha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 09:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233766AbiI1NhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 09:37:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F568E0FE
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 06:37:19 -0700 (PDT)
Date:   Wed, 28 Sep 2022 13:37:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1664372237;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aOAGHq/P9nTk8L01xWDXNzpV3s9ABFiqF0pELt1xUYE=;
        b=zDRfQz4wreyit+POa9oG8PbP7yO44esK0Cj3gW1KYjJ5Oa89H2DKHavmwE08brmofUId4J
        onUgmCAk/Z8Q8SgmGrdaDFgsWqs7Px7XX4EuAdtWf+CH2+0AzdX8q7FjYxIZRkD3mf34Cx
        VgE5kufM134LdLnjlg0cyyzrmrW/91LPraGtU30v9nA0ndDxixFk2FeRV018Fj7vfDG+Rc
        WJq0azRMccYxRDoZlhugA0rGMPlid1WMW8zotfdK5ELPdytJ7fQ72hz5DiF7Fj4BkqiM2T
        lsakgRgCOBk9MicEGO2AL05iqR0hp9tukvKqwSmNq6UTejN3vfuX7dUgacwHGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1664372237;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aOAGHq/P9nTk8L01xWDXNzpV3s9ABFiqF0pELt1xUYE=;
        b=12gV73B0G5M6LBXhKEDsC/kLQrfxP5J2cUkG83RyIIRUFECZ65DLEHhyhUmE+Dok+rvmrx
        TTtf0zhx4OqznKDw==
From:   "irqchip-bot for Frank Li" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip: Allow extra fields to be passed
 to IRQCHIP_PLATFORM_DRIVER_END
Cc:     Frank Li <Frank.Li@nxp.com>, Marc Zyngier <maz@kernel.org>,
        tglx@linutronix.de
In-Reply-To: <20220922161246.20586-3-Frank.Li@nxp.com>
References: <20220922161246.20586-3-Frank.Li@nxp.com>
MIME-Version: 1.0
Message-ID: <166437223652.401.2238283063035568160.tip-bot2@tip-bot2>
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

Commit-ID:     334f7d42db3eb0274aa6b4aba7ce14d87df3fef0
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/334f7d42db3eb0274aa6b4aba7ce14d87df3fef0
Author:        Frank Li <Frank.Li@nxp.com>
AuthorDate:    Thu, 22 Sep 2022 11:12:42 -05:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 28 Sep 2022 14:21:53 +01:00

irqchip: Allow extra fields to be passed to IRQCHIP_PLATFORM_DRIVER_END

IRQCHIP_PLATFORM_DRIVER_* doesn't allow some fields (such as .pm)
to be set in the platform_driver structure.

Make IRQCHIP_PLATFORM_DRIVER_END variadic so that .pm or another
field can be set if needed.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
[maz: revamped commit message]
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220922161246.20586-3-Frank.Li@nxp.com
---
 include/linux/irqchip.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/irqchip.h b/include/linux/irqchip.h
index 3a091d0..d5e6024 100644
--- a/include/linux/irqchip.h
+++ b/include/linux/irqchip.h
@@ -44,7 +44,8 @@ static const struct of_device_id drv_name##_irqchip_match_table[] = {
 #define IRQCHIP_MATCH(compat, fn) { .compatible = compat,		\
 				    .data = typecheck_irq_init_cb(fn), },
 
-#define IRQCHIP_PLATFORM_DRIVER_END(drv_name)				\
+
+#define IRQCHIP_PLATFORM_DRIVER_END(drv_name, ...)			\
 	{},								\
 };									\
 MODULE_DEVICE_TABLE(of, drv_name##_irqchip_match_table);		\
@@ -56,6 +57,7 @@ static struct platform_driver drv_name##_driver = {			\
 		.owner = THIS_MODULE,					\
 		.of_match_table = drv_name##_irqchip_match_table,	\
 		.suppress_bind_attrs = true,				\
+		__VA_ARGS__						\
 	},								\
 };									\
 builtin_platform_driver(drv_name##_driver)
