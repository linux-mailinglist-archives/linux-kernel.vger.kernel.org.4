Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79E7068CAB4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 00:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbjBFXmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 18:42:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjBFXm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 18:42:29 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A8562448F
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 15:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675726945; x=1707262945;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=URrdhd4/W7Mg25YmjYNxLbJ2RsxAcpE2rCNjB8T6Zp0=;
  b=AkH/NbgFbktbfay/xN+0CZ9YrVKWTxagFn1iZ2tI3wFmyYqGbO3kG1vB
   D16fMpbeqgXze0yOUHAp2RPsMWvg/xZMECVGSRK85wJfORDI/6DlmouNB
   J+7rbMv6xJ/YtWrt+vyDemR85uifhodtzyhwKHmaDHNhEvvlI24+wDCFj
   AJXIDUu7hnk/GMYIGFXXWTwS7t+nl+hlVHsAMxE0oNOmTVUWm1of9rP42
   N/I+/rTRAlw+dCoQshConGbtI3VRjHTcFpGctTzDFaopltzyCFockBGgl
   kXF2w2tIOoYXta4bPiuC3uA2v0ILFFXTwRp4vANBzvRUMDTvxmkF0uoSB
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="308991862"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="308991862"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 15:42:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="697038978"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="697038978"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 06 Feb 2023 15:42:23 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pPB7u-0002s6-1h;
        Mon, 06 Feb 2023 23:42:22 +0000
Date:   Tue, 7 Feb 2023 07:41:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: [tip:x86/vdso 3/4] arch/x86/entry/vdso/vdso32/../vgetcpu.c:13:1:
 warning: no previous prototype for '__vdso_getcpu'
Message-ID: <202302070742.iYcnoJwk-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/vdso
head:   5646bbd6684acf5c9b9dedb863b7d2f6f5a330fb
commit: 92d33063c081a82d25dd08a9cce03947c8ed9164 [3/4] x86/vdso: Provide getcpu for x86-32.
config: x86_64-rhel-8.3-kselftests (https://download.01.org/0day-ci/archive/20230207/202302070742.iYcnoJwk-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=92d33063c081a82d25dd08a9cce03947c8ed9164
        git remote add tip https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
        git fetch --no-tags tip x86/vdso
        git checkout 92d33063c081a82d25dd08a9cce03947c8ed9164
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 olddefconfig
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/entry/vdso/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from arch/x86/entry/vdso/vdso32/vgetcpu.c:2:
>> arch/x86/entry/vdso/vdso32/../vgetcpu.c:13:1: warning: no previous prototype for '__vdso_getcpu' [-Wmissing-prototypes]
      13 | __vdso_getcpu(unsigned *cpu, unsigned *node, struct getcpu_cache *unused)
         | ^~~~~~~~~~~~~


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
