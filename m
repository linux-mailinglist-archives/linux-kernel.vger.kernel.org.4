Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7086E3359
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 21:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbjDOTy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 15:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbjDOTy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 15:54:57 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4074F3580
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 12:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681588495; x=1713124495;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ibQYgOzgU83XerxDcPwp14yJzRTqyflYwNRm4kZiRhk=;
  b=BXNs0VwRHnNPPtw5YA58+WxqHfI1LrJ5356et/ly+G+i9BYdek1LBpnZ
   aded+3GXTGnkzVfz8/LFkloUm70xjjSoFiYcWLXazUXfxyS4m3P83aniP
   S8OgXf3yutsPTO4u+YiZrg3QlBNHkwPsif/It0Rz3pGW8h/bInzJ92mYi
   Fif8F1nj3m1Kkj+sizF7EigHbXcJ3/rinI2i0mzq9ArMxSyMNEHJq+dwv
   BgszFIqyw2Q2M7F+CjFChXgLTJHUsQ08cFHcFJaeX6re4l4ThgCXigKh7
   aVqpEeyPrQeG/i4S43AZz4ZIPkxmoYqupnr4AkHn8pCrFO/tMdUD0OW4A
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10681"; a="328832116"
X-IronPort-AV: E=Sophos;i="5.99,200,1677571200"; 
   d="scan'208";a="328832116"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2023 12:54:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10681"; a="690202399"
X-IronPort-AV: E=Sophos;i="5.99,200,1677571200"; 
   d="scan'208";a="690202399"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 15 Apr 2023 12:54:52 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pnlz1-000bJ9-39;
        Sat, 15 Apr 2023 19:54:51 +0000
Date:   Sun, 16 Apr 2023 03:54:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Subject: arch/arm/mach-sa1100/assabet.c:746:13: warning: no previous
 prototype for function 'assabet_init_irq'
Message-ID: <202304160350.FfJdKRPG-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nathan,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   7a934f4bd7d6f9da84c8812da3ba42ee10f5778e
commit: 5eb6e280432ddc9b755193552f3a070da8d7455c ARM: 9289/1: Allow pre-ARMv5 builds with ld.lld 16.0.0 and newer
date:   2 months ago
config: arm-neponset_defconfig (https://download.01.org/0day-ci/archive/20230416/202304160350.FfJdKRPG-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 9638da200e00bd069e6dd63604e14cbafede9324)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5eb6e280432ddc9b755193552f3a070da8d7455c
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 5eb6e280432ddc9b755193552f3a070da8d7455c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash arch/arm/common/ arch/arm/mach-sa1100/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304160350.FfJdKRPG-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/arm/mach-sa1100/assabet.c:746:13: warning: no previous prototype for function 'assabet_init_irq' [-Wmissing-prototypes]
   void __init assabet_init_irq(void)
               ^
   arch/arm/mach-sa1100/assabet.c:746:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __init assabet_init_irq(void)
   ^
   static 
   1 warning generated.
--
>> arch/arm/common/sa1111.c:699:1: warning: no previous prototype for function 'sa1111_configure_smc' [-Wmissing-prototypes]
   sa1111_configure_smc(struct sa1111 *sachip, int sdram, unsigned int drac,
   ^
   arch/arm/common/sa1111.c:698:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void
   ^
   static 
   1 warning generated.


vim +/assabet_init_irq +746 arch/arm/mach-sa1100/assabet.c

^1da177e4c3f41 Linus Torvalds 2005-04-16  745  
b955153bfa68d7 Russell King   2016-08-31 @746  void __init assabet_init_irq(void)
b955153bfa68d7 Russell King   2016-08-31  747  {
b955153bfa68d7 Russell King   2016-08-31  748  	u32 def_val;
b955153bfa68d7 Russell King   2016-08-31  749  
b955153bfa68d7 Russell King   2016-08-31  750  	sa1100_init_irq();
b955153bfa68d7 Russell King   2016-08-31  751  
b955153bfa68d7 Russell King   2016-08-31  752  	if (machine_has_neponset())
b955153bfa68d7 Russell King   2016-08-31  753  		def_val = ASSABET_BCR_DB1111;
b955153bfa68d7 Russell King   2016-08-31  754  	else
b955153bfa68d7 Russell King   2016-08-31  755  		def_val = ASSABET_BCR_DB1110;
b955153bfa68d7 Russell King   2016-08-31  756  
b955153bfa68d7 Russell King   2016-08-31  757  	/*
b955153bfa68d7 Russell King   2016-08-31  758  	 * Angel sets this, but other bootloaders may not.
b955153bfa68d7 Russell King   2016-08-31  759  	 *
b955153bfa68d7 Russell King   2016-08-31  760  	 * This must precede any driver calls to BCR_set() or BCR_clear().
b955153bfa68d7 Russell King   2016-08-31  761  	 */
20a451f8db4a81 Linus Walleij  2021-07-20  762  	assabet_init_gpio((void *)&ASSABET_BCR, def_val);
b955153bfa68d7 Russell King   2016-08-31  763  }
b955153bfa68d7 Russell King   2016-08-31  764  

:::::: The code at line 746 was first introduced by commit
:::::: b955153bfa68d7a9fa2be40bb606cf9578b66511 ARM: sa1100/assabet: add BCR/BSR GPIO driver

:::::: TO: Russell King <rmk+kernel@armlinux.org.uk>
:::::: CC: Russell King <rmk+kernel@armlinux.org.uk>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
