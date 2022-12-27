Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 731CE656ACE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 13:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbiL0MQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 07:16:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232182AbiL0MOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 07:14:41 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C1EF0A;
        Tue, 27 Dec 2022 04:13:54 -0800 (PST)
Date:   Tue, 27 Dec 2022 12:13:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1672143231;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d9wf+j6N53sovhSqAyHbXBuTU6A3y3VY5oYPwNssAEw=;
        b=CfhmefPhN/VoOcGzahWELUz6k2kvnoyaNtUBZNxGrP6ZXk6HInucRxsUQPiey4Mkl2mkEc
        nbC2ODnlyaJmT0ENHmWxAcYbVBf3WK/fQ0slG1v+N4pVnUiQYyi4mCOqbC9nahILxozyQu
        wYN7DL/80WQd/F59LKy3EriX9xTPqYWumnp2xVWMhUetMdWJixwhXMDn6RhSkUNCO4WPDb
        wl4/imlV3jAeBXdcoMjBvliIO90tFpcsI9pasPLtWPIjxmefXoYq+yxEJV1gVZwypqO1Pf
        YjqDIYxH7hHgU6ur5m8Pt+DrjUqh0A2dOXcGVhVOKBL4IGUMr1BzGkr1ckey9w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1672143231;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d9wf+j6N53sovhSqAyHbXBuTU6A3y3VY5oYPwNssAEw=;
        b=pAmT1DlAjHgsPmkI3CQ3H1Tli8Xmqn6qeZ/rGMjxmMPmMa9OKfz0mB0P/qMADrrjTUckII
        ftL4GE62liqOeGAQ==
From:   "tip-bot2 for Mathieu Desnoyers" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] selftests/rseq: Remove RSEQ_SKIP_FASTPATH code
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221122203932.231377-10-mathieu.desnoyers@efficios.com>
References: <20221122203932.231377-10-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Message-ID: <167214323135.4906.6238883610748131215.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     72cb1d7f2faca4fba81ab8417367d63852cd490c
Gitweb:        https://git.kernel.org/tip/72cb1d7f2faca4fba81ab8417367d63852cd490c
Author:        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
AuthorDate:    Tue, 22 Nov 2022 15:39:11 -05:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 27 Dec 2022 12:52:12 +01:00

selftests/rseq: Remove RSEQ_SKIP_FASTPATH code

This code is not currently build by the test Makefile, adds complexity,
and is not overall useful considering that the abort handling loops to
retry the fast-path.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20221122203932.231377-10-mathieu.desnoyers@efficios.com
---
 tools/testing/selftests/rseq/param_test.c |  4 +-
 tools/testing/selftests/rseq/rseq-arm.h   |  6 +--
 tools/testing/selftests/rseq/rseq-arm64.h |  6 +--
 tools/testing/selftests/rseq/rseq-mips.h  |  6 +--
 tools/testing/selftests/rseq/rseq-ppc.h   |  6 +--
 tools/testing/selftests/rseq/rseq-riscv.h |  6 +--
 tools/testing/selftests/rseq/rseq-s390.h  |  5 +--
 tools/testing/selftests/rseq/rseq-skip.h  | 65 +----------------------
 tools/testing/selftests/rseq/rseq-x86.h   | 12 +----
 9 files changed, 116 deletions(-)
 delete mode 100644 tools/testing/selftests/rseq/rseq-skip.h

diff --git a/tools/testing/selftests/rseq/param_test.c b/tools/testing/selftests/rseq/param_test.c
index ef29bc1..9869369 100644
--- a/tools/testing/selftests/rseq/param_test.c
+++ b/tools/testing/selftests/rseq/param_test.c
@@ -38,11 +38,7 @@ static int opt_yield, opt_signal, opt_sleep,
 		opt_disable_rseq, opt_threads = 200,
 		opt_disable_mod = 0, opt_test = 's', opt_mb = 0;
 
-#ifndef RSEQ_SKIP_FASTPATH
 static long long opt_reps = 5000;
-#else
-static long long opt_reps = 100;
-#endif
 
 static __thread __attribute__((tls_model("initial-exec")))
 unsigned int signals_delivered;
diff --git a/tools/testing/selftests/rseq/rseq-arm.h b/tools/testing/selftests/rseq/rseq-arm.h
index 893a11e..7445107 100644
--- a/tools/testing/selftests/rseq/rseq-arm.h
+++ b/tools/testing/selftests/rseq/rseq-arm.h
@@ -79,10 +79,6 @@ do {									\
 	RSEQ_WRITE_ONCE(*p, v);						\
 } while (0)
 
-#ifdef RSEQ_SKIP_FASTPATH
-#include "rseq-skip.h"
-#else /* !RSEQ_SKIP_FASTPATH */
-
 #define __RSEQ_ASM_DEFINE_TABLE(label, version, flags, start_ip,	\
 				post_commit_offset, abort_ip)		\
 		".pushsection __rseq_cs, \"aw\"\n\t"			\
@@ -823,5 +819,3 @@ error2:
 	rseq_bug("expected value comparison failed");
 #endif
 }
-
-#endif /* !RSEQ_SKIP_FASTPATH */
diff --git a/tools/testing/selftests/rseq/rseq-arm64.h b/tools/testing/selftests/rseq/rseq-arm64.h
index cbe190a..49c387f 100644
--- a/tools/testing/selftests/rseq/rseq-arm64.h
+++ b/tools/testing/selftests/rseq/rseq-arm64.h
@@ -85,10 +85,6 @@ do {										\
 	}									\
 } while (0)
 
-#ifdef RSEQ_SKIP_FASTPATH
-#include "rseq-skip.h"
-#else /* !RSEQ_SKIP_FASTPATH */
-
 #define RSEQ_ASM_TMP_REG32	"w15"
 #define RSEQ_ASM_TMP_REG	"x15"
 #define RSEQ_ASM_TMP_REG_2	"x14"
@@ -691,5 +687,3 @@ error2:
 	rseq_bug("expected value comparison failed");
 #endif
 }
-
-#endif /* !RSEQ_SKIP_FASTPATH */
diff --git a/tools/testing/selftests/rseq/rseq-mips.h b/tools/testing/selftests/rseq/rseq-mips.h
index 878739f..dd19995 100644
--- a/tools/testing/selftests/rseq/rseq-mips.h
+++ b/tools/testing/selftests/rseq/rseq-mips.h
@@ -60,10 +60,6 @@ do {									\
 	RSEQ_WRITE_ONCE(*p, v);						\
 } while (0)
 
-#ifdef RSEQ_SKIP_FASTPATH
-#include "rseq-skip.h"
-#else /* !RSEQ_SKIP_FASTPATH */
-
 #if _MIPS_SZLONG == 64
 # define LONG			".dword"
 # define LONG_LA		"dla"
@@ -773,5 +769,3 @@ error2:
 	rseq_bug("expected value comparison failed");
 #endif
 }
-
-#endif /* !RSEQ_SKIP_FASTPATH */
diff --git a/tools/testing/selftests/rseq/rseq-ppc.h b/tools/testing/selftests/rseq/rseq-ppc.h
index bab8e0b..f82d95c 100644
--- a/tools/testing/selftests/rseq/rseq-ppc.h
+++ b/tools/testing/selftests/rseq/rseq-ppc.h
@@ -36,10 +36,6 @@ do {									\
 	RSEQ_WRITE_ONCE(*p, v);						\
 } while (0)
 
-#ifdef RSEQ_SKIP_FASTPATH
-#include "rseq-skip.h"
-#else /* !RSEQ_SKIP_FASTPATH */
-
 /*
  * The __rseq_cs_ptr_array and __rseq_cs sections can be used by debuggers to
  * better handle single-stepping through the restartable critical sections.
@@ -787,5 +783,3 @@ error2:
 	rseq_bug("expected value comparison failed");
 #endif
 }
-
-#endif /* !RSEQ_SKIP_FASTPATH */
diff --git a/tools/testing/selftests/rseq/rseq-riscv.h b/tools/testing/selftests/rseq/rseq-riscv.h
index 3a391c9..b16d943 100644
--- a/tools/testing/selftests/rseq/rseq-riscv.h
+++ b/tools/testing/selftests/rseq/rseq-riscv.h
@@ -49,10 +49,6 @@ do {									\
 	RSEQ_WRITE_ONCE(*(p), v);						\
 } while (0)
 
-#ifdef RSEQ_SKIP_FASTPATH
-#include "rseq-skip.h"
-#else /* !RSEQ_SKIP_FASTPATH */
-
 #define __RSEQ_ASM_DEFINE_TABLE(label, version, flags, start_ip,	\
 				post_commit_offset, abort_ip)		\
 	".pushsection	__rseq_cs, \"aw\"\n"				\
@@ -673,5 +669,3 @@ error1:
 	rseq_bug("cpu_id comparison failed");
 #endif
 }
-
-#endif /* !RSEQ_SKIP_FASTPATH */
diff --git a/tools/testing/selftests/rseq/rseq-s390.h b/tools/testing/selftests/rseq/rseq-s390.h
index 4e6dc5f..4d32864 100644
--- a/tools/testing/selftests/rseq/rseq-s390.h
+++ b/tools/testing/selftests/rseq/rseq-s390.h
@@ -28,10 +28,6 @@ do {									\
 	RSEQ_WRITE_ONCE(*p, v);						\
 } while (0)
 
-#ifdef RSEQ_SKIP_FASTPATH
-#include "rseq-skip.h"
-#else /* !RSEQ_SKIP_FASTPATH */
-
 #ifdef __s390x__
 
 #define LONG_L			"lg"
@@ -607,4 +603,3 @@ int rseq_cmpeqv_trymemcpy_storev_release(intptr_t *v, intptr_t expect,
 	return rseq_cmpeqv_trymemcpy_storev(v, expect, dst, src, len,
 					    newv, cpu);
 }
-#endif /* !RSEQ_SKIP_FASTPATH */
diff --git a/tools/testing/selftests/rseq/rseq-skip.h b/tools/testing/selftests/rseq/rseq-skip.h
deleted file mode 100644
index 7b53dac..0000000
--- a/tools/testing/selftests/rseq/rseq-skip.h
+++ /dev/null
@@ -1,65 +0,0 @@
-/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
-/*
- * rseq-skip.h
- *
- * (C) Copyright 2017-2018 - Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
- */
-
-static inline __attribute__((always_inline))
-int rseq_cmpeqv_storev(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
-{
-	return -1;
-}
-
-static inline __attribute__((always_inline))
-int rseq_cmpnev_storeoffp_load(intptr_t *v, intptr_t expectnot,
-			       long voffp, intptr_t *load, int cpu)
-{
-	return -1;
-}
-
-static inline __attribute__((always_inline))
-int rseq_addv(intptr_t *v, intptr_t count, int cpu)
-{
-	return -1;
-}
-
-static inline __attribute__((always_inline))
-int rseq_cmpeqv_trystorev_storev(intptr_t *v, intptr_t expect,
-				 intptr_t *v2, intptr_t newv2,
-				 intptr_t newv, int cpu)
-{
-	return -1;
-}
-
-static inline __attribute__((always_inline))
-int rseq_cmpeqv_trystorev_storev_release(intptr_t *v, intptr_t expect,
-					 intptr_t *v2, intptr_t newv2,
-					 intptr_t newv, int cpu)
-{
-	return -1;
-}
-
-static inline __attribute__((always_inline))
-int rseq_cmpeqv_cmpeqv_storev(intptr_t *v, intptr_t expect,
-			      intptr_t *v2, intptr_t expect2,
-			      intptr_t newv, int cpu)
-{
-	return -1;
-}
-
-static inline __attribute__((always_inline))
-int rseq_cmpeqv_trymemcpy_storev(intptr_t *v, intptr_t expect,
-				 void *dst, void *src, size_t len,
-				 intptr_t newv, int cpu)
-{
-	return -1;
-}
-
-static inline __attribute__((always_inline))
-int rseq_cmpeqv_trymemcpy_storev_release(intptr_t *v, intptr_t expect,
-					 void *dst, void *src, size_t len,
-					 intptr_t newv, int cpu)
-{
-	return -1;
-}
diff --git a/tools/testing/selftests/rseq/rseq-x86.h b/tools/testing/selftests/rseq/rseq-x86.h
index bd01dc4..e148dfb 100644
--- a/tools/testing/selftests/rseq/rseq-x86.h
+++ b/tools/testing/selftests/rseq/rseq-x86.h
@@ -50,10 +50,6 @@ do {									\
 	RSEQ_WRITE_ONCE(*p, v);						\
 } while (0)
 
-#ifdef RSEQ_SKIP_FASTPATH
-#include "rseq-skip.h"
-#else /* !RSEQ_SKIP_FASTPATH */
-
 #define __RSEQ_ASM_DEFINE_TABLE(label, version, flags,			\
 				start_ip, post_commit_offset, abort_ip)	\
 		".pushsection __rseq_cs, \"aw\"\n\t"			\
@@ -629,8 +625,6 @@ int rseq_cmpeqv_trymemcpy_storev_release(intptr_t *v, intptr_t expect,
 					    newv, cpu);
 }
 
-#endif /* !RSEQ_SKIP_FASTPATH */
-
 #elif defined(__i386__)
 
 #define RSEQ_ASM_TP_SEGMENT	%%gs
@@ -657,10 +651,6 @@ do {									\
 	RSEQ_WRITE_ONCE(*p, v);						\
 } while (0)
 
-#ifdef RSEQ_SKIP_FASTPATH
-#include "rseq-skip.h"
-#else /* !RSEQ_SKIP_FASTPATH */
-
 /*
  * Use eax as scratch register and take memory operands as input to
  * lessen register pressure. Especially needed when compiling in O0.
@@ -1360,6 +1350,4 @@ error2:
 #endif
 }
 
-#endif /* !RSEQ_SKIP_FASTPATH */
-
 #endif
