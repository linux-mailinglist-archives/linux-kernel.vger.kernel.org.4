Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ACAF6F8DDB
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 04:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbjEFCMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 22:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjEFCMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 22:12:37 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583AB5B86
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 19:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683339156; x=1714875156;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ABrthTnLoueMtmGiidF64a2pvhf9LmjgeABn6yXIBLg=;
  b=H8O77YD+OgJ0PhEDCc8x2D7KEReMYQIA0GOB8bopx7cWycRbb3jAZFUW
   ulIzeEQBUaSdKDFtc0fdOXPhcwZiRZCOZPZk4qRn2BAh+AdHorTFINQUK
   wM3+whnpQ+mdbP+Rx/FlVQjCwbGNNY96Is+y3J8CnFdetOiyH5AHOM4yr
   KDSlkTVC1BtxON9impoHOH3DkNbi3sbx6rEAe6/LcR8sEu3RWWB8R/j50
   VhAgTpL4a+vR7trng9jGEs9Oepx9e8lKtiBE8YSrzidp3LYbog735wovY
   /NGOVrgKuWsaPwHZ0PDMAyLG9aBPwEIeVE42z+0KqW3gb85cz7QPP8SRd
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="348157225"
X-IronPort-AV: E=Sophos;i="5.99,253,1677571200"; 
   d="scan'208";a="348157225"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2023 19:12:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="1027730906"
X-IronPort-AV: E=Sophos;i="5.99,253,1677571200"; 
   d="scan'208";a="1027730906"
Received: from lkp-server01.sh.intel.com (HELO fe5d646e317d) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 05 May 2023 19:12:34 -0700
Received: from kbuild by fe5d646e317d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pv7PW-00013h-06;
        Sat, 06 May 2023 02:12:34 +0000
Date:   Sat, 6 May 2023 10:12:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [paulmck-rcu:dev.2023.05.05a 47/72] arch/csky/kernel/smp.c:320:1:
 warning: 'noreturn' function does return
Message-ID: <202305061006.icKxQPqN-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2023.05.05a
head:   e217254079020832da33e19179438f4f5dcf81c8
commit: fb27834418c972c982320994dc42a29cca6df154 [47/72] objtool: Fix for unreachable instruction warning
config: csky-randconfig-r001-20230505 (https://download.01.org/0day-ci/archive/20230506/202305061006.icKxQPqN-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/commit/?id=fb27834418c972c982320994dc42a29cca6df154
        git remote add paulmck-rcu https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
        git fetch --no-tags paulmck-rcu dev.2023.05.05a
        git checkout fb27834418c972c982320994dc42a29cca6df154
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=csky olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=csky SHELL=/bin/bash arch/csky/kernel/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305061006.icKxQPqN-lkp@intel.com/

All warnings (new ones prefixed by >>):

   arch/csky/kernel/smp.c:246:6: warning: no previous prototype for 'csky_start_secondary' [-Wmissing-prototypes]
     246 | void csky_start_secondary(void)
         |      ^~~~~~~~~~~~~~~~~~~~
   arch/csky/kernel/smp.c: In function 'arch_cpu_idle_dead':
>> arch/csky/kernel/smp.c:320:1: warning: 'noreturn' function does return
     320 | }
         | ^


vim +/noreturn +320 arch/csky/kernel/smp.c

859e5f45cbb33f Guo Ren        2018-12-19  302  
859e5f45cbb33f Guo Ren        2018-12-19  303  void arch_cpu_idle_dead(void)
859e5f45cbb33f Guo Ren        2018-12-19  304  {
859e5f45cbb33f Guo Ren        2018-12-19  305  	idle_task_exit();
859e5f45cbb33f Guo Ren        2018-12-19  306  
859e5f45cbb33f Guo Ren        2018-12-19  307  	cpu_report_death();
859e5f45cbb33f Guo Ren        2018-12-19  308  
859e5f45cbb33f Guo Ren        2018-12-19  309  	while (!secondary_stack)
859e5f45cbb33f Guo Ren        2018-12-19  310  		arch_cpu_idle();
859e5f45cbb33f Guo Ren        2018-12-19  311  
89b3098703bd2a Peter Zijlstra 2023-01-12  312  	raw_local_irq_disable();
859e5f45cbb33f Guo Ren        2018-12-19  313  
859e5f45cbb33f Guo Ren        2018-12-19  314  	asm volatile(
859e5f45cbb33f Guo Ren        2018-12-19  315  		"mov	sp, %0\n"
859e5f45cbb33f Guo Ren        2018-12-19  316  		"mov	r8, %0\n"
859e5f45cbb33f Guo Ren        2018-12-19  317  		"jmpi	csky_start_secondary"
859e5f45cbb33f Guo Ren        2018-12-19  318  		:
859e5f45cbb33f Guo Ren        2018-12-19  319  		: "r" (secondary_stack));
859e5f45cbb33f Guo Ren        2018-12-19 @320  }

:::::: The code at line 320 was first introduced by commit
:::::: 859e5f45cbb33fe5d591a8e429667f0b7d4f4be8 csky: CPU-hotplug supported for SMP

:::::: TO: Guo Ren <ren_guo@c-sky.com>
:::::: CC: Guo Ren <ren_guo@c-sky.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
