Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF8269AAF3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 13:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjBQMCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 07:02:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjBQMCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 07:02:14 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83CD66CF7
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 04:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676635332; x=1708171332;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=S0yxM7bf9cJzdbOvbAH/GUfz3h0ybmzQtUpTFVcp8h0=;
  b=Gm9kds3DwSU631xCrQaysAeQpcedAIvOT/d4hdSfOEC3ggmynbWXfdsv
   hn/A9EpTQutXR5mqYiGXAe6rOU5RsfYnB5tXrFGwmN6nNzJqkmg2YPyyk
   V6iB5J96DkAJVk3vfleFrJw2C5LHfQ4c5Td3GzlOIEYHrXSOUR+QnEBCu
   +lX6YJbHJBE67Vr9rBbY22XE6guupiV2t0IhHBrS3ya/62uXjekpFb1wA
   EIk9KRbApAoGjYAu8ZSZ76AzRVJTx1ehKa8b+fYF0gH3NMhWF8luUR84t
   efb6zwRvFXqA1TrYcqWLUtMOTWdx6cXBJAVyZ2MDffASXKTxv4MK8uohX
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="396646589"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="396646589"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2023 04:02:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="739240904"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="739240904"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 17 Feb 2023 04:02:11 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pSzRK-000BQd-1m;
        Fri, 17 Feb 2023 12:02:10 +0000
Date:   Fri, 17 Feb 2023 20:02:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/perf/thunderx2_pmu.c:556:9: sparse: sparse: incorrect type
 in argument 1 (different address spaces)
Message-ID: <202302171904.ATesGXtj-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ec35307e18ba8174e2a3f701956059f6a36f22fb
commit: f3c0eba287049237b23d1300376768293eb89e69 perf: Add a few assertions
date:   5 months ago
config: loongarch-randconfig-s033-20230217 (https://download.01.org/0day-ci/archive/20230217/202302171904.ATesGXtj-lkp@intel.com/config)
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
| Link: https://lore.kernel.org/oe-kbuild-all/202302171904.ATesGXtj-lkp@intel.com/

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
