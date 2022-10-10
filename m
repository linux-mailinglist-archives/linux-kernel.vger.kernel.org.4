Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F21A95F9E55
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 14:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbiJJMGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 08:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231731AbiJJMG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 08:06:28 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA19165642
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 05:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1665403567; x=1696939567;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IxRzl8wZoy2AZOn2+9pIS5+UIJn467efM/s30gFvEXY=;
  b=VHr7uAyob03HEmn8ml1Zia2vOmhajhIyOgifSnsYNOqBOSBqm5/u0/i+
   k+/iIXbl92jB5pzZ255PFF+KSkYsJXuCYrcavRHcMXYVRJbyxLeCbd7kV
   i0bIoYRMcVqsuMkuz0nh1d6+qcBsT+0Wvy9dRp0GyT1nkcRo1S0zPjVVB
   7mTG069HCwUKy1q79eXG1YrpP1zLRxAfsaawBMiwujtAJIX+E0E51qPv7
   hcEdQwoDOdJfaHMnltA72KIR91xf7JXvQFXd1M8096H3U/1f8IdyzlakP
   l/rf9MB2jtgWNcEKyIPIUAhyhiMneA8taPfnNj4yU5DOO4uO1p65/7baa
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="184023541"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Oct 2022 05:06:06 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 10 Oct 2022 05:06:02 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Mon, 10 Oct 2022 05:06:01 -0700
Date:   Mon, 10 Oct 2022 13:05:39 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     kernel test robot <lkp@intel.com>
CC:     Jens Axboe <axboe@kernel.dk>, <kbuild-all@lists.01.org>,
        <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Jason A. Donenfeld" <zx2c4@kernel.org>
Subject: Re: [linux-stable-rc:linux-4.19.y 3113/3976]
 drivers/char/random.c:1336: Error: unrecognized opcode `csrs sstatus,s4'
Message-ID: <Y0QKkwQ5KGT9ngPL@wendy>
References: <202210101947.iPda3BwQ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <202210101947.iPda3BwQ-lkp@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,UPPERCASE_50_75 autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2022 at 07:51:59PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> head:   5644b22533b36dc1a95ab1db4ae83381514b2908
> commit: 1923d9a8a08684c063da049fa9d5d8139edbbcbb [3113/3976] random: convert to using fops->write_iter()
> config: riscv-randconfig-c024-20221009
> compiler: riscv64-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=1923d9a8a08684c063da049fa9d5d8139edbbcbb
>         git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
>         git fetch --no-tags linux-stable-rc linux-4.19.y
>         git checkout 1923d9a8a08684c063da049fa9d5d8139edbbcbb
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/char/
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    arch/riscv/include/asm/irqflags.h: Assembler messages:
>    arch/riscv/include/asm/irqflags.h:42: Error: unrecognized opcode `csrrc s6,sstatus,2'
>    arch/riscv/include/asm/irqflags.h:60: Error: unrecognized opcode `csrs sstatus,0'
>    arch/riscv/include/asm/irqflags.h:60: Error: unrecognized opcode `csrs sstatus,s6'
>    drivers/char/random.c:1316: Error: unrecognized opcode `csrs sstatus,a3'
>    drivers/char/random.c:1316: Error: unrecognized opcode `csrc sstatus,a3'
>    drivers/char/random.c:1322: Error: unrecognized opcode `csrs sstatus,a3'
>    drivers/char/random.c:1322: Error: unrecognized opcode `csrc sstatus,a3'
> >> drivers/char/random.c:1336: Error: unrecognized opcode `csrs sstatus,s4'
> >> drivers/char/random.c:1336: Error: unrecognized opcode `csrc sstatus,s4'

All of these look like 4.19.y is missing a backport of:
Fixes: 6df2a016c0c8 ("riscv: fix build with binutils 2.38")

That commit is CC: stable, so I assume it did not apply or w/e and
nobody cared enough to do a backport?

>    drivers/char/random.c:1340: Error: unrecognized opcode `csrs sstatus,s4'
>    drivers/char/random.c:1340: Error: unrecognized opcode `csrc sstatus,s4'
>    arch/riscv/include/asm/irqflags.h:36: Error: unrecognized opcode `csrc sstatus,2'
>    arch/riscv/include/asm/irqflags.h:30: Error: unrecognized opcode `csrs sstatus,2'
>    arch/riscv/include/asm/irqflags.h:30: Error: unrecognized opcode `csrs sstatus,2'
>    arch/riscv/include/asm/irqflags.h:42: Error: unrecognized opcode `csrrc s1,sstatus,2'
>    arch/riscv/include/asm/irqflags.h:60: Error: unrecognized opcode `csrs sstatus,0'
>    arch/riscv/include/asm/irqflags.h:60: Error: unrecognized opcode `csrs sstatus,s1'
>    arch/riscv/include/asm/irqflags.h:42: Error: unrecognized opcode `csrrc s1,sstatus,2'
>    arch/riscv/include/asm/irqflags.h:60: Error: unrecognized opcode `csrs sstatus,0'
>    arch/riscv/include/asm/irqflags.h:60: Error: unrecognized opcode `csrs sstatus,s1'
> 
> 
> vim +1336 drivers/char/random.c
> 
> 0d35cc7b3fec62 Jason A. Donenfeld 2022-02-11  1307  
> 43ae4860ff4a35 Matt Mackall       2008-04-29  1308  static long random_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  1309  {
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  1310  	int __user *p = (int __user *)arg;
> 1923d9a8a08684 Jens Axboe         2022-05-19  1311  	int ent_count;
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  1312  
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  1313  	switch (cmd) {
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  1314  	case RNDGETENTCNT:
> 0d35cc7b3fec62 Jason A. Donenfeld 2022-02-11  1315  		/* Inherently racy, no point locking. */
> 85b46e0c80a637 Jason A. Donenfeld 2022-04-30  1316  		if (put_user(input_pool.init_bits, p))
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  1317  			return -EFAULT;
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  1318  		return 0;
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  1319  	case RNDADDTOENTCNT:
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  1320  		if (!capable(CAP_SYS_ADMIN))
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  1321  			return -EPERM;
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  1322  		if (get_user(ent_count, p))
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  1323  			return -EFAULT;
> cead215ea9fdb5 Jason A. Donenfeld 2022-02-04  1324  		if (ent_count < 0)
> cead215ea9fdb5 Jason A. Donenfeld 2022-02-04  1325  			return -EINVAL;
> 85b46e0c80a637 Jason A. Donenfeld 2022-04-30  1326  		credit_init_bits(ent_count);
> cead215ea9fdb5 Jason A. Donenfeld 2022-02-04  1327  		return 0;
> 1923d9a8a08684 Jens Axboe         2022-05-19  1328  	case RNDADDENTROPY: {
> 1923d9a8a08684 Jens Axboe         2022-05-19  1329  		struct iov_iter iter;
> 1923d9a8a08684 Jens Axboe         2022-05-19  1330  		struct iovec iov;
> 1923d9a8a08684 Jens Axboe         2022-05-19  1331  		ssize_t ret;
> 1923d9a8a08684 Jens Axboe         2022-05-19  1332  		int len;
> 1923d9a8a08684 Jens Axboe         2022-05-19  1333  
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  1334  		if (!capable(CAP_SYS_ADMIN))
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  1335  			return -EPERM;
> ^1da177e4c3f41 Linus Torvalds     2005-04-16 @1336  		if (get_user(ent_count, p++))
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  1337  			return -EFAULT;
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  1338  		if (ent_count < 0)
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  1339  			return -EINVAL;
> 1923d9a8a08684 Jens Axboe         2022-05-19  1340  		if (get_user(len, p++))
> 1923d9a8a08684 Jens Axboe         2022-05-19  1341  			return -EFAULT;
> 1923d9a8a08684 Jens Axboe         2022-05-19  1342  		ret = import_single_range(WRITE, p, len, &iov, &iter);
> 1923d9a8a08684 Jens Axboe         2022-05-19  1343  		if (unlikely(ret))
> 1923d9a8a08684 Jens Axboe         2022-05-19  1344  			return ret;
> 1923d9a8a08684 Jens Axboe         2022-05-19  1345  		ret = write_pool(&iter);
> 1923d9a8a08684 Jens Axboe         2022-05-19  1346  		if (unlikely(ret < 0))
> 1923d9a8a08684 Jens Axboe         2022-05-19  1347  			return ret;
> 1923d9a8a08684 Jens Axboe         2022-05-19  1348  		/* Since we're crediting, enforce that it was all written into the pool. */
> 1923d9a8a08684 Jens Axboe         2022-05-19  1349  		if (unlikely(ret != len))
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  1350  			return -EFAULT;
> 85b46e0c80a637 Jason A. Donenfeld 2022-04-30  1351  		credit_init_bits(ent_count);
> cead215ea9fdb5 Jason A. Donenfeld 2022-02-04  1352  		return 0;
> 1923d9a8a08684 Jens Axboe         2022-05-19  1353  	}
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  1354  	case RNDZAPENTCNT:
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  1355  	case RNDCLEARPOOL:
> 85b46e0c80a637 Jason A. Donenfeld 2022-04-30  1356  		/* No longer has any effect. */
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  1357  		if (!capable(CAP_SYS_ADMIN))
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  1358  			return -EPERM;
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  1359  		return 0;
> d848e5f8e1ebdb Theodore Ts'o      2018-04-11  1360  	case RNDRESEEDCRNG:
> d848e5f8e1ebdb Theodore Ts'o      2018-04-11  1361  		if (!capable(CAP_SYS_ADMIN))
> d848e5f8e1ebdb Theodore Ts'o      2018-04-11  1362  			return -EPERM;
> 13ffd431ae1032 Jason A. Donenfeld 2022-03-08  1363  		if (!crng_ready())
> d848e5f8e1ebdb Theodore Ts'o      2018-04-11  1364  			return -ENODATA;
> e2fc165d51e9e3 Jason A. Donenfeld 2022-02-08  1365  		crng_reseed();
> d848e5f8e1ebdb Theodore Ts'o      2018-04-11  1366  		return 0;
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  1367  	default:
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  1368  		return -EINVAL;
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  1369  	}
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  1370  }
> ^1da177e4c3f41 Linus Torvalds     2005-04-16  1371  
> 
> :::::: The code at line 1336 was first introduced by commit
> :::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2
> 
> :::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
> :::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://01.org/lkp

> #
> # Automatically generated file; DO NOT EDIT.
> # Linux/riscv 4.19.248 Kernel Configuration
> #
> 
> #
> # Compiler: riscv64-linux-gcc (GCC) 12.1.0
> #
> CONFIG_CC_IS_GCC=y
> CONFIG_GCC_VERSION=120100
> CONFIG_CLANG_VERSION=0
> CONFIG_CC_HAS_ASM_GOTO=y
> CONFIG_IRQ_WORK=y
> CONFIG_THREAD_INFO_IN_TASK=y
> 
> #
> # General setup
> #
> CONFIG_INIT_ENV_ARG_LIMIT=32
> CONFIG_COMPILE_TEST=y
> CONFIG_LOCALVERSION=""
> CONFIG_BUILD_SALT=""
> CONFIG_DEFAULT_HOSTNAME="(none)"
> CONFIG_SYSVIPC=y
> CONFIG_SYSVIPC_SYSCTL=y
> # CONFIG_POSIX_MQUEUE is not set
> CONFIG_CROSS_MEMORY_ATTACH=y
> CONFIG_USELIB=y
> CONFIG_AUDIT=y
> 
> #
> # IRQ subsystem
> #
> CONFIG_GENERIC_IRQ_SHOW=y
> CONFIG_IRQ_DOMAIN=y
> CONFIG_IRQ_SIM=y
> CONFIG_SPARSE_IRQ=y
> # CONFIG_GENERIC_IRQ_DEBUGFS is not set
> CONFIG_GENERIC_IRQ_MULTI_HANDLER=y
> CONFIG_GENERIC_CLOCKEVENTS=y
> 
> #
> # Timers subsystem
> #
> CONFIG_TICK_ONESHOT=y
> CONFIG_HZ_PERIODIC=y
> # CONFIG_NO_HZ_IDLE is not set
> # CONFIG_NO_HZ is not set
> CONFIG_HIGH_RES_TIMERS=y
> # CONFIG_PREEMPT_NONE is not set
> CONFIG_PREEMPT_VOLUNTARY=y
> # CONFIG_PREEMPT is not set
> CONFIG_PREEMPT_COUNT=y
> 
> #
> # CPU/Task time and stats accounting
> #
> CONFIG_TICK_CPU_ACCOUNTING=y
> CONFIG_CPU_ISOLATION=y
> 
> #
> # RCU Subsystem
> #
> CONFIG_TREE_RCU=y
> # CONFIG_RCU_EXPERT is not set
> CONFIG_SRCU=y
> CONFIG_TREE_SRCU=y
> CONFIG_TASKS_RCU=y
> CONFIG_RCU_STALL_COMMON=y
> CONFIG_RCU_NEED_SEGCBLIST=y
> CONFIG_BUILD_BIN2C=y
> CONFIG_IKCONFIG=y
> # CONFIG_IKCONFIG_PROC is not set
> CONFIG_LOG_BUF_SHIFT=17
> CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
> CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
> CONFIG_CGROUPS=y
> # CONFIG_MEMCG is not set
> CONFIG_CGROUP_SCHED=y
> CONFIG_FAIR_GROUP_SCHED=y
> CONFIG_CFS_BANDWIDTH=y
> # CONFIG_RT_GROUP_SCHED is not set
> CONFIG_CGROUP_PIDS=y
> CONFIG_CGROUP_RDMA=y
> # CONFIG_CGROUP_FREEZER is not set
> CONFIG_CPUSETS=y
> CONFIG_PROC_PID_CPUSET=y
> # CONFIG_CGROUP_DEVICE is not set
> # CONFIG_CGROUP_CPUACCT is not set
> # CONFIG_CGROUP_DEBUG is not set
> # CONFIG_CHECKPOINT_RESTORE is not set
> CONFIG_SCHED_AUTOGROUP=y
> CONFIG_SYSFS_DEPRECATED=y
> CONFIG_SYSFS_DEPRECATED_V2=y
> CONFIG_RELAY=y
> # CONFIG_BLK_DEV_INITRD is not set
> CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
> # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
> CONFIG_SYSCTL=y
> CONFIG_ANON_INODES=y
> CONFIG_SYSCTL_EXCEPTION_TRACE=y
> CONFIG_BPF=y
> CONFIG_EXPERT=y
> # CONFIG_MULTIUSER is not set
> # CONFIG_SGETMASK_SYSCALL is not set
> # CONFIG_SYSFS_SYSCALL is not set
> # CONFIG_SYSCTL_SYSCALL is not set
> # CONFIG_FHANDLE is not set
> # CONFIG_POSIX_TIMERS is not set
> CONFIG_PRINTK=y
> # CONFIG_BUG is not set
> CONFIG_BASE_FULL=y
> CONFIG_FUTEX=y
> CONFIG_FUTEX_PI=y
> CONFIG_EPOLL=y
> CONFIG_SIGNALFD=y
> CONFIG_TIMERFD=y
> CONFIG_EVENTFD=y
> CONFIG_SHMEM=y
> # CONFIG_AIO is not set
> # CONFIG_ADVISE_SYSCALLS is not set
> # CONFIG_MEMBARRIER is not set
> CONFIG_KALLSYMS=y
> CONFIG_KALLSYMS_ALL=y
> CONFIG_KALLSYMS_BASE_RELATIVE=y
> # CONFIG_BPF_SYSCALL is not set
> # CONFIG_USERFAULTFD is not set
> CONFIG_EMBEDDED=y
> CONFIG_HAVE_PERF_EVENTS=y
> CONFIG_PC104=y
> 
> #
> # Kernel Performance Events And Counters
> #
> # CONFIG_PERF_EVENTS is not set
> CONFIG_VM_EVENT_COUNTERS=y
> # CONFIG_SLUB_DEBUG is not set
> # CONFIG_COMPAT_BRK is not set
> # CONFIG_SLAB is not set
> CONFIG_SLUB=y
> # CONFIG_SLOB is not set
> CONFIG_SLAB_MERGE_DEFAULT=y
> CONFIG_SLAB_FREELIST_RANDOM=y
> CONFIG_SLAB_FREELIST_HARDENED=y
> CONFIG_SLUB_CPU_PARTIAL=y
> CONFIG_PROFILING=y
> CONFIG_TRACEPOINTS=y
> CONFIG_64BIT=y
> CONFIG_RISCV=y
> CONFIG_MMU=y
> CONFIG_ZONE_DMA32=y
> CONFIG_PAGE_OFFSET=0xffffffff80000000
> CONFIG_STACKTRACE_SUPPORT=y
> CONFIG_TRACE_IRQFLAGS_SUPPORT=y
> CONFIG_RWSEM_GENERIC_SPINLOCK=y
> CONFIG_GENERIC_CALIBRATE_DELAY=y
> CONFIG_GENERIC_CSUM=y
> CONFIG_GENERIC_HWEIGHT=y
> CONFIG_PGTABLE_LEVELS=3
> 
> #
> # Platform type
> #
> # CONFIG_ARCH_RV32I is not set
> CONFIG_ARCH_RV64I=y
> CONFIG_CMODEL_MEDLOW=y
> # CONFIG_CMODEL_MEDANY is not set
> CONFIG_MAXPHYSMEM_2GB=y
> CONFIG_SMP=y
> CONFIG_NR_CPUS=8
> CONFIG_TUNE_GENERIC=y
> # CONFIG_RISCV_ISA_C is not set
> CONFIG_RISCV_ISA_A=y
> 
> #
> # Kernel type
> #
> CONFIG_HZ_100=y
> # CONFIG_HZ_250 is not set
> # CONFIG_HZ_300 is not set
> # CONFIG_HZ_1000 is not set
> CONFIG_HZ=100
> CONFIG_SCHED_HRTICK=y
> 
> #
> # Bus support
> #
> # CONFIG_PCI is not set
> 
> #
> # PCI Endpoint
> #
> # CONFIG_PCI_ENDPOINT is not set
> 
> #
> # Power management options
> #
> # CONFIG_PM is not set
> 
> #
> # General architecture-dependent options
> #
> CONFIG_HAVE_64BIT_ALIGNED_ACCESS=y
> CONFIG_HAVE_ARCH_TRACEHOOK=y
> CONFIG_HAVE_DMA_CONTIGUOUS=y
> CONFIG_GENERIC_SMP_IDLE_THREAD=y
> CONFIG_HAVE_CLK=y
> CONFIG_CC_HAS_STACKPROTECTOR_NONE=y
> CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
> CONFIG_CLONE_BACKWARDS=y
> # CONFIG_REFCOUNT_FULL is not set
> 
> #
> # GCOV-based kernel profiling
> #
> # CONFIG_GCOV_KERNEL is not set
> CONFIG_PLUGIN_HOSTCC=""
> CONFIG_RT_MUTEXES=y
> CONFIG_BASE_SMALL=0
> # CONFIG_MODULES is not set
> CONFIG_MODULES_TREE_LOOKUP=y
> # CONFIG_BLOCK is not set
> CONFIG_ASN1=y
> CONFIG_UNINLINE_SPIN_UNLOCK=y
> 
> #
> # Executable file formats
> #
> CONFIG_BINFMT_ELF=y
> CONFIG_ELFCORE=y
> # CONFIG_BINFMT_SCRIPT is not set
> CONFIG_BINFMT_MISC=y
> # CONFIG_COREDUMP is not set
> 
> #
> # Memory Management options
> #
> CONFIG_FLATMEM=y
> CONFIG_FLAT_NODE_MEM_MAP=y
> CONFIG_HAVE_MEMBLOCK=y
> CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
> CONFIG_NO_BOOTMEM=y
> CONFIG_SPLIT_PTLOCK_CPUS=4
> CONFIG_MEMORY_BALLOON=y
> CONFIG_BALLOON_COMPACTION=y
> CONFIG_COMPACTION=y
> CONFIG_MIGRATION=y
> CONFIG_PHYS_ADDR_T_64BIT=y
> # CONFIG_KSM is not set
> CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
> # CONFIG_CLEANCACHE is not set
> # CONFIG_CMA is not set
> # CONFIG_ZPOOL is not set
> # CONFIG_ZBUD is not set
> # CONFIG_ZSMALLOC is not set
> # CONFIG_IDLE_PAGE_TRACKING is not set
> # CONFIG_PERCPU_STATS is not set
> # CONFIG_GUP_BENCHMARK is not set
> CONFIG_ARCH_HAS_PTE_SPECIAL=y
> CONFIG_NET=y
> 
> #
> # Networking options
> #
> CONFIG_PACKET=y
> CONFIG_PACKET_DIAG=y
> CONFIG_UNIX=y
> CONFIG_UNIX_SCM=y
> CONFIG_UNIX_DIAG=y
> CONFIG_TLS=y
> CONFIG_TLS_DEVICE=y
> CONFIG_XFRM=y
> CONFIG_XFRM_OFFLOAD=y
> CONFIG_XFRM_ALGO=y
> # CONFIG_XFRM_USER is not set
> # CONFIG_XFRM_INTERFACE is not set
> # CONFIG_XFRM_SUB_POLICY is not set
> CONFIG_XFRM_MIGRATE=y
> CONFIG_XFRM_STATISTICS=y
> CONFIG_XFRM_IPCOMP=y
> # CONFIG_NET_KEY is not set
> CONFIG_INET=y
> CONFIG_IP_MULTICAST=y
> CONFIG_IP_ADVANCED_ROUTER=y
> # CONFIG_IP_FIB_TRIE_STATS is not set
> CONFIG_IP_MULTIPLE_TABLES=y
> CONFIG_IP_ROUTE_MULTIPATH=y
> CONFIG_IP_ROUTE_VERBOSE=y
> CONFIG_IP_PNP=y
> CONFIG_IP_PNP_DHCP=y
> CONFIG_IP_PNP_BOOTP=y
> CONFIG_IP_PNP_RARP=y
> CONFIG_NET_IPIP=y
> CONFIG_NET_IPGRE_DEMUX=y
> CONFIG_NET_IP_TUNNEL=y
> CONFIG_NET_IPGRE=y
> # CONFIG_NET_IPGRE_BROADCAST is not set
> CONFIG_IP_MROUTE_COMMON=y
> CONFIG_IP_MROUTE=y
> CONFIG_IP_MROUTE_MULTIPLE_TABLES=y
> CONFIG_IP_PIMSM_V1=y
> # CONFIG_IP_PIMSM_V2 is not set
> # CONFIG_SYN_COOKIES is not set
> # CONFIG_NET_IPVTI is not set
> CONFIG_NET_UDP_TUNNEL=y
> # CONFIG_NET_FOU is not set
> # CONFIG_NET_FOU_IP_TUNNELS is not set
> CONFIG_INET_AH=y
> CONFIG_INET_ESP=y
> CONFIG_INET_ESP_OFFLOAD=y
> # CONFIG_INET_IPCOMP is not set
> CONFIG_INET_TUNNEL=y
> CONFIG_INET_XFRM_MODE_TRANSPORT=y
> CONFIG_INET_XFRM_MODE_TUNNEL=y
> CONFIG_INET_XFRM_MODE_BEET=y
> # CONFIG_INET_DIAG is not set
> # CONFIG_TCP_CONG_ADVANCED is not set
> CONFIG_TCP_CONG_CUBIC=y
> CONFIG_DEFAULT_TCP_CONG="cubic"
> # CONFIG_TCP_MD5SIG is not set
> CONFIG_IPV6=y
> # CONFIG_IPV6_ROUTER_PREF is not set
> # CONFIG_IPV6_OPTIMISTIC_DAD is not set
> # CONFIG_INET6_AH is not set
> # CONFIG_INET6_ESP is not set
> CONFIG_INET6_IPCOMP=y
> CONFIG_IPV6_MIP6=y
> CONFIG_INET6_XFRM_TUNNEL=y
> CONFIG_INET6_TUNNEL=y
> CONFIG_INET6_XFRM_MODE_TRANSPORT=y
> CONFIG_INET6_XFRM_MODE_TUNNEL=y
> CONFIG_INET6_XFRM_MODE_BEET=y
> # CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION is not set
> CONFIG_IPV6_VTI=y
> # CONFIG_IPV6_SIT is not set
> CONFIG_IPV6_TUNNEL=y
> CONFIG_IPV6_GRE=y
> CONFIG_IPV6_MULTIPLE_TABLES=y
> # CONFIG_IPV6_SUBTREES is not set
> CONFIG_IPV6_MROUTE=y
> CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
> # CONFIG_IPV6_PIMSM_V2 is not set
> # CONFIG_IPV6_SEG6_LWTUNNEL is not set
> CONFIG_IPV6_SEG6_HMAC=y
> # CONFIG_NETWORK_SECMARK is not set
> CONFIG_NET_PTP_CLASSIFY=y
> CONFIG_NETWORK_PHY_TIMESTAMPING=y
> # CONFIG_NETFILTER is not set
> # CONFIG_BPFILTER is not set
> CONFIG_IP_DCCP=y
> 
> #
> # DCCP CCIDs Configuration
> #
> CONFIG_IP_DCCP_CCID2_DEBUG=y
> # CONFIG_IP_DCCP_CCID3 is not set
> 
> #
> # DCCP Kernel Hacking
> #
> # CONFIG_IP_DCCP_DEBUG is not set
> CONFIG_IP_SCTP=y
> CONFIG_SCTP_DBG_OBJCNT=y
> # CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5 is not set
> # CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1 is not set
> CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE=y
> CONFIG_SCTP_COOKIE_HMAC_MD5=y
> # CONFIG_SCTP_COOKIE_HMAC_SHA1 is not set
> CONFIG_RDS=y
> # CONFIG_RDS_TCP is not set
> CONFIG_RDS_DEBUG=y
> CONFIG_TIPC=y
> CONFIG_TIPC_MEDIA_UDP=y
> CONFIG_TIPC_DIAG=y
> CONFIG_ATM=y
> CONFIG_ATM_CLIP=y
> CONFIG_ATM_CLIP_NO_ICMP=y
> CONFIG_ATM_LANE=y
> CONFIG_ATM_MPOA=y
> CONFIG_ATM_BR2684=y
> CONFIG_ATM_BR2684_IPFILTER=y
> CONFIG_L2TP=y
> # CONFIG_L2TP_DEBUGFS is not set
> CONFIG_L2TP_V3=y
> CONFIG_L2TP_IP=y
> CONFIG_L2TP_ETH=y
> CONFIG_STP=y
> CONFIG_BRIDGE=y
> # CONFIG_BRIDGE_IGMP_SNOOPING is not set
> CONFIG_HAVE_NET_DSA=y
> # CONFIG_NET_DSA is not set
> # CONFIG_VLAN_8021Q is not set
> CONFIG_DECNET=y
> CONFIG_DECNET_ROUTER=y
> CONFIG_LLC=y
> CONFIG_LLC2=y
> CONFIG_ATALK=y
> CONFIG_DEV_APPLETALK=y
> CONFIG_IPDDP=y
> CONFIG_IPDDP_ENCAP=y
> # CONFIG_X25 is not set
> CONFIG_LAPB=y
> CONFIG_PHONET=y
> CONFIG_6LOWPAN=y
> # CONFIG_6LOWPAN_DEBUGFS is not set
> # CONFIG_6LOWPAN_NHC is not set
> CONFIG_IEEE802154=y
> # CONFIG_IEEE802154_NL802154_EXPERIMENTAL is not set
> CONFIG_IEEE802154_SOCKET=y
> # CONFIG_IEEE802154_6LOWPAN is not set
> CONFIG_MAC802154=y
> # CONFIG_NET_SCHED is not set
> CONFIG_DCB=y
> # CONFIG_DNS_RESOLVER is not set
> CONFIG_BATMAN_ADV=y
> # CONFIG_BATMAN_ADV_BATMAN_V is not set
> CONFIG_BATMAN_ADV_BLA=y
> CONFIG_BATMAN_ADV_DAT=y
> # CONFIG_BATMAN_ADV_NC is not set
> CONFIG_BATMAN_ADV_MCAST=y
> # CONFIG_BATMAN_ADV_DEBUGFS is not set
> # CONFIG_OPENVSWITCH is not set
> # CONFIG_VSOCKETS is not set
> # CONFIG_NETLINK_DIAG is not set
> # CONFIG_MPLS is not set
> CONFIG_NET_NSH=y
> CONFIG_HSR=y
> # CONFIG_NET_SWITCHDEV is not set
> # CONFIG_NET_L3_MASTER_DEV is not set
> CONFIG_QRTR=y
> # CONFIG_QRTR_SMD is not set
> # CONFIG_QRTR_TUN is not set
> CONFIG_NET_NCSI=y
> CONFIG_RPS=y
> CONFIG_RFS_ACCEL=y
> CONFIG_XPS=y
> # CONFIG_CGROUP_NET_PRIO is not set
> # CONFIG_CGROUP_NET_CLASSID is not set
> CONFIG_NET_RX_BUSY_POLL=y
> CONFIG_BQL=y
> CONFIG_NET_FLOW_LIMIT=y
> 
> #
> # Network testing
> #
> # CONFIG_NET_PKTGEN is not set
> CONFIG_NET_DROP_MONITOR=y
> CONFIG_HAMRADIO=y
> 
> #
> # Packet Radio protocols
> #
> # CONFIG_AX25 is not set
> # CONFIG_CAN is not set
> CONFIG_BT=y
> # CONFIG_BT_BREDR is not set
> # CONFIG_BT_LE is not set
> CONFIG_BT_LEDS=y
> # CONFIG_BT_SELFTEST is not set
> # CONFIG_BT_DEBUGFS is not set
> 
> #
> # Bluetooth device drivers
> #
> CONFIG_BT_INTEL=y
> CONFIG_BT_BCM=y
> CONFIG_BT_RTL=y
> CONFIG_BT_HCIBTUSB=y
> CONFIG_BT_HCIBTUSB_AUTOSUSPEND=y
> CONFIG_BT_HCIBTUSB_BCM=y
> CONFIG_BT_HCIBTUSB_RTL=y
> # CONFIG_BT_HCIBTSDIO is not set
> CONFIG_BT_HCIBCM203X=y
> CONFIG_BT_HCIBPA10X=y
> CONFIG_BT_HCIBFUSB=y
> # CONFIG_BT_HCIVHCI is not set
> CONFIG_BT_MRVL=y
> CONFIG_BT_MRVL_SDIO=y
> CONFIG_BT_ATH3K=y
> CONFIG_BT_MTKUART=y
> # CONFIG_BT_QCOMSMD is not set
> CONFIG_AF_RXRPC=y
> CONFIG_AF_RXRPC_IPV6=y
> CONFIG_AF_RXRPC_INJECT_LOSS=y
> CONFIG_AF_RXRPC_DEBUG=y
> CONFIG_RXKAD=y
> # CONFIG_AF_KCM is not set
> CONFIG_STREAM_PARSER=y
> CONFIG_FIB_RULES=y
> CONFIG_WIRELESS=y
> # CONFIG_CFG80211 is not set
> 
> #
> # CFG80211 needs to be enabled for MAC80211
> #
> CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
> # CONFIG_WIMAX is not set
> # CONFIG_RFKILL is not set
> # CONFIG_NET_9P is not set
> CONFIG_CAIF=y
> # CONFIG_CAIF_DEBUG is not set
> # CONFIG_CAIF_NETDEV is not set
> CONFIG_CAIF_USB=y
> # CONFIG_CEPH_LIB is not set
> # CONFIG_NFC is not set
> CONFIG_PSAMPLE=y
> CONFIG_NET_IFE=y
> CONFIG_LWTUNNEL=y
> # CONFIG_LWTUNNEL_BPF is not set
> CONFIG_DST_CACHE=y
> CONFIG_GRO_CELLS=y
> CONFIG_SOCK_VALIDATE_XMIT=y
> CONFIG_NET_DEVLINK=y
> CONFIG_MAY_USE_DEVLINK=y
> CONFIG_FAILOVER=y
> 
> #
> # Device Drivers
> #
> 
> #
> # Generic Driver Options
> #
> # CONFIG_UEVENT_HELPER is not set
> CONFIG_DEVTMPFS=y
> # CONFIG_DEVTMPFS_MOUNT is not set
> # CONFIG_STANDALONE is not set
> # CONFIG_PREVENT_FIRMWARE_BUILD is not set
> 
> #
> # Firmware loader
> #
> CONFIG_FW_LOADER=y
> CONFIG_EXTRA_FIRMWARE=""
> # CONFIG_FW_LOADER_USER_HELPER is not set
> CONFIG_WANT_DEV_COREDUMP=y
> # CONFIG_ALLOW_DEV_COREDUMP is not set
> # CONFIG_DEBUG_DRIVER is not set
> CONFIG_DEBUG_DEVRES=y
> CONFIG_DEBUG_TEST_DRIVER_REMOVE=y
> CONFIG_GENERIC_CPU_DEVICES=y
> CONFIG_REGMAP=y
> CONFIG_REGMAP_I2C=y
> CONFIG_REGMAP_SPI=y
> CONFIG_REGMAP_SPMI=y
> CONFIG_REGMAP_MMIO=y
> CONFIG_REGMAP_IRQ=y
> CONFIG_DMA_SHARED_BUFFER=y
> CONFIG_DMA_FENCE_TRACE=y
> 
> #
> # Bus devices
> #
> # CONFIG_QCOM_EBI2 is not set
> CONFIG_CONNECTOR=y
> CONFIG_PROC_EVENTS=y
> CONFIG_GNSS=y
> CONFIG_GNSS_SERIAL=y
> CONFIG_GNSS_SIRF_SERIAL=y
> CONFIG_GNSS_UBX_SERIAL=y
> CONFIG_MTD=y
> CONFIG_MTD_REDBOOT_PARTS=y
> CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=-1
> # CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED is not set
> CONFIG_MTD_REDBOOT_PARTS_READONLY=y
> # CONFIG_MTD_CMDLINE_PARTS is not set
> CONFIG_MTD_OF_PARTS=y
> CONFIG_MTD_AR7_PARTS=y
> # CONFIG_MTD_BCM63XX_PARTS is not set
> 
> #
> # Partition parsers
> #
> # CONFIG_MTD_PARSER_TRX is not set
> # CONFIG_MTD_SHARPSL_PARTS is not set
> 
> #
> # User Modules And Translation Layers
> #
> CONFIG_MTD_OOPS=y
> # CONFIG_MTD_PARTITIONED_MASTER is not set
> 
> #
> # RAM/ROM/Flash chip drivers
> #
> # CONFIG_MTD_CFI is not set
> CONFIG_MTD_JEDECPROBE=y
> CONFIG_MTD_GEN_PROBE=y
> CONFIG_MTD_CFI_ADV_OPTIONS=y
> # CONFIG_MTD_CFI_NOSWAP is not set
> # CONFIG_MTD_CFI_BE_BYTE_SWAP is not set
> CONFIG_MTD_CFI_LE_BYTE_SWAP=y
> # CONFIG_MTD_CFI_GEOMETRY is not set
> CONFIG_MTD_MAP_BANK_WIDTH_1=y
> CONFIG_MTD_MAP_BANK_WIDTH_2=y
> CONFIG_MTD_MAP_BANK_WIDTH_4=y
> CONFIG_MTD_CFI_I1=y
> CONFIG_MTD_CFI_I2=y
> CONFIG_MTD_OTP=y
> CONFIG_MTD_CFI_INTELEXT=y
> CONFIG_MTD_CFI_AMDSTD=y
> # CONFIG_MTD_CFI_STAA is not set
> CONFIG_MTD_CFI_UTIL=y
> CONFIG_MTD_RAM=y
> CONFIG_MTD_ROM=y
> CONFIG_MTD_ABSENT=y
> 
> #
> # Mapping drivers for chip access
> #
> # CONFIG_MTD_COMPLEX_MAPPINGS is not set
> # CONFIG_MTD_PHYSMAP is not set
> # CONFIG_MTD_PHYSMAP_OF is not set
> # CONFIG_MTD_TS5500 is not set
> CONFIG_MTD_PLATRAM=y
> 
> #
> # Self-contained MTD device drivers
> #
> # CONFIG_MTD_DATAFLASH is not set
> CONFIG_MTD_MCHP23K256=y
> # CONFIG_MTD_SST25L is not set
> CONFIG_MTD_SLRAM=y
> CONFIG_MTD_PHRAM=y
> CONFIG_MTD_MTDRAM=y
> CONFIG_MTDRAM_TOTAL_SIZE=4096
> CONFIG_MTDRAM_ERASE_SIZE=128
> 
> #
> # Disk-On-Chip Device Drivers
> #
> # CONFIG_MTD_DOCG3 is not set
> CONFIG_MTD_NAND_CORE=y
> CONFIG_MTD_ONENAND=y
> # CONFIG_MTD_ONENAND_VERIFY_WRITE is not set
> CONFIG_MTD_ONENAND_GENERIC=y
> # CONFIG_MTD_ONENAND_OTP is not set
> CONFIG_MTD_ONENAND_2X_PROGRAM=y
> # CONFIG_MTD_NAND is not set
> CONFIG_MTD_SPI_NAND=y
> 
> #
> # LPDDR & LPDDR2 PCM memory drivers
> #
> CONFIG_MTD_LPDDR=y
> CONFIG_MTD_QINFO_PROBE=y
> # CONFIG_MTD_SPI_NOR is not set
> CONFIG_MTD_UBI=y
> CONFIG_MTD_UBI_WL_THRESHOLD=4096
> CONFIG_MTD_UBI_BEB_LIMIT=20
> # CONFIG_MTD_UBI_FASTMAP is not set
> CONFIG_MTD_UBI_GLUEBI=y
> CONFIG_DTC=y
> CONFIG_OF=y
> CONFIG_OF_UNITTEST=y
> # CONFIG_OF_ALL_DTBS is not set
> CONFIG_OF_FLATTREE=y
> CONFIG_OF_EARLY_FLATTREE=y
> CONFIG_OF_KOBJ=y
> CONFIG_OF_DYNAMIC=y
> CONFIG_OF_ADDRESS=y
> CONFIG_OF_IRQ=y
> CONFIG_OF_NET=y
> CONFIG_OF_MDIO=y
> CONFIG_OF_RESOLVE=y
> # CONFIG_OF_OVERLAY is not set
> CONFIG_PARPORT=y
> CONFIG_PARPORT_AX88796=y
> # CONFIG_PARPORT_1284 is not set
> CONFIG_PARPORT_NOT_PC=y
> 
> #
> # NVME Support
> #
> 
> #
> # Misc devices
> #
> CONFIG_SENSORS_LIS3LV02D=y
> # CONFIG_AD525X_DPOT is not set
> CONFIG_DUMMY_IRQ=y
> # CONFIG_ICS932S401 is not set
> # CONFIG_ATMEL_SSC is not set
> CONFIG_ENCLOSURE_SERVICES=y
> # CONFIG_QCOM_COINCELL is not set
> CONFIG_APDS9802ALS=y
> CONFIG_ISL29003=y
> CONFIG_ISL29020=y
> # CONFIG_SENSORS_TSL2550 is not set
> CONFIG_SENSORS_BH1770=y
> CONFIG_SENSORS_APDS990X=y
> CONFIG_HMC6352=y
> CONFIG_DS1682=y
> # CONFIG_USB_SWITCH_FSA9480 is not set
> CONFIG_LATTICE_ECP3_CONFIG=y
> # CONFIG_SRAM is not set
> # CONFIG_ASPEED_LPC_CTRL is not set
> # CONFIG_ASPEED_LPC_SNOOP is not set
> CONFIG_MISC_RTSX=y
> # CONFIG_C2PORT is not set
> 
> #
> # EEPROM support
> #
> CONFIG_EEPROM_AT24=y
> CONFIG_EEPROM_AT25=y
> CONFIG_EEPROM_LEGACY=y
> CONFIG_EEPROM_MAX6875=y
> CONFIG_EEPROM_93CX6=y
> # CONFIG_EEPROM_93XX46 is not set
> CONFIG_EEPROM_IDT_89HPESX=y
> 
> #
> # Texas Instruments shared transport line discipline
> #
> # CONFIG_SENSORS_LIS3_SPI is not set
> CONFIG_SENSORS_LIS3_I2C=y
> # CONFIG_ALTERA_STAPL is not set
> 
> #
> # Intel MIC & related support
> #
> 
> #
> # Intel MIC Bus Driver
> #
> 
> #
> # SCIF Bus Driver
> #
> 
> #
> # VOP Bus Driver
> #
> 
> #
> # Intel MIC Host Driver
> #
> 
> #
> # Intel MIC Card Driver
> #
> 
> #
> # SCIF Driver
> #
> 
> #
> # Intel MIC Coprocessor State Management (COSM) Drivers
> #
> 
> #
> # VOP Driver
> #
> CONFIG_VHOST_RING=y
> CONFIG_ECHO=y
> CONFIG_MISC_RTSX_USB=y
> 
> #
> # SCSI device support
> #
> CONFIG_SCSI_MOD=y
> 
> #
> # IEEE 1394 (FireWire) support
> #
> # CONFIG_FIREWIRE is not set
> CONFIG_NETDEVICES=y
> # CONFIG_NET_CORE is not set
> # CONFIG_ATM_DRIVERS is not set
> 
> #
> # CAIF transport drivers
> #
> # CONFIG_CAIF_SPI_SLAVE is not set
> # CONFIG_CAIF_HSI is not set
> CONFIG_CAIF_VIRTIO=y
> 
> #
> # Distributed Switch Architecture drivers
> #
> # CONFIG_ETHERNET is not set
> CONFIG_MDIO_DEVICE=y
> CONFIG_MDIO_BUS=y
> # CONFIG_MDIO_BCM_IPROC is not set
> CONFIG_MDIO_BCM_UNIMAC=y
> CONFIG_MDIO_BITBANG=y
> CONFIG_MDIO_BUS_MUX=y
> # CONFIG_MDIO_BUS_MUX_BCM_IPROC is not set
> # CONFIG_MDIO_BUS_MUX_GPIO is not set
> CONFIG_MDIO_BUS_MUX_MMIOREG=y
> CONFIG_MDIO_CAVIUM=y
> # CONFIG_MDIO_GPIO is not set
> # CONFIG_MDIO_HISI_FEMAC is not set
> # CONFIG_MDIO_MOXART is not set
> # CONFIG_MDIO_MSCC_MIIM is not set
> CONFIG_MDIO_OCTEON=y
> # CONFIG_MDIO_SUN4I is not set
> # CONFIG_MDIO_XGENE is not set
> CONFIG_PHYLIB=y
> CONFIG_SWPHY=y
> CONFIG_LED_TRIGGER_PHY=y
> 
> #
> # MII PHY device drivers
> #
> CONFIG_AMD_PHY=y
> CONFIG_AQUANTIA_PHY=y
> CONFIG_AX88796B_PHY=y
> CONFIG_AT803X_PHY=y
> # CONFIG_BCM7XXX_PHY is not set
> CONFIG_BCM87XX_PHY=y
> CONFIG_BCM_NET_PHYLIB=y
> CONFIG_BROADCOM_PHY=y
> CONFIG_CICADA_PHY=y
> CONFIG_CORTINA_PHY=y
> # CONFIG_DAVICOM_PHY is not set
> CONFIG_DP83822_PHY=y
> CONFIG_DP83TC811_PHY=y
> CONFIG_DP83848_PHY=y
> CONFIG_DP83867_PHY=y
> CONFIG_FIXED_PHY=y
> CONFIG_ICPLUS_PHY=y
> CONFIG_INTEL_XWAY_PHY=y
> CONFIG_LSI_ET1011C_PHY=y
> # CONFIG_LXT_PHY is not set
> CONFIG_MARVELL_PHY=y
> CONFIG_MARVELL_10G_PHY=y
> # CONFIG_MESON_GXL_PHY is not set
> CONFIG_MICREL_PHY=y
> CONFIG_MICROCHIP_PHY=y
> CONFIG_MICROCHIP_T1_PHY=y
> # CONFIG_MICROSEMI_PHY is not set
> CONFIG_NATIONAL_PHY=y
> # CONFIG_QSEMI_PHY is not set
> CONFIG_REALTEK_PHY=y
> CONFIG_RENESAS_PHY=y
> CONFIG_ROCKCHIP_PHY=y
> CONFIG_SMSC_PHY=y
> CONFIG_STE10XP=y
> CONFIG_TERANETICS_PHY=y
> # CONFIG_VITESSE_PHY is not set
> CONFIG_XILINX_GMII2RGMII=y
> CONFIG_MICREL_KS8995MA=y
> CONFIG_PLIP=y
> # CONFIG_PPP is not set
> # CONFIG_USB_NET_DRIVERS is not set
> CONFIG_WLAN=y
> # CONFIG_WIRELESS_WDS is not set
> # CONFIG_WLAN_VENDOR_ADMTEK is not set
> CONFIG_WLAN_VENDOR_ATH=y
> CONFIG_ATH_DEBUG=y
> CONFIG_ATH_TRACEPOINTS=y
> # CONFIG_WLAN_VENDOR_ATMEL is not set
> CONFIG_WLAN_VENDOR_BROADCOM=y
> # CONFIG_WLAN_VENDOR_CISCO is not set
> # CONFIG_WLAN_VENDOR_INTEL is not set
> # CONFIG_WLAN_VENDOR_INTERSIL is not set
> CONFIG_WLAN_VENDOR_MARVELL=y
> # CONFIG_WLAN_VENDOR_MEDIATEK is not set
> # CONFIG_WLAN_VENDOR_RALINK is not set
> CONFIG_WLAN_VENDOR_REALTEK=y
> # CONFIG_WLAN_VENDOR_RSI is not set
> # CONFIG_WLAN_VENDOR_ST is not set
> # CONFIG_WLAN_VENDOR_TI is not set
> CONFIG_WLAN_VENDOR_ZYDAS=y
> # CONFIG_WLAN_VENDOR_QUANTENNA is not set
> 
> #
> # Enable WiMAX (Networking options) to see the WiMAX drivers
> #
> CONFIG_WAN=y
> # CONFIG_HDLC is not set
> # CONFIG_SLIC_DS26522 is not set
> # CONFIG_DLCI is not set
> CONFIG_IEEE802154_DRIVERS=y
> # CONFIG_IEEE802154_FAKELB is not set
> CONFIG_IEEE802154_AT86RF230=y
> # CONFIG_IEEE802154_AT86RF230_DEBUGFS is not set
> CONFIG_IEEE802154_MRF24J40=y
> # CONFIG_IEEE802154_CC2520 is not set
> CONFIG_IEEE802154_ATUSB=y
> CONFIG_IEEE802154_ADF7242=y
> CONFIG_IEEE802154_CA8210=y
> CONFIG_IEEE802154_CA8210_DEBUGFS=y
> CONFIG_IEEE802154_MCR20A=y
> CONFIG_IEEE802154_HWSIM=y
> CONFIG_NETDEVSIM=y
> CONFIG_NET_FAILOVER=y
> CONFIG_ISDN=y
> CONFIG_ISDN_CAPI=y
> CONFIG_CAPI_TRACE=y
> # CONFIG_ISDN_CAPI_CAPI20 is not set
> 
> #
> # CAPI hardware drivers
> #
> # CONFIG_CAPI_AVM is not set
> # CONFIG_CAPI_EICON is not set
> CONFIG_MISDN=y
> CONFIG_MISDN_DSP=y
> # CONFIG_MISDN_L1OIP is not set
> 
> #
> # mISDN hardware drivers
> #
> CONFIG_MISDN_HFCUSB=y
> 
> #
> # Input device support
> #
> CONFIG_INPUT=y
> # CONFIG_INPUT_LEDS is not set
> CONFIG_INPUT_FF_MEMLESS=y
> CONFIG_INPUT_POLLDEV=y
> CONFIG_INPUT_SPARSEKMAP=y
> CONFIG_INPUT_MATRIXKMAP=y
> 
> #
> # Userland interfaces
> #
> CONFIG_INPUT_MOUSEDEV=y
> CONFIG_INPUT_MOUSEDEV_PSAUX=y
> CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
> CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
> CONFIG_INPUT_JOYDEV=y
> CONFIG_INPUT_EVDEV=y
> CONFIG_INPUT_EVBUG=y
> 
> #
> # Input Device Drivers
> #
> CONFIG_INPUT_KEYBOARD=y
> CONFIG_KEYBOARD_ADC=y
> CONFIG_KEYBOARD_ADP5588=y
> # CONFIG_KEYBOARD_ADP5589 is not set
> # CONFIG_KEYBOARD_ATKBD is not set
> CONFIG_KEYBOARD_QT1070=y
> CONFIG_KEYBOARD_QT2160=y
> # CONFIG_KEYBOARD_CLPS711X is not set
> CONFIG_KEYBOARD_DLINK_DIR685=y
> CONFIG_KEYBOARD_LKKBD=y
> CONFIG_KEYBOARD_GPIO=y
> CONFIG_KEYBOARD_GPIO_POLLED=y
> CONFIG_KEYBOARD_TCA6416=y
> # CONFIG_KEYBOARD_TCA8418 is not set
> # CONFIG_KEYBOARD_MATRIX is not set
> CONFIG_KEYBOARD_LM8323=y
> CONFIG_KEYBOARD_LM8333=y
> CONFIG_KEYBOARD_MAX7359=y
> CONFIG_KEYBOARD_MCS=y
> CONFIG_KEYBOARD_MPR121=y
> # CONFIG_KEYBOARD_NEWTON is not set
> CONFIG_KEYBOARD_OPENCORES=y
> # CONFIG_KEYBOARD_SAMSUNG is not set
> # CONFIG_KEYBOARD_GOLDFISH_EVENTS is not set
> # CONFIG_KEYBOARD_STOWAWAY is not set
> # CONFIG_KEYBOARD_ST_KEYSCAN is not set
> CONFIG_KEYBOARD_SUNKBD=y
> # CONFIG_KEYBOARD_SH_KEYSC is not set
> # CONFIG_KEYBOARD_STMPE is not set
> CONFIG_KEYBOARD_OMAP4=y
> CONFIG_KEYBOARD_TC3589X=y
> CONFIG_KEYBOARD_TM2_TOUCHKEY=y
> # CONFIG_KEYBOARD_XTKBD is not set
> CONFIG_KEYBOARD_CAP11XX=y
> CONFIG_KEYBOARD_BCM=y
> CONFIG_INPUT_MOUSE=y
> CONFIG_MOUSE_PS2=y
> # CONFIG_MOUSE_PS2_ALPS is not set
> CONFIG_MOUSE_PS2_BYD=y
> CONFIG_MOUSE_PS2_LOGIPS2PP=y
> # CONFIG_MOUSE_PS2_SYNAPTICS is not set
> # CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS is not set
> # CONFIG_MOUSE_PS2_CYPRESS is not set
> CONFIG_MOUSE_PS2_TRACKPOINT=y
> CONFIG_MOUSE_PS2_ELANTECH=y
> CONFIG_MOUSE_PS2_ELANTECH_SMBUS=y
> # CONFIG_MOUSE_PS2_SENTELIC is not set
> CONFIG_MOUSE_PS2_TOUCHKIT=y
> # CONFIG_MOUSE_PS2_FOCALTECH is not set
> CONFIG_MOUSE_PS2_SMBUS=y
> CONFIG_MOUSE_SERIAL=y
> CONFIG_MOUSE_APPLETOUCH=y
> # CONFIG_MOUSE_BCM5974 is not set
> CONFIG_MOUSE_CYAPA=y
> CONFIG_MOUSE_ELAN_I2C=y
> # CONFIG_MOUSE_ELAN_I2C_I2C is not set
> CONFIG_MOUSE_ELAN_I2C_SMBUS=y
> CONFIG_MOUSE_VSXXXAA=y
> CONFIG_MOUSE_GPIO=y
> CONFIG_MOUSE_SYNAPTICS_I2C=y
> CONFIG_MOUSE_SYNAPTICS_USB=y
> # CONFIG_INPUT_JOYSTICK is not set
> # CONFIG_INPUT_TABLET is not set
> CONFIG_INPUT_TOUCHSCREEN=y
> CONFIG_TOUCHSCREEN_PROPERTIES=y
> CONFIG_TOUCHSCREEN_ADS7846=y
> # CONFIG_TOUCHSCREEN_AD7877 is not set
> # CONFIG_TOUCHSCREEN_AD7879 is not set
> # CONFIG_TOUCHSCREEN_ADC is not set
> CONFIG_TOUCHSCREEN_AR1021_I2C=y
> CONFIG_TOUCHSCREEN_ATMEL_MXT=y
> # CONFIG_TOUCHSCREEN_AUO_PIXCIR is not set
> CONFIG_TOUCHSCREEN_BU21013=y
> # CONFIG_TOUCHSCREEN_BU21029 is not set
> # CONFIG_TOUCHSCREEN_CHIPONE_ICN8318 is not set
> CONFIG_TOUCHSCREEN_CY8CTMG110=y
> CONFIG_TOUCHSCREEN_CYTTSP_CORE=y
> CONFIG_TOUCHSCREEN_CYTTSP_I2C=y
> CONFIG_TOUCHSCREEN_CYTTSP_SPI=y
> CONFIG_TOUCHSCREEN_CYTTSP4_CORE=y
> # CONFIG_TOUCHSCREEN_CYTTSP4_I2C is not set
> CONFIG_TOUCHSCREEN_CYTTSP4_SPI=y
> CONFIG_TOUCHSCREEN_DA9034=y
> # CONFIG_TOUCHSCREEN_DA9052 is not set
> CONFIG_TOUCHSCREEN_DYNAPRO=y
> CONFIG_TOUCHSCREEN_HAMPSHIRE=y
> # CONFIG_TOUCHSCREEN_EETI is not set
> CONFIG_TOUCHSCREEN_EGALAX=y
> # CONFIG_TOUCHSCREEN_EGALAX_SERIAL is not set
> CONFIG_TOUCHSCREEN_EXC3000=y
> CONFIG_TOUCHSCREEN_FUJITSU=y
> # CONFIG_TOUCHSCREEN_GOODIX is not set
> CONFIG_TOUCHSCREEN_HIDEEP=y
> # CONFIG_TOUCHSCREEN_ILI210X is not set
> # CONFIG_TOUCHSCREEN_IPROC is not set
> CONFIG_TOUCHSCREEN_S6SY761=y
> CONFIG_TOUCHSCREEN_GUNZE=y
> CONFIG_TOUCHSCREEN_EKTF2127=y
> CONFIG_TOUCHSCREEN_ELAN=y
> CONFIG_TOUCHSCREEN_ELO=y
> # CONFIG_TOUCHSCREEN_WACOM_W8001 is not set
> # CONFIG_TOUCHSCREEN_WACOM_I2C is not set
> # CONFIG_TOUCHSCREEN_MAX11801 is not set
> CONFIG_TOUCHSCREEN_MCS5000=y
> # CONFIG_TOUCHSCREEN_MMS114 is not set
> # CONFIG_TOUCHSCREEN_MELFAS_MIP4 is not set
> # CONFIG_TOUCHSCREEN_MTOUCH is not set
> CONFIG_TOUCHSCREEN_IMX6UL_TSC=y
> CONFIG_TOUCHSCREEN_INEXIO=y
> CONFIG_TOUCHSCREEN_MK712=y
> CONFIG_TOUCHSCREEN_PENMOUNT=y
> CONFIG_TOUCHSCREEN_EDT_FT5X06=y
> # CONFIG_TOUCHSCREEN_MIGOR is not set
> # CONFIG_TOUCHSCREEN_TOUCHRIGHT is not set
> CONFIG_TOUCHSCREEN_TOUCHWIN=y
> CONFIG_TOUCHSCREEN_PIXCIR=y
> CONFIG_TOUCHSCREEN_WDT87XX_I2C=y
> CONFIG_TOUCHSCREEN_WM831X=y
> CONFIG_TOUCHSCREEN_USB_COMPOSITE=y
> # CONFIG_TOUCHSCREEN_MC13783 is not set
> # CONFIG_TOUCHSCREEN_USB_EGALAX is not set
> # CONFIG_TOUCHSCREEN_USB_PANJIT is not set
> CONFIG_TOUCHSCREEN_USB_3M=y
> CONFIG_TOUCHSCREEN_USB_ITM=y
> # CONFIG_TOUCHSCREEN_USB_ETURBO is not set
> # CONFIG_TOUCHSCREEN_USB_GUNZE is not set
> CONFIG_TOUCHSCREEN_USB_DMC_TSC10=y
> CONFIG_TOUCHSCREEN_USB_IRTOUCH=y
> CONFIG_TOUCHSCREEN_USB_IDEALTEK=y
> # CONFIG_TOUCHSCREEN_USB_GENERAL_TOUCH is not set
> CONFIG_TOUCHSCREEN_USB_GOTOP=y
> CONFIG_TOUCHSCREEN_USB_JASTEC=y
> CONFIG_TOUCHSCREEN_USB_ELO=y
> # CONFIG_TOUCHSCREEN_USB_E2I is not set
> CONFIG_TOUCHSCREEN_USB_ZYTRONIC=y
> # CONFIG_TOUCHSCREEN_USB_ETT_TC45USB is not set
> CONFIG_TOUCHSCREEN_USB_NEXIO=y
> CONFIG_TOUCHSCREEN_USB_EASYTOUCH=y
> CONFIG_TOUCHSCREEN_TOUCHIT213=y
> # CONFIG_TOUCHSCREEN_TS4800 is not set
> # CONFIG_TOUCHSCREEN_TSC_SERIO is not set
> CONFIG_TOUCHSCREEN_TSC200X_CORE=y
> CONFIG_TOUCHSCREEN_TSC2004=y
> CONFIG_TOUCHSCREEN_TSC2005=y
> CONFIG_TOUCHSCREEN_TSC2007=y
> CONFIG_TOUCHSCREEN_TSC2007_IIO=y
> # CONFIG_TOUCHSCREEN_PCAP is not set
> CONFIG_TOUCHSCREEN_RM_TS=y
> # CONFIG_TOUCHSCREEN_SILEAD is not set
> CONFIG_TOUCHSCREEN_SIS_I2C=y
> CONFIG_TOUCHSCREEN_ST1232=y
> # CONFIG_TOUCHSCREEN_STMFTS is not set
> CONFIG_TOUCHSCREEN_STMPE=y
> # CONFIG_TOUCHSCREEN_SUN4I is not set
> # CONFIG_TOUCHSCREEN_SURFACE3_SPI is not set
> CONFIG_TOUCHSCREEN_SX8654=y
> # CONFIG_TOUCHSCREEN_TPS6507X is not set
> # CONFIG_TOUCHSCREEN_ZET6223 is not set
> # CONFIG_TOUCHSCREEN_ZFORCE is not set
> CONFIG_TOUCHSCREEN_COLIBRI_VF50=y
> CONFIG_TOUCHSCREEN_ROHM_BU21023=y
> # CONFIG_INPUT_MISC is not set
> CONFIG_RMI4_CORE=y
> CONFIG_RMI4_I2C=y
> CONFIG_RMI4_SPI=y
> CONFIG_RMI4_SMB=y
> CONFIG_RMI4_F03=y
> CONFIG_RMI4_F03_SERIO=y
> CONFIG_RMI4_2D_SENSOR=y
> CONFIG_RMI4_F11=y
> CONFIG_RMI4_F12=y
> CONFIG_RMI4_F30=y
> # CONFIG_RMI4_F34 is not set
> CONFIG_RMI4_F55=y
> 
> #
> # Hardware I/O ports
> #
> CONFIG_SERIO=y
> # CONFIG_SERIO_PARKBD is not set
> CONFIG_SERIO_LIBPS2=y
> # CONFIG_SERIO_RAW is not set
> CONFIG_SERIO_ALTERA_PS2=y
> # CONFIG_SERIO_PS2MULT is not set
> # CONFIG_SERIO_ARC_PS2 is not set
> CONFIG_SERIO_APBPS2=y
> # CONFIG_SERIO_OLPC_APSP is not set
> # CONFIG_SERIO_SUN4I_PS2 is not set
> CONFIG_SERIO_GPIO_PS2=y
> # CONFIG_USERIO is not set
> CONFIG_GAMEPORT=y
> # CONFIG_GAMEPORT_NS558 is not set
> CONFIG_GAMEPORT_L4=y
> 
> #
> # Character devices
> #
> # CONFIG_TTY is not set
> # CONFIG_DEVMEM is not set
> # CONFIG_DEVKMEM is not set
> CONFIG_SERIAL_DEV_BUS=y
> CONFIG_PRINTER=y
> # CONFIG_LP_CONSOLE is not set
> CONFIG_PPDEV=y
> CONFIG_IPMI_HANDLER=y
> CONFIG_IPMI_PANIC_EVENT=y
> # CONFIG_IPMI_PANIC_STRING is not set
> CONFIG_IPMI_DEVICE_INTERFACE=y
> CONFIG_IPMI_SI=y
> CONFIG_IPMI_SSIF=y
> # CONFIG_IPMI_WATCHDOG is not set
> CONFIG_IPMI_POWEROFF=y
> # CONFIG_ASPEED_KCS_IPMI_BMC is not set
> # CONFIG_NPCM7XX_KCS_IPMI_BMC is not set
> # CONFIG_ASPEED_BT_IPMI_BMC is not set
> CONFIG_HW_RANDOM=y
> # CONFIG_HW_RANDOM_TIMERIOMEM is not set
> CONFIG_HW_RANDOM_VIRTIO=y
> CONFIG_HW_RANDOM_STM32=y
> CONFIG_HW_RANDOM_MESON=y
> CONFIG_HW_RANDOM_MTK=y
> CONFIG_HW_RANDOM_EXYNOS=y
> 
> #
> # PCMCIA character devices
> #
> CONFIG_TCG_TPM=y
> # CONFIG_HW_RANDOM_TPM is not set
> CONFIG_TCG_TIS_CORE=y
> CONFIG_TCG_TIS=y
> CONFIG_TCG_TIS_SPI=y
> # CONFIG_TCG_TIS_I2C_ATMEL is not set
> # CONFIG_TCG_TIS_I2C_INFINEON is not set
> # CONFIG_TCG_TIS_I2C_NUVOTON is not set
> # CONFIG_TCG_ATMEL is not set
> CONFIG_TCG_VTPM_PROXY=y
> CONFIG_TCG_TIS_ST33ZP24=y
> # CONFIG_TCG_TIS_ST33ZP24_I2C is not set
> CONFIG_TCG_TIS_ST33ZP24_SPI=y
> CONFIG_XILLYBUS=y
> # CONFIG_XILLYBUS_OF is not set
> # CONFIG_RANDOM_TRUST_BOOTLOADER is not set
> 
> #
> # I2C support
> #
> CONFIG_I2C=y
> CONFIG_I2C_BOARDINFO=y
> CONFIG_I2C_COMPAT=y
> CONFIG_I2C_CHARDEV=y
> CONFIG_I2C_MUX=y
> 
> #
> # Multiplexer I2C Chip support
> #
> # CONFIG_I2C_ARB_GPIO_CHALLENGE is not set
> CONFIG_I2C_MUX_GPIO=y
> CONFIG_I2C_MUX_GPMUX=y
> CONFIG_I2C_MUX_LTC4306=y
> # CONFIG_I2C_MUX_PCA9541 is not set
> CONFIG_I2C_MUX_PCA954x=y
> # CONFIG_I2C_MUX_PINCTRL is not set
> CONFIG_I2C_MUX_REG=y
> # CONFIG_I2C_DEMUX_PINCTRL is not set
> CONFIG_I2C_MUX_MLXCPLD=y
> # CONFIG_I2C_HELPER_AUTO is not set
> CONFIG_I2C_SMBUS=y
> 
> #
> # I2C Algorithms
> #
> CONFIG_I2C_ALGOBIT=y
> # CONFIG_I2C_ALGOPCF is not set
> CONFIG_I2C_ALGOPCA=y
> 
> #
> # I2C Hardware Bus support
> #
> # CONFIG_I2C_HIX5HD2 is not set
> 
> #
> # I2C system bus drivers (mostly embedded / system-on-chip)
> #
> # CONFIG_I2C_ASPEED is not set
> # CONFIG_I2C_AXXIA is not set
> # CONFIG_I2C_BCM_IPROC is not set
> CONFIG_I2C_BRCMSTB=y
> # CONFIG_I2C_CADENCE is not set
> # CONFIG_I2C_CBUS_GPIO is not set
> # CONFIG_I2C_DESIGNWARE_PLATFORM is not set
> # CONFIG_I2C_EFM32 is not set
> CONFIG_I2C_EMEV2=y
> # CONFIG_I2C_GPIO is not set
> # CONFIG_I2C_IMG is not set
> # CONFIG_I2C_IMX_LPI2C is not set
> # CONFIG_I2C_JZ4780 is not set
> # CONFIG_I2C_LPC2K is not set
> # CONFIG_I2C_MESON is not set
> # CONFIG_I2C_MT65XX is not set
> # CONFIG_I2C_OCORES is not set
> # CONFIG_I2C_OWL is not set
> CONFIG_I2C_PCA_PLATFORM=y
> # CONFIG_I2C_QUP is not set
> # CONFIG_I2C_RIIC is not set
> # CONFIG_I2C_RK3X is not set
> # CONFIG_I2C_SH_MOBILE is not set
> # CONFIG_I2C_SIMTEC is not set
> # CONFIG_I2C_STM32F4 is not set
> # CONFIG_I2C_STM32F7 is not set
> # CONFIG_I2C_SUN6I_P2WI is not set
> # CONFIG_I2C_SYNQUACER is not set
> # CONFIG_I2C_UNIPHIER is not set
> # CONFIG_I2C_UNIPHIER_F is not set
> # CONFIG_I2C_VERSATILE is not set
> CONFIG_I2C_XILINX=y
> # CONFIG_I2C_XLP9XX is not set
> # CONFIG_I2C_RCAR is not set
> 
> #
> # External I2C/SMBus adapter drivers
> #
> # CONFIG_I2C_DIOLAN_U2C is not set
> # CONFIG_I2C_PARPORT is not set
> # CONFIG_I2C_PARPORT_LIGHT is not set
> CONFIG_I2C_ROBOTFUZZ_OSIF=y
> # CONFIG_I2C_TINY_USB is not set
> 
> #
> # Other I2C/SMBus bus drivers
> #
> CONFIG_I2C_FSI=y
> CONFIG_I2C_SLAVE=y
> CONFIG_I2C_SLAVE_EEPROM=y
> CONFIG_I2C_DEBUG_CORE=y
> # CONFIG_I2C_DEBUG_ALGO is not set
> CONFIG_I2C_DEBUG_BUS=y
> CONFIG_SPI=y
> # CONFIG_SPI_DEBUG is not set
> CONFIG_SPI_MASTER=y
> CONFIG_SPI_MEM=y
> 
> #
> # SPI Master Controller Drivers
> #
> CONFIG_SPI_ALTERA=y
> # CONFIG_SPI_ARMADA_3700 is not set
> # CONFIG_SPI_ATMEL is not set
> CONFIG_SPI_AXI_SPI_ENGINE=y
> # CONFIG_SPI_BCM2835 is not set
> # CONFIG_SPI_BCM2835AUX is not set
> # CONFIG_SPI_BCM63XX is not set
> # CONFIG_SPI_BCM63XX_HSSPI is not set
> # CONFIG_SPI_BCM_QSPI is not set
> CONFIG_SPI_BITBANG=y
> # CONFIG_SPI_BUTTERFLY is not set
> # CONFIG_SPI_CADENCE is not set
> # CONFIG_SPI_CLPS711X is not set
> CONFIG_SPI_DESIGNWARE=y
> CONFIG_SPI_DW_MMIO=y
> # CONFIG_SPI_EP93XX is not set
> # CONFIG_SPI_FSL_LPSPI is not set
> CONFIG_SPI_GPIO=y
> # CONFIG_SPI_IMG_SPFI is not set
> # CONFIG_SPI_IMX is not set
> # CONFIG_SPI_JCORE is not set
> CONFIG_SPI_LM70_LLP=y
> # CONFIG_SPI_LP8841_RTC is not set
> # CONFIG_SPI_FSL_SPI is not set
> # CONFIG_SPI_FSL_DSPI is not set
> # CONFIG_SPI_MESON_SPICC is not set
> # CONFIG_SPI_MESON_SPIFC is not set
> # CONFIG_SPI_MT65XX is not set
> # CONFIG_SPI_LANTIQ_SSC is not set
> CONFIG_SPI_OC_TINY=y
> # CONFIG_SPI_OMAP24XX is not set
> # CONFIG_SPI_TI_QSPI is not set
> # CONFIG_SPI_OMAP_100K is not set
> # CONFIG_SPI_ORION is not set
> # CONFIG_SPI_PIC32 is not set
> # CONFIG_SPI_PIC32_SQI is not set
> CONFIG_SPI_ROCKCHIP=y
> # CONFIG_SPI_RSPI is not set
> # CONFIG_SPI_S3C64XX is not set
> CONFIG_SPI_SC18IS602=y
> # CONFIG_SPI_SH_MSIOF is not set
> # CONFIG_SPI_SH is not set
> # CONFIG_SPI_SH_HSPI is not set
> # CONFIG_SPI_SPRD_ADI is not set
> # CONFIG_SPI_STM32 is not set
> # CONFIG_SPI_ST_SSC4 is not set
> # CONFIG_SPI_SUN4I is not set
> # CONFIG_SPI_SUN6I is not set
> # CONFIG_SPI_TEGRA114 is not set
> # CONFIG_SPI_TEGRA20_SFLASH is not set
> # CONFIG_SPI_TEGRA20_SLINK is not set
> # CONFIG_SPI_TXX9 is not set
> # CONFIG_SPI_UNIPHIER is not set
> # CONFIG_SPI_XCOMM is not set
> # CONFIG_SPI_XILINX is not set
> # CONFIG_SPI_XLP is not set
> # CONFIG_SPI_XTENSA_XTFPGA is not set
> CONFIG_SPI_ZYNQMP_GQSPI=y
> 
> #
> # SPI Protocol Masters
> #
> CONFIG_SPI_SPIDEV=y
> # CONFIG_SPI_TLE62X0 is not set
> # CONFIG_SPI_SLAVE is not set
> CONFIG_SPI_DYNAMIC=y
> CONFIG_SPMI=y
> # CONFIG_SPMI_MSM_PMIC_ARB is not set
> # CONFIG_HSI is not set
> CONFIG_PPS=y
> # CONFIG_PPS_DEBUG is not set
> # CONFIG_NTP_PPS is not set
> 
> #
> # PPS clients support
> #
> CONFIG_PPS_CLIENT_KTIMER=y
> # CONFIG_PPS_CLIENT_PARPORT is not set
> # CONFIG_PPS_CLIENT_GPIO is not set
> 
> #
> # PPS generators support
> #
> 
> #
> # PTP clock support
> #
> CONFIG_PINCTRL=y
> CONFIG_GENERIC_PINCTRL_GROUPS=y
> CONFIG_PINMUX=y
> CONFIG_GENERIC_PINMUX_FUNCTIONS=y
> CONFIG_PINCONF=y
> CONFIG_GENERIC_PINCONF=y
> CONFIG_DEBUG_PINCTRL=y
> # CONFIG_PINCTRL_AS3722 is not set
> CONFIG_PINCTRL_AXP209=y
> # CONFIG_PINCTRL_AMD is not set
> # CONFIG_PINCTRL_DA850_PUPD is not set
> # CONFIG_PINCTRL_LPC18XX is not set
> CONFIG_PINCTRL_MCP23S08=y
> # CONFIG_PINCTRL_RZA1 is not set
> CONFIG_PINCTRL_SINGLE=y
> CONFIG_PINCTRL_SX150X=y
> # CONFIG_PINCTRL_MAX77620 is not set
> CONFIG_PINCTRL_INGENIC=y
> # CONFIG_PINCTRL_OCELOT is not set
> # CONFIG_PINCTRL_OWL is not set
> # CONFIG_PINCTRL_ASPEED_G4 is not set
> # CONFIG_PINCTRL_ASPEED_G5 is not set
> # CONFIG_PINCTRL_BCM281XX is not set
> # CONFIG_PINCTRL_IPROC_GPIO is not set
> # CONFIG_PINCTRL_CYGNUS_MUX is not set
> # CONFIG_PINCTRL_NSP_GPIO is not set
> # CONFIG_PINCTRL_NS2_MUX is not set
> # CONFIG_PINCTRL_NSP_MUX is not set
> # CONFIG_PINCTRL_AS370 is not set
> # CONFIG_PINCTRL_BERLIN_BG4CT is not set
> # CONFIG_PINCTRL_PXA25X is not set
> # CONFIG_PINCTRL_PXA27X is not set
> # CONFIG_PINCTRL_APQ8064 is not set
> # CONFIG_PINCTRL_APQ8084 is not set
> # CONFIG_PINCTRL_IPQ4019 is not set
> # CONFIG_PINCTRL_IPQ8064 is not set
> # CONFIG_PINCTRL_IPQ8074 is not set
> # CONFIG_PINCTRL_MSM8660 is not set
> # CONFIG_PINCTRL_MSM8960 is not set
> # CONFIG_PINCTRL_MDM9615 is not set
> # CONFIG_PINCTRL_MSM8X74 is not set
> # CONFIG_PINCTRL_MSM8916 is not set
> # CONFIG_PINCTRL_MSM8994 is not set
> # CONFIG_PINCTRL_MSM8996 is not set
> # CONFIG_PINCTRL_MSM8998 is not set
> # CONFIG_PINCTRL_QCOM_SPMI_PMIC is not set
> # CONFIG_PINCTRL_QCOM_SSBI_PMIC is not set
> # CONFIG_PINCTRL_SDM845 is not set
> # CONFIG_PINCTRL_SPRD is not set
> # CONFIG_PINCTRL_STM32F429 is not set
> # CONFIG_PINCTRL_STM32F469 is not set
> # CONFIG_PINCTRL_STM32F746 is not set
> # CONFIG_PINCTRL_STM32F769 is not set
> # CONFIG_PINCTRL_STM32H743 is not set
> # CONFIG_PINCTRL_STM32MP157 is not set
> # CONFIG_PINCTRL_TI_IODELAY is not set
> CONFIG_PINCTRL_UNIPHIER=y
> # CONFIG_PINCTRL_UNIPHIER_LD4 is not set
> # CONFIG_PINCTRL_UNIPHIER_PRO4 is not set
> # CONFIG_PINCTRL_UNIPHIER_SLD8 is not set
> # CONFIG_PINCTRL_UNIPHIER_PRO5 is not set
> # CONFIG_PINCTRL_UNIPHIER_PXS2 is not set
> # CONFIG_PINCTRL_UNIPHIER_LD6B is not set
> # CONFIG_PINCTRL_UNIPHIER_LD11 is not set
> # CONFIG_PINCTRL_UNIPHIER_LD20 is not set
> # CONFIG_PINCTRL_UNIPHIER_PXS3 is not set
> 
> #
> # MediaTek pinctrl drivers
> #
> # CONFIG_EINT_MTK is not set
> # CONFIG_PINCTRL_MT2701 is not set
> # CONFIG_PINCTRL_MT8135 is not set
> # CONFIG_PINCTRL_MT8127 is not set
> # CONFIG_PINCTRL_MT2712 is not set
> # CONFIG_PINCTRL_MT7622 is not set
> # CONFIG_PINCTRL_MT8173 is not set
> # CONFIG_PINCTRL_MT6397 is not set
> CONFIG_GPIOLIB=y
> CONFIG_GPIOLIB_FASTPATH_LIMIT=512
> CONFIG_OF_GPIO=y
> CONFIG_GPIOLIB_IRQCHIP=y
> # CONFIG_DEBUG_GPIO is not set
> CONFIG_GPIO_SYSFS=y
> CONFIG_GPIO_GENERIC=y
> CONFIG_GPIO_MAX730X=y
> 
> #
> # Memory mapped GPIO drivers
> #
> # CONFIG_GPIO_74XX_MMIO is not set
> CONFIG_GPIO_ALTERA=y
> # CONFIG_GPIO_ASPEED is not set
> # CONFIG_GPIO_ATH79 is not set
> # CONFIG_GPIO_RASPBERRYPI_EXP is not set
> # CONFIG_GPIO_BCM_KONA is not set
> # CONFIG_GPIO_BRCMSTB is not set
> # CONFIG_GPIO_CLPS711X is not set
> # CONFIG_GPIO_DWAPB is not set
> # CONFIG_GPIO_EIC_SPRD is not set
> # CONFIG_GPIO_EM is not set
> CONFIG_GPIO_FTGPIO010=y
> # CONFIG_GPIO_GENERIC_PLATFORM is not set
> # CONFIG_GPIO_GRGPIO is not set
> CONFIG_GPIO_HLWD=y
> # CONFIG_GPIO_INGENIC is not set
> # CONFIG_GPIO_IOP is not set
> # CONFIG_GPIO_LPC18XX is not set
> CONFIG_GPIO_MB86S7X=y
> CONFIG_GPIO_MOCKUP=y
> # CONFIG_GPIO_MPC8XXX is not set
> # CONFIG_GPIO_MT7621 is not set
> # CONFIG_GPIO_PMIC_EIC_SPRD is not set
> # CONFIG_GPIO_RCAR is not set
> # CONFIG_GPIO_SPRD is not set
> CONFIG_GPIO_SYSCON=y
> # CONFIG_GPIO_TEGRA is not set
> # CONFIG_GPIO_TEGRA186 is not set
> # CONFIG_GPIO_TS4800 is not set
> # CONFIG_GPIO_UNIPHIER is not set
> # CONFIG_GPIO_XILINX is not set
> # CONFIG_GPIO_XLP is not set
> # CONFIG_GPIO_ZX is not set
> 
> #
> # I2C GPIO expanders
> #
> # CONFIG_GPIO_ADP5588 is not set
> # CONFIG_GPIO_ADNP is not set
> # CONFIG_GPIO_MAX7300 is not set
> CONFIG_GPIO_MAX732X=y
> CONFIG_GPIO_MAX732X_IRQ=y
> # CONFIG_GPIO_PCA953X is not set
> CONFIG_GPIO_PCF857X=y
> CONFIG_GPIO_TPIC2810=y
> # CONFIG_GPIO_TS4900 is not set
> 
> #
> # MFD GPIO expanders
> #
> CONFIG_GPIO_ARIZONA=y
> # CONFIG_GPIO_BD9571MWV is not set
> CONFIG_GPIO_DA9052=y
> # CONFIG_GPIO_DA9055 is not set
> CONFIG_GPIO_LP87565=y
> # CONFIG_GPIO_MAX77620 is not set
> # CONFIG_GPIO_STMPE is not set
> # CONFIG_GPIO_TC3589X is not set
> CONFIG_GPIO_TPS65086=y
> CONFIG_GPIO_TPS65910=y
> CONFIG_GPIO_TPS65912=y
> CONFIG_GPIO_WM831X=y
> # CONFIG_GPIO_WM8350 is not set
> # CONFIG_GPIO_WM8994 is not set
> 
> #
> # SPI GPIO expanders
> #
> CONFIG_GPIO_74X164=y
> CONFIG_GPIO_MAX3191X=y
> CONFIG_GPIO_MAX7301=y
> # CONFIG_GPIO_MC33880 is not set
> # CONFIG_GPIO_PISOSR is not set
> CONFIG_GPIO_XRA1403=y
> 
> #
> # USB GPIO expanders
> #
> CONFIG_W1=y
> # CONFIG_W1_CON is not set
> 
> #
> # 1-wire Bus Masters
> #
> CONFIG_W1_MASTER_DS2490=y
> CONFIG_W1_MASTER_DS2482=y
> # CONFIG_W1_MASTER_MXC is not set
> CONFIG_W1_MASTER_DS1WM=y
> CONFIG_W1_MASTER_GPIO=y
> 
> #
> # 1-wire Slaves
> #
> CONFIG_W1_SLAVE_THERM=y
> CONFIG_W1_SLAVE_SMEM=y
> CONFIG_W1_SLAVE_DS2405=y
> CONFIG_W1_SLAVE_DS2408=y
> # CONFIG_W1_SLAVE_DS2408_READBACK is not set
> CONFIG_W1_SLAVE_DS2413=y
> CONFIG_W1_SLAVE_DS2406=y
> # CONFIG_W1_SLAVE_DS2423 is not set
> CONFIG_W1_SLAVE_DS2805=y
> # CONFIG_W1_SLAVE_DS2431 is not set
> # CONFIG_W1_SLAVE_DS2433 is not set
> # CONFIG_W1_SLAVE_DS2438 is not set
> CONFIG_W1_SLAVE_DS2780=y
> CONFIG_W1_SLAVE_DS2781=y
> CONFIG_W1_SLAVE_DS28E04=y
> CONFIG_W1_SLAVE_DS28E17=y
> # CONFIG_POWER_AVS is not set
> # CONFIG_POWER_RESET is not set
> CONFIG_POWER_SUPPLY=y
> CONFIG_POWER_SUPPLY_DEBUG=y
> # CONFIG_PDA_POWER is not set
> # CONFIG_GENERIC_ADC_BATTERY is not set
> CONFIG_MAX8925_POWER=y
> # CONFIG_WM831X_BACKUP is not set
> CONFIG_WM831X_POWER=y
> CONFIG_WM8350_POWER=y
> CONFIG_TEST_POWER=y
> # CONFIG_CHARGER_ADP5061 is not set
> CONFIG_BATTERY_ACT8945A=y
> # CONFIG_BATTERY_CPCAP is not set
> CONFIG_BATTERY_DS2760=y
> CONFIG_BATTERY_DS2780=y
> # CONFIG_BATTERY_DS2781 is not set
> # CONFIG_BATTERY_DS2782 is not set
> # CONFIG_BATTERY_LEGO_EV3 is not set
> CONFIG_BATTERY_SBS=y
> CONFIG_CHARGER_SBS=y
> CONFIG_MANAGER_SBS=y
> CONFIG_BATTERY_BQ27XXX=y
> CONFIG_BATTERY_BQ27XXX_I2C=y
> # CONFIG_BATTERY_BQ27XXX_HDQ is not set
> # CONFIG_BATTERY_BQ27XXX_DT_UPDATES_NVM is not set
> CONFIG_BATTERY_DA9030=y
> CONFIG_BATTERY_DA9052=y
> # CONFIG_CHARGER_DA9150 is not set
> CONFIG_BATTERY_DA9150=y
> CONFIG_CHARGER_AXP20X=y
> CONFIG_BATTERY_AXP20X=y
> # CONFIG_AXP20X_POWER is not set
> # CONFIG_AXP288_FUEL_GAUGE is not set
> # CONFIG_BATTERY_MAX17040 is not set
> CONFIG_BATTERY_MAX17042=y
> # CONFIG_BATTERY_MAX1721X is not set
> CONFIG_CHARGER_PCF50633=y
> CONFIG_CHARGER_CPCAP=y
> CONFIG_CHARGER_ISP1704=y
> CONFIG_CHARGER_MAX8903=y
> CONFIG_CHARGER_LP8727=y
> CONFIG_CHARGER_LP8788=y
> # CONFIG_CHARGER_GPIO is not set
> CONFIG_CHARGER_MANAGER=y
> # CONFIG_CHARGER_LTC3651 is not set
> # CONFIG_CHARGER_DETECTOR_MAX14656 is not set
> CONFIG_CHARGER_MAX77693=y
> # CONFIG_CHARGER_MAX8997 is not set
> # CONFIG_CHARGER_QCOM_SMBB is not set
> # CONFIG_CHARGER_BQ2415X is not set
> # CONFIG_CHARGER_BQ24190 is not set
> # CONFIG_CHARGER_BQ24257 is not set
> # CONFIG_CHARGER_BQ24735 is not set
> CONFIG_CHARGER_BQ25890=y
> # CONFIG_CHARGER_SMB347 is not set
> CONFIG_CHARGER_TPS65217=y
> CONFIG_BATTERY_GAUGE_LTC2941=y
> CONFIG_BATTERY_GOLDFISH=y
> CONFIG_BATTERY_RT5033=y
> # CONFIG_CHARGER_RT9455 is not set
> CONFIG_HWMON=y
> CONFIG_HWMON_VID=y
> # CONFIG_HWMON_DEBUG_CHIP is not set
> 
> #
> # Native drivers
> #
> CONFIG_SENSORS_AD7314=y
> CONFIG_SENSORS_AD7414=y
> CONFIG_SENSORS_AD7418=y
> # CONFIG_SENSORS_ADM1021 is not set
> # CONFIG_SENSORS_ADM1025 is not set
> # CONFIG_SENSORS_ADM1026 is not set
> CONFIG_SENSORS_ADM1029=y
> CONFIG_SENSORS_ADM1031=y
> CONFIG_SENSORS_ADM9240=y
> CONFIG_SENSORS_ADT7X10=y
> CONFIG_SENSORS_ADT7310=y
> CONFIG_SENSORS_ADT7410=y
> CONFIG_SENSORS_ADT7411=y
> CONFIG_SENSORS_ADT7462=y
> # CONFIG_SENSORS_ADT7470 is not set
> CONFIG_SENSORS_ADT7475=y
> # CONFIG_SENSORS_ASC7621 is not set
> # CONFIG_SENSORS_ASPEED is not set
> # CONFIG_SENSORS_ATXP1 is not set
> CONFIG_SENSORS_DS620=y
> CONFIG_SENSORS_DS1621=y
> CONFIG_SENSORS_DA9052_ADC=y
> # CONFIG_SENSORS_DA9055 is not set
> CONFIG_SENSORS_F71805F=y
> CONFIG_SENSORS_F71882FG=y
> CONFIG_SENSORS_F75375S=y
> CONFIG_SENSORS_MC13783_ADC=y
> # CONFIG_SENSORS_GL518SM is not set
> CONFIG_SENSORS_GL520SM=y
> CONFIG_SENSORS_G760A=y
> # CONFIG_SENSORS_G762 is not set
> CONFIG_SENSORS_GPIO_FAN=y
> CONFIG_SENSORS_HIH6130=y
> # CONFIG_SENSORS_IBMAEM is not set
> CONFIG_SENSORS_IBMPEX=y
> CONFIG_SENSORS_IIO_HWMON=y
> CONFIG_SENSORS_IT87=y
> # CONFIG_SENSORS_JC42 is not set
> # CONFIG_SENSORS_POWR1220 is not set
> CONFIG_SENSORS_LINEAGE=y
> CONFIG_SENSORS_LTC2945=y
> CONFIG_SENSORS_LTC2990=y
> CONFIG_SENSORS_LTC4151=y
> CONFIG_SENSORS_LTC4215=y
> # CONFIG_SENSORS_LTC4222 is not set
> # CONFIG_SENSORS_LTC4245 is not set
> CONFIG_SENSORS_LTC4260=y
> CONFIG_SENSORS_LTC4261=y
> CONFIG_SENSORS_MAX1111=y
> CONFIG_SENSORS_MAX16065=y
> CONFIG_SENSORS_MAX1619=y
> CONFIG_SENSORS_MAX1668=y
> # CONFIG_SENSORS_MAX197 is not set
> CONFIG_SENSORS_MAX31722=y
> # CONFIG_SENSORS_MAX6621 is not set
> CONFIG_SENSORS_MAX6639=y
> CONFIG_SENSORS_MAX6642=y
> CONFIG_SENSORS_MAX6650=y
> # CONFIG_SENSORS_MAX6697 is not set
> # CONFIG_SENSORS_MAX31790 is not set
> # CONFIG_SENSORS_MCP3021 is not set
> CONFIG_SENSORS_TC654=y
> CONFIG_SENSORS_ADCXX=y
> # CONFIG_SENSORS_LM63 is not set
> # CONFIG_SENSORS_LM70 is not set
> # CONFIG_SENSORS_LM73 is not set
> # CONFIG_SENSORS_LM75 is not set
> # CONFIG_SENSORS_LM77 is not set
> CONFIG_SENSORS_LM78=y
> CONFIG_SENSORS_LM80=y
> CONFIG_SENSORS_LM83=y
> # CONFIG_SENSORS_LM85 is not set
> CONFIG_SENSORS_LM87=y
> # CONFIG_SENSORS_LM90 is not set
> # CONFIG_SENSORS_LM92 is not set
> # CONFIG_SENSORS_LM93 is not set
> CONFIG_SENSORS_LM95234=y
> # CONFIG_SENSORS_LM95241 is not set
> CONFIG_SENSORS_LM95245=y
> # CONFIG_SENSORS_PC87360 is not set
> # CONFIG_SENSORS_PC87427 is not set
> CONFIG_SENSORS_NTC_THERMISTOR=y
> # CONFIG_SENSORS_NCT6683 is not set
> CONFIG_SENSORS_NCT6775=y
> CONFIG_SENSORS_NCT7802=y
> # CONFIG_SENSORS_NCT7904 is not set
> # CONFIG_SENSORS_NPCM7XX is not set
> # CONFIG_SENSORS_NSA320 is not set
> CONFIG_SENSORS_PCF8591=y
> CONFIG_PMBUS=y
> CONFIG_SENSORS_PMBUS=y
> CONFIG_SENSORS_ADM1275=y
> CONFIG_SENSORS_IBM_CFFPS=y
> CONFIG_SENSORS_IR35221=y
> CONFIG_SENSORS_LM25066=y
> CONFIG_SENSORS_LTC2978=y
> CONFIG_SENSORS_LTC2978_REGULATOR=y
> CONFIG_SENSORS_LTC3815=y
> CONFIG_SENSORS_MAX16064=y
> # CONFIG_SENSORS_MAX20751 is not set
> CONFIG_SENSORS_MAX31785=y
> # CONFIG_SENSORS_MAX34440 is not set
> # CONFIG_SENSORS_MAX8688 is not set
> CONFIG_SENSORS_TPS40422=y
> CONFIG_SENSORS_TPS53679=y
> CONFIG_SENSORS_UCD9000=y
> # CONFIG_SENSORS_UCD9200 is not set
> CONFIG_SENSORS_ZL6100=y
> # CONFIG_SENSORS_PWM_FAN is not set
> # CONFIG_SENSORS_RASPBERRYPI_HWMON is not set
> CONFIG_SENSORS_SHT15=y
> CONFIG_SENSORS_SHT21=y
> # CONFIG_SENSORS_SHT3x is not set
> # CONFIG_SENSORS_SHTC1 is not set
> # CONFIG_SENSORS_DME1737 is not set
> CONFIG_SENSORS_EMC1403=y
> CONFIG_SENSORS_EMC2103=y
> CONFIG_SENSORS_EMC6W201=y
> CONFIG_SENSORS_SMSC47M1=y
> CONFIG_SENSORS_SMSC47M192=y
> CONFIG_SENSORS_SMSC47B397=y
> # CONFIG_SENSORS_STTS751 is not set
> # CONFIG_SENSORS_SMM665 is not set
> # CONFIG_SENSORS_ADC128D818 is not set
> # CONFIG_SENSORS_ADS1015 is not set
> CONFIG_SENSORS_ADS7828=y
> CONFIG_SENSORS_ADS7871=y
> # CONFIG_SENSORS_AMC6821 is not set
> CONFIG_SENSORS_INA209=y
> CONFIG_SENSORS_INA2XX=y
> # CONFIG_SENSORS_INA3221 is not set
> CONFIG_SENSORS_TC74=y
> CONFIG_SENSORS_THMC50=y
> CONFIG_SENSORS_TMP102=y
> CONFIG_SENSORS_TMP103=y
> CONFIG_SENSORS_TMP108=y
> # CONFIG_SENSORS_TMP401 is not set
> CONFIG_SENSORS_TMP421=y
> CONFIG_SENSORS_VT1211=y
> CONFIG_SENSORS_W83773G=y
> CONFIG_SENSORS_W83781D=y
> # CONFIG_SENSORS_W83791D is not set
> # CONFIG_SENSORS_W83792D is not set
> CONFIG_SENSORS_W83793=y
> # CONFIG_SENSORS_W83795 is not set
> # CONFIG_SENSORS_W83L785TS is not set
> CONFIG_SENSORS_W83L786NG=y
> CONFIG_SENSORS_W83627HF=y
> CONFIG_SENSORS_W83627EHF=y
> # CONFIG_SENSORS_WM831X is not set
> CONFIG_SENSORS_WM8350=y
> CONFIG_THERMAL=y
> # CONFIG_THERMAL_STATISTICS is not set
> CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
> CONFIG_THERMAL_HWMON=y
> # CONFIG_THERMAL_OF is not set
> CONFIG_THERMAL_WRITABLE_TRIPS=y
> CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
> # CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
> # CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
> # CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR is not set
> CONFIG_THERMAL_GOV_FAIR_SHARE=y
> CONFIG_THERMAL_GOV_STEP_WISE=y
> # CONFIG_THERMAL_GOV_BANG_BANG is not set
> # CONFIG_THERMAL_GOV_USER_SPACE is not set
> # CONFIG_THERMAL_GOV_POWER_ALLOCATOR is not set
> # CONFIG_THERMAL_EMULATION is not set
> CONFIG_HISI_THERMAL=y
> # CONFIG_IMX_THERMAL is not set
> CONFIG_MAX77620_THERMAL=y
> # CONFIG_SPEAR_THERMAL is not set
> # CONFIG_ROCKCHIP_THERMAL is not set
> # CONFIG_RCAR_THERMAL is not set
> # CONFIG_RCAR_GEN3_THERMAL is not set
> # CONFIG_KIRKWOOD_THERMAL is not set
> # CONFIG_DOVE_THERMAL is not set
> # CONFIG_ARMADA_THERMAL is not set
> CONFIG_DA9062_THERMAL=y
> 
> #
> # ACPI INT340X thermal drivers
> #
> CONFIG_MTK_THERMAL=y
> 
> #
> # Broadcom thermal drivers
> #
> # CONFIG_BRCMSTB_THERMAL is not set
> # CONFIG_BCM_NS_THERMAL is not set
> 
> #
> # Texas Instruments thermal drivers
> #
> # CONFIG_TI_SOC_THERMAL is not set
> 
> #
> # Samsung thermal drivers
> #
> # CONFIG_TANGO_THERMAL is not set
> # CONFIG_QCOM_SPMI_TEMP_ALARM is not set
> # CONFIG_GENERIC_ADC_THERMAL is not set
> 
> #
> # Qualcomm thermal drivers
> #
> # CONFIG_ZX2967_THERMAL is not set
> # CONFIG_WATCHDOG is not set
> CONFIG_SSB_POSSIBLE=y
> # CONFIG_SSB is not set
> CONFIG_BCMA_POSSIBLE=y
> CONFIG_BCMA=y
> # CONFIG_BCMA_HOST_SOC is not set
> # CONFIG_BCMA_DRIVER_MIPS is not set
> # CONFIG_BCMA_DRIVER_GMAC_CMN is not set
> CONFIG_BCMA_DRIVER_GPIO=y
> # CONFIG_BCMA_DEBUG is not set
> 
> #
> # Multifunction device drivers
> #
> CONFIG_MFD_CORE=y
> CONFIG_MFD_ACT8945A=y
> # CONFIG_MFD_SUN4I_GPADC is not set
> CONFIG_MFD_AS3711=y
> CONFIG_MFD_AS3722=y
> # CONFIG_PMIC_ADP5520 is not set
> # CONFIG_MFD_AAT2870_CORE is not set
> CONFIG_MFD_ATMEL_FLEXCOM=y
> CONFIG_MFD_ATMEL_HLCDC=y
> # CONFIG_MFD_BCM590XX is not set
> CONFIG_MFD_BD9571MWV=y
> CONFIG_MFD_AXP20X=y
> CONFIG_MFD_AXP20X_I2C=y
> # CONFIG_MFD_CROS_EC is not set
> # CONFIG_MFD_MADERA is not set
> CONFIG_PMIC_DA903X=y
> CONFIG_PMIC_DA9052=y
> CONFIG_MFD_DA9052_SPI=y
> CONFIG_MFD_DA9052_I2C=y
> CONFIG_MFD_DA9055=y
> CONFIG_MFD_DA9062=y
> CONFIG_MFD_DA9063=y
> CONFIG_MFD_DA9150=y
> # CONFIG_MFD_DLN2 is not set
> # CONFIG_MFD_EXYNOS_LPASS is not set
> CONFIG_MFD_MC13XXX=y
> # CONFIG_MFD_MC13XXX_SPI is not set
> CONFIG_MFD_MC13XXX_I2C=y
> # CONFIG_MFD_MXS_LRADC is not set
> # CONFIG_MFD_MX25_TSADC is not set
> CONFIG_MFD_HI6421_PMIC=y
> # CONFIG_MFD_HI655X_PMIC is not set
> # CONFIG_HTC_PASIC3 is not set
> # CONFIG_HTC_I2CPLD is not set
> # CONFIG_MFD_KEMPLD is not set
> CONFIG_MFD_88PM800=y
> CONFIG_MFD_88PM805=y
> # CONFIG_MFD_88PM860X is not set
> # CONFIG_MFD_MAX14577 is not set
> CONFIG_MFD_MAX77620=y
> CONFIG_MFD_MAX77686=y
> CONFIG_MFD_MAX77693=y
> CONFIG_MFD_MAX77843=y
> # CONFIG_MFD_MAX8907 is not set
> CONFIG_MFD_MAX8925=y
> CONFIG_MFD_MAX8997=y
> CONFIG_MFD_MAX8998=y
> # CONFIG_MFD_MT6397 is not set
> # CONFIG_MFD_MENF21BMC is not set
> CONFIG_EZX_PCAP=y
> CONFIG_MFD_CPCAP=y
> # CONFIG_MFD_VIPERBOARD is not set
> CONFIG_MFD_RETU=y
> CONFIG_MFD_PCF50633=y
> CONFIG_PCF50633_ADC=y
> # CONFIG_PCF50633_GPIO is not set
> # CONFIG_MFD_PM8XXX is not set
> # CONFIG_MFD_SPMI_PMIC is not set
> CONFIG_MFD_RT5033=y
> # CONFIG_MFD_RC5T583 is not set
> # CONFIG_MFD_RK808 is not set
> CONFIG_MFD_RN5T618=y
> CONFIG_MFD_SEC_CORE=y
> CONFIG_MFD_SI476X_CORE=y
> # CONFIG_MFD_SM501 is not set
> # CONFIG_MFD_SKY81452 is not set
> # CONFIG_MFD_SMSC is not set
> # CONFIG_MFD_SC27XX_PMIC is not set
> CONFIG_ABX500_CORE=y
> # CONFIG_AB3100_CORE is not set
> CONFIG_MFD_STMPE=y
> 
> #
> # STMicroelectronics STMPE Interface Drivers
> #
> # CONFIG_STMPE_I2C is not set
> # CONFIG_STMPE_SPI is not set
> CONFIG_MFD_SYSCON=y
> # CONFIG_MFD_TI_AM335X_TSCADC is not set
> # CONFIG_MFD_LP3943 is not set
> CONFIG_MFD_LP8788=y
> # CONFIG_MFD_TI_LMU is not set
> # CONFIG_MFD_PALMAS is not set
> CONFIG_TPS6105X=y
> CONFIG_TPS65010=y
> CONFIG_TPS6507X=y
> CONFIG_MFD_TPS65086=y
> # CONFIG_MFD_TPS65090 is not set
> CONFIG_MFD_TPS65217=y
> # CONFIG_MFD_TI_LP873X is not set
> CONFIG_MFD_TI_LP87565=y
> # CONFIG_MFD_TPS65218 is not set
> # CONFIG_MFD_TPS6586X is not set
> CONFIG_MFD_TPS65910=y
> CONFIG_MFD_TPS65912=y
> CONFIG_MFD_TPS65912_I2C=y
> CONFIG_MFD_TPS65912_SPI=y
> # CONFIG_MFD_TPS80031 is not set
> # CONFIG_TWL4030_CORE is not set
> # CONFIG_TWL6040_CORE is not set
> CONFIG_MFD_WL1273_CORE=y
> CONFIG_MFD_LM3533=y
> CONFIG_MFD_TC3589X=y
> CONFIG_MFD_ARIZONA=y
> CONFIG_MFD_ARIZONA_I2C=y
> CONFIG_MFD_ARIZONA_SPI=y
> # CONFIG_MFD_CS47L24 is not set
> # CONFIG_MFD_WM5102 is not set
> # CONFIG_MFD_WM5110 is not set
> CONFIG_MFD_WM8997=y
> CONFIG_MFD_WM8998=y
> CONFIG_MFD_WM8400=y
> CONFIG_MFD_WM831X=y
> # CONFIG_MFD_WM831X_I2C is not set
> CONFIG_MFD_WM831X_SPI=y
> CONFIG_MFD_WM8350=y
> CONFIG_MFD_WM8350_I2C=y
> CONFIG_MFD_WM8994=y
> # CONFIG_MFD_STW481X is not set
> CONFIG_MFD_ROHM_BD718XX=y
> # CONFIG_MFD_STM32_LPTIMER is not set
> # CONFIG_MFD_STM32_TIMERS is not set
> CONFIG_RAVE_SP_CORE=y
> CONFIG_REGULATOR=y
> CONFIG_REGULATOR_DEBUG=y
> CONFIG_REGULATOR_FIXED_VOLTAGE=y
> CONFIG_REGULATOR_VIRTUAL_CONSUMER=y
> CONFIG_REGULATOR_USERSPACE_CONSUMER=y
> CONFIG_REGULATOR_88PG86X=y
> CONFIG_REGULATOR_88PM800=y
> # CONFIG_REGULATOR_ACT8865 is not set
> # CONFIG_REGULATOR_ACT8945A is not set
> CONFIG_REGULATOR_AD5398=y
> # CONFIG_REGULATOR_ANATOP is not set
> # CONFIG_REGULATOR_AS3711 is not set
> # CONFIG_REGULATOR_AS3722 is not set
> CONFIG_REGULATOR_AXP20X=y
> # CONFIG_REGULATOR_BD718XX is not set
> CONFIG_REGULATOR_BD9571MWV=y
> CONFIG_REGULATOR_CPCAP=y
> CONFIG_REGULATOR_DA903X=y
> # CONFIG_REGULATOR_DA9052 is not set
> # CONFIG_REGULATOR_DA9055 is not set
> CONFIG_REGULATOR_DA9062=y
> CONFIG_REGULATOR_DA9063=y
> CONFIG_REGULATOR_DA9210=y
> CONFIG_REGULATOR_DA9211=y
> # CONFIG_REGULATOR_FAN53555 is not set
> # CONFIG_REGULATOR_GPIO is not set
> CONFIG_REGULATOR_HI6421=y
> CONFIG_REGULATOR_HI6421V530=y
> # CONFIG_REGULATOR_ISL9305 is not set
> CONFIG_REGULATOR_ISL6271A=y
> CONFIG_REGULATOR_LP3971=y
> CONFIG_REGULATOR_LP3972=y
> CONFIG_REGULATOR_LP872X=y
> CONFIG_REGULATOR_LP8755=y
> # CONFIG_REGULATOR_LP87565 is not set
> CONFIG_REGULATOR_LP8788=y
> CONFIG_REGULATOR_LTC3589=y
> # CONFIG_REGULATOR_LTC3676 is not set
> CONFIG_REGULATOR_MAX1586=y
> # CONFIG_REGULATOR_MAX77620 is not set
> CONFIG_REGULATOR_MAX8649=y
> CONFIG_REGULATOR_MAX8660=y
> CONFIG_REGULATOR_MAX8925=y
> CONFIG_REGULATOR_MAX8952=y
> CONFIG_REGULATOR_MAX8997=y
> # CONFIG_REGULATOR_MAX8998 is not set
> # CONFIG_REGULATOR_MAX77686 is not set
> CONFIG_REGULATOR_MAX77693=y
> CONFIG_REGULATOR_MAX77802=y
> CONFIG_REGULATOR_MC13XXX_CORE=y
> CONFIG_REGULATOR_MC13783=y
> CONFIG_REGULATOR_MC13892=y
> # CONFIG_REGULATOR_MT6311 is not set
> # CONFIG_REGULATOR_PBIAS is not set
> CONFIG_REGULATOR_PCAP=y
> CONFIG_REGULATOR_PCF50633=y
> # CONFIG_REGULATOR_PFUZE100 is not set
> CONFIG_REGULATOR_PV88060=y
> # CONFIG_REGULATOR_PV88080 is not set
> CONFIG_REGULATOR_PV88090=y
> # CONFIG_REGULATOR_QCOM_RPMH is not set
> CONFIG_REGULATOR_QCOM_SPMI=y
> # CONFIG_REGULATOR_RN5T618 is not set
> # CONFIG_REGULATOR_RT5033 is not set
> # CONFIG_REGULATOR_S2MPA01 is not set
> # CONFIG_REGULATOR_S2MPS11 is not set
> # CONFIG_REGULATOR_S5M8767 is not set
> # CONFIG_REGULATOR_SC2731 is not set
> # CONFIG_REGULATOR_STM32_VREFBUF is not set
> # CONFIG_REGULATOR_STW481X_VMMC is not set
> CONFIG_REGULATOR_SY8106A=y
> # CONFIG_REGULATOR_TPS51632 is not set
> CONFIG_REGULATOR_TPS6105X=y
> CONFIG_REGULATOR_TPS62360=y
> # CONFIG_REGULATOR_TPS65023 is not set
> CONFIG_REGULATOR_TPS6507X=y
> CONFIG_REGULATOR_TPS65086=y
> CONFIG_REGULATOR_TPS65132=y
> CONFIG_REGULATOR_TPS65217=y
> CONFIG_REGULATOR_TPS6524X=y
> CONFIG_REGULATOR_TPS65910=y
> CONFIG_REGULATOR_TPS65912=y
> # CONFIG_REGULATOR_UNIPHIER is not set
> CONFIG_REGULATOR_VCTRL=y
> # CONFIG_REGULATOR_WM831X is not set
> # CONFIG_REGULATOR_WM8350 is not set
> CONFIG_REGULATOR_WM8400=y
> # CONFIG_REGULATOR_WM8994 is not set
> CONFIG_CEC_CORE=y
> CONFIG_CEC_NOTIFIER=y
> CONFIG_RC_CORE=y
> CONFIG_RC_MAP=y
> # CONFIG_LIRC is not set
> # CONFIG_RC_DECODERS is not set
> # CONFIG_RC_DEVICES is not set
> # CONFIG_MEDIA_SUPPORT is not set
> 
> #
> # Graphics support
> #
> # CONFIG_IMX_IPUV3_CORE is not set
> CONFIG_DRM=y
> CONFIG_DRM_MIPI_DSI=y
> # CONFIG_DRM_DP_AUX_CHARDEV is not set
> # CONFIG_DRM_DEBUG_MM is not set
> # CONFIG_DRM_DEBUG_SELFTEST is not set
> CONFIG_DRM_KMS_HELPER=y
> CONFIG_DRM_KMS_FB_HELPER=y
> CONFIG_DRM_FBDEV_EMULATION=y
> CONFIG_DRM_FBDEV_OVERALLOC=100
> # CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM is not set
> CONFIG_DRM_LOAD_EDID_FIRMWARE=y
> CONFIG_DRM_DP_CEC=y
> CONFIG_DRM_GEM_CMA_HELPER=y
> CONFIG_DRM_KMS_CMA_HELPER=y
> 
> #
> # I2C encoder or helper chips
> #
> CONFIG_DRM_I2C_CH7006=y
> CONFIG_DRM_I2C_SIL164=y
> CONFIG_DRM_I2C_NXP_TDA998X=y
> CONFIG_DRM_I2C_NXP_TDA9950=y
> 
> #
> # ACP (Audio CoProcessor) Configuration
> #
> 
> #
> # AMD Library routines
> #
> # CONFIG_DRM_VGEM is not set
> # CONFIG_DRM_VKMS is not set
> # CONFIG_DRM_UDL is not set
> # CONFIG_DRM_RCAR_DW_HDMI is not set
> # CONFIG_DRM_RCAR_LVDS is not set
> # CONFIG_DRM_VIRTIO_GPU is not set
> CONFIG_DRM_PANEL=y
> 
> #
> # Display Panels
> #
> CONFIG_DRM_PANEL_ARM_VERSATILE=y
> CONFIG_DRM_PANEL_LVDS=y
> # CONFIG_DRM_PANEL_SIMPLE is not set
> CONFIG_DRM_PANEL_ILITEK_IL9322=y
> # CONFIG_DRM_PANEL_ILITEK_ILI9881C is not set
> CONFIG_DRM_PANEL_INNOLUX_P079ZCA=y
> # CONFIG_DRM_PANEL_JDI_LT070ME05000 is not set
> # CONFIG_DRM_PANEL_SAMSUNG_LD9040 is not set
> # CONFIG_DRM_PANEL_LG_LG4573 is not set
> CONFIG_DRM_PANEL_ORISETECH_OTM8009A=y
> CONFIG_DRM_PANEL_PANASONIC_VVX10F034N00=y
> CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN=y
> # CONFIG_DRM_PANEL_RAYDIUM_RM68200 is not set
> # CONFIG_DRM_PANEL_SAMSUNG_S6E3HA2 is not set
> CONFIG_DRM_PANEL_SAMSUNG_S6E63J0X03=y
> CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0=y
> CONFIG_DRM_PANEL_SEIKO_43WVF1G=y
> CONFIG_DRM_PANEL_SHARP_LQ101R1SX01=y
> # CONFIG_DRM_PANEL_SHARP_LS043T1LE01 is not set
> CONFIG_DRM_PANEL_SITRONIX_ST7789V=y
> CONFIG_DRM_BRIDGE=y
> CONFIG_DRM_PANEL_BRIDGE=y
> 
> #
> # Display Interface Bridges
> #
> CONFIG_DRM_ANALOGIX_ANX78XX=y
> CONFIG_DRM_CDNS_DSI=y
> # CONFIG_DRM_DUMB_VGA_DAC is not set
> # CONFIG_DRM_LVDS_ENCODER is not set
> # CONFIG_DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW is not set
> # CONFIG_DRM_NXP_PTN3460 is not set
> # CONFIG_DRM_PARADE_PS8622 is not set
> CONFIG_DRM_SIL_SII8620=y
> CONFIG_DRM_SII902X=y
> CONFIG_DRM_SII9234=y
> CONFIG_DRM_THINE_THC63LVD1024=y
> CONFIG_DRM_TOSHIBA_TC358767=y
> CONFIG_DRM_TI_TFP410=y
> CONFIG_DRM_I2C_ADV7511=y
> CONFIG_DRM_I2C_ADV7533=y
> CONFIG_DRM_I2C_ADV7511_CEC=y
> # CONFIG_DRM_V3D is not set
> CONFIG_DRM_ARCPGU=y
> CONFIG_DRM_MXS=y
> CONFIG_DRM_MXSFB=y
> # CONFIG_DRM_TINYDRM is not set
> # CONFIG_DRM_PL111 is not set
> # CONFIG_DRM_LEGACY is not set
> CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
> 
> #
> # Frame buffer Devices
> #
> CONFIG_FB_CMDLINE=y
> CONFIG_FB_NOTIFY=y
> CONFIG_FB=y
> # CONFIG_FIRMWARE_EDID is not set
> CONFIG_FB_CFB_FILLRECT=y
> CONFIG_FB_CFB_COPYAREA=y
> CONFIG_FB_CFB_IMAGEBLIT=y
> CONFIG_FB_SYS_FILLRECT=y
> CONFIG_FB_SYS_COPYAREA=y
> CONFIG_FB_SYS_IMAGEBLIT=y
> # CONFIG_FB_FOREIGN_ENDIAN is not set
> CONFIG_FB_SYS_FOPS=y
> CONFIG_FB_DEFERRED_IO=y
> # CONFIG_FB_MODE_HELPERS is not set
> # CONFIG_FB_TILEBLITTING is not set
> 
> #
> # Frame buffer hardware drivers
> #
> # CONFIG_FB_CLPS711X is not set
> # CONFIG_FB_UVESA is not set
> # CONFIG_FB_OPENCORES is not set
> # CONFIG_FB_S1D13XXX is not set
> # CONFIG_FB_TMIO is not set
> # CONFIG_FB_SMSCUFX is not set
> # CONFIG_FB_UDL is not set
> # CONFIG_FB_IBM_GXT4500 is not set
> # CONFIG_FB_GOLDFISH is not set
> # CONFIG_FB_VIRTUAL is not set
> # CONFIG_FB_METRONOME is not set
> # CONFIG_FB_BROADSHEET is not set
> # CONFIG_FB_SIMPLE is not set
> # CONFIG_FB_SSD1307 is not set
> # CONFIG_FB_OMAP2 is not set
> CONFIG_BACKLIGHT_LCD_SUPPORT=y
> CONFIG_LCD_CLASS_DEVICE=y
> CONFIG_LCD_L4F00242T03=y
> CONFIG_LCD_LMS283GF05=y
> CONFIG_LCD_LTV350QV=y
> CONFIG_LCD_ILI922X=y
> # CONFIG_LCD_ILI9320 is not set
> # CONFIG_LCD_TDO24M is not set
> # CONFIG_LCD_VGG2432A4 is not set
> CONFIG_LCD_PLATFORM=y
> # CONFIG_LCD_S6E63M0 is not set
> # CONFIG_LCD_LD9040 is not set
> # CONFIG_LCD_AMS369FG06 is not set
> CONFIG_LCD_LMS501KF03=y
> CONFIG_LCD_HX8357=y
> # CONFIG_LCD_OTM3225A is not set
> CONFIG_BACKLIGHT_CLASS_DEVICE=y
> CONFIG_BACKLIGHT_GENERIC=y
> CONFIG_BACKLIGHT_LM3533=y
> CONFIG_BACKLIGHT_DA903X=y
> # CONFIG_BACKLIGHT_DA9052 is not set
> CONFIG_BACKLIGHT_MAX8925=y
> # CONFIG_BACKLIGHT_PM8941_WLED is not set
> # CONFIG_BACKLIGHT_WM831X is not set
> CONFIG_BACKLIGHT_ADP8860=y
> CONFIG_BACKLIGHT_ADP8870=y
> CONFIG_BACKLIGHT_PCF50633=y
> # CONFIG_BACKLIGHT_LM3639 is not set
> CONFIG_BACKLIGHT_TPS65217=y
> # CONFIG_BACKLIGHT_AS3711 is not set
> CONFIG_BACKLIGHT_GPIO=y
> CONFIG_BACKLIGHT_LV5207LP=y
> CONFIG_BACKLIGHT_BD6107=y
> # CONFIG_BACKLIGHT_ARCXCNN is not set
> # CONFIG_BACKLIGHT_RAVE_SP is not set
> CONFIG_VIDEOMODE_HELPERS=y
> CONFIG_HDMI=y
> # CONFIG_LOGO is not set
> CONFIG_SOUND=y
> # CONFIG_SND is not set
> 
> #
> # HID support
> #
> CONFIG_HID=y
> # CONFIG_HID_BATTERY_STRENGTH is not set
> CONFIG_HIDRAW=y
> CONFIG_UHID=y
> CONFIG_HID_GENERIC=y
> 
> #
> # Special HID drivers
> #
> CONFIG_HID_A4TECH=y
> CONFIG_HID_ACRUX=y
> # CONFIG_HID_ACRUX_FF is not set
> # CONFIG_HID_APPLE is not set
> CONFIG_HID_AUREAL=y
> CONFIG_HID_BELKIN=y
> CONFIG_HID_CHERRY=y
> CONFIG_HID_COUGAR=y
> CONFIG_HID_CMEDIA=y
> CONFIG_HID_CYPRESS=y
> CONFIG_HID_DRAGONRISE=y
> # CONFIG_DRAGONRISE_FF is not set
> CONFIG_HID_EMS_FF=y
> CONFIG_HID_ELECOM=y
> # CONFIG_HID_EZKEY is not set
> # CONFIG_HID_GEMBIRD is not set
> CONFIG_HID_GFRM=y
> CONFIG_HID_KEYTOUCH=y
> CONFIG_HID_KYE=y
> CONFIG_HID_WALTOP=y
> # CONFIG_HID_GYRATION is not set
> CONFIG_HID_ICADE=y
> CONFIG_HID_ITE=y
> # CONFIG_HID_JABRA is not set
> # CONFIG_HID_TWINHAN is not set
> CONFIG_HID_KENSINGTON=y
> CONFIG_HID_LCPOWER=y
> CONFIG_HID_LED=y
> CONFIG_HID_LENOVO=y
> CONFIG_HID_MAGICMOUSE=y
> CONFIG_HID_MAYFLASH=y
> CONFIG_HID_REDRAGON=y
> CONFIG_HID_MICROSOFT=y
> # CONFIG_HID_MONTEREY is not set
> CONFIG_HID_MULTITOUCH=y
> CONFIG_HID_NTI=y
> # CONFIG_HID_ORTEK is not set
> CONFIG_HID_PANTHERLORD=y
> # CONFIG_PANTHERLORD_FF is not set
> # CONFIG_HID_PETALYNX is not set
> # CONFIG_HID_PICOLCD is not set
> CONFIG_HID_PLANTRONICS=y
> CONFIG_HID_PRIMAX=y
> # CONFIG_HID_SAITEK is not set
> # CONFIG_HID_SPEEDLINK is not set
> # CONFIG_HID_STEAM is not set
> CONFIG_HID_STEELSERIES=y
> # CONFIG_HID_SUNPLUS is not set
> CONFIG_HID_RMI=y
> CONFIG_HID_GREENASIA=y
> # CONFIG_GREENASIA_FF is not set
> CONFIG_HID_SMARTJOYPLUS=y
> CONFIG_SMARTJOYPLUS_FF=y
> CONFIG_HID_TIVO=y
> CONFIG_HID_TOPSEED=y
> CONFIG_HID_THINGM=y
> # CONFIG_HID_THRUSTMASTER is not set
> # CONFIG_HID_UDRAW_PS3 is not set
> # CONFIG_HID_WIIMOTE is not set
> CONFIG_HID_XINMO=y
> # CONFIG_HID_ZEROPLUS is not set
> CONFIG_HID_ZYDACRON=y
> CONFIG_HID_SENSOR_HUB=y
> # CONFIG_HID_SENSOR_CUSTOM_SENSOR is not set
> CONFIG_HID_ALPS=y
> 
> #
> # USB HID support
> #
> # CONFIG_USB_HID is not set
> # CONFIG_HID_PID is not set
> 
> #
> # USB HID Boot Protocol drivers
> #
> # CONFIG_USB_KBD is not set
> CONFIG_USB_MOUSE=y
> 
> #
> # I2C HID support
> #
> # CONFIG_I2C_HID is not set
> CONFIG_USB_OHCI_LITTLE_ENDIAN=y
> CONFIG_USB_SUPPORT=y
> CONFIG_USB_COMMON=y
> CONFIG_USB_ARCH_HAS_HCD=y
> CONFIG_USB=y
> CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
> 
> #
> # Miscellaneous USB options
> #
> # CONFIG_USB_DEFAULT_PERSIST is not set
> # CONFIG_USB_DYNAMIC_MINORS is not set
> # CONFIG_USB_OTG_WHITELIST is not set
> # CONFIG_USB_OTG_BLACKLIST_HUB is not set
> CONFIG_USB_LEDS_TRIGGER_USBPORT=y
> CONFIG_USB_MON=y
> # CONFIG_USB_WUSB_CBAF is not set
> 
> #
> # USB Host Controller Drivers
> #
> # CONFIG_USB_C67X00_HCD is not set
> CONFIG_USB_XHCI_HCD=y
> CONFIG_USB_XHCI_PLATFORM=y
> # CONFIG_USB_XHCI_HISTB is not set
> # CONFIG_USB_XHCI_MTK is not set
> # CONFIG_USB_XHCI_MVEBU is not set
> # CONFIG_USB_XHCI_RCAR is not set
> CONFIG_USB_EHCI_HCD=y
> CONFIG_USB_EHCI_ROOT_HUB_TT=y
> CONFIG_USB_EHCI_TT_NEWSCHED=y
> # CONFIG_USB_EHCI_HCD_NPCM7XX is not set
> CONFIG_USB_EHCI_HCD_PLATFORM=y
> CONFIG_USB_OXU210HP_HCD=y
> # CONFIG_USB_ISP116X_HCD is not set
> # CONFIG_USB_ISP1362_HCD is not set
> CONFIG_USB_FOTG210_HCD=y
> CONFIG_USB_MAX3421_HCD=y
> CONFIG_USB_OHCI_HCD=y
> CONFIG_USB_OHCI_HCD_PLATFORM=y
> CONFIG_USB_U132_HCD=y
> # CONFIG_USB_SL811_HCD is not set
> # CONFIG_USB_R8A66597_HCD is not set
> CONFIG_USB_HCD_BCMA=y
> # CONFIG_USB_HCD_TEST_MODE is not set
> # CONFIG_USB_RENESAS_USBHS is not set
> 
> #
> # USB Device Class drivers
> #
> CONFIG_USB_PRINTER=y
> # CONFIG_USB_WDM is not set
> # CONFIG_USB_TMC is not set
> 
> #
> # NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
> #
> 
> #
> # also be needed; see USB_STORAGE Help for more info
> #
> 
> #
> # USB Imaging devices
> #
> CONFIG_USB_MDC800=y
> CONFIG_USBIP_CORE=y
> CONFIG_USBIP_VHCI_HCD=y
> CONFIG_USBIP_VHCI_HC_PORTS=8
> CONFIG_USBIP_VHCI_NR_HCS=1
> CONFIG_USBIP_HOST=y
> # CONFIG_USBIP_VUDC is not set
> CONFIG_USBIP_DEBUG=y
> # CONFIG_USB_MTU3 is not set
> CONFIG_USB_MUSB_HDRC=y
> # CONFIG_USB_MUSB_HOST is not set
> # CONFIG_USB_MUSB_GADGET is not set
> CONFIG_USB_MUSB_DUAL_ROLE=y
> 
> #
> # Platform Glue Layer
> #
> # CONFIG_USB_MUSB_DSPS is not set
> # CONFIG_USB_MUSB_UX500 is not set
> 
> #
> # MUSB DMA mode
> #
> CONFIG_MUSB_PIO_ONLY=y
> CONFIG_USB_DWC3=y
> CONFIG_USB_DWC3_ULPI=y
> # CONFIG_USB_DWC3_HOST is not set
> # CONFIG_USB_DWC3_GADGET is not set
> CONFIG_USB_DWC3_DUAL_ROLE=y
> 
> #
> # Platform Glue Driver Support
> #
> CONFIG_USB_DWC3_OMAP=y
> CONFIG_USB_DWC3_EXYNOS=y
> CONFIG_USB_DWC3_KEYSTONE=y
> # CONFIG_USB_DWC3_OF_SIMPLE is not set
> CONFIG_USB_DWC3_ST=y
> CONFIG_USB_DWC3_QCOM=y
> # CONFIG_USB_DWC2 is not set
> # CONFIG_USB_CHIPIDEA is not set
> # CONFIG_USB_ISP1760 is not set
> 
> #
> # USB port drivers
> #
> CONFIG_USB_USS720=y
> 
> #
> # USB Miscellaneous drivers
> #
> CONFIG_USB_EMI62=y
> CONFIG_USB_EMI26=y
> # CONFIG_USB_ADUTUX is not set
> # CONFIG_USB_SEVSEG is not set
> # CONFIG_USB_LEGOTOWER is not set
> # CONFIG_USB_LCD is not set
> # CONFIG_USB_CYPRESS_CY7C63 is not set
> CONFIG_USB_CYTHERM=y
> CONFIG_USB_IDMOUSE=y
> CONFIG_USB_FTDI_ELAN=y
> CONFIG_USB_APPLEDISPLAY=y
> CONFIG_USB_SISUSBVGA=y
> CONFIG_USB_LD=y
> CONFIG_USB_TRANCEVIBRATOR=y
> CONFIG_USB_IOWARRIOR=y
> CONFIG_USB_TEST=y
> CONFIG_USB_EHSET_TEST_FIXTURE=y
> # CONFIG_USB_ISIGHTFW is not set
> # CONFIG_USB_YUREX is not set
> # CONFIG_USB_EZUSB_FX2 is not set
> CONFIG_USB_HUB_USB251XB=y
> CONFIG_USB_HSIC_USB3503=y
> CONFIG_USB_HSIC_USB4604=y
> CONFIG_USB_LINK_LAYER_TEST=y
> # CONFIG_USB_CHAOSKEY is not set
> CONFIG_USB_ATM=y
> # CONFIG_USB_SPEEDTOUCH is not set
> CONFIG_USB_CXACRU=y
> CONFIG_USB_UEAGLEATM=y
> CONFIG_USB_XUSBATM=y
> 
> #
> # USB Physical Layer drivers
> #
> CONFIG_USB_PHY=y
> # CONFIG_NOP_USB_XCEIV is not set
> CONFIG_USB_GPIO_VBUS=y
> # CONFIG_TAHVO_USB is not set
> CONFIG_USB_ISP1301=y
> CONFIG_USB_GADGET=y
> CONFIG_USB_GADGET_DEBUG=y
> # CONFIG_USB_GADGET_VERBOSE is not set
> CONFIG_USB_GADGET_DEBUG_FILES=y
> # CONFIG_USB_GADGET_DEBUG_FS is not set
> CONFIG_USB_GADGET_VBUS_DRAW=2
> CONFIG_USB_GADGET_STORAGE_NUM_BUFFERS=2
> 
> #
> # USB Peripheral Controller
> #
> # CONFIG_USB_FOTG210_UDC is not set
> CONFIG_USB_GR_UDC=y
> # CONFIG_USB_R8A66597 is not set
> # CONFIG_USB_RENESAS_USB3 is not set
> CONFIG_USB_PXA27X=y
> CONFIG_USB_MV_UDC=y
> CONFIG_USB_MV_U3D=y
> CONFIG_USB_SNP_CORE=y
> CONFIG_USB_SNP_UDC_PLAT=y
> # CONFIG_USB_M66592 is not set
> CONFIG_USB_BDC_UDC=y
> 
> #
> # Platform Support
> #
> CONFIG_USB_NET2272=y
> CONFIG_USB_NET2272_DMA=y
> CONFIG_USB_GADGET_XILINX=y
> # CONFIG_USB_ASPEED_VHUB is not set
> CONFIG_USB_DUMMY_HCD=y
> CONFIG_USB_LIBCOMPOSITE=y
> CONFIG_USB_F_SS_LB=y
> CONFIG_USB_U_ETHER=y
> CONFIG_USB_F_NCM=y
> CONFIG_USB_F_ECM=y
> CONFIG_USB_F_PHONET=y
> CONFIG_USB_F_EEM=y
> CONFIG_USB_F_FS=y
> CONFIG_USB_F_HID=y
> CONFIG_USB_CONFIGFS=y
> CONFIG_USB_CONFIGFS_NCM=y
> CONFIG_USB_CONFIGFS_ECM=y
> # CONFIG_USB_CONFIGFS_ECM_SUBSET is not set
> # CONFIG_USB_CONFIGFS_RNDIS is not set
> CONFIG_USB_CONFIGFS_EEM=y
> CONFIG_USB_CONFIGFS_PHONET=y
> CONFIG_USB_CONFIGFS_F_LB_SS=y
> CONFIG_USB_CONFIGFS_F_FS=y
> # CONFIG_USB_CONFIGFS_F_HID is not set
> # CONFIG_USB_CONFIGFS_F_PRINTER is not set
> # CONFIG_USB_ZERO is not set
> # CONFIG_USB_ETH is not set
> # CONFIG_USB_G_NCM is not set
> # CONFIG_USB_GADGETFS is not set
> # CONFIG_USB_FUNCTIONFS is not set
> # CONFIG_USB_G_PRINTER is not set
> CONFIG_USB_G_HID=y
> # CONFIG_TYPEC is not set
> CONFIG_USB_ROLE_SWITCH=y
> # CONFIG_USB_LED_TRIG is not set
> CONFIG_USB_ULPI_BUS=y
> # CONFIG_UWB is not set
> CONFIG_MMC=y
> CONFIG_PWRSEQ_EMMC=y
> CONFIG_PWRSEQ_SD8787=y
> # CONFIG_PWRSEQ_SIMPLE is not set
> CONFIG_MMC_TEST=y
> 
> #
> # MMC/SD/SDIO Host Controller Drivers
> #
> CONFIG_MMC_DEBUG=y
> CONFIG_MMC_SDHCI=y
> CONFIG_MMC_SDHCI_PLTFM=y
> # CONFIG_MMC_SDHCI_OF_ARASAN is not set
> CONFIG_MMC_SDHCI_OF_AT91=y
> # CONFIG_MMC_SDHCI_OF_DWCMSHC is not set
> CONFIG_MMC_SDHCI_CADENCE=y
> # CONFIG_MMC_SDHCI_PXAV3 is not set
> # CONFIG_MMC_SDHCI_PXAV2 is not set
> CONFIG_MMC_SDHCI_F_SDH30=y
> # CONFIG_MMC_SDHCI_IPROC is not set
> # CONFIG_MMC_MESON_MX_SDIO is not set
> # CONFIG_MMC_OMAP_HS is not set
> # CONFIG_MMC_GOLDFISH is not set
> # CONFIG_MMC_SPI is not set
> # CONFIG_MMC_SDHI is not set
> CONFIG_MMC_DW=y
> CONFIG_MMC_DW_PLTFM=y
> CONFIG_MMC_DW_BLUEFIELD=y
> CONFIG_MMC_DW_EXYNOS=y
> CONFIG_MMC_DW_HI3798CV200=y
> CONFIG_MMC_DW_K3=y
> # CONFIG_MMC_SH_MMCIF is not set
> CONFIG_MMC_VUB300=y
> CONFIG_MMC_USHC=y
> CONFIG_MMC_USDHI6ROL0=y
> CONFIG_MMC_REALTEK_USB=y
> CONFIG_MMC_CQHCI=y
> # CONFIG_MMC_BCM2835 is not set
> CONFIG_MMC_MTK=y
> # CONFIG_MMC_SDHCI_XENON is not set
> CONFIG_MMC_SDHCI_OMAP=y
> # CONFIG_MEMSTICK is not set
> CONFIG_NEW_LEDS=y
> CONFIG_LEDS_CLASS=y
> CONFIG_LEDS_CLASS_FLASH=y
> # CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set
> 
> #
> # LED drivers
> #
> CONFIG_LEDS_AAT1290=y
> CONFIG_LEDS_AS3645A=y
> CONFIG_LEDS_BCM6328=y
> CONFIG_LEDS_BCM6358=y
> # CONFIG_LEDS_CPCAP is not set
> CONFIG_LEDS_CR0014114=y
> CONFIG_LEDS_LM3530=y
> CONFIG_LEDS_LM3533=y
> CONFIG_LEDS_LM3642=y
> CONFIG_LEDS_LM3692X=y
> CONFIG_LEDS_LM3601X=y
> # CONFIG_LEDS_PCA9532 is not set
> CONFIG_LEDS_GPIO=y
> CONFIG_LEDS_LP3944=y
> CONFIG_LEDS_LP3952=y
> # CONFIG_LEDS_LP5521 is not set
> # CONFIG_LEDS_LP5523 is not set
> # CONFIG_LEDS_LP5562 is not set
> # CONFIG_LEDS_LP8501 is not set
> CONFIG_LEDS_LP8788=y
> CONFIG_LEDS_LP8860=y
> # CONFIG_LEDS_PCA955X is not set
> # CONFIG_LEDS_PCA963X is not set
> CONFIG_LEDS_WM831X_STATUS=y
> # CONFIG_LEDS_WM8350 is not set
> CONFIG_LEDS_DA903X=y
> CONFIG_LEDS_DA9052=y
> # CONFIG_LEDS_DAC124S085 is not set
> # CONFIG_LEDS_REGULATOR is not set
> CONFIG_LEDS_BD2802=y
> # CONFIG_LEDS_LT3593 is not set
> CONFIG_LEDS_MC13783=y
> # CONFIG_LEDS_TCA6507 is not set
> # CONFIG_LEDS_TLC591XX is not set
> CONFIG_LEDS_MAX77693=y
> CONFIG_LEDS_MAX8997=y
> # CONFIG_LEDS_LM355x is not set
> # CONFIG_LEDS_OT200 is not set
> CONFIG_LEDS_KTD2692=y
> CONFIG_LEDS_IS31FL319X=y
> # CONFIG_LEDS_IS31FL32XX is not set
> 
> #
> # LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
> #
> CONFIG_LEDS_BLINKM=y
> CONFIG_LEDS_SYSCON=y
> # CONFIG_LEDS_MLXREG is not set
> CONFIG_LEDS_USER=y
> 
> #
> # LED Triggers
> #
> CONFIG_LEDS_TRIGGERS=y
> CONFIG_LEDS_TRIGGER_TIMER=y
> # CONFIG_LEDS_TRIGGER_ONESHOT is not set
> # CONFIG_LEDS_TRIGGER_MTD is not set
> CONFIG_LEDS_TRIGGER_HEARTBEAT=y
> # CONFIG_LEDS_TRIGGER_BACKLIGHT is not set
> CONFIG_LEDS_TRIGGER_CPU=y
> CONFIG_LEDS_TRIGGER_ACTIVITY=y
> CONFIG_LEDS_TRIGGER_GPIO=y
> CONFIG_LEDS_TRIGGER_DEFAULT_ON=y
> 
> #
> # iptables trigger is under Netfilter config (LED target)
> #
> # CONFIG_LEDS_TRIGGER_TRANSIENT is not set
> # CONFIG_LEDS_TRIGGER_CAMERA is not set
> # CONFIG_LEDS_TRIGGER_PANIC is not set
> CONFIG_LEDS_TRIGGER_NETDEV=y
> # CONFIG_ACCESSIBILITY is not set
> # CONFIG_INFINIBAND is not set
> CONFIG_RTC_LIB=y
> CONFIG_RTC_CLASS=y
> # CONFIG_RTC_HCTOSYS is not set
> CONFIG_RTC_SYSTOHC=y
> CONFIG_RTC_SYSTOHC_DEVICE="rtc0"
> # CONFIG_RTC_DEBUG is not set
> # CONFIG_RTC_NVMEM is not set
> 
> #
> # RTC interfaces
> #
> CONFIG_RTC_INTF_SYSFS=y
> # CONFIG_RTC_INTF_PROC is not set
> CONFIG_RTC_INTF_DEV=y
> # CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
> CONFIG_RTC_DRV_TEST=y
> 
> #
> # I2C RTC drivers
> #
> CONFIG_RTC_DRV_88PM80X=y
> CONFIG_RTC_DRV_ABB5ZES3=y
> CONFIG_RTC_DRV_ABX80X=y
> # CONFIG_RTC_DRV_BRCMSTB is not set
> CONFIG_RTC_DRV_AS3722=y
> CONFIG_RTC_DRV_DS1307=y
> CONFIG_RTC_DRV_DS1307_CENTURY=y
> CONFIG_RTC_DRV_DS1374=y
> # CONFIG_RTC_DRV_DS1374_WDT is not set
> # CONFIG_RTC_DRV_DS1672 is not set
> CONFIG_RTC_DRV_HYM8563=y
> CONFIG_RTC_DRV_LP8788=y
> CONFIG_RTC_DRV_MAX6900=y
> # CONFIG_RTC_DRV_MAX8907 is not set
> # CONFIG_RTC_DRV_MAX8925 is not set
> CONFIG_RTC_DRV_MAX8998=y
> CONFIG_RTC_DRV_MAX8997=y
> CONFIG_RTC_DRV_MAX77686=y
> CONFIG_RTC_DRV_RS5C372=y
> # CONFIG_RTC_DRV_ISL1208 is not set
> CONFIG_RTC_DRV_ISL12022=y
> # CONFIG_RTC_DRV_ISL12026 is not set
> CONFIG_RTC_DRV_X1205=y
> # CONFIG_RTC_DRV_PCF8523 is not set
> CONFIG_RTC_DRV_PCF85063=y
> # CONFIG_RTC_DRV_PCF85363 is not set
> # CONFIG_RTC_DRV_PCF8563 is not set
> CONFIG_RTC_DRV_PCF8583=y
> CONFIG_RTC_DRV_M41T80=y
> # CONFIG_RTC_DRV_M41T80_WDT is not set
> CONFIG_RTC_DRV_BQ32K=y
> # CONFIG_RTC_DRV_TPS65910 is not set
> CONFIG_RTC_DRV_S35390A=y
> CONFIG_RTC_DRV_FM3130=y
> # CONFIG_RTC_DRV_RX8010 is not set
> CONFIG_RTC_DRV_RX8581=y
> CONFIG_RTC_DRV_RX8025=y
> CONFIG_RTC_DRV_EM3027=y
> CONFIG_RTC_DRV_RV8803=y
> # CONFIG_RTC_DRV_S5M is not set
> 
> #
> # SPI RTC drivers
> #
> CONFIG_RTC_DRV_M41T93=y
> CONFIG_RTC_DRV_M41T94=y
> # CONFIG_RTC_DRV_DS1302 is not set
> CONFIG_RTC_DRV_DS1305=y
> CONFIG_RTC_DRV_DS1343=y
> # CONFIG_RTC_DRV_DS1347 is not set
> CONFIG_RTC_DRV_DS1390=y
> CONFIG_RTC_DRV_MAX6916=y
> # CONFIG_RTC_DRV_R9701 is not set
> # CONFIG_RTC_DRV_RX4581 is not set
> CONFIG_RTC_DRV_RX6110=y
> CONFIG_RTC_DRV_RS5C348=y
> # CONFIG_RTC_DRV_MAX6902 is not set
> CONFIG_RTC_DRV_PCF2123=y
> # CONFIG_RTC_DRV_MCP795 is not set
> CONFIG_RTC_I2C_AND_SPI=y
> 
> #
> # SPI and I2C RTC drivers
> #
> # CONFIG_RTC_DRV_DS3232 is not set
> # CONFIG_RTC_DRV_PCF2127 is not set
> CONFIG_RTC_DRV_RV3029C2=y
> CONFIG_RTC_DRV_RV3029_HWMON=y
> 
> #
> # Platform RTC drivers
> #
> CONFIG_RTC_DRV_DS1286=y
> # CONFIG_RTC_DRV_DS1511 is not set
> # CONFIG_RTC_DRV_DS1553 is not set
> CONFIG_RTC_DRV_DS1685_FAMILY=y
> CONFIG_RTC_DRV_DS1685=y
> # CONFIG_RTC_DRV_DS1689 is not set
> # CONFIG_RTC_DRV_DS17285 is not set
> # CONFIG_RTC_DRV_DS17485 is not set
> # CONFIG_RTC_DRV_DS17885 is not set
> # CONFIG_RTC_DS1685_PROC_REGS is not set
> CONFIG_RTC_DRV_DS1742=y
> CONFIG_RTC_DRV_DS2404=y
> CONFIG_RTC_DRV_DA9052=y
> # CONFIG_RTC_DRV_DA9055 is not set
> # CONFIG_RTC_DRV_DA9063 is not set
> # CONFIG_RTC_DRV_STK17TA8 is not set
> # CONFIG_RTC_DRV_M48T86 is not set
> CONFIG_RTC_DRV_M48T35=y
> CONFIG_RTC_DRV_M48T59=y
> CONFIG_RTC_DRV_MSM6242=y
> CONFIG_RTC_DRV_BQ4802=y
> # CONFIG_RTC_DRV_RP5C01 is not set
> # CONFIG_RTC_DRV_V3020 is not set
> # CONFIG_RTC_DRV_WM831X is not set
> CONFIG_RTC_DRV_WM8350=y
> # CONFIG_RTC_DRV_SC27XX is not set
> CONFIG_RTC_DRV_SPEAR=y
> CONFIG_RTC_DRV_PCF50633=y
> # CONFIG_RTC_DRV_NUC900 is not set
> # CONFIG_RTC_DRV_ZYNQMP is not set
> 
> #
> # on-CPU RTC drivers
> #
> # CONFIG_RTC_DRV_ASM9260 is not set
> # CONFIG_RTC_DRV_DAVINCI is not set
> # CONFIG_RTC_DRV_DIGICOLOR is not set
> # CONFIG_RTC_DRV_OMAP is not set
> # CONFIG_RTC_DRV_S3C is not set
> # CONFIG_RTC_DRV_EP93XX is not set
> # CONFIG_RTC_DRV_VR41XX is not set
> # CONFIG_RTC_DRV_AT91RM9200 is not set
> # CONFIG_RTC_DRV_AT91SAM9 is not set
> # CONFIG_RTC_DRV_GENERIC is not set
> # CONFIG_RTC_DRV_VT8500 is not set
> # CONFIG_RTC_DRV_SUN6I is not set
> # CONFIG_RTC_DRV_SUNXI is not set
> # CONFIG_RTC_DRV_TX4939 is not set
> # CONFIG_RTC_DRV_MV is not set
> # CONFIG_RTC_DRV_ARMADA38X is not set
> # CONFIG_RTC_DRV_FTRTC010 is not set
> # CONFIG_RTC_DRV_COH901331 is not set
> # CONFIG_RTC_DRV_STMP is not set
> # CONFIG_RTC_DRV_PCAP is not set
> CONFIG_RTC_DRV_MC13XXX=y
> # CONFIG_RTC_DRV_JZ4740 is not set
> # CONFIG_RTC_DRV_LPC24XX is not set
> # CONFIG_RTC_DRV_LPC32XX is not set
> # CONFIG_RTC_DRV_PM8XXX is not set
> # CONFIG_RTC_DRV_TEGRA is not set
> # CONFIG_RTC_DRV_SNVS is not set
> # CONFIG_RTC_DRV_MOXART is not set
> # CONFIG_RTC_DRV_MT6397 is not set
> # CONFIG_RTC_DRV_MT7622 is not set
> # CONFIG_RTC_DRV_XGENE is not set
> # CONFIG_RTC_DRV_R7301 is not set
> # CONFIG_RTC_DRV_STM32 is not set
> CONFIG_RTC_DRV_CPCAP=y
> # CONFIG_RTC_DRV_RTD119X is not set
> 
> #
> # HID Sensor RTC drivers
> #
> CONFIG_DMADEVICES=y
> CONFIG_DMADEVICES_DEBUG=y
> CONFIG_DMADEVICES_VDEBUG=y
> 
> #
> # DMA Devices
> #
> CONFIG_DMA_ENGINE=y
> CONFIG_DMA_VIRTUAL_CHANNELS=y
> CONFIG_DMA_OF=y
> CONFIG_ALTERA_MSGDMA=y
> # CONFIG_AXI_DMAC is not set
> # CONFIG_COH901318 is not set
> # CONFIG_DMA_JZ4740 is not set
> # CONFIG_DMA_JZ4780 is not set
> # CONFIG_DMA_SA11X0 is not set
> # CONFIG_DMA_SUN6I is not set
> CONFIG_DW_AXI_DMAC=y
> # CONFIG_EP93XX_DMA is not set
> CONFIG_FSL_EDMA=y
> # CONFIG_IMG_MDC_DMA is not set
> CONFIG_INTEL_IDMA64=y
> # CONFIG_K3_DMA is not set
> # CONFIG_MMP_PDMA is not set
> # CONFIG_MMP_TDMA is not set
> # CONFIG_MV_XOR is not set
> # CONFIG_MXS_DMA is not set
> # CONFIG_NBPFAXI_DMA is not set
> # CONFIG_STM32_DMA is not set
> # CONFIG_STM32_DMAMUX is not set
> # CONFIG_STM32_MDMA is not set
> # CONFIG_SPRD_DMA is not set
> # CONFIG_S3C24XX_DMAC is not set
> # CONFIG_TIMB_DMA is not set
> # CONFIG_XGENE_DMA is not set
> # CONFIG_ZX_DMA is not set
> # CONFIG_MTK_HSDMA is not set
> # CONFIG_QCOM_HIDMA_MGMT is not set
> CONFIG_QCOM_HIDMA=y
> CONFIG_DW_DMAC_CORE=y
> CONFIG_DW_DMAC=y
> CONFIG_RENESAS_DMA=y
> CONFIG_SH_DMAE_BASE=y
> # CONFIG_SH_DMAE is not set
> # CONFIG_RCAR_DMAC is not set
> # CONFIG_RENESAS_USB_DMAC is not set
> # CONFIG_SUDMAC is not set
> CONFIG_TI_EDMA=y
> CONFIG_DMA_OMAP=y
> CONFIG_TI_DMA_CROSSBAR=y
> 
> #
> # DMA Clients
> #
> CONFIG_ASYNC_TX_DMA=y
> CONFIG_DMATEST=y
> CONFIG_DMA_ENGINE_RAID=y
> 
> #
> # DMABUF options
> #
> CONFIG_SYNC_FILE=y
> # CONFIG_SW_SYNC is not set
> CONFIG_AUXDISPLAY=y
> CONFIG_HD44780=y
> CONFIG_IMG_ASCII_LCD=y
> # CONFIG_HT16K33 is not set
> CONFIG_PANEL=y
> CONFIG_PANEL_PARPORT=0
> CONFIG_PANEL_PROFILE=5
> CONFIG_PANEL_CHANGE_MESSAGE=y
> CONFIG_PANEL_BOOT_MESSAGE=""
> CONFIG_CHARLCD=y
> # CONFIG_UIO is not set
> # CONFIG_VIRT_DRIVERS is not set
> CONFIG_VIRTIO=y
> CONFIG_VIRTIO_MENU=y
> CONFIG_VIRTIO_BALLOON=y
> # CONFIG_VIRTIO_INPUT is not set
> # CONFIG_VIRTIO_MMIO is not set
> 
> #
> # Microsoft Hyper-V guest support
> #
> # CONFIG_STAGING is not set
> # CONFIG_CHROME_PLATFORMS is not set
> # CONFIG_MELLANOX_PLATFORM is not set
> CONFIG_CLKDEV_LOOKUP=y
> CONFIG_HAVE_CLK_PREPARE=y
> CONFIG_COMMON_CLK=y
> 
> #
> # Common Clock Framework
> #
> # CONFIG_COMMON_CLK_WM831X is not set
> # CONFIG_COMMON_CLK_VERSATILE is not set
> # CONFIG_CLK_HSDK is not set
> # CONFIG_COMMON_CLK_MAX77686 is not set
> CONFIG_COMMON_CLK_MAX9485=y
> # CONFIG_COMMON_CLK_HI655X is not set
> # CONFIG_COMMON_CLK_SCMI is not set
> # CONFIG_COMMON_CLK_SCPI is not set
> CONFIG_COMMON_CLK_SI5351=y
> CONFIG_COMMON_CLK_SI514=y
> # CONFIG_COMMON_CLK_SI544 is not set
> CONFIG_COMMON_CLK_SI570=y
> # CONFIG_COMMON_CLK_CDCE706 is not set
> # CONFIG_COMMON_CLK_CDCE925 is not set
> CONFIG_COMMON_CLK_CS2000_CP=y
> # CONFIG_COMMON_CLK_GEMINI is not set
> # CONFIG_COMMON_CLK_ASPEED is not set
> CONFIG_COMMON_CLK_S2MPS11=y
> CONFIG_COMMON_CLK_AXI_CLKGEN=y
> # CONFIG_CLK_QORIQ is not set
> CONFIG_COMMON_CLK_XGENE=y
> # CONFIG_COMMON_CLK_OXNAS is not set
> CONFIG_COMMON_CLK_VC5=y
> # CONFIG_CLK_ACTIONS is not set
> # CONFIG_CLK_BCM_63XX is not set
> # CONFIG_CLK_BCM_KONA is not set
> # CONFIG_CLK_BCM_CYGNUS is not set
> # CONFIG_CLK_BCM_HR2 is not set
> # CONFIG_CLK_BCM_NSP is not set
> # CONFIG_CLK_BCM_NS2 is not set
> # CONFIG_CLK_BCM_SR is not set
> # CONFIG_COMMON_CLK_HI3516CV300 is not set
> # CONFIG_COMMON_CLK_HI3519 is not set
> # CONFIG_COMMON_CLK_HI3660 is not set
> # CONFIG_COMMON_CLK_HI3798CV200 is not set
> # CONFIG_COMMON_CLK_HI6220 is not set
> # CONFIG_RESET_HISI is not set
> # CONFIG_STUB_CLK_HI6220 is not set
> # CONFIG_STUB_CLK_HI3660 is not set
> # CONFIG_COMMON_CLK_BOSTON is not set
> # CONFIG_COMMON_CLK_KEYSTONE is not set
> 
> #
> # Clock driver for MediaTek SoC
> #
> # CONFIG_COMMON_CLK_MT2701 is not set
> # CONFIG_COMMON_CLK_MT2712 is not set
> # CONFIG_COMMON_CLK_MT6797 is not set
> # CONFIG_COMMON_CLK_MT7622 is not set
> # CONFIG_COMMON_CLK_MT8135 is not set
> # CONFIG_COMMON_CLK_MT8173 is not set
> # CONFIG_COMMON_CLK_QCOM is not set
> # CONFIG_SPMI_PMIC_CLKDIV is not set
> # CONFIG_CLK_RENESAS is not set
> # CONFIG_COMMON_CLK_SAMSUNG is not set
> # CONFIG_S3C2410_COMMON_CLK is not set
> # CONFIG_S3C2412_COMMON_CLK is not set
> # CONFIG_S3C2443_COMMON_CLK is not set
> # CONFIG_SPRD_COMMON_CLK is not set
> # CONFIG_SUNXI_CCU is not set
> # CONFIG_COMMON_CLK_TI_ADPLL is not set
> # CONFIG_CLK_UNIPHIER is not set
> # CONFIG_HWSPINLOCK is not set
> 
> #
> # Clock Source drivers
> #
> CONFIG_TIMER_OF=y
> CONFIG_TIMER_PROBE=y
> # CONFIG_BCM2835_TIMER is not set
> # CONFIG_BCM_KONA_TIMER is not set
> # CONFIG_DIGICOLOR_TIMER is not set
> # CONFIG_DW_APB_TIMER is not set
> # CONFIG_FTTMR010_TIMER is not set
> # CONFIG_MESON6_TIMER is not set
> # CONFIG_OWL_TIMER is not set
> # CONFIG_SUN4I_TIMER is not set
> # CONFIG_SUN5I_HSTIMER is not set
> # CONFIG_VT8500_TIMER is not set
> # CONFIG_NPCM7XX_TIMER is not set
> # CONFIG_CADENCE_TTC_TIMER is not set
> # CONFIG_ASM9260_TIMER is not set
> # CONFIG_CLKSRC_DBX500_PRCMU is not set
> # CONFIG_CLPS711X_TIMER is not set
> # CONFIG_ATLAS7_TIMER is not set
> # CONFIG_MXS_TIMER is not set
> # CONFIG_PRIMA2_TIMER is not set
> # CONFIG_NSPIRE_TIMER is not set
> # CONFIG_INTEGRATOR_AP_TIMER is not set
> # CONFIG_CLKSRC_PISTACHIO is not set
> # CONFIG_ARMV7M_SYSTICK is not set
> # CONFIG_ATMEL_ST is not set
> # CONFIG_CLKSRC_SAMSUNG_PWM is not set
> # CONFIG_FSL_FTM_TIMER is not set
> # CONFIG_OXNAS_RPS_TIMER is not set
> # CONFIG_MTK_TIMER is not set
> # CONFIG_SPRD_TIMER is not set
> # CONFIG_CLKSRC_JCORE_PIT is not set
> # CONFIG_SH_TIMER_CMT is not set
> # CONFIG_SH_TIMER_MTU2 is not set
> # CONFIG_RENESAS_OSTM is not set
> # CONFIG_SH_TIMER_TMU is not set
> # CONFIG_EM_TIMER_STI is not set
> # CONFIG_CLKSRC_PXA is not set
> # CONFIG_H8300_TMR8 is not set
> # CONFIG_H8300_TMR16 is not set
> # CONFIG_H8300_TPU is not set
> # CONFIG_CLKSRC_ST_LPC is not set
> # CONFIG_ATCPIT100_TIMER is not set
> CONFIG_RISCV_TIMER=y
> CONFIG_MAILBOX=y
> # CONFIG_IMX_MBOX is not set
> CONFIG_PLATFORM_MHU=y
> # CONFIG_ROCKCHIP_MBOX is not set
> CONFIG_ALTERA_MBOX=y
> # CONFIG_HI3660_MBOX is not set
> # CONFIG_HI6220_MBOX is not set
> # CONFIG_MAILBOX_TEST is not set
> # CONFIG_QCOM_APCS_IPC is not set
> # CONFIG_BCM_PDC_MBOX is not set
> # CONFIG_MTK_CMDQ_MBOX is not set
> CONFIG_IOMMU_SUPPORT=y
> 
> #
> # Generic IOMMU Pagetable Support
> #
> # CONFIG_IOMMU_IO_PGTABLE_LPAE is not set
> # CONFIG_IOMMU_IO_PGTABLE_ARMV7S is not set
> # CONFIG_IOMMU_DEBUGFS is not set
> # CONFIG_QCOM_IOMMU is not set
> 
> #
> # Remoteproc drivers
> #
> # CONFIG_REMOTEPROC is not set
> 
> #
> # Rpmsg drivers
> #
> CONFIG_RPMSG=y
> CONFIG_RPMSG_CHAR=y
> # CONFIG_RPMSG_QCOM_GLINK_RPM is not set
> CONFIG_RPMSG_VIRTIO=y
> 
> #
> # SOC (System On Chip) specific Drivers
> #
> 
> #
> # Amlogic SoC drivers
> #
> # CONFIG_MESON_GX_SOCINFO is not set
> # CONFIG_MESON_MX_SOCINFO is not set
> # CONFIG_AT91_SOC_ID is not set
> 
> #
> # Broadcom SoC drivers
> #
> # CONFIG_SOC_BRCMSTB is not set
> 
> #
> # NXP/Freescale QorIQ SoC drivers
> #
> 
> #
> # i.MX SoC drivers
> #
> 
> #
> # MediaTek SoC drivers
> #
> # CONFIG_MTK_INFRACFG is not set
> # CONFIG_MTK_PMIC_WRAP is not set
> # CONFIG_MTK_SCPSYS is not set
> 
> #
> # Qualcomm SoC drivers
> #
> # CONFIG_QCOM_GENI_SE is not set
> # CONFIG_QCOM_RPMH is not set
> # CONFIG_SOC_RENESAS is not set
> # CONFIG_ROCKCHIP_GRF is not set
> # CONFIG_SOC_SAMSUNG is not set
> # CONFIG_SOC_TI is not set
> # CONFIG_UX500_SOC_ID is not set
> 
> #
> # Xilinx SoC drivers
> #
> CONFIG_XILINX_VCU=y
> # CONFIG_SOC_ZTE is not set
> # CONFIG_PM_DEVFREQ is not set
> CONFIG_EXTCON=y
> 
> #
> # Extcon Device Drivers
> #
> CONFIG_EXTCON_ADC_JACK=y
> # CONFIG_EXTCON_GPIO is not set
> CONFIG_EXTCON_MAX3355=y
> # CONFIG_EXTCON_MAX77693 is not set
> # CONFIG_EXTCON_MAX77843 is not set
> # CONFIG_EXTCON_MAX8997 is not set
> # CONFIG_EXTCON_QCOM_SPMI_MISC is not set
> CONFIG_EXTCON_RT8973A=y
> CONFIG_EXTCON_SM5502=y
> CONFIG_EXTCON_USB_GPIO=y
> CONFIG_MEMORY=y
> CONFIG_JZ4780_NEMC=y
> # CONFIG_SAMSUNG_MC is not set
> CONFIG_IIO=y
> CONFIG_IIO_BUFFER=y
> CONFIG_IIO_BUFFER_CB=y
> CONFIG_IIO_BUFFER_HW_CONSUMER=y
> CONFIG_IIO_KFIFO_BUF=y
> CONFIG_IIO_TRIGGERED_BUFFER=y
> CONFIG_IIO_CONFIGFS=y
> CONFIG_IIO_TRIGGER=y
> CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
> CONFIG_IIO_SW_DEVICE=y
> # CONFIG_IIO_SW_TRIGGER is not set
> CONFIG_IIO_TRIGGERED_EVENT=y
> 
> #
> # Accelerometers
> #
> CONFIG_ADIS16201=y
> CONFIG_ADIS16209=y
> CONFIG_ADXL345=y
> CONFIG_ADXL345_I2C=y
> # CONFIG_ADXL345_SPI is not set
> # CONFIG_BMA180 is not set
> CONFIG_BMA220=y
> # CONFIG_BMC150_ACCEL is not set
> # CONFIG_DA280 is not set
> CONFIG_DA311=y
> CONFIG_DMARD06=y
> CONFIG_DMARD09=y
> # CONFIG_DMARD10 is not set
> CONFIG_HID_SENSOR_ACCEL_3D=y
> # CONFIG_IIO_CROS_EC_ACCEL_LEGACY is not set
> CONFIG_KXSD9=y
> # CONFIG_KXSD9_SPI is not set
> CONFIG_KXSD9_I2C=y
> # CONFIG_KXCJK1013 is not set
> CONFIG_MC3230=y
> CONFIG_MMA7455=y
> CONFIG_MMA7455_I2C=y
> CONFIG_MMA7455_SPI=y
> # CONFIG_MMA7660 is not set
> CONFIG_MMA8452=y
> CONFIG_MMA9551_CORE=y
> # CONFIG_MMA9551 is not set
> CONFIG_MMA9553=y
> CONFIG_MXC4005=y
> CONFIG_MXC6255=y
> # CONFIG_SCA3000 is not set
> CONFIG_STK8312=y
> # CONFIG_STK8BA50 is not set
> 
> #
> # Analog to digital converters
> #
> CONFIG_AD_SIGMA_DELTA=y
> CONFIG_AD7266=y
> # CONFIG_AD7291 is not set
> # CONFIG_AD7298 is not set
> # CONFIG_AD7476 is not set
> CONFIG_AD7766=y
> # CONFIG_AD7791 is not set
> CONFIG_AD7793=y
> CONFIG_AD7887=y
> # CONFIG_AD7923 is not set
> CONFIG_AD799X=y
> # CONFIG_ASPEED_ADC is not set
> # CONFIG_AT91_SAMA5D2_ADC is not set
> CONFIG_AXP20X_ADC=y
> # CONFIG_AXP288_ADC is not set
> # CONFIG_BCM_IPROC_ADC is not set
> CONFIG_CC10001_ADC=y
> CONFIG_CPCAP_ADC=y
> CONFIG_DA9150_GPADC=y
> # CONFIG_ENVELOPE_DETECTOR is not set
> # CONFIG_EXYNOS_ADC is not set
> CONFIG_HI8435=y
> # CONFIG_HX711 is not set
> # CONFIG_IMX7D_ADC is not set
> CONFIG_LP8788_ADC=y
> # CONFIG_LPC18XX_ADC is not set
> # CONFIG_LPC32XX_ADC is not set
> CONFIG_LTC2471=y
> CONFIG_LTC2485=y
> CONFIG_LTC2497=y
> CONFIG_MAX1027=y
> CONFIG_MAX11100=y
> # CONFIG_MAX1118 is not set
> CONFIG_MAX1363=y
> CONFIG_MAX9611=y
> CONFIG_MCP320X=y
> # CONFIG_MCP3422 is not set
> # CONFIG_MEDIATEK_MT6577_AUXADC is not set
> # CONFIG_MESON_SARADC is not set
> CONFIG_NAU7802=y
> CONFIG_QCOM_VADC_COMMON=y
> # CONFIG_QCOM_SPMI_IADC is not set
> CONFIG_QCOM_SPMI_VADC=y
> # CONFIG_RCAR_GYRO_ADC is not set
> # CONFIG_SC27XX_ADC is not set
> # CONFIG_SPEAR_ADC is not set
> # CONFIG_SD_ADC_MODULATOR is not set
> # CONFIG_STM32_ADC_CORE is not set
> # CONFIG_STM32_DFSDM_CORE is not set
> # CONFIG_STM32_DFSDM_ADC is not set
> CONFIG_TI_ADC081C=y
> # CONFIG_TI_ADC0832 is not set
> CONFIG_TI_ADC084S021=y
> CONFIG_TI_ADC12138=y
> # CONFIG_TI_ADC108S102 is not set
> # CONFIG_TI_ADC128S052 is not set
> CONFIG_TI_ADC161S626=y
> CONFIG_TI_ADS1015=y
> CONFIG_TI_ADS7950=y
> CONFIG_TI_ADS8688=y
> # CONFIG_TI_TLC4541 is not set
> CONFIG_VF610_ADC=y
> # CONFIG_XILINX_XADC is not set
> 
> #
> # Analog Front Ends
> #
> CONFIG_IIO_RESCALE=y
> 
> #
> # Amplifiers
> #
> CONFIG_AD8366=y
> 
> #
> # Chemical Sensors
> #
> CONFIG_ATLAS_PH_SENSOR=y
> CONFIG_BME680=y
> CONFIG_BME680_I2C=y
> CONFIG_BME680_SPI=y
> CONFIG_CCS811=y
> # CONFIG_IAQCORE is not set
> CONFIG_VZ89X=y
> 
> #
> # Hid Sensor IIO Common
> #
> CONFIG_HID_SENSOR_IIO_COMMON=y
> CONFIG_HID_SENSOR_IIO_TRIGGER=y
> CONFIG_IIO_MS_SENSORS_I2C=y
> 
> #
> # SSP Sensor Common
> #
> # CONFIG_IIO_SSP_SENSORS_COMMONS is not set
> CONFIG_IIO_SSP_SENSORHUB=y
> CONFIG_IIO_ST_SENSORS_I2C=y
> CONFIG_IIO_ST_SENSORS_SPI=y
> CONFIG_IIO_ST_SENSORS_CORE=y
> 
> #
> # Counters
> #
> # CONFIG_STM32_LPTIMER_CNT is not set
> 
> #
> # Digital to analog converters
> #
> # CONFIG_AD5064 is not set
> CONFIG_AD5360=y
> CONFIG_AD5380=y
> # CONFIG_AD5421 is not set
> CONFIG_AD5446=y
> # CONFIG_AD5449 is not set
> CONFIG_AD5592R_BASE=y
> CONFIG_AD5592R=y
> CONFIG_AD5593R=y
> CONFIG_AD5504=y
> # CONFIG_AD5624R_SPI is not set
> CONFIG_LTC2632=y
> # CONFIG_AD5686_SPI is not set
> # CONFIG_AD5696_I2C is not set
> CONFIG_AD5755=y
> # CONFIG_AD5758 is not set
> # CONFIG_AD5761 is not set
> # CONFIG_AD5764 is not set
> CONFIG_AD5791=y
> CONFIG_AD7303=y
> # CONFIG_AD8801 is not set
> # CONFIG_DPOT_DAC is not set
> CONFIG_DS4424=y
> # CONFIG_LPC18XX_DAC is not set
> # CONFIG_M62332 is not set
> CONFIG_MAX517=y
> CONFIG_MAX5821=y
> CONFIG_MCP4725=y
> CONFIG_MCP4922=y
> # CONFIG_STM32_DAC is not set
> CONFIG_TI_DAC082S085=y
> CONFIG_TI_DAC5571=y
> CONFIG_VF610_DAC=y
> 
> #
> # IIO dummy driver
> #
> CONFIG_IIO_DUMMY_EVGEN=y
> CONFIG_IIO_SIMPLE_DUMMY=y
> CONFIG_IIO_SIMPLE_DUMMY_EVENTS=y
> CONFIG_IIO_SIMPLE_DUMMY_BUFFER=y
> 
> #
> # Frequency Synthesizers DDS/PLL
> #
> 
> #
> # Clock Generator/Distribution
> #
> # CONFIG_AD9523 is not set
> 
> #
> # Phase-Locked Loop (PLL) frequency synthesizers
> #
> # CONFIG_ADF4350 is not set
> 
> #
> # Digital gyroscope sensors
> #
> # CONFIG_ADIS16080 is not set
> CONFIG_ADIS16130=y
> CONFIG_ADIS16136=y
> # CONFIG_ADIS16260 is not set
> CONFIG_ADXRS450=y
> # CONFIG_BMG160 is not set
> CONFIG_HID_SENSOR_GYRO_3D=y
> # CONFIG_MPU3050_I2C is not set
> CONFIG_IIO_ST_GYRO_3AXIS=y
> CONFIG_IIO_ST_GYRO_I2C_3AXIS=y
> CONFIG_IIO_ST_GYRO_SPI_3AXIS=y
> # CONFIG_ITG3200 is not set
> 
> #
> # Health Sensors
> #
> 
> #
> # Heart Rate Monitors
> #
> CONFIG_AFE4403=y
> CONFIG_AFE4404=y
> # CONFIG_MAX30100 is not set
> # CONFIG_MAX30102 is not set
> 
> #
> # Humidity sensors
> #
> CONFIG_AM2315=y
> CONFIG_DHT11=y
> CONFIG_HDC100X=y
> # CONFIG_HID_SENSOR_HUMIDITY is not set
> CONFIG_HTS221=y
> CONFIG_HTS221_I2C=y
> CONFIG_HTS221_SPI=y
> CONFIG_HTU21=y
> CONFIG_SI7005=y
> CONFIG_SI7020=y
> 
> #
> # Inertial measurement units
> #
> CONFIG_ADIS16400=y
> CONFIG_ADIS16480=y
> CONFIG_BMI160=y
> CONFIG_BMI160_I2C=y
> # CONFIG_BMI160_SPI is not set
> # CONFIG_KMX61 is not set
> CONFIG_INV_MPU6050_IIO=y
> # CONFIG_INV_MPU6050_I2C is not set
> CONFIG_INV_MPU6050_SPI=y
> CONFIG_IIO_ST_LSM6DSX=y
> CONFIG_IIO_ST_LSM6DSX_I2C=y
> CONFIG_IIO_ST_LSM6DSX_SPI=y
> CONFIG_IIO_ADIS_LIB=y
> CONFIG_IIO_ADIS_LIB_BUFFER=y
> 
> #
> # Light sensors
> #
> CONFIG_ADJD_S311=y
> # CONFIG_AL3320A is not set
> CONFIG_APDS9300=y
> CONFIG_APDS9960=y
> CONFIG_BH1750=y
> CONFIG_BH1780=y
> CONFIG_CM32181=y
> # CONFIG_CM3232 is not set
> CONFIG_CM3323=y
> CONFIG_CM3605=y
> # CONFIG_CM36651 is not set
> CONFIG_GP2AP020A00F=y
> CONFIG_SENSORS_ISL29018=y
> CONFIG_SENSORS_ISL29028=y
> CONFIG_ISL29125=y
> # CONFIG_HID_SENSOR_ALS is not set
> CONFIG_HID_SENSOR_PROX=y
> CONFIG_JSA1212=y
> CONFIG_RPR0521=y
> # CONFIG_SENSORS_LM3533 is not set
> CONFIG_LTR501=y
> # CONFIG_LV0104CS is not set
> # CONFIG_MAX44000 is not set
> CONFIG_OPT3001=y
> CONFIG_PA12203001=y
> CONFIG_SI1133=y
> # CONFIG_SI1145 is not set
> # CONFIG_STK3310 is not set
> CONFIG_ST_UVIS25=y
> CONFIG_ST_UVIS25_I2C=y
> CONFIG_ST_UVIS25_SPI=y
> # CONFIG_TCS3414 is not set
> # CONFIG_TCS3472 is not set
> CONFIG_SENSORS_TSL2563=y
> # CONFIG_TSL2583 is not set
> CONFIG_TSL2772=y
> CONFIG_TSL4531=y
> # CONFIG_US5182D is not set
> CONFIG_VCNL4000=y
> CONFIG_VEML6070=y
> CONFIG_VL6180=y
> CONFIG_ZOPT2201=y
> 
> #
> # Magnetometer sensors
> #
> CONFIG_AK8974=y
> CONFIG_AK8975=y
> # CONFIG_AK09911 is not set
> CONFIG_BMC150_MAGN=y
> CONFIG_BMC150_MAGN_I2C=y
> CONFIG_BMC150_MAGN_SPI=y
> CONFIG_MAG3110=y
> CONFIG_HID_SENSOR_MAGNETOMETER_3D=y
> CONFIG_MMC35240=y
> CONFIG_IIO_ST_MAGN_3AXIS=y
> CONFIG_IIO_ST_MAGN_I2C_3AXIS=y
> CONFIG_IIO_ST_MAGN_SPI_3AXIS=y
> CONFIG_SENSORS_HMC5843=y
> CONFIG_SENSORS_HMC5843_I2C=y
> CONFIG_SENSORS_HMC5843_SPI=y
> 
> #
> # Multiplexers
> #
> CONFIG_IIO_MUX=y
> 
> #
> # Inclinometer sensors
> #
> CONFIG_HID_SENSOR_INCLINOMETER_3D=y
> CONFIG_HID_SENSOR_DEVICE_ROTATION=y
> 
> #
> # Triggers - standalone
> #
> # CONFIG_IIO_INTERRUPT_TRIGGER is not set
> # CONFIG_IIO_STM32_LPTIMER_TRIGGER is not set
> # CONFIG_IIO_STM32_TIMER_TRIGGER is not set
> CONFIG_IIO_SYSFS_TRIGGER=y
> 
> #
> # Digital potentiometers
> #
> # CONFIG_AD5272 is not set
> CONFIG_DS1803=y
> CONFIG_MAX5481=y
> CONFIG_MAX5487=y
> # CONFIG_MCP4018 is not set
> CONFIG_MCP4131=y
> # CONFIG_MCP4531 is not set
> CONFIG_TPL0102=y
> 
> #
> # Digital potentiostats
> #
> CONFIG_LMP91000=y
> 
> #
> # Pressure sensors
> #
> CONFIG_ABP060MG=y
> CONFIG_BMP280=y
> CONFIG_BMP280_I2C=y
> CONFIG_BMP280_SPI=y
> CONFIG_HID_SENSOR_PRESS=y
> CONFIG_HP03=y
> # CONFIG_MPL115_I2C is not set
> # CONFIG_MPL115_SPI is not set
> # CONFIG_MPL3115 is not set
> CONFIG_MS5611=y
> CONFIG_MS5611_I2C=y
> CONFIG_MS5611_SPI=y
> # CONFIG_MS5637 is not set
> # CONFIG_IIO_ST_PRESS is not set
> CONFIG_T5403=y
> # CONFIG_HP206C is not set
> # CONFIG_ZPA2326 is not set
> 
> #
> # Lightning sensors
> #
> CONFIG_AS3935=y
> 
> #
> # Proximity and distance sensors
> #
> CONFIG_ISL29501=y
> CONFIG_LIDAR_LITE_V2=y
> CONFIG_RFD77402=y
> CONFIG_SRF04=y
> # CONFIG_SX9500 is not set
> CONFIG_SRF08=y
> 
> #
> # Resolver to digital converters
> #
> CONFIG_AD2S1200=y
> 
> #
> # Temperature sensors
> #
> CONFIG_MAXIM_THERMOCOUPLE=y
> # CONFIG_HID_SENSOR_TEMP is not set
> CONFIG_MLX90614=y
> CONFIG_MLX90632=y
> # CONFIG_TMP006 is not set
> CONFIG_TMP007=y
> CONFIG_TSYS01=y
> # CONFIG_TSYS02D is not set
> # CONFIG_PWM is not set
> 
> #
> # IRQ chip support
> #
> CONFIG_IRQCHIP=y
> CONFIG_ARM_GIC_MAX_NR=1
> # CONFIG_JCORE_AIC is not set
> # CONFIG_TS4800_IRQ is not set
> # CONFIG_IRQ_UNIPHIER_AIDET is not set
> CONFIG_SIFIVE_PLIC=y
> # CONFIG_IPACK_BUS is not set
> CONFIG_RESET_CONTROLLER=y
> # CONFIG_RESET_ATH79 is not set
> # CONFIG_RESET_AXS10X is not set
> # CONFIG_RESET_BERLIN is not set
> # CONFIG_RESET_HSDK is not set
> # CONFIG_RESET_IMX7 is not set
> # CONFIG_RESET_LANTIQ is not set
> # CONFIG_RESET_LPC18XX is not set
> # CONFIG_RESET_MESON is not set
> # CONFIG_RESET_MESON_AUDIO_ARB is not set
> # CONFIG_RESET_PISTACHIO is not set
> # CONFIG_RESET_QCOM_AOSS is not set
> # CONFIG_RESET_SIMPLE is not set
> # CONFIG_RESET_STM32MP157 is not set
> # CONFIG_RESET_SUNXI is not set
> # CONFIG_RESET_TI_SYSCON is not set
> # CONFIG_RESET_UNIPHIER is not set
> # CONFIG_RESET_UNIPHIER_USB3 is not set
> # CONFIG_RESET_ZYNQ is not set
> # CONFIG_COMMON_RESET_HI3660 is not set
> # CONFIG_COMMON_RESET_HI6220 is not set
> # CONFIG_FMC is not set
> 
> #
> # PHY Subsystem
> #
> CONFIG_GENERIC_PHY=y
> # CONFIG_PHY_LPC18XX_USB_OTG is not set
> # CONFIG_PHY_XGENE is not set
> # CONFIG_PHY_MESON8B_USB2 is not set
> # CONFIG_PHY_MESON_GXL_USB2 is not set
> # CONFIG_PHY_MESON_GXL_USB3 is not set
> # CONFIG_PHY_CYGNUS_PCIE is not set
> CONFIG_BCM_KONA_USB2_PHY=y
> # CONFIG_PHY_BCM_NS_USB2 is not set
> # CONFIG_PHY_BCM_NS_USB3 is not set
> # CONFIG_PHY_NS2_USB_DRD is not set
> # CONFIG_PHY_BRCM_SATA is not set
> # CONFIG_PHY_BCM_SR_PCIE is not set
> # CONFIG_PHY_HI6220_USB is not set
> # CONFIG_PHY_HISTB_COMBPHY is not set
> # CONFIG_PHY_HISI_INNO_USB2 is not set
> # CONFIG_PHY_LANTIQ_RCU_USB2 is not set
> # CONFIG_ARMADA375_USBCLUSTER_PHY is not set
> # CONFIG_PHY_MVEBU_CP110_COMPHY is not set
> # CONFIG_PHY_PXA_28NM_HSIC is not set
> CONFIG_PHY_PXA_28NM_USB2=y
> CONFIG_PHY_CPCAP_USB=y
> CONFIG_PHY_MAPPHONE_MDM6600=y
> CONFIG_PHY_ATH79_USB=y
> # CONFIG_PHY_QCOM_QMP is not set
> # CONFIG_PHY_QCOM_QUSB2 is not set
> CONFIG_PHY_QCOM_USB_HS=y
> # CONFIG_PHY_QCOM_USB_HSIC is not set
> # CONFIG_PHY_RALINK_USB is not set
> # CONFIG_PHY_RCAR_GEN3_USB3 is not set
> # CONFIG_PHY_ROCKCHIP_INNO_USB2 is not set
> # CONFIG_PHY_ROCKCHIP_PCIE is not set
> # CONFIG_PHY_ROCKCHIP_TYPEC is not set
> # CONFIG_PHY_EXYNOS_DP_VIDEO is not set
> # CONFIG_PHY_EXYNOS_MIPI_VIDEO is not set
> # CONFIG_PHY_EXYNOS_PCIE is not set
> # CONFIG_PHY_ST_SPEAR1310_MIPHY is not set
> # CONFIG_PHY_ST_SPEAR1340_MIPHY is not set
> # CONFIG_PHY_STIH407_USB is not set
> # CONFIG_PHY_STM32_USBPHYC is not set
> # CONFIG_OMAP_CONTROL_PHY is not set
> CONFIG_PHY_TUSB1210=y
> CONFIG_POWERCAP=y
> # CONFIG_MCB is not set
> CONFIG_RAS=y
> 
> #
> # Android
> #
> # CONFIG_ANDROID is not set
> CONFIG_DAX=y
> CONFIG_NVMEM=y
> # CONFIG_NVMEM_IMX_IIM is not set
> # CONFIG_NVMEM_IMX_OCOTP is not set
> # CONFIG_NVMEM_LPC18XX_EEPROM is not set
> # CONFIG_NVMEM_LPC18XX_OTP is not set
> # CONFIG_NVMEM_MXS_OCOTP is not set
> # CONFIG_MTK_EFUSE is not set
> # CONFIG_QCOM_QFPROM is not set
> # CONFIG_ROCKCHIP_EFUSE is not set
> # CONFIG_NVMEM_BCM_OCOTP is not set
> # CONFIG_UNIPHIER_EFUSE is not set
> # CONFIG_NVMEM_VF610_OCOTP is not set
> # CONFIG_MESON_MX_EFUSE is not set
> # CONFIG_NVMEM_SNVS_LPGPR is not set
> # CONFIG_RAVE_SP_EEPROM is not set
> # CONFIG_SC27XX_EFUSE is not set
> 
> #
> # HW tracing support
> #
> CONFIG_STM=y
> CONFIG_STM_DUMMY=y
> CONFIG_STM_SOURCE_CONSOLE=y
> CONFIG_STM_SOURCE_HEARTBEAT=y
> CONFIG_STM_SOURCE_FTRACE=y
> CONFIG_INTEL_TH=y
> CONFIG_INTEL_TH_GTH=y
> CONFIG_INTEL_TH_STH=y
> CONFIG_INTEL_TH_MSU=y
> CONFIG_INTEL_TH_PTI=y
> # CONFIG_INTEL_TH_DEBUG is not set
> # CONFIG_FPGA is not set
> CONFIG_FSI=y
> CONFIG_FSI_NEW_DEV_NODE=y
> # CONFIG_FSI_MASTER_GPIO is not set
> CONFIG_FSI_MASTER_HUB=y
> CONFIG_FSI_SCOM=y
> CONFIG_FSI_SBEFIFO=y
> # CONFIG_TEE is not set
> CONFIG_MULTIPLEXER=y
> 
> #
> # Multiplexer drivers
> #
> # CONFIG_MUX_ADG792A is not set
> CONFIG_MUX_ADGS1408=y
> CONFIG_MUX_GPIO=y
> # CONFIG_MUX_MMIO is not set
> CONFIG_SIOX=y
> CONFIG_SIOX_BUS_GPIO=y
> CONFIG_SLIMBUS=y
> CONFIG_SLIM_QCOM_CTRL=y
> 
> #
> # File systems
> #
> CONFIG_FS_POSIX_ACL=y
> CONFIG_EXPORTFS_BLOCK_OPS=y
> CONFIG_FILE_LOCKING=y
> CONFIG_MANDATORY_FILE_LOCKING=y
> # CONFIG_FS_ENCRYPTION is not set
> CONFIG_FSNOTIFY=y
> # CONFIG_DNOTIFY is not set
> CONFIG_INOTIFY_USER=y
> CONFIG_FANOTIFY=y
> CONFIG_QUOTA=y
> CONFIG_QUOTA_NETLINK_INTERFACE=y
> CONFIG_PRINT_QUOTA_WARNING=y
> CONFIG_QUOTA_DEBUG=y
> CONFIG_QUOTA_TREE=y
> CONFIG_QFMT_V1=y
> CONFIG_QFMT_V2=y
> CONFIG_QUOTACTL=y
> CONFIG_AUTOFS4_FS=y
> CONFIG_AUTOFS_FS=y
> CONFIG_FUSE_FS=y
> CONFIG_CUSE=y
> # CONFIG_OVERLAY_FS is not set
> 
> #
> # Caches
> #
> CONFIG_FSCACHE=y
> # CONFIG_FSCACHE_STATS is not set
> # CONFIG_FSCACHE_HISTOGRAM is not set
> # CONFIG_FSCACHE_DEBUG is not set
> # CONFIG_FSCACHE_OBJECT_LIST is not set
> 
> #
> # Pseudo filesystems
> #
> CONFIG_PROC_FS=y
> # CONFIG_PROC_KCORE is not set
> CONFIG_PROC_SYSCTL=y
> CONFIG_PROC_PAGE_MONITOR=y
> # CONFIG_PROC_CHILDREN is not set
> CONFIG_KERNFS=y
> CONFIG_SYSFS=y
> # CONFIG_TMPFS is not set
> CONFIG_CONFIGFS_FS=y
> # CONFIG_MISC_FILESYSTEMS is not set
> # CONFIG_NETWORK_FILESYSTEMS is not set
> CONFIG_NLS=y
> CONFIG_NLS_DEFAULT="iso8859-1"
> CONFIG_NLS_CODEPAGE_437=y
> # CONFIG_NLS_CODEPAGE_737 is not set
> CONFIG_NLS_CODEPAGE_775=y
> CONFIG_NLS_CODEPAGE_850=y
> CONFIG_NLS_CODEPAGE_852=y
> CONFIG_NLS_CODEPAGE_855=y
> CONFIG_NLS_CODEPAGE_857=y
> CONFIG_NLS_CODEPAGE_860=y
> CONFIG_NLS_CODEPAGE_861=y
> CONFIG_NLS_CODEPAGE_862=y
> CONFIG_NLS_CODEPAGE_863=y
> # CONFIG_NLS_CODEPAGE_864 is not set
> CONFIG_NLS_CODEPAGE_865=y
> CONFIG_NLS_CODEPAGE_866=y
> CONFIG_NLS_CODEPAGE_869=y
> CONFIG_NLS_CODEPAGE_936=y
> # CONFIG_NLS_CODEPAGE_950 is not set
> CONFIG_NLS_CODEPAGE_932=y
> CONFIG_NLS_CODEPAGE_949=y
> CONFIG_NLS_CODEPAGE_874=y
> CONFIG_NLS_ISO8859_8=y
> # CONFIG_NLS_CODEPAGE_1250 is not set
> # CONFIG_NLS_CODEPAGE_1251 is not set
> # CONFIG_NLS_ASCII is not set
> CONFIG_NLS_ISO8859_1=y
> # CONFIG_NLS_ISO8859_2 is not set
> CONFIG_NLS_ISO8859_3=y
> # CONFIG_NLS_ISO8859_4 is not set
> CONFIG_NLS_ISO8859_5=y
> CONFIG_NLS_ISO8859_6=y
> CONFIG_NLS_ISO8859_7=y
> # CONFIG_NLS_ISO8859_9 is not set
> CONFIG_NLS_ISO8859_13=y
> CONFIG_NLS_ISO8859_14=y
> CONFIG_NLS_ISO8859_15=y
> CONFIG_NLS_KOI8_R=y
> CONFIG_NLS_KOI8_U=y
> # CONFIG_NLS_MAC_ROMAN is not set
> CONFIG_NLS_MAC_CELTIC=y
> # CONFIG_NLS_MAC_CENTEURO is not set
> # CONFIG_NLS_MAC_CROATIAN is not set
> CONFIG_NLS_MAC_CYRILLIC=y
> # CONFIG_NLS_MAC_GAELIC is not set
> CONFIG_NLS_MAC_GREEK=y
> CONFIG_NLS_MAC_ICELAND=y
> CONFIG_NLS_MAC_INUIT=y
> CONFIG_NLS_MAC_ROMANIAN=y
> CONFIG_NLS_MAC_TURKISH=y
> CONFIG_NLS_UTF8=y
> CONFIG_DLM=y
> # CONFIG_DLM_DEBUG is not set
> 
> #
> # Security options
> #
> CONFIG_KEYS=y
> # CONFIG_PERSISTENT_KEYRINGS is not set
> CONFIG_TRUSTED_KEYS=y
> # CONFIG_ENCRYPTED_KEYS is not set
> CONFIG_KEY_DH_OPERATIONS=y
> CONFIG_SECURITY_DMESG_RESTRICT=y
> CONFIG_SECURITYFS=y
> CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
> # CONFIG_HARDENED_USERCOPY is not set
> # CONFIG_STATIC_USERMODEHELPER is not set
> CONFIG_DEFAULT_SECURITY_DAC=y
> CONFIG_DEFAULT_SECURITY=""
> CONFIG_CRYPTO=y
> 
> #
> # Crypto core or helper
> #
> CONFIG_CRYPTO_ALGAPI=y
> CONFIG_CRYPTO_ALGAPI2=y
> CONFIG_CRYPTO_AEAD=y
> CONFIG_CRYPTO_AEAD2=y
> CONFIG_CRYPTO_BLKCIPHER=y
> CONFIG_CRYPTO_BLKCIPHER2=y
> CONFIG_CRYPTO_HASH=y
> CONFIG_CRYPTO_HASH2=y
> CONFIG_CRYPTO_RNG=y
> CONFIG_CRYPTO_RNG2=y
> CONFIG_CRYPTO_RNG_DEFAULT=y
> CONFIG_CRYPTO_AKCIPHER2=y
> CONFIG_CRYPTO_AKCIPHER=y
> CONFIG_CRYPTO_KPP2=y
> CONFIG_CRYPTO_KPP=y
> CONFIG_CRYPTO_ACOMP2=y
> CONFIG_CRYPTO_RSA=y
> CONFIG_CRYPTO_DH=y
> CONFIG_CRYPTO_ECDH=y
> CONFIG_CRYPTO_MANAGER=y
> CONFIG_CRYPTO_MANAGER2=y
> # CONFIG_CRYPTO_USER is not set
> CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
> CONFIG_CRYPTO_GF128MUL=y
> CONFIG_CRYPTO_NULL=y
> CONFIG_CRYPTO_NULL2=y
> # CONFIG_CRYPTO_PCRYPT is not set
> CONFIG_CRYPTO_WORKQUEUE=y
> CONFIG_CRYPTO_CRYPTD=y
> # CONFIG_CRYPTO_MCRYPTD is not set
> CONFIG_CRYPTO_AUTHENC=y
> 
> #
> # Authenticated Encryption with Associated Data
> #
> CONFIG_CRYPTO_CCM=y
> CONFIG_CRYPTO_GCM=y
> CONFIG_CRYPTO_CHACHA20POLY1305=y
> CONFIG_CRYPTO_AEGIS128=y
> # CONFIG_CRYPTO_AEGIS128L is not set
> # CONFIG_CRYPTO_AEGIS256 is not set
> # CONFIG_CRYPTO_MORUS640 is not set
> # CONFIG_CRYPTO_MORUS1280 is not set
> CONFIG_CRYPTO_SEQIV=y
> CONFIG_CRYPTO_ECHAINIV=y
> 
> #
> # Block modes
> #
> CONFIG_CRYPTO_CBC=y
> CONFIG_CRYPTO_CFB=y
> CONFIG_CRYPTO_CTR=y
> CONFIG_CRYPTO_CTS=y
> CONFIG_CRYPTO_ECB=y
> # CONFIG_CRYPTO_LRW is not set
> CONFIG_CRYPTO_PCBC=y
> # CONFIG_CRYPTO_XTS is not set
> # CONFIG_CRYPTO_KEYWRAP is not set
> 
> #
> # Hash modes
> #
> CONFIG_CRYPTO_CMAC=y
> CONFIG_CRYPTO_HMAC=y
> # CONFIG_CRYPTO_XCBC is not set
> CONFIG_CRYPTO_VMAC=y
> 
> #
> # Digest
> #
> CONFIG_CRYPTO_CRC32C=y
> CONFIG_CRYPTO_CRC32=y
> CONFIG_CRYPTO_CRCT10DIF=y
> CONFIG_CRYPTO_GHASH=y
> CONFIG_CRYPTO_POLY1305=y
> # CONFIG_CRYPTO_MD4 is not set
> CONFIG_CRYPTO_MD5=y
> CONFIG_CRYPTO_MICHAEL_MIC=y
> # CONFIG_CRYPTO_RMD128 is not set
> CONFIG_CRYPTO_RMD160=y
> # CONFIG_CRYPTO_RMD256 is not set
> # CONFIG_CRYPTO_RMD320 is not set
> CONFIG_CRYPTO_SHA1=y
> CONFIG_CRYPTO_SHA256=y
> CONFIG_CRYPTO_SHA512=y
> CONFIG_CRYPTO_SHA3=y
> CONFIG_CRYPTO_SM3=y
> # CONFIG_CRYPTO_TGR192 is not set
> # CONFIG_CRYPTO_WP512 is not set
> 
> #
> # Ciphers
> #
> CONFIG_CRYPTO_AES=y
> # CONFIG_CRYPTO_AES_TI is not set
> # CONFIG_CRYPTO_ANUBIS is not set
> # CONFIG_CRYPTO_ARC4 is not set
> CONFIG_CRYPTO_BLOWFISH=y
> CONFIG_CRYPTO_BLOWFISH_COMMON=y
> # CONFIG_CRYPTO_CAMELLIA is not set
> CONFIG_CRYPTO_CAST_COMMON=y
> CONFIG_CRYPTO_CAST5=y
> CONFIG_CRYPTO_CAST6=y
> CONFIG_CRYPTO_DES=y
> CONFIG_CRYPTO_FCRYPT=y
> # CONFIG_CRYPTO_KHAZAD is not set
> # CONFIG_CRYPTO_SALSA20 is not set
> CONFIG_CRYPTO_CHACHA20=y
> # CONFIG_CRYPTO_SEED is not set
> CONFIG_CRYPTO_SERPENT=y
> CONFIG_CRYPTO_SM4=y
> # CONFIG_CRYPTO_TEA is not set
> CONFIG_CRYPTO_TWOFISH=y
> CONFIG_CRYPTO_TWOFISH_COMMON=y
> 
> #
> # Compression
> #
> CONFIG_CRYPTO_DEFLATE=y
> # CONFIG_CRYPTO_LZO is not set
> # CONFIG_CRYPTO_842 is not set
> # CONFIG_CRYPTO_LZ4 is not set
> CONFIG_CRYPTO_LZ4HC=y
> CONFIG_CRYPTO_ZSTD=y
> 
> #
> # Random Number Generation
> #
> CONFIG_CRYPTO_ANSI_CPRNG=y
> CONFIG_CRYPTO_DRBG_MENU=y
> CONFIG_CRYPTO_DRBG_HMAC=y
> # CONFIG_CRYPTO_DRBG_HASH is not set
> # CONFIG_CRYPTO_DRBG_CTR is not set
> CONFIG_CRYPTO_DRBG=y
> CONFIG_CRYPTO_JITTERENTROPY=y
> CONFIG_CRYPTO_USER_API=y
> # CONFIG_CRYPTO_USER_API_HASH is not set
> # CONFIG_CRYPTO_USER_API_SKCIPHER is not set
> # CONFIG_CRYPTO_USER_API_RNG is not set
> CONFIG_CRYPTO_USER_API_AEAD=y
> CONFIG_CRYPTO_HASH_INFO=y
> # CONFIG_CRYPTO_HW is not set
> CONFIG_ASYMMETRIC_KEY_TYPE=y
> CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
> CONFIG_X509_CERTIFICATE_PARSER=y
> # CONFIG_PKCS7_MESSAGE_PARSER is not set
> 
> #
> # Certificates for signature checking
> #
> # CONFIG_SYSTEM_TRUSTED_KEYRING is not set
> # CONFIG_SYSTEM_BLACKLIST_KEYRING is not set
> CONFIG_BINARY_PRINTF=y
> 
> #
> # Library routines
> #
> CONFIG_BITREVERSE=y
> CONFIG_RATIONAL=y
> CONFIG_GENERIC_STRNCPY_FROM_USER=y
> CONFIG_GENERIC_STRNLEN_USER=y
> CONFIG_GENERIC_NET_UTILS=y
> CONFIG_GENERIC_PCI_IOMAP=y
> CONFIG_CRC_CCITT=y
> CONFIG_CRC16=y
> # CONFIG_CRC_T10DIF is not set
> CONFIG_CRC_ITU_T=y
> CONFIG_CRC32=y
> CONFIG_CRC32_SELFTEST=y
> # CONFIG_CRC32_SLICEBY8 is not set
> # CONFIG_CRC32_SLICEBY4 is not set
> CONFIG_CRC32_SARWATE=y
> # CONFIG_CRC32_BIT is not set
> # CONFIG_CRC64 is not set
> CONFIG_CRC4=y
> CONFIG_CRC7=y
> CONFIG_LIBCRC32C=y
> CONFIG_CRC8=y
> CONFIG_XXHASH=y
> CONFIG_AUDIT_GENERIC=y
> # CONFIG_RANDOM32_SELFTEST is not set
> CONFIG_ZLIB_INFLATE=y
> CONFIG_ZLIB_DEFLATE=y
> CONFIG_LZ4HC_COMPRESS=y
> CONFIG_LZ4_DECOMPRESS=y
> CONFIG_ZSTD_COMPRESS=y
> CONFIG_ZSTD_DECOMPRESS=y
> # CONFIG_XZ_DEC is not set
> CONFIG_GENERIC_ALLOCATOR=y
> CONFIG_ASSOCIATIVE_ARRAY=y
> CONFIG_HAS_IOMEM=y
> CONFIG_HAS_IOPORT_MAP=y
> CONFIG_HAS_DMA=y
> CONFIG_NEED_DMA_MAP_STATE=y
> CONFIG_ARCH_DMA_ADDR_T_64BIT=y
> CONFIG_HAVE_GENERIC_DMA_COHERENT=y
> CONFIG_DMA_DIRECT_OPS=y
> CONFIG_SWIOTLB=y
> CONFIG_SGL_ALLOC=y
> CONFIG_CPU_RMAP=y
> CONFIG_DQL=y
> CONFIG_GLOB=y
> # CONFIG_GLOB_SELFTEST is not set
> CONFIG_NLATTR=y
> CONFIG_CLZ_TAB=y
> CONFIG_CORDIC=y
> # CONFIG_DDR is not set
> CONFIG_IRQ_POLL=y
> CONFIG_MPILIB=y
> CONFIG_LIBFDT=y
> CONFIG_OID_REGISTRY=y
> CONFIG_STACKDEPOT=y
> # CONFIG_PARMAN is not set
> # CONFIG_STRING_SELFTEST is not set
> 
> #
> # Kernel hacking
> #
> 
> #
> # printk and dmesg options
> #
> CONFIG_PRINTK_TIME=y
> CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
> CONFIG_CONSOLE_LOGLEVEL_QUIET=4
> CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
> CONFIG_BOOT_PRINTK_DELAY=y
> CONFIG_DYNAMIC_DEBUG=y
> 
> #
> # Compile-time checks and compiler options
> #
> CONFIG_ENABLE_MUST_CHECK=y
> CONFIG_FRAME_WARN=2048
> # CONFIG_STRIP_ASM_SYMS is not set
> CONFIG_READABLE_ASM=y
> # CONFIG_UNUSED_SYMBOLS is not set
> CONFIG_PAGE_OWNER=y
> CONFIG_DEBUG_FS=y
> CONFIG_HEADERS_CHECK=y
> CONFIG_DEBUG_SECTION_MISMATCH=y
> CONFIG_SECTION_MISMATCH_WARN_ONLY=y
> CONFIG_ARCH_WANT_FRAME_POINTERS=y
> # CONFIG_FRAME_POINTER is not set
> # CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
> # CONFIG_MAGIC_SYSRQ is not set
> CONFIG_DEBUG_KERNEL=y
> 
> #
> # Memory Debugging
> #
> CONFIG_PAGE_EXTENSION=y
> # CONFIG_DEBUG_PAGEALLOC is not set
> CONFIG_PAGE_POISONING=y
> # CONFIG_PAGE_POISONING_NO_SANITY is not set
> # CONFIG_PAGE_POISONING_ZERO is not set
> # CONFIG_DEBUG_PAGE_REF is not set
> # CONFIG_DEBUG_OBJECTS is not set
> CONFIG_SLUB_STATS=y
> CONFIG_DEBUG_STACK_USAGE=y
> CONFIG_DEBUG_VM=y
> CONFIG_DEBUG_VM_VMACACHE=y
> # CONFIG_DEBUG_VM_RB is not set
> # CONFIG_DEBUG_VM_PGFLAGS is not set
> CONFIG_DEBUG_MEMORY_INIT=y
> # CONFIG_DEBUG_PER_CPU_MAPS is not set
> CONFIG_CC_HAS_SANCOV_TRACE_PC=y
> # CONFIG_DEBUG_SHIRQ is not set
> 
> #
> # Debug Lockups and Hangs
> #
> CONFIG_LOCKUP_DETECTOR=y
> CONFIG_SOFTLOCKUP_DETECTOR=y
> CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=y
> CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=1
> # CONFIG_DETECT_HUNG_TASK is not set
> CONFIG_WQ_WATCHDOG=y
> CONFIG_PANIC_ON_OOPS=y
> CONFIG_PANIC_ON_OOPS_VALUE=1
> CONFIG_PANIC_TIMEOUT=0
> CONFIG_SCHED_DEBUG=y
> # CONFIG_SCHEDSTATS is not set
> # CONFIG_SCHED_STACK_END_CHECK is not set
> CONFIG_DEBUG_TIMEKEEPING=y
> 
> #
> # Lock Debugging (spinlocks, mutexes, etc...)
> #
> CONFIG_DEBUG_RT_MUTEXES=y
> CONFIG_DEBUG_SPINLOCK=y
> CONFIG_DEBUG_MUTEXES=y
> CONFIG_DEBUG_ATOMIC_SLEEP=y
> CONFIG_DEBUG_LOCKING_API_SELFTESTS=y
> CONFIG_LOCK_TORTURE_TEST=y
> CONFIG_WW_MUTEX_SELFTEST=y
> CONFIG_TRACE_IRQFLAGS=y
> CONFIG_STACKTRACE=y
> # CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
> # CONFIG_DEBUG_KOBJECT is not set
> # CONFIG_DEBUG_LIST is not set
> # CONFIG_DEBUG_PI_LIST is not set
> # CONFIG_DEBUG_SG is not set
> CONFIG_DEBUG_NOTIFIERS=y
> # CONFIG_DEBUG_CREDENTIALS is not set
> 
> #
> # RCU Debugging
> #
> CONFIG_TORTURE_TEST=y
> # CONFIG_RCU_PERF_TEST is not set
> CONFIG_RCU_TORTURE_TEST=y
> CONFIG_RCU_CPU_STALL_TIMEOUT=21
> # CONFIG_RCU_TRACE is not set
> # CONFIG_RCU_EQS_DEBUG is not set
> CONFIG_DEBUG_WQ_FORCE_RR_CPU=y
> CONFIG_NOTIFIER_ERROR_INJECTION=y
> CONFIG_OF_RECONFIG_NOTIFIER_ERROR_INJECT=y
> # CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
> # CONFIG_FAULT_INJECTION is not set
> # CONFIG_LATENCYTOP is not set
> CONFIG_NOP_TRACER=y
> CONFIG_HAVE_FUNCTION_TRACER=y
> CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
> CONFIG_HAVE_DYNAMIC_FTRACE=y
> CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
> CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
> CONFIG_TRACER_MAX_TRACE=y
> CONFIG_TRACE_CLOCK=y
> CONFIG_RING_BUFFER=y
> CONFIG_EVENT_TRACING=y
> CONFIG_CONTEXT_SWITCH_TRACER=y
> CONFIG_RING_BUFFER_ALLOW_SWAP=y
> CONFIG_PREEMPTIRQ_TRACEPOINTS=y
> CONFIG_TRACING=y
> CONFIG_GENERIC_TRACER=y
> CONFIG_TRACING_SUPPORT=y
> CONFIG_FTRACE=y
> CONFIG_FUNCTION_TRACER=y
> # CONFIG_FUNCTION_GRAPH_TRACER is not set
> # CONFIG_PREEMPTIRQ_EVENTS is not set
> CONFIG_IRQSOFF_TRACER=y
> CONFIG_SCHED_TRACER=y
> CONFIG_HWLAT_TRACER=y
> CONFIG_TRACER_SNAPSHOT=y
> CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP=y
> CONFIG_TRACE_BRANCH_PROFILING=y
> # CONFIG_BRANCH_PROFILE_NONE is not set
> CONFIG_PROFILE_ANNOTATED_BRANCHES=y
> # CONFIG_PROFILE_ALL_BRANCHES is not set
> # CONFIG_BRANCH_TRACER is not set
> CONFIG_STACK_TRACER=y
> CONFIG_DYNAMIC_FTRACE=y
> CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
> # CONFIG_FUNCTION_PROFILER is not set
> CONFIG_FTRACE_MCOUNT_RECORD=y
> # CONFIG_FTRACE_STARTUP_TEST is not set
> CONFIG_TRACEPOINT_BENCHMARK=y
> CONFIG_RING_BUFFER_BENCHMARK=y
> CONFIG_RING_BUFFER_STARTUP_TEST=y
> # CONFIG_TRACE_EVAL_MAP_FILE is not set
> CONFIG_TRACING_EVENTS_GPIO=y
> CONFIG_DMA_API_DEBUG=y
> # CONFIG_DMA_API_DEBUG_SG is not set
> # CONFIG_RUNTIME_TESTING_MENU is not set
> CONFIG_MEMTEST=y
> # CONFIG_BUG_ON_DATA_CORRUPTION is not set
> # CONFIG_SAMPLES is not set
> # CONFIG_UBSAN is not set
> # CONFIG_CMDLINE_BOOL is not set
> CONFIG_EARLY_PRINTK=y

