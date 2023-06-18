Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA90273488C
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 23:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjFRVTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 17:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjFRVTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 17:19:44 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C361B4
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 14:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687123183; x=1718659183;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Plcyh4dlupOF2/wvncz4aGtsbkmENnkZX2jLIs/uuNs=;
  b=DxIYTYTddVQdIaKFF0eCM+kJ696HANCCnoQGJso5DmZSSUqCiH2a9e0Y
   Djyyg3hSftnt+9cVBdiQfVU+3e6tUPSv4CEF20w1LV/LNvdCsvGuCGGLu
   UJC9qM7Gc09GcIa8xUMOsKUx3gvenJq56+UCoBnjmaN2ZzKC+J1UVLvcy
   N+BvLcqJBaUVCi0rOnjiW25lYLG92zbsJpHMHkR4gPbTOXpzTfwtMIs+l
   +LAjI3XT5L+w8LLxEj4fYD2WpU/8Y/SHCfhdtWBeSb/rQKCWXxmDcDlfd
   uetzIeTj11jUSz0pg7y48/SHqwpyGskoePduKotq0B5CPn9xFZh8DDFBv
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10745"; a="423169087"
X-IronPort-AV: E=Sophos;i="6.00,253,1681196400"; 
   d="scan'208";a="423169087"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2023 14:19:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10745"; a="663772816"
X-IronPort-AV: E=Sophos;i="6.00,253,1681196400"; 
   d="scan'208";a="663772816"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 18 Jun 2023 14:19:41 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qAzoC-00042u-1K;
        Sun, 18 Jun 2023 21:19:40 +0000
Date:   Mon, 19 Jun 2023 05:19:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: kernel/trace/trace_eprobe.c:427:1: warning: stack frame size (1424)
 exceeds limit (1024) in 'process_fetch_insn'
Message-ID: <202306190512.F00Ve0zD-lkp@intel.com>
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
commit: b26a124cbfa80f42bfc4e63e1d5643ca98159d66 tracing/probes: Add symstr type for dynamic events
date:   6 months ago
config: riscv-randconfig-r011-20230619 (https://download.01.org/0day-ci/archive/20230619/202306190512.F00Ve0zD-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20230619/202306190512.F00Ve0zD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306190512.F00Ve0zD-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/trace/trace_eprobe.c:427:1: warning: stack frame size (1424) exceeds limit (1024) in 'process_fetch_insn' [-Wframe-larger-than]
     427 | process_fetch_insn(struct fetch_insn *code, void *rec, void *dest,
         | ^
   kernel/trace/trace_eprobe.c:561:13: warning: stack frame size (1584) exceeds limit (1024) in 'eprobe_trigger_func' [-Wframe-larger-than]
     561 | static void eprobe_trigger_func(struct event_trigger_data *data,
         |             ^
   2 warnings generated.
--
>> kernel/trace/trace_uprobe.c:218:1: warning: stack frame size (1440) exceeds limit (1024) in 'process_fetch_insn' [-Wframe-larger-than]
     218 | process_fetch_insn(struct fetch_insn *code, void *rec, void *dest,
         | ^
   1 warning generated.


vim +/process_fetch_insn +427 kernel/trace/trace_eprobe.c

7491e2c442781a Tzvetomir Stoyanov (VMware  2021-08-19  424) 
7491e2c442781a Tzvetomir Stoyanov (VMware  2021-08-19  425) /* Note that we don't verify it, since the code does not come from user space */
7491e2c442781a Tzvetomir Stoyanov (VMware  2021-08-19  426) static int
7491e2c442781a Tzvetomir Stoyanov (VMware  2021-08-19 @427) process_fetch_insn(struct fetch_insn *code, void *rec, void *dest,
7491e2c442781a Tzvetomir Stoyanov (VMware  2021-08-19  428) 		   void *base)
7491e2c442781a Tzvetomir Stoyanov (VMware  2021-08-19  429) {
7491e2c442781a Tzvetomir Stoyanov (VMware  2021-08-19  430) 	unsigned long val;
7491e2c442781a Tzvetomir Stoyanov (VMware  2021-08-19  431) 
6a832ec3d680b3 Steven Rostedt (Google      2022-08-20  432)  retry:
6a832ec3d680b3 Steven Rostedt (Google      2022-08-20  433) 	switch (code->op) {
6a832ec3d680b3 Steven Rostedt (Google      2022-08-20  434) 	case FETCH_OP_TP_ARG:
7491e2c442781a Tzvetomir Stoyanov (VMware  2021-08-19  435) 		val = get_event_field(code, rec);
6a832ec3d680b3 Steven Rostedt (Google      2022-08-20  436) 		break;
6a832ec3d680b3 Steven Rostedt (Google      2022-08-20  437) 	case FETCH_OP_IMM:
6a832ec3d680b3 Steven Rostedt (Google      2022-08-20  438) 		val = code->immediate;
6a832ec3d680b3 Steven Rostedt (Google      2022-08-20  439) 		break;
6a832ec3d680b3 Steven Rostedt (Google      2022-08-20  440) 	case FETCH_OP_COMM:
6a832ec3d680b3 Steven Rostedt (Google      2022-08-20  441) 		val = (unsigned long)current->comm;
6a832ec3d680b3 Steven Rostedt (Google      2022-08-20  442) 		break;
6a832ec3d680b3 Steven Rostedt (Google      2022-08-20  443) 	case FETCH_OP_DATA:
6a832ec3d680b3 Steven Rostedt (Google      2022-08-20  444) 		val = (unsigned long)code->data;
6a832ec3d680b3 Steven Rostedt (Google      2022-08-20  445) 		break;
6a832ec3d680b3 Steven Rostedt (Google      2022-08-20  446) 	case FETCH_NOP_SYMBOL:	/* Ignore a place holder */
6a832ec3d680b3 Steven Rostedt (Google      2022-08-20  447) 		code++;
6a832ec3d680b3 Steven Rostedt (Google      2022-08-20  448) 		goto retry;
6a832ec3d680b3 Steven Rostedt (Google      2022-08-20  449) 	default:
6a832ec3d680b3 Steven Rostedt (Google      2022-08-20  450) 		return -EILSEQ;
6a832ec3d680b3 Steven Rostedt (Google      2022-08-20  451) 	}
6a832ec3d680b3 Steven Rostedt (Google      2022-08-20  452) 	code++;
6a832ec3d680b3 Steven Rostedt (Google      2022-08-20  453) 	return process_fetch_insn_bottom(code, val, dest, base);
7491e2c442781a Tzvetomir Stoyanov (VMware  2021-08-19  454) }
7491e2c442781a Tzvetomir Stoyanov (VMware  2021-08-19  455) NOKPROBE_SYMBOL(process_fetch_insn)
7491e2c442781a Tzvetomir Stoyanov (VMware  2021-08-19  456) 

:::::: The code at line 427 was first introduced by commit
:::::: 7491e2c442781a1860181adb5ab472a52075f393 tracing: Add a probe that attaches to trace events

:::::: TO: Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
:::::: CC: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
