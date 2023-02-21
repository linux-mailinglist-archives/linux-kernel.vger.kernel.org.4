Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED25B69E8CF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 21:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjBUUGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 15:06:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbjBUUGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 15:06:02 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 133E12B628
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 12:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677009961; x=1708545961;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xgS7PVJCPZJ+//xyj4OSmQvPnD+TakDYc2ICsvn/8wM=;
  b=V5ntS0vTaK5HDksoYql19iZasKzxVZ5ZNQa+tiZEtRlGR6vdH96IDTFN
   w6F/GWyu7eWbZzC/qtmGb/eys+Y7RURJbqLVQb/6iOkMxluWlTDnAO/+W
   QfavCLxU9rbTTgmluBM70hntLb0Ll9R0wlKDu7LjO4zSjWe609FlVTTvd
   Ep8hjkHvfx0y0gCPXjQ32yQToZtbK5I56umOmGaWOzoRMnFxytpJu3UZe
   BfWXTcxRRANBnjw9m0D/X/4L4RI+T+OBepYAzenZvmyI18j28POzpiNG2
   soB2aVVcroaSkjeO5SBabe8xuMzWpXb65wOWiTZ55UVhrAfa1uF+Ib+c7
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="334100045"
X-IronPort-AV: E=Sophos;i="5.97,315,1669104000"; 
   d="scan'208";a="334100045"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2023 12:05:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="917317158"
X-IronPort-AV: E=Sophos;i="5.97,315,1669104000"; 
   d="scan'208";a="917317158"
Received: from lkp-server01.sh.intel.com (HELO eac18b5d7d93) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 21 Feb 2023 12:05:39 -0800
Received: from kbuild by eac18b5d7d93 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pUYtO-0000Cr-2Q;
        Tue, 21 Feb 2023 20:05:38 +0000
Date:   Wed, 22 Feb 2023 04:05:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: drivers/input/touchscreen/sun4i-ts.c:392:34: warning: unused
 variable 'sun4i_ts_of_match'
Message-ID: <202302220342.AqAtycBB-lkp@intel.com>
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

Hi Paul,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9e58df973d2272e6e558965e7cb32453a4b380ff
commit: c434b9f80b0923e6460031b0fd964f8b0bf3c6a6 MIPS: Kconfig: add MIPS_GENERIC_KERNEL symbol
date:   2 years, 5 months ago
config: mips-randconfig-c004-20230217 (https://download.01.org/0day-ci/archive/20230222/202302220342.AqAtycBB-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project db89896bbbd2251fff457699635acbbedeead27f)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mipsel-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c434b9f80b0923e6460031b0fd964f8b0bf3c6a6
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout c434b9f80b0923e6460031b0fd964f8b0bf3c6a6
        # save the config file
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross  olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross 

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302220342.AqAtycBB-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/input/touchscreen/sun4i-ts.c:392:34: warning: unused variable 'sun4i_ts_of_match' [-Wunused-const-variable]
   static const struct of_device_id sun4i_ts_of_match[] = {
                                    ^
   1 warning generated.


vim +/sun4i_ts_of_match +392 drivers/input/touchscreen/sun4i-ts.c

f09f98d3240b7e Hans de Goede 2014-05-14  391  
6decea7c5438e2 Hans de Goede 2014-05-14 @392  static const struct of_device_id sun4i_ts_of_match[] = {
6decea7c5438e2 Hans de Goede 2014-05-14  393  	{ .compatible = "allwinner,sun4i-a10-ts", },
91c68a7c1d92b4 Hans de Goede 2015-03-08  394  	{ .compatible = "allwinner,sun5i-a13-ts", },
43c0e2234021d7 Chen-Yu Tsai  2015-01-26  395  	{ .compatible = "allwinner,sun6i-a31-ts", },
6decea7c5438e2 Hans de Goede 2014-05-14  396  	{ /* sentinel */ }
6decea7c5438e2 Hans de Goede 2014-05-14  397  };
6decea7c5438e2 Hans de Goede 2014-05-14  398  MODULE_DEVICE_TABLE(of, sun4i_ts_of_match);
6decea7c5438e2 Hans de Goede 2014-05-14  399  

:::::: The code at line 392 was first introduced by commit
:::::: 6decea7c5438e2955f64e2513ec9a2fac7602a7d Input: add driver for Allwinner sunxi SoC's rtp controller

:::::: TO: Hans de Goede <hdegoede@redhat.com>
:::::: CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
