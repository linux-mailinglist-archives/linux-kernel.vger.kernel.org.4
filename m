Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C781A6FB098
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 14:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234284AbjEHMtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 08:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbjEHMtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 08:49:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9951A31EC0;
        Mon,  8 May 2023 05:49:01 -0700 (PDT)
Date:   Mon, 08 May 2023 12:48:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683550139;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=piMYMo2Ju0wC3n0HNs0uuwqGqcw3lZpEN2IbEw9GZa8=;
        b=JGbh4E8TG5Fl6qBJuyOfdsdTCX/iozLOJ8Zgqw76KY+XD2vdPvd78+jXc2xtLZy4b8A5PB
        M0ymBt9tlJoXCUIPARjRKf41QKiXBDTExwbc1hk90SECfhxVSk/NyMU1kksIYDmOJjVuWY
        RGM3VkP89jFYIcbTga1ngVNu7FCmW2epnQ3HyZgVAhkBm4ukLpG8ukzv9yk3fjYR/zRrrt
        4Ty8peEnuwfDWRvI5vZ7bGbPAl8omf6yjqQCeDe1Mp4rxI/6aIXI+f8UjVJDBlhPukNz7F
        BDrDqxxAaxhUKGUnFfGFSpmow4cIytYb4hjiF7lKQl7Thwmfyc3insslYghGrg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683550139;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=piMYMo2Ju0wC3n0HNs0uuwqGqcw3lZpEN2IbEw9GZa8=;
        b=QJDxacT9nY03yrlG3saDGvCfQrsZyplDdDcIlcocqRD1FL0lkYkO6BYUMg1v251mcjrmAA
        9DWO8a4SaKRMisCg==
From:   "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode/AMD: Get rid of __find_equiv_id()
Cc:     "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230227160352.7260-1-bp@alien8.de>
References: <20230227160352.7260-1-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <168355013878.404.6720675388219891668.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     37a19366e10b95380bf33e7a8b02509980399d7e
Gitweb:        https://git.kernel.org/tip/37a19366e10b95380bf33e7a8b02509980399d7e
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Mon, 27 Feb 2023 17:03:52 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 08 May 2023 14:24:11 +02:00

x86/microcode/AMD: Get rid of __find_equiv_id()

Merge it into its only call site.

No functional changes.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230227160352.7260-1-bp@alien8.de
---
 arch/x86/kernel/cpu/microcode/amd.c |  9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index f5fdeb1..dd33ee8 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -596,11 +596,6 @@ void reload_ucode_amd(unsigned int cpu)
 		}
 	}
 }
-static u16 __find_equiv_id(unsigned int cpu)
-{
-	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
-	return find_equiv_id(&equiv_table, uci->cpu_sig.sig);
-}
 
 /*
  * a small, trivial cache of per-family ucode patches
@@ -651,9 +646,11 @@ static void free_cache(void)
 
 static struct ucode_patch *find_patch(unsigned int cpu)
 {
+	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
 	u16 equiv_id;
 
-	equiv_id = __find_equiv_id(cpu);
+
+	equiv_id = find_equiv_id(&equiv_table, uci->cpu_sig.sig);
 	if (!equiv_id)
 		return NULL;
 
