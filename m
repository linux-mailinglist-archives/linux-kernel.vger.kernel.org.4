Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3D066C8861
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 23:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232358AbjCXWbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 18:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232326AbjCXWaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 18:30:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E0F14993
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 15:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679697002;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=vYTQiRc7lT5S/yDbJT9cft3TMm7prvMmVkxMpqnSrho=;
        b=Zz3PcsnncO6UhjH8/cPA5npEuyN4Z+wyxGTRwHavHaYxmIJT9oNWoga73b/O/wTFkiceQ3
        ncw/fQvZtR8suPKpg7PsUggt0HWwt8g/B7JM08wP0KstDn7l3HuQUoXIcbLwtmdj4Uqp11
        7gjbD6DmKSzzeMMGig6r8m4jeg9Smvk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-613-YBRI3m6PMBKhEU9FMwXwNA-1; Fri, 24 Mar 2023 18:29:58 -0400
X-MC-Unique: YBRI3m6PMBKhEU9FMwXwNA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 10EBB1C06914;
        Fri, 24 Mar 2023 22:29:58 +0000 (UTC)
Received: from localhost (unknown [10.22.32.138])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 850A0202701E;
        Fri, 24 Mar 2023 22:29:57 +0000 (UTC)
Date:   Fri, 24 Mar 2023 19:29:56 -0300
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
Subject: [ANNOUNCE] 5.10.175-rt85
Message-ID: <ZB4kZGN/1ELiLTxt@uudg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 5.10.175-rt85 stable release.

This release is an RT-only update. All the changes here are specific to RT.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.10-rt
  Head SHA1: d575c05b87320d13cbc441d7c83e2a8e291e3d59

Or to build 5.10.175-rt85 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.10.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.10.175.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.10/older/patch-5.10.175-rt85.patch.xz

Signing key fingerprint:

  9354 0649 9972 8D31 D464  D140 F394 A423 F8E6 7C26

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Luis

Changes from v5.10.175-rt84:
---

Luis Claudio R. Goncalves (1):
      Linux 5.10.175-rt85

Steffen Dirkwinkel (1):
      kernel: fork: set wake_q_sleeper.next=NULL again in dup_task_struct
---
kernel/fork.c   | 1 +
 localversion-rt | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)
---
diff --git a/kernel/fork.c b/kernel/fork.c
index c6e0d555fca9a..0c4c20eb762c3 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -949,6 +949,7 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 	tsk->splice_pipe = NULL;
 	tsk->task_frag.page = NULL;
 	tsk->wake_q.next = NULL;
+	tsk->wake_q_sleeper.next = NULL;
 	tsk->pf_io_worker = NULL;
 
 	account_kernel_stack(tsk, 1);
diff --git a/localversion-rt b/localversion-rt
index fc6ea32352bca..168858f0521be 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt84
+-rt85

