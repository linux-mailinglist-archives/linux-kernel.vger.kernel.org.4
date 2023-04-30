Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6006F296A
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Apr 2023 17:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjD3Psp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 11:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjD3Psn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 11:48:43 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A1E26A9
        for <linux-kernel@vger.kernel.org>; Sun, 30 Apr 2023 08:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682869722; x=1714405722;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dZqkRh5o849PejBMLlgURL1sHxT5dBczJ6a9ndFeQHY=;
  b=BN65fPfuvkcn6WU2jspBqp+3y2lk+pjw/CDEou6jZMATt4igMvE0Ocd9
   eDGeoKd9cmxgJeK+CZzc7MgbBNO9DX64aeSzw6uhlDGzvzWuJxjNq70lh
   1HWv/e17sRPmC/lXelk00bxoSgByKYOHzaz2K7ld4BFU0x1bw2gPAmtji
   a5UiqYpYbUptMznr7flxhmylPQqqLzj0Rxz0sgQwjEzpGOIh22h8eD8qB
   DK5/a1korg+TDTbUTCbK8qmZIOGDfDMIdxB65so4GQ27VnKY4A67eb3ZE
   IfMlvujHFwcCSR1fiWXFbnHBmndY+wpR6H+fbMX69fb9IjcXyzK8YUXgH
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10696"; a="345504210"
X-IronPort-AV: E=Sophos;i="5.99,239,1677571200"; 
   d="scan'208";a="345504210"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2023 08:48:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10696"; a="839597913"
X-IronPort-AV: E=Sophos;i="5.99,239,1677571200"; 
   d="scan'208";a="839597913"
Received: from lkp-server01.sh.intel.com (HELO e3434d64424d) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 30 Apr 2023 08:48:40 -0700
Received: from kbuild by e3434d64424d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pt9Hz-00001b-1F;
        Sun, 30 Apr 2023 15:48:39 +0000
Date:   Sun, 30 Apr 2023 23:47:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: arch/x86/entry/vdso/vdso32/../vgetcpu.c:13:1: error: no previous
 prototype for '__vdso_getcpu'
Message-ID: <202304302304.LTYndwk9-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   825a0714d2b3883d4f8ff64f6933fb73ee3f1834
commit: 92d33063c081a82d25dd08a9cce03947c8ed9164 x86/vdso: Provide getcpu for x86-32.
date:   3 months ago
config: x86_64-sof-customedconfig-edison-defconfig (https://download.01.org/0day-ci/archive/20230430/202304302304.LTYndwk9-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
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
| Link: https://lore.kernel.org/oe-kbuild-all/202304302304.LTYndwk9-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/x86/entry/vdso/vdso32/vgetcpu.c:2:
>> arch/x86/entry/vdso/vdso32/../vgetcpu.c:13:1: error: no previous prototype for '__vdso_getcpu' [-Werror=missing-prototypes]
      13 | __vdso_getcpu(unsigned *cpu, unsigned *node, struct getcpu_cache *unused)
         | ^~~~~~~~~~~~~
   cc1: all warnings being treated as errors


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
