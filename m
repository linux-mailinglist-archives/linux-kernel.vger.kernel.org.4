Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC5A67FCB8
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 05:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbjA2EMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 23:12:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjA2EMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 23:12:45 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A946820069
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 20:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674965563; x=1706501563;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2gbhL4C0dsuascfNB2Cf58aoG5ppAOxbOutSsyOfwpE=;
  b=WsaoixNTriB2Wlc08zNqHqZkha6w6XqdIft/L0uHBMC9E0hLWhwWKs/T
   K+7rD5gjUV0e/9l1zZo4eSrmR6a5Zv3GXByPW8pP7qD4k1BPPfNY1E0uE
   peaKGMzptxge2Cixln/HZjd7gQboUzXTBZ7ZKMILt/yKkrNhLaojI9xiV
   VKQCIEiunVxST15ydODQ+RUVN1B8qOWbfzhp7dgAdqoXW4hpuztr+PtFG
   AHD+rP/daE4ksJ2WBthuYYmSOKjZ4t3O5DKYs1cScAd1/UABC666w24/C
   G/XcKtLgzlcE6OYSj6oKVQBN+OFj7wQgs/x9qBAIeEJA1WgB0wapYA0gU
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="310982871"
X-IronPort-AV: E=Sophos;i="5.97,254,1669104000"; 
   d="scan'208";a="310982871"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2023 20:12:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="752416786"
X-IronPort-AV: E=Sophos;i="5.97,254,1669104000"; 
   d="scan'208";a="752416786"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 28 Jan 2023 20:12:41 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pLz3Y-0002SM-2K;
        Sun, 29 Jan 2023 04:12:40 +0000
Date:   Sun, 29 Jan 2023 12:11:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Devarsh Thakkar <devarsht@ti.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Aswath Govindraju <a-govindraju@ti.com>
Subject: drivers/gpio/gpio-davinci.c:704:1: sparse: sparse: symbol
 'davinci_gpio_dev_pm_ops' was not declared. Should it be static?
Message-ID: <202301291241.d3xh6GiJ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c96618275234ad03d44eafe9f8844305bb44fda4
commit: 0651a730924b172476f67c7c6e01e898f84cd8f3 gpio: davinci: Add support for system suspend/resume PM
date:   6 months ago
config: arm64-randconfig-s051-20230129 (https://download.01.org/0day-ci/archive/20230129/202301291241.d3xh6GiJ-lkp@intel.com/config)
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
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/gpio/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> drivers/gpio/gpio-davinci.c:704:1: sparse: sparse: symbol 'davinci_gpio_dev_pm_ops' was not declared. Should it be static?

vim +/davinci_gpio_dev_pm_ops +704 drivers/gpio/gpio-davinci.c

   699	
   700	DEFINE_SIMPLE_DEV_PM_OPS(davinci_gpio_dev_pm_ops, davinci_gpio_suspend,
   701				 davinci_gpio_resume);
   702	
   703	static const struct of_device_id davinci_gpio_ids[] = {
 > 704		{ .compatible = "ti,keystone-gpio", keystone_gpio_get_irq_chip},
   705		{ .compatible = "ti,am654-gpio", keystone_gpio_get_irq_chip},
   706		{ .compatible = "ti,dm6441-gpio", davinci_gpio_get_irq_chip},
   707		{ /* sentinel */ },
   708	};
   709	MODULE_DEVICE_TABLE(of, davinci_gpio_ids);
   710	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
