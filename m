Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D42296C9C6D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 09:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232671AbjC0Hky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 03:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232664AbjC0Hko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 03:40:44 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C2846A3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 00:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679902824; x=1711438824;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=pKOSXn65w46JuYz/MaG0A2MmHx6Io4eeOYVM1dB1WyY=;
  b=E9WuVGkxVkcqQJ+PMoMvBDCIRt0CGpcCTa3COueBFdhXJpj900Po76Hi
   E4wgvWhs7RzQvPKx83t06TdYfqOmQ+VGoiyJJzCTY8zj6BtvZvXKkiFLA
   LrK5a1m0nVYxUoIwpkQx62NFV9H5aaLsSPFSfP8vHf3nSC9guQYuz5gB6
   y3u9ExNBgw8PLSnbdUzGqN0nPNZfG6y7BvbqNYv23utf5tFC2RhKveoW7
   c9VlMD+ftPc4ACfVRNwq1s5Fgq7AjoUc9fhidMHrxz/DQUYjPJDO+kLmJ
   vGCec36PJN4lThBDdzhF6K2vJLy/lXWwHopjyVrLpbF9xWXAURvuJrhFr
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="367942268"
X-IronPort-AV: E=Sophos;i="5.98,294,1673942400"; 
   d="scan'208";a="367942268"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 00:40:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="683375750"
X-IronPort-AV: E=Sophos;i="5.98,294,1673942400"; 
   d="scan'208";a="683375750"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 27 Mar 2023 00:40:06 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pghSY-000Hbb-0N;
        Mon, 27 Mar 2023 07:40:06 +0000
Date:   Mon, 27 Mar 2023 15:39:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:srcu-cf.2023.03.26a 4/20]
 kernel/rcu/srcutree.c:1907:67: error: 'struct srcu_usage' has no member
 named 'srcu_gp_seq_needed'
Message-ID: <202303271532.p78iYvzM-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git srcu-cf.2023.03.26a
head:   9607cde099a20296cf0234f571d60184f277aa37
commit: 428843e3b2f64d472d38f68968c532acafe42490 [4/20] srcu: Begin offloading srcu_struct fields to srcu_update
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20230327/202303271532.p78iYvzM-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/commit/?id=428843e3b2f64d472d38f68968c532acafe42490
        git remote add paulmck-rcu https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
        git fetch --no-tags paulmck-rcu srcu-cf.2023.03.26a
        git checkout 428843e3b2f64d472d38f68968c532acafe42490
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash kernel/rcu/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303271532.p78iYvzM-lkp@intel.com/

Note: the paulmck-rcu/srcu-cf.2023.03.26a HEAD 9607cde099a20296cf0234f571d60184f277aa37 builds fine.
      It only hurts bisectability.

All errors (new ones prefixed by >>):

   In file included from include/linux/list.h:11,
                    from include/linux/mutex.h:15,
                    from kernel/rcu/srcutree.c:19:
   kernel/rcu/srcutree.c: In function 'srcu_module_going':
>> kernel/rcu/srcutree.c:1907:67: error: 'struct srcu_usage' has no member named 'srcu_gp_seq_needed'
    1907 |                 if (!rcu_seq_state(smp_load_acquire(&ssp->srcu_sup->srcu_gp_seq_needed)) &&
         |                                                                   ^~
   arch/powerpc/include/asm/barrier.h:81:17: note: in definition of macro '__smp_load_acquire'
      81 |         typeof(*p) ___p1 = READ_ONCE(*p);                               \
         |                 ^
   kernel/rcu/srcutree.c:1907:36: note: in expansion of macro 'smp_load_acquire'
    1907 |                 if (!rcu_seq_state(smp_load_acquire(&ssp->srcu_sup->srcu_gp_seq_needed)) &&
         |                                    ^~~~~~~~~~~~~~~~
   In file included from <command-line>:
>> kernel/rcu/srcutree.c:1907:67: error: 'struct srcu_usage' has no member named 'srcu_gp_seq_needed'
    1907 |                 if (!rcu_seq_state(smp_load_acquire(&ssp->srcu_sup->srcu_gp_seq_needed)) &&
         |                                                                   ^~
   include/linux/compiler_types.h:377:23: note: in definition of macro '__compiletime_assert'
     377 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:397:9: note: in expansion of macro '_compiletime_assert'
     397 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/barrier.h:81:28: note: in expansion of macro 'READ_ONCE'
      81 |         typeof(*p) ___p1 = READ_ONCE(*p);                               \
         |                            ^~~~~~~~~
   include/asm-generic/barrier.h:176:29: note: in expansion of macro '__smp_load_acquire'
     176 | #define smp_load_acquire(p) __smp_load_acquire(p)
         |                             ^~~~~~~~~~~~~~~~~~
   kernel/rcu/srcutree.c:1907:36: note: in expansion of macro 'smp_load_acquire'
    1907 |                 if (!rcu_seq_state(smp_load_acquire(&ssp->srcu_sup->srcu_gp_seq_needed)) &&
         |                                    ^~~~~~~~~~~~~~~~
>> kernel/rcu/srcutree.c:1907:67: error: 'struct srcu_usage' has no member named 'srcu_gp_seq_needed'
    1907 |                 if (!rcu_seq_state(smp_load_acquire(&ssp->srcu_sup->srcu_gp_seq_needed)) &&
         |                                                                   ^~
   include/linux/compiler_types.h:377:23: note: in definition of macro '__compiletime_assert'
     377 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:397:9: note: in expansion of macro '_compiletime_assert'
     397 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/barrier.h:81:28: note: in expansion of macro 'READ_ONCE'
      81 |         typeof(*p) ___p1 = READ_ONCE(*p);                               \
         |                            ^~~~~~~~~
   include/asm-generic/barrier.h:176:29: note: in expansion of macro '__smp_load_acquire'
     176 | #define smp_load_acquire(p) __smp_load_acquire(p)
         |                             ^~~~~~~~~~~~~~~~~~
   kernel/rcu/srcutree.c:1907:36: note: in expansion of macro 'smp_load_acquire'
    1907 |                 if (!rcu_seq_state(smp_load_acquire(&ssp->srcu_sup->srcu_gp_seq_needed)) &&
         |                                    ^~~~~~~~~~~~~~~~
>> kernel/rcu/srcutree.c:1907:67: error: 'struct srcu_usage' has no member named 'srcu_gp_seq_needed'
    1907 |                 if (!rcu_seq_state(smp_load_acquire(&ssp->srcu_sup->srcu_gp_seq_needed)) &&
         |                                                                   ^~
   include/linux/compiler_types.h:377:23: note: in definition of macro '__compiletime_assert'
     377 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:397:9: note: in expansion of macro '_compiletime_assert'
     397 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/barrier.h:81:28: note: in expansion of macro 'READ_ONCE'
      81 |         typeof(*p) ___p1 = READ_ONCE(*p);                               \
         |                            ^~~~~~~~~
   include/asm-generic/barrier.h:176:29: note: in expansion of macro '__smp_load_acquire'
     176 | #define smp_load_acquire(p) __smp_load_acquire(p)
         |                             ^~~~~~~~~~~~~~~~~~
   kernel/rcu/srcutree.c:1907:36: note: in expansion of macro 'smp_load_acquire'
    1907 |                 if (!rcu_seq_state(smp_load_acquire(&ssp->srcu_sup->srcu_gp_seq_needed)) &&
         |                                    ^~~~~~~~~~~~~~~~
>> kernel/rcu/srcutree.c:1907:67: error: 'struct srcu_usage' has no member named 'srcu_gp_seq_needed'
    1907 |                 if (!rcu_seq_state(smp_load_acquire(&ssp->srcu_sup->srcu_gp_seq_needed)) &&
         |                                                                   ^~
   include/linux/compiler_types.h:377:23: note: in definition of macro '__compiletime_assert'
     377 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:397:9: note: in expansion of macro '_compiletime_assert'
     397 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/barrier.h:81:28: note: in expansion of macro 'READ_ONCE'
      81 |         typeof(*p) ___p1 = READ_ONCE(*p);                               \
         |                            ^~~~~~~~~
   include/asm-generic/barrier.h:176:29: note: in expansion of macro '__smp_load_acquire'
     176 | #define smp_load_acquire(p) __smp_load_acquire(p)
         |                             ^~~~~~~~~~~~~~~~~~
   kernel/rcu/srcutree.c:1907:36: note: in expansion of macro 'smp_load_acquire'
    1907 |                 if (!rcu_seq_state(smp_load_acquire(&ssp->srcu_sup->srcu_gp_seq_needed)) &&
         |                                    ^~~~~~~~~~~~~~~~
>> kernel/rcu/srcutree.c:1907:67: error: 'struct srcu_usage' has no member named 'srcu_gp_seq_needed'
    1907 |                 if (!rcu_seq_state(smp_load_acquire(&ssp->srcu_sup->srcu_gp_seq_needed)) &&
         |                                                                   ^~
   include/linux/compiler_types.h:377:23: note: in definition of macro '__compiletime_assert'
     377 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:397:9: note: in expansion of macro '_compiletime_assert'
     397 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/barrier.h:81:28: note: in expansion of macro 'READ_ONCE'
      81 |         typeof(*p) ___p1 = READ_ONCE(*p);                               \
         |                            ^~~~~~~~~
   include/asm-generic/barrier.h:176:29: note: in expansion of macro '__smp_load_acquire'
     176 | #define smp_load_acquire(p) __smp_load_acquire(p)
         |                             ^~~~~~~~~~~~~~~~~~
   kernel/rcu/srcutree.c:1907:36: note: in expansion of macro 'smp_load_acquire'
    1907 |                 if (!rcu_seq_state(smp_load_acquire(&ssp->srcu_sup->srcu_gp_seq_needed)) &&
         |                                    ^~~~~~~~~~~~~~~~
>> kernel/rcu/srcutree.c:1907:67: error: 'struct srcu_usage' has no member named 'srcu_gp_seq_needed'
    1907 |                 if (!rcu_seq_state(smp_load_acquire(&ssp->srcu_sup->srcu_gp_seq_needed)) &&
         |                                                                   ^~
   include/linux/compiler_types.h:353:27: note: in definition of macro '__unqual_scalar_typeof'
     353 |                 _Generic((x),                                           \
         |                           ^
   include/asm-generic/rwonce.h:50:9: note: in expansion of macro '__READ_ONCE'
      50 |         __READ_ONCE(x);                                                 \
         |         ^~~~~~~~~~~
   arch/powerpc/include/asm/barrier.h:81:28: note: in expansion of macro 'READ_ONCE'
      81 |         typeof(*p) ___p1 = READ_ONCE(*p);                               \
         |                            ^~~~~~~~~
   include/asm-generic/barrier.h:176:29: note: in expansion of macro '__smp_load_acquire'
     176 | #define smp_load_acquire(p) __smp_load_acquire(p)
         |                             ^~~~~~~~~~~~~~~~~~
   kernel/rcu/srcutree.c:1907:36: note: in expansion of macro 'smp_load_acquire'
    1907 |                 if (!rcu_seq_state(smp_load_acquire(&ssp->srcu_sup->srcu_gp_seq_needed)) &&
         |                                    ^~~~~~~~~~~~~~~~
   In file included from ./arch/powerpc/include/generated/asm/rwonce.h:1,
                    from include/linux/compiler.h:247,
                    from include/linux/build_bug.h:5,
                    from include/linux/container_of.h:5,
                    from include/linux/list.h:5:
>> kernel/rcu/srcutree.c:1907:67: error: 'struct srcu_usage' has no member named 'srcu_gp_seq_needed'
    1907 |                 if (!rcu_seq_state(smp_load_acquire(&ssp->srcu_sup->srcu_gp_seq_needed)) &&
         |                                                                   ^~
   include/asm-generic/rwonce.h:44:73: note: in definition of macro '__READ_ONCE'
      44 | #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(x) *)&(x))
         |                                                                         ^
   arch/powerpc/include/asm/barrier.h:81:28: note: in expansion of macro 'READ_ONCE'
      81 |         typeof(*p) ___p1 = READ_ONCE(*p);                               \
         |                            ^~~~~~~~~
   include/asm-generic/barrier.h:176:29: note: in expansion of macro '__smp_load_acquire'
     176 | #define smp_load_acquire(p) __smp_load_acquire(p)
         |                             ^~~~~~~~~~~~~~~~~~
   kernel/rcu/srcutree.c:1907:36: note: in expansion of macro 'smp_load_acquire'
    1907 |                 if (!rcu_seq_state(smp_load_acquire(&ssp->srcu_sup->srcu_gp_seq_needed)) &&
         |                                    ^~~~~~~~~~~~~~~~
>> kernel/rcu/srcutree.c:1907:67: error: 'struct srcu_usage' has no member named 'srcu_gp_seq_needed'
    1907 |                 if (!rcu_seq_state(smp_load_acquire(&ssp->srcu_sup->srcu_gp_seq_needed)) &&
         |                                                                   ^~
   include/linux/compiler_types.h:377:23: note: in definition of macro '__compiletime_assert'
     377 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:397:9: note: in expansion of macro '_compiletime_assert'
     397 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:400:9: note: in expansion of macro 'compiletime_assert'
     400 |         compiletime_assert(__native_word(t),                            \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:400:28: note: in expansion of macro '__native_word'
     400 |         compiletime_assert(__native_word(t),                            \
         |                            ^~~~~~~~~~~~~
   arch/powerpc/include/asm/barrier.h:82:9: note: in expansion of macro 'compiletime_assert_atomic_type'
      82 |         compiletime_assert_atomic_type(*p);                             \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/barrier.h:176:29: note: in expansion of macro '__smp_load_acquire'
     176 | #define smp_load_acquire(p) __smp_load_acquire(p)
         |                             ^~~~~~~~~~~~~~~~~~
   kernel/rcu/srcutree.c:1907:36: note: in expansion of macro 'smp_load_acquire'
    1907 |                 if (!rcu_seq_state(smp_load_acquire(&ssp->srcu_sup->srcu_gp_seq_needed)) &&
         |                                    ^~~~~~~~~~~~~~~~
>> kernel/rcu/srcutree.c:1907:67: error: 'struct srcu_usage' has no member named 'srcu_gp_seq_needed'
    1907 |                 if (!rcu_seq_state(smp_load_acquire(&ssp->srcu_sup->srcu_gp_seq_needed)) &&
         |                                                                   ^~
   include/linux/compiler_types.h:377:23: note: in definition of macro '__compiletime_assert'
     377 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:397:9: note: in expansion of macro '_compiletime_assert'
     397 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:400:9: note: in expansion of macro 'compiletime_assert'
     400 |         compiletime_assert(__native_word(t),                            \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:400:28: note: in expansion of macro '__native_word'
     400 |         compiletime_assert(__native_word(t),                            \
         |                            ^~~~~~~~~~~~~
   arch/powerpc/include/asm/barrier.h:82:9: note: in expansion of macro 'compiletime_assert_atomic_type'
      82 |         compiletime_assert_atomic_type(*p);                             \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/barrier.h:176:29: note: in expansion of macro '__smp_load_acquire'
     176 | #define smp_load_acquire(p) __smp_load_acquire(p)
         |                             ^~~~~~~~~~~~~~~~~~
   kernel/rcu/srcutree.c:1907:36: note: in expansion of macro 'smp_load_acquire'
    1907 |                 if (!rcu_seq_state(smp_load_acquire(&ssp->srcu_sup->srcu_gp_seq_needed)) &&
         |                                    ^~~~~~~~~~~~~~~~
>> kernel/rcu/srcutree.c:1907:67: error: 'struct srcu_usage' has no member named 'srcu_gp_seq_needed'
    1907 |                 if (!rcu_seq_state(smp_load_acquire(&ssp->srcu_sup->srcu_gp_seq_needed)) &&
         |                                                                   ^~
   include/linux/compiler_types.h:377:23: note: in definition of macro '__compiletime_assert'
     377 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:397:9: note: in expansion of macro '_compiletime_assert'
     397 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:400:9: note: in expansion of macro 'compiletime_assert'
     400 |         compiletime_assert(__native_word(t),                            \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:400:28: note: in expansion of macro '__native_word'
     400 |         compiletime_assert(__native_word(t),                            \
         |                            ^~~~~~~~~~~~~
   arch/powerpc/include/asm/barrier.h:82:9: note: in expansion of macro 'compiletime_assert_atomic_type'
      82 |         compiletime_assert_atomic_type(*p);                             \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/barrier.h:176:29: note: in expansion of macro '__smp_load_acquire'
     176 | #define smp_load_acquire(p) __smp_load_acquire(p)
         |                             ^~~~~~~~~~~~~~~~~~
   kernel/rcu/srcutree.c:1907:36: note: in expansion of macro 'smp_load_acquire'
    1907 |                 if (!rcu_seq_state(smp_load_acquire(&ssp->srcu_sup->srcu_gp_seq_needed)) &&
         |                                    ^~~~~~~~~~~~~~~~
>> kernel/rcu/srcutree.c:1907:67: error: 'struct srcu_usage' has no member named 'srcu_gp_seq_needed'
    1907 |                 if (!rcu_seq_state(smp_load_acquire(&ssp->srcu_sup->srcu_gp_seq_needed)) &&
         |                                                                   ^~
   include/linux/compiler_types.h:377:23: note: in definition of macro '__compiletime_assert'
     377 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:397:9: note: in expansion of macro '_compiletime_assert'
     397 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:400:9: note: in expansion of macro 'compiletime_assert'
     400 |         compiletime_assert(__native_word(t),                            \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:400:28: note: in expansion of macro '__native_word'
     400 |         compiletime_assert(__native_word(t),                            \
         |                            ^~~~~~~~~~~~~
   arch/powerpc/include/asm/barrier.h:82:9: note: in expansion of macro 'compiletime_assert_atomic_type'
      82 |         compiletime_assert_atomic_type(*p);                             \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/barrier.h:176:29: note: in expansion of macro '__smp_load_acquire'
     176 | #define smp_load_acquire(p) __smp_load_acquire(p)
         |                             ^~~~~~~~~~~~~~~~~~
   kernel/rcu/srcutree.c:1907:36: note: in expansion of macro 'smp_load_acquire'
    1907 |                 if (!rcu_seq_state(smp_load_acquire(&ssp->srcu_sup->srcu_gp_seq_needed)) &&
         |                                    ^~~~~~~~~~~~~~~~
   In file included from arch/powerpc/include/asm/bug.h:159,
                    from include/linux/bug.h:5,
                    from include/linux/fortify-string.h:5,
                    from include/linux/string.h:254,
                    from include/linux/bitmap.h:11,
                    from include/linux/cpumask.h:12,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/mutex.h:17:
>> kernel/rcu/srcutree.c:1908:49: error: 'struct srcu_usage' has no member named 'sda_is_static'
    1908 |                     !WARN_ON_ONCE(!ssp->srcu_sup->sda_is_static))
         |                                                 ^~
   include/asm-generic/bug.h:110:32: note: in definition of macro 'WARN_ON_ONCE'
     110 |         int __ret_warn_on = !!(condition);                      \
         |                                ^~~~~~~~~


vim +1907 kernel/rcu/srcutree.c

fe15b50cdeeebd Paul E. McKenney 2019-04-05  1897  
fe15b50cdeeebd Paul E. McKenney 2019-04-05  1898  /* Clean up any global-scope srcu_struct structures used by this module. */
fe15b50cdeeebd Paul E. McKenney 2019-04-05  1899  static void srcu_module_going(struct module *mod)
fe15b50cdeeebd Paul E. McKenney 2019-04-05  1900  {
fe15b50cdeeebd Paul E. McKenney 2019-04-05  1901  	int i;
7a8ec79485d274 Paul E. McKenney 2023-03-17  1902  	struct srcu_struct *ssp;
fe15b50cdeeebd Paul E. McKenney 2019-04-05  1903  	struct srcu_struct **sspp = mod->srcu_struct_ptrs;
fe15b50cdeeebd Paul E. McKenney 2019-04-05  1904  
7a8ec79485d274 Paul E. McKenney 2023-03-17  1905  	for (i = 0; i < mod->num_srcu_structs; i++) {
7a8ec79485d274 Paul E. McKenney 2023-03-17  1906  		ssp = *(sspp++);
7a8ec79485d274 Paul E. McKenney 2023-03-17 @1907  		if (!rcu_seq_state(smp_load_acquire(&ssp->srcu_sup->srcu_gp_seq_needed)) &&
7a8ec79485d274 Paul E. McKenney 2023-03-17 @1908  		    !WARN_ON_ONCE(!ssp->srcu_sup->sda_is_static))
7a8ec79485d274 Paul E. McKenney 2023-03-17  1909  			cleanup_srcu_struct(ssp);
7a8ec79485d274 Paul E. McKenney 2023-03-17  1910  		free_percpu(ssp->sda);
7a8ec79485d274 Paul E. McKenney 2023-03-17  1911  	}
fe15b50cdeeebd Paul E. McKenney 2019-04-05  1912  }
fe15b50cdeeebd Paul E. McKenney 2019-04-05  1913  

:::::: The code at line 1907 was first introduced by commit
:::::: 7a8ec79485d27415fdc6ffb5bcb2d71626e3c8fb srcu: Use static init for statically allocated in-module srcu_struct

:::::: TO: Paul E. McKenney <paulmck@kernel.org>
:::::: CC: Paul E. McKenney <paulmck@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
