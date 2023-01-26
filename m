Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B27467CE27
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 15:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232077AbjAZOcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 09:32:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232043AbjAZOcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 09:32:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE0FF8
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 06:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674743491;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=d9+hNPuB0Ep+JKeSxwD3Jyys+PWBTEAa8vxP5xKzgr0=;
        b=KM+8ZZNgF6ht9g2dCBlDLM1cKXhrpRjR8lafK83jBSeL2biaAy+DK77JlsfIM5WjZ7tWwH
        GO36q/slcf751KibSKFNMfUq6MWnBHOGba+onKIfEgQ2/o0+7FzWIZSKAh5DOSjuEb7Cou
        6qdrTkhtSw4zshbsAf+DAjPZ3MRMz5w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-564-Fu4le_8kMM6BWQn1Xq9vIw-1; Thu, 26 Jan 2023 09:31:27 -0500
X-MC-Unique: Fu4le_8kMM6BWQn1Xq9vIw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 254B0183B3C3;
        Thu, 26 Jan 2023 14:31:27 +0000 (UTC)
Received: from localhost (unknown [10.22.32.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 65F4840C2064;
        Thu, 26 Jan 2023 14:31:26 +0000 (UTC)
Date:   Thu, 26 Jan 2023 11:31:25 -0300
From:   "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        stable-rt <stable-rt@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Pavel Machek <pavel@denx.de>,
        Jeff Brady <jeffreyjbrady@gmail.com>,
        Luis Goncalves <lgoncalv@redhat.com>,
        Salvatore Bonaccorso <carnil@debian.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [ANNOUNCE] 5.10.162-rt79
Message-ID: <Y9KOvZH61omPpn/3@uudg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm pleased to announce the 5.10.162-rt79 stable release.

This release contains a single change, a fix to the aarch64 build failure
I introduced while fixing merge conflicts in 5.10.162-rt78.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.10-rt
  Head SHA1: 10ea07eb47e2f5a82c5dabba993635c73c11592f

Or to build 5.10.162-rt79 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.10.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.10.162.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.10/older/patch-5.10.162-rt79.patch.xz

Signing key fingerprint:

  9354 0649 9972 8D31 D464  D140 F394 A423 F8E6 7C26

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Luis

Changes from v5.10.162-rt78:
---

Luis Claudio R. Goncalves (1):
      Linux 5.10.162-rt79

Salvatore Bonaccorso (1):
      rt: arm64: make _TIF_WORK_MASK bits contiguous
---
arch/arm64/include/asm/thread_info.h | 12 ++++++------
 localversion-rt                      |  2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)
---
diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
index 6eb36a2126e8..2afd9ceb66c9 100644
--- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@ -70,12 +70,12 @@ void arch_release_task_struct(struct task_struct *tsk);
 #define TIF_FSCHECK		5	/* Check FS is USER_DS on return */
 #define TIF_MTE_ASYNC_FAULT	6	/* MTE Asynchronous Tag Check Fault */
 #define TIF_NOTIFY_SIGNAL	7	/* signal notifications exist */
-#define TIF_SYSCALL_TRACE	8	/* syscall trace active */
-#define TIF_SYSCALL_AUDIT	9	/* syscall auditing */
-#define TIF_SYSCALL_TRACEPOINT	10	/* syscall tracepoint for ftrace */
-#define TIF_SECCOMP		11	/* syscall secure computing */
-#define TIF_SYSCALL_EMU		12	/* syscall emulation active */
-#define TIF_NEED_RESCHED_LAZY	13
+#define TIF_NEED_RESCHED_LAZY	8
+#define TIF_SYSCALL_TRACE	9	/* syscall trace active */
+#define TIF_SYSCALL_AUDIT	10	/* syscall auditing */
+#define TIF_SYSCALL_TRACEPOINT	11	/* syscall tracepoint for ftrace */
+#define TIF_SECCOMP		12	/* syscall secure computing */
+#define TIF_SYSCALL_EMU		13	/* syscall emulation active */
 #define TIF_MEMDIE		18	/* is terminating due to OOM killer */
 #define TIF_FREEZE		19
 #define TIF_RESTORE_SIGMASK	20
diff --git a/localversion-rt b/localversion-rt
index 30758e0b2242..cf94a551bf32 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt78
+-rt79

