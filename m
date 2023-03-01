Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 134416A74C9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 21:10:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjCAUKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 15:10:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjCAUKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 15:10:50 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D8441B4F
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 12:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677701448; x=1709237448;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=H2gb310Vh/tQ2QVSRE3iWoVhZ5Tja9P5k8VPe5EDTCs=;
  b=AZeV4Kj87hrHMKS/a182gS+pxBuXtbuC59gA6wb2S2QhjotcjpkJIPs2
   JPtcnGljA6sMXfYKz7kpRfdCdFreZPUbl3Tqd6Vq9k32xSSuMtwYjKNk2
   VckrK9vpV8szEsxiqiOTuA6pSkoMtm3hv3QzL4eUDUy1iQeTx6eQ2Kqid
   Kwb75vuYcwJyiGo95frIuGot0x6XlbYm/g+0dOUvabPDo5+yzhFZFhLoT
   R5tNEW2pHzFFwM/c06GjCOTKKZ1pJaZvQBdpOo5YtavW8lRZzVXdTWA4p
   35jwt1/KOBEh8xl4cWsf8QK8xe78wRDDEbsm9Cm503bZYgu+6Y/fCSe5Q
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="322778588"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="322778588"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 12:10:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="667997311"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="667997311"
Received: from lkp-server01.sh.intel.com (HELO 3895f5c55ead) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 01 Mar 2023 12:10:34 -0800
Received: from kbuild by 3895f5c55ead with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pXSmX-0006OF-2u;
        Wed, 01 Mar 2023 20:10:33 +0000
Date:   Thu, 2 Mar 2023 04:10:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Naresh Solanki <naresh.solanki@9elements.com>,
        Lee Jones <lee@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Marcello Sylvester Bauer <sylv@sylv.io>,
        Naresh Solanki <Naresh.Solanki@9elements.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mfd: max597x: Add support for MAX5970 and MAX5978
Message-ID: <202303020344.8ATqgdUl-lkp@intel.com>
References: <20230301091234.3159953-2-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230301091234.3159953-2-Naresh.Solanki@9elements.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Naresh,

I love your patch! Yet something to improve:

[auto build test ERROR on 59c54c59974649b2e7bc92faae4a21e2b2408db2]

url:    https://github.com/intel-lab-lkp/linux/commits/Naresh-Solanki/mfd-max597x-Add-support-for-MAX5970-and-MAX5978/20230301-171527
base:   59c54c59974649b2e7bc92faae4a21e2b2408db2
patch link:    https://lore.kernel.org/r/20230301091234.3159953-2-Naresh.Solanki%409elements.com
patch subject: [PATCH 2/2] mfd: max597x: Add support for MAX5970 and MAX5978
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20230302/202303020344.8ATqgdUl-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/68623f7868d887a57422ce2cd6f5dc1ee1510f1e
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Naresh-Solanki/mfd-max597x-Add-support-for-MAX5970-and-MAX5978/20230301-171527
        git checkout 68623f7868d887a57422ce2cd6f5dc1ee1510f1e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sh olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sh SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303020344.8ATqgdUl-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/regulator/max597x-regulator.c: In function 'max597x_regulator_probe':
>> drivers/regulator/max597x-regulator.c:447:41: error: 'struct max597x_data' has no member named 'dev'
     447 |                     devm_kzalloc(max597x->dev, sizeof(struct max597x_regulator),
         |                                         ^~
>> drivers/regulator/max597x-regulator.c:453:39: error: 'struct max597x_data' has no member named 'regmap'
     453 |                 data->regmap = max597x->regmap;
         |                                       ^~
   drivers/regulator/max597x-regulator.c:462:37: error: 'struct max597x_data' has no member named 'dev'
     462 |                 config.dev = max597x->dev;
         |                                     ^~
   drivers/regulator/max597x-regulator.c:465:55: error: 'struct max597x_data' has no member named 'dev'
     465 |                 rdev = devm_regulator_register(max597x->dev,
         |                                                       ^~
   In file included from include/linux/device.h:15,
                    from drivers/regulator/max597x-regulator.c:11:
   drivers/regulator/max597x-regulator.c:468:40: error: 'struct max597x_data' has no member named 'dev'
     468 |                         dev_err(max597x->dev, "failed to register regulator %s\n",
         |                                        ^~
   include/linux/dev_printk.h:110:25: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                         ^~~
   drivers/regulator/max597x-regulator.c:468:25: note: in expansion of macro 'dev_err'
     468 |                         dev_err(max597x->dev, "failed to register regulator %s\n",
         |                         ^~~~~~~
>> drivers/regulator/max597x-regulator.c:476:20: error: 'struct max597x_data' has no member named 'irq'
     476 |         if (max597x->irq) {
         |                    ^~
   drivers/regulator/max597x-regulator.c:478:46: error: 'struct max597x_data' has no member named 'dev'
     478 |                     max597x_setup_irq(max597x->dev, max597x->irq, rdevs, num_switches,
         |                                              ^~
   drivers/regulator/max597x-regulator.c:478:60: error: 'struct max597x_data' has no member named 'irq'
     478 |                     max597x_setup_irq(max597x->dev, max597x->irq, rdevs, num_switches,
         |                                                            ^~
   drivers/regulator/max597x-regulator.c:481:40: error: 'struct max597x_data' has no member named 'dev'
     481 |                         dev_err(max597x->dev, "IRQ setup failed");
         |                                        ^~
   include/linux/dev_printk.h:110:25: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                         ^~~
   drivers/regulator/max597x-regulator.c:481:25: note: in expansion of macro 'dev_err'
     481 |                         dev_err(max597x->dev, "IRQ setup failed");
         |                         ^~~~~~~
   drivers/regulator/max597x-regulator.c: At top level:
   drivers/regulator/max597x-regulator.c:360:35: warning: 'max597x_regmap_config' defined but not used [-Wunused-const-variable=]
     360 | static const struct regmap_config max597x_regmap_config = {
         |                                   ^~~~~~~~~~~~~~~~~~~~~


vim +447 drivers/regulator/max597x-regulator.c

38493f008deb435 Patrick Rudolph 2022-07-05  434  
38493f008deb435 Patrick Rudolph 2022-07-05  435  
38493f008deb435 Patrick Rudolph 2022-07-05  436  	struct max597x_data *max597x = dev_get_drvdata(pdev->dev.parent);
38493f008deb435 Patrick Rudolph 2022-07-05  437  	struct max597x_regulator *data;
38493f008deb435 Patrick Rudolph 2022-07-05  438  
38493f008deb435 Patrick Rudolph 2022-07-05  439  	struct regulator_config config = { };
38493f008deb435 Patrick Rudolph 2022-07-05  440  	struct regulator_dev *rdev;
38493f008deb435 Patrick Rudolph 2022-07-05  441  	struct regulator_dev *rdevs[MAX5970_NUM_SWITCHES];
38493f008deb435 Patrick Rudolph 2022-07-05  442  	int num_switches = max597x->num_switches;
38493f008deb435 Patrick Rudolph 2022-07-05  443  	int ret, i;
38493f008deb435 Patrick Rudolph 2022-07-05  444  
38493f008deb435 Patrick Rudolph 2022-07-05  445  	for (i = 0; i < num_switches; i++) {
38493f008deb435 Patrick Rudolph 2022-07-05  446  		data =
38493f008deb435 Patrick Rudolph 2022-07-05 @447  		    devm_kzalloc(max597x->dev, sizeof(struct max597x_regulator),
38493f008deb435 Patrick Rudolph 2022-07-05  448  				 GFP_KERNEL);
38493f008deb435 Patrick Rudolph 2022-07-05  449  		if (!data)
38493f008deb435 Patrick Rudolph 2022-07-05  450  			return -ENOMEM;
38493f008deb435 Patrick Rudolph 2022-07-05  451  
38493f008deb435 Patrick Rudolph 2022-07-05  452  		data->num_switches = num_switches;
38493f008deb435 Patrick Rudolph 2022-07-05 @453  		data->regmap = max597x->regmap;
38493f008deb435 Patrick Rudolph 2022-07-05  454  
38493f008deb435 Patrick Rudolph 2022-07-05  455  		ret = max597x_adc_range(data->regmap, i, &max597x->irng[i], &max597x->mon_rng[i]);
38493f008deb435 Patrick Rudolph 2022-07-05  456  		if (ret < 0)
38493f008deb435 Patrick Rudolph 2022-07-05  457  			return ret;
38493f008deb435 Patrick Rudolph 2022-07-05  458  
38493f008deb435 Patrick Rudolph 2022-07-05  459  		data->irng = max597x->irng[i];
38493f008deb435 Patrick Rudolph 2022-07-05  460  		data->mon_rng = max597x->mon_rng[i];
38493f008deb435 Patrick Rudolph 2022-07-05  461  
38493f008deb435 Patrick Rudolph 2022-07-05  462  		config.dev = max597x->dev;
38493f008deb435 Patrick Rudolph 2022-07-05  463  		config.driver_data = (void *)data;
38493f008deb435 Patrick Rudolph 2022-07-05  464  		config.regmap = data->regmap;
38493f008deb435 Patrick Rudolph 2022-07-05  465  		rdev = devm_regulator_register(max597x->dev,
38493f008deb435 Patrick Rudolph 2022-07-05  466  					       &regulators[i], &config);
38493f008deb435 Patrick Rudolph 2022-07-05  467  		if (IS_ERR(rdev)) {
38493f008deb435 Patrick Rudolph 2022-07-05  468  			dev_err(max597x->dev, "failed to register regulator %s\n",
38493f008deb435 Patrick Rudolph 2022-07-05  469  				regulators[i].name);
38493f008deb435 Patrick Rudolph 2022-07-05  470  			return PTR_ERR(rdev);
38493f008deb435 Patrick Rudolph 2022-07-05  471  		}
38493f008deb435 Patrick Rudolph 2022-07-05  472  		rdevs[i] = rdev;
38493f008deb435 Patrick Rudolph 2022-07-05  473  		max597x->shunt_micro_ohms[i] = data->shunt_micro_ohms;
38493f008deb435 Patrick Rudolph 2022-07-05  474  	}
38493f008deb435 Patrick Rudolph 2022-07-05  475  
38493f008deb435 Patrick Rudolph 2022-07-05 @476  	if (max597x->irq) {
38493f008deb435 Patrick Rudolph 2022-07-05  477  		ret =
38493f008deb435 Patrick Rudolph 2022-07-05  478  		    max597x_setup_irq(max597x->dev, max597x->irq, rdevs, num_switches,
38493f008deb435 Patrick Rudolph 2022-07-05  479  				      data);
38493f008deb435 Patrick Rudolph 2022-07-05  480  		if (ret) {
38493f008deb435 Patrick Rudolph 2022-07-05  481  			dev_err(max597x->dev, "IRQ setup failed");
38493f008deb435 Patrick Rudolph 2022-07-05  482  			return ret;
38493f008deb435 Patrick Rudolph 2022-07-05  483  		}
38493f008deb435 Patrick Rudolph 2022-07-05  484  	}
38493f008deb435 Patrick Rudolph 2022-07-05  485  
38493f008deb435 Patrick Rudolph 2022-07-05  486  	return ret;
38493f008deb435 Patrick Rudolph 2022-07-05  487  }
38493f008deb435 Patrick Rudolph 2022-07-05  488  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
