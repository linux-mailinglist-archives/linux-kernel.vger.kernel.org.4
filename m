Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4266173491A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 00:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjFRWXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 18:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjFRWXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 18:23:47 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A1AA197
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 15:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687127026; x=1718663026;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=KjNekOqWRtFbZcJys2xPNUrkkb4T2h1uOmRSQUTwu4c=;
  b=h+A8gNeBNKyWqlczfmNtNwSGZ1d/k3B9WiIzY9vCogZM5DX7dEA4cVT5
   e5XZTJAJ/ztvv/fM9lDUlOI14Z8GNhS/7UuMD5XuRCXnG0GrNX3YfNu2Z
   qbPXyXMcj2BM9sjfFDjSBDA9BxJiuRpKXVVOO+n+ulZm3CWog4pPTRBlr
   P1Z/DKySWhxQKvsmBpODbr/SykzJ8uwvAZk1zR8nRp5io+sKy89jBUKYP
   cqhLNx/8a9RTkA3klbzeoIX8dppY6mRjblVo6lQVJuUbt0pUo/xhNQ2qj
   A7fn4xYazEZwU9i487Cw95+DwdMPKhWqYDpsg5UoJmicwVu5Z0gg+Zjuf
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10745"; a="423172376"
X-IronPort-AV: E=Sophos;i="6.00,253,1681196400"; 
   d="scan'208";a="423172376"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2023 15:23:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10745"; a="1043690826"
X-IronPort-AV: E=Sophos;i="6.00,253,1681196400"; 
   d="scan'208";a="1043690826"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 18 Jun 2023 15:23:44 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qB0oB-00045k-1y;
        Sun, 18 Jun 2023 22:23:43 +0000
Date:   Mon, 19 Jun 2023 06:22:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Song Chen <chensong_2000@189.cn>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Subject: kernel/trace/trace_eprobe.c:460:1: warning: stack frame size (1760)
 exceeds limit (1024) in '__eprobe_trace_func'
Message-ID: <202306190644.qKs8k0ng-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   8c1f0c38b31025f60437215dd27fffc293565fa4
commit: 672a2bf84061f0f19acfc5869f5b3689759a55a8 kernel/trace: Provide default impelentations defined in trace_probe_tmpl.h
date:   4 months ago
config: riscv-randconfig-r011-20230619 (https://download.01.org/0day-ci/archive/20230619/202306190644.qKs8k0ng-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20230619/202306190644.qKs8k0ng-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306190644.qKs8k0ng-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/trace/trace_eprobe.c:428:1: warning: stack frame size (1424) exceeds limit (1024) in 'process_fetch_insn' [-Wframe-larger-than]
     428 | process_fetch_insn(struct fetch_insn *code, void *rec, void *dest,
         | ^
>> kernel/trace/trace_eprobe.c:460:1: warning: stack frame size (1760) exceeds limit (1024) in '__eprobe_trace_func' [-Wframe-larger-than]
     460 | __eprobe_trace_func(struct eprobe_data *edata, void *rec)
         | ^
   2 warnings generated.


vim +/__eprobe_trace_func +460 kernel/trace/trace_eprobe.c

7491e2c442781a Tzvetomir Stoyanov (VMware  2021-08-19  457) 
7491e2c442781a Tzvetomir Stoyanov (VMware  2021-08-19  458) /* eprobe handler */
7491e2c442781a Tzvetomir Stoyanov (VMware  2021-08-19  459) static inline void
7491e2c442781a Tzvetomir Stoyanov (VMware  2021-08-19 @460) __eprobe_trace_func(struct eprobe_data *edata, void *rec)
7491e2c442781a Tzvetomir Stoyanov (VMware  2021-08-19  461) {
7491e2c442781a Tzvetomir Stoyanov (VMware  2021-08-19  462) 	struct eprobe_trace_entry_head *entry;
7491e2c442781a Tzvetomir Stoyanov (VMware  2021-08-19  463) 	struct trace_event_call *call = trace_probe_event_call(&edata->ep->tp);
7491e2c442781a Tzvetomir Stoyanov (VMware  2021-08-19  464) 	struct trace_event_buffer fbuffer;
7491e2c442781a Tzvetomir Stoyanov (VMware  2021-08-19  465) 	int dsize;
7491e2c442781a Tzvetomir Stoyanov (VMware  2021-08-19  466) 
7491e2c442781a Tzvetomir Stoyanov (VMware  2021-08-19  467) 	if (WARN_ON_ONCE(call != edata->file->event_call))
7491e2c442781a Tzvetomir Stoyanov (VMware  2021-08-19  468) 		return;
7491e2c442781a Tzvetomir Stoyanov (VMware  2021-08-19  469) 
7491e2c442781a Tzvetomir Stoyanov (VMware  2021-08-19  470) 	if (trace_trigger_soft_disabled(edata->file))
7491e2c442781a Tzvetomir Stoyanov (VMware  2021-08-19  471) 		return;
7491e2c442781a Tzvetomir Stoyanov (VMware  2021-08-19  472) 
7491e2c442781a Tzvetomir Stoyanov (VMware  2021-08-19  473) 	dsize = get_eprobe_size(&edata->ep->tp, rec);
3e8b1a29a0e8d3 Steven Rostedt (VMware      2021-11-29  474) 
3e8b1a29a0e8d3 Steven Rostedt (VMware      2021-11-29  475) 	entry = trace_event_buffer_reserve(&fbuffer, edata->file,
3e8b1a29a0e8d3 Steven Rostedt (VMware      2021-11-29  476) 					   sizeof(*entry) + edata->ep->tp.size + dsize);
3e8b1a29a0e8d3 Steven Rostedt (VMware      2021-11-29  477) 
3e8b1a29a0e8d3 Steven Rostedt (VMware      2021-11-29  478) 	if (!entry)
7491e2c442781a Tzvetomir Stoyanov (VMware  2021-08-19  479) 		return;
7491e2c442781a Tzvetomir Stoyanov (VMware  2021-08-19  480) 
7491e2c442781a Tzvetomir Stoyanov (VMware  2021-08-19  481) 	entry = fbuffer.entry = ring_buffer_event_data(fbuffer.event);
7491e2c442781a Tzvetomir Stoyanov (VMware  2021-08-19  482) 	store_trace_args(&entry[1], &edata->ep->tp, rec, sizeof(*entry), dsize);
7491e2c442781a Tzvetomir Stoyanov (VMware  2021-08-19  483) 
7491e2c442781a Tzvetomir Stoyanov (VMware  2021-08-19  484) 	trace_event_buffer_commit(&fbuffer);
7491e2c442781a Tzvetomir Stoyanov (VMware  2021-08-19  485) }
7491e2c442781a Tzvetomir Stoyanov (VMware  2021-08-19  486) 

:::::: The code at line 460 was first introduced by commit
:::::: 7491e2c442781a1860181adb5ab472a52075f393 tracing: Add a probe that attaches to trace events

:::::: TO: Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
:::::: CC: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
