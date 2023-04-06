Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08E2B6D9BFF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 17:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239719AbjDFPRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 11:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238857AbjDFPRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 11:17:07 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EEFC9ECE
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 08:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680794220; x=1712330220;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=s4/hpkakGhYEo4d6+c5FNnmXhVmCCSszbyT4HssTgVs=;
  b=now6eWfeSjREDeOjqfie3E2pGBnutQuuPRby02eix2BaEO2umZTwug7W
   UUqmo9/Jixp9NXbtfGzKGUHH8W+0uUctkdQDhAeTMojoxwONbs03BykD6
   C0zMt1RORI7u8NBMss85bWhzp7dSC++1pdOMvrYkd5TeUyxTc0bWpC6Qh
   O5NgjEaISWlNkp4359sjeS0KMRfIdtqBUOFPWD/LHjrKtQua2iY4rbBTj
   +nzBVVJVAM7iiIstuMpz044AucDomq1Igt9++5oAi0LiXJwElVfSkk4Bc
   BnZsnJWlnpwi2AmuifpTMDHLskdk4rZXbOXkY8U1nrWdNaNdQxg8ENJb/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10672"; a="370592082"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400"; 
   d="scan'208";a="370592082"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2023 08:16:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10672"; a="687179616"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400"; 
   d="scan'208";a="687179616"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 06 Apr 2023 08:16:56 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pkRM8-000RSs-0W;
        Thu, 06 Apr 2023 15:16:56 +0000
Date:   Thu, 6 Apr 2023 23:16:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>
Subject: [tip:sched/core 7/13] kernel/sched/core.c:8677:1: sparse: sparse:
 symbol 'sched_dynamic_mutex' was not declared. Should it be static?
Message-ID: <202304062335.tNuUjgsl-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
head:   d82caa273565b45fcf103148950549af76c314b0
commit: e3ff7c609f39671d1aaff4fb4a8594e14f3e03f8 [7/13] livepatch,sched: Add livepatch task switching to cond_resched()
config: arm64-randconfig-s053-20230406 (https://download.01.org/0day-ci/archive/20230406/202304062335.tNuUjgsl-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=e3ff7c609f39671d1aaff4fb4a8594e14f3e03f8
        git remote add tip https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
        git fetch --no-tags tip sched/core
        git checkout e3ff7c609f39671d1aaff4fb4a8594e14f3e03f8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/remoteproc/ kernel/sched/ lib/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304062335.tNuUjgsl-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   kernel/sched/core.c:791:48: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:791:48: sparse:     expected struct task_struct *p
   kernel/sched/core.c:791:48: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:1038:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *curr @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:1038:38: sparse:     expected struct task_struct *curr
   kernel/sched/core.c:1038:38: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:1096:9: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/core.c:1096:9: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/core.c:1096:9: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/core.c:2202:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:2202:33: sparse:     expected struct task_struct *p
   kernel/sched/core.c:2202:33: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:2202:68: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *tsk @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:2202:68: sparse:     expected struct task_struct *tsk
   kernel/sched/core.c:2202:68: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:3674:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/core.c:3674:17: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/core.c:3674:17: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/core.c:3881:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct const *p @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:3881:28: sparse:     expected struct task_struct const *p
   kernel/sched/core.c:3881:28: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:9401:43: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *push_task @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:9401:43: sparse:     expected struct task_struct *push_task
   kernel/sched/core.c:9401:43: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:5582:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *curr @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:5582:38: sparse:     expected struct task_struct *curr
   kernel/sched/core.c:5582:38: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:6536:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *prev @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:6536:14: sparse:     expected struct task_struct *prev
   kernel/sched/core.c:6536:14: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:7062:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/core.c:7062:17: sparse:    struct task_struct *
   kernel/sched/core.c:7062:17: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/core.c:7278:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/core.c:7278:22: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/core.c:7278:22: sparse:    struct task_struct *
>> kernel/sched/core.c:8677:1: sparse: sparse: symbol 'sched_dynamic_mutex' was not declared. Should it be static?
   kernel/sched/core.c:11419:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:11419:25: sparse:     expected struct task_struct *p
   kernel/sched/core.c:11419:25: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:547:6: sparse: sparse: context imbalance in 'raw_spin_rq_lock_nested' - wrong count at exit
   kernel/sched/core.c:572:6: sparse: sparse: context imbalance in 'raw_spin_rq_trylock' - wrong count at exit
   kernel/sched/core.c:596:6: sparse: sparse: context imbalance in 'raw_spin_rq_unlock' - unexpected unlock
   kernel/sched/core.c: note: in included file:
   kernel/sched/sched.h:1582:9: sparse: sparse: context imbalance in '__task_rq_lock' - wrong count at exit
   kernel/sched/sched.h:1582:9: sparse: sparse: context imbalance in 'task_rq_lock' - wrong count at exit
   kernel/sched/core.c: note: in included file:
   kernel/sched/pelt.h:97:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct const *p @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/pelt.h:97:13: sparse:     expected struct task_struct const *p
   kernel/sched/pelt.h:97:13: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:791:11: sparse: sparse: dereference of noderef expression
   kernel/sched/core.c:2193:33: sparse: sparse: dereference of noderef expression
   kernel/sched/core.c:2194:19: sparse: sparse: dereference of noderef expression
   kernel/sched/core.c:2195:18: sparse: sparse: dereference of noderef expression
   kernel/sched/core.c: note: in included file:
   kernel/sched/sched.h:2073:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2073:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2073:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2235:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2235:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2235:9: sparse:    struct task_struct *
   kernel/sched/core.c:2168:38: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/core.c:2168:38: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/core.c:2168:38: sparse:    struct task_struct const *
   kernel/sched/sched.h:2073:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2073:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2073:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2235:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2235:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2235:9: sparse:    struct task_struct *
   kernel/sched/sched.h:2235:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2235:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2235:9: sparse:    struct task_struct *
   kernel/sched/sched.h:2073:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2073:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2073:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2235:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2235:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2235:9: sparse:    struct task_struct *
   kernel/sched/sched.h:2073:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2073:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2073:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2235:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2235:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2235:9: sparse:    struct task_struct *
   kernel/sched/sched.h:2073:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2073:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2073:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2235:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2235:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2235:9: sparse:    struct task_struct *
   kernel/sched/sched.h:2073:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2073:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2073:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2235:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2235:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2235:9: sparse:    struct task_struct *

vim +/sched_dynamic_mutex +8677 kernel/sched/core.c

  8676	
> 8677	DEFINE_MUTEX(sched_dynamic_mutex);
  8678	static bool klp_override;
  8679	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
