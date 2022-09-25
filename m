Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD15F5E909D
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 03:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbiIYBLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 21:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbiIYBL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 21:11:28 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C823643A
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 18:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664068285; x=1695604285;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SvbqnyIDtBQ9Lomj/GO7qPeN1FQysSUNt3RQkepkeyM=;
  b=c0tIoUTMcO5ZAi+CUwYHO9HKUKy30jl4Z1vSujVNPTkLlN3/bVyFL5K4
   p9LJcaL9GfB4BdEXbVajRJxPY0+9exP/bFGzBAyJv6+2Dy9FDEs18eSwv
   NRIHzgzb0rJPZoeM3pgStl4mPvr8w/yUYQatlQxCZsmK1ey3qscVvnLvD
   nFyBVIXzpcsQ3xWRRlUp2+2LlHNccxhrGz95DivoVm5s7tgB0xKBO4AvT
   cwRL+h8kH2mxy3kxHD+KQk82riGy6+Uq+tSv1unkTayBMO2u9Xq07X8qs
   QJQ0Zd7ZyUEHpswNrBYODIr/3c04/HOqICYhKF5WVkfY1rsN676X6JOXu
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10480"; a="327157503"
X-IronPort-AV: E=Sophos;i="5.93,343,1654585200"; 
   d="scan'208";a="327157503"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2022 18:11:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,343,1654585200"; 
   d="scan'208";a="709714304"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Sep 2022 18:11:18 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ocGAw-0007Co-17;
        Sun, 25 Sep 2022 01:11:18 +0000
Date:   Sun, 25 Sep 2022 09:10:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Youling Tang <tangyouling@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     kbuild-all@lists.01.org, Ard Biesheuvel <ardb@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] LoongArch: Use generic BUG() handler
Message-ID: <202209250858.bchDxCiQ-lkp@intel.com>
References: <1663844890-10776-1-git-send-email-tangyouling@loongson.cn>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="/+SrRbyQb96/jwl+"
Content-Disposition: inline
In-Reply-To: <1663844890-10776-1-git-send-email-tangyouling@loongson.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        UPPERCASE_50_75 autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/+SrRbyQb96/jwl+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Youling,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.0-rc6 next-20220923]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Youling-Tang/LoongArch-Use-generic-BUG-handler/20220922-190855
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git dc164f4fb00a0abebdfff132f8bc7291a28f5401
config: loongarch-randconfig-m041-20220925
compiler: loongarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/233fbb60106526bdb7cb8496ff5d1c735b5c975e
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Youling-Tang/LoongArch-Use-generic-BUG-handler/20220922-190855
        git checkout 233fbb60106526bdb7cb8496ff5d1c735b5c975e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=loongarch SHELL=/bin/bash arch/loongarch/kernel/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   arch/loongarch/kernel/traps.c:213:6: warning: no previous prototype for 'show_registers' [-Wmissing-prototypes]
     213 | void show_registers(struct pt_regs *regs)
         |      ^~~~~~~~~~~~~~
   arch/loongarch/kernel/traps.c:276:6: warning: no previous prototype for 'force_fcsr_sig' [-Wmissing-prototypes]
     276 | void force_fcsr_sig(unsigned long fcsr, void __user *fault_addr,
         |      ^~~~~~~~~~~~~~
   arch/loongarch/kernel/traps.c:295:5: warning: no previous prototype for 'process_fpemu_return' [-Wmissing-prototypes]
     295 | int process_fpemu_return(int sig, void __user *fault_addr, unsigned long fcsr)
         |     ^~~~~~~~~~~~~~~~~~~~
   arch/loongarch/kernel/traps.c:330:25: warning: no previous prototype for 'do_fpe' [-Wmissing-prototypes]
     330 | asmlinkage void noinstr do_fpe(struct pt_regs *regs, unsigned long fcsr)
         |                         ^~~~~~
   arch/loongarch/kernel/traps.c:357:25: warning: no previous prototype for 'do_ade' [-Wmissing-prototypes]
     357 | asmlinkage void noinstr do_ade(struct pt_regs *regs)
         |                         ^~~~~~
   arch/loongarch/kernel/traps.c:367:25: warning: no previous prototype for 'do_ale' [-Wmissing-prototypes]
     367 | asmlinkage void noinstr do_ale(struct pt_regs *regs)
         |                         ^~~~~~
>> arch/loongarch/kernel/traps.c:379:5: warning: no previous prototype for 'is_valid_bugaddr' [-Wmissing-prototypes]
     379 | int is_valid_bugaddr(unsigned long addr)
         |     ^~~~~~~~~~~~~~~~
   arch/loongarch/kernel/traps.c:400:25: warning: no previous prototype for 'do_bp' [-Wmissing-prototypes]
     400 | asmlinkage void noinstr do_bp(struct pt_regs *regs)
         |                         ^~~~~
   arch/loongarch/kernel/traps.c:479:25: warning: no previous prototype for 'do_watch' [-Wmissing-prototypes]
     479 | asmlinkage void noinstr do_watch(struct pt_regs *regs)
         |                         ^~~~~~~~
   arch/loongarch/kernel/traps.c:484:25: warning: no previous prototype for 'do_ri' [-Wmissing-prototypes]
     484 | asmlinkage void noinstr do_ri(struct pt_regs *regs)
         |                         ^~~~~
   arch/loongarch/kernel/traps.c: In function 'do_ri':
   arch/loongarch/kernel/traps.c:487:22: warning: variable 'opcode' set but not used [-Wunused-but-set-variable]
     487 |         unsigned int opcode = 0;
         |                      ^~~~~~
   arch/loongarch/kernel/traps.c: At top level:
   arch/loongarch/kernel/traps.c:537:25: warning: no previous prototype for 'do_fpu' [-Wmissing-prototypes]
     537 | asmlinkage void noinstr do_fpu(struct pt_regs *regs)
         |                         ^~~~~~
   arch/loongarch/kernel/traps.c:552:25: warning: no previous prototype for 'do_lsx' [-Wmissing-prototypes]
     552 | asmlinkage void noinstr do_lsx(struct pt_regs *regs)
         |                         ^~~~~~
   arch/loongarch/kernel/traps.c:563:25: warning: no previous prototype for 'do_lasx' [-Wmissing-prototypes]
     563 | asmlinkage void noinstr do_lasx(struct pt_regs *regs)
         |                         ^~~~~~~
   arch/loongarch/kernel/traps.c:574:25: warning: no previous prototype for 'do_lbt' [-Wmissing-prototypes]
     574 | asmlinkage void noinstr do_lbt(struct pt_regs *regs)
         |                         ^~~~~~
   arch/loongarch/kernel/traps.c:585:25: warning: no previous prototype for 'do_reserved' [-Wmissing-prototypes]
     585 | asmlinkage void noinstr do_reserved(struct pt_regs *regs)
         |                         ^~~~~~~~~~~
   arch/loongarch/kernel/traps.c:604:17: warning: no previous prototype for 'cache_parity_error' [-Wmissing-prototypes]
     604 | asmlinkage void cache_parity_error(void)
         |                 ^~~~~~~~~~~~~~~~~~
   arch/loongarch/kernel/traps.c:613:25: warning: no previous prototype for 'handle_loongarch_irq' [-Wmissing-prototypes]
     613 | asmlinkage void noinstr handle_loongarch_irq(struct pt_regs *regs)
         |                         ^~~~~~~~~~~~~~~~~~~~
   arch/loongarch/kernel/traps.c:624:25: warning: no previous prototype for 'do_vint' [-Wmissing-prototypes]
     624 | asmlinkage void noinstr do_vint(struct pt_regs *regs, unsigned long sp)
         |                         ^~~~~~~


vim +/is_valid_bugaddr +379 arch/loongarch/kernel/traps.c

   378	
 > 379	int is_valid_bugaddr(unsigned long addr)
   380	{
   381		return 1;
   382	}
   383	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

--/+SrRbyQb96/jwl+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=config

#
# Automatically generated file; DO NOT EDIT.
# Linux/loongarch 6.0.0-rc6 Kernel Configuration
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
CONFIG_SYSVIPC=y
CONFIG_POSIX_MQUEUE=y
CONFIG_WATCH_QUEUE=y
# CONFIG_CROSS_MEMORY_ATTACH is not set
# CONFIG_USELIB is not set
CONFIG_AUDIT=y
CONFIG_HAVE_ARCH_AUDITSYSCALL=y
CONFIG_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
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
CONFIG_CONTEXT_TRACKING=y
CONFIG_CONTEXT_TRACKING_IDLE=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_HZ_PERIODIC=y
# CONFIG_NO_HZ_IDLE is not set
# CONFIG_NO_HZ_FULL is not set
CONFIG_CONTEXT_TRACKING_USER=y
# CONFIG_CONTEXT_TRACKING_USER_FORCE is not set
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
# end of Timers subsystem

CONFIG_BPF=y

#
# BPF subsystem
#
CONFIG_BPF_SYSCALL=y
# CONFIG_BPF_UNPRIV_DEFAULT_OFF is not set
# end of BPF subsystem

CONFIG_PREEMPT_VOLUNTARY_BUILD=y
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y

#
# CPU/Task time and stats accounting
#
CONFIG_VIRT_CPU_ACCOUNTING=y
# CONFIG_TICK_CPU_ACCOUNTING is not set
CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
# CONFIG_IRQ_TIME_ACCOUNTING is not set
CONFIG_PSI=y
# CONFIG_PSI_DEFAULT_DISABLED is not set
# end of CPU/Task time and stats accounting

# CONFIG_CPU_ISOLATION is not set

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
CONFIG_RCU_EXPERT=y
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_FORCE_TASKS_RCU=y
CONFIG_TASKS_RCU=y
CONFIG_FORCE_TASKS_RUDE_RCU=y
CONFIG_TASKS_RUDE_RCU=y
CONFIG_FORCE_TASKS_TRACE_RCU=y
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_FANOUT=64
CONFIG_RCU_FANOUT_LEAF=16
CONFIG_RCU_NOCB_CPU=y
CONFIG_RCU_NOCB_CPU_DEFAULT_ALL=y
CONFIG_TASKS_TRACE_RCU_READ_MB=y
# end of RCU Subsystem

CONFIG_IKCONFIG=y
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
# CONFIG_NUMA_BALANCING is not set
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
CONFIG_CGROUP_FAVOR_DYNMODS=y
CONFIG_MEMCG=y
# CONFIG_CGROUP_SCHED is not set
# CONFIG_CGROUP_PIDS is not set
# CONFIG_CGROUP_RDMA is not set
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_HUGETLB=y
CONFIG_CPUSETS=y
CONFIG_PROC_PID_CPUSET=y
# CONFIG_CGROUP_DEVICE is not set
# CONFIG_CGROUP_CPUACCT is not set
CONFIG_CGROUP_PERF=y
# CONFIG_CGROUP_BPF is not set
CONFIG_CGROUP_MISC=y
CONFIG_CGROUP_DEBUG=y
CONFIG_SOCK_CGROUP_DATA=y
# CONFIG_CHECKPOINT_RESTORE is not set
# CONFIG_SCHED_AUTOGROUP is not set
# CONFIG_SYSFS_DEPRECATED is not set
# CONFIG_RELAY is not set
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
# CONFIG_RD_XZ is not set
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
CONFIG_RD_ZSTD=y
CONFIG_BOOT_CONFIG=y
# CONFIG_BOOT_CONFIG_EMBED is not set
# CONFIG_INITRAMFS_PRESERVE_MTIME is not set
# CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE is not set
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
CONFIG_LD_ORPHAN_WARN=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_EXPERT=y
# CONFIG_MULTIUSER is not set
# CONFIG_SGETMASK_SYSCALL is not set
# CONFIG_SYSFS_SYSCALL is not set
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
# CONFIG_PRINTK is not set
# CONFIG_BUG is not set
CONFIG_ELF_CORE=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_IO_URING=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
# CONFIG_KCMP is not set
CONFIG_RSEQ=y
# CONFIG_DEBUG_RSEQ is not set
CONFIG_EMBEDDED=y
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_PERF_USE_VMALLOC=y
# CONFIG_PC104 is not set

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

CONFIG_PROFILING=y
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
CONFIG_PGTABLE_3LEVEL=y
CONFIG_PGTABLE_LEVELS=3
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
# CONFIG_16KB_2LEVEL is not set
CONFIG_16KB_3LEVEL=y
# CONFIG_64KB_2LEVEL is not set
# CONFIG_64KB_3LEVEL is not set
CONFIG_CMDLINE=""
CONFIG_CMDLINE_BOOTLOADER=y
# CONFIG_CMDLINE_EXTEND is not set
# CONFIG_CMDLINE_FORCE is not set
CONFIG_DMI=y
CONFIG_EFI=y
CONFIG_SMP=y
# CONFIG_HOTPLUG_CPU is not set
CONFIG_NR_CPUS=64
CONFIG_NUMA=y
CONFIG_NODES_SHIFT=6
CONFIG_FORCE_MAX_ZONEORDER=12
# CONFIG_SECCOMP is not set
# end of Kernel type and options

CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
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
CONFIG_ACPI_DEBUGGER=y
CONFIG_ACPI_DEBUGGER_USER=y
CONFIG_ACPI_SPCR_TABLE=y
CONFIG_ACPI_EC_DEBUGFS=y
# CONFIG_ACPI_AC is not set
# CONFIG_ACPI_BATTERY is not set
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=y
# CONFIG_ACPI_FAN is not set
# CONFIG_ACPI_DOCK is not set
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_MCFG=y
CONFIG_ACPI_PROCESSOR=y
# CONFIG_ACPI_THERMAL is not set
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_DEBUG=y
# CONFIG_ACPI_PCI_SLOT is not set
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HED=y
CONFIG_ACPI_CUSTOM_METHOD=y
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
CONFIG_ACPI_NUMA=y
# CONFIG_ACPI_HMAT is not set
CONFIG_ACPI_WATCHDOG=y
CONFIG_ACPI_CONFIGFS=y
CONFIG_ACPI_PFRUT=y
CONFIG_PMIC_OPREGION=y
# end of Power management options

#
# Firmware Drivers
#

#
# ARM System Control and Management Interface Protocol
#
# CONFIG_ARM_SCMI_PROTOCOL is not set
CONFIG_ARM_SCMI_POWER_DOMAIN=y
# CONFIG_ARM_SCMI_POWER_CONTROL is not set
# end of ARM System Control and Management Interface Protocol

# CONFIG_ARM_SCPI_PROTOCOL is not set
CONFIG_ARM_SCPI_POWER_DOMAIN=y
# CONFIG_FIRMWARE_MEMMAP is not set
CONFIG_DMIID=y
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
CONFIG_SYSFB=y
# CONFIG_SYSFB_SIMPLEFB is not set
# CONFIG_TURRIS_MOX_RWTM is not set
# CONFIG_BCM47XX_NVRAM is not set
CONFIG_GOOGLE_FIRMWARE=y
# CONFIG_GOOGLE_COREBOOT_TABLE is not set

#
# EFI (Extensible Firmware Interface) Support
#
CONFIG_EFI_ESRT=y
CONFIG_EFI_PARAMS_FROM_FDT=y
CONFIG_EFI_RUNTIME_WRAPPERS=y
# CONFIG_EFI_BOOTLOADER_CONTROL is not set
CONFIG_EFI_CAPSULE_LOADER=y
# CONFIG_EFI_TEST is not set
# CONFIG_EFI_RCI2_TABLE is not set
CONFIG_EFI_DISABLE_PCI_DMA=y
# CONFIG_EFI_CUSTOM_SSDT_OVERLAYS is not set
# CONFIG_EFI_DISABLE_RUNTIME is not set
# CONFIG_EFI_COCO_SECRET is not set
# end of EFI (Extensible Firmware Interface) Support

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

#
# General architecture-dependent options
#
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
CONFIG_HAVE_CONTEXT_TRACKING_USER=y
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
CONFIG_LOCK_EVENT_COUNTS=y
CONFIG_ARCH_WANT_LD_ORPHAN_WARN=y

#
# GCOV-based kernel profiling
#
CONFIG_GCOV_KERNEL=y
# end of GCOV-based kernel profiling
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
# CONFIG_MODULES is not set
# CONFIG_BLOCK is not set
CONFIG_ASN1=y
CONFIG_ARCH_INLINE_SPIN_TRYLOCK=y
CONFIG_ARCH_INLINE_SPIN_TRYLOCK_BH=y
CONFIG_ARCH_INLINE_SPIN_LOCK=y
CONFIG_ARCH_INLINE_SPIN_LOCK_BH=y
CONFIG_ARCH_INLINE_SPIN_LOCK_IRQ=y
CONFIG_ARCH_INLINE_SPIN_LOCK_IRQSAVE=y
CONFIG_ARCH_INLINE_SPIN_UNLOCK=y
CONFIG_ARCH_INLINE_SPIN_UNLOCK_BH=y
CONFIG_ARCH_INLINE_SPIN_UNLOCK_IRQ=y
CONFIG_ARCH_INLINE_SPIN_UNLOCK_IRQRESTORE=y
CONFIG_ARCH_INLINE_READ_LOCK=y
CONFIG_ARCH_INLINE_READ_LOCK_BH=y
CONFIG_ARCH_INLINE_READ_LOCK_IRQ=y
CONFIG_ARCH_INLINE_READ_LOCK_IRQSAVE=y
CONFIG_ARCH_INLINE_READ_UNLOCK=y
CONFIG_ARCH_INLINE_READ_UNLOCK_BH=y
CONFIG_ARCH_INLINE_READ_UNLOCK_IRQ=y
CONFIG_ARCH_INLINE_READ_UNLOCK_IRQRESTORE=y
CONFIG_ARCH_INLINE_WRITE_LOCK=y
CONFIG_ARCH_INLINE_WRITE_LOCK_BH=y
CONFIG_ARCH_INLINE_WRITE_LOCK_IRQ=y
CONFIG_ARCH_INLINE_WRITE_LOCK_IRQSAVE=y
CONFIG_ARCH_INLINE_WRITE_UNLOCK=y
CONFIG_ARCH_INLINE_WRITE_UNLOCK_BH=y
CONFIG_ARCH_INLINE_WRITE_UNLOCK_IRQ=y
CONFIG_ARCH_INLINE_WRITE_UNLOCK_IRQRESTORE=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y
CONFIG_FREEZER=y

#
# Executable file formats
#
# CONFIG_BINFMT_ELF is not set
CONFIG_ARCH_BINFMT_ELF_STATE=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=y
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#

#
# SLAB allocator options
#
# CONFIG_SLAB is not set
# CONFIG_SLUB is not set
CONFIG_SLOB=y
# end of SLAB allocator options

# CONFIG_SHUFFLE_PAGE_ALLOCATOR is not set
# CONFIG_COMPAT_BRK is not set
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_ARCH_KEEP_MEMBLOCK=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
# CONFIG_MEMORY_HOTPLUG is not set
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_COMPACTION=y
CONFIG_PAGE_REPORTING=y
CONFIG_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
# CONFIG_TRANSPARENT_HUGEPAGE is not set
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_CMA=y
CONFIG_CMA_DEBUG=y
CONFIG_CMA_DEBUGFS=y
# CONFIG_CMA_SYSFS is not set
CONFIG_CMA_AREAS=19
# CONFIG_DEFERRED_STRUCT_PAGE_INIT is not set
# CONFIG_IDLE_PAGE_TRACKING is not set
CONFIG_ZONE_DMA32=y
CONFIG_GET_FREE_REGION=y
# CONFIG_VM_EVENT_COUNTERS is not set
# CONFIG_PERCPU_STATS is not set
CONFIG_GUP_TEST=y
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_USERFAULTFD=y

#
# Data Access Monitoring
#
# CONFIG_DAMON is not set
# end of Data Access Monitoring
# end of Memory Management options

CONFIG_NET=y
CONFIG_NET_INGRESS=y
CONFIG_SKB_EXTENSIONS=y

#
# Networking options
#
# CONFIG_PACKET is not set
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
CONFIG_AF_UNIX_OOB=y
# CONFIG_UNIX_DIAG is not set
CONFIG_TLS=y
# CONFIG_TLS_DEVICE is not set
# CONFIG_TLS_TOE is not set
CONFIG_XFRM=y
CONFIG_XFRM_ALGO=y
CONFIG_XFRM_USER=y
CONFIG_XFRM_INTERFACE=y
CONFIG_XFRM_SUB_POLICY=y
# CONFIG_XFRM_MIGRATE is not set
CONFIG_XFRM_AH=y
CONFIG_XFRM_ESP=y
# CONFIG_NET_KEY is not set
CONFIG_XFRM_ESPINTCP=y
# CONFIG_XDP_SOCKETS is not set
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
CONFIG_IP_PNP_BOOTP=y
# CONFIG_IP_PNP_RARP is not set
CONFIG_NET_IPIP=y
# CONFIG_NET_IPGRE_DEMUX is not set
CONFIG_NET_IP_TUNNEL=y
CONFIG_IP_MROUTE_COMMON=y
# CONFIG_SYN_COOKIES is not set
CONFIG_NET_IPVTI=y
CONFIG_NET_UDP_TUNNEL=y
CONFIG_NET_FOU=y
# CONFIG_NET_FOU_IP_TUNNELS is not set
CONFIG_INET_AH=y
CONFIG_INET_ESP=y
# CONFIG_INET_ESP_OFFLOAD is not set
CONFIG_INET_ESPINTCP=y
# CONFIG_INET_IPCOMP is not set
CONFIG_INET_TUNNEL=y
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
CONFIG_INET_UDP_DIAG=y
CONFIG_INET_RAW_DIAG=y
# CONFIG_INET_DIAG_DESTROY is not set
CONFIG_TCP_CONG_ADVANCED=y
CONFIG_TCP_CONG_BIC=y
CONFIG_TCP_CONG_CUBIC=y
CONFIG_TCP_CONG_WESTWOOD=y
CONFIG_TCP_CONG_HTCP=y
CONFIG_TCP_CONG_HSTCP=y
CONFIG_TCP_CONG_HYBLA=y
CONFIG_TCP_CONG_VEGAS=y
# CONFIG_TCP_CONG_NV is not set
CONFIG_TCP_CONG_SCALABLE=y
# CONFIG_TCP_CONG_LP is not set
CONFIG_TCP_CONG_VENO=y
CONFIG_TCP_CONG_YEAH=y
CONFIG_TCP_CONG_ILLINOIS=y
# CONFIG_TCP_CONG_DCTCP is not set
# CONFIG_TCP_CONG_CDG is not set
CONFIG_TCP_CONG_BBR=y
# CONFIG_DEFAULT_BIC is not set
# CONFIG_DEFAULT_CUBIC is not set
# CONFIG_DEFAULT_HTCP is not set
# CONFIG_DEFAULT_HYBLA is not set
# CONFIG_DEFAULT_VEGAS is not set
# CONFIG_DEFAULT_VENO is not set
# CONFIG_DEFAULT_WESTWOOD is not set
# CONFIG_DEFAULT_BBR is not set
CONFIG_DEFAULT_RENO=y
CONFIG_DEFAULT_TCP_CONG="reno"
# CONFIG_TCP_MD5SIG is not set
CONFIG_IPV6=y
CONFIG_IPV6_ROUTER_PREF=y
# CONFIG_IPV6_ROUTE_INFO is not set
CONFIG_IPV6_OPTIMISTIC_DAD=y
CONFIG_INET6_AH=y
CONFIG_INET6_ESP=y
# CONFIG_INET6_ESP_OFFLOAD is not set
# CONFIG_INET6_ESPINTCP is not set
# CONFIG_INET6_IPCOMP is not set
CONFIG_IPV6_MIP6=y
# CONFIG_IPV6_ILA is not set
CONFIG_INET6_TUNNEL=y
CONFIG_IPV6_VTI=y
CONFIG_IPV6_SIT=y
CONFIG_IPV6_SIT_6RD=y
CONFIG_IPV6_NDISC_NODETYPE=y
CONFIG_IPV6_TUNNEL=y
CONFIG_IPV6_FOU=y
# CONFIG_IPV6_MULTIPLE_TABLES is not set
CONFIG_IPV6_MROUTE=y
CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
CONFIG_IPV6_PIMSM_V2=y
# CONFIG_IPV6_SEG6_LWTUNNEL is not set
# CONFIG_IPV6_SEG6_HMAC is not set
CONFIG_IPV6_RPL_LWTUNNEL=y
CONFIG_IPV6_IOAM6_LWTUNNEL=y
CONFIG_MPTCP=y
CONFIG_INET_MPTCP_DIAG=y
# CONFIG_MPTCP_IPV6 is not set
CONFIG_NETWORK_SECMARK=y
CONFIG_NET_PTP_CLASSIFY=y
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_ADVANCED is not set

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_INGRESS=y
# CONFIG_NETFILTER_EGRESS is not set
CONFIG_NETFILTER_NETLINK=y
CONFIG_NETFILTER_FAMILY_BRIDGE=y
CONFIG_NETFILTER_NETLINK_LOG=y
CONFIG_NF_CONNTRACK=y
CONFIG_NF_LOG_SYSLOG=y
# CONFIG_NF_CONNTRACK_SECMARK is not set
CONFIG_NF_CONNTRACK_LABELS=y
CONFIG_NF_CONNTRACK_FTP=y
CONFIG_NF_CONNTRACK_IRC=y
CONFIG_NF_CONNTRACK_BROADCAST=y
CONFIG_NF_CONNTRACK_NETBIOS_NS=y
CONFIG_NF_CONNTRACK_SIP=y
CONFIG_NF_CT_NETLINK=y
# CONFIG_NETFILTER_NETLINK_GLUE_CT is not set
CONFIG_NF_NAT=y
CONFIG_NF_NAT_FTP=y
CONFIG_NF_NAT_IRC=y
CONFIG_NF_NAT_SIP=y
CONFIG_NF_NAT_REDIRECT=y
CONFIG_NF_NAT_MASQUERADE=y
CONFIG_NF_TABLES=y
CONFIG_NF_TABLES_INET=y
CONFIG_NF_TABLES_NETDEV=y
CONFIG_NFT_NUMGEN=y
CONFIG_NFT_CT=y
CONFIG_NFT_FLOW_OFFLOAD=y
# CONFIG_NFT_LOG is not set
CONFIG_NFT_LIMIT=y
CONFIG_NFT_MASQ=y
CONFIG_NFT_REDIR=y
CONFIG_NFT_NAT=y
# CONFIG_NFT_TUNNEL is not set
CONFIG_NFT_OBJREF=y
# CONFIG_NFT_QUOTA is not set
# CONFIG_NFT_REJECT is not set
CONFIG_NFT_COMPAT=y
CONFIG_NFT_HASH=y
CONFIG_NFT_FIB=y
CONFIG_NFT_FIB_INET=y
CONFIG_NFT_XFRM=y
# CONFIG_NFT_SOCKET is not set
CONFIG_NFT_TPROXY=y
CONFIG_NF_DUP_NETDEV=y
CONFIG_NFT_DUP_NETDEV=y
CONFIG_NFT_FWD_NETDEV=y
CONFIG_NFT_FIB_NETDEV=y
# CONFIG_NF_FLOW_TABLE_INET is not set
CONFIG_NF_FLOW_TABLE=y
CONFIG_NETFILTER_XTABLES=y

#
# Xtables combined modules
#
CONFIG_NETFILTER_XT_MARK=y

#
# Xtables targets
#
# CONFIG_NETFILTER_XT_TARGET_LOG is not set
CONFIG_NETFILTER_XT_NAT=y
# CONFIG_NETFILTER_XT_TARGET_NETMAP is not set
CONFIG_NETFILTER_XT_TARGET_NFLOG=y
# CONFIG_NETFILTER_XT_TARGET_REDIRECT is not set
CONFIG_NETFILTER_XT_TARGET_MASQUERADE=y
CONFIG_NETFILTER_XT_TARGET_SECMARK=y
CONFIG_NETFILTER_XT_TARGET_TCPMSS=y

#
# Xtables matches
#
CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=y
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=y
CONFIG_NETFILTER_XT_MATCH_POLICY=y
CONFIG_NETFILTER_XT_MATCH_STATE=y
# end of Core Netfilter Configuration

CONFIG_IP_SET=y
CONFIG_IP_SET_MAX=256
CONFIG_IP_SET_BITMAP_IP=y
# CONFIG_IP_SET_BITMAP_IPMAC is not set
# CONFIG_IP_SET_BITMAP_PORT is not set
# CONFIG_IP_SET_HASH_IP is not set
CONFIG_IP_SET_HASH_IPMARK=y
CONFIG_IP_SET_HASH_IPPORT=y
CONFIG_IP_SET_HASH_IPPORTIP=y
CONFIG_IP_SET_HASH_IPPORTNET=y
CONFIG_IP_SET_HASH_IPMAC=y
CONFIG_IP_SET_HASH_MAC=y
# CONFIG_IP_SET_HASH_NETPORTNET is not set
CONFIG_IP_SET_HASH_NET=y
CONFIG_IP_SET_HASH_NETNET=y
CONFIG_IP_SET_HASH_NETPORT=y
CONFIG_IP_SET_HASH_NETIFACE=y
CONFIG_IP_SET_LIST_SET=y
CONFIG_IP_VS=y
# CONFIG_IP_VS_IPV6 is not set
# CONFIG_IP_VS_DEBUG is not set
CONFIG_IP_VS_TAB_BITS=12

#
# IPVS transport protocol load balancing support
#
# CONFIG_IP_VS_PROTO_TCP is not set
CONFIG_IP_VS_PROTO_UDP=y
CONFIG_IP_VS_PROTO_AH_ESP=y
# CONFIG_IP_VS_PROTO_ESP is not set
CONFIG_IP_VS_PROTO_AH=y
# CONFIG_IP_VS_PROTO_SCTP is not set

#
# IPVS scheduler
#
CONFIG_IP_VS_RR=y
CONFIG_IP_VS_WRR=y
# CONFIG_IP_VS_LC is not set
# CONFIG_IP_VS_WLC is not set
# CONFIG_IP_VS_FO is not set
CONFIG_IP_VS_OVF=y
CONFIG_IP_VS_LBLC=y
CONFIG_IP_VS_LBLCR=y
# CONFIG_IP_VS_DH is not set
# CONFIG_IP_VS_SH is not set
CONFIG_IP_VS_MH=y
# CONFIG_IP_VS_SED is not set
CONFIG_IP_VS_NQ=y
CONFIG_IP_VS_TWOS=y

#
# IPVS SH scheduler
#
CONFIG_IP_VS_SH_TAB_BITS=8

#
# IPVS MH scheduler
#
CONFIG_IP_VS_MH_TAB_INDEX=12

#
# IPVS application helper
#
# CONFIG_IP_VS_NFCT is not set
CONFIG_IP_VS_PE_SIP=y

#
# IP: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV4=y
CONFIG_NF_SOCKET_IPV4=y
CONFIG_NF_TPROXY_IPV4=y
CONFIG_NF_TABLES_IPV4=y
CONFIG_NFT_DUP_IPV4=y
CONFIG_NFT_FIB_IPV4=y
# CONFIG_NF_TABLES_ARP is not set
CONFIG_NF_DUP_IPV4=y
CONFIG_NF_LOG_ARP=y
CONFIG_NF_LOG_IPV4=y
# CONFIG_NF_REJECT_IPV4 is not set
# CONFIG_IP_NF_IPTABLES is not set
# end of IP: Netfilter Configuration

#
# IPv6: Netfilter Configuration
#
CONFIG_NF_SOCKET_IPV6=y
CONFIG_NF_TPROXY_IPV6=y
CONFIG_NF_TABLES_IPV6=y
CONFIG_NFT_DUP_IPV6=y
CONFIG_NFT_FIB_IPV6=y
CONFIG_NF_DUP_IPV6=y
CONFIG_NF_REJECT_IPV6=y
CONFIG_NF_LOG_IPV6=y
CONFIG_IP6_NF_IPTABLES=y
CONFIG_IP6_NF_MATCH_IPV6HEADER=y
# CONFIG_IP6_NF_FILTER is not set
# CONFIG_IP6_NF_MANGLE is not set
CONFIG_IP6_NF_RAW=y
# end of IPv6: Netfilter Configuration

CONFIG_NF_DEFRAG_IPV6=y
CONFIG_NF_TABLES_BRIDGE=y
# CONFIG_NFT_BRIDGE_META is not set
# CONFIG_NF_CONNTRACK_BRIDGE is not set
# CONFIG_BRIDGE_NF_EBTABLES is not set
# CONFIG_BPFILTER is not set
# CONFIG_IP_DCCP is not set
CONFIG_IP_SCTP=y
CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5=y
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1 is not set
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
CONFIG_SCTP_COOKIE_HMAC_MD5=y
# CONFIG_SCTP_COOKIE_HMAC_SHA1 is not set
CONFIG_INET_SCTP_DIAG=y
# CONFIG_RDS is not set
CONFIG_TIPC=y
# CONFIG_TIPC_MEDIA_UDP is not set
CONFIG_TIPC_CRYPTO=y
CONFIG_TIPC_DIAG=y
CONFIG_ATM=y
# CONFIG_ATM_CLIP is not set
CONFIG_ATM_LANE=y
CONFIG_ATM_MPOA=y
CONFIG_ATM_BR2684=y
CONFIG_ATM_BR2684_IPFILTER=y
CONFIG_L2TP=y
# CONFIG_L2TP_DEBUGFS is not set
# CONFIG_L2TP_V3 is not set
CONFIG_STP=y
CONFIG_BRIDGE=y
CONFIG_BRIDGE_IGMP_SNOOPING=y
CONFIG_BRIDGE_VLAN_FILTERING=y
CONFIG_BRIDGE_MRP=y
# CONFIG_BRIDGE_CFM is not set
# CONFIG_NET_DSA is not set
CONFIG_VLAN_8021Q=y
# CONFIG_VLAN_8021Q_GVRP is not set
# CONFIG_VLAN_8021Q_MVRP is not set
# CONFIG_DECNET is not set
CONFIG_LLC=y
# CONFIG_LLC2 is not set
CONFIG_ATALK=y
# CONFIG_DEV_APPLETALK is not set
CONFIG_X25=y
CONFIG_LAPB=y
# CONFIG_PHONET is not set
CONFIG_6LOWPAN=y
CONFIG_6LOWPAN_DEBUGFS=y
CONFIG_6LOWPAN_NHC=y
# CONFIG_6LOWPAN_NHC_DEST is not set
CONFIG_6LOWPAN_NHC_FRAGMENT=y
CONFIG_6LOWPAN_NHC_HOP=y
# CONFIG_6LOWPAN_NHC_IPV6 is not set
CONFIG_6LOWPAN_NHC_MOBILITY=y
# CONFIG_6LOWPAN_NHC_ROUTING is not set
# CONFIG_6LOWPAN_NHC_UDP is not set
CONFIG_6LOWPAN_GHC_EXT_HDR_HOP=y
# CONFIG_6LOWPAN_GHC_UDP is not set
# CONFIG_6LOWPAN_GHC_ICMPV6 is not set
CONFIG_6LOWPAN_GHC_EXT_HDR_DEST=y
CONFIG_6LOWPAN_GHC_EXT_HDR_FRAG=y
# CONFIG_6LOWPAN_GHC_EXT_HDR_ROUTE is not set
CONFIG_IEEE802154=y
CONFIG_IEEE802154_NL802154_EXPERIMENTAL=y
# CONFIG_IEEE802154_SOCKET is not set
CONFIG_IEEE802154_6LOWPAN=y
CONFIG_MAC802154=y
# CONFIG_NET_SCHED is not set
CONFIG_DCB=y
CONFIG_DNS_RESOLVER=y
CONFIG_BATMAN_ADV=y
# CONFIG_BATMAN_ADV_BATMAN_V is not set
# CONFIG_BATMAN_ADV_BLA is not set
# CONFIG_BATMAN_ADV_DAT is not set
CONFIG_BATMAN_ADV_NC=y
CONFIG_BATMAN_ADV_MCAST=y
# CONFIG_BATMAN_ADV_DEBUG is not set
CONFIG_BATMAN_ADV_TRACING=y
CONFIG_OPENVSWITCH=y
# CONFIG_VSOCKETS is not set
CONFIG_NETLINK_DIAG=y
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=y
CONFIG_NET_NSH=y
CONFIG_HSR=y
CONFIG_NET_SWITCHDEV=y
CONFIG_NET_L3_MASTER_DEV=y
CONFIG_QRTR=y
CONFIG_QRTR_SMD=y
# CONFIG_QRTR_TUN is not set
# CONFIG_QRTR_MHI is not set
CONFIG_NET_NCSI=y
CONFIG_NCSI_OEM_CMD_GET_MAC=y
CONFIG_NCSI_OEM_CMD_KEEP_PHY=y
# CONFIG_PCPU_DEV_REFCNT is not set
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_SOCK_RX_QUEUE_MAPPING=y
CONFIG_XPS=y
CONFIG_CGROUP_NET_PRIO=y
# CONFIG_CGROUP_NET_CLASSID is not set
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
CONFIG_NET_DROP_MONITOR=y
# end of Network testing
# end of Networking options

CONFIG_HAMRADIO=y

#
# Packet Radio protocols
#
CONFIG_AX25=y
# CONFIG_AX25_DAMA_SLAVE is not set
# CONFIG_NETROM is not set
CONFIG_ROSE=y

#
# AX.25 network device drivers
#
# CONFIG_BPQETHER is not set
CONFIG_BAYCOM_SER_FDX=y
# CONFIG_BAYCOM_SER_HDX is not set
CONFIG_YAM=y
# end of AX.25 network device drivers

CONFIG_CAN=y
CONFIG_CAN_RAW=y
CONFIG_CAN_BCM=y
# CONFIG_CAN_GW is not set
# CONFIG_CAN_J1939 is not set
CONFIG_CAN_ISOTP=y
CONFIG_BT=y
# CONFIG_BT_BREDR is not set
CONFIG_BT_LE=y
CONFIG_BT_6LOWPAN=y
# CONFIG_BT_LEDS is not set
CONFIG_BT_MSFTEXT=y
CONFIG_BT_AOSPEXT=y
# CONFIG_BT_DEBUGFS is not set
# CONFIG_BT_SELFTEST is not set
CONFIG_BT_FEATURE_DEBUG=y

#
# Bluetooth device drivers
#
CONFIG_BT_INTEL=y
CONFIG_BT_RTL=y
CONFIG_BT_HCIBTUSB=y
# CONFIG_BT_HCIBTUSB_AUTOSUSPEND is not set
# CONFIG_BT_HCIBTUSB_BCM is not set
# CONFIG_BT_HCIBTUSB_MTK is not set
CONFIG_BT_HCIBTUSB_RTL=y
# CONFIG_BT_HCIBCM203X is not set
# CONFIG_BT_HCIBPA10X is not set
# CONFIG_BT_HCIBFUSB is not set
CONFIG_BT_HCIDTL1=y
CONFIG_BT_HCIBT3C=y
CONFIG_BT_HCIBLUECARD=y
# CONFIG_BT_HCIVHCI is not set
CONFIG_BT_MRVL=y
# CONFIG_BT_ATH3K is not set
# CONFIG_BT_QCOMSMD is not set
CONFIG_BT_VIRTIO=y
# end of Bluetooth device drivers

CONFIG_AF_RXRPC=y
# CONFIG_AF_RXRPC_IPV6 is not set
# CONFIG_AF_RXRPC_INJECT_LOSS is not set
# CONFIG_AF_RXRPC_DEBUG is not set
# CONFIG_RXKAD is not set
CONFIG_AF_KCM=y
CONFIG_STREAM_PARSER=y
CONFIG_MCTP=y
CONFIG_MCTP_FLOWS=y
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
# CONFIG_CFG80211 is not set

#
# CFG80211 needs to be enabled for MAC80211
#
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
CONFIG_RFKILL=y
CONFIG_RFKILL_LEDS=y
# CONFIG_RFKILL_INPUT is not set
# CONFIG_RFKILL_GPIO is not set
# CONFIG_NET_9P is not set
CONFIG_CAIF=y
# CONFIG_CAIF_DEBUG is not set
CONFIG_CAIF_NETDEV=y
CONFIG_CAIF_USB=y
CONFIG_CEPH_LIB=y
# CONFIG_CEPH_LIB_PRETTYDEBUG is not set
CONFIG_CEPH_LIB_USE_DNS_RESOLVER=y
CONFIG_NFC=y
# CONFIG_NFC_DIGITAL is not set
CONFIG_NFC_NCI=y
# CONFIG_NFC_NCI_SPI is not set
CONFIG_NFC_HCI=y
CONFIG_NFC_SHDLC=y

#
# Near Field Communication (NFC) devices
#
# CONFIG_NFC_VIRTUAL_NCI is not set
CONFIG_NFC_FDP=y
CONFIG_NFC_FDP_I2C=y
# CONFIG_NFC_PN544_I2C is not set
CONFIG_NFC_PN533=y
CONFIG_NFC_PN533_USB=y
CONFIG_NFC_PN533_I2C=y
# CONFIG_NFC_MICROREAD_I2C is not set
CONFIG_NFC_MRVL=y
CONFIG_NFC_MRVL_USB=y
CONFIG_NFC_MRVL_I2C=y
# CONFIG_NFC_ST21NFCA_I2C is not set
CONFIG_NFC_ST_NCI=y
CONFIG_NFC_ST_NCI_I2C=y
CONFIG_NFC_ST_NCI_SPI=y
CONFIG_NFC_NXP_NCI=y
CONFIG_NFC_NXP_NCI_I2C=y
CONFIG_NFC_S3FWRN5=y
CONFIG_NFC_S3FWRN5_I2C=y
# end of Near Field Communication (NFC) devices

CONFIG_PSAMPLE=y
# CONFIG_NET_IFE is not set
CONFIG_LWTUNNEL=y
# CONFIG_LWTUNNEL_BPF is not set
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_NET_SELFTESTS=y
CONFIG_NET_SOCK_MSG=y
CONFIG_NET_DEVLINK=y
CONFIG_PAGE_POOL=y
CONFIG_PAGE_POOL_STATS=y
CONFIG_FAILOVER=y
CONFIG_ETHTOOL_NETLINK=y

#
# Device Drivers
#
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCI_DOMAINS_GENERIC=y
CONFIG_PCIEPORTBUS=y
# CONFIG_HOTPLUG_PCI_PCIE is not set
CONFIG_PCIEAER=y
# CONFIG_PCIEAER_INJECT is not set
CONFIG_PCIE_ECRC=y
# CONFIG_PCIEASPM is not set
# CONFIG_PCIE_DPC is not set
# CONFIG_PCIE_PTM is not set
CONFIG_PCI_MSI=y
CONFIG_PCI_MSI_IRQ_DOMAIN=y
CONFIG_PCI_MSI_ARCH_FALLBACKS=y
CONFIG_PCI_QUIRKS=y
CONFIG_PCI_DEBUG=y
CONFIG_PCI_REALLOC_ENABLE_AUTO=y
CONFIG_PCI_STUB=y
CONFIG_PCI_PF_STUB=y
CONFIG_PCI_ATS=y
CONFIG_PCI_DOE=y
CONFIG_PCI_ECAM=y
CONFIG_PCI_IOV=y
# CONFIG_PCI_PRI is not set
CONFIG_PCI_PASID=y
CONFIG_PCI_LABEL=y
# CONFIG_PCIE_BUS_TUNE_OFF is not set
# CONFIG_PCIE_BUS_DEFAULT is not set
# CONFIG_PCIE_BUS_SAFE is not set
CONFIG_PCIE_BUS_PERFORMANCE=y
# CONFIG_PCIE_BUS_PEER2PEER is not set
# CONFIG_VGA_ARB is not set
CONFIG_HOTPLUG_PCI=y
# CONFIG_HOTPLUG_PCI_ACPI is not set
# CONFIG_HOTPLUG_PCI_CPCI is not set
CONFIG_HOTPLUG_PCI_SHPC=y

#
# PCI controller drivers
#
# CONFIG_PCI_AARDVARK is not set
# CONFIG_PCIE_XILINX_NWL is not set
# CONFIG_PCI_FTPCI100 is not set
# CONFIG_PCI_TEGRA is not set
# CONFIG_PCIE_RCAR_HOST is not set
# CONFIG_PCIE_RCAR_EP is not set
# CONFIG_PCI_HOST_GENERIC is not set
# CONFIG_PCIE_XILINX is not set
# CONFIG_PCIE_XILINX_CPM is not set
# CONFIG_PCI_XGENE is not set
# CONFIG_PCI_V3_SEMI is not set
# CONFIG_PCI_VERSATILE is not set
# CONFIG_PCIE_ALTERA is not set
# CONFIG_PCI_HOST_THUNDER_PEM is not set
# CONFIG_PCI_HOST_THUNDER_ECAM is not set
# CONFIG_PCIE_ROCKCHIP_HOST is not set
# CONFIG_PCIE_ROCKCHIP_EP is not set
# CONFIG_PCIE_MEDIATEK is not set
# CONFIG_PCIE_MEDIATEK_GEN3 is not set
# CONFIG_PCIE_BRCMSTB is not set
CONFIG_PCI_LOONGSON=y
# CONFIG_PCIE_MICROCHIP_HOST is not set
# CONFIG_PCIE_APPLE is not set
# CONFIG_PCIE_MT7621 is not set

#
# DesignWare PCI Core Support
#
CONFIG_PCIE_DW=y
CONFIG_PCIE_DW_HOST=y
CONFIG_PCIE_DW_EP=y
CONFIG_PCIE_DW_PLAT=y
CONFIG_PCIE_DW_PLAT_HOST=y
CONFIG_PCIE_DW_PLAT_EP=y
# CONFIG_PCI_EXYNOS is not set
# CONFIG_PCI_IMX6 is not set
# CONFIG_PCIE_SPEAR13XX is not set
# CONFIG_PCI_KEYSTONE_HOST is not set
# CONFIG_PCI_KEYSTONE_EP is not set
# CONFIG_PCI_LAYERSCAPE is not set
# CONFIG_PCI_LAYERSCAPE_EP is not set
# CONFIG_PCI_HISI is not set
# CONFIG_PCIE_QCOM is not set
# CONFIG_PCIE_QCOM_EP is not set
# CONFIG_PCIE_ARMADA_8K is not set
# CONFIG_PCIE_ARTPEC6_HOST is not set
# CONFIG_PCIE_ARTPEC6_EP is not set
# CONFIG_PCIE_ROCKCHIP_DW_HOST is not set
# CONFIG_PCIE_INTEL_GW is not set
# CONFIG_PCIE_KEEMBAY_HOST is not set
# CONFIG_PCIE_KEEMBAY_EP is not set
# CONFIG_PCIE_KIRIN is not set
# CONFIG_PCIE_HISI_STB is not set
CONFIG_PCI_MESON=y
# CONFIG_PCIE_TEGRA194_HOST is not set
# CONFIG_PCIE_TEGRA194_EP is not set
# CONFIG_PCIE_VISCONTI_HOST is not set
# CONFIG_PCIE_UNIPHIER is not set
# CONFIG_PCIE_UNIPHIER_EP is not set
# CONFIG_PCIE_AL is not set
# CONFIG_PCIE_FU740 is not set
# end of DesignWare PCI Core Support

#
# Mobiveil PCIe Core Support
#
# CONFIG_PCIE_MOBIVEIL_PLAT is not set
# CONFIG_PCIE_LAYERSCAPE_GEN4 is not set
# end of Mobiveil PCIe Core Support

#
# Cadence PCIe controllers support
#
# CONFIG_PCIE_CADENCE_PLAT_HOST is not set
# CONFIG_PCIE_CADENCE_PLAT_EP is not set
# CONFIG_PCI_J721E_HOST is not set
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
CONFIG_PCI_EPF_VNTB=y
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
# CONFIG_CXL_MEM is not set
CONFIG_CXL_PORT=y
CONFIG_CXL_REGION=y
CONFIG_PCCARD=y
CONFIG_PCMCIA=y
CONFIG_PCMCIA_LOAD_CIS=y
# CONFIG_CARDBUS is not set

#
# PC-card bridges
#
# CONFIG_YENTA is not set
CONFIG_PD6729=y
CONFIG_I82092=y
CONFIG_PCCARD_NONSTATIC=y
CONFIG_RAPIDIO=y
# CONFIG_RAPIDIO_TSI721 is not set
CONFIG_RAPIDIO_DISC_TIMEOUT=30
CONFIG_RAPIDIO_ENABLE_RX_TX_PORTS=y
CONFIG_RAPIDIO_DEBUG=y
CONFIG_RAPIDIO_ENUM_BASIC=y
CONFIG_RAPIDIO_CHMAN=y
CONFIG_RAPIDIO_MPORT_CDEV=y

#
# RapidIO Switch drivers
#
CONFIG_RAPIDIO_CPS_XX=y
CONFIG_RAPIDIO_CPS_GEN2=y
CONFIG_RAPIDIO_RXS_GEN3=y
# end of RapidIO Switch drivers

#
# Generic Driver Options
#
CONFIG_AUXILIARY_BUS=y
# CONFIG_UEVENT_HELPER is not set
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
# CONFIG_DEVTMPFS_SAFE is not set
CONFIG_STANDALONE=y
# CONFIG_PREVENT_FIRMWARE_BUILD is not set

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_FW_LOADER_SYSFS=y
CONFIG_EXTRA_FIRMWARE=""
# CONFIG_FW_LOADER_USER_HELPER is not set
# CONFIG_FW_LOADER_COMPRESS is not set
CONFIG_FW_UPLOAD=y
# end of Firmware loader

CONFIG_WANT_DEV_COREDUMP=y
# CONFIG_ALLOW_DEV_COREDUMP is not set
CONFIG_DEBUG_DRIVER=y
CONFIG_DEBUG_DEVRES=y
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SLIMBUS=y
CONFIG_REGMAP_SPI=y
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_REGMAP_SCCB=y
CONFIG_REGMAP_SPI_AVMM=y
CONFIG_DMA_SHARED_BUFFER=y
CONFIG_DMA_FENCE_TRACE=y
# end of Generic Driver Options

#
# Bus devices
#
# CONFIG_ARM_INTEGRATOR_LM is not set
# CONFIG_BT1_APB is not set
# CONFIG_BT1_AXI is not set
# CONFIG_MOXTET is not set
# CONFIG_HISILICON_LPC is not set
# CONFIG_INTEL_IXP4XX_EB is not set
# CONFIG_QCOM_EBI2 is not set
CONFIG_MHI_BUS=y
# CONFIG_MHI_BUS_DEBUG is not set
# CONFIG_MHI_BUS_PCI_GENERIC is not set
CONFIG_MHI_BUS_EP=y
# end of Bus devices

# CONFIG_CONNECTOR is not set

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
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
# CONFIG_ISAPNP is not set
CONFIG_PNPACPI=y

#
# NVME Support
#
# end of NVME Support

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=y
CONFIG_AD525X_DPOT=y
# CONFIG_AD525X_DPOT_I2C is not set
CONFIG_AD525X_DPOT_SPI=y
CONFIG_DUMMY_IRQ=y
# CONFIG_PHANTOM is not set
CONFIG_TIFM_CORE=y
# CONFIG_TIFM_7XX1 is not set
# CONFIG_ICS932S401 is not set
# CONFIG_ATMEL_SSC is not set
CONFIG_ENCLOSURE_SERVICES=y
# CONFIG_GEHC_ACHC is not set
CONFIG_HP_ILO=y
# CONFIG_QCOM_COINCELL is not set
# CONFIG_QCOM_FASTRPC is not set
# CONFIG_APDS9802ALS is not set
CONFIG_ISL29003=y
CONFIG_ISL29020=y
CONFIG_SENSORS_TSL2550=y
CONFIG_SENSORS_BH1770=y
CONFIG_SENSORS_APDS990X=y
CONFIG_HMC6352=y
CONFIG_DS1682=y
# CONFIG_PCH_PHUB is not set
CONFIG_LATTICE_ECP3_CONFIG=y
CONFIG_SRAM=y
CONFIG_DW_XDATA_PCIE=y
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_XILINX_SDFEC is not set
CONFIG_MISC_RTSX=y
# CONFIG_HISI_HIKEY_USB is not set
# CONFIG_OPEN_DICE is not set
# CONFIG_VCPU_STALL_DETECTOR is not set
CONFIG_C2PORT=y

#
# EEPROM support
#
CONFIG_EEPROM_AT24=y
CONFIG_EEPROM_AT25=y
CONFIG_EEPROM_LEGACY=y
CONFIG_EEPROM_MAX6875=y
CONFIG_EEPROM_93CX6=y
# CONFIG_EEPROM_93XX46 is not set
CONFIG_EEPROM_IDT_89HPESX=y
CONFIG_EEPROM_EE1004=y
# end of EEPROM support

# CONFIG_CB710_CORE is not set

#
# Texas Instruments shared transport line discipline
#
# end of Texas Instruments shared transport line discipline

CONFIG_SENSORS_LIS3_I2C=y
# CONFIG_ALTERA_STAPL is not set
# CONFIG_GENWQE is not set
# CONFIG_ECHO is not set
CONFIG_BCM_VK=y
CONFIG_MISC_ALCOR_PCI=y
CONFIG_MISC_RTSX_PCI=y
CONFIG_MISC_RTSX_USB=y
CONFIG_HABANA_AI=y
# CONFIG_UACCE is not set
# CONFIG_PVPANIC is not set
# end of Misc devices

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
# end of SCSI device support

# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_FIREWIRE is not set
CONFIG_FIREWIRE_NOSY=y
# end of IEEE 1394 (FireWire) support

CONFIG_NETDEVICES=y
CONFIG_MII=y
# CONFIG_NET_CORE is not set
CONFIG_ARCNET=y
CONFIG_ARCNET_1201=y
CONFIG_ARCNET_1051=y
CONFIG_ARCNET_RAW=y
# CONFIG_ARCNET_CAP is not set
# CONFIG_ARCNET_COM90xx is not set
CONFIG_ARCNET_COM90xxIO=y
CONFIG_ARCNET_RIM_I=y
CONFIG_ARCNET_COM20020=y
CONFIG_ARCNET_COM20020_PCI=y
# CONFIG_ARCNET_COM20020_CS is not set
CONFIG_ATM_DRIVERS=y
CONFIG_ATM_DUMMY=y
CONFIG_ATM_TCP=y
CONFIG_ATM_LANAI=y
CONFIG_ATM_ENI=y
CONFIG_ATM_ENI_DEBUG=y
# CONFIG_ATM_ENI_TUNE_BURST is not set
# CONFIG_ATM_NICSTAR is not set
CONFIG_ATM_IDT77252=y
CONFIG_ATM_IDT77252_DEBUG=y
# CONFIG_ATM_IDT77252_RCV_ALL is not set
CONFIG_ATM_IDT77252_USE_SUNI=y
CONFIG_ATM_IA=y
# CONFIG_ATM_IA_DEBUG is not set
# CONFIG_ATM_FORE200E is not set
# CONFIG_ATM_HE is not set
# CONFIG_ATM_SOLOS is not set
CONFIG_CAIF_DRIVERS=y
CONFIG_CAIF_VIRTIO=y
CONFIG_ETHERNET=y
CONFIG_MDIO=y
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_NET_VENDOR_ACTIONS is not set
# CONFIG_NET_VENDOR_ADAPTEC is not set
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
CONFIG_NET_VENDOR_ALACRITECH=y
CONFIG_SLICOSS=y
# CONFIG_NET_VENDOR_ALTEON is not set
CONFIG_ALTERA_TSE=y
CONFIG_NET_VENDOR_AMAZON=y
CONFIG_ENA_ETHERNET=y
# CONFIG_NET_VENDOR_AMD is not set
# CONFIG_NET_XGENE is not set
# CONFIG_NET_XGENE_V2 is not set
# CONFIG_NET_VENDOR_AQUANTIA is not set
# CONFIG_NET_VENDOR_ARC is not set
CONFIG_NET_VENDOR_ASIX=y
# CONFIG_SPI_AX88796C is not set
CONFIG_NET_VENDOR_ATHEROS=y
# CONFIG_ATL2 is not set
CONFIG_ATL1=y
CONFIG_ATL1E=y
CONFIG_ATL1C=y
# CONFIG_ALX is not set
# CONFIG_CX_ECAT is not set
# CONFIG_NET_VENDOR_BROADCOM is not set
# CONFIG_NET_VENDOR_CADENCE is not set
# CONFIG_NET_CALXEDA_XGMAC is not set
# CONFIG_NET_VENDOR_CAVIUM is not set
# CONFIG_NET_VENDOR_CHELSIO is not set
CONFIG_NET_VENDOR_CIRRUS=y
# CONFIG_CS89x0_PLATFORM is not set
# CONFIG_EP93XX_ETH is not set
CONFIG_NET_VENDOR_CISCO=y
CONFIG_ENIC=y
# CONFIG_NET_VENDOR_CORTINA is not set
# CONFIG_NET_VENDOR_DAVICOM is not set
CONFIG_DNET=y
CONFIG_NET_VENDOR_DEC=y
CONFIG_NET_TULIP=y
CONFIG_DE2104X=y
CONFIG_DE2104X_DSL=0
CONFIG_TULIP=y
CONFIG_TULIP_MWI=y
CONFIG_TULIP_MMIO=y
# CONFIG_TULIP_NAPI is not set
# CONFIG_WINBOND_840 is not set
# CONFIG_DM9102 is not set
CONFIG_ULI526X=y
CONFIG_NET_VENDOR_DLINK=y
CONFIG_DL2K=y
# CONFIG_SUNDANCE is not set
# CONFIG_NET_VENDOR_EMULEX is not set
CONFIG_NET_VENDOR_ENGLEDER=y
CONFIG_TSNEP=y
# CONFIG_TSNEP_SELFTESTS is not set
# CONFIG_NET_VENDOR_EZCHIP is not set
CONFIG_NET_VENDOR_FARADAY=y
CONFIG_NET_VENDOR_FREESCALE=y
# CONFIG_FEC is not set
# CONFIG_FSL_FMAN is not set
# CONFIG_FSL_PQ_MDIO is not set
# CONFIG_FSL_XGMAC_MDIO is not set
# CONFIG_GIANFAR is not set
# CONFIG_FSL_DPAA2_SWITCH is not set
# CONFIG_FSL_ENETC is not set
# CONFIG_FSL_ENETC_VF is not set
# CONFIG_FSL_ENETC_IERB is not set
# CONFIG_FSL_ENETC_MDIO is not set
# CONFIG_NET_VENDOR_FUJITSU is not set
CONFIG_NET_VENDOR_FUNGIBLE=y
# CONFIG_FUN_ETH is not set
CONFIG_NET_VENDOR_GOOGLE=y
CONFIG_NET_VENDOR_HISILICON=y
# CONFIG_HIX5HD2_GMAC is not set
# CONFIG_HISI_FEMAC is not set
# CONFIG_HIP04_ETH is not set
# CONFIG_HNS_DSAF is not set
# CONFIG_HNS_ENET is not set
# CONFIG_HNS3 is not set
CONFIG_NET_VENDOR_HUAWEI=y
CONFIG_NET_VENDOR_I825XX=y
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
# CONFIG_E1000E is not set
CONFIG_IGB=y
CONFIG_IGB_HWMON=y
# CONFIG_IGBVF is not set
CONFIG_IXGB=y
CONFIG_IXGBE=y
CONFIG_IXGBE_HWMON=y
# CONFIG_IXGBE_DCB is not set
CONFIG_IXGBEVF=y
CONFIG_I40E=y
# CONFIG_I40E_DCB is not set
CONFIG_IAVF=y
CONFIG_I40EVF=y
# CONFIG_ICE is not set
# CONFIG_FM10K is not set
CONFIG_IGC=y
# CONFIG_NET_VENDOR_WANGXUN is not set
CONFIG_JME=y
# CONFIG_KORINA is not set
# CONFIG_NET_VENDOR_LITEX is not set
CONFIG_NET_VENDOR_MARVELL=y
# CONFIG_MV643XX_ETH is not set
# CONFIG_MVMDIO is not set
# CONFIG_MVNETA is not set
# CONFIG_MVPP2 is not set
# CONFIG_PXA168_ETH is not set
# CONFIG_SKGE is not set
CONFIG_SKY2=y
# CONFIG_SKY2_DEBUG is not set
# CONFIG_OCTEONTX2_AF is not set
# CONFIG_OCTEONTX2_PF is not set
CONFIG_OCTEON_EP=y
# CONFIG_PRESTERA is not set
# CONFIG_NET_VENDOR_MEDIATEK is not set
CONFIG_NET_VENDOR_MELLANOX=y
CONFIG_MLX4_EN=y
CONFIG_MLX4_EN_DCB=y
CONFIG_MLX4_CORE=y
CONFIG_MLX4_DEBUG=y
CONFIG_MLX4_CORE_GEN2=y
CONFIG_MLX5_CORE=y
CONFIG_MLX5_FPGA=y
CONFIG_MLX5_CORE_EN=y
# CONFIG_MLX5_EN_ARFS is not set
# CONFIG_MLX5_EN_RXNFC is not set
# CONFIG_MLX5_MPFS is not set
CONFIG_MLX5_ESWITCH=y
CONFIG_MLX5_BRIDGE=y
CONFIG_MLX5_CORE_EN_DCB=y
CONFIG_MLX5_CORE_IPOIB=y
CONFIG_MLX5_SW_STEERING=y
# CONFIG_MLX5_SF is not set
# CONFIG_MLXSW_CORE is not set
CONFIG_MLXFW=y
# CONFIG_MLXBF_GIGE is not set
CONFIG_NET_VENDOR_MICREL=y
# CONFIG_KS8851 is not set
CONFIG_KS8851_MLL=y
CONFIG_KSZ884X_PCI=y
CONFIG_NET_VENDOR_MICROCHIP=y
CONFIG_ENC28J60=y
CONFIG_ENC28J60_WRITEVERIFY=y
CONFIG_ENCX24J600=y
CONFIG_LAN743X=y
# CONFIG_LAN966X_SWITCH is not set
# CONFIG_SPARX5_SWITCH is not set
# CONFIG_NET_VENDOR_MICROSEMI is not set
# CONFIG_NET_VENDOR_MICROSOFT is not set
# CONFIG_NET_VENDOR_MYRI is not set
CONFIG_FEALNX=y
CONFIG_NET_VENDOR_NI=y
CONFIG_NI_XGE_MANAGEMENT_ENET=y
CONFIG_NET_VENDOR_NATSEMI=y
CONFIG_NATSEMI=y
CONFIG_NS83820=y
# CONFIG_NET_VENDOR_NETERION is not set
CONFIG_NET_VENDOR_NETRONOME=y
CONFIG_NFP=y
# CONFIG_NFP_APP_FLOWER is not set
# CONFIG_NFP_APP_ABM_NIC is not set
CONFIG_NFP_DEBUG=y
CONFIG_NET_VENDOR_8390=y
CONFIG_PCMCIA_AXNET=y
# CONFIG_AX88796 is not set
CONFIG_NE2K_PCI=y
CONFIG_PCMCIA_PCNET=y
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
# CONFIG_LPC_ENET is not set
# CONFIG_NET_VENDOR_OKI is not set
CONFIG_ETHOC=y
CONFIG_NET_VENDOR_PACKET_ENGINES=y
CONFIG_HAMACHI=y
# CONFIG_YELLOWFIN is not set
# CONFIG_NET_VENDOR_PENSANDO is not set
CONFIG_NET_VENDOR_QLOGIC=y
CONFIG_QLA3XXX=y
CONFIG_QLCNIC=y
CONFIG_QLCNIC_SRIOV=y
# CONFIG_QLCNIC_DCB is not set
# CONFIG_QLCNIC_HWMON is not set
# CONFIG_NETXEN_NIC is not set
# CONFIG_QED is not set
# CONFIG_NET_VENDOR_BROCADE is not set
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCA7000_SPI is not set
CONFIG_QCOM_EMAC=y
# CONFIG_RMNET is not set
CONFIG_NET_VENDOR_RDC=y
CONFIG_R6040=y
# CONFIG_NET_VENDOR_REALTEK is not set
CONFIG_NET_VENDOR_RENESAS=y
# CONFIG_SH_ETH is not set
# CONFIG_RAVB is not set
# CONFIG_NET_VENDOR_ROCKER is not set
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
# CONFIG_NET_VENDOR_SEEQ is not set
# CONFIG_NET_VENDOR_SILAN is not set
# CONFIG_NET_VENDOR_SIS is not set
# CONFIG_NET_VENDOR_SOLARFLARE is not set
# CONFIG_NET_VENDOR_SMSC is not set
# CONFIG_NET_VENDOR_SOCIONEXT is not set
# CONFIG_NET_VENDOR_STMICRO is not set
# CONFIG_NET_VENDOR_SUN is not set
CONFIG_NET_VENDOR_SUNPLUS=y
# CONFIG_SP7021_EMAC is not set
CONFIG_NET_VENDOR_SYNOPSYS=y
CONFIG_DWC_XLGMAC=y
CONFIG_DWC_XLGMAC_PCI=y
# CONFIG_NET_VENDOR_TEHUTI is not set
# CONFIG_NET_VENDOR_TI is not set
CONFIG_NET_VENDOR_VERTEXCOM=y
CONFIG_MSE102X=y
CONFIG_NET_VENDOR_VIA=y
CONFIG_VIA_RHINE=y
CONFIG_VIA_RHINE_MMIO=y
# CONFIG_VIA_VELOCITY is not set
CONFIG_NET_VENDOR_WIZNET=y
CONFIG_WIZNET_W5100=y
CONFIG_WIZNET_W5300=y
# CONFIG_WIZNET_BUS_DIRECT is not set
# CONFIG_WIZNET_BUS_INDIRECT is not set
CONFIG_WIZNET_BUS_ANY=y
# CONFIG_WIZNET_W5100_SPI is not set
CONFIG_NET_VENDOR_XILINX=y
CONFIG_XILINX_EMACLITE=y
# CONFIG_XILINX_AXI_EMAC is not set
# CONFIG_XILINX_LL_TEMAC is not set
CONFIG_NET_VENDOR_XIRCOM=y
CONFIG_PCMCIA_XIRC2PS=y
CONFIG_FDDI=y
CONFIG_DEFXX=y
CONFIG_SKFP=y
CONFIG_HIPPI=y
CONFIG_ROADRUNNER=y
# CONFIG_ROADRUNNER_LARGE_RINGS is not set
CONFIG_NET_SB1000=y
CONFIG_PHYLIB=y
CONFIG_SWPHY=y
# CONFIG_LED_TRIGGER_PHY is not set
CONFIG_FIXED_PHY=y

#
# MII PHY device drivers
#
CONFIG_AMD_PHY=y
# CONFIG_MESON_GXL_PHY is not set
# CONFIG_ADIN_PHY is not set
# CONFIG_ADIN1100_PHY is not set
CONFIG_AQUANTIA_PHY=y
CONFIG_AX88796B_PHY=y
CONFIG_BROADCOM_PHY=y
# CONFIG_BCM54140_PHY is not set
# CONFIG_BCM63XX_PHY is not set
CONFIG_BCM7XXX_PHY=y
CONFIG_BCM84881_PHY=y
CONFIG_BCM87XX_PHY=y
CONFIG_BCM_NET_PHYLIB=y
# CONFIG_CICADA_PHY is not set
# CONFIG_CORTINA_PHY is not set
# CONFIG_DAVICOM_PHY is not set
CONFIG_ICPLUS_PHY=y
# CONFIG_LXT_PHY is not set
CONFIG_INTEL_XWAY_PHY=y
CONFIG_LSI_ET1011C_PHY=y
CONFIG_MARVELL_PHY=y
# CONFIG_MARVELL_10G_PHY is not set
# CONFIG_MARVELL_88X2222_PHY is not set
CONFIG_MAXLINEAR_GPHY=y
CONFIG_MEDIATEK_GE_PHY=y
CONFIG_MICREL_PHY=y
# CONFIG_MICROCHIP_PHY is not set
CONFIG_MICROCHIP_T1_PHY=y
# CONFIG_MICROSEMI_PHY is not set
# CONFIG_MOTORCOMM_PHY is not set
# CONFIG_NATIONAL_PHY is not set
# CONFIG_NXP_C45_TJA11XX_PHY is not set
CONFIG_NXP_TJA11XX_PHY=y
CONFIG_AT803X_PHY=y
CONFIG_QSEMI_PHY=y
CONFIG_REALTEK_PHY=y
CONFIG_RENESAS_PHY=y
CONFIG_ROCKCHIP_PHY=y
# CONFIG_SMSC_PHY is not set
# CONFIG_STE10XP is not set
# CONFIG_TERANETICS_PHY is not set
CONFIG_DP83822_PHY=y
CONFIG_DP83TC811_PHY=y
# CONFIG_DP83848_PHY is not set
# CONFIG_DP83867_PHY is not set
# CONFIG_DP83869_PHY is not set
CONFIG_DP83TD510_PHY=y
CONFIG_VITESSE_PHY=y
CONFIG_XILINX_GMII2RGMII=y
CONFIG_MICREL_KS8995MA=y
CONFIG_CAN_DEV=y
CONFIG_CAN_VCAN=y
CONFIG_CAN_VXCAN=y
CONFIG_CAN_NETLINK=y
CONFIG_CAN_CALC_BITTIMING=y
CONFIG_CAN_RX_OFFLOAD=y
# CONFIG_CAN_AT91 is not set
# CONFIG_CAN_FLEXCAN is not set
# CONFIG_CAN_GRCAN is not set
CONFIG_CAN_JANZ_ICAN3=y
CONFIG_CAN_KVASER_PCIEFD=y
# CONFIG_CAN_SUN4I is not set
# CONFIG_CAN_XILINXCAN is not set
# CONFIG_PCH_CAN is not set
# CONFIG_CAN_C_CAN is not set
# CONFIG_CAN_CC770 is not set
CONFIG_CAN_CTUCANFD=y
CONFIG_CAN_CTUCANFD_PCI=y
# CONFIG_CAN_CTUCANFD_PLATFORM is not set
CONFIG_CAN_IFI_CANFD=y
CONFIG_CAN_M_CAN=y
CONFIG_CAN_M_CAN_PCI=y
# CONFIG_CAN_M_CAN_PLATFORM is not set
CONFIG_CAN_M_CAN_TCAN4X5X=y
# CONFIG_CAN_PEAK_PCIEFD is not set
# CONFIG_CAN_RCAR is not set
# CONFIG_CAN_RCAR_CANFD is not set
CONFIG_CAN_SJA1000=y
CONFIG_CAN_EMS_PCI=y
CONFIG_CAN_EMS_PCMCIA=y
CONFIG_CAN_F81601=y
# CONFIG_CAN_KVASER_PCI is not set
CONFIG_CAN_PEAK_PCI=y
CONFIG_CAN_PEAK_PCIEC=y
# CONFIG_CAN_PEAK_PCMCIA is not set
CONFIG_CAN_PLX_PCI=y
CONFIG_CAN_SJA1000_ISA=y
CONFIG_CAN_SJA1000_PLATFORM=y
# CONFIG_CAN_SOFTING is not set

#
# CAN SPI interfaces
#
CONFIG_CAN_HI311X=y
# CONFIG_CAN_MCP251X is not set
CONFIG_CAN_MCP251XFD=y
CONFIG_CAN_MCP251XFD_SANITY=y
# end of CAN SPI interfaces

#
# CAN USB interfaces
#
# CONFIG_CAN_8DEV_USB is not set
# CONFIG_CAN_EMS_USB is not set
CONFIG_CAN_ESD_USB=y
# CONFIG_CAN_ETAS_ES58X is not set
CONFIG_CAN_GS_USB=y
# CONFIG_CAN_KVASER_USB is not set
CONFIG_CAN_MCBA_USB=y
CONFIG_CAN_PEAK_USB=y
CONFIG_CAN_UCAN=y
# end of CAN USB interfaces

CONFIG_CAN_DEBUG_DEVICES=y

#
# MCTP Device Drivers
#
CONFIG_MCTP_TRANSPORT_I2C=y
# end of MCTP Device Drivers

CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
CONFIG_FWNODE_MDIO=y
CONFIG_OF_MDIO=y
CONFIG_ACPI_MDIO=y
CONFIG_MDIO_DEVRES=y
# CONFIG_MDIO_SUN4I is not set
# CONFIG_MDIO_XGENE is not set
# CONFIG_MDIO_ASPEED is not set
CONFIG_MDIO_BITBANG=y
# CONFIG_MDIO_BCM_IPROC is not set
# CONFIG_MDIO_BCM_UNIMAC is not set
# CONFIG_MDIO_GPIO is not set
# CONFIG_MDIO_HISI_FEMAC is not set
CONFIG_MDIO_MVUSB=y
# CONFIG_MDIO_MSCC_MIIM is not set
# CONFIG_MDIO_MOXART is not set
# CONFIG_MDIO_OCTEON is not set
# CONFIG_MDIO_IPQ4019 is not set
# CONFIG_MDIO_IPQ8064 is not set
# CONFIG_MDIO_THUNDER is not set

#
# MDIO Multiplexers
#
# CONFIG_MDIO_BUS_MUX_MESON_G12A is not set
# CONFIG_MDIO_BUS_MUX_BCM6368 is not set
# CONFIG_MDIO_BUS_MUX_BCM_IPROC is not set
# CONFIG_MDIO_BUS_MUX_GPIO is not set
# CONFIG_MDIO_BUS_MUX_MULTIPLEXER is not set
# CONFIG_MDIO_BUS_MUX_MMIOREG is not set

#
# PCS device drivers
#
# CONFIG_PCS_RZN1_MIIC is not set
# end of PCS device drivers

# CONFIG_PPP is not set
# CONFIG_USB_NET_DRIVERS is not set
CONFIG_WLAN=y
# CONFIG_WLAN_VENDOR_ADMTEK is not set
# CONFIG_WLAN_VENDOR_ATH is not set
CONFIG_WLAN_VENDOR_ATMEL=y
# CONFIG_WLAN_VENDOR_BROADCOM is not set
# CONFIG_WLAN_VENDOR_CISCO is not set
CONFIG_WLAN_VENDOR_INTEL=y
CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
CONFIG_WLAN_VENDOR_MARVELL=y
# CONFIG_WLAN_VENDOR_MEDIATEK is not set
CONFIG_WLAN_VENDOR_MICROCHIP=y
# CONFIG_WLAN_VENDOR_PURELIFI is not set
CONFIG_WLAN_VENDOR_RALINK=y
# CONFIG_WLAN_VENDOR_REALTEK is not set
# CONFIG_WLAN_VENDOR_RSI is not set
# CONFIG_WLAN_VENDOR_SILABS is not set
# CONFIG_WLAN_VENDOR_ST is not set
# CONFIG_WLAN_VENDOR_TI is not set
# CONFIG_WLAN_VENDOR_ZYDAS is not set
# CONFIG_WLAN_VENDOR_QUANTENNA is not set
# CONFIG_PCMCIA_RAYCS is not set
# CONFIG_WAN is not set
CONFIG_IEEE802154_DRIVERS=y
CONFIG_IEEE802154_FAKELB=y
CONFIG_IEEE802154_AT86RF230=y
CONFIG_IEEE802154_MRF24J40=y
CONFIG_IEEE802154_CC2520=y
# CONFIG_IEEE802154_ATUSB is not set
CONFIG_IEEE802154_ADF7242=y
CONFIG_IEEE802154_CA8210=y
CONFIG_IEEE802154_CA8210_DEBUGFS=y
# CONFIG_IEEE802154_MCR20A is not set
# CONFIG_IEEE802154_HWSIM is not set

#
# Wireless WAN
#
# CONFIG_WWAN is not set
# end of Wireless WAN

CONFIG_VMXNET3=y
CONFIG_FUJITSU_ES=y
# CONFIG_USB4_NET is not set
CONFIG_NETDEVSIM=y
CONFIG_NET_FAILOVER=y
CONFIG_ISDN=y
CONFIG_ISDN_CAPI=y
# CONFIG_MISDN is not set

#
# Input device support
#
CONFIG_INPUT=y
# CONFIG_INPUT_LEDS is not set
CONFIG_INPUT_FF_MEMLESS=y
CONFIG_INPUT_SPARSEKMAP=y
CONFIG_INPUT_MATRIXKMAP=y
CONFIG_INPUT_VIVALDIFMAP=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
CONFIG_INPUT_EVDEV=y
CONFIG_INPUT_EVBUG=y

#
# Input Device Drivers
#
# CONFIG_INPUT_KEYBOARD is not set
# CONFIG_INPUT_MOUSE is not set
# CONFIG_INPUT_JOYSTICK is not set
CONFIG_INPUT_TABLET=y
CONFIG_TABLET_USB_ACECAD=y
CONFIG_TABLET_USB_AIPTEK=y
CONFIG_TABLET_USB_HANWANG=y
# CONFIG_TABLET_USB_KBTAB is not set
# CONFIG_TABLET_USB_PEGASUS is not set
CONFIG_TABLET_SERIAL_WACOM4=y
CONFIG_INPUT_TOUCHSCREEN=y
CONFIG_TOUCHSCREEN_ADS7846=y
CONFIG_TOUCHSCREEN_AD7877=y
CONFIG_TOUCHSCREEN_AD7879=y
CONFIG_TOUCHSCREEN_AD7879_I2C=y
CONFIG_TOUCHSCREEN_AD7879_SPI=y
# CONFIG_TOUCHSCREEN_ADC is not set
# CONFIG_TOUCHSCREEN_AR1021_I2C is not set
CONFIG_TOUCHSCREEN_ATMEL_MXT=y
CONFIG_TOUCHSCREEN_ATMEL_MXT_T37=y
CONFIG_TOUCHSCREEN_AUO_PIXCIR=y
CONFIG_TOUCHSCREEN_BU21013=y
# CONFIG_TOUCHSCREEN_BU21029 is not set
# CONFIG_TOUCHSCREEN_CHIPONE_ICN8318 is not set
# CONFIG_TOUCHSCREEN_CHIPONE_ICN8505 is not set
# CONFIG_TOUCHSCREEN_CY8CTMA140 is not set
CONFIG_TOUCHSCREEN_CY8CTMG110=y
# CONFIG_TOUCHSCREEN_CYTTSP_CORE is not set
CONFIG_TOUCHSCREEN_CYTTSP4_CORE=y
CONFIG_TOUCHSCREEN_CYTTSP4_I2C=y
# CONFIG_TOUCHSCREEN_CYTTSP4_SPI is not set
CONFIG_TOUCHSCREEN_DA9034=y
# CONFIG_TOUCHSCREEN_DA9052 is not set
CONFIG_TOUCHSCREEN_DYNAPRO=y
CONFIG_TOUCHSCREEN_HAMPSHIRE=y
CONFIG_TOUCHSCREEN_EETI=y
# CONFIG_TOUCHSCREEN_EGALAX is not set
CONFIG_TOUCHSCREEN_EGALAX_SERIAL=y
# CONFIG_TOUCHSCREEN_EXC3000 is not set
CONFIG_TOUCHSCREEN_FUJITSU=y
# CONFIG_TOUCHSCREEN_GOODIX is not set
CONFIG_TOUCHSCREEN_HIDEEP=y
CONFIG_TOUCHSCREEN_HYCON_HY46XX=y
CONFIG_TOUCHSCREEN_ILI210X=y
# CONFIG_TOUCHSCREEN_ILITEK is not set
# CONFIG_TOUCHSCREEN_IPROC is not set
CONFIG_TOUCHSCREEN_S6SY761=y
# CONFIG_TOUCHSCREEN_GUNZE is not set
CONFIG_TOUCHSCREEN_EKTF2127=y
# CONFIG_TOUCHSCREEN_ELAN is not set
CONFIG_TOUCHSCREEN_ELO=y
CONFIG_TOUCHSCREEN_WACOM_W8001=y
CONFIG_TOUCHSCREEN_WACOM_I2C=y
CONFIG_TOUCHSCREEN_MAX11801=y
CONFIG_TOUCHSCREEN_MCS5000=y
# CONFIG_TOUCHSCREEN_MMS114 is not set
CONFIG_TOUCHSCREEN_MELFAS_MIP4=y
CONFIG_TOUCHSCREEN_MSG2638=y
CONFIG_TOUCHSCREEN_MTOUCH=y
CONFIG_TOUCHSCREEN_IMAGIS=y
# CONFIG_TOUCHSCREEN_IMX6UL_TSC is not set
CONFIG_TOUCHSCREEN_INEXIO=y
CONFIG_TOUCHSCREEN_MK712=y
CONFIG_TOUCHSCREEN_PENMOUNT=y
# CONFIG_TOUCHSCREEN_EDT_FT5X06 is not set
# CONFIG_TOUCHSCREEN_RASPBERRYPI_FW is not set
# CONFIG_TOUCHSCREEN_MIGOR is not set
# CONFIG_TOUCHSCREEN_TOUCHRIGHT is not set
# CONFIG_TOUCHSCREEN_TOUCHWIN is not set
# CONFIG_TOUCHSCREEN_TI_AM335X_TSC is not set
CONFIG_TOUCHSCREEN_PIXCIR=y
CONFIG_TOUCHSCREEN_WDT87XX_I2C=y
CONFIG_TOUCHSCREEN_WM831X=y
CONFIG_TOUCHSCREEN_USB_COMPOSITE=y
CONFIG_TOUCHSCREEN_MC13783=y
# CONFIG_TOUCHSCREEN_USB_EGALAX is not set
CONFIG_TOUCHSCREEN_USB_PANJIT=y
CONFIG_TOUCHSCREEN_USB_3M=y
CONFIG_TOUCHSCREEN_USB_ITM=y
CONFIG_TOUCHSCREEN_USB_ETURBO=y
# CONFIG_TOUCHSCREEN_USB_GUNZE is not set
CONFIG_TOUCHSCREEN_USB_DMC_TSC10=y
# CONFIG_TOUCHSCREEN_USB_IRTOUCH is not set
CONFIG_TOUCHSCREEN_USB_IDEALTEK=y
# CONFIG_TOUCHSCREEN_USB_GENERAL_TOUCH is not set
CONFIG_TOUCHSCREEN_USB_GOTOP=y
# CONFIG_TOUCHSCREEN_USB_JASTEC is not set
CONFIG_TOUCHSCREEN_USB_ELO=y
CONFIG_TOUCHSCREEN_USB_E2I=y
CONFIG_TOUCHSCREEN_USB_ZYTRONIC=y
# CONFIG_TOUCHSCREEN_USB_ETT_TC45USB is not set
CONFIG_TOUCHSCREEN_USB_NEXIO=y
CONFIG_TOUCHSCREEN_USB_EASYTOUCH=y
CONFIG_TOUCHSCREEN_TOUCHIT213=y
# CONFIG_TOUCHSCREEN_TS4800 is not set
# CONFIG_TOUCHSCREEN_TSC_SERIO is not set
CONFIG_TOUCHSCREEN_TSC200X_CORE=y
# CONFIG_TOUCHSCREEN_TSC2004 is not set
CONFIG_TOUCHSCREEN_TSC2005=y
CONFIG_TOUCHSCREEN_TSC2007=y
# CONFIG_TOUCHSCREEN_TSC2007_IIO is not set
CONFIG_TOUCHSCREEN_RM_TS=y
# CONFIG_TOUCHSCREEN_SILEAD is not set
CONFIG_TOUCHSCREEN_SIS_I2C=y
# CONFIG_TOUCHSCREEN_ST1232 is not set
CONFIG_TOUCHSCREEN_STMFTS=y
# CONFIG_TOUCHSCREEN_SUN4I is not set
CONFIG_TOUCHSCREEN_SURFACE3_SPI=y
CONFIG_TOUCHSCREEN_SX8654=y
CONFIG_TOUCHSCREEN_TPS6507X=y
CONFIG_TOUCHSCREEN_ZET6223=y
CONFIG_TOUCHSCREEN_ZFORCE=y
# CONFIG_TOUCHSCREEN_COLIBRI_VF50 is not set
CONFIG_TOUCHSCREEN_ROHM_BU21023=y
# CONFIG_TOUCHSCREEN_IQS5XX is not set
CONFIG_TOUCHSCREEN_ZINITIX=y
CONFIG_INPUT_MISC=y
CONFIG_INPUT_AD714X=y
CONFIG_INPUT_AD714X_I2C=y
CONFIG_INPUT_AD714X_SPI=y
# CONFIG_INPUT_ARIEL_PWRBUTTON is not set
CONFIG_INPUT_ATC260X_ONKEY=y
# CONFIG_INPUT_ATMEL_CAPTOUCH is not set
# CONFIG_INPUT_BMA150 is not set
CONFIG_INPUT_E3X0_BUTTON=y
# CONFIG_INPUT_MAX77693_HAPTIC is not set
# CONFIG_INPUT_MAX8925_ONKEY is not set
CONFIG_INPUT_MAX8997_HAPTIC=y
CONFIG_INPUT_MC13783_PWRBUTTON=y
# CONFIG_INPUT_MMA8450 is not set
# CONFIG_INPUT_GPIO_BEEPER is not set
CONFIG_INPUT_GPIO_DECODER=y
# CONFIG_INPUT_GPIO_VIBRA is not set
# CONFIG_INPUT_ATI_REMOTE2 is not set
CONFIG_INPUT_KEYSPAN_REMOTE=y
CONFIG_INPUT_KXTJ9=y
CONFIG_INPUT_POWERMATE=y
CONFIG_INPUT_YEALINK=y
# CONFIG_INPUT_CM109 is not set
# CONFIG_INPUT_REGULATOR_HAPTIC is not set
CONFIG_INPUT_AXP20X_PEK=y
CONFIG_INPUT_TWL6040_VIBRA=y
CONFIG_INPUT_UINPUT=y
CONFIG_INPUT_PALMAS_PWRBUTTON=y
CONFIG_INPUT_PCF8574=y
# CONFIG_INPUT_PWM_BEEPER is not set
CONFIG_INPUT_PWM_VIBRA=y
CONFIG_INPUT_GPIO_ROTARY_ENCODER=y
CONFIG_INPUT_DA7280_HAPTICS=y
# CONFIG_INPUT_DA9052_ONKEY is not set
CONFIG_INPUT_DA9055_ONKEY=y
CONFIG_INPUT_DA9063_ONKEY=y
CONFIG_INPUT_WM831X_ON=y
# CONFIG_INPUT_ADXL34X is not set
CONFIG_INPUT_IMS_PCU=y
CONFIG_INPUT_IQS269A=y
CONFIG_INPUT_IQS626A=y
CONFIG_INPUT_IQS7222=y
CONFIG_INPUT_CMA3000=y
CONFIG_INPUT_CMA3000_I2C=y
# CONFIG_INPUT_IDEAPAD_SLIDEBAR is not set
# CONFIG_INPUT_DRV260X_HAPTICS is not set
# CONFIG_INPUT_DRV2665_HAPTICS is not set
# CONFIG_INPUT_DRV2667_HAPTICS is not set
# CONFIG_INPUT_HISI_POWERKEY is not set
# CONFIG_INPUT_SC27XX_VIBRA is not set
CONFIG_RMI4_CORE=y
CONFIG_RMI4_I2C=y
CONFIG_RMI4_SPI=y
CONFIG_RMI4_SMB=y
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=y
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
# CONFIG_RMI4_F34 is not set
# CONFIG_RMI4_F3A is not set
CONFIG_RMI4_F54=y
CONFIG_RMI4_F55=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_PCIPS2=y
# CONFIG_SERIO_LIBPS2 is not set
CONFIG_SERIO_RAW=y
# CONFIG_SERIO_ALTERA_PS2 is not set
CONFIG_SERIO_PS2MULT=y
CONFIG_SERIO_ARC_PS2=y
# CONFIG_SERIO_APBPS2 is not set
# CONFIG_SERIO_OLPC_APSP is not set
# CONFIG_SERIO_SUN4I_PS2 is not set
CONFIG_SERIO_GPIO_PS2=y
CONFIG_USERIO=y
CONFIG_GAMEPORT=y
CONFIG_GAMEPORT_NS558=y
# CONFIG_GAMEPORT_L4 is not set
CONFIG_GAMEPORT_EMU10K1=y
# CONFIG_GAMEPORT_FM801 is not set
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
# CONFIG_TTY is not set
# CONFIG_SERIAL_DEV_BUS is not set
# CONFIG_IPMI_HANDLER is not set
# CONFIG_ASPEED_KCS_IPMI_BMC is not set
# CONFIG_NPCM7XX_KCS_IPMI_BMC is not set
# CONFIG_ASPEED_BT_IPMI_BMC is not set
CONFIG_IPMB_DEVICE_INTERFACE=y
CONFIG_HW_RANDOM=y
# CONFIG_HW_RANDOM_TIMERIOMEM is not set
CONFIG_HW_RANDOM_ATMEL=y
# CONFIG_HW_RANDOM_BA431 is not set
CONFIG_HW_RANDOM_BCM2835=y
CONFIG_HW_RANDOM_IPROC_RNG200=y
CONFIG_HW_RANDOM_IXP4XX=y
CONFIG_HW_RANDOM_OMAP=y
CONFIG_HW_RANDOM_OMAP3_ROM=y
CONFIG_HW_RANDOM_VIRTIO=y
CONFIG_HW_RANDOM_IMX_RNGC=y
CONFIG_HW_RANDOM_NOMADIK=y
CONFIG_HW_RANDOM_STM32=y
CONFIG_HW_RANDOM_MESON=y
CONFIG_HW_RANDOM_MTK=y
CONFIG_HW_RANDOM_EXYNOS=y
CONFIG_HW_RANDOM_NPCM=y
CONFIG_HW_RANDOM_KEYSTONE=y
# CONFIG_HW_RANDOM_CCTRNG is not set
# CONFIG_HW_RANDOM_XIPHERA is not set
CONFIG_HW_RANDOM_CN10K=y
CONFIG_APPLICOM=y

#
# PCMCIA character devices
#
CONFIG_CARDMAN_4000=y
# CONFIG_CARDMAN_4040 is not set
# CONFIG_SCR24X is not set
# end of PCMCIA character devices

CONFIG_DEVMEM=y
# CONFIG_DEVPORT is not set
CONFIG_TCG_TPM=y
# CONFIG_HW_RANDOM_TPM is not set
# CONFIG_TCG_TIS is not set
# CONFIG_TCG_TIS_SPI is not set
# CONFIG_TCG_TIS_I2C is not set
# CONFIG_TCG_TIS_SYNQUACER is not set
CONFIG_TCG_TIS_I2C_CR50=y
CONFIG_TCG_TIS_I2C_ATMEL=y
CONFIG_TCG_TIS_I2C_INFINEON=y
CONFIG_TCG_TIS_I2C_NUVOTON=y
CONFIG_TCG_ATMEL=y
CONFIG_TCG_INFINEON=y
# CONFIG_TCG_CRB is not set
CONFIG_TCG_VTPM_PROXY=y
CONFIG_TCG_TIS_ST33ZP24=y
CONFIG_TCG_TIS_ST33ZP24_I2C=y
# CONFIG_TCG_TIS_ST33ZP24_SPI is not set
CONFIG_XILLYBUS_CLASS=y
# CONFIG_XILLYBUS is not set
CONFIG_XILLYUSB=y
# CONFIG_RANDOM_TRUST_CPU is not set
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
# CONFIG_I2C_MUX_PCA9541 is not set
CONFIG_I2C_MUX_PCA954x=y
# CONFIG_I2C_MUX_PINCTRL is not set
# CONFIG_I2C_MUX_REG is not set
# CONFIG_I2C_DEMUX_PINCTRL is not set
CONFIG_I2C_MUX_MLXCPLD=y
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
CONFIG_I2C_ALI1535=y
CONFIG_I2C_ALI1563=y
# CONFIG_I2C_ALI15X3 is not set
CONFIG_I2C_AMD756=y
CONFIG_I2C_AMD8111=y
# CONFIG_I2C_AMD_MP2 is not set
# CONFIG_I2C_HIX5HD2 is not set
# CONFIG_I2C_I801 is not set
CONFIG_I2C_ISCH=y
# CONFIG_I2C_PIIX4 is not set
# CONFIG_I2C_NFORCE2 is not set
CONFIG_I2C_NVIDIA_GPU=y
CONFIG_I2C_SIS5595=y
CONFIG_I2C_SIS630=y
# CONFIG_I2C_SIS96X is not set
CONFIG_I2C_VIA=y
# CONFIG_I2C_VIAPRO is not set

#
# ACPI drivers
#
CONFIG_I2C_SCMI=y

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_ALTERA is not set
# CONFIG_I2C_ASPEED is not set
# CONFIG_I2C_AT91 is not set
# CONFIG_I2C_AXXIA is not set
# CONFIG_I2C_BCM2835 is not set
# CONFIG_I2C_BCM_IPROC is not set
# CONFIG_I2C_BCM_KONA is not set
CONFIG_I2C_BRCMSTB=y
# CONFIG_I2C_CADENCE is not set
CONFIG_I2C_CBUS_GPIO=y
# CONFIG_I2C_DAVINCI is not set
CONFIG_I2C_DESIGNWARE_CORE=y
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
CONFIG_I2C_DESIGNWARE_PLATFORM=y
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_DIGICOLOR is not set
# CONFIG_I2C_EG20T is not set
# CONFIG_I2C_EMEV2 is not set
# CONFIG_I2C_EXYNOS5 is not set
CONFIG_I2C_GPIO=y
CONFIG_I2C_GPIO_FAULT_INJECTOR=y
# CONFIG_I2C_HIGHLANDER is not set
# CONFIG_I2C_HISI is not set
# CONFIG_I2C_IMG is not set
# CONFIG_I2C_IMX is not set
# CONFIG_I2C_IMX_LPI2C is not set
# CONFIG_I2C_IOP3XX is not set
# CONFIG_I2C_JZ4780 is not set
# CONFIG_I2C_KEMPLD is not set
# CONFIG_I2C_LPC2K is not set
# CONFIG_I2C_MESON is not set
# CONFIG_I2C_MICROCHIP_CORE is not set
# CONFIG_I2C_MT65XX is not set
# CONFIG_I2C_MT7621 is not set
# CONFIG_I2C_MV64XXX is not set
# CONFIG_I2C_MXS is not set
# CONFIG_I2C_NPCM is not set
# CONFIG_I2C_OCORES is not set
# CONFIG_I2C_OMAP is not set
# CONFIG_I2C_OWL is not set
# CONFIG_I2C_APPLE is not set
CONFIG_I2C_PCA_PLATFORM=y
# CONFIG_I2C_PNX is not set
# CONFIG_I2C_PXA is not set
# CONFIG_I2C_QCOM_CCI is not set
# CONFIG_I2C_QUP is not set
# CONFIG_I2C_RIIC is not set
# CONFIG_I2C_RK3X is not set
# CONFIG_I2C_RZV2M is not set
# CONFIG_I2C_S3C2410 is not set
# CONFIG_I2C_SH_MOBILE is not set
CONFIG_I2C_SIMTEC=y
# CONFIG_I2C_SPRD is not set
# CONFIG_I2C_ST is not set
# CONFIG_I2C_STM32F4 is not set
# CONFIG_I2C_STM32F7 is not set
# CONFIG_I2C_SUN6I_P2WI is not set
# CONFIG_I2C_SYNQUACER is not set
# CONFIG_I2C_TEGRA_BPMP is not set
# CONFIG_I2C_UNIPHIER is not set
# CONFIG_I2C_UNIPHIER_F is not set
# CONFIG_I2C_VERSATILE is not set
# CONFIG_I2C_WMT is not set
# CONFIG_I2C_THUNDERX is not set
# CONFIG_I2C_XILINX is not set
# CONFIG_I2C_XLP9XX is not set
# CONFIG_I2C_RCAR is not set

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_DIOLAN_U2C=y
CONFIG_I2C_DLN2=y
CONFIG_I2C_CP2615=y
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
# CONFIG_I2C_TINY_USB is not set

#
# Other I2C/SMBus bus drivers
#
# CONFIG_I2C_MLXCPLD is not set
CONFIG_I2C_VIRTIO=y
# end of I2C Hardware Bus support

CONFIG_I2C_SLAVE=y
CONFIG_I2C_SLAVE_EEPROM=y
CONFIG_I2C_SLAVE_TESTUNIT=y
CONFIG_I2C_DEBUG_CORE=y
# CONFIG_I2C_DEBUG_ALGO is not set
CONFIG_I2C_DEBUG_BUS=y
# end of I2C support

# CONFIG_I3C is not set
CONFIG_SPI=y
CONFIG_SPI_DEBUG=y
CONFIG_SPI_MASTER=y
CONFIG_SPI_MEM=y

#
# SPI Master Controller Drivers
#
CONFIG_SPI_ALTERA=y
CONFIG_SPI_ALTERA_CORE=y
# CONFIG_SPI_ALTERA_DFL is not set
# CONFIG_SPI_AR934X is not set
# CONFIG_SPI_ATH79 is not set
# CONFIG_SPI_ARMADA_3700 is not set
# CONFIG_SPI_ASPEED_SMC is not set
# CONFIG_SPI_ATMEL is not set
# CONFIG_SPI_ATMEL_QUADSPI is not set
CONFIG_SPI_AXI_SPI_ENGINE=y
# CONFIG_SPI_BCM2835 is not set
# CONFIG_SPI_BCM2835AUX is not set
# CONFIG_SPI_BCM63XX is not set
# CONFIG_SPI_BCM63XX_HSSPI is not set
# CONFIG_SPI_BCM_QSPI is not set
CONFIG_SPI_BITBANG=y
# CONFIG_SPI_CADENCE is not set
# CONFIG_SPI_CADENCE_QUADSPI is not set
# CONFIG_SPI_CADENCE_XSPI is not set
# CONFIG_SPI_CLPS711X is not set
CONFIG_SPI_DESIGNWARE=y
# CONFIG_SPI_DW_DMA is not set
CONFIG_SPI_DW_PCI=y
CONFIG_SPI_DW_MMIO=y
# CONFIG_SPI_DW_BT1 is not set
CONFIG_SPI_DLN2=y
# CONFIG_SPI_EP93XX is not set
# CONFIG_SPI_FSL_LPSPI is not set
# CONFIG_SPI_FSL_QUADSPI is not set
# CONFIG_SPI_GXP is not set
# CONFIG_SPI_HISI_KUNPENG is not set
# CONFIG_SPI_HISI_SFC_V3XX is not set
CONFIG_SPI_NXP_FLEXSPI=y
# CONFIG_SPI_GPIO is not set
# CONFIG_SPI_IMG_SPFI is not set
# CONFIG_SPI_IMX is not set
# CONFIG_SPI_INGENIC is not set
# CONFIG_SPI_INTEL_PCI is not set
# CONFIG_SPI_INTEL_PLATFORM is not set
# CONFIG_SPI_JCORE is not set
# CONFIG_SPI_LP8841_RTC is not set
# CONFIG_SPI_FSL_SPI is not set
# CONFIG_SPI_FSL_DSPI is not set
# CONFIG_SPI_MESON_SPICC is not set
# CONFIG_SPI_MESON_SPIFC is not set
# CONFIG_SPI_MICROCHIP_CORE is not set
# CONFIG_SPI_MT65XX is not set
# CONFIG_SPI_MT7621 is not set
# CONFIG_SPI_MTK_NOR is not set
# CONFIG_SPI_NPCM_FIU is not set
# CONFIG_SPI_NPCM_PSPI is not set
# CONFIG_SPI_LANTIQ_SSC is not set
CONFIG_SPI_OC_TINY=y
# CONFIG_SPI_OMAP24XX is not set
# CONFIG_SPI_TI_QSPI is not set
# CONFIG_SPI_OMAP_100K is not set
# CONFIG_SPI_ORION is not set
# CONFIG_SPI_PIC32 is not set
# CONFIG_SPI_PIC32_SQI is not set
# CONFIG_SPI_PXA2XX is not set
CONFIG_SPI_ROCKCHIP=y
# CONFIG_SPI_ROCKCHIP_SFC is not set
# CONFIG_SPI_RSPI is not set
# CONFIG_SPI_QUP is not set
# CONFIG_SPI_S3C64XX is not set
# CONFIG_SPI_SC18IS602 is not set
# CONFIG_SPI_SH_MSIOF is not set
# CONFIG_SPI_SH is not set
# CONFIG_SPI_SH_HSPI is not set
# CONFIG_SPI_SIFIVE is not set
# CONFIG_SPI_SPRD is not set
# CONFIG_SPI_SPRD_ADI is not set
# CONFIG_SPI_STM32 is not set
# CONFIG_SPI_STM32_QSPI is not set
# CONFIG_SPI_ST_SSC4 is not set
# CONFIG_SPI_SUN4I is not set
# CONFIG_SPI_SUN6I is not set
# CONFIG_SPI_SUNPLUS_SP7021 is not set
# CONFIG_SPI_SYNQUACER is not set
CONFIG_SPI_MXIC=y
# CONFIG_SPI_TEGRA210_QUAD is not set
# CONFIG_SPI_TEGRA114 is not set
# CONFIG_SPI_TEGRA20_SFLASH is not set
# CONFIG_SPI_TEGRA20_SLINK is not set
# CONFIG_SPI_THUNDERX is not set
# CONFIG_SPI_TOPCLIFF_PCH is not set
# CONFIG_SPI_UNIPHIER is not set
CONFIG_SPI_XCOMM=y
CONFIG_SPI_XILINX=y
# CONFIG_SPI_XLP is not set
# CONFIG_SPI_XTENSA_XTFPGA is not set
# CONFIG_SPI_ZYNQ_QSPI is not set
CONFIG_SPI_ZYNQMP_GQSPI=y
CONFIG_SPI_AMD=y

#
# SPI Multiplexer support
#
# CONFIG_SPI_MUX is not set

#
# SPI Protocol Masters
#
# CONFIG_SPI_SPIDEV is not set
CONFIG_SPI_TLE62X0=y
# CONFIG_SPI_SLAVE is not set
CONFIG_SPI_DYNAMIC=y
# CONFIG_SPMI is not set
# CONFIG_HSI is not set
CONFIG_PPS=y
CONFIG_PPS_DEBUG=y
CONFIG_NTP_PPS=y

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
CONFIG_PPS_CLIENT_GPIO=y

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=y
CONFIG_PTP_1588_CLOCK_OPTIONAL=y
CONFIG_PTP_1588_CLOCK_DTE=y
CONFIG_PTP_1588_CLOCK_QORIQ=y

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
# CONFIG_PTP_1588_CLOCK_PCH is not set
CONFIG_PTP_1588_CLOCK_IDT82P33=y
CONFIG_PTP_1588_CLOCK_IDTCM=y
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
# CONFIG_PINCTRL_DA9062 is not set
# CONFIG_PINCTRL_EQUILIBRIUM is not set
# CONFIG_PINCTRL_INGENIC is not set
# CONFIG_PINCTRL_LPC18XX is not set
CONFIG_PINCTRL_MCP23S08_I2C=y
CONFIG_PINCTRL_MCP23S08_SPI=y
CONFIG_PINCTRL_MCP23S08=y
# CONFIG_PINCTRL_MICROCHIP_SGPIO is not set
# CONFIG_PINCTRL_OCELOT is not set
# CONFIG_PINCTRL_PALMAS is not set
# CONFIG_PINCTRL_PISTACHIO is not set
# CONFIG_PINCTRL_ROCKCHIP is not set
# CONFIG_PINCTRL_SINGLE is not set
# CONFIG_PINCTRL_STARFIVE is not set
# CONFIG_PINCTRL_STMFX is not set
# CONFIG_PINCTRL_SX150X is not set
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
CONFIG_PINCTRL_CS47L85=y
CONFIG_PINCTRL_CS47L90=y

#
# Intel pinctrl drivers
#
# CONFIG_PINCTRL_BAYTRAIL is not set
# CONFIG_PINCTRL_CHERRYVIEW is not set
# CONFIG_PINCTRL_LYNXPOINT is not set
# CONFIG_PINCTRL_ALDERLAKE is not set
# CONFIG_PINCTRL_BROXTON is not set
# CONFIG_PINCTRL_CANNONLAKE is not set
# CONFIG_PINCTRL_CEDARFORK is not set
# CONFIG_PINCTRL_DENVERTON is not set
# CONFIG_PINCTRL_ELKHARTLAKE is not set
# CONFIG_PINCTRL_EMMITSBURG is not set
# CONFIG_PINCTRL_GEMINILAKE is not set
# CONFIG_PINCTRL_ICELAKE is not set
# CONFIG_PINCTRL_JASPERLAKE is not set
# CONFIG_PINCTRL_LAKEFIELD is not set
# CONFIG_PINCTRL_LEWISBURG is not set
# CONFIG_PINCTRL_METEORLAKE is not set
# CONFIG_PINCTRL_SUNRISEPOINT is not set
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
# CONFIG_PINCTRL_PXA25X is not set
# CONFIG_PINCTRL_PXA27X is not set
# CONFIG_PINCTRL_MSM is not set
# CONFIG_PINCTRL_QCOM_SSBI_PMIC is not set
# CONFIG_PINCTRL_LPASS_LPI is not set

#
# Renesas pinctrl drivers
#
# CONFIG_PINCTRL_RENESAS is not set
# CONFIG_PINCTRL_PFC_EMEV2 is not set
# CONFIG_PINCTRL_PFC_R8A77995 is not set
# CONFIG_PINCTRL_PFC_R8A7794 is not set
# CONFIG_PINCTRL_PFC_R8A77990 is not set
# CONFIG_PINCTRL_PFC_R8A7779 is not set
# CONFIG_PINCTRL_PFC_R8A7790 is not set
# CONFIG_PINCTRL_PFC_R8A77950 is not set
# CONFIG_PINCTRL_PFC_R8A77951 is not set
# CONFIG_PINCTRL_PFC_R8A7778 is not set
# CONFIG_PINCTRL_PFC_R8A7793 is not set
# CONFIG_PINCTRL_PFC_R8A7791 is not set
# CONFIG_PINCTRL_PFC_R8A77965 is not set
# CONFIG_PINCTRL_PFC_R8A77960 is not set
# CONFIG_PINCTRL_PFC_R8A77961 is not set
# CONFIG_PINCTRL_PFC_R8A779F0 is not set
# CONFIG_PINCTRL_PFC_R8A7792 is not set
# CONFIG_PINCTRL_PFC_R8A77980 is not set
# CONFIG_PINCTRL_PFC_R8A77970 is not set
# CONFIG_PINCTRL_PFC_R8A779A0 is not set
# CONFIG_PINCTRL_PFC_R8A779G0 is not set
# CONFIG_PINCTRL_PFC_R8A7740 is not set
# CONFIG_PINCTRL_PFC_R8A73A4 is not set
# CONFIG_PINCTRL_RZA1 is not set
# CONFIG_PINCTRL_RZA2 is not set
# CONFIG_PINCTRL_RZG2L is not set
# CONFIG_PINCTRL_PFC_R8A77470 is not set
# CONFIG_PINCTRL_PFC_R8A7745 is not set
# CONFIG_PINCTRL_PFC_R8A7742 is not set
# CONFIG_PINCTRL_PFC_R8A7743 is not set
# CONFIG_PINCTRL_PFC_R8A7744 is not set
# CONFIG_PINCTRL_PFC_R8A774C0 is not set
# CONFIG_PINCTRL_PFC_R8A774E1 is not set
# CONFIG_PINCTRL_PFC_R8A774A1 is not set
# CONFIG_PINCTRL_PFC_R8A774B1 is not set
# CONFIG_PINCTRL_RZN1 is not set
# CONFIG_PINCTRL_RZV2M is not set
# CONFIG_PINCTRL_PFC_SH7203 is not set
# CONFIG_PINCTRL_PFC_SH7264 is not set
# CONFIG_PINCTRL_PFC_SH7269 is not set
# CONFIG_PINCTRL_PFC_SH7720 is not set
# CONFIG_PINCTRL_PFC_SH7722 is not set
# CONFIG_PINCTRL_PFC_SH7734 is not set
# CONFIG_PINCTRL_PFC_SH7757 is not set
# CONFIG_PINCTRL_PFC_SH7785 is not set
# CONFIG_PINCTRL_PFC_SH7786 is not set
# CONFIG_PINCTRL_PFC_SH73A0 is not set
# CONFIG_PINCTRL_PFC_SH7723 is not set
# CONFIG_PINCTRL_PFC_SH7724 is not set
# CONFIG_PINCTRL_PFC_SHX3 is not set
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
CONFIG_DEBUG_GPIO=y
# CONFIG_GPIO_SYSFS is not set
# CONFIG_GPIO_CDEV is not set
CONFIG_GPIO_GENERIC=y

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_74XX_MMIO is not set
# CONFIG_GPIO_ALTERA is not set
CONFIG_GPIO_AMDPT=y
# CONFIG_GPIO_ASPEED is not set
# CONFIG_GPIO_ASPEED_SGPIO is not set
# CONFIG_GPIO_ATH79 is not set
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
# CONFIG_GPIO_IOP is not set
# CONFIG_GPIO_LOGICVC is not set
# CONFIG_GPIO_LPC18XX is not set
# CONFIG_GPIO_LPC32XX is not set
# CONFIG_GPIO_MB86S7X is not set
CONFIG_GPIO_MENZ127=y
# CONFIG_GPIO_MPC8XXX is not set
# CONFIG_GPIO_MT7621 is not set
# CONFIG_GPIO_MXC is not set
# CONFIG_GPIO_MXS is not set
# CONFIG_GPIO_PMIC_EIC_SPRD is not set
# CONFIG_GPIO_PXA is not set
# CONFIG_GPIO_RCAR is not set
# CONFIG_GPIO_RDA is not set
# CONFIG_GPIO_ROCKCHIP is not set
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
# CONFIG_GPIO_THUNDERX is not set
# CONFIG_GPIO_UNIPHIER is not set
# CONFIG_GPIO_VISCONTI is not set
# CONFIG_GPIO_VX855 is not set
# CONFIG_GPIO_WCD934X is not set
# CONFIG_GPIO_XGENE_SB is not set
# CONFIG_GPIO_XILINX is not set
# CONFIG_GPIO_XLP is not set
CONFIG_GPIO_AMD_FCH=y
# CONFIG_GPIO_IDT3243X is not set
# end of Memory mapped GPIO drivers

#
# I2C GPIO expanders
#
CONFIG_GPIO_ADP5588=y
# CONFIG_GPIO_ADP5588_IRQ is not set
# CONFIG_GPIO_ADNP is not set
# CONFIG_GPIO_GW_PLD is not set
# CONFIG_GPIO_MAX7300 is not set
CONFIG_GPIO_MAX732X=y
CONFIG_GPIO_MAX732X_IRQ=y
CONFIG_GPIO_PCA953X=y
# CONFIG_GPIO_PCA953X_IRQ is not set
# CONFIG_GPIO_PCA9570 is not set
CONFIG_GPIO_PCF857X=y
CONFIG_GPIO_TPIC2810=y
# CONFIG_GPIO_TS4900 is not set
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
CONFIG_GPIO_ADP5520=y
CONFIG_GPIO_ARIZONA=y
# CONFIG_GPIO_BD9571MWV is not set
CONFIG_GPIO_DA9052=y
CONFIG_GPIO_DA9055=y
CONFIG_GPIO_DLN2=y
# CONFIG_GPIO_JANZ_TTL is not set
CONFIG_GPIO_KEMPLD=y
CONFIG_GPIO_LP3943=y
CONFIG_GPIO_LP873X=y
CONFIG_GPIO_MADERA=y
# CONFIG_GPIO_PALMAS is not set
# CONFIG_GPIO_RC5T583 is not set
# CONFIG_GPIO_SL28CPLD is not set
CONFIG_GPIO_TPS65086=y
# CONFIG_GPIO_TPS65910 is not set
CONFIG_GPIO_TPS65912=y
CONFIG_GPIO_TQMX86=y
CONFIG_GPIO_TWL6040=y
# CONFIG_GPIO_WM831X is not set
# CONFIG_GPIO_WM8350 is not set
# CONFIG_GPIO_WM8994 is not set
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
CONFIG_GPIO_BT8XX=y
# CONFIG_GPIO_MLXBF is not set
# CONFIG_GPIO_MLXBF2 is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
CONFIG_GPIO_RDC321X=y
# end of PCI GPIO expanders

#
# SPI GPIO expanders
#
# CONFIG_GPIO_74X164 is not set
# CONFIG_GPIO_MAX3191X is not set
# CONFIG_GPIO_MAX7301 is not set
CONFIG_GPIO_MC33880=y
CONFIG_GPIO_PISOSR=y
CONFIG_GPIO_XRA1403=y
# end of SPI GPIO expanders

#
# USB GPIO expanders
#
# end of USB GPIO expanders

#
# Virtual GPIO drivers
#
CONFIG_GPIO_AGGREGATOR=y
# CONFIG_GPIO_MOCKUP is not set
CONFIG_GPIO_VIRTIO=y
CONFIG_GPIO_SIM=y
# end of Virtual GPIO drivers

CONFIG_W1=y

#
# 1-wire Bus Masters
#
CONFIG_W1_MASTER_MATROX=y
# CONFIG_W1_MASTER_DS2490 is not set
CONFIG_W1_MASTER_DS2482=y
# CONFIG_W1_MASTER_MXC is not set
CONFIG_W1_MASTER_DS1WM=y
# CONFIG_W1_MASTER_GPIO is not set
CONFIG_W1_MASTER_SGI=y
# end of 1-wire Bus Masters

#
# 1-wire Slaves
#
CONFIG_W1_SLAVE_THERM=y
CONFIG_W1_SLAVE_SMEM=y
CONFIG_W1_SLAVE_DS2405=y
CONFIG_W1_SLAVE_DS2408=y
CONFIG_W1_SLAVE_DS2408_READBACK=y
# CONFIG_W1_SLAVE_DS2413 is not set
CONFIG_W1_SLAVE_DS2406=y
CONFIG_W1_SLAVE_DS2423=y
CONFIG_W1_SLAVE_DS2805=y
# CONFIG_W1_SLAVE_DS2430 is not set
# CONFIG_W1_SLAVE_DS2431 is not set
CONFIG_W1_SLAVE_DS2433=y
# CONFIG_W1_SLAVE_DS2433_CRC is not set
CONFIG_W1_SLAVE_DS2438=y
CONFIG_W1_SLAVE_DS250X=y
CONFIG_W1_SLAVE_DS2780=y
CONFIG_W1_SLAVE_DS2781=y
# CONFIG_W1_SLAVE_DS28E04 is not set
CONFIG_W1_SLAVE_DS28E17=y
# end of 1-wire Slaves

# CONFIG_POWER_RESET is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_POWER_SUPPLY_HWMON=y
# CONFIG_PDA_POWER is not set
# CONFIG_GENERIC_ADC_BATTERY is not set
# CONFIG_IP5XXX_POWER is not set
CONFIG_MAX8925_POWER=y
CONFIG_WM831X_BACKUP=y
CONFIG_WM831X_POWER=y
CONFIG_WM8350_POWER=y
CONFIG_TEST_POWER=y
# CONFIG_CHARGER_ADP5061 is not set
# CONFIG_BATTERY_ACT8945A is not set
# CONFIG_BATTERY_CW2015 is not set
CONFIG_BATTERY_DS2760=y
CONFIG_BATTERY_DS2780=y
# CONFIG_BATTERY_DS2781 is not set
CONFIG_BATTERY_DS2782=y
# CONFIG_BATTERY_LEGO_EV3 is not set
CONFIG_BATTERY_SAMSUNG_SDI=y
CONFIG_BATTERY_SBS=y
# CONFIG_CHARGER_SBS is not set
CONFIG_MANAGER_SBS=y
CONFIG_BATTERY_BQ27XXX=y
# CONFIG_BATTERY_BQ27XXX_I2C is not set
CONFIG_BATTERY_BQ27XXX_HDQ=y
# CONFIG_BATTERY_DA9030 is not set
# CONFIG_BATTERY_DA9052 is not set
CONFIG_CHARGER_DA9150=y
CONFIG_BATTERY_DA9150=y
# CONFIG_CHARGER_AXP20X is not set
CONFIG_BATTERY_AXP20X=y
CONFIG_AXP20X_POWER=y
CONFIG_BATTERY_MAX17040=y
CONFIG_BATTERY_MAX17042=y
# CONFIG_BATTERY_MAX1721X is not set
CONFIG_CHARGER_ISP1704=y
# CONFIG_CHARGER_MAX8903 is not set
CONFIG_CHARGER_LP8727=y
CONFIG_CHARGER_GPIO=y
CONFIG_CHARGER_MANAGER=y
# CONFIG_CHARGER_LT3651 is not set
# CONFIG_CHARGER_LTC4162L is not set
# CONFIG_CHARGER_DETECTOR_MAX14656 is not set
# CONFIG_CHARGER_MAX77693 is not set
CONFIG_CHARGER_MAX77976=y
CONFIG_CHARGER_MAX8997=y
CONFIG_CHARGER_MP2629=y
# CONFIG_CHARGER_QCOM_SMBB is not set
CONFIG_CHARGER_BQ2415X=y
CONFIG_CHARGER_BQ24190=y
# CONFIG_CHARGER_BQ24257 is not set
# CONFIG_CHARGER_BQ24735 is not set
# CONFIG_CHARGER_BQ2515X is not set
CONFIG_CHARGER_BQ25890=y
CONFIG_CHARGER_BQ25980=y
CONFIG_CHARGER_BQ256XX=y
CONFIG_CHARGER_SMB347=y
# CONFIG_CHARGER_TPS65090 is not set
CONFIG_BATTERY_GAUGE_LTC2941=y
CONFIG_BATTERY_GOLDFISH=y
CONFIG_BATTERY_RT5033=y
CONFIG_CHARGER_RT9455=y
# CONFIG_CHARGER_SC2731 is not set
# CONFIG_FUEL_GAUGE_SC27XX is not set
# CONFIG_CHARGER_UCS1002 is not set
CONFIG_CHARGER_BD99954=y
# CONFIG_BATTERY_UG3105 is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
CONFIG_HWMON_DEBUG_CHIP=y

#
# Native drivers
#
CONFIG_SENSORS_AD7314=y
CONFIG_SENSORS_AD7414=y
CONFIG_SENSORS_AD7418=y
CONFIG_SENSORS_ADM1025=y
# CONFIG_SENSORS_ADM1026 is not set
# CONFIG_SENSORS_ADM1029 is not set
CONFIG_SENSORS_ADM1031=y
# CONFIG_SENSORS_ADM1177 is not set
CONFIG_SENSORS_ADM9240=y
CONFIG_SENSORS_ADT7X10=y
# CONFIG_SENSORS_ADT7310 is not set
CONFIG_SENSORS_ADT7410=y
CONFIG_SENSORS_ADT7411=y
# CONFIG_SENSORS_ADT7462 is not set
# CONFIG_SENSORS_ADT7470 is not set
CONFIG_SENSORS_ADT7475=y
CONFIG_SENSORS_AHT10=y
CONFIG_SENSORS_AQUACOMPUTER_D5NEXT=y
# CONFIG_SENSORS_AS370 is not set
CONFIG_SENSORS_ASC7621=y
CONFIG_SENSORS_AXI_FAN_CONTROL=y
# CONFIG_SENSORS_ASB100 is not set
CONFIG_SENSORS_ASPEED=y
CONFIG_SENSORS_ATXP1=y
# CONFIG_SENSORS_BT1_PVT is not set
# CONFIG_SENSORS_CORSAIR_CPRO is not set
CONFIG_SENSORS_CORSAIR_PSU=y
CONFIG_SENSORS_DS620=y
CONFIG_SENSORS_DS1621=y
# CONFIG_SENSORS_DA9052_ADC is not set
CONFIG_SENSORS_DA9055=y
CONFIG_SENSORS_I5K_AMB=y
# CONFIG_SENSORS_SPARX5 is not set
# CONFIG_SENSORS_F71805F is not set
# CONFIG_SENSORS_F71882FG is not set
CONFIG_SENSORS_F75375S=y
CONFIG_SENSORS_MC13783_ADC=y
# CONFIG_SENSORS_FSCHMD is not set
# CONFIG_SENSORS_FTSTEUTATES is not set
CONFIG_SENSORS_GL518SM=y
CONFIG_SENSORS_GL520SM=y
# CONFIG_SENSORS_G760A is not set
# CONFIG_SENSORS_G762 is not set
# CONFIG_SENSORS_GPIO_FAN is not set
# CONFIG_SENSORS_HIH6130 is not set
CONFIG_SENSORS_IIO_HWMON=y
# CONFIG_SENSORS_IT87 is not set
CONFIG_SENSORS_JC42=y
CONFIG_SENSORS_POWR1220=y
# CONFIG_SENSORS_LAN966X is not set
# CONFIG_SENSORS_LINEAGE is not set
CONFIG_SENSORS_LTC2945=y
# CONFIG_SENSORS_LTC2947_I2C is not set
# CONFIG_SENSORS_LTC2947_SPI is not set
CONFIG_SENSORS_LTC2990=y
CONFIG_SENSORS_LTC2992=y
CONFIG_SENSORS_LTC4151=y
CONFIG_SENSORS_LTC4215=y
# CONFIG_SENSORS_LTC4222 is not set
CONFIG_SENSORS_LTC4245=y
CONFIG_SENSORS_LTC4260=y
CONFIG_SENSORS_LTC4261=y
# CONFIG_SENSORS_MAX1111 is not set
CONFIG_SENSORS_MAX127=y
CONFIG_SENSORS_MAX16065=y
CONFIG_SENSORS_MAX1619=y
# CONFIG_SENSORS_MAX1668 is not set
CONFIG_SENSORS_MAX197=y
CONFIG_SENSORS_MAX31722=y
CONFIG_SENSORS_MAX31730=y
CONFIG_SENSORS_MAX6620=y
# CONFIG_SENSORS_MAX6621 is not set
CONFIG_SENSORS_MAX6639=y
CONFIG_SENSORS_MAX6650=y
CONFIG_SENSORS_MAX6697=y
CONFIG_SENSORS_MAX31790=y
# CONFIG_SENSORS_MCP3021 is not set
# CONFIG_SENSORS_TC654 is not set
CONFIG_SENSORS_TPS23861=y
CONFIG_SENSORS_MENF21BMC_HWMON=y
# CONFIG_SENSORS_MR75203 is not set
CONFIG_SENSORS_ADCXX=y
CONFIG_SENSORS_LM63=y
CONFIG_SENSORS_LM70=y
CONFIG_SENSORS_LM73=y
CONFIG_SENSORS_LM75=y
# CONFIG_SENSORS_LM77 is not set
CONFIG_SENSORS_LM78=y
# CONFIG_SENSORS_LM80 is not set
CONFIG_SENSORS_LM83=y
# CONFIG_SENSORS_LM85 is not set
# CONFIG_SENSORS_LM87 is not set
CONFIG_SENSORS_LM90=y
CONFIG_SENSORS_LM92=y
# CONFIG_SENSORS_LM93 is not set
CONFIG_SENSORS_LM95234=y
CONFIG_SENSORS_LM95241=y
# CONFIG_SENSORS_LM95245 is not set
CONFIG_SENSORS_PC87360=y
CONFIG_SENSORS_PC87427=y
# CONFIG_SENSORS_NTC_THERMISTOR is not set
CONFIG_SENSORS_NCT6683=y
CONFIG_SENSORS_NCT6775_CORE=y
CONFIG_SENSORS_NCT6775=y
CONFIG_SENSORS_NCT6775_I2C=y
# CONFIG_SENSORS_NCT7802 is not set
CONFIG_SENSORS_NCT7904=y
# CONFIG_SENSORS_NPCM7XX is not set
# CONFIG_SENSORS_NSA320 is not set
# CONFIG_SENSORS_NZXT_KRAKEN2 is not set
CONFIG_SENSORS_NZXT_SMART2=y
# CONFIG_SENSORS_OCC_P8_I2C is not set
CONFIG_SENSORS_PCF8591=y
CONFIG_SENSORS_PECI_CPUTEMP=y
CONFIG_SENSORS_PECI_DIMMTEMP=y
CONFIG_SENSORS_PECI=y
CONFIG_PMBUS=y
CONFIG_SENSORS_PMBUS=y
CONFIG_SENSORS_ADM1266=y
# CONFIG_SENSORS_ADM1275 is not set
CONFIG_SENSORS_BEL_PFE=y
CONFIG_SENSORS_BPA_RS600=y
CONFIG_SENSORS_DELTA_AHE50DC_FAN=y
# CONFIG_SENSORS_FSP_3Y is not set
# CONFIG_SENSORS_IBM_CFFPS is not set
# CONFIG_SENSORS_DPS920AB is not set
# CONFIG_SENSORS_INSPUR_IPSPS is not set
CONFIG_SENSORS_IR35221=y
# CONFIG_SENSORS_IR36021 is not set
CONFIG_SENSORS_IR38064=y
CONFIG_SENSORS_IR38064_REGULATOR=y
CONFIG_SENSORS_IRPS5401=y
CONFIG_SENSORS_ISL68137=y
CONFIG_SENSORS_LM25066=y
# CONFIG_SENSORS_LM25066_REGULATOR is not set
CONFIG_SENSORS_LT7182S=y
CONFIG_SENSORS_LTC2978=y
CONFIG_SENSORS_LTC2978_REGULATOR=y
CONFIG_SENSORS_LTC3815=y
# CONFIG_SENSORS_MAX15301 is not set
CONFIG_SENSORS_MAX16064=y
CONFIG_SENSORS_MAX16601=y
CONFIG_SENSORS_MAX20730=y
# CONFIG_SENSORS_MAX20751 is not set
CONFIG_SENSORS_MAX31785=y
# CONFIG_SENSORS_MAX34440 is not set
CONFIG_SENSORS_MAX8688=y
# CONFIG_SENSORS_MP2888 is not set
CONFIG_SENSORS_MP2975=y
CONFIG_SENSORS_MP5023=y
CONFIG_SENSORS_PIM4328=y
CONFIG_SENSORS_PLI1209BC=y
CONFIG_SENSORS_PLI1209BC_REGULATOR=y
# CONFIG_SENSORS_PM6764TR is not set
CONFIG_SENSORS_PXE1610=y
# CONFIG_SENSORS_Q54SJ108A2 is not set
CONFIG_SENSORS_STPDDC60=y
CONFIG_SENSORS_TPS40422=y
CONFIG_SENSORS_TPS53679=y
CONFIG_SENSORS_UCD9000=y
CONFIG_SENSORS_UCD9200=y
# CONFIG_SENSORS_XDPE152 is not set
# CONFIG_SENSORS_XDPE122 is not set
CONFIG_SENSORS_ZL6100=y
# CONFIG_SENSORS_PWM_FAN is not set
# CONFIG_SENSORS_RASPBERRYPI_HWMON is not set
# CONFIG_SENSORS_SL28CPLD is not set
CONFIG_SENSORS_SBTSI=y
CONFIG_SENSORS_SBRMI=y
CONFIG_SENSORS_SHT15=y
CONFIG_SENSORS_SHT21=y
CONFIG_SENSORS_SHT3x=y
CONFIG_SENSORS_SHT4x=y
CONFIG_SENSORS_SHTC1=y
CONFIG_SENSORS_SIS5595=y
CONFIG_SENSORS_SY7636A=y
# CONFIG_SENSORS_DME1737 is not set
CONFIG_SENSORS_EMC1403=y
CONFIG_SENSORS_EMC2103=y
CONFIG_SENSORS_EMC6W201=y
CONFIG_SENSORS_SMSC47M1=y
CONFIG_SENSORS_SMSC47M192=y
CONFIG_SENSORS_SMSC47B397=y
# CONFIG_SENSORS_SCH5627 is not set
# CONFIG_SENSORS_SCH5636 is not set
# CONFIG_SENSORS_STTS751 is not set
CONFIG_SENSORS_SMM665=y
CONFIG_SENSORS_ADC128D818=y
CONFIG_SENSORS_ADS7828=y
CONFIG_SENSORS_ADS7871=y
# CONFIG_SENSORS_AMC6821 is not set
# CONFIG_SENSORS_INA209 is not set
CONFIG_SENSORS_INA2XX=y
CONFIG_SENSORS_INA238=y
# CONFIG_SENSORS_INA3221 is not set
CONFIG_SENSORS_TC74=y
CONFIG_SENSORS_THMC50=y
CONFIG_SENSORS_TMP102=y
# CONFIG_SENSORS_TMP103 is not set
CONFIG_SENSORS_TMP108=y
CONFIG_SENSORS_TMP401=y
CONFIG_SENSORS_TMP421=y
CONFIG_SENSORS_TMP464=y
CONFIG_SENSORS_TMP513=y
CONFIG_SENSORS_VIA686A=y
# CONFIG_SENSORS_VT1211 is not set
CONFIG_SENSORS_VT8231=y
CONFIG_SENSORS_W83773G=y
CONFIG_SENSORS_W83781D=y
# CONFIG_SENSORS_W83791D is not set
# CONFIG_SENSORS_W83792D is not set
# CONFIG_SENSORS_W83793 is not set
# CONFIG_SENSORS_W83795 is not set
CONFIG_SENSORS_W83L785TS=y
CONFIG_SENSORS_W83L786NG=y
CONFIG_SENSORS_W83627HF=y
# CONFIG_SENSORS_W83627EHF is not set
# CONFIG_SENSORS_WM831X is not set
# CONFIG_SENSORS_WM8350 is not set
CONFIG_SENSORS_INTEL_M10_BMC_HWMON=y

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=y
CONFIG_THERMAL=y
# CONFIG_THERMAL_NETLINK is not set
CONFIG_THERMAL_STATISTICS=y
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_OF=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
# CONFIG_THERMAL_GOV_BANG_BANG is not set
# CONFIG_THERMAL_GOV_USER_SPACE is not set
# CONFIG_CPU_THERMAL is not set
# CONFIG_DEVFREQ_THERMAL is not set
# CONFIG_THERMAL_EMULATION is not set
# CONFIG_THERMAL_MMIO is not set
CONFIG_HISI_THERMAL=y
# CONFIG_IMX_THERMAL is not set
# CONFIG_IMX8MM_THERMAL is not set
# CONFIG_K3_THERMAL is not set
# CONFIG_QORIQ_THERMAL is not set
# CONFIG_SPEAR_THERMAL is not set
# CONFIG_SUN8I_THERMAL is not set
# CONFIG_ROCKCHIP_THERMAL is not set
# CONFIG_RCAR_THERMAL is not set
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
# CONFIG_TEGRA_SOCTHERM is not set
# CONFIG_TEGRA_BPMP_THERMAL is not set
# CONFIG_TEGRA30_TSENSOR is not set
# end of NVIDIA Tegra thermal drivers

# CONFIG_GENERIC_ADC_THERMAL is not set

#
# Qualcomm thermal drivers
#
# end of Qualcomm thermal drivers

# CONFIG_UNIPHIER_THERMAL is not set
# CONFIG_SPRD_THERMAL is not set
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
# CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED is not set
CONFIG_WATCHDOG_OPEN_TIMEOUT=0
CONFIG_WATCHDOG_SYSFS=y
CONFIG_WATCHDOG_HRTIMER_PRETIMEOUT=y

#
# Watchdog Pretimeout Governors
#
# CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=y
# CONFIG_DA9052_WATCHDOG is not set
# CONFIG_DA9055_WATCHDOG is not set
# CONFIG_DA9063_WATCHDOG is not set
# CONFIG_DA9062_WATCHDOG is not set
# CONFIG_GPIO_WATCHDOG is not set
CONFIG_MENF21BMC_WATCHDOG=y
# CONFIG_MENZ069_WATCHDOG is not set
CONFIG_WDAT_WDT=y
CONFIG_WM831X_WATCHDOG=y
CONFIG_WM8350_WATCHDOG=y
# CONFIG_XILINX_WATCHDOG is not set
CONFIG_ZIIRAVE_WATCHDOG=y
# CONFIG_SL28CPLD_WATCHDOG is not set
# CONFIG_ARMADA_37XX_WATCHDOG is not set
# CONFIG_ASM9260_WATCHDOG is not set
# CONFIG_AT91RM9200_WATCHDOG is not set
# CONFIG_AT91SAM9X_WATCHDOG is not set
# CONFIG_SAMA5D4_WATCHDOG is not set
# CONFIG_CADENCE_WATCHDOG is not set
# CONFIG_FTWDT010_WATCHDOG is not set
# CONFIG_S3C2410_WATCHDOG is not set
CONFIG_DW_WATCHDOG=y
# CONFIG_EP93XX_WATCHDOG is not set
# CONFIG_OMAP_WATCHDOG is not set
# CONFIG_PNX4008_WATCHDOG is not set
# CONFIG_DAVINCI_WATCHDOG is not set
# CONFIG_K3_RTI_WATCHDOG is not set
# CONFIG_RN5T618_WATCHDOG is not set
# CONFIG_SUNXI_WATCHDOG is not set
# CONFIG_NPCM7XX_WATCHDOG is not set
# CONFIG_STMP3XXX_RTC_WATCHDOG is not set
# CONFIG_TS4800_WATCHDOG is not set
# CONFIG_TS72XX_WATCHDOG is not set
CONFIG_MAX63XX_WATCHDOG=y
# CONFIG_MAX77620_WATCHDOG is not set
# CONFIG_IMX2_WDT is not set
# CONFIG_IMX7ULP_WDT is not set
# CONFIG_MOXART_WDT is not set
# CONFIG_ST_LPC_WATCHDOG is not set
# CONFIG_TEGRA_WATCHDOG is not set
# CONFIG_QCOM_WDT is not set
# CONFIG_MESON_GXBB_WATCHDOG is not set
# CONFIG_MESON_WATCHDOG is not set
# CONFIG_MEDIATEK_WATCHDOG is not set
# CONFIG_DIGICOLOR_WATCHDOG is not set
# CONFIG_LPC18XX_WATCHDOG is not set
# CONFIG_RENESAS_WDT is not set
# CONFIG_RENESAS_RZAWDT is not set
# CONFIG_RENESAS_RZN1WDT is not set
# CONFIG_RENESAS_RZG2LWDT is not set
# CONFIG_ASPEED_WATCHDOG is not set
# CONFIG_UNIPHIER_WATCHDOG is not set
# CONFIG_RTD119X_WATCHDOG is not set
# CONFIG_REALTEK_OTTO_WDT is not set
# CONFIG_SPRD_WATCHDOG is not set
# CONFIG_VISCONTI_WATCHDOG is not set
# CONFIG_MSC313E_WATCHDOG is not set
# CONFIG_APPLE_WATCHDOG is not set
# CONFIG_SUNPLUS_WATCHDOG is not set
CONFIG_ALIM7101_WDT=y
# CONFIG_SC520_WDT is not set
# CONFIG_I6300ESB_WDT is not set
CONFIG_KEMPLD_WDT=y
# CONFIG_RDC321X_WDT is not set
# CONFIG_BCM47XX_WDT is not set
# CONFIG_BCM2835_WDT is not set
# CONFIG_BCM_KONA_WDT is not set
# CONFIG_BCM7038_WDT is not set
# CONFIG_IMGPDC_WDT is not set
# CONFIG_MPC5200_WDT is not set
# CONFIG_MEN_A21_WDT is not set
# CONFIG_UML_WATCHDOG is not set

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=y
# CONFIG_WDTPCI is not set

#
# USB-based Watchdog Cards
#
CONFIG_USBPCWATCHDOG=y
CONFIG_SSB_POSSIBLE=y
# CONFIG_SSB is not set
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=y
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
# CONFIG_BCMA_HOST_SOC is not set
CONFIG_BCMA_DRIVER_PCI=y
# CONFIG_BCMA_DRIVER_MIPS is not set
# CONFIG_BCMA_DRIVER_GMAC_CMN is not set
# CONFIG_BCMA_DRIVER_GPIO is not set
# CONFIG_BCMA_DEBUG is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_ACT8945A is not set
# CONFIG_MFD_SUN4I_GPADC is not set
# CONFIG_MFD_AS3711 is not set
# CONFIG_MFD_AS3722 is not set
CONFIG_PMIC_ADP5520=y
CONFIG_MFD_AAT2870_CORE=y
# CONFIG_MFD_AT91_USART is not set
# CONFIG_MFD_ATMEL_FLEXCOM is not set
# CONFIG_MFD_ATMEL_HLCDC is not set
# CONFIG_MFD_BCM590XX is not set
CONFIG_MFD_BD9571MWV=y
CONFIG_MFD_AXP20X=y
CONFIG_MFD_AXP20X_I2C=y
CONFIG_MFD_MADERA=y
CONFIG_MFD_MADERA_I2C=y
CONFIG_MFD_MADERA_SPI=y
# CONFIG_MFD_CS47L15 is not set
# CONFIG_MFD_CS47L35 is not set
CONFIG_MFD_CS47L85=y
CONFIG_MFD_CS47L90=y
# CONFIG_MFD_CS47L92 is not set
# CONFIG_MFD_ASIC3 is not set
CONFIG_PMIC_DA903X=y
CONFIG_PMIC_DA9052=y
# CONFIG_MFD_DA9052_SPI is not set
CONFIG_MFD_DA9052_I2C=y
CONFIG_MFD_DA9055=y
CONFIG_MFD_DA9062=y
CONFIG_MFD_DA9063=y
CONFIG_MFD_DA9150=y
CONFIG_MFD_DLN2=y
# CONFIG_MFD_ENE_KB3930 is not set
# CONFIG_MFD_EXYNOS_LPASS is not set
# CONFIG_MFD_GATEWORKS_GSC is not set
CONFIG_MFD_MC13XXX=y
CONFIG_MFD_MC13XXX_SPI=y
CONFIG_MFD_MC13XXX_I2C=y
CONFIG_MFD_MP2629=y
# CONFIG_MFD_MXS_LRADC is not set
# CONFIG_MFD_MX25_TSADC is not set
# CONFIG_MFD_HI6421_PMIC is not set
# CONFIG_MFD_HI655X_PMIC is not set
CONFIG_HTC_PASIC3=y
# CONFIG_HTC_I2CPLD is not set
CONFIG_LPC_ICH=y
CONFIG_LPC_SCH=y
# CONFIG_INTEL_SOC_PMIC is not set
# CONFIG_INTEL_SOC_PMIC_CHTWC is not set
# CONFIG_MFD_IQS62X is not set
CONFIG_MFD_JANZ_CMODIO=y
CONFIG_MFD_KEMPLD=y
# CONFIG_MFD_88PM800 is not set
CONFIG_MFD_88PM805=y
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_MAX14577 is not set
# CONFIG_MFD_MAX77620 is not set
# CONFIG_MFD_MAX77650 is not set
# CONFIG_MFD_MAX77686 is not set
CONFIG_MFD_MAX77693=y
# CONFIG_MFD_MAX77714 is not set
# CONFIG_MFD_MAX77843 is not set
CONFIG_MFD_MAX8907=y
CONFIG_MFD_MAX8925=y
CONFIG_MFD_MAX8997=y
# CONFIG_MFD_MAX8998 is not set
# CONFIG_MFD_MT6360 is not set
# CONFIG_MFD_MT6397 is not set
CONFIG_MFD_MENF21BMC=y
# CONFIG_EZX_PCAP is not set
# CONFIG_MFD_CPCAP is not set
# CONFIG_MFD_VIPERBOARD is not set
# CONFIG_MFD_NTXEC is not set
# CONFIG_MFD_RETU is not set
# CONFIG_MFD_PCF50633 is not set
# CONFIG_MFD_PM8XXX is not set
CONFIG_MFD_RDC321X=y
CONFIG_MFD_RT4831=y
CONFIG_MFD_RT5033=y
CONFIG_MFD_RC5T583=y
# CONFIG_MFD_RK808 is not set
# CONFIG_MFD_RN5T618 is not set
# CONFIG_MFD_SEC_CORE is not set
CONFIG_MFD_SI476X_CORE=y
CONFIG_MFD_SIMPLE_MFD_I2C=y
# CONFIG_MFD_SL28CPLD is not set
CONFIG_MFD_SM501=y
CONFIG_MFD_SM501_GPIO=y
CONFIG_MFD_SKY81452=y
# CONFIG_MFD_SC27XX_PMIC is not set
# CONFIG_ABX500_CORE is not set
# CONFIG_MFD_STMPE is not set
# CONFIG_MFD_SUN6I_PRCM is not set
CONFIG_MFD_SYSCON=y
CONFIG_MFD_TI_AM335X_TSCADC=y
CONFIG_MFD_LP3943=y
# CONFIG_MFD_LP8788 is not set
CONFIG_MFD_TI_LMU=y
CONFIG_MFD_PALMAS=y
CONFIG_TPS6105X=y
CONFIG_TPS65010=y
CONFIG_TPS6507X=y
CONFIG_MFD_TPS65086=y
CONFIG_MFD_TPS65090=y
# CONFIG_MFD_TPS65217 is not set
CONFIG_MFD_TI_LP873X=y
# CONFIG_MFD_TI_LP87565 is not set
# CONFIG_MFD_TPS65218 is not set
# CONFIG_MFD_TPS6586X is not set
CONFIG_MFD_TPS65910=y
CONFIG_MFD_TPS65912=y
CONFIG_MFD_TPS65912_I2C=y
CONFIG_MFD_TPS65912_SPI=y
# CONFIG_TWL4030_CORE is not set
CONFIG_TWL6040_CORE=y
# CONFIG_MFD_WL1273_CORE is not set
# CONFIG_MFD_LM3533 is not set
# CONFIG_MFD_TIMBERDALE is not set
# CONFIG_MFD_TC3589X is not set
CONFIG_MFD_TQMX86=y
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
# CONFIG_MFD_WM8400 is not set
CONFIG_MFD_WM831X=y
CONFIG_MFD_WM831X_I2C=y
CONFIG_MFD_WM831X_SPI=y
CONFIG_MFD_WM8350=y
CONFIG_MFD_WM8350_I2C=y
CONFIG_MFD_WM8994=y
# CONFIG_MFD_STW481X is not set
# CONFIG_MFD_ROHM_BD718XX is not set
# CONFIG_MFD_ROHM_BD71828 is not set
# CONFIG_MFD_ROHM_BD957XMUF is not set
# CONFIG_MFD_STM32_LPTIMER is not set
# CONFIG_MFD_STM32_TIMERS is not set
# CONFIG_MFD_STPMIC1 is not set
# CONFIG_MFD_STMFX is not set
CONFIG_MFD_WCD934X=y
CONFIG_MFD_ATC260X=y
CONFIG_MFD_ATC260X_I2C=y
# CONFIG_MFD_KHADAS_MCU is not set
# CONFIG_MFD_ACER_A500_EC is not set
# CONFIG_MFD_QCOM_PM8008 is not set
CONFIG_MFD_INTEL_M10_BMC=y
# CONFIG_MFD_RSMU_I2C is not set
# CONFIG_MFD_RSMU_SPI is not set
# end of Multifunction device drivers

CONFIG_REGULATOR=y
CONFIG_REGULATOR_DEBUG=y
CONFIG_REGULATOR_FIXED_VOLTAGE=y
CONFIG_REGULATOR_VIRTUAL_CONSUMER=y
# CONFIG_REGULATOR_USERSPACE_CONSUMER is not set
CONFIG_REGULATOR_88PG86X=y
CONFIG_REGULATOR_ACT8865=y
# CONFIG_REGULATOR_AD5398 is not set
# CONFIG_REGULATOR_ANATOP is not set
CONFIG_REGULATOR_AAT2870=y
# CONFIG_REGULATOR_ATC260X is not set
CONFIG_REGULATOR_AXP20X=y
CONFIG_REGULATOR_BD9571MWV=y
# CONFIG_REGULATOR_DA903X is not set
# CONFIG_REGULATOR_DA9052 is not set
# CONFIG_REGULATOR_DA9055 is not set
# CONFIG_REGULATOR_DA9062 is not set
# CONFIG_REGULATOR_DA9063 is not set
# CONFIG_REGULATOR_DA9121 is not set
CONFIG_REGULATOR_DA9210=y
# CONFIG_REGULATOR_DA9211 is not set
CONFIG_REGULATOR_FAN53555=y
# CONFIG_REGULATOR_FAN53880 is not set
CONFIG_REGULATOR_GPIO=y
CONFIG_REGULATOR_ISL9305=y
CONFIG_REGULATOR_ISL6271A=y
CONFIG_REGULATOR_LM363X=y
# CONFIG_REGULATOR_LP3971 is not set
CONFIG_REGULATOR_LP3972=y
CONFIG_REGULATOR_LP872X=y
# CONFIG_REGULATOR_LP873X is not set
CONFIG_REGULATOR_LP8755=y
# CONFIG_REGULATOR_LTC3589 is not set
CONFIG_REGULATOR_LTC3676=y
CONFIG_REGULATOR_MAX1586=y
# CONFIG_REGULATOR_MAX77620 is not set
# CONFIG_REGULATOR_MAX77650 is not set
CONFIG_REGULATOR_MAX8649=y
CONFIG_REGULATOR_MAX8660=y
CONFIG_REGULATOR_MAX8893=y
# CONFIG_REGULATOR_MAX8907 is not set
CONFIG_REGULATOR_MAX8925=y
CONFIG_REGULATOR_MAX8952=y
# CONFIG_REGULATOR_MAX8973 is not set
CONFIG_REGULATOR_MAX8997=y
# CONFIG_REGULATOR_MAX20086 is not set
# CONFIG_REGULATOR_MAX77686 is not set
CONFIG_REGULATOR_MAX77693=y
# CONFIG_REGULATOR_MAX77802 is not set
# CONFIG_REGULATOR_MAX77826 is not set
CONFIG_REGULATOR_MC13XXX_CORE=y
CONFIG_REGULATOR_MC13783=y
CONFIG_REGULATOR_MC13892=y
# CONFIG_REGULATOR_MCP16502 is not set
# CONFIG_REGULATOR_MP5416 is not set
CONFIG_REGULATOR_MP8859=y
# CONFIG_REGULATOR_MP886X is not set
# CONFIG_REGULATOR_MPQ7920 is not set
CONFIG_REGULATOR_MT6311=y
CONFIG_REGULATOR_PALMAS=y
# CONFIG_REGULATOR_PBIAS is not set
# CONFIG_REGULATOR_PCA9450 is not set
# CONFIG_REGULATOR_PF8X00 is not set
# CONFIG_REGULATOR_PFUZE100 is not set
CONFIG_REGULATOR_PV88060=y
CONFIG_REGULATOR_PV88080=y
# CONFIG_REGULATOR_PV88090 is not set
# CONFIG_REGULATOR_PWM is not set
# CONFIG_REGULATOR_QCOM_RPMH is not set
# CONFIG_REGULATOR_QCOM_SPMI is not set
# CONFIG_REGULATOR_QCOM_USB_VBUS is not set
# CONFIG_REGULATOR_RASPBERRYPI_TOUCHSCREEN_ATTINY is not set
# CONFIG_REGULATOR_RC5T583 is not set
CONFIG_REGULATOR_RT4801=y
CONFIG_REGULATOR_RT4831=y
CONFIG_REGULATOR_RT5033=y
# CONFIG_REGULATOR_RT5190A is not set
CONFIG_REGULATOR_RT5759=y
# CONFIG_REGULATOR_RT6160 is not set
CONFIG_REGULATOR_RT6245=y
CONFIG_REGULATOR_RTQ2134=y
CONFIG_REGULATOR_RTMV20=y
# CONFIG_REGULATOR_RTQ6752 is not set
# CONFIG_REGULATOR_S2MPA01 is not set
# CONFIG_REGULATOR_S2MPS11 is not set
# CONFIG_REGULATOR_S5M8767 is not set
# CONFIG_REGULATOR_SC2731 is not set
CONFIG_REGULATOR_SKY81452=y
CONFIG_REGULATOR_SLG51000=y
# CONFIG_REGULATOR_STM32_BOOSTER is not set
# CONFIG_REGULATOR_STM32_VREFBUF is not set
# CONFIG_REGULATOR_STM32_PWR is not set
# CONFIG_REGULATOR_TI_ABB is not set
# CONFIG_REGULATOR_STW481X_VMMC is not set
CONFIG_REGULATOR_SY7636A=y
# CONFIG_REGULATOR_SY8106A is not set
# CONFIG_REGULATOR_SY8824X is not set
# CONFIG_REGULATOR_SY8827N is not set
CONFIG_REGULATOR_TPS51632=y
# CONFIG_REGULATOR_TPS6105X is not set
# CONFIG_REGULATOR_TPS62360 is not set
# CONFIG_REGULATOR_TPS6286X is not set
# CONFIG_REGULATOR_TPS65023 is not set
CONFIG_REGULATOR_TPS6507X=y
CONFIG_REGULATOR_TPS65086=y
CONFIG_REGULATOR_TPS65090=y
CONFIG_REGULATOR_TPS65132=y
# CONFIG_REGULATOR_TPS6524X is not set
# CONFIG_REGULATOR_TPS65910 is not set
CONFIG_REGULATOR_TPS65912=y
# CONFIG_REGULATOR_TPS68470 is not set
# CONFIG_REGULATOR_UNIPHIER is not set
# CONFIG_REGULATOR_VCTRL is not set
# CONFIG_REGULATOR_WM831X is not set
# CONFIG_REGULATOR_WM8350 is not set
# CONFIG_REGULATOR_WM8994 is not set
# CONFIG_REGULATOR_QCOM_LABIBB is not set
CONFIG_RC_CORE=y
# CONFIG_LIRC is not set
CONFIG_RC_MAP=y
# CONFIG_RC_DECODERS is not set
CONFIG_RC_DEVICES=y
CONFIG_IR_ENE=y
CONFIG_IR_FINTEK=y
# CONFIG_IR_GPIO_CIR is not set
# CONFIG_IR_HIX5HD2 is not set
CONFIG_IR_IGORPLUGUSB=y
# CONFIG_IR_IGUANA is not set
# CONFIG_IR_IMON is not set
CONFIG_IR_IMON_RAW=y
CONFIG_IR_ITE_CIR=y
CONFIG_IR_MCEUSB=y
# CONFIG_IR_MESON is not set
# CONFIG_IR_MESON_TX is not set
# CONFIG_IR_MTK is not set
CONFIG_IR_NUVOTON=y
CONFIG_IR_REDRAT3=y
# CONFIG_IR_RX51 is not set
CONFIG_IR_SERIAL=y
CONFIG_IR_SERIAL_TRANSMITTER=y
# CONFIG_IR_STREAMZAP is not set
# CONFIG_IR_SUNXI is not set
CONFIG_IR_TOY=y
CONFIG_IR_TTUSBIR=y
# CONFIG_IR_WINBOND_CIR is not set
# CONFIG_RC_ATI_REMOTE is not set
CONFIG_RC_LOOPBACK=y
# CONFIG_RC_ST is not set
CONFIG_RC_XBOX_DVD=y
# CONFIG_IR_IMG is not set
CONFIG_CEC_CORE=y

#
# CEC support
#
CONFIG_MEDIA_CEC_RC=y
CONFIG_MEDIA_CEC_SUPPORT=y
CONFIG_CEC_CH7322=y
# CONFIG_CEC_MESON_AO is not set
# CONFIG_CEC_MESON_G12A_AO is not set
# CONFIG_CEC_GPIO is not set
# CONFIG_CEC_SAMSUNG_S5P is not set
# CONFIG_CEC_STI is not set
# CONFIG_CEC_STM32 is not set
# CONFIG_CEC_TEGRA is not set
# CONFIG_CEC_SECO is not set
# end of CEC support

CONFIG_MEDIA_SUPPORT=y
CONFIG_MEDIA_SUPPORT_FILTER=y
CONFIG_MEDIA_SUBDRV_AUTOSELECT=y

#
# Media device types
#
CONFIG_MEDIA_CAMERA_SUPPORT=y
# CONFIG_MEDIA_ANALOG_TV_SUPPORT is not set
CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
# CONFIG_MEDIA_RADIO_SUPPORT is not set
CONFIG_MEDIA_SDR_SUPPORT=y
CONFIG_MEDIA_PLATFORM_SUPPORT=y
CONFIG_MEDIA_TEST_SUPPORT=y
# end of Media device types

CONFIG_VIDEO_DEV=y
CONFIG_MEDIA_CONTROLLER=y
CONFIG_DVB_CORE=y

#
# Video4Linux options
#
CONFIG_VIDEO_V4L2_I2C=y
CONFIG_VIDEO_V4L2_SUBDEV_API=y
CONFIG_VIDEO_ADV_DEBUG=y
CONFIG_VIDEO_FIXED_MINOR_RANGES=y
CONFIG_V4L2_MEM2MEM_DEV=y
CONFIG_V4L2_FLASH_LED_CLASS=y
CONFIG_V4L2_FWNODE=y
CONFIG_V4L2_ASYNC=y
# end of Video4Linux options

#
# Media controller options
#
# CONFIG_MEDIA_CONTROLLER_DVB is not set
CONFIG_MEDIA_CONTROLLER_REQUEST_API=y
# end of Media controller options

#
# Digital TV options
#
CONFIG_DVB_MMAP=y
# CONFIG_DVB_NET is not set
CONFIG_DVB_MAX_ADAPTERS=16
# CONFIG_DVB_DYNAMIC_MINORS is not set
# CONFIG_DVB_DEMUX_SECTION_LOSS_LOG is not set
CONFIG_DVB_ULE_DEBUG=y
# end of Digital TV options

#
# Media drivers
#

#
# Drivers filtered as selected at 'Filter media drivers'
#

#
# Media drivers
#
# CONFIG_MEDIA_USB_SUPPORT is not set
# CONFIG_MEDIA_PCI_SUPPORT is not set
CONFIG_MEDIA_PLATFORM_DRIVERS=y
# CONFIG_V4L_PLATFORM_DRIVERS is not set
CONFIG_SDR_PLATFORM_DRIVERS=y
# CONFIG_DVB_PLATFORM_DRIVERS is not set
# CONFIG_V4L_MEM2MEM_DRIVERS is not set

#
# Allegro DVT media platform drivers
#

#
# Amlogic media platform drivers
#

#
# Amphion drivers
#

#
# Aspeed media platform drivers
#

#
# Atmel media platform drivers
#

#
# Cadence media platform drivers
#
CONFIG_VIDEO_CADENCE_CSI2RX=y
CONFIG_VIDEO_CADENCE_CSI2TX=y

#
# Chips&Media media platform drivers
#

#
# Intel media platform drivers
#

#
# Marvell media platform drivers
#

#
# Mediatek media platform drivers
#

#
# NVidia media platform drivers
#

#
# NXP media platform drivers
#
# CONFIG_VIDEO_IMX_MIPI_CSIS is not set

#
# Qualcomm media platform drivers
#

#
# Renesas media platform drivers
#
# CONFIG_VIDEO_RCAR_DRIF is not set

#
# Rockchip media platform drivers
#

#
# Samsung media platform drivers
#

#
# STMicroelectronics media platform drivers
#

#
# Sunxi media platform drivers
#

#
# Texas Instruments drivers
#

#
# VIA media platform drivers
#

#
# Xilinx media platform drivers
#
CONFIG_V4L_TEST_DRIVERS=y
CONFIG_VIDEO_VIM2M=y
# CONFIG_VIDEO_VICODEC is not set
# CONFIG_VIDEO_VIMC is not set
# CONFIG_VIDEO_VIVID is not set
# CONFIG_DVB_TEST_DRIVERS is not set
CONFIG_VIDEOBUF2_CORE=y
CONFIG_VIDEOBUF2_V4L2=y
CONFIG_VIDEOBUF2_MEMOPS=y
CONFIG_VIDEOBUF2_VMALLOC=y
CONFIG_VIDEOBUF2_DMA_SG=y
# end of Media drivers

#
# Media ancillary drivers
#

#
# IR I2C driver auto-selected by 'Autoselect ancillary drivers'
#
CONFIG_VIDEO_IR_I2C=y

#
# Camera sensor devices
#
CONFIG_VIDEO_APTINA_PLL=y
CONFIG_VIDEO_AR0521=y
CONFIG_VIDEO_HI556=y
CONFIG_VIDEO_HI846=y
# CONFIG_VIDEO_HI847 is not set
CONFIG_VIDEO_IMX208=y
# CONFIG_VIDEO_IMX214 is not set
CONFIG_VIDEO_IMX219=y
CONFIG_VIDEO_IMX258=y
CONFIG_VIDEO_IMX274=y
# CONFIG_VIDEO_IMX290 is not set
# CONFIG_VIDEO_IMX319 is not set
# CONFIG_VIDEO_IMX334 is not set
# CONFIG_VIDEO_IMX335 is not set
CONFIG_VIDEO_IMX355=y
# CONFIG_VIDEO_IMX412 is not set
CONFIG_VIDEO_MAX9271_LIB=y
# CONFIG_VIDEO_MT9M001 is not set
CONFIG_VIDEO_MT9M032=y
CONFIG_VIDEO_MT9M111=y
CONFIG_VIDEO_MT9P031=y
# CONFIG_VIDEO_MT9T001 is not set
CONFIG_VIDEO_MT9T112=y
CONFIG_VIDEO_MT9V011=y
CONFIG_VIDEO_MT9V032=y
# CONFIG_VIDEO_MT9V111 is not set
CONFIG_VIDEO_NOON010PC30=y
# CONFIG_VIDEO_OG01A1B is not set
# CONFIG_VIDEO_OV02A10 is not set
CONFIG_VIDEO_OV08D10=y
# CONFIG_VIDEO_OV13858 is not set
CONFIG_VIDEO_OV13B10=y
# CONFIG_VIDEO_OV2640 is not set
CONFIG_VIDEO_OV2659=y
CONFIG_VIDEO_OV2680=y
CONFIG_VIDEO_OV2685=y
# CONFIG_VIDEO_OV2740 is not set
# CONFIG_VIDEO_OV5640 is not set
# CONFIG_VIDEO_OV5645 is not set
# CONFIG_VIDEO_OV5647 is not set
CONFIG_VIDEO_OV5670=y
# CONFIG_VIDEO_OV5675 is not set
CONFIG_VIDEO_OV5693=y
CONFIG_VIDEO_OV5695=y
CONFIG_VIDEO_OV6650=y
# CONFIG_VIDEO_OV7251 is not set
CONFIG_VIDEO_OV7640=y
CONFIG_VIDEO_OV7670=y
CONFIG_VIDEO_OV772X=y
CONFIG_VIDEO_OV7740=y
CONFIG_VIDEO_OV8856=y
# CONFIG_VIDEO_OV9282 is not set
CONFIG_VIDEO_OV9640=y
CONFIG_VIDEO_OV9650=y
# CONFIG_VIDEO_OV9734 is not set
CONFIG_VIDEO_RDACM20=y
# CONFIG_VIDEO_RDACM21 is not set
# CONFIG_VIDEO_RJ54N1 is not set
# CONFIG_VIDEO_S5C73M3 is not set
CONFIG_VIDEO_S5K4ECGX=y
# CONFIG_VIDEO_S5K5BAF is not set
CONFIG_VIDEO_S5K6A3=y
CONFIG_VIDEO_S5K6AA=y
# CONFIG_VIDEO_SR030PC30 is not set
# CONFIG_VIDEO_VS6624 is not set
# CONFIG_VIDEO_CCS is not set
# CONFIG_VIDEO_ET8EK8 is not set
CONFIG_VIDEO_M5MOLS=y
# end of Camera sensor devices

#
# Lens drivers
#
CONFIG_VIDEO_AD5820=y
CONFIG_VIDEO_AK7375=y
# CONFIG_VIDEO_DW9714 is not set
CONFIG_VIDEO_DW9768=y
CONFIG_VIDEO_DW9807_VCM=y
# end of Lens drivers

#
# Flash devices
#
CONFIG_VIDEO_ADP1653=y
# CONFIG_VIDEO_LM3560 is not set
# CONFIG_VIDEO_LM3646 is not set
# end of Flash devices

#
# Audio decoders, processors and mixers
#
# CONFIG_VIDEO_CS3308 is not set
# CONFIG_VIDEO_CS5345 is not set
CONFIG_VIDEO_CS53L32A=y
CONFIG_VIDEO_MSP3400=y
# CONFIG_VIDEO_SONY_BTF_MPX is not set
CONFIG_VIDEO_TDA7432=y
CONFIG_VIDEO_TDA9840=y
# CONFIG_VIDEO_TEA6415C is not set
CONFIG_VIDEO_TEA6420=y
CONFIG_VIDEO_TLV320AIC23B=y
CONFIG_VIDEO_TVAUDIO=y
# CONFIG_VIDEO_UDA1342 is not set
CONFIG_VIDEO_VP27SMPX=y
CONFIG_VIDEO_WM8739=y
CONFIG_VIDEO_WM8775=y
# end of Audio decoders, processors and mixers

#
# RDS decoders
#
# CONFIG_VIDEO_SAA6588 is not set
# end of RDS decoders

#
# Video decoders
#
CONFIG_VIDEO_ADV7180=y
CONFIG_VIDEO_ADV7183=y
# CONFIG_VIDEO_ADV748X is not set
CONFIG_VIDEO_ADV7604=y
# CONFIG_VIDEO_ADV7604_CEC is not set
# CONFIG_VIDEO_ADV7842 is not set
CONFIG_VIDEO_BT819=y
# CONFIG_VIDEO_BT856 is not set
CONFIG_VIDEO_BT866=y
# CONFIG_VIDEO_ISL7998X is not set
CONFIG_VIDEO_KS0127=y
# CONFIG_VIDEO_MAX9286 is not set
CONFIG_VIDEO_ML86V7667=y
CONFIG_VIDEO_SAA7110=y
CONFIG_VIDEO_SAA711X=y
CONFIG_VIDEO_TC358743=y
# CONFIG_VIDEO_TC358743_CEC is not set
CONFIG_VIDEO_TVP514X=y
CONFIG_VIDEO_TVP5150=y
CONFIG_VIDEO_TVP7002=y
CONFIG_VIDEO_TW2804=y
# CONFIG_VIDEO_TW9903 is not set
CONFIG_VIDEO_TW9906=y
# CONFIG_VIDEO_TW9910 is not set
CONFIG_VIDEO_VPX3220=y

#
# Video and audio decoders
#
# CONFIG_VIDEO_SAA717X is not set
CONFIG_VIDEO_CX25840=y
# end of Video decoders

#
# Video encoders
#
CONFIG_VIDEO_AD9389B=y
CONFIG_VIDEO_ADV7170=y
CONFIG_VIDEO_ADV7175=y
# CONFIG_VIDEO_ADV7343 is not set
# CONFIG_VIDEO_ADV7393 is not set
CONFIG_VIDEO_ADV7511=y
# CONFIG_VIDEO_ADV7511_CEC is not set
# CONFIG_VIDEO_AK881X is not set
CONFIG_VIDEO_SAA7127=y
CONFIG_VIDEO_SAA7185=y
CONFIG_VIDEO_THS8200=y
# end of Video encoders

#
# Video improvement chips
#
CONFIG_VIDEO_UPD64031A=y
CONFIG_VIDEO_UPD64083=y
# end of Video improvement chips

#
# Audio/Video compression chips
#
# CONFIG_VIDEO_SAA6752HS is not set
# end of Audio/Video compression chips

#
# SDR tuner chips
#
# CONFIG_SDR_MAX2175 is not set
# end of SDR tuner chips

#
# Miscellaneous helper chips
#
CONFIG_VIDEO_I2C=y
CONFIG_VIDEO_M52790=y
CONFIG_VIDEO_ST_MIPID02=y
CONFIG_VIDEO_THS7303=y
# end of Miscellaneous helper chips

#
# Media SPI Adapters
#
CONFIG_CXD2880_SPI_DRV=y
CONFIG_VIDEO_GS1662=y
# end of Media SPI Adapters

CONFIG_MEDIA_TUNER=y

#
# Customize TV tuners
#
# CONFIG_MEDIA_TUNER_E4000 is not set
# CONFIG_MEDIA_TUNER_FC0011 is not set
# CONFIG_MEDIA_TUNER_FC0012 is not set
CONFIG_MEDIA_TUNER_FC0013=y
CONFIG_MEDIA_TUNER_FC2580=y
# CONFIG_MEDIA_TUNER_IT913X is not set
# CONFIG_MEDIA_TUNER_M88RS6000T is not set
# CONFIG_MEDIA_TUNER_MAX2165 is not set
CONFIG_MEDIA_TUNER_MC44S803=y
CONFIG_MEDIA_TUNER_MSI001=y
CONFIG_MEDIA_TUNER_MT2060=y
CONFIG_MEDIA_TUNER_MT2063=y
CONFIG_MEDIA_TUNER_MT20XX=y
CONFIG_MEDIA_TUNER_MT2131=y
CONFIG_MEDIA_TUNER_MT2266=y
CONFIG_MEDIA_TUNER_MXL301RF=y
CONFIG_MEDIA_TUNER_MXL5005S=y
CONFIG_MEDIA_TUNER_MXL5007T=y
# CONFIG_MEDIA_TUNER_QM1D1B0004 is not set
# CONFIG_MEDIA_TUNER_QM1D1C0042 is not set
CONFIG_MEDIA_TUNER_QT1010=y
# CONFIG_MEDIA_TUNER_R820T is not set
CONFIG_MEDIA_TUNER_SI2157=y
CONFIG_MEDIA_TUNER_SIMPLE=y
CONFIG_MEDIA_TUNER_TDA18212=y
# CONFIG_MEDIA_TUNER_TDA18218 is not set
# CONFIG_MEDIA_TUNER_TDA18250 is not set
CONFIG_MEDIA_TUNER_TDA18271=y
CONFIG_MEDIA_TUNER_TDA827X=y
CONFIG_MEDIA_TUNER_TDA8290=y
CONFIG_MEDIA_TUNER_TDA9887=y
CONFIG_MEDIA_TUNER_TEA5761=y
CONFIG_MEDIA_TUNER_TEA5767=y
CONFIG_MEDIA_TUNER_TUA9001=y
CONFIG_MEDIA_TUNER_XC2028=y
CONFIG_MEDIA_TUNER_XC4000=y
CONFIG_MEDIA_TUNER_XC5000=y
# end of Customize TV tuners

#
# Customise DVB Frontends
#

#
# Multistandard (satellite) frontends
#
CONFIG_DVB_M88DS3103=y
# CONFIG_DVB_MXL5XX is not set
# CONFIG_DVB_STB0899 is not set
# CONFIG_DVB_STB6100 is not set
# CONFIG_DVB_STV090x is not set
CONFIG_DVB_STV0910=y
# CONFIG_DVB_STV6110x is not set
CONFIG_DVB_STV6111=y

#
# Multistandard (cable + terrestrial) frontends
#
# CONFIG_DVB_DRXK is not set
CONFIG_DVB_MN88472=y
# CONFIG_DVB_MN88473 is not set
# CONFIG_DVB_SI2165 is not set
CONFIG_DVB_TDA18271C2DD=y

#
# DVB-S (satellite) frontends
#
CONFIG_DVB_CX24110=y
CONFIG_DVB_CX24116=y
# CONFIG_DVB_CX24117 is not set
# CONFIG_DVB_CX24120 is not set
# CONFIG_DVB_CX24123 is not set
# CONFIG_DVB_DS3000 is not set
CONFIG_DVB_MB86A16=y
# CONFIG_DVB_MT312 is not set
CONFIG_DVB_S5H1420=y
CONFIG_DVB_SI21XX=y
CONFIG_DVB_STB6000=y
CONFIG_DVB_STV0288=y
CONFIG_DVB_STV0299=y
CONFIG_DVB_STV0900=y
CONFIG_DVB_STV6110=y
CONFIG_DVB_TDA10071=y
CONFIG_DVB_TDA10086=y
# CONFIG_DVB_TDA8083 is not set
CONFIG_DVB_TDA8261=y
# CONFIG_DVB_TDA826X is not set
# CONFIG_DVB_TS2020 is not set
# CONFIG_DVB_TUA6100 is not set
CONFIG_DVB_TUNER_CX24113=y
CONFIG_DVB_TUNER_ITD1000=y
CONFIG_DVB_VES1X93=y
CONFIG_DVB_ZL10036=y
CONFIG_DVB_ZL10039=y

#
# DVB-T (terrestrial) frontends
#
# CONFIG_DVB_AF9013 is not set
CONFIG_DVB_CX22700=y
CONFIG_DVB_CX22702=y
# CONFIG_DVB_CXD2820R is not set
CONFIG_DVB_CXD2841ER=y
CONFIG_DVB_DIB3000MB=y
CONFIG_DVB_DIB3000MC=y
CONFIG_DVB_DIB7000M=y
CONFIG_DVB_DIB7000P=y
CONFIG_DVB_DIB9000=y
# CONFIG_DVB_DRXD is not set
CONFIG_DVB_EC100=y
CONFIG_DVB_L64781=y
CONFIG_DVB_MT352=y
CONFIG_DVB_NXT6000=y
CONFIG_DVB_RTL2830=y
CONFIG_DVB_RTL2832=y
CONFIG_DVB_RTL2832_SDR=y
# CONFIG_DVB_S5H1432 is not set
# CONFIG_DVB_SI2168 is not set
# CONFIG_DVB_SP887X is not set
CONFIG_DVB_STV0367=y
# CONFIG_DVB_TDA10048 is not set
# CONFIG_DVB_TDA1004X is not set
CONFIG_DVB_ZD1301_DEMOD=y
# CONFIG_DVB_ZL10353 is not set
CONFIG_DVB_CXD2880=y

#
# DVB-C (cable) frontends
#
CONFIG_DVB_STV0297=y
CONFIG_DVB_TDA10021=y
# CONFIG_DVB_TDA10023 is not set
CONFIG_DVB_VES1820=y

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#
CONFIG_DVB_AU8522=y
CONFIG_DVB_AU8522_DTV=y
CONFIG_DVB_AU8522_V4L=y
CONFIG_DVB_BCM3510=y
CONFIG_DVB_LG2160=y
# CONFIG_DVB_LGDT3305 is not set
CONFIG_DVB_LGDT3306A=y
CONFIG_DVB_LGDT330X=y
# CONFIG_DVB_MXL692 is not set
CONFIG_DVB_NXT200X=y
CONFIG_DVB_OR51132=y
CONFIG_DVB_OR51211=y
# CONFIG_DVB_S5H1409 is not set
CONFIG_DVB_S5H1411=y

#
# ISDB-T (terrestrial) frontends
#
CONFIG_DVB_DIB8000=y
CONFIG_DVB_MB86A20S=y
CONFIG_DVB_S921=y

#
# ISDB-S (satellite) & ISDB-T (terrestrial) frontends
#
# CONFIG_DVB_MN88443X is not set
CONFIG_DVB_TC90522=y

#
# Digital terrestrial only tuners/PLL
#
# CONFIG_DVB_PLL is not set
# CONFIG_DVB_TUNER_DIB0070 is not set
# CONFIG_DVB_TUNER_DIB0090 is not set

#
# SEC control devices for DVB-S
#
CONFIG_DVB_A8293=y
CONFIG_DVB_AF9033=y
# CONFIG_DVB_ASCOT2E is not set
# CONFIG_DVB_ATBM8830 is not set
CONFIG_DVB_HELENE=y
CONFIG_DVB_HORUS3A=y
# CONFIG_DVB_ISL6405 is not set
CONFIG_DVB_ISL6421=y
# CONFIG_DVB_ISL6423 is not set
CONFIG_DVB_IX2505V=y
CONFIG_DVB_LGS8GL5=y
# CONFIG_DVB_LGS8GXX is not set
# CONFIG_DVB_LNBH25 is not set
# CONFIG_DVB_LNBH29 is not set
CONFIG_DVB_LNBP21=y
CONFIG_DVB_LNBP22=y
# CONFIG_DVB_M88RS2000 is not set
CONFIG_DVB_TDA665x=y
CONFIG_DVB_DRX39XYJ=y

#
# Common Interface (EN50221) controller drivers
#
CONFIG_DVB_CXD2099=y
CONFIG_DVB_SP2=y
# end of Customise DVB Frontends

#
# Tools to develop new frontends
#
CONFIG_DVB_DUMMY_FE=y
# end of Media ancillary drivers

#
# Graphics support
#
CONFIG_APERTURE_HELPERS=y
# CONFIG_IMX_IPUV3_CORE is not set
# CONFIG_DRM is not set
CONFIG_DRM_DEBUG_MODESET_LOCK=y

#
# ARM devices
#
# end of ARM devices

CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
CONFIG_FIRMWARE_EDID=y
CONFIG_FB_DDC=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=y
CONFIG_FB_SYS_COPYAREA=y
CONFIG_FB_SYS_IMAGEBLIT=y
CONFIG_FB_FOREIGN_ENDIAN=y
CONFIG_FB_BOTH_ENDIAN=y
# CONFIG_FB_BIG_ENDIAN is not set
# CONFIG_FB_LITTLE_ENDIAN is not set
CONFIG_FB_SYS_FOPS=y
CONFIG_FB_DEFERRED_IO=y
CONFIG_FB_SVGALIB=y
CONFIG_FB_BACKLIGHT=y
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
CONFIG_FB_CIRRUS=y
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CLPS711X is not set
# CONFIG_FB_IMX is not set
CONFIG_FB_CYBER2000=y
CONFIG_FB_CYBER2000_DDC=y
# CONFIG_FB_ARC is not set
# CONFIG_FB_CONTROL is not set
CONFIG_FB_ASILIANT=y
# CONFIG_FB_IMSTT is not set
CONFIG_FB_EFI=y
# CONFIG_FB_GBE is not set
# CONFIG_FB_PVR2 is not set
CONFIG_FB_OPENCORES=y
CONFIG_FB_S1D13XXX=y
# CONFIG_FB_ATMEL is not set
CONFIG_FB_NVIDIA=y
# CONFIG_FB_NVIDIA_I2C is not set
# CONFIG_FB_NVIDIA_DEBUG is not set
CONFIG_FB_NVIDIA_BACKLIGHT=y
CONFIG_FB_RIVA=y
CONFIG_FB_RIVA_I2C=y
CONFIG_FB_RIVA_DEBUG=y
CONFIG_FB_RIVA_BACKLIGHT=y
CONFIG_FB_I740=y
CONFIG_FB_MATROX=y
# CONFIG_FB_MATROX_MILLENIUM is not set
# CONFIG_FB_MATROX_MYSTIQUE is not set
# CONFIG_FB_MATROX_G is not set
CONFIG_FB_MATROX_I2C=y
CONFIG_FB_RADEON=y
CONFIG_FB_RADEON_I2C=y
# CONFIG_FB_RADEON_BACKLIGHT is not set
CONFIG_FB_RADEON_DEBUG=y
CONFIG_FB_ATY128=y
# CONFIG_FB_ATY128_BACKLIGHT is not set
CONFIG_FB_ATY=y
# CONFIG_FB_ATY_CT is not set
# CONFIG_FB_ATY_GX is not set
# CONFIG_FB_ATY_BACKLIGHT is not set
CONFIG_FB_S3=y
CONFIG_FB_S3_DDC=y
CONFIG_FB_SAVAGE=y
# CONFIG_FB_SAVAGE_I2C is not set
# CONFIG_FB_SAVAGE_ACCEL is not set
CONFIG_FB_SIS=y
CONFIG_FB_SIS_300=y
# CONFIG_FB_SIS_315 is not set
# CONFIG_FB_VIA is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
CONFIG_FB_VOODOO1=y
CONFIG_FB_VT8623=y
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
# CONFIG_FB_WM8505 is not set
# CONFIG_FB_PXA168 is not set
# CONFIG_FB_W100 is not set
# CONFIG_FB_SH_MOBILE_LCDC is not set
# CONFIG_FB_TMIO is not set
# CONFIG_FB_S3C is not set
CONFIG_FB_SM501=y
CONFIG_FB_SMSCUFX=y
CONFIG_FB_UDL=y
CONFIG_FB_IBM_GXT4500=y
# CONFIG_FB_GOLDFISH is not set
# CONFIG_FB_DA8XX is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_FB_METRONOME is not set
CONFIG_FB_MB862XX=y
CONFIG_FB_MB862XX_PCI_GDC=y
# CONFIG_FB_MB862XX_I2C is not set
# CONFIG_FB_BROADSHEET is not set
# CONFIG_FB_SIMPLE is not set
CONFIG_FB_SSD1307=y
CONFIG_FB_SM712=y
CONFIG_FB_OMAP_LCD_H3=y
# CONFIG_FB_OMAP2 is not set
# CONFIG_MMP_DISP is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=y
CONFIG_LCD_L4F00242T03=y
# CONFIG_LCD_LMS283GF05 is not set
CONFIG_LCD_LTV350QV=y
CONFIG_LCD_ILI922X=y
CONFIG_LCD_ILI9320=y
CONFIG_LCD_TDO24M=y
# CONFIG_LCD_VGG2432A4 is not set
# CONFIG_LCD_PLATFORM is not set
# CONFIG_LCD_AMS369FG06 is not set
CONFIG_LCD_LMS501KF03=y
CONFIG_LCD_HX8357=y
# CONFIG_LCD_OTM3225A is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
CONFIG_BACKLIGHT_KTD253=y
# CONFIG_BACKLIGHT_OMAP1 is not set
CONFIG_BACKLIGHT_PWM=y
# CONFIG_BACKLIGHT_DA903X is not set
CONFIG_BACKLIGHT_DA9052=y
# CONFIG_BACKLIGHT_MAX8925 is not set
# CONFIG_BACKLIGHT_QCOM_WLED is not set
# CONFIG_BACKLIGHT_RT4831 is not set
# CONFIG_BACKLIGHT_WM831X is not set
CONFIG_BACKLIGHT_ADP5520=y
# CONFIG_BACKLIGHT_ADP8860 is not set
# CONFIG_BACKLIGHT_ADP8870 is not set
# CONFIG_BACKLIGHT_AAT2870 is not set
CONFIG_BACKLIGHT_LM3630A=y
CONFIG_BACKLIGHT_LM3639=y
# CONFIG_BACKLIGHT_LP855X is not set
CONFIG_BACKLIGHT_SKY81452=y
CONFIG_BACKLIGHT_GPIO=y
# CONFIG_BACKLIGHT_LV5207LP is not set
# CONFIG_BACKLIGHT_BD6107 is not set
CONFIG_BACKLIGHT_ARCXCNN=y
# CONFIG_BACKLIGHT_LED is not set
# end of Backlight & LCD device support

CONFIG_VGASTATE=y
CONFIG_HDMI=y
CONFIG_LOGO=y
CONFIG_LOGO_LINUX_MONO=y
# CONFIG_LOGO_LINUX_VGA16 is not set
CONFIG_LOGO_LINUX_CLUT224=y
# end of Graphics support

CONFIG_SOUND=y
CONFIG_SND=y
CONFIG_SND_TIMER=y
CONFIG_SND_PCM=y
CONFIG_SND_HWDEP=y
CONFIG_SND_RAWMIDI=y
# CONFIG_SND_OSSEMUL is not set
CONFIG_SND_PCM_TIMER=y
CONFIG_SND_HRTIMER=y
# CONFIG_SND_DYNAMIC_MINORS is not set
# CONFIG_SND_SUPPORT_OLD_API is not set
CONFIG_SND_VERBOSE_PRINTK=y
CONFIG_SND_CTL_FAST_LOOKUP=y
# CONFIG_SND_DEBUG is not set
CONFIG_SND_CTL_INPUT_VALIDATION=y
CONFIG_SND_VMASTER=y
# CONFIG_SND_SEQUENCER is not set
CONFIG_SND_DRIVERS=y
CONFIG_SND_DUMMY=y
CONFIG_SND_ALOOP=y
CONFIG_SND_MTPAV=y
CONFIG_SND_SERIAL_U16550=y
# CONFIG_SND_MPU401 is not set
# CONFIG_SND_PCI is not set

#
# HD-Audio
#
# end of HD-Audio

CONFIG_SND_HDA_PREALLOC_SIZE=64
CONFIG_SND_SPI=y
CONFIG_SND_USB=y
CONFIG_SND_USB_AUDIO=y
CONFIG_SND_USB_AUDIO_USE_MEDIA_CONTROLLER=y
# CONFIG_SND_USB_UA101 is not set
CONFIG_SND_USB_CAIAQ=y
CONFIG_SND_USB_CAIAQ_INPUT=y
# CONFIG_SND_USB_US122L is not set
CONFIG_SND_USB_6FIRE=y
CONFIG_SND_USB_HIFACE=y
CONFIG_SND_BCD2000=y
CONFIG_SND_USB_LINE6=y
CONFIG_SND_USB_POD=y
# CONFIG_SND_USB_PODHD is not set
CONFIG_SND_USB_TONEPORT=y
CONFIG_SND_USB_VARIAX=y
CONFIG_SND_PCMCIA=y
# CONFIG_SND_VXPOCKET is not set
CONFIG_SND_PDAUDIOCF=y
# CONFIG_SND_SOC is not set
# CONFIG_SND_VIRTIO is not set

#
# HID support
#
CONFIG_HID=y
# CONFIG_HID_BATTERY_STRENGTH is not set
# CONFIG_HIDRAW is not set
# CONFIG_UHID is not set
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
CONFIG_HID_A4TECH=y
# CONFIG_HID_ACCUTOUCH is not set
CONFIG_HID_ACRUX=y
# CONFIG_HID_ACRUX_FF is not set
CONFIG_HID_APPLE=y
CONFIG_HID_APPLEIR=y
CONFIG_HID_ASUS=y
CONFIG_HID_AUREAL=y
CONFIG_HID_BELKIN=y
# CONFIG_HID_BETOP_FF is not set
# CONFIG_HID_BIGBEN_FF is not set
# CONFIG_HID_CHERRY is not set
CONFIG_HID_CHICONY=y
# CONFIG_HID_CORSAIR is not set
CONFIG_HID_COUGAR=y
CONFIG_HID_MACALLY=y
CONFIG_HID_PRODIKEYS=y
CONFIG_HID_CMEDIA=y
# CONFIG_HID_CREATIVE_SB0540 is not set
CONFIG_HID_CYPRESS=y
CONFIG_HID_DRAGONRISE=y
# CONFIG_DRAGONRISE_FF is not set
# CONFIG_HID_EMS_FF is not set
CONFIG_HID_ELAN=y
CONFIG_HID_ELECOM=y
# CONFIG_HID_ELO is not set
# CONFIG_HID_EZKEY is not set
CONFIG_HID_GEMBIRD=y
# CONFIG_HID_GFRM is not set
CONFIG_HID_GLORIOUS=y
CONFIG_HID_HOLTEK=y
CONFIG_HOLTEK_FF=y
CONFIG_HID_VIVALDI_COMMON=y
CONFIG_HID_VIVALDI=y
# CONFIG_HID_GT683R is not set
# CONFIG_HID_KEYTOUCH is not set
CONFIG_HID_KYE=y
# CONFIG_HID_UCLOGIC is not set
CONFIG_HID_WALTOP=y
CONFIG_HID_VIEWSONIC=y
CONFIG_HID_XIAOMI=y
# CONFIG_HID_GYRATION is not set
CONFIG_HID_ICADE=y
CONFIG_HID_ITE=y
CONFIG_HID_JABRA=y
CONFIG_HID_TWINHAN=y
CONFIG_HID_KENSINGTON=y
CONFIG_HID_LCPOWER=y
CONFIG_HID_LED=y
# CONFIG_HID_LENOVO is not set
CONFIG_HID_LETSKETCH=y
# CONFIG_HID_LOGITECH is not set
CONFIG_HID_MAGICMOUSE=y
CONFIG_HID_MALTRON=y
CONFIG_HID_MAYFLASH=y
# CONFIG_HID_MEGAWORLD_FF is not set
# CONFIG_HID_REDRAGON is not set
CONFIG_HID_MICROSOFT=y
# CONFIG_HID_MONTEREY is not set
CONFIG_HID_MULTITOUCH=y
CONFIG_HID_NINTENDO=y
# CONFIG_NINTENDO_FF is not set
CONFIG_HID_NTI=y
CONFIG_HID_NTRIG=y
CONFIG_HID_ORTEK=y
CONFIG_HID_PANTHERLORD=y
# CONFIG_PANTHERLORD_FF is not set
CONFIG_HID_PENMOUNT=y
CONFIG_HID_PETALYNX=y
# CONFIG_HID_PICOLCD is not set
CONFIG_HID_PLANTRONICS=y
# CONFIG_HID_PLAYSTATION is not set
CONFIG_HID_RAZER=y
# CONFIG_HID_PRIMAX is not set
CONFIG_HID_RETRODE=y
# CONFIG_HID_ROCCAT is not set
# CONFIG_HID_SAITEK is not set
CONFIG_HID_SAMSUNG=y
# CONFIG_HID_SEMITEK is not set
CONFIG_HID_SIGMAMICRO=y
CONFIG_HID_SONY=y
# CONFIG_SONY_FF is not set
CONFIG_HID_SPEEDLINK=y
CONFIG_HID_STEAM=y
CONFIG_HID_STEELSERIES=y
# CONFIG_HID_SUNPLUS is not set
CONFIG_HID_RMI=y
CONFIG_HID_GREENASIA=y
CONFIG_GREENASIA_FF=y
# CONFIG_HID_SMARTJOYPLUS is not set
CONFIG_HID_TIVO=y
CONFIG_HID_TOPSEED=y
# CONFIG_HID_THINGM is not set
# CONFIG_HID_THRUSTMASTER is not set
# CONFIG_HID_UDRAW_PS3 is not set
# CONFIG_HID_U2FZERO is not set
# CONFIG_HID_WACOM is not set
# CONFIG_HID_WIIMOTE is not set
CONFIG_HID_XINMO=y
# CONFIG_HID_ZEROPLUS is not set
CONFIG_HID_ZYDACRON=y
# CONFIG_HID_SENSOR_HUB is not set
CONFIG_HID_ALPS=y
CONFIG_HID_MCP2221=y
# end of Special HID drivers

#
# USB HID support
#
CONFIG_USB_HID=y
# CONFIG_HID_PID is not set
# CONFIG_USB_HIDDEV is not set
# end of USB HID support

#
# I2C HID support
#
# CONFIG_I2C_HID_ACPI is not set
# CONFIG_I2C_HID_OF is not set
# CONFIG_I2C_HID_OF_ELAN is not set
# CONFIG_I2C_HID_OF_GOODIX is not set
# end of I2C HID support

#
# Intel ISH HID support
#
# end of Intel ISH HID support

#
# AMD SFH HID Support
#
# CONFIG_AMD_SFH_HID is not set
# end of AMD SFH HID Support
# end of HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
CONFIG_USB_LED_TRIG=y
CONFIG_USB_ULPI_BUS=y
# CONFIG_USB_CONN_GPIO is not set
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
# CONFIG_USB_PCI is not set
# CONFIG_USB_ANNOUNCE_NEW_DEVICES is not set

#
# Miscellaneous USB options
#
# CONFIG_USB_DEFAULT_PERSIST is not set
CONFIG_USB_FEW_INIT_RETRIES=y
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_OTG_PRODUCTLIST is not set
# CONFIG_USB_OTG_DISABLE_EXTERNAL_HUB is not set
# CONFIG_USB_LEDS_TRIGGER_USBPORT is not set
CONFIG_USB_AUTOSUSPEND_DELAY=2
# CONFIG_USB_MON is not set

#
# USB Host Controller Drivers
#
CONFIG_USB_C67X00_HCD=y
CONFIG_USB_XHCI_HCD=y
CONFIG_USB_XHCI_PCI_RENESAS=y
CONFIG_USB_XHCI_PLATFORM=y
# CONFIG_USB_XHCI_HISTB is not set
# CONFIG_USB_XHCI_MTK is not set
# CONFIG_USB_XHCI_MVEBU is not set
# CONFIG_USB_XHCI_RCAR is not set
# CONFIG_USB_BRCMSTB is not set
# CONFIG_USB_EHCI_HCD is not set
CONFIG_USB_OXU210HP_HCD=y
CONFIG_USB_ISP116X_HCD=y
# CONFIG_USB_ISP1362_HCD is not set
CONFIG_USB_FOTG210_HCD=y
# CONFIG_USB_MAX3421_HCD is not set
CONFIG_USB_OHCI_HCD=y
# CONFIG_USB_OHCI_HCD_SPEAR is not set
# CONFIG_USB_OHCI_HCD_STI is not set
# CONFIG_USB_OHCI_HCD_S3C2410 is not set
CONFIG_USB_OHCI_HCD_LPC32XX=y
# CONFIG_USB_OHCI_HCD_AT91 is not set
# CONFIG_USB_OHCI_HCD_OMAP3 is not set
# CONFIG_USB_OHCI_HCD_DAVINCI is not set
# CONFIG_USB_OHCI_SH is not set
# CONFIG_USB_OHCI_EXYNOS is not set
# CONFIG_USB_CNS3XXX_OHCI is not set
CONFIG_USB_OHCI_HCD_PLATFORM=y
CONFIG_USB_U132_HCD=y
CONFIG_USB_SL811_HCD=y
CONFIG_USB_SL811_HCD_ISO=y
CONFIG_USB_SL811_CS=y
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_HCD_BCMA is not set
CONFIG_USB_HCD_TEST_MODE=y
# CONFIG_USB_RENESAS_USBHS is not set

#
# USB Device Class drivers
#
CONFIG_USB_PRINTER=y
CONFIG_USB_WDM=y
CONFIG_USB_TMC=y

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#

#
# USB Imaging devices
#
CONFIG_USB_MDC800=y
CONFIG_USBIP_CORE=y
CONFIG_USBIP_VHCI_HCD=y
CONFIG_USBIP_VHCI_HC_PORTS=8
CONFIG_USBIP_VHCI_NR_HCS=1
# CONFIG_USBIP_HOST is not set
# CONFIG_USBIP_VUDC is not set
# CONFIG_USBIP_DEBUG is not set
CONFIG_USB_CDNS_SUPPORT=y
# CONFIG_USB_CDNS3 is not set
# CONFIG_USB_MTU3 is not set
CONFIG_USB_MUSB_HDRC=y
# CONFIG_USB_MUSB_HOST is not set
CONFIG_USB_MUSB_GADGET=y
# CONFIG_USB_MUSB_DUAL_ROLE is not set

#
# Platform Glue Layer
#
# CONFIG_USB_MUSB_TUSB6010 is not set
# CONFIG_USB_MUSB_DSPS is not set
# CONFIG_USB_MUSB_UX500 is not set

#
# MUSB DMA mode
#
# CONFIG_MUSB_PIO_ONLY is not set
# CONFIG_USB_DWC3 is not set
CONFIG_USB_DWC2=y
CONFIG_USB_DWC2_HOST=y

#
# Gadget/Dual-role mode requires USB Gadget support to be enabled
#
# CONFIG_USB_DWC2_PERIPHERAL is not set
# CONFIG_USB_DWC2_DUAL_ROLE is not set
CONFIG_USB_DWC2_DEBUG=y
CONFIG_USB_DWC2_VERBOSE=y
# CONFIG_USB_DWC2_TRACK_MISSED_SOFS is not set
# CONFIG_USB_DWC2_DEBUG_PERIODIC is not set
CONFIG_USB_CHIPIDEA=y
CONFIG_USB_CHIPIDEA_UDC=y
CONFIG_USB_CHIPIDEA_MSM=y
CONFIG_USB_CHIPIDEA_IMX=y
CONFIG_USB_CHIPIDEA_GENERIC=y
CONFIG_USB_CHIPIDEA_TEGRA=y
CONFIG_USB_ISP1760=y
CONFIG_USB_ISP1760_HCD=y
CONFIG_USB_ISP1760_HOST_ROLE=y
# CONFIG_USB_ISP1760_GADGET_ROLE is not set
# CONFIG_USB_ISP1760_DUAL_ROLE is not set

#
# USB port drivers
#

#
# USB Miscellaneous drivers
#
CONFIG_USB_EMI62=y
CONFIG_USB_EMI26=y
CONFIG_USB_ADUTUX=y
# CONFIG_USB_SEVSEG is not set
CONFIG_USB_LEGOTOWER=y
CONFIG_USB_LCD=y
CONFIG_USB_CYPRESS_CY7C63=y
CONFIG_USB_CYTHERM=y
CONFIG_USB_IDMOUSE=y
CONFIG_USB_FTDI_ELAN=y
# CONFIG_USB_APPLEDISPLAY is not set
# CONFIG_USB_QCOM_EUD is not set
CONFIG_APPLE_MFI_FASTCHARGE=y
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_LD is not set
CONFIG_USB_TRANCEVIBRATOR=y
# CONFIG_USB_IOWARRIOR is not set
# CONFIG_USB_TEST is not set
CONFIG_USB_EHSET_TEST_FIXTURE=y
CONFIG_USB_ISIGHTFW=y
# CONFIG_USB_YUREX is not set
CONFIG_USB_EZUSB_FX2=y
CONFIG_USB_HUB_USB251XB=y
CONFIG_USB_HSIC_USB3503=y
CONFIG_USB_HSIC_USB4604=y
CONFIG_USB_LINK_LAYER_TEST=y
CONFIG_USB_CHAOSKEY=y
# CONFIG_BRCM_USB_PINMAP is not set
# CONFIG_USB_ONBOARD_HUB is not set
CONFIG_USB_ATM=y
# CONFIG_USB_SPEEDTOUCH is not set
CONFIG_USB_CXACRU=y
CONFIG_USB_UEAGLEATM=y
# CONFIG_USB_XUSBATM is not set

#
# USB Physical Layer drivers
#
CONFIG_USB_PHY=y
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
CONFIG_USB_ISP1301=y
# CONFIG_USB_TEGRA_PHY is not set
# CONFIG_USB_ULPI is not set
# CONFIG_JZ4770_PHY is not set
# end of USB Physical Layer drivers

CONFIG_USB_GADGET=y
# CONFIG_USB_GADGET_DEBUG is not set
# CONFIG_USB_GADGET_DEBUG_FS is not set
CONFIG_USB_GADGET_VBUS_DRAW=2
CONFIG_USB_GADGET_STORAGE_NUM_BUFFERS=2

#
# USB Peripheral Controller
#
# CONFIG_USB_LPC32XX is not set
# CONFIG_USB_FOTG210_UDC is not set
CONFIG_USB_GR_UDC=y
CONFIG_USB_R8A66597=y
# CONFIG_USB_RENESAS_USB3 is not set
CONFIG_USB_PXA27X=y
CONFIG_USB_MV_UDC=y
CONFIG_USB_MV_U3D=y
# CONFIG_USB_SNP_UDC_PLAT is not set
CONFIG_USB_M66592=y
CONFIG_USB_BDC_UDC=y
CONFIG_USB_NET2272=y
CONFIG_USB_NET2272_DMA=y
# CONFIG_USB_GADGET_XILINX is not set
CONFIG_USB_MAX3420_UDC=y
# CONFIG_USB_ASPEED_UDC is not set
# CONFIG_USB_ASPEED_VHUB is not set
CONFIG_USB_DUMMY_HCD=y
# end of USB Peripheral Controller

CONFIG_USB_LIBCOMPOSITE=y
CONFIG_USB_F_SS_LB=y
CONFIG_USB_U_ETHER=y
CONFIG_USB_U_AUDIO=y
CONFIG_USB_F_NCM=y
CONFIG_USB_F_ECM=y
CONFIG_USB_F_EEM=y
CONFIG_USB_F_SUBSET=y
CONFIG_USB_F_RNDIS=y
CONFIG_USB_F_FS=y
CONFIG_USB_F_UAC1_LEGACY=y
CONFIG_USB_F_UAC2=y
CONFIG_USB_F_UVC=y
CONFIG_USB_F_MIDI=y
CONFIG_USB_CONFIGFS=y
CONFIG_USB_CONFIGFS_NCM=y
CONFIG_USB_CONFIGFS_ECM=y
# CONFIG_USB_CONFIGFS_ECM_SUBSET is not set
# CONFIG_USB_CONFIGFS_RNDIS is not set
CONFIG_USB_CONFIGFS_EEM=y
# CONFIG_USB_CONFIGFS_F_LB_SS is not set
# CONFIG_USB_CONFIGFS_F_FS is not set
# CONFIG_USB_CONFIGFS_F_UAC1 is not set
CONFIG_USB_CONFIGFS_F_UAC1_LEGACY=y
CONFIG_USB_CONFIGFS_F_UAC2=y
CONFIG_USB_CONFIGFS_F_MIDI=y
# CONFIG_USB_CONFIGFS_F_HID is not set
CONFIG_USB_CONFIGFS_F_UVC=y
# CONFIG_USB_CONFIGFS_F_PRINTER is not set

#
# USB Gadget precomposed configurations
#
CONFIG_USB_ZERO=y
CONFIG_USB_AUDIO=y
# CONFIG_GADGET_UAC1 is not set
CONFIG_USB_ETH=y
CONFIG_USB_ETH_RNDIS=y
CONFIG_USB_ETH_EEM=y
CONFIG_USB_G_NCM=y
CONFIG_USB_GADGETFS=y
CONFIG_USB_FUNCTIONFS=y
CONFIG_USB_FUNCTIONFS_ETH=y
CONFIG_USB_FUNCTIONFS_RNDIS=y
# CONFIG_USB_FUNCTIONFS_GENERIC is not set
# CONFIG_USB_MIDI_GADGET is not set
# CONFIG_USB_G_PRINTER is not set
# CONFIG_USB_G_HID is not set
CONFIG_USB_G_WEBCAM=y
CONFIG_USB_RAW_GADGET=y
# end of USB Gadget precomposed configurations

CONFIG_TYPEC=y
CONFIG_TYPEC_TCPM=y
CONFIG_TYPEC_TCPCI=y
# CONFIG_TYPEC_RT1711H is not set
# CONFIG_TYPEC_TCPCI_MAXIM is not set
CONFIG_TYPEC_FUSB302=y
# CONFIG_TYPEC_UCSI is not set
# CONFIG_TYPEC_TPS6598X is not set
CONFIG_TYPEC_ANX7411=y
CONFIG_TYPEC_RT1719=y
CONFIG_TYPEC_HD3SS3220=y
CONFIG_TYPEC_STUSB160X=y
# CONFIG_TYPEC_QCOM_PMIC is not set
CONFIG_TYPEC_WUSB3801=y

#
# USB Type-C Multiplexer/DeMultiplexer Switch support
#
CONFIG_TYPEC_MUX_FSA4480=y
# CONFIG_TYPEC_MUX_PI3USB30532 is not set
# end of USB Type-C Multiplexer/DeMultiplexer Switch support

#
# USB Type-C Alternate Mode drivers
#
# end of USB Type-C Alternate Mode drivers

CONFIG_USB_ROLE_SWITCH=y
# CONFIG_MMC is not set
# CONFIG_MEMSTICK is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_CLASS_FLASH=y
CONFIG_LEDS_CLASS_MULTICOLOR=y
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
# CONFIG_LEDS_AN30259A is not set
# CONFIG_LEDS_ARIEL is not set
# CONFIG_LEDS_AW2013 is not set
# CONFIG_LEDS_BCM6328 is not set
# CONFIG_LEDS_BCM6358 is not set
# CONFIG_LEDS_CR0014114 is not set
# CONFIG_LEDS_EL15203000 is not set
# CONFIG_LEDS_TURRIS_OMNIA is not set
CONFIG_LEDS_LM3530=y
CONFIG_LEDS_LM3532=y
CONFIG_LEDS_LM3642=y
# CONFIG_LEDS_LM3692X is not set
# CONFIG_LEDS_S3C24XX is not set
# CONFIG_LEDS_COBALT_QUBE is not set
# CONFIG_LEDS_COBALT_RAQ is not set
CONFIG_LEDS_PCA9532=y
# CONFIG_LEDS_PCA9532_GPIO is not set
CONFIG_LEDS_GPIO=y
# CONFIG_LEDS_LP3944 is not set
CONFIG_LEDS_LP3952=y
# CONFIG_LEDS_LP50XX is not set
# CONFIG_LEDS_LP55XX_COMMON is not set
# CONFIG_LEDS_LP8860 is not set
CONFIG_LEDS_PCA955X=y
# CONFIG_LEDS_PCA955X_GPIO is not set
CONFIG_LEDS_PCA963X=y
# CONFIG_LEDS_WM831X_STATUS is not set
CONFIG_LEDS_WM8350=y
CONFIG_LEDS_DA903X=y
CONFIG_LEDS_DA9052=y
# CONFIG_LEDS_DAC124S085 is not set
CONFIG_LEDS_PWM=y
CONFIG_LEDS_REGULATOR=y
CONFIG_LEDS_BD2802=y
CONFIG_LEDS_LT3593=y
CONFIG_LEDS_ADP5520=y
CONFIG_LEDS_MC13783=y
CONFIG_LEDS_NS2=y
CONFIG_LEDS_NETXBIG=y
CONFIG_LEDS_TCA6507=y
CONFIG_LEDS_TLC591XX=y
CONFIG_LEDS_MAX8997=y
CONFIG_LEDS_LM355x=y
# CONFIG_LEDS_OT200 is not set
# CONFIG_LEDS_MENF21BMC is not set
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
# CONFIG_LEDS_IP30 is not set
# CONFIG_LEDS_BCM63138 is not set
# CONFIG_LEDS_LGM is not set

#
# Flash and Torch LED drivers
#
# CONFIG_LEDS_AAT1290 is not set
CONFIG_LEDS_AS3645A=y
# CONFIG_LEDS_KTD2692 is not set
CONFIG_LEDS_LM3601X=y
# CONFIG_LEDS_MAX77693 is not set
# CONFIG_LEDS_RT4505 is not set
CONFIG_LEDS_RT8515=y
# CONFIG_LEDS_SGM3140 is not set

#
# RGB LED drivers
#
# CONFIG_LEDS_PWM_MULTICOLOR is not set

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
# CONFIG_LEDS_TRIGGER_TIMER is not set
# CONFIG_LEDS_TRIGGER_ONESHOT is not set
# CONFIG_LEDS_TRIGGER_HEARTBEAT is not set
CONFIG_LEDS_TRIGGER_BACKLIGHT=y
# CONFIG_LEDS_TRIGGER_CPU is not set
CONFIG_LEDS_TRIGGER_ACTIVITY=y
CONFIG_LEDS_TRIGGER_GPIO=y
CONFIG_LEDS_TRIGGER_DEFAULT_ON=y

#
# iptables trigger is under Netfilter config (LED target)
#
# CONFIG_LEDS_TRIGGER_TRANSIENT is not set
CONFIG_LEDS_TRIGGER_CAMERA=y
# CONFIG_LEDS_TRIGGER_PANIC is not set
CONFIG_LEDS_TRIGGER_NETDEV=y
CONFIG_LEDS_TRIGGER_PATTERN=y
# CONFIG_LEDS_TRIGGER_AUDIO is not set

#
# Simple LED drivers
#
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_RTC_LIB=y
# CONFIG_RTC_CLASS is not set
# CONFIG_DMADEVICES is not set

#
# DMABUF options
#
# CONFIG_SYNC_FILE is not set
# CONFIG_UDMABUF is not set
# CONFIG_DMABUF_MOVE_NOTIFY is not set
CONFIG_DMABUF_DEBUG=y
# CONFIG_DMABUF_SELFTESTS is not set
CONFIG_DMABUF_HEAPS=y
CONFIG_DMABUF_SYSFS_STATS=y
# CONFIG_DMABUF_HEAPS_SYSTEM is not set
# end of DMABUF options

CONFIG_AUXDISPLAY=y
CONFIG_CHARLCD=y
CONFIG_LINEDISP=y
CONFIG_HD44780_COMMON=y
CONFIG_HD44780=y
CONFIG_IMG_ASCII_LCD=y
CONFIG_HT16K33=y
CONFIG_LCD2S=y
CONFIG_PANEL_CHANGE_MESSAGE=y
CONFIG_PANEL_BOOT_MESSAGE=""
# CONFIG_CHARLCD_BL_OFF is not set
CONFIG_CHARLCD_BL_ON=y
# CONFIG_CHARLCD_BL_FLASH is not set
# CONFIG_UIO is not set
CONFIG_VFIO=y
CONFIG_VFIO_VIRQFD=y
# CONFIG_VFIO_NOIOMMU is not set
CONFIG_VFIO_PCI_CORE=y
CONFIG_VFIO_PCI_MMAP=y
CONFIG_VFIO_PCI_INTX=y
CONFIG_VFIO_PCI=y
# CONFIG_MLX5_VFIO_PCI is not set
# CONFIG_VFIO_PLATFORM is not set
CONFIG_VFIO_MDEV=y
CONFIG_IRQ_BYPASS_MANAGER=y
CONFIG_VIRT_DRIVERS=y
CONFIG_VMGENID=y
CONFIG_VIRTIO_ANCHOR=y
CONFIG_VIRTIO=y
# CONFIG_VIRTIO_MENU is not set
CONFIG_VDPA=y
CONFIG_VDPA_SIM=y
CONFIG_VDPA_SIM_NET=y
# CONFIG_VDPA_SIM_BLOCK is not set
CONFIG_VDPA_USER=y
# CONFIG_IFCVF is not set
CONFIG_MLX5_VDPA=y
CONFIG_MLX5_VDPA_NET=y
# CONFIG_VP_VDPA is not set
CONFIG_VHOST_IOTLB=y
CONFIG_VHOST_RING=y
# CONFIG_VHOST_MENU is not set

#
# Microsoft Hyper-V guest support
#
# end of Microsoft Hyper-V guest support

CONFIG_GREYBUS=y
CONFIG_GREYBUS_ES2=y
CONFIG_COMEDI=y
# CONFIG_COMEDI_DEBUG is not set
CONFIG_COMEDI_DEFAULT_BUF_SIZE_KB=2048
CONFIG_COMEDI_DEFAULT_BUF_MAXSIZE_KB=20480
# CONFIG_COMEDI_MISC_DRIVERS is not set
# CONFIG_COMEDI_ISA_DRIVERS is not set
CONFIG_COMEDI_PCI_DRIVERS=y
CONFIG_COMEDI_8255_PCI=y
CONFIG_COMEDI_ADDI_WATCHDOG=y
# CONFIG_COMEDI_ADDI_APCI_1032 is not set
# CONFIG_COMEDI_ADDI_APCI_1500 is not set
CONFIG_COMEDI_ADDI_APCI_1516=y
CONFIG_COMEDI_ADDI_APCI_1564=y
CONFIG_COMEDI_ADDI_APCI_16XX=y
CONFIG_COMEDI_ADDI_APCI_2032=y
CONFIG_COMEDI_ADDI_APCI_2200=y
CONFIG_COMEDI_ADDI_APCI_3120=y
CONFIG_COMEDI_ADDI_APCI_3501=y
CONFIG_COMEDI_ADDI_APCI_3XXX=y
CONFIG_COMEDI_ADL_PCI6208=y
CONFIG_COMEDI_ADL_PCI7X3X=y
# CONFIG_COMEDI_ADL_PCI8164 is not set
# CONFIG_COMEDI_ADL_PCI9111 is not set
CONFIG_COMEDI_ADL_PCI9118=y
CONFIG_COMEDI_ADV_PCI1710=y
CONFIG_COMEDI_ADV_PCI1720=y
CONFIG_COMEDI_ADV_PCI1723=y
CONFIG_COMEDI_ADV_PCI1724=y
# CONFIG_COMEDI_ADV_PCI1760 is not set
CONFIG_COMEDI_ADV_PCI_DIO=y
# CONFIG_COMEDI_AMPLC_DIO200_PCI is not set
# CONFIG_COMEDI_AMPLC_PC236_PCI is not set
# CONFIG_COMEDI_AMPLC_PC263_PCI is not set
# CONFIG_COMEDI_AMPLC_PCI224 is not set
# CONFIG_COMEDI_AMPLC_PCI230 is not set
# CONFIG_COMEDI_CONTEC_PCI_DIO is not set
CONFIG_COMEDI_DAS08_PCI=y
CONFIG_COMEDI_DT3000=y
CONFIG_COMEDI_DYNA_PCI10XX=y
# CONFIG_COMEDI_GSC_HPDI is not set
CONFIG_COMEDI_MF6X4=y
CONFIG_COMEDI_ICP_MULTI=y
# CONFIG_COMEDI_DAQBOARD2000 is not set
# CONFIG_COMEDI_JR3_PCI is not set
CONFIG_COMEDI_KE_COUNTER=y
CONFIG_COMEDI_CB_PCIDAS64=y
# CONFIG_COMEDI_CB_PCIDAS is not set
# CONFIG_COMEDI_CB_PCIDDA is not set
CONFIG_COMEDI_CB_PCIMDAS=y
# CONFIG_COMEDI_CB_PCIMDDA is not set
CONFIG_COMEDI_ME4000=y
CONFIG_COMEDI_ME_DAQ=y
CONFIG_COMEDI_NI_6527=y
# CONFIG_COMEDI_NI_65XX is not set
CONFIG_COMEDI_NI_660X=y
CONFIG_COMEDI_NI_670X=y
# CONFIG_COMEDI_NI_LABPC_PCI is not set
# CONFIG_COMEDI_NI_PCIDIO is not set
CONFIG_COMEDI_NI_PCIMIO=y
CONFIG_COMEDI_RTD520=y
# CONFIG_COMEDI_S626 is not set
CONFIG_COMEDI_MITE=y
CONFIG_COMEDI_NI_TIOCMD=y
CONFIG_COMEDI_PCMCIA_DRIVERS=y
# CONFIG_COMEDI_CB_DAS16_CS is not set
CONFIG_COMEDI_DAS08_CS=y
# CONFIG_COMEDI_NI_DAQ_700_CS is not set
CONFIG_COMEDI_NI_DAQ_DIO24_CS=y
# CONFIG_COMEDI_NI_LABPC_CS is not set
CONFIG_COMEDI_NI_MIO_CS=y
# CONFIG_COMEDI_QUATECH_DAQP_CS is not set
# CONFIG_COMEDI_USB_DRIVERS is not set
CONFIG_COMEDI_8254=y
CONFIG_COMEDI_8255=y
CONFIG_COMEDI_8255_SA=y
CONFIG_COMEDI_KCOMEDILIB=y
CONFIG_COMEDI_DAS08=y
CONFIG_COMEDI_NI_TIO=y
CONFIG_COMEDI_NI_ROUTING=y
# CONFIG_COMEDI_TESTS is not set
# CONFIG_STAGING is not set
CONFIG_GOLDFISH=y
# CONFIG_GOLDFISH_PIPE is not set
# CONFIG_CHROME_PLATFORMS is not set
# CONFIG_MELLANOX_PLATFORM is not set
# CONFIG_OLPC_XO175 is not set
CONFIG_SURFACE_PLATFORMS=y
# CONFIG_SURFACE_3_POWER_OPREGION is not set
# CONFIG_SURFACE_GPE is not set
# CONFIG_SURFACE_HOTPLUG is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
CONFIG_HAVE_CLK=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
# CONFIG_COMMON_CLK_WM831X is not set

#
# Clock driver for ARM Reference designs
#
# CONFIG_CLK_ICST is not set
# CONFIG_CLK_SP810 is not set
# end of Clock driver for ARM Reference designs

# CONFIG_CLK_HSDK is not set
# CONFIG_LMK04832 is not set
# CONFIG_COMMON_CLK_APPLE_NCO is not set
# CONFIG_COMMON_CLK_MAX77686 is not set
CONFIG_COMMON_CLK_MAX9485=y
# CONFIG_COMMON_CLK_HI655X is not set
# CONFIG_COMMON_CLK_SCMI is not set
# CONFIG_COMMON_CLK_SCPI is not set
# CONFIG_COMMON_CLK_SI5341 is not set
CONFIG_COMMON_CLK_SI5351=y
# CONFIG_COMMON_CLK_SI514 is not set
CONFIG_COMMON_CLK_SI544=y
# CONFIG_COMMON_CLK_SI570 is not set
# CONFIG_COMMON_CLK_BM1880 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_TPS68470 is not set
# CONFIG_COMMON_CLK_CDCE925 is not set
CONFIG_COMMON_CLK_CS2000_CP=y
# CONFIG_COMMON_CLK_EN7523 is not set
# CONFIG_COMMON_CLK_FSL_FLEXSPI is not set
# CONFIG_COMMON_CLK_FSL_SAI is not set
# CONFIG_COMMON_CLK_GEMINI is not set
# CONFIG_COMMON_CLK_LAN966X is not set
# CONFIG_COMMON_CLK_ASPEED is not set
# CONFIG_COMMON_CLK_S2MPS11 is not set
CONFIG_CLK_TWL6040=y
# CONFIG_COMMON_CLK_AXI_CLKGEN is not set
# CONFIG_CLK_QORIQ is not set
# CONFIG_CLK_LS1028A_PLLDIG is not set
# CONFIG_COMMON_CLK_XGENE is not set
CONFIG_COMMON_CLK_PALMAS=y
# CONFIG_COMMON_CLK_PWM is not set
# CONFIG_COMMON_CLK_OXNAS is not set
# CONFIG_COMMON_CLK_RS9_PCIE is not set
# CONFIG_COMMON_CLK_VC5 is not set
# CONFIG_COMMON_CLK_MMP2_AUDIO is not set
# CONFIG_COMMON_CLK_FIXED_MMIO is not set
# CONFIG_CLK_ACTIONS is not set
# CONFIG_CLK_BAIKAL_T1 is not set
# CONFIG_CLK_BCM2711_DVP is not set
# CONFIG_CLK_BCM2835 is not set
# CONFIG_CLK_BCM_63XX is not set
# CONFIG_CLK_BCM_63XX_GATE is not set
# CONFIG_CLK_BCM_KONA is not set
# CONFIG_CLK_BCM_CYGNUS is not set
# CONFIG_CLK_BCM_HR2 is not set
# CONFIG_CLK_BCM_NSP is not set
# CONFIG_CLK_BCM_NS2 is not set
# CONFIG_CLK_BCM_SR is not set
# CONFIG_CLK_RASPBERRYPI is not set
# CONFIG_COMMON_CLK_HI3516CV300 is not set
# CONFIG_COMMON_CLK_HI3519 is not set
# CONFIG_COMMON_CLK_HI3559A is not set
# CONFIG_COMMON_CLK_HI3660 is not set
# CONFIG_COMMON_CLK_HI3670 is not set
# CONFIG_COMMON_CLK_HI3798CV200 is not set
# CONFIG_COMMON_CLK_HI6220 is not set
# CONFIG_RESET_HISI is not set
# CONFIG_STUB_CLK_HI6220 is not set
# CONFIG_STUB_CLK_HI3660 is not set
# CONFIG_COMMON_CLK_BOSTON is not set
# CONFIG_MXC_CLK is not set
# CONFIG_CLK_IMX8MM is not set
# CONFIG_CLK_IMX8MN is not set
# CONFIG_CLK_IMX8MP is not set
# CONFIG_CLK_IMX8MQ is not set
# CONFIG_CLK_IMX8ULP is not set
# CONFIG_CLK_IMX93 is not set

#
# Ingenic SoCs drivers
#
# CONFIG_INGENIC_CGU_JZ4740 is not set
# CONFIG_INGENIC_CGU_JZ4725B is not set
# CONFIG_INGENIC_CGU_JZ4760 is not set
# CONFIG_INGENIC_CGU_JZ4770 is not set
# CONFIG_INGENIC_CGU_JZ4780 is not set
# CONFIG_INGENIC_CGU_X1000 is not set
# CONFIG_INGENIC_CGU_X1830 is not set
# CONFIG_INGENIC_TCU_CLK is not set
# end of Ingenic SoCs drivers

# CONFIG_COMMON_CLK_KEYSTONE is not set
# CONFIG_TI_SYSCON_CLK is not set

#
# Clock driver for MediaTek SoC
#
# CONFIG_COMMON_CLK_MT2701 is not set
# CONFIG_COMMON_CLK_MT2712 is not set
# CONFIG_COMMON_CLK_MT6765 is not set
# CONFIG_COMMON_CLK_MT6779 is not set
# CONFIG_COMMON_CLK_MT6797 is not set
# CONFIG_COMMON_CLK_MT7622 is not set
# CONFIG_COMMON_CLK_MT7629 is not set
# CONFIG_COMMON_CLK_MT7986 is not set
# CONFIG_COMMON_CLK_MT8135 is not set
# CONFIG_COMMON_CLK_MT8167 is not set
# CONFIG_COMMON_CLK_MT8173 is not set
# CONFIG_COMMON_CLK_MT8183 is not set
# CONFIG_COMMON_CLK_MT8186 is not set
# CONFIG_COMMON_CLK_MT8192 is not set
# CONFIG_COMMON_CLK_MT8195 is not set
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
# CONFIG_CLK_RENESAS is not set
# CONFIG_COMMON_CLK_SAMSUNG is not set
# CONFIG_S3C2410_COMMON_CLK is not set
# CONFIG_S3C2412_COMMON_CLK is not set
# CONFIG_S3C2443_COMMON_CLK is not set
# CONFIG_CLK_SIFIVE is not set
# CONFIG_CLK_INTEL_SOCFPGA is not set
# CONFIG_SPRD_COMMON_CLK is not set
# CONFIG_CLK_STARFIVE_JH7100 is not set
CONFIG_CLK_SUNXI=y
CONFIG_CLK_SUNXI_CLOCKS=y
CONFIG_CLK_SUNXI_PRCM_SUN6I=y
CONFIG_CLK_SUNXI_PRCM_SUN8I=y
CONFIG_CLK_SUNXI_PRCM_SUN9I=y
# CONFIG_SUNXI_CCU is not set
# CONFIG_COMMON_CLK_TI_ADPLL is not set
# CONFIG_CLK_UNIPHIER is not set
# CONFIG_COMMON_CLK_VISCONTI is not set
# CONFIG_CLK_LGM_CGU is not set
# CONFIG_XILINX_VCU is not set
# CONFIG_COMMON_CLK_ZYNQMP is not set
# CONFIG_HWSPINLOCK is not set

#
# Clock Source drivers
#
# CONFIG_BCM2835_TIMER is not set
# CONFIG_BCM_KONA_TIMER is not set
# CONFIG_DAVINCI_TIMER is not set
# CONFIG_DIGICOLOR_TIMER is not set
# CONFIG_OMAP_DM_TIMER is not set
# CONFIG_DW_APB_TIMER is not set
# CONFIG_FTTMR010_TIMER is not set
# CONFIG_IXP4XX_TIMER is not set
# CONFIG_MESON6_TIMER is not set
# CONFIG_OWL_TIMER is not set
# CONFIG_RDA_TIMER is not set
# CONFIG_SUN4I_TIMER is not set
# CONFIG_SUN5I_HSTIMER is not set
# CONFIG_TEGRA_TIMER is not set
# CONFIG_TEGRA186_TIMER is not set
# CONFIG_VT8500_TIMER is not set
# CONFIG_NPCM7XX_TIMER is not set
# CONFIG_CADENCE_TTC_TIMER is not set
# CONFIG_ASM9260_TIMER is not set
# CONFIG_CLKSRC_DBX500_PRCMU is not set
# CONFIG_CLPS711X_TIMER is not set
# CONFIG_MXS_TIMER is not set
# CONFIG_NSPIRE_TIMER is not set
# CONFIG_INTEGRATOR_AP_TIMER is not set
# CONFIG_CLKSRC_PISTACHIO is not set
# CONFIG_CLKSRC_TI_32K is not set
# CONFIG_CLKSRC_STM32_LP is not set
# CONFIG_CLKSRC_MPS2 is not set
# CONFIG_ARC_TIMERS is not set
# CONFIG_ARM_TIMER_SP804 is not set
# CONFIG_ARMV7M_SYSTICK is not set
# CONFIG_ATMEL_PIT is not set
# CONFIG_ATMEL_ST is not set
# CONFIG_CLKSRC_SAMSUNG_PWM is not set
# CONFIG_FSL_FTM_TIMER is not set
# CONFIG_OXNAS_RPS_TIMER is not set
# CONFIG_MTK_TIMER is not set
# CONFIG_SPRD_TIMER is not set
# CONFIG_CLKSRC_JCORE_PIT is not set
# CONFIG_SH_TIMER_CMT is not set
# CONFIG_SH_TIMER_MTU2 is not set
# CONFIG_RENESAS_OSTM is not set
# CONFIG_SH_TIMER_TMU is not set
# CONFIG_EM_TIMER_STI is not set
# CONFIG_CLKSRC_VERSATILE is not set
# CONFIG_CLKSRC_PXA is not set
# CONFIG_TIMER_IMX_SYS_CTR is not set
# CONFIG_CLKSRC_ST_LPC is not set
# CONFIG_GXP_TIMER is not set
# CONFIG_MSC313E_TIMER is not set
# CONFIG_INGENIC_TIMER is not set
# CONFIG_INGENIC_SYSOST is not set
# CONFIG_INGENIC_OST is not set
# CONFIG_MICROCHIP_PIT64B is not set
# end of Clock Source drivers

CONFIG_MAILBOX=y
# CONFIG_IMX_MBOX is not set
# CONFIG_PLATFORM_MHU is not set
# CONFIG_ARMADA_37XX_RWTM_MBOX is not set
# CONFIG_ROCKCHIP_MBOX is not set
# CONFIG_PCC is not set
CONFIG_ALTERA_MBOX=y
# CONFIG_HI3660_MBOX is not set
# CONFIG_HI6220_MBOX is not set
# CONFIG_MAILBOX_TEST is not set
# CONFIG_POLARFIRE_SOC_MAILBOX is not set
# CONFIG_QCOM_APCS_IPC is not set
# CONFIG_BCM_PDC_MBOX is not set
# CONFIG_STM32_IPCC is not set
# CONFIG_MTK_ADSP_MBOX is not set
# CONFIG_MTK_CMDQ_MBOX is not set
# CONFIG_SUN6I_MSGBOX is not set
# CONFIG_SPRD_MBOX is not set
# CONFIG_QCOM_IPCC is not set
CONFIG_IOMMU_IOVA=y
CONFIG_IOMMU_API=y
# CONFIG_IOMMU_SUPPORT is not set

#
# Remoteproc drivers
#
CONFIG_REMOTEPROC=y
# CONFIG_REMOTEPROC_CDEV is not set
# CONFIG_INGENIC_VPU_RPROC is not set
# CONFIG_MTK_SCP is not set
# CONFIG_MESON_MX_AO_ARC_REMOTEPROC is not set
# CONFIG_RCAR_REMOTEPROC is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
CONFIG_RPMSG=y
CONFIG_RPMSG_CHAR=y
# CONFIG_RPMSG_CTRL is not set
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
# CONFIG_MESON_CANVAS is not set
# CONFIG_MESON_CLK_MEASURE is not set
# CONFIG_MESON_GX_SOCINFO is not set
# CONFIG_MESON_MX_SOCINFO is not set
# end of Amlogic SoC drivers

#
# Apple SoC drivers
#
# CONFIG_APPLE_RTKIT is not set
# CONFIG_APPLE_SART is not set
# end of Apple SoC drivers

#
# ASPEED SoC drivers
#
# CONFIG_ASPEED_LPC_CTRL is not set
# CONFIG_ASPEED_LPC_SNOOP is not set
# CONFIG_ASPEED_UART_ROUTING is not set
# CONFIG_ASPEED_P2A_CTRL is not set
# CONFIG_ASPEED_SOCINFO is not set
# end of ASPEED SoC drivers

# CONFIG_AT91_SOC_ID is not set
# CONFIG_AT91_SOC_SFR is not set

#
# Broadcom SoC drivers
#
# CONFIG_BCM2835_POWER is not set
# CONFIG_SOC_BCM63XX is not set
# CONFIG_SOC_BRCMSTB is not set
# CONFIG_BCM_PMB is not set
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# CONFIG_QUICC_ENGINE is not set
CONFIG_DPAA2_CONSOLE=y
# end of NXP/Freescale QorIQ SoC drivers

#
# fujitsu SoC drivers
#
# end of fujitsu SoC drivers

#
# i.MX SoC drivers
#
# CONFIG_SOC_IMX8M is not set
# end of i.MX SoC drivers

#
# IXP4xx SoC drivers
#
# CONFIG_IXP4XX_QMGR is not set
# CONFIG_IXP4XX_NPE is not set
# end of IXP4xx SoC drivers

#
# Enable LiteX SoC Builder specific drivers
#
# CONFIG_LITEX_SOC_CONTROLLER is not set
# end of Enable LiteX SoC Builder specific drivers

#
# MediaTek SoC drivers
#
# CONFIG_MTK_CMDQ is not set
# CONFIG_MTK_DEVAPC is not set
# CONFIG_MTK_INFRACFG is not set
# CONFIG_MTK_PMIC_WRAP is not set
# CONFIG_MTK_SCPSYS is not set
# CONFIG_MTK_MMSYS is not set
# end of MediaTek SoC drivers

#
# Qualcomm SoC drivers
#
# CONFIG_QCOM_COMMAND_DB is not set
# CONFIG_QCOM_GENI_SE is not set
# CONFIG_QCOM_GSBI is not set
# CONFIG_QCOM_LLCC is not set
# CONFIG_QCOM_RPMH is not set
# CONFIG_QCOM_SMD_RPM is not set
# CONFIG_QCOM_SPM is not set
# CONFIG_QCOM_WCNSS_CTRL is not set
# CONFIG_QCOM_APR is not set
# CONFIG_QCOM_ICC_BWMON is not set
# end of Qualcomm SoC drivers

# CONFIG_SOC_RENESAS is not set
# CONFIG_ROCKCHIP_GRF is not set
# CONFIG_ROCKCHIP_IODOMAIN is not set
# CONFIG_SOC_SAMSUNG is not set
# CONFIG_SOC_TEGRA20_VOLTAGE_COUPLER is not set
# CONFIG_SOC_TEGRA30_VOLTAGE_COUPLER is not set
# CONFIG_SOC_TI is not set
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
# CONFIG_DEVFREQ_GOV_PERFORMANCE is not set
# CONFIG_DEVFREQ_GOV_POWERSAVE is not set
# CONFIG_DEVFREQ_GOV_USERSPACE is not set
# CONFIG_DEVFREQ_GOV_PASSIVE is not set

#
# DEVFREQ Drivers
#
# CONFIG_ARM_EXYNOS_BUS_DEVFREQ is not set
# CONFIG_ARM_IMX_BUS_DEVFREQ is not set
# CONFIG_ARM_TEGRA_DEVFREQ is not set
# CONFIG_ARM_MEDIATEK_CCI_DEVFREQ is not set
# CONFIG_ARM_SUN8I_A33_MBUS_DEVFREQ is not set
# CONFIG_PM_DEVFREQ_EVENT is not set
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
CONFIG_EXTCON_ADC_JACK=y
# CONFIG_EXTCON_FSA9480 is not set
CONFIG_EXTCON_GPIO=y
# CONFIG_EXTCON_INTEL_INT3496 is not set
CONFIG_EXTCON_MAX3355=y
CONFIG_EXTCON_MAX77693=y
# CONFIG_EXTCON_MAX8997 is not set
CONFIG_EXTCON_PALMAS=y
CONFIG_EXTCON_PTN5150=y
# CONFIG_EXTCON_QCOM_SPMI_MISC is not set
# CONFIG_EXTCON_RT8973A is not set
CONFIG_EXTCON_SM5502=y
CONFIG_EXTCON_USB_GPIO=y
CONFIG_EXTCON_USBC_TUSB320=y
CONFIG_MEMORY=y
CONFIG_DDR=y
# CONFIG_ATMEL_SDRAMC is not set
# CONFIG_ATMEL_EBI is not set
# CONFIG_BRCMSTB_DPFE is not set
# CONFIG_BT1_L2_CTL is not set
# CONFIG_TI_AEMIF is not set
# CONFIG_TI_EMIF is not set
# CONFIG_OMAP_GPMC is not set
CONFIG_FPGA_DFL_EMIF=y
# CONFIG_MVEBU_DEVBUS is not set
# CONFIG_FSL_CORENET_CF is not set
# CONFIG_FSL_IFC is not set
# CONFIG_JZ4780_NEMC is not set
# CONFIG_MTK_SMI is not set
# CONFIG_DA8XX_DDRCTL is not set
# CONFIG_RENESAS_RPCIF is not set
# CONFIG_STM32_FMC2_EBI is not set
# CONFIG_SAMSUNG_MC is not set
CONFIG_TEGRA_MC=y
CONFIG_TEGRA20_EMC=y
CONFIG_TEGRA30_EMC=y
CONFIG_TEGRA124_EMC=y
# CONFIG_TEGRA210_EMC is not set
CONFIG_IIO=y
CONFIG_IIO_BUFFER=y
CONFIG_IIO_BUFFER_CB=y
CONFIG_IIO_BUFFER_DMA=y
# CONFIG_IIO_BUFFER_DMAENGINE is not set
# CONFIG_IIO_BUFFER_HW_CONSUMER is not set
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
CONFIG_ADIS16201=y
# CONFIG_ADIS16209 is not set
CONFIG_ADXL313=y
CONFIG_ADXL313_I2C=y
CONFIG_ADXL313_SPI=y
CONFIG_ADXL345=y
CONFIG_ADXL345_I2C=y
# CONFIG_ADXL345_SPI is not set
CONFIG_ADXL355=y
CONFIG_ADXL355_I2C=y
CONFIG_ADXL355_SPI=y
CONFIG_ADXL367=y
CONFIG_ADXL367_SPI=y
CONFIG_ADXL367_I2C=y
# CONFIG_ADXL372_SPI is not set
# CONFIG_ADXL372_I2C is not set
CONFIG_BMA180=y
CONFIG_BMA220=y
CONFIG_BMA400=y
CONFIG_BMA400_I2C=y
CONFIG_BMA400_SPI=y
CONFIG_BMC150_ACCEL=y
CONFIG_BMC150_ACCEL_I2C=y
CONFIG_BMC150_ACCEL_SPI=y
CONFIG_BMI088_ACCEL=y
CONFIG_BMI088_ACCEL_SPI=y
CONFIG_DA280=y
CONFIG_DA311=y
# CONFIG_DMARD06 is not set
# CONFIG_DMARD09 is not set
CONFIG_DMARD10=y
CONFIG_FXLS8962AF=y
CONFIG_FXLS8962AF_I2C=y
CONFIG_FXLS8962AF_SPI=y
CONFIG_KXSD9=y
CONFIG_KXSD9_SPI=y
CONFIG_KXSD9_I2C=y
CONFIG_KXCJK1013=y
# CONFIG_MC3230 is not set
CONFIG_MMA7455=y
# CONFIG_MMA7455_I2C is not set
CONFIG_MMA7455_SPI=y
# CONFIG_MMA7660 is not set
CONFIG_MMA8452=y
CONFIG_MMA9551_CORE=y
CONFIG_MMA9551=y
CONFIG_MMA9553=y
CONFIG_MXC4005=y
# CONFIG_MXC6255 is not set
CONFIG_SCA3000=y
CONFIG_SCA3300=y
CONFIG_STK8312=y
CONFIG_STK8BA50=y
# end of Accelerometers

#
# Analog to digital converters
#
CONFIG_AD_SIGMA_DELTA=y
CONFIG_AD7091R5=y
CONFIG_AD7124=y
CONFIG_AD7192=y
# CONFIG_AD7266 is not set
CONFIG_AD7280=y
# CONFIG_AD7291 is not set
# CONFIG_AD7292 is not set
CONFIG_AD7298=y
CONFIG_AD7476=y
CONFIG_AD7606=y
CONFIG_AD7606_IFACE_PARALLEL=y
# CONFIG_AD7606_IFACE_SPI is not set
# CONFIG_AD7766 is not set
CONFIG_AD7768_1=y
# CONFIG_AD7780 is not set
# CONFIG_AD7791 is not set
CONFIG_AD7793=y
CONFIG_AD7887=y
CONFIG_AD7923=y
CONFIG_AD7949=y
CONFIG_AD799X=y
# CONFIG_ADI_AXI_ADC is not set
# CONFIG_ASPEED_ADC is not set
# CONFIG_AT91_ADC is not set
# CONFIG_AT91_SAMA5D2_ADC is not set
CONFIG_AXP20X_ADC=y
# CONFIG_AXP288_ADC is not set
# CONFIG_BCM_IPROC_ADC is not set
# CONFIG_BERLIN2_ADC is not set
CONFIG_CC10001_ADC=y
CONFIG_DA9150_GPADC=y
CONFIG_DLN2_ADC=y
CONFIG_ENVELOPE_DETECTOR=y
# CONFIG_EXYNOS_ADC is not set
# CONFIG_HI8435 is not set
CONFIG_HX711=y
# CONFIG_INGENIC_ADC is not set
# CONFIG_IMX7D_ADC is not set
# CONFIG_IMX8QXP_ADC is not set
# CONFIG_LPC18XX_ADC is not set
# CONFIG_LPC32XX_ADC is not set
# CONFIG_LTC2471 is not set
CONFIG_LTC2485=y
# CONFIG_LTC2496 is not set
CONFIG_LTC2497=y
CONFIG_MAX1027=y
# CONFIG_MAX11100 is not set
CONFIG_MAX1118=y
CONFIG_MAX1241=y
# CONFIG_MAX1363 is not set
# CONFIG_MAX9611 is not set
CONFIG_MCP320X=y
CONFIG_MCP3422=y
CONFIG_MCP3911=y
# CONFIG_MEDIATEK_MT6577_AUXADC is not set
CONFIG_MEN_Z188_ADC=y
# CONFIG_MESON_SARADC is not set
CONFIG_MP2629_ADC=y
CONFIG_NAU7802=y
# CONFIG_NPCM_ADC is not set
# CONFIG_PALMAS_GPADC is not set
# CONFIG_RCAR_GYRO_ADC is not set
# CONFIG_ROCKCHIP_SARADC is not set
# CONFIG_RZG2L_ADC is not set
# CONFIG_SC27XX_ADC is not set
# CONFIG_SPEAR_ADC is not set
CONFIG_SD_ADC_MODULATOR=y
# CONFIG_STM32_ADC_CORE is not set
# CONFIG_STM32_DFSDM_CORE is not set
# CONFIG_STM32_DFSDM_ADC is not set
# CONFIG_TI_ADC081C is not set
CONFIG_TI_ADC0832=y
# CONFIG_TI_ADC084S021 is not set
CONFIG_TI_ADC12138=y
CONFIG_TI_ADC108S102=y
# CONFIG_TI_ADC128S052 is not set
# CONFIG_TI_ADC161S626 is not set
CONFIG_TI_ADS1015=y
CONFIG_TI_ADS7950=y
CONFIG_TI_ADS8344=y
# CONFIG_TI_ADS8688 is not set
CONFIG_TI_ADS124S08=y
CONFIG_TI_ADS131E08=y
CONFIG_TI_AM335X_ADC=y
CONFIG_TI_TLC4541=y
CONFIG_TI_TSC2046=y
CONFIG_VF610_ADC=y
# CONFIG_XILINX_XADC is not set
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
# CONFIG_AD8366 is not set
CONFIG_ADA4250=y
CONFIG_HMC425=y
# end of Amplifiers

#
# Capacitance to digital converters
#
CONFIG_AD7150=y
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
# CONFIG_IAQCORE is not set
CONFIG_SCD30_CORE=y
CONFIG_SCD30_I2C=y
CONFIG_SCD4X=y
CONFIG_SENSIRION_SGP30=y
CONFIG_SENSIRION_SGP40=y
# CONFIG_SPS30_I2C is not set
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
# end of IIO SCMI Sensors

#
# SSP Sensor Common
#
CONFIG_IIO_SSP_SENSORS_COMMONS=y
CONFIG_IIO_SSP_SENSORHUB=y
# end of SSP Sensor Common

CONFIG_IIO_ST_SENSORS_SPI=y
CONFIG_IIO_ST_SENSORS_CORE=y

#
# Digital to analog converters
#
# CONFIG_AD3552R is not set
CONFIG_AD5064=y
CONFIG_AD5360=y
CONFIG_AD5380=y
# CONFIG_AD5421 is not set
# CONFIG_AD5446 is not set
# CONFIG_AD5449 is not set
CONFIG_AD5592R_BASE=y
CONFIG_AD5592R=y
CONFIG_AD5593R=y
# CONFIG_AD5504 is not set
CONFIG_AD5624R_SPI=y
CONFIG_LTC2688=y
CONFIG_AD5686=y
# CONFIG_AD5686_SPI is not set
CONFIG_AD5696_I2C=y
# CONFIG_AD5755 is not set
# CONFIG_AD5758 is not set
# CONFIG_AD5761 is not set
CONFIG_AD5764=y
# CONFIG_AD5766 is not set
# CONFIG_AD5770R is not set
# CONFIG_AD5791 is not set
CONFIG_AD7293=y
CONFIG_AD7303=y
CONFIG_AD8801=y
# CONFIG_DPOT_DAC is not set
# CONFIG_DS4424 is not set
# CONFIG_LPC18XX_DAC is not set
CONFIG_LTC1660=y
CONFIG_LTC2632=y
CONFIG_M62332=y
# CONFIG_MAX517 is not set
CONFIG_MAX5821=y
# CONFIG_MCP4725 is not set
CONFIG_MCP4922=y
# CONFIG_STM32_DAC is not set
# CONFIG_TI_DAC082S085 is not set
CONFIG_TI_DAC5571=y
CONFIG_TI_DAC7311=y
CONFIG_TI_DAC7612=y
# CONFIG_VF610_DAC is not set
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
# CONFIG_ADF4371 is not set
CONFIG_ADMV1013=y
CONFIG_ADMV1014=y
CONFIG_ADMV4420=y
# CONFIG_ADRF6780 is not set
# end of Phase-Locked Loop (PLL) frequency synthesizers
# end of Frequency Synthesizers DDS/PLL

#
# Digital gyroscope sensors
#
CONFIG_ADIS16080=y
# CONFIG_ADIS16130 is not set
CONFIG_ADIS16136=y
# CONFIG_ADIS16260 is not set
# CONFIG_ADXRS290 is not set
CONFIG_ADXRS450=y
CONFIG_BMG160=y
CONFIG_BMG160_I2C=y
CONFIG_BMG160_SPI=y
CONFIG_FXAS21002C=y
CONFIG_FXAS21002C_I2C=y
CONFIG_FXAS21002C_SPI=y
CONFIG_MPU3050=y
CONFIG_MPU3050_I2C=y
CONFIG_IIO_ST_GYRO_3AXIS=y
# CONFIG_IIO_ST_GYRO_I2C_3AXIS is not set
CONFIG_IIO_ST_GYRO_SPI_3AXIS=y
# CONFIG_ITG3200 is not set
# end of Digital gyroscope sensors

#
# Health Sensors
#

#
# Heart Rate Monitors
#
CONFIG_AFE4403=y
# CONFIG_AFE4404 is not set
# CONFIG_MAX30100 is not set
CONFIG_MAX30102=y
# end of Heart Rate Monitors
# end of Health Sensors

#
# Humidity sensors
#
CONFIG_AM2315=y
CONFIG_DHT11=y
CONFIG_HDC100X=y
# CONFIG_HDC2010 is not set
# CONFIG_HTS221 is not set
# CONFIG_HTU21 is not set
CONFIG_SI7005=y
CONFIG_SI7020=y
# end of Humidity sensors

#
# Inertial measurement units
#
CONFIG_ADIS16400=y
CONFIG_ADIS16460=y
CONFIG_ADIS16475=y
# CONFIG_ADIS16480 is not set
CONFIG_BMI160=y
# CONFIG_BMI160_I2C is not set
CONFIG_BMI160_SPI=y
CONFIG_FXOS8700=y
CONFIG_FXOS8700_I2C=y
CONFIG_FXOS8700_SPI=y
# CONFIG_KMX61 is not set
CONFIG_INV_ICM42600=y
CONFIG_INV_ICM42600_I2C=y
CONFIG_INV_ICM42600_SPI=y
CONFIG_INV_MPU6050_IIO=y
CONFIG_INV_MPU6050_I2C=y
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
CONFIG_ADJD_S311=y
CONFIG_ADUX1020=y
# CONFIG_AL3010 is not set
# CONFIG_AL3320A is not set
CONFIG_APDS9300=y
CONFIG_APDS9960=y
CONFIG_AS73211=y
CONFIG_BH1750=y
# CONFIG_BH1780 is not set
CONFIG_CM32181=y
# CONFIG_CM3232 is not set
# CONFIG_CM3323 is not set
# CONFIG_CM3605 is not set
CONFIG_CM36651=y
CONFIG_GP2AP002=y
CONFIG_GP2AP020A00F=y
# CONFIG_IQS621_ALS is not set
CONFIG_SENSORS_ISL29018=y
CONFIG_SENSORS_ISL29028=y
# CONFIG_ISL29125 is not set
CONFIG_JSA1212=y
CONFIG_RPR0521=y
CONFIG_LTR501=y
CONFIG_LV0104CS=y
CONFIG_MAX44000=y
CONFIG_MAX44009=y
CONFIG_NOA1305=y
CONFIG_OPT3001=y
CONFIG_PA12203001=y
CONFIG_SI1133=y
CONFIG_SI1145=y
# CONFIG_STK3310 is not set
# CONFIG_ST_UVIS25 is not set
CONFIG_TCS3414=y
CONFIG_TCS3472=y
CONFIG_SENSORS_TSL2563=y
CONFIG_TSL2583=y
CONFIG_TSL2591=y
CONFIG_TSL2772=y
CONFIG_TSL4531=y
CONFIG_US5182D=y
CONFIG_VCNL4000=y
# CONFIG_VCNL4035 is not set
# CONFIG_VEML6030 is not set
CONFIG_VEML6070=y
CONFIG_VL6180=y
CONFIG_ZOPT2201=y
# end of Light sensors

#
# Magnetometer sensors
#
CONFIG_AK8974=y
CONFIG_AK8975=y
# CONFIG_AK09911 is not set
CONFIG_BMC150_MAGN=y
CONFIG_BMC150_MAGN_I2C=y
# CONFIG_BMC150_MAGN_SPI is not set
CONFIG_MAG3110=y
CONFIG_MMC35240=y
# CONFIG_IIO_ST_MAGN_3AXIS is not set
CONFIG_SENSORS_HMC5843=y
# CONFIG_SENSORS_HMC5843_I2C is not set
CONFIG_SENSORS_HMC5843_SPI=y
CONFIG_SENSORS_RM3100=y
CONFIG_SENSORS_RM3100_I2C=y
CONFIG_SENSORS_RM3100_SPI=y
CONFIG_YAMAHA_YAS530=y
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

#
# Triggers - standalone
#
CONFIG_IIO_HRTIMER_TRIGGER=y
CONFIG_IIO_INTERRUPT_TRIGGER=y
# CONFIG_IIO_STM32_LPTIMER_TRIGGER is not set
# CONFIG_IIO_STM32_TIMER_TRIGGER is not set
CONFIG_IIO_TIGHTLOOP_TRIGGER=y
# CONFIG_IIO_SYSFS_TRIGGER is not set
# end of Triggers - standalone

#
# Linear and angular position sensors
#
# CONFIG_IQS624_POS is not set
# end of Linear and angular position sensors

#
# Digital potentiometers
#
# CONFIG_AD5110 is not set
# CONFIG_AD5272 is not set
# CONFIG_DS1803 is not set
CONFIG_MAX5432=y
CONFIG_MAX5481=y
CONFIG_MAX5487=y
CONFIG_MCP4018=y
CONFIG_MCP4131=y
# CONFIG_MCP4531 is not set
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
CONFIG_ABP060MG=y
# CONFIG_BMP280 is not set
CONFIG_DLHL60D=y
# CONFIG_DPS310 is not set
CONFIG_HP03=y
# CONFIG_ICP10100 is not set
# CONFIG_MPL115_I2C is not set
# CONFIG_MPL115_SPI is not set
CONFIG_MPL3115=y
CONFIG_MS5611=y
CONFIG_MS5611_I2C=y
CONFIG_MS5611_SPI=y
# CONFIG_MS5637 is not set
# CONFIG_IIO_ST_PRESS is not set
CONFIG_T5403=y
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
CONFIG_LIDAR_LITE_V2=y
CONFIG_MB1232=y
CONFIG_PING=y
CONFIG_RFD77402=y
CONFIG_SRF04=y
CONFIG_SX_COMMON=y
CONFIG_SX9310=y
CONFIG_SX9324=y
CONFIG_SX9360=y
CONFIG_SX9500=y
CONFIG_SRF08=y
CONFIG_VCNL3020=y
CONFIG_VL53L0X_I2C=y
# end of Proximity and distance sensors

#
# Resolver to digital converters
#
CONFIG_AD2S90=y
CONFIG_AD2S1200=y
# end of Resolver to digital converters

#
# Temperature sensors
#
# CONFIG_IQS620AT_TEMP is not set
CONFIG_LTC2983=y
CONFIG_MAXIM_THERMOCOUPLE=y
# CONFIG_MLX90614 is not set
CONFIG_MLX90632=y
CONFIG_TMP006=y
# CONFIG_TMP007 is not set
# CONFIG_TMP117 is not set
CONFIG_TSYS01=y
CONFIG_TSYS02D=y
CONFIG_MAX31856=y
# CONFIG_MAX31865 is not set
# end of Temperature sensors

CONFIG_NTB=y
CONFIG_NTB_MSI=y
CONFIG_NTB_IDT=y
CONFIG_NTB_SWITCHTEC=y
# CONFIG_NTB_PINGPONG is not set
CONFIG_NTB_TOOL=y
CONFIG_NTB_PERF=y
# CONFIG_NTB_MSI_TEST is not set
CONFIG_NTB_TRANSPORT=y
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
CONFIG_PWM_DEBUG=y
# CONFIG_PWM_ATMEL is not set
# CONFIG_PWM_ATMEL_TCB is not set
# CONFIG_PWM_BCM_IPROC is not set
# CONFIG_PWM_BCM_KONA is not set
# CONFIG_PWM_BCM2835 is not set
# CONFIG_PWM_BERLIN is not set
# CONFIG_PWM_BRCMSTB is not set
CONFIG_PWM_CLK=y
# CONFIG_PWM_CLPS711X is not set
CONFIG_PWM_DWC=y
# CONFIG_PWM_EP93XX is not set
# CONFIG_PWM_FSL_FTM is not set
# CONFIG_PWM_HIBVT is not set
# CONFIG_PWM_IMG is not set
# CONFIG_PWM_IMX1 is not set
# CONFIG_PWM_IMX27 is not set
# CONFIG_PWM_IMX_TPM is not set
# CONFIG_PWM_INTEL_LGM is not set
# CONFIG_PWM_IQS620A is not set
# CONFIG_PWM_JZ4740 is not set
# CONFIG_PWM_KEEMBAY is not set
CONFIG_PWM_LP3943=y
# CONFIG_PWM_LPC18XX_SCT is not set
# CONFIG_PWM_LPC32XX is not set
# CONFIG_PWM_LPSS_PCI is not set
# CONFIG_PWM_LPSS_PLATFORM is not set
# CONFIG_PWM_MESON is not set
# CONFIG_PWM_MTK_DISP is not set
# CONFIG_PWM_MEDIATEK is not set
# CONFIG_PWM_MXS is not set
# CONFIG_PWM_OMAP_DMTIMER is not set
CONFIG_PWM_PCA9685=y
# CONFIG_PWM_PXA is not set
# CONFIG_PWM_RASPBERRYPI_POE is not set
# CONFIG_PWM_RCAR is not set
# CONFIG_PWM_RENESAS_TPU is not set
# CONFIG_PWM_ROCKCHIP is not set
# CONFIG_PWM_SAMSUNG is not set
# CONFIG_PWM_SIFIVE is not set
# CONFIG_PWM_SL28CPLD is not set
# CONFIG_PWM_SPEAR is not set
# CONFIG_PWM_SPRD is not set
# CONFIG_PWM_STI is not set
# CONFIG_PWM_STM32 is not set
# CONFIG_PWM_STM32_LP is not set
# CONFIG_PWM_SUN4I is not set
# CONFIG_PWM_SUNPLUS is not set
# CONFIG_PWM_TEGRA is not set
# CONFIG_PWM_TIECAP is not set
# CONFIG_PWM_TIEHRPWM is not set
# CONFIG_PWM_VISCONTI is not set
# CONFIG_PWM_VT8500 is not set
# CONFIG_PWM_XILINX is not set

#
# IRQ chip support
#
CONFIG_IRQCHIP=y
# CONFIG_AL_FIC is not set
CONFIG_MADERA_IRQ=y
# CONFIG_JCORE_AIC is not set
# CONFIG_RENESAS_INTC_IRQPIN is not set
# CONFIG_RENESAS_IRQC is not set
# CONFIG_RENESAS_RZA1_IRQC is not set
# CONFIG_RENESAS_RZG2L_IRQC is not set
# CONFIG_SL28CPLD_INTC is not set
# CONFIG_TS4800_IRQ is not set
# CONFIG_XILINX_INTC is not set
# CONFIG_INGENIC_TCU_IRQ is not set
# CONFIG_IRQ_UNIPHIER_AIDET is not set
# CONFIG_MESON_IRQ_GPIO is not set
# CONFIG_IMX_IRQSTEER is not set
# CONFIG_IMX_INTMUX is not set
# CONFIG_EXYNOS_IRQ_COMBINER is not set
CONFIG_IRQ_LOONGARCH_CPU=y
CONFIG_LOONGSON_LIOINTC=y
CONFIG_LOONGSON_EIOINTC=y
# CONFIG_LOONGSON_HTVEC is not set
CONFIG_LOONGSON_PCH_PIC=y
CONFIG_LOONGSON_PCH_MSI=y
CONFIG_LOONGSON_PCH_LPC=y
# CONFIG_MST_IRQ is not set
# CONFIG_MCHP_EIC is not set
# CONFIG_SUNPLUS_SP7021_INTC is not set
# end of IRQ chip support

CONFIG_IPACK_BUS=y
CONFIG_BOARD_TPCI200=y
CONFIG_RESET_CONTROLLER=y
# CONFIG_RESET_A10SR is not set
# CONFIG_RESET_ATH79 is not set
# CONFIG_RESET_AXS10X is not set
# CONFIG_RESET_BCM6345 is not set
# CONFIG_RESET_BERLIN is not set
# CONFIG_RESET_BRCMSTB is not set
# CONFIG_RESET_BRCMSTB_RESCAL is not set
# CONFIG_RESET_HSDK is not set
# CONFIG_RESET_IMX7 is not set
# CONFIG_RESET_INTEL_GW is not set
# CONFIG_RESET_K210 is not set
# CONFIG_RESET_LANTIQ is not set
# CONFIG_RESET_LPC18XX is not set
# CONFIG_RESET_MCHP_SPARX5 is not set
# CONFIG_RESET_MESON is not set
# CONFIG_RESET_MESON_AUDIO_ARB is not set
# CONFIG_RESET_NPCM is not set
# CONFIG_RESET_PISTACHIO is not set
# CONFIG_RESET_QCOM_AOSS is not set
# CONFIG_RESET_QCOM_PDC is not set
# CONFIG_RESET_RASPBERRYPI is not set
# CONFIG_RESET_RZG2L_USBPHY_CTRL is not set
# CONFIG_RESET_SCMI is not set
# CONFIG_RESET_SIMPLE is not set
# CONFIG_RESET_SOCFPGA is not set
# CONFIG_RESET_STARFIVE_JH7100 is not set
# CONFIG_RESET_SUNPLUS is not set
# CONFIG_RESET_SUNXI is not set
# CONFIG_RESET_TI_SCI is not set
CONFIG_RESET_TI_SYSCON=y
# CONFIG_RESET_TI_TPS380X is not set
# CONFIG_RESET_TN48M_CPLD is not set
# CONFIG_RESET_UNIPHIER is not set
# CONFIG_RESET_UNIPHIER_GLUE is not set
# CONFIG_RESET_ZYNQ is not set
# CONFIG_COMMON_RESET_HI3660 is not set
# CONFIG_COMMON_RESET_HI6220 is not set

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
# CONFIG_PHY_LPC18XX_USB_OTG is not set
# CONFIG_PHY_PISTACHIO_USB is not set
# CONFIG_PHY_XGENE is not set
# CONFIG_USB_LGM_PHY is not set
CONFIG_PHY_CAN_TRANSCEIVER=y
# CONFIG_PHY_SUN4I_USB is not set
# CONFIG_PHY_SUN6I_MIPI_DPHY is not set
# CONFIG_PHY_SUN9I_USB is not set
# CONFIG_PHY_SUN50I_USB3 is not set
# CONFIG_PHY_MESON8_HDMI_TX is not set
# CONFIG_PHY_MESON8B_USB2 is not set
# CONFIG_PHY_MESON_GXL_USB2 is not set
# CONFIG_PHY_MESON_G12A_MIPI_DPHY_ANALOG is not set
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
CONFIG_BCM_KONA_USB2_PHY=y
# CONFIG_PHY_BCM_NS_USB2 is not set
# CONFIG_PHY_BCM_NS_USB3 is not set
# CONFIG_PHY_NS2_PCIE is not set
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
# CONFIG_PHY_MIXEL_LVDS_PHY is not set
# CONFIG_PHY_MIXEL_MIPI_DPHY is not set
# CONFIG_PHY_FSL_IMX8M_PCIE is not set
# CONFIG_PHY_FSL_LYNX_28G is not set
# CONFIG_PHY_HI6220_USB is not set
# CONFIG_PHY_HI3660_USB is not set
# CONFIG_PHY_HI3670_USB is not set
# CONFIG_PHY_HI3670_PCIE is not set
# CONFIG_PHY_HISTB_COMBPHY is not set
# CONFIG_PHY_HISI_INNO_USB2 is not set
# CONFIG_PHY_INGENIC_USB is not set
# CONFIG_PHY_LANTIQ_VRX200_PCIE is not set
# CONFIG_PHY_LANTIQ_RCU_USB2 is not set
# CONFIG_ARMADA375_USBCLUSTER_PHY is not set
# CONFIG_PHY_BERLIN_SATA is not set
# CONFIG_PHY_BERLIN_USB is not set
CONFIG_PHY_MVEBU_A3700_UTMI=y
# CONFIG_PHY_MVEBU_A38X_COMPHY is not set
# CONFIG_PHY_MVEBU_CP110_UTMI is not set
CONFIG_PHY_PXA_28NM_HSIC=y
# CONFIG_PHY_PXA_28NM_USB2 is not set
# CONFIG_PHY_PXA_USB is not set
# CONFIG_PHY_MMP3_USB is not set
# CONFIG_PHY_MMP3_HSIC is not set
# CONFIG_PHY_MTK_PCIE is not set
# CONFIG_PHY_MTK_TPHY is not set
# CONFIG_PHY_MTK_UFS is not set
# CONFIG_PHY_MTK_XSPHY is not set
# CONFIG_PHY_MTK_HDMI is not set
# CONFIG_PHY_MTK_MIPI_DSI is not set
# CONFIG_PHY_MTK_DP is not set
# CONFIG_PHY_SPARX5_SERDES is not set
# CONFIG_PHY_LAN966X_SERDES is not set
# CONFIG_PHY_CPCAP_USB is not set
# CONFIG_PHY_MAPPHONE_MDM6600 is not set
# CONFIG_PHY_OCELOT_SERDES is not set
CONFIG_PHY_ATH79_USB=y
# CONFIG_PHY_QCOM_EDP is not set
# CONFIG_PHY_QCOM_IPQ4019_USB is not set
# CONFIG_PHY_QCOM_PCIE2 is not set
# CONFIG_PHY_QCOM_QMP is not set
# CONFIG_PHY_QCOM_QUSB2 is not set
# CONFIG_PHY_QCOM_USB_HS is not set
# CONFIG_PHY_QCOM_USB_SNPS_FEMTO_V2 is not set
# CONFIG_PHY_QCOM_USB_HSIC is not set
# CONFIG_PHY_QCOM_USB_HS_28NM is not set
# CONFIG_PHY_QCOM_USB_SS is not set
# CONFIG_PHY_QCOM_IPQ806X_USB is not set
# CONFIG_PHY_MT7621_PCI is not set
# CONFIG_PHY_RALINK_USB is not set
# CONFIG_PHY_RCAR_GEN3_USB3 is not set
# CONFIG_PHY_ROCKCHIP_DPHY_RX0 is not set
# CONFIG_PHY_ROCKCHIP_INNO_HDMI is not set
# CONFIG_PHY_ROCKCHIP_INNO_USB2 is not set
# CONFIG_PHY_ROCKCHIP_INNO_CSIDPHY is not set
# CONFIG_PHY_ROCKCHIP_INNO_DSIDPHY is not set
# CONFIG_PHY_ROCKCHIP_PCIE is not set
# CONFIG_PHY_ROCKCHIP_TYPEC is not set
# CONFIG_PHY_EXYNOS_DP_VIDEO is not set
# CONFIG_PHY_EXYNOS_MIPI_VIDEO is not set
# CONFIG_PHY_EXYNOS_PCIE is not set
# CONFIG_PHY_SAMSUNG_UFS is not set
# CONFIG_PHY_SAMSUNG_USB2 is not set
# CONFIG_PHY_UNIPHIER_USB2 is not set
# CONFIG_PHY_UNIPHIER_USB3 is not set
# CONFIG_PHY_UNIPHIER_PCIE is not set
# CONFIG_PHY_UNIPHIER_AHCI is not set
# CONFIG_PHY_ST_SPEAR1310_MIPHY is not set
# CONFIG_PHY_ST_SPEAR1340_MIPHY is not set
# CONFIG_PHY_STIH407_USB is not set
# CONFIG_PHY_STM32_USBPHYC is not set
# CONFIG_PHY_TEGRA194_P2U is not set
# CONFIG_PHY_DA8XX_USB is not set
# CONFIG_PHY_DM816X_USB is not set
# CONFIG_PHY_AM654_SERDES is not set
# CONFIG_PHY_J721E_WIZ is not set
# CONFIG_OMAP_CONTROL_PHY is not set
# CONFIG_TI_PIPE3 is not set
CONFIG_PHY_TUSB1210=y
# CONFIG_PHY_INTEL_KEEMBAY_EMMC is not set
# CONFIG_PHY_INTEL_KEEMBAY_USB is not set
# CONFIG_PHY_INTEL_LGM_COMBO is not set
# CONFIG_PHY_INTEL_LGM_EMMC is not set
# CONFIG_PHY_INTEL_THUNDERBAY_EMMC is not set
# CONFIG_PHY_XILINX_ZYNQMP is not set
# end of PHY Subsystem

CONFIG_POWERCAP=y
# CONFIG_DTPM is not set
CONFIG_MCB=y
# CONFIG_MCB_PCI is not set
# CONFIG_MCB_LPC is not set

#
# Performance monitor support
#
# CONFIG_ARM_CCN is not set
# CONFIG_ARM_CMN is not set
# CONFIG_ARM_SMMU_V3_PMU is not set
# CONFIG_FSL_IMX8_DDR_PMU is not set
CONFIG_THUNDERX2_PMU=y
# CONFIG_XGENE_PMU is not set
# CONFIG_ARM_DMC620_PMU is not set
# CONFIG_MARVELL_CN10K_TAD_PMU is not set
# CONFIG_HNS3_PMU is not set
# CONFIG_MARVELL_CN10K_DDR_PMU is not set
# end of Performance monitor support

CONFIG_RAS=y
CONFIG_USB4=y
# CONFIG_USB4_DEBUGFS_WRITE is not set
CONFIG_USB4_DMA_TEST=y

#
# Android
#
CONFIG_ANDROID_BINDER_IPC=y
# CONFIG_ANDROID_BINDERFS is not set
CONFIG_ANDROID_BINDER_DEVICES="binder,hwbinder,vndbinder"
# CONFIG_ANDROID_BINDER_IPC_SELFTEST is not set
# end of Android

CONFIG_DAX=y
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y
# CONFIG_NVMEM_IMX_IIM is not set
# CONFIG_NVMEM_IMX_OCOTP is not set
# CONFIG_JZ4780_EFUSE is not set
# CONFIG_NVMEM_LPC18XX_EEPROM is not set
# CONFIG_NVMEM_LPC18XX_OTP is not set
# CONFIG_NVMEM_MXS_OCOTP is not set
# CONFIG_MTK_EFUSE is not set
# CONFIG_MICROCHIP_OTPC is not set
# CONFIG_NVMEM_NINTENDO_OTP is not set
# CONFIG_QCOM_QFPROM is not set
# CONFIG_ROCKCHIP_EFUSE is not set
# CONFIG_ROCKCHIP_OTP is not set
# CONFIG_NVMEM_BCM_OCOTP is not set
# CONFIG_NVMEM_STM32_ROMEM is not set
# CONFIG_UNIPHIER_EFUSE is not set
# CONFIG_NVMEM_VF610_OCOTP is not set
# CONFIG_MESON_MX_EFUSE is not set
# CONFIG_NVMEM_SNVS_LPGPR is not set
# CONFIG_SC27XX_EFUSE is not set
# CONFIG_SPRD_EFUSE is not set
CONFIG_NVMEM_RMEM=y
# CONFIG_NVMEM_BRCM_NVRAM is not set
# CONFIG_NVMEM_LAYERSCAPE_SFP is not set
# CONFIG_NVMEM_SUNPLUS_OCOTP is not set
# CONFIG_NVMEM_APPLE_EFUSES is not set

#
# HW tracing support
#
# CONFIG_STM is not set
CONFIG_INTEL_TH=y
CONFIG_INTEL_TH_PCI=y
# CONFIG_INTEL_TH_ACPI is not set
CONFIG_INTEL_TH_GTH=y
CONFIG_INTEL_TH_MSU=y
# CONFIG_INTEL_TH_PTI is not set
# CONFIG_INTEL_TH_DEBUG is not set
# end of HW tracing support

CONFIG_FPGA=y
# CONFIG_FPGA_MGR_SOCFPGA is not set
# CONFIG_FPGA_MGR_SOCFPGA_A10 is not set
# CONFIG_ALTERA_PR_IP_CORE is not set
# CONFIG_FPGA_MGR_ALTERA_PS_SPI is not set
CONFIG_FPGA_MGR_ALTERA_CVP=y
# CONFIG_FPGA_MGR_ZYNQ_FPGA is not set
# CONFIG_FPGA_MGR_XILINX_SPI is not set
# CONFIG_FPGA_MGR_ICE40_SPI is not set
# CONFIG_FPGA_MGR_MACHXO2_SPI is not set
CONFIG_FPGA_BRIDGE=y
CONFIG_ALTERA_FREEZE_BRIDGE=y
CONFIG_XILINX_PR_DECOUPLER=y
CONFIG_FPGA_REGION=y
# CONFIG_OF_FPGA_REGION is not set
CONFIG_FPGA_DFL=y
CONFIG_FPGA_DFL_FME=y
CONFIG_FPGA_DFL_FME_MGR=y
CONFIG_FPGA_DFL_FME_BRIDGE=y
# CONFIG_FPGA_DFL_FME_REGION is not set
CONFIG_FPGA_DFL_AFU=y
CONFIG_FPGA_DFL_NIOS_INTEL_PAC_N3000=y
# CONFIG_FPGA_DFL_PCI is not set
# CONFIG_FPGA_MGR_ZYNQMP_FPGA is not set
# CONFIG_FPGA_MGR_VERSAL_FPGA is not set
# CONFIG_FPGA_M10_BMC_SEC_UPDATE is not set
# CONFIG_FPGA_MGR_MICROCHIP_SPI is not set
# CONFIG_FSI is not set
# CONFIG_TEE is not set
CONFIG_MULTIPLEXER=y

#
# Multiplexer drivers
#
CONFIG_MUX_ADG792A=y
CONFIG_MUX_ADGS1408=y
CONFIG_MUX_GPIO=y
# CONFIG_MUX_MMIO is not set
# end of Multiplexer drivers

CONFIG_PM_OPP=y
CONFIG_SIOX=y
CONFIG_SIOX_BUS_GPIO=y
CONFIG_SLIMBUS=y
CONFIG_SLIM_QCOM_CTRL=y
CONFIG_INTERCONNECT=y
# CONFIG_INTERCONNECT_IMX is not set
# CONFIG_INTERCONNECT_QCOM_OSM_L3 is not set
# CONFIG_INTERCONNECT_SAMSUNG is not set
CONFIG_COUNTER=y
# CONFIG_104_QUAD_8 is not set
# CONFIG_INTERRUPT_CNT is not set
# CONFIG_STM32_TIMER_CNT is not set
# CONFIG_STM32_LPTIMER_CNT is not set
# CONFIG_TI_EQEP is not set
# CONFIG_FTM_QUADDEC is not set
# CONFIG_MICROCHIP_TCB_CAPTURE is not set
CONFIG_INTEL_QEP=y
CONFIG_MOST=y
# CONFIG_MOST_USB_HDM is not set
CONFIG_MOST_CDEV=y
CONFIG_MOST_SND=y
CONFIG_PECI=y
CONFIG_PECI_CPU=y
# CONFIG_PECI_ASPEED is not set
# CONFIG_HTE is not set
# end of Device Drivers

#
# File systems
#
CONFIG_VALIDATE_FS_PARSER=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
# CONFIG_EXPORTFS_BLOCK_OPS is not set
CONFIG_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
# CONFIG_FS_VERITY is not set
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
# CONFIG_QUOTA is not set
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=y
# CONFIG_CUSE is not set
# CONFIG_VIRTIO_FS is not set
# CONFIG_OVERLAY_FS is not set

#
# Caches
#
CONFIG_NETFS_SUPPORT=y
CONFIG_FSCACHE=y
CONFIG_FSCACHE_DEBUG=y
# end of Caches

#
# Pseudo filesystems
#
# CONFIG_PROC_FS is not set
# CONFIG_PROC_CHILDREN is not set
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
# CONFIG_TMPFS_INODE64 is not set
CONFIG_ARCH_SUPPORTS_HUGETLBFS=y
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_MEMFD_CREATE=y
CONFIG_CONFIGFS_FS=y
# CONFIG_EFIVAR_FS is not set
# end of Pseudo filesystems

# CONFIG_MISC_FILESYSTEMS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_CEPH_FS=y
# CONFIG_CEPH_FSCACHE is not set
# CONFIG_CEPH_FS_POSIX_ACL is not set
CONFIG_CIFS=y
CONFIG_CIFS_STATS2=y
# CONFIG_CIFS_ALLOW_INSECURE_LEGACY is not set
CONFIG_CIFS_UPCALL=y
CONFIG_CIFS_XATTR=y
CONFIG_CIFS_DEBUG=y
CONFIG_CIFS_DEBUG2=y
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
# CONFIG_CIFS_DFS_UPCALL is not set
# CONFIG_CIFS_SWN_UPCALL is not set
# CONFIG_CIFS_FSCACHE is not set
CONFIG_CIFS_ROOT=y
CONFIG_SMBFS_COMMON=y
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=y
CONFIG_NLS_CODEPAGE_775=y
CONFIG_NLS_CODEPAGE_850=y
CONFIG_NLS_CODEPAGE_852=y
CONFIG_NLS_CODEPAGE_855=y
CONFIG_NLS_CODEPAGE_857=y
CONFIG_NLS_CODEPAGE_860=y
# CONFIG_NLS_CODEPAGE_861 is not set
CONFIG_NLS_CODEPAGE_862=y
CONFIG_NLS_CODEPAGE_863=y
CONFIG_NLS_CODEPAGE_864=y
# CONFIG_NLS_CODEPAGE_865 is not set
CONFIG_NLS_CODEPAGE_866=y
CONFIG_NLS_CODEPAGE_869=y
CONFIG_NLS_CODEPAGE_936=y
CONFIG_NLS_CODEPAGE_950=y
CONFIG_NLS_CODEPAGE_932=y
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
CONFIG_NLS_ISO8859_8=y
# CONFIG_NLS_CODEPAGE_1250 is not set
CONFIG_NLS_CODEPAGE_1251=y
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_ISO8859_2=y
# CONFIG_NLS_ISO8859_3 is not set
CONFIG_NLS_ISO8859_4=y
CONFIG_NLS_ISO8859_5=y
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
CONFIG_NLS_ISO8859_9=y
CONFIG_NLS_ISO8859_13=y
CONFIG_NLS_ISO8859_14=y
CONFIG_NLS_ISO8859_15=y
CONFIG_NLS_KOI8_R=y
# CONFIG_NLS_KOI8_U is not set
CONFIG_NLS_MAC_ROMAN=y
CONFIG_NLS_MAC_CELTIC=y
CONFIG_NLS_MAC_CENTEURO=y
CONFIG_NLS_MAC_CROATIAN=y
CONFIG_NLS_MAC_CYRILLIC=y
CONFIG_NLS_MAC_GAELIC=y
CONFIG_NLS_MAC_GREEK=y
CONFIG_NLS_MAC_ICELAND=y
CONFIG_NLS_MAC_INUIT=y
CONFIG_NLS_MAC_ROMANIAN=y
# CONFIG_NLS_MAC_TURKISH is not set
CONFIG_NLS_UTF8=y
CONFIG_DLM=y
# CONFIG_DLM_DEPRECATED_API is not set
# CONFIG_DLM_DEBUG is not set
CONFIG_UNICODE=y
CONFIG_UNICODE_NORMALIZATION_SELFTEST=y
CONFIG_IO_WQ=y
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
CONFIG_KEYS_REQUEST_CACHE=y
# CONFIG_PERSISTENT_KEYRINGS is not set
CONFIG_BIG_KEYS=y
CONFIG_TRUSTED_KEYS=y
# CONFIG_TRUSTED_KEYS_TPM is not set

#
# No trust source selected!
#
CONFIG_ENCRYPTED_KEYS=y
CONFIG_USER_DECRYPTED_DATA=y
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_KEY_NOTIFICATIONS is not set
CONFIG_SECURITY_DMESG_RESTRICT=y
# CONFIG_SECURITYFS is not set
CONFIG_STATIC_USERMODEHELPER=y
CONFIG_STATIC_USERMODEHELPER_PATH="/sbin/usermode-helper"
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
# CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
CONFIG_INIT_ON_FREE_DEFAULT_ON=y
CONFIG_CC_HAS_ZERO_CALL_USED_REGS=y
CONFIG_ZERO_CALL_USED_REGS=y
# end of Memory initialization

CONFIG_RANDSTRUCT_NONE=y
# end of Kernel hardening options
# end of Security options

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
# CONFIG_CRYPTO_USER is not set
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
# CONFIG_CRYPTO_PCRYPT is not set
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=y
# CONFIG_CRYPTO_TEST is not set
CONFIG_CRYPTO_ENGINE=y

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=y
CONFIG_CRYPTO_DH_RFC7919_GROUPS=y
CONFIG_CRYPTO_ECC=y
CONFIG_CRYPTO_ECDH=y
# CONFIG_CRYPTO_ECDSA is not set
# CONFIG_CRYPTO_ECRDSA is not set
# CONFIG_CRYPTO_SM2 is not set
CONFIG_CRYPTO_CURVE25519=y

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=y
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_CHACHA20POLY1305=y
CONFIG_CRYPTO_AEGIS128=y
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
# CONFIG_CRYPTO_OFB is not set
# CONFIG_CRYPTO_PCBC is not set
CONFIG_CRYPTO_XCTR=y
CONFIG_CRYPTO_XTS=y
# CONFIG_CRYPTO_KEYWRAP is not set
CONFIG_CRYPTO_NHPOLY1305=y
CONFIG_CRYPTO_ADIANTUM=y
CONFIG_CRYPTO_HCTR2=y
CONFIG_CRYPTO_ESSIV=y

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=y
CONFIG_CRYPTO_HMAC=y
# CONFIG_CRYPTO_XCBC is not set
CONFIG_CRYPTO_VMAC=y

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32=y
CONFIG_CRYPTO_XXHASH=y
CONFIG_CRYPTO_BLAKE2B=y
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRC64_ROCKSOFT=y
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_POLYVAL=y
CONFIG_CRYPTO_POLY1305=y
CONFIG_CRYPTO_MD4=y
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=y
CONFIG_CRYPTO_RMD160=y
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=y
# CONFIG_CRYPTO_SM3_GENERIC is not set
# CONFIG_CRYPTO_STREEBOG is not set
CONFIG_CRYPTO_WP512=y

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
# CONFIG_CRYPTO_BLOWFISH is not set
# CONFIG_CRYPTO_CAMELLIA is not set
CONFIG_CRYPTO_CAST_COMMON=y
CONFIG_CRYPTO_CAST5=y
# CONFIG_CRYPTO_CAST6 is not set
CONFIG_CRYPTO_DES=y
CONFIG_CRYPTO_FCRYPT=y
CONFIG_CRYPTO_CHACHA20=y
# CONFIG_CRYPTO_ARIA is not set
CONFIG_CRYPTO_SERPENT=y
CONFIG_CRYPTO_SM4=y
CONFIG_CRYPTO_SM4_GENERIC=y
# CONFIG_CRYPTO_TWOFISH is not set

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
# CONFIG_CRYPTO_842 is not set
# CONFIG_CRYPTO_LZ4 is not set
# CONFIG_CRYPTO_LZ4HC is not set
CONFIG_CRYPTO_ZSTD=y

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=y
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
# CONFIG_CRYPTO_DRBG_CTR is not set
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_USER_API=y
CONFIG_CRYPTO_USER_API_HASH=y
CONFIG_CRYPTO_USER_API_SKCIPHER=y
CONFIG_CRYPTO_USER_API_RNG=y
# CONFIG_CRYPTO_USER_API_RNG_CAVP is not set
# CONFIG_CRYPTO_USER_API_AEAD is not set
# CONFIG_CRYPTO_USER_API_ENABLE_OBSOLETE is not set
CONFIG_CRYPTO_HASH_INFO=y
CONFIG_CRYPTO_HW=y
# CONFIG_CRYPTO_DEV_ALLWINNER is not set
# CONFIG_CRYPTO_DEV_EXYNOS_RNG is not set
# CONFIG_CRYPTO_DEV_S5P is not set
# CONFIG_CRYPTO_DEV_ATMEL_AES is not set
# CONFIG_CRYPTO_DEV_ATMEL_TDES is not set
# CONFIG_CRYPTO_DEV_ATMEL_SHA is not set
CONFIG_CRYPTO_DEV_ATMEL_I2C=y
CONFIG_CRYPTO_DEV_ATMEL_ECC=y
CONFIG_CRYPTO_DEV_ATMEL_SHA204A=y
CONFIG_CRYPTO_DEV_QAT=y
# CONFIG_CRYPTO_DEV_QAT_DH895xCC is not set
CONFIG_CRYPTO_DEV_QAT_C3XXX=y
CONFIG_CRYPTO_DEV_QAT_C62X=y
CONFIG_CRYPTO_DEV_QAT_4XXX=y
CONFIG_CRYPTO_DEV_QAT_DH895xCCVF=y
CONFIG_CRYPTO_DEV_QAT_C3XXXVF=y
CONFIG_CRYPTO_DEV_QAT_C62XVF=y
# CONFIG_CAVIUM_CPT is not set
CONFIG_CRYPTO_DEV_NITROX=y
CONFIG_CRYPTO_DEV_NITROX_CNN55XX=y
# CONFIG_CRYPTO_DEV_OCTEONTX_CPT is not set
# CONFIG_CRYPTO_DEV_OCTEONTX2_CPT is not set
# CONFIG_CRYPTO_DEV_CAVIUM_ZIP is not set
# CONFIG_CRYPTO_DEV_QCE is not set
# CONFIG_CRYPTO_DEV_QCOM_RNG is not set
# CONFIG_CRYPTO_DEV_IMGTEC_HASH is not set
# CONFIG_CRYPTO_DEV_ZYNQMP_AES is not set
# CONFIG_CRYPTO_DEV_ZYNQMP_SHA3 is not set
CONFIG_CRYPTO_DEV_VIRTIO=y
CONFIG_CRYPTO_DEV_SAFEXCEL=y
# CONFIG_CRYPTO_DEV_CCREE is not set
# CONFIG_CRYPTO_DEV_HISI_SEC is not set
# CONFIG_CRYPTO_DEV_HISI_SEC2 is not set
# CONFIG_CRYPTO_DEV_HISI_ZIP is not set
# CONFIG_CRYPTO_DEV_HISI_HPRE is not set
CONFIG_CRYPTO_DEV_AMLOGIC_GXL=y
CONFIG_CRYPTO_DEV_AMLOGIC_GXL_DEBUG=y
# CONFIG_CRYPTO_DEV_SA2UL is not set
# CONFIG_CRYPTO_DEV_KEEMBAY_OCS_AES_SM4 is not set
# CONFIG_CRYPTO_DEV_KEEMBAY_OCS_ECC is not set
# CONFIG_CRYPTO_DEV_KEEMBAY_OCS_HCU is not set
# CONFIG_ASYMMETRIC_KEY_TYPE is not set

#
# Certificates for signature checking
#
# CONFIG_SYSTEM_BLACKLIST_KEYRING is not set
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_LINEAR_RANGES=y
CONFIG_PACKING=y
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_CORDIC=y
CONFIG_PRIME_NUMBERS=y
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
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
CONFIG_CRYPTO_LIB_SHA1=y
CONFIG_CRYPTO_LIB_SHA256=y
# end of Crypto library routines

CONFIG_LIB_MEMNEQ=y
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
# CONFIG_CRC_T10DIF is not set
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
CONFIG_AUDIT_GENERIC=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=y
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
# CONFIG_XZ_DEC_X86 is not set
# CONFIG_XZ_DEC_POWERPC is not set
# CONFIG_XZ_DEC_IA64 is not set
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
CONFIG_XZ_DEC_MICROLZMA=y
CONFIG_XZ_DEC_BCJ=y
CONFIG_XZ_DEC_TEST=y
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_DECOMPRESS_ZSTD=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=y
CONFIG_REED_SOLOMON_ENC16=y
CONFIG_REED_SOLOMON_DEC16=y
CONFIG_INTERVAL_TREE=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_DMA_OPS=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_DMA_DECLARE_COHERENT=y
CONFIG_SWIOTLB=y
# CONFIG_DMA_RESTRICTED_POOL is not set
# CONFIG_DMA_CMA is not set
# CONFIG_DMA_API_DEBUG is not set
CONFIG_DMA_MAP_BENCHMARK=y
CONFIG_SGL_ALLOC=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
CONFIG_GLOB_SELFTEST=y
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
# CONFIG_IRQ_POLL is not set
CONFIG_MPILIB=y
CONFIG_DIMLIB=y
CONFIG_LIBFDT=y
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_MEMREGION=y
CONFIG_ARCH_STACKWALK=y
CONFIG_STACKDEPOT=y
CONFIG_REF_TRACKER=y
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
# CONFIG_DEBUG_INFO_DWARF4 is not set
CONFIG_DEBUG_INFO_DWARF5=y
# CONFIG_DEBUG_INFO_REDUCED is not set
CONFIG_DEBUG_INFO_COMPRESSED=y
# CONFIG_DEBUG_INFO_SPLIT is not set
# CONFIG_DEBUG_INFO_BTF is not set
CONFIG_PAHOLE_HAS_SPLIT_BTF=y
# CONFIG_GDB_SCRIPTS is not set
CONFIG_FRAME_WARN=2048
# CONFIG_STRIP_ASM_SYMS is not set
# CONFIG_READABLE_ASM is not set
# CONFIG_HEADERS_INSTALL is not set
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_VMLINUX_MAP=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# end of Compile-time checks and compiler options

#
# Generic Kernel Debugging Instruments
#
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE=""
CONFIG_DEBUG_FS=y
CONFIG_DEBUG_FS_ALLOW_ALL=y
# CONFIG_DEBUG_FS_DISALLOW_MOUNT is not set
# CONFIG_DEBUG_FS_ALLOW_NONE is not set
# CONFIG_UBSAN is not set
CONFIG_HAVE_KCSAN_COMPILER=y
# end of Generic Kernel Debugging Instruments

#
# Networking Debugging
#
# CONFIG_NET_DEV_REFCNT_TRACKER is not set
# CONFIG_NET_NS_REFCNT_TRACKER is not set
# CONFIG_DEBUG_NET is not set
# end of Networking Debugging

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
# CONFIG_DEBUG_PAGEALLOC is not set
CONFIG_PAGE_OWNER=y
CONFIG_PAGE_POISONING=y
CONFIG_DEBUG_PAGE_REF=y
CONFIG_DEBUG_OBJECTS=y
# CONFIG_DEBUG_OBJECTS_SELFTEST is not set
CONFIG_DEBUG_OBJECTS_FREE=y
CONFIG_DEBUG_OBJECTS_TIMERS=y
# CONFIG_DEBUG_OBJECTS_WORK is not set
# CONFIG_DEBUG_OBJECTS_RCU_HEAD is not set
CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER=y
CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=1
CONFIG_SHRINKER_DEBUG=y
CONFIG_DEBUG_STACK_USAGE=y
CONFIG_SCHED_STACK_END_CHECK=y
CONFIG_DEBUG_VM=y
# CONFIG_DEBUG_VM_VMACACHE is not set
CONFIG_DEBUG_VM_RB=y
CONFIG_DEBUG_VM_PGFLAGS=y
# CONFIG_DEBUG_MEMORY_INIT is not set
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
# end of Memory Debugging

CONFIG_DEBUG_SHIRQ=y

#
# Debug Oops, Lockups and Hangs
#
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
# CONFIG_SOFTLOCKUP_DETECTOR is not set
# CONFIG_DETECT_HUNG_TASK is not set
CONFIG_WQ_WATCHDOG=y
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
# end of Scheduler Debugging

# CONFIG_DEBUG_TIMEKEEPING is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
# CONFIG_PROVE_LOCKING is not set
CONFIG_LOCK_STAT=y
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
# CONFIG_DEBUG_RWSEMS is not set
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_LOCKDEP=y
CONFIG_LOCKDEP_BITS=15
CONFIG_LOCKDEP_CHAINS_BITS=16
CONFIG_LOCKDEP_STACK_TRACE_BITS=19
CONFIG_LOCKDEP_STACK_TRACE_HASH_BITS=14
CONFIG_LOCKDEP_CIRCULAR_QUEUE_BITS=12
CONFIG_DEBUG_LOCKDEP=y
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_LOCK_TORTURE_TEST is not set
# CONFIG_WW_MUTEX_SELFTEST is not set
CONFIG_SCF_TORTURE_TEST=y
# CONFIG_CSD_LOCK_WAIT_DEBUG is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_DEBUG_IRQFLAGS=y
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set
# CONFIG_DEBUG_KOBJECT_RELEASE is not set

#
# Debug kernel data structures
#
# CONFIG_DEBUG_LIST is not set
# CONFIG_DEBUG_PLIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
# end of Debug kernel data structures

CONFIG_DEBUG_CREDENTIALS=y

#
# RCU Debugging
#
CONFIG_TORTURE_TEST=y
CONFIG_RCU_SCALE_TEST=y
# CONFIG_RCU_TORTURE_TEST is not set
# CONFIG_RCU_REF_SCALE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=21
CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=0
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
# CONFIG_BOOTTIME_TRACING is not set
# CONFIG_IRQSOFF_TRACER is not set
CONFIG_SCHED_TRACER=y
# CONFIG_HWLAT_TRACER is not set
CONFIG_OSNOISE_TRACER=y
CONFIG_TIMERLAT_TRACER=y
# CONFIG_FTRACE_SYSCALLS is not set
CONFIG_TRACER_SNAPSHOT=y
# CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP is not set
CONFIG_TRACE_BRANCH_PROFILING=y
# CONFIG_BRANCH_PROFILE_NONE is not set
CONFIG_PROFILE_ANNOTATED_BRANCHES=y
# CONFIG_PROFILE_ALL_BRANCHES is not set
# CONFIG_BRANCH_TRACER is not set
CONFIG_DYNAMIC_EVENTS=y
CONFIG_SYNTH_EVENTS=y
# CONFIG_USER_EVENTS is not set
# CONFIG_TRACE_EVENT_INJECT is not set
# CONFIG_TRACEPOINT_BENCHMARK is not set
CONFIG_RING_BUFFER_BENCHMARK=y
CONFIG_TRACE_EVAL_MAP_FILE=y
CONFIG_GCOV_PROFILE_FTRACE=y
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS=y
CONFIG_SYNTH_EVENT_GEN_TEST=y
# CONFIG_RV is not set
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
# CONFIG_KUNIT is not set
CONFIG_NOTIFIER_ERROR_INJECTION=y
CONFIG_NETDEV_NOTIFIER_ERROR_INJECT=y
# CONFIG_FAULT_INJECTION is not set
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
CONFIG_RUNTIME_TESTING_MENU=y
# CONFIG_LKDTM is not set
CONFIG_TEST_MIN_HEAP=y
CONFIG_TEST_DIV64=y
CONFIG_BACKTRACE_SELF_TEST=y
CONFIG_TEST_REF_TRACKER=y
CONFIG_RBTREE_TEST=y
CONFIG_REED_SOLOMON_TEST=y
CONFIG_INTERVAL_TREE_TEST=y
# CONFIG_ATOMIC64_SELFTEST is not set
CONFIG_TEST_HEXDUMP=y
CONFIG_STRING_SELFTEST=y
# CONFIG_TEST_STRING_HELPERS is not set
CONFIG_TEST_STRSCPY=y
# CONFIG_TEST_KSTRTOX is not set
# CONFIG_TEST_PRINTF is not set
# CONFIG_TEST_SCANF is not set
# CONFIG_TEST_BITMAP is not set
# CONFIG_TEST_UUID is not set
CONFIG_TEST_XARRAY=y
CONFIG_TEST_RHASHTABLE=y
# CONFIG_TEST_SIPHASH is not set
# CONFIG_TEST_IDA is not set
# CONFIG_FIND_BIT_BENCHMARK is not set
CONFIG_TEST_FIRMWARE=y
# CONFIG_TEST_UDELAY is not set
# CONFIG_TEST_MEMCAT_P is not set
# CONFIG_TEST_MEMINIT is not set
# CONFIG_TEST_FREE_PAGES is not set
# end of Kernel Testing and Coverage

# CONFIG_WARN_MISSING_DOCUMENTS is not set
# CONFIG_WARN_ABI_ERRORS is not set
# end of Kernel hacking

--/+SrRbyQb96/jwl+--
