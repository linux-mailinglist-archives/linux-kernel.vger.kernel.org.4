Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 204466F24BC
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 14:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbjD2MzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 08:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjD2MzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 08:55:12 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91721BF1
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 05:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682772910; x=1714308910;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=KGHqU3LAlYhjG5tBGOc2nQJAtTnzYDMbe+fxCkqCyCU=;
  b=XcITMuaqcPpfDtMlWMYkqBwzo8/rEO4rBM4y3QDmK5M/aV1C5UFIoW3V
   GFAQhU/7iEMpCK/TN5vsW6RE4J+IaCVeo+e82IvghiiZ7jB5DqdAdqAK/
   AtEaaE6OGxKIk4FM+JQ6l0yRMyRF3pJc7NF4q9Upqeoq2eKQUc/iaYLSv
   R177QGV3WvekZcjB0a/h8n6aRXClTS2dUHYN1wcqpao8kkzwn8AcQW9Ah
   YEPrv18scb2FaAmYpY8Wh8kzI6xAjsJbs1lTm0kj1Lks/txz5BJH9DOW7
   IgcGhHjrB6pbSmJfExci3RXAUom2FUM8rRVAYd/BHh883EoPKLSVV1Vqw
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10695"; a="413346327"
X-IronPort-AV: E=Sophos;i="5.99,237,1677571200"; 
   d="scan'208";a="413346327"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2023 05:55:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10695"; a="697920704"
X-IronPort-AV: E=Sophos;i="5.99,237,1677571200"; 
   d="scan'208";a="697920704"
Received: from lkp-server01.sh.intel.com (HELO 5bad9d2b7fcb) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 29 Apr 2023 05:55:08 -0700
Received: from kbuild by 5bad9d2b7fcb with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1psk6Q-00019Z-38;
        Sat, 29 Apr 2023 12:55:02 +0000
Date:   Sat, 29 Apr 2023 20:54:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: arch/arm/mach-omap2/cpuidle44xx.c:88: warning: expecting prototype
 for omap_enter_idle_[simple/coupled](). Prototype was for
 omap_enter_idle_simple() instead
Message-ID: <202304292001.RvJU7sWm-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   89d77f71f493a3663b10fa812d17f472935d24be
commit: 09f6b27d5ddd9ad0ec096d1b0f8decdacc70f0f8 ARM: dove: multiplatform support
date:   1 year, 1 month ago
config: arm-randconfig-r034-20230429 (https://download.01.org/0day-ci/archive/20230429/202304292001.RvJU7sWm-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 437b7602e4a998220871de78afcb020b9c14a661)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=09f6b27d5ddd9ad0ec096d1b0f8decdacc70f0f8
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 09f6b27d5ddd9ad0ec096d1b0f8decdacc70f0f8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304292001.RvJU7sWm-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/arm/mach-omap2/cpuidle44xx.c:88: warning: expecting prototype for omap_enter_idle_[simple/coupled](). Prototype was for omap_enter_idle_simple() instead


vim +88 arch/arm/mach-omap2/cpuidle44xx.c

9db316b6bf0234 Paul Walmsley     2012-12-15  74  
98272660970a71 Santosh Shilimkar 2011-08-16  75  /**
db4f3dab629109 Santosh Shilimkar 2013-04-05  76   * omap_enter_idle_[simple/coupled] - OMAP4PLUS cpuidle entry functions
98272660970a71 Santosh Shilimkar 2011-08-16  77   * @dev: cpuidle device
98272660970a71 Santosh Shilimkar 2011-08-16  78   * @drv: cpuidle driver
98272660970a71 Santosh Shilimkar 2011-08-16  79   * @index: the index of state to be entered
98272660970a71 Santosh Shilimkar 2011-08-16  80   *
98272660970a71 Santosh Shilimkar 2011-08-16  81   * Called from the CPUidle framework to program the device to the
98272660970a71 Santosh Shilimkar 2011-08-16  82   * specified low power state selected by the governor.
98272660970a71 Santosh Shilimkar 2011-08-16  83   * Returns the amount of time spent in the low power state.
98272660970a71 Santosh Shilimkar 2011-08-16  84   */
db4f3dab629109 Santosh Shilimkar 2013-04-05  85  static int omap_enter_idle_simple(struct cpuidle_device *dev,
dd3ad97c5621aa Santosh Shilimkar 2011-12-25  86  			struct cpuidle_driver *drv,
dd3ad97c5621aa Santosh Shilimkar 2011-12-25  87  			int index)
dd3ad97c5621aa Santosh Shilimkar 2011-12-25 @88  {
dd3ad97c5621aa Santosh Shilimkar 2011-12-25  89  	omap_do_wfi();
dd3ad97c5621aa Santosh Shilimkar 2011-12-25  90  	return index;
dd3ad97c5621aa Santosh Shilimkar 2011-12-25  91  }
dd3ad97c5621aa Santosh Shilimkar 2011-12-25  92  

:::::: The code at line 88 was first introduced by commit
:::::: dd3ad97c5621aa853843dd5e6783ca787466158c ARM: OMAP4: CPUidle: Use coupled cpuidle states to implement SMP cpuidle.

:::::: TO: Santosh Shilimkar <santosh.shilimkar@ti.com>
:::::: CC: Kevin Hilman <khilman@ti.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
