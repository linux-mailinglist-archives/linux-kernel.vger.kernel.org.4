Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97B246D15F4
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 05:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbjCaDXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 23:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjCaDXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 23:23:24 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC4F2B3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 20:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680233003; x=1711769003;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=FHeqoCfyEo2zGt5byWFolwR2+nLbLafxGYsHyOAYIpc=;
  b=d8HSBAUFXYw52NkvcBySad6erDLXgzNRvlknvTFlT9MnwTy9BDNPMzB7
   0Ww6URs8vIlkmdIkO4aDw5DZz7PEX/zhcmIGVmBlpK9s2P7CqFM+uMRNY
   bLQHU7a3QWqSbzf3wn3f+yDSfbOCURP672pKqpPcRvLn6fdSZ0UmLm8z2
   4HkOi8M4eaPmLGjIulda8c4XatPB+KtAZ65yZvsKjDFs5k7OHWhymdKMA
   uFP+amUtV6QUP1zO5BItk0gIX0ifisuAFqLXBsJXHtoa26ULTK+g6/SHi
   olL0ZE0hWuM3LMVsb8Irha+Z22Q3plV0/uXfAKo8h8sLzRT8GFsM2xPfm
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="320994753"
X-IronPort-AV: E=Sophos;i="5.98,306,1673942400"; 
   d="scan'208";a="320994753"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 20:23:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="717557683"
X-IronPort-AV: E=Sophos;i="5.98,306,1673942400"; 
   d="scan'208";a="717557683"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 30 Mar 2023 20:23:21 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pi5MG-000LSC-2N;
        Fri, 31 Mar 2023 03:23:20 +0000
Date:   Fri, 31 Mar 2023 11:23:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: arch/x86/entry/vdso/vdso32/../vgetcpu.c:13:1: error: no previous
 prototype for '__vdso_getcpu'
Message-ID: <202303311104.UfM3VgM1-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   62bad54b26db8bc98e28749cd76b2d890edb4258
commit: 92d33063c081a82d25dd08a9cce03947c8ed9164 x86/vdso: Provide getcpu for x86-32.
date:   8 weeks ago
config: x86_64-sof-customedconfig-edison-defconfig (https://download.01.org/0day-ci/archive/20230331/202303311104.UfM3VgM1-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=92d33063c081a82d25dd08a9cce03947c8ed9164
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 92d33063c081a82d25dd08a9cce03947c8ed9164
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 olddefconfig
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303311104.UfM3VgM1-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/x86/entry/vdso/vdso32/vgetcpu.c:2:
>> arch/x86/entry/vdso/vdso32/../vgetcpu.c:13:1: error: no previous prototype for '__vdso_getcpu' [-Werror=missing-prototypes]
      13 | __vdso_getcpu(unsigned *cpu, unsigned *node, struct getcpu_cache *unused)
         | ^~~~~~~~~~~~~
   cc1: all warnings being treated as errors


vim +/__vdso_getcpu +13 arch/x86/entry/vdso/vdso32/../vgetcpu.c

2aae950b21e4bc7 arch/x86_64/vdso/vgetcpu.c    Andi Kleen     2007-07-21  11  
23adec554a7648f arch/x86/vdso/vgetcpu.c       Steven Rostedt 2008-05-12  12  notrace long
23adec554a7648f arch/x86/vdso/vgetcpu.c       Steven Rostedt 2008-05-12 @13  __vdso_getcpu(unsigned *cpu, unsigned *node, struct getcpu_cache *unused)
2aae950b21e4bc7 arch/x86_64/vdso/vgetcpu.c    Andi Kleen     2007-07-21  14  {
22245bdf0ad805d arch/x86/entry/vdso/vgetcpu.c Ingo Molnar    2018-10-08  15  	vdso_read_cpunode(cpu, node);
ec3a94188df7d28 arch/x86/entry/vdso/vgetcpu.c Ingo Molnar    2018-10-08  16  
2aae950b21e4bc7 arch/x86_64/vdso/vgetcpu.c    Andi Kleen     2007-07-21  17  	return 0;
2aae950b21e4bc7 arch/x86_64/vdso/vgetcpu.c    Andi Kleen     2007-07-21  18  }
2aae950b21e4bc7 arch/x86_64/vdso/vgetcpu.c    Andi Kleen     2007-07-21  19  

:::::: The code at line 13 was first introduced by commit
:::::: 23adec554a7648f99c8acc0caf49c66320cd2b84 x86: add notrace annotations to vsyscall.

:::::: TO: Steven Rostedt <srostedt@redhat.com>
:::::: CC: Thomas Gleixner <tglx@linutronix.de>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
