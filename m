Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 784E9648645
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 17:10:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbiLIQK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 11:10:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiLIQKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 11:10:24 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8034538A1
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 08:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670602220; x=1702138220;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=P/dU4RQFlpTZLAmRa9GYZhOhSSUjjcfZ5Ax3LlfHQ9s=;
  b=dGNmPbEJweGgpqApbX2igSMpSvlYii3MFel9ydSW7aoglBoIQMOmstbL
   tUO+uK00zxZxsNC8IHQGNoVaKhEpjRpe+WnGH/dD9mywLsoXS8/TzrQGl
   mpxsUGwvyFZk10F3BrXVjYNG6GeHLiBhB3jGgHrcHwzkXsx/BFbfaDrdB
   gPTpv1N6EI4kGO+iyfYwoELkpUGv8g7JgKHw5/qVxOY6kP+GkTXULxQKP
   LIRT81UlC8TsZ5ZykAODwHC42b8xjW+ZYf8gZCNApmgqyFgt08ySgsqO8
   wRc2c04qNuR0Qat38pWKldax6INwco1lmYrNI6ktJd7ZaqRobKRog8ZtI
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10556"; a="315125735"
X-IronPort-AV: E=Sophos;i="5.96,230,1665471600"; 
   d="scan'208";a="315125735"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2022 08:10:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10556"; a="754079794"
X-IronPort-AV: E=Sophos;i="5.96,230,1665471600"; 
   d="scan'208";a="754079794"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 09 Dec 2022 08:10:16 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p3fx1-0001xG-2i;
        Fri, 09 Dec 2022 16:10:15 +0000
Date:   Sat, 10 Dec 2022 00:10:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Xander Moerkerken <xandermoerkerken@gmail.com>,
        akpm@linux-foundation.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Xander Moerkerken <xander.moerkerken@gmail.com>
Subject: Re: [PATCH] Added ability to vmalloc executable memory
Message-ID: <202212092353.tQH6186P-lkp@intel.com>
References: <20221209131052.64235-1-xander.moerkerken@omron.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="olaM5A9KH40VOspV"
Content-Disposition: inline
In-Reply-To: <20221209131052.64235-1-xander.moerkerken@omron.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,UPPERCASE_50_75 autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--olaM5A9KH40VOspV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Xander,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on linus/master v6.1-rc8 next-20221208]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Xander-Moerkerken/Added-ability-to-vmalloc-executable-memory/20221209-211212
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20221209131052.64235-1-xander.moerkerken%40omron.com
patch subject: [PATCH] Added ability to vmalloc executable memory
config: hexagon-randconfig-r041-20221209
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 6e4cea55f0d1104408b26ac574566a0e4de48036)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/86c4449bb255bd5320d7b260034db7845878bc12
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Xander-Moerkerken/Added-ability-to-vmalloc-executable-memory/20221209-211212
        git checkout 86c4449bb255bd5320d7b260034db7845878bc12
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from mm/vmalloc.c:14:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
                                                     ^
   In file included from mm/vmalloc.c:14:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
                                                     ^
   In file included from mm/vmalloc.c:14:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
>> mm/vmalloc.c:3314:9: error: call to undeclared function '__vmalloc_node_prot'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           return __vmalloc_node_prot(size, 1, gfp_mask, PAGE_KERNEL_EXEC,
                  ^
>> mm/vmalloc.c:3314:9: error: incompatible integer to pointer conversion returning 'int' from a function with result type 'void *' [-Wint-conversion]
           return __vmalloc_node_prot(size, 1, gfp_mask, PAGE_KERNEL_EXEC,
                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   6 warnings and 2 errors generated.


vim +/__vmalloc_node_prot +3314 mm/vmalloc.c

  3310	
  3311	
  3312	void *__vmalloc_exec(unsigned long size, gfp_t gfp_mask)
  3313	{
> 3314		return __vmalloc_node_prot(size, 1, gfp_mask, PAGE_KERNEL_EXEC,
  3315		                          NUMA_NO_NODE, __builtin_return_address(0));
  3316	}
  3317	EXPORT_SYMBOL(__vmalloc_exec);
  3318	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

--olaM5A9KH40VOspV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=config

#
# Automatically generated file; DO NOT EDIT.
# Linux/hexagon 6.1.0-rc4 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="clang version 16.0.0 (git://gitmirror/llvm_project 6e4cea55f0d1104408b26ac574566a0e4de48036)"
CONFIG_GCC_VERSION=0
CONFIG_CC_IS_CLANG=y
CONFIG_CLANG_VERSION=160000
CONFIG_AS_IS_LLVM=y
CONFIG_AS_VERSION=160000
CONFIG_LD_VERSION=0
CONFIG_LD_IS_LLD=y
CONFIG_LLD_VERSION=160000
CONFIG_RUST_IS_AVAILABLE=y
CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y
CONFIG_TOOLS_SUPPORT_RELR=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_CC_HAS_NO_PROFILE_FN_ATTR=y
CONFIG_PAHOLE_VERSION=123
CONFIG_CONSTRUCTORS=y
CONFIG_IRQ_WORK=y

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
CONFIG_WATCH_QUEUE=y
# CONFIG_CROSS_MEMORY_ATTACH is not set
# CONFIG_USELIB is not set

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
# end of IRQ subsystem

CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_TIME_KUNIT_TEST=y
CONFIG_CONTEXT_TRACKING=y
CONFIG_CONTEXT_TRACKING_IDLE=y

#
# Timers subsystem
#
CONFIG_HZ_PERIODIC=y
# CONFIG_NO_HZ_IDLE is not set
# CONFIG_NO_HZ is not set
# CONFIG_HIGH_RES_TIMERS is not set
# end of Timers subsystem

CONFIG_BPF=y

#
# BPF subsystem
#
CONFIG_BPF_SYSCALL=y
CONFIG_BPF_UNPRIV_DEFAULT_OFF=y
# end of BPF subsystem

CONFIG_PREEMPT_NONE_BUILD=y
CONFIG_PREEMPT_NONE=y

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
# CONFIG_BSD_PROCESS_ACCT is not set
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
# CONFIG_FORCE_TASKS_RCU is not set
# CONFIG_FORCE_TASKS_RUDE_RCU is not set
# CONFIG_FORCE_TASKS_TRACE_RCU is not set
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_FANOUT=32
CONFIG_RCU_FANOUT_LEAF=16
CONFIG_RCU_NOCB_CPU=y
CONFIG_RCU_NOCB_CPU_DEFAULT_ALL=y
CONFIG_TASKS_TRACE_RCU_READ_MB=y
# end of RCU Subsystem

# CONFIG_IKCONFIG is not set
# CONFIG_IKHEADERS is not set
CONFIG_LOG_BUF_SHIFT=17
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
# CONFIG_PRINTK_INDEX is not set

#
# Scheduler features
#
# end of Scheduler features

CONFIG_CC_IMPLICIT_FALLTHROUGH="-Wimplicit-fallthrough"
CONFIG_GCC12_NO_ARRAY_BOUNDS=y
CONFIG_CGROUPS=y
# CONFIG_CGROUP_FAVOR_DYNMODS is not set
# CONFIG_MEMCG is not set
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
# CONFIG_CFS_BANDWIDTH is not set
CONFIG_RT_GROUP_SCHED=y
CONFIG_CGROUP_PIDS=y
# CONFIG_CGROUP_RDMA is not set
# CONFIG_CGROUP_FREEZER is not set
# CONFIG_CPUSETS is not set
CONFIG_CGROUP_DEVICE=y
# CONFIG_CGROUP_CPUACCT is not set
# CONFIG_CGROUP_PERF is not set
CONFIG_CGROUP_BPF=y
# CONFIG_CGROUP_MISC is not set
CONFIG_CGROUP_DEBUG=y
CONFIG_SOCK_CGROUP_DATA=y
CONFIG_NAMESPACES=y
# CONFIG_UTS_NS is not set
# CONFIG_USER_NS is not set
# CONFIG_PID_NS is not set
CONFIG_SCHED_AUTOGROUP=y
CONFIG_SYSFS_DEPRECATED=y
CONFIG_SYSFS_DEPRECATED_V2=y
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
# CONFIG_RD_BZIP2 is not set
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
# CONFIG_RD_LZO is not set
CONFIG_RD_LZ4=y
CONFIG_RD_ZSTD=y
CONFIG_BOOT_CONFIG=y
# CONFIG_BOOT_CONFIG_EMBED is not set
CONFIG_INITRAMFS_PRESERVE_MTIME=y
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_LD_ORPHAN_WARN=y
CONFIG_EXPERT=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
# CONFIG_FHANDLE is not set
# CONFIG_POSIX_TIMERS is not set
CONFIG_PRINTK=y
CONFIG_BUG=y
# CONFIG_ELF_CORE is not set
# CONFIG_BASE_FULL is not set
# CONFIG_FUTEX is not set
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
# CONFIG_TIMERFD is not set
# CONFIG_EVENTFD is not set
CONFIG_SHMEM=y
CONFIG_AIO=y
# CONFIG_IO_URING is not set
CONFIG_ADVISE_SYSCALLS=y
# CONFIG_MEMBARRIER is not set
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_KCMP=y
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y
# CONFIG_PC104 is not set

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

# CONFIG_PROFILING is not set
CONFIG_TRACEPOINTS=y
# end of General setup

#
# Linux Kernel Configuration for Hexagon
#
CONFIG_HEXAGON=y
CONFIG_HEXAGON_PHYS_OFFSET=y
CONFIG_FRAME_POINTER=y
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_EARLY_PRINTK=y
CONFIG_MMU=y
CONFIG_GENERIC_CSUM=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_GENERIC_BUG=y

#
# Machine selection
#
CONFIG_HEXAGON_COMET=y
CONFIG_HEXAGON_ARCH_VERSION=2
CONFIG_CMDLINE=""
CONFIG_SMP=y
CONFIG_NR_CPUS=6
# CONFIG_PAGE_SIZE_4KB is not set
# CONFIG_PAGE_SIZE_16KB is not set
# CONFIG_PAGE_SIZE_64KB is not set
CONFIG_PAGE_SIZE_256KB=y
# CONFIG_HZ_100 is not set
CONFIG_HZ_250=y
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=250
# end of Machine selection

#
# General architecture-dependent options
#
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_32BIT_OFF_T=y
CONFIG_LTO_NONE=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_PGTABLE_LEVELS=2
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_ARCH_NO_PREEMPT=y
# CONFIG_LOCK_EVENT_COUNTS is not set
CONFIG_ARCH_WANT_LD_ORPHAN_WARN=y

#
# GCOV-based kernel profiling
#
CONFIG_GCOV_KERNEL=y
# end of GCOV-based kernel profiling
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=1
# CONFIG_MODULES is not set
# CONFIG_BLOCK is not set
CONFIG_ASN1=y
CONFIG_UNINLINE_SPIN_UNLOCK=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
# CONFIG_BINFMT_ELF_KUNIT_TEST is not set
CONFIG_ELFCORE=y
# CONFIG_BINFMT_SCRIPT is not set
CONFIG_BINFMT_MISC=y
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#

#
# SLAB allocator options
#
CONFIG_SLAB=y
# CONFIG_SLUB is not set
# CONFIG_SLOB is not set
CONFIG_SLAB_MERGE_DEFAULT=y
CONFIG_SLAB_FREELIST_RANDOM=y
# CONFIG_SLAB_FREELIST_HARDENED is not set
# end of SLAB allocator options

# CONFIG_SHUFFLE_PAGE_ALLOCATOR is not set
CONFIG_COMPAT_BRK=y
CONFIG_FLATMEM=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_MEMORY_BALLOON=y
# CONFIG_COMPACTION is not set
CONFIG_PAGE_REPORTING=y
# CONFIG_KSM is not set
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
# CONFIG_CMA is not set
CONFIG_PAGE_IDLE_FLAG=y
# CONFIG_IDLE_PAGE_TRACKING is not set
# CONFIG_VM_EVENT_COUNTERS is not set
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_TEST is not set
# CONFIG_USERFAULTFD is not set
# CONFIG_LRU_GEN is not set

#
# Data Access Monitoring
#
CONFIG_DAMON=y
# CONFIG_DAMON_KUNIT_TEST is not set
CONFIG_DAMON_VADDR=y
# CONFIG_DAMON_PADDR is not set
CONFIG_DAMON_VADDR_KUNIT_TEST=y
# CONFIG_DAMON_SYSFS is not set
# end of Data Access Monitoring
# end of Memory Management options

# CONFIG_NET is not set

#
# Device Drivers
#
# CONFIG_PCCARD is not set

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
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_FW_LOADER_SYSFS=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
CONFIG_FW_LOADER_COMPRESS=y
CONFIG_FW_LOADER_COMPRESS_XZ=y
# CONFIG_FW_LOADER_COMPRESS_ZSTD is not set
# CONFIG_FW_UPLOAD is not set
# end of Firmware loader

CONFIG_WANT_DEV_COREDUMP=y
CONFIG_ALLOW_DEV_COREDUMP=y
CONFIG_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
CONFIG_DEBUG_DEVRES=y
CONFIG_DEBUG_TEST_DRIVER_REMOVE=y
# CONFIG_PM_QOS_KUNIT_TEST is not set
# CONFIG_DRIVER_PE_KUNIT_TEST is not set
CONFIG_GENERIC_CPU_DEVICES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SLIMBUS=y
CONFIG_REGMAP_SPI=y
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_REGMAP_SCCB=y
CONFIG_REGMAP_I3C=y
CONFIG_DMA_SHARED_BUFFER=y
CONFIG_DMA_FENCE_TRACE=y
# end of Generic Driver Options

#
# Bus devices
#
# CONFIG_ARM_INTEGRATOR_LM is not set
# CONFIG_BT1_APB is not set
# CONFIG_BT1_AXI is not set
# CONFIG_INTEL_IXP4XX_EB is not set
# CONFIG_QCOM_EBI2 is not set
# CONFIG_MHI_BUS is not set
# CONFIG_MHI_BUS_EP is not set
# end of Bus devices

#
# Firmware Drivers
#

#
# ARM System Control and Management Interface Protocol
#
# CONFIG_ARM_SCMI_PROTOCOL is not set
# end of ARM System Control and Management Interface Protocol

CONFIG_FIRMWARE_MEMMAP=y
# CONFIG_BCM47XX_NVRAM is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

# CONFIG_GNSS is not set
CONFIG_MTD=y

#
# Partition parsers
#
# CONFIG_MTD_AR7_PARTS is not set
# CONFIG_MTD_BCM63XX_PARTS is not set
# CONFIG_MTD_BRCM_U_BOOT is not set
CONFIG_MTD_CMDLINE_PARTS=y
# CONFIG_MTD_PARSER_IMAGETAG is not set
# CONFIG_MTD_PARSER_TRX is not set
# CONFIG_MTD_SHARPSL_PARTS is not set
# CONFIG_MTD_REDBOOT_PARTS is not set
# end of Partition parsers

#
# User Modules And Translation Layers
#
CONFIG_MTD_OOPS=y
# CONFIG_MTD_PARTITIONED_MASTER is not set

#
# RAM/ROM/Flash chip drivers
#
CONFIG_MTD_CFI=y
CONFIG_MTD_JEDECPROBE=y
CONFIG_MTD_GEN_PROBE=y
CONFIG_MTD_CFI_ADV_OPTIONS=y
# CONFIG_MTD_CFI_NOSWAP is not set
CONFIG_MTD_CFI_BE_BYTE_SWAP=y
# CONFIG_MTD_CFI_LE_BYTE_SWAP is not set
# CONFIG_MTD_CFI_GEOMETRY is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
CONFIG_MTD_OTP=y
CONFIG_MTD_CFI_INTELEXT=y
CONFIG_MTD_CFI_AMDSTD=y
CONFIG_MTD_CFI_STAA=y
CONFIG_MTD_CFI_UTIL=y
CONFIG_MTD_RAM=y
CONFIG_MTD_ROM=y
CONFIG_MTD_ABSENT=y
# end of RAM/ROM/Flash chip drivers

#
# Mapping drivers for chip access
#
CONFIG_MTD_COMPLEX_MAPPINGS=y
CONFIG_MTD_PHYSMAP=y
CONFIG_MTD_PHYSMAP_COMPAT=y
CONFIG_MTD_PHYSMAP_START=0x8000000
CONFIG_MTD_PHYSMAP_LEN=0
CONFIG_MTD_PHYSMAP_BANKWIDTH=2
CONFIG_MTD_PHYSMAP_GPIO_ADDR=y
# CONFIG_MTD_SC520CDP is not set
# CONFIG_MTD_NETSC520 is not set
# CONFIG_MTD_TS5500 is not set
CONFIG_MTD_PLATRAM=y
# end of Mapping drivers for chip access

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_DATAFLASH is not set
CONFIG_MTD_MCHP23K256=y
# CONFIG_MTD_MCHP48L640 is not set
CONFIG_MTD_SPEAR_SMI=y
# CONFIG_MTD_SST25L is not set
# CONFIG_MTD_SLRAM is not set
CONFIG_MTD_PHRAM=y
# CONFIG_MTD_MTDRAM is not set

#
# Disk-On-Chip Device Drivers
#
# CONFIG_MTD_DOCG3 is not set
# end of Self-contained MTD device drivers

#
# NAND
#
CONFIG_MTD_NAND_CORE=y
CONFIG_MTD_ONENAND=y
CONFIG_MTD_ONENAND_VERIFY_WRITE=y
CONFIG_MTD_ONENAND_GENERIC=y
# CONFIG_MTD_ONENAND_SAMSUNG is not set
CONFIG_MTD_ONENAND_OTP=y
CONFIG_MTD_ONENAND_2X_PROGRAM=y
# CONFIG_MTD_RAW_NAND is not set
# CONFIG_MTD_SPI_NAND is not set

#
# ECC engine support
#
CONFIG_MTD_NAND_ECC=y
# CONFIG_MTD_NAND_ECC_SW_HAMMING is not set
# CONFIG_MTD_NAND_ECC_SW_BCH is not set
CONFIG_MTD_NAND_ECC_MXIC=y
# CONFIG_MTD_NAND_ECC_MEDIATEK is not set
# end of ECC engine support
# end of NAND

#
# LPDDR & LPDDR2 PCM memory drivers
#
CONFIG_MTD_LPDDR=y
CONFIG_MTD_QINFO_PROBE=y
# end of LPDDR & LPDDR2 PCM memory drivers

CONFIG_MTD_SPI_NOR=y
CONFIG_MTD_SPI_NOR_USE_4K_SECTORS=y
# CONFIG_MTD_SPI_NOR_SWP_DISABLE is not set
# CONFIG_MTD_SPI_NOR_SWP_DISABLE_ON_VOLATILE is not set
CONFIG_MTD_SPI_NOR_SWP_KEEP=y
# CONFIG_SPI_HISI_SFC is not set
# CONFIG_MTD_UBI is not set
CONFIG_MTD_HYPERBUS=y
# CONFIG_HBMC_AM654 is not set
# CONFIG_OF is not set
# CONFIG_PARPORT is not set

#
# NVME Support
#
# end of NVME Support

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=y
# CONFIG_AD525X_DPOT is not set
CONFIG_DUMMY_IRQ=y
CONFIG_ICS932S401=y
# CONFIG_ATMEL_SSC is not set
CONFIG_ENCLOSURE_SERVICES=y
# CONFIG_GEHC_ACHC is not set
# CONFIG_QCOM_COINCELL is not set
CONFIG_APDS9802ALS=y
CONFIG_ISL29003=y
# CONFIG_ISL29020 is not set
# CONFIG_SENSORS_TSL2550 is not set
# CONFIG_SENSORS_BH1770 is not set
# CONFIG_SENSORS_APDS990X is not set
CONFIG_HMC6352=y
CONFIG_DS1682=y
# CONFIG_LATTICE_ECP3_CONFIG is not set
# CONFIG_SRAM is not set
# CONFIG_XILINX_SDFEC is not set
# CONFIG_HISI_HIKEY_USB is not set
CONFIG_C2PORT=y

#
# EEPROM support
#
CONFIG_EEPROM_AT24=y
CONFIG_EEPROM_AT25=y
# CONFIG_EEPROM_LEGACY is not set
# CONFIG_EEPROM_MAX6875 is not set
CONFIG_EEPROM_93CX6=y
CONFIG_EEPROM_93XX46=y
CONFIG_EEPROM_IDT_89HPESX=y
CONFIG_EEPROM_EE1004=y
# end of EEPROM support

#
# Texas Instruments shared transport line discipline
#
# end of Texas Instruments shared transport line discipline

CONFIG_SENSORS_LIS3_SPI=y
CONFIG_SENSORS_LIS3_I2C=y
# CONFIG_ALTERA_STAPL is not set
CONFIG_ECHO=y
# CONFIG_MISC_RTSX_USB is not set
CONFIG_UACCE=y
# CONFIG_PVPANIC is not set
# end of Misc devices

#
# SCSI device support
#
# end of SCSI device support

#
# IEEE 1394 (FireWire) support
#
# CONFIG_FIREWIRE is not set
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
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_EVDEV is not set
CONFIG_INPUT_EVBUG=y

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ADC=y
CONFIG_KEYBOARD_ADP5588=y
# CONFIG_KEYBOARD_ADP5589 is not set
CONFIG_KEYBOARD_ATKBD=y
CONFIG_KEYBOARD_QT1050=y
CONFIG_KEYBOARD_QT1070=y
CONFIG_KEYBOARD_QT2160=y
# CONFIG_KEYBOARD_CLPS711X is not set
CONFIG_KEYBOARD_DLINK_DIR685=y
CONFIG_KEYBOARD_LKKBD=y
# CONFIG_KEYBOARD_EP93XX is not set
# CONFIG_KEYBOARD_GPIO is not set
# CONFIG_KEYBOARD_GPIO_POLLED is not set
CONFIG_KEYBOARD_TCA6416=y
# CONFIG_KEYBOARD_TCA8418 is not set
CONFIG_KEYBOARD_MATRIX=y
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
CONFIG_KEYBOARD_MCS=y
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_IMX is not set
CONFIG_KEYBOARD_NEWTON=y
CONFIG_KEYBOARD_OPENCORES=y
# CONFIG_KEYBOARD_PINEPHONE is not set
CONFIG_KEYBOARD_SAMSUNG=y
CONFIG_KEYBOARD_GOLDFISH_EVENTS=y
CONFIG_KEYBOARD_STOWAWAY=y
# CONFIG_KEYBOARD_ST_KEYSCAN is not set
CONFIG_KEYBOARD_SUNKBD=y
# CONFIG_KEYBOARD_SH_KEYSC is not set
CONFIG_KEYBOARD_TM2_TOUCHKEY=y
# CONFIG_KEYBOARD_TWL4030 is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_MT6779 is not set
# CONFIG_KEYBOARD_MTK_PMIC is not set
# CONFIG_KEYBOARD_CYPRESS_SF is not set
# CONFIG_INPUT_MOUSE is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set
# CONFIG_RMI4_CORE is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_SERIO_SERPORT=y
CONFIG_SERIO_LIBPS2=y
# CONFIG_SERIO_RAW is not set
CONFIG_SERIO_ALTERA_PS2=y
CONFIG_SERIO_PS2MULT=y
CONFIG_SERIO_ARC_PS2=y
# CONFIG_SERIO_OLPC_APSP is not set
# CONFIG_SERIO_SUN4I_PS2 is not set
# CONFIG_SERIO_GPIO_PS2 is not set
CONFIG_USERIO=y
CONFIG_GAMEPORT=y
CONFIG_GAMEPORT_NS558=y
CONFIG_GAMEPORT_L4=y
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
# CONFIG_VT is not set
# CONFIG_UNIX98_PTYS is not set
# CONFIG_LEGACY_PTYS is not set
# CONFIG_LDISC_AUTOLOAD is not set

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
# CONFIG_SERIAL_8250 is not set

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_AMBA_PL010 is not set
# CONFIG_SERIAL_ATMEL is not set
# CONFIG_SERIAL_MESON is not set
# CONFIG_SERIAL_CLPS711X is not set
# CONFIG_SERIAL_SAMSUNG is not set
# CONFIG_SERIAL_TEGRA is not set
# CONFIG_SERIAL_MAX3100 is not set
# CONFIG_SERIAL_MAX310X is not set
# CONFIG_SERIAL_IMX is not set
CONFIG_SERIAL_UARTLITE=y
# CONFIG_SERIAL_UARTLITE_CONSOLE is not set
CONFIG_SERIAL_UARTLITE_NR_UARTS=1
# CONFIG_SERIAL_SH_SCI is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_MSM is not set
# CONFIG_SERIAL_VT8500 is not set
# CONFIG_SERIAL_OMAP is not set
# CONFIG_SERIAL_LANTIQ is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_TIMBERDALE is not set
# CONFIG_SERIAL_BCM63XX is not set
CONFIG_SERIAL_ALTERA_JTAGUART=y
CONFIG_SERIAL_ALTERA_JTAGUART_CONSOLE=y
# CONFIG_SERIAL_ALTERA_JTAGUART_CONSOLE_BYPASS is not set
CONFIG_SERIAL_ALTERA_UART=y
CONFIG_SERIAL_ALTERA_UART_MAXPORTS=4
CONFIG_SERIAL_ALTERA_UART_BAUDRATE=115200
# CONFIG_SERIAL_ALTERA_UART_CONSOLE is not set
# CONFIG_SERIAL_MXS_AUART is not set
# CONFIG_SERIAL_MPS2_UART is not set
CONFIG_SERIAL_ARC=y
# CONFIG_SERIAL_ARC_CONSOLE is not set
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_FSL_LPUART is not set
CONFIG_SERIAL_FSL_LINFLEXUART=y
CONFIG_SERIAL_FSL_LINFLEXUART_CONSOLE=y
# CONFIG_SERIAL_ST_ASC is not set
CONFIG_SERIAL_SPRD=y
CONFIG_SERIAL_SPRD_CONSOLE=y
# CONFIG_SERIAL_STM32 is not set
# CONFIG_SERIAL_MVEBU_UART is not set
# CONFIG_SERIAL_OWL is not set
# CONFIG_SERIAL_RDA is not set
# CONFIG_SERIAL_LITEUART is not set
# CONFIG_SERIAL_SUNPLUS is not set
# end of Serial drivers

# CONFIG_SERIAL_NONSTANDARD is not set
# CONFIG_GOLDFISH_TTY is not set
CONFIG_NULL_TTY=y
CONFIG_SERIAL_DEV_BUS=y
CONFIG_SERIAL_DEV_CTRL_TTYPORT=y
CONFIG_TTY_PRINTK=y
CONFIG_TTY_PRINTK_LEVEL=6
# CONFIG_VIRTIO_CONSOLE is not set
CONFIG_IPMI_HANDLER=y
CONFIG_IPMI_PLAT_DATA=y
CONFIG_IPMI_PANIC_EVENT=y
# CONFIG_IPMI_PANIC_STRING is not set
# CONFIG_IPMI_DEVICE_INTERFACE is not set
CONFIG_IPMI_SI=y
CONFIG_IPMI_SSIF=y
# CONFIG_IPMI_IPMB is not set
CONFIG_IPMI_WATCHDOG=y
CONFIG_IPMI_POWEROFF=y
# CONFIG_ASPEED_KCS_IPMI_BMC is not set
# CONFIG_NPCM7XX_KCS_IPMI_BMC is not set
# CONFIG_ASPEED_BT_IPMI_BMC is not set
# CONFIG_IPMB_DEVICE_INTERFACE is not set
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=y
CONFIG_HW_RANDOM_BA431=y
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
# CONFIG_HW_RANDOM_XIPHERA is not set
CONFIG_DEVMEM=y
# CONFIG_TCG_TPM is not set
CONFIG_XILLYBUS_CLASS=y
CONFIG_XILLYUSB=y
CONFIG_RANDOM_TRUST_CPU=y
# CONFIG_RANDOM_TRUST_BOOTLOADER is not set
# end of Character devices

#
# I2C support
#
CONFIG_I2C=y
CONFIG_I2C_BOARDINFO=y
# CONFIG_I2C_COMPAT is not set
CONFIG_I2C_CHARDEV=y
CONFIG_I2C_MUX=y

#
# Multiplexer I2C Chip support
#
# CONFIG_I2C_MUX_GPIO is not set
# CONFIG_I2C_MUX_LTC4306 is not set
# CONFIG_I2C_MUX_PCA9541 is not set
# CONFIG_I2C_MUX_PCA954x is not set
CONFIG_I2C_MUX_REG=y
# CONFIG_I2C_MUX_MLXCPLD is not set
# end of Multiplexer I2C Chip support

CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_ALGOBIT=y

#
# I2C Hardware Bus support
#
# CONFIG_I2C_HIX5HD2 is not set

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
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
CONFIG_I2C_DESIGNWARE_SLAVE=y
CONFIG_I2C_DESIGNWARE_PLATFORM=y
# CONFIG_I2C_DIGICOLOR is not set
CONFIG_I2C_EMEV2=y
CONFIG_I2C_GPIO=y
# CONFIG_I2C_GPIO_FAULT_INJECTOR is not set
# CONFIG_I2C_HIGHLANDER is not set
# CONFIG_I2C_HISI is not set
# CONFIG_I2C_IMG is not set
# CONFIG_I2C_IMX is not set
# CONFIG_I2C_IMX_LPI2C is not set
# CONFIG_I2C_IOP3XX is not set
# CONFIG_I2C_JZ4780 is not set
# CONFIG_I2C_MESON is not set
# CONFIG_I2C_MT65XX is not set
# CONFIG_I2C_MT7621 is not set
# CONFIG_I2C_MV64XXX is not set
# CONFIG_I2C_MXS is not set
# CONFIG_I2C_NPCM is not set
CONFIG_I2C_OCORES=y
# CONFIG_I2C_OMAP is not set
# CONFIG_I2C_OWL is not set
# CONFIG_I2C_APPLE is not set
# CONFIG_I2C_PCA_PLATFORM is not set
# CONFIG_I2C_PNX is not set
# CONFIG_I2C_PXA is not set
# CONFIG_I2C_QCOM_CCI is not set
# CONFIG_I2C_QUP is not set
# CONFIG_I2C_RIIC is not set
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
# CONFIG_I2C_XILINX is not set
# CONFIG_I2C_XLP9XX is not set
# CONFIG_I2C_RCAR is not set

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_DIOLAN_U2C=y
CONFIG_I2C_CP2615=y
CONFIG_I2C_ROBOTFUZZ_OSIF=y
CONFIG_I2C_TAOS_EVM=y
# CONFIG_I2C_TINY_USB is not set
# CONFIG_I2C_VIPERBOARD is not set

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
CONFIG_I2C_DEBUG_ALGO=y
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

CONFIG_I3C=y
# CONFIG_CDNS_I3C_MASTER is not set
CONFIG_DW_I3C_MASTER=y
CONFIG_SVC_I3C_MASTER=y
CONFIG_MIPI_I3C_HCI=y
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y
CONFIG_SPI_MEM=y

#
# SPI Master Controller Drivers
#
CONFIG_SPI_ALTERA=y
CONFIG_SPI_ALTERA_CORE=y
# CONFIG_SPI_AR934X is not set
# CONFIG_SPI_ATH79 is not set
# CONFIG_SPI_ARMADA_3700 is not set
CONFIG_SPI_AXI_SPI_ENGINE=y
# CONFIG_SPI_BCM2835 is not set
# CONFIG_SPI_BCM2835AUX is not set
# CONFIG_SPI_BCM63XX is not set
# CONFIG_SPI_BCM63XX_HSSPI is not set
# CONFIG_SPI_BCM_QSPI is not set
CONFIG_SPI_BITBANG=y
CONFIG_SPI_CADENCE=y
# CONFIG_SPI_CADENCE_XSPI is not set
# CONFIG_SPI_CLPS711X is not set
CONFIG_SPI_DESIGNWARE=y
CONFIG_SPI_DW_DMA=y
CONFIG_SPI_DW_MMIO=y
# CONFIG_SPI_DW_BT1 is not set
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
# CONFIG_SPI_INTEL_PLATFORM is not set
# CONFIG_SPI_LP8841_RTC is not set
# CONFIG_SPI_FSL_DSPI is not set
# CONFIG_SPI_MESON_SPICC is not set
# CONFIG_SPI_MESON_SPIFC is not set
# CONFIG_SPI_MICROCHIP_CORE is not set
# CONFIG_SPI_MICROCHIP_CORE_QSPI is not set
# CONFIG_SPI_MT65XX is not set
# CONFIG_SPI_MT7621 is not set
# CONFIG_SPI_MTK_NOR is not set
# CONFIG_SPI_NPCM_PSPI is not set
# CONFIG_SPI_LANTIQ_SSC is not set
# CONFIG_SPI_OC_TINY is not set
# CONFIG_SPI_OMAP24XX is not set
# CONFIG_SPI_TI_QSPI is not set
# CONFIG_SPI_OMAP_100K is not set
# CONFIG_SPI_ORION is not set
# CONFIG_SPI_PIC32 is not set
# CONFIG_SPI_PIC32_SQI is not set
# CONFIG_SPI_PXA2XX is not set
# CONFIG_SPI_ROCKCHIP is not set
# CONFIG_SPI_ROCKCHIP_SFC is not set
# CONFIG_SPI_RSPI is not set
# CONFIG_SPI_QUP is not set
# CONFIG_SPI_S3C64XX is not set
CONFIG_SPI_SC18IS602=y
# CONFIG_SPI_SH_MSIOF is not set
# CONFIG_SPI_SH is not set
# CONFIG_SPI_SH_HSPI is not set
CONFIG_SPI_SIFIVE=y
# CONFIG_SPI_SPRD is not set
# CONFIG_SPI_SPRD_ADI is not set
# CONFIG_SPI_STM32 is not set
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
# CONFIG_SPI_XCOMM is not set
# CONFIG_SPI_XILINX is not set
# CONFIG_SPI_XLP is not set
# CONFIG_SPI_XTENSA_XTFPGA is not set
# CONFIG_SPI_ZYNQ_QSPI is not set
CONFIG_SPI_ZYNQMP_GQSPI=y
# CONFIG_SPI_AMD is not set

#
# SPI Multiplexer support
#
# CONFIG_SPI_MUX is not set

#
# SPI Protocol Masters
#
CONFIG_SPI_SPIDEV=y
CONFIG_SPI_TLE62X0=y
# CONFIG_SPI_SLAVE is not set
# CONFIG_SPMI is not set
# CONFIG_HSI is not set
# CONFIG_PPS is not set

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
CONFIG_DEBUG_PINCTRL=y
# CONFIG_PINCTRL_AMD is not set
# CONFIG_PINCTRL_CY8C95X0 is not set
CONFIG_PINCTRL_MCP23S08_I2C=y
CONFIG_PINCTRL_MCP23S08_SPI=y
CONFIG_PINCTRL_MCP23S08=y
CONFIG_PINCTRL_SX150X=y

#
# Intel pinctrl drivers
#
# end of Intel pinctrl drivers

#
# MediaTek pinctrl drivers
#
# CONFIG_EINT_MTK is not set
# end of MediaTek pinctrl drivers

# CONFIG_PINCTRL_PXA25X is not set
# CONFIG_PINCTRL_PXA27X is not set
# CONFIG_PINCTRL_MSM is not set
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
# CONFIG_PINCTRL_PFC_R8A77470 is not set
# CONFIG_PINCTRL_PFC_R8A7745 is not set
# CONFIG_PINCTRL_PFC_R8A7742 is not set
# CONFIG_PINCTRL_PFC_R8A7743 is not set
# CONFIG_PINCTRL_PFC_R8A7744 is not set
# CONFIG_PINCTRL_PFC_R8A774C0 is not set
# CONFIG_PINCTRL_PFC_R8A774E1 is not set
# CONFIG_PINCTRL_PFC_R8A774A1 is not set
# CONFIG_PINCTRL_PFC_R8A774B1 is not set
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

CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_GPIOLIB_IRQCHIP=y
CONFIG_DEBUG_GPIO=y
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_CDEV=y
# CONFIG_GPIO_CDEV_V1 is not set
CONFIG_GPIO_GENERIC=y
CONFIG_GPIO_MAX730X=y

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_ATH79 is not set
# CONFIG_GPIO_CLPS711X is not set
# CONFIG_GPIO_DWAPB is not set
CONFIG_GPIO_GENERIC_PLATFORM=y
# CONFIG_GPIO_HISI is not set
# CONFIG_GPIO_IOP is not set
CONFIG_GPIO_MB86S7X=y
# CONFIG_GPIO_MPC8XXX is not set
# CONFIG_GPIO_MXC is not set
# CONFIG_GPIO_MXS is not set
# CONFIG_GPIO_PXA is not set
# CONFIG_GPIO_RCAR is not set
# CONFIG_GPIO_ROCKCHIP is not set
CONFIG_GPIO_SIOX=y
# CONFIG_GPIO_XGENE_SB is not set
# CONFIG_GPIO_XLP is not set
# CONFIG_GPIO_AMD_FCH is not set
# CONFIG_GPIO_IDT3243X is not set
# end of Memory mapped GPIO drivers

#
# I2C GPIO expanders
#
CONFIG_GPIO_MAX7300=y
CONFIG_GPIO_MAX732X=y
CONFIG_GPIO_MAX732X_IRQ=y
# CONFIG_GPIO_PCA953X is not set
# CONFIG_GPIO_PCA9570 is not set
# CONFIG_GPIO_PCF857X is not set
CONFIG_GPIO_TPIC2810=y
# CONFIG_GPIO_TS4900 is not set
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
CONFIG_GPIO_ARIZONA=y
CONFIG_GPIO_DA9052=y
CONFIG_GPIO_DA9055=y
# CONFIG_GPIO_LP3943 is not set
# CONFIG_GPIO_PALMAS is not set
CONFIG_GPIO_RC5T583=y
# CONFIG_GPIO_SL28CPLD is not set
# CONFIG_GPIO_TPS65912 is not set
CONFIG_GPIO_TQMX86=y
CONFIG_GPIO_TWL4030=y
CONFIG_GPIO_WM831X=y
CONFIG_GPIO_WM8350=y
CONFIG_GPIO_WM8994=y
# end of MFD GPIO expanders

#
# SPI GPIO expanders
#
# CONFIG_GPIO_MAX3191X is not set
CONFIG_GPIO_MAX7301=y
CONFIG_GPIO_MC33880=y
# CONFIG_GPIO_PISOSR is not set
CONFIG_GPIO_XRA1403=y
# end of SPI GPIO expanders

#
# USB GPIO expanders
#
CONFIG_GPIO_VIPERBOARD=y
# end of USB GPIO expanders

#
# Virtual GPIO drivers
#
CONFIG_GPIO_AGGREGATOR=y
CONFIG_GPIO_MOCKUP=y
# CONFIG_GPIO_VIRTIO is not set
# CONFIG_GPIO_SIM is not set
# end of Virtual GPIO drivers

CONFIG_W1=y

#
# 1-wire Bus Masters
#
CONFIG_W1_MASTER_DS2490=y
CONFIG_W1_MASTER_DS2482=y
# CONFIG_W1_MASTER_MXC is not set
CONFIG_W1_MASTER_DS1WM=y
# CONFIG_W1_MASTER_GPIO is not set
# CONFIG_W1_MASTER_SGI is not set
# end of 1-wire Bus Masters

#
# 1-wire Slaves
#
CONFIG_W1_SLAVE_THERM=y
CONFIG_W1_SLAVE_SMEM=y
# CONFIG_W1_SLAVE_DS2405 is not set
CONFIG_W1_SLAVE_DS2408=y
# CONFIG_W1_SLAVE_DS2408_READBACK is not set
# CONFIG_W1_SLAVE_DS2413 is not set
CONFIG_W1_SLAVE_DS2406=y
# CONFIG_W1_SLAVE_DS2423 is not set
CONFIG_W1_SLAVE_DS2805=y
CONFIG_W1_SLAVE_DS2430=y
CONFIG_W1_SLAVE_DS2431=y
CONFIG_W1_SLAVE_DS2433=y
CONFIG_W1_SLAVE_DS2433_CRC=y
CONFIG_W1_SLAVE_DS2438=y
# CONFIG_W1_SLAVE_DS250X is not set
CONFIG_W1_SLAVE_DS2780=y
CONFIG_W1_SLAVE_DS2781=y
# CONFIG_W1_SLAVE_DS28E04 is not set
CONFIG_W1_SLAVE_DS28E17=y
# end of 1-wire Slaves

# CONFIG_POWER_RESET is not set
CONFIG_POWER_SUPPLY=y
CONFIG_POWER_SUPPLY_DEBUG=y
# CONFIG_PDA_POWER is not set
CONFIG_GENERIC_ADC_BATTERY=y
# CONFIG_IP5XXX_POWER is not set
# CONFIG_MAX8925_POWER is not set
CONFIG_WM831X_BACKUP=y
# CONFIG_WM831X_POWER is not set
CONFIG_WM8350_POWER=y
# CONFIG_TEST_POWER is not set
CONFIG_BATTERY_88PM860X=y
CONFIG_CHARGER_ADP5061=y
# CONFIG_BATTERY_ACT8945A is not set
CONFIG_BATTERY_CW2015=y
CONFIG_BATTERY_DS2760=y
CONFIG_BATTERY_DS2780=y
CONFIG_BATTERY_DS2781=y
CONFIG_BATTERY_DS2782=y
# CONFIG_BATTERY_SAMSUNG_SDI is not set
# CONFIG_BATTERY_SBS is not set
# CONFIG_CHARGER_SBS is not set
# CONFIG_MANAGER_SBS is not set
CONFIG_BATTERY_BQ27XXX=y
CONFIG_BATTERY_BQ27XXX_I2C=y
CONFIG_BATTERY_BQ27XXX_HDQ=y
# CONFIG_BATTERY_BQ27XXX_DT_UPDATES_NVM is not set
CONFIG_BATTERY_DA9052=y
CONFIG_CHARGER_DA9150=y
# CONFIG_BATTERY_DA9150 is not set
# CONFIG_AXP20X_POWER is not set
# CONFIG_BATTERY_MAX17040 is not set
# CONFIG_BATTERY_MAX17042 is not set
# CONFIG_BATTERY_MAX1721X is not set
CONFIG_BATTERY_TWL4030_MADC=y
CONFIG_CHARGER_88PM860X=y
# CONFIG_CHARGER_PCF50633 is not set
CONFIG_BATTERY_RX51=y
CONFIG_CHARGER_ISP1704=y
CONFIG_CHARGER_MAX8903=y
# CONFIG_CHARGER_TWL4030 is not set
CONFIG_CHARGER_LP8727=y
CONFIG_CHARGER_LP8788=y
# CONFIG_CHARGER_GPIO is not set
CONFIG_CHARGER_MANAGER=y
# CONFIG_CHARGER_LT3651 is not set
# CONFIG_CHARGER_LTC4162L is not set
CONFIG_CHARGER_MAX77693=y
# CONFIG_CHARGER_MAX77976 is not set
CONFIG_CHARGER_MAX8997=y
# CONFIG_CHARGER_MP2629 is not set
CONFIG_CHARGER_MT6360=y
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_CHARGER_BQ24190 is not set
CONFIG_CHARGER_BQ24257=y
CONFIG_CHARGER_BQ24735=y
CONFIG_CHARGER_BQ2515X=y
CONFIG_CHARGER_BQ25890=y
CONFIG_CHARGER_BQ25980=y
CONFIG_CHARGER_BQ256XX=y
CONFIG_CHARGER_SMB347=y
# CONFIG_CHARGER_TPS65090 is not set
CONFIG_BATTERY_GAUGE_LTC2941=y
# CONFIG_BATTERY_GOLDFISH is not set
# CONFIG_BATTERY_RT5033 is not set
# CONFIG_CHARGER_RT9455 is not set
# CONFIG_CHARGER_SC2731 is not set
# CONFIG_FUEL_GAUGE_SC27XX is not set
CONFIG_CHARGER_BD99954=y
# CONFIG_BATTERY_UG3105 is not set
# CONFIG_HWMON is not set
CONFIG_THERMAL=y
CONFIG_THERMAL_STATISTICS=y
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
# CONFIG_THERMAL_WRITABLE_TRIPS is not set
# CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE is not set
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE=y
CONFIG_THERMAL_GOV_FAIR_SHARE=y
# CONFIG_THERMAL_GOV_STEP_WISE is not set
# CONFIG_THERMAL_GOV_BANG_BANG is not set
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_THERMAL_EMULATION is not set
# CONFIG_K3_THERMAL is not set
# CONFIG_ROCKCHIP_THERMAL is not set
# CONFIG_RCAR_THERMAL is not set
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

# CONFIG_SPRD_THERMAL is not set
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
CONFIG_WATCHDOG_NOWAYOUT=y
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
# CONFIG_SOFT_WATCHDOG is not set
# CONFIG_DA9052_WATCHDOG is not set
# CONFIG_DA9055_WATCHDOG is not set
# CONFIG_DA9063_WATCHDOG is not set
# CONFIG_DA9062_WATCHDOG is not set
# CONFIG_MENF21BMC_WATCHDOG is not set
# CONFIG_WM831X_WATCHDOG is not set
# CONFIG_WM8350_WATCHDOG is not set
CONFIG_XILINX_WATCHDOG=y
# CONFIG_ZIIRAVE_WATCHDOG is not set
# CONFIG_RAVE_SP_WATCHDOG is not set
# CONFIG_SL28CPLD_WATCHDOG is not set
# CONFIG_ARMADA_37XX_WATCHDOG is not set
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
# CONFIG_TWL4030_WATCHDOG is not set
# CONFIG_STMP3XXX_RTC_WATCHDOG is not set
# CONFIG_TS72XX_WATCHDOG is not set
CONFIG_MAX63XX_WATCHDOG=y
# CONFIG_MAX77620_WATCHDOG is not set
# CONFIG_IMX2_WDT is not set
# CONFIG_IMX7ULP_WDT is not set
# CONFIG_RETU_WATCHDOG is not set
# CONFIG_MOXART_WDT is not set
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
# CONFIG_REALTEK_OTTO_WDT is not set
# CONFIG_SPRD_WATCHDOG is not set
# CONFIG_VISCONTI_WATCHDOG is not set
# CONFIG_MSC313E_WATCHDOG is not set
# CONFIG_APPLE_WATCHDOG is not set
# CONFIG_SUNPLUS_WATCHDOG is not set
# CONFIG_SC520_WDT is not set
# CONFIG_BCM47XX_WDT is not set
# CONFIG_BCM_KONA_WDT is not set
# CONFIG_BCM7038_WDT is not set
# CONFIG_IMGPDC_WDT is not set
# CONFIG_MPC5200_WDT is not set
CONFIG_MEN_A21_WDT=y
# CONFIG_UML_WATCHDOG is not set

#
# USB-based Watchdog Cards
#
CONFIG_USBPCWATCHDOG=y
CONFIG_SSB_POSSIBLE=y
# CONFIG_SSB is not set
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=y
# CONFIG_BCMA_HOST_SOC is not set
# CONFIG_BCMA_DRIVER_MIPS is not set
CONFIG_BCMA_DRIVER_GMAC_CMN=y
# CONFIG_BCMA_DRIVER_GPIO is not set
# CONFIG_BCMA_DEBUG is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_SUN4I_GPADC is not set
CONFIG_MFD_AS3711=y
# CONFIG_PMIC_ADP5520 is not set
CONFIG_MFD_AAT2870_CORE=y
# CONFIG_MFD_AT91_USART is not set
CONFIG_MFD_BCM590XX=y
# CONFIG_MFD_BD9571MWV is not set
CONFIG_MFD_AXP20X=y
CONFIG_MFD_AXP20X_I2C=y
# CONFIG_MFD_MADERA is not set
# CONFIG_MFD_ASIC3 is not set
# CONFIG_PMIC_DA903X is not set
CONFIG_PMIC_DA9052=y
# CONFIG_MFD_DA9052_SPI is not set
CONFIG_MFD_DA9052_I2C=y
CONFIG_MFD_DA9055=y
# CONFIG_MFD_DA9062 is not set
CONFIG_MFD_DA9063=y
CONFIG_MFD_DA9150=y
# CONFIG_MFD_DLN2 is not set
# CONFIG_MFD_ENE_KB3930 is not set
# CONFIG_MFD_EXYNOS_LPASS is not set
CONFIG_MFD_MC13XXX=y
CONFIG_MFD_MC13XXX_SPI=y
# CONFIG_MFD_MC13XXX_I2C is not set
CONFIG_MFD_MP2629=y
# CONFIG_MFD_MXS_LRADC is not set
# CONFIG_MFD_MX25_TSADC is not set
CONFIG_HTC_PASIC3=y
CONFIG_HTC_I2CPLD=y
# CONFIG_INTEL_SOC_PMIC is not set
# CONFIG_MFD_IQS62X is not set
# CONFIG_MFD_KEMPLD is not set
CONFIG_MFD_88PM800=y
CONFIG_MFD_88PM805=y
CONFIG_MFD_88PM860X=y
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
CONFIG_MFD_MT6360=y
# CONFIG_MFD_MT6370 is not set
CONFIG_MFD_MT6397=y
CONFIG_MFD_MENF21BMC=y
# CONFIG_MFD_OCELOT is not set
CONFIG_EZX_PCAP=y
# CONFIG_MFD_CPCAP is not set
CONFIG_MFD_VIPERBOARD=y
# CONFIG_MFD_NTXEC is not set
CONFIG_MFD_RETU=y
CONFIG_MFD_PCF50633=y
CONFIG_PCF50633_ADC=y
# CONFIG_PCF50633_GPIO is not set
# CONFIG_MFD_PM8XXX is not set
# CONFIG_MFD_SY7636A is not set
# CONFIG_MFD_RT4831 is not set
CONFIG_MFD_RT5033=y
# CONFIG_MFD_RT5120 is not set
CONFIG_MFD_RC5T583=y
# CONFIG_MFD_SEC_CORE is not set
CONFIG_MFD_SI476X_CORE=y
# CONFIG_MFD_SL28CPLD is not set
CONFIG_MFD_SM501=y
CONFIG_MFD_SM501_GPIO=y
CONFIG_MFD_SKY81452=y
# CONFIG_MFD_SC27XX_PMIC is not set
# CONFIG_ABX500_CORE is not set
# CONFIG_MFD_SUN6I_PRCM is not set
CONFIG_MFD_SYSCON=y
CONFIG_MFD_TI_AM335X_TSCADC=y
CONFIG_MFD_LP3943=y
CONFIG_MFD_LP8788=y
# CONFIG_MFD_TI_LMU is not set
CONFIG_MFD_OMAP_USB_HOST=y
CONFIG_MFD_PALMAS=y
CONFIG_TPS6105X=y
CONFIG_TPS65010=y
# CONFIG_TPS6507X is not set
# CONFIG_MFD_TPS65086 is not set
CONFIG_MFD_TPS65090=y
# CONFIG_MFD_TI_LP873X is not set
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
CONFIG_MFD_TPS65912=y
CONFIG_MFD_TPS65912_I2C=y
CONFIG_MFD_TPS65912_SPI=y
CONFIG_TWL4030_CORE=y
# CONFIG_MFD_TWL4030_AUDIO is not set
# CONFIG_TWL6040_CORE is not set
CONFIG_MFD_WL1273_CORE=y
# CONFIG_MFD_LM3533 is not set
CONFIG_MFD_TQMX86=y
CONFIG_MFD_ARIZONA=y
CONFIG_MFD_ARIZONA_I2C=y
CONFIG_MFD_ARIZONA_SPI=y
CONFIG_MFD_CS47L24=y
# CONFIG_MFD_WM5102 is not set
# CONFIG_MFD_WM5110 is not set
CONFIG_MFD_WM8997=y
# CONFIG_MFD_WM8998 is not set
CONFIG_MFD_WM8400=y
CONFIG_MFD_WM831X=y
CONFIG_MFD_WM831X_I2C=y
CONFIG_MFD_WM831X_SPI=y
CONFIG_MFD_WM8350=y
CONFIG_MFD_WM8350_I2C=y
CONFIG_MFD_WM8994=y
# CONFIG_MFD_STW481X is not set
# CONFIG_MFD_STM32_LPTIMER is not set
# CONFIG_MFD_STM32_TIMERS is not set
# CONFIG_MFD_STMFX is not set
CONFIG_MFD_WCD934X=y
# CONFIG_MFD_ATC260X_I2C is not set
# CONFIG_MFD_KHADAS_MCU is not set
# CONFIG_MFD_ACER_A500_EC is not set
CONFIG_RAVE_SP_CORE=y
# CONFIG_MFD_INTEL_M10_BMC is not set
# end of Multifunction device drivers

CONFIG_REGULATOR=y
# CONFIG_REGULATOR_DEBUG is not set
CONFIG_REGULATOR_FIXED_VOLTAGE=y
CONFIG_REGULATOR_VIRTUAL_CONSUMER=y
CONFIG_REGULATOR_USERSPACE_CONSUMER=y
CONFIG_REGULATOR_88PG86X=y
CONFIG_REGULATOR_88PM800=y
CONFIG_REGULATOR_88PM8607=y
# CONFIG_REGULATOR_ACT8865 is not set
CONFIG_REGULATOR_AD5398=y
# CONFIG_REGULATOR_ANATOP is not set
CONFIG_REGULATOR_AAT2870=y
# CONFIG_REGULATOR_AS3711 is not set
CONFIG_REGULATOR_AXP20X=y
# CONFIG_REGULATOR_BCM590XX is not set
# CONFIG_REGULATOR_DA9052 is not set
CONFIG_REGULATOR_DA9055=y
CONFIG_REGULATOR_DA9210=y
CONFIG_REGULATOR_DA9211=y
CONFIG_REGULATOR_FAN53555=y
# CONFIG_REGULATOR_FAN53880 is not set
# CONFIG_REGULATOR_GPIO is not set
CONFIG_REGULATOR_ISL9305=y
# CONFIG_REGULATOR_ISL6271A is not set
CONFIG_REGULATOR_LP3971=y
# CONFIG_REGULATOR_LP3972 is not set
CONFIG_REGULATOR_LP872X=y
CONFIG_REGULATOR_LP8755=y
CONFIG_REGULATOR_LP8788=y
CONFIG_REGULATOR_LTC3589=y
# CONFIG_REGULATOR_LTC3676 is not set
# CONFIG_REGULATOR_MAX1586 is not set
# CONFIG_REGULATOR_MAX77620 is not set
# CONFIG_REGULATOR_MAX77650 is not set
CONFIG_REGULATOR_MAX8649=y
# CONFIG_REGULATOR_MAX8660 is not set
CONFIG_REGULATOR_MAX8893=y
# CONFIG_REGULATOR_MAX8907 is not set
CONFIG_REGULATOR_MAX8925=y
CONFIG_REGULATOR_MAX8952=y
CONFIG_REGULATOR_MAX8997=y
# CONFIG_REGULATOR_MAX20086 is not set
# CONFIG_REGULATOR_MAX77686 is not set
# CONFIG_REGULATOR_MAX77693 is not set
# CONFIG_REGULATOR_MAX77802 is not set
CONFIG_REGULATOR_MAX77826=y
CONFIG_REGULATOR_MC13XXX_CORE=y
# CONFIG_REGULATOR_MC13783 is not set
CONFIG_REGULATOR_MC13892=y
CONFIG_REGULATOR_MP8859=y
# CONFIG_REGULATOR_MP886X is not set
CONFIG_REGULATOR_MT6311=y
CONFIG_REGULATOR_MT6323=y
# CONFIG_REGULATOR_MT6331 is not set
# CONFIG_REGULATOR_MT6332 is not set
# CONFIG_REGULATOR_MT6358 is not set
CONFIG_REGULATOR_MT6359=y
CONFIG_REGULATOR_MT6360=y
CONFIG_REGULATOR_MT6397=y
CONFIG_REGULATOR_PALMAS=y
# CONFIG_REGULATOR_PBIAS is not set
CONFIG_REGULATOR_PCA9450=y
CONFIG_REGULATOR_PCAP=y
CONFIG_REGULATOR_PCF50633=y
CONFIG_REGULATOR_PV88060=y
CONFIG_REGULATOR_PV88080=y
CONFIG_REGULATOR_PV88090=y
# CONFIG_REGULATOR_PWM is not set
# CONFIG_REGULATOR_QCOM_RPMH is not set
# CONFIG_REGULATOR_QCOM_SPMI is not set
# CONFIG_REGULATOR_QCOM_USB_VBUS is not set
CONFIG_REGULATOR_RC5T583=y
CONFIG_REGULATOR_RT4801=y
CONFIG_REGULATOR_RT5033=y
# CONFIG_REGULATOR_RT5190A is not set
# CONFIG_REGULATOR_RT5759 is not set
# CONFIG_REGULATOR_RT6160 is not set
CONFIG_REGULATOR_RT6245=y
# CONFIG_REGULATOR_RTQ2134 is not set
# CONFIG_REGULATOR_RTMV20 is not set
CONFIG_REGULATOR_RTQ6752=y
# CONFIG_REGULATOR_S2MPA01 is not set
# CONFIG_REGULATOR_S2MPS11 is not set
# CONFIG_REGULATOR_S5M8767 is not set
# CONFIG_REGULATOR_SC2731 is not set
CONFIG_REGULATOR_SKY81452=y
# CONFIG_REGULATOR_SLG51000 is not set
# CONFIG_REGULATOR_STM32_BOOSTER is not set
# CONFIG_REGULATOR_STM32_VREFBUF is not set
# CONFIG_REGULATOR_STM32_PWR is not set
# CONFIG_REGULATOR_TI_ABB is not set
# CONFIG_REGULATOR_STW481X_VMMC is not set
# CONFIG_REGULATOR_SY8106A is not set
# CONFIG_REGULATOR_SY8824X is not set
# CONFIG_REGULATOR_SY8827N is not set
CONFIG_REGULATOR_TPS51632=y
# CONFIG_REGULATOR_TPS6105X is not set
# CONFIG_REGULATOR_TPS62360 is not set
CONFIG_REGULATOR_TPS65023=y
# CONFIG_REGULATOR_TPS6507X is not set
CONFIG_REGULATOR_TPS65090=y
# CONFIG_REGULATOR_TPS65132 is not set
# CONFIG_REGULATOR_TPS6524X is not set
# CONFIG_REGULATOR_TPS65912 is not set
# CONFIG_REGULATOR_TPS68470 is not set
CONFIG_REGULATOR_TWL4030=y
CONFIG_REGULATOR_WM831X=y
# CONFIG_REGULATOR_WM8350 is not set
CONFIG_REGULATOR_WM8400=y
CONFIG_REGULATOR_WM8994=y
# CONFIG_REGULATOR_QCOM_LABIBB is not set
CONFIG_RC_CORE=y
# CONFIG_LIRC is not set
# CONFIG_RC_MAP is not set
CONFIG_RC_DECODERS=y
CONFIG_IR_IMON_DECODER=y
CONFIG_IR_JVC_DECODER=y
CONFIG_IR_MCE_KBD_DECODER=y
CONFIG_IR_NEC_DECODER=y
# CONFIG_IR_RC5_DECODER is not set
CONFIG_IR_RC6_DECODER=y
CONFIG_IR_RCMM_DECODER=y
# CONFIG_IR_SANYO_DECODER is not set
CONFIG_IR_SHARP_DECODER=y
CONFIG_IR_SONY_DECODER=y
CONFIG_IR_XMP_DECODER=y
# CONFIG_RC_DEVICES is not set
CONFIG_CEC_CORE=y
CONFIG_CEC_NOTIFIER=y

#
# CEC support
#
CONFIG_MEDIA_CEC_RC=y
CONFIG_MEDIA_CEC_SUPPORT=y
CONFIG_CEC_CH7322=y
# CONFIG_CEC_MESON_AO is not set
# CONFIG_CEC_GPIO is not set
# CONFIG_CEC_SAMSUNG_S5P is not set
# CONFIG_CEC_STI is not set
# CONFIG_CEC_STM32 is not set
# CONFIG_CEC_TEGRA is not set
# CONFIG_USB_PULSE8_CEC is not set
CONFIG_USB_RAINSHADOW_CEC=y
# end of CEC support

CONFIG_MEDIA_SUPPORT=y
# CONFIG_MEDIA_SUPPORT_FILTER is not set
# CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set

#
# Media device types
#
CONFIG_MEDIA_CAMERA_SUPPORT=y
CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
CONFIG_MEDIA_RADIO_SUPPORT=y
CONFIG_MEDIA_SDR_SUPPORT=y
CONFIG_MEDIA_PLATFORM_SUPPORT=y
CONFIG_MEDIA_TEST_SUPPORT=y
# end of Media device types

#
# Media core support
#
CONFIG_VIDEO_DEV=y
CONFIG_MEDIA_CONTROLLER=y
CONFIG_DVB_CORE=y
# end of Media core support

#
# Video4Linux options
#
CONFIG_VIDEO_V4L2_I2C=y
CONFIG_VIDEO_V4L2_SUBDEV_API=y
# CONFIG_VIDEO_ADV_DEBUG is not set
CONFIG_VIDEO_FIXED_MINOR_RANGES=y
CONFIG_VIDEO_TUNER=y
CONFIG_V4L2_MEM2MEM_DEV=y
CONFIG_V4L2_FLASH_LED_CLASS=y
CONFIG_V4L2_FWNODE=y
CONFIG_V4L2_ASYNC=y
# end of Video4Linux options

#
# Media controller options
#
CONFIG_MEDIA_CONTROLLER_DVB=y
CONFIG_MEDIA_CONTROLLER_REQUEST_API=y
# end of Media controller options

#
# Digital TV options
#
CONFIG_DVB_MMAP=y
CONFIG_DVB_MAX_ADAPTERS=16
# CONFIG_DVB_DYNAMIC_MINORS is not set
# CONFIG_DVB_DEMUX_SECTION_LOSS_LOG is not set
# CONFIG_DVB_ULE_DEBUG is not set
# end of Digital TV options

#
# Media drivers
#

#
# Media drivers
#
CONFIG_MEDIA_USB_SUPPORT=y

#
# Webcam devices
#
CONFIG_USB_GSPCA=y
CONFIG_USB_GSPCA_BENQ=y
# CONFIG_USB_GSPCA_CONEX is not set
CONFIG_USB_GSPCA_CPIA1=y
# CONFIG_USB_GSPCA_DTCS033 is not set
CONFIG_USB_GSPCA_ETOMS=y
# CONFIG_USB_GSPCA_FINEPIX is not set
# CONFIG_USB_GSPCA_JEILINJ is not set
CONFIG_USB_GSPCA_JL2005BCD=y
CONFIG_USB_GSPCA_KINECT=y
CONFIG_USB_GSPCA_KONICA=y
CONFIG_USB_GSPCA_MARS=y
CONFIG_USB_GSPCA_MR97310A=y
CONFIG_USB_GSPCA_NW80X=y
CONFIG_USB_GSPCA_OV519=y
CONFIG_USB_GSPCA_OV534=y
# CONFIG_USB_GSPCA_OV534_9 is not set
CONFIG_USB_GSPCA_PAC207=y
# CONFIG_USB_GSPCA_PAC7302 is not set
# CONFIG_USB_GSPCA_PAC7311 is not set
CONFIG_USB_GSPCA_SE401=y
CONFIG_USB_GSPCA_SN9C2028=y
CONFIG_USB_GSPCA_SN9C20X=y
CONFIG_USB_GSPCA_SONIXB=y
CONFIG_USB_GSPCA_SONIXJ=y
# CONFIG_USB_GSPCA_SPCA1528 is not set
CONFIG_USB_GSPCA_SPCA500=y
# CONFIG_USB_GSPCA_SPCA501 is not set
CONFIG_USB_GSPCA_SPCA505=y
CONFIG_USB_GSPCA_SPCA506=y
# CONFIG_USB_GSPCA_SPCA508 is not set
# CONFIG_USB_GSPCA_SPCA561 is not set
CONFIG_USB_GSPCA_SQ905=y
# CONFIG_USB_GSPCA_SQ905C is not set
CONFIG_USB_GSPCA_SQ930X=y
CONFIG_USB_GSPCA_STK014=y
CONFIG_USB_GSPCA_STK1135=y
# CONFIG_USB_GSPCA_STV0680 is not set
CONFIG_USB_GSPCA_SUNPLUS=y
CONFIG_USB_GSPCA_T613=y
CONFIG_USB_GSPCA_TOPRO=y
CONFIG_USB_GSPCA_TOUPTEK=y
CONFIG_USB_GSPCA_TV8532=y
CONFIG_USB_GSPCA_VC032X=y
CONFIG_USB_GSPCA_VICAM=y
# CONFIG_USB_GSPCA_XIRLINK_CIT is not set
CONFIG_USB_GSPCA_ZC3XX=y
# CONFIG_USB_GL860 is not set
# CONFIG_USB_M5602 is not set
CONFIG_USB_STV06XX=y
CONFIG_USB_PWC=y
CONFIG_USB_PWC_DEBUG=y
CONFIG_USB_PWC_INPUT_EVDEV=y
CONFIG_USB_S2255=y
# CONFIG_USB_VIDEO_CLASS is not set

#
# Analog TV USB devices
#
CONFIG_VIDEO_HDPVR=y
# CONFIG_VIDEO_PVRUSB2 is not set
CONFIG_VIDEO_STK1160_COMMON=y
CONFIG_VIDEO_STK1160=y

#
# Analog/digital TV USB devices
#
# CONFIG_VIDEO_AU0828 is not set
CONFIG_VIDEO_CX231XX=y
CONFIG_VIDEO_CX231XX_RC=y
# CONFIG_VIDEO_CX231XX_DVB is not set

#
# Digital TV USB devices
#
CONFIG_DVB_AS102=y
CONFIG_DVB_B2C2_FLEXCOP_USB=y
# CONFIG_DVB_B2C2_FLEXCOP_USB_DEBUG is not set
CONFIG_DVB_USB_V2=y
CONFIG_DVB_USB_AF9015=y
CONFIG_DVB_USB_AF9035=y
CONFIG_DVB_USB_ANYSEE=y
# CONFIG_DVB_USB_AU6610 is not set
CONFIG_DVB_USB_AZ6007=y
CONFIG_DVB_USB_CE6230=y
CONFIG_DVB_USB_DVBSKY=y
CONFIG_DVB_USB_EC168=y
CONFIG_DVB_USB_GL861=y
CONFIG_DVB_USB_LME2510=y
# CONFIG_DVB_USB_MXL111SF is not set
CONFIG_DVB_USB_RTL28XXU=y
CONFIG_DVB_USB_ZD1301=y
# CONFIG_DVB_USB is not set
# CONFIG_SMS_USB_DRV is not set

#
# Webcam, TV (analog/digital) USB devices
#
CONFIG_VIDEO_EM28XX=y
CONFIG_VIDEO_EM28XX_V4L2=y
CONFIG_VIDEO_EM28XX_DVB=y
# CONFIG_VIDEO_EM28XX_RC is not set

#
# Software defined radio USB devices
#
CONFIG_USB_AIRSPY=y
CONFIG_USB_HACKRF=y
CONFIG_USB_MSI2500=y
CONFIG_RADIO_ADAPTERS=y
CONFIG_RADIO_SAA7706H=y
CONFIG_RADIO_SHARK=y
CONFIG_RADIO_SHARK2=y
CONFIG_RADIO_SI4713=y
CONFIG_RADIO_TEA575X=y
CONFIG_RADIO_TEA5764=y
# CONFIG_RADIO_TEA5764_XTAL is not set
# CONFIG_RADIO_TEF6862 is not set
CONFIG_RADIO_WL1273=y
# CONFIG_USB_DSBR is not set
CONFIG_USB_KEENE=y
# CONFIG_USB_MA901 is not set
# CONFIG_USB_MR800 is not set
# CONFIG_USB_RAREMONO is not set
CONFIG_RADIO_SI470X=y
# CONFIG_USB_SI470X is not set
CONFIG_I2C_SI470X=y
CONFIG_USB_SI4713=y
CONFIG_PLATFORM_SI4713=y
CONFIG_I2C_SI4713=y
# CONFIG_V4L_RADIO_ISA_DRIVERS is not set
CONFIG_MEDIA_PLATFORM_DRIVERS=y
# CONFIG_V4L_PLATFORM_DRIVERS is not set
# CONFIG_SDR_PLATFORM_DRIVERS is not set
# CONFIG_DVB_PLATFORM_DRIVERS is not set
CONFIG_V4L_MEM2MEM_DRIVERS=y
# CONFIG_VIDEO_MEM2MEM_DEINTERLACE is not set

#
# Allegro DVT media platform drivers
#
# CONFIG_VIDEO_ALLEGRO_DVT is not set

#
# Amlogic media platform drivers
#
# CONFIG_VIDEO_MESON_GE2D is not set

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
# CONFIG_VIDEO_CADENCE_CSI2RX is not set
# CONFIG_VIDEO_CADENCE_CSI2TX is not set

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
# CONFIG_VIDEO_MEDIATEK_JPEG is not set
# CONFIG_VIDEO_MEDIATEK_MDP is not set
# CONFIG_VIDEO_MEDIATEK_VPU is not set
# CONFIG_VIDEO_MEDIATEK_MDP3 is not set

#
# NVidia media platform drivers
#
# CONFIG_VIDEO_TEGRA_VDE is not set

#
# NXP media platform drivers
#
# CONFIG_VIDEO_IMX_MIPI_CSIS is not set
# CONFIG_VIDEO_IMX_PXP is not set
# CONFIG_VIDEO_MX2_EMMAPRP is not set
# CONFIG_VIDEO_DW100 is not set
# CONFIG_VIDEO_IMX8_JPEG is not set

#
# Qualcomm media platform drivers
#

#
# Renesas media platform drivers
#
# CONFIG_VIDEO_RENESAS_FDP1 is not set
# CONFIG_VIDEO_RENESAS_JPU is not set
# CONFIG_VIDEO_RENESAS_VSP1 is not set

#
# Rockchip media platform drivers
#
# CONFIG_VIDEO_ROCKCHIP_RGA is not set

#
# Samsung media platform drivers
#
# CONFIG_VIDEO_SAMSUNG_EXYNOS_GSC is not set
# CONFIG_VIDEO_SAMSUNG_S5P_G2D is not set
# CONFIG_VIDEO_SAMSUNG_S5P_JPEG is not set
# CONFIG_VIDEO_SAMSUNG_S5P_MFC is not set

#
# STMicroelectronics media platform drivers
#
# CONFIG_VIDEO_STI_BDISP is not set
# CONFIG_VIDEO_STI_DELTA is not set
# CONFIG_VIDEO_STI_HVA is not set
# CONFIG_VIDEO_STM32_DMA2D is not set

#
# Sunxi media platform drivers
#

#
# Texas Instruments drivers
#
# CONFIG_VIDEO_TI_VPE is not set

#
# Verisilicon media platform drivers
#
# CONFIG_VIDEO_HANTRO is not set

#
# VIA media platform drivers
#

#
# Xilinx media platform drivers
#

#
# MMC/SDIO DVB adapters
#
# CONFIG_SMS_SDIO_DRV is not set
CONFIG_V4L_TEST_DRIVERS=y
CONFIG_VIDEO_VIM2M=y
CONFIG_VIDEO_VICODEC=y
CONFIG_VIDEO_VIMC=y
# CONFIG_DVB_TEST_DRIVERS is not set
CONFIG_CYPRESS_FIRMWARE=y
CONFIG_VIDEO_CX2341X=y
CONFIG_VIDEO_TVEEPROM=y
CONFIG_DVB_B2C2_FLEXCOP=y
CONFIG_VIDEO_V4L2_TPG=y
CONFIG_VIDEOBUF2_CORE=y
CONFIG_VIDEOBUF2_V4L2=y
CONFIG_VIDEOBUF2_MEMOPS=y
CONFIG_VIDEOBUF2_DMA_CONTIG=y
CONFIG_VIDEOBUF2_VMALLOC=y
# end of Media drivers

#
# Media ancillary drivers
#
# CONFIG_VIDEO_IR_I2C is not set

#
# Camera sensor devices
#
CONFIG_VIDEO_APTINA_PLL=y
CONFIG_VIDEO_CCS_PLL=y
# CONFIG_VIDEO_AR0521 is not set
# CONFIG_VIDEO_HI556 is not set
# CONFIG_VIDEO_HI846 is not set
# CONFIG_VIDEO_HI847 is not set
CONFIG_VIDEO_IMX208=y
# CONFIG_VIDEO_IMX214 is not set
# CONFIG_VIDEO_IMX219 is not set
CONFIG_VIDEO_IMX258=y
CONFIG_VIDEO_IMX274=y
CONFIG_VIDEO_IMX290=y
CONFIG_VIDEO_IMX319=y
# CONFIG_VIDEO_IMX355 is not set
CONFIG_VIDEO_MAX9271_LIB=y
# CONFIG_VIDEO_MT9M001 is not set
CONFIG_VIDEO_MT9M032=y
CONFIG_VIDEO_MT9M111=y
# CONFIG_VIDEO_MT9P031 is not set
# CONFIG_VIDEO_MT9T001 is not set
CONFIG_VIDEO_MT9T112=y
CONFIG_VIDEO_MT9V011=y
CONFIG_VIDEO_MT9V032=y
# CONFIG_VIDEO_MT9V111 is not set
CONFIG_VIDEO_NOON010PC30=y
# CONFIG_VIDEO_OG01A1B is not set
CONFIG_VIDEO_OV02A10=y
# CONFIG_VIDEO_OV08D10 is not set
CONFIG_VIDEO_OV13858=y
# CONFIG_VIDEO_OV13B10 is not set
# CONFIG_VIDEO_OV2640 is not set
CONFIG_VIDEO_OV2659=y
CONFIG_VIDEO_OV2680=y
# CONFIG_VIDEO_OV2685 is not set
# CONFIG_VIDEO_OV2740 is not set
# CONFIG_VIDEO_OV5647 is not set
CONFIG_VIDEO_OV5670=y
CONFIG_VIDEO_OV5675=y
# CONFIG_VIDEO_OV5693 is not set
CONFIG_VIDEO_OV5695=y
CONFIG_VIDEO_OV6650=y
# CONFIG_VIDEO_OV7251 is not set
CONFIG_VIDEO_OV7640=y
# CONFIG_VIDEO_OV7670 is not set
# CONFIG_VIDEO_OV772X is not set
CONFIG_VIDEO_OV7740=y
# CONFIG_VIDEO_OV8856 is not set
# CONFIG_VIDEO_OV9640 is not set
CONFIG_VIDEO_OV9650=y
# CONFIG_VIDEO_OV9734 is not set
# CONFIG_VIDEO_RDACM20 is not set
CONFIG_VIDEO_RDACM21=y
CONFIG_VIDEO_RJ54N1=y
CONFIG_VIDEO_S5C73M3=y
CONFIG_VIDEO_S5K4ECGX=y
# CONFIG_VIDEO_S5K5BAF is not set
# CONFIG_VIDEO_S5K6A3 is not set
CONFIG_VIDEO_S5K6AA=y
CONFIG_VIDEO_SR030PC30=y
CONFIG_VIDEO_VS6624=y
CONFIG_VIDEO_CCS=y
# CONFIG_VIDEO_ET8EK8 is not set
CONFIG_VIDEO_M5MOLS=y
# end of Camera sensor devices

#
# Lens drivers
#
CONFIG_VIDEO_AD5820=y
# CONFIG_VIDEO_AK7375 is not set
# CONFIG_VIDEO_DW9714 is not set
# CONFIG_VIDEO_DW9768 is not set
CONFIG_VIDEO_DW9807_VCM=y
# end of Lens drivers

#
# Flash devices
#
CONFIG_VIDEO_ADP1653=y
CONFIG_VIDEO_LM3560=y
# CONFIG_VIDEO_LM3646 is not set
# end of Flash devices

#
# Audio decoders, processors and mixers
#
CONFIG_VIDEO_CS3308=y
CONFIG_VIDEO_CS5345=y
# CONFIG_VIDEO_CS53L32A is not set
CONFIG_VIDEO_MSP3400=y
CONFIG_VIDEO_SONY_BTF_MPX=y
CONFIG_VIDEO_TDA7432=y
# CONFIG_VIDEO_TDA9840 is not set
CONFIG_VIDEO_TEA6415C=y
CONFIG_VIDEO_TEA6420=y
CONFIG_VIDEO_TLV320AIC23B=y
# CONFIG_VIDEO_TVAUDIO is not set
CONFIG_VIDEO_UDA1342=y
CONFIG_VIDEO_VP27SMPX=y
# CONFIG_VIDEO_WM8739 is not set
CONFIG_VIDEO_WM8775=y
# end of Audio decoders, processors and mixers

#
# RDS decoders
#
CONFIG_VIDEO_SAA6588=y
# end of RDS decoders

#
# Video decoders
#
# CONFIG_VIDEO_ADV7180 is not set
CONFIG_VIDEO_ADV7183=y
CONFIG_VIDEO_ADV7604=y
# CONFIG_VIDEO_ADV7604_CEC is not set
CONFIG_VIDEO_ADV7842=y
# CONFIG_VIDEO_ADV7842_CEC is not set
CONFIG_VIDEO_BT819=y
CONFIG_VIDEO_BT856=y
CONFIG_VIDEO_BT866=y
# CONFIG_VIDEO_KS0127 is not set
# CONFIG_VIDEO_ML86V7667 is not set
# CONFIG_VIDEO_SAA7110 is not set
CONFIG_VIDEO_SAA711X=y
CONFIG_VIDEO_TC358743=y
CONFIG_VIDEO_TC358743_CEC=y
CONFIG_VIDEO_TVP514X=y
# CONFIG_VIDEO_TVP5150 is not set
CONFIG_VIDEO_TVP7002=y
# CONFIG_VIDEO_TW2804 is not set
CONFIG_VIDEO_TW9903=y
CONFIG_VIDEO_TW9906=y
CONFIG_VIDEO_TW9910=y
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
# CONFIG_VIDEO_ADV7170 is not set
CONFIG_VIDEO_ADV7175=y
CONFIG_VIDEO_ADV7343=y
# CONFIG_VIDEO_ADV7393 is not set
CONFIG_VIDEO_ADV7511=y
# CONFIG_VIDEO_ADV7511_CEC is not set
CONFIG_VIDEO_AK881X=y
# CONFIG_VIDEO_SAA7127 is not set
# CONFIG_VIDEO_SAA7185 is not set
# CONFIG_VIDEO_THS8200 is not set
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
CONFIG_VIDEO_SAA6752HS=y
# end of Audio/Video compression chips

#
# SDR tuner chips
#
CONFIG_SDR_MAX2175=y
# end of SDR tuner chips

#
# Miscellaneous helper chips
#
CONFIG_VIDEO_I2C=y
CONFIG_VIDEO_M52790=y
# CONFIG_VIDEO_ST_MIPID02 is not set
CONFIG_VIDEO_THS7303=y
# end of Miscellaneous helper chips

#
# Media SPI Adapters
#
CONFIG_CXD2880_SPI_DRV=y
# CONFIG_VIDEO_GS1662 is not set
# end of Media SPI Adapters

CONFIG_MEDIA_TUNER=y

#
# Customize TV tuners
#
CONFIG_MEDIA_TUNER_E4000=y
CONFIG_MEDIA_TUNER_FC0011=y
CONFIG_MEDIA_TUNER_FC0012=y
CONFIG_MEDIA_TUNER_FC0013=y
CONFIG_MEDIA_TUNER_FC2580=y
CONFIG_MEDIA_TUNER_IT913X=y
CONFIG_MEDIA_TUNER_M88RS6000T=y
# CONFIG_MEDIA_TUNER_MAX2165 is not set
# CONFIG_MEDIA_TUNER_MC44S803 is not set
CONFIG_MEDIA_TUNER_MSI001=y
CONFIG_MEDIA_TUNER_MT2060=y
# CONFIG_MEDIA_TUNER_MT2063 is not set
CONFIG_MEDIA_TUNER_MT20XX=y
# CONFIG_MEDIA_TUNER_MT2131 is not set
CONFIG_MEDIA_TUNER_MT2266=y
CONFIG_MEDIA_TUNER_MXL301RF=y
CONFIG_MEDIA_TUNER_MXL5005S=y
# CONFIG_MEDIA_TUNER_MXL5007T is not set
CONFIG_MEDIA_TUNER_QM1D1B0004=y
CONFIG_MEDIA_TUNER_QM1D1C0042=y
# CONFIG_MEDIA_TUNER_QT1010 is not set
CONFIG_MEDIA_TUNER_R820T=y
CONFIG_MEDIA_TUNER_SI2157=y
CONFIG_MEDIA_TUNER_SIMPLE=y
# CONFIG_MEDIA_TUNER_TDA18212 is not set
CONFIG_MEDIA_TUNER_TDA18218=y
CONFIG_MEDIA_TUNER_TDA18250=y
CONFIG_MEDIA_TUNER_TDA18271=y
CONFIG_MEDIA_TUNER_TDA827X=y
# CONFIG_MEDIA_TUNER_TDA8290 is not set
CONFIG_MEDIA_TUNER_TDA9887=y
# CONFIG_MEDIA_TUNER_TEA5761 is not set
# CONFIG_MEDIA_TUNER_TEA5767 is not set
CONFIG_MEDIA_TUNER_TUA9001=y
# CONFIG_MEDIA_TUNER_XC2028 is not set
# CONFIG_MEDIA_TUNER_XC4000 is not set
CONFIG_MEDIA_TUNER_XC5000=y
# end of Customize TV tuners

#
# Customise DVB Frontends
#

#
# Multistandard (satellite) frontends
#
# CONFIG_DVB_M88DS3103 is not set
CONFIG_DVB_MXL5XX=y
CONFIG_DVB_STB0899=y
CONFIG_DVB_STB6100=y
CONFIG_DVB_STV090x=y
CONFIG_DVB_STV0910=y
# CONFIG_DVB_STV6110x is not set
# CONFIG_DVB_STV6111 is not set

#
# Multistandard (cable + terrestrial) frontends
#
# CONFIG_DVB_DRXK is not set
CONFIG_DVB_MN88472=y
# CONFIG_DVB_MN88473 is not set
CONFIG_DVB_SI2165=y
# CONFIG_DVB_TDA18271C2DD is not set

#
# DVB-S (satellite) frontends
#
CONFIG_DVB_CX24110=y
CONFIG_DVB_CX24116=y
CONFIG_DVB_CX24117=y
CONFIG_DVB_CX24120=y
# CONFIG_DVB_CX24123 is not set
# CONFIG_DVB_DS3000 is not set
# CONFIG_DVB_MB86A16 is not set
CONFIG_DVB_MT312=y
CONFIG_DVB_S5H1420=y
CONFIG_DVB_SI21XX=y
CONFIG_DVB_STB6000=y
CONFIG_DVB_STV0288=y
# CONFIG_DVB_STV0299 is not set
CONFIG_DVB_STV0900=y
CONFIG_DVB_STV6110=y
CONFIG_DVB_TDA10071=y
CONFIG_DVB_TDA10086=y
CONFIG_DVB_TDA8083=y
CONFIG_DVB_TDA8261=y
# CONFIG_DVB_TDA826X is not set
CONFIG_DVB_TS2020=y
CONFIG_DVB_TUA6100=y
CONFIG_DVB_TUNER_CX24113=y
CONFIG_DVB_TUNER_ITD1000=y
# CONFIG_DVB_VES1X93 is not set
CONFIG_DVB_ZL10036=y
# CONFIG_DVB_ZL10039 is not set

#
# DVB-T (terrestrial) frontends
#
CONFIG_DVB_AF9013=y
CONFIG_DVB_AS102_FE=y
# CONFIG_DVB_CX22700 is not set
CONFIG_DVB_CX22702=y
# CONFIG_DVB_CXD2820R is not set
CONFIG_DVB_CXD2841ER=y
CONFIG_DVB_DIB3000MB=y
# CONFIG_DVB_DIB3000MC is not set
# CONFIG_DVB_DIB7000M is not set
CONFIG_DVB_DIB7000P=y
CONFIG_DVB_DIB9000=y
# CONFIG_DVB_DRXD is not set
CONFIG_DVB_EC100=y
CONFIG_DVB_L64781=y
# CONFIG_DVB_MT352 is not set
CONFIG_DVB_NXT6000=y
CONFIG_DVB_RTL2830=y
CONFIG_DVB_RTL2832=y
CONFIG_DVB_RTL2832_SDR=y
# CONFIG_DVB_S5H1432 is not set
CONFIG_DVB_SI2168=y
CONFIG_DVB_SP887X=y
CONFIG_DVB_STV0367=y
CONFIG_DVB_TDA10048=y
# CONFIG_DVB_TDA1004X is not set
# CONFIG_DVB_ZD1301_DEMOD is not set
CONFIG_DVB_ZL10353=y
CONFIG_DVB_CXD2880=y

#
# DVB-C (cable) frontends
#
CONFIG_DVB_STV0297=y
CONFIG_DVB_TDA10021=y
CONFIG_DVB_TDA10023=y
CONFIG_DVB_VES1820=y

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#
CONFIG_DVB_AU8522=y
CONFIG_DVB_AU8522_DTV=y
CONFIG_DVB_AU8522_V4L=y
# CONFIG_DVB_BCM3510 is not set
# CONFIG_DVB_LG2160 is not set
# CONFIG_DVB_LGDT3305 is not set
CONFIG_DVB_LGDT3306A=y
CONFIG_DVB_LGDT330X=y
# CONFIG_DVB_MXL692 is not set
# CONFIG_DVB_NXT200X is not set
CONFIG_DVB_OR51132=y
CONFIG_DVB_OR51211=y
CONFIG_DVB_S5H1409=y
# CONFIG_DVB_S5H1411 is not set

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
CONFIG_DVB_TUNER_DIB0090=y

#
# SEC control devices for DVB-S
#
# CONFIG_DVB_A8293 is not set
CONFIG_DVB_AF9033=y
CONFIG_DVB_ASCOT2E=y
# CONFIG_DVB_ATBM8830 is not set
CONFIG_DVB_HELENE=y
# CONFIG_DVB_HORUS3A is not set
CONFIG_DVB_ISL6405=y
# CONFIG_DVB_ISL6421 is not set
CONFIG_DVB_ISL6423=y
CONFIG_DVB_IX2505V=y
CONFIG_DVB_LGS8GL5=y
CONFIG_DVB_LGS8GXX=y
# CONFIG_DVB_LNBH25 is not set
CONFIG_DVB_LNBH29=y
# CONFIG_DVB_LNBP21 is not set
CONFIG_DVB_LNBP22=y
CONFIG_DVB_M88RS2000=y
# CONFIG_DVB_TDA665x is not set
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
CONFIG_DRM=y
CONFIG_DRM_MIPI_DBI=y
CONFIG_DRM_DEBUG_MM=y
# CONFIG_DRM_KUNIT_TEST is not set
CONFIG_DRM_KMS_HELPER=y
# CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS is not set
CONFIG_DRM_DEBUG_MODESET_LOCK=y
# CONFIG_DRM_LOAD_EDID_FIRMWARE is not set
CONFIG_DRM_GEM_DMA_HELPER=y
CONFIG_DRM_GEM_SHMEM_HELPER=y
CONFIG_DRM_SCHED=y

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=y
# CONFIG_DRM_I2C_SIL164 is not set
CONFIG_DRM_I2C_NXP_TDA998X=y
CONFIG_DRM_I2C_NXP_TDA9950=y
# end of I2C encoder or helper chips

#
# ARM devices
#
# end of ARM devices

# CONFIG_DRM_KMB_DISPLAY is not set
CONFIG_DRM_VGEM=y
CONFIG_DRM_VKMS=y
# CONFIG_DRM_UDL is not set
# CONFIG_DRM_SUN4I is not set
CONFIG_DRM_VIRTIO_GPU=y
# CONFIG_DRM_MSM is not set
CONFIG_DRM_PANEL=y

#
# Display Panels
#
CONFIG_DRM_PANEL_WIDECHIPS_WS2401=y
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
# end of Display Interface Bridges

# CONFIG_DRM_V3D is not set
CONFIG_DRM_ETNAVIV=y
CONFIG_DRM_ETNAVIV_THERMAL=y
# CONFIG_DRM_LOGICVC is not set
CONFIG_DRM_GM12U320=y
CONFIG_DRM_PANEL_MIPI_DBI=y
CONFIG_DRM_SIMPLEDRM=y
# CONFIG_TINYDRM_HX8357D is not set
CONFIG_TINYDRM_ILI9163=y
CONFIG_TINYDRM_ILI9225=y
CONFIG_TINYDRM_ILI9341=y
# CONFIG_TINYDRM_ILI9486 is not set
CONFIG_TINYDRM_MI0283QT=y
# CONFIG_TINYDRM_REPAPER is not set
# CONFIG_TINYDRM_ST7586 is not set
CONFIG_TINYDRM_ST7735R=y
# CONFIG_DRM_PL111 is not set
# CONFIG_DRM_GUD is not set
CONFIG_DRM_SSD130X=y
CONFIG_DRM_SSD130X_I2C=y
# CONFIG_DRM_SSD130X_SPI is not set
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
CONFIG_DRM_NOMODESET=y

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
# CONFIG_FB is not set
CONFIG_FB_OMAP_LCD_H3=y
# CONFIG_MMP_DISP is not set
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
# CONFIG_LCD_PLATFORM is not set
CONFIG_LCD_AMS369FG06=y
CONFIG_LCD_LMS501KF03=y
CONFIG_LCD_HX8357=y
CONFIG_LCD_OTM3225A=y
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_KTD253 is not set
# CONFIG_BACKLIGHT_OMAP1 is not set
# CONFIG_BACKLIGHT_PWM is not set
CONFIG_BACKLIGHT_DA9052=y
CONFIG_BACKLIGHT_MAX8925=y
CONFIG_BACKLIGHT_QCOM_WLED=y
# CONFIG_BACKLIGHT_WM831X is not set
# CONFIG_BACKLIGHT_ADP8860 is not set
# CONFIG_BACKLIGHT_ADP8870 is not set
CONFIG_BACKLIGHT_88PM860X=y
CONFIG_BACKLIGHT_PCF50633=y
# CONFIG_BACKLIGHT_AAT2870 is not set
# CONFIG_BACKLIGHT_LM3630A is not set
# CONFIG_BACKLIGHT_LM3639 is not set
CONFIG_BACKLIGHT_LP855X=y
CONFIG_BACKLIGHT_LP8788=y
# CONFIG_BACKLIGHT_PANDORA is not set
CONFIG_BACKLIGHT_SKY81452=y
# CONFIG_BACKLIGHT_AS3711 is not set
CONFIG_BACKLIGHT_GPIO=y
CONFIG_BACKLIGHT_LV5207LP=y
CONFIG_BACKLIGHT_BD6107=y
CONFIG_BACKLIGHT_ARCXCNN=y
CONFIG_BACKLIGHT_RAVE_SP=y
# end of Backlight & LCD device support

CONFIG_VIDEOMODE_HELPERS=y
CONFIG_HDMI=y
# end of Graphics support

# CONFIG_SOUND is not set

#
# HID support
#
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
CONFIG_HIDRAW=y
# CONFIG_UHID is not set
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
# CONFIG_HID_A4TECH is not set
CONFIG_HID_ACRUX=y
CONFIG_HID_ACRUX_FF=y
# CONFIG_HID_APPLE is not set
# CONFIG_HID_AUREAL is not set
CONFIG_HID_BELKIN=y
CONFIG_HID_CHERRY=y
CONFIG_HID_COUGAR=y
CONFIG_HID_MACALLY=y
CONFIG_HID_CMEDIA=y
CONFIG_HID_CYPRESS=y
# CONFIG_HID_DRAGONRISE is not set
CONFIG_HID_EMS_FF=y
CONFIG_HID_ELECOM=y
CONFIG_HID_EZKEY=y
# CONFIG_HID_GEMBIRD is not set
CONFIG_HID_GFRM=y
CONFIG_HID_GLORIOUS=y
CONFIG_HID_VIVALDI_COMMON=y
CONFIG_HID_VIVALDI=y
# CONFIG_HID_KEYTOUCH is not set
CONFIG_HID_KYE=y
CONFIG_HID_WALTOP=y
# CONFIG_HID_VIEWSONIC is not set
# CONFIG_HID_VRC2 is not set
# CONFIG_HID_XIAOMI is not set
CONFIG_HID_GYRATION=y
CONFIG_HID_ICADE=y
CONFIG_HID_ITE=y
CONFIG_HID_JABRA=y
CONFIG_HID_TWINHAN=y
CONFIG_HID_KENSINGTON=y
CONFIG_HID_LCPOWER=y
CONFIG_HID_LED=y
CONFIG_HID_LENOVO=y
CONFIG_HID_MAGICMOUSE=y
# CONFIG_HID_MALTRON is not set
CONFIG_HID_MAYFLASH=y
CONFIG_HID_REDRAGON=y
CONFIG_HID_MICROSOFT=y
CONFIG_HID_MONTEREY=y
# CONFIG_HID_MULTITOUCH is not set
# CONFIG_HID_NINTENDO is not set
CONFIG_HID_NTI=y
# CONFIG_HID_ORTEK is not set
# CONFIG_HID_PANTHERLORD is not set
CONFIG_HID_PETALYNX=y
# CONFIG_HID_PICOLCD is not set
CONFIG_HID_PLANTRONICS=y
CONFIG_HID_PLAYSTATION=y
# CONFIG_PLAYSTATION_FF is not set
# CONFIG_HID_PXRC is not set
# CONFIG_HID_RAZER is not set
CONFIG_HID_PRIMAX=y
# CONFIG_HID_SAITEK is not set
CONFIG_HID_SEMITEK=y
CONFIG_HID_SPEEDLINK=y
# CONFIG_HID_STEAM is not set
CONFIG_HID_STEELSERIES=y
CONFIG_HID_SUNPLUS=y
# CONFIG_HID_RMI is not set
CONFIG_HID_GREENASIA=y
CONFIG_GREENASIA_FF=y
# CONFIG_HID_SMARTJOYPLUS is not set
CONFIG_HID_TIVO=y
CONFIG_HID_TOPSEED=y
# CONFIG_HID_TOPRE is not set
# CONFIG_HID_THINGM is not set
CONFIG_HID_UDRAW_PS3=y
CONFIG_HID_WIIMOTE=y
CONFIG_HID_XINMO=y
CONFIG_HID_ZEROPLUS=y
# CONFIG_ZEROPLUS_FF is not set
CONFIG_HID_ZYDACRON=y
# CONFIG_HID_SENSOR_HUB is not set
CONFIG_HID_ALPS=y
# end of Special HID drivers

#
# USB HID support
#
# CONFIG_USB_HID is not set
# CONFIG_HID_PID is not set

#
# USB HID Boot Protocol drivers
#
CONFIG_USB_KBD=y
# CONFIG_USB_MOUSE is not set
# end of USB HID Boot Protocol drivers
# end of USB HID support

#
# I2C HID support
#
# end of I2C HID support
# end of HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
CONFIG_USB_ULPI_BUS=y
CONFIG_USB_CONN_GPIO=y
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
# CONFIG_USB_ANNOUNCE_NEW_DEVICES is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=y
# CONFIG_USB_FEW_INIT_RETRIES is not set
CONFIG_USB_DYNAMIC_MINORS=y
# CONFIG_USB_OTG_PRODUCTLIST is not set
# CONFIG_USB_OTG_DISABLE_EXTERNAL_HUB is not set
CONFIG_USB_AUTOSUSPEND_DELAY=2
# CONFIG_USB_MON is not set

#
# USB Host Controller Drivers
#
CONFIG_USB_C67X00_HCD=y
# CONFIG_USB_XHCI_HCD is not set
# CONFIG_USB_BRCMSTB is not set
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_EHCI_FSL=y
# CONFIG_USB_EHCI_HCD_NPCM7XX is not set
CONFIG_USB_EHCI_HCD_OMAP=y
# CONFIG_USB_EHCI_HCD_ORION is not set
# CONFIG_USB_EHCI_HCD_SPEAR is not set
# CONFIG_USB_EHCI_HCD_AT91 is not set
# CONFIG_USB_EHCI_SH is not set
# CONFIG_USB_EHCI_EXYNOS is not set
# CONFIG_USB_EHCI_MV is not set
# CONFIG_USB_CNS3XXX_EHCI is not set
CONFIG_USB_EHCI_HCD_PLATFORM=y
# CONFIG_USB_OXU210HP_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_ISP1362_HCD is not set
CONFIG_USB_FOTG210_HCD=y
CONFIG_USB_MAX3421_HCD=y
CONFIG_USB_OHCI_HCD=y
# CONFIG_USB_OHCI_HCD_SPEAR is not set
# CONFIG_USB_OHCI_HCD_S3C2410 is not set
# CONFIG_USB_OHCI_HCD_OMAP3 is not set
# CONFIG_USB_OHCI_HCD_DAVINCI is not set
# CONFIG_USB_OHCI_SH is not set
# CONFIG_USB_OHCI_EXYNOS is not set
# CONFIG_USB_CNS3XXX_OHCI is not set
CONFIG_USB_OHCI_HCD_PLATFORM=y
CONFIG_USB_U132_HCD=y
# CONFIG_USB_SL811_HCD is not set
CONFIG_USB_R8A66597_HCD=y
CONFIG_USB_HCD_BCMA=y
CONFIG_USB_HCD_TEST_MODE=y

#
# USB Device Class drivers
#
CONFIG_USB_ACM=y
CONFIG_USB_PRINTER=y
CONFIG_USB_WDM=y
# CONFIG_USB_TMC is not set

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
CONFIG_USB_CDNS_SUPPORT=y
CONFIG_USB_CDNS_HOST=y
CONFIG_USB_CDNS3=y
CONFIG_USB_CDNS3_HOST=y
CONFIG_USB_CDNS3_TI=y
CONFIG_USB_CDNS3_IMX=y
# CONFIG_USB_MTU3 is not set
# CONFIG_USB_MUSB_HDRC is not set
CONFIG_USB_DWC3=y
# CONFIG_USB_DWC3_ULPI is not set
CONFIG_USB_DWC3_HOST=y

#
# Platform Glue Driver Support
#
CONFIG_USB_DWC3_KEYSTONE=y
CONFIG_USB_DWC3_AM62=y
# CONFIG_USB_DWC2 is not set
CONFIG_USB_CHIPIDEA=y
CONFIG_USB_CHIPIDEA_HOST=y
CONFIG_USB_CHIPIDEA_MSM=y
CONFIG_USB_CHIPIDEA_GENERIC=y
CONFIG_USB_ISP1760=y
CONFIG_USB_ISP1760_HCD=y
CONFIG_USB_ISP1760_HOST_ROLE=y

#
# USB port drivers
#
# CONFIG_USB_SERIAL is not set

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
# CONFIG_USB_IDMOUSE is not set
CONFIG_USB_FTDI_ELAN=y
CONFIG_USB_APPLEDISPLAY=y
# CONFIG_USB_QCOM_EUD is not set
CONFIG_APPLE_MFI_FASTCHARGE=y
# CONFIG_USB_SISUSBVGA is not set
CONFIG_USB_LD=y
# CONFIG_USB_TRANCEVIBRATOR is not set
# CONFIG_USB_IOWARRIOR is not set
# CONFIG_USB_TEST is not set
CONFIG_USB_EHSET_TEST_FIXTURE=y
# CONFIG_USB_ISIGHTFW is not set
CONFIG_USB_YUREX=y
# CONFIG_USB_EZUSB_FX2 is not set
# CONFIG_USB_HUB_USB251XB is not set
CONFIG_USB_HSIC_USB3503=y
CONFIG_USB_HSIC_USB4604=y
CONFIG_USB_LINK_LAYER_TEST=y
# CONFIG_USB_CHAOSKEY is not set
# CONFIG_BRCM_USB_PINMAP is not set
# CONFIG_USB_ONBOARD_HUB is not set

#
# USB Physical Layer drivers
#
CONFIG_USB_PHY=y
# CONFIG_KEYSTONE_USB_PHY is not set
CONFIG_NOP_USB_XCEIV=y
# CONFIG_AM335X_PHY_USB is not set
CONFIG_USB_GPIO_VBUS=y
# CONFIG_TAHVO_USB is not set
# CONFIG_USB_ISP1301 is not set
# CONFIG_USB_TEGRA_PHY is not set
# CONFIG_USB_ULPI is not set
# CONFIG_JZ4770_PHY is not set
# end of USB Physical Layer drivers

# CONFIG_USB_GADGET is not set
CONFIG_TYPEC=y
CONFIG_TYPEC_TCPM=y
CONFIG_TYPEC_TCPCI=y
CONFIG_TYPEC_RT1711H=y
# CONFIG_TYPEC_MT6360 is not set
# CONFIG_TYPEC_TCPCI_MAXIM is not set
CONFIG_TYPEC_FUSB302=y
# CONFIG_TYPEC_UCSI is not set
CONFIG_TYPEC_TPS6598X=y
# CONFIG_TYPEC_ANX7411 is not set
# CONFIG_TYPEC_RT1719 is not set
CONFIG_TYPEC_HD3SS3220=y
CONFIG_TYPEC_STUSB160X=y
# CONFIG_TYPEC_QCOM_PMIC is not set
# CONFIG_TYPEC_WUSB3801 is not set

#
# USB Type-C Multiplexer/DeMultiplexer Switch support
#
# CONFIG_TYPEC_MUX_FSA4480 is not set
CONFIG_TYPEC_MUX_PI3USB30532=y
# end of USB Type-C Multiplexer/DeMultiplexer Switch support

#
# USB Type-C Alternate Mode drivers
#
CONFIG_TYPEC_DP_ALTMODE=y
CONFIG_TYPEC_NVIDIA_ALTMODE=y
# end of USB Type-C Alternate Mode drivers

CONFIG_USB_ROLE_SWITCH=y
CONFIG_MMC=y
CONFIG_SDIO_UART=y
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
CONFIG_MMC_DEBUG=y
CONFIG_MMC_SDHCI=y
CONFIG_MMC_SDHCI_PLTFM=y
# CONFIG_MMC_SDHCI_OF_ESDHC is not set
# CONFIG_MMC_SDHCI_OF_SPARX5 is not set
# CONFIG_MMC_SDHCI_CNS3XXX is not set
# CONFIG_MMC_SDHCI_DOVE is not set
# CONFIG_MMC_SDHCI_TEGRA is not set
# CONFIG_MMC_SDHCI_S3C is not set
# CONFIG_MMC_SDHCI_PXAV3 is not set
# CONFIG_MMC_SDHCI_PXAV2 is not set
# CONFIG_MMC_SDHCI_BCM_KONA is not set
# CONFIG_MMC_MESON_GX is not set
# CONFIG_MMC_MOXART is not set
# CONFIG_MMC_SDHCI_ST is not set
# CONFIG_MMC_OMAP_HS is not set
# CONFIG_MMC_SDHCI_MSM is not set
# CONFIG_MMC_DAVINCI is not set
CONFIG_MMC_SPI=y
# CONFIG_MMC_S3C is not set
# CONFIG_MMC_SDHCI_SPRD is not set
# CONFIG_MMC_TMIO is not set
# CONFIG_MMC_SDHI is not set
# CONFIG_MMC_DW is not set
# CONFIG_MMC_SH_MMCIF is not set
# CONFIG_MMC_VUB300 is not set
CONFIG_MMC_USHC=y
CONFIG_MMC_USDHI6ROL0=y
CONFIG_MMC_CQHCI=y
# CONFIG_MMC_HSQ is not set
# CONFIG_MMC_BCM2835 is not set
CONFIG_MMC_MTK=y
CONFIG_MMC_SDHCI_XENON=y
# CONFIG_MMC_OWL is not set
# CONFIG_MMC_LITEX is not set
# CONFIG_MEMSTICK is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_CLASS_FLASH=y
CONFIG_LEDS_CLASS_MULTICOLOR=y
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
CONFIG_LEDS_88PM860X=y
# CONFIG_LEDS_ARIEL is not set
# CONFIG_LEDS_LM3530 is not set
# CONFIG_LEDS_LM3532 is not set
# CONFIG_LEDS_LM3642 is not set
# CONFIG_LEDS_MT6323 is not set
# CONFIG_LEDS_S3C24XX is not set
# CONFIG_LEDS_COBALT_QUBE is not set
# CONFIG_LEDS_COBALT_RAQ is not set
# CONFIG_LEDS_PCA9532 is not set
# CONFIG_LEDS_GPIO is not set
CONFIG_LEDS_LP3944=y
CONFIG_LEDS_LP3952=y
# CONFIG_LEDS_LP50XX is not set
# CONFIG_LEDS_LP8788 is not set
# CONFIG_LEDS_PCA955X is not set
# CONFIG_LEDS_PCA963X is not set
CONFIG_LEDS_WM831X_STATUS=y
# CONFIG_LEDS_WM8350 is not set
CONFIG_LEDS_DA9052=y
CONFIG_LEDS_DAC124S085=y
CONFIG_LEDS_PWM=y
# CONFIG_LEDS_REGULATOR is not set
# CONFIG_LEDS_BD2802 is not set
CONFIG_LEDS_LT3593=y
# CONFIG_LEDS_MC13783 is not set
CONFIG_LEDS_NS2=y
CONFIG_LEDS_TCA6507=y
# CONFIG_LEDS_TLC591XX is not set
CONFIG_LEDS_MAX8997=y
CONFIG_LEDS_LM355x=y
# CONFIG_LEDS_OT200 is not set
# CONFIG_LEDS_MENF21BMC is not set
# CONFIG_LEDS_IS31FL319X is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=y
CONFIG_LEDS_MLXREG=y
CONFIG_LEDS_USER=y
# CONFIG_LEDS_TI_LMU_COMMON is not set
CONFIG_LEDS_TPS6105X=y
# CONFIG_LEDS_IP30 is not set

#
# Flash and Torch LED drivers
#
CONFIG_LEDS_AS3645A=y
CONFIG_LEDS_LM3601X=y
CONFIG_LEDS_RT8515=y
CONFIG_LEDS_SGM3140=y

#
# RGB LED drivers
#
# CONFIG_LEDS_PWM_MULTICOLOR is not set

#
# LED Triggers
#
# CONFIG_LEDS_TRIGGERS is not set

#
# Simple LED drivers
#
CONFIG_ACCESSIBILITY=y

#
# Speakup console speech
#
# end of Speakup console speech

CONFIG_RTC_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
CONFIG_RTC_SYSTOHC=y
CONFIG_RTC_SYSTOHC_DEVICE="rtc0"
CONFIG_RTC_DEBUG=y
CONFIG_RTC_LIB_KUNIT_TEST=y
# CONFIG_RTC_NVMEM is not set

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
# CONFIG_RTC_INTF_DEV is not set
CONFIG_RTC_DRV_TEST=y

#
# I2C RTC drivers
#
# CONFIG_RTC_DRV_88PM860X is not set
CONFIG_RTC_DRV_88PM80X=y
CONFIG_RTC_DRV_ABB5ZES3=y
CONFIG_RTC_DRV_ABEOZ9=y
CONFIG_RTC_DRV_ABX80X=y
# CONFIG_RTC_DRV_BRCMSTB is not set
CONFIG_RTC_DRV_DS1307=y
# CONFIG_RTC_DRV_DS1307_CENTURY is not set
# CONFIG_RTC_DRV_DS1374 is not set
CONFIG_RTC_DRV_DS1672=y
CONFIG_RTC_DRV_LP8788=y
CONFIG_RTC_DRV_MAX6900=y
# CONFIG_RTC_DRV_MAX8907 is not set
CONFIG_RTC_DRV_MAX8925=y
CONFIG_RTC_DRV_MAX8997=y
# CONFIG_RTC_DRV_MAX77686 is not set
# CONFIG_RTC_DRV_RS5C372 is not set
CONFIG_RTC_DRV_ISL1208=y
CONFIG_RTC_DRV_ISL12022=y
# CONFIG_RTC_DRV_ISL12026 is not set
CONFIG_RTC_DRV_X1205=y
CONFIG_RTC_DRV_PCF8523=y
# CONFIG_RTC_DRV_PCF85063 is not set
CONFIG_RTC_DRV_PCF85363=y
# CONFIG_RTC_DRV_PCF8563 is not set
CONFIG_RTC_DRV_PCF8583=y
CONFIG_RTC_DRV_M41T80=y
CONFIG_RTC_DRV_M41T80_WDT=y
CONFIG_RTC_DRV_BQ32K=y
CONFIG_RTC_DRV_PALMAS=y
CONFIG_RTC_DRV_RC5T583=y
# CONFIG_RTC_DRV_S35390A is not set
CONFIG_RTC_DRV_FM3130=y
CONFIG_RTC_DRV_RX8010=y
# CONFIG_RTC_DRV_RX8581 is not set
CONFIG_RTC_DRV_RX8025=y
CONFIG_RTC_DRV_EM3027=y
# CONFIG_RTC_DRV_RV3028 is not set
CONFIG_RTC_DRV_RV3032=y
CONFIG_RTC_DRV_RV8803=y
# CONFIG_RTC_DRV_S5M is not set
# CONFIG_RTC_DRV_SD3078 is not set

#
# SPI RTC drivers
#
# CONFIG_RTC_DRV_M41T93 is not set
CONFIG_RTC_DRV_M41T94=y
CONFIG_RTC_DRV_DS1302=y
# CONFIG_RTC_DRV_DS1305 is not set
CONFIG_RTC_DRV_DS1343=y
CONFIG_RTC_DRV_DS1347=y
CONFIG_RTC_DRV_DS1390=y
# CONFIG_RTC_DRV_MAX6916 is not set
CONFIG_RTC_DRV_R9701=y
# CONFIG_RTC_DRV_RX4581 is not set
# CONFIG_RTC_DRV_RS5C348 is not set
CONFIG_RTC_DRV_MAX6902=y
CONFIG_RTC_DRV_PCF2123=y
# CONFIG_RTC_DRV_MCP795 is not set
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=y
CONFIG_RTC_DRV_PCF2127=y
CONFIG_RTC_DRV_RV3029C2=y
# CONFIG_RTC_DRV_RX6110 is not set

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_DS1286=y
CONFIG_RTC_DRV_DS1511=y
# CONFIG_RTC_DRV_DS1553 is not set
CONFIG_RTC_DRV_DS1685_FAMILY=y
# CONFIG_RTC_DRV_DS1685 is not set
# CONFIG_RTC_DRV_DS1689 is not set
# CONFIG_RTC_DRV_DS17285 is not set
# CONFIG_RTC_DRV_DS17485 is not set
CONFIG_RTC_DRV_DS17885=y
CONFIG_RTC_DRV_DS1742=y
# CONFIG_RTC_DRV_DS2404 is not set
CONFIG_RTC_DRV_DA9052=y
# CONFIG_RTC_DRV_DA9055 is not set
CONFIG_RTC_DRV_DA9063=y
CONFIG_RTC_DRV_STK17TA8=y
CONFIG_RTC_DRV_M48T86=y
# CONFIG_RTC_DRV_M48T35 is not set
# CONFIG_RTC_DRV_M48T59 is not set
# CONFIG_RTC_DRV_MSM6242 is not set
# CONFIG_RTC_DRV_BQ4802 is not set
# CONFIG_RTC_DRV_RP5C01 is not set
# CONFIG_RTC_DRV_V3020 is not set
# CONFIG_RTC_DRV_GAMECUBE is not set
CONFIG_RTC_DRV_WM831X=y
CONFIG_RTC_DRV_WM8350=y
# CONFIG_RTC_DRV_SC27XX is not set
CONFIG_RTC_DRV_SPEAR=y
# CONFIG_RTC_DRV_PCF50633 is not set

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_ASM9260 is not set
# CONFIG_RTC_DRV_DAVINCI is not set
# CONFIG_RTC_DRV_DIGICOLOR is not set
# CONFIG_RTC_DRV_FSL_FTM_ALARM is not set
# CONFIG_RTC_DRV_MESON is not set
# CONFIG_RTC_DRV_MESON_VRTC is not set
# CONFIG_RTC_DRV_S3C is not set
# CONFIG_RTC_DRV_EP93XX is not set
# CONFIG_RTC_DRV_GENERIC is not set
# CONFIG_RTC_DRV_VT8500 is not set
# CONFIG_RTC_DRV_SUN6I is not set
# CONFIG_RTC_DRV_SUNXI is not set
# CONFIG_RTC_DRV_MV is not set
CONFIG_RTC_DRV_FTRTC010=y
# CONFIG_RTC_DRV_STMP is not set
CONFIG_RTC_DRV_PCAP=y
# CONFIG_RTC_DRV_MC13XXX is not set
# CONFIG_RTC_DRV_LPC32XX is not set
# CONFIG_RTC_DRV_PM8XXX is not set
# CONFIG_RTC_DRV_TEGRA is not set
# CONFIG_RTC_DRV_MOXART is not set
# CONFIG_RTC_DRV_MT2712 is not set
CONFIG_RTC_DRV_MT6397=y
# CONFIG_RTC_DRV_MT7622 is not set
# CONFIG_RTC_DRV_XGENE is not set
# CONFIG_RTC_DRV_STM32 is not set
# CONFIG_RTC_DRV_RTD119X is not set
# CONFIG_RTC_DRV_TI_K3 is not set

#
# HID Sensor RTC drivers
#
# CONFIG_RTC_DRV_GOLDFISH is not set
# CONFIG_RTC_DRV_MSC313 is not set
# CONFIG_DMADEVICES is not set

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
# CONFIG_SW_SYNC is not set
# CONFIG_UDMABUF is not set
CONFIG_DMABUF_MOVE_NOTIFY=y
CONFIG_DMABUF_DEBUG=y
CONFIG_DMABUF_SELFTESTS=y
CONFIG_DMABUF_HEAPS=y
# CONFIG_DMABUF_SYSFS_STATS is not set
CONFIG_DMABUF_HEAPS_SYSTEM=y
# end of DMABUF options

# CONFIG_AUXDISPLAY is not set
CONFIG_UIO=y
# CONFIG_UIO_PDRV_GENIRQ is not set
CONFIG_UIO_DMEM_GENIRQ=y
CONFIG_UIO_PRUSS=y
CONFIG_VFIO=y
# CONFIG_VFIO_NOIOMMU is not set
# CONFIG_VFIO_PLATFORM is not set
CONFIG_VFIO_MDEV=y
CONFIG_VIRT_DRIVERS=y
CONFIG_VIRTIO_ANCHOR=y
CONFIG_VIRTIO=y
CONFIG_VIRTIO_MENU=y
CONFIG_VIRTIO_BALLOON=y
# CONFIG_VIRTIO_INPUT is not set
# CONFIG_VIRTIO_MMIO is not set
CONFIG_VIRTIO_DMA_SHARED_BUFFER=y
CONFIG_VHOST_MENU=y
CONFIG_VHOST_CROSS_ENDIAN_LEGACY=y

#
# Microsoft Hyper-V guest support
#
# end of Microsoft Hyper-V guest support

CONFIG_GREYBUS=y
CONFIG_GREYBUS_ES2=y
CONFIG_COMEDI=y
CONFIG_COMEDI_DEBUG=y
CONFIG_COMEDI_DEFAULT_BUF_SIZE_KB=2048
CONFIG_COMEDI_DEFAULT_BUF_MAXSIZE_KB=20480
CONFIG_COMEDI_MISC_DRIVERS=y
# CONFIG_COMEDI_BOND is not set
# CONFIG_COMEDI_TEST is not set
CONFIG_COMEDI_PARPORT=y
# CONFIG_COMEDI_SSV_DNP is not set
# CONFIG_COMEDI_ISA_DRIVERS is not set
CONFIG_COMEDI_USB_DRIVERS=y
# CONFIG_COMEDI_DT9812 is not set
CONFIG_COMEDI_NI_USB6501=y
CONFIG_COMEDI_USBDUX=y
CONFIG_COMEDI_USBDUXFAST=y
# CONFIG_COMEDI_USBDUXSIGMA is not set
# CONFIG_COMEDI_VMK80XX is not set
CONFIG_COMEDI_8255=y
CONFIG_COMEDI_8255_SA=y
CONFIG_COMEDI_KCOMEDILIB=y
CONFIG_COMEDI_NI_ROUTING=y
CONFIG_COMEDI_TESTS=y
# CONFIG_COMEDI_TESTS_EXAMPLE is not set
CONFIG_COMEDI_TESTS_NI_ROUTES=y
# CONFIG_STAGING is not set
CONFIG_GOLDFISH=y
# CONFIG_GOLDFISH_PIPE is not set
# CONFIG_CHROME_PLATFORMS is not set
# CONFIG_MELLANOX_PLATFORM is not set
# CONFIG_OLPC_XO175 is not set
CONFIG_SURFACE_PLATFORMS=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
# CONFIG_COMMON_CLK_WM831X is not set

#
# Clock driver for ARM Reference designs
#
# CONFIG_CLK_ICST is not set
CONFIG_CLK_SP810=y
# end of Clock driver for ARM Reference designs

# CONFIG_CLK_HSDK is not set
CONFIG_LMK04832=y
# CONFIG_COMMON_CLK_APPLE_NCO is not set
# CONFIG_COMMON_CLK_MAX77686 is not set
CONFIG_COMMON_CLK_MAX9485=y
# CONFIG_COMMON_CLK_HI655X is not set
# CONFIG_COMMON_CLK_SCMI is not set
# CONFIG_COMMON_CLK_SCPI is not set
CONFIG_COMMON_CLK_SI5341=y
CONFIG_COMMON_CLK_SI5351=y
CONFIG_COMMON_CLK_SI544=y
# CONFIG_COMMON_CLK_BM1880 is not set
CONFIG_COMMON_CLK_CDCE706=y
# CONFIG_COMMON_CLK_TPS68470 is not set
CONFIG_COMMON_CLK_CS2000_CP=y
# CONFIG_COMMON_CLK_FSL_FLEXSPI is not set
# CONFIG_COMMON_CLK_FSL_SAI is not set
# CONFIG_COMMON_CLK_GEMINI is not set
# CONFIG_COMMON_CLK_ASPEED is not set
# CONFIG_COMMON_CLK_S2MPS11 is not set
# CONFIG_CLK_LS1028A_PLLDIG is not set
# CONFIG_COMMON_CLK_XGENE is not set
CONFIG_COMMON_CLK_PALMAS=y
CONFIG_COMMON_CLK_PWM=y
# CONFIG_COMMON_CLK_OXNAS is not set
# CONFIG_COMMON_CLK_MMP2_AUDIO is not set
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

# CONFIG_TI_SYSCON_CLK is not set

#
# Clock driver for MediaTek SoC
#
# CONFIG_COMMON_CLK_MT2701 is not set
# CONFIG_COMMON_CLK_MT2712 is not set
# CONFIG_COMMON_CLK_MT6765 is not set
# CONFIG_COMMON_CLK_MT6779 is not set
# CONFIG_COMMON_CLK_MT6795 is not set
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
# CONFIG_COMMON_CLK_MT8365 is not set
# CONFIG_COMMON_CLK_MT8516 is not set
# end of Clock driver for MediaTek SoC

#
# Clock support for Amlogic platforms
#
# end of Clock support for Amlogic platforms

# CONFIG_MSTAR_MSC313_MPLL is not set
# CONFIG_MCHP_CLK_MPFS is not set
# CONFIG_COMMON_CLK_PISTACHIO is not set
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
# CONFIG_COMMON_CLK_VISCONTI is not set
# CONFIG_XILINX_VCU is not set
# CONFIG_COMMON_CLK_ZYNQMP is not set
# CONFIG_CLK_KUNIT_TEST is not set
# CONFIG_CLK_GATE_KUNIT_TEST is not set
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
# CONFIG_CLKSRC_STM32_LP is not set
# CONFIG_ARMV7M_SYSTICK is not set
# CONFIG_ATMEL_PIT is not set
# CONFIG_ATMEL_ST is not set
# CONFIG_CLKSRC_SAMSUNG_PWM is not set
# CONFIG_FSL_FTM_TIMER is not set
# CONFIG_OXNAS_RPS_TIMER is not set
# CONFIG_MTK_TIMER is not set
# CONFIG_SPRD_TIMER is not set
# CONFIG_SH_TIMER_CMT is not set
# CONFIG_SH_TIMER_MTU2 is not set
# CONFIG_RENESAS_OSTM is not set
# CONFIG_SH_TIMER_TMU is not set
# CONFIG_EM_TIMER_STI is not set
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

# CONFIG_MAILBOX is not set
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# CONFIG_IOMMU_IO_PGTABLE_ARMV7S is not set
# end of Generic IOMMU Pagetable Support

CONFIG_IOMMU_DEBUGFS=y
# CONFIG_IOMMU_DEFAULT_DMA_STRICT is not set
CONFIG_IOMMU_DEFAULT_DMA_LAZY=y
# CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
# CONFIG_OMAP_IOMMU is not set
# CONFIG_ROCKCHIP_IOMMU is not set
# CONFIG_SUN50I_IOMMU is not set
# CONFIG_EXYNOS_IOMMU is not set
# CONFIG_S390_CCW_IOMMU is not set
# CONFIG_S390_AP_IOMMU is not set
# CONFIG_MTK_IOMMU is not set
# CONFIG_SPRD_IOMMU is not set

#
# Remoteproc drivers
#
CONFIG_REMOTEPROC=y
CONFIG_REMOTEPROC_CDEV=y
# CONFIG_INGENIC_VPU_RPROC is not set
# CONFIG_MTK_SCP is not set
# CONFIG_MESON_MX_AO_ARC_REMOTEPROC is not set
# CONFIG_RCAR_REMOTEPROC is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
# CONFIG_RPMSG_VIRTIO is not set
# end of Rpmsg drivers

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
# CONFIG_SOC_BCM63XX is not set
# CONFIG_SOC_BRCMSTB is not set
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# end of NXP/Freescale QorIQ SoC drivers

#
# fujitsu SoC drivers
#
# end of fujitsu SoC drivers

#
# i.MX SoC drivers
#
# CONFIG_SOC_IMX8M is not set
# CONFIG_SOC_IMX9 is not set
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
# CONFIG_MTK_MMSYS is not set
# end of MediaTek SoC drivers

#
# Qualcomm SoC drivers
#
# CONFIG_QCOM_GENI_SE is not set
# CONFIG_QCOM_GSBI is not set
# CONFIG_QCOM_LLCC is not set
# CONFIG_QCOM_RPMH is not set
# CONFIG_QCOM_SPM is not set
# CONFIG_QCOM_ICC_BWMON is not set
# end of Qualcomm SoC drivers

# CONFIG_SOC_RENESAS is not set
# CONFIG_ROCKCHIP_GRF is not set
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

# CONFIG_PM_DEVFREQ is not set
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
# CONFIG_EXTCON_ADC_JACK is not set
CONFIG_EXTCON_FSA9480=y
CONFIG_EXTCON_GPIO=y
# CONFIG_EXTCON_MAX3355 is not set
# CONFIG_EXTCON_MAX77693 is not set
CONFIG_EXTCON_MAX8997=y
CONFIG_EXTCON_PALMAS=y
CONFIG_EXTCON_PTN5150=y
# CONFIG_EXTCON_QCOM_SPMI_MISC is not set
CONFIG_EXTCON_RT8973A=y
# CONFIG_EXTCON_SM5502 is not set
CONFIG_EXTCON_USB_GPIO=y
CONFIG_EXTCON_USBC_TUSB320=y
# CONFIG_MEMORY is not set
CONFIG_IIO=y
CONFIG_IIO_BUFFER=y
CONFIG_IIO_BUFFER_CB=y
CONFIG_IIO_BUFFER_DMA=y
# CONFIG_IIO_BUFFER_DMAENGINE is not set
CONFIG_IIO_BUFFER_HW_CONSUMER=y
CONFIG_IIO_KFIFO_BUF=y
CONFIG_IIO_TRIGGERED_BUFFER=y
CONFIG_IIO_CONFIGFS=y
CONFIG_IIO_TRIGGER=y
CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
CONFIG_IIO_SW_DEVICE=y
CONFIG_IIO_SW_TRIGGER=y
CONFIG_IIO_TRIGGERED_EVENT=y

#
# Accelerometers
#
CONFIG_ADIS16201=y
# CONFIG_ADIS16209 is not set
# CONFIG_ADXL313_I2C is not set
# CONFIG_ADXL313_SPI is not set
CONFIG_ADXL345=y
CONFIG_ADXL345_I2C=y
CONFIG_ADXL345_SPI=y
# CONFIG_ADXL355_I2C is not set
# CONFIG_ADXL355_SPI is not set
# CONFIG_ADXL367_SPI is not set
# CONFIG_ADXL367_I2C is not set
CONFIG_ADXL372=y
CONFIG_ADXL372_SPI=y
# CONFIG_ADXL372_I2C is not set
CONFIG_BMA180=y
# CONFIG_BMA220 is not set
CONFIG_BMA400=y
CONFIG_BMA400_I2C=y
CONFIG_BMA400_SPI=y
# CONFIG_BMC150_ACCEL is not set
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
CONFIG_MC3230=y
CONFIG_MMA7455=y
CONFIG_MMA7455_I2C=y
CONFIG_MMA7455_SPI=y
CONFIG_MMA7660=y
CONFIG_MMA8452=y
CONFIG_MMA9551_CORE=y
CONFIG_MMA9551=y
CONFIG_MMA9553=y
# CONFIG_MSA311 is not set
CONFIG_MXC4005=y
# CONFIG_MXC6255 is not set
# CONFIG_SCA3000 is not set
# CONFIG_SCA3300 is not set
CONFIG_STK8312=y
# CONFIG_STK8BA50 is not set
# end of Accelerometers

#
# Analog to digital converters
#
CONFIG_AD_SIGMA_DELTA=y
CONFIG_AD7091R5=y
CONFIG_AD7124=y
CONFIG_AD7192=y
CONFIG_AD7266=y
# CONFIG_AD7280 is not set
# CONFIG_AD7291 is not set
# CONFIG_AD7292 is not set
CONFIG_AD7298=y
CONFIG_AD7476=y
CONFIG_AD7606=y
# CONFIG_AD7606_IFACE_PARALLEL is not set
CONFIG_AD7606_IFACE_SPI=y
CONFIG_AD7766=y
CONFIG_AD7768_1=y
CONFIG_AD7780=y
CONFIG_AD7791=y
CONFIG_AD7793=y
# CONFIG_AD7887 is not set
CONFIG_AD7923=y
CONFIG_AD7949=y
# CONFIG_AD799X is not set
# CONFIG_ASPEED_ADC is not set
# CONFIG_AT91_SAMA5D2_ADC is not set
# CONFIG_AXP20X_ADC is not set
# CONFIG_AXP288_ADC is not set
# CONFIG_BCM_IPROC_ADC is not set
# CONFIG_BERLIN2_ADC is not set
CONFIG_CC10001_ADC=y
CONFIG_DA9150_GPADC=y
# CONFIG_ENVELOPE_DETECTOR is not set
CONFIG_HI8435=y
CONFIG_HX711=y
# CONFIG_INA2XX_ADC is not set
# CONFIG_INGENIC_ADC is not set
# CONFIG_IMX7D_ADC is not set
# CONFIG_IMX8QXP_ADC is not set
CONFIG_LP8788_ADC=y
# CONFIG_LPC18XX_ADC is not set
# CONFIG_LPC32XX_ADC is not set
CONFIG_LTC2471=y
CONFIG_LTC2485=y
# CONFIG_LTC2496 is not set
# CONFIG_LTC2497 is not set
# CONFIG_MAX1027 is not set
CONFIG_MAX11100=y
CONFIG_MAX1118=y
# CONFIG_MAX11205 is not set
# CONFIG_MAX1241 is not set
# CONFIG_MAX1363 is not set
CONFIG_MAX9611=y
CONFIG_MCP320X=y
# CONFIG_MCP3422 is not set
CONFIG_MCP3911=y
CONFIG_MEDIATEK_MT6360_ADC=y
# CONFIG_MEDIATEK_MT6577_AUXADC is not set
CONFIG_MP2629_ADC=y
# CONFIG_NAU7802 is not set
# CONFIG_NPCM_ADC is not set
CONFIG_PALMAS_GPADC=y
# CONFIG_RCAR_GYRO_ADC is not set
# CONFIG_ROCKCHIP_SARADC is not set
# CONFIG_RICHTEK_RTQ6056 is not set
# CONFIG_RZG2L_ADC is not set
# CONFIG_SC27XX_ADC is not set
# CONFIG_SPEAR_ADC is not set
# CONFIG_SD_ADC_MODULATOR is not set
# CONFIG_STM32_DFSDM_CORE is not set
# CONFIG_STM32_DFSDM_ADC is not set
CONFIG_TI_ADC081C=y
# CONFIG_TI_ADC0832 is not set
CONFIG_TI_ADC084S021=y
CONFIG_TI_ADC12138=y
# CONFIG_TI_ADC108S102 is not set
# CONFIG_TI_ADC128S052 is not set
# CONFIG_TI_ADC161S626 is not set
# CONFIG_TI_ADS1015 is not set
CONFIG_TI_ADS7950=y
# CONFIG_TI_ADS8344 is not set
# CONFIG_TI_ADS8688 is not set
# CONFIG_TI_ADS124S08 is not set
# CONFIG_TI_ADS131E08 is not set
CONFIG_TI_AM335X_ADC=y
# CONFIG_TI_TLC4541 is not set
CONFIG_TI_TSC2046=y
CONFIG_TWL4030_MADC=y
# CONFIG_TWL6030_GPADC is not set
# CONFIG_VF610_ADC is not set
CONFIG_VIPERBOARD_ADC=y
CONFIG_XILINX_XADC=y
# CONFIG_XILINX_AMS is not set
# end of Analog to digital converters

#
# Analog to digital and digital to analog converters
#
# CONFIG_AD74413R is not set
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
CONFIG_AD7150=y
# CONFIG_AD7746 is not set
# end of Capacitance to digital converters

#
# Chemical Sensors
#
CONFIG_ATLAS_PH_SENSOR=y
# CONFIG_ATLAS_EZO_SENSOR is not set
CONFIG_BME680=y
CONFIG_BME680_I2C=y
CONFIG_BME680_SPI=y
# CONFIG_CCS811 is not set
CONFIG_IAQCORE=y
CONFIG_PMS7003=y
CONFIG_SCD30_CORE=y
CONFIG_SCD30_I2C=y
CONFIG_SCD30_SERIAL=y
# CONFIG_SCD4X is not set
CONFIG_SENSIRION_SGP30=y
CONFIG_SENSIRION_SGP40=y
CONFIG_SPS30=y
# CONFIG_SPS30_I2C is not set
CONFIG_SPS30_SERIAL=y
# CONFIG_SENSEAIR_SUNRISE_CO2 is not set
# CONFIG_VZ89X is not set
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
# CONFIG_IIO_SSP_SENSORHUB is not set
# end of SSP Sensor Common

#
# Digital to analog converters
#
# CONFIG_AD3552R is not set
CONFIG_AD5064=y
CONFIG_AD5360=y
# CONFIG_AD5380 is not set
CONFIG_AD5421=y
CONFIG_AD5446=y
CONFIG_AD5449=y
CONFIG_AD5592R_BASE=y
CONFIG_AD5592R=y
CONFIG_AD5593R=y
CONFIG_AD5504=y
CONFIG_AD5624R_SPI=y
# CONFIG_LTC2688 is not set
CONFIG_AD5686=y
CONFIG_AD5686_SPI=y
CONFIG_AD5696_I2C=y
CONFIG_AD5755=y
CONFIG_AD5758=y
CONFIG_AD5761=y
# CONFIG_AD5764 is not set
CONFIG_AD5766=y
# CONFIG_AD5770R is not set
# CONFIG_AD5791 is not set
# CONFIG_AD7293 is not set
CONFIG_AD7303=y
CONFIG_AD8801=y
# CONFIG_DPOT_DAC is not set
CONFIG_DS4424=y
# CONFIG_LPC18XX_DAC is not set
CONFIG_LTC1660=y
CONFIG_LTC2632=y
# CONFIG_M62332 is not set
# CONFIG_MAX517 is not set
# CONFIG_MAX5821 is not set
# CONFIG_MCP4725 is not set
CONFIG_MCP4922=y
# CONFIG_STM32_DAC is not set
CONFIG_TI_DAC082S085=y
# CONFIG_TI_DAC5571 is not set
CONFIG_TI_DAC7311=y
# CONFIG_TI_DAC7612 is not set
# CONFIG_VF610_DAC is not set
# end of Digital to analog converters

#
# IIO dummy driver
#
CONFIG_IIO_DUMMY_EVGEN=y
CONFIG_IIO_SIMPLE_DUMMY=y
CONFIG_IIO_SIMPLE_DUMMY_EVENTS=y
CONFIG_IIO_SIMPLE_DUMMY_BUFFER=y
# end of IIO dummy driver

#
# Filters
#
# end of Filters

#
# Frequency Synthesizers DDS/PLL
#

#
# Clock Generator/Distribution
#
# CONFIG_AD9523 is not set
# end of Clock Generator/Distribution

#
# Phase-Locked Loop (PLL) frequency synthesizers
#
CONFIG_ADF4350=y
# CONFIG_ADF4371 is not set
# CONFIG_ADMV1013 is not set
# CONFIG_ADMV4420 is not set
# CONFIG_ADRF6780 is not set
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
# CONFIG_BMG160 is not set
# CONFIG_FXAS21002C is not set
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
CONFIG_MAX30100=y
CONFIG_MAX30102=y
# end of Heart Rate Monitors
# end of Health Sensors

#
# Humidity sensors
#
CONFIG_AM2315=y
CONFIG_DHT11=y
CONFIG_HDC100X=y
CONFIG_HDC2010=y
CONFIG_HTS221=y
CONFIG_HTS221_I2C=y
CONFIG_HTS221_SPI=y
CONFIG_HTU21=y
CONFIG_SI7005=y
CONFIG_SI7020=y
# end of Humidity sensors

#
# Inertial measurement units
#
# CONFIG_ADIS16400 is not set
CONFIG_ADIS16460=y
# CONFIG_ADIS16475 is not set
# CONFIG_ADIS16480 is not set
CONFIG_BMI160=y
# CONFIG_BMI160_I2C is not set
CONFIG_BMI160_SPI=y
# CONFIG_BOSCH_BNO055_SERIAL is not set
# CONFIG_BOSCH_BNO055_I2C is not set
CONFIG_FXOS8700=y
CONFIG_FXOS8700_I2C=y
# CONFIG_FXOS8700_SPI is not set
CONFIG_KMX61=y
CONFIG_INV_ICM42600=y
CONFIG_INV_ICM42600_I2C=y
CONFIG_INV_ICM42600_SPI=y
CONFIG_INV_MPU6050_IIO=y
CONFIG_INV_MPU6050_I2C=y
# CONFIG_INV_MPU6050_SPI is not set
CONFIG_IIO_ST_LSM6DSX=y
CONFIG_IIO_ST_LSM6DSX_I2C=y
CONFIG_IIO_ST_LSM6DSX_SPI=y
CONFIG_IIO_ST_LSM6DSX_I3C=y
# end of Inertial measurement units

CONFIG_IIO_ADIS_LIB=y
CONFIG_IIO_ADIS_LIB_BUFFER=y

#
# Light sensors
#
CONFIG_ADJD_S311=y
CONFIG_ADUX1020=y
CONFIG_AL3010=y
CONFIG_AL3320A=y
CONFIG_APDS9300=y
CONFIG_APDS9960=y
# CONFIG_AS73211 is not set
CONFIG_BH1750=y
# CONFIG_BH1780 is not set
# CONFIG_CM32181 is not set
# CONFIG_CM3232 is not set
# CONFIG_CM3323 is not set
# CONFIG_CM3605 is not set
CONFIG_CM36651=y
CONFIG_GP2AP002=y
CONFIG_GP2AP020A00F=y
# CONFIG_IQS621_ALS is not set
CONFIG_SENSORS_ISL29018=y
CONFIG_SENSORS_ISL29028=y
CONFIG_ISL29125=y
CONFIG_JSA1212=y
# CONFIG_RPR0521 is not set
CONFIG_LTR501=y
# CONFIG_LTRF216A is not set
CONFIG_LV0104CS=y
CONFIG_MAX44000=y
CONFIG_MAX44009=y
# CONFIG_NOA1305 is not set
CONFIG_OPT3001=y
CONFIG_PA12203001=y
# CONFIG_SI1133 is not set
CONFIG_SI1145=y
# CONFIG_STK3310 is not set
CONFIG_ST_UVIS25=y
CONFIG_ST_UVIS25_I2C=y
CONFIG_ST_UVIS25_SPI=y
CONFIG_TCS3414=y
# CONFIG_TCS3472 is not set
CONFIG_SENSORS_TSL2563=y
CONFIG_TSL2583=y
CONFIG_TSL2591=y
CONFIG_TSL2772=y
CONFIG_TSL4531=y
# CONFIG_US5182D is not set
CONFIG_VCNL4000=y
# CONFIG_VCNL4035 is not set
# CONFIG_VEML6030 is not set
# CONFIG_VEML6070 is not set
CONFIG_VL6180=y
# CONFIG_ZOPT2201 is not set
# end of Light sensors

#
# Magnetometer sensors
#
# CONFIG_AK8974 is not set
CONFIG_AK8975=y
# CONFIG_AK09911 is not set
# CONFIG_BMC150_MAGN_I2C is not set
# CONFIG_BMC150_MAGN_SPI is not set
CONFIG_MAG3110=y
# CONFIG_MMC35240 is not set
# CONFIG_IIO_ST_MAGN_3AXIS is not set
CONFIG_SENSORS_HMC5843=y
CONFIG_SENSORS_HMC5843_I2C=y
CONFIG_SENSORS_HMC5843_SPI=y
CONFIG_SENSORS_RM3100=y
# CONFIG_SENSORS_RM3100_I2C is not set
CONFIG_SENSORS_RM3100_SPI=y
CONFIG_YAMAHA_YAS530=y
# end of Magnetometer sensors

#
# Multiplexers
#
# CONFIG_IIO_MUX is not set
# end of Multiplexers

#
# Inclinometer sensors
#
# end of Inclinometer sensors

# CONFIG_IIO_FORMAT_KUNIT_TEST is not set

#
# Triggers - standalone
#
CONFIG_IIO_HRTIMER_TRIGGER=y
CONFIG_IIO_INTERRUPT_TRIGGER=y
# CONFIG_IIO_STM32_LPTIMER_TRIGGER is not set
# CONFIG_IIO_STM32_TIMER_TRIGGER is not set
# CONFIG_IIO_TIGHTLOOP_TRIGGER is not set
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
CONFIG_AD5272=y
CONFIG_DS1803=y
CONFIG_MAX5432=y
# CONFIG_MAX5481 is not set
CONFIG_MAX5487=y
CONFIG_MCP4018=y
# CONFIG_MCP4131 is not set
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
CONFIG_DLHL60D=y
CONFIG_DPS310=y
CONFIG_HP03=y
CONFIG_ICP10100=y
CONFIG_MPL115=y
CONFIG_MPL115_I2C=y
# CONFIG_MPL115_SPI is not set
CONFIG_MPL3115=y
CONFIG_MS5611=y
CONFIG_MS5611_I2C=y
CONFIG_MS5611_SPI=y
# CONFIG_MS5637 is not set
# CONFIG_IIO_ST_PRESS is not set
CONFIG_T5403=y
CONFIG_HP206C=y
# CONFIG_ZPA2326 is not set
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
# CONFIG_MB1232 is not set
CONFIG_PING=y
CONFIG_RFD77402=y
CONFIG_SRF04=y
CONFIG_SX_COMMON=y
# CONFIG_SX9310 is not set
CONFIG_SX9324=y
# CONFIG_SX9360 is not set
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
# CONFIG_LTC2983 is not set
# CONFIG_MAXIM_THERMOCOUPLE is not set
# CONFIG_MLX90614 is not set
# CONFIG_MLX90632 is not set
CONFIG_TMP006=y
CONFIG_TMP007=y
# CONFIG_TMP117 is not set
CONFIG_TSYS01=y
# CONFIG_TSYS02D is not set
# CONFIG_MAX31856 is not set
# CONFIG_MAX31865 is not set
# end of Temperature sensors

CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
CONFIG_PWM_DEBUG=y
# CONFIG_PWM_BCM_IPROC is not set
# CONFIG_PWM_BCM_KONA is not set
# CONFIG_PWM_BCM2835 is not set
# CONFIG_PWM_BERLIN is not set
# CONFIG_PWM_BRCMSTB is not set
# CONFIG_PWM_CLK is not set
# CONFIG_PWM_CLPS711X is not set
# CONFIG_PWM_EP93XX is not set
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
# CONFIG_PWM_LPSS_PLATFORM is not set
# CONFIG_PWM_MESON is not set
# CONFIG_PWM_MTK_DISP is not set
# CONFIG_PWM_MEDIATEK is not set
CONFIG_PWM_PCA9685=y
# CONFIG_PWM_PXA is not set
# CONFIG_PWM_RASPBERRYPI_POE is not set
# CONFIG_PWM_RCAR is not set
# CONFIG_PWM_RENESAS_TPU is not set
# CONFIG_PWM_ROCKCHIP is not set
# CONFIG_PWM_SAMSUNG is not set
# CONFIG_PWM_SL28CPLD is not set
# CONFIG_PWM_SPRD is not set
# CONFIG_PWM_STM32 is not set
# CONFIG_PWM_STM32_LP is not set
# CONFIG_PWM_SUN4I is not set
# CONFIG_PWM_TEGRA is not set
# CONFIG_PWM_TIECAP is not set
# CONFIG_PWM_TIEHRPWM is not set
# CONFIG_PWM_TWL is not set
CONFIG_PWM_TWL_LED=y
# CONFIG_PWM_VISCONTI is not set
# CONFIG_PWM_VT8500 is not set

#
# IRQ chip support
#
# CONFIG_AL_FIC is not set
# CONFIG_RENESAS_INTC_IRQPIN is not set
# CONFIG_RENESAS_IRQC is not set
# CONFIG_RENESAS_RZA1_IRQC is not set
# CONFIG_RENESAS_RZG2L_IRQC is not set
# CONFIG_SL28CPLD_INTC is not set
# CONFIG_TS4800_IRQ is not set
# CONFIG_INGENIC_TCU_IRQ is not set
# CONFIG_IRQ_UNIPHIER_AIDET is not set
# CONFIG_MESON_IRQ_GPIO is not set
# CONFIG_IMX_IRQSTEER is not set
# CONFIG_IMX_INTMUX is not set
# CONFIG_EXYNOS_IRQ_COMBINER is not set
# CONFIG_MST_IRQ is not set
# CONFIG_MCHP_EIC is not set
# CONFIG_SUNPLUS_SP7021_INTC is not set
# end of IRQ chip support

# CONFIG_IPACK_BUS is not set
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
# CONFIG_RESET_ZYNQ is not set
# CONFIG_COMMON_RESET_HI3660 is not set
# CONFIG_COMMON_RESET_HI6220 is not set

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
# CONFIG_PHY_PISTACHIO_USB is not set
# CONFIG_USB_LGM_PHY is not set
# CONFIG_PHY_CAN_TRANSCEIVER is not set
# CONFIG_PHY_SUN4I_USB is not set
# CONFIG_PHY_SUN6I_MIPI_DPHY is not set
# CONFIG_PHY_SUN9I_USB is not set

#
# PHY drivers for Broadcom platforms
#
# CONFIG_PHY_BCM63XX_USBH is not set
CONFIG_BCM_KONA_USB2_PHY=y
# end of PHY drivers for Broadcom platforms

# CONFIG_PHY_HI6220_USB is not set
# CONFIG_PHY_HI3660_USB is not set
# CONFIG_PHY_HI3670_USB is not set
# CONFIG_PHY_HI3670_PCIE is not set
# CONFIG_PHY_HISTB_COMBPHY is not set
# CONFIG_PHY_HISI_INNO_USB2 is not set
# CONFIG_PHY_INGENIC_USB is not set
CONFIG_PHY_PXA_28NM_HSIC=y
CONFIG_PHY_PXA_28NM_USB2=y
# CONFIG_PHY_PXA_USB is not set
# CONFIG_PHY_MMP3_USB is not set
# CONFIG_PHY_MMP3_HSIC is not set
CONFIG_PHY_CPCAP_USB=y
# CONFIG_PHY_QCOM_USB_HS is not set
CONFIG_PHY_QCOM_USB_HSIC=y
# CONFIG_PHY_MT7621_PCI is not set
# CONFIG_PHY_RALINK_USB is not set
# CONFIG_PHY_RCAR_GEN3_USB3 is not set
# CONFIG_PHY_ROCKCHIP_DPHY_RX0 is not set
# CONFIG_PHY_ROCKCHIP_PCIE is not set
# CONFIG_PHY_ROCKCHIP_SNPS_PCIE3 is not set
# CONFIG_PHY_EXYNOS_MIPI_VIDEO is not set
CONFIG_PHY_SAMSUNG_USB2=y
# CONFIG_PHY_S5PV210_USB2 is not set
# CONFIG_PHY_ST_SPEAR1310_MIPHY is not set
# CONFIG_PHY_ST_SPEAR1340_MIPHY is not set
# CONFIG_PHY_STIH407_USB is not set
# CONFIG_PHY_STM32_USBPHYC is not set
# CONFIG_PHY_TEGRA194_P2U is not set
# CONFIG_PHY_DA8XX_USB is not set
# CONFIG_PHY_DM816X_USB is not set
# CONFIG_PHY_AM654_SERDES is not set
# CONFIG_OMAP_CONTROL_PHY is not set
# CONFIG_TI_PIPE3 is not set
# CONFIG_PHY_TUSB1210 is not set
# CONFIG_PHY_INTEL_KEEMBAY_EMMC is not set
# CONFIG_PHY_INTEL_KEEMBAY_USB is not set
# CONFIG_PHY_INTEL_LGM_EMMC is not set
# CONFIG_PHY_XILINX_ZYNQMP is not set
# end of PHY Subsystem

# CONFIG_POWERCAP is not set
# CONFIG_MCB is not set

#
# Performance monitor support
#
# CONFIG_ARM_CCN is not set
# CONFIG_ARM_CMN is not set
# CONFIG_FSL_IMX8_DDR_PMU is not set
# CONFIG_ARM_DMC620_PMU is not set
# CONFIG_ALIBABA_UNCORE_DRW_PMU is not set
# end of Performance monitor support

CONFIG_RAS=y

#
# Android
#
# CONFIG_ANDROID_BINDER_IPC is not set
# end of Android

CONFIG_DAX=y
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y
# CONFIG_NVMEM_APPLE_EFUSES is not set
# CONFIG_NVMEM_BCM_OCOTP is not set
# CONFIG_NVMEM_BRCM_NVRAM is not set
# CONFIG_NVMEM_IMX_IIM is not set
# CONFIG_NVMEM_IMX_OCOTP is not set
# CONFIG_NVMEM_LAN9662_OTPC is not set
# CONFIG_NVMEM_LAYERSCAPE_SFP is not set
# CONFIG_NVMEM_LPC18XX_EEPROM is not set
# CONFIG_NVMEM_LPC18XX_OTP is not set
# CONFIG_NVMEM_MESON_MX_EFUSE is not set
# CONFIG_NVMEM_MICROCHIP_OTPC is not set
# CONFIG_NVMEM_MTK_EFUSE is not set
# CONFIG_NVMEM_MXS_OCOTP is not set
# CONFIG_NVMEM_NINTENDO_OTP is not set
# CONFIG_NVMEM_QCOM_QFPROM is not set
# CONFIG_NVMEM_RAVE_SP_EEPROM is not set
CONFIG_NVMEM_RMEM=y
# CONFIG_NVMEM_ROCKCHIP_EFUSE is not set
# CONFIG_NVMEM_ROCKCHIP_OTP is not set
# CONFIG_NVMEM_SC27XX_EFUSE is not set
# CONFIG_NVMEM_SNVS_LPGPR is not set
# CONFIG_NVMEM_SPRD_EFUSE is not set
# CONFIG_NVMEM_STM32_ROMEM is not set
# CONFIG_NVMEM_SUNPLUS_OCOTP is not set
# CONFIG_NVMEM_UNIPHIER_EFUSE is not set
# CONFIG_NVMEM_VF610_OCOTP is not set

#
# HW tracing support
#
CONFIG_STM=y
CONFIG_STM_PROTO_BASIC=y
CONFIG_STM_PROTO_SYS_T=y
CONFIG_STM_DUMMY=y
# CONFIG_STM_SOURCE_CONSOLE is not set
# CONFIG_STM_SOURCE_HEARTBEAT is not set
# CONFIG_STM_SOURCE_FTRACE is not set
CONFIG_INTEL_TH=y
# CONFIG_INTEL_TH_GTH is not set
# CONFIG_INTEL_TH_STH is not set
CONFIG_INTEL_TH_MSU=y
CONFIG_INTEL_TH_PTI=y
# CONFIG_INTEL_TH_DEBUG is not set
# end of HW tracing support

CONFIG_FPGA=y
# CONFIG_FPGA_MGR_SOCFPGA is not set
# CONFIG_FPGA_MGR_SOCFPGA_A10 is not set
CONFIG_ALTERA_PR_IP_CORE=y
CONFIG_FPGA_MGR_ALTERA_PS_SPI=y
# CONFIG_FPGA_MGR_ZYNQ_FPGA is not set
CONFIG_FPGA_MGR_XILINX_SPI=y
CONFIG_FPGA_MGR_MACHXO2_SPI=y
# CONFIG_FPGA_BRIDGE is not set
# CONFIG_FPGA_DFL is not set
# CONFIG_FPGA_MGR_ZYNQMP_FPGA is not set
# CONFIG_FPGA_MGR_VERSAL_FPGA is not set
# CONFIG_FPGA_MGR_MICROCHIP_SPI is not set
# CONFIG_TEE is not set
CONFIG_SIOX=y
# CONFIG_SIOX_BUS_GPIO is not set
CONFIG_SLIMBUS=y
# CONFIG_SLIM_QCOM_CTRL is not set
# CONFIG_INTERCONNECT is not set
CONFIG_COUNTER=y
# CONFIG_104_QUAD_8 is not set
CONFIG_INTERRUPT_CNT=y
# CONFIG_STM32_TIMER_CNT is not set
# CONFIG_STM32_LPTIMER_CNT is not set
# CONFIG_TI_EQEP is not set
# CONFIG_TI_ECAP_CAPTURE is not set
CONFIG_MOST=y
CONFIG_MOST_USB_HDM=y
CONFIG_MOST_CDEV=y
# CONFIG_PECI is not set
# CONFIG_HTE is not set
# end of Device Drivers

#
# File systems
#
CONFIG_VALIDATE_FS_PARSER=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
# CONFIG_EXPORTFS_BLOCK_OPS is not set
# CONFIG_FILE_LOCKING is not set
# CONFIG_FS_ENCRYPTION is not set
# CONFIG_FS_VERITY is not set
CONFIG_FSNOTIFY=y
# CONFIG_DNOTIFY is not set
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
CONFIG_QUOTA=y
# CONFIG_PRINT_QUOTA_WARNING is not set
# CONFIG_QUOTA_DEBUG is not set
# CONFIG_QFMT_V1 is not set
# CONFIG_QFMT_V2 is not set
CONFIG_QUOTACTL=y
# CONFIG_AUTOFS4_FS is not set
# CONFIG_AUTOFS_FS is not set
CONFIG_FUSE_FS=y
CONFIG_CUSE=y
# CONFIG_VIRTIO_FS is not set
CONFIG_OVERLAY_FS=y
CONFIG_OVERLAY_FS_REDIRECT_DIR=y
# CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
# CONFIG_OVERLAY_FS_INDEX is not set
# CONFIG_OVERLAY_FS_METACOPY is not set

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
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_TMPFS_POSIX_ACL is not set
CONFIG_TMPFS_XATTR=y
CONFIG_MEMFD_CREATE=y
CONFIG_CONFIGFS_FS=y
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
# CONFIG_NLS_CODEPAGE_857 is not set
CONFIG_NLS_CODEPAGE_860=y
CONFIG_NLS_CODEPAGE_861=y
# CONFIG_NLS_CODEPAGE_862 is not set
CONFIG_NLS_CODEPAGE_863=y
# CONFIG_NLS_CODEPAGE_864 is not set
CONFIG_NLS_CODEPAGE_865=y
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
CONFIG_NLS_CODEPAGE_936=y
CONFIG_NLS_CODEPAGE_950=y
# CONFIG_NLS_CODEPAGE_932 is not set
CONFIG_NLS_CODEPAGE_949=y
CONFIG_NLS_CODEPAGE_874=y
CONFIG_NLS_ISO8859_8=y
CONFIG_NLS_CODEPAGE_1250=y
CONFIG_NLS_CODEPAGE_1251=y
CONFIG_NLS_ASCII=y
# CONFIG_NLS_ISO8859_1 is not set
CONFIG_NLS_ISO8859_2=y
# CONFIG_NLS_ISO8859_3 is not set
CONFIG_NLS_ISO8859_4=y
CONFIG_NLS_ISO8859_5=y
CONFIG_NLS_ISO8859_6=y
# CONFIG_NLS_ISO8859_7 is not set
CONFIG_NLS_ISO8859_9=y
CONFIG_NLS_ISO8859_13=y
CONFIG_NLS_ISO8859_14=y
# CONFIG_NLS_ISO8859_15 is not set
CONFIG_NLS_KOI8_R=y
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_MAC_ROMAN is not set
# CONFIG_NLS_MAC_CELTIC is not set
# CONFIG_NLS_MAC_CENTEURO is not set
CONFIG_NLS_MAC_CROATIAN=y
CONFIG_NLS_MAC_CYRILLIC=y
CONFIG_NLS_MAC_GAELIC=y
CONFIG_NLS_MAC_GREEK=y
# CONFIG_NLS_MAC_ICELAND is not set
CONFIG_NLS_MAC_INUIT=y
CONFIG_NLS_MAC_ROMANIAN=y
# CONFIG_NLS_MAC_TURKISH is not set
CONFIG_NLS_UTF8=y
CONFIG_UNICODE=y
CONFIG_UNICODE_NORMALIZATION_SELFTEST=y
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_KEYS_REQUEST_CACHE is not set
CONFIG_PERSISTENT_KEYRINGS=y
CONFIG_BIG_KEYS=y
# CONFIG_TRUSTED_KEYS is not set
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_USER_DECRYPTED_DATA is not set
CONFIG_KEY_DH_OPERATIONS=y
# CONFIG_KEY_NOTIFICATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
# CONFIG_SECURITY is not set
CONFIG_SECURITYFS=y
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
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
CONFIG_CC_HAS_AUTO_VAR_INIT_ZERO_BARE=y
CONFIG_CC_HAS_AUTO_VAR_INIT_ZERO=y
# CONFIG_INIT_STACK_NONE is not set
# CONFIG_INIT_STACK_ALL_PATTERN is not set
CONFIG_INIT_STACK_ALL_ZERO=y
# CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
# end of Memory initialization

CONFIG_CC_HAS_RANDSTRUCT=y
# CONFIG_RANDSTRUCT_NONE is not set
CONFIG_RANDSTRUCT_FULL=y
CONFIG_RANDSTRUCT=y
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
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
# CONFIG_CRYPTO_PCRYPT is not set
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=y
CONFIG_CRYPTO_TEST=y
CONFIG_CRYPTO_ENGINE=y
# end of Crypto core or helper

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=y
# CONFIG_CRYPTO_DH_RFC7919_GROUPS is not set
CONFIG_CRYPTO_ECC=y
CONFIG_CRYPTO_ECDH=y
CONFIG_CRYPTO_ECDSA=y
CONFIG_CRYPTO_ECRDSA=y
CONFIG_CRYPTO_SM2=y
CONFIG_CRYPTO_CURVE25519=y
# end of Public-key cryptography

#
# Block ciphers
#
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_AES_TI=y
# CONFIG_CRYPTO_ARIA is not set
# CONFIG_CRYPTO_BLOWFISH is not set
CONFIG_CRYPTO_CAMELLIA=y
CONFIG_CRYPTO_CAST_COMMON=y
CONFIG_CRYPTO_CAST5=y
CONFIG_CRYPTO_CAST6=y
CONFIG_CRYPTO_DES=y
CONFIG_CRYPTO_FCRYPT=y
CONFIG_CRYPTO_SERPENT=y
# CONFIG_CRYPTO_SM4_GENERIC is not set
CONFIG_CRYPTO_TWOFISH=y
CONFIG_CRYPTO_TWOFISH_COMMON=y
# end of Block ciphers

#
# Length-preserving ciphers and modes
#
# CONFIG_CRYPTO_ADIANTUM is not set
# CONFIG_CRYPTO_CHACHA20 is not set
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CFB=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
# CONFIG_CRYPTO_HCTR2 is not set
CONFIG_CRYPTO_KEYWRAP=y
CONFIG_CRYPTO_LRW=y
CONFIG_CRYPTO_OFB=y
# CONFIG_CRYPTO_PCBC is not set
# CONFIG_CRYPTO_XTS is not set
# end of Length-preserving ciphers and modes

#
# AEAD (authenticated encryption with associated data) ciphers
#
CONFIG_CRYPTO_AEGIS128=y
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_CCM=y
# CONFIG_CRYPTO_GCM is not set
CONFIG_CRYPTO_SEQIV=y
# CONFIG_CRYPTO_ECHAINIV is not set
CONFIG_CRYPTO_ESSIV=y
# end of AEAD (authenticated encryption with associated data) ciphers

#
# Hashes, digests, and MACs
#
CONFIG_CRYPTO_BLAKE2B=y
# CONFIG_CRYPTO_CMAC is not set
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_MD4=y
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=y
CONFIG_CRYPTO_POLY1305=y
CONFIG_CRYPTO_RMD160=y
# CONFIG_CRYPTO_SHA1 is not set
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=y
CONFIG_CRYPTO_SM3=y
# CONFIG_CRYPTO_SM3_GENERIC is not set
CONFIG_CRYPTO_STREEBOG=y
CONFIG_CRYPTO_VMAC=y
# CONFIG_CRYPTO_WP512 is not set
CONFIG_CRYPTO_XCBC=y
CONFIG_CRYPTO_XXHASH=y
# end of Hashes, digests, and MACs

#
# CRCs (cyclic redundancy checks)
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32=y
CONFIG_CRYPTO_CRCT10DIF=y
# CONFIG_CRYPTO_CRC64_ROCKSOFT is not set
# end of CRCs (cyclic redundancy checks)

#
# Compression
#
# CONFIG_CRYPTO_DEFLATE is not set
CONFIG_CRYPTO_LZO=y
CONFIG_CRYPTO_842=y
CONFIG_CRYPTO_LZ4=y
CONFIG_CRYPTO_LZ4HC=y
CONFIG_CRYPTO_ZSTD=y
# end of Compression

#
# Random number generation
#
# CONFIG_CRYPTO_ANSI_CPRNG is not set
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_KDF800108_CTR=y
# end of Random number generation

#
# Userspace interface
#
# end of Userspace interface

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
# CONFIG_CRYPTO_DEV_QCE is not set
# CONFIG_CRYPTO_DEV_QCOM_RNG is not set
# CONFIG_CRYPTO_DEV_IMGTEC_HASH is not set
# CONFIG_CRYPTO_DEV_ZYNQMP_AES is not set
# CONFIG_CRYPTO_DEV_ZYNQMP_SHA3 is not set
CONFIG_CRYPTO_DEV_VIRTIO=y
# CONFIG_CRYPTO_DEV_SAFEXCEL is not set
# CONFIG_CRYPTO_DEV_HISI_SEC is not set
# CONFIG_CRYPTO_DEV_AMLOGIC_GXL is not set
# CONFIG_CRYPTO_DEV_SA2UL is not set
# CONFIG_CRYPTO_DEV_KEEMBAY_OCS_AES_SM4 is not set
# CONFIG_CRYPTO_DEV_ASPEED is not set
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
CONFIG_CORDIC=y
CONFIG_PRIME_NUMBERS=y
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_UTILS=y
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=y
CONFIG_CRYPTO_LIB_CHACHA=y
CONFIG_CRYPTO_LIB_CURVE25519_GENERIC=y
# CONFIG_CRYPTO_LIB_CURVE25519 is not set
CONFIG_CRYPTO_LIB_DES=y
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=1
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=y
CONFIG_CRYPTO_LIB_POLY1305=y
CONFIG_CRYPTO_LIB_CHACHA20POLY1305=y
CONFIG_CRYPTO_LIB_SHA1=y
CONFIG_CRYPTO_LIB_SHA256=y
# end of Crypto library routines

CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
# CONFIG_CRC64_ROCKSOFT is not set
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
CONFIG_CRC32_SELFTEST=y
# CONFIG_CRC32_SLICEBY8 is not set
CONFIG_CRC32_SLICEBY4=y
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
CONFIG_CRC64=y
# CONFIG_CRC4 is not set
CONFIG_CRC7=y
CONFIG_LIBCRC32C=y
CONFIG_CRC8=y
CONFIG_XXHASH=y
CONFIG_RANDOM32_SELFTEST=y
CONFIG_842_COMPRESS=y
CONFIG_842_DECOMPRESS=y
CONFIG_ZLIB_INFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_COMPRESS=y
CONFIG_LZ4HC_COMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMMON=y
CONFIG_ZSTD_COMPRESS=y
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
# CONFIG_XZ_DEC_POWERPC is not set
CONFIG_XZ_DEC_IA64=y
# CONFIG_XZ_DEC_ARM is not set
CONFIG_XZ_DEC_ARMTHUMB=y
# CONFIG_XZ_DEC_SPARC is not set
# CONFIG_XZ_DEC_MICROLZMA is not set
CONFIG_XZ_DEC_BCJ=y
CONFIG_XZ_DEC_TEST=y
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_DECOMPRESS_ZSTD=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=y
CONFIG_REED_SOLOMON_ENC16=y
CONFIG_REED_SOLOMON_DEC16=y
CONFIG_INTERVAL_TREE=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_DMA_DECLARE_COHERENT=y
CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE=y
CONFIG_DMA_GLOBAL_POOL=y
# CONFIG_DMA_API_DEBUG is not set
# CONFIG_DMA_MAP_BENCHMARK is not set
CONFIG_SGL_ALLOC=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_GENERIC_ATOMIC64=y
CONFIG_CLZ_TAB=y
# CONFIG_IRQ_POLL is not set
CONFIG_MPILIB=y
CONFIG_OID_REGISTRY=y
CONFIG_FONT_SUPPORT=y
CONFIG_FONT_8x16=y
CONFIG_FONT_AUTOSELECT=y
CONFIG_STACKDEPOT=y
# CONFIG_PARMAN is not set
# CONFIG_OBJAGG is not set
# end of Library routines

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
CONFIG_PRINTK_CALLER=y
CONFIG_STACKTRACE_BUILD_ID=y
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
# CONFIG_DYNAMIC_DEBUG is not set
CONFIG_DYNAMIC_DEBUG_CORE=y
# CONFIG_SYMBOLIC_ERRNAME is not set
# CONFIG_DEBUG_BUGVERBOSE is not set
# end of printk and dmesg options

CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_MISC=y

#
# Compile-time checks and compiler options
#
CONFIG_AS_HAS_NON_CONST_LEB128=y
CONFIG_DEBUG_INFO_NONE=y
# CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is not set
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_DEBUG_INFO_DWARF5 is not set
CONFIG_FRAME_WARN=1024
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_HEADERS_INSTALL is not set
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_VMLINUX_MAP=y
CONFIG_DEBUG_FORCE_WEAK_PER_CPU=y
# end of Compile-time checks and compiler options

#
# Generic Kernel Debugging Instruments
#
# CONFIG_MAGIC_SYSRQ is not set
CONFIG_DEBUG_FS=y
CONFIG_DEBUG_FS_ALLOW_ALL=y
# CONFIG_DEBUG_FS_DISALLOW_MOUNT is not set
# CONFIG_DEBUG_FS_ALLOW_NONE is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_UBSAN=y
CONFIG_CC_HAS_UBSAN_BOUNDS=y
CONFIG_CC_HAS_UBSAN_ARRAY_BOUNDS=y
CONFIG_UBSAN_BOUNDS=y
CONFIG_UBSAN_ARRAY_BOUNDS=y
CONFIG_UBSAN_SHIFT=y
CONFIG_UBSAN_UNREACHABLE=y
CONFIG_UBSAN_BOOL=y
CONFIG_UBSAN_ENUM=y
# end of Generic Kernel Debugging Instruments

#
# Networking Debugging
#
# end of Networking Debugging

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
CONFIG_DEBUG_PAGEALLOC=y
CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT=y
CONFIG_DEBUG_SLAB=y
# CONFIG_PAGE_OWNER is not set
CONFIG_PAGE_POISONING=y
CONFIG_DEBUG_PAGE_REF=y
CONFIG_DEBUG_OBJECTS=y
CONFIG_DEBUG_OBJECTS_SELFTEST=y
# CONFIG_DEBUG_OBJECTS_FREE is not set
CONFIG_DEBUG_OBJECTS_TIMERS=y
# CONFIG_DEBUG_OBJECTS_WORK is not set
# CONFIG_DEBUG_OBJECTS_RCU_HEAD is not set
CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER=y
CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=1
# CONFIG_SHRINKER_DEBUG is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_SCHED_STACK_END_CHECK is not set
# CONFIG_DEBUG_VM is not set
CONFIG_DEBUG_MEMORY_INIT=y
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
# end of Memory Debugging

CONFIG_DEBUG_SHIRQ=y

#
# Debug Oops, Lockups and Hangs
#
# CONFIG_PANIC_ON_OOPS is not set
CONFIG_PANIC_ON_OOPS_VALUE=0
CONFIG_PANIC_TIMEOUT=0
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=y
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
# CONFIG_DEBUG_LOCKDEP is not set
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
CONFIG_LOCK_TORTURE_TEST=y
CONFIG_WW_MUTEX_SELFTEST=y
CONFIG_SCF_TORTURE_TEST=y
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_DEBUG_IRQFLAGS=y
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
CONFIG_DEBUG_KOBJECT=y
# CONFIG_DEBUG_KOBJECT_RELEASE is not set

#
# Debug kernel data structures
#
CONFIG_DEBUG_LIST=y
# CONFIG_DEBUG_PLIST is not set
CONFIG_DEBUG_SG=y
CONFIG_DEBUG_NOTIFIERS=y
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
# CONFIG_DEBUG_MAPLE_TREE is not set
# end of Debug kernel data structures

CONFIG_DEBUG_CREDENTIALS=y

#
# RCU Debugging
#
CONFIG_TORTURE_TEST=y
CONFIG_RCU_SCALE_TEST=y
CONFIG_RCU_TORTURE_TEST=y
CONFIG_RCU_REF_SCALE_TEST=y
CONFIG_RCU_CPU_STALL_TIMEOUT=21
CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=0
CONFIG_RCU_TRACE=y
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

CONFIG_DEBUG_WQ_FORCE_RR_CPU=y
CONFIG_NOP_TRACER=y
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
# CONFIG_SCHED_TRACER is not set
CONFIG_HWLAT_TRACER=y
CONFIG_OSNOISE_TRACER=y
# CONFIG_TIMERLAT_TRACER is not set
# CONFIG_TRACER_SNAPSHOT is not set
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
# CONFIG_PROFILE_ALL_BRANCHES is not set
# CONFIG_SYNTH_EVENTS is not set
# CONFIG_USER_EVENTS is not set
# CONFIG_TRACE_EVENT_INJECT is not set
# CONFIG_TRACEPOINT_BENCHMARK is not set
# CONFIG_RING_BUFFER_BENCHMARK is not set
# CONFIG_TRACE_EVAL_MAP_FILE is not set
# CONFIG_GCOV_PROFILE_FTRACE is not set
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS=y
# CONFIG_RV is not set
# CONFIG_SAMPLES is not set
# CONFIG_STRICT_DEVMEM is not set

#
# hexagon Debugging
#
# end of hexagon Debugging

#
# Kernel Testing and Coverage
#
CONFIG_KUNIT=y
# CONFIG_KUNIT_DEBUGFS is not set
# CONFIG_KUNIT_TEST is not set
CONFIG_KUNIT_EXAMPLE_TEST=y
# CONFIG_KUNIT_ALL_TESTS is not set
CONFIG_KUNIT_DEFAULT_ENABLED=y
CONFIG_NOTIFIER_ERROR_INJECTION=y
CONFIG_FAULT_INJECTION=y
# CONFIG_FAILSLAB is not set
CONFIG_FAIL_PAGE_ALLOC=y
CONFIG_FAULT_INJECTION_USERCOPY=y
CONFIG_FAULT_INJECTION_DEBUG_FS=y
CONFIG_FAIL_MMC_REQUEST=y
CONFIG_FAULT_INJECTION_STACKTRACE_FILTER=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
CONFIG_RUNTIME_TESTING_MENU=y
CONFIG_LKDTM=y
# CONFIG_CPUMASK_KUNIT_TEST is not set
CONFIG_TEST_LIST_SORT=y
# CONFIG_TEST_MIN_HEAP is not set
# CONFIG_TEST_SORT is not set
# CONFIG_TEST_DIV64 is not set
CONFIG_BACKTRACE_SELF_TEST=y
# CONFIG_TEST_REF_TRACKER is not set
CONFIG_RBTREE_TEST=y
CONFIG_REED_SOLOMON_TEST=y
CONFIG_INTERVAL_TREE_TEST=y
CONFIG_ATOMIC64_SELFTEST=y
CONFIG_TEST_HEXDUMP=y
CONFIG_STRING_SELFTEST=y
CONFIG_TEST_STRING_HELPERS=y
CONFIG_TEST_STRSCPY=y
CONFIG_TEST_KSTRTOX=y
CONFIG_TEST_PRINTF=y
# CONFIG_TEST_SCANF is not set
CONFIG_TEST_BITMAP=y
CONFIG_TEST_UUID=y
CONFIG_TEST_XARRAY=y
# CONFIG_TEST_MAPLE_TREE is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_SIPHASH is not set
CONFIG_TEST_IDA=y
CONFIG_FIND_BIT_BENCHMARK=y
CONFIG_TEST_FIRMWARE=y
CONFIG_BITFIELD_KUNIT=y
# CONFIG_HASH_KUNIT_TEST is not set
CONFIG_RESOURCE_KUNIT_TEST=y
# CONFIG_SYSCTL_KUNIT_TEST is not set
CONFIG_LIST_KUNIT_TEST=y
# CONFIG_LINEAR_RANGES_TEST is not set
# CONFIG_CMDLINE_KUNIT_TEST is not set
# CONFIG_BITS_TEST is not set
# CONFIG_RATIONAL_KUNIT_TEST is not set
# CONFIG_MEMCPY_KUNIT_TEST is not set
# CONFIG_IS_SIGNED_TYPE_KUNIT_TEST is not set
# CONFIG_OVERFLOW_KUNIT_TEST is not set
# CONFIG_STACKINIT_KUNIT_TEST is not set
CONFIG_TEST_UDELAY=y
CONFIG_TEST_MEMCAT_P=y
CONFIG_TEST_MEMINIT=y
# CONFIG_TEST_FREE_PAGES is not set
# end of Kernel Testing and Coverage

#
# Rust hacking
#
# end of Rust hacking

# CONFIG_WARN_MISSING_DOCUMENTS is not set
# CONFIG_WARN_ABI_ERRORS is not set
# end of Kernel hacking

--olaM5A9KH40VOspV--
