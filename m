Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E85245BBAA6
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 23:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbiIQVTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 17:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiIQVTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 17:19:10 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A63275CA
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 14:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663449548; x=1694985548;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9e36sAeWHdkpRtQMbPWe++XKnl9dnfw1iywNX9erSA8=;
  b=N/wGHRRYFWlFiHysRtLAbAATciMYgPF8kkukVuQ1LsxS6ML5jkmA4/pe
   C9P/+sJSOi5TS/lrvP/UYritYK8C8iOjXzmwW03vgInFmqG/JafxooqUZ
   GtyIwiLCNV1nkKwJ/pZkmzWp9eVEMEOSAsYN/ZfW6FpzyEWu6mEixFo0S
   1LWLGTe0A/jKcRwmP7nX1d/8cwUpEgFPlB7ZrSSHq0LwIW/GLW0qeGgYB
   rndaY5VARuyHIaqEfPFf97bmU4yHyl42o/6F0RB5XBuife0mxA9+fx5JU
   f85a8XkZTgQ4zQn7reWLJCbSBImF2zNq7Zbg80R9pbJvMntSa/9ey2jkG
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10473"; a="297909876"
X-IronPort-AV: E=Sophos;i="5.93,323,1654585200"; 
   d="scan'208";a="297909876"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2022 14:19:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,323,1654585200"; 
   d="scan'208";a="863088869"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 17 Sep 2022 14:19:07 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oZfDO-0000c5-2m;
        Sat, 17 Sep 2022 21:19:06 +0000
Date:   Sun, 18 Sep 2022 05:18:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/video/fbdev/omap/lcd_mipid.c:451:23: sparse: sparse: cast to
 restricted __be32
Message-ID: <202209180507.z4LLyzZO-lkp@intel.com>
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
head:   a335366bad1364a07f49df9da1fdfa6d411a5f39
commit: 804f7f19c2e2928aeb8eafef8379fe8b8d13f98b fbdev: omap: avoid using mach/*.h files
date:   5 months ago
config: arm-randconfig-s033-20220918 (https://download.01.org/0day-ci/archive/20220918/202209180507.z4LLyzZO-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=804f7f19c2e2928aeb8eafef8379fe8b8d13f98b
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 804f7f19c2e2928aeb8eafef8379fe8b8d13f98b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm SHELL=/bin/bash drivers/video/fbdev/omap/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> drivers/video/fbdev/omap/lcd_mipid.c:451:23: sparse: sparse: cast to restricted __be32

vim +451 drivers/video/fbdev/omap/lcd_mipid.c

66d2f99d0bb5a2 drivers/video/omap/lcd_mipid.c Imre Deak 2009-09-22  444  
66d2f99d0bb5a2 drivers/video/omap/lcd_mipid.c Imre Deak 2009-09-22  445  static int panel_enabled(struct mipid_device *md)
66d2f99d0bb5a2 drivers/video/omap/lcd_mipid.c Imre Deak 2009-09-22  446  {
66d2f99d0bb5a2 drivers/video/omap/lcd_mipid.c Imre Deak 2009-09-22  447  	u32 disp_status;
66d2f99d0bb5a2 drivers/video/omap/lcd_mipid.c Imre Deak 2009-09-22  448  	int enabled;
66d2f99d0bb5a2 drivers/video/omap/lcd_mipid.c Imre Deak 2009-09-22  449  
66d2f99d0bb5a2 drivers/video/omap/lcd_mipid.c Imre Deak 2009-09-22  450  	mipid_read(md, MIPID_CMD_READ_DISP_STATUS, (u8 *)&disp_status, 4);
66d2f99d0bb5a2 drivers/video/omap/lcd_mipid.c Imre Deak 2009-09-22 @451  	disp_status = __be32_to_cpu(disp_status);
66d2f99d0bb5a2 drivers/video/omap/lcd_mipid.c Imre Deak 2009-09-22  452  	enabled = (disp_status & (1 << 17)) && (disp_status & (1 << 10));
66d2f99d0bb5a2 drivers/video/omap/lcd_mipid.c Imre Deak 2009-09-22  453  	dev_dbg(&md->spi->dev,
66d2f99d0bb5a2 drivers/video/omap/lcd_mipid.c Imre Deak 2009-09-22  454  		"LCD panel %senabled by bootloader (status 0x%04x)\n",
66d2f99d0bb5a2 drivers/video/omap/lcd_mipid.c Imre Deak 2009-09-22  455  		enabled ? "" : "not ", disp_status);
66d2f99d0bb5a2 drivers/video/omap/lcd_mipid.c Imre Deak 2009-09-22  456  	return enabled;
66d2f99d0bb5a2 drivers/video/omap/lcd_mipid.c Imre Deak 2009-09-22  457  }
66d2f99d0bb5a2 drivers/video/omap/lcd_mipid.c Imre Deak 2009-09-22  458  

:::::: The code at line 451 was first introduced by commit
:::::: 66d2f99d0bb5a2972fb5c1d88b61169510e540d6 omapfb: add support for MIPI-DCS compatible LCDs

:::::: TO: Imre Deak <imre.deak@nokia.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
