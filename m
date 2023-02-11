Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A739B692FDC
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 11:01:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjBKKBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 05:01:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjBKKBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 05:01:49 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D6B44B9;
        Sat, 11 Feb 2023 02:01:46 -0800 (PST)
Date:   Sat, 11 Feb 2023 10:01:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676109705;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S+Yy/q6QlfXSRC00fKt7wXcSKaBvC41G2L+bQ8VlbZ4=;
        b=GKzmfLZUb2F17S7CwnVqf9dZ6kDg66642BnU/3mAfhTwnisJFHV437B5Ep4z45CMXhqvsS
        ReR1Devo3vBNMeDBU1AaTig6Z/gAot+H3FhEpIBSG1n94l/ethUPzjz5yrwUsE+N8VsVAh
        uWXM/d9XAm6tGXJycXdKBB13dCwseU8cqSG9cgtivqVG/Y+TJjwg09QkQD479YqpuxucNU
        CaQX+cppuEN/3+vMPb7xwb3B7/M4LdWwWP3da74b52FNAC1W2kTTIJ3tL2zcmqMruQ4Bkl
        6h+30SBaGm1IZNIKs1p+FKZOyW475/XqVxcKsWuBmMzxjuyDdqirnOsjgQMAGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676109705;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S+Yy/q6QlfXSRC00fKt7wXcSKaBvC41G2L+bQ8VlbZ4=;
        b=dwUisN94oDzHOCtgnql3e34IZuI1WfXZswrSjhzVsH3jS9kwR+plZEBKGFZ6cRV0643rDN
        ijSGa72ZJviyIVBQ==
From:   "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/cacheinfo: Remove unused trace variable
Cc:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230210234541.9694-1-bp@alien8.de>
References: <20230210234541.9694-1-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <167610970497.4906.9484310857519512123.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     851026a2bf54e739a2e13723bf3c4513f3cbcdc9
Gitweb:        https://git.kernel.org/tip/851026a2bf54e739a2e13723bf3c4513f3cbcdc9
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Sat, 11 Feb 2023 00:45:41 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Sat, 11 Feb 2023 10:43:31 +01:00

x86/cacheinfo: Remove unused trace variable

15cd8812ab2c ("x86: Remove the CPU cache size printk's") removed the
last use of the trace local var. Remove it too and the useless trace
cache case.

No functional changes.

Reported-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230210234541.9694-1-bp@alien8.de
Link: http://lore.kernel.org/r/20220705073349.1512-1-jiapeng.chong@linux.alibaba.com
---
 arch/x86/kernel/cpu/cacheinfo.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index f4e5aa2..4063e89 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -734,7 +734,7 @@ void init_hygon_cacheinfo(struct cpuinfo_x86 *c)
 void init_intel_cacheinfo(struct cpuinfo_x86 *c)
 {
 	/* Cache sizes */
-	unsigned int trace = 0, l1i = 0, l1d = 0, l2 = 0, l3 = 0;
+	unsigned int l1i = 0, l1d = 0, l2 = 0, l3 = 0;
 	unsigned int new_l1d = 0, new_l1i = 0; /* Cache sizes from cpuid(4) */
 	unsigned int new_l2 = 0, new_l3 = 0, i; /* Cache sizes from cpuid(4) */
 	unsigned int l2_id = 0, l3_id = 0, num_threads_sharing, index_msb;
@@ -835,9 +835,6 @@ void init_intel_cacheinfo(struct cpuinfo_x86 *c)
 						case LVL_3:
 							l3 += cache_table[k].size;
 							break;
-						case LVL_TRACE:
-							trace += cache_table[k].size;
-							break;
 						}
 
 						break;
