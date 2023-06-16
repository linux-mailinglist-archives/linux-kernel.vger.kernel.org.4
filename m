Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED5A733452
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 17:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344061AbjFPPI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 11:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345884AbjFPPIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 11:08:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6208430EB;
        Fri, 16 Jun 2023 08:08:43 -0700 (PDT)
Date:   Fri, 16 Jun 2023 15:08:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686928121;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iXB+cKgSU3o8/scNiCQIc4BV8pTRs/x28lCF92PTRuI=;
        b=a1hwy88DZhY5VM9TtZDohFeAJDSX/qYnJBLu4TS6QqhaBCwujBrfeflQJ0OBv75j26pt0R
        DbhMNwrj5tJ/CsqpSrLLFpi12D2xrwBR/kqoIGrBGnJV5ICuRaAyQ+ut3iTM2u/u+c41/B
        N6E+H02SuNrEcsdlzvFWiHaqa+zWJNWCuLcfYlbUBUK7fzH89ilwi3kb5UAkDmz4qPxl9Z
        fSytWBwsKb8POgQ6kHSQ1G+c1Pe8eRUQSA8bG2Ph5m8c6H+AcOMU9n/nNmDjfp+0uD6PnT
        AnyCJIG1qt3qh7hMTF0yYU2CVKqCAX4RuXkq2XkX5dpzWpqnh/eTByFRlDiQaw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686928121;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iXB+cKgSU3o8/scNiCQIc4BV8pTRs/x28lCF92PTRuI=;
        b=ZTeS2yGYvb4CeOJw9XsXEzHIQWBNOVz+Nz73uhPwi/MUlErht4Ry7mXYKio024kVoe19RH
        yUMVCgwevTTF4mCg==
From:   "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/core: Drop __weak attribute from
 arch_perf_update_userpage() prototype
Cc:     Reiji Watanabe <reijiw@google.com>, Marc Zyngier <maz@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230616114831.3186980-1-maz@kernel.org>
References: <20230616114831.3186980-1-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <168692812141.404.12009878705497041085.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     b50f26a44887f3f71ff5457135ee1d5f1d542d7d
Gitweb:        https://git.kernel.org/tip/b50f26a44887f3f71ff5457135ee1d5f1d542d7d
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Fri, 16 Jun 2023 12:48:31 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 16 Jun 2023 16:46:33 +02:00

perf/core: Drop __weak attribute from arch_perf_update_userpage() prototype

Reiji reports that the arm64 implementation of arch_perf_update_userpage()
is now ignored and replaced by the dummy stub in core code.
This seems to happen since the PMUv3 driver was moved to driver/perf.

As it turns out, dropping the __weak attribute from the *prototype*
of the function solves the problem. You're right, this doesn't seem
to make much sense. And yet... It appears that both symbols get
flagged as weak, and that the first one to appear in the link order
wins:

$ nm drivers/perf/arm_pmuv3.o|grep arch_perf_update_userpage
0000000000001db0 W arch_perf_update_userpage

Dropping the attribute from the prototype restores the expected
behaviour, and arm64 is able to enjoy arch_perf_update_userpage()
again.

Fixes: 7755cec63ade ("arm64: perf: Move PMUv3 driver to drivers/perf")
Fixes: f1ec3a517b43 ("kernel/events: Add a missing prototype for arch_perf_update_userpage()")
Reported-by: Reiji Watanabe <reijiw@google.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Reiji Watanabe <reijiw@google.com>
Link: https://lkml.kernel.org/r/20230616114831.3186980-1-maz@kernel.org
---
 include/linux/perf_event.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index d5628a7..c8dcfdb 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1845,9 +1845,9 @@ int perf_event_exit_cpu(unsigned int cpu);
 #define perf_event_exit_cpu	NULL
 #endif
 
-extern void __weak arch_perf_update_userpage(struct perf_event *event,
-					     struct perf_event_mmap_page *userpg,
-					     u64 now);
+extern void arch_perf_update_userpage(struct perf_event *event,
+				      struct perf_event_mmap_page *userpg,
+				      u64 now);
 
 #ifdef CONFIG_MMU
 extern __weak u64 arch_perf_get_page_size(struct mm_struct *mm, unsigned long addr);
