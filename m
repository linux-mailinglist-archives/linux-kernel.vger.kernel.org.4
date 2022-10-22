Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC8B60906F
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 01:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbiJVX2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 19:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiJVX2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 19:28:16 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDBD06E88C
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 16:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666481291; x=1698017291;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=SI9XCdzTmifX6P6up6F9v3RbSGl9tbTOtrrj8uix4bI=;
  b=FHvCXAyovi2eRtch6GMXx9XS7+FnqwuJT+HnbUXjUgpr73LiVwrx/NRp
   Vpfp0IVmUMDJXNuxNw2ujIwhd/RGslCAKQVhFwAqmujo625MPaC67PTJ9
   /mRKAI4sHClAYC0+nR+ynnVOCxpMPd2BqGmQL8OZFwG+O4J+Pkz516OtC
   FwoXSt/ELkEkTXzYSYRvBfd/KluxTYknAAQ0aA8m5PxB8rwZe/AKBTV+l
   DCnZwjt1OHGk2Y8OgBS+cudmPDjsVv51PUgTIPVELyBSMptd/nZ/pdfLQ
   W3TpRnscdvR3h+KUE3HGiUsNsoBlNVEsozpyn+trmaB08UIy2PeblXsH3
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10508"; a="308312769"
X-IronPort-AV: E=Sophos;i="5.95,206,1661842800"; 
   d="scan'208";a="308312769"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2022 16:27:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10508"; a="699744181"
X-IronPort-AV: E=Sophos;i="5.95,206,1661842800"; 
   d="scan'208";a="699744181"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 22 Oct 2022 16:27:56 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1omNuF-0003yD-2y;
        Sat, 22 Oct 2022 23:27:55 +0000
Date:   Sun, 23 Oct 2022 07:27:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/perf/fsl_imx8_ddr_perf.c:397:17: sparse: sparse: incorrect
 type in argument 1 (different address spaces)
Message-ID: <202210230710.iF2r8c9X-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="W/q7qJiNgbBno5WO"
Content-Disposition: inline
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        UPPERCASE_50_75 autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--W/q7qJiNgbBno5WO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4da34b7d175dc99b8befebd69e96546c960d526c
commit: f3c0eba287049237b23d1300376768293eb89e69 perf: Add a few assertions
date:   6 weeks ago
config: loongarch-randconfig-s053-20221023
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
https://01.org/lkp

--W/q7qJiNgbBno5WO
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
# CONFIG_WATCH_QUEUE is not set
# CONFIG_CROSS_MEMORY_ATTACH is not set
# CONFIG_USELIB is not set
CONFIG_HAVE_ARCH_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_GENERIC_IRQ_CHIP=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_IRQ_FASTEOI_HIERARCHY_HANDLERS=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
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
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ_FULL=y
CONFIG_CONTEXT_TRACKING_USER=y
CONFIG_CONTEXT_TRACKING_USER_FORCE=y
# CONFIG_NO_HZ is not set
CONFIG_HIGH_RES_TIMERS=y
# end of Timers subsystem

#
# BPF subsystem
#
# CONFIG_BPF_SYSCALL is not set
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
CONFIG_VIRT_CPU_ACCOUNTING=y
CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_SCHED_AVG_IRQ=y
# CONFIG_BSD_PROCESS_ACCT is not set
# CONFIG_PSI is not set
# end of CPU/Task time and stats accounting

CONFIG_CPU_ISOLATION=y

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
CONFIG_PREEMPT_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_TASKS_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_NOCB_CPU=y
CONFIG_RCU_NOCB_CPU_DEFAULT_ALL=y
# end of RCU Subsystem

CONFIG_IKCONFIG=y
# CONFIG_IKCONFIG_PROC is not set
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
# CONFIG_CGROUPS is not set
CONFIG_NAMESPACES=y
# CONFIG_UTS_NS is not set
CONFIG_USER_NS=y
# CONFIG_PID_NS is not set
CONFIG_CHECKPOINT_RESTORE=y
# CONFIG_SCHED_AUTOGROUP is not set
CONFIG_SYSFS_DEPRECATED=y
# CONFIG_SYSFS_DEPRECATED_V2 is not set
# CONFIG_RELAY is not set
# CONFIG_BLK_DEV_INITRD is not set
CONFIG_BOOT_CONFIG=y
CONFIG_BOOT_CONFIG_EMBED=y
CONFIG_BOOT_CONFIG_EMBED_FILE=""
# CONFIG_INITRAMFS_PRESERVE_MTIME is not set
# CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE is not set
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
CONFIG_SYSCTL=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
# CONFIG_EXPERT is not set
CONFIG_MULTIUSER=y
CONFIG_SYSFS_SYSCALL=y
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_IO_URING=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_KCMP=y
CONFIG_RSEQ=y
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_PERF_USE_VMALLOC=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
CONFIG_DEBUG_PERF_USE_VMALLOC=y
# end of Kernel Performance Events And Counters

# CONFIG_PROFILING is not set
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
CONFIG_PAGE_SIZE_4KB=y
CONFIG_PGTABLE_3LEVEL=y
CONFIG_PGTABLE_LEVELS=3
CONFIG_SCHED_OMIT_FRAME_POINTER=y

#
# Kernel type and options
#
CONFIG_HZ_100=y
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=100
CONFIG_SCHED_HRTICK=y
CONFIG_4KB_3LEVEL=y
# CONFIG_4KB_4LEVEL is not set
# CONFIG_16KB_2LEVEL is not set
# CONFIG_16KB_3LEVEL is not set
# CONFIG_64KB_2LEVEL is not set
# CONFIG_64KB_3LEVEL is not set
CONFIG_CMDLINE=""
# CONFIG_CMDLINE_BOOTLOADER is not set
# CONFIG_CMDLINE_EXTEND is not set
CONFIG_CMDLINE_FORCE=y
# CONFIG_DMI is not set
CONFIG_EFI=y
CONFIG_SMP=y
CONFIG_HOTPLUG_CPU=y
CONFIG_NR_CPUS=64
# CONFIG_NUMA is not set
CONFIG_FORCE_MAX_ZONEORDER=11
CONFIG_SECCOMP=y
# end of Kernel type and options

CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ARCH_FLATMEM_ENABLE=y
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
CONFIG_ACPI_DEBUGGER=y
CONFIG_ACPI_DEBUGGER_USER=y
# CONFIG_ACPI_SPCR_TABLE is not set
CONFIG_ACPI_EC_DEBUGFS=y
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=y
# CONFIG_ACPI_FAN is not set
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_MCFG=y
# CONFIG_ACPI_PROCESSOR is not set
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_DEBUG=y
CONFIG_ACPI_PCI_SLOT=y
CONFIG_ACPI_CONTAINER=y
# CONFIG_ACPI_HED is not set
CONFIG_ACPI_CUSTOM_METHOD=y
CONFIG_ACPI_CONFIGFS=y
# CONFIG_ACPI_PFRUT is not set
# CONFIG_ACPI_PCC is not set
# CONFIG_PMIC_OPREGION is not set
# end of Power management options

#
# Firmware Drivers
#

#
# ARM System Control and Management Interface Protocol
#
# CONFIG_ARM_SCMI_PROTOCOL is not set
CONFIG_ARM_SCMI_POWER_DOMAIN=y
CONFIG_ARM_SCMI_POWER_CONTROL=y
# end of ARM System Control and Management Interface Protocol

CONFIG_ARM_SCPI_PROTOCOL=y
CONFIG_ARM_SCPI_POWER_DOMAIN=y
# CONFIG_ISCSI_IBFT is not set
# CONFIG_MTK_ADSP_IPC is not set
CONFIG_QCOM_SCM=y
CONFIG_QCOM_SCM_DOWNLOAD_MODE_DEFAULT=y
CONFIG_SYSFB=y
CONFIG_SYSFB_SIMPLEFB=y
CONFIG_TURRIS_MOX_RWTM=y
# CONFIG_BCM47XX_NVRAM is not set
CONFIG_CS_DSP=y
CONFIG_GOOGLE_FIRMWARE=y
CONFIG_GOOGLE_COREBOOT_TABLE=y
CONFIG_GOOGLE_MEMCONSOLE=y
CONFIG_GOOGLE_FRAMEBUFFER_COREBOOT=y
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
CONFIG_EFI_TEST=y
CONFIG_EFI_RCI2_TABLE=y
# CONFIG_EFI_DISABLE_PCI_DMA is not set
CONFIG_EFI_EARLYCON=y
# CONFIG_EFI_CUSTOM_SSDT_OVERLAYS is not set
CONFIG_EFI_DISABLE_RUNTIME=y
# CONFIG_EFI_COCO_SECRET is not set
# end of EFI (Extensible Firmware Interface) Support

CONFIG_IMX_DSP=y
# CONFIG_IMX_SCU is not set

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
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
CONFIG_ISA_BUS_API=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_ARCH_HAS_PHYS_TO_DMA=y
CONFIG_ARCH_USE_MEMREMAP_PROT=y
# CONFIG_LOCK_EVENT_COUNTS is not set

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
# end of GCOV-based kernel profiling
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
# CONFIG_MODULES is not set
CONFIG_BLOCK=y
CONFIG_BLOCK_LEGACY_AUTOLOAD=y
CONFIG_BLK_DEV_BSG_COMMON=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_INTEGRITY_T10=y
# CONFIG_BLK_DEV_ZONED is not set
# CONFIG_BLK_WBT is not set
CONFIG_BLK_DEBUG_FS=y
CONFIG_BLK_SED_OPAL=y
# CONFIG_BLK_INLINE_ENCRYPTION is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
CONFIG_AIX_PARTITION=y
# CONFIG_OSF_PARTITION is not set
# CONFIG_AMIGA_PARTITION is not set
# CONFIG_ATARI_PARTITION is not set
CONFIG_MAC_PARTITION=y
# CONFIG_MSDOS_PARTITION is not set
# CONFIG_LDM_PARTITION is not set
# CONFIG_SGI_PARTITION is not set
CONFIG_ULTRIX_PARTITION=y
CONFIG_SUN_PARTITION=y
CONFIG_KARMA_PARTITION=y
CONFIG_EFI_PARTITION=y
# CONFIG_SYSV68_PARTITION is not set
CONFIG_CMDLINE_PARTITION=y
# end of Partition Types

CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
# CONFIG_MQ_IOSCHED_KYBER is not set
# CONFIG_IOSCHED_BFQ is not set
# end of IO Schedulers

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
# CONFIG_BINFMT_ELF is not set
CONFIG_ARCH_BINFMT_ELF_STATE=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=y
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
CONFIG_ZPOOL=y
CONFIG_SWAP=y
CONFIG_ZSWAP=y
CONFIG_ZSWAP_DEFAULT_ON=y
CONFIG_ZSWAP_COMPRESSOR_DEFAULT_DEFLATE=y
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZO is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_842 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4HC is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_ZSTD is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT="deflate"
# CONFIG_ZSWAP_ZPOOL_DEFAULT_ZBUD is not set
# CONFIG_ZSWAP_ZPOOL_DEFAULT_Z3FOLD is not set
CONFIG_ZSWAP_ZPOOL_DEFAULT_ZSMALLOC=y
CONFIG_ZSWAP_ZPOOL_DEFAULT="zsmalloc"
# CONFIG_ZBUD is not set
CONFIG_Z3FOLD=y
CONFIG_ZSMALLOC=y
# CONFIG_ZSMALLOC_STAT is not set

#
# SLAB allocator options
#
# CONFIG_SLAB is not set
CONFIG_SLUB=y
CONFIG_SLAB_MERGE_DEFAULT=y
# CONFIG_SLAB_FREELIST_RANDOM is not set
# CONFIG_SLAB_FREELIST_HARDENED is not set
CONFIG_SLUB_STATS=y
CONFIG_SLUB_CPU_PARTIAL=y
# end of SLAB allocator options

CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
CONFIG_COMPAT_BRK=y
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_FLATMEM_MANUAL=y
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_FLATMEM=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_MEMORY_BALLOON=y
# CONFIG_BALLOON_COMPACTION is not set
CONFIG_COMPACTION=y
CONFIG_PAGE_REPORTING=y
CONFIG_MIGRATION=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
# CONFIG_READ_ONLY_THP_FOR_FS is not set
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y
CONFIG_FRONTSWAP=y
# CONFIG_CMA is not set
# CONFIG_IDLE_PAGE_TRACKING is not set
CONFIG_ZONE_DMA32=y
CONFIG_VM_EVENT_COUNTERS=y
CONFIG_PERCPU_STATS=y
# CONFIG_GUP_TEST is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
# CONFIG_ANON_VMA_NAME is not set
# CONFIG_USERFAULTFD is not set

#
# Data Access Monitoring
#
# CONFIG_DAMON is not set
# end of Data Access Monitoring
# end of Memory Management options

# CONFIG_NET is not set

#
# Device Drivers
#
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCI_DOMAINS_GENERIC=y
CONFIG_PCIEPORTBUS=y
# CONFIG_HOTPLUG_PCI_PCIE is not set
# CONFIG_PCIEAER is not set
CONFIG_PCIEASPM=y
# CONFIG_PCIEASPM_DEFAULT is not set
# CONFIG_PCIEASPM_POWERSAVE is not set
CONFIG_PCIEASPM_POWER_SUPERSAVE=y
# CONFIG_PCIEASPM_PERFORMANCE is not set
# CONFIG_PCIE_PTM is not set
CONFIG_PCI_MSI=y
CONFIG_PCI_MSI_IRQ_DOMAIN=y
CONFIG_PCI_MSI_ARCH_FALLBACKS=y
CONFIG_PCI_QUIRKS=y
CONFIG_PCI_DEBUG=y
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
CONFIG_PCI_STUB=y
CONFIG_PCI_PF_STUB=y
CONFIG_PCI_ATS=y
CONFIG_PCI_DOE=y
CONFIG_PCI_ECAM=y
CONFIG_PCI_BRIDGE_EMUL=y
CONFIG_PCI_IOV=y
CONFIG_PCI_PRI=y
CONFIG_PCI_PASID=y
CONFIG_PCI_LABEL=y
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
CONFIG_HOTPLUG_PCI=y
CONFIG_HOTPLUG_PCI_ACPI=y
# CONFIG_HOTPLUG_PCI_ACPI_IBM is not set
# CONFIG_HOTPLUG_PCI_CPCI is not set
CONFIG_HOTPLUG_PCI_SHPC=y

#
# PCI controller drivers
#
CONFIG_PCI_AARDVARK=y
# CONFIG_PCIE_XILINX_NWL is not set
# CONFIG_PCI_FTPCI100 is not set
CONFIG_PCI_TEGRA=y
CONFIG_PCIE_RCAR_HOST=y
CONFIG_PCIE_RCAR_EP=y
CONFIG_PCI_HOST_COMMON=y
CONFIG_PCI_HOST_GENERIC=y
CONFIG_PCIE_XILINX=y
# CONFIG_PCIE_XILINX_CPM is not set
CONFIG_PCI_XGENE=y
# CONFIG_PCI_XGENE_MSI is not set
CONFIG_PCI_V3_SEMI=y
CONFIG_PCI_VERSATILE=y
CONFIG_PCIE_ALTERA=y
# CONFIG_PCIE_ALTERA_MSI is not set
CONFIG_PCI_HOST_THUNDER_PEM=y
CONFIG_PCI_HOST_THUNDER_ECAM=y
CONFIG_PCIE_ROCKCHIP=y
CONFIG_PCIE_ROCKCHIP_HOST=y
# CONFIG_PCIE_ROCKCHIP_EP is not set
# CONFIG_PCIE_MEDIATEK is not set
CONFIG_PCIE_MEDIATEK_GEN3=y
CONFIG_PCIE_BRCMSTB=y
CONFIG_PCI_LOONGSON=y
# CONFIG_PCIE_MICROCHIP_HOST is not set
CONFIG_PCIE_APPLE_MSI_DOORBELL_ADDR=0xfffff000
CONFIG_PCIE_APPLE=y
CONFIG_PCIE_MT7621=y

#
# DesignWare PCI Core Support
#
CONFIG_PCIE_DW=y
CONFIG_PCIE_DW_HOST=y
CONFIG_PCIE_DW_EP=y
CONFIG_PCI_DRA7XX=y
# CONFIG_PCI_DRA7XX_HOST is not set
CONFIG_PCI_DRA7XX_EP=y
# CONFIG_PCIE_DW_PLAT_HOST is not set
# CONFIG_PCIE_DW_PLAT_EP is not set
CONFIG_PCI_EXYNOS=y
CONFIG_PCI_IMX6=y
CONFIG_PCIE_SPEAR13XX=y
CONFIG_PCI_KEYSTONE=y
CONFIG_PCI_KEYSTONE_HOST=y
# CONFIG_PCI_KEYSTONE_EP is not set
CONFIG_PCI_LAYERSCAPE=y
# CONFIG_PCI_LAYERSCAPE_EP is not set
# CONFIG_PCI_HISI is not set
CONFIG_PCIE_QCOM=y
# CONFIG_PCIE_QCOM_EP is not set
# CONFIG_PCIE_ARMADA_8K is not set
CONFIG_PCIE_ARTPEC6=y
# CONFIG_PCIE_ARTPEC6_HOST is not set
CONFIG_PCIE_ARTPEC6_EP=y
CONFIG_PCIE_ROCKCHIP_DW_HOST=y
# CONFIG_PCIE_INTEL_GW is not set
# CONFIG_PCIE_KEEMBAY_HOST is not set
# CONFIG_PCIE_KEEMBAY_EP is not set
CONFIG_PCIE_KIRIN=y
# CONFIG_PCIE_HISI_STB is not set
CONFIG_PCI_MESON=y
CONFIG_PCIE_TEGRA194=y
CONFIG_PCIE_TEGRA194_HOST=y
CONFIG_PCIE_TEGRA194_EP=y
# CONFIG_PCIE_VISCONTI_HOST is not set
CONFIG_PCIE_UNIPHIER=y
CONFIG_PCIE_UNIPHIER_EP=y
# CONFIG_PCIE_AL is not set
# CONFIG_PCIE_FU740 is not set
# end of DesignWare PCI Core Support

#
# Mobiveil PCIe Core Support
#
CONFIG_PCIE_MOBIVEIL=y
CONFIG_PCIE_MOBIVEIL_HOST=y
CONFIG_PCIE_MOBIVEIL_PLAT=y
CONFIG_PCIE_LAYERSCAPE_GEN4=y
# end of Mobiveil PCIe Core Support

#
# Cadence PCIe controllers support
#
CONFIG_PCIE_CADENCE=y
CONFIG_PCIE_CADENCE_HOST=y
CONFIG_PCIE_CADENCE_PLAT=y
CONFIG_PCIE_CADENCE_PLAT_HOST=y
# CONFIG_PCIE_CADENCE_PLAT_EP is not set
# CONFIG_PCI_J721E_HOST is not set
# CONFIG_PCI_J721E_EP is not set
# end of Cadence PCIe controllers support
# end of PCI controller drivers

#
# PCI Endpoint
#
CONFIG_PCI_ENDPOINT=y
# CONFIG_PCI_ENDPOINT_CONFIGFS is not set
CONFIG_PCI_EPF_TEST=y
CONFIG_PCI_EPF_NTB=y
# end of PCI Endpoint

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
# end of PCI switch controller drivers

CONFIG_CXL_BUS=y
CONFIG_CXL_PCI=y
CONFIG_CXL_MEM_RAW_COMMANDS=y
# CONFIG_CXL_ACPI is not set
CONFIG_CXL_MEM=y
CONFIG_CXL_PORT=y
CONFIG_PCCARD=y
CONFIG_PCMCIA=y
CONFIG_PCMCIA_LOAD_CIS=y
CONFIG_CARDBUS=y

#
# PC-card bridges
#
# CONFIG_YENTA is not set
CONFIG_PD6729=y
CONFIG_I82092=y
CONFIG_PCCARD_NONSTATIC=y
# CONFIG_RAPIDIO is not set

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
CONFIG_FW_LOADER_SYSFS=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
# CONFIG_FW_LOADER_COMPRESS is not set
CONFIG_FW_UPLOAD=y
# end of Firmware loader

CONFIG_WANT_DEV_COREDUMP=y
CONFIG_ALLOW_DEV_COREDUMP=y
CONFIG_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
CONFIG_DEBUG_DEVRES=y
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_SOC_BUS=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SLIMBUS=y
CONFIG_REGMAP_SPMI=y
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_REGMAP_SOUNDWIRE=y
CONFIG_REGMAP_SOUNDWIRE_MBQ=y
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# end of Generic Driver Options

#
# Bus devices
#
CONFIG_ARM_INTEGRATOR_LM=y
# CONFIG_BT1_APB is not set
CONFIG_BT1_AXI=y
CONFIG_HISILICON_LPC=y
CONFIG_INTEL_IXP4XX_EB=y
CONFIG_QCOM_EBI2=y
# CONFIG_MHI_BUS is not set
CONFIG_MHI_BUS_EP=y
# end of Bus devices

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

CONFIG_GNSS=y
CONFIG_MTD=y

#
# Partition parsers
#
# CONFIG_MTD_AR7_PARTS is not set
CONFIG_MTD_BCM63XX_PARTS=y
CONFIG_MTD_CMDLINE_PARTS=y
CONFIG_MTD_OF_PARTS=y
CONFIG_MTD_OF_PARTS_BCM4908=y
# CONFIG_MTD_OF_PARTS_LINKSYS_NS is not set
CONFIG_MTD_PARSER_IMAGETAG=y
CONFIG_MTD_PARSER_TRX=y
# CONFIG_MTD_SHARPSL_PARTS is not set
CONFIG_MTD_REDBOOT_PARTS=y
CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=-1
# CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED is not set
CONFIG_MTD_REDBOOT_PARTS_READONLY=y
# end of Partition parsers

#
# User Modules And Translation Layers
#
CONFIG_MTD_BLKDEVS=y
# CONFIG_MTD_BLOCK is not set
# CONFIG_MTD_BLOCK_RO is not set
CONFIG_FTL=y
CONFIG_NFTL=y
# CONFIG_NFTL_RW is not set
CONFIG_INFTL=y
# CONFIG_RFD_FTL is not set
CONFIG_SSFDC=y
# CONFIG_SM_FTL is not set
CONFIG_MTD_OOPS=y
CONFIG_MTD_SWAP=y
# CONFIG_MTD_PARTITIONED_MASTER is not set

#
# RAM/ROM/Flash chip drivers
#
CONFIG_MTD_CFI=y
CONFIG_MTD_JEDECPROBE=y
CONFIG_MTD_GEN_PROBE=y
CONFIG_MTD_CFI_ADV_OPTIONS=y
CONFIG_MTD_CFI_NOSWAP=y
# CONFIG_MTD_CFI_BE_BYTE_SWAP is not set
# CONFIG_MTD_CFI_LE_BYTE_SWAP is not set
CONFIG_MTD_CFI_GEOMETRY=y
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
# CONFIG_MTD_CFI_I1 is not set
CONFIG_MTD_CFI_I2=y
# CONFIG_MTD_CFI_I4 is not set
# CONFIG_MTD_CFI_I8 is not set
# CONFIG_MTD_OTP is not set
# CONFIG_MTD_CFI_INTELEXT is not set
CONFIG_MTD_CFI_AMDSTD=y
# CONFIG_MTD_CFI_STAA is not set
CONFIG_MTD_CFI_UTIL=y
CONFIG_MTD_RAM=y
CONFIG_MTD_ROM=y
CONFIG_MTD_ABSENT=y
# end of RAM/ROM/Flash chip drivers

#
# Mapping drivers for chip access
#
CONFIG_MTD_COMPLEX_MAPPINGS=y
CONFIG_MTD_PHYSMAP=y
# CONFIG_MTD_PHYSMAP_COMPAT is not set
# CONFIG_MTD_PHYSMAP_OF is not set
CONFIG_MTD_PHYSMAP_GPIO_ADDR=y
# CONFIG_MTD_SC520CDP is not set
CONFIG_MTD_NETSC520=y
CONFIG_MTD_TS5500=y
# CONFIG_MTD_PCI is not set
# CONFIG_MTD_PCMCIA is not set
CONFIG_MTD_INTEL_VR_NOR=y
CONFIG_MTD_PLATRAM=y
# end of Mapping drivers for chip access

#
# Self-contained MTD device drivers
#
CONFIG_MTD_PMC551=y
CONFIG_MTD_PMC551_BUGFIX=y
# CONFIG_MTD_PMC551_DEBUG is not set
CONFIG_MTD_SPEAR_SMI=y
# CONFIG_MTD_SLRAM is not set
# CONFIG_MTD_PHRAM is not set
CONFIG_MTD_MTDRAM=y
CONFIG_MTDRAM_TOTAL_SIZE=4096
CONFIG_MTDRAM_ERASE_SIZE=128
CONFIG_MTD_BLOCK2MTD=y

#
# Disk-On-Chip Device Drivers
#
CONFIG_MTD_DOCG3=y
CONFIG_BCH_CONST_M=14
CONFIG_BCH_CONST_T=4
# end of Self-contained MTD device drivers

#
# NAND
#
CONFIG_MTD_NAND_CORE=y
# CONFIG_MTD_ONENAND is not set
CONFIG_MTD_RAW_NAND=y

#
# Raw/parallel NAND flash controllers
#
CONFIG_MTD_NAND_DENALI=y
CONFIG_MTD_NAND_DENALI_PCI=y
CONFIG_MTD_NAND_DENALI_DT=y
# CONFIG_MTD_NAND_AMS_DELTA is not set
CONFIG_MTD_NAND_SHARPSL=y
CONFIG_MTD_NAND_CAFE=y
# CONFIG_MTD_NAND_ATMEL is not set
CONFIG_MTD_NAND_MARVELL=y
# CONFIG_MTD_NAND_SLC_LPC32XX is not set
CONFIG_MTD_NAND_MLC_LPC32XX=y
CONFIG_MTD_NAND_BRCMNAND=y
# CONFIG_MTD_NAND_BRCMNAND_BCMA is not set
CONFIG_MTD_NAND_BCM47XXNFLASH=y
CONFIG_MTD_NAND_OXNAS=y
# CONFIG_MTD_NAND_GPMI_NAND is not set
# CONFIG_MTD_NAND_FSL_IFC is not set
# CONFIG_MTD_NAND_VF610_NFC is not set
# CONFIG_MTD_NAND_MXC is not set
CONFIG_MTD_NAND_SH_FLCTL=y
CONFIG_MTD_NAND_DAVINCI=y
CONFIG_MTD_NAND_TXX9NDFMC=y
CONFIG_MTD_NAND_FSMC=y
CONFIG_MTD_NAND_SUNXI=y
# CONFIG_MTD_NAND_HISI504 is not set
CONFIG_MTD_NAND_QCOM=y
# CONFIG_MTD_NAND_MTK is not set
# CONFIG_MTD_NAND_MXIC is not set
CONFIG_MTD_NAND_TEGRA=y
# CONFIG_MTD_NAND_STM32_FMC2 is not set
# CONFIG_MTD_NAND_MESON is not set
CONFIG_MTD_NAND_GPIO=y
# CONFIG_MTD_NAND_PLATFORM is not set
CONFIG_MTD_NAND_CADENCE=y
CONFIG_MTD_NAND_ARASAN=y
# CONFIG_MTD_NAND_INTEL_LGM is not set
# CONFIG_MTD_NAND_RENESAS is not set

#
# Misc
#
CONFIG_MTD_SM_COMMON=y
CONFIG_MTD_NAND_NANDSIM=y
CONFIG_MTD_NAND_RICOH=y
CONFIG_MTD_NAND_DISKONCHIP=y
# CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADVANCED is not set
CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADDRESS=0
CONFIG_MTD_NAND_DISKONCHIP_BBTWRITE=y

#
# ECC engine support
#
CONFIG_MTD_NAND_ECC=y
# CONFIG_MTD_NAND_ECC_SW_HAMMING is not set
CONFIG_MTD_NAND_ECC_SW_BCH=y
CONFIG_MTD_NAND_ECC_MXIC=y
CONFIG_MTD_NAND_ECC_MEDIATEK=y
# end of ECC engine support
# end of NAND

#
# LPDDR & LPDDR2 PCM memory drivers
#
CONFIG_MTD_LPDDR=y
CONFIG_MTD_QINFO_PROBE=y
# end of LPDDR & LPDDR2 PCM memory drivers

# CONFIG_MTD_UBI is not set
CONFIG_MTD_HYPERBUS=y
CONFIG_HBMC_AM654=y
CONFIG_DTC=y
CONFIG_OF=y
CONFIG_OF_UNITTEST=y
# CONFIG_OF_ALL_DTBS is not set
CONFIG_OF_FLATTREE=y
CONFIG_OF_EARLY_FLATTREE=y
CONFIG_OF_KOBJ=y
CONFIG_OF_DYNAMIC=y
CONFIG_OF_ADDRESS=y
CONFIG_OF_IRQ=y
CONFIG_OF_RESERVED_MEM=y
CONFIG_OF_RESOLVE=y
# CONFIG_OF_OVERLAY is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
# CONFIG_PARPORT is not set
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
# CONFIG_ISAPNP is not set
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_NULL_BLK=y
# CONFIG_BLK_DEV_NULL_BLK_FAULT_INJECTION is not set
CONFIG_CDROM=y
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
CONFIG_ZRAM=y
CONFIG_ZRAM_DEF_COMP_LZORLE=y
# CONFIG_ZRAM_DEF_COMP_ZSTD is not set
# CONFIG_ZRAM_DEF_COMP_LZ4 is not set
# CONFIG_ZRAM_DEF_COMP_LZO is not set
# CONFIG_ZRAM_DEF_COMP_LZ4HC is not set
# CONFIG_ZRAM_DEF_COMP_842 is not set
CONFIG_ZRAM_DEF_COMP="lzo-rle"
# CONFIG_ZRAM_WRITEBACK is not set
CONFIG_ZRAM_MEMORY_TRACKING=y
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_LOOP_MIN_COUNT=8

#
# DRBD disabled because PROC_FS or INET not selected
#
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=4096
# CONFIG_CDROM_PKTCDVD is not set
# CONFIG_VIRTIO_BLK is not set
CONFIG_BLK_DEV_UBLK=y

#
# NVME Support
#
CONFIG_NVME_CORE=y
# CONFIG_BLK_DEV_NVME is not set
CONFIG_NVME_MULTIPATH=y
CONFIG_NVME_VERBOSE_ERRORS=y
CONFIG_NVME_HWMON=y
CONFIG_NVME_FABRICS=y
CONFIG_NVME_FC=y
# CONFIG_NVME_AUTH is not set
# CONFIG_NVME_TARGET is not set
# end of NVME Support

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=y
CONFIG_AD525X_DPOT=y
CONFIG_AD525X_DPOT_I2C=y
# CONFIG_DUMMY_IRQ is not set
CONFIG_PHANTOM=y
CONFIG_TIFM_CORE=y
# CONFIG_TIFM_7XX1 is not set
CONFIG_ICS932S401=y
CONFIG_ATMEL_SSC=y
CONFIG_ENCLOSURE_SERVICES=y
CONFIG_HI6421V600_IRQ=y
CONFIG_HP_ILO=y
CONFIG_QCOM_COINCELL=y
CONFIG_QCOM_FASTRPC=y
CONFIG_APDS9802ALS=y
CONFIG_ISL29003=y
CONFIG_ISL29020=y
CONFIG_SENSORS_TSL2550=y
# CONFIG_SENSORS_BH1770 is not set
CONFIG_SENSORS_APDS990X=y
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
CONFIG_PCH_PHUB=y
CONFIG_SRAM=y
CONFIG_DW_XDATA_PCIE=y
CONFIG_PCI_ENDPOINT_TEST=y
# CONFIG_XILINX_SDFEC is not set
CONFIG_MISC_RTSX=y
CONFIG_OPEN_DICE=y
# CONFIG_VCPU_STALL_DETECTOR is not set
# CONFIG_C2PORT is not set

#
# EEPROM support
#
CONFIG_EEPROM_AT24=y
# CONFIG_EEPROM_LEGACY is not set
# CONFIG_EEPROM_MAX6875 is not set
CONFIG_EEPROM_93CX6=y
CONFIG_EEPROM_IDT_89HPESX=y
CONFIG_EEPROM_EE1004=y
# end of EEPROM support

# CONFIG_CB710_CORE is not set

#
# Texas Instruments shared transport line discipline
#
# end of Texas Instruments shared transport line discipline

CONFIG_SENSORS_LIS3_I2C=y
CONFIG_ALTERA_STAPL=y
CONFIG_GENWQE=y
CONFIG_GENWQE_PLATFORM_ERROR_RECOVERY=0
CONFIG_ECHO=y
CONFIG_BCM_VK=y
# CONFIG_BCM_VK_TTY is not set
CONFIG_MISC_ALCOR_PCI=y
CONFIG_MISC_RTSX_PCI=y
CONFIG_HABANA_AI=y
CONFIG_UACCE=y
# CONFIG_PVPANIC is not set
# end of Misc devices

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=y
CONFIG_SCSI_COMMON=y
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
CONFIG_CHR_DEV_ST=y
CONFIG_BLK_DEV_SR=y
CONFIG_CHR_DEV_SG=y
CONFIG_BLK_DEV_BSG=y
# CONFIG_CHR_DEV_SCH is not set
CONFIG_SCSI_ENCLOSURE=y
CONFIG_SCSI_CONSTANTS=y
# CONFIG_SCSI_LOGGING is not set
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=y
CONFIG_SCSI_SAS_ATTRS=y
CONFIG_SCSI_SAS_LIBSAS=y
# CONFIG_SCSI_SAS_ATA is not set
CONFIG_SCSI_SAS_HOST_SMP=y
CONFIG_SCSI_SRP_ATTRS=y
# end of SCSI Transports

CONFIG_SCSI_LOWLEVEL=y
# CONFIG_ISCSI_BOOT_SYSFS is not set
CONFIG_BLK_DEV_3W_XXXX_RAID=y
CONFIG_SCSI_HPSA=y
CONFIG_SCSI_3W_9XXX=y
CONFIG_SCSI_3W_SAS=y
# CONFIG_SCSI_ACARD is not set
CONFIG_SCSI_AACRAID=y
CONFIG_SCSI_AIC7XXX=y
CONFIG_AIC7XXX_CMDS_PER_DEVICE=32
CONFIG_AIC7XXX_RESET_DELAY_MS=5000
# CONFIG_AIC7XXX_BUILD_FIRMWARE is not set
# CONFIG_AIC7XXX_DEBUG_ENABLE is not set
CONFIG_AIC7XXX_DEBUG_MASK=0
# CONFIG_AIC7XXX_REG_PRETTY_PRINT is not set
CONFIG_SCSI_AIC79XX=y
CONFIG_AIC79XX_CMDS_PER_DEVICE=32
CONFIG_AIC79XX_RESET_DELAY_MS=5000
# CONFIG_AIC79XX_BUILD_FIRMWARE is not set
# CONFIG_AIC79XX_DEBUG_ENABLE is not set
CONFIG_AIC79XX_DEBUG_MASK=0
# CONFIG_AIC79XX_REG_PRETTY_PRINT is not set
# CONFIG_SCSI_AIC94XX is not set
CONFIG_SCSI_HISI_SAS=y
CONFIG_SCSI_HISI_SAS_PCI=y
# CONFIG_SCSI_HISI_SAS_DEBUGFS_DEFAULT_ENABLE is not set
CONFIG_SCSI_MVSAS=y
# CONFIG_SCSI_MVSAS_DEBUG is not set
# CONFIG_SCSI_MVSAS_TASKLET is not set
# CONFIG_SCSI_MVUMI is not set
CONFIG_SCSI_ADVANSYS=y
CONFIG_SCSI_ARCMSR=y
# CONFIG_SCSI_ESAS2R is not set
# CONFIG_MEGARAID_NEWGEN is not set
CONFIG_MEGARAID_LEGACY=y
CONFIG_MEGARAID_SAS=y
# CONFIG_SCSI_MPT3SAS is not set
# CONFIG_SCSI_MPT2SAS is not set
CONFIG_SCSI_MPI3MR=y
CONFIG_SCSI_SMARTPQI=y
CONFIG_SCSI_HPTIOP=y
CONFIG_SCSI_BUSLOGIC=y
CONFIG_SCSI_FLASHPOINT=y
CONFIG_SCSI_MYRB=y
CONFIG_SCSI_MYRS=y
CONFIG_SCSI_SNIC=y
CONFIG_SCSI_SNIC_DEBUG_FS=y
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_FDOMAIN_PCI is not set
# CONFIG_SCSI_IPS is not set
CONFIG_SCSI_INITIO=y
# CONFIG_SCSI_INIA100 is not set
CONFIG_SCSI_STEX=y
# CONFIG_SCSI_SYM53C8XX_2 is not set
CONFIG_SCSI_IPR=y
# CONFIG_SCSI_IPR_TRACE is not set
# CONFIG_SCSI_IPR_DUMP is not set
CONFIG_SCSI_QLOGIC_1280=y
CONFIG_SCSI_DC395x=y
CONFIG_SCSI_AM53C974=y
# CONFIG_SCSI_WD719X is not set
# CONFIG_SCSI_DEBUG is not set
CONFIG_SCSI_PM8001=y
# CONFIG_SCSI_VIRTIO is not set
# CONFIG_SCSI_LOWLEVEL_PCMCIA is not set
CONFIG_SCSI_DH=y
CONFIG_SCSI_DH_RDAC=y
CONFIG_SCSI_DH_HP_SW=y
CONFIG_SCSI_DH_EMC=y
CONFIG_SCSI_DH_ALUA=y
# end of SCSI device support

CONFIG_ATA=y
CONFIG_SATA_HOST=y
CONFIG_PATA_TIMINGS=y
# CONFIG_ATA_VERBOSE_ERROR is not set
CONFIG_ATA_FORCE=y
CONFIG_ATA_ACPI=y
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI=y
CONFIG_SATA_MOBILE_LPM_POLICY=0
CONFIG_SATA_AHCI_PLATFORM=y
# CONFIG_AHCI_BRCM is not set
CONFIG_AHCI_DA850=y
CONFIG_AHCI_DM816=y
# CONFIG_AHCI_IMX is not set
CONFIG_AHCI_CEVA=y
# CONFIG_AHCI_MTK is not set
CONFIG_AHCI_MVEBU=y
CONFIG_AHCI_SUNXI=y
CONFIG_AHCI_TEGRA=y
CONFIG_AHCI_XGENE=y
CONFIG_AHCI_QORIQ=y
CONFIG_SATA_FSL=y
CONFIG_SATA_GEMINI=y
CONFIG_SATA_AHCI_SEATTLE=y
CONFIG_SATA_INIC162X=y
# CONFIG_SATA_ACARD_AHCI is not set
CONFIG_SATA_SIL24=y
CONFIG_ATA_SFF=y

#
# SFF controllers with custom DMA interface
#
CONFIG_PDC_ADMA=y
CONFIG_SATA_QSTOR=y
CONFIG_SATA_SX4=y
CONFIG_ATA_BMDMA=y

#
# SATA SFF controllers with BMDMA
#
# CONFIG_ATA_PIIX is not set
CONFIG_SATA_DWC=y
CONFIG_SATA_DWC_OLD_DMA=y
CONFIG_SATA_HIGHBANK=y
# CONFIG_SATA_MV is not set
CONFIG_SATA_NV=y
# CONFIG_SATA_PROMISE is not set
CONFIG_SATA_RCAR=y
CONFIG_SATA_SIL=y
# CONFIG_SATA_SIS is not set
# CONFIG_SATA_SVW is not set
# CONFIG_SATA_ULI is not set
CONFIG_SATA_VIA=y
# CONFIG_SATA_VITESSE is not set

#
# PATA SFF controllers with BMDMA
#
# CONFIG_PATA_ALI is not set
# CONFIG_PATA_AMD is not set
CONFIG_PATA_ARASAN_CF=y
CONFIG_PATA_ARTOP=y
# CONFIG_PATA_ATIIXP is not set
# CONFIG_PATA_ATP867X is not set
# CONFIG_PATA_BK3710 is not set
CONFIG_PATA_CMD64X=y
CONFIG_PATA_CS5520=y
CONFIG_PATA_CS5530=y
CONFIG_PATA_CS5536=y
# CONFIG_PATA_CYPRESS is not set
# CONFIG_PATA_EFAR is not set
CONFIG_PATA_FTIDE010=y
CONFIG_PATA_HPT366=y
CONFIG_PATA_HPT37X=y
CONFIG_PATA_HPT3X2N=y
# CONFIG_PATA_HPT3X3 is not set
CONFIG_PATA_IMX=y
# CONFIG_PATA_IT8213 is not set
# CONFIG_PATA_IT821X is not set
# CONFIG_PATA_JMICRON is not set
CONFIG_PATA_MARVELL=y
# CONFIG_PATA_NETCELL is not set
# CONFIG_PATA_NINJA32 is not set
# CONFIG_PATA_NS87415 is not set
CONFIG_PATA_OLDPIIX=y
CONFIG_PATA_OPTIDMA=y
# CONFIG_PATA_PDC2027X is not set
CONFIG_PATA_PDC_OLD=y
# CONFIG_PATA_RADISYS is not set
CONFIG_PATA_RDC=y
# CONFIG_PATA_SC1200 is not set
CONFIG_PATA_SCH=y
# CONFIG_PATA_SERVERWORKS is not set
# CONFIG_PATA_SIL680 is not set
# CONFIG_PATA_SIS is not set
CONFIG_PATA_TOSHIBA=y
CONFIG_PATA_TRIFLEX=y
CONFIG_PATA_VIA=y
CONFIG_PATA_PXA=y
CONFIG_PATA_WINBOND=y

#
# PIO-only SFF controllers
#
CONFIG_PATA_CMD640_PCI=y
CONFIG_PATA_IXP4XX_CF=y
# CONFIG_PATA_MPIIX is not set
CONFIG_PATA_NS87410=y
CONFIG_PATA_OPTI=y
CONFIG_PATA_PCMCIA=y
# CONFIG_PATA_RZ1000 is not set
CONFIG_PATA_SAMSUNG_CF=y

#
# Generic fallback / legacy drivers
#
# CONFIG_PATA_ACPI is not set
CONFIG_ATA_GENERIC=y
CONFIG_PATA_LEGACY=y
# CONFIG_MD is not set
CONFIG_TARGET_CORE=y
CONFIG_TCM_IBLOCK=y
CONFIG_TCM_FILEIO=y
CONFIG_TCM_PSCSI=y
CONFIG_LOOPBACK_TARGET=y
# CONFIG_SBP_TARGET is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=y
CONFIG_FIREWIRE_OHCI=y
CONFIG_FIREWIRE_SBP2=y
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

#
# Input device support
#
CONFIG_INPUT=y
# CONFIG_INPUT_LEDS is not set
CONFIG_INPUT_FF_MEMLESS=y
CONFIG_INPUT_SPARSEKMAP=y
# CONFIG_INPUT_MATRIXKMAP is not set
CONFIG_INPUT_VIVALDIFMAP=y

#
# Userland interfaces
#
# CONFIG_INPUT_MOUSEDEV is not set
# CONFIG_INPUT_JOYDEV is not set
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
# CONFIG_INPUT_KEYBOARD is not set
# CONFIG_INPUT_MOUSE is not set
CONFIG_INPUT_JOYSTICK=y
CONFIG_JOYSTICK_ANALOG=y
CONFIG_JOYSTICK_A3D=y
CONFIG_JOYSTICK_ADI=y
CONFIG_JOYSTICK_COBRA=y
CONFIG_JOYSTICK_GF2K=y
CONFIG_JOYSTICK_GRIP=y
# CONFIG_JOYSTICK_GRIP_MP is not set
CONFIG_JOYSTICK_GUILLEMOT=y
# CONFIG_JOYSTICK_INTERACT is not set
CONFIG_JOYSTICK_SIDEWINDER=y
CONFIG_JOYSTICK_TMDC=y
# CONFIG_JOYSTICK_IFORCE is not set
CONFIG_JOYSTICK_WARRIOR=y
CONFIG_JOYSTICK_MAGELLAN=y
CONFIG_JOYSTICK_SPACEORB=y
# CONFIG_JOYSTICK_SPACEBALL is not set
CONFIG_JOYSTICK_STINGER=y
# CONFIG_JOYSTICK_TWIDJOY is not set
CONFIG_JOYSTICK_ZHENHUA=y
CONFIG_JOYSTICK_AS5011=y
CONFIG_JOYSTICK_JOYDUMP=y
CONFIG_JOYSTICK_QWIIC=y
CONFIG_JOYSTICK_FSIA6B=y
# CONFIG_JOYSTICK_SENSEHAT is not set
# CONFIG_INPUT_TABLET is not set
CONFIG_INPUT_TOUCHSCREEN=y
# CONFIG_TOUCHSCREEN_88PM860X is not set
CONFIG_TOUCHSCREEN_AD7879=y
# CONFIG_TOUCHSCREEN_AD7879_I2C is not set
CONFIG_TOUCHSCREEN_AR1021_I2C=y
# CONFIG_TOUCHSCREEN_ATMEL_MXT is not set
CONFIG_TOUCHSCREEN_AUO_PIXCIR=y
CONFIG_TOUCHSCREEN_BU21013=y
CONFIG_TOUCHSCREEN_BU21029=y
CONFIG_TOUCHSCREEN_CHIPONE_ICN8318=y
CONFIG_TOUCHSCREEN_CHIPONE_ICN8505=y
CONFIG_TOUCHSCREEN_CY8CTMA140=y
CONFIG_TOUCHSCREEN_CY8CTMG110=y
CONFIG_TOUCHSCREEN_CYTTSP_CORE=y
CONFIG_TOUCHSCREEN_CYTTSP_I2C=y
CONFIG_TOUCHSCREEN_CYTTSP4_CORE=y
# CONFIG_TOUCHSCREEN_CYTTSP4_I2C is not set
CONFIG_TOUCHSCREEN_DYNAPRO=y
CONFIG_TOUCHSCREEN_HAMPSHIRE=y
CONFIG_TOUCHSCREEN_EETI=y
CONFIG_TOUCHSCREEN_EGALAX=y
CONFIG_TOUCHSCREEN_EGALAX_SERIAL=y
# CONFIG_TOUCHSCREEN_EXC3000 is not set
CONFIG_TOUCHSCREEN_FUJITSU=y
# CONFIG_TOUCHSCREEN_GOODIX is not set
CONFIG_TOUCHSCREEN_HIDEEP=y
# CONFIG_TOUCHSCREEN_HYCON_HY46XX is not set
# CONFIG_TOUCHSCREEN_ILI210X is not set
CONFIG_TOUCHSCREEN_ILITEK=y
# CONFIG_TOUCHSCREEN_IPROC is not set
CONFIG_TOUCHSCREEN_S6SY761=y
CONFIG_TOUCHSCREEN_GUNZE=y
CONFIG_TOUCHSCREEN_EKTF2127=y
CONFIG_TOUCHSCREEN_ELAN=y
CONFIG_TOUCHSCREEN_ELO=y
CONFIG_TOUCHSCREEN_WACOM_W8001=y
CONFIG_TOUCHSCREEN_WACOM_I2C=y
CONFIG_TOUCHSCREEN_MAX11801=y
# CONFIG_TOUCHSCREEN_MCS5000 is not set
# CONFIG_TOUCHSCREEN_MMS114 is not set
CONFIG_TOUCHSCREEN_MELFAS_MIP4=y
CONFIG_TOUCHSCREEN_MSG2638=y
CONFIG_TOUCHSCREEN_MTOUCH=y
CONFIG_TOUCHSCREEN_IMAGIS=y
CONFIG_TOUCHSCREEN_IMX6UL_TSC=y
CONFIG_TOUCHSCREEN_INEXIO=y
CONFIG_TOUCHSCREEN_MK712=y
CONFIG_TOUCHSCREEN_PENMOUNT=y
CONFIG_TOUCHSCREEN_EDT_FT5X06=y
CONFIG_TOUCHSCREEN_RASPBERRYPI_FW=y
CONFIG_TOUCHSCREEN_MIGOR=y
# CONFIG_TOUCHSCREEN_TOUCHRIGHT is not set
CONFIG_TOUCHSCREEN_TOUCHWIN=y
# CONFIG_TOUCHSCREEN_TI_AM335X_TSC is not set
CONFIG_TOUCHSCREEN_UCB1400=y
# CONFIG_TOUCHSCREEN_PIXCIR is not set
# CONFIG_TOUCHSCREEN_WDT87XX_I2C is not set
CONFIG_TOUCHSCREEN_WM831X=y
CONFIG_TOUCHSCREEN_WM97XX=y
CONFIG_TOUCHSCREEN_WM9705=y
# CONFIG_TOUCHSCREEN_WM9712 is not set
# CONFIG_TOUCHSCREEN_WM9713 is not set
CONFIG_TOUCHSCREEN_MXS_LRADC=y
# CONFIG_TOUCHSCREEN_TOUCHIT213 is not set
CONFIG_TOUCHSCREEN_TS4800=y
# CONFIG_TOUCHSCREEN_TSC_SERIO is not set
# CONFIG_TOUCHSCREEN_TSC2004 is not set
CONFIG_TOUCHSCREEN_TSC2007=y
CONFIG_TOUCHSCREEN_RM_TS=y
CONFIG_TOUCHSCREEN_SILEAD=y
CONFIG_TOUCHSCREEN_SIS_I2C=y
CONFIG_TOUCHSCREEN_ST1232=y
# CONFIG_TOUCHSCREEN_STMFTS is not set
CONFIG_TOUCHSCREEN_SUN4I=y
# CONFIG_TOUCHSCREEN_SX8654 is not set
CONFIG_TOUCHSCREEN_TPS6507X=y
CONFIG_TOUCHSCREEN_ZET6223=y
CONFIG_TOUCHSCREEN_ZFORCE=y
CONFIG_TOUCHSCREEN_ROHM_BU21023=y
CONFIG_TOUCHSCREEN_IQS5XX=y
# CONFIG_TOUCHSCREEN_ZINITIX is not set
# CONFIG_INPUT_MISC is not set
CONFIG_RMI4_CORE=y
CONFIG_RMI4_I2C=y
# CONFIG_RMI4_SMB is not set
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=y
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
# CONFIG_RMI4_F34 is not set
CONFIG_RMI4_F3A=y
CONFIG_RMI4_F55=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
CONFIG_SERIO_PCIPS2=y
# CONFIG_SERIO_LIBPS2 is not set
CONFIG_SERIO_RAW=y
# CONFIG_SERIO_ALTERA_PS2 is not set
CONFIG_SERIO_PS2MULT=y
# CONFIG_SERIO_ARC_PS2 is not set
# CONFIG_SERIO_APBPS2 is not set
# CONFIG_SERIO_OLPC_APSP is not set
CONFIG_SERIO_SUN4I_PS2=y
CONFIG_SERIO_GPIO_PS2=y
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
CONFIG_TTY=y
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_VT_HW_CONSOLE_BINDING=y
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
# CONFIG_LDISC_AUTOLOAD is not set

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
# CONFIG_SERIAL_8250 is not set

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_AMBA_PL010 is not set
CONFIG_SERIAL_ATMEL=y
# CONFIG_SERIAL_ATMEL_CONSOLE is not set
CONFIG_SERIAL_ATMEL_PDC=y
CONFIG_SERIAL_ATMEL_TTYAT=y
CONFIG_SERIAL_MESON=y
CONFIG_SERIAL_MESON_CONSOLE=y
CONFIG_SERIAL_CLPS711X=y
CONFIG_SERIAL_CLPS711X_CONSOLE=y
CONFIG_SERIAL_SAMSUNG=y
CONFIG_SERIAL_SAMSUNG_UARTS_4=y
CONFIG_SERIAL_SAMSUNG_UARTS=4
# CONFIG_SERIAL_SAMSUNG_CONSOLE is not set
CONFIG_SERIAL_TEGRA=y
CONFIG_SERIAL_TEGRA_TCU=y
CONFIG_SERIAL_TEGRA_TCU_CONSOLE=y
CONFIG_SERIAL_IMX=y
CONFIG_SERIAL_IMX_CONSOLE=y
CONFIG_SERIAL_IMX_EARLYCON=y
# CONFIG_SERIAL_UARTLITE is not set
# CONFIG_SERIAL_SH_SCI is not set
CONFIG_SERIAL_HS_LPC32XX=y
# CONFIG_SERIAL_HS_LPC32XX_CONSOLE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_SERIAL_ICOM=y
# CONFIG_SERIAL_JSM is not set
# CONFIG_SERIAL_MSM is not set
CONFIG_SERIAL_QCOM_GENI=y
CONFIG_SERIAL_QCOM_GENI_CONSOLE=y
CONFIG_SERIAL_VT8500=y
CONFIG_SERIAL_VT8500_CONSOLE=y
CONFIG_SERIAL_OMAP=y
CONFIG_SERIAL_OMAP_CONSOLE=y
# CONFIG_SERIAL_SIFIVE is not set
CONFIG_SERIAL_LANTIQ=y
CONFIG_SERIAL_LANTIQ_CONSOLE=y
CONFIG_SERIAL_QE=y
CONFIG_SERIAL_SCCNXP=y
CONFIG_SERIAL_SCCNXP_CONSOLE=y
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_TIMBERDALE is not set
# CONFIG_SERIAL_BCM63XX is not set
CONFIG_SERIAL_ALTERA_JTAGUART=y
CONFIG_SERIAL_ALTERA_JTAGUART_CONSOLE=y
# CONFIG_SERIAL_ALTERA_JTAGUART_CONSOLE_BYPASS is not set
# CONFIG_SERIAL_ALTERA_UART is not set
CONFIG_SERIAL_PCH_UART=y
# CONFIG_SERIAL_PCH_UART_CONSOLE is not set
CONFIG_SERIAL_MXS_AUART=y
CONFIG_SERIAL_MXS_AUART_CONSOLE=y
# CONFIG_SERIAL_XILINX_PS_UART is not set
CONFIG_SERIAL_MPS2_UART_CONSOLE=y
CONFIG_SERIAL_MPS2_UART=y
CONFIG_SERIAL_ARC=y
CONFIG_SERIAL_ARC_CONSOLE=y
CONFIG_SERIAL_ARC_NR_PORTS=1
CONFIG_SERIAL_RP2=y
CONFIG_SERIAL_RP2_NR_UARTS=32
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
CONFIG_SERIAL_CONEXANT_DIGICOLOR=y
CONFIG_SERIAL_CONEXANT_DIGICOLOR_CONSOLE=y
# CONFIG_SERIAL_ST_ASC is not set
CONFIG_SERIAL_SPRD=y
CONFIG_SERIAL_SPRD_CONSOLE=y
# CONFIG_SERIAL_STM32 is not set
CONFIG_SERIAL_MVEBU_UART=y
# CONFIG_SERIAL_MVEBU_CONSOLE is not set
CONFIG_SERIAL_OWL=y
# CONFIG_SERIAL_OWL_CONSOLE is not set
CONFIG_SERIAL_RDA=y
# CONFIG_SERIAL_RDA_CONSOLE is not set
CONFIG_SERIAL_MILBEAUT_USIO=y
CONFIG_SERIAL_MILBEAUT_USIO_PORTS=4
# CONFIG_SERIAL_MILBEAUT_USIO_CONSOLE is not set
CONFIG_SERIAL_LITEUART=y
CONFIG_SERIAL_LITEUART_MAX_PORTS=1
CONFIG_SERIAL_LITEUART_CONSOLE=y
CONFIG_SERIAL_SUNPLUS=y
CONFIG_SERIAL_SUNPLUS_CONSOLE=y
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
CONFIG_SERIAL_NONSTANDARD=y
CONFIG_MOXA_INTELLIO=y
# CONFIG_MOXA_SMARTIO is not set
# CONFIG_SYNCLINK_GT is not set
# CONFIG_N_HDLC is not set
# CONFIG_GOLDFISH_TTY is not set
CONFIG_NOZOMI=y
CONFIG_NULL_TTY=y
CONFIG_HVC_DRIVER=y
# CONFIG_RPMSG_TTY is not set
# CONFIG_SERIAL_DEV_BUS is not set
CONFIG_VIRTIO_CONSOLE=y
# CONFIG_IPMI_HANDLER is not set
CONFIG_IPMI_KCS_BMC=y
CONFIG_ASPEED_KCS_IPMI_BMC=y
CONFIG_NPCM7XX_KCS_IPMI_BMC=y
# CONFIG_IPMI_KCS_BMC_CDEV_IPMI is not set
# CONFIG_IPMI_KCS_BMC_SERIO is not set
# CONFIG_ASPEED_BT_IPMI_BMC is not set
# CONFIG_IPMB_DEVICE_INTERFACE is not set
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=y
# CONFIG_HW_RANDOM_ATMEL is not set
CONFIG_HW_RANDOM_BA431=y
CONFIG_HW_RANDOM_BCM2835=y
# CONFIG_HW_RANDOM_IPROC_RNG200 is not set
CONFIG_HW_RANDOM_IXP4XX=y
CONFIG_HW_RANDOM_OMAP=y
CONFIG_HW_RANDOM_OMAP3_ROM=y
CONFIG_HW_RANDOM_VIRTIO=y
CONFIG_HW_RANDOM_IMX_RNGC=y
# CONFIG_HW_RANDOM_NOMADIK is not set
# CONFIG_HW_RANDOM_STM32 is not set
CONFIG_HW_RANDOM_POLARFIRE_SOC=y
CONFIG_HW_RANDOM_MESON=y
# CONFIG_HW_RANDOM_MTK is not set
CONFIG_HW_RANDOM_EXYNOS=y
CONFIG_HW_RANDOM_NPCM=y
CONFIG_HW_RANDOM_KEYSTONE=y
CONFIG_HW_RANDOM_CCTRNG=y
CONFIG_HW_RANDOM_XIPHERA=y
CONFIG_HW_RANDOM_CN10K=y
CONFIG_APPLICOM=y

#
# PCMCIA character devices
#
CONFIG_SYNCLINK_CS=y
CONFIG_CARDMAN_4000=y
CONFIG_CARDMAN_4040=y
# CONFIG_SCR24X is not set
# end of PCMCIA character devices

CONFIG_DEVMEM=y
# CONFIG_DEVPORT is not set
CONFIG_TCG_TPM=y
# CONFIG_HW_RANDOM_TPM is not set
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
CONFIG_TCG_TIS_I2C=y
CONFIG_TCG_TIS_SYNQUACER=y
CONFIG_TCG_TIS_I2C_CR50=y
CONFIG_TCG_TIS_I2C_ATMEL=y
CONFIG_TCG_TIS_I2C_INFINEON=y
CONFIG_TCG_TIS_I2C_NUVOTON=y
CONFIG_TCG_ATMEL=y
# CONFIG_TCG_INFINEON is not set
CONFIG_TCG_CRB=y
# CONFIG_TCG_VTPM_PROXY is not set
CONFIG_TCG_TIS_ST33ZP24=y
CONFIG_TCG_TIS_ST33ZP24_I2C=y
CONFIG_XILLYBUS_CLASS=y
CONFIG_XILLYBUS=y
CONFIG_XILLYBUS_PCIE=y
CONFIG_XILLYBUS_OF=y
CONFIG_RANDOM_TRUST_CPU=y
CONFIG_RANDOM_TRUST_BOOTLOADER=y
# end of Character devices

#
# I2C support
#
CONFIG_I2C=y
# CONFIG_ACPI_I2C_OPREGION is not set
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=y
CONFIG_I2C_MUX=y

#
# Multiplexer I2C Chip support
#
CONFIG_I2C_ARB_GPIO_CHALLENGE=y
CONFIG_I2C_MUX_GPIO=y
# CONFIG_I2C_MUX_GPMUX is not set
# CONFIG_I2C_MUX_LTC4306 is not set
CONFIG_I2C_MUX_PCA9541=y
CONFIG_I2C_MUX_PCA954x=y
# CONFIG_I2C_MUX_PINCTRL is not set
CONFIG_I2C_MUX_REG=y
CONFIG_I2C_DEMUX_PINCTRL=y
CONFIG_I2C_MUX_MLXCPLD=y
# end of Multiplexer I2C Chip support

# CONFIG_I2C_HELPER_AUTO is not set
CONFIG_I2C_SMBUS=y

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCF=y
CONFIG_I2C_ALGOPCA=y
# end of I2C Algorithms

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
CONFIG_I2C_CCGX_UCSI=y
# CONFIG_I2C_ALI1535 is not set
CONFIG_I2C_ALI1563=y
# CONFIG_I2C_ALI15X3 is not set
CONFIG_I2C_AMD756=y
CONFIG_I2C_AMD8111=y
CONFIG_I2C_AMD_MP2=y
CONFIG_I2C_HIX5HD2=y
CONFIG_I2C_I801=y
CONFIG_I2C_ISCH=y
CONFIG_I2C_PIIX4=y
CONFIG_I2C_NFORCE2=y
CONFIG_I2C_NVIDIA_GPU=y
CONFIG_I2C_SIS5595=y
# CONFIG_I2C_SIS630 is not set
CONFIG_I2C_SIS96X=y
# CONFIG_I2C_VIA is not set
# CONFIG_I2C_VIAPRO is not set

#
# ACPI drivers
#
CONFIG_I2C_SCMI=y

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
CONFIG_I2C_ALTERA=y
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
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
CONFIG_I2C_DESIGNWARE_PLATFORM=y
# CONFIG_I2C_DESIGNWARE_PCI is not set
CONFIG_I2C_DIGICOLOR=y
# CONFIG_I2C_EG20T is not set
CONFIG_I2C_EMEV2=y
CONFIG_I2C_EXYNOS5=y
CONFIG_I2C_GPIO=y
# CONFIG_I2C_GPIO_FAULT_INJECTOR is not set
CONFIG_I2C_HIGHLANDER=y
CONFIG_I2C_HISI=y
# CONFIG_I2C_IMG is not set
CONFIG_I2C_IMX=y
CONFIG_I2C_IMX_LPI2C=y
# CONFIG_I2C_IOP3XX is not set
# CONFIG_I2C_JZ4780 is not set
CONFIG_I2C_KEMPLD=y
# CONFIG_I2C_LPC2K is not set
CONFIG_I2C_MESON=y
# CONFIG_I2C_MICROCHIP_CORE is not set
# CONFIG_I2C_MT65XX is not set
# CONFIG_I2C_MT7621 is not set
# CONFIG_I2C_MV64XXX is not set
# CONFIG_I2C_MXS is not set
# CONFIG_I2C_NPCM is not set
CONFIG_I2C_OCORES=y
CONFIG_I2C_OMAP=y
CONFIG_I2C_OWL=y
CONFIG_I2C_APPLE=y
CONFIG_I2C_PCA_PLATFORM=y
# CONFIG_I2C_PNX is not set
CONFIG_I2C_PXA=y
CONFIG_I2C_PXA_SLAVE=y
CONFIG_I2C_QCOM_CCI=y
CONFIG_I2C_QCOM_GENI=y
CONFIG_I2C_QUP=y
# CONFIG_I2C_RIIC is not set
CONFIG_I2C_RK3X=y
# CONFIG_I2C_RZV2M is not set
CONFIG_I2C_S3C2410=y
CONFIG_I2C_SH_MOBILE=y
CONFIG_I2C_SIMTEC=y
# CONFIG_I2C_SPRD is not set
# CONFIG_I2C_ST is not set
CONFIG_I2C_STM32F4=y
# CONFIG_I2C_STM32F7 is not set
CONFIG_I2C_SUN6I_P2WI=y
CONFIG_I2C_SYNQUACER=y
CONFIG_I2C_TEGRA_BPMP=y
# CONFIG_I2C_UNIPHIER is not set
# CONFIG_I2C_UNIPHIER_F is not set
# CONFIG_I2C_VERSATILE is not set
CONFIG_I2C_WMT=y
CONFIG_I2C_THUNDERX=y
# CONFIG_I2C_XILINX is not set
CONFIG_I2C_XLP9XX=y
CONFIG_I2C_RCAR=y

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_TAOS_EVM=y

#
# Other I2C/SMBus bus drivers
#
# CONFIG_I2C_MLXCPLD is not set
# CONFIG_I2C_VIRTIO is not set
# end of I2C Hardware Bus support

CONFIG_I2C_SLAVE=y
# CONFIG_I2C_SLAVE_EEPROM is not set
# CONFIG_I2C_SLAVE_TESTUNIT is not set
CONFIG_I2C_DEBUG_CORE=y
CONFIG_I2C_DEBUG_ALGO=y
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

CONFIG_I3C=y
# CONFIG_CDNS_I3C_MASTER is not set
# CONFIG_DW_I3C_MASTER is not set
# CONFIG_SVC_I3C_MASTER is not set
CONFIG_MIPI_I3C_HCI=y
# CONFIG_SPI is not set
CONFIG_SPMI=y
CONFIG_SPMI_HISI3670=y
CONFIG_SPMI_MSM_PMIC_ARB=y
CONFIG_SPMI_MTK_PMIF=y
# CONFIG_HSI is not set
CONFIG_PPS=y
CONFIG_PPS_DEBUG=y

#
# PPS clients support
#
CONFIG_PPS_CLIENT_KTIMER=y
CONFIG_PPS_CLIENT_LDISC=y
# CONFIG_PPS_CLIENT_GPIO is not set

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
CONFIG_GENERIC_PINCTRL_GROUPS=y
CONFIG_PINMUX=y
CONFIG_GENERIC_PINMUX_FUNCTIONS=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
CONFIG_PINCTRL_AMD=y
# CONFIG_PINCTRL_AS3722 is not set
# CONFIG_PINCTRL_AT91PIO4 is not set
CONFIG_PINCTRL_AXP209=y
# CONFIG_PINCTRL_BM1880 is not set
CONFIG_PINCTRL_DA850_PUPD=y
CONFIG_PINCTRL_DA9062=y
CONFIG_PINCTRL_EQUILIBRIUM=y
# CONFIG_PINCTRL_INGENIC is not set
# CONFIG_PINCTRL_LPC18XX is not set
CONFIG_PINCTRL_MCP23S08_I2C=y
CONFIG_PINCTRL_MCP23S08=y
# CONFIG_PINCTRL_MICROCHIP_SGPIO is not set
CONFIG_PINCTRL_OCELOT=y
# CONFIG_PINCTRL_PISTACHIO is not set
CONFIG_PINCTRL_ROCKCHIP=y
# CONFIG_PINCTRL_SINGLE is not set
# CONFIG_PINCTRL_STARFIVE is not set
# CONFIG_PINCTRL_STMFX is not set
CONFIG_PINCTRL_SX150X=y
CONFIG_PINCTRL_OWL=y
CONFIG_PINCTRL_S500=y
CONFIG_PINCTRL_S700=y
CONFIG_PINCTRL_S900=y
CONFIG_PINCTRL_ASPEED=y
CONFIG_PINCTRL_ASPEED_G4=y
CONFIG_PINCTRL_ASPEED_G5=y
# CONFIG_PINCTRL_ASPEED_G6 is not set
CONFIG_PINCTRL_BCM281XX=y
# CONFIG_PINCTRL_BCM2835 is not set
CONFIG_PINCTRL_BCM4908=y
CONFIG_PINCTRL_BCM63XX=y
# CONFIG_PINCTRL_BCM6318 is not set
CONFIG_PINCTRL_BCM6328=y
# CONFIG_PINCTRL_BCM6358 is not set
CONFIG_PINCTRL_BCM6362=y
CONFIG_PINCTRL_BCM6368=y
# CONFIG_PINCTRL_BCM63268 is not set
# CONFIG_PINCTRL_IPROC_GPIO is not set
# CONFIG_PINCTRL_CYGNUS_MUX is not set
CONFIG_PINCTRL_NS=y
CONFIG_PINCTRL_NSP_GPIO=y
CONFIG_PINCTRL_NS2_MUX=y
# CONFIG_PINCTRL_NSP_MUX is not set
# CONFIG_PINCTRL_AS370 is not set
# CONFIG_PINCTRL_BERLIN_BG4CT is not set
CONFIG_PINCTRL_MADERA=y
CONFIG_PINCTRL_CS47L35=y
CONFIG_PINCTRL_CS47L85=y

#
# Intel pinctrl drivers
#
CONFIG_PINCTRL_BAYTRAIL=y
# CONFIG_PINCTRL_CHERRYVIEW is not set
CONFIG_PINCTRL_LYNXPOINT=y
CONFIG_PINCTRL_INTEL=y
CONFIG_PINCTRL_ALDERLAKE=y
# CONFIG_PINCTRL_BROXTON is not set
# CONFIG_PINCTRL_CANNONLAKE is not set
CONFIG_PINCTRL_CEDARFORK=y
CONFIG_PINCTRL_DENVERTON=y
CONFIG_PINCTRL_ELKHARTLAKE=y
CONFIG_PINCTRL_EMMITSBURG=y
CONFIG_PINCTRL_GEMINILAKE=y
CONFIG_PINCTRL_ICELAKE=y
# CONFIG_PINCTRL_JASPERLAKE is not set
CONFIG_PINCTRL_LAKEFIELD=y
CONFIG_PINCTRL_LEWISBURG=y
CONFIG_PINCTRL_METEORLAKE=y
CONFIG_PINCTRL_SUNRISEPOINT=y
CONFIG_PINCTRL_TIGERLAKE=y
# end of Intel pinctrl drivers

#
# MediaTek pinctrl drivers
#
CONFIG_EINT_MTK=y
CONFIG_PINCTRL_MTK=y
CONFIG_PINCTRL_MTK_V2=y
CONFIG_PINCTRL_MTK_MOORE=y
CONFIG_PINCTRL_MTK_PARIS=y
CONFIG_PINCTRL_MT2701=y
CONFIG_PINCTRL_MT7623=y
# CONFIG_PINCTRL_MT7629 is not set
# CONFIG_PINCTRL_MT8135 is not set
CONFIG_PINCTRL_MT8127=y
CONFIG_PINCTRL_MT2712=y
CONFIG_PINCTRL_MT6765=y
CONFIG_PINCTRL_MT6779=y
CONFIG_PINCTRL_MT6795=y
# CONFIG_PINCTRL_MT6797 is not set
CONFIG_PINCTRL_MT7622=y
# CONFIG_PINCTRL_MT7986 is not set
CONFIG_PINCTRL_MT8167=y
# CONFIG_PINCTRL_MT8173 is not set
# CONFIG_PINCTRL_MT8183 is not set
# CONFIG_PINCTRL_MT8186 is not set
CONFIG_PINCTRL_MT8192=y
CONFIG_PINCTRL_MT8195=y
CONFIG_PINCTRL_MT8365=y
CONFIG_PINCTRL_MT8516=y
# CONFIG_PINCTRL_MT6397 is not set
# end of MediaTek pinctrl drivers

CONFIG_PINCTRL_MESON=y
CONFIG_PINCTRL_WPCM450=y
# CONFIG_PINCTRL_NPCM7XX is not set
CONFIG_PINCTRL_PXA=y
CONFIG_PINCTRL_PXA25X=y
CONFIG_PINCTRL_PXA27X=y
# CONFIG_PINCTRL_MSM is not set
CONFIG_PINCTRL_QCOM_SPMI_PMIC=y
CONFIG_PINCTRL_QCOM_SSBI_PMIC=y
CONFIG_PINCTRL_SC7280_LPASS_LPI=y
CONFIG_PINCTRL_SM8250_LPASS_LPI=y
CONFIG_PINCTRL_LPASS_LPI=y

#
# Renesas pinctrl drivers
#
CONFIG_PINCTRL_RENESAS=y
CONFIG_PINCTRL_SH_PFC=y
CONFIG_PINCTRL_SH_PFC_GPIO=y
CONFIG_PINCTRL_SH_FUNC_GPIO=y
CONFIG_PINCTRL_PFC_EMEV2=y
# CONFIG_PINCTRL_PFC_R8A77995 is not set
# CONFIG_PINCTRL_PFC_R8A7794 is not set
CONFIG_PINCTRL_PFC_R8A77990=y
CONFIG_PINCTRL_PFC_R8A7779=y
CONFIG_PINCTRL_PFC_R8A7790=y
# CONFIG_PINCTRL_PFC_R8A77950 is not set
# CONFIG_PINCTRL_PFC_R8A77951 is not set
# CONFIG_PINCTRL_PFC_R8A7778 is not set
# CONFIG_PINCTRL_PFC_R8A7793 is not set
CONFIG_PINCTRL_PFC_R8A7791=y
CONFIG_PINCTRL_PFC_R8A77965=y
# CONFIG_PINCTRL_PFC_R8A77960 is not set
CONFIG_PINCTRL_PFC_R8A77961=y
CONFIG_PINCTRL_PFC_R8A779F0=y
CONFIG_PINCTRL_PFC_R8A7792=y
CONFIG_PINCTRL_PFC_R8A77980=y
CONFIG_PINCTRL_PFC_R8A77970=y
# CONFIG_PINCTRL_PFC_R8A779A0 is not set
# CONFIG_PINCTRL_PFC_R8A779G0 is not set
# CONFIG_PINCTRL_PFC_R8A7740 is not set
CONFIG_PINCTRL_PFC_R8A73A4=y
CONFIG_PINCTRL_RZA1=y
# CONFIG_PINCTRL_RZA2 is not set
CONFIG_PINCTRL_RZG2L=y
CONFIG_PINCTRL_PFC_R8A77470=y
# CONFIG_PINCTRL_PFC_R8A7745 is not set
# CONFIG_PINCTRL_PFC_R8A7742 is not set
CONFIG_PINCTRL_PFC_R8A7743=y
CONFIG_PINCTRL_PFC_R8A7744=y
# CONFIG_PINCTRL_PFC_R8A774C0 is not set
# CONFIG_PINCTRL_PFC_R8A774E1 is not set
CONFIG_PINCTRL_PFC_R8A774A1=y
# CONFIG_PINCTRL_PFC_R8A774B1 is not set
CONFIG_PINCTRL_RZN1=y
CONFIG_PINCTRL_RZV2M=y
CONFIG_PINCTRL_PFC_SH7203=y
# CONFIG_PINCTRL_PFC_SH7264 is not set
CONFIG_PINCTRL_PFC_SH7269=y
CONFIG_PINCTRL_PFC_SH7720=y
CONFIG_PINCTRL_PFC_SH7722=y
# CONFIG_PINCTRL_PFC_SH7734 is not set
CONFIG_PINCTRL_PFC_SH7757=y
# CONFIG_PINCTRL_PFC_SH7785 is not set
CONFIG_PINCTRL_PFC_SH7786=y
CONFIG_PINCTRL_PFC_SH73A0=y
CONFIG_PINCTRL_PFC_SH7723=y
# CONFIG_PINCTRL_PFC_SH7724 is not set
CONFIG_PINCTRL_PFC_SHX3=y
# end of Renesas pinctrl drivers

CONFIG_PINCTRL_SAMSUNG=y
# CONFIG_PINCTRL_EXYNOS is not set
CONFIG_PINCTRL_S3C24XX=y
# CONFIG_PINCTRL_S3C64XX is not set
CONFIG_PINCTRL_SPRD=y
CONFIG_PINCTRL_SPRD_SC9860=y
CONFIG_PINCTRL_STM32=y
# CONFIG_PINCTRL_STM32F429 is not set
# CONFIG_PINCTRL_STM32F469 is not set
CONFIG_PINCTRL_STM32F746=y
CONFIG_PINCTRL_STM32F769=y
CONFIG_PINCTRL_STM32H743=y
# CONFIG_PINCTRL_STM32MP135 is not set
# CONFIG_PINCTRL_STM32MP157 is not set
# CONFIG_PINCTRL_TI_IODELAY is not set
# CONFIG_PINCTRL_UNIPHIER is not set
CONFIG_PINCTRL_VISCONTI=y
CONFIG_PINCTRL_TMPV7700=y
CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_OF_GPIO=y
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
CONFIG_DEBUG_GPIO=y
CONFIG_GPIO_CDEV=y
CONFIG_GPIO_CDEV_V1=y
CONFIG_GPIO_GENERIC=y
CONFIG_GPIO_REGMAP=y
CONFIG_GPIO_MAX730X=y

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_74XX_MMIO is not set
CONFIG_GPIO_ALTERA=y
CONFIG_GPIO_AMDPT=y
# CONFIG_GPIO_ASPEED is not set
# CONFIG_GPIO_ASPEED_SGPIO is not set
CONFIG_GPIO_ATH79=y
# CONFIG_GPIO_RASPBERRYPI_EXP is not set
# CONFIG_GPIO_BCM_KONA is not set
# CONFIG_GPIO_BCM_XGS_IPROC is not set
# CONFIG_GPIO_BRCMSTB is not set
CONFIG_GPIO_CADENCE=y
CONFIG_GPIO_CLPS711X=y
CONFIG_GPIO_DWAPB=y
CONFIG_GPIO_EIC_SPRD=y
# CONFIG_GPIO_EM is not set
# CONFIG_GPIO_FTGPIO010 is not set
# CONFIG_GPIO_GENERIC_PLATFORM is not set
CONFIG_GPIO_GRGPIO=y
CONFIG_GPIO_HISI=y
CONFIG_GPIO_HLWD=y
CONFIG_GPIO_IOP=y
CONFIG_GPIO_LOGICVC=y
CONFIG_GPIO_LPC18XX=y
CONFIG_GPIO_LPC32XX=y
# CONFIG_GPIO_MB86S7X is not set
# CONFIG_GPIO_MPC8XXX is not set
# CONFIG_GPIO_MT7621 is not set
CONFIG_GPIO_MXC=y
# CONFIG_GPIO_MXS is not set
CONFIG_GPIO_PMIC_EIC_SPRD=y
CONFIG_GPIO_PXA=y
CONFIG_GPIO_RCAR=y
CONFIG_GPIO_RDA=y
# CONFIG_GPIO_ROCKCHIP is not set
CONFIG_GPIO_SAMA5D2_PIOBU=y
CONFIG_GPIO_SIFIVE=y
CONFIG_GPIO_SIOX=y
CONFIG_GPIO_SNPS_CREG=y
# CONFIG_GPIO_SPRD is not set
# CONFIG_GPIO_STP_XWAY is not set
CONFIG_GPIO_SYSCON=y
CONFIG_GPIO_TEGRA=y
# CONFIG_GPIO_TEGRA186 is not set
CONFIG_GPIO_TS4800=y
CONFIG_GPIO_THUNDERX=y
CONFIG_GPIO_UNIPHIER=y
CONFIG_GPIO_VISCONTI=y
# CONFIG_GPIO_VX855 is not set
CONFIG_GPIO_WCD934X=y
CONFIG_GPIO_XGENE_SB=y
CONFIG_GPIO_XILINX=y
# CONFIG_GPIO_XLP is not set
# CONFIG_GPIO_AMD_FCH is not set
# CONFIG_GPIO_IDT3243X is not set
# end of Memory mapped GPIO drivers

#
# I2C GPIO expanders
#
# CONFIG_GPIO_ADP5588 is not set
# CONFIG_GPIO_ADNP is not set
CONFIG_GPIO_GW_PLD=y
CONFIG_GPIO_MAX7300=y
CONFIG_GPIO_MAX732X=y
CONFIG_GPIO_MAX732X_IRQ=y
CONFIG_GPIO_PCA953X=y
CONFIG_GPIO_PCA953X_IRQ=y
CONFIG_GPIO_PCA9570=y
CONFIG_GPIO_PCF857X=y
CONFIG_GPIO_TPIC2810=y
# CONFIG_GPIO_TS4900 is not set
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
CONFIG_GPIO_BD71815=y
# CONFIG_GPIO_BD71828 is not set
CONFIG_GPIO_JANZ_TTL=y
CONFIG_GPIO_KEMPLD=y
# CONFIG_GPIO_LP3943 is not set
# CONFIG_GPIO_LP87565 is not set
# CONFIG_GPIO_MADERA is not set
CONFIG_GPIO_MAX77650=y
# CONFIG_GPIO_RC5T583 is not set
# CONFIG_GPIO_SL28CPLD is not set
# CONFIG_GPIO_TIMBERDALE is not set
# CONFIG_GPIO_TPS65086 is not set
CONFIG_GPIO_TPS65218=y
CONFIG_GPIO_TPS65910=y
# CONFIG_GPIO_TQMX86 is not set
# CONFIG_GPIO_TWL4030 is not set
# CONFIG_GPIO_UCB1400 is not set
# CONFIG_GPIO_WM831X is not set
CONFIG_GPIO_WM8350=y
CONFIG_GPIO_WM8994=y
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_BT8XX is not set
# CONFIG_GPIO_MLXBF is not set
CONFIG_GPIO_MLXBF2=y
CONFIG_GPIO_ML_IOH=y
# CONFIG_GPIO_PCH is not set
CONFIG_GPIO_PCI_IDIO_16=y
CONFIG_GPIO_PCIE_IDIO_24=y
CONFIG_GPIO_RDC321X=y
# end of PCI GPIO expanders

#
# Virtual GPIO drivers
#
CONFIG_GPIO_AGGREGATOR=y
CONFIG_GPIO_MOCKUP=y
CONFIG_GPIO_VIRTIO=y
# CONFIG_GPIO_SIM is not set
# end of Virtual GPIO drivers

CONFIG_W1=y

#
# 1-wire Bus Masters
#
CONFIG_W1_MASTER_MATROX=y
# CONFIG_W1_MASTER_DS2482 is not set
CONFIG_W1_MASTER_MXC=y
CONFIG_W1_MASTER_DS1WM=y
CONFIG_W1_MASTER_GPIO=y
CONFIG_W1_MASTER_SGI=y
# end of 1-wire Bus Masters

#
# 1-wire Slaves
#
CONFIG_W1_SLAVE_THERM=y
# CONFIG_W1_SLAVE_SMEM is not set
CONFIG_W1_SLAVE_DS2405=y
# CONFIG_W1_SLAVE_DS2408 is not set
CONFIG_W1_SLAVE_DS2413=y
CONFIG_W1_SLAVE_DS2406=y
# CONFIG_W1_SLAVE_DS2423 is not set
CONFIG_W1_SLAVE_DS2805=y
CONFIG_W1_SLAVE_DS2430=y
CONFIG_W1_SLAVE_DS2431=y
CONFIG_W1_SLAVE_DS2433=y
# CONFIG_W1_SLAVE_DS2433_CRC is not set
CONFIG_W1_SLAVE_DS2438=y
CONFIG_W1_SLAVE_DS250X=y
CONFIG_W1_SLAVE_DS2780=y
CONFIG_W1_SLAVE_DS2781=y
# CONFIG_W1_SLAVE_DS28E04 is not set
# CONFIG_W1_SLAVE_DS28E17 is not set
# end of 1-wire Slaves

# CONFIG_POWER_RESET is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
# CONFIG_POWER_SUPPLY_HWMON is not set
# CONFIG_PDA_POWER is not set
# CONFIG_IP5XXX_POWER is not set
# CONFIG_WM831X_BACKUP is not set
# CONFIG_WM831X_POWER is not set
# CONFIG_WM8350_POWER is not set
CONFIG_TEST_POWER=y
# CONFIG_BATTERY_88PM860X is not set
# CONFIG_CHARGER_ADP5061 is not set
CONFIG_BATTERY_ACT8945A=y
CONFIG_BATTERY_CW2015=y
CONFIG_BATTERY_DS2760=y
CONFIG_BATTERY_DS2780=y
CONFIG_BATTERY_DS2781=y
CONFIG_BATTERY_DS2782=y
# CONFIG_BATTERY_SAMSUNG_SDI is not set
# CONFIG_BATTERY_WM97XX is not set
# CONFIG_BATTERY_SBS is not set
CONFIG_CHARGER_SBS=y
CONFIG_MANAGER_SBS=y
# CONFIG_BATTERY_BQ27XXX is not set
CONFIG_BATTERY_MAX17040=y
CONFIG_BATTERY_MAX17042=y
# CONFIG_BATTERY_MAX1721X is not set
CONFIG_CHARGER_PCF50633=y
CONFIG_CHARGER_MAX8903=y
CONFIG_CHARGER_LP8727=y
# CONFIG_CHARGER_GPIO is not set
# CONFIG_CHARGER_MANAGER is not set
# CONFIG_CHARGER_LT3651 is not set
CONFIG_CHARGER_LTC4162L=y
CONFIG_CHARGER_DETECTOR_MAX14656=y
# CONFIG_CHARGER_MAX77650 is not set
CONFIG_CHARGER_MAX77693=y
CONFIG_CHARGER_MAX77976=y
# CONFIG_CHARGER_MT6360 is not set
CONFIG_CHARGER_QCOM_SMBB=y
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_CHARGER_BQ24190 is not set
CONFIG_CHARGER_BQ24257=y
CONFIG_CHARGER_BQ24735=y
# CONFIG_CHARGER_BQ2515X is not set
CONFIG_CHARGER_BQ25890=y
CONFIG_CHARGER_BQ25980=y
CONFIG_CHARGER_BQ256XX=y
CONFIG_CHARGER_SMB347=y
CONFIG_BATTERY_GAUGE_LTC2941=y
CONFIG_BATTERY_GOLDFISH=y
CONFIG_BATTERY_RT5033=y
CONFIG_CHARGER_RT9455=y
CONFIG_CHARGER_SC2731=y
CONFIG_CHARGER_UCS1002=y
CONFIG_CHARGER_BD99954=y
# CONFIG_BATTERY_ACER_A500 is not set
# CONFIG_BATTERY_UG3105 is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_AD7414=y
CONFIG_SENSORS_AD7418=y
# CONFIG_SENSORS_ADM1025 is not set
CONFIG_SENSORS_ADM1026=y
CONFIG_SENSORS_ADM1029=y
CONFIG_SENSORS_ADM1031=y
CONFIG_SENSORS_ADM1177=y
# CONFIG_SENSORS_ADM9240 is not set
CONFIG_SENSORS_ADT7X10=y
CONFIG_SENSORS_ADT7410=y
CONFIG_SENSORS_ADT7411=y
CONFIG_SENSORS_ADT7462=y
CONFIG_SENSORS_ADT7470=y
# CONFIG_SENSORS_ADT7475 is not set
# CONFIG_SENSORS_AHT10 is not set
CONFIG_SENSORS_AS370=y
CONFIG_SENSORS_ASC7621=y
CONFIG_SENSORS_AXI_FAN_CONTROL=y
CONFIG_SENSORS_ARM_SCPI=y
# CONFIG_SENSORS_ASB100 is not set
# CONFIG_SENSORS_ASPEED is not set
CONFIG_SENSORS_ATXP1=y
# CONFIG_SENSORS_BT1_PVT is not set
# CONFIG_SENSORS_CORSAIR_CPRO is not set
CONFIG_SENSORS_CORSAIR_PSU=y
CONFIG_SENSORS_DRIVETEMP=y
CONFIG_SENSORS_DS620=y
CONFIG_SENSORS_DS1621=y
CONFIG_SENSORS_I5K_AMB=y
# CONFIG_SENSORS_SPARX5 is not set
# CONFIG_SENSORS_F71805F is not set
# CONFIG_SENSORS_F71882FG is not set
# CONFIG_SENSORS_F75375S is not set
CONFIG_SENSORS_GSC=y
CONFIG_SENSORS_FSCHMD=y
CONFIG_SENSORS_GL518SM=y
# CONFIG_SENSORS_GL520SM is not set
CONFIG_SENSORS_G760A=y
CONFIG_SENSORS_G762=y
# CONFIG_SENSORS_GPIO_FAN is not set
# CONFIG_SENSORS_HIH6130 is not set
CONFIG_SENSORS_IT87=y
# CONFIG_SENSORS_JC42 is not set
# CONFIG_SENSORS_POWR1220 is not set
# CONFIG_SENSORS_LAN966X is not set
CONFIG_SENSORS_LINEAGE=y
# CONFIG_SENSORS_LTC2945 is not set
# CONFIG_SENSORS_LTC2947_I2C is not set
CONFIG_SENSORS_LTC2990=y
CONFIG_SENSORS_LTC2992=y
CONFIG_SENSORS_LTC4151=y
# CONFIG_SENSORS_LTC4215 is not set
CONFIG_SENSORS_LTC4222=y
CONFIG_SENSORS_LTC4245=y
CONFIG_SENSORS_LTC4260=y
CONFIG_SENSORS_LTC4261=y
# CONFIG_SENSORS_MAX127 is not set
CONFIG_SENSORS_MAX16065=y
CONFIG_SENSORS_MAX1619=y
# CONFIG_SENSORS_MAX1668 is not set
CONFIG_SENSORS_MAX197=y
# CONFIG_SENSORS_MAX31730 is not set
CONFIG_SENSORS_MAX6620=y
CONFIG_SENSORS_MAX6621=y
CONFIG_SENSORS_MAX6639=y
CONFIG_SENSORS_MAX6650=y
# CONFIG_SENSORS_MAX6697 is not set
CONFIG_SENSORS_MAX31790=y
CONFIG_SENSORS_MCP3021=y
CONFIG_SENSORS_TC654=y
# CONFIG_SENSORS_TPS23861 is not set
CONFIG_SENSORS_MENF21BMC_HWMON=y
# CONFIG_SENSORS_MR75203 is not set
CONFIG_SENSORS_LM63=y
# CONFIG_SENSORS_LM73 is not set
# CONFIG_SENSORS_LM75 is not set
CONFIG_SENSORS_LM77=y
CONFIG_SENSORS_LM78=y
# CONFIG_SENSORS_LM80 is not set
CONFIG_SENSORS_LM83=y
CONFIG_SENSORS_LM85=y
# CONFIG_SENSORS_LM87 is not set
CONFIG_SENSORS_LM90=y
# CONFIG_SENSORS_LM92 is not set
CONFIG_SENSORS_LM93=y
CONFIG_SENSORS_LM95234=y
CONFIG_SENSORS_LM95241=y
# CONFIG_SENSORS_LM95245 is not set
CONFIG_SENSORS_PC87360=y
CONFIG_SENSORS_PC87427=y
CONFIG_SENSORS_NCT6683=y
CONFIG_SENSORS_NCT6775_CORE=y
CONFIG_SENSORS_NCT6775=y
CONFIG_SENSORS_NCT6775_I2C=y
# CONFIG_SENSORS_NCT7802 is not set
CONFIG_SENSORS_NPCM7XX=y
CONFIG_SENSORS_NSA320=y
# CONFIG_SENSORS_OCC_P8_I2C is not set
CONFIG_SENSORS_PCF8591=y
CONFIG_SENSORS_PECI_CPUTEMP=y
CONFIG_SENSORS_PECI_DIMMTEMP=y
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
CONFIG_SENSORS_DPS920AB=y
CONFIG_SENSORS_INSPUR_IPSPS=y
# CONFIG_SENSORS_IR35221 is not set
# CONFIG_SENSORS_IR36021 is not set
# CONFIG_SENSORS_IR38064 is not set
CONFIG_SENSORS_IRPS5401=y
CONFIG_SENSORS_ISL68137=y
CONFIG_SENSORS_LM25066=y
# CONFIG_SENSORS_LM25066_REGULATOR is not set
# CONFIG_SENSORS_LT7182S is not set
# CONFIG_SENSORS_LTC2978 is not set
CONFIG_SENSORS_LTC3815=y
CONFIG_SENSORS_MAX15301=y
# CONFIG_SENSORS_MAX16064 is not set
CONFIG_SENSORS_MAX16601=y
CONFIG_SENSORS_MAX20730=y
# CONFIG_SENSORS_MAX20751 is not set
CONFIG_SENSORS_MAX31785=y
CONFIG_SENSORS_MAX34440=y
CONFIG_SENSORS_MAX8688=y
CONFIG_SENSORS_MP2888=y
# CONFIG_SENSORS_MP2975 is not set
CONFIG_SENSORS_MP5023=y
CONFIG_SENSORS_PIM4328=y
CONFIG_SENSORS_PLI1209BC=y
# CONFIG_SENSORS_PLI1209BC_REGULATOR is not set
# CONFIG_SENSORS_PM6764TR is not set
CONFIG_SENSORS_PXE1610=y
CONFIG_SENSORS_Q54SJ108A2=y
# CONFIG_SENSORS_STPDDC60 is not set
CONFIG_SENSORS_TPS40422=y
CONFIG_SENSORS_TPS53679=y
CONFIG_SENSORS_UCD9000=y
CONFIG_SENSORS_UCD9200=y
# CONFIG_SENSORS_XDPE152 is not set
CONFIG_SENSORS_XDPE122=y
CONFIG_SENSORS_XDPE122_REGULATOR=y
CONFIG_SENSORS_ZL6100=y
CONFIG_SENSORS_PWM_FAN=y
# CONFIG_SENSORS_RASPBERRYPI_HWMON is not set
CONFIG_SENSORS_SL28CPLD=y
CONFIG_SENSORS_SBTSI=y
CONFIG_SENSORS_SBRMI=y
CONFIG_SENSORS_SHT15=y
CONFIG_SENSORS_SHT21=y
# CONFIG_SENSORS_SHT3x is not set
CONFIG_SENSORS_SHT4x=y
CONFIG_SENSORS_SHTC1=y
# CONFIG_SENSORS_SIS5595 is not set
# CONFIG_SENSORS_SY7636A is not set
CONFIG_SENSORS_DME1737=y
CONFIG_SENSORS_EMC1403=y
# CONFIG_SENSORS_EMC2103 is not set
CONFIG_SENSORS_EMC6W201=y
# CONFIG_SENSORS_SMSC47M1 is not set
CONFIG_SENSORS_SMSC47M192=y
# CONFIG_SENSORS_SMSC47B397 is not set
CONFIG_SENSORS_STTS751=y
CONFIG_SENSORS_SMM665=y
CONFIG_SENSORS_ADC128D818=y
# CONFIG_SENSORS_ADS7828 is not set
CONFIG_SENSORS_AMC6821=y
# CONFIG_SENSORS_INA209 is not set
CONFIG_SENSORS_INA2XX=y
# CONFIG_SENSORS_INA238 is not set
CONFIG_SENSORS_INA3221=y
# CONFIG_SENSORS_TC74 is not set
CONFIG_SENSORS_THMC50=y
CONFIG_SENSORS_TMP102=y
CONFIG_SENSORS_TMP103=y
CONFIG_SENSORS_TMP108=y
# CONFIG_SENSORS_TMP401 is not set
CONFIG_SENSORS_TMP421=y
# CONFIG_SENSORS_TMP464 is not set
CONFIG_SENSORS_TMP513=y
# CONFIG_SENSORS_VIA686A is not set
# CONFIG_SENSORS_VT1211 is not set
CONFIG_SENSORS_VT8231=y
CONFIG_SENSORS_W83773G=y
CONFIG_SENSORS_W83781D=y
CONFIG_SENSORS_W83791D=y
# CONFIG_SENSORS_W83792D is not set
CONFIG_SENSORS_W83793=y
CONFIG_SENSORS_W83795=y
# CONFIG_SENSORS_W83795_FANCTRL is not set
# CONFIG_SENSORS_W83L785TS is not set
CONFIG_SENSORS_W83L786NG=y
CONFIG_SENSORS_W83627HF=y
CONFIG_SENSORS_W83627EHF=y
# CONFIG_SENSORS_WM831X is not set
# CONFIG_SENSORS_WM8350 is not set
# CONFIG_SENSORS_XGENE is not set

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=y
CONFIG_THERMAL=y
CONFIG_THERMAL_STATISTICS=y
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_OF=y
# CONFIG_THERMAL_WRITABLE_TRIPS is not set
# CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE is not set
CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE=y
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
# CONFIG_THERMAL_GOV_BANG_BANG is not set
# CONFIG_THERMAL_GOV_USER_SPACE is not set
# CONFIG_CPU_THERMAL is not set
CONFIG_DEVFREQ_THERMAL=y
CONFIG_THERMAL_EMULATION=y
CONFIG_THERMAL_MMIO=y
CONFIG_HISI_THERMAL=y
# CONFIG_IMX_THERMAL is not set
CONFIG_IMX8MM_THERMAL=y
CONFIG_K3_THERMAL=y
# CONFIG_QORIQ_THERMAL is not set
# CONFIG_SPEAR_THERMAL is not set
# CONFIG_SUN8I_THERMAL is not set
CONFIG_ROCKCHIP_THERMAL=y
CONFIG_RCAR_THERMAL=y
# CONFIG_RCAR_GEN3_THERMAL is not set
CONFIG_RZG2L_THERMAL=y
CONFIG_KIRKWOOD_THERMAL=y
CONFIG_DOVE_THERMAL=y
CONFIG_ARMADA_THERMAL=y
CONFIG_DA9062_THERMAL=y
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
# CONFIG_TI_SOC_THERMAL is not set
# end of Texas Instruments thermal drivers

#
# Samsung thermal drivers
#
CONFIG_EXYNOS_THERMAL=y
# end of Samsung thermal drivers

#
# NVIDIA Tegra thermal drivers
#
# CONFIG_TEGRA_SOCTHERM is not set
CONFIG_TEGRA_BPMP_THERMAL=y
CONFIG_TEGRA30_TSENSOR=y
# end of NVIDIA Tegra thermal drivers

#
# Qualcomm thermal drivers
#
# end of Qualcomm thermal drivers

# CONFIG_UNIPHIER_THERMAL is not set
CONFIG_SPRD_THERMAL=y
CONFIG_KHADAS_MCU_FAN_THERMAL=y
# CONFIG_WATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
# CONFIG_SSB is not set
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=y
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
CONFIG_BCMA_HOST_SOC=y
CONFIG_BCMA_DRIVER_PCI=y
CONFIG_BCMA_DRIVER_MIPS=y
CONFIG_BCMA_PFLASH=y
# CONFIG_BCMA_SFLASH is not set
CONFIG_BCMA_NFLASH=y
CONFIG_BCMA_DRIVER_GMAC_CMN=y
# CONFIG_BCMA_DRIVER_GPIO is not set
# CONFIG_BCMA_DEBUG is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
CONFIG_MFD_ACT8945A=y
CONFIG_MFD_AS3711=y
CONFIG_MFD_AS3722=y
# CONFIG_PMIC_ADP5520 is not set
CONFIG_MFD_AAT2870_CORE=y
CONFIG_MFD_AT91_USART=y
# CONFIG_MFD_ATMEL_FLEXCOM is not set
# CONFIG_MFD_ATMEL_HLCDC is not set
CONFIG_MFD_BCM590XX=y
# CONFIG_MFD_BD9571MWV is not set
CONFIG_MFD_AXP20X=y
CONFIG_MFD_AXP20X_I2C=y
CONFIG_MFD_MADERA=y
CONFIG_MFD_MADERA_I2C=y
# CONFIG_MFD_CS47L15 is not set
CONFIG_MFD_CS47L35=y
CONFIG_MFD_CS47L85=y
# CONFIG_MFD_CS47L90 is not set
# CONFIG_MFD_CS47L92 is not set
# CONFIG_MFD_ASIC3 is not set
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_I2C is not set
# CONFIG_MFD_DA9055 is not set
CONFIG_MFD_DA9062=y
CONFIG_MFD_DA9063=y
# CONFIG_MFD_DA9150 is not set
CONFIG_MFD_ENE_KB3930=y
CONFIG_MFD_EXYNOS_LPASS=y
CONFIG_MFD_GATEWORKS_GSC=y
# CONFIG_MFD_MC13XXX_I2C is not set
CONFIG_MFD_MP2629=y
CONFIG_MFD_MXS_LRADC=y
# CONFIG_MFD_MX25_TSADC is not set
CONFIG_MFD_HI6421_PMIC=y
CONFIG_MFD_HI6421_SPMI=y
CONFIG_MFD_HI655X_PMIC=y
CONFIG_HTC_PASIC3=y
# CONFIG_HTC_I2CPLD is not set
CONFIG_LPC_ICH=y
CONFIG_LPC_SCH=y
# CONFIG_INTEL_SOC_PMIC is not set
# CONFIG_INTEL_SOC_PMIC_CHTWC is not set
CONFIG_MFD_IQS62X=y
CONFIG_MFD_JANZ_CMODIO=y
CONFIG_MFD_KEMPLD=y
# CONFIG_MFD_88PM800 is not set
CONFIG_MFD_88PM805=y
CONFIG_MFD_88PM860X=y
# CONFIG_MFD_MAX14577 is not set
# CONFIG_MFD_MAX77620 is not set
CONFIG_MFD_MAX77650=y
# CONFIG_MFD_MAX77686 is not set
CONFIG_MFD_MAX77693=y
CONFIG_MFD_MAX77714=y
# CONFIG_MFD_MAX77843 is not set
CONFIG_MFD_MAX8907=y
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
CONFIG_MFD_MT6360=y
CONFIG_MFD_MT6397=y
CONFIG_MFD_MENF21BMC=y
CONFIG_MFD_NTXEC=y
CONFIG_MFD_RETU=y
CONFIG_MFD_PCF50633=y
# CONFIG_PCF50633_ADC is not set
CONFIG_PCF50633_GPIO=y
CONFIG_UCB1400_CORE=y
CONFIG_MFD_PM8XXX=y
CONFIG_MFD_SPMI_PMIC=y
CONFIG_MFD_RDC321X=y
# CONFIG_MFD_RT4831 is not set
CONFIG_MFD_RT5033=y
CONFIG_MFD_RC5T583=y
# CONFIG_MFD_RK808 is not set
# CONFIG_MFD_RN5T618 is not set
# CONFIG_MFD_SEC_CORE is not set
# CONFIG_MFD_SI476X_CORE is not set
CONFIG_MFD_SIMPLE_MFD_I2C=y
CONFIG_MFD_SL28CPLD=y
# CONFIG_MFD_SM501 is not set
CONFIG_MFD_SKY81452=y
# CONFIG_ABX500_CORE is not set
# CONFIG_MFD_STMPE is not set
CONFIG_MFD_SUN6I_PRCM=y
CONFIG_MFD_SYSCON=y
CONFIG_MFD_TI_AM335X_TSCADC=y
CONFIG_MFD_LP3943=y
CONFIG_MFD_LP8788=y
CONFIG_MFD_TI_LMU=y
# CONFIG_MFD_PALMAS is not set
CONFIG_TPS6105X=y
# CONFIG_TPS65010 is not set
CONFIG_TPS6507X=y
CONFIG_MFD_TPS65086=y
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_TPS65217 is not set
# CONFIG_MFD_TI_LP873X is not set
CONFIG_MFD_TI_LP87565=y
CONFIG_MFD_TPS65218=y
# CONFIG_MFD_TPS6586X is not set
CONFIG_MFD_TPS65910=y
# CONFIG_MFD_TPS65912_I2C is not set
CONFIG_TWL4030_CORE=y
CONFIG_MFD_TWL4030_AUDIO=y
# CONFIG_TWL6040_CORE is not set
# CONFIG_MFD_WL1273_CORE is not set
CONFIG_MFD_LM3533=y
CONFIG_MFD_TIMBERDALE=y
# CONFIG_MFD_TC3589X is not set
CONFIG_MFD_TQMX86=y
# CONFIG_MFD_VX855 is not set
# CONFIG_MFD_LOCHNAGAR is not set
# CONFIG_MFD_ARIZONA_I2C is not set
CONFIG_MFD_WM8400=y
CONFIG_MFD_WM831X=y
CONFIG_MFD_WM831X_I2C=y
CONFIG_MFD_WM8350=y
CONFIG_MFD_WM8350_I2C=y
CONFIG_MFD_WM8994=y
CONFIG_MFD_STW481X=y
CONFIG_MFD_ROHM_BD718XX=y
CONFIG_MFD_ROHM_BD71828=y
CONFIG_MFD_ROHM_BD957XMUF=y
CONFIG_MFD_STM32_LPTIMER=y
CONFIG_MFD_STM32_TIMERS=y
# CONFIG_MFD_STPMIC1 is not set
CONFIG_MFD_STMFX=y
CONFIG_MFD_WCD934X=y
CONFIG_MFD_ATC260X=y
CONFIG_MFD_ATC260X_I2C=y
CONFIG_MFD_KHADAS_MCU=y
CONFIG_MFD_ACER_A500_EC=y
# CONFIG_MFD_QCOM_PM8008 is not set
CONFIG_MFD_RSMU_I2C=y
# end of Multifunction device drivers

CONFIG_REGULATOR=y
# CONFIG_REGULATOR_DEBUG is not set
CONFIG_REGULATOR_FIXED_VOLTAGE=y
CONFIG_REGULATOR_VIRTUAL_CONSUMER=y
CONFIG_REGULATOR_USERSPACE_CONSUMER=y
CONFIG_REGULATOR_88PG86X=y
CONFIG_REGULATOR_88PM8607=y
# CONFIG_REGULATOR_ACT8865 is not set
CONFIG_REGULATOR_ACT8945A=y
# CONFIG_REGULATOR_AD5398 is not set
CONFIG_REGULATOR_ANATOP=y
CONFIG_REGULATOR_AAT2870=y
CONFIG_REGULATOR_ARIZONA_LDO1=y
CONFIG_REGULATOR_ARIZONA_MICSUPP=y
CONFIG_REGULATOR_AS3711=y
CONFIG_REGULATOR_AS3722=y
CONFIG_REGULATOR_ATC260X=y
CONFIG_REGULATOR_AXP20X=y
CONFIG_REGULATOR_BCM590XX=y
CONFIG_REGULATOR_BD71815=y
# CONFIG_REGULATOR_BD71828 is not set
CONFIG_REGULATOR_BD718XX=y
CONFIG_REGULATOR_BD957XMUF=y
CONFIG_REGULATOR_DA9062=y
CONFIG_REGULATOR_DA9063=y
CONFIG_REGULATOR_DA9121=y
# CONFIG_REGULATOR_DA9210 is not set
# CONFIG_REGULATOR_DA9211 is not set
CONFIG_REGULATOR_FAN53555=y
CONFIG_REGULATOR_FAN53880=y
CONFIG_REGULATOR_GPIO=y
CONFIG_REGULATOR_HI6421=y
# CONFIG_REGULATOR_HI6421V530 is not set
# CONFIG_REGULATOR_HI655X is not set
CONFIG_REGULATOR_HI6421V600=y
CONFIG_REGULATOR_ISL9305=y
CONFIG_REGULATOR_ISL6271A=y
# CONFIG_REGULATOR_LM363X is not set
# CONFIG_REGULATOR_LP3971 is not set
# CONFIG_REGULATOR_LP3972 is not set
CONFIG_REGULATOR_LP872X=y
CONFIG_REGULATOR_LP8755=y
CONFIG_REGULATOR_LP87565=y
# CONFIG_REGULATOR_LP8788 is not set
CONFIG_REGULATOR_LTC3589=y
CONFIG_REGULATOR_LTC3676=y
# CONFIG_REGULATOR_MAX1586 is not set
CONFIG_REGULATOR_MAX77620=y
CONFIG_REGULATOR_MAX77650=y
CONFIG_REGULATOR_MAX8649=y
CONFIG_REGULATOR_MAX8660=y
CONFIG_REGULATOR_MAX8893=y
CONFIG_REGULATOR_MAX8907=y
CONFIG_REGULATOR_MAX8952=y
CONFIG_REGULATOR_MAX8973=y
CONFIG_REGULATOR_MAX20086=y
CONFIG_REGULATOR_MAX77686=y
CONFIG_REGULATOR_MAX77693=y
CONFIG_REGULATOR_MAX77802=y
CONFIG_REGULATOR_MAX77826=y
CONFIG_REGULATOR_MCP16502=y
# CONFIG_REGULATOR_MP5416 is not set
CONFIG_REGULATOR_MP8859=y
CONFIG_REGULATOR_MP886X=y
# CONFIG_REGULATOR_MPQ7920 is not set
# CONFIG_REGULATOR_MT6311 is not set
# CONFIG_REGULATOR_MT6315 is not set
# CONFIG_REGULATOR_MT6323 is not set
# CONFIG_REGULATOR_MT6358 is not set
# CONFIG_REGULATOR_MT6359 is not set
CONFIG_REGULATOR_MT6360=y
CONFIG_REGULATOR_MT6397=y
# CONFIG_REGULATOR_PBIAS is not set
CONFIG_REGULATOR_PCA9450=y
# CONFIG_REGULATOR_PCF50633 is not set
# CONFIG_REGULATOR_PF8X00 is not set
# CONFIG_REGULATOR_PFUZE100 is not set
CONFIG_REGULATOR_PV88060=y
# CONFIG_REGULATOR_PV88080 is not set
CONFIG_REGULATOR_PV88090=y
CONFIG_REGULATOR_PWM=y
# CONFIG_REGULATOR_QCOM_RPMH is not set
CONFIG_REGULATOR_QCOM_SMD_RPM=y
CONFIG_REGULATOR_QCOM_SPMI=y
CONFIG_REGULATOR_QCOM_USB_VBUS=y
CONFIG_REGULATOR_RASPBERRYPI_TOUCHSCREEN_ATTINY=y
CONFIG_REGULATOR_RC5T583=y
CONFIG_REGULATOR_ROHM=y
CONFIG_REGULATOR_RT4801=y
CONFIG_REGULATOR_RT5033=y
# CONFIG_REGULATOR_RT5190A is not set
CONFIG_REGULATOR_RT5759=y
CONFIG_REGULATOR_RT6160=y
# CONFIG_REGULATOR_RT6245 is not set
CONFIG_REGULATOR_RTQ2134=y
# CONFIG_REGULATOR_RTMV20 is not set
CONFIG_REGULATOR_RTQ6752=y
CONFIG_REGULATOR_S2MPA01=y
CONFIG_REGULATOR_S2MPS11=y
CONFIG_REGULATOR_S5M8767=y
CONFIG_REGULATOR_SC2731=y
# CONFIG_REGULATOR_SKY81452 is not set
CONFIG_REGULATOR_SLG51000=y
CONFIG_REGULATOR_STM32_BOOSTER=y
# CONFIG_REGULATOR_STM32_VREFBUF is not set
# CONFIG_REGULATOR_STM32_PWR is not set
CONFIG_REGULATOR_TI_ABB=y
# CONFIG_REGULATOR_STW481X_VMMC is not set
# CONFIG_REGULATOR_SY7636A is not set
CONFIG_REGULATOR_SY8106A=y
CONFIG_REGULATOR_SY8824X=y
CONFIG_REGULATOR_SY8827N=y
CONFIG_REGULATOR_TPS51632=y
CONFIG_REGULATOR_TPS6105X=y
CONFIG_REGULATOR_TPS62360=y
CONFIG_REGULATOR_TPS6286X=y
CONFIG_REGULATOR_TPS65023=y
# CONFIG_REGULATOR_TPS6507X is not set
CONFIG_REGULATOR_TPS65086=y
# CONFIG_REGULATOR_TPS65132 is not set
CONFIG_REGULATOR_TPS65218=y
# CONFIG_REGULATOR_TPS65910 is not set
CONFIG_REGULATOR_TPS68470=y
CONFIG_REGULATOR_TWL4030=y
CONFIG_REGULATOR_UNIPHIER=y
CONFIG_REGULATOR_VCTRL=y
CONFIG_REGULATOR_WM831X=y
CONFIG_REGULATOR_WM8350=y
CONFIG_REGULATOR_WM8400=y
CONFIG_REGULATOR_WM8994=y
CONFIG_REGULATOR_QCOM_LABIBB=y
# CONFIG_RC_CORE is not set

#
# CEC support
#
# CONFIG_MEDIA_CEC_SUPPORT is not set
# end of CEC support

CONFIG_MEDIA_SUPPORT=y
# CONFIG_MEDIA_SUPPORT_FILTER is not set
# CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set

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
# CONFIG_MEDIA_CONTROLLER is not set
CONFIG_DVB_CORE=y
# end of Media core support

#
# Digital TV options
#
CONFIG_DVB_MAX_ADAPTERS=16
CONFIG_DVB_DYNAMIC_MINORS=y
# CONFIG_DVB_DEMUX_SECTION_LOSS_LOG is not set
CONFIG_DVB_ULE_DEBUG=y
# end of Digital TV options

#
# Media drivers
#

#
# Media drivers
#
CONFIG_MEDIA_PCI_SUPPORT=y

#
# Media capture support
#

#
# Media capture/analog TV support
#

#
# Media capture/analog/hybrid TV support
#

#
# Media digital TV PCI Adapters
#
CONFIG_DVB_B2C2_FLEXCOP_PCI=y
CONFIG_DVB_B2C2_FLEXCOP_PCI_DEBUG=y
CONFIG_DVB_DDBRIDGE=y
CONFIG_DVB_DDBRIDGE_MSIENABLE=y
CONFIG_DVB_NGENE=y
CONFIG_DVB_PLUTO2=y
CONFIG_DVB_PT1=y
# CONFIG_DVB_PT3 is not set
# CONFIG_DVB_BUDGET_CORE is not set
# CONFIG_MEDIA_PLATFORM_DRIVERS is not set
# CONFIG_DVB_TEST_DRIVERS is not set

#
# FireWire (IEEE 1394) Adapters
#
CONFIG_DVB_FIREDTV=y
CONFIG_DVB_FIREDTV_INPUT=y
CONFIG_DVB_B2C2_FLEXCOP=y
CONFIG_DVB_B2C2_FLEXCOP_DEBUG=y
# end of Media drivers

#
# Media ancillary drivers
#
CONFIG_MEDIA_TUNER=y

#
# Customize TV tuners
#
# CONFIG_MEDIA_TUNER_FC0011 is not set
# CONFIG_MEDIA_TUNER_FC0012 is not set
CONFIG_MEDIA_TUNER_FC0013=y
CONFIG_MEDIA_TUNER_IT913X=y
# CONFIG_MEDIA_TUNER_M88RS6000T is not set
# CONFIG_MEDIA_TUNER_MAX2165 is not set
CONFIG_MEDIA_TUNER_MC44S803=y
CONFIG_MEDIA_TUNER_MT2060=y
CONFIG_MEDIA_TUNER_MT2063=y
# CONFIG_MEDIA_TUNER_MT20XX is not set
CONFIG_MEDIA_TUNER_MT2131=y
CONFIG_MEDIA_TUNER_MT2266=y
# CONFIG_MEDIA_TUNER_MXL301RF is not set
CONFIG_MEDIA_TUNER_MXL5005S=y
CONFIG_MEDIA_TUNER_MXL5007T=y
CONFIG_MEDIA_TUNER_QM1D1B0004=y
# CONFIG_MEDIA_TUNER_QM1D1C0042 is not set
# CONFIG_MEDIA_TUNER_QT1010 is not set
CONFIG_MEDIA_TUNER_R820T=y
# CONFIG_MEDIA_TUNER_SI2157 is not set
CONFIG_MEDIA_TUNER_SIMPLE=y
# CONFIG_MEDIA_TUNER_TDA18212 is not set
CONFIG_MEDIA_TUNER_TDA18218=y
# CONFIG_MEDIA_TUNER_TDA18250 is not set
CONFIG_MEDIA_TUNER_TDA18271=y
CONFIG_MEDIA_TUNER_TDA827X=y
CONFIG_MEDIA_TUNER_TDA8290=y
CONFIG_MEDIA_TUNER_TDA9887=y
# CONFIG_MEDIA_TUNER_TEA5761 is not set
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
CONFIG_DVB_STV090x=y
CONFIG_DVB_STV0910=y
# CONFIG_DVB_STV6110x is not set
# CONFIG_DVB_STV6111 is not set

#
# Multistandard (cable + terrestrial) frontends
#
CONFIG_DVB_DRXK=y
# CONFIG_DVB_MN88472 is not set
# CONFIG_DVB_MN88473 is not set
# CONFIG_DVB_SI2165 is not set
CONFIG_DVB_TDA18271C2DD=y

#
# DVB-S (satellite) frontends
#
CONFIG_DVB_CX24110=y
CONFIG_DVB_CX24116=y
# CONFIG_DVB_CX24117 is not set
# CONFIG_DVB_CX24120 is not set
CONFIG_DVB_CX24123=y
CONFIG_DVB_DS3000=y
# CONFIG_DVB_MB86A16 is not set
CONFIG_DVB_MT312=y
# CONFIG_DVB_S5H1420 is not set
# CONFIG_DVB_SI21XX is not set
CONFIG_DVB_STB6000=y
# CONFIG_DVB_STV0288 is not set
CONFIG_DVB_STV0299=y
CONFIG_DVB_STV0900=y
CONFIG_DVB_STV6110=y
# CONFIG_DVB_TDA10071 is not set
# CONFIG_DVB_TDA10086 is not set
CONFIG_DVB_TDA8083=y
CONFIG_DVB_TDA8261=y
CONFIG_DVB_TDA826X=y
CONFIG_DVB_TS2020=y
# CONFIG_DVB_TUA6100 is not set
# CONFIG_DVB_TUNER_CX24113 is not set
CONFIG_DVB_TUNER_ITD1000=y
CONFIG_DVB_VES1X93=y
# CONFIG_DVB_ZL10036 is not set
# CONFIG_DVB_ZL10039 is not set

#
# DVB-T (terrestrial) frontends
#
CONFIG_DVB_AF9013=y
CONFIG_DVB_CX22700=y
# CONFIG_DVB_CX22702 is not set
# CONFIG_DVB_CXD2820R is not set
CONFIG_DVB_CXD2841ER=y
# CONFIG_DVB_DIB3000MB is not set
# CONFIG_DVB_DIB3000MC is not set
# CONFIG_DVB_DIB7000M is not set
# CONFIG_DVB_DIB7000P is not set
CONFIG_DVB_DIB9000=y
CONFIG_DVB_DRXD=y
# CONFIG_DVB_EC100 is not set
# CONFIG_DVB_L64781 is not set
CONFIG_DVB_MT352=y
CONFIG_DVB_NXT6000=y
CONFIG_DVB_RTL2830=y
CONFIG_DVB_RTL2832=y
# CONFIG_DVB_S5H1432 is not set
CONFIG_DVB_SI2168=y
# CONFIG_DVB_SP887X is not set
CONFIG_DVB_STV0367=y
CONFIG_DVB_TDA10048=y
CONFIG_DVB_TDA1004X=y
# CONFIG_DVB_ZD1301_DEMOD is not set
# CONFIG_DVB_ZL10353 is not set

#
# DVB-C (cable) frontends
#
# CONFIG_DVB_STV0297 is not set
CONFIG_DVB_TDA10021=y
CONFIG_DVB_TDA10023=y
CONFIG_DVB_VES1820=y

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#
# CONFIG_DVB_AU8522_DTV is not set
CONFIG_DVB_BCM3510=y
# CONFIG_DVB_LG2160 is not set
CONFIG_DVB_LGDT3305=y
CONFIG_DVB_LGDT3306A=y
# CONFIG_DVB_LGDT330X is not set
CONFIG_DVB_MXL692=y
CONFIG_DVB_NXT200X=y
CONFIG_DVB_OR51132=y
# CONFIG_DVB_OR51211 is not set
CONFIG_DVB_S5H1409=y
# CONFIG_DVB_S5H1411 is not set

#
# ISDB-T (terrestrial) frontends
#
CONFIG_DVB_DIB8000=y
# CONFIG_DVB_MB86A20S is not set
# CONFIG_DVB_S921 is not set

#
# ISDB-S (satellite) & ISDB-T (terrestrial) frontends
#
# CONFIG_DVB_MN88443X is not set
# CONFIG_DVB_TC90522 is not set

#
# Digital terrestrial only tuners/PLL
#
# CONFIG_DVB_PLL is not set
# CONFIG_DVB_TUNER_DIB0070 is not set
CONFIG_DVB_TUNER_DIB0090=y

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
# CONFIG_DVB_ISL6421 is not set
CONFIG_DVB_ISL6423=y
CONFIG_DVB_IX2505V=y
# CONFIG_DVB_LGS8GL5 is not set
# CONFIG_DVB_LGS8GXX is not set
CONFIG_DVB_LNBH25=y
# CONFIG_DVB_LNBH29 is not set
CONFIG_DVB_LNBP21=y
CONFIG_DVB_LNBP22=y
# CONFIG_DVB_M88RS2000 is not set
# CONFIG_DVB_TDA665x is not set
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
# CONFIG_DVB_DUMMY_FE is not set
# end of Media ancillary drivers

#
# Graphics support
#
CONFIG_APERTURE_HELPERS=y
# CONFIG_IMX_IPUV3_CORE is not set
# CONFIG_DRM is not set

#
# ARM devices
#
# end of ARM devices

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
CONFIG_FIRMWARE_EDID=y
CONFIG_FB_DDC=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_CFB_REV_PIXELS_IN_BYTE=y
CONFIG_FB_SYS_FILLRECT=y
CONFIG_FB_SYS_COPYAREA=y
CONFIG_FB_SYS_IMAGEBLIT=y
CONFIG_FB_FOREIGN_ENDIAN=y
# CONFIG_FB_BOTH_ENDIAN is not set
# CONFIG_FB_BIG_ENDIAN is not set
CONFIG_FB_LITTLE_ENDIAN=y
CONFIG_FB_SYS_FOPS=y
CONFIG_FB_DEFERRED_IO=y
CONFIG_FB_SVGALIB=y
CONFIG_FB_BACKLIGHT=y
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
CONFIG_FB_CIRRUS=y
CONFIG_FB_PM2=y
CONFIG_FB_PM2_FIFO_DISCONNECT=y
# CONFIG_FB_CLPS711X is not set
# CONFIG_FB_IMX is not set
# CONFIG_FB_CYBER2000 is not set
CONFIG_FB_ARC=y
# CONFIG_FB_CONTROL is not set
CONFIG_FB_ASILIANT=y
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_EFI is not set
CONFIG_FB_GBE=y
CONFIG_FB_GBE_MEM=4
CONFIG_FB_PVR2=y
CONFIG_FB_OPENCORES=y
# CONFIG_FB_S1D13XXX is not set
CONFIG_FB_ATMEL=y
CONFIG_FB_NVIDIA=y
CONFIG_FB_NVIDIA_I2C=y
# CONFIG_FB_NVIDIA_DEBUG is not set
CONFIG_FB_NVIDIA_BACKLIGHT=y
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I740 is not set
# CONFIG_FB_MATROX is not set
CONFIG_FB_RADEON=y
CONFIG_FB_RADEON_I2C=y
# CONFIG_FB_RADEON_BACKLIGHT is not set
CONFIG_FB_RADEON_DEBUG=y
CONFIG_FB_ATY128=y
CONFIG_FB_ATY128_BACKLIGHT=y
CONFIG_FB_ATY=y
# CONFIG_FB_ATY_CT is not set
CONFIG_FB_ATY_GX=y
# CONFIG_FB_ATY_BACKLIGHT is not set
CONFIG_FB_S3=y
CONFIG_FB_S3_DDC=y
CONFIG_FB_SAVAGE=y
# CONFIG_FB_SAVAGE_I2C is not set
# CONFIG_FB_SAVAGE_ACCEL is not set
CONFIG_FB_SIS=y
# CONFIG_FB_SIS_300 is not set
CONFIG_FB_SIS_315=y
CONFIG_FB_VIA=y
CONFIG_FB_VIA_DIRECT_PROCFS=y
# CONFIG_FB_VIA_X_COMPATIBILITY is not set
# CONFIG_FB_NEOMAGIC is not set
CONFIG_FB_KYRO=y
CONFIG_FB_3DFX=y
CONFIG_FB_3DFX_ACCEL=y
# CONFIG_FB_3DFX_I2C is not set
# CONFIG_FB_VOODOO1 is not set
CONFIG_FB_VT8623=y
CONFIG_FB_TRIDENT=y
CONFIG_FB_ARK=y
CONFIG_FB_PM3=y
# CONFIG_FB_CARMINE is not set
# CONFIG_FB_WM8505 is not set
CONFIG_FB_PXA168=y
CONFIG_FB_W100=y
# CONFIG_FB_SH_MOBILE_LCDC is not set
CONFIG_FB_TMIO=y
CONFIG_FB_TMIO_ACCELL=y
# CONFIG_FB_S3C is not set
# CONFIG_FB_IBM_GXT4500 is not set
CONFIG_FB_GOLDFISH=y
CONFIG_FB_DA8XX=y
# CONFIG_FB_VIRTUAL is not set
CONFIG_FB_METRONOME=y
CONFIG_FB_MB862XX=y
CONFIG_FB_MB862XX_PCI_GDC=y
CONFIG_FB_MB862XX_I2C=y
CONFIG_FB_BROADSHEET=y
CONFIG_FB_SIMPLE=y
CONFIG_FB_SSD1307=y
CONFIG_FB_SM712=y
CONFIG_FB_OMAP2=y
CONFIG_FB_OMAP2_DEBUG_SUPPORT=y
CONFIG_FB_OMAP2_NUM_FBS=3
CONFIG_FB_OMAP2_DSS_INIT=y
CONFIG_FB_OMAP2_DSS=y
CONFIG_FB_OMAP2_DSS_DEBUG=y
CONFIG_FB_OMAP2_DSS_DEBUGFS=y
# CONFIG_FB_OMAP2_DSS_COLLECT_IRQ_STATS is not set
CONFIG_FB_OMAP2_DSS_DPI=y
CONFIG_FB_OMAP2_DSS_VENC=y
# CONFIG_FB_OMAP4_DSS_HDMI is not set
# CONFIG_FB_OMAP5_DSS_HDMI is not set
# CONFIG_FB_OMAP2_DSS_SDI is not set
CONFIG_FB_OMAP2_DSS_DSI=y
CONFIG_FB_OMAP2_DSS_MIN_FCK_PER_PCK=0
CONFIG_FB_OMAP2_DSS_SLEEP_AFTER_VENC_RESET=y

#
# OMAPFB Panel and Encoder Drivers
#
# CONFIG_FB_OMAP2_ENCODER_OPA362 is not set
CONFIG_FB_OMAP2_ENCODER_TFP410=y
# CONFIG_FB_OMAP2_ENCODER_TPD12S015 is not set
CONFIG_FB_OMAP2_CONNECTOR_DVI=y
CONFIG_FB_OMAP2_CONNECTOR_HDMI=y
CONFIG_FB_OMAP2_CONNECTOR_ANALOG_TV=y
# CONFIG_FB_OMAP2_PANEL_DPI is not set
CONFIG_FB_OMAP2_PANEL_DSI_CM=y
CONFIG_FB_OMAP2_PANEL_SHARP_LS037V7DW01=y
# end of OMAPFB Panel and Encoder Drivers

# CONFIG_MMP_DISP is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=y
# CONFIG_LCD_PLATFORM is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
CONFIG_BACKLIGHT_ATMEL_LCDC=y
CONFIG_BACKLIGHT_KTD253=y
CONFIG_BACKLIGHT_LM3533=y
CONFIG_BACKLIGHT_OMAP1=y
CONFIG_BACKLIGHT_PWM=y
CONFIG_BACKLIGHT_QCOM_WLED=y
# CONFIG_BACKLIGHT_WM831X is not set
CONFIG_BACKLIGHT_ADP8860=y
CONFIG_BACKLIGHT_ADP8870=y
CONFIG_BACKLIGHT_88PM860X=y
# CONFIG_BACKLIGHT_PCF50633 is not set
CONFIG_BACKLIGHT_AAT2870=y
# CONFIG_BACKLIGHT_LM3630A is not set
CONFIG_BACKLIGHT_LM3639=y
# CONFIG_BACKLIGHT_LP855X is not set
CONFIG_BACKLIGHT_LP8788=y
# CONFIG_BACKLIGHT_PANDORA is not set
# CONFIG_BACKLIGHT_SKY81452 is not set
CONFIG_BACKLIGHT_AS3711=y
# CONFIG_BACKLIGHT_GPIO is not set
CONFIG_BACKLIGHT_LV5207LP=y
CONFIG_BACKLIGHT_BD6107=y
CONFIG_BACKLIGHT_ARCXCNN=y
CONFIG_BACKLIGHT_LED=y
# end of Backlight & LCD device support

CONFIG_VGASTATE=y
CONFIG_VIDEOMODE_HELPERS=y
CONFIG_HDMI=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
# CONFIG_FRAMEBUFFER_CONSOLE is not set
# end of Console display driver support

# CONFIG_LOGO is not set
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
# CONFIG_SND_HRTIMER is not set
CONFIG_SND_DYNAMIC_MINORS=y
CONFIG_SND_MAX_CARDS=32
CONFIG_SND_SUPPORT_OLD_API=y
CONFIG_SND_PROC_FS=y
CONFIG_SND_VERBOSE_PROCFS=y
CONFIG_SND_VERBOSE_PRINTK=y
CONFIG_SND_CTL_FAST_LOOKUP=y
# CONFIG_SND_DEBUG is not set
# CONFIG_SND_CTL_INPUT_VALIDATION is not set
CONFIG_SND_VMASTER=y
CONFIG_SND_CTL_LED=y
# CONFIG_SND_SEQUENCER is not set
CONFIG_SND_MPU401_UART=y
CONFIG_SND_OPL3_LIB=y
CONFIG_SND_AC97_CODEC=y
CONFIG_SND_DRIVERS=y
# CONFIG_SND_DUMMY is not set
# CONFIG_SND_ALOOP is not set
CONFIG_SND_MTPAV=y
CONFIG_SND_SERIAL_U16550=y
CONFIG_SND_MPU401=y
CONFIG_SND_AC97_POWER_SAVE=y
CONFIG_SND_AC97_POWER_SAVE_DEFAULT=0
CONFIG_SND_PCI=y
# CONFIG_SND_AD1889 is not set
CONFIG_SND_ATIIXP=y
CONFIG_SND_ATIIXP_MODEM=y
# CONFIG_SND_AU8810 is not set
CONFIG_SND_AU8820=y
CONFIG_SND_AU8830=y
# CONFIG_SND_AW2 is not set
CONFIG_SND_BT87X=y
# CONFIG_SND_BT87X_OVERCLOCK is not set
CONFIG_SND_CA0106=y
# CONFIG_SND_CMIPCI is not set
CONFIG_SND_OXYGEN_LIB=y
CONFIG_SND_OXYGEN=y
CONFIG_SND_CS4281=y
CONFIG_SND_CS46XX=y
CONFIG_SND_CS46XX_NEW_DSP=y
CONFIG_SND_CS5535AUDIO=y
# CONFIG_SND_CTXFI is not set
CONFIG_SND_DARLA20=y
# CONFIG_SND_GINA20 is not set
CONFIG_SND_LAYLA20=y
CONFIG_SND_DARLA24=y
CONFIG_SND_GINA24=y
CONFIG_SND_LAYLA24=y
# CONFIG_SND_MONA is not set
# CONFIG_SND_MIA is not set
CONFIG_SND_ECHO3G=y
CONFIG_SND_INDIGO=y
CONFIG_SND_INDIGOIO=y
# CONFIG_SND_INDIGODJ is not set
# CONFIG_SND_INDIGOIOX is not set
# CONFIG_SND_INDIGODJX is not set
# CONFIG_SND_ENS1370 is not set
CONFIG_SND_ENS1371=y
CONFIG_SND_FM801=y
CONFIG_SND_HDSP=y

#
# Don't forget to add built-in firmwares for HDSP driver
#
CONFIG_SND_HDSPM=y
# CONFIG_SND_ICE1724 is not set
# CONFIG_SND_INTEL8X0 is not set
CONFIG_SND_INTEL8X0M=y
CONFIG_SND_KORG1212=y
CONFIG_SND_LOLA=y
CONFIG_SND_LX6464ES=y
CONFIG_SND_MIXART=y
CONFIG_SND_NM256=y
CONFIG_SND_PCXHR=y
# CONFIG_SND_RIPTIDE is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
CONFIG_SND_RME9652=y
# CONFIG_SND_VIA82XX is not set
# CONFIG_SND_VIA82XX_MODEM is not set
CONFIG_SND_VIRTUOSO=y
# CONFIG_SND_VX222 is not set
CONFIG_SND_YMFPCI=y

#
# HD-Audio
#
CONFIG_SND_HDA=y
CONFIG_SND_HDA_GENERIC_LEDS=y
CONFIG_SND_HDA_INTEL=y
CONFIG_SND_HDA_HWDEP=y
# CONFIG_SND_HDA_RECONFIG is not set
# CONFIG_SND_HDA_INPUT_BEEP is not set
# CONFIG_SND_HDA_PATCH_LOADER is not set
CONFIG_SND_HDA_SCODEC_CS35L41=y
CONFIG_SND_HDA_CS_DSP_CONTROLS=y
CONFIG_SND_HDA_SCODEC_CS35L41_I2C=y
CONFIG_SND_HDA_CODEC_REALTEK=y
# CONFIG_SND_HDA_CODEC_ANALOG is not set
# CONFIG_SND_HDA_CODEC_SIGMATEL is not set
CONFIG_SND_HDA_CODEC_VIA=y
CONFIG_SND_HDA_CODEC_HDMI=y
CONFIG_SND_HDA_CODEC_CIRRUS=y
# CONFIG_SND_HDA_CODEC_CS8409 is not set
# CONFIG_SND_HDA_CODEC_CONEXANT is not set
# CONFIG_SND_HDA_CODEC_CA0110 is not set
CONFIG_SND_HDA_CODEC_CA0132=y
# CONFIG_SND_HDA_CODEC_CA0132_DSP is not set
CONFIG_SND_HDA_CODEC_CMEDIA=y
# CONFIG_SND_HDA_CODEC_SI3054 is not set
CONFIG_SND_HDA_GENERIC=y
CONFIG_SND_HDA_INTEL_HDMI_SILENT_STREAM=y
# end of HD-Audio

CONFIG_SND_HDA_CORE=y
CONFIG_SND_HDA_DSP_LOADER=y
CONFIG_SND_HDA_EXT_CORE=y
CONFIG_SND_HDA_PREALLOC_SIZE=64
CONFIG_SND_INTEL_NHLT=y
CONFIG_SND_INTEL_DSP_CONFIG=y
CONFIG_SND_INTEL_SOUNDWIRE_ACPI=y
CONFIG_SND_PXA2XX_LIB=y
# CONFIG_SND_FIREWIRE is not set
# CONFIG_SND_PCMCIA is not set
CONFIG_SND_SOC=y
CONFIG_SND_SOC_GENERIC_DMAENGINE_PCM=y
CONFIG_SND_SOC_COMPRESS=y
CONFIG_SND_SOC_TOPOLOGY=y
CONFIG_SND_SOC_ACPI=y
CONFIG_SND_SOC_ADI=y
# CONFIG_SND_SOC_ADI_AXI_I2S is not set
CONFIG_SND_SOC_ADI_AXI_SPDIF=y
# CONFIG_SND_SOC_AMD_ACP is not set
CONFIG_SND_AMD_ACP_CONFIG=y
CONFIG_SND_ATMEL_SOC=y
CONFIG_SND_ATMEL_SOC_PDC=y
CONFIG_SND_ATMEL_SOC_DMA=y
CONFIG_SND_ATMEL_SOC_SSC=y
CONFIG_SND_ATMEL_SOC_SSC_PDC=y
CONFIG_SND_ATMEL_SOC_SSC_DMA=y
CONFIG_SND_AT91_SOC_SAM9G20_WM8731=y
CONFIG_SND_ATMEL_SOC_WM8904=y
CONFIG_SND_AT91_SOC_SAM9X5_WM8731=y
# CONFIG_SND_ATMEL_SOC_CLASSD is not set
# CONFIG_SND_ATMEL_SOC_PDMIC is not set
CONFIG_SND_ATMEL_SOC_I2S=y
CONFIG_SND_SOC_MIKROE_PROTO=y
CONFIG_SND_MCHP_SOC_I2S_MCC=y
# CONFIG_SND_MCHP_SOC_SPDIFTX is not set
# CONFIG_SND_MCHP_SOC_SPDIFRX is not set
CONFIG_SND_MCHP_SOC_PDMC=y
CONFIG_SND_BCM2835_SOC_I2S=y
# CONFIG_SND_SOC_CYGNUS is not set
CONFIG_SND_BCM63XX_I2S_WHISTLER=y
# CONFIG_SND_EP93XX_SOC is not set
CONFIG_SND_DESIGNWARE_I2S=y
# CONFIG_SND_DESIGNWARE_PCM is not set

#
# SoC Audio for Freescale CPUs
#

#
# Common SoC Audio options for Freescale CPUs:
#
CONFIG_SND_SOC_FSL_ASRC=y
CONFIG_SND_SOC_FSL_SAI=y
CONFIG_SND_SOC_FSL_MQS=y
CONFIG_SND_SOC_FSL_AUDMIX=y
CONFIG_SND_SOC_FSL_SSI=y
CONFIG_SND_SOC_FSL_SPDIF=y
# CONFIG_SND_SOC_FSL_ESAI is not set
CONFIG_SND_SOC_FSL_MICFIL=y
# CONFIG_SND_SOC_FSL_EASRC is not set
# CONFIG_SND_SOC_FSL_XCVR is not set
CONFIG_SND_SOC_FSL_AUD2HTX=y
CONFIG_SND_SOC_FSL_UTILS=y
# CONFIG_SND_SOC_FSL_RPMSG is not set
CONFIG_SND_SOC_IMX_PCM_DMA=y
# CONFIG_SND_SOC_IMX_AUDMUX is not set
CONFIG_SND_IMX_SOC=y

#
# SoC Audio support for Freescale i.MX boards:
#
# CONFIG_SND_SOC_IMX_ES8328 is not set
# CONFIG_SND_SOC_IMX_SGTL5000 is not set
CONFIG_SND_SOC_IMX_SPDIF=y
# CONFIG_SND_SOC_FSL_ASOC_CARD is not set
# CONFIG_SND_SOC_IMX_AUDMIX is not set
CONFIG_SND_SOC_IMX_HDMI=y
# CONFIG_SND_SOC_IMX_RPMSG is not set
CONFIG_SND_SOC_IMX_CARD=y
# end of SoC Audio for Freescale CPUs

CONFIG_SND_I2S_HI6210_I2S=y
CONFIG_SND_JZ4740_SOC_I2S=y
CONFIG_SND_KIRKWOOD_SOC=y
CONFIG_SND_KIRKWOOD_SOC_ARMADA370_DB=y
CONFIG_SND_SOC_IMG=y
CONFIG_SND_SOC_IMG_I2S_IN=y
CONFIG_SND_SOC_IMG_I2S_OUT=y
CONFIG_SND_SOC_IMG_PARALLEL_OUT=y
CONFIG_SND_SOC_IMG_SPDIF_IN=y
# CONFIG_SND_SOC_IMG_SPDIF_OUT is not set
# CONFIG_SND_SOC_IMG_PISTACHIO_INTERNAL_DAC is not set
CONFIG_SND_SOC_INTEL_SST_TOPLEVEL=y
CONFIG_SND_SOC_INTEL_SST=y
CONFIG_SND_SOC_INTEL_SKYLAKE=y
CONFIG_SND_SOC_INTEL_SKL=y
CONFIG_SND_SOC_INTEL_APL=y
CONFIG_SND_SOC_INTEL_KBL=y
CONFIG_SND_SOC_INTEL_GLK=y
CONFIG_SND_SOC_INTEL_CNL=y
CONFIG_SND_SOC_INTEL_CFL=y
# CONFIG_SND_SOC_INTEL_CML_H is not set
CONFIG_SND_SOC_INTEL_CML_LP=y
CONFIG_SND_SOC_INTEL_SKYLAKE_FAMILY=y
CONFIG_SND_SOC_INTEL_SKYLAKE_SSP_CLK=y
CONFIG_SND_SOC_INTEL_SKYLAKE_HDAUDIO_CODEC=y
CONFIG_SND_SOC_INTEL_SKYLAKE_COMMON=y
CONFIG_SND_SOC_ACPI_INTEL_MATCH=y
# CONFIG_SND_SOC_INTEL_KEEMBAY is not set
# CONFIG_SND_SOC_INTEL_AVS is not set
CONFIG_SND_SOC_INTEL_MACH=y
CONFIG_SND_SOC_INTEL_USER_FRIENDLY_LONG_NAMES=y
CONFIG_SND_SOC_INTEL_HDA_DSP_COMMON=y
CONFIG_SND_SOC_INTEL_SKL_RT286_MACH=y
CONFIG_SND_SOC_INTEL_SKL_NAU88L25_SSM4567_MACH=y
# CONFIG_SND_SOC_INTEL_SKL_NAU88L25_MAX98357A_MACH is not set
CONFIG_SND_SOC_INTEL_DA7219_MAX98357A_GENERIC=y
CONFIG_SND_SOC_INTEL_BXT_DA7219_MAX98357A_COMMON=y
CONFIG_SND_SOC_INTEL_BXT_DA7219_MAX98357A_MACH=y
CONFIG_SND_SOC_INTEL_BXT_RT298_MACH=y
CONFIG_SND_SOC_INTEL_KBL_RT5663_MAX98927_MACH=y
CONFIG_SND_SOC_INTEL_KBL_DA7219_MAX98357A_MACH=y
CONFIG_SND_SOC_INTEL_KBL_DA7219_MAX98927_MACH=y
# CONFIG_SND_SOC_INTEL_KBL_RT5660_MACH is not set
CONFIG_SND_SOC_INTEL_SKL_HDA_DSP_GENERIC_MACH=y
CONFIG_SND_SOC_MEDIATEK=y
# CONFIG_SND_SOC_MT8186 is not set
# CONFIG_SND_SOC_MTK_BTCVSD is not set
CONFIG_SND_SOC_MT8195=y

#
# ASoC support for Amlogic platforms
#
# CONFIG_SND_MESON_AIU is not set
CONFIG_SND_MESON_AXG_FIFO=y
CONFIG_SND_MESON_AXG_FRDDR=y
CONFIG_SND_MESON_AXG_TODDR=y
CONFIG_SND_MESON_AXG_TDM_FORMATTER=y
CONFIG_SND_MESON_AXG_TDM_INTERFACE=y
# CONFIG_SND_MESON_AXG_TDMIN is not set
CONFIG_SND_MESON_AXG_TDMOUT=y
CONFIG_SND_MESON_AXG_SOUND_CARD=y
CONFIG_SND_MESON_AXG_SPDIFOUT=y
# CONFIG_SND_MESON_AXG_SPDIFIN is not set
# CONFIG_SND_MESON_AXG_PDM is not set
CONFIG_SND_MESON_CARD_UTILS=y
CONFIG_SND_MESON_CODEC_GLUE=y
CONFIG_SND_MESON_GX_SOUND_CARD=y
CONFIG_SND_MESON_G12A_TOACODEC=y
CONFIG_SND_MESON_G12A_TOHDMITX=y
CONFIG_SND_SOC_MESON_T9015=y
# end of ASoC support for Amlogic platforms

CONFIG_SND_MXS_SOC=y
# CONFIG_SND_SOC_MXS_SGTL5000 is not set
CONFIG_SND_PXA2XX_SOC=y
CONFIG_SND_SOC_QCOM=y
CONFIG_SND_SOC_LPASS_CPU=y
CONFIG_SND_SOC_LPASS_HDMI=y
CONFIG_SND_SOC_LPASS_PLATFORM=y
CONFIG_SND_SOC_LPASS_CDC_DMA=y
CONFIG_SND_SOC_LPASS_SC7180=y
CONFIG_SND_SOC_LPASS_SC7280=y
# CONFIG_SND_SOC_STORM is not set
# CONFIG_SND_SOC_APQ8016_SBC is not set
CONFIG_SND_SOC_QCOM_COMMON=y
CONFIG_SND_SOC_SC7180=y
CONFIG_SND_SOC_SC7280=y
CONFIG_SND_SOC_ROCKCHIP=y
CONFIG_SND_SOC_ROCKCHIP_I2S=y
CONFIG_SND_SOC_ROCKCHIP_I2S_TDM=y
# CONFIG_SND_SOC_ROCKCHIP_PDM is not set
CONFIG_SND_SOC_ROCKCHIP_SPDIF=y
CONFIG_SND_SOC_ROCKCHIP_MAX98090=y
# CONFIG_SND_SOC_ROCKCHIP_RT5645 is not set
CONFIG_SND_SOC_RK3288_HDMI_ANALOG=y
# CONFIG_SND_SOC_SAMSUNG is not set

#
# SoC Audio support for Renesas SoCs
#
CONFIG_SND_SOC_SH4_FSI=y
# CONFIG_SND_SOC_RCAR is not set
CONFIG_SND_SOC_RZ=y
# end of SoC Audio support for Renesas SoCs

# CONFIG_SND_SOC_SOF_TOPLEVEL is not set
CONFIG_SND_SOC_SPRD=y
# CONFIG_SND_SOC_SPRD_MCDT is not set
CONFIG_SND_SOC_STI=y

#
# STMicroelectronics STM32 SOC audio support
#
CONFIG_SND_SOC_STM32_SAI=y
# CONFIG_SND_SOC_STM32_I2S is not set
CONFIG_SND_SOC_STM32_SPDIFRX=y
# end of STMicroelectronics STM32 SOC audio support

#
# Allwinner SoC Audio support
#
CONFIG_SND_SUN4I_CODEC=y
CONFIG_SND_SUN8I_CODEC=y
CONFIG_SND_SUN8I_CODEC_ANALOG=y
CONFIG_SND_SUN50I_CODEC_ANALOG=y
# CONFIG_SND_SUN4I_I2S is not set
CONFIG_SND_SUN4I_SPDIF=y
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
CONFIG_SND_SOC_DAVINCI_ASP=y
CONFIG_SND_SOC_DAVINCI_MCASP=y
# CONFIG_SND_SOC_DAVINCI_VCIF is not set
# CONFIG_SND_SOC_OMAP_DMIC is not set
CONFIG_SND_SOC_OMAP_MCBSP=y
CONFIG_SND_SOC_OMAP_MCPDM=y

#
# Audio support for boards with Texas Instruments SoCs
#
# CONFIG_SND_SOC_OMAP3_TWL4030 is not set
# CONFIG_SND_SOC_OMAP_HDMI is not set
CONFIG_SND_SOC_J721E_EVM=y
# end of Audio support for Texas Instruments SoCs

CONFIG_SND_SOC_UNIPHIER=y
CONFIG_SND_SOC_UNIPHIER_AIO=y
CONFIG_SND_SOC_UNIPHIER_LD11=y
CONFIG_SND_SOC_UNIPHIER_PXS2=y
CONFIG_SND_SOC_UNIPHIER_EVEA_CODEC=y
CONFIG_SND_SOC_XILINX_I2S=y
# CONFIG_SND_SOC_XILINX_AUDIO_FORMATTER is not set
CONFIG_SND_SOC_XILINX_SPDIF=y
CONFIG_SND_SOC_XTFPGA_I2S=y
CONFIG_SND_SOC_I2C_AND_SPI=y

#
# CODEC drivers
#
CONFIG_SND_SOC_ALL_CODECS=y
CONFIG_SND_SOC_88PM860X=y
CONFIG_SND_SOC_WM_HUBS=y
CONFIG_SND_SOC_WM_ADSP=y
# CONFIG_SND_SOC_AB8500_CODEC is not set
# CONFIG_SND_SOC_AC97_CODEC is not set
# CONFIG_SND_SOC_AD1836 is not set
CONFIG_SND_SOC_AD193X=y
# CONFIG_SND_SOC_AD193X_SPI is not set
CONFIG_SND_SOC_AD193X_I2C=y
# CONFIG_SND_SOC_AD1980 is not set
CONFIG_SND_SOC_AD73311=y
CONFIG_SND_SOC_ADAU_UTILS=y
CONFIG_SND_SOC_ADAU1372=y
CONFIG_SND_SOC_ADAU1372_I2C=y
# CONFIG_SND_SOC_ADAU1372_SPI is not set
CONFIG_SND_SOC_ADAU1373=y
# CONFIG_SND_SOC_ADAU1701 is not set
CONFIG_SND_SOC_ADAU17X1=y
# CONFIG_SND_SOC_ADAU1761_I2C is not set
# CONFIG_SND_SOC_ADAU1761_SPI is not set
CONFIG_SND_SOC_ADAU1781=y
CONFIG_SND_SOC_ADAU1781_I2C=y
# CONFIG_SND_SOC_ADAU1781_SPI is not set
CONFIG_SND_SOC_ADAU1977=y
# CONFIG_SND_SOC_ADAU1977_SPI is not set
CONFIG_SND_SOC_ADAU1977_I2C=y
CONFIG_SND_SOC_ADAU7002=y
CONFIG_SND_SOC_ADAU7118=y
CONFIG_SND_SOC_ADAU7118_HW=y
CONFIG_SND_SOC_ADAU7118_I2C=y
CONFIG_SND_SOC_ADAV80X=y
# CONFIG_SND_SOC_ADAV801 is not set
CONFIG_SND_SOC_ADAV803=y
CONFIG_SND_SOC_ADS117X=y
# CONFIG_SND_SOC_AK4104 is not set
# CONFIG_SND_SOC_AK4118 is not set
# CONFIG_SND_SOC_AK4375 is not set
CONFIG_SND_SOC_AK4458=y
CONFIG_SND_SOC_AK4535=y
CONFIG_SND_SOC_AK4554=y
CONFIG_SND_SOC_AK4613=y
CONFIG_SND_SOC_AK4641=y
# CONFIG_SND_SOC_AK4642 is not set
CONFIG_SND_SOC_AK4671=y
# CONFIG_SND_SOC_AK5386 is not set
CONFIG_SND_SOC_AK5558=y
# CONFIG_SND_SOC_ALC5623 is not set
CONFIG_SND_SOC_ALC5632=y
CONFIG_SND_SOC_AW8738=y
# CONFIG_SND_SOC_BD28623 is not set
CONFIG_SND_SOC_BT_SCO=y
CONFIG_SND_SOC_CQ0093VC=y
# CONFIG_SND_SOC_CROS_EC_CODEC is not set
CONFIG_SND_SOC_CS35L32=y
# CONFIG_SND_SOC_CS35L33 is not set
# CONFIG_SND_SOC_CS35L34 is not set
CONFIG_SND_SOC_CS35L35=y
CONFIG_SND_SOC_CS35L36=y
CONFIG_SND_SOC_CS35L41_LIB=y
# CONFIG_SND_SOC_CS35L41_SPI is not set
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
CONFIG_SND_SOC_CS4270=y
CONFIG_SND_SOC_CS4271=y
CONFIG_SND_SOC_CS4271_I2C=y
# CONFIG_SND_SOC_CS4271_SPI is not set
CONFIG_SND_SOC_CS42XX8=y
CONFIG_SND_SOC_CS42XX8_I2C=y
CONFIG_SND_SOC_CS43130=y
# CONFIG_SND_SOC_CS4341 is not set
CONFIG_SND_SOC_CS4349=y
# CONFIG_SND_SOC_CS47L15 is not set
# CONFIG_SND_SOC_CS47L24 is not set
CONFIG_SND_SOC_CS47L35=y
CONFIG_SND_SOC_CS47L85=y
# CONFIG_SND_SOC_CS47L90 is not set
# CONFIG_SND_SOC_CS47L92 is not set
CONFIG_SND_SOC_CS53L30=y
CONFIG_SND_SOC_CX20442=y
# CONFIG_SND_SOC_CX2072X is not set
CONFIG_SND_SOC_JZ4740_CODEC=y
# CONFIG_SND_SOC_JZ4725B_CODEC is not set
# CONFIG_SND_SOC_JZ4760_CODEC is not set
CONFIG_SND_SOC_JZ4770_CODEC=y
CONFIG_SND_SOC_L3=y
CONFIG_SND_SOC_DA7210=y
CONFIG_SND_SOC_DA7213=y
CONFIG_SND_SOC_DA7218=y
CONFIG_SND_SOC_DA7219=y
CONFIG_SND_SOC_DA732X=y
CONFIG_SND_SOC_DA9055=y
CONFIG_SND_SOC_DMIC=y
CONFIG_SND_SOC_HDMI_CODEC=y
CONFIG_SND_SOC_ES7134=y
CONFIG_SND_SOC_ES7241=y
CONFIG_SND_SOC_ES8316=y
CONFIG_SND_SOC_ES8328=y
CONFIG_SND_SOC_ES8328_I2C=y
# CONFIG_SND_SOC_ES8328_SPI is not set
CONFIG_SND_SOC_GTM601=y
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
# CONFIG_SND_SOC_MAX98504 is not set
CONFIG_SND_SOC_MAX9867=y
CONFIG_SND_SOC_MAX98925=y
CONFIG_SND_SOC_MAX98926=y
CONFIG_SND_SOC_MAX98927=y
# CONFIG_SND_SOC_MAX98520 is not set
CONFIG_SND_SOC_MAX98373=y
CONFIG_SND_SOC_MAX98373_I2C=y
CONFIG_SND_SOC_MAX98373_SDW=y
CONFIG_SND_SOC_MAX98390=y
CONFIG_SND_SOC_MAX98396=y
CONFIG_SND_SOC_MAX9850=y
# CONFIG_SND_SOC_MAX9860 is not set
CONFIG_SND_SOC_MSM8916_WCD_ANALOG=y
CONFIG_SND_SOC_MSM8916_WCD_DIGITAL=y
CONFIG_SND_SOC_PCM1681=y
# CONFIG_SND_SOC_PCM1789_I2C is not set
CONFIG_SND_SOC_PCM179X=y
CONFIG_SND_SOC_PCM179X_I2C=y
# CONFIG_SND_SOC_PCM179X_SPI is not set
CONFIG_SND_SOC_PCM186X=y
CONFIG_SND_SOC_PCM186X_I2C=y
# CONFIG_SND_SOC_PCM186X_SPI is not set
CONFIG_SND_SOC_PCM3008=y
CONFIG_SND_SOC_PCM3060=y
CONFIG_SND_SOC_PCM3060_I2C=y
# CONFIG_SND_SOC_PCM3060_SPI is not set
CONFIG_SND_SOC_PCM3168A=y
CONFIG_SND_SOC_PCM3168A_I2C=y
# CONFIG_SND_SOC_PCM3168A_SPI is not set
# CONFIG_SND_SOC_PCM5102A is not set
CONFIG_SND_SOC_PCM512x=y
CONFIG_SND_SOC_PCM512x_I2C=y
# CONFIG_SND_SOC_PCM512x_SPI is not set
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
# CONFIG_SND_SOC_RT1316_SDW is not set
CONFIG_SND_SOC_RT5514=y
CONFIG_SND_SOC_RT5616=y
# CONFIG_SND_SOC_RT5631 is not set
CONFIG_SND_SOC_RT5640=y
CONFIG_SND_SOC_RT5645=y
CONFIG_SND_SOC_RT5651=y
# CONFIG_SND_SOC_RT5659 is not set
CONFIG_SND_SOC_RT5660=y
CONFIG_SND_SOC_RT5663=y
CONFIG_SND_SOC_RT5665=y
CONFIG_SND_SOC_RT5668=y
CONFIG_SND_SOC_RT5670=y
CONFIG_SND_SOC_RT5677=y
CONFIG_SND_SOC_RT5682=y
CONFIG_SND_SOC_RT5682_I2C=y
CONFIG_SND_SOC_RT5682_SDW=y
CONFIG_SND_SOC_RT5682S=y
# CONFIG_SND_SOC_RT700_SDW is not set
CONFIG_SND_SOC_RT711=y
CONFIG_SND_SOC_RT711_SDW=y
CONFIG_SND_SOC_RT711_SDCA_SDW=y
CONFIG_SND_SOC_RT715=y
CONFIG_SND_SOC_RT715_SDW=y
CONFIG_SND_SOC_RT715_SDCA_SDW=y
CONFIG_SND_SOC_RT9120=y
# CONFIG_SND_SOC_SDW_MOCKUP is not set
CONFIG_SND_SOC_SGTL5000=y
CONFIG_SND_SOC_SI476X=y
CONFIG_SND_SOC_SIGMADSP=y
CONFIG_SND_SOC_SIGMADSP_REGMAP=y
CONFIG_SND_SOC_SIMPLE_AMPLIFIER=y
CONFIG_SND_SOC_SIMPLE_MUX=y
CONFIG_SND_SOC_SPDIF=y
CONFIG_SND_SOC_SSM2305=y
# CONFIG_SND_SOC_SSM2518 is not set
# CONFIG_SND_SOC_SSM2602_SPI is not set
# CONFIG_SND_SOC_SSM2602_I2C is not set
CONFIG_SND_SOC_SSM4567=y
# CONFIG_SND_SOC_STA32X is not set
CONFIG_SND_SOC_STA350=y
CONFIG_SND_SOC_STA529=y
# CONFIG_SND_SOC_STAC9766 is not set
CONFIG_SND_SOC_STI_SAS=y
# CONFIG_SND_SOC_TAS2552 is not set
CONFIG_SND_SOC_TAS2562=y
# CONFIG_SND_SOC_TAS2764 is not set
# CONFIG_SND_SOC_TAS2770 is not set
CONFIG_SND_SOC_TAS2780=y
# CONFIG_SND_SOC_TAS5086 is not set
# CONFIG_SND_SOC_TAS571X is not set
CONFIG_SND_SOC_TAS5720=y
CONFIG_SND_SOC_TAS5805M=y
# CONFIG_SND_SOC_TAS6424 is not set
CONFIG_SND_SOC_TDA7419=y
# CONFIG_SND_SOC_TFA9879 is not set
CONFIG_SND_SOC_TFA989X=y
CONFIG_SND_SOC_TLV320ADC3XXX=y
CONFIG_SND_SOC_TLV320AIC23=y
CONFIG_SND_SOC_TLV320AIC23_I2C=y
# CONFIG_SND_SOC_TLV320AIC23_SPI is not set
# CONFIG_SND_SOC_TLV320AIC26 is not set
# CONFIG_SND_SOC_TLV320AIC31XX is not set
CONFIG_SND_SOC_TLV320AIC32X4=y
CONFIG_SND_SOC_TLV320AIC32X4_I2C=y
# CONFIG_SND_SOC_TLV320AIC32X4_SPI is not set
CONFIG_SND_SOC_TLV320AIC3X=y
CONFIG_SND_SOC_TLV320AIC3X_I2C=y
# CONFIG_SND_SOC_TLV320AIC3X_SPI is not set
CONFIG_SND_SOC_TLV320DAC33=y
CONFIG_SND_SOC_TLV320ADCX140=y
CONFIG_SND_SOC_TS3A227E=y
# CONFIG_SND_SOC_TSCS42XX is not set
CONFIG_SND_SOC_TSCS454=y
CONFIG_SND_SOC_TWL4030=y
# CONFIG_SND_SOC_TWL6040 is not set
# CONFIG_SND_SOC_UDA1334 is not set
CONFIG_SND_SOC_UDA134X=y
CONFIG_SND_SOC_UDA1380=y
CONFIG_SND_SOC_WCD9335=y
CONFIG_SND_SOC_WCD_MBHC=y
# CONFIG_SND_SOC_WCD934X is not set
CONFIG_SND_SOC_WCD938X=y
CONFIG_SND_SOC_WCD938X_SDW=y
CONFIG_SND_SOC_WL1273=y
# CONFIG_SND_SOC_WM0010 is not set
CONFIG_SND_SOC_WM1250_EV1=y
CONFIG_SND_SOC_WM2000=y
CONFIG_SND_SOC_WM2200=y
CONFIG_SND_SOC_WM5100=y
# CONFIG_SND_SOC_WM5102 is not set
# CONFIG_SND_SOC_WM5110 is not set
CONFIG_SND_SOC_WM8350=y
CONFIG_SND_SOC_WM8400=y
CONFIG_SND_SOC_WM8510=y
# CONFIG_SND_SOC_WM8523 is not set
# CONFIG_SND_SOC_WM8524 is not set
CONFIG_SND_SOC_WM8580=y
# CONFIG_SND_SOC_WM8711 is not set
CONFIG_SND_SOC_WM8727=y
CONFIG_SND_SOC_WM8728=y
CONFIG_SND_SOC_WM8731=y
CONFIG_SND_SOC_WM8731_I2C=y
# CONFIG_SND_SOC_WM8731_SPI is not set
# CONFIG_SND_SOC_WM8737 is not set
CONFIG_SND_SOC_WM8741=y
CONFIG_SND_SOC_WM8750=y
CONFIG_SND_SOC_WM8753=y
# CONFIG_SND_SOC_WM8770 is not set
CONFIG_SND_SOC_WM8776=y
CONFIG_SND_SOC_WM8782=y
# CONFIG_SND_SOC_WM8804_I2C is not set
# CONFIG_SND_SOC_WM8804_SPI is not set
CONFIG_SND_SOC_WM8900=y
CONFIG_SND_SOC_WM8903=y
CONFIG_SND_SOC_WM8904=y
# CONFIG_SND_SOC_WM8940 is not set
CONFIG_SND_SOC_WM8955=y
CONFIG_SND_SOC_WM8960=y
CONFIG_SND_SOC_WM8961=y
# CONFIG_SND_SOC_WM8962 is not set
CONFIG_SND_SOC_WM8971=y
# CONFIG_SND_SOC_WM8974 is not set
CONFIG_SND_SOC_WM8978=y
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
# CONFIG_SND_SOC_WM9705 is not set
# CONFIG_SND_SOC_WM9712 is not set
# CONFIG_SND_SOC_WM9713 is not set
CONFIG_SND_SOC_WSA881X=y
CONFIG_SND_SOC_WSA883X=y
# CONFIG_SND_SOC_ZL38060 is not set
CONFIG_SND_SOC_LM4857=y
CONFIG_SND_SOC_MAX9759=y
CONFIG_SND_SOC_MAX9768=y
CONFIG_SND_SOC_MAX9877=y
# CONFIG_SND_SOC_MC13783 is not set
CONFIG_SND_SOC_ML26124=y
CONFIG_SND_SOC_MT6351=y
CONFIG_SND_SOC_MT6358=y
# CONFIG_SND_SOC_MT6359 is not set
CONFIG_SND_SOC_MT6660=y
CONFIG_SND_SOC_NAU8315=y
# CONFIG_SND_SOC_NAU8540 is not set
CONFIG_SND_SOC_NAU8810=y
CONFIG_SND_SOC_NAU8821=y
# CONFIG_SND_SOC_NAU8822 is not set
# CONFIG_SND_SOC_NAU8824 is not set
CONFIG_SND_SOC_NAU8825=y
# CONFIG_SND_SOC_TPA6130A2 is not set
CONFIG_SND_SOC_LPASS_MACRO_COMMON=y
CONFIG_SND_SOC_LPASS_WSA_MACRO=y
# CONFIG_SND_SOC_LPASS_VA_MACRO is not set
CONFIG_SND_SOC_LPASS_RX_MACRO=y
# CONFIG_SND_SOC_LPASS_TX_MACRO is not set
# end of CODEC drivers

CONFIG_SND_SIMPLE_CARD_UTILS=y
CONFIG_SND_SIMPLE_CARD=y
CONFIG_SND_AUDIO_GRAPH_CARD=y
CONFIG_SND_AUDIO_GRAPH_CARD2=y
CONFIG_SND_AUDIO_GRAPH_CARD2_CUSTOM_SAMPLE=y
CONFIG_SND_TEST_COMPONENT=y
# CONFIG_SND_VIRTIO is not set
CONFIG_AC97_BUS=y

#
# HID support
#
CONFIG_HID=y
# CONFIG_HID_BATTERY_STRENGTH is not set
CONFIG_HIDRAW=y
CONFIG_UHID=y
# CONFIG_HID_GENERIC is not set

#
# Special HID drivers
#
CONFIG_HID_A4TECH=y
CONFIG_HID_ACRUX=y
CONFIG_HID_ACRUX_FF=y
# CONFIG_HID_APPLE is not set
# CONFIG_HID_AUREAL is not set
CONFIG_HID_BELKIN=y
CONFIG_HID_CHERRY=y
CONFIG_HID_COUGAR=y
# CONFIG_HID_MACALLY is not set
# CONFIG_HID_CMEDIA is not set
# CONFIG_HID_CYPRESS is not set
# CONFIG_HID_DRAGONRISE is not set
CONFIG_HID_EMS_FF=y
# CONFIG_HID_ELECOM is not set
# CONFIG_HID_EZKEY is not set
CONFIG_HID_GEMBIRD=y
# CONFIG_HID_GFRM is not set
CONFIG_HID_GLORIOUS=y
CONFIG_HID_VIVALDI_COMMON=y
CONFIG_HID_VIVALDI=y
CONFIG_HID_KEYTOUCH=y
CONFIG_HID_KYE=y
# CONFIG_HID_WALTOP is not set
# CONFIG_HID_VIEWSONIC is not set
CONFIG_HID_XIAOMI=y
# CONFIG_HID_GYRATION is not set
CONFIG_HID_ICADE=y
CONFIG_HID_ITE=y
# CONFIG_HID_JABRA is not set
CONFIG_HID_TWINHAN=y
CONFIG_HID_KENSINGTON=y
CONFIG_HID_LCPOWER=y
CONFIG_HID_LED=y
# CONFIG_HID_LENOVO is not set
CONFIG_HID_MAGICMOUSE=y
CONFIG_HID_MALTRON=y
# CONFIG_HID_MAYFLASH is not set
# CONFIG_HID_REDRAGON is not set
CONFIG_HID_MICROSOFT=y
CONFIG_HID_MONTEREY=y
# CONFIG_HID_MULTITOUCH is not set
CONFIG_HID_NINTENDO=y
CONFIG_NINTENDO_FF=y
CONFIG_HID_NTI=y
# CONFIG_HID_ORTEK is not set
CONFIG_HID_PANTHERLORD=y
CONFIG_PANTHERLORD_FF=y
# CONFIG_HID_PETALYNX is not set
# CONFIG_HID_PICOLCD is not set
CONFIG_HID_PLANTRONICS=y
CONFIG_HID_PLAYSTATION=y
CONFIG_PLAYSTATION_FF=y
CONFIG_HID_RAZER=y
# CONFIG_HID_PRIMAX is not set
# CONFIG_HID_SAITEK is not set
# CONFIG_HID_SEMITEK is not set
CONFIG_HID_SPEEDLINK=y
CONFIG_HID_STEAM=y
# CONFIG_HID_STEELSERIES is not set
CONFIG_HID_SUNPLUS=y
CONFIG_HID_RMI=y
CONFIG_HID_GREENASIA=y
# CONFIG_GREENASIA_FF is not set
# CONFIG_HID_SMARTJOYPLUS is not set
# CONFIG_HID_TIVO is not set
# CONFIG_HID_TOPSEED is not set
CONFIG_HID_THINGM=y
# CONFIG_HID_UDRAW_PS3 is not set
# CONFIG_HID_WIIMOTE is not set
CONFIG_HID_XINMO=y
CONFIG_HID_ZEROPLUS=y
# CONFIG_ZEROPLUS_FF is not set
# CONFIG_HID_ZYDACRON is not set
# CONFIG_HID_SENSOR_HUB is not set
CONFIG_HID_ALPS=y
# end of Special HID drivers

#
# I2C HID support
#
CONFIG_I2C_HID_ACPI=y
CONFIG_I2C_HID_OF=y
CONFIG_I2C_HID_OF_ELAN=y
CONFIG_I2C_HID_OF_GOODIX=y
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
# CONFIG_MMC is not set
CONFIG_SCSI_UFSHCD=y
# CONFIG_SCSI_UFS_BSG is not set
CONFIG_SCSI_UFS_HPB=y
CONFIG_SCSI_UFS_FAULT_INJECTION=y
CONFIG_SCSI_UFS_HWMON=y
# CONFIG_SCSI_UFSHCD_PCI is not set
CONFIG_SCSI_UFSHCD_PLATFORM=y
# CONFIG_SCSI_UFS_CDNS_PLATFORM is not set
# CONFIG_SCSI_UFS_DWC_TC_PLATFORM is not set
CONFIG_SCSI_UFS_HISI=y
# CONFIG_SCSI_UFS_RENESAS is not set
CONFIG_SCSI_UFS_TI_J721E=y
CONFIG_SCSI_UFS_EXYNOS=y
CONFIG_MEMSTICK=y
CONFIG_MEMSTICK_DEBUG=y

#
# MemoryStick drivers
#
# CONFIG_MEMSTICK_UNSAFE_RESUME is not set
# CONFIG_MSPRO_BLOCK is not set
CONFIG_MS_BLOCK=y

#
# MemoryStick Host Controller Drivers
#
# CONFIG_MEMSTICK_TIFM_MS is not set
# CONFIG_MEMSTICK_JMICRON_38X is not set
CONFIG_MEMSTICK_R592=y
CONFIG_MEMSTICK_REALTEK_PCI=y
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_CLASS_FLASH=y
CONFIG_LEDS_CLASS_MULTICOLOR=y
CONFIG_LEDS_BRIGHTNESS_HW_CHANGED=y

#
# LED drivers
#
# CONFIG_LEDS_88PM860X is not set
CONFIG_LEDS_AN30259A=y
# CONFIG_LEDS_ARIEL is not set
CONFIG_LEDS_AW2013=y
# CONFIG_LEDS_BCM6328 is not set
CONFIG_LEDS_BCM6358=y
# CONFIG_LEDS_TURRIS_OMNIA is not set
# CONFIG_LEDS_LM3530 is not set
CONFIG_LEDS_LM3532=y
CONFIG_LEDS_LM3533=y
CONFIG_LEDS_LM3642=y
# CONFIG_LEDS_LM3692X is not set
CONFIG_LEDS_MT6323=y
# CONFIG_LEDS_S3C24XX is not set
# CONFIG_LEDS_COBALT_QUBE is not set
CONFIG_LEDS_COBALT_RAQ=y
# CONFIG_LEDS_PCA9532 is not set
CONFIG_LEDS_GPIO=y
# CONFIG_LEDS_LP3944 is not set
CONFIG_LEDS_LP3952=y
# CONFIG_LEDS_LP50XX is not set
CONFIG_LEDS_LP55XX_COMMON=y
CONFIG_LEDS_LP5521=y
# CONFIG_LEDS_LP5523 is not set
CONFIG_LEDS_LP5562=y
CONFIG_LEDS_LP8501=y
# CONFIG_LEDS_LP8788 is not set
CONFIG_LEDS_LP8860=y
CONFIG_LEDS_PCA955X=y
CONFIG_LEDS_PCA955X_GPIO=y
# CONFIG_LEDS_PCA963X is not set
# CONFIG_LEDS_WM831X_STATUS is not set
CONFIG_LEDS_WM8350=y
CONFIG_LEDS_PWM=y
CONFIG_LEDS_REGULATOR=y
# CONFIG_LEDS_BD2802 is not set
# CONFIG_LEDS_LT3593 is not set
CONFIG_LEDS_NS2=y
CONFIG_LEDS_NETXBIG=y
# CONFIG_LEDS_TCA6507 is not set
CONFIG_LEDS_TLC591XX=y
CONFIG_LEDS_MAX77650=y
CONFIG_LEDS_LM355x=y
CONFIG_LEDS_OT200=y
CONFIG_LEDS_MENF21BMC=y
CONFIG_LEDS_IS31FL319X=y
CONFIG_LEDS_IS31FL32XX=y

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=y
# CONFIG_LEDS_SYSCON is not set
CONFIG_LEDS_PM8058=y
CONFIG_LEDS_MLXREG=y
CONFIG_LEDS_USER=y
CONFIG_LEDS_TI_LMU_COMMON=y
CONFIG_LEDS_LM3697=y
CONFIG_LEDS_LM36274=y
# CONFIG_LEDS_TPS6105X is not set
CONFIG_LEDS_IP30=y
CONFIG_LEDS_ACER_A500=y
CONFIG_LEDS_BCM63138=y
CONFIG_LEDS_LGM=y

#
# Flash and Torch LED drivers
#
CONFIG_LEDS_AAT1290=y
CONFIG_LEDS_AS3645A=y
# CONFIG_LEDS_KTD2692 is not set
CONFIG_LEDS_LM3601X=y
# CONFIG_LEDS_MAX77693 is not set
# CONFIG_LEDS_MT6360 is not set
CONFIG_LEDS_RT4505=y
# CONFIG_LEDS_RT8515 is not set
CONFIG_LEDS_SGM3140=y

#
# RGB LED drivers
#
CONFIG_LEDS_PWM_MULTICOLOR=y
# CONFIG_LEDS_QCOM_LPG is not set

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
# CONFIG_LEDS_TRIGGER_TIMER is not set
# CONFIG_LEDS_TRIGGER_ONESHOT is not set
# CONFIG_LEDS_TRIGGER_DISK is not set
# CONFIG_LEDS_TRIGGER_MTD is not set
CONFIG_LEDS_TRIGGER_HEARTBEAT=y
CONFIG_LEDS_TRIGGER_BACKLIGHT=y
# CONFIG_LEDS_TRIGGER_CPU is not set
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
# CONFIG_LEDS_TRIGGER_GPIO is not set
CONFIG_LEDS_TRIGGER_DEFAULT_ON=y

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=y
# CONFIG_LEDS_TRIGGER_CAMERA is not set
CONFIG_LEDS_TRIGGER_PANIC=y
CONFIG_LEDS_TRIGGER_PATTERN=y
CONFIG_LEDS_TRIGGER_AUDIO=y
CONFIG_LEDS_TRIGGER_TTY=y

#
# Simple LED drivers
#
# CONFIG_ACCESSIBILITY is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
CONFIG_RTC_SYSTOHC=y
CONFIG_RTC_SYSTOHC_DEVICE="rtc0"
# CONFIG_RTC_DEBUG is not set
# CONFIG_RTC_NVMEM is not set

#
# RTC interfaces
#
# CONFIG_RTC_INTF_SYSFS is not set
CONFIG_RTC_INTF_PROC=y
# CONFIG_RTC_INTF_DEV is not set
CONFIG_RTC_DRV_TEST=y

#
# I2C RTC drivers
#
# CONFIG_RTC_DRV_88PM860X is not set
CONFIG_RTC_DRV_ABB5ZES3=y
CONFIG_RTC_DRV_ABEOZ9=y
CONFIG_RTC_DRV_ABX80X=y
CONFIG_RTC_DRV_BRCMSTB=y
CONFIG_RTC_DRV_AS3722=y
CONFIG_RTC_DRV_DS1307=y
# CONFIG_RTC_DRV_DS1307_CENTURY is not set
CONFIG_RTC_DRV_DS1374=y
CONFIG_RTC_DRV_DS1672=y
CONFIG_RTC_DRV_HYM8563=y
CONFIG_RTC_DRV_LP8788=y
CONFIG_RTC_DRV_MAX6900=y
CONFIG_RTC_DRV_MAX8907=y
# CONFIG_RTC_DRV_MAX77686 is not set
# CONFIG_RTC_DRV_NCT3018Y is not set
CONFIG_RTC_DRV_RS5C372=y
CONFIG_RTC_DRV_ISL1208=y
CONFIG_RTC_DRV_ISL12022=y
CONFIG_RTC_DRV_ISL12026=y
CONFIG_RTC_DRV_X1205=y
CONFIG_RTC_DRV_PCF8523=y
CONFIG_RTC_DRV_PCF85063=y
CONFIG_RTC_DRV_PCF85363=y
# CONFIG_RTC_DRV_PCF8563 is not set
# CONFIG_RTC_DRV_PCF8583 is not set
# CONFIG_RTC_DRV_M41T80 is not set
CONFIG_RTC_DRV_BD70528=y
CONFIG_RTC_DRV_BQ32K=y
CONFIG_RTC_DRV_TWL4030=y
# CONFIG_RTC_DRV_TPS65910 is not set
CONFIG_RTC_DRV_RC5T583=y
# CONFIG_RTC_DRV_S35390A is not set
CONFIG_RTC_DRV_FM3130=y
# CONFIG_RTC_DRV_RX8010 is not set
CONFIG_RTC_DRV_RX8581=y
CONFIG_RTC_DRV_RX8025=y
# CONFIG_RTC_DRV_EM3027 is not set
CONFIG_RTC_DRV_RV3028=y
# CONFIG_RTC_DRV_RV3032 is not set
CONFIG_RTC_DRV_RV8803=y
CONFIG_RTC_DRV_S5M=y
CONFIG_RTC_DRV_SD3078=y

#
# SPI RTC drivers
#
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
# CONFIG_RTC_DRV_DS3232 is not set
# CONFIG_RTC_DRV_PCF2127 is not set
CONFIG_RTC_DRV_RV3029C2=y
# CONFIG_RTC_DRV_RV3029_HWMON is not set
CONFIG_RTC_DRV_RX6110=y

#
# Platform RTC drivers
#
# CONFIG_RTC_DRV_DS1286 is not set
CONFIG_RTC_DRV_DS1511=y
# CONFIG_RTC_DRV_DS1553 is not set
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
# CONFIG_RTC_DRV_DS1742 is not set
CONFIG_RTC_DRV_DS2404=y
# CONFIG_RTC_DRV_DA9063 is not set
# CONFIG_RTC_DRV_EFI is not set
# CONFIG_RTC_DRV_STK17TA8 is not set
CONFIG_RTC_DRV_M48T86=y
CONFIG_RTC_DRV_M48T35=y
CONFIG_RTC_DRV_M48T59=y
# CONFIG_RTC_DRV_MSM6242 is not set
CONFIG_RTC_DRV_BQ4802=y
CONFIG_RTC_DRV_RP5C01=y
CONFIG_RTC_DRV_V3020=y
# CONFIG_RTC_DRV_GAMECUBE is not set
CONFIG_RTC_DRV_WM831X=y
# CONFIG_RTC_DRV_WM8350 is not set
CONFIG_RTC_DRV_SC27XX=y
CONFIG_RTC_DRV_SPEAR=y
# CONFIG_RTC_DRV_PCF50633 is not set
CONFIG_RTC_DRV_ZYNQMP=y
CONFIG_RTC_DRV_NTXEC=y

#
# on-CPU RTC drivers
#
CONFIG_RTC_DRV_ASM9260=y
# CONFIG_RTC_DRV_DAVINCI is not set
# CONFIG_RTC_DRV_DIGICOLOR is not set
CONFIG_RTC_DRV_FSL_FTM_ALARM=y
CONFIG_RTC_DRV_MESON=y
CONFIG_RTC_DRV_MESON_VRTC=y
CONFIG_RTC_DRV_OMAP=y
CONFIG_RTC_DRV_S3C=y
# CONFIG_RTC_DRV_EP93XX is not set
CONFIG_RTC_DRV_AT91RM9200=y
CONFIG_RTC_DRV_AT91SAM9=y
CONFIG_RTC_DRV_RZN1=y
CONFIG_RTC_DRV_GENERIC=y
CONFIG_RTC_DRV_VT8500=y
# CONFIG_RTC_DRV_SUN6I is not set
CONFIG_RTC_DRV_SUNXI=y
CONFIG_RTC_DRV_MV=y
CONFIG_RTC_DRV_ARMADA38X=y
CONFIG_RTC_DRV_CADENCE=y
# CONFIG_RTC_DRV_FTRTC010 is not set
CONFIG_RTC_DRV_STMP=y
# CONFIG_RTC_DRV_JZ4740 is not set
CONFIG_RTC_DRV_LPC24XX=y
CONFIG_RTC_DRV_LPC32XX=y
# CONFIG_RTC_DRV_PM8XXX is not set
CONFIG_RTC_DRV_TEGRA=y
CONFIG_RTC_DRV_MXC=y
# CONFIG_RTC_DRV_MXC_V2 is not set
# CONFIG_RTC_DRV_SNVS is not set
CONFIG_RTC_DRV_MOXART=y
CONFIG_RTC_DRV_MT2712=y
# CONFIG_RTC_DRV_MT6397 is not set
CONFIG_RTC_DRV_MT7622=y
# CONFIG_RTC_DRV_XGENE is not set
# CONFIG_RTC_DRV_R7301 is not set
CONFIG_RTC_DRV_STM32=y
# CONFIG_RTC_DRV_RTD119X is not set
CONFIG_RTC_DRV_ASPEED=y
CONFIG_RTC_DRV_TI_K3=y

#
# HID Sensor RTC drivers
#
# CONFIG_RTC_DRV_GOLDFISH is not set
CONFIG_RTC_DRV_MSC313=y
CONFIG_DMADEVICES=y
CONFIG_DMADEVICES_DEBUG=y
CONFIG_DMADEVICES_VDEBUG=y

#
# DMA Devices
#
CONFIG_ASYNC_TX_ENABLE_CHANNEL_SWITCH=y
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
CONFIG_DMA_OF=y
# CONFIG_ALTERA_MSGDMA is not set
# CONFIG_APPLE_ADMAC is not set
CONFIG_AXI_DMAC=y
CONFIG_BCM_SBA_RAID=y
# CONFIG_DMA_JZ4780 is not set
CONFIG_DMA_SA11X0=y
CONFIG_DMA_SUN6I=y
CONFIG_DW_AXI_DMAC=y
CONFIG_EP93XX_DMA=y
# CONFIG_FSL_EDMA is not set
CONFIG_HISI_DMA=y
CONFIG_IMG_MDC_DMA=y
# CONFIG_INTEL_IDMA64 is not set
# CONFIG_INTEL_IOP_ADMA is not set
# CONFIG_K3_DMA is not set
CONFIG_MCF_EDMA=y
CONFIG_MILBEAUT_HDMAC=y
CONFIG_MILBEAUT_XDMAC=y
CONFIG_MMP_PDMA=y
# CONFIG_MMP_TDMA is not set
# CONFIG_MV_XOR is not set
CONFIG_MXS_DMA=y
CONFIG_NBPFAXI_DMA=y
CONFIG_PCH_DMA=y
# CONFIG_PLX_DMA is not set
# CONFIG_STM32_DMA is not set
CONFIG_STM32_DMAMUX=y
CONFIG_STM32_MDMA=y
# CONFIG_SPRD_DMA is not set
CONFIG_S3C24XX_DMAC=y
# CONFIG_TEGRA186_GPC_DMA is not set
CONFIG_TEGRA20_APB_DMA=y
CONFIG_TEGRA210_ADMA=y
# CONFIG_TIMB_DMA is not set
# CONFIG_UNIPHIER_MDMAC is not set
CONFIG_UNIPHIER_XDMAC=y
# CONFIG_XGENE_DMA is not set
# CONFIG_XILINX_ZYNQMP_DMA is not set
# CONFIG_XILINX_ZYNQMP_DPDMA is not set
CONFIG_MTK_HSDMA=y
CONFIG_MTK_CQDMA=y
# CONFIG_QCOM_HIDMA_MGMT is not set
CONFIG_QCOM_HIDMA=y
CONFIG_DW_DMAC_CORE=y
# CONFIG_DW_DMAC is not set
CONFIG_DW_DMAC_PCI=y
CONFIG_DW_EDMA=y
# CONFIG_DW_EDMA_PCIE is not set
CONFIG_SF_PDMA=y
CONFIG_RENESAS_DMA=y
# CONFIG_SH_DMAE_BASE is not set
CONFIG_RCAR_DMAC=y
# CONFIG_RENESAS_USB_DMAC is not set
CONFIG_RZ_DMAC=y
CONFIG_TI_EDMA=y
CONFIG_DMA_OMAP=y
CONFIG_TI_DMA_CROSSBAR=y
CONFIG_INTEL_LDMA=y

#
# DMA Clients
#
# CONFIG_ASYNC_TX_DMA is not set
CONFIG_DMATEST=y
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
# CONFIG_SW_SYNC is not set
# CONFIG_UDMABUF is not set
# CONFIG_DMABUF_MOVE_NOTIFY is not set
CONFIG_DMABUF_DEBUG=y
# CONFIG_DMABUF_SELFTESTS is not set
# CONFIG_DMABUF_HEAPS is not set
CONFIG_DMABUF_SYSFS_STATS=y
# end of DMABUF options

# CONFIG_AUXDISPLAY is not set
# CONFIG_UIO is not set
# CONFIG_VFIO is not set
CONFIG_VIRT_DRIVERS=y
CONFIG_VMGENID=y
CONFIG_VIRTIO_ANCHOR=y
CONFIG_VIRTIO=y
CONFIG_VIRTIO_PCI_LIB=y
CONFIG_VIRTIO_MENU=y
CONFIG_VIRTIO_PCI=y
# CONFIG_VIRTIO_PCI_LEGACY is not set
CONFIG_VIRTIO_BALLOON=y
CONFIG_VIRTIO_INPUT=y
# CONFIG_VIRTIO_MMIO is not set
# CONFIG_VHOST_MENU is not set

#
# Microsoft Hyper-V guest support
#
# end of Microsoft Hyper-V guest support

# CONFIG_GREYBUS is not set
# CONFIG_COMEDI is not set
# CONFIG_STAGING is not set
CONFIG_GOLDFISH=y
CONFIG_GOLDFISH_PIPE=y
# CONFIG_CHROME_PLATFORMS is not set
# CONFIG_MELLANOX_PLATFORM is not set
CONFIG_OLPC_XO175=y
# CONFIG_SURFACE_PLATFORMS is not set
CONFIG_HAVE_CLK=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
CONFIG_COMMON_CLK_WM831X=y

#
# Clock driver for ARM Reference designs
#
# CONFIG_CLK_ICST is not set
# CONFIG_CLK_SP810 is not set
# end of Clock driver for ARM Reference designs

# CONFIG_CLK_HSDK is not set
# CONFIG_COMMON_CLK_APPLE_NCO is not set
# CONFIG_COMMON_CLK_MAX77686 is not set
CONFIG_COMMON_CLK_MAX9485=y
CONFIG_COMMON_CLK_HI655X=y
CONFIG_COMMON_CLK_SCMI=y
CONFIG_COMMON_CLK_SCPI=y
CONFIG_COMMON_CLK_SI5341=y
CONFIG_COMMON_CLK_SI5351=y
# CONFIG_COMMON_CLK_SI514 is not set
CONFIG_COMMON_CLK_SI544=y
# CONFIG_COMMON_CLK_SI570 is not set
CONFIG_COMMON_CLK_BM1880=y
CONFIG_COMMON_CLK_CDCE706=y
CONFIG_COMMON_CLK_TPS68470=y
# CONFIG_COMMON_CLK_CDCE925 is not set
CONFIG_COMMON_CLK_CS2000_CP=y
# CONFIG_COMMON_CLK_EN7523 is not set
CONFIG_COMMON_CLK_FSL_FLEXSPI=y
CONFIG_COMMON_CLK_FSL_SAI=y
CONFIG_COMMON_CLK_GEMINI=y
CONFIG_COMMON_CLK_LAN966X=y
CONFIG_COMMON_CLK_ASPEED=y
CONFIG_COMMON_CLK_S2MPS11=y
# CONFIG_COMMON_CLK_AXI_CLKGEN is not set
# CONFIG_CLK_QORIQ is not set
CONFIG_CLK_LS1028A_PLLDIG=y
CONFIG_COMMON_CLK_XGENE=y
CONFIG_COMMON_CLK_PWM=y
CONFIG_COMMON_CLK_OXNAS=y
CONFIG_COMMON_CLK_RS9_PCIE=y
CONFIG_COMMON_CLK_VC5=y
CONFIG_COMMON_CLK_MMP2_AUDIO=y
CONFIG_COMMON_CLK_BD718XX=y
# CONFIG_COMMON_CLK_FIXED_MMIO is not set
# CONFIG_CLK_ACTIONS is not set
CONFIG_CLK_BAIKAL_T1=y
# CONFIG_CLK_BT1_CCU_PLL is not set
CONFIG_CLK_BT1_CCU_DIV=y
# CONFIG_CLK_BCM2711_DVP is not set
CONFIG_CLK_BCM2835=y
CONFIG_CLK_BCM_63XX=y
CONFIG_CLK_BCM_63XX_GATE=y
CONFIG_CLK_BCM_KONA=y
CONFIG_COMMON_CLK_IPROC=y
CONFIG_CLK_BCM_CYGNUS=y
CONFIG_CLK_BCM_HR2=y
# CONFIG_CLK_BCM_NSP is not set
# CONFIG_CLK_BCM_NS2 is not set
# CONFIG_CLK_BCM_SR is not set
# CONFIG_CLK_RASPBERRYPI is not set
CONFIG_COMMON_CLK_HI3516CV300=y
# CONFIG_COMMON_CLK_HI3519 is not set
CONFIG_COMMON_CLK_HI3559A=y
# CONFIG_COMMON_CLK_HI3660 is not set
# CONFIG_COMMON_CLK_HI3670 is not set
# CONFIG_COMMON_CLK_HI3798CV200 is not set
# CONFIG_COMMON_CLK_HI6220 is not set
CONFIG_RESET_HISI=y
# CONFIG_COMMON_CLK_BOSTON is not set
CONFIG_MXC_CLK=y
CONFIG_CLK_IMX8MM=y
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
# CONFIG_INGENIC_CGU_JZ4725B is not set
CONFIG_INGENIC_CGU_JZ4760=y
CONFIG_INGENIC_CGU_JZ4770=y
CONFIG_INGENIC_CGU_JZ4780=y
# CONFIG_INGENIC_CGU_X1000 is not set
CONFIG_INGENIC_CGU_X1830=y
# CONFIG_INGENIC_TCU_CLK is not set
# end of Ingenic SoCs drivers

CONFIG_COMMON_CLK_KEYSTONE=y
CONFIG_TI_SYSCON_CLK=y

#
# Clock driver for MediaTek SoC
#
CONFIG_COMMON_CLK_MEDIATEK=y
CONFIG_COMMON_CLK_MT2701=y
CONFIG_COMMON_CLK_MT2701_MMSYS=y
CONFIG_COMMON_CLK_MT2701_IMGSYS=y
# CONFIG_COMMON_CLK_MT2701_VDECSYS is not set
CONFIG_COMMON_CLK_MT2701_HIFSYS=y
CONFIG_COMMON_CLK_MT2701_ETHSYS=y
CONFIG_COMMON_CLK_MT2701_BDPSYS=y
# CONFIG_COMMON_CLK_MT2701_AUDSYS is not set
CONFIG_COMMON_CLK_MT2701_G3DSYS=y
CONFIG_COMMON_CLK_MT2712=y
CONFIG_COMMON_CLK_MT2712_BDPSYS=y
# CONFIG_COMMON_CLK_MT2712_IMGSYS is not set
CONFIG_COMMON_CLK_MT2712_JPGDECSYS=y
# CONFIG_COMMON_CLK_MT2712_MFGCFG is not set
CONFIG_COMMON_CLK_MT2712_MMSYS=y
# CONFIG_COMMON_CLK_MT2712_VDECSYS is not set
CONFIG_COMMON_CLK_MT2712_VENCSYS=y
CONFIG_COMMON_CLK_MT6765=y
CONFIG_COMMON_CLK_MT6765_AUDIOSYS=y
# CONFIG_COMMON_CLK_MT6765_CAMSYS is not set
CONFIG_COMMON_CLK_MT6765_GCESYS=y
CONFIG_COMMON_CLK_MT6765_MMSYS=y
# CONFIG_COMMON_CLK_MT6765_IMGSYS is not set
# CONFIG_COMMON_CLK_MT6765_VCODECSYS is not set
# CONFIG_COMMON_CLK_MT6765_MFGSYS is not set
# CONFIG_COMMON_CLK_MT6765_MIPI0ASYS is not set
CONFIG_COMMON_CLK_MT6765_MIPI0BSYS=y
# CONFIG_COMMON_CLK_MT6765_MIPI1ASYS is not set
# CONFIG_COMMON_CLK_MT6765_MIPI1BSYS is not set
CONFIG_COMMON_CLK_MT6765_MIPI2ASYS=y
CONFIG_COMMON_CLK_MT6765_MIPI2BSYS=y
# CONFIG_COMMON_CLK_MT6779 is not set
CONFIG_COMMON_CLK_MT6797=y
# CONFIG_COMMON_CLK_MT6797_MMSYS is not set
CONFIG_COMMON_CLK_MT6797_IMGSYS=y
# CONFIG_COMMON_CLK_MT6797_VDECSYS is not set
CONFIG_COMMON_CLK_MT6797_VENCSYS=y
# CONFIG_COMMON_CLK_MT7622 is not set
# CONFIG_COMMON_CLK_MT7629 is not set
# CONFIG_COMMON_CLK_MT7986 is not set
CONFIG_COMMON_CLK_MT8135=y
CONFIG_COMMON_CLK_MT8167=y
CONFIG_COMMON_CLK_MT8167_AUDSYS=y
# CONFIG_COMMON_CLK_MT8167_IMGSYS is not set
CONFIG_COMMON_CLK_MT8167_MFGCFG=y
# CONFIG_COMMON_CLK_MT8167_MMSYS is not set
# CONFIG_COMMON_CLK_MT8167_VDECSYS is not set
CONFIG_COMMON_CLK_MT8173=y
CONFIG_COMMON_CLK_MT8173_MMSYS=y
CONFIG_COMMON_CLK_MT8183=y
# CONFIG_COMMON_CLK_MT8183_AUDIOSYS is not set
# CONFIG_COMMON_CLK_MT8183_CAMSYS is not set
# CONFIG_COMMON_CLK_MT8183_IMGSYS is not set
CONFIG_COMMON_CLK_MT8183_IPU_CORE0=y
CONFIG_COMMON_CLK_MT8183_IPU_CORE1=y
# CONFIG_COMMON_CLK_MT8183_IPU_ADL is not set
# CONFIG_COMMON_CLK_MT8183_IPU_CONN is not set
# CONFIG_COMMON_CLK_MT8183_MFGCFG is not set
CONFIG_COMMON_CLK_MT8183_MMSYS=y
CONFIG_COMMON_CLK_MT8183_VDECSYS=y
CONFIG_COMMON_CLK_MT8183_VENCSYS=y
# CONFIG_COMMON_CLK_MT8186 is not set
CONFIG_COMMON_CLK_MT8192=y
# CONFIG_COMMON_CLK_MT8192_AUDSYS is not set
# CONFIG_COMMON_CLK_MT8192_CAMSYS is not set
CONFIG_COMMON_CLK_MT8192_IMGSYS=y
# CONFIG_COMMON_CLK_MT8192_IMP_IIC_WRAP is not set
# CONFIG_COMMON_CLK_MT8192_IPESYS is not set
CONFIG_COMMON_CLK_MT8192_MDPSYS=y
CONFIG_COMMON_CLK_MT8192_MFGCFG=y
CONFIG_COMMON_CLK_MT8192_MMSYS=y
# CONFIG_COMMON_CLK_MT8192_MSDC is not set
CONFIG_COMMON_CLK_MT8192_SCP_ADSP=y
# CONFIG_COMMON_CLK_MT8192_VDECSYS is not set
# CONFIG_COMMON_CLK_MT8192_VENCSYS is not set
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
# CONFIG_MCHP_CLK_MPFS is not set
# CONFIG_COMMON_CLK_PISTACHIO is not set
CONFIG_QCOM_GDSC=y
CONFIG_COMMON_CLK_QCOM=y
CONFIG_QCOM_A53PLL=y
CONFIG_QCOM_A7PLL=y
CONFIG_QCOM_CLK_APCS_MSM8916=y
CONFIG_QCOM_CLK_APCS_SDX55=y
# CONFIG_QCOM_CLK_SMD_RPM is not set
CONFIG_QCOM_CLK_RPMH=y
CONFIG_APQ_GCC_8084=y
CONFIG_APQ_MMCC_8084=y
CONFIG_IPQ_APSS_PLL=y
CONFIG_IPQ_APSS_6018=y
CONFIG_IPQ_GCC_4019=y
CONFIG_IPQ_GCC_6018=y
CONFIG_IPQ_GCC_806X=y
CONFIG_IPQ_LCC_806X=y
CONFIG_IPQ_GCC_8074=y
# CONFIG_MSM_GCC_8660 is not set
CONFIG_MSM_GCC_8916=y
# CONFIG_MSM_GCC_8939 is not set
CONFIG_MSM_GCC_8960=y
CONFIG_MSM_LCC_8960=y
CONFIG_MDM_GCC_9607=y
CONFIG_MDM_GCC_9615=y
# CONFIG_MDM_LCC_9615 is not set
CONFIG_MSM_MMCC_8960=y
CONFIG_MSM_GCC_8953=y
CONFIG_MSM_GCC_8974=y
CONFIG_MSM_MMCC_8974=y
# CONFIG_MSM_GCC_8976 is not set
CONFIG_MSM_MMCC_8994=y
CONFIG_MSM_GCC_8994=y
CONFIG_MSM_GCC_8996=y
# CONFIG_MSM_MMCC_8996 is not set
CONFIG_MSM_GCC_8998=y
# CONFIG_MSM_GPUCC_8998 is not set
CONFIG_MSM_MMCC_8998=y
CONFIG_QCM_GCC_2290=y
CONFIG_QCM_DISPCC_2290=y
CONFIG_QCS_GCC_404=y
CONFIG_SC_CAMCC_7180=y
CONFIG_SC_CAMCC_7280=y
CONFIG_SC_DISPCC_7180=y
CONFIG_SC_DISPCC_7280=y
CONFIG_SC_GCC_7180=y
CONFIG_SC_GCC_7280=y
CONFIG_SC_GCC_8180X=y
CONFIG_SC_GCC_8280XP=y
CONFIG_SC_GPUCC_7180=y
CONFIG_SC_GPUCC_7280=y
CONFIG_SC_LPASSCC_7280=y
# CONFIG_SC_LPASS_CORECC_7180 is not set
# CONFIG_SC_LPASS_CORECC_7280 is not set
CONFIG_SC_MSS_7180=y
CONFIG_SC_VIDEOCC_7180=y
CONFIG_SC_VIDEOCC_7280=y
CONFIG_SDM_CAMCC_845=y
CONFIG_SDM_GCC_660=y
CONFIG_SDM_MMCC_660=y
CONFIG_SDM_GPUCC_660=y
CONFIG_QCS_TURING_404=y
CONFIG_QCS_Q6SSTOP_404=y
CONFIG_SDM_GCC_845=y
CONFIG_SDM_GPUCC_845=y
# CONFIG_SDM_VIDEOCC_845 is not set
# CONFIG_SDM_DISPCC_845 is not set
CONFIG_SDM_LPASSCC_845=y
CONFIG_SDX_GCC_55=y
CONFIG_SDX_GCC_65=y
CONFIG_SM_CAMCC_8250=y
CONFIG_SM_CAMCC_8450=y
CONFIG_SM_DISPCC_8250=y
CONFIG_SM_DISPCC_6350=y
CONFIG_SM_GCC_6115=y
# CONFIG_SM_GCC_6125 is not set
CONFIG_SM_GCC_6350=y
CONFIG_SM_GCC_8150=y
CONFIG_SM_GCC_8250=y
# CONFIG_SM_GCC_8350 is not set
CONFIG_SM_GCC_8450=y
# CONFIG_SM_GPUCC_6350 is not set
# CONFIG_SM_GPUCC_8150 is not set
CONFIG_SM_GPUCC_8250=y
# CONFIG_SM_GPUCC_8350 is not set
CONFIG_SM_VIDEOCC_8150=y
CONFIG_SM_VIDEOCC_8250=y
# CONFIG_SPMI_PMIC_CLKDIV is not set
CONFIG_QCOM_HFPLL=y
CONFIG_KPSS_XCC=y
CONFIG_CLK_GFM_LPASS_SM8250=y
# CONFIG_CLK_MT7621 is not set
# CONFIG_CLK_RENESAS is not set
CONFIG_COMMON_CLK_SAMSUNG=y
CONFIG_S3C64XX_COMMON_CLK=y
CONFIG_S5PV210_COMMON_CLK=y
# CONFIG_EXYNOS_3250_COMMON_CLK is not set
CONFIG_EXYNOS_4_COMMON_CLK=y
CONFIG_EXYNOS_5250_COMMON_CLK=y
CONFIG_EXYNOS_5260_COMMON_CLK=y
# CONFIG_EXYNOS_5410_COMMON_CLK is not set
CONFIG_EXYNOS_5420_COMMON_CLK=y
CONFIG_EXYNOS_ARM64_COMMON_CLK=y
CONFIG_EXYNOS_AUDSS_CLK_CON=y
CONFIG_EXYNOS_CLKOUT=y
CONFIG_S3C2410_COMMON_CLK=y
# CONFIG_S3C2412_COMMON_CLK is not set
CONFIG_S3C2443_COMMON_CLK=y
# CONFIG_TESLA_FSD_COMMON_CLK is not set
# CONFIG_CLK_SIFIVE is not set
CONFIG_CLK_INTEL_SOCFPGA=y
# CONFIG_CLK_INTEL_SOCFPGA32 is not set
CONFIG_CLK_INTEL_SOCFPGA64=y
CONFIG_SPRD_COMMON_CLK=y
CONFIG_SPRD_SC9860_CLK=y
CONFIG_SPRD_SC9863A_CLK=y
# CONFIG_CLK_STARFIVE_JH7100 is not set
# CONFIG_CLK_SUNXI is not set
CONFIG_SUNXI_CCU=y
CONFIG_SUNIV_F1C100S_CCU=y
CONFIG_SUN20I_D1_CCU=y
# CONFIG_SUN20I_D1_R_CCU is not set
CONFIG_SUN50I_A64_CCU=y
# CONFIG_SUN50I_A100_CCU is not set
CONFIG_SUN50I_A100_R_CCU=y
# CONFIG_SUN50I_H6_CCU is not set
# CONFIG_SUN50I_H616_CCU is not set
# CONFIG_SUN50I_H6_R_CCU is not set
# CONFIG_SUN4I_A10_CCU is not set
CONFIG_SUN5I_CCU=y
CONFIG_SUN6I_A31_CCU=y
CONFIG_SUN6I_RTC_CCU=y
CONFIG_SUN8I_A23_CCU=y
CONFIG_SUN8I_A33_CCU=y
CONFIG_SUN8I_A83T_CCU=y
CONFIG_SUN8I_H3_CCU=y
CONFIG_SUN8I_V3S_CCU=y
CONFIG_SUN8I_DE2_CCU=y
CONFIG_SUN8I_R40_CCU=y
CONFIG_SUN9I_A80_CCU=y
CONFIG_SUN8I_R_CCU=y
# CONFIG_COMMON_CLK_TI_ADPLL is not set
# CONFIG_CLK_UNIPHIER is not set
# CONFIG_COMMON_CLK_VISCONTI is not set
CONFIG_CLK_LGM_CGU=y
# CONFIG_XILINX_VCU is not set
# CONFIG_COMMON_CLK_ZYNQMP is not set
CONFIG_HWSPINLOCK=y
CONFIG_HWSPINLOCK_OMAP=y
# CONFIG_HWSPINLOCK_QCOM is not set
CONFIG_HWSPINLOCK_SPRD=y
# CONFIG_HWSPINLOCK_STM32 is not set
CONFIG_HWSPINLOCK_SUN6I=y
# CONFIG_HSEM_U8500 is not set

#
# Clock Source drivers
#
CONFIG_TIMER_OF=y
CONFIG_TIMER_PROBE=y
CONFIG_CLKSRC_MMIO=y
CONFIG_BCM2835_TIMER=y
# CONFIG_BCM_KONA_TIMER is not set
CONFIG_DAVINCI_TIMER=y
# CONFIG_DIGICOLOR_TIMER is not set
CONFIG_OMAP_DM_TIMER=y
CONFIG_DW_APB_TIMER=y
# CONFIG_FTTMR010_TIMER is not set
CONFIG_IXP4XX_TIMER=y
# CONFIG_MESON6_TIMER is not set
CONFIG_OWL_TIMER=y
# CONFIG_RDA_TIMER is not set
CONFIG_SUN4I_TIMER=y
# CONFIG_SUN5I_HSTIMER is not set
# CONFIG_TEGRA_TIMER is not set
# CONFIG_VT8500_TIMER is not set
CONFIG_NPCM7XX_TIMER=y
CONFIG_CADENCE_TTC_TIMER=y
# CONFIG_ASM9260_TIMER is not set
# CONFIG_CLKSRC_DBX500_PRCMU is not set
CONFIG_CLPS711X_TIMER=y
# CONFIG_MXS_TIMER is not set
# CONFIG_NSPIRE_TIMER is not set
CONFIG_INTEGRATOR_AP_TIMER=y
CONFIG_CLKSRC_PISTACHIO=y
# CONFIG_CLKSRC_TI_32K is not set
# CONFIG_CLKSRC_STM32_LP is not set
CONFIG_CLKSRC_MPS2=y
CONFIG_ARC_TIMERS=y
CONFIG_ARC_TIMERS_64BIT=y
CONFIG_ARM_TIMER_SP804=y
CONFIG_ARMV7M_SYSTICK=y
CONFIG_ATMEL_PIT=y
CONFIG_ATMEL_ST=y
CONFIG_CLKSRC_SAMSUNG_PWM=y
# CONFIG_FSL_FTM_TIMER is not set
# CONFIG_OXNAS_RPS_TIMER is not set
CONFIG_MTK_TIMER=y
# CONFIG_CLKSRC_JCORE_PIT is not set
# CONFIG_SH_TIMER_CMT is not set
# CONFIG_SH_TIMER_MTU2 is not set
# CONFIG_RENESAS_OSTM is not set
# CONFIG_SH_TIMER_TMU is not set
CONFIG_EM_TIMER_STI=y
# CONFIG_CLKSRC_VERSATILE is not set
# CONFIG_CLKSRC_PXA is not set
CONFIG_TIMER_IMX_SYS_CTR=y
# CONFIG_CLKSRC_ST_LPC is not set
CONFIG_GXP_TIMER=y
# CONFIG_MSC313E_TIMER is not set
CONFIG_INGENIC_TIMER=y
CONFIG_INGENIC_SYSOST=y
# CONFIG_INGENIC_OST is not set
CONFIG_MICROCHIP_PIT64B=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
CONFIG_IMX_MBOX=y
CONFIG_PLATFORM_MHU=y
CONFIG_ARMADA_37XX_RWTM_MBOX=y
CONFIG_ROCKCHIP_MBOX=y
CONFIG_PCC=y
CONFIG_ALTERA_MBOX=y
CONFIG_MAILBOX_TEST=y
CONFIG_POLARFIRE_SOC_MAILBOX=y
CONFIG_QCOM_APCS_IPC=y
CONFIG_BCM_PDC_MBOX=y
CONFIG_STM32_IPCC=y
CONFIG_MTK_ADSP_MBOX=y
CONFIG_MTK_CMDQ_MBOX=y
CONFIG_SUN6I_MSGBOX=y
CONFIG_SPRD_MBOX=y
CONFIG_QCOM_IPCC=y
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
CONFIG_IOMMU_IO_PGTABLE=y
CONFIG_IOMMU_IO_PGTABLE_LPAE=y
# CONFIG_IOMMU_IO_PGTABLE_LPAE_SELFTEST is not set
CONFIG_IOMMU_IO_PGTABLE_ARMV7S=y
CONFIG_IOMMU_IO_PGTABLE_ARMV7S_SELFTEST=y
# end of Generic IOMMU Pagetable Support

CONFIG_IOMMU_DEBUGFS=y
# CONFIG_IOMMU_DEFAULT_DMA_STRICT is not set
CONFIG_IOMMU_DEFAULT_DMA_LAZY=y
# CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
CONFIG_OF_IOMMU=y
# CONFIG_OMAP_IOMMU is not set
# CONFIG_ROCKCHIP_IOMMU is not set
CONFIG_SUN50I_IOMMU=y
# CONFIG_EXYNOS_IOMMU is not set
CONFIG_IPMMU_VMSA=y
# CONFIG_APPLE_DART is not set
CONFIG_ARM_SMMU=y
# CONFIG_ARM_SMMU_LEGACY_DT_BINDINGS is not set
# CONFIG_ARM_SMMU_DISABLE_BYPASS_BY_DEFAULT is not set
# CONFIG_S390_CCW_IOMMU is not set
# CONFIG_S390_AP_IOMMU is not set
CONFIG_MTK_IOMMU=y
# CONFIG_QCOM_IOMMU is not set
CONFIG_SPRD_IOMMU=y

#
# Remoteproc drivers
#
CONFIG_REMOTEPROC=y
# CONFIG_REMOTEPROC_CDEV is not set
CONFIG_INGENIC_VPU_RPROC=y
# CONFIG_MTK_SCP is not set
# CONFIG_MESON_MX_AO_ARC_REMOTEPROC is not set
CONFIG_RCAR_REMOTEPROC=y
# end of Remoteproc drivers

#
# Rpmsg drivers
#
CONFIG_RPMSG=y
CONFIG_RPMSG_CTRL=y
CONFIG_RPMSG_NS=y
CONFIG_RPMSG_QCOM_GLINK=y
CONFIG_RPMSG_QCOM_GLINK_RPM=y
CONFIG_RPMSG_VIRTIO=y
# end of Rpmsg drivers

CONFIG_SOUNDWIRE=y

#
# SoundWire Devices
#
CONFIG_SOUNDWIRE_CADENCE=y
CONFIG_SOUNDWIRE_INTEL=y
CONFIG_SOUNDWIRE_QCOM=y
CONFIG_SOUNDWIRE_GENERIC_ALLOCATION=y

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#
# CONFIG_MESON_CANVAS is not set
CONFIG_MESON_CLK_MEASURE=y
CONFIG_MESON_GX_SOCINFO=y
CONFIG_MESON_MX_SOCINFO=y
# end of Amlogic SoC drivers

#
# Apple SoC drivers
#
CONFIG_APPLE_RTKIT=y
# CONFIG_APPLE_SART is not set
# end of Apple SoC drivers

#
# ASPEED SoC drivers
#
CONFIG_ASPEED_LPC_CTRL=y
CONFIG_ASPEED_LPC_SNOOP=y
# CONFIG_ASPEED_UART_ROUTING is not set
# CONFIG_ASPEED_P2A_CTRL is not set
CONFIG_ASPEED_SOCINFO=y
# end of ASPEED SoC drivers

CONFIG_AT91_SOC_ID=y
CONFIG_AT91_SOC_SFR=y

#
# Broadcom SoC drivers
#
CONFIG_BCM2835_POWER=y
# CONFIG_SOC_BCM63XX is not set
CONFIG_SOC_BRCMSTB=y
CONFIG_BCM_PMB=y
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
CONFIG_QUICC_ENGINE=y
CONFIG_UCC_SLOW=y
CONFIG_UCC=y
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
# CONFIG_IXP4XX_QMGR is not set
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
CONFIG_MTK_DEVAPC=y
CONFIG_MTK_INFRACFG=y
# CONFIG_MTK_PMIC_WRAP is not set
# CONFIG_MTK_SCPSYS is not set
# CONFIG_MTK_MMSYS is not set
# end of MediaTek SoC drivers

CONFIG_POLARFIRE_SOC_SYS_CTRL=y

#
# Qualcomm SoC drivers
#
# CONFIG_QCOM_COMMAND_DB is not set
CONFIG_QCOM_GENI_SE=y
CONFIG_QCOM_GSBI=y
CONFIG_QCOM_LLCC=y
CONFIG_QCOM_RPMH=y
# CONFIG_QCOM_SMEM is not set
CONFIG_QCOM_SMD_RPM=y
CONFIG_QCOM_SPM=y
CONFIG_QCOM_WCNSS_CTRL=y
# CONFIG_QCOM_ICC_BWMON is not set
# end of Qualcomm SoC drivers

CONFIG_SOC_RENESAS=y
CONFIG_RST_RCAR=y
CONFIG_SYSC_RCAR=y
CONFIG_SYSC_RCAR_GEN4=y
CONFIG_SYSC_R8A77995=y
# CONFIG_SYSC_R8A7794 is not set
# CONFIG_SYSC_R8A77990 is not set
CONFIG_SYSC_R8A7779=y
CONFIG_SYSC_R8A7790=y
# CONFIG_SYSC_R8A7795 is not set
CONFIG_SYSC_R8A7791=y
CONFIG_SYSC_R8A77965=y
CONFIG_SYSC_R8A77960=y
CONFIG_SYSC_R8A77961=y
# CONFIG_SYSC_R8A779F0 is not set
# CONFIG_SYSC_R8A7792 is not set
CONFIG_SYSC_R8A77980=y
CONFIG_SYSC_R8A77970=y
# CONFIG_SYSC_R8A779A0 is not set
# CONFIG_SYSC_R8A779G0 is not set
CONFIG_SYSC_RMOBILE=y
# CONFIG_SYSC_R8A77470 is not set
# CONFIG_SYSC_R8A7745 is not set
# CONFIG_SYSC_R8A7742 is not set
# CONFIG_SYSC_R8A7743 is not set
# CONFIG_SYSC_R8A774C0 is not set
# CONFIG_SYSC_R8A774E1 is not set
CONFIG_SYSC_R8A774A1=y
CONFIG_SYSC_R8A774B1=y
# CONFIG_ROCKCHIP_GRF is not set
# CONFIG_ROCKCHIP_IODOMAIN is not set
CONFIG_SOC_SAMSUNG=y
# CONFIG_EXYNOS_CHIPID is not set
CONFIG_EXYNOS_USI=y
# CONFIG_EXYNOS_PM_DOMAINS is not set
CONFIG_EXYNOS_REGULATOR_COUPLER=y
CONFIG_SOC_TEGRA20_VOLTAGE_COUPLER=y
# CONFIG_SOC_TEGRA30_VOLTAGE_COUPLER is not set
# CONFIG_SOC_TI is not set
CONFIG_UX500_SOC_ID=y

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
# CONFIG_ARM_TEGRA_DEVFREQ is not set
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
CONFIG_EXTCON_FSA9480=y
CONFIG_EXTCON_GPIO=y
CONFIG_EXTCON_INTEL_INT3496=y
CONFIG_EXTCON_MAX3355=y
CONFIG_EXTCON_MAX77693=y
# CONFIG_EXTCON_PTN5150 is not set
# CONFIG_EXTCON_QCOM_SPMI_MISC is not set
CONFIG_EXTCON_RT8973A=y
# CONFIG_EXTCON_SM5502 is not set
# CONFIG_EXTCON_USB_GPIO is not set
# CONFIG_EXTCON_USBC_TUSB320 is not set
CONFIG_MEMORY=y
CONFIG_DDR=y
CONFIG_ATMEL_SDRAMC=y
# CONFIG_ATMEL_EBI is not set
CONFIG_BRCMSTB_DPFE=y
CONFIG_BT1_L2_CTL=y
CONFIG_TI_AEMIF=y
# CONFIG_TI_EMIF is not set
# CONFIG_OMAP_GPMC is not set
# CONFIG_MVEBU_DEVBUS is not set
# CONFIG_FSL_CORENET_CF is not set
CONFIG_FSL_IFC=y
# CONFIG_JZ4780_NEMC is not set
CONFIG_MTK_SMI=y
# CONFIG_DA8XX_DDRCTL is not set
CONFIG_RENESAS_RPCIF=y
CONFIG_STM32_FMC2_EBI=y
# CONFIG_SAMSUNG_MC is not set
CONFIG_TEGRA_MC=y
CONFIG_TEGRA20_EMC=y
# CONFIG_TEGRA30_EMC is not set
CONFIG_TEGRA124_EMC=y
CONFIG_TEGRA210_EMC_TABLE=y
CONFIG_TEGRA210_EMC=y
# CONFIG_IIO is not set
# CONFIG_NTB is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_DEBUG is not set
CONFIG_PWM_ATMEL=y
CONFIG_PWM_ATMEL_TCB=y
CONFIG_PWM_BCM_IPROC=y
# CONFIG_PWM_BCM_KONA is not set
# CONFIG_PWM_BCM2835 is not set
CONFIG_PWM_BERLIN=y
CONFIG_PWM_BRCMSTB=y
# CONFIG_PWM_CLK is not set
# CONFIG_PWM_CLPS711X is not set
# CONFIG_PWM_DWC is not set
CONFIG_PWM_EP93XX=y
# CONFIG_PWM_FSL_FTM is not set
CONFIG_PWM_HIBVT=y
CONFIG_PWM_IMG=y
CONFIG_PWM_IMX1=y
CONFIG_PWM_IMX27=y
# CONFIG_PWM_IMX_TPM is not set
CONFIG_PWM_INTEL_LGM=y
# CONFIG_PWM_IQS620A is not set
CONFIG_PWM_JZ4740=y
# CONFIG_PWM_KEEMBAY is not set
CONFIG_PWM_LP3943=y
CONFIG_PWM_LPC18XX_SCT=y
# CONFIG_PWM_LPC32XX is not set
CONFIG_PWM_LPSS=y
# CONFIG_PWM_LPSS_PCI is not set
CONFIG_PWM_LPSS_PLATFORM=y
# CONFIG_PWM_MESON is not set
# CONFIG_PWM_MTK_DISP is not set
CONFIG_PWM_MEDIATEK=y
CONFIG_PWM_MXS=y
CONFIG_PWM_NTXEC=y
CONFIG_PWM_OMAP_DMTIMER=y
CONFIG_PWM_PCA9685=y
# CONFIG_PWM_PXA is not set
CONFIG_PWM_RASPBERRYPI_POE=y
CONFIG_PWM_RCAR=y
CONFIG_PWM_RENESAS_TPU=y
CONFIG_PWM_ROCKCHIP=y
# CONFIG_PWM_SAMSUNG is not set
CONFIG_PWM_SIFIVE=y
CONFIG_PWM_SL28CPLD=y
CONFIG_PWM_SPEAR=y
CONFIG_PWM_SPRD=y
# CONFIG_PWM_STI is not set
# CONFIG_PWM_STM32 is not set
CONFIG_PWM_STM32_LP=y
# CONFIG_PWM_SUN4I is not set
CONFIG_PWM_SUNPLUS=y
CONFIG_PWM_TEGRA=y
CONFIG_PWM_TIECAP=y
# CONFIG_PWM_TIEHRPWM is not set
CONFIG_PWM_TWL=y
CONFIG_PWM_TWL_LED=y
CONFIG_PWM_VISCONTI=y
CONFIG_PWM_VT8500=y
CONFIG_PWM_XILINX=y

#
# IRQ chip support
#
CONFIG_IRQCHIP=y
CONFIG_AL_FIC=y
CONFIG_MADERA_IRQ=y
# CONFIG_JCORE_AIC is not set
CONFIG_RENESAS_INTC_IRQPIN=y
# CONFIG_RENESAS_IRQC is not set
# CONFIG_RENESAS_RZA1_IRQC is not set
CONFIG_RENESAS_RZG2L_IRQC=y
CONFIG_SL28CPLD_INTC=y
CONFIG_TS4800_IRQ=y
CONFIG_XILINX_INTC=y
CONFIG_INGENIC_TCU_IRQ=y
# CONFIG_IRQ_UNIPHIER_AIDET is not set
CONFIG_MESON_IRQ_GPIO=y
# CONFIG_IMX_IRQSTEER is not set
CONFIG_IMX_INTMUX=y
CONFIG_EXYNOS_IRQ_COMBINER=y
CONFIG_IRQ_LOONGARCH_CPU=y
CONFIG_LOONGSON_LIOINTC=y
CONFIG_LOONGSON_EIOINTC=y
# CONFIG_LOONGSON_HTVEC is not set
CONFIG_LOONGSON_PCH_PIC=y
CONFIG_LOONGSON_PCH_MSI=y
CONFIG_LOONGSON_PCH_LPC=y
# CONFIG_MST_IRQ is not set
# CONFIG_MCHP_EIC is not set
# CONFIG_SUNPLUS_SP7021_INTC is not set
# end of IRQ chip support

# CONFIG_IPACK_BUS is not set
CONFIG_RESET_CONTROLLER=y
CONFIG_RESET_A10SR=y
# CONFIG_RESET_ATH79 is not set
CONFIG_RESET_AXS10X=y
CONFIG_RESET_BCM6345=y
CONFIG_RESET_BERLIN=y
CONFIG_RESET_BRCMSTB=y
CONFIG_RESET_BRCMSTB_RESCAL=y
# CONFIG_RESET_HSDK is not set
CONFIG_RESET_IMX7=y
CONFIG_RESET_INTEL_GW=y
CONFIG_RESET_K210=y
# CONFIG_RESET_LANTIQ is not set
# CONFIG_RESET_LPC18XX is not set
CONFIG_RESET_MCHP_SPARX5=y
CONFIG_RESET_MESON=y
# CONFIG_RESET_MESON_AUDIO_ARB is not set
CONFIG_RESET_NPCM=y
CONFIG_RESET_PISTACHIO=y
CONFIG_RESET_QCOM_AOSS=y
CONFIG_RESET_QCOM_PDC=y
# CONFIG_RESET_RASPBERRYPI is not set
CONFIG_RESET_RZG2L_USBPHY_CTRL=y
# CONFIG_RESET_SCMI is not set
CONFIG_RESET_SIMPLE=y
CONFIG_RESET_SOCFPGA=y
# CONFIG_RESET_STARFIVE_JH7100 is not set
CONFIG_RESET_SUNPLUS=y
# CONFIG_RESET_SUNXI is not set
CONFIG_RESET_TI_SCI=y
CONFIG_RESET_TI_SYSCON=y
CONFIG_RESET_TI_TPS380X=y
# CONFIG_RESET_TN48M_CPLD is not set
# CONFIG_RESET_UNIPHIER is not set
CONFIG_RESET_UNIPHIER_GLUE=y
# CONFIG_RESET_ZYNQ is not set
# CONFIG_COMMON_RESET_HI3660 is not set
CONFIG_COMMON_RESET_HI6220=y

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
CONFIG_GENERIC_PHY_MIPI_DPHY=y
# CONFIG_PHY_LPC18XX_USB_OTG is not set
CONFIG_PHY_PISTACHIO_USB=y
# CONFIG_PHY_XGENE is not set
CONFIG_PHY_CAN_TRANSCEIVER=y
# CONFIG_PHY_SUN6I_MIPI_DPHY is not set
# CONFIG_PHY_SUN50I_USB3 is not set
CONFIG_PHY_MESON8_HDMI_TX=y
CONFIG_PHY_MESON_G12A_MIPI_DPHY_ANALOG=y
CONFIG_PHY_MESON_G12A_USB2=y
# CONFIG_PHY_MESON_G12A_USB3_PCIE is not set
CONFIG_PHY_MESON_AXG_PCIE=y
CONFIG_PHY_MESON_AXG_MIPI_PCIE_ANALOG=y
CONFIG_PHY_MESON_AXG_MIPI_DPHY=y

#
# PHY drivers for Broadcom platforms
#
CONFIG_PHY_BCM63XX_USBH=y
# CONFIG_PHY_CYGNUS_PCIE is not set
CONFIG_PHY_BCM_SR_USB=y
CONFIG_BCM_KONA_USB2_PHY=y
# CONFIG_PHY_BCM_NS_USB2 is not set
# CONFIG_PHY_NS2_USB_DRD is not set
CONFIG_PHY_BRCM_SATA=y
# CONFIG_PHY_BRCM_USB is not set
CONFIG_PHY_BCM_SR_PCIE=y
# end of PHY drivers for Broadcom platforms

CONFIG_PHY_CADENCE_TORRENT=y
CONFIG_PHY_CADENCE_DPHY=y
CONFIG_PHY_CADENCE_DPHY_RX=y
# CONFIG_PHY_CADENCE_SIERRA is not set
CONFIG_PHY_CADENCE_SALVO=y
CONFIG_PHY_FSL_IMX8MQ_USB=y
# CONFIG_PHY_MIXEL_LVDS_PHY is not set
CONFIG_PHY_MIXEL_MIPI_DPHY=y
CONFIG_PHY_FSL_IMX8M_PCIE=y
CONFIG_PHY_FSL_LYNX_28G=y
CONFIG_PHY_HI6220_USB=y
CONFIG_PHY_HI3660_USB=y
CONFIG_PHY_HI3670_USB=y
# CONFIG_PHY_HI3670_PCIE is not set
CONFIG_PHY_HISTB_COMBPHY=y
CONFIG_PHY_HISI_INNO_USB2=y
CONFIG_PHY_LANTIQ_VRX200_PCIE=y
CONFIG_PHY_LANTIQ_RCU_USB2=y
CONFIG_ARMADA375_USBCLUSTER_PHY=y
# CONFIG_PHY_BERLIN_SATA is not set
# CONFIG_PHY_BERLIN_USB is not set
# CONFIG_PHY_MVEBU_A3700_UTMI is not set
CONFIG_PHY_MVEBU_A38X_COMPHY=y
CONFIG_PHY_PXA_28NM_HSIC=y
CONFIG_PHY_PXA_28NM_USB2=y
CONFIG_PHY_PXA_USB=y
CONFIG_PHY_MMP3_USB=y
CONFIG_PHY_MMP3_HSIC=y
CONFIG_PHY_MTK_PCIE=y
# CONFIG_PHY_MTK_TPHY is not set
CONFIG_PHY_MTK_UFS=y
CONFIG_PHY_MTK_XSPHY=y
CONFIG_PHY_MTK_HDMI=y
CONFIG_PHY_MTK_MIPI_DSI=y
CONFIG_PHY_MTK_DP=y
# CONFIG_PHY_SPARX5_SERDES is not set
# CONFIG_PHY_LAN966X_SERDES is not set
CONFIG_PHY_OCELOT_SERDES=y
CONFIG_PHY_ATH79_USB=y
CONFIG_PHY_QCOM_EDP=y
# CONFIG_PHY_QCOM_IPQ4019_USB is not set
CONFIG_PHY_QCOM_PCIE2=y
CONFIG_PHY_QCOM_QMP=y
# CONFIG_PHY_QCOM_QUSB2 is not set
CONFIG_PHY_QCOM_USB_SNPS_FEMTO_V2=y
CONFIG_PHY_QCOM_USB_HS_28NM=y
CONFIG_PHY_QCOM_USB_SS=y
CONFIG_PHY_QCOM_IPQ806X_USB=y
CONFIG_PHY_MT7621_PCI=y
CONFIG_PHY_RALINK_USB=y
# CONFIG_PHY_RCAR_GEN3_USB3 is not set
# CONFIG_PHY_ROCKCHIP_DPHY_RX0 is not set
# CONFIG_PHY_ROCKCHIP_INNO_HDMI is not set
# CONFIG_PHY_ROCKCHIP_INNO_CSIDPHY is not set
CONFIG_PHY_ROCKCHIP_INNO_DSIDPHY=y
CONFIG_PHY_ROCKCHIP_PCIE=y
# CONFIG_PHY_ROCKCHIP_TYPEC is not set
CONFIG_PHY_EXYNOS_DP_VIDEO=y
CONFIG_PHY_EXYNOS_MIPI_VIDEO=y
# CONFIG_PHY_EXYNOS_PCIE is not set
CONFIG_PHY_SAMSUNG_UFS=y
CONFIG_PHY_SAMSUNG_USB2=y
# CONFIG_PHY_S5PV210_USB2 is not set
# CONFIG_PHY_UNIPHIER_USB2 is not set
CONFIG_PHY_UNIPHIER_USB3=y
CONFIG_PHY_UNIPHIER_PCIE=y
# CONFIG_PHY_UNIPHIER_AHCI is not set
CONFIG_PHY_ST_SPEAR1310_MIPHY=y
CONFIG_PHY_ST_SPEAR1340_MIPHY=y
# CONFIG_PHY_STIH407_USB is not set
CONFIG_PHY_STM32_USBPHYC=y
CONFIG_PHY_TEGRA194_P2U=y
CONFIG_PHY_DA8XX_USB=y
CONFIG_PHY_AM654_SERDES=y
CONFIG_PHY_J721E_WIZ=y
CONFIG_OMAP_CONTROL_PHY=y
CONFIG_TI_PIPE3=y
CONFIG_PHY_INTEL_KEEMBAY_EMMC=y
# CONFIG_PHY_INTEL_KEEMBAY_USB is not set
# CONFIG_PHY_INTEL_LGM_COMBO is not set
CONFIG_PHY_INTEL_LGM_EMMC=y
CONFIG_PHY_INTEL_THUNDERBAY_EMMC=y
# CONFIG_PHY_XILINX_ZYNQMP is not set
# end of PHY Subsystem

# CONFIG_POWERCAP is not set
# CONFIG_MCB is not set

#
# Performance monitor support
#
# CONFIG_ARM_CCN is not set
CONFIG_ARM_CMN=y
# CONFIG_ARM_SMMU_V3_PMU is not set
CONFIG_FSL_IMX8_DDR_PMU=y
# CONFIG_XGENE_PMU is not set
CONFIG_ARM_DMC620_PMU=y
# CONFIG_MARVELL_CN10K_TAD_PMU is not set
CONFIG_HNS3_PMU=y
CONFIG_MARVELL_CN10K_DDR_PMU=y
# end of Performance monitor support

# CONFIG_RAS is not set
# CONFIG_USB4 is not set

#
# Android
#
CONFIG_ANDROID_BINDER_IPC=y
CONFIG_ANDROID_BINDERFS=y
CONFIG_ANDROID_BINDER_DEVICES="binder,hwbinder,vndbinder"
# CONFIG_ANDROID_BINDER_IPC_SELFTEST is not set
# end of Android

# CONFIG_LIBNVDIMM is not set
# CONFIG_DAX is not set
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y
CONFIG_NVMEM_IMX_IIM=y
# CONFIG_NVMEM_IMX_OCOTP is not set
# CONFIG_JZ4780_EFUSE is not set
CONFIG_NVMEM_LPC18XX_EEPROM=y
CONFIG_NVMEM_LPC18XX_OTP=y
CONFIG_NVMEM_MXS_OCOTP=y
# CONFIG_MTK_EFUSE is not set
# CONFIG_MICROCHIP_OTPC is not set
# CONFIG_NVMEM_NINTENDO_OTP is not set
# CONFIG_QCOM_QFPROM is not set
# CONFIG_NVMEM_SPMI_SDAM is not set
# CONFIG_ROCKCHIP_EFUSE is not set
# CONFIG_ROCKCHIP_OTP is not set
# CONFIG_NVMEM_BCM_OCOTP is not set
# CONFIG_NVMEM_STM32_ROMEM is not set
# CONFIG_UNIPHIER_EFUSE is not set
CONFIG_NVMEM_VF610_OCOTP=y
# CONFIG_MESON_MX_EFUSE is not set
CONFIG_NVMEM_SNVS_LPGPR=y
# CONFIG_SC27XX_EFUSE is not set
# CONFIG_SPRD_EFUSE is not set
CONFIG_NVMEM_RMEM=y
CONFIG_NVMEM_BRCM_NVRAM=y
CONFIG_NVMEM_LAYERSCAPE_SFP=y
# CONFIG_NVMEM_SUNPLUS_OCOTP is not set
CONFIG_NVMEM_APPLE_EFUSES=y

#
# HW tracing support
#
CONFIG_STM=y
# CONFIG_STM_PROTO_BASIC is not set
CONFIG_STM_PROTO_SYS_T=y
CONFIG_STM_DUMMY=y
CONFIG_STM_SOURCE_CONSOLE=y
# CONFIG_STM_SOURCE_HEARTBEAT is not set
CONFIG_STM_SOURCE_FTRACE=y
CONFIG_INTEL_TH=y
# CONFIG_INTEL_TH_PCI is not set
CONFIG_INTEL_TH_ACPI=y
CONFIG_INTEL_TH_GTH=y
# CONFIG_INTEL_TH_STH is not set
CONFIG_INTEL_TH_MSU=y
# CONFIG_INTEL_TH_PTI is not set
# CONFIG_INTEL_TH_DEBUG is not set
# end of HW tracing support

# CONFIG_FPGA is not set
# CONFIG_FSI is not set
# CONFIG_TEE is not set
CONFIG_MULTIPLEXER=y

#
# Multiplexer drivers
#
CONFIG_MUX_ADG792A=y
CONFIG_MUX_GPIO=y
CONFIG_MUX_MMIO=y
# end of Multiplexer drivers

CONFIG_PM_OPP=y
CONFIG_SIOX=y
CONFIG_SIOX_BUS_GPIO=y
CONFIG_SLIMBUS=y
# CONFIG_SLIM_QCOM_CTRL is not set
CONFIG_INTERCONNECT=y
# CONFIG_INTERCONNECT_IMX is not set
CONFIG_INTERCONNECT_QCOM_OSM_L3=y
CONFIG_INTERCONNECT_SAMSUNG=y
# CONFIG_INTERCONNECT_EXYNOS is not set
CONFIG_COUNTER=y
CONFIG_104_QUAD_8=y
CONFIG_INTERRUPT_CNT=y
CONFIG_STM32_TIMER_CNT=y
CONFIG_STM32_LPTIMER_CNT=y
# CONFIG_TI_EQEP is not set
CONFIG_FTM_QUADDEC=y
CONFIG_MICROCHIP_TCB_CAPTURE=y
CONFIG_INTEL_QEP=y
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
CONFIG_VALIDATE_FS_PARSER=y
CONFIG_FS_IOMAP=y
CONFIG_EXT2_FS=y
# CONFIG_EXT2_FS_XATTR is not set
CONFIG_EXT3_FS=y
# CONFIG_EXT3_FS_POSIX_ACL is not set
CONFIG_EXT3_FS_SECURITY=y
CONFIG_EXT4_FS=y
# CONFIG_EXT4_FS_POSIX_ACL is not set
CONFIG_EXT4_FS_SECURITY=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=y
CONFIG_JBD2_DEBUG=y
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=y
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
CONFIG_REISERFS_FS_XATTR=y
CONFIG_REISERFS_FS_POSIX_ACL=y
# CONFIG_REISERFS_FS_SECURITY is not set
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=y
CONFIG_XFS_SUPPORT_V4=y
# CONFIG_XFS_QUOTA is not set
# CONFIG_XFS_POSIX_ACL is not set
# CONFIG_XFS_RT is not set
CONFIG_XFS_ONLINE_SCRUB=y
# CONFIG_XFS_ONLINE_REPAIR is not set
# CONFIG_XFS_WARN is not set
# CONFIG_XFS_DEBUG is not set
CONFIG_GFS2_FS=y
CONFIG_BTRFS_FS=y
# CONFIG_BTRFS_FS_POSIX_ACL is not set
CONFIG_BTRFS_FS_CHECK_INTEGRITY=y
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
CONFIG_BTRFS_ASSERT=y
# CONFIG_BTRFS_FS_REF_VERIFY is not set
# CONFIG_NILFS2_FS is not set
CONFIG_F2FS_FS=y
CONFIG_F2FS_STAT_FS=y
CONFIG_F2FS_FS_XATTR=y
# CONFIG_F2FS_FS_POSIX_ACL is not set
CONFIG_F2FS_FS_SECURITY=y
# CONFIG_F2FS_CHECK_FS is not set
CONFIG_F2FS_FAULT_INJECTION=y
CONFIG_F2FS_FS_COMPRESSION=y
CONFIG_F2FS_FS_LZO=y
# CONFIG_F2FS_FS_LZORLE is not set
# CONFIG_F2FS_FS_LZ4 is not set
# CONFIG_F2FS_FS_ZSTD is not set
CONFIG_F2FS_IOSTAT=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
CONFIG_FS_ENCRYPTION_ALGS=y
CONFIG_FS_VERITY=y
# CONFIG_FS_VERITY_DEBUG is not set
# CONFIG_FS_VERITY_BUILTIN_SIGNATURES is not set
CONFIG_FSNOTIFY=y
# CONFIG_DNOTIFY is not set
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
# CONFIG_FANOTIFY_ACCESS_PERMISSIONS is not set
CONFIG_QUOTA=y
CONFIG_PRINT_QUOTA_WARNING=y
CONFIG_QUOTA_DEBUG=y
CONFIG_QUOTA_TREE=y
CONFIG_QFMT_V1=y
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=y
CONFIG_CUSE=y
CONFIG_VIRTIO_FS=y
CONFIG_OVERLAY_FS=y
CONFIG_OVERLAY_FS_REDIRECT_DIR=y
CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW=y
# CONFIG_OVERLAY_FS_INDEX is not set
CONFIG_OVERLAY_FS_XINO_AUTO=y
CONFIG_OVERLAY_FS_METACOPY=y

#
# Caches
#
CONFIG_NETFS_SUPPORT=y
CONFIG_NETFS_STATS=y
CONFIG_FSCACHE=y
# CONFIG_FSCACHE_STATS is not set
CONFIG_FSCACHE_DEBUG=y
# CONFIG_CACHEFILES is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
# CONFIG_JOLIET is not set
# CONFIG_ZISOFS is not set
CONFIG_UDF_FS=y
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/EXFAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
CONFIG_FAT_DEFAULT_UTF8=y
# CONFIG_EXFAT_FS is not set
CONFIG_NTFS_FS=y
# CONFIG_NTFS_DEBUG is not set
# CONFIG_NTFS_RW is not set
# CONFIG_NTFS3_FS is not set
# end of DOS/FAT/EXFAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
# CONFIG_TMPFS is not set
CONFIG_ARCH_SUPPORTS_HUGETLBFS=y
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_MEMFD_CREATE=y
CONFIG_CONFIGFS_FS=y
CONFIG_EFIVAR_FS=y
# end of Pseudo filesystems

# CONFIG_MISC_FILESYSTEMS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
# CONFIG_NLS_CODEPAGE_437 is not set
CONFIG_NLS_CODEPAGE_737=y
CONFIG_NLS_CODEPAGE_775=y
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
CONFIG_NLS_CODEPAGE_855=y
CONFIG_NLS_CODEPAGE_857=y
CONFIG_NLS_CODEPAGE_860=y
CONFIG_NLS_CODEPAGE_861=y
CONFIG_NLS_CODEPAGE_862=y
# CONFIG_NLS_CODEPAGE_863 is not set
CONFIG_NLS_CODEPAGE_864=y
# CONFIG_NLS_CODEPAGE_865 is not set
CONFIG_NLS_CODEPAGE_866=y
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
CONFIG_NLS_CODEPAGE_932=y
CONFIG_NLS_CODEPAGE_949=y
CONFIG_NLS_CODEPAGE_874=y
CONFIG_NLS_ISO8859_8=y
# CONFIG_NLS_CODEPAGE_1250 is not set
CONFIG_NLS_CODEPAGE_1251=y
# CONFIG_NLS_ASCII is not set
CONFIG_NLS_ISO8859_1=y
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
CONFIG_NLS_ISO8859_4=y
CONFIG_NLS_ISO8859_5=y
CONFIG_NLS_ISO8859_6=y
CONFIG_NLS_ISO8859_7=y
CONFIG_NLS_ISO8859_9=y
CONFIG_NLS_ISO8859_13=y
CONFIG_NLS_ISO8859_14=y
CONFIG_NLS_ISO8859_15=y
CONFIG_NLS_KOI8_R=y
CONFIG_NLS_KOI8_U=y
CONFIG_NLS_MAC_ROMAN=y
CONFIG_NLS_MAC_CELTIC=y
CONFIG_NLS_MAC_CENTEURO=y
CONFIG_NLS_MAC_CROATIAN=y
CONFIG_NLS_MAC_CYRILLIC=y
CONFIG_NLS_MAC_GAELIC=y
CONFIG_NLS_MAC_GREEK=y
# CONFIG_NLS_MAC_ICELAND is not set
# CONFIG_NLS_MAC_INUIT is not set
# CONFIG_NLS_MAC_ROMANIAN is not set
# CONFIG_NLS_MAC_TURKISH is not set
# CONFIG_NLS_UTF8 is not set
CONFIG_UNICODE=y
CONFIG_UNICODE_NORMALIZATION_SELFTEST=y
CONFIG_IO_WQ=y
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
CONFIG_KEYS_REQUEST_CACHE=y
# CONFIG_PERSISTENT_KEYRINGS is not set
# CONFIG_TRUSTED_KEYS is not set
CONFIG_ENCRYPTED_KEYS=y
CONFIG_USER_DECRYPTED_DATA=y
CONFIG_KEY_DH_OPERATIONS=y
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
CONFIG_SECURITY_PATH=y
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
# CONFIG_STATIC_USERMODEHELPER is not set
# CONFIG_SECURITY_LOADPIN is not set
# CONFIG_SECURITY_YAMA is not set
# CONFIG_SECURITY_SAFESETID is not set
# CONFIG_SECURITY_LOCKDOWN_LSM is not set
CONFIG_SECURITY_LANDLOCK=y
CONFIG_INTEGRITY=y
# CONFIG_INTEGRITY_SIGNATURE is not set
CONFIG_IMA=y
CONFIG_IMA_MEASURE_PCR_IDX=10
# CONFIG_IMA_NG_TEMPLATE is not set
CONFIG_IMA_SIG_TEMPLATE=y
CONFIG_IMA_DEFAULT_TEMPLATE="ima-sig"
# CONFIG_IMA_DEFAULT_HASH_SHA1 is not set
# CONFIG_IMA_DEFAULT_HASH_SHA256 is not set
CONFIG_IMA_DEFAULT_HASH_SHA512=y
# CONFIG_IMA_DEFAULT_HASH_SM3 is not set
CONFIG_IMA_DEFAULT_HASH="sha512"
CONFIG_IMA_WRITE_POLICY=y
# CONFIG_IMA_READ_POLICY is not set
# CONFIG_IMA_APPRAISE is not set
CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS=y
# CONFIG_IMA_DISABLE_HTABLE is not set
CONFIG_EVM=y
# CONFIG_EVM_ATTR_FSUUID is not set
# CONFIG_EVM_ADD_XATTRS is not set
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
# CONFIG_ZERO_CALL_USED_REGS is not set
# end of Memory initialization

CONFIG_RANDSTRUCT_NONE=y
# end of Kernel hardening options
# end of Security options

CONFIG_XOR_BLOCKS=y
CONFIG_ASYNC_TX_DISABLE_PQ_VAL_DMA=y
CONFIG_ASYNC_TX_DISABLE_XOR_VAL_DMA=y
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
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
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
# CONFIG_CRYPTO_PCRYPT is not set
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=y
CONFIG_CRYPTO_ENGINE=y

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=y
# CONFIG_CRYPTO_DH_RFC7919_GROUPS is not set
CONFIG_CRYPTO_ECC=y
CONFIG_CRYPTO_ECDH=y
CONFIG_CRYPTO_ECDSA=y
CONFIG_CRYPTO_ECRDSA=y
CONFIG_CRYPTO_SM2=y
CONFIG_CRYPTO_CURVE25519=y

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=y
# CONFIG_CRYPTO_GCM is not set
CONFIG_CRYPTO_CHACHA20POLY1305=y
CONFIG_CRYPTO_AEGIS128=y
# CONFIG_CRYPTO_SEQIV is not set
# CONFIG_CRYPTO_ECHAINIV is not set

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CFB=y
CONFIG_CRYPTO_CTR=y
# CONFIG_CRYPTO_CTS is not set
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=y
CONFIG_CRYPTO_OFB=y
CONFIG_CRYPTO_PCBC=y
CONFIG_CRYPTO_XCTR=y
CONFIG_CRYPTO_XTS=y
CONFIG_CRYPTO_KEYWRAP=y
# CONFIG_CRYPTO_ADIANTUM is not set
CONFIG_CRYPTO_HCTR2=y
CONFIG_CRYPTO_ESSIV=y

#
# Hash modes
#
# CONFIG_CRYPTO_CMAC is not set
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=y
CONFIG_CRYPTO_VMAC=y

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32=y
CONFIG_CRYPTO_XXHASH=y
CONFIG_CRYPTO_BLAKE2B=y
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRC64_ROCKSOFT=y
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_POLYVAL=y
CONFIG_CRYPTO_POLY1305=y
CONFIG_CRYPTO_MD4=y
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=y
# CONFIG_CRYPTO_RMD160 is not set
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=y
CONFIG_CRYPTO_SM3=y
# CONFIG_CRYPTO_SM3_GENERIC is not set
CONFIG_CRYPTO_STREEBOG=y
# CONFIG_CRYPTO_WP512 is not set

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_AES_TI=y
CONFIG_CRYPTO_BLOWFISH=y
CONFIG_CRYPTO_BLOWFISH_COMMON=y
CONFIG_CRYPTO_CAMELLIA=y
CONFIG_CRYPTO_CAST_COMMON=y
CONFIG_CRYPTO_CAST5=y
CONFIG_CRYPTO_CAST6=y
CONFIG_CRYPTO_DES=y
CONFIG_CRYPTO_FCRYPT=y
CONFIG_CRYPTO_CHACHA20=y
CONFIG_CRYPTO_ARIA=y
# CONFIG_CRYPTO_SERPENT is not set
CONFIG_CRYPTO_SM4=y
CONFIG_CRYPTO_SM4_GENERIC=y
CONFIG_CRYPTO_TWOFISH=y
CONFIG_CRYPTO_TWOFISH_COMMON=y

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
CONFIG_CRYPTO_842=y
CONFIG_CRYPTO_LZ4=y
CONFIG_CRYPTO_LZ4HC=y
CONFIG_CRYPTO_ZSTD=y

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=y
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
# CONFIG_CRYPTO_DRBG_HASH is not set
# CONFIG_CRYPTO_DRBG_CTR is not set
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_KDF800108_CTR=y
CONFIG_CRYPTO_HASH_INFO=y
CONFIG_CRYPTO_HW=y
# CONFIG_CRYPTO_DEV_ALLWINNER is not set
CONFIG_CRYPTO_DEV_EXYNOS_RNG=y
CONFIG_CRYPTO_DEV_S5P=y
CONFIG_CRYPTO_DEV_ATMEL_AUTHENC=y
CONFIG_CRYPTO_DEV_ATMEL_AES=y
# CONFIG_CRYPTO_DEV_ATMEL_TDES is not set
CONFIG_CRYPTO_DEV_ATMEL_SHA=y
CONFIG_CRYPTO_DEV_ATMEL_I2C=y
CONFIG_CRYPTO_DEV_ATMEL_ECC=y
CONFIG_CRYPTO_DEV_ATMEL_SHA204A=y
CONFIG_CRYPTO_DEV_QAT=y
CONFIG_CRYPTO_DEV_QAT_DH895xCC=y
CONFIG_CRYPTO_DEV_QAT_C3XXX=y
# CONFIG_CRYPTO_DEV_QAT_C62X is not set
CONFIG_CRYPTO_DEV_QAT_4XXX=y
CONFIG_CRYPTO_DEV_QAT_DH895xCCVF=y
# CONFIG_CRYPTO_DEV_QAT_C3XXXVF is not set
CONFIG_CRYPTO_DEV_QAT_C62XVF=y
CONFIG_CRYPTO_DEV_CPT=y
CONFIG_CAVIUM_CPT=y
# CONFIG_CRYPTO_DEV_NITROX_CNN55XX is not set
CONFIG_CRYPTO_DEV_MARVELL=y
CONFIG_CRYPTO_DEV_OCTEONTX_CPT=y
CONFIG_CRYPTO_DEV_CAVIUM_ZIP=y
# CONFIG_CRYPTO_DEV_QCE is not set
# CONFIG_CRYPTO_DEV_QCOM_RNG is not set
CONFIG_CRYPTO_DEV_IMGTEC_HASH=y
# CONFIG_CRYPTO_DEV_ZYNQMP_AES is not set
CONFIG_CRYPTO_DEV_ZYNQMP_SHA3=y
CONFIG_CRYPTO_DEV_VIRTIO=y
CONFIG_CRYPTO_DEV_SAFEXCEL=y
# CONFIG_CRYPTO_DEV_CCREE is not set
CONFIG_CRYPTO_DEV_HISI_SEC=y
# CONFIG_CRYPTO_DEV_HISI_SEC2 is not set
CONFIG_CRYPTO_DEV_HISI_QM=y
# CONFIG_CRYPTO_DEV_HISI_ZIP is not set
CONFIG_CRYPTO_DEV_HISI_HPRE=y
# CONFIG_CRYPTO_DEV_AMLOGIC_GXL is not set
CONFIG_CRYPTO_DEV_SA2UL=y
CONFIG_CRYPTO_DEV_KEEMBAY_OCS_AES_SM4=y
CONFIG_CRYPTO_DEV_KEEMBAY_OCS_AES_SM4_ECB=y
CONFIG_CRYPTO_DEV_KEEMBAY_OCS_AES_SM4_CTS=y
CONFIG_CRYPTO_DEV_KEEMBAY_OCS_ECC=y
CONFIG_CRYPTO_DEV_KEEMBAY_OCS_HCU=y
CONFIG_CRYPTO_DEV_KEEMBAY_OCS_HCU_HMAC_SHA224=y
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
CONFIG_PKCS8_PRIVATE_KEY_PARSER=y
# CONFIG_PKCS7_MESSAGE_PARSER is not set

#
# Certificates for signature checking
#
# CONFIG_SYSTEM_TRUSTED_KEYRING is not set
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=y
# CONFIG_RAID6_PQ_BENCHMARK is not set
CONFIG_LINEAR_RANGES=y
CONFIG_PACKING=y
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_CORDIC=y
# CONFIG_PRIME_NUMBERS is not set
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_STMP_DEVICE=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=y
CONFIG_CRYPTO_LIB_CHACHA=y
CONFIG_CRYPTO_LIB_CURVE25519_GENERIC=y
CONFIG_CRYPTO_LIB_CURVE25519=y
CONFIG_CRYPTO_LIB_DES=y
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=1
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=y
CONFIG_CRYPTO_LIB_POLY1305=y
# CONFIG_CRYPTO_LIB_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_LIB_SHA1=y
CONFIG_CRYPTO_LIB_SHA256=y
# end of Crypto library routines

CONFIG_LIB_MEMNEQ=y
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC64_ROCKSOFT=y
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
CONFIG_CRC32_SELFTEST=y
# CONFIG_CRC32_SLICEBY8 is not set
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
CONFIG_CRC32_BIT=y
CONFIG_CRC64=y
# CONFIG_CRC4 is not set
CONFIG_CRC7=y
CONFIG_LIBCRC32C=y
CONFIG_CRC8=y
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_842_COMPRESS=y
CONFIG_842_DECOMPRESS=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_COMPRESS=y
CONFIG_LZ4HC_COMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=y
CONFIG_ZSTD_DECOMPRESS=y
# CONFIG_XZ_DEC is not set
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=y
CONFIG_REED_SOLOMON_DEC16=y
CONFIG_BCH=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_DMA_DECLARE_COHERENT=y
CONFIG_SWIOTLB=y
CONFIG_DMA_RESTRICTED_POOL=y
# CONFIG_DMA_API_DEBUG is not set
# CONFIG_DMA_MAP_BENCHMARK is not set
CONFIG_SGL_ALLOC=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_GLOB=y
CONFIG_GLOB_SELFTEST=y
CONFIG_CLZ_TAB=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_LIBFDT=y
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_FONT_SUPPORT=y
CONFIG_FONT_8x16=y
CONFIG_FONT_AUTOSELECT=y
CONFIG_SG_SPLIT=y
CONFIG_SG_POOL=y
CONFIG_ARCH_STACKWALK=y
CONFIG_STACKDEPOT=y
CONFIG_SBITMAP=y
CONFIG_PARMAN=y
CONFIG_OBJAGG=y
# end of Library routines

CONFIG_GENERIC_LIB_ASHLDI3=y
CONFIG_GENERIC_LIB_ASHRDI3=y
CONFIG_GENERIC_LIB_LSHRDI3=y
CONFIG_GENERIC_LIB_CMPDI2=y
CONFIG_GENERIC_LIB_UCMPDI2=y

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
# CONFIG_PRINTK_CALLER is not set
CONFIG_STACKTRACE_BUILD_ID=y
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
# CONFIG_BOOT_PRINTK_DELAY is not set
CONFIG_DYNAMIC_DEBUG=y
CONFIG_DYNAMIC_DEBUG_CORE=y
# CONFIG_SYMBOLIC_ERRNAME is not set
# end of printk and dmesg options

CONFIG_DEBUG_KERNEL=y
# CONFIG_DEBUG_MISC is not set

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO_NONE=y
# CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is not set
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_DEBUG_INFO_DWARF5 is not set
CONFIG_FRAME_WARN=2048
# CONFIG_STRIP_ASM_SYMS is not set
# CONFIG_READABLE_ASM is not set
# CONFIG_HEADERS_INSTALL is not set
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_DEBUG_FORCE_WEAK_PER_CPU=y
# end of Compile-time checks and compiler options

#
# Generic Kernel Debugging Instruments
#
# CONFIG_MAGIC_SYSRQ is not set
CONFIG_DEBUG_FS=y
CONFIG_DEBUG_FS_ALLOW_ALL=y
# CONFIG_DEBUG_FS_DISALLOW_MOUNT is not set
# CONFIG_DEBUG_FS_ALLOW_NONE is not set
# CONFIG_UBSAN is not set
CONFIG_HAVE_KCSAN_COMPILER=y
# end of Generic Kernel Debugging Instruments

#
# Networking Debugging
#
# CONFIG_NET_DEV_REFCNT_TRACKER is not set
# CONFIG_NET_NS_REFCNT_TRACKER is not set
# end of Networking Debugging

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
# CONFIG_DEBUG_PAGEALLOC is not set
CONFIG_SLUB_DEBUG=y
# CONFIG_SLUB_DEBUG_ON is not set
CONFIG_PAGE_OWNER=y
CONFIG_PAGE_POISONING=y
CONFIG_DEBUG_PAGE_REF=y
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SHRINKER_DEBUG is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_SCHED_STACK_END_CHECK is not set
# CONFIG_DEBUG_VM is not set
CONFIG_DEBUG_MEMORY_INIT=y
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
CONFIG_DEBUG_STACKOVERFLOW=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
# end of Memory Debugging

CONFIG_DEBUG_SHIRQ=y

#
# Debug Oops, Lockups and Hangs
#
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=y
# CONFIG_DETECT_HUNG_TASK is not set
CONFIG_WQ_WATCHDOG=y
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
CONFIG_SCHED_DEBUG=y
# CONFIG_SCHEDSTATS is not set
# end of Scheduler Debugging

CONFIG_DEBUG_TIMEKEEPING=y
CONFIG_DEBUG_PREEMPT=y

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
CONFIG_PROVE_LOCKING=y
CONFIG_PROVE_RAW_LOCK_NESTING=y
CONFIG_LOCK_STAT=y
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
# CONFIG_DEBUG_LOCKDEP is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_LOCK_TORTURE_TEST is not set
# CONFIG_WW_MUTEX_SELFTEST is not set
# CONFIG_SCF_TORTURE_TEST is not set
# CONFIG_CSD_LOCK_WAIT_DEBUG is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_TRACE_IRQFLAGS=y
CONFIG_DEBUG_IRQFLAGS=y
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
CONFIG_DEBUG_KOBJECT=y

#
# Debug kernel data structures
#
CONFIG_DEBUG_LIST=y
CONFIG_DEBUG_PLIST=y
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
CONFIG_BUG_ON_DATA_CORRUPTION=y
# end of Debug kernel data structures

CONFIG_DEBUG_CREDENTIALS=y

#
# RCU Debugging
#
CONFIG_PROVE_RCU=y
CONFIG_TORTURE_TEST=y
CONFIG_RCU_SCALE_TEST=y
# CONFIG_RCU_TORTURE_TEST is not set
CONFIG_RCU_REF_SCALE_TEST=y
CONFIG_RCU_CPU_STALL_TIMEOUT=21
CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=0
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
CONFIG_CPU_HOTPLUG_STATE_CONTROL=y
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
# CONFIG_STRICT_DEVMEM is not set

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
CONFIG_FAILSLAB=y
CONFIG_FAIL_PAGE_ALLOC=y
CONFIG_FAULT_INJECTION_USERCOPY=y
# CONFIG_FAIL_MAKE_REQUEST is not set
# CONFIG_FAIL_IO_TIMEOUT is not set
# CONFIG_FAIL_FUTEX is not set
# CONFIG_FAULT_INJECTION_DEBUG_FS is not set
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_RUNTIME_TESTING_MENU is not set
# end of Kernel Testing and Coverage

# CONFIG_WARN_MISSING_DOCUMENTS is not set
# CONFIG_WARN_ABI_ERRORS is not set
# end of Kernel hacking

--W/q7qJiNgbBno5WO--
