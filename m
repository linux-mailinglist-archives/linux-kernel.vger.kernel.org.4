Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D41E05B587D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 12:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbiILKdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 06:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiILKdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 06:33:47 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD90C633D
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 03:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662978825; x=1694514825;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/JDMWLOgTY02hAOLr1Z92UTz/FqPqic7KaUgEs5vIW0=;
  b=NX7e0TuR0ZZfYsUIEsGbcHlvIctHCBpwvCRnroewxRNMH2qbf+C1cHwc
   YYE4QbpiamA3ZyAc7oHFRZDS/FP9Fzh9g4CszceMq20Ey2cmOfJwEaZR1
   mG9f3RFGqsavlebxdRK0vNGByHv3mRIBGpnBQTG77NJKB0wp+3PJNBcdn
   Tnl1NF3mpk0+ZsQId3jXxGATgB/AMyDwu00u+f6uci5Jfka/eTfNs57Or
   RjHG+Ycfy/nwhJ/fWOJASLRDZfVhtdni9MHrRaqwXz8bNZ7hxjgUcxzei
   yeFXpXZHiZzrLZXhgchOrQHZI9mZRYeWGldlMT//Ny3LMCqJ6bd7hFZ5w
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10467"; a="295417323"
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="295417323"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 03:33:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="567117040"
Received: from lkp-server02.sh.intel.com (HELO 4011df4f4fd3) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 12 Sep 2022 03:33:41 -0700
Received: from kbuild by 4011df4f4fd3 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oXgl2-0002QJ-2o;
        Mon, 12 Sep 2022 10:33:40 +0000
Date:   Mon, 12 Sep 2022 18:33:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     cgel.zte@gmail.com, mingo@redhat.com
Cc:     kbuild-all@lists.01.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, Xu Panda <xu.panda@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH linux-next] sched/core: remove duplicate referenced
 header files
Message-ID: <202209121840.ztJjt8BQ-lkp@intel.com>
References: <20220912082848.17859-1-xu.panda@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220912082848.17859-1-xu.panda@zte.com.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on next-20220909]

url:    https://github.com/intel-lab-lkp/linux/commits/cgel-zte-gmail-com/sched-core-remove-duplicate-referenced-header-files/20220912-163221
base:    9a82ccda91ed2b40619cb3c10d446ae1f97bab6e
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20220912/202209121840.ztJjt8BQ-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/4a9f2bfb0bf0353106fa2c74d7a8a0a0db2573df
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review cgel-zte-gmail-com/sched-core-remove-duplicate-referenced-header-files/20220912-163221
        git checkout 4a9f2bfb0bf0353106fa2c74d7a8a0a0db2573df
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash kernel/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> kernel/sched/core.c:8468:5: warning: no previous prototype for 'sched_dynamic_mode' [-Wmissing-prototypes]
    8468 | int sched_dynamic_mode(const char *str)
         |     ^~~~~~~~~~~~~~~~~~
   kernel/sched/core.c:8489:2: error: #error "Unsupported PREEMPT_DYNAMIC mechanism"
    8489 | #error "Unsupported PREEMPT_DYNAMIC mechanism"
         |  ^~~~~
>> kernel/sched/core.c:8492:6: warning: no previous prototype for 'sched_dynamic_update' [-Wmissing-prototypes]
    8492 | void sched_dynamic_update(int mode)
         |      ^~~~~~~~~~~~~~~~~~~~
   kernel/sched/core.c: In function 'sched_dynamic_update':
   kernel/sched/core.c:8498:9: error: implicit declaration of function 'preempt_dynamic_enable'; did you mean 'preempt_enable'? [-Werror=implicit-function-declaration]
    8498 |         preempt_dynamic_enable(cond_resched);
         |         ^~~~~~~~~~~~~~~~~~~~~~
         |         preempt_enable
   kernel/sched/core.c:8498:32: error: 'cond_resched' undeclared (first use in this function); did you mean '_cond_resched'?
    8498 |         preempt_dynamic_enable(cond_resched);
         |                                ^~~~~~~~~~~~
         |                                _cond_resched
   kernel/sched/core.c:8498:32: note: each undeclared identifier is reported only once for each function it appears in
   kernel/sched/core.c:8499:32: error: 'might_resched' undeclared (first use in this function)
    8499 |         preempt_dynamic_enable(might_resched);
         |                                ^~~~~~~~~~~~~
   kernel/sched/core.c:8500:32: error: 'preempt_schedule' undeclared (first use in this function); did you mean 'preempt_schedule_irq'?
    8500 |         preempt_dynamic_enable(preempt_schedule);
         |                                ^~~~~~~~~~~~~~~~
         |                                preempt_schedule_irq
   kernel/sched/core.c:8501:32: error: 'preempt_schedule_notrace' undeclared (first use in this function); did you mean 'preempt_schedule_common'?
    8501 |         preempt_dynamic_enable(preempt_schedule_notrace);
         |                                ^~~~~~~~~~~~~~~~~~~~~~~~
         |                                preempt_schedule_common
   kernel/sched/core.c:8502:32: error: 'irqentry_exit_cond_resched' undeclared (first use in this function)
    8502 |         preempt_dynamic_enable(irqentry_exit_cond_resched);
         |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/sched/core.c:8507:17: error: implicit declaration of function 'preempt_dynamic_disable'; did you mean 'preempt_disable'? [-Werror=implicit-function-declaration]
    8507 |                 preempt_dynamic_disable(might_resched);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~
         |                 preempt_disable
   kernel/sched/core.c: At top level:
   kernel/sched/core.c:8566:14: error: redefinition of 'preempt_model_none'
    8566 |         bool preempt_model_##mode(void)                                          \
         |              ^~~~~~~~~~~~~~
   kernel/sched/core.c:8573:1: note: in expansion of macro 'PREEMPT_MODEL_ACCESSOR'
    8573 | PREEMPT_MODEL_ACCESSOR(none);
         | ^~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/sched/mm.h:7,
                    from include/linux/xarray.h:19,
                    from include/linux/list_lru.h:14,
                    from include/linux/fs.h:13,
                    from include/linux/highmem.h:5,
                    from kernel/sched/core.c:9:
   include/linux/sched.h:2154:20: note: previous definition of 'preempt_model_none' with type 'bool(void)' {aka '_Bool(void)'}
    2154 | static inline bool preempt_model_none(void)
         |                    ^~~~~~~~~~~~~~~~~~
   kernel/sched/core.c:8566:14: error: redefinition of 'preempt_model_voluntary'
    8566 |         bool preempt_model_##mode(void)                                          \
         |              ^~~~~~~~~~~~~~
   kernel/sched/core.c:8574:1: note: in expansion of macro 'PREEMPT_MODEL_ACCESSOR'
    8574 | PREEMPT_MODEL_ACCESSOR(voluntary);
         | ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/sched.h:2158:20: note: previous definition of 'preempt_model_voluntary' with type 'bool(void)' {aka '_Bool(void)'}
    2158 | static inline bool preempt_model_voluntary(void)
         |                    ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/sched/core.c:8566:14: error: redefinition of 'preempt_model_full'
    8566 |         bool preempt_model_##mode(void)                                          \
         |              ^~~~~~~~~~~~~~
   kernel/sched/core.c:8575:1: note: in expansion of macro 'PREEMPT_MODEL_ACCESSOR'
    8575 | PREEMPT_MODEL_ACCESSOR(full);
         | ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/sched.h:2162:20: note: previous definition of 'preempt_model_full' with type 'bool(void)' {aka '_Bool(void)'}
    2162 | static inline bool preempt_model_full(void)
         |                    ^~~~~~~~~~~~~~~~~~
   kernel/sched/core.c:8577:2: error: #else without #if
    8577 | #else /* !CONFIG_PREEMPT_DYNAMIC */
         |  ^~~~
   kernel/sched/core.c:8579:20: error: redefinition of 'preempt_dynamic_init'
    8579 | static inline void preempt_dynamic_init(void) { }
         |                    ^~~~~~~~~~~~~~~~~~~~
   kernel/sched/core.c:8549:20: note: previous definition of 'preempt_dynamic_init' with type 'void(void)'
    8549 | static void __init preempt_dynamic_init(void)
         |                    ^~~~~~~~~~~~~~~~~~~~
   kernel/sched/core.c:8581:2: error: #endif without #if
    8581 | #endif /* #ifdef CONFIG_PREEMPT_DYNAMIC */
         |  ^~~~~
   kernel/sched/core.c:8549:20: warning: 'preempt_dynamic_init' defined but not used [-Wunused-function]
    8549 | static void __init preempt_dynamic_init(void)
         |                    ^~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/sched_dynamic_mode +8468 kernel/sched/core.c

4c7485584d48f6 Mark Rutland 2022-02-14  8467  
4c7485584d48f6 Mark Rutland 2022-02-14 @8468  int sched_dynamic_mode(const char *str)
4c7485584d48f6 Mark Rutland 2022-02-14  8469  {
4c7485584d48f6 Mark Rutland 2022-02-14  8470  	if (!strcmp(str, "none"))
4c7485584d48f6 Mark Rutland 2022-02-14  8471  		return preempt_dynamic_none;
4c7485584d48f6 Mark Rutland 2022-02-14  8472  
4c7485584d48f6 Mark Rutland 2022-02-14  8473  	if (!strcmp(str, "voluntary"))
4c7485584d48f6 Mark Rutland 2022-02-14  8474  		return preempt_dynamic_voluntary;
4c7485584d48f6 Mark Rutland 2022-02-14  8475  
4c7485584d48f6 Mark Rutland 2022-02-14  8476  	if (!strcmp(str, "full"))
4c7485584d48f6 Mark Rutland 2022-02-14  8477  		return preempt_dynamic_full;
4c7485584d48f6 Mark Rutland 2022-02-14  8478  
4c7485584d48f6 Mark Rutland 2022-02-14  8479  	return -EINVAL;
4c7485584d48f6 Mark Rutland 2022-02-14  8480  }
4c7485584d48f6 Mark Rutland 2022-02-14  8481  
99cf983cc8bca4 Mark Rutland 2022-02-14  8482  #if defined(CONFIG_HAVE_PREEMPT_DYNAMIC_CALL)
8a69fe0be143b0 Mark Rutland 2022-02-14  8483  #define preempt_dynamic_enable(f)	static_call_update(f, f##_dynamic_enabled)
8a69fe0be143b0 Mark Rutland 2022-02-14  8484  #define preempt_dynamic_disable(f)	static_call_update(f, f##_dynamic_disabled)
99cf983cc8bca4 Mark Rutland 2022-02-14  8485  #elif defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
99cf983cc8bca4 Mark Rutland 2022-02-14  8486  #define preempt_dynamic_enable(f)	static_key_enable(&sk_dynamic_##f.key)
99cf983cc8bca4 Mark Rutland 2022-02-14  8487  #define preempt_dynamic_disable(f)	static_key_disable(&sk_dynamic_##f.key)
99cf983cc8bca4 Mark Rutland 2022-02-14  8488  #else
99cf983cc8bca4 Mark Rutland 2022-02-14  8489  #error "Unsupported PREEMPT_DYNAMIC mechanism"
99cf983cc8bca4 Mark Rutland 2022-02-14  8490  #endif
8a69fe0be143b0 Mark Rutland 2022-02-14  8491  
4c7485584d48f6 Mark Rutland 2022-02-14 @8492  void sched_dynamic_update(int mode)
4c7485584d48f6 Mark Rutland 2022-02-14  8493  {
4c7485584d48f6 Mark Rutland 2022-02-14  8494  	/*
4c7485584d48f6 Mark Rutland 2022-02-14  8495  	 * Avoid {NONE,VOLUNTARY} -> FULL transitions from ever ending up in
4c7485584d48f6 Mark Rutland 2022-02-14  8496  	 * the ZERO state, which is invalid.
4c7485584d48f6 Mark Rutland 2022-02-14  8497  	 */
8a69fe0be143b0 Mark Rutland 2022-02-14  8498  	preempt_dynamic_enable(cond_resched);
8a69fe0be143b0 Mark Rutland 2022-02-14  8499  	preempt_dynamic_enable(might_resched);
8a69fe0be143b0 Mark Rutland 2022-02-14  8500  	preempt_dynamic_enable(preempt_schedule);
8a69fe0be143b0 Mark Rutland 2022-02-14  8501  	preempt_dynamic_enable(preempt_schedule_notrace);
8a69fe0be143b0 Mark Rutland 2022-02-14  8502  	preempt_dynamic_enable(irqentry_exit_cond_resched);
4c7485584d48f6 Mark Rutland 2022-02-14  8503  
4c7485584d48f6 Mark Rutland 2022-02-14  8504  	switch (mode) {
4c7485584d48f6 Mark Rutland 2022-02-14  8505  	case preempt_dynamic_none:
8a69fe0be143b0 Mark Rutland 2022-02-14  8506  		preempt_dynamic_enable(cond_resched);
8a69fe0be143b0 Mark Rutland 2022-02-14  8507  		preempt_dynamic_disable(might_resched);
8a69fe0be143b0 Mark Rutland 2022-02-14  8508  		preempt_dynamic_disable(preempt_schedule);
8a69fe0be143b0 Mark Rutland 2022-02-14  8509  		preempt_dynamic_disable(preempt_schedule_notrace);
8a69fe0be143b0 Mark Rutland 2022-02-14  8510  		preempt_dynamic_disable(irqentry_exit_cond_resched);
4c7485584d48f6 Mark Rutland 2022-02-14  8511  		pr_info("Dynamic Preempt: none\n");
4c7485584d48f6 Mark Rutland 2022-02-14  8512  		break;
4c7485584d48f6 Mark Rutland 2022-02-14  8513  
4c7485584d48f6 Mark Rutland 2022-02-14  8514  	case preempt_dynamic_voluntary:
8a69fe0be143b0 Mark Rutland 2022-02-14  8515  		preempt_dynamic_enable(cond_resched);
8a69fe0be143b0 Mark Rutland 2022-02-14  8516  		preempt_dynamic_enable(might_resched);
8a69fe0be143b0 Mark Rutland 2022-02-14  8517  		preempt_dynamic_disable(preempt_schedule);
8a69fe0be143b0 Mark Rutland 2022-02-14  8518  		preempt_dynamic_disable(preempt_schedule_notrace);
8a69fe0be143b0 Mark Rutland 2022-02-14  8519  		preempt_dynamic_disable(irqentry_exit_cond_resched);
4c7485584d48f6 Mark Rutland 2022-02-14  8520  		pr_info("Dynamic Preempt: voluntary\n");
4c7485584d48f6 Mark Rutland 2022-02-14  8521  		break;
4c7485584d48f6 Mark Rutland 2022-02-14  8522  
4c7485584d48f6 Mark Rutland 2022-02-14  8523  	case preempt_dynamic_full:
8a69fe0be143b0 Mark Rutland 2022-02-14  8524  		preempt_dynamic_disable(cond_resched);
8a69fe0be143b0 Mark Rutland 2022-02-14  8525  		preempt_dynamic_disable(might_resched);
8a69fe0be143b0 Mark Rutland 2022-02-14  8526  		preempt_dynamic_enable(preempt_schedule);
8a69fe0be143b0 Mark Rutland 2022-02-14  8527  		preempt_dynamic_enable(preempt_schedule_notrace);
8a69fe0be143b0 Mark Rutland 2022-02-14  8528  		preempt_dynamic_enable(irqentry_exit_cond_resched);
4c7485584d48f6 Mark Rutland 2022-02-14  8529  		pr_info("Dynamic Preempt: full\n");
4c7485584d48f6 Mark Rutland 2022-02-14  8530  		break;
4c7485584d48f6 Mark Rutland 2022-02-14  8531  	}
4c7485584d48f6 Mark Rutland 2022-02-14  8532  
4c7485584d48f6 Mark Rutland 2022-02-14  8533  	preempt_dynamic_mode = mode;
4c7485584d48f6 Mark Rutland 2022-02-14  8534  }
4c7485584d48f6 Mark Rutland 2022-02-14  8535  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
