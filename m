Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BAA0616722
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 17:09:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbiKBQJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 12:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbiKBQJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 12:09:00 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B30272B1A5;
        Wed,  2 Nov 2022 09:08:59 -0700 (PDT)
Date:   Wed, 02 Nov 2022 16:08:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667405337;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=409bMVTBRdKa8UrKbFq/pmwOU0N/BaKvfsRkl1vzBsg=;
        b=ZVhab/tXD9XYm93nhavxM2XwjRVRRlLyQ4PurB4njZ4E+GxaSv/fPOH6r6ke4vwTRZYxT/
        9AHTCHD1FBkrPiLTY2Itx8COmgDk7UBcrkida2M2tm9wLvOpZATNM8qn34uNhU/oREr0Jm
        XBdlT+cbfMX0+nBvh/rdC3vPUTyrmVGIawCCqeHaI8AygKlA/CLpOlnuY8NfGmvbRP3GfX
        KHhoOz6g0nfLMV7KiygyddnGsgRw367puCiFLnRF4VDOWAifTunx7xz64ZNn1VxfUU1iqU
        idNzXyV4bPCRRUNqcmcNIjv3rHLWAXdBsY6b+meNNg6AW2RP7MaGqgpmbS5MLw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667405337;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=409bMVTBRdKa8UrKbFq/pmwOU0N/BaKvfsRkl1vzBsg=;
        b=PYW5/+4huF+SC7HV+QqyWwUQWNS6Kh1xDCcrYa8PzrHi6OCkkI/HJcl+uidNncKocBwsg2
        NVyluJ2+r1TUAeCQ==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode: Drop struct ucode_cpu_info.valid
Cc:     Borislav Petkov <bp@suse.de>, Ashok Raj <ashok.raj@intel.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20221028142638.28498-6-bp@alien8.de>
References: <20221028142638.28498-6-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <166740533523.6127.10746142712096251030.tip-bot2@tip-bot2>
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

Commit-ID:     254ed7cf4dd79a18bbc496ab53f6c82d45431c78
Gitweb:        https://git.kernel.org/tip/254ed7cf4dd79a18bbc496ab53f6c82d45431c78
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Wed, 19 Oct 2022 19:25:27 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 02 Nov 2022 16:45:46 +01:00

x86/microcode: Drop struct ucode_cpu_info.valid

It is not needed anymore.

Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
Link: https://lore.kernel.org/r/20221028142638.28498-6-bp@alien8.de
---
 arch/x86/include/asm/microcode.h     | 1 -
 arch/x86/kernel/cpu/intel.c          | 1 -
 arch/x86/kernel/cpu/microcode/core.c | 4 ++--
 3 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/microcode.h b/arch/x86/include/asm/microcode.h
index d4c36fb..d5a58bd 100644
--- a/arch/x86/include/asm/microcode.h
+++ b/arch/x86/include/asm/microcode.h
@@ -49,7 +49,6 @@ struct microcode_ops {
 
 struct ucode_cpu_info {
 	struct cpu_signature	cpu_sig;
-	int			valid;
 	void			*mc;
 };
 extern struct ucode_cpu_info ucode_cpu_info[];
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 2d7ea54..beb8ca5 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -210,7 +210,6 @@ int intel_cpu_collect_info(struct ucode_cpu_info *uci)
 	csig.rev = intel_get_microcode_revision();
 
 	uci->cpu_sig = csig;
-	uci->valid = 1;
 
 	return 0;
 }
diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index ffb249c..712aaff 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -554,9 +554,9 @@ void microcode_bsp_resume(void)
 	int cpu = smp_processor_id();
 	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
 
-	if (uci->valid && uci->mc)
+	if (uci->mc)
 		microcode_ops->apply_microcode(cpu);
-	else if (!uci->mc)
+	else
 		reload_early_microcode();
 }
 
