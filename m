Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C359616724
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 17:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbiKBQJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 12:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbiKBQJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 12:09:00 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B33AF2B1AF;
        Wed,  2 Nov 2022 09:08:59 -0700 (PDT)
Date:   Wed, 02 Nov 2022 16:08:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667405338;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LzyPUVrEzCbCHNapHCCi0qzQz5vi1Sk/EGn2ob3J6q0=;
        b=Hw6RwmizLVhtNNvU8pc8K87L+aEpEOL+e/EweZlqkeyGkk1KP6779wtYcp/I0/AAQ6CtfA
        S6I/98dHxDzIRCubsD557i83be4EWErn6SbRhjj09mqDG96HfNQS/mtoT1/ro2ZyX17Sps
        6EAHl53m4A4ep0wJys9r8gHpXkqyvPMvCNjZa3V0ninXw0MsZn59h9LBNqK0UQaa/Ld7Ll
        GmcGus9zc104iB1uz2eDNqvZm1BNlKY5cfO144uWZdHvSUI66b63Ag3FbKjrH8DaiHtuJc
        8fLwgRXBSOHLy2De6FMn9sj3PFjEh6Mf2jvNjvUgh8h2GdhbK9zk4oO/0Df7VQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667405338;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LzyPUVrEzCbCHNapHCCi0qzQz5vi1Sk/EGn2ob3J6q0=;
        b=aaScXHtWuhOYYm7b4Hg4fdxU15QmHkkm0fA+19MKUDJrH3x+ZScfi2eNQ3mqQawTda+2ji
        MA+iiEJDclyHEtBA==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode: Do some minor fixups
Cc:     Borislav Petkov <bp@suse.de>, Ashok Raj <ashok.raj@intel.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20221028142638.28498-5-bp@alien8.de>
References: <20221028142638.28498-5-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <166740533709.6127.11493980524508136910.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     2e6ff4052d89ff9eeaddece14ba88c40bf8b2721
Gitweb:        https://git.kernel.org/tip/2e6ff4052d89ff9eeaddece14ba88c40bf8b2721
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Wed, 19 Oct 2022 19:20:47 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 02 Nov 2022 16:45:46 +01:00

x86/microcode: Do some minor fixups

Improve debugging printks and fixup formatting.

Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
Link: https://lore.kernel.org/r/20221028142638.28498-5-bp@alien8.de
---
 arch/x86/kernel/cpu/microcode/core.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 7c41e01..ffb249c 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -568,6 +568,8 @@ static int mc_cpu_starting(unsigned int cpu)
 {
 	enum ucode_state err = microcode_ops->apply_microcode(cpu);
 
+	pr_debug("%s: CPU%d, err: %d\n", __func__, cpu, err);
+
 	return err == UCODE_ERROR;
 }
 
@@ -590,7 +592,7 @@ static int mc_cpu_down_prep(unsigned int cpu)
 
 	/* Suspend is in progress, only remove the interface */
 	sysfs_remove_group(&dev->kobj, &mc_attr_group);
-	pr_debug("CPU%d removed\n", cpu);
+	pr_debug("%s: CPU%d\n", __func__, cpu);
 
 	return 0;
 }
@@ -639,14 +641,11 @@ static int __init microcode_init(void)
 	if (!microcode_ops)
 		return -ENODEV;
 
-	microcode_pdev = platform_device_register_simple("microcode", -1,
-							 NULL, 0);
+	microcode_pdev = platform_device_register_simple("microcode", -1, NULL, 0);
 	if (IS_ERR(microcode_pdev))
 		return PTR_ERR(microcode_pdev);
 
-	error = sysfs_create_group(&cpu_subsys.dev_root->kobj,
-				   &cpu_root_microcode_group);
-
+	error = sysfs_create_group(&cpu_subsys.dev_root->kobj, &cpu_root_microcode_group);
 	if (error) {
 		pr_err("Error creating microcode group!\n");
 		goto out_pdev;
