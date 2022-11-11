Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD9F6261C7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 20:15:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233923AbiKKTP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 14:15:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbiKKTP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 14:15:26 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34904742D8
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 11:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668194122; x=1699730122;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=EOO5eLkHgoG86kiNjdNCJVg1A6P6pQQwenpr3n5zqyw=;
  b=ndWNN4Q0UTXE0ln7qp2HStUy+cvBroGoeXqmxi7b3D/LeklwW/c2foDp
   3mS94+EyZbSwGpwVBDrb26VP39gSZSiU04rw6ItCsoL6cM4nmfDlNsTAt
   bABr36/MxHXlu8bF3yrDE1k9hQZ4bUuNr2CljrMw4c7O1trM5DZiKNJFM
   Ygk1vRVMMsCWTfBiRNHw2EOcKsSdiePhbBc2dEdmtV2uXU/gP+mMRWvxm
   xnKsI+3YnQgOaOcWjppOut5EDQCk8ZhCnPAPb9b2xGEUgXAxgDVCALUsH
   M4aqX+UBEvV+VIhpekaeODPXV9Av/bwEz8Sq7ROu71ggg6Ev3umI2Ej4+
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="338426428"
X-IronPort-AV: E=Sophos;i="5.96,157,1665471600"; 
   d="scan'208";a="338426428"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 11:15:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="668891054"
X-IronPort-AV: E=Sophos;i="5.96,157,1665471600"; 
   d="scan'208";a="668891054"
Received: from lkp-server01.sh.intel.com (HELO e783503266e8) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 11 Nov 2022 11:15:19 -0800
Received: from kbuild by e783503266e8 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1otZUk-0004Dr-1t;
        Fri, 11 Nov 2022 19:15:18 +0000
Date:   Sat, 12 Nov 2022 03:14:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Qing Zhang <zhangqing@loongson.cn>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Huacai Chen <chenhuacai@kernel.org>
Subject: mm/slub.c:486:17: sparse: sparse: incorrect type in argument 1
 (different address spaces)
Message-ID: <202211120317.oJLO04RN-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Pm1R2lLfXX49/sKk"
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        UPPERCASE_50_75 autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Pm1R2lLfXX49/sKk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4bbf3422df78029f03161640dcb1e9d1ed64d1ea
commit: 93a4fa622eb061f75f87f0cf9609ab4e69c67d01 LoongArch: Add STACKTRACE support
date:   3 months ago
config: loongarch-randconfig-s052-20221111
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
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=loongarch SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> mm/slub.c:486:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   mm/slub.c:486:17: sparse:     expected void *ptr
   mm/slub.c:486:17: sparse:     got unsigned int [noderef] __percpu *
>> mm/slub.c:486:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   mm/slub.c:486:17: sparse:     expected void *ptr
   mm/slub.c:486:17: sparse:     got unsigned int [noderef] __percpu *
>> mm/slub.c:486:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   mm/slub.c:486:17: sparse:     expected void *ptr
   mm/slub.c:486:17: sparse:     got unsigned int [noderef] __percpu *
>> mm/slub.c:486:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   mm/slub.c:486:17: sparse:     expected void *ptr
   mm/slub.c:486:17: sparse:     got unsigned int [noderef] __percpu *
>> mm/slub.c:486:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   mm/slub.c:486:17: sparse:     expected void *ptr
   mm/slub.c:486:17: sparse:     got int [noderef] __percpu *
>> mm/slub.c:486:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   mm/slub.c:486:17: sparse:     expected void *ptr
   mm/slub.c:486:17: sparse:     got int [noderef] __percpu *
>> mm/slub.c:486:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   mm/slub.c:486:17: sparse:     expected void *ptr
   mm/slub.c:486:17: sparse:     got int [noderef] __percpu *
>> mm/slub.c:486:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   mm/slub.c:486:17: sparse:     expected void *ptr
   mm/slub.c:486:17: sparse:     got int [noderef] __percpu *
   mm/slub.c:2475:9: sparse: sparse: context imbalance in 'deactivate_slab' - different lock contexts for basic block
>> mm/slub.c:486:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   mm/slub.c:486:17: sparse:     expected void *ptr
   mm/slub.c:486:17: sparse:     got unsigned int [noderef] __percpu *
>> mm/slub.c:486:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   mm/slub.c:486:17: sparse:     expected void *ptr
   mm/slub.c:486:17: sparse:     got unsigned int [noderef] __percpu *
>> mm/slub.c:486:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   mm/slub.c:486:17: sparse:     expected void *ptr
   mm/slub.c:486:17: sparse:     got unsigned int [noderef] __percpu *
>> mm/slub.c:486:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   mm/slub.c:486:17: sparse:     expected void *ptr
   mm/slub.c:486:17: sparse:     got unsigned int [noderef] __percpu *
>> mm/slub.c:486:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   mm/slub.c:486:17: sparse:     expected void *ptr
   mm/slub.c:486:17: sparse:     got int [noderef] __percpu *
>> mm/slub.c:486:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   mm/slub.c:486:17: sparse:     expected void *ptr
   mm/slub.c:486:17: sparse:     got int [noderef] __percpu *
>> mm/slub.c:486:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   mm/slub.c:486:17: sparse:     expected void *ptr
   mm/slub.c:486:17: sparse:     got int [noderef] __percpu *
>> mm/slub.c:486:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   mm/slub.c:486:17: sparse:     expected void *ptr
   mm/slub.c:486:17: sparse:     got int [noderef] __percpu *
   mm/slub.c:3350:47: sparse: sparse: context imbalance in '__slab_free' - unexpected unlock

vim +486 mm/slub.c

a2b4ae8bfd9c10 Vlastimil Babka   2021-06-04  474  
a2b4ae8bfd9c10 Vlastimil Babka   2021-06-04  475  /*
a2b4ae8bfd9c10 Vlastimil Babka   2021-06-04  476   * Interrupts must be disabled (for the fallback code to work right), typically
a2b4ae8bfd9c10 Vlastimil Babka   2021-06-04  477   * by an _irqsave() lock variant. Except on PREEMPT_RT where locks are different
a2b4ae8bfd9c10 Vlastimil Babka   2021-06-04  478   * so we disable interrupts as part of slab_[un]lock().
a2b4ae8bfd9c10 Vlastimil Babka   2021-06-04  479   */
bb192ed9aa7191 Vlastimil Babka   2021-11-03  480  static inline bool __cmpxchg_double_slab(struct kmem_cache *s, struct slab *slab,
1d07171c5e58e6 Christoph Lameter 2011-07-14  481  		void *freelist_old, unsigned long counters_old,
1d07171c5e58e6 Christoph Lameter 2011-07-14  482  		void *freelist_new, unsigned long counters_new,
1d07171c5e58e6 Christoph Lameter 2011-07-14  483  		const char *n)
1d07171c5e58e6 Christoph Lameter 2011-07-14  484  {
a2b4ae8bfd9c10 Vlastimil Babka   2021-06-04  485  	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
a2b4ae8bfd9c10 Vlastimil Babka   2021-06-04 @486  		lockdep_assert_irqs_disabled();
2565409fc0303f Heiko Carstens    2012-01-12  487  #if defined(CONFIG_HAVE_CMPXCHG_DOUBLE) && \
2565409fc0303f Heiko Carstens    2012-01-12  488      defined(CONFIG_HAVE_ALIGNED_STRUCT_PAGE)
1d07171c5e58e6 Christoph Lameter 2011-07-14  489  	if (s->flags & __CMPXCHG_DOUBLE) {
bb192ed9aa7191 Vlastimil Babka   2021-11-03  490  		if (cmpxchg_double(&slab->freelist, &slab->counters,
1d07171c5e58e6 Christoph Lameter 2011-07-14  491  				   freelist_old, counters_old,
1d07171c5e58e6 Christoph Lameter 2011-07-14  492  				   freelist_new, counters_new))
6f6528a1632cb9 Joe Perches       2015-04-14  493  			return true;
1d07171c5e58e6 Christoph Lameter 2011-07-14  494  	} else
1d07171c5e58e6 Christoph Lameter 2011-07-14  495  #endif
1d07171c5e58e6 Christoph Lameter 2011-07-14  496  	{
a2b4ae8bfd9c10 Vlastimil Babka   2021-06-04  497  		/* init to 0 to prevent spurious warnings */
a2b4ae8bfd9c10 Vlastimil Babka   2021-06-04  498  		unsigned long flags = 0;
a2b4ae8bfd9c10 Vlastimil Babka   2021-06-04  499  
bb192ed9aa7191 Vlastimil Babka   2021-11-03  500  		slab_lock(slab, &flags);
bb192ed9aa7191 Vlastimil Babka   2021-11-03  501  		if (slab->freelist == freelist_old &&
bb192ed9aa7191 Vlastimil Babka   2021-11-03  502  					slab->counters == counters_old) {
bb192ed9aa7191 Vlastimil Babka   2021-11-03  503  			slab->freelist = freelist_new;
bb192ed9aa7191 Vlastimil Babka   2021-11-03  504  			slab->counters = counters_new;
bb192ed9aa7191 Vlastimil Babka   2021-11-03  505  			slab_unlock(slab, &flags);
6f6528a1632cb9 Joe Perches       2015-04-14  506  			return true;
1d07171c5e58e6 Christoph Lameter 2011-07-14  507  		}
bb192ed9aa7191 Vlastimil Babka   2021-11-03  508  		slab_unlock(slab, &flags);
1d07171c5e58e6 Christoph Lameter 2011-07-14  509  	}
1d07171c5e58e6 Christoph Lameter 2011-07-14  510  
1d07171c5e58e6 Christoph Lameter 2011-07-14  511  	cpu_relax();
1d07171c5e58e6 Christoph Lameter 2011-07-14  512  	stat(s, CMPXCHG_DOUBLE_FAIL);
1d07171c5e58e6 Christoph Lameter 2011-07-14  513  

:::::: The code at line 486 was first introduced by commit
:::::: a2b4ae8bfd9c10e3c1c1966bd3c8d8b7c9026aaf mm, slub: make slab_lock() disable irqs with PREEMPT_RT

:::::: TO: Vlastimil Babka <vbabka@suse.cz>
:::::: CC: Vlastimil Babka <vbabka@suse.cz>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

--Pm1R2lLfXX49/sKk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=config

#
# Automatically generated file; DO NOT EDIT.
# Linux/loongarch 5.19.0 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="loongarch64-linux-gcc (GCC) 12.1.0"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=120100
CONFIG_CLANG_VERSION=0
CONFIG_AS_IS_GNU=y
CONFIG_AS_VERSION=23800
CONFIG_LD_IS_BFD=y
CONFIG_LD_VERSION=23800
CONFIG_LLD_VERSION=0
CONFIG_CC_HAS_ASM_GOTO=y
CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_CC_HAS_NO_PROFILE_FN_ATTR=y
CONFIG_PAHOLE_VERSION=123
CONFIG_CONSTRUCTORS=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_TABLE_SORT=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
CONFIG_COMPILE_TEST=y
# CONFIG_WERROR is not set
CONFIG_LOCALVERSION=""
CONFIG_BUILD_SALT=""
CONFIG_DEFAULT_INIT=""
CONFIG_DEFAULT_HOSTNAME="(none)"
# CONFIG_SYSVIPC is not set
# CONFIG_WATCH_QUEUE is not set
CONFIG_CROSS_MEMORY_ATTACH=y
# CONFIG_USELIB is not set
CONFIG_HAVE_ARCH_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_GENERIC_IRQ_INJECTION=y
CONFIG_GENERIC_IRQ_CHIP=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_IRQ_FASTEOI_HIERARCHY_HANDLERS=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
CONFIG_GENERIC_IRQ_DEBUGFS=y
# end of IRQ subsystem

CONFIG_GENERIC_IRQ_MULTI_HANDLER=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CMOS_UPDATE=y
CONFIG_TIME_KUNIT_TEST=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
CONFIG_NO_HZ_IDLE=y
# CONFIG_NO_HZ_FULL is not set
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
# end of Timers subsystem

#
# BPF subsystem
#
# CONFIG_BPF_SYSCALL is not set
# end of BPF subsystem

CONFIG_PREEMPT_BUILD=y
# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
CONFIG_PREEMPT=y
CONFIG_PREEMPT_COUNT=y
CONFIG_PREEMPTION=y

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
# CONFIG_VIRT_CPU_ACCOUNTING_GEN is not set
# CONFIG_IRQ_TIME_ACCOUNTING is not set
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_PSI=y
# CONFIG_PSI_DEFAULT_DISABLED is not set
# end of CPU/Task time and stats accounting

# CONFIG_CPU_ISOLATION is not set

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
CONFIG_PREEMPT_RCU=y
CONFIG_RCU_EXPERT=y
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_FORCE_TASKS_RCU=y
CONFIG_TASKS_RCU=y
# CONFIG_FORCE_TASKS_RUDE_RCU is not set
CONFIG_FORCE_TASKS_TRACE_RCU=y
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_FANOUT=64
CONFIG_RCU_FANOUT_LEAF=16
# CONFIG_RCU_BOOST is not set
CONFIG_RCU_NOCB_CPU=y
# CONFIG_TASKS_TRACE_RCU_READ_MB is not set
# end of RCU Subsystem

# CONFIG_IKCONFIG is not set
CONFIG_IKHEADERS=y
CONFIG_GENERIC_SCHED_CLOCK=y

#
# Scheduler features
#
# end of Scheduler features

CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_CC_HAS_INT128=y
CONFIG_CC_IMPLICIT_FALLTHROUGH="-Wimplicit-fallthrough=5"
CONFIG_GCC12_NO_ARRAY_BOUNDS=y
CONFIG_CC_NO_ARRAY_BOUNDS=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
# CONFIG_MEMCG is not set
# CONFIG_BLK_CGROUP is not set
CONFIG_CGROUP_SCHED=y
# CONFIG_FAIR_GROUP_SCHED is not set
# CONFIG_RT_GROUP_SCHED is not set
# CONFIG_CGROUP_PIDS is not set
CONFIG_CGROUP_RDMA=y
# CONFIG_CGROUP_FREEZER is not set
CONFIG_CGROUP_HUGETLB=y
# CONFIG_CPUSETS is not set
# CONFIG_CGROUP_DEVICE is not set
CONFIG_CGROUP_CPUACCT=y
CONFIG_CGROUP_MISC=y
CONFIG_CGROUP_DEBUG=y
CONFIG_NAMESPACES=y
# CONFIG_UTS_NS is not set
CONFIG_USER_NS=y
CONFIG_PID_NS=y
CONFIG_CHECKPOINT_RESTORE=y
# CONFIG_SCHED_AUTOGROUP is not set
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
# CONFIG_BLK_DEV_INITRD is not set
CONFIG_BOOT_CONFIG=y
CONFIG_BOOT_CONFIG_EMBED=y
CONFIG_BOOT_CONFIG_EMBED_FILE=""
CONFIG_INITRAMFS_PRESERVE_MTIME=y
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_EXPERT=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
# CONFIG_SYSFS_SYSCALL is not set
CONFIG_FHANDLE=y
# CONFIG_POSIX_TIMERS is not set
# CONFIG_PRINTK is not set
CONFIG_BUG=y
# CONFIG_ELF_CORE is not set
# CONFIG_BASE_FULL is not set
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
# CONFIG_EPOLL is not set
CONFIG_SIGNALFD=y
# CONFIG_TIMERFD is not set
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
# CONFIG_AIO is not set
# CONFIG_IO_URING is not set
# CONFIG_ADVISE_SYSCALLS is not set
# CONFIG_MEMBARRIER is not set
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_KCMP=y
# CONFIG_RSEQ is not set
CONFIG_EMBEDDED=y
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_PERF_USE_VMALLOC=y
CONFIG_PC104=y

#
# Kernel Performance Events And Counters
#
# CONFIG_PERF_EVENTS is not set
# end of Kernel Performance Events And Counters

# CONFIG_PROFILING is not set
CONFIG_TRACEPOINTS=y
# end of General setup

CONFIG_LOONGARCH=y
CONFIG_64BIT=y
CONFIG_CPU_HAS_FPU=y
CONFIG_CPU_HAS_PREFETCH=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_GENERIC_CSUM=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_L1_CACHE_SHIFT=6
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MACH_LOONGSON64=y
CONFIG_PAGE_SIZE_16KB=y
CONFIG_PGTABLE_2LEVEL=y
CONFIG_PGTABLE_LEVELS=2
CONFIG_SCHED_OMIT_FRAME_POINTER=y

#
# Kernel type and options
#
# CONFIG_HZ_100 is not set
CONFIG_HZ_250=y
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=250
CONFIG_SCHED_HRTICK=y
# CONFIG_4KB_3LEVEL is not set
# CONFIG_4KB_4LEVEL is not set
CONFIG_16KB_2LEVEL=y
# CONFIG_16KB_3LEVEL is not set
# CONFIG_64KB_2LEVEL is not set
# CONFIG_64KB_3LEVEL is not set
CONFIG_CMDLINE=""
# CONFIG_CMDLINE_BOOTLOADER is not set
CONFIG_CMDLINE_EXTEND=y
# CONFIG_CMDLINE_FORCE is not set
# CONFIG_DMI is not set
CONFIG_EFI=y
CONFIG_SMP=y
CONFIG_HOTPLUG_CPU=y
CONFIG_NR_CPUS=64
# CONFIG_NUMA is not set
CONFIG_FORCE_MAX_ZONEORDER=12
CONFIG_SECCOMP=y
# end of Kernel type and options

CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=12
CONFIG_ARCH_MMAP_RND_BITS_MAX=18

#
# Power management options
#
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_GENERIC_GSI=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
CONFIG_ACPI_TABLE_LIB=y
# CONFIG_ACPI_DEBUGGER is not set
# CONFIG_ACPI_SPCR_TABLE is not set
# CONFIG_ACPI_EC_DEBUGFS is not set
# CONFIG_ACPI_AC is not set
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_MCFG=y
# CONFIG_ACPI_PROCESSOR is not set
# CONFIG_ACPI_IPMI is not set
CONFIG_ACPI_CUSTOM_DSDT_FILE=""
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_DEBUG=y
CONFIG_ACPI_PCI_SLOT=y
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HED=y
CONFIG_ACPI_CUSTOM_METHOD=y
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
# CONFIG_ACPI_CONFIGFS is not set
# CONFIG_ACPI_PFRUT is not set
# CONFIG_ACPI_PCC is not set
# CONFIG_PMIC_OPREGION is not set
# end of Power management options

#
# Firmware Drivers
#

#
# ARM System Control and Management Interface Protocol
#
CONFIG_ARM_SCMI_PROTOCOL=y
CONFIG_ARM_SCMI_HAVE_TRANSPORT=y
CONFIG_ARM_SCMI_HAVE_SHMEM=y
CONFIG_ARM_SCMI_TRANSPORT_MAILBOX=y
# CONFIG_ARM_SCMI_TRANSPORT_VIRTIO is not set
# CONFIG_ARM_SCMI_POWER_DOMAIN is not set
# end of ARM System Control and Management Interface Protocol

# CONFIG_ARM_SCPI_PROTOCOL is not set
CONFIG_ARM_SCPI_POWER_DOMAIN=y
# CONFIG_FIRMWARE_MEMMAP is not set
CONFIG_ISCSI_IBFT=y
CONFIG_MTK_ADSP_IPC=y
CONFIG_QCOM_SCM=y
# CONFIG_QCOM_SCM_DOWNLOAD_MODE_DEFAULT is not set
CONFIG_SYSFB=y
CONFIG_SYSFB_SIMPLEFB=y
# CONFIG_TURRIS_MOX_RWTM is not set
CONFIG_BCM47XX_NVRAM=y
# CONFIG_BCM47XX_SPROM is not set
# CONFIG_TEE_BNXT_FW is not set
CONFIG_GOOGLE_FIRMWARE=y
# CONFIG_GOOGLE_COREBOOT_TABLE is not set

#
# EFI (Extensible Firmware Interface) Support
#
CONFIG_EFI_ESRT=y
CONFIG_EFI_PARAMS_FROM_FDT=y
CONFIG_EFI_RUNTIME_WRAPPERS=y
CONFIG_EFI_BOOTLOADER_CONTROL=y
CONFIG_EFI_CAPSULE_LOADER=y
# CONFIG_EFI_TEST is not set
# CONFIG_EFI_RCI2_TABLE is not set
CONFIG_EFI_DISABLE_PCI_DMA=y
CONFIG_EFI_EARLYCON=y
# CONFIG_EFI_CUSTOM_SSDT_OVERLAYS is not set
CONFIG_EFI_DISABLE_RUNTIME=y
CONFIG_EFI_COCO_SECRET=y
# end of EFI (Extensible Firmware Interface) Support

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_GENERIC_ENTRY=y
CONFIG_HAVE_64BIT_ALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_NMI=y
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_WANTS_NO_INSTR=y
CONFIG_HAVE_ASM_MODVERSIONS=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_MMU_GATHER_MERGE_VMAS=y
CONFIG_HAVE_ARCH_SECCOMP=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_LTO_NONE=y
CONFIG_HAVE_CONTEXT_TRACKING=y
CONFIG_HAVE_TIF_NOHZ=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=12
CONFIG_PAGE_SIZE_LESS_THAN_64KB=y
CONFIG_PAGE_SIZE_LESS_THAN_256KB=y
CONFIG_ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_ARCH_HAS_PHYS_TO_DMA=y
CONFIG_ARCH_USE_MEMREMAP_PROT=y
# CONFIG_LOCK_EVENT_COUNTS is not set

#
# GCOV-based kernel profiling
#
CONFIG_GCOV_KERNEL=y
# end of GCOV-based kernel profiling
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=1
# CONFIG_MODULES is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
# CONFIG_BLOCK_LEGACY_AUTOLOAD is not set
CONFIG_BLK_DEV_BSG_COMMON=y
CONFIG_BLK_ICQ=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_INTEGRITY_T10=y
CONFIG_BLK_DEV_ZONED=y
CONFIG_BLK_WBT=y
# CONFIG_BLK_WBT_MQ is not set
CONFIG_BLK_DEBUG_FS=y
CONFIG_BLK_DEBUG_FS_ZONED=y
CONFIG_BLK_SED_OPAL=y
# CONFIG_BLK_INLINE_ENCRYPTION is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
CONFIG_ACORN_PARTITION=y
CONFIG_ACORN_PARTITION_CUMANA=y
# CONFIG_ACORN_PARTITION_EESOX is not set
# CONFIG_ACORN_PARTITION_ICS is not set
CONFIG_ACORN_PARTITION_ADFS=y
CONFIG_ACORN_PARTITION_POWERTEC=y
# CONFIG_ACORN_PARTITION_RISCIX is not set
# CONFIG_AIX_PARTITION is not set
CONFIG_OSF_PARTITION=y
# CONFIG_AMIGA_PARTITION is not set
CONFIG_ATARI_PARTITION=y
CONFIG_MAC_PARTITION=y
CONFIG_MSDOS_PARTITION=y
# CONFIG_BSD_DISKLABEL is not set
CONFIG_MINIX_SUBPARTITION=y
# CONFIG_SOLARIS_X86_PARTITION is not set
# CONFIG_UNIXWARE_DISKLABEL is not set
# CONFIG_LDM_PARTITION is not set
CONFIG_SGI_PARTITION=y
CONFIG_ULTRIX_PARTITION=y
# CONFIG_SUN_PARTITION is not set
CONFIG_KARMA_PARTITION=y
# CONFIG_EFI_PARTITION is not set
CONFIG_SYSV68_PARTITION=y
# CONFIG_CMDLINE_PARTITION is not set
# end of Partition Types

CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
# CONFIG_MQ_IOSCHED_KYBER is not set
CONFIG_IOSCHED_BFQ=y
# end of IO Schedulers

CONFIG_PADATA=y
CONFIG_ASN1=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y

#
# Executable file formats
#
# CONFIG_BINFMT_ELF is not set
CONFIG_ARCH_BINFMT_ELF_STATE=y
# CONFIG_BINFMT_SCRIPT is not set
# CONFIG_BINFMT_MISC is not set
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
CONFIG_ZPOOL=y
CONFIG_SWAP=y
CONFIG_ZSWAP=y
# CONFIG_ZSWAP_DEFAULT_ON is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_DEFLATE is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZO=y
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_842 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4HC is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_ZSTD is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT="lzo"
# CONFIG_ZSWAP_ZPOOL_DEFAULT_ZBUD is not set
# CONFIG_ZSWAP_ZPOOL_DEFAULT_Z3FOLD is not set
CONFIG_ZSWAP_ZPOOL_DEFAULT_ZSMALLOC=y
CONFIG_ZSWAP_ZPOOL_DEFAULT="zsmalloc"
# CONFIG_ZBUD is not set
CONFIG_Z3FOLD=y
CONFIG_ZSMALLOC=y
# CONFIG_ZSMALLOC_STAT is not set

#
# SLAB allocator options
#
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB is not set
# CONFIG_SLAB_MERGE_DEFAULT is not set
# CONFIG_SLAB_FREELIST_RANDOM is not set
# CONFIG_SLAB_FREELIST_HARDENED is not set
CONFIG_SLUB_STATS=y
# CONFIG_SLUB_CPU_PARTIAL is not set
# end of SLAB allocator options

CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
# CONFIG_COMPAT_BRK is not set
CONFIG_SELECT_MEMORY_MODEL=y
# CONFIG_FLATMEM_MANUAL is not set
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_EXCLUSIVE_SYSTEM_RAM=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
# CONFIG_MEMORY_HOTPLUG is not set
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_COMPACTION=y
CONFIG_PAGE_REPORTING=y
CONFIG_MIGRATION=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_MMU_NOTIFIER=y
# CONFIG_KSM is not set
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_TRANSPARENT_HUGEPAGE=y
# CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS is not set
CONFIG_TRANSPARENT_HUGEPAGE_MADVISE=y
# CONFIG_READ_ONLY_THP_FOR_FS is not set
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y
CONFIG_FRONTSWAP=y
# CONFIG_CMA is not set
CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
# CONFIG_IDLE_PAGE_TRACKING is not set
CONFIG_ZONE_DMA32=y
CONFIG_HMM_MIRROR=y
# CONFIG_VM_EVENT_COUNTERS is not set
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_TEST is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_USERFAULTFD=y

#
# Data Access Monitoring
#
# CONFIG_DAMON is not set
# end of Data Access Monitoring
# end of Memory Management options

# CONFIG_NET is not set

#
# Device Drivers
#
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCI_DOMAINS_GENERIC=y
# CONFIG_PCIEPORTBUS is not set
# CONFIG_PCIEASPM is not set
CONFIG_PCIE_PTM=y
CONFIG_PCI_MSI=y
CONFIG_PCI_MSI_IRQ_DOMAIN=y
CONFIG_PCI_MSI_ARCH_FALLBACKS=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
CONFIG_PCI_REALLOC_ENABLE_AUTO=y
# CONFIG_PCI_STUB is not set
CONFIG_PCI_PF_STUB=y
CONFIG_PCI_ATS=y
CONFIG_PCI_ECAM=y
CONFIG_PCI_IOV=y
CONFIG_PCI_PRI=y
CONFIG_PCI_PASID=y
CONFIG_PCI_LABEL=y
# CONFIG_PCIE_BUS_TUNE_OFF is not set
# CONFIG_PCIE_BUS_DEFAULT is not set
# CONFIG_PCIE_BUS_SAFE is not set
CONFIG_PCIE_BUS_PERFORMANCE=y
# CONFIG_PCIE_BUS_PEER2PEER is not set
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
CONFIG_HOTPLUG_PCI=y
# CONFIG_HOTPLUG_PCI_ACPI is not set
CONFIG_HOTPLUG_PCI_CPCI=y
# CONFIG_HOTPLUG_PCI_SHPC is not set

#
# PCI controller drivers
#
# CONFIG_PCI_AARDVARK is not set
# CONFIG_PCIE_XILINX_NWL is not set
# CONFIG_PCI_FTPCI100 is not set
# CONFIG_PCI_TEGRA is not set
CONFIG_PCIE_RCAR_HOST=y
CONFIG_PCIE_RCAR_EP=y
CONFIG_PCI_HOST_COMMON=y
CONFIG_PCI_HOST_GENERIC=y
CONFIG_PCIE_XILINX=y
CONFIG_PCIE_XILINX_CPM=y
# CONFIG_PCI_XGENE is not set
# CONFIG_PCI_V3_SEMI is not set
CONFIG_PCI_VERSATILE=y
# CONFIG_PCIE_ALTERA is not set
# CONFIG_PCI_HOST_THUNDER_PEM is not set
# CONFIG_PCI_HOST_THUNDER_ECAM is not set
CONFIG_PCIE_ROCKCHIP=y
CONFIG_PCIE_ROCKCHIP_HOST=y
CONFIG_PCIE_ROCKCHIP_EP=y
# CONFIG_PCIE_MEDIATEK is not set
# CONFIG_PCIE_MEDIATEK_GEN3 is not set
CONFIG_PCIE_BRCMSTB=y
CONFIG_PCI_LOONGSON=y
# CONFIG_PCIE_MICROCHIP_HOST is not set
# CONFIG_PCIE_APPLE is not set
CONFIG_PCIE_MT7621=y

#
# DesignWare PCI Core Support
#
CONFIG_PCIE_DW=y
CONFIG_PCIE_DW_HOST=y
CONFIG_PCIE_DW_EP=y
CONFIG_PCIE_DW_PLAT=y
CONFIG_PCIE_DW_PLAT_HOST=y
# CONFIG_PCIE_DW_PLAT_EP is not set
# CONFIG_PCI_EXYNOS is not set
# CONFIG_PCI_IMX6 is not set
CONFIG_PCIE_SPEAR13XX=y
CONFIG_PCI_KEYSTONE=y
CONFIG_PCI_KEYSTONE_HOST=y
CONFIG_PCI_KEYSTONE_EP=y
CONFIG_PCI_LAYERSCAPE=y
CONFIG_PCI_LAYERSCAPE_EP=y
CONFIG_PCI_HISI=y
CONFIG_PCIE_QCOM=y
CONFIG_PCIE_QCOM_EP=y
CONFIG_PCIE_ARMADA_8K=y
CONFIG_PCIE_ARTPEC6=y
CONFIG_PCIE_ARTPEC6_HOST=y
CONFIG_PCIE_ARTPEC6_EP=y
CONFIG_PCIE_ROCKCHIP_DW_HOST=y
CONFIG_PCIE_INTEL_GW=y
# CONFIG_PCIE_KEEMBAY_HOST is not set
# CONFIG_PCIE_KEEMBAY_EP is not set
# CONFIG_PCIE_KIRIN is not set
CONFIG_PCIE_HISI_STB=y
CONFIG_PCI_MESON=y
CONFIG_PCIE_TEGRA194=y
CONFIG_PCIE_TEGRA194_HOST=y
CONFIG_PCIE_TEGRA194_EP=y
# CONFIG_PCIE_VISCONTI_HOST is not set
CONFIG_PCIE_UNIPHIER=y
# CONFIG_PCIE_UNIPHIER_EP is not set
# CONFIG_PCIE_AL is not set
# CONFIG_PCIE_FU740 is not set
# end of DesignWare PCI Core Support

#
# Mobiveil PCIe Core Support
#
CONFIG_PCIE_MOBIVEIL=y
CONFIG_PCIE_MOBIVEIL_HOST=y
# CONFIG_PCIE_MOBIVEIL_PLAT is not set
CONFIG_PCIE_LAYERSCAPE_GEN4=y
# end of Mobiveil PCIe Core Support

#
# Cadence PCIe controllers support
#
CONFIG_PCIE_CADENCE=y
CONFIG_PCIE_CADENCE_HOST=y
# CONFIG_PCIE_CADENCE_PLAT_HOST is not set
# CONFIG_PCIE_CADENCE_PLAT_EP is not set
CONFIG_PCI_J721E=y
CONFIG_PCI_J721E_HOST=y
# CONFIG_PCI_J721E_EP is not set
# end of Cadence PCIe controllers support
# end of PCI controller drivers

#
# PCI Endpoint
#
CONFIG_PCI_ENDPOINT=y
# CONFIG_PCI_ENDPOINT_CONFIGFS is not set
CONFIG_PCI_EPF_TEST=y
CONFIG_PCI_EPF_NTB=y
# end of PCI Endpoint

#
# PCI switch controller drivers
#
CONFIG_PCI_SW_SWITCHTEC=y
# end of PCI switch controller drivers

CONFIG_CXL_BUS=y
CONFIG_CXL_PCI=y
CONFIG_CXL_MEM_RAW_COMMANDS=y
CONFIG_CXL_ACPI=y
CONFIG_CXL_MEM=y
CONFIG_CXL_PORT=y
CONFIG_PCCARD=y
# CONFIG_PCMCIA is not set
# CONFIG_CARDBUS is not set

#
# PC-card bridges
#
# CONFIG_YENTA is not set
CONFIG_RAPIDIO=y
CONFIG_RAPIDIO_DISC_TIMEOUT=30
# CONFIG_RAPIDIO_ENABLE_RX_TX_PORTS is not set
# CONFIG_RAPIDIO_DEBUG is not set
CONFIG_RAPIDIO_ENUM_BASIC=y
CONFIG_RAPIDIO_CHMAN=y
CONFIG_RAPIDIO_MPORT_CDEV=y

#
# RapidIO Switch drivers
#
# CONFIG_RAPIDIO_CPS_XX is not set
# CONFIG_RAPIDIO_CPS_GEN2 is not set
CONFIG_RAPIDIO_RXS_GEN3=y
# end of RapidIO Switch drivers

#
# Generic Driver Options
#
CONFIG_UEVENT_HELPER=y
CONFIG_UEVENT_HELPER_PATH=""
CONFIG_DEVTMPFS=y
# CONFIG_DEVTMPFS_MOUNT is not set
# CONFIG_DEVTMPFS_SAFE is not set
# CONFIG_STANDALONE is not set
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_EXTRA_FIRMWARE=""
# CONFIG_FW_LOADER_USER_HELPER is not set
# CONFIG_FW_LOADER_COMPRESS is not set
# CONFIG_FW_UPLOAD is not set
# end of Firmware loader

CONFIG_WANT_DEV_COREDUMP=y
CONFIG_ALLOW_DEV_COREDUMP=y
CONFIG_DEV_COREDUMP=y
CONFIG_DEBUG_DRIVER=y
CONFIG_DEBUG_DEVRES=y
CONFIG_DEBUG_TEST_DRIVER_REMOVE=y
CONFIG_PM_QOS_KUNIT_TEST=y
CONFIG_DRIVER_PE_KUNIT_TEST=y
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_SOC_BUS=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SPI=y
CONFIG_REGMAP_SPMI=y
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# end of Generic Driver Options

#
# Bus devices
#
CONFIG_ARM_INTEGRATOR_LM=y
# CONFIG_BT1_APB is not set
# CONFIG_BT1_AXI is not set
# CONFIG_MOXTET is not set
CONFIG_HISILICON_LPC=y
# CONFIG_INTEL_IXP4XX_EB is not set
CONFIG_QCOM_EBI2=y
CONFIG_MHI_BUS=y
CONFIG_MHI_BUS_DEBUG=y
CONFIG_MHI_BUS_PCI_GENERIC=y
# CONFIG_MHI_BUS_EP is not set
# end of Bus devices

#
# Firmware Drivers
#

#
# ARM System Control and Management Interface Protocol
#
# end of ARM System Control and Management Interface Protocol

#
# EFI (Extensible Firmware Interface) Support
#
# end of EFI (Extensible Firmware Interface) Support

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

# CONFIG_GNSS is not set
# CONFIG_MTD is not set
# CONFIG_MTD_NAND_ECC_MXIC is not set
CONFIG_DTC=y
CONFIG_OF=y
# CONFIG_OF_UNITTEST is not set
# CONFIG_OF_ALL_DTBS is not set
CONFIG_OF_FLATTREE=y
CONFIG_OF_EARLY_FLATTREE=y
CONFIG_OF_KOBJ=y
CONFIG_OF_ADDRESS=y
CONFIG_OF_IRQ=y
CONFIG_OF_RESERVED_MEM=y
# CONFIG_OF_OVERLAY is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
# CONFIG_PARPORT is not set
CONFIG_PNP=y
CONFIG_PNP_DEBUG_MESSAGES=y

#
# Protocols
#
CONFIG_ISAPNP=y
CONFIG_PNPACPI=y
# CONFIG_BLK_DEV is not set

#
# NVME Support
#
CONFIG_NVME_CORE=y
# CONFIG_BLK_DEV_NVME is not set
CONFIG_NVME_MULTIPATH=y
CONFIG_NVME_VERBOSE_ERRORS=y
# CONFIG_NVME_HWMON is not set
CONFIG_NVME_FABRICS=y
CONFIG_NVME_FC=y
# CONFIG_NVME_APPLE is not set
CONFIG_NVME_TARGET=y
CONFIG_NVME_TARGET_PASSTHRU=y
CONFIG_NVME_TARGET_LOOP=y
# CONFIG_NVME_TARGET_FC is not set
# end of NVME Support

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=y
CONFIG_AD525X_DPOT=y
# CONFIG_AD525X_DPOT_I2C is not set
CONFIG_AD525X_DPOT_SPI=y
# CONFIG_DUMMY_IRQ is not set
# CONFIG_PHANTOM is not set
CONFIG_TIFM_CORE=y
# CONFIG_TIFM_7XX1 is not set
CONFIG_ICS932S401=y
# CONFIG_ATMEL_SSC is not set
# CONFIG_ENCLOSURE_SERVICES is not set
# CONFIG_GEHC_ACHC is not set
# CONFIG_HI6421V600_IRQ is not set
CONFIG_HP_ILO=y
# CONFIG_QCOM_COINCELL is not set
CONFIG_QCOM_FASTRPC=y
CONFIG_APDS9802ALS=y
CONFIG_ISL29003=y
# CONFIG_ISL29020 is not set
# CONFIG_SENSORS_TSL2550 is not set
CONFIG_SENSORS_BH1770=y
CONFIG_SENSORS_APDS990X=y
CONFIG_HMC6352=y
CONFIG_DS1682=y
CONFIG_PCH_PHUB=y
CONFIG_LATTICE_ECP3_CONFIG=y
# CONFIG_SRAM is not set
CONFIG_DW_XDATA_PCIE=y
CONFIG_PCI_ENDPOINT_TEST=y
# CONFIG_XILINX_SDFEC is not set
CONFIG_MISC_RTSX=y
# CONFIG_OPEN_DICE is not set
# CONFIG_C2PORT is not set

#
# EEPROM support
#
# CONFIG_EEPROM_AT24 is not set
# CONFIG_EEPROM_AT25 is not set
CONFIG_EEPROM_LEGACY=y
# CONFIG_EEPROM_MAX6875 is not set
CONFIG_EEPROM_93CX6=y
CONFIG_EEPROM_93XX46=y
CONFIG_EEPROM_IDT_89HPESX=y
CONFIG_EEPROM_EE1004=y
# end of EEPROM support

CONFIG_CB710_CORE=y
CONFIG_CB710_DEBUG=y
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
# end of Texas Instruments shared transport line discipline

CONFIG_SENSORS_LIS3_I2C=y
# CONFIG_ALTERA_STAPL is not set
CONFIG_GENWQE=y
CONFIG_GENWQE_PLATFORM_ERROR_RECOVERY=0
CONFIG_ECHO=y
CONFIG_BCM_VK=y
CONFIG_BCM_VK_TTY=y
# CONFIG_MISC_ALCOR_PCI is not set
CONFIG_MISC_RTSX_PCI=y
CONFIG_HABANA_AI=y
CONFIG_UACCE=y
CONFIG_PVPANIC=y
CONFIG_PVPANIC_MMIO=y
# CONFIG_PVPANIC_PCI is not set
# end of Misc devices

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=y
CONFIG_SCSI_COMMON=y
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
# CONFIG_SCSI_PROC_FS is not set

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
CONFIG_CHR_DEV_ST=y
# CONFIG_CHR_DEV_SG is not set
CONFIG_BLK_DEV_BSG=y
CONFIG_CHR_DEV_SCH=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=y
CONFIG_SCSI_SAS_ATTRS=y
CONFIG_SCSI_SAS_LIBSAS=y
# CONFIG_SCSI_SAS_ATA is not set
CONFIG_SCSI_SAS_HOST_SMP=y
CONFIG_SCSI_SRP_ATTRS=y
# end of SCSI Transports

CONFIG_SCSI_LOWLEVEL=y
CONFIG_ISCSI_BOOT_SYSFS=y
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_HPSA is not set
CONFIG_SCSI_3W_9XXX=y
# CONFIG_SCSI_3W_SAS is not set
CONFIG_SCSI_ACARD=y
# CONFIG_SCSI_AACRAID is not set
CONFIG_SCSI_AIC7XXX=y
CONFIG_AIC7XXX_CMDS_PER_DEVICE=32
CONFIG_AIC7XXX_RESET_DELAY_MS=5000
CONFIG_AIC7XXX_DEBUG_ENABLE=y
CONFIG_AIC7XXX_DEBUG_MASK=0
CONFIG_AIC7XXX_REG_PRETTY_PRINT=y
CONFIG_SCSI_AIC79XX=y
CONFIG_AIC79XX_CMDS_PER_DEVICE=32
CONFIG_AIC79XX_RESET_DELAY_MS=5000
# CONFIG_AIC79XX_DEBUG_ENABLE is not set
CONFIG_AIC79XX_DEBUG_MASK=0
CONFIG_AIC79XX_REG_PRETTY_PRINT=y
CONFIG_SCSI_AIC94XX=y
CONFIG_AIC94XX_DEBUG=y
CONFIG_SCSI_HISI_SAS=y
# CONFIG_SCSI_HISI_SAS_PCI is not set
CONFIG_SCSI_HISI_SAS_DEBUGFS_DEFAULT_ENABLE=y
# CONFIG_SCSI_MVSAS is not set
CONFIG_SCSI_MVUMI=y
CONFIG_SCSI_ADVANSYS=y
CONFIG_SCSI_ARCMSR=y
# CONFIG_SCSI_ESAS2R is not set
CONFIG_MEGARAID_NEWGEN=y
# CONFIG_MEGARAID_MM is not set
CONFIG_MEGARAID_LEGACY=y
CONFIG_MEGARAID_SAS=y
CONFIG_SCSI_MPT3SAS=y
CONFIG_SCSI_MPT2SAS_MAX_SGE=128
CONFIG_SCSI_MPT3SAS_MAX_SGE=128
CONFIG_SCSI_MPT2SAS=y
CONFIG_SCSI_MPI3MR=y
# CONFIG_SCSI_SMARTPQI is not set
CONFIG_SCSI_HPTIOP=y
# CONFIG_SCSI_MYRB is not set
CONFIG_SCSI_MYRS=y
# CONFIG_SCSI_SNIC is not set
CONFIG_SCSI_DMX3191D=y
CONFIG_SCSI_FDOMAIN=y
CONFIG_SCSI_FDOMAIN_PCI=y
CONFIG_SCSI_IPS=y
CONFIG_SCSI_INITIO=y
# CONFIG_SCSI_INIA100 is not set
CONFIG_SCSI_STEX=y
CONFIG_SCSI_SYM53C8XX_2=y
CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=1
CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=16
CONFIG_SCSI_SYM53C8XX_MAX_TAGS=64
# CONFIG_SCSI_SYM53C8XX_MMIO is not set
CONFIG_SCSI_IPR=y
# CONFIG_SCSI_IPR_TRACE is not set
# CONFIG_SCSI_IPR_DUMP is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_AM53C974 is not set
CONFIG_SCSI_WD719X=y
CONFIG_SCSI_DEBUG=y
CONFIG_SCSI_PM8001=y
# CONFIG_SCSI_VIRTIO is not set
CONFIG_SCSI_DH=y
CONFIG_SCSI_DH_RDAC=y
CONFIG_SCSI_DH_HP_SW=y
CONFIG_SCSI_DH_EMC=y
# CONFIG_SCSI_DH_ALUA is not set
# end of SCSI device support

CONFIG_ATA=y
CONFIG_SATA_HOST=y
CONFIG_PATA_TIMINGS=y
# CONFIG_ATA_VERBOSE_ERROR is not set
CONFIG_ATA_FORCE=y
# CONFIG_ATA_ACPI is not set
# CONFIG_SATA_PMP is not set

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI=y
CONFIG_SATA_MOBILE_LPM_POLICY=0
# CONFIG_SATA_AHCI_PLATFORM is not set
CONFIG_AHCI_BRCM=y
CONFIG_AHCI_DA850=y
CONFIG_AHCI_DM816=y
CONFIG_AHCI_IMX=y
# CONFIG_AHCI_CEVA is not set
CONFIG_AHCI_MTK=y
CONFIG_AHCI_MVEBU=y
# CONFIG_AHCI_SUNXI is not set
# CONFIG_AHCI_TEGRA is not set
# CONFIG_AHCI_XGENE is not set
# CONFIG_AHCI_QORIQ is not set
CONFIG_SATA_FSL=y
# CONFIG_SATA_GEMINI is not set
# CONFIG_SATA_AHCI_SEATTLE is not set
CONFIG_SATA_INIC162X=y
CONFIG_SATA_ACARD_AHCI=y
CONFIG_SATA_SIL24=y
CONFIG_ATA_SFF=y

#
# SFF controllers with custom DMA interface
#
# CONFIG_PDC_ADMA is not set
CONFIG_SATA_QSTOR=y
CONFIG_SATA_SX4=y
# CONFIG_ATA_BMDMA is not set

#
# PIO-only SFF controllers
#
CONFIG_PATA_CMD640_PCI=y
CONFIG_PATA_ISAPNP=y
CONFIG_PATA_IXP4XX_CF=y
# CONFIG_PATA_MPIIX is not set
CONFIG_PATA_NS87410=y
# CONFIG_PATA_OPTI is not set
# CONFIG_PATA_PLATFORM is not set
CONFIG_PATA_RZ1000=y
CONFIG_PATA_SAMSUNG_CF=y

#
# Generic fallback / legacy drivers
#
CONFIG_PATA_LEGACY=y
# CONFIG_MD is not set
# CONFIG_TARGET_CORE is not set
CONFIG_FUSION=y
CONFIG_FUSION_SPI=y
# CONFIG_FUSION_SAS is not set
CONFIG_FUSION_MAX_SGE=128
# CONFIG_FUSION_CTL is not set
# CONFIG_FUSION_LOGGING is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=y
CONFIG_FIREWIRE_OHCI=y
CONFIG_FIREWIRE_SBP2=y
CONFIG_FIREWIRE_NOSY=y
# end of IEEE 1394 (FireWire) support

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=y
CONFIG_INPUT_SPARSEKMAP=y
CONFIG_INPUT_MATRIXKMAP=y
CONFIG_INPUT_VIVALDIFMAP=y

#
# Userland interfaces
#
# CONFIG_INPUT_MOUSEDEV is not set
CONFIG_INPUT_JOYDEV=y
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADC is not set
# CONFIG_KEYBOARD_ADP5520 is not set
CONFIG_KEYBOARD_ADP5588=y
CONFIG_KEYBOARD_ADP5589=y
# CONFIG_KEYBOARD_APPLESPI is not set
# CONFIG_KEYBOARD_ATKBD is not set
CONFIG_KEYBOARD_QT1050=y
CONFIG_KEYBOARD_QT1070=y
CONFIG_KEYBOARD_QT2160=y
CONFIG_KEYBOARD_CLPS711X=y
CONFIG_KEYBOARD_DLINK_DIR685=y
CONFIG_KEYBOARD_LKKBD=y
CONFIG_KEYBOARD_EP93XX=y
# CONFIG_KEYBOARD_GPIO is not set
CONFIG_KEYBOARD_GPIO_POLLED=y
CONFIG_KEYBOARD_TCA6416=y
# CONFIG_KEYBOARD_TCA8418 is not set
CONFIG_KEYBOARD_MATRIX=y
CONFIG_KEYBOARD_LM8323=y
CONFIG_KEYBOARD_LM8333=y
CONFIG_KEYBOARD_MAX7359=y
CONFIG_KEYBOARD_MCS=y
CONFIG_KEYBOARD_MPR121=y
# CONFIG_KEYBOARD_SNVS_PWRKEY is not set
# CONFIG_KEYBOARD_IMX is not set
CONFIG_KEYBOARD_NEWTON=y
CONFIG_KEYBOARD_OPENCORES=y
CONFIG_KEYBOARD_SAMSUNG=y
# CONFIG_KEYBOARD_GOLDFISH_EVENTS is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
CONFIG_KEYBOARD_ST_KEYSCAN=y
CONFIG_KEYBOARD_SUNKBD=y
CONFIG_KEYBOARD_SH_KEYSC=y
CONFIG_KEYBOARD_IQS62X=y
# CONFIG_KEYBOARD_OMAP4 is not set
CONFIG_KEYBOARD_TM2_TOUCHKEY=y
CONFIG_KEYBOARD_XTKBD=y
# CONFIG_KEYBOARD_CAP11XX is not set
# CONFIG_KEYBOARD_BCM is not set
# CONFIG_KEYBOARD_MT6779 is not set
CONFIG_KEYBOARD_CYPRESS_SF=y
# CONFIG_INPUT_MOUSE is not set
CONFIG_INPUT_JOYSTICK=y
CONFIG_JOYSTICK_ANALOG=y
# CONFIG_JOYSTICK_A3D is not set
CONFIG_JOYSTICK_ADC=y
# CONFIG_JOYSTICK_ADI is not set
# CONFIG_JOYSTICK_COBRA is not set
# CONFIG_JOYSTICK_GF2K is not set
CONFIG_JOYSTICK_GRIP=y
# CONFIG_JOYSTICK_GRIP_MP is not set
CONFIG_JOYSTICK_GUILLEMOT=y
CONFIG_JOYSTICK_INTERACT=y
# CONFIG_JOYSTICK_SIDEWINDER is not set
# CONFIG_JOYSTICK_TMDC is not set
CONFIG_JOYSTICK_IFORCE=y
# CONFIG_JOYSTICK_IFORCE_232 is not set
CONFIG_JOYSTICK_WARRIOR=y
CONFIG_JOYSTICK_MAGELLAN=y
CONFIG_JOYSTICK_SPACEORB=y
CONFIG_JOYSTICK_SPACEBALL=y
# CONFIG_JOYSTICK_STINGER is not set
# CONFIG_JOYSTICK_TWIDJOY is not set
CONFIG_JOYSTICK_ZHENHUA=y
# CONFIG_JOYSTICK_AS5011 is not set
CONFIG_JOYSTICK_JOYDUMP=y
CONFIG_JOYSTICK_PSXPAD_SPI=y
CONFIG_JOYSTICK_PSXPAD_SPI_FF=y
# CONFIG_JOYSTICK_QWIIC is not set
CONFIG_JOYSTICK_FSIA6B=y
CONFIG_JOYSTICK_SENSEHAT=y
CONFIG_INPUT_TABLET=y
# CONFIG_TABLET_SERIAL_WACOM4 is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set
CONFIG_RMI4_CORE=y
CONFIG_RMI4_I2C=y
# CONFIG_RMI4_SPI is not set
# CONFIG_RMI4_SMB is not set
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=y
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
CONFIG_RMI4_F34=y
CONFIG_RMI4_F3A=y
CONFIG_RMI4_F55=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
# CONFIG_SERIO_SERPORT is not set
CONFIG_SERIO_PCIPS2=y
# CONFIG_SERIO_LIBPS2 is not set
CONFIG_SERIO_RAW=y
CONFIG_SERIO_ALTERA_PS2=y
CONFIG_SERIO_PS2MULT=y
CONFIG_SERIO_ARC_PS2=y
# CONFIG_SERIO_APBPS2 is not set
# CONFIG_SERIO_OLPC_APSP is not set
# CONFIG_SERIO_SUN4I_PS2 is not set
CONFIG_SERIO_GPIO_PS2=y
# CONFIG_USERIO is not set
CONFIG_GAMEPORT=y
# CONFIG_GAMEPORT_NS558 is not set
CONFIG_GAMEPORT_L4=y
CONFIG_GAMEPORT_EMU10K1=y
CONFIG_GAMEPORT_FM801=y
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
# CONFIG_VT is not set
# CONFIG_UNIX98_PTYS is not set
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
# CONFIG_LDISC_AUTOLOAD is not set

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
CONFIG_SERIAL_8250_PNP=y
CONFIG_SERIAL_8250_16550A_VARIANTS=y
CONFIG_SERIAL_8250_FINTEK=y
# CONFIG_SERIAL_8250_CONSOLE is not set
# CONFIG_SERIAL_8250_PCI is not set
CONFIG_SERIAL_8250_MEN_MCB=y
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
# CONFIG_SERIAL_8250_ASPEED_VUART is not set
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
# CONFIG_SERIAL_8250_RSA is not set
CONFIG_SERIAL_8250_DWLIB=y
CONFIG_SERIAL_8250_BCM2835AUX=y
CONFIG_SERIAL_8250_DW=y
CONFIG_SERIAL_8250_EM=y
CONFIG_SERIAL_8250_IOC3=y
CONFIG_SERIAL_8250_RT288X=y
# CONFIG_SERIAL_8250_OMAP is not set
# CONFIG_SERIAL_8250_LPC18XX is not set
# CONFIG_SERIAL_8250_MT6577 is not set
CONFIG_SERIAL_8250_UNIPHIER=y
# CONFIG_SERIAL_8250_INGENIC is not set
# CONFIG_SERIAL_8250_LPSS is not set
# CONFIG_SERIAL_8250_MID is not set
CONFIG_SERIAL_8250_PERICOM=y
# CONFIG_SERIAL_8250_PXA is not set
# CONFIG_SERIAL_8250_TEGRA is not set
CONFIG_SERIAL_8250_BCM7271=y
# CONFIG_SERIAL_OF_PLATFORM is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_AMBA_PL010=y
CONFIG_SERIAL_AMBA_PL010_CONSOLE=y
CONFIG_SERIAL_ATMEL=y
# CONFIG_SERIAL_ATMEL_CONSOLE is not set
# CONFIG_SERIAL_ATMEL_PDC is not set
# CONFIG_SERIAL_ATMEL_TTYAT is not set
CONFIG_SERIAL_MESON=y
# CONFIG_SERIAL_MESON_CONSOLE is not set
CONFIG_SERIAL_CLPS711X=y
# CONFIG_SERIAL_CLPS711X_CONSOLE is not set
CONFIG_SERIAL_SAMSUNG=y
CONFIG_SERIAL_SAMSUNG_UARTS_4=y
CONFIG_SERIAL_SAMSUNG_UARTS=4
# CONFIG_SERIAL_SAMSUNG_CONSOLE is not set
CONFIG_SERIAL_TEGRA=y
CONFIG_SERIAL_TEGRA_TCU=y
CONFIG_SERIAL_TEGRA_TCU_CONSOLE=y
CONFIG_SERIAL_MAX3100=y
CONFIG_SERIAL_MAX310X=y
# CONFIG_SERIAL_IMX is not set
# CONFIG_SERIAL_IMX_EARLYCON is not set
CONFIG_SERIAL_UARTLITE=y
CONFIG_SERIAL_UARTLITE_CONSOLE=y
CONFIG_SERIAL_UARTLITE_NR_UARTS=1
CONFIG_SERIAL_SH_SCI=y
CONFIG_SERIAL_SH_SCI_NR_UARTS=2
CONFIG_SERIAL_SH_SCI_CONSOLE=y
CONFIG_SERIAL_SH_SCI_EARLYCON=y
# CONFIG_SERIAL_HS_LPC32XX is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_ICOM is not set
CONFIG_SERIAL_JSM=y
# CONFIG_SERIAL_MSM is not set
CONFIG_SERIAL_QCOM_GENI=y
# CONFIG_SERIAL_QCOM_GENI_CONSOLE is not set
# CONFIG_SERIAL_VT8500 is not set
CONFIG_SERIAL_OMAP=y
CONFIG_SERIAL_OMAP_CONSOLE=y
# CONFIG_SERIAL_SIFIVE is not set
CONFIG_SERIAL_LANTIQ=y
# CONFIG_SERIAL_LANTIQ_CONSOLE is not set
# CONFIG_SERIAL_SCCNXP is not set
CONFIG_SERIAL_SC16IS7XX=y
# CONFIG_SERIAL_SC16IS7XX_I2C is not set
# CONFIG_SERIAL_SC16IS7XX_SPI is not set
CONFIG_SERIAL_TIMBERDALE=y
# CONFIG_SERIAL_BCM63XX is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
CONFIG_SERIAL_ALTERA_UART=y
CONFIG_SERIAL_ALTERA_UART_MAXPORTS=4
CONFIG_SERIAL_ALTERA_UART_BAUDRATE=115200
# CONFIG_SERIAL_ALTERA_UART_CONSOLE is not set
CONFIG_SERIAL_PCH_UART=y
CONFIG_SERIAL_PCH_UART_CONSOLE=y
CONFIG_SERIAL_MXS_AUART=y
CONFIG_SERIAL_MXS_AUART_CONSOLE=y
# CONFIG_SERIAL_XILINX_PS_UART is not set
# CONFIG_SERIAL_MPS2_UART is not set
# CONFIG_SERIAL_ARC is not set
CONFIG_SERIAL_RP2=y
CONFIG_SERIAL_RP2_NR_UARTS=32
CONFIG_SERIAL_FSL_LPUART=y
CONFIG_SERIAL_FSL_LPUART_CONSOLE=y
# CONFIG_SERIAL_CONEXANT_DIGICOLOR is not set
# CONFIG_SERIAL_ST_ASC is not set
CONFIG_SERIAL_MEN_Z135=y
CONFIG_SERIAL_SPRD=y
# CONFIG_SERIAL_SPRD_CONSOLE is not set
# CONFIG_SERIAL_STM32 is not set
# CONFIG_SERIAL_MVEBU_UART is not set
CONFIG_SERIAL_OWL=y
CONFIG_SERIAL_OWL_CONSOLE=y
# CONFIG_SERIAL_RDA is not set
# CONFIG_SERIAL_MILBEAUT_USIO is not set
CONFIG_SERIAL_LITEUART=y
CONFIG_SERIAL_LITEUART_MAX_PORTS=1
# CONFIG_SERIAL_LITEUART_CONSOLE is not set
CONFIG_SERIAL_SUNPLUS=y
# CONFIG_SERIAL_SUNPLUS_CONSOLE is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
CONFIG_SERIAL_NONSTANDARD=y
CONFIG_MOXA_INTELLIO=y
CONFIG_MOXA_SMARTIO=y
CONFIG_SYNCLINK_GT=y
CONFIG_N_HDLC=y
CONFIG_GOLDFISH_TTY=y
CONFIG_GOLDFISH_TTY_EARLY_CONSOLE=y
# CONFIG_NOZOMI is not set
CONFIG_NULL_TTY=y
CONFIG_HVC_DRIVER=y
CONFIG_RPMSG_TTY=y
CONFIG_SERIAL_DEV_BUS=y
CONFIG_SERIAL_DEV_CTRL_TTYPORT=y
CONFIG_TTY_PRINTK=y
CONFIG_TTY_PRINTK_LEVEL=6
CONFIG_VIRTIO_CONSOLE=y
CONFIG_IPMI_HANDLER=y
CONFIG_IPMI_PANIC_EVENT=y
# CONFIG_IPMI_PANIC_STRING is not set
CONFIG_IPMI_DEVICE_INTERFACE=y
# CONFIG_IPMI_SI is not set
CONFIG_IPMI_SSIF=y
CONFIG_IPMI_IPMB=y
CONFIG_IPMI_WATCHDOG=y
CONFIG_IPMI_POWEROFF=y
CONFIG_IPMI_KCS_BMC=y
# CONFIG_ASPEED_KCS_IPMI_BMC is not set
CONFIG_NPCM7XX_KCS_IPMI_BMC=y
CONFIG_IPMI_KCS_BMC_CDEV_IPMI=y
# CONFIG_IPMI_KCS_BMC_SERIO is not set
CONFIG_ASPEED_BT_IPMI_BMC=y
CONFIG_IPMB_DEVICE_INTERFACE=y
CONFIG_HW_RANDOM=y
# CONFIG_HW_RANDOM_TIMERIOMEM is not set
CONFIG_HW_RANDOM_ATMEL=y
CONFIG_HW_RANDOM_BA431=y
CONFIG_HW_RANDOM_BCM2835=y
# CONFIG_HW_RANDOM_IPROC_RNG200 is not set
# CONFIG_HW_RANDOM_IXP4XX is not set
CONFIG_HW_RANDOM_OMAP=y
CONFIG_HW_RANDOM_OMAP3_ROM=y
CONFIG_HW_RANDOM_VIRTIO=y
# CONFIG_HW_RANDOM_IMX_RNGC is not set
CONFIG_HW_RANDOM_NOMADIK=y
CONFIG_HW_RANDOM_STM32=y
CONFIG_HW_RANDOM_MESON=y
# CONFIG_HW_RANDOM_MTK is not set
# CONFIG_HW_RANDOM_EXYNOS is not set
# CONFIG_HW_RANDOM_NPCM is not set
CONFIG_HW_RANDOM_KEYSTONE=y
# CONFIG_HW_RANDOM_CCTRNG is not set
CONFIG_HW_RANDOM_XIPHERA=y
# CONFIG_HW_RANDOM_CN10K is not set
CONFIG_APPLICOM=y
# CONFIG_DEVMEM is not set
# CONFIG_DEVPORT is not set
# CONFIG_TCG_TPM is not set
# CONFIG_XILLYBUS is not set
CONFIG_RANDOM_TRUST_BOOTLOADER=y
# end of Character devices

#
# I2C support
#
CONFIG_I2C=y
# CONFIG_ACPI_I2C_OPREGION is not set
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=y
CONFIG_I2C_MUX=y

#
# Multiplexer I2C Chip support
#
# CONFIG_I2C_ARB_GPIO_CHALLENGE is not set
CONFIG_I2C_MUX_GPIO=y
# CONFIG_I2C_MUX_GPMUX is not set
CONFIG_I2C_MUX_LTC4306=y
CONFIG_I2C_MUX_PCA9541=y
CONFIG_I2C_MUX_PCA954x=y
# CONFIG_I2C_MUX_PINCTRL is not set
CONFIG_I2C_MUX_REG=y
# CONFIG_I2C_DEMUX_PINCTRL is not set
# CONFIG_I2C_MUX_MLXCPLD is not set
# end of Multiplexer I2C Chip support

# CONFIG_I2C_HELPER_AUTO is not set
CONFIG_I2C_SMBUS=y

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCF=y
CONFIG_I2C_ALGOPCA=y
# end of I2C Algorithms

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
CONFIG_I2C_CCGX_UCSI=y
# CONFIG_I2C_ALI1535 is not set
CONFIG_I2C_ALI1563=y
CONFIG_I2C_ALI15X3=y
CONFIG_I2C_AMD756=y
CONFIG_I2C_AMD8111=y
CONFIG_I2C_AMD_MP2=y
CONFIG_I2C_HIX5HD2=y
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_ISCH is not set
# CONFIG_I2C_PIIX4 is not set
# CONFIG_I2C_NFORCE2 is not set
CONFIG_I2C_NVIDIA_GPU=y
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
CONFIG_I2C_VIA=y
# CONFIG_I2C_VIAPRO is not set

#
# ACPI drivers
#
# CONFIG_I2C_SCMI is not set

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_ALTERA is not set
CONFIG_I2C_ASPEED=y
# CONFIG_I2C_AT91 is not set
CONFIG_I2C_AXXIA=y
CONFIG_I2C_BCM2835=y
CONFIG_I2C_BCM_IPROC=y
# CONFIG_I2C_BCM_KONA is not set
# CONFIG_I2C_BRCMSTB is not set
# CONFIG_I2C_CADENCE is not set
CONFIG_I2C_CBUS_GPIO=y
# CONFIG_I2C_DAVINCI is not set
CONFIG_I2C_DESIGNWARE_CORE=y
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
# CONFIG_I2C_DESIGNWARE_PLATFORM is not set
CONFIG_I2C_DESIGNWARE_PCI=y
CONFIG_I2C_DIGICOLOR=y
CONFIG_I2C_EG20T=y
CONFIG_I2C_EMEV2=y
# CONFIG_I2C_EXYNOS5 is not set
CONFIG_I2C_GPIO=y
CONFIG_I2C_GPIO_FAULT_INJECTOR=y
CONFIG_I2C_HIGHLANDER=y
CONFIG_I2C_HISI=y
CONFIG_I2C_IMG=y
CONFIG_I2C_IMX=y
CONFIG_I2C_IMX_LPI2C=y
CONFIG_I2C_IOP3XX=y
# CONFIG_I2C_JZ4780 is not set
# CONFIG_I2C_LPC2K is not set
CONFIG_I2C_MESON=y
# CONFIG_I2C_MT65XX is not set
# CONFIG_I2C_MT7621 is not set
CONFIG_I2C_MV64XXX=y
# CONFIG_I2C_MXS is not set
# CONFIG_I2C_NPCM7XX is not set
# CONFIG_I2C_OCORES is not set
# CONFIG_I2C_OMAP is not set
CONFIG_I2C_OWL=y
CONFIG_I2C_APPLE=y
CONFIG_I2C_PCA_PLATFORM=y
CONFIG_I2C_PNX=y
CONFIG_I2C_PXA=y
CONFIG_I2C_PXA_SLAVE=y
CONFIG_I2C_QCOM_CCI=y
CONFIG_I2C_QCOM_GENI=y
CONFIG_I2C_QUP=y
# CONFIG_I2C_RIIC is not set
# CONFIG_I2C_RK3X is not set
# CONFIG_I2C_S3C2410 is not set
CONFIG_I2C_SH_MOBILE=y
CONFIG_I2C_SIMTEC=y
# CONFIG_I2C_SPRD is not set
CONFIG_I2C_ST=y
# CONFIG_I2C_STM32F4 is not set
# CONFIG_I2C_STM32F7 is not set
CONFIG_I2C_SUN6I_P2WI=y
CONFIG_I2C_SYNQUACER=y
CONFIG_I2C_TEGRA_BPMP=y
CONFIG_I2C_UNIPHIER=y
CONFIG_I2C_UNIPHIER_F=y
# CONFIG_I2C_VERSATILE is not set
CONFIG_I2C_WMT=y
CONFIG_I2C_THUNDERX=y
CONFIG_I2C_XILINX=y
CONFIG_I2C_XLP9XX=y
CONFIG_I2C_RCAR=y

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_TAOS_EVM is not set

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_MLXCPLD=y
# CONFIG_I2C_VIRTIO is not set
# end of I2C Hardware Bus support

CONFIG_I2C_SLAVE=y
# CONFIG_I2C_SLAVE_EEPROM is not set
CONFIG_I2C_SLAVE_TESTUNIT=y
CONFIG_I2C_DEBUG_CORE=y
# CONFIG_I2C_DEBUG_ALGO is not set
CONFIG_I2C_DEBUG_BUS=y
# end of I2C support

# CONFIG_I3C is not set
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y
CONFIG_SPI_MEM=y

#
# SPI Master Controller Drivers
#
CONFIG_SPI_ALTERA=y
CONFIG_SPI_ALTERA_CORE=y
CONFIG_SPI_AR934X=y
# CONFIG_SPI_ATH79 is not set
CONFIG_SPI_ARMADA_3700=y
# CONFIG_SPI_ASPEED_SMC is not set
# CONFIG_SPI_ATMEL is not set
CONFIG_SPI_AT91_USART=y
# CONFIG_SPI_ATMEL_QUADSPI is not set
CONFIG_SPI_AXI_SPI_ENGINE=y
CONFIG_SPI_BCM2835=y
# CONFIG_SPI_BCM2835AUX is not set
# CONFIG_SPI_BCM63XX is not set
CONFIG_SPI_BCM63XX_HSSPI=y
# CONFIG_SPI_BCM_QSPI is not set
CONFIG_SPI_BITBANG=y
CONFIG_SPI_CADENCE=y
# CONFIG_SPI_CADENCE_QUADSPI is not set
CONFIG_SPI_CADENCE_XSPI=y
CONFIG_SPI_CLPS711X=y
CONFIG_SPI_DESIGNWARE=y
CONFIG_SPI_DW_DMA=y
# CONFIG_SPI_DW_PCI is not set
CONFIG_SPI_DW_MMIO=y
CONFIG_SPI_DW_BT1=y
CONFIG_SPI_DW_BT1_DIRMAP=y
CONFIG_SPI_EP93XX=y
CONFIG_SPI_FSL_LPSPI=y
CONFIG_SPI_FSL_QUADSPI=y
CONFIG_SPI_HISI_KUNPENG=y
CONFIG_SPI_HISI_SFC_V3XX=y
CONFIG_SPI_NXP_FLEXSPI=y
CONFIG_SPI_GPIO=y
CONFIG_SPI_IMG_SPFI=y
# CONFIG_SPI_IMX is not set
CONFIG_SPI_INGENIC=y
CONFIG_SPI_INTEL=y
CONFIG_SPI_INTEL_PCI=y
CONFIG_SPI_INTEL_PLATFORM=y
# CONFIG_SPI_JCORE is not set
# CONFIG_SPI_LP8841_RTC is not set
# CONFIG_SPI_FSL_SPI is not set
CONFIG_SPI_FSL_DSPI=y
# CONFIG_SPI_MESON_SPICC is not set
# CONFIG_SPI_MESON_SPIFC is not set
CONFIG_SPI_MT65XX=y
CONFIG_SPI_MT7621=y
CONFIG_SPI_MTK_NOR=y
# CONFIG_SPI_NPCM_FIU is not set
CONFIG_SPI_NPCM_PSPI=y
CONFIG_SPI_LANTIQ_SSC=y
CONFIG_SPI_OC_TINY=y
CONFIG_SPI_OMAP24XX=y
# CONFIG_SPI_TI_QSPI is not set
CONFIG_SPI_OMAP_100K=y
# CONFIG_SPI_ORION is not set
CONFIG_SPI_PIC32=y
CONFIG_SPI_PIC32_SQI=y
CONFIG_SPI_PXA2XX=y
CONFIG_SPI_PXA2XX_PCI=y
# CONFIG_SPI_ROCKCHIP is not set
CONFIG_SPI_ROCKCHIP_SFC=y
CONFIG_SPI_RPCIF=y
CONFIG_SPI_RSPI=y
# CONFIG_SPI_QUP is not set
CONFIG_SPI_QCOM_GENI=y
CONFIG_SPI_S3C64XX=y
CONFIG_SPI_SC18IS602=y
CONFIG_SPI_SH_MSIOF=y
CONFIG_SPI_SH=y
CONFIG_SPI_SH_HSPI=y
CONFIG_SPI_SIFIVE=y
CONFIG_SPI_SLAVE_MT27XX=y
# CONFIG_SPI_SPRD is not set
# CONFIG_SPI_SPRD_ADI is not set
CONFIG_SPI_STM32=y
# CONFIG_SPI_STM32_QSPI is not set
CONFIG_SPI_ST_SSC4=y
# CONFIG_SPI_SUN4I is not set
CONFIG_SPI_SUN6I=y
CONFIG_SPI_SUNPLUS_SP7021=y
# CONFIG_SPI_SYNQUACER is not set
CONFIG_SPI_MXIC=y
CONFIG_SPI_TEGRA210_QUAD=y
CONFIG_SPI_TEGRA114=y
CONFIG_SPI_TEGRA20_SFLASH=y
CONFIG_SPI_TEGRA20_SLINK=y
CONFIG_SPI_THUNDERX=y
# CONFIG_SPI_TOPCLIFF_PCH is not set
# CONFIG_SPI_UNIPHIER is not set
CONFIG_SPI_XCOMM=y
CONFIG_SPI_XILINX=y
# CONFIG_SPI_XLP is not set
CONFIG_SPI_XTENSA_XTFPGA=y
# CONFIG_SPI_ZYNQ_QSPI is not set
CONFIG_SPI_ZYNQMP_GQSPI=y
CONFIG_SPI_AMD=y

#
# SPI Multiplexer support
#
CONFIG_SPI_MUX=y

#
# SPI Protocol Masters
#
CONFIG_SPI_SPIDEV=y
CONFIG_SPI_TLE62X0=y
CONFIG_SPI_SLAVE=y
CONFIG_SPI_SLAVE_TIME=y
# CONFIG_SPI_SLAVE_SYSTEM_CONTROL is not set
CONFIG_SPI_DYNAMIC=y
CONFIG_SPMI=y
# CONFIG_SPMI_HISI3670 is not set
# CONFIG_SPMI_MSM_PMIC_ARB is not set
CONFIG_SPMI_MTK_PMIF=y
# CONFIG_HSI is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
CONFIG_PPS_CLIENT_KTIMER=y
# CONFIG_PPS_CLIENT_LDISC is not set
CONFIG_PPS_CLIENT_GPIO=y

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK_OPTIONAL=y

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
# end of PTP clock support

CONFIG_PINCTRL=y
CONFIG_PINMUX=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
CONFIG_PINCTRL_AMD=y
# CONFIG_PINCTRL_AT91PIO4 is not set
# CONFIG_PINCTRL_AXP209 is not set
# CONFIG_PINCTRL_BM1880 is not set
# CONFIG_PINCTRL_DA850_PUPD is not set
CONFIG_PINCTRL_DA9062=y
# CONFIG_PINCTRL_EQUILIBRIUM is not set
# CONFIG_PINCTRL_INGENIC is not set
# CONFIG_PINCTRL_LPC18XX is not set
# CONFIG_PINCTRL_MAX77620 is not set
CONFIG_PINCTRL_MCP23S08_I2C=y
CONFIG_PINCTRL_MCP23S08_SPI=y
CONFIG_PINCTRL_MCP23S08=y
# CONFIG_PINCTRL_MICROCHIP_SGPIO is not set
# CONFIG_PINCTRL_OCELOT is not set
# CONFIG_PINCTRL_PISTACHIO is not set
# CONFIG_PINCTRL_ROCKCHIP is not set
# CONFIG_PINCTRL_SINGLE is not set
# CONFIG_PINCTRL_STARFIVE is not set
# CONFIG_PINCTRL_STMFX is not set
CONFIG_PINCTRL_SX150X=y
# CONFIG_PINCTRL_OWL is not set
# CONFIG_PINCTRL_ASPEED_G4 is not set
# CONFIG_PINCTRL_ASPEED_G5 is not set
# CONFIG_PINCTRL_ASPEED_G6 is not set
# CONFIG_PINCTRL_BCM281XX is not set
# CONFIG_PINCTRL_BCM2835 is not set
# CONFIG_PINCTRL_BCM4908 is not set
# CONFIG_PINCTRL_BCM6318 is not set
# CONFIG_PINCTRL_BCM6328 is not set
# CONFIG_PINCTRL_BCM6358 is not set
# CONFIG_PINCTRL_BCM6362 is not set
# CONFIG_PINCTRL_BCM6368 is not set
# CONFIG_PINCTRL_BCM63268 is not set
# CONFIG_PINCTRL_IPROC_GPIO is not set
# CONFIG_PINCTRL_CYGNUS_MUX is not set
# CONFIG_PINCTRL_NS is not set
# CONFIG_PINCTRL_NSP_GPIO is not set
# CONFIG_PINCTRL_NS2_MUX is not set
# CONFIG_PINCTRL_NSP_MUX is not set
# CONFIG_PINCTRL_AS370 is not set
# CONFIG_PINCTRL_BERLIN_BG4CT is not set
CONFIG_PINCTRL_MADERA=y
CONFIG_PINCTRL_CS47L15=y
CONFIG_PINCTRL_CS47L85=y
CONFIG_PINCTRL_CS47L92=y

#
# Intel pinctrl drivers
#
CONFIG_PINCTRL_BAYTRAIL=y
# CONFIG_PINCTRL_CHERRYVIEW is not set
CONFIG_PINCTRL_LYNXPOINT=y
CONFIG_PINCTRL_INTEL=y
CONFIG_PINCTRL_ALDERLAKE=y
CONFIG_PINCTRL_BROXTON=y
CONFIG_PINCTRL_CANNONLAKE=y
CONFIG_PINCTRL_CEDARFORK=y
CONFIG_PINCTRL_DENVERTON=y
CONFIG_PINCTRL_ELKHARTLAKE=y
CONFIG_PINCTRL_EMMITSBURG=y
# CONFIG_PINCTRL_GEMINILAKE is not set
CONFIG_PINCTRL_ICELAKE=y
CONFIG_PINCTRL_JASPERLAKE=y
# CONFIG_PINCTRL_LAKEFIELD is not set
CONFIG_PINCTRL_LEWISBURG=y
CONFIG_PINCTRL_SUNRISEPOINT=y
# CONFIG_PINCTRL_TIGERLAKE is not set
# end of Intel pinctrl drivers

#
# MediaTek pinctrl drivers
#
# CONFIG_EINT_MTK is not set
# CONFIG_PINCTRL_MT2701 is not set
# CONFIG_PINCTRL_MT7623 is not set
# CONFIG_PINCTRL_MT7629 is not set
# CONFIG_PINCTRL_MT8135 is not set
# CONFIG_PINCTRL_MT8127 is not set
# CONFIG_PINCTRL_MT2712 is not set
# CONFIG_PINCTRL_MT6765 is not set
# CONFIG_PINCTRL_MT6779 is not set
# CONFIG_PINCTRL_MT6795 is not set
# CONFIG_PINCTRL_MT6797 is not set
# CONFIG_PINCTRL_MT7622 is not set
# CONFIG_PINCTRL_MT7986 is not set
# CONFIG_PINCTRL_MT8167 is not set
# CONFIG_PINCTRL_MT8173 is not set
# CONFIG_PINCTRL_MT8183 is not set
# CONFIG_PINCTRL_MT8186 is not set
# CONFIG_PINCTRL_MT8192 is not set
# CONFIG_PINCTRL_MT8195 is not set
# CONFIG_PINCTRL_MT8365 is not set
# CONFIG_PINCTRL_MT8516 is not set
# CONFIG_PINCTRL_MT6397 is not set
# end of MediaTek pinctrl drivers

CONFIG_PINCTRL_MESON=y
# CONFIG_PINCTRL_WPCM450 is not set
# CONFIG_PINCTRL_NPCM7XX is not set
CONFIG_PINCTRL_PXA=y
CONFIG_PINCTRL_PXA25X=y
CONFIG_PINCTRL_PXA27X=y
CONFIG_PINCTRL_MSM=y
# CONFIG_PINCTRL_APQ8064 is not set
# CONFIG_PINCTRL_APQ8084 is not set
# CONFIG_PINCTRL_IPQ4019 is not set
# CONFIG_PINCTRL_IPQ8064 is not set
# CONFIG_PINCTRL_IPQ8074 is not set
# CONFIG_PINCTRL_IPQ6018 is not set
# CONFIG_PINCTRL_MSM8226 is not set
# CONFIG_PINCTRL_MSM8660 is not set
# CONFIG_PINCTRL_MSM8960 is not set
# CONFIG_PINCTRL_MDM9607 is not set
# CONFIG_PINCTRL_MDM9615 is not set
# CONFIG_PINCTRL_MSM8X74 is not set
# CONFIG_PINCTRL_MSM8916 is not set
# CONFIG_PINCTRL_MSM8953 is not set
# CONFIG_PINCTRL_MSM8976 is not set
# CONFIG_PINCTRL_MSM8994 is not set
# CONFIG_PINCTRL_MSM8996 is not set
# CONFIG_PINCTRL_MSM8998 is not set
# CONFIG_PINCTRL_QCM2290 is not set
# CONFIG_PINCTRL_QCS404 is not set
# CONFIG_PINCTRL_QDF2XXX is not set
# CONFIG_PINCTRL_QCOM_SPMI_PMIC is not set
# CONFIG_PINCTRL_QCOM_SSBI_PMIC is not set
# CONFIG_PINCTRL_SC7180 is not set
# CONFIG_PINCTRL_SC7280 is not set
CONFIG_PINCTRL_SC8180X=y
# CONFIG_PINCTRL_SC8280XP is not set
# CONFIG_PINCTRL_SDM660 is not set
CONFIG_PINCTRL_SDM845=y
# CONFIG_PINCTRL_SDX55 is not set
# CONFIG_PINCTRL_SM6115 is not set
# CONFIG_PINCTRL_SM6125 is not set
# CONFIG_PINCTRL_SM6350 is not set
# CONFIG_PINCTRL_SDX65 is not set
# CONFIG_PINCTRL_SM8150 is not set
# CONFIG_PINCTRL_SM8250 is not set
CONFIG_PINCTRL_SM8350=y
# CONFIG_PINCTRL_SM8450 is not set
# CONFIG_PINCTRL_LPASS_LPI is not set

#
# Renesas pinctrl drivers
#
# CONFIG_PINCTRL_RENESAS is not set
CONFIG_PINCTRL_SH_PFC=y
CONFIG_PINCTRL_SH_PFC_GPIO=y
CONFIG_PINCTRL_SH_FUNC_GPIO=y
# CONFIG_PINCTRL_PFC_EMEV2 is not set
CONFIG_PINCTRL_PFC_R8A77995=y
CONFIG_PINCTRL_PFC_R8A7794=y
CONFIG_PINCTRL_PFC_R8A77990=y
# CONFIG_PINCTRL_PFC_R8A7779 is not set
# CONFIG_PINCTRL_PFC_R8A7790 is not set
# CONFIG_PINCTRL_PFC_R8A77950 is not set
CONFIG_PINCTRL_PFC_R8A77951=y
CONFIG_PINCTRL_PFC_R8A7778=y
# CONFIG_PINCTRL_PFC_R8A7793 is not set
CONFIG_PINCTRL_PFC_R8A7791=y
CONFIG_PINCTRL_PFC_R8A77965=y
CONFIG_PINCTRL_PFC_R8A77960=y
CONFIG_PINCTRL_PFC_R8A77961=y
# CONFIG_PINCTRL_PFC_R8A779F0 is not set
CONFIG_PINCTRL_PFC_R8A7792=y
# CONFIG_PINCTRL_PFC_R8A77980 is not set
CONFIG_PINCTRL_PFC_R8A77970=y
CONFIG_PINCTRL_PFC_R8A779A0=y
# CONFIG_PINCTRL_PFC_R8A7740 is not set
# CONFIG_PINCTRL_PFC_R8A73A4 is not set
# CONFIG_PINCTRL_RZA1 is not set
# CONFIG_PINCTRL_RZA2 is not set
# CONFIG_PINCTRL_RZG2L is not set
CONFIG_PINCTRL_PFC_R8A77470=y
CONFIG_PINCTRL_PFC_R8A7745=y
# CONFIG_PINCTRL_PFC_R8A7742 is not set
CONFIG_PINCTRL_PFC_R8A7743=y
CONFIG_PINCTRL_PFC_R8A7744=y
# CONFIG_PINCTRL_PFC_R8A774C0 is not set
# CONFIG_PINCTRL_PFC_R8A774E1 is not set
CONFIG_PINCTRL_PFC_R8A774A1=y
CONFIG_PINCTRL_PFC_R8A774B1=y
# CONFIG_PINCTRL_RZN1 is not set
# CONFIG_PINCTRL_PFC_SH7203 is not set
CONFIG_PINCTRL_PFC_SH7264=y
# CONFIG_PINCTRL_PFC_SH7269 is not set
# CONFIG_PINCTRL_PFC_SH7720 is not set
CONFIG_PINCTRL_PFC_SH7722=y
# CONFIG_PINCTRL_PFC_SH7734 is not set
CONFIG_PINCTRL_PFC_SH7757=y
# CONFIG_PINCTRL_PFC_SH7785 is not set
CONFIG_PINCTRL_PFC_SH7786=y
# CONFIG_PINCTRL_PFC_SH73A0 is not set
CONFIG_PINCTRL_PFC_SH7723=y
CONFIG_PINCTRL_PFC_SH7724=y
CONFIG_PINCTRL_PFC_SHX3=y
# end of Renesas pinctrl drivers

# CONFIG_PINCTRL_EXYNOS is not set
# CONFIG_PINCTRL_S3C24XX is not set
# CONFIG_PINCTRL_S3C64XX is not set
# CONFIG_PINCTRL_SPRD_SC9860 is not set
# CONFIG_PINCTRL_STM32F429 is not set
# CONFIG_PINCTRL_STM32F469 is not set
# CONFIG_PINCTRL_STM32F746 is not set
# CONFIG_PINCTRL_STM32F769 is not set
# CONFIG_PINCTRL_STM32H743 is not set
# CONFIG_PINCTRL_STM32MP135 is not set
# CONFIG_PINCTRL_STM32MP157 is not set
# CONFIG_PINCTRL_TI_IODELAY is not set
CONFIG_PINCTRL_UNIPHIER=y
# CONFIG_PINCTRL_UNIPHIER_LD4 is not set
# CONFIG_PINCTRL_UNIPHIER_PRO4 is not set
# CONFIG_PINCTRL_UNIPHIER_SLD8 is not set
# CONFIG_PINCTRL_UNIPHIER_PRO5 is not set
# CONFIG_PINCTRL_UNIPHIER_PXS2 is not set
# CONFIG_PINCTRL_UNIPHIER_LD6B is not set
# CONFIG_PINCTRL_UNIPHIER_LD11 is not set
# CONFIG_PINCTRL_UNIPHIER_LD20 is not set
# CONFIG_PINCTRL_UNIPHIER_PXS3 is not set
# CONFIG_PINCTRL_UNIPHIER_NX1 is not set
# CONFIG_PINCTRL_TMPV7700 is not set
CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_OF_GPIO=y
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_CDEV=y
CONFIG_GPIO_CDEV_V1=y
CONFIG_GPIO_GENERIC=y
CONFIG_GPIO_REGMAP=y
CONFIG_GPIO_MAX730X=y

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_74XX_MMIO is not set
# CONFIG_GPIO_ALTERA is not set
CONFIG_GPIO_AMDPT=y
# CONFIG_GPIO_ASPEED is not set
# CONFIG_GPIO_ASPEED_SGPIO is not set
CONFIG_GPIO_ATH79=y
# CONFIG_GPIO_RASPBERRYPI_EXP is not set
# CONFIG_GPIO_BCM_KONA is not set
# CONFIG_GPIO_BCM_XGS_IPROC is not set
# CONFIG_GPIO_BRCMSTB is not set
# CONFIG_GPIO_CADENCE is not set
# CONFIG_GPIO_CLPS711X is not set
CONFIG_GPIO_DWAPB=y
# CONFIG_GPIO_EIC_SPRD is not set
# CONFIG_GPIO_EM is not set
# CONFIG_GPIO_FTGPIO010 is not set
CONFIG_GPIO_GENERIC_PLATFORM=y
# CONFIG_GPIO_GRGPIO is not set
# CONFIG_GPIO_HISI is not set
# CONFIG_GPIO_HLWD is not set
CONFIG_GPIO_IOP=y
# CONFIG_GPIO_LOGICVC is not set
# CONFIG_GPIO_LPC18XX is not set
# CONFIG_GPIO_LPC32XX is not set
CONFIG_GPIO_MB86S7X=y
CONFIG_GPIO_MENZ127=y
CONFIG_GPIO_MPC8XXX=y
# CONFIG_GPIO_MT7621 is not set
CONFIG_GPIO_MXC=y
# CONFIG_GPIO_MXS is not set
# CONFIG_GPIO_PMIC_EIC_SPRD is not set
CONFIG_GPIO_PXA=y
CONFIG_GPIO_RCAR=y
# CONFIG_GPIO_RDA is not set
CONFIG_GPIO_ROCKCHIP=y
# CONFIG_GPIO_SAMA5D2_PIOBU is not set
# CONFIG_GPIO_SIFIVE is not set
# CONFIG_GPIO_SIOX is not set
# CONFIG_GPIO_SNPS_CREG is not set
# CONFIG_GPIO_SPRD is not set
# CONFIG_GPIO_STP_XWAY is not set
# CONFIG_GPIO_SYSCON is not set
# CONFIG_GPIO_TEGRA is not set
# CONFIG_GPIO_TEGRA186 is not set
# CONFIG_GPIO_TS4800 is not set
CONFIG_GPIO_THUNDERX=y
# CONFIG_GPIO_UNIPHIER is not set
# CONFIG_GPIO_VISCONTI is not set
# CONFIG_GPIO_VX855 is not set
CONFIG_GPIO_XGENE_SB=y
# CONFIG_GPIO_XILINX is not set
# CONFIG_GPIO_XLP is not set
CONFIG_GPIO_AMD_FCH=y
CONFIG_GPIO_IDT3243X=y
# end of Memory mapped GPIO drivers

#
# I2C GPIO expanders
#
# CONFIG_GPIO_ADP5588 is not set
# CONFIG_GPIO_ADNP is not set
# CONFIG_GPIO_GW_PLD is not set
CONFIG_GPIO_MAX7300=y
CONFIG_GPIO_MAX732X=y
CONFIG_GPIO_MAX732X_IRQ=y
CONFIG_GPIO_PCA953X=y
CONFIG_GPIO_PCA953X_IRQ=y
CONFIG_GPIO_PCA9570=y
CONFIG_GPIO_PCF857X=y
CONFIG_GPIO_TPIC2810=y
CONFIG_GPIO_TS4900=y
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
CONFIG_GPIO_ADP5520=y
CONFIG_GPIO_ARIZONA=y
CONFIG_GPIO_BD9571MWV=y
# CONFIG_GPIO_DA9052 is not set
# CONFIG_GPIO_JANZ_TTL is not set
# CONFIG_GPIO_LP873X is not set
# CONFIG_GPIO_MADERA is not set
CONFIG_GPIO_MAX77620=y
# CONFIG_GPIO_MAX77650 is not set
CONFIG_GPIO_SL28CPLD=y
# CONFIG_GPIO_TIMBERDALE is not set
CONFIG_GPIO_TPS65086=y
# CONFIG_GPIO_TPS65910 is not set
# CONFIG_GPIO_TQMX86 is not set
CONFIG_GPIO_WM831X=y
CONFIG_GPIO_WM8994=y
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
CONFIG_GPIO_AMD8111=y
# CONFIG_GPIO_BT8XX is not set
CONFIG_GPIO_MLXBF=y
CONFIG_GPIO_MLXBF2=y
CONFIG_GPIO_ML_IOH=y
CONFIG_GPIO_PCH=y
CONFIG_GPIO_PCI_IDIO_16=y
CONFIG_GPIO_PCIE_IDIO_24=y
# CONFIG_GPIO_RDC321X is not set
# end of PCI GPIO expanders

#
# SPI GPIO expanders
#
# CONFIG_GPIO_74X164 is not set
CONFIG_GPIO_MAX3191X=y
CONFIG_GPIO_MAX7301=y
CONFIG_GPIO_MC33880=y
CONFIG_GPIO_PISOSR=y
CONFIG_GPIO_XRA1403=y
# end of SPI GPIO expanders

#
# Virtual GPIO drivers
#
CONFIG_GPIO_AGGREGATOR=y
CONFIG_GPIO_MOCKUP=y
CONFIG_GPIO_VIRTIO=y
CONFIG_GPIO_SIM=y
# end of Virtual GPIO drivers

CONFIG_W1=y

#
# 1-wire Bus Masters
#
# CONFIG_W1_MASTER_MATROX is not set
# CONFIG_W1_MASTER_DS2482 is not set
CONFIG_W1_MASTER_MXC=y
CONFIG_W1_MASTER_DS1WM=y
# CONFIG_W1_MASTER_GPIO is not set
CONFIG_W1_MASTER_SGI=y
# end of 1-wire Bus Masters

#
# 1-wire Slaves
#
CONFIG_W1_SLAVE_THERM=y
# CONFIG_W1_SLAVE_SMEM is not set
CONFIG_W1_SLAVE_DS2405=y
# CONFIG_W1_SLAVE_DS2408 is not set
CONFIG_W1_SLAVE_DS2413=y
CONFIG_W1_SLAVE_DS2406=y
CONFIG_W1_SLAVE_DS2423=y
# CONFIG_W1_SLAVE_DS2805 is not set
CONFIG_W1_SLAVE_DS2430=y
# CONFIG_W1_SLAVE_DS2431 is not set
# CONFIG_W1_SLAVE_DS2433 is not set
CONFIG_W1_SLAVE_DS2438=y
CONFIG_W1_SLAVE_DS250X=y
CONFIG_W1_SLAVE_DS2780=y
CONFIG_W1_SLAVE_DS2781=y
CONFIG_W1_SLAVE_DS28E04=y
# CONFIG_W1_SLAVE_DS28E17 is not set
# end of 1-wire Slaves

CONFIG_POWER_RESET=y
CONFIG_POWER_RESET_ATC260X=y
# CONFIG_POWER_RESET_BRCMKONA is not set
# CONFIG_POWER_RESET_BRCMSTB is not set
# CONFIG_POWER_RESET_GEMINI_POWEROFF is not set
# CONFIG_POWER_RESET_GPIO is not set
# CONFIG_POWER_RESET_GPIO_RESTART is not set
CONFIG_POWER_RESET_OCELOT_RESET=y
# CONFIG_POWER_RESET_PIIX4_POWEROFF is not set
# CONFIG_POWER_RESET_LTC2952 is not set
# CONFIG_POWER_RESET_REGULATOR is not set
# CONFIG_POWER_RESET_RESTART is not set
# CONFIG_POWER_RESET_TPS65086 is not set
# CONFIG_POWER_RESET_KEYSTONE is not set
# CONFIG_POWER_RESET_SYSCON is not set
# CONFIG_POWER_RESET_SYSCON_POWEROFF is not set
# CONFIG_POWER_RESET_RMOBILE is not set
# CONFIG_SYSCON_REBOOT_MODE is not set
CONFIG_POWER_RESET_SC27XX=y
# CONFIG_NVMEM_REBOOT_MODE is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_POWER_SUPPLY_HWMON=y
CONFIG_PDA_POWER=y
CONFIG_GENERIC_ADC_BATTERY=y
# CONFIG_IP5XXX_POWER is not set
# CONFIG_WM831X_BACKUP is not set
CONFIG_WM831X_POWER=y
CONFIG_TEST_POWER=y
CONFIG_BATTERY_88PM860X=y
CONFIG_CHARGER_ADP5061=y
# CONFIG_BATTERY_ACT8945A is not set
CONFIG_BATTERY_CW2015=y
CONFIG_BATTERY_DS2760=y
CONFIG_BATTERY_DS2780=y
CONFIG_BATTERY_DS2781=y
# CONFIG_BATTERY_DS2782 is not set
# CONFIG_BATTERY_LEGO_EV3 is not set
# CONFIG_BATTERY_SAMSUNG_SDI is not set
CONFIG_BATTERY_INGENIC=y
CONFIG_BATTERY_SBS=y
# CONFIG_CHARGER_SBS is not set
CONFIG_MANAGER_SBS=y
CONFIG_BATTERY_BQ27XXX=y
CONFIG_BATTERY_BQ27XXX_I2C=y
# CONFIG_BATTERY_BQ27XXX_HDQ is not set
CONFIG_BATTERY_BQ27XXX_DT_UPDATES_NVM=y
# CONFIG_BATTERY_DA9052 is not set
# CONFIG_BATTERY_DA9150 is not set
CONFIG_CHARGER_AXP20X=y
CONFIG_BATTERY_AXP20X=y
CONFIG_AXP20X_POWER=y
CONFIG_BATTERY_MAX17040=y
CONFIG_BATTERY_MAX17042=y
# CONFIG_BATTERY_MAX1721X is not set
# CONFIG_CHARGER_88PM860X is not set
CONFIG_CHARGER_PCF50633=y
CONFIG_CHARGER_MAX8903=y
CONFIG_CHARGER_LP8727=y
CONFIG_CHARGER_LP8788=y
# CONFIG_CHARGER_GPIO is not set
CONFIG_CHARGER_MANAGER=y
CONFIG_CHARGER_LT3651=y
# CONFIG_CHARGER_LTC4162L is not set
# CONFIG_CHARGER_DETECTOR_MAX14656 is not set
# CONFIG_CHARGER_MAX77650 is not set
CONFIG_CHARGER_MAX77976=y
CONFIG_CHARGER_MT6360=y
# CONFIG_CHARGER_QCOM_SMBB is not set
CONFIG_CHARGER_BQ2415X=y
CONFIG_CHARGER_BQ24190=y
CONFIG_CHARGER_BQ24257=y
CONFIG_CHARGER_BQ24735=y
CONFIG_CHARGER_BQ2515X=y
# CONFIG_CHARGER_BQ25890 is not set
# CONFIG_CHARGER_BQ25980 is not set
# CONFIG_CHARGER_BQ256XX is not set
# CONFIG_CHARGER_SMB347 is not set
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
# CONFIG_BATTERY_GOLDFISH is not set
CONFIG_BATTERY_RT5033=y
CONFIG_CHARGER_RT9455=y
CONFIG_CHARGER_SC2731=y
CONFIG_FUEL_GAUGE_SC27XX=y
# CONFIG_CHARGER_UCS1002 is not set
CONFIG_CHARGER_BD99954=y
CONFIG_BATTERY_UG3105=y
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
CONFIG_HWMON_DEBUG_CHIP=y

#
# Native drivers
#
# CONFIG_SENSORS_AD7314 is not set
CONFIG_SENSORS_AD7414=y
CONFIG_SENSORS_AD7418=y
# CONFIG_SENSORS_ADM1021 is not set
# CONFIG_SENSORS_ADM1025 is not set
# CONFIG_SENSORS_ADM1026 is not set
CONFIG_SENSORS_ADM1029=y
CONFIG_SENSORS_ADM1031=y
CONFIG_SENSORS_ADM1177=y
CONFIG_SENSORS_ADM9240=y
CONFIG_SENSORS_ADT7X10=y
CONFIG_SENSORS_ADT7310=y
# CONFIG_SENSORS_ADT7410 is not set
# CONFIG_SENSORS_ADT7411 is not set
CONFIG_SENSORS_ADT7462=y
# CONFIG_SENSORS_ADT7470 is not set
CONFIG_SENSORS_ADT7475=y
CONFIG_SENSORS_AHT10=y
# CONFIG_SENSORS_AS370 is not set
CONFIG_SENSORS_ASC7621=y
CONFIG_SENSORS_AXI_FAN_CONTROL=y
CONFIG_SENSORS_ARM_SCMI=y
CONFIG_SENSORS_ASPEED=y
CONFIG_SENSORS_ATXP1=y
# CONFIG_SENSORS_BT1_PVT is not set
CONFIG_SENSORS_CORSAIR_CPRO=y
# CONFIG_SENSORS_CORSAIR_PSU is not set
CONFIG_SENSORS_DRIVETEMP=y
CONFIG_SENSORS_DS620=y
# CONFIG_SENSORS_DS1621 is not set
# CONFIG_SENSORS_DA9052_ADC is not set
CONFIG_SENSORS_I5K_AMB=y
CONFIG_SENSORS_SPARX5=y
CONFIG_SENSORS_F71805F=y
CONFIG_SENSORS_F71882FG=y
# CONFIG_SENSORS_F75375S is not set
CONFIG_SENSORS_MC13783_ADC=y
CONFIG_SENSORS_GL518SM=y
CONFIG_SENSORS_GL520SM=y
CONFIG_SENSORS_G760A=y
CONFIG_SENSORS_G762=y
# CONFIG_SENSORS_GPIO_FAN is not set
CONFIG_SENSORS_HIH6130=y
# CONFIG_SENSORS_IBMAEM is not set
# CONFIG_SENSORS_IBMPEX is not set
CONFIG_SENSORS_IIO_HWMON=y
CONFIG_SENSORS_IT87=y
# CONFIG_SENSORS_JC42 is not set
CONFIG_SENSORS_POWR1220=y
CONFIG_SENSORS_LAN966X=y
CONFIG_SENSORS_LINEAGE=y
# CONFIG_SENSORS_LTC2945 is not set
CONFIG_SENSORS_LTC2947=y
# CONFIG_SENSORS_LTC2947_I2C is not set
CONFIG_SENSORS_LTC2947_SPI=y
CONFIG_SENSORS_LTC2990=y
CONFIG_SENSORS_LTC2992=y
# CONFIG_SENSORS_LTC4151 is not set
CONFIG_SENSORS_LTC4215=y
# CONFIG_SENSORS_LTC4222 is not set
# CONFIG_SENSORS_LTC4245 is not set
CONFIG_SENSORS_LTC4260=y
CONFIG_SENSORS_LTC4261=y
# CONFIG_SENSORS_MAX1111 is not set
CONFIG_SENSORS_MAX127=y
CONFIG_SENSORS_MAX16065=y
CONFIG_SENSORS_MAX1619=y
CONFIG_SENSORS_MAX1668=y
CONFIG_SENSORS_MAX197=y
CONFIG_SENSORS_MAX31722=y
CONFIG_SENSORS_MAX31730=y
CONFIG_SENSORS_MAX6620=y
CONFIG_SENSORS_MAX6621=y
CONFIG_SENSORS_MAX6639=y
# CONFIG_SENSORS_MAX6642 is not set
CONFIG_SENSORS_MAX6650=y
CONFIG_SENSORS_MAX6697=y
CONFIG_SENSORS_MAX31790=y
# CONFIG_SENSORS_MCP3021 is not set
CONFIG_SENSORS_MLXREG_FAN=y
CONFIG_SENSORS_TC654=y
# CONFIG_SENSORS_TPS23861 is not set
CONFIG_SENSORS_MR75203=y
CONFIG_SENSORS_ADCXX=y
# CONFIG_SENSORS_LM63 is not set
CONFIG_SENSORS_LM70=y
CONFIG_SENSORS_LM73=y
CONFIG_SENSORS_LM75=y
CONFIG_SENSORS_LM77=y
CONFIG_SENSORS_LM78=y
# CONFIG_SENSORS_LM80 is not set
CONFIG_SENSORS_LM83=y
# CONFIG_SENSORS_LM85 is not set
CONFIG_SENSORS_LM87=y
CONFIG_SENSORS_LM90=y
CONFIG_SENSORS_LM92=y
# CONFIG_SENSORS_LM93 is not set
# CONFIG_SENSORS_LM95234 is not set
CONFIG_SENSORS_LM95241=y
CONFIG_SENSORS_LM95245=y
# CONFIG_SENSORS_PC87360 is not set
CONFIG_SENSORS_PC87427=y
CONFIG_SENSORS_NTC_THERMISTOR=y
CONFIG_SENSORS_NCT6683=y
CONFIG_SENSORS_NCT6775_CORE=y
CONFIG_SENSORS_NCT6775=y
CONFIG_SENSORS_NCT6775_I2C=y
CONFIG_SENSORS_NCT7802=y
CONFIG_SENSORS_NPCM7XX=y
# CONFIG_SENSORS_NSA320 is not set
# CONFIG_SENSORS_OCC_P8_I2C is not set
CONFIG_SENSORS_PCF8591=y
# CONFIG_SENSORS_PECI_CPUTEMP is not set
# CONFIG_SENSORS_PECI_DIMMTEMP is not set
# CONFIG_PMBUS is not set
CONFIG_SENSORS_PWM_FAN=y
# CONFIG_SENSORS_RASPBERRYPI_HWMON is not set
# CONFIG_SENSORS_SL28CPLD is not set
# CONFIG_SENSORS_SBTSI is not set
# CONFIG_SENSORS_SBRMI is not set
# CONFIG_SENSORS_SHT15 is not set
# CONFIG_SENSORS_SHT21 is not set
# CONFIG_SENSORS_SHT3x is not set
# CONFIG_SENSORS_SHT4x is not set
CONFIG_SENSORS_SHTC1=y
CONFIG_SENSORS_SIS5595=y
CONFIG_SENSORS_SY7636A=y
CONFIG_SENSORS_DME1737=y
# CONFIG_SENSORS_EMC1403 is not set
# CONFIG_SENSORS_EMC2103 is not set
CONFIG_SENSORS_EMC6W201=y
# CONFIG_SENSORS_SMSC47M1 is not set
# CONFIG_SENSORS_SMSC47M192 is not set
# CONFIG_SENSORS_SMSC47B397 is not set
# CONFIG_SENSORS_STTS751 is not set
# CONFIG_SENSORS_SMM665 is not set
# CONFIG_SENSORS_ADC128D818 is not set
CONFIG_SENSORS_ADS7828=y
# CONFIG_SENSORS_ADS7871 is not set
CONFIG_SENSORS_AMC6821=y
# CONFIG_SENSORS_INA209 is not set
CONFIG_SENSORS_INA2XX=y
# CONFIG_SENSORS_INA238 is not set
CONFIG_SENSORS_INA3221=y
CONFIG_SENSORS_TC74=y
# CONFIG_SENSORS_THMC50 is not set
# CONFIG_SENSORS_TMP102 is not set
# CONFIG_SENSORS_TMP103 is not set
# CONFIG_SENSORS_TMP108 is not set
CONFIG_SENSORS_TMP401=y
CONFIG_SENSORS_TMP421=y
CONFIG_SENSORS_TMP464=y
CONFIG_SENSORS_TMP513=y
CONFIG_SENSORS_VIA686A=y
CONFIG_SENSORS_VT1211=y
CONFIG_SENSORS_VT8231=y
CONFIG_SENSORS_W83773G=y
CONFIG_SENSORS_W83781D=y
CONFIG_SENSORS_W83791D=y
# CONFIG_SENSORS_W83792D is not set
CONFIG_SENSORS_W83793=y
CONFIG_SENSORS_W83795=y
CONFIG_SENSORS_W83795_FANCTRL=y
CONFIG_SENSORS_W83L785TS=y
CONFIG_SENSORS_W83L786NG=y
# CONFIG_SENSORS_W83627HF is not set
CONFIG_SENSORS_W83627EHF=y
CONFIG_SENSORS_WM831X=y
# CONFIG_SENSORS_XGENE is not set

#
# ACPI drivers
#
# CONFIG_SENSORS_ACPI_POWER is not set
CONFIG_THERMAL=y
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
# CONFIG_THERMAL_HWMON is not set
CONFIG_THERMAL_OF=y
# CONFIG_THERMAL_WRITABLE_TRIPS is not set
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
# CONFIG_THERMAL_GOV_FAIR_SHARE is not set
CONFIG_THERMAL_GOV_STEP_WISE=y
# CONFIG_THERMAL_GOV_BANG_BANG is not set
# CONFIG_THERMAL_GOV_USER_SPACE is not set
# CONFIG_CPU_THERMAL is not set
# CONFIG_DEVFREQ_THERMAL is not set
CONFIG_THERMAL_EMULATION=y
# CONFIG_THERMAL_MMIO is not set
CONFIG_HISI_THERMAL=y
# CONFIG_IMX_THERMAL is not set
# CONFIG_IMX8MM_THERMAL is not set
CONFIG_K3_THERMAL=y
# CONFIG_MAX77620_THERMAL is not set
# CONFIG_QORIQ_THERMAL is not set
# CONFIG_SPEAR_THERMAL is not set
# CONFIG_SUN8I_THERMAL is not set
# CONFIG_ROCKCHIP_THERMAL is not set
CONFIG_RCAR_THERMAL=y
# CONFIG_RCAR_GEN3_THERMAL is not set
# CONFIG_RZG2L_THERMAL is not set
# CONFIG_KIRKWOOD_THERMAL is not set
# CONFIG_DOVE_THERMAL is not set
# CONFIG_ARMADA_THERMAL is not set
# CONFIG_DA9062_THERMAL is not set
CONFIG_MTK_THERMAL=y

#
# Intel thermal drivers
#

#
# ACPI INT340X thermal drivers
#
# end of ACPI INT340X thermal drivers
# end of Intel thermal drivers

#
# Broadcom thermal drivers
#
# CONFIG_BCM2711_THERMAL is not set
# CONFIG_BCM2835_THERMAL is not set
# CONFIG_BRCMSTB_THERMAL is not set
# CONFIG_BCM_NS_THERMAL is not set
# CONFIG_BCM_SR_THERMAL is not set
# end of Broadcom thermal drivers

#
# Texas Instruments thermal drivers
#
# CONFIG_TI_SOC_THERMAL is not set
# end of Texas Instruments thermal drivers

#
# Samsung thermal drivers
#
# CONFIG_EXYNOS_THERMAL is not set
# end of Samsung thermal drivers

#
# NVIDIA Tegra thermal drivers
#
CONFIG_TEGRA_SOCTHERM=y
CONFIG_TEGRA_BPMP_THERMAL=y
CONFIG_TEGRA30_TSENSOR=y
# end of NVIDIA Tegra thermal drivers

CONFIG_GENERIC_ADC_THERMAL=y

#
# Qualcomm thermal drivers
#
# CONFIG_QCOM_SPMI_ADC_TM5 is not set
# CONFIG_QCOM_SPMI_TEMP_ALARM is not set
# end of Qualcomm thermal drivers

# CONFIG_UNIPHIER_THERMAL is not set
CONFIG_SPRD_THERMAL=y
# CONFIG_WATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=y
CONFIG_SSB_SPROM=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
CONFIG_SSB_PCIHOST=y
# CONFIG_SSB_HOST_SOC is not set
CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
CONFIG_SSB_DRIVER_PCICORE=y
# CONFIG_SSB_DRIVER_GPIO is not set
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=y
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
# CONFIG_BCMA_HOST_SOC is not set
CONFIG_BCMA_DRIVER_PCI=y
# CONFIG_BCMA_DRIVER_MIPS is not set
# CONFIG_BCMA_DRIVER_GMAC_CMN is not set
# CONFIG_BCMA_DRIVER_GPIO is not set
CONFIG_BCMA_DEBUG=y

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_ACT8945A is not set
CONFIG_MFD_SUN4I_GPADC=y
CONFIG_MFD_AS3711=y
# CONFIG_MFD_AS3722 is not set
CONFIG_PMIC_ADP5520=y
CONFIG_MFD_AAT2870_CORE=y
CONFIG_MFD_AT91_USART=y
# CONFIG_MFD_ATMEL_FLEXCOM is not set
# CONFIG_MFD_ATMEL_HLCDC is not set
# CONFIG_MFD_BCM590XX is not set
CONFIG_MFD_BD9571MWV=y
CONFIG_MFD_AXP20X=y
CONFIG_MFD_AXP20X_I2C=y
CONFIG_MFD_MADERA=y
CONFIG_MFD_MADERA_I2C=y
CONFIG_MFD_MADERA_SPI=y
CONFIG_MFD_CS47L15=y
# CONFIG_MFD_CS47L35 is not set
CONFIG_MFD_CS47L85=y
# CONFIG_MFD_CS47L90 is not set
CONFIG_MFD_CS47L92=y
# CONFIG_MFD_ASIC3 is not set
# CONFIG_PMIC_DA903X is not set
CONFIG_PMIC_DA9052=y
CONFIG_MFD_DA9052_SPI=y
# CONFIG_MFD_DA9052_I2C is not set
# CONFIG_MFD_DA9055 is not set
CONFIG_MFD_DA9062=y
CONFIG_MFD_DA9063=y
CONFIG_MFD_DA9150=y
CONFIG_MFD_ENE_KB3930=y
CONFIG_MFD_EXYNOS_LPASS=y
# CONFIG_MFD_GATEWORKS_GSC is not set
CONFIG_MFD_MC13XXX=y
CONFIG_MFD_MC13XXX_SPI=y
CONFIG_MFD_MC13XXX_I2C=y
# CONFIG_MFD_MP2629 is not set
CONFIG_MFD_MXS_LRADC=y
CONFIG_MFD_MX25_TSADC=y
# CONFIG_MFD_HI6421_PMIC is not set
# CONFIG_MFD_HI6421_SPMI is not set
# CONFIG_MFD_HI655X_PMIC is not set
CONFIG_HTC_PASIC3=y
# CONFIG_HTC_I2CPLD is not set
CONFIG_LPC_ICH=y
CONFIG_LPC_SCH=y
CONFIG_MFD_IQS62X=y
CONFIG_MFD_JANZ_CMODIO=y
# CONFIG_MFD_KEMPLD is not set
# CONFIG_MFD_88PM800 is not set
CONFIG_MFD_88PM805=y
CONFIG_MFD_88PM860X=y
# CONFIG_MFD_MAX14577 is not set
CONFIG_MFD_MAX77620=y
CONFIG_MFD_MAX77650=y
CONFIG_MFD_MAX77686=y
# CONFIG_MFD_MAX77693 is not set
CONFIG_MFD_MAX77714=y
# CONFIG_MFD_MAX77843 is not set
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
CONFIG_MFD_MAX8997=y
# CONFIG_MFD_MAX8998 is not set
CONFIG_MFD_MT6360=y
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_MENF21BMC is not set
CONFIG_EZX_PCAP=y
# CONFIG_MFD_CPCAP is not set
# CONFIG_MFD_NTXEC is not set
CONFIG_MFD_RETU=y
CONFIG_MFD_PCF50633=y
CONFIG_PCF50633_ADC=y
CONFIG_PCF50633_GPIO=y
# CONFIG_MFD_PM8XXX is not set
# CONFIG_MFD_SPMI_PMIC is not set
# CONFIG_MFD_RDC321X is not set
CONFIG_MFD_RT4831=y
CONFIG_MFD_RT5033=y
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_RK808 is not set
# CONFIG_MFD_RN5T618 is not set
CONFIG_MFD_SEC_CORE=y
# CONFIG_MFD_SI476X_CORE is not set
CONFIG_MFD_SIMPLE_MFD_I2C=y
CONFIG_MFD_SL28CPLD=y
CONFIG_MFD_SM501=y
# CONFIG_MFD_SM501_GPIO is not set
CONFIG_MFD_SKY81452=y
# CONFIG_MFD_SC27XX_PMIC is not set
# CONFIG_ABX500_CORE is not set
# CONFIG_MFD_STMPE is not set
# CONFIG_MFD_SUN6I_PRCM is not set
CONFIG_MFD_SYSCON=y
CONFIG_MFD_TI_AM335X_TSCADC=y
# CONFIG_MFD_LP3943 is not set
CONFIG_MFD_LP8788=y
CONFIG_MFD_TI_LMU=y
# CONFIG_MFD_PALMAS is not set
CONFIG_TPS6105X=y
CONFIG_TPS65010=y
CONFIG_TPS6507X=y
CONFIG_MFD_TPS65086=y
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_TPS65217 is not set
CONFIG_MFD_TI_LP873X=y
# CONFIG_MFD_TI_LP87565 is not set
# CONFIG_MFD_TPS65218 is not set
# CONFIG_MFD_TPS6586X is not set
CONFIG_MFD_TPS65910=y
# CONFIG_MFD_TPS65912_I2C is not set
# CONFIG_MFD_TPS65912_SPI is not set
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
# CONFIG_MFD_WL1273_CORE is not set
CONFIG_MFD_LM3533=y
CONFIG_MFD_TIMBERDALE=y
# CONFIG_MFD_TC3589X is not set
# CONFIG_MFD_TQMX86 is not set
CONFIG_MFD_VX855=y
# CONFIG_MFD_LOCHNAGAR is not set
CONFIG_MFD_ARIZONA=y
CONFIG_MFD_ARIZONA_I2C=y
CONFIG_MFD_ARIZONA_SPI=y
CONFIG_MFD_CS47L24=y
CONFIG_MFD_WM5102=y
# CONFIG_MFD_WM5110 is not set
# CONFIG_MFD_WM8997 is not set
CONFIG_MFD_WM8998=y
CONFIG_MFD_WM8400=y
CONFIG_MFD_WM831X=y
CONFIG_MFD_WM831X_I2C=y
CONFIG_MFD_WM831X_SPI=y
# CONFIG_MFD_WM8350_I2C is not set
CONFIG_MFD_WM8994=y
CONFIG_MFD_STW481X=y
# CONFIG_MFD_ROHM_BD718XX is not set
# CONFIG_MFD_ROHM_BD71828 is not set
# CONFIG_MFD_ROHM_BD957XMUF is not set
# CONFIG_MFD_STM32_LPTIMER is not set
CONFIG_MFD_STM32_TIMERS=y
# CONFIG_MFD_STPMIC1 is not set
CONFIG_MFD_STMFX=y
CONFIG_MFD_ATC260X=y
CONFIG_MFD_ATC260X_I2C=y
# CONFIG_MFD_KHADAS_MCU is not set
# CONFIG_MFD_ACER_A500_EC is not set
# CONFIG_MFD_QCOM_PM8008 is not set
CONFIG_RAVE_SP_CORE=y
# CONFIG_MFD_INTEL_M10_BMC is not set
# CONFIG_MFD_RSMU_I2C is not set
# CONFIG_MFD_RSMU_SPI is not set
# end of Multifunction device drivers

CONFIG_REGULATOR=y
CONFIG_REGULATOR_DEBUG=y
CONFIG_REGULATOR_FIXED_VOLTAGE=y
CONFIG_REGULATOR_VIRTUAL_CONSUMER=y
CONFIG_REGULATOR_USERSPACE_CONSUMER=y
CONFIG_REGULATOR_88PG86X=y
CONFIG_REGULATOR_88PM8607=y
CONFIG_REGULATOR_ACT8865=y
CONFIG_REGULATOR_AD5398=y
CONFIG_REGULATOR_ANATOP=y
# CONFIG_REGULATOR_AAT2870 is not set
# CONFIG_REGULATOR_ARM_SCMI is not set
CONFIG_REGULATOR_AS3711=y
# CONFIG_REGULATOR_ATC260X is not set
CONFIG_REGULATOR_AXP20X=y
# CONFIG_REGULATOR_BD9571MWV is not set
CONFIG_REGULATOR_DA9052=y
CONFIG_REGULATOR_DA9062=y
# CONFIG_REGULATOR_DA9063 is not set
# CONFIG_REGULATOR_DA9121 is not set
CONFIG_REGULATOR_DA9210=y
CONFIG_REGULATOR_DA9211=y
# CONFIG_REGULATOR_FAN53555 is not set
CONFIG_REGULATOR_FAN53880=y
# CONFIG_REGULATOR_GPIO is not set
# CONFIG_REGULATOR_ISL9305 is not set
CONFIG_REGULATOR_ISL6271A=y
CONFIG_REGULATOR_LM363X=y
CONFIG_REGULATOR_LP3971=y
CONFIG_REGULATOR_LP3972=y
CONFIG_REGULATOR_LP872X=y
# CONFIG_REGULATOR_LP873X is not set
# CONFIG_REGULATOR_LP8755 is not set
CONFIG_REGULATOR_LP8788=y
CONFIG_REGULATOR_LTC3589=y
CONFIG_REGULATOR_LTC3676=y
CONFIG_REGULATOR_MAX1586=y
# CONFIG_REGULATOR_MAX77620 is not set
CONFIG_REGULATOR_MAX77650=y
CONFIG_REGULATOR_MAX8649=y
CONFIG_REGULATOR_MAX8660=y
CONFIG_REGULATOR_MAX8893=y
# CONFIG_REGULATOR_MAX8907 is not set
CONFIG_REGULATOR_MAX8952=y
# CONFIG_REGULATOR_MAX8973 is not set
# CONFIG_REGULATOR_MAX8997 is not set
CONFIG_REGULATOR_MAX20086=y
CONFIG_REGULATOR_MAX77686=y
CONFIG_REGULATOR_MAX77693=y
CONFIG_REGULATOR_MAX77802=y
CONFIG_REGULATOR_MAX77826=y
CONFIG_REGULATOR_MC13XXX_CORE=y
CONFIG_REGULATOR_MC13783=y
# CONFIG_REGULATOR_MC13892 is not set
# CONFIG_REGULATOR_MCP16502 is not set
# CONFIG_REGULATOR_MP5416 is not set
CONFIG_REGULATOR_MP8859=y
CONFIG_REGULATOR_MP886X=y
# CONFIG_REGULATOR_MPQ7920 is not set
CONFIG_REGULATOR_MT6311=y
# CONFIG_REGULATOR_MT6315 is not set
# CONFIG_REGULATOR_MT6360 is not set
CONFIG_REGULATOR_PBIAS=y
CONFIG_REGULATOR_PCA9450=y
CONFIG_REGULATOR_PCAP=y
# CONFIG_REGULATOR_PCF50633 is not set
# CONFIG_REGULATOR_PF8X00 is not set
# CONFIG_REGULATOR_PFUZE100 is not set
CONFIG_REGULATOR_PV88060=y
CONFIG_REGULATOR_PV88080=y
CONFIG_REGULATOR_PV88090=y
CONFIG_REGULATOR_QCOM_RPMH=y
CONFIG_REGULATOR_QCOM_SMD_RPM=y
# CONFIG_REGULATOR_QCOM_SPMI is not set
CONFIG_REGULATOR_QCOM_USB_VBUS=y
# CONFIG_REGULATOR_RASPBERRYPI_TOUCHSCREEN_ATTINY is not set
CONFIG_REGULATOR_RT4801=y
# CONFIG_REGULATOR_RT4831 is not set
# CONFIG_REGULATOR_RT5033 is not set
CONFIG_REGULATOR_RT5190A=y
CONFIG_REGULATOR_RT5759=y
# CONFIG_REGULATOR_RT6160 is not set
CONFIG_REGULATOR_RT6245=y
CONFIG_REGULATOR_RTQ2134=y
CONFIG_REGULATOR_RTMV20=y
# CONFIG_REGULATOR_RTQ6752 is not set
# CONFIG_REGULATOR_S2MPA01 is not set
# CONFIG_REGULATOR_S2MPS11 is not set
# CONFIG_REGULATOR_S5M8767 is not set
CONFIG_REGULATOR_SC2731=y
# CONFIG_REGULATOR_SKY81452 is not set
CONFIG_REGULATOR_SLG51000=y
CONFIG_REGULATOR_STM32_BOOSTER=y
# CONFIG_REGULATOR_STM32_VREFBUF is not set
CONFIG_REGULATOR_STM32_PWR=y
# CONFIG_REGULATOR_TI_ABB is not set
# CONFIG_REGULATOR_STW481X_VMMC is not set
CONFIG_REGULATOR_SY7636A=y
CONFIG_REGULATOR_SY8106A=y
CONFIG_REGULATOR_SY8824X=y
CONFIG_REGULATOR_SY8827N=y
CONFIG_REGULATOR_TPS51632=y
CONFIG_REGULATOR_TPS6105X=y
# CONFIG_REGULATOR_TPS62360 is not set
# CONFIG_REGULATOR_TPS6286X is not set
CONFIG_REGULATOR_TPS65023=y
CONFIG_REGULATOR_TPS6507X=y
CONFIG_REGULATOR_TPS65086=y
CONFIG_REGULATOR_TPS65132=y
# CONFIG_REGULATOR_TPS6524X is not set
CONFIG_REGULATOR_TPS65910=y
# CONFIG_REGULATOR_TPS68470 is not set
# CONFIG_REGULATOR_UNIPHIER is not set
# CONFIG_REGULATOR_VCTRL is not set
# CONFIG_REGULATOR_WM831X is not set
# CONFIG_REGULATOR_WM8400 is not set
CONFIG_REGULATOR_WM8994=y
CONFIG_REGULATOR_QCOM_LABIBB=y
CONFIG_RC_CORE=y
CONFIG_LIRC=y
# CONFIG_RC_MAP is not set
# CONFIG_RC_DECODERS is not set
# CONFIG_RC_DEVICES is not set
CONFIG_CEC_CORE=y
CONFIG_CEC_NOTIFIER=y
CONFIG_CEC_PIN=y

#
# CEC support
#
# CONFIG_MEDIA_CEC_RC is not set
CONFIG_CEC_PIN_ERROR_INJ=y
CONFIG_MEDIA_CEC_SUPPORT=y
CONFIG_CEC_CH7322=y
CONFIG_CEC_MESON_AO=y
# CONFIG_CEC_MESON_G12A_AO is not set
CONFIG_CEC_GPIO=y
CONFIG_CEC_SAMSUNG_S5P=y
CONFIG_CEC_STI=y
CONFIG_CEC_STM32=y
# CONFIG_CEC_TEGRA is not set
# end of CEC support

# CONFIG_MEDIA_SUPPORT is not set

#
# Graphics support
#
CONFIG_IMX_IPUV3_CORE=y
CONFIG_DRM=y
CONFIG_DRM_MIPI_DBI=y
CONFIG_DRM_MIPI_DSI=y
CONFIG_DRM_DEBUG_MM=y
# CONFIG_DRM_DEBUG_SELFTEST is not set
CONFIG_DRM_KMS_HELPER=y
# CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS is not set
# CONFIG_DRM_DEBUG_MODESET_LOCK is not set
# CONFIG_DRM_LOAD_EDID_FIRMWARE is not set
CONFIG_DRM_DP_AUX_BUS=y
CONFIG_DRM_DISPLAY_HELPER=y
CONFIG_DRM_DISPLAY_DP_HELPER=y
CONFIG_DRM_DISPLAY_HDMI_HELPER=y
CONFIG_DRM_DP_AUX_CHARDEV=y
CONFIG_DRM_DP_CEC=y
CONFIG_DRM_TTM=y
CONFIG_DRM_VRAM_HELPER=y
CONFIG_DRM_TTM_HELPER=y
CONFIG_DRM_GEM_CMA_HELPER=y
CONFIG_DRM_GEM_SHMEM_HELPER=y
CONFIG_DRM_SCHED=y

#
# I2C encoder or helper chips
#
# CONFIG_DRM_I2C_CH7006 is not set
CONFIG_DRM_I2C_SIL164=y
# CONFIG_DRM_I2C_NXP_TDA998X is not set
CONFIG_DRM_I2C_NXP_TDA9950=y
# end of I2C encoder or helper chips

#
# ARM devices
#
# CONFIG_DRM_HDLCD is not set
# CONFIG_DRM_MALI_DISPLAY is not set
# CONFIG_DRM_KOMEDA is not set
# end of ARM devices

CONFIG_DRM_RADEON=y
# CONFIG_DRM_RADEON_USERPTR is not set
CONFIG_DRM_AMDGPU=y
# CONFIG_DRM_AMDGPU_SI is not set
CONFIG_DRM_AMDGPU_CIK=y
CONFIG_DRM_AMDGPU_USERPTR=y

#
# ACP (Audio CoProcessor) Configuration
#
# CONFIG_DRM_AMD_ACP is not set
# end of ACP (Audio CoProcessor) Configuration

#
# Display Engine Configuration
#
# CONFIG_DRM_AMD_DC is not set
# end of Display Engine Configuration

CONFIG_DRM_NOUVEAU=y
# CONFIG_NOUVEAU_LEGACY_CTX_SUPPORT is not set
CONFIG_NOUVEAU_DEBUG=5
CONFIG_NOUVEAU_DEBUG_DEFAULT=3
# CONFIG_NOUVEAU_DEBUG_MMU is not set
# CONFIG_NOUVEAU_DEBUG_PUSH is not set
CONFIG_DRM_NOUVEAU_BACKLIGHT=y
CONFIG_DRM_KMB_DISPLAY=y
CONFIG_DRM_VGEM=y
CONFIG_DRM_VKMS=y
# CONFIG_DRM_EXYNOS is not set
# CONFIG_DRM_ROCKCHIP is not set
CONFIG_DRM_AST=y
CONFIG_DRM_MGAG200=y
# CONFIG_DRM_RCAR_DW_HDMI is not set
# CONFIG_DRM_RCAR_USE_LVDS is not set
# CONFIG_DRM_RCAR_MIPI_DSI is not set
CONFIG_DRM_SUN4I=y
CONFIG_DRM_SUN4I_HDMI=y
CONFIG_DRM_SUN4I_HDMI_CEC=y
CONFIG_DRM_SUN4I_BACKEND=y
# CONFIG_DRM_SUN6I_DSI is not set
# CONFIG_DRM_SUN8I_DW_HDMI is not set
CONFIG_DRM_SUN8I_MIXER=y
CONFIG_DRM_SUN8I_TCON_TOP=y
# CONFIG_DRM_QXL is not set
CONFIG_DRM_VIRTIO_GPU=y
CONFIG_DRM_MSM=y
CONFIG_DRM_MSM_GPU_STATE=y
CONFIG_DRM_MSM_GPU_SUDO=y
CONFIG_DRM_MSM_MDSS=y
CONFIG_DRM_MSM_MDP4=y
# CONFIG_DRM_MSM_MDP5 is not set
CONFIG_DRM_MSM_DPU=y
CONFIG_DRM_MSM_DP=y
# CONFIG_DRM_MSM_DSI is not set
# CONFIG_DRM_MSM_HDMI is not set
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# CONFIG_DRM_PANEL_ABT_Y030XX067A is not set
# CONFIG_DRM_PANEL_ARM_VERSATILE is not set
# CONFIG_DRM_PANEL_ASUS_Z00T_TM5P5_NT35596 is not set
# CONFIG_DRM_PANEL_BOE_BF060Y8M_AJ0 is not set
# CONFIG_DRM_PANEL_BOE_HIMAX8279D is not set
# CONFIG_DRM_PANEL_BOE_TV101WUM_NL6 is not set
# CONFIG_DRM_PANEL_DSI_CM is not set
# CONFIG_DRM_PANEL_LVDS is not set
# CONFIG_DRM_PANEL_ELIDA_KD35T133 is not set
# CONFIG_DRM_PANEL_FEIXIN_K101_IM2BA02 is not set
# CONFIG_DRM_PANEL_FEIYANG_FY07024DI26A30D is not set
# CONFIG_DRM_PANEL_ILITEK_IL9322 is not set
# CONFIG_DRM_PANEL_ILITEK_ILI9341 is not set
# CONFIG_DRM_PANEL_ILITEK_ILI9881C is not set
# CONFIG_DRM_PANEL_INNOLUX_EJ030NA is not set
# CONFIG_DRM_PANEL_INNOLUX_P079ZCA is not set
# CONFIG_DRM_PANEL_JDI_LT070ME05000 is not set
# CONFIG_DRM_PANEL_JDI_R63452 is not set
# CONFIG_DRM_PANEL_KHADAS_TS050 is not set
# CONFIG_DRM_PANEL_KINGDISPLAY_KD097D04 is not set
# CONFIG_DRM_PANEL_LEADTEK_LTK050H3146W is not set
# CONFIG_DRM_PANEL_LEADTEK_LTK500HD1829 is not set
# CONFIG_DRM_PANEL_SAMSUNG_LD9040 is not set
# CONFIG_DRM_PANEL_LG_LB035Q02 is not set
# CONFIG_DRM_PANEL_LG_LG4573 is not set
# CONFIG_DRM_PANEL_NEC_NL8048HL11 is not set
# CONFIG_DRM_PANEL_NEWVISION_NV3052C is not set
# CONFIG_DRM_PANEL_NOVATEK_NT35510 is not set
# CONFIG_DRM_PANEL_NOVATEK_NT35560 is not set
# CONFIG_DRM_PANEL_NOVATEK_NT35950 is not set
# CONFIG_DRM_PANEL_NOVATEK_NT36672A is not set
# CONFIG_DRM_PANEL_NOVATEK_NT39016 is not set
# CONFIG_DRM_PANEL_MANTIX_MLAF057WE51 is not set
# CONFIG_DRM_PANEL_OLIMEX_LCD_OLINUXINO is not set
# CONFIG_DRM_PANEL_ORISETECH_OTM8009A is not set
# CONFIG_DRM_PANEL_OSD_OSD101T2587_53TS is not set
# CONFIG_DRM_PANEL_PANASONIC_VVX10F034N00 is not set
# CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN is not set
# CONFIG_DRM_PANEL_RAYDIUM_RM67191 is not set
# CONFIG_DRM_PANEL_RAYDIUM_RM68200 is not set
# CONFIG_DRM_PANEL_RONBO_RB070D30 is not set
# CONFIG_DRM_PANEL_SAMSUNG_DB7430 is not set
# CONFIG_DRM_PANEL_SAMSUNG_S6D16D0 is not set
# CONFIG_DRM_PANEL_SAMSUNG_S6D27A1 is not set
# CONFIG_DRM_PANEL_SAMSUNG_S6E3HA2 is not set
# CONFIG_DRM_PANEL_SAMSUNG_S6E63J0X03 is not set
# CONFIG_DRM_PANEL_SAMSUNG_S6E63M0 is not set
# CONFIG_DRM_PANEL_SAMSUNG_S6E88A0_AMS452EF01 is not set
# CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0 is not set
# CONFIG_DRM_PANEL_SAMSUNG_SOFEF00 is not set
# CONFIG_DRM_PANEL_SEIKO_43WVF1G is not set
# CONFIG_DRM_PANEL_SHARP_LQ101R1SX01 is not set
# CONFIG_DRM_PANEL_SHARP_LS037V7DW01 is not set
# CONFIG_DRM_PANEL_SHARP_LS043T1LE01 is not set
# CONFIG_DRM_PANEL_SHARP_LS060T1SX01 is not set
# CONFIG_DRM_PANEL_SITRONIX_ST7701 is not set
# CONFIG_DRM_PANEL_SITRONIX_ST7703 is not set
# CONFIG_DRM_PANEL_SITRONIX_ST7789V is not set
# CONFIG_DRM_PANEL_SONY_ACX565AKM is not set
# CONFIG_DRM_PANEL_SONY_TULIP_TRULY_NT35521 is not set
# CONFIG_DRM_PANEL_TDO_TL070WSH30 is not set
# CONFIG_DRM_PANEL_TPO_TD028TTEC1 is not set
# CONFIG_DRM_PANEL_TPO_TD043MTEA1 is not set
# CONFIG_DRM_PANEL_TPO_TPG110 is not set
# CONFIG_DRM_PANEL_TRULY_NT35597_WQXGA is not set
# CONFIG_DRM_PANEL_VISIONOX_RM69299 is not set
CONFIG_DRM_PANEL_WIDECHIPS_WS2401=y
# CONFIG_DRM_PANEL_XINPENG_XPP055C272 is not set
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_CDNS_DSI is not set
# CONFIG_DRM_CHIPONE_ICN6211 is not set
# CONFIG_DRM_CHRONTEL_CH7033 is not set
# CONFIG_DRM_CROS_EC_ANX7688 is not set
# CONFIG_DRM_DISPLAY_CONNECTOR is not set
# CONFIG_DRM_FSL_LDB is not set
# CONFIG_DRM_ITE_IT6505 is not set
# CONFIG_DRM_LONTIUM_LT8912B is not set
# CONFIG_DRM_LONTIUM_LT9211 is not set
# CONFIG_DRM_LONTIUM_LT9611 is not set
# CONFIG_DRM_LONTIUM_LT9611UXC is not set
# CONFIG_DRM_ITE_IT66121 is not set
# CONFIG_DRM_LVDS_CODEC is not set
# CONFIG_DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW is not set
# CONFIG_DRM_NWL_MIPI_DSI is not set
# CONFIG_DRM_NXP_PTN3460 is not set
# CONFIG_DRM_PARADE_PS8622 is not set
# CONFIG_DRM_PARADE_PS8640 is not set
# CONFIG_DRM_SIL_SII8620 is not set
# CONFIG_DRM_SII902X is not set
# CONFIG_DRM_SII9234 is not set
# CONFIG_DRM_SIMPLE_BRIDGE is not set
# CONFIG_DRM_THINE_THC63LVD1024 is not set
# CONFIG_DRM_TOSHIBA_TC358762 is not set
# CONFIG_DRM_TOSHIBA_TC358764 is not set
# CONFIG_DRM_TOSHIBA_TC358767 is not set
# CONFIG_DRM_TOSHIBA_TC358768 is not set
# CONFIG_DRM_TOSHIBA_TC358775 is not set
# CONFIG_DRM_TI_TFP410 is not set
# CONFIG_DRM_TI_SN65DSI83 is not set
# CONFIG_DRM_TI_SN65DSI86 is not set
# CONFIG_DRM_TI_TPD12S015 is not set
# CONFIG_DRM_ANALOGIX_ANX6345 is not set
CONFIG_DRM_ANALOGIX_ANX78XX=y
CONFIG_DRM_ANALOGIX_DP=y
# CONFIG_DRM_ANALOGIX_ANX7625 is not set
# CONFIG_DRM_I2C_ADV7511 is not set
# CONFIG_DRM_CDNS_MHDP8546 is not set
# end of Display Interface Bridges

# CONFIG_DRM_IMX is not set
CONFIG_DRM_V3D=y
# CONFIG_DRM_ETNAVIV is not set
CONFIG_DRM_HISI_HIBMC=y
# CONFIG_DRM_MXSFB is not set
# CONFIG_DRM_ARCPGU is not set
CONFIG_DRM_BOCHS=y
CONFIG_DRM_CIRRUS_QEMU=y
CONFIG_DRM_PANEL_MIPI_DBI=y
# CONFIG_DRM_SIMPLEDRM is not set
CONFIG_TINYDRM_HX8357D=y
CONFIG_TINYDRM_ILI9163=y
CONFIG_TINYDRM_ILI9225=y
CONFIG_TINYDRM_ILI9341=y
# CONFIG_TINYDRM_ILI9486 is not set
CONFIG_TINYDRM_MI0283QT=y
CONFIG_TINYDRM_REPAPER=y
CONFIG_TINYDRM_ST7586=y
CONFIG_TINYDRM_ST7735R=y
CONFIG_DRM_PL111=y
# CONFIG_DRM_LIMA is not set
CONFIG_DRM_PANFROST=y
# CONFIG_DRM_ASPEED_GFX is not set
# CONFIG_DRM_TIDSS is not set
# CONFIG_DRM_SSD130X is not set
# CONFIG_DRM_SPRD is not set
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
CONFIG_DRM_NOMODESET=y

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
# CONFIG_FB is not set
CONFIG_FB_OMAP_LCD_H3=y
CONFIG_MMP_DISP=y
# CONFIG_MMP_DISP_CONTROLLER is not set
# CONFIG_MMP_PANEL_TPOHVGA is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=y
CONFIG_LCD_L4F00242T03=y
# CONFIG_LCD_LMS283GF05 is not set
CONFIG_LCD_LTV350QV=y
# CONFIG_LCD_ILI922X is not set
CONFIG_LCD_ILI9320=y
CONFIG_LCD_TDO24M=y
CONFIG_LCD_VGG2432A4=y
CONFIG_LCD_PLATFORM=y
CONFIG_LCD_AMS369FG06=y
CONFIG_LCD_LMS501KF03=y
# CONFIG_LCD_HX8357 is not set
CONFIG_LCD_OTM3225A=y
CONFIG_BACKLIGHT_CLASS_DEVICE=y
CONFIG_BACKLIGHT_KTD253=y
# CONFIG_BACKLIGHT_LM3533 is not set
# CONFIG_BACKLIGHT_OMAP1 is not set
CONFIG_BACKLIGHT_DA9052=y
CONFIG_BACKLIGHT_QCOM_WLED=y
CONFIG_BACKLIGHT_RT4831=y
CONFIG_BACKLIGHT_WM831X=y
CONFIG_BACKLIGHT_ADP5520=y
# CONFIG_BACKLIGHT_ADP8860 is not set
CONFIG_BACKLIGHT_ADP8870=y
CONFIG_BACKLIGHT_88PM860X=y
# CONFIG_BACKLIGHT_PCF50633 is not set
# CONFIG_BACKLIGHT_AAT2870 is not set
CONFIG_BACKLIGHT_LM3639=y
# CONFIG_BACKLIGHT_SKY81452 is not set
CONFIG_BACKLIGHT_AS3711=y
CONFIG_BACKLIGHT_GPIO=y
CONFIG_BACKLIGHT_LV5207LP=y
# CONFIG_BACKLIGHT_BD6107 is not set
CONFIG_BACKLIGHT_ARCXCNN=y
CONFIG_BACKLIGHT_RAVE_SP=y
# CONFIG_BACKLIGHT_LED is not set
# end of Backlight & LCD device support

CONFIG_VIDEOMODE_HELPERS=y
CONFIG_HDMI=y
# end of Graphics support

CONFIG_SOUND=y
CONFIG_SOUND_OSS_CORE=y
# CONFIG_SOUND_OSS_CORE_PRECLAIM is not set
CONFIG_SND=y
CONFIG_SND_TIMER=y
CONFIG_SND_PCM=y
CONFIG_SND_RAWMIDI=y
CONFIG_SND_OSSEMUL=y
# CONFIG_SND_MIXER_OSS is not set
CONFIG_SND_PCM_OSS=y
CONFIG_SND_PCM_OSS_PLUGINS=y
# CONFIG_SND_PCM_TIMER is not set
CONFIG_SND_HRTIMER=y
CONFIG_SND_DYNAMIC_MINORS=y
CONFIG_SND_MAX_CARDS=32
# CONFIG_SND_SUPPORT_OLD_API is not set
CONFIG_SND_PROC_FS=y
# CONFIG_SND_VERBOSE_PROCFS is not set
CONFIG_SND_VERBOSE_PRINTK=y
CONFIG_SND_DEBUG=y
CONFIG_SND_DEBUG_VERBOSE=y
# CONFIG_SND_CTL_VALIDATION is not set
# CONFIG_SND_SEQUENCER is not set
CONFIG_SND_DRIVERS=y
CONFIG_SND_DUMMY=y
CONFIG_SND_ALOOP=y
CONFIG_SND_MTPAV=y
# CONFIG_SND_SERIAL_U16550 is not set
# CONFIG_SND_SERIAL_GENERIC is not set
# CONFIG_SND_MPU401 is not set
# CONFIG_SND_PCI is not set

#
# HD-Audio
#
# end of HD-Audio

CONFIG_SND_HDA_PREALLOC_SIZE=64
CONFIG_SND_SPI=y
# CONFIG_SND_FIREWIRE is not set
# CONFIG_SND_SOC is not set
# CONFIG_SND_VIRTIO is not set

#
# HID support
#
CONFIG_HID=y
# CONFIG_HID_BATTERY_STRENGTH is not set
CONFIG_HIDRAW=y
CONFIG_UHID=y
# CONFIG_HID_GENERIC is not set

#
# Special HID drivers
#
CONFIG_HID_A4TECH=y
CONFIG_HID_ACRUX=y
CONFIG_HID_ACRUX_FF=y
# CONFIG_HID_APPLE is not set
CONFIG_HID_AUREAL=y
CONFIG_HID_BELKIN=y
# CONFIG_HID_CHERRY is not set
CONFIG_HID_COUGAR=y
CONFIG_HID_MACALLY=y
# CONFIG_HID_CMEDIA is not set
CONFIG_HID_CYPRESS=y
# CONFIG_HID_DRAGONRISE is not set
# CONFIG_HID_EMS_FF is not set
CONFIG_HID_ELECOM=y
CONFIG_HID_EZKEY=y
# CONFIG_HID_GEMBIRD is not set
CONFIG_HID_GFRM=y
# CONFIG_HID_GLORIOUS is not set
CONFIG_HID_VIVALDI_COMMON=y
CONFIG_HID_VIVALDI=y
# CONFIG_HID_KEYTOUCH is not set
CONFIG_HID_KYE=y
CONFIG_HID_WALTOP=y
CONFIG_HID_VIEWSONIC=y
CONFIG_HID_XIAOMI=y
CONFIG_HID_GYRATION=y
# CONFIG_HID_ICADE is not set
CONFIG_HID_ITE=y
CONFIG_HID_JABRA=y
CONFIG_HID_TWINHAN=y
CONFIG_HID_KENSINGTON=y
# CONFIG_HID_LCPOWER is not set
CONFIG_HID_LED=y
CONFIG_HID_LENOVO=y
CONFIG_HID_MAGICMOUSE=y
CONFIG_HID_MALTRON=y
CONFIG_HID_MAYFLASH=y
# CONFIG_HID_REDRAGON is not set
CONFIG_HID_MICROSOFT=y
CONFIG_HID_MONTEREY=y
CONFIG_HID_MULTITOUCH=y
CONFIG_HID_NINTENDO=y
CONFIG_NINTENDO_FF=y
CONFIG_HID_NTI=y
# CONFIG_HID_ORTEK is not set
CONFIG_HID_PANTHERLORD=y
# CONFIG_PANTHERLORD_FF is not set
# CONFIG_HID_PETALYNX is not set
CONFIG_HID_PICOLCD=y
# CONFIG_HID_PICOLCD_BACKLIGHT is not set
# CONFIG_HID_PICOLCD_LCD is not set
CONFIG_HID_PICOLCD_LEDS=y
# CONFIG_HID_PICOLCD_CIR is not set
# CONFIG_HID_PLANTRONICS is not set
CONFIG_HID_PLAYSTATION=y
# CONFIG_PLAYSTATION_FF is not set
# CONFIG_HID_RAZER is not set
# CONFIG_HID_PRIMAX is not set
# CONFIG_HID_SAITEK is not set
# CONFIG_HID_SEMITEK is not set
CONFIG_HID_SPEEDLINK=y
CONFIG_HID_STEAM=y
CONFIG_HID_STEELSERIES=y
CONFIG_HID_SUNPLUS=y
CONFIG_HID_RMI=y
# CONFIG_HID_GREENASIA is not set
# CONFIG_HID_SMARTJOYPLUS is not set
# CONFIG_HID_TIVO is not set
CONFIG_HID_TOPSEED=y
CONFIG_HID_THINGM=y
# CONFIG_HID_UDRAW_PS3 is not set
# CONFIG_HID_WIIMOTE is not set
CONFIG_HID_XINMO=y
# CONFIG_HID_ZEROPLUS is not set
# CONFIG_HID_ZYDACRON is not set
# CONFIG_HID_SENSOR_HUB is not set
# CONFIG_HID_ALPS is not set
# end of Special HID drivers

#
# I2C HID support
#
CONFIG_I2C_HID_ACPI=y
# CONFIG_I2C_HID_OF is not set
# CONFIG_I2C_HID_OF_GOODIX is not set
# end of I2C HID support

CONFIG_I2C_HID_CORE=y

#
# Intel ISH HID support
#
# end of Intel ISH HID support

#
# AMD SFH HID Support
#
# CONFIG_AMD_SFH_HID is not set
# end of AMD SFH HID Support

#
# Surface System Aggregator Module HID support
#
# CONFIG_SURFACE_KBD is not set
# end of Surface System Aggregator Module HID support
# end of HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
# CONFIG_USB_SUPPORT is not set
# CONFIG_MMC is not set
CONFIG_SCSI_UFSHCD=y
CONFIG_SCSI_UFS_BSG=y
# CONFIG_SCSI_UFS_HPB is not set
CONFIG_SCSI_UFS_HWMON=y
# CONFIG_SCSI_UFSHCD_PCI is not set
CONFIG_SCSI_UFSHCD_PLATFORM=y
# CONFIG_SCSI_UFS_CDNS_PLATFORM is not set
CONFIG_SCSI_UFS_DWC_TC_PLATFORM=y
CONFIG_SCSI_UFS_HISI=y
# CONFIG_SCSI_UFS_TI_J721E is not set
CONFIG_SCSI_UFS_EXYNOS=y
CONFIG_MEMSTICK=y
# CONFIG_MEMSTICK_DEBUG is not set

#
# MemoryStick drivers
#
CONFIG_MEMSTICK_UNSAFE_RESUME=y
# CONFIG_MSPRO_BLOCK is not set
CONFIG_MS_BLOCK=y

#
# MemoryStick Host Controller Drivers
#
CONFIG_MEMSTICK_TIFM_MS=y
# CONFIG_MEMSTICK_JMICRON_38X is not set
CONFIG_MEMSTICK_R592=y
CONFIG_MEMSTICK_REALTEK_PCI=y
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_CLASS_FLASH=y
CONFIG_LEDS_CLASS_MULTICOLOR=y
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
# CONFIG_LEDS_88PM860X is not set
# CONFIG_LEDS_AN30259A is not set
CONFIG_LEDS_ARIEL=y
# CONFIG_LEDS_AW2013 is not set
# CONFIG_LEDS_BCM6328 is not set
# CONFIG_LEDS_BCM6358 is not set
# CONFIG_LEDS_CR0014114 is not set
# CONFIG_LEDS_EL15203000 is not set
# CONFIG_LEDS_TURRIS_OMNIA is not set
CONFIG_LEDS_LM3530=y
CONFIG_LEDS_LM3532=y
CONFIG_LEDS_LM3533=y
CONFIG_LEDS_LM3642=y
# CONFIG_LEDS_LM3692X is not set
CONFIG_LEDS_S3C24XX=y
# CONFIG_LEDS_COBALT_QUBE is not set
# CONFIG_LEDS_COBALT_RAQ is not set
CONFIG_LEDS_PCA9532=y
CONFIG_LEDS_PCA9532_GPIO=y
CONFIG_LEDS_GPIO=y
CONFIG_LEDS_LP3944=y
# CONFIG_LEDS_LP3952 is not set
CONFIG_LEDS_LP50XX=y
# CONFIG_LEDS_LP55XX_COMMON is not set
CONFIG_LEDS_LP8788=y
# CONFIG_LEDS_LP8860 is not set
CONFIG_LEDS_PCA955X=y
# CONFIG_LEDS_PCA955X_GPIO is not set
CONFIG_LEDS_PCA963X=y
CONFIG_LEDS_WM831X_STATUS=y
CONFIG_LEDS_DA9052=y
CONFIG_LEDS_DAC124S085=y
# CONFIG_LEDS_REGULATOR is not set
CONFIG_LEDS_BD2802=y
CONFIG_LEDS_LT3593=y
CONFIG_LEDS_ADP5520=y
# CONFIG_LEDS_MC13783 is not set
CONFIG_LEDS_NS2=y
CONFIG_LEDS_NETXBIG=y
# CONFIG_LEDS_TCA6507 is not set
CONFIG_LEDS_TLC591XX=y
CONFIG_LEDS_MAX77650=y
CONFIG_LEDS_MAX8997=y
CONFIG_LEDS_LM355x=y
# CONFIG_LEDS_OT200 is not set
# CONFIG_LEDS_IS31FL319X is not set
# CONFIG_LEDS_IS31FL32XX is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=y
# CONFIG_LEDS_SYSCON is not set
CONFIG_LEDS_MLXREG=y
CONFIG_LEDS_USER=y
# CONFIG_LEDS_SPI_BYTE is not set
CONFIG_LEDS_TI_LMU_COMMON=y
# CONFIG_LEDS_LM3697 is not set
CONFIG_LEDS_LM36274=y
CONFIG_LEDS_TPS6105X=y
CONFIG_LEDS_IP30=y
# CONFIG_LEDS_LGM is not set

#
# Flash and Torch LED drivers
#
# CONFIG_LEDS_AAT1290 is not set
# CONFIG_LEDS_AS3645A is not set
# CONFIG_LEDS_KTD2692 is not set
CONFIG_LEDS_LM3601X=y
# CONFIG_LEDS_MT6360 is not set
# CONFIG_LEDS_RT4505 is not set
CONFIG_LEDS_RT8515=y
CONFIG_LEDS_SGM3140=y

#
# RGB LED drivers
#

#
# LED Triggers
#
# CONFIG_LEDS_TRIGGERS is not set

#
# Simple LED drivers
#
# CONFIG_ACCESSIBILITY is not set
CONFIG_RTC_LIB=y
# CONFIG_RTC_CLASS is not set
# CONFIG_DMADEVICES is not set

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
# CONFIG_SW_SYNC is not set
# CONFIG_UDMABUF is not set
CONFIG_DMABUF_MOVE_NOTIFY=y
# CONFIG_DMABUF_DEBUG is not set
CONFIG_DMABUF_SELFTESTS=y
# CONFIG_DMABUF_HEAPS is not set
CONFIG_DMABUF_SYSFS_STATS=y
# end of DMABUF options

CONFIG_AUXDISPLAY=y
CONFIG_CHARLCD=y
CONFIG_LINEDISP=y
CONFIG_HD44780_COMMON=y
CONFIG_HD44780=y
# CONFIG_IMG_ASCII_LCD is not set
CONFIG_LCD2S=y
CONFIG_PANEL_CHANGE_MESSAGE=y
CONFIG_PANEL_BOOT_MESSAGE=""
CONFIG_CHARLCD_BL_OFF=y
# CONFIG_CHARLCD_BL_ON is not set
# CONFIG_CHARLCD_BL_FLASH is not set
CONFIG_UIO=y
CONFIG_UIO_CIF=y
CONFIG_UIO_PDRV_GENIRQ=y
# CONFIG_UIO_DMEM_GENIRQ is not set
CONFIG_UIO_AEC=y
CONFIG_UIO_SERCOS3=y
CONFIG_UIO_PCI_GENERIC=y
CONFIG_UIO_NETX=y
# CONFIG_UIO_PRUSS is not set
CONFIG_UIO_MF624=y
CONFIG_VFIO=y
CONFIG_VFIO_VIRQFD=y
CONFIG_VFIO_NOIOMMU=y
CONFIG_VFIO_PCI_MMAP=y
CONFIG_VFIO_PCI_INTX=y
# CONFIG_VFIO_PCI is not set
CONFIG_VFIO_PLATFORM=y
CONFIG_VFIO_AMBA=y
CONFIG_VFIO_PLATFORM_CALXEDAXGMAC_RESET=y
# CONFIG_VFIO_PLATFORM_AMDXGBE_RESET is not set
CONFIG_VFIO_PLATFORM_BCMFLEXRM_RESET=y
# CONFIG_VFIO_MDEV is not set
CONFIG_VIRT_DRIVERS=y
# CONFIG_VMGENID is not set
CONFIG_VIRTIO=y
CONFIG_VIRTIO_MENU=y
# CONFIG_VIRTIO_HARDEN_NOTIFICATION is not set
# CONFIG_VIRTIO_PCI is not set
# CONFIG_VIRTIO_BALLOON is not set
# CONFIG_VIRTIO_INPUT is not set
CONFIG_VIRTIO_MMIO=y
# CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES is not set
CONFIG_VIRTIO_DMA_SHARED_BUFFER=y
# CONFIG_VHOST_MENU is not set

#
# Microsoft Hyper-V guest support
#
# end of Microsoft Hyper-V guest support

# CONFIG_GREYBUS is not set
CONFIG_COMEDI=y
# CONFIG_COMEDI_DEBUG is not set
CONFIG_COMEDI_DEFAULT_BUF_SIZE_KB=2048
CONFIG_COMEDI_DEFAULT_BUF_MAXSIZE_KB=20480
# CONFIG_COMEDI_MISC_DRIVERS is not set
CONFIG_COMEDI_ISA_DRIVERS=y
CONFIG_COMEDI_PCL711=y
CONFIG_COMEDI_PCL724=y
# CONFIG_COMEDI_PCL726 is not set
CONFIG_COMEDI_PCL730=y
CONFIG_COMEDI_PCL812=y
CONFIG_COMEDI_PCL816=y
CONFIG_COMEDI_PCL818=y
CONFIG_COMEDI_PCM3724=y
CONFIG_COMEDI_AMPLC_DIO200_ISA=y
# CONFIG_COMEDI_AMPLC_PC236_ISA is not set
CONFIG_COMEDI_AMPLC_PC263_ISA=y
# CONFIG_COMEDI_RTI800 is not set
CONFIG_COMEDI_RTI802=y
CONFIG_COMEDI_DAC02=y
CONFIG_COMEDI_DAS16M1=y
# CONFIG_COMEDI_DAS08_ISA is not set
CONFIG_COMEDI_DAS16=y
CONFIG_COMEDI_DAS800=y
CONFIG_COMEDI_DAS1800=y
CONFIG_COMEDI_DAS6402=y
CONFIG_COMEDI_DT2801=y
CONFIG_COMEDI_DT2811=y
# CONFIG_COMEDI_DT2814 is not set
CONFIG_COMEDI_DT2815=y
CONFIG_COMEDI_DT2817=y
CONFIG_COMEDI_DT282X=y
# CONFIG_COMEDI_DMM32AT is not set
CONFIG_COMEDI_FL512=y
CONFIG_COMEDI_AIO_AIO12_8=y
# CONFIG_COMEDI_AIO_IIRO_16 is not set
CONFIG_COMEDI_II_PCI20KC=y
# CONFIG_COMEDI_C6XDIGIO is not set
CONFIG_COMEDI_MPC624=y
CONFIG_COMEDI_ADQ12B=y
CONFIG_COMEDI_NI_AT_A2150=y
CONFIG_COMEDI_NI_AT_AO=y
CONFIG_COMEDI_NI_ATMIO=y
CONFIG_COMEDI_NI_ATMIO16D=y
CONFIG_COMEDI_NI_LABPC_ISA=y
CONFIG_COMEDI_PCMAD=y
CONFIG_COMEDI_PCMDA12=y
# CONFIG_COMEDI_PCMMIO is not set
CONFIG_COMEDI_PCMUIO=y
# CONFIG_COMEDI_MULTIQ3 is not set
CONFIG_COMEDI_S526=y
CONFIG_COMEDI_PCI_DRIVERS=y
CONFIG_COMEDI_8255_PCI=y
CONFIG_COMEDI_ADDI_WATCHDOG=y
# CONFIG_COMEDI_ADDI_APCI_1032 is not set
CONFIG_COMEDI_ADDI_APCI_1500=y
CONFIG_COMEDI_ADDI_APCI_1516=y
CONFIG_COMEDI_ADDI_APCI_1564=y
CONFIG_COMEDI_ADDI_APCI_16XX=y
CONFIG_COMEDI_ADDI_APCI_2032=y
CONFIG_COMEDI_ADDI_APCI_2200=y
CONFIG_COMEDI_ADDI_APCI_3120=y
# CONFIG_COMEDI_ADDI_APCI_3501 is not set
# CONFIG_COMEDI_ADDI_APCI_3XXX is not set
# CONFIG_COMEDI_ADL_PCI6208 is not set
# CONFIG_COMEDI_ADL_PCI7X3X is not set
# CONFIG_COMEDI_ADL_PCI8164 is not set
# CONFIG_COMEDI_ADL_PCI9111 is not set
# CONFIG_COMEDI_ADL_PCI9118 is not set
CONFIG_COMEDI_ADV_PCI1710=y
CONFIG_COMEDI_ADV_PCI1720=y
CONFIG_COMEDI_ADV_PCI1723=y
# CONFIG_COMEDI_ADV_PCI1724 is not set
CONFIG_COMEDI_ADV_PCI1760=y
# CONFIG_COMEDI_ADV_PCI_DIO is not set
CONFIG_COMEDI_AMPLC_DIO200_PCI=y
# CONFIG_COMEDI_AMPLC_PC236_PCI is not set
CONFIG_COMEDI_AMPLC_PC263_PCI=y
CONFIG_COMEDI_AMPLC_PCI224=y
# CONFIG_COMEDI_AMPLC_PCI230 is not set
CONFIG_COMEDI_CONTEC_PCI_DIO=y
CONFIG_COMEDI_DAS08_PCI=y
# CONFIG_COMEDI_DT3000 is not set
CONFIG_COMEDI_DYNA_PCI10XX=y
# CONFIG_COMEDI_GSC_HPDI is not set
CONFIG_COMEDI_MF6X4=y
CONFIG_COMEDI_ICP_MULTI=y
# CONFIG_COMEDI_DAQBOARD2000 is not set
CONFIG_COMEDI_JR3_PCI=y
CONFIG_COMEDI_KE_COUNTER=y
CONFIG_COMEDI_CB_PCIDAS64=y
CONFIG_COMEDI_CB_PCIDAS=y
# CONFIG_COMEDI_CB_PCIDDA is not set
CONFIG_COMEDI_CB_PCIMDAS=y
CONFIG_COMEDI_CB_PCIMDDA=y
CONFIG_COMEDI_ME4000=y
CONFIG_COMEDI_ME_DAQ=y
CONFIG_COMEDI_NI_6527=y
CONFIG_COMEDI_NI_65XX=y
CONFIG_COMEDI_NI_660X=y
CONFIG_COMEDI_NI_670X=y
# CONFIG_COMEDI_NI_LABPC_PCI is not set
CONFIG_COMEDI_NI_PCIDIO=y
CONFIG_COMEDI_NI_PCIMIO=y
# CONFIG_COMEDI_RTD520 is not set
# CONFIG_COMEDI_S626 is not set
CONFIG_COMEDI_MITE=y
CONFIG_COMEDI_NI_TIOCMD=y
CONFIG_COMEDI_8254=y
CONFIG_COMEDI_8255=y
CONFIG_COMEDI_8255_SA=y
CONFIG_COMEDI_KCOMEDILIB=y
CONFIG_COMEDI_AMPLC_DIO200=y
CONFIG_COMEDI_DAS08=y
CONFIG_COMEDI_NI_LABPC=y
CONFIG_COMEDI_NI_TIO=y
CONFIG_COMEDI_NI_ROUTING=y
CONFIG_COMEDI_TESTS=y
# CONFIG_COMEDI_TESTS_EXAMPLE is not set
# CONFIG_COMEDI_TESTS_NI_ROUTES is not set
# CONFIG_STAGING is not set
CONFIG_GOLDFISH=y
# CONFIG_GOLDFISH_PIPE is not set
# CONFIG_CHROME_PLATFORMS is not set
CONFIG_MELLANOX_PLATFORM=y
CONFIG_MLXREG_HOTPLUG=y
# CONFIG_MLXREG_IO is not set
CONFIG_MLXREG_LC=y
CONFIG_NVSW_SN2201=y
CONFIG_OLPC_XO175=y
# CONFIG_OLPC_XO175_EC is not set
CONFIG_SURFACE_PLATFORMS=y
CONFIG_SURFACE_3_POWER_OPREGION=y
CONFIG_SURFACE_ACPI_NOTIFY=y
CONFIG_SURFACE_AGGREGATOR_CDEV=y
# CONFIG_SURFACE_AGGREGATOR_REGISTRY is not set
# CONFIG_SURFACE_DTX is not set
CONFIG_SURFACE_HOTPLUG=y
CONFIG_SURFACE_PRO3_BUTTON=y
CONFIG_SURFACE_AGGREGATOR=y
CONFIG_SURFACE_AGGREGATOR_BUS=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
CONFIG_COMMON_CLK_WM831X=y

#
# Clock driver for ARM Reference designs
#
# CONFIG_CLK_ICST is not set
CONFIG_CLK_SP810=y
# end of Clock driver for ARM Reference designs

# CONFIG_CLK_HSDK is not set
CONFIG_LMK04832=y
CONFIG_COMMON_CLK_APPLE_NCO=y
# CONFIG_COMMON_CLK_MAX77686 is not set
# CONFIG_COMMON_CLK_MAX9485 is not set
# CONFIG_COMMON_CLK_HI655X is not set
CONFIG_COMMON_CLK_SCMI=y
CONFIG_COMMON_CLK_SCPI=y
CONFIG_COMMON_CLK_SI5341=y
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI514 is not set
# CONFIG_COMMON_CLK_SI544 is not set
# CONFIG_COMMON_CLK_SI570 is not set
# CONFIG_COMMON_CLK_BM1880 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
CONFIG_COMMON_CLK_TPS68470=y
# CONFIG_COMMON_CLK_CDCE925 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_EN7523 is not set
# CONFIG_COMMON_CLK_FSL_FLEXSPI is not set
# CONFIG_COMMON_CLK_FSL_SAI is not set
CONFIG_COMMON_CLK_GEMINI=y
# CONFIG_COMMON_CLK_LAN966X is not set
CONFIG_COMMON_CLK_ASPEED=y
# CONFIG_COMMON_CLK_S2MPS11 is not set
# CONFIG_COMMON_CLK_AXI_CLKGEN is not set
# CONFIG_CLK_QORIQ is not set
# CONFIG_CLK_LS1028A_PLLDIG is not set
CONFIG_COMMON_CLK_XGENE=y
# CONFIG_COMMON_CLK_OXNAS is not set
# CONFIG_COMMON_CLK_RS9_PCIE is not set
# CONFIG_COMMON_CLK_VC5 is not set
CONFIG_COMMON_CLK_MMP2_AUDIO=y
# CONFIG_COMMON_CLK_FIXED_MMIO is not set
# CONFIG_CLK_ACTIONS is not set
CONFIG_CLK_ANALOGBITS_WRPLL_CLN28HPC=y
# CONFIG_CLK_BAIKAL_T1 is not set
CONFIG_CLK_BCM2711_DVP=y
CONFIG_CLK_BCM2835=y
CONFIG_CLK_BCM_63XX=y
CONFIG_CLK_BCM_63XX_GATE=y
CONFIG_CLK_BCM_KONA=y
CONFIG_COMMON_CLK_IPROC=y
# CONFIG_CLK_BCM_CYGNUS is not set
# CONFIG_CLK_BCM_HR2 is not set
# CONFIG_CLK_BCM_NSP is not set
CONFIG_CLK_BCM_NS2=y
CONFIG_CLK_BCM_SR=y
CONFIG_CLK_RASPBERRYPI=y
CONFIG_COMMON_CLK_HI3516CV300=y
CONFIG_COMMON_CLK_HI3519=y
# CONFIG_COMMON_CLK_HI3559A is not set
# CONFIG_COMMON_CLK_HI3660 is not set
CONFIG_COMMON_CLK_HI3670=y
CONFIG_COMMON_CLK_HI3798CV200=y
CONFIG_COMMON_CLK_HI6220=y
CONFIG_RESET_HISI=y
CONFIG_STUB_CLK_HI6220=y
CONFIG_STUB_CLK_HI3660=y
CONFIG_COMMON_CLK_BOSTON=y
CONFIG_MXC_CLK=y
CONFIG_CLK_IMX8MM=y
CONFIG_CLK_IMX8MN=y
# CONFIG_CLK_IMX8MP is not set
# CONFIG_CLK_IMX8MQ is not set
CONFIG_CLK_IMX8ULP=y
# CONFIG_CLK_IMX93 is not set

#
# Ingenic SoCs drivers
#
CONFIG_INGENIC_CGU_COMMON=y
# CONFIG_INGENIC_CGU_JZ4740 is not set
CONFIG_INGENIC_CGU_JZ4725B=y
# CONFIG_INGENIC_CGU_JZ4760 is not set
CONFIG_INGENIC_CGU_JZ4770=y
# CONFIG_INGENIC_CGU_JZ4780 is not set
# CONFIG_INGENIC_CGU_X1000 is not set
# CONFIG_INGENIC_CGU_X1830 is not set
CONFIG_INGENIC_TCU_CLK=y
# end of Ingenic SoCs drivers

# CONFIG_COMMON_CLK_KEYSTONE is not set
CONFIG_TI_SYSCON_CLK=y

#
# Clock driver for MediaTek SoC
#
CONFIG_COMMON_CLK_MEDIATEK=y
CONFIG_COMMON_CLK_MT2701=y
# CONFIG_COMMON_CLK_MT2701_MMSYS is not set
CONFIG_COMMON_CLK_MT2701_IMGSYS=y
CONFIG_COMMON_CLK_MT2701_VDECSYS=y
CONFIG_COMMON_CLK_MT2701_HIFSYS=y
# CONFIG_COMMON_CLK_MT2701_ETHSYS is not set
# CONFIG_COMMON_CLK_MT2701_BDPSYS is not set
CONFIG_COMMON_CLK_MT2701_AUDSYS=y
# CONFIG_COMMON_CLK_MT2701_G3DSYS is not set
# CONFIG_COMMON_CLK_MT2712 is not set
CONFIG_COMMON_CLK_MT6765=y
CONFIG_COMMON_CLK_MT6765_AUDIOSYS=y
CONFIG_COMMON_CLK_MT6765_CAMSYS=y
# CONFIG_COMMON_CLK_MT6765_GCESYS is not set
CONFIG_COMMON_CLK_MT6765_MMSYS=y
# CONFIG_COMMON_CLK_MT6765_IMGSYS is not set
CONFIG_COMMON_CLK_MT6765_VCODECSYS=y
CONFIG_COMMON_CLK_MT6765_MFGSYS=y
# CONFIG_COMMON_CLK_MT6765_MIPI0ASYS is not set
# CONFIG_COMMON_CLK_MT6765_MIPI0BSYS is not set
# CONFIG_COMMON_CLK_MT6765_MIPI1ASYS is not set
CONFIG_COMMON_CLK_MT6765_MIPI1BSYS=y
# CONFIG_COMMON_CLK_MT6765_MIPI2ASYS is not set
CONFIG_COMMON_CLK_MT6765_MIPI2BSYS=y
CONFIG_COMMON_CLK_MT6779=y
# CONFIG_COMMON_CLK_MT6779_MMSYS is not set
CONFIG_COMMON_CLK_MT6779_IMGSYS=y
CONFIG_COMMON_CLK_MT6779_IPESYS=y
# CONFIG_COMMON_CLK_MT6779_CAMSYS is not set
CONFIG_COMMON_CLK_MT6779_VDECSYS=y
CONFIG_COMMON_CLK_MT6779_VENCSYS=y
CONFIG_COMMON_CLK_MT6779_MFGCFG=y
# CONFIG_COMMON_CLK_MT6779_AUDSYS is not set
CONFIG_COMMON_CLK_MT6797=y
# CONFIG_COMMON_CLK_MT6797_MMSYS is not set
# CONFIG_COMMON_CLK_MT6797_IMGSYS is not set
# CONFIG_COMMON_CLK_MT6797_VDECSYS is not set
CONFIG_COMMON_CLK_MT6797_VENCSYS=y
# CONFIG_COMMON_CLK_MT7622 is not set
# CONFIG_COMMON_CLK_MT7629 is not set
CONFIG_COMMON_CLK_MT7986=y
# CONFIG_COMMON_CLK_MT7986_ETHSYS is not set
# CONFIG_COMMON_CLK_MT8135 is not set
CONFIG_COMMON_CLK_MT8167=y
CONFIG_COMMON_CLK_MT8167_AUDSYS=y
CONFIG_COMMON_CLK_MT8167_IMGSYS=y
CONFIG_COMMON_CLK_MT8167_MFGCFG=y
CONFIG_COMMON_CLK_MT8167_MMSYS=y
CONFIG_COMMON_CLK_MT8167_VDECSYS=y
# CONFIG_COMMON_CLK_MT8173 is not set
# CONFIG_COMMON_CLK_MT8183 is not set
# CONFIG_COMMON_CLK_MT8186 is not set
CONFIG_COMMON_CLK_MT8192=y
# CONFIG_COMMON_CLK_MT8192_AUDSYS is not set
CONFIG_COMMON_CLK_MT8192_CAMSYS=y
# CONFIG_COMMON_CLK_MT8192_IMGSYS is not set
# CONFIG_COMMON_CLK_MT8192_IMP_IIC_WRAP is not set
# CONFIG_COMMON_CLK_MT8192_IPESYS is not set
CONFIG_COMMON_CLK_MT8192_MDPSYS=y
CONFIG_COMMON_CLK_MT8192_MFGCFG=y
CONFIG_COMMON_CLK_MT8192_MMSYS=y
CONFIG_COMMON_CLK_MT8192_MSDC=y
# CONFIG_COMMON_CLK_MT8192_SCP_ADSP is not set
# CONFIG_COMMON_CLK_MT8192_VDECSYS is not set
# CONFIG_COMMON_CLK_MT8192_VENCSYS is not set
CONFIG_COMMON_CLK_MT8195=y
# CONFIG_COMMON_CLK_MT8516 is not set
# end of Clock driver for MediaTek SoC

#
# Clock support for Amlogic platforms
#
# end of Clock support for Amlogic platforms

# CONFIG_MSTAR_MSC313_MPLL is not set
# CONFIG_MCHP_CLK_MPFS is not set
# CONFIG_COMMON_CLK_PISTACHIO is not set
# CONFIG_COMMON_CLK_QCOM is not set
# CONFIG_CLK_MT7621 is not set
CONFIG_CLK_RENESAS=y
# CONFIG_CLK_EMEV2 is not set
# CONFIG_CLK_RZA1 is not set
# CONFIG_CLK_R7S9210 is not set
CONFIG_CLK_R8A73A4=y
# CONFIG_CLK_R8A7740 is not set
# CONFIG_CLK_R8A7742 is not set
# CONFIG_CLK_R8A7743 is not set
CONFIG_CLK_R8A7745=y
# CONFIG_CLK_R8A77470 is not set
CONFIG_CLK_R8A774A1=y
# CONFIG_CLK_R8A774B1 is not set
# CONFIG_CLK_R8A774C0 is not set
CONFIG_CLK_R8A774E1=y
CONFIG_CLK_R8A7778=y
# CONFIG_CLK_R8A7779 is not set
CONFIG_CLK_R8A7790=y
CONFIG_CLK_R8A7791=y
# CONFIG_CLK_R8A7792 is not set
# CONFIG_CLK_R8A7794 is not set
CONFIG_CLK_R8A7795=y
CONFIG_CLK_R8A77960=y
CONFIG_CLK_R8A77961=y
CONFIG_CLK_R8A77965=y
CONFIG_CLK_R8A77970=y
CONFIG_CLK_R8A77980=y
CONFIG_CLK_R8A77990=y
# CONFIG_CLK_R8A77995 is not set
# CONFIG_CLK_R8A779A0 is not set
# CONFIG_CLK_R8A779F0 is not set
CONFIG_CLK_R8A779G0=y
# CONFIG_CLK_R9A06G032 is not set
CONFIG_CLK_R9A07G043=y
CONFIG_CLK_R9A07G044=y
CONFIG_CLK_R9A07G054=y
CONFIG_CLK_R9A09G011=y
# CONFIG_CLK_SH73A0 is not set
CONFIG_CLK_RCAR_CPG_LIB=y
CONFIG_CLK_RCAR_GEN2_CPG=y
CONFIG_CLK_RCAR_GEN3_CPG=y
CONFIG_CLK_RCAR_GEN4_CPG=y
# CONFIG_CLK_RCAR_USB2_CLOCK_SEL is not set
CONFIG_CLK_RZG2L=y
CONFIG_CLK_RENESAS_CPG_MSSR=y
CONFIG_CLK_RENESAS_CPG_MSTP=y
CONFIG_CLK_RENESAS_DIV6=y
CONFIG_COMMON_CLK_SAMSUNG=y
CONFIG_S3C64XX_COMMON_CLK=y
# CONFIG_S5PV210_COMMON_CLK is not set
# CONFIG_EXYNOS_3250_COMMON_CLK is not set
CONFIG_EXYNOS_4_COMMON_CLK=y
# CONFIG_EXYNOS_5250_COMMON_CLK is not set
# CONFIG_EXYNOS_5260_COMMON_CLK is not set
# CONFIG_EXYNOS_5410_COMMON_CLK is not set
CONFIG_EXYNOS_5420_COMMON_CLK=y
CONFIG_EXYNOS_ARM64_COMMON_CLK=y
# CONFIG_EXYNOS_AUDSS_CLK_CON is not set
# CONFIG_EXYNOS_CLKOUT is not set
CONFIG_S3C2410_COMMON_CLK=y
CONFIG_S3C2412_COMMON_CLK=y
# CONFIG_S3C2443_COMMON_CLK is not set
# CONFIG_TESLA_FSD_COMMON_CLK is not set
CONFIG_CLK_SIFIVE=y
CONFIG_CLK_SIFIVE_PRCI=y
# CONFIG_CLK_INTEL_SOCFPGA is not set
# CONFIG_SPRD_COMMON_CLK is not set
# CONFIG_CLK_STARFIVE_JH7100 is not set
# CONFIG_CLK_SUNXI is not set
CONFIG_SUNXI_CCU=y
CONFIG_SUNIV_F1C100S_CCU=y
CONFIG_SUN20I_D1_CCU=y
CONFIG_SUN20I_D1_R_CCU=y
# CONFIG_SUN50I_A64_CCU is not set
CONFIG_SUN50I_A100_CCU=y
# CONFIG_SUN50I_A100_R_CCU is not set
CONFIG_SUN50I_H6_CCU=y
CONFIG_SUN50I_H616_CCU=y
CONFIG_SUN50I_H6_R_CCU=y
CONFIG_SUN4I_A10_CCU=y
# CONFIG_SUN5I_CCU is not set
CONFIG_SUN6I_A31_CCU=y
CONFIG_SUN6I_RTC_CCU=y
CONFIG_SUN8I_A23_CCU=y
CONFIG_SUN8I_A33_CCU=y
CONFIG_SUN8I_A83T_CCU=y
CONFIG_SUN8I_H3_CCU=y
CONFIG_SUN8I_V3S_CCU=y
# CONFIG_SUN8I_DE2_CCU is not set
# CONFIG_SUN8I_R40_CCU is not set
# CONFIG_SUN9I_A80_CCU is not set
CONFIG_SUN8I_R_CCU=y
CONFIG_COMMON_CLK_TI_ADPLL=y
# CONFIG_CLK_UNIPHIER is not set
CONFIG_COMMON_CLK_VISCONTI=y
# CONFIG_CLK_LGM_CGU is not set
CONFIG_XILINX_VCU=y
CONFIG_COMMON_CLK_ZYNQMP=y
CONFIG_CLK_KUNIT_TEST=y
CONFIG_CLK_GATE_KUNIT_TEST=y
# CONFIG_HWSPINLOCK is not set

#
# Clock Source drivers
#
CONFIG_TIMER_OF=y
CONFIG_TIMER_PROBE=y
CONFIG_CLKSRC_MMIO=y
CONFIG_BCM2835_TIMER=y
CONFIG_BCM_KONA_TIMER=y
CONFIG_DAVINCI_TIMER=y
CONFIG_DIGICOLOR_TIMER=y
# CONFIG_DW_APB_TIMER is not set
CONFIG_FTTMR010_TIMER=y
CONFIG_IXP4XX_TIMER=y
# CONFIG_MESON6_TIMER is not set
CONFIG_OWL_TIMER=y
# CONFIG_RDA_TIMER is not set
CONFIG_SUN4I_TIMER=y
# CONFIG_SUN5I_HSTIMER is not set
# CONFIG_TEGRA_TIMER is not set
# CONFIG_VT8500_TIMER is not set
# CONFIG_NPCM7XX_TIMER is not set
CONFIG_CADENCE_TTC_TIMER=y
# CONFIG_ASM9260_TIMER is not set
# CONFIG_CLKSRC_DBX500_PRCMU is not set
# CONFIG_CLPS711X_TIMER is not set
# CONFIG_MXS_TIMER is not set
# CONFIG_NSPIRE_TIMER is not set
# CONFIG_INTEGRATOR_AP_TIMER is not set
CONFIG_CLKSRC_PISTACHIO=y
# CONFIG_CLKSRC_TI_32K is not set
CONFIG_CLKSRC_STM32_LP=y
# CONFIG_CLKSRC_MPS2 is not set
CONFIG_ARC_TIMERS=y
# CONFIG_ARC_TIMERS_64BIT is not set
# CONFIG_ARM_TIMER_SP804 is not set
CONFIG_ARMV7M_SYSTICK=y
# CONFIG_ATMEL_PIT is not set
# CONFIG_ATMEL_ST is not set
CONFIG_CLKSRC_SAMSUNG_PWM=y
# CONFIG_FSL_FTM_TIMER is not set
# CONFIG_OXNAS_RPS_TIMER is not set
# CONFIG_MTK_TIMER is not set
CONFIG_SPRD_TIMER=y
# CONFIG_CLKSRC_JCORE_PIT is not set
# CONFIG_SH_TIMER_CMT is not set
# CONFIG_SH_TIMER_MTU2 is not set
# CONFIG_RENESAS_OSTM is not set
# CONFIG_SH_TIMER_TMU is not set
CONFIG_EM_TIMER_STI=y
# CONFIG_CLKSRC_VERSATILE is not set
# CONFIG_CLKSRC_PXA is not set
# CONFIG_TIMER_IMX_SYS_CTR is not set
CONFIG_CLKSRC_ST_LPC=y
CONFIG_GXP_TIMER=y
CONFIG_MSC313E_TIMER=y
# CONFIG_INGENIC_TIMER is not set
CONFIG_INGENIC_SYSOST=y
# CONFIG_INGENIC_OST is not set
# CONFIG_MICROCHIP_PIT64B is not set
# end of Clock Source drivers

CONFIG_MAILBOX=y
# CONFIG_IMX_MBOX is not set
# CONFIG_PLATFORM_MHU is not set
# CONFIG_ARMADA_37XX_RWTM_MBOX is not set
# CONFIG_ROCKCHIP_MBOX is not set
CONFIG_PCC=y
CONFIG_ALTERA_MBOX=y
# CONFIG_HI3660_MBOX is not set
# CONFIG_HI6220_MBOX is not set
# CONFIG_MAILBOX_TEST is not set
# CONFIG_POLARFIRE_SOC_MAILBOX is not set
CONFIG_QCOM_APCS_IPC=y
# CONFIG_BCM_PDC_MBOX is not set
CONFIG_STM32_IPCC=y
CONFIG_MTK_ADSP_MBOX=y
CONFIG_MTK_CMDQ_MBOX=y
CONFIG_SUN6I_MSGBOX=y
# CONFIG_SPRD_MBOX is not set
CONFIG_QCOM_IPCC=y
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
CONFIG_IOMMU_IO_PGTABLE=y
CONFIG_IOMMU_IO_PGTABLE_LPAE=y
CONFIG_IOMMU_IO_PGTABLE_LPAE_SELFTEST=y
CONFIG_IOMMU_IO_PGTABLE_ARMV7S=y
CONFIG_IOMMU_IO_PGTABLE_ARMV7S_SELFTEST=y
# end of Generic IOMMU Pagetable Support

# CONFIG_IOMMU_DEBUGFS is not set
# CONFIG_IOMMU_DEFAULT_DMA_STRICT is not set
CONFIG_IOMMU_DEFAULT_DMA_LAZY=y
# CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
CONFIG_OF_IOMMU=y
# CONFIG_OMAP_IOMMU is not set
CONFIG_ROCKCHIP_IOMMU=y
CONFIG_SUN50I_IOMMU=y
# CONFIG_EXYNOS_IOMMU is not set
# CONFIG_IPMMU_VMSA is not set
# CONFIG_APPLE_DART is not set
CONFIG_ARM_SMMU=y
# CONFIG_ARM_SMMU_LEGACY_DT_BINDINGS is not set
CONFIG_ARM_SMMU_DISABLE_BYPASS_BY_DEFAULT=y
CONFIG_S390_CCW_IOMMU=y
# CONFIG_S390_AP_IOMMU is not set
# CONFIG_MTK_IOMMU is not set
# CONFIG_QCOM_IOMMU is not set
CONFIG_SPRD_IOMMU=y

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
CONFIG_RPMSG=y
CONFIG_RPMSG_CTRL=y
CONFIG_RPMSG_NS=y
CONFIG_RPMSG_QCOM_GLINK=y
CONFIG_RPMSG_QCOM_GLINK_RPM=y
# CONFIG_RPMSG_VIRTIO is not set
# end of Rpmsg drivers

# CONFIG_SOUNDWIRE is not set

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#
CONFIG_MESON_CANVAS=y
# CONFIG_MESON_CLK_MEASURE is not set
CONFIG_MESON_GX_SOCINFO=y
# CONFIG_MESON_MX_SOCINFO is not set
# end of Amlogic SoC drivers

#
# Apple SoC drivers
#
CONFIG_APPLE_RTKIT=y
CONFIG_APPLE_SART=y
# end of Apple SoC drivers

#
# ASPEED SoC drivers
#
CONFIG_ASPEED_LPC_CTRL=y
CONFIG_ASPEED_LPC_SNOOP=y
CONFIG_ASPEED_UART_ROUTING=y
# CONFIG_ASPEED_P2A_CTRL is not set
CONFIG_ASPEED_SOCINFO=y
# end of ASPEED SoC drivers

# CONFIG_AT91_SOC_ID is not set
# CONFIG_AT91_SOC_SFR is not set

#
# Broadcom SoC drivers
#
# CONFIG_BCM2835_POWER is not set
# CONFIG_SOC_BCM63XX is not set
CONFIG_SOC_BRCMSTB=y
# CONFIG_BCM_PMB is not set
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# CONFIG_QUICC_ENGINE is not set
CONFIG_DPAA2_CONSOLE=y
# end of NXP/Freescale QorIQ SoC drivers

#
# i.MX SoC drivers
#
CONFIG_SOC_IMX8M=y
# end of i.MX SoC drivers

#
# IXP4xx SoC drivers
#
# CONFIG_IXP4XX_QMGR is not set
CONFIG_IXP4XX_NPE=y
# end of IXP4xx SoC drivers

#
# Enable LiteX SoC Builder specific drivers
#
# CONFIG_LITEX_SOC_CONTROLLER is not set
# end of Enable LiteX SoC Builder specific drivers

#
# MediaTek SoC drivers
#
CONFIG_MTK_CMDQ=y
CONFIG_MTK_DEVAPC=y
CONFIG_MTK_INFRACFG=y
# CONFIG_MTK_PMIC_WRAP is not set
# CONFIG_MTK_SCPSYS is not set
# CONFIG_MTK_MMSYS is not set
# end of MediaTek SoC drivers

#
# Qualcomm SoC drivers
#
# CONFIG_QCOM_COMMAND_DB is not set
CONFIG_QCOM_GENI_SE=y
CONFIG_QCOM_GSBI=y
CONFIG_QCOM_LLCC=y
# CONFIG_QCOM_RPMH is not set
# CONFIG_QCOM_RPMPD is not set
CONFIG_QCOM_SMD_RPM=y
CONFIG_QCOM_SPM=y
CONFIG_QCOM_WCNSS_CTRL=y
# end of Qualcomm SoC drivers

# CONFIG_SOC_RENESAS is not set
# CONFIG_ROCKCHIP_GRF is not set
# CONFIG_ROCKCHIP_IODOMAIN is not set
CONFIG_SOC_SAMSUNG=y
# CONFIG_EXYNOS_ASV_ARM is not set
CONFIG_EXYNOS_CHIPID=y
# CONFIG_EXYNOS_USI is not set
# CONFIG_EXYNOS_PM_DOMAINS is not set
CONFIG_EXYNOS_REGULATOR_COUPLER=y
CONFIG_SOC_TEGRA20_VOLTAGE_COUPLER=y
# CONFIG_SOC_TEGRA30_VOLTAGE_COUPLER is not set
CONFIG_SOC_TI=y
# CONFIG_UX500_SOC_ID is not set

#
# Xilinx SoC drivers
#
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=y
CONFIG_DEVFREQ_GOV_PERFORMANCE=y
CONFIG_DEVFREQ_GOV_POWERSAVE=y
CONFIG_DEVFREQ_GOV_USERSPACE=y
# CONFIG_DEVFREQ_GOV_PASSIVE is not set

#
# DEVFREQ Drivers
#
# CONFIG_ARM_EXYNOS_BUS_DEVFREQ is not set
CONFIG_ARM_IMX_BUS_DEVFREQ=y
CONFIG_ARM_TEGRA_DEVFREQ=y
# CONFIG_ARM_SUN8I_A33_MBUS_DEVFREQ is not set
# CONFIG_PM_DEVFREQ_EVENT is not set
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
CONFIG_EXTCON_ADC_JACK=y
CONFIG_EXTCON_FSA9480=y
# CONFIG_EXTCON_GPIO is not set
CONFIG_EXTCON_INTEL_INT3496=y
# CONFIG_EXTCON_MAX3355 is not set
CONFIG_EXTCON_MAX8997=y
# CONFIG_EXTCON_PTN5150 is not set
CONFIG_EXTCON_QCOM_SPMI_MISC=y
# CONFIG_EXTCON_RT8973A is not set
# CONFIG_EXTCON_SM5502 is not set
CONFIG_EXTCON_USB_GPIO=y
# CONFIG_EXTCON_USBC_TUSB320 is not set
CONFIG_MEMORY=y
CONFIG_DDR=y
# CONFIG_ATMEL_SDRAMC is not set
# CONFIG_ATMEL_EBI is not set
CONFIG_BRCMSTB_DPFE=y
# CONFIG_BT1_L2_CTL is not set
# CONFIG_TI_AEMIF is not set
CONFIG_TI_EMIF=y
# CONFIG_OMAP_GPMC is not set
# CONFIG_MVEBU_DEVBUS is not set
CONFIG_FSL_CORENET_CF=y
CONFIG_FSL_IFC=y
# CONFIG_JZ4780_NEMC is not set
CONFIG_MTK_SMI=y
CONFIG_DA8XX_DDRCTL=y
CONFIG_RENESAS_RPCIF=y
# CONFIG_STM32_FMC2_EBI is not set
CONFIG_SAMSUNG_MC=y
# CONFIG_EXYNOS_SROM is not set
CONFIG_TEGRA_MC=y
CONFIG_TEGRA20_EMC=y
CONFIG_TEGRA30_EMC=y
# CONFIG_TEGRA124_EMC is not set
# CONFIG_TEGRA210_EMC is not set
CONFIG_IIO=y
CONFIG_IIO_BUFFER=y
CONFIG_IIO_BUFFER_CB=y
CONFIG_IIO_BUFFER_DMA=y
CONFIG_IIO_BUFFER_DMAENGINE=y
CONFIG_IIO_BUFFER_HW_CONSUMER=y
CONFIG_IIO_KFIFO_BUF=y
CONFIG_IIO_TRIGGERED_BUFFER=y
CONFIG_IIO_CONFIGFS=y
CONFIG_IIO_TRIGGER=y
CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
# CONFIG_IIO_SW_DEVICE is not set
CONFIG_IIO_SW_TRIGGER=y
CONFIG_IIO_TRIGGERED_EVENT=y

#
# Accelerometers
#
# CONFIG_ADIS16201 is not set
CONFIG_ADIS16209=y
CONFIG_ADXL313=y
# CONFIG_ADXL313_I2C is not set
CONFIG_ADXL313_SPI=y
CONFIG_ADXL345=y
CONFIG_ADXL345_I2C=y
CONFIG_ADXL345_SPI=y
CONFIG_ADXL355=y
CONFIG_ADXL355_I2C=y
CONFIG_ADXL355_SPI=y
CONFIG_ADXL367=y
CONFIG_ADXL367_SPI=y
CONFIG_ADXL367_I2C=y
CONFIG_ADXL372=y
CONFIG_ADXL372_SPI=y
# CONFIG_ADXL372_I2C is not set
CONFIG_BMA180=y
CONFIG_BMA220=y
# CONFIG_BMA400 is not set
# CONFIG_BMC150_ACCEL is not set
CONFIG_BMI088_ACCEL=y
CONFIG_BMI088_ACCEL_SPI=y
# CONFIG_DA280 is not set
CONFIG_DA311=y
CONFIG_DMARD06=y
CONFIG_DMARD09=y
# CONFIG_DMARD10 is not set
CONFIG_FXLS8962AF=y
# CONFIG_FXLS8962AF_I2C is not set
CONFIG_FXLS8962AF_SPI=y
CONFIG_KXSD9=y
CONFIG_KXSD9_SPI=y
CONFIG_KXSD9_I2C=y
CONFIG_KXCJK1013=y
CONFIG_MC3230=y
CONFIG_MMA7455=y
CONFIG_MMA7455_I2C=y
CONFIG_MMA7455_SPI=y
CONFIG_MMA7660=y
CONFIG_MMA8452=y
CONFIG_MMA9551_CORE=y
CONFIG_MMA9551=y
CONFIG_MMA9553=y
# CONFIG_MXC4005 is not set
CONFIG_MXC6255=y
# CONFIG_SCA3000 is not set
CONFIG_SCA3300=y
# CONFIG_STK8312 is not set
CONFIG_STK8BA50=y
# end of Accelerometers

#
# Analog to digital converters
#
CONFIG_AD_SIGMA_DELTA=y
# CONFIG_AD7091R5 is not set
CONFIG_AD7124=y
# CONFIG_AD7192 is not set
CONFIG_AD7266=y
# CONFIG_AD7280 is not set
CONFIG_AD7291=y
CONFIG_AD7292=y
CONFIG_AD7298=y
CONFIG_AD7476=y
# CONFIG_AD7606_IFACE_PARALLEL is not set
# CONFIG_AD7606_IFACE_SPI is not set
# CONFIG_AD7766 is not set
CONFIG_AD7768_1=y
CONFIG_AD7780=y
# CONFIG_AD7791 is not set
# CONFIG_AD7793 is not set
CONFIG_AD7887=y
CONFIG_AD7923=y
# CONFIG_AD7949 is not set
CONFIG_AD799X=y
# CONFIG_ADI_AXI_ADC is not set
CONFIG_ASPEED_ADC=y
# CONFIG_AT91_ADC is not set
CONFIG_AT91_SAMA5D2_ADC=y
CONFIG_AXP20X_ADC=y
CONFIG_AXP288_ADC=y
CONFIG_BCM_IPROC_ADC=y
CONFIG_BERLIN2_ADC=y
# CONFIG_CC10001_ADC is not set
# CONFIG_DA9150_GPADC is not set
CONFIG_ENVELOPE_DETECTOR=y
# CONFIG_EXYNOS_ADC is not set
CONFIG_MXS_LRADC_ADC=y
# CONFIG_FSL_MX25_ADC is not set
CONFIG_HI8435=y
CONFIG_HX711=y
CONFIG_INGENIC_ADC=y
CONFIG_IMX7D_ADC=y
CONFIG_IMX8QXP_ADC=y
CONFIG_LP8788_ADC=y
CONFIG_LPC18XX_ADC=y
CONFIG_LPC32XX_ADC=y
# CONFIG_LTC2471 is not set
# CONFIG_LTC2485 is not set
CONFIG_LTC2496=y
CONFIG_LTC2497=y
CONFIG_MAX1027=y
CONFIG_MAX11100=y
# CONFIG_MAX1118 is not set
# CONFIG_MAX1241 is not set
CONFIG_MAX1363=y
CONFIG_MAX9611=y
# CONFIG_MCP320X is not set
# CONFIG_MCP3422 is not set
# CONFIG_MCP3911 is not set
# CONFIG_MEDIATEK_MT6360_ADC is not set
# CONFIG_MEDIATEK_MT6577_AUXADC is not set
CONFIG_MEN_Z188_ADC=y
# CONFIG_MESON_SARADC is not set
CONFIG_NAU7802=y
# CONFIG_NPCM_ADC is not set
CONFIG_QCOM_VADC_COMMON=y
CONFIG_QCOM_SPMI_IADC=y
CONFIG_QCOM_SPMI_VADC=y
CONFIG_QCOM_SPMI_ADC5=y
CONFIG_RCAR_GYRO_ADC=y
CONFIG_ROCKCHIP_SARADC=y
# CONFIG_RZG2L_ADC is not set
CONFIG_SC27XX_ADC=y
CONFIG_SPEAR_ADC=y
CONFIG_SD_ADC_MODULATOR=y
# CONFIG_STM32_ADC_CORE is not set
# CONFIG_STM32_DFSDM_CORE is not set
# CONFIG_STM32_DFSDM_ADC is not set
CONFIG_SUN4I_GPADC=y
# CONFIG_TI_ADC081C is not set
CONFIG_TI_ADC0832=y
# CONFIG_TI_ADC084S021 is not set
# CONFIG_TI_ADC12138 is not set
CONFIG_TI_ADC108S102=y
CONFIG_TI_ADC128S052=y
CONFIG_TI_ADC161S626=y
CONFIG_TI_ADS1015=y
CONFIG_TI_ADS7950=y
CONFIG_TI_ADS8344=y
CONFIG_TI_ADS8688=y
CONFIG_TI_ADS124S08=y
CONFIG_TI_ADS131E08=y
# CONFIG_TI_AM335X_ADC is not set
CONFIG_TI_TLC4541=y
CONFIG_TI_TSC2046=y
CONFIG_VF610_ADC=y
CONFIG_XILINX_XADC=y
# CONFIG_XILINX_AMS is not set
# end of Analog to digital converters

#
# Analog to digital and digital to analog converters
#
CONFIG_AD74413R=y
# end of Analog to digital and digital to analog converters

#
# Analog Front Ends
#
# CONFIG_IIO_RESCALE is not set
# end of Analog Front Ends

#
# Amplifiers
#
CONFIG_AD8366=y
# CONFIG_ADA4250 is not set
CONFIG_HMC425=y
# end of Amplifiers

#
# Capacitance to digital converters
#
# CONFIG_AD7150 is not set
# end of Capacitance to digital converters

#
# Chemical Sensors
#
# CONFIG_ATLAS_PH_SENSOR is not set
CONFIG_ATLAS_EZO_SENSOR=y
CONFIG_BME680=y
CONFIG_BME680_I2C=y
CONFIG_BME680_SPI=y
# CONFIG_CCS811 is not set
CONFIG_IAQCORE=y
CONFIG_PMS7003=y
CONFIG_SCD30_CORE=y
# CONFIG_SCD30_I2C is not set
CONFIG_SCD30_SERIAL=y
# CONFIG_SCD4X is not set
CONFIG_SENSIRION_SGP30=y
CONFIG_SENSIRION_SGP40=y
CONFIG_SPS30=y
CONFIG_SPS30_I2C=y
CONFIG_SPS30_SERIAL=y
CONFIG_SENSEAIR_SUNRISE_CO2=y
CONFIG_VZ89X=y
# end of Chemical Sensors

#
# Hid Sensor IIO Common
#
# end of Hid Sensor IIO Common

CONFIG_IIO_MS_SENSORS_I2C=y

#
# IIO SCMI Sensors
#
CONFIG_IIO_SCMI=y
# end of IIO SCMI Sensors

#
# SSP Sensor Common
#
# CONFIG_IIO_SSP_SENSORHUB is not set
# end of SSP Sensor Common

CONFIG_IIO_ST_SENSORS_I2C=y
CONFIG_IIO_ST_SENSORS_SPI=y
CONFIG_IIO_ST_SENSORS_CORE=y

#
# Digital to analog converters
#
CONFIG_AD3552R=y
CONFIG_AD5064=y
# CONFIG_AD5360 is not set
# CONFIG_AD5380 is not set
# CONFIG_AD5421 is not set
CONFIG_AD5446=y
CONFIG_AD5449=y
CONFIG_AD5592R_BASE=y
CONFIG_AD5592R=y
CONFIG_AD5593R=y
# CONFIG_AD5504 is not set
# CONFIG_AD5624R_SPI is not set
CONFIG_LTC2688=y
CONFIG_AD5686=y
CONFIG_AD5686_SPI=y
CONFIG_AD5696_I2C=y
CONFIG_AD5755=y
# CONFIG_AD5758 is not set
CONFIG_AD5761=y
CONFIG_AD5764=y
# CONFIG_AD5766 is not set
# CONFIG_AD5770R is not set
# CONFIG_AD5791 is not set
CONFIG_AD7293=y
CONFIG_AD7303=y
CONFIG_AD8801=y
# CONFIG_DPOT_DAC is not set
CONFIG_DS4424=y
# CONFIG_LPC18XX_DAC is not set
# CONFIG_LTC1660 is not set
CONFIG_LTC2632=y
CONFIG_M62332=y
CONFIG_MAX517=y
# CONFIG_MAX5821 is not set
CONFIG_MCP4725=y
# CONFIG_MCP4922 is not set
CONFIG_STM32_DAC=y
CONFIG_STM32_DAC_CORE=y
# CONFIG_TI_DAC082S085 is not set
# CONFIG_TI_DAC5571 is not set
CONFIG_TI_DAC7311=y
CONFIG_TI_DAC7612=y
CONFIG_VF610_DAC=y
# end of Digital to analog converters

#
# IIO dummy driver
#
# end of IIO dummy driver

#
# Filters
#
CONFIG_ADMV8818=y
# end of Filters

#
# Frequency Synthesizers DDS/PLL
#

#
# Clock Generator/Distribution
#
CONFIG_AD9523=y
# end of Clock Generator/Distribution

#
# Phase-Locked Loop (PLL) frequency synthesizers
#
CONFIG_ADF4350=y
CONFIG_ADF4371=y
CONFIG_ADMV1013=y
CONFIG_ADMV1014=y
# CONFIG_ADMV4420 is not set
CONFIG_ADRF6780=y
# end of Phase-Locked Loop (PLL) frequency synthesizers
# end of Frequency Synthesizers DDS/PLL

#
# Digital gyroscope sensors
#
CONFIG_ADIS16080=y
# CONFIG_ADIS16130 is not set
# CONFIG_ADIS16136 is not set
# CONFIG_ADIS16260 is not set
CONFIG_ADXRS290=y
CONFIG_ADXRS450=y
CONFIG_BMG160=y
CONFIG_BMG160_I2C=y
CONFIG_BMG160_SPI=y
CONFIG_FXAS21002C=y
CONFIG_FXAS21002C_I2C=y
CONFIG_FXAS21002C_SPI=y
CONFIG_MPU3050=y
CONFIG_MPU3050_I2C=y
# CONFIG_IIO_ST_GYRO_3AXIS is not set
CONFIG_ITG3200=y
# end of Digital gyroscope sensors

#
# Health Sensors
#

#
# Heart Rate Monitors
#
CONFIG_AFE4403=y
CONFIG_AFE4404=y
# CONFIG_MAX30100 is not set
# CONFIG_MAX30102 is not set
# end of Heart Rate Monitors
# end of Health Sensors

#
# Humidity sensors
#
# CONFIG_AM2315 is not set
CONFIG_DHT11=y
CONFIG_HDC100X=y
CONFIG_HDC2010=y
CONFIG_HTS221=y
CONFIG_HTS221_I2C=y
CONFIG_HTS221_SPI=y
# CONFIG_HTU21 is not set
CONFIG_SI7005=y
CONFIG_SI7020=y
# end of Humidity sensors

#
# Inertial measurement units
#
# CONFIG_ADIS16400 is not set
CONFIG_ADIS16460=y
CONFIG_ADIS16475=y
# CONFIG_ADIS16480 is not set
CONFIG_BMI160=y
CONFIG_BMI160_I2C=y
# CONFIG_BMI160_SPI is not set
CONFIG_FXOS8700=y
# CONFIG_FXOS8700_I2C is not set
CONFIG_FXOS8700_SPI=y
# CONFIG_KMX61 is not set
CONFIG_INV_ICM42600=y
# CONFIG_INV_ICM42600_I2C is not set
CONFIG_INV_ICM42600_SPI=y
CONFIG_INV_MPU6050_IIO=y
# CONFIG_INV_MPU6050_I2C is not set
CONFIG_INV_MPU6050_SPI=y
CONFIG_IIO_ST_LSM6DSX=y
CONFIG_IIO_ST_LSM6DSX_I2C=y
CONFIG_IIO_ST_LSM6DSX_SPI=y
# end of Inertial measurement units

CONFIG_IIO_ADIS_LIB=y
CONFIG_IIO_ADIS_LIB_BUFFER=y

#
# Light sensors
#
CONFIG_ACPI_ALS=y
# CONFIG_ADJD_S311 is not set
# CONFIG_ADUX1020 is not set
CONFIG_AL3010=y
CONFIG_AL3320A=y
# CONFIG_APDS9300 is not set
CONFIG_APDS9960=y
CONFIG_AS73211=y
CONFIG_BH1750=y
# CONFIG_BH1780 is not set
CONFIG_CM32181=y
# CONFIG_CM3232 is not set
CONFIG_CM3323=y
CONFIG_CM3605=y
CONFIG_CM36651=y
# CONFIG_GP2AP002 is not set
# CONFIG_GP2AP020A00F is not set
# CONFIG_IQS621_ALS is not set
# CONFIG_SENSORS_ISL29018 is not set
CONFIG_SENSORS_ISL29028=y
# CONFIG_ISL29125 is not set
CONFIG_JSA1212=y
CONFIG_RPR0521=y
CONFIG_SENSORS_LM3533=y
# CONFIG_LTR501 is not set
CONFIG_LV0104CS=y
CONFIG_MAX44000=y
# CONFIG_MAX44009 is not set
CONFIG_NOA1305=y
# CONFIG_OPT3001 is not set
# CONFIG_PA12203001 is not set
# CONFIG_SI1133 is not set
CONFIG_SI1145=y
CONFIG_STK3310=y
CONFIG_ST_UVIS25=y
CONFIG_ST_UVIS25_I2C=y
CONFIG_ST_UVIS25_SPI=y
CONFIG_TCS3414=y
CONFIG_TCS3472=y
# CONFIG_SENSORS_TSL2563 is not set
CONFIG_TSL2583=y
CONFIG_TSL2591=y
CONFIG_TSL2772=y
CONFIG_TSL4531=y
CONFIG_US5182D=y
CONFIG_VCNL4000=y
CONFIG_VCNL4035=y
CONFIG_VEML6030=y
CONFIG_VEML6070=y
CONFIG_VL6180=y
CONFIG_ZOPT2201=y
# end of Light sensors

#
# Magnetometer sensors
#
CONFIG_AK8974=y
CONFIG_AK8975=y
CONFIG_AK09911=y
CONFIG_BMC150_MAGN=y
CONFIG_BMC150_MAGN_I2C=y
# CONFIG_BMC150_MAGN_SPI is not set
CONFIG_MAG3110=y
CONFIG_MMC35240=y
CONFIG_IIO_ST_MAGN_3AXIS=y
# CONFIG_IIO_ST_MAGN_I2C_3AXIS is not set
CONFIG_IIO_ST_MAGN_SPI_3AXIS=y
CONFIG_SENSORS_HMC5843=y
CONFIG_SENSORS_HMC5843_I2C=y
CONFIG_SENSORS_HMC5843_SPI=y
CONFIG_SENSORS_RM3100=y
CONFIG_SENSORS_RM3100_I2C=y
CONFIG_SENSORS_RM3100_SPI=y
# CONFIG_YAMAHA_YAS530 is not set
# end of Magnetometer sensors

#
# Multiplexers
#
CONFIG_IIO_MUX=y
# end of Multiplexers

#
# Inclinometer sensors
#
# end of Inclinometer sensors

# CONFIG_IIO_TEST_FORMAT is not set

#
# Triggers - standalone
#
CONFIG_IIO_HRTIMER_TRIGGER=y
# CONFIG_IIO_INTERRUPT_TRIGGER is not set
CONFIG_IIO_STM32_LPTIMER_TRIGGER=y
CONFIG_IIO_STM32_TIMER_TRIGGER=y
# CONFIG_IIO_TIGHTLOOP_TRIGGER is not set
CONFIG_IIO_SYSFS_TRIGGER=y
# end of Triggers - standalone

#
# Linear and angular position sensors
#
CONFIG_IQS624_POS=y
# end of Linear and angular position sensors

#
# Digital potentiometers
#
CONFIG_AD5110=y
# CONFIG_AD5272 is not set
# CONFIG_DS1803 is not set
CONFIG_MAX5432=y
# CONFIG_MAX5481 is not set
# CONFIG_MAX5487 is not set
CONFIG_MCP4018=y
CONFIG_MCP4131=y
CONFIG_MCP4531=y
CONFIG_MCP41010=y
CONFIG_TPL0102=y
# end of Digital potentiometers

#
# Digital potentiostats
#
CONFIG_LMP91000=y
# end of Digital potentiostats

#
# Pressure sensors
#
# CONFIG_ABP060MG is not set
CONFIG_BMP280=y
CONFIG_BMP280_I2C=y
CONFIG_BMP280_SPI=y
# CONFIG_DLHL60D is not set
# CONFIG_DPS310 is not set
CONFIG_HP03=y
CONFIG_ICP10100=y
CONFIG_MPL115=y
CONFIG_MPL115_I2C=y
CONFIG_MPL115_SPI=y
CONFIG_MPL3115=y
# CONFIG_MS5611 is not set
CONFIG_MS5637=y
CONFIG_IIO_ST_PRESS=y
CONFIG_IIO_ST_PRESS_I2C=y
CONFIG_IIO_ST_PRESS_SPI=y
# CONFIG_T5403 is not set
# CONFIG_HP206C is not set
CONFIG_ZPA2326=y
CONFIG_ZPA2326_I2C=y
CONFIG_ZPA2326_SPI=y
# end of Pressure sensors

#
# Lightning sensors
#
CONFIG_AS3935=y
# end of Lightning sensors

#
# Proximity and distance sensors
#
CONFIG_ISL29501=y
# CONFIG_LIDAR_LITE_V2 is not set
CONFIG_MB1232=y
CONFIG_PING=y
CONFIG_RFD77402=y
# CONFIG_SRF04 is not set
CONFIG_SX_COMMON=y
CONFIG_SX9310=y
CONFIG_SX9324=y
CONFIG_SX9360=y
CONFIG_SX9500=y
# CONFIG_SRF08 is not set
# CONFIG_VCNL3020 is not set
# CONFIG_VL53L0X_I2C is not set
# end of Proximity and distance sensors

#
# Resolver to digital converters
#
# CONFIG_AD2S90 is not set
CONFIG_AD2S1200=y
# end of Resolver to digital converters

#
# Temperature sensors
#
CONFIG_IQS620AT_TEMP=y
# CONFIG_LTC2983 is not set
CONFIG_MAXIM_THERMOCOUPLE=y
CONFIG_MLX90614=y
CONFIG_MLX90632=y
# CONFIG_TMP006 is not set
CONFIG_TMP007=y
CONFIG_TMP117=y
# CONFIG_TSYS01 is not set
# CONFIG_TSYS02D is not set
CONFIG_MAX31856=y
# CONFIG_MAX31865 is not set
# end of Temperature sensors

# CONFIG_NTB is not set
# CONFIG_VME_BUS is not set
# CONFIG_PWM is not set

#
# IRQ chip support
#
CONFIG_IRQCHIP=y
CONFIG_AL_FIC=y
CONFIG_MADERA_IRQ=y
# CONFIG_JCORE_AIC is not set
# CONFIG_RENESAS_INTC_IRQPIN is not set
# CONFIG_RENESAS_IRQC is not set
CONFIG_RENESAS_RZA1_IRQC=y
# CONFIG_SL28CPLD_INTC is not set
CONFIG_TS4800_IRQ=y
# CONFIG_XILINX_INTC is not set
# CONFIG_INGENIC_TCU_IRQ is not set
# CONFIG_IRQ_UNIPHIER_AIDET is not set
CONFIG_MESON_IRQ_GPIO=y
# CONFIG_IMX_IRQSTEER is not set
CONFIG_IMX_INTMUX=y
# CONFIG_EXYNOS_IRQ_COMBINER is not set
CONFIG_IRQ_LOONGARCH_CPU=y
CONFIG_LOONGSON_LIOINTC=y
CONFIG_LOONGSON_EIOINTC=y
CONFIG_LOONGSON_HTVEC=y
CONFIG_LOONGSON_PCH_PIC=y
CONFIG_LOONGSON_PCH_MSI=y
CONFIG_LOONGSON_PCH_LPC=y
CONFIG_MST_IRQ=y
CONFIG_MCHP_EIC=y
# end of IRQ chip support

# CONFIG_IPACK_BUS is not set
CONFIG_RESET_CONTROLLER=y
# CONFIG_RESET_ATH79 is not set
# CONFIG_RESET_AXS10X is not set
# CONFIG_RESET_BCM6345 is not set
CONFIG_RESET_BERLIN=y
CONFIG_RESET_BRCMSTB=y
CONFIG_RESET_BRCMSTB_RESCAL=y
CONFIG_RESET_HSDK=y
CONFIG_RESET_IMX7=y
# CONFIG_RESET_INTEL_GW is not set
# CONFIG_RESET_K210 is not set
CONFIG_RESET_LANTIQ=y
# CONFIG_RESET_LPC18XX is not set
# CONFIG_RESET_MCHP_SPARX5 is not set
CONFIG_RESET_MESON=y
# CONFIG_RESET_MESON_AUDIO_ARB is not set
CONFIG_RESET_NPCM=y
CONFIG_RESET_PISTACHIO=y
# CONFIG_RESET_QCOM_AOSS is not set
CONFIG_RESET_QCOM_PDC=y
CONFIG_RESET_RASPBERRYPI=y
CONFIG_RESET_RZG2L_USBPHY_CTRL=y
CONFIG_RESET_SCMI=y
CONFIG_RESET_SIMPLE=y
CONFIG_RESET_SOCFPGA=y
# CONFIG_RESET_STARFIVE_JH7100 is not set
# CONFIG_RESET_SUNXI is not set
CONFIG_RESET_TI_SCI=y
# CONFIG_RESET_TI_SYSCON is not set
# CONFIG_RESET_TN48M_CPLD is not set
# CONFIG_RESET_UNIPHIER is not set
# CONFIG_RESET_UNIPHIER_GLUE is not set
CONFIG_RESET_ZYNQ=y
CONFIG_COMMON_RESET_HI3660=y
CONFIG_COMMON_RESET_HI6220=y

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
CONFIG_GENERIC_PHY_MIPI_DPHY=y
# CONFIG_PHY_LPC18XX_USB_OTG is not set
# CONFIG_PHY_PISTACHIO_USB is not set
# CONFIG_PHY_XGENE is not set
# CONFIG_PHY_CAN_TRANSCEIVER is not set
CONFIG_PHY_SUN6I_MIPI_DPHY=y
# CONFIG_PHY_SUN50I_USB3 is not set
# CONFIG_PHY_MESON8_HDMI_TX is not set
# CONFIG_PHY_MESON_G12A_USB2 is not set
# CONFIG_PHY_MESON_G12A_USB3_PCIE is not set
# CONFIG_PHY_MESON_AXG_PCIE is not set
# CONFIG_PHY_MESON_AXG_MIPI_PCIE_ANALOG is not set
# CONFIG_PHY_MESON_AXG_MIPI_DPHY is not set

#
# PHY drivers for Broadcom platforms
#
# CONFIG_PHY_BCM63XX_USBH is not set
# CONFIG_PHY_CYGNUS_PCIE is not set
# CONFIG_PHY_BCM_SR_USB is not set
# CONFIG_BCM_KONA_USB2_PHY is not set
# CONFIG_PHY_BCM_NS_USB2 is not set
# CONFIG_PHY_NS2_USB_DRD is not set
# CONFIG_PHY_BRCM_SATA is not set
# CONFIG_PHY_BRCM_USB is not set
# CONFIG_PHY_BCM_SR_PCIE is not set
# end of PHY drivers for Broadcom platforms

# CONFIG_PHY_CADENCE_TORRENT is not set
# CONFIG_PHY_CADENCE_DPHY is not set
# CONFIG_PHY_CADENCE_DPHY_RX is not set
# CONFIG_PHY_CADENCE_SIERRA is not set
# CONFIG_PHY_CADENCE_SALVO is not set
# CONFIG_PHY_FSL_IMX8MQ_USB is not set
# CONFIG_PHY_MIXEL_MIPI_DPHY is not set
# CONFIG_PHY_FSL_IMX8M_PCIE is not set
# CONFIG_PHY_FSL_LYNX_28G is not set
CONFIG_PHY_HI6220_USB=y
CONFIG_PHY_HI3660_USB=y
CONFIG_PHY_HI3670_USB=y
# CONFIG_PHY_HI3670_PCIE is not set
CONFIG_PHY_HISTB_COMBPHY=y
# CONFIG_PHY_HISI_INNO_USB2 is not set
# CONFIG_PHY_LANTIQ_VRX200_PCIE is not set
# CONFIG_PHY_LANTIQ_RCU_USB2 is not set
# CONFIG_ARMADA375_USBCLUSTER_PHY is not set
# CONFIG_PHY_BERLIN_SATA is not set
# CONFIG_PHY_BERLIN_USB is not set
CONFIG_PHY_MVEBU_A3700_UTMI=y
# CONFIG_PHY_MVEBU_A38X_COMPHY is not set
# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
# CONFIG_PHY_PXA_USB is not set
CONFIG_PHY_MMP3_USB=y
CONFIG_PHY_MMP3_HSIC=y
# CONFIG_PHY_MTK_TPHY is not set
# CONFIG_PHY_MTK_UFS is not set
# CONFIG_PHY_MTK_XSPHY is not set
# CONFIG_PHY_MTK_HDMI is not set
# CONFIG_PHY_MTK_MIPI_DSI is not set
# CONFIG_PHY_SPARX5_SERDES is not set
# CONFIG_PHY_LAN966X_SERDES is not set
# CONFIG_PHY_OCELOT_SERDES is not set
# CONFIG_PHY_ATH79_USB is not set
# CONFIG_PHY_QCOM_EDP is not set
# CONFIG_PHY_QCOM_IPQ4019_USB is not set
# CONFIG_PHY_QCOM_PCIE2 is not set
# CONFIG_PHY_QCOM_QMP is not set
# CONFIG_PHY_QCOM_QUSB2 is not set
# CONFIG_PHY_QCOM_USB_SNPS_FEMTO_V2 is not set
# CONFIG_PHY_QCOM_USB_HS_28NM is not set
# CONFIG_PHY_QCOM_USB_SS is not set
# CONFIG_PHY_QCOM_IPQ806X_USB is not set
CONFIG_PHY_MT7621_PCI=y
# CONFIG_PHY_RALINK_USB is not set
CONFIG_PHY_RCAR_GEN3_USB3=y
CONFIG_PHY_ROCKCHIP_DPHY_RX0=y
# CONFIG_PHY_ROCKCHIP_INNO_HDMI is not set
# CONFIG_PHY_ROCKCHIP_INNO_CSIDPHY is not set
# CONFIG_PHY_ROCKCHIP_INNO_DSIDPHY is not set
# CONFIG_PHY_ROCKCHIP_PCIE is not set
# CONFIG_PHY_ROCKCHIP_TYPEC is not set
# CONFIG_PHY_EXYNOS_DP_VIDEO is not set
CONFIG_PHY_EXYNOS_MIPI_VIDEO=y
# CONFIG_PHY_EXYNOS_PCIE is not set
# CONFIG_PHY_SAMSUNG_UFS is not set
# CONFIG_PHY_SAMSUNG_USB2 is not set
# CONFIG_PHY_UNIPHIER_USB2 is not set
# CONFIG_PHY_UNIPHIER_USB3 is not set
CONFIG_PHY_UNIPHIER_PCIE=y
# CONFIG_PHY_UNIPHIER_AHCI is not set
CONFIG_PHY_ST_SPEAR1310_MIPHY=y
CONFIG_PHY_ST_SPEAR1340_MIPHY=y
CONFIG_PHY_STIH407_USB=y
CONFIG_PHY_STM32_USBPHYC=y
CONFIG_PHY_TEGRA194_P2U=y
CONFIG_PHY_DA8XX_USB=y
CONFIG_PHY_AM654_SERDES=y
# CONFIG_PHY_J721E_WIZ is not set
# CONFIG_OMAP_CONTROL_PHY is not set
# CONFIG_TI_PIPE3 is not set
# CONFIG_PHY_INTEL_KEEMBAY_EMMC is not set
CONFIG_PHY_INTEL_KEEMBAY_USB=y
# CONFIG_PHY_INTEL_LGM_COMBO is not set
CONFIG_PHY_INTEL_LGM_EMMC=y
# CONFIG_PHY_INTEL_THUNDERBAY_EMMC is not set
CONFIG_PHY_XILINX_ZYNQMP=y
# end of PHY Subsystem

CONFIG_POWERCAP=y
# CONFIG_DTPM is not set
CONFIG_MCB=y
# CONFIG_MCB_PCI is not set
CONFIG_MCB_LPC=y
# CONFIG_RAS is not set
CONFIG_USB4=y
CONFIG_USB4_DEBUGFS_WRITE=y
CONFIG_USB4_KUNIT_TEST=y
CONFIG_USB4_DMA_TEST=y

#
# Android
#
# CONFIG_ANDROID is not set
# end of Android

CONFIG_DAX=y
# CONFIG_DEV_DAX is not set
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y
# CONFIG_NVMEM_IMX_IIM is not set
CONFIG_NVMEM_IMX_OCOTP=y
# CONFIG_JZ4780_EFUSE is not set
CONFIG_NVMEM_LPC18XX_EEPROM=y
CONFIG_NVMEM_LPC18XX_OTP=y
CONFIG_NVMEM_MXS_OCOTP=y
# CONFIG_MTK_EFUSE is not set
CONFIG_NVMEM_NINTENDO_OTP=y
# CONFIG_QCOM_QFPROM is not set
# CONFIG_NVMEM_SPMI_SDAM is not set
# CONFIG_ROCKCHIP_EFUSE is not set
# CONFIG_ROCKCHIP_OTP is not set
CONFIG_NVMEM_BCM_OCOTP=y
# CONFIG_NVMEM_STM32_ROMEM is not set
# CONFIG_UNIPHIER_EFUSE is not set
CONFIG_NVMEM_VF610_OCOTP=y
# CONFIG_MESON_MX_EFUSE is not set
CONFIG_NVMEM_SNVS_LPGPR=y
# CONFIG_RAVE_SP_EEPROM is not set
# CONFIG_SC27XX_EFUSE is not set
# CONFIG_SPRD_EFUSE is not set
CONFIG_NVMEM_RMEM=y
CONFIG_NVMEM_BRCM_NVRAM=y
# CONFIG_NVMEM_LAYERSCAPE_SFP is not set
CONFIG_NVMEM_SUNPLUS_OCOTP=y
CONFIG_NVMEM_APPLE_EFUSES=y

#
# HW tracing support
#
# CONFIG_STM is not set
# CONFIG_INTEL_TH is not set
# end of HW tracing support

# CONFIG_FPGA is not set
# CONFIG_FSI is not set
CONFIG_TEE=y
CONFIG_MULTIPLEXER=y

#
# Multiplexer drivers
#
CONFIG_MUX_ADG792A=y
CONFIG_MUX_ADGS1408=y
# CONFIG_MUX_GPIO is not set
CONFIG_MUX_MMIO=y
# end of Multiplexer drivers

CONFIG_PM_OPP=y
CONFIG_SIOX=y
# CONFIG_SIOX_BUS_GPIO is not set
# CONFIG_SLIMBUS is not set
CONFIG_INTERCONNECT=y
CONFIG_INTERCONNECT_IMX=y
CONFIG_INTERCONNECT_IMX8MM=y
# CONFIG_INTERCONNECT_IMX8MN is not set
CONFIG_INTERCONNECT_IMX8MQ=y
CONFIG_INTERCONNECT_QCOM_OSM_L3=y
# CONFIG_INTERCONNECT_SAMSUNG is not set
CONFIG_COUNTER=y
# CONFIG_104_QUAD_8 is not set
# CONFIG_INTERRUPT_CNT is not set
# CONFIG_STM32_TIMER_CNT is not set
CONFIG_STM32_LPTIMER_CNT=y
CONFIG_TI_EQEP=y
# CONFIG_FTM_QUADDEC is not set
# CONFIG_MICROCHIP_TCB_CAPTURE is not set
CONFIG_INTEL_QEP=y
CONFIG_MOST=y
# CONFIG_MOST_CDEV is not set
CONFIG_MOST_SND=y
CONFIG_PECI=y
# CONFIG_PECI_CPU is not set
# CONFIG_PECI_ASPEED is not set
# CONFIG_HTE is not set
# end of Device Drivers

#
# File systems
#
CONFIG_VALIDATE_FS_PARSER=y
CONFIG_FS_IOMAP=y
CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
# CONFIG_EXT2_FS_POSIX_ACL is not set
# CONFIG_EXT2_FS_SECURITY is not set
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=y
CONFIG_EXT4_FS_POSIX_ACL=y
# CONFIG_EXT4_FS_SECURITY is not set
CONFIG_EXT4_DEBUG=y
CONFIG_EXT4_KUNIT_TESTS=y
CONFIG_JBD2=y
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=y
# CONFIG_REISERFS_CHECK is not set
CONFIG_REISERFS_PROC_INFO=y
# CONFIG_REISERFS_FS_XATTR is not set
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=y
CONFIG_XFS_SUPPORT_V4=y
# CONFIG_XFS_QUOTA is not set
# CONFIG_XFS_POSIX_ACL is not set
CONFIG_XFS_RT=y
# CONFIG_XFS_ONLINE_SCRUB is not set
# CONFIG_XFS_WARN is not set
# CONFIG_XFS_DEBUG is not set
CONFIG_GFS2_FS=y
# CONFIG_BTRFS_FS is not set
CONFIG_NILFS2_FS=y
CONFIG_F2FS_FS=y
# CONFIG_F2FS_STAT_FS is not set
CONFIG_F2FS_FS_XATTR=y
# CONFIG_F2FS_FS_POSIX_ACL is not set
CONFIG_F2FS_FS_SECURITY=y
# CONFIG_F2FS_CHECK_FS is not set
# CONFIG_F2FS_FAULT_INJECTION is not set
CONFIG_F2FS_FS_COMPRESSION=y
# CONFIG_F2FS_FS_LZO is not set
CONFIG_F2FS_FS_LZ4=y
CONFIG_F2FS_FS_LZ4HC=y
# CONFIG_F2FS_FS_ZSTD is not set
CONFIG_F2FS_IOSTAT=y
# CONFIG_ZONEFS_FS is not set
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
# CONFIG_EXPORTFS_BLOCK_OPS is not set
# CONFIG_FILE_LOCKING is not set
CONFIG_FS_ENCRYPTION=y
CONFIG_FS_ENCRYPTION_ALGS=y
CONFIG_FS_VERITY=y
CONFIG_FS_VERITY_DEBUG=y
# CONFIG_FS_VERITY_BUILTIN_SIGNATURES is not set
CONFIG_FSNOTIFY=y
# CONFIG_DNOTIFY is not set
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
# CONFIG_QUOTA is not set
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=y
CONFIG_CUSE=y
# CONFIG_VIRTIO_FS is not set
CONFIG_OVERLAY_FS=y
# CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
# CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
CONFIG_OVERLAY_FS_INDEX=y
# CONFIG_OVERLAY_FS_NFS_EXPORT is not set
# CONFIG_OVERLAY_FS_XINO_AUTO is not set
# CONFIG_OVERLAY_FS_METACOPY is not set

#
# Caches
#
CONFIG_NETFS_SUPPORT=y
CONFIG_NETFS_STATS=y
CONFIG_FSCACHE=y
# CONFIG_FSCACHE_STATS is not set
# CONFIG_FSCACHE_DEBUG is not set
CONFIG_CACHEFILES=y
CONFIG_CACHEFILES_DEBUG=y
# CONFIG_CACHEFILES_ONDEMAND is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
# CONFIG_JOLIET is not set
CONFIG_ZISOFS=y
# CONFIG_UDF_FS is not set
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/EXFAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
CONFIG_FAT_DEFAULT_UTF8=y
CONFIG_FAT_KUNIT_TEST=y
CONFIG_EXFAT_FS=y
CONFIG_EXFAT_DEFAULT_IOCHARSET="utf8"
CONFIG_NTFS_FS=y
# CONFIG_NTFS_DEBUG is not set
# CONFIG_NTFS_RW is not set
CONFIG_NTFS3_FS=y
# CONFIG_NTFS3_64BIT_CLUSTER is not set
CONFIG_NTFS3_LZX_XPRESS=y
CONFIG_NTFS3_FS_POSIX_ACL=y
# end of DOS/FAT/EXFAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
# CONFIG_PROC_SYSCTL is not set
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_TMPFS_POSIX_ACL is not set
CONFIG_TMPFS_XATTR=y
# CONFIG_TMPFS_INODE64 is not set
CONFIG_ARCH_SUPPORTS_HUGETLBFS=y
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_MEMFD_CREATE=y
CONFIG_CONFIGFS_FS=y
CONFIG_EFIVAR_FS=y
# end of Pseudo filesystems

# CONFIG_MISC_FILESYSTEMS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=y
CONFIG_NLS_CODEPAGE_775=y
CONFIG_NLS_CODEPAGE_850=y
CONFIG_NLS_CODEPAGE_852=y
# CONFIG_NLS_CODEPAGE_855 is not set
CONFIG_NLS_CODEPAGE_857=y
# CONFIG_NLS_CODEPAGE_860 is not set
CONFIG_NLS_CODEPAGE_861=y
CONFIG_NLS_CODEPAGE_862=y
CONFIG_NLS_CODEPAGE_863=y
# CONFIG_NLS_CODEPAGE_864 is not set
CONFIG_NLS_CODEPAGE_865=y
CONFIG_NLS_CODEPAGE_866=y
CONFIG_NLS_CODEPAGE_869=y
CONFIG_NLS_CODEPAGE_936=y
CONFIG_NLS_CODEPAGE_950=y
CONFIG_NLS_CODEPAGE_932=y
# CONFIG_NLS_CODEPAGE_949 is not set
CONFIG_NLS_CODEPAGE_874=y
CONFIG_NLS_ISO8859_8=y
CONFIG_NLS_CODEPAGE_1250=y
CONFIG_NLS_CODEPAGE_1251=y
# CONFIG_NLS_ASCII is not set
CONFIG_NLS_ISO8859_1=y
# CONFIG_NLS_ISO8859_2 is not set
CONFIG_NLS_ISO8859_3=y
CONFIG_NLS_ISO8859_4=y
CONFIG_NLS_ISO8859_5=y
# CONFIG_NLS_ISO8859_6 is not set
CONFIG_NLS_ISO8859_7=y
# CONFIG_NLS_ISO8859_9 is not set
CONFIG_NLS_ISO8859_13=y
CONFIG_NLS_ISO8859_14=y
CONFIG_NLS_ISO8859_15=y
CONFIG_NLS_KOI8_R=y
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_MAC_ROMAN is not set
CONFIG_NLS_MAC_CELTIC=y
CONFIG_NLS_MAC_CENTEURO=y
CONFIG_NLS_MAC_CROATIAN=y
CONFIG_NLS_MAC_CYRILLIC=y
CONFIG_NLS_MAC_GAELIC=y
# CONFIG_NLS_MAC_GREEK is not set
CONFIG_NLS_MAC_ICELAND=y
# CONFIG_NLS_MAC_INUIT is not set
CONFIG_NLS_MAC_ROMANIAN=y
CONFIG_NLS_MAC_TURKISH=y
CONFIG_NLS_UTF8=y
CONFIG_UNICODE=y
# CONFIG_UNICODE_NORMALIZATION_SELFTEST is not set
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
CONFIG_KEYS_REQUEST_CACHE=y
CONFIG_PERSISTENT_KEYRINGS=y
# CONFIG_BIG_KEYS is not set
CONFIG_TRUSTED_KEYS=y
CONFIG_TRUSTED_KEYS_TEE=y
CONFIG_ENCRYPTED_KEYS=y
CONFIG_USER_DECRYPTED_DATA=y
CONFIG_KEY_DH_OPERATIONS=y
CONFIG_SECURITY_DMESG_RESTRICT=y
CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
CONFIG_SECURITY_PATH=y
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
# CONFIG_HARDENED_USERCOPY is not set
CONFIG_STATIC_USERMODEHELPER=y
CONFIG_STATIC_USERMODEHELPER_PATH="/sbin/usermode-helper"
CONFIG_SECURITY_LOADPIN=y
# CONFIG_SECURITY_LOADPIN_ENFORCE is not set
# CONFIG_SECURITY_YAMA is not set
CONFIG_SECURITY_SAFESETID=y
CONFIG_SECURITY_LOCKDOWN_LSM=y
# CONFIG_SECURITY_LOCKDOWN_LSM_EARLY is not set
# CONFIG_LOCK_DOWN_KERNEL_FORCE_NONE is not set
CONFIG_LOCK_DOWN_KERNEL_FORCE_INTEGRITY=y
# CONFIG_LOCK_DOWN_KERNEL_FORCE_CONFIDENTIALITY is not set
# CONFIG_SECURITY_LANDLOCK is not set
CONFIG_INTEGRITY=y
CONFIG_INTEGRITY_SIGNATURE=y
CONFIG_INTEGRITY_ASYMMETRIC_KEYS=y
# CONFIG_INTEGRITY_PLATFORM_KEYRING is not set
# CONFIG_IMA is not set
# CONFIG_EVM is not set
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_LSM="landlock,lockdown,yama,loadpin,safesetid,integrity,bpf"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_CC_HAS_AUTO_VAR_INIT_PATTERN=y
CONFIG_CC_HAS_AUTO_VAR_INIT_ZERO=y
CONFIG_INIT_STACK_NONE=y
# CONFIG_INIT_STACK_ALL_PATTERN is not set
# CONFIG_INIT_STACK_ALL_ZERO is not set
CONFIG_INIT_ON_ALLOC_DEFAULT_ON=y
CONFIG_INIT_ON_FREE_DEFAULT_ON=y
CONFIG_CC_HAS_ZERO_CALL_USED_REGS=y
# CONFIG_ZERO_CALL_USED_REGS is not set
# end of Memory initialization

CONFIG_RANDSTRUCT_NONE=y
# end of Kernel hardening options
# end of Security options

CONFIG_XOR_BLOCKS=y
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_SKCIPHER=y
CONFIG_CRYPTO_SKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=y
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=y
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=y
CONFIG_CRYPTO_TEST=y
CONFIG_CRYPTO_ENGINE=y

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=y
CONFIG_CRYPTO_DH_RFC7919_GROUPS=y
CONFIG_CRYPTO_ECC=y
CONFIG_CRYPTO_ECDH=y
CONFIG_CRYPTO_ECDSA=y
CONFIG_CRYPTO_ECRDSA=y
# CONFIG_CRYPTO_SM2 is not set
CONFIG_CRYPTO_CURVE25519=y

#
# Authenticated Encryption with Associated Data
#
# CONFIG_CRYPTO_CCM is not set
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_CHACHA20POLY1305=y
# CONFIG_CRYPTO_AEGIS128 is not set
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=y

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CFB=y
CONFIG_CRYPTO_CTR=y
# CONFIG_CRYPTO_CTS is not set
CONFIG_CRYPTO_ECB=y
# CONFIG_CRYPTO_LRW is not set
CONFIG_CRYPTO_OFB=y
CONFIG_CRYPTO_PCBC=y
# CONFIG_CRYPTO_XTS is not set
CONFIG_CRYPTO_KEYWRAP=y
CONFIG_CRYPTO_NHPOLY1305=y
CONFIG_CRYPTO_ADIANTUM=y
# CONFIG_CRYPTO_ESSIV is not set

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=y
CONFIG_CRYPTO_VMAC=y

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32=y
CONFIG_CRYPTO_XXHASH=y
CONFIG_CRYPTO_BLAKE2B=y
# CONFIG_CRYPTO_BLAKE2S is not set
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRC64_ROCKSOFT=y
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_POLY1305=y
CONFIG_CRYPTO_MD4=y
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=y
# CONFIG_CRYPTO_RMD160 is not set
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=y
CONFIG_CRYPTO_SM3=y
CONFIG_CRYPTO_SM3_GENERIC=y
CONFIG_CRYPTO_STREEBOG=y
# CONFIG_CRYPTO_WP512 is not set

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_AES_TI=y
# CONFIG_CRYPTO_BLOWFISH is not set
CONFIG_CRYPTO_CAMELLIA=y
CONFIG_CRYPTO_CAST_COMMON=y
CONFIG_CRYPTO_CAST5=y
# CONFIG_CRYPTO_CAST6 is not set
CONFIG_CRYPTO_DES=y
# CONFIG_CRYPTO_FCRYPT is not set
CONFIG_CRYPTO_CHACHA20=y
CONFIG_CRYPTO_SERPENT=y
CONFIG_CRYPTO_SM4=y
CONFIG_CRYPTO_SM4_GENERIC=y
# CONFIG_CRYPTO_TWOFISH is not set

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
CONFIG_CRYPTO_842=y
CONFIG_CRYPTO_LZ4=y
# CONFIG_CRYPTO_LZ4HC is not set
CONFIG_CRYPTO_ZSTD=y

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=y
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_KDF800108_CTR=y
CONFIG_CRYPTO_HASH_INFO=y
CONFIG_CRYPTO_HW=y
CONFIG_CRYPTO_DEV_ALLWINNER=y
CONFIG_CRYPTO_DEV_EXYNOS_RNG=y
CONFIG_CRYPTO_DEV_S5P=y
CONFIG_CRYPTO_DEV_ATMEL_AUTHENC=y
CONFIG_CRYPTO_DEV_ATMEL_AES=y
# CONFIG_CRYPTO_DEV_ATMEL_TDES is not set
CONFIG_CRYPTO_DEV_ATMEL_SHA=y
CONFIG_CRYPTO_DEV_ATMEL_I2C=y
CONFIG_CRYPTO_DEV_ATMEL_ECC=y
# CONFIG_CRYPTO_DEV_ATMEL_SHA204A is not set
# CONFIG_CAVIUM_CPT is not set
CONFIG_CRYPTO_DEV_NITROX=y
CONFIG_CRYPTO_DEV_NITROX_CNN55XX=y
CONFIG_CRYPTO_DEV_MARVELL=y
CONFIG_CRYPTO_DEV_OCTEONTX_CPT=y
# CONFIG_CRYPTO_DEV_CAVIUM_ZIP is not set
CONFIG_CRYPTO_DEV_QCE=y
CONFIG_CRYPTO_DEV_QCE_SHA=y
# CONFIG_CRYPTO_DEV_QCE_ENABLE_ALL is not set
# CONFIG_CRYPTO_DEV_QCE_ENABLE_SKCIPHER is not set
CONFIG_CRYPTO_DEV_QCE_ENABLE_SHA=y
# CONFIG_CRYPTO_DEV_QCE_ENABLE_AEAD is not set
CONFIG_CRYPTO_DEV_QCOM_RNG=y
CONFIG_CRYPTO_DEV_IMGTEC_HASH=y
CONFIG_CRYPTO_DEV_ZYNQMP_AES=y
# CONFIG_CRYPTO_DEV_ZYNQMP_SHA3 is not set
CONFIG_CRYPTO_DEV_VIRTIO=y
CONFIG_CRYPTO_DEV_SAFEXCEL=y
# CONFIG_CRYPTO_DEV_CCREE is not set
# CONFIG_CRYPTO_DEV_HISI_SEC is not set
# CONFIG_CRYPTO_DEV_HISI_SEC2 is not set
CONFIG_CRYPTO_DEV_HISI_QM=y
# CONFIG_CRYPTO_DEV_HISI_ZIP is not set
CONFIG_CRYPTO_DEV_HISI_HPRE=y
CONFIG_CRYPTO_DEV_AMLOGIC_GXL=y
CONFIG_CRYPTO_DEV_AMLOGIC_GXL_DEBUG=y
CONFIG_CRYPTO_DEV_SA2UL=y
# CONFIG_CRYPTO_DEV_KEEMBAY_OCS_AES_SM4 is not set
# CONFIG_CRYPTO_DEV_KEEMBAY_OCS_ECC is not set
# CONFIG_CRYPTO_DEV_KEEMBAY_OCS_HCU is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
# CONFIG_PKCS8_PRIVATE_KEY_PARSER is not set
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_FIPS_SIGNATURE_SELFTEST is not set

#
# Certificates for signature checking
#
# CONFIG_SYSTEM_TRUSTED_KEYRING is not set
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
CONFIG_SYSTEM_REVOCATION_LIST=y
CONFIG_SYSTEM_REVOCATION_KEYS=""
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_LINEAR_RANGES=y
# CONFIG_PACKING is not set
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_CORDIC=y
CONFIG_PRIME_NUMBERS=y
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_STMP_DEVICE=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=y
CONFIG_CRYPTO_LIB_CHACHA=y
CONFIG_CRYPTO_LIB_CURVE25519_GENERIC=y
CONFIG_CRYPTO_LIB_CURVE25519=y
CONFIG_CRYPTO_LIB_DES=y
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=1
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=y
CONFIG_CRYPTO_LIB_POLY1305=y
CONFIG_CRYPTO_LIB_CHACHA20POLY1305=y
CONFIG_CRYPTO_LIB_SHA256=y
# end of Crypto library routines

CONFIG_LIB_MEMNEQ=y
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC64_ROCKSOFT=y
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
CONFIG_CRC32_SELFTEST=y
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
CONFIG_CRC64=y
CONFIG_CRC4=y
CONFIG_CRC7=y
CONFIG_LIBCRC32C=y
CONFIG_CRC8=y
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_842_COMPRESS=y
CONFIG_842_DECOMPRESS=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_COMPRESS=y
CONFIG_LZ4HC_COMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=y
CONFIG_ZSTD_DECOMPRESS=y
# CONFIG_XZ_DEC is not set
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_INTERVAL_TREE=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_DMA_DECLARE_COHERENT=y
CONFIG_SWIOTLB=y
# CONFIG_DMA_RESTRICTED_POOL is not set
CONFIG_DMA_API_DEBUG=y
CONFIG_DMA_API_DEBUG_SG=y
CONFIG_DMA_MAP_BENCHMARK=y
CONFIG_SGL_ALLOC=y
# CONFIG_CPUMASK_OFFSTACK is not set
CONFIG_GLOB=y
CONFIG_GLOB_SELFTEST=y
CONFIG_CLZ_TAB=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_SIGNATURE=y
CONFIG_LIBFDT=y
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_FONT_SUPPORT=y
CONFIG_FONT_8x16=y
CONFIG_FONT_AUTOSELECT=y
CONFIG_SG_SPLIT=y
CONFIG_SG_POOL=y
CONFIG_ARCH_STACKWALK=y
CONFIG_STACKDEPOT=y
CONFIG_STACK_HASH_ORDER=20
CONFIG_SBITMAP=y
# CONFIG_PARMAN is not set
# CONFIG_OBJAGG is not set
# end of Library routines

CONFIG_GENERIC_LIB_ASHLDI3=y
CONFIG_GENERIC_LIB_ASHRDI3=y
CONFIG_GENERIC_LIB_LSHRDI3=y
CONFIG_GENERIC_LIB_CMPDI2=y
CONFIG_GENERIC_LIB_UCMPDI2=y
CONFIG_POLYNOMIAL=y

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
# CONFIG_SYMBOLIC_ERRNAME is not set
# end of printk and dmesg options

CONFIG_DEBUG_KERNEL=y
# CONFIG_DEBUG_MISC is not set

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
# CONFIG_DEBUG_INFO_NONE is not set
# CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is not set
CONFIG_DEBUG_INFO_DWARF4=y
# CONFIG_DEBUG_INFO_DWARF5 is not set
CONFIG_DEBUG_INFO_REDUCED=y
# CONFIG_DEBUG_INFO_COMPRESSED is not set
# CONFIG_DEBUG_INFO_SPLIT is not set
CONFIG_PAHOLE_HAS_SPLIT_BTF=y
# CONFIG_GDB_SCRIPTS is not set
CONFIG_FRAME_WARN=2048
CONFIG_STRIP_ASM_SYMS=y
CONFIG_READABLE_ASM=y
CONFIG_HEADERS_INSTALL=y
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
# CONFIG_VMLINUX_MAP is not set
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# end of Compile-time checks and compiler options

#
# Generic Kernel Debugging Instruments
#
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
# CONFIG_MAGIC_SYSRQ_SERIAL is not set
CONFIG_DEBUG_FS=y
# CONFIG_DEBUG_FS_ALLOW_ALL is not set
# CONFIG_DEBUG_FS_DISALLOW_MOUNT is not set
CONFIG_DEBUG_FS_ALLOW_NONE=y
CONFIG_UBSAN=y
CONFIG_CC_HAS_UBSAN_BOUNDS=y
CONFIG_UBSAN_BOUNDS=y
CONFIG_UBSAN_ONLY_BOUNDS=y
# CONFIG_UBSAN_SHIFT is not set
# CONFIG_UBSAN_DIV_ZERO is not set
CONFIG_UBSAN_UNREACHABLE=y
# CONFIG_UBSAN_BOOL is not set
CONFIG_UBSAN_ENUM=y
CONFIG_HAVE_KCSAN_COMPILER=y
# end of Generic Kernel Debugging Instruments

#
# Networking Debugging
#
# CONFIG_NET_DEV_REFCNT_TRACKER is not set
# CONFIG_NET_NS_REFCNT_TRACKER is not set
# end of Networking Debugging

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
CONFIG_DEBUG_PAGEALLOC=y
CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT=y
CONFIG_SLUB_DEBUG=y
# CONFIG_SLUB_DEBUG_ON is not set
CONFIG_PAGE_OWNER=y
CONFIG_PAGE_POISONING=y
CONFIG_DEBUG_PAGE_REF=y
# CONFIG_DEBUG_OBJECTS is not set
CONFIG_DEBUG_STACK_USAGE=y
CONFIG_SCHED_STACK_END_CHECK=y
# CONFIG_DEBUG_VM is not set
CONFIG_DEBUG_MEMORY_INIT=y
CONFIG_DEBUG_PER_CPU_MAPS=y
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
CONFIG_DEBUG_STACKOVERFLOW=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
# end of Memory Debugging

CONFIG_DEBUG_SHIRQ=y

#
# Debug Oops, Lockups and Hangs
#
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
# CONFIG_DETECT_HUNG_TASK is not set
# CONFIG_WQ_WATCHDOG is not set
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
# CONFIG_SCHED_DEBUG is not set
# CONFIG_SCHEDSTATS is not set
# end of Scheduler Debugging

CONFIG_DEBUG_TIMEKEEPING=y
CONFIG_DEBUG_PREEMPT=y

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
CONFIG_PROVE_LOCKING=y
# CONFIG_PROVE_RAW_LOCK_NESTING is not set
# CONFIG_LOCK_STAT is not set
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
CONFIG_DEBUG_RWSEMS=y
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_LOCKDEP=y
CONFIG_LOCKDEP_BITS=15
CONFIG_LOCKDEP_CHAINS_BITS=16
CONFIG_LOCKDEP_STACK_TRACE_BITS=19
CONFIG_LOCKDEP_STACK_TRACE_HASH_BITS=14
CONFIG_LOCKDEP_CIRCULAR_QUEUE_BITS=12
CONFIG_DEBUG_LOCKDEP=y
# CONFIG_DEBUG_ATOMIC_SLEEP is not set
CONFIG_DEBUG_LOCKING_API_SELFTESTS=y
CONFIG_LOCK_TORTURE_TEST=y
# CONFIG_WW_MUTEX_SELFTEST is not set
CONFIG_SCF_TORTURE_TEST=y
# CONFIG_CSD_LOCK_WAIT_DEBUG is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_TRACE_IRQFLAGS=y
CONFIG_DEBUG_IRQFLAGS=y
CONFIG_STACKTRACE=y
CONFIG_WARN_ALL_UNSEEDED_RANDOM=y
# CONFIG_DEBUG_KOBJECT is not set

#
# Debug kernel data structures
#
CONFIG_DEBUG_LIST=y
CONFIG_DEBUG_PLIST=y
CONFIG_DEBUG_SG=y
# CONFIG_DEBUG_NOTIFIERS is not set
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
# end of Debug kernel data structures

CONFIG_DEBUG_CREDENTIALS=y

#
# RCU Debugging
#
CONFIG_PROVE_RCU=y
# CONFIG_PROVE_RCU_LIST is not set
CONFIG_TORTURE_TEST=y
CONFIG_RCU_SCALE_TEST=y
# CONFIG_RCU_TORTURE_TEST is not set
CONFIG_RCU_REF_SCALE_TEST=y
CONFIG_RCU_CPU_STALL_TIMEOUT=21
CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=0
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

CONFIG_DEBUG_WQ_FORCE_RR_CPU=y
CONFIG_CPU_HOTPLUG_STATE_CONTROL=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_RING_BUFFER_ALLOW_SWAP=y
CONFIG_PREEMPTIRQ_TRACEPOINTS=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
CONFIG_BOOTTIME_TRACING=y
CONFIG_TRACE_PREEMPT_TOGGLE=y
# CONFIG_IRQSOFF_TRACER is not set
CONFIG_PREEMPT_TRACER=y
# CONFIG_SCHED_TRACER is not set
CONFIG_HWLAT_TRACER=y
CONFIG_OSNOISE_TRACER=y
CONFIG_TIMERLAT_TRACER=y
# CONFIG_FTRACE_SYSCALLS is not set
CONFIG_TRACER_SNAPSHOT=y
CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP=y
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
# CONFIG_PROFILE_ALL_BRANCHES is not set
CONFIG_BLK_DEV_IO_TRACE=y
CONFIG_DYNAMIC_EVENTS=y
# CONFIG_SYNTH_EVENTS is not set
CONFIG_USER_EVENTS=y
CONFIG_TRACE_EVENT_INJECT=y
# CONFIG_TRACEPOINT_BENCHMARK is not set
CONFIG_RING_BUFFER_BENCHMARK=y
CONFIG_TRACE_EVAL_MAP_FILE=y
# CONFIG_GCOV_PROFILE_FTRACE is not set
CONFIG_FTRACE_SELFTEST=y
CONFIG_FTRACE_STARTUP_TEST=y
CONFIG_EVENT_TRACE_STARTUP_TEST=y
# CONFIG_EVENT_TRACE_TEST_SYSCALLS is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS is not set
# CONFIG_SAMPLES is not set

#
# loongarch Debugging
#
CONFIG_UNWINDER_GUESS=y
# CONFIG_UNWINDER_PROLOGUE is not set
# end of loongarch Debugging

#
# Kernel Testing and Coverage
#
CONFIG_KUNIT=y
CONFIG_KUNIT_DEBUGFS=y
CONFIG_KUNIT_TEST=y
CONFIG_KUNIT_EXAMPLE_TEST=y
CONFIG_KUNIT_ALL_TESTS=y
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
# CONFIG_FAULT_INJECTION is not set
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_RUNTIME_TESTING_MENU is not set
# end of Kernel Testing and Coverage

CONFIG_WARN_MISSING_DOCUMENTS=y
# CONFIG_WARN_ABI_ERRORS is not set
# end of Kernel hacking

--Pm1R2lLfXX49/sKk--
