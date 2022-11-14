Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EDB762858C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 17:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237770AbiKNQiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 11:38:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237994AbiKNQhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 11:37:04 -0500
X-Greylist: delayed 371 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 14 Nov 2022 08:32:38 PST
Received: from mail.nearlyone.de (unknown [IPv6:2a01:4f8:1c1e:abde::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9356E528B8;
        Mon, 14 Nov 2022 08:32:38 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0CD3AE3010;
        Mon, 14 Nov 2022 17:26:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
        t=1668443184; h=from:subject:date:message-id:to:mime-version:content-type;
        bh=1StDczw4e3LuLKYoP5nni+c0NUCH5y1MWiweDne5D+Q=;
        b=ZtdlkjtG69gwkeSw71nKMsqZvkI7LA5Y1TEwQtaN5pecKqztGHj8OJV0HxGnLE93hESSwJ
        VS+eC/aI9CLQPhIVXvzL4zwkVEsCRWe3tejJCCkWkAneQAt359+Q4l5wvsCVGKIAm18veq
        8v6OKo84oShCAbdRoO9A5zgK/AOX5ODK+PTw5dAUd7XGxxsYaQhuAlneYZ9mnElmO72GUB
        H912oxT81pkKxnsJOpBgPYk5lukbgMXfItTCMiHzqZevuv/pQvG/TON17Y7lUrjOoFN9wq
        xGW64q9FFea/niDlsDLKXrGtxf87x/2DSZYsWrH3ewpmoi3uABDsaO7xTnEcdA==
Date:   Mon, 14 Nov 2022 17:26:21 +0100
From:   Daniel Wagner <wagi@monom.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Pavel Machek <pavel@denx.de>
Subject: [ANNOUNCE] 4.19.255-rt114
Message-ID: <166841697922.6047.1364424530338819464@beryllium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 4.19.255-rt114 stable release.

This update has adding few backport updates from Sebastian. Mainly
timer and workqueues. This bring the v4.19 in sync with the other -rt
stable versions.

I'll start now with the stable update so the next release will be
syncing the v4.19-rt with the latest stable v4.19 version.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.19-rt
  Head SHA1: bcecbff27cc9717eb953482a4bfc5667653cc451

Or to build 4.19.255-rt114 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.19.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.19.255.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/older/patch-4.19.255-rt114.patch.xz

Signing key fingerprint:

  5BF6 7BC5 0826 72CA BB45  ACAE 587C 5ECA 5D0A 306C

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Daniel

Changes from v4.19.255-rt113:
---

Anna-Maria Gleixner (1):
      timers: Prepare support for PREEMPT_RT

Daniel Wagner (3):
      Revert "random: Use local locks for crng context access"
      rcu: Update rcuwait
      Linux 4.19.255-rt114

Sebastian Andrzej Siewior (7):
      random: Bring back the local_locks
      local_lock: Provide INIT_LOCAL_LOCK().
      Revert "workqueue: Use local irq lock instead of irq disable regions"
      timers: Keep interrupts disabled for TIMER_IRQSAFE timer.
      timers: Don't block on ->expiry_lock for TIMER_IRQSAFE timers
      workqueue: Use rcuwait for wq_manager_wait
      timers: Don't block on ->expiry_lock for TIMER_IRQSAFE timers

Thomas Gleixner (1):
      timers: Move clearing of base::timer_running under base:: Lock
