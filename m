Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA4672936F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 10:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240838AbjFIIk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 04:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238462AbjFIIkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 04:40:25 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 612722D7B
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 01:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686300001; x=1717836001;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8d8EZLl9aLDs76xNI8gDdKl0+/w1V8ZJkq3N24V7zo4=;
  b=cbf2qvHXQnWpzOXp825hvpuB71vU9Wxcmx0WfTDEdhOoamKmy1bj9KsS
   ZY55u94/cf2c3Ro/1AFZDkXCN+zMuKRK8tKW0c44p5bc2oc3eQh+U2RAs
   AOXYdnXNISyW6uWsYIdhWfez9/lTvJNnMgSt3211bXgbGR3LFqhAhwx51
   LvBHSPq1DPCdR7CylM7xvbYwVLsiZ5BjMuY1myn7dYvbdLEVY+1TaAWzG
   0n8PJyzYmtSiT49q3g1smhbYMVynhTVgCLcsbDrTtCaxwViXbxr/0NrAw
   fPjDnofk37WC+Ddfpy5IIkpwKzwXJBEAysazaDuyjlgGfSGQcExN/YzD6
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="337184615"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; 
   d="scan'208";a="337184615"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 01:40:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="713429673"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; 
   d="scan'208";a="713429673"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 09 Jun 2023 01:39:59 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q7Xf4-0008rc-2O;
        Fri, 09 Jun 2023 08:39:58 +0000
Date:   Fri, 9 Jun 2023 16:39:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: drivers/memstick/host/r592.c:83:9: sparse: sparse: incorrect type in
 assignment (different base types)
Message-ID: <202306091608.zuOYo5EP-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   33f2b5785a2b6b0ed1948aafee60d3abb12f1e3a
commit: d4aa8affa1e9e51c237a1ec47a97e96dce76c98c m68knommu: fix use of cpu_to_le() on IO access
date:   2 years, 10 months ago
config: m68k-randconfig-s041-20230608 (https://download.01.org/0day-ci/archive/20230609/202306091608.zuOYo5EP-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.3.0
reproduce:
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d4aa8affa1e9e51c237a1ec47a97e96dce76c98c
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout d4aa8affa1e9e51c237a1ec47a97e96dce76c98c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=m68k olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306091608.zuOYo5EP-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/memstick/host/r592.c:83:9: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int volatile [usertype] @@     got restricted __be32 [usertype] @@
   drivers/memstick/host/r592.c:83:9: sparse:     expected unsigned int volatile [usertype]
   drivers/memstick/host/r592.c:83:9: sparse:     got restricted __be32 [usertype]
>> drivers/memstick/host/r592.c:83:9: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int volatile [usertype] @@     got restricted __be32 [usertype] @@
   drivers/memstick/host/r592.c:83:9: sparse:     expected unsigned int volatile [usertype]
   drivers/memstick/host/r592.c:83:9: sparse:     got restricted __be32 [usertype]
>> drivers/memstick/host/r592.c:83:9: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int volatile [usertype] @@     got restricted __be32 [usertype] @@
   drivers/memstick/host/r592.c:83:9: sparse:     expected unsigned int volatile [usertype]
   drivers/memstick/host/r592.c:83:9: sparse:     got restricted __be32 [usertype]
   drivers/memstick/host/r592.c:75:16: sparse: sparse: cast to restricted __be32
   drivers/memstick/host/r592.c:75:16: sparse: sparse: cast to restricted __be32

vim +83 drivers/memstick/host/r592.c

9263412501022f Maxim Levitsky 2011-03-25  42  
9263412501022f Maxim Levitsky 2011-03-25  43  /**
9263412501022f Maxim Levitsky 2011-03-25  44   * memstick_debug_get_tpc_name - debug helper that returns string for
9263412501022f Maxim Levitsky 2011-03-25  45   * a TPC number
9263412501022f Maxim Levitsky 2011-03-25  46   */
9263412501022f Maxim Levitsky 2011-03-25 @47  const char *memstick_debug_get_tpc_name(int tpc)
9263412501022f Maxim Levitsky 2011-03-25  48  {
9263412501022f Maxim Levitsky 2011-03-25  49  	return tpc_names[tpc-1];
9263412501022f Maxim Levitsky 2011-03-25  50  }
9263412501022f Maxim Levitsky 2011-03-25  51  EXPORT_SYMBOL(memstick_debug_get_tpc_name);
9263412501022f Maxim Levitsky 2011-03-25  52  
9263412501022f Maxim Levitsky 2011-03-25  53  
9263412501022f Maxim Levitsky 2011-03-25  54  /* Read a register*/
9263412501022f Maxim Levitsky 2011-03-25  55  static inline u32 r592_read_reg(struct r592_device *dev, int address)
9263412501022f Maxim Levitsky 2011-03-25  56  {
9263412501022f Maxim Levitsky 2011-03-25  57  	u32 value = readl(dev->mmio + address);
9263412501022f Maxim Levitsky 2011-03-25  58  	dbg_reg("reg #%02d == 0x%08x", address, value);
9263412501022f Maxim Levitsky 2011-03-25  59  	return value;
9263412501022f Maxim Levitsky 2011-03-25  60  }
9263412501022f Maxim Levitsky 2011-03-25  61  
9263412501022f Maxim Levitsky 2011-03-25  62  /* Write a register */
9263412501022f Maxim Levitsky 2011-03-25  63  static inline void r592_write_reg(struct r592_device *dev,
9263412501022f Maxim Levitsky 2011-03-25  64  							int address, u32 value)
9263412501022f Maxim Levitsky 2011-03-25  65  {
9263412501022f Maxim Levitsky 2011-03-25  66  	dbg_reg("reg #%02d <- 0x%08x", address, value);
9263412501022f Maxim Levitsky 2011-03-25  67  	writel(value, dev->mmio + address);
9263412501022f Maxim Levitsky 2011-03-25  68  }
9263412501022f Maxim Levitsky 2011-03-25  69  
9263412501022f Maxim Levitsky 2011-03-25  70  /* Reads a big endian DWORD register */
9263412501022f Maxim Levitsky 2011-03-25  71  static inline u32 r592_read_reg_raw_be(struct r592_device *dev, int address)
9263412501022f Maxim Levitsky 2011-03-25  72  {
9263412501022f Maxim Levitsky 2011-03-25  73  	u32 value = __raw_readl(dev->mmio + address);
9263412501022f Maxim Levitsky 2011-03-25  74  	dbg_reg("reg #%02d == 0x%08x", address, value);
9263412501022f Maxim Levitsky 2011-03-25  75  	return be32_to_cpu(value);
9263412501022f Maxim Levitsky 2011-03-25  76  }
9263412501022f Maxim Levitsky 2011-03-25  77  
9263412501022f Maxim Levitsky 2011-03-25  78  /* Writes a big endian DWORD register */
9263412501022f Maxim Levitsky 2011-03-25  79  static inline void r592_write_reg_raw_be(struct r592_device *dev,
9263412501022f Maxim Levitsky 2011-03-25  80  							int address, u32 value)
9263412501022f Maxim Levitsky 2011-03-25  81  {
9263412501022f Maxim Levitsky 2011-03-25  82  	dbg_reg("reg #%02d <- 0x%08x", address, value);
9263412501022f Maxim Levitsky 2011-03-25 @83  	__raw_writel(cpu_to_be32(value), dev->mmio + address);
9263412501022f Maxim Levitsky 2011-03-25  84  }
9263412501022f Maxim Levitsky 2011-03-25  85  

:::::: The code at line 83 was first introduced by commit
:::::: 9263412501022fecef844907129ee2513b5a89de memstick: add driver for Ricoh R5C592 card reader

:::::: TO: Maxim Levitsky <maximlevitsky@gmail.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
