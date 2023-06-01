Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23E0C71A277
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 17:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233499AbjFAPXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 11:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233018AbjFAPXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 11:23:18 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC0EB3;
        Thu,  1 Jun 2023 08:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685632986; x=1717168986;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gVvYAmz4hzU58KtAxeCJlCFJgLqSrt6q5V7koKnLAso=;
  b=SXikThb2cPAiNRfE89gvnNmRBfTw30xAg9U2VsvVayuCSD3MoWUW/MoC
   w3QmjQMfUUCPYGXJ+FLUtsp7aK6JjKMgpuzEyCpPUrtviWmvAWFQfE9qF
   kJve0KeZek+Tf4dTlMuvIUZ7plPzPHAgSkhxLJE5rvns88lBo0bWpJf42
   sxLEiZKMuT1kTlyXPKhR7r7l2pnfygrQDawdzVgqzzOVFg+pB4+pFAho3
   zrtBhFs/EBBH0gJMmyi5oisSutAouDrF4btiaFG8ZkJWOfv33dSR99FRN
   DcB5hxsPAUnSBk9pTRM8MtL+XlxeXXZMmkt2Ihi/L6YJgSKpW7ESKlkat
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="335941913"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="335941913"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 08:21:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="657836521"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="657836521"
Received: from lkp-server01.sh.intel.com (HELO fb1ced2c09fb) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 01 Jun 2023 08:21:27 -0700
Received: from kbuild by fb1ced2c09fb with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q4k7C-0002Pe-1w;
        Thu, 01 Jun 2023 15:21:26 +0000
Date:   Thu, 1 Jun 2023 23:20:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nikita Shubin <nikita.shubin@maquefel.me>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     oe-kbuild-all@lists.linux.dev,
        Michael Peters <mpeters@embeddedts.com>,
        Kris Bahnsen <kris@embeddedts.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 28/43] input: keypad: ep93xx: add DT support for
 Cirrus EP93xx
Message-ID: <202306012336.68kZBdn0-lkp@intel.com>
References: <20230601054549.10843-10-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601054549.10843-10-nikita.shubin@maquefel.me>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nikita,

kernel test robot noticed the following build errors:

[auto build test ERROR on clk/clk-next]
[also build test ERROR on linusw-pinctrl/devel linusw-pinctrl/for-next linus/master v6.4-rc4 next-20230601]
[cannot apply to soc/for-next robh/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Nikita-Shubin/dt-bindings-soc-Add-Cirrus-EP93xx/20230601-143415
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
patch link:    https://lore.kernel.org/r/20230601054549.10843-10-nikita.shubin%40maquefel.me
patch subject: [PATCH v1 28/43] input: keypad: ep93xx: add DT support for Cirrus EP93xx
config: arm-randconfig-r046-20230531 (https://download.01.org/0day-ci/archive/20230601/202306012336.68kZBdn0-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.3.0
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/79136093fef692a2db3c48c2d30e37310599131f
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Nikita-Shubin/dt-bindings-soc-Add-Cirrus-EP93xx/20230601-143415
        git checkout 79136093fef692a2db3c48c2d30e37310599131f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/input/keyboard/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306012336.68kZBdn0-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/input/keyboard/ep93xx_keypad.c: In function 'ep93xx_keypad_probe':
>> drivers/input/keyboard/ep93xx_keypad.c:262:9: error: implicit declaration of function 'of_property_read_u32' [-Werror=implicit-function-declaration]
     262 |         of_property_read_u32(np, "cirrus,debounce-delay-ms", &keypad->debounce);
         |         ^~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/of_property_read_u32 +262 drivers/input/keyboard/ep93xx_keypad.c

   233	
   234	static DEFINE_SIMPLE_DEV_PM_OPS(ep93xx_keypad_pm_ops,
   235					ep93xx_keypad_suspend, ep93xx_keypad_resume);
   236	
   237	static int ep93xx_keypad_probe(struct platform_device *pdev)
   238	{
   239		struct device_node *np = pdev->dev.of_node;
   240		struct ep93xx_keypad *keypad;
   241		struct input_dev *input_dev;
   242		int err;
   243	
   244		keypad = devm_kzalloc(&pdev->dev, sizeof(*keypad), GFP_KERNEL);
   245		if (!keypad)
   246			return -ENOMEM;
   247	
   248		keypad->irq = platform_get_irq(pdev, 0);
   249		if (keypad->irq < 0)
   250			return keypad->irq;
   251	
   252		keypad->mmio_base = devm_platform_ioremap_resource(pdev, 0);
   253		if (IS_ERR(keypad->mmio_base))
   254			return PTR_ERR(keypad->mmio_base);
   255	
   256		keypad->clk = devm_clk_get(&pdev->dev, NULL);
   257		if (IS_ERR(keypad->clk))
   258			return PTR_ERR(keypad->clk);
   259	
   260		keypad->flags = ep93xx_keypad_flags;
   261	
 > 262		of_property_read_u32(np, "cirrus,debounce-delay-ms", &keypad->debounce);
   263		of_property_read_u32(np, "cirrus,prescale", &keypad->prescale);
   264	
   265		input_dev = devm_input_allocate_device(&pdev->dev);
   266		if (!input_dev)
   267			return -ENOMEM;
   268	
   269		keypad->input_dev = input_dev;
   270	
   271		input_dev->name = pdev->name;
   272		input_dev->id.bustype = BUS_HOST;
   273		input_dev->open = ep93xx_keypad_open;
   274		input_dev->close = ep93xx_keypad_close;
   275	
   276		err = matrix_keypad_build_keymap(NULL, NULL,
   277						 EP93XX_MATRIX_ROWS, EP93XX_MATRIX_COLS,
   278						 keypad->keycodes, input_dev);
   279		if (err)
   280			return err;
   281	
   282		if (keypad->flags & EP93XX_KEYPAD_AUTOREPEAT)
   283			__set_bit(EV_REP, input_dev->evbit);
   284		input_set_drvdata(input_dev, keypad);
   285	
   286		err = devm_request_irq(&pdev->dev, keypad->irq,
   287				       ep93xx_keypad_irq_handler,
   288				       0, pdev->name, keypad);
   289		if (err)
   290			return err;
   291	
   292		err = input_register_device(input_dev);
   293		if (err)
   294			return err;
   295	
   296		platform_set_drvdata(pdev, keypad);
   297	
   298		device_init_wakeup(&pdev->dev, 1);
   299		err = dev_pm_set_wake_irq(&pdev->dev, keypad->irq);
   300		if (err)
   301			dev_warn(&pdev->dev, "failed to set up wakeup irq: %d\n", err);
   302	
   303		return 0;
   304	}
   305	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
