Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28CA15B453C
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 10:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbiIJI05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 04:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiIJI0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 04:26:53 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D7488E0FB
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 01:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662798412; x=1694334412;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=edMros1zwKMDUZOarHjJXHIlnGh4LxkLP40pazDgUw8=;
  b=BkRO2DHnhv7TIC8MNAwweJRwqQ0xDfvTQNkcZRAo8//kaXcO2jgrSx4G
   NSGvfOezMEAmQG/wx4uzgH5XyRuvbf+YwqYoOYvSL7GLY44Z5fcOaIj6y
   AeIka3r6CS9z/a433OvCLtkJ+voLfiQ+CNFBdh6z+bb/UnWGGujm3xmDm
   g7Bi4Uxg6zJ3Q7SQByM7BziNE8ZGexThI2X78/T82f9IBJns1VlCtO58O
   1v02G5Fo2nONRFNgeypjYW+JOVH8NseRrRQPwHODQww5eERXlKI4wmLJG
   TFZrve/tqNFc6Z5OY2GrmcJtvPF6ee4R12sbGhpBExaXit4xwNRS9w/rR
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10465"; a="298961468"
X-IronPort-AV: E=Sophos;i="5.93,305,1654585200"; 
   d="scan'208";a="298961468"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2022 01:26:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,305,1654585200"; 
   d="scan'208";a="791054441"
Received: from lkp-server02.sh.intel.com (HELO b2938d2e5c5a) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 10 Sep 2022 01:26:47 -0700
Received: from kbuild by b2938d2e5c5a with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oWvp8-0002JZ-1p;
        Sat, 10 Sep 2022 08:26:46 +0000
Date:   Sat, 10 Sep 2022 16:26:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jolsa-perf:tp_fix 1/1] include/linux/rcupdate.h:707: undefined
 reference to `bpf_prog_inc_misses_counter'
Message-ID: <202209101652.Q0TCRc8T-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git tp_fix
head:   1d5150ae30634ba3ff98b5ac0489f44375acca56
commit: 1d5150ae30634ba3ff98b5ac0489f44375acca56 [1/1] bpf: Prevent bpf program recursion for raw tracepoint probes
config: riscv-randconfig-r002-20220907 (https://download.01.org/0day-ci/archive/20220910/202209101652.Q0TCRc8T-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/commit/?id=1d5150ae30634ba3ff98b5ac0489f44375acca56
        git remote add jolsa-perf https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
        git fetch --no-tags jolsa-perf tp_fix
        git checkout 1d5150ae30634ba3ff98b5ac0489f44375acca56
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   riscv32-linux-ld: kernel/bpf/trampoline.o: in function `rcu_read_lock':
>> include/linux/rcupdate.h:707: undefined reference to `bpf_prog_inc_misses_counter'


vim +707 include/linux/rcupdate.h

c3ac7cf1847a4e Paul E. McKenney          2015-09-10  654  
^1da177e4c3f41 Linus Torvalds            2005-04-16  655  /**
ca5ecddfa8fcbd Paul E. McKenney          2010-04-28  656   * rcu_read_lock() - mark the beginning of an RCU read-side critical section
^1da177e4c3f41 Linus Torvalds            2005-04-16  657   *
9b06e818985d13 Paul E. McKenney          2005-05-01  658   * When synchronize_rcu() is invoked on one CPU while other CPUs
^1da177e4c3f41 Linus Torvalds            2005-04-16  659   * are within RCU read-side critical sections, then the
9b06e818985d13 Paul E. McKenney          2005-05-01  660   * synchronize_rcu() is guaranteed to block until after all the other
^1da177e4c3f41 Linus Torvalds            2005-04-16  661   * CPUs exit their critical sections.  Similarly, if call_rcu() is invoked
^1da177e4c3f41 Linus Torvalds            2005-04-16  662   * on one CPU while other CPUs are within RCU read-side critical
^1da177e4c3f41 Linus Torvalds            2005-04-16  663   * sections, invocation of the corresponding RCU callback is deferred
^1da177e4c3f41 Linus Torvalds            2005-04-16  664   * until after the all the other CPUs exit their critical sections.
^1da177e4c3f41 Linus Torvalds            2005-04-16  665   *
1893afd6340911 Paul E. McKenney          2021-04-29  666   * In v5.0 and later kernels, synchronize_rcu() and call_rcu() also
1893afd6340911 Paul E. McKenney          2021-04-29  667   * wait for regions of code with preemption disabled, including regions of
1893afd6340911 Paul E. McKenney          2021-04-29  668   * code with interrupts or softirqs disabled.  In pre-v5.0 kernels, which
1893afd6340911 Paul E. McKenney          2021-04-29  669   * define synchronize_sched(), only code enclosed within rcu_read_lock()
1893afd6340911 Paul E. McKenney          2021-04-29  670   * and rcu_read_unlock() are guaranteed to be waited for.
1893afd6340911 Paul E. McKenney          2021-04-29  671   *
^1da177e4c3f41 Linus Torvalds            2005-04-16  672   * Note, however, that RCU callbacks are permitted to run concurrently
77d8485a8b5416 Paul E. McKenney          2010-07-08  673   * with new RCU read-side critical sections.  One way that this can happen
^1da177e4c3f41 Linus Torvalds            2005-04-16  674   * is via the following sequence of events: (1) CPU 0 enters an RCU
^1da177e4c3f41 Linus Torvalds            2005-04-16  675   * read-side critical section, (2) CPU 1 invokes call_rcu() to register
^1da177e4c3f41 Linus Torvalds            2005-04-16  676   * an RCU callback, (3) CPU 0 exits the RCU read-side critical section,
^1da177e4c3f41 Linus Torvalds            2005-04-16  677   * (4) CPU 2 enters a RCU read-side critical section, (5) the RCU
^1da177e4c3f41 Linus Torvalds            2005-04-16  678   * callback is invoked.  This is legal, because the RCU read-side critical
^1da177e4c3f41 Linus Torvalds            2005-04-16  679   * section that was running concurrently with the call_rcu() (and which
^1da177e4c3f41 Linus Torvalds            2005-04-16  680   * therefore might be referencing something that the corresponding RCU
^1da177e4c3f41 Linus Torvalds            2005-04-16  681   * callback would free up) has completed before the corresponding
^1da177e4c3f41 Linus Torvalds            2005-04-16  682   * RCU callback is invoked.
^1da177e4c3f41 Linus Torvalds            2005-04-16  683   *
^1da177e4c3f41 Linus Torvalds            2005-04-16  684   * RCU read-side critical sections may be nested.  Any deferred actions
^1da177e4c3f41 Linus Torvalds            2005-04-16  685   * will be deferred until the outermost RCU read-side critical section
^1da177e4c3f41 Linus Torvalds            2005-04-16  686   * completes.
^1da177e4c3f41 Linus Torvalds            2005-04-16  687   *
9079fd7c2e06a9 Paul E. McKenney          2010-08-07  688   * You can avoid reading and understanding the next paragraph by
9079fd7c2e06a9 Paul E. McKenney          2010-08-07  689   * following this rule: don't put anything in an rcu_read_lock() RCU
90326f0521a880 Sebastian Andrzej Siewior 2019-10-15  690   * read-side critical section that would block in a !PREEMPTION kernel.
9079fd7c2e06a9 Paul E. McKenney          2010-08-07  691   * But if you want the full story, read on!
9079fd7c2e06a9 Paul E. McKenney          2010-08-07  692   *
b3e627d3d5092a Lai Jiangshan             2019-10-15  693   * In non-preemptible RCU implementations (pure TREE_RCU and TINY_RCU),
ab74fdfd4e11ec Paul E. McKenney          2014-05-04  694   * it is illegal to block while in an RCU read-side critical section.
01b1d88b09824b Thomas Gleixner           2019-07-26  695   * In preemptible RCU implementations (PREEMPT_RCU) in CONFIG_PREEMPTION
ab74fdfd4e11ec Paul E. McKenney          2014-05-04  696   * kernel builds, RCU read-side critical sections may be preempted,
ab74fdfd4e11ec Paul E. McKenney          2014-05-04  697   * but explicit blocking is illegal.  Finally, in preemptible RCU
ab74fdfd4e11ec Paul E. McKenney          2014-05-04  698   * implementations in real-time (with -rt patchset) kernel builds, RCU
ab74fdfd4e11ec Paul E. McKenney          2014-05-04  699   * read-side critical sections may be preempted and they may also block, but
ab74fdfd4e11ec Paul E. McKenney          2014-05-04  700   * only when acquiring spinlocks that are subject to priority inheritance.
^1da177e4c3f41 Linus Torvalds            2005-04-16  701   */
6da9f775175e51 Waiman Long               2019-05-21  702  static __always_inline void rcu_read_lock(void)
bc33f24bdca8b6 Paul E. McKenney          2009-08-22  703  {
bc33f24bdca8b6 Paul E. McKenney          2009-08-22  704  	__rcu_read_lock();
bc33f24bdca8b6 Paul E. McKenney          2009-08-22  705  	__acquire(RCU);
d8ab29f8be918b Paul E. McKenney          2011-10-07  706  	rcu_lock_acquire(&rcu_lock_map);
f78f5b90c4ffa5 Paul E. McKenney          2015-06-18 @707  	RCU_LOCKDEP_WARN(!rcu_is_watching(),
bde23c6892878e Heiko Carstens            2012-02-01  708  			 "rcu_read_lock() used illegally while idle");
bc33f24bdca8b6 Paul E. McKenney          2009-08-22  709  }
^1da177e4c3f41 Linus Torvalds            2005-04-16  710  

:::::: The code at line 707 was first introduced by commit
:::::: f78f5b90c4ffa559e400c3919a02236101f29f3f rcu: Rename rcu_lockdep_assert() to RCU_LOCKDEP_WARN()

:::::: TO: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
:::::: CC: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
