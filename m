Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D39956F0C9F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 21:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245044AbjD0Tfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 15:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245035AbjD0Tfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 15:35:32 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19FA62712
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 12:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682624128; x=1714160128;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=QNXXbxAfYh4C+5lqOIiMDqUc4LiqdHH8E3qjvQLuzcg=;
  b=Qfd9T/OuNIoCl/S9X/l35Dk78//vGxCTkVtQ6t05wDuF68LUcp9tkX4F
   z7+RmNGcMrZndqN1rBPRd40HDS3J63Foi5tauHfI0A5tJ0qvXt4ofTZHI
   XMKhcNxBKBd6nf81aOBUSH/irLZ27dDylTiJBYKS9zkuKWl9cdvUE6s3N
   sWnvn9hmO2b1O1hJwXQlrTHAKsYQH8AFOOZXHP4dc2hbfGUGLM68x3qCp
   +h1d67yhDZTj2b5i2ODhxbL0U9wOD1pAuvzuV6JPZfMXzB1t/IoIp/tEy
   YsUMx+lDaDJA9QlEPyS1rsvkdL6uadtI52aOjEorka6qaQoNBPdOYBSYc
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="345003795"
X-IronPort-AV: E=Sophos;i="5.99,232,1677571200"; 
   d="scan'208";a="345003795"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2023 12:35:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="868850709"
X-IronPort-AV: E=Sophos;i="5.99,232,1677571200"; 
   d="scan'208";a="868850709"
Received: from lkp-server01.sh.intel.com (HELO b95e16499b55) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 27 Apr 2023 12:35:25 -0700
Received: from kbuild by b95e16499b55 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ps7Om-00005l-1s;
        Thu, 27 Apr 2023 19:35:24 +0000
Date:   Fri, 28 Apr 2023 03:35:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Qing Zhang <zhangqing@loongson.cn>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Huacai Chen <chenhuacai@kernel.org>
Subject: kernel/time/tick-sched.c:1151:9: sparse: sparse: incorrect type in
 argument 1 (different address spaces)
Message-ID: <202304280318.3aZhPbxA-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   32f7ad0fbe7521de2a5e8f79c33d46110247fd7c
commit: 93a4fa622eb061f75f87f0cf9609ab4e69c67d01 LoongArch: Add STACKTRACE support
date:   9 months ago
config: loongarch-randconfig-s053-20230427 (https://download.01.org/0day-ci/archive/20230428/202304280318.3aZhPbxA-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=93a4fa622eb061f75f87f0cf9609ab4e69c67d01
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 93a4fa622eb061f75f87f0cf9609ab4e69c67d01
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=loongarch olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=loongarch SHELL=/bin/bash drivers/soc/qcom/ kernel/time/ net/core/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304280318.3aZhPbxA-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> kernel/time/tick-sched.c:1151:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/time/tick-sched.c:1151:9: sparse:     expected void *ptr
   kernel/time/tick-sched.c:1151:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/time/tick-sched.c:1151:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/time/tick-sched.c:1151:9: sparse:     expected void *ptr
   kernel/time/tick-sched.c:1151:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/time/tick-sched.c:1151:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/time/tick-sched.c:1151:9: sparse:     expected void *ptr
   kernel/time/tick-sched.c:1151:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/time/tick-sched.c:1151:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/time/tick-sched.c:1151:9: sparse:     expected void *ptr
   kernel/time/tick-sched.c:1151:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/time/tick-sched.c:1151:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/time/tick-sched.c:1151:9: sparse:     expected void *ptr
   kernel/time/tick-sched.c:1151:9: sparse:     got int [noderef] __percpu *
>> kernel/time/tick-sched.c:1151:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/time/tick-sched.c:1151:9: sparse:     expected void *ptr
   kernel/time/tick-sched.c:1151:9: sparse:     got int [noderef] __percpu *
>> kernel/time/tick-sched.c:1151:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/time/tick-sched.c:1151:9: sparse:     expected void *ptr
   kernel/time/tick-sched.c:1151:9: sparse:     got int [noderef] __percpu *
>> kernel/time/tick-sched.c:1151:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/time/tick-sched.c:1151:9: sparse:     expected void *ptr
   kernel/time/tick-sched.c:1151:9: sparse:     got int [noderef] __percpu *
--
>> drivers/soc/qcom/rpmh.c:441:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   drivers/soc/qcom/rpmh.c:441:9: sparse:     expected void *ptr
   drivers/soc/qcom/rpmh.c:441:9: sparse:     got unsigned int [noderef] __percpu *
>> drivers/soc/qcom/rpmh.c:441:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   drivers/soc/qcom/rpmh.c:441:9: sparse:     expected void *ptr
   drivers/soc/qcom/rpmh.c:441:9: sparse:     got unsigned int [noderef] __percpu *
>> drivers/soc/qcom/rpmh.c:441:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   drivers/soc/qcom/rpmh.c:441:9: sparse:     expected void *ptr
   drivers/soc/qcom/rpmh.c:441:9: sparse:     got unsigned int [noderef] __percpu *
>> drivers/soc/qcom/rpmh.c:441:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   drivers/soc/qcom/rpmh.c:441:9: sparse:     expected void *ptr
   drivers/soc/qcom/rpmh.c:441:9: sparse:     got unsigned int [noderef] __percpu *
>> drivers/soc/qcom/rpmh.c:441:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   drivers/soc/qcom/rpmh.c:441:9: sparse:     expected void *ptr
   drivers/soc/qcom/rpmh.c:441:9: sparse:     got int [noderef] __percpu *
>> drivers/soc/qcom/rpmh.c:441:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   drivers/soc/qcom/rpmh.c:441:9: sparse:     expected void *ptr
   drivers/soc/qcom/rpmh.c:441:9: sparse:     got int [noderef] __percpu *
>> drivers/soc/qcom/rpmh.c:441:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   drivers/soc/qcom/rpmh.c:441:9: sparse:     expected void *ptr
   drivers/soc/qcom/rpmh.c:441:9: sparse:     got int [noderef] __percpu *
>> drivers/soc/qcom/rpmh.c:441:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   drivers/soc/qcom/rpmh.c:441:9: sparse:     expected void *ptr
   drivers/soc/qcom/rpmh.c:441:9: sparse:     got int [noderef] __percpu *
--
   net/core/dev.c:3325:23: sparse: sparse: incorrect type in argument 4 (different base types) @@     expected restricted __wsum [usertype] csum @@     got unsigned int @@
   net/core/dev.c:3325:23: sparse:     expected restricted __wsum [usertype] csum
   net/core/dev.c:3325:23: sparse:     got unsigned int
   net/core/dev.c:3325:23: sparse: sparse: cast from restricted __wsum
   net/core/dev.c:204:9: sparse: sparse: context imbalance in 'unlist_netdevice' - different lock contexts for basic block
   net/core/dev.c:3829:17: sparse: sparse: context imbalance in '__dev_queue_xmit' - different lock contexts for basic block
   net/core/dev.c:5056:17: sparse: sparse: context imbalance in 'net_tx_action' - different lock contexts for basic block
>> net/core/dev.c:4348:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   net/core/dev.c:4348:9: sparse:     expected void *ptr
   net/core/dev.c:4348:9: sparse:     got unsigned int [noderef] __percpu *
>> net/core/dev.c:4348:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   net/core/dev.c:4348:9: sparse:     expected void *ptr
   net/core/dev.c:4348:9: sparse:     got unsigned int [noderef] __percpu *
>> net/core/dev.c:4348:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   net/core/dev.c:4348:9: sparse:     expected void *ptr
   net/core/dev.c:4348:9: sparse:     got unsigned int [noderef] __percpu *
>> net/core/dev.c:4348:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   net/core/dev.c:4348:9: sparse:     expected void *ptr
   net/core/dev.c:4348:9: sparse:     got unsigned int [noderef] __percpu *
>> net/core/dev.c:4348:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   net/core/dev.c:4348:9: sparse:     expected void *ptr
   net/core/dev.c:4348:9: sparse:     got int [noderef] __percpu *
>> net/core/dev.c:4348:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   net/core/dev.c:4348:9: sparse:     expected void *ptr
   net/core/dev.c:4348:9: sparse:     got int [noderef] __percpu *
>> net/core/dev.c:4348:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   net/core/dev.c:4348:9: sparse:     expected void *ptr
   net/core/dev.c:4348:9: sparse:     got int [noderef] __percpu *
>> net/core/dev.c:4348:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   net/core/dev.c:4348:9: sparse:     expected void *ptr
   net/core/dev.c:4348:9: sparse:     got int [noderef] __percpu *
>> net/core/dev.c:4348:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   net/core/dev.c:4348:9: sparse:     expected void *ptr
   net/core/dev.c:4348:9: sparse:     got unsigned int [noderef] __percpu *
>> net/core/dev.c:4348:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   net/core/dev.c:4348:9: sparse:     expected void *ptr
   net/core/dev.c:4348:9: sparse:     got unsigned int [noderef] __percpu *
>> net/core/dev.c:4348:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   net/core/dev.c:4348:9: sparse:     expected void *ptr
   net/core/dev.c:4348:9: sparse:     got unsigned int [noderef] __percpu *
>> net/core/dev.c:4348:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   net/core/dev.c:4348:9: sparse:     expected void *ptr
   net/core/dev.c:4348:9: sparse:     got unsigned int [noderef] __percpu *
>> net/core/dev.c:4348:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   net/core/dev.c:4348:9: sparse:     expected void *ptr
   net/core/dev.c:4348:9: sparse:     got int [noderef] __percpu *
>> net/core/dev.c:4348:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   net/core/dev.c:4348:9: sparse:     expected void *ptr
   net/core/dev.c:4348:9: sparse:     got int [noderef] __percpu *
>> net/core/dev.c:4348:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   net/core/dev.c:4348:9: sparse:     expected void *ptr
   net/core/dev.c:4348:9: sparse:     got int [noderef] __percpu *
>> net/core/dev.c:4348:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   net/core/dev.c:4348:9: sparse:     expected void *ptr
   net/core/dev.c:4348:9: sparse:     got int [noderef] __percpu *
>> net/core/dev.c:4348:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   net/core/dev.c:4348:9: sparse:     expected void *ptr
   net/core/dev.c:4348:9: sparse:     got unsigned int [noderef] __percpu *
>> net/core/dev.c:4348:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   net/core/dev.c:4348:9: sparse:     expected void *ptr
   net/core/dev.c:4348:9: sparse:     got unsigned int [noderef] __percpu *
>> net/core/dev.c:4348:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   net/core/dev.c:4348:9: sparse:     expected void *ptr
   net/core/dev.c:4348:9: sparse:     got unsigned int [noderef] __percpu *
>> net/core/dev.c:4348:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   net/core/dev.c:4348:9: sparse:     expected void *ptr
   net/core/dev.c:4348:9: sparse:     got unsigned int [noderef] __percpu *
>> net/core/dev.c:4348:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   net/core/dev.c:4348:9: sparse:     expected void *ptr
   net/core/dev.c:4348:9: sparse:     got int [noderef] __percpu *
>> net/core/dev.c:4348:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   net/core/dev.c:4348:9: sparse:     expected void *ptr
   net/core/dev.c:4348:9: sparse:     got int [noderef] __percpu *
>> net/core/dev.c:4348:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   net/core/dev.c:4348:9: sparse:     expected void *ptr
   net/core/dev.c:4348:9: sparse:     got int [noderef] __percpu *
>> net/core/dev.c:4348:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   net/core/dev.c:4348:9: sparse:     expected void *ptr
   net/core/dev.c:4348:9: sparse:     got int [noderef] __percpu *

vim +1151 kernel/time/tick-sched.c

554c8aa8ecade21 Rafael J. Wysocki   2018-04-03  1141  
0e7767687fdabfc Rafael J. Wysocki   2018-04-05  1142  /**
0e7767687fdabfc Rafael J. Wysocki   2018-04-05  1143   * tick_nohz_idle_enter - prepare for entering idle on the current CPU
2bbb6817c0ac1b5 Frederic Weisbecker 2011-10-08  1144   *
0e7767687fdabfc Rafael J. Wysocki   2018-04-05  1145   * Called when we start the idle loop.
280f06774afedf8 Frederic Weisbecker 2011-10-07  1146   */
1268fbc746ea1cd Frederic Weisbecker 2011-11-17  1147  void tick_nohz_idle_enter(void)
280f06774afedf8 Frederic Weisbecker 2011-10-07  1148  {
280f06774afedf8 Frederic Weisbecker 2011-10-07  1149  	struct tick_sched *ts;
280f06774afedf8 Frederic Weisbecker 2011-10-07  1150  
ebf3adbad012b89 Frederic Weisbecker 2017-11-06 @1151  	lockdep_assert_irqs_enabled();
0db49b72bce2634 Linus Torvalds      2012-01-06  1152  
1268fbc746ea1cd Frederic Weisbecker 2011-11-17  1153  	local_irq_disable();
1268fbc746ea1cd Frederic Weisbecker 2011-11-17  1154  
22127e93c587afa Christoph Lameter   2014-08-17  1155  	ts = this_cpu_ptr(&tick_cpu_sched);
23a8d888107ce4c Rafael J. Wysocki   2018-04-05  1156  
23a8d888107ce4c Rafael J. Wysocki   2018-04-05  1157  	WARN_ON_ONCE(ts->timer_expires_base);
23a8d888107ce4c Rafael J. Wysocki   2018-04-05  1158  
280f06774afedf8 Frederic Weisbecker 2011-10-07  1159  	ts->inidle = 1;
0e7767687fdabfc Rafael J. Wysocki   2018-04-05  1160  	tick_nohz_start_idle(ts);
1268fbc746ea1cd Frederic Weisbecker 2011-11-17  1161  
1268fbc746ea1cd Frederic Weisbecker 2011-11-17  1162  	local_irq_enable();
280f06774afedf8 Frederic Weisbecker 2011-10-07  1163  }
280f06774afedf8 Frederic Weisbecker 2011-10-07  1164  

:::::: The code at line 1151 was first introduced by commit
:::::: ebf3adbad012b89c4a51a3beae718a587d988a3a timers/nohz: Use lockdep to assert IRQs are disabled/enabled

:::::: TO: Frederic Weisbecker <frederic@kernel.org>
:::::: CC: Ingo Molnar <mingo@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
