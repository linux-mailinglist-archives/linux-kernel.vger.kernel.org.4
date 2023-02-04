Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3E2868ACD3
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 23:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbjBDWQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 17:16:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbjBDWQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 17:16:01 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285E71554E
        for <linux-kernel@vger.kernel.org>; Sat,  4 Feb 2023 14:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675548960; x=1707084960;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Plgk4imI89DJIyFiyoJPXHa0tezSnh1RMpc0Bzd5PV0=;
  b=YyifnuEU4I9jOyfPrhriycp+NdOayy63/AbiVyGS3EMmAu22Vyb0ZsQc
   Yq/F3sIr1uk320la2mCQ+GZ+tKxMYg8hcXWBe31XH4QfxFc8OEYpiuMMO
   z4lhf3Ovh9faH9kdi52y8MJGVMbBglunoOq9R7A2mzcexKJTZQTz/KJXi
   dmnq/KDWaIQx+nobFjIAUs68C+RIt/fAZyo9AKkoYCraRMY39TvneHnCZ
   EhLGhq9vu5hc73fPbeYN8Wg5GZ8OCVtH5sP74CJeV4Vu5yOA3pUJuL/Wo
   qqN/34XII4pEPBKZEfRTBqCdQ5Xc+c1nu+d1KRZSsJmqH+Gsb3mMm10c9
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10611"; a="330287350"
X-IronPort-AV: E=Sophos;i="5.97,274,1669104000"; 
   d="scan'208";a="330287350"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2023 14:15:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10611"; a="668029649"
X-IronPort-AV: E=Sophos;i="5.97,272,1669104000"; 
   d="scan'208";a="668029649"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 04 Feb 2023 14:15:58 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pOQpB-0001YO-2F;
        Sat, 04 Feb 2023 22:15:57 +0000
Date:   Sun, 5 Feb 2023 06:15:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Stafford Horne <shorne@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/video/fbdev/sstfb.c:337:23: sparse: sparse: incorrect type
 in argument 1 (different address spaces)
Message-ID: <202302050615.2F4POBYV-lkp@intel.com>
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

Hi Stafford,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   db27c22251e7c8f3a9d5bfb55c9c8c701a70bbb3
commit: ded2ee36313c941f1a12b6f85cde295b575264ae openrisc: Add pci bus support
date:   6 months ago
config: openrisc-randconfig-s032-20230205 (https://download.01.org/0day-ci/archive/20230205/202302050615.2F4POBYV-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ded2ee36313c941f1a12b6f85cde295b575264ae
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout ded2ee36313c941f1a12b6f85cde295b575264ae
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=openrisc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=openrisc SHELL=/bin/bash drivers/video/fbdev/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> drivers/video/fbdev/sstfb.c:337:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *s @@     got char [noderef] __iomem *screen_base @@
   drivers/video/fbdev/sstfb.c:337:23: sparse:     expected void *s
   drivers/video/fbdev/sstfb.c:337:23: sparse:     got char [noderef] __iomem *screen_base

vim +337 drivers/video/fbdev/sstfb.c

^1da177e4c3f41 drivers/video/sstfb.c Linus Torvalds 2005-04-16  330  
^1da177e4c3f41 drivers/video/sstfb.c Linus Torvalds 2005-04-16  331  /*
^1da177e4c3f41 drivers/video/sstfb.c Linus Torvalds 2005-04-16  332   * clear lfb screen
^1da177e4c3f41 drivers/video/sstfb.c Linus Torvalds 2005-04-16  333   */
^1da177e4c3f41 drivers/video/sstfb.c Linus Torvalds 2005-04-16  334  static void sstfb_clear_screen(struct fb_info *info)
^1da177e4c3f41 drivers/video/sstfb.c Linus Torvalds 2005-04-16  335  {
^1da177e4c3f41 drivers/video/sstfb.c Linus Torvalds 2005-04-16  336  	/* clear screen */
^1da177e4c3f41 drivers/video/sstfb.c Linus Torvalds 2005-04-16 @337  	fb_memset(info->screen_base, 0, info->fix.smem_len);
^1da177e4c3f41 drivers/video/sstfb.c Linus Torvalds 2005-04-16  338  }
^1da177e4c3f41 drivers/video/sstfb.c Linus Torvalds 2005-04-16  339  

:::::: The code at line 337 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
