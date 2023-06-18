Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E16E17348BB
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 23:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjFRVwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 17:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjFRVwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 17:52:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89BC7113
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 14:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687125119;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=wZLdjHcab2BcEUayDGFasfyZtj2UYXOAR0yUXAOl+LM=;
        b=EwRF4DsW7rKDoSMT1DjDdC3WnF91zmdB0JMvADBy8lbJoDhJ9N0xFFgzlaIDi95EMhgJH9
        OxiX2xXdqbKwY7Ovq3+/O9nAo6Nx65ZnxQeaViYZk7yke42buAgHXtZnmKserSae18DXYQ
        wG8QYO+fo7Da9/ScZNx6ttJ4PETLf2Y=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-300-2SUG0_mZO4qACebW0T-EiA-1; Sun, 18 Jun 2023 17:51:55 -0400
X-MC-Unique: 2SUG0_mZO4qACebW0T-EiA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 83B7338035A6;
        Sun, 18 Jun 2023 21:51:54 +0000 (UTC)
Received: from localhost (unknown [10.22.8.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A75D9C1603B;
        Sun, 18 Jun 2023 21:51:53 +0000 (UTC)
Date:   Sun, 18 Jun 2023 18:51:52 -0300
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
        Luis Goncalves <lgoncalv@redhat.com>
Subject: [ANNOUNCE] 5.10.180-rt89
Message-ID: <ZI98eLwx3ykPh2d9@uudg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 5.10.180-rt89 stable release.

This release is a RT-only update. All the changes here are specific to RT.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.10-rt
  Head SHA1: cb0ca150b57efd9e879e56c8f9834d98182aa394

Or to build 5.10.180-rt89 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.10.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.10.180.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.10/older/patch-5.10.180-rt89.patch.xz

Signing key fingerprint:

  9354 0649 9972 8D31 D464  D140 F394 A423 F8E6 7C26

All keys used for the above files and repositories can be found on the
following git repository:

  git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Testing performed under the tag v5.10.180-rt89-rc1 at:

  https://linux.kernelci.org/test/job/rt-stable/branch/v5.10-rt-next/kernel/v5.10.180-rt89-rc1/

Enjoy!
Luis

Changes from v5.10.180-rt88:
---

Luis Claudio R. Goncalves (3):
      Revert "printk: declare printk_deferred_{enter,safe}() in include/linux/printk.h"
      Revert "mm/page_alloc: fix potential deadlock on zonelist_update_seqseqlock"
      Linux 5.10.180-rt89
---
include/linux/printk.h | 19 -------------------
 localversion-rt        |  2 +-
 mm/page_alloc.c        | 14 --------------
 3 files changed, 1 insertion(+), 34 deletions(-)
---
diff --git a/include/linux/printk.h b/include/linux/printk.h
index 92e0656841128..7e4352467d831 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -609,23 +609,4 @@ static inline void print_hex_dump_debug(const char *prefix_str, int prefix_type,
 #define print_hex_dump_bytes(prefix_str, prefix_type, buf, len)	\
 	print_hex_dump_debug(prefix_str, prefix_type, 16, 1, buf, len, true)
 
-#if defined(CONFIG_PRINTK) && !defined(CONFIG_PREEMPT_RT)
-extern void __printk_safe_enter(void);
-extern void __printk_safe_exit(void);
-/*
- * The printk_deferred_enter/exit macros are available only as a hack for
- * some code paths that need to defer all printk console printing. Interrupts
- * must be disabled for the deferred duration.
- */
-#define printk_deferred_enter __printk_safe_enter
-#define printk_deferred_exit __printk_safe_exit
-#else /* defined(CONFIG_PRINTK) && !defined(CONFIG_PREEMPT_RT) */
-static inline void printk_deferred_enter(void)
-{
-}
-static inline void printk_deferred_exit(void)
-{
-}
-#endif
-
 #endif
diff --git a/localversion-rt b/localversion-rt
index 666227d921a3d..d2a40223e4b77 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt88
+-rt89
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 7e65e3ef16e3a..3760a06932a6e 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6043,20 +6043,7 @@ static void __build_all_zonelists(void *data)
 	int nid;
 	int __maybe_unused cpu;
 	pg_data_t *self = data;
-	unsigned long flags;
 
-	/*
-	 * Explicitly disable this CPU's interrupts before taking seqlock
-	 * to prevent any IRQ handler from calling into the page allocator
-	 * (e.g. GFP_ATOMIC) that could hit zonelist_iter_begin and livelock.
-	 */
-	local_irq_save(flags);
-	/*
-	 * Explicitly disable this CPU's synchronous printk() before taking
-	 * seqlock to prevent any printk() from trying to hold port->lock, for
-	 * tty_insert_flip_string_and_push_buffer() on other CPU might be
-	 * calling kmalloc(GFP_ATOMIC | __GFP_NOWARN) with port->lock held.
-	 */
 	write_seqlock(&zonelist_update_seq);
 
 #ifdef CONFIG_NUMA
@@ -6091,7 +6078,6 @@ static void __build_all_zonelists(void *data)
 	}
 
 	write_sequnlock(&zonelist_update_seq);
-	local_irq_restore(flags);
 }
 
 static noinline void __init

