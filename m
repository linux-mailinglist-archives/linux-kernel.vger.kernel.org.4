Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66C95661022
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 16:56:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232225AbjAGP4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 10:56:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjAGP4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 10:56:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9FE940C00
        for <linux-kernel@vger.kernel.org>; Sat,  7 Jan 2023 07:56:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2924060B21
        for <linux-kernel@vger.kernel.org>; Sat,  7 Jan 2023 15:56:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 835BBC433D2;
        Sat,  7 Jan 2023 15:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673106974;
        bh=N1Qj/DURqlazl95OoIcVVrrE1qEcRjnogYhUOB1SDoM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=G/2hgAJLCUcUj1i9megvG0/Sx7UZLs1twjVrK1EMfR/ERpjUTmoir3waQqaZhv0pp
         zf9hY5ynRyyo/eBV/Ltw6aUgH4KhFjeMiwOV32s80Fa6foKsqfqgGglRSNnXpZD7Vk
         C7EGBmjd2oWqd7N3emFniR9o9AC+sTLp7GQUY3RrUgeeOMfqo28DVCFvb81oTLGTRG
         /5wbscGaYaQ7OXvI3xUgDmfawQcrIrywJh2YCRLeHHMwW/G0hZzLj2ZftCW4M9wS0s
         8SSVIhEJCKmW2/8Apd0FItik7Q43F9Fz5MNVrjNbyvc87uwdPsLuQcz8HOXx+sQmdz
         HvG+6oDDhFFNw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 1D8175C09F1; Sat,  7 Jan 2023 07:56:14 -0800 (PST)
Date:   Sat, 7 Jan 2023 07:56:14 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [paulmck-rcu:workqueue.2023.01.06a 36/37] ERROR: modpost:
 "show_all_workqueues" [kernel/rcu/rcutorture.ko] undefined!
Message-ID: <20230107155614.GX4028633@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <202301071437.qTKn0SDP-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202301071437.qTKn0SDP-lkp@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75 autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 07, 2023 at 02:23:22PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git workqueue.2023.01.06a
> head:   1d85f95f4694b6a8eb0d4a11bdd38a92abcbe002
> commit: 0f78b75d9574dac1e48c70fa790899d02390f619 [36/37] rcutorture: Add test of show_all_workqueues()
> config: arm-randconfig-r046-20230106
> compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/commit/?id=0f78b75d9574dac1e48c70fa790899d02390f619
>         git remote add paulmck-rcu https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
>         git fetch --no-tags paulmck-rcu workqueue.2023.01.06a
>         git checkout 0f78b75d9574dac1e48c70fa790899d02390f619
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm olddefconfig
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>, old ones prefixed by <<):
> 
> WARNING: modpost: lib/test_user_copy.o: section mismatch in reference: (unknown) (section: .text.fixup) -> (unknown) (section: .init.text)
> WARNING: modpost: lib/test_user_copy.o: section mismatch in reference: (unknown) (section: .text.fixup) -> (unknown) (section: .init.text)
> WARNING: modpost: lib/test_user_copy.o: section mismatch in reference: (unknown) (section: .text.fixup) -> (unknown) (section: .init.text)
> WARNING: modpost: lib/test_user_copy.o: section mismatch in reference: (unknown) (section: .text.fixup) -> (unknown) (section: .init.text)
> WARNING: modpost: lib/test_user_copy.o: section mismatch in reference: (unknown) (section: .text.fixup) -> (unknown) (section: .init.text)
> WARNING: modpost: lib/test_user_copy.o: section mismatch in reference: (unknown) (section: .text.fixup) -> (unknown) (section: .init.text)
> WARNING: modpost: lib/test_user_copy.o: section mismatch in reference: (unknown) (section: .text.fixup) -> (unknown) (section: .init.text)
> WARNING: modpost: lib/test_user_copy.o: section mismatch in reference: (unknown) (section: .text.fixup) -> (unknown) (section: .init.text)
> WARNING: modpost: lib/test_user_copy.o: section mismatch in reference: (unknown) (section: .text.fixup) -> (unknown) (section: .init.text)
> WARNING: modpost: lib/test_user_copy.o: section mismatch in reference: (unknown) (section: .text.fixup) -> (unknown) (section: .init.text)
> WARNING: modpost: lib/test_user_copy.o: section mismatch in reference: (unknown) (section: .text.fixup) -> (unknown) (section: .init.text)
> WARNING: modpost: lib/test_user_copy.o: section mismatch in reference: (unknown) (section: .text.fixup) -> (unknown) (section: .init.text)
> >> ERROR: modpost: "show_all_workqueues" [kernel/rcu/rcutorture.ko] undefined!

Thank you for testing this!

This one is just a test, which I won't be sending to mainline, so I am
just leaving it as is.

							Thanx, Paul

> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests

> #
> # Automatically generated file; DO NOT EDIT.
> # Linux/arm 6.2.0-rc1 Kernel Configuration
> #
> CONFIG_CC_VERSION_TEXT="arm-linux-gnueabi-gcc (GCC) 12.1.0"
> CONFIG_CC_IS_GCC=y
> CONFIG_GCC_VERSION=120100
> CONFIG_CLANG_VERSION=0
> CONFIG_AS_IS_GNU=y
> CONFIG_AS_VERSION=23800
> CONFIG_LD_IS_BFD=y
> CONFIG_LD_VERSION=23800
> CONFIG_LLD_VERSION=0
> CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y
> CONFIG_CC_HAS_ASM_GOTO_TIED_OUTPUT=y
> CONFIG_CC_HAS_ASM_INLINE=y
> CONFIG_CC_HAS_NO_PROFILE_FN_ATTR=y
> CONFIG_PAHOLE_VERSION=123
> CONFIG_IRQ_WORK=y
> CONFIG_THREAD_INFO_IN_TASK=y
> 
> #
> # General setup
> #
> CONFIG_BROKEN_ON_SMP=y
> CONFIG_INIT_ENV_ARG_LIMIT=32
> CONFIG_COMPILE_TEST=y
> # CONFIG_WERROR is not set
> CONFIG_LOCALVERSION=""
> CONFIG_BUILD_SALT=""
> CONFIG_HAVE_KERNEL_GZIP=y
> CONFIG_HAVE_KERNEL_LZMA=y
> CONFIG_HAVE_KERNEL_XZ=y
> CONFIG_HAVE_KERNEL_LZO=y
> CONFIG_HAVE_KERNEL_LZ4=y
> # CONFIG_KERNEL_GZIP is not set
> # CONFIG_KERNEL_LZMA is not set
> CONFIG_KERNEL_XZ=y
> # CONFIG_KERNEL_LZO is not set
> # CONFIG_KERNEL_LZ4 is not set
> CONFIG_DEFAULT_INIT=""
> CONFIG_DEFAULT_HOSTNAME="(none)"
> # CONFIG_SYSVIPC is not set
> CONFIG_WATCH_QUEUE=y
> # CONFIG_USELIB is not set
> CONFIG_HAVE_ARCH_AUDITSYSCALL=y
> 
> #
> # IRQ subsystem
> #
> CONFIG_GENERIC_IRQ_PROBE=y
> CONFIG_GENERIC_IRQ_SHOW=y
> CONFIG_GENERIC_IRQ_SHOW_LEVEL=y
> CONFIG_GENERIC_IRQ_INJECTION=y
> CONFIG_HARDIRQS_SW_RESEND=y
> CONFIG_GENERIC_IRQ_CHIP=y
> CONFIG_IRQ_DOMAIN=y
> CONFIG_IRQ_SIM=y
> CONFIG_IRQ_DOMAIN_HIERARCHY=y
> CONFIG_IRQ_FORCED_THREADING=y
> CONFIG_SPARSE_IRQ=y
> CONFIG_GENERIC_IRQ_DEBUGFS=y
> # end of IRQ subsystem
> 
> CONFIG_GENERIC_IRQ_MULTI_HANDLER=y
> CONFIG_GENERIC_CLOCKEVENTS=y
> CONFIG_TIME_KUNIT_TEST=m
> 
> #
> # Timers subsystem
> #
> CONFIG_TICK_ONESHOT=y
> CONFIG_HZ_PERIODIC=y
> # CONFIG_NO_HZ_IDLE is not set
> CONFIG_NO_HZ=y
> CONFIG_HIGH_RES_TIMERS=y
> # end of Timers subsystem
> 
> CONFIG_HAVE_EBPF_JIT=y
> 
> #
> # BPF subsystem
> #
> # CONFIG_BPF_SYSCALL is not set
> # end of BPF subsystem
> 
> CONFIG_PREEMPT_NONE_BUILD=y
> CONFIG_PREEMPT_NONE=y
> # CONFIG_PREEMPT_VOLUNTARY is not set
> # CONFIG_PREEMPT is not set
> 
> #
> # CPU/Task time and stats accounting
> #
> CONFIG_TICK_CPU_ACCOUNTING=y
> # CONFIG_VIRT_CPU_ACCOUNTING_GEN is not set
> # CONFIG_IRQ_TIME_ACCOUNTING is not set
> CONFIG_BSD_PROCESS_ACCT=y
> CONFIG_BSD_PROCESS_ACCT_V3=y
> CONFIG_PSI=y
> CONFIG_PSI_DEFAULT_DISABLED=y
> # end of CPU/Task time and stats accounting
> 
> CONFIG_CPU_ISOLATION=y
> 
> #
> # RCU Subsystem
> #
> CONFIG_TINY_RCU=y
> CONFIG_RCU_EXPERT=y
> CONFIG_TINY_SRCU=y
> CONFIG_TASKS_RCU_GENERIC=y
> CONFIG_FORCE_TASKS_RCU=y
> CONFIG_TASKS_RCU=y
> CONFIG_FORCE_TASKS_RUDE_RCU=y
> CONFIG_TASKS_RUDE_RCU=y
> # CONFIG_FORCE_TASKS_TRACE_RCU is not set
> CONFIG_RCU_NEED_SEGCBLIST=y
> # end of RCU Subsystem
> 
> CONFIG_IKCONFIG=m
> CONFIG_IKCONFIG_PROC=y
> CONFIG_IKHEADERS=y
> CONFIG_LOG_BUF_SHIFT=17
> CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
> CONFIG_PRINTK_INDEX=y
> CONFIG_GENERIC_SCHED_CLOCK=y
> 
> #
> # Scheduler features
> #
> # end of Scheduler features
> 
> CONFIG_CC_IMPLICIT_FALLTHROUGH="-Wimplicit-fallthrough=5"
> CONFIG_GCC12_NO_ARRAY_BOUNDS=y
> CONFIG_CC_NO_ARRAY_BOUNDS=y
> CONFIG_CGROUPS=y
> CONFIG_PAGE_COUNTER=y
> CONFIG_CGROUP_FAVOR_DYNMODS=y
> CONFIG_MEMCG=y
> CONFIG_MEMCG_KMEM=y
> CONFIG_BLK_CGROUP=y
> CONFIG_CGROUP_WRITEBACK=y
> # CONFIG_CGROUP_SCHED is not set
> # CONFIG_CGROUP_PIDS is not set
> CONFIG_CGROUP_RDMA=y
> CONFIG_CGROUP_FREEZER=y
> # CONFIG_CGROUP_DEVICE is not set
> CONFIG_CGROUP_CPUACCT=y
> # CONFIG_CGROUP_PERF is not set
> CONFIG_CGROUP_MISC=y
> CONFIG_CGROUP_DEBUG=y
> # CONFIG_NAMESPACES is not set
> CONFIG_CHECKPOINT_RESTORE=y
> # CONFIG_SCHED_AUTOGROUP is not set
> # CONFIG_SYSFS_DEPRECATED is not set
> # CONFIG_RELAY is not set
> CONFIG_BLK_DEV_INITRD=y
> CONFIG_INITRAMFS_SOURCE=""
> # CONFIG_RD_GZIP is not set
> CONFIG_RD_BZIP2=y
> # CONFIG_RD_LZMA is not set
> CONFIG_RD_XZ=y
> CONFIG_RD_LZO=y
> CONFIG_RD_LZ4=y
> # CONFIG_RD_ZSTD is not set
> # CONFIG_BOOT_CONFIG is not set
> # CONFIG_INITRAMFS_PRESERVE_MTIME is not set
> CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
> # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
> CONFIG_LD_ORPHAN_WARN=y
> CONFIG_LD_ORPHAN_WARN_LEVEL="warn"
> CONFIG_SYSCTL=y
> CONFIG_HAVE_UID16=y
> CONFIG_EXPERT=y
> CONFIG_UID16=y
> CONFIG_MULTIUSER=y
> # CONFIG_SGETMASK_SYSCALL is not set
> CONFIG_SYSFS_SYSCALL=y
> CONFIG_FHANDLE=y
> CONFIG_POSIX_TIMERS=y
> CONFIG_PRINTK=y
> # CONFIG_BUG is not set
> CONFIG_BASE_FULL=y
> # CONFIG_FUTEX is not set
> # CONFIG_EPOLL is not set
> CONFIG_SIGNALFD=y
> # CONFIG_TIMERFD is not set
> CONFIG_EVENTFD=y
> # CONFIG_AIO is not set
> CONFIG_IO_URING=y
> CONFIG_ADVISE_SYSCALLS=y
> CONFIG_MEMBARRIER=y
> CONFIG_KALLSYMS=y
> # CONFIG_KALLSYMS_SELFTEST is not set
> CONFIG_KALLSYMS_ALL=y
> CONFIG_KALLSYMS_BASE_RELATIVE=y
> CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
> CONFIG_KCMP=y
> CONFIG_RSEQ=y
> CONFIG_DEBUG_RSEQ=y
> CONFIG_EMBEDDED=y
> CONFIG_HAVE_PERF_EVENTS=y
> CONFIG_PERF_USE_VMALLOC=y
> # CONFIG_PC104 is not set
> 
> #
> # Kernel Performance Events And Counters
> #
> CONFIG_PERF_EVENTS=y
> CONFIG_DEBUG_PERF_USE_VMALLOC=y
> # end of Kernel Performance Events And Counters
> 
> CONFIG_SYSTEM_DATA_VERIFICATION=y
> CONFIG_PROFILING=y
> # end of General setup
> 
> CONFIG_ARM=y
> CONFIG_SYS_SUPPORTS_APM_EMULATION=y
> CONFIG_NO_IOPORT_MAP=y
> CONFIG_STACKTRACE_SUPPORT=y
> CONFIG_LOCKDEP_SUPPORT=y
> CONFIG_GENERIC_HWEIGHT=y
> CONFIG_GENERIC_CALIBRATE_DELAY=y
> CONFIG_ARCH_SUPPORTS_UPROBES=y
> CONFIG_PHYS_OFFSET=0x00800000
> CONFIG_PGTABLE_LEVELS=2
> 
> #
> # System Type
> #
> # CONFIG_MMU is not set
> CONFIG_ARM_SINGLE_ARMV7M=y
> CONFIG_ARCH_MMAP_RND_BITS_MIN=8
> CONFIG_ARCH_MMAP_RND_BITS_MAX=16
> CONFIG_ARCH_AT91=y
> # CONFIG_SOC_SAMV7 is not set
> 
> #
> # Clocksource driver selection
> #
> # CONFIG_ATMEL_CLOCKSOURCE_TCB is not set
> # CONFIG_MICROCHIP_CLOCKSOURCE_PIT64B is not set
> CONFIG_COMMON_CLK_AT91=y
> # CONFIG_ARCH_MXC is not set
> CONFIG_ARCH_STM32=y
> CONFIG_MACH_STM32F429=y
> CONFIG_MACH_STM32F469=y
> CONFIG_MACH_STM32F746=y
> # CONFIG_MACH_STM32F769 is not set
> CONFIG_MACH_STM32H743=y
> CONFIG_ARCH_LPC18XX=y
> # CONFIG_ARCH_MPS2 is not set
> 
> #
> # Processor Type
> #
> CONFIG_CPU_V7M=y
> CONFIG_CPU_THUMBONLY=y
> CONFIG_CPU_THUMB_CAPABLE=y
> CONFIG_CPU_32v7M=y
> CONFIG_CPU_ABRT_NOMMU=y
> CONFIG_CPU_PABRT_LEGACY=y
> CONFIG_CPU_CACHE_NOP=y
> CONFIG_CPU_CACHE_V7M=y
> CONFIG_CPU_V7M_NUM_IRQ=90
> 
> #
> # Processor Features
> #
> CONFIG_ARM_THUMB=y
> # CONFIG_CPU_LITTLE_ENDIAN is not set
> CONFIG_CPU_BIG_ENDIAN=y
> CONFIG_CPU_ENDIAN_BE8=y
> CONFIG_CPU_ICACHE_DISABLE=y
> # CONFIG_CPU_DCACHE_DISABLE is not set
> # CONFIG_CPU_BPREDICT_DISABLE is not set
> CONFIG_ARM_L1_CACHE_SHIFT=5
> # CONFIG_ARM_DMA_MEM_BUFFERABLE is not set
> CONFIG_SET_MEM_PARAM=y
> CONFIG_DRAM_BASE=0x00800000
> CONFIG_DRAM_SIZE=0x00800000
> # CONFIG_REMAP_VECTORS_TO_RAM is not set
> # CONFIG_ARM_MPU is not set
> # end of System Type
> 
> #
> # Bus support
> #
> # end of Bus support
> 
> #
> # Kernel Features
> #
> CONFIG_IRQSTACKS=y
> CONFIG_PAGE_OFFSET=0x00800000
> CONFIG_HZ_FIXED=0
> # CONFIG_HZ_100 is not set
> # CONFIG_HZ_200 is not set
> # CONFIG_HZ_250 is not set
> CONFIG_HZ_300=y
> # CONFIG_HZ_500 is not set
> # CONFIG_HZ_1000 is not set
> CONFIG_HZ=300
> CONFIG_SCHED_HRTICK=y
> CONFIG_THUMB2_KERNEL=y
> CONFIG_AEABI=y
> CONFIG_ARCH_SELECT_MEMORY_MODEL=y
> CONFIG_ARCH_FLATMEM_ENABLE=y
> CONFIG_ARCH_SPARSEMEM_ENABLE=y
> CONFIG_ARM_MODULE_PLTS=y
> CONFIG_ARCH_FORCE_MAX_ORDER=11
> # CONFIG_PARAVIRT is not set
> # CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
> CONFIG_CC_HAVE_STACKPROTECTOR_TLS=y
> # end of Kernel Features
> 
> #
> # Boot options
> #
> CONFIG_USE_OF=y
> CONFIG_ATAGS=y
> CONFIG_UNUSED_BOARD_FILES=y
> CONFIG_DEPRECATED_PARAM_STRUCT=y
> CONFIG_ZBOOT_ROM_TEXT=0x0
> CONFIG_ZBOOT_ROM_BSS=0x0
> CONFIG_ARM_APPENDED_DTB=y
> # CONFIG_ARM_ATAG_DTB_COMPAT is not set
> CONFIG_CMDLINE=""
> # CONFIG_XIP_KERNEL is not set
> # CONFIG_CRASH_DUMP is not set
> CONFIG_AUTO_ZRELADDR=y
> # end of Boot options
> 
> #
> # CPU Power Management
> #
> 
> #
> # CPU Frequency scaling
> #
> # CONFIG_CPU_FREQ is not set
> # end of CPU Frequency scaling
> 
> #
> # CPU Idle
> #
> # CONFIG_CPU_IDLE is not set
> # end of CPU Idle
> # end of CPU Power Management
> 
> #
> # Floating point emulation
> #
> 
> #
> # At least one emulation must be selected
> #
> # end of Floating point emulation
> 
> #
> # Power management options
> #
> CONFIG_SUSPEND=y
> CONFIG_SUSPEND_FREEZER=y
> CONFIG_SUSPEND_SKIP_SYNC=y
> CONFIG_PM_SLEEP=y
> # CONFIG_PM_AUTOSLEEP is not set
> # CONFIG_PM_USERSPACE_AUTOSLEEP is not set
> # CONFIG_PM_WAKELOCKS is not set
> CONFIG_PM=y
> # CONFIG_PM_DEBUG is not set
> CONFIG_APM_EMULATION=m
> CONFIG_PM_CLK=y
> CONFIG_PM_GENERIC_DOMAINS=y
> CONFIG_WQ_POWER_EFFICIENT_DEFAULT=y
> CONFIG_PM_GENERIC_DOMAINS_SLEEP=y
> CONFIG_PM_GENERIC_DOMAINS_OF=y
> CONFIG_CPU_PM=y
> CONFIG_ARCH_SUSPEND_POSSIBLE=y
> CONFIG_ARM_CPU_SUSPEND=y
> # end of Power management options
> 
> CONFIG_AS_VFP_VMRS_FPINST=y
> 
> #
> # General architecture-dependent options
> #
> CONFIG_ARCH_USE_BUILTIN_BSWAP=y
> CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
> CONFIG_HAVE_NMI=y
> CONFIG_HAVE_ARCH_TRACEHOOK=y
> CONFIG_GENERIC_SMP_IDLE_THREAD=y
> CONFIG_GENERIC_IDLE_POLL_SETUP=y
> CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
> CONFIG_ARCH_HAS_KEEPINITRD=y
> CONFIG_ARCH_HAS_SET_MEMORY=y
> CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
> CONFIG_ARCH_32BIT_OFF_T=y
> CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
> CONFIG_HAVE_RSEQ=y
> CONFIG_HAVE_PERF_REGS=y
> CONFIG_HAVE_PERF_USER_STACK_DUMP=y
> CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
> CONFIG_ARCH_WANT_IPC_PARSE_VERSION=y
> CONFIG_HAVE_ARCH_SECCOMP=y
> CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
> CONFIG_SECCOMP=y
> CONFIG_HAVE_STACKPROTECTOR=y
> # CONFIG_STACKPROTECTOR is not set
> CONFIG_LTO_NONE=y
> CONFIG_HAVE_CONTEXT_TRACKING_USER=y
> CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
> CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
> CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
> CONFIG_MODULES_USE_ELF_REL=y
> CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
> CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK=y
> CONFIG_SOFTIRQ_ON_OWN_STACK=y
> CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
> CONFIG_HAVE_EXIT_THREAD=y
> CONFIG_PAGE_SIZE_LESS_THAN_64KB=y
> CONFIG_PAGE_SIZE_LESS_THAN_256KB=y
> CONFIG_CLONE_BACKWARDS=y
> CONFIG_OLD_SIGSUSPEND3=y
> CONFIG_OLD_SIGACTION=y
> CONFIG_COMPAT_32BIT_TIME=y
> # CONFIG_LOCK_EVENT_COUNTS is not set
> CONFIG_ARCH_WANT_LD_ORPHAN_WARN=y
> CONFIG_HAVE_ARCH_PFN_VALID=y
> 
> #
> # GCOV-based kernel profiling
> #
> # CONFIG_GCOV_KERNEL is not set
> CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
> # end of GCOV-based kernel profiling
> 
> CONFIG_HAVE_GCC_PLUGINS=y
> # CONFIG_GCC_PLUGINS is not set
> CONFIG_FUNCTION_ALIGNMENT=0
> # end of General architecture-dependent options
> 
> CONFIG_RT_MUTEXES=y
> CONFIG_BASE_SMALL=0
> CONFIG_MODULES=y
> # CONFIG_MODULE_FORCE_LOAD is not set
> # CONFIG_MODULE_UNLOAD is not set
> # CONFIG_MODVERSIONS is not set
> # CONFIG_MODULE_SRCVERSION_ALL is not set
> # CONFIG_MODULE_SIG is not set
> # CONFIG_MODULE_COMPRESS_NONE is not set
> # CONFIG_MODULE_COMPRESS_GZIP is not set
> CONFIG_MODULE_COMPRESS_XZ=y
> # CONFIG_MODULE_COMPRESS_ZSTD is not set
> CONFIG_MODULE_DECOMPRESS=y
> # CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
> CONFIG_MODPROBE_PATH="/sbin/modprobe"
> CONFIG_MODULES_TREE_LOOKUP=y
> CONFIG_BLOCK=y
> CONFIG_BLOCK_LEGACY_AUTOLOAD=y
> CONFIG_BLK_CGROUP_RWSTAT=y
> CONFIG_BLK_DEV_BSG_COMMON=y
> CONFIG_BLK_ICQ=y
> CONFIG_BLK_DEV_BSGLIB=y
> # CONFIG_BLK_DEV_INTEGRITY is not set
> CONFIG_BLK_DEV_ZONED=y
> CONFIG_BLK_DEV_THROTTLING=y
> CONFIG_BLK_DEV_THROTTLING_LOW=y
> # CONFIG_BLK_WBT is not set
> CONFIG_BLK_CGROUP_IOLATENCY=y
> # CONFIG_BLK_CGROUP_FC_APPID is not set
> # CONFIG_BLK_CGROUP_IOCOST is not set
> CONFIG_BLK_CGROUP_IOPRIO=y
> CONFIG_BLK_DEBUG_FS=y
> CONFIG_BLK_DEBUG_FS_ZONED=y
> CONFIG_BLK_SED_OPAL=y
> # CONFIG_BLK_INLINE_ENCRYPTION is not set
> 
> #
> # Partition Types
> #
> # CONFIG_PARTITION_ADVANCED is not set
> CONFIG_MSDOS_PARTITION=y
> CONFIG_EFI_PARTITION=y
> # end of Partition Types
> 
> CONFIG_BLK_MQ_VIRTIO=y
> CONFIG_BLK_PM=y
> CONFIG_BLOCK_HOLDER_DEPRECATED=y
> 
> #
> # IO Schedulers
> #
> CONFIG_MQ_IOSCHED_DEADLINE=y
> # CONFIG_MQ_IOSCHED_KYBER is not set
> CONFIG_IOSCHED_BFQ=m
> CONFIG_BFQ_GROUP_IOSCHED=y
> # CONFIG_BFQ_CGROUP_DEBUG is not set
> # end of IO Schedulers
> 
> CONFIG_ASN1=y
> CONFIG_UNINLINE_SPIN_UNLOCK=y
> CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
> CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=y
> CONFIG_FREEZER=y
> 
> #
> # Executable file formats
> #
> # CONFIG_BINFMT_ELF_FDPIC is not set
> CONFIG_BINFMT_SCRIPT=m
> CONFIG_ARCH_HAS_BINFMT_FLAT=y
> CONFIG_BINFMT_FLAT=y
> CONFIG_BINFMT_FLAT_ARGVP_ENVP_ON_STACK=y
> CONFIG_BINFMT_FLAT_OLD=y
> # CONFIG_BINFMT_ZFLAT is not set
> # CONFIG_BINFMT_MISC is not set
> # CONFIG_COREDUMP is not set
> # end of Executable file formats
> 
> #
> # Memory Management options
> #
> 
> #
> # SLAB allocator options
> #
> # CONFIG_SLAB is not set
> CONFIG_SLUB=y
> # CONFIG_SLOB_DEPRECATED is not set
> # CONFIG_SLUB_TINY is not set
> # CONFIG_SLAB_MERGE_DEFAULT is not set
> CONFIG_SLAB_FREELIST_RANDOM=y
> # CONFIG_SLAB_FREELIST_HARDENED is not set
> # CONFIG_SLUB_STATS is not set
> # end of SLAB allocator options
> 
> CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
> CONFIG_COMPAT_BRK=y
> CONFIG_MMAP_ALLOW_UNINITIALIZED=y
> CONFIG_SELECT_MEMORY_MODEL=y
> # CONFIG_FLATMEM_MANUAL is not set
> CONFIG_SPARSEMEM_MANUAL=y
> CONFIG_SPARSEMEM=y
> CONFIG_SPARSEMEM_STATIC=y
> CONFIG_ARCH_KEEP_MEMBLOCK=y
> CONFIG_EXCLUSIVE_SYSTEM_RAM=y
> CONFIG_SPLIT_PTLOCK_CPUS=999999
> # CONFIG_PAGE_REPORTING is not set
> CONFIG_NOMMU_INITIAL_TRIM_EXCESS=1
> CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
> CONFIG_NEED_PER_CPU_KM=y
> CONFIG_GENERIC_EARLY_IOREMAP=y
> CONFIG_ARCH_HAS_CURRENT_STACK_POINTER=y
> # CONFIG_VM_EVENT_COUNTERS is not set
> CONFIG_PERCPU_STATS=y
> CONFIG_GUP_TEST=y
> 
> #
> # Data Access Monitoring
> #
> CONFIG_DAMON=y
> # CONFIG_DAMON_SYSFS is not set
> # end of Data Access Monitoring
> # end of Memory Management options
> 
> # CONFIG_NET is not set
> 
> #
> # Device Drivers
> #
> CONFIG_ARM_AMBA=y
> CONFIG_PCCARD=m
> # CONFIG_PCMCIA is not set
> 
> #
> # PC-card bridges
> #
> 
> #
> # Generic Driver Options
> #
> # CONFIG_UEVENT_HELPER is not set
> CONFIG_DEVTMPFS=y
> # CONFIG_DEVTMPFS_MOUNT is not set
> # CONFIG_DEVTMPFS_SAFE is not set
> CONFIG_STANDALONE=y
> # CONFIG_PREVENT_FIRMWARE_BUILD is not set
> 
> #
> # Firmware loader
> #
> CONFIG_FW_LOADER=y
> CONFIG_FW_LOADER_PAGED_BUF=y
> CONFIG_FW_LOADER_SYSFS=y
> CONFIG_EXTRA_FIRMWARE=""
> CONFIG_FW_LOADER_USER_HELPER=y
> CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
> CONFIG_FW_LOADER_COMPRESS=y
> CONFIG_FW_LOADER_COMPRESS_XZ=y
> # CONFIG_FW_LOADER_COMPRESS_ZSTD is not set
> # CONFIG_FW_CACHE is not set
> CONFIG_FW_UPLOAD=y
> # end of Firmware loader
> 
> CONFIG_WANT_DEV_COREDUMP=y
> CONFIG_ALLOW_DEV_COREDUMP=y
> CONFIG_DEV_COREDUMP=y
> # CONFIG_DEBUG_DRIVER is not set
> CONFIG_DEBUG_DEVRES=y
> # CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
> CONFIG_TEST_ASYNC_DRIVER_PROBE=m
> CONFIG_GENERIC_CPU_AUTOPROBE=y
> CONFIG_SOC_BUS=y
> CONFIG_REGMAP=y
> CONFIG_REGMAP_I2C=y
> CONFIG_REGMAP_SPI=y
> CONFIG_REGMAP_SPMI=y
> CONFIG_REGMAP_W1=m
> CONFIG_REGMAP_MMIO=y
> CONFIG_REGMAP_IRQ=y
> CONFIG_REGMAP_SOUNDWIRE=m
> CONFIG_REGMAP_SOUNDWIRE_MBQ=m
> CONFIG_REGMAP_I3C=m
> CONFIG_REGMAP_SPI_AVMM=y
> CONFIG_DMA_SHARED_BUFFER=y
> # CONFIG_DMA_FENCE_TRACE is not set
> # end of Generic Driver Options
> 
> #
> # Bus devices
> #
> # CONFIG_ARM_INTEGRATOR_LM is not set
> # CONFIG_BRCMSTB_GISB_ARB is not set
> # CONFIG_BT1_APB is not set
> # CONFIG_BT1_AXI is not set
> # CONFIG_MOXTET is not set
> # CONFIG_HISILICON_LPC is not set
> # CONFIG_INTEL_IXP4XX_EB is not set
> # CONFIG_QCOM_EBI2 is not set
> CONFIG_VEXPRESS_CONFIG=m
> # CONFIG_FSL_MC_BUS is not set
> # CONFIG_MHI_BUS is not set
> CONFIG_MHI_BUS_EP=m
> # end of Bus devices
> 
> #
> # Firmware Drivers
> #
> 
> #
> # ARM System Control and Management Interface Protocol
> #
> CONFIG_ARM_SCMI_PROTOCOL=m
> CONFIG_ARM_SCMI_HAVE_TRANSPORT=y
> CONFIG_ARM_SCMI_HAVE_SHMEM=y
> CONFIG_ARM_SCMI_TRANSPORT_MAILBOX=y
> # CONFIG_ARM_SCMI_TRANSPORT_VIRTIO is not set
> # CONFIG_ARM_SCMI_POWER_DOMAIN is not set
> CONFIG_ARM_SCMI_POWER_CONTROL=m
> # end of ARM System Control and Management Interface Protocol
> 
> # CONFIG_ARM_SCPI_PROTOCOL is not set
> CONFIG_ARM_SCPI_POWER_DOMAIN=y
> # CONFIG_FIRMWARE_MEMMAP is not set
> # CONFIG_TURRIS_MOX_RWTM is not set
> # CONFIG_BCM47XX_NVRAM is not set
> # CONFIG_GOOGLE_FIRMWARE is not set
> 
> #
> # Tegra firmware driver
> #
> # end of Tegra firmware driver
> # end of Firmware Drivers
> 
> CONFIG_GNSS=y
> CONFIG_GNSS_USB=m
> CONFIG_MTD=m
> CONFIG_MTD_TESTS=m
> 
> #
> # Partition parsers
> #
> CONFIG_MTD_AR7_PARTS=m
> # CONFIG_MTD_BCM63XX_PARTS is not set
> # CONFIG_MTD_BRCM_U_BOOT is not set
> CONFIG_MTD_CMDLINE_PARTS=m
> CONFIG_MTD_OF_PARTS=m
> # CONFIG_MTD_OF_PARTS_BCM4908 is not set
> # CONFIG_MTD_OF_PARTS_LINKSYS_NS is not set
> # CONFIG_MTD_PARSER_IMAGETAG is not set
> CONFIG_MTD_AFS_PARTS=m
> # CONFIG_MTD_PARSER_TPLINK_SAFELOADER is not set
> # CONFIG_MTD_PARSER_TRX is not set
> # CONFIG_MTD_SHARPSL_PARTS is not set
> CONFIG_MTD_REDBOOT_PARTS=m
> CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=-1
> # CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED is not set
> CONFIG_MTD_REDBOOT_PARTS_READONLY=y
> # end of Partition parsers
> 
> #
> # User Modules And Translation Layers
> #
> CONFIG_MTD_BLKDEVS=m
> CONFIG_MTD_BLOCK=m
> CONFIG_MTD_BLOCK_RO=m
> 
> #
> # Note that in some cases UBI block is preferred. See MTD_UBI_BLOCK.
> #
> # CONFIG_FTL is not set
> # CONFIG_NFTL is not set
> # CONFIG_INFTL is not set
> # CONFIG_RFD_FTL is not set
> # CONFIG_SSFDC is not set
> CONFIG_SM_FTL=m
> CONFIG_MTD_OOPS=m
> # CONFIG_MTD_PSTORE is not set
> CONFIG_MTD_PARTITIONED_MASTER=y
> 
> #
> # RAM/ROM/Flash chip drivers
> #
> CONFIG_MTD_CFI=m
> # CONFIG_MTD_JEDECPROBE is not set
> CONFIG_MTD_GEN_PROBE=m
> CONFIG_MTD_CFI_ADV_OPTIONS=y
> # CONFIG_MTD_CFI_NOSWAP is not set
> CONFIG_MTD_CFI_BE_BYTE_SWAP=y
> # CONFIG_MTD_CFI_LE_BYTE_SWAP is not set
> CONFIG_MTD_CFI_GEOMETRY=y
> # CONFIG_MTD_MAP_BANK_WIDTH_1 is not set
> CONFIG_MTD_MAP_BANK_WIDTH_2=y
> CONFIG_MTD_MAP_BANK_WIDTH_4=y
> # CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
> CONFIG_MTD_MAP_BANK_WIDTH_16=y
> CONFIG_MTD_MAP_BANK_WIDTH_32=y
> CONFIG_MTD_CFI_I1=y
> CONFIG_MTD_CFI_I2=y
> CONFIG_MTD_CFI_I4=y
> CONFIG_MTD_CFI_I8=y
> # CONFIG_MTD_OTP is not set
> # CONFIG_MTD_CFI_INTELEXT is not set
> CONFIG_MTD_CFI_AMDSTD=m
> # CONFIG_MTD_CFI_STAA is not set
> CONFIG_MTD_CFI_UTIL=m
> CONFIG_MTD_RAM=m
> CONFIG_MTD_ROM=m
> # CONFIG_MTD_ABSENT is not set
> # end of RAM/ROM/Flash chip drivers
> 
> #
> # Mapping drivers for chip access
> #
> CONFIG_MTD_COMPLEX_MAPPINGS=y
> CONFIG_MTD_PHYSMAP=m
> CONFIG_MTD_PHYSMAP_COMPAT=y
> CONFIG_MTD_PHYSMAP_START=0x8000000
> CONFIG_MTD_PHYSMAP_LEN=0
> CONFIG_MTD_PHYSMAP_BANKWIDTH=2
> CONFIG_MTD_PHYSMAP_OF=y
> # CONFIG_MTD_PHYSMAP_BT1_ROM is not set
> # CONFIG_MTD_PHYSMAP_VERSATILE is not set
> CONFIG_MTD_PHYSMAP_GEMINI=y
> CONFIG_MTD_PHYSMAP_IXP4XX=y
> # CONFIG_MTD_PHYSMAP_GPIO_ADDR is not set
> # CONFIG_MTD_SC520CDP is not set
> # CONFIG_MTD_NETSC520 is not set
> # CONFIG_MTD_TS5500 is not set
> CONFIG_MTD_PLATRAM=m
> # end of Mapping drivers for chip access
> 
> #
> # Self-contained MTD device drivers
> #
> # CONFIG_MTD_DATAFLASH is not set
> # CONFIG_MTD_MCHP23K256 is not set
> # CONFIG_MTD_MCHP48L640 is not set
> CONFIG_MTD_SPEAR_SMI=m
> # CONFIG_MTD_SST25L is not set
> CONFIG_MTD_SLRAM=m
> # CONFIG_MTD_PHRAM is not set
> CONFIG_MTD_MTDRAM=m
> CONFIG_MTDRAM_TOTAL_SIZE=4096
> CONFIG_MTDRAM_ERASE_SIZE=128
> CONFIG_MTD_BLOCK2MTD=m
> 
> #
> # Disk-On-Chip Device Drivers
> #
> CONFIG_MTD_DOCG3=m
> CONFIG_BCH_CONST_M=14
> CONFIG_BCH_CONST_T=4
> # end of Self-contained MTD device drivers
> 
> #
> # NAND
> #
> CONFIG_MTD_NAND_CORE=m
> CONFIG_MTD_ONENAND=m
> # CONFIG_MTD_ONENAND_VERIFY_WRITE is not set
> CONFIG_MTD_ONENAND_GENERIC=m
> # CONFIG_MTD_ONENAND_SAMSUNG is not set
> CONFIG_MTD_ONENAND_OTP=y
> CONFIG_MTD_ONENAND_2X_PROGRAM=y
> CONFIG_MTD_RAW_NAND=m
> 
> #
> # Raw/parallel NAND flash controllers
> #
> # CONFIG_MTD_NAND_DENALI_DT is not set
> CONFIG_MTD_NAND_AMS_DELTA=m
> # CONFIG_MTD_NAND_SHARPSL is not set
> CONFIG_MTD_NAND_ATMEL=m
> # CONFIG_MTD_NAND_MARVELL is not set
> # CONFIG_MTD_NAND_SLC_LPC32XX is not set
> # CONFIG_MTD_NAND_MLC_LPC32XX is not set
> # CONFIG_MTD_NAND_BRCMNAND is not set
> # CONFIG_MTD_NAND_OXNAS is not set
> # CONFIG_MTD_NAND_FSL_IFC is not set
> # CONFIG_MTD_NAND_VF610_NFC is not set
> # CONFIG_MTD_NAND_MXC is not set
> # CONFIG_MTD_NAND_SH_FLCTL is not set
> # CONFIG_MTD_NAND_DAVINCI is not set
> # CONFIG_MTD_NAND_TXX9NDFMC is not set
> # CONFIG_MTD_NAND_FSMC is not set
> # CONFIG_MTD_NAND_SUNXI is not set
> # CONFIG_MTD_NAND_HISI504 is not set
> # CONFIG_MTD_NAND_QCOM is not set
> CONFIG_MTD_NAND_MXIC=m
> # CONFIG_MTD_NAND_TEGRA is not set
> # CONFIG_MTD_NAND_STM32_FMC2 is not set
> # CONFIG_MTD_NAND_MESON is not set
> CONFIG_MTD_NAND_GPIO=m
> CONFIG_MTD_NAND_PLATFORM=m
> CONFIG_MTD_NAND_CADENCE=m
> CONFIG_MTD_NAND_ARASAN=m
> CONFIG_MTD_NAND_INTEL_LGM=m
> # CONFIG_MTD_NAND_RENESAS is not set
> 
> #
> # Misc
> #
> # CONFIG_MTD_NAND_NANDSIM is not set
> CONFIG_MTD_NAND_DISKONCHIP=m
> # CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADVANCED is not set
> CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADDRESS=0
> # CONFIG_MTD_NAND_DISKONCHIP_BBTWRITE is not set
> CONFIG_MTD_SPI_NAND=m
> 
> #
> # ECC engine support
> #
> CONFIG_MTD_NAND_ECC=y
> CONFIG_MTD_NAND_ECC_SW_HAMMING=y
> # CONFIG_MTD_NAND_ECC_SW_HAMMING_SMC is not set
> # CONFIG_MTD_NAND_ECC_SW_BCH is not set
> # CONFIG_MTD_NAND_ECC_MXIC is not set
> # CONFIG_MTD_NAND_ECC_MEDIATEK is not set
> # end of ECC engine support
> # end of NAND
> 
> #
> # LPDDR & LPDDR2 PCM memory drivers
> #
> CONFIG_MTD_LPDDR=m
> CONFIG_MTD_QINFO_PROBE=m
> CONFIG_MTD_LPDDR2_NVM=m
> # end of LPDDR & LPDDR2 PCM memory drivers
> 
> CONFIG_MTD_SPI_NOR=m
> CONFIG_MTD_SPI_NOR_USE_4K_SECTORS=y
> # CONFIG_MTD_SPI_NOR_SWP_DISABLE is not set
> CONFIG_MTD_SPI_NOR_SWP_DISABLE_ON_VOLATILE=y
> # CONFIG_MTD_SPI_NOR_SWP_KEEP is not set
> # CONFIG_SPI_HISI_SFC is not set
> # CONFIG_SPI_NXP_SPIFI is not set
> # CONFIG_MTD_UBI is not set
> CONFIG_MTD_HYPERBUS=m
> # CONFIG_HBMC_AM654 is not set
> CONFIG_DTC=y
> CONFIG_OF=y
> # CONFIG_OF_UNITTEST is not set
> # CONFIG_OF_ALL_DTBS is not set
> CONFIG_OF_FLATTREE=y
> CONFIG_OF_EARLY_FLATTREE=y
> CONFIG_OF_KOBJ=y
> CONFIG_OF_DYNAMIC=y
> CONFIG_OF_ADDRESS=y
> CONFIG_OF_IRQ=y
> CONFIG_OF_RESERVED_MEM=y
> CONFIG_OF_RESOLVE=y
> CONFIG_OF_OVERLAY=y
> CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
> CONFIG_PARPORT=m
> CONFIG_PARPORT_PC=m
> CONFIG_PARPORT_PC_FIFO=y
> CONFIG_PARPORT_PC_SUPERIO=y
> CONFIG_PARPORT_AX88796=m
> CONFIG_PARPORT_1284=y
> CONFIG_PARPORT_NOT_PC=y
> # CONFIG_BLK_DEV is not set
> 
> #
> # NVME Support
> #
> CONFIG_NVME_COMMON=m
> CONFIG_NVME_CORE=m
> CONFIG_NVME_MULTIPATH=y
> # CONFIG_NVME_VERBOSE_ERRORS is not set
> # CONFIG_NVME_HWMON is not set
> CONFIG_NVME_FABRICS=m
> CONFIG_NVME_FC=m
> # CONFIG_NVME_AUTH is not set
> CONFIG_NVME_TARGET=m
> # CONFIG_NVME_TARGET_PASSTHRU is not set
> # CONFIG_NVME_TARGET_LOOP is not set
> CONFIG_NVME_TARGET_FC=m
> CONFIG_NVME_TARGET_FCLOOP=m
> CONFIG_NVME_TARGET_AUTH=y
> # end of NVME Support
> 
> #
> # Misc devices
> #
> CONFIG_AD525X_DPOT=y
> CONFIG_AD525X_DPOT_I2C=y
> CONFIG_AD525X_DPOT_SPI=y
> # CONFIG_DUMMY_IRQ is not set
> CONFIG_ICS932S401=y
> CONFIG_ATMEL_SSC=y
> CONFIG_ENCLOSURE_SERVICES=y
> # CONFIG_SMPRO_ERRMON is not set
> # CONFIG_SMPRO_MISC is not set
> # CONFIG_GEHC_ACHC is not set
> CONFIG_HI6421V600_IRQ=y
> # CONFIG_QCOM_COINCELL is not set
> # CONFIG_QCOM_FASTRPC is not set
> # CONFIG_APDS9802ALS is not set
> CONFIG_ISL29003=m
> CONFIG_ISL29020=y
> # CONFIG_SENSORS_TSL2550 is not set
> CONFIG_SENSORS_BH1770=m
> CONFIG_SENSORS_APDS990X=m
> CONFIG_HMC6352=m
> CONFIG_DS1682=m
> CONFIG_LATTICE_ECP3_CONFIG=y
> # CONFIG_SRAM is not set
> CONFIG_XILINX_SDFEC=y
> # CONFIG_HISI_HIKEY_USB is not set
> # CONFIG_OPEN_DICE is not set
> CONFIG_VCPU_STALL_DETECTOR=y
> CONFIG_C2PORT=m
> 
> #
> # EEPROM support
> #
> CONFIG_EEPROM_AT24=y
> CONFIG_EEPROM_AT25=y
> CONFIG_EEPROM_LEGACY=y
> # CONFIG_EEPROM_MAX6875 is not set
> CONFIG_EEPROM_93CX6=m
> # CONFIG_EEPROM_93XX46 is not set
> CONFIG_EEPROM_IDT_89HPESX=y
> CONFIG_EEPROM_EE1004=m
> # end of EEPROM support
> 
> #
> # Texas Instruments shared transport line discipline
> #
> # end of Texas Instruments shared transport line discipline
> 
> # CONFIG_SENSORS_LIS3_SPI is not set
> # CONFIG_SENSORS_LIS3_I2C is not set
> CONFIG_ALTERA_STAPL=m
> # CONFIG_ECHO is not set
> # CONFIG_MISC_RTSX_USB is not set
> CONFIG_UACCE=m
> CONFIG_PVPANIC=y
> # CONFIG_PVPANIC_MMIO is not set
> # end of Misc devices
> 
> #
> # SCSI device support
> #
> CONFIG_SCSI_MOD=m
> # CONFIG_RAID_ATTRS is not set
> CONFIG_SCSI_COMMON=m
> CONFIG_SCSI=m
> CONFIG_SCSI_DMA=y
> # CONFIG_SCSI_PROC_FS is not set
> 
> #
> # SCSI support type (disk, tape, CD-ROM)
> #
> CONFIG_BLK_DEV_SD=m
> CONFIG_CHR_DEV_ST=m
> CONFIG_CHR_DEV_SG=m
> CONFIG_BLK_DEV_BSG=y
> CONFIG_CHR_DEV_SCH=m
> # CONFIG_SCSI_ENCLOSURE is not set
> # CONFIG_SCSI_CONSTANTS is not set
> # CONFIG_SCSI_LOGGING is not set
> CONFIG_SCSI_SCAN_ASYNC=y
> 
> #
> # SCSI Transports
> #
> # CONFIG_SCSI_SPI_ATTRS is not set
> CONFIG_SCSI_SAS_ATTRS=m
> CONFIG_SCSI_SAS_LIBSAS=m
> # CONFIG_SCSI_SAS_ATA is not set
> # CONFIG_SCSI_SAS_HOST_SMP is not set
> CONFIG_SCSI_SRP_ATTRS=m
> # end of SCSI Transports
> 
> # CONFIG_SCSI_LOWLEVEL is not set
> CONFIG_SCSI_DH=y
> CONFIG_SCSI_DH_RDAC=m
> # CONFIG_SCSI_DH_HP_SW is not set
> CONFIG_SCSI_DH_EMC=m
> # CONFIG_SCSI_DH_ALUA is not set
> # end of SCSI device support
> 
> CONFIG_ATA=m
> CONFIG_SATA_HOST=y
> CONFIG_ATA_VERBOSE_ERROR=y
> # CONFIG_ATA_FORCE is not set
> # CONFIG_SATA_PMP is not set
> 
> #
> # Controllers with non-SFF native interface
> #
> CONFIG_SATA_AHCI_PLATFORM=m
> # CONFIG_AHCI_BRCM is not set
> # CONFIG_AHCI_DA850 is not set
> # CONFIG_AHCI_DM816 is not set
> # CONFIG_AHCI_DWC is not set
> # CONFIG_AHCI_ST is not set
> # CONFIG_AHCI_IMX is not set
> CONFIG_AHCI_CEVA=m
> # CONFIG_AHCI_MTK is not set
> # CONFIG_AHCI_MVEBU is not set
> # CONFIG_AHCI_SUNXI is not set
> # CONFIG_AHCI_TEGRA is not set
> # CONFIG_AHCI_XGENE is not set
> CONFIG_AHCI_QORIQ=m
> # CONFIG_SATA_FSL is not set
> # CONFIG_SATA_GEMINI is not set
> # CONFIG_SATA_AHCI_SEATTLE is not set
> CONFIG_ATA_SFF=y
> 
> #
> # SFF controllers with custom DMA interface
> #
> # CONFIG_ATA_BMDMA is not set
> 
> #
> # PIO-only SFF controllers
> #
> # CONFIG_PATA_IXP4XX_CF is not set
> CONFIG_PATA_PLATFORM=m
> CONFIG_PATA_OF_PLATFORM=m
> # CONFIG_PATA_SAMSUNG_CF is not set
> 
> #
> # Generic fallback / legacy drivers
> #
> CONFIG_MD=y
> # CONFIG_BLK_DEV_MD is not set
> CONFIG_BCACHE=m
> # CONFIG_BCACHE_DEBUG is not set
> CONFIG_BCACHE_CLOSURES_DEBUG=y
> CONFIG_BCACHE_ASYNC_REGISTRATION=y
> # CONFIG_BLK_DEV_DM is not set
> # CONFIG_TARGET_CORE is not set
> 
> #
> # IEEE 1394 (FireWire) support
> #
> # CONFIG_FIREWIRE is not set
> # end of IEEE 1394 (FireWire) support
> 
> #
> # Input device support
> #
> CONFIG_INPUT=y
> # CONFIG_INPUT_LEDS is not set
> CONFIG_INPUT_FF_MEMLESS=y
> CONFIG_INPUT_SPARSEKMAP=y
> CONFIG_INPUT_MATRIXKMAP=y
> 
> #
> # Userland interfaces
> #
> # CONFIG_INPUT_MOUSEDEV is not set
> CONFIG_INPUT_JOYDEV=y
> CONFIG_INPUT_EVDEV=m
> CONFIG_INPUT_EVBUG=m
> CONFIG_INPUT_APMPOWER=m
> 
> #
> # Input Device Drivers
> #
> # CONFIG_INPUT_KEYBOARD is not set
> CONFIG_INPUT_MOUSE=y
> # CONFIG_MOUSE_PS2 is not set
> CONFIG_MOUSE_SERIAL=y
> CONFIG_MOUSE_APPLETOUCH=m
> CONFIG_MOUSE_BCM5974=m
> # CONFIG_MOUSE_CYAPA is not set
> CONFIG_MOUSE_ELAN_I2C=m
> # CONFIG_MOUSE_ELAN_I2C_I2C is not set
> CONFIG_MOUSE_ELAN_I2C_SMBUS=y
> # CONFIG_MOUSE_VSXXXAA is not set
> CONFIG_MOUSE_GPIO=y
> CONFIG_MOUSE_SYNAPTICS_I2C=y
> # CONFIG_MOUSE_SYNAPTICS_USB is not set
> # CONFIG_INPUT_JOYSTICK is not set
> # CONFIG_INPUT_TABLET is not set
> # CONFIG_INPUT_TOUCHSCREEN is not set
> CONFIG_INPUT_MISC=y
> # CONFIG_INPUT_88PM860X_ONKEY is not set
> # CONFIG_INPUT_88PM80X_ONKEY is not set
> CONFIG_INPUT_AD714X=y
> CONFIG_INPUT_AD714X_I2C=m
> CONFIG_INPUT_AD714X_SPI=y
> # CONFIG_INPUT_ARIEL_PWRBUTTON is not set
> # CONFIG_INPUT_ATC260X_ONKEY is not set
> CONFIG_INPUT_ATMEL_CAPTOUCH=m
> CONFIG_INPUT_BMA150=m
> CONFIG_INPUT_E3X0_BUTTON=m
> CONFIG_INPUT_PM8XXX_VIBRATOR=m
> # CONFIG_INPUT_PMIC8XXX_PWRKEY is not set
> # CONFIG_INPUT_MAX77650_ONKEY is not set
> CONFIG_INPUT_MAX77693_HAPTIC=m
> # CONFIG_INPUT_MMA8450 is not set
> CONFIG_INPUT_GPIO_BEEPER=m
> CONFIG_INPUT_GPIO_DECODER=m
> # CONFIG_INPUT_GPIO_VIBRA is not set
> CONFIG_INPUT_ATI_REMOTE2=m
> CONFIG_INPUT_KEYSPAN_REMOTE=m
> CONFIG_INPUT_KXTJ9=y
> # CONFIG_INPUT_POWERMATE is not set
> CONFIG_INPUT_YEALINK=y
> CONFIG_INPUT_CM109=y
> CONFIG_INPUT_REGULATOR_HAPTIC=y
> CONFIG_INPUT_RETU_PWRBUTTON=m
> CONFIG_INPUT_TPS65218_PWRBUTTON=y
> # CONFIG_INPUT_AXP20X_PEK is not set
> CONFIG_INPUT_TWL4030_PWRBUTTON=m
> CONFIG_INPUT_TWL4030_VIBRA=m
> # CONFIG_INPUT_TWL6040_VIBRA is not set
> CONFIG_INPUT_UINPUT=y
> CONFIG_INPUT_PALMAS_PWRBUTTON=y
> CONFIG_INPUT_PCF8574=m
> CONFIG_INPUT_PWM_BEEPER=m
> # CONFIG_INPUT_PWM_VIBRA is not set
> # CONFIG_INPUT_GPIO_ROTARY_ENCODER is not set
> CONFIG_INPUT_DA7280_HAPTICS=y
> CONFIG_INPUT_DA9063_ONKEY=m
> CONFIG_INPUT_WM831X_ON=y
> # CONFIG_INPUT_PCAP is not set
> # CONFIG_INPUT_ADXL34X is not set
> CONFIG_INPUT_IBM_PANEL=y
> # CONFIG_INPUT_IMS_PCU is not set
> # CONFIG_INPUT_IQS269A is not set
> CONFIG_INPUT_IQS626A=y
> CONFIG_INPUT_IQS7222=y
> # CONFIG_INPUT_CMA3000 is not set
> # CONFIG_INPUT_DRV260X_HAPTICS is not set
> CONFIG_INPUT_DRV2665_HAPTICS=m
> CONFIG_INPUT_DRV2667_HAPTICS=m
> # CONFIG_INPUT_HISI_POWERKEY is not set
> # CONFIG_INPUT_SC27XX_VIBRA is not set
> # CONFIG_INPUT_RT5120_PWRKEY is not set
> CONFIG_RMI4_CORE=y
> CONFIG_RMI4_I2C=y
> CONFIG_RMI4_SPI=m
> CONFIG_RMI4_SMB=m
> CONFIG_RMI4_F03=y
> CONFIG_RMI4_F03_SERIO=y
> CONFIG_RMI4_2D_SENSOR=y
> # CONFIG_RMI4_F11 is not set
> CONFIG_RMI4_F12=y
> # CONFIG_RMI4_F30 is not set
> # CONFIG_RMI4_F34 is not set
> CONFIG_RMI4_F3A=y
> # CONFIG_RMI4_F55 is not set
> 
> #
> # Hardware I/O ports
> #
> CONFIG_SERIO=y
> CONFIG_SERIO_SERPORT=y
> CONFIG_SERIO_PARKBD=m
> # CONFIG_SERIO_AMBAKMI is not set
> CONFIG_SERIO_LIBPS2=y
> CONFIG_SERIO_RAW=m
> CONFIG_SERIO_ALTERA_PS2=m
> # CONFIG_SERIO_PS2MULT is not set
> CONFIG_SERIO_ARC_PS2=y
> CONFIG_SERIO_APBPS2=y
> # CONFIG_SERIO_OLPC_APSP is not set
> # CONFIG_SERIO_SUN4I_PS2 is not set
> CONFIG_SERIO_GPIO_PS2=y
> CONFIG_USERIO=y
> # CONFIG_GAMEPORT is not set
> # end of Hardware I/O ports
> # end of Input device support
> 
> #
> # Character devices
> #
> CONFIG_TTY=y
> # CONFIG_VT is not set
> CONFIG_UNIX98_PTYS=y
> # CONFIG_LEGACY_PTYS is not set
> CONFIG_LEGACY_TIOCSTI=y
> CONFIG_LDISC_AUTOLOAD=y
> 
> #
> # Serial drivers
> #
> CONFIG_SERIAL_EARLYCON=y
> CONFIG_SERIAL_8250=m
> CONFIG_SERIAL_8250_DEPRECATED_OPTIONS=y
> # CONFIG_SERIAL_8250_16550A_VARIANTS is not set
> # CONFIG_SERIAL_8250_FINTEK is not set
> # CONFIG_SERIAL_8250_MEN_MCB is not set
> CONFIG_SERIAL_8250_NR_UARTS=4
> CONFIG_SERIAL_8250_RUNTIME_UARTS=4
> CONFIG_SERIAL_8250_EXTENDED=y
> # CONFIG_SERIAL_8250_MANY_PORTS is not set
> # CONFIG_SERIAL_8250_ASPEED_VUART is not set
> # CONFIG_SERIAL_8250_SHARE_IRQ is not set
> CONFIG_SERIAL_8250_DETECT_IRQ=y
> CONFIG_SERIAL_8250_RSA=y
> CONFIG_SERIAL_8250_DWLIB=y
> CONFIG_SERIAL_8250_DW=m
> # CONFIG_SERIAL_8250_EM is not set
> # CONFIG_SERIAL_8250_IOC3 is not set
> # CONFIG_SERIAL_8250_RT288X is not set
> # CONFIG_SERIAL_8250_OMAP is not set
> # CONFIG_SERIAL_8250_LPC18XX is not set
> # CONFIG_SERIAL_8250_MT6577 is not set
> # CONFIG_SERIAL_8250_UNIPHIER is not set
> # CONFIG_SERIAL_8250_INGENIC is not set
> # CONFIG_SERIAL_8250_PXA is not set
> CONFIG_SERIAL_8250_TEGRA=m
> # CONFIG_SERIAL_8250_BCM7271 is not set
> CONFIG_SERIAL_OF_PLATFORM=m
> 
> #
> # Non-8250 serial port support
> #
> # CONFIG_SERIAL_AMBA_PL010 is not set
> CONFIG_SERIAL_AMBA_PL011=m
> CONFIG_SERIAL_EARLYCON_ARM_SEMIHOST=y
> CONFIG_SERIAL_ATMEL=y
> # CONFIG_SERIAL_ATMEL_CONSOLE is not set
> CONFIG_SERIAL_ATMEL_PDC=y
> CONFIG_SERIAL_ATMEL_TTYAT=y
> # CONFIG_SERIAL_MESON is not set
> # CONFIG_SERIAL_CLPS711X is not set
> # CONFIG_SERIAL_SAMSUNG is not set
> # CONFIG_SERIAL_TEGRA is not set
> # CONFIG_SERIAL_TEGRA_TCU is not set
> # CONFIG_SERIAL_MAX3100 is not set
> CONFIG_SERIAL_MAX310X=m
> # CONFIG_SERIAL_IMX is not set
> # CONFIG_SERIAL_IMX_EARLYCON is not set
> CONFIG_SERIAL_UARTLITE=m
> CONFIG_SERIAL_UARTLITE_NR_UARTS=1
> # CONFIG_SERIAL_SH_SCI is not set
> # CONFIG_SERIAL_HS_LPC32XX is not set
> CONFIG_SERIAL_CORE=y
> CONFIG_SERIAL_CORE_CONSOLE=y
> # CONFIG_SERIAL_MSM is not set
> # CONFIG_SERIAL_VT8500 is not set
> # CONFIG_SERIAL_OMAP is not set
> # CONFIG_SERIAL_SIFIVE is not set
> # CONFIG_SERIAL_LANTIQ is not set
> # CONFIG_SERIAL_QE is not set
> CONFIG_SERIAL_SCCNXP=y
> CONFIG_SERIAL_SCCNXP_CONSOLE=y
> # CONFIG_SERIAL_SC16IS7XX is not set
> # CONFIG_SERIAL_TIMBERDALE is not set
> # CONFIG_SERIAL_BCM63XX is not set
> # CONFIG_SERIAL_ALTERA_JTAGUART is not set
> # CONFIG_SERIAL_ALTERA_UART is not set
> # CONFIG_SERIAL_MXS_AUART is not set
> CONFIG_SERIAL_XILINX_PS_UART=y
> # CONFIG_SERIAL_XILINX_PS_UART_CONSOLE is not set
> # CONFIG_SERIAL_MPS2_UART is not set
> CONFIG_SERIAL_ARC=m
> CONFIG_SERIAL_ARC_NR_PORTS=1
> # CONFIG_SERIAL_FSL_LPUART is not set
> CONFIG_SERIAL_FSL_LINFLEXUART=y
> # CONFIG_SERIAL_FSL_LINFLEXUART_CONSOLE is not set
> CONFIG_SERIAL_CONEXANT_DIGICOLOR=m
> # CONFIG_SERIAL_ST_ASC is not set
> CONFIG_SERIAL_MEN_Z135=m
> CONFIG_SERIAL_SPRD=m
> CONFIG_SERIAL_STM32=m
> # CONFIG_SERIAL_MVEBU_UART is not set
> # CONFIG_SERIAL_OWL is not set
> # CONFIG_SERIAL_RDA is not set
> # CONFIG_SERIAL_MILBEAUT_USIO is not set
> CONFIG_SERIAL_LITEUART=m
> CONFIG_SERIAL_LITEUART_MAX_PORTS=1
> # CONFIG_SERIAL_SUNPLUS is not set
> # end of Serial drivers
> 
> CONFIG_SERIAL_MCTRL_GPIO=y
> # CONFIG_SERIAL_NONSTANDARD is not set
> CONFIG_GOLDFISH_TTY=m
> CONFIG_NULL_TTY=y
> CONFIG_HVC_DRIVER=y
> CONFIG_HVC_DCC=y
> # CONFIG_RPMSG_TTY is not set
> # CONFIG_SERIAL_DEV_BUS is not set
> CONFIG_TTY_PRINTK=y
> CONFIG_TTY_PRINTK_LEVEL=6
> CONFIG_PRINTER=m
> # CONFIG_LP_CONSOLE is not set
> # CONFIG_PPDEV is not set
> CONFIG_VIRTIO_CONSOLE=y
> # CONFIG_IPMI_HANDLER is not set
> # CONFIG_ASPEED_KCS_IPMI_BMC is not set
> # CONFIG_NPCM7XX_KCS_IPMI_BMC is not set
> # CONFIG_ASPEED_BT_IPMI_BMC is not set
> # CONFIG_SSIF_IPMI_BMC is not set
> CONFIG_IPMB_DEVICE_INTERFACE=y
> CONFIG_HW_RANDOM=m
> CONFIG_HW_RANDOM_TIMERIOMEM=m
> CONFIG_HW_RANDOM_ATMEL=m
> CONFIG_HW_RANDOM_BA431=m
> CONFIG_HW_RANDOM_BCM2835=m
> CONFIG_HW_RANDOM_IPROC_RNG200=m
> CONFIG_HW_RANDOM_IXP4XX=m
> CONFIG_HW_RANDOM_OMAP=m
> CONFIG_HW_RANDOM_OMAP3_ROM=m
> CONFIG_HW_RANDOM_VIRTIO=m
> CONFIG_HW_RANDOM_IMX_RNGC=m
> CONFIG_HW_RANDOM_NOMADIK=m
> CONFIG_HW_RANDOM_STM32=m
> CONFIG_HW_RANDOM_MESON=m
> CONFIG_HW_RANDOM_MTK=m
> CONFIG_HW_RANDOM_EXYNOS=m
> CONFIG_HW_RANDOM_NPCM=m
> CONFIG_HW_RANDOM_KEYSTONE=m
> CONFIG_HW_RANDOM_CCTRNG=m
> CONFIG_HW_RANDOM_XIPHERA=m
> # CONFIG_DEVMEM is not set
> CONFIG_TCG_TPM=y
> CONFIG_TCG_TIS_CORE=m
> CONFIG_TCG_TIS=m
> # CONFIG_TCG_TIS_SPI is not set
> # CONFIG_TCG_TIS_I2C is not set
> # CONFIG_TCG_TIS_SYNQUACER is not set
> CONFIG_TCG_TIS_I2C_CR50=y
> # CONFIG_TCG_TIS_I2C_ATMEL is not set
> CONFIG_TCG_TIS_I2C_INFINEON=y
> # CONFIG_TCG_TIS_I2C_NUVOTON is not set
> CONFIG_TCG_VTPM_PROXY=m
> CONFIG_TCG_TIS_ST33ZP24=m
> CONFIG_TCG_TIS_ST33ZP24_I2C=m
> CONFIG_TCG_TIS_ST33ZP24_SPI=m
> CONFIG_XILLYBUS_CLASS=m
> CONFIG_XILLYBUS=m
> CONFIG_XILLYBUS_OF=m
> # CONFIG_XILLYUSB is not set
> # end of Character devices
> 
> #
> # I2C support
> #
> CONFIG_I2C=y
> CONFIG_I2C_BOARDINFO=y
> # CONFIG_I2C_COMPAT is not set
> CONFIG_I2C_CHARDEV=m
> CONFIG_I2C_MUX=y
> 
> #
> # Multiplexer I2C Chip support
> #
> # CONFIG_I2C_ARB_GPIO_CHALLENGE is not set
> # CONFIG_I2C_MUX_GPIO is not set
> # CONFIG_I2C_MUX_GPMUX is not set
> # CONFIG_I2C_MUX_LTC4306 is not set
> CONFIG_I2C_MUX_PCA9541=m
> # CONFIG_I2C_MUX_PCA954x is not set
> # CONFIG_I2C_MUX_PINCTRL is not set
> CONFIG_I2C_MUX_REG=y
> # CONFIG_I2C_DEMUX_PINCTRL is not set
> # CONFIG_I2C_MUX_MLXCPLD is not set
> # end of Multiplexer I2C Chip support
> 
> CONFIG_I2C_HELPER_AUTO=y
> CONFIG_I2C_SMBUS=m
> CONFIG_I2C_ALGOBIT=y
> CONFIG_I2C_ALGOPCA=m
> 
> #
> # I2C Hardware Bus support
> #
> # CONFIG_I2C_HIX5HD2 is not set
> 
> #
> # I2C system bus drivers (mostly embedded / system-on-chip)
> #
> # CONFIG_I2C_ALTERA is not set
> # CONFIG_I2C_ASPEED is not set
> CONFIG_I2C_AT91=y
> CONFIG_I2C_AT91_SLAVE_EXPERIMENTAL=m
> # CONFIG_I2C_AXXIA is not set
> # CONFIG_I2C_BCM2835 is not set
> # CONFIG_I2C_BCM_IPROC is not set
> # CONFIG_I2C_BCM_KONA is not set
> CONFIG_I2C_BRCMSTB=y
> # CONFIG_I2C_CADENCE is not set
> CONFIG_I2C_CBUS_GPIO=y
> # CONFIG_I2C_DAVINCI is not set
> # CONFIG_I2C_DESIGNWARE_PLATFORM is not set
> # CONFIG_I2C_DIGICOLOR is not set
> CONFIG_I2C_EMEV2=y
> # CONFIG_I2C_EXYNOS5 is not set
> CONFIG_I2C_GPIO=m
> CONFIG_I2C_GPIO_FAULT_INJECTOR=y
> # CONFIG_I2C_HIGHLANDER is not set
> # CONFIG_I2C_HISI is not set
> # CONFIG_I2C_IMG is not set
> # CONFIG_I2C_IMX is not set
> # CONFIG_I2C_IMX_LPI2C is not set
> # CONFIG_I2C_IOP3XX is not set
> # CONFIG_I2C_JZ4780 is not set
> # CONFIG_I2C_KEMPLD is not set
> CONFIG_I2C_LPC2K=y
> # CONFIG_I2C_MESON is not set
> # CONFIG_I2C_MICROCHIP_CORE is not set
> # CONFIG_I2C_MT65XX is not set
> # CONFIG_I2C_MT7621 is not set
> # CONFIG_I2C_MV64XXX is not set
> # CONFIG_I2C_MXS is not set
> CONFIG_I2C_NOMADIK=y
> # CONFIG_I2C_NPCM is not set
> CONFIG_I2C_OCORES=m
> # CONFIG_I2C_OMAP is not set
> # CONFIG_I2C_OWL is not set
> # CONFIG_I2C_APPLE is not set
> CONFIG_I2C_PCA_PLATFORM=m
> # CONFIG_I2C_PNX is not set
> # CONFIG_I2C_PXA is not set
> # CONFIG_I2C_QCOM_CCI is not set
> # CONFIG_I2C_QUP is not set
> # CONFIG_I2C_RIIC is not set
> CONFIG_I2C_RK3X=m
> # CONFIG_I2C_RZV2M is not set
> # CONFIG_I2C_S3C2410 is not set
> # CONFIG_I2C_SH_MOBILE is not set
> CONFIG_I2C_SIMTEC=y
> # CONFIG_I2C_SPRD is not set
> # CONFIG_I2C_ST is not set
> # CONFIG_I2C_STM32F4 is not set
> CONFIG_I2C_STM32F7=m
> # CONFIG_I2C_SUN6I_P2WI is not set
> # CONFIG_I2C_SYNQUACER is not set
> # CONFIG_I2C_TEGRA is not set
> # CONFIG_I2C_TEGRA_BPMP is not set
> # CONFIG_I2C_UNIPHIER is not set
> # CONFIG_I2C_UNIPHIER_F is not set
> # CONFIG_I2C_VERSATILE is not set
> # CONFIG_I2C_WMT is not set
> CONFIG_I2C_XILINX=m
> # CONFIG_I2C_XLP9XX is not set
> # CONFIG_I2C_RCAR is not set
> 
> #
> # External I2C/SMBus adapter drivers
> #
> # CONFIG_I2C_DIOLAN_U2C is not set
> # CONFIG_I2C_DLN2 is not set
> CONFIG_I2C_CP2615=y
> # CONFIG_I2C_PARPORT is not set
> # CONFIG_I2C_ROBOTFUZZ_OSIF is not set
> CONFIG_I2C_TAOS_EVM=y
> # CONFIG_I2C_TINY_USB is not set
> # CONFIG_I2C_VIPERBOARD is not set
> 
> #
> # Other I2C/SMBus bus drivers
> #
> # CONFIG_I2C_MLXCPLD is not set
> CONFIG_I2C_FSI=y
> CONFIG_I2C_VIRTIO=m
> # end of I2C Hardware Bus support
> 
> CONFIG_I2C_STUB=m
> CONFIG_I2C_SLAVE=y
> CONFIG_I2C_SLAVE_EEPROM=y
> CONFIG_I2C_SLAVE_TESTUNIT=m
> CONFIG_I2C_DEBUG_CORE=y
> CONFIG_I2C_DEBUG_ALGO=y
> # CONFIG_I2C_DEBUG_BUS is not set
> # end of I2C support
> 
> CONFIG_I3C=m
> CONFIG_CDNS_I3C_MASTER=m
> # CONFIG_DW_I3C_MASTER is not set
> # CONFIG_SVC_I3C_MASTER is not set
> # CONFIG_MIPI_I3C_HCI is not set
> CONFIG_SPI=y
> CONFIG_SPI_DEBUG=y
> CONFIG_SPI_MASTER=y
> CONFIG_SPI_MEM=y
> 
> #
> # SPI Master Controller Drivers
> #
> # CONFIG_SPI_ALTERA is not set
> # CONFIG_SPI_ALTERA_CORE is not set
> # CONFIG_SPI_AR934X is not set
> # CONFIG_SPI_ATH79 is not set
> # CONFIG_SPI_ARMADA_3700 is not set
> # CONFIG_SPI_ASPEED_SMC is not set
> CONFIG_SPI_ATMEL=m
> CONFIG_SPI_AT91_USART=y
> # CONFIG_SPI_ATMEL_QUADSPI is not set
> CONFIG_SPI_AXI_SPI_ENGINE=m
> # CONFIG_SPI_BCM2835 is not set
> # CONFIG_SPI_BCM2835AUX is not set
> # CONFIG_SPI_BCM63XX is not set
> # CONFIG_SPI_BCM63XX_HSSPI is not set
> # CONFIG_SPI_BCM_QSPI is not set
> CONFIG_SPI_BITBANG=y
> CONFIG_SPI_BUTTERFLY=m
> # CONFIG_SPI_CADENCE is not set
> # CONFIG_SPI_CADENCE_QUADSPI is not set
> CONFIG_SPI_CADENCE_XSPI=m
> # CONFIG_SPI_CLPS711X is not set
> CONFIG_SPI_DESIGNWARE=m
> # CONFIG_SPI_DW_DMA is not set
> CONFIG_SPI_DW_MMIO=m
> # CONFIG_SPI_DW_BT1 is not set
> # CONFIG_SPI_DLN2 is not set
> # CONFIG_SPI_EP93XX is not set
> CONFIG_SPI_FSI=m
> # CONFIG_SPI_FSL_LPSPI is not set
> # CONFIG_SPI_FSL_QUADSPI is not set
> # CONFIG_SPI_GXP is not set
> # CONFIG_SPI_HISI_KUNPENG is not set
> # CONFIG_SPI_HISI_SFC_V3XX is not set
> # CONFIG_SPI_NXP_FLEXSPI is not set
> CONFIG_SPI_GPIO=y
> # CONFIG_SPI_IMG_SPFI is not set
> # CONFIG_SPI_IMX is not set
> # CONFIG_SPI_INGENIC is not set
> # CONFIG_SPI_INTEL_PLATFORM is not set
> # CONFIG_SPI_JCORE is not set
> CONFIG_SPI_LM70_LLP=m
> # CONFIG_SPI_LP8841_RTC is not set
> CONFIG_SPI_FSL_LIB=y
> CONFIG_SPI_FSL_SPI=y
> # CONFIG_SPI_FSL_DSPI is not set
> # CONFIG_SPI_MESON_SPICC is not set
> # CONFIG_SPI_MESON_SPIFC is not set
> CONFIG_SPI_MICROCHIP_CORE=y
> # CONFIG_SPI_MICROCHIP_CORE_QSPI is not set
> # CONFIG_SPI_MT65XX is not set
> # CONFIG_SPI_MT7621 is not set
> # CONFIG_SPI_MTK_NOR is not set
> # CONFIG_SPI_WPCM_FIU is not set
> # CONFIG_SPI_NPCM_FIU is not set
> # CONFIG_SPI_NPCM_PSPI is not set
> # CONFIG_SPI_LANTIQ_SSC is not set
> CONFIG_SPI_OC_TINY=m
> # CONFIG_SPI_OMAP_UWIRE is not set
> # CONFIG_SPI_OMAP24XX is not set
> # CONFIG_SPI_TI_QSPI is not set
> # CONFIG_SPI_OMAP_100K is not set
> # CONFIG_SPI_ORION is not set
> # CONFIG_SPI_PIC32 is not set
> # CONFIG_SPI_PIC32_SQI is not set
> CONFIG_SPI_PL022=y
> # CONFIG_SPI_PXA2XX is not set
> CONFIG_SPI_ROCKCHIP=y
> # CONFIG_SPI_ROCKCHIP_SFC is not set
> # CONFIG_SPI_RSPI is not set
> # CONFIG_SPI_QUP is not set
> # CONFIG_SPI_S3C64XX is not set
> CONFIG_SPI_SC18IS602=m
> # CONFIG_SPI_SH_MSIOF is not set
> # CONFIG_SPI_SH is not set
> # CONFIG_SPI_SH_HSPI is not set
> # CONFIG_SPI_SIFIVE is not set
> # CONFIG_SPI_SLAVE_MT27XX is not set
> # CONFIG_SPI_SN_F_OSPI is not set
> # CONFIG_SPI_SPRD is not set
> # CONFIG_SPI_SPRD_ADI is not set
> # CONFIG_SPI_STM32 is not set
> # CONFIG_SPI_STM32_QSPI is not set
> # CONFIG_SPI_ST_SSC4 is not set
> # CONFIG_SPI_SUN4I is not set
> # CONFIG_SPI_SUN6I is not set
> # CONFIG_SPI_SUNPLUS_SP7021 is not set
> # CONFIG_SPI_SYNQUACER is not set
> CONFIG_SPI_MXIC=m
> # CONFIG_SPI_TEGRA210_QUAD is not set
> # CONFIG_SPI_TEGRA114 is not set
> # CONFIG_SPI_TEGRA20_SFLASH is not set
> # CONFIG_SPI_TEGRA20_SLINK is not set
> # CONFIG_SPI_UNIPHIER is not set
> CONFIG_SPI_XCOMM=m
> # CONFIG_SPI_XILINX is not set
> # CONFIG_SPI_XLP is not set
> # CONFIG_SPI_XTENSA_XTFPGA is not set
> # CONFIG_SPI_ZYNQ_QSPI is not set
> CONFIG_SPI_ZYNQMP_GQSPI=m
> CONFIG_SPI_AMD=y
> 
> #
> # SPI Multiplexer support
> #
> # CONFIG_SPI_MUX is not set
> 
> #
> # SPI Protocol Masters
> #
> # CONFIG_SPI_SPIDEV is not set
> CONFIG_SPI_LOOPBACK_TEST=m
> CONFIG_SPI_TLE62X0=m
> CONFIG_SPI_SLAVE=y
> # CONFIG_SPI_SLAVE_TIME is not set
> CONFIG_SPI_SLAVE_SYSTEM_CONTROL=y
> CONFIG_SPI_DYNAMIC=y
> CONFIG_SPMI=y
> CONFIG_SPMI_HISI3670=m
> # CONFIG_SPMI_MSM_PMIC_ARB is not set
> # CONFIG_SPMI_MTK_PMIF is not set
> # CONFIG_HSI is not set
> CONFIG_PPS=m
> # CONFIG_PPS_DEBUG is not set
> CONFIG_NTP_PPS=y
> 
> #
> # PPS clients support
> #
> CONFIG_PPS_CLIENT_KTIMER=m
> CONFIG_PPS_CLIENT_LDISC=m
> # CONFIG_PPS_CLIENT_PARPORT is not set
> CONFIG_PPS_CLIENT_GPIO=m
> 
> #
> # PPS generators support
> #
> 
> #
> # PTP clock support
> #
> CONFIG_PTP_1588_CLOCK_OPTIONAL=y
> 
> #
> # Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
> #
> # end of PTP clock support
> 
> CONFIG_PINCTRL=y
> CONFIG_GENERIC_PINCTRL_GROUPS=y
> CONFIG_PINMUX=y
> CONFIG_GENERIC_PINMUX_FUNCTIONS=y
> CONFIG_PINCONF=y
> CONFIG_GENERIC_PINCONF=y
> CONFIG_DEBUG_PINCTRL=y
> # CONFIG_PINCTRL_AMD is not set
> CONFIG_PINCTRL_AS3722=m
> CONFIG_PINCTRL_AT91=y
> # CONFIG_PINCTRL_AT91PIO4 is not set
> # CONFIG_PINCTRL_AXP209 is not set
> # CONFIG_PINCTRL_BM1880 is not set
> # CONFIG_PINCTRL_CY8C95X0 is not set
> # CONFIG_PINCTRL_DA850_PUPD is not set
> CONFIG_PINCTRL_DA9062=m
> # CONFIG_PINCTRL_EQUILIBRIUM is not set
> # CONFIG_PINCTRL_INGENIC is not set
> # CONFIG_PINCTRL_LOONGSON2 is not set
> # CONFIG_PINCTRL_LPC18XX is not set
> CONFIG_PINCTRL_MAX77620=y
> CONFIG_PINCTRL_MCP23S08_I2C=m
> CONFIG_PINCTRL_MCP23S08_SPI=m
> CONFIG_PINCTRL_MCP23S08=m
> # CONFIG_PINCTRL_MICROCHIP_SGPIO is not set
> CONFIG_PINCTRL_OCELOT=y
> # CONFIG_PINCTRL_PALMAS is not set
> # CONFIG_PINCTRL_PISTACHIO is not set
> # CONFIG_PINCTRL_ROCKCHIP is not set
> # CONFIG_PINCTRL_SINGLE is not set
> CONFIG_PINCTRL_STMFX=m
> CONFIG_PINCTRL_SX150X=y
> # CONFIG_PINCTRL_OWL is not set
> # CONFIG_PINCTRL_ASPEED_G4 is not set
> # CONFIG_PINCTRL_ASPEED_G5 is not set
> # CONFIG_PINCTRL_ASPEED_G6 is not set
> # CONFIG_PINCTRL_BCM281XX is not set
> # CONFIG_PINCTRL_BCM2835 is not set
> # CONFIG_PINCTRL_BCM4908 is not set
> # CONFIG_PINCTRL_BCM6318 is not set
> # CONFIG_PINCTRL_BCM6328 is not set
> # CONFIG_PINCTRL_BCM6358 is not set
> # CONFIG_PINCTRL_BCM6362 is not set
> # CONFIG_PINCTRL_BCM6368 is not set
> # CONFIG_PINCTRL_BCM63268 is not set
> # CONFIG_PINCTRL_IPROC_GPIO is not set
> # CONFIG_PINCTRL_CYGNUS_MUX is not set
> # CONFIG_PINCTRL_NS is not set
> # CONFIG_PINCTRL_NSP_GPIO is not set
> # CONFIG_PINCTRL_NS2_MUX is not set
> # CONFIG_PINCTRL_NSP_MUX is not set
> # CONFIG_PINCTRL_AS370 is not set
> # CONFIG_PINCTRL_BERLIN_BG4CT is not set
> CONFIG_PINCTRL_MADERA=m
> CONFIG_PINCTRL_CS47L90=y
> CONFIG_PINCTRL_CS47L92=y
> 
> #
> # Intel pinctrl drivers
> #
> # end of Intel pinctrl drivers
> 
> #
> # MediaTek pinctrl drivers
> #
> # CONFIG_EINT_MTK is not set
> # CONFIG_PINCTRL_MT2701 is not set
> # CONFIG_PINCTRL_MT7623 is not set
> # CONFIG_PINCTRL_MT7629 is not set
> # CONFIG_PINCTRL_MT8135 is not set
> # CONFIG_PINCTRL_MT8127 is not set
> # CONFIG_PINCTRL_MT2712 is not set
> # CONFIG_PINCTRL_MT6765 is not set
> # CONFIG_PINCTRL_MT6779 is not set
> # CONFIG_PINCTRL_MT6795 is not set
> # CONFIG_PINCTRL_MT6797 is not set
> # CONFIG_PINCTRL_MT7622 is not set
> # CONFIG_PINCTRL_MT7986 is not set
> # CONFIG_PINCTRL_MT8167 is not set
> # CONFIG_PINCTRL_MT8173 is not set
> # CONFIG_PINCTRL_MT8183 is not set
> # CONFIG_PINCTRL_MT8186 is not set
> # CONFIG_PINCTRL_MT8188 is not set
> # CONFIG_PINCTRL_MT8192 is not set
> # CONFIG_PINCTRL_MT8195 is not set
> # CONFIG_PINCTRL_MT8365 is not set
> # CONFIG_PINCTRL_MT8516 is not set
> # CONFIG_PINCTRL_MT6397 is not set
> # end of MediaTek pinctrl drivers
> 
> CONFIG_PINCTRL_MESON=y
> CONFIG_PINCTRL_MESON8=y
> CONFIG_PINCTRL_MESON8B=y
> CONFIG_PINCTRL_MESON8_PMX=y
> # CONFIG_PINCTRL_WPCM450 is not set
> # CONFIG_PINCTRL_NPCM7XX is not set
> # CONFIG_PINCTRL_PXA25X is not set
> # CONFIG_PINCTRL_PXA27X is not set
> # CONFIG_PINCTRL_MSM is not set
> # CONFIG_PINCTRL_QCOM_SPMI_PMIC is not set
> # CONFIG_PINCTRL_QCOM_SSBI_PMIC is not set
> # CONFIG_PINCTRL_LPASS_LPI is not set
> 
> #
> # Renesas pinctrl drivers
> #
> # CONFIG_PINCTRL_RENESAS is not set
> # CONFIG_PINCTRL_PFC_EMEV2 is not set
> # CONFIG_PINCTRL_PFC_R8A77995 is not set
> # CONFIG_PINCTRL_PFC_R8A7794 is not set
> # CONFIG_PINCTRL_PFC_R8A77990 is not set
> # CONFIG_PINCTRL_PFC_R8A7779 is not set
> # CONFIG_PINCTRL_PFC_R8A7790 is not set
> # CONFIG_PINCTRL_PFC_R8A77950 is not set
> # CONFIG_PINCTRL_PFC_R8A77951 is not set
> # CONFIG_PINCTRL_PFC_R8A7778 is not set
> # CONFIG_PINCTRL_PFC_R8A7793 is not set
> # CONFIG_PINCTRL_PFC_R8A7791 is not set
> # CONFIG_PINCTRL_PFC_R8A77965 is not set
> # CONFIG_PINCTRL_PFC_R8A77960 is not set
> # CONFIG_PINCTRL_PFC_R8A77961 is not set
> # CONFIG_PINCTRL_PFC_R8A779F0 is not set
> # CONFIG_PINCTRL_PFC_R8A7792 is not set
> # CONFIG_PINCTRL_PFC_R8A77980 is not set
> # CONFIG_PINCTRL_PFC_R8A77970 is not set
> # CONFIG_PINCTRL_PFC_R8A779A0 is not set
> # CONFIG_PINCTRL_PFC_R8A779G0 is not set
> # CONFIG_PINCTRL_PFC_R8A7740 is not set
> # CONFIG_PINCTRL_PFC_R8A73A4 is not set
> # CONFIG_PINCTRL_RZA1 is not set
> # CONFIG_PINCTRL_RZA2 is not set
> # CONFIG_PINCTRL_RZG2L is not set
> # CONFIG_PINCTRL_PFC_R8A77470 is not set
> # CONFIG_PINCTRL_PFC_R8A7745 is not set
> # CONFIG_PINCTRL_PFC_R8A7742 is not set
> # CONFIG_PINCTRL_PFC_R8A7743 is not set
> # CONFIG_PINCTRL_PFC_R8A7744 is not set
> # CONFIG_PINCTRL_PFC_R8A774C0 is not set
> # CONFIG_PINCTRL_PFC_R8A774E1 is not set
> # CONFIG_PINCTRL_PFC_R8A774A1 is not set
> # CONFIG_PINCTRL_PFC_R8A774B1 is not set
> # CONFIG_PINCTRL_RZN1 is not set
> # CONFIG_PINCTRL_RZV2M is not set
> # CONFIG_PINCTRL_PFC_SH7203 is not set
> # CONFIG_PINCTRL_PFC_SH7264 is not set
> # CONFIG_PINCTRL_PFC_SH7269 is not set
> # CONFIG_PINCTRL_PFC_SH7720 is not set
> # CONFIG_PINCTRL_PFC_SH7722 is not set
> # CONFIG_PINCTRL_PFC_SH7734 is not set
> # CONFIG_PINCTRL_PFC_SH7757 is not set
> # CONFIG_PINCTRL_PFC_SH7785 is not set
> # CONFIG_PINCTRL_PFC_SH7786 is not set
> # CONFIG_PINCTRL_PFC_SH73A0 is not set
> # CONFIG_PINCTRL_PFC_SH7723 is not set
> # CONFIG_PINCTRL_PFC_SH7724 is not set
> # CONFIG_PINCTRL_PFC_SHX3 is not set
> # end of Renesas pinctrl drivers
> 
> # CONFIG_PINCTRL_EXYNOS is not set
> # CONFIG_PINCTRL_S3C24XX is not set
> # CONFIG_PINCTRL_S3C64XX is not set
> # CONFIG_PINCTRL_SPRD_SC9860 is not set
> # CONFIG_PINCTRL_STARFIVE_JH7100 is not set
> CONFIG_PINCTRL_STM32=y
> CONFIG_PINCTRL_STM32F429=y
> CONFIG_PINCTRL_STM32F469=y
> CONFIG_PINCTRL_STM32F746=y
> # CONFIG_PINCTRL_STM32F769 is not set
> CONFIG_PINCTRL_STM32H743=y
> # CONFIG_PINCTRL_STM32MP135 is not set
> # CONFIG_PINCTRL_STM32MP157 is not set
> # CONFIG_PINCTRL_TI_IODELAY is not set
> CONFIG_PINCTRL_UNIPHIER=y
> CONFIG_PINCTRL_UNIPHIER_LD4=y
> CONFIG_PINCTRL_UNIPHIER_PRO4=y
> CONFIG_PINCTRL_UNIPHIER_SLD8=y
> CONFIG_PINCTRL_UNIPHIER_PRO5=y
> CONFIG_PINCTRL_UNIPHIER_PXS2=y
> CONFIG_PINCTRL_UNIPHIER_LD6B=y
> # CONFIG_PINCTRL_UNIPHIER_LD11 is not set
> # CONFIG_PINCTRL_UNIPHIER_LD20 is not set
> # CONFIG_PINCTRL_UNIPHIER_PXS3 is not set
> # CONFIG_PINCTRL_UNIPHIER_NX1 is not set
> # CONFIG_PINCTRL_TMPV7700 is not set
> CONFIG_ARCH_HAVE_CUSTOM_GPIO_H=y
> CONFIG_GPIOLIB=y
> CONFIG_GPIOLIB_FASTPATH_LIMIT=512
> CONFIG_OF_GPIO=y
> CONFIG_GPIOLIB_IRQCHIP=y
> # CONFIG_DEBUG_GPIO is not set
> # CONFIG_GPIO_SYSFS is not set
> # CONFIG_GPIO_CDEV is not set
> CONFIG_GPIO_GENERIC=y
> CONFIG_GPIO_MAX730X=m
> 
> #
> # Memory mapped GPIO drivers
> #
> # CONFIG_GPIO_74XX_MMIO is not set
> # CONFIG_GPIO_ALTERA is not set
> # CONFIG_GPIO_ASPEED is not set
> # CONFIG_GPIO_ASPEED_SGPIO is not set
> # CONFIG_GPIO_ATH79 is not set
> # CONFIG_GPIO_RASPBERRYPI_EXP is not set
> # CONFIG_GPIO_BCM_KONA is not set
> # CONFIG_GPIO_BCM_XGS_IPROC is not set
> # CONFIG_GPIO_BRCMSTB is not set
> CONFIG_GPIO_CADENCE=y
> # CONFIG_GPIO_CLPS711X is not set
> CONFIG_GPIO_DWAPB=m
> # CONFIG_GPIO_EIC_SPRD is not set
> # CONFIG_GPIO_EM is not set
> CONFIG_GPIO_FTGPIO010=y
> CONFIG_GPIO_GENERIC_PLATFORM=m
> # CONFIG_GPIO_GRGPIO is not set
> # CONFIG_GPIO_HISI is not set
> # CONFIG_GPIO_HLWD is not set
> # CONFIG_GPIO_IOP is not set
> CONFIG_GPIO_LOGICVC=y
> # CONFIG_GPIO_LPC18XX is not set
> # CONFIG_GPIO_LPC32XX is not set
> # CONFIG_GPIO_MB86S7X is not set
> CONFIG_GPIO_MENZ127=m
> # CONFIG_GPIO_MPC8XXX is not set
> # CONFIG_GPIO_MT7621 is not set
> # CONFIG_GPIO_MXC is not set
> # CONFIG_GPIO_MXS is not set
> # CONFIG_GPIO_OMAP is not set
> # CONFIG_GPIO_PL061 is not set
> # CONFIG_GPIO_PMIC_EIC_SPRD is not set
> # CONFIG_GPIO_PXA is not set
> # CONFIG_GPIO_RCAR is not set
> # CONFIG_GPIO_RDA is not set
> # CONFIG_GPIO_ROCKCHIP is not set
> # CONFIG_GPIO_SAMA5D2_PIOBU is not set
> # CONFIG_GPIO_SIFIVE is not set
> CONFIG_GPIO_SIOX=m
> # CONFIG_GPIO_SNPS_CREG is not set
> # CONFIG_GPIO_SPRD is not set
> # CONFIG_GPIO_STP_XWAY is not set
> CONFIG_GPIO_SYSCON=m
> # CONFIG_GPIO_TEGRA is not set
> # CONFIG_GPIO_TEGRA186 is not set
> # CONFIG_GPIO_TS4800 is not set
> # CONFIG_GPIO_UNIPHIER is not set
> # CONFIG_GPIO_VISCONTI is not set
> # CONFIG_GPIO_XGENE_SB is not set
> # CONFIG_GPIO_XILINX is not set
> # CONFIG_GPIO_XLP is not set
> CONFIG_GPIO_ZEVIO=y
> # CONFIG_GPIO_AMD_FCH is not set
> # CONFIG_GPIO_IDT3243X is not set
> # end of Memory mapped GPIO drivers
> 
> #
> # I2C GPIO expanders
> #
> CONFIG_GPIO_ADNP=m
> # CONFIG_GPIO_GW_PLD is not set
> # CONFIG_GPIO_MAX7300 is not set
> # CONFIG_GPIO_MAX732X is not set
> # CONFIG_GPIO_PCA953X is not set
> CONFIG_GPIO_PCA9570=m
> CONFIG_GPIO_PCF857X=y
> # CONFIG_GPIO_TPIC2810 is not set
> # CONFIG_GPIO_TS4900 is not set
> # end of I2C GPIO expanders
> 
> #
> # MFD GPIO expanders
> #
> CONFIG_GPIO_BD9571MWV=m
> CONFIG_GPIO_DLN2=m
> # CONFIG_HTC_EGPIO is not set
> # CONFIG_GPIO_KEMPLD is not set
> CONFIG_GPIO_LP873X=m
> # CONFIG_GPIO_LP87565 is not set
> CONFIG_GPIO_MADERA=m
> CONFIG_GPIO_MAX77620=y
> CONFIG_GPIO_MAX77650=m
> # CONFIG_GPIO_PALMAS is not set
> # CONFIG_GPIO_SL28CPLD is not set
> CONFIG_GPIO_STMPE=y
> # CONFIG_GPIO_TC3589X is not set
> # CONFIG_GPIO_TPS65086 is not set
> CONFIG_GPIO_TPS65910=y
> CONFIG_GPIO_TPS65912=y
> CONFIG_GPIO_TWL4030=y
> # CONFIG_GPIO_TWL6040 is not set
> # CONFIG_GPIO_UCB1400 is not set
> # CONFIG_GPIO_WM831X is not set
> CONFIG_GPIO_WM8994=y
> # end of MFD GPIO expanders
> 
> #
> # SPI GPIO expanders
> #
> CONFIG_GPIO_74X164=m
> CONFIG_GPIO_MAX3191X=m
> CONFIG_GPIO_MAX7301=m
> CONFIG_GPIO_MC33880=y
> # CONFIG_GPIO_PISOSR is not set
> CONFIG_GPIO_XRA1403=m
> # end of SPI GPIO expanders
> 
> #
> # USB GPIO expanders
> #
> # CONFIG_GPIO_VIPERBOARD is not set
> # end of USB GPIO expanders
> 
> #
> # Virtual GPIO drivers
> #
> # CONFIG_GPIO_AGGREGATOR is not set
> # CONFIG_GPIO_LATCH is not set
> CONFIG_GPIO_MOCKUP=m
> # CONFIG_GPIO_VIRTIO is not set
> # CONFIG_GPIO_SIM is not set
> # end of Virtual GPIO drivers
> 
> CONFIG_W1=m
> 
> #
> # 1-wire Bus Masters
> #
> CONFIG_W1_MASTER_DS2490=m
> CONFIG_W1_MASTER_DS2482=m
> # CONFIG_W1_MASTER_MXC is not set
> # CONFIG_W1_MASTER_DS1WM is not set
> CONFIG_W1_MASTER_GPIO=m
> CONFIG_W1_MASTER_SGI=m
> # end of 1-wire Bus Masters
> 
> #
> # 1-wire Slaves
> #
> # CONFIG_W1_SLAVE_THERM is not set
> CONFIG_W1_SLAVE_SMEM=m
> CONFIG_W1_SLAVE_DS2405=m
> CONFIG_W1_SLAVE_DS2408=m
> CONFIG_W1_SLAVE_DS2408_READBACK=y
> CONFIG_W1_SLAVE_DS2413=m
> CONFIG_W1_SLAVE_DS2406=m
> CONFIG_W1_SLAVE_DS2423=m
> # CONFIG_W1_SLAVE_DS2805 is not set
> CONFIG_W1_SLAVE_DS2430=m
> CONFIG_W1_SLAVE_DS2431=m
> # CONFIG_W1_SLAVE_DS2433 is not set
> # CONFIG_W1_SLAVE_DS2438 is not set
> CONFIG_W1_SLAVE_DS250X=m
> CONFIG_W1_SLAVE_DS2780=m
> CONFIG_W1_SLAVE_DS2781=m
> CONFIG_W1_SLAVE_DS28E04=m
> CONFIG_W1_SLAVE_DS28E17=m
> # end of 1-wire Slaves
> 
> CONFIG_POWER_RESET=y
> # CONFIG_POWER_RESET_AS3722 is not set
> CONFIG_POWER_RESET_AT91_POWEROFF=y
> CONFIG_POWER_RESET_AT91_RESET=m
> # CONFIG_POWER_RESET_AT91_SAMA5D2_SHDWC is not set
> # CONFIG_POWER_RESET_ATC260X is not set
> CONFIG_POWER_RESET_BRCMKONA=y
> # CONFIG_POWER_RESET_BRCMSTB is not set
> # CONFIG_POWER_RESET_GEMINI_POWEROFF is not set
> CONFIG_POWER_RESET_GPIO=y
> CONFIG_POWER_RESET_GPIO_RESTART=y
> # CONFIG_POWER_RESET_OCELOT_RESET is not set
> # CONFIG_POWER_RESET_LTC2952 is not set
> CONFIG_POWER_RESET_REGULATOR=y
> CONFIG_POWER_RESET_RESTART=y
> CONFIG_POWER_RESET_TPS65086=y
> CONFIG_POWER_RESET_VERSATILE=y
> # CONFIG_POWER_RESET_KEYSTONE is not set
> # CONFIG_POWER_RESET_SYSCON is not set
> CONFIG_POWER_RESET_SYSCON_POWEROFF=y
> # CONFIG_POWER_RESET_RMOBILE is not set
> CONFIG_REBOOT_MODE=y
> CONFIG_SYSCON_REBOOT_MODE=y
> # CONFIG_POWER_RESET_SC27XX is not set
> CONFIG_NVMEM_REBOOT_MODE=y
> CONFIG_POWER_SUPPLY=y
> # CONFIG_POWER_SUPPLY_DEBUG is not set
> CONFIG_PDA_POWER=m
> # CONFIG_APM_POWER is not set
> # CONFIG_GENERIC_ADC_BATTERY is not set
> CONFIG_IP5XXX_POWER=m
> CONFIG_WM831X_BACKUP=y
> CONFIG_WM831X_POWER=y
> CONFIG_TEST_POWER=m
> CONFIG_BATTERY_88PM860X=m
> CONFIG_CHARGER_ADP5061=m
> # CONFIG_BATTERY_ACT8945A is not set
> CONFIG_BATTERY_CW2015=y
> # CONFIG_BATTERY_DS2760 is not set
> CONFIG_BATTERY_DS2780=m
> CONFIG_BATTERY_DS2781=m
> CONFIG_BATTERY_DS2782=m
> # CONFIG_BATTERY_LEGO_EV3 is not set
> # CONFIG_BATTERY_SAMSUNG_SDI is not set
> CONFIG_BATTERY_SBS=y
> # CONFIG_CHARGER_SBS is not set
> # CONFIG_MANAGER_SBS is not set
> CONFIG_BATTERY_BQ27XXX=y
> # CONFIG_BATTERY_BQ27XXX_I2C is not set
> CONFIG_BATTERY_BQ27XXX_HDQ=m
> CONFIG_CHARGER_DA9150=m
> CONFIG_BATTERY_DA9150=m
> # CONFIG_AXP20X_POWER is not set
> # CONFIG_BATTERY_MAX17040 is not set
> CONFIG_BATTERY_MAX17042=m
> CONFIG_BATTERY_MAX1721X=m
> # CONFIG_BATTERY_TWL4030_MADC is not set
> CONFIG_CHARGER_88PM860X=m
> CONFIG_BATTERY_RX51=m
> CONFIG_CHARGER_ISP1704=y
> # CONFIG_CHARGER_MAX8903 is not set
> CONFIG_CHARGER_TWL4030=m
> CONFIG_CHARGER_LP8727=m
> CONFIG_CHARGER_GPIO=y
> CONFIG_CHARGER_MANAGER=m
> # CONFIG_CHARGER_LT3651 is not set
> # CONFIG_CHARGER_LTC4162L is not set
> CONFIG_CHARGER_MAX14577=m
> # CONFIG_CHARGER_DETECTOR_MAX14656 is not set
> CONFIG_CHARGER_MAX77650=y
> CONFIG_CHARGER_MAX77976=m
> CONFIG_CHARGER_MAX8998=m
> # CONFIG_CHARGER_MT6360 is not set
> # CONFIG_CHARGER_QCOM_SMBB is not set
> # CONFIG_CHARGER_BQ2415X is not set
> # CONFIG_CHARGER_BQ24190 is not set
> # CONFIG_CHARGER_BQ24257 is not set
> # CONFIG_CHARGER_BQ24735 is not set
> # CONFIG_CHARGER_BQ2515X is not set
> CONFIG_CHARGER_BQ25890=y
> CONFIG_CHARGER_BQ25980=y
> CONFIG_CHARGER_BQ256XX=y
> # CONFIG_CHARGER_SMB347 is not set
> CONFIG_CHARGER_TPS65217=m
> CONFIG_BATTERY_GAUGE_LTC2941=m
> CONFIG_BATTERY_GOLDFISH=y
> CONFIG_BATTERY_RT5033=m
> CONFIG_CHARGER_RT9455=y
> # CONFIG_CHARGER_SC2731 is not set
> # CONFIG_FUEL_GAUGE_SC27XX is not set
> CONFIG_CHARGER_UCS1002=m
> CONFIG_CHARGER_BD99954=y
> CONFIG_BATTERY_UG3105=y
> CONFIG_HWMON=m
> CONFIG_HWMON_VID=m
> # CONFIG_HWMON_DEBUG_CHIP is not set
> 
> #
> # Native drivers
> #
> # CONFIG_SENSORS_AD7314 is not set
> CONFIG_SENSORS_AD7414=m
> CONFIG_SENSORS_AD7418=m
> # CONFIG_SENSORS_ADM1025 is not set
> # CONFIG_SENSORS_ADM1026 is not set
> # CONFIG_SENSORS_ADM1029 is not set
> # CONFIG_SENSORS_ADM1031 is not set
> # CONFIG_SENSORS_ADM1177 is not set
> # CONFIG_SENSORS_ADM9240 is not set
> CONFIG_SENSORS_ADT7X10=m
> CONFIG_SENSORS_ADT7310=m
> CONFIG_SENSORS_ADT7410=m
> CONFIG_SENSORS_ADT7411=m
> CONFIG_SENSORS_ADT7462=m
> CONFIG_SENSORS_ADT7470=m
> CONFIG_SENSORS_ADT7475=m
> CONFIG_SENSORS_AHT10=m
> # CONFIG_SENSORS_AQUACOMPUTER_D5NEXT is not set
> CONFIG_SENSORS_AS370=m
> CONFIG_SENSORS_ASC7621=m
> CONFIG_SENSORS_AXI_FAN_CONTROL=m
> CONFIG_SENSORS_ARM_SCMI=m
> # CONFIG_SENSORS_ASB100 is not set
> # CONFIG_SENSORS_ASPEED is not set
> CONFIG_SENSORS_ATXP1=m
> # CONFIG_SENSORS_BT1_PVT is not set
> CONFIG_SENSORS_CORSAIR_CPRO=m
> # CONFIG_SENSORS_CORSAIR_PSU is not set
> # CONFIG_SENSORS_DRIVETEMP is not set
> CONFIG_SENSORS_DS620=m
> CONFIG_SENSORS_DS1621=m
> # CONFIG_SENSORS_SPARX5 is not set
> # CONFIG_SENSORS_F71805F is not set
> CONFIG_SENSORS_F71882FG=m
> CONFIG_SENSORS_F75375S=m
> # CONFIG_SENSORS_GSC is not set
> # CONFIG_SENSORS_FSCHMD is not set
> CONFIG_SENSORS_GL518SM=m
> CONFIG_SENSORS_GL520SM=m
> # CONFIG_SENSORS_G760A is not set
> CONFIG_SENSORS_G762=m
> CONFIG_SENSORS_GPIO_FAN=m
> # CONFIG_SENSORS_HIH6130 is not set
> CONFIG_SENSORS_IIO_HWMON=m
> CONFIG_SENSORS_IT87=m
> # CONFIG_SENSORS_JC42 is not set
> CONFIG_SENSORS_POWR1220=m
> # CONFIG_SENSORS_LAN966X is not set
> CONFIG_SENSORS_LINEAGE=m
> CONFIG_SENSORS_LTC2945=m
> CONFIG_SENSORS_LTC2947=m
> CONFIG_SENSORS_LTC2947_I2C=m
> CONFIG_SENSORS_LTC2947_SPI=m
> # CONFIG_SENSORS_LTC2990 is not set
> CONFIG_SENSORS_LTC2992=m
> CONFIG_SENSORS_LTC4151=m
> CONFIG_SENSORS_LTC4215=m
> # CONFIG_SENSORS_LTC4222 is not set
> # CONFIG_SENSORS_LTC4245 is not set
> # CONFIG_SENSORS_LTC4260 is not set
> CONFIG_SENSORS_LTC4261=m
> CONFIG_SENSORS_MAX1111=m
> # CONFIG_SENSORS_MAX127 is not set
> # CONFIG_SENSORS_MAX16065 is not set
> CONFIG_SENSORS_MAX1619=m
> # CONFIG_SENSORS_MAX1668 is not set
> CONFIG_SENSORS_MAX197=m
> CONFIG_SENSORS_MAX31722=m
> # CONFIG_SENSORS_MAX31730 is not set
> CONFIG_SENSORS_MAX31760=m
> # CONFIG_SENSORS_MAX6620 is not set
> CONFIG_SENSORS_MAX6621=m
> CONFIG_SENSORS_MAX6639=m
> CONFIG_SENSORS_MAX6650=m
> CONFIG_SENSORS_MAX6697=m
> # CONFIG_SENSORS_MAX31790 is not set
> # CONFIG_SENSORS_MCP3021 is not set
> # CONFIG_SENSORS_MLXREG_FAN is not set
> # CONFIG_SENSORS_TC654 is not set
> CONFIG_SENSORS_TPS23861=m
> CONFIG_SENSORS_MENF21BMC_HWMON=m
> CONFIG_SENSORS_MR75203=m
> CONFIG_SENSORS_ADCXX=m
> # CONFIG_SENSORS_LM63 is not set
> CONFIG_SENSORS_LM70=m
> # CONFIG_SENSORS_LM73 is not set
> CONFIG_SENSORS_LM75=m
> # CONFIG_SENSORS_LM77 is not set
> CONFIG_SENSORS_LM78=m
> CONFIG_SENSORS_LM80=m
> CONFIG_SENSORS_LM83=m
> # CONFIG_SENSORS_LM85 is not set
> CONFIG_SENSORS_LM87=m
> CONFIG_SENSORS_LM90=m
> # CONFIG_SENSORS_LM92 is not set
> CONFIG_SENSORS_LM93=m
> # CONFIG_SENSORS_LM95234 is not set
> CONFIG_SENSORS_LM95241=m
> # CONFIG_SENSORS_LM95245 is not set
> CONFIG_SENSORS_PC87360=m
> CONFIG_SENSORS_PC87427=m
> CONFIG_SENSORS_NTC_THERMISTOR=m
> CONFIG_SENSORS_NCT6683=m
> CONFIG_SENSORS_NCT6775_CORE=m
> CONFIG_SENSORS_NCT6775=m
> CONFIG_SENSORS_NCT6775_I2C=m
> CONFIG_SENSORS_NCT7802=m
> # CONFIG_SENSORS_NPCM7XX is not set
> # CONFIG_SENSORS_NSA320 is not set
> CONFIG_SENSORS_NZXT_KRAKEN2=m
> # CONFIG_SENSORS_NZXT_SMART2 is not set
> CONFIG_SENSORS_OCC_P8_I2C=m
> CONFIG_SENSORS_OCC_P9_SBE=m
> CONFIG_SENSORS_OCC=m
> CONFIG_SENSORS_PCF8591=m
> # CONFIG_PMBUS is not set
> CONFIG_SENSORS_PWM_FAN=m
> # CONFIG_SENSORS_RASPBERRYPI_HWMON is not set
> # CONFIG_SENSORS_SL28CPLD is not set
> CONFIG_SENSORS_SBTSI=m
> CONFIG_SENSORS_SBRMI=m
> # CONFIG_SENSORS_SHT15 is not set
> CONFIG_SENSORS_SHT21=m
> CONFIG_SENSORS_SHT3x=m
> # CONFIG_SENSORS_SHT4x is not set
> CONFIG_SENSORS_SHTC1=m
> # CONFIG_SENSORS_SY7636A is not set
> CONFIG_SENSORS_DME1737=m
> CONFIG_SENSORS_EMC1403=m
> CONFIG_SENSORS_EMC2103=m
> # CONFIG_SENSORS_EMC2305 is not set
> # CONFIG_SENSORS_EMC6W201 is not set
> # CONFIG_SENSORS_SMSC47M1 is not set
> CONFIG_SENSORS_SMSC47M192=m
> # CONFIG_SENSORS_SMSC47B397 is not set
> CONFIG_SENSORS_STTS751=m
> CONFIG_SENSORS_SMM665=m
> CONFIG_SENSORS_ADC128D818=m
> CONFIG_SENSORS_ADS7828=m
> CONFIG_SENSORS_ADS7871=m
> CONFIG_SENSORS_AMC6821=m
> CONFIG_SENSORS_INA209=m
> CONFIG_SENSORS_INA2XX=m
> CONFIG_SENSORS_INA238=m
> CONFIG_SENSORS_INA3221=m
> CONFIG_SENSORS_TC74=m
> CONFIG_SENSORS_THMC50=m
> CONFIG_SENSORS_TMP102=m
> # CONFIG_SENSORS_TMP103 is not set
> CONFIG_SENSORS_TMP108=m
> # CONFIG_SENSORS_TMP401 is not set
> # CONFIG_SENSORS_TMP421 is not set
> # CONFIG_SENSORS_TMP464 is not set
> # CONFIG_SENSORS_TMP513 is not set
> CONFIG_SENSORS_VEXPRESS=m
> CONFIG_SENSORS_VT1211=m
> CONFIG_SENSORS_W83773G=m
> CONFIG_SENSORS_W83781D=m
> CONFIG_SENSORS_W83791D=m
> # CONFIG_SENSORS_W83792D is not set
> CONFIG_SENSORS_W83793=m
> CONFIG_SENSORS_W83795=m
> # CONFIG_SENSORS_W83795_FANCTRL is not set
> CONFIG_SENSORS_W83L785TS=m
> # CONFIG_SENSORS_W83L786NG is not set
> # CONFIG_SENSORS_W83627HF is not set
> CONFIG_SENSORS_W83627EHF=m
> # CONFIG_SENSORS_WM831X is not set
> CONFIG_SENSORS_INTEL_M10_BMC_HWMON=m
> CONFIG_THERMAL=y
> CONFIG_THERMAL_STATISTICS=y
> CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
> # CONFIG_THERMAL_OF is not set
> # CONFIG_THERMAL_WRITABLE_TRIPS is not set
> # CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE is not set
> # CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
> CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE=y
> CONFIG_THERMAL_GOV_FAIR_SHARE=y
> CONFIG_THERMAL_GOV_STEP_WISE=y
> # CONFIG_THERMAL_GOV_BANG_BANG is not set
> CONFIG_THERMAL_GOV_USER_SPACE=y
> CONFIG_DEVFREQ_THERMAL=y
> # CONFIG_THERMAL_EMULATION is not set
> CONFIG_THERMAL_MMIO=y
> CONFIG_HISI_THERMAL=y
> # CONFIG_IMX_THERMAL is not set
> # CONFIG_IMX8MM_THERMAL is not set
> # CONFIG_K3_THERMAL is not set
> # CONFIG_MAX77620_THERMAL is not set
> # CONFIG_SPEAR_THERMAL is not set
> # CONFIG_SUN8I_THERMAL is not set
> # CONFIG_ROCKCHIP_THERMAL is not set
> # CONFIG_RCAR_THERMAL is not set
> # CONFIG_RCAR_GEN3_THERMAL is not set
> # CONFIG_RZG2L_THERMAL is not set
> # CONFIG_KIRKWOOD_THERMAL is not set
> # CONFIG_DOVE_THERMAL is not set
> # CONFIG_ARMADA_THERMAL is not set
> # CONFIG_DA9062_THERMAL is not set
> CONFIG_MTK_THERMAL=y
> 
> #
> # Intel thermal drivers
> #
> 
> #
> # ACPI INT340X thermal drivers
> #
> # end of ACPI INT340X thermal drivers
> # end of Intel thermal drivers
> 
> #
> # Broadcom thermal drivers
> #
> # CONFIG_BRCMSTB_THERMAL is not set
> # CONFIG_BCM_NS_THERMAL is not set
> # CONFIG_BCM_SR_THERMAL is not set
> # end of Broadcom thermal drivers
> 
> #
> # Texas Instruments thermal drivers
> #
> # CONFIG_TI_SOC_THERMAL is not set
> # end of Texas Instruments thermal drivers
> 
> #
> # Samsung thermal drivers
> #
> # end of Samsung thermal drivers
> 
> #
> # STMicroelectronics thermal drivers
> #
> CONFIG_ST_THERMAL=y
> # CONFIG_ST_THERMAL_SYSCFG is not set
> CONFIG_ST_THERMAL_MEMMAP=y
> # end of STMicroelectronics thermal drivers
> 
> #
> # NVIDIA Tegra thermal drivers
> #
> # CONFIG_TEGRA_SOCTHERM is not set
> # CONFIG_TEGRA_BPMP_THERMAL is not set
> # CONFIG_TEGRA30_TSENSOR is not set
> # end of NVIDIA Tegra thermal drivers
> 
> CONFIG_GENERIC_ADC_THERMAL=m
> 
> #
> # Qualcomm thermal drivers
> #
> # CONFIG_QCOM_SPMI_ADC_TM5 is not set
> # CONFIG_QCOM_SPMI_TEMP_ALARM is not set
> # end of Qualcomm thermal drivers
> 
> # CONFIG_SPRD_THERMAL is not set
> # CONFIG_WATCHDOG is not set
> CONFIG_SSB_POSSIBLE=y
> CONFIG_SSB=y
> CONFIG_SSB_SDIOHOST_POSSIBLE=y
> CONFIG_SSB_SDIOHOST=y
> CONFIG_SSB_DRIVER_GPIO=y
> CONFIG_BCMA_POSSIBLE=y
> CONFIG_BCMA=m
> # CONFIG_BCMA_HOST_SOC is not set
> # CONFIG_BCMA_DRIVER_MIPS is not set
> CONFIG_BCMA_DRIVER_GMAC_CMN=y
> CONFIG_BCMA_DRIVER_GPIO=y
> CONFIG_BCMA_DEBUG=y
> 
> #
> # Multifunction device drivers
> #
> CONFIG_MFD_CORE=y
> # CONFIG_MFD_ACT8945A is not set
> # CONFIG_MFD_SUN4I_GPADC is not set
> CONFIG_MFD_AS3711=y
> # CONFIG_MFD_SMPRO is not set
> CONFIG_MFD_AS3722=m
> # CONFIG_PMIC_ADP5520 is not set
> # CONFIG_MFD_AAT2870_CORE is not set
> CONFIG_MFD_AT91_USART=y
> CONFIG_MFD_ATMEL_FLEXCOM=y
> CONFIG_MFD_ATMEL_HLCDC=m
> CONFIG_MFD_ATMEL_SMC=y
> CONFIG_MFD_BCM590XX=m
> CONFIG_MFD_BD9571MWV=y
> CONFIG_MFD_AXP20X=m
> CONFIG_MFD_AXP20X_I2C=m
> CONFIG_MFD_MADERA=m
> CONFIG_MFD_MADERA_I2C=m
> CONFIG_MFD_MADERA_SPI=m
> # CONFIG_MFD_CS47L15 is not set
> # CONFIG_MFD_CS47L35 is not set
> # CONFIG_MFD_CS47L85 is not set
> CONFIG_MFD_CS47L90=y
> CONFIG_MFD_CS47L92=y
> CONFIG_MFD_ASIC3=y
> # CONFIG_PMIC_DA903X is not set
> # CONFIG_MFD_DA9052_SPI is not set
> # CONFIG_MFD_DA9052_I2C is not set
> # CONFIG_MFD_DA9055 is not set
> CONFIG_MFD_DA9062=m
> # CONFIG_MFD_DA9063 is not set
> CONFIG_MFD_DA9150=y
> CONFIG_MFD_DLN2=m
> # CONFIG_MFD_ENE_KB3930 is not set
> # CONFIG_MFD_EXYNOS_LPASS is not set
> CONFIG_MFD_GATEWORKS_GSC=y
> # CONFIG_MFD_MC13XXX_SPI is not set
> # CONFIG_MFD_MC13XXX_I2C is not set
> # CONFIG_MFD_MP2629 is not set
> # CONFIG_MFD_MXS_LRADC is not set
> # CONFIG_MFD_MX25_TSADC is not set
> CONFIG_MFD_HI6421_PMIC=m
> CONFIG_MFD_HI6421_SPMI=m
> # CONFIG_MFD_HI655X_PMIC is not set
> CONFIG_HTC_PASIC3=y
> # CONFIG_INTEL_SOC_PMIC is not set
> CONFIG_MFD_IQS62X=m
> CONFIG_MFD_KEMPLD=m
> CONFIG_MFD_88PM800=m
> # CONFIG_MFD_88PM805 is not set
> CONFIG_MFD_88PM860X=y
> CONFIG_MFD_MAX14577=m
> CONFIG_MFD_MAX77620=y
> CONFIG_MFD_MAX77650=y
> CONFIG_MFD_MAX77686=y
> # CONFIG_MFD_MAX77693 is not set
> CONFIG_MFD_MAX77714=y
> CONFIG_MFD_MAX77843=y
> CONFIG_MFD_MAX8907=y
> # CONFIG_MFD_MAX8925 is not set
> # CONFIG_MFD_MAX8997 is not set
> CONFIG_MFD_MAX8998=y
> CONFIG_MFD_MT6360=m
> # CONFIG_MFD_MT6370 is not set
> # CONFIG_MFD_MT6397 is not set
> CONFIG_MFD_MENF21BMC=m
> CONFIG_MFD_OCELOT=m
> CONFIG_EZX_PCAP=y
> # CONFIG_MFD_CPCAP is not set
> CONFIG_MFD_VIPERBOARD=m
> # CONFIG_MFD_NTXEC is not set
> CONFIG_MFD_RETU=m
> # CONFIG_MFD_PCF50633 is not set
> CONFIG_UCB1400_CORE=m
> CONFIG_MFD_PM8XXX=m
> # CONFIG_MFD_SPMI_PMIC is not set
> CONFIG_MFD_SY7636A=m
> CONFIG_MFD_RT4831=m
> CONFIG_MFD_RT5033=m
> # CONFIG_MFD_RT5120 is not set
> # CONFIG_MFD_RC5T583 is not set
> # CONFIG_MFD_RK808 is not set
> CONFIG_MFD_RN5T618=m
> # CONFIG_MFD_SEC_CORE is not set
> CONFIG_MFD_SI476X_CORE=m
> CONFIG_MFD_SIMPLE_MFD_I2C=m
> # CONFIG_MFD_SL28CPLD is not set
> # CONFIG_MFD_SM501 is not set
> CONFIG_MFD_SKY81452=y
> # CONFIG_MFD_SC27XX_PMIC is not set
> # CONFIG_ABX500_CORE is not set
> CONFIG_MFD_STMPE=y
> 
> #
> # STMicroelectronics STMPE Interface Drivers
> #
> # CONFIG_STMPE_I2C is not set
> CONFIG_STMPE_SPI=y
> # end of STMicroelectronics STMPE Interface Drivers
> 
> # CONFIG_MFD_SUN6I_PRCM is not set
> CONFIG_MFD_SYSCON=y
> CONFIG_MFD_TI_AM335X_TSCADC=y
> # CONFIG_MFD_LP3943 is not set
> CONFIG_MFD_LP8788=y
> CONFIG_MFD_TI_LMU=m
> CONFIG_MFD_OMAP_USB_HOST=y
> CONFIG_MFD_PALMAS=y
> CONFIG_TPS6105X=y
> CONFIG_TPS65010=m
> # CONFIG_TPS6507X is not set
> CONFIG_MFD_TPS65086=y
> # CONFIG_MFD_TPS65090 is not set
> CONFIG_MFD_TPS65217=y
> CONFIG_MFD_TI_LP873X=y
> CONFIG_MFD_TI_LP87565=m
> # CONFIG_MFD_TPS65218 is not set
> # CONFIG_MFD_TPS65219 is not set
> # CONFIG_MFD_TPS6586X is not set
> CONFIG_MFD_TPS65910=y
> CONFIG_MFD_TPS65912=y
> CONFIG_MFD_TPS65912_I2C=y
> # CONFIG_MFD_TPS65912_SPI is not set
> CONFIG_TWL4030_CORE=y
> # CONFIG_TWL4030_POWER is not set
> CONFIG_MFD_TWL4030_AUDIO=y
> CONFIG_TWL6040_CORE=y
> CONFIG_MFD_WL1273_CORE=m
> CONFIG_MFD_LM3533=y
> CONFIG_MFD_TC3589X=y
> # CONFIG_MFD_T7L66XB is not set
> # CONFIG_MFD_TC6387XB is not set
> # CONFIG_MFD_TC6393XB is not set
> # CONFIG_MFD_TQMX86 is not set
> # CONFIG_MFD_LOCHNAGAR is not set
> # CONFIG_MFD_ARIZONA_I2C is not set
> # CONFIG_MFD_ARIZONA_SPI is not set
> # CONFIG_MFD_WM8400 is not set
> CONFIG_MFD_WM831X=y
> # CONFIG_MFD_WM831X_I2C is not set
> CONFIG_MFD_WM831X_SPI=y
> # CONFIG_MFD_WM8350_I2C is not set
> CONFIG_MFD_WM8994=y
> # CONFIG_MFD_STW481X is not set
> CONFIG_MFD_ROHM_BD718XX=y
> # CONFIG_MFD_ROHM_BD71828 is not set
> # CONFIG_MFD_ROHM_BD957XMUF is not set
> # CONFIG_MFD_STM32_LPTIMER is not set
> CONFIG_MFD_STM32_TIMERS=m
> # CONFIG_MFD_STPMIC1 is not set
> CONFIG_MFD_STMFX=m
> # CONFIG_MFD_WCD934X is not set
> CONFIG_MFD_ATC260X=m
> CONFIG_MFD_ATC260X_I2C=m
> # CONFIG_MFD_KHADAS_MCU is not set
> # CONFIG_MFD_ACER_A500_EC is not set
> CONFIG_MFD_QCOM_PM8008=y
> # CONFIG_MFD_VEXPRESS_SYSREG is not set
> CONFIG_MFD_INTEL_M10_BMC=y
> CONFIG_MFD_RSMU_I2C=m
> CONFIG_MFD_RSMU_SPI=m
> # end of Multifunction device drivers
> 
> CONFIG_REGULATOR=y
> # CONFIG_REGULATOR_DEBUG is not set
> CONFIG_REGULATOR_FIXED_VOLTAGE=y
> CONFIG_REGULATOR_VIRTUAL_CONSUMER=y
> CONFIG_REGULATOR_USERSPACE_CONSUMER=m
> # CONFIG_REGULATOR_88PG86X is not set
> CONFIG_REGULATOR_88PM800=m
> CONFIG_REGULATOR_88PM8607=m
> CONFIG_REGULATOR_ACT8865=y
> # CONFIG_REGULATOR_AD5398 is not set
> # CONFIG_REGULATOR_ANATOP is not set
> CONFIG_REGULATOR_ARIZONA_LDO1=m
> # CONFIG_REGULATOR_ARIZONA_MICSUPP is not set
> # CONFIG_REGULATOR_ARM_SCMI is not set
> # CONFIG_REGULATOR_AS3711 is not set
> # CONFIG_REGULATOR_AS3722 is not set
> # CONFIG_REGULATOR_ATC260X is not set
> CONFIG_REGULATOR_AXP20X=m
> # CONFIG_REGULATOR_BCM590XX is not set
> CONFIG_REGULATOR_BD718XX=y
> # CONFIG_REGULATOR_BD9571MWV is not set
> CONFIG_REGULATOR_DA9062=m
> CONFIG_REGULATOR_DA9121=m
> CONFIG_REGULATOR_DA9210=m
> CONFIG_REGULATOR_DA9211=m
> CONFIG_REGULATOR_FAN53555=y
> CONFIG_REGULATOR_FAN53880=y
> CONFIG_REGULATOR_GPIO=y
> CONFIG_REGULATOR_HI6421=m
> CONFIG_REGULATOR_HI6421V530=m
> # CONFIG_REGULATOR_HI6421V600 is not set
> CONFIG_REGULATOR_ISL9305=m
> CONFIG_REGULATOR_ISL6271A=y
> CONFIG_REGULATOR_LM363X=m
> # CONFIG_REGULATOR_LP3971 is not set
> # CONFIG_REGULATOR_LP3972 is not set
> CONFIG_REGULATOR_LP872X=m
> CONFIG_REGULATOR_LP873X=y
> # CONFIG_REGULATOR_LP8755 is not set
> CONFIG_REGULATOR_LP87565=m
> CONFIG_REGULATOR_LP8788=m
> CONFIG_REGULATOR_LTC3589=m
> CONFIG_REGULATOR_LTC3676=m
> CONFIG_REGULATOR_MAX14577=m
> # CONFIG_REGULATOR_MAX1586 is not set
> # CONFIG_REGULATOR_MAX77620 is not set
> # CONFIG_REGULATOR_MAX77650 is not set
> # CONFIG_REGULATOR_MAX8649 is not set
> CONFIG_REGULATOR_MAX8660=m
> # CONFIG_REGULATOR_MAX8893 is not set
> CONFIG_REGULATOR_MAX8907=m
> # CONFIG_REGULATOR_MAX8952 is not set
> CONFIG_REGULATOR_MAX8998=y
> CONFIG_REGULATOR_MAX20086=m
> CONFIG_REGULATOR_MAX77686=y
> CONFIG_REGULATOR_MAX77693=y
> CONFIG_REGULATOR_MAX77802=m
> CONFIG_REGULATOR_MAX77826=y
> # CONFIG_REGULATOR_MCP16502 is not set
> CONFIG_REGULATOR_MP5416=y
> CONFIG_REGULATOR_MP8859=y
> CONFIG_REGULATOR_MP886X=y
> CONFIG_REGULATOR_MPQ7920=m
> CONFIG_REGULATOR_MT6311=m
> # CONFIG_REGULATOR_MT6315 is not set
> # CONFIG_REGULATOR_MT6360 is not set
> # CONFIG_REGULATOR_PALMAS is not set
> # CONFIG_REGULATOR_PBIAS is not set
> # CONFIG_REGULATOR_PCA9450 is not set
> # CONFIG_REGULATOR_PCAP is not set
> CONFIG_REGULATOR_PF8X00=y
> CONFIG_REGULATOR_PFUZE100=m
> CONFIG_REGULATOR_PV88060=y
> CONFIG_REGULATOR_PV88080=y
> CONFIG_REGULATOR_PV88090=m
> # CONFIG_REGULATOR_PWM is not set
> # CONFIG_REGULATOR_QCOM_RPMH is not set
> # CONFIG_REGULATOR_QCOM_SPMI is not set
> CONFIG_REGULATOR_QCOM_USB_VBUS=y
> # CONFIG_REGULATOR_RASPBERRYPI_TOUCHSCREEN_ATTINY is not set
> CONFIG_REGULATOR_RN5T618=m
> CONFIG_REGULATOR_ROHM=y
> # CONFIG_REGULATOR_RT4801 is not set
> CONFIG_REGULATOR_RT4831=m
> CONFIG_REGULATOR_RT5033=m
> CONFIG_REGULATOR_RT5190A=y
> CONFIG_REGULATOR_RT5759=y
> # CONFIG_REGULATOR_RT6160 is not set
> # CONFIG_REGULATOR_RT6190 is not set
> CONFIG_REGULATOR_RT6245=m
> CONFIG_REGULATOR_RTQ2134=m
> # CONFIG_REGULATOR_RTMV20 is not set
> CONFIG_REGULATOR_RTQ6752=m
> # CONFIG_REGULATOR_S2MPA01 is not set
> # CONFIG_REGULATOR_S2MPS11 is not set
> # CONFIG_REGULATOR_S5M8767 is not set
> # CONFIG_REGULATOR_SC2731 is not set
> CONFIG_REGULATOR_SKY81452=y
> CONFIG_REGULATOR_SLG51000=m
> # CONFIG_REGULATOR_STM32_BOOSTER is not set
> CONFIG_REGULATOR_STM32_VREFBUF=m
> CONFIG_REGULATOR_STM32_PWR=y
> # CONFIG_REGULATOR_TI_ABB is not set
> # CONFIG_REGULATOR_STW481X_VMMC is not set
> # CONFIG_REGULATOR_SY7636A is not set
> # CONFIG_REGULATOR_SY8106A is not set
> CONFIG_REGULATOR_SY8824X=m
> # CONFIG_REGULATOR_SY8827N is not set
> # CONFIG_REGULATOR_TPS51632 is not set
> CONFIG_REGULATOR_TPS6105X=m
> CONFIG_REGULATOR_TPS62360=m
> CONFIG_REGULATOR_TPS6286X=m
> CONFIG_REGULATOR_TPS65023=y
> CONFIG_REGULATOR_TPS6507X=y
> CONFIG_REGULATOR_TPS65086=y
> CONFIG_REGULATOR_TPS65132=y
> # CONFIG_REGULATOR_TPS65217 is not set
> CONFIG_REGULATOR_TPS6524X=m
> CONFIG_REGULATOR_TPS65910=m
> CONFIG_REGULATOR_TPS65912=y
> # CONFIG_REGULATOR_TPS68470 is not set
> CONFIG_REGULATOR_TWL4030=m
> # CONFIG_REGULATOR_UNIPHIER is not set
> CONFIG_REGULATOR_VCTRL=y
> # CONFIG_REGULATOR_VEXPRESS is not set
> CONFIG_REGULATOR_WM831X=y
> CONFIG_REGULATOR_WM8994=y
> # CONFIG_REGULATOR_QCOM_LABIBB is not set
> CONFIG_RC_CORE=m
> CONFIG_LIRC=y
> CONFIG_RC_MAP=m
> CONFIG_RC_DECODERS=y
> CONFIG_IR_IMON_DECODER=m
> CONFIG_IR_JVC_DECODER=m
> CONFIG_IR_MCE_KBD_DECODER=m
> # CONFIG_IR_NEC_DECODER is not set
> CONFIG_IR_RC5_DECODER=m
> CONFIG_IR_RC6_DECODER=m
> CONFIG_IR_RCMM_DECODER=m
> # CONFIG_IR_SANYO_DECODER is not set
> # CONFIG_IR_SHARP_DECODER is not set
> CONFIG_IR_SONY_DECODER=m
> CONFIG_IR_XMP_DECODER=m
> # CONFIG_RC_DEVICES is not set
> CONFIG_CEC_CORE=y
> 
> #
> # CEC support
> #
> CONFIG_MEDIA_CEC_SUPPORT=y
> CONFIG_CEC_CH7322=y
> # CONFIG_CEC_MESON_AO is not set
> # CONFIG_CEC_MESON_G12A_AO is not set
> # CONFIG_CEC_GPIO is not set
> # CONFIG_CEC_SAMSUNG_S5P is not set
> # CONFIG_CEC_STI is not set
> CONFIG_CEC_STM32=m
> # CONFIG_CEC_TEGRA is not set
> CONFIG_USB_PULSE8_CEC=m
> CONFIG_USB_RAINSHADOW_CEC=m
> # end of CEC support
> 
> # CONFIG_MEDIA_SUPPORT is not set
> 
> #
> # Graphics support
> #
> CONFIG_VIDEO_NOMODESET=y
> # CONFIG_TEGRA_HOST1X is not set
> # CONFIG_IMX_IPUV3_CORE is not set
> CONFIG_DRM=y
> CONFIG_DRM_MIPI_DBI=y
> CONFIG_DRM_MIPI_DSI=y
> CONFIG_DRM_DEBUG_MM=y
> CONFIG_DRM_KUNIT_TEST=m
> CONFIG_DRM_KMS_HELPER=y
> CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS=y
> CONFIG_DRM_DEBUG_MODESET_LOCK=y
> # CONFIG_DRM_FBDEV_EMULATION is not set
> CONFIG_DRM_LOAD_EDID_FIRMWARE=y
> CONFIG_DRM_DP_AUX_BUS=y
> CONFIG_DRM_DISPLAY_HELPER=y
> CONFIG_DRM_DISPLAY_DP_HELPER=y
> CONFIG_DRM_DISPLAY_HDCP_HELPER=y
> CONFIG_DRM_DISPLAY_HDMI_HELPER=y
> CONFIG_DRM_DP_AUX_CHARDEV=y
> # CONFIG_DRM_DP_CEC is not set
> CONFIG_DRM_BUDDY=m
> CONFIG_DRM_GEM_DMA_HELPER=y
> 
> #
> # I2C encoder or helper chips
> #
> # CONFIG_DRM_I2C_CH7006 is not set
> CONFIG_DRM_I2C_SIL164=m
> CONFIG_DRM_I2C_NXP_TDA998X=m
> # CONFIG_DRM_I2C_NXP_TDA9950 is not set
> # end of I2C encoder or helper chips
> 
> #
> # ARM devices
> #
> # CONFIG_DRM_HDLCD is not set
> CONFIG_DRM_MALI_DISPLAY=y
> # CONFIG_DRM_KOMEDA is not set
> # end of ARM devices
> 
> # CONFIG_DRM_KMB_DISPLAY is not set
> CONFIG_DRM_ATMEL_HLCDC=m
> # CONFIG_DRM_RCAR_DU is not set
> CONFIG_DRM_RCAR_DW_HDMI=m
> # CONFIG_DRM_RCAR_USE_LVDS is not set
> # CONFIG_DRM_RCAR_USE_MIPI_DSI is not set
> # CONFIG_DRM_RZG2L_MIPI_DSI is not set
> # CONFIG_DRM_SHMOBILE is not set
> # CONFIG_DRM_SUN4I is not set
> CONFIG_DRM_TILCDC=y
> CONFIG_DRM_FSL_DCU=y
> # CONFIG_DRM_TEGRA is not set
> # CONFIG_DRM_STM is not set
> CONFIG_DRM_PANEL=y
> 
> #
> # Display Panels
> #
> # CONFIG_DRM_PANEL_ABT_Y030XX067A is not set
> CONFIG_DRM_PANEL_ARM_VERSATILE=m
> CONFIG_DRM_PANEL_ASUS_Z00T_TM5P5_NT35596=y
> CONFIG_DRM_PANEL_BOE_BF060Y8M_AJ0=m
> CONFIG_DRM_PANEL_BOE_HIMAX8279D=y
> CONFIG_DRM_PANEL_BOE_TV101WUM_NL6=y
> CONFIG_DRM_PANEL_DSI_CM=y
> CONFIG_DRM_PANEL_LVDS=y
> CONFIG_DRM_PANEL_SIMPLE=m
> # CONFIG_DRM_PANEL_EDP is not set
> # CONFIG_DRM_PANEL_EBBG_FT8719 is not set
> # CONFIG_DRM_PANEL_ELIDA_KD35T133 is not set
> CONFIG_DRM_PANEL_FEIXIN_K101_IM2BA02=y
> CONFIG_DRM_PANEL_FEIYANG_FY07024DI26A30D=m
> CONFIG_DRM_PANEL_ILITEK_IL9322=y
> CONFIG_DRM_PANEL_ILITEK_ILI9341=m
> # CONFIG_DRM_PANEL_ILITEK_ILI9881C is not set
> # CONFIG_DRM_PANEL_INNOLUX_EJ030NA is not set
> CONFIG_DRM_PANEL_INNOLUX_P079ZCA=y
> # CONFIG_DRM_PANEL_JADARD_JD9365DA_H3 is not set
> CONFIG_DRM_PANEL_JDI_LT070ME05000=m
> CONFIG_DRM_PANEL_JDI_R63452=m
> # CONFIG_DRM_PANEL_KHADAS_TS050 is not set
> CONFIG_DRM_PANEL_KINGDISPLAY_KD097D04=y
> CONFIG_DRM_PANEL_LEADTEK_LTK050H3146W=y
> CONFIG_DRM_PANEL_LEADTEK_LTK500HD1829=m
> CONFIG_DRM_PANEL_SAMSUNG_LD9040=y
> CONFIG_DRM_PANEL_LG_LB035Q02=y
> # CONFIG_DRM_PANEL_LG_LG4573 is not set
> CONFIG_DRM_PANEL_NEC_NL8048HL11=m
> # CONFIG_DRM_PANEL_NEWVISION_NV3051D is not set
> CONFIG_DRM_PANEL_NEWVISION_NV3052C=y
> CONFIG_DRM_PANEL_NOVATEK_NT35510=m
> # CONFIG_DRM_PANEL_NOVATEK_NT35560 is not set
> CONFIG_DRM_PANEL_NOVATEK_NT35950=y
> CONFIG_DRM_PANEL_NOVATEK_NT36672A=m
> # CONFIG_DRM_PANEL_NOVATEK_NT39016 is not set
> CONFIG_DRM_PANEL_MANTIX_MLAF057WE51=y
> CONFIG_DRM_PANEL_OLIMEX_LCD_OLINUXINO=m
> # CONFIG_DRM_PANEL_ORISETECH_OTM8009A is not set
> CONFIG_DRM_PANEL_OSD_OSD101T2587_53TS=m
> # CONFIG_DRM_PANEL_PANASONIC_VVX10F034N00 is not set
> # CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN is not set
> CONFIG_DRM_PANEL_RAYDIUM_RM67191=m
> # CONFIG_DRM_PANEL_RAYDIUM_RM68200 is not set
> CONFIG_DRM_PANEL_RONBO_RB070D30=y
> CONFIG_DRM_PANEL_SAMSUNG_ATNA33XC20=m
> # CONFIG_DRM_PANEL_SAMSUNG_DB7430 is not set
> CONFIG_DRM_PANEL_SAMSUNG_S6D16D0=m
> # CONFIG_DRM_PANEL_SAMSUNG_S6D27A1 is not set
> CONFIG_DRM_PANEL_SAMSUNG_S6E3HA2=m
> # CONFIG_DRM_PANEL_SAMSUNG_S6E63J0X03 is not set
> # CONFIG_DRM_PANEL_SAMSUNG_S6E63M0 is not set
> CONFIG_DRM_PANEL_SAMSUNG_S6E88A0_AMS452EF01=m
> # CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0 is not set
> CONFIG_DRM_PANEL_SAMSUNG_SOFEF00=y
> CONFIG_DRM_PANEL_SEIKO_43WVF1G=y
> # CONFIG_DRM_PANEL_SHARP_LQ101R1SX01 is not set
> CONFIG_DRM_PANEL_SHARP_LS037V7DW01=y
> CONFIG_DRM_PANEL_SHARP_LS043T1LE01=m
> CONFIG_DRM_PANEL_SHARP_LS060T1SX01=m
> CONFIG_DRM_PANEL_SITRONIX_ST7701=m
> # CONFIG_DRM_PANEL_SITRONIX_ST7703 is not set
> CONFIG_DRM_PANEL_SITRONIX_ST7789V=y
> CONFIG_DRM_PANEL_SONY_ACX565AKM=y
> CONFIG_DRM_PANEL_SONY_TULIP_TRULY_NT35521=m
> # CONFIG_DRM_PANEL_TDO_TL070WSH30 is not set
> CONFIG_DRM_PANEL_TPO_TD028TTEC1=y
> CONFIG_DRM_PANEL_TPO_TD043MTEA1=y
> CONFIG_DRM_PANEL_TPO_TPG110=y
> # CONFIG_DRM_PANEL_TRULY_NT35597_WQXGA is not set
> # CONFIG_DRM_PANEL_VISIONOX_RM69299 is not set
> CONFIG_DRM_PANEL_WIDECHIPS_WS2401=m
> # CONFIG_DRM_PANEL_XINPENG_XPP055C272 is not set
> # end of Display Panels
> 
> CONFIG_DRM_BRIDGE=y
> CONFIG_DRM_PANEL_BRIDGE=y
> 
> #
> # Display Interface Bridges
> #
> CONFIG_DRM_CDNS_DSI=m
> # CONFIG_DRM_CHIPONE_ICN6211 is not set
> # CONFIG_DRM_CHRONTEL_CH7033 is not set
> # CONFIG_DRM_CROS_EC_ANX7688 is not set
> # CONFIG_DRM_DISPLAY_CONNECTOR is not set
> # CONFIG_DRM_FSL_LDB is not set
> CONFIG_DRM_ITE_IT6505=m
> CONFIG_DRM_LONTIUM_LT8912B=y
> CONFIG_DRM_LONTIUM_LT9211=y
> # CONFIG_DRM_LONTIUM_LT9611 is not set
> # CONFIG_DRM_LONTIUM_LT9611UXC is not set
> # CONFIG_DRM_ITE_IT66121 is not set
> # CONFIG_DRM_LVDS_CODEC is not set
> CONFIG_DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW=y
> CONFIG_DRM_NWL_MIPI_DSI=m
> CONFIG_DRM_NXP_PTN3460=y
> CONFIG_DRM_PARADE_PS8622=y
> CONFIG_DRM_PARADE_PS8640=y
> CONFIG_DRM_SIL_SII8620=m
> CONFIG_DRM_SII902X=y
> # CONFIG_DRM_SII9234 is not set
> CONFIG_DRM_SIMPLE_BRIDGE=m
> CONFIG_DRM_THINE_THC63LVD1024=m
> # CONFIG_DRM_TOSHIBA_TC358762 is not set
> CONFIG_DRM_TOSHIBA_TC358764=m
> CONFIG_DRM_TOSHIBA_TC358767=m
> # CONFIG_DRM_TOSHIBA_TC358768 is not set
> CONFIG_DRM_TOSHIBA_TC358775=y
> # CONFIG_DRM_TI_DLPC3433 is not set
> CONFIG_DRM_TI_TFP410=y
> # CONFIG_DRM_TI_SN65DSI83 is not set
> # CONFIG_DRM_TI_SN65DSI86 is not set
> CONFIG_DRM_TI_TPD12S015=m
> CONFIG_DRM_ANALOGIX_ANX6345=y
> # CONFIG_DRM_ANALOGIX_ANX78XX is not set
> CONFIG_DRM_ANALOGIX_DP=y
> CONFIG_DRM_ANALOGIX_ANX7625=m
> CONFIG_DRM_I2C_ADV7511=y
> # CONFIG_DRM_I2C_ADV7511_AUDIO is not set
> CONFIG_DRM_I2C_ADV7511_CEC=y
> # CONFIG_DRM_CDNS_MHDP8546 is not set
> # CONFIG_DRM_IMX8QM_LDB is not set
> # CONFIG_DRM_IMX8QXP_LDB is not set
> # CONFIG_DRM_IMX8QXP_PIXEL_COMBINER is not set
> # CONFIG_DRM_IMX8QXP_PIXEL_LINK_TO_DPI is not set
> CONFIG_DRM_DW_HDMI=m
> # CONFIG_DRM_DW_HDMI_AHB_AUDIO is not set
> CONFIG_DRM_DW_HDMI_I2S_AUDIO=m
> CONFIG_DRM_DW_HDMI_GP_AUDIO=m
> # CONFIG_DRM_DW_HDMI_CEC is not set
> # end of Display Interface Bridges
> 
> # CONFIG_DRM_VC4 is not set
> CONFIG_DRM_LOGICVC=y
> CONFIG_DRM_MXS=y
> # CONFIG_DRM_MXSFB is not set
> CONFIG_DRM_IMX_LCDIF=y
> # CONFIG_DRM_MESON is not set
> # CONFIG_DRM_ARCPGU is not set
> CONFIG_DRM_PANEL_MIPI_DBI=y
> # CONFIG_TINYDRM_HX8357D is not set
> # CONFIG_TINYDRM_ILI9163 is not set
> # CONFIG_TINYDRM_ILI9225 is not set
> CONFIG_TINYDRM_ILI9341=m
> CONFIG_TINYDRM_ILI9486=m
> CONFIG_TINYDRM_MI0283QT=m
> # CONFIG_TINYDRM_REPAPER is not set
> # CONFIG_TINYDRM_ST7586 is not set
> CONFIG_TINYDRM_ST7735R=m
> # CONFIG_DRM_PL111 is not set
> CONFIG_DRM_TIDSS=m
> # CONFIG_DRM_SPRD is not set
> CONFIG_DRM_EXPORT_FOR_TESTS=y
> CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
> CONFIG_DRM_LIB_RANDOM=y
> 
> #
> # Frame buffer Devices
> #
> CONFIG_FB_CMDLINE=y
> CONFIG_FB_NOTIFY=y
> CONFIG_FB=y
> CONFIG_FIRMWARE_EDID=y
> CONFIG_FB_CFB_FILLRECT=m
> CONFIG_FB_CFB_COPYAREA=m
> CONFIG_FB_CFB_IMAGEBLIT=m
> CONFIG_FB_SYS_FILLRECT=y
> CONFIG_FB_SYS_COPYAREA=y
> CONFIG_FB_SYS_IMAGEBLIT=y
> CONFIG_FB_FOREIGN_ENDIAN=y
> CONFIG_FB_BOTH_ENDIAN=y
> # CONFIG_FB_BIG_ENDIAN is not set
> # CONFIG_FB_LITTLE_ENDIAN is not set
> CONFIG_FB_SYS_FOPS=y
> CONFIG_FB_DEFERRED_IO=y
> CONFIG_FB_BACKLIGHT=y
> CONFIG_FB_MODE_HELPERS=y
> # CONFIG_FB_TILEBLITTING is not set
> 
> #
> # Frame buffer hardware drivers
> #
> CONFIG_FB_ARMCLCD=m
> # CONFIG_FB_CLPS711X is not set
> # CONFIG_FB_IMX is not set
> # CONFIG_FB_ARC is not set
> # CONFIG_FB_CONTROL is not set
> # CONFIG_FB_GBE is not set
> # CONFIG_FB_PVR2 is not set
> # CONFIG_FB_OPENCORES is not set
> # CONFIG_FB_S1D13XXX is not set
> # CONFIG_FB_ATMEL is not set
> # CONFIG_FB_WM8505 is not set
> # CONFIG_FB_PXA168 is not set
> # CONFIG_FB_W100 is not set
> # CONFIG_FB_SH_MOBILE_LCDC is not set
> # CONFIG_FB_TMIO is not set
> # CONFIG_FB_S3C is not set
> # CONFIG_FB_SMSCUFX is not set
> CONFIG_FB_UDL=y
> # CONFIG_FB_IBM_GXT4500 is not set
> # CONFIG_FB_GOLDFISH is not set
> # CONFIG_FB_DA8XX is not set
> CONFIG_FB_VIRTUAL=y
> # CONFIG_FB_METRONOME is not set
> # CONFIG_FB_BROADSHEET is not set
> # CONFIG_FB_SIMPLE is not set
> CONFIG_FB_SSD1307=m
> # CONFIG_FB_OMAP is not set
> # CONFIG_FB_OMAP2 is not set
> # CONFIG_MMP_DISP is not set
> # end of Frame buffer Devices
> 
> #
> # Backlight & LCD device support
> #
> # CONFIG_LCD_CLASS_DEVICE is not set
> CONFIG_BACKLIGHT_CLASS_DEVICE=y
> CONFIG_BACKLIGHT_KTD253=m
> CONFIG_BACKLIGHT_LM3533=m
> # CONFIG_BACKLIGHT_OMAP1 is not set
> CONFIG_BACKLIGHT_PWM=y
> CONFIG_BACKLIGHT_QCOM_WLED=m
> CONFIG_BACKLIGHT_RT4831=m
> CONFIG_BACKLIGHT_WM831X=m
> # CONFIG_BACKLIGHT_ADP8860 is not set
> CONFIG_BACKLIGHT_ADP8870=m
> # CONFIG_BACKLIGHT_88PM860X is not set
> CONFIG_BACKLIGHT_LM3630A=m
> # CONFIG_BACKLIGHT_LM3639 is not set
> CONFIG_BACKLIGHT_LP855X=m
> CONFIG_BACKLIGHT_LP8788=m
> # CONFIG_BACKLIGHT_PANDORA is not set
> CONFIG_BACKLIGHT_SKY81452=y
> # CONFIG_BACKLIGHT_TPS65217 is not set
> CONFIG_BACKLIGHT_AS3711=y
> CONFIG_BACKLIGHT_GPIO=m
> # CONFIG_BACKLIGHT_LV5207LP is not set
> CONFIG_BACKLIGHT_BD6107=m
> # CONFIG_BACKLIGHT_ARCXCNN is not set
> CONFIG_BACKLIGHT_LED=y
> # end of Backlight & LCD device support
> 
> CONFIG_VIDEOMODE_HELPERS=y
> CONFIG_HDMI=y
> # CONFIG_LOGO is not set
> # end of Graphics support
> 
> # CONFIG_DRM_ACCEL is not set
> CONFIG_SOUND=y
> CONFIG_SOUND_OSS_CORE=y
> # CONFIG_SOUND_OSS_CORE_PRECLAIM is not set
> CONFIG_SND=m
> CONFIG_SND_TIMER=m
> CONFIG_SND_PCM=m
> CONFIG_SND_PCM_ELD=y
> CONFIG_SND_PCM_IEC958=y
> CONFIG_SND_DMAENGINE_PCM=m
> CONFIG_SND_RAWMIDI=m
> CONFIG_SND_JACK=y
> CONFIG_SND_JACK_INPUT_DEV=y
> CONFIG_SND_OSSEMUL=y
> CONFIG_SND_MIXER_OSS=m
> CONFIG_SND_PCM_OSS=m
> # CONFIG_SND_PCM_OSS_PLUGINS is not set
> # CONFIG_SND_PCM_TIMER is not set
> CONFIG_SND_HRTIMER=m
> CONFIG_SND_DYNAMIC_MINORS=y
> CONFIG_SND_MAX_CARDS=32
> # CONFIG_SND_SUPPORT_OLD_API is not set
> # CONFIG_SND_PROC_FS is not set
> # CONFIG_SND_VERBOSE_PRINTK is not set
> CONFIG_SND_CTL_FAST_LOOKUP=y
> # CONFIG_SND_DEBUG is not set
> # CONFIG_SND_CTL_INPUT_VALIDATION is not set
> CONFIG_SND_VMASTER=y
> CONFIG_SND_CTL_LED=m
> # CONFIG_SND_SEQUENCER is not set
> CONFIG_SND_AC97_CODEC=m
> CONFIG_SND_DRIVERS=y
> CONFIG_SND_DUMMY=m
> CONFIG_SND_ALOOP=m
> # CONFIG_SND_MTPAV is not set
> CONFIG_SND_MTS64=m
> # CONFIG_SND_SERIAL_U16550 is not set
> # CONFIG_SND_MPU401 is not set
> CONFIG_SND_PORTMAN2X4=m
> CONFIG_SND_AC97_POWER_SAVE=y
> CONFIG_SND_AC97_POWER_SAVE_DEFAULT=0
> 
> #
> # HD-Audio
> #
> CONFIG_SND_HDA=m
> CONFIG_SND_HDA_GENERIC_LEDS=y
> # CONFIG_SND_HDA_HWDEP is not set
> CONFIG_SND_HDA_RECONFIG=y
> CONFIG_SND_HDA_INPUT_BEEP=y
> CONFIG_SND_HDA_INPUT_BEEP_MODE=1
> CONFIG_SND_HDA_PATCH_LOADER=y
> # CONFIG_SND_HDA_CODEC_REALTEK is not set
> CONFIG_SND_HDA_CODEC_ANALOG=m
> CONFIG_SND_HDA_CODEC_SIGMATEL=m
> CONFIG_SND_HDA_CODEC_VIA=m
> CONFIG_SND_HDA_CODEC_HDMI=m
> CONFIG_SND_HDA_CODEC_CIRRUS=m
> CONFIG_SND_HDA_CODEC_CS8409=m
> CONFIG_SND_HDA_CODEC_CONEXANT=m
> CONFIG_SND_HDA_CODEC_CA0110=m
> CONFIG_SND_HDA_CODEC_CA0132=m
> CONFIG_SND_HDA_CODEC_CA0132_DSP=y
> CONFIG_SND_HDA_CODEC_CMEDIA=m
> CONFIG_SND_HDA_CODEC_SI3054=m
> CONFIG_SND_HDA_GENERIC=m
> CONFIG_SND_HDA_POWER_SAVE_DEFAULT=0
> # end of HD-Audio
> 
> CONFIG_SND_HDA_CORE=m
> CONFIG_SND_HDA_DSP_LOADER=y
> CONFIG_SND_HDA_EXT_CORE=m
> CONFIG_SND_HDA_PREALLOC_SIZE=64
> CONFIG_SND_ARM=y
> CONFIG_SND_ARMAACI=m
> 
> #
> # Atmel devices (AT91)
> #
> CONFIG_SND_ATMEL_AC97C=m
> # end of Atmel devices (AT91)
> 
> CONFIG_SND_SPI=y
> # CONFIG_SND_AT73C213 is not set
> # CONFIG_SND_USB is not set
> CONFIG_SND_SOC=m
> CONFIG_SND_SOC_AC97_BUS=y
> CONFIG_SND_SOC_GENERIC_DMAENGINE_PCM=y
> CONFIG_SND_SOC_UTILS_KUNIT_TEST=m
> # CONFIG_SND_SOC_ADI is not set
> CONFIG_SND_SOC_AMD_ACP=m
> CONFIG_SND_SOC_AMD_CZ_RT5645_MACH=m
> # CONFIG_SND_AMD_ACP_CONFIG is not set
> # CONFIG_SND_SOC_APPLE_MCA is not set
> CONFIG_SND_ATMEL_SOC=m
> CONFIG_SND_ATMEL_SOC_PDC=y
> CONFIG_SND_ATMEL_SOC_DMA=y
> CONFIG_SND_ATMEL_SOC_SSC=m
> CONFIG_SND_ATMEL_SOC_SSC_PDC=m
> CONFIG_SND_ATMEL_SOC_SSC_DMA=m
> CONFIG_SND_AT91_SOC_SAM9G20_WM8731=m
> CONFIG_SND_ATMEL_SOC_WM8904=m
> CONFIG_SND_AT91_SOC_SAM9X5_WM8731=m
> CONFIG_SND_ATMEL_SOC_CLASSD=m
> CONFIG_SND_ATMEL_SOC_PDMIC=m
> CONFIG_SND_ATMEL_SOC_TSE850_PCM5142=m
> CONFIG_SND_ATMEL_SOC_I2S=m
> CONFIG_SND_SOC_MIKROE_PROTO=m
> CONFIG_SND_MCHP_SOC_I2S_MCC=m
> CONFIG_SND_MCHP_SOC_SPDIFTX=m
> CONFIG_SND_MCHP_SOC_SPDIFRX=m
> CONFIG_SND_MCHP_SOC_PDMC=m
> # CONFIG_SND_BCM2835_SOC_I2S is not set
> # CONFIG_SND_SOC_CYGNUS is not set
> CONFIG_SND_BCM63XX_I2S_WHISTLER=m
> # CONFIG_SND_EP93XX_SOC is not set
> CONFIG_SND_DESIGNWARE_I2S=m
> # CONFIG_SND_DESIGNWARE_PCM is not set
> 
> #
> # SoC Audio for Freescale CPUs
> #
> 
> #
> # Common SoC Audio options for Freescale CPUs:
> #
> # CONFIG_SND_SOC_FSL_ASRC is not set
> # CONFIG_SND_SOC_FSL_SAI is not set
> CONFIG_SND_SOC_FSL_AUDMIX=m
> CONFIG_SND_SOC_FSL_SSI=m
> CONFIG_SND_SOC_FSL_SPDIF=m
> CONFIG_SND_SOC_FSL_ESAI=m
> # CONFIG_SND_SOC_FSL_MICFIL is not set
> CONFIG_SND_SOC_FSL_XCVR=m
> # CONFIG_SND_SOC_FSL_AUD2HTX is not set
> CONFIG_SND_SOC_FSL_UTILS=m
> CONFIG_SND_SOC_FSL_RPMSG=m
> CONFIG_SND_SOC_IMX_AUDMUX=m
> # CONFIG_SND_IMX_SOC is not set
> # end of SoC Audio for Freescale CPUs
> 
> CONFIG_SND_I2S_HI6210_I2S=m
> # CONFIG_SND_JZ4740_SOC_I2S is not set
> # CONFIG_SND_KIRKWOOD_SOC is not set
> # CONFIG_SND_SOC_IMG is not set
> CONFIG_SND_SOC_INTEL_SST_TOPLEVEL=y
> # CONFIG_SND_SOC_INTEL_KEEMBAY is not set
> CONFIG_SND_SOC_INTEL_MACH=y
> # CONFIG_SND_SOC_INTEL_USER_FRIENDLY_LONG_NAMES is not set
> # CONFIG_SND_SOC_MT8186 is not set
> CONFIG_SND_SOC_MTK_BTCVSD=m
> # CONFIG_SND_SOC_MT8195 is not set
> 
> #
> # ASoC support for Amlogic platforms
> #
> # CONFIG_SND_MESON_AIU is not set
> # CONFIG_SND_MESON_AXG_FRDDR is not set
> # CONFIG_SND_MESON_AXG_TODDR is not set
> # CONFIG_SND_MESON_AXG_TDMIN is not set
> # CONFIG_SND_MESON_AXG_TDMOUT is not set
> # CONFIG_SND_MESON_AXG_SOUND_CARD is not set
> # CONFIG_SND_MESON_AXG_SPDIFOUT is not set
> # CONFIG_SND_MESON_AXG_SPDIFIN is not set
> # CONFIG_SND_MESON_AXG_PDM is not set
> # CONFIG_SND_MESON_GX_SOUND_CARD is not set
> # CONFIG_SND_MESON_G12A_TOACODEC is not set
> # CONFIG_SND_MESON_G12A_TOHDMITX is not set
> # CONFIG_SND_SOC_MESON_T9015 is not set
> # end of ASoC support for Amlogic platforms
> 
> # CONFIG_SND_MXS_SOC is not set
> # CONFIG_SND_PXA2XX_SOC is not set
> # CONFIG_SND_SOC_QCOM is not set
> # CONFIG_SND_SOC_ROCKCHIP is not set
> # CONFIG_SND_SOC_SAMSUNG is not set
> 
> #
> # SoC Audio support for Renesas SoCs
> #
> # CONFIG_SND_SOC_SH4_FSI is not set
> # CONFIG_SND_SOC_RCAR is not set
> # CONFIG_SND_SOC_RZ is not set
> # end of SoC Audio support for Renesas SoCs
> 
> CONFIG_SND_SOC_SOF_TOPLEVEL=y
> # CONFIG_SND_SOC_SOF_ACPI is not set
> # CONFIG_SND_SOC_SOF_OF is not set
> # CONFIG_SND_SOC_SOF_AMD_TOPLEVEL is not set
> # CONFIG_SND_SOC_SOF_INTEL_TOPLEVEL is not set
> # CONFIG_SND_SOC_SPRD is not set
> # CONFIG_SND_SOC_STI is not set
> 
> #
> # STMicroelectronics STM32 SOC audio support
> #
> CONFIG_SND_SOC_STM32_SAI=m
> # CONFIG_SND_SOC_STM32_I2S is not set
> CONFIG_SND_SOC_STM32_SPDIFRX=m
> # CONFIG_SND_SOC_STM32_DFSDM is not set
> # end of STMicroelectronics STM32 SOC audio support
> 
> #
> # Allwinner SoC Audio support
> #
> # CONFIG_SND_SUN4I_CODEC is not set
> # CONFIG_SND_SUN8I_CODEC is not set
> # CONFIG_SND_SUN8I_CODEC_ANALOG is not set
> # CONFIG_SND_SUN50I_CODEC_ANALOG is not set
> # CONFIG_SND_SUN4I_I2S is not set
> # CONFIG_SND_SUN4I_SPDIF is not set
> # CONFIG_SND_SUN50I_DMIC is not set
> # end of Allwinner SoC Audio support
> 
> # CONFIG_SND_SOC_TEGRA is not set
> 
> #
> # Audio support for Texas Instruments SoCs
> #
> 
> #
> # Texas Instruments DAI support for:
> #
> # CONFIG_SND_SOC_DAVINCI_ASP is not set
> # CONFIG_SND_SOC_DAVINCI_MCASP is not set
> # CONFIG_SND_SOC_DAVINCI_VCIF is not set
> # CONFIG_SND_SOC_OMAP_DMIC is not set
> # CONFIG_SND_SOC_OMAP_MCBSP is not set
> # CONFIG_SND_SOC_OMAP_MCPDM is not set
> 
> #
> # Audio support for boards with Texas Instruments SoCs
> #
> # CONFIG_SND_SOC_OMAP3_TWL4030 is not set
> # CONFIG_SND_SOC_OMAP_ABE_TWL6040 is not set
> # CONFIG_SND_SOC_OMAP_HDMI is not set
> # CONFIG_SND_SOC_J721E_EVM is not set
> # end of Audio support for Texas Instruments SoCs
> 
> # CONFIG_SND_SOC_UNIPHIER is not set
> CONFIG_SND_SOC_XILINX_I2S=m
> CONFIG_SND_SOC_XILINX_AUDIO_FORMATTER=m
> CONFIG_SND_SOC_XILINX_SPDIF=m
> CONFIG_SND_SOC_XTFPGA_I2S=m
> CONFIG_SND_SOC_I2C_AND_SPI=m
> 
> #
> # CODEC drivers
> #
> # CONFIG_SND_SOC_ALL_CODECS is not set
> CONFIG_SND_SOC_AC97_CODEC=m
> CONFIG_SND_SOC_ADAU_UTILS=m
> CONFIG_SND_SOC_ADAU1372=m
> # CONFIG_SND_SOC_ADAU1372_I2C is not set
> CONFIG_SND_SOC_ADAU1372_SPI=m
> # CONFIG_SND_SOC_ADAU1701 is not set
> CONFIG_SND_SOC_ADAU17X1=m
> CONFIG_SND_SOC_ADAU1761=m
> CONFIG_SND_SOC_ADAU1761_I2C=m
> # CONFIG_SND_SOC_ADAU1761_SPI is not set
> CONFIG_SND_SOC_ADAU7002=m
> CONFIG_SND_SOC_ADAU7118=m
> CONFIG_SND_SOC_ADAU7118_HW=m
> # CONFIG_SND_SOC_ADAU7118_I2C is not set
> CONFIG_SND_SOC_AK4104=m
> # CONFIG_SND_SOC_AK4118 is not set
> CONFIG_SND_SOC_AK4375=m
> # CONFIG_SND_SOC_AK4458 is not set
> CONFIG_SND_SOC_AK4554=m
> CONFIG_SND_SOC_AK4613=m
> CONFIG_SND_SOC_AK4642=m
> CONFIG_SND_SOC_AK5386=m
> # CONFIG_SND_SOC_AK5558 is not set
> # CONFIG_SND_SOC_ALC5623 is not set
> CONFIG_SND_SOC_AW8738=m
> CONFIG_SND_SOC_BD28623=m
> CONFIG_SND_SOC_BT_SCO=m
> # CONFIG_SND_SOC_CPCAP is not set
> # CONFIG_SND_SOC_CS35L32 is not set
> # CONFIG_SND_SOC_CS35L33 is not set
> CONFIG_SND_SOC_CS35L34=m
> # CONFIG_SND_SOC_CS35L35 is not set
> CONFIG_SND_SOC_CS35L36=m
> # CONFIG_SND_SOC_CS35L41_SPI is not set
> # CONFIG_SND_SOC_CS35L41_I2C is not set
> CONFIG_SND_SOC_CS35L45_TABLES=m
> CONFIG_SND_SOC_CS35L45=m
> # CONFIG_SND_SOC_CS35L45_SPI is not set
> CONFIG_SND_SOC_CS35L45_I2C=m
> CONFIG_SND_SOC_CS42L42_CORE=m
> # CONFIG_SND_SOC_CS42L42 is not set
> CONFIG_SND_SOC_CS42L51=m
> CONFIG_SND_SOC_CS42L51_I2C=m
> CONFIG_SND_SOC_CS42L52=m
> # CONFIG_SND_SOC_CS42L56 is not set
> CONFIG_SND_SOC_CS42L73=m
> CONFIG_SND_SOC_CS42L83=m
> CONFIG_SND_SOC_CS4234=m
> # CONFIG_SND_SOC_CS4265 is not set
> # CONFIG_SND_SOC_CS4270 is not set
> CONFIG_SND_SOC_CS4271=m
> CONFIG_SND_SOC_CS4271_I2C=m
> # CONFIG_SND_SOC_CS4271_SPI is not set
> CONFIG_SND_SOC_CS42XX8=m
> CONFIG_SND_SOC_CS42XX8_I2C=m
> CONFIG_SND_SOC_CS43130=m
> # CONFIG_SND_SOC_CS4341 is not set
> CONFIG_SND_SOC_CS4349=m
> CONFIG_SND_SOC_CS53L30=m
> # CONFIG_SND_SOC_CX2072X is not set
> # CONFIG_SND_SOC_JZ4740_CODEC is not set
> # CONFIG_SND_SOC_JZ4725B_CODEC is not set
> # CONFIG_SND_SOC_JZ4760_CODEC is not set
> # CONFIG_SND_SOC_JZ4770_CODEC is not set
> CONFIG_SND_SOC_DA7213=m
> # CONFIG_SND_SOC_DMIC is not set
> CONFIG_SND_SOC_HDMI_CODEC=m
> CONFIG_SND_SOC_ES7134=m
> # CONFIG_SND_SOC_ES7241 is not set
> CONFIG_SND_SOC_ES8316=m
> CONFIG_SND_SOC_ES8326=m
> CONFIG_SND_SOC_ES8328=m
> CONFIG_SND_SOC_ES8328_I2C=m
> # CONFIG_SND_SOC_ES8328_SPI is not set
> CONFIG_SND_SOC_GTM601=m
> CONFIG_SND_SOC_HDA=m
> CONFIG_SND_SOC_ICS43432=m
> CONFIG_SND_SOC_INNO_RK3036=m
> # CONFIG_SND_SOC_LOCHNAGAR_SC is not set
> # CONFIG_SND_SOC_MAX98088 is not set
> CONFIG_SND_SOC_MAX98357A=m
> CONFIG_SND_SOC_MAX98504=m
> CONFIG_SND_SOC_MAX9867=m
> CONFIG_SND_SOC_MAX98927=m
> CONFIG_SND_SOC_MAX98520=m
> CONFIG_SND_SOC_MAX98373=m
> CONFIG_SND_SOC_MAX98373_I2C=m
> # CONFIG_SND_SOC_MAX98373_SDW is not set
> # CONFIG_SND_SOC_MAX98390 is not set
> CONFIG_SND_SOC_MAX98396=m
> # CONFIG_SND_SOC_MAX9860 is not set
> CONFIG_SND_SOC_MSM8916_WCD_ANALOG=m
> # CONFIG_SND_SOC_MSM8916_WCD_DIGITAL is not set
> # CONFIG_SND_SOC_PCM1681 is not set
> CONFIG_SND_SOC_PCM1789=m
> CONFIG_SND_SOC_PCM1789_I2C=m
> # CONFIG_SND_SOC_PCM179X_I2C is not set
> # CONFIG_SND_SOC_PCM179X_SPI is not set
> CONFIG_SND_SOC_PCM186X=m
> # CONFIG_SND_SOC_PCM186X_I2C is not set
> CONFIG_SND_SOC_PCM186X_SPI=m
> CONFIG_SND_SOC_PCM3060=m
> CONFIG_SND_SOC_PCM3060_I2C=m
> CONFIG_SND_SOC_PCM3060_SPI=m
> CONFIG_SND_SOC_PCM3168A=m
> CONFIG_SND_SOC_PCM3168A_I2C=m
> # CONFIG_SND_SOC_PCM3168A_SPI is not set
> # CONFIG_SND_SOC_PCM5102A is not set
> CONFIG_SND_SOC_PCM512x=m
> CONFIG_SND_SOC_PCM512x_I2C=m
> CONFIG_SND_SOC_PCM512x_SPI=m
> CONFIG_SND_SOC_RK3328=m
> # CONFIG_SND_SOC_RK817 is not set
> CONFIG_SND_SOC_RL6231=m
> CONFIG_SND_SOC_RT1308_SDW=m
> # CONFIG_SND_SOC_RT1316_SDW is not set
> # CONFIG_SND_SOC_RT1318_SDW is not set
> CONFIG_SND_SOC_RT5616=m
> CONFIG_SND_SOC_RT5631=m
> CONFIG_SND_SOC_RT5640=m
> CONFIG_SND_SOC_RT5645=m
> CONFIG_SND_SOC_RT5659=m
> # CONFIG_SND_SOC_RT5682_SDW is not set
> CONFIG_SND_SOC_RT700=m
> CONFIG_SND_SOC_RT700_SDW=m
> CONFIG_SND_SOC_RT711=m
> CONFIG_SND_SOC_RT711_SDW=m
> CONFIG_SND_SOC_RT711_SDCA_SDW=m
> CONFIG_SND_SOC_RT715=m
> CONFIG_SND_SOC_RT715_SDW=m
> CONFIG_SND_SOC_RT715_SDCA_SDW=m
> CONFIG_SND_SOC_RT9120=m
> CONFIG_SND_SOC_SDW_MOCKUP=m
> CONFIG_SND_SOC_SGTL5000=m
> CONFIG_SND_SOC_SIGMADSP=m
> CONFIG_SND_SOC_SIGMADSP_REGMAP=m
> # CONFIG_SND_SOC_SIMPLE_AMPLIFIER is not set
> # CONFIG_SND_SOC_SIMPLE_MUX is not set
> CONFIG_SND_SOC_SPDIF=m
> CONFIG_SND_SOC_SRC4XXX_I2C=m
> CONFIG_SND_SOC_SRC4XXX=m
> CONFIG_SND_SOC_SSM2305=m
> CONFIG_SND_SOC_SSM2518=m
> CONFIG_SND_SOC_SSM2602=m
> # CONFIG_SND_SOC_SSM2602_SPI is not set
> CONFIG_SND_SOC_SSM2602_I2C=m
> CONFIG_SND_SOC_SSM4567=m
> CONFIG_SND_SOC_STA32X=m
> CONFIG_SND_SOC_STA350=m
> CONFIG_SND_SOC_STI_SAS=m
> # CONFIG_SND_SOC_TAS2552 is not set
> # CONFIG_SND_SOC_TAS2562 is not set
> CONFIG_SND_SOC_TAS2764=m
> CONFIG_SND_SOC_TAS2770=m
> CONFIG_SND_SOC_TAS2780=m
> # CONFIG_SND_SOC_TAS5086 is not set
> CONFIG_SND_SOC_TAS571X=m
> CONFIG_SND_SOC_TAS5720=m
> CONFIG_SND_SOC_TAS5805M=m
> CONFIG_SND_SOC_TAS6424=m
> CONFIG_SND_SOC_TDA7419=m
> # CONFIG_SND_SOC_TFA9879 is not set
> # CONFIG_SND_SOC_TFA989X is not set
> CONFIG_SND_SOC_TLV320ADC3XXX=m
> CONFIG_SND_SOC_TLV320AIC23=m
> CONFIG_SND_SOC_TLV320AIC23_I2C=m
> CONFIG_SND_SOC_TLV320AIC23_SPI=m
> CONFIG_SND_SOC_TLV320AIC31XX=m
> CONFIG_SND_SOC_TLV320AIC32X4=m
> CONFIG_SND_SOC_TLV320AIC32X4_I2C=m
> CONFIG_SND_SOC_TLV320AIC32X4_SPI=m
> CONFIG_SND_SOC_TLV320AIC3X=m
> CONFIG_SND_SOC_TLV320AIC3X_I2C=m
> CONFIG_SND_SOC_TLV320AIC3X_SPI=m
> CONFIG_SND_SOC_TLV320ADCX140=m
> CONFIG_SND_SOC_TS3A227E=m
> CONFIG_SND_SOC_TSCS42XX=m
> CONFIG_SND_SOC_TSCS454=m
> # CONFIG_SND_SOC_UDA1334 is not set
> # CONFIG_SND_SOC_WCD9335 is not set
> CONFIG_SND_SOC_WCD_MBHC=m
> # CONFIG_SND_SOC_WCD934X is not set
> CONFIG_SND_SOC_WCD938X=m
> CONFIG_SND_SOC_WCD938X_SDW=m
> # CONFIG_SND_SOC_WM8510 is not set
> # CONFIG_SND_SOC_WM8523 is not set
> CONFIG_SND_SOC_WM8524=m
> CONFIG_SND_SOC_WM8580=m
> CONFIG_SND_SOC_WM8711=m
> CONFIG_SND_SOC_WM8728=m
> CONFIG_SND_SOC_WM8731=m
> CONFIG_SND_SOC_WM8731_I2C=m
> # CONFIG_SND_SOC_WM8731_SPI is not set
> CONFIG_SND_SOC_WM8737=m
> CONFIG_SND_SOC_WM8741=m
> # CONFIG_SND_SOC_WM8750 is not set
> # CONFIG_SND_SOC_WM8753 is not set
> CONFIG_SND_SOC_WM8770=m
> # CONFIG_SND_SOC_WM8776 is not set
> # CONFIG_SND_SOC_WM8782 is not set
> CONFIG_SND_SOC_WM8804=m
> # CONFIG_SND_SOC_WM8804_I2C is not set
> CONFIG_SND_SOC_WM8804_SPI=m
> CONFIG_SND_SOC_WM8903=m
> CONFIG_SND_SOC_WM8904=m
> CONFIG_SND_SOC_WM8940=m
> CONFIG_SND_SOC_WM8960=m
> # CONFIG_SND_SOC_WM8961 is not set
> CONFIG_SND_SOC_WM8962=m
> CONFIG_SND_SOC_WM8974=m
> CONFIG_SND_SOC_WM8978=m
> CONFIG_SND_SOC_WM8985=m
> CONFIG_SND_SOC_WSA881X=m
> # CONFIG_SND_SOC_WSA883X is not set
> CONFIG_SND_SOC_ZL38060=m
> # CONFIG_SND_SOC_MAX9759 is not set
> # CONFIG_SND_SOC_MT6351 is not set
> CONFIG_SND_SOC_MT6358=m
> # CONFIG_SND_SOC_MT6660 is not set
> CONFIG_SND_SOC_NAU8315=m
> CONFIG_SND_SOC_NAU8540=m
> # CONFIG_SND_SOC_NAU8810 is not set
> CONFIG_SND_SOC_NAU8821=m
> # CONFIG_SND_SOC_NAU8822 is not set
> CONFIG_SND_SOC_NAU8824=m
> CONFIG_SND_SOC_TPA6130A2=m
> CONFIG_SND_SOC_LPASS_MACRO_COMMON=m
> # CONFIG_SND_SOC_LPASS_WSA_MACRO is not set
> # CONFIG_SND_SOC_LPASS_VA_MACRO is not set
> CONFIG_SND_SOC_LPASS_RX_MACRO=m
> # CONFIG_SND_SOC_LPASS_TX_MACRO is not set
> # end of CODEC drivers
> 
> CONFIG_SND_SIMPLE_CARD_UTILS=m
> # CONFIG_SND_SIMPLE_CARD is not set
> CONFIG_SND_AUDIO_GRAPH_CARD=m
> CONFIG_SND_AUDIO_GRAPH_CARD2=m
> CONFIG_SND_AUDIO_GRAPH_CARD2_CUSTOM_SAMPLE=m
> CONFIG_SND_TEST_COMPONENT=m
> CONFIG_SND_VIRTIO=m
> CONFIG_AC97_BUS=m
> 
> #
> # HID support
> #
> CONFIG_HID=y
> CONFIG_HID_BATTERY_STRENGTH=y
> # CONFIG_HIDRAW is not set
> # CONFIG_UHID is not set
> CONFIG_HID_GENERIC=y
> 
> #
> # Special HID drivers
> #
> CONFIG_HID_A4TECH=y
> # CONFIG_HID_ACCUTOUCH is not set
> CONFIG_HID_ACRUX=y
> CONFIG_HID_ACRUX_FF=y
> CONFIG_HID_APPLE=m
> # CONFIG_HID_APPLEIR is not set
> CONFIG_HID_ASUS=m
> # CONFIG_HID_AUREAL is not set
> # CONFIG_HID_BELKIN is not set
> CONFIG_HID_BETOP_FF=y
> CONFIG_HID_BIGBEN_FF=m
> # CONFIG_HID_CHERRY is not set
> CONFIG_HID_CHICONY=m
> # CONFIG_HID_CORSAIR is not set
> # CONFIG_HID_COUGAR is not set
> CONFIG_HID_MACALLY=y
> # CONFIG_HID_PRODIKEYS is not set
> CONFIG_HID_CMEDIA=m
> CONFIG_HID_CREATIVE_SB0540=y
> # CONFIG_HID_CYPRESS is not set
> # CONFIG_HID_DRAGONRISE is not set
> CONFIG_HID_EMS_FF=y
> # CONFIG_HID_ELAN is not set
> CONFIG_HID_ELECOM=y
> # CONFIG_HID_ELO is not set
> # CONFIG_HID_EZKEY is not set
> CONFIG_HID_GEMBIRD=m
> CONFIG_HID_GFRM=m
> CONFIG_HID_GLORIOUS=m
> # CONFIG_HID_HOLTEK is not set
> # CONFIG_HID_VIVALDI is not set
> # CONFIG_HID_GT683R is not set
> # CONFIG_HID_KEYTOUCH is not set
> # CONFIG_HID_KYE is not set
> CONFIG_HID_UCLOGIC=y
> CONFIG_HID_WALTOP=y
> CONFIG_HID_VIEWSONIC=m
> # CONFIG_HID_VRC2 is not set
> # CONFIG_HID_XIAOMI is not set
> CONFIG_HID_GYRATION=m
> # CONFIG_HID_ICADE is not set
> CONFIG_HID_ITE=m
> # CONFIG_HID_JABRA is not set
> CONFIG_HID_TWINHAN=m
> # CONFIG_HID_KENSINGTON is not set
> CONFIG_HID_LCPOWER=y
> CONFIG_HID_LED=m
> CONFIG_HID_LENOVO=y
> CONFIG_HID_LETSKETCH=y
> CONFIG_HID_LOGITECH=m
> CONFIG_HID_LOGITECH_HIDPP=m
> # CONFIG_LOGITECH_FF is not set
> CONFIG_LOGIRUMBLEPAD2_FF=y
> CONFIG_LOGIG940_FF=y
> # CONFIG_LOGIWHEELS_FF is not set
> # CONFIG_HID_MAGICMOUSE is not set
> CONFIG_HID_MALTRON=m
> CONFIG_HID_MAYFLASH=m
> CONFIG_HID_MEGAWORLD_FF=m
> CONFIG_HID_REDRAGON=m
> # CONFIG_HID_MICROSOFT is not set
> CONFIG_HID_MONTEREY=y
> CONFIG_HID_MULTITOUCH=y
> CONFIG_HID_NINTENDO=y
> # CONFIG_NINTENDO_FF is not set
> # CONFIG_HID_NTI is not set
> CONFIG_HID_NTRIG=m
> # CONFIG_HID_ORTEK is not set
> CONFIG_HID_PANTHERLORD=m
> CONFIG_PANTHERLORD_FF=y
> CONFIG_HID_PENMOUNT=m
> CONFIG_HID_PETALYNX=m
> # CONFIG_HID_PICOLCD is not set
> CONFIG_HID_PLANTRONICS=y
> CONFIG_HID_PLAYSTATION=y
> # CONFIG_PLAYSTATION_FF is not set
> CONFIG_HID_PXRC=y
> # CONFIG_HID_RAZER is not set
> # CONFIG_HID_PRIMAX is not set
> # CONFIG_HID_RETRODE is not set
> # CONFIG_HID_ROCCAT is not set
> CONFIG_HID_SAITEK=y
> CONFIG_HID_SAMSUNG=m
> CONFIG_HID_SEMITEK=m
> CONFIG_HID_SIGMAMICRO=m
> # CONFIG_HID_SONY is not set
> # CONFIG_HID_SPEEDLINK is not set
> # CONFIG_HID_STEAM is not set
> CONFIG_HID_STEELSERIES=m
> # CONFIG_HID_SUNPLUS is not set
> # CONFIG_HID_RMI is not set
> CONFIG_HID_GREENASIA=y
> CONFIG_GREENASIA_FF=y
> # CONFIG_HID_SMARTJOYPLUS is not set
> CONFIG_HID_TIVO=y
> CONFIG_HID_TOPSEED=m
> # CONFIG_HID_TOPRE is not set
> CONFIG_HID_THINGM=m
> # CONFIG_HID_THRUSTMASTER is not set
> CONFIG_HID_UDRAW_PS3=m
> CONFIG_HID_U2FZERO=m
> # CONFIG_HID_WACOM is not set
> # CONFIG_HID_WIIMOTE is not set
> CONFIG_HID_XINMO=y
> # CONFIG_HID_ZEROPLUS is not set
> CONFIG_HID_ZYDACRON=m
> CONFIG_HID_SENSOR_HUB=m
> CONFIG_HID_SENSOR_CUSTOM_SENSOR=m
> # CONFIG_HID_ALPS is not set
> # CONFIG_HID_MCP2221 is not set
> # end of Special HID drivers
> 
> #
> # USB HID support
> #
> CONFIG_USB_HID=y
> CONFIG_HID_PID=y
> # CONFIG_USB_HIDDEV is not set
> # end of USB HID support
> 
> #
> # I2C HID support
> #
> CONFIG_I2C_HID_OF=y
> # CONFIG_I2C_HID_OF_ELAN is not set
> CONFIG_I2C_HID_OF_GOODIX=m
> # end of I2C HID support
> 
> CONFIG_I2C_HID_CORE=y
> # end of HID support
> 
> CONFIG_USB_OHCI_LITTLE_ENDIAN=y
> CONFIG_USB_SUPPORT=y
> CONFIG_USB_COMMON=y
> CONFIG_USB_LED_TRIG=y
> CONFIG_USB_ULPI_BUS=m
> # CONFIG_USB_CONN_GPIO is not set
> CONFIG_USB_ARCH_HAS_HCD=y
> CONFIG_USB=y
> CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
> 
> #
> # Miscellaneous USB options
> #
> # CONFIG_USB_DEFAULT_PERSIST is not set
> # CONFIG_USB_FEW_INIT_RETRIES is not set
> CONFIG_USB_DYNAMIC_MINORS=y
> # CONFIG_USB_OTG is not set
> CONFIG_USB_OTG_PRODUCTLIST=y
> # CONFIG_USB_OTG_DISABLE_EXTERNAL_HUB is not set
> CONFIG_USB_LEDS_TRIGGER_USBPORT=y
> CONFIG_USB_AUTOSUSPEND_DELAY=2
> # CONFIG_USB_MON is not set
> 
> #
> # USB Host Controller Drivers
> #
> CONFIG_USB_C67X00_HCD=m
> # CONFIG_USB_XHCI_HCD is not set
> # CONFIG_USB_BRCMSTB is not set
> CONFIG_USB_EHCI_HCD=y
> CONFIG_USB_EHCI_ROOT_HUB_TT=y
> # CONFIG_USB_EHCI_TT_NEWSCHED is not set
> CONFIG_USB_EHCI_FSL=y
> # CONFIG_USB_EHCI_HCD_NPCM7XX is not set
> CONFIG_USB_EHCI_HCD_OMAP=m
> # CONFIG_USB_EHCI_HCD_ORION is not set
> # CONFIG_USB_EHCI_HCD_SPEAR is not set
> # CONFIG_USB_EHCI_HCD_STI is not set
> CONFIG_USB_EHCI_HCD_AT91=y
> # CONFIG_USB_EHCI_SH is not set
> # CONFIG_USB_EHCI_EXYNOS is not set
> # CONFIG_USB_EHCI_MV is not set
> # CONFIG_USB_CNS3XXX_EHCI is not set
> CONFIG_USB_EHCI_HCD_PLATFORM=y
> # CONFIG_USB_OXU210HP_HCD is not set
> CONFIG_USB_ISP116X_HCD=m
> # CONFIG_USB_ISP1362_HCD is not set
> # CONFIG_USB_MAX3421_HCD is not set
> CONFIG_USB_OHCI_HCD=y
> # CONFIG_USB_OHCI_HCD_SPEAR is not set
> # CONFIG_USB_OHCI_HCD_STI is not set
> # CONFIG_USB_OHCI_HCD_S3C2410 is not set
> CONFIG_USB_OHCI_HCD_LPC32XX=m
> CONFIG_USB_OHCI_HCD_AT91=m
> # CONFIG_USB_OHCI_HCD_OMAP3 is not set
> # CONFIG_USB_OHCI_HCD_DAVINCI is not set
> CONFIG_USB_OHCI_HCD_SSB=y
> # CONFIG_USB_OHCI_SH is not set
> # CONFIG_USB_OHCI_EXYNOS is not set
> # CONFIG_USB_CNS3XXX_OHCI is not set
> CONFIG_USB_OHCI_HCD_PLATFORM=y
> # CONFIG_USB_U132_HCD is not set
> # CONFIG_USB_SL811_HCD is not set
> CONFIG_USB_R8A66597_HCD=y
> # CONFIG_USB_HCD_BCMA is not set
> CONFIG_USB_HCD_SSB=y
> CONFIG_USB_HCD_TEST_MODE=y
> 
> #
> # USB Device Class drivers
> #
> CONFIG_USB_ACM=m
> CONFIG_USB_PRINTER=y
> # CONFIG_USB_WDM is not set
> CONFIG_USB_TMC=m
> 
> #
> # NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
> #
> 
> #
> # also be needed; see USB_STORAGE Help for more info
> #
> # CONFIG_USB_STORAGE is not set
> 
> #
> # USB Imaging devices
> #
> CONFIG_USB_MDC800=y
> CONFIG_USB_MICROTEK=m
> 
> #
> # USB dual-mode controller drivers
> #
> # CONFIG_USB_CDNS_SUPPORT is not set
> # CONFIG_USB_FOTG210 is not set
> # CONFIG_USB_MTU3 is not set
> # CONFIG_USB_MUSB_HDRC is not set
> # CONFIG_USB_DWC3 is not set
> CONFIG_USB_DWC2=y
> CONFIG_USB_DWC2_HOST=y
> 
> #
> # Gadget/Dual-role mode requires USB Gadget support to be enabled
> #
> CONFIG_USB_DWC2_DEBUG=y
> # CONFIG_USB_DWC2_VERBOSE is not set
> CONFIG_USB_DWC2_TRACK_MISSED_SOFS=y
> CONFIG_USB_DWC2_DEBUG_PERIODIC=y
> # CONFIG_USB_CHIPIDEA is not set
> CONFIG_USB_ISP1760=y
> CONFIG_USB_ISP1760_HCD=y
> CONFIG_USB_ISP1760_HOST_ROLE=y
> 
> #
> # USB port drivers
> #
> # CONFIG_USB_USS720 is not set
> CONFIG_USB_SERIAL=y
> # CONFIG_USB_SERIAL_CONSOLE is not set
> CONFIG_USB_SERIAL_GENERIC=y
> CONFIG_USB_SERIAL_SIMPLE=y
> CONFIG_USB_SERIAL_AIRCABLE=y
> CONFIG_USB_SERIAL_ARK3116=y
> # CONFIG_USB_SERIAL_BELKIN is not set
> CONFIG_USB_SERIAL_CH341=y
> CONFIG_USB_SERIAL_WHITEHEAT=y
> CONFIG_USB_SERIAL_DIGI_ACCELEPORT=y
> CONFIG_USB_SERIAL_CP210X=m
> CONFIG_USB_SERIAL_CYPRESS_M8=y
> CONFIG_USB_SERIAL_EMPEG=y
> CONFIG_USB_SERIAL_FTDI_SIO=m
> CONFIG_USB_SERIAL_VISOR=m
> # CONFIG_USB_SERIAL_IPAQ is not set
> # CONFIG_USB_SERIAL_IR is not set
> CONFIG_USB_SERIAL_EDGEPORT=m
> CONFIG_USB_SERIAL_EDGEPORT_TI=m
> # CONFIG_USB_SERIAL_F81232 is not set
> CONFIG_USB_SERIAL_F8153X=y
> CONFIG_USB_SERIAL_GARMIN=y
> CONFIG_USB_SERIAL_IPW=y
> CONFIG_USB_SERIAL_IUU=y
> # CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
> # CONFIG_USB_SERIAL_KEYSPAN is not set
> # CONFIG_USB_SERIAL_KLSI is not set
> CONFIG_USB_SERIAL_KOBIL_SCT=m
> CONFIG_USB_SERIAL_MCT_U232=m
> # CONFIG_USB_SERIAL_METRO is not set
> CONFIG_USB_SERIAL_MOS7720=y
> CONFIG_USB_SERIAL_MOS7840=y
> # CONFIG_USB_SERIAL_MXUPORT is not set
> CONFIG_USB_SERIAL_NAVMAN=m
> # CONFIG_USB_SERIAL_PL2303 is not set
> CONFIG_USB_SERIAL_OTI6858=y
> # CONFIG_USB_SERIAL_QCAUX is not set
> CONFIG_USB_SERIAL_QUALCOMM=y
> CONFIG_USB_SERIAL_SPCP8X5=y
> CONFIG_USB_SERIAL_SAFE=m
> # CONFIG_USB_SERIAL_SAFE_PADDED is not set
> # CONFIG_USB_SERIAL_SIERRAWIRELESS is not set
> CONFIG_USB_SERIAL_SYMBOL=m
> CONFIG_USB_SERIAL_TI=m
> CONFIG_USB_SERIAL_CYBERJACK=m
> CONFIG_USB_SERIAL_WWAN=y
> CONFIG_USB_SERIAL_OPTION=y
> # CONFIG_USB_SERIAL_OMNINET is not set
> CONFIG_USB_SERIAL_OPTICON=y
> CONFIG_USB_SERIAL_XSENS_MT=m
> CONFIG_USB_SERIAL_WISHBONE=y
> CONFIG_USB_SERIAL_SSU100=m
> CONFIG_USB_SERIAL_QT2=y
> CONFIG_USB_SERIAL_UPD78F0730=y
> CONFIG_USB_SERIAL_XR=m
> CONFIG_USB_SERIAL_DEBUG=m
> 
> #
> # USB Miscellaneous drivers
> #
> CONFIG_USB_EMI62=m
> CONFIG_USB_EMI26=y
> CONFIG_USB_ADUTUX=y
> CONFIG_USB_SEVSEG=y
> CONFIG_USB_LEGOTOWER=y
> # CONFIG_USB_LCD is not set
> CONFIG_USB_CYPRESS_CY7C63=m
> CONFIG_USB_CYTHERM=m
> CONFIG_USB_IDMOUSE=y
> CONFIG_USB_FTDI_ELAN=y
> CONFIG_USB_APPLEDISPLAY=m
> # CONFIG_USB_QCOM_EUD is not set
> # CONFIG_APPLE_MFI_FASTCHARGE is not set
> CONFIG_USB_SISUSBVGA=y
> # CONFIG_USB_LD is not set
> CONFIG_USB_TRANCEVIBRATOR=m
> CONFIG_USB_IOWARRIOR=y
> CONFIG_USB_TEST=y
> CONFIG_USB_EHSET_TEST_FIXTURE=y
> # CONFIG_USB_ISIGHTFW is not set
> # CONFIG_USB_YUREX is not set
> CONFIG_USB_EZUSB_FX2=y
> # CONFIG_USB_HUB_USB251XB is not set
> CONFIG_USB_HSIC_USB3503=m
> # CONFIG_USB_HSIC_USB4604 is not set
> CONFIG_USB_LINK_LAYER_TEST=m
> CONFIG_USB_CHAOSKEY=m
> # CONFIG_BRCM_USB_PINMAP is not set
> # CONFIG_USB_ONBOARD_HUB is not set
> 
> #
> # USB Physical Layer drivers
> #
> CONFIG_USB_PHY=y
> # CONFIG_ISP1301_OMAP is not set
> # CONFIG_KEYSTONE_USB_PHY is not set
> CONFIG_NOP_USB_XCEIV=m
> CONFIG_AM335X_CONTROL_USB=m
> CONFIG_AM335X_PHY_USB=m
> CONFIG_USB_GPIO_VBUS=y
> CONFIG_TAHVO_USB=m
> # CONFIG_TAHVO_USB_HOST_BY_DEFAULT is not set
> CONFIG_USB_ISP1301=m
> # CONFIG_USB_TEGRA_PHY is not set
> # CONFIG_USB_ULPI is not set
> # end of USB Physical Layer drivers
> 
> # CONFIG_USB_GADGET is not set
> # CONFIG_TYPEC is not set
> CONFIG_USB_ROLE_SWITCH=y
> CONFIG_MMC=y
> CONFIG_PWRSEQ_EMMC=m
> CONFIG_PWRSEQ_SIMPLE=y
> CONFIG_MMC_BLOCK=y
> CONFIG_MMC_BLOCK_MINORS=8
> CONFIG_SDIO_UART=y
> CONFIG_MMC_TEST=m
> 
> #
> # MMC/SD/SDIO Host Controller Drivers
> #
> CONFIG_MMC_DEBUG=y
> # CONFIG_MMC_SUNPLUS is not set
> # CONFIG_MMC_ARMMMCI is not set
> CONFIG_MMC_SDHCI=m
> CONFIG_MMC_SDHCI_IO_ACCESSORS=y
> CONFIG_MMC_SDHCI_PLTFM=m
> CONFIG_MMC_SDHCI_OF_ARASAN=m
> # CONFIG_MMC_SDHCI_OF_ASPEED is not set
> CONFIG_MMC_SDHCI_OF_AT91=m
> # CONFIG_MMC_SDHCI_OF_ESDHC is not set
> CONFIG_MMC_SDHCI_OF_DWCMSHC=m
> # CONFIG_MMC_SDHCI_OF_SPARX5 is not set
> # CONFIG_MMC_SDHCI_CADENCE is not set
> # CONFIG_MMC_SDHCI_CNS3XXX is not set
> # CONFIG_MMC_SDHCI_ESDHC_IMX is not set
> # CONFIG_MMC_SDHCI_DOVE is not set
> # CONFIG_MMC_SDHCI_TEGRA is not set
> # CONFIG_MMC_SDHCI_S3C is not set
> # CONFIG_MMC_SDHCI_PXAV3 is not set
> # CONFIG_MMC_SDHCI_PXAV2 is not set
> # CONFIG_MMC_SDHCI_SPEAR is not set
> # CONFIG_MMC_SDHCI_BCM_KONA is not set
> CONFIG_MMC_SDHCI_F_SDH30=m
> # CONFIG_MMC_SDHCI_MILBEAUT is not set
> # CONFIG_MMC_SDHCI_IPROC is not set
> # CONFIG_MMC_MESON_GX is not set
> # CONFIG_MMC_MESON_MX_SDHC is not set
> # CONFIG_MMC_MESON_MX_SDIO is not set
> # CONFIG_MMC_MOXART is not set
> # CONFIG_MMC_SDHCI_ST is not set
> # CONFIG_MMC_OMAP_HS is not set
> CONFIG_MMC_ATMELMCI=m
> # CONFIG_MMC_SDHCI_MSM is not set
> # CONFIG_MMC_MVSDIO is not set
> # CONFIG_MMC_DAVINCI is not set
> CONFIG_MMC_SPI=m
> # CONFIG_MMC_S3C is not set
> # CONFIG_MMC_SDHCI_SPRD is not set
> # CONFIG_MMC_TMIO is not set
> # CONFIG_MMC_SDHI is not set
> # CONFIG_MMC_UNIPHIER is not set
> # CONFIG_MMC_DW is not set
> # CONFIG_MMC_SH_MMCIF is not set
> CONFIG_MMC_VUB300=m
> # CONFIG_MMC_USHC is not set
> CONFIG_MMC_USDHI6ROL0=y
> CONFIG_MMC_CQHCI=m
> CONFIG_MMC_HSQ=y
> # CONFIG_MMC_BCM2835 is not set
> CONFIG_MMC_MTK=m
> # CONFIG_MMC_SDHCI_BRCMSTB is not set
> # CONFIG_MMC_SDHCI_XENON is not set
> CONFIG_MMC_SDHCI_OMAP=m
> CONFIG_MMC_SDHCI_AM654=m
> # CONFIG_MMC_OWL is not set
> CONFIG_MMC_LITEX=m
> CONFIG_SCSI_UFSHCD=m
> CONFIG_SCSI_UFS_BSG=y
> CONFIG_SCSI_UFS_HPB=y
> CONFIG_SCSI_UFS_HWMON=y
> # CONFIG_SCSI_UFSHCD_PLATFORM is not set
> # CONFIG_SCSI_UFS_TI_J721E is not set
> CONFIG_MEMSTICK=y
> CONFIG_MEMSTICK_DEBUG=y
> 
> #
> # MemoryStick drivers
> #
> # CONFIG_MEMSTICK_UNSAFE_RESUME is not set
> # CONFIG_MSPRO_BLOCK is not set
> # CONFIG_MS_BLOCK is not set
> 
> #
> # MemoryStick Host Controller Drivers
> #
> CONFIG_NEW_LEDS=y
> CONFIG_LEDS_CLASS=y
> # CONFIG_LEDS_CLASS_FLASH is not set
> CONFIG_LEDS_CLASS_MULTICOLOR=y
> # CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set
> 
> #
> # LED drivers
> #
> CONFIG_LEDS_88PM860X=m
> CONFIG_LEDS_AN30259A=m
> # CONFIG_LEDS_ARIEL is not set
> # CONFIG_LEDS_AW2013 is not set
> CONFIG_LEDS_BCM6328=m
> CONFIG_LEDS_BCM6358=m
> # CONFIG_LEDS_CR0014114 is not set
> # CONFIG_LEDS_EL15203000 is not set
> # CONFIG_LEDS_TURRIS_OMNIA is not set
> CONFIG_LEDS_LM3530=m
> # CONFIG_LEDS_LM3532 is not set
> # CONFIG_LEDS_LM3533 is not set
> CONFIG_LEDS_LM3642=m
> # CONFIG_LEDS_LM3692X is not set
> # CONFIG_LEDS_S3C24XX is not set
> # CONFIG_LEDS_COBALT_QUBE is not set
> # CONFIG_LEDS_COBALT_RAQ is not set
> # CONFIG_LEDS_PCA9532 is not set
> CONFIG_LEDS_GPIO=y
> # CONFIG_LEDS_LP3944 is not set
> CONFIG_LEDS_LP3952=m
> CONFIG_LEDS_LP50XX=y
> CONFIG_LEDS_LP55XX_COMMON=m
> # CONFIG_LEDS_LP5521 is not set
> CONFIG_LEDS_LP5523=m
> CONFIG_LEDS_LP5562=m
> CONFIG_LEDS_LP8501=m
> # CONFIG_LEDS_LP8788 is not set
> CONFIG_LEDS_LP8860=m
> CONFIG_LEDS_PCA955X=m
> CONFIG_LEDS_PCA955X_GPIO=y
> CONFIG_LEDS_PCA963X=y
> CONFIG_LEDS_WM831X_STATUS=m
> CONFIG_LEDS_DAC124S085=y
> CONFIG_LEDS_PWM=y
> # CONFIG_LEDS_REGULATOR is not set
> CONFIG_LEDS_BD2802=y
> # CONFIG_LEDS_LT3593 is not set
> CONFIG_LEDS_NS2=y
> CONFIG_LEDS_NETXBIG=y
> # CONFIG_LEDS_ASIC3 is not set
> # CONFIG_LEDS_TCA6507 is not set
> # CONFIG_LEDS_TLC591XX is not set
> CONFIG_LEDS_MAX77650=y
> CONFIG_LEDS_LM355x=y
> # CONFIG_LEDS_OT200 is not set
> CONFIG_LEDS_MENF21BMC=m
> CONFIG_LEDS_IS31FL319X=m
> CONFIG_LEDS_IS31FL32XX=m
> 
> #
> # LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
> #
> CONFIG_LEDS_BLINKM=y
> # CONFIG_LEDS_SYSCON is not set
> CONFIG_LEDS_PM8058=m
> # CONFIG_LEDS_MLXREG is not set
> CONFIG_LEDS_USER=y
> # CONFIG_LEDS_SPI_BYTE is not set
> # CONFIG_LEDS_TI_LMU_COMMON is not set
> CONFIG_LEDS_TPS6105X=y
> # CONFIG_LEDS_IP30 is not set
> # CONFIG_LEDS_BCM63138 is not set
> # CONFIG_LEDS_LGM is not set
> 
> #
> # Flash and Torch LED drivers
> #
> 
> #
> # RGB LED drivers
> #
> # CONFIG_LEDS_PWM_MULTICOLOR is not set
> CONFIG_LEDS_QCOM_LPG=y
> 
> #
> # LED Triggers
> #
> CONFIG_LEDS_TRIGGERS=y
> CONFIG_LEDS_TRIGGER_TIMER=y
> CONFIG_LEDS_TRIGGER_ONESHOT=y
> CONFIG_LEDS_TRIGGER_DISK=y
> # CONFIG_LEDS_TRIGGER_MTD is not set
> CONFIG_LEDS_TRIGGER_HEARTBEAT=m
> CONFIG_LEDS_TRIGGER_BACKLIGHT=y
> CONFIG_LEDS_TRIGGER_CPU=y
> # CONFIG_LEDS_TRIGGER_ACTIVITY is not set
> CONFIG_LEDS_TRIGGER_GPIO=m
> CONFIG_LEDS_TRIGGER_DEFAULT_ON=m
> 
> #
> # iptables trigger is under Netfilter config (LED target)
> #
> CONFIG_LEDS_TRIGGER_TRANSIENT=m
> # CONFIG_LEDS_TRIGGER_CAMERA is not set
> CONFIG_LEDS_TRIGGER_PANIC=y
> CONFIG_LEDS_TRIGGER_PATTERN=y
> CONFIG_LEDS_TRIGGER_AUDIO=y
> # CONFIG_LEDS_TRIGGER_TTY is not set
> 
> #
> # Simple LED drivers
> #
> # CONFIG_ACCESSIBILITY is not set
> CONFIG_EDAC_ATOMIC_SCRUB=y
> CONFIG_EDAC_SUPPORT=y
> CONFIG_RTC_LIB=y
> # CONFIG_RTC_CLASS is not set
> # CONFIG_DMADEVICES is not set
> 
> #
> # DMABUF options
> #
> CONFIG_SYNC_FILE=y
> CONFIG_SW_SYNC=y
> # CONFIG_UDMABUF is not set
> CONFIG_DMABUF_MOVE_NOTIFY=y
> # CONFIG_DMABUF_DEBUG is not set
> CONFIG_DMABUF_SELFTESTS=y
> CONFIG_DMABUF_HEAPS=y
> CONFIG_DMABUF_SYSFS_STATS=y
> # CONFIG_DMABUF_HEAPS_SYSTEM is not set
> # end of DMABUF options
> 
> CONFIG_AUXDISPLAY=y
> CONFIG_CHARLCD=y
> CONFIG_LINEDISP=y
> CONFIG_HD44780_COMMON=y
> CONFIG_HD44780=y
> # CONFIG_KS0108 is not set
> CONFIG_IMG_ASCII_LCD=y
> CONFIG_HT16K33=y
> CONFIG_LCD2S=y
> CONFIG_PARPORT_PANEL=m
> CONFIG_PANEL_PARPORT=0
> CONFIG_PANEL_PROFILE=5
> # CONFIG_PANEL_CHANGE_MESSAGE is not set
> CONFIG_CHARLCD_BL_OFF=y
> # CONFIG_CHARLCD_BL_ON is not set
> # CONFIG_CHARLCD_BL_FLASH is not set
> CONFIG_PANEL=m
> CONFIG_VFIO=y
> CONFIG_VFIO_CONTAINER=y
> CONFIG_VFIO_NOIOMMU=y
> CONFIG_VFIO_VIRQFD=y
> CONFIG_VFIO_PLATFORM=y
> CONFIG_VFIO_AMBA=m
> CONFIG_VFIO_PLATFORM_CALXEDAXGMAC_RESET=y
> CONFIG_VFIO_PLATFORM_AMDXGBE_RESET=y
> # CONFIG_VFIO_PLATFORM_BCMFLEXRM_RESET is not set
> CONFIG_VFIO_MDEV=m
> # CONFIG_VIRT_DRIVERS is not set
> CONFIG_VIRTIO_ANCHOR=y
> CONFIG_VIRTIO=y
> # CONFIG_VIRTIO_MENU is not set
> # CONFIG_VHOST_MENU is not set
> 
> #
> # Microsoft Hyper-V guest support
> #
> # end of Microsoft Hyper-V guest support
> 
> CONFIG_GREYBUS=m
> CONFIG_GREYBUS_ES2=m
> # CONFIG_COMEDI is not set
> # CONFIG_STAGING is not set
> CONFIG_GOLDFISH=y
> CONFIG_GOLDFISH_PIPE=y
> # CONFIG_CHROME_PLATFORMS is not set
> CONFIG_MELLANOX_PLATFORM=y
> # CONFIG_MLXREG_HOTPLUG is not set
> # CONFIG_MLXREG_IO is not set
> CONFIG_MLXREG_LC=m
> CONFIG_NVSW_SN2201=m
> # CONFIG_OLPC_XO175 is not set
> CONFIG_SURFACE_PLATFORMS=y
> CONFIG_HAVE_CLK=y
> CONFIG_HAVE_CLK_PREPARE=y
> CONFIG_COMMON_CLK=y
> # CONFIG_COMMON_CLK_WM831X is not set
> 
> #
> # Clock driver for ARM Reference designs
> #
> CONFIG_CLK_ICST=y
> CONFIG_CLK_SP810=y
> # CONFIG_CLK_VEXPRESS_OSC is not set
> # end of Clock driver for ARM Reference designs
> 
> # CONFIG_CLK_HSDK is not set
> # CONFIG_LMK04832 is not set
> # CONFIG_COMMON_CLK_APPLE_NCO is not set
> CONFIG_COMMON_CLK_MAX77686=m
> # CONFIG_COMMON_CLK_MAX9485 is not set
> # CONFIG_COMMON_CLK_HI655X is not set
> CONFIG_COMMON_CLK_SCMI=m
> # CONFIG_COMMON_CLK_SCPI is not set
> CONFIG_COMMON_CLK_SI5341=m
> CONFIG_COMMON_CLK_SI5351=y
> # CONFIG_COMMON_CLK_SI514 is not set
> CONFIG_COMMON_CLK_SI544=y
> CONFIG_COMMON_CLK_SI570=m
> # CONFIG_COMMON_CLK_BM1880 is not set
> CONFIG_COMMON_CLK_CDCE706=y
> # CONFIG_COMMON_CLK_TPS68470 is not set
> # CONFIG_COMMON_CLK_CDCE925 is not set
> CONFIG_COMMON_CLK_CS2000_CP=m
> # CONFIG_COMMON_CLK_EN7523 is not set
> # CONFIG_COMMON_CLK_FSL_FLEXSPI is not set
> # CONFIG_COMMON_CLK_FSL_SAI is not set
> # CONFIG_COMMON_CLK_GEMINI is not set
> # CONFIG_COMMON_CLK_LAN966X is not set
> # CONFIG_COMMON_CLK_ASPEED is not set
> # CONFIG_COMMON_CLK_S2MPS11 is not set
> # CONFIG_CLK_TWL6040 is not set
> CONFIG_COMMON_CLK_AXI_CLKGEN=y
> # CONFIG_CLK_QORIQ is not set
> # CONFIG_CLK_LS1028A_PLLDIG is not set
> # CONFIG_COMMON_CLK_XGENE is not set
> CONFIG_COMMON_CLK_NXP=y
> CONFIG_COMMON_CLK_PALMAS=y
> CONFIG_COMMON_CLK_PWM=y
> # CONFIG_COMMON_CLK_OXNAS is not set
> # CONFIG_COMMON_CLK_RS9_PCIE is not set
> CONFIG_COMMON_CLK_VC5=y
> # CONFIG_COMMON_CLK_VC7 is not set
> CONFIG_COMMON_CLK_STM32F=y
> CONFIG_COMMON_CLK_STM32H7=y
> # CONFIG_COMMON_CLK_MMP2_AUDIO is not set
> CONFIG_COMMON_CLK_BD718XX=y
> CONFIG_COMMON_CLK_FIXED_MMIO=y
> # CONFIG_CLK_ACTIONS is not set
> # CONFIG_CLK_BAIKAL_T1 is not set
> # CONFIG_CLK_BCM2711_DVP is not set
> # CONFIG_CLK_BCM2835 is not set
> # CONFIG_CLK_BCM_63XX is not set
> # CONFIG_CLK_BCM_63XX_GATE is not set
> # CONFIG_CLK_BCM_KONA is not set
> # CONFIG_CLK_BCM_CYGNUS is not set
> # CONFIG_CLK_BCM_HR2 is not set
> # CONFIG_CLK_BCM_NSP is not set
> # CONFIG_CLK_BCM_NS2 is not set
> # CONFIG_CLK_BCM_SR is not set
> # CONFIG_CLK_RASPBERRYPI is not set
> # CONFIG_COMMON_CLK_HI3516CV300 is not set
> # CONFIG_COMMON_CLK_HI3519 is not set
> # CONFIG_COMMON_CLK_HI3559A is not set
> # CONFIG_COMMON_CLK_HI3660 is not set
> # CONFIG_COMMON_CLK_HI3670 is not set
> # CONFIG_COMMON_CLK_HI3798CV200 is not set
> # CONFIG_COMMON_CLK_HI6220 is not set
> # CONFIG_RESET_HISI is not set
> # CONFIG_STUB_CLK_HI6220 is not set
> # CONFIG_STUB_CLK_HI3660 is not set
> # CONFIG_COMMON_CLK_BOSTON is not set
> # CONFIG_MXC_CLK is not set
> # CONFIG_CLK_IMX8MM is not set
> # CONFIG_CLK_IMX8MN is not set
> # CONFIG_CLK_IMX8MP is not set
> # CONFIG_CLK_IMX8MQ is not set
> # CONFIG_CLK_IMX8ULP is not set
> # CONFIG_CLK_IMX93 is not set
> 
> #
> # Ingenic SoCs drivers
> #
> # CONFIG_INGENIC_CGU_JZ4740 is not set
> # CONFIG_INGENIC_CGU_JZ4755 is not set
> # CONFIG_INGENIC_CGU_JZ4725B is not set
> # CONFIG_INGENIC_CGU_JZ4760 is not set
> # CONFIG_INGENIC_CGU_JZ4770 is not set
> # CONFIG_INGENIC_CGU_JZ4780 is not set
> # CONFIG_INGENIC_CGU_X1000 is not set
> # CONFIG_INGENIC_CGU_X1830 is not set
> # CONFIG_INGENIC_TCU_CLK is not set
> # end of Ingenic SoCs drivers
> 
> # CONFIG_COMMON_CLK_KEYSTONE is not set
> # CONFIG_TI_SYSCON_CLK is not set
> 
> #
> # Clock driver for MediaTek SoC
> #
> # CONFIG_COMMON_CLK_MEDIATEK_FHCTL is not set
> # CONFIG_COMMON_CLK_MT2701 is not set
> # CONFIG_COMMON_CLK_MT2712 is not set
> # CONFIG_COMMON_CLK_MT6765 is not set
> # CONFIG_COMMON_CLK_MT6779 is not set
> # CONFIG_COMMON_CLK_MT6795 is not set
> # CONFIG_COMMON_CLK_MT6797 is not set
> # CONFIG_COMMON_CLK_MT7622 is not set
> # CONFIG_COMMON_CLK_MT7629 is not set
> # CONFIG_COMMON_CLK_MT7986 is not set
> # CONFIG_COMMON_CLK_MT8135 is not set
> # CONFIG_COMMON_CLK_MT8167 is not set
> # CONFIG_COMMON_CLK_MT8173 is not set
> # CONFIG_COMMON_CLK_MT8183 is not set
> # CONFIG_COMMON_CLK_MT8186 is not set
> # CONFIG_COMMON_CLK_MT8192 is not set
> # CONFIG_COMMON_CLK_MT8195 is not set
> # CONFIG_COMMON_CLK_MT8365 is not set
> # CONFIG_COMMON_CLK_MT8516 is not set
> # end of Clock driver for MediaTek SoC
> 
> #
> # Clock support for Amlogic platforms
> #
> CONFIG_COMMON_CLK_MESON_REGMAP=y
> CONFIG_COMMON_CLK_MESON_MPLL=y
> CONFIG_COMMON_CLK_MESON_PLL=y
> CONFIG_COMMON_CLK_MESON8B=y
> # end of Clock support for Amlogic platforms
> 
> # CONFIG_MSTAR_MSC313_CPUPLL is not set
> # CONFIG_MSTAR_MSC313_MPLL is not set
> # CONFIG_MCHP_CLK_MPFS is not set
> # CONFIG_COMMON_CLK_PISTACHIO is not set
> # CONFIG_COMMON_CLK_QCOM is not set
> # CONFIG_CLK_MT7621 is not set
> # CONFIG_CLK_RENESAS is not set
> # CONFIG_COMMON_CLK_SAMSUNG is not set
> # CONFIG_S3C2410_COMMON_CLK is not set
> # CONFIG_S3C2412_COMMON_CLK is not set
> # CONFIG_S3C2443_COMMON_CLK is not set
> # CONFIG_CLK_SIFIVE is not set
> # CONFIG_CLK_INTEL_SOCFPGA is not set
> # CONFIG_SPRD_COMMON_CLK is not set
> # CONFIG_CLK_STARFIVE_JH7100 is not set
> CONFIG_CLK_SUNXI=y
> CONFIG_CLK_SUNXI_CLOCKS=y
> CONFIG_CLK_SUNXI_PRCM_SUN6I=y
> CONFIG_CLK_SUNXI_PRCM_SUN8I=y
> CONFIG_CLK_SUNXI_PRCM_SUN9I=y
> # CONFIG_SUNXI_CCU is not set
> # CONFIG_COMMON_CLK_TI_ADPLL is not set
> # CONFIG_CLK_UNIPHIER is not set
> # CONFIG_COMMON_CLK_VISCONTI is not set
> # CONFIG_CLK_LGM_CGU is not set
> CONFIG_XILINX_VCU=m
> CONFIG_COMMON_CLK_XLNX_CLKWZRD=y
> # CONFIG_COMMON_CLK_ZYNQMP is not set
> # CONFIG_CLK_KUNIT_TEST is not set
> # CONFIG_CLK_GATE_KUNIT_TEST is not set
> # CONFIG_HWSPINLOCK is not set
> 
> #
> # Clock Source drivers
> #
> CONFIG_TIMER_OF=y
> CONFIG_TIMER_PROBE=y
> CONFIG_CLKSRC_MMIO=y
> # CONFIG_BCM2835_TIMER is not set
> # CONFIG_BCM_KONA_TIMER is not set
> # CONFIG_DAVINCI_TIMER is not set
> # CONFIG_DIGICOLOR_TIMER is not set
> # CONFIG_OMAP_DM_TIMER is not set
> # CONFIG_DW_APB_TIMER is not set
> # CONFIG_FTTMR010_TIMER is not set
> # CONFIG_IXP4XX_TIMER is not set
> # CONFIG_ROCKCHIP_TIMER is not set
> # CONFIG_ARMADA_370_XP_TIMER is not set
> # CONFIG_MESON6_TIMER is not set
> # CONFIG_ORION_TIMER is not set
> # CONFIG_OWL_TIMER is not set
> # CONFIG_RDA_TIMER is not set
> # CONFIG_SUN4I_TIMER is not set
> # CONFIG_SUN5I_HSTIMER is not set
> # CONFIG_TEGRA_TIMER is not set
> # CONFIG_VT8500_TIMER is not set
> # CONFIG_NPCM7XX_TIMER is not set
> # CONFIG_CADENCE_TTC_TIMER is not set
> # CONFIG_ASM9260_TIMER is not set
> # CONFIG_CLKSRC_NOMADIK_MTU is not set
> # CONFIG_CLKSRC_DBX500_PRCMU is not set
> # CONFIG_CLPS711X_TIMER is not set
> # CONFIG_MXS_TIMER is not set
> # CONFIG_NSPIRE_TIMER is not set
> # CONFIG_KEYSTONE_TIMER is not set
> # CONFIG_INTEGRATOR_AP_TIMER is not set
> CONFIG_CLKSRC_LPC32XX=y
> # CONFIG_CLKSRC_PISTACHIO is not set
> # CONFIG_CLKSRC_TI_32K is not set
> CONFIG_CLKSRC_STM32=y
> # CONFIG_CLKSRC_STM32_LP is not set
> # CONFIG_CLKSRC_MPS2 is not set
> # CONFIG_ARC_TIMERS is not set
> # CONFIG_ARM_GLOBAL_TIMER is not set
> # CONFIG_ARM_TIMER_SP804 is not set
> CONFIG_ARMV7M_SYSTICK=y
> # CONFIG_ATMEL_PIT is not set
> # CONFIG_ATMEL_ST is not set
> # CONFIG_ATMEL_TCB_CLKSRC is not set
> # CONFIG_CLKSRC_EXYNOS_MCT is not set
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
> # CONFIG_CLKSRC_QCOM is not set
> # CONFIG_CLKSRC_VERSATILE is not set
> # CONFIG_CLKSRC_PXA is not set
> # CONFIG_CLKSRC_IMX_GPT is not set
> # CONFIG_CLKSRC_IMX_TPM is not set
> # CONFIG_TIMER_IMX_SYS_CTR is not set
> # CONFIG_CLKSRC_ST_LPC is not set
> # CONFIG_GXP_TIMER is not set
> # CONFIG_MILBEAUT_TIMER is not set
> # CONFIG_MSC313E_TIMER is not set
> # CONFIG_INGENIC_TIMER is not set
> # CONFIG_INGENIC_SYSOST is not set
> # CONFIG_INGENIC_OST is not set
> CONFIG_MICROCHIP_PIT64B=y
> # end of Clock Source drivers
> 
> CONFIG_MAILBOX=y
> CONFIG_ARM_MHU=y
> CONFIG_ARM_MHU_V2=y
> # CONFIG_IMX_MBOX is not set
> # CONFIG_PLATFORM_MHU is not set
> CONFIG_PL320_MBOX=y
> # CONFIG_ARMADA_37XX_RWTM_MBOX is not set
> # CONFIG_ROCKCHIP_MBOX is not set
> CONFIG_ALTERA_MBOX=y
> # CONFIG_HI3660_MBOX is not set
> # CONFIG_HI6220_MBOX is not set
> CONFIG_MAILBOX_TEST=y
> # CONFIG_POLARFIRE_SOC_MAILBOX is not set
> # CONFIG_QCOM_APCS_IPC is not set
> # CONFIG_BCM_PDC_MBOX is not set
> # CONFIG_STM32_IPCC is not set
> # CONFIG_MTK_ADSP_MBOX is not set
> # CONFIG_MTK_CMDQ_MBOX is not set
> # CONFIG_SUN6I_MSGBOX is not set
> # CONFIG_SPRD_MBOX is not set
> # CONFIG_QCOM_IPCC is not set
> CONFIG_IOMMU_API=y
> 
> #
> # Remoteproc drivers
> #
> CONFIG_REMOTEPROC=y
> CONFIG_REMOTEPROC_CDEV=y
> # CONFIG_INGENIC_VPU_RPROC is not set
> # CONFIG_MTK_SCP is not set
> # CONFIG_MESON_MX_AO_ARC_REMOTEPROC is not set
> # CONFIG_RCAR_REMOTEPROC is not set
> # CONFIG_STM32_RPROC is not set
> # end of Remoteproc drivers
> 
> #
> # Rpmsg drivers
> #
> CONFIG_RPMSG=y
> CONFIG_RPMSG_CTRL=y
> CONFIG_RPMSG_NS=y
> CONFIG_RPMSG_QCOM_GLINK=m
> CONFIG_RPMSG_QCOM_GLINK_RPM=m
> CONFIG_RPMSG_VIRTIO=y
> # end of Rpmsg drivers
> 
> CONFIG_SOUNDWIRE=m
> 
> #
> # SoundWire Devices
> #
> CONFIG_SOUNDWIRE_QCOM=m
> 
> #
> # SOC (System On Chip) specific Drivers
> #
> # CONFIG_OWL_PM_DOMAINS is not set
> 
> #
> # Amlogic SoC drivers
> #
> # CONFIG_MESON_CANVAS is not set
> # CONFIG_MESON_CLK_MEASURE is not set
> # CONFIG_MESON_GX_SOCINFO is not set
> # CONFIG_MESON_GX_PM_DOMAINS is not set
> # CONFIG_MESON_EE_PM_DOMAINS is not set
> # CONFIG_MESON_MX_SOCINFO is not set
> # end of Amlogic SoC drivers
> 
> #
> # Apple SoC drivers
> #
> # CONFIG_APPLE_PMGR_PWRSTATE is not set
> # CONFIG_APPLE_RTKIT is not set
> # CONFIG_APPLE_SART is not set
> # end of Apple SoC drivers
> 
> #
> # ASPEED SoC drivers
> #
> # CONFIG_ASPEED_LPC_CTRL is not set
> # CONFIG_ASPEED_LPC_SNOOP is not set
> # CONFIG_ASPEED_UART_ROUTING is not set
> # CONFIG_ASPEED_P2A_CTRL is not set
> # CONFIG_ASPEED_SOCINFO is not set
> # end of ASPEED SoC drivers
> 
> CONFIG_AT91_SOC_ID=y
> # CONFIG_AT91_SOC_SFR is not set
> 
> #
> # Broadcom SoC drivers
> #
> # CONFIG_BCM2835_POWER is not set
> # CONFIG_SOC_BCM63XX is not set
> CONFIG_SOC_BRCMSTB=y
> # CONFIG_BCM_PMB is not set
> # end of Broadcom SoC drivers
> 
> #
> # NXP/Freescale QorIQ SoC drivers
> #
> CONFIG_QUICC_ENGINE=y
> CONFIG_DPAA2_CONSOLE=y
> # CONFIG_FSL_RCPM is not set
> # end of NXP/Freescale QorIQ SoC drivers
> 
> #
> # fujitsu SoC drivers
> #
> # end of fujitsu SoC drivers
> 
> #
> # i.MX SoC drivers
> #
> # CONFIG_IMX_GPCV2_PM_DOMAINS is not set
> # CONFIG_SOC_IMX8M is not set
> # CONFIG_SOC_IMX9 is not set
> # end of i.MX SoC drivers
> 
> #
> # IXP4xx SoC drivers
> #
> # CONFIG_IXP4XX_QMGR is not set
> # CONFIG_IXP4XX_NPE is not set
> # end of IXP4xx SoC drivers
> 
> #
> # Enable LiteX SoC Builder specific drivers
> #
> CONFIG_LITEX=y
> CONFIG_LITEX_SOC_CONTROLLER=y
> # end of Enable LiteX SoC Builder specific drivers
> 
> # CONFIG_LOONGSON2_GUTS is not set
> 
> #
> # MediaTek SoC drivers
> #
> # CONFIG_MTK_CMDQ is not set
> # CONFIG_MTK_DEVAPC is not set
> # CONFIG_MTK_INFRACFG is not set
> # CONFIG_MTK_PMIC_WRAP is not set
> # CONFIG_MTK_SCPSYS is not set
> # CONFIG_MTK_SCPSYS_PM_DOMAINS is not set
> # CONFIG_MTK_MMSYS is not set
> # end of MediaTek SoC drivers
> 
> #
> # Qualcomm SoC drivers
> #
> # CONFIG_QCOM_AOSS_QMP is not set
> # CONFIG_QCOM_COMMAND_DB is not set
> # CONFIG_QCOM_GENI_SE is not set
> # CONFIG_QCOM_GSBI is not set
> # CONFIG_QCOM_LLCC is not set
> # CONFIG_QCOM_RPMH is not set
> # CONFIG_QCOM_SMD_RPM is not set
> # CONFIG_QCOM_SPM is not set
> # CONFIG_QCOM_WCNSS_CTRL is not set
> # CONFIG_QCOM_ICC_BWMON is not set
> # end of Qualcomm SoC drivers
> 
> # CONFIG_SOC_RENESAS is not set
> # CONFIG_ROCKCHIP_GRF is not set
> # CONFIG_ROCKCHIP_IODOMAIN is not set
> # CONFIG_ROCKCHIP_PM_DOMAINS is not set
> # CONFIG_SOC_SAMSUNG is not set
> # CONFIG_SOC_TEGRA20_VOLTAGE_COUPLER is not set
> # CONFIG_SOC_TEGRA30_VOLTAGE_COUPLER is not set
> CONFIG_SOC_TI=y
> # CONFIG_UX500_SOC_ID is not set
> 
> #
> # Xilinx SoC drivers
> #
> # end of Xilinx SoC drivers
> # end of SOC (System On Chip) specific Drivers
> 
> CONFIG_PM_DEVFREQ=y
> 
> #
> # DEVFREQ Governors
> #
> CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=m
> # CONFIG_DEVFREQ_GOV_PERFORMANCE is not set
> CONFIG_DEVFREQ_GOV_POWERSAVE=y
> CONFIG_DEVFREQ_GOV_USERSPACE=m
> CONFIG_DEVFREQ_GOV_PASSIVE=m
> 
> #
> # DEVFREQ Drivers
> #
> # CONFIG_ARM_EXYNOS_BUS_DEVFREQ is not set
> # CONFIG_ARM_IMX_BUS_DEVFREQ is not set
> # CONFIG_ARM_TEGRA_DEVFREQ is not set
> # CONFIG_ARM_MEDIATEK_CCI_DEVFREQ is not set
> # CONFIG_ARM_SUN8I_A33_MBUS_DEVFREQ is not set
> # CONFIG_PM_DEVFREQ_EVENT is not set
> CONFIG_EXTCON=y
> 
> #
> # Extcon Device Drivers
> #
> CONFIG_EXTCON_ADC_JACK=m
> # CONFIG_EXTCON_FSA9480 is not set
> CONFIG_EXTCON_GPIO=y
> # CONFIG_EXTCON_MAX14577 is not set
> # CONFIG_EXTCON_MAX3355 is not set
> CONFIG_EXTCON_MAX77843=m
> CONFIG_EXTCON_PALMAS=m
> # CONFIG_EXTCON_PTN5150 is not set
> # CONFIG_EXTCON_QCOM_SPMI_MISC is not set
> CONFIG_EXTCON_RT8973A=m
> # CONFIG_EXTCON_SM5502 is not set
> CONFIG_EXTCON_USB_GPIO=y
> # CONFIG_MEMORY is not set
> CONFIG_IIO=m
> CONFIG_IIO_BUFFER=y
> CONFIG_IIO_BUFFER_CB=m
> CONFIG_IIO_BUFFER_DMA=m
> CONFIG_IIO_BUFFER_DMAENGINE=m
> CONFIG_IIO_BUFFER_HW_CONSUMER=m
> CONFIG_IIO_KFIFO_BUF=m
> CONFIG_IIO_TRIGGERED_BUFFER=m
> CONFIG_IIO_CONFIGFS=m
> CONFIG_IIO_TRIGGER=y
> CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
> CONFIG_IIO_SW_DEVICE=m
> CONFIG_IIO_SW_TRIGGER=m
> CONFIG_IIO_TRIGGERED_EVENT=m
> 
> #
> # Accelerometers
> #
> # CONFIG_ADIS16201 is not set
> CONFIG_ADIS16209=m
> # CONFIG_ADXL313_I2C is not set
> # CONFIG_ADXL313_SPI is not set
> # CONFIG_ADXL345_I2C is not set
> # CONFIG_ADXL345_SPI is not set
> CONFIG_ADXL355=m
> CONFIG_ADXL355_I2C=m
> # CONFIG_ADXL355_SPI is not set
> CONFIG_ADXL367=m
> # CONFIG_ADXL367_SPI is not set
> CONFIG_ADXL367_I2C=m
> CONFIG_ADXL372=m
> CONFIG_ADXL372_SPI=m
> CONFIG_ADXL372_I2C=m
> CONFIG_BMA220=m
> CONFIG_BMA400=m
> CONFIG_BMA400_I2C=m
> CONFIG_BMA400_SPI=m
> CONFIG_BMC150_ACCEL=m
> CONFIG_BMC150_ACCEL_I2C=m
> CONFIG_BMC150_ACCEL_SPI=m
> # CONFIG_BMI088_ACCEL is not set
> CONFIG_DA280=m
> CONFIG_DA311=m
> # CONFIG_DMARD06 is not set
> CONFIG_DMARD09=m
> CONFIG_DMARD10=m
> # CONFIG_FXLS8962AF_I2C is not set
> # CONFIG_FXLS8962AF_SPI is not set
> # CONFIG_HID_SENSOR_ACCEL_3D is not set
> CONFIG_IIO_ST_ACCEL_3AXIS=m
> # CONFIG_IIO_ST_ACCEL_I2C_3AXIS is not set
> CONFIG_IIO_ST_ACCEL_SPI_3AXIS=m
> # CONFIG_IIO_KX022A_SPI is not set
> # CONFIG_IIO_KX022A_I2C is not set
> # CONFIG_KXSD9 is not set
> # CONFIG_KXCJK1013 is not set
> CONFIG_MC3230=m
> CONFIG_MMA7455=m
> # CONFIG_MMA7455_I2C is not set
> CONFIG_MMA7455_SPI=m
> # CONFIG_MMA7660 is not set
> CONFIG_MMA8452=m
> # CONFIG_MMA9551 is not set
> # CONFIG_MMA9553 is not set
> # CONFIG_MSA311 is not set
> CONFIG_MXC4005=m
> # CONFIG_MXC6255 is not set
> CONFIG_SCA3000=m
> CONFIG_SCA3300=m
> CONFIG_STK8312=m
> CONFIG_STK8BA50=m
> # end of Accelerometers
> 
> #
> # Analog to digital converters
> #
> CONFIG_AD_SIGMA_DELTA=m
> # CONFIG_AD4130 is not set
> CONFIG_AD7091R5=m
> CONFIG_AD7124=m
> # CONFIG_AD7192 is not set
> CONFIG_AD7266=m
> CONFIG_AD7280=m
> CONFIG_AD7291=m
> CONFIG_AD7292=m
> CONFIG_AD7298=m
> # CONFIG_AD7476 is not set
> CONFIG_AD7606=m
> CONFIG_AD7606_IFACE_PARALLEL=m
> CONFIG_AD7606_IFACE_SPI=m
> CONFIG_AD7766=m
> # CONFIG_AD7768_1 is not set
> CONFIG_AD7780=m
> # CONFIG_AD7791 is not set
> # CONFIG_AD7793 is not set
> CONFIG_AD7887=m
> CONFIG_AD7923=m
> # CONFIG_AD7949 is not set
> CONFIG_AD799X=m
> CONFIG_AD9467=m
> CONFIG_ADI_AXI_ADC=m
> # CONFIG_ASPEED_ADC is not set
> # CONFIG_AT91_ADC is not set
> CONFIG_AT91_SAMA5D2_ADC=m
> # CONFIG_AXP20X_ADC is not set
> CONFIG_AXP288_ADC=m
> # CONFIG_BCM_IPROC_ADC is not set
> # CONFIG_BERLIN2_ADC is not set
> # CONFIG_CC10001_ADC is not set
> CONFIG_DA9150_GPADC=m
> # CONFIG_DLN2_ADC is not set
> # CONFIG_ENVELOPE_DETECTOR is not set
> # CONFIG_EXYNOS_ADC is not set
> CONFIG_HI8435=m
> # CONFIG_HX711 is not set
> CONFIG_INA2XX_ADC=m
> # CONFIG_INGENIC_ADC is not set
> # CONFIG_IMX7D_ADC is not set
> # CONFIG_IMX8QXP_ADC is not set
> # CONFIG_LP8788_ADC is not set
> CONFIG_LPC18XX_ADC=m
> # CONFIG_LPC32XX_ADC is not set
> CONFIG_LTC2471=m
> CONFIG_LTC2485=m
> # CONFIG_LTC2496 is not set
> CONFIG_LTC2497=m
> CONFIG_MAX1027=m
> CONFIG_MAX11100=m
> # CONFIG_MAX1118 is not set
> CONFIG_MAX11205=m
> # CONFIG_MAX11410 is not set
> # CONFIG_MAX1241 is not set
> # CONFIG_MAX1363 is not set
> # CONFIG_MAX9611 is not set
> # CONFIG_MCP320X is not set
> CONFIG_MCP3422=m
> # CONFIG_MCP3911 is not set
> # CONFIG_MEDIATEK_MT6360_ADC is not set
> # CONFIG_MEDIATEK_MT6577_AUXADC is not set
> CONFIG_MEN_Z188_ADC=m
> # CONFIG_MESON_SARADC is not set
> CONFIG_NAU7802=m
> # CONFIG_NPCM_ADC is not set
> # CONFIG_PALMAS_GPADC is not set
> CONFIG_QCOM_VADC_COMMON=m
> CONFIG_QCOM_PM8XXX_XOADC=m
> CONFIG_QCOM_SPMI_IADC=m
> # CONFIG_QCOM_SPMI_VADC is not set
> CONFIG_QCOM_SPMI_ADC5=m
> # CONFIG_RCAR_GYRO_ADC is not set
> # CONFIG_RN5T618_ADC is not set
> # CONFIG_ROCKCHIP_SARADC is not set
> CONFIG_RICHTEK_RTQ6056=m
> # CONFIG_RZG2L_ADC is not set
> # CONFIG_SC27XX_ADC is not set
> # CONFIG_SPEAR_ADC is not set
> CONFIG_SD_ADC_MODULATOR=m
> CONFIG_STM32_ADC_CORE=m
> # CONFIG_STM32_ADC is not set
> CONFIG_STM32_DFSDM_CORE=m
> CONFIG_STM32_DFSDM_ADC=m
> CONFIG_STMPE_ADC=m
> CONFIG_TI_ADC081C=m
> # CONFIG_TI_ADC0832 is not set
> CONFIG_TI_ADC084S021=m
> CONFIG_TI_ADC12138=m
> CONFIG_TI_ADC108S102=m
> CONFIG_TI_ADC128S052=m
> # CONFIG_TI_ADC161S626 is not set
> # CONFIG_TI_ADS1015 is not set
> CONFIG_TI_ADS7950=m
> CONFIG_TI_ADS8344=m
> CONFIG_TI_ADS8688=m
> CONFIG_TI_ADS124S08=m
> CONFIG_TI_ADS131E08=m
> # CONFIG_TI_AM335X_ADC is not set
> CONFIG_TI_TLC4541=m
> CONFIG_TI_TSC2046=m
> CONFIG_TWL4030_MADC=m
> # CONFIG_TWL6030_GPADC is not set
> CONFIG_VF610_ADC=m
> CONFIG_VIPERBOARD_ADC=m
> # CONFIG_XILINX_XADC is not set
> # CONFIG_XILINX_AMS is not set
> # end of Analog to digital converters
> 
> #
> # Analog to digital and digital to analog converters
> #
> # CONFIG_AD74115 is not set
> CONFIG_AD74413R=m
> # end of Analog to digital and digital to analog converters
> 
> #
> # Analog Front Ends
> #
> CONFIG_IIO_RESCALE=m
> # end of Analog Front Ends
> 
> #
> # Amplifiers
> #
> # CONFIG_AD8366 is not set
> CONFIG_ADA4250=m
> CONFIG_HMC425=m
> # end of Amplifiers
> 
> #
> # Capacitance to digital converters
> #
> CONFIG_AD7150=m
> CONFIG_AD7746=m
> # end of Capacitance to digital converters
> 
> #
> # Chemical Sensors
> #
> # CONFIG_ATLAS_PH_SENSOR is not set
> CONFIG_ATLAS_EZO_SENSOR=m
> # CONFIG_BME680 is not set
> # CONFIG_CCS811 is not set
> # CONFIG_IAQCORE is not set
> CONFIG_SCD30_CORE=m
> # CONFIG_SCD30_I2C is not set
> CONFIG_SCD4X=m
> CONFIG_SENSIRION_SGP30=m
> CONFIG_SENSIRION_SGP40=m
> CONFIG_SPS30=m
> CONFIG_SPS30_I2C=m
> # CONFIG_SENSEAIR_SUNRISE_CO2 is not set
> # CONFIG_VZ89X is not set
> # end of Chemical Sensors
> 
> #
> # Hid Sensor IIO Common
> #
> CONFIG_HID_SENSOR_IIO_COMMON=m
> CONFIG_HID_SENSOR_IIO_TRIGGER=m
> # end of Hid Sensor IIO Common
> 
> CONFIG_IIO_MS_SENSORS_I2C=m
> 
> #
> # IIO SCMI Sensors
> #
> # CONFIG_IIO_SCMI is not set
> # end of IIO SCMI Sensors
> 
> #
> # SSP Sensor Common
> #
> CONFIG_IIO_SSP_SENSORS_COMMONS=m
> CONFIG_IIO_SSP_SENSORHUB=m
> # end of SSP Sensor Common
> 
> CONFIG_IIO_ST_SENSORS_I2C=m
> CONFIG_IIO_ST_SENSORS_SPI=m
> CONFIG_IIO_ST_SENSORS_CORE=m
> 
> #
> # Digital to analog converters
> #
> CONFIG_AD3552R=m
> CONFIG_AD5064=m
> CONFIG_AD5360=m
> CONFIG_AD5380=m
> CONFIG_AD5421=m
> CONFIG_AD5446=m
> CONFIG_AD5449=m
> CONFIG_AD5592R_BASE=m
> CONFIG_AD5592R=m
> CONFIG_AD5593R=m
> CONFIG_AD5504=m
> CONFIG_AD5624R_SPI=m
> # CONFIG_LTC2688 is not set
> CONFIG_AD5686=m
> CONFIG_AD5686_SPI=m
> CONFIG_AD5696_I2C=m
> CONFIG_AD5755=m
> CONFIG_AD5758=m
> # CONFIG_AD5761 is not set
> CONFIG_AD5764=m
> # CONFIG_AD5766 is not set
> # CONFIG_AD5770R is not set
> CONFIG_AD5791=m
> # CONFIG_AD7293 is not set
> CONFIG_AD7303=m
> CONFIG_AD8801=m
> CONFIG_DPOT_DAC=m
> CONFIG_DS4424=m
> CONFIG_LPC18XX_DAC=m
> # CONFIG_LTC1660 is not set
> CONFIG_LTC2632=m
> CONFIG_M62332=m
> CONFIG_MAX517=m
> CONFIG_MAX5821=m
> CONFIG_MCP4725=m
> CONFIG_MCP4922=m
> # CONFIG_STM32_DAC is not set
> # CONFIG_TI_DAC082S085 is not set
> CONFIG_TI_DAC5571=m
> CONFIG_TI_DAC7311=m
> CONFIG_TI_DAC7612=m
> CONFIG_VF610_DAC=m
> # end of Digital to analog converters
> 
> #
> # IIO dummy driver
> #
> # CONFIG_IIO_SIMPLE_DUMMY is not set
> # end of IIO dummy driver
> 
> #
> # Filters
> #
> # end of Filters
> 
> #
> # Frequency Synthesizers DDS/PLL
> #
> 
> #
> # Clock Generator/Distribution
> #
> # CONFIG_AD9523 is not set
> # end of Clock Generator/Distribution
> 
> #
> # Phase-Locked Loop (PLL) frequency synthesizers
> #
> CONFIG_ADF4350=m
> # CONFIG_ADF4371 is not set
> # CONFIG_ADF4377 is not set
> CONFIG_ADMV1013=m
> CONFIG_ADMV4420=m
> # CONFIG_ADRF6780 is not set
> # end of Phase-Locked Loop (PLL) frequency synthesizers
> # end of Frequency Synthesizers DDS/PLL
> 
> #
> # Digital gyroscope sensors
> #
> CONFIG_ADIS16080=m
> CONFIG_ADIS16130=m
> CONFIG_ADIS16136=m
> CONFIG_ADIS16260=m
> CONFIG_ADXRS290=m
> CONFIG_ADXRS450=m
> CONFIG_BMG160=m
> CONFIG_BMG160_I2C=m
> CONFIG_BMG160_SPI=m
> # CONFIG_FXAS21002C is not set
> CONFIG_HID_SENSOR_GYRO_3D=m
> CONFIG_MPU3050=m
> CONFIG_MPU3050_I2C=m
> CONFIG_IIO_ST_GYRO_3AXIS=m
> # CONFIG_IIO_ST_GYRO_I2C_3AXIS is not set
> CONFIG_IIO_ST_GYRO_SPI_3AXIS=m
> CONFIG_ITG3200=m
> # end of Digital gyroscope sensors
> 
> #
> # Health Sensors
> #
> 
> #
> # Heart Rate Monitors
> #
> # CONFIG_AFE4403 is not set
> # CONFIG_AFE4404 is not set
> CONFIG_MAX30100=m
> # CONFIG_MAX30102 is not set
> # end of Heart Rate Monitors
> # end of Health Sensors
> 
> #
> # Humidity sensors
> #
> CONFIG_AM2315=m
> CONFIG_DHT11=m
> # CONFIG_HDC100X is not set
> CONFIG_HDC2010=m
> CONFIG_HID_SENSOR_HUMIDITY=m
> CONFIG_HTS221=m
> CONFIG_HTS221_I2C=m
> CONFIG_HTS221_SPI=m
> # CONFIG_HTU21 is not set
> CONFIG_SI7005=m
> # CONFIG_SI7020 is not set
> # end of Humidity sensors
> 
> #
> # Inertial measurement units
> #
> CONFIG_ADIS16400=m
> CONFIG_ADIS16460=m
> CONFIG_ADIS16475=m
> CONFIG_ADIS16480=m
> CONFIG_BMI160=m
> CONFIG_BMI160_I2C=m
> # CONFIG_BMI160_SPI is not set
> # CONFIG_BOSCH_BNO055_I2C is not set
> # CONFIG_FXOS8700_I2C is not set
> # CONFIG_FXOS8700_SPI is not set
> # CONFIG_KMX61 is not set
> CONFIG_INV_ICM42600=m
> CONFIG_INV_ICM42600_I2C=m
> # CONFIG_INV_ICM42600_SPI is not set
> CONFIG_INV_MPU6050_IIO=m
> CONFIG_INV_MPU6050_I2C=m
> CONFIG_INV_MPU6050_SPI=m
> CONFIG_IIO_ST_LSM6DSX=m
> CONFIG_IIO_ST_LSM6DSX_I2C=m
> CONFIG_IIO_ST_LSM6DSX_SPI=m
> CONFIG_IIO_ST_LSM6DSX_I3C=m
> CONFIG_IIO_ST_LSM9DS0=m
> # CONFIG_IIO_ST_LSM9DS0_I2C is not set
> CONFIG_IIO_ST_LSM9DS0_SPI=m
> # end of Inertial measurement units
> 
> CONFIG_IIO_ADIS_LIB=m
> CONFIG_IIO_ADIS_LIB_BUFFER=y
> 
> #
> # Light sensors
> #
> # CONFIG_ADJD_S311 is not set
> # CONFIG_ADUX1020 is not set
> # CONFIG_AL3010 is not set
> CONFIG_AL3320A=m
> # CONFIG_APDS9300 is not set
> CONFIG_APDS9960=m
> CONFIG_AS73211=m
> # CONFIG_BH1750 is not set
> CONFIG_BH1780=m
> CONFIG_CM32181=m
> CONFIG_CM3232=m
> CONFIG_CM3323=m
> CONFIG_CM3605=m
> CONFIG_CM36651=m
> CONFIG_GP2AP002=m
> CONFIG_GP2AP020A00F=m
> CONFIG_IQS621_ALS=m
> CONFIG_SENSORS_ISL29018=m
> CONFIG_SENSORS_ISL29028=m
> # CONFIG_ISL29125 is not set
> # CONFIG_HID_SENSOR_ALS is not set
> CONFIG_HID_SENSOR_PROX=m
> CONFIG_JSA1212=m
> CONFIG_RPR0521=m
> # CONFIG_SENSORS_LM3533 is not set
> # CONFIG_LTR501 is not set
> CONFIG_LTRF216A=m
> # CONFIG_LV0104CS is not set
> CONFIG_MAX44000=m
> # CONFIG_MAX44009 is not set
> # CONFIG_NOA1305 is not set
> CONFIG_OPT3001=m
> CONFIG_PA12203001=m
> # CONFIG_SI1133 is not set
> CONFIG_SI1145=m
> # CONFIG_STK3310 is not set
> CONFIG_ST_UVIS25=m
> CONFIG_ST_UVIS25_I2C=m
> CONFIG_ST_UVIS25_SPI=m
> # CONFIG_TCS3414 is not set
> CONFIG_TCS3472=m
> # CONFIG_SENSORS_TSL2563 is not set
> CONFIG_TSL2583=m
> CONFIG_TSL2591=m
> CONFIG_TSL2772=m
> CONFIG_TSL4531=m
> CONFIG_US5182D=m
> # CONFIG_VCNL4000 is not set
> CONFIG_VCNL4035=m
> CONFIG_VEML6030=m
> # CONFIG_VEML6070 is not set
> CONFIG_VL6180=m
> CONFIG_ZOPT2201=m
> # end of Light sensors
> 
> #
> # Magnetometer sensors
> #
> CONFIG_AK8974=m
> CONFIG_AK8975=m
> CONFIG_AK09911=m
> CONFIG_BMC150_MAGN=m
> CONFIG_BMC150_MAGN_I2C=m
> # CONFIG_BMC150_MAGN_SPI is not set
> CONFIG_MAG3110=m
> CONFIG_HID_SENSOR_MAGNETOMETER_3D=m
> # CONFIG_MMC35240 is not set
> CONFIG_IIO_ST_MAGN_3AXIS=m
> CONFIG_IIO_ST_MAGN_I2C_3AXIS=m
> CONFIG_IIO_ST_MAGN_SPI_3AXIS=m
> # CONFIG_SENSORS_HMC5843_I2C is not set
> # CONFIG_SENSORS_HMC5843_SPI is not set
> CONFIG_SENSORS_RM3100=m
> CONFIG_SENSORS_RM3100_I2C=m
> CONFIG_SENSORS_RM3100_SPI=m
> # CONFIG_YAMAHA_YAS530 is not set
> # end of Magnetometer sensors
> 
> #
> # Multiplexers
> #
> CONFIG_IIO_MUX=m
> # end of Multiplexers
> 
> #
> # Inclinometer sensors
> #
> # CONFIG_HID_SENSOR_INCLINOMETER_3D is not set
> CONFIG_HID_SENSOR_DEVICE_ROTATION=m
> # end of Inclinometer sensors
> 
> CONFIG_IIO_RESCALE_KUNIT_TEST=m
> # CONFIG_IIO_FORMAT_KUNIT_TEST is not set
> 
> #
> # Triggers - standalone
> #
> # CONFIG_IIO_HRTIMER_TRIGGER is not set
> CONFIG_IIO_INTERRUPT_TRIGGER=m
> # CONFIG_IIO_STM32_LPTIMER_TRIGGER is not set
> CONFIG_IIO_STM32_TIMER_TRIGGER=m
> CONFIG_IIO_TIGHTLOOP_TRIGGER=m
> CONFIG_IIO_SYSFS_TRIGGER=m
> # end of Triggers - standalone
> 
> #
> # Linear and angular position sensors
> #
> CONFIG_IQS624_POS=m
> CONFIG_HID_SENSOR_CUSTOM_INTEL_HINGE=m
> # end of Linear and angular position sensors
> 
> #
> # Digital potentiometers
> #
> # CONFIG_AD5110 is not set
> CONFIG_AD5272=m
> # CONFIG_DS1803 is not set
> CONFIG_MAX5432=m
> # CONFIG_MAX5481 is not set
> CONFIG_MAX5487=m
> CONFIG_MCP4018=m
> CONFIG_MCP4131=m
> CONFIG_MCP4531=m
> # CONFIG_MCP41010 is not set
> # CONFIG_TPL0102 is not set
> # end of Digital potentiometers
> 
> #
> # Digital potentiostats
> #
> CONFIG_LMP91000=m
> # end of Digital potentiostats
> 
> #
> # Pressure sensors
> #
> CONFIG_ABP060MG=m
> CONFIG_BMP280=m
> CONFIG_BMP280_I2C=m
> CONFIG_BMP280_SPI=m
> CONFIG_DLHL60D=m
> CONFIG_DPS310=m
> CONFIG_HID_SENSOR_PRESS=m
> # CONFIG_HP03 is not set
> CONFIG_ICP10100=m
> CONFIG_MPL115=m
> # CONFIG_MPL115_I2C is not set
> CONFIG_MPL115_SPI=m
> CONFIG_MPL3115=m
> CONFIG_MS5611=m
> CONFIG_MS5611_I2C=m
> CONFIG_MS5611_SPI=m
> # CONFIG_MS5637 is not set
> CONFIG_IIO_ST_PRESS=m
> CONFIG_IIO_ST_PRESS_I2C=m
> CONFIG_IIO_ST_PRESS_SPI=m
> CONFIG_T5403=m
> CONFIG_HP206C=m
> CONFIG_ZPA2326=m
> CONFIG_ZPA2326_I2C=m
> CONFIG_ZPA2326_SPI=m
> # end of Pressure sensors
> 
> #
> # Lightning sensors
> #
> # CONFIG_AS3935 is not set
> # end of Lightning sensors
> 
> #
> # Proximity and distance sensors
> #
> # CONFIG_ISL29501 is not set
> CONFIG_LIDAR_LITE_V2=m
> CONFIG_MB1232=m
> CONFIG_PING=m
> # CONFIG_RFD77402 is not set
> CONFIG_SRF04=m
> CONFIG_SX_COMMON=m
> # CONFIG_SX9310 is not set
> CONFIG_SX9324=m
> # CONFIG_SX9360 is not set
> CONFIG_SX9500=m
> # CONFIG_SRF08 is not set
> CONFIG_VCNL3020=m
> CONFIG_VL53L0X_I2C=m
> # end of Proximity and distance sensors
> 
> #
> # Resolver to digital converters
> #
> CONFIG_AD2S90=m
> # CONFIG_AD2S1200 is not set
> # end of Resolver to digital converters
> 
> #
> # Temperature sensors
> #
> CONFIG_IQS620AT_TEMP=m
> CONFIG_LTC2983=m
> CONFIG_MAXIM_THERMOCOUPLE=m
> CONFIG_HID_SENSOR_TEMP=m
> # CONFIG_MLX90614 is not set
> # CONFIG_MLX90632 is not set
> # CONFIG_TMP006 is not set
> CONFIG_TMP007=m
> CONFIG_TMP117=m
> CONFIG_TSYS01=m
> CONFIG_TSYS02D=m
> # CONFIG_MAX30208 is not set
> CONFIG_MAX31856=m
> CONFIG_MAX31865=m
> # end of Temperature sensors
> 
> CONFIG_PWM=y
> CONFIG_PWM_SYSFS=y
> # CONFIG_PWM_DEBUG is not set
> # CONFIG_PWM_ATMEL is not set
> # CONFIG_PWM_ATMEL_HLCDC_PWM is not set
> CONFIG_PWM_ATMEL_TCB=y
> # CONFIG_PWM_BCM_IPROC is not set
> # CONFIG_PWM_BCM_KONA is not set
> # CONFIG_PWM_BCM2835 is not set
> # CONFIG_PWM_BERLIN is not set
> # CONFIG_PWM_BRCMSTB is not set
> # CONFIG_PWM_CLK is not set
> # CONFIG_PWM_CLPS711X is not set
> # CONFIG_PWM_EP93XX is not set
> CONFIG_PWM_FSL_FTM=y
> # CONFIG_PWM_HIBVT is not set
> # CONFIG_PWM_IMG is not set
> # CONFIG_PWM_IMX1 is not set
> # CONFIG_PWM_IMX27 is not set
> # CONFIG_PWM_IMX_TPM is not set
> # CONFIG_PWM_INTEL_LGM is not set
> CONFIG_PWM_IQS620A=m
> # CONFIG_PWM_JZ4740 is not set
> # CONFIG_PWM_KEEMBAY is not set
> CONFIG_PWM_LPC18XX_SCT=y
> # CONFIG_PWM_LPC32XX is not set
> # CONFIG_PWM_LPSS_PLATFORM is not set
> # CONFIG_PWM_MESON is not set
> # CONFIG_PWM_MTK_DISP is not set
> # CONFIG_PWM_MEDIATEK is not set
> # CONFIG_PWM_MXS is not set
> # CONFIG_PWM_OMAP_DMTIMER is not set
> CONFIG_PWM_PCA9685=m
> # CONFIG_PWM_PXA is not set
> # CONFIG_PWM_RASPBERRYPI_POE is not set
> # CONFIG_PWM_RCAR is not set
> # CONFIG_PWM_RENESAS_TPU is not set
> # CONFIG_PWM_ROCKCHIP is not set
> # CONFIG_PWM_SAMSUNG is not set
> # CONFIG_PWM_SIFIVE is not set
> # CONFIG_PWM_SL28CPLD is not set
> # CONFIG_PWM_SPEAR is not set
> # CONFIG_PWM_SPRD is not set
> # CONFIG_PWM_STI is not set
> # CONFIG_PWM_STM32 is not set
> # CONFIG_PWM_STM32_LP is not set
> # CONFIG_PWM_STMPE is not set
> # CONFIG_PWM_SUN4I is not set
> # CONFIG_PWM_SUNPLUS is not set
> # CONFIG_PWM_TEGRA is not set
> # CONFIG_PWM_TIECAP is not set
> # CONFIG_PWM_TIEHRPWM is not set
> CONFIG_PWM_TWL=y
> CONFIG_PWM_TWL_LED=y
> # CONFIG_PWM_VISCONTI is not set
> # CONFIG_PWM_VT8500 is not set
> CONFIG_PWM_XILINX=y
> 
> #
> # IRQ chip support
> #
> CONFIG_IRQCHIP=y
> CONFIG_ARM_NVIC=y
> # CONFIG_AL_FIC is not set
> CONFIG_MADERA_IRQ=m
> # CONFIG_JCORE_AIC is not set
> # CONFIG_RENESAS_INTC_IRQPIN is not set
> # CONFIG_RENESAS_IRQC is not set
> # CONFIG_RENESAS_RZA1_IRQC is not set
> # CONFIG_RENESAS_RZG2L_IRQC is not set
> # CONFIG_SL28CPLD_INTC is not set
> # CONFIG_TS4800_IRQ is not set
> CONFIG_XILINX_INTC=y
> # CONFIG_INGENIC_TCU_IRQ is not set
> CONFIG_STM32_EXTI=y
> # CONFIG_IRQ_UNIPHIER_AIDET is not set
> # CONFIG_MESON_IRQ_GPIO is not set
> # CONFIG_IMX_IRQSTEER is not set
> # CONFIG_IMX_INTMUX is not set
> # CONFIG_IMX_MU_MSI is not set
> # CONFIG_EXYNOS_IRQ_COMBINER is not set
> # CONFIG_MST_IRQ is not set
> CONFIG_MCHP_EIC=y
> # CONFIG_SUNPLUS_SP7021_INTC is not set
> # end of IRQ chip support
> 
> CONFIG_IPACK_BUS=y
> # CONFIG_SERIAL_IPOCTAL is not set
> CONFIG_ARCH_HAS_RESET_CONTROLLER=y
> CONFIG_RESET_CONTROLLER=y
> # CONFIG_RESET_A10SR is not set
> # CONFIG_RESET_ATH79 is not set
> # CONFIG_RESET_AXS10X is not set
> # CONFIG_RESET_BCM6345 is not set
> # CONFIG_RESET_BERLIN is not set
> # CONFIG_RESET_BRCMSTB is not set
> # CONFIG_RESET_BRCMSTB_RESCAL is not set
> # CONFIG_RESET_HSDK is not set
> # CONFIG_RESET_IMX7 is not set
> # CONFIG_RESET_INTEL_GW is not set
> # CONFIG_RESET_K210 is not set
> # CONFIG_RESET_LANTIQ is not set
> CONFIG_RESET_LPC18XX=y
> # CONFIG_RESET_MCHP_SPARX5 is not set
> # CONFIG_RESET_MESON is not set
> # CONFIG_RESET_MESON_AUDIO_ARB is not set
> # CONFIG_RESET_NPCM is not set
> # CONFIG_RESET_PISTACHIO is not set
> # CONFIG_RESET_QCOM_AOSS is not set
> # CONFIG_RESET_QCOM_PDC is not set
> # CONFIG_RESET_RASPBERRYPI is not set
> # CONFIG_RESET_RZG2L_USBPHY_CTRL is not set
> CONFIG_RESET_SCMI=m
> # CONFIG_RESET_SIMPLE is not set
> # CONFIG_RESET_SOCFPGA is not set
> # CONFIG_RESET_STARFIVE_JH7100 is not set
> # CONFIG_RESET_SUNPLUS is not set
> # CONFIG_RESET_SUNXI is not set
> # CONFIG_RESET_TI_SCI is not set
> CONFIG_RESET_TI_SYSCON=y
> CONFIG_RESET_TI_TPS380X=y
> # CONFIG_RESET_TN48M_CPLD is not set
> # CONFIG_RESET_UNIPHIER is not set
> # CONFIG_RESET_UNIPHIER_GLUE is not set
> # CONFIG_RESET_ZYNQ is not set
> # CONFIG_COMMON_RESET_HI3660 is not set
> # CONFIG_COMMON_RESET_HI6220 is not set
> 
> #
> # PHY Subsystem
> #
> CONFIG_GENERIC_PHY=y
> CONFIG_GENERIC_PHY_MIPI_DPHY=y
> # CONFIG_PHY_LPC18XX_USB_OTG is not set
> # CONFIG_PHY_PISTACHIO_USB is not set
> # CONFIG_PHY_XGENE is not set
> # CONFIG_USB_LGM_PHY is not set
> CONFIG_PHY_CAN_TRANSCEIVER=y
> # CONFIG_PHY_SUN4I_USB is not set
> # CONFIG_PHY_SUN6I_MIPI_DPHY is not set
> # CONFIG_PHY_SUN9I_USB is not set
> # CONFIG_PHY_SUN50I_USB3 is not set
> # CONFIG_PHY_MESON8_HDMI_TX is not set
> # CONFIG_PHY_MESON8B_USB2 is not set
> # CONFIG_PHY_MESON_GXL_USB2 is not set
> # CONFIG_PHY_MESON_G12A_MIPI_DPHY_ANALOG is not set
> # CONFIG_PHY_MESON_G12A_USB2 is not set
> # CONFIG_PHY_MESON_G12A_USB3_PCIE is not set
> # CONFIG_PHY_MESON_AXG_PCIE is not set
> # CONFIG_PHY_MESON_AXG_MIPI_PCIE_ANALOG is not set
> # CONFIG_PHY_MESON_AXG_MIPI_DPHY is not set
> 
> #
> # PHY drivers for Broadcom platforms
> #
> # CONFIG_PHY_BCM63XX_USBH is not set
> # CONFIG_PHY_CYGNUS_PCIE is not set
> # CONFIG_PHY_BCM_SR_USB is not set
> CONFIG_BCM_KONA_USB2_PHY=y
> # CONFIG_PHY_BCM_NS_USB2 is not set
> # CONFIG_PHY_NS2_USB_DRD is not set
> # CONFIG_PHY_BRCM_SATA is not set
> # CONFIG_PHY_BRCM_USB is not set
> # CONFIG_PHY_BCM_SR_PCIE is not set
> # end of PHY drivers for Broadcom platforms
> 
> CONFIG_PHY_CADENCE_TORRENT=y
> CONFIG_PHY_CADENCE_DPHY=y
> CONFIG_PHY_CADENCE_DPHY_RX=m
> # CONFIG_PHY_CADENCE_SIERRA is not set
> CONFIG_PHY_CADENCE_SALVO=m
> # CONFIG_PHY_FSL_IMX8MQ_USB is not set
> # CONFIG_PHY_MIXEL_LVDS_PHY is not set
> # CONFIG_PHY_MIXEL_MIPI_DPHY is not set
> # CONFIG_PHY_FSL_IMX8M_PCIE is not set
> # CONFIG_PHY_FSL_LYNX_28G is not set
> # CONFIG_PHY_HI6220_USB is not set
> # CONFIG_PHY_HI3660_USB is not set
> # CONFIG_PHY_HI3670_USB is not set
> # CONFIG_PHY_HI3670_PCIE is not set
> # CONFIG_PHY_HISTB_COMBPHY is not set
> # CONFIG_PHY_HISI_INNO_USB2 is not set
> # CONFIG_PHY_INGENIC_USB is not set
> # CONFIG_PHY_LANTIQ_VRX200_PCIE is not set
> # CONFIG_PHY_LANTIQ_RCU_USB2 is not set
> # CONFIG_ARMADA375_USBCLUSTER_PHY is not set
> # CONFIG_PHY_BERLIN_SATA is not set
> # CONFIG_PHY_BERLIN_USB is not set
> CONFIG_PHY_MVEBU_A3700_UTMI=y
> # CONFIG_PHY_MVEBU_A38X_COMPHY is not set
> # CONFIG_PHY_MVEBU_CP110_UTMI is not set
> CONFIG_PHY_PXA_28NM_HSIC=m
> # CONFIG_PHY_PXA_28NM_USB2 is not set
> # CONFIG_PHY_PXA_USB is not set
> # CONFIG_PHY_MMP3_USB is not set
> # CONFIG_PHY_MMP3_HSIC is not set
> # CONFIG_PHY_MTK_PCIE is not set
> # CONFIG_PHY_MTK_TPHY is not set
> # CONFIG_PHY_MTK_UFS is not set
> # CONFIG_PHY_MTK_XSPHY is not set
> # CONFIG_PHY_MTK_HDMI is not set
> # CONFIG_PHY_MTK_MIPI_DSI is not set
> # CONFIG_PHY_MTK_DP is not set
> # CONFIG_PHY_SPARX5_SERDES is not set
> CONFIG_PHY_LAN966X_SERDES=y
> CONFIG_PHY_CPCAP_USB=m
> CONFIG_PHY_MAPPHONE_MDM6600=y
> # CONFIG_PHY_OCELOT_SERDES is not set
> CONFIG_PHY_ATH79_USB=y
> # CONFIG_PHY_QCOM_EDP is not set
> # CONFIG_PHY_QCOM_IPQ4019_USB is not set
> # CONFIG_PHY_QCOM_PCIE2 is not set
> # CONFIG_PHY_QCOM_QMP is not set
> # CONFIG_PHY_QCOM_QUSB2 is not set
> CONFIG_PHY_QCOM_USB_HS=m
> # CONFIG_PHY_QCOM_USB_SNPS_FEMTO_V2 is not set
> # CONFIG_PHY_QCOM_USB_HSIC is not set
> # CONFIG_PHY_QCOM_USB_HS_28NM is not set
> # CONFIG_PHY_QCOM_USB_SS is not set
> # CONFIG_PHY_QCOM_IPQ806X_USB is not set
> # CONFIG_PHY_MT7621_PCI is not set
> # CONFIG_PHY_RALINK_USB is not set
> # CONFIG_PHY_R8A779F0_ETHERNET_SERDES is not set
> # CONFIG_PHY_RCAR_GEN3_USB3 is not set
> # CONFIG_PHY_ROCKCHIP_DPHY_RX0 is not set
> # CONFIG_PHY_ROCKCHIP_INNO_HDMI is not set
> # CONFIG_PHY_ROCKCHIP_INNO_USB2 is not set
> # CONFIG_PHY_ROCKCHIP_INNO_CSIDPHY is not set
> # CONFIG_PHY_ROCKCHIP_INNO_DSIDPHY is not set
> # CONFIG_PHY_ROCKCHIP_PCIE is not set
> # CONFIG_PHY_ROCKCHIP_SNPS_PCIE3 is not set
> # CONFIG_PHY_ROCKCHIP_TYPEC is not set
> # CONFIG_PHY_EXYNOS_DP_VIDEO is not set
> # CONFIG_PHY_EXYNOS_MIPI_VIDEO is not set
> # CONFIG_PHY_EXYNOS_PCIE is not set
> # CONFIG_PHY_SAMSUNG_UFS is not set
> # CONFIG_PHY_SAMSUNG_USB2 is not set
> # CONFIG_PHY_UNIPHIER_USB2 is not set
> # CONFIG_PHY_UNIPHIER_USB3 is not set
> # CONFIG_PHY_UNIPHIER_PCIE is not set
> CONFIG_PHY_UNIPHIER_AHCI=m
> # CONFIG_PHY_ST_SPEAR1310_MIPHY is not set
> # CONFIG_PHY_ST_SPEAR1340_MIPHY is not set
> # CONFIG_PHY_STIH407_USB is not set
> CONFIG_PHY_STM32_USBPHYC=m
> # CONFIG_PHY_SUNPLUS_USB is not set
> # CONFIG_PHY_TEGRA194_P2U is not set
> # CONFIG_PHY_DA8XX_USB is not set
> # CONFIG_PHY_DM816X_USB is not set
> # CONFIG_PHY_AM654_SERDES is not set
> # CONFIG_PHY_J721E_WIZ is not set
> # CONFIG_OMAP_CONTROL_PHY is not set
> # CONFIG_TI_PIPE3 is not set
> CONFIG_PHY_TUSB1210=m
> # CONFIG_PHY_INTEL_KEEMBAY_EMMC is not set
> # CONFIG_PHY_INTEL_KEEMBAY_USB is not set
> # CONFIG_PHY_INTEL_LGM_COMBO is not set
> # CONFIG_PHY_INTEL_LGM_EMMC is not set
> # CONFIG_PHY_INTEL_THUNDERBAY_EMMC is not set
> # CONFIG_PHY_XILINX_ZYNQMP is not set
> # end of PHY Subsystem
> 
> CONFIG_POWERCAP=y
> # CONFIG_ARM_SCMI_POWERCAP is not set
> # CONFIG_DTPM is not set
> CONFIG_MCB=y
> # CONFIG_MCB_LPC is not set
> 
> #
> # Performance monitor support
> #
> # CONFIG_ARM_CCN is not set
> # CONFIG_ARM_CMN is not set
> # CONFIG_ARM_PMU is not set
> # CONFIG_FSL_IMX8_DDR_PMU is not set
> # CONFIG_ARM_DMC620_PMU is not set
> # CONFIG_ALIBABA_UNCORE_DRW_PMU is not set
> # CONFIG_MESON_DDR_PMU is not set
> # end of Performance monitor support
> 
> # CONFIG_RAS is not set
> 
> #
> # Android
> #
> # end of Android
> 
> # CONFIG_DAX is not set
> CONFIG_NVMEM=y
> CONFIG_NVMEM_SYSFS=y
> # CONFIG_NVMEM_APPLE_EFUSES is not set
> # CONFIG_NVMEM_BCM_OCOTP is not set
> # CONFIG_NVMEM_BRCM_NVRAM is not set
> # CONFIG_NVMEM_IMX_IIM is not set
> # CONFIG_NVMEM_IMX_OCOTP is not set
> # CONFIG_NVMEM_JZ4780_EFUSE is not set
> # CONFIG_NVMEM_LAN9662_OTPC is not set
> # CONFIG_NVMEM_LAYERSCAPE_SFP is not set
> CONFIG_NVMEM_LPC18XX_EEPROM=m
> CONFIG_NVMEM_LPC18XX_OTP=m
> # CONFIG_NVMEM_MESON_MX_EFUSE is not set
> CONFIG_NVMEM_MICROCHIP_OTPC=m
> # CONFIG_NVMEM_MTK_EFUSE is not set
> # CONFIG_NVMEM_MXS_OCOTP is not set
> # CONFIG_NVMEM_NINTENDO_OTP is not set
> # CONFIG_NVMEM_QCOM_QFPROM is not set
> CONFIG_NVMEM_RMEM=y
> # CONFIG_NVMEM_ROCKCHIP_EFUSE is not set
> # CONFIG_NVMEM_ROCKCHIP_OTP is not set
> # CONFIG_NVMEM_SC27XX_EFUSE is not set
> # CONFIG_NVMEM_SNVS_LPGPR is not set
> CONFIG_NVMEM_SPMI_SDAM=y
> # CONFIG_NVMEM_SPRD_EFUSE is not set
> # CONFIG_NVMEM_STM32_ROMEM is not set
> # CONFIG_NVMEM_SUNPLUS_OCOTP is not set
> CONFIG_NVMEM_U_BOOT_ENV=m
> # CONFIG_NVMEM_UNIPHIER_EFUSE is not set
> # CONFIG_NVMEM_VF610_OCOTP is not set
> 
> #
> # HW tracing support
> #
> CONFIG_STM=y
> CONFIG_STM_PROTO_BASIC=m
> CONFIG_STM_PROTO_SYS_T=m
> CONFIG_STM_DUMMY=y
> CONFIG_STM_SOURCE_CONSOLE=y
> CONFIG_STM_SOURCE_HEARTBEAT=m
> CONFIG_INTEL_TH=y
> CONFIG_INTEL_TH_GTH=m
> CONFIG_INTEL_TH_STH=y
> # CONFIG_INTEL_TH_MSU is not set
> # CONFIG_INTEL_TH_PTI is not set
> # CONFIG_INTEL_TH_DEBUG is not set
> # end of HW tracing support
> 
> # CONFIG_FPGA is not set
> CONFIG_FSI=y
> CONFIG_FSI_NEW_DEV_NODE=y
> CONFIG_FSI_MASTER_GPIO=y
> CONFIG_FSI_MASTER_HUB=m
> # CONFIG_FSI_MASTER_ASPEED is not set
> CONFIG_FSI_SCOM=y
> CONFIG_FSI_SBEFIFO=y
> CONFIG_FSI_OCC=m
> # CONFIG_TEE is not set
> CONFIG_MULTIPLEXER=y
> 
> #
> # Multiplexer drivers
> #
> # CONFIG_MUX_ADG792A is not set
> CONFIG_MUX_ADGS1408=m
> # CONFIG_MUX_GPIO is not set
> CONFIG_MUX_MMIO=y
> # end of Multiplexer drivers
> 
> CONFIG_PM_OPP=y
> CONFIG_SIOX=y
> CONFIG_SIOX_BUS_GPIO=m
> CONFIG_SLIMBUS=y
> CONFIG_SLIM_QCOM_CTRL=m
> CONFIG_INTERCONNECT=y
> # CONFIG_INTERCONNECT_IMX is not set
> # CONFIG_INTERCONNECT_QCOM_OSM_L3 is not set
> # CONFIG_INTERCONNECT_SAMSUNG is not set
> # CONFIG_COUNTER is not set
> CONFIG_MOST=y
> CONFIG_MOST_USB_HDM=y
> # CONFIG_MOST_CDEV is not set
> CONFIG_MOST_SND=m
> # CONFIG_PECI is not set
> # CONFIG_HTE is not set
> # end of Device Drivers
> 
> #
> # File systems
> #
> # CONFIG_VALIDATE_FS_PARSER is not set
> CONFIG_FS_IOMAP=y
> # CONFIG_EXT2_FS is not set
> # CONFIG_EXT3_FS is not set
> CONFIG_EXT4_FS=m
> CONFIG_EXT4_USE_FOR_EXT2=y
> # CONFIG_EXT4_FS_POSIX_ACL is not set
> # CONFIG_EXT4_FS_SECURITY is not set
> CONFIG_EXT4_DEBUG=y
> # CONFIG_EXT4_KUNIT_TESTS is not set
> CONFIG_JBD2=m
> CONFIG_JBD2_DEBUG=y
> CONFIG_FS_MBCACHE=m
> CONFIG_REISERFS_FS=y
> CONFIG_REISERFS_CHECK=y
> # CONFIG_REISERFS_PROC_INFO is not set
> # CONFIG_REISERFS_FS_XATTR is not set
> CONFIG_JFS_FS=m
> # CONFIG_JFS_POSIX_ACL is not set
> CONFIG_JFS_SECURITY=y
> CONFIG_JFS_DEBUG=y
> # CONFIG_JFS_STATISTICS is not set
> # CONFIG_XFS_FS is not set
> CONFIG_GFS2_FS=m
> # CONFIG_BTRFS_FS is not set
> CONFIG_NILFS2_FS=y
> CONFIG_F2FS_FS=y
> CONFIG_F2FS_STAT_FS=y
> CONFIG_F2FS_FS_XATTR=y
> # CONFIG_F2FS_FS_POSIX_ACL is not set
> # CONFIG_F2FS_FS_SECURITY is not set
> # CONFIG_F2FS_CHECK_FS is not set
> # CONFIG_F2FS_FAULT_INJECTION is not set
> CONFIG_F2FS_FS_COMPRESSION=y
> CONFIG_F2FS_FS_LZO=y
> CONFIG_F2FS_FS_LZORLE=y
> CONFIG_F2FS_FS_LZ4=y
> # CONFIG_F2FS_FS_LZ4HC is not set
> # CONFIG_F2FS_FS_ZSTD is not set
> # CONFIG_F2FS_IOSTAT is not set
> CONFIG_F2FS_UNFAIR_RWSEM=y
> CONFIG_ZONEFS_FS=m
> CONFIG_FS_POSIX_ACL=y
> CONFIG_EXPORTFS=y
> CONFIG_EXPORTFS_BLOCK_OPS=y
> CONFIG_FILE_LOCKING=y
> CONFIG_FS_ENCRYPTION=y
> CONFIG_FS_ENCRYPTION_ALGS=y
> CONFIG_FS_VERITY=y
> # CONFIG_FS_VERITY_DEBUG is not set
> CONFIG_FS_VERITY_BUILTIN_SIGNATURES=y
> # CONFIG_DNOTIFY is not set
> # CONFIG_INOTIFY_USER is not set
> # CONFIG_FANOTIFY is not set
> # CONFIG_QUOTA is not set
> CONFIG_QUOTACTL=y
> CONFIG_AUTOFS4_FS=y
> CONFIG_AUTOFS_FS=y
> CONFIG_FUSE_FS=m
> CONFIG_CUSE=m
> CONFIG_VIRTIO_FS=m
> # CONFIG_OVERLAY_FS is not set
> 
> #
> # Caches
> #
> CONFIG_NETFS_SUPPORT=y
> CONFIG_NETFS_STATS=y
> CONFIG_FSCACHE=y
> # CONFIG_FSCACHE_STATS is not set
> CONFIG_FSCACHE_DEBUG=y
> CONFIG_CACHEFILES=m
> CONFIG_CACHEFILES_DEBUG=y
> # CONFIG_CACHEFILES_ERROR_INJECTION is not set
> # CONFIG_CACHEFILES_ONDEMAND is not set
> # end of Caches
> 
> #
> # CD-ROM/DVD Filesystems
> #
> CONFIG_ISO9660_FS=y
> CONFIG_JOLIET=y
> # CONFIG_ZISOFS is not set
> # CONFIG_UDF_FS is not set
> # end of CD-ROM/DVD Filesystems
> 
> #
> # DOS/FAT/EXFAT/NT Filesystems
> #
> CONFIG_FAT_FS=y
> # CONFIG_MSDOS_FS is not set
> CONFIG_VFAT_FS=y
> CONFIG_FAT_DEFAULT_CODEPAGE=437
> CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
> # CONFIG_FAT_DEFAULT_UTF8 is not set
> CONFIG_FAT_KUNIT_TEST=m
> # CONFIG_EXFAT_FS is not set
> # CONFIG_NTFS_FS is not set
> CONFIG_NTFS3_FS=y
> CONFIG_NTFS3_LZX_XPRESS=y
> CONFIG_NTFS3_FS_POSIX_ACL=y
> # end of DOS/FAT/EXFAT/NT Filesystems
> 
> #
> # Pseudo filesystems
> #
> CONFIG_PROC_FS=y
> CONFIG_PROC_SYSCTL=y
> CONFIG_PROC_CHILDREN=y
> CONFIG_KERNFS=y
> CONFIG_SYSFS=y
> CONFIG_CONFIGFS_FS=y
> # end of Pseudo filesystems
> 
> CONFIG_MISC_FILESYSTEMS=y
> CONFIG_ORANGEFS_FS=y
> CONFIG_ADFS_FS=m
> CONFIG_ADFS_FS_RW=y
> CONFIG_AFFS_FS=m
> # CONFIG_ECRYPT_FS is not set
> CONFIG_HFS_FS=m
> CONFIG_HFSPLUS_FS=y
> # CONFIG_BEFS_FS is not set
> CONFIG_BFS_FS=m
> CONFIG_EFS_FS=m
> CONFIG_JFFS2_FS=m
> CONFIG_JFFS2_FS_DEBUG=0
> # CONFIG_JFFS2_FS_WRITEBUFFER is not set
> # CONFIG_JFFS2_SUMMARY is not set
> CONFIG_JFFS2_FS_XATTR=y
> CONFIG_JFFS2_FS_POSIX_ACL=y
> # CONFIG_JFFS2_FS_SECURITY is not set
> CONFIG_JFFS2_COMPRESSION_OPTIONS=y
> CONFIG_JFFS2_ZLIB=y
> # CONFIG_JFFS2_LZO is not set
> CONFIG_JFFS2_RTIME=y
> CONFIG_JFFS2_RUBIN=y
> # CONFIG_JFFS2_CMODE_NONE is not set
> # CONFIG_JFFS2_CMODE_PRIORITY is not set
> # CONFIG_JFFS2_CMODE_SIZE is not set
> CONFIG_JFFS2_CMODE_FAVOURLZO=y
> CONFIG_CRAMFS=m
> CONFIG_CRAMFS_BLOCKDEV=y
> CONFIG_CRAMFS_MTD=y
> CONFIG_SQUASHFS=m
> CONFIG_SQUASHFS_FILE_CACHE=y
> # CONFIG_SQUASHFS_FILE_DIRECT is not set
> CONFIG_SQUASHFS_DECOMP_SINGLE=y
> # CONFIG_SQUASHFS_CHOICE_DECOMP_BY_MOUNT is not set
> CONFIG_SQUASHFS_COMPILE_DECOMP_SINGLE=y
> # CONFIG_SQUASHFS_COMPILE_DECOMP_MULTI is not set
> # CONFIG_SQUASHFS_COMPILE_DECOMP_MULTI_PERCPU is not set
> CONFIG_SQUASHFS_XATTR=y
> CONFIG_SQUASHFS_ZLIB=y
> # CONFIG_SQUASHFS_LZ4 is not set
> CONFIG_SQUASHFS_LZO=y
> # CONFIG_SQUASHFS_XZ is not set
> CONFIG_SQUASHFS_ZSTD=y
> CONFIG_SQUASHFS_4K_DEVBLK_SIZE=y
> CONFIG_SQUASHFS_EMBEDDED=y
> CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
> CONFIG_VXFS_FS=y
> CONFIG_MINIX_FS=m
> CONFIG_OMFS_FS=y
> # CONFIG_HPFS_FS is not set
> CONFIG_QNX4FS_FS=m
> CONFIG_QNX6FS_FS=m
> CONFIG_QNX6FS_DEBUG=y
> CONFIG_ROMFS_FS=y
> CONFIG_ROMFS_BACKED_BY_BLOCK=y
> CONFIG_ROMFS_ON_BLOCK=y
> CONFIG_PSTORE=y
> CONFIG_PSTORE_DEFAULT_KMSG_BYTES=10240
> CONFIG_PSTORE_DEFLATE_COMPRESS=y
> CONFIG_PSTORE_LZO_COMPRESS=y
> # CONFIG_PSTORE_LZ4_COMPRESS is not set
> CONFIG_PSTORE_LZ4HC_COMPRESS=m
> CONFIG_PSTORE_842_COMPRESS=y
> CONFIG_PSTORE_ZSTD_COMPRESS=y
> CONFIG_PSTORE_COMPRESS=y
> # CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT is not set
> # CONFIG_PSTORE_LZO_COMPRESS_DEFAULT is not set
> # CONFIG_PSTORE_LZ4HC_COMPRESS_DEFAULT is not set
> CONFIG_PSTORE_842_COMPRESS_DEFAULT=y
> # CONFIG_PSTORE_ZSTD_COMPRESS_DEFAULT is not set
> CONFIG_PSTORE_COMPRESS_DEFAULT="842"
> # CONFIG_PSTORE_CONSOLE is not set
> # CONFIG_PSTORE_PMSG is not set
> CONFIG_PSTORE_RAM=y
> CONFIG_PSTORE_ZONE=m
> CONFIG_PSTORE_BLK=m
> CONFIG_PSTORE_BLK_BLKDEV=""
> CONFIG_PSTORE_BLK_KMSG_SIZE=64
> CONFIG_PSTORE_BLK_MAX_REASON=2
> # CONFIG_SYSV_FS is not set
> # CONFIG_UFS_FS is not set
> CONFIG_EROFS_FS=y
> # CONFIG_EROFS_FS_DEBUG is not set
> # CONFIG_EROFS_FS_XATTR is not set
> CONFIG_EROFS_FS_ZIP=y
> CONFIG_EROFS_FS_ZIP_LZMA=y
> CONFIG_NLS=y
> CONFIG_NLS_DEFAULT="iso8859-1"
> CONFIG_NLS_CODEPAGE_437=m
> CONFIG_NLS_CODEPAGE_737=m
> CONFIG_NLS_CODEPAGE_775=y
> CONFIG_NLS_CODEPAGE_850=y
> CONFIG_NLS_CODEPAGE_852=y
> CONFIG_NLS_CODEPAGE_855=m
> # CONFIG_NLS_CODEPAGE_857 is not set
> CONFIG_NLS_CODEPAGE_860=y
> # CONFIG_NLS_CODEPAGE_861 is not set
> # CONFIG_NLS_CODEPAGE_862 is not set
> CONFIG_NLS_CODEPAGE_863=y
> CONFIG_NLS_CODEPAGE_864=m
> CONFIG_NLS_CODEPAGE_865=m
> # CONFIG_NLS_CODEPAGE_866 is not set
> CONFIG_NLS_CODEPAGE_869=m
> CONFIG_NLS_CODEPAGE_936=m
> # CONFIG_NLS_CODEPAGE_950 is not set
> CONFIG_NLS_CODEPAGE_932=y
> CONFIG_NLS_CODEPAGE_949=m
> CONFIG_NLS_CODEPAGE_874=m
> CONFIG_NLS_ISO8859_8=m
> CONFIG_NLS_CODEPAGE_1250=m
> CONFIG_NLS_CODEPAGE_1251=y
> CONFIG_NLS_ASCII=y
> # CONFIG_NLS_ISO8859_1 is not set
> CONFIG_NLS_ISO8859_2=y
> CONFIG_NLS_ISO8859_3=m
> CONFIG_NLS_ISO8859_4=y
> CONFIG_NLS_ISO8859_5=m
> # CONFIG_NLS_ISO8859_6 is not set
> CONFIG_NLS_ISO8859_7=y
> # CONFIG_NLS_ISO8859_9 is not set
> CONFIG_NLS_ISO8859_13=m
> CONFIG_NLS_ISO8859_14=m
> CONFIG_NLS_ISO8859_15=m
> CONFIG_NLS_KOI8_R=m
> # CONFIG_NLS_KOI8_U is not set
> # CONFIG_NLS_MAC_ROMAN is not set
> CONFIG_NLS_MAC_CELTIC=y
> CONFIG_NLS_MAC_CENTEURO=y
> CONFIG_NLS_MAC_CROATIAN=m
> CONFIG_NLS_MAC_CYRILLIC=m
> CONFIG_NLS_MAC_GAELIC=y
> CONFIG_NLS_MAC_GREEK=m
> CONFIG_NLS_MAC_ICELAND=m
> CONFIG_NLS_MAC_INUIT=y
> # CONFIG_NLS_MAC_ROMANIAN is not set
> CONFIG_NLS_MAC_TURKISH=y
> CONFIG_NLS_UTF8=y
> CONFIG_UNICODE=y
> CONFIG_UNICODE_NORMALIZATION_SELFTEST=y
> CONFIG_IO_WQ=y
> # end of File systems
> 
> #
> # Security options
> #
> CONFIG_KEYS=y
> CONFIG_KEYS_REQUEST_CACHE=y
> CONFIG_PERSISTENT_KEYRINGS=y
> CONFIG_TRUSTED_KEYS=y
> # CONFIG_TRUSTED_KEYS_TPM is not set
> 
> #
> # No trust source selected!
> #
> CONFIG_ENCRYPTED_KEYS=m
> # CONFIG_USER_DECRYPTED_DATA is not set
> CONFIG_KEY_DH_OPERATIONS=y
> CONFIG_KEY_NOTIFICATIONS=y
> CONFIG_SECURITY_DMESG_RESTRICT=y
> # CONFIG_SECURITY is not set
> CONFIG_SECURITYFS=y
> CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
> CONFIG_HARDENED_USERCOPY=y
> CONFIG_FORTIFY_SOURCE=y
> CONFIG_STATIC_USERMODEHELPER=y
> CONFIG_STATIC_USERMODEHELPER_PATH="/sbin/usermode-helper"
> CONFIG_DEFAULT_SECURITY_DAC=y
> CONFIG_LSM="landlock,lockdown,yama,loadpin,safesetid,integrity,bpf"
> 
> #
> # Kernel hardening options
> #
> 
> #
> # Memory initialization
> #
> CONFIG_CC_HAS_AUTO_VAR_INIT_PATTERN=y
> CONFIG_CC_HAS_AUTO_VAR_INIT_ZERO_BARE=y
> CONFIG_CC_HAS_AUTO_VAR_INIT_ZERO=y
> # CONFIG_INIT_STACK_NONE is not set
> # CONFIG_INIT_STACK_ALL_PATTERN is not set
> CONFIG_INIT_STACK_ALL_ZERO=y
> CONFIG_INIT_ON_ALLOC_DEFAULT_ON=y
> # CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
> CONFIG_CC_HAS_ZERO_CALL_USED_REGS=y
> CONFIG_ZERO_CALL_USED_REGS=y
> # end of Memory initialization
> 
> CONFIG_RANDSTRUCT_NONE=y
> # end of Kernel hardening options
> # end of Security options
> 
> CONFIG_CRYPTO=y
> 
> #
> # Crypto core or helper
> #
> CONFIG_CRYPTO_ALGAPI=y
> CONFIG_CRYPTO_ALGAPI2=y
> CONFIG_CRYPTO_AEAD=y
> CONFIG_CRYPTO_AEAD2=y
> CONFIG_CRYPTO_SKCIPHER=y
> CONFIG_CRYPTO_SKCIPHER2=y
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
> CONFIG_CRYPTO_MANAGER=y
> CONFIG_CRYPTO_MANAGER2=y
> # CONFIG_CRYPTO_MANAGER_DISABLE_TESTS is not set
> # CONFIG_CRYPTO_MANAGER_EXTRA_TESTS is not set
> CONFIG_CRYPTO_NULL=y
> CONFIG_CRYPTO_NULL2=y
> CONFIG_CRYPTO_CRYPTD=y
> CONFIG_CRYPTO_AUTHENC=y
> # CONFIG_CRYPTO_TEST is not set
> # end of Crypto core or helper
> 
> #
> # Public-key cryptography
> #
> CONFIG_CRYPTO_RSA=y
> CONFIG_CRYPTO_DH=y
> CONFIG_CRYPTO_DH_RFC7919_GROUPS=y
> CONFIG_CRYPTO_ECC=y
> CONFIG_CRYPTO_ECDH=y
> # CONFIG_CRYPTO_ECDSA is not set
> CONFIG_CRYPTO_ECRDSA=y
> # CONFIG_CRYPTO_SM2 is not set
> # CONFIG_CRYPTO_CURVE25519 is not set
> # end of Public-key cryptography
> 
> #
> # Block ciphers
> #
> CONFIG_CRYPTO_AES=y
> CONFIG_CRYPTO_AES_TI=y
> # CONFIG_CRYPTO_ARIA is not set
> # CONFIG_CRYPTO_BLOWFISH is not set
> CONFIG_CRYPTO_CAMELLIA=m
> CONFIG_CRYPTO_CAST_COMMON=m
> # CONFIG_CRYPTO_CAST5 is not set
> CONFIG_CRYPTO_CAST6=m
> # CONFIG_CRYPTO_DES is not set
> # CONFIG_CRYPTO_FCRYPT is not set
> # CONFIG_CRYPTO_SERPENT is not set
> CONFIG_CRYPTO_SM4=y
> CONFIG_CRYPTO_SM4_GENERIC=y
> CONFIG_CRYPTO_TWOFISH=y
> CONFIG_CRYPTO_TWOFISH_COMMON=y
> # end of Block ciphers
> 
> #
> # Length-preserving ciphers and modes
> #
> # CONFIG_CRYPTO_ADIANTUM is not set
> CONFIG_CRYPTO_CHACHA20=y
> CONFIG_CRYPTO_CBC=m
> # CONFIG_CRYPTO_CFB is not set
> CONFIG_CRYPTO_CTR=y
> CONFIG_CRYPTO_CTS=m
> CONFIG_CRYPTO_ECB=y
> # CONFIG_CRYPTO_HCTR2 is not set
> CONFIG_CRYPTO_KEYWRAP=y
> # CONFIG_CRYPTO_LRW is not set
> # CONFIG_CRYPTO_OFB is not set
> CONFIG_CRYPTO_PCBC=m
> CONFIG_CRYPTO_XTS=y
> # end of Length-preserving ciphers and modes
> 
> #
> # AEAD (authenticated encryption with associated data) ciphers
> #
> CONFIG_CRYPTO_AEGIS128=m
> CONFIG_CRYPTO_CHACHA20POLY1305=y
> CONFIG_CRYPTO_CCM=y
> CONFIG_CRYPTO_GCM=m
> CONFIG_CRYPTO_SEQIV=y
> CONFIG_CRYPTO_ECHAINIV=m
> # CONFIG_CRYPTO_ESSIV is not set
> # end of AEAD (authenticated encryption with associated data) ciphers
> 
> #
> # Hashes, digests, and MACs
> #
> CONFIG_CRYPTO_BLAKE2B=y
> # CONFIG_CRYPTO_CMAC is not set
> CONFIG_CRYPTO_GHASH=m
> CONFIG_CRYPTO_HMAC=y
> CONFIG_CRYPTO_MD4=y
> CONFIG_CRYPTO_MD5=y
> # CONFIG_CRYPTO_MICHAEL_MIC is not set
> CONFIG_CRYPTO_POLY1305=y
> # CONFIG_CRYPTO_RMD160 is not set
> CONFIG_CRYPTO_SHA1=m
> CONFIG_CRYPTO_SHA256=y
> CONFIG_CRYPTO_SHA512=y
> CONFIG_CRYPTO_SHA3=y
> CONFIG_CRYPTO_SM3=y
> CONFIG_CRYPTO_SM3_GENERIC=y
> CONFIG_CRYPTO_STREEBOG=y
> # CONFIG_CRYPTO_VMAC is not set
> CONFIG_CRYPTO_WP512=y
> CONFIG_CRYPTO_XCBC=m
> CONFIG_CRYPTO_XXHASH=m
> # end of Hashes, digests, and MACs
> 
> #
> # CRCs (cyclic redundancy checks)
> #
> CONFIG_CRYPTO_CRC32C=y
> CONFIG_CRYPTO_CRC32=y
> CONFIG_CRYPTO_CRCT10DIF=y
> CONFIG_CRYPTO_CRC64_ROCKSOFT=m
> # end of CRCs (cyclic redundancy checks)
> 
> #
> # Compression
> #
> CONFIG_CRYPTO_DEFLATE=y
> CONFIG_CRYPTO_LZO=y
> CONFIG_CRYPTO_842=y
> CONFIG_CRYPTO_LZ4=y
> CONFIG_CRYPTO_LZ4HC=m
> CONFIG_CRYPTO_ZSTD=y
> # end of Compression
> 
> #
> # Random number generation
> #
> CONFIG_CRYPTO_ANSI_CPRNG=y
> CONFIG_CRYPTO_DRBG_MENU=y
> CONFIG_CRYPTO_DRBG_HMAC=y
> # CONFIG_CRYPTO_DRBG_HASH is not set
> # CONFIG_CRYPTO_DRBG_CTR is not set
> CONFIG_CRYPTO_DRBG=y
> CONFIG_CRYPTO_JITTERENTROPY=y
> CONFIG_CRYPTO_KDF800108_CTR=y
> # end of Random number generation
> 
> #
> # Userspace interface
> #
> # end of Userspace interface
> 
> CONFIG_CRYPTO_HASH_INFO=y
> 
> #
> # Accelerated Cryptographic Algorithms for CPU (arm)
> #
> CONFIG_CRYPTO_POLY1305_ARM=y
> CONFIG_CRYPTO_BLAKE2S_ARM=y
> CONFIG_CRYPTO_SHA1_ARM=m
> # CONFIG_CRYPTO_AES_ARM is not set
> # CONFIG_CRYPTO_CHACHA20_NEON is not set
> # end of Accelerated Cryptographic Algorithms for CPU (arm)
> 
> # CONFIG_CRYPTO_HW is not set
> CONFIG_ASYMMETRIC_KEY_TYPE=y
> CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
> CONFIG_X509_CERTIFICATE_PARSER=y
> # CONFIG_PKCS8_PRIVATE_KEY_PARSER is not set
> CONFIG_PKCS7_MESSAGE_PARSER=y
> CONFIG_PKCS7_TEST_KEY=m
> # CONFIG_SIGNED_PE_FILE_VERIFICATION is not set
> # CONFIG_FIPS_SIGNATURE_SELFTEST is not set
> 
> #
> # Certificates for signature checking
> #
> CONFIG_SYSTEM_TRUSTED_KEYRING=y
> CONFIG_SYSTEM_TRUSTED_KEYS=""
> # CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
> # CONFIG_SECONDARY_TRUSTED_KEYRING is not set
> CONFIG_SYSTEM_BLACKLIST_KEYRING=y
> CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
> # CONFIG_SYSTEM_REVOCATION_LIST is not set
> # CONFIG_SYSTEM_BLACKLIST_AUTH_UPDATE is not set
> # end of Certificates for signature checking
> 
> #
> # Library routines
> #
> CONFIG_LINEAR_RANGES=y
> CONFIG_PACKING=y
> CONFIG_BITREVERSE=y
> CONFIG_HAVE_ARCH_BITREVERSE=y
> CONFIG_GENERIC_STRNCPY_FROM_USER=y
> CONFIG_GENERIC_STRNLEN_USER=y
> CONFIG_CORDIC=y
> CONFIG_PRIME_NUMBERS=m
> CONFIG_RATIONAL=y
> CONFIG_GENERIC_PCI_IOMAP=y
> CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
> 
> #
> # Crypto library routines
> #
> CONFIG_CRYPTO_LIB_UTILS=y
> CONFIG_CRYPTO_LIB_AES=y
> CONFIG_CRYPTO_LIB_GF128MUL=m
> CONFIG_CRYPTO_ARCH_HAVE_LIB_BLAKE2S=y
> CONFIG_CRYPTO_LIB_CHACHA_GENERIC=y
> CONFIG_CRYPTO_LIB_CHACHA=y
> CONFIG_CRYPTO_LIB_CURVE25519_GENERIC=y
> CONFIG_CRYPTO_LIB_CURVE25519=y
> CONFIG_CRYPTO_LIB_POLY1305_RSIZE=9
> CONFIG_CRYPTO_ARCH_HAVE_LIB_POLY1305=y
> CONFIG_CRYPTO_LIB_POLY1305_GENERIC=y
> CONFIG_CRYPTO_LIB_POLY1305=m
> CONFIG_CRYPTO_LIB_CHACHA20POLY1305=m
> CONFIG_CRYPTO_LIB_SHA1=m
> CONFIG_CRYPTO_LIB_SHA256=y
> # end of Crypto library routines
> 
> CONFIG_CRC_CCITT=m
> CONFIG_CRC16=y
> CONFIG_CRC_T10DIF=y
> # CONFIG_CRC64_ROCKSOFT is not set
> CONFIG_CRC_ITU_T=y
> CONFIG_CRC32=y
> CONFIG_CRC32_SELFTEST=m
> # CONFIG_CRC32_SLICEBY8 is not set
> # CONFIG_CRC32_SLICEBY4 is not set
> CONFIG_CRC32_SARWATE=y
> # CONFIG_CRC32_BIT is not set
> CONFIG_CRC64=m
> CONFIG_CRC4=y
> CONFIG_CRC7=y
> CONFIG_LIBCRC32C=y
> CONFIG_CRC8=m
> CONFIG_XXHASH=y
> # CONFIG_RANDOM32_SELFTEST is not set
> CONFIG_842_COMPRESS=y
> CONFIG_842_DECOMPRESS=y
> CONFIG_ZLIB_INFLATE=y
> CONFIG_ZLIB_DEFLATE=y
> CONFIG_LZO_COMPRESS=y
> CONFIG_LZO_DECOMPRESS=y
> CONFIG_LZ4_COMPRESS=y
> CONFIG_LZ4HC_COMPRESS=m
> CONFIG_LZ4_DECOMPRESS=y
> CONFIG_ZSTD_COMMON=y
> CONFIG_ZSTD_COMPRESS=y
> CONFIG_ZSTD_DECOMPRESS=y
> CONFIG_XZ_DEC=y
> CONFIG_XZ_DEC_X86=y
> # CONFIG_XZ_DEC_POWERPC is not set
> # CONFIG_XZ_DEC_IA64 is not set
> CONFIG_XZ_DEC_ARM=y
> # CONFIG_XZ_DEC_ARMTHUMB is not set
> # CONFIG_XZ_DEC_SPARC is not set
> CONFIG_XZ_DEC_MICROLZMA=y
> CONFIG_XZ_DEC_BCJ=y
> # CONFIG_XZ_DEC_TEST is not set
> CONFIG_DECOMPRESS_BZIP2=y
> CONFIG_DECOMPRESS_XZ=y
> CONFIG_DECOMPRESS_LZO=y
> CONFIG_DECOMPRESS_LZ4=y
> CONFIG_GENERIC_ALLOCATOR=y
> CONFIG_REED_SOLOMON=y
> CONFIG_REED_SOLOMON_ENC8=y
> CONFIG_REED_SOLOMON_DEC8=y
> CONFIG_REED_SOLOMON_DEC16=y
> CONFIG_BCH=m
> CONFIG_BCH_CONST_PARAMS=y
> CONFIG_INTERVAL_TREE=y
> CONFIG_XARRAY_MULTI=y
> CONFIG_ASSOCIATIVE_ARRAY=y
> CONFIG_HAS_IOMEM=y
> CONFIG_HAS_DMA=y
> CONFIG_DMA_OPS=y
> CONFIG_NEED_DMA_MAP_STATE=y
> CONFIG_ARCH_HAS_DMA_WRITE_COMBINE=y
> CONFIG_DMA_DECLARE_COHERENT=y
> CONFIG_ARCH_HAS_SETUP_DMA_OPS=y
> CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE=y
> CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU=y
> CONFIG_DMA_NONCOHERENT_MMAP=y
> CONFIG_DMA_GLOBAL_POOL=y
> CONFIG_DMA_API_DEBUG=y
> CONFIG_DMA_API_DEBUG_SG=y
> # CONFIG_DMA_MAP_BENCHMARK is not set
> CONFIG_SGL_ALLOC=y
> CONFIG_GLOB=y
> CONFIG_GLOB_SELFTEST=m
> CONFIG_GENERIC_ATOMIC64=y
> CONFIG_CLZ_TAB=y
> CONFIG_IRQ_POLL=y
> CONFIG_MPILIB=y
> CONFIG_LIBFDT=y
> CONFIG_OID_REGISTRY=y
> CONFIG_SG_POOL=y
> CONFIG_ARCH_STACKWALK=y
> CONFIG_STACKDEPOT=y
> CONFIG_SBITMAP=y
> # CONFIG_PARMAN is not set
> # CONFIG_OBJAGG is not set
> # end of Library routines
> 
> CONFIG_GENERIC_LIB_DEVMEM_IS_ALLOWED=y
> 
> #
> # Kernel hacking
> #
> 
> #
> # printk and dmesg options
> #
> CONFIG_PRINTK_TIME=y
> CONFIG_PRINTK_CALLER=y
> # CONFIG_STACKTRACE_BUILD_ID is not set
> CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
> CONFIG_CONSOLE_LOGLEVEL_QUIET=4
> CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
> # CONFIG_BOOT_PRINTK_DELAY is not set
> # CONFIG_DYNAMIC_DEBUG is not set
> # CONFIG_DYNAMIC_DEBUG_CORE is not set
> # CONFIG_SYMBOLIC_ERRNAME is not set
> # end of printk and dmesg options
> 
> CONFIG_DEBUG_KERNEL=y
> # CONFIG_DEBUG_MISC is not set
> 
> #
> # Compile-time checks and compiler options
> #
> CONFIG_DEBUG_INFO=y
> CONFIG_AS_HAS_NON_CONST_LEB128=y
> # CONFIG_DEBUG_INFO_NONE is not set
> CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
> # CONFIG_DEBUG_INFO_DWARF4 is not set
> # CONFIG_DEBUG_INFO_DWARF5 is not set
> # CONFIG_DEBUG_INFO_REDUCED is not set
> CONFIG_DEBUG_INFO_COMPRESSED_NONE=y
> # CONFIG_DEBUG_INFO_COMPRESSED_ZLIB is not set
> CONFIG_DEBUG_INFO_SPLIT=y
> CONFIG_PAHOLE_HAS_SPLIT_BTF=y
> # CONFIG_GDB_SCRIPTS is not set
> CONFIG_FRAME_WARN=1024
> CONFIG_STRIP_ASM_SYMS=y
> CONFIG_READABLE_ASM=y
> # CONFIG_HEADERS_INSTALL is not set
> CONFIG_DEBUG_SECTION_MISMATCH=y
> CONFIG_SECTION_MISMATCH_WARN_ONLY=y
> CONFIG_VMLINUX_MAP=y
> CONFIG_DEBUG_FORCE_WEAK_PER_CPU=y
> # end of Compile-time checks and compiler options
> 
> #
> # Generic Kernel Debugging Instruments
> #
> # CONFIG_MAGIC_SYSRQ is not set
> CONFIG_DEBUG_FS=y
> # CONFIG_DEBUG_FS_ALLOW_ALL is not set
> CONFIG_DEBUG_FS_DISALLOW_MOUNT=y
> # CONFIG_DEBUG_FS_ALLOW_NONE is not set
> CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
> CONFIG_UBSAN=y
> CONFIG_CC_HAS_UBSAN_BOUNDS=y
> # CONFIG_UBSAN_BOUNDS is not set
> # CONFIG_UBSAN_SHIFT is not set
> # CONFIG_UBSAN_DIV_ZERO is not set
> # CONFIG_UBSAN_UNREACHABLE is not set
> CONFIG_UBSAN_BOOL=y
> # CONFIG_UBSAN_ENUM is not set
> CONFIG_UBSAN_SANITIZE_ALL=y
> CONFIG_TEST_UBSAN=m
> CONFIG_HAVE_KCSAN_COMPILER=y
> # end of Generic Kernel Debugging Instruments
> 
> #
> # Networking Debugging
> #
> # end of Networking Debugging
> 
> #
> # Memory Debugging
> #
> # CONFIG_PAGE_EXTENSION is not set
> # CONFIG_DEBUG_PAGEALLOC is not set
> # CONFIG_SLUB_DEBUG is not set
> # CONFIG_PAGE_OWNER is not set
> # CONFIG_PAGE_POISONING is not set
> # CONFIG_DEBUG_OBJECTS is not set
> CONFIG_SHRINKER_DEBUG=y
> CONFIG_HAVE_DEBUG_KMEMLEAK=y
> # CONFIG_DEBUG_KMEMLEAK is not set
> # CONFIG_DEBUG_STACK_USAGE is not set
> # CONFIG_SCHED_STACK_END_CHECK is not set
> CONFIG_DEBUG_VM_IRQSOFF=y
> CONFIG_DEBUG_VM=y
> CONFIG_DEBUG_VM_MAPLE_TREE=y
> CONFIG_DEBUG_VM_RB=y
> # CONFIG_DEBUG_VM_PGFLAGS is not set
> CONFIG_DEBUG_NOMMU_REGIONS=y
> CONFIG_DEBUG_MEMORY_INIT=y
> CONFIG_CC_HAS_KASAN_GENERIC=y
> CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
> # end of Memory Debugging
> 
> # CONFIG_DEBUG_SHIRQ is not set
> 
> #
> # Debug Oops, Lockups and Hangs
> #
> # CONFIG_PANIC_ON_OOPS is not set
> CONFIG_PANIC_ON_OOPS_VALUE=0
> CONFIG_PANIC_TIMEOUT=0
> CONFIG_LOCKUP_DETECTOR=y
> CONFIG_SOFTLOCKUP_DETECTOR=y
> CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=y
> # CONFIG_DETECT_HUNG_TASK is not set
> # CONFIG_WQ_WATCHDOG is not set
> CONFIG_TEST_LOCKUP=m
> # end of Debug Oops, Lockups and Hangs
> 
> #
> # Scheduler Debugging
> #
> # CONFIG_SCHED_DEBUG is not set
> CONFIG_SCHED_INFO=y
> CONFIG_SCHEDSTATS=y
> # end of Scheduler Debugging
> 
> CONFIG_DEBUG_TIMEKEEPING=y
> 
> #
> # Lock Debugging (spinlocks, mutexes, etc...)
> #
> CONFIG_DEBUG_RT_MUTEXES=y
> CONFIG_DEBUG_SPINLOCK=y
> CONFIG_DEBUG_MUTEXES=y
> CONFIG_DEBUG_RWSEMS=y
> # CONFIG_DEBUG_ATOMIC_SLEEP is not set
> CONFIG_DEBUG_LOCKING_API_SELFTESTS=y
> CONFIG_LOCK_TORTURE_TEST=y
> # CONFIG_WW_MUTEX_SELFTEST is not set
> CONFIG_SCF_TORTURE_TEST=m
> # end of Lock Debugging (spinlocks, mutexes, etc...)
> 
> CONFIG_DEBUG_IRQFLAGS=y
> CONFIG_STACKTRACE=y
> CONFIG_WARN_ALL_UNSEEDED_RANDOM=y
> # CONFIG_DEBUG_KOBJECT is not set
> 
> #
> # Debug kernel data structures
> #
> CONFIG_DEBUG_LIST=y
> CONFIG_DEBUG_PLIST=y
> CONFIG_DEBUG_SG=y
> # CONFIG_DEBUG_NOTIFIERS is not set
> CONFIG_BUG_ON_DATA_CORRUPTION=y
> CONFIG_DEBUG_MAPLE_TREE=y
> # end of Debug kernel data structures
> 
> # CONFIG_DEBUG_CREDENTIALS is not set
> 
> #
> # RCU Debugging
> #
> CONFIG_TORTURE_TEST=y
> CONFIG_RCU_SCALE_TEST=y
> CONFIG_RCU_TORTURE_TEST=m
> CONFIG_RCU_REF_SCALE_TEST=m
> CONFIG_RCU_TRACE=y
> # CONFIG_RCU_EQS_DEBUG is not set
> # end of RCU Debugging
> 
> CONFIG_DEBUG_WQ_FORCE_RR_CPU=y
> CONFIG_LATENCYTOP=y
> CONFIG_HAVE_FUNCTION_TRACER=y
> CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
> CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
> CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
> CONFIG_HAVE_C_RECORDMCOUNT=y
> CONFIG_HAVE_BUILDTIME_MCOUNT_SORT=y
> CONFIG_TRACE_CLOCK=y
> # CONFIG_SAMPLES is not set
> # CONFIG_STRICT_DEVMEM is not set
> 
> #
> # arm Debugging
> #
> CONFIG_UNWINDER_ARM=y
> CONFIG_ARM_UNWIND=y
> # CONFIG_BACKTRACE_VERBOSE is not set
> # CONFIG_DEBUG_USER is not set
> CONFIG_DEBUG_LL=y
> CONFIG_DEBUG_LPC18XX_UART0=y
> # CONFIG_STM32F4_DEBUG_UART is not set
> # CONFIG_STM32F7_DEBUG_UART is not set
> # CONFIG_STM32H7_DEBUG_UART is not set
> # CONFIG_DEBUG_ICEDCC is not set
> # CONFIG_DEBUG_SEMIHOSTING is not set
> # CONFIG_DEBUG_LL_UART_8250 is not set
> # CONFIG_DEBUG_LL_UART_PL01X is not set
> # CONFIG_DEBUG_UART_FLOW_CONTROL is not set
> CONFIG_DEBUG_LL_INCLUDE="debug/palmchip.S"
> CONFIG_DEBUG_UART_8250=y
> CONFIG_DEBUG_UART_PHYS=0x40081000
> CONFIG_DEBUG_UART_VIRT=0x40081000
> CONFIG_DEBUG_UART_8250_SHIFT=2
> CONFIG_DEBUG_UART_8250_WORD=y
> CONFIG_DEBUG_UART_8250_PALMCHIP=y
> # CONFIG_DEBUG_UNCOMPRESS is not set
> CONFIG_UNCOMPRESS_INCLUDE="debug/uncompress.h"
> # CONFIG_EARLY_PRINTK is not set
> CONFIG_CORESIGHT=y
> CONFIG_CORESIGHT_LINKS_AND_SINKS=y
> CONFIG_CORESIGHT_LINK_AND_SINK_TMC=y
> # CONFIG_CORESIGHT_CATU is not set
> CONFIG_CORESIGHT_SINK_TPIU=y
> CONFIG_CORESIGHT_SINK_ETBV10=m
> CONFIG_CORESIGHT_SOURCE_ETM3X=y
> CONFIG_CORESIGHT_STM=y
> CONFIG_CORESIGHT_CPU_DEBUG=y
> CONFIG_CORESIGHT_CPU_DEBUG_DEFAULT_ON=y
> CONFIG_CORESIGHT_CTI=y
> CONFIG_CORESIGHT_CTI_INTEGRATION_REGS=y
> # end of arm Debugging
> 
> #
> # Kernel Testing and Coverage
> #
> CONFIG_KUNIT=m
> # CONFIG_KUNIT_DEBUGFS is not set
> # CONFIG_KUNIT_TEST is not set
> # CONFIG_KUNIT_EXAMPLE_TEST is not set
> CONFIG_KUNIT_ALL_TESTS=m
> # CONFIG_KUNIT_DEFAULT_ENABLED is not set
> CONFIG_NOTIFIER_ERROR_INJECTION=y
> CONFIG_PM_NOTIFIER_ERROR_INJECT=y
> CONFIG_OF_RECONFIG_NOTIFIER_ERROR_INJECT=m
> # CONFIG_FAULT_INJECTION is not set
> CONFIG_ARCH_HAS_KCOV=y
> CONFIG_CC_HAS_SANCOV_TRACE_PC=y
> CONFIG_KCOV=y
> CONFIG_KCOV_ENABLE_COMPARISONS=y
> # CONFIG_KCOV_INSTRUMENT_ALL is not set
> CONFIG_KCOV_IRQ_AREA_SIZE=0x40000
> CONFIG_RUNTIME_TESTING_MENU=y
> CONFIG_LKDTM=m
> CONFIG_CPUMASK_KUNIT_TEST=m
> CONFIG_TEST_LIST_SORT=m
> CONFIG_TEST_MIN_HEAP=m
> # CONFIG_TEST_SORT is not set
> CONFIG_TEST_DIV64=y
> # CONFIG_BACKTRACE_SELF_TEST is not set
> # CONFIG_TEST_REF_TRACKER is not set
> # CONFIG_RBTREE_TEST is not set
> # CONFIG_REED_SOLOMON_TEST is not set
> CONFIG_INTERVAL_TREE_TEST=m
> # CONFIG_PERCPU_TEST is not set
> CONFIG_ATOMIC64_SELFTEST=y
> # CONFIG_TEST_HEXDUMP is not set
> CONFIG_STRING_SELFTEST=y
> CONFIG_TEST_STRING_HELPERS=m
> CONFIG_TEST_KSTRTOX=y
> CONFIG_TEST_PRINTF=m
> CONFIG_TEST_SCANF=y
> CONFIG_TEST_BITMAP=m
> CONFIG_TEST_UUID=y
> CONFIG_TEST_XARRAY=y
> # CONFIG_TEST_MAPLE_TREE is not set
> # CONFIG_TEST_RHASHTABLE is not set
> CONFIG_TEST_IDA=m
> CONFIG_TEST_LKM=m
> # CONFIG_TEST_BITOPS is not set
> CONFIG_TEST_USER_COPY=m
> # CONFIG_FIND_BIT_BENCHMARK is not set
> # CONFIG_TEST_FIRMWARE is not set
> CONFIG_TEST_SYSCTL=m
> CONFIG_BITFIELD_KUNIT=m
> CONFIG_HASH_KUNIT_TEST=m
> CONFIG_RESOURCE_KUNIT_TEST=m
> CONFIG_SYSCTL_KUNIT_TEST=m
> CONFIG_LIST_KUNIT_TEST=m
> CONFIG_LINEAR_RANGES_TEST=m
> CONFIG_CMDLINE_KUNIT_TEST=m
> CONFIG_BITS_TEST=m
> CONFIG_RATIONAL_KUNIT_TEST=m
> # CONFIG_MEMCPY_KUNIT_TEST is not set
> CONFIG_IS_SIGNED_TYPE_KUNIT_TEST=m
> CONFIG_OVERFLOW_KUNIT_TEST=m
> CONFIG_STACKINIT_KUNIT_TEST=m
> # CONFIG_FORTIFY_KUNIT_TEST is not set
> CONFIG_STRSCPY_KUNIT_TEST=m
> CONFIG_SIPHASH_KUNIT_TEST=m
> # CONFIG_TEST_UDELAY is not set
> CONFIG_TEST_STATIC_KEYS=m
> # CONFIG_TEST_MEMCAT_P is not set
> CONFIG_TEST_MEMINIT=y
> # CONFIG_TEST_FREE_PAGES is not set
> CONFIG_ARCH_USE_MEMTEST=y
> CONFIG_MEMTEST=y
> # end of Kernel Testing and Coverage
> 
> #
> # Rust hacking
> #
> # end of Rust hacking
> 
> # CONFIG_WARN_MISSING_DOCUMENTS is not set
> # CONFIG_WARN_ABI_ERRORS is not set
> # end of Kernel hacking

