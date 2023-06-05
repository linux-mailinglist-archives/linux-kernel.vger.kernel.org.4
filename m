Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0386572284B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 16:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233865AbjFEOIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 10:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233120AbjFEOIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 10:08:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD000E45;
        Mon,  5 Jun 2023 07:08:14 -0700 (PDT)
Date:   Mon, 05 Jun 2023 14:08:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685974093;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NDwp2BcOopICX/IOEZYP1qc+E1yibUEvaUcQK06Ntvw=;
        b=mwTRYY/nrLDj8Xcc4IVbVKSMYKuY0yK8xVApEExWyaLAKlFeHtUxp5d08ojKRBf0hDkr8S
        l9myVwCeNJqRfR4K8/UqYzgWFb26EEBtNXecO/yMC0UMF/cV31BhU2SilkToSWg+eDDKoG
        jjGZ3rYlbv20O5bkFsECwIA7XGl32PxmPwcmU8KEF9+j2iNUm5eiGYV1Lm1Ya+70rLN6Qv
        SZzGhVQIpxiUL7QP97IaAtWZpFzhuPLkco/3tkYegIc4RPH4UMKrc3o4b5gwlDVYhfNsNS
        m15Qm7kAkONLqXhlK2jdQ81Kpv4OWlPkz1U8b+ox2PpX9XyVeufawinVwoRMng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685974093;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NDwp2BcOopICX/IOEZYP1qc+E1yibUEvaUcQK06Ntvw=;
        b=ZGmvR9SNodzx2RNVFPNMgkeXpNx+YKlvF1jUBPY5GMJsyntlQ/o0G1BxumjLMAIqKw0z8j
        udJfvLhf6lUQBiAA==
From:   "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mtrr] x86/mtrr: Remove unused code
Cc:     Juergen Gross <jgross@suse.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Michael Kelley <mikelley@microsoft.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230502120931.20719-17-jgross@suse.com>
References: <20230502120931.20719-17-jgross@suse.com>
MIME-Version: 1.0
Message-ID: <168597409311.404.9099056252144987246.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/mtrr branch of tip:

Commit-ID:     08611a3a9a23e5e2e1a799e966c69ebc4851dfa8
Gitweb:        https://git.kernel.org/tip/08611a3a9a23e5e2e1a799e966c69ebc4851dfa8
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Tue, 02 May 2023 14:09:31 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 01 Jun 2023 15:04:33 +02:00

x86/mtrr: Remove unused code

mtrr_centaur_report_mcr() isn't used by anyone, so it can be removed.

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Link: https://lore.kernel.org/r/20230502120931.20719-17-jgross@suse.com
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/include/asm/mtrr.h        |  4 ----
 arch/x86/kernel/cpu/mtrr/centaur.c |  9 ---------
 2 files changed, 13 deletions(-)

diff --git a/arch/x86/include/asm/mtrr.h b/arch/x86/include/asm/mtrr.h
index 5a758ee..090d658 100644
--- a/arch/x86/include/asm/mtrr.h
+++ b/arch/x86/include/asm/mtrr.h
@@ -69,7 +69,6 @@ extern int mtrr_add_page(unsigned long base, unsigned long size,
 			 unsigned int type, bool increment);
 extern int mtrr_del(int reg, unsigned long base, unsigned long size);
 extern int mtrr_del_page(int reg, unsigned long base, unsigned long size);
-extern void mtrr_centaur_report_mcr(int mcr, u32 lo, u32 hi);
 extern void mtrr_bp_restore(void);
 extern int mtrr_trim_uncached_memory(unsigned long end_pfn);
 extern int amd_special_default_mtrr(void);
@@ -117,9 +116,6 @@ static inline int mtrr_trim_uncached_memory(unsigned long end_pfn)
 {
 	return 0;
 }
-static inline void mtrr_centaur_report_mcr(int mcr, u32 lo, u32 hi)
-{
-}
 #define mtrr_bp_init() do {} while (0)
 #define mtrr_bp_restore() do {} while (0)
 #define mtrr_disable() do {} while (0)
diff --git a/arch/x86/kernel/cpu/mtrr/centaur.c b/arch/x86/kernel/cpu/mtrr/centaur.c
index 4466dde..6f6c3ae 100644
--- a/arch/x86/kernel/cpu/mtrr/centaur.c
+++ b/arch/x86/kernel/cpu/mtrr/centaur.c
@@ -45,15 +45,6 @@ centaur_get_free_region(unsigned long base, unsigned long size, int replace_reg)
 	return -ENOSPC;
 }
 
-/*
- * Report boot time MCR setups
- */
-void mtrr_centaur_report_mcr(int mcr, u32 lo, u32 hi)
-{
-	centaur_mcr[mcr].low = lo;
-	centaur_mcr[mcr].high = hi;
-}
-
 static void
 centaur_get_mcr(unsigned int reg, unsigned long *base,
 		unsigned long *size, mtrr_type * type)
