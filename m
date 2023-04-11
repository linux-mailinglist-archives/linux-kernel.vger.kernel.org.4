Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 450DC6DE57F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 22:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjDKUIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 16:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbjDKUHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 16:07:42 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A429A4EE8
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 13:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681243611; x=1712779611;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=UfOUvuJHeut6EmXf3sCGrtWFR0/2VDiA1r8P3zkV+VE=;
  b=YR/69MA4D2wM16tdObyt6fwLMAEmtSKlpQqjZlga+pakFdhaTOQWtZ7C
   FVV2/3hWHLVw6BRntT0TjoexVqTBavLulw7OzZYsun58sHC+PeyuHVgh5
   fjHwzRS8Fai4F2XN7/zETAxW39P59JNHJdilRrae4TF5eO2YVPjIJXOg2
   PWQaOLsgvkSgvaiCB4t/cSN/2kMWNm5Qcycm61JPxJV1faJp2H/jN8FW7
   7oVRaSs580YCME/aJoUFYAx3bVdIo03cnSMpC8dq2vQW8dh3kyyEaCPPy
   txoZI7BwvIeUXJoAH1pF3kUwZd0IagNgcfj4F0sE0eahXwMvScjbZrnAL
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="345515129"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="345515129"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 13:06:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="934848010"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="934848010"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 11 Apr 2023 13:06:27 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pmKG2-000WfZ-0i;
        Tue, 11 Apr 2023 20:06:26 +0000
Date:   Wed, 12 Apr 2023 04:05:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: arch/arm/mach-versatile/versatile.c:56:14: warning: no previous
 prototype for 'mmc_status'
Message-ID: <202304120307.rabOWgH9-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0d3eb744aed40ffce820cded61d7eac515199165
commit: 7036440eab3e2d47a775d4616909f8235488d714 ARM: omap1: enable multiplatform
date:   10 months ago
config: arm-randconfig-r023-20230411 (https://download.01.org/0day-ci/archive/20230412/202304120307.rabOWgH9-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7036440eab3e2d47a775d4616909f8235488d714
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 7036440eab3e2d47a775d4616909f8235488d714
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304120307.rabOWgH9-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/arm/mach-versatile/versatile.c:56:14: warning: no previous prototype for 'mmc_status' [-Wmissing-prototypes]
      56 | unsigned int mmc_status(struct device *dev)
         |              ^~~~~~~~~~
--
>> arch/arm/mach-spear/pl080.c:30:5: warning: no previous prototype for 'pl080_get_signal' [-Wmissing-prototypes]
      30 | int pl080_get_signal(const struct pl08x_channel_data *cd)
         |     ^~~~~~~~~~~~~~~~
>> arch/arm/mach-spear/pl080.c:65:6: warning: no previous prototype for 'pl080_put_signal' [-Wmissing-prototypes]
      65 | void pl080_put_signal(const struct pl08x_channel_data *cd, int signal)
         |      ^~~~~~~~~~~~~~~~


vim +/mmc_status +56 arch/arm/mach-versatile/versatile.c

a7096789211193 arch/arm/mach-versatile/versatile_dt.c Rob Herring 2015-12-08  55  
a7096789211193 arch/arm/mach-versatile/versatile_dt.c Rob Herring 2015-12-08 @56  unsigned int mmc_status(struct device *dev)
a7096789211193 arch/arm/mach-versatile/versatile_dt.c Rob Herring 2015-12-08  57  {
a7096789211193 arch/arm/mach-versatile/versatile_dt.c Rob Herring 2015-12-08  58  	struct amba_device *adev = container_of(dev, struct amba_device, dev);
a7096789211193 arch/arm/mach-versatile/versatile_dt.c Rob Herring 2015-12-08  59  	u32 mask;
a7096789211193 arch/arm/mach-versatile/versatile_dt.c Rob Herring 2015-12-08  60  
a7096789211193 arch/arm/mach-versatile/versatile_dt.c Rob Herring 2015-12-08  61  	if (adev->res.start == VERSATILE_MMCI0_BASE)
a7096789211193 arch/arm/mach-versatile/versatile_dt.c Rob Herring 2015-12-08  62  		mask = 1;
a7096789211193 arch/arm/mach-versatile/versatile_dt.c Rob Herring 2015-12-08  63  	else
a7096789211193 arch/arm/mach-versatile/versatile_dt.c Rob Herring 2015-12-08  64  		mask = 2;
a7096789211193 arch/arm/mach-versatile/versatile_dt.c Rob Herring 2015-12-08  65  
a7096789211193 arch/arm/mach-versatile/versatile_dt.c Rob Herring 2015-12-08  66  	return readl(versatile_sys_base + VERSATILE_SYS_MCI_OFFSET) & mask;
a7096789211193 arch/arm/mach-versatile/versatile_dt.c Rob Herring 2015-12-08  67  }
a7096789211193 arch/arm/mach-versatile/versatile_dt.c Rob Herring 2015-12-08  68  

:::::: The code at line 56 was first introduced by commit
:::::: a70967892111934e292485ce84f1bab38cc55380 ARM: versatile: merge mach code into a single file

:::::: TO: Rob Herring <robh@kernel.org>
:::::: CC: Arnd Bergmann <arnd@arndb.de>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
