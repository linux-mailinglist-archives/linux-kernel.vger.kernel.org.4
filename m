Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6DDE6CCB3B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 22:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjC1UKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 16:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjC1UK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 16:10:29 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48BE426AA;
        Tue, 28 Mar 2023 13:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680034227; x=1711570227;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Bqz2a0tDDrO3Ug0U0rJWmNzaiLxLbO5wioAjP7cmdpo=;
  b=DSu6v0gdh26DzG+fiiUVojYQ3MbUjTrSU3TnFdTq/77GpQLrn7IDTjbD
   tAzlXqTpOJrTuYYnLoX0AkqAz4y6TWAJpgGY4U8RZEu90dJ3+Ewa/Z9ao
   Q3SUoCjeuvMXw/UpcjFh90Mqqzo3azuK/EbCSASJLI2D9HFgQgaHOrhha
   C6NiTv1GP1sF1XGe1g6C1yx+vzI48mstFlPE3C6EnpgMaGPxv21jbssRi
   rjNT/0izKC06sQB4jksZ7akRgyY5J0Nk+DlNmenwOWblvgIFZTy96ww4X
   D4jqbvrA2USTRXkptQGBOZIB8jYLzyMXj2JRHykvWIKAhlzvKNt89/ntR
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="403297734"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="403297734"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 13:10:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="858228540"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="858228540"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 28 Mar 2023 13:10:20 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1phFe7-000Is7-2a;
        Tue, 28 Mar 2023 20:10:19 +0000
Date:   Wed, 29 Mar 2023 04:09:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Esteban Blanc <eblanc@baylibre.com>, linus.walleij@linaro.org,
        lgirdwood@gmail.com, broonie@kernel.org, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-rtc@vger.kernel.org,
        jpanis@baylibre.com, jneanne@baylibre.com, sterzik@ti.com,
        u-kumar1@ti.com
Subject: Re: [PATCH v2 3/3] regulator: tps6594-regulator: Add driver for TI
 TPS6594 regulators
Message-ID: <202303290336.bSKllPZi-lkp@intel.com>
References: <20230328091448.648452-4-eblanc@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328091448.648452-4-eblanc@baylibre.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Esteban,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linusw-pinctrl/devel]
[also build test WARNING on linusw-pinctrl/for-next broonie-regulator/for-next abelloni/rtc-next linus/master v6.3-rc4 next-20230328]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Esteban-Blanc/rtc-tps6594-add-driver-for-TPS6594-PMIC-RTC/20230328-171612
base:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git devel
patch link:    https://lore.kernel.org/r/20230328091448.648452-4-eblanc%40baylibre.com
patch subject: [PATCH v2 3/3] regulator: tps6594-regulator: Add driver for TI TPS6594 regulators
config: loongarch-allyesconfig (https://download.01.org/0day-ci/archive/20230329/202303290336.bSKllPZi-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/842fe9039c5ca8c856ee7433c0dff43ee7f52cfe
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Esteban-Blanc/rtc-tps6594-add-driver-for-TPS6594-PMIC-RTC/20230328-171612
        git checkout 842fe9039c5ca8c856ee7433c0dff43ee7f52cfe
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=loongarch olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=loongarch SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303290336.bSKllPZi-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/regulator/tps6594-regulator.c: In function 'tps6594_regulator_probe':
>> drivers/regulator/tps6594-regulator.c:423:31: warning: variable 'rdevldotbl' set but not used [-Wunused-but-set-variable]
     423 |         struct regulator_dev *rdevldotbl[LDO_NB];
         |                               ^~~~~~~~~~
>> drivers/regulator/tps6594-regulator.c:422:31: warning: variable 'rdevmultitbl' set but not used [-Wunused-but-set-variable]
     422 |         struct regulator_dev *rdevmultitbl[MULTI_PHASE_NB];
         |                               ^~~~~~~~~~~~
>> drivers/regulator/tps6594-regulator.c:421:31: warning: variable 'rdevbucktbl' set but not used [-Wunused-but-set-variable]
     421 |         struct regulator_dev *rdevbucktbl[BUCK_NB];
         |                               ^~~~~~~~~~~


vim +/rdevldotbl +423 drivers/regulator/tps6594-regulator.c

   405	
   406	static int tps6594_regulator_probe(struct platform_device *pdev)
   407	{
   408		struct tps6594 *tps = dev_get_drvdata(pdev->dev.parent);
   409		struct regulator_dev *rdev;
   410		struct regulator_config config = {};
   411		u8 buck_configured[BUCK_NB] = { 0 };
   412		u8 buck_multi[MULTI_PHASE_NB] = { 0 };
   413		int i, nranges;
   414		int irq_idx = 0;
   415		int buck_idx = 0;
   416		int error, irq;
   417		int ext_reg_irq_nb = 2;
   418		struct tps6594_regulator_irq_data *irq_data;
   419		struct tps6594_ext_regulator_irq_data *irq_ext_reg_data;
   420		struct tps6594_regulator_irq_type *irq_type;
 > 421		struct regulator_dev *rdevbucktbl[BUCK_NB];
 > 422		struct regulator_dev *rdevmultitbl[MULTI_PHASE_NB];
 > 423		struct regulator_dev *rdevldotbl[LDO_NB];
   424		u32 multi_phase_id;
   425		u32 multi_phase_id_tbl[2];
   426	
   427		config.dev = tps->dev;
   428		config.driver_data = tps;
   429		config.regmap = tps->regmap;
   430	
   431		/*
   432		 * Switch case defines different possible multi phase config
   433		 * This is based on dts custom property: multi-phase-id
   434		 * Using compatible or device rev is a too complex alternative
   435		 * Default case is no Multiphase buck.
   436		 * In case of Multiphase configuration, value should be defined for
   437		 * buck_configured to avoid creating bucks for every buck in multiphase
   438		 */
   439	
   440		if (device_property_present(tps->dev, "ti,multi-phase-id")) {
   441			nranges = device_property_count_u32(tps->dev, "ti,multi-phase-id");
   442			if (nranges < 1 || nranges > 2) {
   443				dev_err(tps->dev, "%s port range: '%s' property\n",
   444					nranges == -EINVAL ? "Missing" : "Invalid",
   445					"ti,multi-phase-id");
   446				return -EINVAL;
   447			}
   448			error = device_property_read_u32_array(tps->dev, "ti,multi-phase-id",
   449							       multi_phase_id_tbl, nranges);
   450			if (error) {
   451				dev_err(tps->dev, "failed to parse '%s' property: %d\n",
   452					"ti,multi-phase-id", error);
   453				return error;
   454			}
   455			multi_phase_id = multi_phase_id_tbl[0];
   456			/* Only configuration multiphase buck12 & buck34 requires 2 arguments */
   457			if (nranges > 1 && multi_phase_id != 34)
   458				multi_phase_id = multi_phase_id_tbl[1];
   459	
   460			switch (multi_phase_id) {
   461			case 12:
   462				buck_multi[0] = 1;
   463				buck_configured[0] = 1;
   464				buck_configured[1] = 1;
   465				break;
   466			/* multiphase buck34 is supported only with buck12 */
   467			case 34:
   468				buck_multi[0] = 1;
   469				buck_configured[0] = 1;
   470				buck_configured[1] = 1;
   471				buck_multi[1] = 1;
   472				buck_configured[2] = 1;
   473				buck_configured[3] = 1;
   474				break;
   475			case 123:
   476				buck_multi[2] = 1;
   477				buck_configured[0] = 1;
   478				buck_configured[1] = 1;
   479				buck_configured[2] = 1;
   480				break;
   481			case 1234:
   482				buck_multi[3] = 1;
   483				buck_configured[0] = 1;
   484				buck_configured[1] = 1;
   485				buck_configured[2] = 1;
   486				buck_configured[3] = 1;
   487				break;
   488			}
   489		}
   490	
   491		if (tps->chip_id == LP8764X)
   492			/* There is only 4 buck on LP8764X */
   493			buck_configured[4] = 1;
   494	
   495		irq_data = devm_kmalloc(tps->dev,
   496					ARRAY_SIZE(tps6594_bucks_irq_types) *
   497					REGS_INT_NB *
   498					sizeof(struct tps6594_regulator_irq_data) +
   499					ARRAY_SIZE(tps6594_ldos_irq_types) *
   500					REGS_INT_NB *
   501					sizeof(struct tps6594_regulator_irq_data),
   502					GFP_KERNEL);
   503		if (!irq_data)
   504			return -ENOMEM;
   505	
   506		for (i = 0; i < MULTI_PHASE_NB; i++) {
   507			if (buck_multi[i] == 0)
   508				continue;
   509	
   510			rdev = devm_regulator_register(&pdev->dev, &multi_regs[i], &config);
   511			if (IS_ERR(rdev)) {
   512				dev_err(tps->dev, "failed to register %s regulator\n",
   513					pdev->name);
   514				return PTR_ERR(rdev);
   515			}
   516			rdevmultitbl[i] = rdev;
   517			/* config multiphase buck12+buck34 */
   518			if (i == 1)
   519				buck_idx = 2;
   520			error = tps6594_request_reg_irqs(pdev, rdev, irq_data,
   521							 tps6594_bucks_irq_types[buck_idx], &irq_idx);
   522			if (error)
   523				return error;
   524			error = tps6594_request_reg_irqs(pdev, rdev, irq_data,
   525							 tps6594_bucks_irq_types[buck_idx + 1], &irq_idx);
   526			if (error)
   527				return error;
   528	
   529			if (i == 2 || i == 3) {
   530				error = tps6594_request_reg_irqs(pdev, rdev, irq_data,
   531								 tps6594_bucks_irq_types[buck_idx + 2],
   532								 &irq_idx);
   533				if (error)
   534					return error;
   535			}
   536			if (i == 3) {
   537				error = tps6594_request_reg_irqs(pdev, rdev, irq_data,
   538								 tps6594_bucks_irq_types[buck_idx + 3],
   539								 &irq_idx);
   540				if (error)
   541					return error;
   542			}
   543		}
   544	
   545		for (i = 0; i < BUCK_NB; i++) {
   546			if (buck_configured[i] == 1)
   547				continue;
   548	
   549			rdev = devm_regulator_register(&pdev->dev, &buck_regs[i], &config);
   550			if (IS_ERR(rdev)) {
   551				dev_err(tps->dev, "failed to register %s regulator\n",
   552					pdev->name);
   553				return PTR_ERR(rdev);
   554			}
   555			rdevbucktbl[i] = rdev;
   556	
   557			error = tps6594_request_reg_irqs(pdev, rdev, irq_data,
   558							 tps6594_bucks_irq_types[i], &irq_idx);
   559			if (error)
   560				return error;
   561		}
   562	
   563		/* LP8764X dosen't have LDO */
   564		if (tps->chip_id != LP8764X) {
   565			for (i = 0; i < ARRAY_SIZE(ldo_regs); i++) {
   566				rdev = devm_regulator_register(&pdev->dev, &ldo_regs[i], &config);
   567				if (IS_ERR(rdev)) {
   568					dev_err(tps->dev,
   569						"failed to register %s regulator\n",
   570						pdev->name);
   571					return PTR_ERR(rdev);
   572				}
   573				rdevldotbl[i] = rdev;
   574				error = tps6594_request_reg_irqs(pdev, rdev, irq_data,
   575								 tps6594_ldos_irq_types[i],
   576								 &irq_idx);
   577				if (error)
   578					return error;
   579			}
   580		}
   581	
   582		if (tps->chip_id == LP8764X)
   583			ext_reg_irq_nb = ARRAY_SIZE(tps6594_ext_regulator_irq_types);
   584	
   585		irq_ext_reg_data = devm_kmalloc(tps->dev,
   586						ext_reg_irq_nb *
   587						sizeof(struct tps6594_ext_regulator_irq_data),
   588						GFP_KERNEL);
   589		if (!irq_ext_reg_data)
   590			return -ENOMEM;
   591	
   592		for (i = 0; i < ext_reg_irq_nb; ++i) {
   593			irq_type = &tps6594_ext_regulator_irq_types[i];
   594	
   595			irq = platform_get_irq_byname(pdev, irq_type->irq_name);
   596			if (irq < 0)
   597				return -EINVAL;
   598	
   599			irq_ext_reg_data[i].dev = tps->dev;
   600			irq_ext_reg_data[i].type = irq_type;
   601	
   602			error = devm_request_threaded_irq(tps->dev, irq, NULL,
   603							  tps6594_regulator_irq_handler,
   604							  IRQF_ONESHOT,
   605							  irq_type->irq_name,
   606							  &irq_ext_reg_data[i]);
   607			if (error) {
   608				dev_err(tps->dev, "failed to request %s IRQ %d: %d\n",
   609					irq_type->irq_name, irq, error);
   610				return error;
   611			}
   612		}
   613		return 0;
   614	}
   615	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
