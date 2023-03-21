Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 692196C3B9A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 21:19:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbjCUUTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 16:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjCUUTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 16:19:39 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDF9744A3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 13:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679429924; x=1710965924;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=HjODDlc6QV5JvzadG8RMnb0NNVEv1mmgEwwUjjJ+V/s=;
  b=gmp50rA+vB8kZAzwaB28x7DXN0D0DAzK1m7t9beas2zMwGrbW/Yxr82z
   saI7qWuvDFGEj4APkztOFQvKDC0qropGWw43rXg/avnSAYYVscefF3H20
   iOjfNRBYJGLkoE/JGS/bzCf/sdrXtF6XTSs9miabzrGi/5okT4E6lA7Yk
   TNSFN1N/2wbwNnmDU/A6uh7PpRSz8oXXI9F04mf3cEvt8T8gnz3k0U/1N
   CJfxfaERuq7e7fPRHHEnVgBjgBtWN98h87IcoaJhODsgzh6ZjB0+OBtRs
   xPoe5bMPIKVwtxgLnfLFAPvZZR7u+nl0auuGiiOgzm7BfB819SWUxcbqx
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="339090457"
X-IronPort-AV: E=Sophos;i="5.98,279,1673942400"; 
   d="scan'208";a="339090457"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 13:17:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="805551711"
X-IronPort-AV: E=Sophos;i="5.98,279,1673942400"; 
   d="scan'208";a="805551711"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 21 Mar 2023 13:17:57 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1peiQZ-000CNI-2s;
        Tue, 21 Mar 2023 20:17:51 +0000
Date:   Wed, 22 Mar 2023 04:17:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Xiaoming Ni <nixiaoming@huawei.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: kernel/stackleak.c:33:50: sparse: sparse: incorrect type in argument
 3 (different address spaces)
Message-ID: <202303220449.l6Q32ILq-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2faac9a98f010cf5b342fa89ac489c4586364e6e
commit: 0df8bdd5e3b3e557ce2c2575fce0c64c5dd1045a stackleak: move stack_erasing sysctl to stackleak.c
date:   1 year, 2 months ago
config: arm64-randconfig-s032-20230321 (https://download.01.org/0day-ci/archive/20230322/202303220449.l6Q32ILq-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0df8bdd5e3b3e557ce2c2575fce0c64c5dd1045a
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 0df8bdd5e3b3e557ce2c2575fce0c64c5dd1045a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303220449.l6Q32ILq-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> kernel/stackleak.c:33:50: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected void * @@     got void [noderef] __user *buffer @@
   kernel/stackleak.c:33:50: sparse:     expected void *
   kernel/stackleak.c:33:50: sparse:     got void [noderef] __user *buffer
>> kernel/stackleak.c:53:35: sparse: sparse: incorrect type in initializer (incompatible argument 3 (different address spaces)) @@     expected int ( [usertype] *proc_handler )( ... ) @@     got int ( * )( ... ) @@
   kernel/stackleak.c:53:35: sparse:     expected int ( [usertype] *proc_handler )( ... )
   kernel/stackleak.c:53:35: sparse:     got int ( * )( ... )

vim +33 kernel/stackleak.c

964c9dff0091893 Alexander Popov 2018-08-17  22  
0df8bdd5e3b3e55 Xiaoming Ni     2022-01-21  23  #ifdef CONFIG_SYSCTL
0df8bdd5e3b3e55 Xiaoming Ni     2022-01-21  24  static int stack_erasing_sysctl(struct ctl_table *table, int write,
0df8bdd5e3b3e55 Xiaoming Ni     2022-01-21  25  			void __user *buffer, size_t *lenp, loff_t *ppos)
964c9dff0091893 Alexander Popov 2018-08-17  26  {
964c9dff0091893 Alexander Popov 2018-08-17  27  	int ret = 0;
964c9dff0091893 Alexander Popov 2018-08-17  28  	int state = !static_branch_unlikely(&stack_erasing_bypass);
964c9dff0091893 Alexander Popov 2018-08-17  29  	int prev_state = state;
964c9dff0091893 Alexander Popov 2018-08-17  30  
964c9dff0091893 Alexander Popov 2018-08-17  31  	table->data = &state;
964c9dff0091893 Alexander Popov 2018-08-17  32  	table->maxlen = sizeof(int);
964c9dff0091893 Alexander Popov 2018-08-17 @33  	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
964c9dff0091893 Alexander Popov 2018-08-17  34  	state = !!state;
964c9dff0091893 Alexander Popov 2018-08-17  35  	if (ret || !write || state == prev_state)
964c9dff0091893 Alexander Popov 2018-08-17  36  		return ret;
964c9dff0091893 Alexander Popov 2018-08-17  37  
964c9dff0091893 Alexander Popov 2018-08-17  38  	if (state)
964c9dff0091893 Alexander Popov 2018-08-17  39  		static_branch_disable(&stack_erasing_bypass);
964c9dff0091893 Alexander Popov 2018-08-17  40  	else
964c9dff0091893 Alexander Popov 2018-08-17  41  		static_branch_enable(&stack_erasing_bypass);
964c9dff0091893 Alexander Popov 2018-08-17  42  
964c9dff0091893 Alexander Popov 2018-08-17  43  	pr_warn("stackleak: kernel stack erasing is %s\n",
964c9dff0091893 Alexander Popov 2018-08-17  44  					state ? "enabled" : "disabled");
964c9dff0091893 Alexander Popov 2018-08-17  45  	return ret;
964c9dff0091893 Alexander Popov 2018-08-17  46  }
0df8bdd5e3b3e55 Xiaoming Ni     2022-01-21  47  static struct ctl_table stackleak_sysctls[] = {
0df8bdd5e3b3e55 Xiaoming Ni     2022-01-21  48  	{
0df8bdd5e3b3e55 Xiaoming Ni     2022-01-21  49  		.procname	= "stack_erasing",
0df8bdd5e3b3e55 Xiaoming Ni     2022-01-21  50  		.data		= NULL,
0df8bdd5e3b3e55 Xiaoming Ni     2022-01-21  51  		.maxlen		= sizeof(int),
0df8bdd5e3b3e55 Xiaoming Ni     2022-01-21  52  		.mode		= 0600,
0df8bdd5e3b3e55 Xiaoming Ni     2022-01-21 @53  		.proc_handler	= stack_erasing_sysctl,
0df8bdd5e3b3e55 Xiaoming Ni     2022-01-21  54  		.extra1		= SYSCTL_ZERO,
0df8bdd5e3b3e55 Xiaoming Ni     2022-01-21  55  		.extra2		= SYSCTL_ONE,
0df8bdd5e3b3e55 Xiaoming Ni     2022-01-21  56  	},
0df8bdd5e3b3e55 Xiaoming Ni     2022-01-21  57  	{}
0df8bdd5e3b3e55 Xiaoming Ni     2022-01-21  58  };
0df8bdd5e3b3e55 Xiaoming Ni     2022-01-21  59  

:::::: The code at line 33 was first introduced by commit
:::::: 964c9dff0091893a9a74a88edf984c6da0b779f7 stackleak: Allow runtime disabling of kernel stack erasing

:::::: TO: Alexander Popov <alex.popov@linux.com>
:::::: CC: Kees Cook <keescook@chromium.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
