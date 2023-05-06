Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D43486F93FB
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 22:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjEFUq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 16:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjEFUq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 16:46:27 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10342D401
        for <linux-kernel@vger.kernel.org>; Sat,  6 May 2023 13:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683405985; x=1714941985;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=PnmHCyabgXyvYS1htvgDiVxkPTs2+/67i+YR/NcU3b0=;
  b=b091sWgEShcdUUu9Rhpo80skdfiWnWBqwYxGtsvuPyl7oJj2T2zuox0X
   JgRiHzZFUIm41CeGa/vYw2dNwuVBZ1Cop8B58BR1dxNf+lIR/DAkWtj0C
   SRkU8XxhTeVPvbaBs/+7medVL79GS03V1aTcL+F+VAeE6Gy5/To6g9Qf0
   1zjYVsBsHm/uvEzMPn2ru0+SqiS/e99ohvmd/0RzrU2oSxGvxVE3wos+T
   jiqFsCRBsjrkH9oxW9cel2/M6GOBjnTT+qtQkxj4so0Hm/4xiyhGpeiqy
   wtVxNulOw9A1dQcO5Ms7UNVRLwd5SRsZcUnrTW2GEao+AqtALhMHJu1r+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10702"; a="412666306"
X-IronPort-AV: E=Sophos;i="5.99,255,1677571200"; 
   d="scan'208";a="412666306"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2023 13:46:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10702"; a="730794938"
X-IronPort-AV: E=Sophos;i="5.99,255,1677571200"; 
   d="scan'208";a="730794938"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 06 May 2023 13:46:23 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pvOnO-0000Td-2Y;
        Sat, 06 May 2023 20:46:22 +0000
Date:   Sun, 7 May 2023 04:45:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>
Subject: include/linux/cpuidle.h:121:9: sparse: sparse: incorrect type in
 argument 1 (different address spaces)
Message-ID: <202305070454.FfHPTQpw-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   fc4354c6e5c21257cf4a50b32f7c11c7d65c55b3
commit: a01353cf1896ea5b8a7bbc5e2b2d38feed8b7aaa cpuidle: Fix ct_idle_*() usage
date:   4 months ago
config: loongarch-randconfig-s052-20230507 (https://download.01.org/0day-ci/archive/20230507/202305070454.FfHPTQpw-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a01353cf1896ea5b8a7bbc5e2b2d38feed8b7aaa
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout a01353cf1896ea5b8a7bbc5e2b2d38feed8b7aaa
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=loongarch olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=loongarch SHELL=/bin/bash kernel/sched/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305070454.FfHPTQpw-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   kernel/sched/rt.c:1047:38: sparse:     expected struct task_struct *curr
   kernel/sched/rt.c:1047:38: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/rt.c:1592:31: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/rt.c:1592:31: sparse:     expected struct task_struct *p
   kernel/sched/rt.c:1592:31: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/rt.c:1880:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got struct cpumask *[noderef] __percpu * @@
   kernel/sched/rt.c:1880:39: sparse:     expected void *ptr
   kernel/sched/rt.c:1880:39: sparse:     got struct cpumask *[noderef] __percpu *
   kernel/sched/rt.c:1880:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got struct cpumask *[noderef] __percpu * @@
   kernel/sched/rt.c:1880:39: sparse:     expected void *ptr
   kernel/sched/rt.c:1880:39: sparse:     got struct cpumask *[noderef] __percpu *
   kernel/sched/rt.c:1880:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got struct cpumask *[noderef] __percpu * @@
   kernel/sched/rt.c:1880:39: sparse:     expected void *ptr
   kernel/sched/rt.c:1880:39: sparse:     got struct cpumask *[noderef] __percpu *
   kernel/sched/rt.c:1880:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got struct cpumask *[noderef] __percpu * @@
   kernel/sched/rt.c:1880:39: sparse:     expected void *ptr
   kernel/sched/rt.c:1880:39: sparse:     got struct cpumask *[noderef] __percpu *
   kernel/sched/rt.c:1929:9: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/rt.c:1929:9: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/rt.c:1929:9: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/rt.c:1612:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *curr @@     got struct task_struct [noderef] __rcu * @@
   kernel/sched/rt.c:1612:14: sparse:     expected struct task_struct *curr
   kernel/sched/rt.c:1612:14: sparse:     got struct task_struct [noderef] __rcu *
   kernel/sched/rt.c:1677:45: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/rt.c:1677:45: sparse:     expected struct task_struct *p
   kernel/sched/rt.c:1677:45: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/rt.c:1738:67: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *tsk @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/rt.c:1738:67: sparse:     expected struct task_struct *tsk
   kernel/sched/rt.c:1738:67: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/rt.c:2093:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *task @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/rt.c:2093:40: sparse:     expected struct task_struct *task
   kernel/sched/rt.c:2093:40: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/rt.c:2114:13: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/rt.c:2114:13: sparse:    struct task_struct *
   kernel/sched/rt.c:2114:13: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/rt.c:2462:54: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *tsk @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/rt.c:2462:54: sparse:     expected struct task_struct *tsk
   kernel/sched/rt.c:2462:54: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/rt.c:2464:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/rt.c:2464:40: sparse:     expected struct task_struct *p
   kernel/sched/rt.c:2464:40: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/rt.c:2464:61: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/rt.c:2464:61: sparse:     expected struct task_struct *p
   kernel/sched/rt.c:2464:61: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/build_policy.c: note: in included file:
   kernel/sched/deadline.c:2315:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/deadline.c:2315:23: sparse:     expected struct task_struct *p
   kernel/sched/deadline.c:2315:23: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/deadline.c:2325:13: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/deadline.c:2325:13: sparse:    struct task_struct *
   kernel/sched/deadline.c:2325:13: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/deadline.c:2433:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/deadline.c:2433:25: sparse:    struct task_struct *
   kernel/sched/deadline.c:2433:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/deadline.c:1954:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct sched_dl_entity const *b @@     got struct sched_dl_entity [noderef] __rcu * @@
   kernel/sched/deadline.c:1954:42: sparse:     expected struct sched_dl_entity const *b
   kernel/sched/deadline.c:1954:42: sparse:     got struct sched_dl_entity [noderef] __rcu *
   kernel/sched/deadline.c:1965:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *tsk @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/deadline.c:1965:38: sparse:     expected struct task_struct *tsk
   kernel/sched/deadline.c:1965:38: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/deadline.c:1182:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/deadline.c:1182:23: sparse:     expected struct task_struct *p
   kernel/sched/deadline.c:1182:23: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/deadline.c:1309:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *curr @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/deadline.c:1309:38: sparse:     expected struct task_struct *curr
   kernel/sched/deadline.c:1309:38: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/deadline.c:2134:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got struct cpumask *[noderef] __percpu * @@
   kernel/sched/deadline.c:2134:38: sparse:     expected void *ptr
   kernel/sched/deadline.c:2134:38: sparse:     got struct cpumask *[noderef] __percpu *
   kernel/sched/deadline.c:2134:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got struct cpumask *[noderef] __percpu * @@
   kernel/sched/deadline.c:2134:38: sparse:     expected void *ptr
   kernel/sched/deadline.c:2134:38: sparse:     got struct cpumask *[noderef] __percpu *
   kernel/sched/deadline.c:2134:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got struct cpumask *[noderef] __percpu * @@
   kernel/sched/deadline.c:2134:38: sparse:     expected void *ptr
   kernel/sched/deadline.c:2134:38: sparse:     got struct cpumask *[noderef] __percpu *
   kernel/sched/deadline.c:2134:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got struct cpumask *[noderef] __percpu * @@
   kernel/sched/deadline.c:2134:38: sparse:     expected void *ptr
   kernel/sched/deadline.c:2134:38: sparse:     got struct cpumask *[noderef] __percpu *
   kernel/sched/deadline.c:2174:9: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/deadline.c:2174:9: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/deadline.c:2174:9: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/deadline.c:1839:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *curr @@     got struct task_struct [noderef] __rcu * @@
   kernel/sched/deadline.c:1839:14: sparse:     expected struct task_struct *curr
   kernel/sched/deadline.c:1839:14: sparse:     got struct task_struct [noderef] __rcu *
   kernel/sched/deadline.c:1915:43: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/deadline.c:1915:43: sparse:     expected struct task_struct *p
   kernel/sched/deadline.c:1915:43: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/deadline.c:2478:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *tsk @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/deadline.c:2478:38: sparse:     expected struct task_struct *tsk
   kernel/sched/deadline.c:2478:38: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/deadline.c:2480:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/deadline.c:2480:23: sparse:     expected struct task_struct *p
   kernel/sched/deadline.c:2480:23: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/deadline.c:2482:44: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct sched_dl_entity const *b @@     got struct sched_dl_entity [noderef] __rcu * @@
   kernel/sched/deadline.c:2482:44: sparse:     expected struct sched_dl_entity const *b
   kernel/sched/deadline.c:2482:44: sparse:     got struct sched_dl_entity [noderef] __rcu *
   kernel/sched/deadline.c:2645:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/deadline.c:2645:22: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/deadline.c:2645:22: sparse:    struct task_struct *
   kernel/sched/build_policy.c: note: in included file:
>> include/linux/cpuidle.h:121:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
>> include/linux/cpuidle.h:121:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
>> include/linux/cpuidle.h:121:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
>> include/linux/cpuidle.h:121:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
>> include/linux/cpuidle.h:121:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
>> include/linux/cpuidle.h:121:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
>> include/linux/cpuidle.h:121:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
>> include/linux/cpuidle.h:121:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
>> include/linux/cpuidle.h:121:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
>> include/linux/cpuidle.h:121:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
>> include/linux/cpuidle.h:121:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
>> include/linux/cpuidle.h:121:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
>> include/linux/cpuidle.h:121:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
>> include/linux/cpuidle.h:121:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
>> include/linux/cpuidle.h:121:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
>> include/linux/cpuidle.h:121:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/sched/build_policy.c: note: in included file:
   kernel/sched/sched.h:2074:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2074:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2074:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2074:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2074:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2074:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2074:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2074:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2074:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2074:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2074:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2074:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2074:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2074:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2074:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2074:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2074:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2074:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2074:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2074:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2074:25: sparse:    struct task_struct *

vim +121 include/linux/cpuidle.h

   118	
   119	static __always_inline void ct_cpuidle_enter(void)
   120	{
 > 121		lockdep_assert_irqs_disabled();
   122		/*
   123		 * Idle is allowed to (temporary) enable IRQs. It
   124		 * will return with IRQs disabled.
   125		 *
   126		 * Trace IRQs enable here, then switch off RCU, and have
   127		 * arch_cpu_idle() use raw_local_irq_enable(). Note that
   128		 * ct_idle_enter() relies on lockdep IRQ state, so switch that
   129		 * last -- this is very similar to the entry code.
   130		 */
   131		trace_hardirqs_on_prepare();
   132		lockdep_hardirqs_on_prepare();
   133		instrumentation_end();
   134		ct_idle_enter();
   135		lockdep_hardirqs_on(_RET_IP_);
   136	}
   137	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
