Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 218555B4B55
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 04:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiIKCmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 22:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiIKCmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 22:42:35 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC1243135E
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 19:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662864154; x=1694400154;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=a+Va3J7nnKzBSpwB8G095mxgIqFK4sfoqfQxl0BYfNg=;
  b=ivdxViYSHwNZvlSuI9iGNfdIiO391SPrpuefMAvA7saPhB8ZrVRD+rb+
   8sxA5RbGZCCRxbwBV0lAr5vJckFkaZ9VsvBjOJtaH+C+9DABUX84sgfGp
   BXHKGXT3Il65iQrg3AEqvx2FhpnNWR7xvid0fFsAXq13Tuc+32Ek1DmUe
   rn7rdcC3hoxKVGrQ5qMSUx0prVNbNBwDxQXPBi61LzIamEDtO0TlKPolb
   wQEYyQpomjBFCYU1nvUnwpPSiFqwVct84nxMNEdWSWa4Kl+WdlYf02+4l
   3wWTl/yjq3DGCXdVXpE24tt7aZLIGTb/UtI7uc589FPKRD8MwUjNmWV+Q
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10466"; a="277422363"
X-IronPort-AV: E=Sophos;i="5.93,307,1654585200"; 
   d="scan'208";a="277422363"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2022 19:42:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,307,1654585200"; 
   d="scan'208";a="758012975"
Received: from lkp-server02.sh.intel.com (HELO 4011df4f4fd3) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 10 Sep 2022 19:42:33 -0700
Received: from kbuild by 4011df4f4fd3 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oXCvY-0000sd-26;
        Sun, 11 Sep 2022 02:42:32 +0000
Date:   Sun, 11 Sep 2022 10:42:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Devarsh Thakkar <devarsht@ti.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Aswath Govindraju <a-govindraju@ti.com>
Subject: drivers/gpio/gpio-davinci.c:704:1: sparse: sparse: symbol
 'davinci_gpio_dev_pm_ops' was not declared. Should it be static?
Message-ID: <202209111012.SuQNMgoq-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b96fbd602d35739b5cdb49baa02048f2c41fdab1
commit: 0651a730924b172476f67c7c6e01e898f84cd8f3 gpio: davinci: Add support for system suspend/resume PM
date:   8 weeks ago
config: arm64-randconfig-s051-20220911 (https://download.01.org/0day-ci/archive/20220911/202209111012.SuQNMgoq-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0651a730924b172476f67c7c6e01e898f84cd8f3
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 0651a730924b172476f67c7c6e01e898f84cd8f3
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/gpio/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> drivers/gpio/gpio-davinci.c:704:1: sparse: sparse: symbol 'davinci_gpio_dev_pm_ops' was not declared. Should it be static?

vim +/davinci_gpio_dev_pm_ops +704 drivers/gpio/gpio-davinci.c

   703	
 > 704	DEFINE_SIMPLE_DEV_PM_OPS(davinci_gpio_dev_pm_ops, davinci_gpio_suspend,
   705				 davinci_gpio_resume);
   706	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
