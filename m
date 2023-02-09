Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BED46912E7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 23:01:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbjBIWBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 17:01:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBIWBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 17:01:16 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9D1656A0
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 14:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675980072; x=1707516072;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=EH8Ns4Eo5biqParAggGUDNepm9WjFHaL1k/0CTNIePk=;
  b=LgioWdo3o5rZgRHuXvYamjrtwnw1N+j10rB3WBiEmeMk5tCSdkeITWSQ
   QcCeECO61WVhr7kdx0N1JKyUsN7Ik2zoIh1tuy8euyDolBITxFFUEyYv9
   eVDOo4E+fXT4YPqSIZ1u+oozyGEBeJsHk2PpIdbBn6lD2988Yzia8FR3o
   quaLqJvkD3MG17S5iFMIp+k3eVZDXRgT0FFMhzG2vrufz+PMtWm2UTl8c
   dAJ7bxrAFEuyzEYzsLtLnPKhRiQ4c1T8Q0XbDrST2WruHoF416FVTPxfk
   +YztR1KCrDQ7G7nYNMLWqRRUGX+L9aWP3chDp/v2JjpMi6zPJ5Q7mu78g
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="394857760"
X-IronPort-AV: E=Sophos;i="5.97,284,1669104000"; 
   d="scan'208";a="394857760"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 14:01:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="700237979"
X-IronPort-AV: E=Sophos;i="5.97,284,1669104000"; 
   d="scan'208";a="700237979"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 09 Feb 2023 14:01:10 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pQEyb-0005Ks-1C;
        Thu, 09 Feb 2023 22:01:09 +0000
Date:   Fri, 10 Feb 2023 06:00:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/perf/fsl_imx8_ddr_perf.c:397:17: sparse: sparse: incorrect
 type in argument 1 (different address spaces)
Message-ID: <202302100544.2ckxnoLz-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e544a07438522ab3688416e6e2e34bf0ee6d8755
commit: f3c0eba287049237b23d1300376768293eb89e69 perf: Add a few assertions
date:   5 months ago
config: loongarch-randconfig-s031-20230209 (https://download.01.org/0day-ci/archive/20230210/202302100544.2ckxnoLz-lkp@intel.com/config)
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
| Link: https://lore.kernel.org/oe-kbuild-all/202302100544.2ckxnoLz-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/perf/fsl_imx8_ddr_perf.c:397:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   drivers/perf/fsl_imx8_ddr_perf.c:397:17: sparse:     expected void *ptr
   drivers/perf/fsl_imx8_ddr_perf.c:397:17: sparse:     got unsigned int [noderef] __percpu *
>> drivers/perf/fsl_imx8_ddr_perf.c:397:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   drivers/perf/fsl_imx8_ddr_perf.c:397:17: sparse:     expected void *ptr
   drivers/perf/fsl_imx8_ddr_perf.c:397:17: sparse:     got unsigned int [noderef] __percpu *
>> drivers/perf/fsl_imx8_ddr_perf.c:397:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   drivers/perf/fsl_imx8_ddr_perf.c:397:17: sparse:     expected void *ptr
   drivers/perf/fsl_imx8_ddr_perf.c:397:17: sparse:     got unsigned int [noderef] __percpu *
>> drivers/perf/fsl_imx8_ddr_perf.c:397:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   drivers/perf/fsl_imx8_ddr_perf.c:397:17: sparse:     expected void *ptr
   drivers/perf/fsl_imx8_ddr_perf.c:397:17: sparse:     got unsigned int [noderef] __percpu *
>> drivers/perf/fsl_imx8_ddr_perf.c:397:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   drivers/perf/fsl_imx8_ddr_perf.c:397:17: sparse:     expected void *ptr
   drivers/perf/fsl_imx8_ddr_perf.c:397:17: sparse:     got int [noderef] __percpu *
>> drivers/perf/fsl_imx8_ddr_perf.c:397:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   drivers/perf/fsl_imx8_ddr_perf.c:397:17: sparse:     expected void *ptr
   drivers/perf/fsl_imx8_ddr_perf.c:397:17: sparse:     got int [noderef] __percpu *
>> drivers/perf/fsl_imx8_ddr_perf.c:397:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   drivers/perf/fsl_imx8_ddr_perf.c:397:17: sparse:     expected void *ptr
   drivers/perf/fsl_imx8_ddr_perf.c:397:17: sparse:     got int [noderef] __percpu *
>> drivers/perf/fsl_imx8_ddr_perf.c:397:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   drivers/perf/fsl_imx8_ddr_perf.c:397:17: sparse:     expected void *ptr
   drivers/perf/fsl_imx8_ddr_perf.c:397:17: sparse:     got int [noderef] __percpu *
   drivers/perf/fsl_imx8_ddr_perf.c:403:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   drivers/perf/fsl_imx8_ddr_perf.c:403:9: sparse:     expected void *ptr
   drivers/perf/fsl_imx8_ddr_perf.c:403:9: sparse:     got unsigned int [noderef] __percpu *
   drivers/perf/fsl_imx8_ddr_perf.c:403:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   drivers/perf/fsl_imx8_ddr_perf.c:403:9: sparse:     expected void *ptr
   drivers/perf/fsl_imx8_ddr_perf.c:403:9: sparse:     got unsigned int [noderef] __percpu *
   drivers/perf/fsl_imx8_ddr_perf.c:403:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   drivers/perf/fsl_imx8_ddr_perf.c:403:9: sparse:     expected void *ptr
   drivers/perf/fsl_imx8_ddr_perf.c:403:9: sparse:     got unsigned int [noderef] __percpu *
   drivers/perf/fsl_imx8_ddr_perf.c:403:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   drivers/perf/fsl_imx8_ddr_perf.c:403:9: sparse:     expected void *ptr
   drivers/perf/fsl_imx8_ddr_perf.c:403:9: sparse:     got unsigned int [noderef] __percpu *
   drivers/perf/fsl_imx8_ddr_perf.c:403:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   drivers/perf/fsl_imx8_ddr_perf.c:403:9: sparse:     expected void *ptr
   drivers/perf/fsl_imx8_ddr_perf.c:403:9: sparse:     got int [noderef] __percpu *
   drivers/perf/fsl_imx8_ddr_perf.c:403:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   drivers/perf/fsl_imx8_ddr_perf.c:403:9: sparse:     expected void *ptr
   drivers/perf/fsl_imx8_ddr_perf.c:403:9: sparse:     got int [noderef] __percpu *
   drivers/perf/fsl_imx8_ddr_perf.c:403:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   drivers/perf/fsl_imx8_ddr_perf.c:403:9: sparse:     expected void *ptr
   drivers/perf/fsl_imx8_ddr_perf.c:403:9: sparse:     got int [noderef] __percpu *
   drivers/perf/fsl_imx8_ddr_perf.c:403:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   drivers/perf/fsl_imx8_ddr_perf.c:403:9: sparse:     expected void *ptr
   drivers/perf/fsl_imx8_ddr_perf.c:403:9: sparse:     got int [noderef] __percpu *
   drivers/perf/fsl_imx8_ddr_perf.c: note: in included file (through arch/loongarch/include/asm/io.h, include/linux/io.h, include/linux/irq.h, ...):
   include/asm-generic/io.h:335:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:335:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:335:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:335:15: sparse: sparse: cast to restricted __le32
--
>> drivers/perf/arm_dmc620_pmu.c:524:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   drivers/perf/arm_dmc620_pmu.c:524:9: sparse:     expected void *ptr
   drivers/perf/arm_dmc620_pmu.c:524:9: sparse:     got unsigned int [noderef] __percpu *
>> drivers/perf/arm_dmc620_pmu.c:524:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   drivers/perf/arm_dmc620_pmu.c:524:9: sparse:     expected void *ptr
   drivers/perf/arm_dmc620_pmu.c:524:9: sparse:     got unsigned int [noderef] __percpu *
>> drivers/perf/arm_dmc620_pmu.c:524:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   drivers/perf/arm_dmc620_pmu.c:524:9: sparse:     expected void *ptr
   drivers/perf/arm_dmc620_pmu.c:524:9: sparse:     got unsigned int [noderef] __percpu *
>> drivers/perf/arm_dmc620_pmu.c:524:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   drivers/perf/arm_dmc620_pmu.c:524:9: sparse:     expected void *ptr
   drivers/perf/arm_dmc620_pmu.c:524:9: sparse:     got unsigned int [noderef] __percpu *
>> drivers/perf/arm_dmc620_pmu.c:524:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   drivers/perf/arm_dmc620_pmu.c:524:9: sparse:     expected void *ptr
   drivers/perf/arm_dmc620_pmu.c:524:9: sparse:     got int [noderef] __percpu *
>> drivers/perf/arm_dmc620_pmu.c:524:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   drivers/perf/arm_dmc620_pmu.c:524:9: sparse:     expected void *ptr
   drivers/perf/arm_dmc620_pmu.c:524:9: sparse:     got int [noderef] __percpu *
>> drivers/perf/arm_dmc620_pmu.c:524:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   drivers/perf/arm_dmc620_pmu.c:524:9: sparse:     expected void *ptr
   drivers/perf/arm_dmc620_pmu.c:524:9: sparse:     got int [noderef] __percpu *
>> drivers/perf/arm_dmc620_pmu.c:524:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   drivers/perf/arm_dmc620_pmu.c:524:9: sparse:     expected void *ptr
   drivers/perf/arm_dmc620_pmu.c:524:9: sparse:     got int [noderef] __percpu *
--
>> drivers/perf/arm_smmuv3_pmu.c:403:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   drivers/perf/arm_smmuv3_pmu.c:403:9: sparse:     expected void *ptr
   drivers/perf/arm_smmuv3_pmu.c:403:9: sparse:     got unsigned int [noderef] __percpu *
>> drivers/perf/arm_smmuv3_pmu.c:403:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   drivers/perf/arm_smmuv3_pmu.c:403:9: sparse:     expected void *ptr
   drivers/perf/arm_smmuv3_pmu.c:403:9: sparse:     got unsigned int [noderef] __percpu *
>> drivers/perf/arm_smmuv3_pmu.c:403:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   drivers/perf/arm_smmuv3_pmu.c:403:9: sparse:     expected void *ptr
   drivers/perf/arm_smmuv3_pmu.c:403:9: sparse:     got unsigned int [noderef] __percpu *
>> drivers/perf/arm_smmuv3_pmu.c:403:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   drivers/perf/arm_smmuv3_pmu.c:403:9: sparse:     expected void *ptr
   drivers/perf/arm_smmuv3_pmu.c:403:9: sparse:     got unsigned int [noderef] __percpu *
>> drivers/perf/arm_smmuv3_pmu.c:403:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   drivers/perf/arm_smmuv3_pmu.c:403:9: sparse:     expected void *ptr
   drivers/perf/arm_smmuv3_pmu.c:403:9: sparse:     got int [noderef] __percpu *
>> drivers/perf/arm_smmuv3_pmu.c:403:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   drivers/perf/arm_smmuv3_pmu.c:403:9: sparse:     expected void *ptr
   drivers/perf/arm_smmuv3_pmu.c:403:9: sparse:     got int [noderef] __percpu *
>> drivers/perf/arm_smmuv3_pmu.c:403:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   drivers/perf/arm_smmuv3_pmu.c:403:9: sparse:     expected void *ptr
   drivers/perf/arm_smmuv3_pmu.c:403:9: sparse:     got int [noderef] __percpu *
>> drivers/perf/arm_smmuv3_pmu.c:403:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   drivers/perf/arm_smmuv3_pmu.c:403:9: sparse:     expected void *ptr
   drivers/perf/arm_smmuv3_pmu.c:403:9: sparse:     got int [noderef] __percpu *
   drivers/perf/arm_smmuv3_pmu.c: note: in included file (through arch/loongarch/include/asm/io.h, arch/loongarch/include/asm/pgtable.h, arch/loongarch/include/asm/uaccess.h, ...):
   include/asm-generic/io.h:239:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:239:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:290:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long long [usertype] value @@     got restricted __le64 [usertype] @@
   include/asm-generic/io.h:290:22: sparse:     expected unsigned long long [usertype] value
   include/asm-generic/io.h:290:22: sparse:     got restricted __le64 [usertype]
   include/asm-generic/io.h:290:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long long [usertype] value @@     got restricted __le64 [usertype] @@
   include/asm-generic/io.h:290:22: sparse:     expected unsigned long long [usertype] value
   include/asm-generic/io.h:290:22: sparse:     got restricted __le64 [usertype]
   include/asm-generic/io.h:290:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long long [usertype] value @@     got restricted __le64 [usertype] @@
   include/asm-generic/io.h:290:22: sparse:     expected unsigned long long [usertype] value
   include/asm-generic/io.h:290:22: sparse:     got restricted __le64 [usertype]
   include/asm-generic/io.h:290:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long long [usertype] value @@     got restricted __le64 [usertype] @@
   include/asm-generic/io.h:290:22: sparse:     expected unsigned long long [usertype] value
   include/asm-generic/io.h:290:22: sparse:     got restricted __le64 [usertype]
   include/asm-generic/io.h:290:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long long [usertype] value @@     got restricted __le64 [usertype] @@
   include/asm-generic/io.h:290:22: sparse:     expected unsigned long long [usertype] value
   include/asm-generic/io.h:290:22: sparse:     got restricted __le64 [usertype]
   include/asm-generic/io.h:239:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:290:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long long [usertype] value @@     got restricted __le64 [usertype] @@
   include/asm-generic/io.h:290:22: sparse:     expected unsigned long long [usertype] value
   include/asm-generic/io.h:290:22: sparse:     got restricted __le64 [usertype]
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
   include/asm-generic/io.h:389:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long long [usertype] value @@     got restricted __le64 [usertype] @@
   include/asm-generic/io.h:389:22: sparse:     expected unsigned long long [usertype] value
   include/asm-generic/io.h:389:22: sparse:     got restricted __le64 [usertype]
   include/asm-generic/io.h:389:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long long [usertype] value @@     got restricted __le64 [usertype] @@
   include/asm-generic/io.h:389:22: sparse:     expected unsigned long long [usertype] value
   include/asm-generic/io.h:389:22: sparse:     got restricted __le64 [usertype]
   include/asm-generic/io.h:389:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long long [usertype] value @@     got restricted __le64 [usertype] @@
   include/asm-generic/io.h:389:22: sparse:     expected unsigned long long [usertype] value
   include/asm-generic/io.h:389:22: sparse:     got restricted __le64 [usertype]
   include/asm-generic/io.h:335:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:335:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:348:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:348:15: sparse: sparse: cast to restricted __le64
--
>> drivers/perf/arm-ccn.c:835:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   drivers/perf/arm-ccn.c:835:9: sparse:     expected void *ptr
   drivers/perf/arm-ccn.c:835:9: sparse:     got unsigned int [noderef] __percpu *
>> drivers/perf/arm-ccn.c:835:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   drivers/perf/arm-ccn.c:835:9: sparse:     expected void *ptr
   drivers/perf/arm-ccn.c:835:9: sparse:     got unsigned int [noderef] __percpu *
>> drivers/perf/arm-ccn.c:835:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   drivers/perf/arm-ccn.c:835:9: sparse:     expected void *ptr
   drivers/perf/arm-ccn.c:835:9: sparse:     got unsigned int [noderef] __percpu *
>> drivers/perf/arm-ccn.c:835:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   drivers/perf/arm-ccn.c:835:9: sparse:     expected void *ptr
   drivers/perf/arm-ccn.c:835:9: sparse:     got unsigned int [noderef] __percpu *
>> drivers/perf/arm-ccn.c:835:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   drivers/perf/arm-ccn.c:835:9: sparse:     expected void *ptr
   drivers/perf/arm-ccn.c:835:9: sparse:     got int [noderef] __percpu *
>> drivers/perf/arm-ccn.c:835:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   drivers/perf/arm-ccn.c:835:9: sparse:     expected void *ptr
   drivers/perf/arm-ccn.c:835:9: sparse:     got int [noderef] __percpu *
>> drivers/perf/arm-ccn.c:835:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   drivers/perf/arm-ccn.c:835:9: sparse:     expected void *ptr
   drivers/perf/arm-ccn.c:835:9: sparse:     got int [noderef] __percpu *
>> drivers/perf/arm-ccn.c:835:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   drivers/perf/arm-ccn.c:835:9: sparse:     expected void *ptr
   drivers/perf/arm-ccn.c:835:9: sparse:     got int [noderef] __percpu *
   drivers/perf/arm-ccn.c: note: in included file (through arch/loongarch/include/asm/io.h, include/linux/io.h, include/linux/irq.h, ...):
   include/asm-generic/io.h:239:15: sparse: sparse: cast to restricted __le64
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

vim +397 drivers/perf/fsl_imx8_ddr_perf.c

c12c0288e35a46 Joakim Zhang 2019-08-28  367  
9a66d36cc7ace8 Frank Li     2019-05-01  368  static int ddr_perf_event_init(struct perf_event *event)
9a66d36cc7ace8 Frank Li     2019-05-01  369  {
9a66d36cc7ace8 Frank Li     2019-05-01  370  	struct ddr_pmu *pmu = to_ddr_pmu(event->pmu);
9a66d36cc7ace8 Frank Li     2019-05-01  371  	struct hw_perf_event *hwc = &event->hw;
9a66d36cc7ace8 Frank Li     2019-05-01  372  	struct perf_event *sibling;
9a66d36cc7ace8 Frank Li     2019-05-01  373  
9a66d36cc7ace8 Frank Li     2019-05-01  374  	if (event->attr.type != event->pmu->type)
9a66d36cc7ace8 Frank Li     2019-05-01  375  		return -ENOENT;
9a66d36cc7ace8 Frank Li     2019-05-01  376  
9a66d36cc7ace8 Frank Li     2019-05-01  377  	if (is_sampling_event(event) || event->attach_state & PERF_ATTACH_TASK)
9a66d36cc7ace8 Frank Li     2019-05-01  378  		return -EOPNOTSUPP;
9a66d36cc7ace8 Frank Li     2019-05-01  379  
9a66d36cc7ace8 Frank Li     2019-05-01  380  	if (event->cpu < 0) {
9a66d36cc7ace8 Frank Li     2019-05-01  381  		dev_warn(pmu->dev, "Can't provide per-task data!\n");
9a66d36cc7ace8 Frank Li     2019-05-01  382  		return -EOPNOTSUPP;
9a66d36cc7ace8 Frank Li     2019-05-01  383  	}
9a66d36cc7ace8 Frank Li     2019-05-01  384  
9a66d36cc7ace8 Frank Li     2019-05-01  385  	/*
9a66d36cc7ace8 Frank Li     2019-05-01  386  	 * We must NOT create groups containing mixed PMUs, although software
9a66d36cc7ace8 Frank Li     2019-05-01  387  	 * events are acceptable (for example to create a CCN group
9a66d36cc7ace8 Frank Li     2019-05-01  388  	 * periodically read when a hrtimer aka cpu-clock leader triggers).
9a66d36cc7ace8 Frank Li     2019-05-01  389  	 */
9a66d36cc7ace8 Frank Li     2019-05-01  390  	if (event->group_leader->pmu != event->pmu &&
9a66d36cc7ace8 Frank Li     2019-05-01  391  			!is_software_event(event->group_leader))
9a66d36cc7ace8 Frank Li     2019-05-01  392  		return -EINVAL;
9a66d36cc7ace8 Frank Li     2019-05-01  393  
c12c0288e35a46 Joakim Zhang 2019-08-28  394  	if (pmu->devtype_data->quirks & DDR_CAP_AXI_ID_FILTER) {
c12c0288e35a46 Joakim Zhang 2019-08-28  395  		if (!ddr_perf_filters_compatible(event, event->group_leader))
c12c0288e35a46 Joakim Zhang 2019-08-28  396  			return -EINVAL;
c12c0288e35a46 Joakim Zhang 2019-08-28 @397  		for_each_sibling_event(sibling, event->group_leader) {
c12c0288e35a46 Joakim Zhang 2019-08-28  398  			if (!ddr_perf_filters_compatible(event, sibling))
c12c0288e35a46 Joakim Zhang 2019-08-28  399  				return -EINVAL;
c12c0288e35a46 Joakim Zhang 2019-08-28  400  		}
c12c0288e35a46 Joakim Zhang 2019-08-28  401  	}
c12c0288e35a46 Joakim Zhang 2019-08-28  402  
9a66d36cc7ace8 Frank Li     2019-05-01  403  	for_each_sibling_event(sibling, event->group_leader) {
9a66d36cc7ace8 Frank Li     2019-05-01  404  		if (sibling->pmu != event->pmu &&
9a66d36cc7ace8 Frank Li     2019-05-01  405  				!is_software_event(sibling))
9a66d36cc7ace8 Frank Li     2019-05-01  406  			return -EINVAL;
9a66d36cc7ace8 Frank Li     2019-05-01  407  	}
9a66d36cc7ace8 Frank Li     2019-05-01  408  
9a66d36cc7ace8 Frank Li     2019-05-01  409  	event->cpu = pmu->cpu;
9a66d36cc7ace8 Frank Li     2019-05-01  410  	hwc->idx = -1;
9a66d36cc7ace8 Frank Li     2019-05-01  411  
9a66d36cc7ace8 Frank Li     2019-05-01  412  	return 0;
9a66d36cc7ace8 Frank Li     2019-05-01  413  }
9a66d36cc7ace8 Frank Li     2019-05-01  414  

:::::: The code at line 397 was first introduced by commit
:::::: c12c0288e35a4693b1606e229dab54a62f1ad568 perf/imx_ddr: Add support for AXI ID filtering

:::::: TO: Joakim Zhang <qiangqing.zhang@nxp.com>
:::::: CC: Will Deacon <will@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
