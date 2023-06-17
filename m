Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2AAC733EC2
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 08:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345995AbjFQGk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 02:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234065AbjFQGj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 02:39:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D12CB2D77
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 23:39:52 -0700 (PDT)
Date:   Sat, 17 Jun 2023 06:39:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686983991;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cSxgI2o5uihiND/DdC/IbroCuDyv7atO+hbKcF7qv+8=;
        b=DwOLb+ln2HmL3he9ygQ1/VIXq0tJcOmD6/IBMWfnivKOIAqMw1HCqFmCwvkZT1yxxVIgnL
        QqqzzK5hsdPBa4RuF9rusN4gFpA7yvQcGtwQmYKrACVa6nV0K+AwB2WE3mVEQbCww3u8Zq
        UFBAbv/KpPKV0hmARj5e8c07rhJhaDY0rc13Apcha3rxI0nTP7btDKgbMrfUGlA5GrZXT6
        irPzlMUFHWzqFnNqIKz818buJDtfa1gqJ1VDRbwx+rS/fnn8/udZMix+xksNUv2f9JRLoz
        LIuFPE8DTbLRU/qLAgTcGPnCmKwOcpuHruruo7PIspyjZBNzTmMuJve91TMA5Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686983991;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cSxgI2o5uihiND/DdC/IbroCuDyv7atO+hbKcF7qv+8=;
        b=fhPR0lvQmaYbUWjnrnOjV3hrXRRAu0hR0Z8sz0K35NeUbezkb2v4um6kXtvlQUSkV5zvci
        7DL/piGFmb1LA6Cw==
From:   "irqchip-bot for Arnd Bergmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/clps711x: Remove unused
 clps711x_intc_init() function
Cc:     Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <maz@kernel.org>,
        tglx@linutronix.de
In-Reply-To: <20230516200516.554663-3-arnd@kernel.org>
References: <20230516200516.554663-3-arnd@kernel.org>
MIME-Version: 1.0
Message-ID: <168698399095.404.9422113582417114481.tip-bot2@tip-bot2>
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

Commit-ID:     eee284fe8f326719fed1963e0851cbb2185076f8
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/eee284fe8f326719fed1963e0851cbb2185076f8
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Tue, 16 May 2023 22:05:06 +02:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sat, 17 Jun 2023 07:21:08 +01:00

irqchip/clps711x: Remove unused clps711x_intc_init() function

This function has no caller or declaration any more:

drivers/irqchip/irq-clps711x.c:215:13: error: no previous prototype for 'clps711x_intc_init'

The #ifdef check around clps711x_intc_init_dt() is also not
needed since the file is only built when that is enabled.

Fixes: 4a56f46a7dc6 ("ARM: clps711x: Remove boards support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20230516200516.554663-3-arnd@kernel.org
---
 drivers/irqchip/irq-clps711x.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/irqchip/irq-clps711x.c b/drivers/irqchip/irq-clps711x.c
index 77ebe7e..e731e07 100644
--- a/drivers/irqchip/irq-clps711x.c
+++ b/drivers/irqchip/irq-clps711x.c
@@ -212,12 +212,6 @@ out_kfree:
 	return err;
 }
 
-void __init clps711x_intc_init(phys_addr_t base, resource_size_t size)
-{
-	BUG_ON(_clps711x_intc_init(NULL, base, size));
-}
-
-#ifdef CONFIG_IRQCHIP
 static int __init clps711x_intc_init_dt(struct device_node *np,
 					struct device_node *parent)
 {
@@ -231,4 +225,3 @@ static int __init clps711x_intc_init_dt(struct device_node *np,
 	return _clps711x_intc_init(np, res.start, resource_size(&res));
 }
 IRQCHIP_DECLARE(clps711x, "cirrus,ep7209-intc", clps711x_intc_init_dt);
-#endif
