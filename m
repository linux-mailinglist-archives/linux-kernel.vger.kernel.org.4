Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9710B6E2884
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 18:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjDNQk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 12:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjDNQky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 12:40:54 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E823CE45;
        Fri, 14 Apr 2023 09:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681490452; x=1713026452;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=WQy0telDgCadi0YQv9CqPNLPz/Bs1Jmwt5uVTnql7ZE=;
  b=gU/+dD3GwFQJfaXKk4IFlHEP3xKP53jPaRESn0Qf62aQc9Q6dTBZ7oZa
   gjY2QVqsSJkXaHeKXvRpEexXycIVwkL7sIZdkWgBwzZyMu7ik/f9GKd6Y
   qisewDO1jzMykNtXNyBmrN9Z4WtGdXYyOiLZOWrawDVPk5ADkbtNaIdXx
   FQYJMOQDwDh/Ek+J8RtXVjQXpbya5Mg95TtP/VgqAQXYx40Ibx1+Z6VGL
   plCZQH7DjyEyMcCoe4y/nXJfmrrrCOts/jruMEeRqr9Eb0iSHvaZY6Dff
   2b3hQOeBtIq3jc+f1ERSseUD/B4g6s8jQ95jiw/S4T/P500XR3Jybl3+d
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10680"; a="347226862"
X-IronPort-AV: E=Sophos;i="5.99,197,1677571200"; 
   d="scan'208";a="347226862"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 09:40:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10680"; a="936069984"
X-IronPort-AV: E=Sophos;i="5.99,197,1677571200"; 
   d="scan'208";a="936069984"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 14 Apr 2023 09:40:39 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pnMTW-000Zj1-1M;
        Fri, 14 Apr 2023 16:40:38 +0000
Date:   Sat, 15 Apr 2023 00:39:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: drivers/media/platform/renesas/rcar_jpu.c:77: warning: "RST"
 redefined
Message-ID: <202304150059.bHUyuriy-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   44149752e9987a9eac5ad78e6d3a20934b5e018d
commit: ee4a77a32b39064fdab0aa2b36bbd35ebf57e077 media: platform: place Renesas drivers on a separate dir
date:   1 year, 1 month ago
config: mips-buildonly-randconfig-r002-20230414 (https://download.01.org/0day-ci/archive/20230415/202304150059.bHUyuriy-lkp@intel.com/config)
compiler: mipsel-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ee4a77a32b39064fdab0aa2b36bbd35ebf57e077
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout ee4a77a32b39064fdab0aa2b36bbd35ebf57e077
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=mips olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/media/platform/renesas/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304150059.bHUyuriy-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/media/platform/renesas/rcar_jpu.c:77: warning: "RST" redefined
      77 | #define RST     0xd0
         | 
   In file included from arch/mips/include/asm/mach-rc32434/irq.h:8,
                    from arch/mips/include/asm/irq.h:17,
                    from include/linux/irq.h:23,
                    from include/asm-generic/hardirq.h:17,
                    from arch/mips/include/asm/hardirq.h:16,
                    from include/linux/hardirq.h:11,
                    from include/linux/interrupt.h:11,
                    from drivers/media/platform/renesas/rcar_jpu.c:20:
   arch/mips/include/asm/mach-rc32434/rb.h:13: note: this is the location of the previous definition
      13 | #define RST             (1 << 15)
         | 


vim +/RST +77 drivers/media/platform/renesas/rcar_jpu.c

2c42cdbaec56a9 drivers/media/platform/rcar_jpu.c Mikhail Ulyanov 2015-07-22  73  
2c42cdbaec56a9 drivers/media/platform/rcar_jpu.c Mikhail Ulyanov 2015-07-22  74  /* JPEG markers */
2c42cdbaec56a9 drivers/media/platform/rcar_jpu.c Mikhail Ulyanov 2015-07-22  75  #define TEM	0x01
2c42cdbaec56a9 drivers/media/platform/rcar_jpu.c Mikhail Ulyanov 2015-07-22  76  #define SOF0	0xc0
2c42cdbaec56a9 drivers/media/platform/rcar_jpu.c Mikhail Ulyanov 2015-07-22 @77  #define RST	0xd0
2c42cdbaec56a9 drivers/media/platform/rcar_jpu.c Mikhail Ulyanov 2015-07-22  78  #define SOI	0xd8
2c42cdbaec56a9 drivers/media/platform/rcar_jpu.c Mikhail Ulyanov 2015-07-22  79  #define EOI	0xd9
2c42cdbaec56a9 drivers/media/platform/rcar_jpu.c Mikhail Ulyanov 2015-07-22  80  #define DHP	0xde
2c42cdbaec56a9 drivers/media/platform/rcar_jpu.c Mikhail Ulyanov 2015-07-22  81  #define DHT	0xc4
2c42cdbaec56a9 drivers/media/platform/rcar_jpu.c Mikhail Ulyanov 2015-07-22  82  #define COM	0xfe
2c42cdbaec56a9 drivers/media/platform/rcar_jpu.c Mikhail Ulyanov 2015-07-22  83  #define DQT	0xdb
2c42cdbaec56a9 drivers/media/platform/rcar_jpu.c Mikhail Ulyanov 2015-07-22  84  #define DRI	0xdd
2c42cdbaec56a9 drivers/media/platform/rcar_jpu.c Mikhail Ulyanov 2015-07-22  85  #define APP0	0xe0
2c42cdbaec56a9 drivers/media/platform/rcar_jpu.c Mikhail Ulyanov 2015-07-22  86  

:::::: The code at line 77 was first introduced by commit
:::::: 2c42cdbaec56a9565a2717b450506150c9c55103 [media] V4L2: platform: Add Renesas R-Car JPEG codec driver

:::::: TO: Mikhail Ulyanov <mikhail.ulyanov@cogentembedded.com>
:::::: CC: Mauro Carvalho Chehab <mchehab@osg.samsung.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
