Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5BD5BA0BC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 20:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbiIOSSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 14:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiIOSRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 14:17:50 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2DF193230
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 11:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663265857; x=1694801857;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=j5OsYP3tkEj9inavdTVg/YHnhE5hqf7weDM983IJ5tY=;
  b=RE0VTwhz/udHbjkP+JUYDWAPPlgCoHjDEc8ckR8DpSF1hW8+D9xt4v1k
   biwjTjrH789h4IDm1CvZFVFNcy/hSP4w3AHBgCThR3Ltu1DUEenXAAMx5
   M3j5Gcs0q8h5lOgEdFhIGHm10utTkaLYPCVc7uuDx9NWUzWpOqGzIEInW
   qP4zpyrduYP5vmwwiVUikNq9LZALLxA4kz657VGkOUOYrgZ83hO1wrDs5
   GWCnM1iT951K1qO5tlXIqrgl0RoB+EYVc4haKbG4RgOaap+TtjOhv7h5E
   L0zmn2KvgWfJp81q0ZXwFw6+UQx0Ee402t2BHqP6zdqcagNrWFS+q+Q/N
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10471"; a="360542094"
X-IronPort-AV: E=Sophos;i="5.93,318,1654585200"; 
   d="scan'208";a="360542094"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2022 11:17:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,318,1654585200"; 
   d="scan'208";a="759747990"
Received: from lkp-server02.sh.intel.com (HELO 41300c7200ea) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 15 Sep 2022 11:17:35 -0700
Received: from kbuild by 41300c7200ea with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oYtQc-0000q5-2y;
        Thu, 15 Sep 2022 18:17:34 +0000
Date:   Fri, 16 Sep 2022 02:17:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: drivers/gpu/drm/omapdrm/dss/dsi.c:1126:1: warning: the frame size of
 1060 bytes is larger than 1024 bytes
Message-ID: <202209160259.7f3Z5krO-lkp@intel.com>
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

Hi Arnd,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3245cb65fd91cd514801bf91f5a3066d562f0ac4
commit: 3d427228f7370894680580fcd0381c0349624fa1 ARM: ixp4xx: enable multiplatform support
date:   5 months ago
config: arm-randconfig-r035-20220915 (https://download.01.org/0day-ci/archive/20220916/202209160259.7f3Z5krO-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3d427228f7370894680580fcd0381c0349624fa1
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 3d427228f7370894680580fcd0381c0349624fa1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/gpu/drm/omapdrm/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/omapdrm/dss/dsi.c: In function 'dsi_dump_dsi_irqs':
>> drivers/gpu/drm/omapdrm/dss/dsi.c:1126:1: warning: the frame size of 1060 bytes is larger than 1024 bytes [-Wframe-larger-than=]
    1126 | }
         | ^
   In file included from include/linux/string.h:253,
                    from include/linux/bitmap.h:11,
                    from include/linux/cpumask.h:12,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/rcupdate.h:29,
                    from include/linux/rbtree.h:24,
                    from include/linux/regmap.h:14,
                    from drivers/gpu/drm/omapdrm/dss/dsi.c:11:
   In function 'fortify_memcpy_chk',
       inlined from 'omap_dsi_irq_handler' at drivers/gpu/drm/omapdrm/dss/dsi.c:460:2:
   include/linux/fortify-string.h:336:25: warning: call to '__read_overflow2_field' declared with attribute warning: detected read beyond size of field (2nd parameter); maybe use struct_group()? [-Wattribute-warning]
     336 |                         __read_overflow2_field(q_size_field, size);
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +1126 drivers/gpu/drm/omapdrm/dss/dsi.c

a72b64b99918ee drivers/video/omap2/dss/dsi.c     Archit Taneja    2011-05-12  1124  
f33656e1fe5aba drivers/gpu/drm/omapdrm/dss/dsi.c Laurent Pinchart 2018-02-13  1125  	return 0;
5a8b572d832772 drivers/video/omap2/dss/dsi.c     Archit Taneja    2011-05-12 @1126  }
5a8b572d832772 drivers/video/omap2/dss/dsi.c     Archit Taneja    2011-05-12  1127  #endif
5a8b572d832772 drivers/video/omap2/dss/dsi.c     Archit Taneja    2011-05-12  1128  

:::::: The code at line 1126 was first introduced by commit
:::::: 5a8b572d832772722c3b3b7578e7fb968560fcf3 OMAP4: DSS2: DSI: Changes for DSI2 on OMAP4

:::::: TO: Archit Taneja <archit@ti.com>
:::::: CC: Tomi Valkeinen <tomi.valkeinen@ti.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
