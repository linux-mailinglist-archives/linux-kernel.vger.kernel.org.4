Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2932C5BF41E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 05:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbiIUDJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 23:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiIUDI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 23:08:58 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B2367DF7A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 20:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663729737; x=1695265737;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=PVEHIxZo8pe3/kgPKbJQ0pMuqpy6w0Mu3n51nYNoKn8=;
  b=Gov02hiY6t421mO+CFY7yhfRYPYrZ7NCcH8Fr6Gf5scr+iN3Dk39AXFG
   z/jay7C0u/8eB1IWZQiGPVsuZSGHZ5597pasPSgJYdZCUCqhgT0vYfp83
   U49ySLB0xfZk9kB5U4jTrZY72EorM6HAPM62Uqj2tnSZN/eI8T/PnLivy
   f/bY0DY6OlkAEX6acZBqMaZSrRXdHAFnTcmpJC/VOvSekEGXCq7hFH+L2
   i0g7eRSf6Iey+jP5N3t/C0tVgLCZ8CAB81lG0FaHeJOPblxIH3+lrktSZ
   2AWVPDjbX9ZL+QABCCkxgi/S4F5eMVTJyoMVQV5tpHe0ziBJL31nozg6K
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10476"; a="298604502"
X-IronPort-AV: E=Sophos;i="5.93,332,1654585200"; 
   d="scan'208";a="298604502"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 20:08:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,332,1654585200"; 
   d="scan'208";a="596786653"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 20 Sep 2022 20:08:55 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oaq6Z-0003BO-0I;
        Wed, 21 Sep 2022 03:08:55 +0000
Date:   Wed, 21 Sep 2022 11:08:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Dave Jiang <dave.jiang@intel.com>
Subject: [djiang:cxl-security 1/19] include/linux/memregion.h:52:5: warning:
 no previous prototype for 'cpu_cache_invalidate_memregion'
Message-ID: <202209211040.pEXdfJvU-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git cxl-security
head:   3b2ea8468d5dbe2e7b61dcd86cc3aeadfe766d07
commit: d8fab77dd9512ae56e653afddbef9351da206679 [1/19] memregion: Add cpu_cache_invalidate_memregion() interface
config: parisc-allyesconfig (https://download.01.org/0day-ci/archive/20220921/202209211040.pEXdfJvU-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/commit/?id=d8fab77dd9512ae56e653afddbef9351da206679
        git remote add djiang https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git
        git fetch --no-tags djiang cxl-security
        git checkout d8fab77dd9512ae56e653afddbef9351da206679
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=parisc SHELL=/bin/bash drivers/cxl/core/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/cxl/core/port.c:4:
>> include/linux/memregion.h:52:5: warning: no previous prototype for 'cpu_cache_invalidate_memregion' [-Wmissing-prototypes]
      52 | int cpu_cache_invalidate_memregion(int res_desc)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/cpu_cache_invalidate_memregion +52 include/linux/memregion.h

    51	
  > 52	int cpu_cache_invalidate_memregion(int res_desc)

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
