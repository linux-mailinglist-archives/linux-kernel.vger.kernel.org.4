Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FAFF744BAB
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 01:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjGAXCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 19:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjGAXC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 19:02:28 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EAF110DC
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jul 2023 16:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688252546; x=1719788546;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=IYnW846sq0wYleV4YkOC4AOty92PdnoeHCbJ2AgN/Fo=;
  b=hMi4GkXjpT0J7rlVFfu7J5BEIibXB9egAcwwo+j/2bovspYhNFu+OaxN
   kpi1HWiMSAHo0DOPt8+CCTHddxSYyOV54U1BoDaodMceOMJHC6BcjASpn
   GEpdJWXkMyg3/mzXZL8rZSAHiClcWk4TXlTsIbdymmYNuLYKtplVVh3sm
   c8C5+rhXI9qPS4GAMPvo3/WkpQ/12asBPfkYw2SbkV5/ePuo7kMMrR099
   kcMGIrzfkjU24Srfi3Mj9clHnqHJDxYEVhAaRWS86qTewF5zuYleIQoAY
   vCY1k5foylimghzgmHxA8tOMrui67mJIsRMtM4rBzHNPqubR/ceJrvZua
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10758"; a="360113064"
X-IronPort-AV: E=Sophos;i="6.01,175,1684825200"; 
   d="scan'208";a="360113064"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2023 16:02:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10758"; a="712163735"
X-IronPort-AV: E=Sophos;i="6.01,175,1684825200"; 
   d="scan'208";a="712163735"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 01 Jul 2023 16:02:23 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qFjbi-000GJx-2j;
        Sat, 01 Jul 2023 23:02:22 +0000
Date:   Sun, 2 Jul 2023 07:01:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Waiman Long <longman@redhat.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: kernel/trace/trace.c:2430:9: sparse: sparse: incorrect type in
 argument 1 (different address spaces)
Message-ID: <202307020600.1oOCL8pD-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   dfab92f27c600fea3cadc6e2cb39f092024e1fef
commit: c0a581d7126c0bbc96163276f585fd7b4e4d8d0e tracing: Disable interrupt or preemption before acquiring arch_spinlock_t
date:   9 months ago
config: loongarch-randconfig-r073-20230627 (https://download.01.org/0day-ci/archive/20230702/202307020600.1oOCL8pD-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230702/202307020600.1oOCL8pD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307020600.1oOCL8pD-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   kernel/trace/trace.c:406:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct trace_export **list @@     got struct trace_export [noderef] __rcu ** @@
   kernel/trace/trace.c:406:28: sparse:     expected struct trace_export **list
   kernel/trace/trace.c:406:28: sparse:     got struct trace_export [noderef] __rcu **
   kernel/trace/trace.c:420:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct trace_export **list @@     got struct trace_export [noderef] __rcu ** @@
   kernel/trace/trace.c:420:33: sparse:     expected struct trace_export **list
   kernel/trace/trace.c:420:33: sparse:     got struct trace_export [noderef] __rcu **
>> kernel/trace/trace.c:2430:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/trace/trace.c:2430:9: sparse:     expected void *ptr
   kernel/trace/trace.c:2430:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/trace/trace.c:2430:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/trace/trace.c:2430:9: sparse:     expected void *ptr
   kernel/trace/trace.c:2430:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/trace/trace.c:2430:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/trace/trace.c:2430:9: sparse:     expected void *ptr
   kernel/trace/trace.c:2430:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/trace/trace.c:2430:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/trace/trace.c:2430:9: sparse:     expected void *ptr
   kernel/trace/trace.c:2430:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/trace/trace.c:2430:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/trace/trace.c:2430:9: sparse:     expected void *ptr
   kernel/trace/trace.c:2430:9: sparse:     got int [noderef] __percpu *
>> kernel/trace/trace.c:2430:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/trace/trace.c:2430:9: sparse:     expected void *ptr
   kernel/trace/trace.c:2430:9: sparse:     got int [noderef] __percpu *
>> kernel/trace/trace.c:2430:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/trace/trace.c:2430:9: sparse:     expected void *ptr
   kernel/trace/trace.c:2430:9: sparse:     got int [noderef] __percpu *
>> kernel/trace/trace.c:2430:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/trace/trace.c:2430:9: sparse:     expected void *ptr
   kernel/trace/trace.c:2430:9: sparse:     got int [noderef] __percpu *
   kernel/trace/trace.c:2879:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct event_filter *filter @@     got struct event_filter [noderef] __rcu *filter @@
   kernel/trace/trace.c:2879:38: sparse:     expected struct event_filter *filter
   kernel/trace/trace.c:2879:38: sparse:     got struct event_filter [noderef] __rcu *filter
   kernel/trace/trace.c:7354:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got struct ring_buffer_event *[noderef] __percpu * @@
   kernel/trace/trace.c:7354:20: sparse:     expected void *ptr
   kernel/trace/trace.c:7354:20: sparse:     got struct ring_buffer_event *[noderef] __percpu *
   kernel/trace/trace.c:7354:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got struct ring_buffer_event *[noderef] __percpu * @@
   kernel/trace/trace.c:7354:20: sparse:     expected void *ptr
   kernel/trace/trace.c:7354:20: sparse:     got struct ring_buffer_event *[noderef] __percpu *
   kernel/trace/trace.c:7354:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got struct ring_buffer_event *[noderef] __percpu * @@
   kernel/trace/trace.c:7354:20: sparse:     expected void *ptr
   kernel/trace/trace.c:7354:20: sparse:     got struct ring_buffer_event *[noderef] __percpu *
   kernel/trace/trace.c:7354:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got struct ring_buffer_event *[noderef] __percpu * @@
   kernel/trace/trace.c:7354:20: sparse:     expected void *ptr
   kernel/trace/trace.c:7354:20: sparse:     got struct ring_buffer_event *[noderef] __percpu *
   kernel/trace/trace.c:360:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/trace/trace.c:360:9: sparse:    struct trace_export [noderef] __rcu *
   kernel/trace/trace.c:360:9: sparse:    struct trace_export *
   kernel/trace/trace.c:375:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/trace/trace.c:375:9: sparse:    struct trace_export [noderef] __rcu *
   kernel/trace/trace.c:375:9: sparse:    struct trace_export *

vim +2430 kernel/trace/trace.c

  2410	
  2411	static int trace_save_cmdline(struct task_struct *tsk)
  2412	{
  2413		unsigned tpid, idx;
  2414	
  2415		/* treat recording of idle task as a success */
  2416		if (!tsk->pid)
  2417			return 1;
  2418	
  2419		tpid = tsk->pid & (PID_MAX_DEFAULT - 1);
  2420	
  2421		/*
  2422		 * It's not the end of the world if we don't get
  2423		 * the lock, but we also don't want to spin
  2424		 * nor do we want to disable interrupts,
  2425		 * so if we miss here, then better luck next time.
  2426		 *
  2427		 * This is called within the scheduler and wake up, so interrupts
  2428		 * had better been disabled and run queue lock been held.
  2429		 */
> 2430		lockdep_assert_preemption_disabled();
  2431		if (!arch_spin_trylock(&trace_cmdline_lock))
  2432			return 0;
  2433	
  2434		idx = savedcmd->map_pid_to_cmdline[tpid];
  2435		if (idx == NO_CMDLINE_MAP) {
  2436			idx = (savedcmd->cmdline_idx + 1) % savedcmd->cmdline_num;
  2437	
  2438			savedcmd->map_pid_to_cmdline[tpid] = idx;
  2439			savedcmd->cmdline_idx = idx;
  2440		}
  2441	
  2442		savedcmd->map_cmdline_to_pid[idx] = tsk->pid;
  2443		set_cmdline(idx, tsk->comm);
  2444	
  2445		arch_spin_unlock(&trace_cmdline_lock);
  2446	
  2447		return 1;
  2448	}
  2449	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
