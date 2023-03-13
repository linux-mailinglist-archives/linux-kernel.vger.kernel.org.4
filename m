Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E02F46B80FA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 19:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbjCMSo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 14:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbjCMSoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 14:44:18 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580302748D;
        Mon, 13 Mar 2023 11:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678733024; x=1710269024;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JHNQMG+SmEvryqcuY67cCs5r39GOh8n5At5NploTfC4=;
  b=AmfHoZdVdT7pzyajBdFz8QUB0yTY1CZCGhK7BWiJSwsXlE+ON0bgK6Vq
   aG959gO4j1ROmh0U1yyNfsYieu6fNd6n5YXkG2ibW+iatjhmsxk1/kXxD
   45UUSPNXWKpDidbkZvlplYgvo2h4qPV8hoArqOjYNLNESLWYymJsxzJQG
   lEDnXWpdiHIu68LebLjYD7B8knaWurFbxFKvPrhQHqmgzaGmOnCc+KQTF
   ymztnUvmprxG1k4y+ZG1t2Xr3cYrtBh9hbv3qW+BZZtaSGDNWsTcUrzJH
   JQbQ7sK6s83D6JdTHP1+MaWtQrvdXFEicWHLiuAw1qviJC5QgmDdsccK2
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="399821603"
X-IronPort-AV: E=Sophos;i="5.98,257,1673942400"; 
   d="scan'208";a="399821603"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 11:40:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="708978883"
X-IronPort-AV: E=Sophos;i="5.98,257,1673942400"; 
   d="scan'208";a="708978883"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 13 Mar 2023 11:40:38 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pbn65-00060Q-27;
        Mon, 13 Mar 2023 18:40:37 +0000
Date:   Tue, 14 Mar 2023 02:40:00 +0800
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
Message-ID: <202303140220.FQmu9huZ-lkp@intel.com>
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

I love your patch! Yet something to improve:

[auto build test ERROR on brgl/gpio/for-next]
[also build test ERROR on linus/master v6.3-rc2 next-20230310]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/gpio-Drop-unused-inclusions-from-of_gpio-h/20230313-224656
base:   https://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git gpio/for-next
patch link:    https://lore.kernel.org/r/20230313144557.35856-1-andriy.shevchenko%40linux.intel.com
patch subject: [rft, PATCH v1 1/1] gpio: Drop unused inclusions from of_gpio.h
config: arm-randconfig-r046-20230312 (https://download.01.org/0day-ci/archive/20230314/202303140220.FQmu9huZ-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 67409911353323ca5edf2049ef0df54132fa1ca7)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/intel-lab-lkp/linux/commit/b108d11788b6db9e37a6c4b3110c09cecf30a46c
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Andy-Shevchenko/gpio-Drop-unused-inclusions-from-of_gpio-h/20230313-224656
        git checkout b108d11788b6db9e37a6c4b3110c09cecf30a46c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/video/backlight/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303140220.FQmu9huZ-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/video/backlight/hx8357.c:324:2: error: call to undeclared function 'gpio_set_value'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           gpio_set_value(lcd->reset, 1);
           ^
   drivers/video/backlight/hx8357.c:324:2: note: did you mean 'gpiod_set_value'?
   include/linux/gpio/consumer.h:122:6: note: 'gpiod_set_value' declared here
   void gpiod_set_value(struct gpio_desc *desc, int value);
        ^
>> drivers/video/backlight/hx8357.c:344:3: error: call to undeclared function 'gpio_set_value_cansleep'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                   gpio_set_value_cansleep(lcd->im_pins[0], 1);
                   ^
   drivers/video/backlight/hx8357.c:344:3: note: did you mean 'gpiod_set_value_cansleep'?
   include/linux/gpio/consumer.h:144:6: note: 'gpiod_set_value_cansleep' declared here
   void gpiod_set_value_cansleep(struct gpio_desc *desc, int value);
        ^
>> drivers/video/backlight/hx8357.c:605:7: error: call to undeclared function 'gpio_is_valid'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           if (!gpio_is_valid(lcd->reset)) {
                ^
   drivers/video/backlight/hx8357.c:605:7: note: did you mean 'uuid_is_valid'?
   include/linux/uuid.h:102:19: note: 'uuid_is_valid' declared here
   bool __must_check uuid_is_valid(const char *uuid);
                     ^
>> drivers/video/backlight/hx8357.c:610:8: error: call to undeclared function 'devm_gpio_request_one'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           ret = devm_gpio_request_one(&spi->dev, lcd->reset,
                 ^
>> drivers/video/backlight/hx8357.c:611:9: error: use of undeclared identifier 'GPIOF_OUT_INIT_HIGH'; did you mean 'GPIOD_OUT_HIGH'?
                                       GPIOF_OUT_INIT_HIGH,
                                       ^~~~~~~~~~~~~~~~~~~
                                       GPIOD_OUT_HIGH
   include/linux/gpio/consumer.h:51:2: note: 'GPIOD_OUT_HIGH' declared here
           GPIOD_OUT_HIGH  = GPIOD_FLAGS_BIT_DIR_SET | GPIOD_FLAGS_BIT_DIR_OUT |
           ^
>> drivers/video/backlight/hx8357.c:636:11: error: use of undeclared identifier 'GPIOF_OUT_INIT_LOW'; did you mean 'GPIOD_OUT_LOW'?
                                                       GPIOF_OUT_INIT_LOW,
                                                       ^~~~~~~~~~~~~~~~~~
                                                       GPIOD_OUT_LOW
   include/linux/gpio/consumer.h:50:2: note: 'GPIOD_OUT_LOW' declared here
           GPIOD_OUT_LOW   = GPIOD_FLAGS_BIT_DIR_SET | GPIOD_FLAGS_BIT_DIR_OUT,
           ^
   6 errors generated.


vim +/gpio_set_value +324 drivers/video/backlight/hx8357.c

8a6c1dd55168b5 Maxime Ripard     2013-02-21  318  
fb52566873ca8c Alexandre Belloni 2013-08-01  319  static void hx8357_lcd_reset(struct lcd_device *lcdev)
fb52566873ca8c Alexandre Belloni 2013-08-01  320  {
fb52566873ca8c Alexandre Belloni 2013-08-01  321  	struct hx8357_data *lcd = lcd_get_data(lcdev);
fb52566873ca8c Alexandre Belloni 2013-08-01  322  
fb52566873ca8c Alexandre Belloni 2013-08-01  323  	/* Reset the screen */
fb52566873ca8c Alexandre Belloni 2013-08-01 @324  	gpio_set_value(lcd->reset, 1);
fb52566873ca8c Alexandre Belloni 2013-08-01  325  	usleep_range(10000, 12000);
fb52566873ca8c Alexandre Belloni 2013-08-01  326  	gpio_set_value(lcd->reset, 0);
fb52566873ca8c Alexandre Belloni 2013-08-01  327  	usleep_range(10000, 12000);
fb52566873ca8c Alexandre Belloni 2013-08-01  328  	gpio_set_value(lcd->reset, 1);
fb52566873ca8c Alexandre Belloni 2013-08-01  329  
fb52566873ca8c Alexandre Belloni 2013-08-01  330  	/* The controller needs 120ms to recover from reset */
fb52566873ca8c Alexandre Belloni 2013-08-01  331  	msleep(120);
fb52566873ca8c Alexandre Belloni 2013-08-01  332  }
fb52566873ca8c Alexandre Belloni 2013-08-01  333  
8a6c1dd55168b5 Maxime Ripard     2013-02-21  334  static int hx8357_lcd_init(struct lcd_device *lcdev)
8a6c1dd55168b5 Maxime Ripard     2013-02-21  335  {
8a6c1dd55168b5 Maxime Ripard     2013-02-21  336  	struct hx8357_data *lcd = lcd_get_data(lcdev);
8a6c1dd55168b5 Maxime Ripard     2013-02-21  337  	int ret;
8a6c1dd55168b5 Maxime Ripard     2013-02-21  338  
8a6c1dd55168b5 Maxime Ripard     2013-02-21  339  	/*
8a6c1dd55168b5 Maxime Ripard     2013-02-21  340  	 * Set the interface selection pins to SPI mode, with three
8a6c1dd55168b5 Maxime Ripard     2013-02-21  341  	 * wires
8a6c1dd55168b5 Maxime Ripard     2013-02-21  342  	 */
ccf9901ffec4b4 Maxime Ripard     2013-08-01  343  	if (lcd->use_im_pins) {
8a6c1dd55168b5 Maxime Ripard     2013-02-21 @344  		gpio_set_value_cansleep(lcd->im_pins[0], 1);
8a6c1dd55168b5 Maxime Ripard     2013-02-21  345  		gpio_set_value_cansleep(lcd->im_pins[1], 0);
8a6c1dd55168b5 Maxime Ripard     2013-02-21  346  		gpio_set_value_cansleep(lcd->im_pins[2], 1);
ccf9901ffec4b4 Maxime Ripard     2013-08-01  347  	}
8a6c1dd55168b5 Maxime Ripard     2013-02-21  348  
8a6c1dd55168b5 Maxime Ripard     2013-02-21  349  	ret = hx8357_spi_write_array(lcdev, hx8357_seq_power,
8a6c1dd55168b5 Maxime Ripard     2013-02-21  350  				ARRAY_SIZE(hx8357_seq_power));
8a6c1dd55168b5 Maxime Ripard     2013-02-21  351  	if (ret < 0)
8a6c1dd55168b5 Maxime Ripard     2013-02-21  352  		return ret;
8a6c1dd55168b5 Maxime Ripard     2013-02-21  353  
8a6c1dd55168b5 Maxime Ripard     2013-02-21  354  	ret = hx8357_spi_write_array(lcdev, hx8357_seq_vcom,
8a6c1dd55168b5 Maxime Ripard     2013-02-21  355  				ARRAY_SIZE(hx8357_seq_vcom));
8a6c1dd55168b5 Maxime Ripard     2013-02-21  356  	if (ret < 0)
8a6c1dd55168b5 Maxime Ripard     2013-02-21  357  		return ret;
8a6c1dd55168b5 Maxime Ripard     2013-02-21  358  
8a6c1dd55168b5 Maxime Ripard     2013-02-21  359  	ret = hx8357_spi_write_array(lcdev, hx8357_seq_power_normal,
8a6c1dd55168b5 Maxime Ripard     2013-02-21  360  				ARRAY_SIZE(hx8357_seq_power_normal));
8a6c1dd55168b5 Maxime Ripard     2013-02-21  361  	if (ret < 0)
8a6c1dd55168b5 Maxime Ripard     2013-02-21  362  		return ret;
8a6c1dd55168b5 Maxime Ripard     2013-02-21  363  
8a6c1dd55168b5 Maxime Ripard     2013-02-21  364  	ret = hx8357_spi_write_array(lcdev, hx8357_seq_panel_driving,
8a6c1dd55168b5 Maxime Ripard     2013-02-21  365  				ARRAY_SIZE(hx8357_seq_panel_driving));
8a6c1dd55168b5 Maxime Ripard     2013-02-21  366  	if (ret < 0)
8a6c1dd55168b5 Maxime Ripard     2013-02-21  367  		return ret;
8a6c1dd55168b5 Maxime Ripard     2013-02-21  368  
8a6c1dd55168b5 Maxime Ripard     2013-02-21  369  	ret = hx8357_spi_write_array(lcdev, hx8357_seq_display_frame,
8a6c1dd55168b5 Maxime Ripard     2013-02-21  370  				ARRAY_SIZE(hx8357_seq_display_frame));
8a6c1dd55168b5 Maxime Ripard     2013-02-21  371  	if (ret < 0)
8a6c1dd55168b5 Maxime Ripard     2013-02-21  372  		return ret;
8a6c1dd55168b5 Maxime Ripard     2013-02-21  373  
8a6c1dd55168b5 Maxime Ripard     2013-02-21  374  	ret = hx8357_spi_write_array(lcdev, hx8357_seq_panel_related,
8a6c1dd55168b5 Maxime Ripard     2013-02-21  375  				ARRAY_SIZE(hx8357_seq_panel_related));
8a6c1dd55168b5 Maxime Ripard     2013-02-21  376  	if (ret < 0)
8a6c1dd55168b5 Maxime Ripard     2013-02-21  377  		return ret;
8a6c1dd55168b5 Maxime Ripard     2013-02-21  378  
8a6c1dd55168b5 Maxime Ripard     2013-02-21  379  	ret = hx8357_spi_write_array(lcdev, hx8357_seq_undefined1,
8a6c1dd55168b5 Maxime Ripard     2013-02-21  380  				ARRAY_SIZE(hx8357_seq_undefined1));
8a6c1dd55168b5 Maxime Ripard     2013-02-21  381  	if (ret < 0)
8a6c1dd55168b5 Maxime Ripard     2013-02-21  382  		return ret;
8a6c1dd55168b5 Maxime Ripard     2013-02-21  383  
8a6c1dd55168b5 Maxime Ripard     2013-02-21  384  	ret = hx8357_spi_write_array(lcdev, hx8357_seq_undefined2,
8a6c1dd55168b5 Maxime Ripard     2013-02-21  385  				ARRAY_SIZE(hx8357_seq_undefined2));
8a6c1dd55168b5 Maxime Ripard     2013-02-21  386  	if (ret < 0)
8a6c1dd55168b5 Maxime Ripard     2013-02-21  387  		return ret;
8a6c1dd55168b5 Maxime Ripard     2013-02-21  388  
8a6c1dd55168b5 Maxime Ripard     2013-02-21  389  	ret = hx8357_spi_write_array(lcdev, hx8357_seq_gamma,
8a6c1dd55168b5 Maxime Ripard     2013-02-21  390  				ARRAY_SIZE(hx8357_seq_gamma));
8a6c1dd55168b5 Maxime Ripard     2013-02-21  391  	if (ret < 0)
8a6c1dd55168b5 Maxime Ripard     2013-02-21  392  		return ret;
8a6c1dd55168b5 Maxime Ripard     2013-02-21  393  
8a6c1dd55168b5 Maxime Ripard     2013-02-21  394  	ret = hx8357_spi_write_array(lcdev, hx8357_seq_address_mode,
8a6c1dd55168b5 Maxime Ripard     2013-02-21  395  				ARRAY_SIZE(hx8357_seq_address_mode));
8a6c1dd55168b5 Maxime Ripard     2013-02-21  396  	if (ret < 0)
8a6c1dd55168b5 Maxime Ripard     2013-02-21  397  		return ret;
8a6c1dd55168b5 Maxime Ripard     2013-02-21  398  
8a6c1dd55168b5 Maxime Ripard     2013-02-21  399  	ret = hx8357_spi_write_array(lcdev, hx8357_seq_pixel_format,
8a6c1dd55168b5 Maxime Ripard     2013-02-21  400  				ARRAY_SIZE(hx8357_seq_pixel_format));
8a6c1dd55168b5 Maxime Ripard     2013-02-21  401  	if (ret < 0)
8a6c1dd55168b5 Maxime Ripard     2013-02-21  402  		return ret;
8a6c1dd55168b5 Maxime Ripard     2013-02-21  403  
8a6c1dd55168b5 Maxime Ripard     2013-02-21  404  	ret = hx8357_spi_write_array(lcdev, hx8357_seq_column_address,
8a6c1dd55168b5 Maxime Ripard     2013-02-21  405  				ARRAY_SIZE(hx8357_seq_column_address));
8a6c1dd55168b5 Maxime Ripard     2013-02-21  406  	if (ret < 0)
8a6c1dd55168b5 Maxime Ripard     2013-02-21  407  		return ret;
8a6c1dd55168b5 Maxime Ripard     2013-02-21  408  
8a6c1dd55168b5 Maxime Ripard     2013-02-21  409  	ret = hx8357_spi_write_array(lcdev, hx8357_seq_page_address,
8a6c1dd55168b5 Maxime Ripard     2013-02-21  410  				ARRAY_SIZE(hx8357_seq_page_address));
8a6c1dd55168b5 Maxime Ripard     2013-02-21  411  	if (ret < 0)
8a6c1dd55168b5 Maxime Ripard     2013-02-21  412  		return ret;
8a6c1dd55168b5 Maxime Ripard     2013-02-21  413  
8a6c1dd55168b5 Maxime Ripard     2013-02-21  414  	ret = hx8357_spi_write_array(lcdev, hx8357_seq_rgb,
8a6c1dd55168b5 Maxime Ripard     2013-02-21  415  				ARRAY_SIZE(hx8357_seq_rgb));
8a6c1dd55168b5 Maxime Ripard     2013-02-21  416  	if (ret < 0)
8a6c1dd55168b5 Maxime Ripard     2013-02-21  417  		return ret;
8a6c1dd55168b5 Maxime Ripard     2013-02-21  418  
8a6c1dd55168b5 Maxime Ripard     2013-02-21  419  	ret = hx8357_spi_write_array(lcdev, hx8357_seq_display_mode,
8a6c1dd55168b5 Maxime Ripard     2013-02-21  420  				ARRAY_SIZE(hx8357_seq_display_mode));
8a6c1dd55168b5 Maxime Ripard     2013-02-21  421  	if (ret < 0)
8a6c1dd55168b5 Maxime Ripard     2013-02-21  422  		return ret;
8a6c1dd55168b5 Maxime Ripard     2013-02-21  423  
8a6c1dd55168b5 Maxime Ripard     2013-02-21  424  	ret = hx8357_spi_write_byte(lcdev, HX8357_EXIT_SLEEP_MODE);
8a6c1dd55168b5 Maxime Ripard     2013-02-21  425  	if (ret < 0)
8a6c1dd55168b5 Maxime Ripard     2013-02-21  426  		return ret;
8a6c1dd55168b5 Maxime Ripard     2013-02-21  427  
fb52566873ca8c Alexandre Belloni 2013-08-01  428  	/*
fb52566873ca8c Alexandre Belloni 2013-08-01  429  	 * The controller needs 120ms to fully recover from exiting sleep mode
fb52566873ca8c Alexandre Belloni 2013-08-01  430  	 */
8a6c1dd55168b5 Maxime Ripard     2013-02-21  431  	msleep(120);
8a6c1dd55168b5 Maxime Ripard     2013-02-21  432  
8a6c1dd55168b5 Maxime Ripard     2013-02-21  433  	ret = hx8357_spi_write_byte(lcdev, HX8357_SET_DISPLAY_ON);
8a6c1dd55168b5 Maxime Ripard     2013-02-21  434  	if (ret < 0)
8a6c1dd55168b5 Maxime Ripard     2013-02-21  435  		return ret;
8a6c1dd55168b5 Maxime Ripard     2013-02-21  436  
8a6c1dd55168b5 Maxime Ripard     2013-02-21  437  	usleep_range(5000, 7000);
8a6c1dd55168b5 Maxime Ripard     2013-02-21  438  
8a6c1dd55168b5 Maxime Ripard     2013-02-21  439  	ret = hx8357_spi_write_byte(lcdev, HX8357_WRITE_MEMORY_START);
8a6c1dd55168b5 Maxime Ripard     2013-02-21  440  	if (ret < 0)
8a6c1dd55168b5 Maxime Ripard     2013-02-21  441  		return ret;
8a6c1dd55168b5 Maxime Ripard     2013-02-21  442  
8a6c1dd55168b5 Maxime Ripard     2013-02-21  443  	return 0;
8a6c1dd55168b5 Maxime Ripard     2013-02-21  444  }
8a6c1dd55168b5 Maxime Ripard     2013-02-21  445  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
