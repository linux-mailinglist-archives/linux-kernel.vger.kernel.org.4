Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB44A5F8C34
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 18:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbiJIQNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 12:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbiJIQNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 12:13:04 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF2462497D
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 09:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665331979; x=1696867979;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=DxW1sBAjF/yCgGVTBtSijAmEG3RCBAw9Vcu3K8yd9HY=;
  b=g2HphjEnDvsyuvHbAM1y2uZkNrj7bY1QFdyVP1mv5dcKioDmymi0UPE7
   XPsWnnYUDG/Ex/+GzGQCFawdH856zbbaGLICdCuxuTfLcTxtbSyJNfmZ/
   MRpj9oiVwHEgT8PNVrU8SS5yVGzptWSYRR7CTHpfSiTQoTKjZziwSRDZI
   4nATFhNoO1PWO63CdscOZky//Sv66k544baiMdpWPgh4AmvQuPTRdbAyB
   W4jVxotaKTElFC4ZxX1+fy0czqFCpkHkm5lGKHnK7P5w3B8tA6GIFIG8b
   p5pulnsB5/1onAHojiMgu8J2d/Y1rdXYhkqo11NAkITHch4kG2O4XNHL4
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10495"; a="366032866"
X-IronPort-AV: E=Sophos;i="5.95,171,1661842800"; 
   d="scan'208";a="366032866"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2022 09:12:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10495"; a="576796347"
X-IronPort-AV: E=Sophos;i="5.95,171,1661842800"; 
   d="scan'208";a="576796347"
Received: from lkp-server01.sh.intel.com (HELO 2af0a69ca4e0) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 09 Oct 2022 09:12:56 -0700
Received: from kbuild by 2af0a69ca4e0 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ohYv9-0000yi-2s;
        Sun, 09 Oct 2022 16:12:55 +0000
Date:   Mon, 10 Oct 2022 00:12:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Justin Stitt <jstitt007@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Nathan Chancellor <nathan@kernel.org>
Subject: drivers/net/vmxnet3/vmxnet3_drv.c:228:23: sparse: sparse: incorrect
 type in assignment (different base types)
Message-ID: <202210100022.ygw3all5-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="6BnD8dwpNlBC6Pe5"
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,UPPERCASE_50_75 autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6BnD8dwpNlBC6Pe5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a6afa4199d3d038fbfdff5511f7523b0e30cb774
commit: d30dfd490f7dc4cb6a7c11a647bd1ff7a22139e7 include/uapi/linux/swab.h: move explicit cast outside ternary
date:   4 months ago
config: sparc-randconfig-s032-20221009
compiler: sparc-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d30dfd490f7dc4cb6a7c11a647bd1ff7a22139e7
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout d30dfd490f7dc4cb6a7c11a647bd1ff7a22139e7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=sparc SHELL=/bin/bash drivers/net/vmxnet3/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> drivers/net/vmxnet3/vmxnet3_drv.c:228:23: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le64 [usertype] addr @@     got unsigned long long [usertype] @@
   drivers/net/vmxnet3/vmxnet3_drv.c:228:23: sparse:     expected restricted __le64 [usertype] addr
   drivers/net/vmxnet3/vmxnet3_drv.c:228:23: sparse:     got unsigned long long [usertype]
   drivers/net/vmxnet3/vmxnet3_drv.c:229:16: sparse: sparse: cast to restricted __le32
   drivers/net/vmxnet3/vmxnet3_drv.c:229:16: sparse: sparse: cast to restricted __le32
   drivers/net/vmxnet3/vmxnet3_drv.c:229:16: sparse: sparse: cast to restricted __le32
   drivers/net/vmxnet3/vmxnet3_drv.c:229:16: sparse: sparse: cast to restricted __le32
   drivers/net/vmxnet3/vmxnet3_drv.c:229:16: sparse: sparse: cast to restricted __le32
   drivers/net/vmxnet3/vmxnet3_drv.c:229:16: sparse: sparse: cast to restricted __le32
   drivers/net/vmxnet3/vmxnet3_drv.c:230:25: sparse: sparse: cast to restricted __le32
   drivers/net/vmxnet3/vmxnet3_drv.c:230:25: sparse: sparse: cast to restricted __le32
   drivers/net/vmxnet3/vmxnet3_drv.c:230:25: sparse: sparse: cast to restricted __le32
   drivers/net/vmxnet3/vmxnet3_drv.c:230:25: sparse: sparse: cast to restricted __le32
   drivers/net/vmxnet3/vmxnet3_drv.c:230:25: sparse: sparse: cast to restricted __le32
   drivers/net/vmxnet3/vmxnet3_drv.c:230:25: sparse: sparse: cast to restricted __le32
   drivers/net/vmxnet3/vmxnet3_drv.c:244:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 [usertype] @@
   drivers/net/vmxnet3/vmxnet3_drv.c:244:22: sparse:     expected unsigned int [usertype]
   drivers/net/vmxnet3/vmxnet3_drv.c:244:22: sparse:     got restricted __le32 [usertype]
   drivers/net/vmxnet3/vmxnet3_drv.c:256:24: sparse: sparse: cast to restricted __le32
   drivers/net/vmxnet3/vmxnet3_drv.c:256:24: sparse: sparse: cast to restricted __le32
   drivers/net/vmxnet3/vmxnet3_drv.c:256:24: sparse: sparse: cast to restricted __le32
   drivers/net/vmxnet3/vmxnet3_drv.c:256:24: sparse: sparse: cast to restricted __le32
   drivers/net/vmxnet3/vmxnet3_drv.c:256:24: sparse: sparse: cast to restricted __le32
   drivers/net/vmxnet3/vmxnet3_drv.c:256:24: sparse: sparse: cast to restricted __le32
   drivers/net/vmxnet3/vmxnet3_drv.c:1250:43: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __wsum [usertype] csum @@     got restricted __be16 [usertype] @@
   drivers/net/vmxnet3/vmxnet3_drv.c:1250:43: sparse:     expected restricted __wsum [usertype] csum
   drivers/net/vmxnet3/vmxnet3_drv.c:1250:43: sparse:     got restricted __be16 [usertype]
   drivers/net/vmxnet3/vmxnet3_drv.c:1392:17: sparse: sparse: restricted __le64 degrades to integer
   drivers/net/vmxnet3/vmxnet3_drv.c:1685:33: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected unsigned int [usertype] addr @@     got restricted __le64 [usertype] addr @@
   drivers/net/vmxnet3/vmxnet3_drv.c:1685:33: sparse:     expected unsigned int [usertype] addr
   drivers/net/vmxnet3/vmxnet3_drv.c:1685:33: sparse:     got restricted __le64 [usertype] addr
   drivers/net/vmxnet3/vmxnet3_drv.c:1691:33: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected unsigned int [usertype] addr @@     got restricted __le64 [usertype] addr @@
   drivers/net/vmxnet3/vmxnet3_drv.c:1691:33: sparse:     expected unsigned int [usertype] addr
   drivers/net/vmxnet3/vmxnet3_drv.c:1691:33: sparse:     got restricted __le64 [usertype] addr
   drivers/net/vmxnet3/vmxnet3_drv.c:2313:31: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned int [usertype] *vfTable @@     got restricted __le32 * @@
   drivers/net/vmxnet3/vmxnet3_drv.c:2313:31: sparse:     expected unsigned int [usertype] *vfTable
   drivers/net/vmxnet3/vmxnet3_drv.c:2313:31: sparse:     got restricted __le32 *
   drivers/net/vmxnet3/vmxnet3_drv.c:2330:39: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned int [usertype] *vfTable @@     got restricted __le32 * @@
   drivers/net/vmxnet3/vmxnet3_drv.c:2330:39: sparse:     expected unsigned int [usertype] *vfTable
   drivers/net/vmxnet3/vmxnet3_drv.c:2330:39: sparse:     got restricted __le32 *
   drivers/net/vmxnet3/vmxnet3_drv.c:2352:39: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned int [usertype] *vfTable @@     got restricted __le32 * @@
   drivers/net/vmxnet3/vmxnet3_drv.c:2352:39: sparse:     expected unsigned int [usertype] *vfTable
   drivers/net/vmxnet3/vmxnet3_drv.c:2352:39: sparse:     got restricted __le32 *
   drivers/net/vmxnet3/vmxnet3_drv.c:2404:39: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned int [usertype] *vfTable @@     got restricted __le32 * @@
   drivers/net/vmxnet3/vmxnet3_drv.c:2404:39: sparse:     expected unsigned int [usertype] *vfTable
   drivers/net/vmxnet3/vmxnet3_drv.c:2404:39: sparse:     got restricted __le32 *
   drivers/net/vmxnet3/vmxnet3_drv.c:2450:31: sparse: sparse: restricted __le32 degrades to integer
   drivers/net/vmxnet3/vmxnet3_drv.c:2463:17: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected unsigned int [usertype] size @@     got restricted __le16 [usertype] mfTableLen @@
   drivers/net/vmxnet3/vmxnet3_drv.c:2463:17: sparse:     expected unsigned int [usertype] size
   drivers/net/vmxnet3/vmxnet3_drv.c:2463:17: sparse:     got restricted __le16 [usertype] mfTableLen
   drivers/net/vmxnet3/vmxnet3_drv.c:2501:49: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 [usertype] @@
   drivers/net/vmxnet3/vmxnet3_drv.c:2501:49: sparse:     expected unsigned int [usertype]
   drivers/net/vmxnet3/vmxnet3_drv.c:2501:49: sparse:     got restricted __le32 [usertype]
   drivers/net/vmxnet3/vmxnet3_drv.c:2542:41: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] txDataRingDescSize @@     got restricted __le32 [usertype] @@
   drivers/net/vmxnet3/vmxnet3_drv.c:2542:41: sparse:     expected restricted __le16 [usertype] txDataRingDescSize
   drivers/net/vmxnet3/vmxnet3_drv.c:2542:41: sparse:     got restricted __le32 [usertype]
   drivers/net/vmxnet3/vmxnet3_drv.c:2591:46: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] confVer @@     got int @@
   drivers/net/vmxnet3/vmxnet3_drv.c:2591:46: sparse:     expected restricted __le32 [usertype] confVer
   drivers/net/vmxnet3/vmxnet3_drv.c:2591:46: sparse:     got int
   drivers/net/vmxnet3/vmxnet3_drv.c:2640:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] confVer @@     got int @@
   drivers/net/vmxnet3/vmxnet3_drv.c:2640:34: sparse:     expected restricted __le32 [usertype] confVer
   drivers/net/vmxnet3/vmxnet3_drv.c:2640:34: sparse:     got int

vim +228 drivers/net/vmxnet3/vmxnet3_drv.c

d1a890fa37f27d Shreyas Bhatewara 2009-10-13  209  
115924b6bdc7cc Shreyas Bhatewara 2009-11-16  210  #ifdef __BIG_ENDIAN_BITFIELD
115924b6bdc7cc Shreyas Bhatewara 2009-11-16  211  /*
115924b6bdc7cc Shreyas Bhatewara 2009-11-16  212   * The device expects the bitfields in shared structures to be written in
115924b6bdc7cc Shreyas Bhatewara 2009-11-16  213   * little endian. When CPU is big endian, the following routines are used to
115924b6bdc7cc Shreyas Bhatewara 2009-11-16  214   * correctly read and write into ABI.
115924b6bdc7cc Shreyas Bhatewara 2009-11-16  215   * The general technique used here is : double word bitfields are defined in
115924b6bdc7cc Shreyas Bhatewara 2009-11-16  216   * opposite order for big endian architecture. Then before reading them in
115924b6bdc7cc Shreyas Bhatewara 2009-11-16  217   * driver the complete double word is translated using le32_to_cpu. Similarly
115924b6bdc7cc Shreyas Bhatewara 2009-11-16  218   * After the driver writes into bitfields, cpu_to_le32 is used to translate the
115924b6bdc7cc Shreyas Bhatewara 2009-11-16  219   * double words into required format.
115924b6bdc7cc Shreyas Bhatewara 2009-11-16  220   * In order to avoid touching bits in shared structure more than once, temporary
115924b6bdc7cc Shreyas Bhatewara 2009-11-16  221   * descriptors are used. These are passed as srcDesc to following functions.
115924b6bdc7cc Shreyas Bhatewara 2009-11-16  222   */
115924b6bdc7cc Shreyas Bhatewara 2009-11-16  223  static void vmxnet3_RxDescToCPU(const struct Vmxnet3_RxDesc *srcDesc,
115924b6bdc7cc Shreyas Bhatewara 2009-11-16  224  				struct Vmxnet3_RxDesc *dstDesc)
115924b6bdc7cc Shreyas Bhatewara 2009-11-16  225  {
115924b6bdc7cc Shreyas Bhatewara 2009-11-16  226  	u32 *src = (u32 *)srcDesc + 2;
115924b6bdc7cc Shreyas Bhatewara 2009-11-16  227  	u32 *dst = (u32 *)dstDesc + 2;
115924b6bdc7cc Shreyas Bhatewara 2009-11-16 @228  	dstDesc->addr = le64_to_cpu(srcDesc->addr);
115924b6bdc7cc Shreyas Bhatewara 2009-11-16  229  	*dst = le32_to_cpu(*src);
115924b6bdc7cc Shreyas Bhatewara 2009-11-16  230  	dstDesc->ext1 = le32_to_cpu(srcDesc->ext1);
115924b6bdc7cc Shreyas Bhatewara 2009-11-16  231  }
115924b6bdc7cc Shreyas Bhatewara 2009-11-16  232  

:::::: The code at line 228 was first introduced by commit
:::::: 115924b6bdc7cc6bf7da5b933b09281e1f4e17a9 net: Getting rid of the x86 dependency to built vmxnet3

:::::: TO: Shreyas Bhatewara <sbhatewara@vmware.com>
:::::: CC: David S. Miller <davem@davemloft.net>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

--6BnD8dwpNlBC6Pe5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=config

#
# Automatically generated file; DO NOT EDIT.
# Linux/sparc 5.19.0-rc2 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="sparc-linux-gcc (GCC) 12.1.0"
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
# CONFIG_POSIX_MQUEUE is not set
CONFIG_WATCH_QUEUE=y
CONFIG_CROSS_MEMORY_ATTACH=y
# CONFIG_USELIB is not set
# CONFIG_AUDIT is not set

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_INJECTION=y
CONFIG_GENERIC_IRQ_CHIP=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_IRQ_FASTEOI_HIERARCHY_HANDLERS=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
# end of IRQ subsystem

CONFIG_GENERIC_CLOCKEVENTS=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_HZ_PERIODIC=y
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
# end of Timers subsystem

CONFIG_BPF=y
CONFIG_HAVE_CBPF_JIT=y

#
# BPF subsystem
#
CONFIG_BPF_SYSCALL=y
CONFIG_BPF_JIT=y
# CONFIG_BPF_UNPRIV_DEFAULT_OFF is not set
CONFIG_USERMODE_DRIVER=y
# end of BPF subsystem

CONFIG_PREEMPT_NONE_BUILD=y
CONFIG_PREEMPT_NONE=y
# CONFIG_PREEMPT_VOLUNTARY is not set
# CONFIG_PREEMPT is not set

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
# CONFIG_PSI is not set
# end of CPU/Task time and stats accounting

CONFIG_CPU_ISOLATION=y

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
# CONFIG_RCU_NOCB_CPU is not set
CONFIG_TASKS_TRACE_RCU_READ_MB=y
# end of RCU Subsystem

# CONFIG_IKCONFIG is not set
# CONFIG_IKHEADERS is not set

#
# Scheduler features
#
# end of Scheduler features

CONFIG_CC_IMPLICIT_FALLTHROUGH="-Wimplicit-fallthrough=5"
CONFIG_GCC12_NO_ARRAY_BOUNDS=y
CONFIG_CC_NO_ARRAY_BOUNDS=y
CONFIG_CGROUPS=y
# CONFIG_MEMCG is not set
# CONFIG_BLK_CGROUP is not set
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
CONFIG_RT_GROUP_SCHED=y
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
CONFIG_CGROUP_FREEZER=y
CONFIG_CPUSETS=y
# CONFIG_PROC_PID_CPUSET is not set
# CONFIG_CGROUP_DEVICE is not set
# CONFIG_CGROUP_CPUACCT is not set
CONFIG_CGROUP_BPF=y
# CONFIG_CGROUP_MISC is not set
CONFIG_CGROUP_DEBUG=y
CONFIG_SOCK_CGROUP_DATA=y
# CONFIG_CHECKPOINT_RESTORE is not set
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
# CONFIG_RD_ZSTD is not set
CONFIG_BOOT_CONFIG=y
# CONFIG_BOOT_CONFIG_EMBED is not set
CONFIG_INITRAMFS_PRESERVE_MTIME=y
# CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE is not set
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_EXPERT=y
# CONFIG_MULTIUSER is not set
# CONFIG_SGETMASK_SYSCALL is not set
CONFIG_SYSFS_SYSCALL=y
CONFIG_FHANDLE=y
# CONFIG_POSIX_TIMERS is not set
# CONFIG_PRINTK is not set
CONFIG_BUG=y
# CONFIG_BASE_FULL is not set
# CONFIG_EPOLL is not set
# CONFIG_SIGNALFD is not set
CONFIG_TIMERFD=y
# CONFIG_EVENTFD is not set
CONFIG_SHMEM=y
# CONFIG_AIO is not set
# CONFIG_IO_URING is not set
# CONFIG_ADVISE_SYSCALLS is not set
# CONFIG_MEMBARRIER is not set
# CONFIG_KALLSYMS is not set
# CONFIG_KCMP is not set
CONFIG_EMBEDDED=y
# CONFIG_PC104 is not set

#
# Kernel Performance Events And Counters
#
# end of Kernel Performance Events And Counters

CONFIG_SYSTEM_DATA_VERIFICATION=y
# CONFIG_PROFILING is not set
# end of General setup

# CONFIG_64BIT is not set
CONFIG_SPARC=y
CONFIG_SPARC32=y
CONFIG_ARCH_PROC_KCORE_TEXT=y
CONFIG_CPU_BIG_ENDIAN=y
CONFIG_AUDIT_ARCH=y
CONFIG_MMU=y
CONFIG_HIGHMEM=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_PGTABLE_LEVELS=3

#
# Processor type and features
#
CONFIG_SMP=y
CONFIG_NR_CPUS=32
# CONFIG_HZ_100 is not set
CONFIG_HZ_250=y
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=250
CONFIG_SCHED_HRTICK=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_EMULATED_CMPXCHG=y
CONFIG_SPARC32_SMP=y
CONFIG_FORCE_MAX_ZONEORDER=13
CONFIG_SUN_PM=y
CONFIG_SPARC_LED=m
CONFIG_SERIAL_CONSOLE=y
CONFIG_SPARC_LEON=y

#
# U-Boot options
#
CONFIG_UBOOT_LOAD_ADDR=0x40004000
CONFIG_UBOOT_FLASH_ADDR=0x00080000
CONFIG_UBOOT_ENTRY_ADDR=0xf0004000
# end of U-Boot options
# end of Processor type and features

#
# Bus options (PCI etc.)
#
CONFIG_SBUS=y
CONFIG_SBUSCHAR=y
CONFIG_LEON_PCI=y
CONFIG_SPARC_GRPCI1=y
CONFIG_SPARC_GRPCI2=y
# CONFIG_SUN_OPENPROMFS is not set
# end of Bus options (PCI etc.)

#
# Misc Linux/SPARC drivers
#
# CONFIG_SUN_OPENPROMIO is not set
CONFIG_TADPOLE_TS102_UCTRL=y
# end of Misc Linux/SPARC drivers

#
# General architecture-dependent options
#
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_32BIT_OFF_T=y
CONFIG_HAVE_ASM_MODVERSIONS=y
CONFIG_ARCH_WANT_IPC_PARSE_VERSION=y
CONFIG_LTO_NONE=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_PAGE_SIZE_LESS_THAN_64KB=y
CONFIG_PAGE_SIZE_LESS_THAN_256KB=y
CONFIG_ODD_RT_SIGACTION=y
CONFIG_OLD_SIGSUSPEND=y
CONFIG_OLD_SIGACTION=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_CPU_NO_EFFICIENT_FFS=y
# CONFIG_LOCK_EVENT_COUNTS is not set

#
# GCOV-based kernel profiling
#
CONFIG_GCOV_KERNEL=y
# end of GCOV-based kernel profiling
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=1
CONFIG_MODULE_SIG_FORMAT=y
CONFIG_MODULES=y
CONFIG_MODULE_FORCE_LOAD=y
# CONFIG_MODULE_UNLOAD is not set
CONFIG_MODVERSIONS=y
CONFIG_ASM_MODVERSIONS=y
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_MODULE_SIG=y
CONFIG_MODULE_SIG_FORCE=y
CONFIG_MODULE_SIG_ALL=y
# CONFIG_MODULE_SIG_SHA1 is not set
# CONFIG_MODULE_SIG_SHA224 is not set
CONFIG_MODULE_SIG_SHA256=y
# CONFIG_MODULE_SIG_SHA384 is not set
# CONFIG_MODULE_SIG_SHA512 is not set
CONFIG_MODULE_SIG_HASH="sha256"
CONFIG_MODULE_COMPRESS_NONE=y
# CONFIG_MODULE_COMPRESS_GZIP is not set
# CONFIG_MODULE_COMPRESS_XZ is not set
# CONFIG_MODULE_COMPRESS_ZSTD is not set
# CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
CONFIG_MODPROBE_PATH="/sbin/modprobe"
CONFIG_BLOCK=y
CONFIG_BLOCK_LEGACY_AUTOLOAD=y
CONFIG_BLK_DEV_BSG_COMMON=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_INTEGRITY_T10=y
CONFIG_BLK_DEV_ZONED=y
# CONFIG_BLK_WBT is not set
CONFIG_BLK_DEBUG_FS=y
CONFIG_BLK_DEBUG_FS_ZONED=y
# CONFIG_BLK_SED_OPAL is not set
# CONFIG_BLK_INLINE_ENCRYPTION is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
CONFIG_AIX_PARTITION=y
CONFIG_OSF_PARTITION=y
CONFIG_AMIGA_PARTITION=y
# CONFIG_ATARI_PARTITION is not set
# CONFIG_MAC_PARTITION is not set
# CONFIG_MSDOS_PARTITION is not set
CONFIG_LDM_PARTITION=y
CONFIG_LDM_DEBUG=y
# CONFIG_SGI_PARTITION is not set
CONFIG_ULTRIX_PARTITION=y
CONFIG_SUN_PARTITION=y
# CONFIG_KARMA_PARTITION is not set
# CONFIG_EFI_PARTITION is not set
# CONFIG_SYSV68_PARTITION is not set
# CONFIG_CMDLINE_PARTITION is not set
# end of Partition Types

CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLOCK_HOLDER_DEPRECATED=y
CONFIG_BLK_MQ_STACKING=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=y
# CONFIG_IOSCHED_BFQ is not set
# end of IO Schedulers

CONFIG_PADATA=y
CONFIG_ASN1=y
CONFIG_INLINE_SPIN_UNLOCK_IRQ=y
CONFIG_INLINE_READ_UNLOCK=y
CONFIG_INLINE_READ_UNLOCK_IRQ=y
CONFIG_INLINE_WRITE_UNLOCK=y
CONFIG_INLINE_WRITE_UNLOCK_IRQ=y
CONFIG_FREEZER=y

#
# Executable file formats
#
# CONFIG_BINFMT_ELF is not set
# CONFIG_BINFMT_SCRIPT is not set
# CONFIG_BINFMT_MISC is not set
# CONFIG_COREDUMP is not set
# end of Executable file formats

#
# Memory Management options
#
CONFIG_SWAP=y
# CONFIG_ZSWAP is not set

#
# SLAB allocator options
#
CONFIG_SLAB=y
# CONFIG_SLUB is not set
# CONFIG_SLOB is not set
# CONFIG_SLAB_MERGE_DEFAULT is not set
CONFIG_SLAB_FREELIST_RANDOM=y
# CONFIG_SLAB_FREELIST_HARDENED is not set
# end of SLAB allocator options

# CONFIG_SHUFFLE_PAGE_ALLOCATOR is not set
CONFIG_COMPAT_BRK=y
CONFIG_FLATMEM=y
CONFIG_SPLIT_PTLOCK_CPUS=999999
CONFIG_COMPACTION=y
# CONFIG_PAGE_REPORTING is not set
CONFIG_MIGRATION=y
# CONFIG_BOUNCE is not set
# CONFIG_KSM is not set
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
# CONFIG_CMA is not set
# CONFIG_IDLE_PAGE_TRACKING is not set
CONFIG_ZONE_DMA=y
CONFIG_VM_EVENT_COUNTERS=y
CONFIG_PERCPU_STATS=y
# CONFIG_GUP_TEST is not set
CONFIG_KMAP_LOCAL=y
# CONFIG_USERFAULTFD is not set

#
# Data Access Monitoring
#
# CONFIG_DAMON is not set
# end of Data Access Monitoring
# end of Memory Management options

CONFIG_NET=y
CONFIG_NET_INGRESS=y
CONFIG_NET_EGRESS=y
CONFIG_SKB_EXTENSIONS=y

#
# Networking options
#
CONFIG_PACKET=m
CONFIG_PACKET_DIAG=m
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
CONFIG_AF_UNIX_OOB=y
CONFIG_UNIX_DIAG=y
CONFIG_TLS=m
CONFIG_TLS_DEVICE=y
CONFIG_TLS_TOE=y
CONFIG_XFRM=y
CONFIG_XFRM_OFFLOAD=y
CONFIG_XFRM_ALGO=y
# CONFIG_XFRM_USER is not set
CONFIG_XFRM_SUB_POLICY=y
CONFIG_XFRM_MIGRATE=y
CONFIG_XFRM_AH=y
CONFIG_XFRM_ESP=m
CONFIG_NET_KEY=m
CONFIG_NET_KEY_MIGRATE=y
CONFIG_XFRM_ESPINTCP=y
CONFIG_XDP_SOCKETS=y
CONFIG_XDP_SOCKETS_DIAG=m
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_ROUTE_CLASSID=y
# CONFIG_IP_PNP is not set
CONFIG_NET_IPIP=y
# CONFIG_NET_IPGRE_DEMUX is not set
CONFIG_NET_IP_TUNNEL=y
CONFIG_IP_MROUTE_COMMON=y
CONFIG_IP_MROUTE=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
CONFIG_SYN_COOKIES=y
CONFIG_NET_IPVTI=y
CONFIG_NET_UDP_TUNNEL=y
CONFIG_NET_FOU=y
# CONFIG_NET_FOU_IP_TUNNELS is not set
CONFIG_INET_AH=y
CONFIG_INET_ESP=m
CONFIG_INET_ESP_OFFLOAD=m
CONFIG_INET_ESPINTCP=y
# CONFIG_INET_IPCOMP is not set
CONFIG_INET_TUNNEL=y
# CONFIG_INET_DIAG is not set
CONFIG_TCP_CONG_ADVANCED=y
# CONFIG_TCP_CONG_BIC is not set
CONFIG_TCP_CONG_CUBIC=y
CONFIG_TCP_CONG_WESTWOOD=y
CONFIG_TCP_CONG_HTCP=m
CONFIG_TCP_CONG_HSTCP=y
CONFIG_TCP_CONG_HYBLA=y
CONFIG_TCP_CONG_VEGAS=y
# CONFIG_TCP_CONG_NV is not set
CONFIG_TCP_CONG_SCALABLE=m
CONFIG_TCP_CONG_LP=y
CONFIG_TCP_CONG_VENO=m
# CONFIG_TCP_CONG_YEAH is not set
CONFIG_TCP_CONG_ILLINOIS=m
CONFIG_TCP_CONG_DCTCP=m
CONFIG_TCP_CONG_CDG=m
CONFIG_TCP_CONG_BBR=y
CONFIG_DEFAULT_CUBIC=y
# CONFIG_DEFAULT_HYBLA is not set
# CONFIG_DEFAULT_VEGAS is not set
# CONFIG_DEFAULT_WESTWOOD is not set
# CONFIG_DEFAULT_BBR is not set
# CONFIG_DEFAULT_RENO is not set
CONFIG_DEFAULT_TCP_CONG="cubic"
CONFIG_TCP_MD5SIG=y
# CONFIG_IPV6 is not set
# CONFIG_MPTCP is not set
CONFIG_NETWORK_SECMARK=y
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
CONFIG_NETFILTER=y
CONFIG_NETFILTER_ADVANCED=y
# CONFIG_BRIDGE_NETFILTER is not set

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_INGRESS=y
CONFIG_NETFILTER_EGRESS=y
CONFIG_NETFILTER_SKIP_EGRESS=y
CONFIG_NETFILTER_NETLINK=y
CONFIG_NETFILTER_FAMILY_BRIDGE=y
CONFIG_NETFILTER_FAMILY_ARP=y
# CONFIG_NETFILTER_NETLINK_ACCT is not set
CONFIG_NETFILTER_NETLINK_QUEUE=y
CONFIG_NETFILTER_NETLINK_LOG=m
CONFIG_NETFILTER_NETLINK_OSF=y
CONFIG_NF_CONNTRACK=m
CONFIG_NF_LOG_SYSLOG=y
CONFIG_NF_CONNTRACK_MARK=y
# CONFIG_NF_CONNTRACK_SECMARK is not set
CONFIG_NF_CONNTRACK_ZONES=y
CONFIG_NF_CONNTRACK_EVENTS=y
CONFIG_NF_CONNTRACK_TIMEOUT=y
# CONFIG_NF_CONNTRACK_TIMESTAMP is not set
CONFIG_NF_CONNTRACK_LABELS=y
CONFIG_NF_CT_PROTO_DCCP=y
CONFIG_NF_CT_PROTO_GRE=y
CONFIG_NF_CT_PROTO_SCTP=y
# CONFIG_NF_CT_PROTO_UDPLITE is not set
# CONFIG_NF_CONNTRACK_AMANDA is not set
CONFIG_NF_CONNTRACK_FTP=m
CONFIG_NF_CONNTRACK_H323=m
CONFIG_NF_CONNTRACK_IRC=m
CONFIG_NF_CONNTRACK_BROADCAST=m
# CONFIG_NF_CONNTRACK_NETBIOS_NS is not set
CONFIG_NF_CONNTRACK_SNMP=m
CONFIG_NF_CONNTRACK_PPTP=m
CONFIG_NF_CONNTRACK_SANE=m
CONFIG_NF_CONNTRACK_SIP=m
# CONFIG_NF_CONNTRACK_TFTP is not set
# CONFIG_NF_CT_NETLINK is not set
CONFIG_NF_CT_NETLINK_TIMEOUT=m
CONFIG_NF_NAT=m
CONFIG_NF_NAT_FTP=m
CONFIG_NF_NAT_IRC=m
CONFIG_NF_NAT_SIP=m
CONFIG_NF_NAT_MASQUERADE=y
# CONFIG_NF_TABLES is not set
CONFIG_NETFILTER_XTABLES=y

#
# Xtables combined modules
#
CONFIG_NETFILTER_XT_MARK=y
CONFIG_NETFILTER_XT_CONNMARK=m

#
# Xtables targets
#
CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
CONFIG_NETFILTER_XT_TARGET_CONNMARK=m
CONFIG_NETFILTER_XT_TARGET_CT=m
# CONFIG_NETFILTER_XT_TARGET_HMARK is not set
CONFIG_NETFILTER_XT_TARGET_IDLETIMER=y
# CONFIG_NETFILTER_XT_TARGET_LOG is not set
CONFIG_NETFILTER_XT_TARGET_MARK=y
CONFIG_NETFILTER_XT_NAT=m
CONFIG_NETFILTER_XT_TARGET_NETMAP=m
CONFIG_NETFILTER_XT_TARGET_NFLOG=m
CONFIG_NETFILTER_XT_TARGET_NFQUEUE=y
CONFIG_NETFILTER_XT_TARGET_NOTRACK=m
CONFIG_NETFILTER_XT_TARGET_RATEEST=y
# CONFIG_NETFILTER_XT_TARGET_REDIRECT is not set
CONFIG_NETFILTER_XT_TARGET_MASQUERADE=m
CONFIG_NETFILTER_XT_TARGET_TEE=m
CONFIG_NETFILTER_XT_TARGET_TRACE=m
CONFIG_NETFILTER_XT_TARGET_SECMARK=m
CONFIG_NETFILTER_XT_TARGET_TCPMSS=y

#
# Xtables matches
#
CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=y
CONFIG_NETFILTER_XT_MATCH_BPF=m
# CONFIG_NETFILTER_XT_MATCH_CGROUP is not set
CONFIG_NETFILTER_XT_MATCH_CLUSTER=m
# CONFIG_NETFILTER_XT_MATCH_COMMENT is not set
# CONFIG_NETFILTER_XT_MATCH_CONNBYTES is not set
# CONFIG_NETFILTER_XT_MATCH_CONNLABEL is not set
# CONFIG_NETFILTER_XT_MATCH_CONNLIMIT is not set
# CONFIG_NETFILTER_XT_MATCH_CONNMARK is not set
# CONFIG_NETFILTER_XT_MATCH_CONNTRACK is not set
# CONFIG_NETFILTER_XT_MATCH_CPU is not set
CONFIG_NETFILTER_XT_MATCH_DCCP=y
CONFIG_NETFILTER_XT_MATCH_DEVGROUP=m
CONFIG_NETFILTER_XT_MATCH_DSCP=y
CONFIG_NETFILTER_XT_MATCH_ECN=m
# CONFIG_NETFILTER_XT_MATCH_ESP is not set
CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=m
CONFIG_NETFILTER_XT_MATCH_HELPER=m
CONFIG_NETFILTER_XT_MATCH_HL=y
CONFIG_NETFILTER_XT_MATCH_IPCOMP=y
CONFIG_NETFILTER_XT_MATCH_IPRANGE=y
# CONFIG_NETFILTER_XT_MATCH_L2TP is not set
CONFIG_NETFILTER_XT_MATCH_LENGTH=m
CONFIG_NETFILTER_XT_MATCH_LIMIT=y
CONFIG_NETFILTER_XT_MATCH_MAC=y
CONFIG_NETFILTER_XT_MATCH_MARK=m
# CONFIG_NETFILTER_XT_MATCH_MULTIPORT is not set
# CONFIG_NETFILTER_XT_MATCH_NFACCT is not set
# CONFIG_NETFILTER_XT_MATCH_OSF is not set
CONFIG_NETFILTER_XT_MATCH_OWNER=m
# CONFIG_NETFILTER_XT_MATCH_POLICY is not set
CONFIG_NETFILTER_XT_MATCH_PKTTYPE=y
CONFIG_NETFILTER_XT_MATCH_QUOTA=y
CONFIG_NETFILTER_XT_MATCH_RATEEST=m
CONFIG_NETFILTER_XT_MATCH_REALM=m
# CONFIG_NETFILTER_XT_MATCH_RECENT is not set
CONFIG_NETFILTER_XT_MATCH_SCTP=m
CONFIG_NETFILTER_XT_MATCH_SOCKET=y
CONFIG_NETFILTER_XT_MATCH_STATE=m
CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
# CONFIG_NETFILTER_XT_MATCH_STRING is not set
CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
# CONFIG_NETFILTER_XT_MATCH_TIME is not set
CONFIG_NETFILTER_XT_MATCH_U32=m
# end of Core Netfilter Configuration

# CONFIG_IP_SET is not set
# CONFIG_IP_VS is not set

#
# IP: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV4=y
CONFIG_NF_SOCKET_IPV4=y
CONFIG_NF_TPROXY_IPV4=y
CONFIG_NF_DUP_IPV4=m
# CONFIG_NF_LOG_ARP is not set
CONFIG_NF_LOG_IPV4=y
CONFIG_NF_REJECT_IPV4=y
# CONFIG_NF_NAT_SNMP_BASIC is not set
CONFIG_NF_NAT_PPTP=m
CONFIG_NF_NAT_H323=m
CONFIG_IP_NF_IPTABLES=y
CONFIG_IP_NF_MATCH_AH=y
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_RPFILTER=m
# CONFIG_IP_NF_MATCH_TTL is not set
CONFIG_IP_NF_FILTER=y
CONFIG_IP_NF_TARGET_REJECT=m
# CONFIG_IP_NF_TARGET_SYNPROXY is not set
CONFIG_IP_NF_NAT=m
# CONFIG_IP_NF_TARGET_MASQUERADE is not set
CONFIG_IP_NF_TARGET_NETMAP=m
# CONFIG_IP_NF_TARGET_REDIRECT is not set
# CONFIG_IP_NF_MANGLE is not set
CONFIG_IP_NF_RAW=m
CONFIG_IP_NF_ARPTABLES=y
# CONFIG_IP_NF_ARPFILTER is not set
# CONFIG_IP_NF_ARP_MANGLE is not set
# end of IP: Netfilter Configuration

CONFIG_NF_CONNTRACK_BRIDGE=m
CONFIG_BRIDGE_NF_EBTABLES=m
CONFIG_BRIDGE_EBT_BROUTE=m
CONFIG_BRIDGE_EBT_T_FILTER=m
CONFIG_BRIDGE_EBT_T_NAT=m
# CONFIG_BRIDGE_EBT_802_3 is not set
CONFIG_BRIDGE_EBT_AMONG=m
CONFIG_BRIDGE_EBT_ARP=m
CONFIG_BRIDGE_EBT_IP=m
CONFIG_BRIDGE_EBT_LIMIT=m
# CONFIG_BRIDGE_EBT_MARK is not set
CONFIG_BRIDGE_EBT_PKTTYPE=m
CONFIG_BRIDGE_EBT_STP=m
# CONFIG_BRIDGE_EBT_VLAN is not set
# CONFIG_BRIDGE_EBT_ARPREPLY is not set
CONFIG_BRIDGE_EBT_DNAT=m
CONFIG_BRIDGE_EBT_MARK_T=m
# CONFIG_BRIDGE_EBT_REDIRECT is not set
CONFIG_BRIDGE_EBT_SNAT=m
CONFIG_BRIDGE_EBT_LOG=m
CONFIG_BRIDGE_EBT_NFLOG=m
CONFIG_BPFILTER=y
# CONFIG_IP_DCCP is not set
CONFIG_IP_SCTP=m
CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5=y
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1 is not set
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
CONFIG_SCTP_COOKIE_HMAC_MD5=y
CONFIG_SCTP_COOKIE_HMAC_SHA1=y
# CONFIG_RDS is not set
CONFIG_TIPC=m
# CONFIG_TIPC_MEDIA_UDP is not set
CONFIG_TIPC_CRYPTO=y
CONFIG_TIPC_DIAG=m
# CONFIG_ATM is not set
CONFIG_L2TP=y
CONFIG_L2TP_DEBUGFS=m
# CONFIG_L2TP_V3 is not set
CONFIG_STP=m
CONFIG_MRP=y
CONFIG_BRIDGE=m
CONFIG_BRIDGE_IGMP_SNOOPING=y
CONFIG_BRIDGE_VLAN_FILTERING=y
# CONFIG_BRIDGE_MRP is not set
# CONFIG_BRIDGE_CFM is not set
CONFIG_NET_DSA=m
CONFIG_NET_DSA_TAG_AR9331=m
CONFIG_NET_DSA_TAG_BRCM_COMMON=m
CONFIG_NET_DSA_TAG_BRCM=m
CONFIG_NET_DSA_TAG_BRCM_LEGACY=m
CONFIG_NET_DSA_TAG_BRCM_PREPEND=m
# CONFIG_NET_DSA_TAG_HELLCREEK is not set
CONFIG_NET_DSA_TAG_GSWIP=m
CONFIG_NET_DSA_TAG_DSA_COMMON=m
CONFIG_NET_DSA_TAG_DSA=m
CONFIG_NET_DSA_TAG_EDSA=m
# CONFIG_NET_DSA_TAG_MTK is not set
CONFIG_NET_DSA_TAG_KSZ=m
CONFIG_NET_DSA_TAG_OCELOT=m
CONFIG_NET_DSA_TAG_OCELOT_8021Q=m
CONFIG_NET_DSA_TAG_QCA=m
# CONFIG_NET_DSA_TAG_RTL4_A is not set
# CONFIG_NET_DSA_TAG_RTL8_4 is not set
CONFIG_NET_DSA_TAG_LAN9303=m
# CONFIG_NET_DSA_TAG_SJA1105 is not set
CONFIG_NET_DSA_TAG_TRAILER=m
# CONFIG_NET_DSA_TAG_XRS700X is not set
CONFIG_VLAN_8021Q=y
# CONFIG_VLAN_8021Q_GVRP is not set
CONFIG_VLAN_8021Q_MVRP=y
# CONFIG_DECNET is not set
CONFIG_LLC=y
CONFIG_LLC2=y
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
CONFIG_PHONET=y
CONFIG_IEEE802154=y
CONFIG_IEEE802154_NL802154_EXPERIMENTAL=y
CONFIG_IEEE802154_SOCKET=y
CONFIG_MAC802154=m
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_HTB=y
CONFIG_NET_SCH_HFSC=m
CONFIG_NET_SCH_PRIO=y
# CONFIG_NET_SCH_MULTIQ is not set
CONFIG_NET_SCH_RED=y
CONFIG_NET_SCH_SFB=m
# CONFIG_NET_SCH_SFQ is not set
CONFIG_NET_SCH_TEQL=y
CONFIG_NET_SCH_TBF=m
CONFIG_NET_SCH_CBS=y
# CONFIG_NET_SCH_ETF is not set
CONFIG_NET_SCH_TAPRIO=y
CONFIG_NET_SCH_GRED=y
CONFIG_NET_SCH_DSMARK=y
# CONFIG_NET_SCH_NETEM is not set
CONFIG_NET_SCH_DRR=m
CONFIG_NET_SCH_MQPRIO=y
CONFIG_NET_SCH_SKBPRIO=m
CONFIG_NET_SCH_CHOKE=m
# CONFIG_NET_SCH_QFQ is not set
CONFIG_NET_SCH_CODEL=y
CONFIG_NET_SCH_FQ_CODEL=m
CONFIG_NET_SCH_CAKE=y
CONFIG_NET_SCH_FQ=y
CONFIG_NET_SCH_HHF=m
CONFIG_NET_SCH_PIE=y
# CONFIG_NET_SCH_FQ_PIE is not set
# CONFIG_NET_SCH_INGRESS is not set
# CONFIG_NET_SCH_PLUG is not set
CONFIG_NET_SCH_ETS=m
# CONFIG_NET_SCH_DEFAULT is not set

#
# Classification
#
CONFIG_NET_CLS=y
CONFIG_NET_CLS_BASIC=y
# CONFIG_NET_CLS_TCINDEX is not set
CONFIG_NET_CLS_ROUTE4=y
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
# CONFIG_CLS_U32_PERF is not set
CONFIG_CLS_U32_MARK=y
# CONFIG_NET_CLS_RSVP is not set
CONFIG_NET_CLS_RSVP6=m
# CONFIG_NET_CLS_FLOW is not set
CONFIG_NET_CLS_CGROUP=m
CONFIG_NET_CLS_BPF=y
CONFIG_NET_CLS_FLOWER=y
CONFIG_NET_CLS_MATCHALL=y
CONFIG_NET_EMATCH=y
CONFIG_NET_EMATCH_STACK=32
CONFIG_NET_EMATCH_CMP=m
# CONFIG_NET_EMATCH_NBYTE is not set
# CONFIG_NET_EMATCH_U32 is not set
CONFIG_NET_EMATCH_META=y
CONFIG_NET_EMATCH_TEXT=m
# CONFIG_NET_EMATCH_CANID is not set
CONFIG_NET_EMATCH_IPT=y
CONFIG_NET_CLS_ACT=y
CONFIG_NET_ACT_POLICE=m
CONFIG_NET_ACT_GACT=m
# CONFIG_GACT_PROB is not set
CONFIG_NET_ACT_MIRRED=y
# CONFIG_NET_ACT_SAMPLE is not set
CONFIG_NET_ACT_IPT=m
CONFIG_NET_ACT_NAT=y
CONFIG_NET_ACT_PEDIT=m
CONFIG_NET_ACT_SIMP=y
CONFIG_NET_ACT_SKBEDIT=m
CONFIG_NET_ACT_CSUM=m
CONFIG_NET_ACT_MPLS=y
CONFIG_NET_ACT_VLAN=m
# CONFIG_NET_ACT_BPF is not set
CONFIG_NET_ACT_CONNMARK=m
CONFIG_NET_ACT_CTINFO=m
CONFIG_NET_ACT_SKBMOD=y
CONFIG_NET_ACT_IFE=y
CONFIG_NET_ACT_TUNNEL_KEY=m
# CONFIG_NET_ACT_GATE is not set
CONFIG_NET_IFE_SKBMARK=y
CONFIG_NET_IFE_SKBPRIO=m
CONFIG_NET_IFE_SKBTCINDEX=y
CONFIG_NET_TC_SKB_EXT=y
CONFIG_NET_SCH_FIFO=y
# CONFIG_DCB is not set
CONFIG_DNS_RESOLVER=y
CONFIG_BATMAN_ADV=y
CONFIG_BATMAN_ADV_BATMAN_V=y
CONFIG_BATMAN_ADV_BLA=y
CONFIG_BATMAN_ADV_DAT=y
CONFIG_BATMAN_ADV_NC=y
# CONFIG_BATMAN_ADV_DEBUG is not set
# CONFIG_OPENVSWITCH is not set
CONFIG_VSOCKETS=m
# CONFIG_VSOCKETS_DIAG is not set
CONFIG_VSOCKETS_LOOPBACK=m
# CONFIG_VIRTIO_VSOCKETS is not set
CONFIG_VIRTIO_VSOCKETS_COMMON=m
CONFIG_NETLINK_DIAG=y
# CONFIG_MPLS is not set
CONFIG_NET_NSH=m
# CONFIG_HSR is not set
CONFIG_NET_SWITCHDEV=y
CONFIG_NET_L3_MASTER_DEV=y
# CONFIG_QRTR is not set
CONFIG_NET_NCSI=y
CONFIG_NCSI_OEM_CMD_GET_MAC=y
# CONFIG_NCSI_OEM_CMD_KEEP_PHY is not set
CONFIG_PCPU_DEV_REFCNT=y
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_SOCK_RX_QUEUE_MAPPING=y
CONFIG_XPS=y
# CONFIG_CGROUP_NET_PRIO is not set
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_BPF_STREAM_PARSER=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
# end of Network testing
# end of Networking options

# CONFIG_HAMRADIO is not set
CONFIG_CAN=y
# CONFIG_CAN_RAW is not set
# CONFIG_CAN_BCM is not set
CONFIG_CAN_GW=y
# CONFIG_CAN_J1939 is not set
CONFIG_CAN_ISOTP=y

#
# CAN Device Drivers
#
# CONFIG_CAN_VCAN is not set
# CONFIG_CAN_VXCAN is not set
# CONFIG_CAN_DEV is not set
# CONFIG_CAN_DEBUG_DEVICES is not set
# end of CAN Device Drivers

CONFIG_BT=y
# CONFIG_BT_BREDR is not set
# CONFIG_BT_LE is not set
CONFIG_BT_MSFTEXT=y
# CONFIG_BT_AOSPEXT is not set
CONFIG_BT_DEBUGFS=y
# CONFIG_BT_SELFTEST is not set
CONFIG_BT_FEATURE_DEBUG=y

#
# Bluetooth device drivers
#
CONFIG_BT_HCIDTL1=m
CONFIG_BT_HCIBT3C=m
CONFIG_BT_HCIBLUECARD=m
# CONFIG_BT_HCIVHCI is not set
# CONFIG_BT_MRVL is not set
# CONFIG_BT_MTKUART is not set
# CONFIG_BT_QCOMSMD is not set
# CONFIG_BT_VIRTIO is not set
# end of Bluetooth device drivers

CONFIG_AF_RXRPC=y
CONFIG_AF_RXRPC_INJECT_LOSS=y
CONFIG_AF_RXRPC_DEBUG=y
CONFIG_RXKAD=y
CONFIG_AF_KCM=m
CONFIG_STREAM_PARSER=y
# CONFIG_MCTP is not set
CONFIG_WIRELESS=y
CONFIG_WIRELESS_EXT=y
CONFIG_WEXT_CORE=y
CONFIG_WEXT_SPY=y
CONFIG_WEXT_PRIV=y
# CONFIG_CFG80211 is not set

#
# CFG80211 needs to be enabled for MAC80211
#
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
CONFIG_RFKILL=y
# CONFIG_RFKILL_INPUT is not set
CONFIG_RFKILL_GPIO=m
CONFIG_NET_9P=y
CONFIG_NET_9P_FD=y
CONFIG_NET_9P_VIRTIO=m
CONFIG_NET_9P_DEBUG=y
# CONFIG_CAIF is not set
CONFIG_CEPH_LIB=y
# CONFIG_CEPH_LIB_PRETTYDEBUG is not set
# CONFIG_CEPH_LIB_USE_DNS_RESOLVER is not set
CONFIG_NFC=m
CONFIG_NFC_DIGITAL=m
CONFIG_NFC_NCI=m
CONFIG_NFC_HCI=m
CONFIG_NFC_SHDLC=y

#
# Near Field Communication (NFC) devices
#
CONFIG_NFC_SIM=m
# CONFIG_NFC_VIRTUAL_NCI is not set
# CONFIG_NFC_FDP is not set
CONFIG_NFC_PN544=m
CONFIG_NFC_PN544_I2C=m
# CONFIG_NFC_PN533_I2C is not set
# CONFIG_NFC_PN532_UART is not set
# CONFIG_NFC_MICROREAD_I2C is not set
# CONFIG_NFC_ST21NFCA_I2C is not set
CONFIG_NFC_ST_NCI=m
CONFIG_NFC_ST_NCI_I2C=m
# CONFIG_NFC_NXP_NCI is not set
CONFIG_NFC_S3FWRN5=m
CONFIG_NFC_S3FWRN5_I2C=m
# CONFIG_NFC_S3FWRN82_UART is not set
# end of Near Field Communication (NFC) devices

CONFIG_PSAMPLE=m
CONFIG_NET_IFE=y
# CONFIG_LWTUNNEL is not set
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_SOCK_VALIDATE_XMIT=y
CONFIG_NET_SELFTESTS=y
CONFIG_NET_SOCK_MSG=y
CONFIG_NET_DEVLINK=y
CONFIG_PAGE_POOL=y
# CONFIG_PAGE_POOL_STATS is not set
CONFIG_FAILOVER=y
CONFIG_ETHTOOL_NETLINK=y

#
# Device Drivers
#
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_SYSCALL=y
CONFIG_PCIEPORTBUS=y
CONFIG_PCIEAER=y
CONFIG_PCIEAER_INJECT=m
CONFIG_PCIE_ECRC=y
CONFIG_PCIEASPM=y
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
# CONFIG_PCIE_DPC is not set
CONFIG_PCIE_PTM=y
CONFIG_PCI_MSI=y
CONFIG_PCI_MSI_IRQ_DOMAIN=y
CONFIG_PCI_MSI_ARCH_FALLBACKS=y
# CONFIG_PCI_QUIRKS is not set
# CONFIG_PCI_DEBUG is not set
CONFIG_PCI_REALLOC_ENABLE_AUTO=y
# CONFIG_PCI_STUB is not set
# CONFIG_PCI_PF_STUB is not set
CONFIG_PCI_ATS=y
CONFIG_PCI_ECAM=y
CONFIG_PCI_IOV=y
CONFIG_PCI_PRI=y
CONFIG_PCI_PASID=y
# CONFIG_PCIE_BUS_TUNE_OFF is not set
# CONFIG_PCIE_BUS_DEFAULT is not set
# CONFIG_PCIE_BUS_SAFE is not set
# CONFIG_PCIE_BUS_PERFORMANCE is not set
CONFIG_PCIE_BUS_PEER2PEER=y
# CONFIG_VGA_ARB is not set
# CONFIG_HOTPLUG_PCI is not set

#
# PCI controller drivers
#
# CONFIG_PCI_AARDVARK is not set
# CONFIG_PCIE_XILINX_NWL is not set
CONFIG_PCI_FTPCI100=y
CONFIG_PCI_TEGRA=y
CONFIG_PCIE_RCAR_HOST=y
CONFIG_PCI_HOST_COMMON=y
CONFIG_PCI_HOST_GENERIC=m
CONFIG_PCIE_XILINX=y
# CONFIG_PCIE_XILINX_CPM is not set
CONFIG_PCI_XGENE=y
CONFIG_PCI_XGENE_MSI=y
CONFIG_PCI_V3_SEMI=y
# CONFIG_PCI_VERSATILE is not set
# CONFIG_PCIE_ALTERA is not set
CONFIG_PCI_HOST_THUNDER_PEM=y
CONFIG_PCI_HOST_THUNDER_ECAM=y
CONFIG_PCIE_ROCKCHIP=y
CONFIG_PCIE_ROCKCHIP_HOST=m
CONFIG_PCIE_MEDIATEK=y
# CONFIG_PCIE_MEDIATEK_GEN3 is not set
CONFIG_PCIE_BRCMSTB=m
# CONFIG_PCIE_MICROCHIP_HOST is not set
# CONFIG_PCIE_APPLE is not set
# CONFIG_PCIE_MT7621 is not set

#
# DesignWare PCI Core Support
#
CONFIG_PCIE_DW=y
CONFIG_PCIE_DW_HOST=y
CONFIG_PCIE_DW_PLAT=y
CONFIG_PCIE_DW_PLAT_HOST=y
# CONFIG_PCI_EXYNOS is not set
# CONFIG_PCI_IMX6 is not set
# CONFIG_PCIE_SPEAR13XX is not set
# CONFIG_PCI_KEYSTONE_HOST is not set
CONFIG_PCI_LAYERSCAPE=y
# CONFIG_PCI_HISI is not set
CONFIG_PCIE_QCOM=y
# CONFIG_PCIE_ARMADA_8K is not set
# CONFIG_PCIE_ARTPEC6_HOST is not set
# CONFIG_PCIE_ROCKCHIP_DW_HOST is not set
# CONFIG_PCIE_INTEL_GW is not set
# CONFIG_PCIE_KEEMBAY_HOST is not set
# CONFIG_PCIE_KIRIN is not set
# CONFIG_PCIE_HISI_STB is not set
# CONFIG_PCI_MESON is not set
# CONFIG_PCIE_TEGRA194_HOST is not set
# CONFIG_PCIE_VISCONTI_HOST is not set
# CONFIG_PCIE_UNIPHIER is not set
# CONFIG_PCIE_AL is not set
# CONFIG_PCIE_FU740 is not set
# end of DesignWare PCI Core Support

#
# Mobiveil PCIe Core Support
#
CONFIG_PCIE_MOBIVEIL=y
CONFIG_PCIE_MOBIVEIL_HOST=y
CONFIG_PCIE_MOBIVEIL_PLAT=y
# CONFIG_PCIE_LAYERSCAPE_GEN4 is not set
# end of Mobiveil PCIe Core Support

#
# Cadence PCIe controllers support
#
CONFIG_PCIE_CADENCE=y
CONFIG_PCIE_CADENCE_HOST=y
CONFIG_PCIE_CADENCE_PLAT=y
CONFIG_PCIE_CADENCE_PLAT_HOST=y
# CONFIG_PCI_J721E_HOST is not set
# end of Cadence PCIe controllers support
# end of PCI controller drivers

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set
# end of PCI Endpoint

#
# PCI switch controller drivers
#
CONFIG_PCI_SW_SWITCHTEC=m
# end of PCI switch controller drivers

# CONFIG_CXL_BUS is not set
CONFIG_PCCARD=m
CONFIG_PCMCIA=m
# CONFIG_PCMCIA_LOAD_CIS is not set
# CONFIG_CARDBUS is not set

#
# PC-card bridges
#
# CONFIG_YENTA is not set
CONFIG_PD6729=m
CONFIG_I82092=m
CONFIG_PCCARD_NONSTATIC=y
CONFIG_RAPIDIO=m
# CONFIG_RAPIDIO_TSI721 is not set
CONFIG_RAPIDIO_DISC_TIMEOUT=30
CONFIG_RAPIDIO_ENABLE_RX_TX_PORTS=y
CONFIG_RAPIDIO_DEBUG=y
# CONFIG_RAPIDIO_ENUM_BASIC is not set
# CONFIG_RAPIDIO_CHMAN is not set
CONFIG_RAPIDIO_MPORT_CDEV=m

#
# RapidIO Switch drivers
#
# CONFIG_RAPIDIO_CPS_XX is not set
CONFIG_RAPIDIO_CPS_GEN2=m
CONFIG_RAPIDIO_RXS_GEN3=m
# end of RapidIO Switch drivers

#
# Generic Driver Options
#
CONFIG_AUXILIARY_BUS=y
CONFIG_UEVENT_HELPER=y
CONFIG_UEVENT_HELPER_PATH=""
# CONFIG_DEVTMPFS is not set
CONFIG_STANDALONE=y
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
CONFIG_FW_LOADER_COMPRESS=y
CONFIG_FW_LOADER_COMPRESS_XZ=y
# CONFIG_FW_LOADER_COMPRESS_ZSTD is not set
# CONFIG_FW_UPLOAD is not set
# end of Firmware loader

CONFIG_ALLOW_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
CONFIG_DEBUG_DEVRES=y
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
CONFIG_TEST_ASYNC_DRIVER_PROBE=m
CONFIG_SOC_BUS=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SLIMBUS=m
CONFIG_REGMAP_W1=m
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_REGMAP_SCCB=y
CONFIG_DMA_SHARED_BUFFER=y
CONFIG_DMA_FENCE_TRACE=y
# end of Generic Driver Options

#
# Bus devices
#
CONFIG_ARM_INTEGRATOR_LM=y
CONFIG_BT1_APB=y
CONFIG_BT1_AXI=y
# CONFIG_HISILICON_LPC is not set
# CONFIG_INTEL_IXP4XX_EB is not set
CONFIG_QCOM_EBI2=y
CONFIG_MHI_BUS=m
CONFIG_MHI_BUS_DEBUG=y
# CONFIG_MHI_BUS_PCI_GENERIC is not set
# CONFIG_MHI_BUS_EP is not set
# end of Bus devices

CONFIG_CONNECTOR=y
# CONFIG_PROC_EVENTS is not set

#
# Firmware Drivers
#

#
# ARM System Control and Management Interface Protocol
#
# CONFIG_ARM_SCMI_PROTOCOL is not set
CONFIG_ARM_SCMI_POWER_DOMAIN=y
# end of ARM System Control and Management Interface Protocol

CONFIG_ARM_SCPI_POWER_DOMAIN=y
# CONFIG_FIRMWARE_MEMMAP is not set
# CONFIG_FW_CFG_SYSFS is not set
CONFIG_QCOM_SCM=y
# CONFIG_QCOM_SCM_DOWNLOAD_MODE_DEFAULT is not set
# CONFIG_BCM47XX_NVRAM is not set
# CONFIG_TEE_BNXT_FW is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

CONFIG_GNSS=y
CONFIG_GNSS_SERIAL=m
CONFIG_GNSS_MTK_SERIAL=m
CONFIG_GNSS_SIRF_SERIAL=y
# CONFIG_GNSS_UBX_SERIAL is not set
CONFIG_MTD=m
CONFIG_MTD_TESTS=m

#
# Partition parsers
#
# CONFIG_MTD_AR7_PARTS is not set
CONFIG_MTD_BCM63XX_PARTS=y
CONFIG_MTD_CMDLINE_PARTS=m
CONFIG_MTD_OF_PARTS=m
# CONFIG_MTD_OF_PARTS_BCM4908 is not set
# CONFIG_MTD_OF_PARTS_LINKSYS_NS is not set
CONFIG_MTD_PARSER_IMAGETAG=m
CONFIG_MTD_PARSER_TRX=m
CONFIG_MTD_SHARPSL_PARTS=m
CONFIG_MTD_REDBOOT_PARTS=m
CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=-1
# CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED is not set
CONFIG_MTD_REDBOOT_PARTS_READONLY=y
# end of Partition parsers

#
# User Modules And Translation Layers
#
CONFIG_MTD_BLKDEVS=m
CONFIG_MTD_BLOCK=m
# CONFIG_MTD_BLOCK_RO is not set

#
# Note that in some cases UBI block is preferred. See MTD_UBI_BLOCK.
#
CONFIG_FTL=m
CONFIG_NFTL=m
# CONFIG_NFTL_RW is not set
# CONFIG_INFTL is not set
CONFIG_RFD_FTL=m
# CONFIG_SSFDC is not set
# CONFIG_SM_FTL is not set
CONFIG_MTD_OOPS=m
# CONFIG_MTD_SWAP is not set
CONFIG_MTD_PARTITIONED_MASTER=y

#
# RAM/ROM/Flash chip drivers
#
CONFIG_MTD_CFI=m
CONFIG_MTD_JEDECPROBE=m
CONFIG_MTD_GEN_PROBE=m
# CONFIG_MTD_CFI_ADV_OPTIONS is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
CONFIG_MTD_CFI_INTELEXT=m
CONFIG_MTD_CFI_AMDSTD=m
CONFIG_MTD_CFI_STAA=m
CONFIG_MTD_CFI_UTIL=m
CONFIG_MTD_RAM=m
CONFIG_MTD_ROM=m
CONFIG_MTD_ABSENT=m
# end of RAM/ROM/Flash chip drivers

#
# Mapping drivers for chip access
#
CONFIG_MTD_COMPLEX_MAPPINGS=y
# CONFIG_MTD_PHYSMAP is not set
CONFIG_MTD_SUN_UFLASH=m
# CONFIG_MTD_SC520CDP is not set
CONFIG_MTD_NETSC520=m
CONFIG_MTD_TS5500=m
CONFIG_MTD_PCI=m
CONFIG_MTD_PCMCIA=m
CONFIG_MTD_PCMCIA_ANONYMOUS=y
CONFIG_MTD_INTEL_VR_NOR=m
CONFIG_MTD_PLATRAM=m
# end of Mapping drivers for chip access

#
# Self-contained MTD device drivers
#
CONFIG_MTD_PMC551=m
# CONFIG_MTD_PMC551_BUGFIX is not set
CONFIG_MTD_PMC551_DEBUG=y
# CONFIG_MTD_SPEAR_SMI is not set
# CONFIG_MTD_SLRAM is not set
# CONFIG_MTD_PHRAM is not set
CONFIG_MTD_MTDRAM=m
CONFIG_MTDRAM_TOTAL_SIZE=4096
CONFIG_MTDRAM_ERASE_SIZE=128
# CONFIG_MTD_BLOCK2MTD is not set

#
# Disk-On-Chip Device Drivers
#
CONFIG_MTD_DOCG3=m
CONFIG_BCH_CONST_M=14
CONFIG_BCH_CONST_T=4
# end of Self-contained MTD device drivers

#
# NAND
#
CONFIG_MTD_NAND_CORE=m
# CONFIG_MTD_ONENAND is not set
CONFIG_MTD_RAW_NAND=m

#
# Raw/parallel NAND flash controllers
#
CONFIG_MTD_NAND_DENALI=m
CONFIG_MTD_NAND_DENALI_PCI=m
CONFIG_MTD_NAND_AMS_DELTA=m
CONFIG_MTD_NAND_SHARPSL=m
CONFIG_MTD_NAND_CAFE=m
# CONFIG_MTD_NAND_ATMEL is not set
CONFIG_MTD_NAND_MARVELL=m
# CONFIG_MTD_NAND_SLC_LPC32XX is not set
CONFIG_MTD_NAND_MLC_LPC32XX=m
# CONFIG_MTD_NAND_BRCMNAND is not set
# CONFIG_MTD_NAND_OXNAS is not set
CONFIG_MTD_NAND_FSL_IFC=m
CONFIG_MTD_NAND_VF610_NFC=m
# CONFIG_MTD_NAND_MXC is not set
# CONFIG_MTD_NAND_SH_FLCTL is not set
CONFIG_MTD_NAND_DAVINCI=m
CONFIG_MTD_NAND_TXX9NDFMC=m
CONFIG_MTD_NAND_JZ4780=m
CONFIG_MTD_NAND_INGENIC_ECC=y
CONFIG_MTD_NAND_JZ4740_ECC=m
CONFIG_MTD_NAND_JZ4725B_BCH=m
# CONFIG_MTD_NAND_JZ4780_BCH is not set
CONFIG_MTD_NAND_FSMC=m
CONFIG_MTD_NAND_SUNXI=m
CONFIG_MTD_NAND_HISI504=m
CONFIG_MTD_NAND_QCOM=m
CONFIG_MTD_NAND_MXIC=m
# CONFIG_MTD_NAND_TEGRA is not set
# CONFIG_MTD_NAND_STM32_FMC2 is not set
# CONFIG_MTD_NAND_MESON is not set
CONFIG_MTD_NAND_GPIO=m
CONFIG_MTD_NAND_PLATFORM=m
CONFIG_MTD_NAND_CADENCE=m
CONFIG_MTD_NAND_ARASAN=m
# CONFIG_MTD_NAND_INTEL_LGM is not set
# CONFIG_MTD_NAND_RENESAS is not set

#
# Misc
#
CONFIG_MTD_SM_COMMON=m
CONFIG_MTD_NAND_NANDSIM=m
CONFIG_MTD_NAND_RICOH=m
# CONFIG_MTD_NAND_DISKONCHIP is not set

#
# ECC engine support
#
CONFIG_MTD_NAND_ECC=y
CONFIG_MTD_NAND_ECC_SW_HAMMING=y
# CONFIG_MTD_NAND_ECC_SW_HAMMING_SMC is not set
# CONFIG_MTD_NAND_ECC_SW_BCH is not set
# CONFIG_MTD_NAND_ECC_MXIC is not set
# CONFIG_MTD_NAND_ECC_MEDIATEK is not set
# end of ECC engine support
# end of NAND

#
# LPDDR & LPDDR2 PCM memory drivers
#
CONFIG_MTD_LPDDR=m
CONFIG_MTD_QINFO_PROBE=m
# end of LPDDR & LPDDR2 PCM memory drivers

# CONFIG_MTD_UBI is not set
CONFIG_MTD_HYPERBUS=m
CONFIG_HBMC_AM654=m
CONFIG_OF=y
# CONFIG_OF_ALL_DTBS is not set
CONFIG_OF_PROMTREE=y
CONFIG_OF_KOBJ=y
# CONFIG_OF_OVERLAY is not set
# CONFIG_PARPORT is not set
# CONFIG_BLK_DEV is not set

#
# NVME Support
#
CONFIG_NVME_CORE=y
CONFIG_BLK_DEV_NVME=m
# CONFIG_NVME_MULTIPATH is not set
# CONFIG_NVME_VERBOSE_ERRORS is not set
# CONFIG_NVME_HWMON is not set
CONFIG_NVME_FABRICS=y
CONFIG_NVME_FC=m
CONFIG_NVME_TCP=y
CONFIG_NVME_TARGET=y
# CONFIG_NVME_TARGET_PASSTHRU is not set
CONFIG_NVME_TARGET_LOOP=m
CONFIG_NVME_TARGET_FC=y
CONFIG_NVME_TARGET_FCLOOP=m
CONFIG_NVME_TARGET_TCP=y
# end of NVME Support

#
# Misc devices
#
CONFIG_AD525X_DPOT=y
CONFIG_AD525X_DPOT_I2C=m
CONFIG_DUMMY_IRQ=y
# CONFIG_PHANTOM is not set
CONFIG_TIFM_CORE=m
CONFIG_TIFM_7XX1=m
# CONFIG_ICS932S401 is not set
# CONFIG_ATMEL_SSC is not set
CONFIG_ENCLOSURE_SERVICES=y
CONFIG_HP_ILO=y
# CONFIG_QCOM_COINCELL is not set
CONFIG_QCOM_FASTRPC=y
# CONFIG_APDS9802ALS is not set
CONFIG_ISL29003=y
CONFIG_ISL29020=m
# CONFIG_SENSORS_TSL2550 is not set
# CONFIG_SENSORS_BH1770 is not set
# CONFIG_SENSORS_APDS990X is not set
CONFIG_HMC6352=m
CONFIG_DS1682=y
CONFIG_PCH_PHUB=y
# CONFIG_SRAM is not set
# CONFIG_DW_XDATA_PCIE is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
CONFIG_XILINX_SDFEC=y
# CONFIG_C2PORT is not set

#
# EEPROM support
#
# CONFIG_EEPROM_AT24 is not set
# CONFIG_EEPROM_LEGACY is not set
# CONFIG_EEPROM_MAX6875 is not set
CONFIG_EEPROM_93CX6=m
# CONFIG_EEPROM_IDT_89HPESX is not set
CONFIG_EEPROM_EE1004=m
# end of EEPROM support

CONFIG_CB710_CORE=y
# CONFIG_CB710_DEBUG is not set
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
# end of Texas Instruments shared transport line discipline

# CONFIG_SENSORS_LIS3_I2C is not set
CONFIG_ALTERA_STAPL=m
CONFIG_ECHO=y
# CONFIG_BCM_VK is not set
# CONFIG_MISC_ALCOR_PCI is not set
# CONFIG_MISC_RTSX_PCI is not set
CONFIG_HABANA_AI=y
CONFIG_UACCE=y
# CONFIG_PVPANIC is not set
# end of Misc devices

#
# SCSI device support
#
CONFIG_SCSI_MOD=m
CONFIG_RAID_ATTRS=m
CONFIG_SCSI_COMMON=m
CONFIG_SCSI=m
CONFIG_SCSI_DMA=y
CONFIG_SCSI_NETLINK=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
CONFIG_CHR_DEV_ST=m
# CONFIG_CHR_DEV_SG is not set
CONFIG_BLK_DEV_BSG=y
CONFIG_CHR_DEV_SCH=m
CONFIG_SCSI_ENCLOSURE=m
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
# CONFIG_SCSI_SCAN_ASYNC is not set

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=m
CONFIG_SCSI_FC_ATTRS=m
CONFIG_SCSI_ISCSI_ATTRS=m
CONFIG_SCSI_SAS_ATTRS=m
CONFIG_SCSI_SAS_LIBSAS=m
CONFIG_SCSI_SAS_ATA=y
# CONFIG_SCSI_SAS_HOST_SMP is not set
# CONFIG_SCSI_SRP_ATTRS is not set
# end of SCSI Transports

CONFIG_SCSI_LOWLEVEL=y
CONFIG_ISCSI_TCP=m
CONFIG_ISCSI_BOOT_SYSFS=m
# CONFIG_SCSI_CXGB3_ISCSI is not set
CONFIG_SCSI_CXGB4_ISCSI=m
# CONFIG_SCSI_BNX2_ISCSI is not set
CONFIG_SCSI_BNX2X_FCOE=m
CONFIG_BE2ISCSI=m
CONFIG_BLK_DEV_3W_XXXX_RAID=m
CONFIG_SCSI_HPSA=m
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_3W_SAS is not set
CONFIG_SCSI_ACARD=m
CONFIG_SCSI_AACRAID=m
CONFIG_SCSI_AIC7XXX=m
CONFIG_AIC7XXX_CMDS_PER_DEVICE=32
CONFIG_AIC7XXX_RESET_DELAY_MS=5000
# CONFIG_AIC7XXX_DEBUG_ENABLE is not set
CONFIG_AIC7XXX_DEBUG_MASK=0
# CONFIG_AIC7XXX_REG_PRETTY_PRINT is not set
CONFIG_SCSI_AIC79XX=m
CONFIG_AIC79XX_CMDS_PER_DEVICE=32
CONFIG_AIC79XX_RESET_DELAY_MS=5000
# CONFIG_AIC79XX_DEBUG_ENABLE is not set
CONFIG_AIC79XX_DEBUG_MASK=0
CONFIG_AIC79XX_REG_PRETTY_PRINT=y
CONFIG_SCSI_AIC94XX=m
# CONFIG_AIC94XX_DEBUG is not set
# CONFIG_SCSI_HISI_SAS is not set
CONFIG_SCSI_MVSAS=m
CONFIG_SCSI_MVSAS_DEBUG=y
CONFIG_SCSI_MVSAS_TASKLET=y
CONFIG_SCSI_MVUMI=m
CONFIG_SCSI_ADVANSYS=m
CONFIG_SCSI_ARCMSR=m
CONFIG_SCSI_ESAS2R=m
# CONFIG_MEGARAID_NEWGEN is not set
CONFIG_MEGARAID_LEGACY=m
CONFIG_MEGARAID_SAS=m
CONFIG_SCSI_MPT3SAS=m
CONFIG_SCSI_MPT2SAS_MAX_SGE=128
CONFIG_SCSI_MPT3SAS_MAX_SGE=128
CONFIG_SCSI_MPT2SAS=m
# CONFIG_SCSI_MPI3MR is not set
# CONFIG_SCSI_SMARTPQI is not set
CONFIG_SCSI_HPTIOP=m
CONFIG_SCSI_MYRB=m
CONFIG_SCSI_MYRS=m
CONFIG_LIBFC=m
CONFIG_LIBFCOE=m
# CONFIG_FCOE is not set
CONFIG_SCSI_SNIC=m
CONFIG_SCSI_SNIC_DEBUG_FS=y
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_FDOMAIN_PCI is not set
CONFIG_SCSI_IPS=m
CONFIG_SCSI_INITIO=m
# CONFIG_SCSI_INIA100 is not set
CONFIG_SCSI_STEX=m
# CONFIG_SCSI_SYM53C8XX_2 is not set
CONFIG_SCSI_IPR=m
# CONFIG_SCSI_IPR_TRACE is not set
CONFIG_SCSI_IPR_DUMP=y
CONFIG_SCSI_QLOGIC_1280=m
CONFIG_SCSI_QLOGICPTI=m
# CONFIG_SCSI_QLA_FC is not set
CONFIG_SCSI_QLA_ISCSI=m
# CONFIG_QEDI is not set
CONFIG_QEDF=m
# CONFIG_SCSI_EFCT is not set
CONFIG_SCSI_DC395x=m
# CONFIG_SCSI_AM53C974 is not set
CONFIG_SCSI_NSP32=m
CONFIG_SCSI_WD719X=m
CONFIG_SCSI_DEBUG=m
# CONFIG_SCSI_SUNESP is not set
# CONFIG_SCSI_PMCRAID is not set
CONFIG_SCSI_PM8001=m
CONFIG_SCSI_BFA_FC=m
CONFIG_SCSI_VIRTIO=m
CONFIG_SCSI_CHELSIO_FCOE=m
# CONFIG_SCSI_LOWLEVEL_PCMCIA is not set
# CONFIG_SCSI_DH is not set
# end of SCSI device support

CONFIG_ATA=m
CONFIG_SATA_HOST=y
CONFIG_PATA_TIMINGS=y
# CONFIG_ATA_VERBOSE_ERROR is not set
# CONFIG_ATA_FORCE is not set
# CONFIG_SATA_PMP is not set

#
# Controllers with non-SFF native interface
#
# CONFIG_SATA_AHCI is not set
CONFIG_SATA_AHCI_PLATFORM=m
# CONFIG_AHCI_BRCM is not set
# CONFIG_AHCI_DA850 is not set
# CONFIG_AHCI_DM816 is not set
CONFIG_AHCI_IMX=m
# CONFIG_AHCI_CEVA is not set
# CONFIG_AHCI_MTK is not set
# CONFIG_AHCI_MVEBU is not set
# CONFIG_AHCI_SUNXI is not set
# CONFIG_AHCI_TEGRA is not set
# CONFIG_AHCI_XGENE is not set
CONFIG_AHCI_QORIQ=m
# CONFIG_SATA_FSL is not set
CONFIG_SATA_GEMINI=m
# CONFIG_SATA_AHCI_SEATTLE is not set
CONFIG_SATA_INIC162X=m
# CONFIG_SATA_ACARD_AHCI is not set
CONFIG_SATA_SIL24=m
CONFIG_ATA_SFF=y

#
# SFF controllers with custom DMA interface
#
# CONFIG_PDC_ADMA is not set
CONFIG_SATA_QSTOR=m
# CONFIG_SATA_SX4 is not set
CONFIG_ATA_BMDMA=y

#
# SATA SFF controllers with BMDMA
#
CONFIG_ATA_PIIX=m
# CONFIG_SATA_HIGHBANK is not set
# CONFIG_SATA_MV is not set
# CONFIG_SATA_NV is not set
CONFIG_SATA_PROMISE=m
CONFIG_SATA_RCAR=m
CONFIG_SATA_SIL=m
CONFIG_SATA_SIS=m
CONFIG_SATA_SVW=m
# CONFIG_SATA_ULI is not set
CONFIG_SATA_VIA=m
CONFIG_SATA_VITESSE=m

#
# PATA SFF controllers with BMDMA
#
# CONFIG_PATA_ALI is not set
CONFIG_PATA_AMD=m
CONFIG_PATA_ARTOP=m
CONFIG_PATA_ATIIXP=m
CONFIG_PATA_ATP867X=m
# CONFIG_PATA_BK3710 is not set
# CONFIG_PATA_CMD64X is not set
# CONFIG_PATA_CS5520 is not set
CONFIG_PATA_CS5530=m
# CONFIG_PATA_CS5536 is not set
# CONFIG_PATA_CYPRESS is not set
CONFIG_PATA_EFAR=m
# CONFIG_PATA_FTIDE010 is not set
CONFIG_PATA_HPT366=m
CONFIG_PATA_HPT37X=m
CONFIG_PATA_HPT3X2N=m
CONFIG_PATA_HPT3X3=m
CONFIG_PATA_HPT3X3_DMA=y
# CONFIG_PATA_IMX is not set
CONFIG_PATA_IT8213=m
CONFIG_PATA_IT821X=m
CONFIG_PATA_JMICRON=m
# CONFIG_PATA_MARVELL is not set
# CONFIG_PATA_NETCELL is not set
CONFIG_PATA_NINJA32=m
# CONFIG_PATA_NS87415 is not set
CONFIG_PATA_OLDPIIX=m
CONFIG_PATA_OPTIDMA=m
CONFIG_PATA_PDC2027X=m
CONFIG_PATA_PDC_OLD=m
# CONFIG_PATA_RADISYS is not set
CONFIG_PATA_RDC=m
CONFIG_PATA_SC1200=m
CONFIG_PATA_SCH=m
# CONFIG_PATA_SERVERWORKS is not set
CONFIG_PATA_SIL680=m
CONFIG_PATA_SIS=m
CONFIG_PATA_TOSHIBA=m
# CONFIG_PATA_TRIFLEX is not set
CONFIG_PATA_VIA=m
# CONFIG_PATA_PXA is not set
CONFIG_PATA_WINBOND=m

#
# PIO-only SFF controllers
#
# CONFIG_PATA_CMD640_PCI is not set
# CONFIG_PATA_IXP4XX_CF is not set
CONFIG_PATA_MPIIX=m
CONFIG_PATA_NS87410=m
CONFIG_PATA_OPTI=m
CONFIG_PATA_PCMCIA=m
CONFIG_PATA_PLATFORM=m
CONFIG_PATA_OF_PLATFORM=m
CONFIG_PATA_RZ1000=m
# CONFIG_PATA_SAMSUNG_CF is not set

#
# Generic fallback / legacy drivers
#
CONFIG_ATA_GENERIC=m
# CONFIG_PATA_LEGACY is not set
CONFIG_MD=y
CONFIG_BLK_DEV_MD=m
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID10=m
CONFIG_MD_RAID456=m
# CONFIG_MD_MULTIPATH is not set
CONFIG_MD_FAULTY=m
CONFIG_BCACHE=m
# CONFIG_BCACHE_DEBUG is not set
CONFIG_BCACHE_CLOSURES_DEBUG=y
# CONFIG_BCACHE_ASYNC_REGISTRATION is not set
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_BLK_DEV_DM=m
CONFIG_DM_DEBUG=y
CONFIG_DM_BUFIO=m
CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING=y
CONFIG_DM_BIO_PRISON=m
CONFIG_DM_PERSISTENT_DATA=m
# CONFIG_DM_UNSTRIPED is not set
CONFIG_DM_CRYPT=m
CONFIG_DM_SNAPSHOT=m
# CONFIG_DM_THIN_PROVISIONING is not set
CONFIG_DM_CACHE=m
CONFIG_DM_CACHE_SMQ=m
# CONFIG_DM_WRITECACHE is not set
# CONFIG_DM_ERA is not set
# CONFIG_DM_CLONE is not set
CONFIG_DM_MIRROR=m
CONFIG_DM_LOG_USERSPACE=m
CONFIG_DM_RAID=m
CONFIG_DM_ZERO=m
# CONFIG_DM_MULTIPATH is not set
CONFIG_DM_DELAY=m
CONFIG_DM_DUST=m
CONFIG_DM_UEVENT=y
# CONFIG_DM_FLAKEY is not set
CONFIG_DM_VERITY=m
CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG=y
# CONFIG_DM_VERITY_FEC is not set
# CONFIG_DM_SWITCH is not set
CONFIG_DM_LOG_WRITES=m
# CONFIG_DM_INTEGRITY is not set
# CONFIG_DM_ZONED is not set
CONFIG_TARGET_CORE=m
CONFIG_TCM_IBLOCK=m
CONFIG_TCM_FILEIO=m
CONFIG_TCM_PSCSI=m
CONFIG_TCM_USER2=m
# CONFIG_LOOPBACK_TARGET is not set
CONFIG_TCM_FC=m
CONFIG_ISCSI_TARGET=m
# CONFIG_ISCSI_TARGET_CXGB4 is not set
# CONFIG_SBP_TARGET is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=m
# CONFIG_FIREWIRE_OHCI is not set
CONFIG_FIREWIRE_SBP2=m
CONFIG_FIREWIRE_NET=m
CONFIG_FIREWIRE_NOSY=y
# end of IEEE 1394 (FireWire) support

CONFIG_NETDEVICES=y
CONFIG_MII=y
# CONFIG_NET_CORE is not set
CONFIG_ARCNET=y
CONFIG_ARCNET_1201=m
CONFIG_ARCNET_1051=m
CONFIG_ARCNET_RAW=y
CONFIG_ARCNET_CAP=m
CONFIG_ARCNET_COM90xx=m
CONFIG_ARCNET_COM90xxIO=y
CONFIG_ARCNET_RIM_I=y

#
# Distributed Switch Architecture drivers
#
CONFIG_B53=m
CONFIG_B53_MDIO_DRIVER=m
CONFIG_B53_MMAP_DRIVER=m
# CONFIG_B53_SRAB_DRIVER is not set
# CONFIG_B53_SERDES is not set
CONFIG_NET_DSA_BCM_SF2=m
# CONFIG_NET_DSA_LOOP is not set
CONFIG_NET_DSA_LANTIQ_GSWIP=m
# CONFIG_NET_DSA_MT7530 is not set
# CONFIG_NET_DSA_MV88E6060 is not set
# CONFIG_NET_DSA_MICROCHIP_KSZ9477 is not set
# CONFIG_NET_DSA_MICROCHIP_KSZ8795 is not set
# CONFIG_NET_DSA_MV88E6XXX is not set
# CONFIG_NET_DSA_MSCC_FELIX is not set
CONFIG_NET_DSA_MSCC_SEVILLE=m
CONFIG_NET_DSA_AR9331=m
# CONFIG_NET_DSA_XRS700X_I2C is not set
# CONFIG_NET_DSA_XRS700X_MDIO is not set
CONFIG_NET_DSA_QCA8K=m
# CONFIG_NET_DSA_REALTEK is not set
CONFIG_NET_DSA_SMSC_LAN9303=m
CONFIG_NET_DSA_SMSC_LAN9303_I2C=m
CONFIG_NET_DSA_SMSC_LAN9303_MDIO=m
# CONFIG_NET_DSA_VITESSE_VSC73XX_PLATFORM is not set
# end of Distributed Switch Architecture drivers

CONFIG_ETHERNET=y
CONFIG_MDIO=y
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_NET_VENDOR_ACTIONS is not set
CONFIG_NET_VENDOR_ADAPTEC=y
CONFIG_ADAPTEC_STARFIRE=m
CONFIG_GRETH=m
CONFIG_NET_VENDOR_AGERE=y
CONFIG_ET131X=m
# CONFIG_NET_VENDOR_ALACRITECH is not set
CONFIG_NET_VENDOR_ALTEON=y
CONFIG_ACENIC=m
# CONFIG_ACENIC_OMIT_TIGON_I is not set
CONFIG_ALTERA_TSE=y
# CONFIG_NET_VENDOR_AMAZON is not set
# CONFIG_NET_VENDOR_AMD is not set
CONFIG_NET_XGENE=y
CONFIG_NET_XGENE_V2=m
# CONFIG_NET_VENDOR_AQUANTIA is not set
# CONFIG_NET_VENDOR_ARC is not set
CONFIG_NET_VENDOR_ASIX=y
# CONFIG_NET_VENDOR_ATHEROS is not set
CONFIG_CX_ECAT=m
CONFIG_NET_VENDOR_BROADCOM=y
CONFIG_B44=y
CONFIG_B44_PCI_AUTOSELECT=y
CONFIG_B44_PCICORE_AUTOSELECT=y
CONFIG_B44_PCI=y
# CONFIG_BCM4908_ENET is not set
CONFIG_BCMGENET=m
CONFIG_BNX2=y
CONFIG_CNIC=y
# CONFIG_TIGON3 is not set
CONFIG_BNX2X=m
# CONFIG_BNX2X_SRIOV is not set
# CONFIG_BGMAC_PLATFORM is not set
CONFIG_SYSTEMPORT=m
CONFIG_BNXT=m
# CONFIG_BNXT_SRIOV is not set
CONFIG_BNXT_FLOWER_OFFLOAD=y
# CONFIG_BNXT_HWMON is not set
# CONFIG_NET_VENDOR_CADENCE is not set
CONFIG_NET_CALXEDA_XGMAC=y
# CONFIG_NET_VENDOR_CAVIUM is not set
CONFIG_NET_VENDOR_CHELSIO=y
CONFIG_CHELSIO_T1=y
# CONFIG_CHELSIO_T1_1G is not set
CONFIG_CHELSIO_T3=m
CONFIG_CHELSIO_T4=m
CONFIG_CHELSIO_T4VF=m
CONFIG_CHELSIO_LIB=m
# CONFIG_CHELSIO_INLINE_CRYPTO is not set
CONFIG_NET_VENDOR_CIRRUS=y
# CONFIG_CS89x0_PLATFORM is not set
# CONFIG_EP93XX_ETH is not set
# CONFIG_NET_VENDOR_CISCO is not set
CONFIG_NET_VENDOR_CORTINA=y
# CONFIG_GEMINI_ETHERNET is not set
CONFIG_NET_VENDOR_DAVICOM=y
# CONFIG_DM9000 is not set
CONFIG_DNET=y
# CONFIG_NET_VENDOR_DEC is not set
# CONFIG_NET_VENDOR_DLINK is not set
# CONFIG_NET_VENDOR_EMULEX is not set
CONFIG_NET_VENDOR_ENGLEDER=y
# CONFIG_TSNEP is not set
# CONFIG_NET_VENDOR_EZCHIP is not set
CONFIG_NET_VENDOR_FARADAY=y
CONFIG_FTMAC100=y
# CONFIG_FTGMAC100 is not set
CONFIG_NET_VENDOR_FREESCALE=y
CONFIG_FEC=m
CONFIG_FSL_FMAN=m
CONFIG_FSL_PQ_MDIO=y
# CONFIG_FSL_XGMAC_MDIO is not set
CONFIG_GIANFAR=y
# CONFIG_FSL_DPAA2_SWITCH is not set
# CONFIG_FSL_ENETC is not set
CONFIG_FSL_ENETC_VF=y
# CONFIG_FSL_ENETC_IERB is not set
CONFIG_FSL_ENETC_MDIO=y
CONFIG_FSL_ENETC_QOS=y
# CONFIG_NET_VENDOR_FUJITSU is not set
CONFIG_NET_VENDOR_FUNGIBLE=y
# CONFIG_FUN_ETH is not set
# CONFIG_NET_VENDOR_GOOGLE is not set
CONFIG_NET_VENDOR_HISILICON=y
# CONFIG_HIX5HD2_GMAC is not set
CONFIG_HISI_FEMAC=y
CONFIG_HIP04_ETH=y
CONFIG_HI13X1_GMAC=y
CONFIG_HNS_MDIO=y
CONFIG_HNS=y
CONFIG_HNS_DSAF=y
# CONFIG_HNS_ENET is not set
CONFIG_HNS3=m
# CONFIG_HNS3_HCLGE is not set
# CONFIG_NET_VENDOR_HUAWEI is not set
CONFIG_NET_VENDOR_I825XX=y
CONFIG_NET_VENDOR_INTEL=y
CONFIG_E100=m
CONFIG_E1000=y
CONFIG_IGB=m
CONFIG_IGB_HWMON=y
# CONFIG_IGBVF is not set
CONFIG_IXGB=m
# CONFIG_IXGBE is not set
# CONFIG_IXGBEVF is not set
CONFIG_I40E=y
CONFIG_IAVF=y
CONFIG_I40EVF=y
# CONFIG_ICE is not set
CONFIG_FM10K=m
CONFIG_IGC=m
CONFIG_JME=m
# CONFIG_KORINA is not set
CONFIG_NET_VENDOR_LITEX=y
# CONFIG_LITEX_LITEETH is not set
# CONFIG_NET_VENDOR_MARVELL is not set
# CONFIG_NET_VENDOR_MEDIATEK is not set
CONFIG_NET_VENDOR_MELLANOX=y
CONFIG_MLX4_EN=y
CONFIG_MLX4_CORE=y
# CONFIG_MLX4_DEBUG is not set
# CONFIG_MLX4_CORE_GEN2 is not set
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
# CONFIG_MLXBF_GIGE is not set
# CONFIG_NET_VENDOR_MICREL is not set
# CONFIG_NET_VENDOR_MICROCHIP is not set
CONFIG_NET_VENDOR_MICROSEMI=y
CONFIG_MSCC_OCELOT_SWITCH_LIB=m
# CONFIG_MSCC_OCELOT_SWITCH is not set
CONFIG_NET_VENDOR_MICROSOFT=y
# CONFIG_NET_VENDOR_MYRI is not set
CONFIG_FEALNX=y
CONFIG_NET_VENDOR_NI=y
CONFIG_NI_XGE_MANAGEMENT_ENET=m
CONFIG_NET_VENDOR_NATSEMI=y
CONFIG_NATSEMI=m
CONFIG_NS83820=y
CONFIG_NET_VENDOR_NETERION=y
# CONFIG_S2IO is not set
# CONFIG_VXGE is not set
# CONFIG_NET_VENDOR_NETRONOME is not set
CONFIG_NET_VENDOR_8390=y
# CONFIG_PCMCIA_AXNET is not set
CONFIG_AX88796=m
# CONFIG_AX88796_93CX6 is not set
CONFIG_NE2K_PCI=m
# CONFIG_PCMCIA_PCNET is not set
# CONFIG_NET_VENDOR_NVIDIA is not set
# CONFIG_LPC_ENET is not set
CONFIG_NET_VENDOR_OKI=y
CONFIG_ETHOC=y
# CONFIG_NET_VENDOR_PACKET_ENGINES is not set
CONFIG_NET_VENDOR_PENSANDO=y
CONFIG_NET_VENDOR_QLOGIC=y
# CONFIG_QLA3XXX is not set
CONFIG_QLCNIC=y
CONFIG_QLCNIC_SRIOV=y
CONFIG_QLCNIC_HWMON=y
# CONFIG_NETXEN_NIC is not set
CONFIG_QED=m
CONFIG_QED_LL2=y
# CONFIG_QED_SRIOV is not set
CONFIG_QEDE=m
CONFIG_QED_FCOE=y
# CONFIG_NET_VENDOR_BROCADE is not set
CONFIG_NET_VENDOR_QUALCOMM=y
CONFIG_QCA7000=m
CONFIG_QCA7000_UART=m
CONFIG_QCOM_EMAC=m
CONFIG_RMNET=m
# CONFIG_NET_VENDOR_RDC is not set
# CONFIG_NET_VENDOR_REALTEK is not set
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_SH_ETH=y
# CONFIG_RAVB is not set
# CONFIG_NET_VENDOR_ROCKER is not set
# CONFIG_NET_VENDOR_SAMSUNG is not set
# CONFIG_NET_VENDOR_SEEQ is not set
CONFIG_NET_VENDOR_SILAN=y
CONFIG_SC92031=m
# CONFIG_NET_VENDOR_SIS is not set
CONFIG_NET_VENDOR_SOLARFLARE=y
CONFIG_SFC=y
CONFIG_SFC_MCDI_MON=y
# CONFIG_SFC_SRIOV is not set
CONFIG_SFC_MCDI_LOGGING=y
# CONFIG_SFC_FALCON is not set
CONFIG_NET_VENDOR_SMSC=y
# CONFIG_SMC91X is not set
# CONFIG_PCMCIA_SMC91C92 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SMC911X is not set
CONFIG_SMSC911X=m
CONFIG_SMSC9420=m
# CONFIG_NET_VENDOR_SOCIONEXT is not set
# CONFIG_NET_VENDOR_STMICRO is not set
# CONFIG_NET_VENDOR_SUN is not set
CONFIG_NET_VENDOR_SUNPLUS=y
# CONFIG_SP7021_EMAC is not set
# CONFIG_NET_VENDOR_SYNOPSYS is not set
# CONFIG_NET_VENDOR_TEHUTI is not set
CONFIG_NET_VENDOR_TI=y
# CONFIG_TI_DAVINCI_EMAC is not set
CONFIG_TI_DAVINCI_MDIO=y
CONFIG_TI_CPSW_PHY_SEL=y
# CONFIG_TI_CPSW is not set
CONFIG_TI_CPSW_SWITCHDEV=m
CONFIG_TLAN=y
CONFIG_NET_VENDOR_VERTEXCOM=y
CONFIG_NET_VENDOR_VIA=y
# CONFIG_VIA_RHINE is not set
CONFIG_VIA_VELOCITY=y
# CONFIG_NET_VENDOR_WIZNET is not set
CONFIG_NET_VENDOR_XILINX=y
# CONFIG_XILINX_EMACLITE is not set
CONFIG_XILINX_AXI_EMAC=y
CONFIG_XILINX_LL_TEMAC=y
CONFIG_NET_VENDOR_XIRCOM=y
# CONFIG_PCMCIA_XIRC2PS is not set
CONFIG_FDDI=y
CONFIG_DEFXX=m
CONFIG_SKFP=m
CONFIG_HIPPI=y
CONFIG_ROADRUNNER=m
# CONFIG_ROADRUNNER_LARGE_RINGS is not set
CONFIG_PHYLINK=y
CONFIG_PHYLIB=y
CONFIG_SWPHY=y
CONFIG_FIXED_PHY=y
CONFIG_SFP=y

#
# MII PHY device drivers
#
CONFIG_AMD_PHY=m
CONFIG_MESON_GXL_PHY=y
# CONFIG_ADIN_PHY is not set
# CONFIG_ADIN1100_PHY is not set
CONFIG_AQUANTIA_PHY=y
CONFIG_AX88796B_PHY=y
CONFIG_BROADCOM_PHY=y
CONFIG_BCM54140_PHY=m
CONFIG_BCM63XX_PHY=y
CONFIG_BCM7XXX_PHY=y
# CONFIG_BCM84881_PHY is not set
CONFIG_BCM87XX_PHY=m
# CONFIG_BCM_CYGNUS_PHY is not set
CONFIG_BCM_NET_PHYLIB=y
CONFIG_CICADA_PHY=y
# CONFIG_CORTINA_PHY is not set
# CONFIG_DAVICOM_PHY is not set
CONFIG_ICPLUS_PHY=y
CONFIG_LXT_PHY=y
CONFIG_INTEL_XWAY_PHY=m
CONFIG_LSI_ET1011C_PHY=y
CONFIG_MARVELL_PHY=y
# CONFIG_MARVELL_10G_PHY is not set
# CONFIG_MARVELL_88X2222_PHY is not set
# CONFIG_MAXLINEAR_GPHY is not set
# CONFIG_MEDIATEK_GE_PHY is not set
# CONFIG_MICREL_PHY is not set
CONFIG_MICROCHIP_PHY=y
CONFIG_MICROCHIP_T1_PHY=y
CONFIG_MICROSEMI_PHY=m
# CONFIG_MOTORCOMM_PHY is not set
CONFIG_NATIONAL_PHY=m
# CONFIG_NXP_C45_TJA11XX_PHY is not set
# CONFIG_NXP_TJA11XX_PHY is not set
CONFIG_AT803X_PHY=m
CONFIG_QSEMI_PHY=y
CONFIG_REALTEK_PHY=m
CONFIG_RENESAS_PHY=y
CONFIG_ROCKCHIP_PHY=m
CONFIG_SMSC_PHY=m
CONFIG_STE10XP=y
CONFIG_TERANETICS_PHY=y
CONFIG_DP83822_PHY=y
# CONFIG_DP83TC811_PHY is not set
CONFIG_DP83848_PHY=y
# CONFIG_DP83867_PHY is not set
CONFIG_DP83869_PHY=y
# CONFIG_DP83TD510_PHY is not set
CONFIG_VITESSE_PHY=y
CONFIG_XILINX_GMII2RGMII=y
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
CONFIG_FWNODE_MDIO=y
CONFIG_OF_MDIO=y
CONFIG_MDIO_DEVRES=y
CONFIG_MDIO_SUN4I=y
CONFIG_MDIO_XGENE=y
CONFIG_MDIO_ASPEED=y
CONFIG_MDIO_BITBANG=y
CONFIG_MDIO_BCM_IPROC=y
CONFIG_MDIO_BCM_UNIMAC=m
# CONFIG_MDIO_GPIO is not set
# CONFIG_MDIO_HISI_FEMAC is not set
CONFIG_MDIO_I2C=y
CONFIG_MDIO_MSCC_MIIM=m
CONFIG_MDIO_MOXART=m
# CONFIG_MDIO_OCTEON is not set
CONFIG_MDIO_IPQ8064=m

#
# MDIO Multiplexers
#
CONFIG_MDIO_BUS_MUX=y
# CONFIG_MDIO_BUS_MUX_BCM6368 is not set
CONFIG_MDIO_BUS_MUX_BCM_IPROC=m
CONFIG_MDIO_BUS_MUX_GPIO=m
CONFIG_MDIO_BUS_MUX_MULTIPLEXER=m
CONFIG_MDIO_BUS_MUX_MMIOREG=y

#
# PCS device drivers
#
# CONFIG_PCS_XPCS is not set
CONFIG_PCS_LYNX=m
# end of PCS device drivers

CONFIG_PPP=y
CONFIG_PPP_BSDCOMP=y
CONFIG_PPP_DEFLATE=y
CONFIG_PPP_FILTER=y
CONFIG_PPP_MPPE=m
CONFIG_PPP_MULTILINK=y
CONFIG_PPPOE=y
# CONFIG_PPPOL2TP is not set
CONFIG_SLHC=y

#
# Host-side USB support is needed for USB Network Adapter support
#
CONFIG_WLAN=y
CONFIG_WLAN_VENDOR_ADMTEK=y
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
CONFIG_ATH5K_PCI=y
CONFIG_WLAN_VENDOR_ATMEL=y
# CONFIG_WLAN_VENDOR_BROADCOM is not set
# CONFIG_WLAN_VENDOR_CISCO is not set
# CONFIG_WLAN_VENDOR_INTEL is not set
CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
# CONFIG_WLAN_VENDOR_MARVELL is not set
CONFIG_WLAN_VENDOR_MEDIATEK=y
CONFIG_WLAN_VENDOR_MICROCHIP=y
CONFIG_WLAN_VENDOR_PURELIFI=y
# CONFIG_WLAN_VENDOR_RALINK is not set
# CONFIG_WLAN_VENDOR_REALTEK is not set
# CONFIG_WLAN_VENDOR_RSI is not set
CONFIG_WLAN_VENDOR_SILABS=y
# CONFIG_WLAN_VENDOR_ST is not set
# CONFIG_WLAN_VENDOR_TI is not set
# CONFIG_WLAN_VENDOR_ZYDAS is not set
CONFIG_WLAN_VENDOR_QUANTENNA=y
CONFIG_PCMCIA_RAYCS=m
CONFIG_WAN=y
CONFIG_HDLC=m
CONFIG_HDLC_RAW=m
CONFIG_HDLC_RAW_ETH=m
CONFIG_HDLC_CISCO=m
# CONFIG_HDLC_FR is not set
CONFIG_HDLC_PPP=m

#
# X.25/LAPB support is disabled
#
CONFIG_PCI200SYN=m
CONFIG_WANXL=m
CONFIG_PC300TOO=m
CONFIG_FARSYNC=m
CONFIG_IEEE802154_DRIVERS=m
CONFIG_IEEE802154_FAKELB=m
CONFIG_IEEE802154_HWSIM=m

#
# Wireless WAN
#
# CONFIG_WWAN is not set
# end of Wireless WAN

CONFIG_VMXNET3=y
CONFIG_NETDEVSIM=m
CONFIG_NET_FAILOVER=y
CONFIG_ISDN=y
CONFIG_ISDN_CAPI=y
# CONFIG_MISDN is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_FF_MEMLESS=y
CONFIG_INPUT_SPARSEKMAP=m
CONFIG_INPUT_MATRIXKMAP=y
CONFIG_INPUT_VIVALDIFMAP=y

#
# Userland interfaces
#
# CONFIG_INPUT_MOUSEDEV is not set
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
# CONFIG_INPUT_KEYBOARD is not set
# CONFIG_INPUT_MOUSE is not set
# CONFIG_INPUT_JOYSTICK is not set
CONFIG_INPUT_TABLET=y
CONFIG_TABLET_SERIAL_WACOM4=y
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
CONFIG_INPUT_88PM80X_ONKEY=m
# CONFIG_INPUT_AD714X is not set
# CONFIG_INPUT_ATMEL_CAPTOUCH is not set
CONFIG_INPUT_BMA150=m
CONFIG_INPUT_E3X0_BUTTON=y
CONFIG_INPUT_MAX77693_HAPTIC=y
# CONFIG_INPUT_MAX8925_ONKEY is not set
# CONFIG_INPUT_MAX8997_HAPTIC is not set
CONFIG_INPUT_MC13783_PWRBUTTON=m
CONFIG_INPUT_MMA8450=m
# CONFIG_INPUT_GPIO_BEEPER is not set
# CONFIG_INPUT_GPIO_DECODER is not set
CONFIG_INPUT_GPIO_VIBRA=y
CONFIG_INPUT_KXTJ9=y
CONFIG_INPUT_REGULATOR_HAPTIC=y
# CONFIG_INPUT_TPS65218_PWRBUTTON is not set
# CONFIG_INPUT_TWL6040_VIBRA is not set
CONFIG_INPUT_UINPUT=m
CONFIG_INPUT_PALMAS_PWRBUTTON=y
CONFIG_INPUT_PCF8574=m
# CONFIG_INPUT_PWM_BEEPER is not set
CONFIG_INPUT_PWM_VIBRA=y
# CONFIG_INPUT_GPIO_ROTARY_ENCODER is not set
# CONFIG_INPUT_DA7280_HAPTICS is not set
CONFIG_INPUT_DA9052_ONKEY=m
CONFIG_INPUT_DA9055_ONKEY=m
CONFIG_INPUT_DA9063_ONKEY=y
CONFIG_INPUT_ADXL34X=m
CONFIG_INPUT_ADXL34X_I2C=m
# CONFIG_INPUT_IQS269A is not set
# CONFIG_INPUT_IQS626A is not set
# CONFIG_INPUT_IQS7222 is not set
# CONFIG_INPUT_CMA3000 is not set
CONFIG_INPUT_IDEAPAD_SLIDEBAR=m
# CONFIG_INPUT_DRV260X_HAPTICS is not set
CONFIG_INPUT_DRV2665_HAPTICS=m
CONFIG_INPUT_DRV2667_HAPTICS=y
CONFIG_INPUT_HISI_POWERKEY=m
# CONFIG_INPUT_RAVE_SP_PWRBUTTON is not set
# CONFIG_INPUT_SC27XX_VIBRA is not set
CONFIG_RMI4_CORE=y
CONFIG_RMI4_I2C=y
# CONFIG_RMI4_SMB is not set
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=y
# CONFIG_RMI4_F11 is not set
# CONFIG_RMI4_F12 is not set
CONFIG_RMI4_F30=y
# CONFIG_RMI4_F34 is not set
CONFIG_RMI4_F3A=y
CONFIG_RMI4_F54=y
CONFIG_RMI4_F55=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=m
CONFIG_SERIO_PCIPS2=y
# CONFIG_SERIO_LIBPS2 is not set
CONFIG_SERIO_RAW=m
CONFIG_SERIO_ALTERA_PS2=m
# CONFIG_SERIO_PS2MULT is not set
CONFIG_SERIO_ARC_PS2=m
CONFIG_SERIO_APBPS2=y
# CONFIG_SERIO_OLPC_APSP is not set
# CONFIG_SERIO_SUN4I_PS2 is not set
CONFIG_SERIO_GPIO_PS2=m
CONFIG_USERIO=m
CONFIG_GAMEPORT=m
CONFIG_GAMEPORT_NS558=m
CONFIG_GAMEPORT_L4=m
CONFIG_GAMEPORT_EMU10K1=m
CONFIG_GAMEPORT_FM801=m
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
# CONFIG_TTY is not set
CONFIG_SERIAL_DEV_BUS=y
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_PLAT_DATA=y
CONFIG_IPMI_PANIC_EVENT=y
CONFIG_IPMI_PANIC_STRING=y
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_SI=m
# CONFIG_IPMI_SSIF is not set
# CONFIG_IPMI_IPMB is not set
CONFIG_IPMI_WATCHDOG=m
CONFIG_IPMI_POWEROFF=m
CONFIG_IPMI_KCS_BMC=y
CONFIG_ASPEED_KCS_IPMI_BMC=y
CONFIG_NPCM7XX_KCS_IPMI_BMC=y
# CONFIG_IPMI_KCS_BMC_CDEV_IPMI is not set
# CONFIG_IPMI_KCS_BMC_SERIO is not set
# CONFIG_ASPEED_BT_IPMI_BMC is not set
# CONFIG_IPMB_DEVICE_INTERFACE is not set
CONFIG_HW_RANDOM=m
CONFIG_HW_RANDOM_TIMERIOMEM=m
# CONFIG_HW_RANDOM_BA431 is not set
CONFIG_HW_RANDOM_BCM2835=m
CONFIG_HW_RANDOM_IPROC_RNG200=m
CONFIG_HW_RANDOM_IXP4XX=m
CONFIG_HW_RANDOM_OMAP=m
CONFIG_HW_RANDOM_OMAP3_ROM=m
# CONFIG_HW_RANDOM_VIRTIO is not set
CONFIG_HW_RANDOM_NOMADIK=m
CONFIG_HW_RANDOM_STM32=m
# CONFIG_HW_RANDOM_MESON is not set
CONFIG_HW_RANDOM_MTK=m
CONFIG_HW_RANDOM_EXYNOS=m
CONFIG_HW_RANDOM_NPCM=m
CONFIG_HW_RANDOM_KEYSTONE=m
CONFIG_HW_RANDOM_CCTRNG=m
CONFIG_HW_RANDOM_XIPHERA=m
CONFIG_APPLICOM=m

#
# PCMCIA character devices
#
CONFIG_CARDMAN_4000=m
CONFIG_CARDMAN_4040=m
CONFIG_SCR24X=m
# end of PCMCIA character devices

CONFIG_DEVMEM=y
CONFIG_DEVPORT=y
# CONFIG_TCG_TPM is not set
# CONFIG_XILLYBUS is not set
CONFIG_RANDOM_TRUST_BOOTLOADER=y
# end of Character devices

#
# I2C support
#
CONFIG_I2C=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_MUX=y

#
# Multiplexer I2C Chip support
#
CONFIG_I2C_ARB_GPIO_CHALLENGE=m
CONFIG_I2C_MUX_GPIO=y
CONFIG_I2C_MUX_GPMUX=m
CONFIG_I2C_MUX_LTC4306=y
# CONFIG_I2C_MUX_PCA9541 is not set
CONFIG_I2C_MUX_PCA954x=m
CONFIG_I2C_MUX_PINCTRL=m
CONFIG_I2C_MUX_REG=y
# CONFIG_I2C_DEMUX_PINCTRL is not set
CONFIG_I2C_MUX_MLXCPLD=y
# end of Multiplexer I2C Chip support

CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=y
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCA=y

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
CONFIG_I2C_CCGX_UCSI=y
CONFIG_I2C_ALI1535=y
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
CONFIG_I2C_AMD756=m
# CONFIG_I2C_AMD8111 is not set
CONFIG_I2C_HIX5HD2=y
CONFIG_I2C_I801=m
CONFIG_I2C_ISCH=y
CONFIG_I2C_PIIX4=m
CONFIG_I2C_NFORCE2=y
CONFIG_I2C_NVIDIA_GPU=y
CONFIG_I2C_SIS5595=y
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
CONFIG_I2C_VIA=y
# CONFIG_I2C_VIAPRO is not set

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
CONFIG_I2C_ALTERA=y
# CONFIG_I2C_ASPEED is not set
CONFIG_I2C_AT91=y
# CONFIG_I2C_AT91_SLAVE_EXPERIMENTAL is not set
CONFIG_I2C_AXXIA=y
CONFIG_I2C_BCM_IPROC=y
CONFIG_I2C_BCM_KONA=m
# CONFIG_I2C_BRCMSTB is not set
CONFIG_I2C_CADENCE=y
CONFIG_I2C_CBUS_GPIO=m
CONFIG_I2C_DAVINCI=y
CONFIG_I2C_DESIGNWARE_CORE=m
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
# CONFIG_I2C_DESIGNWARE_PLATFORM is not set
CONFIG_I2C_DESIGNWARE_PCI=m
# CONFIG_I2C_DIGICOLOR is not set
CONFIG_I2C_EG20T=m
CONFIG_I2C_EXYNOS5=m
CONFIG_I2C_GPIO=m
CONFIG_I2C_GPIO_FAULT_INJECTOR=y
CONFIG_I2C_HIGHLANDER=m
# CONFIG_I2C_HISI is not set
CONFIG_I2C_IMG=y
# CONFIG_I2C_IMX is not set
CONFIG_I2C_IMX_LPI2C=y
# CONFIG_I2C_IOP3XX is not set
CONFIG_I2C_JZ4780=y
CONFIG_I2C_KEMPLD=m
# CONFIG_I2C_LPC2K is not set
# CONFIG_I2C_MT65XX is not set
# CONFIG_I2C_MT7621 is not set
CONFIG_I2C_MV64XXX=m
# CONFIG_I2C_MXS is not set
# CONFIG_I2C_NPCM7XX is not set
# CONFIG_I2C_OCORES is not set
CONFIG_I2C_OMAP=m
CONFIG_I2C_OWL=y
# CONFIG_I2C_APPLE is not set
CONFIG_I2C_PCA_PLATFORM=y
CONFIG_I2C_PNX=m
CONFIG_I2C_PXA=y
# CONFIG_I2C_PXA_SLAVE is not set
CONFIG_I2C_QCOM_CCI=y
CONFIG_I2C_QCOM_GENI=y
# CONFIG_I2C_QUP is not set
CONFIG_I2C_RIIC=m
# CONFIG_I2C_S3C2410 is not set
# CONFIG_I2C_SH_MOBILE is not set
# CONFIG_I2C_SIMTEC is not set
# CONFIG_I2C_ST is not set
CONFIG_I2C_STM32F4=y
CONFIG_I2C_STM32F7=m
CONFIG_I2C_SUN6I_P2WI=m
CONFIG_I2C_SYNQUACER=m
CONFIG_I2C_TEGRA=m
CONFIG_I2C_TEGRA_BPMP=y
# CONFIG_I2C_UNIPHIER is not set
# CONFIG_I2C_UNIPHIER_F is not set
# CONFIG_I2C_VERSATILE is not set
# CONFIG_I2C_WMT is not set
# CONFIG_I2C_XILINX is not set
# CONFIG_I2C_XLP9XX is not set
CONFIG_I2C_RCAR=y

#
# External I2C/SMBus adapter drivers
#

#
# Other I2C/SMBus bus drivers
#
# CONFIG_I2C_MLXCPLD is not set
CONFIG_I2C_FSI=m
# CONFIG_I2C_VIRTIO is not set
# end of I2C Hardware Bus support

# CONFIG_I2C_STUB is not set
CONFIG_I2C_SLAVE=y
CONFIG_I2C_SLAVE_EEPROM=m
CONFIG_I2C_SLAVE_TESTUNIT=y
# CONFIG_I2C_DEBUG_CORE is not set
CONFIG_I2C_DEBUG_ALGO=y
CONFIG_I2C_DEBUG_BUS=y
# end of I2C support

# CONFIG_I3C is not set
# CONFIG_SPI is not set
# CONFIG_SPMI is not set
CONFIG_HSI=m
CONFIG_HSI_BOARDINFO=y

#
# HSI controllers
#

#
# HSI clients
#
# CONFIG_HSI_CHAR is not set
CONFIG_PPS=m
CONFIG_PPS_DEBUG=y
CONFIG_NTP_PPS=y

#
# PPS clients support
#
CONFIG_PPS_CLIENT_KTIMER=m
CONFIG_PPS_CLIENT_GPIO=m

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
CONFIG_GENERIC_PINCTRL_GROUPS=y
CONFIG_PINMUX=y
CONFIG_GENERIC_PINMUX_FUNCTIONS=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
CONFIG_PINCTRL_AMD=y
CONFIG_PINCTRL_AT91PIO4=y
CONFIG_PINCTRL_BM1880=y
# CONFIG_PINCTRL_DA850_PUPD is not set
CONFIG_PINCTRL_DA9062=m
CONFIG_PINCTRL_EQUILIBRIUM=y
# CONFIG_PINCTRL_INGENIC is not set
# CONFIG_PINCTRL_LPC18XX is not set
CONFIG_PINCTRL_MAX77620=y
# CONFIG_PINCTRL_MCP23S08 is not set
# CONFIG_PINCTRL_MICROCHIP_SGPIO is not set
CONFIG_PINCTRL_OCELOT=y
# CONFIG_PINCTRL_PALMAS is not set
# CONFIG_PINCTRL_PISTACHIO is not set
# CONFIG_PINCTRL_ROCKCHIP is not set
CONFIG_PINCTRL_SINGLE=y
# CONFIG_PINCTRL_STARFIVE is not set
CONFIG_PINCTRL_STMFX=m
# CONFIG_PINCTRL_SX150X is not set
# CONFIG_PINCTRL_OWL is not set
CONFIG_PINCTRL_ASPEED=y
CONFIG_PINCTRL_ASPEED_G4=y
# CONFIG_PINCTRL_ASPEED_G5 is not set
# CONFIG_PINCTRL_ASPEED_G6 is not set
CONFIG_PINCTRL_BCM281XX=y
# CONFIG_PINCTRL_BCM2835 is not set
# CONFIG_PINCTRL_BCM4908 is not set
# CONFIG_PINCTRL_BCM6318 is not set
# CONFIG_PINCTRL_BCM6328 is not set
# CONFIG_PINCTRL_BCM6358 is not set
# CONFIG_PINCTRL_BCM6362 is not set
# CONFIG_PINCTRL_BCM6368 is not set
# CONFIG_PINCTRL_BCM63268 is not set
# CONFIG_PINCTRL_IPROC_GPIO is not set
CONFIG_PINCTRL_CYGNUS_MUX=y
# CONFIG_PINCTRL_NS is not set
CONFIG_PINCTRL_NSP_GPIO=y
CONFIG_PINCTRL_NS2_MUX=y
# CONFIG_PINCTRL_NSP_MUX is not set
CONFIG_PINCTRL_BERLIN=y
CONFIG_PINCTRL_AS370=y
# CONFIG_PINCTRL_BERLIN_BG4CT is not set
CONFIG_PINCTRL_LOCHNAGAR=m
CONFIG_PINCTRL_MADERA=m
CONFIG_PINCTRL_CS47L35=y
CONFIG_PINCTRL_CS47L85=y
CONFIG_PINCTRL_CS47L92=y

#
# Intel pinctrl drivers
#
# end of Intel pinctrl drivers

#
# MediaTek pinctrl drivers
#
CONFIG_EINT_MTK=y
CONFIG_PINCTRL_MTK=y
CONFIG_PINCTRL_MTK_V2=y
CONFIG_PINCTRL_MTK_MOORE=y
CONFIG_PINCTRL_MTK_PARIS=y
# CONFIG_PINCTRL_MT2701 is not set
# CONFIG_PINCTRL_MT7623 is not set
CONFIG_PINCTRL_MT7629=y
# CONFIG_PINCTRL_MT8135 is not set
# CONFIG_PINCTRL_MT8127 is not set
CONFIG_PINCTRL_MT2712=y
# CONFIG_PINCTRL_MT6765 is not set
# CONFIG_PINCTRL_MT6779 is not set
# CONFIG_PINCTRL_MT6795 is not set
# CONFIG_PINCTRL_MT6797 is not set
# CONFIG_PINCTRL_MT7622 is not set
# CONFIG_PINCTRL_MT7986 is not set
CONFIG_PINCTRL_MT8167=y
# CONFIG_PINCTRL_MT8173 is not set
CONFIG_PINCTRL_MT8183=y
# CONFIG_PINCTRL_MT8186 is not set
CONFIG_PINCTRL_MT8192=y
# CONFIG_PINCTRL_MT8195 is not set
# CONFIG_PINCTRL_MT8365 is not set
# CONFIG_PINCTRL_MT8516 is not set
# CONFIG_PINCTRL_MT6397 is not set
# end of MediaTek pinctrl drivers

CONFIG_PINCTRL_MESON=y
# CONFIG_PINCTRL_WPCM450 is not set
CONFIG_PINCTRL_NPCM7XX=y
# CONFIG_PINCTRL_PXA25X is not set
# CONFIG_PINCTRL_PXA27X is not set
CONFIG_PINCTRL_MSM=y
CONFIG_PINCTRL_APQ8064=y
CONFIG_PINCTRL_APQ8084=y
CONFIG_PINCTRL_IPQ4019=y
# CONFIG_PINCTRL_IPQ8064 is not set
# CONFIG_PINCTRL_IPQ8074 is not set
CONFIG_PINCTRL_IPQ6018=m
CONFIG_PINCTRL_MSM8226=y
# CONFIG_PINCTRL_MSM8660 is not set
CONFIG_PINCTRL_MSM8960=y
# CONFIG_PINCTRL_MDM9607 is not set
# CONFIG_PINCTRL_MDM9615 is not set
CONFIG_PINCTRL_MSM8X74=m
# CONFIG_PINCTRL_MSM8916 is not set
# CONFIG_PINCTRL_MSM8953 is not set
# CONFIG_PINCTRL_MSM8976 is not set
# CONFIG_PINCTRL_MSM8994 is not set
CONFIG_PINCTRL_MSM8996=m
# CONFIG_PINCTRL_MSM8998 is not set
# CONFIG_PINCTRL_QCM2290 is not set
CONFIG_PINCTRL_QCS404=y
CONFIG_PINCTRL_QCOM_SSBI_PMIC=y
CONFIG_PINCTRL_SC7180=m
# CONFIG_PINCTRL_SC7280 is not set
# CONFIG_PINCTRL_SC8180X is not set
# CONFIG_PINCTRL_SC8280XP is not set
CONFIG_PINCTRL_SDM660=m
# CONFIG_PINCTRL_SDM845 is not set
# CONFIG_PINCTRL_SDX55 is not set
# CONFIG_PINCTRL_SM6115 is not set
# CONFIG_PINCTRL_SM6125 is not set
# CONFIG_PINCTRL_SM6350 is not set
# CONFIG_PINCTRL_SDX65 is not set
CONFIG_PINCTRL_SM8150=m
CONFIG_PINCTRL_SM8250=m
# CONFIG_PINCTRL_SM8350 is not set
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
# CONFIG_PINCTRL_PFC_R8A77995 is not set
# CONFIG_PINCTRL_PFC_R8A7794 is not set
CONFIG_PINCTRL_PFC_R8A77990=y
CONFIG_PINCTRL_PFC_R8A7779=y
# CONFIG_PINCTRL_PFC_R8A7790 is not set
# CONFIG_PINCTRL_PFC_R8A77950 is not set
# CONFIG_PINCTRL_PFC_R8A77951 is not set
# CONFIG_PINCTRL_PFC_R8A7778 is not set
# CONFIG_PINCTRL_PFC_R8A7793 is not set
# CONFIG_PINCTRL_PFC_R8A7791 is not set
# CONFIG_PINCTRL_PFC_R8A77965 is not set
CONFIG_PINCTRL_PFC_R8A77960=y
# CONFIG_PINCTRL_PFC_R8A77961 is not set
# CONFIG_PINCTRL_PFC_R8A779F0 is not set
CONFIG_PINCTRL_PFC_R8A7792=y
CONFIG_PINCTRL_PFC_R8A77980=y
CONFIG_PINCTRL_PFC_R8A77970=y
# CONFIG_PINCTRL_PFC_R8A779A0 is not set
CONFIG_PINCTRL_PFC_R8A7740=y
# CONFIG_PINCTRL_PFC_R8A73A4 is not set
CONFIG_PINCTRL_RZA1=y
# CONFIG_PINCTRL_RZA2 is not set
# CONFIG_PINCTRL_RZG2L is not set
CONFIG_PINCTRL_PFC_R8A77470=y
# CONFIG_PINCTRL_PFC_R8A7745 is not set
# CONFIG_PINCTRL_PFC_R8A7742 is not set
CONFIG_PINCTRL_PFC_R8A7743=y
CONFIG_PINCTRL_PFC_R8A7744=y
# CONFIG_PINCTRL_PFC_R8A774C0 is not set
CONFIG_PINCTRL_PFC_R8A774E1=y
# CONFIG_PINCTRL_PFC_R8A774A1 is not set
CONFIG_PINCTRL_PFC_R8A774B1=y
# CONFIG_PINCTRL_RZN1 is not set
# CONFIG_PINCTRL_PFC_SH7203 is not set
# CONFIG_PINCTRL_PFC_SH7264 is not set
# CONFIG_PINCTRL_PFC_SH7269 is not set
# CONFIG_PINCTRL_PFC_SH7720 is not set
# CONFIG_PINCTRL_PFC_SH7722 is not set
# CONFIG_PINCTRL_PFC_SH7734 is not set
# CONFIG_PINCTRL_PFC_SH7757 is not set
# CONFIG_PINCTRL_PFC_SH7785 is not set
CONFIG_PINCTRL_PFC_SH7786=y
# CONFIG_PINCTRL_PFC_SH73A0 is not set
# CONFIG_PINCTRL_PFC_SH7723 is not set
CONFIG_PINCTRL_PFC_SH7724=y
CONFIG_PINCTRL_PFC_SHX3=y
# end of Renesas pinctrl drivers

CONFIG_PINCTRL_SAMSUNG=y
CONFIG_PINCTRL_EXYNOS=y
CONFIG_PINCTRL_EXYNOS_ARM=y
CONFIG_PINCTRL_EXYNOS_ARM64=y
# CONFIG_PINCTRL_S3C24XX is not set
CONFIG_PINCTRL_S3C64XX=y
CONFIG_PINCTRL_SPRD=m
CONFIG_PINCTRL_SPRD_SC9860=m
CONFIG_PINCTRL_STM32=y
CONFIG_PINCTRL_STM32F429=y
CONFIG_PINCTRL_STM32F469=y
CONFIG_PINCTRL_STM32F746=y
CONFIG_PINCTRL_STM32F769=y
CONFIG_PINCTRL_STM32H743=y
# CONFIG_PINCTRL_STM32MP135 is not set
# CONFIG_PINCTRL_STM32MP157 is not set
CONFIG_PINCTRL_TI_IODELAY=m
CONFIG_PINCTRL_UNIPHIER=y
CONFIG_PINCTRL_UNIPHIER_LD4=y
# CONFIG_PINCTRL_UNIPHIER_PRO4 is not set
# CONFIG_PINCTRL_UNIPHIER_SLD8 is not set
CONFIG_PINCTRL_UNIPHIER_PRO5=y
CONFIG_PINCTRL_UNIPHIER_PXS2=y
CONFIG_PINCTRL_UNIPHIER_LD6B=y
# CONFIG_PINCTRL_UNIPHIER_LD11 is not set
CONFIG_PINCTRL_UNIPHIER_LD20=y
CONFIG_PINCTRL_UNIPHIER_PXS3=y
# CONFIG_PINCTRL_UNIPHIER_NX1 is not set
# CONFIG_PINCTRL_TMPV7700 is not set
CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_OF_GPIO=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
# CONFIG_GPIO_SYSFS is not set
CONFIG_GPIO_CDEV=y
# CONFIG_GPIO_CDEV_V1 is not set
CONFIG_GPIO_GENERIC=y
CONFIG_GPIO_REGMAP=y
CONFIG_GPIO_MAX730X=y

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_74XX_MMIO is not set
CONFIG_GPIO_ALTERA=m
# CONFIG_GPIO_ASPEED is not set
# CONFIG_GPIO_ASPEED_SGPIO is not set
# CONFIG_GPIO_ATH79 is not set
CONFIG_GPIO_RASPBERRYPI_EXP=m
CONFIG_GPIO_BCM_KONA=y
# CONFIG_GPIO_BCM_XGS_IPROC is not set
CONFIG_GPIO_BRCMSTB=y
CONFIG_GPIO_CADENCE=m
CONFIG_GPIO_CLPS711X=y
CONFIG_GPIO_DWAPB=m
CONFIG_GPIO_EIC_SPRD=m
CONFIG_GPIO_EM=y
# CONFIG_GPIO_FTGPIO010 is not set
# CONFIG_GPIO_GENERIC_PLATFORM is not set
CONFIG_GPIO_GRGPIO=y
# CONFIG_GPIO_HISI is not set
CONFIG_GPIO_HLWD=y
CONFIG_GPIO_IOP=m
# CONFIG_GPIO_LOGICVC is not set
CONFIG_GPIO_LPC18XX=y
CONFIG_GPIO_LPC32XX=y
# CONFIG_GPIO_MB86S7X is not set
CONFIG_GPIO_MENZ127=m
CONFIG_GPIO_MPC8XXX=y
CONFIG_GPIO_MT7621=y
CONFIG_GPIO_MXC=y
CONFIG_GPIO_MXS=y
# CONFIG_GPIO_PMIC_EIC_SPRD is not set
CONFIG_GPIO_PXA=y
CONFIG_GPIO_RCAR=y
# CONFIG_GPIO_RDA is not set
# CONFIG_GPIO_ROCKCHIP is not set
CONFIG_GPIO_SAMA5D2_PIOBU=m
CONFIG_GPIO_SIFIVE=y
CONFIG_GPIO_SIOX=m
CONFIG_GPIO_SNPS_CREG=y
CONFIG_GPIO_SPRD=y
# CONFIG_GPIO_STP_XWAY is not set
CONFIG_GPIO_SYSCON=m
CONFIG_GPIO_TEGRA=y
# CONFIG_GPIO_TEGRA186 is not set
CONFIG_GPIO_TS4800=m
# CONFIG_GPIO_UNIPHIER is not set
# CONFIG_GPIO_VISCONTI is not set
CONFIG_GPIO_VX855=y
# CONFIG_GPIO_WCD934X is not set
# CONFIG_GPIO_XGENE_SB is not set
CONFIG_GPIO_XILINX=y
CONFIG_GPIO_XLP=y
CONFIG_GPIO_AMD_FCH=m
# CONFIG_GPIO_IDT3243X is not set
# end of Memory mapped GPIO drivers

#
# I2C GPIO expanders
#
# CONFIG_GPIO_ADP5588 is not set
CONFIG_GPIO_ADNP=y
CONFIG_GPIO_GW_PLD=m
CONFIG_GPIO_MAX7300=y
# CONFIG_GPIO_MAX732X is not set
CONFIG_GPIO_PCA953X=m
# CONFIG_GPIO_PCA953X_IRQ is not set
CONFIG_GPIO_PCA9570=y
CONFIG_GPIO_PCF857X=m
CONFIG_GPIO_TPIC2810=m
CONFIG_GPIO_TS4900=y
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
# CONFIG_GPIO_ADP5520 is not set
# CONFIG_GPIO_BD9571MWV is not set
CONFIG_GPIO_DA9052=m
CONFIG_GPIO_DA9055=m
# CONFIG_GPIO_JANZ_TTL is not set
CONFIG_GPIO_KEMPLD=m
CONFIG_GPIO_LP873X=m
CONFIG_GPIO_MADERA=m
CONFIG_GPIO_MAX77620=y
CONFIG_GPIO_PALMAS=y
CONFIG_GPIO_SL28CPLD=y
# CONFIG_GPIO_TIMBERDALE is not set
# CONFIG_GPIO_TPS65218 is not set
CONFIG_GPIO_TPS6586X=y
CONFIG_GPIO_TPS65912=m
# CONFIG_GPIO_TQMX86 is not set
CONFIG_GPIO_TWL6040=y
CONFIG_GPIO_WM8994=m
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
CONFIG_GPIO_AMD8111=m
CONFIG_GPIO_BT8XX=y
# CONFIG_GPIO_ML_IOH is not set
CONFIG_GPIO_PCH=y
CONFIG_GPIO_PCI_IDIO_16=m
CONFIG_GPIO_PCIE_IDIO_24=m
CONFIG_GPIO_RDC321X=y
# end of PCI GPIO expanders

#
# Virtual GPIO drivers
#
CONFIG_GPIO_AGGREGATOR=m
# CONFIG_GPIO_MOCKUP is not set
# CONFIG_GPIO_VIRTIO is not set
# CONFIG_GPIO_SIM is not set
# end of Virtual GPIO drivers

CONFIG_W1=y
# CONFIG_W1_CON is not set

#
# 1-wire Bus Masters
#
CONFIG_W1_MASTER_MATROX=y
# CONFIG_W1_MASTER_DS2482 is not set
# CONFIG_W1_MASTER_MXC is not set
# CONFIG_W1_MASTER_DS1WM is not set
CONFIG_W1_MASTER_GPIO=y
CONFIG_W1_MASTER_SGI=y
# end of 1-wire Bus Masters

#
# 1-wire Slaves
#
CONFIG_W1_SLAVE_THERM=y
# CONFIG_W1_SLAVE_SMEM is not set
# CONFIG_W1_SLAVE_DS2405 is not set
CONFIG_W1_SLAVE_DS2408=y
# CONFIG_W1_SLAVE_DS2408_READBACK is not set
CONFIG_W1_SLAVE_DS2413=m
CONFIG_W1_SLAVE_DS2406=m
CONFIG_W1_SLAVE_DS2423=y
CONFIG_W1_SLAVE_DS2805=m
# CONFIG_W1_SLAVE_DS2430 is not set
CONFIG_W1_SLAVE_DS2431=y
CONFIG_W1_SLAVE_DS2433=y
# CONFIG_W1_SLAVE_DS2433_CRC is not set
# CONFIG_W1_SLAVE_DS2438 is not set
CONFIG_W1_SLAVE_DS250X=m
CONFIG_W1_SLAVE_DS2780=m
CONFIG_W1_SLAVE_DS2781=y
CONFIG_W1_SLAVE_DS28E04=m
# CONFIG_W1_SLAVE_DS28E17 is not set
# end of 1-wire Slaves

# CONFIG_POWER_RESET is not set
CONFIG_POWER_SUPPLY=y
CONFIG_POWER_SUPPLY_DEBUG=y
CONFIG_POWER_SUPPLY_HWMON=y
CONFIG_PDA_POWER=m
CONFIG_GENERIC_ADC_BATTERY=m
# CONFIG_IP5XXX_POWER is not set
CONFIG_MAX8925_POWER=m
CONFIG_TEST_POWER=y
# CONFIG_CHARGER_ADP5061 is not set
CONFIG_BATTERY_ACT8945A=y
# CONFIG_BATTERY_CW2015 is not set
CONFIG_BATTERY_DS2760=m
# CONFIG_BATTERY_DS2780 is not set
CONFIG_BATTERY_DS2781=y
CONFIG_BATTERY_DS2782=y
CONFIG_BATTERY_LEGO_EV3=m
# CONFIG_BATTERY_SAMSUNG_SDI is not set
# CONFIG_BATTERY_INGENIC is not set
CONFIG_BATTERY_SBS=m
# CONFIG_CHARGER_SBS is not set
CONFIG_MANAGER_SBS=y
# CONFIG_BATTERY_BQ27XXX is not set
CONFIG_BATTERY_DA9052=y
# CONFIG_BATTERY_DA9150 is not set
CONFIG_BATTERY_MAX17040=y
# CONFIG_BATTERY_MAX17042 is not set
CONFIG_BATTERY_MAX1721X=m
CONFIG_CHARGER_MAX8903=m
CONFIG_CHARGER_LP8727=y
# CONFIG_CHARGER_GPIO is not set
CONFIG_CHARGER_MANAGER=m
# CONFIG_CHARGER_LT3651 is not set
# CONFIG_CHARGER_LTC4162L is not set
# CONFIG_CHARGER_DETECTOR_MAX14656 is not set
# CONFIG_CHARGER_MAX77976 is not set
# CONFIG_CHARGER_MAX8997 is not set
# CONFIG_CHARGER_MT6360 is not set
CONFIG_CHARGER_QCOM_SMBB=y
CONFIG_CHARGER_BQ2415X=y
CONFIG_CHARGER_BQ24190=m
# CONFIG_CHARGER_BQ24257 is not set
# CONFIG_CHARGER_BQ24735 is not set
CONFIG_CHARGER_BQ2515X=m
CONFIG_CHARGER_BQ25890=y
# CONFIG_CHARGER_BQ25980 is not set
# CONFIG_CHARGER_BQ256XX is not set
# CONFIG_CHARGER_SMB347 is not set
CONFIG_CHARGER_TPS65217=m
CONFIG_BATTERY_GAUGE_LTC2941=y
CONFIG_BATTERY_GOLDFISH=y
# CONFIG_BATTERY_RT5033 is not set
# CONFIG_CHARGER_RT9455 is not set
CONFIG_CHARGER_SC2731=m
CONFIG_FUEL_GAUGE_SC27XX=y
CONFIG_CHARGER_UCS1002=y
CONFIG_CHARGER_BD99954=y
# CONFIG_BATTERY_UG3105 is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_AD7414=m
CONFIG_SENSORS_AD7418=m
CONFIG_SENSORS_ADM1021=m
CONFIG_SENSORS_ADM1025=y
CONFIG_SENSORS_ADM1026=m
# CONFIG_SENSORS_ADM1029 is not set
# CONFIG_SENSORS_ADM1031 is not set
CONFIG_SENSORS_ADM1177=m
CONFIG_SENSORS_ADM9240=m
CONFIG_SENSORS_ADT7X10=y
CONFIG_SENSORS_ADT7410=y
# CONFIG_SENSORS_ADT7411 is not set
CONFIG_SENSORS_ADT7462=y
# CONFIG_SENSORS_ADT7470 is not set
CONFIG_SENSORS_ADT7475=m
# CONFIG_SENSORS_AHT10 is not set
CONFIG_SENSORS_AS370=m
# CONFIG_SENSORS_ASC7621 is not set
# CONFIG_SENSORS_AXI_FAN_CONTROL is not set
CONFIG_SENSORS_ASPEED=m
# CONFIG_SENSORS_ATXP1 is not set
# CONFIG_SENSORS_BT1_PVT is not set
CONFIG_SENSORS_CORSAIR_CPRO=m
# CONFIG_SENSORS_CORSAIR_PSU is not set
# CONFIG_SENSORS_DRIVETEMP is not set
# CONFIG_SENSORS_DS620 is not set
CONFIG_SENSORS_DS1621=y
CONFIG_SENSORS_DA9052_ADC=m
# CONFIG_SENSORS_DA9055 is not set
# CONFIG_SENSORS_I5K_AMB is not set
CONFIG_SENSORS_SPARX5=y
CONFIG_SENSORS_F71805F=y
# CONFIG_SENSORS_F71882FG is not set
CONFIG_SENSORS_F75375S=y
# CONFIG_SENSORS_MC13783_ADC is not set
CONFIG_SENSORS_FTSTEUTATES=y
CONFIG_SENSORS_GL518SM=m
CONFIG_SENSORS_GL520SM=m
CONFIG_SENSORS_G760A=m
CONFIG_SENSORS_G762=y
CONFIG_SENSORS_GPIO_FAN=y
CONFIG_SENSORS_HIH6130=m
CONFIG_SENSORS_IBMAEM=m
# CONFIG_SENSORS_IBMPEX is not set
CONFIG_SENSORS_IIO_HWMON=y
CONFIG_SENSORS_IT87=y
CONFIG_SENSORS_JC42=m
CONFIG_SENSORS_POWR1220=y
# CONFIG_SENSORS_LAN966X is not set
# CONFIG_SENSORS_LINEAGE is not set
# CONFIG_SENSORS_LOCHNAGAR is not set
# CONFIG_SENSORS_LTC2945 is not set
# CONFIG_SENSORS_LTC2947_I2C is not set
CONFIG_SENSORS_LTC2990=m
# CONFIG_SENSORS_LTC2992 is not set
CONFIG_SENSORS_LTC4151=y
CONFIG_SENSORS_LTC4215=m
CONFIG_SENSORS_LTC4222=m
CONFIG_SENSORS_LTC4245=m
CONFIG_SENSORS_LTC4260=y
CONFIG_SENSORS_LTC4261=m
# CONFIG_SENSORS_MAX127 is not set
CONFIG_SENSORS_MAX16065=m
# CONFIG_SENSORS_MAX1619 is not set
CONFIG_SENSORS_MAX1668=m
CONFIG_SENSORS_MAX197=y
CONFIG_SENSORS_MAX31730=m
# CONFIG_SENSORS_MAX6620 is not set
# CONFIG_SENSORS_MAX6621 is not set
CONFIG_SENSORS_MAX6639=y
CONFIG_SENSORS_MAX6642=m
CONFIG_SENSORS_MAX6650=m
CONFIG_SENSORS_MAX6697=y
# CONFIG_SENSORS_MAX31790 is not set
CONFIG_SENSORS_MCP3021=m
# CONFIG_SENSORS_MLXREG_FAN is not set
CONFIG_SENSORS_TC654=m
# CONFIG_SENSORS_TPS23861 is not set
CONFIG_SENSORS_MENF21BMC_HWMON=m
CONFIG_SENSORS_MR75203=m
CONFIG_SENSORS_LM63=m
CONFIG_SENSORS_LM73=m
# CONFIG_SENSORS_LM75 is not set
# CONFIG_SENSORS_LM77 is not set
# CONFIG_SENSORS_LM78 is not set
CONFIG_SENSORS_LM80=y
# CONFIG_SENSORS_LM83 is not set
# CONFIG_SENSORS_LM85 is not set
CONFIG_SENSORS_LM87=m
# CONFIG_SENSORS_LM90 is not set
CONFIG_SENSORS_LM92=y
# CONFIG_SENSORS_LM93 is not set
CONFIG_SENSORS_LM95234=y
# CONFIG_SENSORS_LM95241 is not set
# CONFIG_SENSORS_LM95245 is not set
# CONFIG_SENSORS_PC87360 is not set
CONFIG_SENSORS_PC87427=y
CONFIG_SENSORS_NTC_THERMISTOR=y
CONFIG_SENSORS_NCT6683=y
CONFIG_SENSORS_NCT6775_CORE=y
CONFIG_SENSORS_NCT6775=y
# CONFIG_SENSORS_NCT6775_I2C is not set
CONFIG_SENSORS_NCT7802=m
# CONFIG_SENSORS_NCT7904 is not set
CONFIG_SENSORS_NPCM7XX=y
# CONFIG_SENSORS_NSA320 is not set
# CONFIG_SENSORS_OCC_P8_I2C is not set
CONFIG_SENSORS_PCF8591=y
# CONFIG_PMBUS is not set
CONFIG_SENSORS_PWM_FAN=y
CONFIG_SENSORS_RASPBERRYPI_HWMON=y
CONFIG_SENSORS_SL28CPLD=m
# CONFIG_SENSORS_SBTSI is not set
# CONFIG_SENSORS_SBRMI is not set
CONFIG_SENSORS_SHT15=m
CONFIG_SENSORS_SHT21=m
# CONFIG_SENSORS_SHT3x is not set
# CONFIG_SENSORS_SHT4x is not set
CONFIG_SENSORS_SHTC1=m
# CONFIG_SENSORS_SIS5595 is not set
# CONFIG_SENSORS_SY7636A is not set
CONFIG_SENSORS_DME1737=y
# CONFIG_SENSORS_EMC1403 is not set
CONFIG_SENSORS_EMC2103=m
CONFIG_SENSORS_EMC6W201=m
# CONFIG_SENSORS_SMSC47M1 is not set
CONFIG_SENSORS_SMSC47M192=y
CONFIG_SENSORS_SMSC47B397=m
CONFIG_SENSORS_SCH56XX_COMMON=m
CONFIG_SENSORS_SCH5627=m
# CONFIG_SENSORS_SCH5636 is not set
CONFIG_SENSORS_STTS751=y
CONFIG_SENSORS_SMM665=m
# CONFIG_SENSORS_ADC128D818 is not set
# CONFIG_SENSORS_ADS7828 is not set
# CONFIG_SENSORS_AMC6821 is not set
CONFIG_SENSORS_INA209=m
CONFIG_SENSORS_INA2XX=m
# CONFIG_SENSORS_INA238 is not set
# CONFIG_SENSORS_INA3221 is not set
CONFIG_SENSORS_TC74=m
# CONFIG_SENSORS_THMC50 is not set
CONFIG_SENSORS_TMP102=y
# CONFIG_SENSORS_TMP103 is not set
# CONFIG_SENSORS_TMP108 is not set
CONFIG_SENSORS_TMP401=m
# CONFIG_SENSORS_TMP421 is not set
# CONFIG_SENSORS_TMP464 is not set
CONFIG_SENSORS_TMP513=m
# CONFIG_SENSORS_VIA686A is not set
# CONFIG_SENSORS_VT1211 is not set
# CONFIG_SENSORS_VT8231 is not set
CONFIG_SENSORS_W83773G=y
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83791D=y
CONFIG_SENSORS_W83792D=y
CONFIG_SENSORS_W83793=y
# CONFIG_SENSORS_W83795 is not set
CONFIG_SENSORS_W83L785TS=m
CONFIG_SENSORS_W83L786NG=m
CONFIG_SENSORS_W83627HF=y
CONFIG_SENSORS_W83627EHF=m
CONFIG_THERMAL=y
CONFIG_THERMAL_NETLINK=y
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_OF=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
# CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE is not set
CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE=y
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
# CONFIG_THERMAL_GOV_BANG_BANG is not set
# CONFIG_THERMAL_GOV_USER_SPACE is not set
# CONFIG_CPU_THERMAL is not set
# CONFIG_DEVFREQ_THERMAL is not set
# CONFIG_THERMAL_EMULATION is not set
# CONFIG_THERMAL_MMIO is not set
# CONFIG_HISI_THERMAL is not set
CONFIG_IMX_THERMAL=y
CONFIG_IMX8MM_THERMAL=y
# CONFIG_K3_THERMAL is not set
# CONFIG_MAX77620_THERMAL is not set
# CONFIG_QORIQ_THERMAL is not set
CONFIG_SPEAR_THERMAL=m
# CONFIG_SUN8I_THERMAL is not set
CONFIG_ROCKCHIP_THERMAL=y
# CONFIG_RCAR_THERMAL is not set
CONFIG_RCAR_GEN3_THERMAL=m
# CONFIG_RZG2L_THERMAL is not set
CONFIG_KIRKWOOD_THERMAL=y
CONFIG_DOVE_THERMAL=y
CONFIG_ARMADA_THERMAL=y
CONFIG_DA9062_THERMAL=y
CONFIG_MTK_THERMAL=m

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
CONFIG_BCM2711_THERMAL=y
CONFIG_BCM2835_THERMAL=m
CONFIG_BRCMSTB_THERMAL=m
CONFIG_BCM_NS_THERMAL=y
# CONFIG_BCM_SR_THERMAL is not set
# end of Broadcom thermal drivers

#
# Texas Instruments thermal drivers
#
CONFIG_TI_SOC_THERMAL=y
# CONFIG_TI_THERMAL is not set
CONFIG_OMAP3_THERMAL=y
CONFIG_OMAP4_THERMAL=y
CONFIG_OMAP5_THERMAL=y
# CONFIG_DRA752_THERMAL is not set
# end of Texas Instruments thermal drivers

#
# Samsung thermal drivers
#
CONFIG_EXYNOS_THERMAL=m
# end of Samsung thermal drivers

#
# NVIDIA Tegra thermal drivers
#
# CONFIG_TEGRA_SOCTHERM is not set
# CONFIG_TEGRA_BPMP_THERMAL is not set
# CONFIG_TEGRA30_TSENSOR is not set
# end of NVIDIA Tegra thermal drivers

CONFIG_GENERIC_ADC_THERMAL=m

#
# Qualcomm thermal drivers
#
# end of Qualcomm thermal drivers

CONFIG_UNIPHIER_THERMAL=m
CONFIG_SPRD_THERMAL=m
CONFIG_KHADAS_MCU_FAN_THERMAL=m
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
# CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED is not set
CONFIG_WATCHDOG_OPEN_TIMEOUT=0
CONFIG_WATCHDOG_SYSFS=y
# CONFIG_WATCHDOG_HRTIMER_PRETIMEOUT is not set

#
# Watchdog Pretimeout Governors
#
# CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set

#
# Watchdog Device Drivers
#
# CONFIG_SOFT_WATCHDOG is not set
CONFIG_DA9052_WATCHDOG=y
CONFIG_DA9055_WATCHDOG=m
CONFIG_DA9063_WATCHDOG=y
CONFIG_DA9062_WATCHDOG=y
CONFIG_GPIO_WATCHDOG=m
# CONFIG_MENF21BMC_WATCHDOG is not set
CONFIG_MENZ069_WATCHDOG=y
# CONFIG_XILINX_WATCHDOG is not set
CONFIG_ZIIRAVE_WATCHDOG=m
CONFIG_RAVE_SP_WATCHDOG=y
CONFIG_MLX_WDT=y
CONFIG_SL28CPLD_WATCHDOG=y
# CONFIG_ARMADA_37XX_WATCHDOG is not set
# CONFIG_ASM9260_WATCHDOG is not set
CONFIG_AT91RM9200_WATCHDOG=y
CONFIG_AT91SAM9X_WATCHDOG=y
# CONFIG_SAMA5D4_WATCHDOG is not set
CONFIG_CADENCE_WATCHDOG=m
CONFIG_FTWDT010_WATCHDOG=m
CONFIG_S3C2410_WATCHDOG=m
CONFIG_DW_WATCHDOG=m
# CONFIG_EP93XX_WATCHDOG is not set
CONFIG_OMAP_WATCHDOG=m
CONFIG_PNX4008_WATCHDOG=y
CONFIG_DAVINCI_WATCHDOG=y
# CONFIG_K3_RTI_WATCHDOG is not set
# CONFIG_RN5T618_WATCHDOG is not set
# CONFIG_SUNXI_WATCHDOG is not set
CONFIG_NPCM7XX_WATCHDOG=m
# CONFIG_STMP3XXX_RTC_WATCHDOG is not set
# CONFIG_TS4800_WATCHDOG is not set
# CONFIG_TS72XX_WATCHDOG is not set
CONFIG_MAX63XX_WATCHDOG=m
# CONFIG_MAX77620_WATCHDOG is not set
CONFIG_IMX2_WDT=y
CONFIG_IMX7ULP_WDT=y
CONFIG_MOXART_WDT=m
# CONFIG_ST_LPC_WATCHDOG is not set
# CONFIG_TEGRA_WATCHDOG is not set
# CONFIG_QCOM_WDT is not set
CONFIG_MESON_GXBB_WATCHDOG=m
CONFIG_MESON_WATCHDOG=y
CONFIG_MEDIATEK_WATCHDOG=m
# CONFIG_DIGICOLOR_WATCHDOG is not set
CONFIG_LPC18XX_WATCHDOG=m
# CONFIG_RENESAS_WDT is not set
# CONFIG_RENESAS_RZAWDT is not set
# CONFIG_RENESAS_RZN1WDT is not set
# CONFIG_RENESAS_RZG2LWDT is not set
CONFIG_ASPEED_WATCHDOG=m
CONFIG_UNIPHIER_WATCHDOG=m
# CONFIG_RTD119X_WATCHDOG is not set
CONFIG_SPRD_WATCHDOG=y
# CONFIG_VISCONTI_WATCHDOG is not set
# CONFIG_MSC313E_WATCHDOG is not set
# CONFIG_APPLE_WATCHDOG is not set
# CONFIG_SUNPLUS_WATCHDOG is not set
# CONFIG_ALIM7101_WDT is not set
CONFIG_SC520_WDT=m
CONFIG_I6300ESB_WDT=y
CONFIG_KEMPLD_WDT=m
CONFIG_RDC321X_WDT=m
# CONFIG_BCM47XX_WDT is not set
CONFIG_BCM2835_WDT=m
# CONFIG_BCM_KONA_WDT is not set
# CONFIG_BCM7038_WDT is not set
# CONFIG_IMGPDC_WDT is not set
CONFIG_MPC5200_WDT=y
# CONFIG_MEN_A21_WDT is not set
CONFIG_UML_WATCHDOG=y

#
# PCI-based Watchdog Cards
#
# CONFIG_PCIPCWATCHDOG is not set
# CONFIG_WDTPCI is not set
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=y
CONFIG_SSB_SPROM=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
CONFIG_SSB_PCIHOST=y
CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
CONFIG_SSB_DRIVER_PCICORE=y
# CONFIG_SSB_DRIVER_GPIO is not set
CONFIG_BCMA_POSSIBLE=y
# CONFIG_BCMA is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
CONFIG_MFD_ACT8945A=y
CONFIG_MFD_SUN4I_GPADC=y
# CONFIG_MFD_AS3711 is not set
# CONFIG_MFD_AS3722 is not set
CONFIG_PMIC_ADP5520=y
# CONFIG_MFD_AAT2870_CORE is not set
CONFIG_MFD_AT91_USART=m
CONFIG_MFD_ATMEL_FLEXCOM=m
CONFIG_MFD_ATMEL_HLCDC=y
CONFIG_MFD_BCM590XX=y
CONFIG_MFD_BD9571MWV=y
# CONFIG_MFD_AXP20X_I2C is not set
CONFIG_MFD_MADERA=m
CONFIG_MFD_MADERA_I2C=m
# CONFIG_MFD_CS47L15 is not set
CONFIG_MFD_CS47L35=y
CONFIG_MFD_CS47L85=y
# CONFIG_MFD_CS47L90 is not set
CONFIG_MFD_CS47L92=y
# CONFIG_MFD_ASIC3 is not set
# CONFIG_PMIC_DA903X is not set
CONFIG_PMIC_DA9052=y
CONFIG_MFD_DA9052_I2C=y
CONFIG_MFD_DA9055=y
CONFIG_MFD_DA9062=m
CONFIG_MFD_DA9063=y
CONFIG_MFD_DA9150=y
CONFIG_MFD_ENE_KB3930=y
CONFIG_MFD_EXYNOS_LPASS=y
# CONFIG_MFD_GATEWORKS_GSC is not set
CONFIG_MFD_MC13XXX=m
CONFIG_MFD_MC13XXX_I2C=m
CONFIG_MFD_MP2629=y
CONFIG_MFD_MXS_LRADC=m
# CONFIG_MFD_MX25_TSADC is not set
# CONFIG_MFD_HI6421_PMIC is not set
CONFIG_MFD_HI655X_PMIC=y
CONFIG_HTC_PASIC3=y
CONFIG_HTC_I2CPLD=y
CONFIG_LPC_ICH=y
CONFIG_LPC_SCH=y
CONFIG_MFD_IQS62X=y
CONFIG_MFD_JANZ_CMODIO=m
CONFIG_MFD_KEMPLD=m
CONFIG_MFD_88PM800=y
CONFIG_MFD_88PM805=m
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_MAX14577 is not set
CONFIG_MFD_MAX77620=y
# CONFIG_MFD_MAX77650 is not set
CONFIG_MFD_MAX77686=m
# CONFIG_MFD_MAX77693 is not set
# CONFIG_MFD_MAX77714 is not set
CONFIG_MFD_MAX77843=y
# CONFIG_MFD_MAX8907 is not set
CONFIG_MFD_MAX8925=y
CONFIG_MFD_MAX8997=y
# CONFIG_MFD_MAX8998 is not set
CONFIG_MFD_MT6360=m
CONFIG_MFD_MT6397=m
CONFIG_MFD_MENF21BMC=m
# CONFIG_MFD_NTXEC is not set
# CONFIG_MFD_RETU is not set
# CONFIG_MFD_PCF50633 is not set
# CONFIG_MFD_PM8XXX is not set
CONFIG_MFD_RDC321X=y
# CONFIG_MFD_RT4831 is not set
CONFIG_MFD_RT5033=m
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_RK808 is not set
# CONFIG_MFD_RN5T618 is not set
CONFIG_MFD_SEC_CORE=y
CONFIG_MFD_SI476X_CORE=m
CONFIG_MFD_SIMPLE_MFD_I2C=m
CONFIG_MFD_SL28CPLD=m
CONFIG_MFD_SM501=m
CONFIG_MFD_SM501_GPIO=y
CONFIG_MFD_SKY81452=y
CONFIG_ABX500_CORE=y
# CONFIG_MFD_STMPE is not set
# CONFIG_MFD_SUN6I_PRCM is not set
CONFIG_MFD_SYSCON=y
# CONFIG_MFD_TI_AM335X_TSCADC is not set
# CONFIG_MFD_LP3943 is not set
CONFIG_MFD_LP8788=y
# CONFIG_MFD_TI_LMU is not set
CONFIG_MFD_PALMAS=y
CONFIG_TPS6105X=m
CONFIG_TPS65010=m
CONFIG_TPS6507X=m
# CONFIG_MFD_TPS65086 is not set
# CONFIG_MFD_TPS65090 is not set
CONFIG_MFD_TPS65217=m
CONFIG_MFD_TI_LP873X=m
# CONFIG_MFD_TI_LP87565 is not set
CONFIG_MFD_TPS65218=y
CONFIG_MFD_TPS6586X=y
# CONFIG_MFD_TPS65910 is not set
CONFIG_MFD_TPS65912=m
CONFIG_MFD_TPS65912_I2C=m
# CONFIG_TWL4030_CORE is not set
CONFIG_TWL6040_CORE=y
CONFIG_MFD_WL1273_CORE=m
CONFIG_MFD_LM3533=y
CONFIG_MFD_TIMBERDALE=m
# CONFIG_MFD_TC3589X is not set
CONFIG_MFD_TQMX86=m
CONFIG_MFD_VX855=y
CONFIG_MFD_LOCHNAGAR=y
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM8350_I2C is not set
CONFIG_MFD_WM8994=y
# CONFIG_MFD_STW481X is not set
CONFIG_MFD_ROHM_BD718XX=y
# CONFIG_MFD_ROHM_BD71828 is not set
# CONFIG_MFD_ROHM_BD957XMUF is not set
CONFIG_MFD_STM32_LPTIMER=y
# CONFIG_MFD_STM32_TIMERS is not set
# CONFIG_MFD_STPMIC1 is not set
CONFIG_MFD_STMFX=m
CONFIG_MFD_WCD934X=m
# CONFIG_MFD_ATC260X_I2C is not set
CONFIG_MFD_KHADAS_MCU=m
# CONFIG_MFD_ACER_A500_EC is not set
# CONFIG_MFD_QCOM_PM8008 is not set
CONFIG_RAVE_SP_CORE=y
# CONFIG_MFD_RSMU_I2C is not set
# end of Multifunction device drivers

CONFIG_REGULATOR=y
CONFIG_REGULATOR_DEBUG=y
CONFIG_REGULATOR_FIXED_VOLTAGE=y
CONFIG_REGULATOR_VIRTUAL_CONSUMER=m
CONFIG_REGULATOR_USERSPACE_CONSUMER=m
# CONFIG_REGULATOR_88PG86X is not set
CONFIG_REGULATOR_88PM800=y
CONFIG_REGULATOR_ACT8865=y
CONFIG_REGULATOR_ACT8945A=m
# CONFIG_REGULATOR_AD5398 is not set
# CONFIG_REGULATOR_ANATOP is not set
# CONFIG_REGULATOR_BCM590XX is not set
# CONFIG_REGULATOR_BD718XX is not set
# CONFIG_REGULATOR_BD9571MWV is not set
# CONFIG_REGULATOR_DA9052 is not set
CONFIG_REGULATOR_DA9055=y
CONFIG_REGULATOR_DA9062=m
CONFIG_REGULATOR_DA9063=m
# CONFIG_REGULATOR_DA9121 is not set
CONFIG_REGULATOR_DA9210=y
CONFIG_REGULATOR_DA9211=m
CONFIG_REGULATOR_FAN53555=m
# CONFIG_REGULATOR_FAN53880 is not set
CONFIG_REGULATOR_GPIO=y
CONFIG_REGULATOR_HI655X=y
CONFIG_REGULATOR_ISL9305=y
# CONFIG_REGULATOR_ISL6271A is not set
# CONFIG_REGULATOR_LOCHNAGAR is not set
CONFIG_REGULATOR_LP3971=y
CONFIG_REGULATOR_LP3972=m
CONFIG_REGULATOR_LP872X=y
# CONFIG_REGULATOR_LP873X is not set
# CONFIG_REGULATOR_LP8755 is not set
CONFIG_REGULATOR_LP8788=m
CONFIG_REGULATOR_LTC3589=m
# CONFIG_REGULATOR_LTC3676 is not set
CONFIG_REGULATOR_MAX1586=m
CONFIG_REGULATOR_MAX77620=m
CONFIG_REGULATOR_MAX77650=y
CONFIG_REGULATOR_MAX8649=y
CONFIG_REGULATOR_MAX8660=y
# CONFIG_REGULATOR_MAX8893 is not set
CONFIG_REGULATOR_MAX8907=y
CONFIG_REGULATOR_MAX8925=y
CONFIG_REGULATOR_MAX8952=y
CONFIG_REGULATOR_MAX8973=y
CONFIG_REGULATOR_MAX8997=m
# CONFIG_REGULATOR_MAX20086 is not set
CONFIG_REGULATOR_MAX77686=m
CONFIG_REGULATOR_MAX77693=m
CONFIG_REGULATOR_MAX77802=y
CONFIG_REGULATOR_MAX77826=y
CONFIG_REGULATOR_MC13XXX_CORE=m
# CONFIG_REGULATOR_MC13783 is not set
CONFIG_REGULATOR_MC13892=m
CONFIG_REGULATOR_MCP16502=y
CONFIG_REGULATOR_MP5416=y
CONFIG_REGULATOR_MP8859=y
CONFIG_REGULATOR_MP886X=y
CONFIG_REGULATOR_MPQ7920=y
# CONFIG_REGULATOR_MT6311 is not set
CONFIG_REGULATOR_MT6323=m
CONFIG_REGULATOR_MT6358=m
# CONFIG_REGULATOR_MT6359 is not set
CONFIG_REGULATOR_MT6360=m
CONFIG_REGULATOR_MT6380=y
CONFIG_REGULATOR_MT6397=m
CONFIG_REGULATOR_PALMAS=y
CONFIG_REGULATOR_PBIAS=y
CONFIG_REGULATOR_PCA9450=y
# CONFIG_REGULATOR_PF8X00 is not set
# CONFIG_REGULATOR_PFUZE100 is not set
# CONFIG_REGULATOR_PV88060 is not set
CONFIG_REGULATOR_PV88080=y
# CONFIG_REGULATOR_PV88090 is not set
CONFIG_REGULATOR_PWM=y
# CONFIG_REGULATOR_QCOM_RPMH is not set
# CONFIG_REGULATOR_QCOM_SPMI is not set
CONFIG_REGULATOR_QCOM_USB_VBUS=y
CONFIG_REGULATOR_RT4801=y
# CONFIG_REGULATOR_RT5033 is not set
# CONFIG_REGULATOR_RT5190A is not set
# CONFIG_REGULATOR_RT5759 is not set
# CONFIG_REGULATOR_RT6160 is not set
# CONFIG_REGULATOR_RT6245 is not set
# CONFIG_REGULATOR_RTQ2134 is not set
CONFIG_REGULATOR_RTMV20=y
# CONFIG_REGULATOR_RTQ6752 is not set
# CONFIG_REGULATOR_S2MPA01 is not set
CONFIG_REGULATOR_S2MPS11=m
CONFIG_REGULATOR_S5M8767=y
# CONFIG_REGULATOR_SC2731 is not set
# CONFIG_REGULATOR_SKY81452 is not set
CONFIG_REGULATOR_SLG51000=y
CONFIG_REGULATOR_STM32_BOOSTER=y
CONFIG_REGULATOR_STM32_VREFBUF=y
# CONFIG_REGULATOR_STM32_PWR is not set
# CONFIG_REGULATOR_TI_ABB is not set
CONFIG_REGULATOR_STW481X_VMMC=y
# CONFIG_REGULATOR_SY7636A is not set
# CONFIG_REGULATOR_SY8106A is not set
CONFIG_REGULATOR_SY8824X=m
# CONFIG_REGULATOR_SY8827N is not set
# CONFIG_REGULATOR_TPS51632 is not set
CONFIG_REGULATOR_TPS6105X=m
CONFIG_REGULATOR_TPS62360=m
# CONFIG_REGULATOR_TPS6286X is not set
# CONFIG_REGULATOR_TPS65023 is not set
CONFIG_REGULATOR_TPS6507X=m
CONFIG_REGULATOR_TPS65132=m
CONFIG_REGULATOR_TPS65217=m
CONFIG_REGULATOR_TPS65218=m
# CONFIG_REGULATOR_TPS6586X is not set
CONFIG_REGULATOR_TPS65912=m
# CONFIG_REGULATOR_TPS68470 is not set
CONFIG_REGULATOR_UNIPHIER=m
CONFIG_REGULATOR_VCTRL=y
CONFIG_REGULATOR_WM8994=y
# CONFIG_REGULATOR_QCOM_LABIBB is not set
CONFIG_RC_CORE=m
CONFIG_LIRC=y
CONFIG_RC_MAP=m
CONFIG_RC_DECODERS=y
CONFIG_IR_IMON_DECODER=m
CONFIG_IR_JVC_DECODER=m
CONFIG_IR_MCE_KBD_DECODER=m
CONFIG_IR_NEC_DECODER=m
CONFIG_IR_RC5_DECODER=m
# CONFIG_IR_RC6_DECODER is not set
# CONFIG_IR_RCMM_DECODER is not set
CONFIG_IR_SANYO_DECODER=m
CONFIG_IR_SHARP_DECODER=m
CONFIG_IR_SONY_DECODER=m
CONFIG_IR_XMP_DECODER=m
CONFIG_RC_DEVICES=y
CONFIG_IR_ENE=m
# CONFIG_IR_FINTEK is not set
# CONFIG_IR_GPIO_CIR is not set
# CONFIG_IR_GPIO_TX is not set
CONFIG_IR_HIX5HD2=m
CONFIG_IR_ITE_CIR=m
CONFIG_IR_MESON=m
# CONFIG_IR_MESON_TX is not set
# CONFIG_IR_MTK is not set
# CONFIG_IR_NUVOTON is not set
# CONFIG_IR_PWM_TX is not set
CONFIG_IR_RX51=m
# CONFIG_IR_SERIAL is not set
CONFIG_IR_SUNXI=m
# CONFIG_IR_WINBOND_CIR is not set
CONFIG_RC_LOOPBACK=m
CONFIG_RC_ST=m
CONFIG_IR_IMG=m
CONFIG_IR_IMG_RAW=y
CONFIG_IR_IMG_HW=y
# CONFIG_IR_IMG_NEC is not set
CONFIG_IR_IMG_JVC=y
# CONFIG_IR_IMG_SONY is not set
CONFIG_IR_IMG_SHARP=y
# CONFIG_IR_IMG_SANYO is not set
CONFIG_IR_IMG_RC5=y
CONFIG_IR_IMG_RC6=y
CONFIG_CEC_CORE=y

#
# CEC support
#
# CONFIG_MEDIA_CEC_SUPPORT is not set
# end of CEC support

CONFIG_MEDIA_SUPPORT=y
CONFIG_MEDIA_SUPPORT_FILTER=y
CONFIG_MEDIA_SUBDRV_AUTOSELECT=y

#
# Media device types
#
CONFIG_MEDIA_CAMERA_SUPPORT=y
CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
# CONFIG_MEDIA_RADIO_SUPPORT is not set
# CONFIG_MEDIA_SDR_SUPPORT is not set
# CONFIG_MEDIA_PLATFORM_SUPPORT is not set
# CONFIG_MEDIA_TEST_SUPPORT is not set
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
CONFIG_VIDEO_TUNER=y
CONFIG_V4L2_FWNODE=y
CONFIG_V4L2_ASYNC=y
# end of Video4Linux options

#
# Media controller options
#
CONFIG_MEDIA_CONTROLLER_DVB=y
# end of Media controller options

#
# Digital TV options
#
# CONFIG_DVB_MMAP is not set
CONFIG_DVB_NET=y
CONFIG_DVB_MAX_ADAPTERS=16
CONFIG_DVB_DYNAMIC_MINORS=y
CONFIG_DVB_DEMUX_SECTION_LOSS_LOG=y
# CONFIG_DVB_ULE_DEBUG is not set
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
CONFIG_MEDIA_PCI_SUPPORT=y

#
# Media capture support
#
CONFIG_VIDEO_TW5864=y
CONFIG_VIDEO_TW68=y

#
# Media capture/analog TV support
#
CONFIG_VIDEO_DT3155=y
CONFIG_VIDEO_IVTV=m
# CONFIG_VIDEO_HEXIUM_GEMINI is not set
# CONFIG_VIDEO_HEXIUM_ORION is not set
# CONFIG_VIDEO_MXB is not set

#
# Media capture/analog/hybrid TV support
#
# CONFIG_VIDEO_CX18 is not set
CONFIG_VIDEO_CX25821=m
# CONFIG_VIDEO_CX88 is not set
CONFIG_VIDEO_SAA7134=m
CONFIG_VIDEO_SAA7134_RC=y
CONFIG_VIDEO_SAA7134_DVB=m
CONFIG_VIDEO_SAA7164=y

#
# Media digital TV PCI Adapters
#
CONFIG_DVB_B2C2_FLEXCOP_PCI=y
CONFIG_DVB_B2C2_FLEXCOP_PCI_DEBUG=y
CONFIG_DVB_DDBRIDGE=m
# CONFIG_DVB_DDBRIDGE_MSIENABLE is not set
CONFIG_DVB_DM1105=m
CONFIG_MANTIS_CORE=m
CONFIG_DVB_MANTIS=m
CONFIG_DVB_HOPPER=m
CONFIG_DVB_NGENE=y
# CONFIG_DVB_PLUTO2 is not set
CONFIG_DVB_PT1=m
# CONFIG_DVB_PT3 is not set
# CONFIG_DVB_SMIPCIE is not set
# CONFIG_DVB_BUDGET_CORE is not set

#
# FireWire (IEEE 1394) Adapters
#
# CONFIG_DVB_FIREDTV is not set
CONFIG_VIDEO_CX2341X=m
CONFIG_VIDEO_TVEEPROM=y
CONFIG_DVB_B2C2_FLEXCOP=y
CONFIG_DVB_B2C2_FLEXCOP_DEBUG=y
CONFIG_VIDEOBUF2_CORE=y
CONFIG_VIDEOBUF2_V4L2=y
CONFIG_VIDEOBUF2_MEMOPS=y
CONFIG_VIDEOBUF2_DMA_CONTIG=y
CONFIG_VIDEOBUF2_VMALLOC=y
CONFIG_VIDEOBUF2_DMA_SG=y
CONFIG_VIDEOBUF2_DVB=m
# end of Media drivers

#
# Media ancillary drivers
#
CONFIG_MEDIA_ATTACH=y

#
# IR I2C driver auto-selected by 'Autoselect ancillary drivers'
#
CONFIG_VIDEO_IR_I2C=m

#
# Camera sensor devices
#
CONFIG_VIDEO_APTINA_PLL=y
# CONFIG_VIDEO_HI556 is not set
# CONFIG_VIDEO_HI846 is not set
# CONFIG_VIDEO_HI847 is not set
# CONFIG_VIDEO_IMX208 is not set
CONFIG_VIDEO_IMX214=m
# CONFIG_VIDEO_IMX219 is not set
# CONFIG_VIDEO_IMX258 is not set
# CONFIG_VIDEO_IMX274 is not set
CONFIG_VIDEO_IMX290=m
# CONFIG_VIDEO_IMX319 is not set
# CONFIG_VIDEO_IMX334 is not set
# CONFIG_VIDEO_IMX335 is not set
CONFIG_VIDEO_IMX355=m
# CONFIG_VIDEO_IMX412 is not set
CONFIG_VIDEO_MT9M001=m
CONFIG_VIDEO_MT9M032=y
# CONFIG_VIDEO_MT9M111 is not set
# CONFIG_VIDEO_MT9P031 is not set
CONFIG_VIDEO_MT9T001=y
CONFIG_VIDEO_MT9T112=y
# CONFIG_VIDEO_MT9V011 is not set
CONFIG_VIDEO_MT9V032=y
CONFIG_VIDEO_MT9V111=m
# CONFIG_VIDEO_NOON010PC30 is not set
# CONFIG_VIDEO_OG01A1B is not set
# CONFIG_VIDEO_OV02A10 is not set
# CONFIG_VIDEO_OV08D10 is not set
CONFIG_VIDEO_OV13858=m
# CONFIG_VIDEO_OV13B10 is not set
CONFIG_VIDEO_OV2640=y
CONFIG_VIDEO_OV2659=y
# CONFIG_VIDEO_OV2680 is not set
CONFIG_VIDEO_OV2685=m
CONFIG_VIDEO_OV2740=m
# CONFIG_VIDEO_OV5640 is not set
CONFIG_VIDEO_OV5645=m
CONFIG_VIDEO_OV5647=m
# CONFIG_VIDEO_OV5670 is not set
# CONFIG_VIDEO_OV5675 is not set
# CONFIG_VIDEO_OV5693 is not set
CONFIG_VIDEO_OV5695=m
# CONFIG_VIDEO_OV6650 is not set
CONFIG_VIDEO_OV7251=m
# CONFIG_VIDEO_OV7640 is not set
# CONFIG_VIDEO_OV7670 is not set
CONFIG_VIDEO_OV772X=y
# CONFIG_VIDEO_OV7740 is not set
CONFIG_VIDEO_OV8856=y
# CONFIG_VIDEO_OV9282 is not set
CONFIG_VIDEO_OV9640=m
# CONFIG_VIDEO_OV9650 is not set
# CONFIG_VIDEO_OV9734 is not set
# CONFIG_VIDEO_RDACM20 is not set
# CONFIG_VIDEO_RDACM21 is not set
# CONFIG_VIDEO_RJ54N1 is not set
CONFIG_VIDEO_S5K4ECGX=m
# CONFIG_VIDEO_S5K5BAF is not set
CONFIG_VIDEO_S5K6A3=y
# CONFIG_VIDEO_S5K6AA is not set
# CONFIG_VIDEO_SR030PC30 is not set
CONFIG_VIDEO_VS6624=y
CONFIG_VIDEO_ET8EK8=m
CONFIG_VIDEO_M5MOLS=y
# end of Camera sensor devices

#
# Lens drivers
#
# CONFIG_VIDEO_AD5820 is not set
# CONFIG_VIDEO_AK7375 is not set
CONFIG_VIDEO_DW9714=m
CONFIG_VIDEO_DW9768=y
# CONFIG_VIDEO_DW9807_VCM is not set
# end of Lens drivers

#
# Flash devices
#
CONFIG_VIDEO_ADP1653=y
CONFIG_VIDEO_LM3560=y
CONFIG_VIDEO_LM3646=y
# end of Flash devices

#
# Audio decoders, processors and mixers
#
CONFIG_VIDEO_CS3308=m
CONFIG_VIDEO_CS5345=m
CONFIG_VIDEO_CS53L32A=m
CONFIG_VIDEO_MSP3400=y
CONFIG_VIDEO_SONY_BTF_MPX=m
CONFIG_VIDEO_TDA7432=y
CONFIG_VIDEO_TDA9840=y
CONFIG_VIDEO_TEA6415C=m
CONFIG_VIDEO_TEA6420=m
CONFIG_VIDEO_TLV320AIC23B=m
CONFIG_VIDEO_TVAUDIO=y
CONFIG_VIDEO_UDA1342=m
CONFIG_VIDEO_VP27SMPX=m
CONFIG_VIDEO_WM8739=m
CONFIG_VIDEO_WM8775=m
# end of Audio decoders, processors and mixers

#
# RDS decoders
#
CONFIG_VIDEO_SAA6588=m
# end of RDS decoders

#
# Video decoders
#
CONFIG_VIDEO_ADV7180=y
# CONFIG_VIDEO_ADV7183 is not set
# CONFIG_VIDEO_ADV748X is not set
CONFIG_VIDEO_ADV7604=m
# CONFIG_VIDEO_ADV7604_CEC is not set
CONFIG_VIDEO_ADV7842=y
CONFIG_VIDEO_ADV7842_CEC=y
CONFIG_VIDEO_BT819=m
CONFIG_VIDEO_BT856=m
CONFIG_VIDEO_BT866=y
# CONFIG_VIDEO_ISL7998X is not set
CONFIG_VIDEO_KS0127=m
CONFIG_VIDEO_MAX9286=m
CONFIG_VIDEO_ML86V7667=m
CONFIG_VIDEO_SAA7110=m
CONFIG_VIDEO_SAA711X=y
CONFIG_VIDEO_TC358743=m
# CONFIG_VIDEO_TC358743_CEC is not set
CONFIG_VIDEO_TVP514X=y
CONFIG_VIDEO_TVP5150=y
CONFIG_VIDEO_TVP7002=y
CONFIG_VIDEO_TW2804=y
CONFIG_VIDEO_TW9903=y
CONFIG_VIDEO_TW9906=y
# CONFIG_VIDEO_TW9910 is not set
# CONFIG_VIDEO_VPX3220 is not set

#
# Video and audio decoders
#
CONFIG_VIDEO_SAA717X=m
CONFIG_VIDEO_CX25840=y
# end of Video decoders

#
# Video encoders
#
# CONFIG_VIDEO_AD9389B is not set
# CONFIG_VIDEO_ADV7170 is not set
CONFIG_VIDEO_ADV7175=y
CONFIG_VIDEO_ADV7343=y
# CONFIG_VIDEO_ADV7393 is not set
CONFIG_VIDEO_ADV7511=m
CONFIG_VIDEO_ADV7511_CEC=y
CONFIG_VIDEO_AK881X=y
CONFIG_VIDEO_SAA7127=y
CONFIG_VIDEO_SAA7185=m
# CONFIG_VIDEO_THS8200 is not set
# end of Video encoders

#
# Video improvement chips
#
CONFIG_VIDEO_UPD64031A=m
CONFIG_VIDEO_UPD64083=m
# end of Video improvement chips

#
# Audio/Video compression chips
#
CONFIG_VIDEO_SAA6752HS=m
# end of Audio/Video compression chips

#
# SDR tuner chips
#
# end of SDR tuner chips

#
# Miscellaneous helper chips
#
CONFIG_VIDEO_I2C=y
CONFIG_VIDEO_M52790=m
CONFIG_VIDEO_ST_MIPID02=y
CONFIG_VIDEO_THS7303=m
# end of Miscellaneous helper chips

CONFIG_MEDIA_TUNER=y

#
# Customize TV tuners
#
CONFIG_MEDIA_TUNER_E4000=y
CONFIG_MEDIA_TUNER_FC0011=m
CONFIG_MEDIA_TUNER_FC0012=y
# CONFIG_MEDIA_TUNER_FC0013 is not set
CONFIG_MEDIA_TUNER_FC2580=m
CONFIG_MEDIA_TUNER_IT913X=y
# CONFIG_MEDIA_TUNER_M88RS6000T is not set
# CONFIG_MEDIA_TUNER_MAX2165 is not set
CONFIG_MEDIA_TUNER_MC44S803=y
# CONFIG_MEDIA_TUNER_MT2060 is not set
CONFIG_MEDIA_TUNER_MT2063=y
CONFIG_MEDIA_TUNER_MT20XX=y
CONFIG_MEDIA_TUNER_MT2131=y
# CONFIG_MEDIA_TUNER_MT2266 is not set
CONFIG_MEDIA_TUNER_MXL301RF=m
# CONFIG_MEDIA_TUNER_MXL5005S is not set
CONFIG_MEDIA_TUNER_MXL5007T=m
CONFIG_MEDIA_TUNER_QM1D1B0004=m
CONFIG_MEDIA_TUNER_QM1D1C0042=y
CONFIG_MEDIA_TUNER_QT1010=m
CONFIG_MEDIA_TUNER_R820T=m
CONFIG_MEDIA_TUNER_SI2157=y
CONFIG_MEDIA_TUNER_SIMPLE=y
CONFIG_MEDIA_TUNER_TDA18212=y
# CONFIG_MEDIA_TUNER_TDA18218 is not set
CONFIG_MEDIA_TUNER_TDA18250=y
CONFIG_MEDIA_TUNER_TDA18271=y
CONFIG_MEDIA_TUNER_TDA827X=y
CONFIG_MEDIA_TUNER_TDA8290=y
CONFIG_MEDIA_TUNER_TDA9887=y
CONFIG_MEDIA_TUNER_TEA5761=y
CONFIG_MEDIA_TUNER_TEA5767=y
CONFIG_MEDIA_TUNER_TUA9001=m
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
CONFIG_DVB_MXL5XX=y
CONFIG_DVB_STB0899=m
CONFIG_DVB_STB6100=m
CONFIG_DVB_STV090x=y
CONFIG_DVB_STV0910=y
CONFIG_DVB_STV6110x=y
CONFIG_DVB_STV6111=y

#
# Multistandard (cable + terrestrial) frontends
#
CONFIG_DVB_DRXK=y
CONFIG_DVB_MN88472=y
# CONFIG_DVB_MN88473 is not set
CONFIG_DVB_SI2165=m
CONFIG_DVB_TDA18271C2DD=y

#
# DVB-S (satellite) frontends
#
# CONFIG_DVB_CX24110 is not set
CONFIG_DVB_CX24116=m
# CONFIG_DVB_CX24117 is not set
CONFIG_DVB_CX24120=y
CONFIG_DVB_CX24123=y
CONFIG_DVB_DS3000=m
CONFIG_DVB_MB86A16=m
CONFIG_DVB_MT312=y
CONFIG_DVB_S5H1420=y
CONFIG_DVB_SI21XX=m
CONFIG_DVB_STB6000=m
CONFIG_DVB_STV0288=m
CONFIG_DVB_STV0299=y
CONFIG_DVB_STV0900=y
# CONFIG_DVB_STV6110 is not set
CONFIG_DVB_TDA10071=m
CONFIG_DVB_TDA10086=m
CONFIG_DVB_TDA8083=m
CONFIG_DVB_TDA8261=m
CONFIG_DVB_TDA826X=m
CONFIG_DVB_TS2020=y
CONFIG_DVB_TUA6100=m
CONFIG_DVB_TUNER_CX24113=y
CONFIG_DVB_TUNER_ITD1000=y
CONFIG_DVB_VES1X93=m
CONFIG_DVB_ZL10036=m
CONFIG_DVB_ZL10039=y

#
# DVB-T (terrestrial) frontends
#
# CONFIG_DVB_AF9013 is not set
CONFIG_DVB_CX22700=y
# CONFIG_DVB_CX22702 is not set
# CONFIG_DVB_CXD2820R is not set
CONFIG_DVB_CXD2841ER=y
CONFIG_DVB_DIB3000MB=m
CONFIG_DVB_DIB3000MC=m
CONFIG_DVB_DIB7000M=y
CONFIG_DVB_DIB7000P=y
CONFIG_DVB_DIB9000=m
# CONFIG_DVB_DRXD is not set
CONFIG_DVB_EC100=m
CONFIG_DVB_L64781=m
CONFIG_DVB_MT352=y
CONFIG_DVB_NXT6000=y
CONFIG_DVB_RTL2830=y
CONFIG_DVB_RTL2832=y
CONFIG_DVB_S5H1432=y
CONFIG_DVB_SI2168=y
# CONFIG_DVB_SP887X is not set
CONFIG_DVB_STV0367=y
CONFIG_DVB_TDA10048=y
CONFIG_DVB_TDA1004X=m
CONFIG_DVB_ZD1301_DEMOD=y
CONFIG_DVB_ZL10353=m

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
# CONFIG_DVB_AU8522_DTV is not set
CONFIG_DVB_AU8522_V4L=y
CONFIG_DVB_BCM3510=y
CONFIG_DVB_LG2160=y
CONFIG_DVB_LGDT3305=y
CONFIG_DVB_LGDT3306A=m
CONFIG_DVB_LGDT330X=y
# CONFIG_DVB_MXL692 is not set
CONFIG_DVB_NXT200X=y
CONFIG_DVB_OR51132=y
# CONFIG_DVB_OR51211 is not set
CONFIG_DVB_S5H1409=m
CONFIG_DVB_S5H1411=y

#
# ISDB-T (terrestrial) frontends
#
CONFIG_DVB_DIB8000=y
CONFIG_DVB_MB86A20S=y
# CONFIG_DVB_S921 is not set

#
# ISDB-S (satellite) & ISDB-T (terrestrial) frontends
#
CONFIG_DVB_MN88443X=m
CONFIG_DVB_TC90522=m

#
# Digital terrestrial only tuners/PLL
#
CONFIG_DVB_PLL=y
# CONFIG_DVB_TUNER_DIB0070 is not set
# CONFIG_DVB_TUNER_DIB0090 is not set

#
# SEC control devices for DVB-S
#
# CONFIG_DVB_A8293 is not set
CONFIG_DVB_AF9033=y
# CONFIG_DVB_ASCOT2E is not set
CONFIG_DVB_ATBM8830=y
# CONFIG_DVB_HELENE is not set
# CONFIG_DVB_HORUS3A is not set
CONFIG_DVB_ISL6405=y
CONFIG_DVB_ISL6421=y
CONFIG_DVB_ISL6423=y
# CONFIG_DVB_IX2505V is not set
CONFIG_DVB_LGS8GL5=y
# CONFIG_DVB_LGS8GXX is not set
CONFIG_DVB_LNBH25=y
CONFIG_DVB_LNBH29=m
CONFIG_DVB_LNBP21=y
CONFIG_DVB_LNBP22=y
CONFIG_DVB_M88RS2000=m
CONFIG_DVB_TDA665x=m
# CONFIG_DVB_DRX39XYJ is not set

#
# Common Interface (EN50221) controller drivers
#
CONFIG_DVB_CXD2099=y
CONFIG_DVB_SP2=m
# end of Customise DVB Frontends
# end of Media ancillary drivers

#
# Graphics support
#
# CONFIG_IMX_IPUV3_CORE is not set

#
# ARM devices
#
# end of ARM devices

#
# Frame buffer Devices
#
# CONFIG_FB is not set
# CONFIG_MMP_DISP is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=y
CONFIG_LCD_PLATFORM=y
# CONFIG_BACKLIGHT_CLASS_DEVICE is not set
# end of Backlight & LCD device support

CONFIG_HDMI=y
# end of Graphics support

# CONFIG_SOUND is not set

#
# HID support
#
CONFIG_HID=y
# CONFIG_HID_BATTERY_STRENGTH is not set
# CONFIG_HIDRAW is not set
CONFIG_UHID=m
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
# CONFIG_HID_A4TECH is not set
CONFIG_HID_ACRUX=y
# CONFIG_HID_ACRUX_FF is not set
CONFIG_HID_AUREAL=y
# CONFIG_HID_BELKIN is not set
CONFIG_HID_CHERRY=m
# CONFIG_HID_COUGAR is not set
CONFIG_HID_MACALLY=m
# CONFIG_HID_CMEDIA is not set
# CONFIG_HID_CYPRESS is not set
# CONFIG_HID_DRAGONRISE is not set
CONFIG_HID_EMS_FF=m
CONFIG_HID_ELECOM=m
CONFIG_HID_EZKEY=y
CONFIG_HID_GEMBIRD=y
CONFIG_HID_GFRM=m
CONFIG_HID_GLORIOUS=m
CONFIG_HID_VIVALDI_COMMON=y
CONFIG_HID_VIVALDI=y
CONFIG_HID_KEYTOUCH=m
CONFIG_HID_KYE=y
CONFIG_HID_WALTOP=m
CONFIG_HID_VIEWSONIC=y
# CONFIG_HID_XIAOMI is not set
# CONFIG_HID_GYRATION is not set
CONFIG_HID_ICADE=y
CONFIG_HID_ITE=y
CONFIG_HID_JABRA=y
CONFIG_HID_TWINHAN=y
CONFIG_HID_KENSINGTON=y
CONFIG_HID_LCPOWER=y
# CONFIG_HID_LENOVO is not set
CONFIG_HID_MAGICMOUSE=m
# CONFIG_HID_MALTRON is not set
CONFIG_HID_MAYFLASH=y
# CONFIG_HID_REDRAGON is not set
CONFIG_HID_MICROSOFT=y
# CONFIG_HID_MONTEREY is not set
CONFIG_HID_MULTITOUCH=y
CONFIG_HID_NTI=m
CONFIG_HID_ORTEK=y
# CONFIG_HID_PANTHERLORD is not set
CONFIG_HID_PETALYNX=y
CONFIG_HID_PICOLCD=m
CONFIG_HID_PICOLCD_LCD=y
# CONFIG_HID_PICOLCD_CIR is not set
CONFIG_HID_PLANTRONICS=y
# CONFIG_HID_RAZER is not set
# CONFIG_HID_PRIMAX is not set
CONFIG_HID_SAITEK=y
# CONFIG_HID_SEMITEK is not set
CONFIG_HID_SPEEDLINK=y
# CONFIG_HID_STEAM is not set
CONFIG_HID_STEELSERIES=m
CONFIG_HID_SUNPLUS=y
# CONFIG_HID_RMI is not set
CONFIG_HID_GREENASIA=y
# CONFIG_GREENASIA_FF is not set
# CONFIG_HID_SMARTJOYPLUS is not set
CONFIG_HID_TIVO=y
CONFIG_HID_TOPSEED=y
CONFIG_HID_UDRAW_PS3=m
# CONFIG_HID_XINMO is not set
# CONFIG_HID_ZEROPLUS is not set
CONFIG_HID_ZYDACRON=y
# CONFIG_HID_SENSOR_HUB is not set
CONFIG_HID_ALPS=m
# end of Special HID drivers

#
# I2C HID support
#
# CONFIG_I2C_HID_OF is not set
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
CONFIG_USB_EHCI_BIG_ENDIAN_MMIO=y
CONFIG_USB_EHCI_BIG_ENDIAN_DESC=y
CONFIG_USB_UHCI_BIG_ENDIAN_MMIO=y
CONFIG_USB_UHCI_BIG_ENDIAN_DESC=y
# CONFIG_USB_SUPPORT is not set
# CONFIG_MMC is not set
CONFIG_SCSI_UFSHCD=m
# CONFIG_SCSI_UFS_BSG is not set
# CONFIG_SCSI_UFS_HPB is not set
# CONFIG_SCSI_UFS_FAULT_INJECTION is not set
# CONFIG_SCSI_UFS_HWMON is not set
# CONFIG_SCSI_UFSHCD_PCI is not set
CONFIG_SCSI_UFSHCD_PLATFORM=m
# CONFIG_SCSI_UFS_CDNS_PLATFORM is not set
# CONFIG_SCSI_UFS_DWC_TC_PLATFORM is not set
CONFIG_SCSI_UFS_HISI=m
CONFIG_SCSI_UFS_TI_J721E=m
CONFIG_SCSI_UFS_EXYNOS=m
CONFIG_MEMSTICK=m
# CONFIG_MEMSTICK_DEBUG is not set

#
# MemoryStick drivers
#
CONFIG_MEMSTICK_UNSAFE_RESUME=y
CONFIG_MSPRO_BLOCK=m
# CONFIG_MS_BLOCK is not set

#
# MemoryStick Host Controller Drivers
#
CONFIG_MEMSTICK_TIFM_MS=m
# CONFIG_MEMSTICK_JMICRON_38X is not set
CONFIG_MEMSTICK_R592=m
# CONFIG_NEW_LEDS is not set
CONFIG_ACCESSIBILITY=y

#
# Speakup console speech
#
# end of Speakup console speech

# CONFIG_INFINIBAND is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
CONFIG_RTC_SYSTOHC=y
CONFIG_RTC_SYSTOHC_DEVICE="rtc0"
CONFIG_RTC_DEBUG=y
# CONFIG_RTC_NVMEM is not set

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_DEV=y
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
CONFIG_RTC_DRV_88PM80X=m
CONFIG_RTC_DRV_ABB5ZES3=y
CONFIG_RTC_DRV_ABEOZ9=y
# CONFIG_RTC_DRV_ABX80X is not set
# CONFIG_RTC_DRV_BRCMSTB is not set
# CONFIG_RTC_DRV_DS1307 is not set
CONFIG_RTC_DRV_DS1374=y
CONFIG_RTC_DRV_DS1374_WDT=y
CONFIG_RTC_DRV_DS1672=m
CONFIG_RTC_DRV_HYM8563=m
# CONFIG_RTC_DRV_LP8788 is not set
CONFIG_RTC_DRV_MAX6900=m
# CONFIG_RTC_DRV_MAX8907 is not set
CONFIG_RTC_DRV_MAX8925=m
CONFIG_RTC_DRV_MAX8997=m
# CONFIG_RTC_DRV_MAX77686 is not set
CONFIG_RTC_DRV_RS5C372=m
# CONFIG_RTC_DRV_ISL1208 is not set
CONFIG_RTC_DRV_ISL12022=m
# CONFIG_RTC_DRV_ISL12026 is not set
CONFIG_RTC_DRV_X1205=y
CONFIG_RTC_DRV_PCF8523=y
CONFIG_RTC_DRV_PCF85063=y
CONFIG_RTC_DRV_PCF85363=m
# CONFIG_RTC_DRV_PCF8563 is not set
CONFIG_RTC_DRV_PCF8583=y
# CONFIG_RTC_DRV_M41T80 is not set
CONFIG_RTC_DRV_BQ32K=y
# CONFIG_RTC_DRV_PALMAS is not set
CONFIG_RTC_DRV_TPS6586X=m
CONFIG_RTC_DRV_S35390A=m
CONFIG_RTC_DRV_FM3130=y
CONFIG_RTC_DRV_RX8010=y
CONFIG_RTC_DRV_RX8581=m
# CONFIG_RTC_DRV_RX8025 is not set
CONFIG_RTC_DRV_EM3027=m
CONFIG_RTC_DRV_RV3028=y
CONFIG_RTC_DRV_RV3032=m
CONFIG_RTC_DRV_RV8803=m
CONFIG_RTC_DRV_S5M=m
CONFIG_RTC_DRV_SD3078=m

#
# SPI RTC drivers
#
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=m
CONFIG_RTC_DRV_DS3232_HWMON=y
CONFIG_RTC_DRV_PCF2127=m
# CONFIG_RTC_DRV_RV3029C2 is not set
# CONFIG_RTC_DRV_RX6110 is not set

#
# Platform RTC drivers
#
# CONFIG_RTC_DRV_DS1286 is not set
CONFIG_RTC_DRV_DS1511=m
CONFIG_RTC_DRV_DS1553=m
CONFIG_RTC_DRV_DS1685_FAMILY=m
# CONFIG_RTC_DRV_DS1685 is not set
# CONFIG_RTC_DRV_DS1689 is not set
CONFIG_RTC_DRV_DS17285=y
# CONFIG_RTC_DRV_DS17485 is not set
# CONFIG_RTC_DRV_DS17885 is not set
CONFIG_RTC_DRV_DS1742=y
CONFIG_RTC_DRV_DS2404=y
CONFIG_RTC_DRV_DA9052=m
CONFIG_RTC_DRV_DA9055=y
# CONFIG_RTC_DRV_DA9063 is not set
CONFIG_RTC_DRV_STK17TA8=y
CONFIG_RTC_DRV_M48T86=y
CONFIG_RTC_DRV_M48T35=y
CONFIG_RTC_DRV_M48T59=y
# CONFIG_RTC_DRV_MSM6242 is not set
CONFIG_RTC_DRV_BQ4802=m
# CONFIG_RTC_DRV_RP5C01 is not set
CONFIG_RTC_DRV_V3020=y
# CONFIG_RTC_DRV_GAMECUBE is not set
CONFIG_RTC_DRV_SC27XX=y
CONFIG_RTC_DRV_SPEAR=y
CONFIG_RTC_DRV_ZYNQMP=y

#
# on-CPU RTC drivers
#
CONFIG_RTC_DRV_ASM9260=m
CONFIG_RTC_DRV_DAVINCI=m
CONFIG_RTC_DRV_DIGICOLOR=m
CONFIG_RTC_DRV_FSL_FTM_ALARM=m
# CONFIG_RTC_DRV_MESON is not set
CONFIG_RTC_DRV_MESON_VRTC=m
CONFIG_RTC_DRV_OMAP=m
# CONFIG_RTC_DRV_S3C is not set
CONFIG_RTC_DRV_EP93XX=y
# CONFIG_RTC_DRV_VR41XX is not set
CONFIG_RTC_DRV_AT91RM9200=y
CONFIG_RTC_DRV_AT91SAM9=y
# CONFIG_RTC_DRV_RZN1 is not set
CONFIG_RTC_DRV_GENERIC=y
CONFIG_RTC_DRV_VT8500=m
CONFIG_RTC_DRV_SUNXI=y
# CONFIG_RTC_DRV_MV is not set
CONFIG_RTC_DRV_ARMADA38X=y
CONFIG_RTC_DRV_CADENCE=y
CONFIG_RTC_DRV_FTRTC010=y
CONFIG_RTC_DRV_STMP=m
CONFIG_RTC_DRV_MC13XXX=m
CONFIG_RTC_DRV_JZ4740=m
# CONFIG_RTC_DRV_LPC24XX is not set
CONFIG_RTC_DRV_LPC32XX=y
CONFIG_RTC_DRV_PM8XXX=y
CONFIG_RTC_DRV_TEGRA=m
# CONFIG_RTC_DRV_MXC is not set
# CONFIG_RTC_DRV_MXC_V2 is not set
CONFIG_RTC_DRV_SNVS=m
# CONFIG_RTC_DRV_MOXART is not set
# CONFIG_RTC_DRV_MT2712 is not set
CONFIG_RTC_DRV_MT6397=m
CONFIG_RTC_DRV_MT7622=m
CONFIG_RTC_DRV_XGENE=y
# CONFIG_RTC_DRV_R7301 is not set
CONFIG_RTC_DRV_STM32=y
CONFIG_RTC_DRV_RTD119X=y
CONFIG_RTC_DRV_ASPEED=m

#
# HID Sensor RTC drivers
#
# CONFIG_RTC_DRV_GOLDFISH is not set
# CONFIG_RTC_DRV_MSC313 is not set
# CONFIG_DMADEVICES is not set

#
# DMABUF options
#
# CONFIG_SYNC_FILE is not set
# CONFIG_UDMABUF is not set
CONFIG_DMABUF_MOVE_NOTIFY=y
# CONFIG_DMABUF_DEBUG is not set
CONFIG_DMABUF_SELFTESTS=m
CONFIG_DMABUF_HEAPS=y
CONFIG_DMABUF_SYSFS_STATS=y
# CONFIG_DMABUF_HEAPS_SYSTEM is not set
# end of DMABUF options

CONFIG_AUXDISPLAY=y
# CONFIG_CHARLCD is not set
# CONFIG_LINEDISP is not set
# CONFIG_HD44780_COMMON is not set
# CONFIG_HD44780 is not set
# CONFIG_IMG_ASCII_LCD is not set
# CONFIG_LCD2S is not set
# CONFIG_CHARLCD_BL_OFF is not set
# CONFIG_CHARLCD_BL_ON is not set
CONFIG_CHARLCD_BL_FLASH=y
CONFIG_UIO=y
# CONFIG_UIO_CIF is not set
CONFIG_UIO_PDRV_GENIRQ=y
CONFIG_UIO_DMEM_GENIRQ=y
CONFIG_UIO_AEC=m
CONFIG_UIO_SERCOS3=m
# CONFIG_UIO_PCI_GENERIC is not set
# CONFIG_UIO_NETX is not set
CONFIG_UIO_PRUSS=y
CONFIG_UIO_MF624=m
# CONFIG_VFIO is not set
CONFIG_VIRT_DRIVERS=y
CONFIG_VIRTIO=y
CONFIG_VIRTIO_PCI_LIB=m
CONFIG_VIRTIO_PCI_LIB_LEGACY=m
CONFIG_VIRTIO_MENU=y
CONFIG_VIRTIO_PCI=m
CONFIG_VIRTIO_PCI_LEGACY=y
CONFIG_VIRTIO_VDPA=m
# CONFIG_VIRTIO_BALLOON is not set
CONFIG_VIRTIO_INPUT=y
CONFIG_VIRTIO_MMIO=m
# CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES is not set
CONFIG_VDPA=y
CONFIG_IFCVF=m
# CONFIG_VP_VDPA is not set
# CONFIG_VHOST_MENU is not set

#
# Microsoft Hyper-V guest support
#
# end of Microsoft Hyper-V guest support

CONFIG_GREYBUS=m
# CONFIG_COMEDI is not set
# CONFIG_STAGING is not set
CONFIG_GOLDFISH=y
CONFIG_GOLDFISH_PIPE=y
# CONFIG_CHROME_PLATFORMS is not set
CONFIG_MELLANOX_PLATFORM=y
CONFIG_MLXREG_HOTPLUG=y
CONFIG_MLXREG_IO=m
# CONFIG_MLXREG_LC is not set
# CONFIG_NVSW_SN2201 is not set
# CONFIG_OLPC_XO175 is not set
CONFIG_SURFACE_PLATFORMS=y
# CONFIG_COMMON_CLK is not set
CONFIG_HWSPINLOCK=y
CONFIG_HWSPINLOCK_OMAP=y
CONFIG_HWSPINLOCK_QCOM=m
CONFIG_HWSPINLOCK_SPRD=y
CONFIG_HWSPINLOCK_STM32=m
# CONFIG_HWSPINLOCK_SUN6I is not set
CONFIG_HSEM_U8500=m

#
# Clock Source drivers
#
CONFIG_TIMER_OF=y
CONFIG_TIMER_PROBE=y
CONFIG_CLKSRC_MMIO=y
# CONFIG_BCM2835_TIMER is not set
CONFIG_BCM_KONA_TIMER=y
# CONFIG_DAVINCI_TIMER is not set
# CONFIG_DIGICOLOR_TIMER is not set
# CONFIG_DW_APB_TIMER is not set
CONFIG_FTTMR010_TIMER=y
# CONFIG_IXP4XX_TIMER is not set
CONFIG_MESON6_TIMER=y
# CONFIG_OWL_TIMER is not set
# CONFIG_RDA_TIMER is not set
# CONFIG_SUN4I_TIMER is not set
CONFIG_TEGRA_TIMER=y
CONFIG_VT8500_TIMER=y
# CONFIG_NPCM7XX_TIMER is not set
CONFIG_ASM9260_TIMER=y
CONFIG_CLKSRC_DBX500_PRCMU=y
CONFIG_CLPS711X_TIMER=y
# CONFIG_MXS_TIMER is not set
# CONFIG_NSPIRE_TIMER is not set
CONFIG_INTEGRATOR_AP_TIMER=y
# CONFIG_CLKSRC_PISTACHIO is not set
# CONFIG_CLKSRC_STM32_LP is not set
CONFIG_ARMV7M_SYSTICK=y
CONFIG_ATMEL_PIT=y
# CONFIG_ATMEL_ST is not set
# CONFIG_CLKSRC_SAMSUNG_PWM is not set
CONFIG_FSL_FTM_TIMER=y
# CONFIG_OXNAS_RPS_TIMER is not set
CONFIG_MTK_TIMER=y
CONFIG_SPRD_TIMER=y
CONFIG_CLKSRC_JCORE_PIT=y
CONFIG_SH_TIMER_CMT=y
# CONFIG_SH_TIMER_MTU2 is not set
CONFIG_RENESAS_OSTM=y
CONFIG_SH_TIMER_TMU=y
CONFIG_EM_TIMER_STI=y
# CONFIG_CLKSRC_PXA is not set
CONFIG_TIMER_IMX_SYS_CTR=y
CONFIG_CLKSRC_ST_LPC=y
# CONFIG_GXP_TIMER is not set
# CONFIG_MSC313E_TIMER is not set
# CONFIG_MICROCHIP_PIT64B is not set
# end of Clock Source drivers

# CONFIG_MAILBOX is not set
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
CONFIG_IOMMU_IO_PGTABLE=y
CONFIG_IOMMU_IO_PGTABLE_ARMV7S=y
CONFIG_IOMMU_IO_PGTABLE_ARMV7S_SELFTEST=y
# end of Generic IOMMU Pagetable Support

# CONFIG_IOMMU_DEBUGFS is not set
CONFIG_IOMMU_DEFAULT_DMA_STRICT=y
# CONFIG_IOMMU_DEFAULT_DMA_LAZY is not set
# CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
CONFIG_OF_IOMMU=y
# CONFIG_OMAP_IOMMU is not set
CONFIG_ROCKCHIP_IOMMU=y
# CONFIG_SUN50I_IOMMU is not set
# CONFIG_S390_CCW_IOMMU is not set
# CONFIG_S390_AP_IOMMU is not set
CONFIG_MTK_IOMMU=y
# CONFIG_SPRD_IOMMU is not set

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
CONFIG_RPMSG=y
CONFIG_RPMSG_CHAR=y
# CONFIG_RPMSG_CTRL is not set
CONFIG_RPMSG_NS=y
CONFIG_RPMSG_VIRTIO=y
# end of Rpmsg drivers

CONFIG_SOUNDWIRE=m

#
# SoundWire Devices
#

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#
CONFIG_MESON_CANVAS=m
CONFIG_MESON_CLK_MEASURE=y
CONFIG_MESON_GX_SOCINFO=y
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
CONFIG_ASPEED_LPC_CTRL=y
# CONFIG_ASPEED_LPC_SNOOP is not set
# CONFIG_ASPEED_UART_ROUTING is not set
# CONFIG_ASPEED_P2A_CTRL is not set
# CONFIG_ASPEED_SOCINFO is not set
# end of ASPEED SoC drivers

# CONFIG_AT91_SOC_ID is not set
CONFIG_AT91_SOC_SFR=m

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
# i.MX SoC drivers
#
# CONFIG_SOC_IMX8M is not set
# end of i.MX SoC drivers

#
# IXP4xx SoC drivers
#
CONFIG_IXP4XX_QMGR=y
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
# CONFIG_MTK_CMDQ is not set
# CONFIG_MTK_DEVAPC is not set
CONFIG_MTK_INFRACFG=y
CONFIG_MTK_PMIC_WRAP=y
# CONFIG_MTK_SCPSYS is not set
# CONFIG_MTK_MMSYS is not set
# end of MediaTek SoC drivers

#
# Qualcomm SoC drivers
#
CONFIG_QCOM_GENI_SE=y
# CONFIG_QCOM_GSBI is not set
CONFIG_QCOM_LLCC=y
CONFIG_QCOM_RPMH=y
# CONFIG_QCOM_SMEM is not set
# CONFIG_QCOM_SMD_RPM is not set
# CONFIG_QCOM_SPM is not set
CONFIG_QCOM_WCNSS_CTRL=y
# CONFIG_QCOM_APR is not set
# end of Qualcomm SoC drivers

# CONFIG_SOC_RENESAS is not set
# CONFIG_ROCKCHIP_GRF is not set
CONFIG_ROCKCHIP_IODOMAIN=m
CONFIG_SOC_SAMSUNG=y
# CONFIG_EXYNOS_ASV_ARM is not set
CONFIG_EXYNOS_CHIPID=y
# CONFIG_EXYNOS_USI is not set
CONFIG_EXYNOS_PM_DOMAINS=y
# CONFIG_EXYNOS_REGULATOR_COUPLER is not set
CONFIG_SOC_TEGRA20_VOLTAGE_COUPLER=y
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
CONFIG_DEVFREQ_GOV_PERFORMANCE=y
# CONFIG_DEVFREQ_GOV_POWERSAVE is not set
CONFIG_DEVFREQ_GOV_USERSPACE=y
CONFIG_DEVFREQ_GOV_PASSIVE=m

#
# DEVFREQ Drivers
#
CONFIG_ARM_EXYNOS_BUS_DEVFREQ=m
CONFIG_ARM_IMX_BUS_DEVFREQ=m
CONFIG_PM_DEVFREQ_EVENT=y
CONFIG_DEVFREQ_EVENT_EXYNOS_NOCP=m
CONFIG_DEVFREQ_EVENT_EXYNOS_PPMU=m
CONFIG_DEVFREQ_EVENT_ROCKCHIP_DFI=y
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
CONFIG_EXTCON_ADC_JACK=y
# CONFIG_EXTCON_FSA9480 is not set
CONFIG_EXTCON_GPIO=m
CONFIG_EXTCON_MAX3355=y
CONFIG_EXTCON_MAX77843=y
# CONFIG_EXTCON_MAX8997 is not set
CONFIG_EXTCON_PALMAS=m
CONFIG_EXTCON_PTN5150=y
# CONFIG_EXTCON_QCOM_SPMI_MISC is not set
# CONFIG_EXTCON_RT8973A is not set
CONFIG_EXTCON_SM5502=y
CONFIG_EXTCON_USB_GPIO=y
# CONFIG_EXTCON_USBC_TUSB320 is not set
CONFIG_MEMORY=y
CONFIG_DDR=y
# CONFIG_ATMEL_SDRAMC is not set
# CONFIG_ATMEL_EBI is not set
# CONFIG_BRCMSTB_DPFE is not set
# CONFIG_BT1_L2_CTL is not set
# CONFIG_TI_AEMIF is not set
CONFIG_TI_EMIF=y
# CONFIG_MVEBU_DEVBUS is not set
CONFIG_FSL_CORENET_CF=y
CONFIG_FSL_IFC=y
CONFIG_JZ4780_NEMC=y
CONFIG_MTK_SMI=y
CONFIG_DA8XX_DDRCTL=y
CONFIG_RENESAS_RPCIF=y
CONFIG_STM32_FMC2_EBI=y
# CONFIG_SAMSUNG_MC is not set
CONFIG_IIO=y
CONFIG_IIO_BUFFER=y
CONFIG_IIO_BUFFER_CB=y
CONFIG_IIO_BUFFER_DMA=y
CONFIG_IIO_BUFFER_DMAENGINE=y
CONFIG_IIO_BUFFER_HW_CONSUMER=m
CONFIG_IIO_KFIFO_BUF=y
CONFIG_IIO_TRIGGERED_BUFFER=y
CONFIG_IIO_CONFIGFS=m
CONFIG_IIO_TRIGGER=y
CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
# CONFIG_IIO_SW_DEVICE is not set
CONFIG_IIO_SW_TRIGGER=m
# CONFIG_IIO_TRIGGERED_EVENT is not set

#
# Accelerometers
#
# CONFIG_ADXL313_I2C is not set
# CONFIG_ADXL355_I2C is not set
# CONFIG_ADXL367_I2C is not set
CONFIG_ADXL372=y
CONFIG_ADXL372_I2C=y
CONFIG_BMA400=y
CONFIG_BMA400_I2C=y
# CONFIG_BMC150_ACCEL is not set
# CONFIG_DA280 is not set
CONFIG_DA311=y
# CONFIG_DMARD06 is not set
CONFIG_DMARD09=y
CONFIG_DMARD10=m
# CONFIG_FXLS8962AF_I2C is not set
# CONFIG_IIO_ST_ACCEL_3AXIS is not set
# CONFIG_KXSD9 is not set
# CONFIG_KXCJK1013 is not set
CONFIG_MC3230=m
# CONFIG_MMA7455_I2C is not set
CONFIG_MMA7660=m
CONFIG_MMA8452=m
CONFIG_MMA9551_CORE=y
CONFIG_MMA9551=y
CONFIG_MMA9553=m
CONFIG_MXC4005=m
# CONFIG_MXC6255 is not set
# CONFIG_STK8312 is not set
CONFIG_STK8BA50=y
# end of Accelerometers

#
# Analog to digital converters
#
# CONFIG_AD7091R5 is not set
CONFIG_AD7291=y
# CONFIG_AD7606_IFACE_PARALLEL is not set
CONFIG_AD799X=y
# CONFIG_ADI_AXI_ADC is not set
CONFIG_AT91_ADC=y
CONFIG_AT91_SAMA5D2_ADC=m
# CONFIG_BCM_IPROC_ADC is not set
# CONFIG_BERLIN2_ADC is not set
# CONFIG_DA9150_GPADC is not set
CONFIG_ENVELOPE_DETECTOR=y
# CONFIG_EXYNOS_ADC is not set
CONFIG_MXS_LRADC_ADC=m
CONFIG_HX711=y
CONFIG_INA2XX_ADC=m
CONFIG_INGENIC_ADC=m
# CONFIG_IMX7D_ADC is not set
# CONFIG_IMX8QXP_ADC is not set
# CONFIG_LP8788_ADC is not set
CONFIG_LPC18XX_ADC=m
CONFIG_LPC32XX_ADC=m
CONFIG_LTC2471=y
# CONFIG_LTC2485 is not set
CONFIG_LTC2497=y
CONFIG_MAX1363=y
# CONFIG_MAX9611 is not set
CONFIG_MCP3422=y
# CONFIG_MEDIATEK_MT6360_ADC is not set
CONFIG_MEDIATEK_MT6577_AUXADC=m
# CONFIG_MEN_Z188_ADC is not set
# CONFIG_MP2629_ADC is not set
CONFIG_NAU7802=m
# CONFIG_NPCM_ADC is not set
CONFIG_PALMAS_GPADC=y
CONFIG_RCAR_GYRO_ADC=m
CONFIG_ROCKCHIP_SARADC=m
# CONFIG_RZG2L_ADC is not set
# CONFIG_SC27XX_ADC is not set
# CONFIG_SPEAR_ADC is not set
CONFIG_SD_ADC_MODULATOR=m
# CONFIG_STM32_ADC_CORE is not set
CONFIG_STM32_DFSDM_CORE=m
CONFIG_STM32_DFSDM_ADC=m
CONFIG_SUN4I_GPADC=y
# CONFIG_TI_ADC081C is not set
CONFIG_TI_ADS1015=m
CONFIG_VF610_ADC=m
CONFIG_XILINX_XADC=y
# CONFIG_XILINX_AMS is not set
# end of Analog to digital converters

#
# Analog to digital and digital to analog converters
#
# end of Analog to digital and digital to analog converters

#
# Analog Front Ends
#
# CONFIG_IIO_RESCALE is not set
# end of Analog Front Ends

#
# Amplifiers
#
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
CONFIG_ATLAS_PH_SENSOR=y
CONFIG_ATLAS_EZO_SENSOR=y
# CONFIG_BME680 is not set
CONFIG_CCS811=y
CONFIG_IAQCORE=y
# CONFIG_PMS7003 is not set
CONFIG_SCD30_CORE=y
# CONFIG_SCD30_I2C is not set
CONFIG_SCD30_SERIAL=m
# CONFIG_SCD4X is not set
# CONFIG_SENSIRION_SGP30 is not set
# CONFIG_SENSIRION_SGP40 is not set
# CONFIG_SPS30_I2C is not set
# CONFIG_SPS30_SERIAL is not set
# CONFIG_SENSEAIR_SUNRISE_CO2 is not set
CONFIG_VZ89X=m
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

CONFIG_IIO_ST_SENSORS_I2C=y
CONFIG_IIO_ST_SENSORS_CORE=y

#
# Digital to analog converters
#
CONFIG_AD5064=y
# CONFIG_AD5380 is not set
CONFIG_AD5446=y
# CONFIG_AD5593R is not set
CONFIG_AD5686=m
CONFIG_AD5696_I2C=m
CONFIG_DPOT_DAC=y
# CONFIG_DS4424 is not set
CONFIG_LPC18XX_DAC=y
CONFIG_M62332=m
CONFIG_MAX517=m
CONFIG_MAX5821=y
CONFIG_MCP4725=y
# CONFIG_STM32_DAC is not set
# CONFIG_TI_DAC5571 is not set
# CONFIG_VF610_DAC is not set
# end of Digital to analog converters

#
# IIO dummy driver
#
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
CONFIG_BMG160=m
CONFIG_BMG160_I2C=m
CONFIG_FXAS21002C=m
CONFIG_FXAS21002C_I2C=m
# CONFIG_MPU3050_I2C is not set
# CONFIG_IIO_ST_GYRO_3AXIS is not set
CONFIG_ITG3200=m
# end of Digital gyroscope sensors

#
# Health Sensors
#

#
# Heart Rate Monitors
#
# CONFIG_AFE4404 is not set
CONFIG_MAX30100=y
# CONFIG_MAX30102 is not set
# end of Heart Rate Monitors
# end of Health Sensors

#
# Humidity sensors
#
CONFIG_AM2315=y
CONFIG_DHT11=y
CONFIG_HDC100X=y
CONFIG_HDC2010=m
CONFIG_HTS221=m
CONFIG_HTS221_I2C=m
CONFIG_HTU21=m
CONFIG_SI7005=m
# CONFIG_SI7020 is not set
# end of Humidity sensors

#
# Inertial measurement units
#
CONFIG_BMI160=m
CONFIG_BMI160_I2C=m
CONFIG_FXOS8700=m
CONFIG_FXOS8700_I2C=m
CONFIG_KMX61=y
CONFIG_INV_ICM42600=y
CONFIG_INV_ICM42600_I2C=y
# CONFIG_INV_MPU6050_I2C is not set
CONFIG_IIO_ST_LSM6DSX=y
CONFIG_IIO_ST_LSM6DSX_I2C=y
# CONFIG_IIO_ST_LSM9DS0 is not set
# end of Inertial measurement units

#
# Light sensors
#
CONFIG_ADJD_S311=m
CONFIG_ADUX1020=m
CONFIG_AL3010=y
CONFIG_AL3320A=m
CONFIG_APDS9300=m
# CONFIG_APDS9960 is not set
CONFIG_AS73211=m
# CONFIG_BH1750 is not set
CONFIG_BH1780=y
# CONFIG_CM32181 is not set
CONFIG_CM3232=y
CONFIG_CM3323=y
# CONFIG_CM3605 is not set
CONFIG_CM36651=m
# CONFIG_GP2AP002 is not set
CONFIG_GP2AP020A00F=m
CONFIG_IQS621_ALS=m
CONFIG_SENSORS_ISL29018=y
CONFIG_SENSORS_ISL29028=m
CONFIG_ISL29125=m
# CONFIG_JSA1212 is not set
CONFIG_RPR0521=y
# CONFIG_SENSORS_LM3533 is not set
# CONFIG_LTR501 is not set
CONFIG_LV0104CS=y
# CONFIG_MAX44000 is not set
CONFIG_MAX44009=y
CONFIG_NOA1305=m
CONFIG_OPT3001=y
CONFIG_PA12203001=y
CONFIG_SI1133=m
CONFIG_SI1145=y
CONFIG_STK3310=m
CONFIG_ST_UVIS25=y
CONFIG_ST_UVIS25_I2C=y
CONFIG_TCS3414=m
CONFIG_TCS3472=y
CONFIG_SENSORS_TSL2563=y
CONFIG_TSL2583=m
# CONFIG_TSL2591 is not set
CONFIG_TSL2772=m
# CONFIG_TSL4531 is not set
CONFIG_US5182D=m
# CONFIG_VCNL4000 is not set
CONFIG_VCNL4035=y
CONFIG_VEML6030=m
CONFIG_VEML6070=y
CONFIG_VL6180=m
# CONFIG_ZOPT2201 is not set
# end of Light sensors

#
# Magnetometer sensors
#
# CONFIG_AK8974 is not set
CONFIG_AK8975=y
CONFIG_AK09911=y
# CONFIG_BMC150_MAGN_I2C is not set
# CONFIG_MAG3110 is not set
CONFIG_MMC35240=m
CONFIG_IIO_ST_MAGN_3AXIS=m
CONFIG_IIO_ST_MAGN_I2C_3AXIS=m
CONFIG_SENSORS_HMC5843=m
CONFIG_SENSORS_HMC5843_I2C=m
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
CONFIG_IIO_HRTIMER_TRIGGER=m
# CONFIG_IIO_INTERRUPT_TRIGGER is not set
CONFIG_IIO_STM32_LPTIMER_TRIGGER=y
CONFIG_IIO_STM32_TIMER_TRIGGER=y
# CONFIG_IIO_TIGHTLOOP_TRIGGER is not set
CONFIG_IIO_SYSFS_TRIGGER=y
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
# CONFIG_DS1803 is not set
CONFIG_MAX5432=y
# CONFIG_MCP4018 is not set
CONFIG_MCP4531=y
CONFIG_TPL0102=y
# end of Digital potentiometers

#
# Digital potentiostats
#
CONFIG_LMP91000=m
# end of Digital potentiostats

#
# Pressure sensors
#
CONFIG_ABP060MG=y
CONFIG_BMP280=y
CONFIG_BMP280_I2C=y
# CONFIG_DLHL60D is not set
CONFIG_DPS310=y
CONFIG_HP03=m
# CONFIG_ICP10100 is not set
CONFIG_MPL115=m
CONFIG_MPL115_I2C=m
# CONFIG_MPL3115 is not set
CONFIG_MS5611=y
CONFIG_MS5611_I2C=y
CONFIG_MS5637=y
CONFIG_IIO_ST_PRESS=y
CONFIG_IIO_ST_PRESS_I2C=y
CONFIG_T5403=m
CONFIG_HP206C=y
CONFIG_ZPA2326=m
CONFIG_ZPA2326_I2C=m
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
# CONFIG_MB1232 is not set
CONFIG_PING=m
CONFIG_RFD77402=y
CONFIG_SRF04=y
CONFIG_SX_COMMON=m
CONFIG_SX9310=m
# CONFIG_SX9324 is not set
# CONFIG_SX9360 is not set
# CONFIG_SX9500 is not set
# CONFIG_SRF08 is not set
CONFIG_VCNL3020=y
CONFIG_VL53L0X_I2C=y
# end of Proximity and distance sensors

#
# Resolver to digital converters
#
# end of Resolver to digital converters

#
# Temperature sensors
#
# CONFIG_IQS620AT_TEMP is not set
# CONFIG_MLX90614 is not set
CONFIG_MLX90632=y
CONFIG_TMP006=m
# CONFIG_TMP007 is not set
# CONFIG_TMP117 is not set
CONFIG_TSYS01=m
# CONFIG_TSYS02D is not set
# end of Temperature sensors

CONFIG_NTB=y
CONFIG_NTB_MSI=y
CONFIG_NTB_IDT=m
# CONFIG_NTB_EPF is not set
# CONFIG_NTB_SWITCHTEC is not set
# CONFIG_NTB_PINGPONG is not set
CONFIG_NTB_TOOL=y
CONFIG_NTB_PERF=y
CONFIG_NTB_MSI_TEST=y
CONFIG_NTB_TRANSPORT=m
# CONFIG_VME_BUS is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
CONFIG_PWM_DEBUG=y
CONFIG_PWM_ATMEL=m
# CONFIG_PWM_ATMEL_TCB is not set
CONFIG_PWM_BCM2835=y
CONFIG_PWM_BERLIN=m
CONFIG_PWM_BRCMSTB=y
CONFIG_PWM_CLPS711X=m
# CONFIG_PWM_DWC is not set
CONFIG_PWM_EP93XX=y
CONFIG_PWM_FSL_FTM=m
CONFIG_PWM_HIBVT=m
CONFIG_PWM_IMX1=y
CONFIG_PWM_IMX27=y
# CONFIG_PWM_INTEL_LGM is not set
CONFIG_PWM_IQS620A=m
CONFIG_PWM_LPC18XX_SCT=y
# CONFIG_PWM_LPC32XX is not set
# CONFIG_PWM_LPSS_PCI is not set
# CONFIG_PWM_LPSS_PLATFORM is not set
# CONFIG_PWM_MTK_DISP is not set
CONFIG_PWM_MEDIATEK=m
CONFIG_PWM_MXS=m
CONFIG_PWM_OMAP_DMTIMER=m
CONFIG_PWM_PCA9685=y
# CONFIG_PWM_PXA is not set
# CONFIG_PWM_RASPBERRYPI_POE is not set
# CONFIG_PWM_RCAR is not set
CONFIG_PWM_RENESAS_TPU=y
CONFIG_PWM_ROCKCHIP=y
CONFIG_PWM_SAMSUNG=m
CONFIG_PWM_SL28CPLD=y
CONFIG_PWM_SPEAR=y
CONFIG_PWM_SPRD=y
CONFIG_PWM_STI=m
CONFIG_PWM_STM32=m
CONFIG_PWM_STM32_LP=y
# CONFIG_PWM_SUNPLUS is not set
# CONFIG_PWM_TEGRA is not set
CONFIG_PWM_TIECAP=y
# CONFIG_PWM_TIEHRPWM is not set
# CONFIG_PWM_VISCONTI is not set
CONFIG_PWM_VT8500=m

#
# IRQ chip support
#
# CONFIG_AL_FIC is not set
CONFIG_MADERA_IRQ=m
CONFIG_JCORE_AIC=y
CONFIG_RENESAS_INTC_IRQPIN=y
CONFIG_RENESAS_IRQC=y
# CONFIG_RENESAS_RZA1_IRQC is not set
CONFIG_SL28CPLD_INTC=y
CONFIG_TS4800_IRQ=m
# CONFIG_INGENIC_TCU_IRQ is not set
# CONFIG_IRQ_UNIPHIER_AIDET is not set
# CONFIG_MESON_IRQ_GPIO is not set
CONFIG_IMX_IRQSTEER=y
# CONFIG_IMX_INTMUX is not set
CONFIG_EXYNOS_IRQ_COMBINER=y
# CONFIG_LOONGSON_PCH_PIC is not set
# CONFIG_LOONGSON_PCH_MSI is not set
CONFIG_MST_IRQ=y
# CONFIG_MCHP_EIC is not set
# end of IRQ chip support

CONFIG_IPACK_BUS=y
# CONFIG_BOARD_TPCI200 is not set
CONFIG_RESET_CONTROLLER=y
# CONFIG_RESET_ATH79 is not set
# CONFIG_RESET_AXS10X is not set
# CONFIG_RESET_BCM6345 is not set
CONFIG_RESET_BERLIN=y
CONFIG_RESET_BRCMSTB=m
# CONFIG_RESET_BRCMSTB_RESCAL is not set
# CONFIG_RESET_HSDK is not set
CONFIG_RESET_IMX7=y
CONFIG_RESET_INTEL_GW=y
# CONFIG_RESET_K210 is not set
# CONFIG_RESET_LANTIQ is not set
CONFIG_RESET_LPC18XX=y
# CONFIG_RESET_MCHP_SPARX5 is not set
CONFIG_RESET_MESON=y
CONFIG_RESET_MESON_AUDIO_ARB=m
# CONFIG_RESET_NPCM is not set
CONFIG_RESET_PISTACHIO=y
# CONFIG_RESET_QCOM_AOSS is not set
CONFIG_RESET_QCOM_PDC=y
# CONFIG_RESET_RASPBERRYPI is not set
# CONFIG_RESET_RZG2L_USBPHY_CTRL is not set
# CONFIG_RESET_SCMI is not set
CONFIG_RESET_SIMPLE=y
# CONFIG_RESET_SOCFPGA is not set
# CONFIG_RESET_STARFIVE_JH7100 is not set
CONFIG_RESET_SUNXI=y
# CONFIG_RESET_TI_SCI is not set
CONFIG_RESET_TI_SYSCON=m
# CONFIG_RESET_TN48M_CPLD is not set
CONFIG_RESET_UNIPHIER=y
CONFIG_RESET_UNIPHIER_GLUE=m
# CONFIG_RESET_ZYNQ is not set
# CONFIG_COMMON_RESET_HI3660 is not set
# CONFIG_COMMON_RESET_HI6220 is not set

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
CONFIG_GENERIC_PHY_MIPI_DPHY=y
CONFIG_PHY_LPC18XX_USB_OTG=m
# CONFIG_PHY_PISTACHIO_USB is not set
# CONFIG_PHY_XGENE is not set
# CONFIG_PHY_CAN_TRANSCEIVER is not set
CONFIG_PHY_SUN50I_USB3=m
# CONFIG_PHY_MESON8_HDMI_TX is not set
CONFIG_PHY_MESON_G12A_USB2=m
CONFIG_PHY_MESON_G12A_USB3_PCIE=y
# CONFIG_PHY_MESON_AXG_PCIE is not set
CONFIG_PHY_MESON_AXG_MIPI_PCIE_ANALOG=m
# CONFIG_PHY_MESON_AXG_MIPI_DPHY is not set

#
# PHY drivers for Broadcom platforms
#
CONFIG_PHY_BCM63XX_USBH=y
# CONFIG_PHY_CYGNUS_PCIE is not set
# CONFIG_PHY_BCM_SR_USB is not set
CONFIG_BCM_KONA_USB2_PHY=y
CONFIG_PHY_BCM_NS_USB2=y
CONFIG_PHY_BCM_NS_USB3=y
CONFIG_PHY_NS2_PCIE=m
CONFIG_PHY_NS2_USB_DRD=m
CONFIG_PHY_BRCM_SATA=y
# CONFIG_PHY_BRCM_USB is not set
CONFIG_PHY_BCM_SR_PCIE=y
# end of PHY drivers for Broadcom platforms

# CONFIG_PHY_CADENCE_DPHY is not set
# CONFIG_PHY_CADENCE_DPHY_RX is not set
CONFIG_PHY_CADENCE_SALVO=y
CONFIG_PHY_FSL_IMX8MQ_USB=m
CONFIG_PHY_MIXEL_MIPI_DPHY=m
# CONFIG_PHY_FSL_IMX8M_PCIE is not set
# CONFIG_PHY_FSL_LYNX_28G is not set
# CONFIG_PHY_HI6220_USB is not set
CONFIG_PHY_HI3660_USB=m
# CONFIG_PHY_HI3670_USB is not set
# CONFIG_PHY_HI3670_PCIE is not set
# CONFIG_PHY_HISTB_COMBPHY is not set
CONFIG_PHY_HISI_INNO_USB2=y
# CONFIG_PHY_LANTIQ_VRX200_PCIE is not set
CONFIG_PHY_LANTIQ_RCU_USB2=y
# CONFIG_ARMADA375_USBCLUSTER_PHY is not set
CONFIG_PHY_BERLIN_SATA=y
CONFIG_PHY_BERLIN_USB=m
CONFIG_PHY_MVEBU_A3700_UTMI=y
CONFIG_PHY_MVEBU_A38X_COMPHY=y
# CONFIG_PHY_PXA_28NM_HSIC is not set
CONFIG_PHY_PXA_28NM_USB2=m
# CONFIG_PHY_PXA_USB is not set
# CONFIG_PHY_MMP3_USB is not set
# CONFIG_PHY_MMP3_HSIC is not set
CONFIG_PHY_MTK_UFS=y
# CONFIG_PHY_SPARX5_SERDES is not set
# CONFIG_PHY_LAN966X_SERDES is not set
CONFIG_PHY_OCELOT_SERDES=m
CONFIG_PHY_ATH79_USB=y
CONFIG_PHY_QCOM_IPQ4019_USB=m
# CONFIG_PHY_QCOM_QUSB2 is not set
CONFIG_PHY_QCOM_USB_SNPS_FEMTO_V2=y
CONFIG_PHY_QCOM_USB_HS_28NM=y
CONFIG_PHY_QCOM_USB_SS=m
CONFIG_PHY_QCOM_IPQ806X_USB=y
# CONFIG_PHY_MT7621_PCI is not set
CONFIG_PHY_RALINK_USB=y
CONFIG_PHY_RCAR_GEN3_USB3=m
CONFIG_PHY_ROCKCHIP_DPHY_RX0=m
# CONFIG_PHY_ROCKCHIP_INNO_CSIDPHY is not set
# CONFIG_PHY_ROCKCHIP_INNO_DSIDPHY is not set
CONFIG_PHY_ROCKCHIP_PCIE=m
CONFIG_PHY_ROCKCHIP_TYPEC=m
CONFIG_PHY_EXYNOS_DP_VIDEO=m
CONFIG_PHY_EXYNOS_MIPI_VIDEO=y
CONFIG_PHY_EXYNOS_PCIE=y
CONFIG_PHY_SAMSUNG_UFS=y
# CONFIG_PHY_SAMSUNG_USB2 is not set
CONFIG_PHY_UNIPHIER_USB2=y
# CONFIG_PHY_UNIPHIER_USB3 is not set
CONFIG_PHY_UNIPHIER_PCIE=y
# CONFIG_PHY_UNIPHIER_AHCI is not set
# CONFIG_PHY_ST_SPEAR1310_MIPHY is not set
CONFIG_PHY_ST_SPEAR1340_MIPHY=m
CONFIG_PHY_STIH407_USB=y
CONFIG_PHY_TEGRA194_P2U=y
# CONFIG_PHY_DA8XX_USB is not set
# CONFIG_OMAP_CONTROL_PHY is not set
# CONFIG_TI_PIPE3 is not set
CONFIG_PHY_TI_GMII_SEL=m
CONFIG_PHY_INTEL_KEEMBAY_EMMC=m
# CONFIG_PHY_INTEL_KEEMBAY_USB is not set
CONFIG_PHY_INTEL_LGM_COMBO=y
# CONFIG_PHY_INTEL_LGM_EMMC is not set
# CONFIG_PHY_INTEL_THUNDERBAY_EMMC is not set
# CONFIG_PHY_XILINX_ZYNQMP is not set
# end of PHY Subsystem

CONFIG_POWERCAP=y
# CONFIG_DTPM is not set
CONFIG_MCB=y
CONFIG_MCB_PCI=y
# CONFIG_MCB_LPC is not set
CONFIG_RAS=y
# CONFIG_USB4 is not set

#
# Android
#
# CONFIG_ANDROID is not set
# end of Android

CONFIG_DAX=y
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y
# CONFIG_NVMEM_IMX_IIM is not set
CONFIG_NVMEM_IMX_OCOTP=m
# CONFIG_JZ4780_EFUSE is not set
CONFIG_NVMEM_LPC18XX_EEPROM=m
CONFIG_NVMEM_LPC18XX_OTP=m
# CONFIG_NVMEM_MXS_OCOTP is not set
# CONFIG_MTK_EFUSE is not set
# CONFIG_NVMEM_NINTENDO_OTP is not set
# CONFIG_QCOM_QFPROM is not set
# CONFIG_ROCKCHIP_EFUSE is not set
# CONFIG_ROCKCHIP_OTP is not set
CONFIG_NVMEM_BCM_OCOTP=m
# CONFIG_NVMEM_STM32_ROMEM is not set
# CONFIG_UNIPHIER_EFUSE is not set
# CONFIG_NVMEM_VF610_OCOTP is not set
# CONFIG_MESON_MX_EFUSE is not set
# CONFIG_NVMEM_SNVS_LPGPR is not set
# CONFIG_RAVE_SP_EEPROM is not set
# CONFIG_SC27XX_EFUSE is not set
# CONFIG_SPRD_EFUSE is not set
# CONFIG_NVMEM_RMEM is not set
# CONFIG_NVMEM_BRCM_NVRAM is not set
# CONFIG_NVMEM_LAYERSCAPE_SFP is not set
# CONFIG_NVMEM_SUNPLUS_OCOTP is not set
# CONFIG_NVMEM_APPLE_EFUSES is not set

#
# HW tracing support
#
CONFIG_STM=y
# CONFIG_STM_PROTO_BASIC is not set
CONFIG_STM_PROTO_SYS_T=y
CONFIG_STM_DUMMY=y
CONFIG_STM_SOURCE_CONSOLE=m
CONFIG_STM_SOURCE_HEARTBEAT=m
CONFIG_INTEL_TH=y
CONFIG_INTEL_TH_PCI=y
# CONFIG_INTEL_TH_GTH is not set
CONFIG_INTEL_TH_STH=y
CONFIG_INTEL_TH_MSU=y
# CONFIG_INTEL_TH_PTI is not set
CONFIG_INTEL_TH_DEBUG=y
# end of HW tracing support

# CONFIG_FPGA is not set
CONFIG_FSI=y
CONFIG_FSI_NEW_DEV_NODE=y
CONFIG_FSI_MASTER_GPIO=y
# CONFIG_FSI_MASTER_HUB is not set
CONFIG_FSI_MASTER_ASPEED=m
CONFIG_FSI_SCOM=m
CONFIG_TEE=y
CONFIG_MULTIPLEXER=m

#
# Multiplexer drivers
#
CONFIG_MUX_ADG792A=m
CONFIG_MUX_GPIO=m
CONFIG_MUX_MMIO=m
# end of Multiplexer drivers

CONFIG_PM_OPP=y
CONFIG_SIOX=m
CONFIG_SIOX_BUS_GPIO=m
CONFIG_SLIMBUS=m
CONFIG_SLIM_QCOM_CTRL=m
# CONFIG_INTERCONNECT is not set
CONFIG_COUNTER=m
# CONFIG_104_QUAD_8 is not set
# CONFIG_INTERRUPT_CNT is not set
CONFIG_STM32_TIMER_CNT=m
# CONFIG_STM32_LPTIMER_CNT is not set
CONFIG_TI_EQEP=m
# CONFIG_FTM_QUADDEC is not set
CONFIG_MICROCHIP_TCB_CAPTURE=m
# CONFIG_INTEL_QEP is not set
# CONFIG_MOST is not set
# CONFIG_PECI is not set
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
# CONFIG_EXT4_FS is not set
CONFIG_JBD2=m
CONFIG_JBD2_DEBUG=y
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=m
# CONFIG_REISERFS_CHECK is not set
CONFIG_REISERFS_FS_XATTR=y
CONFIG_REISERFS_FS_POSIX_ACL=y
# CONFIG_REISERFS_FS_SECURITY is not set
CONFIG_JFS_FS=m
# CONFIG_JFS_POSIX_ACL is not set
CONFIG_JFS_SECURITY=y
CONFIG_JFS_DEBUG=y
CONFIG_JFS_STATISTICS=y
CONFIG_XFS_FS=y
CONFIG_XFS_SUPPORT_V4=y
CONFIG_XFS_QUOTA=y
# CONFIG_XFS_POSIX_ACL is not set
# CONFIG_XFS_RT is not set
# CONFIG_XFS_ONLINE_SCRUB is not set
# CONFIG_XFS_WARN is not set
# CONFIG_XFS_DEBUG is not set
CONFIG_GFS2_FS=m
CONFIG_OCFS2_FS=m
CONFIG_OCFS2_FS_O2CB=m
# CONFIG_OCFS2_FS_STATS is not set
# CONFIG_OCFS2_DEBUG_MASKLOG is not set
# CONFIG_OCFS2_DEBUG_FS is not set
CONFIG_BTRFS_FS=y
CONFIG_BTRFS_FS_POSIX_ACL=y
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
CONFIG_BTRFS_FS_RUN_SANITY_TESTS=y
# CONFIG_BTRFS_DEBUG is not set
CONFIG_BTRFS_ASSERT=y
# CONFIG_BTRFS_FS_REF_VERIFY is not set
CONFIG_NILFS2_FS=y
CONFIG_F2FS_FS=m
CONFIG_F2FS_STAT_FS=y
CONFIG_F2FS_FS_XATTR=y
# CONFIG_F2FS_FS_POSIX_ACL is not set
# CONFIG_F2FS_FS_SECURITY is not set
# CONFIG_F2FS_CHECK_FS is not set
# CONFIG_F2FS_FAULT_INJECTION is not set
CONFIG_F2FS_FS_COMPRESSION=y
# CONFIG_F2FS_FS_LZO is not set
CONFIG_F2FS_FS_LZ4=y
CONFIG_F2FS_FS_LZ4HC=y
CONFIG_F2FS_FS_ZSTD=y
CONFIG_F2FS_IOSTAT=y
CONFIG_ZONEFS_FS=m
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
# CONFIG_EXPORTFS_BLOCK_OPS is not set
CONFIG_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
CONFIG_FS_ENCRYPTION_ALGS=m
CONFIG_FS_VERITY=y
# CONFIG_FS_VERITY_DEBUG is not set
# CONFIG_FS_VERITY_BUILTIN_SIGNATURES is not set
CONFIG_FSNOTIFY=y
# CONFIG_DNOTIFY is not set
CONFIG_INOTIFY_USER=y
# CONFIG_FANOTIFY is not set
CONFIG_QUOTA=y
# CONFIG_QUOTA_NETLINK_INTERFACE is not set
CONFIG_PRINT_QUOTA_WARNING=y
CONFIG_QUOTA_DEBUG=y
CONFIG_QUOTA_TREE=m
CONFIG_QFMT_V1=m
# CONFIG_QFMT_V2 is not set
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=m
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=y
# CONFIG_CUSE is not set
CONFIG_VIRTIO_FS=m
CONFIG_OVERLAY_FS=m
# CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
# CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
# CONFIG_OVERLAY_FS_INDEX is not set
# CONFIG_OVERLAY_FS_METACOPY is not set

#
# Caches
#
CONFIG_NETFS_SUPPORT=y
CONFIG_FSCACHE=y
CONFIG_FSCACHE_DEBUG=y
CONFIG_CACHEFILES=m
CONFIG_CACHEFILES_DEBUG=y
# CONFIG_CACHEFILES_ONDEMAND is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
# CONFIG_JOLIET is not set
CONFIG_ZISOFS=y
CONFIG_UDF_FS=y
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/EXFAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
# CONFIG_VFAT_FS is not set
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_EXFAT_FS=y
CONFIG_EXFAT_DEFAULT_IOCHARSET="utf8"
CONFIG_NTFS_FS=m
# CONFIG_NTFS_DEBUG is not set
# CONFIG_NTFS_RW is not set
# CONFIG_NTFS3_FS is not set
# end of DOS/FAT/EXFAT/NT Filesystems

#
# Pseudo filesystems
#
# CONFIG_PROC_FS is not set
# CONFIG_PROC_CHILDREN is not set
CONFIG_KERNFS=y
CONFIG_SYSFS=y
# CONFIG_TMPFS is not set
CONFIG_CONFIGFS_FS=y
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
CONFIG_ORANGEFS_FS=y
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
CONFIG_ECRYPT_FS=y
CONFIG_ECRYPT_FS_MESSAGING=y
CONFIG_HFS_FS=y
CONFIG_HFSPLUS_FS=m
CONFIG_BEFS_FS=y
# CONFIG_BEFS_DEBUG is not set
CONFIG_BFS_FS=m
CONFIG_EFS_FS=m
CONFIG_JFFS2_FS=m
CONFIG_JFFS2_FS_DEBUG=0
# CONFIG_JFFS2_FS_WRITEBUFFER is not set
# CONFIG_JFFS2_SUMMARY is not set
CONFIG_JFFS2_FS_XATTR=y
# CONFIG_JFFS2_FS_POSIX_ACL is not set
CONFIG_JFFS2_FS_SECURITY=y
# CONFIG_JFFS2_COMPRESSION_OPTIONS is not set
CONFIG_JFFS2_ZLIB=y
CONFIG_JFFS2_RTIME=y
# CONFIG_CRAMFS is not set
CONFIG_SQUASHFS=y
# CONFIG_SQUASHFS_FILE_CACHE is not set
CONFIG_SQUASHFS_FILE_DIRECT=y
CONFIG_SQUASHFS_DECOMP_SINGLE=y
# CONFIG_SQUASHFS_DECOMP_MULTI is not set
# CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU is not set
# CONFIG_SQUASHFS_XATTR is not set
CONFIG_SQUASHFS_ZLIB=y
# CONFIG_SQUASHFS_LZ4 is not set
CONFIG_SQUASHFS_LZO=y
# CONFIG_SQUASHFS_XZ is not set
CONFIG_SQUASHFS_ZSTD=y
CONFIG_SQUASHFS_4K_DEVBLK_SIZE=y
# CONFIG_SQUASHFS_EMBEDDED is not set
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
CONFIG_VXFS_FS=y
CONFIG_MINIX_FS=m
CONFIG_MINIX_FS_NATIVE_ENDIAN=y
CONFIG_OMFS_FS=m
CONFIG_HPFS_FS=m
# CONFIG_QNX4FS_FS is not set
CONFIG_QNX6FS_FS=y
CONFIG_QNX6FS_DEBUG=y
# CONFIG_ROMFS_FS is not set
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFAULT_KMSG_BYTES=10240
CONFIG_PSTORE_DEFLATE_COMPRESS=y
CONFIG_PSTORE_LZO_COMPRESS=m
# CONFIG_PSTORE_LZ4_COMPRESS is not set
# CONFIG_PSTORE_LZ4HC_COMPRESS is not set
# CONFIG_PSTORE_842_COMPRESS is not set
# CONFIG_PSTORE_ZSTD_COMPRESS is not set
CONFIG_PSTORE_COMPRESS=y
CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT=y
# CONFIG_PSTORE_LZO_COMPRESS_DEFAULT is not set
CONFIG_PSTORE_COMPRESS_DEFAULT="deflate"
CONFIG_PSTORE_CONSOLE=y
CONFIG_PSTORE_PMSG=y
CONFIG_PSTORE_RAM=m
# CONFIG_PSTORE_BLK is not set
CONFIG_SYSV_FS=y
CONFIG_UFS_FS=y
CONFIG_UFS_FS_WRITE=y
CONFIG_UFS_DEBUG=y
# CONFIG_EROFS_FS is not set
CONFIG_NETWORK_FILESYSTEMS=y
# CONFIG_CEPH_FS is not set
# CONFIG_CIFS is not set
CONFIG_CODA_FS=m
CONFIG_AFS_FS=y
# CONFIG_AFS_DEBUG is not set
# CONFIG_AFS_FSCACHE is not set
# CONFIG_AFS_DEBUG_CURSOR is not set
CONFIG_9P_FS=m
# CONFIG_9P_FSCACHE is not set
# CONFIG_9P_FS_POSIX_ACL is not set
CONFIG_9P_FS_SECURITY=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=m
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=y
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=y
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=y
CONFIG_NLS_CODEPAGE_862=y
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
CONFIG_NLS_CODEPAGE_936=y
CONFIG_NLS_CODEPAGE_950=y
CONFIG_NLS_CODEPAGE_932=y
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=y
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=y
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=y
# CONFIG_NLS_ISO8859_7 is not set
CONFIG_NLS_ISO8859_9=y
CONFIG_NLS_ISO8859_13=y
CONFIG_NLS_ISO8859_14=y
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
CONFIG_NLS_KOI8_U=y
# CONFIG_NLS_MAC_ROMAN is not set
# CONFIG_NLS_MAC_CELTIC is not set
# CONFIG_NLS_MAC_CENTEURO is not set
CONFIG_NLS_MAC_CROATIAN=m
CONFIG_NLS_MAC_CYRILLIC=y
CONFIG_NLS_MAC_GAELIC=m
CONFIG_NLS_MAC_GREEK=m
CONFIG_NLS_MAC_ICELAND=m
CONFIG_NLS_MAC_INUIT=y
CONFIG_NLS_MAC_ROMANIAN=y
CONFIG_NLS_MAC_TURKISH=m
CONFIG_NLS_UTF8=y
# CONFIG_DLM is not set
CONFIG_UNICODE=y
CONFIG_UNICODE_NORMALIZATION_SELFTEST=y
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_KEYS_REQUEST_CACHE is not set
# CONFIG_PERSISTENT_KEYRINGS is not set
# CONFIG_TRUSTED_KEYS is not set
# CONFIG_ENCRYPTED_KEYS is not set
CONFIG_KEY_DH_OPERATIONS=y
CONFIG_KEY_NOTIFICATIONS=y
# CONFIG_SECURITY_DMESG_RESTRICT is not set
# CONFIG_SECURITYFS is not set
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
CONFIG_STATIC_USERMODEHELPER=y
CONFIG_STATIC_USERMODEHELPER_PATH="/sbin/usermode-helper"
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_LSM="lockdown,yama,loadpin,safesetid,integrity,bpf"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_CC_HAS_AUTO_VAR_INIT_PATTERN=y
CONFIG_CC_HAS_AUTO_VAR_INIT_ZERO=y
# CONFIG_INIT_STACK_NONE is not set
CONFIG_INIT_STACK_ALL_PATTERN=y
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
CONFIG_ASYNC_CORE=m
CONFIG_ASYNC_MEMCPY=m
CONFIG_ASYNC_XOR=m
CONFIG_ASYNC_PQ=m
CONFIG_ASYNC_RAID6_RECOV=m
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
CONFIG_CRYPTO_USER=y
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=y
CONFIG_CRYPTO_CRYPTD=m
CONFIG_CRYPTO_AUTHENC=y
CONFIG_CRYPTO_TEST=m
CONFIG_CRYPTO_ENGINE=y

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=y
# CONFIG_CRYPTO_DH_RFC7919_GROUPS is not set
CONFIG_CRYPTO_ECC=y
CONFIG_CRYPTO_ECDH=y
# CONFIG_CRYPTO_ECDSA is not set
CONFIG_CRYPTO_ECRDSA=m
CONFIG_CRYPTO_SM2=m
# CONFIG_CRYPTO_CURVE25519 is not set

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=y
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
# CONFIG_CRYPTO_AEGIS128 is not set
CONFIG_CRYPTO_SEQIV=m
CONFIG_CRYPTO_ECHAINIV=y

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CFB=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=m
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=m
# CONFIG_CRYPTO_OFB is not set
CONFIG_CRYPTO_PCBC=y
CONFIG_CRYPTO_XTS=y
CONFIG_CRYPTO_KEYWRAP=y
# CONFIG_CRYPTO_ADIANTUM is not set
CONFIG_CRYPTO_ESSIV=m

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=y
CONFIG_CRYPTO_HMAC=y
# CONFIG_CRYPTO_XCBC is not set
# CONFIG_CRYPTO_VMAC is not set

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
CONFIG_CRYPTO_POLY1305=m
CONFIG_CRYPTO_MD4=y
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=m
# CONFIG_CRYPTO_RMD160 is not set
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=m
CONFIG_CRYPTO_SM3=y
# CONFIG_CRYPTO_SM3_GENERIC is not set
CONFIG_CRYPTO_STREEBOG=m
CONFIG_CRYPTO_WP512=m

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
# CONFIG_CRYPTO_ANUBIS is not set
CONFIG_CRYPTO_ARC4=y
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_BLOWFISH_COMMON=m
CONFIG_CRYPTO_CAMELLIA=y
CONFIG_CRYPTO_CAST_COMMON=y
CONFIG_CRYPTO_CAST5=y
# CONFIG_CRYPTO_CAST6 is not set
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_FCRYPT=y
CONFIG_CRYPTO_KHAZAD=y
CONFIG_CRYPTO_CHACHA20=y
CONFIG_CRYPTO_SEED=y
# CONFIG_CRYPTO_SERPENT is not set
CONFIG_CRYPTO_SM4=y
# CONFIG_CRYPTO_SM4_GENERIC is not set
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_TWOFISH=y
CONFIG_CRYPTO_TWOFISH_COMMON=y

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=m
CONFIG_CRYPTO_842=y
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
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_KDF800108_CTR=y
CONFIG_CRYPTO_USER_API=y
CONFIG_CRYPTO_USER_API_HASH=m
CONFIG_CRYPTO_USER_API_SKCIPHER=m
CONFIG_CRYPTO_USER_API_RNG=y
# CONFIG_CRYPTO_USER_API_RNG_CAVP is not set
CONFIG_CRYPTO_USER_API_AEAD=y
CONFIG_CRYPTO_USER_API_ENABLE_OBSOLETE=y
# CONFIG_CRYPTO_STATS is not set
CONFIG_CRYPTO_HASH_INFO=y
CONFIG_CRYPTO_HW=y
# CONFIG_CRYPTO_DEV_ALLWINNER is not set
CONFIG_CRYPTO_DEV_HIFN_795X=m
CONFIG_CRYPTO_DEV_HIFN_795X_RNG=y
CONFIG_CRYPTO_DEV_EXYNOS_RNG=m
CONFIG_CRYPTO_DEV_S5P=m
# CONFIG_CRYPTO_DEV_ATMEL_AES is not set
CONFIG_CRYPTO_DEV_ATMEL_TDES=y
# CONFIG_CRYPTO_DEV_ATMEL_SHA is not set
CONFIG_CRYPTO_DEV_ATMEL_I2C=m
# CONFIG_CRYPTO_DEV_ATMEL_ECC is not set
CONFIG_CRYPTO_DEV_ATMEL_SHA204A=m
# CONFIG_CRYPTO_DEV_QCE is not set
CONFIG_CRYPTO_DEV_QCOM_RNG=y
CONFIG_CRYPTO_DEV_IMGTEC_HASH=y
CONFIG_CRYPTO_DEV_ZYNQMP_AES=m
# CONFIG_CRYPTO_DEV_ZYNQMP_SHA3 is not set
CONFIG_CRYPTO_DEV_CHELSIO=m
CONFIG_CRYPTO_DEV_VIRTIO=y
# CONFIG_CRYPTO_DEV_SAFEXCEL is not set
CONFIG_CRYPTO_DEV_CCREE=y
# CONFIG_CRYPTO_DEV_HISI_SEC is not set
# CONFIG_CRYPTO_DEV_AMLOGIC_GXL is not set
# CONFIG_CRYPTO_DEV_SA2UL is not set
# CONFIG_CRYPTO_DEV_KEEMBAY_OCS_AES_SM4 is not set
# CONFIG_CRYPTO_DEV_KEEMBAY_OCS_ECC is not set
CONFIG_CRYPTO_DEV_KEEMBAY_OCS_HCU=m
# CONFIG_CRYPTO_DEV_KEEMBAY_OCS_HCU_HMAC_SHA224 is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
# CONFIG_PKCS8_PRIVATE_KEY_PARSER is not set
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_PKCS7_TEST_KEY is not set
CONFIG_SIGNED_PE_FILE_VERIFICATION=y

#
# Certificates for signature checking
#
CONFIG_MODULE_SIG_KEY="certs/signing_key.pem"
CONFIG_MODULE_SIG_KEY_TYPE_RSA=y
# CONFIG_MODULE_SIG_KEY_TYPE_ECDSA is not set
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
# CONFIG_SECONDARY_TRUSTED_KEYRING is not set
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
# CONFIG_SYSTEM_REVOCATION_LIST is not set
# CONFIG_SYSTEM_BLACKLIST_AUTH_UPDATE is not set
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=y
# CONFIG_RAID6_PQ_BENCHMARK is not set
CONFIG_LINEAR_RANGES=y
CONFIG_PACKING=y
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_CORDIC=m
CONFIG_PRIME_NUMBERS=y
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_STMP_DEVICE=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_ARC4=y
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=y
CONFIG_CRYPTO_LIB_CHACHA=m
CONFIG_CRYPTO_LIB_CURVE25519_GENERIC=y
CONFIG_CRYPTO_LIB_CURVE25519=y
CONFIG_CRYPTO_LIB_DES=y
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=1
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=y
CONFIG_CRYPTO_LIB_POLY1305=y
CONFIG_CRYPTO_LIB_CHACHA20POLY1305=m
CONFIG_CRYPTO_LIB_SHA256=y
# end of Crypto library routines

CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC64_ROCKSOFT=y
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
# CONFIG_CRC32_SLICEBY8 is not set
CONFIG_CRC32_SLICEBY4=y
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
CONFIG_CRC64=y
CONFIG_CRC4=y
CONFIG_CRC7=m
CONFIG_LIBCRC32C=y
CONFIG_CRC8=y
CONFIG_XXHASH=y
CONFIG_RANDOM32_SELFTEST=y
CONFIG_842_COMPRESS=y
CONFIG_842_DECOMPRESS=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_COMPRESS=m
CONFIG_LZ4HC_COMPRESS=m
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=y
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
# CONFIG_XZ_DEC_POWERPC is not set
# CONFIG_XZ_DEC_IA64 is not set
# CONFIG_XZ_DEC_ARM is not set
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
# CONFIG_XZ_DEC_MICROLZMA is not set
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_REED_SOLOMON_DEC16=y
CONFIG_BCH=m
CONFIG_BCH_CONST_PARAMS=y
CONFIG_TEXTSEARCH=y
CONFIG_TEXTSEARCH_KMP=m
CONFIG_TEXTSEARCH_BM=m
CONFIG_TEXTSEARCH_FSM=m
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_DMA_OPS=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU=y
CONFIG_DMA_NONCOHERENT_MMAP=y
CONFIG_DMA_COHERENT_POOL=y
CONFIG_DMA_DIRECT_REMAP=y
# CONFIG_DMA_API_DEBUG is not set
# CONFIG_DMA_MAP_BENCHMARK is not set
CONFIG_SGL_ALLOC=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_GENERIC_ATOMIC64=y
CONFIG_CLZ_TAB=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_DIMLIB=y
CONFIG_OID_REGISTRY=y
CONFIG_SG_POOL=y
CONFIG_SBITMAP=y
CONFIG_PARMAN=m
CONFIG_OBJAGG=y
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
CONFIG_SYMBOLIC_ERRNAME=y
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
CONFIG_FRAME_WARN=1024
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
# CONFIG_HEADERS_INSTALL is not set
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
# CONFIG_VMLINUX_MAP is not set
CONFIG_DEBUG_FORCE_WEAK_PER_CPU=y
# end of Compile-time checks and compiler options

#
# Generic Kernel Debugging Instruments
#
# CONFIG_MAGIC_SYSRQ is not set
CONFIG_DEBUG_FS=y
# CONFIG_DEBUG_FS_ALLOW_ALL is not set
CONFIG_DEBUG_FS_DISALLOW_MOUNT=y
# CONFIG_DEBUG_FS_ALLOW_NONE is not set
CONFIG_UBSAN=y
CONFIG_CC_HAS_UBSAN_BOUNDS=y
CONFIG_UBSAN_BOUNDS=y
CONFIG_UBSAN_ONLY_BOUNDS=y
CONFIG_UBSAN_SHIFT=y
# CONFIG_UBSAN_DIV_ZERO is not set
# CONFIG_UBSAN_UNREACHABLE is not set
CONFIG_UBSAN_BOOL=y
CONFIG_UBSAN_ENUM=y
# CONFIG_TEST_UBSAN is not set
CONFIG_HAVE_KCSAN_COMPILER=y
# end of Generic Kernel Debugging Instruments

#
# Networking Debugging
#
# CONFIG_DEBUG_NET is not set
# end of Networking Debugging

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
CONFIG_DEBUG_PAGEALLOC=y
# CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT is not set
# CONFIG_DEBUG_SLAB is not set
CONFIG_PAGE_POISONING=y
CONFIG_DEBUG_OBJECTS=y
CONFIG_DEBUG_OBJECTS_SELFTEST=y
# CONFIG_DEBUG_OBJECTS_FREE is not set
CONFIG_DEBUG_OBJECTS_TIMERS=y
CONFIG_DEBUG_OBJECTS_WORK=y
# CONFIG_DEBUG_OBJECTS_RCU_HEAD is not set
CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER=y
CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=1
CONFIG_DEBUG_STACK_USAGE=y
CONFIG_SCHED_STACK_END_CHECK=y
CONFIG_DEBUG_VM=y
CONFIG_DEBUG_VM_VMACACHE=y
CONFIG_DEBUG_VM_RB=y
CONFIG_DEBUG_VM_PGFLAGS=y
CONFIG_DEBUG_MEMORY_INIT=y
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_DEBUG_KMAP_LOCAL=y
CONFIG_DEBUG_HIGHMEM=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
# end of Memory Debugging

# CONFIG_DEBUG_SHIRQ is not set

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
CONFIG_WQ_WATCHDOG=y
CONFIG_TEST_LOCKUP=m
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
# end of Scheduler Debugging

# CONFIG_DEBUG_TIMEKEEPING is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
CONFIG_DEBUG_RWSEMS=y
# CONFIG_DEBUG_ATOMIC_SLEEP is not set
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
CONFIG_LOCK_TORTURE_TEST=m
CONFIG_WW_MUTEX_SELFTEST=m
# CONFIG_SCF_TORTURE_TEST is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

# CONFIG_DEBUG_IRQFLAGS is not set
CONFIG_WARN_ALL_UNSEEDED_RANDOM=y
CONFIG_DEBUG_KOBJECT=y
CONFIG_DEBUG_KOBJECT_RELEASE=y
CONFIG_HAVE_DEBUG_BUGVERBOSE=y

#
# Debug kernel data structures
#
CONFIG_DEBUG_LIST=y
CONFIG_DEBUG_PLIST=y
# CONFIG_DEBUG_SG is not set
CONFIG_DEBUG_NOTIFIERS=y
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
# end of Debug kernel data structures

# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_TORTURE_TEST=y
# CONFIG_RCU_SCALE_TEST is not set
CONFIG_RCU_TORTURE_TEST=y
CONFIG_RCU_REF_SCALE_TEST=m
CONFIG_RCU_CPU_STALL_TIMEOUT=21
CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=0
CONFIG_RCU_TRACE=y
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

CONFIG_DEBUG_WQ_FORCE_RR_CPU=y
CONFIG_TRACE_CLOCK=y
# CONFIG_SAMPLES is not set
# CONFIG_STRICT_DEVMEM is not set

#
# sparc Debugging
#
# end of sparc Debugging

#
# Kernel Testing and Coverage
#
# CONFIG_KUNIT is not set
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
CONFIG_FAULT_INJECTION=y
# CONFIG_FAILSLAB is not set
# CONFIG_FAIL_PAGE_ALLOC is not set
# CONFIG_FAULT_INJECTION_USERCOPY is not set
CONFIG_FAIL_MAKE_REQUEST=y
CONFIG_FAIL_IO_TIMEOUT=y
CONFIG_FAULT_INJECTION_DEBUG_FS=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_RUNTIME_TESTING_MENU is not set
# end of Kernel Testing and Coverage

# CONFIG_WARN_MISSING_DOCUMENTS is not set
# CONFIG_WARN_ABI_ERRORS is not set
# end of Kernel hacking

--6BnD8dwpNlBC6Pe5--
