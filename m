Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECA3C6E7A77
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 15:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232976AbjDSNS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 09:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232553AbjDSNS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 09:18:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95327146F1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 06:18:24 -0700 (PDT)
Date:   Wed, 19 Apr 2023 13:18:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681910303;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lG275QBRVJan002C8Xh0HeJNh0LuXsL25ySfhtwE1d4=;
        b=z4G35qYfijIAxaECBNy8UR/c1SSKfMThywbgqhhaB3vJpEV8nEIVLt3umusjewBTZochjF
        IEhlwtP5sIM7IqA9BPrf/oCYuRe4Oid3oee/dh7opv4JZU3FUe0hycG3L7kSqibDU++X8f
        s01oJREvZCHWDLDoY8yi+LivbmtM2061qXZC6qsENVlgrcB35IsNFXiDWKcbrVJGN+nLwp
        dvAD//eFSHarlQ6ch7JDtuLBoOTmvYHr/FRMERJlPrLxNCIwqwUyaylxY8YWbZnxNsVX3c
        EfRJxD4v+Qy1VuDtY/wqaiRhG/sflcYctDXGSdyNZsiHvvsMSo7Tc4tSTaY8VQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681910303;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lG275QBRVJan002C8Xh0HeJNh0LuXsL25ySfhtwE1d4=;
        b=O/CBhoqR6UeuJulkMbofUrYh1TXVdeeDcp/bQDFI+wOwHJ1uo34WONFMo/L6Cq2xb9Gad4
        tD90fQaVYbh+uyAg==
From:   "irqchip-bot for Alain Volmat" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/st: Remove stih415/stih416 and
 stid127 platforms support
Cc:     Alain Volmat <avolmat@me.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20230416190501.18737-1-avolmat@me.com>
References: <20230416190501.18737-1-avolmat@me.com>
MIME-Version: 1.0
Message-ID: <168191030239.404.849191030846628178.tip-bot2@tip-bot2>
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

Commit-ID:     0989ffb31cff794506f5d3dd109574ddbb9b983a
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/0989ffb31cff794506f5d3dd109574ddbb9b983a
Author:        Alain Volmat <avolmat@me.com>
AuthorDate:    Sun, 16 Apr 2023 21:05:01 +02:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 19 Apr 2023 14:08:52 +01:00

irqchip/st: Remove stih415/stih416 and stid127 platforms support

Remove support for the already no more supported stih415 and stih416
platforms.  Remove as well the stid127 platform which never made it
up to the kernel.

Signed-off-by: Alain Volmat <avolmat@me.com>
Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20230416190501.18737-1-avolmat@me.com
---
 drivers/irqchip/irq-st.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/irqchip/irq-st.c b/drivers/irqchip/irq-st.c
index 1b83512..819a122 100644
--- a/drivers/irqchip/irq-st.c
+++ b/drivers/irqchip/irq-st.c
@@ -15,10 +15,7 @@
 #include <linux/regmap.h>
 #include <linux/slab.h>
 
-#define STIH415_SYSCFG_642		0x0a8
-#define STIH416_SYSCFG_7543		0x87c
 #define STIH407_SYSCFG_5102		0x198
-#define STID127_SYSCFG_734		0x088
 
 #define ST_A9_IRQ_MASK			0x001FFFFF
 #define ST_A9_IRQ_MAX_CHANS		2
@@ -45,21 +42,9 @@ struct st_irq_syscfg {
 
 static const struct of_device_id st_irq_syscfg_match[] = {
 	{
-		.compatible = "st,stih415-irq-syscfg",
-		.data = (void *)STIH415_SYSCFG_642,
-	},
-	{
-		.compatible = "st,stih416-irq-syscfg",
-		.data = (void *)STIH416_SYSCFG_7543,
-	},
-	{
 		.compatible = "st,stih407-irq-syscfg",
 		.data = (void *)STIH407_SYSCFG_5102,
 	},
-	{
-		.compatible = "st,stid127-irq-syscfg",
-		.data = (void *)STID127_SYSCFG_734,
-	},
 	{}
 };
 
