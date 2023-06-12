Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6997672D0BD
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 22:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231724AbjFLUjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 16:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237022AbjFLUje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 16:39:34 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E3DD1984
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 13:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686602369; x=1718138369;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=SbYyvJYQ3piNwv5linQ1WYTpJRSYyWv7Nn+u6U5b9MI=;
  b=OxVR9bSn+Gqng7y8CeA4ynA8Btl6WiOBhlxtoygOzneJqK7w03LwrUSo
   3H3F4F0ylnol287uW5WBiSWtZixjRRVlSy8/SrKM6ihymzhx7z4yrS5re
   NjlYoM3bSUZVU+CBSvqWUvs6CsHPdyEl/3o1dvigoeGf66Np9iwfU3BN3
   ouC7fS/Kg1/w4pCqdhtkioBqheZhZ2rJ/aTQLB5n/UOHKeCnP/ud7rWND
   taharkK06DdZyf2mELDmGHxuqmO0l144IXce+1v5Oe4ywkcJOM9NMbwRT
   CakYK1HsoYGbPUlD6T6i5CGug5jFBq8z3aXafRfXZud2orQuZtP/IFX4H
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="358153907"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="358153907"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 13:37:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="741167195"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="741167195"
Received: from lkp-server01.sh.intel.com (HELO 211f47bdb1cb) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 12 Jun 2023 13:37:07 -0700
Received: from kbuild by 211f47bdb1cb with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q8oHi-0000gg-0C;
        Mon, 12 Jun 2023 20:37:06 +0000
Date:   Tue, 13 Jun 2023 04:36:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Rob Herring <robh@kernel.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
Subject: arch/powerpc/platforms/52xx/lite5200_pm.c:47:12: error: stack frame
 size (1040) exceeds limit (1024) in 'lite5200_pm_prepare'
Message-ID: <202306130405.uTv5yOZD-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   858fd168a95c5b9669aac8db6c14a9aeab446375
commit: 2500763dd3db37fad94d9b506907c59c2f5e97c6 powerpc: Use of_address_to_resource()
date:   10 weeks ago
config: powerpc-randconfig-r033-20230612 (https://download.01.org/0day-ci/archive/20230613/202306130405.uTv5yOZD-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install powerpc cross compiling tool for clang build
        # apt-get install binutils-powerpc-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2500763dd3db37fad94d9b506907c59c2f5e97c6
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 2500763dd3db37fad94d9b506907c59c2f5e97c6
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=powerpc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash arch/powerpc/platforms/52xx/

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306130405.uTv5yOZD-lkp@intel.com/

All errors (new ones prefixed by >>):

>> arch/powerpc/platforms/52xx/lite5200_pm.c:47:12: error: stack frame size (1040) exceeds limit (1024) in 'lite5200_pm_prepare' [-Werror,-Wframe-larger-than]
      47 | static int lite5200_pm_prepare(void)
         |            ^
   1 error generated.


vim +/lite5200_pm_prepare +47 arch/powerpc/platforms/52xx/lite5200_pm.c

e6c5eb9541f219 Rafael J. Wysocki 2007-10-18  46  
e6c5eb9541f219 Rafael J. Wysocki 2007-10-18 @47  static int lite5200_pm_prepare(void)
ee983079ce0464 Domen Puncer      2007-07-18  48  {
75ca399e82726f Grant Likely      2008-01-18  49  	struct device_node *np;
66ffbe490b6156 Grant Likely      2008-01-24  50  	const struct of_device_id immr_ids[] = {
66ffbe490b6156 Grant Likely      2008-01-24  51  		{ .compatible = "fsl,mpc5200-immr", },
66ffbe490b6156 Grant Likely      2008-01-24  52  		{ .compatible = "fsl,mpc5200b-immr", },
66ffbe490b6156 Grant Likely      2008-01-24  53  		{ .type = "soc", .compatible = "mpc5200", }, /* lite5200 */
66ffbe490b6156 Grant Likely      2008-01-24  54  		{ .type = "builtin", .compatible = "mpc5200", }, /* efika */
66ffbe490b6156 Grant Likely      2008-01-24  55  		{}
66ffbe490b6156 Grant Likely      2008-01-24  56  	};
2500763dd3db37 Rob Herring       2023-03-29  57  	struct resource res;
75ca399e82726f Grant Likely      2008-01-18  58  
ee983079ce0464 Domen Puncer      2007-07-18  59  	/* deep sleep? let mpc52xx code handle that */
e6c5eb9541f219 Rafael J. Wysocki 2007-10-18  60  	if (lite5200_pm_target_state == PM_SUSPEND_STANDBY)
e6c5eb9541f219 Rafael J. Wysocki 2007-10-18  61  		return mpc52xx_pm_prepare();
ee983079ce0464 Domen Puncer      2007-07-18  62  
e6c5eb9541f219 Rafael J. Wysocki 2007-10-18  63  	if (lite5200_pm_target_state != PM_SUSPEND_MEM)
ee983079ce0464 Domen Puncer      2007-07-18  64  		return -EINVAL;
ee983079ce0464 Domen Puncer      2007-07-18  65  
ee983079ce0464 Domen Puncer      2007-07-18  66  	/* map registers */
66ffbe490b6156 Grant Likely      2008-01-24  67  	np = of_find_matching_node(NULL, immr_ids);
2500763dd3db37 Rob Herring       2023-03-29  68  	of_address_to_resource(np, 0, &res);
75ca399e82726f Grant Likely      2008-01-18  69  	of_node_put(np);
18d76ac9a47742 Tim Yamin         2008-06-17  70  
2500763dd3db37 Rob Herring       2023-03-29  71  	mbar = ioremap(res.start, 0xC000);
ee983079ce0464 Domen Puncer      2007-07-18  72  	if (!mbar) {
ee983079ce0464 Domen Puncer      2007-07-18  73  		printk(KERN_ERR "%s:%i Error mapping registers\n", __func__, __LINE__);
ee983079ce0464 Domen Puncer      2007-07-18  74  		return -ENOSYS;
ee983079ce0464 Domen Puncer      2007-07-18  75  	}
ee983079ce0464 Domen Puncer      2007-07-18  76  
ee983079ce0464 Domen Puncer      2007-07-18  77  	cdm = mbar + 0x200;
ee983079ce0464 Domen Puncer      2007-07-18  78  	pic = mbar + 0x500;
ee983079ce0464 Domen Puncer      2007-07-18  79  	gps = mbar + 0xb00;
ee983079ce0464 Domen Puncer      2007-07-18  80  	gpw = mbar + 0xc00;
18d76ac9a47742 Tim Yamin         2008-06-17  81  	pci = mbar + 0xd00;
ee983079ce0464 Domen Puncer      2007-07-18  82  	bes = mbar + 0x1200;
ee983079ce0464 Domen Puncer      2007-07-18  83  	xlb = mbar + 0x1f00;
ee983079ce0464 Domen Puncer      2007-07-18  84  	sram = mbar + 0x8000;
ee983079ce0464 Domen Puncer      2007-07-18  85  
ee983079ce0464 Domen Puncer      2007-07-18  86  	return 0;
ee983079ce0464 Domen Puncer      2007-07-18  87  }
ee983079ce0464 Domen Puncer      2007-07-18  88  

:::::: The code at line 47 was first introduced by commit
:::::: e6c5eb9541f2197a3ffab90b1c7a3250a9b51bf6 PM: Rework struct platform_suspend_ops

:::::: TO: Rafael J. Wysocki <rjw@sisk.pl>
:::::: CC: Linus Torvalds <torvalds@woody.linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
