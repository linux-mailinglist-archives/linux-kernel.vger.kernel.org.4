Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5E76F0DD2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 23:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjD0Vvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 17:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjD0Vvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 17:51:31 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A332D5B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 14:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682632289; x=1714168289;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qDKdvAGKI0QcCEwsSQB+6XQop7gFpkd98PF2ePrKY4M=;
  b=X7Nzg1CgWegehuilXgxPAHCe/d0OzfA7S2AK3wFVq6IQVbcpvyoI6hcQ
   nCgXimsLNCEfoXIaqDr6uCTJSFqcSJxeaPrrXztsRY1nGBoCNS4z196ZH
   aqBarc+E1JNbxGOqFozVuuRCv6ztPlBakpWUufooNbSEQHkfBbSxlknP8
   u+liU+kJhNVdKIPP4qNUBqgLsiq87PxKriwfInKIEnqnbVPwMa88yp/Ep
   pWYpGTaaFrWZ85dl9ayEpfJO7qIpogeMgV2EkaNpE5NsPv4RIjKj/Od2U
   8pCFDOnI1XcQA7fuae13nnJSN7PXWPT5JCZgm89f+N1+FDlEkz7fe/XDQ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="346345782"
X-IronPort-AV: E=Sophos;i="5.99,232,1677571200"; 
   d="scan'208";a="346345782"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2023 14:51:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="868892637"
X-IronPort-AV: E=Sophos;i="5.99,232,1677571200"; 
   d="scan'208";a="868892637"
Received: from lkp-server01.sh.intel.com (HELO b95e16499b55) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 27 Apr 2023 14:51:28 -0700
Received: from kbuild by b95e16499b55 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ps9WR-000097-19;
        Thu, 27 Apr 2023 21:51:27 +0000
Date:   Fri, 28 Apr 2023 05:50:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [paulmck-rcu:dev.2023.04.26b 35/53] arch/mips/kernel/process.c:46:1:
 warning: 'noreturn' function does return
Message-ID: <202304280553.ZsGndQkE-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2023.04.26b
head:   fcaa8c6ca41362484ff84124f7fd8929739eef45
commit: 2b927bfdda366c1719e021cd0e9688baf933c9cf [35/53] objtool: Fix for unreachable instruction warning
config: mips-randconfig-r012-20230427 (https://download.01.org/0day-ci/archive/20230428/202304280553.ZsGndQkE-lkp@intel.com/config)
compiler: mipsel-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/commit/?id=2b927bfdda366c1719e021cd0e9688baf933c9cf
        git remote add paulmck-rcu https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
        git fetch --no-tags paulmck-rcu dev.2023.04.26b
        git checkout 2b927bfdda366c1719e021cd0e9688baf933c9cf
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=mips olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash arch/mips/kernel/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304280553.ZsGndQkE-lkp@intel.com/

All warnings (new ones prefixed by >>):

   arch/mips/kernel/process.c: In function 'arch_cpu_idle_dead':
>> arch/mips/kernel/process.c:46:1: warning: 'noreturn' function does return
      46 | }
         | ^


vim +/noreturn +46 arch/mips/kernel/process.c

^1da177e4c3f41 Linus Torvalds  2005-04-16  41  
cdbedc61c8d012 Thomas Gleixner 2013-03-21  42  #ifdef CONFIG_HOTPLUG_CPU
cdbedc61c8d012 Thomas Gleixner 2013-03-21  43  void arch_cpu_idle_dead(void)
^1da177e4c3f41 Linus Torvalds  2005-04-16  44  {
cdbedc61c8d012 Thomas Gleixner 2013-03-21  45  	play_dead();
cdbedc61c8d012 Thomas Gleixner 2013-03-21 @46  }
cdbedc61c8d012 Thomas Gleixner 2013-03-21  47  #endif
1b2bc75c1bde65 Ralf Baechle    2009-06-23  48  

:::::: The code at line 46 was first introduced by commit
:::::: cdbedc61c8d0122ad682815936f0d11df1fe5f57 mips: Use generic idle loop

:::::: TO: Thomas Gleixner <tglx@linutronix.de>
:::::: CC: Thomas Gleixner <tglx@linutronix.de>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
