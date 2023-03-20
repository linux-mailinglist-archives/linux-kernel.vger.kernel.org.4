Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D490D6C1297
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 14:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbjCTNFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 09:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbjCTNFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 09:05:11 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C6126AE
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 06:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679317510; x=1710853510;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Q3QPUUkGvy4I02ZnqncjmhVs5TLqBKNyyltpb0wA9Qw=;
  b=Y13Pr+5mxc/Ftg7rnojbOTlxTKhIkDl1pOoK7woNfdpxqmppYyUZBEwV
   kgyluj7+EdZUdC7b5Bb3phaswEvzqnLL6O2wmwi4IrypTXN8SiRSqBxO5
   3haFQokntrGO79veD5JZJ6W1QZN+sFtRLNT4ZjoLWgYTEDmA2Cb6aZuKI
   zgzxorIzzzm9VGwbdfF23bxOXimfCIjeLXpWOVKvERRomTIkGaIpLntx8
   IJL1ilxJFs+Inajb9Py2LUczx5s7EsUaot7eaWzYMVUeU57Ysb5rm60ti
   064QF1w18haBemunv0QBefq6GRA718i/kUEd+Wh96jKD5+BIi1uymxBV4
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="322494896"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="322494896"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 06:04:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="791604671"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="791604671"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 20 Mar 2023 06:04:43 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1peFBq-000B2s-1r;
        Mon, 20 Mar 2023 13:04:42 +0000
Date:   Mon, 20 Mar 2023 21:04:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: [tip:core/urgent 1/1] include/linux/context_tracking.h:99:19: error:
 redefinition of '__ct_state'
Message-ID: <202303202052.lv1EF1t6-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core/urgent
head:   3e2619c4ebba2cab8414c55b131b7a28f628de3b
commit: 3e2619c4ebba2cab8414c55b131b7a28f628de3b [1/1] entry: Fix noinstr warning in __enter_from_user_mode()
config: powerpc-allyesconfig (https://download.01.org/0day-ci/archive/20230320/202303202052.lv1EF1t6-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=3e2619c4ebba2cab8414c55b131b7a28f628de3b
        git remote add tip https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
        git fetch --no-tags tip core/urgent
        git checkout 3e2619c4ebba2cab8414c55b131b7a28f628de3b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc prepare

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303202052.lv1EF1t6-lkp@intel.com/

All errors (new ones prefixed by >>):

   scripts/genksyms/parse.y: warning: 9 shift/reduce conflicts [-Wconflicts-sr]
   scripts/genksyms/parse.y: warning: 5 reduce/reduce conflicts [-Wconflicts-rr]
   scripts/genksyms/parse.y: note: rerun with option '-Wcounterexamples' to generate conflict counterexamples
   In file included from include/linux/kvm_host.h:26,
                    from arch/powerpc/include/asm/kvm_ppc.h:19,
                    from arch/powerpc/include/asm/dbell.h:17,
                    from arch/powerpc/kernel/asm-offsets.c:36:
>> include/linux/context_tracking.h:99:19: error: redefinition of '__ct_state'
      99 | static inline int __ct_state(void) { return -1; }
         |                   ^~~~~~~~~~
   In file included from include/linux/hardirq.h:5,
                    from include/linux/interrupt.h:11,
                    from include/linux/kernel_stat.h:9,
                    from include/linux/cgroup.h:26,
                    from include/linux/memcontrol.h:13,
                    from include/linux/swap.h:9,
                    from include/linux/suspend.h:5,
                    from arch/powerpc/kernel/asm-offsets.c:21:
   include/linux/context_tracking_state.h:50:28: note: previous definition of '__ct_state' with type 'int(void)'
      50 | static __always_inline int __ct_state(void)
         |                            ^~~~~~~~~~
   make[2]: *** [scripts/Makefile.build:114: arch/powerpc/kernel/asm-offsets.s] Error 1
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:1286: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:226: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +/__ct_state +99 include/linux/context_tracking.h

    90	
    91	#else
    92	static inline void user_enter(void) { }
    93	static inline void user_exit(void) { }
    94	static inline void user_enter_irqoff(void) { }
    95	static inline void user_exit_irqoff(void) { }
    96	static inline int exception_enter(void) { return 0; }
    97	static inline void exception_exit(enum ctx_state prev_ctx) { }
    98	static inline int ct_state(void) { return -1; }
  > 99	static inline int __ct_state(void) { return -1; }
   100	static __always_inline bool context_tracking_guest_enter(void) { return false; }
   101	static inline void context_tracking_guest_exit(void) { }
   102	#define CT_WARN_ON(cond) do { } while (0)
   103	#endif /* !CONFIG_CONTEXT_TRACKING_USER */
   104	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
