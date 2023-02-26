Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E33466A338C
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 20:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjBZTFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 14:05:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjBZTFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 14:05:06 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D610C0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 11:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677438305; x=1708974305;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dFPb/YmrCXa1UzGOgyqUKWpPdEPR+OWJNAeRTsWyaq8=;
  b=IdL0B6n15fMfuqu1gBllClwNL/xKEnDU8l+4T6u3fCLvoXrSN6++JdRx
   2ZxFooljDEcaC+UIdmy2C6gSDlU9MgbyEZg8ULVvrHlKPCThsl1eLylSg
   1F67fSgecIHbj/8iCn3Ac73IOjE1+jXvo6rheft1br7hNrGaM1EUCpsHQ
   fMhIofgbHRC38uZVGUXUZ99zZib4/9NVTXA9RuLdHpLASk1mlk2+bv/4C
   cIr6XfUn96Opc6d+LcJ6otNfY78pE/tTI/ktLPiGCa1eP8w+kF78j/TrT
   /njJWgVuwogXJuQ3MwTPEgKMQKC40pFrJ6M7W6/V8V+VxpXrglprCaXm2
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10633"; a="314160419"
X-IronPort-AV: E=Sophos;i="5.97,330,1669104000"; 
   d="scan'208";a="314160419"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2023 11:05:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10633"; a="1002454462"
X-IronPort-AV: E=Sophos;i="5.97,330,1669104000"; 
   d="scan'208";a="1002454462"
Received: from lkp-server01.sh.intel.com (HELO 3895f5c55ead) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 26 Feb 2023 11:05:03 -0800
Received: from kbuild by 3895f5c55ead with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pWMKU-0003rD-2q;
        Sun, 26 Feb 2023 19:05:02 +0000
Date:   Mon, 27 Feb 2023 03:04:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>
Subject: drivers/gpio/gpio-mxc.c:341:50: warning: shift count >= width of type
Message-ID: <202302270247.exJ9xqyM-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2fcd07b7ccd5fd10b2120d298363e4e6c53ccf9c
commit: 70afdab904d2d1e68bffe75fe08e7e48e0b0ff8e irqchip: Add IMX MU MSI controller driver
date:   5 months ago
config: i386-buildonly-randconfig-r006-20230227 (https://download.01.org/0day-ci/archive/20230227/202302270247.exJ9xqyM-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=70afdab904d2d1e68bffe75fe08e7e48e0b0ff8e
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 70afdab904d2d1e68bffe75fe08e7e48e0b0ff8e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash arch/x86/kernel/ drivers/base/ drivers/gpio/ kernel/irq/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302270247.exJ9xqyM-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/gpio/gpio-mxc.c:22:
   include/linux/gpio/driver.h:31:19: error: field has incomplete type 'msi_alloc_info_t' (aka 'struct irq_alloc_info')
           msi_alloc_info_t        msiinfo;
                                   ^
   arch/x86/include/asm/msi.h:7:16: note: forward declaration of 'struct irq_alloc_info'
   typedef struct irq_alloc_info msi_alloc_info_t;
                  ^
>> drivers/gpio/gpio-mxc.c:341:50: warning: shift count >= width of type [-Wshift-count-overflow]
           rv = devm_irq_setup_generic_chip(port->dev, gc, IRQ_MSK(32),
                                                           ^~~~~~~~~~~
   include/linux/irq.h:1193:41: note: expanded from macro 'IRQ_MSK'
   #define IRQ_MSK(n) (u32)((n) < 32 ? ((1 << (n)) - 1) : UINT_MAX)
                                           ^  ~~~
   1 warning and 1 error generated.


vim +341 drivers/gpio/gpio-mxc.c

a3484ffd2acc19 arch/arm/plat-mxc/gpio.c Dinh Nguyen         2010-10-23  318  
9e26b0b114adb3 drivers/gpio/gpio-mxc.c  Peng Fan            2015-08-23  319  static int mxc_gpio_init_gc(struct mxc_gpio_port *port, int irq_base)
e4ea933363d39b drivers/gpio/gpio-mxc.c  Shawn Guo           2011-06-07  320  {
e4ea933363d39b drivers/gpio/gpio-mxc.c  Shawn Guo           2011-06-07  321  	struct irq_chip_generic *gc;
e4ea933363d39b drivers/gpio/gpio-mxc.c  Shawn Guo           2011-06-07  322  	struct irq_chip_type *ct;
db5270acaae5b6 drivers/gpio/gpio-mxc.c  Bartosz Golaszewski 2017-08-09  323  	int rv;
e4ea933363d39b drivers/gpio/gpio-mxc.c  Shawn Guo           2011-06-07  324  
db5270acaae5b6 drivers/gpio/gpio-mxc.c  Bartosz Golaszewski 2017-08-09  325  	gc = devm_irq_alloc_generic_chip(port->dev, "gpio-mxc", 1, irq_base,
e4ea933363d39b drivers/gpio/gpio-mxc.c  Shawn Guo           2011-06-07  326  					 port->base, handle_level_irq);
9e26b0b114adb3 drivers/gpio/gpio-mxc.c  Peng Fan            2015-08-23  327  	if (!gc)
9e26b0b114adb3 drivers/gpio/gpio-mxc.c  Peng Fan            2015-08-23  328  		return -ENOMEM;
e4ea933363d39b drivers/gpio/gpio-mxc.c  Shawn Guo           2011-06-07  329  	gc->private = port;
e4ea933363d39b drivers/gpio/gpio-mxc.c  Shawn Guo           2011-06-07  330  
e4ea933363d39b drivers/gpio/gpio-mxc.c  Shawn Guo           2011-06-07  331  	ct = gc->chip_types;
591567a5ea2585 drivers/gpio/gpio-mxc.c  Shawn Guo           2011-07-19  332  	ct->chip.irq_ack = irq_gc_ack_set_bit;
e4ea933363d39b drivers/gpio/gpio-mxc.c  Shawn Guo           2011-06-07  333  	ct->chip.irq_mask = irq_gc_mask_clr_bit;
e4ea933363d39b drivers/gpio/gpio-mxc.c  Shawn Guo           2011-06-07  334  	ct->chip.irq_unmask = irq_gc_mask_set_bit;
e4ea933363d39b drivers/gpio/gpio-mxc.c  Shawn Guo           2011-06-07  335  	ct->chip.irq_set_type = gpio_set_irq_type;
591567a5ea2585 drivers/gpio/gpio-mxc.c  Shawn Guo           2011-07-19  336  	ct->chip.irq_set_wake = gpio_set_wake_irq;
3093e6cca3ba7d drivers/gpio/gpio-mxc.c  Loic Poulain        2021-06-17  337  	ct->chip.flags = IRQCHIP_MASK_ON_SUSPEND | IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND;
e4ea933363d39b drivers/gpio/gpio-mxc.c  Shawn Guo           2011-06-07  338  	ct->regs.ack = GPIO_ISR;
e4ea933363d39b drivers/gpio/gpio-mxc.c  Shawn Guo           2011-06-07  339  	ct->regs.mask = GPIO_IMR;
e4ea933363d39b drivers/gpio/gpio-mxc.c  Shawn Guo           2011-06-07  340  
db5270acaae5b6 drivers/gpio/gpio-mxc.c  Bartosz Golaszewski 2017-08-09 @341  	rv = devm_irq_setup_generic_chip(port->dev, gc, IRQ_MSK(32),
db5270acaae5b6 drivers/gpio/gpio-mxc.c  Bartosz Golaszewski 2017-08-09  342  					 IRQ_GC_INIT_NESTED_LOCK,
e4ea933363d39b drivers/gpio/gpio-mxc.c  Shawn Guo           2011-06-07  343  					 IRQ_NOREQUEST, 0);
9e26b0b114adb3 drivers/gpio/gpio-mxc.c  Peng Fan            2015-08-23  344  
db5270acaae5b6 drivers/gpio/gpio-mxc.c  Bartosz Golaszewski 2017-08-09  345  	return rv;
e4ea933363d39b drivers/gpio/gpio-mxc.c  Shawn Guo           2011-06-07  346  }
b5eee2fdefc89d arch/arm/plat-mxc/gpio.c Thomas Gleixner     2011-04-04  347  

:::::: The code at line 341 was first introduced by commit
:::::: db5270acaae5b6d63ce1a6f053aeabc7a9c939bb gpio: mxc: use devres for irq generic chip

:::::: TO: Bartosz Golaszewski <brgl@bgdev.pl>
:::::: CC: Linus Walleij <linus.walleij@linaro.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
