Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE1168CA73
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 00:21:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbjBFXVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 18:21:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjBFXVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 18:21:24 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F83E23DB7
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 15:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675725683; x=1707261683;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3CegStI2OdNPOSLc16MGHcE2ZWQ9IgspkA7bHYrCrqg=;
  b=BDhFGorsZy/1pqCQbJZW21dZ54F7GMjDsI7fTgnSAuxTe7mhor00tJpI
   DDQF4uhPV80KpbK6YxfXhbRQMPedETO721NX2Vh3IUlhELdi1KiPZldF1
   6FnJ1muarvT74IqRuRnnGahyMOsc7yWyB4rPscrn7UEi1V/m4DVC3Rsms
   joFiAal2J3v4FTwD/DuDNoFBc8NwvbwnCz6kaWVBzwj2W+XAaabZVya4q
   q1vexleb6a8FNVS/Dl9k//1pR9O9GvwuVYvT/ISaaEBrFSgRs2qyYP20H
   k7ZISVWG6fd8Wjo+5KzO+UPnYAEbMO3KVHUm4+bIPuUIrct++IPDloBzQ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="393941086"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="393941086"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 15:21:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="666639643"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="666639643"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 06 Feb 2023 15:21:21 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pPAnY-0002qh-0H;
        Mon, 06 Feb 2023 23:21:20 +0000
Date:   Tue, 7 Feb 2023 07:21:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [tip:x86/vdso 3/4] arch/x86/entry/vdso/vdso32/../vgetcpu.c:13:1:
 warning: no previous prototype for function '__vdso_getcpu'
Message-ID: <202302070751.uhpE2V7R-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/vdso
head:   5646bbd6684acf5c9b9dedb863b7d2f6f5a330fb
commit: 92d33063c081a82d25dd08a9cce03947c8ed9164 [3/4] x86/vdso: Provide getcpu for x86-32.
config: x86_64-randconfig-r031-20230206 (https://download.01.org/0day-ci/archive/20230207/202302070751.uhpE2V7R-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=92d33063c081a82d25dd08a9cce03947c8ed9164
        git remote add tip https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
        git fetch --no-tags tip x86/vdso
        git checkout 92d33063c081a82d25dd08a9cce03947c8ed9164
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/entry/vdso/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from arch/x86/entry/vdso/vdso32/vgetcpu.c:2:
   In file included from arch/x86/entry/vdso/vdso32/../vgetcpu.c:8:
   In file included from include/linux/kernel.h:22:
   In file included from include/linux/bitops.h:68:
   In file included from arch/x86/include/asm/bitops.h:420:
   arch/x86/include/asm/arch_hweight.h:49:15: error: invalid input size for constraint 'D'
                            : REG_IN (w));
                                      ^
   In file included from arch/x86/entry/vdso/vdso32/vgetcpu.c:2:
   In file included from arch/x86/entry/vdso/vdso32/../vgetcpu.c:8:
   In file included from include/linux/kernel.h:25:
   In file included from include/linux/math.h:6:
   arch/x86/include/asm/div64.h:85:34: error: invalid output size for constraint '=a'
           asm ("mulq %2; divq %3" : "=a" (q)
                                           ^
   In file included from arch/x86/entry/vdso/vdso32/vgetcpu.c:2:
>> arch/x86/entry/vdso/vdso32/../vgetcpu.c:13:1: warning: no previous prototype for function '__vdso_getcpu' [-Wmissing-prototypes]
   __vdso_getcpu(unsigned *cpu, unsigned *node, struct getcpu_cache *unused)
   ^
   arch/x86/entry/vdso/vdso32/../vgetcpu.c:12:9: note: declare 'static' if the function is not intended to be used outside of this translation unit
   notrace long
           ^
           static 
   1 warning and 2 errors generated.


vim +/__vdso_getcpu +13 arch/x86/entry/vdso/vdso32/../vgetcpu.c

2aae950b21e4bc arch/x86_64/vdso/vgetcpu.c    Andi Kleen     2007-07-21  11  
23adec554a7648 arch/x86/vdso/vgetcpu.c       Steven Rostedt 2008-05-12  12  notrace long
23adec554a7648 arch/x86/vdso/vgetcpu.c       Steven Rostedt 2008-05-12 @13  __vdso_getcpu(unsigned *cpu, unsigned *node, struct getcpu_cache *unused)
2aae950b21e4bc arch/x86_64/vdso/vgetcpu.c    Andi Kleen     2007-07-21  14  {
22245bdf0ad805 arch/x86/entry/vdso/vgetcpu.c Ingo Molnar    2018-10-08  15  	vdso_read_cpunode(cpu, node);
ec3a94188df7d2 arch/x86/entry/vdso/vgetcpu.c Ingo Molnar    2018-10-08  16  
2aae950b21e4bc arch/x86_64/vdso/vgetcpu.c    Andi Kleen     2007-07-21  17  	return 0;
2aae950b21e4bc arch/x86_64/vdso/vgetcpu.c    Andi Kleen     2007-07-21  18  }
2aae950b21e4bc arch/x86_64/vdso/vgetcpu.c    Andi Kleen     2007-07-21  19  

:::::: The code at line 13 was first introduced by commit
:::::: 23adec554a7648f99c8acc0caf49c66320cd2b84 x86: add notrace annotations to vsyscall.

:::::: TO: Steven Rostedt <srostedt@redhat.com>
:::::: CC: Thomas Gleixner <tglx@linutronix.de>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
