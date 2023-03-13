Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 198756B7FFB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 19:10:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbjCMSKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 14:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbjCMSKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 14:10:03 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D4776C68D;
        Mon, 13 Mar 2023 11:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678730980; x=1710266980;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NBGnYQ5tkOtUWP1KuktTn5IAX4FVweUOhRHoZAfA8lA=;
  b=JZ8dJC/gjl0NFcYVIgj7uSGvxC3wBA+nyQeFolrWAL6O4D2W4NdyacVx
   97QwXw+WYi55ggJqvTAzyi6cp3/8WwTmkOcMmMizTgiWl1XGYpTBILjaH
   5N5Nu8rA18FHrPsvdUMxzY6HojDFqLdNPcu3wbYvQsmUima8hmYjVHcL+
   Hjyx/Go3bTYnDRM+edTfJRQ+tLBkwL0Zi3qcMyiBtWumcOWn4qZ0Q0+8A
   EYWlKpWOGnggTONKAWgdnCo9nz0dbSIs2vrjKa81zM3TZ22LCpL4rP6pg
   EFqfW9BOGDEDjD5KhZacP3kZnzA7xEeyic60YL6V54e7Ee66zeRinLZrH
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="321075695"
X-IronPort-AV: E=Sophos;i="5.98,257,1673942400"; 
   d="scan'208";a="321075695"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 11:09:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="708970201"
X-IronPort-AV: E=Sophos;i="5.98,257,1673942400"; 
   d="scan'208";a="708970201"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 13 Mar 2023 11:09:36 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pbmc3-0005z2-2r;
        Mon, 13 Mar 2023 18:09:35 +0000
Date:   Tue, 14 Mar 2023 02:08:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [rft, PATCH v1 1/1] gpio: Drop unused inclusions from of_gpio.h
Message-ID: <202303140150.VrCOppiE-lkp@intel.com>
References: <20230313144557.35856-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230313144557.35856-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
config: arm-allyesconfig (https://download.01.org/0day-ci/archive/20230314/202303140150.VrCOppiE-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/b108d11788b6db9e37a6c4b3110c09cecf30a46c
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Andy-Shevchenko/gpio-Drop-unused-inclusions-from-of_gpio-h/20230313-224656
        git checkout b108d11788b6db9e37a6c4b3110c09cecf30a46c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/gpu/drm/sti/ drivers/net/ethernet/smsc/ drivers/net/phy/ drivers/nfc/nfcmrvl/ drivers/pci/controller/dwc/ drivers/regulator/ drivers/video/backlight/ sound/soc/codecs/ sound/soc/samsung/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303140150.VrCOppiE-lkp@intel.com/

All warnings (new ones prefixed by >>):

   sound/soc/codecs/wcd938x.c:4056:21: error: variable 'wcd_domain_ops' has initializer but incomplete type
    4056 | static const struct irq_domain_ops wcd_domain_ops = {
         |                     ^~~~~~~~~~~~~~
   sound/soc/codecs/wcd938x.c:4057:10: error: 'const struct irq_domain_ops' has no member named 'map'
    4057 |         .map = wcd_irq_chip_map,
         |          ^~~
>> sound/soc/codecs/wcd938x.c:4057:16: warning: excess elements in struct initializer
    4057 |         .map = wcd_irq_chip_map,
         |                ^~~~~~~~~~~~~~~~
   sound/soc/codecs/wcd938x.c:4057:16: note: (near initialization for 'wcd_domain_ops')
   sound/soc/codecs/wcd938x.c: In function 'wcd938x_irq_init':
   sound/soc/codecs/wcd938x.c:4063:21: error: implicit declaration of function 'irq_domain_add_linear' [-Werror=implicit-function-declaration]
    4063 |         wcd->virq = irq_domain_add_linear(NULL, 1, &wcd_domain_ops, NULL);
         |                     ^~~~~~~~~~~~~~~~~~~~~
>> sound/soc/codecs/wcd938x.c:4063:19: warning: assignment to 'struct irq_domain *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
    4063 |         wcd->virq = irq_domain_add_linear(NULL, 1, &wcd_domain_ops, NULL);
         |                   ^
   sound/soc/codecs/wcd938x.c:4070:41: error: implicit declaration of function 'irq_create_mapping' [-Werror=implicit-function-declaration]
    4070 |                                         irq_create_mapping(wcd->virq, 0),
         |                                         ^~~~~~~~~~~~~~~~~~
   sound/soc/codecs/wcd938x.c: In function 'wcd938x_reset':
   sound/soc/codecs/wcd938x.c:4288:9: error: implicit declaration of function 'gpio_direction_output'; did you mean 'gpiod_direction_output'? [-Werror=implicit-function-declaration]
    4288 |         gpio_direction_output(wcd938x->reset_gpio, 0);
         |         ^~~~~~~~~~~~~~~~~~~~~
         |         gpiod_direction_output
   sound/soc/codecs/wcd938x.c:4291:9: error: implicit declaration of function 'gpio_set_value'; did you mean 'gpiod_set_value'? [-Werror=implicit-function-declaration]
    4291 |         gpio_set_value(wcd938x->reset_gpio, 1);
         |         ^~~~~~~~~~~~~~
         |         gpiod_set_value
   sound/soc/codecs/wcd938x.c: At top level:
   sound/soc/codecs/wcd938x.c:4056:36: error: storage size of 'wcd_domain_ops' isn't known
    4056 | static const struct irq_domain_ops wcd_domain_ops = {
         |                                    ^~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   drivers/regulator/s5m8767.c: In function 's5m8767_set_high':
   drivers/regulator/s5m8767.c:274:9: error: implicit declaration of function 'gpio_set_value'; did you mean 'gpiod_set_value'? [-Werror=implicit-function-declaration]
     274 |         gpio_set_value(s5m8767->buck_gpios[0], (temp_index >> 2) & 0x1);
         |         ^~~~~~~~~~~~~~
         |         gpiod_set_value
   drivers/regulator/s5m8767.c: In function 's5m8767_pmic_dt_parse_dvs_gpio':
   drivers/regulator/s5m8767.c:493:22: error: implicit declaration of function 'gpio_is_valid'; did you mean 'uuid_is_valid'? [-Werror=implicit-function-declaration]
     493 |                 if (!gpio_is_valid(gpio)) {
         |                      ^~~~~~~~~~~~~
         |                      uuid_is_valid
   drivers/regulator/s5m8767.c: In function 's5m8767_pmic_dt_parse_pdata':
   drivers/regulator/s5m8767.c:535:25: error: implicit declaration of function 'of_get_child_by_name' [-Werror=implicit-function-declaration]
     535 |         regulators_np = of_get_child_by_name(pmic_np, "regulators");
         |                         ^~~~~~~~~~~~~~~~~~~~
>> drivers/regulator/s5m8767.c:535:23: warning: assignment to 'struct device_node *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     535 |         regulators_np = of_get_child_by_name(pmic_np, "regulators");
         |                       ^
   drivers/regulator/s5m8767.c:542:33: error: implicit declaration of function 'of_get_child_count' [-Werror=implicit-function-declaration]
     542 |         pdata->num_regulators = of_get_child_count(regulators_np);
         |                                 ^~~~~~~~~~~~~~~~~~
   drivers/regulator/s5m8767.c:548:17: error: implicit declaration of function 'of_node_put' [-Werror=implicit-function-declaration]
     548 |                 of_node_put(regulators_np);
         |                 ^~~~~~~~~~~
   drivers/regulator/s5m8767.c:562:9: error: implicit declaration of function 'for_each_child_of_node'; did you mean 'for_each_online_node'? [-Werror=implicit-function-declaration]
     562 |         for_each_child_of_node(regulators_np, reg_np) {
         |         ^~~~~~~~~~~~~~~~~~~~~~
         |         for_each_online_node
   drivers/regulator/s5m8767.c:562:54: error: expected ';' before '{' token
     562 |         for_each_child_of_node(regulators_np, reg_np) {
         |                                                      ^~
         |                                                      ;
   drivers/regulator/s5m8767.c:608:13: error: implicit declaration of function 'of_get_property' [-Werror=implicit-function-declaration]
     608 |         if (of_get_property(pmic_np, "s5m8767,pmic-buck2-uses-gpio-dvs", NULL)) {
         |             ^~~~~~~~~~~~~~~
   drivers/regulator/s5m8767.c:611:21: error: implicit declaration of function 'of_property_read_u32_array' [-Werror=implicit-function-declaration]
     611 |                 if (of_property_read_u32_array(pmic_np,
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/regulator/s5m8767.c:647:21: error: implicit declaration of function 'of_property_read_u32' [-Werror=implicit-function-declaration]
     647 |                 if (of_property_read_u32(pmic_np,
         |                     ^~~~~~~~~~~~~~~~~~~~
   drivers/regulator/s5m8767.c:527:22: warning: unused variable 'i' [-Wunused-variable]
     527 |         unsigned int i, dvs_voltage_nr = 8, ret;
         |                      ^
   drivers/regulator/s5m8767.c: In function 's5m8767_pmic_probe':
   drivers/regulator/s5m8767.c:808:23: error: implicit declaration of function 'devm_gpio_request'; did you mean 'devm_gpiod_put'? [-Werror=implicit-function-declaration]
     808 |                 ret = devm_gpio_request(&pdev->dev, pdata->buck_gpios[0],
         |                       ^~~~~~~~~~~~~~~~~
         |                       devm_gpiod_put
   drivers/regulator/s5m8767.c:824:17: error: implicit declaration of function 'gpio_direction_output'; did you mean 'gpiod_direction_output'? [-Werror=implicit-function-declaration]
     824 |                 gpio_direction_output(pdata->buck_gpios[0],
         |                 ^~~~~~~~~~~~~~~~~~~~~
         |                 gpiod_direction_output
   drivers/regulator/s5m8767.c: At top level:
   drivers/regulator/s5m8767.c:998:40: error: array type has incomplete element type 'struct platform_device_id'
     998 | static const struct platform_device_id s5m8767_pmic_id[] = {
         |                                        ^~~~~~~~~~~~~~~
   drivers/regulator/s5m8767.c:998:40: warning: 's5m8767_pmic_id' defined but not used [-Wunused-variable]
   cc1: some warnings being treated as errors
--
   drivers/net/phy/at803x.c:629:21: error: implicit declaration of function 'of_match_ptr' [-Werror=implicit-function-declaration]
     629 |         .of_match = of_match_ptr("vddio-regulator"),
         |                     ^~~~~~~~~~~~
>> drivers/net/phy/at803x.c:629:21: warning: initialization of 'const char *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
   drivers/net/phy/at803x.c:629:21: note: (near initialization for 'vddio_desc.of_match')
   drivers/net/phy/at803x.c:629:21: error: initializer element is not constant
   drivers/net/phy/at803x.c:629:21: note: (near initialization for 'vddio_desc.of_match')
   drivers/net/phy/at803x.c:642:21: warning: initialization of 'const char *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     642 |         .of_match = of_match_ptr("vddh-regulator"),
         |                     ^~~~~~~~~~~~
   drivers/net/phy/at803x.c:642:21: note: (near initialization for 'vddh_desc.of_match')
   drivers/net/phy/at803x.c:642:21: error: initializer element is not constant
   drivers/net/phy/at803x.c:642:21: note: (near initialization for 'vddh_desc.of_match')
   drivers/net/phy/at803x.c: In function 'at803x_parse_dt':
   drivers/net/phy/at803x.c:735:13: error: implicit declaration of function 'of_property_read_bool' [-Werror=implicit-function-declaration]
     735 |         if (of_property_read_bool(node, "qca,disable-smarteee"))
         |             ^~~~~~~~~~~~~~~~~~~~~
   drivers/net/phy/at803x.c:741:14: error: implicit declaration of function 'of_property_read_u32' [-Werror=implicit-function-declaration]
     741 |         if (!of_property_read_u32(node, "qca,smarteee-tw-us-1g", &tw)) {
         |              ^~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   drivers/nfc/nfcmrvl/uart.c: In function 'nfcmrvl_uart_parse_dt':
   drivers/nfc/nfcmrvl/uart.c:65:24: error: implicit declaration of function 'of_get_compatible_child' [-Werror=implicit-function-declaration]
      65 |         matched_node = of_get_compatible_child(node, "marvell,nfc-uart");
         |                        ^~~~~~~~~~~~~~~~~~~~~~~
>> drivers/nfc/nfcmrvl/uart.c:65:22: warning: assignment to 'struct device_node *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
      65 |         matched_node = of_get_compatible_child(node, "marvell,nfc-uart");
         |                      ^
   drivers/nfc/nfcmrvl/uart.c:67:30: warning: assignment to 'struct device_node *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
      67 |                 matched_node = of_get_compatible_child(node, "mrvl,nfc-uart");
         |                              ^
   drivers/nfc/nfcmrvl/uart.c:75:17: error: implicit declaration of function 'of_node_put' [-Werror=implicit-function-declaration]
      75 |                 of_node_put(matched_node);
         |                 ^~~~~~~~~~~
   drivers/nfc/nfcmrvl/uart.c:79:13: error: implicit declaration of function 'of_find_property' [-Werror=implicit-function-declaration]
      79 |         if (of_find_property(matched_node, "flow-control", NULL))
         |             ^~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   drivers/gpu/drm/sti/sti_dvo.c: In function 'sti_dvo_probe':
   drivers/gpu/drm/sti/sti_dvo.c:560:27: error: implicit declaration of function 'of_parse_phandle' [-Werror=implicit-function-declaration]
     560 |         dvo->panel_node = of_parse_phandle(np, "sti,panel", 0);
         |                           ^~~~~~~~~~~~~~~~
>> drivers/gpu/drm/sti/sti_dvo.c:560:25: warning: assignment to 'struct device_node *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     560 |         dvo->panel_node = of_parse_phandle(np, "sti,panel", 0);
         |                         ^
   drivers/gpu/drm/sti/sti_dvo.c:563:9: error: implicit declaration of function 'of_node_put' [-Werror=implicit-function-declaration]
     563 |         of_node_put(dvo->panel_node);
         |         ^~~~~~~~~~~
   drivers/gpu/drm/sti/sti_dvo.c: At top level:
   drivers/gpu/drm/sti/sti_dvo.c:576:34: error: array type has incomplete element type 'struct of_device_id'
     576 | static const struct of_device_id dvo_of_match[] = {
         |                                  ^~~~~~~~~~~~
   drivers/gpu/drm/sti/sti_dvo.c:576:34: warning: 'dvo_of_match' defined but not used [-Wunused-variable]
   cc1: some warnings being treated as errors


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
5be0e549e18f8a Dmitry Torokhov          2019-10-04  576  			of_fwnode_handle(reg_np),
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
