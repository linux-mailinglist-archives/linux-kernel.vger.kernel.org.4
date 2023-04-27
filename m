Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 235B16F00CD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 08:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243023AbjD0G2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 02:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243016AbjD0G2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 02:28:20 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 388181988
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 23:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682576898; x=1714112898;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9LKCA0IQASiMVP4MmY4V3jFMfURVW5tMG3Z+ri8Kk1g=;
  b=Cf8nd0/7GVCbZX4bzGMWBWeA4WCyWwABFAuW9ODPuPCxXnNWwkqVIpvi
   yexUTmIDM5qI7U3+0AKAf76tXcAqBd8Jsg9XUBJwCxxtl4cshiRCxu6ya
   ETAuASbSrIkvOnwpdWqG2/Ddk5QjBSXSxU7vOIBGq5oC4Yau0YgEQOVEx
   FHdjXCgSkuW0t3wLsKg/L1mdZuQTy3J6ndfBk63wNo6YPbwfBfhRqH6jM
   DJqcvYJBAE8qpwvkea/4+a48xsXNkQhAtMJFlw6jsT6C9ZIpK4kgnGtIL
   oApbPZHWGd0pw1POkPypfUBU7KP41ygwQOlpbHCS2B1cc6iMemzkFuhk3
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="331592964"
X-IronPort-AV: E=Sophos;i="5.99,230,1677571200"; 
   d="scan'208";a="331592964"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2023 23:28:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="644561414"
X-IronPort-AV: E=Sophos;i="5.99,230,1677571200"; 
   d="scan'208";a="644561414"
Received: from lkp-server01.sh.intel.com (HELO 1e0e07564161) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 26 Apr 2023 23:28:15 -0700
Received: from kbuild by 1e0e07564161 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1prv70-00003A-1d;
        Thu, 27 Apr 2023 06:28:14 +0000
Date:   Thu, 27 Apr 2023 14:27:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [paulmck-rcu:dev.2023.04.26a 35/51]
 arch/loongarch/kernel/process.c:68:1: warning: 'noreturn' function does
 return
Message-ID: <202304271412.cbmTIpbf-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2023.04.26a
head:   56b38a90a12f76e463a7381d8cff854926fa2b59
commit: 2b927bfdda366c1719e021cd0e9688baf933c9cf [35/51] objtool: Fix for unreachable instruction warning
config: loongarch-randconfig-r012-20230427 (https://download.01.org/0day-ci/archive/20230427/202304271412.cbmTIpbf-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/commit/?id=2b927bfdda366c1719e021cd0e9688baf933c9cf
        git remote add paulmck-rcu https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
        git fetch --no-tags paulmck-rcu dev.2023.04.26a
        git checkout 2b927bfdda366c1719e021cd0e9688baf933c9cf
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=loongarch olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=loongarch SHELL=/bin/bash arch/loongarch/kernel/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304271412.cbmTIpbf-lkp@intel.com/

All warnings (new ones prefixed by >>):

   arch/loongarch/kernel/process.c:109:5: warning: no previous prototype for 'arch_dup_task_struct' [-Wmissing-prototypes]
     109 | int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
         |     ^~~~~~~~~~~~~~~~~~~~
   arch/loongarch/kernel/process.c:301:15: warning: no previous prototype for 'arch_align_stack' [-Wmissing-prototypes]
     301 | unsigned long arch_align_stack(unsigned long sp)
         |               ^~~~~~~~~~~~~~~~
   arch/loongarch/kernel/process.c: In function 'arch_cpu_idle_dead':
>> arch/loongarch/kernel/process.c:68:1: warning: 'noreturn' function does return
      68 | }
         | ^


vim +/noreturn +68 arch/loongarch/kernel/process.c

803b0fc5c3f2ba Huacai Chen 2022-05-31  63  
46859ac8af52ae Huacai Chen 2022-05-31  64  #ifdef CONFIG_HOTPLUG_CPU
46859ac8af52ae Huacai Chen 2022-05-31  65  void arch_cpu_idle_dead(void)
46859ac8af52ae Huacai Chen 2022-05-31  66  {
46859ac8af52ae Huacai Chen 2022-05-31  67  	play_dead();
46859ac8af52ae Huacai Chen 2022-05-31 @68  }
46859ac8af52ae Huacai Chen 2022-05-31  69  #endif
46859ac8af52ae Huacai Chen 2022-05-31  70  

:::::: The code at line 68 was first introduced by commit
:::::: 46859ac8af52ae599e1b51992ddef3eb43f295fc LoongArch: Add multi-processor (SMP) support

:::::: TO: Huacai Chen <chenhuacai@loongson.cn>
:::::: CC: Huacai Chen <chenhuacai@loongson.cn>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
