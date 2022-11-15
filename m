Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC7B462AE93
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 23:48:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbiKOWsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 17:48:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238642AbiKOWsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 17:48:03 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD0EC222AF
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 14:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668552473; x=1700088473;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=gIzhA9PaSllpespIMLbKcUgTOIGVuJnmViRhjlib1LY=;
  b=POGe8o1He9sd60BIIjZj0eIGCEwEoE/Dx8dnvhvKsXmNrC54ovLXsFfi
   nZnFXaFD6Km4mTCHLuCoX/UyITURiGBJMw6ZQ1guvdb69R77XxLdPnJ48
   kQNJgwJPdaYkieFUSiz1aUoui25Klc82kF1O3s2qr1YWNKswWiUv7YbiI
   4WSMGDYpq1JW9ZvsfS4GDXGDpCaCMjkkI9cCwcFjT2+PC1Knk5lw0A1wc
   CuFXZhs5W1XF46gynj730k3MtMJK2EXbQit6yi6lOjp/FF7iYmMfl3YUz
   k05A4WyOUfRubwfpXoRrmc+DTrUtG1UqGz5Dq1sI+rTv15n1ep9M3ES7/
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="292097076"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="292097076"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 14:47:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="670256372"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="670256372"
Received: from lkp-server01.sh.intel.com (HELO ebd99836cbe0) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 15 Nov 2022 14:47:51 -0800
Received: from kbuild by ebd99836cbe0 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ov4i8-0001it-13;
        Tue, 15 Nov 2022 22:47:20 +0000
Date:   Wed, 16 Nov 2022 06:46:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/perf/fsl_imx8_ddr_perf.c:397:17: sparse: sparse: incorrect
 type in argument 1 (different address spaces)
Message-ID: <202211160645.cinB2eUm-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="1QLjTjNamNICajfh"
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,UPPERCASE_50_75 autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1QLjTjNamNICajfh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   81e7cfa3a9eb4ba6993a9c71772fdab21bc5d870
commit: f3c0eba287049237b23d1300376768293eb89e69 perf: Add a few assertions
date:   10 weeks ago
config: loongarch-randconfig-s052-20221115
compiler: loongarch64-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f3c0eba287049237b23d1300376768293eb89e69
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout f3c0eba287049237b23d1300376768293eb89e69
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=loongarch SHELL=/bin/bash drivers/perf/ mm/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> drivers/perf/fsl_imx8_ddr_perf.c:397:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   drivers/perf/fsl_imx8_ddr_perf.c:397:17: sparse:     expected void *ptr
   drivers/perf/fsl_imx8_ddr_perf.c:397:17: sparse:     got unsigned int [noderef] __percpu *
>> drivers/perf/fsl_imx8_ddr_perf.c:397:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   drivers/perf/fsl_imx8_ddr_perf.c:397:17: sparse:     expected void *ptr
   drivers/perf/fsl_imx8_ddr_perf.c:397:17: sparse:     got unsigned int [noderef] __percpu *
>> drivers/perf/fsl_imx8_ddr_perf.c:397:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   drivers/perf/fsl_imx8_ddr_perf.c:397:17: sparse:     expected void *ptr
   drivers/perf/fsl_imx8_ddr_perf.c:397:17: sparse:     got unsigned int [noderef] __percpu *
>> drivers/perf/fsl_imx8_ddr_perf.c:397:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   drivers/perf/fsl_imx8_ddr_perf.c:397:17: sparse:     expected void *ptr
   drivers/perf/fsl_imx8_ddr_perf.c:397:17: sparse:     got unsigned int [noderef] __percpu *
>> drivers/perf/fsl_imx8_ddr_perf.c:397:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   drivers/perf/fsl_imx8_ddr_perf.c:397:17: sparse:     expected void *ptr
   drivers/perf/fsl_imx8_ddr_perf.c:397:17: sparse:     got int [noderef] __percpu *
>> drivers/perf/fsl_imx8_ddr_perf.c:397:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   drivers/perf/fsl_imx8_ddr_perf.c:397:17: sparse:     expected void *ptr
   drivers/perf/fsl_imx8_ddr_perf.c:397:17: sparse:     got int [noderef] __percpu *
>> drivers/perf/fsl_imx8_ddr_perf.c:397:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   drivers/perf/fsl_imx8_ddr_perf.c:397:17: sparse:     expected void *ptr
   drivers/perf/fsl_imx8_ddr_perf.c:397:17: sparse:     got int [noderef] __percpu *
>> drivers/perf/fsl_imx8_ddr_perf.c:397:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   drivers/perf/fsl_imx8_ddr_perf.c:397:17: sparse:     expected void *ptr
   drivers/perf/fsl_imx8_ddr_perf.c:397:17: sparse:     got int [noderef] __percpu *
   drivers/perf/fsl_imx8_ddr_perf.c:403:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   drivers/perf/fsl_imx8_ddr_perf.c:403:9: sparse:     expected void *ptr
   drivers/perf/fsl_imx8_ddr_perf.c:403:9: sparse:     got unsigned int [noderef] __percpu *
   drivers/perf/fsl_imx8_ddr_perf.c:403:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   drivers/perf/fsl_imx8_ddr_perf.c:403:9: sparse:     expected void *ptr
   drivers/perf/fsl_imx8_ddr_perf.c:403:9: sparse:     got unsigned int [noderef] __percpu *
   drivers/perf/fsl_imx8_ddr_perf.c:403:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   drivers/perf/fsl_imx8_ddr_perf.c:403:9: sparse:     expected void *ptr
   drivers/perf/fsl_imx8_ddr_perf.c:403:9: sparse:     got unsigned int [noderef] __percpu *
   drivers/perf/fsl_imx8_ddr_perf.c:403:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   drivers/perf/fsl_imx8_ddr_perf.c:403:9: sparse:     expected void *ptr
   drivers/perf/fsl_imx8_ddr_perf.c:403:9: sparse:     got unsigned int [noderef] __percpu *
   drivers/perf/fsl_imx8_ddr_perf.c:403:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   drivers/perf/fsl_imx8_ddr_perf.c:403:9: sparse:     expected void *ptr
   drivers/perf/fsl_imx8_ddr_perf.c:403:9: sparse:     got int [noderef] __percpu *
   drivers/perf/fsl_imx8_ddr_perf.c:403:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   drivers/perf/fsl_imx8_ddr_perf.c:403:9: sparse:     expected void *ptr
   drivers/perf/fsl_imx8_ddr_perf.c:403:9: sparse:     got int [noderef] __percpu *
   drivers/perf/fsl_imx8_ddr_perf.c:403:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   drivers/perf/fsl_imx8_ddr_perf.c:403:9: sparse:     expected void *ptr
   drivers/perf/fsl_imx8_ddr_perf.c:403:9: sparse:     got int [noderef] __percpu *
   drivers/perf/fsl_imx8_ddr_perf.c:403:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   drivers/perf/fsl_imx8_ddr_perf.c:403:9: sparse:     expected void *ptr
   drivers/perf/fsl_imx8_ddr_perf.c:403:9: sparse:     got int [noderef] __percpu *
   drivers/perf/fsl_imx8_ddr_perf.c: note: in included file (through arch/loongarch/include/asm/io.h, include/linux/io.h, include/linux/irq.h, ...):
   include/asm-generic/io.h:335:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:335:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:335:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:335:15: sparse: sparse: cast to restricted __le32

vim +397 drivers/perf/fsl_imx8_ddr_perf.c

c12c0288e35a469 Joakim Zhang 2019-08-28  367  
9a66d36cc7ace80 Frank Li     2019-05-01  368  static int ddr_perf_event_init(struct perf_event *event)
9a66d36cc7ace80 Frank Li     2019-05-01  369  {
9a66d36cc7ace80 Frank Li     2019-05-01  370  	struct ddr_pmu *pmu = to_ddr_pmu(event->pmu);
9a66d36cc7ace80 Frank Li     2019-05-01  371  	struct hw_perf_event *hwc = &event->hw;
9a66d36cc7ace80 Frank Li     2019-05-01  372  	struct perf_event *sibling;
9a66d36cc7ace80 Frank Li     2019-05-01  373  
9a66d36cc7ace80 Frank Li     2019-05-01  374  	if (event->attr.type != event->pmu->type)
9a66d36cc7ace80 Frank Li     2019-05-01  375  		return -ENOENT;
9a66d36cc7ace80 Frank Li     2019-05-01  376  
9a66d36cc7ace80 Frank Li     2019-05-01  377  	if (is_sampling_event(event) || event->attach_state & PERF_ATTACH_TASK)
9a66d36cc7ace80 Frank Li     2019-05-01  378  		return -EOPNOTSUPP;
9a66d36cc7ace80 Frank Li     2019-05-01  379  
9a66d36cc7ace80 Frank Li     2019-05-01  380  	if (event->cpu < 0) {
9a66d36cc7ace80 Frank Li     2019-05-01  381  		dev_warn(pmu->dev, "Can't provide per-task data!\n");
9a66d36cc7ace80 Frank Li     2019-05-01  382  		return -EOPNOTSUPP;
9a66d36cc7ace80 Frank Li     2019-05-01  383  	}
9a66d36cc7ace80 Frank Li     2019-05-01  384  
9a66d36cc7ace80 Frank Li     2019-05-01  385  	/*
9a66d36cc7ace80 Frank Li     2019-05-01  386  	 * We must NOT create groups containing mixed PMUs, although software
9a66d36cc7ace80 Frank Li     2019-05-01  387  	 * events are acceptable (for example to create a CCN group
9a66d36cc7ace80 Frank Li     2019-05-01  388  	 * periodically read when a hrtimer aka cpu-clock leader triggers).
9a66d36cc7ace80 Frank Li     2019-05-01  389  	 */
9a66d36cc7ace80 Frank Li     2019-05-01  390  	if (event->group_leader->pmu != event->pmu &&
9a66d36cc7ace80 Frank Li     2019-05-01  391  			!is_software_event(event->group_leader))
9a66d36cc7ace80 Frank Li     2019-05-01  392  		return -EINVAL;
9a66d36cc7ace80 Frank Li     2019-05-01  393  
c12c0288e35a469 Joakim Zhang 2019-08-28  394  	if (pmu->devtype_data->quirks & DDR_CAP_AXI_ID_FILTER) {
c12c0288e35a469 Joakim Zhang 2019-08-28  395  		if (!ddr_perf_filters_compatible(event, event->group_leader))
c12c0288e35a469 Joakim Zhang 2019-08-28  396  			return -EINVAL;
c12c0288e35a469 Joakim Zhang 2019-08-28 @397  		for_each_sibling_event(sibling, event->group_leader) {
c12c0288e35a469 Joakim Zhang 2019-08-28  398  			if (!ddr_perf_filters_compatible(event, sibling))
c12c0288e35a469 Joakim Zhang 2019-08-28  399  				return -EINVAL;
c12c0288e35a469 Joakim Zhang 2019-08-28  400  		}
c12c0288e35a469 Joakim Zhang 2019-08-28  401  	}
c12c0288e35a469 Joakim Zhang 2019-08-28  402  
9a66d36cc7ace80 Frank Li     2019-05-01  403  	for_each_sibling_event(sibling, event->group_leader) {
9a66d36cc7ace80 Frank Li     2019-05-01  404  		if (sibling->pmu != event->pmu &&
9a66d36cc7ace80 Frank Li     2019-05-01  405  				!is_software_event(sibling))
9a66d36cc7ace80 Frank Li     2019-05-01  406  			return -EINVAL;
9a66d36cc7ace80 Frank Li     2019-05-01  407  	}
9a66d36cc7ace80 Frank Li     2019-05-01  408  
9a66d36cc7ace80 Frank Li     2019-05-01  409  	event->cpu = pmu->cpu;
9a66d36cc7ace80 Frank Li     2019-05-01  410  	hwc->idx = -1;
9a66d36cc7ace80 Frank Li     2019-05-01  411  
9a66d36cc7ace80 Frank Li     2019-05-01  412  	return 0;
9a66d36cc7ace80 Frank Li     2019-05-01  413  }
9a66d36cc7ace80 Frank Li     2019-05-01  414  

:::::: The code at line 397 was first introduced by commit
:::::: c12c0288e35a4693b1606e229dab54a62f1ad568 perf/imx_ddr: Add support for AXI ID filtering

:::::: TO: Joakim Zhang <qiangqing.zhang@nxp.com>
:::::: CC: Will Deacon <will@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

--1QLjTjNamNICajfh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=config

#
# Automatically generated file; DO NOT EDIT.
# Linux/loongarch 6.0.0-rc2 Kernel Configuration
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
# CONFIG_CROSS_MEMORY_ATTACH is not set
CONFIG_USELIB=y
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
# CONFIG_TIME_KUNIT_TEST is not set
CONFIG_CONTEXT_TRACKING=y
CONFIG_CONTEXT_TRACKING_IDLE=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_HZ_PERIODIC=y
# CONFIG_NO_HZ_IDLE is not set
# CONFIG_NO_HZ_FULL is not set
# CONFIG_NO_HZ is not set
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
# CONFIG_PSI is not set
# end of CPU/Task time and stats accounting

CONFIG_CPU_ISOLATION=y

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
CONFIG_PREEMPT_RCU=y
CONFIG_RCU_EXPERT=y
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
# CONFIG_FORCE_TASKS_RCU is not set
CONFIG_TASKS_RCU=y
CONFIG_FORCE_TASKS_RUDE_RCU=y
CONFIG_TASKS_RUDE_RCU=y
# CONFIG_FORCE_TASKS_TRACE_RCU is not set
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_FANOUT=64
CONFIG_RCU_FANOUT_LEAF=16
CONFIG_RCU_BOOST=y
CONFIG_RCU_BOOST_DELAY=500
CONFIG_RCU_EXP_KTHREAD=y
CONFIG_RCU_NOCB_CPU=y
CONFIG_RCU_NOCB_CPU_DEFAULT_ALL=y
CONFIG_RCU_NOCB_CPU_CB_BOOST=y
# end of RCU Subsystem

# CONFIG_IKCONFIG is not set
# CONFIG_IKHEADERS is not set
CONFIG_LOG_BUF_SHIFT=17
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
# CONFIG_PRINTK_INDEX is not set
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
# CONFIG_CGROUP_FAVOR_DYNMODS is not set
CONFIG_MEMCG=y
# CONFIG_BLK_CGROUP is not set
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
# CONFIG_CFS_BANDWIDTH is not set
# CONFIG_RT_GROUP_SCHED is not set
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
# CONFIG_CGROUP_FREEZER is not set
CONFIG_CGROUP_HUGETLB=y
# CONFIG_CPUSETS is not set
# CONFIG_CGROUP_DEVICE is not set
CONFIG_CGROUP_CPUACCT=y
# CONFIG_CGROUP_PERF is not set
CONFIG_CGROUP_MISC=y
# CONFIG_CGROUP_DEBUG is not set
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
CONFIG_USER_NS=y
CONFIG_PID_NS=y
CONFIG_CHECKPOINT_RESTORE=y
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_SYSFS_DEPRECATED is not set
# CONFIG_RELAY is not set
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_INITRAMFS_FORCE=y
CONFIG_RD_GZIP=y
# CONFIG_RD_BZIP2 is not set
CONFIG_RD_LZMA=y
# CONFIG_RD_XZ is not set
CONFIG_RD_LZO=y
# CONFIG_RD_LZ4 is not set
CONFIG_RD_ZSTD=y
CONFIG_BOOT_CONFIG=y
# CONFIG_BOOT_CONFIG_EMBED is not set
# CONFIG_INITRAMFS_PRESERVE_MTIME is not set
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_EXPERT=y
CONFIG_MULTIUSER=y
# CONFIG_SGETMASK_SYSCALL is not set
# CONFIG_SYSFS_SYSCALL is not set
# CONFIG_FHANDLE is not set
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
# CONFIG_BUG is not set
# CONFIG_ELF_CORE is not set
# CONFIG_BASE_FULL is not set
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
# CONFIG_TIMERFD is not set
CONFIG_EVENTFD=y
# CONFIG_SHMEM is not set
CONFIG_AIO=y
# CONFIG_IO_URING is not set
CONFIG_ADVISE_SYSCALLS=y
# CONFIG_MEMBARRIER is not set
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_KCMP=y
# CONFIG_RSEQ is not set
CONFIG_EMBEDDED=y
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_PERF_USE_VMALLOC=y
# CONFIG_PC104 is not set

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
CONFIG_DEBUG_PERF_USE_VMALLOC=y
# end of Kernel Performance Events And Counters

CONFIG_SYSTEM_DATA_VERIFICATION=y
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
CONFIG_PAGE_SIZE_64KB=y
CONFIG_PGTABLE_2LEVEL=y
CONFIG_PGTABLE_LEVELS=2
CONFIG_SCHED_OMIT_FRAME_POINTER=y

#
# Kernel type and options
#
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_SCHED_HRTICK=y
# CONFIG_4KB_3LEVEL is not set
# CONFIG_4KB_4LEVEL is not set
# CONFIG_16KB_2LEVEL is not set
# CONFIG_16KB_3LEVEL is not set
CONFIG_64KB_2LEVEL=y
# CONFIG_64KB_3LEVEL is not set
CONFIG_CMDLINE=""
# CONFIG_CMDLINE_BOOTLOADER is not set
CONFIG_CMDLINE_EXTEND=y
# CONFIG_CMDLINE_FORCE is not set
CONFIG_DMI=y
CONFIG_EFI=y
CONFIG_SMP=y
CONFIG_HOTPLUG_CPU=y
CONFIG_NR_CPUS=64
# CONFIG_NUMA is not set
CONFIG_FORCE_MAX_ZONEORDER=14
# CONFIG_SECCOMP is not set
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
CONFIG_ACPI_DEBUGGER=y
CONFIG_ACPI_DEBUGGER_USER=y
CONFIG_ACPI_SPCR_TABLE=y
CONFIG_ACPI_EC_DEBUGFS=y
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=m
CONFIG_ACPI_BUTTON=y
# CONFIG_ACPI_VIDEO is not set
CONFIG_ACPI_FAN=m
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_MCFG=y
# CONFIG_ACPI_PROCESSOR is not set
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_TABLE_UPGRADE is not set
CONFIG_ACPI_DEBUG=y
# CONFIG_ACPI_PCI_SLOT is not set
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HED=m
CONFIG_ACPI_CUSTOM_METHOD=y
CONFIG_ACPI_REDUCED_HARDWARE_ONLY=y
CONFIG_ACPI_CONFIGFS=y
CONFIG_ACPI_PFRUT=m
CONFIG_PMIC_OPREGION=y
# end of Power management options

#
# Firmware Drivers
#

#
# ARM System Control and Management Interface Protocol
#
CONFIG_ARM_SCMI_PROTOCOL=m
CONFIG_ARM_SCMI_HAVE_TRANSPORT=y
CONFIG_ARM_SCMI_HAVE_SHMEM=y
CONFIG_ARM_SCMI_HAVE_MSG=y
CONFIG_ARM_SCMI_TRANSPORT_MAILBOX=y
CONFIG_ARM_SCMI_TRANSPORT_VIRTIO=y
CONFIG_ARM_SCMI_TRANSPORT_VIRTIO_VERSION1_COMPLIANCE=y
CONFIG_ARM_SCMI_TRANSPORT_VIRTIO_ATOMIC_ENABLE=y
# CONFIG_ARM_SCMI_POWER_DOMAIN is not set
# CONFIG_ARM_SCMI_POWER_CONTROL is not set
# end of ARM System Control and Management Interface Protocol

# CONFIG_ARM_SCPI_PROTOCOL is not set
CONFIG_ARM_SCPI_POWER_DOMAIN=y
# CONFIG_FIRMWARE_MEMMAP is not set
# CONFIG_DMIID is not set
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
CONFIG_QCOM_SCM=y
# CONFIG_QCOM_SCM_DOWNLOAD_MODE_DEFAULT is not set
CONFIG_SYSFB=y
CONFIG_SYSFB_SIMPLEFB=y
# CONFIG_TURRIS_MOX_RWTM is not set
CONFIG_BCM47XX_NVRAM=y
CONFIG_BCM47XX_SPROM=y
CONFIG_TEE_BNXT_FW=m
CONFIG_CS_DSP=m
# CONFIG_GOOGLE_FIRMWARE is not set

#
# EFI (Extensible Firmware Interface) Support
#
CONFIG_EFI_ESRT=y
CONFIG_EFI_PARAMS_FROM_FDT=y
CONFIG_EFI_RUNTIME_WRAPPERS=y
CONFIG_EFI_BOOTLOADER_CONTROL=y
CONFIG_EFI_CAPSULE_LOADER=y
CONFIG_EFI_TEST=m
# CONFIG_EFI_RCI2_TABLE is not set
# CONFIG_EFI_DISABLE_PCI_DMA is not set
CONFIG_EFI_EARLYCON=y
CONFIG_EFI_CUSTOM_SSDT_OVERLAYS=y
# CONFIG_EFI_DISABLE_RUNTIME is not set
CONFIG_EFI_COCO_SECRET=y
# end of EFI (Extensible Firmware Interface) Support

CONFIG_IMX_DSP=m
CONFIG_IMX_SCU=y
# CONFIG_IMX_SCU_PD is not set

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
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=12
CONFIG_PAGE_SIZE_LESS_THAN_256KB=y
CONFIG_ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT=y
CONFIG_ISA_BUS_API=y
# CONFIG_COMPAT_32BIT_TIME is not set
CONFIG_ARCH_HAS_PHYS_TO_DMA=y
CONFIG_ARCH_USE_MEMREMAP_PROT=y
CONFIG_LOCK_EVENT_COUNTS=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
# end of GCOV-based kernel profiling
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=1
CONFIG_MODULE_SIG_FORMAT=y
CONFIG_MODULES=y
CONFIG_MODULE_FORCE_LOAD=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_MODULE_UNLOAD_TAINT_TRACKING=y
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_MODULE_SIG=y
# CONFIG_MODULE_SIG_FORCE is not set
# CONFIG_MODULE_SIG_ALL is not set
# CONFIG_MODULE_SIG_SHA1 is not set
CONFIG_MODULE_SIG_SHA224=y
# CONFIG_MODULE_SIG_SHA256 is not set
# CONFIG_MODULE_SIG_SHA384 is not set
# CONFIG_MODULE_SIG_SHA512 is not set
CONFIG_MODULE_SIG_HASH="sha224"
# CONFIG_MODULE_COMPRESS_NONE is not set
# CONFIG_MODULE_COMPRESS_GZIP is not set
# CONFIG_MODULE_COMPRESS_XZ is not set
CONFIG_MODULE_COMPRESS_ZSTD=y
CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS=y
CONFIG_MODPROBE_PATH="/sbin/modprobe"
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLOCK_LEGACY_AUTOLOAD=y
CONFIG_BLK_DEV_BSG_COMMON=y
CONFIG_BLK_ICQ=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_INTEGRITY_T10=y
# CONFIG_BLK_DEV_ZONED is not set
# CONFIG_BLK_WBT is not set
CONFIG_BLK_DEBUG_FS=y
CONFIG_BLK_SED_OPAL=y
# CONFIG_BLK_INLINE_ENCRYPTION is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_EFI_PARTITION=y
# end of Partition Types

CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=m
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
CONFIG_BINFMT_SCRIPT=m
# CONFIG_BINFMT_MISC is not set
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
# CONFIG_SWAP is not set

#
# SLAB allocator options
#
# CONFIG_SLAB is not set
# CONFIG_SLUB is not set
CONFIG_SLOB=y
# end of SLAB allocator options

CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
# CONFIG_COMPAT_BRK is not set
CONFIG_SELECT_MEMORY_MODEL=y
# CONFIG_FLATMEM_MANUAL is not set
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_EXCLUSIVE_SYSTEM_RAM=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
# CONFIG_MEMORY_HOTPLUG is not set
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_COMPACTION=y
# CONFIG_PAGE_REPORTING is not set
CONFIG_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PHYS_ADDR_T_64BIT=y
# CONFIG_KSM is not set
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_TRANSPARENT_HUGEPAGE=y
# CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS is not set
CONFIG_TRANSPARENT_HUGEPAGE_MADVISE=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y
CONFIG_CMA=y
CONFIG_CMA_DEBUG=y
# CONFIG_CMA_DEBUGFS is not set
# CONFIG_CMA_SYSFS is not set
CONFIG_CMA_AREAS=7
CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
CONFIG_PAGE_IDLE_FLAG=y
# CONFIG_IDLE_PAGE_TRACKING is not set
CONFIG_ZONE_DMA32=y
CONFIG_GET_FREE_REGION=y
# CONFIG_VM_EVENT_COUNTERS is not set
# CONFIG_PERCPU_STATS is not set
CONFIG_GUP_TEST=y
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_ANON_VMA_NAME=y
CONFIG_USERFAULTFD=y

#
# Data Access Monitoring
#
CONFIG_DAMON=y
# CONFIG_DAMON_KUNIT_TEST is not set
CONFIG_DAMON_VADDR=y
CONFIG_DAMON_PADDR=y
# CONFIG_DAMON_VADDR_KUNIT_TEST is not set
CONFIG_DAMON_SYSFS=y
CONFIG_DAMON_DBGFS=y
# CONFIG_DAMON_DBGFS_KUNIT_TEST is not set
CONFIG_DAMON_RECLAIM=y
CONFIG_DAMON_LRU_SORT=y
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
CONFIG_PCIEPORTBUS=y
CONFIG_PCIEAER=y
CONFIG_PCIEAER_INJECT=m
# CONFIG_PCIE_ECRC is not set
# CONFIG_PCIEASPM is not set
CONFIG_PCIE_DPC=y
# CONFIG_PCIE_PTM is not set
# CONFIG_PCIE_EDR is not set
CONFIG_PCI_MSI=y
CONFIG_PCI_MSI_IRQ_DOMAIN=y
CONFIG_PCI_MSI_ARCH_FALLBACKS=y
CONFIG_PCI_QUIRKS=y
CONFIG_PCI_DEBUG=y
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
CONFIG_PCI_STUB=y
# CONFIG_PCI_PF_STUB is not set
CONFIG_PCI_ATS=y
CONFIG_PCI_DOE=y
CONFIG_PCI_ECAM=y
CONFIG_PCI_IOV=y
# CONFIG_PCI_PRI is not set
# CONFIG_PCI_PASID is not set
CONFIG_PCI_LABEL=y
# CONFIG_PCIE_BUS_TUNE_OFF is not set
CONFIG_PCIE_BUS_DEFAULT=y
# CONFIG_PCIE_BUS_SAFE is not set
# CONFIG_PCIE_BUS_PERFORMANCE is not set
# CONFIG_PCIE_BUS_PEER2PEER is not set
# CONFIG_VGA_ARB is not set
# CONFIG_HOTPLUG_PCI is not set

#
# PCI controller drivers
#
# CONFIG_PCI_AARDVARK is not set
# CONFIG_PCIE_XILINX_NWL is not set
# CONFIG_PCI_FTPCI100 is not set
CONFIG_PCI_TEGRA=y
CONFIG_PCIE_RCAR_HOST=y
# CONFIG_PCIE_RCAR_EP is not set
CONFIG_PCI_HOST_COMMON=y
# CONFIG_PCI_HOST_GENERIC is not set
# CONFIG_PCIE_XILINX is not set
CONFIG_PCIE_XILINX_CPM=y
# CONFIG_PCI_XGENE is not set
# CONFIG_PCI_V3_SEMI is not set
CONFIG_PCI_VERSATILE=y
CONFIG_PCIE_ALTERA=m
CONFIG_PCIE_ALTERA_MSI=m
CONFIG_PCI_HOST_THUNDER_PEM=y
# CONFIG_PCI_HOST_THUNDER_ECAM is not set
# CONFIG_PCIE_ROCKCHIP_HOST is not set
# CONFIG_PCIE_ROCKCHIP_EP is not set
# CONFIG_PCIE_MEDIATEK is not set
CONFIG_PCIE_MEDIATEK_GEN3=m
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
# CONFIG_PCIE_DW_PLAT_HOST is not set
CONFIG_PCIE_DW_PLAT_EP=y
CONFIG_PCI_EXYNOS=y
CONFIG_PCI_IMX6=y
# CONFIG_PCIE_SPEAR13XX is not set
CONFIG_PCI_KEYSTONE=y
CONFIG_PCI_KEYSTONE_HOST=y
CONFIG_PCI_KEYSTONE_EP=y
# CONFIG_PCI_LAYERSCAPE is not set
# CONFIG_PCI_LAYERSCAPE_EP is not set
# CONFIG_PCI_HISI is not set
# CONFIG_PCIE_QCOM is not set
# CONFIG_PCIE_QCOM_EP is not set
# CONFIG_PCIE_ARMADA_8K is not set
CONFIG_PCIE_ARTPEC6=y
CONFIG_PCIE_ARTPEC6_HOST=y
CONFIG_PCIE_ARTPEC6_EP=y
# CONFIG_PCIE_ROCKCHIP_DW_HOST is not set
# CONFIG_PCIE_INTEL_GW is not set
CONFIG_PCIE_KEEMBAY=y
CONFIG_PCIE_KEEMBAY_HOST=y
CONFIG_PCIE_KEEMBAY_EP=y
# CONFIG_PCIE_KIRIN is not set
CONFIG_PCIE_HISI_STB=y
# CONFIG_PCI_MESON is not set
# CONFIG_PCIE_TEGRA194_HOST is not set
# CONFIG_PCIE_TEGRA194_EP is not set
# CONFIG_PCIE_VISCONTI_HOST is not set
# CONFIG_PCIE_UNIPHIER is not set
# CONFIG_PCIE_UNIPHIER_EP is not set
# CONFIG_PCIE_AL is not set
CONFIG_PCIE_FU740=y
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
CONFIG_PCI_ENDPOINT_CONFIGFS=y
CONFIG_PCI_EPF_TEST=y
CONFIG_PCI_EPF_NTB=m
# end of PCI Endpoint

#
# PCI switch controller drivers
#
CONFIG_PCI_SW_SWITCHTEC=y
# end of PCI switch controller drivers

CONFIG_CXL_BUS=m
CONFIG_CXL_PCI=m
CONFIG_CXL_MEM_RAW_COMMANDS=y
CONFIG_CXL_ACPI=m
# CONFIG_CXL_MEM is not set
CONFIG_CXL_PORT=m
CONFIG_CXL_REGION=y
# CONFIG_PCCARD is not set
CONFIG_RAPIDIO=y
# CONFIG_RAPIDIO_TSI721 is not set
CONFIG_RAPIDIO_DISC_TIMEOUT=30
CONFIG_RAPIDIO_ENABLE_RX_TX_PORTS=y
# CONFIG_RAPIDIO_DEBUG is not set
# CONFIG_RAPIDIO_ENUM_BASIC is not set
CONFIG_RAPIDIO_CHMAN=y
CONFIG_RAPIDIO_MPORT_CDEV=y

#
# RapidIO Switch drivers
#
CONFIG_RAPIDIO_CPS_XX=m
# CONFIG_RAPIDIO_CPS_GEN2 is not set
# CONFIG_RAPIDIO_RXS_GEN3 is not set
# end of RapidIO Switch drivers

#
# Generic Driver Options
#
CONFIG_AUXILIARY_BUS=y
CONFIG_UEVENT_HELPER=y
CONFIG_UEVENT_HELPER_PATH=""
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
CONFIG_DEVTMPFS_SAFE=y
CONFIG_STANDALONE=y
# CONFIG_PREVENT_FIRMWARE_BUILD is not set

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
CONFIG_FW_UPLOAD=y
# end of Firmware loader

CONFIG_WANT_DEV_COREDUMP=y
# CONFIG_ALLOW_DEV_COREDUMP is not set
CONFIG_DEBUG_DRIVER=y
# CONFIG_DEBUG_DEVRES is not set
CONFIG_DEBUG_TEST_DRIVER_REMOVE=y
# CONFIG_PM_QOS_KUNIT_TEST is not set
CONFIG_TEST_ASYNC_DRIVER_PROBE=m
# CONFIG_DRIVER_PE_KUNIT_TEST is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_SOC_BUS=y
CONFIG_REGMAP=y
CONFIG_REGMAP_AC97=m
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SPI=y
CONFIG_REGMAP_SPMI=m
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_DMA_SHARED_BUFFER=y
CONFIG_DMA_FENCE_TRACE=y
# end of Generic Driver Options

#
# Bus devices
#
CONFIG_ARM_INTEGRATOR_LM=y
# CONFIG_BT1_APB is not set
# CONFIG_BT1_AXI is not set
# CONFIG_MOXTET is not set
# CONFIG_HISILICON_LPC is not set
# CONFIG_INTEL_IXP4XX_EB is not set
CONFIG_QCOM_EBI2=y
# CONFIG_MHI_BUS is not set
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
CONFIG_MTD=y
# CONFIG_MTD_TESTS is not set

#
# Partition parsers
#
# CONFIG_MTD_AR7_PARTS is not set
# CONFIG_MTD_BCM63XX_PARTS is not set
CONFIG_MTD_CMDLINE_PARTS=m
CONFIG_MTD_OF_PARTS=y
# CONFIG_MTD_OF_PARTS_BCM4908 is not set
# CONFIG_MTD_OF_PARTS_LINKSYS_NS is not set
# CONFIG_MTD_PARSER_IMAGETAG is not set
CONFIG_MTD_PARSER_TRX=m
CONFIG_MTD_SHARPSL_PARTS=y
CONFIG_MTD_REDBOOT_PARTS=m
CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=-1
# CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED is not set
# CONFIG_MTD_REDBOOT_PARTS_READONLY is not set
CONFIG_MTD_QCOMSMEM_PARTS=y
# end of Partition parsers

#
# User Modules And Translation Layers
#
CONFIG_MTD_BLKDEVS=y
# CONFIG_MTD_BLOCK is not set
CONFIG_MTD_BLOCK_RO=m

#
# Note that in some cases UBI block is preferred. See MTD_UBI_BLOCK.
#
# CONFIG_FTL is not set
CONFIG_NFTL=m
CONFIG_NFTL_RW=y
# CONFIG_INFTL is not set
CONFIG_RFD_FTL=m
CONFIG_SSFDC=y
# CONFIG_SM_FTL is not set
CONFIG_MTD_OOPS=y
# CONFIG_MTD_PARTITIONED_MASTER is not set

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
# CONFIG_MTD_CFI_INTELEXT is not set
# CONFIG_MTD_CFI_AMDSTD is not set
CONFIG_MTD_CFI_STAA=m
CONFIG_MTD_CFI_UTIL=m
CONFIG_MTD_RAM=y
CONFIG_MTD_ROM=m
CONFIG_MTD_ABSENT=y
# end of RAM/ROM/Flash chip drivers

#
# Mapping drivers for chip access
#
# CONFIG_MTD_COMPLEX_MAPPINGS is not set
CONFIG_MTD_PHYSMAP=y
# CONFIG_MTD_PHYSMAP_COMPAT is not set
# CONFIG_MTD_PHYSMAP_OF is not set
CONFIG_MTD_SC520CDP=m
# CONFIG_MTD_NETSC520 is not set
# CONFIG_MTD_TS5500 is not set
CONFIG_MTD_INTEL_VR_NOR=m
# CONFIG_MTD_PLATRAM is not set
# end of Mapping drivers for chip access

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_PMC551 is not set
# CONFIG_MTD_DATAFLASH is not set
# CONFIG_MTD_MCHP23K256 is not set
# CONFIG_MTD_MCHP48L640 is not set
# CONFIG_MTD_SPEAR_SMI is not set
CONFIG_MTD_SST25L=y
# CONFIG_MTD_SLRAM is not set
CONFIG_MTD_PHRAM=y
CONFIG_MTD_MTDRAM=y
CONFIG_MTDRAM_TOTAL_SIZE=4096
CONFIG_MTDRAM_ERASE_SIZE=128
CONFIG_MTD_BLOCK2MTD=y

#
# Disk-On-Chip Device Drivers
#
# CONFIG_MTD_DOCG3 is not set
# end of Self-contained MTD device drivers

#
# NAND
#
CONFIG_MTD_NAND_CORE=y
# CONFIG_MTD_ONENAND is not set
CONFIG_MTD_RAW_NAND=y

#
# Raw/parallel NAND flash controllers
#
CONFIG_MTD_NAND_DENALI=y
CONFIG_MTD_NAND_DENALI_PCI=y
# CONFIG_MTD_NAND_DENALI_DT is not set
CONFIG_MTD_NAND_AMS_DELTA=y
# CONFIG_MTD_NAND_SHARPSL is not set
CONFIG_MTD_NAND_CAFE=m
CONFIG_MTD_NAND_ATMEL=y
CONFIG_MTD_NAND_MARVELL=m
CONFIG_MTD_NAND_SLC_LPC32XX=y
CONFIG_MTD_NAND_MLC_LPC32XX=y
# CONFIG_MTD_NAND_BRCMNAND is not set
CONFIG_MTD_NAND_OXNAS=m
# CONFIG_MTD_NAND_FSL_IFC is not set
# CONFIG_MTD_NAND_VF610_NFC is not set
# CONFIG_MTD_NAND_MXC is not set
# CONFIG_MTD_NAND_SH_FLCTL is not set
# CONFIG_MTD_NAND_DAVINCI is not set
CONFIG_MTD_NAND_TXX9NDFMC=m
# CONFIG_MTD_NAND_FSMC is not set
# CONFIG_MTD_NAND_SUNXI is not set
# CONFIG_MTD_NAND_HISI504 is not set
# CONFIG_MTD_NAND_QCOM is not set
# CONFIG_MTD_NAND_MTK is not set
# CONFIG_MTD_NAND_MXIC is not set
# CONFIG_MTD_NAND_TEGRA is not set
CONFIG_MTD_NAND_STM32_FMC2=y
CONFIG_MTD_NAND_MESON=m
CONFIG_MTD_NAND_GPIO=y
# CONFIG_MTD_NAND_PLATFORM is not set
# CONFIG_MTD_NAND_CADENCE is not set
CONFIG_MTD_NAND_ARASAN=m
CONFIG_MTD_NAND_INTEL_LGM=y
# CONFIG_MTD_NAND_RENESAS is not set

#
# Misc
#
CONFIG_MTD_NAND_NANDSIM=y
# CONFIG_MTD_NAND_RICOH is not set
CONFIG_MTD_NAND_DISKONCHIP=m
# CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADVANCED is not set
CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADDRESS=0
# CONFIG_MTD_NAND_DISKONCHIP_BBTWRITE is not set
CONFIG_MTD_SPI_NAND=m

#
# ECC engine support
#
CONFIG_MTD_NAND_ECC=y
CONFIG_MTD_NAND_ECC_SW_HAMMING=y
CONFIG_MTD_NAND_ECC_SW_HAMMING_SMC=y
# CONFIG_MTD_NAND_ECC_SW_BCH is not set
# CONFIG_MTD_NAND_ECC_MXIC is not set
CONFIG_MTD_NAND_ECC_MEDIATEK=y
# end of ECC engine support
# end of NAND

#
# LPDDR & LPDDR2 PCM memory drivers
#
CONFIG_MTD_LPDDR=y
CONFIG_MTD_QINFO_PROBE=y
# end of LPDDR & LPDDR2 PCM memory drivers

CONFIG_MTD_SPI_NOR=m
# CONFIG_MTD_SPI_NOR_USE_4K_SECTORS is not set
# CONFIG_MTD_SPI_NOR_SWP_DISABLE is not set
# CONFIG_MTD_SPI_NOR_SWP_DISABLE_ON_VOLATILE is not set
CONFIG_MTD_SPI_NOR_SWP_KEEP=y
# CONFIG_SPI_HISI_SFC is not set
# CONFIG_SPI_NXP_SPIFI is not set
CONFIG_MTD_UBI=m
CONFIG_MTD_UBI_WL_THRESHOLD=4096
CONFIG_MTD_UBI_BEB_LIMIT=20
CONFIG_MTD_UBI_FASTMAP=y
CONFIG_MTD_UBI_GLUEBI=m
# CONFIG_MTD_UBI_BLOCK is not set
# CONFIG_MTD_HYPERBUS is not set
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
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_FIFO=y
# CONFIG_PARPORT_PC_SUPERIO is not set
CONFIG_PARPORT_AX88796=m
# CONFIG_PARPORT_1284 is not set
CONFIG_PARPORT_NOT_PC=y
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
CONFIG_NVME_COMMON=y
CONFIG_NVME_CORE=y
CONFIG_BLK_DEV_NVME=y
CONFIG_NVME_MULTIPATH=y
# CONFIG_NVME_VERBOSE_ERRORS is not set
CONFIG_NVME_HWMON=y
CONFIG_NVME_FABRICS=m
CONFIG_NVME_FC=m
CONFIG_NVME_AUTH=y
# CONFIG_NVME_APPLE is not set
CONFIG_NVME_TARGET=m
# CONFIG_NVME_TARGET_PASSTHRU is not set
CONFIG_NVME_TARGET_LOOP=m
CONFIG_NVME_TARGET_FC=m
# CONFIG_NVME_TARGET_FCLOOP is not set
# CONFIG_NVME_TARGET_AUTH is not set
# end of NVME Support

#
# Misc devices
#
CONFIG_AD525X_DPOT=y
CONFIG_AD525X_DPOT_I2C=y
CONFIG_AD525X_DPOT_SPI=y
CONFIG_DUMMY_IRQ=y
CONFIG_PHANTOM=m
CONFIG_TIFM_CORE=m
# CONFIG_TIFM_7XX1 is not set
CONFIG_ICS932S401=y
# CONFIG_ATMEL_SSC is not set
CONFIG_ENCLOSURE_SERVICES=y
CONFIG_GEHC_ACHC=m
# CONFIG_HI6421V600_IRQ is not set
# CONFIG_HP_ILO is not set
CONFIG_QCOM_COINCELL=y
CONFIG_QCOM_FASTRPC=m
# CONFIG_APDS9802ALS is not set
CONFIG_ISL29003=y
CONFIG_ISL29020=y
CONFIG_SENSORS_TSL2550=y
# CONFIG_SENSORS_BH1770 is not set
CONFIG_SENSORS_APDS990X=m
CONFIG_HMC6352=y
CONFIG_DS1682=y
CONFIG_PCH_PHUB=m
CONFIG_LATTICE_ECP3_CONFIG=y
# CONFIG_SRAM is not set
CONFIG_DW_XDATA_PCIE=m
# CONFIG_PCI_ENDPOINT_TEST is not set
CONFIG_XILINX_SDFEC=m
CONFIG_MISC_RTSX=m
# CONFIG_HISI_HIKEY_USB is not set
# CONFIG_OPEN_DICE is not set
# CONFIG_VCPU_STALL_DETECTOR is not set
# CONFIG_C2PORT is not set

#
# EEPROM support
#
# CONFIG_EEPROM_AT24 is not set
CONFIG_EEPROM_AT25=m
# CONFIG_EEPROM_LEGACY is not set
CONFIG_EEPROM_MAX6875=m
CONFIG_EEPROM_93CX6=m
# CONFIG_EEPROM_93XX46 is not set
CONFIG_EEPROM_IDT_89HPESX=y
# CONFIG_EEPROM_EE1004 is not set
# end of EEPROM support

CONFIG_CB710_CORE=y
# CONFIG_CB710_DEBUG is not set
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
# end of Texas Instruments shared transport line discipline

# CONFIG_SENSORS_LIS3_I2C is not set
CONFIG_ALTERA_STAPL=y
CONFIG_GENWQE=y
CONFIG_GENWQE_PLATFORM_ERROR_RECOVERY=0
CONFIG_ECHO=m
# CONFIG_BCM_VK is not set
CONFIG_MISC_ALCOR_PCI=m
CONFIG_MISC_RTSX_PCI=m
CONFIG_MISC_RTSX_USB=m
CONFIG_HABANA_AI=m
CONFIG_UACCE=m
CONFIG_PVPANIC=y
CONFIG_PVPANIC_MMIO=m
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
# CONFIG_BLK_DEV_SD is not set
CONFIG_CHR_DEV_ST=m
CONFIG_CHR_DEV_SG=m
# CONFIG_BLK_DEV_BSG is not set
CONFIG_CHR_DEV_SCH=y
# CONFIG_SCSI_ENCLOSURE is not set
CONFIG_SCSI_CONSTANTS=y
# CONFIG_SCSI_LOGGING is not set
# CONFIG_SCSI_SCAN_ASYNC is not set

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=m
CONFIG_SCSI_SAS_ATTRS=y
CONFIG_SCSI_SAS_LIBSAS=y
CONFIG_SCSI_SAS_ATA=y
# CONFIG_SCSI_SAS_HOST_SMP is not set
CONFIG_SCSI_SRP_ATTRS=m
# end of SCSI Transports

# CONFIG_SCSI_LOWLEVEL is not set
# CONFIG_SCSI_DH is not set
# end of SCSI device support

CONFIG_ATA=y
CONFIG_SATA_HOST=y
CONFIG_PATA_TIMINGS=y
CONFIG_ATA_VERBOSE_ERROR=y
# CONFIG_ATA_FORCE is not set
CONFIG_ATA_ACPI=y
# CONFIG_SATA_PMP is not set

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI=y
CONFIG_SATA_MOBILE_LPM_POLICY=0
CONFIG_SATA_AHCI_PLATFORM=m
# CONFIG_AHCI_BRCM is not set
CONFIG_AHCI_DA850=m
CONFIG_AHCI_DM816=m
CONFIG_AHCI_IMX=y
# CONFIG_AHCI_CEVA is not set
# CONFIG_AHCI_MTK is not set
CONFIG_AHCI_MVEBU=y
CONFIG_AHCI_SUNXI=y
# CONFIG_AHCI_TEGRA is not set
CONFIG_AHCI_XGENE=m
# CONFIG_AHCI_QORIQ is not set
CONFIG_SATA_FSL=m
# CONFIG_SATA_GEMINI is not set
# CONFIG_SATA_AHCI_SEATTLE is not set
CONFIG_SATA_INIC162X=y
# CONFIG_SATA_ACARD_AHCI is not set
CONFIG_SATA_SIL24=y
# CONFIG_ATA_SFF is not set
# CONFIG_MD is not set
# CONFIG_TARGET_CORE is not set
CONFIG_FUSION=y
CONFIG_FUSION_SPI=m
CONFIG_FUSION_SAS=m
CONFIG_FUSION_MAX_SGE=128
CONFIG_FUSION_CTL=m
# CONFIG_FUSION_LOGGING is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=m
# CONFIG_FIREWIRE_OHCI is not set
CONFIG_FIREWIRE_SBP2=m
CONFIG_FIREWIRE_NOSY=m
# end of IEEE 1394 (FireWire) support

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
CONFIG_INPUT_MOUSEDEV=m
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ADP5588=m
CONFIG_KEYBOARD_ADP5589=m
CONFIG_KEYBOARD_APPLESPI=m
CONFIG_KEYBOARD_ATKBD=y
CONFIG_KEYBOARD_QT1050=m
CONFIG_KEYBOARD_QT1070=m
CONFIG_KEYBOARD_QT2160=y
CONFIG_KEYBOARD_CLPS711X=y
CONFIG_KEYBOARD_DLINK_DIR685=y
CONFIG_KEYBOARD_LKKBD=m
CONFIG_KEYBOARD_EP93XX=y
CONFIG_KEYBOARD_GPIO=y
# CONFIG_KEYBOARD_GPIO_POLLED is not set
CONFIG_KEYBOARD_TCA6416=y
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
CONFIG_KEYBOARD_LM8323=m
CONFIG_KEYBOARD_LM8333=y
# CONFIG_KEYBOARD_MAX7359 is not set
CONFIG_KEYBOARD_MCS=y
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_SNVS_PWRKEY is not set
CONFIG_KEYBOARD_IMX=y
CONFIG_KEYBOARD_IMX_SC_KEY=y
CONFIG_KEYBOARD_NEWTON=y
CONFIG_KEYBOARD_OPENCORES=m
# CONFIG_KEYBOARD_SAMSUNG is not set
CONFIG_KEYBOARD_GOLDFISH_EVENTS=m
CONFIG_KEYBOARD_STOWAWAY=y
# CONFIG_KEYBOARD_ST_KEYSCAN is not set
CONFIG_KEYBOARD_SUNKBD=m
CONFIG_KEYBOARD_SH_KEYSC=m
# CONFIG_KEYBOARD_IQS62X is not set
# CONFIG_KEYBOARD_OMAP4 is not set
CONFIG_KEYBOARD_TM2_TOUCHKEY=y
CONFIG_KEYBOARD_XTKBD=y
# CONFIG_KEYBOARD_CAP11XX is not set
# CONFIG_KEYBOARD_BCM is not set
# CONFIG_KEYBOARD_MT6779 is not set
# CONFIG_KEYBOARD_MTK_PMIC is not set
CONFIG_KEYBOARD_CYPRESS_SF=y
CONFIG_INPUT_MOUSE=y
# CONFIG_MOUSE_PS2 is not set
# CONFIG_MOUSE_SERIAL is not set
CONFIG_MOUSE_APPLETOUCH=m
CONFIG_MOUSE_BCM5974=m
CONFIG_MOUSE_CYAPA=y
CONFIG_MOUSE_ELAN_I2C=y
CONFIG_MOUSE_ELAN_I2C_I2C=y
# CONFIG_MOUSE_ELAN_I2C_SMBUS is not set
CONFIG_MOUSE_VSXXXAA=y
CONFIG_MOUSE_GPIO=m
CONFIG_MOUSE_SYNAPTICS_I2C=y
# CONFIG_MOUSE_SYNAPTICS_USB is not set
CONFIG_INPUT_JOYSTICK=y
CONFIG_JOYSTICK_ANALOG=m
CONFIG_JOYSTICK_A3D=m
CONFIG_JOYSTICK_ADI=y
CONFIG_JOYSTICK_COBRA=y
# CONFIG_JOYSTICK_GF2K is not set
# CONFIG_JOYSTICK_GRIP is not set
# CONFIG_JOYSTICK_GRIP_MP is not set
CONFIG_JOYSTICK_GUILLEMOT=m
# CONFIG_JOYSTICK_INTERACT is not set
# CONFIG_JOYSTICK_SIDEWINDER is not set
CONFIG_JOYSTICK_TMDC=y
CONFIG_JOYSTICK_IFORCE=m
CONFIG_JOYSTICK_IFORCE_USB=m
CONFIG_JOYSTICK_IFORCE_232=m
CONFIG_JOYSTICK_WARRIOR=m
# CONFIG_JOYSTICK_MAGELLAN is not set
CONFIG_JOYSTICK_SPACEORB=m
# CONFIG_JOYSTICK_SPACEBALL is not set
CONFIG_JOYSTICK_STINGER=y
CONFIG_JOYSTICK_TWIDJOY=y
# CONFIG_JOYSTICK_ZHENHUA is not set
# CONFIG_JOYSTICK_DB9 is not set
CONFIG_JOYSTICK_GAMECON=m
# CONFIG_JOYSTICK_TURBOGRAFX is not set
CONFIG_JOYSTICK_AS5011=m
# CONFIG_JOYSTICK_JOYDUMP is not set
CONFIG_JOYSTICK_XPAD=m
CONFIG_JOYSTICK_XPAD_FF=y
CONFIG_JOYSTICK_XPAD_LEDS=y
CONFIG_JOYSTICK_WALKERA0701=m
CONFIG_JOYSTICK_PSXPAD_SPI=m
CONFIG_JOYSTICK_PSXPAD_SPI_FF=y
CONFIG_JOYSTICK_PXRC=m
CONFIG_JOYSTICK_QWIIC=y
# CONFIG_JOYSTICK_FSIA6B is not set
CONFIG_JOYSTICK_SENSEHAT=y
CONFIG_INPUT_TABLET=y
# CONFIG_TABLET_USB_ACECAD is not set
CONFIG_TABLET_USB_AIPTEK=y
CONFIG_TABLET_USB_HANWANG=m
# CONFIG_TABLET_USB_KBTAB is not set
# CONFIG_TABLET_USB_PEGASUS is not set
CONFIG_TABLET_SERIAL_WACOM4=y
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set
CONFIG_RMI4_CORE=m
CONFIG_RMI4_I2C=m
CONFIG_RMI4_SPI=m
CONFIG_RMI4_SMB=m
# CONFIG_RMI4_F03 is not set
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
# CONFIG_RMI4_F34 is not set
CONFIG_RMI4_F3A=y
# CONFIG_RMI4_F55 is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=m
CONFIG_SERIO_PARKBD=m
CONFIG_SERIO_PCIPS2=y
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=m
CONFIG_SERIO_ALTERA_PS2=m
CONFIG_SERIO_PS2MULT=y
CONFIG_SERIO_ARC_PS2=y
# CONFIG_SERIO_APBPS2 is not set
CONFIG_SERIO_OLPC_APSP=m
CONFIG_SERIO_SUN4I_PS2=y
CONFIG_SERIO_GPIO_PS2=y
# CONFIG_USERIO is not set
CONFIG_GAMEPORT=y
CONFIG_GAMEPORT_NS558=m
# CONFIG_GAMEPORT_L4 is not set
CONFIG_GAMEPORT_EMU10K1=m
CONFIG_GAMEPORT_FM801=y
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
# CONFIG_VT is not set
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
# CONFIG_LDISC_AUTOLOAD is not set

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=m
CONFIG_SERIAL_8250_DEPRECATED_OPTIONS=y
# CONFIG_SERIAL_8250_PNP is not set
# CONFIG_SERIAL_8250_16550A_VARIANTS is not set
CONFIG_SERIAL_8250_FINTEK=y
# CONFIG_SERIAL_8250_PCI is not set
CONFIG_SERIAL_8250_MEN_MCB=m
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
# CONFIG_SERIAL_8250_ASPEED_VUART is not set
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
# CONFIG_SERIAL_8250_RSA is not set
CONFIG_SERIAL_8250_DWLIB=y
CONFIG_SERIAL_8250_BCM2835AUX=m
CONFIG_SERIAL_8250_DW=m
CONFIG_SERIAL_8250_EM=m
CONFIG_SERIAL_8250_IOC3=m
CONFIG_SERIAL_8250_RT288X=y
# CONFIG_SERIAL_8250_OMAP is not set
# CONFIG_SERIAL_8250_LPC18XX is not set
# CONFIG_SERIAL_8250_MT6577 is not set
# CONFIG_SERIAL_8250_UNIPHIER is not set
# CONFIG_SERIAL_8250_INGENIC is not set
# CONFIG_SERIAL_8250_LPSS is not set
CONFIG_SERIAL_8250_MID=m
CONFIG_SERIAL_8250_PERICOM=m
CONFIG_SERIAL_8250_PXA=m
CONFIG_SERIAL_8250_TEGRA=m
CONFIG_SERIAL_8250_BCM7271=m
# CONFIG_SERIAL_OF_PLATFORM is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_AMBA_PL010=m
# CONFIG_SERIAL_ATMEL is not set
CONFIG_SERIAL_MESON=m
# CONFIG_SERIAL_MESON_CONSOLE is not set
CONFIG_SERIAL_CLPS711X=m
CONFIG_SERIAL_SAMSUNG=m
CONFIG_SERIAL_SAMSUNG_UARTS_4=y
CONFIG_SERIAL_SAMSUNG_UARTS=4
# CONFIG_SERIAL_SAMSUNG_CONSOLE is not set
CONFIG_SERIAL_TEGRA=m
CONFIG_SERIAL_TEGRA_TCU=y
# CONFIG_SERIAL_TEGRA_TCU_CONSOLE is not set
CONFIG_SERIAL_MAX3100=m
CONFIG_SERIAL_MAX310X=m
CONFIG_SERIAL_IMX=y
CONFIG_SERIAL_IMX_CONSOLE=m
CONFIG_SERIAL_IMX_EARLYCON=y
CONFIG_SERIAL_UARTLITE=y
CONFIG_SERIAL_UARTLITE_CONSOLE=y
CONFIG_SERIAL_UARTLITE_NR_UARTS=1
CONFIG_SERIAL_SH_SCI=y
CONFIG_SERIAL_SH_SCI_NR_UARTS=2
# CONFIG_SERIAL_SH_SCI_CONSOLE is not set
# CONFIG_SERIAL_SH_SCI_EARLYCON is not set
# CONFIG_SERIAL_HS_LPC32XX is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_ICOM is not set
# CONFIG_SERIAL_JSM is not set
# CONFIG_SERIAL_MSM is not set
CONFIG_SERIAL_QCOM_GENI=m
CONFIG_SERIAL_QCOM_GENI_CONSOLE=y
CONFIG_SERIAL_VT8500=y
# CONFIG_SERIAL_VT8500_CONSOLE is not set
CONFIG_SERIAL_OMAP=m
# CONFIG_SERIAL_SIFIVE is not set
CONFIG_SERIAL_LANTIQ=y
CONFIG_SERIAL_LANTIQ_CONSOLE=y
CONFIG_SERIAL_SCCNXP=m
CONFIG_SERIAL_SC16IS7XX_CORE=m
CONFIG_SERIAL_SC16IS7XX=m
# CONFIG_SERIAL_SC16IS7XX_I2C is not set
CONFIG_SERIAL_SC16IS7XX_SPI=y
# CONFIG_SERIAL_TIMBERDALE is not set
# CONFIG_SERIAL_BCM63XX is not set
CONFIG_SERIAL_ALTERA_JTAGUART=m
CONFIG_SERIAL_ALTERA_UART=y
CONFIG_SERIAL_ALTERA_UART_MAXPORTS=4
CONFIG_SERIAL_ALTERA_UART_BAUDRATE=115200
# CONFIG_SERIAL_ALTERA_UART_CONSOLE is not set
CONFIG_SERIAL_PCH_UART=y
# CONFIG_SERIAL_PCH_UART_CONSOLE is not set
CONFIG_SERIAL_MXS_AUART=y
CONFIG_SERIAL_MXS_AUART_CONSOLE=y
# CONFIG_SERIAL_XILINX_PS_UART is not set
# CONFIG_SERIAL_MPS2_UART_CONSOLE is not set
CONFIG_SERIAL_MPS2_UART=y
CONFIG_SERIAL_ARC=y
# CONFIG_SERIAL_ARC_CONSOLE is not set
CONFIG_SERIAL_ARC_NR_PORTS=1
CONFIG_SERIAL_RP2=m
CONFIG_SERIAL_RP2_NR_UARTS=32
CONFIG_SERIAL_FSL_LPUART=m
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
# CONFIG_SERIAL_CONEXANT_DIGICOLOR is not set
CONFIG_SERIAL_ST_ASC=m
CONFIG_SERIAL_MEN_Z135=m
CONFIG_SERIAL_SPRD=y
CONFIG_SERIAL_SPRD_CONSOLE=y
# CONFIG_SERIAL_STM32 is not set
CONFIG_SERIAL_MVEBU_UART=y
# CONFIG_SERIAL_MVEBU_CONSOLE is not set
CONFIG_SERIAL_OWL=y
# CONFIG_SERIAL_OWL_CONSOLE is not set
# CONFIG_SERIAL_RDA is not set
# CONFIG_SERIAL_MILBEAUT_USIO is not set
CONFIG_SERIAL_LITEUART=m
CONFIG_SERIAL_LITEUART_MAX_PORTS=1
CONFIG_SERIAL_SUNPLUS=y
CONFIG_SERIAL_SUNPLUS_CONSOLE=y
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_GOLDFISH_TTY=y
CONFIG_GOLDFISH_TTY_EARLY_CONSOLE=y
# CONFIG_NOZOMI is not set
CONFIG_NULL_TTY=y
CONFIG_HVC_DRIVER=y
# CONFIG_RPMSG_TTY is not set
CONFIG_SERIAL_DEV_BUS=y
CONFIG_SERIAL_DEV_CTRL_TTYPORT=y
CONFIG_TTY_PRINTK=m
CONFIG_TTY_PRINTK_LEVEL=6
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
# CONFIG_PPDEV is not set
CONFIG_VIRTIO_CONSOLE=m
# CONFIG_IPMI_HANDLER is not set
CONFIG_IPMI_KCS_BMC=y
CONFIG_ASPEED_KCS_IPMI_BMC=y
CONFIG_NPCM7XX_KCS_IPMI_BMC=m
# CONFIG_IPMI_KCS_BMC_CDEV_IPMI is not set
CONFIG_IPMI_KCS_BMC_SERIO=y
CONFIG_ASPEED_BT_IPMI_BMC=m
# CONFIG_IPMB_DEVICE_INTERFACE is not set
CONFIG_HW_RANDOM=m
CONFIG_HW_RANDOM_TIMERIOMEM=m
CONFIG_HW_RANDOM_ATMEL=m
CONFIG_HW_RANDOM_BA431=m
CONFIG_HW_RANDOM_BCM2835=m
# CONFIG_HW_RANDOM_IPROC_RNG200 is not set
# CONFIG_HW_RANDOM_IXP4XX is not set
# CONFIG_HW_RANDOM_OMAP is not set
# CONFIG_HW_RANDOM_OMAP3_ROM is not set
CONFIG_HW_RANDOM_VIRTIO=m
CONFIG_HW_RANDOM_IMX_RNGC=m
CONFIG_HW_RANDOM_NOMADIK=m
CONFIG_HW_RANDOM_STM32=m
CONFIG_HW_RANDOM_MESON=m
CONFIG_HW_RANDOM_MTK=m
# CONFIG_HW_RANDOM_EXYNOS is not set
CONFIG_HW_RANDOM_NPCM=m
CONFIG_HW_RANDOM_KEYSTONE=m
# CONFIG_HW_RANDOM_CCTRNG is not set
CONFIG_HW_RANDOM_XIPHERA=m
CONFIG_HW_RANDOM_CN10K=m
# CONFIG_APPLICOM is not set
# CONFIG_DEVMEM is not set
# CONFIG_DEVPORT is not set
# CONFIG_TCG_TPM is not set
CONFIG_XILLYBUS_CLASS=y
CONFIG_XILLYBUS=y
# CONFIG_XILLYBUS_PCIE is not set
# CONFIG_XILLYBUS_OF is not set
CONFIG_XILLYUSB=y
CONFIG_RANDOM_TRUST_CPU=y
CONFIG_RANDOM_TRUST_BOOTLOADER=y
# end of Character devices

#
# I2C support
#
CONFIG_I2C=y
# CONFIG_ACPI_I2C_OPREGION is not set
CONFIG_I2C_BOARDINFO=y
# CONFIG_I2C_COMPAT is not set
# CONFIG_I2C_CHARDEV is not set
# CONFIG_I2C_MUX is not set
CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=y
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCA=m

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
CONFIG_I2C_ALI15X3=y
# CONFIG_I2C_AMD756 is not set
CONFIG_I2C_AMD8111=m
CONFIG_I2C_AMD_MP2=y
CONFIG_I2C_HIX5HD2=y
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_ISCH is not set
CONFIG_I2C_PIIX4=m
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_NVIDIA_GPU is not set
CONFIG_I2C_SIS5595=m
CONFIG_I2C_SIS630=m
CONFIG_I2C_SIS96X=y
CONFIG_I2C_VIA=y
CONFIG_I2C_VIAPRO=m

#
# ACPI drivers
#
CONFIG_I2C_SCMI=y

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_ALTERA is not set
CONFIG_I2C_ASPEED=y
# CONFIG_I2C_AT91 is not set
CONFIG_I2C_AXXIA=m
CONFIG_I2C_BCM2835=m
CONFIG_I2C_BCM_IPROC=m
CONFIG_I2C_BCM_KONA=y
CONFIG_I2C_BRCMSTB=y
CONFIG_I2C_CADENCE=m
CONFIG_I2C_CBUS_GPIO=m
CONFIG_I2C_DAVINCI=y
# CONFIG_I2C_DESIGNWARE_PLATFORM is not set
# CONFIG_I2C_DESIGNWARE_PCI is not set
CONFIG_I2C_DIGICOLOR=y
# CONFIG_I2C_EG20T is not set
CONFIG_I2C_EMEV2=m
# CONFIG_I2C_EXYNOS5 is not set
CONFIG_I2C_GPIO=m
CONFIG_I2C_GPIO_FAULT_INJECTOR=y
CONFIG_I2C_HIGHLANDER=y
# CONFIG_I2C_HISI is not set
CONFIG_I2C_IMG=y
CONFIG_I2C_IMX=y
CONFIG_I2C_IMX_LPI2C=y
CONFIG_I2C_IOP3XX=m
CONFIG_I2C_JZ4780=y
CONFIG_I2C_KEMPLD=m
# CONFIG_I2C_LPC2K is not set
CONFIG_I2C_MESON=m
# CONFIG_I2C_MICROCHIP_CORE is not set
CONFIG_I2C_MT65XX=m
CONFIG_I2C_MT7621=m
# CONFIG_I2C_MV64XXX is not set
# CONFIG_I2C_MXS is not set
# CONFIG_I2C_NPCM is not set
CONFIG_I2C_OCORES=y
CONFIG_I2C_OMAP=y
# CONFIG_I2C_OWL is not set
CONFIG_I2C_APPLE=y
CONFIG_I2C_PCA_PLATFORM=m
# CONFIG_I2C_PNX is not set
CONFIG_I2C_PXA=y
# CONFIG_I2C_PXA_SLAVE is not set
# CONFIG_I2C_QCOM_CCI is not set
CONFIG_I2C_QCOM_GENI=m
CONFIG_I2C_QUP=y
CONFIG_I2C_RIIC=y
# CONFIG_I2C_RK3X is not set
CONFIG_I2C_RZV2M=y
CONFIG_I2C_S3C2410=y
CONFIG_I2C_SH_MOBILE=y
CONFIG_I2C_SIMTEC=m
CONFIG_I2C_SPRD=y
CONFIG_I2C_ST=m
CONFIG_I2C_STM32F4=y
# CONFIG_I2C_STM32F7 is not set
# CONFIG_I2C_SUN6I_P2WI is not set
CONFIG_I2C_SYNQUACER=m
CONFIG_I2C_TEGRA_BPMP=y
# CONFIG_I2C_UNIPHIER is not set
# CONFIG_I2C_UNIPHIER_F is not set
# CONFIG_I2C_VERSATILE is not set
CONFIG_I2C_WMT=y
# CONFIG_I2C_THUNDERX is not set
CONFIG_I2C_XILINX=m
# CONFIG_I2C_XLP9XX is not set
CONFIG_I2C_RCAR=y

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_DIOLAN_U2C=y
CONFIG_I2C_CP2615=y
# CONFIG_I2C_PARPORT is not set
CONFIG_I2C_ROBOTFUZZ_OSIF=m
# CONFIG_I2C_TAOS_EVM is not set
CONFIG_I2C_TINY_USB=m

#
# Other I2C/SMBus bus drivers
#
# CONFIG_I2C_MLXCPLD is not set
# CONFIG_I2C_VIRTIO is not set
# end of I2C Hardware Bus support

CONFIG_I2C_STUB=m
CONFIG_I2C_SLAVE=y
# CONFIG_I2C_SLAVE_EEPROM is not set
CONFIG_I2C_SLAVE_TESTUNIT=y
CONFIG_I2C_DEBUG_CORE=y
# CONFIG_I2C_DEBUG_ALGO is not set
CONFIG_I2C_DEBUG_BUS=y
# end of I2C support

CONFIG_I3C=m
CONFIG_CDNS_I3C_MASTER=m
CONFIG_DW_I3C_MASTER=m
CONFIG_SVC_I3C_MASTER=m
CONFIG_MIPI_I3C_HCI=m
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y
CONFIG_SPI_MEM=y

#
# SPI Master Controller Drivers
#
CONFIG_SPI_ALTERA=y
CONFIG_SPI_ALTERA_CORE=y
# CONFIG_SPI_ALTERA_DFL is not set
# CONFIG_SPI_AR934X is not set
CONFIG_SPI_ATH79=y
# CONFIG_SPI_ARMADA_3700 is not set
# CONFIG_SPI_ASPEED_SMC is not set
# CONFIG_SPI_ATMEL is not set
CONFIG_SPI_AT91_USART=m
# CONFIG_SPI_ATMEL_QUADSPI is not set
CONFIG_SPI_AXI_SPI_ENGINE=m
CONFIG_SPI_BCM2835=m
CONFIG_SPI_BCM2835AUX=y
# CONFIG_SPI_BCM63XX is not set
# CONFIG_SPI_BCM63XX_HSSPI is not set
# CONFIG_SPI_BCM_QSPI is not set
CONFIG_SPI_BITBANG=y
CONFIG_SPI_BUTTERFLY=m
# CONFIG_SPI_CADENCE is not set
# CONFIG_SPI_CADENCE_QUADSPI is not set
# CONFIG_SPI_CADENCE_XSPI is not set
CONFIG_SPI_CLPS711X=y
# CONFIG_SPI_DESIGNWARE is not set
CONFIG_SPI_EP93XX=y
CONFIG_SPI_FSL_LPSPI=m
CONFIG_SPI_FSL_QUADSPI=y
CONFIG_SPI_GXP=y
CONFIG_SPI_HISI_KUNPENG=m
CONFIG_SPI_HISI_SFC_V3XX=m
CONFIG_SPI_NXP_FLEXSPI=m
# CONFIG_SPI_GPIO is not set
CONFIG_SPI_IMG_SPFI=y
# CONFIG_SPI_IMX is not set
CONFIG_SPI_INGENIC=y
CONFIG_SPI_INTEL=m
CONFIG_SPI_INTEL_PCI=m
CONFIG_SPI_INTEL_PLATFORM=m
# CONFIG_SPI_JCORE is not set
# CONFIG_SPI_LM70_LLP is not set
# CONFIG_SPI_LP8841_RTC is not set
# CONFIG_SPI_FSL_SPI is not set
CONFIG_SPI_FSL_DSPI=m
CONFIG_SPI_MESON_SPICC=y
# CONFIG_SPI_MESON_SPIFC is not set
# CONFIG_SPI_MICROCHIP_CORE is not set
CONFIG_SPI_MT65XX=m
CONFIG_SPI_MT7621=y
CONFIG_SPI_MTK_NOR=y
CONFIG_SPI_MTK_SNFI=y
# CONFIG_SPI_NPCM_FIU is not set
CONFIG_SPI_NPCM_PSPI=y
CONFIG_SPI_LANTIQ_SSC=y
CONFIG_SPI_OC_TINY=y
# CONFIG_SPI_OMAP24XX is not set
# CONFIG_SPI_TI_QSPI is not set
# CONFIG_SPI_OMAP_100K is not set
CONFIG_SPI_ORION=y
CONFIG_SPI_PIC32=y
# CONFIG_SPI_PIC32_SQI is not set
CONFIG_SPI_PXA2XX=m
CONFIG_SPI_PXA2XX_PCI=m
CONFIG_SPI_ROCKCHIP=m
CONFIG_SPI_ROCKCHIP_SFC=y
CONFIG_SPI_RSPI=y
CONFIG_SPI_QUP=m
# CONFIG_SPI_QCOM_GENI is not set
# CONFIG_SPI_S3C64XX is not set
CONFIG_SPI_SC18IS602=m
CONFIG_SPI_SH_MSIOF=y
CONFIG_SPI_SH=y
CONFIG_SPI_SH_HSPI=m
CONFIG_SPI_SIFIVE=y
CONFIG_SPI_SPRD=y
# CONFIG_SPI_SPRD_ADI is not set
# CONFIG_SPI_STM32 is not set
# CONFIG_SPI_STM32_QSPI is not set
# CONFIG_SPI_ST_SSC4 is not set
# CONFIG_SPI_SUN4I is not set
# CONFIG_SPI_SUN6I is not set
CONFIG_SPI_SUNPLUS_SP7021=y
CONFIG_SPI_SYNQUACER=m
CONFIG_SPI_MXIC=m
CONFIG_SPI_TEGRA210_QUAD=y
CONFIG_SPI_TEGRA114=y
CONFIG_SPI_TEGRA20_SFLASH=y
CONFIG_SPI_TEGRA20_SLINK=y
# CONFIG_SPI_THUNDERX is not set
CONFIG_SPI_TOPCLIFF_PCH=y
# CONFIG_SPI_UNIPHIER is not set
# CONFIG_SPI_XCOMM is not set
CONFIG_SPI_XILINX=m
CONFIG_SPI_XLP=m
CONFIG_SPI_XTENSA_XTFPGA=y
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
# CONFIG_SPI_LOOPBACK_TEST is not set
CONFIG_SPI_TLE62X0=m
# CONFIG_SPI_SLAVE is not set
CONFIG_SPI_DYNAMIC=y
CONFIG_SPMI=y
# CONFIG_SPMI_HISI3670 is not set
CONFIG_SPMI_MSM_PMIC_ARB=y
CONFIG_SPMI_MTK_PMIF=m
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
CONFIG_GENERIC_PINCTRL_GROUPS=y
CONFIG_PINMUX=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
CONFIG_DEBUG_PINCTRL=y
# CONFIG_PINCTRL_AMD is not set
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
CONFIG_PINCTRL_CS47L15=y
CONFIG_PINCTRL_CS47L90=y
CONFIG_PINCTRL_CS47L92=y

#
# Intel pinctrl drivers
#
# CONFIG_PINCTRL_BAYTRAIL is not set
# CONFIG_PINCTRL_CHERRYVIEW is not set
CONFIG_PINCTRL_LYNXPOINT=m
CONFIG_PINCTRL_INTEL=y
CONFIG_PINCTRL_ALDERLAKE=y
CONFIG_PINCTRL_BROXTON=y
# CONFIG_PINCTRL_CANNONLAKE is not set
CONFIG_PINCTRL_CEDARFORK=y
CONFIG_PINCTRL_DENVERTON=y
# CONFIG_PINCTRL_ELKHARTLAKE is not set
CONFIG_PINCTRL_EMMITSBURG=m
CONFIG_PINCTRL_GEMINILAKE=y
CONFIG_PINCTRL_ICELAKE=m
# CONFIG_PINCTRL_JASPERLAKE is not set
CONFIG_PINCTRL_LAKEFIELD=y
# CONFIG_PINCTRL_LEWISBURG is not set
CONFIG_PINCTRL_METEORLAKE=y
CONFIG_PINCTRL_SUNRISEPOINT=y
CONFIG_PINCTRL_TIGERLAKE=m
# end of Intel pinctrl drivers

#
# MediaTek pinctrl drivers
#
CONFIG_EINT_MTK=y
CONFIG_PINCTRL_MTK=y
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
CONFIG_PINCTRL_MT6397=y
# end of MediaTek pinctrl drivers

CONFIG_PINCTRL_MESON=y
# CONFIG_PINCTRL_WPCM450 is not set
# CONFIG_PINCTRL_NPCM7XX is not set
CONFIG_PINCTRL_PXA=y
# CONFIG_PINCTRL_PXA25X is not set
CONFIG_PINCTRL_PXA27X=y
CONFIG_PINCTRL_MSM=m
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
# CONFIG_PINCTRL_MSM8909 is not set
# CONFIG_PINCTRL_MSM8916 is not set
# CONFIG_PINCTRL_MSM8953 is not set
# CONFIG_PINCTRL_MSM8976 is not set
# CONFIG_PINCTRL_MSM8994 is not set
# CONFIG_PINCTRL_MSM8996 is not set
# CONFIG_PINCTRL_MSM8998 is not set
# CONFIG_PINCTRL_QCM2290 is not set
# CONFIG_PINCTRL_QCS404 is not set
CONFIG_PINCTRL_QDF2XXX=m
# CONFIG_PINCTRL_QCOM_SPMI_PMIC is not set
# CONFIG_PINCTRL_QCOM_SSBI_PMIC is not set
# CONFIG_PINCTRL_SC7180 is not set
# CONFIG_PINCTRL_SC7280 is not set
CONFIG_PINCTRL_SC7280_LPASS_LPI=m
# CONFIG_PINCTRL_SC8180X is not set
# CONFIG_PINCTRL_SC8280XP is not set
# CONFIG_PINCTRL_SDM660 is not set
# CONFIG_PINCTRL_SDM845 is not set
# CONFIG_PINCTRL_SDX55 is not set
# CONFIG_PINCTRL_SM6115 is not set
# CONFIG_PINCTRL_SM6125 is not set
# CONFIG_PINCTRL_SM6350 is not set
# CONFIG_PINCTRL_SM6375 is not set
# CONFIG_PINCTRL_SDX65 is not set
# CONFIG_PINCTRL_SM8150 is not set
# CONFIG_PINCTRL_SM8250 is not set
CONFIG_PINCTRL_SM8250_LPASS_LPI=y
# CONFIG_PINCTRL_SM8350 is not set
# CONFIG_PINCTRL_SM8450 is not set
CONFIG_PINCTRL_LPASS_LPI=y

#
# Renesas pinctrl drivers
#
CONFIG_PINCTRL_RENESAS=y
CONFIG_PINCTRL_SH_PFC=y
CONFIG_PINCTRL_SH_PFC_GPIO=y
CONFIG_PINCTRL_SH_FUNC_GPIO=y
# CONFIG_PINCTRL_PFC_EMEV2 is not set
CONFIG_PINCTRL_PFC_R8A77995=y
CONFIG_PINCTRL_PFC_R8A7794=y
CONFIG_PINCTRL_PFC_R8A77990=y
# CONFIG_PINCTRL_PFC_R8A7779 is not set
# CONFIG_PINCTRL_PFC_R8A7790 is not set
CONFIG_PINCTRL_PFC_R8A77950=y
CONFIG_PINCTRL_PFC_R8A77951=y
CONFIG_PINCTRL_PFC_R8A7778=y
CONFIG_PINCTRL_PFC_R8A7793=y
# CONFIG_PINCTRL_PFC_R8A7791 is not set
# CONFIG_PINCTRL_PFC_R8A77965 is not set
# CONFIG_PINCTRL_PFC_R8A77960 is not set
# CONFIG_PINCTRL_PFC_R8A77961 is not set
# CONFIG_PINCTRL_PFC_R8A779F0 is not set
# CONFIG_PINCTRL_PFC_R8A7792 is not set
CONFIG_PINCTRL_PFC_R8A77980=y
# CONFIG_PINCTRL_PFC_R8A77970 is not set
# CONFIG_PINCTRL_PFC_R8A779A0 is not set
CONFIG_PINCTRL_PFC_R8A779G0=y
# CONFIG_PINCTRL_PFC_R8A7740 is not set
CONFIG_PINCTRL_PFC_R8A73A4=y
# CONFIG_PINCTRL_RZA1 is not set
# CONFIG_PINCTRL_RZA2 is not set
# CONFIG_PINCTRL_RZG2L is not set
# CONFIG_PINCTRL_PFC_R8A77470 is not set
CONFIG_PINCTRL_PFC_R8A7745=y
CONFIG_PINCTRL_PFC_R8A7742=y
# CONFIG_PINCTRL_PFC_R8A7743 is not set
CONFIG_PINCTRL_PFC_R8A7744=y
# CONFIG_PINCTRL_PFC_R8A774C0 is not set
# CONFIG_PINCTRL_PFC_R8A774E1 is not set
# CONFIG_PINCTRL_PFC_R8A774A1 is not set
# CONFIG_PINCTRL_PFC_R8A774B1 is not set
# CONFIG_PINCTRL_RZN1 is not set
# CONFIG_PINCTRL_RZV2M is not set
# CONFIG_PINCTRL_PFC_SH7203 is not set
CONFIG_PINCTRL_PFC_SH7264=y
CONFIG_PINCTRL_PFC_SH7269=y
# CONFIG_PINCTRL_PFC_SH7720 is not set
# CONFIG_PINCTRL_PFC_SH7722 is not set
CONFIG_PINCTRL_PFC_SH7734=y
CONFIG_PINCTRL_PFC_SH7757=y
# CONFIG_PINCTRL_PFC_SH7785 is not set
CONFIG_PINCTRL_PFC_SH7786=y
CONFIG_PINCTRL_PFC_SH73A0=y
# CONFIG_PINCTRL_PFC_SH7723 is not set
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
CONFIG_DEBUG_GPIO=y
# CONFIG_GPIO_SYSFS is not set
CONFIG_GPIO_CDEV=y
# CONFIG_GPIO_CDEV_V1 is not set
CONFIG_GPIO_GENERIC=y
CONFIG_GPIO_REGMAP=m
CONFIG_GPIO_MAX730X=m

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_74XX_MMIO is not set
# CONFIG_GPIO_ALTERA is not set
CONFIG_GPIO_AMDPT=y
# CONFIG_GPIO_ASPEED is not set
# CONFIG_GPIO_ASPEED_SGPIO is not set
CONFIG_GPIO_ATH79=m
# CONFIG_GPIO_RASPBERRYPI_EXP is not set
# CONFIG_GPIO_BCM_KONA is not set
# CONFIG_GPIO_BCM_XGS_IPROC is not set
# CONFIG_GPIO_BRCMSTB is not set
# CONFIG_GPIO_CADENCE is not set
CONFIG_GPIO_CLPS711X=y
CONFIG_GPIO_DWAPB=y
# CONFIG_GPIO_EIC_SPRD is not set
# CONFIG_GPIO_EM is not set
# CONFIG_GPIO_FTGPIO010 is not set
# CONFIG_GPIO_GENERIC_PLATFORM is not set
# CONFIG_GPIO_GRGPIO is not set
CONFIG_GPIO_HISI=m
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
CONFIG_GPIO_PXA=y
CONFIG_GPIO_RCAR=m
# CONFIG_GPIO_RDA is not set
CONFIG_GPIO_ROCKCHIP=y
# CONFIG_GPIO_SAMA5D2_PIOBU is not set
# CONFIG_GPIO_SIFIVE is not set
CONFIG_GPIO_SIOX=m
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
# CONFIG_GPIO_XGENE_SB is not set
# CONFIG_GPIO_XILINX is not set
# CONFIG_GPIO_XLP is not set
# CONFIG_GPIO_AMD_FCH is not set
CONFIG_GPIO_IDT3243X=m
# end of Memory mapped GPIO drivers

#
# I2C GPIO expanders
#
# CONFIG_GPIO_ADP5588 is not set
# CONFIG_GPIO_ADNP is not set
# CONFIG_GPIO_GW_PLD is not set
# CONFIG_GPIO_MAX7300 is not set
# CONFIG_GPIO_MAX732X is not set
CONFIG_GPIO_PCA953X=y
CONFIG_GPIO_PCA953X_IRQ=y
CONFIG_GPIO_PCA9570=m
# CONFIG_GPIO_PCF857X is not set
CONFIG_GPIO_TPIC2810=y
CONFIG_GPIO_TS4900=m
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
# CONFIG_GPIO_ARIZONA is not set
CONFIG_GPIO_BD9571MWV=m
# CONFIG_GPIO_DA9052 is not set
CONFIG_GPIO_DA9055=m
CONFIG_GPIO_KEMPLD=m
# CONFIG_GPIO_MADERA is not set
# CONFIG_GPIO_MAX77650 is not set
# CONFIG_GPIO_RC5T583 is not set
CONFIG_GPIO_SL28CPLD=m
CONFIG_GPIO_TIMBERDALE=y
# CONFIG_GPIO_TPS65086 is not set
# CONFIG_GPIO_TPS65910 is not set
# CONFIG_GPIO_TPS65912 is not set
CONFIG_GPIO_TQMX86=y
CONFIG_GPIO_WM8350=y
CONFIG_GPIO_WM8994=m
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
CONFIG_GPIO_BT8XX=y
CONFIG_GPIO_MLXBF=m
# CONFIG_GPIO_MLXBF2 is not set
CONFIG_GPIO_ML_IOH=y
CONFIG_GPIO_PCH=m
# CONFIG_GPIO_PCI_IDIO_16 is not set
CONFIG_GPIO_PCIE_IDIO_24=m
CONFIG_GPIO_RDC321X=m
# end of PCI GPIO expanders

#
# SPI GPIO expanders
#
# CONFIG_GPIO_74X164 is not set
CONFIG_GPIO_MAX3191X=m
CONFIG_GPIO_MAX7301=m
CONFIG_GPIO_MC33880=y
# CONFIG_GPIO_PISOSR is not set
CONFIG_GPIO_XRA1403=m
# end of SPI GPIO expanders

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
CONFIG_GPIO_SIM=m
# end of Virtual GPIO drivers

CONFIG_W1=y

#
# 1-wire Bus Masters
#
CONFIG_W1_MASTER_MATROX=y
CONFIG_W1_MASTER_DS2490=y
# CONFIG_W1_MASTER_DS2482 is not set
CONFIG_W1_MASTER_MXC=m
CONFIG_W1_MASTER_DS1WM=m
CONFIG_W1_MASTER_GPIO=y
# CONFIG_W1_MASTER_SGI is not set
# end of 1-wire Bus Masters

#
# 1-wire Slaves
#
# CONFIG_W1_SLAVE_THERM is not set
CONFIG_W1_SLAVE_SMEM=y
CONFIG_W1_SLAVE_DS2405=m
CONFIG_W1_SLAVE_DS2408=y
CONFIG_W1_SLAVE_DS2408_READBACK=y
# CONFIG_W1_SLAVE_DS2413 is not set
CONFIG_W1_SLAVE_DS2406=y
CONFIG_W1_SLAVE_DS2423=m
CONFIG_W1_SLAVE_DS2805=m
# CONFIG_W1_SLAVE_DS2430 is not set
CONFIG_W1_SLAVE_DS2431=y
CONFIG_W1_SLAVE_DS2433=y
CONFIG_W1_SLAVE_DS2433_CRC=y
# CONFIG_W1_SLAVE_DS2438 is not set
CONFIG_W1_SLAVE_DS250X=m
CONFIG_W1_SLAVE_DS2780=y
CONFIG_W1_SLAVE_DS2781=y
CONFIG_W1_SLAVE_DS28E04=y
# CONFIG_W1_SLAVE_DS28E17 is not set
# end of 1-wire Slaves

# CONFIG_POWER_RESET is not set
CONFIG_POWER_SUPPLY=y
CONFIG_POWER_SUPPLY_DEBUG=y
# CONFIG_POWER_SUPPLY_HWMON is not set
# CONFIG_PDA_POWER is not set
CONFIG_IP5XXX_POWER=y
CONFIG_WM8350_POWER=y
CONFIG_TEST_POWER=y
CONFIG_BATTERY_88PM860X=m
CONFIG_CHARGER_ADP5061=m
# CONFIG_BATTERY_ACT8945A is not set
CONFIG_BATTERY_CW2015=m
CONFIG_BATTERY_DS2760=m
CONFIG_BATTERY_DS2780=m
# CONFIG_BATTERY_DS2781 is not set
# CONFIG_BATTERY_DS2782 is not set
CONFIG_BATTERY_SAMSUNG_SDI=y
CONFIG_BATTERY_SBS=m
CONFIG_CHARGER_SBS=m
# CONFIG_BATTERY_BQ27XXX is not set
# CONFIG_BATTERY_DA9030 is not set
CONFIG_BATTERY_DA9052=y
CONFIG_BATTERY_DA9150=m
# CONFIG_BATTERY_MAX17040 is not set
# CONFIG_BATTERY_MAX17042 is not set
# CONFIG_BATTERY_MAX1721X is not set
# CONFIG_CHARGER_88PM860X is not set
CONFIG_CHARGER_ISP1704=m
CONFIG_CHARGER_MAX8903=m
CONFIG_CHARGER_LP8727=m
CONFIG_CHARGER_GPIO=m
CONFIG_CHARGER_MANAGER=m
# CONFIG_CHARGER_LT3651 is not set
CONFIG_CHARGER_LTC4162L=m
# CONFIG_CHARGER_MAX14577 is not set
# CONFIG_CHARGER_DETECTOR_MAX14656 is not set
CONFIG_CHARGER_MAX77650=y
# CONFIG_CHARGER_MAX77693 is not set
CONFIG_CHARGER_MAX77976=m
CONFIG_CHARGER_MAX8998=m
CONFIG_CHARGER_MT6360=m
# CONFIG_CHARGER_QCOM_SMBB is not set
CONFIG_CHARGER_BQ2415X=y
CONFIG_CHARGER_BQ24190=m
CONFIG_CHARGER_BQ24257=m
CONFIG_CHARGER_BQ24735=y
CONFIG_CHARGER_BQ2515X=y
# CONFIG_CHARGER_BQ25890 is not set
CONFIG_CHARGER_BQ25980=y
# CONFIG_CHARGER_BQ256XX is not set
CONFIG_CHARGER_SMB347=y
CONFIG_CHARGER_TPS65090=m
CONFIG_BATTERY_GAUGE_LTC2941=m
CONFIG_BATTERY_GOLDFISH=m
CONFIG_BATTERY_RT5033=y
CONFIG_CHARGER_RT9455=m
CONFIG_CHARGER_SC2731=y
# CONFIG_CHARGER_UCS1002 is not set
# CONFIG_CHARGER_BD99954 is not set
CONFIG_BATTERY_ACER_A500=m
# CONFIG_BATTERY_UG3105 is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_AD7314=m
# CONFIG_SENSORS_AD7414 is not set
# CONFIG_SENSORS_AD7418 is not set
CONFIG_SENSORS_ADM1025=m
# CONFIG_SENSORS_ADM1026 is not set
CONFIG_SENSORS_ADM1029=y
CONFIG_SENSORS_ADM1031=y
CONFIG_SENSORS_ADM1177=y
CONFIG_SENSORS_ADM9240=m
CONFIG_SENSORS_ADT7X10=m
CONFIG_SENSORS_ADT7310=m
# CONFIG_SENSORS_ADT7410 is not set
CONFIG_SENSORS_ADT7411=m
# CONFIG_SENSORS_ADT7462 is not set
CONFIG_SENSORS_ADT7470=m
CONFIG_SENSORS_ADT7475=m
# CONFIG_SENSORS_AHT10 is not set
CONFIG_SENSORS_AQUACOMPUTER_D5NEXT=m
CONFIG_SENSORS_AS370=y
CONFIG_SENSORS_ASC7621=y
CONFIG_SENSORS_AXI_FAN_CONTROL=m
# CONFIG_SENSORS_ARM_SCMI is not set
CONFIG_SENSORS_ASB100=y
# CONFIG_SENSORS_ASPEED is not set
CONFIG_SENSORS_ATXP1=m
# CONFIG_SENSORS_BT1_PVT is not set
CONFIG_SENSORS_CORSAIR_CPRO=y
# CONFIG_SENSORS_CORSAIR_PSU is not set
# CONFIG_SENSORS_DRIVETEMP is not set
CONFIG_SENSORS_DS620=m
# CONFIG_SENSORS_DS1621 is not set
CONFIG_SENSORS_DA9052_ADC=y
# CONFIG_SENSORS_DA9055 is not set
CONFIG_SENSORS_I5K_AMB=m
# CONFIG_SENSORS_SPARX5 is not set
# CONFIG_SENSORS_F71805F is not set
CONFIG_SENSORS_F71882FG=y
CONFIG_SENSORS_F75375S=m
# CONFIG_SENSORS_MC13783_ADC is not set
CONFIG_SENSORS_FSCHMD=m
# CONFIG_SENSORS_GL518SM is not set
# CONFIG_SENSORS_GL520SM is not set
# CONFIG_SENSORS_G760A is not set
# CONFIG_SENSORS_G762 is not set
# CONFIG_SENSORS_GPIO_FAN is not set
# CONFIG_SENSORS_HIH6130 is not set
CONFIG_SENSORS_IT87=m
# CONFIG_SENSORS_JC42 is not set
CONFIG_SENSORS_POWR1220=y
CONFIG_SENSORS_LAN966X=m
# CONFIG_SENSORS_LINEAGE is not set
CONFIG_SENSORS_LTC2945=y
CONFIG_SENSORS_LTC2947=y
# CONFIG_SENSORS_LTC2947_I2C is not set
CONFIG_SENSORS_LTC2947_SPI=y
CONFIG_SENSORS_LTC2990=y
CONFIG_SENSORS_LTC2992=y
CONFIG_SENSORS_LTC4151=y
CONFIG_SENSORS_LTC4215=m
CONFIG_SENSORS_LTC4222=m
CONFIG_SENSORS_LTC4245=y
# CONFIG_SENSORS_LTC4260 is not set
# CONFIG_SENSORS_LTC4261 is not set
CONFIG_SENSORS_MAX1111=y
CONFIG_SENSORS_MAX127=y
CONFIG_SENSORS_MAX16065=y
CONFIG_SENSORS_MAX1619=y
CONFIG_SENSORS_MAX1668=y
CONFIG_SENSORS_MAX197=y
CONFIG_SENSORS_MAX31722=y
CONFIG_SENSORS_MAX31730=m
CONFIG_SENSORS_MAX6620=y
CONFIG_SENSORS_MAX6621=y
CONFIG_SENSORS_MAX6639=y
CONFIG_SENSORS_MAX6650=y
CONFIG_SENSORS_MAX6697=y
# CONFIG_SENSORS_MAX31790 is not set
# CONFIG_SENSORS_MCP3021 is not set
# CONFIG_SENSORS_TC654 is not set
# CONFIG_SENSORS_TPS23861 is not set
CONFIG_SENSORS_MENF21BMC_HWMON=m
CONFIG_SENSORS_MR75203=m
CONFIG_SENSORS_ADCXX=m
CONFIG_SENSORS_LM63=y
CONFIG_SENSORS_LM70=m
# CONFIG_SENSORS_LM73 is not set
CONFIG_SENSORS_LM75=m
# CONFIG_SENSORS_LM77 is not set
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=m
# CONFIG_SENSORS_LM83 is not set
# CONFIG_SENSORS_LM85 is not set
CONFIG_SENSORS_LM87=m
CONFIG_SENSORS_LM90=y
CONFIG_SENSORS_LM92=m
# CONFIG_SENSORS_LM93 is not set
CONFIG_SENSORS_LM95234=m
# CONFIG_SENSORS_LM95241 is not set
CONFIG_SENSORS_LM95245=y
CONFIG_SENSORS_PC87360=m
# CONFIG_SENSORS_PC87427 is not set
CONFIG_SENSORS_NCT6683=m
CONFIG_SENSORS_NCT6775_CORE=m
# CONFIG_SENSORS_NCT6775 is not set
CONFIG_SENSORS_NCT6775_I2C=m
CONFIG_SENSORS_NCT7802=y
CONFIG_SENSORS_NPCM7XX=y
# CONFIG_SENSORS_NSA320 is not set
CONFIG_SENSORS_NZXT_KRAKEN2=m
# CONFIG_SENSORS_NZXT_SMART2 is not set
CONFIG_SENSORS_OCC_P8_I2C=y
CONFIG_SENSORS_OCC=y
CONFIG_SENSORS_PCF8591=m
CONFIG_SENSORS_PECI_CPUTEMP=m
CONFIG_SENSORS_PECI_DIMMTEMP=y
CONFIG_SENSORS_PECI=y
# CONFIG_PMBUS is not set
CONFIG_SENSORS_PWM_FAN=m
# CONFIG_SENSORS_RASPBERRYPI_HWMON is not set
# CONFIG_SENSORS_SL28CPLD is not set
# CONFIG_SENSORS_SBTSI is not set
CONFIG_SENSORS_SBRMI=m
CONFIG_SENSORS_SHT15=y
CONFIG_SENSORS_SHT21=y
CONFIG_SENSORS_SHT3x=m
CONFIG_SENSORS_SHT4x=y
# CONFIG_SENSORS_SHTC1 is not set
CONFIG_SENSORS_SIS5595=m
CONFIG_SENSORS_SY7636A=y
CONFIG_SENSORS_DME1737=y
# CONFIG_SENSORS_EMC1403 is not set
# CONFIG_SENSORS_EMC2103 is not set
CONFIG_SENSORS_EMC6W201=y
CONFIG_SENSORS_SMSC47M1=y
CONFIG_SENSORS_SMSC47M192=y
# CONFIG_SENSORS_SMSC47B397 is not set
CONFIG_SENSORS_STTS751=y
CONFIG_SENSORS_SMM665=y
CONFIG_SENSORS_ADC128D818=m
CONFIG_SENSORS_ADS7828=m
# CONFIG_SENSORS_ADS7871 is not set
CONFIG_SENSORS_AMC6821=m
CONFIG_SENSORS_INA209=m
# CONFIG_SENSORS_INA2XX is not set
CONFIG_SENSORS_INA238=y
CONFIG_SENSORS_INA3221=m
CONFIG_SENSORS_TC74=y
CONFIG_SENSORS_THMC50=m
# CONFIG_SENSORS_TMP102 is not set
CONFIG_SENSORS_TMP103=y
CONFIG_SENSORS_TMP108=y
# CONFIG_SENSORS_TMP401 is not set
CONFIG_SENSORS_TMP421=m
CONFIG_SENSORS_TMP464=m
CONFIG_SENSORS_TMP513=m
# CONFIG_SENSORS_VIA686A is not set
# CONFIG_SENSORS_VT1211 is not set
CONFIG_SENSORS_VT8231=m
CONFIG_SENSORS_W83773G=y
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83791D=m
CONFIG_SENSORS_W83792D=y
CONFIG_SENSORS_W83793=y
CONFIG_SENSORS_W83795=y
# CONFIG_SENSORS_W83795_FANCTRL is not set
# CONFIG_SENSORS_W83L785TS is not set
# CONFIG_SENSORS_W83L786NG is not set
# CONFIG_SENSORS_W83627HF is not set
# CONFIG_SENSORS_W83627EHF is not set
CONFIG_SENSORS_WM8350=m

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=m
CONFIG_THERMAL=y
CONFIG_THERMAL_STATISTICS=y
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_OF=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
# CONFIG_THERMAL_GOV_FAIR_SHARE is not set
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
# CONFIG_THERMAL_GOV_USER_SPACE is not set
# CONFIG_CPU_THERMAL is not set
CONFIG_DEVFREQ_THERMAL=y
# CONFIG_THERMAL_EMULATION is not set
# CONFIG_THERMAL_MMIO is not set
CONFIG_HISI_THERMAL=y
# CONFIG_IMX_THERMAL is not set
# CONFIG_IMX_SC_THERMAL is not set
# CONFIG_IMX8MM_THERMAL is not set
CONFIG_K3_THERMAL=m
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
# CONFIG_BCM2711_THERMAL is not set
# CONFIG_BCM2835_THERMAL is not set
# CONFIG_BRCMSTB_THERMAL is not set
CONFIG_BCM_NS_THERMAL=m
CONFIG_BCM_SR_THERMAL=y
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
# CONFIG_TEGRA_BPMP_THERMAL is not set
CONFIG_TEGRA30_TSENSOR=y
# end of NVIDIA Tegra thermal drivers

#
# Qualcomm thermal drivers
#
# end of Qualcomm thermal drivers

# CONFIG_UNIPHIER_THERMAL is not set
# CONFIG_SPRD_THERMAL is not set
# CONFIG_KHADAS_MCU_FAN_THERMAL is not set
# CONFIG_WATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
# CONFIG_SSB_PCIHOST is not set
# CONFIG_SSB_HOST_SOC is not set
# CONFIG_SSB_DRIVER_GPIO is not set
CONFIG_BCMA_POSSIBLE=y
# CONFIG_BCMA is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_ACT8945A is not set
# CONFIG_MFD_SUN4I_GPADC is not set
# CONFIG_MFD_AS3711 is not set
# CONFIG_MFD_AS3722 is not set
# CONFIG_PMIC_ADP5520 is not set
CONFIG_MFD_AAT2870_CORE=y
CONFIG_MFD_AT91_USART=m
# CONFIG_MFD_ATMEL_FLEXCOM is not set
# CONFIG_MFD_ATMEL_HLCDC is not set
CONFIG_MFD_ATMEL_SMC=y
CONFIG_MFD_BCM590XX=y
CONFIG_MFD_BD9571MWV=m
CONFIG_MFD_AXP20X=y
CONFIG_MFD_AXP20X_I2C=y
CONFIG_MFD_MADERA=y
# CONFIG_MFD_MADERA_I2C is not set
CONFIG_MFD_MADERA_SPI=m
CONFIG_MFD_CS47L15=y
# CONFIG_MFD_CS47L35 is not set
# CONFIG_MFD_CS47L85 is not set
CONFIG_MFD_CS47L90=y
CONFIG_MFD_CS47L92=y
# CONFIG_MFD_ASIC3 is not set
CONFIG_PMIC_DA903X=y
CONFIG_PMIC_DA9052=y
CONFIG_MFD_DA9052_SPI=y
# CONFIG_MFD_DA9052_I2C is not set
CONFIG_MFD_DA9055=y
CONFIG_MFD_DA9062=y
CONFIG_MFD_DA9063=y
CONFIG_MFD_DA9150=m
# CONFIG_MFD_DLN2 is not set
CONFIG_MFD_ENE_KB3930=m
# CONFIG_MFD_EXYNOS_LPASS is not set
# CONFIG_MFD_GATEWORKS_GSC is not set
CONFIG_MFD_MC13XXX=y
# CONFIG_MFD_MC13XXX_SPI is not set
CONFIG_MFD_MC13XXX_I2C=y
CONFIG_MFD_MP2629=y
CONFIG_MFD_MXS_LRADC=y
CONFIG_MFD_MX25_TSADC=y
# CONFIG_MFD_HI6421_PMIC is not set
# CONFIG_MFD_HI6421_SPMI is not set
# CONFIG_MFD_HI655X_PMIC is not set
CONFIG_HTC_PASIC3=m
# CONFIG_HTC_I2CPLD is not set
CONFIG_LPC_ICH=m
# CONFIG_LPC_SCH is not set
CONFIG_MFD_IQS62X=y
# CONFIG_MFD_JANZ_CMODIO is not set
CONFIG_MFD_KEMPLD=m
# CONFIG_MFD_88PM800 is not set
CONFIG_MFD_88PM805=m
CONFIG_MFD_88PM860X=y
CONFIG_MFD_MAX14577=y
# CONFIG_MFD_MAX77620 is not set
CONFIG_MFD_MAX77650=y
CONFIG_MFD_MAX77686=y
CONFIG_MFD_MAX77693=y
CONFIG_MFD_MAX77714=m
CONFIG_MFD_MAX77843=y
CONFIG_MFD_MAX8907=m
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
CONFIG_MFD_MAX8998=y
CONFIG_MFD_MT6360=m
CONFIG_MFD_MT6397=y
CONFIG_MFD_MENF21BMC=y
CONFIG_EZX_PCAP=y
CONFIG_MFD_CPCAP=y
# CONFIG_MFD_VIPERBOARD is not set
CONFIG_MFD_NTXEC=m
CONFIG_MFD_RETU=m
# CONFIG_MFD_PCF50633 is not set
# CONFIG_UCB1400_CORE is not set
# CONFIG_MFD_PM8XXX is not set
# CONFIG_MFD_SPMI_PMIC is not set
CONFIG_MFD_RDC321X=m
CONFIG_MFD_RT4831=y
CONFIG_MFD_RT5033=m
CONFIG_MFD_RC5T583=y
# CONFIG_MFD_RK808 is not set
# CONFIG_MFD_RN5T618 is not set
CONFIG_MFD_SEC_CORE=m
CONFIG_MFD_SI476X_CORE=m
CONFIG_MFD_SIMPLE_MFD_I2C=y
# CONFIG_MFD_SL28CPLD is not set
CONFIG_MFD_SM501=y
# CONFIG_MFD_SM501_GPIO is not set
# CONFIG_MFD_SKY81452 is not set
CONFIG_MFD_SC27XX_PMIC=m
# CONFIG_ABX500_CORE is not set
# CONFIG_MFD_STMPE is not set
CONFIG_MFD_SUN6I_PRCM=y
CONFIG_MFD_SYSCON=y
CONFIG_MFD_TI_AM335X_TSCADC=y
# CONFIG_MFD_LP3943 is not set
CONFIG_MFD_LP8788=y
CONFIG_MFD_TI_LMU=y
# CONFIG_MFD_PALMAS is not set
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
CONFIG_TPS6507X=m
CONFIG_MFD_TPS65086=y
CONFIG_MFD_TPS65090=y
# CONFIG_MFD_TPS65217 is not set
# CONFIG_MFD_TI_LP873X is not set
# CONFIG_MFD_TI_LP87565 is not set
# CONFIG_MFD_TPS65218 is not set
# CONFIG_MFD_TPS6586X is not set
CONFIG_MFD_TPS65910=y
CONFIG_MFD_TPS65912=y
CONFIG_MFD_TPS65912_I2C=y
# CONFIG_MFD_TPS65912_SPI is not set
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
CONFIG_MFD_WL1273_CORE=y
CONFIG_MFD_LM3533=m
CONFIG_MFD_TIMBERDALE=y
# CONFIG_MFD_TC3589X is not set
CONFIG_MFD_TQMX86=m
# CONFIG_MFD_VX855 is not set
# CONFIG_MFD_LOCHNAGAR is not set
CONFIG_MFD_ARIZONA=y
# CONFIG_MFD_ARIZONA_I2C is not set
CONFIG_MFD_ARIZONA_SPI=y
CONFIG_MFD_CS47L24=y
CONFIG_MFD_WM5102=y
CONFIG_MFD_WM5110=y
# CONFIG_MFD_WM8997 is not set
# CONFIG_MFD_WM8998 is not set
CONFIG_MFD_WM8400=y
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM831X_SPI is not set
CONFIG_MFD_WM8350=y
CONFIG_MFD_WM8350_I2C=y
CONFIG_MFD_WM8994=m
CONFIG_MFD_STW481X=y
# CONFIG_MFD_ROHM_BD718XX is not set
# CONFIG_MFD_ROHM_BD71828 is not set
# CONFIG_MFD_ROHM_BD957XMUF is not set
CONFIG_MFD_STM32_LPTIMER=y
# CONFIG_MFD_STM32_TIMERS is not set
# CONFIG_MFD_STPMIC1 is not set
CONFIG_MFD_STMFX=y
# CONFIG_MFD_WCD934X is not set
CONFIG_MFD_ATC260X=y
CONFIG_MFD_ATC260X_I2C=y
CONFIG_MFD_KHADAS_MCU=m
CONFIG_MFD_ACER_A500_EC=m
# CONFIG_MFD_QCOM_PM8008 is not set
# CONFIG_RAVE_SP_CORE is not set
# CONFIG_MFD_INTEL_M10_BMC is not set
# CONFIG_MFD_RSMU_I2C is not set
# CONFIG_MFD_RSMU_SPI is not set
# end of Multifunction device drivers

CONFIG_REGULATOR=y
CONFIG_REGULATOR_DEBUG=y
CONFIG_REGULATOR_FIXED_VOLTAGE=y
# CONFIG_REGULATOR_VIRTUAL_CONSUMER is not set
CONFIG_REGULATOR_USERSPACE_CONSUMER=m
CONFIG_REGULATOR_88PG86X=m
CONFIG_REGULATOR_88PM8607=y
CONFIG_REGULATOR_ACT8865=m
CONFIG_REGULATOR_AD5398=y
CONFIG_REGULATOR_ANATOP=y
CONFIG_REGULATOR_AAT2870=m
CONFIG_REGULATOR_ARIZONA_LDO1=m
# CONFIG_REGULATOR_ARIZONA_MICSUPP is not set
# CONFIG_REGULATOR_ARM_SCMI is not set
CONFIG_REGULATOR_ATC260X=m
CONFIG_REGULATOR_AXP20X=y
CONFIG_REGULATOR_BCM590XX=y
CONFIG_REGULATOR_BD9571MWV=m
CONFIG_REGULATOR_CPCAP=m
CONFIG_REGULATOR_DA903X=y
# CONFIG_REGULATOR_DA9052 is not set
# CONFIG_REGULATOR_DA9055 is not set
# CONFIG_REGULATOR_DA9062 is not set
# CONFIG_REGULATOR_DA9063 is not set
# CONFIG_REGULATOR_DA9121 is not set
# CONFIG_REGULATOR_DA9210 is not set
# CONFIG_REGULATOR_DA9211 is not set
CONFIG_REGULATOR_FAN53555=m
CONFIG_REGULATOR_FAN53880=y
CONFIG_REGULATOR_GPIO=m
CONFIG_REGULATOR_ISL9305=y
CONFIG_REGULATOR_ISL6271A=m
CONFIG_REGULATOR_LM363X=m
CONFIG_REGULATOR_LP3971=m
CONFIG_REGULATOR_LP3972=y
# CONFIG_REGULATOR_LP872X is not set
# CONFIG_REGULATOR_LP8755 is not set
CONFIG_REGULATOR_LP8788=y
CONFIG_REGULATOR_LTC3589=m
CONFIG_REGULATOR_LTC3676=y
CONFIG_REGULATOR_MAX14577=y
CONFIG_REGULATOR_MAX1586=y
# CONFIG_REGULATOR_MAX77620 is not set
CONFIG_REGULATOR_MAX77650=y
# CONFIG_REGULATOR_MAX8649 is not set
CONFIG_REGULATOR_MAX8660=m
CONFIG_REGULATOR_MAX8893=m
CONFIG_REGULATOR_MAX8907=y
CONFIG_REGULATOR_MAX8952=m
# CONFIG_REGULATOR_MAX8973 is not set
CONFIG_REGULATOR_MAX8998=y
# CONFIG_REGULATOR_MAX20086 is not set
CONFIG_REGULATOR_MAX77686=y
CONFIG_REGULATOR_MAX77693=y
# CONFIG_REGULATOR_MAX77802 is not set
CONFIG_REGULATOR_MAX77826=m
CONFIG_REGULATOR_MC13XXX_CORE=y
CONFIG_REGULATOR_MC13783=y
CONFIG_REGULATOR_MC13892=y
# CONFIG_REGULATOR_MCP16502 is not set
# CONFIG_REGULATOR_MP5416 is not set
CONFIG_REGULATOR_MP8859=y
CONFIG_REGULATOR_MP886X=m
# CONFIG_REGULATOR_MPQ7920 is not set
# CONFIG_REGULATOR_MT6311 is not set
CONFIG_REGULATOR_MT6315=m
CONFIG_REGULATOR_MT6323=m
# CONFIG_REGULATOR_MT6358 is not set
CONFIG_REGULATOR_MT6359=y
CONFIG_REGULATOR_MT6360=m
CONFIG_REGULATOR_MT6397=m
# CONFIG_REGULATOR_PBIAS is not set
CONFIG_REGULATOR_PCA9450=y
# CONFIG_REGULATOR_PCAP is not set
# CONFIG_REGULATOR_PF8X00 is not set
# CONFIG_REGULATOR_PFUZE100 is not set
CONFIG_REGULATOR_PV88060=m
CONFIG_REGULATOR_PV88080=m
CONFIG_REGULATOR_PV88090=m
CONFIG_REGULATOR_PWM=y
CONFIG_REGULATOR_QCOM_RPMH=y
CONFIG_REGULATOR_QCOM_SMD_RPM=m
CONFIG_REGULATOR_QCOM_SPMI=m
# CONFIG_REGULATOR_QCOM_USB_VBUS is not set
# CONFIG_REGULATOR_RASPBERRYPI_TOUCHSCREEN_ATTINY is not set
CONFIG_REGULATOR_RC5T583=m
CONFIG_REGULATOR_RT4801=y
# CONFIG_REGULATOR_RT4831 is not set
CONFIG_REGULATOR_RT5033=m
# CONFIG_REGULATOR_RT5190A is not set
CONFIG_REGULATOR_RT5759=m
# CONFIG_REGULATOR_RT6160 is not set
# CONFIG_REGULATOR_RT6245 is not set
# CONFIG_REGULATOR_RTQ2134 is not set
# CONFIG_REGULATOR_RTMV20 is not set
# CONFIG_REGULATOR_RTQ6752 is not set
CONFIG_REGULATOR_S2MPA01=y
CONFIG_REGULATOR_S2MPS11=y
CONFIG_REGULATOR_S5M8767=m
CONFIG_REGULATOR_SC2731=m
CONFIG_REGULATOR_SLG51000=y
CONFIG_REGULATOR_STM32_BOOSTER=y
# CONFIG_REGULATOR_STM32_VREFBUF is not set
CONFIG_REGULATOR_STM32_PWR=y
# CONFIG_REGULATOR_TI_ABB is not set
# CONFIG_REGULATOR_STW481X_VMMC is not set
# CONFIG_REGULATOR_SY7636A is not set
CONFIG_REGULATOR_SY8106A=y
CONFIG_REGULATOR_SY8824X=m
# CONFIG_REGULATOR_SY8827N is not set
CONFIG_REGULATOR_TPS51632=y
CONFIG_REGULATOR_TPS62360=m
# CONFIG_REGULATOR_TPS6286X is not set
# CONFIG_REGULATOR_TPS65023 is not set
CONFIG_REGULATOR_TPS6507X=y
CONFIG_REGULATOR_TPS65086=y
# CONFIG_REGULATOR_TPS65090 is not set
# CONFIG_REGULATOR_TPS65132 is not set
CONFIG_REGULATOR_TPS6524X=y
CONFIG_REGULATOR_TPS65910=m
CONFIG_REGULATOR_TPS65912=m
CONFIG_REGULATOR_TPS68470=y
# CONFIG_REGULATOR_UNIPHIER is not set
# CONFIG_REGULATOR_VCTRL is not set
# CONFIG_REGULATOR_WM8350 is not set
CONFIG_REGULATOR_WM8400=m
CONFIG_REGULATOR_WM8994=m
CONFIG_REGULATOR_QCOM_LABIBB=y
# CONFIG_RC_CORE is not set

#
# CEC support
#
# CONFIG_MEDIA_CEC_SUPPORT is not set
# end of CEC support

# CONFIG_MEDIA_SUPPORT is not set

#
# Graphics support
#
CONFIG_IMX_IPUV3_CORE=m
# CONFIG_DRM is not set
# CONFIG_DRM_DEBUG_MODESET_LOCK is not set

#
# ARM devices
#
# end of ARM devices

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=m
CONFIG_FIRMWARE_EDID=y
CONFIG_FB_DDC=m
CONFIG_FB_CFB_FILLRECT=m
CONFIG_FB_CFB_COPYAREA=m
CONFIG_FB_CFB_IMAGEBLIT=m
CONFIG_FB_SYS_FILLRECT=m
CONFIG_FB_SYS_COPYAREA=m
CONFIG_FB_SYS_IMAGEBLIT=m
CONFIG_FB_FOREIGN_ENDIAN=y
# CONFIG_FB_BOTH_ENDIAN is not set
# CONFIG_FB_BIG_ENDIAN is not set
CONFIG_FB_LITTLE_ENDIAN=y
CONFIG_FB_SYS_FOPS=m
CONFIG_FB_DEFERRED_IO=y
CONFIG_FB_SVGALIB=m
CONFIG_FB_BACKLIGHT=m
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
CONFIG_FB_CIRRUS=m
CONFIG_FB_PM2=m
CONFIG_FB_PM2_FIFO_DISCONNECT=y
CONFIG_FB_CLPS711X=m
CONFIG_FB_IMX=m
# CONFIG_FB_CYBER2000 is not set
CONFIG_FB_ARC=m
CONFIG_FB_PVR2=m
# CONFIG_FB_OPENCORES is not set
CONFIG_FB_S1D13XXX=m
# CONFIG_FB_ATMEL is not set
CONFIG_FB_NVIDIA=m
# CONFIG_FB_NVIDIA_I2C is not set
CONFIG_FB_NVIDIA_DEBUG=y
# CONFIG_FB_NVIDIA_BACKLIGHT is not set
# CONFIG_FB_RIVA is not set
CONFIG_FB_I740=m
# CONFIG_FB_MATROX is not set
CONFIG_FB_RADEON=m
# CONFIG_FB_RADEON_I2C is not set
# CONFIG_FB_RADEON_BACKLIGHT is not set
# CONFIG_FB_RADEON_DEBUG is not set
# CONFIG_FB_ATY128 is not set
CONFIG_FB_ATY=m
CONFIG_FB_ATY_CT=y
# CONFIG_FB_ATY_GENERIC_LCD is not set
# CONFIG_FB_ATY_GX is not set
CONFIG_FB_ATY_BACKLIGHT=y
CONFIG_FB_S3=m
# CONFIG_FB_S3_DDC is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_VIA is not set
# CONFIG_FB_NEOMAGIC is not set
CONFIG_FB_KYRO=m
CONFIG_FB_3DFX=m
CONFIG_FB_3DFX_ACCEL=y
CONFIG_FB_3DFX_I2C=y
CONFIG_FB_VOODOO1=m
CONFIG_FB_VT8623=m
CONFIG_FB_TRIDENT=m
CONFIG_FB_ARK=m
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
# CONFIG_FB_PXA168 is not set
CONFIG_FB_W100=m
CONFIG_FB_SH_MOBILE_LCDC=m
CONFIG_FB_TMIO=m
# CONFIG_FB_TMIO_ACCELL is not set
# CONFIG_FB_S3C is not set
# CONFIG_FB_SM501 is not set
CONFIG_FB_SMSCUFX=m
CONFIG_FB_UDL=m
CONFIG_FB_IBM_GXT4500=m
CONFIG_FB_GOLDFISH=m
# CONFIG_FB_DA8XX is not set
CONFIG_FB_VIRTUAL=m
CONFIG_FB_METRONOME=m
CONFIG_FB_MB862XX=m
CONFIG_FB_MB862XX_PCI_GDC=y
CONFIG_FB_MB862XX_I2C=y
CONFIG_FB_BROADSHEET=m
# CONFIG_FB_SIMPLE is not set
CONFIG_FB_SSD1307=m
# CONFIG_FB_SM712 is not set
# CONFIG_FB_OMAP2 is not set
# CONFIG_MMP_DISP is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=m
CONFIG_LCD_L4F00242T03=m
# CONFIG_LCD_LMS283GF05 is not set
CONFIG_LCD_LTV350QV=m
CONFIG_LCD_ILI922X=m
CONFIG_LCD_ILI9320=m
CONFIG_LCD_TDO24M=m
CONFIG_LCD_VGG2432A4=m
# CONFIG_LCD_PLATFORM is not set
# CONFIG_LCD_AMS369FG06 is not set
CONFIG_LCD_LMS501KF03=m
CONFIG_LCD_HX8357=m
CONFIG_LCD_OTM3225A=m
CONFIG_BACKLIGHT_CLASS_DEVICE=y
CONFIG_BACKLIGHT_KTD253=m
CONFIG_BACKLIGHT_LM3533=m
# CONFIG_BACKLIGHT_OMAP1 is not set
CONFIG_BACKLIGHT_PWM=m
CONFIG_BACKLIGHT_DA903X=m
# CONFIG_BACKLIGHT_DA9052 is not set
CONFIG_BACKLIGHT_QCOM_WLED=y
# CONFIG_BACKLIGHT_RT4831 is not set
CONFIG_BACKLIGHT_ADP8860=y
# CONFIG_BACKLIGHT_ADP8870 is not set
CONFIG_BACKLIGHT_88PM860X=y
# CONFIG_BACKLIGHT_AAT2870 is not set
CONFIG_BACKLIGHT_LM3630A=m
CONFIG_BACKLIGHT_LM3639=y
# CONFIG_BACKLIGHT_LP855X is not set
CONFIG_BACKLIGHT_LP8788=m
# CONFIG_BACKLIGHT_GPIO is not set
# CONFIG_BACKLIGHT_LV5207LP is not set
CONFIG_BACKLIGHT_BD6107=y
# CONFIG_BACKLIGHT_ARCXCNN is not set
# CONFIG_BACKLIGHT_LED is not set
# end of Backlight & LCD device support

CONFIG_VGASTATE=m
CONFIG_VIDEOMODE_HELPERS=y
CONFIG_HDMI=y
# CONFIG_LOGO is not set
# end of Graphics support

CONFIG_SOUND=y
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_PCM_ELD=y
CONFIG_SND_PCM_IEC958=y
CONFIG_SND_DMAENGINE_PCM=m
CONFIG_SND_HWDEP=m
CONFIG_SND_SEQ_DEVICE=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_COMPRESS_OFFLOAD=m
CONFIG_SND_JACK=y
CONFIG_SND_JACK_INPUT_DEV=y
# CONFIG_SND_OSSEMUL is not set
CONFIG_SND_PCM_TIMER=y
CONFIG_SND_HRTIMER=m
CONFIG_SND_DYNAMIC_MINORS=y
CONFIG_SND_MAX_CARDS=32
# CONFIG_SND_SUPPORT_OLD_API is not set
# CONFIG_SND_PROC_FS is not set
CONFIG_SND_VERBOSE_PRINTK=y
# CONFIG_SND_CTL_FAST_LOOKUP is not set
# CONFIG_SND_DEBUG is not set
CONFIG_SND_CTL_INPUT_VALIDATION=y
CONFIG_SND_VMASTER=y
CONFIG_SND_CTL_LED=m
CONFIG_SND_SEQUENCER=m
CONFIG_SND_SEQ_DUMMY=m
CONFIG_SND_SEQ_HRTIMER_DEFAULT=y
CONFIG_SND_SEQ_MIDI_EVENT=m
CONFIG_SND_SEQ_MIDI=m
CONFIG_SND_SEQ_MIDI_EMUL=m
CONFIG_SND_SEQ_VIRMIDI=m
CONFIG_SND_MPU401_UART=m
CONFIG_SND_OPL3_LIB=m
CONFIG_SND_OPL3_LIB_SEQ=m
CONFIG_SND_VX_LIB=m
CONFIG_SND_AC97_CODEC=m
CONFIG_SND_DRIVERS=y
CONFIG_SND_DUMMY=m
CONFIG_SND_ALOOP=m
CONFIG_SND_VIRMIDI=m
CONFIG_SND_MTPAV=m
CONFIG_SND_MTS64=m
# CONFIG_SND_SERIAL_U16550 is not set
# CONFIG_SND_SERIAL_GENERIC is not set
# CONFIG_SND_MPU401 is not set
CONFIG_SND_PORTMAN2X4=m
# CONFIG_SND_AC97_POWER_SAVE is not set
CONFIG_SND_PCI=y
CONFIG_SND_AD1889=m
# CONFIG_SND_ATIIXP is not set
CONFIG_SND_ATIIXP_MODEM=m
# CONFIG_SND_AU8810 is not set
# CONFIG_SND_AU8820 is not set
CONFIG_SND_AU8830=m
CONFIG_SND_AW2=m
CONFIG_SND_BT87X=m
CONFIG_SND_BT87X_OVERCLOCK=y
# CONFIG_SND_CA0106 is not set
# CONFIG_SND_CMIPCI is not set
CONFIG_SND_OXYGEN_LIB=m
CONFIG_SND_OXYGEN=m
# CONFIG_SND_CS4281 is not set
CONFIG_SND_CS46XX=m
CONFIG_SND_CS46XX_NEW_DSP=y
# CONFIG_SND_CS5535AUDIO is not set
# CONFIG_SND_CTXFI is not set
# CONFIG_SND_DARLA20 is not set
CONFIG_SND_GINA20=m
# CONFIG_SND_LAYLA20 is not set
CONFIG_SND_DARLA24=m
# CONFIG_SND_GINA24 is not set
CONFIG_SND_LAYLA24=m
CONFIG_SND_MONA=m
CONFIG_SND_MIA=m
CONFIG_SND_ECHO3G=m
CONFIG_SND_INDIGO=m
CONFIG_SND_INDIGOIO=m
CONFIG_SND_INDIGODJ=m
CONFIG_SND_INDIGOIOX=m
CONFIG_SND_INDIGODJX=m
CONFIG_SND_ENS1370=m
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_FM801 is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_HDSPM is not set
CONFIG_SND_ICE1724=m
CONFIG_SND_INTEL8X0=m
# CONFIG_SND_INTEL8X0M is not set
CONFIG_SND_KORG1212=m
CONFIG_SND_LOLA=m
# CONFIG_SND_LX6464ES is not set
CONFIG_SND_MIXART=m
CONFIG_SND_NM256=m
CONFIG_SND_PCXHR=m
CONFIG_SND_RIPTIDE=m
# CONFIG_SND_RME32 is not set
CONFIG_SND_RME96=m
CONFIG_SND_RME9652=m
CONFIG_SND_VIA82XX=m
CONFIG_SND_VIA82XX_MODEM=m
CONFIG_SND_VIRTUOSO=m
CONFIG_SND_VX222=m
CONFIG_SND_YMFPCI=m

#
# HD-Audio
#
CONFIG_SND_HDA=m
CONFIG_SND_HDA_GENERIC_LEDS=y
# CONFIG_SND_HDA_INTEL is not set
# CONFIG_SND_HDA_HWDEP is not set
CONFIG_SND_HDA_RECONFIG=y
CONFIG_SND_HDA_INPUT_BEEP=y
CONFIG_SND_HDA_INPUT_BEEP_MODE=1
# CONFIG_SND_HDA_PATCH_LOADER is not set
CONFIG_SND_HDA_SCODEC_CS35L41=m
CONFIG_SND_HDA_CS_DSP_CONTROLS=m
CONFIG_SND_HDA_SCODEC_CS35L41_I2C=m
CONFIG_SND_HDA_SCODEC_CS35L41_SPI=m
# CONFIG_SND_HDA_CODEC_REALTEK is not set
# CONFIG_SND_HDA_CODEC_ANALOG is not set
CONFIG_SND_HDA_CODEC_SIGMATEL=m
CONFIG_SND_HDA_CODEC_VIA=m
CONFIG_SND_HDA_CODEC_HDMI=m
CONFIG_SND_HDA_CODEC_CIRRUS=m
CONFIG_SND_HDA_CODEC_CS8409=m
# CONFIG_SND_HDA_CODEC_CONEXANT is not set
CONFIG_SND_HDA_CODEC_CA0110=m
# CONFIG_SND_HDA_CODEC_CA0132 is not set
# CONFIG_SND_HDA_CODEC_CMEDIA is not set
# CONFIG_SND_HDA_CODEC_SI3054 is not set
CONFIG_SND_HDA_GENERIC=m
# end of HD-Audio

CONFIG_SND_HDA_CORE=m
CONFIG_SND_HDA_DSP_LOADER=y
CONFIG_SND_HDA_EXT_CORE=m
CONFIG_SND_HDA_PREALLOC_SIZE=64
CONFIG_SND_INTEL_NHLT=y
CONFIG_SND_INTEL_DSP_CONFIG=m
CONFIG_SND_INTEL_SOUNDWIRE_ACPI=m
CONFIG_SND_PXA2XX_LIB=m
# CONFIG_SND_SPI is not set
CONFIG_SND_USB=y
CONFIG_SND_USB_AUDIO=m
# CONFIG_SND_USB_UA101 is not set
CONFIG_SND_USB_CAIAQ=m
CONFIG_SND_USB_CAIAQ_INPUT=y
CONFIG_SND_USB_US122L=m
CONFIG_SND_USB_6FIRE=m
CONFIG_SND_USB_HIFACE=m
CONFIG_SND_BCD2000=m
CONFIG_SND_USB_LINE6=m
CONFIG_SND_USB_POD=m
# CONFIG_SND_USB_PODHD is not set
# CONFIG_SND_USB_TONEPORT is not set
CONFIG_SND_USB_VARIAX=m
# CONFIG_SND_FIREWIRE is not set
CONFIG_SND_SOC=m
CONFIG_SND_SOC_AC97_BUS=y
CONFIG_SND_SOC_GENERIC_DMAENGINE_PCM=y
CONFIG_SND_SOC_COMPRESS=y
CONFIG_SND_SOC_TOPOLOGY=y
# CONFIG_SND_SOC_TOPOLOGY_KUNIT_TEST is not set
CONFIG_SND_SOC_UTILS_KUNIT_TEST=m
CONFIG_SND_SOC_ACPI=m
CONFIG_SND_SOC_ADI=m
CONFIG_SND_SOC_ADI_AXI_I2S=m
CONFIG_SND_SOC_ADI_AXI_SPDIF=m
CONFIG_SND_SOC_AMD_ACP=m
# CONFIG_SND_SOC_AMD_CZ_DA7219MX98357_MACH is not set
CONFIG_SND_SOC_AMD_CZ_RT5645_MACH=m
# CONFIG_SND_SOC_AMD_ST_ES8336_MACH is not set
CONFIG_SND_AMD_ACP_CONFIG=m
CONFIG_SND_ATMEL_SOC=m
# CONFIG_SND_ATMEL_SOC_CLASSD is not set
# CONFIG_SND_ATMEL_SOC_PDMIC is not set
# CONFIG_SND_ATMEL_SOC_I2S is not set
# CONFIG_SND_SOC_MIKROE_PROTO is not set
# CONFIG_SND_MCHP_SOC_I2S_MCC is not set
# CONFIG_SND_MCHP_SOC_SPDIFTX is not set
# CONFIG_SND_MCHP_SOC_SPDIFRX is not set
# CONFIG_SND_MCHP_SOC_PDMC is not set
CONFIG_SND_BCM2835_SOC_I2S=m
CONFIG_SND_SOC_CYGNUS=m
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
CONFIG_SND_SOC_FSL_AUDMIX=m
# CONFIG_SND_SOC_FSL_SSI is not set
CONFIG_SND_SOC_FSL_SPDIF=m
CONFIG_SND_SOC_FSL_ESAI=m
CONFIG_SND_SOC_FSL_MICFIL=m
CONFIG_SND_SOC_FSL_EASRC=m
CONFIG_SND_SOC_FSL_XCVR=m
CONFIG_SND_SOC_FSL_AUD2HTX=m
CONFIG_SND_SOC_FSL_UTILS=m
# CONFIG_SND_SOC_FSL_RPMSG is not set
CONFIG_SND_SOC_IMX_PCM_DMA=m
CONFIG_SND_SOC_IMX_AUDIO_RPMSG=m
CONFIG_SND_SOC_IMX_PCM_RPMSG=m
CONFIG_SND_SOC_IMX_AUDMUX=m
CONFIG_SND_IMX_SOC=m

#
# SoC Audio support for Freescale i.MX boards:
#
# CONFIG_SND_SOC_IMX_ES8328 is not set
# CONFIG_SND_SOC_IMX_SGTL5000 is not set
CONFIG_SND_SOC_IMX_SPDIF=m
# CONFIG_SND_SOC_FSL_ASOC_CARD is not set
# CONFIG_SND_SOC_IMX_AUDMIX is not set
CONFIG_SND_SOC_IMX_HDMI=m
CONFIG_SND_SOC_IMX_RPMSG=m
# CONFIG_SND_SOC_IMX_CARD is not set
# end of SoC Audio for Freescale CPUs

CONFIG_SND_I2S_HI6210_I2S=m
# CONFIG_SND_JZ4740_SOC_I2S is not set
CONFIG_SND_KIRKWOOD_SOC=m
CONFIG_SND_KIRKWOOD_SOC_ARMADA370_DB=m
# CONFIG_SND_SOC_IMG is not set
# CONFIG_SND_SOC_INTEL_SST_TOPLEVEL is not set
CONFIG_SND_SOC_INTEL_KEEMBAY=m
CONFIG_SND_SOC_INTEL_AVS=m

#
# Intel AVS Machine drivers
#

#
# Available DSP configurations
#
# CONFIG_SND_SOC_INTEL_AVS_MACH_DA7219 is not set
CONFIG_SND_SOC_INTEL_AVS_MACH_DMIC=m
# CONFIG_SND_SOC_INTEL_AVS_MACH_HDAUDIO is not set
CONFIG_SND_SOC_INTEL_AVS_MACH_I2S_TEST=m
# CONFIG_SND_SOC_INTEL_AVS_MACH_MAX98357A is not set
CONFIG_SND_SOC_INTEL_AVS_MACH_MAX98373=m
CONFIG_SND_SOC_INTEL_AVS_MACH_NAU8825=m
# CONFIG_SND_SOC_INTEL_AVS_MACH_RT274 is not set
# CONFIG_SND_SOC_INTEL_AVS_MACH_RT286 is not set
CONFIG_SND_SOC_INTEL_AVS_MACH_RT298=m
CONFIG_SND_SOC_INTEL_AVS_MACH_RT5682=m
CONFIG_SND_SOC_INTEL_AVS_MACH_SSM4567=m
# end of Intel AVS Machine drivers

CONFIG_SND_SOC_MEDIATEK=m
CONFIG_SND_SOC_MT8186=m
CONFIG_SND_SOC_MTK_BTCVSD=m
# CONFIG_SND_SOC_MT8195 is not set

#
# ASoC support for Amlogic platforms
#
CONFIG_SND_MESON_AIU=m
CONFIG_SND_MESON_AXG_FIFO=m
CONFIG_SND_MESON_AXG_FRDDR=m
# CONFIG_SND_MESON_AXG_TODDR is not set
CONFIG_SND_MESON_AXG_TDM_FORMATTER=m
CONFIG_SND_MESON_AXG_TDM_INTERFACE=m
CONFIG_SND_MESON_AXG_TDMIN=m
CONFIG_SND_MESON_AXG_TDMOUT=m
CONFIG_SND_MESON_AXG_SOUND_CARD=m
# CONFIG_SND_MESON_AXG_SPDIFOUT is not set
# CONFIG_SND_MESON_AXG_SPDIFIN is not set
# CONFIG_SND_MESON_AXG_PDM is not set
CONFIG_SND_MESON_CARD_UTILS=m
CONFIG_SND_MESON_CODEC_GLUE=m
CONFIG_SND_MESON_GX_SOUND_CARD=m
CONFIG_SND_MESON_G12A_TOACODEC=m
# CONFIG_SND_MESON_G12A_TOHDMITX is not set
# CONFIG_SND_SOC_MESON_T9015 is not set
# end of ASoC support for Amlogic platforms

CONFIG_SND_MXS_SOC=m
CONFIG_SND_SOC_MXS_SGTL5000=m
CONFIG_SND_PXA2XX_SOC=m
# CONFIG_SND_SOC_QCOM is not set
CONFIG_SND_SOC_ROCKCHIP=m
CONFIG_SND_SOC_ROCKCHIP_I2S=m
CONFIG_SND_SOC_ROCKCHIP_I2S_TDM=m
# CONFIG_SND_SOC_ROCKCHIP_PDM is not set
# CONFIG_SND_SOC_ROCKCHIP_SPDIF is not set
# CONFIG_SND_SOC_ROCKCHIP_MAX98090 is not set
CONFIG_SND_SOC_ROCKCHIP_RT5645=m
CONFIG_SND_SOC_RK3288_HDMI_ANALOG=m
CONFIG_SND_SOC_RK3399_GRU_SOUND=m
CONFIG_SND_SOC_SAMSUNG=m
CONFIG_SND_S3C24XX_I2S=m
CONFIG_SND_SAMSUNG_PCM=m
CONFIG_SND_SAMSUNG_SPDIF=m
CONFIG_SND_SAMSUNG_I2S=m
CONFIG_SND_SOC_SAMSUNG_NEO1973_WM8753=m
# CONFIG_SND_SOC_SAMSUNG_SMDK_WM8580 is not set
CONFIG_SND_SOC_SAMSUNG_SMDK_WM8994=m
CONFIG_SND_SOC_SAMSUNG_S3C24XX_UDA134X=m
# CONFIG_SND_SOC_SAMSUNG_SIMTEC_TLV320AIC23 is not set
# CONFIG_SND_SOC_SAMSUNG_SIMTEC_HERMES is not set
CONFIG_SND_SOC_SAMSUNG_H1940_UDA1380=m
CONFIG_SND_SOC_SAMSUNG_RX1950_UDA1380=m
# CONFIG_SND_SOC_SMARTQ is not set
# CONFIG_SND_SOC_SAMSUNG_SMDK_SPDIF is not set
CONFIG_SND_SOC_SMDK_WM8994_PCM=m
# CONFIG_SND_SOC_SPEYSIDE is not set
# CONFIG_SND_SOC_TOBERMORY is not set
CONFIG_SND_SOC_BELLS=m
CONFIG_SND_SOC_LOWLAND=m
CONFIG_SND_SOC_LITTLEMILL=m
CONFIG_SND_SOC_SNOW=m
CONFIG_SND_SOC_ODROID=m
CONFIG_SND_SOC_ARNDALE=m
CONFIG_SND_SOC_SAMSUNG_TM2_WM5110=m
# CONFIG_SND_SOC_SAMSUNG_MIDAS_WM1811 is not set

#
# SoC Audio support for Renesas SoCs
#
CONFIG_SND_SOC_SH4_FSI=m
# CONFIG_SND_SOC_RCAR is not set
CONFIG_SND_SOC_RZ=m
# end of SoC Audio support for Renesas SoCs

# CONFIG_SND_SOC_SOF_TOPLEVEL is not set
CONFIG_SND_SOC_SPRD=m
# CONFIG_SND_SOC_SPRD_MCDT is not set
CONFIG_SND_SOC_STI=m

#
# STMicroelectronics STM32 SOC audio support
#
# CONFIG_SND_SOC_STM32_SAI is not set
CONFIG_SND_SOC_STM32_I2S=m
CONFIG_SND_SOC_STM32_SPDIFRX=m
# end of STMicroelectronics STM32 SOC audio support

#
# Allwinner SoC Audio support
#
CONFIG_SND_SUN4I_CODEC=m
# CONFIG_SND_SUN8I_CODEC is not set
CONFIG_SND_SUN8I_CODEC_ANALOG=m
# CONFIG_SND_SUN50I_CODEC_ANALOG is not set
# CONFIG_SND_SUN4I_I2S is not set
# CONFIG_SND_SUN4I_SPDIF is not set
CONFIG_SND_SUN8I_ADDA_PR_REGMAP=m
# end of Allwinner SoC Audio support

# CONFIG_SND_SOC_TEGRA is not set

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
CONFIG_SND_SOC_DAVINCI_VCIF=m
CONFIG_SND_SOC_OMAP_DMIC=m
CONFIG_SND_SOC_OMAP_MCBSP=m
CONFIG_SND_SOC_OMAP_MCPDM=m

#
# Audio support for boards with Texas Instruments SoCs
#
CONFIG_SND_SOC_OMAP_HDMI=m
CONFIG_SND_SOC_J721E_EVM=m
# end of Audio support for Texas Instruments SoCs

CONFIG_SND_SOC_UNIPHIER=m
CONFIG_SND_SOC_UNIPHIER_AIO=m
CONFIG_SND_SOC_UNIPHIER_LD11=m
# CONFIG_SND_SOC_UNIPHIER_PXS2 is not set
# CONFIG_SND_SOC_UNIPHIER_EVEA_CODEC is not set
CONFIG_SND_SOC_XILINX_I2S=m
CONFIG_SND_SOC_XILINX_AUDIO_FORMATTER=m
# CONFIG_SND_SOC_XILINX_SPDIF is not set
CONFIG_SND_SOC_XTFPGA_I2S=m
CONFIG_SND_SOC_I2C_AND_SPI=m

#
# CODEC drivers
#
CONFIG_SND_SOC_ALL_CODECS=m
CONFIG_SND_SOC_88PM860X=m
CONFIG_SND_SOC_ARIZONA=m
CONFIG_SND_SOC_WM_HUBS=m
CONFIG_SND_SOC_WM_ADSP=m
# CONFIG_SND_SOC_AB8500_CODEC is not set
CONFIG_SND_SOC_AC97_CODEC=m
CONFIG_SND_SOC_AD1836=m
CONFIG_SND_SOC_AD193X=m
CONFIG_SND_SOC_AD193X_SPI=m
CONFIG_SND_SOC_AD193X_I2C=m
CONFIG_SND_SOC_AD1980=m
CONFIG_SND_SOC_AD73311=m
CONFIG_SND_SOC_ADAU_UTILS=m
CONFIG_SND_SOC_ADAU1372=m
CONFIG_SND_SOC_ADAU1372_I2C=m
CONFIG_SND_SOC_ADAU1372_SPI=m
CONFIG_SND_SOC_ADAU1373=m
CONFIG_SND_SOC_ADAU1701=m
CONFIG_SND_SOC_ADAU17X1=m
CONFIG_SND_SOC_ADAU1761=m
CONFIG_SND_SOC_ADAU1761_I2C=m
CONFIG_SND_SOC_ADAU1761_SPI=m
CONFIG_SND_SOC_ADAU1781=m
CONFIG_SND_SOC_ADAU1781_I2C=m
CONFIG_SND_SOC_ADAU1781_SPI=m
CONFIG_SND_SOC_ADAU1977=m
CONFIG_SND_SOC_ADAU1977_SPI=m
CONFIG_SND_SOC_ADAU1977_I2C=m
CONFIG_SND_SOC_ADAU7002=m
CONFIG_SND_SOC_ADAU7118=m
# CONFIG_SND_SOC_ADAU7118_HW is not set
CONFIG_SND_SOC_ADAU7118_I2C=m
CONFIG_SND_SOC_ADAV80X=m
CONFIG_SND_SOC_ADAV801=m
CONFIG_SND_SOC_ADAV803=m
CONFIG_SND_SOC_ADS117X=m
# CONFIG_SND_SOC_AK4104 is not set
# CONFIG_SND_SOC_AK4118 is not set
# CONFIG_SND_SOC_AK4375 is not set
CONFIG_SND_SOC_AK4458=m
CONFIG_SND_SOC_AK4535=m
CONFIG_SND_SOC_AK4554=m
# CONFIG_SND_SOC_AK4613 is not set
CONFIG_SND_SOC_AK4641=m
CONFIG_SND_SOC_AK4642=m
CONFIG_SND_SOC_AK4671=m
CONFIG_SND_SOC_AK5386=m
CONFIG_SND_SOC_AK5558=m
CONFIG_SND_SOC_ALC5623=m
CONFIG_SND_SOC_ALC5632=m
CONFIG_SND_SOC_AW8738=m
CONFIG_SND_SOC_BD28623=m
CONFIG_SND_SOC_BT_SCO=m
# CONFIG_SND_SOC_CPCAP is not set
CONFIG_SND_SOC_CQ0093VC=m
# CONFIG_SND_SOC_CROS_EC_CODEC is not set
# CONFIG_SND_SOC_CS35L32 is not set
CONFIG_SND_SOC_CS35L33=m
CONFIG_SND_SOC_CS35L34=m
CONFIG_SND_SOC_CS35L35=m
CONFIG_SND_SOC_CS35L36=m
CONFIG_SND_SOC_CS35L41_LIB=m
CONFIG_SND_SOC_CS35L41=m
CONFIG_SND_SOC_CS35L41_SPI=m
CONFIG_SND_SOC_CS35L41_I2C=m
CONFIG_SND_SOC_CS35L45_TABLES=m
CONFIG_SND_SOC_CS35L45=m
CONFIG_SND_SOC_CS35L45_SPI=m
CONFIG_SND_SOC_CS35L45_I2C=m
CONFIG_SND_SOC_CS42L42=m
CONFIG_SND_SOC_CS42L51=m
CONFIG_SND_SOC_CS42L51_I2C=m
# CONFIG_SND_SOC_CS42L52 is not set
# CONFIG_SND_SOC_CS42L56 is not set
CONFIG_SND_SOC_CS42L73=m
# CONFIG_SND_SOC_CS4234 is not set
CONFIG_SND_SOC_CS4265=m
# CONFIG_SND_SOC_CS4270 is not set
CONFIG_SND_SOC_CS4271=m
# CONFIG_SND_SOC_CS4271_I2C is not set
CONFIG_SND_SOC_CS4271_SPI=m
CONFIG_SND_SOC_CS42XX8=m
CONFIG_SND_SOC_CS42XX8_I2C=m
CONFIG_SND_SOC_CS43130=m
CONFIG_SND_SOC_CS4341=m
# CONFIG_SND_SOC_CS4349 is not set
CONFIG_SND_SOC_CS47L15=m
CONFIG_SND_SOC_CS47L24=m
# CONFIG_SND_SOC_CS47L35 is not set
# CONFIG_SND_SOC_CS47L85 is not set
CONFIG_SND_SOC_CS47L90=m
CONFIG_SND_SOC_CS47L92=m
# CONFIG_SND_SOC_CS53L30 is not set
CONFIG_SND_SOC_CX20442=m
CONFIG_SND_SOC_CX2072X=m
# CONFIG_SND_SOC_JZ4740_CODEC is not set
# CONFIG_SND_SOC_JZ4725B_CODEC is not set
# CONFIG_SND_SOC_JZ4760_CODEC is not set
# CONFIG_SND_SOC_JZ4770_CODEC is not set
CONFIG_SND_SOC_L3=m
CONFIG_SND_SOC_DA7210=m
# CONFIG_SND_SOC_DA7213 is not set
CONFIG_SND_SOC_DA7218=m
CONFIG_SND_SOC_DA7219=m
CONFIG_SND_SOC_DA732X=m
CONFIG_SND_SOC_DA9055=m
CONFIG_SND_SOC_DMIC=m
CONFIG_SND_SOC_HDMI_CODEC=m
CONFIG_SND_SOC_ES7134=m
# CONFIG_SND_SOC_ES7241 is not set
CONFIG_SND_SOC_ES8316=m
CONFIG_SND_SOC_ES8328=m
CONFIG_SND_SOC_ES8328_I2C=m
CONFIG_SND_SOC_ES8328_SPI=m
CONFIG_SND_SOC_GTM601=m
CONFIG_SND_SOC_HDAC_HDMI=m
CONFIG_SND_SOC_HDAC_HDA=m
CONFIG_SND_SOC_HDA=m
CONFIG_SND_SOC_ICS43432=m
CONFIG_SND_SOC_INNO_RK3036=m
CONFIG_SND_SOC_ISABELLE=m
CONFIG_SND_SOC_LM49453=m
# CONFIG_SND_SOC_LOCHNAGAR_SC is not set
CONFIG_SND_SOC_MADERA=m
CONFIG_SND_SOC_MAX98088=m
CONFIG_SND_SOC_MAX98090=m
CONFIG_SND_SOC_MAX98095=m
CONFIG_SND_SOC_MAX98357A=m
CONFIG_SND_SOC_MAX98371=m
CONFIG_SND_SOC_MAX98504=m
# CONFIG_SND_SOC_MAX9867 is not set
CONFIG_SND_SOC_MAX98925=m
CONFIG_SND_SOC_MAX98926=m
CONFIG_SND_SOC_MAX98927=m
# CONFIG_SND_SOC_MAX98520 is not set
CONFIG_SND_SOC_MAX98373=m
CONFIG_SND_SOC_MAX98373_I2C=m
# CONFIG_SND_SOC_MAX98373_SDW is not set
CONFIG_SND_SOC_MAX98390=m
# CONFIG_SND_SOC_MAX98396 is not set
CONFIG_SND_SOC_MAX9850=m
CONFIG_SND_SOC_MAX9860=m
# CONFIG_SND_SOC_MSM8916_WCD_ANALOG is not set
CONFIG_SND_SOC_MSM8916_WCD_DIGITAL=m
CONFIG_SND_SOC_PCM1681=m
CONFIG_SND_SOC_PCM1789=m
CONFIG_SND_SOC_PCM1789_I2C=m
CONFIG_SND_SOC_PCM179X=m
CONFIG_SND_SOC_PCM179X_I2C=m
CONFIG_SND_SOC_PCM179X_SPI=m
CONFIG_SND_SOC_PCM186X=m
CONFIG_SND_SOC_PCM186X_I2C=m
# CONFIG_SND_SOC_PCM186X_SPI is not set
CONFIG_SND_SOC_PCM3008=m
CONFIG_SND_SOC_PCM3060=m
# CONFIG_SND_SOC_PCM3060_I2C is not set
CONFIG_SND_SOC_PCM3060_SPI=m
CONFIG_SND_SOC_PCM3168A=m
CONFIG_SND_SOC_PCM3168A_I2C=m
# CONFIG_SND_SOC_PCM3168A_SPI is not set
CONFIG_SND_SOC_PCM5102A=m
CONFIG_SND_SOC_PCM512x=m
CONFIG_SND_SOC_PCM512x_I2C=m
CONFIG_SND_SOC_PCM512x_SPI=m
CONFIG_SND_SOC_RK3328=m
# CONFIG_SND_SOC_RK817 is not set
CONFIG_SND_SOC_RL6231=m
CONFIG_SND_SOC_RL6347A=m
CONFIG_SND_SOC_RT274=m
CONFIG_SND_SOC_RT286=m
CONFIG_SND_SOC_RT298=m
CONFIG_SND_SOC_RT1011=m
CONFIG_SND_SOC_RT1015=m
CONFIG_SND_SOC_RT1015P=m
CONFIG_SND_SOC_RT1016=m
CONFIG_SND_SOC_RT1019=m
CONFIG_SND_SOC_RT1305=m
CONFIG_SND_SOC_RT1308=m
# CONFIG_SND_SOC_RT1308_SDW is not set
# CONFIG_SND_SOC_RT1316_SDW is not set
CONFIG_SND_SOC_RT5514=m
CONFIG_SND_SOC_RT5514_SPI=m
CONFIG_SND_SOC_RT5616=m
CONFIG_SND_SOC_RT5631=m
CONFIG_SND_SOC_RT5640=m
CONFIG_SND_SOC_RT5645=m
CONFIG_SND_SOC_RT5651=m
CONFIG_SND_SOC_RT5659=m
CONFIG_SND_SOC_RT5660=m
CONFIG_SND_SOC_RT5663=m
CONFIG_SND_SOC_RT5665=m
CONFIG_SND_SOC_RT5668=m
CONFIG_SND_SOC_RT5670=m
CONFIG_SND_SOC_RT5677=m
CONFIG_SND_SOC_RT5677_SPI=m
CONFIG_SND_SOC_RT5682=m
CONFIG_SND_SOC_RT5682_I2C=m
# CONFIG_SND_SOC_RT5682_SDW is not set
CONFIG_SND_SOC_RT5682S=m
# CONFIG_SND_SOC_RT700_SDW is not set
# CONFIG_SND_SOC_RT711_SDW is not set
# CONFIG_SND_SOC_RT711_SDCA_SDW is not set
# CONFIG_SND_SOC_RT715_SDW is not set
# CONFIG_SND_SOC_RT715_SDCA_SDW is not set
CONFIG_SND_SOC_RT9120=m
# CONFIG_SND_SOC_SDW_MOCKUP is not set
CONFIG_SND_SOC_SGTL5000=m
CONFIG_SND_SOC_SI476X=m
CONFIG_SND_SOC_SIGMADSP=m
CONFIG_SND_SOC_SIGMADSP_I2C=m
CONFIG_SND_SOC_SIGMADSP_REGMAP=m
# CONFIG_SND_SOC_SIMPLE_AMPLIFIER is not set
CONFIG_SND_SOC_SIMPLE_MUX=m
CONFIG_SND_SOC_SPDIF=m
# CONFIG_SND_SOC_SSM2305 is not set
# CONFIG_SND_SOC_SSM2518 is not set
# CONFIG_SND_SOC_SSM2602_SPI is not set
# CONFIG_SND_SOC_SSM2602_I2C is not set
CONFIG_SND_SOC_SSM4567=m
# CONFIG_SND_SOC_STA32X is not set
CONFIG_SND_SOC_STA350=m
CONFIG_SND_SOC_STA529=m
CONFIG_SND_SOC_STAC9766=m
# CONFIG_SND_SOC_STI_SAS is not set
CONFIG_SND_SOC_TAS2552=m
# CONFIG_SND_SOC_TAS2562 is not set
# CONFIG_SND_SOC_TAS2764 is not set
CONFIG_SND_SOC_TAS2770=m
CONFIG_SND_SOC_TAS2780=m
CONFIG_SND_SOC_TAS5086=m
CONFIG_SND_SOC_TAS571X=m
CONFIG_SND_SOC_TAS5720=m
CONFIG_SND_SOC_TAS5805M=m
# CONFIG_SND_SOC_TAS6424 is not set
CONFIG_SND_SOC_TDA7419=m
# CONFIG_SND_SOC_TFA9879 is not set
CONFIG_SND_SOC_TFA989X=m
CONFIG_SND_SOC_TLV320ADC3XXX=m
CONFIG_SND_SOC_TLV320AIC23=m
CONFIG_SND_SOC_TLV320AIC23_I2C=m
CONFIG_SND_SOC_TLV320AIC23_SPI=m
CONFIG_SND_SOC_TLV320AIC26=m
CONFIG_SND_SOC_TLV320AIC31XX=m
# CONFIG_SND_SOC_TLV320AIC32X4_I2C is not set
# CONFIG_SND_SOC_TLV320AIC32X4_SPI is not set
CONFIG_SND_SOC_TLV320AIC3X=m
CONFIG_SND_SOC_TLV320AIC3X_I2C=m
CONFIG_SND_SOC_TLV320AIC3X_SPI=m
CONFIG_SND_SOC_TLV320DAC33=m
CONFIG_SND_SOC_TLV320ADCX140=m
CONFIG_SND_SOC_TS3A227E=m
CONFIG_SND_SOC_TSCS42XX=m
CONFIG_SND_SOC_TSCS454=m
# CONFIG_SND_SOC_TWL4030 is not set
# CONFIG_SND_SOC_TWL6040 is not set
# CONFIG_SND_SOC_UDA1334 is not set
CONFIG_SND_SOC_UDA134X=m
CONFIG_SND_SOC_UDA1380=m
# CONFIG_SND_SOC_WCD9335 is not set
# CONFIG_SND_SOC_WCD934X is not set
# CONFIG_SND_SOC_WCD938X_SDW is not set
CONFIG_SND_SOC_WL1273=m
CONFIG_SND_SOC_WM0010=m
CONFIG_SND_SOC_WM1250_EV1=m
CONFIG_SND_SOC_WM2000=m
CONFIG_SND_SOC_WM2200=m
CONFIG_SND_SOC_WM5100=m
CONFIG_SND_SOC_WM5102=m
CONFIG_SND_SOC_WM5110=m
CONFIG_SND_SOC_WM8350=m
CONFIG_SND_SOC_WM8400=m
CONFIG_SND_SOC_WM8510=m
CONFIG_SND_SOC_WM8523=m
CONFIG_SND_SOC_WM8524=m
# CONFIG_SND_SOC_WM8580 is not set
# CONFIG_SND_SOC_WM8711 is not set
CONFIG_SND_SOC_WM8727=m
CONFIG_SND_SOC_WM8728=m
CONFIG_SND_SOC_WM8731=m
CONFIG_SND_SOC_WM8731_I2C=m
CONFIG_SND_SOC_WM8731_SPI=m
CONFIG_SND_SOC_WM8737=m
CONFIG_SND_SOC_WM8741=m
CONFIG_SND_SOC_WM8750=m
CONFIG_SND_SOC_WM8753=m
# CONFIG_SND_SOC_WM8770 is not set
CONFIG_SND_SOC_WM8776=m
CONFIG_SND_SOC_WM8782=m
CONFIG_SND_SOC_WM8804=m
CONFIG_SND_SOC_WM8804_I2C=m
CONFIG_SND_SOC_WM8804_SPI=m
CONFIG_SND_SOC_WM8900=m
CONFIG_SND_SOC_WM8903=m
# CONFIG_SND_SOC_WM8904 is not set
# CONFIG_SND_SOC_WM8940 is not set
CONFIG_SND_SOC_WM8955=m
CONFIG_SND_SOC_WM8960=m
CONFIG_SND_SOC_WM8961=m
CONFIG_SND_SOC_WM8962=m
CONFIG_SND_SOC_WM8971=m
CONFIG_SND_SOC_WM8974=m
CONFIG_SND_SOC_WM8978=m
CONFIG_SND_SOC_WM8983=m
CONFIG_SND_SOC_WM8985=m
CONFIG_SND_SOC_WM8988=m
CONFIG_SND_SOC_WM8990=m
CONFIG_SND_SOC_WM8991=m
CONFIG_SND_SOC_WM8993=m
CONFIG_SND_SOC_WM8994=m
CONFIG_SND_SOC_WM8995=m
CONFIG_SND_SOC_WM8996=m
# CONFIG_SND_SOC_WM8997 is not set
# CONFIG_SND_SOC_WM8998 is not set
CONFIG_SND_SOC_WM9081=m
CONFIG_SND_SOC_WM9090=m
CONFIG_SND_SOC_WM9705=m
CONFIG_SND_SOC_WM9712=m
CONFIG_SND_SOC_WM9713=m
# CONFIG_SND_SOC_WSA881X is not set
# CONFIG_SND_SOC_WSA883X is not set
CONFIG_SND_SOC_ZL38060=m
CONFIG_SND_SOC_LM4857=m
# CONFIG_SND_SOC_MAX9759 is not set
CONFIG_SND_SOC_MAX9768=m
CONFIG_SND_SOC_MAX9877=m
CONFIG_SND_SOC_MC13783=m
CONFIG_SND_SOC_ML26124=m
CONFIG_SND_SOC_MT6351=m
CONFIG_SND_SOC_MT6358=m
# CONFIG_SND_SOC_MT6359 is not set
CONFIG_SND_SOC_MT6660=m
CONFIG_SND_SOC_NAU8315=m
# CONFIG_SND_SOC_NAU8540 is not set
CONFIG_SND_SOC_NAU8810=m
CONFIG_SND_SOC_NAU8821=m
CONFIG_SND_SOC_NAU8822=m
CONFIG_SND_SOC_NAU8824=m
CONFIG_SND_SOC_NAU8825=m
# CONFIG_SND_SOC_TPA6130A2 is not set
CONFIG_SND_SOC_LPASS_MACRO_COMMON=m
CONFIG_SND_SOC_LPASS_WSA_MACRO=m
# CONFIG_SND_SOC_LPASS_VA_MACRO is not set
# CONFIG_SND_SOC_LPASS_RX_MACRO is not set
CONFIG_SND_SOC_LPASS_TX_MACRO=m
# end of CODEC drivers

CONFIG_SND_SIMPLE_CARD_UTILS=m
CONFIG_SND_SIMPLE_CARD=m
# CONFIG_SND_AUDIO_GRAPH_CARD is not set
# CONFIG_SND_AUDIO_GRAPH_CARD2 is not set
# CONFIG_SND_TEST_COMPONENT is not set
CONFIG_SND_VIRTIO=m
CONFIG_AC97_BUS=m

#
# HID support
#
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
# CONFIG_HIDRAW is not set
CONFIG_UHID=y
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
CONFIG_HID_A4TECH=m
# CONFIG_HID_ACCUTOUCH is not set
# CONFIG_HID_ACRUX is not set
CONFIG_HID_APPLE=y
CONFIG_HID_APPLEIR=y
# CONFIG_HID_ASUS is not set
# CONFIG_HID_AUREAL is not set
CONFIG_HID_BELKIN=y
CONFIG_HID_BETOP_FF=y
# CONFIG_HID_BIGBEN_FF is not set
# CONFIG_HID_CHERRY is not set
# CONFIG_HID_CHICONY is not set
CONFIG_HID_CORSAIR=y
# CONFIG_HID_COUGAR is not set
# CONFIG_HID_MACALLY is not set
CONFIG_HID_PRODIKEYS=m
CONFIG_HID_CMEDIA=y
# CONFIG_HID_CREATIVE_SB0540 is not set
# CONFIG_HID_CYPRESS is not set
CONFIG_HID_DRAGONRISE=y
CONFIG_DRAGONRISE_FF=y
CONFIG_HID_EMS_FF=y
CONFIG_HID_ELAN=y
CONFIG_HID_ELECOM=m
CONFIG_HID_ELO=y
CONFIG_HID_EZKEY=m
# CONFIG_HID_GEMBIRD is not set
# CONFIG_HID_GFRM is not set
CONFIG_HID_GLORIOUS=m
CONFIG_HID_HOLTEK=y
CONFIG_HOLTEK_FF=y
# CONFIG_HID_VIVALDI is not set
# CONFIG_HID_GT683R is not set
# CONFIG_HID_KEYTOUCH is not set
CONFIG_HID_KYE=m
# CONFIG_HID_UCLOGIC is not set
# CONFIG_HID_WALTOP is not set
CONFIG_HID_VIEWSONIC=m
# CONFIG_HID_XIAOMI is not set
# CONFIG_HID_GYRATION is not set
CONFIG_HID_ICADE=y
CONFIG_HID_ITE=m
CONFIG_HID_JABRA=m
CONFIG_HID_TWINHAN=y
# CONFIG_HID_KENSINGTON is not set
CONFIG_HID_LCPOWER=y
CONFIG_HID_LED=y
CONFIG_HID_LENOVO=y
CONFIG_HID_LETSKETCH=y
CONFIG_HID_LOGITECH=y
# CONFIG_HID_LOGITECH_HIDPP is not set
# CONFIG_LOGITECH_FF is not set
CONFIG_LOGIRUMBLEPAD2_FF=y
CONFIG_LOGIG940_FF=y
CONFIG_LOGIWHEELS_FF=y
# CONFIG_HID_MAGICMOUSE is not set
CONFIG_HID_MALTRON=y
CONFIG_HID_MAYFLASH=y
# CONFIG_HID_MEGAWORLD_FF is not set
CONFIG_HID_REDRAGON=y
# CONFIG_HID_MICROSOFT is not set
CONFIG_HID_MONTEREY=m
CONFIG_HID_MULTITOUCH=y
# CONFIG_HID_NINTENDO is not set
CONFIG_HID_NTI=m
# CONFIG_HID_NTRIG is not set
# CONFIG_HID_ORTEK is not set
# CONFIG_HID_PANTHERLORD is not set
CONFIG_HID_PENMOUNT=m
CONFIG_HID_PETALYNX=y
CONFIG_HID_PICOLCD=y
CONFIG_HID_PICOLCD_BACKLIGHT=y
CONFIG_HID_PICOLCD_LEDS=y
CONFIG_HID_PLANTRONICS=y
CONFIG_HID_PLAYSTATION=y
CONFIG_PLAYSTATION_FF=y
# CONFIG_HID_RAZER is not set
CONFIG_HID_PRIMAX=m
CONFIG_HID_RETRODE=m
# CONFIG_HID_ROCCAT is not set
CONFIG_HID_SAITEK=y
CONFIG_HID_SAMSUNG=m
# CONFIG_HID_SEMITEK is not set
CONFIG_HID_SIGMAMICRO=m
CONFIG_HID_SONY=y
CONFIG_SONY_FF=y
# CONFIG_HID_SPEEDLINK is not set
# CONFIG_HID_STEAM is not set
# CONFIG_HID_STEELSERIES is not set
# CONFIG_HID_SUNPLUS is not set
# CONFIG_HID_RMI is not set
CONFIG_HID_GREENASIA=y
CONFIG_GREENASIA_FF=y
CONFIG_HID_SMARTJOYPLUS=y
CONFIG_SMARTJOYPLUS_FF=y
CONFIG_HID_TIVO=y
# CONFIG_HID_TOPSEED is not set
CONFIG_HID_THINGM=m
# CONFIG_HID_THRUSTMASTER is not set
# CONFIG_HID_UDRAW_PS3 is not set
# CONFIG_HID_U2FZERO is not set
CONFIG_HID_WACOM=y
CONFIG_HID_WIIMOTE=m
CONFIG_HID_XINMO=y
# CONFIG_HID_ZEROPLUS is not set
CONFIG_HID_ZYDACRON=m
CONFIG_HID_SENSOR_HUB=m
# CONFIG_HID_SENSOR_CUSTOM_SENSOR is not set
CONFIG_HID_ALPS=y
CONFIG_HID_MCP2221=m
# end of Special HID drivers

#
# USB HID support
#
CONFIG_USB_HID=y
CONFIG_HID_PID=y
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

#
# Surface System Aggregator Module HID support
#
CONFIG_SURFACE_KBD=m
# end of Surface System Aggregator Module HID support

CONFIG_SURFACE_HID_CORE=m
# end of HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
# CONFIG_USB_LED_TRIG is not set
CONFIG_USB_ULPI_BUS=m
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
CONFIG_USB_OTG_PRODUCTLIST=y
# CONFIG_USB_OTG_DISABLE_EXTERNAL_HUB is not set
CONFIG_USB_LEDS_TRIGGER_USBPORT=m
CONFIG_USB_AUTOSUSPEND_DELAY=2
CONFIG_USB_MON=y

#
# USB Host Controller Drivers
#
CONFIG_USB_C67X00_HCD=m
# CONFIG_USB_XHCI_HCD is not set
# CONFIG_USB_BRCMSTB is not set
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
# CONFIG_USB_EHCI_TT_NEWSCHED is not set
CONFIG_USB_EHCI_PCI=y
# CONFIG_USB_EHCI_FSL is not set
CONFIG_USB_EHCI_HCD_NPCM7XX=m
# CONFIG_USB_EHCI_HCD_OMAP is not set
# CONFIG_USB_EHCI_HCD_ORION is not set
CONFIG_USB_EHCI_HCD_SPEAR=y
# CONFIG_USB_EHCI_HCD_STI is not set
CONFIG_USB_EHCI_HCD_AT91=y
# CONFIG_USB_EHCI_SH is not set
CONFIG_USB_EHCI_EXYNOS=m
CONFIG_USB_EHCI_MV=m
# CONFIG_USB_CNS3XXX_EHCI is not set
CONFIG_USB_EHCI_HCD_PLATFORM=y
CONFIG_USB_OXU210HP_HCD=m
CONFIG_USB_ISP116X_HCD=m
CONFIG_USB_ISP1362_HCD=m
CONFIG_USB_FOTG210_HCD=y
CONFIG_USB_MAX3421_HCD=y
# CONFIG_USB_OHCI_HCD is not set
# CONFIG_USB_UHCI_HCD is not set
# CONFIG_USB_U132_HCD is not set
CONFIG_USB_SL811_HCD=y
# CONFIG_USB_SL811_HCD_ISO is not set
CONFIG_USB_R8A66597_HCD=y
CONFIG_USB_HCD_SSB=y
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
CONFIG_USB_ACM=m
# CONFIG_USB_PRINTER is not set
# CONFIG_USB_WDM is not set
CONFIG_USB_TMC=y

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=y
# CONFIG_USB_STORAGE_DEBUG is not set
CONFIG_USB_STORAGE_REALTEK=m
CONFIG_USB_STORAGE_DATAFAB=m
CONFIG_USB_STORAGE_FREECOM=y
CONFIG_USB_STORAGE_ISD200=y
CONFIG_USB_STORAGE_USBAT=m
CONFIG_USB_STORAGE_SDDR09=m
# CONFIG_USB_STORAGE_SDDR55 is not set
CONFIG_USB_STORAGE_JUMPSHOT=m
# CONFIG_USB_STORAGE_ALAUDA is not set
CONFIG_USB_STORAGE_ONETOUCH=y
CONFIG_USB_STORAGE_KARMA=m
CONFIG_USB_STORAGE_CYPRESS_ATACB=m
CONFIG_USB_STORAGE_ENE_UB6250=m
CONFIG_USB_UAS=m

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set
CONFIG_USB_CDNS_SUPPORT=y
CONFIG_USB_CDNS_HOST=y
# CONFIG_USB_CDNS3 is not set
CONFIG_USB_CDNSP_PCI=m
CONFIG_USB_CDNSP_HOST=y
# CONFIG_USB_MTU3 is not set
CONFIG_USB_MUSB_HDRC=y
CONFIG_USB_MUSB_HOST=y

#
# Platform Glue Layer
#
# CONFIG_USB_MUSB_DSPS is not set
# CONFIG_USB_MUSB_UX500 is not set
CONFIG_USB_MUSB_MEDIATEK=m
# CONFIG_USB_MUSB_POLARFIRE_SOC is not set

#
# MUSB DMA mode
#
CONFIG_MUSB_PIO_ONLY=y
CONFIG_USB_DWC3=y
CONFIG_USB_DWC3_HOST=y

#
# Platform Glue Driver Support
#
CONFIG_USB_DWC3_OMAP=y
CONFIG_USB_DWC3_EXYNOS=y
# CONFIG_USB_DWC3_PCI is not set
CONFIG_USB_DWC3_HAPS=y
CONFIG_USB_DWC3_KEYSTONE=y
CONFIG_USB_DWC3_MESON_G12A=y
CONFIG_USB_DWC3_OF_SIMPLE=y
CONFIG_USB_DWC3_ST=y
CONFIG_USB_DWC3_QCOM=y
CONFIG_USB_DWC3_IMX8MP=y
CONFIG_USB_DWC3_AM62=y
# CONFIG_USB_DWC2 is not set
CONFIG_USB_CHIPIDEA=m
CONFIG_USB_CHIPIDEA_HOST=y
CONFIG_USB_CHIPIDEA_PCI=m
CONFIG_USB_CHIPIDEA_MSM=m
CONFIG_USB_CHIPIDEA_IMX=m
CONFIG_USB_CHIPIDEA_GENERIC=m
CONFIG_USB_CHIPIDEA_TEGRA=m
CONFIG_USB_ISP1760=m
CONFIG_USB_ISP1760_HCD=y
CONFIG_USB_ISP1760_HOST_ROLE=y

#
# USB port drivers
#
CONFIG_USB_USS720=m
CONFIG_USB_SERIAL=y
# CONFIG_USB_SERIAL_CONSOLE is not set
CONFIG_USB_SERIAL_GENERIC=y
CONFIG_USB_SERIAL_SIMPLE=y
CONFIG_USB_SERIAL_AIRCABLE=m
CONFIG_USB_SERIAL_ARK3116=m
CONFIG_USB_SERIAL_BELKIN=m
CONFIG_USB_SERIAL_CH341=y
# CONFIG_USB_SERIAL_WHITEHEAT is not set
CONFIG_USB_SERIAL_DIGI_ACCELEPORT=m
# CONFIG_USB_SERIAL_CP210X is not set
CONFIG_USB_SERIAL_CYPRESS_M8=m
CONFIG_USB_SERIAL_EMPEG=y
CONFIG_USB_SERIAL_FTDI_SIO=m
# CONFIG_USB_SERIAL_VISOR is not set
# CONFIG_USB_SERIAL_IPAQ is not set
CONFIG_USB_SERIAL_IR=y
CONFIG_USB_SERIAL_EDGEPORT=y
CONFIG_USB_SERIAL_EDGEPORT_TI=m
# CONFIG_USB_SERIAL_F81232 is not set
CONFIG_USB_SERIAL_F8153X=m
CONFIG_USB_SERIAL_GARMIN=y
CONFIG_USB_SERIAL_IPW=y
# CONFIG_USB_SERIAL_IUU is not set
CONFIG_USB_SERIAL_KEYSPAN_PDA=y
CONFIG_USB_SERIAL_KEYSPAN=y
CONFIG_USB_SERIAL_KLSI=y
# CONFIG_USB_SERIAL_KOBIL_SCT is not set
# CONFIG_USB_SERIAL_MCT_U232 is not set
CONFIG_USB_SERIAL_METRO=m
# CONFIG_USB_SERIAL_MOS7720 is not set
# CONFIG_USB_SERIAL_MOS7840 is not set
CONFIG_USB_SERIAL_MXUPORT=m
CONFIG_USB_SERIAL_NAVMAN=m
# CONFIG_USB_SERIAL_PL2303 is not set
# CONFIG_USB_SERIAL_OTI6858 is not set
CONFIG_USB_SERIAL_QCAUX=y
CONFIG_USB_SERIAL_QUALCOMM=m
CONFIG_USB_SERIAL_SPCP8X5=y
CONFIG_USB_SERIAL_SAFE=y
# CONFIG_USB_SERIAL_SAFE_PADDED is not set
# CONFIG_USB_SERIAL_SIERRAWIRELESS is not set
CONFIG_USB_SERIAL_SYMBOL=y
# CONFIG_USB_SERIAL_TI is not set
CONFIG_USB_SERIAL_CYBERJACK=y
CONFIG_USB_SERIAL_WWAN=y
# CONFIG_USB_SERIAL_OPTION is not set
# CONFIG_USB_SERIAL_OMNINET is not set
# CONFIG_USB_SERIAL_OPTICON is not set
# CONFIG_USB_SERIAL_XSENS_MT is not set
CONFIG_USB_SERIAL_WISHBONE=m
# CONFIG_USB_SERIAL_SSU100 is not set
CONFIG_USB_SERIAL_QT2=y
CONFIG_USB_SERIAL_UPD78F0730=m
CONFIG_USB_SERIAL_XR=y
# CONFIG_USB_SERIAL_DEBUG is not set

#
# USB Miscellaneous drivers
#
CONFIG_USB_EMI62=y
CONFIG_USB_EMI26=m
CONFIG_USB_ADUTUX=m
CONFIG_USB_SEVSEG=y
CONFIG_USB_LEGOTOWER=y
CONFIG_USB_LCD=m
CONFIG_USB_CYPRESS_CY7C63=m
CONFIG_USB_CYTHERM=y
CONFIG_USB_IDMOUSE=y
CONFIG_USB_FTDI_ELAN=m
CONFIG_USB_APPLEDISPLAY=y
CONFIG_USB_QCOM_EUD=y
CONFIG_APPLE_MFI_FASTCHARGE=m
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_LD is not set
CONFIG_USB_TRANCEVIBRATOR=y
CONFIG_USB_IOWARRIOR=y
# CONFIG_USB_TEST is not set
CONFIG_USB_EHSET_TEST_FIXTURE=y
CONFIG_USB_ISIGHTFW=y
# CONFIG_USB_YUREX is not set
CONFIG_USB_EZUSB_FX2=y
CONFIG_USB_HUB_USB251XB=m
CONFIG_USB_HSIC_USB3503=y
CONFIG_USB_HSIC_USB4604=y
# CONFIG_USB_LINK_LAYER_TEST is not set
CONFIG_USB_CHAOSKEY=m
# CONFIG_BRCM_USB_PINMAP is not set
# CONFIG_USB_ONBOARD_HUB is not set

#
# USB Physical Layer drivers
#
CONFIG_USB_PHY=y
CONFIG_KEYSTONE_USB_PHY=m
CONFIG_NOP_USB_XCEIV=m
CONFIG_AM335X_CONTROL_USB=m
CONFIG_AM335X_PHY_USB=m
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_TAHVO_USB is not set
CONFIG_USB_ISP1301=m
# CONFIG_USB_TEGRA_PHY is not set
CONFIG_USB_ULPI=y
CONFIG_USB_ULPI_VIEWPORT=y
# CONFIG_JZ4770_PHY is not set
# end of USB Physical Layer drivers

# CONFIG_USB_GADGET is not set
# CONFIG_TYPEC is not set
CONFIG_USB_ROLE_SWITCH=y
CONFIG_MMC=m
CONFIG_PWRSEQ_EMMC=m
CONFIG_PWRSEQ_SIMPLE=m
CONFIG_MMC_BLOCK=m
CONFIG_MMC_BLOCK_MINORS=8
CONFIG_SDIO_UART=m
CONFIG_MMC_TEST=m

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_SDHCI=m
CONFIG_MMC_SDHCI_IO_ACCESSORS=y
CONFIG_MMC_SDHCI_PCI=m
CONFIG_MMC_RICOH_MMC=y
CONFIG_MMC_SDHCI_ACPI=m
CONFIG_MMC_SDHCI_PLTFM=m
# CONFIG_MMC_SDHCI_OF_ARASAN is not set
# CONFIG_MMC_SDHCI_OF_ASPEED is not set
# CONFIG_MMC_SDHCI_OF_AT91 is not set
CONFIG_MMC_SDHCI_OF_ESDHC=m
# CONFIG_MMC_SDHCI_OF_DWCMSHC is not set
# CONFIG_MMC_SDHCI_OF_SPARX5 is not set
# CONFIG_MMC_SDHCI_CADENCE is not set
CONFIG_MMC_SDHCI_CNS3XXX=m
# CONFIG_MMC_SDHCI_ESDHC_IMX is not set
CONFIG_MMC_SDHCI_DOVE=m
CONFIG_MMC_SDHCI_TEGRA=m
# CONFIG_MMC_SDHCI_S3C is not set
# CONFIG_MMC_SDHCI_PXAV3 is not set
CONFIG_MMC_SDHCI_PXAV2=m
# CONFIG_MMC_SDHCI_SPEAR is not set
# CONFIG_MMC_SDHCI_BCM_KONA is not set
CONFIG_MMC_SDHCI_F_SDH30=m
# CONFIG_MMC_SDHCI_MILBEAUT is not set
# CONFIG_MMC_SDHCI_IPROC is not set
CONFIG_MMC_MESON_GX=m
# CONFIG_MMC_MESON_MX_SDHC is not set
# CONFIG_MMC_MESON_MX_SDIO is not set
CONFIG_MMC_MOXART=m
CONFIG_MMC_SDHCI_ST=m
CONFIG_MMC_OMAP_HS=m
# CONFIG_MMC_ALCOR is not set
CONFIG_MMC_SDHCI_MSM=m
CONFIG_MMC_TIFM_SD=m
CONFIG_MMC_DAVINCI=m
CONFIG_MMC_SPI=m
CONFIG_MMC_S3C=m
CONFIG_MMC_S3C_HW_SDIO_IRQ=y
# CONFIG_MMC_S3C_PIO is not set
CONFIG_MMC_S3C_DMA=y
CONFIG_MMC_SDHCI_SPRD=m
CONFIG_MMC_TMIO_CORE=m
CONFIG_MMC_TMIO=m
# CONFIG_MMC_SDHI is not set
# CONFIG_MMC_UNIPHIER is not set
CONFIG_MMC_CB710=m
# CONFIG_MMC_VIA_SDMMC is not set
# CONFIG_MMC_CAVIUM_THUNDERX is not set
CONFIG_MMC_DW=m
CONFIG_MMC_DW_PLTFM=m
CONFIG_MMC_DW_BLUEFIELD=m
CONFIG_MMC_DW_EXYNOS=m
# CONFIG_MMC_DW_HI3798CV200 is not set
CONFIG_MMC_DW_K3=m
CONFIG_MMC_DW_PCI=m
CONFIG_MMC_SH_MMCIF=m
CONFIG_MMC_VUB300=m
CONFIG_MMC_USHC=m
CONFIG_MMC_USDHI6ROL0=m
CONFIG_MMC_REALTEK_PCI=m
# CONFIG_MMC_REALTEK_USB is not set
CONFIG_MMC_CQHCI=m
CONFIG_MMC_HSQ=m
# CONFIG_MMC_TOSHIBA_PCI is not set
# CONFIG_MMC_BCM2835 is not set
CONFIG_MMC_MTK=m
CONFIG_MMC_SDHCI_XENON=m
# CONFIG_MMC_SDHCI_OMAP is not set
# CONFIG_MMC_SDHCI_AM654 is not set
# CONFIG_MMC_OWL is not set
CONFIG_MMC_LITEX=m
CONFIG_SCSI_UFSHCD=y
# CONFIG_SCSI_UFS_BSG is not set
# CONFIG_SCSI_UFS_HPB is not set
CONFIG_SCSI_UFS_FAULT_INJECTION=y
CONFIG_SCSI_UFS_HWMON=y
# CONFIG_SCSI_UFSHCD_PCI is not set
CONFIG_SCSI_UFSHCD_PLATFORM=m
CONFIG_SCSI_UFS_CDNS_PLATFORM=m
CONFIG_SCSI_UFS_DWC_TC_PLATFORM=m
CONFIG_SCSI_UFS_HISI=m
# CONFIG_SCSI_UFS_RENESAS is not set
# CONFIG_SCSI_UFS_TI_J721E is not set
CONFIG_SCSI_UFS_EXYNOS=m
CONFIG_MEMSTICK=y
# CONFIG_MEMSTICK_DEBUG is not set

#
# MemoryStick drivers
#
CONFIG_MEMSTICK_UNSAFE_RESUME=y
# CONFIG_MSPRO_BLOCK is not set
# CONFIG_MS_BLOCK is not set

#
# MemoryStick Host Controller Drivers
#
CONFIG_MEMSTICK_TIFM_MS=m
# CONFIG_MEMSTICK_JMICRON_38X is not set
# CONFIG_MEMSTICK_R592 is not set
CONFIG_MEMSTICK_REALTEK_PCI=m
CONFIG_MEMSTICK_REALTEK_USB=m
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set
CONFIG_LEDS_CLASS_MULTICOLOR=y
CONFIG_LEDS_BRIGHTNESS_HW_CHANGED=y

#
# LED drivers
#
# CONFIG_LEDS_88PM860X is not set
# CONFIG_LEDS_AN30259A is not set
CONFIG_LEDS_ARIEL=y
# CONFIG_LEDS_AW2013 is not set
# CONFIG_LEDS_BCM6328 is not set
# CONFIG_LEDS_BCM6358 is not set
# CONFIG_LEDS_CPCAP is not set
# CONFIG_LEDS_CR0014114 is not set
# CONFIG_LEDS_EL15203000 is not set
# CONFIG_LEDS_TURRIS_OMNIA is not set
CONFIG_LEDS_LM3530=y
CONFIG_LEDS_LM3532=m
# CONFIG_LEDS_LM3533 is not set
CONFIG_LEDS_LM3642=y
# CONFIG_LEDS_LM3692X is not set
CONFIG_LEDS_MT6323=m
CONFIG_LEDS_S3C24XX=m
CONFIG_LEDS_COBALT_QUBE=m
# CONFIG_LEDS_COBALT_RAQ is not set
CONFIG_LEDS_PCA9532=m
CONFIG_LEDS_PCA9532_GPIO=y
CONFIG_LEDS_GPIO=m
# CONFIG_LEDS_LP3944 is not set
# CONFIG_LEDS_LP3952 is not set
CONFIG_LEDS_LP50XX=m
# CONFIG_LEDS_LP55XX_COMMON is not set
# CONFIG_LEDS_LP8788 is not set
# CONFIG_LEDS_LP8860 is not set
CONFIG_LEDS_PCA955X=y
CONFIG_LEDS_PCA955X_GPIO=y
# CONFIG_LEDS_PCA963X is not set
CONFIG_LEDS_WM8350=m
CONFIG_LEDS_DA903X=y
CONFIG_LEDS_DA9052=y
CONFIG_LEDS_DAC124S085=y
CONFIG_LEDS_PWM=m
# CONFIG_LEDS_REGULATOR is not set
CONFIG_LEDS_BD2802=y
CONFIG_LEDS_LT3593=y
CONFIG_LEDS_MC13783=y
CONFIG_LEDS_NS2=y
CONFIG_LEDS_NETXBIG=y
CONFIG_LEDS_TCA6507=m
# CONFIG_LEDS_TLC591XX is not set
CONFIG_LEDS_MAX77650=m
# CONFIG_LEDS_LM355x is not set
CONFIG_LEDS_OT200=y
CONFIG_LEDS_MENF21BMC=m
# CONFIG_LEDS_IS31FL319X is not set
# CONFIG_LEDS_IS31FL32XX is not set
# CONFIG_LEDS_SC27XX_BLTC is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
# CONFIG_LEDS_BLINKM is not set
# CONFIG_LEDS_SYSCON is not set
CONFIG_LEDS_MLXREG=y
CONFIG_LEDS_USER=y
# CONFIG_LEDS_SPI_BYTE is not set
CONFIG_LEDS_TI_LMU_COMMON=y
# CONFIG_LEDS_LM3697 is not set
CONFIG_LEDS_LM36274=m
CONFIG_LEDS_IP30=y
CONFIG_LEDS_ACER_A500=m
# CONFIG_LEDS_BCM63138 is not set
# CONFIG_LEDS_LGM is not set

#
# Flash and Torch LED drivers
#

#
# RGB LED drivers
#
# CONFIG_LEDS_PWM_MULTICOLOR is not set
# CONFIG_LEDS_QCOM_LPG is not set

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=y
# CONFIG_LEDS_TRIGGER_ONESHOT is not set
# CONFIG_LEDS_TRIGGER_DISK is not set
# CONFIG_LEDS_TRIGGER_MTD is not set
# CONFIG_LEDS_TRIGGER_HEARTBEAT is not set
CONFIG_LEDS_TRIGGER_BACKLIGHT=m
CONFIG_LEDS_TRIGGER_CPU=y
CONFIG_LEDS_TRIGGER_ACTIVITY=y
CONFIG_LEDS_TRIGGER_GPIO=m
CONFIG_LEDS_TRIGGER_DEFAULT_ON=y

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=m
CONFIG_LEDS_TRIGGER_CAMERA=m
CONFIG_LEDS_TRIGGER_PANIC=y
CONFIG_LEDS_TRIGGER_PATTERN=y
CONFIG_LEDS_TRIGGER_AUDIO=m
# CONFIG_LEDS_TRIGGER_TTY is not set

#
# Simple LED drivers
#
CONFIG_ACCESSIBILITY=y

#
# Speakup console speech
#
# end of Speakup console speech

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
# CONFIG_DMABUF_HEAPS is not set
CONFIG_DMABUF_SYSFS_STATS=y
# end of DMABUF options

CONFIG_AUXDISPLAY=y
CONFIG_CHARLCD=y
CONFIG_LINEDISP=y
CONFIG_HD44780_COMMON=y
CONFIG_HD44780=y
CONFIG_KS0108=m
CONFIG_KS0108_PORT=0x378
CONFIG_KS0108_DELAY=2
CONFIG_IMG_ASCII_LCD=m
CONFIG_HT16K33=m
CONFIG_LCD2S=m
CONFIG_PARPORT_PANEL=m
CONFIG_PANEL_PARPORT=0
CONFIG_PANEL_PROFILE=5
CONFIG_PANEL_CHANGE_MESSAGE=y
CONFIG_PANEL_BOOT_MESSAGE=""
# CONFIG_CHARLCD_BL_OFF is not set
# CONFIG_CHARLCD_BL_ON is not set
CONFIG_CHARLCD_BL_FLASH=y
CONFIG_PANEL=m
# CONFIG_UIO is not set
# CONFIG_VFIO is not set
CONFIG_VIRT_DRIVERS=y
CONFIG_VMGENID=y
CONFIG_VIRTIO_ANCHOR=y
CONFIG_VIRTIO=y
# CONFIG_VIRTIO_MENU is not set
CONFIG_VHOST_MENU=y
CONFIG_VHOST_CROSS_ENDIAN_LEGACY=y

#
# Microsoft Hyper-V guest support
#
# end of Microsoft Hyper-V guest support

# CONFIG_GREYBUS is not set
# CONFIG_COMEDI is not set
CONFIG_STAGING=y
# CONFIG_RTS5208 is not set
CONFIG_FB_SM750=m
# CONFIG_STAGING_MEDIA is not set
# CONFIG_STAGING_BOARD is not set
# CONFIG_FIREWIRE_SERIAL is not set
# CONFIG_COMMON_CLK_XLNX_CLKWZRD is not set
CONFIG_FB_TFT=m
# CONFIG_FB_TFT_AGM1264K_FL is not set
# CONFIG_FB_TFT_BD663474 is not set
# CONFIG_FB_TFT_HX8340BN is not set
CONFIG_FB_TFT_HX8347D=m
CONFIG_FB_TFT_HX8353D=m
# CONFIG_FB_TFT_HX8357D is not set
CONFIG_FB_TFT_ILI9163=m
# CONFIG_FB_TFT_ILI9320 is not set
# CONFIG_FB_TFT_ILI9325 is not set
CONFIG_FB_TFT_ILI9340=m
CONFIG_FB_TFT_ILI9341=m
CONFIG_FB_TFT_ILI9481=m
# CONFIG_FB_TFT_ILI9486 is not set
CONFIG_FB_TFT_PCD8544=m
CONFIG_FB_TFT_RA8875=m
# CONFIG_FB_TFT_S6D02A1 is not set
CONFIG_FB_TFT_S6D1121=m
CONFIG_FB_TFT_SEPS525=m
CONFIG_FB_TFT_SH1106=m
# CONFIG_FB_TFT_SSD1289 is not set
CONFIG_FB_TFT_SSD1305=m
# CONFIG_FB_TFT_SSD1306 is not set
CONFIG_FB_TFT_SSD1331=m
CONFIG_FB_TFT_SSD1351=m
CONFIG_FB_TFT_ST7735R=m
CONFIG_FB_TFT_ST7789V=m
CONFIG_FB_TFT_TINYLCD=m
# CONFIG_FB_TFT_TLS8204 is not set
CONFIG_FB_TFT_UC1611=m
CONFIG_FB_TFT_UC1701=m
# CONFIG_FB_TFT_UPD161704 is not set
CONFIG_MOST_COMPONENTS=y
# CONFIG_MOST_DIM2 is not set
CONFIG_MOST_I2C=m
CONFIG_BCM_VIDEOCORE=y
# CONFIG_BCM2835_VCHIQ is not set
# CONFIG_SND_BCM2835 is not set
CONFIG_PI433=y
# CONFIG_XIL_AXIS_FIFO is not set
CONFIG_FIELDBUS_DEV=y
# CONFIG_HMS_ANYBUSS_BUS is not set
CONFIG_VME_BUS=y

#
# VME Bridge Drivers
#
CONFIG_VME_TSI148=y
# CONFIG_VME_FAKE is not set

#
# VME Device Drivers
#
CONFIG_VME_USER=y
CONFIG_GOLDFISH=y
CONFIG_GOLDFISH_PIPE=m
# CONFIG_CHROME_PLATFORMS is not set
# CONFIG_MELLANOX_PLATFORM is not set
CONFIG_OLPC_XO175=y
CONFIG_SURFACE_PLATFORMS=y
CONFIG_SURFACE_3_POWER_OPREGION=y
# CONFIG_SURFACE_ACPI_NOTIFY is not set
CONFIG_SURFACE_AGGREGATOR_CDEV=m
CONFIG_SURFACE_DTX=m
CONFIG_SURFACE_GPE=y
CONFIG_SURFACE_HOTPLUG=y
# CONFIG_SURFACE_PRO3_BUTTON is not set
CONFIG_SURFACE_AGGREGATOR=m
# CONFIG_SURFACE_AGGREGATOR_BUS is not set
CONFIG_HAVE_CLK=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y

#
# Clock driver for ARM Reference designs
#
# CONFIG_CLK_ICST is not set
# CONFIG_CLK_SP810 is not set
# end of Clock driver for ARM Reference designs

# CONFIG_CLK_HSDK is not set
CONFIG_LMK04832=m
# CONFIG_COMMON_CLK_APPLE_NCO is not set
# CONFIG_COMMON_CLK_MAX77686 is not set
CONFIG_COMMON_CLK_MAX9485=m
CONFIG_COMMON_CLK_HI655X=y
CONFIG_COMMON_CLK_SCMI=y
CONFIG_COMMON_CLK_SCPI=y
CONFIG_COMMON_CLK_SI5341=m
CONFIG_COMMON_CLK_SI5351=y
# CONFIG_COMMON_CLK_SI514 is not set
CONFIG_COMMON_CLK_SI544=m
# CONFIG_COMMON_CLK_SI570 is not set
CONFIG_COMMON_CLK_BM1880=y
CONFIG_COMMON_CLK_CDCE706=m
CONFIG_COMMON_CLK_TPS68470=m
# CONFIG_COMMON_CLK_CDCE925 is not set
CONFIG_COMMON_CLK_CS2000_CP=y
# CONFIG_COMMON_CLK_EN7523 is not set
CONFIG_COMMON_CLK_FSL_FLEXSPI=m
# CONFIG_COMMON_CLK_FSL_SAI is not set
CONFIG_COMMON_CLK_GEMINI=y
# CONFIG_COMMON_CLK_LAN966X is not set
# CONFIG_COMMON_CLK_ASPEED is not set
CONFIG_COMMON_CLK_S2MPS11=m
# CONFIG_COMMON_CLK_AXI_CLKGEN is not set
# CONFIG_CLK_QORIQ is not set
# CONFIG_CLK_LS1028A_PLLDIG is not set
CONFIG_COMMON_CLK_XGENE=y
CONFIG_COMMON_CLK_PWM=y
# CONFIG_COMMON_CLK_OXNAS is not set
# CONFIG_COMMON_CLK_RS9_PCIE is not set
# CONFIG_COMMON_CLK_VC5 is not set
CONFIG_COMMON_CLK_MMP2_AUDIO=m
# CONFIG_COMMON_CLK_FIXED_MMIO is not set
# CONFIG_CLK_ACTIONS is not set
# CONFIG_CLK_BAIKAL_T1 is not set
CONFIG_CLK_BCM2711_DVP=y
CONFIG_CLK_BCM2835=y
# CONFIG_CLK_BCM_63XX is not set
CONFIG_CLK_BCM_63XX_GATE=y
CONFIG_CLK_BCM_KONA=y
CONFIG_COMMON_CLK_IPROC=y
CONFIG_CLK_BCM_CYGNUS=y
# CONFIG_CLK_BCM_HR2 is not set
CONFIG_CLK_BCM_NSP=y
# CONFIG_CLK_BCM_NS2 is not set
# CONFIG_CLK_BCM_SR is not set
# CONFIG_CLK_RASPBERRYPI is not set
CONFIG_COMMON_CLK_HI3516CV300=m
CONFIG_COMMON_CLK_HI3519=y
# CONFIG_COMMON_CLK_HI3559A is not set
CONFIG_COMMON_CLK_HI3660=y
# CONFIG_COMMON_CLK_HI3670 is not set
CONFIG_COMMON_CLK_HI3798CV200=m
CONFIG_COMMON_CLK_HI6220=y
CONFIG_RESET_HISI=y
# CONFIG_STUB_CLK_HI6220 is not set
# CONFIG_STUB_CLK_HI3660 is not set
CONFIG_COMMON_CLK_BOSTON=y
CONFIG_MXC_CLK=y
# CONFIG_CLK_IMX8MM is not set
CONFIG_CLK_IMX8MN=m
CONFIG_CLK_IMX8MP=m
# CONFIG_CLK_IMX8MQ is not set
# CONFIG_CLK_IMX8ULP is not set
CONFIG_CLK_IMX93=y

#
# Ingenic SoCs drivers
#
CONFIG_INGENIC_CGU_COMMON=y
# CONFIG_INGENIC_CGU_JZ4740 is not set
# CONFIG_INGENIC_CGU_JZ4725B is not set
# CONFIG_INGENIC_CGU_JZ4760 is not set
# CONFIG_INGENIC_CGU_JZ4770 is not set
CONFIG_INGENIC_CGU_JZ4780=y
CONFIG_INGENIC_CGU_X1000=y
# CONFIG_INGENIC_CGU_X1830 is not set
CONFIG_INGENIC_TCU_CLK=y
# end of Ingenic SoCs drivers

# CONFIG_COMMON_CLK_KEYSTONE is not set
# CONFIG_TI_SYSCON_CLK is not set

#
# Clock driver for MediaTek SoC
#
CONFIG_COMMON_CLK_MEDIATEK=y
# CONFIG_COMMON_CLK_MT2701 is not set
CONFIG_COMMON_CLK_MT2712=y
CONFIG_COMMON_CLK_MT2712_BDPSYS=y
# CONFIG_COMMON_CLK_MT2712_IMGSYS is not set
# CONFIG_COMMON_CLK_MT2712_JPGDECSYS is not set
# CONFIG_COMMON_CLK_MT2712_MFGCFG is not set
# CONFIG_COMMON_CLK_MT2712_MMSYS is not set
# CONFIG_COMMON_CLK_MT2712_VDECSYS is not set
# CONFIG_COMMON_CLK_MT2712_VENCSYS is not set
# CONFIG_COMMON_CLK_MT6765 is not set
CONFIG_COMMON_CLK_MT6779=y
CONFIG_COMMON_CLK_MT6779_MMSYS=y
CONFIG_COMMON_CLK_MT6779_IMGSYS=y
CONFIG_COMMON_CLK_MT6779_IPESYS=m
CONFIG_COMMON_CLK_MT6779_CAMSYS=y
CONFIG_COMMON_CLK_MT6779_VDECSYS=y
# CONFIG_COMMON_CLK_MT6779_VENCSYS is not set
CONFIG_COMMON_CLK_MT6779_MFGCFG=m
CONFIG_COMMON_CLK_MT6779_AUDSYS=m
# CONFIG_COMMON_CLK_MT6797 is not set
# CONFIG_COMMON_CLK_MT7622 is not set
CONFIG_COMMON_CLK_MT7629=y
CONFIG_COMMON_CLK_MT7629_ETHSYS=y
CONFIG_COMMON_CLK_MT7629_HIFSYS=y
# CONFIG_COMMON_CLK_MT7986 is not set
CONFIG_COMMON_CLK_MT8135=y
CONFIG_COMMON_CLK_MT8167=y
CONFIG_COMMON_CLK_MT8167_AUDSYS=y
# CONFIG_COMMON_CLK_MT8167_IMGSYS is not set
# CONFIG_COMMON_CLK_MT8167_MFGCFG is not set
CONFIG_COMMON_CLK_MT8167_MMSYS=y
CONFIG_COMMON_CLK_MT8167_VDECSYS=y
# CONFIG_COMMON_CLK_MT8173 is not set
CONFIG_COMMON_CLK_MT8183=y
# CONFIG_COMMON_CLK_MT8183_AUDIOSYS is not set
CONFIG_COMMON_CLK_MT8183_CAMSYS=y
# CONFIG_COMMON_CLK_MT8183_IMGSYS is not set
CONFIG_COMMON_CLK_MT8183_IPU_CORE0=y
# CONFIG_COMMON_CLK_MT8183_IPU_CORE1 is not set
CONFIG_COMMON_CLK_MT8183_IPU_ADL=y
CONFIG_COMMON_CLK_MT8183_IPU_CONN=y
CONFIG_COMMON_CLK_MT8183_MFGCFG=y
CONFIG_COMMON_CLK_MT8183_MMSYS=y
# CONFIG_COMMON_CLK_MT8183_VDECSYS is not set
CONFIG_COMMON_CLK_MT8183_VENCSYS=y
# CONFIG_COMMON_CLK_MT8186 is not set
CONFIG_COMMON_CLK_MT8192=y
# CONFIG_COMMON_CLK_MT8192_AUDSYS is not set
CONFIG_COMMON_CLK_MT8192_CAMSYS=y
CONFIG_COMMON_CLK_MT8192_IMGSYS=y
CONFIG_COMMON_CLK_MT8192_IMP_IIC_WRAP=y
# CONFIG_COMMON_CLK_MT8192_IPESYS is not set
# CONFIG_COMMON_CLK_MT8192_MDPSYS is not set
CONFIG_COMMON_CLK_MT8192_MFGCFG=y
CONFIG_COMMON_CLK_MT8192_MMSYS=y
CONFIG_COMMON_CLK_MT8192_MSDC=y
CONFIG_COMMON_CLK_MT8192_SCP_ADSP=y
CONFIG_COMMON_CLK_MT8192_VDECSYS=y
CONFIG_COMMON_CLK_MT8192_VENCSYS=y
CONFIG_COMMON_CLK_MT8195=y
# CONFIG_COMMON_CLK_MT8516 is not set
# end of Clock driver for MediaTek SoC

#
# Clock support for Amlogic platforms
#
# CONFIG_COMMON_CLK_AXG_AUDIO is not set
# end of Clock support for Amlogic platforms

CONFIG_MSTAR_MSC313_MPLL=y
CONFIG_MCHP_CLK_MPFS=y
CONFIG_COMMON_CLK_PISTACHIO=y
# CONFIG_COMMON_CLK_QCOM is not set
# CONFIG_CLK_MT7621 is not set
# CONFIG_CLK_RENESAS is not set
CONFIG_COMMON_CLK_SAMSUNG=y
# CONFIG_S3C64XX_COMMON_CLK is not set
# CONFIG_S5PV210_COMMON_CLK is not set
CONFIG_EXYNOS_3250_COMMON_CLK=y
# CONFIG_EXYNOS_4_COMMON_CLK is not set
# CONFIG_EXYNOS_5250_COMMON_CLK is not set
CONFIG_EXYNOS_5260_COMMON_CLK=y
# CONFIG_EXYNOS_5410_COMMON_CLK is not set
# CONFIG_EXYNOS_5420_COMMON_CLK is not set
CONFIG_EXYNOS_ARM64_COMMON_CLK=y
CONFIG_EXYNOS_AUDSS_CLK_CON=m
CONFIG_EXYNOS_CLKOUT=y
# CONFIG_S3C2410_COMMON_CLK is not set
CONFIG_S3C2412_COMMON_CLK=y
# CONFIG_S3C2443_COMMON_CLK is not set
# CONFIG_TESLA_FSD_COMMON_CLK is not set
# CONFIG_CLK_SIFIVE is not set
CONFIG_CLK_INTEL_SOCFPGA=y
# CONFIG_CLK_INTEL_SOCFPGA32 is not set
CONFIG_CLK_INTEL_SOCFPGA64=y
CONFIG_SPRD_COMMON_CLK=y
# CONFIG_SPRD_SC9860_CLK is not set
CONFIG_SPRD_SC9863A_CLK=y
CONFIG_CLK_STARFIVE_JH7100=y
# CONFIG_CLK_STARFIVE_JH7100_AUDIO is not set
CONFIG_CLK_SUNXI=y
# CONFIG_CLK_SUNXI_CLOCKS is not set
# CONFIG_CLK_SUNXI_PRCM_SUN6I is not set
# CONFIG_CLK_SUNXI_PRCM_SUN8I is not set
# CONFIG_CLK_SUNXI_PRCM_SUN9I is not set
# CONFIG_SUNXI_CCU is not set
CONFIG_COMMON_CLK_TI_ADPLL=m
# CONFIG_CLK_UNIPHIER is not set
CONFIG_COMMON_CLK_VISCONTI=y
# CONFIG_CLK_LGM_CGU is not set
# CONFIG_XILINX_VCU is not set
CONFIG_COMMON_CLK_ZYNQMP=y
# CONFIG_CLK_KUNIT_TEST is not set
CONFIG_CLK_GATE_KUNIT_TEST=m
CONFIG_HWSPINLOCK=y
# CONFIG_HWSPINLOCK_OMAP is not set
CONFIG_HWSPINLOCK_QCOM=m
CONFIG_HWSPINLOCK_SPRD=y
# CONFIG_HWSPINLOCK_STM32 is not set
CONFIG_HWSPINLOCK_SUN6I=m
CONFIG_HSEM_U8500=y

#
# Clock Source drivers
#
CONFIG_TIMER_OF=y
CONFIG_TIMER_PROBE=y
CONFIG_CLKSRC_MMIO=y
# CONFIG_BCM2835_TIMER is not set
# CONFIG_BCM_KONA_TIMER is not set
# CONFIG_DAVINCI_TIMER is not set
CONFIG_DIGICOLOR_TIMER=y
# CONFIG_OMAP_DM_TIMER is not set
# CONFIG_DW_APB_TIMER is not set
CONFIG_FTTMR010_TIMER=y
# CONFIG_IXP4XX_TIMER is not set
# CONFIG_MESON6_TIMER is not set
# CONFIG_OWL_TIMER is not set
# CONFIG_RDA_TIMER is not set
# CONFIG_SUN4I_TIMER is not set
# CONFIG_SUN5I_HSTIMER is not set
CONFIG_TEGRA_TIMER=y
# CONFIG_VT8500_TIMER is not set
# CONFIG_NPCM7XX_TIMER is not set
# CONFIG_CADENCE_TTC_TIMER is not set
# CONFIG_ASM9260_TIMER is not set
# CONFIG_CLKSRC_DBX500_PRCMU is not set
# CONFIG_CLPS711X_TIMER is not set
# CONFIG_MXS_TIMER is not set
# CONFIG_NSPIRE_TIMER is not set
CONFIG_INTEGRATOR_AP_TIMER=y
# CONFIG_CLKSRC_PISTACHIO is not set
# CONFIG_CLKSRC_TI_32K is not set
CONFIG_CLKSRC_STM32_LP=y
# CONFIG_CLKSRC_MPS2 is not set
CONFIG_ARC_TIMERS=y
# CONFIG_ARC_TIMERS_64BIT is not set
CONFIG_ARM_TIMER_SP804=y
# CONFIG_ARMV7M_SYSTICK is not set
CONFIG_ATMEL_PIT=y
CONFIG_ATMEL_ST=y
CONFIG_CLKSRC_SAMSUNG_PWM=y
# CONFIG_FSL_FTM_TIMER is not set
# CONFIG_OXNAS_RPS_TIMER is not set
CONFIG_MTK_TIMER=y
# CONFIG_SPRD_TIMER is not set
# CONFIG_CLKSRC_JCORE_PIT is not set
CONFIG_SH_TIMER_CMT=y
CONFIG_SH_TIMER_MTU2=y
# CONFIG_RENESAS_OSTM is not set
# CONFIG_SH_TIMER_TMU is not set
CONFIG_EM_TIMER_STI=y
CONFIG_CLKSRC_VERSATILE=y
CONFIG_CLKSRC_PXA=y
# CONFIG_TIMER_IMX_SYS_CTR is not set
# CONFIG_CLKSRC_ST_LPC is not set
# CONFIG_GXP_TIMER is not set
CONFIG_MSC313E_TIMER=y
CONFIG_INGENIC_TIMER=y
# CONFIG_INGENIC_SYSOST is not set
CONFIG_INGENIC_OST=y
CONFIG_MICROCHIP_PIT64B=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
CONFIG_IMX_MBOX=m
# CONFIG_PLATFORM_MHU is not set
# CONFIG_ARMADA_37XX_RWTM_MBOX is not set
# CONFIG_ROCKCHIP_MBOX is not set
# CONFIG_PCC is not set
CONFIG_ALTERA_MBOX=m
# CONFIG_HI3660_MBOX is not set
# CONFIG_HI6220_MBOX is not set
# CONFIG_MAILBOX_TEST is not set
# CONFIG_POLARFIRE_SOC_MAILBOX is not set
# CONFIG_QCOM_APCS_IPC is not set
# CONFIG_BCM_PDC_MBOX is not set
CONFIG_STM32_IPCC=m
# CONFIG_MTK_ADSP_MBOX is not set
CONFIG_MTK_CMDQ_MBOX=y
CONFIG_SUN6I_MSGBOX=y
# CONFIG_SPRD_MBOX is not set
CONFIG_QCOM_IPCC=m
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
CONFIG_IOMMU_IO_PGTABLE=y
CONFIG_IOMMU_IO_PGTABLE_LPAE=y
CONFIG_IOMMU_IO_PGTABLE_LPAE_SELFTEST=y
CONFIG_IOMMU_IO_PGTABLE_ARMV7S=y
# CONFIG_IOMMU_IO_PGTABLE_ARMV7S_SELFTEST is not set
# end of Generic IOMMU Pagetable Support

# CONFIG_IOMMU_DEBUGFS is not set
CONFIG_IOMMU_DEFAULT_DMA_STRICT=y
# CONFIG_IOMMU_DEFAULT_DMA_LAZY is not set
# CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
CONFIG_OF_IOMMU=y
CONFIG_OMAP_IOMMU=y
# CONFIG_OMAP_IOMMU_DEBUG is not set
CONFIG_ROCKCHIP_IOMMU=y
CONFIG_SUN50I_IOMMU=y
# CONFIG_EXYNOS_IOMMU is not set
CONFIG_IPMMU_VMSA=y
CONFIG_APPLE_DART=y
# CONFIG_ARM_SMMU is not set
# CONFIG_S390_CCW_IOMMU is not set
# CONFIG_S390_AP_IOMMU is not set
CONFIG_MTK_IOMMU=y
CONFIG_QCOM_IOMMU=y
CONFIG_SPRD_IOMMU=m

#
# Remoteproc drivers
#
CONFIG_REMOTEPROC=y
# CONFIG_REMOTEPROC_CDEV is not set
# CONFIG_INGENIC_VPU_RPROC is not set
# CONFIG_MTK_SCP is not set
CONFIG_MESON_MX_AO_ARC_REMOTEPROC=m
# CONFIG_RCAR_REMOTEPROC is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
CONFIG_RPMSG=m
# CONFIG_RPMSG_CTRL is not set
# CONFIG_RPMSG_NS is not set
CONFIG_RPMSG_QCOM_GLINK=m
# CONFIG_RPMSG_QCOM_GLINK_RPM is not set
CONFIG_RPMSG_QCOM_GLINK_SMEM=m
CONFIG_RPMSG_QCOM_SMD=m
# CONFIG_RPMSG_VIRTIO is not set
# end of Rpmsg drivers

# CONFIG_SOUNDWIRE is not set

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#
CONFIG_MESON_CANVAS=m
# CONFIG_MESON_CLK_MEASURE is not set
# CONFIG_MESON_GX_SOCINFO is not set
CONFIG_MESON_MX_SOCINFO=y
# end of Amlogic SoC drivers

#
# Apple SoC drivers
#
CONFIG_APPLE_RTKIT=m
CONFIG_APPLE_SART=m
# end of Apple SoC drivers

#
# ASPEED SoC drivers
#
CONFIG_ASPEED_LPC_CTRL=m
CONFIG_ASPEED_LPC_SNOOP=y
CONFIG_ASPEED_UART_ROUTING=m
CONFIG_ASPEED_P2A_CTRL=y
# CONFIG_ASPEED_SOCINFO is not set
# end of ASPEED SoC drivers

# CONFIG_AT91_SOC_ID is not set
CONFIG_AT91_SOC_SFR=m

#
# Broadcom SoC drivers
#
# CONFIG_BCM2835_POWER is not set
CONFIG_SOC_BCM63XX=y
# CONFIG_SOC_BRCMSTB is not set
# CONFIG_BCM63XX_POWER is not set
# CONFIG_BCM_PMB is not set
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# CONFIG_QUICC_ENGINE is not set
CONFIG_FSL_GUTS=y
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
CONFIG_IXP4XX_QMGR=y
CONFIG_IXP4XX_NPE=y
# end of IXP4xx SoC drivers

#
# Enable LiteX SoC Builder specific drivers
#
CONFIG_LITEX=y
CONFIG_LITEX_SOC_CONTROLLER=m
# end of Enable LiteX SoC Builder specific drivers

#
# MediaTek SoC drivers
#
CONFIG_MTK_CMDQ=y
# CONFIG_MTK_DEVAPC is not set
CONFIG_MTK_INFRACFG=y
# CONFIG_MTK_PMIC_WRAP is not set
# CONFIG_MTK_SCPSYS is not set
CONFIG_MTK_MMSYS=y
# end of MediaTek SoC drivers

#
# Qualcomm SoC drivers
#
# CONFIG_QCOM_COMMAND_DB is not set
CONFIG_QCOM_GENI_SE=m
CONFIG_QCOM_GSBI=m
CONFIG_QCOM_LLCC=m
CONFIG_QCOM_RPMH=y
CONFIG_QCOM_SMEM=y
CONFIG_QCOM_SMD_RPM=m
CONFIG_QCOM_SMEM_STATE=y
CONFIG_QCOM_SMP2P=y
CONFIG_QCOM_SMSM=m
CONFIG_QCOM_SOCINFO=m
CONFIG_QCOM_SPM=m
CONFIG_QCOM_STATS=y
# CONFIG_QCOM_WCNSS_CTRL is not set
CONFIG_QCOM_ICC_BWMON=y
# end of Qualcomm SoC drivers

# CONFIG_SOC_RENESAS is not set
# CONFIG_ROCKCHIP_GRF is not set
# CONFIG_ROCKCHIP_IODOMAIN is not set
CONFIG_SOC_SAMSUNG=y
CONFIG_EXYNOS_ASV_ARM=y
CONFIG_EXYNOS_CHIPID=m
CONFIG_EXYNOS_USI=y
# CONFIG_EXYNOS_PM_DOMAINS is not set
CONFIG_EXYNOS_REGULATOR_COUPLER=y
CONFIG_SOC_TEGRA20_VOLTAGE_COUPLER=y
CONFIG_SOC_TEGRA30_VOLTAGE_COUPLER=y
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
CONFIG_DEVFREQ_GOV_PERFORMANCE=m
CONFIG_DEVFREQ_GOV_POWERSAVE=y
CONFIG_DEVFREQ_GOV_USERSPACE=m
CONFIG_DEVFREQ_GOV_PASSIVE=y

#
# DEVFREQ Drivers
#
CONFIG_ARM_EXYNOS_BUS_DEVFREQ=y
CONFIG_ARM_IMX_BUS_DEVFREQ=m
CONFIG_ARM_TEGRA_DEVFREQ=m
CONFIG_ARM_MEDIATEK_CCI_DEVFREQ=y
# CONFIG_ARM_SUN8I_A33_MBUS_DEVFREQ is not set
CONFIG_PM_DEVFREQ_EVENT=y
CONFIG_DEVFREQ_EVENT_EXYNOS_NOCP=y
CONFIG_DEVFREQ_EVENT_EXYNOS_PPMU=y
CONFIG_DEVFREQ_EVENT_ROCKCHIP_DFI=y
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
# CONFIG_EXTCON_FSA9480 is not set
# CONFIG_EXTCON_GPIO is not set
CONFIG_EXTCON_INTEL_INT3496=m
CONFIG_EXTCON_MAX14577=m
# CONFIG_EXTCON_MAX3355 is not set
CONFIG_EXTCON_MAX77693=m
CONFIG_EXTCON_MAX77843=m
CONFIG_EXTCON_PTN5150=y
CONFIG_EXTCON_QCOM_SPMI_MISC=y
CONFIG_EXTCON_RT8973A=m
CONFIG_EXTCON_SM5502=m
# CONFIG_EXTCON_USB_GPIO is not set
# CONFIG_EXTCON_USBC_TUSB320 is not set
CONFIG_MEMORY=y
CONFIG_DDR=y
# CONFIG_ATMEL_SDRAMC is not set
# CONFIG_ATMEL_EBI is not set
CONFIG_BRCMSTB_DPFE=y
CONFIG_BT1_L2_CTL=y
# CONFIG_TI_AEMIF is not set
# CONFIG_TI_EMIF is not set
# CONFIG_OMAP_GPMC is not set
# CONFIG_FPGA_DFL_EMIF is not set
# CONFIG_MVEBU_DEVBUS is not set
CONFIG_FSL_CORENET_CF=y
# CONFIG_FSL_IFC is not set
# CONFIG_JZ4780_NEMC is not set
CONFIG_MTK_SMI=y
# CONFIG_DA8XX_DDRCTL is not set
# CONFIG_RENESAS_RPCIF is not set
CONFIG_STM32_FMC2_EBI=y
CONFIG_SAMSUNG_MC=y
CONFIG_EXYNOS5422_DMC=m
# CONFIG_EXYNOS_SROM is not set
CONFIG_TEGRA_MC=y
CONFIG_TEGRA20_EMC=y
CONFIG_TEGRA30_EMC=m
CONFIG_TEGRA124_EMC=m
# CONFIG_TEGRA210_EMC is not set
# CONFIG_IIO is not set
# CONFIG_NTB is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
CONFIG_PWM_DEBUG=y
# CONFIG_PWM_ATMEL is not set
# CONFIG_PWM_ATMEL_TCB is not set
CONFIG_PWM_BCM_IPROC=y
CONFIG_PWM_BCM_KONA=m
CONFIG_PWM_BCM2835=y
# CONFIG_PWM_BERLIN is not set
CONFIG_PWM_BRCMSTB=y
# CONFIG_PWM_CLK is not set
# CONFIG_PWM_CLPS711X is not set
# CONFIG_PWM_DWC is not set
CONFIG_PWM_EP93XX=m
# CONFIG_PWM_FSL_FTM is not set
# CONFIG_PWM_HIBVT is not set
CONFIG_PWM_IMG=m
# CONFIG_PWM_IMX1 is not set
CONFIG_PWM_IMX27=y
CONFIG_PWM_IMX_TPM=y
CONFIG_PWM_INTEL_LGM=m
CONFIG_PWM_IQS620A=y
# CONFIG_PWM_JZ4740 is not set
CONFIG_PWM_KEEMBAY=y
# CONFIG_PWM_LPC18XX_SCT is not set
# CONFIG_PWM_LPC32XX is not set
CONFIG_PWM_LPSS=y
# CONFIG_PWM_LPSS_PCI is not set
CONFIG_PWM_LPSS_PLATFORM=y
CONFIG_PWM_MESON=y
# CONFIG_PWM_MTK_DISP is not set
# CONFIG_PWM_MEDIATEK is not set
# CONFIG_PWM_MXS is not set
# CONFIG_PWM_NTXEC is not set
# CONFIG_PWM_OMAP_DMTIMER is not set
CONFIG_PWM_PCA9685=m
CONFIG_PWM_PXA=y
# CONFIG_PWM_RASPBERRYPI_POE is not set
CONFIG_PWM_RCAR=y
CONFIG_PWM_RENESAS_TPU=y
CONFIG_PWM_ROCKCHIP=m
CONFIG_PWM_SAMSUNG=y
# CONFIG_PWM_SIFIVE is not set
# CONFIG_PWM_SL28CPLD is not set
# CONFIG_PWM_SPEAR is not set
CONFIG_PWM_SPRD=y
# CONFIG_PWM_STI is not set
# CONFIG_PWM_STM32 is not set
CONFIG_PWM_STM32_LP=y
# CONFIG_PWM_SUN4I is not set
# CONFIG_PWM_SUNPLUS is not set
CONFIG_PWM_TEGRA=y
# CONFIG_PWM_TIECAP is not set
# CONFIG_PWM_TIEHRPWM is not set
CONFIG_PWM_VISCONTI=m
CONFIG_PWM_VT8500=m
# CONFIG_PWM_XILINX is not set

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
# CONFIG_RENESAS_RZG2L_IRQC is not set
# CONFIG_SL28CPLD_INTC is not set
# CONFIG_TS4800_IRQ is not set
# CONFIG_XILINX_INTC is not set
CONFIG_INGENIC_TCU_IRQ=y
# CONFIG_IRQ_UNIPHIER_AIDET is not set
# CONFIG_MESON_IRQ_GPIO is not set
# CONFIG_IMX_IRQSTEER is not set
# CONFIG_IMX_INTMUX is not set
CONFIG_EXYNOS_IRQ_COMBINER=y
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
CONFIG_BOARD_TPCI200=m
CONFIG_SERIAL_IPOCTAL=y
CONFIG_RESET_CONTROLLER=y
CONFIG_RESET_A10SR=m
# CONFIG_RESET_ATH79 is not set
CONFIG_RESET_AXS10X=y
# CONFIG_RESET_BCM6345 is not set
# CONFIG_RESET_BERLIN is not set
CONFIG_RESET_BRCMSTB=y
# CONFIG_RESET_BRCMSTB_RESCAL is not set
# CONFIG_RESET_HSDK is not set
CONFIG_RESET_IMX7=y
# CONFIG_RESET_INTEL_GW is not set
# CONFIG_RESET_K210 is not set
CONFIG_RESET_LANTIQ=y
# CONFIG_RESET_LPC18XX is not set
# CONFIG_RESET_MCHP_SPARX5 is not set
# CONFIG_RESET_MESON is not set
CONFIG_RESET_MESON_AUDIO_ARB=m
CONFIG_RESET_NPCM=y
# CONFIG_RESET_PISTACHIO is not set
CONFIG_RESET_QCOM_AOSS=m
# CONFIG_RESET_QCOM_PDC is not set
CONFIG_RESET_RASPBERRYPI=m
CONFIG_RESET_RZG2L_USBPHY_CTRL=y
CONFIG_RESET_SCMI=m
CONFIG_RESET_SIMPLE=y
CONFIG_RESET_SOCFPGA=y
# CONFIG_RESET_STARFIVE_JH7100 is not set
CONFIG_RESET_SUNPLUS=y
# CONFIG_RESET_SUNXI is not set
CONFIG_RESET_TI_SCI=m
CONFIG_RESET_TI_SYSCON=y
CONFIG_RESET_TI_TPS380X=y
CONFIG_RESET_TN48M_CPLD=m
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
CONFIG_PHY_PISTACHIO_USB=y
# CONFIG_PHY_XGENE is not set
# CONFIG_USB_LGM_PHY is not set
# CONFIG_PHY_CAN_TRANSCEIVER is not set
CONFIG_PHY_SUN4I_USB=m
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
CONFIG_PHY_BCM63XX_USBH=y
# CONFIG_PHY_CYGNUS_PCIE is not set
# CONFIG_PHY_BCM_SR_USB is not set
CONFIG_BCM_KONA_USB2_PHY=m
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
# CONFIG_PHY_MIXEL_LVDS_PHY is not set
# CONFIG_PHY_MIXEL_MIPI_DPHY is not set
# CONFIG_PHY_FSL_IMX8M_PCIE is not set
# CONFIG_PHY_FSL_LYNX_28G is not set
CONFIG_PHY_HI6220_USB=m
CONFIG_PHY_HI3660_USB=y
CONFIG_PHY_HI3670_USB=m
# CONFIG_PHY_HI3670_PCIE is not set
CONFIG_PHY_HISTB_COMBPHY=m
CONFIG_PHY_HISI_INNO_USB2=m
CONFIG_PHY_INGENIC_USB=y
# CONFIG_PHY_LANTIQ_VRX200_PCIE is not set
# CONFIG_PHY_LANTIQ_RCU_USB2 is not set
# CONFIG_ARMADA375_USBCLUSTER_PHY is not set
# CONFIG_PHY_BERLIN_SATA is not set
# CONFIG_PHY_BERLIN_USB is not set
CONFIG_PHY_MVEBU_A3700_UTMI=y
# CONFIG_PHY_MVEBU_A38X_COMPHY is not set
# CONFIG_PHY_MVEBU_CP110_UTMI is not set
CONFIG_PHY_PXA_28NM_HSIC=m
# CONFIG_PHY_PXA_28NM_USB2 is not set
# CONFIG_PHY_PXA_USB is not set
CONFIG_PHY_MMP3_USB=m
CONFIG_PHY_MMP3_HSIC=y
# CONFIG_PHY_MTK_PCIE is not set
# CONFIG_PHY_MTK_TPHY is not set
# CONFIG_PHY_MTK_UFS is not set
# CONFIG_PHY_MTK_XSPHY is not set
# CONFIG_PHY_MTK_HDMI is not set
# CONFIG_PHY_MTK_MIPI_DSI is not set
# CONFIG_PHY_MTK_DP is not set
# CONFIG_PHY_SPARX5_SERDES is not set
# CONFIG_PHY_LAN966X_SERDES is not set
# CONFIG_PHY_MAPPHONE_MDM6600 is not set
# CONFIG_PHY_OCELOT_SERDES is not set
CONFIG_PHY_ATH79_USB=y
# CONFIG_PHY_QCOM_EDP is not set
# CONFIG_PHY_QCOM_IPQ4019_USB is not set
# CONFIG_PHY_QCOM_PCIE2 is not set
# CONFIG_PHY_QCOM_QMP is not set
# CONFIG_PHY_QCOM_QUSB2 is not set
CONFIG_PHY_QCOM_USB_HS=m
# CONFIG_PHY_QCOM_USB_SNPS_FEMTO_V2 is not set
CONFIG_PHY_QCOM_USB_HSIC=m
# CONFIG_PHY_QCOM_USB_HS_28NM is not set
# CONFIG_PHY_QCOM_USB_SS is not set
# CONFIG_PHY_QCOM_IPQ806X_USB is not set
# CONFIG_PHY_MT7621_PCI is not set
# CONFIG_PHY_RALINK_USB is not set
CONFIG_PHY_RCAR_GEN3_USB3=y
CONFIG_PHY_ROCKCHIP_DPHY_RX0=m
# CONFIG_PHY_ROCKCHIP_INNO_HDMI is not set
# CONFIG_PHY_ROCKCHIP_INNO_USB2 is not set
# CONFIG_PHY_ROCKCHIP_INNO_CSIDPHY is not set
# CONFIG_PHY_ROCKCHIP_INNO_DSIDPHY is not set
CONFIG_PHY_ROCKCHIP_PCIE=y
# CONFIG_PHY_ROCKCHIP_TYPEC is not set
# CONFIG_PHY_EXYNOS_DP_VIDEO is not set
CONFIG_PHY_EXYNOS_MIPI_VIDEO=y
# CONFIG_PHY_EXYNOS_PCIE is not set
# CONFIG_PHY_SAMSUNG_UFS is not set
# CONFIG_PHY_SAMSUNG_USB2 is not set
CONFIG_PHY_EXYNOS5_USBDRD=y
# CONFIG_PHY_UNIPHIER_USB2 is not set
# CONFIG_PHY_UNIPHIER_USB3 is not set
# CONFIG_PHY_UNIPHIER_PCIE is not set
CONFIG_PHY_UNIPHIER_AHCI=m
CONFIG_PHY_ST_SPEAR1310_MIPHY=y
# CONFIG_PHY_ST_SPEAR1340_MIPHY is not set
CONFIG_PHY_STIH407_USB=y
# CONFIG_PHY_STM32_USBPHYC is not set
CONFIG_PHY_TEGRA194_P2U=y
CONFIG_PHY_DA8XX_USB=y
CONFIG_PHY_DM816X_USB=y
# CONFIG_PHY_AM654_SERDES is not set
# CONFIG_PHY_J721E_WIZ is not set
CONFIG_OMAP_CONTROL_PHY=y
# CONFIG_TI_PIPE3 is not set
# CONFIG_PHY_TUSB1210 is not set
# CONFIG_PHY_INTEL_KEEMBAY_EMMC is not set
CONFIG_PHY_INTEL_KEEMBAY_USB=m
# CONFIG_PHY_INTEL_LGM_COMBO is not set
CONFIG_PHY_INTEL_LGM_EMMC=y
# CONFIG_PHY_INTEL_THUNDERBAY_EMMC is not set
CONFIG_PHY_XILINX_ZYNQMP=y
# end of PHY Subsystem

CONFIG_POWERCAP=y
# CONFIG_DTPM is not set
CONFIG_MCB=y
CONFIG_MCB_PCI=y
# CONFIG_MCB_LPC is not set

#
# Performance monitor support
#
CONFIG_ARM_CCN=m
# CONFIG_ARM_CMN is not set
CONFIG_ARM_SMMU_V3_PMU=y
CONFIG_FSL_IMX8_DDR_PMU=y
# CONFIG_XGENE_PMU is not set
# CONFIG_ARM_DMC620_PMU is not set
# CONFIG_MARVELL_CN10K_TAD_PMU is not set
CONFIG_HNS3_PMU=m
CONFIG_MARVELL_CN10K_DDR_PMU=m
# end of Performance monitor support

CONFIG_RAS=y
CONFIG_USB4=m
# CONFIG_USB4_DEBUGFS_WRITE is not set
# CONFIG_USB4_KUNIT_TEST is not set
# CONFIG_USB4_DMA_TEST is not set

#
# Android
#
CONFIG_ANDROID_BINDER_IPC=y
CONFIG_ANDROID_BINDERFS=y
CONFIG_ANDROID_BINDER_DEVICES="binder,hwbinder,vndbinder"
CONFIG_ANDROID_BINDER_IPC_SELFTEST=y
# end of Android

# CONFIG_DAX is not set
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y
CONFIG_NVMEM_IMX_IIM=m
# CONFIG_NVMEM_IMX_OCOTP is not set
# CONFIG_JZ4780_EFUSE is not set
CONFIG_NVMEM_LPC18XX_EEPROM=m
CONFIG_NVMEM_LPC18XX_OTP=m
CONFIG_NVMEM_MXS_OCOTP=y
# CONFIG_MTK_EFUSE is not set
# CONFIG_MICROCHIP_OTPC is not set
CONFIG_NVMEM_NINTENDO_OTP=m
# CONFIG_QCOM_QFPROM is not set
# CONFIG_NVMEM_SPMI_SDAM is not set
# CONFIG_ROCKCHIP_EFUSE is not set
# CONFIG_ROCKCHIP_OTP is not set
CONFIG_NVMEM_BCM_OCOTP=y
CONFIG_NVMEM_STM32_ROMEM=y
# CONFIG_UNIPHIER_EFUSE is not set
# CONFIG_NVMEM_VF610_OCOTP is not set
# CONFIG_MESON_MX_EFUSE is not set
CONFIG_NVMEM_SNVS_LPGPR=m
# CONFIG_SC27XX_EFUSE is not set
# CONFIG_SPRD_EFUSE is not set
CONFIG_NVMEM_RMEM=m
CONFIG_NVMEM_BRCM_NVRAM=y
CONFIG_NVMEM_LAYERSCAPE_SFP=y
CONFIG_NVMEM_SUNPLUS_OCOTP=m
CONFIG_NVMEM_APPLE_EFUSES=y

#
# HW tracing support
#
CONFIG_STM=m
CONFIG_STM_PROTO_BASIC=m
# CONFIG_STM_PROTO_SYS_T is not set
# CONFIG_STM_DUMMY is not set
CONFIG_STM_SOURCE_CONSOLE=m
CONFIG_STM_SOURCE_HEARTBEAT=m
CONFIG_STM_SOURCE_FTRACE=m
CONFIG_INTEL_TH=m
CONFIG_INTEL_TH_PCI=m
# CONFIG_INTEL_TH_ACPI is not set
CONFIG_INTEL_TH_GTH=m
CONFIG_INTEL_TH_STH=m
CONFIG_INTEL_TH_MSU=m
# CONFIG_INTEL_TH_PTI is not set
# CONFIG_INTEL_TH_DEBUG is not set
# end of HW tracing support

CONFIG_FPGA=y
# CONFIG_FPGA_MGR_SOCFPGA is not set
# CONFIG_FPGA_MGR_SOCFPGA_A10 is not set
CONFIG_ALTERA_PR_IP_CORE=m
# CONFIG_ALTERA_PR_IP_CORE_PLAT is not set
CONFIG_FPGA_MGR_ALTERA_PS_SPI=m
CONFIG_FPGA_MGR_ALTERA_CVP=y
# CONFIG_FPGA_MGR_ZYNQ_FPGA is not set
CONFIG_FPGA_MGR_XILINX_SPI=m
# CONFIG_FPGA_MGR_ICE40_SPI is not set
CONFIG_FPGA_MGR_MACHXO2_SPI=y
CONFIG_FPGA_BRIDGE=m
# CONFIG_ALTERA_FREEZE_BRIDGE is not set
CONFIG_XILINX_PR_DECOUPLER=m
CONFIG_FPGA_REGION=m
# CONFIG_OF_FPGA_REGION is not set
CONFIG_FPGA_DFL=m
CONFIG_FPGA_DFL_FME=m
CONFIG_FPGA_DFL_FME_MGR=m
# CONFIG_FPGA_DFL_FME_BRIDGE is not set
CONFIG_FPGA_DFL_FME_REGION=m
CONFIG_FPGA_DFL_AFU=m
# CONFIG_FPGA_DFL_NIOS_INTEL_PAC_N3000 is not set
# CONFIG_FPGA_DFL_PCI is not set
# CONFIG_FPGA_MGR_ZYNQMP_FPGA is not set
CONFIG_FPGA_MGR_VERSAL_FPGA=y
CONFIG_FPGA_MGR_MICROCHIP_SPI=y
# CONFIG_FSI is not set
CONFIG_TEE=m
CONFIG_PM_OPP=y
CONFIG_SIOX=m
CONFIG_SIOX_BUS_GPIO=m
CONFIG_SLIMBUS=y
CONFIG_SLIM_QCOM_CTRL=y
CONFIG_INTERCONNECT=y
CONFIG_INTERCONNECT_IMX=y
# CONFIG_INTERCONNECT_IMX8MM is not set
CONFIG_INTERCONNECT_IMX8MN=m
CONFIG_INTERCONNECT_IMX8MQ=m
# CONFIG_INTERCONNECT_IMX8MP is not set
CONFIG_INTERCONNECT_QCOM_OSM_L3=y
CONFIG_INTERCONNECT_SAMSUNG=y
# CONFIG_INTERCONNECT_EXYNOS is not set
CONFIG_COUNTER=y
CONFIG_104_QUAD_8=y
CONFIG_INTERRUPT_CNT=m
CONFIG_STM32_TIMER_CNT=m
CONFIG_STM32_LPTIMER_CNT=y
CONFIG_TI_EQEP=y
# CONFIG_FTM_QUADDEC is not set
# CONFIG_MICROCHIP_TCB_CAPTURE is not set
# CONFIG_INTEL_QEP is not set
CONFIG_MOST=y
CONFIG_MOST_USB_HDM=m
CONFIG_MOST_CDEV=y
# CONFIG_MOST_SND is not set
CONFIG_PECI=y
CONFIG_PECI_CPU=y
# CONFIG_PECI_ASPEED is not set
CONFIG_HTE=y
# end of Device Drivers

#
# File systems
#
CONFIG_VALIDATE_FS_PARSER=y
CONFIG_FS_IOMAP=y
# CONFIG_EXT2_FS is not set
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=m
CONFIG_EXT4_USE_FOR_EXT2=y
# CONFIG_EXT4_FS_POSIX_ACL is not set
CONFIG_EXT4_FS_SECURITY=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_EXT4_KUNIT_TESTS=m
CONFIG_JBD2=m
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=m
CONFIG_REISERFS_FS=y
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
CONFIG_REISERFS_FS_XATTR=y
# CONFIG_REISERFS_FS_POSIX_ACL is not set
CONFIG_REISERFS_FS_SECURITY=y
CONFIG_JFS_FS=m
# CONFIG_JFS_POSIX_ACL is not set
# CONFIG_JFS_SECURITY is not set
# CONFIG_JFS_DEBUG is not set
CONFIG_JFS_STATISTICS=y
CONFIG_XFS_FS=m
CONFIG_XFS_SUPPORT_V4=y
# CONFIG_XFS_QUOTA is not set
CONFIG_XFS_POSIX_ACL=y
CONFIG_XFS_RT=y
CONFIG_XFS_ONLINE_SCRUB=y
# CONFIG_XFS_ONLINE_REPAIR is not set
# CONFIG_XFS_WARN is not set
# CONFIG_XFS_DEBUG is not set
CONFIG_GFS2_FS=y
# CONFIG_BTRFS_FS is not set
CONFIG_NILFS2_FS=y
# CONFIG_F2FS_FS is not set
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=m
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
# CONFIG_FS_ENCRYPTION is not set
CONFIG_FS_VERITY=y
CONFIG_FS_VERITY_DEBUG=y
CONFIG_FS_VERITY_BUILTIN_SIGNATURES=y
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
# CONFIG_INOTIFY_USER is not set
# CONFIG_FANOTIFY is not set
CONFIG_QUOTA=y
CONFIG_PRINT_QUOTA_WARNING=y
CONFIG_QUOTA_DEBUG=y
CONFIG_QFMT_V1=m
# CONFIG_QFMT_V2 is not set
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=y
# CONFIG_CUSE is not set
# CONFIG_VIRTIO_FS is not set
CONFIG_OVERLAY_FS=m
CONFIG_OVERLAY_FS_REDIRECT_DIR=y
CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW=y
# CONFIG_OVERLAY_FS_INDEX is not set
# CONFIG_OVERLAY_FS_XINO_AUTO is not set
CONFIG_OVERLAY_FS_METACOPY=y

#
# Caches
#
CONFIG_NETFS_SUPPORT=m
# CONFIG_NETFS_STATS is not set
CONFIG_FSCACHE=m
# CONFIG_FSCACHE_STATS is not set
CONFIG_FSCACHE_DEBUG=y
CONFIG_CACHEFILES=m
CONFIG_CACHEFILES_DEBUG=y
CONFIG_CACHEFILES_ONDEMAND=y
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
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
# CONFIG_FAT_DEFAULT_UTF8 is not set
# CONFIG_FAT_KUNIT_TEST is not set
CONFIG_EXFAT_FS=m
CONFIG_EXFAT_DEFAULT_IOCHARSET="utf8"
CONFIG_NTFS_FS=m
# CONFIG_NTFS_DEBUG is not set
CONFIG_NTFS3_FS=m
CONFIG_NTFS3_64BIT_CLUSTER=y
CONFIG_NTFS3_LZX_XPRESS=y
CONFIG_NTFS3_FS_POSIX_ACL=y
# end of DOS/FAT/EXFAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_PROC_KCORE is not set
# CONFIG_PROC_SYSCTL is not set
# CONFIG_PROC_PAGE_MONITOR is not set
CONFIG_PROC_CHILDREN=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
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
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
# CONFIG_NLS_CODEPAGE_852 is not set
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
# CONFIG_NLS_CODEPAGE_861 is not set
CONFIG_NLS_CODEPAGE_862=m
# CONFIG_NLS_CODEPAGE_863 is not set
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=y
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=y
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
# CONFIG_NLS_CODEPAGE_932 is not set
CONFIG_NLS_CODEPAGE_949=m
# CONFIG_NLS_CODEPAGE_874 is not set
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=y
# CONFIG_NLS_ASCII is not set
# CONFIG_NLS_ISO8859_1 is not set
CONFIG_NLS_ISO8859_2=y
# CONFIG_NLS_ISO8859_3 is not set
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=y
# CONFIG_NLS_ISO8859_14 is not set
CONFIG_NLS_ISO8859_15=y
CONFIG_NLS_KOI8_R=m
# CONFIG_NLS_KOI8_U is not set
CONFIG_NLS_MAC_ROMAN=y
CONFIG_NLS_MAC_CELTIC=m
CONFIG_NLS_MAC_CENTEURO=y
# CONFIG_NLS_MAC_CROATIAN is not set
CONFIG_NLS_MAC_CYRILLIC=m
# CONFIG_NLS_MAC_GAELIC is not set
CONFIG_NLS_MAC_GREEK=y
CONFIG_NLS_MAC_ICELAND=m
CONFIG_NLS_MAC_INUIT=m
CONFIG_NLS_MAC_ROMANIAN=y
# CONFIG_NLS_MAC_TURKISH is not set
CONFIG_NLS_UTF8=m
# CONFIG_UNICODE is not set
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_KEYS_REQUEST_CACHE is not set
# CONFIG_PERSISTENT_KEYRINGS is not set
CONFIG_TRUSTED_KEYS=m
CONFIG_TRUSTED_KEYS_TEE=y
CONFIG_ENCRYPTED_KEYS=y
CONFIG_USER_DECRYPTED_DATA=y
# CONFIG_KEY_DH_OPERATIONS is not set
CONFIG_SECURITY_DMESG_RESTRICT=y
# CONFIG_SECURITY is not set
# CONFIG_SECURITYFS is not set
# CONFIG_STATIC_USERMODEHELPER is not set
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
# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
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
CONFIG_CRYPTO_FIPS=y
CONFIG_CRYPTO_FIPS_NAME="Linux Kernel Cryptographic API"
# CONFIG_CRYPTO_FIPS_CUSTOM_VERSION is not set
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
# CONFIG_CRYPTO_MANAGER_DISABLE_TESTS is not set
# CONFIG_CRYPTO_MANAGER_EXTRA_TESTS is not set
CONFIG_CRYPTO_GF128MUL=m
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=y
CONFIG_CRYPTO_CRYPTD=m
CONFIG_CRYPTO_AUTHENC=y
CONFIG_CRYPTO_TEST=y
CONFIG_CRYPTO_ENGINE=y

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=y
CONFIG_CRYPTO_DH_RFC7919_GROUPS=y
CONFIG_CRYPTO_ECC=m
CONFIG_CRYPTO_ECDH=m
CONFIG_CRYPTO_ECDSA=m
CONFIG_CRYPTO_ECRDSA=m
CONFIG_CRYPTO_SM2=m
CONFIG_CRYPTO_CURVE25519=m

#
# Authenticated Encryption with Associated Data
#
# CONFIG_CRYPTO_CCM is not set
CONFIG_CRYPTO_GCM=m
CONFIG_CRYPTO_CHACHA20POLY1305=y
# CONFIG_CRYPTO_AEGIS128 is not set
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=y

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CFB=m
CONFIG_CRYPTO_CTR=y
# CONFIG_CRYPTO_CTS is not set
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=m
# CONFIG_CRYPTO_OFB is not set
CONFIG_CRYPTO_PCBC=m
CONFIG_CRYPTO_XCTR=m
CONFIG_CRYPTO_XTS=m
CONFIG_CRYPTO_KEYWRAP=y
CONFIG_CRYPTO_NHPOLY1305=m
CONFIG_CRYPTO_ADIANTUM=m
CONFIG_CRYPTO_HCTR2=m
# CONFIG_CRYPTO_ESSIV is not set

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=m
CONFIG_CRYPTO_VMAC=y

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
# CONFIG_CRYPTO_CRC32 is not set
# CONFIG_CRYPTO_XXHASH is not set
CONFIG_CRYPTO_BLAKE2B=m
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRC64_ROCKSOFT=y
CONFIG_CRYPTO_GHASH=m
CONFIG_CRYPTO_POLYVAL=m
CONFIG_CRYPTO_POLY1305=y
# CONFIG_CRYPTO_MD4 is not set
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_RMD160=m
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=y
CONFIG_CRYPTO_SM3=m
CONFIG_CRYPTO_SM3_GENERIC=m
CONFIG_CRYPTO_STREEBOG=y
# CONFIG_CRYPTO_WP512 is not set

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_AES_TI=m
# CONFIG_CRYPTO_BLOWFISH is not set
CONFIG_CRYPTO_CAMELLIA=m
CONFIG_CRYPTO_CAST_COMMON=y
CONFIG_CRYPTO_CAST5=y
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_FCRYPT=m
CONFIG_CRYPTO_CHACHA20=y
CONFIG_CRYPTO_ARIA=m
CONFIG_CRYPTO_SERPENT=y
CONFIG_CRYPTO_SM4=m
CONFIG_CRYPTO_SM4_GENERIC=m
# CONFIG_CRYPTO_TWOFISH is not set

#
# Compression
#
# CONFIG_CRYPTO_DEFLATE is not set
CONFIG_CRYPTO_LZO=m
CONFIG_CRYPTO_842=y
CONFIG_CRYPTO_LZ4=m
# CONFIG_CRYPTO_LZ4HC is not set
# CONFIG_CRYPTO_ZSTD is not set

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
CONFIG_CRYPTO_HASH_INFO=y
CONFIG_CRYPTO_HW=y
# CONFIG_CRYPTO_DEV_ALLWINNER is not set
# CONFIG_CRYPTO_DEV_EXYNOS_RNG is not set
CONFIG_CRYPTO_DEV_S5P=y
CONFIG_CRYPTO_DEV_EXYNOS_HASH=y
CONFIG_CRYPTO_DEV_ATMEL_AUTHENC=y
CONFIG_CRYPTO_DEV_ATMEL_AES=y
CONFIG_CRYPTO_DEV_ATMEL_TDES=y
CONFIG_CRYPTO_DEV_ATMEL_SHA=y
CONFIG_CRYPTO_DEV_ATMEL_I2C=m
# CONFIG_CRYPTO_DEV_ATMEL_ECC is not set
CONFIG_CRYPTO_DEV_ATMEL_SHA204A=m
CONFIG_CRYPTO_DEV_QAT=y
# CONFIG_CRYPTO_DEV_QAT_DH895xCC is not set
# CONFIG_CRYPTO_DEV_QAT_C3XXX is not set
# CONFIG_CRYPTO_DEV_QAT_C62X is not set
# CONFIG_CRYPTO_DEV_QAT_4XXX is not set
CONFIG_CRYPTO_DEV_QAT_DH895xCCVF=m
CONFIG_CRYPTO_DEV_QAT_C3XXXVF=m
CONFIG_CRYPTO_DEV_QAT_C62XVF=y
CONFIG_CRYPTO_DEV_CPT=y
CONFIG_CAVIUM_CPT=y
CONFIG_CRYPTO_DEV_NITROX=m
CONFIG_CRYPTO_DEV_NITROX_CNN55XX=m
CONFIG_CRYPTO_DEV_MARVELL=m
CONFIG_CRYPTO_DEV_OCTEONTX_CPT=m
CONFIG_CRYPTO_DEV_CAVIUM_ZIP=m
# CONFIG_CRYPTO_DEV_QCE is not set
# CONFIG_CRYPTO_DEV_QCOM_RNG is not set
# CONFIG_CRYPTO_DEV_IMGTEC_HASH is not set
CONFIG_CRYPTO_DEV_ZYNQMP_AES=y
CONFIG_CRYPTO_DEV_ZYNQMP_SHA3=y
CONFIG_CRYPTO_DEV_VIRTIO=y
CONFIG_CRYPTO_DEV_SAFEXCEL=y
# CONFIG_CRYPTO_DEV_CCREE is not set
CONFIG_CRYPTO_DEV_HISI_SEC=m
CONFIG_CRYPTO_DEV_HISI_SEC2=m
CONFIG_CRYPTO_DEV_HISI_QM=m
CONFIG_CRYPTO_DEV_HISI_ZIP=m
CONFIG_CRYPTO_DEV_HISI_HPRE=m
CONFIG_CRYPTO_DEV_AMLOGIC_GXL=y
# CONFIG_CRYPTO_DEV_AMLOGIC_GXL_DEBUG is not set
CONFIG_CRYPTO_DEV_SA2UL=m
# CONFIG_CRYPTO_DEV_KEEMBAY_OCS_AES_SM4 is not set
# CONFIG_CRYPTO_DEV_KEEMBAY_OCS_ECC is not set
# CONFIG_CRYPTO_DEV_KEEMBAY_OCS_HCU is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
CONFIG_PKCS8_PRIVATE_KEY_PARSER=m
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_PKCS7_TEST_KEY is not set
# CONFIG_SIGNED_PE_FILE_VERIFICATION is not set
# CONFIG_FIPS_SIGNATURE_SELFTEST is not set

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
CONFIG_LINEAR_RANGES=y
# CONFIG_PACKING is not set
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_CORDIC=m
CONFIG_PRIME_NUMBERS=m
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
CONFIG_CRYPTO_LIB_CURVE25519_GENERIC=m
# CONFIG_CRYPTO_LIB_CURVE25519 is not set
CONFIG_CRYPTO_LIB_DES=y
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=1
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=y
CONFIG_CRYPTO_LIB_POLY1305=y
CONFIG_CRYPTO_LIB_CHACHA20POLY1305=y
CONFIG_CRYPTO_LIB_SHA1=y
CONFIG_CRYPTO_LIB_SHA256=y
# end of Crypto library routines

CONFIG_LIB_MEMNEQ=y
CONFIG_CRC_CCITT=m
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC64_ROCKSOFT=y
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
CONFIG_CRC32_SELFTEST=m
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
CONFIG_CRC64=y
# CONFIG_CRC4 is not set
CONFIG_CRC7=m
CONFIG_LIBCRC32C=y
CONFIG_CRC8=y
CONFIG_XXHASH=y
CONFIG_RANDOM32_SELFTEST=y
CONFIG_842_COMPRESS=y
CONFIG_842_DECOMPRESS=y
CONFIG_ZLIB_INFLATE=y
CONFIG_LZO_COMPRESS=m
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_COMPRESS=m
CONFIG_LZ4_DECOMPRESS=m
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=m
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
# CONFIG_XZ_DEC_ARM is not set
CONFIG_XZ_DEC_ARMTHUMB=y
# CONFIG_XZ_DEC_SPARC is not set
CONFIG_XZ_DEC_MICROLZMA=y
CONFIG_XZ_DEC_BCJ=y
CONFIG_XZ_DEC_TEST=m
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_ZSTD=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_ENC16=y
CONFIG_REED_SOLOMON_DEC16=y
CONFIG_BCH=m
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
CONFIG_DMA_CMA=y
CONFIG_DMA_PERNUMA_CMA=y

#
# Default contiguous memory area size:
#
CONFIG_CMA_SIZE_MBYTES=16
CONFIG_CMA_SIZE_PERCENTAGE=10
# CONFIG_CMA_SIZE_SEL_MBYTES is not set
# CONFIG_CMA_SIZE_SEL_PERCENTAGE is not set
CONFIG_CMA_SIZE_SEL_MIN=y
# CONFIG_CMA_SIZE_SEL_MAX is not set
CONFIG_CMA_ALIGNMENT=8
CONFIG_DMA_API_DEBUG=y
CONFIG_DMA_API_DEBUG_SG=y
# CONFIG_DMA_MAP_BENCHMARK is not set
CONFIG_SGL_ALLOC=y
CONFIG_CPUMASK_OFFSTACK=y
CONFIG_GLOB=y
CONFIG_GLOB_SELFTEST=m
CONFIG_CLZ_TAB=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
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
CONFIG_MEMREGION=y
CONFIG_ARCH_STACKWALK=y
CONFIG_STACKDEPOT=y
CONFIG_REF_TRACKER=y
CONFIG_SBITMAP=y
# CONFIG_PARMAN is not set
# CONFIG_OBJAGG is not set
# end of Library routines

CONFIG_GENERIC_LIB_ASHLDI3=y
CONFIG_GENERIC_LIB_ASHRDI3=y
CONFIG_GENERIC_LIB_LSHRDI3=y
CONFIG_GENERIC_LIB_CMPDI2=y
CONFIG_GENERIC_LIB_UCMPDI2=y
CONFIG_POLYNOMIAL=m

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
# CONFIG_PRINTK_CALLER is not set
CONFIG_STACKTRACE_BUILD_ID=y
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
# CONFIG_BOOT_PRINTK_DELAY is not set
# CONFIG_DYNAMIC_DEBUG is not set
# CONFIG_DYNAMIC_DEBUG_CORE is not set
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
# CONFIG_DEBUG_INFO_COMPRESSED is not set
CONFIG_DEBUG_INFO_SPLIT=y
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
# CONFIG_MAGIC_SYSRQ is not set
CONFIG_DEBUG_FS=y
# CONFIG_DEBUG_FS_ALLOW_ALL is not set
CONFIG_DEBUG_FS_DISALLOW_MOUNT=y
# CONFIG_DEBUG_FS_ALLOW_NONE is not set
# CONFIG_UBSAN is not set
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
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_PAGE_OWNER is not set
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_PAGE_REF is not set
CONFIG_DEBUG_OBJECTS=y
CONFIG_DEBUG_OBJECTS_SELFTEST=y
# CONFIG_DEBUG_OBJECTS_FREE is not set
CONFIG_DEBUG_OBJECTS_TIMERS=y
CONFIG_DEBUG_OBJECTS_WORK=y
# CONFIG_DEBUG_OBJECTS_RCU_HEAD is not set
CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER=y
CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=1
CONFIG_SHRINKER_DEBUG=y
# CONFIG_DEBUG_STACK_USAGE is not set
CONFIG_SCHED_STACK_END_CHECK=y
CONFIG_DEBUG_VM=y
# CONFIG_DEBUG_VM_VMACACHE is not set
CONFIG_DEBUG_VM_RB=y
CONFIG_DEBUG_VM_PGFLAGS=y
# CONFIG_DEBUG_MEMORY_INIT is not set
CONFIG_DEBUG_PER_CPU_MAPS=y
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
# end of Memory Debugging

CONFIG_DEBUG_SHIRQ=y

#
# Debug Oops, Lockups and Hangs
#
# CONFIG_PANIC_ON_OOPS is not set
CONFIG_PANIC_ON_OOPS_VALUE=0
CONFIG_PANIC_TIMEOUT=0
# CONFIG_SOFTLOCKUP_DETECTOR is not set
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=120
CONFIG_BOOTPARAM_HUNG_TASK_PANIC=y
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
# CONFIG_DEBUG_LOCKDEP is not set
# CONFIG_DEBUG_ATOMIC_SLEEP is not set
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
CONFIG_LOCK_TORTURE_TEST=y
CONFIG_WW_MUTEX_SELFTEST=y
CONFIG_SCF_TORTURE_TEST=y
# CONFIG_CSD_LOCK_WAIT_DEBUG is not set
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
# CONFIG_DEBUG_PLIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
# end of Debug kernel data structures

CONFIG_DEBUG_CREDENTIALS=y

#
# RCU Debugging
#
CONFIG_PROVE_RCU=y
CONFIG_PROVE_RCU_LIST=y
CONFIG_TORTURE_TEST=y
# CONFIG_RCU_SCALE_TEST is not set
CONFIG_RCU_TORTURE_TEST=m
CONFIG_RCU_REF_SCALE_TEST=y
CONFIG_RCU_CPU_STALL_TIMEOUT=21
CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=0
# CONFIG_RCU_TRACE is not set
CONFIG_RCU_EQS_DEBUG=y
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
CONFIG_USER_STACKTRACE_SUPPORT=y
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
CONFIG_IRQSOFF_TRACER=y
# CONFIG_PREEMPT_TRACER is not set
# CONFIG_SCHED_TRACER is not set
CONFIG_HWLAT_TRACER=y
CONFIG_OSNOISE_TRACER=y
# CONFIG_TIMERLAT_TRACER is not set
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP=y
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
# CONFIG_PROFILE_ALL_BRANCHES is not set
# CONFIG_BLK_DEV_IO_TRACE is not set
CONFIG_DYNAMIC_EVENTS=y
# CONFIG_SYNTH_EVENTS is not set
CONFIG_USER_EVENTS=y
CONFIG_TRACE_EVENT_INJECT=y
CONFIG_TRACEPOINT_BENCHMARK=y
CONFIG_RING_BUFFER_BENCHMARK=m
# CONFIG_TRACE_EVAL_MAP_FILE is not set
CONFIG_FTRACE_SELFTEST=y
CONFIG_FTRACE_STARTUP_TEST=y
# CONFIG_EVENT_TRACE_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set
CONFIG_DA_MON_EVENTS=y
CONFIG_DA_MON_EVENTS_ID=y
CONFIG_RV=y
CONFIG_RV_MON_WWNR=y
# CONFIG_RV_REACTORS is not set
# CONFIG_SAMPLES is not set

#
# loongarch Debugging
#
# CONFIG_UNWINDER_GUESS is not set
CONFIG_UNWINDER_PROLOGUE=y
# end of loongarch Debugging

#
# Kernel Testing and Coverage
#
CONFIG_KUNIT=y
CONFIG_KUNIT_DEBUGFS=y
# CONFIG_KUNIT_TEST is not set
CONFIG_KUNIT_EXAMPLE_TEST=m
CONFIG_KUNIT_ALL_TESTS=m
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
CONFIG_FAULT_INJECTION=y
# CONFIG_FAIL_PAGE_ALLOC is not set
CONFIG_FAULT_INJECTION_USERCOPY=y
CONFIG_FAIL_MAKE_REQUEST=y
CONFIG_FAIL_IO_TIMEOUT=y
# CONFIG_FAIL_FUTEX is not set
# CONFIG_FAULT_INJECTION_DEBUG_FS is not set
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
CONFIG_RUNTIME_TESTING_MENU=y
CONFIG_LKDTM=y
CONFIG_TEST_CPUMASK=m
CONFIG_TEST_LIST_SORT=m
# CONFIG_TEST_MIN_HEAP is not set
CONFIG_TEST_SORT=m
CONFIG_TEST_DIV64=y
CONFIG_BACKTRACE_SELF_TEST=y
CONFIG_TEST_REF_TRACKER=m
CONFIG_RBTREE_TEST=y
CONFIG_REED_SOLOMON_TEST=m
# CONFIG_INTERVAL_TREE_TEST is not set
CONFIG_PERCPU_TEST=m
CONFIG_ATOMIC64_SELFTEST=y
CONFIG_TEST_HEXDUMP=m
# CONFIG_STRING_SELFTEST is not set
CONFIG_TEST_STRING_HELPERS=y
# CONFIG_TEST_STRSCPY is not set
# CONFIG_TEST_KSTRTOX is not set
CONFIG_TEST_PRINTF=y
CONFIG_TEST_SCANF=y
# CONFIG_TEST_BITMAP is not set
# CONFIG_TEST_UUID is not set
CONFIG_TEST_XARRAY=y
CONFIG_TEST_RHASHTABLE=m
# CONFIG_TEST_SIPHASH is not set
# CONFIG_TEST_IDA is not set
# CONFIG_TEST_LKM is not set
CONFIG_TEST_BITOPS=m
CONFIG_TEST_VMALLOC=m
CONFIG_TEST_USER_COPY=m
CONFIG_FIND_BIT_BENCHMARK=y
# CONFIG_TEST_FIRMWARE is not set
CONFIG_BITFIELD_KUNIT=m
# CONFIG_HASH_KUNIT_TEST is not set
CONFIG_RESOURCE_KUNIT_TEST=m
CONFIG_SYSCTL_KUNIT_TEST=m
CONFIG_LIST_KUNIT_TEST=m
CONFIG_LINEAR_RANGES_TEST=m
# CONFIG_CMDLINE_KUNIT_TEST is not set
CONFIG_BITS_TEST=m
# CONFIG_RATIONAL_KUNIT_TEST is not set
CONFIG_MEMCPY_KUNIT_TEST=m
CONFIG_OVERFLOW_KUNIT_TEST=m
CONFIG_STACKINIT_KUNIT_TEST=m
# CONFIG_TEST_UDELAY is not set
# CONFIG_TEST_STATIC_KEYS is not set
CONFIG_TEST_MEMCAT_P=y
CONFIG_TEST_MEMINIT=y
# CONFIG_TEST_FREE_PAGES is not set
# end of Kernel Testing and Coverage

CONFIG_WARN_MISSING_DOCUMENTS=y
CONFIG_WARN_ABI_ERRORS=y
# end of Kernel hacking

--1QLjTjNamNICajfh--
