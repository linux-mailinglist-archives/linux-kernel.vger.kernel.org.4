Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ADFB5F122E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 21:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbiI3TLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 15:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiI3TLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 15:11:02 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E061C10BB2F
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 12:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664565056; x=1696101056;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=gpwWBXCnPvM7f3jBTCLhWzLg8X+1kdFY9XAKpuh46nU=;
  b=OGWpqO2EGqQ6CVO35nusMSC0O6CgWKvr03IF6fGuxgpm3vvA+7vER7tO
   HGy9rgFNGLq9UqrGScE8pqyeU5kHUkm6PQTgo595NTQ22WYvx9Nd1s9F8
   GXZK8pS8RTlSRavzka7L1e/TS/0/j5M194WAoF5YcOGAQ+Z3OqFxkicte
   zjD+Wbb2r582pvCM5z2w2T+AB195dwzU0PPekcWE2IcKCrj0uIzng1Ppn
   rm68kkgY6ntcS2+1BizqutuVQeoMZQ9Pq2eF8jVXLjjZVCpV23iMVM6wy
   A7cb+hVUH1wyq8VDYEyuCfxPioPRwig+nWk27QPJSSxZ8kJGfbGzeqqNP
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10486"; a="282638238"
X-IronPort-AV: E=Sophos;i="5.93,358,1654585200"; 
   d="scan'208";a="282638238"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2022 12:10:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10486"; a="765235174"
X-IronPort-AV: E=Sophos;i="5.93,358,1654585200"; 
   d="scan'208";a="765235174"
Received: from lkp-server01.sh.intel.com (HELO 14cc182da2d0) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 30 Sep 2022 12:10:53 -0700
Received: from kbuild by 14cc182da2d0 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oeLPQ-0001Rf-2T;
        Fri, 30 Sep 2022 19:10:52 +0000
Date:   Sat, 1 Oct 2022 03:10:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [driver-core:kobject-const 15/18] drivers/s390/cio/device.c:133:52:
 error: passing 'const struct ccw_device_id *' to parameter of type 'struct
 ccw_device_id *' discards qualifiers
Message-ID: <202210010324.iMLSqeOw-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="oE+xwdMEZlehhEng"
Content-Disposition: inline
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,UPPERCASE_50_75 autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oE+xwdMEZlehhEng
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git kobject-const
head:   b3fd2c1b72aa7f7a66de071d625c3702f705edf7
commit: 50a40710ce9ffdc860cd60c3d797388781b6fd2e [15/18] driver core: make struct bus_type.uevent() take a const *
config: s390-randconfig-r015-20220926
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 791a7ae1ba3efd6bca96338e10ffde557ba83920)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git/commit/?id=50a40710ce9ffdc860cd60c3d797388781b6fd2e
        git remote add driver-core https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git
        git fetch --no-tags driver-core kobject-const
        git checkout 50a40710ce9ffdc860cd60c3d797388781b6fd2e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash drivers/s390/cio/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from drivers/s390/cio/device.c:27:
   In file included from include/linux/dma-mapping.h:10:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:37:59: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
                                                             ^
   include/uapi/linux/swab.h:102:54: note: expanded from macro '__swab16'
   #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
                                                        ^
   In file included from drivers/s390/cio/device.c:27:
   In file included from include/linux/dma-mapping.h:10:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:35:59: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
                                                             ^
   include/uapi/linux/swab.h:115:54: note: expanded from macro '__swab32'
   #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
                                                        ^
   In file included from drivers/s390/cio/device.c:27:
   In file included from include/linux/dma-mapping.h:10:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:692:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsb(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:700:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsw(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:708:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsl(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:717:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesb(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:726:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesw(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:735:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesl(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
>> drivers/s390/cio/device.c:133:52: error: passing 'const struct ccw_device_id *' to parameter of type 'struct ccw_device_id *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
           snprint_alias(modalias_buf, sizeof(modalias_buf), id, "");
                                                             ^~
   drivers/s390/cio/device.c:83:27: note: passing argument to parameter 'id' here
                            struct ccw_device_id *id, const char *suffix)
                                                  ^
   12 warnings and 1 error generated.


vim +133 drivers/s390/cio/device.c

db0c2d59087296 Peter Oberparleiter 2006-09-20  101  
db0c2d59087296 Peter Oberparleiter 2006-09-20  102  /* Set up environment variables for ccw device uevent. Return 0 on success,
db0c2d59087296 Peter Oberparleiter 2006-09-20  103   * non-zero otherwise. */
50a40710ce9ffd Greg Kroah-Hartman  2022-09-29  104  static int ccw_uevent(const struct device *dev, struct kobj_uevent_env *env)
^1da177e4c3f41 Linus Torvalds      2005-04-16  105  {
50a40710ce9ffd Greg Kroah-Hartman  2022-09-29  106  	const struct ccw_device *cdev = to_ccwdev(dev);
50a40710ce9ffd Greg Kroah-Hartman  2022-09-29  107  	const struct ccw_device_id *id = &(cdev->id);
cfbe9bb2fb5de1 Cornelia Huck       2007-04-27  108  	int ret;
cfbe9bb2fb5de1 Cornelia Huck       2007-04-27  109  	char modalias_buf[30];
^1da177e4c3f41 Linus Torvalds      2005-04-16  110  
db0c2d59087296 Peter Oberparleiter 2006-09-20  111  	/* CU_TYPE= */
7eff2e7a8b65c2 Kay Sievers         2007-08-14  112  	ret = add_uevent_var(env, "CU_TYPE=%04X", id->cu_type);
cfbe9bb2fb5de1 Cornelia Huck       2007-04-27  113  	if (ret)
cfbe9bb2fb5de1 Cornelia Huck       2007-04-27  114  		return ret;
db0c2d59087296 Peter Oberparleiter 2006-09-20  115  
db0c2d59087296 Peter Oberparleiter 2006-09-20  116  	/* CU_MODEL= */
7eff2e7a8b65c2 Kay Sievers         2007-08-14  117  	ret = add_uevent_var(env, "CU_MODEL=%02X", id->cu_model);
cfbe9bb2fb5de1 Cornelia Huck       2007-04-27  118  	if (ret)
cfbe9bb2fb5de1 Cornelia Huck       2007-04-27  119  		return ret;
^1da177e4c3f41 Linus Torvalds      2005-04-16  120  
^1da177e4c3f41 Linus Torvalds      2005-04-16  121  	/* The next two can be zero, that's ok for us */
db0c2d59087296 Peter Oberparleiter 2006-09-20  122  	/* DEV_TYPE= */
7eff2e7a8b65c2 Kay Sievers         2007-08-14  123  	ret = add_uevent_var(env, "DEV_TYPE=%04X", id->dev_type);
cfbe9bb2fb5de1 Cornelia Huck       2007-04-27  124  	if (ret)
cfbe9bb2fb5de1 Cornelia Huck       2007-04-27  125  		return ret;
^1da177e4c3f41 Linus Torvalds      2005-04-16  126  
db0c2d59087296 Peter Oberparleiter 2006-09-20  127  	/* DEV_MODEL= */
7eff2e7a8b65c2 Kay Sievers         2007-08-14  128  	ret = add_uevent_var(env, "DEV_MODEL=%02X", id->dev_model);
cfbe9bb2fb5de1 Cornelia Huck       2007-04-27  129  	if (ret)
cfbe9bb2fb5de1 Cornelia Huck       2007-04-27  130  		return ret;
db0c2d59087296 Peter Oberparleiter 2006-09-20  131  
db0c2d59087296 Peter Oberparleiter 2006-09-20  132  	/* MODALIAS=  */
cfbe9bb2fb5de1 Cornelia Huck       2007-04-27 @133  	snprint_alias(modalias_buf, sizeof(modalias_buf), id, "");
7eff2e7a8b65c2 Kay Sievers         2007-08-14  134  	ret = add_uevent_var(env, "MODALIAS=%s", modalias_buf);
cfbe9bb2fb5de1 Cornelia Huck       2007-04-27  135  	return ret;
^1da177e4c3f41 Linus Torvalds      2005-04-16  136  }
^1da177e4c3f41 Linus Torvalds      2005-04-16  137  

:::::: The code at line 133 was first introduced by commit
:::::: cfbe9bb2fb5de1da58d351432a9465c22d6d3ee5 [S390] cio: Use add_uevent_var.

:::::: TO: Cornelia Huck <cornelia.huck@de.ibm.com>
:::::: CC: Martin Schwidefsky <schwidefsky@de.ibm.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

--oE+xwdMEZlehhEng
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=config

#
# Automatically generated file; DO NOT EDIT.
# Linux/s390 6.0.0-rc6 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="clang version 16.0.0 (git://gitmirror/llvm_project 791a7ae1ba3efd6bca96338e10ffde557ba83920)"
CONFIG_GCC_VERSION=0
CONFIG_CC_IS_CLANG=y
CONFIG_CLANG_VERSION=160000
CONFIG_AS_IS_LLVM=y
CONFIG_AS_VERSION=160000
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
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_WERROR is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
CONFIG_HAVE_KERNEL_ZSTD=y
CONFIG_HAVE_KERNEL_UNCOMPRESSED=y
# CONFIG_KERNEL_GZIP is not set
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
CONFIG_KERNEL_XZ=y
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
# CONFIG_KERNEL_ZSTD is not set
# CONFIG_KERNEL_UNCOMPRESSED is not set
CONFIG_DEFAULT_INIT=""
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SYSVIPC=y
CONFIG_WATCH_QUEUE=y
# CONFIG_CROSS_MEMORY_ATTACH is not set
CONFIG_USELIB=y
CONFIG_HAVE_ARCH_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
CONFIG_SPARSE_IRQ=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
# end of IRQ subsystem

CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_CONTEXT_TRACKING=y
CONFIG_CONTEXT_TRACKING_IDLE=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
CONFIG_NO_HZ_IDLE=y
# CONFIG_NO_HZ is not set
# CONFIG_HIGH_RES_TIMERS is not set
# end of Timers subsystem

CONFIG_HAVE_EBPF_JIT=y
CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y

#
# BPF subsystem
#
# CONFIG_BPF_SYSCALL is not set
# end of BPF subsystem

CONFIG_PREEMPT_VOLUNTARY_BUILD=y
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_SCHED_CORE=y

#
# CPU/Task time and stats accounting
#
CONFIG_VIRT_CPU_ACCOUNTING=y
CONFIG_VIRT_CPU_ACCOUNTING_NATIVE=y
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_PSI=y
CONFIG_PSI_DEFAULT_DISABLED=y
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
# CONFIG_FORCE_TASKS_RUDE_RCU is not set
CONFIG_TASKS_RUDE_RCU=y
CONFIG_FORCE_TASKS_TRACE_RCU=y
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_FANOUT=64
CONFIG_RCU_FANOUT_LEAF=16
# CONFIG_RCU_NOCB_CPU is not set
# CONFIG_TASKS_TRACE_RCU_READ_MB is not set
# end of RCU Subsystem

CONFIG_IKCONFIG=y
CONFIG_IKHEADERS=y

#
# Scheduler features
#
# end of Scheduler features

CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_CC_HAS_INT128=y
CONFIG_CC_IMPLICIT_FALLTHROUGH="-Wimplicit-fallthrough"
CONFIG_GCC12_NO_ARRAY_BOUNDS=y
CONFIG_NUMA_BALANCING=y
# CONFIG_NUMA_BALANCING_DEFAULT_ENABLED is not set
# CONFIG_CGROUPS is not set
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
# CONFIG_TIME_NS is not set
CONFIG_IPC_NS=y
CONFIG_USER_NS=y
# CONFIG_PID_NS is not set
CONFIG_CHECKPOINT_RESTORE=y
# CONFIG_SCHED_AUTOGROUP is not set
# CONFIG_SYSFS_DEPRECATED is not set
# CONFIG_RELAY is not set
# CONFIG_BLK_DEV_INITRD is not set
CONFIG_BOOT_CONFIG=y
CONFIG_BOOT_CONFIG_EMBED=y
CONFIG_BOOT_CONFIG_EMBED_FILE=""
# CONFIG_INITRAMFS_PRESERVE_MTIME is not set
# CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE is not set
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_EXPERT=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
# CONFIG_SYSFS_SYSCALL is not set
# CONFIG_FHANDLE is not set
# CONFIG_POSIX_TIMERS is not set
# CONFIG_PRINTK is not set
CONFIG_BUG=y
CONFIG_ELF_CORE=y
# CONFIG_BASE_FULL is not set
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
# CONFIG_EPOLL is not set
# CONFIG_SIGNALFD is not set
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
# CONFIG_SHMEM is not set
CONFIG_AIO=y
CONFIG_IO_URING=y
# CONFIG_ADVISE_SYSCALLS is not set
# CONFIG_MEMBARRIER is not set
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_KCMP=y
# CONFIG_RSEQ is not set
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_PC104=y

#
# Kernel Performance Events And Counters
#
# CONFIG_PERF_EVENTS is not set
# end of Kernel Performance Events And Counters

# CONFIG_PROFILING is not set
CONFIG_TRACEPOINTS=y
# end of General setup

CONFIG_MMU=y
CONFIG_CPU_BIG_ENDIAN=y
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_PGSTE=y
CONFIG_AUDIT_ARCH=y
CONFIG_NO_IOPORT_MAP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_S390=y
CONFIG_SCHED_OMIT_FRAME_POINTER=y
CONFIG_PGTABLE_LEVELS=5
CONFIG_HAVE_LIVEPATCH=y

#
# Processor type and features
#
CONFIG_HAVE_MARCH_Z10_FEATURES=y
CONFIG_HAVE_MARCH_Z196_FEATURES=y
# CONFIG_MARCH_Z10 is not set
CONFIG_MARCH_Z196=y
# CONFIG_MARCH_ZEC12 is not set
# CONFIG_MARCH_Z13 is not set
# CONFIG_MARCH_Z14 is not set
# CONFIG_MARCH_Z15 is not set
# CONFIG_MARCH_Z16 is not set
CONFIG_MARCH_Z14_TUNE=y
# CONFIG_TUNE_DEFAULT is not set
# CONFIG_TUNE_Z10 is not set
# CONFIG_TUNE_Z196 is not set
# CONFIG_TUNE_ZEC12 is not set
# CONFIG_TUNE_Z13 is not set
CONFIG_TUNE_Z14=y
# CONFIG_TUNE_Z15 is not set
# CONFIG_TUNE_Z16 is not set
CONFIG_64BIT=y
CONFIG_COMMAND_LINE_SIZE=4096
CONFIG_SMP=y
CONFIG_NR_CPUS=64
CONFIG_HOTPLUG_CPU=y
CONFIG_NUMA=y
CONFIG_NODES_SHIFT=1
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
CONFIG_SCHED_BOOK=y
CONFIG_SCHED_DRAWER=y
CONFIG_SCHED_TOPOLOGY=y
CONFIG_HZ_100=y
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=100
CONFIG_KEXEC=y
CONFIG_KEXEC_FILE=y
CONFIG_ARCH_HAS_KEXEC_PURGATORY=y
# CONFIG_KERNEL_NOBP is not set
# CONFIG_RELOCATABLE is not set
# end of Processor type and features

#
# Memory setup
#
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
CONFIG_MAX_PHYSMEM_BITS=46
# CONFIG_CHECK_STACK is not set
# end of Memory setup

#
# I/O subsystem
#
CONFIG_QDIO=y
CONFIG_CHSC_SCH=y
# CONFIG_SCM_BUS is not set
# end of I/O subsystem

#
# Dump support
#
CONFIG_CRASH_DUMP=y
# end of Dump support

CONFIG_CCW=y

#
# Virtualization
#
# CONFIG_PROTECTED_VIRTUALIZATION_GUEST is not set
CONFIG_PFAULT=y
CONFIG_CMM=y
CONFIG_S390_HYPFS_FS=y
CONFIG_HAVE_KVM=y
CONFIG_HAVE_KVM_IRQCHIP=y
CONFIG_HAVE_KVM_IRQFD=y
CONFIG_HAVE_KVM_IRQ_ROUTING=y
CONFIG_HAVE_KVM_EVENTFD=y
CONFIG_KVM_ASYNC_PF=y
CONFIG_KVM_ASYNC_PF_SYNC=y
CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=y
CONFIG_KVM_VFIO=y
CONFIG_HAVE_KVM_INVALID_WAKEUPS=y
CONFIG_HAVE_KVM_VCPU_ASYNC_IOCTL=y
CONFIG_HAVE_KVM_NO_POLL=y
CONFIG_VIRTUALIZATION=y
CONFIG_KVM=y
CONFIG_KVM_S390_UCONTROL=y
# CONFIG_S390_GUEST is not set
# end of Virtualization

#
# Selftests
#
# end of Selftests

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_GENERIC_ENTRY=y
CONFIG_JUMP_LABEL=y
CONFIG_STATIC_KEYS_SELFTEST=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_ARCH_CORRECT_STACKTRACE_ON_KRETPROBE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_ARCH_WANTS_NO_INSTR=y
CONFIG_ARCH_32BIT_USTAT_F_TINODE=y
CONFIG_HAVE_ASM_MODVERSIONS=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
CONFIG_MMU_GATHER_TABLE_FREE=y
CONFIG_MMU_GATHER_RCU_TABLE_FREE=y
CONFIG_MMU_GATHER_MERGE_VMAS=y
CONFIG_MMU_GATHER_NO_GATHER=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_IPC_PARSE_VERSION=y
CONFIG_HAVE_ARCH_SECCOMP=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
# CONFIG_SECCOMP is not set
CONFIG_LTO_NONE=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_IDLE=y
CONFIG_ARCH_HAS_SCALED_CPUTIME=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK=y
CONFIG_SOFTIRQ_ON_OWN_STACK=y
CONFIG_ALTERNATE_USER_ADDRESS_SPACE=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_PAGE_SIZE_LESS_THAN_64KB=y
CONFIG_PAGE_SIZE_LESS_THAN_256KB=y
CONFIG_HAVE_RELIABLE_STACKTRACE=y
CONFIG_CLONE_BACKWARDS2=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_OLD_SIGACTION=y
# CONFIG_COMPAT_32BIT_TIME is not set
CONFIG_HAVE_ARCH_VMAP_STACK=y
# CONFIG_VMAP_STACK is not set
CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET=y
# CONFIG_RANDOMIZE_KSTACK_OFFSET is not set
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
# CONFIG_LOCK_EVENT_COUNTS is not set
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_ARCH_HAS_VDSO_DATA=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y

#
# GCOV-based kernel profiling
#
CONFIG_GCOV_KERNEL=y
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
CONFIG_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_HAVE_GCC_PLUGINS=y
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=1
# CONFIG_MODULES is not set
CONFIG_BLOCK=y
# CONFIG_BLOCK_LEGACY_AUTOLOAD is not set
CONFIG_BLK_ICQ=y
# CONFIG_BLK_DEV_BSGLIB is not set
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_INTEGRITY_T10=y
# CONFIG_BLK_DEV_ZONED is not set
# CONFIG_BLK_WBT is not set
# CONFIG_BLK_DEBUG_FS is not set
CONFIG_BLK_SED_OPAL=y
# CONFIG_BLK_INLINE_ENCRYPTION is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_EFI_PARTITION=y
# end of Partition Types

CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLOCK_HOLDER_DEPRECATED=y

#
# IO Schedulers
#
# CONFIG_MQ_IOSCHED_DEADLINE is not set
CONFIG_MQ_IOSCHED_KYBER=y
CONFIG_IOSCHED_BFQ=y
# end of IO Schedulers

CONFIG_PREEMPT_NOTIFIERS=y
CONFIG_PADATA=y
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
CONFIG_ARCH_INLINE_READ_TRYLOCK=y
CONFIG_ARCH_INLINE_READ_LOCK=y
CONFIG_ARCH_INLINE_READ_LOCK_BH=y
CONFIG_ARCH_INLINE_READ_LOCK_IRQ=y
CONFIG_ARCH_INLINE_READ_LOCK_IRQSAVE=y
CONFIG_ARCH_INLINE_READ_UNLOCK=y
CONFIG_ARCH_INLINE_READ_UNLOCK_BH=y
CONFIG_ARCH_INLINE_READ_UNLOCK_IRQ=y
CONFIG_ARCH_INLINE_READ_UNLOCK_IRQRESTORE=y
CONFIG_ARCH_INLINE_WRITE_TRYLOCK=y
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
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y

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
CONFIG_ZPOOL=y
CONFIG_SWAP=y
CONFIG_ZSWAP=y
CONFIG_ZSWAP_DEFAULT_ON=y
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_DEFLATE is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZO is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_842 is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4=y
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4HC is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_ZSTD is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT="lz4"
# CONFIG_ZSWAP_ZPOOL_DEFAULT_ZBUD is not set
# CONFIG_ZSWAP_ZPOOL_DEFAULT_Z3FOLD is not set
CONFIG_ZSWAP_ZPOOL_DEFAULT_ZSMALLOC=y
CONFIG_ZSWAP_ZPOOL_DEFAULT="zsmalloc"
CONFIG_ZBUD=y
# CONFIG_Z3FOLD is not set
CONFIG_ZSMALLOC=y
CONFIG_ZSMALLOC_STAT=y

#
# SLAB allocator options
#
# CONFIG_SLAB is not set
# CONFIG_SLUB is not set
CONFIG_SLOB=y
# end of SLAB allocator options

CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
# CONFIG_COMPAT_BRK is not set
CONFIG_SPARSEMEM=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_MEMBLOCK_PHYS_MAP=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_NUMA_KEEP_MEMINFO=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_EXCLUSIVE_SYSTEM_RAM=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_MEMORY_HOTPLUG=y
# CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
# CONFIG_MEMORY_HOTREMOVE is not set
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_COMPACTION=y
# CONFIG_PAGE_REPORTING is not set
CONFIG_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_MMU_NOTIFIER=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
# CONFIG_TRANSPARENT_HUGEPAGE is not set
CONFIG_FRONTSWAP=y
# CONFIG_CMA is not set
CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
CONFIG_PAGE_IDLE_FLAG=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_CURRENT_STACK_POINTER=y
CONFIG_ZONE_DMA=y
# CONFIG_VM_EVENT_COUNTERS is not set
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_TEST is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
# CONFIG_USERFAULTFD is not set

#
# Data Access Monitoring
#
CONFIG_DAMON=y
# CONFIG_DAMON_VADDR is not set
CONFIG_DAMON_PADDR=y
CONFIG_DAMON_SYSFS=y
CONFIG_DAMON_RECLAIM=y
CONFIG_DAMON_LRU_SORT=y
# end of Data Access Monitoring
# end of Memory Management options

# CONFIG_NET is not set

#
# Device Drivers
#
CONFIG_HAVE_PCI=y
# CONFIG_PCI is not set
CONFIG_PCCARD=y
# CONFIG_PCMCIA is not set

#
# PC-card bridges
#

#
# Generic Driver Options
#
CONFIG_UEVENT_HELPER=y
CONFIG_UEVENT_HELPER_PATH=""
# CONFIG_DEVTMPFS is not set
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
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
# CONFIG_FW_LOADER_COMPRESS is not set
CONFIG_FW_UPLOAD=y
# end of Firmware loader

# CONFIG_ALLOW_DEV_COREDUMP is not set
CONFIG_DEBUG_DRIVER=y
CONFIG_DEBUG_DEVRES=y
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
CONFIG_SYS_HYPERVISOR=y
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_I3C=y
CONFIG_DMA_SHARED_BUFFER=y
CONFIG_DMA_FENCE_TRACE=y
# end of Generic Driver Options

#
# Bus devices
#
CONFIG_MHI_BUS=y
# CONFIG_MHI_BUS_DEBUG is not set
# CONFIG_MHI_BUS_EP is not set
# end of Bus devices

#
# Firmware Drivers
#

#
# ARM System Control and Management Interface Protocol
#
# end of ARM System Control and Management Interface Protocol

CONFIG_FIRMWARE_MEMMAP=y
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
CONFIG_MTD_AR7_PARTS=y
# CONFIG_MTD_CMDLINE_PARTS is not set
# CONFIG_MTD_OF_PARTS is not set
CONFIG_MTD_REDBOOT_PARTS=y
CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=-1
# CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED is not set
# CONFIG_MTD_REDBOOT_PARTS_READONLY is not set
# end of Partition parsers

#
# User Modules And Translation Layers
#
CONFIG_MTD_BLKDEVS=y
CONFIG_MTD_BLOCK=y

#
# Note that in some cases UBI block is preferred. See MTD_UBI_BLOCK.
#
CONFIG_FTL=y
CONFIG_NFTL=y
# CONFIG_NFTL_RW is not set
# CONFIG_INFTL is not set
CONFIG_RFD_FTL=y
# CONFIG_SSFDC is not set
CONFIG_SM_FTL=y
CONFIG_MTD_OOPS=y
CONFIG_MTD_SWAP=y
CONFIG_MTD_PARTITIONED_MASTER=y

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
# CONFIG_MTD_CFI_AMDSTD is not set
CONFIG_MTD_CFI_STAA=y
CONFIG_MTD_CFI_UTIL=y
CONFIG_MTD_RAM=y
# CONFIG_MTD_ROM is not set
CONFIG_MTD_ABSENT=y
# end of RAM/ROM/Flash chip drivers

#
# NAND
#
CONFIG_MTD_NAND_CORE=y
CONFIG_MTD_RAW_NAND=y

#
# Raw/parallel NAND flash controllers
#

#
# Misc
#
# CONFIG_MTD_NAND_NANDSIM is not set

#
# ECC engine support
#
CONFIG_MTD_NAND_ECC=y
CONFIG_MTD_NAND_ECC_SW_HAMMING=y
# CONFIG_MTD_NAND_ECC_SW_HAMMING_SMC is not set
# CONFIG_MTD_NAND_ECC_SW_BCH is not set
# end of ECC engine support
# end of NAND

#
# LPDDR & LPDDR2 PCM memory drivers
#
CONFIG_MTD_LPDDR=y
CONFIG_MTD_QINFO_PROBE=y
# end of LPDDR & LPDDR2 PCM memory drivers

# CONFIG_MTD_UBI is not set
CONFIG_DTC=y
CONFIG_OF=y
CONFIG_OF_UNITTEST=y
CONFIG_OF_FLATTREE=y
CONFIG_OF_EARLY_FLATTREE=y
CONFIG_OF_KOBJ=y
CONFIG_OF_DYNAMIC=y
CONFIG_OF_IRQ=y
CONFIG_OF_RESERVED_MEM=y
CONFIG_OF_RESOLVE=y
# CONFIG_OF_OVERLAY is not set
# CONFIG_BLK_DEV is not set

#
# NVME Support
#
CONFIG_NVME_COMMON=y
CONFIG_NVME_CORE=y
CONFIG_NVME_MULTIPATH=y
CONFIG_NVME_VERBOSE_ERRORS=y
CONFIG_NVME_FABRICS=y
CONFIG_NVME_FC=y
# CONFIG_NVME_AUTH is not set
CONFIG_NVME_TARGET=y
CONFIG_NVME_TARGET_PASSTHRU=y
CONFIG_NVME_TARGET_LOOP=y
# CONFIG_NVME_TARGET_FC is not set
CONFIG_NVME_TARGET_AUTH=y
# end of NVME Support

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=y
CONFIG_AD525X_DPOT=y
# CONFIG_AD525X_DPOT_I2C is not set
CONFIG_DUMMY_IRQ=y
CONFIG_ICS932S401=y
CONFIG_ENCLOSURE_SERVICES=y
CONFIG_APDS9802ALS=y
# CONFIG_ISL29003 is not set
# CONFIG_ISL29020 is not set
CONFIG_SENSORS_TSL2550=y
CONFIG_SENSORS_BH1770=y
CONFIG_SENSORS_APDS990X=y
CONFIG_HMC6352=y
CONFIG_DS1682=y
CONFIG_OPEN_DICE=y
# CONFIG_C2PORT is not set

#
# EEPROM support
#
CONFIG_EEPROM_AT24=y
# CONFIG_EEPROM_LEGACY is not set
CONFIG_EEPROM_MAX6875=y
# CONFIG_EEPROM_93CX6 is not set
# CONFIG_EEPROM_IDT_89HPESX is not set
CONFIG_EEPROM_EE1004=y
# end of EEPROM support

#
# Texas Instruments shared transport line discipline
#
# end of Texas Instruments shared transport line discipline

CONFIG_SENSORS_LIS3_I2C=y
CONFIG_ALTERA_STAPL=y
CONFIG_ECHO=y
# CONFIG_UACCE is not set
CONFIG_PVPANIC=y
# end of Misc devices

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=y
CONFIG_SCSI_COMMON=y
# CONFIG_SCSI is not set
# end of SCSI device support

CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
# CONFIG_MD_AUTODETECT is not set
CONFIG_MD_LINEAR=y
CONFIG_MD_RAID0=y
CONFIG_MD_RAID1=y
CONFIG_MD_RAID10=y
CONFIG_MD_RAID456=y
# CONFIG_MD_MULTIPATH is not set
CONFIG_MD_FAULTY=y
CONFIG_BCACHE=y
# CONFIG_BCACHE_DEBUG is not set
# CONFIG_BCACHE_CLOSURES_DEBUG is not set
# CONFIG_BCACHE_ASYNC_REGISTRATION is not set
# CONFIG_BLK_DEV_DM is not set
CONFIG_TARGET_CORE=y
CONFIG_TCM_IBLOCK=y
# CONFIG_TCM_FILEIO is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=y
# CONFIG_INPUT_SPARSEKMAP is not set
CONFIG_INPUT_MATRIXKMAP=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=y
CONFIG_INPUT_EVDEV=y
CONFIG_INPUT_EVBUG=y

#
# Input Device Drivers
#
# CONFIG_INPUT_KEYBOARD is not set
# CONFIG_INPUT_MOUSE is not set
# CONFIG_INPUT_JOYSTICK is not set
CONFIG_INPUT_TABLET=y
CONFIG_TABLET_SERIAL_WACOM4=y
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set
CONFIG_RMI4_CORE=y
CONFIG_RMI4_I2C=y
CONFIG_RMI4_SMB=y
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=y
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
# CONFIG_RMI4_F34 is not set
# CONFIG_RMI4_F3A is not set
CONFIG_RMI4_F55=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
# CONFIG_SERIO_SERPORT is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=y
CONFIG_SERIO_PS2MULT=y
CONFIG_SERIO_GPIO_PS2=y
CONFIG_USERIO=y
# CONFIG_GAMEPORT is not set
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
CONFIG_VT=y
# CONFIG_CONSOLE_TRANSLATIONS is not set
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_VT_HW_CONSOLE_BINDING=y
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
CONFIG_LDISC_AUTOLOAD=y
CONFIG_NULL_TTY=y
CONFIG_HVC_DRIVER=y
# CONFIG_SERIAL_DEV_BUS is not set
CONFIG_TTY_PRINTK=y
CONFIG_TTY_PRINTK_LEVEL=6
CONFIG_VIRTIO_CONSOLE=y
# CONFIG_IPMB_DEVICE_INTERFACE is not set
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_VIRTIO=y
CONFIG_HW_RANDOM_S390=y
CONFIG_DEVMEM=y
CONFIG_HANGCHECK_TIMER=y

#
# S/390 character device drivers
#
# CONFIG_TN3270 is not set
# CONFIG_TN3215 is not set
# CONFIG_SCLP_TTY is not set
# CONFIG_SCLP_VT220_TTY is not set
# CONFIG_HMC_DRV is not set
CONFIG_SCLP_OFB=y
# CONFIG_S390_UV_UAPI is not set
CONFIG_S390_TAPE=y

#
# S/390 tape hardware support
#
CONFIG_S390_TAPE_34XX=y
CONFIG_S390_TAPE_3590=y
# CONFIG_VMCP is not set
# CONFIG_MONWRITER is not set
# CONFIG_S390_VMUR is not set
# CONFIG_XILLYBUS is not set
# CONFIG_RANDOM_TRUST_CPU is not set
CONFIG_RANDOM_TRUST_BOOTLOADER=y
# end of Character devices

#
# I2C support
#
CONFIG_I2C=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=y
CONFIG_I2C_MUX=y

#
# Multiplexer I2C Chip support
#
CONFIG_I2C_ARB_GPIO_CHALLENGE=y
# CONFIG_I2C_MUX_GPIO is not set
# CONFIG_I2C_MUX_GPMUX is not set
CONFIG_I2C_MUX_LTC4306=y
CONFIG_I2C_MUX_PCA9541=y
# CONFIG_I2C_MUX_PCA954x is not set
CONFIG_I2C_MUX_PINCTRL=y
CONFIG_I2C_DEMUX_PINCTRL=y
# CONFIG_I2C_MUX_MLXCPLD is not set
# end of Multiplexer I2C Chip support

CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=y
CONFIG_I2C_SLAVE=y
CONFIG_I2C_SLAVE_EEPROM=y
# CONFIG_I2C_SLAVE_TESTUNIT is not set
CONFIG_I2C_DEBUG_CORE=y
CONFIG_I2C_DEBUG_ALGO=y
# end of I2C support

CONFIG_I3C=y
# CONFIG_SPMI is not set
# CONFIG_HSI is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
CONFIG_PPS_CLIENT_KTIMER=y
CONFIG_PPS_CLIENT_LDISC=y
# CONFIG_PPS_CLIENT_GPIO is not set

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
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
CONFIG_PINCTRL_MCP23S08_I2C=y
CONFIG_PINCTRL_MCP23S08=y
# CONFIG_PINCTRL_SX150X is not set

#
# Renesas pinctrl drivers
#
# end of Renesas pinctrl drivers

CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
# CONFIG_GPIO_SYSFS is not set
# CONFIG_GPIO_CDEV is not set
CONFIG_GPIO_MAX730X=y

#
# I2C GPIO expanders
#
CONFIG_GPIO_ADP5588=y
# CONFIG_GPIO_ADP5588_IRQ is not set
CONFIG_GPIO_MAX7300=y
CONFIG_GPIO_MAX732X=y
# CONFIG_GPIO_MAX732X_IRQ is not set
CONFIG_GPIO_PCA953X=y
CONFIG_GPIO_PCA953X_IRQ=y
CONFIG_GPIO_PCA9570=y
CONFIG_GPIO_PCF857X=y
CONFIG_GPIO_TPIC2810=y
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
# end of MFD GPIO expanders

#
# Virtual GPIO drivers
#
# CONFIG_GPIO_AGGREGATOR is not set
CONFIG_GPIO_MOCKUP=y
CONFIG_GPIO_VIRTIO=y
CONFIG_GPIO_SIM=y
# end of Virtual GPIO drivers

CONFIG_POWER_RESET=y
# CONFIG_POWER_RESET_RESTART is not set
# CONFIG_NVMEM_REBOOT_MODE is not set
CONFIG_POWER_SUPPLY=y
CONFIG_POWER_SUPPLY_DEBUG=y
# CONFIG_GENERIC_ADC_BATTERY is not set
CONFIG_IP5XXX_POWER=y
CONFIG_TEST_POWER=y
# CONFIG_CHARGER_ADP5061 is not set
# CONFIG_BATTERY_CW2015 is not set
# CONFIG_BATTERY_DS2782 is not set
CONFIG_BATTERY_SAMSUNG_SDI=y
CONFIG_BATTERY_SBS=y
CONFIG_CHARGER_SBS=y
CONFIG_MANAGER_SBS=y
CONFIG_BATTERY_BQ27XXX=y
# CONFIG_BATTERY_BQ27XXX_I2C is not set
CONFIG_BATTERY_MAX17040=y
# CONFIG_BATTERY_MAX17042 is not set
# CONFIG_CHARGER_MAX8903 is not set
CONFIG_CHARGER_LP8727=y
# CONFIG_CHARGER_GPIO is not set
CONFIG_CHARGER_LT3651=y
CONFIG_CHARGER_LTC4162L=y
# CONFIG_CHARGER_DETECTOR_MAX14656 is not set
CONFIG_CHARGER_MAX77976=y
CONFIG_CHARGER_BQ2415X=y
CONFIG_CHARGER_BQ24257=y
# CONFIG_CHARGER_BQ24735 is not set
CONFIG_CHARGER_BQ2515X=y
CONFIG_CHARGER_BQ25890=y
CONFIG_CHARGER_BQ25980=y
CONFIG_CHARGER_BQ256XX=y
CONFIG_BATTERY_GAUGE_LTC2941=y
CONFIG_BATTERY_RT5033=y
CONFIG_CHARGER_RT9455=y
CONFIG_CHARGER_BD99954=y
CONFIG_BATTERY_UG3105=y
# CONFIG_THERMAL is not set
# CONFIG_WATCHDOG is not set
# CONFIG_REGULATOR is not set
CONFIG_RC_CORE=y
CONFIG_LIRC=y
CONFIG_RC_MAP=y
# CONFIG_RC_DECODERS is not set
CONFIG_RC_DEVICES=y
CONFIG_IR_GPIO_CIR=y
CONFIG_IR_GPIO_TX=y
# CONFIG_IR_PWM_TX is not set
CONFIG_IR_SERIAL=y
# CONFIG_IR_SERIAL_TRANSMITTER is not set
CONFIG_RC_LOOPBACK=y

#
# CEC support
#
# CONFIG_MEDIA_CEC_SUPPORT is not set
# end of CEC support

#
# Graphics support
#

#
# Console display driver support
#
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
# end of Console display driver support
# end of Graphics support

#
# HID support
#
CONFIG_HID=y
# CONFIG_HID_BATTERY_STRENGTH is not set
CONFIG_HIDRAW=y
CONFIG_UHID=y
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
# CONFIG_HID_A4TECH is not set
CONFIG_HID_ACRUX=y
CONFIG_HID_ACRUX_FF=y
CONFIG_HID_APPLE=y
CONFIG_HID_AUREAL=y
CONFIG_HID_BELKIN=y
CONFIG_HID_CHERRY=y
CONFIG_HID_COUGAR=y
CONFIG_HID_MACALLY=y
# CONFIG_HID_CMEDIA is not set
CONFIG_HID_CYPRESS=y
CONFIG_HID_DRAGONRISE=y
CONFIG_DRAGONRISE_FF=y
# CONFIG_HID_EMS_FF is not set
CONFIG_HID_ELECOM=y
# CONFIG_HID_EZKEY is not set
CONFIG_HID_GEMBIRD=y
CONFIG_HID_GFRM=y
CONFIG_HID_GLORIOUS=y
# CONFIG_HID_VIVALDI is not set
# CONFIG_HID_KEYTOUCH is not set
CONFIG_HID_KYE=y
# CONFIG_HID_WALTOP is not set
CONFIG_HID_VIEWSONIC=y
CONFIG_HID_XIAOMI=y
CONFIG_HID_GYRATION=y
CONFIG_HID_ICADE=y
CONFIG_HID_ITE=y
# CONFIG_HID_JABRA is not set
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
CONFIG_HID_MULTITOUCH=y
CONFIG_HID_NINTENDO=y
CONFIG_NINTENDO_FF=y
CONFIG_HID_NTI=y
# CONFIG_HID_ORTEK is not set
CONFIG_HID_PANTHERLORD=y
# CONFIG_PANTHERLORD_FF is not set
# CONFIG_HID_PETALYNX is not set
CONFIG_HID_PICOLCD=y
CONFIG_HID_PICOLCD_LEDS=y
CONFIG_HID_PICOLCD_CIR=y
# CONFIG_HID_PLANTRONICS is not set
CONFIG_HID_PLAYSTATION=y
CONFIG_PLAYSTATION_FF=y
CONFIG_HID_RAZER=y
CONFIG_HID_PRIMAX=y
# CONFIG_HID_SAITEK is not set
CONFIG_HID_SEMITEK=y
CONFIG_HID_SPEEDLINK=y
# CONFIG_HID_STEAM is not set
CONFIG_HID_STEELSERIES=y
CONFIG_HID_SUNPLUS=y
CONFIG_HID_RMI=y
CONFIG_HID_GREENASIA=y
# CONFIG_GREENASIA_FF is not set
CONFIG_HID_SMARTJOYPLUS=y
CONFIG_SMARTJOYPLUS_FF=y
CONFIG_HID_TIVO=y
CONFIG_HID_TOPSEED=y
CONFIG_HID_THINGM=y
CONFIG_HID_UDRAW_PS3=y
CONFIG_HID_WIIMOTE=y
CONFIG_HID_XINMO=y
CONFIG_HID_ZEROPLUS=y
CONFIG_ZEROPLUS_FF=y
# CONFIG_HID_ZYDACRON is not set
# CONFIG_HID_ALPS is not set
# end of Special HID drivers

#
# I2C HID support
#
CONFIG_I2C_HID_OF=y
CONFIG_I2C_HID_OF_ELAN=y
# CONFIG_I2C_HID_OF_GOODIX is not set
# end of I2C HID support

CONFIG_I2C_HID_CORE=y
# end of HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_MEMSTICK=y
# CONFIG_MEMSTICK_DEBUG is not set

#
# MemoryStick drivers
#
CONFIG_MEMSTICK_UNSAFE_RESUME=y
CONFIG_MSPRO_BLOCK=y
# CONFIG_MS_BLOCK is not set

#
# MemoryStick Host Controller Drivers
#
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_CLASS_FLASH=y
CONFIG_LEDS_CLASS_MULTICOLOR=y
CONFIG_LEDS_BRIGHTNESS_HW_CHANGED=y

#
# LED drivers
#
CONFIG_LEDS_AN30259A=y
CONFIG_LEDS_AW2013=y
CONFIG_LEDS_LM3530=y
CONFIG_LEDS_LM3532=y
CONFIG_LEDS_LM3642=y
# CONFIG_LEDS_LM3692X is not set
CONFIG_LEDS_PCA9532=y
CONFIG_LEDS_PCA9532_GPIO=y
CONFIG_LEDS_GPIO=y
CONFIG_LEDS_LP3944=y
CONFIG_LEDS_LP3952=y
# CONFIG_LEDS_LP50XX is not set
CONFIG_LEDS_LP55XX_COMMON=y
CONFIG_LEDS_LP5521=y
CONFIG_LEDS_LP5523=y
CONFIG_LEDS_LP5562=y
CONFIG_LEDS_LP8501=y
# CONFIG_LEDS_LP8860 is not set
CONFIG_LEDS_PCA955X=y
CONFIG_LEDS_PCA955X_GPIO=y
CONFIG_LEDS_PCA963X=y
# CONFIG_LEDS_PWM is not set
CONFIG_LEDS_BD2802=y
CONFIG_LEDS_LT3593=y
CONFIG_LEDS_TCA6507=y
CONFIG_LEDS_TLC591XX=y
# CONFIG_LEDS_LM355x is not set
CONFIG_LEDS_IS31FL319X=y
# CONFIG_LEDS_IS31FL32XX is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
# CONFIG_LEDS_BLINKM is not set
CONFIG_LEDS_MLXREG=y
CONFIG_LEDS_USER=y
# CONFIG_LEDS_TI_LMU_COMMON is not set

#
# Flash and Torch LED drivers
#
CONFIG_LEDS_AAT1290=y
# CONFIG_LEDS_AS3645A is not set
# CONFIG_LEDS_KTD2692 is not set
CONFIG_LEDS_LM3601X=y
CONFIG_LEDS_RT4505=y
# CONFIG_LEDS_RT8515 is not set
CONFIG_LEDS_SGM3140=y

#
# RGB LED drivers
#
CONFIG_LEDS_PWM_MULTICOLOR=y

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
# CONFIG_LEDS_TRIGGER_TIMER is not set
CONFIG_LEDS_TRIGGER_ONESHOT=y
# CONFIG_LEDS_TRIGGER_MTD is not set
CONFIG_LEDS_TRIGGER_HEARTBEAT=y
# CONFIG_LEDS_TRIGGER_BACKLIGHT is not set
CONFIG_LEDS_TRIGGER_CPU=y
CONFIG_LEDS_TRIGGER_ACTIVITY=y
CONFIG_LEDS_TRIGGER_GPIO=y
# CONFIG_LEDS_TRIGGER_DEFAULT_ON is not set

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=y
CONFIG_LEDS_TRIGGER_CAMERA=y
CONFIG_LEDS_TRIGGER_PANIC=y
CONFIG_LEDS_TRIGGER_PATTERN=y
CONFIG_LEDS_TRIGGER_AUDIO=y
CONFIG_LEDS_TRIGGER_TTY=y

#
# Simple LED drivers
#
# CONFIG_ACCESSIBILITY is not set
# CONFIG_DMADEVICES is not set

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
CONFIG_SW_SYNC=y
CONFIG_DMABUF_MOVE_NOTIFY=y
# CONFIG_DMABUF_DEBUG is not set
# CONFIG_DMABUF_SELFTESTS is not set
CONFIG_DMABUF_HEAPS=y
# CONFIG_DMABUF_SYSFS_STATS is not set
# CONFIG_DMABUF_HEAPS_SYSTEM is not set
# end of DMABUF options

# CONFIG_AUXDISPLAY is not set
CONFIG_UIO=y
# CONFIG_UIO_PDRV_GENIRQ is not set
CONFIG_UIO_DMEM_GENIRQ=y
CONFIG_VFIO=y
CONFIG_VFIO_IOMMU_TYPE1=y
CONFIG_VFIO_NOIOMMU=y
# CONFIG_VFIO_MDEV is not set
CONFIG_VIRT_DRIVERS=y
CONFIG_VIRTIO_ANCHOR=y
CONFIG_VIRTIO=y
# CONFIG_VIRTIO_MENU is not set
CONFIG_VHOST_IOTLB=y
CONFIG_VHOST=y
CONFIG_VHOST_MENU=y
CONFIG_VHOST_SCSI=y
CONFIG_VHOST_CROSS_ENDIAN_LEGACY=y

#
# Microsoft Hyper-V guest support
#
# end of Microsoft Hyper-V guest support

# CONFIG_GREYBUS is not set
CONFIG_COMEDI=y
CONFIG_COMEDI_DEBUG=y
CONFIG_COMEDI_DEFAULT_BUF_SIZE_KB=2048
CONFIG_COMEDI_DEFAULT_BUF_MAXSIZE_KB=20480
CONFIG_COMEDI_MISC_DRIVERS=y
CONFIG_COMEDI_BOND=y
# CONFIG_COMEDI_TEST is not set
CONFIG_COMEDI_PARPORT=y
CONFIG_COMEDI_ISA_DRIVERS=y
CONFIG_COMEDI_PCL711=y
CONFIG_COMEDI_PCL724=y
CONFIG_COMEDI_PCL726=y
# CONFIG_COMEDI_PCL730 is not set
CONFIG_COMEDI_PCL812=y
# CONFIG_COMEDI_PCL816 is not set
CONFIG_COMEDI_PCL818=y
# CONFIG_COMEDI_PCM3724 is not set
CONFIG_COMEDI_AMPLC_DIO200_ISA=y
CONFIG_COMEDI_AMPLC_PC236_ISA=y
# CONFIG_COMEDI_AMPLC_PC263_ISA is not set
CONFIG_COMEDI_RTI800=y
CONFIG_COMEDI_RTI802=y
# CONFIG_COMEDI_DAC02 is not set
CONFIG_COMEDI_DAS16M1=y
CONFIG_COMEDI_DAS08_ISA=y
CONFIG_COMEDI_DAS16=y
CONFIG_COMEDI_DAS800=y
CONFIG_COMEDI_DAS1800=y
CONFIG_COMEDI_DAS6402=y
CONFIG_COMEDI_DT2801=y
CONFIG_COMEDI_DT2811=y
CONFIG_COMEDI_DT2814=y
# CONFIG_COMEDI_DT2815 is not set
CONFIG_COMEDI_DT2817=y
CONFIG_COMEDI_DT282X=y
# CONFIG_COMEDI_DMM32AT is not set
CONFIG_COMEDI_FL512=y
CONFIG_COMEDI_AIO_AIO12_8=y
CONFIG_COMEDI_AIO_IIRO_16=y
# CONFIG_COMEDI_C6XDIGIO is not set
CONFIG_COMEDI_MPC624=y
CONFIG_COMEDI_ADQ12B=y
CONFIG_COMEDI_NI_AT_A2150=y
CONFIG_COMEDI_NI_AT_AO=y
# CONFIG_COMEDI_NI_ATMIO is not set
CONFIG_COMEDI_NI_ATMIO16D=y
CONFIG_COMEDI_NI_LABPC_ISA=y
CONFIG_COMEDI_PCMAD=y
CONFIG_COMEDI_PCMDA12=y
CONFIG_COMEDI_PCMMIO=y
CONFIG_COMEDI_PCMUIO=y
CONFIG_COMEDI_MULTIQ3=y
# CONFIG_COMEDI_S526 is not set
CONFIG_COMEDI_8254=y
CONFIG_COMEDI_8255=y
CONFIG_COMEDI_8255_SA=y
CONFIG_COMEDI_KCOMEDILIB=y
CONFIG_COMEDI_AMPLC_DIO200=y
CONFIG_COMEDI_AMPLC_PC236=y
CONFIG_COMEDI_DAS08=y
CONFIG_COMEDI_NI_LABPC=y
CONFIG_COMEDI_NI_ROUTING=y
CONFIG_COMEDI_TESTS=y
CONFIG_COMEDI_TESTS_EXAMPLE=y
CONFIG_COMEDI_TESTS_NI_ROUTES=y
CONFIG_STAGING=y

#
# IIO staging drivers
#

#
# Accelerometers
#
# end of Accelerometers

#
# Analog to digital converters
#
# end of Analog to digital converters

#
# Analog digital bi-direction converters
#
CONFIG_ADT7316=y
CONFIG_ADT7316_I2C=y
# end of Analog digital bi-direction converters

#
# Capacitance to digital converters
#
CONFIG_AD7746=y
# end of Capacitance to digital converters

#
# Direct Digital Synthesis
#
# end of Direct Digital Synthesis

#
# Network Analyzer, Impedance Converters
#
CONFIG_AD5933=y
# end of Network Analyzer, Impedance Converters

#
# Active energy metering IC
#
# CONFIG_ADE7854 is not set
# end of Active energy metering IC

#
# Resolver to digital converters
#
# end of Resolver to digital converters
# end of IIO staging drivers

# CONFIG_STAGING_MEDIA is not set
CONFIG_MOST_COMPONENTS=y
CONFIG_MOST_I2C=y
# CONFIG_FIELDBUS_DEV is not set
# CONFIG_COMMON_CLK is not set
# CONFIG_HWSPINLOCK is not set

#
# Clock Source drivers
#
CONFIG_TIMER_OF=y
CONFIG_TIMER_PROBE=y
CONFIG_MICROCHIP_PIT64B=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
CONFIG_IOMMU_API=y
# CONFIG_IOMMU_SUPPORT is not set

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
# CONFIG_RPMSG_VIRTIO is not set
# end of Rpmsg drivers

CONFIG_SOUNDWIRE=y

#
# SoundWire Devices
#

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#
# end of Amlogic SoC drivers

#
# Broadcom SoC drivers
#
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
# end of i.MX SoC drivers

#
# Enable LiteX SoC Builder specific drivers
#
# end of Enable LiteX SoC Builder specific drivers

#
# Qualcomm SoC drivers
#
# end of Qualcomm SoC drivers

CONFIG_SOC_TI=y

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
CONFIG_DEVFREQ_GOV_PASSIVE=y

#
# DEVFREQ Drivers
#
# CONFIG_PM_DEVFREQ_EVENT is not set
# CONFIG_EXTCON is not set
CONFIG_MEMORY=y
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
CONFIG_IIO_SW_DEVICE=y
# CONFIG_IIO_SW_TRIGGER is not set
# CONFIG_IIO_TRIGGERED_EVENT is not set

#
# Accelerometers
#
CONFIG_ADXL313=y
CONFIG_ADXL313_I2C=y
# CONFIG_ADXL345_I2C is not set
# CONFIG_ADXL355_I2C is not set
# CONFIG_ADXL367_I2C is not set
CONFIG_ADXL372=y
CONFIG_ADXL372_I2C=y
# CONFIG_BMA180 is not set
CONFIG_BMA400=y
CONFIG_BMA400_I2C=y
# CONFIG_BMC150_ACCEL is not set
CONFIG_DA280=y
# CONFIG_DA311 is not set
# CONFIG_DMARD06 is not set
CONFIG_DMARD09=y
CONFIG_DMARD10=y
# CONFIG_FXLS8962AF_I2C is not set
CONFIG_KXSD9=y
# CONFIG_KXSD9_I2C is not set
CONFIG_KXCJK1013=y
# CONFIG_MC3230 is not set
CONFIG_MMA7455=y
CONFIG_MMA7455_I2C=y
CONFIG_MMA7660=y
CONFIG_MMA8452=y
CONFIG_MMA9551_CORE=y
CONFIG_MMA9551=y
CONFIG_MMA9553=y
CONFIG_MXC4005=y
CONFIG_MXC6255=y
CONFIG_STK8312=y
CONFIG_STK8BA50=y
# end of Accelerometers

#
# Analog to digital converters
#
CONFIG_AD7091R5=y
CONFIG_AD7291=y
CONFIG_AD799X=y
CONFIG_ENVELOPE_DETECTOR=y
CONFIG_HX711=y
CONFIG_INA2XX_ADC=y
CONFIG_LTC2471=y
# CONFIG_LTC2485 is not set
CONFIG_LTC2497=y
CONFIG_MAX1363=y
CONFIG_MAX9611=y
CONFIG_MCP3422=y
CONFIG_NAU7802=y
CONFIG_SD_ADC_MODULATOR=y
# CONFIG_TI_ADC081C is not set
# CONFIG_TI_ADS1015 is not set
# end of Analog to digital converters

#
# Analog to digital and digital to analog converters
#
# end of Analog to digital and digital to analog converters

#
# Analog Front Ends
#
CONFIG_IIO_RESCALE=y
# end of Analog Front Ends

#
# Amplifiers
#
# CONFIG_HMC425 is not set
# end of Amplifiers

#
# Capacitance to digital converters
#
CONFIG_AD7150=y
# end of Capacitance to digital converters

#
# Chemical Sensors
#
CONFIG_ATLAS_PH_SENSOR=y
CONFIG_ATLAS_EZO_SENSOR=y
CONFIG_BME680=y
CONFIG_BME680_I2C=y
CONFIG_CCS811=y
CONFIG_IAQCORE=y
CONFIG_SCD30_CORE=y
CONFIG_SCD30_I2C=y
CONFIG_SCD4X=y
CONFIG_SENSIRION_SGP30=y
CONFIG_SENSIRION_SGP40=y
# CONFIG_SPS30_I2C is not set
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
# end of SSP Sensor Common

CONFIG_IIO_ST_SENSORS_CORE=y

#
# Digital to analog converters
#
CONFIG_AD5064=y
CONFIG_AD5380=y
CONFIG_AD5446=y
CONFIG_AD5592R_BASE=y
CONFIG_AD5593R=y
CONFIG_AD5686=y
CONFIG_AD5696_I2C=y
CONFIG_DPOT_DAC=y
CONFIG_DS4424=y
CONFIG_M62332=y
# CONFIG_MAX517 is not set
CONFIG_MAX5821=y
CONFIG_MCP4725=y
CONFIG_TI_DAC5571=y
# end of Digital to analog converters

#
# IIO dummy driver
#
CONFIG_IIO_SIMPLE_DUMMY=y
# CONFIG_IIO_SIMPLE_DUMMY_EVENTS is not set
# CONFIG_IIO_SIMPLE_DUMMY_BUFFER is not set
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
# end of Clock Generator/Distribution

#
# Phase-Locked Loop (PLL) frequency synthesizers
#
# end of Phase-Locked Loop (PLL) frequency synthesizers
# end of Frequency Synthesizers DDS/PLL

#
# Digital gyroscope sensors
#
# CONFIG_BMG160 is not set
# CONFIG_FXAS21002C is not set
# CONFIG_MPU3050_I2C is not set
# CONFIG_IIO_ST_GYRO_3AXIS is not set
CONFIG_ITG3200=y
# end of Digital gyroscope sensors

#
# Health Sensors
#

#
# Heart Rate Monitors
#
# CONFIG_AFE4404 is not set
CONFIG_MAX30100=y
CONFIG_MAX30102=y
# end of Heart Rate Monitors
# end of Health Sensors

#
# Humidity sensors
#
CONFIG_AM2315=y
# CONFIG_DHT11 is not set
# CONFIG_HDC100X is not set
CONFIG_HDC2010=y
CONFIG_HTS221=y
CONFIG_HTS221_I2C=y
# CONFIG_HTU21 is not set
CONFIG_SI7005=y
CONFIG_SI7020=y
# end of Humidity sensors

#
# Inertial measurement units
#
CONFIG_BMI160=y
CONFIG_BMI160_I2C=y
# CONFIG_FXOS8700_I2C is not set
CONFIG_KMX61=y
# CONFIG_INV_ICM42600_I2C is not set
CONFIG_INV_MPU6050_IIO=y
CONFIG_INV_MPU6050_I2C=y
CONFIG_IIO_ST_LSM6DSX=y
CONFIG_IIO_ST_LSM6DSX_I2C=y
CONFIG_IIO_ST_LSM6DSX_I3C=y
# end of Inertial measurement units

#
# Light sensors
#
# CONFIG_ADJD_S311 is not set
CONFIG_ADUX1020=y
# CONFIG_AL3010 is not set
CONFIG_AL3320A=y
CONFIG_APDS9300=y
# CONFIG_APDS9960 is not set
CONFIG_AS73211=y
CONFIG_BH1750=y
CONFIG_BH1780=y
CONFIG_CM32181=y
CONFIG_CM3232=y
CONFIG_CM3323=y
CONFIG_CM3605=y
CONFIG_CM36651=y
CONFIG_GP2AP002=y
# CONFIG_GP2AP020A00F is not set
# CONFIG_SENSORS_ISL29018 is not set
# CONFIG_SENSORS_ISL29028 is not set
CONFIG_ISL29125=y
CONFIG_JSA1212=y
CONFIG_RPR0521=y
# CONFIG_LTR501 is not set
CONFIG_LV0104CS=y
# CONFIG_MAX44000 is not set
CONFIG_MAX44009=y
CONFIG_NOA1305=y
# CONFIG_OPT3001 is not set
CONFIG_PA12203001=y
CONFIG_SI1133=y
CONFIG_SI1145=y
CONFIG_STK3310=y
CONFIG_ST_UVIS25=y
CONFIG_ST_UVIS25_I2C=y
CONFIG_TCS3414=y
CONFIG_TCS3472=y
CONFIG_SENSORS_TSL2563=y
CONFIG_TSL2583=y
# CONFIG_TSL2591 is not set
CONFIG_TSL2772=y
CONFIG_TSL4531=y
CONFIG_US5182D=y
# CONFIG_VCNL4000 is not set
# CONFIG_VCNL4035 is not set
# CONFIG_VEML6030 is not set
CONFIG_VEML6070=y
# CONFIG_VL6180 is not set
# CONFIG_ZOPT2201 is not set
# end of Light sensors

#
# Magnetometer sensors
#
# CONFIG_AK8974 is not set
CONFIG_AK8975=y
# CONFIG_AK09911 is not set
CONFIG_BMC150_MAGN=y
CONFIG_BMC150_MAGN_I2C=y
CONFIG_MAG3110=y
CONFIG_MMC35240=y
# CONFIG_IIO_ST_MAGN_3AXIS is not set
CONFIG_SENSORS_HMC5843=y
CONFIG_SENSORS_HMC5843_I2C=y
# CONFIG_SENSORS_RM3100_I2C is not set
# CONFIG_YAMAHA_YAS530 is not set
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

#
# Triggers - standalone
#
CONFIG_IIO_INTERRUPT_TRIGGER=y
CONFIG_IIO_SYSFS_TRIGGER=y
# end of Triggers - standalone

#
# Linear and angular position sensors
#
# end of Linear and angular position sensors

#
# Digital potentiometers
#
# CONFIG_AD5110 is not set
# CONFIG_AD5272 is not set
# CONFIG_DS1803 is not set
CONFIG_MAX5432=y
CONFIG_MCP4018=y
# CONFIG_MCP4531 is not set
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
CONFIG_BMP280=y
CONFIG_BMP280_I2C=y
# CONFIG_DLHL60D is not set
CONFIG_DPS310=y
CONFIG_HP03=y
CONFIG_ICP10100=y
CONFIG_MPL115=y
CONFIG_MPL115_I2C=y
# CONFIG_MPL3115 is not set
# CONFIG_MS5611 is not set
CONFIG_MS5637=y
CONFIG_IIO_ST_PRESS=y
# CONFIG_IIO_ST_PRESS_I2C is not set
# CONFIG_T5403 is not set
# CONFIG_HP206C is not set
# CONFIG_ZPA2326 is not set
# end of Pressure sensors

#
# Lightning sensors
#
# end of Lightning sensors

#
# Proximity and distance sensors
#
CONFIG_ISL29501=y
# CONFIG_LIDAR_LITE_V2 is not set
CONFIG_MB1232=y
# CONFIG_PING is not set
CONFIG_RFD77402=y
CONFIG_SRF04=y
CONFIG_SX_COMMON=y
# CONFIG_SX9310 is not set
CONFIG_SX9324=y
# CONFIG_SX9360 is not set
# CONFIG_SX9500 is not set
CONFIG_SRF08=y
# CONFIG_VCNL3020 is not set
CONFIG_VL53L0X_I2C=y
# end of Proximity and distance sensors

#
# Resolver to digital converters
#
# end of Resolver to digital converters

#
# Temperature sensors
#
CONFIG_MLX90614=y
CONFIG_MLX90632=y
# CONFIG_TMP006 is not set
CONFIG_TMP007=y
# CONFIG_TMP117 is not set
# CONFIG_TSYS01 is not set
CONFIG_TSYS02D=y
# end of Temperature sensors

CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
CONFIG_PWM_DEBUG=y
CONFIG_PWM_ATMEL_TCB=y
# CONFIG_PWM_PCA9685 is not set

#
# IRQ chip support
#
CONFIG_IRQCHIP=y
# CONFIG_AL_FIC is not set
# end of IRQ chip support

# CONFIG_RESET_CONTROLLER is not set

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
CONFIG_PHY_CAN_TRANSCEIVER=y

#
# PHY drivers for Broadcom platforms
#
# end of PHY drivers for Broadcom platforms
# end of PHY Subsystem

CONFIG_POWERCAP=y
# CONFIG_DTPM is not set
# CONFIG_RAS is not set

#
# Android
#
CONFIG_ANDROID_BINDER_IPC=y
# CONFIG_ANDROID_BINDERFS is not set
CONFIG_ANDROID_BINDER_DEVICES="binder,hwbinder,vndbinder"
# CONFIG_ANDROID_BINDER_IPC_SELFTEST is not set
# end of Android

# CONFIG_DAX is not set
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y

#
# HW tracing support
#
CONFIG_STM=y
CONFIG_STM_PROTO_BASIC=y
CONFIG_STM_PROTO_SYS_T=y
CONFIG_STM_DUMMY=y
CONFIG_STM_SOURCE_CONSOLE=y
CONFIG_STM_SOURCE_HEARTBEAT=y
# CONFIG_STM_SOURCE_FTRACE is not set
# end of HW tracing support

CONFIG_FPGA=y
CONFIG_ALTERA_PR_IP_CORE=y
CONFIG_FPGA_BRIDGE=y
# CONFIG_FPGA_REGION is not set
# CONFIG_FSI is not set
CONFIG_MULTIPLEXER=y

#
# Multiplexer drivers
#
CONFIG_MUX_ADG792A=y
CONFIG_MUX_GPIO=y
CONFIG_MUX_MMIO=y
# end of Multiplexer drivers

CONFIG_PM_OPP=y
CONFIG_SIOX=y
# CONFIG_SIOX_BUS_GPIO is not set
CONFIG_SLIMBUS=y
# CONFIG_INTERCONNECT is not set
# CONFIG_COUNTER is not set
CONFIG_MOST=y
CONFIG_MOST_CDEV=y
CONFIG_PECI=y
# CONFIG_PECI_CPU is not set
CONFIG_HTE=y
# end of Device Drivers

#
# File systems
#
CONFIG_VALIDATE_FS_PARSER=y
CONFIG_FS_IOMAP=y
CONFIG_EXT2_FS=y
# CONFIG_EXT2_FS_XATTR is not set
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=y
# CONFIG_EXT4_FS_POSIX_ACL is not set
# CONFIG_EXT4_FS_SECURITY is not set
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=y
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
# CONFIG_XFS_FS is not set
# CONFIG_GFS2_FS is not set
CONFIG_BTRFS_FS=y
CONFIG_BTRFS_FS_POSIX_ACL=y
CONFIG_BTRFS_FS_CHECK_INTEGRITY=y
CONFIG_BTRFS_FS_RUN_SANITY_TESTS=y
CONFIG_BTRFS_DEBUG=y
# CONFIG_BTRFS_ASSERT is not set
CONFIG_BTRFS_FS_REF_VERIFY=y
# CONFIG_NILFS2_FS is not set
CONFIG_F2FS_FS=y
CONFIG_F2FS_STAT_FS=y
CONFIG_F2FS_FS_XATTR=y
CONFIG_F2FS_FS_POSIX_ACL=y
# CONFIG_F2FS_FS_SECURITY is not set
CONFIG_F2FS_CHECK_FS=y
CONFIG_F2FS_FAULT_INJECTION=y
CONFIG_F2FS_FS_COMPRESSION=y
CONFIG_F2FS_FS_LZO=y
CONFIG_F2FS_FS_LZORLE=y
# CONFIG_F2FS_FS_LZ4 is not set
CONFIG_F2FS_FS_ZSTD=y
CONFIG_F2FS_IOSTAT=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
# CONFIG_EXPORTFS_BLOCK_OPS is not set
CONFIG_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
CONFIG_FS_ENCRYPTION_ALGS=y
# CONFIG_FS_VERITY is not set
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
# CONFIG_FANOTIFY is not set
CONFIG_QUOTA=y
# CONFIG_PRINT_QUOTA_WARNING is not set
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=y
CONFIG_QFMT_V1=y
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=y
CONFIG_CUSE=y
CONFIG_VIRTIO_FS=y
CONFIG_OVERLAY_FS=y
CONFIG_OVERLAY_FS_REDIRECT_DIR=y
# CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
CONFIG_OVERLAY_FS_INDEX=y
CONFIG_OVERLAY_FS_NFS_EXPORT=y
# CONFIG_OVERLAY_FS_XINO_AUTO is not set
# CONFIG_OVERLAY_FS_METACOPY is not set

#
# Caches
#
# CONFIG_FSCACHE is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
# CONFIG_ISO9660_FS is not set
# CONFIG_UDF_FS is not set
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/EXFAT/NT Filesystems
#
# CONFIG_MSDOS_FS is not set
# CONFIG_VFAT_FS is not set
CONFIG_EXFAT_FS=y
CONFIG_EXFAT_DEFAULT_IOCHARSET="utf8"
# CONFIG_NTFS_FS is not set
CONFIG_NTFS3_FS=y
# CONFIG_NTFS3_64BIT_CLUSTER is not set
CONFIG_NTFS3_LZX_XPRESS=y
CONFIG_NTFS3_FS_POSIX_ACL=y
# end of DOS/FAT/EXFAT/NT Filesystems

#
# Pseudo filesystems
#
# CONFIG_PROC_FS is not set
CONFIG_PROC_CHILDREN=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_ARCH_SUPPORTS_HUGETLBFS=y
# CONFIG_HUGETLBFS is not set
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
# end of Pseudo filesystems

# CONFIG_MISC_FILESYSTEMS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=y
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
CONFIG_NLS_CODEPAGE_852=y
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
CONFIG_NLS_CODEPAGE_861=y
# CONFIG_NLS_CODEPAGE_862 is not set
CONFIG_NLS_CODEPAGE_863=y
CONFIG_NLS_CODEPAGE_864=y
CONFIG_NLS_CODEPAGE_865=y
CONFIG_NLS_CODEPAGE_866=y
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
CONFIG_NLS_CODEPAGE_950=y
# CONFIG_NLS_CODEPAGE_932 is not set
CONFIG_NLS_CODEPAGE_949=y
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
CONFIG_NLS_CODEPAGE_1250=y
CONFIG_NLS_CODEPAGE_1251=y
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_ISO8859_2=y
# CONFIG_NLS_ISO8859_3 is not set
CONFIG_NLS_ISO8859_4=y
CONFIG_NLS_ISO8859_5=y
CONFIG_NLS_ISO8859_6=y
CONFIG_NLS_ISO8859_7=y
CONFIG_NLS_ISO8859_9=y
CONFIG_NLS_ISO8859_13=y
CONFIG_NLS_ISO8859_14=y
# CONFIG_NLS_ISO8859_15 is not set
CONFIG_NLS_KOI8_R=y
# CONFIG_NLS_KOI8_U is not set
CONFIG_NLS_MAC_ROMAN=y
# CONFIG_NLS_MAC_CELTIC is not set
CONFIG_NLS_MAC_CENTEURO=y
CONFIG_NLS_MAC_CROATIAN=y
CONFIG_NLS_MAC_CYRILLIC=y
CONFIG_NLS_MAC_GAELIC=y
CONFIG_NLS_MAC_GREEK=y
CONFIG_NLS_MAC_ICELAND=y
CONFIG_NLS_MAC_INUIT=y
CONFIG_NLS_MAC_ROMANIAN=y
# CONFIG_NLS_MAC_TURKISH is not set
# CONFIG_NLS_UTF8 is not set
CONFIG_UNICODE=y
# CONFIG_UNICODE_NORMALIZATION_SELFTEST is not set
CONFIG_IO_WQ=y
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_KEYS_REQUEST_CACHE is not set
# CONFIG_PERSISTENT_KEYRINGS is not set
CONFIG_TRUSTED_KEYS=y

#
# No trust source selected!
#
CONFIG_ENCRYPTED_KEYS=y
CONFIG_USER_DECRYPTED_DATA=y
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_KEY_NOTIFICATIONS is not set
CONFIG_SECURITY_DMESG_RESTRICT=y
# CONFIG_SECURITY is not set
# CONFIG_SECURITYFS is not set
# CONFIG_FORTIFY_SOURCE is not set
# CONFIG_STATIC_USERMODEHELPER is not set
# CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT is not set
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
# CONFIG_INIT_STACK_NONE is not set
# CONFIG_INIT_STACK_ALL_PATTERN is not set
CONFIG_INIT_STACK_ALL_ZERO=y
CONFIG_INIT_ON_ALLOC_DEFAULT_ON=y
# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
# end of Memory initialization

CONFIG_CC_HAS_RANDSTRUCT=y
CONFIG_RANDSTRUCT_NONE=y
# CONFIG_RANDSTRUCT_FULL is not set
# end of Kernel hardening options
# end of Security options

CONFIG_XOR_BLOCKS=y
CONFIG_ASYNC_CORE=y
CONFIG_ASYNC_MEMCPY=y
CONFIG_ASYNC_XOR=y
CONFIG_ASYNC_PQ=y
CONFIG_ASYNC_RAID6_RECOV=y
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
# CONFIG_CRYPTO_TEST is not set

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=y
CONFIG_CRYPTO_DH_RFC7919_GROUPS=y
CONFIG_CRYPTO_ECC=y
CONFIG_CRYPTO_ECDH=y
# CONFIG_CRYPTO_ECDSA is not set
CONFIG_CRYPTO_ECRDSA=y
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
CONFIG_CRYPTO_LRW=y
CONFIG_CRYPTO_OFB=y
CONFIG_CRYPTO_PCBC=y
CONFIG_CRYPTO_XCTR=y
# CONFIG_CRYPTO_XTS is not set
CONFIG_CRYPTO_KEYWRAP=y
# CONFIG_CRYPTO_ADIANTUM is not set
CONFIG_CRYPTO_HCTR2=y
CONFIG_CRYPTO_ESSIV=y

#
# Hash modes
#
# CONFIG_CRYPTO_CMAC is not set
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=y
# CONFIG_CRYPTO_VMAC is not set

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32=y
CONFIG_CRYPTO_CRC32_S390=y
CONFIG_CRYPTO_XXHASH=y
CONFIG_CRYPTO_BLAKE2B=y
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRC64_ROCKSOFT=y
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_POLYVAL=y
CONFIG_CRYPTO_POLY1305=y
# CONFIG_CRYPTO_MD4 is not set
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=y
CONFIG_CRYPTO_RMD160=y
CONFIG_CRYPTO_SHA1=y
# CONFIG_CRYPTO_SHA512_S390 is not set
# CONFIG_CRYPTO_SHA1_S390 is not set
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA256_S390=y
CONFIG_CRYPTO_SHA512=y
# CONFIG_CRYPTO_SHA3 is not set
CONFIG_CRYPTO_SHA3_256_S390=y
# CONFIG_CRYPTO_SHA3_512_S390 is not set
# CONFIG_CRYPTO_SM3_GENERIC is not set
CONFIG_CRYPTO_STREEBOG=y
# CONFIG_CRYPTO_WP512 is not set
# CONFIG_CRYPTO_GHASH_S390 is not set

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_AES_TI=y
CONFIG_CRYPTO_AES_S390=y
CONFIG_CRYPTO_BLOWFISH=y
CONFIG_CRYPTO_BLOWFISH_COMMON=y
# CONFIG_CRYPTO_CAMELLIA is not set
CONFIG_CRYPTO_CAST_COMMON=y
CONFIG_CRYPTO_CAST5=y
CONFIG_CRYPTO_CAST6=y
# CONFIG_CRYPTO_DES is not set
# CONFIG_CRYPTO_DES_S390 is not set
# CONFIG_CRYPTO_FCRYPT is not set
CONFIG_CRYPTO_CHACHA20=y
CONFIG_CRYPTO_CHACHA_S390=y
# CONFIG_CRYPTO_ARIA is not set
CONFIG_CRYPTO_SERPENT=y
# CONFIG_CRYPTO_SM4_GENERIC is not set
# CONFIG_CRYPTO_TWOFISH is not set

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
CONFIG_CRYPTO_842=y
CONFIG_CRYPTO_LZ4=y
CONFIG_CRYPTO_LZ4HC=y
CONFIG_CRYPTO_ZSTD=y

#
# Random Number Generation
#
# CONFIG_CRYPTO_ANSI_CPRNG is not set
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
# CONFIG_CRYPTO_DRBG_HASH is not set
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_HASH_INFO=y
# CONFIG_CRYPTO_HW is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
# CONFIG_X509_CERTIFICATE_PARSER is not set
CONFIG_PKCS8_PRIVATE_KEY_PARSER=y

#
# Certificates for signature checking
#
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=y
CONFIG_RAID6_PQ_BENCHMARK=y
CONFIG_LINEAR_RANGES=y
CONFIG_PACKING=y
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_CORDIC=y
CONFIG_PRIME_NUMBERS=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
CONFIG_CRYPTO_ARCH_HAVE_LIB_CHACHA=y
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=y
CONFIG_CRYPTO_LIB_CHACHA=y
CONFIG_CRYPTO_LIB_CURVE25519_GENERIC=y
CONFIG_CRYPTO_LIB_CURVE25519=y
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=1
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=y
# CONFIG_CRYPTO_LIB_POLY1305 is not set
# CONFIG_CRYPTO_LIB_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_LIB_SHA1=y
CONFIG_CRYPTO_LIB_SHA256=y
# end of Crypto library routines

CONFIG_LIB_MEMNEQ=y
# CONFIG_CRC_CCITT is not set
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC64_ROCKSOFT=y
# CONFIG_CRC_ITU_T is not set
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
# CONFIG_CRC32_SLICEBY8 is not set
# CONFIG_CRC32_SLICEBY4 is not set
CONFIG_CRC32_SARWATE=y
# CONFIG_CRC32_BIT is not set
CONFIG_CRC64=y
CONFIG_CRC4=y
# CONFIG_CRC7 is not set
CONFIG_LIBCRC32C=y
CONFIG_CRC8=y
CONFIG_XXHASH=y
CONFIG_RANDOM32_SELFTEST=y
CONFIG_842_COMPRESS=y
CONFIG_842_DECOMPRESS=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
# CONFIG_ZLIB_DFLTCC is not set
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_COMPRESS=y
CONFIG_LZ4HC_COMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=y
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
# CONFIG_XZ_DEC_X86 is not set
CONFIG_XZ_DEC_POWERPC=y
# CONFIG_XZ_DEC_IA64 is not set
# CONFIG_XZ_DEC_ARM is not set
CONFIG_XZ_DEC_ARMTHUMB=y
# CONFIG_XZ_DEC_SPARC is not set
CONFIG_XZ_DEC_MICROLZMA=y
CONFIG_XZ_DEC_BCJ=y
CONFIG_XZ_DEC_TEST=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=y
CONFIG_REED_SOLOMON_ENC16=y
CONFIG_REED_SOLOMON_DEC16=y
CONFIG_INTERVAL_TREE=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_DMA=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_DMA_DECLARE_COHERENT=y
CONFIG_ARCH_HAS_FORCE_DMA_UNENCRYPTED=y
CONFIG_SWIOTLB=y
CONFIG_DMA_RESTRICTED_POOL=y
CONFIG_DMA_API_DEBUG=y
# CONFIG_DMA_API_DEBUG_SG is not set
# CONFIG_DMA_MAP_BENCHMARK is not set
CONFIG_SGL_ALLOC=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_CLZ_TAB=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_LIBFDT=y
CONFIG_OID_REGISTRY=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_SG_POOL=y
CONFIG_ARCH_STACKWALK=y
CONFIG_STACKDEPOT=y
CONFIG_REF_TRACKER=y
CONFIG_SBITMAP=y
# end of Library routines

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
# CONFIG_DEBUG_BUGVERBOSE is not set
# end of printk and dmesg options

CONFIG_DEBUG_KERNEL=y
# CONFIG_DEBUG_MISC is not set

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO_NONE=y
# CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is not set
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_DEBUG_INFO_DWARF5 is not set
CONFIG_FRAME_WARN=2048
# CONFIG_STRIP_ASM_SYMS is not set
# CONFIG_HEADERS_INSTALL is not set
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
# CONFIG_VMLINUX_MAP is not set
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# end of Compile-time checks and compiler options

#
# Generic Kernel Debugging Instruments
#
# CONFIG_MAGIC_SYSRQ is not set
CONFIG_DEBUG_FS=y
# CONFIG_DEBUG_FS_ALLOW_ALL is not set
CONFIG_DEBUG_FS_DISALLOW_MOUNT=y
# CONFIG_DEBUG_FS_ALLOW_NONE is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
CONFIG_UBSAN=y
CONFIG_UBSAN_TRAP=y
CONFIG_CC_HAS_UBSAN_BOUNDS=y
CONFIG_CC_HAS_UBSAN_ARRAY_BOUNDS=y
# CONFIG_UBSAN_BOUNDS is not set
CONFIG_UBSAN_LOCAL_BOUNDS=y
# CONFIG_UBSAN_SHIFT is not set
CONFIG_UBSAN_UNREACHABLE=y
CONFIG_UBSAN_BOOL=y
# CONFIG_UBSAN_ENUM is not set
# CONFIG_UBSAN_SANITIZE_ALL is not set
CONFIG_HAVE_ARCH_KCSAN=y
CONFIG_HAVE_KCSAN_COMPILER=y
CONFIG_KCSAN=y
CONFIG_CC_HAS_TSAN_COMPOUND_READ_BEFORE_WRITE=y
# CONFIG_KCSAN_SELFTEST is not set
# CONFIG_KCSAN_EARLY_ENABLE is not set
CONFIG_KCSAN_NUM_WATCHPOINTS=64
CONFIG_KCSAN_UDELAY_TASK=80
CONFIG_KCSAN_UDELAY_INTERRUPT=20
# CONFIG_KCSAN_DELAY_RANDOMIZE is not set
CONFIG_KCSAN_SKIP_WATCH=4000
# CONFIG_KCSAN_SKIP_WATCH_RANDOMIZE is not set
CONFIG_KCSAN_INTERRUPT_WATCHER=y
CONFIG_KCSAN_REPORT_ONCE_IN_MS=3000
CONFIG_KCSAN_REPORT_RACE_UNKNOWN_ORIGIN=y
# CONFIG_KCSAN_STRICT is not set
CONFIG_KCSAN_REPORT_VALUE_CHANGE_ONLY=y
# CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC is not set
# CONFIG_KCSAN_IGNORE_ATOMICS is not set
CONFIG_KCSAN_PERMISSIVE=y
# end of Generic Kernel Debugging Instruments

#
# Networking Debugging
#
CONFIG_NET_DEV_REFCNT_TRACKER=y
CONFIG_NET_NS_REFCNT_TRACKER=y
# end of Networking Debugging

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_PAGE_OWNER is not set
CONFIG_PAGE_POISONING=y
# CONFIG_DEBUG_PAGE_REF is not set
CONFIG_DEBUG_RODATA_TEST=y
CONFIG_ARCH_HAS_DEBUG_WX=y
# CONFIG_DEBUG_WX is not set
CONFIG_GENERIC_PTDUMP=y
# CONFIG_PTDUMP_DEBUGFS is not set
CONFIG_DEBUG_OBJECTS=y
CONFIG_DEBUG_OBJECTS_SELFTEST=y
CONFIG_DEBUG_OBJECTS_FREE=y
CONFIG_DEBUG_OBJECTS_TIMERS=y
CONFIG_DEBUG_OBJECTS_WORK=y
CONFIG_DEBUG_OBJECTS_RCU_HEAD=y
CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER=y
CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=1
# CONFIG_SHRINKER_DEBUG is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
CONFIG_SCHED_STACK_END_CHECK=y
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
CONFIG_DEBUG_VM=y
# CONFIG_DEBUG_VM_VMACACHE is not set
CONFIG_DEBUG_VM_RB=y
# CONFIG_DEBUG_VM_PGFLAGS is not set
# CONFIG_DEBUG_VM_PGTABLE is not set
CONFIG_DEBUG_MEMORY_INIT=y
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
CONFIG_HAVE_ARCH_KFENCE=y
# end of Memory Debugging

CONFIG_DEBUG_SHIRQ=y

#
# Debug Oops, Lockups and Hangs
#
# CONFIG_PANIC_ON_OOPS is not set
CONFIG_PANIC_ON_OOPS_VALUE=0
CONFIG_PANIC_TIMEOUT=0
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=120
CONFIG_BOOTPARAM_HUNG_TASK_PANIC=y
CONFIG_WQ_WATCHDOG=y
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
# end of Scheduler Debugging

CONFIG_DEBUG_TIMEKEEPING=y

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
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_LOCK_TORTURE_TEST is not set
CONFIG_WW_MUTEX_SELFTEST=y
CONFIG_SCF_TORTURE_TEST=y
# CONFIG_CSD_LOCK_WAIT_DEBUG is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_DEBUG_IRQFLAGS=y
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_KOBJECT_RELEASE=y

#
# Debug kernel data structures
#
CONFIG_DEBUG_LIST=y
# CONFIG_DEBUG_PLIST is not set
CONFIG_DEBUG_SG=y
# CONFIG_DEBUG_NOTIFIERS is not set
CONFIG_BUG_ON_DATA_CORRUPTION=y
# end of Debug kernel data structures

CONFIG_DEBUG_CREDENTIALS=y

#
# RCU Debugging
#
CONFIG_TORTURE_TEST=y
# CONFIG_RCU_SCALE_TEST is not set
# CONFIG_RCU_TORTURE_TEST is not set
# CONFIG_RCU_REF_SCALE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=21
CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=0
CONFIG_RCU_TRACE=y
CONFIG_RCU_EQS_DEBUG=y
# end of RCU Debugging

CONFIG_DEBUG_WQ_FORCE_RR_CPU=y
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
CONFIG_NOP_TRACER=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_NOP_MCOUNT=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_RING_BUFFER_ALLOW_SWAP=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
CONFIG_BOOTTIME_TRACING=y
CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=y
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_DYNAMIC_FTRACE_WITH_ARGS=y
# CONFIG_FUNCTION_PROFILER is not set
CONFIG_STACK_TRACER=y
# CONFIG_IRQSOFF_TRACER is not set
CONFIG_SCHED_TRACER=y
CONFIG_HWLAT_TRACER=y
CONFIG_OSNOISE_TRACER=y
# CONFIG_TIMERLAT_TRACER is not set
# CONFIG_FTRACE_SYSCALLS is not set
CONFIG_TRACER_SNAPSHOT=y
CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP=y
CONFIG_TRACE_BRANCH_PROFILING=y
# CONFIG_BRANCH_PROFILE_NONE is not set
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
CONFIG_PROFILE_ALL_BRANCHES=y
# CONFIG_BRANCH_TRACER is not set
# CONFIG_BLK_DEV_IO_TRACE is not set
CONFIG_DYNAMIC_EVENTS=y
CONFIG_FTRACE_MCOUNT_RECORD=y
CONFIG_FTRACE_MCOUNT_USE_CC=y
CONFIG_TRACING_MAP=y
CONFIG_SYNTH_EVENTS=y
CONFIG_HIST_TRIGGERS=y
CONFIG_TRACE_EVENT_INJECT=y
# CONFIG_TRACEPOINT_BENCHMARK is not set
CONFIG_RING_BUFFER_BENCHMARK=y
# CONFIG_TRACE_EVAL_MAP_FILE is not set
# CONFIG_FTRACE_RECORD_RECURSION is not set
# CONFIG_GCOV_PROFILE_FTRACE is not set
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS is not set
CONFIG_SYNTH_EVENT_GEN_TEST=y
# CONFIG_HIST_TRIGGERS_DEBUG is not set
CONFIG_DA_MON_EVENTS=y
CONFIG_DA_MON_EVENTS_ID=y
CONFIG_RV=y
CONFIG_RV_MON_WWNR=y
# CONFIG_RV_REACTORS is not set
# CONFIG_SAMPLES is not set
CONFIG_HAVE_SAMPLE_FTRACE_DIRECT=y
CONFIG_HAVE_SAMPLE_FTRACE_DIRECT_MULTI=y
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_STRICT_DEVMEM=y
# CONFIG_IO_STRICT_DEVMEM is not set

#
# s390 Debugging
#
CONFIG_EARLY_PRINTK=y
CONFIG_DEBUG_ENTRY=y
CONFIG_CIO_INJECT=y
# end of s390 Debugging

#
# Kernel Testing and Coverage
#
# CONFIG_KUNIT is not set
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
# CONFIG_FAULT_INJECTION is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
CONFIG_KCOV=y
CONFIG_KCOV_ENABLE_COMPARISONS=y
# CONFIG_KCOV_INSTRUMENT_ALL is not set
CONFIG_KCOV_IRQ_AREA_SIZE=0x40000
CONFIG_RUNTIME_TESTING_MENU=y
# CONFIG_LKDTM is not set
CONFIG_TEST_MIN_HEAP=y
CONFIG_TEST_DIV64=y
CONFIG_BACKTRACE_SELF_TEST=y
CONFIG_TEST_REF_TRACKER=y
CONFIG_RBTREE_TEST=y
CONFIG_REED_SOLOMON_TEST=y
CONFIG_INTERVAL_TREE_TEST=y
CONFIG_ATOMIC64_SELFTEST=y
CONFIG_ASYNC_RAID6_TEST=y
CONFIG_TEST_HEXDUMP=y
# CONFIG_STRING_SELFTEST is not set
# CONFIG_TEST_STRING_HELPERS is not set
CONFIG_TEST_STRSCPY=y
CONFIG_TEST_KSTRTOX=y
# CONFIG_TEST_PRINTF is not set
CONFIG_TEST_SCANF=y
# CONFIG_TEST_BITMAP is not set
# CONFIG_TEST_UUID is not set
CONFIG_TEST_XARRAY=y
CONFIG_TEST_RHASHTABLE=y
# CONFIG_TEST_SIPHASH is not set
# CONFIG_TEST_IDA is not set
# CONFIG_FIND_BIT_BENCHMARK is not set
CONFIG_TEST_FIRMWARE=y
CONFIG_TEST_UDELAY=y
# CONFIG_TEST_MEMCAT_P is not set
CONFIG_TEST_MEMINIT=y
# CONFIG_TEST_FREE_PAGES is not set
# end of Kernel Testing and Coverage
# end of Kernel hacking

--oE+xwdMEZlehhEng--
