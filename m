Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0A69716DE8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 21:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233380AbjE3TrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 15:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233336AbjE3TrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 15:47:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC809F3
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 12:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685475994;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=+KY4BUiF/MOGCSpYc6yuZgQvcU8BMAhBhRLvP6scM8I=;
        b=TQ6paMIhLx+6pX69Nt/RM0naD1OMuhxhKJ1eS4AQrYYlD7AFaLhR3aNS/T8RH+3+O/oydK
        kSHa6hrqi4IQQ9a+DW2r3ZJe7neNnlf8aXuiZ2Tot1GGkgmNwZZSsfzNK1n9ttDn+8jzxY
        O/tnc07OZGjhMArXwhL6nMdZ+99eJAM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-558-BEpvqfrANCit7Dl09nGqLw-1; Tue, 30 May 2023 15:46:30 -0400
X-MC-Unique: BEpvqfrANCit7Dl09nGqLw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C8098185A793;
        Tue, 30 May 2023 19:46:29 +0000 (UTC)
Received: from localhost (unknown [10.22.16.189])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E8F14112132C;
        Tue, 30 May 2023 19:46:28 +0000 (UTC)
Date:   Tue, 30 May 2023 16:46:28 -0300
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
Subject: [ANNOUNCE] 5.10.180-rt88
Message-ID: <ZHZSlJFnTK1IpXeg@uudg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 5.10.180-rt88 stable release.

This release is an update to the new stable 5.10.180 version, with one
RT-specific change required to fix a build error due to the lack of
support for deferred printing in v5.10-rt.

Support for deferred printing was removed in v5.10-rc1-rt1 by commit
9153e3c5cb0c9 ("printk: remove deferred printing").

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.10-rt
  Head SHA1: 442a576e3b9afa5272c3d0a996a0d1a260f259b8

Or to build 5.10.180-rt88 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.10.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.10.180.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.10/older/patch-5.10.180-rt88.patch.xz

Signing key fingerprint:

  9354 0649 9972 8D31 D464  D140 F394 A423 F8E6 7C26

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Luis
---
 include/linux/printk.h |    4 ++--
 mm/page_alloc.c        |    2 --
 2 files changed, 2 insertions(+), 4 deletions(-)

---
diff --git a/include/linux/printk.h b/include/linux/printk.h
index 83c7734e98025..92e0656841128 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -609,7 +609,7 @@ static inline void print_hex_dump_debug(const char *prefix_str, int prefix_type,
 #define print_hex_dump_bytes(prefix_str, prefix_type, buf, len)	\
 	print_hex_dump_debug(prefix_str, prefix_type, 16, 1, buf, len, true)
 
-#ifdef CONFIG_PRINTK
+#if defined(CONFIG_PRINTK) && !defined(CONFIG_PREEMPT_RT)
 extern void __printk_safe_enter(void);
 extern void __printk_safe_exit(void);
 /*
@@ -619,7 +619,7 @@ extern void __printk_safe_exit(void);
  */
 #define printk_deferred_enter __printk_safe_enter
 #define printk_deferred_exit __printk_safe_exit
-#else
+#else /* defined(CONFIG_PRINTK) && !defined(CONFIG_PREEMPT_RT) */
 static inline void printk_deferred_enter(void)
 {
 }
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 5f1c50a6bebc5..7e65e3ef16e3a 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6057,7 +6057,6 @@ static void __build_all_zonelists(void *data)
 	 * tty_insert_flip_string_and_push_buffer() on other CPU might be
 	 * calling kmalloc(GFP_ATOMIC | __GFP_NOWARN) with port->lock held.
 	 */
-	printk_deferred_enter();
 	write_seqlock(&zonelist_update_seq);
 
 #ifdef CONFIG_NUMA
@@ -6092,7 +6091,6 @@ static void __build_all_zonelists(void *data)
 	}
 
 	write_sequnlock(&zonelist_update_seq);
-	printk_deferred_exit();
 	local_irq_restore(flags);
 }
 
-- 
2.40.1

