Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE7969C131
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 16:13:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjBSPNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 10:13:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjBSPNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 10:13:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 356A8B44D
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 07:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676819580;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=LNYvPdPaezRlHehHgm98L+RwXTrJbmSNw+WEXyCFNa4=;
        b=MDimgYo6gr2UtOaXZYjalJnGpOrxeHQHlItdvaWsiwYpKFmGHQvHhmqiRaJE3fGwMc8vl0
        nnDigxj6XnEbw2SH3OKVqRTobrDb/4Dvlb7yRot1WiYPTAmteHWFFFQZtIcQFKKOcYEbHU
        VjPW8j6mzEHqymMor8BhSGNO2qzaBPs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-460-U5rkwhxCOAixSnpHkOr7cw-1; Sun, 19 Feb 2023 10:12:57 -0500
X-MC-Unique: U5rkwhxCOAixSnpHkOr7cw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 709BE811E6E;
        Sun, 19 Feb 2023 15:12:56 +0000 (UTC)
Received: from localhost (unknown [10.22.8.64])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6CE2F140EBF6;
        Sun, 19 Feb 2023 15:12:55 +0000 (UTC)
Date:   Sun, 19 Feb 2023 12:12:54 -0300
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
Subject: [ANNOUNCE] 5.10.168-rt83
Message-ID: <Y/I8dgQ8Cql4BylC@uudg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 5.10.168-rt83 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.10-rt
  Head SHA1: d9e23cb3164dffbb59cd995fb652d99cb8e3bc56

Or to build 5.10.168-rt83 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.10.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.10.168.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.10/older/patch-5.10.168-rt83.patch.xz

Signing key fingerprint:

  9354 0649 9972 8D31 D464  D140 F394 A423 F8E6 7C26

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Luis

RT Changes since v5.10.165-rt81:
---

John Ogness (1):
      printk: ignore consoles without write() callback
---
 kernel/printk/printk.c                             |    6 +
 1 file changed, 6 insertions(+), 0 deletions(-)
---
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index d2205872304d..64747c72fbea 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2267,6 +2267,10 @@ static int printk_kthread_func(void *data)
 /* Must be called within console_lock(). */
 static void start_printk_kthread(struct console *con)
 {
+	/* No need to start a printing thread if the console cannot print. */
+	if (!con->write)
+		return;
+
 	con->thread = kthread_run(printk_kthread_func, con,
 				  "pr/%s%d", con->name, con->index);
 	if (IS_ERR(con->thread)) {
@@ -3566,6 +3570,8 @@ bool pr_flush(int timeout_ms, bool reset_on_progress)
 		for_each_console(con) {
 			if (!(con->flags & CON_ENABLED))
 				continue;
+			if (!con->write && !con->write_atomic)
+				continue;
 			printk_seq = atomic64_read(&con->printk_seq);
 			if (printk_seq < seq)
 				diff += seq - printk_seq;

