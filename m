Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6AD6B7F82
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 18:29:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbjCMR3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 13:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjCMR32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 13:29:28 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A212415CAF;
        Mon, 13 Mar 2023 10:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678728527; x=1710264527;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LiRcsdvUcHjSjrHumuqBshpBcS2sbw2ceIjGZzEcC9E=;
  b=nN0ZAY5rV3t9cryf12ekKapBgVRTzQH+4QGPE6osHyMMOCre8YFnPAmN
   Zw+7RAHiuHFIN9vT6+QTkf+M30spTfMM/r2ZRyrZfVLH7Q1RlFvVhUuYX
   EJS+PgPv2DEl2JzPjYCZQAOzh7ABqxY8ztH9zUr2jN3GjAzu6aP3pX6cW
   vVZPzvtZUAfm4F+rPCiQ7bhZFuqUyOB+1hChNI3I8Ltpo6G8E8Qw6wFPU
   M/38BZKK/GY54VwqVaiW0puRPZe9eZ64QIwz6lJqdxbd/QhLw+rrSAhP+
   aquNhwTRfMpfOhzGvaN2UtBT9Z4AOm5k5PeeXqtWMzwfgXXmRiK3gAPyp
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="317598104"
X-IronPort-AV: E=Sophos;i="5.98,257,1673942400"; 
   d="scan'208";a="317598104"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 10:27:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="802535313"
X-IronPort-AV: E=Sophos;i="5.98,257,1673942400"; 
   d="scan'208";a="802535313"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 13 Mar 2023 10:27:33 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pblxM-0005vl-2I;
        Mon, 13 Mar 2023 17:27:32 +0000
Date:   Tue, 14 Mar 2023 01:27:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [rft, PATCH v1 1/1] gpio: Drop unused inclusions from of_gpio.h
Message-ID: <202303140127.447rXq8p-lkp@intel.com>
References: <20230313144557.35856-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230313144557.35856-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

I love your patch! Perhaps something to improve:

[auto build test WARNING on brgl/gpio/for-next]
[also build test WARNING on linus/master v6.3-rc2 next-20230310]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/gpio-Drop-unused-inclusions-from-of_gpio-h/20230313-224656
base:   https://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git gpio/for-next
patch link:    https://lore.kernel.org/r/20230313144557.35856-1-andriy.shevchenko%40linux.intel.com
patch subject: [rft, PATCH v1 1/1] gpio: Drop unused inclusions from of_gpio.h
config: x86_64-randconfig-a016-20230313 (https://download.01.org/0day-ci/archive/20230314/202303140127.447rXq8p-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/b108d11788b6db9e37a6c4b3110c09cecf30a46c
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Andy-Shevchenko/gpio-Drop-unused-inclusions-from-of_gpio-h/20230313-224656
        git checkout b108d11788b6db9e37a6c4b3110c09cecf30a46c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/regulator/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303140127.447rXq8p-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/regulator/s5m8767.c:274:2: error: implicit declaration of function 'gpio_set_value' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           gpio_set_value(s5m8767->buck_gpios[0], (temp_index >> 2) & 0x1);
           ^
   drivers/regulator/s5m8767.c:274:2: note: did you mean 'gpiod_set_value'?
   include/linux/gpio/consumer.h:122:6: note: 'gpiod_set_value' declared here
   void gpiod_set_value(struct gpio_desc *desc, int value);
        ^
   drivers/regulator/s5m8767.c:285:2: error: implicit declaration of function 'gpio_set_value' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           gpio_set_value(s5m8767->buck_gpios[2], temp_index & 0x1);
           ^
   drivers/regulator/s5m8767.c:493:8: error: implicit declaration of function 'gpio_is_valid' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                   if (!gpio_is_valid(gpio)) {
                        ^
   drivers/regulator/s5m8767.c:493:8: note: did you mean 'uuid_is_valid'?
   include/linux/uuid.h:102:19: note: 'uuid_is_valid' declared here
   bool __must_check uuid_is_valid(const char *uuid);
                     ^
   drivers/regulator/s5m8767.c:511:8: error: implicit declaration of function 'gpio_is_valid' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                   if (!gpio_is_valid(gpio)) {
                        ^
   drivers/regulator/s5m8767.c:535:18: error: implicit declaration of function 'of_get_child_by_name' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           regulators_np = of_get_child_by_name(pmic_np, "regulators");
                           ^
>> drivers/regulator/s5m8767.c:535:16: warning: incompatible integer to pointer conversion assigning to 'struct device_node *' from 'int' [-Wint-conversion]
           regulators_np = of_get_child_by_name(pmic_np, "regulators");
                         ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/regulator/s5m8767.c:542:26: error: implicit declaration of function 'of_get_child_count' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           pdata->num_regulators = of_get_child_count(regulators_np);
                                   ^
   drivers/regulator/s5m8767.c:542:26: note: did you mean 'of_get_child_by_name'?
   drivers/regulator/s5m8767.c:535:18: note: 'of_get_child_by_name' declared here
           regulators_np = of_get_child_by_name(pmic_np, "regulators");
                           ^
   drivers/regulator/s5m8767.c:548:3: error: implicit declaration of function 'of_node_put' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                   of_node_put(regulators_np);
                   ^
   drivers/regulator/s5m8767.c:556:3: error: implicit declaration of function 'of_node_put' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                   of_node_put(regulators_np);
                   ^
   drivers/regulator/s5m8767.c:562:2: error: implicit declaration of function 'for_each_child_of_node' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           for_each_child_of_node(regulators_np, reg_np) {
           ^
   drivers/regulator/s5m8767.c:562:47: error: expected ';' after expression
           for_each_child_of_node(regulators_np, reg_np) {
                                                        ^
                                                        ;
   drivers/regulator/s5m8767.c:564:8: error: implicit declaration of function 'of_node_name_eq' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                           if (of_node_name_eq(reg_np, regulators[i].name))
                               ^
   drivers/regulator/s5m8767.c:571:4: error: 'continue' statement not in loop statement
                           continue;
                           ^
   drivers/regulator/s5m8767.c:576:4: error: implicit declaration of function 'of_fwnode_handle' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                           of_fwnode_handle(reg_np),
                           ^
>> drivers/regulator/s5m8767.c:576:4: warning: incompatible integer to pointer conversion passing 'int' to parameter of type 'struct fwnode_handle *' [-Wint-conversion]
                           of_fwnode_handle(reg_np),
                           ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/gpio/consumer.h:573:28: note: passing argument to parameter 'fwnode' here
                                           struct fwnode_handle *fwnode,
                                                                 ^
   drivers/regulator/s5m8767.c:583:4: error: implicit declaration of function 'of_node_put' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                           of_node_put(reg_np);
                           ^
   drivers/regulator/s5m8767.c:595:7: error: implicit declaration of function 'of_property_read_u32' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                   if (of_property_read_u32(reg_np, "op_mode",
                       ^
   drivers/regulator/s5m8767.c:606:2: error: implicit declaration of function 'of_node_put' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           of_node_put(regulators_np);
           ^
   drivers/regulator/s5m8767.c:608:6: error: implicit declaration of function 'of_get_property' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           if (of_get_property(pmic_np, "s5m8767,pmic-buck2-uses-gpio-dvs", NULL)) {
               ^
   drivers/regulator/s5m8767.c:611:7: error: implicit declaration of function 'of_property_read_u32_array' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                   if (of_property_read_u32_array(pmic_np,
                       ^
   drivers/regulator/s5m8767.c:622:7: error: implicit declaration of function 'of_property_read_u32_array' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                   if (of_property_read_u32_array(pmic_np,
                       ^
   fatal error: too many errors emitted, stopping now [-ferror-limit=]
   2 warnings and 20 errors generated.


vim +535 drivers/regulator/s5m8767.c

26aec009f6b61c Amit Daniel Kachhap      2013-02-03  519  
cbb0ed495ca165 Axel Lin                 2013-02-13  520  static int s5m8767_pmic_dt_parse_pdata(struct platform_device *pdev,
26aec009f6b61c Amit Daniel Kachhap      2013-02-03  521  					struct sec_platform_data *pdata)
26aec009f6b61c Amit Daniel Kachhap      2013-02-03  522  {
cbb0ed495ca165 Axel Lin                 2013-02-13  523  	struct sec_pmic_dev *iodev = dev_get_drvdata(pdev->dev.parent);
26aec009f6b61c Amit Daniel Kachhap      2013-02-03  524  	struct device_node *pmic_np, *regulators_np, *reg_np;
26aec009f6b61c Amit Daniel Kachhap      2013-02-03  525  	struct sec_regulator_data *rdata;
26aec009f6b61c Amit Daniel Kachhap      2013-02-03  526  	struct sec_opmode_data *rmode;
04f9f068a619cc Chanwoo Choi             2013-10-10  527  	unsigned int i, dvs_voltage_nr = 8, ret;
26aec009f6b61c Amit Daniel Kachhap      2013-02-03  528  
26aec009f6b61c Amit Daniel Kachhap      2013-02-03  529  	pmic_np = iodev->dev->of_node;
26aec009f6b61c Amit Daniel Kachhap      2013-02-03  530  	if (!pmic_np) {
26aec009f6b61c Amit Daniel Kachhap      2013-02-03  531  		dev_err(iodev->dev, "could not find pmic sub-node\n");
26aec009f6b61c Amit Daniel Kachhap      2013-02-03  532  		return -ENODEV;
26aec009f6b61c Amit Daniel Kachhap      2013-02-03  533  	}
26aec009f6b61c Amit Daniel Kachhap      2013-02-03  534  
4e52c03dfcdef5 Sachin Kamat             2014-02-13 @535  	regulators_np = of_get_child_by_name(pmic_np, "regulators");
26aec009f6b61c Amit Daniel Kachhap      2013-02-03  536  	if (!regulators_np) {
26aec009f6b61c Amit Daniel Kachhap      2013-02-03  537  		dev_err(iodev->dev, "could not find regulators sub-node\n");
26aec009f6b61c Amit Daniel Kachhap      2013-02-03  538  		return -EINVAL;
26aec009f6b61c Amit Daniel Kachhap      2013-02-03  539  	}
26aec009f6b61c Amit Daniel Kachhap      2013-02-03  540  
26aec009f6b61c Amit Daniel Kachhap      2013-02-03  541  	/* count the number of regulators to be supported in pmic */
1f91b6f6c747d3 Axel Lin                 2013-02-06  542  	pdata->num_regulators = of_get_child_count(regulators_np);
26aec009f6b61c Amit Daniel Kachhap      2013-02-03  543  
a86854d0c599b3 Kees Cook                2018-06-12  544  	rdata = devm_kcalloc(&pdev->dev,
a86854d0c599b3 Kees Cook                2018-06-12  545  			     pdata->num_regulators, sizeof(*rdata),
a86854d0c599b3 Kees Cook                2018-06-12  546  			     GFP_KERNEL);
a5872bd3398d0f Krzysztof Kozlowski      2021-01-21  547  	if (!rdata) {
a5872bd3398d0f Krzysztof Kozlowski      2021-01-21  548  		of_node_put(regulators_np);
26aec009f6b61c Amit Daniel Kachhap      2013-02-03  549  		return -ENOMEM;
a5872bd3398d0f Krzysztof Kozlowski      2021-01-21  550  	}
26aec009f6b61c Amit Daniel Kachhap      2013-02-03  551  
a86854d0c599b3 Kees Cook                2018-06-12  552  	rmode = devm_kcalloc(&pdev->dev,
a86854d0c599b3 Kees Cook                2018-06-12  553  			     pdata->num_regulators, sizeof(*rmode),
a86854d0c599b3 Kees Cook                2018-06-12  554  			     GFP_KERNEL);
a5872bd3398d0f Krzysztof Kozlowski      2021-01-21  555  	if (!rmode) {
a5872bd3398d0f Krzysztof Kozlowski      2021-01-21  556  		of_node_put(regulators_np);
26aec009f6b61c Amit Daniel Kachhap      2013-02-03  557  		return -ENOMEM;
a5872bd3398d0f Krzysztof Kozlowski      2021-01-21  558  	}
26aec009f6b61c Amit Daniel Kachhap      2013-02-03  559  
26aec009f6b61c Amit Daniel Kachhap      2013-02-03  560  	pdata->regulators = rdata;
26aec009f6b61c Amit Daniel Kachhap      2013-02-03  561  	pdata->opmode = rmode;
26aec009f6b61c Amit Daniel Kachhap      2013-02-03  562  	for_each_child_of_node(regulators_np, reg_np) {
26aec009f6b61c Amit Daniel Kachhap      2013-02-03  563  		for (i = 0; i < ARRAY_SIZE(regulators); i++)
c32569e358adea Rob Herring              2018-12-05  564  			if (of_node_name_eq(reg_np, regulators[i].name))
26aec009f6b61c Amit Daniel Kachhap      2013-02-03  565  				break;
26aec009f6b61c Amit Daniel Kachhap      2013-02-03  566  
26aec009f6b61c Amit Daniel Kachhap      2013-02-03  567  		if (i == ARRAY_SIZE(regulators)) {
26aec009f6b61c Amit Daniel Kachhap      2013-02-03  568  			dev_warn(iodev->dev,
0c9721a5d1dea7 Rob Herring              2018-08-27  569  			"don't know how to configure regulator %pOFn\n",
0c9721a5d1dea7 Rob Herring              2018-08-27  570  			reg_np);
26aec009f6b61c Amit Daniel Kachhap      2013-02-03  571  			continue;
26aec009f6b61c Amit Daniel Kachhap      2013-02-03  572  		}
26aec009f6b61c Amit Daniel Kachhap      2013-02-03  573  
5be0e549e18f8a Dmitry Torokhov          2019-10-04  574  		rdata->ext_control_gpiod = devm_fwnode_gpiod_get(
63239e4bf7eff3 Linus Walleij            2018-10-15  575  			&pdev->dev,
5be0e549e18f8a Dmitry Torokhov          2019-10-04 @576  			of_fwnode_handle(reg_np),
5be0e549e18f8a Dmitry Torokhov          2019-10-04  577  			"s5m8767,pmic-ext-control",
63239e4bf7eff3 Linus Walleij            2018-10-15  578  			GPIOD_OUT_HIGH | GPIOD_FLAGS_BIT_NONEXCLUSIVE,
9ae5cc75ceaacf Linus Walleij            2018-05-14  579  			"s5m8767");
dea6dd2ba63f8c Pan Bian                 2021-01-20  580  		if (PTR_ERR(rdata->ext_control_gpiod) == -ENOENT) {
025bf37725f192 Waibel Georg             2019-06-20  581  			rdata->ext_control_gpiod = NULL;
dea6dd2ba63f8c Pan Bian                 2021-01-20  582  		} else if (IS_ERR(rdata->ext_control_gpiod)) {
dea6dd2ba63f8c Pan Bian                 2021-01-20  583  			of_node_put(reg_np);
dea6dd2ba63f8c Pan Bian                 2021-01-20  584  			of_node_put(regulators_np);
9ae5cc75ceaacf Linus Walleij            2018-05-14  585  			return PTR_ERR(rdata->ext_control_gpiod);
dea6dd2ba63f8c Pan Bian                 2021-01-20  586  		}
ee1e0994ab1bd3 Krzysztof Kozlowski      2014-01-24  587  
26aec009f6b61c Amit Daniel Kachhap      2013-02-03  588  		rdata->id = i;
26aec009f6b61c Amit Daniel Kachhap      2013-02-03  589  		rdata->initdata = of_get_regulator_init_data(
072e78b12bf518 Javier Martinez Canillas 2014-11-10  590  						&pdev->dev, reg_np,
072e78b12bf518 Javier Martinez Canillas 2014-11-10  591  						&regulators[i]);
26aec009f6b61c Amit Daniel Kachhap      2013-02-03  592  		rdata->reg_node = reg_np;
26aec009f6b61c Amit Daniel Kachhap      2013-02-03  593  		rdata++;
26aec009f6b61c Amit Daniel Kachhap      2013-02-03  594  		rmode->id = i;
26aec009f6b61c Amit Daniel Kachhap      2013-02-03  595  		if (of_property_read_u32(reg_np, "op_mode",
26aec009f6b61c Amit Daniel Kachhap      2013-02-03  596  				&rmode->mode)) {
26aec009f6b61c Amit Daniel Kachhap      2013-02-03  597  			dev_warn(iodev->dev,
f3c7f7b636ef50 Christophe JAILLET       2019-12-03  598  				"no op_mode property at %pOF\n",
7799167b7a14fe Rob Herring              2017-07-18  599  				reg_np);
26aec009f6b61c Amit Daniel Kachhap      2013-02-03  600  
26aec009f6b61c Amit Daniel Kachhap      2013-02-03  601  			rmode->mode = S5M8767_OPMODE_NORMAL_MODE;
26aec009f6b61c Amit Daniel Kachhap      2013-02-03  602  		}
26aec009f6b61c Amit Daniel Kachhap      2013-02-03  603  		rmode++;
26aec009f6b61c Amit Daniel Kachhap      2013-02-03  604  	}
26aec009f6b61c Amit Daniel Kachhap      2013-02-03  605  
b7db01f3b3b86f Sachin Kamat             2014-02-13  606  	of_node_put(regulators_np);
b7db01f3b3b86f Sachin Kamat             2014-02-13  607  
04f9f068a619cc Chanwoo Choi             2013-10-10  608  	if (of_get_property(pmic_np, "s5m8767,pmic-buck2-uses-gpio-dvs", NULL)) {
26aec009f6b61c Amit Daniel Kachhap      2013-02-03  609  		pdata->buck2_gpiodvs = true;
26aec009f6b61c Amit Daniel Kachhap      2013-02-03  610  
04f9f068a619cc Chanwoo Choi             2013-10-10  611  		if (of_property_read_u32_array(pmic_np,
04f9f068a619cc Chanwoo Choi             2013-10-10  612  				"s5m8767,pmic-buck2-dvs-voltage",
04f9f068a619cc Chanwoo Choi             2013-10-10  613  				pdata->buck2_voltage, dvs_voltage_nr)) {
04f9f068a619cc Chanwoo Choi             2013-10-10  614  			dev_err(iodev->dev, "buck2 voltages not specified\n");
04f9f068a619cc Chanwoo Choi             2013-10-10  615  			return -EINVAL;
04f9f068a619cc Chanwoo Choi             2013-10-10  616  		}
04f9f068a619cc Chanwoo Choi             2013-10-10  617  	}
04f9f068a619cc Chanwoo Choi             2013-10-10  618  
04f9f068a619cc Chanwoo Choi             2013-10-10  619  	if (of_get_property(pmic_np, "s5m8767,pmic-buck3-uses-gpio-dvs", NULL)) {
26aec009f6b61c Amit Daniel Kachhap      2013-02-03  620  		pdata->buck3_gpiodvs = true;
26aec009f6b61c Amit Daniel Kachhap      2013-02-03  621  
04f9f068a619cc Chanwoo Choi             2013-10-10  622  		if (of_property_read_u32_array(pmic_np,
04f9f068a619cc Chanwoo Choi             2013-10-10  623  				"s5m8767,pmic-buck3-dvs-voltage",
04f9f068a619cc Chanwoo Choi             2013-10-10  624  				pdata->buck3_voltage, dvs_voltage_nr)) {
04f9f068a619cc Chanwoo Choi             2013-10-10  625  			dev_err(iodev->dev, "buck3 voltages not specified\n");
04f9f068a619cc Chanwoo Choi             2013-10-10  626  			return -EINVAL;
04f9f068a619cc Chanwoo Choi             2013-10-10  627  		}
04f9f068a619cc Chanwoo Choi             2013-10-10  628  	}
04f9f068a619cc Chanwoo Choi             2013-10-10  629  
04f9f068a619cc Chanwoo Choi             2013-10-10  630  	if (of_get_property(pmic_np, "s5m8767,pmic-buck4-uses-gpio-dvs", NULL)) {
26aec009f6b61c Amit Daniel Kachhap      2013-02-03  631  		pdata->buck4_gpiodvs = true;
26aec009f6b61c Amit Daniel Kachhap      2013-02-03  632  
04f9f068a619cc Chanwoo Choi             2013-10-10  633  		if (of_property_read_u32_array(pmic_np,
04f9f068a619cc Chanwoo Choi             2013-10-10  634  				"s5m8767,pmic-buck4-dvs-voltage",
04f9f068a619cc Chanwoo Choi             2013-10-10  635  				pdata->buck4_voltage, dvs_voltage_nr)) {
04f9f068a619cc Chanwoo Choi             2013-10-10  636  			dev_err(iodev->dev, "buck4 voltages not specified\n");
04f9f068a619cc Chanwoo Choi             2013-10-10  637  			return -EINVAL;
04f9f068a619cc Chanwoo Choi             2013-10-10  638  		}
04f9f068a619cc Chanwoo Choi             2013-10-10  639  	}
04f9f068a619cc Chanwoo Choi             2013-10-10  640  
26aec009f6b61c Amit Daniel Kachhap      2013-02-03  641  	if (pdata->buck2_gpiodvs || pdata->buck3_gpiodvs ||
26aec009f6b61c Amit Daniel Kachhap      2013-02-03  642  						pdata->buck4_gpiodvs) {
26aec009f6b61c Amit Daniel Kachhap      2013-02-03  643  		ret = s5m8767_pmic_dt_parse_dvs_gpio(iodev, pdata, pmic_np);
26aec009f6b61c Amit Daniel Kachhap      2013-02-03  644  		if (ret)
26aec009f6b61c Amit Daniel Kachhap      2013-02-03  645  			return -EINVAL;
26aec009f6b61c Amit Daniel Kachhap      2013-02-03  646  
26aec009f6b61c Amit Daniel Kachhap      2013-02-03  647  		if (of_property_read_u32(pmic_np,
26aec009f6b61c Amit Daniel Kachhap      2013-02-03  648  				"s5m8767,pmic-buck-default-dvs-idx",
26aec009f6b61c Amit Daniel Kachhap      2013-02-03  649  				&pdata->buck_default_idx)) {
26aec009f6b61c Amit Daniel Kachhap      2013-02-03  650  			pdata->buck_default_idx = 0;
26aec009f6b61c Amit Daniel Kachhap      2013-02-03  651  		} else {
26aec009f6b61c Amit Daniel Kachhap      2013-02-03  652  			if (pdata->buck_default_idx >= 8) {
26aec009f6b61c Amit Daniel Kachhap      2013-02-03  653  				pdata->buck_default_idx = 0;
26aec009f6b61c Amit Daniel Kachhap      2013-02-03  654  				dev_info(iodev->dev,
26aec009f6b61c Amit Daniel Kachhap      2013-02-03  655  				"invalid value for default dvs index, use 0\n");
26aec009f6b61c Amit Daniel Kachhap      2013-02-03  656  			}
26aec009f6b61c Amit Daniel Kachhap      2013-02-03  657  		}
26aec009f6b61c Amit Daniel Kachhap      2013-02-03  658  	}
26aec009f6b61c Amit Daniel Kachhap      2013-02-03  659  
26aec009f6b61c Amit Daniel Kachhap      2013-02-03  660  	ret = s5m8767_pmic_dt_parse_ds_gpio(iodev, pdata, pmic_np);
26aec009f6b61c Amit Daniel Kachhap      2013-02-03  661  	if (ret)
26aec009f6b61c Amit Daniel Kachhap      2013-02-03  662  		return -EINVAL;
26aec009f6b61c Amit Daniel Kachhap      2013-02-03  663  
033054e8603036 Chanwoo Choi             2013-10-10  664  	if (of_get_property(pmic_np, "s5m8767,pmic-buck2-ramp-enable", NULL))
033054e8603036 Chanwoo Choi             2013-10-10  665  		pdata->buck2_ramp_enable = true;
26aec009f6b61c Amit Daniel Kachhap      2013-02-03  666  
033054e8603036 Chanwoo Choi             2013-10-10  667  	if (of_get_property(pmic_np, "s5m8767,pmic-buck3-ramp-enable", NULL))
033054e8603036 Chanwoo Choi             2013-10-10  668  		pdata->buck3_ramp_enable = true;
26aec009f6b61c Amit Daniel Kachhap      2013-02-03  669  
033054e8603036 Chanwoo Choi             2013-10-10  670  	if (of_get_property(pmic_np, "s5m8767,pmic-buck4-ramp-enable", NULL))
033054e8603036 Chanwoo Choi             2013-10-10  671  		pdata->buck4_ramp_enable = true;
033054e8603036 Chanwoo Choi             2013-10-10  672  
033054e8603036 Chanwoo Choi             2013-10-10  673  	if (pdata->buck2_ramp_enable || pdata->buck3_ramp_enable
033054e8603036 Chanwoo Choi             2013-10-10  674  			|| pdata->buck4_ramp_enable) {
033054e8603036 Chanwoo Choi             2013-10-10  675  		if (of_property_read_u32(pmic_np, "s5m8767,pmic-buck-ramp-delay",
033054e8603036 Chanwoo Choi             2013-10-10  676  				&pdata->buck_ramp_delay))
033054e8603036 Chanwoo Choi             2013-10-10  677  			pdata->buck_ramp_delay = 0;
26aec009f6b61c Amit Daniel Kachhap      2013-02-03  678  	}
26aec009f6b61c Amit Daniel Kachhap      2013-02-03  679  
26aec009f6b61c Amit Daniel Kachhap      2013-02-03  680  	return 0;
26aec009f6b61c Amit Daniel Kachhap      2013-02-03  681  }
26aec009f6b61c Amit Daniel Kachhap      2013-02-03  682  #else
cbb0ed495ca165 Axel Lin                 2013-02-13  683  static int s5m8767_pmic_dt_parse_pdata(struct platform_device *pdev,
26aec009f6b61c Amit Daniel Kachhap      2013-02-03  684  					struct sec_platform_data *pdata)
26aec009f6b61c Amit Daniel Kachhap      2013-02-03  685  {
26aec009f6b61c Amit Daniel Kachhap      2013-02-03  686  	return 0;
26aec009f6b61c Amit Daniel Kachhap      2013-02-03  687  }
26aec009f6b61c Amit Daniel Kachhap      2013-02-03  688  #endif /* CONFIG_OF */
26aec009f6b61c Amit Daniel Kachhap      2013-02-03  689  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
