Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8DF1619F74
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 19:09:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbiKDSJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 14:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiKDSJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 14:09:40 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D08411A12
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 11:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667585376; x=1699121376;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=bMRzV8X3hZLgwTKmhEHa/VlMhTsD9ZaJwe0H98H7gGM=;
  b=mbh7bdgSTqALQL/R53B0TfrwJxtIiKG+F+lFh55m9z3D/CQroD0703id
   4oTAtMsnU11IfPDy0NV7TivHOeYj2UY9fziaMRYp9ZipEJr0u/N6kUx2X
   UV7sO1cvziAq40P8Miqhhp70PZ9bHtY8p/4DgAoN5TLpRyW7PKUpXkfLk
   eVPxuIyns7FfiQotkfvUtJsp9Rgxn7laJxjGaKmVh9pzWFVFToxncCLPw
   C2VL78EUOa/X3mlAuOejh4EG0SUO0sO7KWwUXnTxe93QsABvS0QVygamG
   ghX1BeEpXJ/wmdAz4SAtM65mPAc0HfEo0C625LwVjT2GQVqXyjxa6HVeI
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="374272641"
X-IronPort-AV: E=Sophos;i="5.96,138,1665471600"; 
   d="scan'208";a="374272641"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 11:09:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="810145332"
X-IronPort-AV: E=Sophos;i="5.96,138,1665471600"; 
   d="scan'208";a="810145332"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 04 Nov 2022 11:09:33 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1or18G-000HDJ-19;
        Fri, 04 Nov 2022 18:09:32 +0000
Date:   Sat, 5 Nov 2022 02:08:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Arnd Bergmann <arnd@arndb.de>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Subject: drivers/scsi/hptiop.c:643:34: sparse: sparse: incorrect type in
 argument 1 (different address spaces)
Message-ID: <202211050221.wBOuzPXW-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="f1d0j511qKItHqrO"
Content-Disposition: inline
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,UPPERCASE_50_75 autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--f1d0j511qKItHqrO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ee6050c8af96bba2f81e8b0793a1fc2f998fcd20
commit: d803336abdbc1bfacdb32b2cf9f4fdbee072b8ee ARM: mm: kill unused runtime hook arch_iounmap()
date:   4 months ago
config: arm-randconfig-s033-20221104
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d803336abdbc1bfacdb32b2cf9f4fdbee072b8ee
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout d803336abdbc1bfacdb32b2cf9f4fdbee072b8ee
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm SHELL=/bin/bash drivers/scsi/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
   drivers/scsi/hptiop.c:150:17: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/hptiop.c:171:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got restricted __le32 * @@
   drivers/scsi/hptiop.c:171:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/hptiop.c:171:9: sparse:     got restricted __le32 *
   drivers/scsi/hptiop.c:208:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got restricted __le32 * @@
   drivers/scsi/hptiop.c:208:18: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/hptiop.c:208:18: sparse:     got restricted __le32 *
   drivers/scsi/hptiop.c:209:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got restricted __le32 * @@
   drivers/scsi/hptiop.c:209:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/hptiop.c:209:9: sparse:     got restricted __le32 *
   drivers/scsi/hptiop.c:244:44: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] result @@     got int @@
   drivers/scsi/hptiop.c:244:44: sparse:     expected restricted __le32 [usertype] result
   drivers/scsi/hptiop.c:244:44: sparse:     got int
   drivers/scsi/hptiop.c:289:35: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/hptiop.c:276:32: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/hptiop.c:277:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] cur_rptr @@     got restricted __le32 [usertype] outlist_rptr @@
   drivers/scsi/hptiop.c:277:34: sparse:     expected unsigned int [usertype] cur_rptr
   drivers/scsi/hptiop.c:277:34: sparse:     got restricted __le32 [usertype] outlist_rptr
   drivers/scsi/hptiop.c:283:38: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] _tag @@     got restricted __le32 [usertype] val @@
   drivers/scsi/hptiop.c:283:38: sparse:     expected unsigned int [usertype] _tag
   drivers/scsi/hptiop.c:283:38: sparse:     got restricted __le32 [usertype] val
   drivers/scsi/hptiop.c:288:52: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] outlist_rptr @@     got unsigned int [assigned] [usertype] cur_rptr @@
   drivers/scsi/hptiop.c:288:52: sparse:     expected restricted __le32 [usertype] outlist_rptr
   drivers/scsi/hptiop.c:288:52: sparse:     got unsigned int [assigned] [usertype] cur_rptr
   drivers/scsi/hptiop.c:369:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got restricted __le32 * @@
   drivers/scsi/hptiop.c:369:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/hptiop.c:369:9: sparse:     got restricted __le32 *
   drivers/scsi/hptiop.c:370:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got restricted __le32 * @@
   drivers/scsi/hptiop.c:370:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/hptiop.c:370:9: sparse:     got restricted __le32 *
   drivers/scsi/hptiop.c:453:64: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct hpt_iop_request_get_config *info @@     got struct hpt_iop_request_get_config [noderef] __iomem *config @@
   drivers/scsi/hptiop.c:453:64: sparse:     expected struct hpt_iop_request_get_config *info
   drivers/scsi/hptiop.c:453:64: sparse:     got struct hpt_iop_request_get_config [noderef] __iomem *config
   drivers/scsi/hptiop.c:455:25: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/hptiop.c:557:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got restricted __le32 * @@
   drivers/scsi/hptiop.c:557:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/hptiop.c:557:9: sparse:     got restricted __le32 *
   drivers/scsi/hptiop.c:637:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct hpt_iopmv_regs *regs @@     got void [noderef] __iomem * @@
   drivers/scsi/hptiop.c:637:24: sparse:     expected struct hpt_iopmv_regs *regs
   drivers/scsi/hptiop.c:637:24: sparse:     got void [noderef] __iomem *
>> drivers/scsi/hptiop.c:643:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *io_addr @@     got struct hpt_iopmv_regs *regs @@
   drivers/scsi/hptiop.c:643:34: sparse:     expected void volatile [noderef] __iomem *io_addr
   drivers/scsi/hptiop.c:643:34: sparse:     got struct hpt_iopmv_regs *regs
   drivers/scsi/hptiop.c:667:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *io_addr @@     got struct hpt_iopmv_regs *regs @@
   drivers/scsi/hptiop.c:667:26: sparse:     expected void volatile [noderef] __iomem *io_addr
   drivers/scsi/hptiop.c:667:26: sparse:     got struct hpt_iopmv_regs *regs
   drivers/scsi/hptiop.c:933:27: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/hptiop.c:938:34: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/hptiop.c:939:30: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/hptiop.c:943:43: sparse: sparse: invalid assignment: &=
   drivers/scsi/hptiop.c:943:43: sparse:    left side has type restricted __le32
   drivers/scsi/hptiop.c:943:43: sparse:    right side has type int
   drivers/scsi/hptiop.c:944:43: sparse: sparse: invalid assignment: ^=
   drivers/scsi/hptiop.c:944:43: sparse:    left side has type restricted __le32
   drivers/scsi/hptiop.c:944:43: sparse:    right side has type int
   drivers/scsi/hptiop.c:949:57: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/hptiop.c:949:48: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] intrfc_len @@     got unsigned int @@
   drivers/scsi/hptiop.c:949:48: sparse:     expected restricted __le32 [usertype] intrfc_len
   drivers/scsi/hptiop.c:949:48: sparse:     got unsigned int
   drivers/scsi/hptiop.c:950:9: sparse: sparse: cast from restricted __le32
   drivers/scsi/hptiop.c:975:9: sparse: sparse: cast from restricted __le32
   drivers/scsi/hptiop.c:977:9: sparse: sparse: cast from restricted __le32
   drivers/scsi/hptiop.c:980:9: sparse: sparse: cast from restricted __le32
   drivers/scsi/hptiop.c:982:9: sparse: sparse: cast from restricted __le32
   drivers/scsi/hptiop.c:985:9: sparse: sparse: cast from restricted __le32
   drivers/scsi/hptiop.c:987:9: sparse: sparse: cast from restricted __le32
   drivers/scsi/hptiop.c:990:35: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] inlist_wptr @@     got unsigned int @@
   drivers/scsi/hptiop.c:990:35: sparse:     expected restricted __le32 [usertype] inlist_wptr
   drivers/scsi/hptiop.c:990:35: sparse:     got unsigned int
   drivers/scsi/hptiop.c:991:37: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] @@     got unsigned int @@
   drivers/scsi/hptiop.c:991:37: sparse:     expected restricted __le32 [usertype]
   drivers/scsi/hptiop.c:991:37: sparse:     got unsigned int
   drivers/scsi/hptiop.c:992:36: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] outlist_rptr @@     got unsigned int @@
   drivers/scsi/hptiop.c:992:36: sparse:     expected restricted __le32 [usertype] outlist_rptr
   drivers/scsi/hptiop.c:992:36: sparse:     got unsigned int
   drivers/scsi/hptiop.c:1534:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got restricted __le32 * @@
   drivers/scsi/hptiop.c:1534:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/hptiop.c:1534:9: sparse:     got restricted __le32 *
   drivers/scsi/hptiop.c:1535:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got restricted __le32 * @@
   drivers/scsi/hptiop.c:1535:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/hptiop.c:1535:9: sparse:     got restricted __le32 *
   drivers/scsi/hptiop.c:150:17: sparse: sparse: dereference of noderef expression
   drivers/scsi/hptiop.c:150:17: sparse: sparse: dereference of noderef expression

vim +643 drivers/scsi/hptiop.c

00f5970193e22c HighPoint Linux Team 2007-12-13  634  
00f5970193e22c HighPoint Linux Team 2007-12-13  635  static int hptiop_map_pci_bar_mv(struct hptiop_hba *hba)
00f5970193e22c HighPoint Linux Team 2007-12-13  636  {
00f5970193e22c HighPoint Linux Team 2007-12-13  637  	hba->u.mv.regs = hptiop_map_pci_bar(hba, 0);
9bcf091083065c Harvey Harrison      2008-05-22  638  	if (hba->u.mv.regs == NULL)
00f5970193e22c HighPoint Linux Team 2007-12-13  639  		return -1;
00f5970193e22c HighPoint Linux Team 2007-12-13  640  
00f5970193e22c HighPoint Linux Team 2007-12-13  641  	hba->u.mv.mu = hptiop_map_pci_bar(hba, 2);
9bcf091083065c Harvey Harrison      2008-05-22  642  	if (hba->u.mv.mu == NULL) {
00f5970193e22c HighPoint Linux Team 2007-12-13 @643  		iounmap(hba->u.mv.regs);
ede1e6f8b43246 HighPoint Linux Team 2006-05-16  644  		return -1;
ede1e6f8b43246 HighPoint Linux Team 2006-05-16  645  	}
ede1e6f8b43246 HighPoint Linux Team 2006-05-16  646  
ede1e6f8b43246 HighPoint Linux Team 2006-05-16  647  	return 0;
ede1e6f8b43246 HighPoint Linux Team 2006-05-16  648  }
ede1e6f8b43246 HighPoint Linux Team 2006-05-16  649  

:::::: The code at line 643 was first introduced by commit
:::::: 00f5970193e22c48f399a2430635d6416b51befe [SCSI] hptiop: add more adapter models and other fixes

:::::: TO: HighPoint Linux Team <linux@highpoint-tech.com>
:::::: CC: James Bottomley <James.Bottomley@HansenPartnership.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

--f1d0j511qKItHqrO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=config

#
# Automatically generated file; DO NOT EDIT.
# Linux/arm 5.19.0-rc3 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="arm-linux-gnueabi-gcc (GCC) 12.1.0"
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
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_TABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_BROKEN_ON_SMP=y
CONFIG_INIT_ENV_ARG_LIMIT=32
CONFIG_COMPILE_TEST=y
# CONFIG_WERROR is not set
CONFIG_LOCALVERSION=""
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
CONFIG_KERNEL_GZIP=y
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
CONFIG_DEFAULT_INIT=""
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SYSVIPC=y
CONFIG_WATCH_QUEUE=y
# CONFIG_CROSS_MEMORY_ATTACH is not set
CONFIG_USELIB=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_SHOW_LEVEL=y
CONFIG_GENERIC_IRQ_INJECTION=y
CONFIG_HARDIRQS_SW_RESEND=y
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
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_TIME_KUNIT_TEST=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_HZ_PERIODIC=y
# CONFIG_NO_HZ_IDLE is not set
# CONFIG_NO_HZ is not set
CONFIG_HIGH_RES_TIMERS=y
# end of Timers subsystem

CONFIG_HAVE_EBPF_JIT=y

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
CONFIG_IRQ_TIME_ACCOUNTING=y
# CONFIG_PSI is not set
# end of CPU/Task time and stats accounting

CONFIG_CPU_ISOLATION=y

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
CONFIG_PREEMPT_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_TASKS_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
# end of RCU Subsystem

# CONFIG_IKCONFIG is not set
# CONFIG_IKHEADERS is not set
CONFIG_GENERIC_SCHED_CLOCK=y

#
# Scheduler features
#
# end of Scheduler features

CONFIG_CC_IMPLICIT_FALLTHROUGH="-Wimplicit-fallthrough=5"
CONFIG_GCC12_NO_ARRAY_BOUNDS=y
CONFIG_CC_NO_ARRAY_BOUNDS=y
# CONFIG_CGROUPS is not set
CONFIG_CHECKPOINT_RESTORE=y
# CONFIG_SCHED_AUTOGROUP is not set
CONFIG_SYSFS_DEPRECATED=y
CONFIG_SYSFS_DEPRECATED_V2=y
# CONFIG_RELAY is not set
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
# CONFIG_RD_GZIP is not set
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
# CONFIG_RD_LZO is not set
# CONFIG_RD_LZ4 is not set
# CONFIG_RD_ZSTD is not set
CONFIG_BOOT_CONFIG=y
# CONFIG_BOOT_CONFIG_EMBED is not set
CONFIG_INITRAMFS_PRESERVE_MTIME=y
# CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE is not set
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
CONFIG_LD_ORPHAN_WARN=y
CONFIG_HAVE_UID16=y
CONFIG_EXPERT=y
# CONFIG_MULTIUSER is not set
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
# CONFIG_FHANDLE is not set
# CONFIG_POSIX_TIMERS is not set
# CONFIG_PRINTK is not set
CONFIG_BUG=y
# CONFIG_ELF_CORE is not set
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
# CONFIG_EPOLL is not set
# CONFIG_SIGNALFD is not set
# CONFIG_TIMERFD is not set
# CONFIG_EVENTFD is not set
# CONFIG_SHMEM is not set
# CONFIG_AIO is not set
CONFIG_IO_URING=y
# CONFIG_ADVISE_SYSCALLS is not set
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_KCMP=y
CONFIG_RSEQ=y
CONFIG_DEBUG_RSEQ=y
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_PERF_USE_VMALLOC=y
# CONFIG_PC104 is not set

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

CONFIG_SYSTEM_DATA_VERIFICATION=y
CONFIG_PROFILING=y
CONFIG_TRACEPOINTS=y
# end of General setup

CONFIG_ARM=y
CONFIG_ARM_HAS_SG_CHAIN=y
CONFIG_ARM_DMA_USE_IOMMU=y
CONFIG_ARM_DMA_IOMMU_ALIGNMENT=8
CONFIG_SYS_SUPPORTS_APM_EMULATION=y
CONFIG_HAVE_PROC_CPU=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_ARM_PATCH_PHYS_VIRT=y
CONFIG_GENERIC_BUG=y
CONFIG_PGTABLE_LEVELS=2

#
# System Type
#
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_BITS_MAX=16
CONFIG_ARCH_MULTIPLATFORM=y
# CONFIG_ARCH_FOOTBRIDGE is not set
# CONFIG_ARCH_SA1100 is not set

#
# Multiple platform selection
#

#
# CPU Core family selection
#
CONFIG_ARCH_MULTI_V4=y
CONFIG_ARCH_MULTI_V4T=y
CONFIG_ARCH_MULTI_V5=y
CONFIG_ARCH_MULTI_V4_V5=y
# CONFIG_ARCH_MULTI_V6 is not set
# CONFIG_ARCH_MULTI_V7 is not set
# end of Multiple platform selection

CONFIG_MACH_ASM9260=y
CONFIG_ARCH_ASPEED=y
CONFIG_MACH_ASPEED_G4=y
CONFIG_ARCH_AT91=y
CONFIG_SOC_AT91RM9200=y
CONFIG_SOC_AT91SAM9=y
# CONFIG_SOC_SAM9X60 is not set

#
# Clocksource driver selection
#
# CONFIG_ATMEL_CLOCKSOURCE_PIT is not set
# CONFIG_ATMEL_CLOCKSOURCE_TCB is not set
# CONFIG_MICROCHIP_CLOCKSOURCE_PIT64B is not set
CONFIG_HAVE_AT91_UTMI=y
CONFIG_HAVE_AT91_USB_CLK=y
CONFIG_COMMON_CLK_AT91=y
CONFIG_HAVE_AT91_SMD=y
CONFIG_SOC_SAM_V4_V5=y
CONFIG_ATMEL_PM=y
CONFIG_ARCH_CLPS711X=y
CONFIG_ARCH_DAVINCI=y

#
# DaVinci Core Type
#
# CONFIG_ARCH_DAVINCI_DM644x is not set
# CONFIG_ARCH_DAVINCI_DM355 is not set
# CONFIG_ARCH_DAVINCI_DM646x is not set
# CONFIG_ARCH_DAVINCI_DA830 is not set
# CONFIG_ARCH_DAVINCI_DA850 is not set
# CONFIG_ARCH_DAVINCI_DM365 is not set

#
# DaVinci Board Type
#
CONFIG_DAVINCI_MUX=y
CONFIG_DAVINCI_MUX_DEBUG=y
# CONFIG_DAVINCI_MUX_WARNINGS is not set
# CONFIG_ARCH_EP93XX is not set
CONFIG_ARCH_GEMINI=y
# CONFIG_ARCH_HISI is not set
# CONFIG_ARCH_MXC is not set
# CONFIG_ARCH_IOP32X is not set
CONFIG_ARCH_LPC32XX=y
CONFIG_ARCH_MMP=y

#
# Marvell PXA168/910/MMP2 Implementations
#
CONFIG_MACH_MMP_DT=y
# end of Marvell PXA168/910/MMP2 Implementations

CONFIG_ARCH_MOXART=y
# CONFIG_MACH_UC7112LX is not set
# CONFIG_ARCH_MV78XX0 is not set
CONFIG_ARCH_MVEBU=y
# CONFIG_MACH_KIRKWOOD is not set
CONFIG_SOC_IMX23=y
CONFIG_SOC_IMX28=y
CONFIG_ARCH_MXS=y
CONFIG_ARCH_NOMADIK=y
# CONFIG_MACH_NOMADIK_8815NHK is not set
CONFIG_ARCH_NPCM=y
CONFIG_ARCH_WPCM450=y
# CONFIG_ARCH_NSPIRE is not set
# CONFIG_ARCH_OMAP1 is not set
CONFIG_ARCH_ORION5X=y
CONFIG_ARCH_ORION5X_DT=y
# CONFIG_MACH_DB88F5281 is not set
# CONFIG_MACH_RD88F5182 is not set
CONFIG_MACH_RD88F5182_DT=y
# CONFIG_MACH_KUROBOX_PRO is not set
# CONFIG_MACH_DNS323 is not set
# CONFIG_MACH_TS209 is not set
# CONFIG_MACH_TERASTATION_PRO2 is not set
# CONFIG_MACH_LINKSTATION_PRO is not set
# CONFIG_MACH_LINKSTATION_MINI is not set
# CONFIG_MACH_LINKSTATION_LS_HGL is not set
# CONFIG_MACH_TS409 is not set
# CONFIG_MACH_WRT350N_V2 is not set
# CONFIG_MACH_TS78XX is not set
# CONFIG_MACH_MV2120 is not set
CONFIG_MACH_D2NET_DT=y
# CONFIG_MACH_NET2BIG is not set
CONFIG_MACH_MSS2_DT=y
# CONFIG_MACH_WNR854T is not set
# CONFIG_MACH_RD88F5181L_GE is not set
# CONFIG_MACH_RD88F5181L_FXO is not set
# CONFIG_MACH_RD88F6183AP_GE is not set
# CONFIG_ARCH_OXNAS is not set
CONFIG_ARCH_PXA=y

#
# Intel PXA2xx/PXA3xx Implementations
#

#
# Intel/Marvell Dev Platforms (sorted by hardware release time)
#
# CONFIG_MACH_PXA25X_DT is not set
CONFIG_MACH_PXA27X_DT=y
CONFIG_MACH_PXA3XX_DT=y
# CONFIG_ARCH_LUBBOCK is not set
# CONFIG_MACH_MAINSTONE is not set
# CONFIG_MACH_ZYLONITE300 is not set
# CONFIG_MACH_ZYLONITE320 is not set
# CONFIG_MACH_LITTLETON is not set
# CONFIG_MACH_TAVOREVB is not set
# CONFIG_MACH_SAAR is not set

#
# Third Party Dev Platforms (sorted by vendor name)
#
# CONFIG_ARCH_PXA_IDP is not set
# CONFIG_ARCH_VIPER is not set
# CONFIG_MACH_ARCOM_ZEUS is not set
# CONFIG_MACH_BALLOON3 is not set
# CONFIG_MACH_CSB726 is not set
# CONFIG_MACH_CM_X300 is not set
# CONFIG_MACH_CAPC7117 is not set
# CONFIG_ARCH_GUMSTIX is not set
# CONFIG_MACH_XCEP is not set
# CONFIG_TRIZEPS_PXA is not set
# CONFIG_MACH_LOGICPD_PXA270 is not set
# CONFIG_MACH_PCM027 is not set
# CONFIG_MACH_COLIBRI is not set
# CONFIG_MACH_COLIBRI300 is not set
# CONFIG_MACH_COLIBRI320 is not set
# CONFIG_MACH_VPAC270 is not set

#
# End-user Products (sorted by vendor name)
#
# CONFIG_MACH_H4700 is not set
# CONFIG_MACH_H5000 is not set
# CONFIG_MACH_HIMALAYA is not set
# CONFIG_MACH_MAGICIAN is not set
# CONFIG_MACH_MIOA701 is not set
# CONFIG_PXA_EZX is not set
# CONFIG_MACH_MP900C is not set
# CONFIG_ARCH_PXA_PALM is not set
# CONFIG_PXA_SHARPSL is not set
# CONFIG_MACH_ICONTROL is not set
# CONFIG_ARCH_PXA_ESERIES is not set
# CONFIG_MACH_ZIPIT2 is not set
# end of Intel PXA2xx/PXA3xx Implementations

CONFIG_PXA27x=y
CONFIG_PXA3xx=y
CONFIG_CPU_PXA300=y
CONFIG_PXA_SYSTEMS_CPLDS=m
# CONFIG_ARCH_S3C24XX is not set
CONFIG_PLAT_SPEAR=y
CONFIG_ARCH_SPEAR3XX=y
# CONFIG_MACH_SPEAR300 is not set
# CONFIG_MACH_SPEAR310 is not set
CONFIG_MACH_SPEAR320=y
# CONFIG_ARCH_SPEAR6XX is not set
CONFIG_ARCH_SUNXI=y
# CONFIG_MACH_SUNIV is not set
# CONFIG_ARCH_VERSATILE is not set
# CONFIG_ARCH_INTEGRATOR is not set
# CONFIG_ARCH_REALVIEW is not set
# CONFIG_ARCH_WM8505 is not set
CONFIG_PLAT_ORION=y
CONFIG_PLAT_ORION_LEGACY=y

#
# Processor Type
#
CONFIG_CPU_ARM720T=y
CONFIG_CPU_ARM920T=y
CONFIG_CPU_ARM926T=y
CONFIG_CPU_FA526=y
CONFIG_CPU_XSCALE=y
CONFIG_CPU_XSC3=y
CONFIG_CPU_MOHAWK=y
CONFIG_CPU_FEROCEON=y
CONFIG_CPU_THUMB_CAPABLE=y
CONFIG_CPU_32v4=y
CONFIG_CPU_32v4T=y
CONFIG_CPU_32v5=y
CONFIG_CPU_ABRT_EV4=y
CONFIG_CPU_ABRT_EV4T=y
CONFIG_CPU_ABRT_LV4T=y
CONFIG_CPU_ABRT_EV5T=y
CONFIG_CPU_ABRT_EV5TJ=y
CONFIG_CPU_PABRT_LEGACY=y
CONFIG_CPU_CACHE_V4=y
CONFIG_CPU_CACHE_V4WT=y
CONFIG_CPU_CACHE_VIVT=y
CONFIG_CPU_CACHE_FA=y
CONFIG_CPU_COPY_V4WT=y
CONFIG_CPU_COPY_V4WB=y
CONFIG_CPU_COPY_FEROCEON=y
CONFIG_CPU_COPY_FA=y
CONFIG_CPU_TLB_V4WT=y
CONFIG_CPU_TLB_V4WBI=y
CONFIG_CPU_TLB_FEROCEON=y
CONFIG_CPU_TLB_FA=y
CONFIG_CPU_CP15=y
CONFIG_CPU_CP15_MMU=y
CONFIG_CPU_USE_DOMAINS=y
CONFIG_IO_36=y

#
# Processor Features
#
CONFIG_CPU_LITTLE_ENDIAN=y
# CONFIG_CPU_BIG_ENDIAN is not set
# CONFIG_CPU_DCACHE_DISABLE is not set
CONFIG_CPU_DCACHE_WRITETHROUGH=y
# CONFIG_CPU_CACHE_ROUND_ROBIN is not set
CONFIG_CPU_BPREDICT_DISABLE=y
CONFIG_NEED_KUSER_HELPERS=y
CONFIG_KUSER_HELPERS=y
CONFIG_OUTER_CACHE=y
CONFIG_OUTER_CACHE_SYNC=y
# CONFIG_CACHE_FEROCEON_L2 is not set
CONFIG_MIGHT_HAVE_CACHE_L2X0=y
CONFIG_CACHE_L2X0=y
# CONFIG_CACHE_L2X0_PMU is not set
# CONFIG_PL310_ERRATA_588369 is not set
# CONFIG_PL310_ERRATA_727915 is not set
# CONFIG_PL310_ERRATA_753970 is not set
CONFIG_PL310_ERRATA_769419=y
# CONFIG_CACHE_TAUROS2 is not set
# CONFIG_CACHE_XSC3L2 is not set
CONFIG_ARM_L1_CACHE_SHIFT=5
CONFIG_ARM_DMA_MEM_BUFFERABLE=y
CONFIG_ARM_HEAVY_MB=y
# CONFIG_IWMMXT is not set
# end of System Type

CONFIG_KRAIT_L2_ACCESSORS=y

#
# Bus support
#
# end of Bus support

#
# Kernel Features
#
CONFIG_IRQSTACKS=y
CONFIG_VMSPLIT_3G=y
# CONFIG_VMSPLIT_3G_OPT is not set
# CONFIG_VMSPLIT_2G is not set
# CONFIG_VMSPLIT_1G is not set
CONFIG_PAGE_OFFSET=0xC0000000
CONFIG_ARCH_NR_GPIO=1024
CONFIG_HZ_FIXED=128
CONFIG_HZ=128
CONFIG_SCHED_HRTICK=y
CONFIG_AEABI=y
CONFIG_OABI_COMPAT=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
# CONFIG_HIGHMEM is not set
CONFIG_CPU_SW_DOMAIN_PAN=y
CONFIG_HW_PERF_EVENTS=y
CONFIG_ARM_MODULE_PLTS=y
CONFIG_FORCE_MAX_ZONEORDER=11
CONFIG_ALIGNMENT_TRAP=y
CONFIG_UACCESS_WITH_MEMCPY=y
# CONFIG_PARAVIRT is not set
# CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
CONFIG_CC_HAVE_STACKPROTECTOR_TLS=y
# end of Kernel Features

#
# Boot options
#
CONFIG_USE_OF=y
# CONFIG_ATAGS is not set
CONFIG_ZBOOT_ROM_TEXT=0x0
CONFIG_ZBOOT_ROM_BSS=0x0
CONFIG_ARM_APPENDED_DTB=y
CONFIG_ARM_ATAG_DTB_COMPAT=y
# CONFIG_ARM_ATAG_DTB_COMPAT_CMDLINE_FROM_BOOTLOADER is not set
CONFIG_ARM_ATAG_DTB_COMPAT_CMDLINE_EXTEND=y
CONFIG_CMDLINE=""
# CONFIG_KEXEC is not set
# CONFIG_CRASH_DUMP is not set
CONFIG_AUTO_ZRELADDR=y
CONFIG_EFI_STUB=y
CONFIG_EFI=y
# CONFIG_DMI is not set
# end of Boot options

#
# CPU Power Management
#

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set
# end of CPU Frequency scaling

#
# CPU Idle
#
# CONFIG_CPU_IDLE is not set
# end of CPU Idle
# end of CPU Power Management

#
# Floating point emulation
#

#
# At least one emulation must be selected
#
# CONFIG_FPE_NWFPE is not set
# CONFIG_FPE_FASTFPE is not set
# CONFIG_VFP is not set
# end of Floating point emulation

#
# Power management options
#
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
CONFIG_SUSPEND_SKIP_SYNC=y
CONFIG_PM_SLEEP=y
# CONFIG_PM_AUTOSLEEP is not set
CONFIG_PM_WAKELOCKS=y
CONFIG_PM_WAKELOCKS_LIMIT=100
CONFIG_PM_WAKELOCKS_GC=y
CONFIG_PM=y
# CONFIG_PM_DEBUG is not set
CONFIG_APM_EMULATION=m
CONFIG_PM_CLK=y
CONFIG_PM_GENERIC_DOMAINS=y
CONFIG_WQ_POWER_EFFICIENT_DEFAULT=y
CONFIG_PM_GENERIC_DOMAINS_SLEEP=y
CONFIG_PM_GENERIC_DOMAINS_OF=y
CONFIG_CPU_PM=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_ARM_CPU_SUSPEND=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
# end of Power management options

# CONFIG_ARM_CRYPTO is not set
CONFIG_AS_VFP_VMRS_FPINST=y

#
# General architecture-dependent options
#
# CONFIG_KPROBES is not set
# CONFIG_JUMP_LABEL is not set
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_NMI=y
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_GENERIC_IDLE_POLL_SETUP=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_KEEPINITRD=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_32BIT_OFF_T=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_ARCH_WANT_IPC_PARSE_VERSION=y
CONFIG_HAVE_ARCH_SECCOMP=y
# CONFIG_SECCOMP is not set
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR=y
# CONFIG_STACKPROTECTOR_STRONG is not set
CONFIG_LTO_NONE=y
CONFIG_HAVE_CONTEXT_TRACKING=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_REL=y
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=8
CONFIG_PAGE_SIZE_LESS_THAN_64KB=y
CONFIG_PAGE_SIZE_LESS_THAN_256KB=y
CONFIG_ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT=y
CONFIG_ISA_BUS_API=y
CONFIG_CLONE_BACKWARDS=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_OLD_SIGACTION=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_CPU_NO_EFFICIENT_FFS=y
CONFIG_ARCH_OPTIONAL_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
# CONFIG_STRICT_KERNEL_RWX is not set
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
# CONFIG_STRICT_MODULE_RWX is not set
CONFIG_ARCH_HAS_PHYS_TO_DMA=y
# CONFIG_LOCK_EVENT_COUNTS is not set
CONFIG_ARCH_WANT_LD_ORPHAN_WARN=y
CONFIG_HAVE_ARCH_PFN_VALID=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_HAVE_GCC_PLUGINS=y
# CONFIG_GCC_PLUGINS is not set
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
CONFIG_MODULE_FORCE_LOAD=y
# CONFIG_MODULE_UNLOAD is not set
CONFIG_MODVERSIONS=y
CONFIG_MODULE_SRCVERSION_ALL=y
# CONFIG_MODULE_SIG is not set
CONFIG_MODULE_COMPRESS_NONE=y
# CONFIG_MODULE_COMPRESS_GZIP is not set
# CONFIG_MODULE_COMPRESS_XZ is not set
# CONFIG_MODULE_COMPRESS_ZSTD is not set
CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS=y
CONFIG_MODPROBE_PATH="/sbin/modprobe"
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLOCK_LEGACY_AUTOLOAD=y
CONFIG_BLK_DEV_BSG_COMMON=y
CONFIG_BLK_ICQ=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_INTEGRITY_T10=m
# CONFIG_BLK_DEV_ZONED is not set
# CONFIG_BLK_WBT is not set
# CONFIG_BLK_DEBUG_FS is not set
# CONFIG_BLK_SED_OPAL is not set
CONFIG_BLK_INLINE_ENCRYPTION=y
CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK=y

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
CONFIG_ACORN_PARTITION=y
CONFIG_ACORN_PARTITION_CUMANA=y
CONFIG_ACORN_PARTITION_EESOX=y
CONFIG_ACORN_PARTITION_ICS=y
CONFIG_ACORN_PARTITION_ADFS=y
CONFIG_ACORN_PARTITION_POWERTEC=y
CONFIG_ACORN_PARTITION_RISCIX=y
# CONFIG_AIX_PARTITION is not set
CONFIG_OSF_PARTITION=y
CONFIG_AMIGA_PARTITION=y
CONFIG_ATARI_PARTITION=y
# CONFIG_MAC_PARTITION is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
# CONFIG_MINIX_SUBPARTITION is not set
# CONFIG_SOLARIS_X86_PARTITION is not set
# CONFIG_UNIXWARE_DISKLABEL is not set
# CONFIG_LDM_PARTITION is not set
# CONFIG_SGI_PARTITION is not set
CONFIG_ULTRIX_PARTITION=y
CONFIG_SUN_PARTITION=y
# CONFIG_KARMA_PARTITION is not set
CONFIG_EFI_PARTITION=y
CONFIG_SYSV68_PARTITION=y
CONFIG_CMDLINE_PARTITION=y
# end of Partition Types

CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_PM=y
CONFIG_BLOCK_HOLDER_DEPRECATED=y
CONFIG_BLK_MQ_STACKING=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=m
CONFIG_IOSCHED_BFQ=y
# end of IO Schedulers

CONFIG_ASN1=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=y
CONFIG_FREEZER=y

#
# Executable file formats
#
# CONFIG_BINFMT_ELF is not set
CONFIG_BINFMT_ELF_FDPIC=y
CONFIG_ELFCORE=y
CONFIG_BINFMT_SCRIPT=m
CONFIG_ARCH_HAS_BINFMT_FLAT=y
# CONFIG_BINFMT_FLAT is not set
CONFIG_BINFMT_FLAT_ARGVP_ENVP_ON_STACK=y
CONFIG_BINFMT_MISC=m
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
# CONFIG_SWAP is not set

#
# SLAB allocator options
#
CONFIG_SLAB=y
# CONFIG_SLUB is not set
# CONFIG_SLOB is not set
# CONFIG_SLAB_MERGE_DEFAULT is not set
# CONFIG_SLAB_FREELIST_RANDOM is not set
CONFIG_SLAB_FREELIST_HARDENED=y
# end of SLAB allocator options

CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
CONFIG_COMPAT_BRK=y
CONFIG_SELECT_MEMORY_MODEL=y
# CONFIG_FLATMEM_MANUAL is not set
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_SPARSEMEM_STATIC=y
CONFIG_ARCH_KEEP_MEMBLOCK=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_EXCLUSIVE_SYSTEM_RAM=y
CONFIG_SPLIT_PTLOCK_CPUS=999999
CONFIG_COMPACTION=y
CONFIG_PAGE_REPORTING=y
CONFIG_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_NEED_PER_CPU_KM=y
CONFIG_CMA=y
# CONFIG_CMA_DEBUG is not set
# CONFIG_CMA_DEBUGFS is not set
CONFIG_CMA_SYSFS=y
CONFIG_CMA_AREAS=7
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_PAGE_IDLE_FLAG=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_CURRENT_STACK_POINTER=y
CONFIG_ZONE_DMA=y
CONFIG_VM_EVENT_COUNTERS=y
CONFIG_PERCPU_STATS=y
CONFIG_GUP_TEST=y
# CONFIG_USERFAULTFD is not set

#
# Data Access Monitoring
#
CONFIG_DAMON=y
CONFIG_DAMON_KUNIT_TEST=y
CONFIG_DAMON_VADDR=y
# CONFIG_DAMON_PADDR is not set
CONFIG_DAMON_VADDR_KUNIT_TEST=y
CONFIG_DAMON_SYSFS=y
# end of Data Access Monitoring
# end of Memory Management options

# CONFIG_NET is not set

#
# Device Drivers
#
CONFIG_ARM_AMBA=y
CONFIG_HAVE_PCI=y
CONFIG_FORCE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCI_DOMAINS_GENERIC=y
CONFIG_PCI_SYSCALL=y
CONFIG_PCIEPORTBUS=y
# CONFIG_PCIEAER is not set
# CONFIG_PCIEASPM is not set
CONFIG_PCIE_PME=y
CONFIG_PCIE_PTM=y
# CONFIG_PCI_MSI is not set
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
CONFIG_PCI_STUB=m
CONFIG_PCI_ATS=y
CONFIG_PCI_ECAM=y
CONFIG_PCI_BRIDGE_EMUL=y
# CONFIG_PCI_IOV is not set
CONFIG_PCI_PRI=y
CONFIG_PCI_PASID=y
# CONFIG_PCIE_BUS_TUNE_OFF is not set
# CONFIG_PCIE_BUS_DEFAULT is not set
CONFIG_PCIE_BUS_SAFE=y
# CONFIG_PCIE_BUS_PERFORMANCE is not set
# CONFIG_PCIE_BUS_PEER2PEER is not set
# CONFIG_VGA_ARB is not set
# CONFIG_HOTPLUG_PCI is not set

#
# PCI controller drivers
#
CONFIG_PCI_MVEBU=m
# CONFIG_PCI_FTPCI100 is not set
# CONFIG_PCI_IXP4XX is not set
CONFIG_PCI_RCAR_GEN2=y
# CONFIG_PCIE_RCAR_EP is not set
CONFIG_PCI_HOST_COMMON=y
# CONFIG_PCI_HOST_GENERIC is not set
# CONFIG_PCIE_XILINX_CPM is not set
CONFIG_PCI_XGENE=y
# CONFIG_PCI_V3_SEMI is not set
# CONFIG_PCI_VERSATILE is not set
CONFIG_PCIE_IPROC=m
CONFIG_PCIE_IPROC_PLATFORM=m
CONFIG_PCIE_IPROC_BCMA=m
CONFIG_PCIE_ALTERA=m
CONFIG_PCI_HOST_THUNDER_PEM=y
# CONFIG_PCI_HOST_THUNDER_ECAM is not set
# CONFIG_PCIE_ROCKCHIP_EP is not set
# CONFIG_PCI_LOONGSON is not set
CONFIG_PCIE_MT7621=y

#
# DesignWare PCI Core Support
#
CONFIG_PCIE_DW=y
CONFIG_PCIE_DW_EP=y
# CONFIG_PCI_KEYSTONE_EP is not set
# CONFIG_PCI_LAYERSCAPE_EP is not set
# CONFIG_PCIE_QCOM_EP is not set
# CONFIG_PCIE_ARTPEC6_EP is not set
CONFIG_PCIE_TEGRA194=y
CONFIG_PCIE_TEGRA194_EP=y
# CONFIG_PCIE_UNIPHIER_EP is not set
# end of DesignWare PCI Core Support

#
# Mobiveil PCIe Core Support
#
# end of Mobiveil PCIe Core Support

#
# Cadence PCIe controllers support
#
CONFIG_PCIE_CADENCE=y
CONFIG_PCIE_CADENCE_HOST=y
CONFIG_PCIE_CADENCE_EP=y
CONFIG_PCIE_CADENCE_PLAT=y
CONFIG_PCIE_CADENCE_PLAT_HOST=y
# CONFIG_PCIE_CADENCE_PLAT_EP is not set
CONFIG_PCI_J721E=y
CONFIG_PCI_J721E_HOST=y
CONFIG_PCI_J721E_EP=y
# end of Cadence PCIe controllers support
# end of PCI controller drivers

#
# PCI Endpoint
#
CONFIG_PCI_ENDPOINT=y
CONFIG_PCI_ENDPOINT_CONFIGFS=y
# CONFIG_PCI_EPF_TEST is not set
CONFIG_PCI_EPF_NTB=m
# end of PCI Endpoint

#
# PCI switch controller drivers
#
CONFIG_PCI_SW_SWITCHTEC=m
# end of PCI switch controller drivers

# CONFIG_CXL_BUS is not set
# CONFIG_PCCARD is not set
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
CONFIG_AUXILIARY_BUS=y
CONFIG_UEVENT_HELPER=y
CONFIG_UEVENT_HELPER_PATH=""
CONFIG_DEVTMPFS=y
# CONFIG_DEVTMPFS_MOUNT is not set
# CONFIG_DEVTMPFS_SAFE is not set
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
CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
# CONFIG_FW_LOADER_COMPRESS is not set
CONFIG_FW_CACHE=y
CONFIG_FW_UPLOAD=y
# end of Firmware loader

CONFIG_WANT_DEV_COREDUMP=y
# CONFIG_ALLOW_DEV_COREDUMP is not set
CONFIG_DEBUG_DRIVER=y
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
CONFIG_PM_QOS_KUNIT_TEST=y
CONFIG_TEST_ASYNC_DRIVER_PROBE=m
CONFIG_DRIVER_PE_KUNIT_TEST=y
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_SOC_BUS=y
CONFIG_REGMAP=y
CONFIG_REGMAP_AC97=m
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SLIMBUS=m
CONFIG_REGMAP_W1=m
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_DMA_SHARED_BUFFER=y
CONFIG_DMA_FENCE_TRACE=y
# end of Generic Driver Options

#
# Bus devices
#
# CONFIG_ARM_INTEGRATOR_LM is not set
# CONFIG_BRCMSTB_GISB_ARB is not set
# CONFIG_BT1_APB is not set
# CONFIG_BT1_AXI is not set
# CONFIG_HISILICON_LPC is not set
# CONFIG_INTEL_IXP4XX_EB is not set
CONFIG_MVEBU_MBUS=y
# CONFIG_QCOM_EBI2 is not set
# CONFIG_SUN50I_DE2_BUS is not set
CONFIG_SUNXI_RSB=m
# CONFIG_TS_NBUS is not set
CONFIG_VEXPRESS_CONFIG=y
CONFIG_FSL_MC_BUS=y
CONFIG_FSL_MC_UAPI_SUPPORT=y
# CONFIG_MHI_BUS is not set
CONFIG_MHI_BUS_EP=y
# end of Bus devices

#
# Firmware Drivers
#

#
# ARM System Control and Management Interface Protocol
#
CONFIG_ARM_SCMI_PROTOCOL=m
CONFIG_ARM_SCMI_HAVE_TRANSPORT=y
CONFIG_ARM_SCMI_HAVE_MSG=y
# CONFIG_ARM_SCMI_TRANSPORT_MAILBOX is not set
CONFIG_ARM_SCMI_TRANSPORT_VIRTIO=y
CONFIG_ARM_SCMI_TRANSPORT_VIRTIO_VERSION1_COMPLIANCE=y
CONFIG_ARM_SCMI_TRANSPORT_VIRTIO_ATOMIC_ENABLE=y
CONFIG_ARM_SCMI_POWER_DOMAIN=y
# end of ARM System Control and Management Interface Protocol

CONFIG_ARM_SCPI_PROTOCOL=y
CONFIG_ARM_SCPI_POWER_DOMAIN=m
# CONFIG_FIRMWARE_MEMMAP is not set
CONFIG_FW_CFG_SYSFS=m
CONFIG_FW_CFG_SYSFS_CMDLINE=y
CONFIG_QCOM_SCM=y
CONFIG_QCOM_SCM_DOWNLOAD_MODE_DEFAULT=y
# CONFIG_SYSFB_SIMPLEFB is not set
CONFIG_TURRIS_MOX_RWTM=m
CONFIG_BCM47XX_NVRAM=y
CONFIG_BCM47XX_SPROM=y
# CONFIG_TEE_BNXT_FW is not set
CONFIG_CS_DSP=m
# CONFIG_GOOGLE_FIRMWARE is not set

#
# EFI (Extensible Firmware Interface) Support
#
CONFIG_EFI_ESRT=y
CONFIG_EFI_PARAMS_FROM_FDT=y
CONFIG_EFI_RUNTIME_WRAPPERS=y
CONFIG_EFI_GENERIC_STUB=y
CONFIG_EFI_ARMSTUB_DTB_LOADER=y
# CONFIG_EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER is not set
# CONFIG_EFI_BOOTLOADER_CONTROL is not set
CONFIG_EFI_CAPSULE_LOADER=y
# CONFIG_EFI_TEST is not set
CONFIG_RESET_ATTACK_MITIGATION=y
CONFIG_EFI_RCI2_TABLE=y
# CONFIG_EFI_DISABLE_PCI_DMA is not set
CONFIG_EFI_DISABLE_RUNTIME=y
# CONFIG_EFI_COCO_SECRET is not set
# end of EFI (Extensible Firmware Interface) Support

CONFIG_IMX_DSP=m
CONFIG_IMX_SCU=y
# CONFIG_IMX_SCU_PD is not set

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

CONFIG_GNSS=y
CONFIG_GNSS_USB=m
CONFIG_MTD=m
CONFIG_MTD_TESTS=m

#
# Partition parsers
#
CONFIG_MTD_AR7_PARTS=m
CONFIG_MTD_BCM63XX_PARTS=y
# CONFIG_MTD_CMDLINE_PARTS is not set
CONFIG_MTD_OF_PARTS=m
CONFIG_MTD_OF_PARTS_BCM4908=y
CONFIG_MTD_OF_PARTS_LINKSYS_NS=y
CONFIG_MTD_PARSER_IMAGETAG=m
CONFIG_MTD_AFS_PARTS=m
# CONFIG_MTD_PARSER_TRX is not set
# CONFIG_MTD_SHARPSL_PARTS is not set
# CONFIG_MTD_REDBOOT_PARTS is not set
CONFIG_MTD_QCOMSMEM_PARTS=m
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
CONFIG_NFTL_RW=y
# CONFIG_INFTL is not set
CONFIG_RFD_FTL=m
CONFIG_SSFDC=m
CONFIG_SM_FTL=m
# CONFIG_MTD_OOPS is not set
CONFIG_MTD_PARTITIONED_MASTER=y

#
# RAM/ROM/Flash chip drivers
#
CONFIG_MTD_CFI=m
# CONFIG_MTD_JEDECPROBE is not set
CONFIG_MTD_GEN_PROBE=m
CONFIG_MTD_CFI_ADV_OPTIONS=y
# CONFIG_MTD_CFI_NOSWAP is not set
# CONFIG_MTD_CFI_BE_BYTE_SWAP is not set
CONFIG_MTD_CFI_LE_BYTE_SWAP=y
# CONFIG_MTD_CFI_GEOMETRY is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
# CONFIG_MTD_OTP is not set
# CONFIG_MTD_CFI_INTELEXT is not set
CONFIG_MTD_CFI_AMDSTD=m
# CONFIG_MTD_CFI_STAA is not set
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
# CONFIG_MTD_SC520CDP is not set
CONFIG_MTD_NETSC520=m
# CONFIG_MTD_TS5500 is not set
CONFIG_MTD_PCI=m
# CONFIG_MTD_INTEL_VR_NOR is not set
# CONFIG_MTD_PLATRAM is not set
# end of Mapping drivers for chip access

#
# Self-contained MTD device drivers
#
CONFIG_MTD_PMC551=m
# CONFIG_MTD_PMC551_BUGFIX is not set
# CONFIG_MTD_PMC551_DEBUG is not set
# CONFIG_MTD_SPEAR_SMI is not set
CONFIG_MTD_SLRAM=m
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
CONFIG_MTD_NAND_DENALI_DT=m
CONFIG_MTD_NAND_AMS_DELTA=m
# CONFIG_MTD_NAND_OMAP2 is not set
CONFIG_MTD_NAND_SHARPSL=m
# CONFIG_MTD_NAND_CAFE is not set
# CONFIG_MTD_NAND_ATMEL is not set
CONFIG_MTD_NAND_ORION=m
# CONFIG_MTD_NAND_MARVELL is not set
CONFIG_MTD_NAND_SLC_LPC32XX=m
# CONFIG_MTD_NAND_MLC_LPC32XX is not set
CONFIG_MTD_NAND_TMIO=m
CONFIG_MTD_NAND_BRCMNAND=m
CONFIG_MTD_NAND_BRCMNAND_BCMA=m
CONFIG_MTD_NAND_BCM47XXNFLASH=m
CONFIG_MTD_NAND_OXNAS=m
CONFIG_MTD_NAND_FSL_IFC=m
CONFIG_MTD_NAND_VF610_NFC=m
CONFIG_MTD_NAND_MXC=m
# CONFIG_MTD_NAND_SH_FLCTL is not set
CONFIG_MTD_NAND_DAVINCI=m
CONFIG_MTD_NAND_TXX9NDFMC=m
CONFIG_MTD_NAND_FSMC=m
CONFIG_MTD_NAND_SUNXI=m
# CONFIG_MTD_NAND_HISI504 is not set
CONFIG_MTD_NAND_QCOM=m
CONFIG_MTD_NAND_MXIC=m
CONFIG_MTD_NAND_TEGRA=m
# CONFIG_MTD_NAND_STM32_FMC2 is not set
CONFIG_MTD_NAND_MESON=m
CONFIG_MTD_NAND_GPIO=m
CONFIG_MTD_NAND_PLATFORM=m
CONFIG_MTD_NAND_CADENCE=m
CONFIG_MTD_NAND_ARASAN=m
CONFIG_MTD_NAND_INTEL_LGM=m
CONFIG_MTD_NAND_RENESAS=m

#
# Misc
#
CONFIG_MTD_SM_COMMON=m
CONFIG_MTD_NAND_NANDSIM=m
CONFIG_MTD_NAND_RICOH=m
CONFIG_MTD_NAND_DISKONCHIP=m
CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADVANCED=y
CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADDRESS=0
CONFIG_MTD_NAND_DISKONCHIP_PROBE_HIGH=y
# CONFIG_MTD_NAND_DISKONCHIP_BBTWRITE is not set

#
# ECC engine support
#
CONFIG_MTD_NAND_ECC=y
CONFIG_MTD_NAND_ECC_SW_HAMMING=y
CONFIG_MTD_NAND_ECC_SW_HAMMING_SMC=y
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
# CONFIG_MTD_LPDDR2_NVM is not set
# end of LPDDR & LPDDR2 PCM memory drivers

CONFIG_MTD_UBI=m
CONFIG_MTD_UBI_WL_THRESHOLD=4096
CONFIG_MTD_UBI_BEB_LIMIT=20
# CONFIG_MTD_UBI_FASTMAP is not set
# CONFIG_MTD_UBI_GLUEBI is not set
CONFIG_MTD_UBI_BLOCK=y
CONFIG_MTD_HYPERBUS=m
# CONFIG_HBMC_AM654 is not set
CONFIG_DTC=y
CONFIG_OF=y
CONFIG_OF_UNITTEST=y
# CONFIG_OF_ALL_DTBS is not set
CONFIG_OF_FLATTREE=y
CONFIG_OF_EARLY_FLATTREE=y
CONFIG_OF_KOBJ=y
CONFIG_OF_DYNAMIC=y
CONFIG_OF_ADDRESS=y
CONFIG_OF_IRQ=y
CONFIG_OF_RESERVED_MEM=y
CONFIG_OF_RESOLVE=y
CONFIG_OF_OVERLAY=y
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=m
# CONFIG_PARPORT_PC is not set
# CONFIG_PARPORT_AX88796 is not set
# CONFIG_PARPORT_1284 is not set
# CONFIG_BLK_DEV is not set

#
# NVME Support
#
CONFIG_NVME_CORE=m
# CONFIG_BLK_DEV_NVME is not set
CONFIG_NVME_MULTIPATH=y
# CONFIG_NVME_VERBOSE_ERRORS is not set
# CONFIG_NVME_HWMON is not set
CONFIG_NVME_FABRICS=m
CONFIG_NVME_FC=m
# CONFIG_NVME_APPLE is not set
# CONFIG_NVME_TARGET is not set
# end of NVME Support

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=m
# CONFIG_AD525X_DPOT is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_PHANTOM is not set
CONFIG_TIFM_CORE=m
# CONFIG_TIFM_7XX1 is not set
CONFIG_ICS932S401=m
# CONFIG_ATMEL_SSC is not set
# CONFIG_ENCLOSURE_SERVICES is not set
CONFIG_HP_ILO=y
# CONFIG_QCOM_COINCELL is not set
CONFIG_QCOM_FASTRPC=m
CONFIG_APDS9802ALS=y
# CONFIG_ISL29003 is not set
CONFIG_ISL29020=m
CONFIG_SENSORS_TSL2550=m
CONFIG_SENSORS_BH1770=m
# CONFIG_SENSORS_APDS990X is not set
CONFIG_HMC6352=m
CONFIG_DS1682=y
CONFIG_PCH_PHUB=m
CONFIG_SRAM=y
CONFIG_SRAM_EXEC=y
# CONFIG_DW_XDATA_PCIE is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
CONFIG_XILINX_SDFEC=y
CONFIG_MISC_RTSX=m
CONFIG_HISI_HIKEY_USB=y
CONFIG_OPEN_DICE=m
# CONFIG_C2PORT is not set

#
# EEPROM support
#
CONFIG_EEPROM_AT24=m
CONFIG_EEPROM_LEGACY=m
CONFIG_EEPROM_MAX6875=y
CONFIG_EEPROM_93CX6=m
CONFIG_EEPROM_IDT_89HPESX=m
# CONFIG_EEPROM_EE1004 is not set
# end of EEPROM support

# CONFIG_CB710_CORE is not set

#
# Texas Instruments shared transport line discipline
#
# end of Texas Instruments shared transport line discipline

CONFIG_SENSORS_LIS3_I2C=m
CONFIG_ALTERA_STAPL=y
CONFIG_ECHO=y
CONFIG_MISC_ALCOR_PCI=m
CONFIG_MISC_RTSX_PCI=m
# CONFIG_MISC_RTSX_USB is not set
CONFIG_HABANA_AI=m
CONFIG_UACCE=m
CONFIG_PVPANIC=y
CONFIG_PVPANIC_MMIO=m
CONFIG_PVPANIC_PCI=y
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
CONFIG_BLK_DEV_SD=m
# CONFIG_CHR_DEV_ST is not set
CONFIG_CHR_DEV_SG=m
# CONFIG_BLK_DEV_BSG is not set
CONFIG_CHR_DEV_SCH=m
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
CONFIG_SCSI_SRP_ATTRS=m
# end of SCSI Transports

CONFIG_SCSI_LOWLEVEL=y
# CONFIG_ISCSI_BOOT_SYSFS is not set
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_HPSA is not set
CONFIG_SCSI_3W_9XXX=m
CONFIG_SCSI_3W_SAS=m
CONFIG_SCSI_ACARD=y
CONFIG_SCSI_AACRAID=m
CONFIG_SCSI_AIC7XXX=y
CONFIG_AIC7XXX_CMDS_PER_DEVICE=32
CONFIG_AIC7XXX_RESET_DELAY_MS=5000
CONFIG_AIC7XXX_DEBUG_ENABLE=y
CONFIG_AIC7XXX_DEBUG_MASK=0
# CONFIG_AIC7XXX_REG_PRETTY_PRINT is not set
# CONFIG_SCSI_AIC79XX is not set
CONFIG_SCSI_AIC94XX=m
# CONFIG_AIC94XX_DEBUG is not set
CONFIG_SCSI_HISI_SAS=y
# CONFIG_SCSI_HISI_SAS_DEBUGFS_DEFAULT_ENABLE is not set
CONFIG_SCSI_MVSAS=y
CONFIG_SCSI_MVSAS_DEBUG=y
CONFIG_SCSI_MVSAS_TASKLET=y
CONFIG_SCSI_MVUMI=y
CONFIG_SCSI_ADVANSYS=m
CONFIG_SCSI_ARCMSR=m
CONFIG_SCSI_ESAS2R=m
CONFIG_MEGARAID_NEWGEN=y
# CONFIG_MEGARAID_MM is not set
# CONFIG_MEGARAID_LEGACY is not set
CONFIG_MEGARAID_SAS=y
CONFIG_SCSI_MPT3SAS=m
CONFIG_SCSI_MPT2SAS_MAX_SGE=128
CONFIG_SCSI_MPT3SAS_MAX_SGE=128
CONFIG_SCSI_MPT2SAS=m
CONFIG_SCSI_MPI3MR=m
# CONFIG_SCSI_SMARTPQI is not set
CONFIG_SCSI_HPTIOP=y
CONFIG_SCSI_MYRB=y
CONFIG_SCSI_MYRS=m
# CONFIG_SCSI_SNIC is not set
CONFIG_SCSI_DMX3191D=y
CONFIG_SCSI_FDOMAIN=y
CONFIG_SCSI_FDOMAIN_PCI=y
CONFIG_SCSI_IPS=y
CONFIG_SCSI_INITIO=y
# CONFIG_SCSI_INIA100 is not set
CONFIG_SCSI_STEX=y
# CONFIG_SCSI_SYM53C8XX_2 is not set
CONFIG_SCSI_IPR=y
CONFIG_SCSI_IPR_TRACE=y
# CONFIG_SCSI_IPR_DUMP is not set
CONFIG_SCSI_QLOGIC_1280=m
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_AM53C974 is not set
CONFIG_SCSI_NSP32=m
CONFIG_SCSI_WD719X=m
CONFIG_SCSI_DEBUG=y
# CONFIG_SCSI_PM8001 is not set
CONFIG_SCSI_VIRTIO=m
# CONFIG_SCSI_DH is not set
# end of SCSI device support

CONFIG_ATA=y
CONFIG_SATA_HOST=y
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_FORCE=y
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI=y
CONFIG_SATA_MOBILE_LPM_POLICY=0
# CONFIG_SATA_AHCI_PLATFORM is not set
CONFIG_AHCI_BRCM=m
CONFIG_AHCI_DA850=m
# CONFIG_AHCI_DM816 is not set
# CONFIG_AHCI_IMX is not set
# CONFIG_AHCI_CEVA is not set
CONFIG_AHCI_MTK=m
# CONFIG_AHCI_MVEBU is not set
CONFIG_AHCI_SUNXI=m
CONFIG_AHCI_TEGRA=m
CONFIG_AHCI_XGENE=m
# CONFIG_AHCI_QORIQ is not set
CONFIG_SATA_FSL=m
# CONFIG_SATA_GEMINI is not set
CONFIG_SATA_AHCI_SEATTLE=y
CONFIG_SATA_INIC162X=m
# CONFIG_SATA_ACARD_AHCI is not set
CONFIG_SATA_SIL24=m
# CONFIG_ATA_SFF is not set
CONFIG_MD=y
CONFIG_BLK_DEV_MD=m
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID10=m
CONFIG_MD_RAID456=m
CONFIG_MD_MULTIPATH=m
CONFIG_MD_FAULTY=m
CONFIG_BCACHE=y
# CONFIG_BCACHE_DEBUG is not set
# CONFIG_BCACHE_CLOSURES_DEBUG is not set
# CONFIG_BCACHE_ASYNC_REGISTRATION is not set
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_BLK_DEV_DM=m
CONFIG_DM_DEBUG=y
CONFIG_DM_BUFIO=m
# CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
CONFIG_DM_BIO_PRISON=m
CONFIG_DM_PERSISTENT_DATA=m
CONFIG_DM_UNSTRIPED=m
CONFIG_DM_CRYPT=m
# CONFIG_DM_SNAPSHOT is not set
CONFIG_DM_THIN_PROVISIONING=m
CONFIG_DM_CACHE=m
CONFIG_DM_CACHE_SMQ=m
CONFIG_DM_WRITECACHE=m
CONFIG_DM_EBS=m
# CONFIG_DM_ERA is not set
# CONFIG_DM_CLONE is not set
CONFIG_DM_MIRROR=m
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
CONFIG_DM_SWITCH=m
CONFIG_DM_LOG_WRITES=m
# CONFIG_DM_INTEGRITY is not set
# CONFIG_TARGET_CORE is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_FIREWIRE is not set
CONFIG_FIREWIRE_NOSY=y
# end of IEEE 1394 (FireWire) support

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=m
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
CONFIG_INPUT_EVBUG=m
CONFIG_INPUT_APMPOWER=m

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ADC=m
# CONFIG_KEYBOARD_ADP5588 is not set
CONFIG_KEYBOARD_ADP5589=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_KEYBOARD_QT1050=m
CONFIG_KEYBOARD_QT1070=y
CONFIG_KEYBOARD_QT2160=y
# CONFIG_KEYBOARD_CLPS711X is not set
CONFIG_KEYBOARD_DLINK_DIR685=y
CONFIG_KEYBOARD_LKKBD=m
CONFIG_KEYBOARD_EP93XX=y
# CONFIG_KEYBOARD_GPIO is not set
CONFIG_KEYBOARD_GPIO_POLLED=m
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
CONFIG_KEYBOARD_MATRIX=m
CONFIG_KEYBOARD_LM8323=m
CONFIG_KEYBOARD_LM8333=m
CONFIG_KEYBOARD_LPC32XX=m
CONFIG_KEYBOARD_MAX7359=y
CONFIG_KEYBOARD_MCS=m
CONFIG_KEYBOARD_MPR121=y
CONFIG_KEYBOARD_SNVS_PWRKEY=y
CONFIG_KEYBOARD_IMX=y
CONFIG_KEYBOARD_IMX_SC_KEY=m
CONFIG_KEYBOARD_NEWTON=m
CONFIG_KEYBOARD_NOMADIK=m
# CONFIG_KEYBOARD_OPENCORES is not set
CONFIG_KEYBOARD_PXA27x=y
CONFIG_KEYBOARD_PMIC8XXX=m
CONFIG_KEYBOARD_SAMSUNG=y
CONFIG_KEYBOARD_GOLDFISH_EVENTS=m
CONFIG_KEYBOARD_STOWAWAY=m
# CONFIG_KEYBOARD_ST_KEYSCAN is not set
# CONFIG_KEYBOARD_SUNKBD is not set
CONFIG_KEYBOARD_SH_KEYSC=m
CONFIG_KEYBOARD_STMPE=m
CONFIG_KEYBOARD_SUN4I_LRADC=m
CONFIG_KEYBOARD_IQS62X=m
# CONFIG_KEYBOARD_OMAP4 is not set
# CONFIG_KEYBOARD_SPEAR is not set
CONFIG_KEYBOARD_TM2_TOUCHKEY=m
CONFIG_KEYBOARD_TWL4030=y
# CONFIG_KEYBOARD_XTKBD is not set
CONFIG_KEYBOARD_CAP11XX=y
CONFIG_KEYBOARD_BCM=m
# CONFIG_KEYBOARD_MT6779 is not set
# CONFIG_KEYBOARD_CYPRESS_SF is not set
# CONFIG_INPUT_MOUSE is not set
# CONFIG_INPUT_JOYSTICK is not set
CONFIG_INPUT_TABLET=y
CONFIG_TABLET_USB_ACECAD=m
CONFIG_TABLET_USB_AIPTEK=y
CONFIG_TABLET_USB_HANWANG=m
CONFIG_TABLET_USB_KBTAB=m
CONFIG_TABLET_USB_PEGASUS=m
CONFIG_TABLET_SERIAL_WACOM4=m
CONFIG_INPUT_TOUCHSCREEN=y
CONFIG_TOUCHSCREEN_AD7879=m
CONFIG_TOUCHSCREEN_AD7879_I2C=m
# CONFIG_TOUCHSCREEN_ADC is not set
# CONFIG_TOUCHSCREEN_AR1021_I2C is not set
# CONFIG_TOUCHSCREEN_ATMEL_MXT is not set
CONFIG_TOUCHSCREEN_AUO_PIXCIR=y
# CONFIG_TOUCHSCREEN_BU21013 is not set
# CONFIG_TOUCHSCREEN_BU21029 is not set
CONFIG_TOUCHSCREEN_CHIPONE_ICN8318=y
# CONFIG_TOUCHSCREEN_CY8CTMA140 is not set
CONFIG_TOUCHSCREEN_CY8CTMG110=y
# CONFIG_TOUCHSCREEN_CYTTSP_CORE is not set
# CONFIG_TOUCHSCREEN_CYTTSP4_CORE is not set
CONFIG_TOUCHSCREEN_DYNAPRO=y
# CONFIG_TOUCHSCREEN_HAMPSHIRE is not set
# CONFIG_TOUCHSCREEN_EETI is not set
CONFIG_TOUCHSCREEN_EGALAX=y
CONFIG_TOUCHSCREEN_EGALAX_SERIAL=y
CONFIG_TOUCHSCREEN_EXC3000=y
# CONFIG_TOUCHSCREEN_FUJITSU is not set
CONFIG_TOUCHSCREEN_GOODIX=y
# CONFIG_TOUCHSCREEN_HIDEEP is not set
CONFIG_TOUCHSCREEN_HYCON_HY46XX=y
CONFIG_TOUCHSCREEN_ILI210X=y
CONFIG_TOUCHSCREEN_ILITEK=y
# CONFIG_TOUCHSCREEN_IPROC is not set
# CONFIG_TOUCHSCREEN_S6SY761 is not set
# CONFIG_TOUCHSCREEN_GUNZE is not set
# CONFIG_TOUCHSCREEN_EKTF2127 is not set
# CONFIG_TOUCHSCREEN_ELAN is not set
CONFIG_TOUCHSCREEN_ELO=y
CONFIG_TOUCHSCREEN_WACOM_W8001=m
CONFIG_TOUCHSCREEN_WACOM_I2C=m
CONFIG_TOUCHSCREEN_LPC32XX=m
CONFIG_TOUCHSCREEN_MAX11801=m
CONFIG_TOUCHSCREEN_MCS5000=m
CONFIG_TOUCHSCREEN_MMS114=y
# CONFIG_TOUCHSCREEN_MELFAS_MIP4 is not set
# CONFIG_TOUCHSCREEN_MSG2638 is not set
CONFIG_TOUCHSCREEN_MTOUCH=y
# CONFIG_TOUCHSCREEN_IMAGIS is not set
CONFIG_TOUCHSCREEN_IMX6UL_TSC=m
CONFIG_TOUCHSCREEN_INEXIO=y
CONFIG_TOUCHSCREEN_MK712=m
# CONFIG_TOUCHSCREEN_PENMOUNT is not set
CONFIG_TOUCHSCREEN_EDT_FT5X06=m
CONFIG_TOUCHSCREEN_RASPBERRYPI_FW=m
# CONFIG_TOUCHSCREEN_MIGOR is not set
CONFIG_TOUCHSCREEN_TOUCHRIGHT=m
CONFIG_TOUCHSCREEN_TOUCHWIN=m
# CONFIG_TOUCHSCREEN_TI_AM335X_TSC is not set
# CONFIG_TOUCHSCREEN_UCB1400 is not set
CONFIG_TOUCHSCREEN_PIXCIR=y
CONFIG_TOUCHSCREEN_WDT87XX_I2C=m
CONFIG_TOUCHSCREEN_WM831X=m
# CONFIG_TOUCHSCREEN_WM97XX is not set
CONFIG_TOUCHSCREEN_USB_COMPOSITE=m
# CONFIG_TOUCHSCREEN_MXS_LRADC is not set
CONFIG_TOUCHSCREEN_MC13783=m
# CONFIG_TOUCHSCREEN_USB_EGALAX is not set
CONFIG_TOUCHSCREEN_USB_PANJIT=y
# CONFIG_TOUCHSCREEN_USB_3M is not set
CONFIG_TOUCHSCREEN_USB_ITM=y
# CONFIG_TOUCHSCREEN_USB_ETURBO is not set
CONFIG_TOUCHSCREEN_USB_GUNZE=y
CONFIG_TOUCHSCREEN_USB_DMC_TSC10=y
# CONFIG_TOUCHSCREEN_USB_IRTOUCH is not set
# CONFIG_TOUCHSCREEN_USB_IDEALTEK is not set
# CONFIG_TOUCHSCREEN_USB_GENERAL_TOUCH is not set
CONFIG_TOUCHSCREEN_USB_GOTOP=y
# CONFIG_TOUCHSCREEN_USB_JASTEC is not set
CONFIG_TOUCHSCREEN_USB_ELO=y
CONFIG_TOUCHSCREEN_USB_E2I=y
# CONFIG_TOUCHSCREEN_USB_ZYTRONIC is not set
# CONFIG_TOUCHSCREEN_USB_ETT_TC45USB is not set
CONFIG_TOUCHSCREEN_USB_NEXIO=y
# CONFIG_TOUCHSCREEN_USB_EASYTOUCH is not set
CONFIG_TOUCHSCREEN_TOUCHIT213=m
CONFIG_TOUCHSCREEN_TS4800=y
# CONFIG_TOUCHSCREEN_TSC_SERIO is not set
# CONFIG_TOUCHSCREEN_TSC2004 is not set
CONFIG_TOUCHSCREEN_TSC2007=m
CONFIG_TOUCHSCREEN_TSC2007_IIO=y
CONFIG_TOUCHSCREEN_RM_TS=m
CONFIG_TOUCHSCREEN_SILEAD=y
# CONFIG_TOUCHSCREEN_SIS_I2C is not set
# CONFIG_TOUCHSCREEN_ST1232 is not set
CONFIG_TOUCHSCREEN_STMFTS=m
CONFIG_TOUCHSCREEN_STMPE=y
CONFIG_TOUCHSCREEN_SUN4I=m
CONFIG_TOUCHSCREEN_SX8654=m
CONFIG_TOUCHSCREEN_TPS6507X=m
CONFIG_TOUCHSCREEN_ZET6223=y
CONFIG_TOUCHSCREEN_ZFORCE=y
CONFIG_TOUCHSCREEN_ROHM_BU21023=m
CONFIG_TOUCHSCREEN_IQS5XX=m
CONFIG_TOUCHSCREEN_ZINITIX=m
# CONFIG_INPUT_MISC is not set
CONFIG_RMI4_CORE=y
CONFIG_RMI4_I2C=m
# CONFIG_RMI4_SMB is not set
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=y
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
CONFIG_RMI4_F34=y
# CONFIG_RMI4_F3A is not set
CONFIG_RMI4_F55=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_SERIO_PARKBD=m
CONFIG_SERIO_AMBAKMI=m
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=y
# CONFIG_SERIO_ALTERA_PS2 is not set
CONFIG_SERIO_PS2MULT=m
# CONFIG_SERIO_ARC_PS2 is not set
CONFIG_SERIO_APBPS2=y
# CONFIG_SERIO_OLPC_APSP is not set
CONFIG_SERIO_SUN4I_PS2=y
# CONFIG_SERIO_GPIO_PS2 is not set
# CONFIG_USERIO is not set
CONFIG_GAMEPORT=m
CONFIG_GAMEPORT_NS558=m
CONFIG_GAMEPORT_L4=m
CONFIG_GAMEPORT_EMU10K1=m
# CONFIG_GAMEPORT_FM801 is not set
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
# CONFIG_TTY is not set
# CONFIG_SERIAL_DEV_BUS is not set
CONFIG_PRINTER=m
CONFIG_LP_CONSOLE=y
CONFIG_PPDEV=m
# CONFIG_IPMI_HANDLER is not set
CONFIG_IPMI_KCS_BMC=y
CONFIG_ASPEED_KCS_IPMI_BMC=y
# CONFIG_NPCM7XX_KCS_IPMI_BMC is not set
CONFIG_IPMI_KCS_BMC_CDEV_IPMI=y
CONFIG_IPMI_KCS_BMC_SERIO=m
# CONFIG_ASPEED_BT_IPMI_BMC is not set
# CONFIG_IPMB_DEVICE_INTERFACE is not set
CONFIG_HW_RANDOM=m
# CONFIG_HW_RANDOM_TIMERIOMEM is not set
CONFIG_HW_RANDOM_ATMEL=m
CONFIG_HW_RANDOM_BA431=m
# CONFIG_HW_RANDOM_BCM2835 is not set
# CONFIG_HW_RANDOM_IPROC_RNG200 is not set
# CONFIG_HW_RANDOM_IXP4XX is not set
# CONFIG_HW_RANDOM_OMAP is not set
CONFIG_HW_RANDOM_OMAP3_ROM=m
# CONFIG_HW_RANDOM_VIRTIO is not set
# CONFIG_HW_RANDOM_IMX_RNGC is not set
CONFIG_HW_RANDOM_NOMADIK=m
# CONFIG_HW_RANDOM_STM32 is not set
CONFIG_HW_RANDOM_POLARFIRE_SOC=m
CONFIG_HW_RANDOM_MESON=m
# CONFIG_HW_RANDOM_MTK is not set
CONFIG_HW_RANDOM_EXYNOS=m
CONFIG_HW_RANDOM_NPCM=m
CONFIG_HW_RANDOM_KEYSTONE=m
CONFIG_HW_RANDOM_CCTRNG=m
CONFIG_HW_RANDOM_XIPHERA=m
# CONFIG_APPLICOM is not set
# CONFIG_DEVMEM is not set
# CONFIG_DEVPORT is not set
# CONFIG_TCG_TPM is not set
CONFIG_XILLYBUS_CLASS=m
# CONFIG_XILLYBUS is not set
CONFIG_XILLYUSB=m
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
CONFIG_I2C_ARB_GPIO_CHALLENGE=m
CONFIG_I2C_MUX_GPIO=y
# CONFIG_I2C_MUX_GPMUX is not set
CONFIG_I2C_MUX_LTC4306=y
# CONFIG_I2C_MUX_PCA9541 is not set
CONFIG_I2C_MUX_PCA954x=m
# CONFIG_I2C_MUX_PINCTRL is not set
# CONFIG_I2C_MUX_REG is not set
CONFIG_I2C_DEMUX_PINCTRL=y
# CONFIG_I2C_MUX_MLXCPLD is not set
# end of Multiplexer I2C Chip support

# CONFIG_I2C_HELPER_AUTO is not set
CONFIG_I2C_SMBUS=y

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCF=y
CONFIG_I2C_ALGOPCA=m
# end of I2C Algorithms

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
CONFIG_I2C_ALI1535=m
CONFIG_I2C_ALI1563=m
# CONFIG_I2C_ALI15X3 is not set
CONFIG_I2C_AMD756=y
CONFIG_I2C_AMD8111=y
CONFIG_I2C_HIX5HD2=y
CONFIG_I2C_I801=y
CONFIG_I2C_ISCH=m
CONFIG_I2C_PIIX4=m
CONFIG_I2C_NFORCE2=y
# CONFIG_I2C_NVIDIA_GPU is not set
# CONFIG_I2C_SIS5595 is not set
CONFIG_I2C_SIS630=m
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_VIA is not set
# CONFIG_I2C_VIAPRO is not set

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_ALTERA is not set
# CONFIG_I2C_ASPEED is not set
CONFIG_I2C_AT91=y
CONFIG_I2C_AT91_SLAVE_EXPERIMENTAL=m
CONFIG_I2C_AXXIA=m
CONFIG_I2C_BCM2835=m
CONFIG_I2C_BCM_IPROC=y
CONFIG_I2C_BCM_KONA=m
# CONFIG_I2C_BRCMSTB is not set
CONFIG_I2C_CADENCE=m
CONFIG_I2C_CBUS_GPIO=y
CONFIG_I2C_DAVINCI=y
# CONFIG_I2C_DESIGNWARE_PLATFORM is not set
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_DIGICOLOR is not set
CONFIG_I2C_EG20T=m
CONFIG_I2C_EMEV2=m
# CONFIG_I2C_EXYNOS5 is not set
CONFIG_I2C_GPIO=m
# CONFIG_I2C_GPIO_FAULT_INJECTOR is not set
CONFIG_I2C_HIGHLANDER=y
CONFIG_I2C_HISI=y
CONFIG_I2C_IMG=y
CONFIG_I2C_IMX=y
# CONFIG_I2C_IMX_LPI2C is not set
CONFIG_I2C_IOP3XX=y
CONFIG_I2C_JZ4780=m
# CONFIG_I2C_KEMPLD is not set
CONFIG_I2C_LPC2K=m
CONFIG_I2C_MESON=y
CONFIG_I2C_MT65XX=m
# CONFIG_I2C_MT7621 is not set
CONFIG_I2C_MV64XXX=y
CONFIG_I2C_MXS=m
# CONFIG_I2C_NOMADIK is not set
# CONFIG_I2C_NPCM7XX is not set
# CONFIG_I2C_OCORES is not set
CONFIG_I2C_OMAP=m
CONFIG_I2C_OWL=m
CONFIG_I2C_APPLE=y
# CONFIG_I2C_PCA_PLATFORM is not set
# CONFIG_I2C_PNX is not set
CONFIG_I2C_PXA=y
CONFIG_I2C_PXA_SLAVE=y
CONFIG_I2C_QCOM_CCI=m
# CONFIG_I2C_QCOM_GENI is not set
CONFIG_I2C_QUP=y
# CONFIG_I2C_RIIC is not set
# CONFIG_I2C_RK3X is not set
# CONFIG_I2C_S3C2410 is not set
CONFIG_I2C_SH_MOBILE=m
CONFIG_I2C_SIMTEC=y
CONFIG_I2C_SPRD=y
CONFIG_I2C_ST=y
CONFIG_I2C_STM32F4=m
CONFIG_I2C_STM32F7=y
# CONFIG_I2C_SUN6I_P2WI is not set
CONFIG_I2C_SYNQUACER=y
CONFIG_I2C_TEGRA=y
CONFIG_I2C_TEGRA_BPMP=m
# CONFIG_I2C_UNIPHIER is not set
CONFIG_I2C_UNIPHIER_F=y
# CONFIG_I2C_VERSATILE is not set
# CONFIG_I2C_WMT is not set
CONFIG_I2C_XILINX=m
# CONFIG_I2C_XLP9XX is not set
CONFIG_I2C_RCAR=y

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_DIOLAN_U2C=y
# CONFIG_I2C_DLN2 is not set
CONFIG_I2C_CP2615=m
# CONFIG_I2C_PARPORT is not set
CONFIG_I2C_ROBOTFUZZ_OSIF=m
CONFIG_I2C_TINY_USB=m

#
# Other I2C/SMBus bus drivers
#
# CONFIG_I2C_MLXCPLD is not set
# CONFIG_I2C_VIRTIO is not set
# end of I2C Hardware Bus support

# CONFIG_I2C_STUB is not set
CONFIG_I2C_SLAVE=y
CONFIG_I2C_SLAVE_EEPROM=y
CONFIG_I2C_SLAVE_TESTUNIT=m
CONFIG_I2C_DEBUG_CORE=y
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

# CONFIG_I3C is not set
# CONFIG_SPI is not set
# CONFIG_SPMI is not set
CONFIG_HSI=m
CONFIG_HSI_BOARDINFO=y

#
# HSI controllers
#
CONFIG_OMAP_SSI=m

#
# HSI clients
#
CONFIG_HSI_CHAR=m
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
CONFIG_GENERIC_PINCTRL_GROUPS=y
CONFIG_PINMUX=y
CONFIG_GENERIC_PINMUX_FUNCTIONS=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
CONFIG_DEBUG_PINCTRL=y
CONFIG_PINCTRL_AMD=y
CONFIG_PINCTRL_AS3722=m
CONFIG_PINCTRL_AT91=y
CONFIG_PINCTRL_AT91PIO4=y
CONFIG_PINCTRL_AXP209=m
CONFIG_PINCTRL_BM1880=y
# CONFIG_PINCTRL_DA850_PUPD is not set
CONFIG_PINCTRL_DA9062=m
CONFIG_PINCTRL_EQUILIBRIUM=m
CONFIG_PINCTRL_GEMINI=y
# CONFIG_PINCTRL_INGENIC is not set
CONFIG_PINCTRL_LPC18XX=y
# CONFIG_PINCTRL_MAX77620 is not set
CONFIG_PINCTRL_MCP23S08_I2C=y
CONFIG_PINCTRL_MCP23S08=y
CONFIG_PINCTRL_MICROCHIP_SGPIO=y
CONFIG_PINCTRL_OCELOT=y
# CONFIG_PINCTRL_PISTACHIO is not set
CONFIG_PINCTRL_ROCKCHIP=y
CONFIG_PINCTRL_SINGLE=y
# CONFIG_PINCTRL_STARFIVE is not set
CONFIG_PINCTRL_STMFX=y
# CONFIG_PINCTRL_SX150X is not set
CONFIG_PINCTRL_OWL=y
# CONFIG_PINCTRL_S500 is not set
# CONFIG_PINCTRL_S700 is not set
CONFIG_PINCTRL_S900=y
CONFIG_PINCTRL_ASPEED=y
CONFIG_PINCTRL_ASPEED_G4=y
CONFIG_PINCTRL_ASPEED_G5=y
# CONFIG_PINCTRL_ASPEED_G6 is not set
CONFIG_PINCTRL_BCM281XX=y
CONFIG_PINCTRL_BCM2835=y
CONFIG_PINCTRL_BCM4908=m
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
# CONFIG_PINCTRL_NS2_MUX is not set
# CONFIG_PINCTRL_NSP_MUX is not set
CONFIG_PINCTRL_BERLIN=y
CONFIG_PINCTRL_AS370=y
# CONFIG_PINCTRL_BERLIN_BG4CT is not set
CONFIG_PINCTRL_MADERA=m
CONFIG_PINCTRL_CS47L15=y
CONFIG_PINCTRL_CS47L90=y
CONFIG_PINCTRL_MXS=y
CONFIG_PINCTRL_IMX23=y
CONFIG_PINCTRL_IMX28=y

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
CONFIG_PINCTRL_MT8135=y
# CONFIG_PINCTRL_MT8127 is not set
# CONFIG_PINCTRL_MT2712 is not set
CONFIG_PINCTRL_MT6765=m
CONFIG_PINCTRL_MT6779=y
# CONFIG_PINCTRL_MT6795 is not set
# CONFIG_PINCTRL_MT6797 is not set
# CONFIG_PINCTRL_MT7622 is not set
# CONFIG_PINCTRL_MT7986 is not set
# CONFIG_PINCTRL_MT8167 is not set
CONFIG_PINCTRL_MT8173=y
# CONFIG_PINCTRL_MT8183 is not set
# CONFIG_PINCTRL_MT8186 is not set
# CONFIG_PINCTRL_MT8192 is not set
CONFIG_PINCTRL_MT8195=y
CONFIG_PINCTRL_MT8365=y
# CONFIG_PINCTRL_MT8516 is not set
CONFIG_PINCTRL_MT6397=y
# end of MediaTek pinctrl drivers

CONFIG_PINCTRL_MESON=m
# CONFIG_PINCTRL_MESON8 is not set
CONFIG_PINCTRL_MESON8B=y
CONFIG_PINCTRL_MESON8_PMX=m
CONFIG_PINCTRL_MVEBU=y
CONFIG_PINCTRL_ORION=y
CONFIG_PINCTRL_NOMADIK=y
CONFIG_PINCTRL_STN8815=y
CONFIG_PINCTRL_WPCM450=m
CONFIG_PINCTRL_NPCM7XX=y
CONFIG_PINCTRL_PXA=y
CONFIG_PINCTRL_PXA25X=y
CONFIG_PINCTRL_PXA27X=y
CONFIG_PINCTRL_MSM=y
CONFIG_PINCTRL_APQ8064=y
CONFIG_PINCTRL_APQ8084=y
CONFIG_PINCTRL_IPQ4019=m
# CONFIG_PINCTRL_IPQ8064 is not set
CONFIG_PINCTRL_IPQ8074=y
# CONFIG_PINCTRL_IPQ6018 is not set
CONFIG_PINCTRL_MSM8226=m
CONFIG_PINCTRL_MSM8660=m
# CONFIG_PINCTRL_MSM8960 is not set
# CONFIG_PINCTRL_MDM9607 is not set
CONFIG_PINCTRL_MDM9615=y
# CONFIG_PINCTRL_MSM8X74 is not set
# CONFIG_PINCTRL_MSM8916 is not set
CONFIG_PINCTRL_MSM8953=m
# CONFIG_PINCTRL_MSM8976 is not set
# CONFIG_PINCTRL_MSM8994 is not set
CONFIG_PINCTRL_MSM8996=y
CONFIG_PINCTRL_MSM8998=m
CONFIG_PINCTRL_QCM2290=y
CONFIG_PINCTRL_QCS404=y
CONFIG_PINCTRL_QCOM_SSBI_PMIC=y
CONFIG_PINCTRL_SC7180=m
# CONFIG_PINCTRL_SC7280 is not set
CONFIG_PINCTRL_SC7280_LPASS_LPI=y
# CONFIG_PINCTRL_SC8180X is not set
CONFIG_PINCTRL_SC8280XP=m
CONFIG_PINCTRL_SDM660=m
# CONFIG_PINCTRL_SDM845 is not set
# CONFIG_PINCTRL_SDX55 is not set
CONFIG_PINCTRL_SM6115=y
CONFIG_PINCTRL_SM6125=m
# CONFIG_PINCTRL_SM6350 is not set
CONFIG_PINCTRL_SDX65=m
CONFIG_PINCTRL_SM8150=m
CONFIG_PINCTRL_SM8250=m
CONFIG_PINCTRL_SM8250_LPASS_LPI=m
CONFIG_PINCTRL_SM8350=y
# CONFIG_PINCTRL_SM8450 is not set
CONFIG_PINCTRL_LPASS_LPI=y

#
# Renesas pinctrl drivers
#
CONFIG_PINCTRL_RENESAS=y
CONFIG_PINCTRL_SH_PFC=y
CONFIG_PINCTRL_SH_PFC_GPIO=y
CONFIG_PINCTRL_SH_FUNC_GPIO=y
CONFIG_PINCTRL_PFC_EMEV2=y
# CONFIG_PINCTRL_PFC_R8A77995 is not set
CONFIG_PINCTRL_PFC_R8A7794=y
CONFIG_PINCTRL_PFC_R8A77990=y
CONFIG_PINCTRL_PFC_R8A7779=y
CONFIG_PINCTRL_PFC_R8A7790=y
CONFIG_PINCTRL_PFC_R8A77950=y
# CONFIG_PINCTRL_PFC_R8A77951 is not set
# CONFIG_PINCTRL_PFC_R8A7778 is not set
CONFIG_PINCTRL_PFC_R8A7793=y
# CONFIG_PINCTRL_PFC_R8A7791 is not set
# CONFIG_PINCTRL_PFC_R8A77965 is not set
# CONFIG_PINCTRL_PFC_R8A77960 is not set
CONFIG_PINCTRL_PFC_R8A77961=y
CONFIG_PINCTRL_PFC_R8A779F0=y
# CONFIG_PINCTRL_PFC_R8A7792 is not set
CONFIG_PINCTRL_PFC_R8A77980=y
# CONFIG_PINCTRL_PFC_R8A77970 is not set
# CONFIG_PINCTRL_PFC_R8A779A0 is not set
CONFIG_PINCTRL_PFC_R8A7740=y
CONFIG_PINCTRL_PFC_R8A73A4=y
# CONFIG_PINCTRL_RZA1 is not set
CONFIG_PINCTRL_RZA2=y
# CONFIG_PINCTRL_RZG2L is not set
CONFIG_PINCTRL_PFC_R8A77470=y
# CONFIG_PINCTRL_PFC_R8A7745 is not set
# CONFIG_PINCTRL_PFC_R8A7742 is not set
CONFIG_PINCTRL_PFC_R8A7743=y
CONFIG_PINCTRL_PFC_R8A7744=y
CONFIG_PINCTRL_PFC_R8A774C0=y
CONFIG_PINCTRL_PFC_R8A774E1=y
# CONFIG_PINCTRL_PFC_R8A774A1 is not set
CONFIG_PINCTRL_PFC_R8A774B1=y
CONFIG_PINCTRL_RZN1=y
# CONFIG_PINCTRL_PFC_SH7203 is not set
CONFIG_PINCTRL_PFC_SH7264=y
CONFIG_PINCTRL_PFC_SH7269=y
CONFIG_PINCTRL_PFC_SH7720=y
# CONFIG_PINCTRL_PFC_SH7722 is not set
CONFIG_PINCTRL_PFC_SH7734=y
CONFIG_PINCTRL_PFC_SH7757=y
CONFIG_PINCTRL_PFC_SH7785=y
# CONFIG_PINCTRL_PFC_SH7786 is not set
# CONFIG_PINCTRL_PFC_SH73A0 is not set
CONFIG_PINCTRL_PFC_SH7723=y
# CONFIG_PINCTRL_PFC_SH7724 is not set
# CONFIG_PINCTRL_PFC_SHX3 is not set
# end of Renesas pinctrl drivers

CONFIG_PINCTRL_SAMSUNG=y
CONFIG_PINCTRL_EXYNOS=y
# CONFIG_PINCTRL_EXYNOS_ARM is not set
CONFIG_PINCTRL_EXYNOS_ARM64=y
# CONFIG_PINCTRL_S3C24XX is not set
CONFIG_PINCTRL_S3C64XX=y
CONFIG_PINCTRL_SPEAR=y
CONFIG_PINCTRL_SPEAR3XX=y
CONFIG_PINCTRL_SPEAR320=y
CONFIG_PINCTRL_SPEAR_PLGPIO=y
# CONFIG_PINCTRL_SPRD_SC9860 is not set
CONFIG_PINCTRL_STM32=y
CONFIG_PINCTRL_STM32F429=y
# CONFIG_PINCTRL_STM32F469 is not set
# CONFIG_PINCTRL_STM32F746 is not set
CONFIG_PINCTRL_STM32F769=y
CONFIG_PINCTRL_STM32H743=y
CONFIG_PINCTRL_STM32MP135=y
# CONFIG_PINCTRL_STM32MP157 is not set
CONFIG_PINCTRL_SUNXI=y
CONFIG_PINCTRL_SUN4I_A10=y
CONFIG_PINCTRL_SUN5I=y
CONFIG_PINCTRL_SUN6I_A31=y
# CONFIG_PINCTRL_SUN6I_A31_R is not set
# CONFIG_PINCTRL_SUN8I_A23 is not set
CONFIG_PINCTRL_SUN8I_A33=y
CONFIG_PINCTRL_SUN8I_A83T=y
# CONFIG_PINCTRL_SUN8I_A83T_R is not set
# CONFIG_PINCTRL_SUN8I_A23_R is not set
CONFIG_PINCTRL_SUN8I_H3=y
# CONFIG_PINCTRL_SUN8I_H3_R is not set
CONFIG_PINCTRL_SUN8I_V3S=y
CONFIG_PINCTRL_SUN9I_A80=y
# CONFIG_PINCTRL_SUN9I_A80_R is not set
CONFIG_PINCTRL_SUN50I_A64=y
# CONFIG_PINCTRL_SUN50I_A64_R is not set
# CONFIG_PINCTRL_SUN50I_A100 is not set
CONFIG_PINCTRL_SUN50I_A100_R=y
CONFIG_PINCTRL_SUN50I_H5=y
CONFIG_PINCTRL_SUN50I_H6=y
CONFIG_PINCTRL_SUN50I_H6_R=y
CONFIG_PINCTRL_SUN50I_H616=y
# CONFIG_PINCTRL_SUN50I_H616_R is not set
# CONFIG_PINCTRL_TI_IODELAY is not set
CONFIG_PINCTRL_UNIPHIER=y
CONFIG_PINCTRL_UNIPHIER_LD4=y
# CONFIG_PINCTRL_UNIPHIER_PRO4 is not set
# CONFIG_PINCTRL_UNIPHIER_SLD8 is not set
CONFIG_PINCTRL_UNIPHIER_PRO5=y
# CONFIG_PINCTRL_UNIPHIER_PXS2 is not set
CONFIG_PINCTRL_UNIPHIER_LD6B=y
CONFIG_PINCTRL_UNIPHIER_LD11=y
CONFIG_PINCTRL_UNIPHIER_LD20=y
CONFIG_PINCTRL_UNIPHIER_PXS3=y
CONFIG_PINCTRL_UNIPHIER_NX1=y
CONFIG_PINCTRL_VISCONTI=y
CONFIG_PINCTRL_TMPV7700=y
CONFIG_ARCH_HAVE_CUSTOM_GPIO_H=y
CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_OF_GPIO=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
# CONFIG_GPIO_SYSFS is not set
# CONFIG_GPIO_CDEV is not set
CONFIG_GPIO_GENERIC=y
CONFIG_GPIO_REGMAP=m

#
# Memory mapped GPIO drivers
#
CONFIG_GPIO_74XX_MMIO=y
# CONFIG_GPIO_ALTERA is not set
CONFIG_GPIO_ASPEED=m
# CONFIG_GPIO_ASPEED_SGPIO is not set
# CONFIG_GPIO_ATH79 is not set
CONFIG_GPIO_RASPBERRYPI_EXP=y
# CONFIG_GPIO_BCM_KONA is not set
# CONFIG_GPIO_BCM_XGS_IPROC is not set
CONFIG_GPIO_BRCMSTB=y
# CONFIG_GPIO_CADENCE is not set
CONFIG_GPIO_CLPS711X=m
CONFIG_GPIO_DAVINCI=y
# CONFIG_GPIO_DWAPB is not set
CONFIG_GPIO_EIC_SPRD=m
CONFIG_GPIO_EM=y
CONFIG_GPIO_FTGPIO010=y
CONFIG_GPIO_GENERIC_PLATFORM=y
CONFIG_GPIO_GRGPIO=m
# CONFIG_GPIO_HISI is not set
CONFIG_GPIO_HLWD=y
# CONFIG_GPIO_IOP is not set
CONFIG_GPIO_LOGICVC=m
CONFIG_GPIO_LPC18XX=y
CONFIG_GPIO_LPC32XX=m
CONFIG_GPIO_MB86S7X=y
CONFIG_GPIO_MENZ127=y
CONFIG_GPIO_MPC8XXX=y
# CONFIG_GPIO_MT7621 is not set
CONFIG_GPIO_MVEBU=y
CONFIG_GPIO_MXC=y
CONFIG_GPIO_MXS=y
CONFIG_GPIO_OMAP=m
# CONFIG_GPIO_PL061 is not set
CONFIG_GPIO_PMIC_EIC_SPRD=m
CONFIG_GPIO_PXA=y
# CONFIG_GPIO_RCAR is not set
# CONFIG_GPIO_RDA is not set
CONFIG_GPIO_ROCKCHIP=m
CONFIG_GPIO_SAMA5D2_PIOBU=m
CONFIG_GPIO_SIFIVE=y
CONFIG_GPIO_SIOX=m
CONFIG_GPIO_SNPS_CREG=y
CONFIG_GPIO_SPEAR_SPICS=y
CONFIG_GPIO_SPRD=m
CONFIG_GPIO_STP_XWAY=y
CONFIG_GPIO_SYSCON=m
CONFIG_GPIO_TEGRA=m
# CONFIG_GPIO_TEGRA186 is not set
CONFIG_GPIO_TS4800=m
CONFIG_GPIO_UNIPHIER=m
CONFIG_GPIO_VISCONTI=y
CONFIG_GPIO_VX855=m
# CONFIG_GPIO_WCD934X is not set
# CONFIG_GPIO_XGENE_SB is not set
# CONFIG_GPIO_XILINX is not set
CONFIG_GPIO_XLP=m
CONFIG_GPIO_ZEVIO=y
CONFIG_GPIO_AMD_FCH=y
# CONFIG_GPIO_IDT3243X is not set
# end of Memory mapped GPIO drivers

#
# I2C GPIO expanders
#
# CONFIG_GPIO_ADP5588 is not set
CONFIG_GPIO_ADNP=y
CONFIG_GPIO_GW_PLD=m
# CONFIG_GPIO_MAX7300 is not set
# CONFIG_GPIO_MAX732X is not set
CONFIG_GPIO_PCA953X=y
CONFIG_GPIO_PCA953X_IRQ=y
CONFIG_GPIO_PCA9570=m
CONFIG_GPIO_PCF857X=y
# CONFIG_GPIO_TPIC2810 is not set
CONFIG_GPIO_TS4900=m
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
CONFIG_GPIO_ARIZONA=m
CONFIG_GPIO_BD9571MWV=m
# CONFIG_GPIO_DA9055 is not set
CONFIG_GPIO_DLN2=m
# CONFIG_HTC_EGPIO is not set
CONFIG_GPIO_JANZ_TTL=m
CONFIG_GPIO_KEMPLD=y
# CONFIG_GPIO_LP87565 is not set
CONFIG_GPIO_MADERA=m
CONFIG_GPIO_MAX77620=y
CONFIG_GPIO_RC5T583=y
CONFIG_GPIO_SL28CPLD=m
CONFIG_GPIO_STMPE=y
CONFIG_GPIO_TPS65086=m
# CONFIG_GPIO_TPS65218 is not set
CONFIG_GPIO_TPS65910=y
# CONFIG_GPIO_TPS65912 is not set
# CONFIG_GPIO_TQMX86 is not set
# CONFIG_GPIO_TWL4030 is not set
CONFIG_GPIO_UCB1400=m
CONFIG_GPIO_WM831X=y
# CONFIG_GPIO_WM8994 is not set
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
CONFIG_GPIO_AMD8111=y
# CONFIG_GPIO_BT8XX is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCH is not set
CONFIG_GPIO_PCI_IDIO_16=y
CONFIG_GPIO_PCIE_IDIO_24=y
# CONFIG_GPIO_RDC321X is not set
# end of PCI GPIO expanders

#
# USB GPIO expanders
#
# end of USB GPIO expanders

#
# Virtual GPIO drivers
#
CONFIG_GPIO_AGGREGATOR=y
CONFIG_GPIO_MOCKUP=m
CONFIG_GPIO_VIRTIO=y
CONFIG_GPIO_SIM=y
# end of Virtual GPIO drivers

CONFIG_W1=y

#
# 1-wire Bus Masters
#
CONFIG_W1_MASTER_MATROX=y
CONFIG_W1_MASTER_DS2490=m
# CONFIG_W1_MASTER_DS2482 is not set
CONFIG_W1_MASTER_MXC=y
CONFIG_W1_MASTER_DS1WM=y
CONFIG_W1_MASTER_GPIO=m
CONFIG_W1_MASTER_SGI=m
# end of 1-wire Bus Masters

#
# 1-wire Slaves
#
# CONFIG_W1_SLAVE_THERM is not set
CONFIG_W1_SLAVE_SMEM=m
# CONFIG_W1_SLAVE_DS2405 is not set
CONFIG_W1_SLAVE_DS2408=y
# CONFIG_W1_SLAVE_DS2408_READBACK is not set
# CONFIG_W1_SLAVE_DS2413 is not set
CONFIG_W1_SLAVE_DS2406=y
CONFIG_W1_SLAVE_DS2423=m
# CONFIG_W1_SLAVE_DS2805 is not set
CONFIG_W1_SLAVE_DS2430=y
CONFIG_W1_SLAVE_DS2431=m
# CONFIG_W1_SLAVE_DS2433 is not set
CONFIG_W1_SLAVE_DS2438=y
# CONFIG_W1_SLAVE_DS250X is not set
CONFIG_W1_SLAVE_DS2780=y
CONFIG_W1_SLAVE_DS2781=y
# CONFIG_W1_SLAVE_DS28E04 is not set
CONFIG_W1_SLAVE_DS28E17=m
# end of 1-wire Slaves

CONFIG_POWER_RESET=y
# CONFIG_POWER_RESET_AS3722 is not set
# CONFIG_POWER_RESET_AT91_POWEROFF is not set
# CONFIG_POWER_RESET_AT91_RESET is not set
CONFIG_POWER_RESET_AT91_SAMA5D2_SHDWC=y
CONFIG_POWER_RESET_BRCMKONA=y
CONFIG_POWER_RESET_BRCMSTB=y
CONFIG_POWER_RESET_GEMINI_POWEROFF=y
# CONFIG_POWER_RESET_GPIO is not set
CONFIG_POWER_RESET_GPIO_RESTART=y
# CONFIG_POWER_RESET_OCELOT_RESET is not set
# CONFIG_POWER_RESET_PIIX4_POWEROFF is not set
CONFIG_POWER_RESET_LTC2952=y
CONFIG_POWER_RESET_QNAP=y
CONFIG_POWER_RESET_REGULATOR=y
CONFIG_POWER_RESET_RESTART=y
CONFIG_POWER_RESET_TPS65086=y
# CONFIG_POWER_RESET_VERSATILE is not set
CONFIG_POWER_RESET_VEXPRESS=y
CONFIG_POWER_RESET_KEYSTONE=y
CONFIG_POWER_RESET_SYSCON=y
CONFIG_POWER_RESET_SYSCON_POWEROFF=y
CONFIG_POWER_RESET_RMOBILE=m
CONFIG_REBOOT_MODE=m
CONFIG_SYSCON_REBOOT_MODE=m
CONFIG_POWER_RESET_SC27XX=m
# CONFIG_NVMEM_REBOOT_MODE is not set
CONFIG_POWER_SUPPLY=y
CONFIG_POWER_SUPPLY_DEBUG=y
CONFIG_POWER_SUPPLY_HWMON=y
CONFIG_PDA_POWER=m
CONFIG_APM_POWER=m
# CONFIG_GENERIC_ADC_BATTERY is not set
CONFIG_IP5XXX_POWER=m
# CONFIG_WM831X_BACKUP is not set
CONFIG_WM831X_POWER=y
CONFIG_TEST_POWER=y
# CONFIG_CHARGER_ADP5061 is not set
# CONFIG_BATTERY_ACT8945A is not set
CONFIG_BATTERY_CW2015=m
# CONFIG_BATTERY_DS2760 is not set
CONFIG_BATTERY_DS2780=m
CONFIG_BATTERY_DS2781=y
CONFIG_BATTERY_DS2782=y
# CONFIG_BATTERY_LEGO_EV3 is not set
CONFIG_BATTERY_SAMSUNG_SDI=y
# CONFIG_BATTERY_SBS is not set
CONFIG_CHARGER_SBS=y
# CONFIG_MANAGER_SBS is not set
# CONFIG_BATTERY_BQ27XXX is not set
# CONFIG_CHARGER_DA9150 is not set
# CONFIG_BATTERY_DA9150 is not set
CONFIG_CHARGER_AXP20X=m
CONFIG_BATTERY_AXP20X=m
# CONFIG_AXP20X_POWER is not set
CONFIG_BATTERY_MAX17040=m
CONFIG_BATTERY_MAX17042=y
CONFIG_BATTERY_MAX1721X=m
# CONFIG_BATTERY_TWL4030_MADC is not set
# CONFIG_CHARGER_PCF50633 is not set
CONFIG_BATTERY_RX51=m
CONFIG_CHARGER_ISP1704=y
CONFIG_CHARGER_MAX8903=y
CONFIG_CHARGER_TWL4030=y
# CONFIG_CHARGER_LP8727 is not set
# CONFIG_CHARGER_LP8788 is not set
CONFIG_CHARGER_GPIO=y
CONFIG_CHARGER_MANAGER=m
CONFIG_CHARGER_LT3651=y
# CONFIG_CHARGER_LTC4162L is not set
# CONFIG_CHARGER_MAX14577 is not set
CONFIG_CHARGER_DETECTOR_MAX14656=y
CONFIG_CHARGER_MAX77693=y
CONFIG_CHARGER_MAX77976=m
CONFIG_CHARGER_MAX8997=m
CONFIG_CHARGER_MP2629=m
CONFIG_CHARGER_MT6360=y
# CONFIG_CHARGER_QCOM_SMBB is not set
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_CHARGER_BQ24190 is not set
# CONFIG_CHARGER_BQ24257 is not set
# CONFIG_CHARGER_BQ24735 is not set
CONFIG_CHARGER_BQ2515X=m
CONFIG_CHARGER_BQ25890=m
CONFIG_CHARGER_BQ25980=y
CONFIG_CHARGER_BQ256XX=m
CONFIG_CHARGER_SMB347=y
CONFIG_CHARGER_TPS65090=m
# CONFIG_CHARGER_TPS65217 is not set
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
CONFIG_BATTERY_GOLDFISH=y
# CONFIG_BATTERY_RT5033 is not set
# CONFIG_CHARGER_RT9455 is not set
CONFIG_CHARGER_SC2731=m
CONFIG_FUEL_GAUGE_SC27XX=y
# CONFIG_CHARGER_UCS1002 is not set
# CONFIG_CHARGER_BD99954 is not set
CONFIG_RN5T618_POWER=y
CONFIG_BATTERY_UG3105=y
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_AD7414=m
CONFIG_SENSORS_AD7418=y
# CONFIG_SENSORS_ADM1021 is not set
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM1026=m
# CONFIG_SENSORS_ADM1029 is not set
CONFIG_SENSORS_ADM1031=m
CONFIG_SENSORS_ADM1177=m
CONFIG_SENSORS_ADM9240=m
CONFIG_SENSORS_ADT7X10=m
CONFIG_SENSORS_ADT7410=m
CONFIG_SENSORS_ADT7411=y
# CONFIG_SENSORS_ADT7462 is not set
CONFIG_SENSORS_ADT7470=y
CONFIG_SENSORS_ADT7475=m
CONFIG_SENSORS_AHT10=y
CONFIG_SENSORS_AQUACOMPUTER_D5NEXT=y
# CONFIG_SENSORS_AS370 is not set
# CONFIG_SENSORS_ASC7621 is not set
CONFIG_SENSORS_AXI_FAN_CONTROL=m
CONFIG_SENSORS_ARM_SCMI=m
CONFIG_SENSORS_ARM_SCPI=m
CONFIG_SENSORS_ASPEED=y
CONFIG_SENSORS_ATXP1=m
CONFIG_SENSORS_BT1_PVT=y
CONFIG_SENSORS_BT1_PVT_ALARMS=y
CONFIG_SENSORS_CORSAIR_CPRO=y
CONFIG_SENSORS_CORSAIR_PSU=m
# CONFIG_SENSORS_DRIVETEMP is not set
CONFIG_SENSORS_DS620=y
CONFIG_SENSORS_DS1621=m
# CONFIG_SENSORS_DA9055 is not set
CONFIG_SENSORS_I5K_AMB=m
CONFIG_SENSORS_SPARX5=m
CONFIG_SENSORS_F71805F=y
CONFIG_SENSORS_F71882FG=y
# CONFIG_SENSORS_F75375S is not set
# CONFIG_SENSORS_GSC is not set
# CONFIG_SENSORS_MC13783_ADC is not set
CONFIG_SENSORS_FTSTEUTATES=m
CONFIG_SENSORS_GL518SM=y
CONFIG_SENSORS_GL520SM=m
# CONFIG_SENSORS_G760A is not set
CONFIG_SENSORS_G762=y
# CONFIG_SENSORS_GPIO_FAN is not set
# CONFIG_SENSORS_HIH6130 is not set
# CONFIG_SENSORS_IIO_HWMON is not set
# CONFIG_SENSORS_IT87 is not set
# CONFIG_SENSORS_JC42 is not set
# CONFIG_SENSORS_POWR1220 is not set
CONFIG_SENSORS_LAN966X=m
CONFIG_SENSORS_LINEAGE=y
CONFIG_SENSORS_LTC2945=m
CONFIG_SENSORS_LTC2947=m
CONFIG_SENSORS_LTC2947_I2C=m
# CONFIG_SENSORS_LTC2990 is not set
CONFIG_SENSORS_LTC2992=m
# CONFIG_SENSORS_LTC4151 is not set
# CONFIG_SENSORS_LTC4215 is not set
# CONFIG_SENSORS_LTC4222 is not set
# CONFIG_SENSORS_LTC4245 is not set
CONFIG_SENSORS_LTC4260=y
# CONFIG_SENSORS_LTC4261 is not set
CONFIG_SENSORS_MAX127=m
CONFIG_SENSORS_MAX16065=y
# CONFIG_SENSORS_MAX1619 is not set
CONFIG_SENSORS_MAX1668=m
CONFIG_SENSORS_MAX197=m
CONFIG_SENSORS_MAX31730=m
# CONFIG_SENSORS_MAX6620 is not set
# CONFIG_SENSORS_MAX6621 is not set
# CONFIG_SENSORS_MAX6639 is not set
# CONFIG_SENSORS_MAX6642 is not set
CONFIG_SENSORS_MAX6650=m
# CONFIG_SENSORS_MAX6697 is not set
# CONFIG_SENSORS_MAX31790 is not set
# CONFIG_SENSORS_MCP3021 is not set
# CONFIG_SENSORS_TC654 is not set
# CONFIG_SENSORS_TPS23861 is not set
CONFIG_SENSORS_MENF21BMC_HWMON=m
# CONFIG_SENSORS_MR75203 is not set
# CONFIG_SENSORS_LM63 is not set
CONFIG_SENSORS_LM73=y
CONFIG_SENSORS_LM75=y
CONFIG_SENSORS_LM77=y
CONFIG_SENSORS_LM78=y
# CONFIG_SENSORS_LM80 is not set
CONFIG_SENSORS_LM83=y
# CONFIG_SENSORS_LM85 is not set
# CONFIG_SENSORS_LM87 is not set
CONFIG_SENSORS_LM90=y
CONFIG_SENSORS_LM92=y
# CONFIG_SENSORS_LM93 is not set
CONFIG_SENSORS_LM95234=m
CONFIG_SENSORS_LM95241=y
# CONFIG_SENSORS_LM95245 is not set
CONFIG_SENSORS_PC87360=y
CONFIG_SENSORS_PC87427=m
CONFIG_SENSORS_NTC_THERMISTOR=y
CONFIG_SENSORS_NCT6683=m
CONFIG_SENSORS_NCT6775_CORE=m
CONFIG_SENSORS_NCT6775=m
# CONFIG_SENSORS_NCT6775_I2C is not set
# CONFIG_SENSORS_NCT7802 is not set
CONFIG_SENSORS_NCT7904=m
# CONFIG_SENSORS_NPCM7XX is not set
CONFIG_SENSORS_NSA320=m
CONFIG_SENSORS_NZXT_KRAKEN2=m
CONFIG_SENSORS_NZXT_SMART2=m
CONFIG_SENSORS_OCC_P8_I2C=m
CONFIG_SENSORS_OCC=m
# CONFIG_SENSORS_PCF8591 is not set
CONFIG_SENSORS_PECI_CPUTEMP=m
CONFIG_SENSORS_PECI_DIMMTEMP=y
CONFIG_SENSORS_PECI=y
CONFIG_PMBUS=y
CONFIG_SENSORS_PMBUS=y
# CONFIG_SENSORS_ADM1266 is not set
CONFIG_SENSORS_ADM1275=m
CONFIG_SENSORS_BEL_PFE=m
# CONFIG_SENSORS_BPA_RS600 is not set
# CONFIG_SENSORS_DELTA_AHE50DC_FAN is not set
# CONFIG_SENSORS_FSP_3Y is not set
CONFIG_SENSORS_IBM_CFFPS=m
CONFIG_SENSORS_DPS920AB=m
# CONFIG_SENSORS_INSPUR_IPSPS is not set
# CONFIG_SENSORS_IR35221 is not set
CONFIG_SENSORS_IR36021=y
# CONFIG_SENSORS_IR38064 is not set
# CONFIG_SENSORS_IRPS5401 is not set
CONFIG_SENSORS_ISL68137=y
CONFIG_SENSORS_LM25066=m
CONFIG_SENSORS_LM25066_REGULATOR=y
CONFIG_SENSORS_LTC2978=m
CONFIG_SENSORS_LTC2978_REGULATOR=y
# CONFIG_SENSORS_LTC3815 is not set
CONFIG_SENSORS_MAX15301=y
CONFIG_SENSORS_MAX16064=y
# CONFIG_SENSORS_MAX16601 is not set
CONFIG_SENSORS_MAX20730=y
CONFIG_SENSORS_MAX20751=y
CONFIG_SENSORS_MAX31785=m
CONFIG_SENSORS_MAX34440=m
CONFIG_SENSORS_MAX8688=m
CONFIG_SENSORS_MP2888=y
CONFIG_SENSORS_MP2975=y
CONFIG_SENSORS_MP5023=m
CONFIG_SENSORS_PIM4328=m
CONFIG_SENSORS_PLI1209BC=y
# CONFIG_SENSORS_PLI1209BC_REGULATOR is not set
CONFIG_SENSORS_PM6764TR=y
# CONFIG_SENSORS_PXE1610 is not set
CONFIG_SENSORS_Q54SJ108A2=m
CONFIG_SENSORS_STPDDC60=y
CONFIG_SENSORS_TPS40422=m
CONFIG_SENSORS_TPS53679=y
# CONFIG_SENSORS_UCD9000 is not set
# CONFIG_SENSORS_UCD9200 is not set
# CONFIG_SENSORS_XDPE152 is not set
# CONFIG_SENSORS_XDPE122 is not set
# CONFIG_SENSORS_ZL6100 is not set
CONFIG_SENSORS_PWM_FAN=m
CONFIG_SENSORS_RASPBERRYPI_HWMON=m
CONFIG_SENSORS_SL28CPLD=y
CONFIG_SENSORS_SBTSI=m
# CONFIG_SENSORS_SBRMI is not set
# CONFIG_SENSORS_SHT15 is not set
CONFIG_SENSORS_SHT21=y
CONFIG_SENSORS_SHT3x=m
# CONFIG_SENSORS_SHT4x is not set
CONFIG_SENSORS_SHTC1=y
# CONFIG_SENSORS_SIS5595 is not set
CONFIG_SENSORS_SY7636A=m
CONFIG_SENSORS_DME1737=m
CONFIG_SENSORS_EMC1403=y
CONFIG_SENSORS_EMC2103=m
CONFIG_SENSORS_EMC6W201=m
CONFIG_SENSORS_SMSC47M1=y
CONFIG_SENSORS_SMSC47M192=m
CONFIG_SENSORS_SMSC47B397=m
CONFIG_SENSORS_SCH56XX_COMMON=m
# CONFIG_SENSORS_SCH5627 is not set
CONFIG_SENSORS_SCH5636=m
CONFIG_SENSORS_STTS751=m
CONFIG_SENSORS_SMM665=y
# CONFIG_SENSORS_ADC128D818 is not set
# CONFIG_SENSORS_ADS7828 is not set
CONFIG_SENSORS_AMC6821=m
CONFIG_SENSORS_INA209=y
# CONFIG_SENSORS_INA2XX is not set
# CONFIG_SENSORS_INA238 is not set
# CONFIG_SENSORS_INA3221 is not set
CONFIG_SENSORS_TC74=m
CONFIG_SENSORS_THMC50=y
# CONFIG_SENSORS_TMP102 is not set
# CONFIG_SENSORS_TMP103 is not set
CONFIG_SENSORS_TMP108=m
CONFIG_SENSORS_TMP401=y
CONFIG_SENSORS_TMP421=y
# CONFIG_SENSORS_TMP464 is not set
CONFIG_SENSORS_TMP513=y
# CONFIG_SENSORS_VEXPRESS is not set
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_VT1211=y
CONFIG_SENSORS_VT8231=y
CONFIG_SENSORS_W83773G=y
CONFIG_SENSORS_W83781D=y
CONFIG_SENSORS_W83791D=y
# CONFIG_SENSORS_W83792D is not set
CONFIG_SENSORS_W83793=m
# CONFIG_SENSORS_W83795 is not set
# CONFIG_SENSORS_W83L785TS is not set
# CONFIG_SENSORS_W83L786NG is not set
CONFIG_SENSORS_W83627HF=m
CONFIG_SENSORS_W83627EHF=y
CONFIG_SENSORS_WM831X=m
# CONFIG_THERMAL is not set
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
CONFIG_WATCHDOG_OPEN_TIMEOUT=0
CONFIG_WATCHDOG_SYSFS=y
CONFIG_WATCHDOG_HRTIMER_PRETIMEOUT=y

#
# Watchdog Pretimeout Governors
#
CONFIG_WATCHDOG_PRETIMEOUT_GOV=y
CONFIG_WATCHDOG_PRETIMEOUT_GOV_SEL=m
CONFIG_WATCHDOG_PRETIMEOUT_GOV_NOOP=m
CONFIG_WATCHDOG_PRETIMEOUT_GOV_PANIC=y
# CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_NOOP is not set
CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_PANIC=y

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=y
# CONFIG_SOFT_WATCHDOG_PRETIMEOUT is not set
# CONFIG_DA9052_WATCHDOG is not set
CONFIG_DA9055_WATCHDOG=m
# CONFIG_DA9063_WATCHDOG is not set
CONFIG_DA9062_WATCHDOG=m
# CONFIG_GPIO_WATCHDOG is not set
CONFIG_MENF21BMC_WATCHDOG=m
# CONFIG_MENZ069_WATCHDOG is not set
CONFIG_WM831X_WATCHDOG=y
# CONFIG_XILINX_WATCHDOG is not set
CONFIG_ZIIRAVE_WATCHDOG=y
# CONFIG_SL28CPLD_WATCHDOG is not set
# CONFIG_ARM_SP805_WATCHDOG is not set
CONFIG_ARMADA_37XX_WATCHDOG=m
CONFIG_ASM9260_WATCHDOG=m
# CONFIG_AT91RM9200_WATCHDOG is not set
CONFIG_AT91SAM9X_WATCHDOG=y
# CONFIG_SAMA5D4_WATCHDOG is not set
CONFIG_CADENCE_WATCHDOG=y
CONFIG_977_WATCHDOG=y
CONFIG_FTWDT010_WATCHDOG=m
CONFIG_S3C2410_WATCHDOG=m
CONFIG_SA1100_WATCHDOG=m
# CONFIG_DW_WATCHDOG is not set
CONFIG_EP93XX_WATCHDOG=y
# CONFIG_OMAP_WATCHDOG is not set
CONFIG_PNX4008_WATCHDOG=y
# CONFIG_DAVINCI_WATCHDOG is not set
CONFIG_K3_RTI_WATCHDOG=m
# CONFIG_ORION_WATCHDOG is not set
# CONFIG_RN5T618_WATCHDOG is not set
# CONFIG_SUNXI_WATCHDOG is not set
CONFIG_NPCM7XX_WATCHDOG=m
CONFIG_TWL4030_WATCHDOG=m
# CONFIG_STMP3XXX_RTC_WATCHDOG is not set
CONFIG_TS4800_WATCHDOG=m
CONFIG_TS72XX_WATCHDOG=m
CONFIG_MAX63XX_WATCHDOG=m
# CONFIG_MAX77620_WATCHDOG is not set
CONFIG_IMX2_WDT=y
# CONFIG_IMX7ULP_WDT is not set
CONFIG_MOXART_WDT=y
CONFIG_ST_LPC_WATCHDOG=y
CONFIG_TEGRA_WATCHDOG=m
CONFIG_QCOM_WDT=m
CONFIG_MESON_GXBB_WATCHDOG=m
CONFIG_MESON_WATCHDOG=m
CONFIG_MEDIATEK_WATCHDOG=m
CONFIG_DIGICOLOR_WATCHDOG=y
CONFIG_LPC18XX_WATCHDOG=y
# CONFIG_RENESAS_WDT is not set
# CONFIG_RENESAS_RZAWDT is not set
CONFIG_RENESAS_RZN1WDT=m
CONFIG_RENESAS_RZG2LWDT=m
CONFIG_ASPEED_WATCHDOG=y
CONFIG_STPMIC1_WATCHDOG=m
CONFIG_UNIPHIER_WATCHDOG=y
# CONFIG_RTD119X_WATCHDOG is not set
CONFIG_REALTEK_OTTO_WDT=y
CONFIG_SPRD_WATCHDOG=m
CONFIG_VISCONTI_WATCHDOG=y
# CONFIG_MSC313E_WATCHDOG is not set
CONFIG_APPLE_WATCHDOG=m
# CONFIG_SUNPLUS_WATCHDOG is not set
CONFIG_ALIM7101_WDT=m
CONFIG_SC520_WDT=y
# CONFIG_I6300ESB_WDT is not set
CONFIG_KEMPLD_WDT=m
# CONFIG_RDC321X_WDT is not set
CONFIG_ATH79_WDT=m
CONFIG_BCM47XX_WDT=m
CONFIG_BCM2835_WDT=y
# CONFIG_BCM_KONA_WDT is not set
CONFIG_BCM7038_WDT=y
CONFIG_IMGPDC_WDT=y
CONFIG_MPC5200_WDT=y
CONFIG_MEN_A21_WDT=y
# CONFIG_UML_WATCHDOG is not set

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=m
# CONFIG_WDTPCI is not set

#
# USB-based Watchdog Cards
#
# CONFIG_USBPCWATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=y
CONFIG_SSB_SPROM=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
CONFIG_SSB_PCIHOST=y
# CONFIG_SSB_HOST_SOC is not set
CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
# CONFIG_SSB_DRIVER_PCICORE is not set
CONFIG_SSB_DRIVER_GPIO=y
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=y
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
# CONFIG_BCMA_HOST_PCI is not set
# CONFIG_BCMA_HOST_SOC is not set
CONFIG_BCMA_DRIVER_PCI=y
CONFIG_BCMA_DRIVER_MIPS=y
CONFIG_BCMA_PFLASH=y
CONFIG_BCMA_NFLASH=y
CONFIG_BCMA_DRIVER_GMAC_CMN=y
CONFIG_BCMA_DRIVER_GPIO=y
CONFIG_BCMA_DEBUG=y

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_ACT8945A is not set
CONFIG_MFD_SUN4I_GPADC=m
# CONFIG_MFD_AS3711 is not set
CONFIG_MFD_AS3722=y
# CONFIG_PMIC_ADP5520 is not set
CONFIG_MFD_AAT2870_CORE=y
CONFIG_MFD_AT91_USART=m
# CONFIG_MFD_ATMEL_FLEXCOM is not set
CONFIG_MFD_ATMEL_HLCDC=y
CONFIG_MFD_ATMEL_SMC=y
# CONFIG_MFD_BCM590XX is not set
CONFIG_MFD_BD9571MWV=y
CONFIG_MFD_AC100=m
CONFIG_MFD_AXP20X=m
CONFIG_MFD_AXP20X_I2C=m
CONFIG_MFD_AXP20X_RSB=m
CONFIG_MFD_MADERA=m
CONFIG_MFD_MADERA_I2C=m
CONFIG_MFD_CS47L15=y
# CONFIG_MFD_CS47L35 is not set
# CONFIG_MFD_CS47L85 is not set
CONFIG_MFD_CS47L90=y
# CONFIG_MFD_CS47L92 is not set
CONFIG_MFD_ASIC3=y
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_I2C is not set
CONFIG_MFD_DA9055=y
CONFIG_MFD_DA9062=m
CONFIG_MFD_DA9063=m
CONFIG_MFD_DA9150=m
CONFIG_MFD_DLN2=m
CONFIG_MFD_ENE_KB3930=y
# CONFIG_MFD_EXYNOS_LPASS is not set
CONFIG_MFD_GATEWORKS_GSC=m
CONFIG_MFD_MC13XXX=y
CONFIG_MFD_MC13XXX_I2C=y
CONFIG_MFD_MP2629=m
CONFIG_MFD_MXS_LRADC=m
# CONFIG_MFD_MX25_TSADC is not set
CONFIG_MFD_HI6421_PMIC=m
CONFIG_MFD_HI655X_PMIC=y
# CONFIG_HTC_PASIC3 is not set
# CONFIG_HTC_I2CPLD is not set
CONFIG_LPC_ICH=y
CONFIG_LPC_SCH=m
CONFIG_MFD_IQS62X=y
CONFIG_MFD_JANZ_CMODIO=y
CONFIG_MFD_KEMPLD=y
CONFIG_MFD_88PM800=y
CONFIG_MFD_88PM805=m
# CONFIG_MFD_88PM860X is not set
CONFIG_MFD_MAX14577=y
CONFIG_MFD_MAX77620=y
# CONFIG_MFD_MAX77650 is not set
CONFIG_MFD_MAX77686=y
CONFIG_MFD_MAX77693=y
CONFIG_MFD_MAX77714=y
# CONFIG_MFD_MAX77843 is not set
CONFIG_MFD_MAX8907=m
# CONFIG_MFD_MAX8925 is not set
CONFIG_MFD_MAX8997=y
# CONFIG_MFD_MAX8998 is not set
CONFIG_MFD_MT6360=y
# CONFIG_MFD_MT6397 is not set
CONFIG_MFD_MENF21BMC=y
# CONFIG_MFD_VIPERBOARD is not set
# CONFIG_MFD_NTXEC is not set
# CONFIG_MFD_RETU is not set
CONFIG_MFD_PCF50633=y
CONFIG_PCF50633_ADC=m
# CONFIG_PCF50633_GPIO is not set
CONFIG_UCB1400_CORE=m
CONFIG_MFD_PM8XXX=y
# CONFIG_MFD_RDC321X is not set
CONFIG_MFD_RT4831=m
CONFIG_MFD_RT5033=m
CONFIG_MFD_RC5T583=y
# CONFIG_MFD_RK808 is not set
CONFIG_MFD_RN5T618=y
CONFIG_MFD_SEC_CORE=y
# CONFIG_MFD_SI476X_CORE is not set
CONFIG_MFD_SIMPLE_MFD_I2C=y
CONFIG_MFD_SL28CPLD=y
# CONFIG_MFD_SM501 is not set
# CONFIG_MFD_SKY81452 is not set
CONFIG_ABX500_CORE=y
CONFIG_MFD_STMPE=y

#
# STMicroelectronics STMPE Interface Drivers
#
# CONFIG_STMPE_I2C is not set
# end of STMicroelectronics STMPE Interface Drivers

CONFIG_MFD_SUN6I_PRCM=y
CONFIG_MFD_SYSCON=y
CONFIG_MFD_TI_AM335X_TSCADC=m
# CONFIG_MFD_LP3943 is not set
CONFIG_MFD_LP8788=y
CONFIG_MFD_TI_LMU=m
# CONFIG_MFD_PALMAS is not set
CONFIG_TPS6105X=m
CONFIG_TPS65010=m
CONFIG_TPS6507X=y
CONFIG_MFD_TPS65086=m
CONFIG_MFD_TPS65090=y
CONFIG_MFD_TPS65217=y
# CONFIG_MFD_TI_LP873X is not set
CONFIG_MFD_TI_LP87565=y
CONFIG_MFD_TPS65218=m
# CONFIG_MFD_TPS6586X is not set
CONFIG_MFD_TPS65910=y
CONFIG_MFD_TPS65912=m
CONFIG_MFD_TPS65912_I2C=m
CONFIG_TWL4030_CORE=y
# CONFIG_TWL4030_POWER is not set
CONFIG_MFD_TWL4030_AUDIO=y
# CONFIG_TWL6040_CORE is not set
CONFIG_MFD_WL1273_CORE=m
CONFIG_MFD_LM3533=y
# CONFIG_MFD_TIMBERDALE is not set
# CONFIG_MFD_TC3589X is not set
CONFIG_MFD_TMIO=y
# CONFIG_MFD_T7L66XB is not set
CONFIG_MFD_TC6387XB=y
# CONFIG_MFD_TC6393XB is not set
# CONFIG_MFD_TQMX86 is not set
CONFIG_MFD_VX855=m
# CONFIG_MFD_LOCHNAGAR is not set
CONFIG_MFD_ARIZONA=y
CONFIG_MFD_ARIZONA_I2C=y
CONFIG_MFD_CS47L24=y
# CONFIG_MFD_WM5102 is not set
CONFIG_MFD_WM5110=y
CONFIG_MFD_WM8997=y
CONFIG_MFD_WM8998=y
CONFIG_MFD_WM8400=y
CONFIG_MFD_WM831X=y
CONFIG_MFD_WM831X_I2C=y
# CONFIG_MFD_WM8350_I2C is not set
CONFIG_MFD_WM8994=m
CONFIG_MFD_STW481X=m
CONFIG_MFD_ROHM_BD718XX=y
# CONFIG_MFD_ROHM_BD71828 is not set
# CONFIG_MFD_ROHM_BD957XMUF is not set
CONFIG_MFD_STM32_LPTIMER=m
CONFIG_MFD_STM32_TIMERS=y
CONFIG_MFD_STPMIC1=y
CONFIG_MFD_STMFX=y
CONFIG_MFD_WCD934X=m
# CONFIG_MFD_ATC260X_I2C is not set
CONFIG_MFD_KHADAS_MCU=y
# CONFIG_MFD_ACER_A500_EC is not set
CONFIG_MFD_QCOM_PM8008=y
CONFIG_MFD_VEXPRESS_SYSREG=m
CONFIG_MFD_RSMU_I2C=m
# end of Multifunction device drivers

CONFIG_REGULATOR=y
CONFIG_REGULATOR_DEBUG=y
CONFIG_REGULATOR_FIXED_VOLTAGE=m
# CONFIG_REGULATOR_VIRTUAL_CONSUMER is not set
# CONFIG_REGULATOR_USERSPACE_CONSUMER is not set
CONFIG_REGULATOR_88PG86X=y
CONFIG_REGULATOR_88PM800=y
# CONFIG_REGULATOR_ACT8865 is not set
CONFIG_REGULATOR_AD5398=m
CONFIG_REGULATOR_ANATOP=m
# CONFIG_REGULATOR_AAT2870 is not set
CONFIG_REGULATOR_ARIZONA_LDO1=m
CONFIG_REGULATOR_ARIZONA_MICSUPP=m
CONFIG_REGULATOR_ARM_SCMI=m
CONFIG_REGULATOR_AS3722=y
CONFIG_REGULATOR_AXP20X=m
CONFIG_REGULATOR_BD718XX=y
CONFIG_REGULATOR_BD9571MWV=y
# CONFIG_REGULATOR_DA9055 is not set
CONFIG_REGULATOR_DA9062=m
CONFIG_REGULATOR_DA9063=m
CONFIG_REGULATOR_DA9121=y
CONFIG_REGULATOR_DA9210=m
CONFIG_REGULATOR_DA9211=y
# CONFIG_REGULATOR_FAN53555 is not set
CONFIG_REGULATOR_FAN53880=m
CONFIG_REGULATOR_GPIO=y
# CONFIG_REGULATOR_HI6421 is not set
# CONFIG_REGULATOR_HI6421V530 is not set
CONFIG_REGULATOR_HI655X=m
CONFIG_REGULATOR_ISL9305=m
CONFIG_REGULATOR_ISL6271A=y
CONFIG_REGULATOR_LM363X=m
CONFIG_REGULATOR_LP3971=y
# CONFIG_REGULATOR_LP3972 is not set
# CONFIG_REGULATOR_LP872X is not set
CONFIG_REGULATOR_LP8755=y
CONFIG_REGULATOR_LP87565=m
CONFIG_REGULATOR_LP8788=y
CONFIG_REGULATOR_LTC3589=y
CONFIG_REGULATOR_LTC3676=m
CONFIG_REGULATOR_MAX14577=m
CONFIG_REGULATOR_MAX1586=y
CONFIG_REGULATOR_MAX77620=y
CONFIG_REGULATOR_MAX77650=y
CONFIG_REGULATOR_MAX8649=y
CONFIG_REGULATOR_MAX8660=y
CONFIG_REGULATOR_MAX8893=y
CONFIG_REGULATOR_MAX8907=y
CONFIG_REGULATOR_MAX8952=y
CONFIG_REGULATOR_MAX8997=m
CONFIG_REGULATOR_MAX20086=y
CONFIG_REGULATOR_MAX77686=y
CONFIG_REGULATOR_MAX77693=m
CONFIG_REGULATOR_MAX77802=y
CONFIG_REGULATOR_MAX77826=m
# CONFIG_REGULATOR_MC13783 is not set
# CONFIG_REGULATOR_MC13892 is not set
# CONFIG_REGULATOR_MCP16502 is not set
# CONFIG_REGULATOR_MP5416 is not set
CONFIG_REGULATOR_MP8859=m
CONFIG_REGULATOR_MP886X=y
# CONFIG_REGULATOR_MPQ7920 is not set
# CONFIG_REGULATOR_MT6311 is not set
CONFIG_REGULATOR_MT6360=y
CONFIG_REGULATOR_PBIAS=m
CONFIG_REGULATOR_PCA9450=y
CONFIG_REGULATOR_PCF50633=m
CONFIG_REGULATOR_PF8X00=y
# CONFIG_REGULATOR_PFUZE100 is not set
# CONFIG_REGULATOR_PV88060 is not set
CONFIG_REGULATOR_PV88080=y
CONFIG_REGULATOR_PV88090=m
CONFIG_REGULATOR_PWM=y
CONFIG_REGULATOR_QCOM_RPMH=m
CONFIG_REGULATOR_QCOM_SMD_RPM=m
# CONFIG_REGULATOR_QCOM_SPMI is not set
CONFIG_REGULATOR_QCOM_USB_VBUS=y
# CONFIG_REGULATOR_RASPBERRYPI_TOUCHSCREEN_ATTINY is not set
CONFIG_REGULATOR_RC5T583=m
# CONFIG_REGULATOR_RN5T618 is not set
CONFIG_REGULATOR_ROHM=y
CONFIG_REGULATOR_RT4801=m
CONFIG_REGULATOR_RT4831=m
# CONFIG_REGULATOR_RT5033 is not set
# CONFIG_REGULATOR_RT5190A is not set
CONFIG_REGULATOR_RT5759=m
CONFIG_REGULATOR_RT6160=y
CONFIG_REGULATOR_RT6245=m
CONFIG_REGULATOR_RTQ2134=m
CONFIG_REGULATOR_RTMV20=y
CONFIG_REGULATOR_RTQ6752=y
CONFIG_REGULATOR_S2MPA01=m
CONFIG_REGULATOR_S2MPS11=m
CONFIG_REGULATOR_S5M8767=y
# CONFIG_REGULATOR_SC2731 is not set
# CONFIG_REGULATOR_SLG51000 is not set
# CONFIG_REGULATOR_STM32_BOOSTER is not set
# CONFIG_REGULATOR_STM32_VREFBUF is not set
# CONFIG_REGULATOR_STM32_PWR is not set
CONFIG_REGULATOR_STPMIC1=m
# CONFIG_REGULATOR_TI_ABB is not set
CONFIG_REGULATOR_STW481X_VMMC=y
# CONFIG_REGULATOR_SY7636A is not set
CONFIG_REGULATOR_SY8106A=y
CONFIG_REGULATOR_SY8824X=m
CONFIG_REGULATOR_SY8827N=m
CONFIG_REGULATOR_TPS51632=y
# CONFIG_REGULATOR_TPS6105X is not set
CONFIG_REGULATOR_TPS62360=y
# CONFIG_REGULATOR_TPS6286X is not set
# CONFIG_REGULATOR_TPS65023 is not set
CONFIG_REGULATOR_TPS6507X=y
# CONFIG_REGULATOR_TPS65086 is not set
# CONFIG_REGULATOR_TPS65090 is not set
CONFIG_REGULATOR_TPS65132=m
CONFIG_REGULATOR_TPS65217=m
CONFIG_REGULATOR_TPS65218=m
# CONFIG_REGULATOR_TPS65910 is not set
CONFIG_REGULATOR_TPS65912=m
CONFIG_REGULATOR_TPS68470=y
# CONFIG_REGULATOR_TWL4030 is not set
CONFIG_REGULATOR_UNIPHIER=m
CONFIG_REGULATOR_VCTRL=y
CONFIG_REGULATOR_VEXPRESS=m
CONFIG_REGULATOR_WM831X=y
CONFIG_REGULATOR_WM8400=m
# CONFIG_REGULATOR_WM8994 is not set
CONFIG_REGULATOR_QCOM_LABIBB=y
CONFIG_RC_CORE=m
CONFIG_LIRC=y
# CONFIG_RC_MAP is not set
CONFIG_RC_DECODERS=y
CONFIG_IR_IMON_DECODER=m
# CONFIG_IR_JVC_DECODER is not set
# CONFIG_IR_MCE_KBD_DECODER is not set
CONFIG_IR_NEC_DECODER=m
CONFIG_IR_RC5_DECODER=m
# CONFIG_IR_RC6_DECODER is not set
CONFIG_IR_RCMM_DECODER=m
CONFIG_IR_SANYO_DECODER=m
CONFIG_IR_SHARP_DECODER=m
# CONFIG_IR_SONY_DECODER is not set
CONFIG_IR_XMP_DECODER=m
CONFIG_RC_DEVICES=y
# CONFIG_IR_ENE is not set
CONFIG_IR_FINTEK=m
# CONFIG_IR_GPIO_CIR is not set
# CONFIG_IR_GPIO_TX is not set
# CONFIG_IR_HIX5HD2 is not set
CONFIG_IR_IGORPLUGUSB=m
CONFIG_IR_IGUANA=m
# CONFIG_IR_IMON is not set
CONFIG_IR_IMON_RAW=m
# CONFIG_IR_ITE_CIR is not set
CONFIG_IR_MCEUSB=m
CONFIG_IR_MESON=m
CONFIG_IR_MESON_TX=m
CONFIG_IR_MTK=m
CONFIG_IR_NUVOTON=m
# CONFIG_IR_PWM_TX is not set
CONFIG_IR_REDRAT3=m
CONFIG_IR_RX51=m
# CONFIG_IR_SERIAL is not set
# CONFIG_IR_STREAMZAP is not set
CONFIG_IR_SUNXI=m
# CONFIG_IR_TOY is not set
CONFIG_IR_TTUSBIR=m
CONFIG_IR_WINBOND_CIR=m
CONFIG_RC_ATI_REMOTE=m
CONFIG_RC_LOOPBACK=m
CONFIG_RC_ST=m
CONFIG_RC_XBOX_DVD=m
CONFIG_IR_IMG=m
CONFIG_IR_IMG_RAW=y
# CONFIG_IR_IMG_HW is not set
CONFIG_CEC_CORE=y
CONFIG_CEC_NOTIFIER=y
CONFIG_CEC_PIN=y

#
# CEC support
#
# CONFIG_CEC_PIN_ERROR_INJ is not set
CONFIG_MEDIA_CEC_SUPPORT=y
# CONFIG_CEC_CH7322 is not set
CONFIG_CEC_MESON_AO=y
CONFIG_CEC_MESON_G12A_AO=y
CONFIG_CEC_GPIO=m
# CONFIG_CEC_SAMSUNG_S5P is not set
# CONFIG_CEC_STI is not set
CONFIG_CEC_STM32=m
# CONFIG_CEC_TEGRA is not set
# end of CEC support

# CONFIG_MEDIA_SUPPORT is not set

#
# Graphics support
#
CONFIG_HAVE_FB_ATMEL=y
CONFIG_TEGRA_HOST1X_CONTEXT_BUS=y
CONFIG_TEGRA_HOST1X=m
CONFIG_TEGRA_HOST1X_FIREWALL=y
CONFIG_IMX_IPUV3_CORE=y
# CONFIG_DRM is not set
CONFIG_DRM_DEBUG_MODESET_LOCK=y

#
# ARM devices
#
# end of ARM devices

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
CONFIG_FB_CFB_REV_PIXELS_IN_BYTE=y
CONFIG_FB_SYS_FILLRECT=y
CONFIG_FB_SYS_COPYAREA=y
CONFIG_FB_SYS_IMAGEBLIT=y
CONFIG_FB_FOREIGN_ENDIAN=y
# CONFIG_FB_BOTH_ENDIAN is not set
CONFIG_FB_BIG_ENDIAN=y
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
CONFIG_FB_PM2=m
CONFIG_FB_PM2_FIFO_DISCONNECT=y
# CONFIG_FB_ARMCLCD is not set
# CONFIG_FB_CLPS711X is not set
CONFIG_FB_IMX=y
CONFIG_FB_CYBER2000=y
# CONFIG_FB_CYBER2000_DDC is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_CONTROL is not set
CONFIG_FB_ASILIANT=y
CONFIG_FB_IMSTT=y
# CONFIG_FB_EFI is not set
CONFIG_FB_GBE=y
CONFIG_FB_GBE_MEM=4
CONFIG_FB_PVR2=y
# CONFIG_FB_OPENCORES is not set
CONFIG_FB_S1D13XXX=y
CONFIG_FB_ATMEL=m
# CONFIG_FB_NVIDIA is not set
CONFIG_FB_RIVA=m
# CONFIG_FB_RIVA_I2C is not set
CONFIG_FB_RIVA_DEBUG=y
# CONFIG_FB_RIVA_BACKLIGHT is not set
# CONFIG_FB_I740 is not set
CONFIG_FB_MATROX=m
# CONFIG_FB_MATROX_MILLENIUM is not set
# CONFIG_FB_MATROX_MYSTIQUE is not set
# CONFIG_FB_MATROX_G is not set
# CONFIG_FB_MATROX_I2C is not set
CONFIG_FB_RADEON=y
# CONFIG_FB_RADEON_I2C is not set
CONFIG_FB_RADEON_BACKLIGHT=y
# CONFIG_FB_RADEON_DEBUG is not set
CONFIG_FB_ATY128=m
# CONFIG_FB_ATY128_BACKLIGHT is not set
# CONFIG_FB_ATY is not set
CONFIG_FB_S3=m
# CONFIG_FB_S3_DDC is not set
CONFIG_FB_SAVAGE=y
CONFIG_FB_SAVAGE_I2C=y
CONFIG_FB_SAVAGE_ACCEL=y
# CONFIG_FB_SIS is not set
# CONFIG_FB_VIA is not set
CONFIG_FB_NEOMAGIC=y
CONFIG_FB_KYRO=m
CONFIG_FB_3DFX=y
CONFIG_FB_3DFX_ACCEL=y
# CONFIG_FB_3DFX_I2C is not set
CONFIG_FB_VOODOO1=m
CONFIG_FB_VT8623=y
CONFIG_FB_TRIDENT=y
CONFIG_FB_ARK=y
CONFIG_FB_PM3=y
CONFIG_FB_CARMINE=y
CONFIG_FB_CARMINE_DRAM_EVAL=y
# CONFIG_CARMINE_DRAM_CUSTOM is not set
CONFIG_FB_WM8505=y
# CONFIG_FB_WMT_GE_ROPS is not set
# CONFIG_FB_PXA168 is not set
CONFIG_FB_PXA=m
# CONFIG_FB_PXA_OVERLAY is not set
CONFIG_FB_PXA_SMARTPANEL=y
CONFIG_FB_PXA_PARAMETERS=y
CONFIG_PXA3XX_GCU=m
CONFIG_FB_W100=m
CONFIG_FB_SH_MOBILE_LCDC=m
# CONFIG_FB_TMIO is not set
# CONFIG_FB_S3C is not set
# CONFIG_FB_SMSCUFX is not set
CONFIG_FB_UDL=y
# CONFIG_FB_IBM_GXT4500 is not set
CONFIG_FB_GOLDFISH=y
CONFIG_FB_DA8XX=y
CONFIG_FB_VIRTUAL=y
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
# CONFIG_FB_BROADSHEET is not set
CONFIG_FB_SIMPLE=y
# CONFIG_FB_SSD1307 is not set
CONFIG_FB_SM712=m
CONFIG_FB_OMAP=y
CONFIG_FB_OMAP_LCDC_EXTERNAL=y
# CONFIG_FB_OMAP_LCDC_HWA742 is not set
CONFIG_FB_OMAP_MANUAL_UPDATE=y
CONFIG_FB_OMAP_DMA_TUNE=y
# CONFIG_FB_OMAP2 is not set
CONFIG_MMP_DISP=m
# CONFIG_MMP_DISP_CONTROLLER is not set
CONFIG_MMP_FB=m
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=y
CONFIG_LCD_PLATFORM=m
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_ATMEL_LCDC is not set
CONFIG_BACKLIGHT_KTD253=m
CONFIG_BACKLIGHT_LM3533=m
# CONFIG_BACKLIGHT_OMAP1 is not set
CONFIG_BACKLIGHT_PWM=y
CONFIG_BACKLIGHT_QCOM_WLED=m
CONFIG_BACKLIGHT_RT4831=m
CONFIG_BACKLIGHT_WM831X=m
# CONFIG_BACKLIGHT_ADP8860 is not set
# CONFIG_BACKLIGHT_ADP8870 is not set
CONFIG_BACKLIGHT_PCF50633=y
CONFIG_BACKLIGHT_AAT2870=m
# CONFIG_BACKLIGHT_LM3630A is not set
CONFIG_BACKLIGHT_LM3639=m
CONFIG_BACKLIGHT_LP855X=y
# CONFIG_BACKLIGHT_LP8788 is not set
CONFIG_BACKLIGHT_PANDORA=y
CONFIG_BACKLIGHT_TPS65217=y
CONFIG_BACKLIGHT_GPIO=y
# CONFIG_BACKLIGHT_LV5207LP is not set
CONFIG_BACKLIGHT_BD6107=m
CONFIG_BACKLIGHT_ARCXCNN=m
CONFIG_BACKLIGHT_LED=m
# end of Backlight & LCD device support

CONFIG_VGASTATE=y
CONFIG_VIDEOMODE_HELPERS=y
CONFIG_HDMI=y
# CONFIG_LOGO is not set
# end of Graphics support

CONFIG_SOUND=m
CONFIG_SOUND_OSS_CORE=y
CONFIG_SOUND_OSS_CORE_PRECLAIM=y
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_PCM_ELD=y
CONFIG_SND_PCM_IEC958=y
CONFIG_SND_DMAENGINE_PCM=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_COMPRESS_OFFLOAD=m
CONFIG_SND_JACK=y
CONFIG_SND_JACK_INPUT_DEV=y
CONFIG_SND_OSSEMUL=y
# CONFIG_SND_MIXER_OSS is not set
# CONFIG_SND_PCM_OSS is not set
# CONFIG_SND_PCM_TIMER is not set
CONFIG_SND_HRTIMER=m
CONFIG_SND_DYNAMIC_MINORS=y
CONFIG_SND_MAX_CARDS=32
CONFIG_SND_SUPPORT_OLD_API=y
# CONFIG_SND_PROC_FS is not set
CONFIG_SND_VERBOSE_PRINTK=y
# CONFIG_SND_DEBUG is not set
CONFIG_SND_VMASTER=y
CONFIG_SND_CTL_LED=m
# CONFIG_SND_SEQUENCER is not set
CONFIG_SND_MPU401_UART=m
CONFIG_SND_AC97_CODEC=m
CONFIG_SND_DRIVERS=y
CONFIG_SND_DUMMY=m
CONFIG_SND_ALOOP=m
CONFIG_SND_MTPAV=m
CONFIG_SND_MTS64=m
CONFIG_SND_SERIAL_U16550=m
CONFIG_SND_MPU401=m
CONFIG_SND_PORTMAN2X4=m
CONFIG_SND_AC97_POWER_SAVE=y
CONFIG_SND_AC97_POWER_SAVE_DEFAULT=0
# CONFIG_SND_PCI is not set

#
# HD-Audio
#
CONFIG_SND_HDA=m
CONFIG_SND_HDA_GENERIC_LEDS=y
# CONFIG_SND_HDA_HWDEP is not set
CONFIG_SND_HDA_RECONFIG=y
# CONFIG_SND_HDA_INPUT_BEEP is not set
CONFIG_SND_HDA_PATCH_LOADER=y
CONFIG_SND_HDA_CODEC_REALTEK=m
CONFIG_SND_HDA_CODEC_ANALOG=m
CONFIG_SND_HDA_CODEC_SIGMATEL=m
CONFIG_SND_HDA_CODEC_VIA=m
CONFIG_SND_HDA_CODEC_HDMI=m
CONFIG_SND_HDA_CODEC_CIRRUS=m
CONFIG_SND_HDA_CODEC_CS8409=m
CONFIG_SND_HDA_CODEC_CONEXANT=m
CONFIG_SND_HDA_CODEC_CA0110=m
# CONFIG_SND_HDA_CODEC_CA0132 is not set
# CONFIG_SND_HDA_CODEC_CMEDIA is not set
CONFIG_SND_HDA_CODEC_SI3054=m
CONFIG_SND_HDA_GENERIC=m
CONFIG_SND_HDA_POWER_SAVE_DEFAULT=0
# end of HD-Audio

CONFIG_SND_HDA_CORE=m
CONFIG_SND_HDA_DSP_LOADER=y
CONFIG_SND_HDA_EXT_CORE=m
CONFIG_SND_HDA_PREALLOC_SIZE=64
CONFIG_SND_INTEL_DSP_CONFIG=m
CONFIG_SND_ARM=y
CONFIG_SND_ARMAACI=m
# CONFIG_SND_PXA2XX_AC97 is not set
CONFIG_SND_PXA2XX_LIB=m

#
# Atmel devices (AT91)
#
CONFIG_SND_ATMEL_AC97C=m
# end of Atmel devices (AT91)

# CONFIG_SND_USB is not set
CONFIG_SND_SOC=m
CONFIG_SND_SOC_AC97_BUS=y
CONFIG_SND_SOC_GENERIC_DMAENGINE_PCM=y
CONFIG_SND_SOC_COMPRESS=y
CONFIG_SND_SOC_TOPOLOGY=y
# CONFIG_SND_SOC_TOPOLOGY_KUNIT_TEST is not set
CONFIG_SND_SOC_UTILS_KUNIT_TEST=m
CONFIG_SND_SOC_ADI=m
CONFIG_SND_SOC_ADI_AXI_I2S=m
CONFIG_SND_SOC_ADI_AXI_SPDIF=m
CONFIG_SND_SOC_AMD_ACP=m
# CONFIG_SND_SOC_AMD_CZ_RT5645_MACH is not set
CONFIG_SND_AMD_ACP_CONFIG=m
CONFIG_SND_ATMEL_SOC=m
CONFIG_SND_ATMEL_SOC_CLASSD=m
CONFIG_SND_ATMEL_SOC_PDMIC=m
CONFIG_SND_ATMEL_SOC_I2S=m
CONFIG_SND_SOC_MIKROE_PROTO=m
CONFIG_SND_MCHP_SOC_I2S_MCC=m
# CONFIG_SND_MCHP_SOC_SPDIFTX is not set
CONFIG_SND_MCHP_SOC_SPDIFRX=m
# CONFIG_SND_MCHP_SOC_PDMC is not set
# CONFIG_SND_BCM2835_SOC_I2S is not set
# CONFIG_SND_SOC_CYGNUS is not set
CONFIG_SND_BCM63XX_I2S_WHISTLER=m
CONFIG_SND_EP93XX_SOC=m
CONFIG_SND_DESIGNWARE_I2S=m
CONFIG_SND_DESIGNWARE_PCM=y

#
# SoC Audio for Freescale CPUs
#

#
# Common SoC Audio options for Freescale CPUs:
#
CONFIG_SND_SOC_FSL_ASRC=m
CONFIG_SND_SOC_FSL_SAI=m
CONFIG_SND_SOC_FSL_MQS=m
# CONFIG_SND_SOC_FSL_AUDMIX is not set
CONFIG_SND_SOC_FSL_SSI=m
CONFIG_SND_SOC_FSL_SPDIF=m
CONFIG_SND_SOC_FSL_ESAI=m
CONFIG_SND_SOC_FSL_MICFIL=m
CONFIG_SND_SOC_FSL_EASRC=m
CONFIG_SND_SOC_FSL_XCVR=m
CONFIG_SND_SOC_FSL_AUD2HTX=m
# CONFIG_SND_SOC_FSL_RPMSG is not set
CONFIG_SND_SOC_IMX_PCM_DMA=m
CONFIG_SND_SOC_IMX_AUDMUX=m
CONFIG_SND_IMX_SOC=m

#
# SoC Audio support for Freescale i.MX boards:
#
# CONFIG_SND_SOC_IMX_ES8328 is not set
CONFIG_SND_SOC_IMX_SGTL5000=m
CONFIG_SND_SOC_IMX_SPDIF=m
# CONFIG_SND_SOC_FSL_ASOC_CARD is not set
# CONFIG_SND_SOC_IMX_AUDMIX is not set
# CONFIG_SND_SOC_IMX_HDMI is not set
# CONFIG_SND_SOC_IMX_RPMSG is not set
CONFIG_SND_SOC_IMX_CARD=m
# end of SoC Audio for Freescale CPUs

CONFIG_SND_I2S_HI6210_I2S=m
CONFIG_SND_JZ4740_SOC_I2S=m
# CONFIG_SND_KIRKWOOD_SOC is not set
# CONFIG_SND_SOC_IMG is not set
CONFIG_SND_SOC_INTEL_SST_TOPLEVEL=y
CONFIG_SND_SOC_INTEL_KEEMBAY=m
CONFIG_SND_SOC_INTEL_AVS=m
CONFIG_SND_SOC_INTEL_MACH=y
# CONFIG_SND_SOC_INTEL_USER_FRIENDLY_LONG_NAMES is not set
CONFIG_SND_SOC_MEDIATEK=m
CONFIG_SND_SOC_MTK_BTCVSD=m
CONFIG_SND_SOC_MT8195=m

#
# ASoC support for Amlogic platforms
#
# CONFIG_SND_MESON_AIU is not set
CONFIG_SND_MESON_AXG_FIFO=m
CONFIG_SND_MESON_AXG_FRDDR=m
CONFIG_SND_MESON_AXG_TODDR=m
CONFIG_SND_MESON_AXG_TDM_FORMATTER=m
CONFIG_SND_MESON_AXG_TDM_INTERFACE=m
CONFIG_SND_MESON_AXG_TDMIN=m
CONFIG_SND_MESON_AXG_TDMOUT=m
CONFIG_SND_MESON_AXG_SOUND_CARD=m
CONFIG_SND_MESON_AXG_SPDIFOUT=m
# CONFIG_SND_MESON_AXG_SPDIFIN is not set
CONFIG_SND_MESON_AXG_PDM=m
CONFIG_SND_MESON_CARD_UTILS=m
CONFIG_SND_MESON_CODEC_GLUE=m
CONFIG_SND_MESON_GX_SOUND_CARD=m
CONFIG_SND_MESON_G12A_TOACODEC=m
CONFIG_SND_MESON_G12A_TOHDMITX=m
CONFIG_SND_SOC_MESON_T9015=m
# end of ASoC support for Amlogic platforms

CONFIG_SND_MXS_SOC=m
CONFIG_SND_SOC_MXS_SGTL5000=m
CONFIG_SND_PXA2XX_SOC=m
CONFIG_SND_PXA_SOC_SSP=m
CONFIG_SND_MMP_SOC_SSPA=m
CONFIG_SND_PXA910_SOC=m
CONFIG_SND_SOC_QCOM=m
CONFIG_SND_SOC_LPASS_CPU=m
CONFIG_SND_SOC_LPASS_HDMI=m
CONFIG_SND_SOC_LPASS_PLATFORM=m
CONFIG_SND_SOC_LPASS_APQ8016=m
CONFIG_SND_SOC_LPASS_SC7180=m
# CONFIG_SND_SOC_STORM is not set
CONFIG_SND_SOC_APQ8016_SBC=m
CONFIG_SND_SOC_QCOM_COMMON=m
CONFIG_SND_SOC_SC7180=m
# CONFIG_SND_SOC_ROCKCHIP is not set
CONFIG_SND_SOC_SAMSUNG=m
CONFIG_SND_SAMSUNG_PCM=m
# CONFIG_SND_SAMSUNG_SPDIF is not set
CONFIG_SND_SAMSUNG_I2S=m
# CONFIG_SND_SOC_SAMSUNG_SMDK_WM8580 is not set
# CONFIG_SND_SOC_SAMSUNG_SMDK_WM8994 is not set
CONFIG_SND_SOC_SMARTQ=m
# CONFIG_SND_SOC_SAMSUNG_SMDK_SPDIF is not set
CONFIG_SND_SOC_SMDK_WM8994_PCM=m
CONFIG_SND_SOC_TOBERMORY=m
# CONFIG_SND_SOC_LOWLAND is not set
CONFIG_SND_SOC_LITTLEMILL=m
CONFIG_SND_SOC_SNOW=m
CONFIG_SND_SOC_ODROID=m
CONFIG_SND_SOC_ARNDALE=m
CONFIG_SND_SOC_SAMSUNG_ARIES_WM8994=m
CONFIG_SND_SOC_SAMSUNG_MIDAS_WM1811=m

#
# SoC Audio support for Renesas SoCs
#
CONFIG_SND_SOC_SH4_FSI=m
CONFIG_SND_SOC_RCAR=m
# CONFIG_SND_SOC_RZ is not set
# end of SoC Audio support for Renesas SoCs

CONFIG_SND_SOC_SOF_TOPLEVEL=y
CONFIG_SND_SOC_SOF_PCI=m
CONFIG_SND_SOC_SOF_ACPI=m
CONFIG_SND_SOC_SOF_OF=m
CONFIG_SND_SOC_SOF_AMD_TOPLEVEL=m
# CONFIG_SND_SOC_SOF_AMD_RENOIR is not set
# CONFIG_SND_SOC_SOF_IMX_TOPLEVEL is not set
# CONFIG_SND_SOC_SOF_INTEL_TOPLEVEL is not set
CONFIG_SND_SOC_SOF_MTK_TOPLEVEL=y
CONFIG_SND_SOC_SPRD=m
CONFIG_SND_SOC_SPRD_MCDT=m
# CONFIG_SND_SOC_STI is not set

#
# STMicroelectronics STM32 SOC audio support
#
CONFIG_SND_SOC_STM32_SAI=m
CONFIG_SND_SOC_STM32_I2S=m
CONFIG_SND_SOC_STM32_SPDIFRX=m
# CONFIG_SND_SOC_STM32_DFSDM is not set
# end of STMicroelectronics STM32 SOC audio support

#
# Allwinner SoC Audio support
#
# CONFIG_SND_SUN4I_CODEC is not set
CONFIG_SND_SUN8I_CODEC=m
CONFIG_SND_SUN8I_CODEC_ANALOG=m
CONFIG_SND_SUN50I_CODEC_ANALOG=m
# CONFIG_SND_SUN4I_I2S is not set
CONFIG_SND_SUN4I_SPDIF=m
CONFIG_SND_SUN8I_ADDA_PR_REGMAP=m
# end of Allwinner SoC Audio support

CONFIG_SND_SOC_TEGRA=m
CONFIG_SND_SOC_TEGRA20_AC97=m
CONFIG_SND_SOC_TEGRA20_DAS=m
CONFIG_SND_SOC_TEGRA20_I2S=m
CONFIG_SND_SOC_TEGRA20_SPDIF=m
CONFIG_SND_SOC_TEGRA30_AHUB=m
# CONFIG_SND_SOC_TEGRA30_I2S is not set
CONFIG_SND_SOC_TEGRA210_AHUB=m
CONFIG_SND_SOC_TEGRA210_DMIC=m
# CONFIG_SND_SOC_TEGRA210_I2S is not set
CONFIG_SND_SOC_TEGRA186_ASRC=m
CONFIG_SND_SOC_TEGRA186_DSPK=m
# CONFIG_SND_SOC_TEGRA210_ADMAIF is not set
CONFIG_SND_SOC_TEGRA210_MVC=m
CONFIG_SND_SOC_TEGRA210_SFC=m
CONFIG_SND_SOC_TEGRA210_AMX=m
CONFIG_SND_SOC_TEGRA210_ADX=m
# CONFIG_SND_SOC_TEGRA210_MIXER is not set
# CONFIG_SND_SOC_TEGRA_AUDIO_GRAPH_CARD is not set
CONFIG_SND_SOC_TEGRA_MACHINE_DRV=m
CONFIG_SND_SOC_TEGRA_RT5640=m
# CONFIG_SND_SOC_TEGRA_WM8753 is not set
CONFIG_SND_SOC_TEGRA_WM8903=m
CONFIG_SND_SOC_TEGRA_WM9712=m
CONFIG_SND_SOC_TEGRA_TRIMSLICE=m
CONFIG_SND_SOC_TEGRA_ALC5632=m
CONFIG_SND_SOC_TEGRA_MAX98090=m
# CONFIG_SND_SOC_TEGRA_RT5677 is not set
CONFIG_SND_SOC_TEGRA_SGTL5000=m

#
# Audio support for Texas Instruments SoCs
#
CONFIG_SND_SOC_TI_EDMA_PCM=m
CONFIG_SND_SOC_TI_SDMA_PCM=m
CONFIG_SND_SOC_TI_UDMA_PCM=m

#
# Texas Instruments DAI support for:
#
# CONFIG_SND_SOC_DAVINCI_ASP is not set
CONFIG_SND_SOC_DAVINCI_MCASP=m
# CONFIG_SND_SOC_DAVINCI_VCIF is not set
CONFIG_SND_SOC_OMAP_DMIC=m
CONFIG_SND_SOC_OMAP_MCBSP=m
CONFIG_SND_SOC_OMAP_MCPDM=m

#
# Audio support for boards with Texas Instruments SoCs
#
# CONFIG_SND_SOC_OMAP3_TWL4030 is not set
# CONFIG_SND_SOC_OMAP_HDMI is not set
CONFIG_SND_SOC_DAVINCI_EVM=m
CONFIG_SND_SOC_J721E_EVM=m
# end of Audio support for Texas Instruments SoCs

CONFIG_SND_SOC_UNIPHIER=m
CONFIG_SND_SOC_UNIPHIER_AIO=m
# CONFIG_SND_SOC_UNIPHIER_LD11 is not set
CONFIG_SND_SOC_UNIPHIER_PXS2=m
# CONFIG_SND_SOC_UNIPHIER_EVEA_CODEC is not set
CONFIG_SND_SOC_XILINX_I2S=m
# CONFIG_SND_SOC_XILINX_AUDIO_FORMATTER is not set
# CONFIG_SND_SOC_XILINX_SPDIF is not set
CONFIG_SND_SOC_XTFPGA_I2S=m
CONFIG_SND_SOC_I2C_AND_SPI=m

#
# CODEC drivers
#
# CONFIG_SND_SOC_ALL_CODECS is not set
CONFIG_SND_SOC_WM_HUBS=m
CONFIG_SND_SOC_WM_ADSP=m
CONFIG_SND_SOC_AC97_CODEC=m
# CONFIG_SND_SOC_ADAU1372_I2C is not set
# CONFIG_SND_SOC_ADAU1701 is not set
# CONFIG_SND_SOC_ADAU1761_I2C is not set
CONFIG_SND_SOC_ADAU7002=m
CONFIG_SND_SOC_ADAU7118=m
CONFIG_SND_SOC_ADAU7118_HW=m
CONFIG_SND_SOC_ADAU7118_I2C=m
CONFIG_SND_SOC_AK4118=m
CONFIG_SND_SOC_AK4375=m
CONFIG_SND_SOC_AK4458=m
CONFIG_SND_SOC_AK4554=m
CONFIG_SND_SOC_AK4613=m
# CONFIG_SND_SOC_AK4642 is not set
CONFIG_SND_SOC_AK5386=m
CONFIG_SND_SOC_AK5558=m
# CONFIG_SND_SOC_ALC5623 is not set
CONFIG_SND_SOC_ALC5632=m
# CONFIG_SND_SOC_AW8738 is not set
CONFIG_SND_SOC_BD28623=m
CONFIG_SND_SOC_BT_SCO=m
CONFIG_SND_SOC_CS35L32=m
# CONFIG_SND_SOC_CS35L33 is not set
# CONFIG_SND_SOC_CS35L34 is not set
CONFIG_SND_SOC_CS35L35=m
CONFIG_SND_SOC_CS35L36=m
CONFIG_SND_SOC_CS35L41_LIB=m
CONFIG_SND_SOC_CS35L41=m
CONFIG_SND_SOC_CS35L41_I2C=m
CONFIG_SND_SOC_CS35L45_TABLES=m
CONFIG_SND_SOC_CS35L45=m
CONFIG_SND_SOC_CS35L45_I2C=m
CONFIG_SND_SOC_CS42L42=m
CONFIG_SND_SOC_CS42L51=m
CONFIG_SND_SOC_CS42L51_I2C=m
CONFIG_SND_SOC_CS42L52=m
CONFIG_SND_SOC_CS42L56=m
CONFIG_SND_SOC_CS42L73=m
CONFIG_SND_SOC_CS4234=m
CONFIG_SND_SOC_CS4265=m
CONFIG_SND_SOC_CS4270=m
# CONFIG_SND_SOC_CS4271_I2C is not set
# CONFIG_SND_SOC_CS42XX8_I2C is not set
CONFIG_SND_SOC_CS43130=m
CONFIG_SND_SOC_CS4341=m
CONFIG_SND_SOC_CS4349=m
# CONFIG_SND_SOC_CS53L30 is not set
CONFIG_SND_SOC_CX2072X=m
# CONFIG_SND_SOC_JZ4740_CODEC is not set
CONFIG_SND_SOC_JZ4725B_CODEC=m
CONFIG_SND_SOC_JZ4760_CODEC=m
# CONFIG_SND_SOC_JZ4770_CODEC is not set
# CONFIG_SND_SOC_DA7213 is not set
# CONFIG_SND_SOC_DMIC is not set
CONFIG_SND_SOC_HDMI_CODEC=m
CONFIG_SND_SOC_ES7134=m
CONFIG_SND_SOC_ES7241=m
# CONFIG_SND_SOC_ES8316 is not set
CONFIG_SND_SOC_ES8328=m
CONFIG_SND_SOC_ES8328_I2C=m
CONFIG_SND_SOC_GTM601=m
# CONFIG_SND_SOC_ICS43432 is not set
# CONFIG_SND_SOC_INNO_RK3036 is not set
CONFIG_SND_SOC_MAX98088=m
CONFIG_SND_SOC_MAX98090=m
CONFIG_SND_SOC_MAX98095=m
CONFIG_SND_SOC_MAX98357A=m
CONFIG_SND_SOC_MAX98504=m
CONFIG_SND_SOC_MAX9867=m
CONFIG_SND_SOC_MAX98927=m
# CONFIG_SND_SOC_MAX98520 is not set
CONFIG_SND_SOC_MAX98373=m
CONFIG_SND_SOC_MAX98373_I2C=m
# CONFIG_SND_SOC_MAX98390 is not set
# CONFIG_SND_SOC_MAX98396 is not set
# CONFIG_SND_SOC_MAX9860 is not set
# CONFIG_SND_SOC_MSM8916_WCD_ANALOG is not set
# CONFIG_SND_SOC_MSM8916_WCD_DIGITAL is not set
CONFIG_SND_SOC_PCM1681=m
# CONFIG_SND_SOC_PCM1789_I2C is not set
CONFIG_SND_SOC_PCM179X=m
CONFIG_SND_SOC_PCM179X_I2C=m
CONFIG_SND_SOC_PCM186X=m
CONFIG_SND_SOC_PCM186X_I2C=m
CONFIG_SND_SOC_PCM3060=m
CONFIG_SND_SOC_PCM3060_I2C=m
CONFIG_SND_SOC_PCM3168A=m
CONFIG_SND_SOC_PCM3168A_I2C=m
CONFIG_SND_SOC_PCM5102A=m
# CONFIG_SND_SOC_PCM512x_I2C is not set
CONFIG_SND_SOC_RK3328=m
CONFIG_SND_SOC_RL6231=m
# CONFIG_SND_SOC_RT5616 is not set
CONFIG_SND_SOC_RT5631=m
CONFIG_SND_SOC_RT5640=m
# CONFIG_SND_SOC_RT5659 is not set
CONFIG_SND_SOC_RT5682=m
CONFIG_SND_SOC_RT5682_I2C=m
CONFIG_SND_SOC_RT5682S=m
CONFIG_SND_SOC_RT9120=m
CONFIG_SND_SOC_SGTL5000=m
CONFIG_SND_SOC_SIMPLE_AMPLIFIER=m
CONFIG_SND_SOC_SIMPLE_MUX=m
CONFIG_SND_SOC_SPDIF=m
CONFIG_SND_SOC_SSM2305=m
# CONFIG_SND_SOC_SSM2518 is not set
CONFIG_SND_SOC_SSM2602=m
CONFIG_SND_SOC_SSM2602_I2C=m
CONFIG_SND_SOC_SSM4567=m
CONFIG_SND_SOC_STA32X=m
# CONFIG_SND_SOC_STA350 is not set
CONFIG_SND_SOC_STI_SAS=m
CONFIG_SND_SOC_TAS2552=m
# CONFIG_SND_SOC_TAS2562 is not set
# CONFIG_SND_SOC_TAS2764 is not set
CONFIG_SND_SOC_TAS2770=m
CONFIG_SND_SOC_TAS5086=m
CONFIG_SND_SOC_TAS571X=m
CONFIG_SND_SOC_TAS5720=m
CONFIG_SND_SOC_TAS5805M=m
CONFIG_SND_SOC_TAS6424=m
CONFIG_SND_SOC_TDA7419=m
CONFIG_SND_SOC_TFA9879=m
CONFIG_SND_SOC_TFA989X=m
CONFIG_SND_SOC_TLV320ADC3XXX=m
CONFIG_SND_SOC_TLV320AIC23=m
CONFIG_SND_SOC_TLV320AIC23_I2C=m
CONFIG_SND_SOC_TLV320AIC31XX=m
CONFIG_SND_SOC_TLV320AIC32X4=m
CONFIG_SND_SOC_TLV320AIC32X4_I2C=m
CONFIG_SND_SOC_TLV320AIC3X=m
# CONFIG_SND_SOC_TLV320AIC3X_I2C is not set
# CONFIG_SND_SOC_TLV320ADCX140 is not set
# CONFIG_SND_SOC_TS3A227E is not set
CONFIG_SND_SOC_TSCS42XX=m
CONFIG_SND_SOC_TSCS454=m
CONFIG_SND_SOC_UDA1334=m
CONFIG_SND_SOC_WCD9335=m
# CONFIG_SND_SOC_WCD934X is not set
# CONFIG_SND_SOC_WM8510 is not set
CONFIG_SND_SOC_WM8523=m
CONFIG_SND_SOC_WM8524=m
CONFIG_SND_SOC_WM8580=m
# CONFIG_SND_SOC_WM8711 is not set
# CONFIG_SND_SOC_WM8728 is not set
CONFIG_SND_SOC_WM8731=m
# CONFIG_SND_SOC_WM8731_I2C is not set
CONFIG_SND_SOC_WM8737=m
CONFIG_SND_SOC_WM8741=m
CONFIG_SND_SOC_WM8750=m
# CONFIG_SND_SOC_WM8753 is not set
CONFIG_SND_SOC_WM8776=m
CONFIG_SND_SOC_WM8782=m
CONFIG_SND_SOC_WM8804=m
CONFIG_SND_SOC_WM8804_I2C=m
CONFIG_SND_SOC_WM8903=m
CONFIG_SND_SOC_WM8904=m
# CONFIG_SND_SOC_WM8940 is not set
# CONFIG_SND_SOC_WM8960 is not set
CONFIG_SND_SOC_WM8962=m
# CONFIG_SND_SOC_WM8974 is not set
CONFIG_SND_SOC_WM8978=m
CONFIG_SND_SOC_WM8985=m
CONFIG_SND_SOC_WM8994=m
CONFIG_SND_SOC_WM9712=m
CONFIG_SND_SOC_MAX9759=m
# CONFIG_SND_SOC_MT6351 is not set
CONFIG_SND_SOC_MT6358=m
CONFIG_SND_SOC_MT6660=m
# CONFIG_SND_SOC_NAU8315 is not set
# CONFIG_SND_SOC_NAU8540 is not set
# CONFIG_SND_SOC_NAU8810 is not set
CONFIG_SND_SOC_NAU8821=m
CONFIG_SND_SOC_NAU8822=m
CONFIG_SND_SOC_NAU8824=m
CONFIG_SND_SOC_TPA6130A2=m
CONFIG_SND_SOC_LPASS_MACRO_COMMON=m
CONFIG_SND_SOC_LPASS_WSA_MACRO=m
# CONFIG_SND_SOC_LPASS_VA_MACRO is not set
CONFIG_SND_SOC_LPASS_RX_MACRO=m
CONFIG_SND_SOC_LPASS_TX_MACRO=m
# end of CODEC drivers

CONFIG_SND_SIMPLE_CARD_UTILS=m
CONFIG_SND_SIMPLE_CARD=m
CONFIG_SND_AUDIO_GRAPH_CARD=m
CONFIG_SND_AUDIO_GRAPH_CARD2=m
# CONFIG_SND_AUDIO_GRAPH_CARD2_CUSTOM_SAMPLE is not set
# CONFIG_SND_TEST_COMPONENT is not set
CONFIG_SND_VIRTIO=m
CONFIG_AC97_BUS=m

#
# HID support
#
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
# CONFIG_HIDRAW is not set
CONFIG_UHID=m
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
CONFIG_HID_A4TECH=y
# CONFIG_HID_ACCUTOUCH is not set
CONFIG_HID_ACRUX=m
CONFIG_HID_ACRUX_FF=y
CONFIG_HID_APPLE=m
CONFIG_HID_APPLEIR=m
CONFIG_HID_ASUS=m
# CONFIG_HID_AUREAL is not set
# CONFIG_HID_BELKIN is not set
CONFIG_HID_BETOP_FF=y
CONFIG_HID_BIGBEN_FF=m
# CONFIG_HID_CHERRY is not set
# CONFIG_HID_CHICONY is not set
CONFIG_HID_CORSAIR=m
# CONFIG_HID_COUGAR is not set
CONFIG_HID_MACALLY=y
CONFIG_HID_PRODIKEYS=m
# CONFIG_HID_CMEDIA is not set
# CONFIG_HID_CREATIVE_SB0540 is not set
CONFIG_HID_CYPRESS=m
# CONFIG_HID_DRAGONRISE is not set
CONFIG_HID_EMS_FF=y
CONFIG_HID_ELAN=y
CONFIG_HID_ELECOM=y
CONFIG_HID_ELO=m
CONFIG_HID_EZKEY=y
CONFIG_HID_GEMBIRD=m
CONFIG_HID_GFRM=y
CONFIG_HID_GLORIOUS=y
CONFIG_HID_HOLTEK=m
# CONFIG_HOLTEK_FF is not set
CONFIG_HID_VIVALDI_COMMON=y
CONFIG_HID_VIVALDI=y
CONFIG_HID_GT683R=y
CONFIG_HID_KEYTOUCH=m
CONFIG_HID_KYE=y
CONFIG_HID_UCLOGIC=m
CONFIG_HID_WALTOP=y
CONFIG_HID_VIEWSONIC=m
CONFIG_HID_XIAOMI=y
CONFIG_HID_GYRATION=y
CONFIG_HID_ICADE=m
# CONFIG_HID_ITE is not set
CONFIG_HID_JABRA=y
CONFIG_HID_TWINHAN=m
# CONFIG_HID_KENSINGTON is not set
CONFIG_HID_LCPOWER=y
# CONFIG_HID_LED is not set
CONFIG_HID_LENOVO=y
CONFIG_HID_LETSKETCH=y
# CONFIG_HID_LOGITECH is not set
CONFIG_HID_MAGICMOUSE=y
CONFIG_HID_MALTRON=y
# CONFIG_HID_MAYFLASH is not set
CONFIG_HID_MEGAWORLD_FF=m
CONFIG_HID_REDRAGON=y
# CONFIG_HID_MICROSOFT is not set
CONFIG_HID_MONTEREY=m
# CONFIG_HID_MULTITOUCH is not set
# CONFIG_HID_NINTENDO is not set
CONFIG_HID_NTI=y
CONFIG_HID_NTRIG=m
CONFIG_HID_ORTEK=y
CONFIG_HID_PANTHERLORD=m
CONFIG_PANTHERLORD_FF=y
# CONFIG_HID_PENMOUNT is not set
CONFIG_HID_PETALYNX=y
# CONFIG_HID_PICOLCD is not set
CONFIG_HID_PLANTRONICS=y
CONFIG_HID_RAZER=y
# CONFIG_HID_PRIMAX is not set
CONFIG_HID_RETRODE=y
CONFIG_HID_ROCCAT=m
CONFIG_HID_SAITEK=y
CONFIG_HID_SAMSUNG=y
# CONFIG_HID_SEMITEK is not set
CONFIG_HID_SIGMAMICRO=m
CONFIG_HID_SONY=m
CONFIG_SONY_FF=y
# CONFIG_HID_SPEEDLINK is not set
CONFIG_HID_STEAM=m
CONFIG_HID_STEELSERIES=y
CONFIG_HID_SUNPLUS=y
CONFIG_HID_RMI=y
# CONFIG_HID_GREENASIA is not set
# CONFIG_HID_SMARTJOYPLUS is not set
# CONFIG_HID_TIVO is not set
# CONFIG_HID_TOPSEED is not set
# CONFIG_HID_THINGM is not set
CONFIG_HID_THRUSTMASTER=y
# CONFIG_THRUSTMASTER_FF is not set
CONFIG_HID_UDRAW_PS3=m
CONFIG_HID_U2FZERO=m
CONFIG_HID_WACOM=m
CONFIG_HID_WIIMOTE=y
CONFIG_HID_XINMO=m
# CONFIG_HID_ZEROPLUS is not set
CONFIG_HID_ZYDACRON=m
# CONFIG_HID_SENSOR_HUB is not set
CONFIG_HID_ALPS=m
CONFIG_HID_MCP2221=m
# end of Special HID drivers

#
# USB HID support
#
CONFIG_USB_HID=y
CONFIG_HID_PID=y
CONFIG_USB_HIDDEV=y
# end of USB HID support

#
# I2C HID support
#
CONFIG_I2C_HID_OF=m
CONFIG_I2C_HID_OF_GOODIX=y
# end of I2C HID support

CONFIG_I2C_HID_CORE=y

#
# Intel ISH HID support
#
# end of Intel ISH HID support

#
# AMD SFH HID Support
#
CONFIG_AMD_SFH_HID=y
# end of AMD SFH HID Support
# end of HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
# CONFIG_USB_LED_TRIG is not set
CONFIG_USB_ULPI_BUS=y
CONFIG_USB_CONN_GPIO=y
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_PCI=y
# CONFIG_USB_ANNOUNCE_NEW_DEVICES is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=y
# CONFIG_USB_FEW_INIT_RETRIES is not set
CONFIG_USB_DYNAMIC_MINORS=y
# CONFIG_USB_OTG is not set
CONFIG_USB_OTG_PRODUCTLIST=y
# CONFIG_USB_OTG_DISABLE_EXTERNAL_HUB is not set
# CONFIG_USB_LEDS_TRIGGER_USBPORT is not set
CONFIG_USB_AUTOSUSPEND_DELAY=2
CONFIG_USB_MON=m

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
# CONFIG_USB_XHCI_HCD is not set
CONFIG_USB_BRCMSTB=y
# CONFIG_USB_EHCI_HCD is not set
CONFIG_USB_OXU210HP_HCD=m
# CONFIG_USB_ISP116X_HCD is not set
CONFIG_USB_ISP1362_HCD=m
CONFIG_USB_FOTG210_HCD=y
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_HCD_SPEAR=m
# CONFIG_USB_OHCI_HCD_STI is not set
CONFIG_USB_OHCI_HCD_S3C2410=m
CONFIG_USB_OHCI_HCD_LPC32XX=m
# CONFIG_USB_OHCI_HCD_PXA27X is not set
CONFIG_USB_OHCI_HCD_AT91=y
# CONFIG_USB_OHCI_HCD_OMAP3 is not set
# CONFIG_USB_OHCI_HCD_DAVINCI is not set
CONFIG_USB_OHCI_HCD_PCI=y
CONFIG_USB_OHCI_HCD_SSB=y
# CONFIG_USB_OHCI_SH is not set
CONFIG_USB_OHCI_EXYNOS=m
# CONFIG_USB_CNS3XXX_OHCI is not set
CONFIG_USB_OHCI_HCD_PLATFORM=y
CONFIG_USB_UHCI_HCD=y
CONFIG_USB_UHCI_SUPPORT_NON_PCI_HC=y
CONFIG_USB_UHCI_PLATFORM=y
CONFIG_USB_UHCI_ASPEED=y
CONFIG_USB_SL811_HCD=y
# CONFIG_USB_SL811_HCD_ISO is not set
CONFIG_USB_R8A66597_HCD=y
CONFIG_USB_HCD_BCMA=m
CONFIG_USB_HCD_SSB=y
CONFIG_USB_HCD_TEST_MODE=y

#
# USB Device Class drivers
#
CONFIG_USB_PRINTER=m
CONFIG_USB_WDM=m
CONFIG_USB_TMC=y

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=m
CONFIG_USB_STORAGE_DEBUG=y
CONFIG_USB_STORAGE_REALTEK=m
# CONFIG_REALTEK_AUTOPM is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
CONFIG_USB_STORAGE_ISD200=m
CONFIG_USB_STORAGE_USBAT=m
CONFIG_USB_STORAGE_SDDR09=m
# CONFIG_USB_STORAGE_SDDR55 is not set
CONFIG_USB_STORAGE_JUMPSHOT=m
# CONFIG_USB_STORAGE_ALAUDA is not set
CONFIG_USB_STORAGE_ONETOUCH=m
CONFIG_USB_STORAGE_KARMA=m
# CONFIG_USB_STORAGE_CYPRESS_ATACB is not set
CONFIG_USB_STORAGE_ENE_UB6250=m
# CONFIG_USB_UAS is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USB_CDNS_SUPPORT is not set
CONFIG_USB_MTU3=m
CONFIG_USB_MTU3_HOST=y
# CONFIG_USB_MTU3_DEBUG is not set
CONFIG_USB_MUSB_HDRC=m
CONFIG_USB_MUSB_HOST=y

#
# Platform Glue Layer
#
CONFIG_USB_MUSB_DSPS=m
# CONFIG_USB_MUSB_UX500 is not set
# CONFIG_USB_MUSB_MEDIATEK is not set

#
# MUSB DMA mode
#
CONFIG_MUSB_PIO_ONLY=y
# CONFIG_USB_DWC3 is not set
CONFIG_USB_DWC2=m
CONFIG_USB_DWC2_HOST=y

#
# Gadget/Dual-role mode requires USB Gadget support to be enabled
#
CONFIG_USB_DWC2_PCI=m
CONFIG_USB_DWC2_DEBUG=y
CONFIG_USB_DWC2_VERBOSE=y
# CONFIG_USB_DWC2_TRACK_MISSED_SOFS is not set
# CONFIG_USB_DWC2_DEBUG_PERIODIC is not set
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
CONFIG_USB_ADUTUX=m
CONFIG_USB_SEVSEG=m
CONFIG_USB_LEGOTOWER=y
CONFIG_USB_LCD=y
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
CONFIG_USB_IDMOUSE=y
# CONFIG_USB_FTDI_ELAN is not set
CONFIG_USB_APPLEDISPLAY=y
# CONFIG_USB_QCOM_EUD is not set
CONFIG_APPLE_MFI_FASTCHARGE=y
CONFIG_USB_SISUSBVGA=m
CONFIG_USB_LD=m
CONFIG_USB_TRANCEVIBRATOR=m
# CONFIG_USB_IOWARRIOR is not set
CONFIG_USB_TEST=m
CONFIG_USB_EHSET_TEST_FIXTURE=m
# CONFIG_USB_ISIGHTFW is not set
# CONFIG_USB_YUREX is not set
# CONFIG_USB_EZUSB_FX2 is not set
CONFIG_USB_HUB_USB251XB=y
# CONFIG_USB_HSIC_USB3503 is not set
# CONFIG_USB_HSIC_USB4604 is not set
CONFIG_USB_LINK_LAYER_TEST=y
# CONFIG_USB_CHAOSKEY is not set
CONFIG_BRCM_USB_PINMAP=m

#
# USB Physical Layer drivers
#
CONFIG_USB_PHY=y
CONFIG_ISP1301_OMAP=y
CONFIG_KEYSTONE_USB_PHY=m
CONFIG_NOP_USB_XCEIV=y
# CONFIG_AM335X_PHY_USB is not set
CONFIG_USB_GPIO_VBUS=y
CONFIG_USB_ISP1301=m
# CONFIG_USB_MXS_PHY is not set
CONFIG_USB_TEGRA_PHY=y
CONFIG_USB_ULPI=y
CONFIG_USB_ULPI_VIEWPORT=y
CONFIG_JZ4770_PHY=m
# end of USB Physical Layer drivers

# CONFIG_USB_GADGET is not set
CONFIG_TYPEC=y
CONFIG_TYPEC_TCPM=m
# CONFIG_TYPEC_TCPCI is not set
CONFIG_TYPEC_FUSB302=m
# CONFIG_TYPEC_UCSI is not set
CONFIG_TYPEC_TPS6598X=m
CONFIG_TYPEC_RT1719=m
# CONFIG_TYPEC_HD3SS3220 is not set
CONFIG_TYPEC_STUSB160X=m
CONFIG_TYPEC_QCOM_PMIC=m
# CONFIG_TYPEC_WUSB3801 is not set

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
CONFIG_MMC=m
CONFIG_PWRSEQ_EMMC=m
# CONFIG_PWRSEQ_SIMPLE is not set
CONFIG_MMC_BLOCK=m
CONFIG_MMC_BLOCK_MINORS=8
# CONFIG_MMC_TEST is not set
CONFIG_MMC_CRYPTO=y

#
# MMC/SD/SDIO Host Controller Drivers
#
CONFIG_MMC_DEBUG=y
CONFIG_MMC_ARMMMCI=m
CONFIG_MMC_STM32_SDMMC=y
CONFIG_MMC_PXA=m
# CONFIG_MMC_SDHCI is not set
# CONFIG_MMC_MESON_GX is not set
CONFIG_MMC_MESON_MX_SDHC=m
CONFIG_MMC_MESON_MX_SDIO=m
CONFIG_MMC_MOXART=m
CONFIG_MMC_OMAP_HS=m
# CONFIG_MMC_ALCOR is not set
CONFIG_MMC_ATMELMCI=m
CONFIG_MMC_TIFM_SD=m
CONFIG_MMC_MVSDIO=m
CONFIG_MMC_DAVINCI=m
CONFIG_MMC_S3C=m
# CONFIG_MMC_S3C_HW_SDIO_IRQ is not set
CONFIG_MMC_S3C_PIO=y
# CONFIG_MMC_S3C_DMA is not set
CONFIG_MMC_TMIO_CORE=m
CONFIG_MMC_TMIO=m
CONFIG_MMC_SDHI=m
CONFIG_MMC_SDHI_SYS_DMAC=m
# CONFIG_MMC_SDHI_INTERNAL_DMAC is not set
CONFIG_MMC_UNIPHIER=m
# CONFIG_MMC_CB710 is not set
CONFIG_MMC_VIA_SDMMC=m
CONFIG_MMC_DW=m
CONFIG_MMC_DW_PLTFM=m
CONFIG_MMC_DW_BLUEFIELD=m
# CONFIG_MMC_DW_EXYNOS is not set
CONFIG_MMC_DW_HI3798CV200=m
CONFIG_MMC_DW_K3=m
CONFIG_MMC_DW_PCI=m
# CONFIG_MMC_SH_MMCIF is not set
CONFIG_MMC_VUB300=m
CONFIG_MMC_USHC=m
# CONFIG_MMC_USDHI6ROL0 is not set
CONFIG_MMC_REALTEK_PCI=m
CONFIG_MMC_SUNXI=m
# CONFIG_MMC_CQHCI is not set
# CONFIG_MMC_HSQ is not set
CONFIG_MMC_TOSHIBA_PCI=m
CONFIG_MMC_BCM2835=m
# CONFIG_MMC_MTK is not set
# CONFIG_MMC_OWL is not set
CONFIG_MMC_LITEX=m
CONFIG_SCSI_UFSHCD=m
# CONFIG_SCSI_UFS_BSG is not set
CONFIG_SCSI_UFS_CRYPTO=y
# CONFIG_SCSI_UFS_HPB is not set
# CONFIG_SCSI_UFS_HWMON is not set
CONFIG_SCSI_UFSHCD_PCI=m
# CONFIG_SCSI_UFS_DWC_TC_PCI is not set
CONFIG_SCSI_UFSHCD_PLATFORM=m
# CONFIG_SCSI_UFS_CDNS_PLATFORM is not set
CONFIG_SCSI_UFS_DWC_TC_PLATFORM=m
# CONFIG_SCSI_UFS_HISI is not set
CONFIG_SCSI_UFS_TI_J721E=m
CONFIG_SCSI_UFS_EXYNOS=m
CONFIG_MEMSTICK=m
# CONFIG_MEMSTICK_DEBUG is not set

#
# MemoryStick drivers
#
# CONFIG_MEMSTICK_UNSAFE_RESUME is not set
# CONFIG_MSPRO_BLOCK is not set
# CONFIG_MS_BLOCK is not set

#
# MemoryStick Host Controller Drivers
#
CONFIG_MEMSTICK_TIFM_MS=m
# CONFIG_MEMSTICK_JMICRON_38X is not set
# CONFIG_MEMSTICK_R592 is not set
CONFIG_MEMSTICK_REALTEK_PCI=m
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_CLASS_FLASH=m
# CONFIG_LEDS_CLASS_MULTICOLOR is not set
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
CONFIG_LEDS_AN30259A=m
CONFIG_LEDS_ARIEL=m
CONFIG_LEDS_AW2013=m
CONFIG_LEDS_BCM6328=m
CONFIG_LEDS_BCM6358=y
# CONFIG_LEDS_LM3530 is not set
CONFIG_LEDS_LM3532=m
# CONFIG_LEDS_LM3533 is not set
CONFIG_LEDS_LM3642=y
CONFIG_LEDS_LM3692X=m
# CONFIG_LEDS_S3C24XX is not set
CONFIG_LEDS_COBALT_QUBE=y
CONFIG_LEDS_COBALT_RAQ=y
CONFIG_LEDS_PCA9532=m
CONFIG_LEDS_PCA9532_GPIO=y
CONFIG_LEDS_GPIO=y
CONFIG_LEDS_LP3944=m
CONFIG_LEDS_LP3952=m
CONFIG_LEDS_LP50XX=y
CONFIG_LEDS_LP55XX_COMMON=m
CONFIG_LEDS_LP5521=m
CONFIG_LEDS_LP5523=m
# CONFIG_LEDS_LP5562 is not set
CONFIG_LEDS_LP8501=m
# CONFIG_LEDS_LP8788 is not set
CONFIG_LEDS_LP8860=m
CONFIG_LEDS_PCA955X=y
CONFIG_LEDS_PCA955X_GPIO=y
CONFIG_LEDS_PCA963X=y
# CONFIG_LEDS_WM831X_STATUS is not set
CONFIG_LEDS_PWM=m
CONFIG_LEDS_REGULATOR=y
CONFIG_LEDS_BD2802=m
# CONFIG_LEDS_LT3593 is not set
CONFIG_LEDS_MC13783=y
# CONFIG_LEDS_NS2 is not set
CONFIG_LEDS_NETXBIG=m
CONFIG_LEDS_ASIC3=y
CONFIG_LEDS_TCA6507=y
CONFIG_LEDS_TLC591XX=y
CONFIG_LEDS_MAX8997=y
CONFIG_LEDS_LM355x=y
# CONFIG_LEDS_OT200 is not set
# CONFIG_LEDS_MENF21BMC is not set
# CONFIG_LEDS_IS31FL319X is not set
CONFIG_LEDS_IS31FL32XX=y

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
# CONFIG_LEDS_BLINKM is not set
CONFIG_LEDS_SYSCON=y
# CONFIG_LEDS_PM8058 is not set
CONFIG_LEDS_MLXREG=y
CONFIG_LEDS_USER=m
# CONFIG_LEDS_TI_LMU_COMMON is not set
CONFIG_LEDS_TPS6105X=m
# CONFIG_LEDS_IP30 is not set
CONFIG_LEDS_LGM=m

#
# Flash and Torch LED drivers
#
# CONFIG_LEDS_AAT1290 is not set
# CONFIG_LEDS_AS3645A is not set
# CONFIG_LEDS_KTD2692 is not set
CONFIG_LEDS_LM3601X=m
# CONFIG_LEDS_MAX77693 is not set
# CONFIG_LEDS_MT6360 is not set
# CONFIG_LEDS_RT4505 is not set
# CONFIG_LEDS_RT8515 is not set
CONFIG_LEDS_SGM3140=m

#
# RGB LED drivers
#

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=y
CONFIG_LEDS_TRIGGER_ONESHOT=m
# CONFIG_LEDS_TRIGGER_DISK is not set
# CONFIG_LEDS_TRIGGER_MTD is not set
CONFIG_LEDS_TRIGGER_HEARTBEAT=m
CONFIG_LEDS_TRIGGER_BACKLIGHT=m
CONFIG_LEDS_TRIGGER_CPU=y
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
CONFIG_LEDS_TRIGGER_GPIO=y
CONFIG_LEDS_TRIGGER_DEFAULT_ON=m

#
# iptables trigger is under Netfilter config (LED target)
#
# CONFIG_LEDS_TRIGGER_TRANSIENT is not set
CONFIG_LEDS_TRIGGER_CAMERA=y
CONFIG_LEDS_TRIGGER_PANIC=y
# CONFIG_LEDS_TRIGGER_PATTERN is not set
CONFIG_LEDS_TRIGGER_AUDIO=m

#
# Simple LED drivers
#
# CONFIG_ACCESSIBILITY is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_RTC_LIB=y
CONFIG_RTC_CLASS=y
# CONFIG_RTC_HCTOSYS is not set
# CONFIG_RTC_SYSTOHC is not set
CONFIG_RTC_DEBUG=y
CONFIG_RTC_LIB_KUNIT_TEST=y
# CONFIG_RTC_NVMEM is not set

#
# RTC interfaces
#
# CONFIG_RTC_INTF_SYSFS is not set
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
CONFIG_RTC_DRV_TEST=m

#
# I2C RTC drivers
#
CONFIG_RTC_DRV_88PM80X=m
CONFIG_RTC_DRV_ABB5ZES3=y
CONFIG_RTC_DRV_ABEOZ9=m
CONFIG_RTC_DRV_ABX80X=m
# CONFIG_RTC_DRV_AC100 is not set
CONFIG_RTC_DRV_BRCMSTB=m
CONFIG_RTC_DRV_AS3722=y
CONFIG_RTC_DRV_DS1307=y
# CONFIG_RTC_DRV_DS1307_CENTURY is not set
# CONFIG_RTC_DRV_DS1374 is not set
CONFIG_RTC_DRV_DS1672=y
# CONFIG_RTC_DRV_HYM8563 is not set
# CONFIG_RTC_DRV_LP8788 is not set
CONFIG_RTC_DRV_MAX6900=y
# CONFIG_RTC_DRV_MAX8907 is not set
CONFIG_RTC_DRV_MAX8997=m
# CONFIG_RTC_DRV_MAX77686 is not set
CONFIG_RTC_DRV_RS5C372=y
CONFIG_RTC_DRV_ISL1208=m
CONFIG_RTC_DRV_ISL12022=y
# CONFIG_RTC_DRV_ISL12026 is not set
CONFIG_RTC_DRV_X1205=y
CONFIG_RTC_DRV_PCF8523=m
# CONFIG_RTC_DRV_PCF85063 is not set
CONFIG_RTC_DRV_PCF85363=m
# CONFIG_RTC_DRV_PCF8563 is not set
CONFIG_RTC_DRV_PCF8583=y
CONFIG_RTC_DRV_M41T80=m
CONFIG_RTC_DRV_M41T80_WDT=y
# CONFIG_RTC_DRV_BQ32K is not set
CONFIG_RTC_DRV_TWL4030=m
CONFIG_RTC_DRV_TPS65910=y
CONFIG_RTC_DRV_RC5T583=m
CONFIG_RTC_DRV_RC5T619=y
CONFIG_RTC_DRV_S35390A=m
# CONFIG_RTC_DRV_FM3130 is not set
# CONFIG_RTC_DRV_RX8010 is not set
# CONFIG_RTC_DRV_RX8581 is not set
CONFIG_RTC_DRV_RX8025=y
CONFIG_RTC_DRV_EM3027=y
CONFIG_RTC_DRV_RV3028=m
CONFIG_RTC_DRV_RV3032=m
CONFIG_RTC_DRV_RV8803=y
CONFIG_RTC_DRV_S5M=y
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
# CONFIG_RTC_DRV_PCF2127 is not set
CONFIG_RTC_DRV_RV3029C2=m
CONFIG_RTC_DRV_RV3029_HWMON=y
CONFIG_RTC_DRV_RX6110=m

#
# Platform RTC drivers
#
# CONFIG_RTC_DRV_CMOS is not set
CONFIG_RTC_DRV_DS1286=y
CONFIG_RTC_DRV_DS1511=m
# CONFIG_RTC_DRV_DS1553 is not set
CONFIG_RTC_DRV_DS1685_FAMILY=m
CONFIG_RTC_DRV_DS1685=y
# CONFIG_RTC_DRV_DS1689 is not set
# CONFIG_RTC_DRV_DS17285 is not set
# CONFIG_RTC_DRV_DS17485 is not set
# CONFIG_RTC_DRV_DS17885 is not set
CONFIG_RTC_DRV_DS1742=m
# CONFIG_RTC_DRV_DS2404 is not set
CONFIG_RTC_DRV_DA9055=m
# CONFIG_RTC_DRV_DA9063 is not set
# CONFIG_RTC_DRV_EFI is not set
CONFIG_RTC_DRV_STK17TA8=y
# CONFIG_RTC_DRV_M48T86 is not set
CONFIG_RTC_DRV_M48T35=m
CONFIG_RTC_DRV_M48T59=m
CONFIG_RTC_DRV_MSM6242=m
# CONFIG_RTC_DRV_BQ4802 is not set
CONFIG_RTC_DRV_RP5C01=m
CONFIG_RTC_DRV_V3020=y
# CONFIG_RTC_DRV_GAMECUBE is not set
CONFIG_RTC_DRV_WM831X=m
CONFIG_RTC_DRV_SC27XX=m
CONFIG_RTC_DRV_SPEAR=y
# CONFIG_RTC_DRV_PCF50633 is not set
CONFIG_RTC_DRV_ZYNQMP=m

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_ASM9260 is not set
CONFIG_RTC_DRV_DAVINCI=y
CONFIG_RTC_DRV_DIGICOLOR=m
# CONFIG_RTC_DRV_FSL_FTM_ALARM is not set
# CONFIG_RTC_DRV_MESON is not set
CONFIG_RTC_DRV_MESON_VRTC=m
CONFIG_RTC_DRV_OMAP=y
CONFIG_RTC_DRV_S3C=y
CONFIG_RTC_DRV_EP93XX=m
CONFIG_RTC_DRV_SA1100=m
# CONFIG_RTC_DRV_VR41XX is not set
CONFIG_RTC_DRV_PL030=m
CONFIG_RTC_DRV_PL031=m
CONFIG_RTC_DRV_AT91RM9200=y
CONFIG_RTC_DRV_AT91SAM9=y
# CONFIG_RTC_DRV_RZN1 is not set
# CONFIG_RTC_DRV_GENERIC is not set
CONFIG_RTC_DRV_PXA=m
CONFIG_RTC_DRV_VT8500=y
CONFIG_RTC_DRV_SUN6I=y
CONFIG_RTC_DRV_SUNXI=y
CONFIG_RTC_DRV_MV=m
# CONFIG_RTC_DRV_ARMADA38X is not set
CONFIG_RTC_DRV_CADENCE=y
CONFIG_RTC_DRV_FTRTC010=y
CONFIG_RTC_DRV_STMP=y
# CONFIG_RTC_DRV_MC13XXX is not set
CONFIG_RTC_DRV_JZ4740=m
CONFIG_RTC_DRV_LPC24XX=y
CONFIG_RTC_DRV_LPC32XX=y
# CONFIG_RTC_DRV_PM8XXX is not set
CONFIG_RTC_DRV_TEGRA=y
CONFIG_RTC_DRV_MXC=m
# CONFIG_RTC_DRV_MXC_V2 is not set
# CONFIG_RTC_DRV_SNVS is not set
CONFIG_RTC_DRV_MOXART=m
CONFIG_RTC_DRV_MT2712=m
# CONFIG_RTC_DRV_MT6397 is not set
CONFIG_RTC_DRV_MT7622=m
CONFIG_RTC_DRV_XGENE=m
CONFIG_RTC_DRV_R7301=m
CONFIG_RTC_DRV_STM32=m
# CONFIG_RTC_DRV_RTD119X is not set
CONFIG_RTC_DRV_ASPEED=y

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
CONFIG_DMABUF_SELFTESTS=y
# CONFIG_DMABUF_HEAPS is not set
# CONFIG_DMABUF_SYSFS_STATS is not set
# end of DMABUF options

CONFIG_AUXDISPLAY=y
CONFIG_CHARLCD=m
CONFIG_LINEDISP=y
CONFIG_HD44780_COMMON=m
# CONFIG_HD44780 is not set
CONFIG_IMG_ASCII_LCD=y
# CONFIG_HT16K33 is not set
# CONFIG_LCD2S is not set
CONFIG_PARPORT_PANEL=m
CONFIG_PANEL_PARPORT=0
CONFIG_PANEL_PROFILE=5
CONFIG_PANEL_CHANGE_MESSAGE=y
CONFIG_PANEL_BOOT_MESSAGE=""
CONFIG_CHARLCD_BL_OFF=y
# CONFIG_CHARLCD_BL_ON is not set
# CONFIG_CHARLCD_BL_FLASH is not set
CONFIG_PANEL=m
CONFIG_UIO=m
CONFIG_UIO_CIF=m
CONFIG_UIO_PDRV_GENIRQ=m
CONFIG_UIO_DMEM_GENIRQ=m
CONFIG_UIO_AEC=m
# CONFIG_UIO_SERCOS3 is not set
# CONFIG_UIO_PCI_GENERIC is not set
# CONFIG_UIO_NETX is not set
CONFIG_UIO_PRUSS=m
CONFIG_UIO_MF624=m
# CONFIG_VFIO is not set
CONFIG_VIRT_DRIVERS=y
CONFIG_VIRTIO=y
# CONFIG_VIRTIO_MENU is not set
CONFIG_VHOST_MENU=y
CONFIG_VHOST_CROSS_ENDIAN_LEGACY=y

#
# Microsoft Hyper-V guest support
#
# end of Microsoft Hyper-V guest support

CONFIG_GREYBUS=m
# CONFIG_GREYBUS_ES2 is not set
# CONFIG_COMEDI is not set
CONFIG_STAGING=y
CONFIG_RTS5208=m

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
# CONFIG_ADT7316 is not set
# end of Analog digital bi-direction converters

#
# Capacitance to digital converters
#
CONFIG_AD7746=m
# end of Capacitance to digital converters

#
# Direct Digital Synthesis
#
# end of Direct Digital Synthesis

#
# Network Analyzer, Impedance Converters
#
# CONFIG_AD5933 is not set
# end of Network Analyzer, Impedance Converters

#
# Active energy metering IC
#
CONFIG_ADE7854=m
CONFIG_ADE7854_I2C=m
# end of Active energy metering IC

#
# Resolver to digital converters
#
# end of Resolver to digital converters
# end of IIO staging drivers

CONFIG_FB_SM750=m
# CONFIG_STAGING_MEDIA is not set
CONFIG_STAGING_BOARD=y
# CONFIG_COMMON_CLK_XLNX_CLKWZRD is not set
CONFIG_MOST_COMPONENTS=m
CONFIG_MOST_DIM2=m
CONFIG_MOST_I2C=m
# CONFIG_GREYBUS_AUDIO is not set
CONFIG_GREYBUS_BOOTROM=m
CONFIG_GREYBUS_HID=m
CONFIG_GREYBUS_LIGHT=m
# CONFIG_GREYBUS_LOG is not set
# CONFIG_GREYBUS_LOOPBACK is not set
CONFIG_GREYBUS_POWER=m
CONFIG_GREYBUS_RAW=m
# CONFIG_GREYBUS_VIBRATOR is not set
# CONFIG_GREYBUS_BRIDGED_PHY is not set
CONFIG_GREYBUS_ARCHE=m
CONFIG_BCM_VIDEOCORE=y
CONFIG_BCM2835_VCHIQ=y
CONFIG_VCHIQ_CDEV=y
CONFIG_SND_BCM2835=m
CONFIG_BCM2835_VCHIQ_MMAL=m
CONFIG_XIL_AXIS_FIFO=m
CONFIG_FIELDBUS_DEV=m
# CONFIG_HMS_ANYBUSS_BUS is not set

#
# VME Device Drivers
#
# CONFIG_VME_USER is not set
# CONFIG_GOLDFISH is not set
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
# CONFIG_CLK_SP810 is not set
# CONFIG_CLK_VEXPRESS_OSC is not set
# end of Clock driver for ARM Reference designs

CONFIG_CLK_HSDK=y
# CONFIG_COMMON_CLK_APPLE_NCO is not set
# CONFIG_COMMON_CLK_MAX77686 is not set
CONFIG_COMMON_CLK_MAX9485=y
# CONFIG_COMMON_CLK_HI655X is not set
# CONFIG_COMMON_CLK_SCMI is not set
# CONFIG_COMMON_CLK_SCPI is not set
# CONFIG_COMMON_CLK_SI5341 is not set
CONFIG_COMMON_CLK_SI5351=y
CONFIG_COMMON_CLK_SI514=y
# CONFIG_COMMON_CLK_SI544 is not set
CONFIG_COMMON_CLK_SI570=m
CONFIG_COMMON_CLK_BM1880=y
# CONFIG_COMMON_CLK_CDCE706 is not set
CONFIG_COMMON_CLK_TPS68470=m
CONFIG_COMMON_CLK_CDCE925=m
# CONFIG_COMMON_CLK_CS2000_CP is not set
CONFIG_COMMON_CLK_EN7523=y
CONFIG_COMMON_CLK_FSL_FLEXSPI=y
CONFIG_COMMON_CLK_FSL_SAI=y
CONFIG_COMMON_CLK_GEMINI=y
# CONFIG_COMMON_CLK_LAN966X is not set
CONFIG_COMMON_CLK_ASPEED=y
CONFIG_COMMON_CLK_S2MPS11=m
# CONFIG_COMMON_CLK_AXI_CLKGEN is not set
# CONFIG_CLK_QORIQ is not set
CONFIG_CLK_LS1028A_PLLDIG=y
CONFIG_COMMON_CLK_XGENE=y
CONFIG_COMMON_CLK_NXP=y
# CONFIG_COMMON_CLK_PWM is not set
CONFIG_COMMON_CLK_PXA=y
# CONFIG_COMMON_CLK_OXNAS is not set
CONFIG_COMMON_CLK_RS9_PCIE=m
# CONFIG_COMMON_CLK_VC5 is not set
CONFIG_COMMON_CLK_MMP2_AUDIO=y
CONFIG_COMMON_CLK_BD718XX=m
CONFIG_COMMON_CLK_FIXED_MMIO=y
CONFIG_CLK_ACTIONS=y
# CONFIG_CLK_OWL_S500 is not set
# CONFIG_CLK_OWL_S700 is not set
# CONFIG_CLK_OWL_S900 is not set
# CONFIG_CLK_BAIKAL_T1 is not set
CONFIG_CLK_BCM2711_DVP=y
CONFIG_CLK_BCM2835=y
# CONFIG_CLK_BCM_63XX is not set
CONFIG_CLK_BCM_63XX_GATE=y
CONFIG_CLK_BCM_KONA=y
CONFIG_COMMON_CLK_IPROC=y
# CONFIG_CLK_BCM_CYGNUS is not set
CONFIG_CLK_BCM_HR2=y
# CONFIG_CLK_BCM_NSP is not set
# CONFIG_CLK_BCM_NS2 is not set
CONFIG_CLK_BCM_SR=y
CONFIG_CLK_RASPBERRYPI=y
CONFIG_COMMON_CLK_HI3516CV300=y
CONFIG_COMMON_CLK_HI3519=y
# CONFIG_COMMON_CLK_HI3559A is not set
# CONFIG_COMMON_CLK_HI3660 is not set
# CONFIG_COMMON_CLK_HI3670 is not set
CONFIG_COMMON_CLK_HI3798CV200=y
CONFIG_COMMON_CLK_HI6220=y
CONFIG_RESET_HISI=y
# CONFIG_STUB_CLK_HI6220 is not set
# CONFIG_STUB_CLK_HI3660 is not set
# CONFIG_COMMON_CLK_BOSTON is not set
CONFIG_MXC_CLK=y
CONFIG_CLK_IMX8MM=m
CONFIG_CLK_IMX8MN=y
CONFIG_CLK_IMX8MP=m
CONFIG_CLK_IMX8MQ=m
CONFIG_CLK_IMX8ULP=m
CONFIG_CLK_IMX93=m

#
# Ingenic SoCs drivers
#
CONFIG_INGENIC_CGU_COMMON=y
CONFIG_INGENIC_CGU_JZ4740=y
# CONFIG_INGENIC_CGU_JZ4725B is not set
# CONFIG_INGENIC_CGU_JZ4760 is not set
# CONFIG_INGENIC_CGU_JZ4770 is not set
CONFIG_INGENIC_CGU_JZ4780=y
CONFIG_INGENIC_CGU_X1000=y
CONFIG_INGENIC_CGU_X1830=y
CONFIG_INGENIC_TCU_CLK=y
# end of Ingenic SoCs drivers

CONFIG_COMMON_CLK_KEYSTONE=m
CONFIG_TI_SYSCON_CLK=m

#
# Clock driver for MediaTek SoC
#
CONFIG_COMMON_CLK_MEDIATEK=y
# CONFIG_COMMON_CLK_MT2701 is not set
# CONFIG_COMMON_CLK_MT2712 is not set
# CONFIG_COMMON_CLK_MT6765 is not set
CONFIG_COMMON_CLK_MT6779=m
# CONFIG_COMMON_CLK_MT6779_MMSYS is not set
CONFIG_COMMON_CLK_MT6779_IMGSYS=m
CONFIG_COMMON_CLK_MT6779_IPESYS=m
# CONFIG_COMMON_CLK_MT6779_CAMSYS is not set
# CONFIG_COMMON_CLK_MT6779_VDECSYS is not set
CONFIG_COMMON_CLK_MT6779_VENCSYS=m
CONFIG_COMMON_CLK_MT6779_MFGCFG=m
CONFIG_COMMON_CLK_MT6779_AUDSYS=m
# CONFIG_COMMON_CLK_MT6797 is not set
CONFIG_COMMON_CLK_MT7622=y
CONFIG_COMMON_CLK_MT7622_ETHSYS=y
# CONFIG_COMMON_CLK_MT7622_HIFSYS is not set
CONFIG_COMMON_CLK_MT7622_AUDSYS=y
# CONFIG_COMMON_CLK_MT7629 is not set
# CONFIG_COMMON_CLK_MT7986 is not set
# CONFIG_COMMON_CLK_MT8135 is not set
# CONFIG_COMMON_CLK_MT8167 is not set
CONFIG_COMMON_CLK_MT8173=y
CONFIG_COMMON_CLK_MT8173_MMSYS=y
CONFIG_COMMON_CLK_MT8183=y
CONFIG_COMMON_CLK_MT8183_AUDIOSYS=y
# CONFIG_COMMON_CLK_MT8183_CAMSYS is not set
# CONFIG_COMMON_CLK_MT8183_IMGSYS is not set
CONFIG_COMMON_CLK_MT8183_IPU_CORE0=y
CONFIG_COMMON_CLK_MT8183_IPU_CORE1=y
CONFIG_COMMON_CLK_MT8183_IPU_ADL=y
# CONFIG_COMMON_CLK_MT8183_IPU_CONN is not set
# CONFIG_COMMON_CLK_MT8183_MFGCFG is not set
CONFIG_COMMON_CLK_MT8183_MMSYS=y
# CONFIG_COMMON_CLK_MT8183_VDECSYS is not set
# CONFIG_COMMON_CLK_MT8183_VENCSYS is not set
CONFIG_COMMON_CLK_MT8186=y
CONFIG_COMMON_CLK_MT8192=y
# CONFIG_COMMON_CLK_MT8192_AUDSYS is not set
CONFIG_COMMON_CLK_MT8192_CAMSYS=y
CONFIG_COMMON_CLK_MT8192_IMGSYS=y
CONFIG_COMMON_CLK_MT8192_IMP_IIC_WRAP=y
# CONFIG_COMMON_CLK_MT8192_IPESYS is not set
CONFIG_COMMON_CLK_MT8192_MDPSYS=y
# CONFIG_COMMON_CLK_MT8192_MFGCFG is not set
CONFIG_COMMON_CLK_MT8192_MMSYS=y
CONFIG_COMMON_CLK_MT8192_MSDC=y
# CONFIG_COMMON_CLK_MT8192_SCP_ADSP is not set
CONFIG_COMMON_CLK_MT8192_VDECSYS=y
# CONFIG_COMMON_CLK_MT8192_VENCSYS is not set
CONFIG_COMMON_CLK_MT8195=y
# CONFIG_COMMON_CLK_MT8516 is not set
# end of Clock driver for MediaTek SoC

#
# Clock support for Amlogic platforms
#
CONFIG_COMMON_CLK_MESON_REGMAP=y
CONFIG_COMMON_CLK_MESON_MPLL=y
CONFIG_COMMON_CLK_MESON_PLL=y
CONFIG_COMMON_CLK_MESON8B=y
# CONFIG_COMMON_CLK_AXG_AUDIO is not set
# end of Clock support for Amlogic platforms

CONFIG_MSTAR_MSC313_MPLL=y
# CONFIG_MCHP_CLK_MPFS is not set
CONFIG_MVEBU_CLK_COMMON=y
CONFIG_ORION_CLK=y
# CONFIG_COMMON_CLK_PISTACHIO is not set
CONFIG_KRAIT_CLOCKS=y
CONFIG_QCOM_GDSC=y
CONFIG_QCOM_RPMCC=y
CONFIG_COMMON_CLK_QCOM=y
# CONFIG_QCOM_A53PLL is not set
# CONFIG_QCOM_A7PLL is not set
CONFIG_QCOM_CLK_APCS_MSM8916=y
CONFIG_QCOM_CLK_APCS_SDX55=y
CONFIG_QCOM_CLK_SMD_RPM=m
CONFIG_APQ_GCC_8084=y
CONFIG_APQ_MMCC_8084=y
CONFIG_IPQ_APSS_PLL=m
CONFIG_IPQ_APSS_6018=m
CONFIG_IPQ_GCC_4019=y
CONFIG_IPQ_GCC_6018=y
CONFIG_IPQ_GCC_806X=y
CONFIG_IPQ_LCC_806X=m
# CONFIG_IPQ_GCC_8074 is not set
# CONFIG_MSM_GCC_8660 is not set
# CONFIG_MSM_GCC_8916 is not set
CONFIG_MSM_GCC_8939=y
# CONFIG_MSM_GCC_8960 is not set
# CONFIG_MSM_LCC_8960 is not set
CONFIG_MDM_GCC_9607=y
CONFIG_MDM_GCC_9615=m
# CONFIG_MDM_LCC_9615 is not set
# CONFIG_MSM_MMCC_8960 is not set
# CONFIG_MSM_GCC_8953 is not set
CONFIG_MSM_GCC_8974=y
CONFIG_MSM_MMCC_8974=y
CONFIG_MSM_GCC_8976=y
# CONFIG_MSM_MMCC_8994 is not set
CONFIG_MSM_GCC_8994=m
CONFIG_MSM_GCC_8996=y
# CONFIG_MSM_MMCC_8996 is not set
CONFIG_MSM_GCC_8998=m
# CONFIG_MSM_GPUCC_8998 is not set
CONFIG_MSM_MMCC_8998=m
CONFIG_QCM_GCC_2290=m
CONFIG_QCM_DISPCC_2290=m
CONFIG_QCS_GCC_404=y
# CONFIG_SC_CAMCC_7180 is not set
CONFIG_SC_CAMCC_7280=y
# CONFIG_SC_DISPCC_7180 is not set
CONFIG_SC_DISPCC_7280=m
CONFIG_SC_GCC_7180=y
CONFIG_SC_GCC_7280=y
CONFIG_SC_GCC_8180X=m
# CONFIG_SC_GCC_8280XP is not set
CONFIG_SC_GPUCC_7180=y
# CONFIG_SC_GPUCC_7280 is not set
# CONFIG_SC_LPASSCC_7280 is not set
CONFIG_SC_LPASS_CORECC_7180=m
CONFIG_SC_LPASS_CORECC_7280=m
# CONFIG_SC_MSS_7180 is not set
# CONFIG_SC_VIDEOCC_7180 is not set
CONFIG_SC_VIDEOCC_7280=y
# CONFIG_SDM_CAMCC_845 is not set
CONFIG_SDM_GCC_660=m
# CONFIG_SDM_MMCC_660 is not set
CONFIG_SDM_GPUCC_660=m
CONFIG_QCS_TURING_404=y
CONFIG_QCS_Q6SSTOP_404=y
CONFIG_SDM_GCC_845=y
CONFIG_SDM_GPUCC_845=m
CONFIG_SDM_VIDEOCC_845=m
CONFIG_SDM_DISPCC_845=y
CONFIG_SDM_LPASSCC_845=y
# CONFIG_SDX_GCC_55 is not set
# CONFIG_SDX_GCC_65 is not set
CONFIG_SM_CAMCC_8250=y
# CONFIG_SM_DISPCC_8250 is not set
CONFIG_SM_DISPCC_6350=m
CONFIG_SM_GCC_6115=y
# CONFIG_SM_GCC_6125 is not set
CONFIG_SM_GCC_6350=m
CONFIG_SM_GCC_8150=m
CONFIG_SM_GCC_8250=y
CONFIG_SM_GCC_8350=y
CONFIG_SM_GCC_8450=y
CONFIG_SM_GPUCC_6350=m
CONFIG_SM_GPUCC_8150=m
CONFIG_SM_GPUCC_8250=y
CONFIG_SM_VIDEOCC_8150=m
# CONFIG_SM_VIDEOCC_8250 is not set
CONFIG_SPMI_PMIC_CLKDIV=m
# CONFIG_QCOM_HFPLL is not set
CONFIG_KPSS_XCC=m
CONFIG_KRAITCC=y
CONFIG_CLK_GFM_LPASS_SM8250=y
CONFIG_CLK_MT7621=y
# CONFIG_CLK_RENESAS is not set
CONFIG_COMMON_CLK_SAMSUNG=y
# CONFIG_S3C64XX_COMMON_CLK is not set
CONFIG_S5PV210_COMMON_CLK=y
CONFIG_EXYNOS_3250_COMMON_CLK=y
# CONFIG_EXYNOS_4_COMMON_CLK is not set
# CONFIG_EXYNOS_5250_COMMON_CLK is not set
CONFIG_EXYNOS_5260_COMMON_CLK=y
CONFIG_EXYNOS_5410_COMMON_CLK=y
CONFIG_EXYNOS_5420_COMMON_CLK=y
# CONFIG_EXYNOS_ARM64_COMMON_CLK is not set
# CONFIG_EXYNOS_AUDSS_CLK_CON is not set
# CONFIG_EXYNOS_CLKOUT is not set
# CONFIG_S3C2410_COMMON_CLK is not set
# CONFIG_S3C2412_COMMON_CLK is not set
# CONFIG_S3C2443_COMMON_CLK is not set
CONFIG_CLK_SIFIVE=y
# CONFIG_CLK_SIFIVE_PRCI is not set
# CONFIG_CLK_INTEL_SOCFPGA is not set
# CONFIG_SPRD_COMMON_CLK is not set
CONFIG_CLK_STARFIVE_JH7100=y
CONFIG_CLK_STARFIVE_JH7100_AUDIO=y
CONFIG_CLK_SUNXI=y
# CONFIG_CLK_SUNXI_CLOCKS is not set
CONFIG_CLK_SUNXI_PRCM_SUN6I=y
# CONFIG_CLK_SUNXI_PRCM_SUN8I is not set
# CONFIG_CLK_SUNXI_PRCM_SUN9I is not set
CONFIG_SUNXI_CCU=m
CONFIG_SUNIV_F1C100S_CCU=m
# CONFIG_SUN20I_D1_CCU is not set
CONFIG_SUN20I_D1_R_CCU=m
# CONFIG_SUN50I_A64_CCU is not set
# CONFIG_SUN50I_A100_CCU is not set
# CONFIG_SUN50I_A100_R_CCU is not set
CONFIG_SUN50I_H6_CCU=m
CONFIG_SUN50I_H616_CCU=m
CONFIG_SUN50I_H6_R_CCU=m
# CONFIG_SUN4I_A10_CCU is not set
CONFIG_SUN6I_A31_CCU=m
# CONFIG_SUN6I_RTC_CCU is not set
CONFIG_SUN8I_A23_CCU=m
# CONFIG_SUN8I_A33_CCU is not set
CONFIG_SUN8I_A83T_CCU=m
CONFIG_SUN8I_H3_CCU=m
CONFIG_SUN8I_V3S_CCU=m
CONFIG_SUN8I_DE2_CCU=m
CONFIG_SUN8I_R40_CCU=m
CONFIG_SUN9I_A80_CCU=m
CONFIG_SUN8I_R_CCU=m
# CONFIG_COMMON_CLK_TI_ADPLL is not set
CONFIG_CLK_UNIPHIER=y
# CONFIG_COMMON_CLK_VISCONTI is not set
# CONFIG_CLK_LGM_CGU is not set
CONFIG_XILINX_VCU=y
# CONFIG_COMMON_CLK_ZYNQMP is not set
CONFIG_CLK_KUNIT_TEST=y
CONFIG_CLK_GATE_KUNIT_TEST=y
CONFIG_HWSPINLOCK=y
CONFIG_HWSPINLOCK_OMAP=y
# CONFIG_HWSPINLOCK_QCOM is not set
CONFIG_HWSPINLOCK_SPRD=y
CONFIG_HWSPINLOCK_STM32=m
CONFIG_HWSPINLOCK_SUN6I=m
CONFIG_HSEM_U8500=y

#
# Clock Source drivers
#
CONFIG_TIMER_OF=y
CONFIG_TIMER_PROBE=y
CONFIG_CLKSRC_MMIO=y
CONFIG_BCM2835_TIMER=y
# CONFIG_BCM_KONA_TIMER is not set
CONFIG_DAVINCI_TIMER=y
# CONFIG_DIGICOLOR_TIMER is not set
# CONFIG_DW_APB_TIMER is not set
CONFIG_FTTMR010_TIMER=y
CONFIG_IXP4XX_TIMER=y
CONFIG_ROCKCHIP_TIMER=y
# CONFIG_ARMADA_370_XP_TIMER is not set
# CONFIG_MESON6_TIMER is not set
CONFIG_ORION_TIMER=y
# CONFIG_OWL_TIMER is not set
# CONFIG_RDA_TIMER is not set
CONFIG_SUN4I_TIMER=y
# CONFIG_SUN5I_HSTIMER is not set
CONFIG_TEGRA_TIMER=y
# CONFIG_VT8500_TIMER is not set
CONFIG_NPCM7XX_TIMER=y
CONFIG_CADENCE_TTC_TIMER=y
CONFIG_ASM9260_TIMER=y
CONFIG_CLKSRC_NOMADIK_MTU=y
CONFIG_CLKSRC_DBX500_PRCMU=y
CONFIG_CLPS711X_TIMER=y
CONFIG_MXS_TIMER=y
CONFIG_NSPIRE_TIMER=y
CONFIG_KEYSTONE_TIMER=y
CONFIG_INTEGRATOR_AP_TIMER=y
CONFIG_CLKSRC_LPC32XX=y
# CONFIG_CLKSRC_PISTACHIO is not set
CONFIG_CLKSRC_TI_32K=y
# CONFIG_CLKSRC_STM32 is not set
CONFIG_CLKSRC_STM32_LP=y
CONFIG_CLKSRC_MPS2=y
# CONFIG_ARC_TIMERS is not set
# CONFIG_ARM_GLOBAL_TIMER is not set
CONFIG_ARM_TIMER_SP804=y
CONFIG_ARMV7M_SYSTICK=y
# CONFIG_ATMEL_PIT is not set
CONFIG_ATMEL_ST=y
CONFIG_ATMEL_TCB_CLKSRC=y
CONFIG_CLKSRC_EXYNOS_MCT=y
CONFIG_CLKSRC_SAMSUNG_PWM=y
# CONFIG_FSL_FTM_TIMER is not set
# CONFIG_OXNAS_RPS_TIMER is not set
CONFIG_MTK_TIMER=y
CONFIG_SPRD_TIMER=y
# CONFIG_CLKSRC_JCORE_PIT is not set
CONFIG_SH_TIMER_CMT=y
# CONFIG_SH_TIMER_MTU2 is not set
# CONFIG_RENESAS_OSTM is not set
CONFIG_SH_TIMER_TMU=y
# CONFIG_EM_TIMER_STI is not set
# CONFIG_CLKSRC_QCOM is not set
# CONFIG_CLKSRC_VERSATILE is not set
CONFIG_CLKSRC_PXA=y
# CONFIG_CLKSRC_IMX_GPT is not set
CONFIG_CLKSRC_IMX_TPM=y
CONFIG_TIMER_IMX_SYS_CTR=y
# CONFIG_CLKSRC_ST_LPC is not set
CONFIG_GXP_TIMER=y
CONFIG_MILBEAUT_TIMER=y
CONFIG_MSC313E_TIMER=y
# CONFIG_INGENIC_TIMER is not set
CONFIG_INGENIC_SYSOST=y
CONFIG_INGENIC_OST=y
# CONFIG_MICROCHIP_PIT64B is not set
# end of Clock Source drivers

CONFIG_MAILBOX=y
CONFIG_ARM_MHU=y
CONFIG_ARM_MHU_V2=y
CONFIG_IMX_MBOX=y
CONFIG_PLATFORM_MHU=y
# CONFIG_PL320_MBOX is not set
CONFIG_ARMADA_37XX_RWTM_MBOX=y
CONFIG_ROCKCHIP_MBOX=y
CONFIG_ALTERA_MBOX=y
CONFIG_HI3660_MBOX=y
CONFIG_HI6220_MBOX=m
CONFIG_MAILBOX_TEST=y
CONFIG_POLARFIRE_SOC_MAILBOX=m
CONFIG_QCOM_APCS_IPC=m
# CONFIG_BCM_PDC_MBOX is not set
CONFIG_STM32_IPCC=y
# CONFIG_MTK_ADSP_MBOX is not set
CONFIG_MTK_CMDQ_MBOX=y
# CONFIG_SUN6I_MSGBOX is not set
# CONFIG_SPRD_MBOX is not set
CONFIG_QCOM_IPCC=m
CONFIG_IOMMU_IOVA=m
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
CONFIG_IOMMU_IO_PGTABLE=y
# CONFIG_IOMMU_IO_PGTABLE_LPAE is not set
CONFIG_IOMMU_IO_PGTABLE_ARMV7S=y
CONFIG_IOMMU_IO_PGTABLE_ARMV7S_SELFTEST=y
# end of Generic IOMMU Pagetable Support

CONFIG_IOMMU_DEBUGFS=y
# CONFIG_IOMMU_DEFAULT_DMA_STRICT is not set
CONFIG_IOMMU_DEFAULT_DMA_LAZY=y
# CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
CONFIG_OF_IOMMU=y
CONFIG_MSM_IOMMU=y
CONFIG_OMAP_IOMMU=y
CONFIG_OMAP_IOMMU_DEBUG=y
# CONFIG_ROCKCHIP_IOMMU is not set
CONFIG_SUN50I_IOMMU=y
# CONFIG_EXYNOS_IOMMU is not set
# CONFIG_ARM_SMMU is not set
# CONFIG_S390_CCW_IOMMU is not set
CONFIG_S390_AP_IOMMU=y
# CONFIG_MTK_IOMMU is not set
# CONFIG_MTK_IOMMU_V1 is not set
# CONFIG_SPRD_IOMMU is not set

#
# Remoteproc drivers
#
CONFIG_REMOTEPROC=y
# CONFIG_REMOTEPROC_CDEV is not set
CONFIG_INGENIC_VPU_RPROC=m
# CONFIG_MTK_SCP is not set
# CONFIG_MESON_MX_AO_ARC_REMOTEPROC is not set
# CONFIG_RCAR_REMOTEPROC is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
CONFIG_RPMSG=y
# CONFIG_RPMSG_CTRL is not set
CONFIG_RPMSG_NS=m
CONFIG_RPMSG_QCOM_GLINK=y
CONFIG_RPMSG_QCOM_GLINK_RPM=y
CONFIG_RPMSG_QCOM_GLINK_SMEM=y
# CONFIG_RPMSG_QCOM_SMD is not set
CONFIG_RPMSG_VIRTIO=m
# end of Rpmsg drivers

# CONFIG_SOUNDWIRE is not set

#
# SOC (System On Chip) specific Drivers
#
# CONFIG_OWL_PM_DOMAINS is not set

#
# Amlogic SoC drivers
#
# CONFIG_MESON_CANVAS is not set
CONFIG_MESON_CLK_MEASURE=m
CONFIG_MESON_GX_SOCINFO=y
CONFIG_MESON_GX_PM_DOMAINS=m
CONFIG_MESON_EE_PM_DOMAINS=y
# CONFIG_MESON_MX_SOCINFO is not set
# end of Amlogic SoC drivers

#
# Apple SoC drivers
#
CONFIG_APPLE_PMGR_PWRSTATE=y
CONFIG_APPLE_RTKIT=m
CONFIG_APPLE_SART=m
# end of Apple SoC drivers

#
# ASPEED SoC drivers
#
CONFIG_ASPEED_LPC_CTRL=y
# CONFIG_ASPEED_LPC_SNOOP is not set
CONFIG_ASPEED_UART_ROUTING=m
CONFIG_ASPEED_P2A_CTRL=y
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
# CONFIG_FSL_MC_DPIO is not set
# CONFIG_DPAA2_CONSOLE is not set
CONFIG_FSL_RCPM=y
# end of NXP/Freescale QorIQ SoC drivers

#
# i.MX SoC drivers
#
CONFIG_IMX_GPCV2_PM_DOMAINS=y
# CONFIG_SOC_IMX8M is not set
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
CONFIG_MTK_CMDQ=m
# CONFIG_MTK_DEVAPC is not set
CONFIG_MTK_INFRACFG=y
# CONFIG_MTK_PMIC_WRAP is not set
# CONFIG_MTK_SCPSYS is not set
# CONFIG_MTK_SCPSYS_PM_DOMAINS is not set
CONFIG_MTK_MMSYS=y
# end of MediaTek SoC drivers

CONFIG_POLARFIRE_SOC_SYS_CTRL=m
CONFIG_PLAT_PXA=y
CONFIG_PXA_SSP=m

#
# Qualcomm SoC drivers
#
CONFIG_QCOM_AOSS_QMP=y
CONFIG_QCOM_COMMAND_DB=m
CONFIG_QCOM_GENI_SE=m
# CONFIG_QCOM_GSBI is not set
CONFIG_QCOM_LLCC=y
# CONFIG_QCOM_RPMH is not set
CONFIG_QCOM_RPMPD=m
CONFIG_QCOM_SMEM=y
CONFIG_QCOM_SMD_RPM=m
CONFIG_QCOM_SMEM_STATE=y
# CONFIG_QCOM_SMP2P is not set
CONFIG_QCOM_SMSM=y
# CONFIG_QCOM_SOCINFO is not set
CONFIG_QCOM_SPM=y
CONFIG_QCOM_STATS=m
# CONFIG_QCOM_WCNSS_CTRL is not set
# end of Qualcomm SoC drivers

# CONFIG_SOC_RENESAS is not set
# CONFIG_ROCKCHIP_GRF is not set
# CONFIG_ROCKCHIP_IODOMAIN is not set
CONFIG_ROCKCHIP_PM_DOMAINS=y
CONFIG_ROCKCHIP_DTPM=m
CONFIG_SOC_SAMSUNG=y
# CONFIG_EXYNOS_ASV_ARM is not set
CONFIG_EXYNOS_CHIPID=m
# CONFIG_EXYNOS_USI is not set
# CONFIG_EXYNOS_PMU is not set
CONFIG_EXYNOS_PM_DOMAINS=y
CONFIG_EXYNOS_REGULATOR_COUPLER=y
CONFIG_SUNXI_MBUS=y
CONFIG_SUNXI_SRAM=y
# CONFIG_SOC_TEGRA20_VOLTAGE_COUPLER is not set
CONFIG_SOC_TEGRA30_VOLTAGE_COUPLER=y
CONFIG_SOC_TI=y
CONFIG_UX500_SOC_ID=y

#
# Xilinx SoC drivers
#
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=m
CONFIG_DEVFREQ_GOV_PERFORMANCE=m
CONFIG_DEVFREQ_GOV_POWERSAVE=m
CONFIG_DEVFREQ_GOV_USERSPACE=y
CONFIG_DEVFREQ_GOV_PASSIVE=m

#
# DEVFREQ Drivers
#
# CONFIG_ARM_EXYNOS_BUS_DEVFREQ is not set
# CONFIG_ARM_IMX_BUS_DEVFREQ is not set
# CONFIG_ARM_TEGRA_DEVFREQ is not set
CONFIG_ARM_SUN8I_A33_MBUS_DEVFREQ=m
CONFIG_PM_DEVFREQ_EVENT=y
# CONFIG_DEVFREQ_EVENT_EXYNOS_NOCP is not set
CONFIG_DEVFREQ_EVENT_EXYNOS_PPMU=y
# CONFIG_DEVFREQ_EVENT_ROCKCHIP_DFI is not set
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
CONFIG_EXTCON_ADC_JACK=m
CONFIG_EXTCON_FSA9480=m
# CONFIG_EXTCON_GPIO is not set
CONFIG_EXTCON_MAX14577=y
# CONFIG_EXTCON_MAX3355 is not set
# CONFIG_EXTCON_MAX77693 is not set
# CONFIG_EXTCON_MAX8997 is not set
CONFIG_EXTCON_PTN5150=y
CONFIG_EXTCON_QCOM_SPMI_MISC=m
CONFIG_EXTCON_RT8973A=y
CONFIG_EXTCON_SM5502=y
CONFIG_EXTCON_USB_GPIO=y
CONFIG_EXTCON_USBC_TUSB320=m
CONFIG_MEMORY=y
CONFIG_DDR=y
CONFIG_ARM_PL172_MPMC=m
CONFIG_ATMEL_SDRAMC=y
CONFIG_ATMEL_EBI=y
CONFIG_BRCMSTB_DPFE=y
# CONFIG_BT1_L2_CTL is not set
CONFIG_TI_AEMIF=y
CONFIG_TI_EMIF=y
CONFIG_OMAP_GPMC=y
# CONFIG_OMAP_GPMC_DEBUG is not set
# CONFIG_MVEBU_DEVBUS is not set
CONFIG_FSL_CORENET_CF=y
CONFIG_FSL_IFC=y
# CONFIG_JZ4780_NEMC is not set
CONFIG_MTK_SMI=y
# CONFIG_DA8XX_DDRCTL is not set
# CONFIG_PL353_SMC is not set
# CONFIG_RENESAS_RPCIF is not set
# CONFIG_STM32_FMC2_EBI is not set
# CONFIG_SAMSUNG_MC is not set
# CONFIG_TEGRA_MC is not set
CONFIG_IIO=y
CONFIG_IIO_BUFFER=y
CONFIG_IIO_BUFFER_CB=m
CONFIG_IIO_BUFFER_DMA=y
CONFIG_IIO_BUFFER_DMAENGINE=m
CONFIG_IIO_BUFFER_HW_CONSUMER=m
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
CONFIG_ADXL313=m
CONFIG_ADXL313_I2C=m
CONFIG_ADXL345=m
CONFIG_ADXL345_I2C=m
CONFIG_ADXL355=y
CONFIG_ADXL355_I2C=y
# CONFIG_ADXL367_I2C is not set
CONFIG_ADXL372=m
CONFIG_ADXL372_I2C=m
CONFIG_BMA180=y
CONFIG_BMA400=y
CONFIG_BMA400_I2C=y
CONFIG_BMC150_ACCEL=y
CONFIG_BMC150_ACCEL_I2C=y
CONFIG_DA280=m
CONFIG_DA311=y
CONFIG_DMARD06=y
CONFIG_DMARD09=m
CONFIG_DMARD10=y
CONFIG_FXLS8962AF=y
CONFIG_FXLS8962AF_I2C=y
CONFIG_IIO_ST_ACCEL_3AXIS=m
CONFIG_IIO_ST_ACCEL_I2C_3AXIS=m
CONFIG_KXSD9=m
CONFIG_KXSD9_I2C=m
CONFIG_KXCJK1013=m
CONFIG_MC3230=y
CONFIG_MMA7455=m
CONFIG_MMA7455_I2C=m
CONFIG_MMA7660=y
CONFIG_MMA8452=m
# CONFIG_MMA9551 is not set
# CONFIG_MMA9553 is not set
# CONFIG_MXC4005 is not set
CONFIG_MXC6255=m
CONFIG_STK8312=m
# CONFIG_STK8BA50 is not set
# end of Accelerometers

#
# Analog to digital converters
#
CONFIG_AD7091R5=y
# CONFIG_AD7291 is not set
CONFIG_AD7606=y
CONFIG_AD7606_IFACE_PARALLEL=y
CONFIG_AD799X=y
CONFIG_ADI_AXI_ADC=m
CONFIG_ASPEED_ADC=m
CONFIG_AT91_ADC=m
CONFIG_AT91_SAMA5D2_ADC=y
CONFIG_AXP20X_ADC=m
CONFIG_AXP288_ADC=m
CONFIG_BCM_IPROC_ADC=y
CONFIG_BERLIN2_ADC=y
# CONFIG_CC10001_ADC is not set
CONFIG_DA9150_GPADC=m
CONFIG_DLN2_ADC=m
CONFIG_ENVELOPE_DETECTOR=y
CONFIG_EXYNOS_ADC=m
CONFIG_MXS_LRADC_ADC=m
# CONFIG_HX711 is not set
# CONFIG_INA2XX_ADC is not set
# CONFIG_INGENIC_ADC is not set
CONFIG_IMX7D_ADC=m
CONFIG_IMX8QXP_ADC=y
CONFIG_LP8788_ADC=y
# CONFIG_LPC18XX_ADC is not set
CONFIG_LPC32XX_ADC=m
CONFIG_LTC2471=m
CONFIG_LTC2485=y
# CONFIG_LTC2497 is not set
CONFIG_MAX1363=m
CONFIG_MAX9611=y
CONFIG_MCP3422=y
CONFIG_MEDIATEK_MT6360_ADC=y
# CONFIG_MEDIATEK_MT6577_AUXADC is not set
CONFIG_MEN_Z188_ADC=m
CONFIG_MESON_SARADC=y
CONFIG_MP2629_ADC=m
# CONFIG_NAU7802 is not set
CONFIG_NPCM_ADC=m
CONFIG_QCOM_VADC_COMMON=m
CONFIG_QCOM_PM8XXX_XOADC=m
CONFIG_RCAR_GYRO_ADC=m
CONFIG_RN5T618_ADC=y
CONFIG_ROCKCHIP_SARADC=y
CONFIG_RZG2L_ADC=m
CONFIG_SC27XX_ADC=y
CONFIG_SPEAR_ADC=m
CONFIG_SD_ADC_MODULATOR=y
# CONFIG_STM32_ADC_CORE is not set
CONFIG_STM32_DFSDM_CORE=m
CONFIG_STM32_DFSDM_ADC=m
# CONFIG_STMPE_ADC is not set
CONFIG_SUN4I_GPADC=m
CONFIG_TI_ADC081C=y
CONFIG_TI_ADS1015=y
# CONFIG_TI_AM335X_ADC is not set
CONFIG_TWL4030_MADC=m
CONFIG_TWL6030_GPADC=m
# CONFIG_VF610_ADC is not set
CONFIG_XILINX_XADC=m
CONFIG_XILINX_AMS=y
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
CONFIG_ATLAS_PH_SENSOR=m
CONFIG_ATLAS_EZO_SENSOR=y
# CONFIG_BME680 is not set
CONFIG_CCS811=y
# CONFIG_IAQCORE is not set
# CONFIG_SCD30_CORE is not set
CONFIG_SCD4X=y
CONFIG_SENSIRION_SGP30=m
# CONFIG_SENSIRION_SGP40 is not set
CONFIG_SPS30=y
CONFIG_SPS30_I2C=y
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
# CONFIG_IIO_SCMI is not set
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
# CONFIG_AD5064 is not set
# CONFIG_AD5380 is not set
CONFIG_AD5446=m
CONFIG_AD5592R_BASE=y
CONFIG_AD5593R=y
CONFIG_AD5686=y
CONFIG_AD5696_I2C=y
CONFIG_DPOT_DAC=m
CONFIG_DS4424=m
# CONFIG_LPC18XX_DAC is not set
CONFIG_M62332=m
CONFIG_MAX517=m
# CONFIG_MAX5821 is not set
# CONFIG_MCP4725 is not set
# CONFIG_STM32_DAC is not set
# CONFIG_TI_DAC5571 is not set
CONFIG_VF610_DAC=y
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
CONFIG_BMG160=y
CONFIG_BMG160_I2C=y
CONFIG_FXAS21002C=m
CONFIG_FXAS21002C_I2C=m
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
# CONFIG_AFE4404 is not set
# CONFIG_MAX30100 is not set
CONFIG_MAX30102=y
# end of Heart Rate Monitors
# end of Health Sensors

#
# Humidity sensors
#
# CONFIG_AM2315 is not set
# CONFIG_DHT11 is not set
CONFIG_HDC100X=m
CONFIG_HDC2010=m
CONFIG_HTS221=y
CONFIG_HTS221_I2C=y
CONFIG_HTU21=m
CONFIG_SI7005=m
CONFIG_SI7020=m
# end of Humidity sensors

#
# Inertial measurement units
#
CONFIG_BMI160=m
CONFIG_BMI160_I2C=m
CONFIG_FXOS8700=y
CONFIG_FXOS8700_I2C=y
CONFIG_KMX61=y
# CONFIG_INV_ICM42600_I2C is not set
CONFIG_INV_MPU6050_IIO=m
CONFIG_INV_MPU6050_I2C=m
# CONFIG_IIO_ST_LSM6DSX is not set
CONFIG_IIO_ST_LSM9DS0=m
# CONFIG_IIO_ST_LSM9DS0_I2C is not set
# end of Inertial measurement units

#
# Light sensors
#
CONFIG_ADJD_S311=m
CONFIG_ADUX1020=m
# CONFIG_AL3010 is not set
# CONFIG_AL3320A is not set
CONFIG_APDS9300=m
CONFIG_APDS9960=m
# CONFIG_AS73211 is not set
CONFIG_BH1750=y
CONFIG_BH1780=y
CONFIG_CM32181=m
# CONFIG_CM3232 is not set
CONFIG_CM3323=m
CONFIG_CM3605=m
# CONFIG_CM36651 is not set
# CONFIG_GP2AP002 is not set
CONFIG_GP2AP020A00F=y
CONFIG_IQS621_ALS=y
CONFIG_SENSORS_ISL29018=m
CONFIG_SENSORS_ISL29028=y
CONFIG_ISL29125=y
CONFIG_JSA1212=y
CONFIG_RPR0521=y
CONFIG_SENSORS_LM3533=m
CONFIG_LTR501=m
# CONFIG_LV0104CS is not set
CONFIG_MAX44000=y
# CONFIG_MAX44009 is not set
CONFIG_NOA1305=y
CONFIG_OPT3001=m
# CONFIG_PA12203001 is not set
CONFIG_SI1133=y
CONFIG_SI1145=m
# CONFIG_STK3310 is not set
CONFIG_ST_UVIS25=m
CONFIG_ST_UVIS25_I2C=m
CONFIG_TCS3414=y
# CONFIG_TCS3472 is not set
# CONFIG_SENSORS_TSL2563 is not set
CONFIG_TSL2583=m
CONFIG_TSL2591=m
CONFIG_TSL2772=m
CONFIG_TSL4531=y
CONFIG_US5182D=y
CONFIG_VCNL4000=y
# CONFIG_VCNL4035 is not set
CONFIG_VEML6030=m
CONFIG_VEML6070=y
CONFIG_VL6180=y
CONFIG_ZOPT2201=m
# end of Light sensors

#
# Magnetometer sensors
#
# CONFIG_AK8974 is not set
CONFIG_AK8975=m
CONFIG_AK09911=m
CONFIG_BMC150_MAGN=y
CONFIG_BMC150_MAGN_I2C=y
CONFIG_MAG3110=m
# CONFIG_MMC35240 is not set
CONFIG_IIO_ST_MAGN_3AXIS=y
CONFIG_IIO_ST_MAGN_I2C_3AXIS=y
CONFIG_SENSORS_HMC5843=m
CONFIG_SENSORS_HMC5843_I2C=m
CONFIG_SENSORS_RM3100=m
CONFIG_SENSORS_RM3100_I2C=m
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

CONFIG_IIO_RESCALE_KUNIT_TEST=y
# CONFIG_IIO_TEST_FORMAT is not set

#
# Triggers - standalone
#
CONFIG_IIO_HRTIMER_TRIGGER=m
# CONFIG_IIO_INTERRUPT_TRIGGER is not set
CONFIG_IIO_STM32_LPTIMER_TRIGGER=y
# CONFIG_IIO_STM32_TIMER_TRIGGER is not set
CONFIG_IIO_TIGHTLOOP_TRIGGER=m
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
CONFIG_AD5110=y
CONFIG_AD5272=y
CONFIG_DS1803=m
CONFIG_MAX5432=m
CONFIG_MCP4018=m
CONFIG_MCP4531=y
CONFIG_TPL0102=y
# end of Digital potentiometers

#
# Digital potentiostats
#
# CONFIG_LMP91000 is not set
# end of Digital potentiostats

#
# Pressure sensors
#
CONFIG_ABP060MG=m
# CONFIG_BMP280 is not set
# CONFIG_DLHL60D is not set
# CONFIG_DPS310 is not set
# CONFIG_HP03 is not set
CONFIG_ICP10100=m
CONFIG_MPL115=y
CONFIG_MPL115_I2C=y
CONFIG_MPL3115=m
CONFIG_MS5611=y
# CONFIG_MS5611_I2C is not set
CONFIG_MS5637=m
CONFIG_IIO_ST_PRESS=y
CONFIG_IIO_ST_PRESS_I2C=m
# CONFIG_T5403 is not set
CONFIG_HP206C=y
CONFIG_ZPA2326=y
CONFIG_ZPA2326_I2C=y
# end of Pressure sensors

#
# Lightning sensors
#
# end of Lightning sensors

#
# Proximity and distance sensors
#
# CONFIG_ISL29501 is not set
CONFIG_LIDAR_LITE_V2=y
# CONFIG_MB1232 is not set
CONFIG_PING=m
CONFIG_RFD77402=y
# CONFIG_SRF04 is not set
CONFIG_SX_COMMON=y
CONFIG_SX9310=m
CONFIG_SX9324=y
CONFIG_SX9360=y
CONFIG_SX9500=m
CONFIG_SRF08=y
CONFIG_VCNL3020=m
# CONFIG_VL53L0X_I2C is not set
# end of Proximity and distance sensors

#
# Resolver to digital converters
#
# end of Resolver to digital converters

#
# Temperature sensors
#
CONFIG_IQS620AT_TEMP=y
CONFIG_MLX90614=m
# CONFIG_MLX90632 is not set
CONFIG_TMP006=m
# CONFIG_TMP007 is not set
# CONFIG_TMP117 is not set
# CONFIG_TSYS01 is not set
CONFIG_TSYS02D=y
# end of Temperature sensors

CONFIG_NTB=y
CONFIG_NTB_IDT=y
CONFIG_NTB_EPF=m
# CONFIG_NTB_SWITCHTEC is not set
CONFIG_NTB_PINGPONG=y
CONFIG_NTB_TOOL=y
CONFIG_NTB_PERF=y
CONFIG_NTB_TRANSPORT=m
CONFIG_VME_BUS=y

#
# VME Bridge Drivers
#
# CONFIG_VME_TSI148 is not set
# CONFIG_VME_FAKE is not set

#
# VME Board Drivers
#
# CONFIG_VMIVME_7805 is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
CONFIG_PWM_DEBUG=y
CONFIG_PWM_ATMEL=y
# CONFIG_PWM_ATMEL_HLCDC_PWM is not set
CONFIG_PWM_ATMEL_TCB=y
# CONFIG_PWM_BCM_IPROC is not set
CONFIG_PWM_BCM_KONA=m
CONFIG_PWM_BCM2835=m
CONFIG_PWM_BERLIN=m
CONFIG_PWM_BRCMSTB=m
CONFIG_PWM_CLPS711X=y
# CONFIG_PWM_DWC is not set
# CONFIG_PWM_EP93XX is not set
CONFIG_PWM_FSL_FTM=m
CONFIG_PWM_HIBVT=y
# CONFIG_PWM_IMG is not set
CONFIG_PWM_IMX1=y
CONFIG_PWM_IMX27=m
# CONFIG_PWM_IMX_TPM is not set
CONFIG_PWM_INTEL_LGM=y
CONFIG_PWM_IQS620A=y
CONFIG_PWM_JZ4740=m
CONFIG_PWM_KEEMBAY=m
CONFIG_PWM_LPC18XX_SCT=y
# CONFIG_PWM_LPC32XX is not set
CONFIG_PWM_LPSS=y
CONFIG_PWM_LPSS_PCI=y
CONFIG_PWM_LPSS_PLATFORM=y
# CONFIG_PWM_MESON is not set
CONFIG_PWM_MTK_DISP=y
CONFIG_PWM_MEDIATEK=m
CONFIG_PWM_MXS=y
CONFIG_PWM_OMAP_DMTIMER=m
CONFIG_PWM_PCA9685=m
CONFIG_PWM_PXA=m
CONFIG_PWM_RASPBERRYPI_POE=y
# CONFIG_PWM_RCAR is not set
CONFIG_PWM_RENESAS_TPU=m
CONFIG_PWM_ROCKCHIP=y
CONFIG_PWM_SAMSUNG=y
CONFIG_PWM_SIFIVE=y
# CONFIG_PWM_SL28CPLD is not set
CONFIG_PWM_SPEAR=y
CONFIG_PWM_SPRD=m
CONFIG_PWM_STI=y
CONFIG_PWM_STM32=y
CONFIG_PWM_STM32_LP=m
CONFIG_PWM_STMPE=y
CONFIG_PWM_SUN4I=y
CONFIG_PWM_SUNPLUS=y
CONFIG_PWM_TEGRA=y
CONFIG_PWM_TIECAP=y
# CONFIG_PWM_TIEHRPWM is not set
# CONFIG_PWM_TWL is not set
CONFIG_PWM_TWL_LED=m
CONFIG_PWM_VISCONTI=m
# CONFIG_PWM_VT8500 is not set
CONFIG_PWM_XILINX=y

#
# IRQ chip support
#
CONFIG_IRQCHIP=y
CONFIG_ARM_VIC=y
CONFIG_ARM_VIC_NR=2
CONFIG_AL_FIC=y
CONFIG_ATMEL_AIC_IRQ=y
CONFIG_FARADAY_FTINTC010=y
CONFIG_MADERA_IRQ=m
CONFIG_CLPS711X_IRQCHIP=y
CONFIG_ORION_IRQCHIP=y
# CONFIG_JCORE_AIC is not set
# CONFIG_RENESAS_INTC_IRQPIN is not set
CONFIG_RENESAS_IRQC=y
# CONFIG_RENESAS_RZA1_IRQC is not set
# CONFIG_SL28CPLD_INTC is not set
CONFIG_TS4800_IRQ=y
CONFIG_XILINX_INTC=y
# CONFIG_INGENIC_TCU_IRQ is not set
CONFIG_IRQ_MXS=y
# CONFIG_IRQ_UNIPHIER_AIDET is not set
CONFIG_MESON_IRQ_GPIO=y
CONFIG_IMX_IRQSTEER=y
CONFIG_IMX_INTMUX=y
CONFIG_EXYNOS_IRQ_COMBINER=y
# CONFIG_LOONGSON_PCH_PIC is not set
# CONFIG_LOONGSON_PCH_MSI is not set
# CONFIG_MST_IRQ is not set
CONFIG_WPCM450_AIC=y
CONFIG_MCHP_EIC=y
# end of IRQ chip support

CONFIG_IPACK_BUS=y
# CONFIG_BOARD_TPCI200 is not set
CONFIG_ARCH_HAS_RESET_CONTROLLER=y
CONFIG_RESET_CONTROLLER=y
# CONFIG_RESET_ATH79 is not set
# CONFIG_RESET_AXS10X is not set
CONFIG_RESET_BCM6345=y
# CONFIG_RESET_BERLIN is not set
CONFIG_RESET_BRCMSTB=m
CONFIG_RESET_BRCMSTB_RESCAL=y
CONFIG_RESET_HSDK=y
CONFIG_RESET_IMX7=y
# CONFIG_RESET_INTEL_GW is not set
CONFIG_RESET_K210=y
CONFIG_RESET_LANTIQ=y
# CONFIG_RESET_LPC18XX is not set
# CONFIG_RESET_MCHP_SPARX5 is not set
# CONFIG_RESET_MESON is not set
CONFIG_RESET_MESON_AUDIO_ARB=y
CONFIG_RESET_NPCM=y
# CONFIG_RESET_PISTACHIO is not set
CONFIG_RESET_QCOM_AOSS=m
CONFIG_RESET_QCOM_PDC=m
# CONFIG_RESET_RASPBERRYPI is not set
# CONFIG_RESET_RZG2L_USBPHY_CTRL is not set
CONFIG_RESET_SCMI=m
CONFIG_RESET_SIMPLE=y
# CONFIG_RESET_SOCFPGA is not set
# CONFIG_RESET_STARFIVE_JH7100 is not set
CONFIG_RESET_SUNXI=y
CONFIG_RESET_TI_SCI=y
# CONFIG_RESET_TI_SYSCON is not set
CONFIG_RESET_TN48M_CPLD=y
CONFIG_RESET_UNIPHIER=m
# CONFIG_RESET_UNIPHIER_GLUE is not set
CONFIG_RESET_ZYNQ=y
CONFIG_COMMON_RESET_HI3660=y
# CONFIG_COMMON_RESET_HI6220 is not set

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
CONFIG_GENERIC_PHY_MIPI_DPHY=y
CONFIG_PHY_LPC18XX_USB_OTG=m
CONFIG_PHY_PISTACHIO_USB=m
CONFIG_PHY_XGENE=m
# CONFIG_USB_LGM_PHY is not set
# CONFIG_PHY_CAN_TRANSCEIVER is not set
# CONFIG_PHY_SUN4I_USB is not set
CONFIG_PHY_SUN6I_MIPI_DPHY=y
CONFIG_PHY_SUN9I_USB=m
CONFIG_PHY_SUN50I_USB3=m
CONFIG_PHY_MESON8_HDMI_TX=m
# CONFIG_PHY_MESON8B_USB2 is not set
CONFIG_PHY_MESON_GXL_USB2=m
# CONFIG_PHY_MESON_G12A_USB2 is not set
# CONFIG_PHY_MESON_G12A_USB3_PCIE is not set
CONFIG_PHY_MESON_AXG_PCIE=y
# CONFIG_PHY_MESON_AXG_MIPI_PCIE_ANALOG is not set
CONFIG_PHY_MESON_AXG_MIPI_DPHY=m

#
# PHY drivers for Broadcom platforms
#
CONFIG_PHY_BCM63XX_USBH=y
CONFIG_PHY_CYGNUS_PCIE=y
# CONFIG_PHY_BCM_SR_USB is not set
CONFIG_BCM_KONA_USB2_PHY=m
CONFIG_PHY_BCM_NS_USB2=m
CONFIG_PHY_NS2_USB_DRD=y
CONFIG_PHY_BRCM_SATA=y
CONFIG_PHY_BRCM_USB=y
CONFIG_PHY_BCM_SR_PCIE=m
# end of PHY drivers for Broadcom platforms

CONFIG_PHY_CADENCE_TORRENT=y
CONFIG_PHY_CADENCE_DPHY=y
CONFIG_PHY_CADENCE_DPHY_RX=m
# CONFIG_PHY_CADENCE_SIERRA is not set
# CONFIG_PHY_CADENCE_SALVO is not set
# CONFIG_PHY_FSL_IMX8MQ_USB is not set
CONFIG_PHY_MIXEL_MIPI_DPHY=y
# CONFIG_PHY_FSL_IMX8M_PCIE is not set
# CONFIG_PHY_FSL_LYNX_28G is not set
# CONFIG_PHY_HI6220_USB is not set
# CONFIG_PHY_HI3660_USB is not set
CONFIG_PHY_HI3670_USB=m
CONFIG_PHY_HI3670_PCIE=y
CONFIG_PHY_HISTB_COMBPHY=y
CONFIG_PHY_HISI_INNO_USB2=m
CONFIG_PHY_INGENIC_USB=y
# CONFIG_PHY_LANTIQ_VRX200_PCIE is not set
CONFIG_PHY_LANTIQ_RCU_USB2=y
CONFIG_ARMADA375_USBCLUSTER_PHY=y
# CONFIG_PHY_BERLIN_SATA is not set
# CONFIG_PHY_BERLIN_USB is not set
CONFIG_PHY_MVEBU_A3700_UTMI=y
CONFIG_PHY_MVEBU_A38X_COMPHY=y
CONFIG_PHY_MVEBU_CP110_UTMI=m
# CONFIG_PHY_PXA_28NM_HSIC is not set
CONFIG_PHY_PXA_28NM_USB2=y
# CONFIG_PHY_PXA_USB is not set
CONFIG_PHY_MMP3_USB=m
CONFIG_PHY_MMP3_HSIC=m
# CONFIG_PHY_MTK_TPHY is not set
CONFIG_PHY_MTK_UFS=m
CONFIG_PHY_MTK_XSPHY=y
# CONFIG_PHY_MTK_HDMI is not set
# CONFIG_PHY_MTK_MIPI_DSI is not set
CONFIG_PHY_SPARX5_SERDES=m
# CONFIG_PHY_LAN966X_SERDES is not set
CONFIG_PHY_CPCAP_USB=m
CONFIG_PHY_MAPPHONE_MDM6600=m
# CONFIG_PHY_OCELOT_SERDES is not set
CONFIG_PHY_ATH79_USB=m
CONFIG_PHY_QCOM_EDP=m
CONFIG_PHY_QCOM_IPQ4019_USB=m
CONFIG_PHY_QCOM_PCIE2=y
CONFIG_PHY_QCOM_QMP=y
# CONFIG_PHY_QCOM_QUSB2 is not set
CONFIG_PHY_QCOM_USB_HS=y
CONFIG_PHY_QCOM_USB_SNPS_FEMTO_V2=m
# CONFIG_PHY_QCOM_USB_HSIC is not set
# CONFIG_PHY_QCOM_USB_HS_28NM is not set
CONFIG_PHY_QCOM_USB_SS=m
CONFIG_PHY_QCOM_IPQ806X_USB=m
CONFIG_PHY_MT7621_PCI=y
CONFIG_PHY_RALINK_USB=m
# CONFIG_PHY_RCAR_GEN3_USB3 is not set
CONFIG_PHY_ROCKCHIP_DPHY_RX0=m
CONFIG_PHY_ROCKCHIP_INNO_HDMI=y
CONFIG_PHY_ROCKCHIP_INNO_USB2=m
# CONFIG_PHY_ROCKCHIP_INNO_CSIDPHY is not set
# CONFIG_PHY_ROCKCHIP_INNO_DSIDPHY is not set
CONFIG_PHY_ROCKCHIP_PCIE=m
CONFIG_PHY_ROCKCHIP_TYPEC=m
CONFIG_PHY_EXYNOS_DP_VIDEO=y
# CONFIG_PHY_EXYNOS_MIPI_VIDEO is not set
CONFIG_PHY_EXYNOS_PCIE=y
CONFIG_PHY_SAMSUNG_UFS=y
# CONFIG_PHY_SAMSUNG_USB2 is not set
CONFIG_PHY_UNIPHIER_USB2=y
CONFIG_PHY_UNIPHIER_USB3=y
CONFIG_PHY_UNIPHIER_PCIE=y
# CONFIG_PHY_UNIPHIER_AHCI is not set
CONFIG_PHY_ST_SPEAR1310_MIPHY=m
# CONFIG_PHY_ST_SPEAR1340_MIPHY is not set
# CONFIG_PHY_STIH407_USB is not set
# CONFIG_PHY_STM32_USBPHYC is not set
CONFIG_PHY_TEGRA194_P2U=y
CONFIG_PHY_DA8XX_USB=m
# CONFIG_PHY_DM816X_USB is not set
CONFIG_PHY_AM654_SERDES=m
CONFIG_PHY_J721E_WIZ=y
CONFIG_OMAP_CONTROL_PHY=y
# CONFIG_TI_PIPE3 is not set
CONFIG_PHY_TUSB1210=m
# CONFIG_PHY_INTEL_KEEMBAY_EMMC is not set
CONFIG_PHY_INTEL_KEEMBAY_USB=m
# CONFIG_PHY_INTEL_LGM_COMBO is not set
CONFIG_PHY_INTEL_LGM_EMMC=y
CONFIG_PHY_INTEL_THUNDERBAY_EMMC=y
CONFIG_PHY_XILINX_ZYNQMP=m
# end of PHY Subsystem

CONFIG_POWERCAP=y
CONFIG_DTPM=y
CONFIG_MCB=y
CONFIG_MCB_PCI=y
CONFIG_MCB_LPC=y

#
# Performance monitor support
#
CONFIG_ARM_CCN=y
CONFIG_ARM_CMN=y
CONFIG_ARM_PMU=y
CONFIG_FSL_IMX8_DDR_PMU=m
# CONFIG_ARM_DMC620_PMU is not set
# end of Performance monitor support

# CONFIG_RAS is not set
CONFIG_USB4=y
# CONFIG_USB4_DEBUGFS_WRITE is not set
CONFIG_USB4_KUNIT_TEST=y
CONFIG_USB4_DMA_TEST=y

#
# Android
#
# CONFIG_ANDROID is not set
# end of Android

# CONFIG_DAX is not set
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y
CONFIG_NVMEM_IMX_IIM=m
CONFIG_NVMEM_IMX_OCOTP=m
# CONFIG_JZ4780_EFUSE is not set
CONFIG_NVMEM_LPC18XX_EEPROM=m
CONFIG_NVMEM_LPC18XX_OTP=m
CONFIG_NVMEM_MXS_OCOTP=m
# CONFIG_MTK_EFUSE is not set
CONFIG_NVMEM_NINTENDO_OTP=y
# CONFIG_QCOM_QFPROM is not set
# CONFIG_ROCKCHIP_EFUSE is not set
# CONFIG_ROCKCHIP_OTP is not set
# CONFIG_NVMEM_BCM_OCOTP is not set
CONFIG_NVMEM_STM32_ROMEM=y
CONFIG_NVMEM_SUNXI_SID=m
# CONFIG_UNIPHIER_EFUSE is not set
CONFIG_NVMEM_VF610_OCOTP=m
# CONFIG_MESON_MX_EFUSE is not set
# CONFIG_NVMEM_SNVS_LPGPR is not set
# CONFIG_SC27XX_EFUSE is not set
# CONFIG_SPRD_EFUSE is not set
CONFIG_NVMEM_RMEM=y
CONFIG_NVMEM_BRCM_NVRAM=m
# CONFIG_NVMEM_LAYERSCAPE_SFP is not set
CONFIG_NVMEM_SUNPLUS_OCOTP=y
CONFIG_NVMEM_APPLE_EFUSES=y

#
# HW tracing support
#
# CONFIG_STM is not set
CONFIG_INTEL_TH=m
# CONFIG_INTEL_TH_PCI is not set
CONFIG_INTEL_TH_GTH=m
# CONFIG_INTEL_TH_MSU is not set
# CONFIG_INTEL_TH_PTI is not set
CONFIG_INTEL_TH_DEBUG=y
# end of HW tracing support

# CONFIG_FPGA is not set
# CONFIG_FSI is not set
CONFIG_TEE=y
CONFIG_MULTIPLEXER=y

#
# Multiplexer drivers
#
# CONFIG_MUX_ADG792A is not set
# CONFIG_MUX_GPIO is not set
CONFIG_MUX_MMIO=y
# end of Multiplexer drivers

CONFIG_PM_OPP=y
CONFIG_SIOX=m
CONFIG_SIOX_BUS_GPIO=m
CONFIG_SLIMBUS=y
CONFIG_SLIM_QCOM_CTRL=m
CONFIG_INTERCONNECT=y
# CONFIG_INTERCONNECT_IMX is not set
# CONFIG_INTERCONNECT_QCOM_OSM_L3 is not set
# CONFIG_INTERCONNECT_SAMSUNG is not set
CONFIG_COUNTER=y
CONFIG_104_QUAD_8=m
CONFIG_INTERRUPT_CNT=m
CONFIG_STM32_TIMER_CNT=m
CONFIG_STM32_LPTIMER_CNT=y
CONFIG_TI_EQEP=m
CONFIG_FTM_QUADDEC=y
# CONFIG_MICROCHIP_TCB_CAPTURE is not set
CONFIG_INTEL_QEP=y
CONFIG_MOST=m
CONFIG_MOST_USB_HDM=m
# CONFIG_MOST_CDEV is not set
CONFIG_MOST_SND=m
CONFIG_PECI=y
CONFIG_PECI_CPU=y
CONFIG_PECI_ASPEED=y
CONFIG_HTE=y
# end of Device Drivers

#
# File systems
#
CONFIG_VALIDATE_FS_PARSER=y
CONFIG_FS_IOMAP=y
# CONFIG_EXT2_FS is not set
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_POSIX_ACL=y
# CONFIG_EXT3_FS_SECURITY is not set
CONFIG_EXT4_FS=y
# CONFIG_EXT4_USE_FOR_EXT2 is not set
CONFIG_EXT4_FS_POSIX_ACL=y
# CONFIG_EXT4_FS_SECURITY is not set
# CONFIG_EXT4_DEBUG is not set
CONFIG_EXT4_KUNIT_TESTS=y
CONFIG_JBD2=y
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
CONFIG_JFS_FS=m
# CONFIG_JFS_POSIX_ACL is not set
CONFIG_JFS_SECURITY=y
# CONFIG_JFS_DEBUG is not set
# CONFIG_JFS_STATISTICS is not set
# CONFIG_XFS_FS is not set
CONFIG_GFS2_FS=m
# CONFIG_BTRFS_FS is not set
CONFIG_NILFS2_FS=m
CONFIG_F2FS_FS=m
CONFIG_F2FS_STAT_FS=y
CONFIG_F2FS_FS_XATTR=y
CONFIG_F2FS_FS_POSIX_ACL=y
CONFIG_F2FS_FS_SECURITY=y
# CONFIG_F2FS_CHECK_FS is not set
# CONFIG_F2FS_FAULT_INJECTION is not set
CONFIG_F2FS_FS_COMPRESSION=y
CONFIG_F2FS_FS_LZO=y
CONFIG_F2FS_FS_LZORLE=y
CONFIG_F2FS_FS_LZ4=y
CONFIG_F2FS_FS_LZ4HC=y
CONFIG_F2FS_FS_ZSTD=y
CONFIG_F2FS_IOSTAT=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
# CONFIG_FS_ENCRYPTION is not set
CONFIG_FS_VERITY=y
CONFIG_FS_VERITY_DEBUG=y
# CONFIG_FS_VERITY_BUILTIN_SIGNATURES is not set
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
# CONFIG_QUOTA is not set
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=m
CONFIG_AUTOFS_FS=m
CONFIG_FUSE_FS=y
CONFIG_CUSE=y
CONFIG_VIRTIO_FS=y
CONFIG_OVERLAY_FS=y
CONFIG_OVERLAY_FS_REDIRECT_DIR=y
# CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
# CONFIG_OVERLAY_FS_INDEX is not set
CONFIG_OVERLAY_FS_METACOPY=y

#
# Caches
#
CONFIG_NETFS_SUPPORT=y
CONFIG_NETFS_STATS=y
CONFIG_FSCACHE=y
CONFIG_FSCACHE_STATS=y
CONFIG_FSCACHE_DEBUG=y
CONFIG_CACHEFILES=y
CONFIG_CACHEFILES_DEBUG=y
CONFIG_CACHEFILES_ONDEMAND=y
# end of Caches

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
# CONFIG_ZISOFS is not set
CONFIG_UDF_FS=y
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/EXFAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
# CONFIG_FAT_DEFAULT_UTF8 is not set
CONFIG_FAT_KUNIT_TEST=y
# CONFIG_EXFAT_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_NTFS3_FS is not set
# end of DOS/FAT/EXFAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_PROC_SYSCTL is not set
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_CONFIGFS_FS=y
CONFIG_EFIVAR_FS=y
# end of Pseudo filesystems

# CONFIG_MISC_FILESYSTEMS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
# CONFIG_NLS_CODEPAGE_737 is not set
CONFIG_NLS_CODEPAGE_775=m
# CONFIG_NLS_CODEPAGE_850 is not set
CONFIG_NLS_CODEPAGE_852=y
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=y
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
# CONFIG_NLS_CODEPAGE_866 is not set
CONFIG_NLS_CODEPAGE_869=y
CONFIG_NLS_CODEPAGE_936=m
# CONFIG_NLS_CODEPAGE_950 is not set
CONFIG_NLS_CODEPAGE_932=y
# CONFIG_NLS_CODEPAGE_949 is not set
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
# CONFIG_NLS_CODEPAGE_1250 is not set
CONFIG_NLS_CODEPAGE_1251=m
# CONFIG_NLS_ASCII is not set
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=y
# CONFIG_NLS_ISO8859_4 is not set
CONFIG_NLS_ISO8859_5=y
# CONFIG_NLS_ISO8859_6 is not set
CONFIG_NLS_ISO8859_7=y
# CONFIG_NLS_ISO8859_9 is not set
CONFIG_NLS_ISO8859_13=y
CONFIG_NLS_ISO8859_14=y
# CONFIG_NLS_ISO8859_15 is not set
CONFIG_NLS_KOI8_R=y
CONFIG_NLS_KOI8_U=y
CONFIG_NLS_MAC_ROMAN=y
# CONFIG_NLS_MAC_CELTIC is not set
# CONFIG_NLS_MAC_CENTEURO is not set
# CONFIG_NLS_MAC_CROATIAN is not set
# CONFIG_NLS_MAC_CYRILLIC is not set
# CONFIG_NLS_MAC_GAELIC is not set
CONFIG_NLS_MAC_GREEK=y
CONFIG_NLS_MAC_ICELAND=y
CONFIG_NLS_MAC_INUIT=y
# CONFIG_NLS_MAC_ROMANIAN is not set
CONFIG_NLS_MAC_TURKISH=y
CONFIG_NLS_UTF8=m
CONFIG_UNICODE=m
CONFIG_UNICODE_NORMALIZATION_SELFTEST=m
CONFIG_IO_WQ=y
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_KEYS_REQUEST_CACHE is not set
# CONFIG_PERSISTENT_KEYRINGS is not set
CONFIG_TRUSTED_KEYS=m
# CONFIG_TRUSTED_KEYS_TEE is not set

#
# No trust source selected!
#
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_USER_DECRYPTED_DATA is not set
CONFIG_KEY_DH_OPERATIONS=y
# CONFIG_KEY_NOTIFICATIONS is not set
CONFIG_SECURITY_DMESG_RESTRICT=y
# CONFIG_SECURITYFS is not set
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
# CONFIG_FORTIFY_SOURCE is not set
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
# CONFIG_INIT_STACK_NONE is not set
CONFIG_INIT_STACK_ALL_PATTERN=y
# CONFIG_INIT_STACK_ALL_ZERO is not set
CONFIG_INIT_ON_ALLOC_DEFAULT_ON=y
CONFIG_INIT_ON_FREE_DEFAULT_ON=y
CONFIG_CC_HAS_ZERO_CALL_USED_REGS=y
CONFIG_ZERO_CALL_USED_REGS=y
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
CONFIG_CRYPTO_AEAD=m
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
# CONFIG_CRYPTO_MANAGER_DISABLE_TESTS is not set
# CONFIG_CRYPTO_MANAGER_EXTRA_TESTS is not set
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=m
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_CRYPTD=m
CONFIG_CRYPTO_AUTHENC=m
CONFIG_CRYPTO_TEST=m

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
CONFIG_CRYPTO_SM2=y
# CONFIG_CRYPTO_CURVE25519 is not set

#
# Authenticated Encryption with Associated Data
#
# CONFIG_CRYPTO_CCM is not set
# CONFIG_CRYPTO_GCM is not set
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_AEGIS128=m
CONFIG_CRYPTO_SEQIV=m
CONFIG_CRYPTO_ECHAINIV=m

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
# CONFIG_CRYPTO_CFB is not set
CONFIG_CRYPTO_CTR=y
# CONFIG_CRYPTO_CTS is not set
CONFIG_CRYPTO_ECB=m
# CONFIG_CRYPTO_LRW is not set
# CONFIG_CRYPTO_OFB is not set
# CONFIG_CRYPTO_PCBC is not set
CONFIG_CRYPTO_XTS=m
CONFIG_CRYPTO_KEYWRAP=y
CONFIG_CRYPTO_NHPOLY1305=y
CONFIG_CRYPTO_ADIANTUM=y
CONFIG_CRYPTO_ESSIV=m

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=m
# CONFIG_CRYPTO_VMAC is not set

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32=m
# CONFIG_CRYPTO_XXHASH is not set
# CONFIG_CRYPTO_BLAKE2B is not set
# CONFIG_CRYPTO_BLAKE2S is not set
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRC64_ROCKSOFT=y
CONFIG_CRYPTO_GHASH=y
# CONFIG_CRYPTO_POLY1305 is not set
# CONFIG_CRYPTO_MD4 is not set
# CONFIG_CRYPTO_MD5 is not set
CONFIG_CRYPTO_MICHAEL_MIC=m
# CONFIG_CRYPTO_RMD160 is not set
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=m
CONFIG_CRYPTO_SM3=y
# CONFIG_CRYPTO_SM3_GENERIC is not set
CONFIG_CRYPTO_STREEBOG=y
CONFIG_CRYPTO_WP512=y

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_AES_TI=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_BLOWFISH_COMMON=m
CONFIG_CRYPTO_CAMELLIA=m
# CONFIG_CRYPTO_CAST5 is not set
# CONFIG_CRYPTO_CAST6 is not set
CONFIG_CRYPTO_DES=m
# CONFIG_CRYPTO_FCRYPT is not set
CONFIG_CRYPTO_CHACHA20=y
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_SM4=m
CONFIG_CRYPTO_SM4_GENERIC=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_TWOFISH_COMMON=m

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=m
CONFIG_CRYPTO_LZO=y
CONFIG_CRYPTO_842=y
# CONFIG_CRYPTO_LZ4 is not set
CONFIG_CRYPTO_LZ4HC=m
CONFIG_CRYPTO_ZSTD=m

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
CONFIG_CRYPTO_KDF800108_CTR=y
CONFIG_CRYPTO_HASH_INFO=y
# CONFIG_CRYPTO_HW is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
CONFIG_PKCS8_PRIVATE_KEY_PARSER=y
CONFIG_PKCS7_MESSAGE_PARSER=y
CONFIG_PKCS7_TEST_KEY=m
CONFIG_SIGNED_PE_FILE_VERIFICATION=y

#
# Certificates for signature checking
#
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
CONFIG_SYSTEM_EXTRA_CERTIFICATE=y
CONFIG_SYSTEM_EXTRA_CERTIFICATE_SIZE=4096
# CONFIG_SECONDARY_TRUSTED_KEYRING is not set
# CONFIG_SYSTEM_BLACKLIST_KEYRING is not set
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=m
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
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=y
CONFIG_CRYPTO_LIB_CHACHA=m
# CONFIG_CRYPTO_LIB_CURVE25519 is not set
CONFIG_CRYPTO_LIB_DES=m
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=9
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=y
CONFIG_CRYPTO_LIB_POLY1305=m
CONFIG_CRYPTO_LIB_CHACHA20POLY1305=m
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
# CONFIG_CRC32_SLICEBY8 is not set
# CONFIG_CRC32_SLICEBY4 is not set
CONFIG_CRC32_SARWATE=y
# CONFIG_CRC32_BIT is not set
CONFIG_CRC64=y
CONFIG_CRC4=m
# CONFIG_CRC7 is not set
CONFIG_LIBCRC32C=m
CONFIG_CRC8=y
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_842_COMPRESS=y
CONFIG_842_DECOMPRESS=y
CONFIG_ZLIB_INFLATE=m
CONFIG_ZLIB_DEFLATE=m
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_COMPRESS=m
CONFIG_LZ4HC_COMPRESS=m
CONFIG_LZ4_DECOMPRESS=m
CONFIG_ZSTD_COMPRESS=m
CONFIG_ZSTD_DECOMPRESS=m
CONFIG_XZ_DEC=y
# CONFIG_XZ_DEC_X86 is not set
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
# CONFIG_XZ_DEC_ARMTHUMB is not set
CONFIG_XZ_DEC_SPARC=y
CONFIG_XZ_DEC_MICROLZMA=y
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_DEC16=y
CONFIG_BCH=m
CONFIG_BCH_CONST_PARAMS=y
CONFIG_INTERVAL_TREE=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_DMA_OPS=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_DMA_DECLARE_COHERENT=y
CONFIG_ARCH_HAS_SETUP_DMA_OPS=y
CONFIG_ARCH_HAS_TEARDOWN_DMA_OPS=y
CONFIG_DMA_NONCOHERENT_MMAP=y
# CONFIG_DMA_CMA is not set
# CONFIG_DMA_API_DEBUG is not set
# CONFIG_DMA_MAP_BENCHMARK is not set
CONFIG_SGL_ALLOC=y
CONFIG_GLOB=y
CONFIG_GLOB_SELFTEST=m
CONFIG_GENERIC_ATOMIC64=y
CONFIG_CLZ_TAB=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_LIBFDT=y
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=y
CONFIG_SG_POOL=y
CONFIG_STACKDEPOT=y
CONFIG_STACK_HASH_ORDER=20
CONFIG_REF_TRACKER=y
CONFIG_SBITMAP=y
CONFIG_PARMAN=m
CONFIG_OBJAGG=y
# end of Library routines

CONFIG_GENERIC_LIB_DEVMEM_IS_ALLOWED=y
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
CONFIG_SYMBOLIC_ERRNAME=y
CONFIG_DEBUG_BUGVERBOSE=y
# end of printk and dmesg options

CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_MISC=y

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
CONFIG_HEADERS_INSTALL=y
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_VMLINUX_MAP=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
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
CONFIG_KGDB=y
# CONFIG_KGDB_HONOUR_BLOCKLIST is not set
CONFIG_KGDB_TESTS=y
CONFIG_KGDB_TESTS_ON_BOOT=y
CONFIG_KGDB_TESTS_BOOT_STRING="V1F100"
CONFIG_KGDB_KDB=y
CONFIG_KDB_DEFAULT_ENABLE=0x1
CONFIG_KDB_CONTINUE_CATASTROPHIC=0
CONFIG_UBSAN=y
CONFIG_CC_HAS_UBSAN_BOUNDS=y
# CONFIG_UBSAN_BOUNDS is not set
CONFIG_UBSAN_SHIFT=y
# CONFIG_UBSAN_DIV_ZERO is not set
# CONFIG_UBSAN_UNREACHABLE is not set
# CONFIG_UBSAN_BOOL is not set
CONFIG_UBSAN_ENUM=y
CONFIG_TEST_UBSAN=m
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
# CONFIG_DEBUG_SLAB is not set
# CONFIG_PAGE_OWNER is not set
CONFIG_PAGE_POISONING=y
CONFIG_DEBUG_PAGE_REF=y
# CONFIG_DEBUG_WX is not set
CONFIG_DEBUG_OBJECTS=y
CONFIG_DEBUG_OBJECTS_SELFTEST=y
CONFIG_DEBUG_OBJECTS_FREE=y
CONFIG_DEBUG_OBJECTS_TIMERS=y
# CONFIG_DEBUG_OBJECTS_WORK is not set
# CONFIG_DEBUG_OBJECTS_RCU_HEAD is not set
CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER=y
CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=1
CONFIG_HAVE_DEBUG_KMEMLEAK=y
CONFIG_DEBUG_KMEMLEAK=y
CONFIG_DEBUG_KMEMLEAK_MEM_POOL_SIZE=16000
# CONFIG_DEBUG_KMEMLEAK_TEST is not set
CONFIG_DEBUG_KMEMLEAK_DEFAULT_OFF=y
CONFIG_DEBUG_KMEMLEAK_AUTO_SCAN=y
CONFIG_DEBUG_STACK_USAGE=y
CONFIG_SCHED_STACK_END_CHECK=y
# CONFIG_DEBUG_VM is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
CONFIG_DEBUG_VIRTUAL=y
CONFIG_DEBUG_MEMORY_INIT=y
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
# CONFIG_KASAN is not set
CONFIG_HAVE_ARCH_KFENCE=y
# CONFIG_KFENCE is not set
# end of Memory Debugging

# CONFIG_DEBUG_SHIRQ is not set

#
# Debug Oops, Lockups and Hangs
#
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
# CONFIG_SOFTLOCKUP_DETECTOR is not set
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=120
# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
# CONFIG_WQ_WATCHDOG is not set
CONFIG_TEST_LOCKUP=m
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
# CONFIG_SCHED_DEBUG is not set
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# end of Scheduler Debugging

CONFIG_DEBUG_TIMEKEEPING=y
CONFIG_DEBUG_PREEMPT=y

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
CONFIG_PROVE_LOCKING=y
CONFIG_PROVE_RAW_LOCK_NESTING=y
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
# CONFIG_DEBUG_LOCKDEP is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_LOCK_TORTURE_TEST is not set
CONFIG_WW_MUTEX_SELFTEST=m
CONFIG_SCF_TORTURE_TEST=y
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_TRACE_IRQFLAGS=y
CONFIG_DEBUG_IRQFLAGS=y
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_KOBJECT_RELEASE=y

#
# Debug kernel data structures
#
CONFIG_DEBUG_LIST=y
CONFIG_DEBUG_PLIST=y
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
CONFIG_BUG_ON_DATA_CORRUPTION=y
# end of Debug kernel data structures

# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_PROVE_RCU=y
CONFIG_TORTURE_TEST=y
CONFIG_RCU_SCALE_TEST=y
CONFIG_RCU_TORTURE_TEST=m
# CONFIG_RCU_REF_SCALE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=21
CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=0
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_LATENCYTOP is not set
CONFIG_NOP_TRACER=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_HAVE_BUILDTIME_MCOUNT_SORT=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_PREEMPTIRQ_TRACEPOINTS=y
CONFIG_TRACING=y
CONFIG_TRACING_SUPPORT=y
# CONFIG_FTRACE is not set
# CONFIG_SAMPLES is not set
# CONFIG_STRICT_DEVMEM is not set

#
# arm Debugging
#
# CONFIG_ARM_PTDUMP_DEBUGFS is not set
# CONFIG_UNWINDER_FRAME_POINTER is not set
CONFIG_UNWINDER_ARM=y
CONFIG_ARM_UNWIND=y
CONFIG_BACKTRACE_VERBOSE=y
# CONFIG_DEBUG_USER is not set
CONFIG_DEBUG_LL=y
CONFIG_DEBUG_ASM9260_UART=y
# CONFIG_DEBUG_AT91_RM9200_DBGU is not set
# CONFIG_DEBUG_AT91_SAM9263_DBGU is not set
# CONFIG_DEBUG_CLPS711X_UART1 is not set
# CONFIG_DEBUG_CLPS711X_UART2 is not set
# CONFIG_DEBUG_GEMINI is not set
# CONFIG_DEBUG_IMX23_UART is not set
# CONFIG_DEBUG_IMX28_UART is not set
# CONFIG_DEBUG_LPC32XX is not set
# CONFIG_DEBUG_MMP_UART2 is not set
# CONFIG_DEBUG_MMP_UART3 is not set
# CONFIG_DEBUG_MVEBU_UART0_ALTERNATE is not set
# CONFIG_DEBUG_MVEBU_UART1_ALTERNATE is not set
# CONFIG_DEBUG_NOMADIK_UART is not set
# CONFIG_DEBUG_PXA_UART1 is not set
# CONFIG_DEBUG_SUNXI_UART0 is not set
# CONFIG_DEBUG_SUNXI_UART1 is not set
# CONFIG_DEBUG_SPEAR3XX is not set
# CONFIG_DEBUG_ICEDCC is not set
# CONFIG_DEBUG_SEMIHOSTING is not set
# CONFIG_DEBUG_LL_UART_8250 is not set
# CONFIG_DEBUG_LL_UART_PL01X is not set
# CONFIG_DEBUG_UART_FLOW_CONTROL is not set
CONFIG_DEBUG_LL_INCLUDE="debug/asm9260.S"
CONFIG_DEBUG_UART_PHYS=0x80010000
CONFIG_DEBUG_UART_VIRT=0xf0010000
# CONFIG_DEBUG_UNCOMPRESS is not set
CONFIG_UNCOMPRESS_INCLUDE="debug/uncompress.h"
# CONFIG_EARLY_PRINTK is not set
CONFIG_CORESIGHT=m
CONFIG_CORESIGHT_LINKS_AND_SINKS=m
# CONFIG_CORESIGHT_LINK_AND_SINK_TMC is not set
CONFIG_CORESIGHT_SINK_TPIU=m
# CONFIG_CORESIGHT_SINK_ETBV10 is not set
# CONFIG_CORESIGHT_SOURCE_ETM3X is not set
CONFIG_CORESIGHT_CPU_DEBUG=m
CONFIG_CORESIGHT_CPU_DEBUG_DEFAULT_ON=y
CONFIG_CORESIGHT_CTI=m
# CONFIG_CORESIGHT_CTI_INTEGRATION_REGS is not set
# end of arm Debugging

#
# Kernel Testing and Coverage
#
CONFIG_KUNIT=y
CONFIG_KUNIT_DEBUGFS=y
CONFIG_KUNIT_TEST=y
CONFIG_KUNIT_EXAMPLE_TEST=y
CONFIG_KUNIT_ALL_TESTS=y
CONFIG_NOTIFIER_ERROR_INJECTION=y
# CONFIG_PM_NOTIFIER_ERROR_INJECT is not set
# CONFIG_OF_RECONFIG_NOTIFIER_ERROR_INJECT is not set
# CONFIG_FAULT_INJECTION is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
CONFIG_KCOV=y
# CONFIG_KCOV_ENABLE_COMPARISONS is not set
# CONFIG_KCOV_INSTRUMENT_ALL is not set
CONFIG_KCOV_IRQ_AREA_SIZE=0x40000
CONFIG_RUNTIME_TESTING_MENU=y
CONFIG_LKDTM=m
CONFIG_TEST_LIST_SORT=y
CONFIG_TEST_MIN_HEAP=y
CONFIG_TEST_SORT=y
CONFIG_TEST_DIV64=m
CONFIG_BACKTRACE_SELF_TEST=y
CONFIG_TEST_REF_TRACKER=m
CONFIG_RBTREE_TEST=m
# CONFIG_REED_SOLOMON_TEST is not set
CONFIG_INTERVAL_TREE_TEST=m
CONFIG_PERCPU_TEST=m
# CONFIG_ATOMIC64_SELFTEST is not set
# CONFIG_ASYNC_RAID6_TEST is not set
CONFIG_TEST_HEXDUMP=y
CONFIG_STRING_SELFTEST=m
CONFIG_TEST_STRING_HELPERS=y
# CONFIG_TEST_STRSCPY is not set
CONFIG_TEST_KSTRTOX=y
CONFIG_TEST_PRINTF=m
# CONFIG_TEST_SCANF is not set
CONFIG_TEST_BITMAP=m
CONFIG_TEST_UUID=m
CONFIG_TEST_XARRAY=m
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_SIPHASH is not set
CONFIG_TEST_IDA=m
# CONFIG_TEST_PARMAN is not set
# CONFIG_TEST_LKM is not set
CONFIG_TEST_BITOPS=m
CONFIG_TEST_VMALLOC=m
# CONFIG_TEST_USER_COPY is not set
CONFIG_FIND_BIT_BENCHMARK=m
# CONFIG_TEST_FIRMWARE is not set
CONFIG_BITFIELD_KUNIT=y
CONFIG_HASH_KUNIT_TEST=y
CONFIG_RESOURCE_KUNIT_TEST=y
CONFIG_SYSCTL_KUNIT_TEST=y
CONFIG_LIST_KUNIT_TEST=y
CONFIG_LINEAR_RANGES_TEST=y
CONFIG_CMDLINE_KUNIT_TEST=y
CONFIG_BITS_TEST=y
CONFIG_RATIONAL_KUNIT_TEST=y
CONFIG_MEMCPY_KUNIT_TEST=y
CONFIG_OVERFLOW_KUNIT_TEST=y
CONFIG_STACKINIT_KUNIT_TEST=y
CONFIG_TEST_UDELAY=y
CONFIG_TEST_STATIC_KEYS=m
CONFIG_TEST_DEBUG_VIRTUAL=y
CONFIG_TEST_MEMCAT_P=y
CONFIG_TEST_OBJAGG=y
CONFIG_TEST_MEMINIT=m
# CONFIG_TEST_FREE_PAGES is not set
CONFIG_ARCH_USE_MEMTEST=y
# CONFIG_MEMTEST is not set
# end of Kernel Testing and Coverage

CONFIG_WARN_MISSING_DOCUMENTS=y
CONFIG_WARN_ABI_ERRORS=y
# end of Kernel hacking

--f1d0j511qKItHqrO--
