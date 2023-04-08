Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F31D6DBDE6
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Apr 2023 00:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbjDHWzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 18:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjDHWzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 18:55:19 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF2759F8
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 15:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680994518; x=1712530518;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=sREKL0FecCK+OZmUS84lAQtJ8y6nWa3lZdyEg7c4L+8=;
  b=NqnO18rxd35/lUfY2HEC9RuVfjwS/4OTtaRVnK4dKnK3Ntg1/C7PL897
   P2UYCu14j+r7Rn1SGFQPTD1EWDwuyMBpH4BghNY5Tsh4YIDVo6VJCavMr
   3hktYk0k5W1/zmud4vPTgBa2iTxkrmfR6dG1SBElrZtACMNWXmUWmVvao
   VxPoPLyM1ITFyYFZk/Cq+SDeqmCWquNI621p6f+QMuF+VzcVsgefrGtFG
   hddE+FABhy/bWv3Rznh+SDcf75MEdeXxLOtIujIRoOCs53Q8m1qTIQIy2
   eHvZVRcFEZD/r8A0yzGRx5hXeCv+sDNGRoXKQNO8DeZ50QeKWG9XUsKDh
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10674"; a="340658099"
X-IronPort-AV: E=Sophos;i="5.98,330,1673942400"; 
   d="scan'208";a="340658099"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2023 15:55:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10674"; a="665234791"
X-IronPort-AV: E=Sophos;i="5.98,330,1673942400"; 
   d="scan'208";a="665234791"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 08 Apr 2023 15:55:16 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1plHSl-000UBP-2B;
        Sat, 08 Apr 2023 22:55:15 +0000
Date:   Sun, 9 Apr 2023 06:54:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/perf/thunderx2_pmu.c:556:9: sparse: sparse: incorrect type
 in argument 1 (different address spaces)
Message-ID: <202304090659.Ib93dkzD-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   68047c48b2288803c441df9f3e61d0d26bed87df
commit: f3c0eba287049237b23d1300376768293eb89e69 perf: Add a few assertions
date:   7 months ago
config: loongarch-randconfig-s053-20230409 (https://download.01.org/0day-ci/archive/20230409/202304090659.Ib93dkzD-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f3c0eba287049237b23d1300376768293eb89e69
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout f3c0eba287049237b23d1300376768293eb89e69
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=loongarch olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=loongarch SHELL=/bin/bash drivers/perf/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304090659.Ib93dkzD-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/perf/thunderx2_pmu.c:556:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   drivers/perf/thunderx2_pmu.c:556:9: sparse:     expected void *ptr
   drivers/perf/thunderx2_pmu.c:556:9: sparse:     got unsigned int [noderef] __percpu *
>> drivers/perf/thunderx2_pmu.c:556:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   drivers/perf/thunderx2_pmu.c:556:9: sparse:     expected void *ptr
   drivers/perf/thunderx2_pmu.c:556:9: sparse:     got unsigned int [noderef] __percpu *
>> drivers/perf/thunderx2_pmu.c:556:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   drivers/perf/thunderx2_pmu.c:556:9: sparse:     expected void *ptr
   drivers/perf/thunderx2_pmu.c:556:9: sparse:     got unsigned int [noderef] __percpu *
>> drivers/perf/thunderx2_pmu.c:556:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   drivers/perf/thunderx2_pmu.c:556:9: sparse:     expected void *ptr
   drivers/perf/thunderx2_pmu.c:556:9: sparse:     got unsigned int [noderef] __percpu *
>> drivers/perf/thunderx2_pmu.c:556:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   drivers/perf/thunderx2_pmu.c:556:9: sparse:     expected void *ptr
   drivers/perf/thunderx2_pmu.c:556:9: sparse:     got int [noderef] __percpu *
>> drivers/perf/thunderx2_pmu.c:556:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   drivers/perf/thunderx2_pmu.c:556:9: sparse:     expected void *ptr
   drivers/perf/thunderx2_pmu.c:556:9: sparse:     got int [noderef] __percpu *
>> drivers/perf/thunderx2_pmu.c:556:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   drivers/perf/thunderx2_pmu.c:556:9: sparse:     expected void *ptr
   drivers/perf/thunderx2_pmu.c:556:9: sparse:     got int [noderef] __percpu *
>> drivers/perf/thunderx2_pmu.c:556:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   drivers/perf/thunderx2_pmu.c:556:9: sparse:     expected void *ptr
   drivers/perf/thunderx2_pmu.c:556:9: sparse:     got int [noderef] __percpu *

vim +556 drivers/perf/thunderx2_pmu.c

69c32972d59388 Kulkarni, Ganapatrao             2018-12-06  539  
69c32972d59388 Kulkarni, Ganapatrao             2018-12-06  540  /*
69c32972d59388 Kulkarni, Ganapatrao             2018-12-06  541   * Make sure the group of events can be scheduled at once
69c32972d59388 Kulkarni, Ganapatrao             2018-12-06  542   * on the PMU.
69c32972d59388 Kulkarni, Ganapatrao             2018-12-06  543   */
5e2c27e833bb92 Ganapatrao Prabhakerrao Kulkarni 2019-10-16  544  static bool tx2_uncore_validate_event_group(struct perf_event *event,
5e2c27e833bb92 Ganapatrao Prabhakerrao Kulkarni 2019-10-16  545  		int max_counters)
69c32972d59388 Kulkarni, Ganapatrao             2018-12-06  546  {
69c32972d59388 Kulkarni, Ganapatrao             2018-12-06  547  	struct perf_event *sibling, *leader = event->group_leader;
69c32972d59388 Kulkarni, Ganapatrao             2018-12-06  548  	int counters = 0;
69c32972d59388 Kulkarni, Ganapatrao             2018-12-06  549  
69c32972d59388 Kulkarni, Ganapatrao             2018-12-06  550  	if (event->group_leader == event)
69c32972d59388 Kulkarni, Ganapatrao             2018-12-06  551  		return true;
69c32972d59388 Kulkarni, Ganapatrao             2018-12-06  552  
69c32972d59388 Kulkarni, Ganapatrao             2018-12-06  553  	if (!tx2_uncore_validate_event(event->pmu, leader, &counters))
69c32972d59388 Kulkarni, Ganapatrao             2018-12-06  554  		return false;
69c32972d59388 Kulkarni, Ganapatrao             2018-12-06  555  
69c32972d59388 Kulkarni, Ganapatrao             2018-12-06 @556  	for_each_sibling_event(sibling, leader) {
69c32972d59388 Kulkarni, Ganapatrao             2018-12-06  557  		if (!tx2_uncore_validate_event(event->pmu, sibling, &counters))
69c32972d59388 Kulkarni, Ganapatrao             2018-12-06  558  			return false;
69c32972d59388 Kulkarni, Ganapatrao             2018-12-06  559  	}
69c32972d59388 Kulkarni, Ganapatrao             2018-12-06  560  
69c32972d59388 Kulkarni, Ganapatrao             2018-12-06  561  	if (!tx2_uncore_validate_event(event->pmu, event, &counters))
69c32972d59388 Kulkarni, Ganapatrao             2018-12-06  562  		return false;
69c32972d59388 Kulkarni, Ganapatrao             2018-12-06  563  
69c32972d59388 Kulkarni, Ganapatrao             2018-12-06  564  	/*
69c32972d59388 Kulkarni, Ganapatrao             2018-12-06  565  	 * If the group requires more counters than the HW has,
69c32972d59388 Kulkarni, Ganapatrao             2018-12-06  566  	 * it cannot ever be scheduled.
69c32972d59388 Kulkarni, Ganapatrao             2018-12-06  567  	 */
5e2c27e833bb92 Ganapatrao Prabhakerrao Kulkarni 2019-10-16  568  	return counters <= max_counters;
69c32972d59388 Kulkarni, Ganapatrao             2018-12-06  569  }
69c32972d59388 Kulkarni, Ganapatrao             2018-12-06  570  

:::::: The code at line 556 was first introduced by commit
:::::: 69c32972d59388c041268e8206e8eb1acff29b9a drivers/perf: Add Cavium ThunderX2 SoC UNCORE PMU driver

:::::: TO: Kulkarni, Ganapatrao <Ganapatrao.Kulkarni@cavium.com>
:::::: CC: Will Deacon <will.deacon@arm.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
