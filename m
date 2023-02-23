Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D75B76A0C80
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 16:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234936AbjBWPGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 10:06:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233805AbjBWPGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 10:06:30 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 118E9521F8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 07:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677164778; x=1708700778;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=5Wm9mpnE9UWJcqzGbV9hTEi4VHRkA+qF7g43saRKdIY=;
  b=CJnEzVOGgSMHN3dJZ95tmgH0W5ZUm6k3yDomg9wbVX8j+0T0HKA5s1H6
   99ha8i/qChP1yplr9tj9NdkdscUfUs1OpLqhVWQtDUyymx+EauU9S8CyK
   6NILFcmzf0wH+WWy2Yf7+2mf0RczaWKqWQiCTDqwEZgFb9Rj52TOgigUK
   LRt9N8JVmc/7PxEeNZdV8kFSfuT+r5c5Jx5JlEmgbFswhRmCuS/G20TtO
   Z7tMMFOvl+T/MPZo4FyTlIEnnBgWpAcyOiqaPfxkHjCMXGK7qTxKJNlr6
   2vLHdLm8KoxAiKqlvYp8YQ8zKTKUyxoYC5qwESUGkouFluyhRJw4uL/mm
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10630"; a="321399206"
X-IronPort-AV: E=Sophos;i="5.97,320,1669104000"; 
   d="scan'208";a="321399206"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2023 06:53:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10630"; a="622352888"
X-IronPort-AV: E=Sophos;i="5.97,320,1669104000"; 
   d="scan'208";a="622352888"
Received: from lkp-server01.sh.intel.com (HELO 3895f5c55ead) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 23 Feb 2023 06:53:02 -0800
Received: from kbuild by 3895f5c55ead with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pVCxy-0001OH-0g;
        Thu, 23 Feb 2023 14:53:02 +0000
Date:   Thu, 23 Feb 2023 22:52:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jerome Neanne <jneanne@baylibre.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Lee Jones <lee@kernel.org>,
        Markus Schneider-Pargmann <msp@baylibre.com>
Subject: drivers/regulator/tps65219-regulator.c:310:60: warning: parameter
 'dev' set but not used
Message-ID: <202302232247.r8w2oeDy-lkp@intel.com>
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

Hi Jerome,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a5c95ca18a98d742d0a4a04063c32556b5b66378
commit: 74c17a0a49a6ad3b32cb130f25196d1f8d5d560e mfd: tps65219: Add driver for TI TPS65219 PMIC
date:   3 months ago
config: alpha-buildonly-randconfig-r004-20230222 (https://download.01.org/0day-ci/archive/20230223/202302232247.r8w2oeDy-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=74c17a0a49a6ad3b32cb130f25196d1f8d5d560e
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 74c17a0a49a6ad3b32cb130f25196d1f8d5d560e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=alpha olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=alpha SHELL=/bin/bash drivers/regulator/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302232247.r8w2oeDy-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/regulator/tps65219-regulator.c: In function 'tps65219_get_rdev_by_name':
>> drivers/regulator/tps65219-regulator.c:310:60: warning: parameter 'dev' set but not used [-Wunused-but-set-parameter]
     310 |                                      struct regulator_dev *dev)
         |                                      ~~~~~~~~~~~~~~~~~~~~~~^~~
   drivers/regulator/tps65219-regulator.c: In function 'tps65219_regulator_probe':
>> drivers/regulator/tps65219-regulator.c:370:26: warning: ordered comparison of pointer with integer zero [-Wextra]
     370 |                 if (rdev < 0) {
         |                          ^


vim +/dev +310 drivers/regulator/tps65219-regulator.c

c12ac5fc3e0af2 Jerome Neanne 2022-08-05  307  
c12ac5fc3e0af2 Jerome Neanne 2022-08-05  308  static int tps65219_get_rdev_by_name(const char *regulator_name,
c12ac5fc3e0af2 Jerome Neanne 2022-08-05  309  				     struct regulator_dev *rdevtbl[7],
c12ac5fc3e0af2 Jerome Neanne 2022-08-05 @310  				     struct regulator_dev *dev)
c12ac5fc3e0af2 Jerome Neanne 2022-08-05  311  {
c12ac5fc3e0af2 Jerome Neanne 2022-08-05  312  	int i;
c12ac5fc3e0af2 Jerome Neanne 2022-08-05  313  
c12ac5fc3e0af2 Jerome Neanne 2022-08-05  314  	for (i = 0; i < ARRAY_SIZE(regulators); i++) {
c12ac5fc3e0af2 Jerome Neanne 2022-08-05  315  		if (strcmp(regulator_name, regulators[i].name) == 0) {
c12ac5fc3e0af2 Jerome Neanne 2022-08-05  316  			dev = rdevtbl[i];
c12ac5fc3e0af2 Jerome Neanne 2022-08-05  317  			return 0;
c12ac5fc3e0af2 Jerome Neanne 2022-08-05  318  		}
c12ac5fc3e0af2 Jerome Neanne 2022-08-05  319  	}
c12ac5fc3e0af2 Jerome Neanne 2022-08-05  320  	return -EINVAL;
c12ac5fc3e0af2 Jerome Neanne 2022-08-05  321  }
c12ac5fc3e0af2 Jerome Neanne 2022-08-05  322  
c12ac5fc3e0af2 Jerome Neanne 2022-08-05  323  static int tps65219_regulator_probe(struct platform_device *pdev)
c12ac5fc3e0af2 Jerome Neanne 2022-08-05  324  {
c12ac5fc3e0af2 Jerome Neanne 2022-08-05  325  	struct tps65219 *tps = dev_get_drvdata(pdev->dev.parent);
c12ac5fc3e0af2 Jerome Neanne 2022-08-05  326  	struct regulator_dev *rdev;
c12ac5fc3e0af2 Jerome Neanne 2022-08-05  327  	struct regulator_config config = { };
c12ac5fc3e0af2 Jerome Neanne 2022-08-05  328  	int i;
c12ac5fc3e0af2 Jerome Neanne 2022-08-05  329  	int error;
c12ac5fc3e0af2 Jerome Neanne 2022-08-05  330  	int irq;
c12ac5fc3e0af2 Jerome Neanne 2022-08-05  331  	struct tps65219_regulator_irq_data *irq_data;
c12ac5fc3e0af2 Jerome Neanne 2022-08-05  332  	struct tps65219_regulator_irq_type *irq_type;
c12ac5fc3e0af2 Jerome Neanne 2022-08-05  333  	struct regulator_dev *rdevtbl[7];
c12ac5fc3e0af2 Jerome Neanne 2022-08-05  334  
c12ac5fc3e0af2 Jerome Neanne 2022-08-05  335  	config.dev = tps->dev;
c12ac5fc3e0af2 Jerome Neanne 2022-08-05  336  	config.driver_data = tps;
c12ac5fc3e0af2 Jerome Neanne 2022-08-05  337  	config.regmap = tps->regmap;
c12ac5fc3e0af2 Jerome Neanne 2022-08-05  338  
c12ac5fc3e0af2 Jerome Neanne 2022-08-05  339  	for (i = 0; i < ARRAY_SIZE(regulators); i++) {
c12ac5fc3e0af2 Jerome Neanne 2022-08-05  340  		dev_dbg(tps->dev, "%s regul i= %d START", __func__, i);
c12ac5fc3e0af2 Jerome Neanne 2022-08-05  341  		rdev = devm_regulator_register(&pdev->dev, &regulators[i],
c12ac5fc3e0af2 Jerome Neanne 2022-08-05  342  					       &config);
c12ac5fc3e0af2 Jerome Neanne 2022-08-05  343  		if (IS_ERR(rdev)) {
c12ac5fc3e0af2 Jerome Neanne 2022-08-05  344  			dev_err(tps->dev, "failed to register %s regulator\n",
c12ac5fc3e0af2 Jerome Neanne 2022-08-05  345  				pdev->name);
c12ac5fc3e0af2 Jerome Neanne 2022-08-05  346  			return PTR_ERR(rdev);
c12ac5fc3e0af2 Jerome Neanne 2022-08-05  347  		}
c12ac5fc3e0af2 Jerome Neanne 2022-08-05  348  		rdevtbl[i] = rdev;
c12ac5fc3e0af2 Jerome Neanne 2022-08-05  349  		dev_dbg(tps->dev, "%s regul i= %d COMPLETED", __func__, i);
c12ac5fc3e0af2 Jerome Neanne 2022-08-05  350  	}
c12ac5fc3e0af2 Jerome Neanne 2022-08-05  351  
c12ac5fc3e0af2 Jerome Neanne 2022-08-05  352  	irq_data = devm_kmalloc(tps->dev,
c12ac5fc3e0af2 Jerome Neanne 2022-08-05  353  				ARRAY_SIZE(tps65219_regulator_irq_types) *
c12ac5fc3e0af2 Jerome Neanne 2022-08-05  354  				sizeof(struct tps65219_regulator_irq_data),
c12ac5fc3e0af2 Jerome Neanne 2022-08-05  355  				GFP_KERNEL);
c12ac5fc3e0af2 Jerome Neanne 2022-08-05  356  	if (!irq_data)
c12ac5fc3e0af2 Jerome Neanne 2022-08-05  357  		return -ENOMEM;
c12ac5fc3e0af2 Jerome Neanne 2022-08-05  358  
c12ac5fc3e0af2 Jerome Neanne 2022-08-05  359  	for (i = 0; i < ARRAY_SIZE(tps65219_regulator_irq_types); ++i) {
c12ac5fc3e0af2 Jerome Neanne 2022-08-05  360  		irq_type = &tps65219_regulator_irq_types[i];
c12ac5fc3e0af2 Jerome Neanne 2022-08-05  361  
c12ac5fc3e0af2 Jerome Neanne 2022-08-05  362  		irq = platform_get_irq_byname(pdev, irq_type->irq_name);
d46f737208a45d Yang Li       2022-08-25  363  		if (irq < 0)
c12ac5fc3e0af2 Jerome Neanne 2022-08-05  364  			return -EINVAL;
d46f737208a45d Yang Li       2022-08-25  365  
c12ac5fc3e0af2 Jerome Neanne 2022-08-05  366  		irq_data[i].dev = tps->dev;
c12ac5fc3e0af2 Jerome Neanne 2022-08-05  367  		irq_data[i].type = irq_type;
c12ac5fc3e0af2 Jerome Neanne 2022-08-05  368  
c12ac5fc3e0af2 Jerome Neanne 2022-08-05  369  		tps65219_get_rdev_by_name(irq_type->regulator_name, rdevtbl, rdev);
c12ac5fc3e0af2 Jerome Neanne 2022-08-05 @370  		if (rdev < 0) {
c12ac5fc3e0af2 Jerome Neanne 2022-08-05  371  			dev_err(tps->dev, "Failed to get rdev for %s\n",
c12ac5fc3e0af2 Jerome Neanne 2022-08-05  372  				irq_type->regulator_name);
c12ac5fc3e0af2 Jerome Neanne 2022-08-05  373  			return -EINVAL;
c12ac5fc3e0af2 Jerome Neanne 2022-08-05  374  		}
c12ac5fc3e0af2 Jerome Neanne 2022-08-05  375  		irq_data[i].rdev = rdev;
c12ac5fc3e0af2 Jerome Neanne 2022-08-05  376  
c12ac5fc3e0af2 Jerome Neanne 2022-08-05  377  		error = devm_request_threaded_irq(tps->dev, irq, NULL,
c12ac5fc3e0af2 Jerome Neanne 2022-08-05  378  						  tps65219_regulator_irq_handler,
c12ac5fc3e0af2 Jerome Neanne 2022-08-05  379  						  IRQF_ONESHOT,
c12ac5fc3e0af2 Jerome Neanne 2022-08-05  380  						  irq_type->irq_name,
c12ac5fc3e0af2 Jerome Neanne 2022-08-05  381  						  &irq_data[i]);
c12ac5fc3e0af2 Jerome Neanne 2022-08-05  382  		if (error) {
c12ac5fc3e0af2 Jerome Neanne 2022-08-05  383  			dev_err(tps->dev, "failed to request %s IRQ %d: %d\n",
c12ac5fc3e0af2 Jerome Neanne 2022-08-05  384  				irq_type->irq_name, irq, error);
c12ac5fc3e0af2 Jerome Neanne 2022-08-05  385  			return error;
c12ac5fc3e0af2 Jerome Neanne 2022-08-05  386  		}
c12ac5fc3e0af2 Jerome Neanne 2022-08-05  387  	}
c12ac5fc3e0af2 Jerome Neanne 2022-08-05  388  
c12ac5fc3e0af2 Jerome Neanne 2022-08-05  389  	return 0;
c12ac5fc3e0af2 Jerome Neanne 2022-08-05  390  }
c12ac5fc3e0af2 Jerome Neanne 2022-08-05  391  

:::::: The code at line 310 was first introduced by commit
:::::: c12ac5fc3e0af29851785e557e243663b4fc7f4b regulator: drivers: Add TI TPS65219 PMIC regulators support

:::::: TO: Jerome Neanne <jneanne@baylibre.com>
:::::: CC: Mark Brown <broonie@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
