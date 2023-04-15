Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C06C36E3234
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 17:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjDOP4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 11:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjDOP4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 11:56:50 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC0FB49DA;
        Sat, 15 Apr 2023 08:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681574209; x=1713110209;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=LF7pkJzFUPufb5UHCdtq03mmFNCFglmxj96MbHLvqV0=;
  b=Yu2miJVr7fpI57sjJoqhaAYyEQ2hUYd2//YkFM4YshVRJcJE6i1K+FhH
   O5ofqmlC9Kscg9l7J53MkV/YZ+uNT9tiRiH/Rb3eyuyWzrPvB5f4Ksi4f
   3oBMcZ9qLxNP/HL9AIlH50mD5U1k0l51ciwkuD/3+le5Is1LoTop9M7OO
   jCRufpL5Wg7kxh90X7vVj16VP93tk6vuuN8NqXrzFZzpqtMGbgeK6lauv
   oifeE5d6VFJ3KzHdzRFF0fTT3pyXnb0fhdDSRPBJVaDVGXzmU3QcOtVWq
   RaxNcw4RXAddXF0viKdwg3Fo0xUB/uYW5YDh6zDf4ltncm2KJ6CkGTZ4k
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10681"; a="346500837"
X-IronPort-AV: E=Sophos;i="5.99,200,1677571200"; 
   d="scan'208";a="346500837"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2023 08:56:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10681"; a="667647552"
X-IronPort-AV: E=Sophos;i="5.99,200,1677571200"; 
   d="scan'208";a="667647552"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 15 Apr 2023 08:56:47 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pniGc-000bBP-1H;
        Sat, 15 Apr 2023 15:56:46 +0000
Date:   Sat, 15 Apr 2023 23:56:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_parse.c:15:9:
 warning: 'RST' macro redefined
Message-ID: <202304152346.hJOPxPRh-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   7a934f4bd7d6f9da84c8812da3ba42ee10f5778e
commit: 2023a99811110aebba9eee4aa09ef7bd21a8a249 media: platform: rename mediatek/mtk-jpeg/ to mediatek/jpeg/
date:   1 year, 1 month ago
config: mips-buildonly-randconfig-r006-20230415 (https://download.01.org/0day-ci/archive/20230415/202304152346.hJOPxPRh-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 9638da200e00bd069e6dd63604e14cbafede9324)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mipsel-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2023a99811110aebba9eee4aa09ef7bd21a8a249
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 2023a99811110aebba9eee4aa09ef7bd21a8a249
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/media/platform/mediatek/jpeg/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304152346.hJOPxPRh-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_parse.c:15:9: warning: 'RST' macro redefined [-Wmacro-redefined]
   #define RST     0xd0
           ^
   arch/mips/include/asm/mach-rc32434/rb.h:13:9: note: previous definition is here
   #define RST             (1 << 15)
           ^
   1 warning generated.


vim +/RST +15 drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_parse.c

b2f0d2724ba477d drivers/media/platform/mtk-jpeg/mtk_jpeg_parse.c Rick Chang 2016-12-14  12  
b2f0d2724ba477d drivers/media/platform/mtk-jpeg/mtk_jpeg_parse.c Rick Chang 2016-12-14  13  #define TEM	0x01
b2f0d2724ba477d drivers/media/platform/mtk-jpeg/mtk_jpeg_parse.c Rick Chang 2016-12-14  14  #define SOF0	0xc0
b2f0d2724ba477d drivers/media/platform/mtk-jpeg/mtk_jpeg_parse.c Rick Chang 2016-12-14 @15  #define RST	0xd0
b2f0d2724ba477d drivers/media/platform/mtk-jpeg/mtk_jpeg_parse.c Rick Chang 2016-12-14  16  #define SOI	0xd8
b2f0d2724ba477d drivers/media/platform/mtk-jpeg/mtk_jpeg_parse.c Rick Chang 2016-12-14  17  #define EOI	0xd9
b2f0d2724ba477d drivers/media/platform/mtk-jpeg/mtk_jpeg_parse.c Rick Chang 2016-12-14  18  

:::::: The code at line 15 was first introduced by commit
:::::: b2f0d2724ba477d326e9d654d4db1c93e98f8b93 [media] vcodec: mediatek: Add Mediatek JPEG Decoder Driver

:::::: TO: Rick Chang <rick.chang@mediatek.com>
:::::: CC: Mauro Carvalho Chehab <mchehab@s-opensource.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
