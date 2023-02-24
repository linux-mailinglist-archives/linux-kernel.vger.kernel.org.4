Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81CBE6A2409
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 23:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbjBXWGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 17:06:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjBXWGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 17:06:15 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B63AC61ED6;
        Fri, 24 Feb 2023 14:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677276373; x=1708812373;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rDITd1hAY7Tct9xmSw77zAJ3KaORKpMyyv5EjImDJMI=;
  b=M+Bkz/JO5VRWcqL815vlzxH5qX2zIZFcCqR2TOA2PY8YBtLGat0OabWo
   6WOA/nalPa8YgH9Sev8gnXImiF68Cv/omBtF2MI9r+uLaU9WzTEjeMJOb
   fLJpkNyqYcRLLgkPO733Y4QOZxyqCOV4O1ZksK12OqIyCPbRDv3AapHTu
   qbsJCAcE5TRPWD42pPXvmrOzY4sdz2NZcfiocxizCZKWnGX2p3kFk8j65
   D0QyqkBjjY3gmNL7WWeM2XPLL++ctAD+Kpl3vcV/wDYkCR4PxysqtGSpA
   napvMfNXOc26OdZVjDAN8EwlFGaDWENM5TOzNX8HPm/Z5Tvh0kdwP1ETG
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10631"; a="335021085"
X-IronPort-AV: E=Sophos;i="5.97,326,1669104000"; 
   d="scan'208";a="335021085"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2023 14:06:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10631"; a="847082338"
X-IronPort-AV: E=Sophos;i="5.97,326,1669104000"; 
   d="scan'208";a="847082338"
Received: from lkp-server01.sh.intel.com (HELO 3895f5c55ead) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 24 Feb 2023 14:06:09 -0800
Received: from kbuild by 3895f5c55ead with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pVgCe-0002ky-2T;
        Fri, 24 Feb 2023 22:06:08 +0000
Date:   Sat, 25 Feb 2023 06:06:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Esteban Blanc <eblanc@baylibre.com>, linus.walleij@linaro.org,
        lgirdwood@gmail.com, broonie@kernel.org, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-rtc@vger.kernel.org,
        jpanis@baylibre.com, jneanne@baylibre.com
Subject: Re: [PATCH INTERNAL v1 3/3] regulator: tps6594-regulator: Add driver
 for TI TPS6594 regulators
Message-ID: <202302250541.p9Kg2Tc6-lkp@intel.com>
References: <20230224133129.887203-4-eblanc@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230224133129.887203-4-eblanc@baylibre.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Esteban,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linusw-pinctrl/devel]
[also build test WARNING on linusw-pinctrl/for-next broonie-regulator/for-next abelloni/rtc-next linus/master v6.2 next-20230224]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Esteban-Blanc/rtc-tps6594-add-driver-for-TPS6594-PMIC-RTC/20230224-213323
base:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git devel
patch link:    https://lore.kernel.org/r/20230224133129.887203-4-eblanc%40baylibre.com
patch subject: [PATCH INTERNAL v1 3/3] regulator: tps6594-regulator: Add driver for TI TPS6594 regulators
config: sparc-allyesconfig (https://download.01.org/0day-ci/archive/20230225/202302250541.p9Kg2Tc6-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/740925ed262d27dda4f7b9af4c0173a845fa0578
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Esteban-Blanc/rtc-tps6594-add-driver-for-TPS6594-PMIC-RTC/20230224-213323
        git checkout 740925ed262d27dda4f7b9af4c0173a845fa0578
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sparc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sparc SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302250541.p9Kg2Tc6-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/regulator/tps6594-regulator.c: In function 'tps6594_get_rdev_by_name':
>> drivers/regulator/tps6594-regulator.c:342:59: warning: parameter 'dev' set but not used [-Wunused-but-set-parameter]
     342 |                                     struct regulator_dev *dev)
         |                                     ~~~~~~~~~~~~~~~~~~~~~~^~~
   drivers/regulator/tps6594-regulator.c: In function 'tps6594_regulator_probe':
>> drivers/regulator/tps6594-regulator.c:493:26: warning: ordered comparison of pointer with integer zero [-Wextra]
     493 |                 if (rdev < 0) {
         |                          ^
>> drivers/regulator/tps6594-regulator.c:381:13: warning: variable 'multi_phase_case' set but not used [-Wunused-but-set-variable]
     381 |         int multi_phase_case = 0xFFFF;
         |             ^~~~~~~~~~~~~~~~
>> drivers/regulator/tps6594-regulator.c:377:31: warning: variable 'rdevmultitbl' set but not used [-Wunused-but-set-variable]
     377 |         struct regulator_dev *rdevmultitbl[MULTI_PHASE_NB];
         |                               ^~~~~~~~~~~~


vim +/dev +342 drivers/regulator/tps6594-regulator.c

   338	
   339	static int tps6594_get_rdev_by_name(const char *regulator_name,
   340					    struct regulator_dev *rdevbucktbl[BUCK_NB],
   341					    struct regulator_dev *rdevldotbl[LDO_NB],
 > 342					    struct regulator_dev *dev)
   343	{
   344		int i;
   345	
   346		for (i = 0; i <= BUCK_NB; i++) {
   347			if (strcmp(regulator_name, buck_regs[i].name) == 0) {
   348				dev = rdevbucktbl[i];
   349				return 0;
   350			}
   351		}
   352	
   353		for (i = 0; i < ARRAY_SIZE(ldo_regs); i++) {
   354			if (strcmp(regulator_name, ldo_regs[i].name) == 0) {
   355				dev = rdevldotbl[i];
   356				return 0;
   357			}
   358		}
   359		return -EINVAL;
   360	}
   361	
   362	static int tps6594_regulator_probe(struct platform_device *pdev)
   363	{
   364		struct tps6594 *tps = dev_get_drvdata(pdev->dev.parent);
   365		struct regulator_dev *rdev;
   366		struct regulator_config config = {};
   367		u8 buck_configured[BUCK_NB] = { 0 };
   368		u8 buck_multi[MULTI_PHASE_NB] = { 0 };
   369		int i;
   370		int error;
   371		int irq;
   372		int ext_reg_irq_nb = 2;
   373		struct tps6594_regulator_irq_data *irq_data;
   374		struct tps6594_ext_regulator_irq_data *irq_ext_reg_data;
   375		struct tps6594_regulator_irq_type *irq_type;
   376		struct regulator_dev *rdevbucktbl[BUCK_NB];
 > 377		struct regulator_dev *rdevmultitbl[MULTI_PHASE_NB];
   378		struct regulator_dev *rdevldotbl[LDO_NB];
   379	
   380		int multi_phase_id;
 > 381		int multi_phase_case = 0xFFFF;
   382	
   383		config.dev = tps->dev;
   384		config.driver_data = tps;
   385		config.regmap = tps->regmap;
   386	
   387		/*
   388		 * Switch case defines different possible multi phase config
   389		 * This is based on dts custom property: multi-phase-id
   390		 * Using compatible or device rev is a too complex alternative
   391		 * Default case is no Multiphase buck.
   392		 * In case of Multiphase configuration, value should be defined for
   393		 * buck_configured to avoid creating bucks for every buck in multiphase
   394		 */
   395	
   396		if (device_property_present(tps->dev, "ti,multi-phase-id")) {
   397			device_property_read_u32(tps->dev, "ti,multi-phase-id", &multi_phase_id);
   398			switch (multi_phase_id) {
   399			case 12:
   400				buck_multi[0] = 1;
   401				buck_configured[0] = 1;
   402				buck_configured[1] = 1;
   403				multi_phase_case = TPS6594_BUCK_12;
   404				break;
   405			case 34:
   406				buck_multi[1] = 1;
   407				buck_configured[2] = 1;
   408				buck_configured[3] = 1;
   409				multi_phase_case = TPS6594_BUCK_34;
   410				break;
   411			case 123:
   412				buck_multi[2] = 1;
   413				buck_configured[0] = 1;
   414				buck_configured[1] = 1;
   415				buck_configured[2] = 1;
   416				multi_phase_case = TPS6594_BUCK_123;
   417				break;
   418			case 1234:
   419				buck_multi[3] = 1;
   420				buck_configured[0] = 1;
   421				buck_configured[1] = 1;
   422				buck_configured[2] = 1;
   423				buck_configured[3] = 1;
   424				multi_phase_case = TPS6594_BUCK_1234;
   425				break;
   426			}
   427		}
   428	
   429		for (i = 0; i < MULTI_PHASE_NB; i++) {
   430			if (buck_multi[i] == 0)
   431				continue;
   432	
   433			rdev = devm_regulator_register(&pdev->dev, &multi_regs[i], &config);
   434			if (IS_ERR(rdev)) {
   435				dev_err(tps->dev, "failed to register %s regulator\n",
   436					pdev->name);
   437				return PTR_ERR(rdev);
   438			}
   439			rdevmultitbl[i] = rdev;
   440		}
   441	
   442		if (tps->chip_id == LP8764X)
   443			/* There is only 4 buck on LP8764X */
   444			buck_configured[4] = 1;
   445	
   446		for (i = 0; i < BUCK_NB; i++) {
   447			if (buck_configured[i] == 1)
   448				continue;
   449	
   450			rdev = devm_regulator_register(&pdev->dev, &buck_regs[i], &config);
   451			if (IS_ERR(rdev)) {
   452				dev_err(tps->dev, "failed to register %s regulator\n",
   453					pdev->name);
   454				return PTR_ERR(rdev);
   455			}
   456			rdevbucktbl[i] = rdev;
   457		}
   458	
   459		/* LP8764X dosen't have LDO */
   460		if (tps->chip_id != LP8764X) {
   461			for (i = 0; i < ARRAY_SIZE(ldo_regs); i++) {
   462				rdev = devm_regulator_register(&pdev->dev, &ldo_regs[i], &config);
   463				if (IS_ERR(rdev)) {
   464					dev_err(tps->dev,
   465						"failed to register %s regulator\n",
   466						pdev->name);
   467					return PTR_ERR(rdev);
   468				}
   469				rdevldotbl[i] = rdev;
   470			}
   471		}
   472	
   473		irq_data = devm_kmalloc(tps->dev,
   474					ARRAY_SIZE(tps6594_regulator_irq_types) *
   475					sizeof(struct tps6594_regulator_irq_data),
   476					GFP_KERNEL);
   477		if (!irq_data)
   478			return -ENOMEM;
   479	
   480		for (i = 0; i < ARRAY_SIZE(tps6594_regulator_irq_types); ++i) {
   481			irq_type = &tps6594_regulator_irq_types[i];
   482	
   483			irq = platform_get_irq_byname(pdev, irq_type->irq_name);
   484			if (irq < 0)
   485				return -EINVAL;
   486	
   487			irq_data[i].dev = tps->dev;
   488			irq_data[i].type = irq_type;
   489	
   490			tps6594_get_rdev_by_name(irq_type->regulator_name, rdevbucktbl,
   491						 rdevldotbl, rdev);
   492	
 > 493			if (rdev < 0) {
   494				dev_err(tps->dev, "Failed to get rdev for %s\n",
   495					irq_type->regulator_name);
   496				return -EINVAL;
   497			}
   498			irq_data[i].rdev = rdev;
   499	
   500			error = devm_request_threaded_irq(tps->dev, irq, NULL,
   501							  tps6594_regulator_irq_handler,
   502							  IRQF_ONESHOT,
   503							  irq_type->irq_name,
   504							  &irq_data[i]);
   505			if (error) {
   506				dev_err(tps->dev, "failed to request %s IRQ %d: %d\n",
   507					irq_type->irq_name, irq, error);
   508				return error;
   509			}
   510		}
   511	
   512		if (tps->chip_id == LP8764X)
   513			ext_reg_irq_nb = ARRAY_SIZE(tps6594_ext_regulator_irq_types);
   514	
   515		irq_ext_reg_data = devm_kmalloc(tps->dev,
   516						ext_reg_irq_nb *
   517						sizeof(struct tps6594_ext_regulator_irq_data),
   518						GFP_KERNEL);
   519		if (!irq_ext_reg_data)
   520			return -ENOMEM;
   521	
   522		for (i = 0; i < ext_reg_irq_nb; ++i) {
   523			irq_type = &tps6594_ext_regulator_irq_types[i];
   524	
   525			irq = platform_get_irq_byname(pdev, irq_type->irq_name);
   526			if (irq < 0)
   527				return -EINVAL;
   528	
   529			irq_ext_reg_data[i].dev = tps->dev;
   530			irq_ext_reg_data[i].type = irq_type;
   531	
   532			error = devm_request_threaded_irq(tps->dev, irq, NULL,
   533							  tps6594_regulator_irq_handler,
   534							  IRQF_ONESHOT,
   535							  irq_type->irq_name,
   536							  &irq_ext_reg_data[i]);
   537			if (error) {
   538				dev_err(tps->dev, "failed to request %s IRQ %d: %d\n",
   539					irq_type->irq_name, irq, error);
   540				return error;
   541			}
   542		}
   543	
   544		return 0;
   545	}
   546	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
