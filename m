Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D842A692C7E
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 02:20:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjBKBU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 20:20:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjBKBU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 20:20:56 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 076903A08D
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 17:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676078455; x=1707614455;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=NvjO3EA2KmrquqdT0hI1GW8nOfSuMARy4qFYkmJmeSI=;
  b=V128GrwrzXyz2cv31f0z/M1i5ibc7zMh87CzZwHpHJNDczzeuV0UWTUC
   WMzLdTieB0XKy5NpzvJTZ8unhcwT4o++SQzgRrVvUQTU4hA+a9P/d2TRB
   eMeWqpQryy+D/9Z80ukN5VmasP4JrpO12QBei14FaXeGe66JRQXXqk2FA
   54USkPGFAJFsWX/NXP3qQust4mMPH4rTCpw7sT2z3hxKwCX1nfNlgqTKf
   pjWshKsJJuaL9xYTHsWmJzUM1dwog4t/DoDKHAHeecQrTMNwIJFxiqC42
   1MZk+dfHn4XEIwUW7Qv5rlKz5nVzz63xM3St1t42KuQ5eNx0IhFVXQkXX
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="328263729"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="328263729"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 17:20:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="792154749"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="792154749"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 10 Feb 2023 17:20:52 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pQeZP-00069f-2d;
        Sat, 11 Feb 2023 01:20:51 +0000
Date:   Sat, 11 Feb 2023 09:19:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Qing Zhang <zhangqing@loongson.cn>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Huacai Chen <chenhuacai@kernel.org>
Subject: net/core/dev.c:4348:9: sparse: sparse: incorrect type in argument 1
 (different address spaces)
Message-ID: <202302110944.Q3Nt0hMV-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   420b2d431d18a2572c8e86579e78105cb5ed45b0
commit: 93a4fa622eb061f75f87f0cf9609ab4e69c67d01 LoongArch: Add STACKTRACE support
date:   6 months ago
config: loongarch-randconfig-s052-20230210 (https://download.01.org/0day-ci/archive/20230211/202302110944.Q3Nt0hMV-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=93a4fa622eb061f75f87f0cf9609ab4e69c67d01
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 93a4fa622eb061f75f87f0cf9609ab4e69c67d01
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=loongarch olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=loongarch SHELL=/bin/bash net/core/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302110944.Q3Nt0hMV-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   net/core/dev.c:3325:23: sparse: sparse: incorrect type in argument 4 (different base types) @@     expected restricted __wsum [usertype] csum @@     got unsigned int @@
   net/core/dev.c:3325:23: sparse:     expected restricted __wsum [usertype] csum
   net/core/dev.c:3325:23: sparse:     got unsigned int
   net/core/dev.c:3325:23: sparse: sparse: cast from restricted __wsum
   net/core/dev.c:204:9: sparse: sparse: context imbalance in 'unlist_netdevice' - different lock contexts for basic block
   net/core/dev.c:3829:17: sparse: sparse: context imbalance in '__dev_queue_xmit' - different lock contexts for basic block
>> net/core/dev.c:4348:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   net/core/dev.c:4348:9: sparse:     expected void *ptr
   net/core/dev.c:4348:9: sparse:     got unsigned int [noderef] __percpu *
>> net/core/dev.c:4348:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   net/core/dev.c:4348:9: sparse:     expected void *ptr
   net/core/dev.c:4348:9: sparse:     got unsigned int [noderef] __percpu *
>> net/core/dev.c:4348:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   net/core/dev.c:4348:9: sparse:     expected void *ptr
   net/core/dev.c:4348:9: sparse:     got unsigned int [noderef] __percpu *
>> net/core/dev.c:4348:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   net/core/dev.c:4348:9: sparse:     expected void *ptr
   net/core/dev.c:4348:9: sparse:     got unsigned int [noderef] __percpu *
>> net/core/dev.c:4348:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   net/core/dev.c:4348:9: sparse:     expected void *ptr
   net/core/dev.c:4348:9: sparse:     got int [noderef] __percpu *
>> net/core/dev.c:4348:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   net/core/dev.c:4348:9: sparse:     expected void *ptr
   net/core/dev.c:4348:9: sparse:     got int [noderef] __percpu *
>> net/core/dev.c:4348:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   net/core/dev.c:4348:9: sparse:     expected void *ptr
   net/core/dev.c:4348:9: sparse:     got int [noderef] __percpu *
>> net/core/dev.c:4348:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   net/core/dev.c:4348:9: sparse:     expected void *ptr
   net/core/dev.c:4348:9: sparse:     got int [noderef] __percpu *
   net/core/dev.c:5056:17: sparse: sparse: context imbalance in 'net_tx_action' - different lock contexts for basic block
>> net/core/dev.c:4348:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   net/core/dev.c:4348:9: sparse:     expected void *ptr
   net/core/dev.c:4348:9: sparse:     got unsigned int [noderef] __percpu *
>> net/core/dev.c:4348:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   net/core/dev.c:4348:9: sparse:     expected void *ptr
   net/core/dev.c:4348:9: sparse:     got unsigned int [noderef] __percpu *
>> net/core/dev.c:4348:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   net/core/dev.c:4348:9: sparse:     expected void *ptr
   net/core/dev.c:4348:9: sparse:     got unsigned int [noderef] __percpu *
>> net/core/dev.c:4348:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   net/core/dev.c:4348:9: sparse:     expected void *ptr
   net/core/dev.c:4348:9: sparse:     got unsigned int [noderef] __percpu *
>> net/core/dev.c:4348:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   net/core/dev.c:4348:9: sparse:     expected void *ptr
   net/core/dev.c:4348:9: sparse:     got int [noderef] __percpu *
>> net/core/dev.c:4348:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   net/core/dev.c:4348:9: sparse:     expected void *ptr
   net/core/dev.c:4348:9: sparse:     got int [noderef] __percpu *
>> net/core/dev.c:4348:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   net/core/dev.c:4348:9: sparse:     expected void *ptr
   net/core/dev.c:4348:9: sparse:     got int [noderef] __percpu *
>> net/core/dev.c:4348:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   net/core/dev.c:4348:9: sparse:     expected void *ptr
   net/core/dev.c:4348:9: sparse:     got int [noderef] __percpu *
>> net/core/dev.c:4348:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   net/core/dev.c:4348:9: sparse:     expected void *ptr
   net/core/dev.c:4348:9: sparse:     got unsigned int [noderef] __percpu *
>> net/core/dev.c:4348:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   net/core/dev.c:4348:9: sparse:     expected void *ptr
   net/core/dev.c:4348:9: sparse:     got unsigned int [noderef] __percpu *
>> net/core/dev.c:4348:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   net/core/dev.c:4348:9: sparse:     expected void *ptr
   net/core/dev.c:4348:9: sparse:     got unsigned int [noderef] __percpu *
>> net/core/dev.c:4348:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   net/core/dev.c:4348:9: sparse:     expected void *ptr
   net/core/dev.c:4348:9: sparse:     got unsigned int [noderef] __percpu *
>> net/core/dev.c:4348:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   net/core/dev.c:4348:9: sparse:     expected void *ptr
   net/core/dev.c:4348:9: sparse:     got int [noderef] __percpu *
>> net/core/dev.c:4348:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   net/core/dev.c:4348:9: sparse:     expected void *ptr
   net/core/dev.c:4348:9: sparse:     got int [noderef] __percpu *
>> net/core/dev.c:4348:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   net/core/dev.c:4348:9: sparse:     expected void *ptr
   net/core/dev.c:4348:9: sparse:     got int [noderef] __percpu *
>> net/core/dev.c:4348:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   net/core/dev.c:4348:9: sparse:     expected void *ptr
   net/core/dev.c:4348:9: sparse:     got int [noderef] __percpu *
>> net/core/dev.c:4348:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   net/core/dev.c:4348:9: sparse:     expected void *ptr
   net/core/dev.c:4348:9: sparse:     got unsigned int [noderef] __percpu *
>> net/core/dev.c:4348:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   net/core/dev.c:4348:9: sparse:     expected void *ptr
   net/core/dev.c:4348:9: sparse:     got unsigned int [noderef] __percpu *
>> net/core/dev.c:4348:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   net/core/dev.c:4348:9: sparse:     expected void *ptr
   net/core/dev.c:4348:9: sparse:     got unsigned int [noderef] __percpu *
>> net/core/dev.c:4348:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   net/core/dev.c:4348:9: sparse:     expected void *ptr
   net/core/dev.c:4348:9: sparse:     got unsigned int [noderef] __percpu *
>> net/core/dev.c:4348:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   net/core/dev.c:4348:9: sparse:     expected void *ptr
   net/core/dev.c:4348:9: sparse:     got int [noderef] __percpu *
>> net/core/dev.c:4348:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   net/core/dev.c:4348:9: sparse:     expected void *ptr
   net/core/dev.c:4348:9: sparse:     got int [noderef] __percpu *
>> net/core/dev.c:4348:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   net/core/dev.c:4348:9: sparse:     expected void *ptr
   net/core/dev.c:4348:9: sparse:     got int [noderef] __percpu *
>> net/core/dev.c:4348:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   net/core/dev.c:4348:9: sparse:     expected void *ptr
   net/core/dev.c:4348:9: sparse:     got int [noderef] __percpu *

vim +4348 net/core/dev.c

^1da177e4c3f41 Linus Torvalds            2005-04-16  4341  
eecfd7c4e36ff5 Eric Dumazet              2010-05-06  4342  /* Called with irq disabled */
eecfd7c4e36ff5 Eric Dumazet              2010-05-06  4343  static inline void ____napi_schedule(struct softnet_data *sd,
eecfd7c4e36ff5 Eric Dumazet              2010-05-06  4344  				     struct napi_struct *napi)
eecfd7c4e36ff5 Eric Dumazet              2010-05-06  4345  {
29863d41bb6e1d Wei Wang                  2021-02-08  4346  	struct task_struct *thread;
29863d41bb6e1d Wei Wang                  2021-02-08  4347  
fbd9a2ceba5c74 Sebastian Andrzej Siewior 2022-03-11 @4348  	lockdep_assert_irqs_disabled();
fbd9a2ceba5c74 Sebastian Andrzej Siewior 2022-03-11  4349  
29863d41bb6e1d Wei Wang                  2021-02-08  4350  	if (test_bit(NAPI_STATE_THREADED, &napi->state)) {
29863d41bb6e1d Wei Wang                  2021-02-08  4351  		/* Paired with smp_mb__before_atomic() in
5fdd2f0e5c6484 Wei Wang                  2021-02-08  4352  		 * napi_enable()/dev_set_threaded().
5fdd2f0e5c6484 Wei Wang                  2021-02-08  4353  		 * Use READ_ONCE() to guarantee a complete
5fdd2f0e5c6484 Wei Wang                  2021-02-08  4354  		 * read on napi->thread. Only call
29863d41bb6e1d Wei Wang                  2021-02-08  4355  		 * wake_up_process() when it's not NULL.
29863d41bb6e1d Wei Wang                  2021-02-08  4356  		 */
29863d41bb6e1d Wei Wang                  2021-02-08  4357  		thread = READ_ONCE(napi->thread);
29863d41bb6e1d Wei Wang                  2021-02-08  4358  		if (thread) {
cb038357937ee4 Wei Wang                  2021-03-16  4359  			/* Avoid doing set_bit() if the thread is in
cb038357937ee4 Wei Wang                  2021-03-16  4360  			 * INTERRUPTIBLE state, cause napi_thread_wait()
cb038357937ee4 Wei Wang                  2021-03-16  4361  			 * makes sure to proceed with napi polling
cb038357937ee4 Wei Wang                  2021-03-16  4362  			 * if the thread is explicitly woken from here.
cb038357937ee4 Wei Wang                  2021-03-16  4363  			 */
2f064a59a11ff9 Peter Zijlstra            2021-06-11  4364  			if (READ_ONCE(thread->__state) != TASK_INTERRUPTIBLE)
cb038357937ee4 Wei Wang                  2021-03-16  4365  				set_bit(NAPI_STATE_SCHED_THREADED, &napi->state);
29863d41bb6e1d Wei Wang                  2021-02-08  4366  			wake_up_process(thread);
29863d41bb6e1d Wei Wang                  2021-02-08  4367  			return;
29863d41bb6e1d Wei Wang                  2021-02-08  4368  		}
29863d41bb6e1d Wei Wang                  2021-02-08  4369  	}
29863d41bb6e1d Wei Wang                  2021-02-08  4370  
eecfd7c4e36ff5 Eric Dumazet              2010-05-06  4371  	list_add_tail(&napi->poll_list, &sd->poll_list);
eecfd7c4e36ff5 Eric Dumazet              2010-05-06  4372  	__raise_softirq_irqoff(NET_RX_SOFTIRQ);
eecfd7c4e36ff5 Eric Dumazet              2010-05-06  4373  }
eecfd7c4e36ff5 Eric Dumazet              2010-05-06  4374  

:::::: The code at line 4348 was first introduced by commit
:::::: fbd9a2ceba5c74bbfa19cf257ae4b4b2c820860d net: Add lockdep asserts to ____napi_schedule().

:::::: TO: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
:::::: CC: David S. Miller <davem@davemloft.net>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
