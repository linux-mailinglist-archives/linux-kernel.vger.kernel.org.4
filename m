Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37DDD6E31F5
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 16:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjDOOoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 10:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjDOOoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 10:44:21 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F18630FA;
        Sat, 15 Apr 2023 07:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681569829; x=1713105829;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=XGrjEAwHGogSmqv9y4dhxxlnsoxI/zzyEK67wxnNBWs=;
  b=INKPkbYCp1+W7TAtYBcy3/vNCtZmQ1o/Woqx92JPUKRg+3Fb6PNqfEr2
   gLraizNjVjCFNU1Q8tUk7xptWHkAS8PdmVEyhVHcsjwChOnMCI+M4LD3Y
   Ou18okDgQ9NXrgWSvy0c1bb/PkDcDcbE3RZjYKHI9Q95EQnkRl1EzMkLB
   DufMgrTrYLg0havxF8Kg/k2Wq2DfhF+SZa1sqT5kZ6KOgDKmT0KONooPn
   gYmsSPwtkjRfu3RB4mQsF2ywBY+Fh6Ul1yeP/ZhDYPvcdgBauE+PJsDBx
   YtYRVCcIW1Wk5hyixf+ixQcmrBhRZOaCxyUYNmTJvgztZFZYfQWBMO+YW
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10681"; a="343407693"
X-IronPort-AV: E=Sophos;i="5.99,199,1677571200"; 
   d="scan'208";a="343407693"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2023 07:43:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10681"; a="814269801"
X-IronPort-AV: E=Sophos;i="5.99,199,1677571200"; 
   d="scan'208";a="814269801"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 15 Apr 2023 07:43:44 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pnh7v-000b7o-1z;
        Sat, 15 Apr 2023 14:43:43 +0000
Date:   Sat, 15 Apr 2023 22:43:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: drivers/media/platform/renesas/rcar_jpu.c:77:9: warning: 'RST' macro
 redefined
Message-ID: <202304152222.ciOWuViG-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   7a934f4bd7d6f9da84c8812da3ba42ee10f5778e
commit: ee4a77a32b39064fdab0aa2b36bbd35ebf57e077 media: platform: place Renesas drivers on a separate dir
date:   1 year, 1 month ago
config: mips-buildonly-randconfig-r006-20230415 (https://download.01.org/0day-ci/archive/20230415/202304152222.ciOWuViG-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 9638da200e00bd069e6dd63604e14cbafede9324)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mipsel-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ee4a77a32b39064fdab0aa2b36bbd35ebf57e077
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout ee4a77a32b39064fdab0aa2b36bbd35ebf57e077
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/media/platform/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304152222.ciOWuViG-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/media/platform/renesas/rcar_jpu.c:77:9: warning: 'RST' macro redefined [-Wmacro-redefined]
   #define RST     0xd0
           ^
   arch/mips/include/asm/mach-rc32434/rb.h:13:9: note: previous definition is here
   #define RST             (1 << 15)
           ^
   1 warning generated.


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
