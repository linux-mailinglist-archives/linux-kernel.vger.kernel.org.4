Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97FA86D23FF
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 17:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232746AbjCaP3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 11:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232303AbjCaP3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 11:29:52 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E6B51CBBB
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 08:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680276591; x=1711812591;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=5SyTZNYw5XW0huCNtiggG05aZ+cRCvH5Y3O+aLlb+3g=;
  b=mlb2ZcR45i/X+P+mB3GRioYD17GXcbzNnCz+4wDDgPPNUVaz44k6pHu0
   lI2MMRwVvf3WwvCECLjhAE5Mw1Anxdmbvh1Icoy9KwK3QyFRvhRQqZX6z
   uViRCndwJgoBJO5k3pXWHWeveNongABmcEojEKGMB6Tm7LOGg7gV/HCB0
   Ac4/JWTlJrtFTiiHl3XoDZFUu4SQzt6Vo7Cqsu5nupruOrUoPSaYodhqL
   I85A5ZZ2lKOSjqE7ACvu3Xxoo2NaLIVHb7UEdYLPuHkFnxxOqiVRvoKfz
   8w/tS6ap7ZE+Fcc2BB9xfLlNAA3o/MRnvquE9OEXnl9oKZbZTqHjNALZU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="321133288"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="321133288"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2023 08:29:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="828750372"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="828750372"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 31 Mar 2023 08:29:44 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1piGhD-000LuT-1T;
        Fri, 31 Mar 2023 15:29:43 +0000
Date:   Fri, 31 Mar 2023 23:29:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/perf/thunderx2_pmu.c:556:9: sparse: sparse: incorrect type
 in argument 1 (different address spaces)
Message-ID: <202303312338.7bFJF1k9-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   62bad54b26db8bc98e28749cd76b2d890edb4258
commit: f3c0eba287049237b23d1300376768293eb89e69 perf: Add a few assertions
date:   7 months ago
config: loongarch-randconfig-s033-20230329 (https://download.01.org/0day-ci/archive/20230331/202303312338.7bFJF1k9-lkp@intel.com/config)
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
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=loongarch SHELL=/bin/bash arch/loongarch/kernel/ drivers/perf/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303312338.7bFJF1k9-lkp@intel.com/

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
