Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F544640822
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 15:04:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233594AbiLBOET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 09:04:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233463AbiLBOEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 09:04:06 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC0ADB0E1;
        Fri,  2 Dec 2022 06:04:04 -0800 (PST)
Date:   Fri, 02 Dec 2022 14:04:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669989843;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q3vvwrGOWdRjoGVQ6sVEK4/+4iKXVaWVSNwYOLo/UTA=;
        b=VQhAgBuMYV9N02ol9psTzuroagwbBgWV9MeX1YHRsWI3oD4+4l1qQCbQQZsqKD0ZaKq9xd
        bp2MfkMz0epMvSWSPZ1pcfNFw6PWclxv6ooFqVQKRToGeadGL+EFzVfqxCtFH5WFx0uyUW
        MyRGaRAGnyDjoauqTsGaqvT+j93+pO7pYP+UzauyogMaN3S2z+OEKYXqwBsT+POWfMyoTy
        WA8HR+7xXcXe521s5IlhzFipIImriwiUegDcD1ZNGicmYGF6ndTMhWIWBTXT377ldV+oZy
        pblxgIE+XFYdRIiOhbvFk1UzSPSSEjhyxryOlV2ZyPYqYAHJDQDPDD7TFNf9MQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669989843;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q3vvwrGOWdRjoGVQ6sVEK4/+4iKXVaWVSNwYOLo/UTA=;
        b=fHkZbly2G7iCw7iWLmQtJ8iWHUnjo3hTqAyYrYtGvw+q09hTBzF/0ymEPKfvgNImR2Dsuy
        WfD1fQDOX+bqqtBA==
From:   "tip-bot2 for Andy Shevchenko" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/of: Remove unused early_init_dt_add_memory_arch()
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221124184824.9548-1-andriy.shevchenko@linux.intel.com>
References: <20221124184824.9548-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Message-ID: <166998984219.4906.12144964269143777509.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     9b09927c0cdec4d4e75f7f9e621eaec179a888fd
Gitweb:        https://git.kernel.org/tip/9b09927c0cdec4d4e75f7f9e621eaec179a888fd
Author:        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
AuthorDate:    Thu, 24 Nov 2022 20:48:24 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 02 Dec 2022 14:57:13 +01:00

x86/of: Remove unused early_init_dt_add_memory_arch()

Recently objtool started complaining about dead code in the object files,
in particular

vmlinux.o: warning: objtool: early_init_dt_scan_memory+0x191: unreachable instruction

when CONFIG_OF=y.

Indeed, early_init_dt_scan() is not used on x86 and making it compile (with
help of CONFIG_OF) will abrupt the code flow since in the middle of it
there is a BUG() instruction.

Remove the pointless function.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20221124184824.9548-1-andriy.shevchenko@linux.intel.com

---
 arch/x86/kernel/devicetree.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/x86/kernel/devicetree.c b/arch/x86/kernel/devicetree.c
index 5cd51f2..59438d2 100644
--- a/arch/x86/kernel/devicetree.c
+++ b/arch/x86/kernel/devicetree.c
@@ -31,11 +31,6 @@ char __initdata cmd_line[COMMAND_LINE_SIZE];
 
 int __initdata of_ioapic;
 
-void __init early_init_dt_add_memory_arch(u64 base, u64 size)
-{
-	BUG();
-}
-
 void __init add_dtb(u64 data)
 {
 	initial_dtb = data + offsetof(struct setup_data, data);
