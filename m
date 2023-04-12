Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F84B6DF8A3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 16:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231653AbjDLOfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 10:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbjDLOfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 10:35:41 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B2293CD
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 07:35:15 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id u4so7674362qvj.10
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 07:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1681310113;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pha/CGTxASjKhJeF/WUk5bsRIts9NaxH9VPPQI0EN78=;
        b=B8sJHKWhFw5o1rDFmXc4bIV2JKw2Snc8nYR9FnFGTdE0RY0jCBWBOguQZ0742bY06I
         3/Ip9ADLx1t40u+RBH2tjeGJCyOii3ffWZ8y7LVeG6oRG1ryj73P26zlIlVOSrNfTz0v
         +0ggR+i8qd6VgxK+jNkpARyl85k7hDNs5qJak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681310113;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pha/CGTxASjKhJeF/WUk5bsRIts9NaxH9VPPQI0EN78=;
        b=vciMUoX4E1ecw1ClkLPGyaLNN1lsNqk50ut55Q7D6GTbd7hRpFSvfVFXP0ERJPLliZ
         EoJX8cWjgnyBE7e8HOAqh0jJrY5MZsG0TXRc9RXA9abtAhAN8B4akm6WcfL6qZ3O/NS6
         84jUJH845upi5WCoiRTDAmAVf9JjYegRE0xs9+nl62wddOPRGTkeFiiHkIbRSJYmSaLO
         WoNPDP7nKi7fwn1NoC4Qo0xww4VNO2dzyOi/X6ZCsz1Z3Nnw61rDHPRrHf5M1YHQzeLC
         bLVR4154qNU6EoV3uUgt56qozs+Jiel4wAH8M9GH2lK9ABxgTGyoVX2iGKGZY3Gkl3Te
         YCAg==
X-Gm-Message-State: AAQBX9fB/SMmBKU2IswaXS40tZxs+CuVk8SNCwprQwc1v2PJyewxvkRC
        SvZIS/tps39x67D8dKaX8eN+ow==
X-Google-Smtp-Source: AKy350YQuhhN5PcByvEcGXji47gE3gsHjXIAun+Dh0NM9xmaPd+Wc5FopRp4tovqx+g0I5pXzD6osg==
X-Received: by 2002:ad4:574b:0:b0:5ef:519:b06 with SMTP id q11-20020ad4574b000000b005ef05190b06mr6902414qvx.29.1681310113313;
        Wed, 12 Apr 2023 07:35:13 -0700 (PDT)
Received: from localhost (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id x4-20020a0cfe04000000b005dd8b9345bcsm2923346qvr.84.2023.04.12.07.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 07:35:12 -0700 (PDT)
Date:   Wed, 12 Apr 2023 14:35:12 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        mingo@kernel.org, tglx@linutronix.de, rcu@vger.kernel.org,
        joel@joelfernandes.org, boqun.feng@gmail.com, frederic@kernel.org,
        quic_neeraju@quicinc.com, urezki@gmail.com, qiang1.zhang@intel.com,
        rostedt@goodmis.org
Subject: [GIT PULL] RCU changes for v6.4
Message-ID: <20230412143512.GA1697547@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Linus,

The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:

  Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git tags/rcu.6.4.april5.2023.3

for you to fetch changes up to 8ae99857748bece993962dd8d04e096f9e76731f:

  Merge branches 'rcu/staging-core', 'rcu/staging-docs' and 'rcu/staging-kfree', remote-tracking branches 'paul/srcu-cf.2023.04.04a', 'fbq/rcu/lockdep.2023.03.27a' and 'fbq/rcu/rcutorture.2023.03.20a' into rcu/staging (2023-04-05 13:50:37 +0000)

Highlights of RCU changes for 6.4 include:

1. Updates and additions to MAINTAINERS files, with Boqun being added to the
   RCU entry and Zqiang being added as an RCU reviewer. I have also
   transitioned from reviewer to maintainer; however, Paul will be taking
   over sending RCU pull-requests for the next merge window.

2. Resolution of hotplug warning in nohz code, achieved by fixing
   cpu_is_hotpluggable() through interaction with the nohz subsystem.
   Tick dependency modifications by Zqiang, focusing on fixing usage of the
   TICK_DEP_BIT_RCU_EXP bitmask.

3. Avoid needless calls to the rcu-lazy shrinker for CONFIG_RCU_LAZY=n kernels,
   fixed by Zqiang.

4. Improvements to rcu-tasks stall reporting by Neeraj.

5. Initial renaming of k[v]free_rcu() to k[v]free_rcu_mightsleep() for
   increased robustness, affecting several components like mac802154, drbd,
   vmw_vmci, tracing, and more. A report [1] by Eric Dumazet showed that the
   API could be unknowingly used in an atomic context, so we'd rather make
   sure they know what they're asking for by being explicit:
   [1] https://lore.kernel.org/all/20221202052847.2623997-1-edumazet@google.com/

6. Documentation updates, including corrections to spelling, clarifications
   in comments, and improvements to the srcu_size_state comments.

7. Better srcu_struct cache locality for readers, by adjusting the size of
   srcu_struct in support of SRCU usage by Christoph Hellwig.

8. Teach lockdep to detect deadlocks between srcu_read_lock() vs
   synchronize_srcu() contributed by Boqun. Previously lockdep could not
   detect such deadlocks, now it can.

9. Integration of rcutorture and rcu-related tools, targeted for v6.4 from
   Boqun's tree, featuring new SRCU deadlock scenarios, test_nmis module
   parameter, and more.

10. Miscellaneous changes, various code cleanups and comment improvements.

Thank you for considering these RCU updates for the 6.4 release.

----------------------------------------------------------------
Bhaskar Chowdhury (1):
      tools: rcu: Add usage function and check for argument

Boqun Feng (5):
      locking/lockdep: Introduce lock_sync()
      rcu: Annotate SRCU's update-side lockdep dependencies
      locking: Reduce the number of locks in ww_mutex stress tests
      locking/lockdep: Improve the deadlock scenario print for sync and read lock
      MAINTAINERS: Add Boqun to RCU entry

Frederic Weisbecker (1):
      rcu: Further comment and explain the state space of GP sequences

Joel Fernandes (Google) (7):
      srcu: Clarify comments on memory barrier "E"
      MAINTAINERS: Change Joel Fernandes from R: to M:
      MAINTAINERS: Add Zqiang as a RCU reviewer
      tick/nohz: Fix cpu_is_hotpluggable() by checking with nohz subsystem
      mac802154: Rename kfree_rcu() to kvfree_rcu_mightsleep()
      checkpatch: Error out if deprecated RCU API used
      Merge branches 'rcu/staging-core', 'rcu/staging-docs' and 'rcu/staging-kfree', remote-tracking branches 'paul/srcu-cf.2023.04.04a', 'fbq/rcu/lockdep.2023.03.27a' and 'fbq/rcu/rcutorture.2023.03.20a' into rcu/staging

Neeraj Upadhyay (1):
      rcu-tasks: Report stalls during synchronize_srcu() in rcu_tasks_postscan()

Paul E. McKenney (35):
      rcutorture: Add test_nmis module parameter
      rcutorture: Set CONFIG_BOOTPARAM_HOTPLUG_CPU0 to offline CPU 0
      rcutorture: Make scenario TREE04 enable lazy call_rcu()
      torture: Permit kvm-again.sh --duration to default to previous run
      torture: Enable clocksource watchdog with "tsc=watchdog"
      rcuscale: Move shutdown from wait_event() to wait_event_idle()
      refscale: Move shutdown from wait_event() to wait_event_idle()
      rcutorture: Add SRCU deadlock scenarios
      rcutorture: Add RCU Tasks Trace and SRCU deadlock scenarios
      rcutorture: Add srcu_lockdep.sh
      rcu-tasks: Fix warning for unused tasks_rcu_exit_srcu
      srcu: Add whitespace to __SRCU_STRUCT_INIT() & __DEFINE_SRCU()
      srcu: Use static init for statically allocated in-module srcu_struct
      srcu: Begin offloading srcu_struct fields to srcu_update
      srcu: Move ->level from srcu_struct to srcu_usage
      srcu: Move ->srcu_size_state from srcu_struct to srcu_usage
      srcu: Move ->srcu_cb_mutex from srcu_struct to srcu_usage
      srcu: Move ->lock initialization after srcu_usage allocation
      srcu: Move ->lock from srcu_struct to srcu_usage
      srcu: Move ->srcu_gp_mutex from srcu_struct to srcu_usage
      srcu: Move grace-period fields from srcu_struct to srcu_usage
      srcu: Move heuristics fields from srcu_struct to srcu_usage
      srcu: Move ->sda_is_static from srcu_struct to srcu_usage
      srcu: Move srcu_barrier() fields from srcu_struct to srcu_usage
      srcu: Move work-scheduling fields from srcu_struct to srcu_usage
      srcu: Check for readers at module-exit time
      srcu: Fix long lines in srcu_get_delay()
      srcu: Fix long lines in cleanup_srcu_struct()
      srcu: Fix long lines in srcu_gp_end()
      srcu: Fix long lines in srcu_funnel_gp_start()
      rcu: Add comment to rcu_do_batch() identifying rcuoc code path
      rcu: Remove CONFIG_SRCU
      mm: Remove "select SRCU"
      kvm: Remove "select SRCU"
      arch/x86: Remove "select SRCU"

Pingfan Liu (1):
      srcu: Add comments for srcu_size_state

Qiuxu Zhuo (1):
      Documentation/RCU: s/not/note/ in checklist.rst

Randy Dunlap (1):
      Documentation: RCU: Correct spelling

Uladzislau Rezki (Sony) (9):
      doc: Update whatisRCU.rst
      drbd: Rename kvfree_rcu() to kvfree_rcu_mightsleep()
      misc: vmw_vmci: Rename kvfree_rcu() to kvfree_rcu_mightsleep()
      tracing: Rename kvfree_rcu() to kvfree_rcu_mightsleep()
      lib/test_vmalloc.c: Rename kvfree_rcu() to kvfree_rcu_mightsleep()
      net/sysctl: Rename kvfree_rcu() to kvfree_rcu_mightsleep()
      net/mlx5: Rename kfree_rcu() to kfree_rcu_mightsleep()
      ext4/super: Rename kfree_rcu() to kfree_rcu_mightsleep()
      rcuscale: Rename kfree_rcu() to kfree_rcu_mightsleep()

Xu Panda (1):
      rcu/trace: use strscpy() to instead of strncpy()

Yue Hu (1):
      rcutorture: Eliminate variable n_rcu_torture_boost_rterror

Zheng Yejian (1):
      rcu: Avoid stack overflow due to __rcu_irq_enter_check_tick() being kprobe-ed

Zqiang (7):
      rcutorture: Create nocb kthreads only when testing rcu in CONFIG_RCU_NOCB_CPU=y kernels
      rcu: Fix set/clear TICK_DEP_BIT_RCU_EXP bitmask race
      rcu: Fix missing TICK_DEP_MASK_RCU_EXP dependency check
      rcu: Register rcu-lazy shrinker only for CONFIG_RCU_LAZY=y kernels
      rcu: Remove never-set needwake assignment from rcu_report_qs_rdp()
      rcu: Permit start_poll_synchronize_rcu_expedited() to be invoked early
      rcu: Protect rcu_print_task_exp_stall() ->exp_tasks access

 .../Expedited-Grace-Periods.rst                    |   6 +-
 .../Memory-Ordering/Tree-RCU-Memory-Ordering.rst   |   2 +-
 Documentation/RCU/RTFP.txt                         |  10 +-
 Documentation/RCU/UP.rst                           |   4 +-
 Documentation/RCU/checklist.rst                    |   2 +-
 Documentation/RCU/lockdep.rst                      |   2 +-
 Documentation/RCU/torture.rst                      |   4 +-
 Documentation/RCU/whatisRCU.rst                    |   6 +-
 MAINTAINERS                                        |   4 +-
 arch/arm64/kvm/Kconfig                             |   1 -
 arch/mips/kvm/Kconfig                              |   1 -
 arch/powerpc/kvm/Kconfig                           |   1 -
 arch/riscv/kvm/Kconfig                             |   1 -
 arch/s390/kvm/Kconfig                              |   1 -
 arch/x86/Kconfig                                   |   2 -
 arch/x86/kvm/Kconfig                               |   1 -
 drivers/base/cpu.c                                 |   3 +-
 drivers/block/drbd/drbd_nl.c                       |   6 +-
 drivers/block/drbd/drbd_receiver.c                 |   4 +-
 drivers/block/drbd/drbd_state.c                    |   2 +-
 drivers/misc/vmw_vmci/vmci_context.c               |   2 +-
 drivers/misc/vmw_vmci/vmci_event.c                 |   2 +-
 .../ethernet/mellanox/mlx5/core/en/tc/int_port.c   |   2 +-
 .../ethernet/mellanox/mlx5/core/en_accel/macsec.c  |   4 +-
 fs/ext4/super.c                                    |   2 +-
 include/linux/lockdep.h                            |   8 +-
 include/linux/notifier.h                           |   5 +-
 include/linux/srcu.h                               |  34 +-
 include/linux/srcutiny.h                           |   6 +-
 include/linux/srcutree.h                           |  94 +++--
 include/linux/tick.h                               |   2 +
 include/trace/events/rcu.h                         |   4 +-
 include/trace/events/timer.h                       |   3 +-
 kernel/locking/lockdep.c                           |  64 ++-
 kernel/locking/test-ww_mutex.c                     |   2 +-
 kernel/rcu/Kconfig                                 |   3 -
 kernel/rcu/rcu.h                                   |  43 +-
 kernel/rcu/rcuscale.c                              |   9 +-
 kernel/rcu/rcutorture.c                            | 234 ++++++++++-
 kernel/rcu/refscale.c                              |   2 +-
 kernel/rcu/srcutiny.c                              |   2 +
 kernel/rcu/srcutree.c                              | 438 ++++++++++++---------
 kernel/rcu/tasks.h                                 |  33 ++
 kernel/rcu/tree.c                                  |  18 +-
 kernel/rcu/tree_exp.h                              |  16 +-
 kernel/rcu/tree_nocb.h                             |   4 +
 kernel/time/tick-sched.c                           |  16 +-
 kernel/trace/trace_osnoise.c                       |   2 +-
 kernel/trace/trace_probe.c                         |   2 +-
 lib/test_vmalloc.c                                 |   2 +-
 mm/Kconfig                                         |   1 -
 net/core/sysctl_net_core.c                         |   4 +-
 net/mac802154/scan.c                               |   4 +-
 scripts/checkpatch.pl                              |   9 +
 tools/rcu/extract-stall.sh                         |  26 +-
 .../testing/selftests/rcutorture/bin/kvm-again.sh  |   2 +-
 .../selftests/rcutorture/bin/srcu_lockdep.sh       |  78 ++++
 tools/testing/selftests/rcutorture/bin/torture.sh  |   6 +-
 .../selftests/rcutorture/configs/rcu/TREE01        |   1 +
 .../selftests/rcutorture/configs/rcu/TREE04        |   1 +
 .../selftests/rcutorture/doc/TREE_RCU-kconfig.txt  |   4 -
 61 files changed, 915 insertions(+), 342 deletions(-)
 mode change 100644 => 100755 tools/rcu/extract-stall.sh
 create mode 100755 tools/testing/selftests/rcutorture/bin/srcu_lockdep.sh
