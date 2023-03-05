Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 979C26AAE7D
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 08:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjCEHhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 02:37:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjCEHhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 02:37:24 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE0BEC7C;
        Sat,  4 Mar 2023 23:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678001842; x=1709537842;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=w4eE0e1ro3KAzqTi6eAbZM43RBSMQFQXw8xLRXeA79M=;
  b=PCqKNV+JiR928o6W/kSY/Mqtu0ozAWlaNk8ISM3NjQ4LGUXpK7GBTO0i
   IAGs6ApZQiKLZ3nCBITR96QKHlfGu9Ut56dmI5h1OtWWBXjlpYbIZb0MW
   9J1pdhtoP+wHIWmOM7QPiKdLmheS71rOJvgEkxpSLvEqJudcmMQj61Inf
   drkoipdvXuzSrGaMvl1jcGyYMD6qWBq44tmP1X1Ixpdo+FwUCTydZEsB4
   AkJz2+5i6gFFV3ls3PzNiu7TFJucWeWQCMvJIYu+fSAH7DFEXtYwDxd67
   J/+Q+S4YUG7afJrEoHdINCmI9eCPAQRbunohmjDpfgVZzbPtn9XPLV5UQ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10639"; a="362963675"
X-IronPort-AV: E=Sophos;i="5.98,235,1673942400"; 
   d="scan'208";a="362963675"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2023 23:37:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10639"; a="764887077"
X-IronPort-AV: E=Sophos;i="5.98,235,1673942400"; 
   d="scan'208";a="764887077"
Received: from lkp-server01.sh.intel.com (HELO 776573491cc5) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Mar 2023 23:37:18 -0800
Received: from kbuild by 776573491cc5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pYivm-0002bJ-0V;
        Sun, 05 Mar 2023 07:37:18 +0000
Date:   Sun, 5 Mar 2023 15:36:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Manish Bhardwaj <bhardwajmanish18@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev,
        Manish Bhardwaj <bhardwajmanish18@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf/core: introduced stub APIs for exported APIs
Message-ID: <202303051558.FF5cjvLT-lkp@intel.com>
References: <20230305053934.9948-1-bhardwajmanish18@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230305053934.9948-1-bhardwajmanish18@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Manish,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on tip/perf/core]
[also build test ERROR on acme/perf/core tip/master tip/auto-latest linus/master v6.2 next-20230303]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Manish-Bhardwaj/perf-core-introduced-stub-APIs-for-exported-APIs/20230305-134024
patch link:    https://lore.kernel.org/r/20230305053934.9948-1-bhardwajmanish18%40gmail.com
patch subject: [PATCH] perf/core: introduced stub APIs for exported APIs
config: nios2-randconfig-r021-20230305 (https://download.01.org/0day-ci/archive/20230305/202303051558.FF5cjvLT-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/2636181e6d3f39c8485077cb15927f84f00a617c
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Manish-Bhardwaj/perf-core-introduced-stub-APIs-for-exported-APIs/20230305-134024
        git checkout 2636181e6d3f39c8485077cb15927f84f00a617c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=nios2 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=nios2 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303051558.FF5cjvLT-lkp@intel.com/

All errors (new ones prefixed by >>):

   nios2-linux-ld: init/do_mounts.o: in function `perf_pmu_unregister':
>> do_mounts.c:(.text+0x184): multiple definition of `perf_pmu_unregister'; init/main.o:main.c:(.text+0x18): first defined here
   nios2-linux-ld: init/do_mounts_initrd.o: in function `perf_pmu_unregister':
   do_mounts_initrd.c:(.text+0x0): multiple definition of `perf_pmu_unregister'; init/main.o:main.c:(.text+0x18): first defined here
   nios2-linux-ld: init/initramfs.o: in function `perf_pmu_unregister':
   initramfs.c:(.text+0x48): multiple definition of `perf_pmu_unregister'; init/main.o:main.c:(.text+0x18): first defined here
   nios2-linux-ld: arch/nios2/kernel/sys_nios2.o: in function `perf_pmu_unregister':
   sys_nios2.c:(.text+0x0): multiple definition of `perf_pmu_unregister'; init/main.o:main.c:(.text+0x18): first defined here
   nios2-linux-ld: arch/nios2/kernel/syscall_table.o: in function `perf_pmu_unregister':
   syscall_table.c:(.text+0x0): multiple definition of `perf_pmu_unregister'; init/main.o:main.c:(.text+0x18): first defined here
   nios2-linux-ld: arch/nios2/mm/fault.o: in function `perf_pmu_unregister':
   fault.c:(.text+0x0): multiple definition of `perf_pmu_unregister'; init/main.o:main.c:(.text+0x18): first defined here
   nios2-linux-ld: kernel/fork.o: in function `perf_pmu_unregister':
   fork.c:(.text+0xa78): multiple definition of `perf_pmu_unregister'; init/main.o:main.c:(.text+0x18): first defined here
   nios2-linux-ld: kernel/exec_domain.o: in function `perf_pmu_unregister':
   exec_domain.c:(.text+0x0): multiple definition of `perf_pmu_unregister'; init/main.o:main.c:(.text+0x18): first defined here
   nios2-linux-ld: kernel/cpu.o: in function `perf_pmu_unregister':
   cpu.c:(.text+0x584): multiple definition of `perf_pmu_unregister'; init/main.o:main.c:(.text+0x18): first defined here
   nios2-linux-ld: kernel/exit.o: in function `perf_pmu_unregister':
   exit.c:(.text+0xf58): multiple definition of `perf_pmu_unregister'; init/main.o:main.c:(.text+0x18): first defined here
   nios2-linux-ld: kernel/sysctl.o: in function `perf_pmu_unregister':
   sysctl.c:(.text+0x60): multiple definition of `perf_pmu_unregister'; init/main.o:main.c:(.text+0x18): first defined here
   nios2-linux-ld: kernel/capability.o: in function `perf_pmu_unregister':
   capability.c:(.text+0x5dc): multiple definition of `perf_pmu_unregister'; init/main.o:main.c:(.text+0x18): first defined here
   nios2-linux-ld: kernel/ptrace.o: in function `perf_pmu_unregister':
   ptrace.c:(.text+0x600): multiple definition of `perf_pmu_unregister'; init/main.o:main.c:(.text+0x18): first defined here
   nios2-linux-ld: kernel/signal.o: in function `perf_pmu_unregister':
   signal.c:(.text+0x16bc): multiple definition of `perf_pmu_unregister'; init/main.o:main.c:(.text+0x18): first defined here
   nios2-linux-ld: kernel/sys.o: in function `perf_pmu_unregister':
   sys.c:(.text+0x1478): multiple definition of `perf_pmu_unregister'; init/main.o:main.c:(.text+0x18): first defined here
   nios2-linux-ld: kernel/umh.o: in function `perf_pmu_unregister':
   umh.c:(.text+0xa08): multiple definition of `perf_pmu_unregister'; init/main.o:main.c:(.text+0x18): first defined here
   nios2-linux-ld: kernel/pid.o: in function `perf_pmu_unregister':
   pid.c:(.text+0x5f8): multiple definition of `perf_pmu_unregister'; init/main.o:main.c:(.text+0x18): first defined here
   nios2-linux-ld: kernel/nsproxy.o: in function `perf_pmu_unregister':
   nsproxy.c:(.text+0x26c): multiple definition of `perf_pmu_unregister'; init/main.o:main.c:(.text+0x18): first defined here
   nios2-linux-ld: kernel/reboot.o: in function `perf_pmu_unregister':
   reboot.c:(.text+0xa74): multiple definition of `perf_pmu_unregister'; init/main.o:main.c:(.text+0x18): first defined here
   nios2-linux-ld: kernel/kmod.o: in function `perf_pmu_unregister':
   kmod.c:(.text+0x358): multiple definition of `perf_pmu_unregister'; init/main.o:main.c:(.text+0x18): first defined here
   nios2-linux-ld: kernel/groups.o: in function `perf_pmu_unregister':
   groups.c:(.text+0x270): multiple definition of `perf_pmu_unregister'; init/main.o:main.c:(.text+0x18): first defined here
   nios2-linux-ld: kernel/sched/core.o: in function `perf_pmu_unregister':
   core.c:(.text+0xc04): multiple definition of `perf_pmu_unregister'; init/main.o:main.c:(.text+0x18): first defined here
   nios2-linux-ld: kernel/sched/fair.o: in function `perf_pmu_unregister':
   fair.c:(.text+0x2184): multiple definition of `perf_pmu_unregister'; init/main.o:main.c:(.text+0x18): first defined here
   nios2-linux-ld: kernel/sched/build_policy.o: in function `perf_pmu_unregister':
   build_policy.c:(.text+0x3318): multiple definition of `perf_pmu_unregister'; init/main.o:main.c:(.text+0x18): first defined here
   nios2-linux-ld: kernel/sched/build_utility.o: in function `perf_pmu_unregister':
   build_utility.c:(.text+0x38a8): multiple definition of `perf_pmu_unregister'; init/main.o:main.c:(.text+0x18): first defined here
   nios2-linux-ld: kernel/power/qos.o: in function `perf_pmu_unregister':
   qos.c:(.text+0xe0): multiple definition of `perf_pmu_unregister'; init/main.o:main.c:(.text+0x18): first defined here
   nios2-linux-ld: kernel/printk/printk.o: in function `perf_pmu_unregister':
   printk.c:(.text+0xb5c): multiple definition of `perf_pmu_unregister'; init/main.o:main.c:(.text+0x18): first defined here
   nios2-linux-ld: kernel/rcu/tree.o: in function `perf_pmu_unregister':
   tree.c:(.text+0x7a00): multiple definition of `perf_pmu_unregister'; init/main.o:main.c:(.text+0x18): first defined here
   nios2-linux-ld: kernel/module/main.o: in function `perf_pmu_unregister':
   main.c:(.text+0xeb4): multiple definition of `perf_pmu_unregister'; init/main.o:main.c:(.text+0x18): first defined here
   nios2-linux-ld: kernel/kcmp.o: in function `perf_pmu_unregister':
   kcmp.c:(.text+0x570): multiple definition of `perf_pmu_unregister'; init/main.o:main.c:(.text+0x18): first defined here
   nios2-linux-ld: kernel/time/time.o: in function `perf_pmu_unregister':
   time.c:(.text+0xc98): multiple definition of `perf_pmu_unregister'; init/main.o:main.c:(.text+0x18): first defined here
   nios2-linux-ld: kernel/time/timer.o: in function `perf_pmu_unregister':
   timer.c:(.text+0x1650): multiple definition of `perf_pmu_unregister'; init/main.o:main.c:(.text+0x18): first defined here
   nios2-linux-ld: kernel/time/hrtimer.o: in function `perf_pmu_unregister':
   hrtimer.c:(.text+0x13c4): multiple definition of `perf_pmu_unregister'; init/main.o:main.c:(.text+0x18): first defined here
   nios2-linux-ld: kernel/time/posix-stubs.o: in function `perf_pmu_unregister':
   posix-stubs.c:(.text+0x0): multiple definition of `perf_pmu_unregister'; init/main.o:main.c:(.text+0x18): first defined here
   nios2-linux-ld: kernel/time/tick-common.o: in function `perf_pmu_unregister':
   tick-common.c:(.text+0x1a0): multiple definition of `perf_pmu_unregister'; init/main.o:main.c:(.text+0x18): first defined here
   nios2-linux-ld: kernel/bpf/core.o: in function `perf_pmu_unregister':
   core.c:(.text+0x4c0): multiple definition of `perf_pmu_unregister'; init/main.o:main.c:(.text+0x18): first defined here
   nios2-linux-ld: mm/oom_kill.o: in function `perf_pmu_unregister':
   oom_kill.c:(.text+0x748): multiple definition of `perf_pmu_unregister'; init/main.o:main.c:(.text+0x18): first defined here
   nios2-linux-ld: mm/fadvise.o: in function `perf_pmu_unregister':
   fadvise.c:(.text+0x324): multiple definition of `perf_pmu_unregister'; init/main.o:main.c:(.text+0x18): first defined here
   nios2-linux-ld: mm/page-writeback.o: in function `perf_pmu_unregister':
   page-writeback.c:(.text+0x287c): multiple definition of `perf_pmu_unregister'; init/main.o:main.c:(.text+0x18): first defined here
   nios2-linux-ld: mm/readahead.o: in function `perf_pmu_unregister':
   readahead.c:(.text+0xb6c): multiple definition of `perf_pmu_unregister'; init/main.o:main.c:(.text+0x18): first defined here
   nios2-linux-ld: mm/shmem.o: in function `perf_pmu_unregister':
   shmem.c:(.text+0x5968): multiple definition of `perf_pmu_unregister'; init/main.o:main.c:(.text+0x18): first defined here
   nios2-linux-ld: mm/debug.o: in function `perf_pmu_unregister':
   debug.c:(.text+0x1a8): multiple definition of `perf_pmu_unregister'; init/main.o:main.c:(.text+0x18): first defined here
   nios2-linux-ld: mm/mmap_lock.o: in function `perf_pmu_unregister':
   mmap_lock.c:(.text+0x0): multiple definition of `perf_pmu_unregister'; init/main.o:main.c:(.text+0x18): first defined here
   nios2-linux-ld: mm/memory.o: in function `perf_pmu_unregister':
   memory.c:(.text+0x1130): multiple definition of `perf_pmu_unregister'; init/main.o:main.c:(.text+0x18): first defined here
   nios2-linux-ld: mm/mincore.o: in function `perf_pmu_unregister':
   mincore.c:(.text+0x52c): multiple definition of `perf_pmu_unregister'; init/main.o:main.c:(.text+0x18): first defined here
   nios2-linux-ld: mm/mlock.o: in function `perf_pmu_unregister':
   mlock.c:(.text+0x1c34): multiple definition of `perf_pmu_unregister'; init/main.o:main.c:(.text+0x18): first defined here
   nios2-linux-ld: mm/mmap.o: in function `perf_pmu_unregister':
   mmap.c:(.text+0xa34): multiple definition of `perf_pmu_unregister'; init/main.o:main.c:(.text+0x18): first defined here
   nios2-linux-ld: mm/mprotect.o: in function `perf_pmu_unregister':
   mprotect.c:(.text+0x0): multiple definition of `perf_pmu_unregister'; init/main.o:main.c:(.text+0x18): first defined here
   nios2-linux-ld: mm/mremap.o: in function `perf_pmu_unregister':
   mremap.c:(.text+0x121c): multiple definition of `perf_pmu_unregister'; init/main.o:main.c:(.text+0x18): first defined here
   nios2-linux-ld: mm/msync.o: in function `perf_pmu_unregister':
   msync.c:(.text+0x24c): multiple definition of `perf_pmu_unregister'; init/main.o:main.c:(.text+0x18): first defined here
   nios2-linux-ld: mm/process_vm_access.o: in function `perf_pmu_unregister':
   process_vm_access.c:(.text+0x5b4): multiple definition of `perf_pmu_unregister'; init/main.o:main.c:(.text+0x18): first defined here

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
