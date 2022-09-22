Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED6355E6B3F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 20:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232155AbiIVSto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 14:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231764AbiIVStj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 14:49:39 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00661DFAA
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 11:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663872577; x=1695408577;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=P5juiKu7bYpxXj/gSrKPExTLTh/mH9tKD2hsvFIFKLA=;
  b=BNpTD+0vMGOIkBlucoXPpbgSVZgncwXbIXTPf4xLNJwKNFG6vBOk9kaH
   76kxyOfDn65zJtaJHN8l6n3UU0P+3rltE/B+UHW1wZ/5nw0pjelJZxOHA
   1nCMS1xozsiZHJv3882w7Ua1Gjc2b0etcIk900Tm8H6c4BwyWkh++hW6q
   hSemWLwTlfJRBHGIeZHQxmVd093I9qjXLRXhuzTvWvd6XZKsBNl/DlWZt
   gIQl+nhiKs8jXfcVle+wMJnw4/wMTa4OE4OKJyrQ3hk7SISeUG0AB/Dvk
   fE7CBzROVOwt4aV7j6KCej3Uy8bWwu+D5h59qPYOsc7Zpk17+sInE++I/
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="280121641"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="280121641"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 11:49:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="597563254"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 22 Sep 2022 11:49:36 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1obRGR-0004sb-2C;
        Thu, 22 Sep 2022 18:49:35 +0000
Date:   Fri, 23 Sep 2022 02:48:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [dvyukov:dvyukov-perf-debugging 1/1]
 arch/x86/kernel/hw_breakpoint.c:101:29: warning: variable 'copy' set but not
 used
Message-ID: <202209230213.4NtxMTaN-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/dvyukov/linux dvyukov-perf-debugging
head:   62267cd404c44bbb18a96c108839c99e7ba6f9bd
commit: 62267cd404c44bbb18a96c108839c99e7ba6f9bd [1/1] perf: debugging of missed breakpoints
config: i386-tinyconfig (https://download.01.org/0day-ci/archive/20220923/202209230213.4NtxMTaN-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/dvyukov/linux/commit/62267cd404c44bbb18a96c108839c99e7ba6f9bd
        git remote add dvyukov https://github.com/dvyukov/linux
        git fetch --no-tags dvyukov dvyukov-perf-debugging
        git checkout 62267cd404c44bbb18a96c108839c99e7ba6f9bd
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash arch/x86/kernel/ kernel/events/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   arch/x86/kernel/hw_breakpoint.c: In function 'arch_install_hw_breakpoint':
>> arch/x86/kernel/hw_breakpoint.c:101:29: warning: variable 'copy' set but not used [-Wunused-but-set-variable]
     101 |         unsigned long *dr7, copy;
         |                             ^~~~
   arch/x86/kernel/hw_breakpoint.c: In function 'arch_uninstall_hw_breakpoint':
   arch/x86/kernel/hw_breakpoint.c:151:28: warning: variable 'copy' set but not used [-Wunused-but-set-variable]
     151 |         unsigned long dr7, copy;
         |                            ^~~~
   arch/x86/kernel/hw_breakpoint.c: In function 'hw_breakpoint_handler':
>> arch/x86/kernel/hw_breakpoint.c:578:37: warning: suggest braces around empty body in an 'if' statement [-Wempty-body]
     578 |                 LOG("HIT not found");
         |                                     ^
--
   kernel/events/core.c: In function 'perf_event_disable_inatomic':
>> kernel/events/core.c:2474:74: warning: suggest braces around empty body in an 'if' statement [-Wempty-body]
    2474 |                 LOG("perf_event_disable_inatomic: irq_work_queue FAILED");
         |                                                                          ^
   kernel/events/core.c: In function 'merge_sched_in':
>> kernel/events/core.c:3739:53: warning: suggest braces around empty body in an 'else' statement [-Wempty-body]
    3739 |                         LOG("group_sched_in failed");
         |                                                     ^
   kernel/events/core.c: In function 'perf_bp_event':
   kernel/events/core.c:10191:45: warning: suggest braces around empty body in an 'else' statement [-Wempty-body]
   10191 |                 LOG("perf_bp_event: ignore");
         |                                             ^


vim +/copy +101 arch/x86/kernel/hw_breakpoint.c

    88	
    89	/*
    90	 * Install a perf counter breakpoint.
    91	 *
    92	 * We seek a free debug address register and use it for this
    93	 * breakpoint. Eventually we enable it in the debug control register.
    94	 *
    95	 * Atomic: we hold the counter->ctx->lock and we only handle variables
    96	 * and registers local to this cpu.
    97	 */
    98	int arch_install_hw_breakpoint(struct perf_event *bp)
    99	{
   100		struct arch_hw_breakpoint *info = counter_arch_bp(bp);
 > 101		unsigned long *dr7, copy;
   102		int i;
   103	
   104		lockdep_assert_irqs_disabled();
   105	
   106		for (i = 0; i < HBP_NUM; i++) {
   107			struct perf_event **slot = this_cpu_ptr(&bp_per_reg[i]);
   108	
   109			if (!*slot) {
   110				*slot = bp;
   111				break;
   112			}
   113		}
   114	
   115		if (WARN_ONCE(i == HBP_NUM, "Can't find any breakpoint slot"))
   116			return -EBUSY;
   117	
   118		set_debugreg(info->address, i);
   119		__this_cpu_write(cpu_debugreg[i], info->address);
   120	
   121		dr7 = this_cpu_ptr(&cpu_dr7);
   122		copy = *dr7;
   123		*dr7 |= encode_dr7(i, info->len, info->type);
   124		//LOG("INSTALL slot=%d event=%p", i, bp);
   125	
   126		/*
   127		 * Ensure we first write cpu_dr7 before we set the DR7 register.
   128		 * This ensures an NMI never see cpu_dr7 0 when DR7 is not.
   129		 */
   130		barrier();
   131	
   132		set_debugreg(*dr7, 7);
   133		if (info->mask)
   134			set_dr_addr_mask(info->mask, i);
   135	
   136		return 0;
   137	}
   138	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
