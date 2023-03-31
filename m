Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6EA76D207C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 14:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbjCaMgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 08:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231766AbjCaMgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 08:36:16 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79162033E
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 05:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680266148; x=1711802148;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=DMDOYXYAeH//I/7UAnCnDMR/SnHlfTK4Kx9Us/xmRPY=;
  b=PjugzfbBZ8zbgn754bQAXsbNEfaQ7DFym89MxNrSC7cuYpGIdK+/gKTJ
   lTD6eDHyh5I00dmdDBNa+ACHVR99WB8ioQ4ldryLdjo1mx2aOuPdBRzLT
   oQsH7CFgVUDzCSKce/sr1i3oAqo/FDxZ31yJrhwzI53/geeaP9KPZuKja
   SxVTtzYWoSKvJ9uLSxskzcbRG9JVxDiVd5iT7dXRvPAjJymzGMZjfLJEW
   hSb/RJApyCwQWGrvKjbg57Nlwbii5iHWz3/quUrjsbcTGlQzWNl87Oi7u
   ZUtakL117pvGZxxEQKfjmgZFHYcLzue8QGpjsbPOgdR/2LNyKvrO4Ng3X
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="343958333"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="343958333"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2023 05:35:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="796107330"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="796107330"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 31 Mar 2023 05:35:36 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1piDyi-000Lm8-0H;
        Fri, 31 Mar 2023 12:35:36 +0000
Date:   Fri, 31 Mar 2023 20:35:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Rui Wang <wangrui@loongson.cn>
Subject: kernel/events/core.c:223:9: sparse: sparse: incorrect type in
 argument 1 (different address spaces)
Message-ID: <202303312017.ZniDYgaU-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-0.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   62bad54b26db8bc98e28749cd76b2d890edb4258
commit: 720dc7ab252bbdf404cab7b909e26b31e602bf7e LoongArch: Add subword xchg/cmpxchg emulation
date:   7 months ago
config: loongarch-randconfig-s033-20230329 (https://download.01.org/0day-ci/archive/20230331/202303312017.ZniDYgaU-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=720dc7ab252bbdf404cab7b909e26b31e602bf7e
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 720dc7ab252bbdf404cab7b909e26b31e602bf7e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=loongarch olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=loongarch SHELL=/bin/bash arch/loongarch/kernel/ drivers/perf/ kernel/events/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303312017.ZniDYgaU-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> kernel/events/core.c:223:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/events/core.c:223:9: sparse:     expected void *ptr
   kernel/events/core.c:223:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/events/core.c:223:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/events/core.c:223:9: sparse:     expected void *ptr
   kernel/events/core.c:223:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/events/core.c:223:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/events/core.c:223:9: sparse:     expected void *ptr
   kernel/events/core.c:223:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/events/core.c:223:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/events/core.c:223:9: sparse:     expected void *ptr
   kernel/events/core.c:223:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/events/core.c:223:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/events/core.c:223:9: sparse:     expected void *ptr
   kernel/events/core.c:223:9: sparse:     got int [noderef] __percpu *
>> kernel/events/core.c:223:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/events/core.c:223:9: sparse:     expected void *ptr
   kernel/events/core.c:223:9: sparse:     got int [noderef] __percpu *
>> kernel/events/core.c:223:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/events/core.c:223:9: sparse:     expected void *ptr
   kernel/events/core.c:223:9: sparse:     got int [noderef] __percpu *
>> kernel/events/core.c:223:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/events/core.c:223:9: sparse:     expected void *ptr
   kernel/events/core.c:223:9: sparse:     got int [noderef] __percpu *
   kernel/events/core.c:320:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/events/core.c:320:9: sparse:     expected void *ptr
   kernel/events/core.c:320:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/events/core.c:320:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/events/core.c:320:9: sparse:     expected void *ptr
   kernel/events/core.c:320:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/events/core.c:320:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/events/core.c:320:9: sparse:     expected void *ptr
   kernel/events/core.c:320:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/events/core.c:320:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/events/core.c:320:9: sparse:     expected void *ptr
   kernel/events/core.c:320:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/events/core.c:320:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/events/core.c:320:9: sparse:     expected void *ptr
   kernel/events/core.c:320:9: sparse:     got int [noderef] __percpu *
   kernel/events/core.c:320:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/events/core.c:320:9: sparse:     expected void *ptr
   kernel/events/core.c:320:9: sparse:     got int [noderef] __percpu *
   kernel/events/core.c:320:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/events/core.c:320:9: sparse:     expected void *ptr
   kernel/events/core.c:320:9: sparse:     got int [noderef] __percpu *
   kernel/events/core.c:320:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/events/core.c:320:9: sparse:     expected void *ptr
   kernel/events/core.c:320:9: sparse:     got int [noderef] __percpu *
   kernel/events/core.c:1074:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/events/core.c:1074:9: sparse:     expected void *ptr
   kernel/events/core.c:1074:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/events/core.c:1074:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/events/core.c:1074:9: sparse:     expected void *ptr
   kernel/events/core.c:1074:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/events/core.c:1074:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/events/core.c:1074:9: sparse:     expected void *ptr
   kernel/events/core.c:1074:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/events/core.c:1074:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/events/core.c:1074:9: sparse:     expected void *ptr
   kernel/events/core.c:1074:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/events/core.c:1074:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/events/core.c:1074:9: sparse:     expected void *ptr
   kernel/events/core.c:1074:9: sparse:     got int [noderef] __percpu *
   kernel/events/core.c:1074:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/events/core.c:1074:9: sparse:     expected void *ptr
   kernel/events/core.c:1074:9: sparse:     got int [noderef] __percpu *
   kernel/events/core.c:1074:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/events/core.c:1074:9: sparse:     expected void *ptr
   kernel/events/core.c:1074:9: sparse:     got int [noderef] __percpu *
   kernel/events/core.c:1074:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/events/core.c:1074:9: sparse:     expected void *ptr
   kernel/events/core.c:1074:9: sparse:     got int [noderef] __percpu *
   kernel/events/core.c:1161:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/events/core.c:1161:9: sparse:     expected void *ptr
   kernel/events/core.c:1161:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/events/core.c:1161:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/events/core.c:1161:9: sparse:     expected void *ptr
   kernel/events/core.c:1161:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/events/core.c:1161:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/events/core.c:1161:9: sparse:     expected void *ptr
   kernel/events/core.c:1161:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/events/core.c:1161:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/events/core.c:1161:9: sparse:     expected void *ptr
   kernel/events/core.c:1161:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/events/core.c:1161:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/events/core.c:1161:9: sparse:     expected void *ptr
   kernel/events/core.c:1161:9: sparse:     got int [noderef] __percpu *
   kernel/events/core.c:1161:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/events/core.c:1161:9: sparse:     expected void *ptr
   kernel/events/core.c:1161:9: sparse:     got int [noderef] __percpu *
   kernel/events/core.c:1161:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/events/core.c:1161:9: sparse:     expected void *ptr
   kernel/events/core.c:1161:9: sparse:     got int [noderef] __percpu *
   kernel/events/core.c:1161:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/events/core.c:1161:9: sparse:     expected void *ptr
   kernel/events/core.c:1161:9: sparse:     got int [noderef] __percpu *
   kernel/events/core.c:1170:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/events/core.c:1170:9: sparse:     expected void *ptr
   kernel/events/core.c:1170:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/events/core.c:1170:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/events/core.c:1170:9: sparse:     expected void *ptr
   kernel/events/core.c:1170:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/events/core.c:1170:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/events/core.c:1170:9: sparse:     expected void *ptr
   kernel/events/core.c:1170:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/events/core.c:1170:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/events/core.c:1170:9: sparse:     expected void *ptr
   kernel/events/core.c:1170:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/events/core.c:1170:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/events/core.c:1170:9: sparse:     expected void *ptr
   kernel/events/core.c:1170:9: sparse:     got int [noderef] __percpu *
   kernel/events/core.c:1170:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/events/core.c:1170:9: sparse:     expected void *ptr
   kernel/events/core.c:1170:9: sparse:     got int [noderef] __percpu *
   kernel/events/core.c:1170:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/events/core.c:1170:9: sparse:     expected void *ptr
   kernel/events/core.c:1170:9: sparse:     got int [noderef] __percpu *
   kernel/events/core.c:1170:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/events/core.c:1170:9: sparse:     expected void *ptr
   kernel/events/core.c:1170:9: sparse:     got int [noderef] __percpu *
   kernel/events/core.c:1402:15: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:1402:15: sparse:    struct perf_event_context [noderef] __rcu *

vim +223 kernel/events/core.c

fae3fde65138b6 Peter Zijlstra      2016-01-11  213  
fae3fde65138b6 Peter Zijlstra      2016-01-11  214  static int event_function(void *info)
fae3fde65138b6 Peter Zijlstra      2016-01-11  215  {
fae3fde65138b6 Peter Zijlstra      2016-01-11  216  	struct event_function_struct *efs = info;
fae3fde65138b6 Peter Zijlstra      2016-01-11  217  	struct perf_event *event = efs->event;
fae3fde65138b6 Peter Zijlstra      2016-01-11  218  	struct perf_event_context *ctx = event->ctx;
fae3fde65138b6 Peter Zijlstra      2016-01-11  219  	struct perf_cpu_context *cpuctx = __get_cpu_context(ctx);
fae3fde65138b6 Peter Zijlstra      2016-01-11  220  	struct perf_event_context *task_ctx = cpuctx->task_ctx;
63b6da39bb38e8 Peter Zijlstra      2016-01-14  221  	int ret = 0;
fae3fde65138b6 Peter Zijlstra      2016-01-11  222  
164446455a5d3f Frederic Weisbecker 2017-11-06 @223  	lockdep_assert_irqs_disabled();
fae3fde65138b6 Peter Zijlstra      2016-01-11  224  
63b6da39bb38e8 Peter Zijlstra      2016-01-14  225  	perf_ctx_lock(cpuctx, task_ctx);
fae3fde65138b6 Peter Zijlstra      2016-01-11  226  	/*
fae3fde65138b6 Peter Zijlstra      2016-01-11  227  	 * Since we do the IPI call without holding ctx->lock things can have
fae3fde65138b6 Peter Zijlstra      2016-01-11  228  	 * changed, double check we hit the task we set out to hit.
fae3fde65138b6 Peter Zijlstra      2016-01-11  229  	 */
fae3fde65138b6 Peter Zijlstra      2016-01-11  230  	if (ctx->task) {
63b6da39bb38e8 Peter Zijlstra      2016-01-14  231  		if (ctx->task != current) {
0da4cf3e0a68c9 Peter Zijlstra      2016-02-24  232  			ret = -ESRCH;
63b6da39bb38e8 Peter Zijlstra      2016-01-14  233  			goto unlock;
fae3fde65138b6 Peter Zijlstra      2016-01-11  234  		}
fae3fde65138b6 Peter Zijlstra      2016-01-11  235  
fae3fde65138b6 Peter Zijlstra      2016-01-11  236  		/*
fae3fde65138b6 Peter Zijlstra      2016-01-11  237  		 * We only use event_function_call() on established contexts,
fae3fde65138b6 Peter Zijlstra      2016-01-11  238  		 * and event_function() is only ever called when active (or
fae3fde65138b6 Peter Zijlstra      2016-01-11  239  		 * rather, we'll have bailed in task_function_call() or the
fae3fde65138b6 Peter Zijlstra      2016-01-11  240  		 * above ctx->task != current test), therefore we must have
fae3fde65138b6 Peter Zijlstra      2016-01-11  241  		 * ctx->is_active here.
fae3fde65138b6 Peter Zijlstra      2016-01-11  242  		 */
fae3fde65138b6 Peter Zijlstra      2016-01-11  243  		WARN_ON_ONCE(!ctx->is_active);
fae3fde65138b6 Peter Zijlstra      2016-01-11  244  		/*
fae3fde65138b6 Peter Zijlstra      2016-01-11  245  		 * And since we have ctx->is_active, cpuctx->task_ctx must
fae3fde65138b6 Peter Zijlstra      2016-01-11  246  		 * match.
fae3fde65138b6 Peter Zijlstra      2016-01-11  247  		 */
63b6da39bb38e8 Peter Zijlstra      2016-01-14  248  		WARN_ON_ONCE(task_ctx != ctx);
63b6da39bb38e8 Peter Zijlstra      2016-01-14  249  	} else {
63b6da39bb38e8 Peter Zijlstra      2016-01-14  250  		WARN_ON_ONCE(&cpuctx->ctx != ctx);
fae3fde65138b6 Peter Zijlstra      2016-01-11  251  	}
63b6da39bb38e8 Peter Zijlstra      2016-01-14  252  
fae3fde65138b6 Peter Zijlstra      2016-01-11  253  	efs->func(event, cpuctx, ctx, efs->data);
63b6da39bb38e8 Peter Zijlstra      2016-01-14  254  unlock:
fae3fde65138b6 Peter Zijlstra      2016-01-11  255  	perf_ctx_unlock(cpuctx, task_ctx);
fae3fde65138b6 Peter Zijlstra      2016-01-11  256  
63b6da39bb38e8 Peter Zijlstra      2016-01-14  257  	return ret;
fae3fde65138b6 Peter Zijlstra      2016-01-11  258  }
fae3fde65138b6 Peter Zijlstra      2016-01-11  259  

:::::: The code at line 223 was first introduced by commit
:::::: 164446455a5d3f1402b5a0ea42acce33fd576ed7 perf/core: Use lockdep to assert IRQs are disabled/enabled

:::::: TO: Frederic Weisbecker <frederic@kernel.org>
:::::: CC: Ingo Molnar <mingo@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
