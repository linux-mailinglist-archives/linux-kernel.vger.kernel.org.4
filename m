Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8BDC6C88FB
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 00:05:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231810AbjCXXFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 19:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjCXXFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 19:05:48 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54113144A2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 16:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679699145; x=1711235145;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=mjuZ5Z6nrEyR/rT5pe8lgCWtmKcz5KNl/7wphOBynHM=;
  b=n8jhk2Ce2b4E+uckChLZKKrTa8zFKxzVUGa2Ddh5cUcHzF26REzgCZil
   IqFQuh7J6NRsMTHwjPCCZ966LsyH0YhGro6o4yeAqJDJNmhYq2bwWAzcD
   69h6qtikvCgElNFby4H4BmNMFSW+s/ueEKYO6i9zaWVEN5Qejf8F2DuBR
   PsDZtbOOgaIjJzJAW+1CtqkmXa20ErsrKPN7B31+MWWn7Xb14YvtwKxPm
   q88e3DY2i62ArqDsWp+pnQ6FcswXvkz4xl8M5j7tsZaAdYsRE/ghW+cmI
   289b5tApiDlWGv5ypQCVPphBYMLg5gm6PKDwAs9qY2IiXyY//Z9p0q7cq
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="404829489"
X-IronPort-AV: E=Sophos;i="5.98,289,1673942400"; 
   d="scan'208";a="404829489"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 16:05:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="752051124"
X-IronPort-AV: E=Sophos;i="5.98,289,1673942400"; 
   d="scan'208";a="752051124"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 24 Mar 2023 16:05:42 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pfqTY-000Fjh-2c;
        Fri, 24 Mar 2023 23:05:36 +0000
Date:   Sat, 25 Mar 2023 07:05:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/fsfa3 17/17] include/asm-generic/rwonce.h:44:26:
 warning: array subscript 0 is outside array bounds of 'const volatile
 int[0]'
Message-ID: <202303250644.7mtCknON-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-0.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/fsfa3
head:   2226ddb6a576f7f89a8a06a3f89b68f5109ded53
commit: 2226ddb6a576f7f89a8a06a3f89b68f5109ded53 [17/17] Makefile: Enable -Wstringop-overflow and -Warray-bounds
config: s390-defconfig (https://download.01.org/0day-ci/archive/20230325/202303250644.7mtCknON-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git/commit/?id=2226ddb6a576f7f89a8a06a3f89b68f5109ded53
        git remote add gustavoars https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git
        git fetch --no-tags gustavoars testing/fsfa3
        git checkout 2226ddb6a576f7f89a8a06a3f89b68f5109ded53
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=s390 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash arch/s390/kernel/ fs/autofs/ fs/cifs/ kernel/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303250644.7mtCknON-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/exit.c:1915:32: warning: no previous prototype for 'abort' [-Wmissing-prototypes]
    1915 | __weak __function_aligned void abort(void)
         |                                ^~~~~
   In file included from arch/s390/include/asm/rwonce.h:29,
                    from include/linux/compiler.h:247,
                    from arch/s390/include/asm/bug.h:5,
                    from include/linux/bug.h:5,
                    from include/linux/mmdebug.h:5,
                    from include/linux/mm.h:6,
                    from kernel/exit.c:8:
   In function 'preempt_count',
       inlined from 'make_task_dead' at kernel/exit.c:938:6:
>> include/asm-generic/rwonce.h:44:26: warning: array subscript 0 is outside array bounds of 'const volatile int[0]' [-Warray-bounds]
      44 | #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(x) *)&(x))
         |                         ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:50:9: note: in expansion of macro '__READ_ONCE'
      50 |         __READ_ONCE(x);                                                 \
         |         ^~~~~~~~~~~
   arch/s390/include/asm/preempt.h:17:16: note: in expansion of macro 'READ_ONCE'
      17 |         return READ_ONCE(S390_lowcore.preempt_count) & ~PREEMPT_NEED_RESCHED;
         |                ^~~~~~~~~
   In function 'preempt_count',
       inlined from 'make_task_dead' at kernel/exit.c:938:6:
>> include/asm-generic/rwonce.h:44:26: warning: array subscript 0 is outside array bounds of 'const volatile int[0]' [-Warray-bounds]
      44 | #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(x) *)&(x))
         |                         ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:50:9: note: in expansion of macro '__READ_ONCE'
      50 |         __READ_ONCE(x);                                                 \
         |         ^~~~~~~~~~~
   arch/s390/include/asm/preempt.h:17:16: note: in expansion of macro 'READ_ONCE'
      17 |         return READ_ONCE(S390_lowcore.preempt_count) & ~PREEMPT_NEED_RESCHED;
         |                ^~~~~~~~~
   In function 'preempt_count',
       inlined from 'make_task_dead' at kernel/exit.c:938:6:
>> include/asm-generic/rwonce.h:44:26: warning: array subscript 0 is outside array bounds of 'const volatile int[0]' [-Warray-bounds]
      44 | #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(x) *)&(x))
         |                         ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:50:9: note: in expansion of macro '__READ_ONCE'
      50 |         __READ_ONCE(x);                                                 \
         |         ^~~~~~~~~~~
   arch/s390/include/asm/preempt.h:17:16: note: in expansion of macro 'READ_ONCE'
      17 |         return READ_ONCE(S390_lowcore.preempt_count) & ~PREEMPT_NEED_RESCHED;
         |                ^~~~~~~~~
   In function 'preempt_count',
       inlined from 'make_task_dead' at kernel/exit.c:948:6:
>> include/asm-generic/rwonce.h:44:26: warning: array subscript 0 is outside array bounds of 'const volatile int[0]' [-Warray-bounds]
      44 | #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(x) *)&(x))
         |                         ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:50:9: note: in expansion of macro '__READ_ONCE'
      50 |         __READ_ONCE(x);                                                 \
         |         ^~~~~~~~~~~
   arch/s390/include/asm/preempt.h:17:16: note: in expansion of macro 'READ_ONCE'
      17 |         return READ_ONCE(S390_lowcore.preempt_count) & ~PREEMPT_NEED_RESCHED;
         |                ^~~~~~~~~
   In function 'preempt_count',
       inlined from 'make_task_dead' at kernel/exit.c:949:3:
>> include/asm-generic/rwonce.h:44:26: warning: array subscript 0 is outside array bounds of 'const volatile int[0]' [-Warray-bounds]
      44 | #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(x) *)&(x))
         |                         ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:50:9: note: in expansion of macro '__READ_ONCE'
      50 |         __READ_ONCE(x);                                                 \
         |         ^~~~~~~~~~~
   arch/s390/include/asm/preempt.h:17:16: note: in expansion of macro 'READ_ONCE'
      17 |         return READ_ONCE(S390_lowcore.preempt_count) & ~PREEMPT_NEED_RESCHED;
         |                ^~~~~~~~~
   In function 'preempt_count_set',
       inlined from 'make_task_dead' at kernel/exit.c:952:3:
>> include/asm-generic/rwonce.h:44:26: warning: array subscript 0 is outside array bounds of 'const volatile int[0]' [-Warray-bounds]
      44 | #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(x) *)&(x))
         |                         ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:50:9: note: in expansion of macro '__READ_ONCE'
      50 |         __READ_ONCE(x);                                                 \
         |         ^~~~~~~~~~~
   arch/s390/include/asm/preempt.h:25:23: note: in expansion of macro 'READ_ONCE'
      25 |                 old = READ_ONCE(S390_lowcore.preempt_count);
         |                       ^~~~~~~~~
   In file included from arch/s390/include/asm/bitops.h:39,
                    from include/linux/bitops.h:68,
                    from include/linux/thread_info.h:27,
                    from arch/s390/include/asm/preempt.h:6,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:56,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:7,
                    from include/linux/mm.h:7:
   In function '__atomic_cmpxchg',
       inlined from 'preempt_count_set' at arch/s390/include/asm/preempt.h:28:11,
       inlined from 'make_task_dead' at kernel/exit.c:952:3:
   arch/s390/include/asm/atomic_ops.h:159:9: warning: array subscript 0 is outside array bounds of 'int[0]' [-Warray-bounds]
     159 |         asm volatile(
         |         ^~~
   arch/s390/include/asm/atomic_ops.h:159:9: warning: array subscript 0 is outside array bounds of 'int[0]' [-Warray-bounds]
--
   In file included from arch/s390/include/asm/rwonce.h:29,
                    from include/linux/compiler.h:247,
                    from include/linux/build_bug.h:5,
                    from include/linux/container_of.h:5,
                    from include/linux/list.h:5,
                    from include/linux/smp.h:12,
                    from include/linux/kernel_stat.h:5,
                    from kernel/softirq.c:13:
   In function 'preempt_count',
       inlined from 'tasklet_kill' at kernel/softirq.c:878:6:
>> include/asm-generic/rwonce.h:44:26: warning: array subscript 0 is outside array bounds of 'const volatile int[0]' [-Warray-bounds]
      44 | #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(x) *)&(x))
         |                         ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:50:9: note: in expansion of macro '__READ_ONCE'
      50 |         __READ_ONCE(x);                                                 \
         |         ^~~~~~~~~~~
   arch/s390/include/asm/preempt.h:17:16: note: in expansion of macro 'READ_ONCE'
      17 |         return READ_ONCE(S390_lowcore.preempt_count) & ~PREEMPT_NEED_RESCHED;
         |                ^~~~~~~~~
   In function 'preempt_count',
       inlined from 'tasklet_kill' at kernel/softirq.c:878:6:
>> include/asm-generic/rwonce.h:44:26: warning: array subscript 0 is outside array bounds of 'const volatile int[0]' [-Warray-bounds]
      44 | #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(x) *)&(x))
         |                         ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:50:9: note: in expansion of macro '__READ_ONCE'
      50 |         __READ_ONCE(x);                                                 \
         |         ^~~~~~~~~~~
   arch/s390/include/asm/preempt.h:17:16: note: in expansion of macro 'READ_ONCE'
      17 |         return READ_ONCE(S390_lowcore.preempt_count) & ~PREEMPT_NEED_RESCHED;
         |                ^~~~~~~~~
   In function 'preempt_count',
       inlined from 'tasklet_kill' at kernel/softirq.c:878:6:
>> include/asm-generic/rwonce.h:44:26: warning: array subscript 0 is outside array bounds of 'const volatile int[0]' [-Warray-bounds]
      44 | #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(x) *)&(x))
         |                         ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:50:9: note: in expansion of macro '__READ_ONCE'
      50 |         __READ_ONCE(x);                                                 \
         |         ^~~~~~~~~~~
   arch/s390/include/asm/preempt.h:17:16: note: in expansion of macro 'READ_ONCE'
      17 |         return READ_ONCE(S390_lowcore.preempt_count) & ~PREEMPT_NEED_RESCHED;
         |                ^~~~~~~~~
   In function 'preempt_count',
       inlined from '_local_bh_enable' at kernel/softirq.c:368:2:
>> include/asm-generic/rwonce.h:44:26: warning: array subscript 0 is outside array bounds of 'const volatile int[0]' [-Warray-bounds]
      44 | #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(x) *)&(x))
         |                         ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:50:9: note: in expansion of macro '__READ_ONCE'
      50 |         __READ_ONCE(x);                                                 \
         |         ^~~~~~~~~~~
   arch/s390/include/asm/preempt.h:17:16: note: in expansion of macro 'READ_ONCE'
      17 |         return READ_ONCE(S390_lowcore.preempt_count) & ~PREEMPT_NEED_RESCHED;
         |                ^~~~~~~~~
   In function 'preempt_count',
       inlined from '__local_bh_enable' at kernel/softirq.c:353:6,
       inlined from '_local_bh_enable' at kernel/softirq.c:369:2:
>> include/asm-generic/rwonce.h:44:26: warning: array subscript 0 is outside array bounds of 'const volatile int[0]' [-Warray-bounds]
      44 | #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(x) *)&(x))
         |                         ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:50:9: note: in expansion of macro '__READ_ONCE'
      50 |         __READ_ONCE(x);                                                 \
         |         ^~~~~~~~~~~
   arch/s390/include/asm/preempt.h:17:16: note: in expansion of macro 'READ_ONCE'
      17 |         return READ_ONCE(S390_lowcore.preempt_count) & ~PREEMPT_NEED_RESCHED;
         |                ^~~~~~~~~
   In function 'preempt_count',
       inlined from '__local_bh_enable' at kernel/softirq.c:356:6,
       inlined from '_local_bh_enable' at kernel/softirq.c:369:2:
>> include/asm-generic/rwonce.h:44:26: warning: array subscript 0 is outside array bounds of 'const volatile int[0]' [-Warray-bounds]
      44 | #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(x) *)&(x))
         |                         ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:50:9: note: in expansion of macro '__READ_ONCE'
      50 |         __READ_ONCE(x);                                                 \
         |         ^~~~~~~~~~~
   arch/s390/include/asm/preempt.h:17:16: note: in expansion of macro 'READ_ONCE'
      17 |         return READ_ONCE(S390_lowcore.preempt_count) & ~PREEMPT_NEED_RESCHED;
         |                ^~~~~~~~~
   In file included from arch/s390/include/asm/bitops.h:39,
                    from include/linux/bitops.h:68,
                    from include/linux/kernel.h:22,
                    from include/linux/cpumask.h:10,
                    from include/linux/smp.h:13:
   In function '__atomic_add',
       inlined from '__preempt_count_add' at arch/s390/include/asm/preempt.h:59:2,
       inlined from '__preempt_count_sub' at arch/s390/include/asm/preempt.h:64:2,
       inlined from '__local_bh_enable' at kernel/softirq.c:359:2,
       inlined from '_local_bh_enable' at kernel/softirq.c:369:2:
   arch/s390/include/asm/atomic_ops.h:52:9: warning: array subscript 0 is outside array bounds of 'int[0]' [-Warray-bounds]
      52 |         asm volatile(                                                   \
         |         ^~~
   arch/s390/include/asm/atomic_ops.h:61:9: note: in expansion of macro '__ATOMIC_OP'
      61 |         __ATOMIC_OP(op_name, op_type, op_string, "\n")                  \
         |         ^~~~~~~~~~~
   arch/s390/include/asm/atomic_ops.h:64:1: note: in expansion of macro '__ATOMIC_OPS'
      64 | __ATOMIC_OPS(__atomic_add, int, "laa")
         | ^~~~~~~~~~~~
   arch/s390/include/asm/atomic_ops.h:52:9: warning: array subscript 0 is outside array bounds of 'int[0]' [-Warray-bounds]
      52 |         asm volatile(                                                   \
         |         ^~~
   arch/s390/include/asm/atomic_ops.h:61:9: note: in expansion of macro '__ATOMIC_OP'
      61 |         __ATOMIC_OP(op_name, op_type, op_string, "\n")                  \
         |         ^~~~~~~~~~~
   arch/s390/include/asm/atomic_ops.h:64:1: note: in expansion of macro '__ATOMIC_OPS'
      64 | __ATOMIC_OPS(__atomic_add, int, "laa")
         | ^~~~~~~~~~~~
   In function '__atomic_add',
       inlined from '__preempt_count_add' at arch/s390/include/asm/preempt.h:59:2,
       inlined from '__local_bh_disable_ip' at include/linux/bottom_half.h:13:2,
       inlined from 'softirq_handle_begin' at kernel/softirq.c:409:2,
       inlined from '__do_softirq' at kernel/softirq.c:547:2:
   arch/s390/include/asm/atomic_ops.h:52:9: warning: array subscript 0 is outside array bounds of 'int[0]' [-Warray-bounds]
      52 |         asm volatile(                                                   \
         |         ^~~
   arch/s390/include/asm/atomic_ops.h:61:9: note: in expansion of macro '__ATOMIC_OP'
      61 |         __ATOMIC_OP(op_name, op_type, op_string, "\n")                  \
         |         ^~~~~~~~~~~
   arch/s390/include/asm/atomic_ops.h:64:1: note: in expansion of macro '__ATOMIC_OPS'
      64 | __ATOMIC_OPS(__atomic_add, int, "laa")
         | ^~~~~~~~~~~~
   arch/s390/include/asm/atomic_ops.h:52:9: warning: array subscript 0 is outside array bounds of 'int[0]' [-Warray-bounds]
      52 |         asm volatile(                                                   \
         |         ^~~
   arch/s390/include/asm/atomic_ops.h:61:9: note: in expansion of macro '__ATOMIC_OP'
      61 |         __ATOMIC_OP(op_name, op_type, op_string, "\n")                  \
         |         ^~~~~~~~~~~
   arch/s390/include/asm/atomic_ops.h:64:1: note: in expansion of macro '__ATOMIC_OPS'
      64 | __ATOMIC_OPS(__atomic_add, int, "laa")
         | ^~~~~~~~~~~~
   In function 'preempt_count',
       inlined from '__do_softirq' at kernel/softirq.c:566:16:
>> include/asm-generic/rwonce.h:44:26: warning: array subscript 0 is outside array bounds of 'const volatile int[0]' [-Warray-bounds]
      44 | #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(x) *)&(x))
         |                         ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:50:9: note: in expansion of macro '__READ_ONCE'
      50 |         __READ_ONCE(x);                                                 \
         |         ^~~~~~~~~~~
   arch/s390/include/asm/preempt.h:17:16: note: in expansion of macro 'READ_ONCE'
      17 |         return READ_ONCE(S390_lowcore.preempt_count) & ~PREEMPT_NEED_RESCHED;
         |                ^~~~~~~~~
   In function 'preempt_count',
       inlined from '__do_softirq' at kernel/softirq.c:573:7:
>> include/asm-generic/rwonce.h:44:26: warning: array subscript 0 is outside array bounds of 'const volatile int[0]' [-Warray-bounds]
      44 | #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(x) *)&(x))
         |                         ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:50:9: note: in expansion of macro '__READ_ONCE'
      50 |         __READ_ONCE(x);                                                 \
         |         ^~~~~~~~~~~
   arch/s390/include/asm/preempt.h:17:16: note: in expansion of macro 'READ_ONCE'
      17 |         return READ_ONCE(S390_lowcore.preempt_count) & ~PREEMPT_NEED_RESCHED;
         |                ^~~~~~~~~
   In function 'preempt_count',
       inlined from '__do_softirq' at kernel/softirq.c:574:4:
>> include/asm-generic/rwonce.h:44:26: warning: array subscript 0 is outside array bounds of 'const volatile int[0]' [-Warray-bounds]
      44 | #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(x) *)&(x))
         |                         ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:50:9: note: in expansion of macro '__READ_ONCE'
      50 |         __READ_ONCE(x);                                                 \
         |         ^~~~~~~~~~~
   arch/s390/include/asm/preempt.h:17:16: note: in expansion of macro 'READ_ONCE'
      17 |         return READ_ONCE(S390_lowcore.preempt_count) & ~PREEMPT_NEED_RESCHED;
         |                ^~~~~~~~~
   In function 'preempt_count_set',
       inlined from '__do_softirq' at kernel/softirq.c:577:4:
>> include/asm-generic/rwonce.h:44:26: warning: array subscript 0 is outside array bounds of 'const volatile int[0]' [-Warray-bounds]
      44 | #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(x) *)&(x))
         |                         ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:50:9: note: in expansion of macro '__READ_ONCE'
      50 |         __READ_ONCE(x);                                                 \
         |         ^~~~~~~~~~~
   arch/s390/include/asm/preempt.h:25:23: note: in expansion of macro 'READ_ONCE'
      25 |                 old = READ_ONCE(S390_lowcore.preempt_count);
         |                       ^~~~~~~~~
   In function '__atomic_cmpxchg',
       inlined from 'preempt_count_set' at arch/s390/include/asm/preempt.h:28:11,
       inlined from '__do_softirq' at kernel/softirq.c:577:4:
   arch/s390/include/asm/atomic_ops.h:159:9: warning: array subscript 0 is outside array bounds of 'int[0]' [-Warray-bounds]
     159 |         asm volatile(
         |         ^~~
   arch/s390/include/asm/atomic_ops.h:159:9: warning: array subscript 0 is outside array bounds of 'int[0]' [-Warray-bounds]
   In function 'preempt_count',
       inlined from '__local_bh_enable' at kernel/softirq.c:353:6,
       inlined from 'softirq_handle_end' at kernel/softirq.c:414:2,
       inlined from '__do_softirq' at kernel/softirq.c:600:2:
>> include/asm-generic/rwonce.h:44:26: warning: array subscript 0 is outside array bounds of 'const volatile int[0]' [-Warray-bounds]
      44 | #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(x) *)&(x))
         |                         ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:50:9: note: in expansion of macro '__READ_ONCE'
      50 |         __READ_ONCE(x);                                                 \
         |         ^~~~~~~~~~~
   arch/s390/include/asm/preempt.h:17:16: note: in expansion of macro 'READ_ONCE'
      17 |         return READ_ONCE(S390_lowcore.preempt_count) & ~PREEMPT_NEED_RESCHED;
         |                ^~~~~~~~~
   In function 'preempt_count',
       inlined from '__local_bh_enable' at kernel/softirq.c:356:6,
       inlined from 'softirq_handle_end' at kernel/softirq.c:414:2,
       inlined from '__do_softirq' at kernel/softirq.c:600:2:
>> include/asm-generic/rwonce.h:44:26: warning: array subscript 0 is outside array bounds of 'const volatile int[0]' [-Warray-bounds]
      44 | #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(x) *)&(x))
         |                         ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:50:9: note: in expansion of macro '__READ_ONCE'
      50 |         __READ_ONCE(x);                                                 \
         |         ^~~~~~~~~~~
   arch/s390/include/asm/preempt.h:17:16: note: in expansion of macro 'READ_ONCE'
      17 |         return READ_ONCE(S390_lowcore.preempt_count) & ~PREEMPT_NEED_RESCHED;
         |                ^~~~~~~~~
   In function '__atomic_add',
       inlined from '__preempt_count_add' at arch/s390/include/asm/preempt.h:59:2,
       inlined from '__preempt_count_sub' at arch/s390/include/asm/preempt.h:64:2,
       inlined from '__local_bh_enable' at kernel/softirq.c:359:2,
       inlined from 'softirq_handle_end' at kernel/softirq.c:414:2,
       inlined from '__do_softirq' at kernel/softirq.c:600:2:
   arch/s390/include/asm/atomic_ops.h:52:9: warning: array subscript 0 is outside array bounds of 'int[0]' [-Warray-bounds]
      52 |         asm volatile(                                                   \
         |         ^~~
   arch/s390/include/asm/atomic_ops.h:61:9: note: in expansion of macro '__ATOMIC_OP'
      61 |         __ATOMIC_OP(op_name, op_type, op_string, "\n")                  \
         |         ^~~~~~~~~~~
   arch/s390/include/asm/atomic_ops.h:64:1: note: in expansion of macro '__ATOMIC_OPS'
      64 | __ATOMIC_OPS(__atomic_add, int, "laa")
         | ^~~~~~~~~~~~
   arch/s390/include/asm/atomic_ops.h:52:9: warning: array subscript 0 is outside array bounds of 'int[0]' [-Warray-bounds]
      52 |         asm volatile(                                                   \
         |         ^~~
   arch/s390/include/asm/atomic_ops.h:61:9: note: in expansion of macro '__ATOMIC_OP'
      61 |         __ATOMIC_OP(op_name, op_type, op_string, "\n")                  \
         |         ^~~~~~~~~~~
   arch/s390/include/asm/atomic_ops.h:64:1: note: in expansion of macro '__ATOMIC_OPS'
      64 | __ATOMIC_OPS(__atomic_add, int, "laa")
         | ^~~~~~~~~~~~
   In function 'preempt_count',
       inlined from 'softirq_handle_end' at kernel/softirq.c:415:2,
       inlined from '__do_softirq' at kernel/softirq.c:600:2:
>> include/asm-generic/rwonce.h:44:26: warning: array subscript 0 is outside array bounds of 'const volatile int[0]' [-Warray-bounds]
      44 | #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(x) *)&(x))
         |                         ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:50:9: note: in expansion of macro '__READ_ONCE'
      50 |         __READ_ONCE(x);                                                 \
         |         ^~~~~~~~~~~
   arch/s390/include/asm/preempt.h:17:16: note: in expansion of macro 'READ_ONCE'
      17 |         return READ_ONCE(S390_lowcore.preempt_count) & ~PREEMPT_NEED_RESCHED;
         |                ^~~~~~~~~
   In function 'preempt_count',
       inlined from 'softirq_handle_end' at kernel/softirq.c:415:2,
       inlined from '__do_softirq' at kernel/softirq.c:600:2:
>> include/asm-generic/rwonce.h:44:26: warning: array subscript 0 is outside array bounds of 'const volatile int[0]' [-Warray-bounds]
      44 | #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(x) *)&(x))
         |                         ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:50:9: note: in expansion of macro '__READ_ONCE'
      50 |         __READ_ONCE(x);                                                 \
         |         ^~~~~~~~~~~
   arch/s390/include/asm/preempt.h:17:16: note: in expansion of macro 'READ_ONCE'
      17 |         return READ_ONCE(S390_lowcore.preempt_count) & ~PREEMPT_NEED_RESCHED;
         |                ^~~~~~~~~
   In function 'preempt_count',
       inlined from 'softirq_handle_end' at kernel/softirq.c:415:2,
       inlined from '__do_softirq' at kernel/softirq.c:600:2:
>> include/asm-generic/rwonce.h:44:26: warning: array subscript 0 is outside array bounds of 'const volatile int[0]' [-Warray-bounds]
      44 | #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(x) *)&(x))
         |                         ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:50:9: note: in expansion of macro '__READ_ONCE'
      50 |         __READ_ONCE(x);                                                 \
         |         ^~~~~~~~~~~
   arch/s390/include/asm/preempt.h:17:16: note: in expansion of macro 'READ_ONCE'
      17 |         return READ_ONCE(S390_lowcore.preempt_count) & ~PREEMPT_NEED_RESCHED;
         |                ^~~~~~~~~
   In function 'preempt_count',
       inlined from 'do_softirq' at kernel/softirq.c:464:6:
>> include/asm-generic/rwonce.h:44:26: warning: array subscript 0 is outside array bounds of 'const volatile int[0]' [-Warray-bounds]
      44 | #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(x) *)&(x))
         |                         ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:50:9: note: in expansion of macro '__READ_ONCE'
      50 |         __READ_ONCE(x);                                                 \
         |         ^~~~~~~~~~~
   arch/s390/include/asm/preempt.h:17:16: note: in expansion of macro 'READ_ONCE'
      17 |         return READ_ONCE(S390_lowcore.preempt_count) & ~PREEMPT_NEED_RESCHED;
         |                ^~~~~~~~~
   In function 'preempt_count',
       inlined from 'do_softirq' at kernel/softirq.c:464:6:
>> include/asm-generic/rwonce.h:44:26: warning: array subscript 0 is outside array bounds of 'const volatile int[0]' [-Warray-bounds]
      44 | #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(x) *)&(x))
         |                         ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:50:9: note: in expansion of macro '__READ_ONCE'
      50 |         __READ_ONCE(x);                                                 \
         |         ^~~~~~~~~~~
   arch/s390/include/asm/preempt.h:17:16: note: in expansion of macro 'READ_ONCE'
      17 |         return READ_ONCE(S390_lowcore.preempt_count) & ~PREEMPT_NEED_RESCHED;
         |                ^~~~~~~~~
   In function 'preempt_count',
       inlined from 'do_softirq' at kernel/softirq.c:464:6:
>> include/asm-generic/rwonce.h:44:26: warning: array subscript 0 is outside array bounds of 'const volatile int[0]' [-Warray-bounds]
      44 | #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(x) *)&(x))
         |                         ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:50:9: note: in expansion of macro '__READ_ONCE'
      50 |         __READ_ONCE(x);                                                 \
         |         ^~~~~~~~~~~
   arch/s390/include/asm/preempt.h:17:16: note: in expansion of macro 'READ_ONCE'
      17 |         return READ_ONCE(S390_lowcore.preempt_count) & ~PREEMPT_NEED_RESCHED;
         |                ^~~~~~~~~
   In function 'preempt_count',
       inlined from '__local_bh_enable_ip' at kernel/softirq.c:375:2:
>> include/asm-generic/rwonce.h:44:26: warning: array subscript 0 is outside array bounds of 'const volatile int[0]' [-Warray-bounds]
      44 | #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(x) *)&(x))
         |                         ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:50:9: note: in expansion of macro '__READ_ONCE'
      50 |         __READ_ONCE(x);                                                 \
         |         ^~~~~~~~~~~
   arch/s390/include/asm/preempt.h:17:16: note: in expansion of macro 'READ_ONCE'
      17 |         return READ_ONCE(S390_lowcore.preempt_count) & ~PREEMPT_NEED_RESCHED;
         |                ^~~~~~~~~
   In function 'preempt_count',
       inlined from '__local_bh_enable_ip' at kernel/softirq.c:383:6:
>> include/asm-generic/rwonce.h:44:26: warning: array subscript 0 is outside array bounds of 'const volatile int[0]' [-Warray-bounds]
      44 | #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(x) *)&(x))
         |                         ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:50:9: note: in expansion of macro '__READ_ONCE'
      50 |         __READ_ONCE(x);                                                 \
         |         ^~~~~~~~~~~
   arch/s390/include/asm/preempt.h:17:16: note: in expansion of macro 'READ_ONCE'
      17 |         return READ_ONCE(S390_lowcore.preempt_count) & ~PREEMPT_NEED_RESCHED;
         |                ^~~~~~~~~
   In function '__atomic_add',
       inlined from '__preempt_count_add' at arch/s390/include/asm/preempt.h:59:2,
       inlined from '__preempt_count_sub' at arch/s390/include/asm/preempt.h:64:2,
       inlined from '__local_bh_enable_ip' at kernel/softirq.c:389:2:
   arch/s390/include/asm/atomic_ops.h:52:9: warning: array subscript 0 is outside array bounds of 'int[0]' [-Warray-bounds]
      52 |         asm volatile(                                                   \
         |         ^~~
   arch/s390/include/asm/atomic_ops.h:61:9: note: in expansion of macro '__ATOMIC_OP'
      61 |         __ATOMIC_OP(op_name, op_type, op_string, "\n")                  \
         |         ^~~~~~~~~~~
   arch/s390/include/asm/atomic_ops.h:64:1: note: in expansion of macro '__ATOMIC_OPS'
      64 | __ATOMIC_OPS(__atomic_add, int, "laa")
         | ^~~~~~~~~~~~
   arch/s390/include/asm/atomic_ops.h:52:9: warning: array subscript 0 is outside array bounds of 'int[0]' [-Warray-bounds]
      52 |         asm volatile(                                                   \
         |         ^~~
   arch/s390/include/asm/atomic_ops.h:61:9: note: in expansion of macro '__ATOMIC_OP'
      61 |         __ATOMIC_OP(op_name, op_type, op_string, "\n")                  \
         |         ^~~~~~~~~~~
   arch/s390/include/asm/atomic_ops.h:64:1: note: in expansion of macro '__ATOMIC_OPS'
      64 | __ATOMIC_OPS(__atomic_add, int, "laa")
         | ^~~~~~~~~~~~
   In function 'preempt_count',
       inlined from '__local_bh_enable_ip' at kernel/softirq.c:391:6:
   include/asm-generic/rwonce.h:44:26: warning: array subscript 0 is outside array bounds of 'const volatile int[0]' [-Warray-bounds]
      44 | #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(x) *)&(x))
         |                         ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:50:9: note: in expansion of macro '__READ_ONCE'
      50 |         __READ_ONCE(x);                                                 \
         |         ^~~~~~~~~~~
   arch/s390/include/asm/preempt.h:17:16: note: in expansion of macro 'READ_ONCE'
      17 |         return READ_ONCE(S390_lowcore.preempt_count) & ~PREEMPT_NEED_RESCHED;
         |                ^~~~~~~~~
   In function 'preempt_count',
       inlined from '__local_bh_enable_ip' at kernel/softirq.c:391:6:
   include/asm-generic/rwonce.h:44:26: warning: array subscript 0 is outside array bounds of 'const volatile int[0]' [-Warray-bounds]
      44 | #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(x) *)&(x))
         |                         ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:50:9: note: in expansion of macro '__READ_ONCE'
      50 |         __READ_ONCE(x);                                                 \
         |         ^~~~~~~~~~~
   arch/s390/include/asm/preempt.h:17:16: note: in expansion of macro 'READ_ONCE'
      17 |         return READ_ONCE(S390_lowcore.preempt_count) & ~PREEMPT_NEED_RESCHED;
         |                ^~~~~~~~~
   In function 'preempt_count',
       inlined from '__local_bh_enable_ip' at kernel/softirq.c:391:6:
   include/asm-generic/rwonce.h:44:26: warning: array subscript 0 is outside array bounds of 'const volatile int[0]' [-Warray-bounds]
      44 | #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(x) *)&(x))
         |                         ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:50:9: note: in expansion of macro '__READ_ONCE'
      50 |         __READ_ONCE(x);                                                 \
         |         ^~~~~~~~~~~
   arch/s390/include/asm/preempt.h:17:16: note: in expansion of macro 'READ_ONCE'
      17 |         return READ_ONCE(S390_lowcore.preempt_count) & ~PREEMPT_NEED_RESCHED;
         |                ^~~~~~~~~
   In function '__atomic_add_const',
       inlined from '__preempt_count_add' at arch/s390/include/asm/preempt.h:55:4,
       inlined from '__preempt_count_sub' at arch/s390/include/asm/preempt.h:64:2,
       inlined from '__local_bh_enable_ip' at kernel/softirq.c:399:2:
   arch/s390/include/asm/atomic_ops.h:80:9: warning: array subscript 0 is outside array bounds of 'int[0]' [-Warray-bounds]
      80 |         asm volatile(                                                   \
         |         ^~~
   arch/s390/include/asm/atomic_ops.h:87:9: note: in expansion of macro '__ATOMIC_CONST_OP'
      87 |         __ATOMIC_CONST_OP(op_name, op_type, op_string, "\n")            \
         |         ^~~~~~~~~~~~~~~~~
   arch/s390/include/asm/atomic_ops.h:90:1: note: in expansion of macro '__ATOMIC_CONST_OPS'
      90 | __ATOMIC_CONST_OPS(__atomic_add_const, int, "asi")
         | ^~~~~~~~~~~~~~~~~~
   arch/s390/include/asm/atomic_ops.h:80:9: warning: array subscript 0 is outside array bounds of 'int[0]' [-Warray-bounds]
      80 |         asm volatile(                                                   \
         |         ^~~
   arch/s390/include/asm/atomic_ops.h:87:9: note: in expansion of macro '__ATOMIC_CONST_OP'
      87 |         __ATOMIC_CONST_OP(op_name, op_type, op_string, "\n")            \
         |         ^~~~~~~~~~~~~~~~~
   arch/s390/include/asm/atomic_ops.h:90:1: note: in expansion of macro '__ATOMIC_CONST_OPS'
      90 | __ATOMIC_CONST_OPS(__atomic_add_const, int, "asi")
         | ^~~~~~~~~~~~~~~~~~
   In function '__atomic_add',
       inlined from '__preempt_count_add' at arch/s390/include/asm/preempt.h:59:2,
       inlined from 'irq_enter_rcu' at kernel/softirq.c:609:2:
   arch/s390/include/asm/atomic_ops.h:52:9: warning: array subscript 0 is outside array bounds of 'int[0]' [-Warray-bounds]
      52 |         asm volatile(                                                   \
         |         ^~~
   arch/s390/include/asm/atomic_ops.h:61:9: note: in expansion of macro '__ATOMIC_OP'
      61 |         __ATOMIC_OP(op_name, op_type, op_string, "\n")                  \
         |         ^~~~~~~~~~~
   arch/s390/include/asm/atomic_ops.h:64:1: note: in expansion of macro '__ATOMIC_OPS'
      64 | __ATOMIC_OPS(__atomic_add, int, "laa")
         | ^~~~~~~~~~~~
   arch/s390/include/asm/atomic_ops.h:52:9: warning: array subscript 0 is outside array bounds of 'int[0]' [-Warray-bounds]
      52 |         asm volatile(                                                   \
         |         ^~~
..


vim +44 include/asm-generic/rwonce.h

e506ea451254ab Will Deacon 2019-10-15  28  
e506ea451254ab Will Deacon 2019-10-15  29  /*
e506ea451254ab Will Deacon 2019-10-15  30   * Yes, this permits 64-bit accesses on 32-bit architectures. These will
e506ea451254ab Will Deacon 2019-10-15  31   * actually be atomic in some cases (namely Armv7 + LPAE), but for others we
e506ea451254ab Will Deacon 2019-10-15  32   * rely on the access being split into 2x32-bit accesses for a 32-bit quantity
e506ea451254ab Will Deacon 2019-10-15  33   * (e.g. a virtual address) and a strong prevailing wind.
e506ea451254ab Will Deacon 2019-10-15  34   */
e506ea451254ab Will Deacon 2019-10-15  35  #define compiletime_assert_rwonce_type(t)					\
e506ea451254ab Will Deacon 2019-10-15  36  	compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),	\
e506ea451254ab Will Deacon 2019-10-15  37  		"Unsupported access size for {READ,WRITE}_ONCE().")
e506ea451254ab Will Deacon 2019-10-15  38  
e506ea451254ab Will Deacon 2019-10-15  39  /*
e506ea451254ab Will Deacon 2019-10-15  40   * Use __READ_ONCE() instead of READ_ONCE() if you do not require any
3c9184109e78ea Will Deacon 2019-10-30  41   * atomicity. Note that this may result in tears!
e506ea451254ab Will Deacon 2019-10-15  42   */
b78b331a3f5c07 Will Deacon 2019-10-15  43  #ifndef __READ_ONCE
e506ea451254ab Will Deacon 2019-10-15 @44  #define __READ_ONCE(x)	(*(const volatile __unqual_scalar_typeof(x) *)&(x))
b78b331a3f5c07 Will Deacon 2019-10-15  45  #endif
e506ea451254ab Will Deacon 2019-10-15  46  

:::::: The code at line 44 was first introduced by commit
:::::: e506ea451254ab17e0bf918ca36232fec2a9b10c compiler.h: Split {READ,WRITE}_ONCE definitions out into rwonce.h

:::::: TO: Will Deacon <will@kernel.org>
:::::: CC: Will Deacon <will@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
