Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3734692F1A
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 08:38:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjBKHiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 02:38:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjBKHiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 02:38:04 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F86663594;
        Fri, 10 Feb 2023 23:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676101083; x=1707637083;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gHRfT8lDxN8tG3DJrfm8yLFhweO4xTvvrJdRsmP8R9w=;
  b=i8WNWobj38ZbZceZNfEfZiQ1gVWxC+ohNxD+SDomgphjMSkp6mVc8m+Q
   ukJifLVhCBnXuQ26SWdalLkgQ4+TydfSTIXw7JXI/Bjd9UsxfEiR3cs/D
   YKjub9f0yBc0+bE3hzhloie7djtMaLON7Cd7mjk0pcKS6XSp/JvM0DEOW
   TcybZ6adVTxfTe0M0P6lh5qsUV0IZiCgfhlvUtakp5ZBzENOhxiY5NU80
   Lg1BcLfMZyevpB/3pRZckjFJOMuectY2oNaEavDgg3GQuwCxWyJJws9HI
   ZygTJRgQfwvOD9kQDIYkSZkeAOmGThK99BnCXRkevGkLEFJhhjw0caFhU
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="416817156"
X-IronPort-AV: E=Sophos;i="5.97,289,1669104000"; 
   d="scan'208";a="416817156"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 23:38:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="777196301"
X-IronPort-AV: E=Sophos;i="5.97,289,1669104000"; 
   d="scan'208";a="777196301"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 10 Feb 2023 23:38:01 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pQkSO-0006Kn-2C;
        Sat, 11 Feb 2023 07:38:00 +0000
Date:   Sat, 11 Feb 2023 15:37:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Asmaa Mnebhi <asmaa@nvidia.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, Asmaa Mnebhi <asmaa@nvidia.com>
Subject: Re: [PATCH v3 1/2] Support NVIDIA BlueField-3 GPIO controller
Message-ID: <202302111542.y6a7wZeb-lkp@intel.com>
References: <c1bf45a868edcd3df5263fa76a32b28e6c9ca3d1.1676042188.git.asmaa@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1bf45a868edcd3df5263fa76a32b28e6c9ca3d1.1676042188.git.asmaa@nvidia.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Asmaa,

I love your patch! Yet something to improve:

[auto build test ERROR on brgl/gpio/for-next]
[also build test ERROR on linusw-pinctrl/devel linusw-pinctrl/for-next linus/master v6.2-rc7 next-20230210]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Asmaa-Mnebhi/Support-NVIDIA-BlueField-3-GPIO-controller/20230210-234043
base:   https://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git gpio/for-next
patch link:    https://lore.kernel.org/r/c1bf45a868edcd3df5263fa76a32b28e6c9ca3d1.1676042188.git.asmaa%40nvidia.com
patch subject: [PATCH v3 1/2] Support NVIDIA BlueField-3 GPIO controller
config: loongarch-allmodconfig (https://download.01.org/0day-ci/archive/20230211/202302111542.y6a7wZeb-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/ea731fc5718b591e6c84ee33049e46b60882009d
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Asmaa-Mnebhi/Support-NVIDIA-BlueField-3-GPIO-controller/20230210-234043
        git checkout ea731fc5718b591e6c84ee33049e46b60882009d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=loongarch olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=loongarch SHELL=/bin/bash drivers/gpio/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302111542.y6a7wZeb-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/gpio/gpio-mlxbf3.c: In function 'mlxbf3_gpio_probe':
>> drivers/gpio/gpio-mlxbf3.c:225:23: error: implicit declaration of function 'devm_request_irq'; did you mean 'can_request_irq'? [-Werror=implicit-function-declaration]
     225 |                 ret = devm_request_irq(dev, irq, mlxbf3_gpio_irq_handler,
         |                       ^~~~~~~~~~~~~~~~
         |                       can_request_irq
>> drivers/gpio/gpio-mlxbf3.c:226:40: error: 'IRQF_SHARED' undeclared (first use in this function); did you mean 'VM_SHARED'?
     226 |                                        IRQF_SHARED, name, gs);
         |                                        ^~~~~~~~~~~
         |                                        VM_SHARED
   drivers/gpio/gpio-mlxbf3.c:226:40: note: each undeclared identifier is reported only once for each function it appears in
   cc1: some warnings being treated as errors


vim +225 drivers/gpio/gpio-mlxbf3.c

   148	
   149	static int
   150	mlxbf3_gpio_probe(struct platform_device *pdev)
   151	{
   152		struct device *dev = &pdev->dev;
   153		struct mlxbf3_gpio_context *gs;
   154		unsigned int npins, valid_mask;
   155		struct gpio_irq_chip *girq;
   156		struct gpio_chip *gc;
   157		struct resource *res;
   158		const char *name;
   159		int ret, irq;
   160	
   161		name = dev_name(dev);
   162	
   163		gs = devm_kzalloc(dev, sizeof(*gs), GFP_KERNEL);
   164		if (!gs)
   165			return -ENOMEM;
   166	
   167		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
   168		if (!res)
   169			return -ENODEV;
   170	
   171		/* Resource shared with pinctrl driver */
   172		gs->gpio_io = devm_ioremap(dev, res->start, resource_size(res));
   173		if (!gs->gpio_io)
   174			return -ENOMEM;
   175	
   176		/* YU GPIO block address */
   177		gs->gpio_cause_io = devm_platform_ioremap_resource(pdev, 1);
   178		if (IS_ERR(gs->gpio_cause_io))
   179			return PTR_ERR(gs->gpio_cause_io);
   180	
   181		if (device_property_read_u32(dev, "npins", &npins))
   182			npins = MLXBF3_GPIO_MAX_PINS_PER_BLOCK;
   183	
   184		if (device_property_read_u32(dev, "valid_mask", &valid_mask))
   185			valid_mask = 0x0;
   186	
   187		gs->valid_mask = valid_mask;
   188	
   189		gc = &gs->gc;
   190	
   191		ret = bgpio_init(gc, dev, 4,
   192				gs->gpio_io + MLXBF_GPIO_READ_DATA_IN,
   193				gs->gpio_io + MLXBF_GPIO_FW_DATA_OUT_SET,
   194				gs->gpio_io + MLXBF_GPIO_FW_DATA_OUT_CLEAR,
   195				gs->gpio_io + MLXBF_GPIO_FW_OUTPUT_ENABLE_SET,
   196				gs->gpio_io + MLXBF_GPIO_FW_OUTPUT_ENABLE_CLEAR, 0);
   197	
   198		gc->request = gpiochip_generic_request;
   199		gc->free = gpiochip_generic_free;
   200		gc->init_valid_mask = mlxbf3_gpio_init_valid_mask;
   201	
   202		gc->ngpio = npins;
   203		gc->owner = THIS_MODULE;
   204	
   205		irq = platform_get_irq(pdev, 0);
   206		if (irq >= 0) {
   207			gs->irq_chip.name = name;
   208			gs->irq_chip.irq_set_type = mlxbf3_gpio_irq_set_type;
   209			gs->irq_chip.irq_enable = mlxbf3_gpio_irq_enable;
   210			gs->irq_chip.irq_disable = mlxbf3_gpio_irq_disable;
   211	
   212			girq = &gs->gc.irq;
   213			girq->chip = &gs->irq_chip;
   214			girq->handler = handle_simple_irq;
   215			girq->default_type = IRQ_TYPE_NONE;
   216			/* This will let us handle the parent IRQ in the driver */
   217			girq->num_parents = 0;
   218			girq->parents = NULL;
   219			girq->parent_handler = NULL;
   220	
   221			/*
   222			 * Directly request the irq here instead of passing
   223			 * a flow-handler because the irq is shared.
   224			 */
 > 225			ret = devm_request_irq(dev, irq, mlxbf3_gpio_irq_handler,
 > 226					       IRQF_SHARED, name, gs);
   227			if (ret) {
   228				dev_err(dev, "failed to request IRQ");
   229				return ret;
   230			}
   231		}
   232	
   233		platform_set_drvdata(pdev, gs);
   234	
   235		ret = devm_gpiochip_add_data(dev, &gs->gc, gs);
   236		if (ret) {
   237			dev_err(dev, "Failed adding memory mapped gpiochip\n");
   238			return ret;
   239		}
   240	
   241		return 0;
   242	}
   243	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
