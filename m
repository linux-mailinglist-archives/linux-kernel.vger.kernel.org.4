Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66D6F6F0431
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 12:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243512AbjD0K03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 06:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243564AbjD0K0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 06:26:23 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748BF4EC9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 03:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682591181; x=1714127181;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=wgOjOQleXk3rIPa3yUms+b5ZVmQBoL/vgR2p4oPCjZA=;
  b=bKjRQZe4rdpuYUMhO3WI98Z3eQAuqbh4OCKDhk9kBLpCQQH2NLqYfd4y
   xgU5Ax19tTywDH9QPSKAwx9o3fOsuN/qJZwxwY216EWdlxUq2PO4q+f2v
   AuQPzogznWoAVIR5cz0mv+YgwScJvrHAC+AIF2qhv59EWIfpMVHOmNTOM
   EBh/jlVd/J8CHaRhqdJ8ByXQOd+cJ6Jb2NjOsSNnfEyfzuXSuV5fN1LHY
   HusP58e3PBRB1mhYUTdFz7mKCl674B/COAeYasRuF2c8FITmeTSjSrDdB
   260yIPULtH++aE2lFrBM+Vi5/jqxRapjn9Vq1f+CxLd81pguoJ0MHK9Cn
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="433679834"
X-IronPort-AV: E=Sophos;i="5.99,230,1677571200"; 
   d="scan'208";a="433679834"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2023 03:26:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="763737187"
X-IronPort-AV: E=Sophos;i="5.99,230,1677571200"; 
   d="scan'208";a="763737187"
Received: from lkp-server01.sh.intel.com (HELO 1e0e07564161) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 27 Apr 2023 03:26:19 -0700
Received: from kbuild by 1e0e07564161 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1prypO-0000Ah-2w;
        Thu, 27 Apr 2023 10:26:18 +0000
Date:   Thu, 27 Apr 2023 18:25:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [paulmck-rcu:dev.2023.04.26a 35/51] arch/arm/kernel/smp.c:385:1:
 warning: function declared 'noreturn' should not return
Message-ID: <202304271836.Rr0pBtSE-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2023.04.26a
head:   56b38a90a12f76e463a7381d8cff854926fa2b59
commit: 2b927bfdda366c1719e021cd0e9688baf933c9cf [35/51] objtool: Fix for unreachable instruction warning
config: arm-milbeaut_m10v_defconfig (https://download.01.org/0day-ci/archive/20230427/202304271836.Rr0pBtSE-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 437b7602e4a998220871de78afcb020b9c14a661)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/commit/?id=2b927bfdda366c1719e021cd0e9688baf933c9cf
        git remote add paulmck-rcu https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
        git fetch --no-tags paulmck-rcu dev.2023.04.26a
        git checkout 2b927bfdda366c1719e021cd0e9688baf933c9cf
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash arch/arm/kernel/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304271836.Rr0pBtSE-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/arm/kernel/smp.c:385:1: warning: function declared 'noreturn' should not return [-Winvalid-noreturn]
   }
   ^
   1 warning generated.


vim +/noreturn +385 arch/arm/kernel/smp.c

a054a811597a17 Russell King     2005-11-02  314  
a054a811597a17 Russell King     2005-11-02  315  /*
a054a811597a17 Russell King     2005-11-02  316   * Called from the idle thread for the CPU which has been shutdown.
a054a811597a17 Russell King     2005-11-02  317   *
a054a811597a17 Russell King     2005-11-02  318   * Note that we disable IRQs here, but do not re-enable them
a054a811597a17 Russell King     2005-11-02  319   * before returning to the caller. This is also the behaviour
a054a811597a17 Russell King     2005-11-02  320   * of the other hotplug-cpu capable cores, so presumably coming
a054a811597a17 Russell King     2005-11-02  321   * out of idle fixes this.
a054a811597a17 Russell King     2005-11-02  322   */
9205b797dbe519 Stephen Boyd     2015-08-24  323  void arch_cpu_idle_dead(void)
a054a811597a17 Russell King     2005-11-02  324  {
a054a811597a17 Russell King     2005-11-02  325  	unsigned int cpu = smp_processor_id();
a054a811597a17 Russell King     2005-11-02  326  
a054a811597a17 Russell King     2005-11-02  327  	idle_task_exit();
a054a811597a17 Russell King     2005-11-02  328  
f36d340122ae87 Russell King     2010-11-30  329  	local_irq_disable();
f36d340122ae87 Russell King     2010-11-30  330  
51acdfd1fa38a2 Russell King     2013-04-18  331  	/*
51acdfd1fa38a2 Russell King     2013-04-18  332  	 * Flush the data out of the L1 cache for this CPU.  This must be
51acdfd1fa38a2 Russell King     2013-04-18  333  	 * before the completion to ensure that data is safely written out
51acdfd1fa38a2 Russell King     2013-04-18  334  	 * before platform_cpu_kill() gets called - which may disable
51acdfd1fa38a2 Russell King     2013-04-18  335  	 * *this* CPU and power down its cache.
51acdfd1fa38a2 Russell King     2013-04-18  336  	 */
51acdfd1fa38a2 Russell King     2013-04-18  337  	flush_cache_louis();
51acdfd1fa38a2 Russell King     2013-04-18  338  
51acdfd1fa38a2 Russell King     2013-04-18  339  	/*
51acdfd1fa38a2 Russell King     2013-04-18  340  	 * Tell __cpu_die() that this CPU is now safe to dispose of.  Once
51acdfd1fa38a2 Russell King     2013-04-18  341  	 * this returns, power and/or clocks can be removed at any point
51acdfd1fa38a2 Russell King     2013-04-18  342  	 * from this CPU and its cache by platform_cpu_kill().
51acdfd1fa38a2 Russell King     2013-04-18  343  	 */
1d5087ab964d84 Paul E. McKenney 2015-05-12  344  	(void)cpu_report_death();
3c030beabf937b Russell King     2010-11-30  345  
a054a811597a17 Russell King     2005-11-02  346  	/*
51acdfd1fa38a2 Russell King     2013-04-18  347  	 * Ensure that the cache lines associated with that completion are
51acdfd1fa38a2 Russell King     2013-04-18  348  	 * written out.  This covers the case where _this_ CPU is doing the
51acdfd1fa38a2 Russell King     2013-04-18  349  	 * powering down, to ensure that the completion is visible to the
51acdfd1fa38a2 Russell King     2013-04-18  350  	 * CPU waiting for this one.
51acdfd1fa38a2 Russell King     2013-04-18  351  	 */
51acdfd1fa38a2 Russell King     2013-04-18  352  	flush_cache_louis();
51acdfd1fa38a2 Russell King     2013-04-18  353  
51acdfd1fa38a2 Russell King     2013-04-18  354  	/*
51acdfd1fa38a2 Russell King     2013-04-18  355  	 * The actual CPU shutdown procedure is at least platform (if not
51acdfd1fa38a2 Russell King     2013-04-18  356  	 * CPU) specific.  This may remove power, or it may simply spin.
51acdfd1fa38a2 Russell King     2013-04-18  357  	 *
51acdfd1fa38a2 Russell King     2013-04-18  358  	 * Platforms are generally expected *NOT* to return from this call,
51acdfd1fa38a2 Russell King     2013-04-18  359  	 * although there are some which do because they have no way to
51acdfd1fa38a2 Russell King     2013-04-18  360  	 * power down the CPU.  These platforms are the _only_ reason we
51acdfd1fa38a2 Russell King     2013-04-18  361  	 * have a return path which uses the fragment of assembly below.
51acdfd1fa38a2 Russell King     2013-04-18  362  	 *
51acdfd1fa38a2 Russell King     2013-04-18  363  	 * The return path should not be used for platforms which can
51acdfd1fa38a2 Russell King     2013-04-18  364  	 * power off the CPU.
a054a811597a17 Russell King     2005-11-02  365  	 */
0a301110b7bd33 Russell King     2013-01-14  366  	if (smp_ops.cpu_die)
0a301110b7bd33 Russell King     2013-01-14  367  		smp_ops.cpu_die(cpu);
a054a811597a17 Russell King     2005-11-02  368  
668bc38669f9a6 Russell King     2014-01-11  369  	pr_warn("CPU%u: smp_ops.cpu_die() returned, trying to resuscitate\n",
668bc38669f9a6 Russell King     2014-01-11  370  		cpu);
668bc38669f9a6 Russell King     2014-01-11  371  
a054a811597a17 Russell King     2005-11-02  372  	/*
a054a811597a17 Russell King     2005-11-02  373  	 * Do not return to the idle loop - jump back to the secondary
a054a811597a17 Russell King     2005-11-02  374  	 * cpu initialisation.  There's some initialisation which needs
a054a811597a17 Russell King     2005-11-02  375  	 * to be repeated to undo the effects of taking the CPU offline.
a054a811597a17 Russell King     2005-11-02  376  	 */
a054a811597a17 Russell King     2005-11-02  377  	__asm__("mov	sp, %0\n"
faabfa0816916b Russell King     2010-12-20  378  	"	mov	fp, #0\n"
19f29aebd929c3 Keith Packard    2021-09-18  379  	"	mov	r0, %1\n"
a054a811597a17 Russell King     2005-11-02  380  	"	b	secondary_start_kernel"
a054a811597a17 Russell King     2005-11-02  381  		:
19f29aebd929c3 Keith Packard    2021-09-18  382  		: "r" (task_stack_page(current) + THREAD_SIZE - 8),
19f29aebd929c3 Keith Packard    2021-09-18  383  		  "r" (current)
19f29aebd929c3 Keith Packard    2021-09-18  384  		: "r0");
a054a811597a17 Russell King     2005-11-02 @385  }
a054a811597a17 Russell King     2005-11-02  386  #endif /* CONFIG_HOTPLUG_CPU */
a054a811597a17 Russell King     2005-11-02  387  

:::::: The code at line 385 was first introduced by commit
:::::: a054a811597a17ffbe92bc4db04a4dc2f1b1ea55 [ARM SMP] Add hotplug CPU infrastructure

:::::: TO: Russell King <rmk@dyn-67.arm.linux.org.uk>
:::::: CC: Russell King <rmk+kernel@arm.linux.org.uk>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
