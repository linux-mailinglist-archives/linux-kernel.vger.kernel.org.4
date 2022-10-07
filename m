Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83FE45F7514
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 10:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiJGIMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 04:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiJGIMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 04:12:18 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F63EB7EF
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 01:12:16 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id g27so5935808edf.11
        for <linux-kernel@vger.kernel.org>; Fri, 07 Oct 2022 01:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date;
        bh=VnNgu+hE8PsW+yKe6IHZxCkDujLir7iOtOEaKE5mb8U=;
        b=VfwkgdSNh2jDSlXQwQUzjlDsU9szl77zSynXKwBrXOxnSmUkfTd9cugWF94rRWScMg
         Ohkutvc5DNhzb7RQHWtMJJ9tjuNrAhKETtN+iqxXBI4axk9n3YPHxh5Xup6s6o9i/3Xd
         9St8Uoln8uPj+bkh26NkOrsRq4I1AV2yqimjm1czQoeTiIy1kfEQecZ029F0mEanUquJ
         JVnp4YHr/75GV/idBCUImUqhlMg46bePhHice6UhRX3mvigU1CXYbsYbd46+tlgVAvGr
         Ze0nn1hQarwdMfOybUUE1rZjBnVddMGmH6m5eJxwXXmOG2Gu48sv2j8xPjiI9vGDfYda
         pUJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date;
        bh=VnNgu+hE8PsW+yKe6IHZxCkDujLir7iOtOEaKE5mb8U=;
        b=Nd+6SfFC0gcVfhu8MqZKpNhrvUqxZxg7olYTAit8mj2qf7Q6HnWItfNJrjLninKh/u
         p6axkJsoCONVeqiRbp8njQrPmJOsx4zAEBFB6yenMyO+zDRI199eJl28ejAK5IhE+fHD
         68ShqblS/QQb4UZ2eUKZPGhZmBPNrxc+IoqTWTOCnF8P0F9cNt5rg733Rr4KiA+w50O6
         kmfrkFUH6+tZuC+Sw7PwDJLQlvAXF/0/wjuHz4XmXpaojmZbWq1VeJk0f5Z+bIkpNDTc
         Cw933jWk80XK/NZLh2RwSqzfHfB8t3QNX0JHfl/+uoTutRIeUtPZrqOUaBaj3IaPmi+7
         GRAw==
X-Gm-Message-State: ACrzQf3Sd7HvGvFi+47lafJ0xCDFYRp0OJhX5KbHJ8/lo0W7uETpUFiA
        Tk69Rb6G6tw7Vs14GApKoZs=
X-Google-Smtp-Source: AMsMyM6bApttZGWI/W5GnP1vqYFrDHvihr57WfC/qCFDXXPw4FQlBgtado62MrKVgpXdtQ5TZT6B9w==
X-Received: by 2002:a05:6402:170f:b0:458:9653:6466 with SMTP id y15-20020a056402170f00b0045896536466mr3412212edu.181.1665130335283;
        Fri, 07 Oct 2022 01:12:15 -0700 (PDT)
Received: from gmail.com (1F2EF191.nat.pool.telekom.hu. [31.46.241.145])
        by smtp.gmail.com with ESMTPSA id z25-20020aa7cf99000000b0044e9601e53fsm981075edx.19.2022.10.07.01.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 01:12:14 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Fri, 7 Oct 2022 10:12:13 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [GIT PULL] locking changes for v6.1
Message-ID: <Yz/fXafXBApgFQrF@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest locking/core git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-core-2022-10-07

   # HEAD: 76e64c73db9542ff4bae8a60f4f32e38f3799b95 locking/lockdep: Print more debug information - report name and key when look_up_lock_class() got confused

Locking changes for v6.1:

 - Disable preemption in rwsem_write_trylock()'s attempt to
   take the rwsem, to avoid RT tasks hogging the CPU, which
   managed to preempt this function after the owner has
   been cleared but before a new owner is set. Also add
   debug checks to enforce this.

 - Add __lockfunc to more slow path functions and add
   __sched to semaphore functions.

 - Mark spinlock APIs noinline when the respective CONFIG_INLINE_SPIN_*
   toggles are disabled, to reduce LTO text size.

 - Print more debug information when lockdep gets confused
   in look_up_lock_class().

 - Improve header file abuse checks.

 - Misc cleanups

 Thanks,

	Ingo

------------------>
Andi Kleen (1):
      locking/spinlocks: Mark spinlocks noinline when inline spinlocks are disabled

Gokul krishna Krishnakumar (1):
      locking/rwsem: Disable preemption while trying for rwsem lock

Namhyung Kim (2):
      locking: Add __lockfunc to slow path functions
      locking: Add __sched to semaphore functions

Sebastian Andrzej Siewior (1):
      locking: Detect includes rwlock.h outside of spinlock.h

Slark Xiao (1):
      selftests: futex: Fix 'the the' typo in comment

Tetsuo Handa (1):
      locking/lockdep: Print more debug information - report name and key when look_up_lock_class() got confused


 arch/x86/include/asm/qspinlock_paravirt.h          | 13 ++---
 include/linux/rwlock.h                             |  2 +-
 include/linux/spinlock.h                           |  2 +
 include/linux/spinlock_api_smp.h                   |  2 +-
 include/linux/spinlock_api_up.h                    |  2 +-
 include/linux/spinlock_rt.h                        |  2 +-
 include/linux/spinlock_up.h                        |  2 +-
 kernel/locking/lockdep.c                           |  6 ++-
 kernel/locking/qrwlock.c                           |  4 +-
 kernel/locking/qspinlock.c                         |  2 +-
 kernel/locking/qspinlock_paravirt.h                |  4 +-
 kernel/locking/rwsem.c                             | 14 +++++-
 kernel/locking/semaphore.c                         | 12 ++---
 kernel/locking/spinlock.c                          | 56 +++++++++++-----------
 .../functional/futex_requeue_pi_signal_restart.c   |  2 +-
 15 files changed, 70 insertions(+), 55 deletions(-)
