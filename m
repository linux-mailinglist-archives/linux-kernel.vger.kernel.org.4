Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B84762DE08
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 15:26:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239613AbiKQO0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 09:26:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239935AbiKQO0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 09:26:05 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E43F7722E
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 06:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668695161; x=1700231161;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8suXtEaCeFLvsWZ/3cL0sfCYCAGYTuJeqXSqhMh1LqQ=;
  b=eHRE/BkeitVAEoRsrwsJBQI2ipFfUXymMCCwNtmSrHw8ov5UkohaRHuT
   xWPUqC5uBqE7APghTz/5oi4l+Wb7smut7tLuwvCuNtqGG51dOB06LwFCq
   Hd6RobHoNjNB6WNm5wv3Yp4oecBp7p6l5sdK+awzJL8RZNoC4yDT1VO0I
   vnJh3Xwmaq4ZpUSaZzqgvczap14aCBXrgO/RfyJ7396YuQiYsPeuqARss
   HUjNI0G+6vlGn0f09sI86mCqiYxcpJoi+KVKdpuhplkT33kc2eue1MMz/
   zzqZ4jvx1Kk3zSLr8kitztjPbwPGgbz6NYAj8d8AaiBmbZBQRcn1suMdf
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="312875358"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="312875358"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 06:26:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="670938182"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="670938182"
Received: from lkp-server01.sh.intel.com (HELO 55744f5052f8) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 17 Nov 2022 06:25:58 -0800
Received: from kbuild by 55744f5052f8 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ovfq1-0000N8-39;
        Thu, 17 Nov 2022 14:25:57 +0000
Date:   Thu, 17 Nov 2022 22:25:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/perf/thunderx2_pmu.c:556:9: sparse: sparse: incorrect type
 in argument 1 (different address spaces)
Message-ID: <202211172243.5jMXgQuu-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="6u0b2+JIS9/V0QBb"
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,UPPERCASE_50_75 autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6u0b2+JIS9/V0QBb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   cc675d22e422442f6d230654a55a5fc5682ea018
commit: f3c0eba287049237b23d1300376768293eb89e69 perf: Add a few assertions
date:   2 months ago
config: loongarch-randconfig-s052-20221117
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
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=loongarch SHELL=/bin/bash drivers/perf/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

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
--
>> drivers/perf/arm-cmn.c:1471:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   drivers/perf/arm-cmn.c:1471:9: sparse:     expected void *ptr
   drivers/perf/arm-cmn.c:1471:9: sparse:     got unsigned int [noderef] __percpu *
>> drivers/perf/arm-cmn.c:1471:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   drivers/perf/arm-cmn.c:1471:9: sparse:     expected void *ptr
   drivers/perf/arm-cmn.c:1471:9: sparse:     got unsigned int [noderef] __percpu *
>> drivers/perf/arm-cmn.c:1471:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   drivers/perf/arm-cmn.c:1471:9: sparse:     expected void *ptr
   drivers/perf/arm-cmn.c:1471:9: sparse:     got unsigned int [noderef] __percpu *
>> drivers/perf/arm-cmn.c:1471:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   drivers/perf/arm-cmn.c:1471:9: sparse:     expected void *ptr
   drivers/perf/arm-cmn.c:1471:9: sparse:     got unsigned int [noderef] __percpu *
>> drivers/perf/arm-cmn.c:1471:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   drivers/perf/arm-cmn.c:1471:9: sparse:     expected void *ptr
   drivers/perf/arm-cmn.c:1471:9: sparse:     got int [noderef] __percpu *
>> drivers/perf/arm-cmn.c:1471:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   drivers/perf/arm-cmn.c:1471:9: sparse:     expected void *ptr
   drivers/perf/arm-cmn.c:1471:9: sparse:     got int [noderef] __percpu *
>> drivers/perf/arm-cmn.c:1471:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   drivers/perf/arm-cmn.c:1471:9: sparse:     expected void *ptr
   drivers/perf/arm-cmn.c:1471:9: sparse:     got int [noderef] __percpu *
>> drivers/perf/arm-cmn.c:1471:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   drivers/perf/arm-cmn.c:1471:9: sparse:     expected void *ptr
   drivers/perf/arm-cmn.c:1471:9: sparse:     got int [noderef] __percpu *
   drivers/perf/arm-cmn.c: note: in included file (through arch/loongarch/include/asm/io.h, arch/loongarch/include/asm/pgtable.h, arch/loongarch/include/asm/uaccess.h, ...):
   include/asm-generic/io.h:335:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:335:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:335:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:335:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:335:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:335:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:379:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:379:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:379:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:379:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:379:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:379:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:348:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:348:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:389:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long long [usertype] value @@     got restricted __le64 [usertype] @@
   include/asm-generic/io.h:389:22: sparse:     expected unsigned long long [usertype] value
   include/asm-generic/io.h:389:22: sparse:     got restricted __le64 [usertype]
   include/asm-generic/io.h:335:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:379:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:379:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:379:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:379:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:379:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:379:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:379:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:379:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:379:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:389:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long long [usertype] value @@     got restricted __le64 [usertype] @@
   include/asm-generic/io.h:389:22: sparse:     expected unsigned long long [usertype] value
   include/asm-generic/io.h:389:22: sparse:     got restricted __le64 [usertype]
   include/asm-generic/io.h:379:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:379:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:379:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:389:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long long [usertype] value @@     got restricted __le64 [usertype] @@
   include/asm-generic/io.h:389:22: sparse:     expected unsigned long long [usertype] value
   include/asm-generic/io.h:389:22: sparse:     got restricted __le64 [usertype]
   include/asm-generic/io.h:389:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long long [usertype] value @@     got restricted __le64 [usertype] @@
   include/asm-generic/io.h:389:22: sparse:     expected unsigned long long [usertype] value
   include/asm-generic/io.h:389:22: sparse:     got restricted __le64 [usertype]
   include/asm-generic/io.h:389:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long long [usertype] value @@     got restricted __le64 [usertype] @@
   include/asm-generic/io.h:389:22: sparse:     expected unsigned long long [usertype] value
   include/asm-generic/io.h:389:22: sparse:     got restricted __le64 [usertype]
   include/asm-generic/io.h:389:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long long [usertype] value @@     got restricted __le64 [usertype] @@
   include/asm-generic/io.h:389:22: sparse:     expected unsigned long long [usertype] value
   include/asm-generic/io.h:389:22: sparse:     got restricted __le64 [usertype]
   include/asm-generic/io.h:389:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long long [usertype] value @@     got restricted __le64 [usertype] @@
   include/asm-generic/io.h:389:22: sparse:     expected unsigned long long [usertype] value
   include/asm-generic/io.h:389:22: sparse:     got restricted __le64 [usertype]
   include/asm-generic/io.h:379:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:379:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:379:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:379:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:379:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:379:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:389:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long long [usertype] value @@     got restricted __le64 [usertype] @@
   include/asm-generic/io.h:389:22: sparse:     expected unsigned long long [usertype] value
   include/asm-generic/io.h:389:22: sparse:     got restricted __le64 [usertype]
   include/asm-generic/io.h:335:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:379:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:379:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:379:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:389:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long long [usertype] value @@     got restricted __le64 [usertype] @@
   include/asm-generic/io.h:389:22: sparse:     expected unsigned long long [usertype] value
   include/asm-generic/io.h:389:22: sparse:     got restricted __le64 [usertype]
   include/asm-generic/io.h:389:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long long [usertype] value @@     got restricted __le64 [usertype] @@
   include/asm-generic/io.h:389:22: sparse:     expected unsigned long long [usertype] value
   include/asm-generic/io.h:389:22: sparse:     got restricted __le64 [usertype]
   include/asm-generic/io.h:379:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:379:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:379:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:379:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:379:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:379:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:379:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:379:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:379:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:379:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:379:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:379:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:348:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:335:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:348:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:348:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:348:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:348:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:348:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:335:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:348:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:348:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:348:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:348:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:348:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:348:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:348:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:348:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:379:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:379:22: sparse:     expected unsigned int [usertype] value

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
https://01.org/lkp

--6u0b2+JIS9/V0QBb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=config

#
# Automatically generated file; DO NOT EDIT.
# Linux/loongarch 6.0.0-rc2 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="loongarch64-linux-gcc (GCC) 12.1.0"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=120100
CONFIG_CLANG_VERSION=0
CONFIG_AS_IS_GNU=y
CONFIG_AS_VERSION=23800
CONFIG_LD_IS_BFD=y
CONFIG_LD_VERSION=23800
CONFIG_LLD_VERSION=0
CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_CC_HAS_NO_PROFILE_FN_ATTR=y
CONFIG_PAHOLE_VERSION=123
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_TABLE_SORT=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
CONFIG_COMPILE_TEST=y
# CONFIG_WERROR is not set
CONFIG_LOCALVERSION=""
CONFIG_BUILD_SALT=""
CONFIG_DEFAULT_INIT=""
CONFIG_DEFAULT_HOSTNAME="(none)"
# CONFIG_SYSVIPC is not set
# CONFIG_POSIX_MQUEUE is not set
CONFIG_WATCH_QUEUE=y
CONFIG_CROSS_MEMORY_ATTACH=y
# CONFIG_USELIB is not set
CONFIG_AUDIT=y
CONFIG_HAVE_ARCH_AUDITSYSCALL=y
CONFIG_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_IRQ_INJECTION=y
CONFIG_GENERIC_IRQ_CHIP=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_IRQ_FASTEOI_HIERARCHY_HANDLERS=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
CONFIG_GENERIC_IRQ_DEBUGFS=y
# end of IRQ subsystem

CONFIG_GENERIC_IRQ_MULTI_HANDLER=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CMOS_UPDATE=y
CONFIG_CONTEXT_TRACKING=y
CONFIG_CONTEXT_TRACKING_IDLE=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_HZ_PERIODIC=y
# CONFIG_NO_HZ_IDLE is not set
# CONFIG_NO_HZ_FULL is not set
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
# end of Timers subsystem

CONFIG_BPF=y

#
# BPF subsystem
#
CONFIG_BPF_SYSCALL=y
# CONFIG_BPF_UNPRIV_DEFAULT_OFF is not set
CONFIG_USERMODE_DRIVER=y
# end of BPF subsystem

CONFIG_PREEMPT_BUILD=y
# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
CONFIG_PREEMPT=y
CONFIG_PREEMPT_COUNT=y
CONFIG_PREEMPTION=y

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
# CONFIG_VIRT_CPU_ACCOUNTING_GEN is not set
# CONFIG_IRQ_TIME_ACCOUNTING is not set
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_TASKSTATS=y
# CONFIG_TASK_DELAY_ACCT is not set
# CONFIG_TASK_XACCT is not set
# CONFIG_PSI is not set
# end of CPU/Task time and stats accounting

CONFIG_CPU_ISOLATION=y

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
CONFIG_PREEMPT_RCU=y
CONFIG_RCU_EXPERT=y
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_FORCE_TASKS_RCU=y
CONFIG_TASKS_RCU=y
CONFIG_FORCE_TASKS_RUDE_RCU=y
CONFIG_TASKS_RUDE_RCU=y
# CONFIG_FORCE_TASKS_TRACE_RCU is not set
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_FANOUT=64
CONFIG_RCU_FANOUT_LEAF=16
# CONFIG_RCU_BOOST is not set
CONFIG_RCU_NOCB_CPU=y
CONFIG_RCU_NOCB_CPU_DEFAULT_ALL=y
CONFIG_TASKS_TRACE_RCU_READ_MB=y
# end of RCU Subsystem

# CONFIG_IKCONFIG is not set
CONFIG_IKHEADERS=y
CONFIG_LOG_BUF_SHIFT=17
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_PRINTK_INDEX=y
CONFIG_GENERIC_SCHED_CLOCK=y

#
# Scheduler features
#
# end of Scheduler features

CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_CC_HAS_INT128=y
CONFIG_CC_IMPLICIT_FALLTHROUGH="-Wimplicit-fallthrough=5"
CONFIG_GCC12_NO_ARRAY_BOUNDS=y
CONFIG_CC_NO_ARRAY_BOUNDS=y
CONFIG_NUMA_BALANCING=y
# CONFIG_NUMA_BALANCING_DEFAULT_ENABLED is not set
# CONFIG_CGROUPS is not set
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
# CONFIG_USER_NS is not set
CONFIG_PID_NS=y
# CONFIG_NET_NS is not set
CONFIG_CHECKPOINT_RESTORE=y
# CONFIG_SCHED_AUTOGROUP is not set
# CONFIG_SYSFS_DEPRECATED is not set
# CONFIG_RELAY is not set
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
# CONFIG_INITRAMFS_FORCE is not set
# CONFIG_RD_GZIP is not set
# CONFIG_RD_BZIP2 is not set
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
# CONFIG_RD_ZSTD is not set
CONFIG_BOOT_CONFIG=y
# CONFIG_BOOT_CONFIG_EMBED is not set
CONFIG_INITRAMFS_PRESERVE_MTIME=y
# CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE is not set
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_EXPERT=y
CONFIG_MULTIUSER=y
# CONFIG_SGETMASK_SYSCALL is not set
# CONFIG_SYSFS_SYSCALL is not set
CONFIG_FHANDLE=y
# CONFIG_POSIX_TIMERS is not set
CONFIG_PRINTK=y
# CONFIG_BUG is not set
# CONFIG_BASE_FULL is not set
# CONFIG_FUTEX is not set
# CONFIG_EPOLL is not set
CONFIG_SIGNALFD=y
# CONFIG_TIMERFD is not set
CONFIG_EVENTFD=y
# CONFIG_SHMEM is not set
CONFIG_AIO=y
CONFIG_IO_URING=y
# CONFIG_ADVISE_SYSCALLS is not set
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_KCMP=y
CONFIG_RSEQ=y
# CONFIG_DEBUG_RSEQ is not set
CONFIG_EMBEDDED=y
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_PERF_USE_VMALLOC=y
# CONFIG_PC104 is not set

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

CONFIG_SYSTEM_DATA_VERIFICATION=y
CONFIG_PROFILING=y
CONFIG_TRACEPOINTS=y
# end of General setup

CONFIG_LOONGARCH=y
CONFIG_64BIT=y
CONFIG_CPU_HAS_FPU=y
CONFIG_CPU_HAS_PREFETCH=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_GENERIC_CSUM=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_L1_CACHE_SHIFT=6
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MACH_LOONGSON64=y
CONFIG_PAGE_SIZE_16KB=y
CONFIG_PGTABLE_2LEVEL=y
CONFIG_PGTABLE_LEVELS=2
CONFIG_SCHED_OMIT_FRAME_POINTER=y

#
# Kernel type and options
#
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_SCHED_HRTICK=y
# CONFIG_4KB_3LEVEL is not set
# CONFIG_4KB_4LEVEL is not set
CONFIG_16KB_2LEVEL=y
# CONFIG_16KB_3LEVEL is not set
# CONFIG_64KB_2LEVEL is not set
# CONFIG_64KB_3LEVEL is not set
CONFIG_CMDLINE=""
# CONFIG_CMDLINE_BOOTLOADER is not set
CONFIG_CMDLINE_EXTEND=y
# CONFIG_CMDLINE_FORCE is not set
# CONFIG_DMI is not set
CONFIG_EFI=y
CONFIG_SMP=y
# CONFIG_HOTPLUG_CPU is not set
CONFIG_NR_CPUS=64
CONFIG_NUMA=y
CONFIG_NODES_SHIFT=6
CONFIG_FORCE_MAX_ZONEORDER=12
CONFIG_SECCOMP=y
# end of Kernel type and options

CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=12
CONFIG_ARCH_MMAP_RND_BITS_MAX=18

#
# Power management options
#
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_GENERIC_GSI=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
# CONFIG_ACPI_EC_DEBUGFS is not set
CONFIG_ACPI_AC=y
# CONFIG_ACPI_BATTERY is not set
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=y
# CONFIG_ACPI_FAN is not set
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_MCFG=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_IPMI=y
# CONFIG_ACPI_THERMAL is not set
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_DEBUG=y
# CONFIG_ACPI_PCI_SLOT is not set
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HED=y
# CONFIG_ACPI_CUSTOM_METHOD is not set
CONFIG_ACPI_REDUCED_HARDWARE_ONLY=y
CONFIG_ACPI_NUMA=y
# CONFIG_ACPI_HMAT is not set
CONFIG_ACPI_WATCHDOG=y
CONFIG_ACPI_CONFIGFS=y
CONFIG_ACPI_PFRUT=y
CONFIG_ACPI_PCC=y
# CONFIG_PMIC_OPREGION is not set
# end of Power management options

#
# Firmware Drivers
#

#
# ARM System Control and Management Interface Protocol
#
CONFIG_ARM_SCMI_PROTOCOL=y
CONFIG_ARM_SCMI_HAVE_TRANSPORT=y
CONFIG_ARM_SCMI_HAVE_SHMEM=y
CONFIG_ARM_SCMI_TRANSPORT_MAILBOX=y
# CONFIG_ARM_SCMI_TRANSPORT_VIRTIO is not set
CONFIG_ARM_SCMI_POWER_DOMAIN=y
CONFIG_ARM_SCMI_POWER_CONTROL=y
# end of ARM System Control and Management Interface Protocol

CONFIG_ARM_SCPI_PROTOCOL=y
CONFIG_ARM_SCPI_POWER_DOMAIN=y
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_MTK_ADSP_IPC=y
CONFIG_SYSFB=y
CONFIG_SYSFB_SIMPLEFB=y
# CONFIG_TURRIS_MOX_RWTM is not set
# CONFIG_BCM47XX_NVRAM is not set
CONFIG_CS_DSP=y
CONFIG_GOOGLE_FIRMWARE=y
CONFIG_GOOGLE_COREBOOT_TABLE=y
CONFIG_GOOGLE_MEMCONSOLE=y
CONFIG_GOOGLE_MEMCONSOLE_COREBOOT=y
CONFIG_GOOGLE_VPD=y

#
# EFI (Extensible Firmware Interface) Support
#
CONFIG_EFI_ESRT=y
CONFIG_EFI_PARAMS_FROM_FDT=y
CONFIG_EFI_RUNTIME_WRAPPERS=y
# CONFIG_EFI_BOOTLOADER_CONTROL is not set
CONFIG_EFI_CAPSULE_LOADER=y
# CONFIG_EFI_TEST is not set
CONFIG_EFI_RCI2_TABLE=y
# CONFIG_EFI_DISABLE_PCI_DMA is not set
CONFIG_EFI_CUSTOM_SSDT_OVERLAYS=y
CONFIG_EFI_DISABLE_RUNTIME=y
# CONFIG_EFI_COCO_SECRET is not set
# end of EFI (Extensible Firmware Interface) Support

# CONFIG_IMX_DSP is not set
CONFIG_IMX_SCU=y
CONFIG_IMX_SCU_PD=y

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

#
# General architecture-dependent options
#
CONFIG_GENERIC_ENTRY=y
CONFIG_HAVE_64BIT_ALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_NMI=y
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_WANTS_NO_INSTR=y
CONFIG_HAVE_ASM_MODVERSIONS=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_MMU_GATHER_MERGE_VMAS=y
CONFIG_HAVE_ARCH_SECCOMP=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP_FILTER=y
# CONFIG_SECCOMP_CACHE_DEBUG is not set
CONFIG_LTO_NONE=y
CONFIG_HAVE_CONTEXT_TRACKING_USER=y
CONFIG_HAVE_TIF_NOHZ=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=12
CONFIG_PAGE_SIZE_LESS_THAN_64KB=y
CONFIG_PAGE_SIZE_LESS_THAN_256KB=y
CONFIG_ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_ARCH_HAS_PHYS_TO_DMA=y
# CONFIG_LOCK_EVENT_COUNTS is not set

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
# end of GCOV-based kernel profiling
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=1
# CONFIG_MODULES is not set
# CONFIG_BLOCK is not set
CONFIG_PADATA=y
CONFIG_ASN1=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_ARCH_BINFMT_ELF_STATE=y
CONFIG_ELFCORE=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=y
# CONFIG_COREDUMP is not set
# end of Executable file formats

#
# Memory Management options
#

#
# SLAB allocator options
#
# CONFIG_SLAB is not set
# CONFIG_SLUB is not set
CONFIG_SLOB=y
# end of SLAB allocator options

CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
# CONFIG_COMPAT_BRK is not set
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
# CONFIG_MEMORY_HOTPLUG is not set
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_COMPACTION=y
# CONFIG_PAGE_REPORTING is not set
CONFIG_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PHYS_ADDR_T_64BIT=y
# CONFIG_KSM is not set
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_CMA=y
# CONFIG_CMA_DEBUG is not set
# CONFIG_CMA_DEBUGFS is not set
CONFIG_CMA_SYSFS=y
CONFIG_CMA_AREAS=19
CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
CONFIG_PAGE_IDLE_FLAG=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ZONE_DMA32=y
CONFIG_VM_EVENT_COUNTERS=y
CONFIG_PERCPU_STATS=y
CONFIG_GUP_TEST=y
CONFIG_ARCH_HAS_PTE_SPECIAL=y
# CONFIG_USERFAULTFD is not set

#
# Data Access Monitoring
#
CONFIG_DAMON=y
CONFIG_DAMON_VADDR=y
CONFIG_DAMON_PADDR=y
CONFIG_DAMON_SYSFS=y
CONFIG_DAMON_DBGFS=y
CONFIG_DAMON_RECLAIM=y
CONFIG_DAMON_LRU_SORT=y
# end of Data Access Monitoring
# end of Memory Management options

CONFIG_NET=y
CONFIG_SKB_EXTENSIONS=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_DIAG=y
# CONFIG_UNIX is not set
# CONFIG_TLS is not set
CONFIG_XFRM=y
CONFIG_XFRM_OFFLOAD=y
CONFIG_XFRM_ALGO=y
CONFIG_XFRM_USER=y
CONFIG_XFRM_INTERFACE=y
# CONFIG_XFRM_SUB_POLICY is not set
CONFIG_XFRM_MIGRATE=y
CONFIG_XFRM_STATISTICS=y
CONFIG_XFRM_AH=y
CONFIG_XFRM_ESP=y
CONFIG_XFRM_IPCOMP=y
# CONFIG_NET_KEY is not set
CONFIG_SMC=y
CONFIG_SMC_DIAG=y
# CONFIG_XDP_SOCKETS is not set
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_ROUTE_CLASSID=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
CONFIG_IP_PNP_BOOTP=y
CONFIG_IP_PNP_RARP=y
CONFIG_NET_IPIP=y
CONFIG_NET_IPGRE_DEMUX=y
CONFIG_NET_IP_TUNNEL=y
CONFIG_NET_IPGRE=y
CONFIG_SYN_COOKIES=y
CONFIG_NET_IPVTI=y
CONFIG_NET_UDP_TUNNEL=y
CONFIG_NET_FOU=y
CONFIG_NET_FOU_IP_TUNNELS=y
CONFIG_INET_AH=y
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
CONFIG_INET_TUNNEL=y
# CONFIG_INET_DIAG is not set
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_CUBIC=y
CONFIG_DEFAULT_TCP_CONG="cubic"
# CONFIG_TCP_MD5SIG is not set
CONFIG_IPV6=y
# CONFIG_IPV6_ROUTER_PREF is not set
# CONFIG_IPV6_OPTIMISTIC_DAD is not set
# CONFIG_INET6_AH is not set
CONFIG_INET6_ESP=y
CONFIG_INET6_ESP_OFFLOAD=y
# CONFIG_INET6_ESPINTCP is not set
CONFIG_INET6_IPCOMP=y
CONFIG_IPV6_MIP6=y
CONFIG_IPV6_ILA=y
CONFIG_INET6_XFRM_TUNNEL=y
CONFIG_INET6_TUNNEL=y
CONFIG_IPV6_VTI=y
CONFIG_IPV6_SIT=y
# CONFIG_IPV6_SIT_6RD is not set
CONFIG_IPV6_NDISC_NODETYPE=y
CONFIG_IPV6_TUNNEL=y
# CONFIG_IPV6_GRE is not set
CONFIG_IPV6_FOU=y
CONFIG_IPV6_FOU_TUNNEL=y
CONFIG_IPV6_MULTIPLE_TABLES=y
# CONFIG_IPV6_SUBTREES is not set
# CONFIG_IPV6_MROUTE is not set
# CONFIG_IPV6_SEG6_LWTUNNEL is not set
CONFIG_IPV6_SEG6_HMAC=y
CONFIG_IPV6_RPL_LWTUNNEL=y
# CONFIG_IPV6_IOAM6_LWTUNNEL is not set
# CONFIG_MPTCP is not set
CONFIG_NETWORK_SECMARK=y
CONFIG_NET_PTP_CLASSIFY=y
CONFIG_NETWORK_PHY_TIMESTAMPING=y
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_ADVANCED is not set

#
# Core Netfilter Configuration
#
# CONFIG_NETFILTER_INGRESS is not set
# CONFIG_NETFILTER_EGRESS is not set
CONFIG_NETFILTER_NETLINK=y
CONFIG_NETFILTER_NETLINK_LOG=y
CONFIG_NF_CONNTRACK=y
CONFIG_NF_LOG_SYSLOG=y
CONFIG_NF_CONNTRACK_SECMARK=y
CONFIG_NF_CONNTRACK_PROCFS=y
# CONFIG_NF_CONNTRACK_LABELS is not set
CONFIG_NF_CONNTRACK_FTP=y
CONFIG_NF_CONNTRACK_IRC=y
# CONFIG_NF_CONNTRACK_NETBIOS_NS is not set
CONFIG_NF_CONNTRACK_SIP=y
CONFIG_NF_CT_NETLINK=y
# CONFIG_NETFILTER_NETLINK_GLUE_CT is not set
CONFIG_NF_NAT=y
CONFIG_NF_NAT_FTP=y
CONFIG_NF_NAT_IRC=y
CONFIG_NF_NAT_SIP=y
CONFIG_NF_NAT_REDIRECT=y
CONFIG_NF_NAT_MASQUERADE=y
CONFIG_NF_TABLES=y
# CONFIG_NF_TABLES_INET is not set
CONFIG_NF_TABLES_NETDEV=y
CONFIG_NFT_NUMGEN=y
# CONFIG_NFT_CT is not set
CONFIG_NFT_LOG=y
# CONFIG_NFT_LIMIT is not set
# CONFIG_NFT_MASQ is not set
CONFIG_NFT_REDIR=y
CONFIG_NFT_NAT=y
CONFIG_NFT_TUNNEL=y
# CONFIG_NFT_OBJREF is not set
# CONFIG_NFT_QUOTA is not set
CONFIG_NFT_REJECT=y
# CONFIG_NFT_COMPAT is not set
# CONFIG_NFT_HASH is not set
CONFIG_NFT_XFRM=y
CONFIG_NFT_SOCKET=y
CONFIG_NFT_TPROXY=y
CONFIG_NF_DUP_NETDEV=y
# CONFIG_NFT_DUP_NETDEV is not set
# CONFIG_NFT_FWD_NETDEV is not set
CONFIG_NETFILTER_XTABLES=y

#
# Xtables combined modules
#
# CONFIG_NETFILTER_XT_MARK is not set

#
# Xtables targets
#
# CONFIG_NETFILTER_XT_TARGET_CONNSECMARK is not set
CONFIG_NETFILTER_XT_TARGET_LOG=y
CONFIG_NETFILTER_XT_NAT=y
CONFIG_NETFILTER_XT_TARGET_NETMAP=y
# CONFIG_NETFILTER_XT_TARGET_NFLOG is not set
# CONFIG_NETFILTER_XT_TARGET_REDIRECT is not set
CONFIG_NETFILTER_XT_TARGET_MASQUERADE=y
CONFIG_NETFILTER_XT_TARGET_SECMARK=y
CONFIG_NETFILTER_XT_TARGET_TCPMSS=y

#
# Xtables matches
#
CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=y
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=y
CONFIG_NETFILTER_XT_MATCH_POLICY=y
CONFIG_NETFILTER_XT_MATCH_STATE=y
# end of Core Netfilter Configuration

CONFIG_IP_SET=y
CONFIG_IP_SET_MAX=256
CONFIG_IP_SET_BITMAP_IP=y
# CONFIG_IP_SET_BITMAP_IPMAC is not set
CONFIG_IP_SET_BITMAP_PORT=y
CONFIG_IP_SET_HASH_IP=y
# CONFIG_IP_SET_HASH_IPMARK is not set
CONFIG_IP_SET_HASH_IPPORT=y
# CONFIG_IP_SET_HASH_IPPORTIP is not set
CONFIG_IP_SET_HASH_IPPORTNET=y
# CONFIG_IP_SET_HASH_IPMAC is not set
CONFIG_IP_SET_HASH_MAC=y
CONFIG_IP_SET_HASH_NETPORTNET=y
CONFIG_IP_SET_HASH_NET=y
CONFIG_IP_SET_HASH_NETNET=y
# CONFIG_IP_SET_HASH_NETPORT is not set
# CONFIG_IP_SET_HASH_NETIFACE is not set
CONFIG_IP_SET_LIST_SET=y
CONFIG_IP_VS=y
CONFIG_IP_VS_IPV6=y
# CONFIG_IP_VS_DEBUG is not set
CONFIG_IP_VS_TAB_BITS=12

#
# IPVS transport protocol load balancing support
#
# CONFIG_IP_VS_PROTO_TCP is not set
CONFIG_IP_VS_PROTO_UDP=y
CONFIG_IP_VS_PROTO_AH_ESP=y
CONFIG_IP_VS_PROTO_ESP=y
# CONFIG_IP_VS_PROTO_AH is not set
# CONFIG_IP_VS_PROTO_SCTP is not set

#
# IPVS scheduler
#
CONFIG_IP_VS_RR=y
CONFIG_IP_VS_WRR=y
CONFIG_IP_VS_LC=y
CONFIG_IP_VS_WLC=y
# CONFIG_IP_VS_FO is not set
# CONFIG_IP_VS_OVF is not set
CONFIG_IP_VS_LBLC=y
# CONFIG_IP_VS_LBLCR is not set
CONFIG_IP_VS_DH=y
CONFIG_IP_VS_SH=y
# CONFIG_IP_VS_MH is not set
CONFIG_IP_VS_SED=y
CONFIG_IP_VS_NQ=y
# CONFIG_IP_VS_TWOS is not set

#
# IPVS SH scheduler
#
CONFIG_IP_VS_SH_TAB_BITS=8

#
# IPVS MH scheduler
#
CONFIG_IP_VS_MH_TAB_INDEX=12

#
# IPVS application helper
#
# CONFIG_IP_VS_NFCT is not set
# CONFIG_IP_VS_PE_SIP is not set

#
# IP: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV4=y
CONFIG_NF_SOCKET_IPV4=y
CONFIG_NF_TPROXY_IPV4=y
CONFIG_NF_TABLES_IPV4=y
CONFIG_NFT_REJECT_IPV4=y
CONFIG_NFT_DUP_IPV4=y
# CONFIG_NFT_FIB_IPV4 is not set
# CONFIG_NF_TABLES_ARP is not set
CONFIG_NF_DUP_IPV4=y
CONFIG_NF_LOG_ARP=y
# CONFIG_NF_LOG_IPV4 is not set
CONFIG_NF_REJECT_IPV4=y
CONFIG_IP_NF_IPTABLES=y
# CONFIG_IP_NF_FILTER is not set
CONFIG_IP_NF_NAT=y
CONFIG_IP_NF_TARGET_MASQUERADE=y
# CONFIG_IP_NF_MANGLE is not set
CONFIG_IP_NF_RAW=y
# end of IP: Netfilter Configuration

#
# IPv6: Netfilter Configuration
#
# CONFIG_NF_SOCKET_IPV6 is not set
CONFIG_NF_TPROXY_IPV6=y
# CONFIG_NF_TABLES_IPV6 is not set
# CONFIG_NF_DUP_IPV6 is not set
CONFIG_NF_REJECT_IPV6=y
CONFIG_NF_LOG_IPV6=y
CONFIG_IP6_NF_IPTABLES=y
# CONFIG_IP6_NF_MATCH_IPV6HEADER is not set
CONFIG_IP6_NF_FILTER=y
# CONFIG_IP6_NF_TARGET_REJECT is not set
# CONFIG_IP6_NF_MANGLE is not set
CONFIG_IP6_NF_RAW=y
# end of IPv6: Netfilter Configuration

CONFIG_NF_DEFRAG_IPV6=y
CONFIG_NF_CONNTRACK_BRIDGE=y
CONFIG_BPFILTER=y
# CONFIG_IP_DCCP is not set
# CONFIG_IP_SCTP is not set
CONFIG_RDS=y
CONFIG_RDS_TCP=y
# CONFIG_RDS_DEBUG is not set
# CONFIG_TIPC is not set
CONFIG_ATM=y
CONFIG_ATM_CLIP=y
CONFIG_ATM_CLIP_NO_ICMP=y
# CONFIG_ATM_LANE is not set
CONFIG_ATM_BR2684=y
# CONFIG_ATM_BR2684_IPFILTER is not set
# CONFIG_L2TP is not set
CONFIG_STP=y
CONFIG_GARP=y
CONFIG_MRP=y
# CONFIG_BRIDGE is not set
CONFIG_VLAN_8021Q=y
CONFIG_VLAN_8021Q_GVRP=y
CONFIG_VLAN_8021Q_MVRP=y
# CONFIG_DECNET is not set
CONFIG_LLC=y
# CONFIG_LLC2 is not set
CONFIG_ATALK=y
CONFIG_DEV_APPLETALK=y
CONFIG_IPDDP=y
CONFIG_IPDDP_ENCAP=y
CONFIG_X25=y
# CONFIG_LAPB is not set
CONFIG_PHONET=y
CONFIG_6LOWPAN=y
CONFIG_6LOWPAN_DEBUGFS=y
# CONFIG_6LOWPAN_NHC is not set
# CONFIG_IEEE802154 is not set
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
# CONFIG_NET_SCH_CBQ is not set
CONFIG_NET_SCH_HTB=y
# CONFIG_NET_SCH_HFSC is not set
# CONFIG_NET_SCH_ATM is not set
CONFIG_NET_SCH_PRIO=y
# CONFIG_NET_SCH_MULTIQ is not set
CONFIG_NET_SCH_RED=y
# CONFIG_NET_SCH_SFB is not set
CONFIG_NET_SCH_SFQ=y
CONFIG_NET_SCH_TEQL=y
CONFIG_NET_SCH_TBF=y
CONFIG_NET_SCH_CBS=y
CONFIG_NET_SCH_ETF=y
CONFIG_NET_SCH_TAPRIO=y
# CONFIG_NET_SCH_GRED is not set
# CONFIG_NET_SCH_DSMARK is not set
CONFIG_NET_SCH_NETEM=y
# CONFIG_NET_SCH_DRR is not set
CONFIG_NET_SCH_MQPRIO=y
CONFIG_NET_SCH_SKBPRIO=y
# CONFIG_NET_SCH_CHOKE is not set
CONFIG_NET_SCH_QFQ=y
CONFIG_NET_SCH_CODEL=y
# CONFIG_NET_SCH_FQ_CODEL is not set
CONFIG_NET_SCH_CAKE=y
CONFIG_NET_SCH_FQ=y
CONFIG_NET_SCH_HHF=y
# CONFIG_NET_SCH_PIE is not set
# CONFIG_NET_SCH_PLUG is not set
CONFIG_NET_SCH_ETS=y
# CONFIG_NET_SCH_DEFAULT is not set

#
# Classification
#
CONFIG_NET_CLS=y
CONFIG_NET_CLS_BASIC=y
CONFIG_NET_CLS_TCINDEX=y
CONFIG_NET_CLS_ROUTE4=y
CONFIG_NET_CLS_FW=y
# CONFIG_NET_CLS_U32 is not set
CONFIG_NET_CLS_RSVP=y
CONFIG_NET_CLS_RSVP6=y
CONFIG_NET_CLS_FLOW=y
# CONFIG_NET_CLS_BPF is not set
CONFIG_NET_CLS_FLOWER=y
CONFIG_NET_CLS_MATCHALL=y
CONFIG_NET_EMATCH=y
CONFIG_NET_EMATCH_STACK=32
CONFIG_NET_EMATCH_CMP=y
CONFIG_NET_EMATCH_NBYTE=y
# CONFIG_NET_EMATCH_U32 is not set
CONFIG_NET_EMATCH_META=y
# CONFIG_NET_EMATCH_TEXT is not set
CONFIG_NET_EMATCH_CANID=y
# CONFIG_NET_EMATCH_IPSET is not set
CONFIG_NET_EMATCH_IPT=y
# CONFIG_NET_CLS_ACT is not set
CONFIG_NET_SCH_FIFO=y
CONFIG_DCB=y
CONFIG_DNS_RESOLVER=y
CONFIG_BATMAN_ADV=y
# CONFIG_BATMAN_ADV_BATMAN_V is not set
# CONFIG_BATMAN_ADV_BLA is not set
CONFIG_BATMAN_ADV_DAT=y
# CONFIG_BATMAN_ADV_NC is not set
CONFIG_BATMAN_ADV_MCAST=y
# CONFIG_BATMAN_ADV_DEBUG is not set
CONFIG_BATMAN_ADV_TRACING=y
CONFIG_OPENVSWITCH=y
CONFIG_OPENVSWITCH_GRE=y
# CONFIG_VSOCKETS is not set
CONFIG_NETLINK_DIAG=y
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=y
CONFIG_NET_NSH=y
CONFIG_HSR=y
CONFIG_NET_SWITCHDEV=y
# CONFIG_NET_L3_MASTER_DEV is not set
CONFIG_QRTR=y
# CONFIG_QRTR_SMD is not set
CONFIG_QRTR_TUN=y
CONFIG_QRTR_MHI=y
# CONFIG_NET_NCSI is not set
CONFIG_PCPU_DEV_REFCNT=y
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_SOCK_RX_QUEUE_MAPPING=y
CONFIG_XPS=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
CONFIG_NET_PKTGEN=y
CONFIG_NET_DROP_MONITOR=y
# end of Network testing
# end of Networking options

# CONFIG_HAMRADIO is not set
CONFIG_CAN=y
CONFIG_CAN_RAW=y
CONFIG_CAN_BCM=y
# CONFIG_CAN_GW is not set
# CONFIG_CAN_J1939 is not set
# CONFIG_CAN_ISOTP is not set
CONFIG_BT=y
CONFIG_BT_BREDR=y
CONFIG_BT_RFCOMM=y
CONFIG_BT_BNEP=y
# CONFIG_BT_BNEP_MC_FILTER is not set
# CONFIG_BT_BNEP_PROTO_FILTER is not set
# CONFIG_BT_HIDP is not set
CONFIG_BT_HS=y
# CONFIG_BT_LE is not set
# CONFIG_BT_LEDS is not set
# CONFIG_BT_MSFTEXT is not set
# CONFIG_BT_AOSPEXT is not set
CONFIG_BT_DEBUGFS=y
CONFIG_BT_SELFTEST=y
# CONFIG_BT_FEATURE_DEBUG is not set

#
# Bluetooth device drivers
#
CONFIG_BT_QCA=y
CONFIG_BT_MTK=y
CONFIG_BT_HCIBTSDIO=y
CONFIG_BT_HCIVHCI=y
CONFIG_BT_MRVL=y
# CONFIG_BT_MRVL_SDIO is not set
CONFIG_BT_MTKSDIO=y
# CONFIG_BT_MTKUART is not set
CONFIG_BT_QCOMSMD=y
CONFIG_BT_VIRTIO=y
# end of Bluetooth device drivers

CONFIG_AF_RXRPC=y
# CONFIG_AF_RXRPC_IPV6 is not set
# CONFIG_AF_RXRPC_INJECT_LOSS is not set
CONFIG_AF_RXRPC_DEBUG=y
CONFIG_RXKAD=y
CONFIG_AF_KCM=y
CONFIG_STREAM_PARSER=y
CONFIG_MCTP=y
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
CONFIG_CFG80211=y
CONFIG_NL80211_TESTMODE=y
CONFIG_CFG80211_DEVELOPER_WARNINGS=y
CONFIG_CFG80211_CERTIFICATION_ONUS=y
# CONFIG_CFG80211_REQUIRE_SIGNED_REGDB is not set
CONFIG_CFG80211_REG_CELLULAR_HINTS=y
CONFIG_CFG80211_REG_RELAX_NO_IR=y
# CONFIG_CFG80211_DEFAULT_PS is not set
CONFIG_CFG80211_DEBUGFS=y
CONFIG_CFG80211_CRDA_SUPPORT=y
# CONFIG_CFG80211_WEXT is not set
# CONFIG_MAC80211 is not set
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
# CONFIG_RFKILL is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_FD=y
CONFIG_NET_9P_VIRTIO=y
CONFIG_NET_9P_DEBUG=y
CONFIG_CAIF=y
CONFIG_CAIF_DEBUG=y
CONFIG_CAIF_NETDEV=y
# CONFIG_CAIF_USB is not set
# CONFIG_CEPH_LIB is not set
# CONFIG_NFC is not set
CONFIG_PSAMPLE=y
# CONFIG_NET_IFE is not set
CONFIG_LWTUNNEL=y
# CONFIG_LWTUNNEL_BPF is not set
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_NET_SOCK_MSG=y
CONFIG_PAGE_POOL=y
CONFIG_PAGE_POOL_STATS=y
# CONFIG_FAILOVER is not set
CONFIG_ETHTOOL_NETLINK=y

#
# Device Drivers
#
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCI_DOMAINS_GENERIC=y
# CONFIG_PCIEPORTBUS is not set
CONFIG_PCIEASPM=y
# CONFIG_PCIEASPM_DEFAULT is not set
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
CONFIG_PCIEASPM_PERFORMANCE=y
# CONFIG_PCIE_PTM is not set
CONFIG_PCI_MSI=y
CONFIG_PCI_MSI_IRQ_DOMAIN=y
CONFIG_PCI_MSI_ARCH_FALLBACKS=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_STUB is not set
CONFIG_PCI_ATS=y
CONFIG_PCI_ECAM=y
# CONFIG_PCI_IOV is not set
CONFIG_PCI_PRI=y
CONFIG_PCI_PASID=y
CONFIG_PCI_LABEL=y
# CONFIG_PCIE_BUS_TUNE_OFF is not set
# CONFIG_PCIE_BUS_DEFAULT is not set
# CONFIG_PCIE_BUS_SAFE is not set
# CONFIG_PCIE_BUS_PERFORMANCE is not set
CONFIG_PCIE_BUS_PEER2PEER=y
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
CONFIG_HOTPLUG_PCI=y
CONFIG_HOTPLUG_PCI_ACPI=y
# CONFIG_HOTPLUG_PCI_ACPI_IBM is not set
CONFIG_HOTPLUG_PCI_CPCI=y
CONFIG_HOTPLUG_PCI_SHPC=y

#
# PCI controller drivers
#
# CONFIG_PCI_AARDVARK is not set
CONFIG_PCIE_XILINX_NWL=y
# CONFIG_PCI_FTPCI100 is not set
# CONFIG_PCI_TEGRA is not set
# CONFIG_PCIE_RCAR_HOST is not set
CONFIG_PCI_HOST_COMMON=y
# CONFIG_PCI_HOST_GENERIC is not set
CONFIG_PCIE_XILINX=y
CONFIG_PCIE_XILINX_CPM=y
# CONFIG_PCI_XGENE is not set
# CONFIG_PCI_V3_SEMI is not set
CONFIG_PCI_VERSATILE=y
CONFIG_PCIE_ALTERA=y
CONFIG_PCIE_ALTERA_MSI=y
CONFIG_PCI_HOST_THUNDER_PEM=y
# CONFIG_PCI_HOST_THUNDER_ECAM is not set
# CONFIG_PCIE_ROCKCHIP_HOST is not set
# CONFIG_PCIE_MEDIATEK is not set
# CONFIG_PCIE_MEDIATEK_GEN3 is not set
# CONFIG_PCIE_BRCMSTB is not set
CONFIG_PCI_LOONGSON=y
# CONFIG_PCIE_MICROCHIP_HOST is not set
# CONFIG_PCIE_APPLE is not set
# CONFIG_PCIE_MT7621 is not set

#
# DesignWare PCI Core Support
#
CONFIG_PCIE_DW=y
CONFIG_PCIE_DW_HOST=y
# CONFIG_PCI_DRA7XX_HOST is not set
CONFIG_PCIE_DW_PLAT=y
CONFIG_PCIE_DW_PLAT_HOST=y
CONFIG_PCI_EXYNOS=y
# CONFIG_PCI_IMX6 is not set
CONFIG_PCIE_SPEAR13XX=y
CONFIG_PCI_KEYSTONE=y
CONFIG_PCI_KEYSTONE_HOST=y
# CONFIG_PCI_LAYERSCAPE is not set
# CONFIG_PCI_HISI is not set
# CONFIG_PCIE_QCOM is not set
CONFIG_PCIE_ARMADA_8K=y
# CONFIG_PCIE_ARTPEC6_HOST is not set
# CONFIG_PCIE_ROCKCHIP_DW_HOST is not set
# CONFIG_PCIE_INTEL_GW is not set
CONFIG_PCIE_KEEMBAY=y
CONFIG_PCIE_KEEMBAY_HOST=y
# CONFIG_PCIE_KIRIN is not set
# CONFIG_PCIE_HISI_STB is not set
# CONFIG_PCI_MESON is not set
CONFIG_PCIE_TEGRA194=y
CONFIG_PCIE_TEGRA194_HOST=y
CONFIG_PCIE_VISCONTI_HOST=y
# CONFIG_PCIE_UNIPHIER is not set
# CONFIG_PCIE_AL is not set
# CONFIG_PCIE_FU740 is not set
# end of DesignWare PCI Core Support

#
# Mobiveil PCIe Core Support
#
# CONFIG_PCIE_MOBIVEIL_PLAT is not set
# CONFIG_PCIE_LAYERSCAPE_GEN4 is not set
# end of Mobiveil PCIe Core Support

#
# Cadence PCIe controllers support
#
# CONFIG_PCIE_CADENCE_PLAT_HOST is not set
# CONFIG_PCI_J721E_HOST is not set
# end of Cadence PCIe controllers support
# end of PCI controller drivers

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set
# end of PCI Endpoint

#
# PCI switch controller drivers
#
CONFIG_PCI_SW_SWITCHTEC=y
# end of PCI switch controller drivers

# CONFIG_CXL_BUS is not set
# CONFIG_PCCARD is not set
CONFIG_RAPIDIO=y
CONFIG_RAPIDIO_DISC_TIMEOUT=30
CONFIG_RAPIDIO_ENABLE_RX_TX_PORTS=y
CONFIG_RAPIDIO_DEBUG=y
CONFIG_RAPIDIO_ENUM_BASIC=y
# CONFIG_RAPIDIO_CHMAN is not set
# CONFIG_RAPIDIO_MPORT_CDEV is not set

#
# RapidIO Switch drivers
#
CONFIG_RAPIDIO_CPS_XX=y
CONFIG_RAPIDIO_CPS_GEN2=y
CONFIG_RAPIDIO_RXS_GEN3=y
# end of RapidIO Switch drivers

#
# Generic Driver Options
#
CONFIG_AUXILIARY_BUS=y
# CONFIG_UEVENT_HELPER is not set
# CONFIG_DEVTMPFS is not set
CONFIG_STANDALONE=y
# CONFIG_PREVENT_FIRMWARE_BUILD is not set

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_EXTRA_FIRMWARE=""
# CONFIG_FW_LOADER_USER_HELPER is not set
CONFIG_FW_LOADER_COMPRESS=y
CONFIG_FW_LOADER_COMPRESS_XZ=y
# CONFIG_FW_LOADER_COMPRESS_ZSTD is not set
# CONFIG_FW_UPLOAD is not set
# end of Firmware loader

CONFIG_WANT_DEV_COREDUMP=y
CONFIG_ALLOW_DEV_COREDUMP=y
CONFIG_DEV_COREDUMP=y
CONFIG_DEBUG_DRIVER=y
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_SOC_BUS=y
CONFIG_REGMAP=y
CONFIG_REGMAP_AC97=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SPI=y
CONFIG_REGMAP_SPMI=y
CONFIG_REGMAP_W1=y
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_REGMAP_SOUNDWIRE=y
CONFIG_REGMAP_SOUNDWIRE_MBQ=y
CONFIG_REGMAP_I3C=y
CONFIG_REGMAP_SPI_AVMM=y
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# end of Generic Driver Options

#
# Bus devices
#
CONFIG_ARM_INTEGRATOR_LM=y
CONFIG_BT1_APB=y
# CONFIG_BT1_AXI is not set
# CONFIG_MOXTET is not set
# CONFIG_HISILICON_LPC is not set
# CONFIG_INTEL_IXP4XX_EB is not set
CONFIG_QCOM_EBI2=y
CONFIG_MHI_BUS=y
CONFIG_MHI_BUS_DEBUG=y
CONFIG_MHI_BUS_PCI_GENERIC=y
CONFIG_MHI_BUS_EP=y
# end of Bus devices

# CONFIG_CONNECTOR is not set

#
# Firmware Drivers
#

#
# ARM System Control and Management Interface Protocol
#
# end of ARM System Control and Management Interface Protocol

#
# EFI (Extensible Firmware Interface) Support
#
# end of EFI (Extensible Firmware Interface) Support

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

# CONFIG_GNSS is not set
# CONFIG_MTD is not set
CONFIG_DTC=y
CONFIG_OF=y
# CONFIG_OF_UNITTEST is not set
# CONFIG_OF_ALL_DTBS is not set
CONFIG_OF_FLATTREE=y
CONFIG_OF_EARLY_FLATTREE=y
CONFIG_OF_KOBJ=y
CONFIG_OF_ADDRESS=y
CONFIG_OF_IRQ=y
CONFIG_OF_RESERVED_MEM=y
# CONFIG_OF_OVERLAY is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
# CONFIG_PARPORT is not set
CONFIG_PNP=y
CONFIG_PNP_DEBUG_MESSAGES=y

#
# Protocols
#
# CONFIG_ISAPNP is not set
CONFIG_PNPACPI=y

#
# NVME Support
#
# end of NVME Support

#
# Misc devices
#
CONFIG_AD525X_DPOT=y
CONFIG_AD525X_DPOT_I2C=y
CONFIG_AD525X_DPOT_SPI=y
CONFIG_DUMMY_IRQ=y
# CONFIG_PHANTOM is not set
CONFIG_TIFM_CORE=y
CONFIG_TIFM_7XX1=y
CONFIG_ICS932S401=y
# CONFIG_ATMEL_SSC is not set
CONFIG_ENCLOSURE_SERVICES=y
CONFIG_GEHC_ACHC=y
# CONFIG_HI6421V600_IRQ is not set
# CONFIG_HP_ILO is not set
CONFIG_QCOM_COINCELL=y
# CONFIG_QCOM_FASTRPC is not set
CONFIG_APDS9802ALS=y
CONFIG_ISL29003=y
CONFIG_ISL29020=y
CONFIG_SENSORS_TSL2550=y
# CONFIG_SENSORS_BH1770 is not set
CONFIG_SENSORS_APDS990X=y
CONFIG_HMC6352=y
CONFIG_DS1682=y
CONFIG_PCH_PHUB=y
CONFIG_LATTICE_ECP3_CONFIG=y
CONFIG_SRAM=y
CONFIG_DW_XDATA_PCIE=y
CONFIG_PCI_ENDPOINT_TEST=y
CONFIG_XILINX_SDFEC=y
# CONFIG_OPEN_DICE is not set
# CONFIG_VCPU_STALL_DETECTOR is not set
CONFIG_C2PORT=y

#
# EEPROM support
#
CONFIG_EEPROM_AT24=y
CONFIG_EEPROM_AT25=y
# CONFIG_EEPROM_LEGACY is not set
CONFIG_EEPROM_MAX6875=y
# CONFIG_EEPROM_93CX6 is not set
# CONFIG_EEPROM_93XX46 is not set
# CONFIG_EEPROM_IDT_89HPESX is not set
CONFIG_EEPROM_EE1004=y
# end of EEPROM support

CONFIG_CB710_CORE=y
# CONFIG_CB710_DEBUG is not set
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
# end of Texas Instruments shared transport line discipline

# CONFIG_SENSORS_LIS3_I2C is not set
CONFIG_ALTERA_STAPL=y
CONFIG_GENWQE=y
CONFIG_GENWQE_PLATFORM_ERROR_RECOVERY=0
CONFIG_ECHO=y
# CONFIG_BCM_VK is not set
CONFIG_MISC_ALCOR_PCI=y
# CONFIG_MISC_RTSX_PCI is not set
CONFIG_HABANA_AI=y
CONFIG_UACCE=y
# CONFIG_PVPANIC is not set
# end of Misc devices

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
# end of SCSI device support

# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=y
CONFIG_FIREWIRE_OHCI=y
CONFIG_FIREWIRE_NET=y
CONFIG_FIREWIRE_NOSY=y
# end of IEEE 1394 (FireWire) support

# CONFIG_NETDEVICES is not set

#
# Input device support
#
CONFIG_INPUT=y
# CONFIG_INPUT_LEDS is not set
CONFIG_INPUT_FF_MEMLESS=y
CONFIG_INPUT_SPARSEKMAP=y
CONFIG_INPUT_MATRIXKMAP=y
CONFIG_INPUT_VIVALDIFMAP=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=y
CONFIG_INPUT_EVDEV=y
CONFIG_INPUT_EVBUG=y

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ADC=y
CONFIG_KEYBOARD_ADP5588=y
CONFIG_KEYBOARD_ADP5589=y
# CONFIG_KEYBOARD_APPLESPI is not set
CONFIG_KEYBOARD_ATKBD=y
CONFIG_KEYBOARD_QT1050=y
CONFIG_KEYBOARD_QT1070=y
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_CLPS711X is not set
CONFIG_KEYBOARD_DLINK_DIR685=y
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_EP93XX is not set
# CONFIG_KEYBOARD_GPIO is not set
# CONFIG_KEYBOARD_GPIO_POLLED is not set
# CONFIG_KEYBOARD_TCA6416 is not set
CONFIG_KEYBOARD_TCA8418=y
# CONFIG_KEYBOARD_MATRIX is not set
CONFIG_KEYBOARD_LM8323=y
CONFIG_KEYBOARD_LM8333=y
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
CONFIG_KEYBOARD_MPR121=y
# CONFIG_KEYBOARD_SNVS_PWRKEY is not set
CONFIG_KEYBOARD_IMX=y
CONFIG_KEYBOARD_IMX_SC_KEY=y
CONFIG_KEYBOARD_NEWTON=y
CONFIG_KEYBOARD_OPENCORES=y
CONFIG_KEYBOARD_SAMSUNG=y
CONFIG_KEYBOARD_GOLDFISH_EVENTS=y
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_ST_KEYSCAN is not set
CONFIG_KEYBOARD_SUNKBD=y
# CONFIG_KEYBOARD_SH_KEYSC is not set
CONFIG_KEYBOARD_IQS62X=y
# CONFIG_KEYBOARD_OMAP4 is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_CAP11XX is not set
# CONFIG_KEYBOARD_BCM is not set
CONFIG_KEYBOARD_MT6779=y
CONFIG_KEYBOARD_MTK_PMIC=y
CONFIG_KEYBOARD_CYPRESS_SF=y
# CONFIG_INPUT_MOUSE is not set
CONFIG_INPUT_JOYSTICK=y
# CONFIG_JOYSTICK_ANALOG is not set
# CONFIG_JOYSTICK_A3D is not set
CONFIG_JOYSTICK_ADC=y
CONFIG_JOYSTICK_ADI=y
CONFIG_JOYSTICK_COBRA=y
CONFIG_JOYSTICK_GF2K=y
CONFIG_JOYSTICK_GRIP=y
CONFIG_JOYSTICK_GRIP_MP=y
CONFIG_JOYSTICK_GUILLEMOT=y
CONFIG_JOYSTICK_INTERACT=y
CONFIG_JOYSTICK_SIDEWINDER=y
CONFIG_JOYSTICK_TMDC=y
CONFIG_JOYSTICK_IFORCE=y
CONFIG_JOYSTICK_IFORCE_232=y
CONFIG_JOYSTICK_WARRIOR=y
CONFIG_JOYSTICK_MAGELLAN=y
CONFIG_JOYSTICK_SPACEORB=y
# CONFIG_JOYSTICK_SPACEBALL is not set
# CONFIG_JOYSTICK_STINGER is not set
# CONFIG_JOYSTICK_TWIDJOY is not set
CONFIG_JOYSTICK_ZHENHUA=y
# CONFIG_JOYSTICK_AS5011 is not set
# CONFIG_JOYSTICK_JOYDUMP is not set
CONFIG_JOYSTICK_PSXPAD_SPI=y
CONFIG_JOYSTICK_PSXPAD_SPI_FF=y
CONFIG_JOYSTICK_QWIIC=y
CONFIG_JOYSTICK_FSIA6B=y
CONFIG_JOYSTICK_SENSEHAT=y
CONFIG_INPUT_TABLET=y
CONFIG_TABLET_SERIAL_WACOM4=y
CONFIG_INPUT_TOUCHSCREEN=y
CONFIG_TOUCHSCREEN_88PM860X=y
# CONFIG_TOUCHSCREEN_ADS7846 is not set
# CONFIG_TOUCHSCREEN_AD7877 is not set
CONFIG_TOUCHSCREEN_AD7879=y
# CONFIG_TOUCHSCREEN_AD7879_I2C is not set
# CONFIG_TOUCHSCREEN_AD7879_SPI is not set
CONFIG_TOUCHSCREEN_ADC=y
# CONFIG_TOUCHSCREEN_AR1021_I2C is not set
# CONFIG_TOUCHSCREEN_ATMEL_MXT is not set
CONFIG_TOUCHSCREEN_AUO_PIXCIR=y
# CONFIG_TOUCHSCREEN_BU21013 is not set
CONFIG_TOUCHSCREEN_BU21029=y
# CONFIG_TOUCHSCREEN_CHIPONE_ICN8318 is not set
CONFIG_TOUCHSCREEN_CHIPONE_ICN8505=y
# CONFIG_TOUCHSCREEN_CY8CTMA140 is not set
CONFIG_TOUCHSCREEN_CY8CTMG110=y
# CONFIG_TOUCHSCREEN_CYTTSP_CORE is not set
# CONFIG_TOUCHSCREEN_CYTTSP4_CORE is not set
# CONFIG_TOUCHSCREEN_DA9034 is not set
CONFIG_TOUCHSCREEN_DYNAPRO=y
# CONFIG_TOUCHSCREEN_HAMPSHIRE is not set
# CONFIG_TOUCHSCREEN_EETI is not set
# CONFIG_TOUCHSCREEN_EGALAX is not set
# CONFIG_TOUCHSCREEN_EGALAX_SERIAL is not set
CONFIG_TOUCHSCREEN_EXC3000=y
# CONFIG_TOUCHSCREEN_FUJITSU is not set
CONFIG_TOUCHSCREEN_GOODIX=y
# CONFIG_TOUCHSCREEN_HIDEEP is not set
CONFIG_TOUCHSCREEN_HYCON_HY46XX=y
CONFIG_TOUCHSCREEN_ILI210X=y
# CONFIG_TOUCHSCREEN_ILITEK is not set
CONFIG_TOUCHSCREEN_IPROC=y
CONFIG_TOUCHSCREEN_S6SY761=y
CONFIG_TOUCHSCREEN_GUNZE=y
# CONFIG_TOUCHSCREEN_EKTF2127 is not set
# CONFIG_TOUCHSCREEN_ELAN is not set
# CONFIG_TOUCHSCREEN_ELO is not set
CONFIG_TOUCHSCREEN_WACOM_W8001=y
CONFIG_TOUCHSCREEN_WACOM_I2C=y
# CONFIG_TOUCHSCREEN_MAX11801 is not set
CONFIG_TOUCHSCREEN_MCS5000=y
# CONFIG_TOUCHSCREEN_MMS114 is not set
CONFIG_TOUCHSCREEN_MELFAS_MIP4=y
CONFIG_TOUCHSCREEN_MSG2638=y
# CONFIG_TOUCHSCREEN_MTOUCH is not set
# CONFIG_TOUCHSCREEN_IMAGIS is not set
CONFIG_TOUCHSCREEN_IMX6UL_TSC=y
CONFIG_TOUCHSCREEN_INEXIO=y
# CONFIG_TOUCHSCREEN_MK712 is not set
# CONFIG_TOUCHSCREEN_PENMOUNT is not set
# CONFIG_TOUCHSCREEN_EDT_FT5X06 is not set
CONFIG_TOUCHSCREEN_RASPBERRYPI_FW=y
CONFIG_TOUCHSCREEN_MIGOR=y
CONFIG_TOUCHSCREEN_TOUCHRIGHT=y
CONFIG_TOUCHSCREEN_TOUCHWIN=y
CONFIG_TOUCHSCREEN_TI_AM335X_TSC=y
CONFIG_TOUCHSCREEN_UCB1400=y
CONFIG_TOUCHSCREEN_PIXCIR=y
CONFIG_TOUCHSCREEN_WDT87XX_I2C=y
# CONFIG_TOUCHSCREEN_WM831X is not set
# CONFIG_TOUCHSCREEN_WM97XX is not set
# CONFIG_TOUCHSCREEN_MXS_LRADC is not set
# CONFIG_TOUCHSCREEN_MX25 is not set
CONFIG_TOUCHSCREEN_MC13783=y
CONFIG_TOUCHSCREEN_TOUCHIT213=y
# CONFIG_TOUCHSCREEN_TS4800 is not set
CONFIG_TOUCHSCREEN_TSC_SERIO=y
# CONFIG_TOUCHSCREEN_TSC2004 is not set
# CONFIG_TOUCHSCREEN_TSC2005 is not set
# CONFIG_TOUCHSCREEN_TSC2007 is not set
CONFIG_TOUCHSCREEN_PCAP=y
# CONFIG_TOUCHSCREEN_RM_TS is not set
# CONFIG_TOUCHSCREEN_SILEAD is not set
CONFIG_TOUCHSCREEN_SIS_I2C=y
# CONFIG_TOUCHSCREEN_ST1232 is not set
CONFIG_TOUCHSCREEN_STMFTS=y
CONFIG_TOUCHSCREEN_SUN4I=y
CONFIG_TOUCHSCREEN_SURFACE3_SPI=y
# CONFIG_TOUCHSCREEN_SX8654 is not set
# CONFIG_TOUCHSCREEN_TPS6507X is not set
CONFIG_TOUCHSCREEN_ZET6223=y
CONFIG_TOUCHSCREEN_ZFORCE=y
CONFIG_TOUCHSCREEN_COLIBRI_VF50=y
CONFIG_TOUCHSCREEN_ROHM_BU21023=y
CONFIG_TOUCHSCREEN_IQS5XX=y
CONFIG_TOUCHSCREEN_ZINITIX=y
CONFIG_INPUT_MISC=y
CONFIG_INPUT_88PM860X_ONKEY=y
CONFIG_INPUT_88PM80X_ONKEY=y
# CONFIG_INPUT_AD714X is not set
CONFIG_INPUT_ARIEL_PWRBUTTON=y
CONFIG_INPUT_ATMEL_CAPTOUCH=y
# CONFIG_INPUT_BMA150 is not set
CONFIG_INPUT_E3X0_BUTTON=y
# CONFIG_INPUT_MAX77650_ONKEY is not set
# CONFIG_INPUT_MC13783_PWRBUTTON is not set
CONFIG_INPUT_MMA8450=y
CONFIG_INPUT_GPIO_BEEPER=y
CONFIG_INPUT_GPIO_DECODER=y
CONFIG_INPUT_GPIO_VIBRA=y
CONFIG_INPUT_CPCAP_PWRBUTTON=y
# CONFIG_INPUT_KXTJ9 is not set
# CONFIG_INPUT_REGULATOR_HAPTIC is not set
CONFIG_INPUT_RETU_PWRBUTTON=y
CONFIG_INPUT_AXP20X_PEK=y
# CONFIG_INPUT_TWL6040_VIBRA is not set
# CONFIG_INPUT_UINPUT is not set
CONFIG_INPUT_PALMAS_PWRBUTTON=y
CONFIG_INPUT_PCF50633_PMU=y
# CONFIG_INPUT_PCF8574 is not set
CONFIG_INPUT_GPIO_ROTARY_ENCODER=y
CONFIG_INPUT_DA7280_HAPTICS=y
CONFIG_INPUT_DA9063_ONKEY=y
# CONFIG_INPUT_WM831X_ON is not set
CONFIG_INPUT_PCAP=y
# CONFIG_INPUT_ADXL34X is not set
CONFIG_INPUT_IQS269A=y
# CONFIG_INPUT_IQS626A is not set
CONFIG_INPUT_IQS7222=y
# CONFIG_INPUT_CMA3000 is not set
CONFIG_INPUT_IDEAPAD_SLIDEBAR=y
# CONFIG_INPUT_DRV260X_HAPTICS is not set
CONFIG_INPUT_DRV2665_HAPTICS=y
CONFIG_INPUT_DRV2667_HAPTICS=y
# CONFIG_INPUT_HISI_POWERKEY is not set
CONFIG_INPUT_SC27XX_VIBRA=y
CONFIG_RMI4_CORE=y
# CONFIG_RMI4_I2C is not set
CONFIG_RMI4_SPI=y
CONFIG_RMI4_SMB=y
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=y
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
# CONFIG_RMI4_F34 is not set
CONFIG_RMI4_F3A=y
# CONFIG_RMI4_F55 is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_PCIPS2=y
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=y
CONFIG_SERIO_ALTERA_PS2=y
# CONFIG_SERIO_PS2MULT is not set
# CONFIG_SERIO_ARC_PS2 is not set
# CONFIG_SERIO_APBPS2 is not set
# CONFIG_SERIO_OLPC_APSP is not set
# CONFIG_SERIO_SUN4I_PS2 is not set
# CONFIG_SERIO_GPIO_PS2 is not set
# CONFIG_USERIO is not set
CONFIG_GAMEPORT=y
CONFIG_GAMEPORT_NS558=y
CONFIG_GAMEPORT_L4=y
CONFIG_GAMEPORT_EMU10K1=y
CONFIG_GAMEPORT_FM801=y
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
# CONFIG_TTY is not set
CONFIG_SERIAL_DEV_BUS=y
CONFIG_IPMI_HANDLER=y
CONFIG_IPMI_PLAT_DATA=y
# CONFIG_IPMI_PANIC_EVENT is not set
CONFIG_IPMI_DEVICE_INTERFACE=y
CONFIG_IPMI_SI=y
CONFIG_IPMI_SSIF=y
CONFIG_IPMI_IPMB=y
# CONFIG_IPMI_WATCHDOG is not set
CONFIG_IPMI_POWEROFF=y
CONFIG_IPMI_KCS_BMC=y
CONFIG_ASPEED_KCS_IPMI_BMC=y
CONFIG_NPCM7XX_KCS_IPMI_BMC=y
# CONFIG_IPMI_KCS_BMC_CDEV_IPMI is not set
CONFIG_IPMI_KCS_BMC_SERIO=y
# CONFIG_ASPEED_BT_IPMI_BMC is not set
CONFIG_IPMB_DEVICE_INTERFACE=y
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=y
CONFIG_HW_RANDOM_ATMEL=y
CONFIG_HW_RANDOM_BA431=y
CONFIG_HW_RANDOM_BCM2835=y
CONFIG_HW_RANDOM_IPROC_RNG200=y
CONFIG_HW_RANDOM_IXP4XX=y
CONFIG_HW_RANDOM_OMAP=y
CONFIG_HW_RANDOM_OMAP3_ROM=y
# CONFIG_HW_RANDOM_VIRTIO is not set
CONFIG_HW_RANDOM_IMX_RNGC=y
CONFIG_HW_RANDOM_NOMADIK=y
CONFIG_HW_RANDOM_STM32=y
CONFIG_HW_RANDOM_MESON=y
# CONFIG_HW_RANDOM_MTK is not set
CONFIG_HW_RANDOM_EXYNOS=y
CONFIG_HW_RANDOM_NPCM=y
CONFIG_HW_RANDOM_KEYSTONE=y
# CONFIG_HW_RANDOM_CCTRNG is not set
# CONFIG_HW_RANDOM_XIPHERA is not set
CONFIG_HW_RANDOM_CN10K=y
CONFIG_APPLICOM=y
CONFIG_DEVMEM=y
# CONFIG_DEVPORT is not set
CONFIG_TCG_TPM=y
# CONFIG_HW_RANDOM_TPM is not set
CONFIG_TCG_TIS_CORE=y
# CONFIG_TCG_TIS is not set
CONFIG_TCG_TIS_SPI=y
CONFIG_TCG_TIS_SPI_CR50=y
# CONFIG_TCG_TIS_I2C is not set
# CONFIG_TCG_TIS_SYNQUACER is not set
CONFIG_TCG_TIS_I2C_CR50=y
# CONFIG_TCG_TIS_I2C_ATMEL is not set
# CONFIG_TCG_TIS_I2C_INFINEON is not set
CONFIG_TCG_TIS_I2C_NUVOTON=y
CONFIG_TCG_ATMEL=y
CONFIG_TCG_INFINEON=y
CONFIG_TCG_CRB=y
# CONFIG_TCG_VTPM_PROXY is not set
# CONFIG_TCG_TIS_ST33ZP24_I2C is not set
# CONFIG_TCG_TIS_ST33ZP24_SPI is not set
CONFIG_XILLYBUS_CLASS=y
CONFIG_XILLYBUS=y
# CONFIG_XILLYBUS_PCIE is not set
# CONFIG_XILLYBUS_OF is not set
# CONFIG_RANDOM_TRUST_CPU is not set
CONFIG_RANDOM_TRUST_BOOTLOADER=y
# end of Character devices

#
# I2C support
#
CONFIG_I2C=y
# CONFIG_ACPI_I2C_OPREGION is not set
CONFIG_I2C_BOARDINFO=y
# CONFIG_I2C_COMPAT is not set
CONFIG_I2C_CHARDEV=y
CONFIG_I2C_MUX=y

#
# Multiplexer I2C Chip support
#
# CONFIG_I2C_ARB_GPIO_CHALLENGE is not set
# CONFIG_I2C_MUX_GPIO is not set
# CONFIG_I2C_MUX_GPMUX is not set
CONFIG_I2C_MUX_LTC4306=y
CONFIG_I2C_MUX_PCA9541=y
CONFIG_I2C_MUX_PCA954x=y
# CONFIG_I2C_MUX_PINCTRL is not set
CONFIG_I2C_MUX_REG=y
# CONFIG_I2C_DEMUX_PINCTRL is not set
# CONFIG_I2C_MUX_MLXCPLD is not set
# end of Multiplexer I2C Chip support

# CONFIG_I2C_HELPER_AUTO is not set
CONFIG_I2C_SMBUS=y

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=y
# CONFIG_I2C_ALGOPCF is not set
CONFIG_I2C_ALGOPCA=y
# end of I2C Algorithms

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
CONFIG_I2C_CCGX_UCSI=y
CONFIG_I2C_ALI1535=y
CONFIG_I2C_ALI1563=y
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
CONFIG_I2C_AMD_MP2=y
# CONFIG_I2C_HIX5HD2 is not set
CONFIG_I2C_I801=y
CONFIG_I2C_ISCH=y
CONFIG_I2C_PIIX4=y
# CONFIG_I2C_NFORCE2 is not set
CONFIG_I2C_NVIDIA_GPU=y
CONFIG_I2C_SIS5595=y
CONFIG_I2C_SIS630=y
CONFIG_I2C_SIS96X=y
CONFIG_I2C_VIA=y
CONFIG_I2C_VIAPRO=y

#
# ACPI drivers
#
CONFIG_I2C_SCMI=y

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_ALTERA is not set
CONFIG_I2C_ASPEED=y
CONFIG_I2C_AT91=y
CONFIG_I2C_AT91_SLAVE_EXPERIMENTAL=y
# CONFIG_I2C_AXXIA is not set
# CONFIG_I2C_BCM2835 is not set
CONFIG_I2C_BCM_IPROC=y
# CONFIG_I2C_BCM_KONA is not set
# CONFIG_I2C_BRCMSTB is not set
CONFIG_I2C_CADENCE=y
CONFIG_I2C_CBUS_GPIO=y
# CONFIG_I2C_DAVINCI is not set
CONFIG_I2C_DESIGNWARE_CORE=y
CONFIG_I2C_DESIGNWARE_SLAVE=y
CONFIG_I2C_DESIGNWARE_PLATFORM=y
# CONFIG_I2C_DESIGNWARE_PCI is not set
CONFIG_I2C_DIGICOLOR=y
CONFIG_I2C_EG20T=y
CONFIG_I2C_EMEV2=y
# CONFIG_I2C_EXYNOS5 is not set
CONFIG_I2C_GPIO=y
CONFIG_I2C_GPIO_FAULT_INJECTOR=y
CONFIG_I2C_HIGHLANDER=y
CONFIG_I2C_HISI=y
CONFIG_I2C_IMG=y
# CONFIG_I2C_IMX is not set
# CONFIG_I2C_IMX_LPI2C is not set
CONFIG_I2C_IOP3XX=y
CONFIG_I2C_JZ4780=y
# CONFIG_I2C_KEMPLD is not set
# CONFIG_I2C_LPC2K is not set
# CONFIG_I2C_MESON is not set
# CONFIG_I2C_MICROCHIP_CORE is not set
# CONFIG_I2C_MT65XX is not set
CONFIG_I2C_MT7621=y
CONFIG_I2C_MV64XXX=y
CONFIG_I2C_MXS=y
# CONFIG_I2C_NPCM is not set
CONFIG_I2C_OCORES=y
# CONFIG_I2C_OMAP is not set
CONFIG_I2C_OWL=y
CONFIG_I2C_APPLE=y
CONFIG_I2C_PCA_PLATFORM=y
CONFIG_I2C_PNX=y
# CONFIG_I2C_PXA is not set
CONFIG_I2C_QCOM_CCI=y
CONFIG_I2C_QCOM_GENI=y
CONFIG_I2C_QUP=y
# CONFIG_I2C_RIIC is not set
# CONFIG_I2C_RK3X is not set
# CONFIG_I2C_RZV2M is not set
CONFIG_I2C_S3C2410=y
# CONFIG_I2C_SH_MOBILE is not set
# CONFIG_I2C_SIMTEC is not set
CONFIG_I2C_SPRD=y
CONFIG_I2C_ST=y
CONFIG_I2C_STM32F4=y
CONFIG_I2C_STM32F7=y
# CONFIG_I2C_SUN6I_P2WI is not set
CONFIG_I2C_SYNQUACER=y
CONFIG_I2C_TEGRA_BPMP=y
CONFIG_I2C_UNIPHIER=y
CONFIG_I2C_UNIPHIER_F=y
# CONFIG_I2C_VERSATILE is not set
# CONFIG_I2C_WMT is not set
# CONFIG_I2C_THUNDERX is not set
CONFIG_I2C_XILINX=y
CONFIG_I2C_XLP9XX=y
# CONFIG_I2C_RCAR is not set

#
# External I2C/SMBus adapter drivers
#

#
# Other I2C/SMBus bus drivers
#
# CONFIG_I2C_MLXCPLD is not set
# CONFIG_I2C_VIRTIO is not set
# end of I2C Hardware Bus support

CONFIG_I2C_SLAVE=y
# CONFIG_I2C_SLAVE_EEPROM is not set
CONFIG_I2C_SLAVE_TESTUNIT=y
# CONFIG_I2C_DEBUG_CORE is not set
CONFIG_I2C_DEBUG_ALGO=y
CONFIG_I2C_DEBUG_BUS=y
# end of I2C support

CONFIG_I3C=y
# CONFIG_CDNS_I3C_MASTER is not set
CONFIG_DW_I3C_MASTER=y
CONFIG_SVC_I3C_MASTER=y
CONFIG_MIPI_I3C_HCI=y
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y
# CONFIG_SPI_MEM is not set

#
# SPI Master Controller Drivers
#
CONFIG_SPI_ALTERA=y
CONFIG_SPI_ALTERA_CORE=y
CONFIG_SPI_ALTERA_DFL=y
# CONFIG_SPI_AR934X is not set
# CONFIG_SPI_ATH79 is not set
CONFIG_SPI_ARMADA_3700=y
# CONFIG_SPI_ASPEED_SMC is not set
# CONFIG_SPI_ATMEL is not set
# CONFIG_SPI_AT91_USART is not set
# CONFIG_SPI_ATMEL_QUADSPI is not set
# CONFIG_SPI_AXI_SPI_ENGINE is not set
# CONFIG_SPI_BCM2835 is not set
# CONFIG_SPI_BCM2835AUX is not set
CONFIG_SPI_BCM63XX=y
# CONFIG_SPI_BCM63XX_HSSPI is not set
CONFIG_SPI_BCM_QSPI=y
CONFIG_SPI_BITBANG=y
# CONFIG_SPI_CADENCE is not set
# CONFIG_SPI_CADENCE_QUADSPI is not set
CONFIG_SPI_CLPS711X=y
CONFIG_SPI_DESIGNWARE=y
CONFIG_SPI_DW_DMA=y
CONFIG_SPI_DW_PCI=y
CONFIG_SPI_DW_MMIO=y
# CONFIG_SPI_DW_BT1 is not set
CONFIG_SPI_EP93XX=y
# CONFIG_SPI_FSL_LPSPI is not set
# CONFIG_SPI_FSL_QUADSPI is not set
CONFIG_SPI_GXP=y
CONFIG_SPI_HISI_KUNPENG=y
CONFIG_SPI_HISI_SFC_V3XX=y
CONFIG_SPI_NXP_FLEXSPI=y
CONFIG_SPI_GPIO=y
# CONFIG_SPI_IMG_SPFI is not set
CONFIG_SPI_IMX=y
CONFIG_SPI_INGENIC=y
# CONFIG_SPI_JCORE is not set
CONFIG_SPI_LP8841_RTC=y
# CONFIG_SPI_FSL_SPI is not set
# CONFIG_SPI_FSL_DSPI is not set
CONFIG_SPI_MESON_SPICC=y
# CONFIG_SPI_MESON_SPIFC is not set
CONFIG_SPI_MICROCHIP_CORE=y
CONFIG_SPI_MT65XX=y
# CONFIG_SPI_MT7621 is not set
CONFIG_SPI_MTK_NOR=y
# CONFIG_SPI_NPCM_FIU is not set
CONFIG_SPI_NPCM_PSPI=y
CONFIG_SPI_LANTIQ_SSC=y
CONFIG_SPI_OC_TINY=y
# CONFIG_SPI_OMAP24XX is not set
CONFIG_SPI_TI_QSPI=y
CONFIG_SPI_OMAP_100K=y
# CONFIG_SPI_ORION is not set
CONFIG_SPI_PIC32=y
# CONFIG_SPI_PIC32_SQI is not set
# CONFIG_SPI_PXA2XX is not set
# CONFIG_SPI_ROCKCHIP is not set
# CONFIG_SPI_ROCKCHIP_SFC is not set
# CONFIG_SPI_RSPI is not set
CONFIG_SPI_QUP=y
CONFIG_SPI_QCOM_GENI=y
CONFIG_SPI_S3C64XX=y
# CONFIG_SPI_SC18IS602 is not set
# CONFIG_SPI_SH_MSIOF is not set
CONFIG_SPI_SH=y
CONFIG_SPI_SH_HSPI=y
# CONFIG_SPI_SIFIVE is not set
CONFIG_SPI_SPRD=y
CONFIG_SPI_SPRD_ADI=y
# CONFIG_SPI_STM32 is not set
CONFIG_SPI_ST_SSC4=y
CONFIG_SPI_SUN4I=y
CONFIG_SPI_SUN6I=y
CONFIG_SPI_SUNPLUS_SP7021=y
CONFIG_SPI_SYNQUACER=y
# CONFIG_SPI_MXIC is not set
CONFIG_SPI_TEGRA210_QUAD=y
# CONFIG_SPI_TEGRA114 is not set
# CONFIG_SPI_TEGRA20_SFLASH is not set
CONFIG_SPI_TEGRA20_SLINK=y
CONFIG_SPI_THUNDERX=y
# CONFIG_SPI_TOPCLIFF_PCH is not set
# CONFIG_SPI_UNIPHIER is not set
CONFIG_SPI_XCOMM=y
CONFIG_SPI_XILINX=y
# CONFIG_SPI_XLP is not set
CONFIG_SPI_XTENSA_XTFPGA=y
CONFIG_SPI_ZYNQ_QSPI=y
CONFIG_SPI_ZYNQMP_GQSPI=y
CONFIG_SPI_AMD=y

#
# SPI Multiplexer support
#
CONFIG_SPI_MUX=y

#
# SPI Protocol Masters
#
CONFIG_SPI_SPIDEV=y
CONFIG_SPI_TLE62X0=y
# CONFIG_SPI_SLAVE is not set
CONFIG_SPI_DYNAMIC=y
CONFIG_SPMI=y
# CONFIG_SPMI_HISI3670 is not set
CONFIG_SPMI_MSM_PMIC_ARB=y
CONFIG_SPMI_MTK_PMIF=y
CONFIG_HSI=y
CONFIG_HSI_BOARDINFO=y

#
# HSI controllers
#

#
# HSI clients
#
CONFIG_HSI_CHAR=y
CONFIG_PPS=y
CONFIG_PPS_DEBUG=y
CONFIG_NTP_PPS=y

#
# PPS clients support
#
CONFIG_PPS_CLIENT_KTIMER=y
CONFIG_PPS_CLIENT_GPIO=y

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK_OPTIONAL=y

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
# end of PTP clock support

CONFIG_PINCTRL=y
CONFIG_PINMUX=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
CONFIG_PINCTRL_AMD=y
# CONFIG_PINCTRL_AT91PIO4 is not set
# CONFIG_PINCTRL_AXP209 is not set
# CONFIG_PINCTRL_BM1880 is not set
# CONFIG_PINCTRL_DA850_PUPD is not set
# CONFIG_PINCTRL_EQUILIBRIUM is not set
# CONFIG_PINCTRL_INGENIC is not set
# CONFIG_PINCTRL_LPC18XX is not set
CONFIG_PINCTRL_MCP23S08_I2C=y
CONFIG_PINCTRL_MCP23S08_SPI=y
CONFIG_PINCTRL_MCP23S08=y
# CONFIG_PINCTRL_MICROCHIP_SGPIO is not set
# CONFIG_PINCTRL_OCELOT is not set
# CONFIG_PINCTRL_PALMAS is not set
# CONFIG_PINCTRL_PISTACHIO is not set
# CONFIG_PINCTRL_ROCKCHIP is not set
# CONFIG_PINCTRL_SINGLE is not set
# CONFIG_PINCTRL_STARFIVE is not set
# CONFIG_PINCTRL_STMFX is not set
# CONFIG_PINCTRL_SX150X is not set
# CONFIG_PINCTRL_OWL is not set
# CONFIG_PINCTRL_ASPEED_G4 is not set
# CONFIG_PINCTRL_ASPEED_G5 is not set
# CONFIG_PINCTRL_ASPEED_G6 is not set
# CONFIG_PINCTRL_BCM281XX is not set
# CONFIG_PINCTRL_BCM2835 is not set
# CONFIG_PINCTRL_BCM4908 is not set
# CONFIG_PINCTRL_BCM6318 is not set
# CONFIG_PINCTRL_BCM6328 is not set
# CONFIG_PINCTRL_BCM6358 is not set
# CONFIG_PINCTRL_BCM6362 is not set
# CONFIG_PINCTRL_BCM6368 is not set
# CONFIG_PINCTRL_BCM63268 is not set
# CONFIG_PINCTRL_IPROC_GPIO is not set
# CONFIG_PINCTRL_CYGNUS_MUX is not set
# CONFIG_PINCTRL_NS is not set
# CONFIG_PINCTRL_NSP_GPIO is not set
# CONFIG_PINCTRL_NS2_MUX is not set
# CONFIG_PINCTRL_NSP_MUX is not set
# CONFIG_PINCTRL_AS370 is not set
# CONFIG_PINCTRL_BERLIN_BG4CT is not set
CONFIG_PINCTRL_MADERA=y
CONFIG_PINCTRL_CS47L15=y
CONFIG_PINCTRL_CS47L35=y
CONFIG_PINCTRL_CS47L90=y

#
# Intel pinctrl drivers
#
CONFIG_PINCTRL_BAYTRAIL=y
CONFIG_PINCTRL_CHERRYVIEW=y
# CONFIG_PINCTRL_LYNXPOINT is not set
CONFIG_PINCTRL_INTEL=y
CONFIG_PINCTRL_ALDERLAKE=y
CONFIG_PINCTRL_BROXTON=y
CONFIG_PINCTRL_CANNONLAKE=y
CONFIG_PINCTRL_CEDARFORK=y
CONFIG_PINCTRL_DENVERTON=y
CONFIG_PINCTRL_ELKHARTLAKE=y
CONFIG_PINCTRL_EMMITSBURG=y
# CONFIG_PINCTRL_GEMINILAKE is not set
# CONFIG_PINCTRL_ICELAKE is not set
CONFIG_PINCTRL_JASPERLAKE=y
CONFIG_PINCTRL_LAKEFIELD=y
# CONFIG_PINCTRL_LEWISBURG is not set
# CONFIG_PINCTRL_METEORLAKE is not set
# CONFIG_PINCTRL_SUNRISEPOINT is not set
CONFIG_PINCTRL_TIGERLAKE=y
# end of Intel pinctrl drivers

#
# MediaTek pinctrl drivers
#
CONFIG_EINT_MTK=y
# CONFIG_PINCTRL_MT2701 is not set
# CONFIG_PINCTRL_MT7623 is not set
# CONFIG_PINCTRL_MT7629 is not set
# CONFIG_PINCTRL_MT8135 is not set
# CONFIG_PINCTRL_MT8127 is not set
# CONFIG_PINCTRL_MT2712 is not set
# CONFIG_PINCTRL_MT6765 is not set
# CONFIG_PINCTRL_MT6779 is not set
# CONFIG_PINCTRL_MT6795 is not set
# CONFIG_PINCTRL_MT6797 is not set
# CONFIG_PINCTRL_MT7622 is not set
# CONFIG_PINCTRL_MT7986 is not set
# CONFIG_PINCTRL_MT8167 is not set
# CONFIG_PINCTRL_MT8173 is not set
# CONFIG_PINCTRL_MT8183 is not set
# CONFIG_PINCTRL_MT8186 is not set
# CONFIG_PINCTRL_MT8192 is not set
# CONFIG_PINCTRL_MT8195 is not set
# CONFIG_PINCTRL_MT8365 is not set
# CONFIG_PINCTRL_MT8516 is not set
# CONFIG_PINCTRL_MT6397 is not set
# end of MediaTek pinctrl drivers

CONFIG_PINCTRL_MESON=y
# CONFIG_PINCTRL_WPCM450 is not set
# CONFIG_PINCTRL_NPCM7XX is not set
# CONFIG_PINCTRL_PXA25X is not set
# CONFIG_PINCTRL_PXA27X is not set
# CONFIG_PINCTRL_MSM is not set
# CONFIG_PINCTRL_QCOM_SPMI_PMIC is not set
# CONFIG_PINCTRL_QCOM_SSBI_PMIC is not set
# CONFIG_PINCTRL_LPASS_LPI is not set

#
# Renesas pinctrl drivers
#
CONFIG_PINCTRL_RENESAS=y
CONFIG_PINCTRL_SH_PFC=y
CONFIG_PINCTRL_SH_PFC_GPIO=y
CONFIG_PINCTRL_SH_FUNC_GPIO=y
# CONFIG_PINCTRL_PFC_EMEV2 is not set
# CONFIG_PINCTRL_PFC_R8A77995 is not set
CONFIG_PINCTRL_PFC_R8A7794=y
CONFIG_PINCTRL_PFC_R8A77990=y
# CONFIG_PINCTRL_PFC_R8A7779 is not set
# CONFIG_PINCTRL_PFC_R8A7790 is not set
# CONFIG_PINCTRL_PFC_R8A77950 is not set
# CONFIG_PINCTRL_PFC_R8A77951 is not set
# CONFIG_PINCTRL_PFC_R8A7778 is not set
# CONFIG_PINCTRL_PFC_R8A7793 is not set
CONFIG_PINCTRL_PFC_R8A7791=y
CONFIG_PINCTRL_PFC_R8A77965=y
CONFIG_PINCTRL_PFC_R8A77960=y
# CONFIG_PINCTRL_PFC_R8A77961 is not set
# CONFIG_PINCTRL_PFC_R8A779F0 is not set
# CONFIG_PINCTRL_PFC_R8A7792 is not set
# CONFIG_PINCTRL_PFC_R8A77980 is not set
CONFIG_PINCTRL_PFC_R8A77970=y
# CONFIG_PINCTRL_PFC_R8A779A0 is not set
CONFIG_PINCTRL_PFC_R8A779G0=y
CONFIG_PINCTRL_PFC_R8A7740=y
# CONFIG_PINCTRL_PFC_R8A73A4 is not set
# CONFIG_PINCTRL_RZA1 is not set
# CONFIG_PINCTRL_RZA2 is not set
# CONFIG_PINCTRL_RZG2L is not set
CONFIG_PINCTRL_PFC_R8A77470=y
CONFIG_PINCTRL_PFC_R8A7745=y
CONFIG_PINCTRL_PFC_R8A7742=y
CONFIG_PINCTRL_PFC_R8A7743=y
CONFIG_PINCTRL_PFC_R8A7744=y
CONFIG_PINCTRL_PFC_R8A774C0=y
# CONFIG_PINCTRL_PFC_R8A774E1 is not set
# CONFIG_PINCTRL_PFC_R8A774A1 is not set
# CONFIG_PINCTRL_PFC_R8A774B1 is not set
# CONFIG_PINCTRL_RZN1 is not set
# CONFIG_PINCTRL_RZV2M is not set
# CONFIG_PINCTRL_PFC_SH7203 is not set
CONFIG_PINCTRL_PFC_SH7264=y
# CONFIG_PINCTRL_PFC_SH7269 is not set
# CONFIG_PINCTRL_PFC_SH7720 is not set
# CONFIG_PINCTRL_PFC_SH7722 is not set
# CONFIG_PINCTRL_PFC_SH7734 is not set
# CONFIG_PINCTRL_PFC_SH7757 is not set
CONFIG_PINCTRL_PFC_SH7785=y
CONFIG_PINCTRL_PFC_SH7786=y
CONFIG_PINCTRL_PFC_SH73A0=y
CONFIG_PINCTRL_PFC_SH7723=y
CONFIG_PINCTRL_PFC_SH7724=y
# CONFIG_PINCTRL_PFC_SHX3 is not set
# end of Renesas pinctrl drivers

# CONFIG_PINCTRL_EXYNOS is not set
# CONFIG_PINCTRL_S3C24XX is not set
# CONFIG_PINCTRL_S3C64XX is not set
# CONFIG_PINCTRL_SPRD_SC9860 is not set
# CONFIG_PINCTRL_STM32F429 is not set
# CONFIG_PINCTRL_STM32F469 is not set
# CONFIG_PINCTRL_STM32F746 is not set
# CONFIG_PINCTRL_STM32F769 is not set
# CONFIG_PINCTRL_STM32H743 is not set
# CONFIG_PINCTRL_STM32MP135 is not set
# CONFIG_PINCTRL_STM32MP157 is not set
# CONFIG_PINCTRL_TI_IODELAY is not set
CONFIG_PINCTRL_UNIPHIER=y
# CONFIG_PINCTRL_UNIPHIER_LD4 is not set
# CONFIG_PINCTRL_UNIPHIER_PRO4 is not set
# CONFIG_PINCTRL_UNIPHIER_SLD8 is not set
# CONFIG_PINCTRL_UNIPHIER_PRO5 is not set
# CONFIG_PINCTRL_UNIPHIER_PXS2 is not set
# CONFIG_PINCTRL_UNIPHIER_LD6B is not set
# CONFIG_PINCTRL_UNIPHIER_LD11 is not set
# CONFIG_PINCTRL_UNIPHIER_LD20 is not set
# CONFIG_PINCTRL_UNIPHIER_PXS3 is not set
# CONFIG_PINCTRL_UNIPHIER_NX1 is not set
# CONFIG_PINCTRL_TMPV7700 is not set
CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_OF_GPIO=y
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_CDEV=y
CONFIG_GPIO_CDEV_V1=y
CONFIG_GPIO_GENERIC=y
CONFIG_GPIO_REGMAP=y

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_74XX_MMIO is not set
# CONFIG_GPIO_ALTERA is not set
CONFIG_GPIO_AMDPT=y
# CONFIG_GPIO_ASPEED is not set
# CONFIG_GPIO_ASPEED_SGPIO is not set
# CONFIG_GPIO_ATH79 is not set
# CONFIG_GPIO_RASPBERRYPI_EXP is not set
# CONFIG_GPIO_BCM_KONA is not set
# CONFIG_GPIO_BCM_XGS_IPROC is not set
# CONFIG_GPIO_BRCMSTB is not set
# CONFIG_GPIO_CADENCE is not set
CONFIG_GPIO_CLPS711X=y
CONFIG_GPIO_DWAPB=y
# CONFIG_GPIO_EIC_SPRD is not set
# CONFIG_GPIO_EM is not set
# CONFIG_GPIO_FTGPIO010 is not set
# CONFIG_GPIO_GENERIC_PLATFORM is not set
# CONFIG_GPIO_GRGPIO is not set
CONFIG_GPIO_HISI=y
# CONFIG_GPIO_HLWD is not set
# CONFIG_GPIO_IOP is not set
# CONFIG_GPIO_LOGICVC is not set
# CONFIG_GPIO_LPC18XX is not set
# CONFIG_GPIO_LPC32XX is not set
CONFIG_GPIO_MB86S7X=y
# CONFIG_GPIO_MENZ127 is not set
# CONFIG_GPIO_MPC8XXX is not set
# CONFIG_GPIO_MT7621 is not set
CONFIG_GPIO_MXC=y
CONFIG_GPIO_MXS=y
# CONFIG_GPIO_PMIC_EIC_SPRD is not set
CONFIG_GPIO_PXA=y
CONFIG_GPIO_RCAR=y
# CONFIG_GPIO_RDA is not set
CONFIG_GPIO_ROCKCHIP=y
# CONFIG_GPIO_SAMA5D2_PIOBU is not set
# CONFIG_GPIO_SIFIVE is not set
CONFIG_GPIO_SIOX=y
# CONFIG_GPIO_SNPS_CREG is not set
# CONFIG_GPIO_SPRD is not set
# CONFIG_GPIO_STP_XWAY is not set
# CONFIG_GPIO_SYSCON is not set
# CONFIG_GPIO_TEGRA is not set
# CONFIG_GPIO_TEGRA186 is not set
# CONFIG_GPIO_TS4800 is not set
# CONFIG_GPIO_THUNDERX is not set
# CONFIG_GPIO_UNIPHIER is not set
# CONFIG_GPIO_VISCONTI is not set
CONFIG_GPIO_VX855=y
CONFIG_GPIO_XGENE_SB=y
# CONFIG_GPIO_XILINX is not set
CONFIG_GPIO_XLP=y
# CONFIG_GPIO_AMD_FCH is not set
CONFIG_GPIO_IDT3243X=y
# end of Memory mapped GPIO drivers

#
# I2C GPIO expanders
#
# CONFIG_GPIO_ADP5588 is not set
# CONFIG_GPIO_ADNP is not set
# CONFIG_GPIO_GW_PLD is not set
# CONFIG_GPIO_MAX7300 is not set
# CONFIG_GPIO_MAX732X is not set
# CONFIG_GPIO_PCA953X is not set
CONFIG_GPIO_PCA9570=y
CONFIG_GPIO_PCF857X=y
CONFIG_GPIO_TPIC2810=y
CONFIG_GPIO_TS4900=y
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
CONFIG_GPIO_BD9571MWV=y
CONFIG_GPIO_JANZ_TTL=y
# CONFIG_GPIO_KEMPLD is not set
CONFIG_GPIO_LP3943=y
CONFIG_GPIO_LP873X=y
CONFIG_GPIO_MADERA=y
CONFIG_GPIO_MAX77650=y
# CONFIG_GPIO_PALMAS is not set
CONFIG_GPIO_RC5T583=y
CONFIG_GPIO_SL28CPLD=y
CONFIG_GPIO_TPS65086=y
# CONFIG_GPIO_TPS65910 is not set
CONFIG_GPIO_TPS65912=y
# CONFIG_GPIO_TQMX86 is not set
CONFIG_GPIO_TWL6040=y
# CONFIG_GPIO_UCB1400 is not set
# CONFIG_GPIO_WM831X is not set
# CONFIG_GPIO_WM8994 is not set
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
CONFIG_GPIO_BT8XX=y
# CONFIG_GPIO_MLXBF is not set
CONFIG_GPIO_MLXBF2=y
CONFIG_GPIO_ML_IOH=y
# CONFIG_GPIO_PCH is not set
CONFIG_GPIO_PCI_IDIO_16=y
CONFIG_GPIO_PCIE_IDIO_24=y
# CONFIG_GPIO_RDC321X is not set
# end of PCI GPIO expanders

#
# SPI GPIO expanders
#
# CONFIG_GPIO_74X164 is not set
# CONFIG_GPIO_MAX3191X is not set
# CONFIG_GPIO_MAX7301 is not set
CONFIG_GPIO_MC33880=y
CONFIG_GPIO_PISOSR=y
# CONFIG_GPIO_XRA1403 is not set
# end of SPI GPIO expanders

#
# Virtual GPIO drivers
#
# CONFIG_GPIO_AGGREGATOR is not set
CONFIG_GPIO_MOCKUP=y
CONFIG_GPIO_VIRTIO=y
CONFIG_GPIO_SIM=y
# end of Virtual GPIO drivers

CONFIG_W1=y

#
# 1-wire Bus Masters
#
CONFIG_W1_MASTER_MATROX=y
CONFIG_W1_MASTER_DS2482=y
CONFIG_W1_MASTER_MXC=y
CONFIG_W1_MASTER_DS1WM=y
CONFIG_W1_MASTER_GPIO=y
CONFIG_W1_MASTER_SGI=y
# end of 1-wire Bus Masters

#
# 1-wire Slaves
#
# CONFIG_W1_SLAVE_THERM is not set
CONFIG_W1_SLAVE_SMEM=y
# CONFIG_W1_SLAVE_DS2405 is not set
CONFIG_W1_SLAVE_DS2408=y
CONFIG_W1_SLAVE_DS2408_READBACK=y
CONFIG_W1_SLAVE_DS2413=y
CONFIG_W1_SLAVE_DS2406=y
# CONFIG_W1_SLAVE_DS2423 is not set
CONFIG_W1_SLAVE_DS2805=y
# CONFIG_W1_SLAVE_DS2430 is not set
# CONFIG_W1_SLAVE_DS2431 is not set
CONFIG_W1_SLAVE_DS2433=y
# CONFIG_W1_SLAVE_DS2433_CRC is not set
CONFIG_W1_SLAVE_DS2438=y
CONFIG_W1_SLAVE_DS250X=y
# CONFIG_W1_SLAVE_DS2780 is not set
CONFIG_W1_SLAVE_DS2781=y
CONFIG_W1_SLAVE_DS28E04=y
CONFIG_W1_SLAVE_DS28E17=y
# end of 1-wire Slaves

# CONFIG_POWER_RESET is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
# CONFIG_POWER_SUPPLY_HWMON is not set
# CONFIG_PDA_POWER is not set
# CONFIG_GENERIC_ADC_BATTERY is not set
CONFIG_IP5XXX_POWER=y
# CONFIG_WM831X_BACKUP is not set
CONFIG_WM831X_POWER=y
CONFIG_TEST_POWER=y
# CONFIG_BATTERY_88PM860X is not set
# CONFIG_CHARGER_ADP5061 is not set
CONFIG_BATTERY_ACT8945A=y
CONFIG_BATTERY_CPCAP=y
CONFIG_BATTERY_CW2015=y
CONFIG_BATTERY_DS2760=y
# CONFIG_BATTERY_DS2780 is not set
CONFIG_BATTERY_DS2781=y
CONFIG_BATTERY_DS2782=y
# CONFIG_BATTERY_LEGO_EV3 is not set
CONFIG_BATTERY_SAMSUNG_SDI=y
CONFIG_BATTERY_SBS=y
CONFIG_CHARGER_SBS=y
# CONFIG_MANAGER_SBS is not set
# CONFIG_BATTERY_BQ27XXX is not set
CONFIG_BATTERY_DA9030=y
CONFIG_CHARGER_DA9150=y
CONFIG_BATTERY_DA9150=y
CONFIG_CHARGER_AXP20X=y
CONFIG_BATTERY_AXP20X=y
CONFIG_AXP20X_POWER=y
# CONFIG_BATTERY_MAX17040 is not set
CONFIG_BATTERY_MAX17042=y
CONFIG_BATTERY_MAX1721X=y
CONFIG_CHARGER_PCF50633=y
CONFIG_CHARGER_CPCAP=y
CONFIG_CHARGER_MAX8903=y
# CONFIG_CHARGER_LP8727 is not set
CONFIG_CHARGER_GPIO=y
CONFIG_CHARGER_MANAGER=y
CONFIG_CHARGER_LT3651=y
CONFIG_CHARGER_LTC4162L=y
# CONFIG_CHARGER_MAX14577 is not set
# CONFIG_CHARGER_DETECTOR_MAX14656 is not set
CONFIG_CHARGER_MAX77650=y
CONFIG_CHARGER_MAX77976=y
CONFIG_CHARGER_MAX8997=y
# CONFIG_CHARGER_QCOM_SMBB is not set
# CONFIG_CHARGER_BQ2415X is not set
CONFIG_CHARGER_BQ24190=y
# CONFIG_CHARGER_BQ24257 is not set
# CONFIG_CHARGER_BQ24735 is not set
CONFIG_CHARGER_BQ2515X=y
CONFIG_CHARGER_BQ25890=y
CONFIG_CHARGER_BQ25980=y
CONFIG_CHARGER_BQ256XX=y
# CONFIG_CHARGER_SMB347 is not set
CONFIG_BATTERY_GAUGE_LTC2941=y
CONFIG_BATTERY_GOLDFISH=y
CONFIG_BATTERY_RT5033=y
CONFIG_CHARGER_RT9455=y
CONFIG_CHARGER_SC2731=y
# CONFIG_FUEL_GAUGE_SC27XX is not set
# CONFIG_CHARGER_UCS1002 is not set
# CONFIG_CHARGER_BD99954 is not set
CONFIG_BATTERY_ACER_A500=y
CONFIG_BATTERY_UG3105=y
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
CONFIG_HWMON_DEBUG_CHIP=y

#
# Native drivers
#
# CONFIG_SENSORS_AD7314 is not set
CONFIG_SENSORS_AD7414=y
# CONFIG_SENSORS_AD7418 is not set
CONFIG_SENSORS_ADM1025=y
CONFIG_SENSORS_ADM1026=y
CONFIG_SENSORS_ADM1029=y
CONFIG_SENSORS_ADM1031=y
CONFIG_SENSORS_ADM1177=y
CONFIG_SENSORS_ADM9240=y
CONFIG_SENSORS_ADT7X10=y
CONFIG_SENSORS_ADT7310=y
# CONFIG_SENSORS_ADT7410 is not set
CONFIG_SENSORS_ADT7411=y
# CONFIG_SENSORS_ADT7462 is not set
# CONFIG_SENSORS_ADT7470 is not set
CONFIG_SENSORS_ADT7475=y
CONFIG_SENSORS_AHT10=y
# CONFIG_SENSORS_AS370 is not set
CONFIG_SENSORS_ASC7621=y
# CONFIG_SENSORS_AXI_FAN_CONTROL is not set
# CONFIG_SENSORS_ARM_SCMI is not set
CONFIG_SENSORS_ARM_SCPI=y
# CONFIG_SENSORS_ASB100 is not set
CONFIG_SENSORS_ASPEED=y
# CONFIG_SENSORS_ATXP1 is not set
# CONFIG_SENSORS_BT1_PVT is not set
# CONFIG_SENSORS_CORSAIR_CPRO is not set
CONFIG_SENSORS_CORSAIR_PSU=y
# CONFIG_SENSORS_DS620 is not set
# CONFIG_SENSORS_DS1621 is not set
CONFIG_SENSORS_I5K_AMB=y
CONFIG_SENSORS_SPARX5=y
CONFIG_SENSORS_F71805F=y
# CONFIG_SENSORS_F71882FG is not set
# CONFIG_SENSORS_F75375S is not set
CONFIG_SENSORS_MC13783_ADC=y
# CONFIG_SENSORS_FSCHMD is not set
CONFIG_SENSORS_FTSTEUTATES=y
CONFIG_SENSORS_GL518SM=y
# CONFIG_SENSORS_GL520SM is not set
# CONFIG_SENSORS_G760A is not set
CONFIG_SENSORS_G762=y
# CONFIG_SENSORS_GPIO_FAN is not set
CONFIG_SENSORS_HIH6130=y
CONFIG_SENSORS_IBMAEM=y
CONFIG_SENSORS_IBMPEX=y
# CONFIG_SENSORS_IIO_HWMON is not set
CONFIG_SENSORS_IT87=y
CONFIG_SENSORS_JC42=y
CONFIG_SENSORS_POWR1220=y
CONFIG_SENSORS_LAN966X=y
CONFIG_SENSORS_LINEAGE=y
CONFIG_SENSORS_LTC2945=y
CONFIG_SENSORS_LTC2947=y
CONFIG_SENSORS_LTC2947_I2C=y
CONFIG_SENSORS_LTC2947_SPI=y
CONFIG_SENSORS_LTC2990=y
CONFIG_SENSORS_LTC2992=y
# CONFIG_SENSORS_LTC4151 is not set
CONFIG_SENSORS_LTC4215=y
# CONFIG_SENSORS_LTC4222 is not set
CONFIG_SENSORS_LTC4245=y
CONFIG_SENSORS_LTC4260=y
CONFIG_SENSORS_LTC4261=y
# CONFIG_SENSORS_MAX1111 is not set
CONFIG_SENSORS_MAX127=y
# CONFIG_SENSORS_MAX16065 is not set
CONFIG_SENSORS_MAX1619=y
CONFIG_SENSORS_MAX1668=y
CONFIG_SENSORS_MAX197=y
# CONFIG_SENSORS_MAX31722 is not set
CONFIG_SENSORS_MAX31730=y
# CONFIG_SENSORS_MAX6620 is not set
# CONFIG_SENSORS_MAX6621 is not set
# CONFIG_SENSORS_MAX6639 is not set
# CONFIG_SENSORS_MAX6650 is not set
CONFIG_SENSORS_MAX6697=y
CONFIG_SENSORS_MAX31790=y
CONFIG_SENSORS_MCP3021=y
CONFIG_SENSORS_TC654=y
CONFIG_SENSORS_TPS23861=y
CONFIG_SENSORS_MR75203=y
CONFIG_SENSORS_ADCXX=y
CONFIG_SENSORS_LM63=y
CONFIG_SENSORS_LM70=y
CONFIG_SENSORS_LM73=y
CONFIG_SENSORS_LM75=y
# CONFIG_SENSORS_LM77 is not set
CONFIG_SENSORS_LM78=y
CONFIG_SENSORS_LM80=y
CONFIG_SENSORS_LM83=y
# CONFIG_SENSORS_LM85 is not set
# CONFIG_SENSORS_LM87 is not set
CONFIG_SENSORS_LM90=y
# CONFIG_SENSORS_LM92 is not set
CONFIG_SENSORS_LM93=y
CONFIG_SENSORS_LM95234=y
# CONFIG_SENSORS_LM95241 is not set
# CONFIG_SENSORS_LM95245 is not set
CONFIG_SENSORS_PC87360=y
# CONFIG_SENSORS_PC87427 is not set
CONFIG_SENSORS_NTC_THERMISTOR=y
# CONFIG_SENSORS_NCT6683 is not set
CONFIG_SENSORS_NCT6775_CORE=y
CONFIG_SENSORS_NCT6775=y
# CONFIG_SENSORS_NCT6775_I2C is not set
CONFIG_SENSORS_NCT7802=y
# CONFIG_SENSORS_NCT7904 is not set
# CONFIG_SENSORS_NPCM7XX is not set
# CONFIG_SENSORS_NSA320 is not set
# CONFIG_SENSORS_OCC_P8_I2C is not set
CONFIG_SENSORS_PCF8591=y
CONFIG_SENSORS_PECI_CPUTEMP=y
# CONFIG_SENSORS_PECI_DIMMTEMP is not set
CONFIG_SENSORS_PECI=y
CONFIG_PMBUS=y
CONFIG_SENSORS_PMBUS=y
CONFIG_SENSORS_ADM1266=y
CONFIG_SENSORS_ADM1275=y
CONFIG_SENSORS_BEL_PFE=y
CONFIG_SENSORS_BPA_RS600=y
CONFIG_SENSORS_DELTA_AHE50DC_FAN=y
CONFIG_SENSORS_FSP_3Y=y
CONFIG_SENSORS_IBM_CFFPS=y
# CONFIG_SENSORS_DPS920AB is not set
# CONFIG_SENSORS_INSPUR_IPSPS is not set
CONFIG_SENSORS_IR35221=y
CONFIG_SENSORS_IR36021=y
# CONFIG_SENSORS_IR38064 is not set
# CONFIG_SENSORS_IRPS5401 is not set
CONFIG_SENSORS_ISL68137=y
CONFIG_SENSORS_LM25066=y
CONFIG_SENSORS_LM25066_REGULATOR=y
CONFIG_SENSORS_LT7182S=y
# CONFIG_SENSORS_LTC2978 is not set
CONFIG_SENSORS_LTC3815=y
CONFIG_SENSORS_MAX15301=y
# CONFIG_SENSORS_MAX16064 is not set
CONFIG_SENSORS_MAX16601=y
CONFIG_SENSORS_MAX20730=y
# CONFIG_SENSORS_MAX20751 is not set
# CONFIG_SENSORS_MAX31785 is not set
CONFIG_SENSORS_MAX34440=y
CONFIG_SENSORS_MAX8688=y
CONFIG_SENSORS_MP2888=y
# CONFIG_SENSORS_MP2975 is not set
CONFIG_SENSORS_MP5023=y
# CONFIG_SENSORS_PIM4328 is not set
# CONFIG_SENSORS_PLI1209BC is not set
CONFIG_SENSORS_PM6764TR=y
CONFIG_SENSORS_PXE1610=y
CONFIG_SENSORS_Q54SJ108A2=y
CONFIG_SENSORS_STPDDC60=y
# CONFIG_SENSORS_TPS40422 is not set
CONFIG_SENSORS_TPS53679=y
# CONFIG_SENSORS_UCD9000 is not set
# CONFIG_SENSORS_UCD9200 is not set
# CONFIG_SENSORS_XDPE152 is not set
CONFIG_SENSORS_XDPE122=y
# CONFIG_SENSORS_XDPE122_REGULATOR is not set
CONFIG_SENSORS_ZL6100=y
CONFIG_SENSORS_PWM_FAN=y
CONFIG_SENSORS_RASPBERRYPI_HWMON=y
# CONFIG_SENSORS_SL28CPLD is not set
CONFIG_SENSORS_SBTSI=y
CONFIG_SENSORS_SBRMI=y
CONFIG_SENSORS_SHT15=y
CONFIG_SENSORS_SHT21=y
CONFIG_SENSORS_SHT3x=y
CONFIG_SENSORS_SHT4x=y
# CONFIG_SENSORS_SHTC1 is not set
CONFIG_SENSORS_SIS5595=y
# CONFIG_SENSORS_SY7636A is not set
# CONFIG_SENSORS_DME1737 is not set
# CONFIG_SENSORS_EMC1403 is not set
CONFIG_SENSORS_EMC2103=y
# CONFIG_SENSORS_EMC6W201 is not set
# CONFIG_SENSORS_SMSC47M1 is not set
CONFIG_SENSORS_SMSC47M192=y
# CONFIG_SENSORS_SMSC47B397 is not set
CONFIG_SENSORS_SCH56XX_COMMON=y
# CONFIG_SENSORS_SCH5627 is not set
CONFIG_SENSORS_SCH5636=y
CONFIG_SENSORS_STTS751=y
CONFIG_SENSORS_SMM665=y
CONFIG_SENSORS_ADC128D818=y
# CONFIG_SENSORS_ADS7828 is not set
# CONFIG_SENSORS_ADS7871 is not set
CONFIG_SENSORS_AMC6821=y
CONFIG_SENSORS_INA209=y
# CONFIG_SENSORS_INA2XX is not set
CONFIG_SENSORS_INA238=y
# CONFIG_SENSORS_INA3221 is not set
CONFIG_SENSORS_TC74=y
# CONFIG_SENSORS_THMC50 is not set
CONFIG_SENSORS_TMP102=y
CONFIG_SENSORS_TMP103=y
CONFIG_SENSORS_TMP108=y
CONFIG_SENSORS_TMP401=y
CONFIG_SENSORS_TMP421=y
# CONFIG_SENSORS_TMP464 is not set
# CONFIG_SENSORS_TMP513 is not set
CONFIG_SENSORS_VIA686A=y
CONFIG_SENSORS_VT1211=y
CONFIG_SENSORS_VT8231=y
CONFIG_SENSORS_W83773G=y
# CONFIG_SENSORS_W83781D is not set
CONFIG_SENSORS_W83791D=y
CONFIG_SENSORS_W83792D=y
CONFIG_SENSORS_W83793=y
# CONFIG_SENSORS_W83795 is not set
CONFIG_SENSORS_W83L785TS=y
# CONFIG_SENSORS_W83L786NG is not set
# CONFIG_SENSORS_W83627HF is not set
CONFIG_SENSORS_W83627EHF=y
CONFIG_SENSORS_WM831X=y
CONFIG_SENSORS_XGENE=y
# CONFIG_SENSORS_INTEL_M10_BMC_HWMON is not set

#
# ACPI drivers
#
# CONFIG_SENSORS_ACPI_POWER is not set
CONFIG_THERMAL=y
CONFIG_THERMAL_NETLINK=y
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_OF=y
# CONFIG_THERMAL_WRITABLE_TRIPS is not set
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
# CONFIG_THERMAL_GOV_USER_SPACE is not set
# CONFIG_CPU_THERMAL is not set
CONFIG_DEVFREQ_THERMAL=y
# CONFIG_THERMAL_EMULATION is not set
# CONFIG_THERMAL_MMIO is not set
CONFIG_HISI_THERMAL=y
# CONFIG_IMX_THERMAL is not set
# CONFIG_IMX_SC_THERMAL is not set
# CONFIG_IMX8MM_THERMAL is not set
CONFIG_K3_THERMAL=y
# CONFIG_QORIQ_THERMAL is not set
# CONFIG_SPEAR_THERMAL is not set
# CONFIG_SUN8I_THERMAL is not set
# CONFIG_ROCKCHIP_THERMAL is not set
CONFIG_RCAR_THERMAL=y
# CONFIG_RCAR_GEN3_THERMAL is not set
# CONFIG_RZG2L_THERMAL is not set
# CONFIG_KIRKWOOD_THERMAL is not set
# CONFIG_DOVE_THERMAL is not set
# CONFIG_ARMADA_THERMAL is not set
# CONFIG_DA9062_THERMAL is not set
# CONFIG_MTK_THERMAL is not set

#
# Intel thermal drivers
#

#
# ACPI INT340X thermal drivers
#
# end of ACPI INT340X thermal drivers
# end of Intel thermal drivers

#
# Broadcom thermal drivers
#
# CONFIG_BCM2711_THERMAL is not set
# CONFIG_BCM2835_THERMAL is not set
# CONFIG_BRCMSTB_THERMAL is not set
# CONFIG_BCM_NS_THERMAL is not set
CONFIG_BCM_SR_THERMAL=y
# end of Broadcom thermal drivers

#
# Texas Instruments thermal drivers
#
CONFIG_TI_SOC_THERMAL=y
# CONFIG_TI_THERMAL is not set
CONFIG_OMAP3_THERMAL=y
# CONFIG_OMAP4_THERMAL is not set
CONFIG_OMAP5_THERMAL=y
# CONFIG_DRA752_THERMAL is not set
# end of Texas Instruments thermal drivers

#
# Samsung thermal drivers
#
# CONFIG_EXYNOS_THERMAL is not set
# end of Samsung thermal drivers

#
# NVIDIA Tegra thermal drivers
#
# CONFIG_TEGRA_SOCTHERM is not set
CONFIG_TEGRA_BPMP_THERMAL=y
CONFIG_TEGRA30_TSENSOR=y
# end of NVIDIA Tegra thermal drivers

CONFIG_GENERIC_ADC_THERMAL=y

#
# Qualcomm thermal drivers
#
# CONFIG_QCOM_SPMI_ADC_TM5 is not set
# CONFIG_QCOM_SPMI_TEMP_ALARM is not set
# end of Qualcomm thermal drivers

# CONFIG_UNIPHIER_THERMAL is not set
CONFIG_SPRD_THERMAL=y
# CONFIG_KHADAS_MCU_FAN_THERMAL is not set
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
# CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED is not set
CONFIG_WATCHDOG_OPEN_TIMEOUT=0
CONFIG_WATCHDOG_SYSFS=y
# CONFIG_WATCHDOG_HRTIMER_PRETIMEOUT is not set

#
# Watchdog Pretimeout Governors
#
CONFIG_WATCHDOG_PRETIMEOUT_GOV=y
CONFIG_WATCHDOG_PRETIMEOUT_GOV_SEL=y
CONFIG_WATCHDOG_PRETIMEOUT_GOV_NOOP=y
CONFIG_WATCHDOG_PRETIMEOUT_GOV_PANIC=y
CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_NOOP=y
# CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_PANIC is not set

#
# Watchdog Device Drivers
#
# CONFIG_SOFT_WATCHDOG is not set
# CONFIG_DA9052_WATCHDOG is not set
CONFIG_DA9055_WATCHDOG=y
# CONFIG_DA9063_WATCHDOG is not set
# CONFIG_DA9062_WATCHDOG is not set
# CONFIG_GPIO_WATCHDOG is not set
CONFIG_MENF21BMC_WATCHDOG=y
CONFIG_MENZ069_WATCHDOG=y
CONFIG_WDAT_WDT=y
# CONFIG_WM831X_WATCHDOG is not set
# CONFIG_XILINX_WATCHDOG is not set
CONFIG_ZIIRAVE_WATCHDOG=y
CONFIG_SL28CPLD_WATCHDOG=y
CONFIG_ARMADA_37XX_WATCHDOG=y
# CONFIG_ASM9260_WATCHDOG is not set
# CONFIG_AT91RM9200_WATCHDOG is not set
# CONFIG_AT91SAM9X_WATCHDOG is not set
# CONFIG_SAMA5D4_WATCHDOG is not set
# CONFIG_CADENCE_WATCHDOG is not set
# CONFIG_FTWDT010_WATCHDOG is not set
CONFIG_S3C2410_WATCHDOG=y
CONFIG_DW_WATCHDOG=y
CONFIG_EP93XX_WATCHDOG=y
CONFIG_OMAP_WATCHDOG=y
CONFIG_PNX4008_WATCHDOG=y
CONFIG_DAVINCI_WATCHDOG=y
# CONFIG_K3_RTI_WATCHDOG is not set
CONFIG_RN5T618_WATCHDOG=y
CONFIG_SUNXI_WATCHDOG=y
CONFIG_NPCM7XX_WATCHDOG=y
# CONFIG_STMP3XXX_RTC_WATCHDOG is not set
# CONFIG_TS4800_WATCHDOG is not set
CONFIG_TS72XX_WATCHDOG=y
CONFIG_MAX63XX_WATCHDOG=y
CONFIG_MAX77620_WATCHDOG=y
CONFIG_IMX2_WDT=y
CONFIG_IMX7ULP_WDT=y
CONFIG_RETU_WATCHDOG=y
# CONFIG_MOXART_WDT is not set
# CONFIG_ST_LPC_WATCHDOG is not set
CONFIG_TEGRA_WATCHDOG=y
CONFIG_QCOM_WDT=y
# CONFIG_MESON_GXBB_WATCHDOG is not set
CONFIG_MESON_WATCHDOG=y
CONFIG_MEDIATEK_WATCHDOG=y
CONFIG_DIGICOLOR_WATCHDOG=y
CONFIG_LPC18XX_WATCHDOG=y
# CONFIG_RENESAS_WDT is not set
CONFIG_RENESAS_RZAWDT=y
CONFIG_RENESAS_RZN1WDT=y
CONFIG_RENESAS_RZG2LWDT=y
CONFIG_ASPEED_WATCHDOG=y
# CONFIG_UNIPHIER_WATCHDOG is not set
# CONFIG_RTD119X_WATCHDOG is not set
# CONFIG_REALTEK_OTTO_WDT is not set
# CONFIG_SPRD_WATCHDOG is not set
CONFIG_VISCONTI_WATCHDOG=y
CONFIG_MSC313E_WATCHDOG=y
CONFIG_APPLE_WATCHDOG=y
CONFIG_SUNPLUS_WATCHDOG=y
# CONFIG_ALIM7101_WDT is not set
CONFIG_SC520_WDT=y
CONFIG_I6300ESB_WDT=y
CONFIG_KEMPLD_WDT=y
CONFIG_RDC321X_WDT=y
CONFIG_BCM47XX_WDT=y
# CONFIG_BCM2835_WDT is not set
# CONFIG_BCM_KONA_WDT is not set
CONFIG_BCM7038_WDT=y
# CONFIG_IMGPDC_WDT is not set
CONFIG_MPC5200_WDT=y
CONFIG_MEN_A21_WDT=y
CONFIG_UML_WATCHDOG=y

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=y
CONFIG_WDTPCI=y
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
# CONFIG_SSB_PCIHOST is not set
CONFIG_SSB_SDIOHOST_POSSIBLE=y
# CONFIG_SSB_SDIOHOST is not set
CONFIG_SSB_DRIVER_GPIO=y
CONFIG_BCMA_POSSIBLE=y
# CONFIG_BCMA is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_ACT8945A is not set
CONFIG_MFD_AS3711=y
# CONFIG_MFD_AS3722 is not set
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
CONFIG_MFD_AT91_USART=y
# CONFIG_MFD_ATMEL_FLEXCOM is not set
# CONFIG_MFD_ATMEL_HLCDC is not set
# CONFIG_MFD_BCM590XX is not set
CONFIG_MFD_BD9571MWV=y
CONFIG_MFD_AXP20X=y
CONFIG_MFD_AXP20X_I2C=y
CONFIG_MFD_MADERA=y
CONFIG_MFD_MADERA_I2C=y
# CONFIG_MFD_MADERA_SPI is not set
CONFIG_MFD_CS47L15=y
CONFIG_MFD_CS47L35=y
# CONFIG_MFD_CS47L85 is not set
CONFIG_MFD_CS47L90=y
# CONFIG_MFD_CS47L92 is not set
# CONFIG_MFD_ASIC3 is not set
CONFIG_PMIC_DA903X=y
# CONFIG_MFD_DA9052_SPI is not set
# CONFIG_MFD_DA9052_I2C is not set
# CONFIG_MFD_DA9055 is not set
# CONFIG_MFD_DA9062 is not set
CONFIG_MFD_DA9063=y
CONFIG_MFD_DA9150=y
CONFIG_MFD_ENE_KB3930=y
CONFIG_MFD_EXYNOS_LPASS=y
# CONFIG_MFD_GATEWORKS_GSC is not set
CONFIG_MFD_MC13XXX=y
CONFIG_MFD_MC13XXX_SPI=y
# CONFIG_MFD_MC13XXX_I2C is not set
# CONFIG_MFD_MP2629 is not set
CONFIG_MFD_MXS_LRADC=y
CONFIG_MFD_MX25_TSADC=y
# CONFIG_MFD_HI6421_PMIC is not set
# CONFIG_MFD_HI6421_SPMI is not set
# CONFIG_MFD_HI655X_PMIC is not set
# CONFIG_HTC_PASIC3 is not set
CONFIG_HTC_I2CPLD=y
CONFIG_LPC_ICH=y
CONFIG_LPC_SCH=y
# CONFIG_INTEL_SOC_PMIC is not set
# CONFIG_INTEL_SOC_PMIC_CHTWC is not set
CONFIG_MFD_IQS62X=y
CONFIG_MFD_JANZ_CMODIO=y
CONFIG_MFD_KEMPLD=y
CONFIG_MFD_88PM800=y
# CONFIG_MFD_88PM805 is not set
CONFIG_MFD_88PM860X=y
CONFIG_MFD_MAX14577=y
# CONFIG_MFD_MAX77620 is not set
CONFIG_MFD_MAX77650=y
# CONFIG_MFD_MAX77686 is not set
# CONFIG_MFD_MAX77693 is not set
CONFIG_MFD_MAX77714=y
CONFIG_MFD_MAX77843=y
CONFIG_MFD_MAX8907=y
# CONFIG_MFD_MAX8925 is not set
CONFIG_MFD_MAX8997=y
# CONFIG_MFD_MAX8998 is not set
# CONFIG_MFD_MT6360 is not set
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_MENF21BMC is not set
CONFIG_EZX_PCAP=y
CONFIG_MFD_CPCAP=y
CONFIG_MFD_NTXEC=y
CONFIG_MFD_RETU=y
CONFIG_MFD_PCF50633=y
CONFIG_PCF50633_ADC=y
CONFIG_PCF50633_GPIO=y
CONFIG_UCB1400_CORE=y
# CONFIG_MFD_PM8XXX is not set
# CONFIG_MFD_SPMI_PMIC is not set
CONFIG_MFD_RDC321X=y
# CONFIG_MFD_RT4831 is not set
CONFIG_MFD_RT5033=y
CONFIG_MFD_RC5T583=y
# CONFIG_MFD_RK808 is not set
# CONFIG_MFD_RN5T618 is not set
# CONFIG_MFD_SEC_CORE is not set
CONFIG_MFD_SI476X_CORE=y
CONFIG_MFD_SIMPLE_MFD_I2C=y
# CONFIG_MFD_SL28CPLD is not set
CONFIG_MFD_SM501=y
# CONFIG_MFD_SM501_GPIO is not set
# CONFIG_MFD_SKY81452 is not set
# CONFIG_MFD_SC27XX_PMIC is not set
# CONFIG_ABX500_CORE is not set
# CONFIG_MFD_STMPE is not set
# CONFIG_MFD_SUN6I_PRCM is not set
CONFIG_MFD_SYSCON=y
CONFIG_MFD_TI_AM335X_TSCADC=y
CONFIG_MFD_LP3943=y
# CONFIG_MFD_LP8788 is not set
CONFIG_MFD_TI_LMU=y
CONFIG_MFD_PALMAS=y
CONFIG_TPS6105X=y
# CONFIG_TPS65010 is not set
CONFIG_TPS6507X=y
CONFIG_MFD_TPS65086=y
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_TPS65217 is not set
CONFIG_MFD_TI_LP873X=y
# CONFIG_MFD_TI_LP87565 is not set
# CONFIG_MFD_TPS65218 is not set
# CONFIG_MFD_TPS6586X is not set
CONFIG_MFD_TPS65910=y
CONFIG_MFD_TPS65912=y
CONFIG_MFD_TPS65912_I2C=y
# CONFIG_MFD_TPS65912_SPI is not set
# CONFIG_TWL4030_CORE is not set
CONFIG_TWL6040_CORE=y
CONFIG_MFD_WL1273_CORE=y
CONFIG_MFD_LM3533=y
# CONFIG_MFD_TIMBERDALE is not set
# CONFIG_MFD_TC3589X is not set
CONFIG_MFD_TQMX86=y
CONFIG_MFD_VX855=y
# CONFIG_MFD_LOCHNAGAR is not set
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_ARIZONA_SPI is not set
CONFIG_MFD_WM8400=y
CONFIG_MFD_WM831X=y
CONFIG_MFD_WM831X_I2C=y
# CONFIG_MFD_WM831X_SPI is not set
# CONFIG_MFD_WM8350_I2C is not set
CONFIG_MFD_WM8994=y
# CONFIG_MFD_STW481X is not set
# CONFIG_MFD_ROHM_BD718XX is not set
# CONFIG_MFD_ROHM_BD71828 is not set
# CONFIG_MFD_ROHM_BD957XMUF is not set
# CONFIG_MFD_STM32_LPTIMER is not set
CONFIG_MFD_STM32_TIMERS=y
# CONFIG_MFD_STPMIC1 is not set
# CONFIG_MFD_STMFX is not set
# CONFIG_MFD_WCD934X is not set
# CONFIG_MFD_ATC260X_I2C is not set
CONFIG_MFD_KHADAS_MCU=y
CONFIG_MFD_ACER_A500_EC=y
# CONFIG_MFD_QCOM_PM8008 is not set
# CONFIG_RAVE_SP_CORE is not set
CONFIG_MFD_INTEL_M10_BMC=y
# CONFIG_MFD_RSMU_I2C is not set
# CONFIG_MFD_RSMU_SPI is not set
# end of Multifunction device drivers

CONFIG_REGULATOR=y
# CONFIG_REGULATOR_DEBUG is not set
CONFIG_REGULATOR_FIXED_VOLTAGE=y
# CONFIG_REGULATOR_VIRTUAL_CONSUMER is not set
# CONFIG_REGULATOR_USERSPACE_CONSUMER is not set
CONFIG_REGULATOR_88PG86X=y
CONFIG_REGULATOR_88PM800=y
CONFIG_REGULATOR_88PM8607=y
# CONFIG_REGULATOR_ACT8865 is not set
CONFIG_REGULATOR_AD5398=y
CONFIG_REGULATOR_ANATOP=y
# CONFIG_REGULATOR_ARIZONA_LDO1 is not set
CONFIG_REGULATOR_ARIZONA_MICSUPP=y
# CONFIG_REGULATOR_ARM_SCMI is not set
# CONFIG_REGULATOR_AS3711 is not set
# CONFIG_REGULATOR_AXP20X is not set
CONFIG_REGULATOR_BD9571MWV=y
CONFIG_REGULATOR_CPCAP=y
CONFIG_REGULATOR_DA903X=y
# CONFIG_REGULATOR_DA9063 is not set
# CONFIG_REGULATOR_DA9121 is not set
CONFIG_REGULATOR_DA9210=y
CONFIG_REGULATOR_DA9211=y
# CONFIG_REGULATOR_FAN53555 is not set
CONFIG_REGULATOR_FAN53880=y
CONFIG_REGULATOR_GPIO=y
CONFIG_REGULATOR_ISL9305=y
CONFIG_REGULATOR_ISL6271A=y
CONFIG_REGULATOR_LM363X=y
CONFIG_REGULATOR_LP3971=y
CONFIG_REGULATOR_LP3972=y
# CONFIG_REGULATOR_LP872X is not set
# CONFIG_REGULATOR_LP873X is not set
CONFIG_REGULATOR_LP8755=y
# CONFIG_REGULATOR_LTC3589 is not set
CONFIG_REGULATOR_LTC3676=y
CONFIG_REGULATOR_MAX14577=y
CONFIG_REGULATOR_MAX1586=y
# CONFIG_REGULATOR_MAX77620 is not set
CONFIG_REGULATOR_MAX77650=y
CONFIG_REGULATOR_MAX8649=y
# CONFIG_REGULATOR_MAX8660 is not set
CONFIG_REGULATOR_MAX8893=y
CONFIG_REGULATOR_MAX8907=y
CONFIG_REGULATOR_MAX8952=y
# CONFIG_REGULATOR_MAX8973 is not set
CONFIG_REGULATOR_MAX8997=y
# CONFIG_REGULATOR_MAX20086 is not set
# CONFIG_REGULATOR_MAX77686 is not set
CONFIG_REGULATOR_MAX77693=y
CONFIG_REGULATOR_MAX77802=y
# CONFIG_REGULATOR_MAX77826 is not set
CONFIG_REGULATOR_MC13XXX_CORE=y
CONFIG_REGULATOR_MC13783=y
# CONFIG_REGULATOR_MC13892 is not set
# CONFIG_REGULATOR_MCP16502 is not set
# CONFIG_REGULATOR_MP5416 is not set
CONFIG_REGULATOR_MP8859=y
# CONFIG_REGULATOR_MP886X is not set
# CONFIG_REGULATOR_MPQ7920 is not set
CONFIG_REGULATOR_MT6311=y
CONFIG_REGULATOR_MT6315=y
CONFIG_REGULATOR_PALMAS=y
# CONFIG_REGULATOR_PBIAS is not set
# CONFIG_REGULATOR_PCA9450 is not set
CONFIG_REGULATOR_PCAP=y
# CONFIG_REGULATOR_PCF50633 is not set
# CONFIG_REGULATOR_PF8X00 is not set
# CONFIG_REGULATOR_PFUZE100 is not set
# CONFIG_REGULATOR_PV88060 is not set
# CONFIG_REGULATOR_PV88080 is not set
# CONFIG_REGULATOR_PV88090 is not set
CONFIG_REGULATOR_QCOM_RPMH=y
CONFIG_REGULATOR_QCOM_SPMI=y
CONFIG_REGULATOR_QCOM_USB_VBUS=y
# CONFIG_REGULATOR_RASPBERRYPI_TOUCHSCREEN_ATTINY is not set
CONFIG_REGULATOR_RC5T583=y
CONFIG_REGULATOR_RT4801=y
# CONFIG_REGULATOR_RT5033 is not set
CONFIG_REGULATOR_RT5190A=y
# CONFIG_REGULATOR_RT5759 is not set
CONFIG_REGULATOR_RT6160=y
CONFIG_REGULATOR_RT6245=y
CONFIG_REGULATOR_RTQ2134=y
CONFIG_REGULATOR_RTMV20=y
CONFIG_REGULATOR_RTQ6752=y
# CONFIG_REGULATOR_S2MPA01 is not set
CONFIG_REGULATOR_S2MPS11=y
# CONFIG_REGULATOR_S5M8767 is not set
CONFIG_REGULATOR_SC2731=y
CONFIG_REGULATOR_SLG51000=y
# CONFIG_REGULATOR_STM32_BOOSTER is not set
CONFIG_REGULATOR_STM32_VREFBUF=y
# CONFIG_REGULATOR_STM32_PWR is not set
CONFIG_REGULATOR_TI_ABB=y
# CONFIG_REGULATOR_STW481X_VMMC is not set
CONFIG_REGULATOR_SY7636A=y
CONFIG_REGULATOR_SY8106A=y
CONFIG_REGULATOR_SY8824X=y
# CONFIG_REGULATOR_SY8827N is not set
CONFIG_REGULATOR_TPS51632=y
# CONFIG_REGULATOR_TPS6105X is not set
CONFIG_REGULATOR_TPS62360=y
# CONFIG_REGULATOR_TPS6286X is not set
# CONFIG_REGULATOR_TPS65023 is not set
CONFIG_REGULATOR_TPS6507X=y
# CONFIG_REGULATOR_TPS65086 is not set
CONFIG_REGULATOR_TPS65132=y
CONFIG_REGULATOR_TPS6524X=y
CONFIG_REGULATOR_TPS65910=y
CONFIG_REGULATOR_TPS65912=y
# CONFIG_REGULATOR_TPS68470 is not set
# CONFIG_REGULATOR_UNIPHIER is not set
# CONFIG_REGULATOR_VCTRL is not set
# CONFIG_REGULATOR_WM831X is not set
CONFIG_REGULATOR_WM8400=y
# CONFIG_REGULATOR_WM8994 is not set
CONFIG_REGULATOR_QCOM_LABIBB=y
CONFIG_RC_CORE=y
# CONFIG_LIRC is not set
# CONFIG_RC_MAP is not set
CONFIG_RC_DECODERS=y
CONFIG_IR_IMON_DECODER=y
CONFIG_IR_JVC_DECODER=y
CONFIG_IR_MCE_KBD_DECODER=y
# CONFIG_IR_NEC_DECODER is not set
CONFIG_IR_RC5_DECODER=y
CONFIG_IR_RC6_DECODER=y
CONFIG_IR_RCMM_DECODER=y
# CONFIG_IR_SANYO_DECODER is not set
CONFIG_IR_SHARP_DECODER=y
CONFIG_IR_SONY_DECODER=y
CONFIG_IR_XMP_DECODER=y
# CONFIG_RC_DEVICES is not set
CONFIG_CEC_CORE=y
CONFIG_CEC_NOTIFIER=y
CONFIG_CEC_PIN=y

#
# CEC support
#
# CONFIG_MEDIA_CEC_RC is not set
# CONFIG_CEC_PIN_ERROR_INJ is not set
CONFIG_MEDIA_CEC_SUPPORT=y
CONFIG_CEC_CH7322=y
# CONFIG_CEC_MESON_AO is not set
# CONFIG_CEC_MESON_G12A_AO is not set
CONFIG_CEC_GPIO=y
CONFIG_CEC_SAMSUNG_S5P=y
CONFIG_CEC_STI=y
# CONFIG_CEC_STM32 is not set
CONFIG_CEC_TEGRA=y
# end of CEC support

CONFIG_MEDIA_SUPPORT=y
# CONFIG_MEDIA_SUPPORT_FILTER is not set
CONFIG_MEDIA_SUBDRV_AUTOSELECT=y

#
# Media device types
#
CONFIG_MEDIA_CAMERA_SUPPORT=y
CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
CONFIG_MEDIA_RADIO_SUPPORT=y
CONFIG_MEDIA_SDR_SUPPORT=y
CONFIG_MEDIA_PLATFORM_SUPPORT=y
CONFIG_MEDIA_TEST_SUPPORT=y
# end of Media device types

#
# Media core support
#
# CONFIG_VIDEO_DEV is not set
CONFIG_MEDIA_CONTROLLER=y
CONFIG_DVB_CORE=y
# end of Media core support

#
# Media controller options
#
CONFIG_MEDIA_CONTROLLER_DVB=y
# end of Media controller options

#
# Digital TV options
#
CONFIG_DVB_NET=y
CONFIG_DVB_MAX_ADAPTERS=16
# CONFIG_DVB_DYNAMIC_MINORS is not set
CONFIG_DVB_DEMUX_SECTION_LOSS_LOG=y
CONFIG_DVB_ULE_DEBUG=y
# end of Digital TV options

#
# Media drivers
#

#
# Media drivers
#
# CONFIG_MEDIA_PCI_SUPPORT is not set
# CONFIG_MEDIA_PLATFORM_DRIVERS is not set

#
# MMC/SDIO DVB adapters
#
CONFIG_SMS_SDIO_DRV=y
CONFIG_DVB_TEST_DRIVERS=y
# CONFIG_DVB_VIDTV is not set

#
# FireWire (IEEE 1394) Adapters
#
CONFIG_DVB_FIREDTV=y
CONFIG_DVB_FIREDTV_INPUT=y
CONFIG_MEDIA_COMMON_OPTIONS=y

#
# common driver options
#
CONFIG_SMS_SIANO_MDTV=y
CONFIG_SMS_SIANO_RC=y
# end of Media drivers

#
# Media ancillary drivers
#
CONFIG_MEDIA_TUNER=y

#
# Customize TV tuners
#
# CONFIG_MEDIA_TUNER_FC0011 is not set
CONFIG_MEDIA_TUNER_FC0012=y
CONFIG_MEDIA_TUNER_FC0013=y
# CONFIG_MEDIA_TUNER_IT913X is not set
CONFIG_MEDIA_TUNER_M88RS6000T=y
# CONFIG_MEDIA_TUNER_MAX2165 is not set
CONFIG_MEDIA_TUNER_MC44S803=y
CONFIG_MEDIA_TUNER_MT2060=y
CONFIG_MEDIA_TUNER_MT2063=y
CONFIG_MEDIA_TUNER_MT20XX=y
# CONFIG_MEDIA_TUNER_MT2131 is not set
CONFIG_MEDIA_TUNER_MT2266=y
CONFIG_MEDIA_TUNER_MXL301RF=y
# CONFIG_MEDIA_TUNER_MXL5005S is not set
# CONFIG_MEDIA_TUNER_MXL5007T is not set
CONFIG_MEDIA_TUNER_QM1D1B0004=y
# CONFIG_MEDIA_TUNER_QM1D1C0042 is not set
# CONFIG_MEDIA_TUNER_QT1010 is not set
# CONFIG_MEDIA_TUNER_R820T is not set
CONFIG_MEDIA_TUNER_SI2157=y
CONFIG_MEDIA_TUNER_SIMPLE=y
CONFIG_MEDIA_TUNER_TDA18212=y
CONFIG_MEDIA_TUNER_TDA18218=y
CONFIG_MEDIA_TUNER_TDA18250=y
CONFIG_MEDIA_TUNER_TDA18271=y
CONFIG_MEDIA_TUNER_TDA827X=y
CONFIG_MEDIA_TUNER_TDA8290=y
CONFIG_MEDIA_TUNER_TDA9887=y
CONFIG_MEDIA_TUNER_TEA5761=y
CONFIG_MEDIA_TUNER_TEA5767=y
CONFIG_MEDIA_TUNER_TUA9001=y
CONFIG_MEDIA_TUNER_XC2028=y
CONFIG_MEDIA_TUNER_XC4000=y
CONFIG_MEDIA_TUNER_XC5000=y
# end of Customize TV tuners

#
# Customise DVB Frontends
#

#
# Multistandard (satellite) frontends
#
CONFIG_DVB_M88DS3103=y
# CONFIG_DVB_MXL5XX is not set
CONFIG_DVB_STB0899=y
CONFIG_DVB_STB6100=y
# CONFIG_DVB_STV090x is not set
CONFIG_DVB_STV0910=y
CONFIG_DVB_STV6110x=y
# CONFIG_DVB_STV6111 is not set

#
# Multistandard (cable + terrestrial) frontends
#
# CONFIG_DVB_DRXK is not set
CONFIG_DVB_MN88472=y
# CONFIG_DVB_MN88473 is not set
# CONFIG_DVB_SI2165 is not set
CONFIG_DVB_TDA18271C2DD=y

#
# DVB-S (satellite) frontends
#
CONFIG_DVB_CX24110=y
CONFIG_DVB_CX24116=y
# CONFIG_DVB_CX24117 is not set
CONFIG_DVB_CX24120=y
# CONFIG_DVB_CX24123 is not set
CONFIG_DVB_DS3000=y
CONFIG_DVB_MB86A16=y
CONFIG_DVB_MT312=y
CONFIG_DVB_S5H1420=y
CONFIG_DVB_SI21XX=y
# CONFIG_DVB_STB6000 is not set
CONFIG_DVB_STV0288=y
CONFIG_DVB_STV0299=y
# CONFIG_DVB_STV0900 is not set
CONFIG_DVB_STV6110=y
CONFIG_DVB_TDA10071=y
CONFIG_DVB_TDA10086=y
# CONFIG_DVB_TDA8083 is not set
# CONFIG_DVB_TDA8261 is not set
CONFIG_DVB_TDA826X=y
# CONFIG_DVB_TS2020 is not set
# CONFIG_DVB_TUA6100 is not set
# CONFIG_DVB_TUNER_CX24113 is not set
CONFIG_DVB_TUNER_ITD1000=y
CONFIG_DVB_VES1X93=y
CONFIG_DVB_ZL10036=y
CONFIG_DVB_ZL10039=y

#
# DVB-T (terrestrial) frontends
#
# CONFIG_DVB_AF9013 is not set
# CONFIG_DVB_CX22700 is not set
CONFIG_DVB_CX22702=y
CONFIG_DVB_CXD2820R=y
CONFIG_DVB_CXD2841ER=y
# CONFIG_DVB_DIB3000MB is not set
# CONFIG_DVB_DIB3000MC is not set
CONFIG_DVB_DIB7000M=y
CONFIG_DVB_DIB7000P=y
CONFIG_DVB_DIB9000=y
CONFIG_DVB_DRXD=y
CONFIG_DVB_EC100=y
# CONFIG_DVB_L64781 is not set
# CONFIG_DVB_MT352 is not set
# CONFIG_DVB_NXT6000 is not set
CONFIG_DVB_RTL2830=y
CONFIG_DVB_RTL2832=y
CONFIG_DVB_S5H1432=y
CONFIG_DVB_SI2168=y
CONFIG_DVB_SP887X=y
CONFIG_DVB_STV0367=y
CONFIG_DVB_TDA10048=y
# CONFIG_DVB_TDA1004X is not set
# CONFIG_DVB_ZD1301_DEMOD is not set
CONFIG_DVB_ZL10353=y
CONFIG_DVB_CXD2880=y

#
# DVB-C (cable) frontends
#
CONFIG_DVB_STV0297=y
CONFIG_DVB_TDA10021=y
# CONFIG_DVB_TDA10023 is not set
CONFIG_DVB_VES1820=y

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#
CONFIG_DVB_AU8522=y
CONFIG_DVB_AU8522_DTV=y
CONFIG_DVB_BCM3510=y
CONFIG_DVB_LG2160=y
CONFIG_DVB_LGDT3305=y
CONFIG_DVB_LGDT3306A=y
CONFIG_DVB_LGDT330X=y
CONFIG_DVB_MXL692=y
# CONFIG_DVB_NXT200X is not set
CONFIG_DVB_OR51132=y
CONFIG_DVB_OR51211=y
# CONFIG_DVB_S5H1409 is not set
CONFIG_DVB_S5H1411=y

#
# ISDB-T (terrestrial) frontends
#
CONFIG_DVB_DIB8000=y
# CONFIG_DVB_MB86A20S is not set
CONFIG_DVB_S921=y

#
# ISDB-S (satellite) & ISDB-T (terrestrial) frontends
#
CONFIG_DVB_MN88443X=y
CONFIG_DVB_TC90522=y

#
# Digital terrestrial only tuners/PLL
#
CONFIG_DVB_PLL=y
CONFIG_DVB_TUNER_DIB0070=y
# CONFIG_DVB_TUNER_DIB0090 is not set

#
# SEC control devices for DVB-S
#
# CONFIG_DVB_A8293 is not set
# CONFIG_DVB_AF9033 is not set
CONFIG_DVB_ASCOT2E=y
CONFIG_DVB_ATBM8830=y
CONFIG_DVB_HELENE=y
CONFIG_DVB_HORUS3A=y
CONFIG_DVB_ISL6405=y
CONFIG_DVB_ISL6421=y
CONFIG_DVB_ISL6423=y
CONFIG_DVB_IX2505V=y
# CONFIG_DVB_LGS8GL5 is not set
CONFIG_DVB_LGS8GXX=y
CONFIG_DVB_LNBH25=y
# CONFIG_DVB_LNBH29 is not set
CONFIG_DVB_LNBP21=y
CONFIG_DVB_LNBP22=y
CONFIG_DVB_M88RS2000=y
CONFIG_DVB_TDA665x=y
CONFIG_DVB_DRX39XYJ=y

#
# Common Interface (EN50221) controller drivers
#
CONFIG_DVB_CXD2099=y
# CONFIG_DVB_SP2 is not set
# end of Customise DVB Frontends

#
# Tools to develop new frontends
#
CONFIG_DVB_DUMMY_FE=y
# end of Media ancillary drivers

#
# Graphics support
#
CONFIG_IMX_IPUV3_CORE=y
# CONFIG_DRM is not set
CONFIG_DRM_DEBUG_MODESET_LOCK=y

#
# ARM devices
#
# end of ARM devices

#
# Frame buffer Devices
#
# CONFIG_FB is not set
# CONFIG_MMP_DISP is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=y
# CONFIG_LCD_L4F00242T03 is not set
CONFIG_LCD_LMS283GF05=y
CONFIG_LCD_LTV350QV=y
CONFIG_LCD_ILI922X=y
CONFIG_LCD_ILI9320=y
CONFIG_LCD_TDO24M=y
CONFIG_LCD_VGG2432A4=y
CONFIG_LCD_PLATFORM=y
# CONFIG_LCD_AMS369FG06 is not set
CONFIG_LCD_LMS501KF03=y
CONFIG_LCD_HX8357=y
CONFIG_LCD_OTM3225A=y
CONFIG_BACKLIGHT_CLASS_DEVICE=y
CONFIG_BACKLIGHT_KTD253=y
CONFIG_BACKLIGHT_LM3533=y
# CONFIG_BACKLIGHT_OMAP1 is not set
# CONFIG_BACKLIGHT_DA903X is not set
CONFIG_BACKLIGHT_QCOM_WLED=y
CONFIG_BACKLIGHT_WM831X=y
# CONFIG_BACKLIGHT_ADP8860 is not set
# CONFIG_BACKLIGHT_ADP8870 is not set
# CONFIG_BACKLIGHT_88PM860X is not set
CONFIG_BACKLIGHT_PCF50633=y
# CONFIG_BACKLIGHT_LM3639 is not set
# CONFIG_BACKLIGHT_AS3711 is not set
CONFIG_BACKLIGHT_GPIO=y
CONFIG_BACKLIGHT_LV5207LP=y
CONFIG_BACKLIGHT_BD6107=y
CONFIG_BACKLIGHT_ARCXCNN=y
# CONFIG_BACKLIGHT_LED is not set
# end of Backlight & LCD device support

CONFIG_HDMI=y
# end of Graphics support

CONFIG_SOUND=y
CONFIG_SND=y
CONFIG_SND_TIMER=y
CONFIG_SND_PCM=y
CONFIG_SND_PCM_ELD=y
CONFIG_SND_PCM_IEC958=y
CONFIG_SND_DMAENGINE_PCM=y
CONFIG_SND_HWDEP=y
CONFIG_SND_RAWMIDI=y
CONFIG_SND_COMPRESS_OFFLOAD=y
CONFIG_SND_JACK=y
CONFIG_SND_JACK_INPUT_DEV=y
# CONFIG_SND_OSSEMUL is not set
CONFIG_SND_PCM_TIMER=y
CONFIG_SND_HRTIMER=y
CONFIG_SND_DYNAMIC_MINORS=y
CONFIG_SND_MAX_CARDS=32
# CONFIG_SND_SUPPORT_OLD_API is not set
CONFIG_SND_PROC_FS=y
# CONFIG_SND_VERBOSE_PROCFS is not set
# CONFIG_SND_VERBOSE_PRINTK is not set
CONFIG_SND_CTL_FAST_LOOKUP=y
# CONFIG_SND_DEBUG is not set
# CONFIG_SND_CTL_INPUT_VALIDATION is not set
CONFIG_SND_VMASTER=y
CONFIG_SND_CTL_LED=y
# CONFIG_SND_SEQUENCER is not set
CONFIG_SND_AC97_CODEC=y
CONFIG_SND_DRIVERS=y
CONFIG_SND_DUMMY=y
CONFIG_SND_ALOOP=y
CONFIG_SND_MTPAV=y
# CONFIG_SND_SERIAL_U16550 is not set
# CONFIG_SND_SERIAL_GENERIC is not set
# CONFIG_SND_MPU401 is not set
# CONFIG_SND_AC97_POWER_SAVE is not set
# CONFIG_SND_PCI is not set

#
# HD-Audio
#
CONFIG_SND_HDA=y
CONFIG_SND_HDA_GENERIC_LEDS=y
CONFIG_SND_HDA_HWDEP=y
CONFIG_SND_HDA_RECONFIG=y
# CONFIG_SND_HDA_INPUT_BEEP is not set
CONFIG_SND_HDA_PATCH_LOADER=y
CONFIG_SND_HDA_SCODEC_CS35L41=y
CONFIG_SND_HDA_CS_DSP_CONTROLS=y
# CONFIG_SND_HDA_SCODEC_CS35L41_I2C is not set
CONFIG_SND_HDA_SCODEC_CS35L41_SPI=y
CONFIG_SND_HDA_CODEC_REALTEK=y
CONFIG_SND_HDA_CODEC_ANALOG=y
CONFIG_SND_HDA_CODEC_SIGMATEL=y
# CONFIG_SND_HDA_CODEC_VIA is not set
CONFIG_SND_HDA_CODEC_HDMI=y
# CONFIG_SND_HDA_CODEC_CIRRUS is not set
# CONFIG_SND_HDA_CODEC_CS8409 is not set
CONFIG_SND_HDA_CODEC_CONEXANT=y
# CONFIG_SND_HDA_CODEC_CA0110 is not set
# CONFIG_SND_HDA_CODEC_CA0132 is not set
# CONFIG_SND_HDA_CODEC_CMEDIA is not set
CONFIG_SND_HDA_CODEC_SI3054=y
CONFIG_SND_HDA_GENERIC=y
# end of HD-Audio

CONFIG_SND_HDA_CORE=y
CONFIG_SND_HDA_DSP_LOADER=y
CONFIG_SND_HDA_EXT_CORE=y
CONFIG_SND_HDA_PREALLOC_SIZE=64
CONFIG_SND_INTEL_NHLT=y
CONFIG_SND_INTEL_DSP_CONFIG=y
CONFIG_SND_INTEL_SOUNDWIRE_ACPI=y
CONFIG_SND_PXA2XX_LIB=y
# CONFIG_SND_SPI is not set
# CONFIG_SND_FIREWIRE is not set
CONFIG_SND_SOC=y
CONFIG_SND_SOC_AC97_BUS=y
CONFIG_SND_SOC_GENERIC_DMAENGINE_PCM=y
CONFIG_SND_SOC_COMPRESS=y
CONFIG_SND_SOC_TOPOLOGY=y
CONFIG_SND_SOC_ACPI=y
# CONFIG_SND_SOC_ADI is not set
CONFIG_SND_SOC_AMD_ACP=y
# CONFIG_SND_SOC_AMD_CZ_DA7219MX98357_MACH is not set
CONFIG_SND_SOC_AMD_CZ_RT5645_MACH=y
CONFIG_SND_SOC_AMD_ST_ES8336_MACH=y
CONFIG_SND_AMD_ACP_CONFIG=y
CONFIG_SND_ATMEL_SOC=y
# CONFIG_SND_ATMEL_SOC_CLASSD is not set
# CONFIG_SND_ATMEL_SOC_PDMIC is not set
# CONFIG_SND_ATMEL_SOC_I2S is not set
# CONFIG_SND_SOC_MIKROE_PROTO is not set
# CONFIG_SND_MCHP_SOC_I2S_MCC is not set
# CONFIG_SND_MCHP_SOC_SPDIFTX is not set
# CONFIG_SND_MCHP_SOC_SPDIFRX is not set
# CONFIG_SND_MCHP_SOC_PDMC is not set
CONFIG_SND_BCM2835_SOC_I2S=y
CONFIG_SND_SOC_CYGNUS=y
CONFIG_SND_BCM63XX_I2S_WHISTLER=y
CONFIG_SND_EP93XX_SOC=y
CONFIG_SND_DESIGNWARE_I2S=y
CONFIG_SND_DESIGNWARE_PCM=y

#
# SoC Audio for Freescale CPUs
#

#
# Common SoC Audio options for Freescale CPUs:
#
# CONFIG_SND_SOC_FSL_ASRC is not set
CONFIG_SND_SOC_FSL_SAI=y
CONFIG_SND_SOC_FSL_MQS=y
CONFIG_SND_SOC_FSL_AUDMIX=y
CONFIG_SND_SOC_FSL_SSI=y
CONFIG_SND_SOC_FSL_SPDIF=y
CONFIG_SND_SOC_FSL_ESAI=y
# CONFIG_SND_SOC_FSL_MICFIL is not set
# CONFIG_SND_SOC_FSL_XCVR is not set
CONFIG_SND_SOC_FSL_AUD2HTX=y
CONFIG_SND_SOC_FSL_UTILS=y
CONFIG_SND_SOC_FSL_RPMSG=y
CONFIG_SND_SOC_IMX_PCM_DMA=y
CONFIG_SND_SOC_IMX_AUDIO_RPMSG=y
CONFIG_SND_SOC_IMX_PCM_RPMSG=y
# CONFIG_SND_SOC_IMX_AUDMUX is not set
CONFIG_SND_IMX_SOC=y

#
# SoC Audio support for Freescale i.MX boards:
#
# CONFIG_SND_SOC_IMX_ES8328 is not set
# CONFIG_SND_SOC_IMX_SGTL5000 is not set
CONFIG_SND_SOC_IMX_SPDIF=y
# CONFIG_SND_SOC_FSL_ASOC_CARD is not set
CONFIG_SND_SOC_IMX_AUDMIX=y
CONFIG_SND_SOC_IMX_HDMI=y
CONFIG_SND_SOC_IMX_RPMSG=y
# CONFIG_SND_SOC_IMX_CARD is not set
# end of SoC Audio for Freescale CPUs

CONFIG_SND_I2S_HI6210_I2S=y
# CONFIG_SND_JZ4740_SOC_I2S is not set
# CONFIG_SND_KIRKWOOD_SOC is not set
CONFIG_SND_SOC_IMG=y
CONFIG_SND_SOC_IMG_I2S_IN=y
CONFIG_SND_SOC_IMG_I2S_OUT=y
# CONFIG_SND_SOC_IMG_PARALLEL_OUT is not set
# CONFIG_SND_SOC_IMG_SPDIF_IN is not set
CONFIG_SND_SOC_IMG_SPDIF_OUT=y
CONFIG_SND_SOC_IMG_PISTACHIO_INTERNAL_DAC=y
# CONFIG_SND_SOC_INTEL_SST_TOPLEVEL is not set
CONFIG_SND_SOC_INTEL_KEEMBAY=y
CONFIG_SND_SOC_INTEL_AVS=y

#
# Intel AVS Machine drivers
#

#
# Available DSP configurations
#
# CONFIG_SND_SOC_INTEL_AVS_MACH_DA7219 is not set
CONFIG_SND_SOC_INTEL_AVS_MACH_DMIC=y
# CONFIG_SND_SOC_INTEL_AVS_MACH_HDAUDIO is not set
CONFIG_SND_SOC_INTEL_AVS_MACH_I2S_TEST=y
CONFIG_SND_SOC_INTEL_AVS_MACH_MAX98357A=y
# CONFIG_SND_SOC_INTEL_AVS_MACH_MAX98373 is not set
CONFIG_SND_SOC_INTEL_AVS_MACH_NAU8825=y
CONFIG_SND_SOC_INTEL_AVS_MACH_RT274=y
CONFIG_SND_SOC_INTEL_AVS_MACH_RT286=y
# CONFIG_SND_SOC_INTEL_AVS_MACH_RT298 is not set
CONFIG_SND_SOC_INTEL_AVS_MACH_RT5682=y
# CONFIG_SND_SOC_INTEL_AVS_MACH_SSM4567 is not set
# end of Intel AVS Machine drivers

CONFIG_SND_SOC_MEDIATEK=y
CONFIG_SND_SOC_MT8186=y
# CONFIG_SND_SOC_MTK_BTCVSD is not set
CONFIG_SND_SOC_MT8195=y

#
# ASoC support for Amlogic platforms
#
# CONFIG_SND_MESON_AIU is not set
CONFIG_SND_MESON_AXG_FIFO=y
# CONFIG_SND_MESON_AXG_FRDDR is not set
CONFIG_SND_MESON_AXG_TODDR=y
CONFIG_SND_MESON_AXG_TDM_FORMATTER=y
CONFIG_SND_MESON_AXG_TDM_INTERFACE=y
CONFIG_SND_MESON_AXG_TDMIN=y
CONFIG_SND_MESON_AXG_TDMOUT=y
CONFIG_SND_MESON_AXG_SOUND_CARD=y
# CONFIG_SND_MESON_AXG_SPDIFOUT is not set
CONFIG_SND_MESON_AXG_SPDIFIN=y
# CONFIG_SND_MESON_AXG_PDM is not set
CONFIG_SND_MESON_CARD_UTILS=y
CONFIG_SND_MESON_CODEC_GLUE=y
CONFIG_SND_MESON_GX_SOUND_CARD=y
CONFIG_SND_MESON_G12A_TOACODEC=y
CONFIG_SND_MESON_G12A_TOHDMITX=y
CONFIG_SND_SOC_MESON_T9015=y
# end of ASoC support for Amlogic platforms

CONFIG_SND_MXS_SOC=y
CONFIG_SND_SOC_MXS_SGTL5000=y
CONFIG_SND_PXA2XX_SOC=y
# CONFIG_SND_SOC_QCOM is not set
CONFIG_SND_SOC_ROCKCHIP=y
CONFIG_SND_SOC_ROCKCHIP_I2S=y
# CONFIG_SND_SOC_ROCKCHIP_I2S_TDM is not set
CONFIG_SND_SOC_ROCKCHIP_PDM=y
# CONFIG_SND_SOC_ROCKCHIP_SPDIF is not set
# CONFIG_SND_SOC_ROCKCHIP_MAX98090 is not set
# CONFIG_SND_SOC_ROCKCHIP_RT5645 is not set
CONFIG_SND_SOC_RK3288_HDMI_ANALOG=y
CONFIG_SND_SOC_RK3399_GRU_SOUND=y
# CONFIG_SND_SOC_SAMSUNG is not set

#
# SoC Audio support for Renesas SoCs
#
CONFIG_SND_SOC_SH4_FSI=y
# CONFIG_SND_SOC_RCAR is not set
CONFIG_SND_SOC_RZ=y
# end of SoC Audio support for Renesas SoCs

# CONFIG_SND_SOC_SOF_TOPLEVEL is not set
# CONFIG_SND_SOC_SPRD is not set
# CONFIG_SND_SOC_STI is not set

#
# STMicroelectronics STM32 SOC audio support
#
CONFIG_SND_SOC_STM32_SAI=y
CONFIG_SND_SOC_STM32_I2S=y
# CONFIG_SND_SOC_STM32_SPDIFRX is not set
CONFIG_SND_SOC_STM32_DFSDM=y
# end of STMicroelectronics STM32 SOC audio support

#
# Allwinner SoC Audio support
#
CONFIG_SND_SUN4I_CODEC=y
# CONFIG_SND_SUN8I_CODEC is not set
CONFIG_SND_SUN8I_CODEC_ANALOG=y
CONFIG_SND_SUN50I_CODEC_ANALOG=y
# CONFIG_SND_SUN4I_I2S is not set
# CONFIG_SND_SUN4I_SPDIF is not set
CONFIG_SND_SUN8I_ADDA_PR_REGMAP=y
# end of Allwinner SoC Audio support

# CONFIG_SND_SOC_TEGRA is not set

#
# Audio support for Texas Instruments SoCs
#
CONFIG_SND_SOC_TI_EDMA_PCM=y
CONFIG_SND_SOC_TI_SDMA_PCM=y
CONFIG_SND_SOC_TI_UDMA_PCM=y

#
# Texas Instruments DAI support for:
#
# CONFIG_SND_SOC_DAVINCI_ASP is not set
CONFIG_SND_SOC_DAVINCI_MCASP=y
CONFIG_SND_SOC_DAVINCI_VCIF=y
CONFIG_SND_SOC_OMAP_DMIC=y
CONFIG_SND_SOC_OMAP_MCBSP=y
CONFIG_SND_SOC_OMAP_MCPDM=y

#
# Audio support for boards with Texas Instruments SoCs
#
# CONFIG_SND_SOC_OMAP_ABE_TWL6040 is not set
CONFIG_SND_SOC_OMAP_HDMI=y
CONFIG_SND_SOC_J721E_EVM=y
# end of Audio support for Texas Instruments SoCs

# CONFIG_SND_SOC_UNIPHIER is not set
# CONFIG_SND_SOC_XILINX_I2S is not set
CONFIG_SND_SOC_XILINX_AUDIO_FORMATTER=y
# CONFIG_SND_SOC_XILINX_SPDIF is not set
# CONFIG_SND_SOC_XTFPGA_I2S is not set
CONFIG_SND_SOC_I2C_AND_SPI=y

#
# CODEC drivers
#
CONFIG_SND_SOC_ALL_CODECS=y
CONFIG_SND_SOC_88PM860X=y
CONFIG_SND_SOC_WM_HUBS=y
CONFIG_SND_SOC_WM_ADSP=y
# CONFIG_SND_SOC_AB8500_CODEC is not set
CONFIG_SND_SOC_AC97_CODEC=y
CONFIG_SND_SOC_AD1836=y
CONFIG_SND_SOC_AD193X=y
CONFIG_SND_SOC_AD193X_SPI=y
CONFIG_SND_SOC_AD193X_I2C=y
CONFIG_SND_SOC_AD1980=y
CONFIG_SND_SOC_AD73311=y
CONFIG_SND_SOC_ADAU_UTILS=y
CONFIG_SND_SOC_ADAU1372=y
CONFIG_SND_SOC_ADAU1372_I2C=y
CONFIG_SND_SOC_ADAU1372_SPI=y
CONFIG_SND_SOC_ADAU1373=y
# CONFIG_SND_SOC_ADAU1701 is not set
CONFIG_SND_SOC_ADAU17X1=y
CONFIG_SND_SOC_ADAU1761=y
CONFIG_SND_SOC_ADAU1761_I2C=y
CONFIG_SND_SOC_ADAU1761_SPI=y
CONFIG_SND_SOC_ADAU1781=y
CONFIG_SND_SOC_ADAU1781_I2C=y
CONFIG_SND_SOC_ADAU1781_SPI=y
CONFIG_SND_SOC_ADAU1977=y
CONFIG_SND_SOC_ADAU1977_SPI=y
CONFIG_SND_SOC_ADAU1977_I2C=y
CONFIG_SND_SOC_ADAU7002=y
CONFIG_SND_SOC_ADAU7118=y
CONFIG_SND_SOC_ADAU7118_HW=y
# CONFIG_SND_SOC_ADAU7118_I2C is not set
CONFIG_SND_SOC_ADAV80X=y
CONFIG_SND_SOC_ADAV801=y
CONFIG_SND_SOC_ADAV803=y
CONFIG_SND_SOC_ADS117X=y
# CONFIG_SND_SOC_AK4104 is not set
# CONFIG_SND_SOC_AK4118 is not set
CONFIG_SND_SOC_AK4375=y
# CONFIG_SND_SOC_AK4458 is not set
CONFIG_SND_SOC_AK4535=y
CONFIG_SND_SOC_AK4554=y
CONFIG_SND_SOC_AK4613=y
CONFIG_SND_SOC_AK4641=y
# CONFIG_SND_SOC_AK4642 is not set
CONFIG_SND_SOC_AK4671=y
# CONFIG_SND_SOC_AK5386 is not set
# CONFIG_SND_SOC_AK5558 is not set
# CONFIG_SND_SOC_ALC5623 is not set
CONFIG_SND_SOC_ALC5632=y
CONFIG_SND_SOC_AW8738=y
CONFIG_SND_SOC_BD28623=y
CONFIG_SND_SOC_BT_SCO=y
CONFIG_SND_SOC_CPCAP=y
CONFIG_SND_SOC_CQ0093VC=y
# CONFIG_SND_SOC_CROS_EC_CODEC is not set
CONFIG_SND_SOC_CS35L32=y
CONFIG_SND_SOC_CS35L33=y
# CONFIG_SND_SOC_CS35L34 is not set
CONFIG_SND_SOC_CS35L35=y
CONFIG_SND_SOC_CS35L36=y
CONFIG_SND_SOC_CS35L41_LIB=y
CONFIG_SND_SOC_CS35L41=y
CONFIG_SND_SOC_CS35L41_SPI=y
# CONFIG_SND_SOC_CS35L41_I2C is not set
CONFIG_SND_SOC_CS35L45_TABLES=y
CONFIG_SND_SOC_CS35L45=y
# CONFIG_SND_SOC_CS35L45_SPI is not set
CONFIG_SND_SOC_CS35L45_I2C=y
# CONFIG_SND_SOC_CS42L42 is not set
CONFIG_SND_SOC_CS42L51=y
CONFIG_SND_SOC_CS42L51_I2C=y
CONFIG_SND_SOC_CS42L52=y
CONFIG_SND_SOC_CS42L56=y
CONFIG_SND_SOC_CS42L73=y
CONFIG_SND_SOC_CS4234=y
# CONFIG_SND_SOC_CS4265 is not set
# CONFIG_SND_SOC_CS4270 is not set
CONFIG_SND_SOC_CS4271=y
CONFIG_SND_SOC_CS4271_I2C=y
# CONFIG_SND_SOC_CS4271_SPI is not set
# CONFIG_SND_SOC_CS42XX8_I2C is not set
CONFIG_SND_SOC_CS43130=y
# CONFIG_SND_SOC_CS4341 is not set
CONFIG_SND_SOC_CS4349=y
CONFIG_SND_SOC_CS47L15=y
# CONFIG_SND_SOC_CS47L24 is not set
CONFIG_SND_SOC_CS47L35=y
# CONFIG_SND_SOC_CS47L85 is not set
CONFIG_SND_SOC_CS47L90=y
# CONFIG_SND_SOC_CS47L92 is not set
# CONFIG_SND_SOC_CS53L30 is not set
# CONFIG_SND_SOC_CX20442 is not set
CONFIG_SND_SOC_CX2072X=y
# CONFIG_SND_SOC_JZ4740_CODEC is not set
# CONFIG_SND_SOC_JZ4725B_CODEC is not set
# CONFIG_SND_SOC_JZ4760_CODEC is not set
# CONFIG_SND_SOC_JZ4770_CODEC is not set
CONFIG_SND_SOC_L3=y
CONFIG_SND_SOC_DA7210=y
CONFIG_SND_SOC_DA7213=y
CONFIG_SND_SOC_DA7218=y
CONFIG_SND_SOC_DA7219=y
CONFIG_SND_SOC_DA732X=y
CONFIG_SND_SOC_DA9055=y
CONFIG_SND_SOC_DMIC=y
CONFIG_SND_SOC_HDMI_CODEC=y
# CONFIG_SND_SOC_ES7134 is not set
CONFIG_SND_SOC_ES7241=y
CONFIG_SND_SOC_ES8316=y
CONFIG_SND_SOC_ES8328=y
CONFIG_SND_SOC_ES8328_I2C=y
CONFIG_SND_SOC_ES8328_SPI=y
# CONFIG_SND_SOC_GTM601 is not set
CONFIG_SND_SOC_HDAC_HDMI=y
CONFIG_SND_SOC_HDAC_HDA=y
CONFIG_SND_SOC_HDA=y
CONFIG_SND_SOC_ICS43432=y
CONFIG_SND_SOC_INNO_RK3036=y
CONFIG_SND_SOC_ISABELLE=y
CONFIG_SND_SOC_LM49453=y
# CONFIG_SND_SOC_LOCHNAGAR_SC is not set
CONFIG_SND_SOC_MADERA=y
# CONFIG_SND_SOC_MAX98088 is not set
CONFIG_SND_SOC_MAX98090=y
CONFIG_SND_SOC_MAX98095=y
CONFIG_SND_SOC_MAX98357A=y
CONFIG_SND_SOC_MAX98371=y
CONFIG_SND_SOC_MAX98504=y
# CONFIG_SND_SOC_MAX9867 is not set
CONFIG_SND_SOC_MAX98925=y
CONFIG_SND_SOC_MAX98926=y
CONFIG_SND_SOC_MAX98927=y
CONFIG_SND_SOC_MAX98520=y
CONFIG_SND_SOC_MAX98373=y
CONFIG_SND_SOC_MAX98373_I2C=y
CONFIG_SND_SOC_MAX98373_SDW=y
CONFIG_SND_SOC_MAX98390=y
# CONFIG_SND_SOC_MAX98396 is not set
CONFIG_SND_SOC_MAX9850=y
# CONFIG_SND_SOC_MAX9860 is not set
CONFIG_SND_SOC_MSM8916_WCD_ANALOG=y
CONFIG_SND_SOC_MSM8916_WCD_DIGITAL=y
CONFIG_SND_SOC_PCM1681=y
# CONFIG_SND_SOC_PCM1789_I2C is not set
CONFIG_SND_SOC_PCM179X=y
CONFIG_SND_SOC_PCM179X_I2C=y
CONFIG_SND_SOC_PCM179X_SPI=y
CONFIG_SND_SOC_PCM186X=y
CONFIG_SND_SOC_PCM186X_I2C=y
CONFIG_SND_SOC_PCM186X_SPI=y
CONFIG_SND_SOC_PCM3008=y
CONFIG_SND_SOC_PCM3060=y
CONFIG_SND_SOC_PCM3060_I2C=y
# CONFIG_SND_SOC_PCM3060_SPI is not set
CONFIG_SND_SOC_PCM3168A=y
CONFIG_SND_SOC_PCM3168A_I2C=y
# CONFIG_SND_SOC_PCM3168A_SPI is not set
CONFIG_SND_SOC_PCM5102A=y
CONFIG_SND_SOC_PCM512x=y
CONFIG_SND_SOC_PCM512x_I2C=y
CONFIG_SND_SOC_PCM512x_SPI=y
CONFIG_SND_SOC_RK3328=y
# CONFIG_SND_SOC_RK817 is not set
CONFIG_SND_SOC_RL6231=y
CONFIG_SND_SOC_RL6347A=y
CONFIG_SND_SOC_RT274=y
CONFIG_SND_SOC_RT286=y
CONFIG_SND_SOC_RT298=y
CONFIG_SND_SOC_RT1011=y
CONFIG_SND_SOC_RT1015=y
CONFIG_SND_SOC_RT1015P=y
CONFIG_SND_SOC_RT1016=y
CONFIG_SND_SOC_RT1019=y
CONFIG_SND_SOC_RT1305=y
CONFIG_SND_SOC_RT1308=y
CONFIG_SND_SOC_RT1308_SDW=y
CONFIG_SND_SOC_RT1316_SDW=y
CONFIG_SND_SOC_RT5514=y
CONFIG_SND_SOC_RT5514_SPI=y
CONFIG_SND_SOC_RT5616=y
# CONFIG_SND_SOC_RT5631 is not set
# CONFIG_SND_SOC_RT5640 is not set
CONFIG_SND_SOC_RT5645=y
CONFIG_SND_SOC_RT5651=y
# CONFIG_SND_SOC_RT5659 is not set
CONFIG_SND_SOC_RT5660=y
CONFIG_SND_SOC_RT5663=y
CONFIG_SND_SOC_RT5665=y
CONFIG_SND_SOC_RT5668=y
CONFIG_SND_SOC_RT5670=y
CONFIG_SND_SOC_RT5677=y
CONFIG_SND_SOC_RT5677_SPI=y
CONFIG_SND_SOC_RT5682=y
CONFIG_SND_SOC_RT5682_I2C=y
CONFIG_SND_SOC_RT5682_SDW=y
CONFIG_SND_SOC_RT5682S=y
CONFIG_SND_SOC_RT700=y
CONFIG_SND_SOC_RT700_SDW=y
CONFIG_SND_SOC_RT711=y
CONFIG_SND_SOC_RT711_SDW=y
CONFIG_SND_SOC_RT711_SDCA_SDW=y
CONFIG_SND_SOC_RT715=y
CONFIG_SND_SOC_RT715_SDW=y
# CONFIG_SND_SOC_RT715_SDCA_SDW is not set
CONFIG_SND_SOC_RT9120=y
CONFIG_SND_SOC_SDW_MOCKUP=y
CONFIG_SND_SOC_SGTL5000=y
CONFIG_SND_SOC_SI476X=y
CONFIG_SND_SOC_SIGMADSP=y
CONFIG_SND_SOC_SIGMADSP_REGMAP=y
CONFIG_SND_SOC_SIMPLE_AMPLIFIER=y
# CONFIG_SND_SOC_SIMPLE_MUX is not set
CONFIG_SND_SOC_SPDIF=y
CONFIG_SND_SOC_SSM2305=y
CONFIG_SND_SOC_SSM2518=y
# CONFIG_SND_SOC_SSM2602_SPI is not set
# CONFIG_SND_SOC_SSM2602_I2C is not set
# CONFIG_SND_SOC_SSM4567 is not set
# CONFIG_SND_SOC_STA32X is not set
CONFIG_SND_SOC_STA350=y
CONFIG_SND_SOC_STA529=y
CONFIG_SND_SOC_STAC9766=y
CONFIG_SND_SOC_STI_SAS=y
CONFIG_SND_SOC_TAS2552=y
# CONFIG_SND_SOC_TAS2562 is not set
# CONFIG_SND_SOC_TAS2764 is not set
CONFIG_SND_SOC_TAS2770=y
CONFIG_SND_SOC_TAS2780=y
CONFIG_SND_SOC_TAS5086=y
# CONFIG_SND_SOC_TAS571X is not set
CONFIG_SND_SOC_TAS5720=y
CONFIG_SND_SOC_TAS5805M=y
CONFIG_SND_SOC_TAS6424=y
CONFIG_SND_SOC_TDA7419=y
# CONFIG_SND_SOC_TFA9879 is not set
# CONFIG_SND_SOC_TFA989X is not set
# CONFIG_SND_SOC_TLV320ADC3XXX is not set
CONFIG_SND_SOC_TLV320AIC23=y
CONFIG_SND_SOC_TLV320AIC23_I2C=y
CONFIG_SND_SOC_TLV320AIC23_SPI=y
CONFIG_SND_SOC_TLV320AIC26=y
# CONFIG_SND_SOC_TLV320AIC31XX is not set
# CONFIG_SND_SOC_TLV320AIC32X4_I2C is not set
# CONFIG_SND_SOC_TLV320AIC32X4_SPI is not set
CONFIG_SND_SOC_TLV320AIC3X=y
CONFIG_SND_SOC_TLV320AIC3X_I2C=y
CONFIG_SND_SOC_TLV320AIC3X_SPI=y
CONFIG_SND_SOC_TLV320DAC33=y
# CONFIG_SND_SOC_TLV320ADCX140 is not set
# CONFIG_SND_SOC_TS3A227E is not set
CONFIG_SND_SOC_TSCS42XX=y
CONFIG_SND_SOC_TSCS454=y
# CONFIG_SND_SOC_TWL4030 is not set
CONFIG_SND_SOC_TWL6040=y
CONFIG_SND_SOC_UDA1334=y
CONFIG_SND_SOC_UDA134X=y
CONFIG_SND_SOC_UDA1380=y
# CONFIG_SND_SOC_WCD9335 is not set
CONFIG_SND_SOC_WCD_MBHC=y
# CONFIG_SND_SOC_WCD934X is not set
CONFIG_SND_SOC_WCD938X=y
CONFIG_SND_SOC_WCD938X_SDW=y
CONFIG_SND_SOC_WL1273=y
CONFIG_SND_SOC_WM0010=y
CONFIG_SND_SOC_WM1250_EV1=y
CONFIG_SND_SOC_WM2000=y
CONFIG_SND_SOC_WM2200=y
CONFIG_SND_SOC_WM5100=y
# CONFIG_SND_SOC_WM5102 is not set
# CONFIG_SND_SOC_WM5110 is not set
# CONFIG_SND_SOC_WM8350 is not set
CONFIG_SND_SOC_WM8400=y
CONFIG_SND_SOC_WM8510=y
# CONFIG_SND_SOC_WM8523 is not set
CONFIG_SND_SOC_WM8524=y
CONFIG_SND_SOC_WM8580=y
CONFIG_SND_SOC_WM8711=y
CONFIG_SND_SOC_WM8727=y
# CONFIG_SND_SOC_WM8728 is not set
CONFIG_SND_SOC_WM8731=y
CONFIG_SND_SOC_WM8731_I2C=y
# CONFIG_SND_SOC_WM8731_SPI is not set
CONFIG_SND_SOC_WM8737=y
# CONFIG_SND_SOC_WM8741 is not set
CONFIG_SND_SOC_WM8750=y
# CONFIG_SND_SOC_WM8753 is not set
CONFIG_SND_SOC_WM8770=y
# CONFIG_SND_SOC_WM8776 is not set
CONFIG_SND_SOC_WM8782=y
CONFIG_SND_SOC_WM8804=y
CONFIG_SND_SOC_WM8804_I2C=y
CONFIG_SND_SOC_WM8804_SPI=y
CONFIG_SND_SOC_WM8900=y
CONFIG_SND_SOC_WM8903=y
CONFIG_SND_SOC_WM8904=y
CONFIG_SND_SOC_WM8940=y
CONFIG_SND_SOC_WM8955=y
CONFIG_SND_SOC_WM8960=y
CONFIG_SND_SOC_WM8961=y
CONFIG_SND_SOC_WM8962=y
CONFIG_SND_SOC_WM8971=y
CONFIG_SND_SOC_WM8974=y
# CONFIG_SND_SOC_WM8978 is not set
CONFIG_SND_SOC_WM8983=y
CONFIG_SND_SOC_WM8985=y
CONFIG_SND_SOC_WM8988=y
CONFIG_SND_SOC_WM8990=y
CONFIG_SND_SOC_WM8991=y
CONFIG_SND_SOC_WM8993=y
CONFIG_SND_SOC_WM8994=y
CONFIG_SND_SOC_WM8995=y
CONFIG_SND_SOC_WM8996=y
# CONFIG_SND_SOC_WM8997 is not set
# CONFIG_SND_SOC_WM8998 is not set
CONFIG_SND_SOC_WM9081=y
CONFIG_SND_SOC_WM9090=y
CONFIG_SND_SOC_WM9705=y
CONFIG_SND_SOC_WM9712=y
CONFIG_SND_SOC_WM9713=y
CONFIG_SND_SOC_WSA881X=y
CONFIG_SND_SOC_WSA883X=y
# CONFIG_SND_SOC_ZL38060 is not set
CONFIG_SND_SOC_LM4857=y
CONFIG_SND_SOC_MAX9759=y
CONFIG_SND_SOC_MAX9768=y
CONFIG_SND_SOC_MAX9877=y
CONFIG_SND_SOC_MC13783=y
CONFIG_SND_SOC_ML26124=y
CONFIG_SND_SOC_MT6351=y
CONFIG_SND_SOC_MT6358=y
# CONFIG_SND_SOC_MT6359 is not set
CONFIG_SND_SOC_MT6660=y
# CONFIG_SND_SOC_NAU8315 is not set
CONFIG_SND_SOC_NAU8540=y
CONFIG_SND_SOC_NAU8810=y
CONFIG_SND_SOC_NAU8821=y
CONFIG_SND_SOC_NAU8822=y
CONFIG_SND_SOC_NAU8824=y
CONFIG_SND_SOC_NAU8825=y
# CONFIG_SND_SOC_TPA6130A2 is not set
CONFIG_SND_SOC_LPASS_MACRO_COMMON=y
CONFIG_SND_SOC_LPASS_WSA_MACRO=y
CONFIG_SND_SOC_LPASS_VA_MACRO=y
# CONFIG_SND_SOC_LPASS_RX_MACRO is not set
CONFIG_SND_SOC_LPASS_TX_MACRO=y
# end of CODEC drivers

CONFIG_SND_SIMPLE_CARD_UTILS=y
CONFIG_SND_SIMPLE_CARD=y
# CONFIG_SND_AUDIO_GRAPH_CARD is not set
# CONFIG_SND_AUDIO_GRAPH_CARD2 is not set
# CONFIG_SND_TEST_COMPONENT is not set
CONFIG_SND_VIRTIO=y
CONFIG_AC97_BUS=y

#
# HID support
#
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
CONFIG_HIDRAW=y
# CONFIG_UHID is not set
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
CONFIG_HID_A4TECH=y
CONFIG_HID_ACRUX=y
CONFIG_HID_ACRUX_FF=y
CONFIG_HID_APPLE=y
CONFIG_HID_AUREAL=y
CONFIG_HID_BELKIN=y
CONFIG_HID_CHERRY=y
# CONFIG_HID_COUGAR is not set
CONFIG_HID_MACALLY=y
CONFIG_HID_CMEDIA=y
CONFIG_HID_CYPRESS=y
# CONFIG_HID_DRAGONRISE is not set
CONFIG_HID_EMS_FF=y
CONFIG_HID_ELECOM=y
CONFIG_HID_EZKEY=y
CONFIG_HID_GEMBIRD=y
CONFIG_HID_GFRM=y
CONFIG_HID_GLORIOUS=y
# CONFIG_HID_VIVALDI is not set
CONFIG_HID_KEYTOUCH=y
CONFIG_HID_KYE=y
# CONFIG_HID_WALTOP is not set
CONFIG_HID_VIEWSONIC=y
# CONFIG_HID_XIAOMI is not set
# CONFIG_HID_GYRATION is not set
# CONFIG_HID_ICADE is not set
CONFIG_HID_ITE=y
CONFIG_HID_JABRA=y
# CONFIG_HID_TWINHAN is not set
# CONFIG_HID_KENSINGTON is not set
# CONFIG_HID_LCPOWER is not set
CONFIG_HID_LED=y
CONFIG_HID_LENOVO=y
# CONFIG_HID_MAGICMOUSE is not set
# CONFIG_HID_MALTRON is not set
CONFIG_HID_MAYFLASH=y
CONFIG_HID_REDRAGON=y
CONFIG_HID_MICROSOFT=y
CONFIG_HID_MONTEREY=y
# CONFIG_HID_MULTITOUCH is not set
# CONFIG_HID_NINTENDO is not set
CONFIG_HID_NTI=y
CONFIG_HID_ORTEK=y
CONFIG_HID_PANTHERLORD=y
CONFIG_PANTHERLORD_FF=y
CONFIG_HID_PETALYNX=y
CONFIG_HID_PICOLCD=y
# CONFIG_HID_PICOLCD_BACKLIGHT is not set
# CONFIG_HID_PICOLCD_LCD is not set
CONFIG_HID_PICOLCD_LEDS=y
# CONFIG_HID_PICOLCD_CIR is not set
# CONFIG_HID_PLANTRONICS is not set
CONFIG_HID_RAZER=y
CONFIG_HID_PRIMAX=y
# CONFIG_HID_SAITEK is not set
# CONFIG_HID_SEMITEK is not set
CONFIG_HID_SPEEDLINK=y
# CONFIG_HID_STEAM is not set
CONFIG_HID_STEELSERIES=y
# CONFIG_HID_SUNPLUS is not set
CONFIG_HID_RMI=y
CONFIG_HID_GREENASIA=y
CONFIG_GREENASIA_FF=y
CONFIG_HID_SMARTJOYPLUS=y
# CONFIG_SMARTJOYPLUS_FF is not set
CONFIG_HID_TIVO=y
CONFIG_HID_TOPSEED=y
CONFIG_HID_THINGM=y
# CONFIG_HID_UDRAW_PS3 is not set
CONFIG_HID_WIIMOTE=y
# CONFIG_HID_XINMO is not set
CONFIG_HID_ZEROPLUS=y
CONFIG_ZEROPLUS_FF=y
CONFIG_HID_ZYDACRON=y
# CONFIG_HID_SENSOR_HUB is not set
CONFIG_HID_ALPS=y
# end of Special HID drivers

#
# I2C HID support
#
CONFIG_I2C_HID_ACPI=y
# CONFIG_I2C_HID_OF is not set
# CONFIG_I2C_HID_OF_ELAN is not set
# CONFIG_I2C_HID_OF_GOODIX is not set
# end of I2C HID support

CONFIG_I2C_HID_CORE=y

#
# Intel ISH HID support
#
# end of Intel ISH HID support

#
# AMD SFH HID Support
#
# CONFIG_AMD_SFH_HID is not set
# end of AMD SFH HID Support
# end of HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
# CONFIG_USB_SUPPORT is not set
CONFIG_MMC=y
CONFIG_PWRSEQ_EMMC=y
CONFIG_PWRSEQ_SIMPLE=y
CONFIG_MMC_TEST=y

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_SDHCI=y
CONFIG_MMC_SDHCI_IO_ACCESSORS=y
CONFIG_MMC_SDHCI_PCI=y
CONFIG_MMC_RICOH_MMC=y
CONFIG_MMC_SDHCI_ACPI=y
# CONFIG_MMC_SDHCI_PLTFM is not set
CONFIG_MMC_SDHCI_S3C=y
# CONFIG_MMC_SDHCI_SPEAR is not set
CONFIG_MMC_SDHCI_S3C_DMA=y
# CONFIG_MMC_MESON_GX is not set
# CONFIG_MMC_MESON_MX_SDHC is not set
# CONFIG_MMC_MESON_MX_SDIO is not set
CONFIG_MMC_MOXART=y
# CONFIG_MMC_OMAP_HS is not set
CONFIG_MMC_ALCOR=y
CONFIG_MMC_TIFM_SD=y
CONFIG_MMC_DAVINCI=y
CONFIG_MMC_SPI=y
# CONFIG_MMC_S3C is not set
CONFIG_MMC_TMIO_CORE=y
# CONFIG_MMC_TMIO is not set
CONFIG_MMC_SDHI=y
# CONFIG_MMC_SDHI_SYS_DMAC is not set
# CONFIG_MMC_SDHI_INTERNAL_DMAC is not set
# CONFIG_MMC_UNIPHIER is not set
# CONFIG_MMC_CB710 is not set
CONFIG_MMC_VIA_SDMMC=y
# CONFIG_MMC_DW is not set
CONFIG_MMC_SH_MMCIF=y
# CONFIG_MMC_USDHI6ROL0 is not set
CONFIG_MMC_CQHCI=y
CONFIG_MMC_HSQ=y
CONFIG_MMC_TOSHIBA_PCI=y
CONFIG_MMC_BCM2835=y
# CONFIG_MMC_MTK is not set
# CONFIG_MMC_OWL is not set
# CONFIG_MMC_LITEX is not set
CONFIG_MEMSTICK=y
# CONFIG_MEMSTICK_DEBUG is not set

#
# MemoryStick drivers
#
# CONFIG_MEMSTICK_UNSAFE_RESUME is not set

#
# MemoryStick Host Controller Drivers
#
CONFIG_MEMSTICK_TIFM_MS=y
CONFIG_MEMSTICK_JMICRON_38X=y
CONFIG_MEMSTICK_R592=y
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set
# CONFIG_LEDS_CLASS_MULTICOLOR is not set
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
# CONFIG_LEDS_88PM860X is not set
# CONFIG_LEDS_AN30259A is not set
CONFIG_LEDS_ARIEL=y
# CONFIG_LEDS_AW2013 is not set
# CONFIG_LEDS_BCM6328 is not set
# CONFIG_LEDS_BCM6358 is not set
# CONFIG_LEDS_CPCAP is not set
# CONFIG_LEDS_CR0014114 is not set
# CONFIG_LEDS_EL15203000 is not set
# CONFIG_LEDS_LM3530 is not set
CONFIG_LEDS_LM3532=y
CONFIG_LEDS_LM3533=y
# CONFIG_LEDS_LM3642 is not set
# CONFIG_LEDS_LM3692X is not set
CONFIG_LEDS_S3C24XX=y
CONFIG_LEDS_COBALT_QUBE=y
# CONFIG_LEDS_COBALT_RAQ is not set
CONFIG_LEDS_PCA9532=y
# CONFIG_LEDS_PCA9532_GPIO is not set
# CONFIG_LEDS_GPIO is not set
CONFIG_LEDS_LP3944=y
# CONFIG_LEDS_LP3952 is not set
CONFIG_LEDS_LP50XX=y
# CONFIG_LEDS_LP55XX_COMMON is not set
# CONFIG_LEDS_LP8860 is not set
CONFIG_LEDS_PCA955X=y
# CONFIG_LEDS_PCA955X_GPIO is not set
# CONFIG_LEDS_PCA963X is not set
CONFIG_LEDS_WM831X_STATUS=y
# CONFIG_LEDS_DA903X is not set
CONFIG_LEDS_DAC124S085=y
# CONFIG_LEDS_REGULATOR is not set
CONFIG_LEDS_BD2802=y
CONFIG_LEDS_LT3593=y
# CONFIG_LEDS_MC13783 is not set
# CONFIG_LEDS_NS2 is not set
CONFIG_LEDS_NETXBIG=y
CONFIG_LEDS_TCA6507=y
CONFIG_LEDS_TLC591XX=y
# CONFIG_LEDS_MAX77650 is not set
CONFIG_LEDS_MAX8997=y
CONFIG_LEDS_LM355x=y
CONFIG_LEDS_OT200=y
CONFIG_LEDS_IS31FL319X=y
# CONFIG_LEDS_IS31FL32XX is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=y
# CONFIG_LEDS_SYSCON is not set
# CONFIG_LEDS_MLXREG is not set
# CONFIG_LEDS_USER is not set
# CONFIG_LEDS_SPI_BYTE is not set
CONFIG_LEDS_TI_LMU_COMMON=y
# CONFIG_LEDS_LM3697 is not set
CONFIG_LEDS_LM36274=y
# CONFIG_LEDS_TPS6105X is not set
CONFIG_LEDS_IP30=y
CONFIG_LEDS_ACER_A500=y
# CONFIG_LEDS_BCM63138 is not set
# CONFIG_LEDS_LGM is not set

#
# Flash and Torch LED drivers
#

#
# RGB LED drivers
#

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=y
# CONFIG_LEDS_TRIGGER_ONESHOT is not set
CONFIG_LEDS_TRIGGER_HEARTBEAT=y
# CONFIG_LEDS_TRIGGER_BACKLIGHT is not set
CONFIG_LEDS_TRIGGER_CPU=y
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
# CONFIG_LEDS_TRIGGER_GPIO is not set
# CONFIG_LEDS_TRIGGER_DEFAULT_ON is not set

#
# iptables trigger is under Netfilter config (LED target)
#
# CONFIG_LEDS_TRIGGER_TRANSIENT is not set
CONFIG_LEDS_TRIGGER_CAMERA=y
# CONFIG_LEDS_TRIGGER_PANIC is not set
CONFIG_LEDS_TRIGGER_NETDEV=y
CONFIG_LEDS_TRIGGER_PATTERN=y
CONFIG_LEDS_TRIGGER_AUDIO=y

#
# Simple LED drivers
#
# CONFIG_ACCESSIBILITY is not set
CONFIG_INFINIBAND=y
CONFIG_INFINIBAND_USER_MAD=y
# CONFIG_INFINIBAND_USER_ACCESS is not set
# CONFIG_INFINIBAND_ADDR_TRANS is not set
CONFIG_INFINIBAND_VIRT_DMA=y
CONFIG_INFINIBAND_MTHCA=y
# CONFIG_INFINIBAND_MTHCA_DEBUG is not set
CONFIG_RDMA_RXE=y
CONFIG_RDMA_SIW=y
CONFIG_RTC_LIB=y
# CONFIG_RTC_CLASS is not set
# CONFIG_DMADEVICES is not set

#
# DMABUF options
#
# CONFIG_SYNC_FILE is not set
# CONFIG_UDMABUF is not set
CONFIG_DMABUF_MOVE_NOTIFY=y
CONFIG_DMABUF_DEBUG=y
CONFIG_DMABUF_SELFTESTS=y
CONFIG_DMABUF_HEAPS=y
CONFIG_DMABUF_SYSFS_STATS=y
CONFIG_DMABUF_HEAPS_SYSTEM=y
CONFIG_DMABUF_HEAPS_CMA=y
# end of DMABUF options

CONFIG_AUXDISPLAY=y
CONFIG_CHARLCD=y
CONFIG_LINEDISP=y
CONFIG_HD44780_COMMON=y
# CONFIG_HD44780 is not set
# CONFIG_IMG_ASCII_LCD is not set
CONFIG_LCD2S=y
CONFIG_PANEL_CHANGE_MESSAGE=y
CONFIG_PANEL_BOOT_MESSAGE=""
CONFIG_CHARLCD_BL_OFF=y
# CONFIG_CHARLCD_BL_ON is not set
# CONFIG_CHARLCD_BL_FLASH is not set
CONFIG_UIO=y
# CONFIG_UIO_CIF is not set
# CONFIG_UIO_PDRV_GENIRQ is not set
CONFIG_UIO_DMEM_GENIRQ=y
# CONFIG_UIO_AEC is not set
CONFIG_UIO_SERCOS3=y
CONFIG_UIO_PCI_GENERIC=y
# CONFIG_UIO_NETX is not set
CONFIG_UIO_PRUSS=y
CONFIG_UIO_MF624=y
CONFIG_UIO_DFL=y
CONFIG_VFIO=y
CONFIG_VFIO_VIRQFD=y
# CONFIG_VFIO_NOIOMMU is not set
CONFIG_VFIO_PCI_CORE=y
CONFIG_VFIO_PCI_MMAP=y
CONFIG_VFIO_PCI_INTX=y
CONFIG_VFIO_PCI=y
# CONFIG_VFIO_PLATFORM is not set
# CONFIG_VFIO_MDEV is not set
CONFIG_IRQ_BYPASS_MANAGER=y
CONFIG_VIRT_DRIVERS=y
CONFIG_VMGENID=y
CONFIG_VIRTIO_ANCHOR=y
CONFIG_VIRTIO=y
# CONFIG_VIRTIO_MENU is not set
# CONFIG_VDPA is not set
# CONFIG_VHOST_MENU is not set

#
# Microsoft Hyper-V guest support
#
# end of Microsoft Hyper-V guest support

CONFIG_GREYBUS=y
# CONFIG_COMEDI is not set
CONFIG_STAGING=y

#
# IIO staging drivers
#

#
# Accelerometers
#
CONFIG_ADIS16203=y
# CONFIG_ADIS16240 is not set
# end of Accelerometers

#
# Analog to digital converters
#
CONFIG_AD7816=y
# end of Analog to digital converters

#
# Analog digital bi-direction converters
#
# CONFIG_ADT7316 is not set
# end of Analog digital bi-direction converters

#
# Capacitance to digital converters
#
# CONFIG_AD7746 is not set
# end of Capacitance to digital converters

#
# Direct Digital Synthesis
#
CONFIG_AD9832=y
CONFIG_AD9834=y
# end of Direct Digital Synthesis

#
# Network Analyzer, Impedance Converters
#
# CONFIG_AD5933 is not set
# end of Network Analyzer, Impedance Converters

#
# Active energy metering IC
#
CONFIG_ADE7854=y
CONFIG_ADE7854_I2C=y
CONFIG_ADE7854_SPI=y
# end of Active energy metering IC

#
# Resolver to digital converters
#
CONFIG_AD2S1210=y
# end of Resolver to digital converters
# end of IIO staging drivers

# CONFIG_STAGING_MEDIA is not set
# CONFIG_STAGING_BOARD is not set
# CONFIG_COMMON_CLK_XLNX_CLKWZRD is not set
CONFIG_MOST_COMPONENTS=y
# CONFIG_MOST_NET is not set
# CONFIG_MOST_DIM2 is not set
CONFIG_MOST_I2C=y
# CONFIG_KS7010 is not set
CONFIG_GREYBUS_AUDIO=y
CONFIG_GREYBUS_AUDIO_APB_CODEC=y
CONFIG_GREYBUS_BOOTROM=y
CONFIG_GREYBUS_FIRMWARE=y
CONFIG_GREYBUS_HID=y
CONFIG_GREYBUS_LIGHT=y
CONFIG_GREYBUS_LOG=y
CONFIG_GREYBUS_LOOPBACK=y
CONFIG_GREYBUS_POWER=y
CONFIG_GREYBUS_RAW=y
CONFIG_GREYBUS_VIBRATOR=y
CONFIG_GREYBUS_BRIDGED_PHY=y
CONFIG_GREYBUS_GPIO=y
CONFIG_GREYBUS_I2C=y
CONFIG_GREYBUS_SDIO=y
# CONFIG_GREYBUS_SPI is not set
# CONFIG_GREYBUS_ARCHE is not set
CONFIG_BCM_VIDEOCORE=y
# CONFIG_BCM2835_VCHIQ is not set
# CONFIG_SND_BCM2835 is not set
# CONFIG_PI433 is not set
# CONFIG_XIL_AXIS_FIFO is not set
# CONFIG_FIELDBUS_DEV is not set
# CONFIG_VME_BUS is not set
CONFIG_GOLDFISH=y
CONFIG_GOLDFISH_PIPE=y
# CONFIG_CHROME_PLATFORMS is not set
# CONFIG_MELLANOX_PLATFORM is not set
CONFIG_OLPC_XO175=y
CONFIG_SURFACE_PLATFORMS=y
# CONFIG_SURFACE_3_POWER_OPREGION is not set
CONFIG_SURFACE_HOTPLUG=y
CONFIG_SURFACE_PRO3_BUTTON=y
# CONFIG_SURFACE_AGGREGATOR is not set
CONFIG_HAVE_CLK=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
# CONFIG_COMMON_CLK_WM831X is not set

#
# Clock driver for ARM Reference designs
#
CONFIG_CLK_ICST=y
CONFIG_CLK_SP810=y
# end of Clock driver for ARM Reference designs

CONFIG_CLK_HSDK=y
# CONFIG_LMK04832 is not set
# CONFIG_COMMON_CLK_APPLE_NCO is not set
CONFIG_COMMON_CLK_MAX77686=y
# CONFIG_COMMON_CLK_MAX9485 is not set
# CONFIG_COMMON_CLK_HI655X is not set
CONFIG_COMMON_CLK_SCMI=y
CONFIG_COMMON_CLK_SCPI=y
# CONFIG_COMMON_CLK_SI5341 is not set
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI514 is not set
# CONFIG_COMMON_CLK_SI544 is not set
# CONFIG_COMMON_CLK_SI570 is not set
# CONFIG_COMMON_CLK_BM1880 is not set
CONFIG_COMMON_CLK_CDCE706=y
CONFIG_COMMON_CLK_TPS68470=y
# CONFIG_COMMON_CLK_CDCE925 is not set
CONFIG_COMMON_CLK_CS2000_CP=y
# CONFIG_COMMON_CLK_EN7523 is not set
CONFIG_COMMON_CLK_FSL_FLEXSPI=y
CONFIG_COMMON_CLK_FSL_SAI=y
# CONFIG_COMMON_CLK_GEMINI is not set
# CONFIG_COMMON_CLK_LAN966X is not set
CONFIG_COMMON_CLK_ASPEED=y
CONFIG_COMMON_CLK_S2MPS11=y
CONFIG_CLK_TWL6040=y
# CONFIG_COMMON_CLK_AXI_CLKGEN is not set
# CONFIG_CLK_QORIQ is not set
# CONFIG_CLK_LS1028A_PLLDIG is not set
# CONFIG_COMMON_CLK_XGENE is not set
CONFIG_COMMON_CLK_PALMAS=y
# CONFIG_COMMON_CLK_OXNAS is not set
# CONFIG_COMMON_CLK_RS9_PCIE is not set
# CONFIG_COMMON_CLK_VC5 is not set
CONFIG_COMMON_CLK_MMP2_AUDIO=y
# CONFIG_COMMON_CLK_FIXED_MMIO is not set
CONFIG_CLK_ACTIONS=y
# CONFIG_CLK_OWL_S500 is not set
CONFIG_CLK_OWL_S700=y
CONFIG_CLK_OWL_S900=y
# CONFIG_CLK_BAIKAL_T1 is not set
CONFIG_CLK_BCM2711_DVP=y
CONFIG_CLK_BCM2835=y
CONFIG_CLK_BCM_63XX=y
# CONFIG_CLK_BCM_63XX_GATE is not set
# CONFIG_CLK_BCM_KONA is not set
CONFIG_COMMON_CLK_IPROC=y
CONFIG_CLK_BCM_CYGNUS=y
# CONFIG_CLK_BCM_HR2 is not set
CONFIG_CLK_BCM_NSP=y
# CONFIG_CLK_BCM_NS2 is not set
CONFIG_CLK_BCM_SR=y
CONFIG_CLK_RASPBERRYPI=y
CONFIG_COMMON_CLK_HI3516CV300=y
# CONFIG_COMMON_CLK_HI3519 is not set
# CONFIG_COMMON_CLK_HI3559A is not set
# CONFIG_COMMON_CLK_HI3660 is not set
CONFIG_COMMON_CLK_HI3670=y
CONFIG_COMMON_CLK_HI3798CV200=y
# CONFIG_COMMON_CLK_HI6220 is not set
CONFIG_RESET_HISI=y
# CONFIG_STUB_CLK_HI6220 is not set
CONFIG_STUB_CLK_HI3660=y
# CONFIG_COMMON_CLK_BOSTON is not set
CONFIG_MXC_CLK=y
# CONFIG_CLK_IMX8MM is not set
CONFIG_CLK_IMX8MN=y
CONFIG_CLK_IMX8MP=y
CONFIG_CLK_IMX8MQ=y
# CONFIG_CLK_IMX8ULP is not set
CONFIG_CLK_IMX93=y

#
# Ingenic SoCs drivers
#
CONFIG_INGENIC_CGU_COMMON=y
CONFIG_INGENIC_CGU_JZ4740=y
CONFIG_INGENIC_CGU_JZ4725B=y
CONFIG_INGENIC_CGU_JZ4760=y
# CONFIG_INGENIC_CGU_JZ4770 is not set
CONFIG_INGENIC_CGU_JZ4780=y
# CONFIG_INGENIC_CGU_X1000 is not set
# CONFIG_INGENIC_CGU_X1830 is not set
CONFIG_INGENIC_TCU_CLK=y
# end of Ingenic SoCs drivers

# CONFIG_COMMON_CLK_KEYSTONE is not set
CONFIG_TI_SYSCON_CLK=y

#
# Clock driver for MediaTek SoC
#
CONFIG_COMMON_CLK_MEDIATEK=y
# CONFIG_COMMON_CLK_MT2701 is not set
CONFIG_COMMON_CLK_MT2712=y
# CONFIG_COMMON_CLK_MT2712_BDPSYS is not set
CONFIG_COMMON_CLK_MT2712_IMGSYS=y
# CONFIG_COMMON_CLK_MT2712_JPGDECSYS is not set
# CONFIG_COMMON_CLK_MT2712_MFGCFG is not set
CONFIG_COMMON_CLK_MT2712_MMSYS=y
# CONFIG_COMMON_CLK_MT2712_VDECSYS is not set
CONFIG_COMMON_CLK_MT2712_VENCSYS=y
# CONFIG_COMMON_CLK_MT6765 is not set
CONFIG_COMMON_CLK_MT6779=y
CONFIG_COMMON_CLK_MT6779_MMSYS=y
CONFIG_COMMON_CLK_MT6779_IMGSYS=y
CONFIG_COMMON_CLK_MT6779_IPESYS=y
# CONFIG_COMMON_CLK_MT6779_CAMSYS is not set
CONFIG_COMMON_CLK_MT6779_VDECSYS=y
CONFIG_COMMON_CLK_MT6779_VENCSYS=y
# CONFIG_COMMON_CLK_MT6779_MFGCFG is not set
# CONFIG_COMMON_CLK_MT6779_AUDSYS is not set
# CONFIG_COMMON_CLK_MT6797 is not set
CONFIG_COMMON_CLK_MT7622=y
# CONFIG_COMMON_CLK_MT7622_ETHSYS is not set
# CONFIG_COMMON_CLK_MT7622_HIFSYS is not set
CONFIG_COMMON_CLK_MT7622_AUDSYS=y
# CONFIG_COMMON_CLK_MT7629 is not set
CONFIG_COMMON_CLK_MT7986=y
# CONFIG_COMMON_CLK_MT7986_ETHSYS is not set
# CONFIG_COMMON_CLK_MT8135 is not set
CONFIG_COMMON_CLK_MT8167=y
CONFIG_COMMON_CLK_MT8167_AUDSYS=y
CONFIG_COMMON_CLK_MT8167_IMGSYS=y
# CONFIG_COMMON_CLK_MT8167_MFGCFG is not set
CONFIG_COMMON_CLK_MT8167_MMSYS=y
# CONFIG_COMMON_CLK_MT8167_VDECSYS is not set
CONFIG_COMMON_CLK_MT8173=y
# CONFIG_COMMON_CLK_MT8173_MMSYS is not set
# CONFIG_COMMON_CLK_MT8183 is not set
CONFIG_COMMON_CLK_MT8186=y
CONFIG_COMMON_CLK_MT8192=y
CONFIG_COMMON_CLK_MT8192_AUDSYS=y
# CONFIG_COMMON_CLK_MT8192_CAMSYS is not set
CONFIG_COMMON_CLK_MT8192_IMGSYS=y
# CONFIG_COMMON_CLK_MT8192_IMP_IIC_WRAP is not set
CONFIG_COMMON_CLK_MT8192_IPESYS=y
CONFIG_COMMON_CLK_MT8192_MDPSYS=y
# CONFIG_COMMON_CLK_MT8192_MFGCFG is not set
CONFIG_COMMON_CLK_MT8192_MMSYS=y
CONFIG_COMMON_CLK_MT8192_MSDC=y
CONFIG_COMMON_CLK_MT8192_SCP_ADSP=y
CONFIG_COMMON_CLK_MT8192_VDECSYS=y
CONFIG_COMMON_CLK_MT8192_VENCSYS=y
CONFIG_COMMON_CLK_MT8195=y
CONFIG_COMMON_CLK_MT8516=y
CONFIG_COMMON_CLK_MT8516_AUDSYS=y
# end of Clock driver for MediaTek SoC

#
# Clock support for Amlogic platforms
#
# CONFIG_COMMON_CLK_AXG_AUDIO is not set
# end of Clock support for Amlogic platforms

# CONFIG_MSTAR_MSC313_MPLL is not set
CONFIG_MCHP_CLK_MPFS=y
# CONFIG_COMMON_CLK_PISTACHIO is not set
# CONFIG_COMMON_CLK_QCOM is not set
# CONFIG_CLK_MT7621 is not set
# CONFIG_CLK_RENESAS is not set
CONFIG_COMMON_CLK_SAMSUNG=y
CONFIG_S3C64XX_COMMON_CLK=y
CONFIG_S5PV210_COMMON_CLK=y
CONFIG_EXYNOS_3250_COMMON_CLK=y
# CONFIG_EXYNOS_4_COMMON_CLK is not set
# CONFIG_EXYNOS_5250_COMMON_CLK is not set
CONFIG_EXYNOS_5260_COMMON_CLK=y
# CONFIG_EXYNOS_5410_COMMON_CLK is not set
# CONFIG_EXYNOS_5420_COMMON_CLK is not set
CONFIG_EXYNOS_ARM64_COMMON_CLK=y
# CONFIG_EXYNOS_AUDSS_CLK_CON is not set
# CONFIG_EXYNOS_CLKOUT is not set
CONFIG_S3C2410_COMMON_CLK=y
CONFIG_S3C2412_COMMON_CLK=y
# CONFIG_S3C2443_COMMON_CLK is not set
CONFIG_TESLA_FSD_COMMON_CLK=y
# CONFIG_CLK_SIFIVE is not set
CONFIG_CLK_INTEL_SOCFPGA=y
# CONFIG_CLK_INTEL_SOCFPGA32 is not set
CONFIG_CLK_INTEL_SOCFPGA64=y
# CONFIG_SPRD_COMMON_CLK is not set
CONFIG_CLK_STARFIVE_JH7100=y
CONFIG_CLK_STARFIVE_JH7100_AUDIO=y
# CONFIG_CLK_SUNXI is not set
# CONFIG_SUNXI_CCU is not set
CONFIG_COMMON_CLK_TI_ADPLL=y
# CONFIG_CLK_UNIPHIER is not set
# CONFIG_COMMON_CLK_VISCONTI is not set
# CONFIG_CLK_LGM_CGU is not set
CONFIG_XILINX_VCU=y
# CONFIG_COMMON_CLK_ZYNQMP is not set
# CONFIG_HWSPINLOCK is not set

#
# Clock Source drivers
#
CONFIG_TIMER_OF=y
CONFIG_TIMER_PROBE=y
CONFIG_CLKSRC_MMIO=y
CONFIG_BCM2835_TIMER=y
CONFIG_BCM_KONA_TIMER=y
CONFIG_DAVINCI_TIMER=y
CONFIG_DIGICOLOR_TIMER=y
CONFIG_OMAP_DM_TIMER=y
CONFIG_DW_APB_TIMER=y
CONFIG_FTTMR010_TIMER=y
CONFIG_IXP4XX_TIMER=y
# CONFIG_MESON6_TIMER is not set
CONFIG_OWL_TIMER=y
# CONFIG_RDA_TIMER is not set
# CONFIG_SUN4I_TIMER is not set
CONFIG_SUN5I_HSTIMER=y
# CONFIG_TEGRA_TIMER is not set
CONFIG_TEGRA186_TIMER=y
# CONFIG_VT8500_TIMER is not set
CONFIG_NPCM7XX_TIMER=y
# CONFIG_CADENCE_TTC_TIMER is not set
CONFIG_ASM9260_TIMER=y
CONFIG_CLKSRC_DBX500_PRCMU=y
CONFIG_CLPS711X_TIMER=y
CONFIG_MXS_TIMER=y
# CONFIG_NSPIRE_TIMER is not set
CONFIG_INTEGRATOR_AP_TIMER=y
CONFIG_CLKSRC_PISTACHIO=y
CONFIG_CLKSRC_TI_32K=y
# CONFIG_CLKSRC_STM32_LP is not set
CONFIG_CLKSRC_MPS2=y
# CONFIG_ARC_TIMERS is not set
# CONFIG_ARM_TIMER_SP804 is not set
CONFIG_ARMV7M_SYSTICK=y
CONFIG_ATMEL_PIT=y
CONFIG_ATMEL_ST=y
CONFIG_CLKSRC_SAMSUNG_PWM=y
CONFIG_FSL_FTM_TIMER=y
# CONFIG_OXNAS_RPS_TIMER is not set
# CONFIG_MTK_TIMER is not set
# CONFIG_SPRD_TIMER is not set
# CONFIG_CLKSRC_JCORE_PIT is not set
CONFIG_SH_TIMER_CMT=y
CONFIG_SH_TIMER_MTU2=y
# CONFIG_RENESAS_OSTM is not set
# CONFIG_SH_TIMER_TMU is not set
CONFIG_EM_TIMER_STI=y
# CONFIG_CLKSRC_VERSATILE is not set
# CONFIG_CLKSRC_PXA is not set
# CONFIG_TIMER_IMX_SYS_CTR is not set
# CONFIG_CLKSRC_ST_LPC is not set
# CONFIG_GXP_TIMER is not set
CONFIG_MSC313E_TIMER=y
CONFIG_INGENIC_TIMER=y
CONFIG_INGENIC_SYSOST=y
# CONFIG_INGENIC_OST is not set
# CONFIG_MICROCHIP_PIT64B is not set
# end of Clock Source drivers

CONFIG_MAILBOX=y
CONFIG_IMX_MBOX=y
# CONFIG_PLATFORM_MHU is not set
# CONFIG_ARMADA_37XX_RWTM_MBOX is not set
CONFIG_ROCKCHIP_MBOX=y
CONFIG_PCC=y
CONFIG_ALTERA_MBOX=y
# CONFIG_HI3660_MBOX is not set
# CONFIG_HI6220_MBOX is not set
# CONFIG_MAILBOX_TEST is not set
# CONFIG_POLARFIRE_SOC_MAILBOX is not set
CONFIG_QCOM_APCS_IPC=y
CONFIG_BCM_PDC_MBOX=y
# CONFIG_STM32_IPCC is not set
CONFIG_MTK_ADSP_MBOX=y
CONFIG_MTK_CMDQ_MBOX=y
CONFIG_SUN6I_MSGBOX=y
CONFIG_SPRD_MBOX=y
CONFIG_QCOM_IPCC=y
CONFIG_IOMMU_API=y
# CONFIG_IOMMU_SUPPORT is not set

#
# Remoteproc drivers
#
CONFIG_REMOTEPROC=y
CONFIG_REMOTEPROC_CDEV=y
CONFIG_INGENIC_VPU_RPROC=y
# CONFIG_MTK_SCP is not set
# CONFIG_MESON_MX_AO_ARC_REMOTEPROC is not set
CONFIG_RCAR_REMOTEPROC=y
# end of Remoteproc drivers

#
# Rpmsg drivers
#
CONFIG_RPMSG=y
# CONFIG_RPMSG_CHAR is not set
CONFIG_RPMSG_CTRL=y
CONFIG_RPMSG_NS=y
CONFIG_RPMSG_QCOM_GLINK=y
CONFIG_RPMSG_QCOM_GLINK_RPM=y
# CONFIG_RPMSG_VIRTIO is not set
# end of Rpmsg drivers

CONFIG_SOUNDWIRE=y

#
# SoundWire Devices
#
# CONFIG_SOUNDWIRE_INTEL is not set
# CONFIG_SOUNDWIRE_QCOM is not set

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#
CONFIG_MESON_CANVAS=y
CONFIG_MESON_CLK_MEASURE=y
CONFIG_MESON_GX_SOCINFO=y
# CONFIG_MESON_MX_SOCINFO is not set
# end of Amlogic SoC drivers

#
# Apple SoC drivers
#
# CONFIG_APPLE_RTKIT is not set
# CONFIG_APPLE_SART is not set
# end of Apple SoC drivers

#
# ASPEED SoC drivers
#
CONFIG_ASPEED_LPC_CTRL=y
# CONFIG_ASPEED_LPC_SNOOP is not set
CONFIG_ASPEED_UART_ROUTING=y
CONFIG_ASPEED_P2A_CTRL=y
# CONFIG_ASPEED_SOCINFO is not set
# end of ASPEED SoC drivers

CONFIG_AT91_SOC_ID=y
CONFIG_AT91_SOC_SFR=y

#
# Broadcom SoC drivers
#
# CONFIG_BCM2835_POWER is not set
# CONFIG_SOC_BCM63XX is not set
CONFIG_SOC_BRCMSTB=y
# CONFIG_BCM_PMB is not set
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# CONFIG_QUICC_ENGINE is not set
CONFIG_DPAA2_CONSOLE=y
# end of NXP/Freescale QorIQ SoC drivers

#
# fujitsu SoC drivers
#
# end of fujitsu SoC drivers

#
# i.MX SoC drivers
#
# CONFIG_SOC_IMX8M is not set
# end of i.MX SoC drivers

#
# IXP4xx SoC drivers
#
CONFIG_IXP4XX_QMGR=y
CONFIG_IXP4XX_NPE=y
# end of IXP4xx SoC drivers

#
# Enable LiteX SoC Builder specific drivers
#
CONFIG_LITEX=y
CONFIG_LITEX_SOC_CONTROLLER=y
# end of Enable LiteX SoC Builder specific drivers

#
# MediaTek SoC drivers
#
CONFIG_MTK_CMDQ=y
# CONFIG_MTK_DEVAPC is not set
CONFIG_MTK_INFRACFG=y
# CONFIG_MTK_PMIC_WRAP is not set
# CONFIG_MTK_SCPSYS is not set
# CONFIG_MTK_MMSYS is not set
# end of MediaTek SoC drivers

#
# Qualcomm SoC drivers
#
# CONFIG_QCOM_COMMAND_DB is not set
CONFIG_QCOM_GENI_SE=y
CONFIG_QCOM_GSBI=y
# CONFIG_QCOM_LLCC is not set
CONFIG_QCOM_PDR_HELPERS=y
CONFIG_QCOM_QMI_HELPERS=y
CONFIG_QCOM_RPMH=y
# CONFIG_QCOM_SMD_RPM is not set
# CONFIG_QCOM_SPM is not set
# CONFIG_QCOM_WCNSS_CTRL is not set
CONFIG_QCOM_APR=y
# CONFIG_QCOM_ICC_BWMON is not set
# end of Qualcomm SoC drivers

CONFIG_SOC_RENESAS=y
CONFIG_RST_RCAR=y
CONFIG_SYSC_RCAR=y
CONFIG_SYSC_RCAR_GEN4=y
# CONFIG_SYSC_R8A77995 is not set
# CONFIG_SYSC_R8A7794 is not set
CONFIG_SYSC_R8A77990=y
# CONFIG_SYSC_R8A7779 is not set
# CONFIG_SYSC_R8A7790 is not set
CONFIG_SYSC_R8A7795=y
CONFIG_SYSC_R8A7791=y
# CONFIG_SYSC_R8A77965 is not set
# CONFIG_SYSC_R8A77960 is not set
# CONFIG_SYSC_R8A77961 is not set
# CONFIG_SYSC_R8A779F0 is not set
# CONFIG_SYSC_R8A7792 is not set
CONFIG_SYSC_R8A77980=y
CONFIG_SYSC_R8A77970=y
CONFIG_SYSC_R8A779A0=y
CONFIG_SYSC_R8A779G0=y
# CONFIG_SYSC_RMOBILE is not set
# CONFIG_SYSC_R8A77470 is not set
CONFIG_SYSC_R8A7745=y
# CONFIG_SYSC_R8A7742 is not set
# CONFIG_SYSC_R8A7743 is not set
CONFIG_SYSC_R8A774C0=y
CONFIG_SYSC_R8A774E1=y
CONFIG_SYSC_R8A774A1=y
CONFIG_SYSC_R8A774B1=y
CONFIG_ROCKCHIP_GRF=y
# CONFIG_ROCKCHIP_IODOMAIN is not set
CONFIG_SOC_SAMSUNG=y
# CONFIG_EXYNOS_ASV_ARM is not set
CONFIG_EXYNOS_CHIPID=y
# CONFIG_EXYNOS_USI is not set
# CONFIG_EXYNOS_PM_DOMAINS is not set
# CONFIG_EXYNOS_REGULATOR_COUPLER is not set
CONFIG_SOC_TEGRA20_VOLTAGE_COUPLER=y
# CONFIG_SOC_TEGRA30_VOLTAGE_COUPLER is not set
CONFIG_SOC_TI=y
# CONFIG_UX500_SOC_ID is not set

#
# Xilinx SoC drivers
#
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=y
# CONFIG_DEVFREQ_GOV_PERFORMANCE is not set
CONFIG_DEVFREQ_GOV_POWERSAVE=y
CONFIG_DEVFREQ_GOV_USERSPACE=y
CONFIG_DEVFREQ_GOV_PASSIVE=y

#
# DEVFREQ Drivers
#
CONFIG_ARM_EXYNOS_BUS_DEVFREQ=y
CONFIG_ARM_IMX_BUS_DEVFREQ=y
CONFIG_ARM_TEGRA_DEVFREQ=y
CONFIG_ARM_MEDIATEK_CCI_DEVFREQ=y
# CONFIG_ARM_SUN8I_A33_MBUS_DEVFREQ is not set
CONFIG_PM_DEVFREQ_EVENT=y
CONFIG_DEVFREQ_EVENT_EXYNOS_NOCP=y
CONFIG_DEVFREQ_EVENT_EXYNOS_PPMU=y
# CONFIG_DEVFREQ_EVENT_ROCKCHIP_DFI is not set
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
# CONFIG_EXTCON_ADC_JACK is not set
CONFIG_EXTCON_FSA9480=y
# CONFIG_EXTCON_GPIO is not set
CONFIG_EXTCON_INTEL_INT3496=y
CONFIG_EXTCON_MAX14577=y
# CONFIG_EXTCON_MAX3355 is not set
CONFIG_EXTCON_MAX77843=y
CONFIG_EXTCON_MAX8997=y
CONFIG_EXTCON_PALMAS=y
CONFIG_EXTCON_PTN5150=y
CONFIG_EXTCON_QCOM_SPMI_MISC=y
CONFIG_EXTCON_RT8973A=y
CONFIG_EXTCON_SM5502=y
# CONFIG_EXTCON_USB_GPIO is not set
# CONFIG_EXTCON_USBC_TUSB320 is not set
# CONFIG_MEMORY is not set
CONFIG_IIO=y
CONFIG_IIO_BUFFER=y
CONFIG_IIO_BUFFER_CB=y
CONFIG_IIO_BUFFER_DMA=y
CONFIG_IIO_BUFFER_DMAENGINE=y
CONFIG_IIO_BUFFER_HW_CONSUMER=y
CONFIG_IIO_KFIFO_BUF=y
CONFIG_IIO_TRIGGERED_BUFFER=y
CONFIG_IIO_CONFIGFS=y
CONFIG_IIO_TRIGGER=y
CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
CONFIG_IIO_SW_DEVICE=y
# CONFIG_IIO_SW_TRIGGER is not set
CONFIG_IIO_TRIGGERED_EVENT=y

#
# Accelerometers
#
CONFIG_ADIS16201=y
CONFIG_ADIS16209=y
CONFIG_ADXL313=y
CONFIG_ADXL313_I2C=y
CONFIG_ADXL313_SPI=y
CONFIG_ADXL345=y
CONFIG_ADXL345_I2C=y
# CONFIG_ADXL345_SPI is not set
# CONFIG_ADXL355_I2C is not set
# CONFIG_ADXL355_SPI is not set
CONFIG_ADXL367=y
CONFIG_ADXL367_SPI=y
CONFIG_ADXL367_I2C=y
CONFIG_ADXL372=y
CONFIG_ADXL372_SPI=y
CONFIG_ADXL372_I2C=y
CONFIG_BMA180=y
CONFIG_BMA220=y
CONFIG_BMA400=y
CONFIG_BMA400_I2C=y
CONFIG_BMA400_SPI=y
# CONFIG_BMC150_ACCEL is not set
CONFIG_BMI088_ACCEL=y
CONFIG_BMI088_ACCEL_SPI=y
CONFIG_DA280=y
CONFIG_DA311=y
# CONFIG_DMARD06 is not set
CONFIG_DMARD09=y
# CONFIG_DMARD10 is not set
CONFIG_FXLS8962AF=y
CONFIG_FXLS8962AF_I2C=y
CONFIG_FXLS8962AF_SPI=y
CONFIG_IIO_ST_ACCEL_3AXIS=y
# CONFIG_IIO_ST_ACCEL_I2C_3AXIS is not set
CONFIG_IIO_ST_ACCEL_SPI_3AXIS=y
CONFIG_KXSD9=y
# CONFIG_KXSD9_SPI is not set
CONFIG_KXSD9_I2C=y
CONFIG_KXCJK1013=y
CONFIG_MC3230=y
# CONFIG_MMA7455_I2C is not set
# CONFIG_MMA7455_SPI is not set
CONFIG_MMA7660=y
CONFIG_MMA8452=y
CONFIG_MMA9551_CORE=y
CONFIG_MMA9551=y
CONFIG_MMA9553=y
CONFIG_MXC4005=y
CONFIG_MXC6255=y
CONFIG_SCA3000=y
CONFIG_SCA3300=y
# CONFIG_STK8312 is not set
# CONFIG_STK8BA50 is not set
# end of Accelerometers

#
# Analog to digital converters
#
CONFIG_AD_SIGMA_DELTA=y
CONFIG_AD7091R5=y
CONFIG_AD7124=y
CONFIG_AD7192=y
# CONFIG_AD7266 is not set
CONFIG_AD7280=y
CONFIG_AD7291=y
CONFIG_AD7292=y
# CONFIG_AD7298 is not set
CONFIG_AD7476=y
CONFIG_AD7606=y
CONFIG_AD7606_IFACE_PARALLEL=y
# CONFIG_AD7606_IFACE_SPI is not set
# CONFIG_AD7766 is not set
# CONFIG_AD7768_1 is not set
CONFIG_AD7780=y
CONFIG_AD7791=y
CONFIG_AD7793=y
# CONFIG_AD7887 is not set
CONFIG_AD7923=y
CONFIG_AD7949=y
# CONFIG_AD799X is not set
# CONFIG_ADI_AXI_ADC is not set
CONFIG_ASPEED_ADC=y
# CONFIG_AT91_ADC is not set
CONFIG_AT91_SAMA5D2_ADC=y
CONFIG_AXP20X_ADC=y
CONFIG_AXP288_ADC=y
# CONFIG_BCM_IPROC_ADC is not set
CONFIG_BERLIN2_ADC=y
# CONFIG_CC10001_ADC is not set
CONFIG_CPCAP_ADC=y
CONFIG_DA9150_GPADC=y
CONFIG_ENVELOPE_DETECTOR=y
# CONFIG_EXYNOS_ADC is not set
CONFIG_MXS_LRADC_ADC=y
CONFIG_FSL_MX25_ADC=y
CONFIG_HI8435=y
CONFIG_HX711=y
CONFIG_INA2XX_ADC=y
# CONFIG_INGENIC_ADC is not set
CONFIG_IMX7D_ADC=y
CONFIG_IMX8QXP_ADC=y
CONFIG_LPC18XX_ADC=y
# CONFIG_LPC32XX_ADC is not set
# CONFIG_LTC2471 is not set
CONFIG_LTC2485=y
# CONFIG_LTC2496 is not set
CONFIG_LTC2497=y
# CONFIG_MAX1027 is not set
# CONFIG_MAX11100 is not set
# CONFIG_MAX1118 is not set
# CONFIG_MAX1241 is not set
CONFIG_MAX1363=y
CONFIG_MAX9611=y
# CONFIG_MCP320X is not set
CONFIG_MCP3422=y
# CONFIG_MCP3911 is not set
# CONFIG_MEDIATEK_MT6577_AUXADC is not set
# CONFIG_MEN_Z188_ADC is not set
# CONFIG_MESON_SARADC is not set
CONFIG_NAU7802=y
CONFIG_NPCM_ADC=y
CONFIG_PALMAS_GPADC=y
CONFIG_QCOM_VADC_COMMON=y
CONFIG_QCOM_SPMI_IADC=y
CONFIG_QCOM_SPMI_VADC=y
# CONFIG_QCOM_SPMI_ADC5 is not set
# CONFIG_RCAR_GYRO_ADC is not set
CONFIG_ROCKCHIP_SARADC=y
# CONFIG_RZG2L_ADC is not set
CONFIG_SC27XX_ADC=y
# CONFIG_SPEAR_ADC is not set
CONFIG_SD_ADC_MODULATOR=y
# CONFIG_STM32_ADC_CORE is not set
CONFIG_STM32_DFSDM_CORE=y
CONFIG_STM32_DFSDM_ADC=y
CONFIG_TI_ADC081C=y
CONFIG_TI_ADC0832=y
# CONFIG_TI_ADC084S021 is not set
CONFIG_TI_ADC12138=y
CONFIG_TI_ADC108S102=y
# CONFIG_TI_ADC128S052 is not set
CONFIG_TI_ADC161S626=y
CONFIG_TI_ADS1015=y
CONFIG_TI_ADS7950=y
# CONFIG_TI_ADS8344 is not set
# CONFIG_TI_ADS8688 is not set
CONFIG_TI_ADS124S08=y
CONFIG_TI_ADS131E08=y
CONFIG_TI_AM335X_ADC=y
CONFIG_TI_TLC4541=y
# CONFIG_TI_TSC2046 is not set
CONFIG_VF610_ADC=y
CONFIG_XILINX_XADC=y
# CONFIG_XILINX_AMS is not set
# end of Analog to digital converters

#
# Analog to digital and digital to analog converters
#
CONFIG_AD74413R=y
# end of Analog to digital and digital to analog converters

#
# Analog Front Ends
#
CONFIG_IIO_RESCALE=y
# end of Analog Front Ends

#
# Amplifiers
#
CONFIG_AD8366=y
CONFIG_ADA4250=y
# CONFIG_HMC425 is not set
# end of Amplifiers

#
# Capacitance to digital converters
#
# CONFIG_AD7150 is not set
# end of Capacitance to digital converters

#
# Chemical Sensors
#
CONFIG_ATLAS_PH_SENSOR=y
# CONFIG_ATLAS_EZO_SENSOR is not set
# CONFIG_BME680 is not set
CONFIG_CCS811=y
CONFIG_IAQCORE=y
# CONFIG_PMS7003 is not set
# CONFIG_SCD30_CORE is not set
CONFIG_SCD4X=y
CONFIG_SENSIRION_SGP30=y
CONFIG_SENSIRION_SGP40=y
CONFIG_SPS30=y
CONFIG_SPS30_I2C=y
CONFIG_SPS30_SERIAL=y
CONFIG_SENSEAIR_SUNRISE_CO2=y
CONFIG_VZ89X=y
# end of Chemical Sensors

#
# Hid Sensor IIO Common
#
# end of Hid Sensor IIO Common

CONFIG_IIO_MS_SENSORS_I2C=y

#
# IIO SCMI Sensors
#
CONFIG_IIO_SCMI=y
# end of IIO SCMI Sensors

#
# SSP Sensor Common
#
CONFIG_IIO_SSP_SENSORS_COMMONS=y
CONFIG_IIO_SSP_SENSORHUB=y
# end of SSP Sensor Common

CONFIG_IIO_ST_SENSORS_I2C=y
CONFIG_IIO_ST_SENSORS_SPI=y
CONFIG_IIO_ST_SENSORS_CORE=y

#
# Digital to analog converters
#
# CONFIG_AD3552R is not set
# CONFIG_AD5064 is not set
CONFIG_AD5360=y
CONFIG_AD5380=y
CONFIG_AD5421=y
CONFIG_AD5446=y
# CONFIG_AD5449 is not set
CONFIG_AD5592R_BASE=y
CONFIG_AD5592R=y
CONFIG_AD5593R=y
# CONFIG_AD5504 is not set
# CONFIG_AD5624R_SPI is not set
# CONFIG_LTC2688 is not set
# CONFIG_AD5686_SPI is not set
# CONFIG_AD5696_I2C is not set
CONFIG_AD5755=y
CONFIG_AD5758=y
CONFIG_AD5761=y
CONFIG_AD5764=y
CONFIG_AD5766=y
CONFIG_AD5770R=y
CONFIG_AD5791=y
CONFIG_AD7293=y
CONFIG_AD7303=y
CONFIG_AD8801=y
CONFIG_DPOT_DAC=y
CONFIG_DS4424=y
CONFIG_LPC18XX_DAC=y
# CONFIG_LTC1660 is not set
CONFIG_LTC2632=y
CONFIG_M62332=y
CONFIG_MAX517=y
# CONFIG_MAX5821 is not set
# CONFIG_MCP4725 is not set
# CONFIG_MCP4922 is not set
# CONFIG_STM32_DAC is not set
CONFIG_TI_DAC082S085=y
CONFIG_TI_DAC5571=y
CONFIG_TI_DAC7311=y
# CONFIG_TI_DAC7612 is not set
CONFIG_VF610_DAC=y
# end of Digital to analog converters

#
# IIO dummy driver
#
CONFIG_IIO_DUMMY_EVGEN=y
CONFIG_IIO_SIMPLE_DUMMY=y
CONFIG_IIO_SIMPLE_DUMMY_EVENTS=y
# CONFIG_IIO_SIMPLE_DUMMY_BUFFER is not set
# end of IIO dummy driver

#
# Filters
#
CONFIG_ADMV8818=y
# end of Filters

#
# Frequency Synthesizers DDS/PLL
#

#
# Clock Generator/Distribution
#
CONFIG_AD9523=y
# end of Clock Generator/Distribution

#
# Phase-Locked Loop (PLL) frequency synthesizers
#
# CONFIG_ADF4350 is not set
CONFIG_ADF4371=y
CONFIG_ADMV1013=y
CONFIG_ADMV1014=y
CONFIG_ADMV4420=y
# CONFIG_ADRF6780 is not set
# end of Phase-Locked Loop (PLL) frequency synthesizers
# end of Frequency Synthesizers DDS/PLL

#
# Digital gyroscope sensors
#
CONFIG_ADIS16080=y
CONFIG_ADIS16130=y
# CONFIG_ADIS16136 is not set
CONFIG_ADIS16260=y
# CONFIG_ADXRS290 is not set
CONFIG_ADXRS450=y
# CONFIG_BMG160 is not set
# CONFIG_FXAS21002C is not set
# CONFIG_MPU3050_I2C is not set
CONFIG_IIO_ST_GYRO_3AXIS=y
CONFIG_IIO_ST_GYRO_I2C_3AXIS=y
CONFIG_IIO_ST_GYRO_SPI_3AXIS=y
CONFIG_ITG3200=y
# end of Digital gyroscope sensors

#
# Health Sensors
#

#
# Heart Rate Monitors
#
# CONFIG_AFE4403 is not set
# CONFIG_AFE4404 is not set
CONFIG_MAX30100=y
CONFIG_MAX30102=y
# end of Heart Rate Monitors
# end of Health Sensors

#
# Humidity sensors
#
# CONFIG_AM2315 is not set
CONFIG_DHT11=y
CONFIG_HDC100X=y
CONFIG_HDC2010=y
# CONFIG_HTS221 is not set
CONFIG_HTU21=y
CONFIG_SI7005=y
CONFIG_SI7020=y
# end of Humidity sensors

#
# Inertial measurement units
#
CONFIG_ADIS16400=y
CONFIG_ADIS16460=y
CONFIG_ADIS16475=y
# CONFIG_ADIS16480 is not set
CONFIG_BMI160=y
CONFIG_BMI160_I2C=y
CONFIG_BMI160_SPI=y
CONFIG_FXOS8700=y
# CONFIG_FXOS8700_I2C is not set
CONFIG_FXOS8700_SPI=y
CONFIG_KMX61=y
CONFIG_INV_ICM42600=y
CONFIG_INV_ICM42600_I2C=y
CONFIG_INV_ICM42600_SPI=y
CONFIG_INV_MPU6050_IIO=y
CONFIG_INV_MPU6050_I2C=y
# CONFIG_INV_MPU6050_SPI is not set
CONFIG_IIO_ST_LSM6DSX=y
CONFIG_IIO_ST_LSM6DSX_I2C=y
CONFIG_IIO_ST_LSM6DSX_SPI=y
CONFIG_IIO_ST_LSM6DSX_I3C=y
CONFIG_IIO_ST_LSM9DS0=y
# CONFIG_IIO_ST_LSM9DS0_I2C is not set
# CONFIG_IIO_ST_LSM9DS0_SPI is not set
# end of Inertial measurement units

CONFIG_IIO_ADIS_LIB=y
CONFIG_IIO_ADIS_LIB_BUFFER=y

#
# Light sensors
#
# CONFIG_ACPI_ALS is not set
# CONFIG_ADJD_S311 is not set
CONFIG_ADUX1020=y
# CONFIG_AL3010 is not set
CONFIG_AL3320A=y
# CONFIG_APDS9300 is not set
# CONFIG_APDS9960 is not set
# CONFIG_AS73211 is not set
CONFIG_BH1750=y
# CONFIG_BH1780 is not set
CONFIG_CM32181=y
# CONFIG_CM3232 is not set
CONFIG_CM3323=y
# CONFIG_CM3605 is not set
CONFIG_CM36651=y
# CONFIG_GP2AP002 is not set
CONFIG_GP2AP020A00F=y
CONFIG_IQS621_ALS=y
CONFIG_SENSORS_ISL29018=y
# CONFIG_SENSORS_ISL29028 is not set
# CONFIG_ISL29125 is not set
CONFIG_JSA1212=y
CONFIG_RPR0521=y
CONFIG_SENSORS_LM3533=y
CONFIG_LTR501=y
CONFIG_LV0104CS=y
CONFIG_MAX44000=y
CONFIG_MAX44009=y
# CONFIG_NOA1305 is not set
CONFIG_OPT3001=y
CONFIG_PA12203001=y
# CONFIG_SI1133 is not set
CONFIG_SI1145=y
CONFIG_STK3310=y
# CONFIG_ST_UVIS25 is not set
# CONFIG_TCS3414 is not set
CONFIG_TCS3472=y
CONFIG_SENSORS_TSL2563=y
# CONFIG_TSL2583 is not set
CONFIG_TSL2591=y
CONFIG_TSL2772=y
CONFIG_TSL4531=y
CONFIG_US5182D=y
CONFIG_VCNL4000=y
CONFIG_VCNL4035=y
CONFIG_VEML6030=y
# CONFIG_VEML6070 is not set
CONFIG_VL6180=y
CONFIG_ZOPT2201=y
# end of Light sensors

#
# Magnetometer sensors
#
CONFIG_AK8974=y
CONFIG_AK8975=y
CONFIG_AK09911=y
CONFIG_BMC150_MAGN=y
CONFIG_BMC150_MAGN_I2C=y
CONFIG_BMC150_MAGN_SPI=y
CONFIG_MAG3110=y
# CONFIG_MMC35240 is not set
CONFIG_IIO_ST_MAGN_3AXIS=y
CONFIG_IIO_ST_MAGN_I2C_3AXIS=y
# CONFIG_IIO_ST_MAGN_SPI_3AXIS is not set
CONFIG_SENSORS_HMC5843=y
# CONFIG_SENSORS_HMC5843_I2C is not set
CONFIG_SENSORS_HMC5843_SPI=y
CONFIG_SENSORS_RM3100=y
CONFIG_SENSORS_RM3100_I2C=y
CONFIG_SENSORS_RM3100_SPI=y
CONFIG_YAMAHA_YAS530=y
# end of Magnetometer sensors

#
# Multiplexers
#
CONFIG_IIO_MUX=y
# end of Multiplexers

#
# Inclinometer sensors
#
# end of Inclinometer sensors

#
# Triggers - standalone
#
# CONFIG_IIO_INTERRUPT_TRIGGER is not set
CONFIG_IIO_STM32_LPTIMER_TRIGGER=y
# CONFIG_IIO_STM32_TIMER_TRIGGER is not set
# CONFIG_IIO_SYSFS_TRIGGER is not set
# end of Triggers - standalone

#
# Linear and angular position sensors
#
# CONFIG_IQS624_POS is not set
# end of Linear and angular position sensors

#
# Digital potentiometers
#
CONFIG_AD5110=y
CONFIG_AD5272=y
CONFIG_DS1803=y
CONFIG_MAX5432=y
# CONFIG_MAX5481 is not set
CONFIG_MAX5487=y
CONFIG_MCP4018=y
CONFIG_MCP4131=y
# CONFIG_MCP4531 is not set
# CONFIG_MCP41010 is not set
CONFIG_TPL0102=y
# end of Digital potentiometers

#
# Digital potentiostats
#
CONFIG_LMP91000=y
# end of Digital potentiostats

#
# Pressure sensors
#
CONFIG_ABP060MG=y
# CONFIG_BMP280 is not set
CONFIG_DLHL60D=y
CONFIG_DPS310=y
CONFIG_HP03=y
CONFIG_ICP10100=y
CONFIG_MPL115=y
CONFIG_MPL115_I2C=y
CONFIG_MPL115_SPI=y
CONFIG_MPL3115=y
# CONFIG_MS5611 is not set
# CONFIG_MS5637 is not set
CONFIG_IIO_ST_PRESS=y
CONFIG_IIO_ST_PRESS_I2C=y
CONFIG_IIO_ST_PRESS_SPI=y
CONFIG_T5403=y
CONFIG_HP206C=y
CONFIG_ZPA2326=y
CONFIG_ZPA2326_I2C=y
CONFIG_ZPA2326_SPI=y
# end of Pressure sensors

#
# Lightning sensors
#
CONFIG_AS3935=y
# end of Lightning sensors

#
# Proximity and distance sensors
#
# CONFIG_ISL29501 is not set
CONFIG_LIDAR_LITE_V2=y
# CONFIG_MB1232 is not set
CONFIG_PING=y
# CONFIG_RFD77402 is not set
CONFIG_SRF04=y
CONFIG_SX_COMMON=y
CONFIG_SX9310=y
# CONFIG_SX9324 is not set
CONFIG_SX9360=y
CONFIG_SX9500=y
# CONFIG_SRF08 is not set
CONFIG_VCNL3020=y
# CONFIG_VL53L0X_I2C is not set
# end of Proximity and distance sensors

#
# Resolver to digital converters
#
CONFIG_AD2S90=y
CONFIG_AD2S1200=y
# end of Resolver to digital converters

#
# Temperature sensors
#
CONFIG_IQS620AT_TEMP=y
CONFIG_LTC2983=y
CONFIG_MAXIM_THERMOCOUPLE=y
# CONFIG_MLX90614 is not set
# CONFIG_MLX90632 is not set
CONFIG_TMP006=y
CONFIG_TMP007=y
CONFIG_TMP117=y
# CONFIG_TSYS01 is not set
CONFIG_TSYS02D=y
CONFIG_MAX31856=y
CONFIG_MAX31865=y
# end of Temperature sensors

# CONFIG_NTB is not set
# CONFIG_PWM is not set

#
# IRQ chip support
#
CONFIG_IRQCHIP=y
CONFIG_AL_FIC=y
CONFIG_MADERA_IRQ=y
# CONFIG_JCORE_AIC is not set
# CONFIG_RENESAS_INTC_IRQPIN is not set
# CONFIG_RENESAS_IRQC is not set
CONFIG_RENESAS_RZA1_IRQC=y
CONFIG_RENESAS_RZG2L_IRQC=y
# CONFIG_SL28CPLD_INTC is not set
# CONFIG_TS4800_IRQ is not set
# CONFIG_XILINX_INTC is not set
# CONFIG_INGENIC_TCU_IRQ is not set
CONFIG_IRQ_UNIPHIER_AIDET=y
# CONFIG_MESON_IRQ_GPIO is not set
# CONFIG_IMX_IRQSTEER is not set
# CONFIG_IMX_INTMUX is not set
# CONFIG_EXYNOS_IRQ_COMBINER is not set
CONFIG_IRQ_LOONGARCH_CPU=y
CONFIG_LOONGSON_LIOINTC=y
CONFIG_LOONGSON_EIOINTC=y
CONFIG_LOONGSON_HTVEC=y
CONFIG_LOONGSON_PCH_PIC=y
CONFIG_LOONGSON_PCH_MSI=y
CONFIG_LOONGSON_PCH_LPC=y
CONFIG_MST_IRQ=y
CONFIG_MCHP_EIC=y
CONFIG_SUNPLUS_SP7021_INTC=y
# end of IRQ chip support

# CONFIG_IPACK_BUS is not set
CONFIG_RESET_CONTROLLER=y
CONFIG_RESET_A10SR=y
# CONFIG_RESET_ATH79 is not set
# CONFIG_RESET_AXS10X is not set
# CONFIG_RESET_BCM6345 is not set
CONFIG_RESET_BERLIN=y
CONFIG_RESET_BRCMSTB=y
# CONFIG_RESET_BRCMSTB_RESCAL is not set
CONFIG_RESET_HSDK=y
CONFIG_RESET_IMX7=y
# CONFIG_RESET_INTEL_GW is not set
# CONFIG_RESET_K210 is not set
# CONFIG_RESET_LANTIQ is not set
CONFIG_RESET_LPC18XX=y
# CONFIG_RESET_MCHP_SPARX5 is not set
CONFIG_RESET_MESON=y
CONFIG_RESET_MESON_AUDIO_ARB=y
CONFIG_RESET_NPCM=y
CONFIG_RESET_PISTACHIO=y
CONFIG_RESET_QCOM_AOSS=y
CONFIG_RESET_QCOM_PDC=y
CONFIG_RESET_RASPBERRYPI=y
CONFIG_RESET_RZG2L_USBPHY_CTRL=y
CONFIG_RESET_SCMI=y
CONFIG_RESET_SIMPLE=y
# CONFIG_RESET_SOCFPGA is not set
CONFIG_RESET_STARFIVE_JH7100=y
# CONFIG_RESET_SUNPLUS is not set
CONFIG_RESET_SUNXI=y
CONFIG_RESET_TI_SCI=y
CONFIG_RESET_TI_SYSCON=y
# CONFIG_RESET_TI_TPS380X is not set
CONFIG_RESET_TN48M_CPLD=y
# CONFIG_RESET_UNIPHIER is not set
# CONFIG_RESET_UNIPHIER_GLUE is not set
# CONFIG_RESET_ZYNQ is not set
CONFIG_COMMON_RESET_HI3660=y
CONFIG_COMMON_RESET_HI6220=y

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
CONFIG_GENERIC_PHY_MIPI_DPHY=y
# CONFIG_PHY_LPC18XX_USB_OTG is not set
# CONFIG_PHY_PISTACHIO_USB is not set
# CONFIG_PHY_XGENE is not set
CONFIG_PHY_CAN_TRANSCEIVER=y
# CONFIG_PHY_SUN6I_MIPI_DPHY is not set
# CONFIG_PHY_SUN50I_USB3 is not set
# CONFIG_PHY_MESON8_HDMI_TX is not set
# CONFIG_PHY_MESON_G12A_MIPI_DPHY_ANALOG is not set
# CONFIG_PHY_MESON_G12A_USB2 is not set
# CONFIG_PHY_MESON_G12A_USB3_PCIE is not set
# CONFIG_PHY_MESON_AXG_PCIE is not set
# CONFIG_PHY_MESON_AXG_MIPI_PCIE_ANALOG is not set
# CONFIG_PHY_MESON_AXG_MIPI_DPHY is not set

#
# PHY drivers for Broadcom platforms
#
CONFIG_PHY_BCM63XX_USBH=y
# CONFIG_PHY_CYGNUS_PCIE is not set
# CONFIG_PHY_BCM_SR_USB is not set
# CONFIG_BCM_KONA_USB2_PHY is not set
# CONFIG_PHY_BCM_NS_USB2 is not set
# CONFIG_PHY_NS2_USB_DRD is not set
# CONFIG_PHY_BRCM_SATA is not set
# CONFIG_PHY_BRCM_USB is not set
# CONFIG_PHY_BCM_SR_PCIE is not set
# end of PHY drivers for Broadcom platforms

# CONFIG_PHY_CADENCE_TORRENT is not set
# CONFIG_PHY_CADENCE_DPHY is not set
# CONFIG_PHY_CADENCE_DPHY_RX is not set
# CONFIG_PHY_CADENCE_SIERRA is not set
# CONFIG_PHY_CADENCE_SALVO is not set
# CONFIG_PHY_FSL_IMX8MQ_USB is not set
# CONFIG_PHY_MIXEL_LVDS_PHY is not set
# CONFIG_PHY_MIXEL_MIPI_DPHY is not set
# CONFIG_PHY_FSL_IMX8M_PCIE is not set
# CONFIG_PHY_FSL_LYNX_28G is not set
CONFIG_PHY_HI6220_USB=y
CONFIG_PHY_HI3660_USB=y
CONFIG_PHY_HI3670_USB=y
CONFIG_PHY_HI3670_PCIE=y
CONFIG_PHY_HISTB_COMBPHY=y
CONFIG_PHY_HISI_INNO_USB2=y
# CONFIG_PHY_LANTIQ_VRX200_PCIE is not set
# CONFIG_PHY_LANTIQ_RCU_USB2 is not set
# CONFIG_ARMADA375_USBCLUSTER_PHY is not set
# CONFIG_PHY_BERLIN_SATA is not set
# CONFIG_PHY_BERLIN_USB is not set
CONFIG_PHY_MVEBU_A3700_UTMI=y
# CONFIG_PHY_MVEBU_A38X_COMPHY is not set
CONFIG_PHY_PXA_28NM_HSIC=y
CONFIG_PHY_PXA_28NM_USB2=y
CONFIG_PHY_PXA_USB=y
# CONFIG_PHY_MMP3_USB is not set
CONFIG_PHY_MMP3_HSIC=y
# CONFIG_PHY_MTK_PCIE is not set
# CONFIG_PHY_MTK_TPHY is not set
# CONFIG_PHY_MTK_UFS is not set
# CONFIG_PHY_MTK_XSPHY is not set
# CONFIG_PHY_MTK_HDMI is not set
# CONFIG_PHY_MTK_MIPI_DSI is not set
# CONFIG_PHY_MTK_DP is not set
# CONFIG_PHY_SPARX5_SERDES is not set
# CONFIG_PHY_LAN966X_SERDES is not set
# CONFIG_PHY_OCELOT_SERDES is not set
# CONFIG_PHY_ATH79_USB is not set
# CONFIG_PHY_QCOM_EDP is not set
# CONFIG_PHY_QCOM_IPQ4019_USB is not set
# CONFIG_PHY_QCOM_PCIE2 is not set
# CONFIG_PHY_QCOM_QMP is not set
# CONFIG_PHY_QCOM_QUSB2 is not set
# CONFIG_PHY_QCOM_USB_SNPS_FEMTO_V2 is not set
# CONFIG_PHY_QCOM_USB_HS_28NM is not set
# CONFIG_PHY_QCOM_USB_SS is not set
# CONFIG_PHY_QCOM_IPQ806X_USB is not set
CONFIG_PHY_MT7621_PCI=y
CONFIG_PHY_RALINK_USB=y
# CONFIG_PHY_RCAR_GEN3_USB3 is not set
CONFIG_PHY_ROCKCHIP_DPHY_RX0=y
# CONFIG_PHY_ROCKCHIP_INNO_HDMI is not set
# CONFIG_PHY_ROCKCHIP_INNO_CSIDPHY is not set
# CONFIG_PHY_ROCKCHIP_INNO_DSIDPHY is not set
CONFIG_PHY_ROCKCHIP_PCIE=y
# CONFIG_PHY_ROCKCHIP_TYPEC is not set
# CONFIG_PHY_EXYNOS_DP_VIDEO is not set
CONFIG_PHY_EXYNOS_MIPI_VIDEO=y
# CONFIG_PHY_EXYNOS_PCIE is not set
# CONFIG_PHY_SAMSUNG_UFS is not set
# CONFIG_PHY_SAMSUNG_USB2 is not set
# CONFIG_PHY_UNIPHIER_USB2 is not set
# CONFIG_PHY_UNIPHIER_USB3 is not set
# CONFIG_PHY_UNIPHIER_PCIE is not set
# CONFIG_PHY_UNIPHIER_AHCI is not set
CONFIG_PHY_ST_SPEAR1310_MIPHY=y
# CONFIG_PHY_ST_SPEAR1340_MIPHY is not set
CONFIG_PHY_STIH407_USB=y
# CONFIG_PHY_STM32_USBPHYC is not set
CONFIG_PHY_TEGRA194_P2U=y
CONFIG_PHY_DA8XX_USB=y
# CONFIG_PHY_AM654_SERDES is not set
# CONFIG_PHY_J721E_WIZ is not set
CONFIG_OMAP_CONTROL_PHY=y
CONFIG_TI_PIPE3=y
CONFIG_PHY_INTEL_KEEMBAY_EMMC=y
# CONFIG_PHY_INTEL_KEEMBAY_USB is not set
# CONFIG_PHY_INTEL_LGM_COMBO is not set
# CONFIG_PHY_INTEL_LGM_EMMC is not set
# CONFIG_PHY_INTEL_THUNDERBAY_EMMC is not set
CONFIG_PHY_XILINX_ZYNQMP=y
# end of PHY Subsystem

# CONFIG_POWERCAP is not set
CONFIG_MCB=y
CONFIG_MCB_PCI=y
CONFIG_MCB_LPC=y

#
# Performance monitor support
#
# CONFIG_ARM_CCN is not set
CONFIG_ARM_CMN=y
# CONFIG_ARM_SMMU_V3_PMU is not set
CONFIG_FSL_IMX8_DDR_PMU=y
CONFIG_THUNDERX2_PMU=y
# CONFIG_XGENE_PMU is not set
# CONFIG_ARM_DMC620_PMU is not set
CONFIG_MARVELL_CN10K_TAD_PMU=y
# CONFIG_HNS3_PMU is not set
CONFIG_MARVELL_CN10K_DDR_PMU=y
# end of Performance monitor support

# CONFIG_RAS is not set
# CONFIG_USB4 is not set

#
# Android
#
# CONFIG_ANDROID_BINDER_IPC is not set
# end of Android

CONFIG_DAX=y
CONFIG_DEV_DAX=y
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y
# CONFIG_NVMEM_IMX_IIM is not set
CONFIG_NVMEM_IMX_OCOTP=y
# CONFIG_JZ4780_EFUSE is not set
# CONFIG_NVMEM_LPC18XX_EEPROM is not set
# CONFIG_NVMEM_LPC18XX_OTP is not set
CONFIG_NVMEM_MXS_OCOTP=y
# CONFIG_MTK_EFUSE is not set
# CONFIG_MICROCHIP_OTPC is not set
CONFIG_NVMEM_NINTENDO_OTP=y
# CONFIG_QCOM_QFPROM is not set
# CONFIG_NVMEM_SPMI_SDAM is not set
# CONFIG_ROCKCHIP_EFUSE is not set
# CONFIG_ROCKCHIP_OTP is not set
CONFIG_NVMEM_BCM_OCOTP=y
CONFIG_NVMEM_STM32_ROMEM=y
# CONFIG_UNIPHIER_EFUSE is not set
CONFIG_NVMEM_VF610_OCOTP=y
# CONFIG_MESON_MX_EFUSE is not set
# CONFIG_NVMEM_SNVS_LPGPR is not set
# CONFIG_SC27XX_EFUSE is not set
# CONFIG_SPRD_EFUSE is not set
CONFIG_NVMEM_RMEM=y
# CONFIG_NVMEM_BRCM_NVRAM is not set
CONFIG_NVMEM_LAYERSCAPE_SFP=y
CONFIG_NVMEM_SUNPLUS_OCOTP=y
CONFIG_NVMEM_APPLE_EFUSES=y

#
# HW tracing support
#
# CONFIG_STM is not set
CONFIG_INTEL_TH=y
CONFIG_INTEL_TH_PCI=y
CONFIG_INTEL_TH_ACPI=y
# CONFIG_INTEL_TH_GTH is not set
# CONFIG_INTEL_TH_MSU is not set
CONFIG_INTEL_TH_PTI=y
CONFIG_INTEL_TH_DEBUG=y
# end of HW tracing support

CONFIG_FPGA=y
CONFIG_FPGA_MGR_SOCFPGA=y
# CONFIG_FPGA_MGR_SOCFPGA_A10 is not set
CONFIG_ALTERA_PR_IP_CORE=y
# CONFIG_ALTERA_PR_IP_CORE_PLAT is not set
CONFIG_FPGA_MGR_ALTERA_PS_SPI=y
CONFIG_FPGA_MGR_ALTERA_CVP=y
CONFIG_FPGA_MGR_ZYNQ_FPGA=y
CONFIG_FPGA_MGR_XILINX_SPI=y
# CONFIG_FPGA_MGR_ICE40_SPI is not set
CONFIG_FPGA_MGR_MACHXO2_SPI=y
CONFIG_FPGA_BRIDGE=y
CONFIG_ALTERA_FREEZE_BRIDGE=y
# CONFIG_XILINX_PR_DECOUPLER is not set
CONFIG_FPGA_REGION=y
# CONFIG_OF_FPGA_REGION is not set
CONFIG_FPGA_DFL=y
CONFIG_FPGA_DFL_FME=y
# CONFIG_FPGA_DFL_FME_MGR is not set
CONFIG_FPGA_DFL_FME_BRIDGE=y
# CONFIG_FPGA_DFL_FME_REGION is not set
CONFIG_FPGA_DFL_AFU=y
# CONFIG_FPGA_DFL_NIOS_INTEL_PAC_N3000 is not set
CONFIG_FPGA_DFL_PCI=y
CONFIG_FPGA_MGR_ZYNQMP_FPGA=y
CONFIG_FPGA_MGR_VERSAL_FPGA=y
# CONFIG_FPGA_MGR_MICROCHIP_SPI is not set
# CONFIG_FSI is not set
# CONFIG_TEE is not set
CONFIG_MULTIPLEXER=y

#
# Multiplexer drivers
#
CONFIG_MUX_ADG792A=y
# CONFIG_MUX_ADGS1408 is not set
# CONFIG_MUX_GPIO is not set
# CONFIG_MUX_MMIO is not set
# end of Multiplexer drivers

CONFIG_PM_OPP=y
CONFIG_SIOX=y
CONFIG_SIOX_BUS_GPIO=y
CONFIG_SLIMBUS=y
CONFIG_SLIM_QCOM_CTRL=y
CONFIG_INTERCONNECT=y
# CONFIG_INTERCONNECT_IMX is not set
CONFIG_INTERCONNECT_QCOM_OSM_L3=y
CONFIG_INTERCONNECT_SAMSUNG=y
# CONFIG_INTERCONNECT_EXYNOS is not set
# CONFIG_COUNTER is not set
CONFIG_MOST=y
CONFIG_MOST_CDEV=y
CONFIG_MOST_SND=y
CONFIG_PECI=y
CONFIG_PECI_CPU=y
# CONFIG_PECI_ASPEED is not set
CONFIG_HTE=y
# end of Device Drivers

#
# File systems
#
# CONFIG_VALIDATE_FS_PARSER is not set
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
# CONFIG_EXPORTFS_BLOCK_OPS is not set
# CONFIG_FILE_LOCKING is not set
# CONFIG_FS_ENCRYPTION is not set
CONFIG_FS_VERITY=y
# CONFIG_FS_VERITY_DEBUG is not set
CONFIG_FS_VERITY_BUILTIN_SIGNATURES=y
CONFIG_FSNOTIFY=y
# CONFIG_DNOTIFY is not set
# CONFIG_INOTIFY_USER is not set
CONFIG_FANOTIFY=y
# CONFIG_QUOTA is not set
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
# CONFIG_FUSE_FS is not set
CONFIG_OVERLAY_FS=y
# CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW=y
# CONFIG_OVERLAY_FS_INDEX is not set
CONFIG_OVERLAY_FS_XINO_AUTO=y
# CONFIG_OVERLAY_FS_METACOPY is not set

#
# Caches
#
# CONFIG_FSCACHE is not set
# end of Caches

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_PROC_KCORE is not set
# CONFIG_PROC_SYSCTL is not set
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_ARCH_SUPPORTS_HUGETLBFS=y
# CONFIG_HUGETLBFS is not set
CONFIG_CONFIGFS_FS=y
# CONFIG_EFIVAR_FS is not set
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
CONFIG_ORANGEFS_FS=y
# CONFIG_ECRYPT_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_PSTORE is not set
# CONFIG_NETWORK_FILESYSTEMS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=y
CONFIG_NLS_CODEPAGE_775=y
# CONFIG_NLS_CODEPAGE_850 is not set
CONFIG_NLS_CODEPAGE_852=y
CONFIG_NLS_CODEPAGE_855=y
CONFIG_NLS_CODEPAGE_857=y
CONFIG_NLS_CODEPAGE_860=y
# CONFIG_NLS_CODEPAGE_861 is not set
CONFIG_NLS_CODEPAGE_862=y
CONFIG_NLS_CODEPAGE_863=y
# CONFIG_NLS_CODEPAGE_864 is not set
CONFIG_NLS_CODEPAGE_865=y
CONFIG_NLS_CODEPAGE_866=y
CONFIG_NLS_CODEPAGE_869=y
CONFIG_NLS_CODEPAGE_936=y
# CONFIG_NLS_CODEPAGE_950 is not set
CONFIG_NLS_CODEPAGE_932=y
CONFIG_NLS_CODEPAGE_949=y
# CONFIG_NLS_CODEPAGE_874 is not set
CONFIG_NLS_ISO8859_8=y
# CONFIG_NLS_CODEPAGE_1250 is not set
CONFIG_NLS_CODEPAGE_1251=y
# CONFIG_NLS_ASCII is not set
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_ISO8859_2=y
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
CONFIG_NLS_ISO8859_6=y
# CONFIG_NLS_ISO8859_7 is not set
CONFIG_NLS_ISO8859_9=y
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
CONFIG_NLS_ISO8859_15=y
CONFIG_NLS_KOI8_R=y
CONFIG_NLS_KOI8_U=y
CONFIG_NLS_MAC_ROMAN=y
# CONFIG_NLS_MAC_CELTIC is not set
CONFIG_NLS_MAC_CENTEURO=y
# CONFIG_NLS_MAC_CROATIAN is not set
# CONFIG_NLS_MAC_CYRILLIC is not set
CONFIG_NLS_MAC_GAELIC=y
CONFIG_NLS_MAC_GREEK=y
CONFIG_NLS_MAC_ICELAND=y
CONFIG_NLS_MAC_INUIT=y
CONFIG_NLS_MAC_ROMANIAN=y
CONFIG_NLS_MAC_TURKISH=y
# CONFIG_NLS_UTF8 is not set
# CONFIG_DLM is not set
CONFIG_UNICODE=y
# CONFIG_UNICODE_NORMALIZATION_SELFTEST is not set
CONFIG_IO_WQ=y
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_KEYS_REQUEST_CACHE is not set
CONFIG_PERSISTENT_KEYRINGS=y
CONFIG_TRUSTED_KEYS=y
# CONFIG_TRUSTED_KEYS_TPM is not set

#
# No trust source selected!
#
CONFIG_ENCRYPTED_KEYS=y
CONFIG_USER_DECRYPTED_DATA=y
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_KEY_NOTIFICATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
# CONFIG_SECURITY is not set
CONFIG_SECURITYFS=y
CONFIG_STATIC_USERMODEHELPER=y
CONFIG_STATIC_USERMODEHELPER_PATH="/sbin/usermode-helper"
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_LSM="landlock,lockdown,yama,loadpin,safesetid,integrity,bpf"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_CC_HAS_AUTO_VAR_INIT_PATTERN=y
CONFIG_CC_HAS_AUTO_VAR_INIT_ZERO=y
CONFIG_INIT_STACK_NONE=y
# CONFIG_INIT_STACK_ALL_PATTERN is not set
# CONFIG_INIT_STACK_ALL_ZERO is not set
CONFIG_INIT_ON_ALLOC_DEFAULT_ON=y
CONFIG_INIT_ON_FREE_DEFAULT_ON=y
CONFIG_CC_HAS_ZERO_CALL_USED_REGS=y
CONFIG_ZERO_CALL_USED_REGS=y
# end of Memory initialization

CONFIG_RANDSTRUCT_NONE=y
# end of Kernel hardening options
# end of Security options

CONFIG_XOR_BLOCKS=y
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
# CONFIG_CRYPTO_FIPS is not set
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_SKCIPHER=y
CONFIG_CRYPTO_SKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=y
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_USER=y
# CONFIG_CRYPTO_MANAGER_DISABLE_TESTS is not set
# CONFIG_CRYPTO_MANAGER_EXTRA_TESTS is not set
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
# CONFIG_CRYPTO_PCRYPT is not set
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=y
CONFIG_CRYPTO_TEST=y

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
# CONFIG_CRYPTO_DH is not set
CONFIG_CRYPTO_ECC=y
CONFIG_CRYPTO_ECDH=y
# CONFIG_CRYPTO_ECDSA is not set
# CONFIG_CRYPTO_ECRDSA is not set
CONFIG_CRYPTO_SM2=y
CONFIG_CRYPTO_CURVE25519=y

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=y
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_CHACHA20POLY1305=y
# CONFIG_CRYPTO_AEGIS128 is not set
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=y

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CFB=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=y
CONFIG_CRYPTO_OFB=y
CONFIG_CRYPTO_PCBC=y
CONFIG_CRYPTO_XCTR=y
CONFIG_CRYPTO_XTS=y
CONFIG_CRYPTO_KEYWRAP=y
CONFIG_CRYPTO_NHPOLY1305=y
CONFIG_CRYPTO_ADIANTUM=y
CONFIG_CRYPTO_HCTR2=y
CONFIG_CRYPTO_ESSIV=y

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=y
CONFIG_CRYPTO_HMAC=y
# CONFIG_CRYPTO_XCBC is not set
CONFIG_CRYPTO_VMAC=y

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32=y
# CONFIG_CRYPTO_XXHASH is not set
CONFIG_CRYPTO_BLAKE2B=y
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_POLYVAL=y
CONFIG_CRYPTO_POLY1305=y
# CONFIG_CRYPTO_MD4 is not set
CONFIG_CRYPTO_MD5=y
# CONFIG_CRYPTO_MICHAEL_MIC is not set
# CONFIG_CRYPTO_RMD160 is not set
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=y
CONFIG_CRYPTO_SM3=y
CONFIG_CRYPTO_SM3_GENERIC=y
CONFIG_CRYPTO_STREEBOG=y
CONFIG_CRYPTO_WP512=y

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_AES_TI=y
CONFIG_CRYPTO_ANUBIS=y
CONFIG_CRYPTO_ARC4=y
# CONFIG_CRYPTO_BLOWFISH is not set
CONFIG_CRYPTO_CAMELLIA=y
CONFIG_CRYPTO_CAST_COMMON=y
CONFIG_CRYPTO_CAST5=y
# CONFIG_CRYPTO_CAST6 is not set
CONFIG_CRYPTO_DES=y
CONFIG_CRYPTO_FCRYPT=y
CONFIG_CRYPTO_KHAZAD=y
CONFIG_CRYPTO_CHACHA20=y
CONFIG_CRYPTO_SEED=y
CONFIG_CRYPTO_ARIA=y
CONFIG_CRYPTO_SERPENT=y
CONFIG_CRYPTO_SM4=y
CONFIG_CRYPTO_SM4_GENERIC=y
# CONFIG_CRYPTO_TEA is not set
CONFIG_CRYPTO_TWOFISH=y
CONFIG_CRYPTO_TWOFISH_COMMON=y

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
# CONFIG_CRYPTO_842 is not set
CONFIG_CRYPTO_LZ4=y
# CONFIG_CRYPTO_LZ4HC is not set
# CONFIG_CRYPTO_ZSTD is not set

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=y
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
# CONFIG_CRYPTO_DRBG_HASH is not set
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_USER_API=y
CONFIG_CRYPTO_USER_API_HASH=y
CONFIG_CRYPTO_USER_API_SKCIPHER=y
CONFIG_CRYPTO_USER_API_RNG=y
# CONFIG_CRYPTO_USER_API_RNG_CAVP is not set
CONFIG_CRYPTO_USER_API_AEAD=y
CONFIG_CRYPTO_USER_API_ENABLE_OBSOLETE=y
# CONFIG_CRYPTO_STATS is not set
CONFIG_CRYPTO_HASH_INFO=y
# CONFIG_CRYPTO_HW is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
# CONFIG_PKCS8_PRIVATE_KEY_PARSER is not set
CONFIG_PKCS7_MESSAGE_PARSER=y
CONFIG_PKCS7_TEST_KEY=y
# CONFIG_SIGNED_PE_FILE_VERIFICATION is not set
# CONFIG_FIPS_SIGNATURE_SELFTEST is not set

#
# Certificates for signature checking
#
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
# CONFIG_SECONDARY_TRUSTED_KEYRING is not set
# CONFIG_SYSTEM_BLACKLIST_KEYRING is not set
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_LINEAR_RANGES=y
CONFIG_PACKING=y
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_CORDIC=y
CONFIG_PRIME_NUMBERS=y
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_STMP_DEVICE=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_ARC4=y
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=y
CONFIG_CRYPTO_LIB_CHACHA=y
CONFIG_CRYPTO_LIB_CURVE25519_GENERIC=y
CONFIG_CRYPTO_LIB_CURVE25519=y
CONFIG_CRYPTO_LIB_DES=y
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=1
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=y
CONFIG_CRYPTO_LIB_POLY1305=y
CONFIG_CRYPTO_LIB_CHACHA20POLY1305=y
CONFIG_CRYPTO_LIB_SHA1=y
CONFIG_CRYPTO_LIB_SHA256=y
# end of Crypto library routines

CONFIG_LIB_MEMNEQ=y
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
# CONFIG_CRC64_ROCKSOFT is not set
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
# CONFIG_CRC32_SLICEBY8 is not set
# CONFIG_CRC32_SLICEBY4 is not set
CONFIG_CRC32_SARWATE=y
# CONFIG_CRC32_BIT is not set
# CONFIG_CRC64 is not set
# CONFIG_CRC4 is not set
CONFIG_CRC7=y
CONFIG_LIBCRC32C=y
CONFIG_CRC8=y
CONFIG_AUDIT_GENERIC=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_COMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_XZ_DEC=y
# CONFIG_XZ_DEC_X86 is not set
CONFIG_XZ_DEC_POWERPC=y
# CONFIG_XZ_DEC_IA64 is not set
CONFIG_XZ_DEC_ARM=y
# CONFIG_XZ_DEC_ARMTHUMB is not set
# CONFIG_XZ_DEC_SPARC is not set
# CONFIG_XZ_DEC_MICROLZMA is not set
CONFIG_XZ_DEC_BCJ=y
CONFIG_XZ_DEC_TEST=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_DMA_DECLARE_COHERENT=y
CONFIG_SWIOTLB=y
# CONFIG_DMA_RESTRICTED_POOL is not set
CONFIG_DMA_CMA=y
# CONFIG_DMA_PERNUMA_CMA is not set

#
# Default contiguous memory area size:
#
CONFIG_CMA_SIZE_MBYTES=16
CONFIG_CMA_SIZE_SEL_MBYTES=y
# CONFIG_CMA_SIZE_SEL_PERCENTAGE is not set
# CONFIG_CMA_SIZE_SEL_MIN is not set
# CONFIG_CMA_SIZE_SEL_MAX is not set
CONFIG_CMA_ALIGNMENT=8
# CONFIG_DMA_API_DEBUG is not set
# CONFIG_DMA_MAP_BENCHMARK is not set
CONFIG_SGL_ALLOC=y
# CONFIG_CPUMASK_OFFSTACK is not set
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
CONFIG_GLOB_SELFTEST=y
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_DIMLIB=y
CONFIG_LIBFDT=y
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_ARCH_STACKWALK=y
CONFIG_STACKDEPOT=y
# CONFIG_PARMAN is not set
# CONFIG_OBJAGG is not set
# end of Library routines

CONFIG_GENERIC_LIB_ASHLDI3=y
CONFIG_GENERIC_LIB_ASHRDI3=y
CONFIG_GENERIC_LIB_LSHRDI3=y
CONFIG_GENERIC_LIB_CMPDI2=y
CONFIG_GENERIC_LIB_UCMPDI2=y
CONFIG_POLYNOMIAL=y

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
# CONFIG_PRINTK_CALLER is not set
# CONFIG_STACKTRACE_BUILD_ID is not set
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
CONFIG_BOOT_PRINTK_DELAY=y
# CONFIG_DYNAMIC_DEBUG is not set
CONFIG_DYNAMIC_DEBUG_CORE=y
CONFIG_SYMBOLIC_ERRNAME=y
# end of printk and dmesg options

CONFIG_DEBUG_KERNEL=y
# CONFIG_DEBUG_MISC is not set

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
# CONFIG_DEBUG_INFO_NONE is not set
CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_DEBUG_INFO_DWARF5 is not set
CONFIG_DEBUG_INFO_REDUCED=y
# CONFIG_DEBUG_INFO_COMPRESSED is not set
CONFIG_DEBUG_INFO_SPLIT=y
CONFIG_PAHOLE_HAS_SPLIT_BTF=y
# CONFIG_GDB_SCRIPTS is not set
CONFIG_FRAME_WARN=2048
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
CONFIG_HEADERS_INSTALL=y
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_VMLINUX_MAP=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# end of Compile-time checks and compiler options

#
# Generic Kernel Debugging Instruments
#
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
# CONFIG_MAGIC_SYSRQ_SERIAL is not set
CONFIG_DEBUG_FS=y
# CONFIG_DEBUG_FS_ALLOW_ALL is not set
CONFIG_DEBUG_FS_DISALLOW_MOUNT=y
# CONFIG_DEBUG_FS_ALLOW_NONE is not set
# CONFIG_UBSAN is not set
CONFIG_HAVE_KCSAN_COMPILER=y
# end of Generic Kernel Debugging Instruments

#
# Networking Debugging
#
# CONFIG_NET_DEV_REFCNT_TRACKER is not set
# CONFIG_NET_NS_REFCNT_TRACKER is not set
# CONFIG_DEBUG_NET is not set
# end of Networking Debugging

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
CONFIG_DEBUG_PAGEALLOC=y
# CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT is not set
CONFIG_PAGE_OWNER=y
CONFIG_PAGE_POISONING=y
# CONFIG_DEBUG_PAGE_REF is not set
# CONFIG_DEBUG_OBJECTS is not set
CONFIG_SHRINKER_DEBUG=y
CONFIG_DEBUG_STACK_USAGE=y
CONFIG_SCHED_STACK_END_CHECK=y
CONFIG_DEBUG_VM=y
# CONFIG_DEBUG_VM_VMACACHE is not set
# CONFIG_DEBUG_VM_RB is not set
CONFIG_DEBUG_VM_PGFLAGS=y
# CONFIG_DEBUG_MEMORY_INIT is not set
CONFIG_DEBUG_PER_CPU_MAPS=y
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
# end of Memory Debugging

CONFIG_DEBUG_SHIRQ=y

#
# Debug Oops, Lockups and Hangs
#
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
# CONFIG_SOFTLOCKUP_DETECTOR is not set
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=120
# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
# CONFIG_WQ_WATCHDOG is not set
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
# CONFIG_SCHED_DEBUG is not set
# CONFIG_SCHEDSTATS is not set
# end of Scheduler Debugging

CONFIG_DEBUG_TIMEKEEPING=y
CONFIG_DEBUG_PREEMPT=y

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
CONFIG_PROVE_LOCKING=y
# CONFIG_PROVE_RAW_LOCK_NESTING is not set
# CONFIG_LOCK_STAT is not set
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
CONFIG_DEBUG_RWSEMS=y
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_LOCKDEP=y
CONFIG_LOCKDEP_BITS=15
CONFIG_LOCKDEP_CHAINS_BITS=16
CONFIG_LOCKDEP_STACK_TRACE_BITS=19
CONFIG_LOCKDEP_STACK_TRACE_HASH_BITS=14
CONFIG_LOCKDEP_CIRCULAR_QUEUE_BITS=12
CONFIG_DEBUG_LOCKDEP=y
# CONFIG_DEBUG_ATOMIC_SLEEP is not set
CONFIG_DEBUG_LOCKING_API_SELFTESTS=y
# CONFIG_LOCK_TORTURE_TEST is not set
# CONFIG_WW_MUTEX_SELFTEST is not set
CONFIG_SCF_TORTURE_TEST=y
# CONFIG_CSD_LOCK_WAIT_DEBUG is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_TRACE_IRQFLAGS=y
CONFIG_DEBUG_IRQFLAGS=y
CONFIG_STACKTRACE=y
CONFIG_WARN_ALL_UNSEEDED_RANDOM=y
# CONFIG_DEBUG_KOBJECT is not set

#
# Debug kernel data structures
#
CONFIG_DEBUG_LIST=y
# CONFIG_DEBUG_PLIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
CONFIG_BUG_ON_DATA_CORRUPTION=y
# end of Debug kernel data structures

CONFIG_DEBUG_CREDENTIALS=y

#
# RCU Debugging
#
CONFIG_PROVE_RCU=y
CONFIG_PROVE_RCU_LIST=y
CONFIG_TORTURE_TEST=y
CONFIG_RCU_SCALE_TEST=y
CONFIG_RCU_TORTURE_TEST=y
CONFIG_RCU_REF_SCALE_TEST=y
CONFIG_RCU_CPU_STALL_TIMEOUT=21
CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=0
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

CONFIG_DEBUG_WQ_FORCE_RR_CPU=y
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_PREEMPTIRQ_TRACEPOINTS=y
CONFIG_TRACING=y
CONFIG_TRACING_SUPPORT=y
# CONFIG_FTRACE is not set
# CONFIG_SAMPLES is not set

#
# loongarch Debugging
#
CONFIG_UNWINDER_GUESS=y
# CONFIG_UNWINDER_PROLOGUE is not set
# end of loongarch Debugging

#
# Kernel Testing and Coverage
#
# CONFIG_KUNIT is not set
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
CONFIG_FAULT_INJECTION=y
# CONFIG_FAIL_PAGE_ALLOC is not set
# CONFIG_FAULT_INJECTION_USERCOPY is not set
CONFIG_FAULT_INJECTION_DEBUG_FS=y
CONFIG_FAIL_MMC_REQUEST=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_RUNTIME_TESTING_MENU is not set
# end of Kernel Testing and Coverage

CONFIG_WARN_MISSING_DOCUMENTS=y
# CONFIG_WARN_ABI_ERRORS is not set
# end of Kernel hacking

--6u0b2+JIS9/V0QBb--
