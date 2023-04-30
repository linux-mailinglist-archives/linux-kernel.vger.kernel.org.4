Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 178D46F2812
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Apr 2023 10:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjD3Ia1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 04:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjD3IaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 04:30:25 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C7019A2
        for <linux-kernel@vger.kernel.org>; Sun, 30 Apr 2023 01:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682843424; x=1714379424;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xHtJVUpepZ/08IQR0gZg205bEVCM3PAELJoyRRLzmjI=;
  b=b69T801NDXRSQUotxo7EzUzvKTQsuLylEPLuWmLDt3uBHNcQ/MEPMEZu
   8KWHXRYg9HGglUgW3hNo8OTuolRWbJZVGL7MLcg4wtqi6pxVQpv3Ee3d8
   hrxmHUSelSwYmiMfx3LKGUaaTEPpzigCOBg+vujYiQ1TnYyd9U6EM2RyC
   9oZIqmb2Q8wuSls/n/oO3WckdkituRm3wuUVQ5YyH1DH/9CEZRJ3HwWz5
   ziBp78ZHVOVMIOBEgZ3ieIi//840QHxMIys1uHNgXV6M2pGk1ftQGPh4p
   6cufkXr8Lwe0YQSHvmyEk2FQOp3jwbleukXzAu4LLEyWBtFBS/8DKMtP4
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10695"; a="376034465"
X-IronPort-AV: E=Sophos;i="5.99,238,1677571200"; 
   d="scan'208";a="376034465"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2023 01:30:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10695"; a="839493108"
X-IronPort-AV: E=Sophos;i="5.99,238,1677571200"; 
   d="scan'208";a="839493108"
Received: from lkp-server01.sh.intel.com (HELO 5bad9d2b7fcb) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 30 Apr 2023 01:30:22 -0700
Received: from kbuild by 5bad9d2b7fcb with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pt2Rp-0001Zp-3D;
        Sun, 30 Apr 2023 08:30:22 +0000
Date:   Sun, 30 Apr 2023 16:30:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>
Subject: riscv64-linux-ld: warning: orphan section `.init.data.rel.ro.local'
 from `arch/riscv/kernel/pi/lib-fdt.pi.o' being placed in section
 `.init.data.rel.ro.local'
Message-ID: <202304301606.Cgp113Ha-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   825a0714d2b3883d4f8ff64f6933fb73ee3f1834
commit: 26e7aacb83dfd04330673c5c9ac336560da52bb3 riscv: Allow to downgrade paging mode from the command line
date:   4 days ago
config: riscv-randconfig-r005-20230430 (https://download.01.org/0day-ci/archive/20230430/202304301606.Cgp113Ha-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=26e7aacb83dfd04330673c5c9ac336560da52bb3
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 26e7aacb83dfd04330673c5c9ac336560da52bb3
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=riscv olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304301606.Cgp113Ha-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> riscv64-linux-ld: warning: orphan section `.init.data.rel.ro.local' from `arch/riscv/kernel/pi/lib-fdt.pi.o' being placed in section `.init.data.rel.ro.local'
>> riscv64-linux-ld: warning: orphan section `.init.printk_index' from `arch/riscv/kernel/pi/lib-fdt.pi.o' being placed in section `.init.printk_index'
>> riscv64-linux-ld: warning: orphan section `.init.data.rel.ro.local' from `arch/riscv/kernel/pi/lib-fdt.pi.o' being placed in section `.init.data.rel.ro.local'
>> riscv64-linux-ld: warning: orphan section `.init.printk_index' from `arch/riscv/kernel/pi/lib-fdt.pi.o' being placed in section `.init.printk_index'
>> riscv64-linux-ld: warning: orphan section `.init.data.rel.ro.local' from `arch/riscv/kernel/pi/lib-fdt.pi.o' being placed in section `.init.data.rel.ro.local'
>> riscv64-linux-ld: warning: orphan section `.init.printk_index' from `arch/riscv/kernel/pi/lib-fdt.pi.o' being placed in section `.init.printk_index'
>> riscv64-linux-ld: warning: orphan section `.init.data.rel.ro.local' from `arch/riscv/kernel/pi/lib-fdt.pi.o' being placed in section `.init.data.rel.ro.local'
>> riscv64-linux-ld: warning: orphan section `.init.printk_index' from `arch/riscv/kernel/pi/lib-fdt.pi.o' being placed in section `.init.printk_index'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
