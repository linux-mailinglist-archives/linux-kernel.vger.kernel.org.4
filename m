Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF41C6B1A8C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 06:02:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjCIFCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 00:02:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjCIFCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 00:02:17 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2390BD514F
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 21:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678338135; x=1709874135;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=GT2cc1kUiLRNcQF/6/hFTE3EgaKK8agFVhCOMI9p8sM=;
  b=FrS4Y87IeptnpWVWMk+3Y8qLWXXcgyw3xGAkanXxIkfpmt9BalIBR0Mq
   yS+aLOd593XTrK7sswPjMi8SYGTIVt2dYHQQCagBUIuMSMKP5QNGoKkwd
   UtW5eUXrO/3j0c7vyiZ8wpUGMvkpg2YPWDx7BADunEzwCnKKSsO2Lm1KK
   iEcP15MsDWb/mdlm0mShf4XesvIZN6b9rZ2SYvYvPM004V6pBsKSeo0gO
   BrJCr0qkVLCzERXuPPsxSgsPGUvQ6jr7f8F5g3pVjVaJA1A1uxwzJ9xnI
   BbRYDVivZK75EnzscBRfvd56mgPfOK/LlGjOQl+UCrMJ3N2mV80TPXqk8
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="401189418"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="401189418"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 21:02:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="820473698"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="820473698"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 08 Mar 2023 21:02:11 -0800
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pa8Pq-0002ev-11;
        Thu, 09 Mar 2023 05:02:10 +0000
Date:   Thu, 9 Mar 2023 13:01:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: arch/arm/mach-imx/pm-imx5.c:244:17: sparse: sparse: restricted
 suspend_state_t degrades to integer
Message-ID: <202303091256.uTPXyvY5-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6a98c9cae232800c319ed69e1063480d31430887
commit: 09f6b27d5ddd9ad0ec096d1b0f8decdacc70f0f8 ARM: dove: multiplatform support
date:   11 months ago
config: arm-randconfig-s053-20230308 (https://download.01.org/0day-ci/archive/20230309/202303091256.uTPXyvY5-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=09f6b27d5ddd9ad0ec096d1b0f8decdacc70f0f8
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 09f6b27d5ddd9ad0ec096d1b0f8decdacc70f0f8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm SHELL=/bin/bash arch/arm/mach-imx/ arch/arm/mach-shmobile/ drivers/irqchip/ drivers/soc/bcm/brcmstb/pm/ drivers/video/fbdev/ drivers/w1/masters/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303091256.uTPXyvY5-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> arch/arm/mach-imx/pm-imx5.c:244:17: sparse: sparse: restricted suspend_state_t degrades to integer
   arch/arm/mach-imx/pm-imx5.c:244:25: sparse: sparse: restricted suspend_state_t degrades to integer
   arch/arm/mach-imx/pm-imx5.c:244:42: sparse: sparse: restricted suspend_state_t degrades to integer
   arch/arm/mach-imx/pm-imx5.c:244:51: sparse: sparse: restricted suspend_state_t degrades to integer
>> arch/arm/mach-imx/pm-imx5.c:342:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct imx5_cpu_suspend_info *suspend_info @@     got void [noderef] __iomem *static [addressable] [toplevel] suspend_ocram_base @@
   arch/arm/mach-imx/pm-imx5.c:342:22: sparse:     expected struct imx5_cpu_suspend_info *suspend_info
   arch/arm/mach-imx/pm-imx5.c:342:22: sparse:     got void [noderef] __iomem *static [addressable] [toplevel] suspend_ocram_base
>> arch/arm/mach-imx/pm-imx5.c:360:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem * @@
   arch/arm/mach-imx/pm-imx5.c:360:36: sparse:     expected void const *
   arch/arm/mach-imx/pm-imx5.c:360:36: sparse:     got void [noderef] __iomem *
>> arch/arm/mach-imx/pm-imx5.c:360:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem * @@
   arch/arm/mach-imx/pm-imx5.c:360:36: sparse:     expected void const *
   arch/arm/mach-imx/pm-imx5.c:360:36: sparse:     got void [noderef] __iomem *
>> arch/arm/mach-imx/pm-imx5.c:360:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
   arch/arm/mach-imx/pm-imx5.c:360:36: sparse:     expected void *
   arch/arm/mach-imx/pm-imx5.c:360:36: sparse:     got void [noderef] __iomem *
--
>> arch/arm/mach-imx/pm-imx6.c:373:24: sparse: sparse: cast removes address space '__iomem' of expression
>> arch/arm/mach-imx/pm-imx6.c:513:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *static [assigned] [toplevel] suspend_ocram_base @@
   arch/arm/mach-imx/pm-imx6.c:513:9: sparse:     expected void const *
   arch/arm/mach-imx/pm-imx6.c:513:9: sparse:     got void [noderef] __iomem *static [assigned] [toplevel] suspend_ocram_base
>> arch/arm/mach-imx/pm-imx6.c:513:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *static [assigned] [toplevel] suspend_ocram_base @@
   arch/arm/mach-imx/pm-imx6.c:513:9: sparse:     expected void const *
   arch/arm/mach-imx/pm-imx6.c:513:9: sparse:     got void [noderef] __iomem *static [assigned] [toplevel] suspend_ocram_base
>> arch/arm/mach-imx/pm-imx6.c:513:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got void [noderef] __iomem *static [assigned] [toplevel] suspend_ocram_base @@
   arch/arm/mach-imx/pm-imx6.c:513:9: sparse:     expected void *
   arch/arm/mach-imx/pm-imx6.c:513:9: sparse:     got void [noderef] __iomem *static [assigned] [toplevel] suspend_ocram_base
>> arch/arm/mach-imx/pm-imx6.c:514:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct imx6_cpu_pm_info *pm_info @@     got void [noderef] __iomem *static [assigned] [toplevel] suspend_ocram_base @@
   arch/arm/mach-imx/pm-imx6.c:514:17: sparse:     expected struct imx6_cpu_pm_info *pm_info
   arch/arm/mach-imx/pm-imx6.c:514:17: sparse:     got void [noderef] __iomem *static [assigned] [toplevel] suspend_ocram_base
>> arch/arm/mach-imx/pm-imx6.c:570:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem * @@
   arch/arm/mach-imx/pm-imx6.c:570:36: sparse:     expected void const *
   arch/arm/mach-imx/pm-imx6.c:570:36: sparse:     got void [noderef] __iomem *
>> arch/arm/mach-imx/pm-imx6.c:570:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem * @@
   arch/arm/mach-imx/pm-imx6.c:570:36: sparse:     expected void const *
   arch/arm/mach-imx/pm-imx6.c:570:36: sparse:     got void [noderef] __iomem *
>> arch/arm/mach-imx/pm-imx6.c:570:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
   arch/arm/mach-imx/pm-imx6.c:570:36: sparse:     expected void *
   arch/arm/mach-imx/pm-imx6.c:570:36: sparse:     got void [noderef] __iomem *
--
>> drivers/irqchip/irq-rda-intc.c:96:51: sparse: sparse: incorrect type in argument 4 (different address spaces) @@     expected void *host_data @@     got void [noderef] __iomem *static [assigned] [toplevel] rda_intc_base @@
   drivers/irqchip/irq-rda-intc.c:96:51: sparse:     expected void *host_data
   drivers/irqchip/irq-rda-intc.c:96:51: sparse:     got void [noderef] __iomem *static [assigned] [toplevel] rda_intc_base
--
>> drivers/irqchip/irq-vic.c:193:33: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void *data @@     got void [noderef] __iomem *base @@
   drivers/irqchip/irq-vic.c:193:33: sparse:     expected void *data
   drivers/irqchip/irq-vic.c:193:33: sparse:     got void [noderef] __iomem *base
>> drivers/irqchip/irq-vic.c:308:56: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void [noderef] __iomem *base @@     got void * @@
   drivers/irqchip/irq-vic.c:308:56: sparse:     expected void [noderef] __iomem *base
   drivers/irqchip/irq-vic.c:308:56: sparse:     got void *
   drivers/irqchip/irq-vic.c:317:56: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void [noderef] __iomem *base @@     got void * @@
   drivers/irqchip/irq-vic.c:317:56: sparse:     expected void [noderef] __iomem *base
   drivers/irqchip/irq-vic.c:317:56: sparse:     got void *
   drivers/irqchip/irq-vic.c:324:56: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void [noderef] __iomem *base @@     got void * @@
   drivers/irqchip/irq-vic.c:324:56: sparse:     expected void [noderef] __iomem *base
   drivers/irqchip/irq-vic.c:324:56: sparse:     got void *
--
>> drivers/video/fbdev/vt8500lcdfb.c:361:33: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char [noderef] __iomem *screen_base @@     got void *[assigned] fb_mem_virt @@
   drivers/video/fbdev/vt8500lcdfb.c:361:33: sparse:     expected char [noderef] __iomem *screen_base
   drivers/video/fbdev/vt8500lcdfb.c:361:33: sparse:     got void *[assigned] fb_mem_virt
>> drivers/video/fbdev/vt8500lcdfb.c:364:33: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem *palette_cpu @@     got void * @@
   drivers/video/fbdev/vt8500lcdfb.c:364:33: sparse:     expected void [noderef] __iomem *palette_cpu
   drivers/video/fbdev/vt8500lcdfb.c:364:33: sparse:     got void *
>> drivers/video/fbdev/vt8500lcdfb.c:434:30: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected void *cpu_addr @@     got void [noderef] __iomem *palette_cpu @@
   drivers/video/fbdev/vt8500lcdfb.c:434:30: sparse:     expected void *cpu_addr
   drivers/video/fbdev/vt8500lcdfb.c:434:30: sparse:     got void [noderef] __iomem *palette_cpu
   drivers/video/fbdev/vt8500lcdfb.c:459:30: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected void *cpu_addr @@     got void [noderef] __iomem *palette_cpu @@
   drivers/video/fbdev/vt8500lcdfb.c:459:30: sparse:     expected void *cpu_addr
   drivers/video/fbdev/vt8500lcdfb.c:459:30: sparse:     got void [noderef] __iomem *palette_cpu
--
>> drivers/soc/bcm/brcmstb/pm/pm-arm.c:366:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *static [assigned] [toplevel] boot_sram @@
   drivers/soc/bcm/brcmstb/pm/pm-arm.c:366:16: sparse:     expected void const *
   drivers/soc/bcm/brcmstb/pm/pm-arm.c:366:16: sparse:     got void [noderef] __iomem *static [assigned] [toplevel] boot_sram
>> drivers/soc/bcm/brcmstb/pm/pm-arm.c:366:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *static [assigned] [toplevel] boot_sram @@
   drivers/soc/bcm/brcmstb/pm/pm-arm.c:366:16: sparse:     expected void const *
   drivers/soc/bcm/brcmstb/pm/pm-arm.c:366:16: sparse:     got void [noderef] __iomem *static [assigned] [toplevel] boot_sram
>> drivers/soc/bcm/brcmstb/pm/pm-arm.c:366:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got void [noderef] __iomem *static [assigned] [toplevel] boot_sram @@
   drivers/soc/bcm/brcmstb/pm/pm-arm.c:366:16: sparse:     expected void *
   drivers/soc/bcm/brcmstb/pm/pm-arm.c:366:16: sparse:     got void [noderef] __iomem *static [assigned] [toplevel] boot_sram
>> drivers/soc/bcm/brcmstb/pm/pm-arm.c:660:31: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] __iomem * @@     got void * @@
   drivers/soc/bcm/brcmstb/pm/pm-arm.c:660:31: sparse:     expected void [noderef] __iomem *
   drivers/soc/bcm/brcmstb/pm/pm-arm.c:660:31: sparse:     got void *
--
>> drivers/w1/masters/omap_hdq.c:226:15: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] rn_le @@     got restricted __le64 [usertype] @@
   drivers/w1/masters/omap_hdq.c:226:15: sparse:     expected unsigned long long [usertype] rn_le
   drivers/w1/masters/omap_hdq.c:226:15: sparse:     got restricted __le64 [usertype]

vim +244 arch/arm/mach-imx/pm-imx5.c

784a90c0a7d8f5 Sascha Hauer       2011-11-07  241  
784a90c0a7d8f5 Sascha Hauer       2011-11-07  242  static int mx5_pm_valid(suspend_state_t state)
784a90c0a7d8f5 Sascha Hauer       2011-11-07  243  {
784a90c0a7d8f5 Sascha Hauer       2011-11-07 @244  	return (state > PM_SUSPEND_ON && state <= PM_SUSPEND_MAX);
784a90c0a7d8f5 Sascha Hauer       2011-11-07  245  }
784a90c0a7d8f5 Sascha Hauer       2011-11-07  246  
784a90c0a7d8f5 Sascha Hauer       2011-11-07  247  static const struct platform_suspend_ops mx5_suspend_ops = {
784a90c0a7d8f5 Sascha Hauer       2011-11-07  248  	.valid = mx5_pm_valid,
784a90c0a7d8f5 Sascha Hauer       2011-11-07  249  	.enter = mx5_suspend_enter,
784a90c0a7d8f5 Sascha Hauer       2011-11-07  250  };
784a90c0a7d8f5 Sascha Hauer       2011-11-07  251  
ccc12b32dc8c8e Robert Lee         2012-05-21  252  static inline int imx5_cpu_do_idle(void)
784a90c0a7d8f5 Sascha Hauer       2011-11-07  253  {
ccc12b32dc8c8e Robert Lee         2012-05-21  254  	int ret = tzic_enable_wake();
ccc12b32dc8c8e Robert Lee         2012-05-21  255  
ccc12b32dc8c8e Robert Lee         2012-05-21  256  	if (likely(!ret))
565fa91f236524 Robert Lee         2012-05-21  257  		cpu_do_idle();
ccc12b32dc8c8e Robert Lee         2012-05-21  258  
ccc12b32dc8c8e Robert Lee         2012-05-21  259  	return ret;
565fa91f236524 Robert Lee         2012-05-21  260  }
784a90c0a7d8f5 Sascha Hauer       2011-11-07  261  
ccc12b32dc8c8e Robert Lee         2012-05-21  262  static void imx5_pm_idle(void)
ccc12b32dc8c8e Robert Lee         2012-05-21  263  {
ccc12b32dc8c8e Robert Lee         2012-05-21  264  	imx5_cpu_do_idle();
ccc12b32dc8c8e Robert Lee         2012-05-21  265  }
ccc12b32dc8c8e Robert Lee         2012-05-21  266  
1579c7b9fe0105 Martin Fuzzey      2015-05-12  267  static int __init imx_suspend_alloc_ocram(
1579c7b9fe0105 Martin Fuzzey      2015-05-12  268  				size_t size,
1579c7b9fe0105 Martin Fuzzey      2015-05-12  269  				void __iomem **virt_out,
1579c7b9fe0105 Martin Fuzzey      2015-05-12  270  				phys_addr_t *phys_out)
1579c7b9fe0105 Martin Fuzzey      2015-05-12  271  {
1579c7b9fe0105 Martin Fuzzey      2015-05-12  272  	struct device_node *node;
1579c7b9fe0105 Martin Fuzzey      2015-05-12  273  	struct platform_device *pdev;
1579c7b9fe0105 Martin Fuzzey      2015-05-12  274  	struct gen_pool *ocram_pool;
1579c7b9fe0105 Martin Fuzzey      2015-05-12  275  	unsigned long ocram_base;
1579c7b9fe0105 Martin Fuzzey      2015-05-12  276  	void __iomem *virt;
1579c7b9fe0105 Martin Fuzzey      2015-05-12  277  	phys_addr_t phys;
1579c7b9fe0105 Martin Fuzzey      2015-05-12  278  	int ret = 0;
1579c7b9fe0105 Martin Fuzzey      2015-05-12  279  
1579c7b9fe0105 Martin Fuzzey      2015-05-12  280  	/* Copied from imx6: TODO factorize */
1579c7b9fe0105 Martin Fuzzey      2015-05-12  281  	node = of_find_compatible_node(NULL, NULL, "mmio-sram");
1579c7b9fe0105 Martin Fuzzey      2015-05-12  282  	if (!node) {
1579c7b9fe0105 Martin Fuzzey      2015-05-12  283  		pr_warn("%s: failed to find ocram node!\n", __func__);
1579c7b9fe0105 Martin Fuzzey      2015-05-12  284  		return -ENODEV;
1579c7b9fe0105 Martin Fuzzey      2015-05-12  285  	}
1579c7b9fe0105 Martin Fuzzey      2015-05-12  286  
1579c7b9fe0105 Martin Fuzzey      2015-05-12  287  	pdev = of_find_device_by_node(node);
1579c7b9fe0105 Martin Fuzzey      2015-05-12  288  	if (!pdev) {
1579c7b9fe0105 Martin Fuzzey      2015-05-12  289  		pr_warn("%s: failed to find ocram device!\n", __func__);
1579c7b9fe0105 Martin Fuzzey      2015-05-12  290  		ret = -ENODEV;
1579c7b9fe0105 Martin Fuzzey      2015-05-12  291  		goto put_node;
1579c7b9fe0105 Martin Fuzzey      2015-05-12  292  	}
1579c7b9fe0105 Martin Fuzzey      2015-05-12  293  
73858173593c31 Vladimir Zapolskiy 2015-09-04  294  	ocram_pool = gen_pool_get(&pdev->dev, NULL);
1579c7b9fe0105 Martin Fuzzey      2015-05-12  295  	if (!ocram_pool) {
1579c7b9fe0105 Martin Fuzzey      2015-05-12  296  		pr_warn("%s: ocram pool unavailable!\n", __func__);
1579c7b9fe0105 Martin Fuzzey      2015-05-12  297  		ret = -ENODEV;
586745f1598ccf yu kuai            2020-06-04  298  		goto put_device;
1579c7b9fe0105 Martin Fuzzey      2015-05-12  299  	}
1579c7b9fe0105 Martin Fuzzey      2015-05-12  300  
1579c7b9fe0105 Martin Fuzzey      2015-05-12  301  	ocram_base = gen_pool_alloc(ocram_pool, size);
1579c7b9fe0105 Martin Fuzzey      2015-05-12  302  	if (!ocram_base) {
1579c7b9fe0105 Martin Fuzzey      2015-05-12  303  		pr_warn("%s: unable to alloc ocram!\n", __func__);
1579c7b9fe0105 Martin Fuzzey      2015-05-12  304  		ret = -ENOMEM;
586745f1598ccf yu kuai            2020-06-04  305  		goto put_device;
1579c7b9fe0105 Martin Fuzzey      2015-05-12  306  	}
1579c7b9fe0105 Martin Fuzzey      2015-05-12  307  
1579c7b9fe0105 Martin Fuzzey      2015-05-12  308  	phys = gen_pool_virt_to_phys(ocram_pool, ocram_base);
1579c7b9fe0105 Martin Fuzzey      2015-05-12  309  	virt = __arm_ioremap_exec(phys, size, false);
1579c7b9fe0105 Martin Fuzzey      2015-05-12  310  	if (phys_out)
1579c7b9fe0105 Martin Fuzzey      2015-05-12  311  		*phys_out = phys;
1579c7b9fe0105 Martin Fuzzey      2015-05-12  312  	if (virt_out)
1579c7b9fe0105 Martin Fuzzey      2015-05-12  313  		*virt_out = virt;
1579c7b9fe0105 Martin Fuzzey      2015-05-12  314  
586745f1598ccf yu kuai            2020-06-04  315  put_device:
586745f1598ccf yu kuai            2020-06-04  316  	put_device(&pdev->dev);
1579c7b9fe0105 Martin Fuzzey      2015-05-12  317  put_node:
1579c7b9fe0105 Martin Fuzzey      2015-05-12  318  	of_node_put(node);
1579c7b9fe0105 Martin Fuzzey      2015-05-12  319  
1579c7b9fe0105 Martin Fuzzey      2015-05-12  320  	return ret;
1579c7b9fe0105 Martin Fuzzey      2015-05-12  321  }
1579c7b9fe0105 Martin Fuzzey      2015-05-12  322  
1579c7b9fe0105 Martin Fuzzey      2015-05-12  323  static int __init imx5_suspend_init(const struct imx5_pm_data *soc_data)
1579c7b9fe0105 Martin Fuzzey      2015-05-12  324  {
1579c7b9fe0105 Martin Fuzzey      2015-05-12  325  	struct imx5_cpu_suspend_info *suspend_info;
1579c7b9fe0105 Martin Fuzzey      2015-05-12  326  	int ret;
1579c7b9fe0105 Martin Fuzzey      2015-05-12  327  	/* Need this to avoid compile error due to const typeof in fncpy.h */
1579c7b9fe0105 Martin Fuzzey      2015-05-12  328  	void (*suspend_asm)(void __iomem *) = soc_data->suspend_asm;
1579c7b9fe0105 Martin Fuzzey      2015-05-12  329  
1579c7b9fe0105 Martin Fuzzey      2015-05-12  330  	if (!suspend_asm)
1579c7b9fe0105 Martin Fuzzey      2015-05-12  331  		return 0;
1579c7b9fe0105 Martin Fuzzey      2015-05-12  332  
1579c7b9fe0105 Martin Fuzzey      2015-05-12  333  	if (!soc_data->suspend_asm_sz || !*soc_data->suspend_asm_sz)
1579c7b9fe0105 Martin Fuzzey      2015-05-12  334  		return -EINVAL;
1579c7b9fe0105 Martin Fuzzey      2015-05-12  335  
1579c7b9fe0105 Martin Fuzzey      2015-05-12  336  	ret = imx_suspend_alloc_ocram(
1579c7b9fe0105 Martin Fuzzey      2015-05-12  337  		*soc_data->suspend_asm_sz + sizeof(*suspend_info),
1579c7b9fe0105 Martin Fuzzey      2015-05-12  338  		&suspend_ocram_base, NULL);
1579c7b9fe0105 Martin Fuzzey      2015-05-12  339  	if (ret)
1579c7b9fe0105 Martin Fuzzey      2015-05-12  340  		return ret;
1579c7b9fe0105 Martin Fuzzey      2015-05-12  341  
1579c7b9fe0105 Martin Fuzzey      2015-05-12 @342  	suspend_info = suspend_ocram_base;
1579c7b9fe0105 Martin Fuzzey      2015-05-12  343  
1579c7b9fe0105 Martin Fuzzey      2015-05-12  344  	suspend_info->io_count = soc_data->suspend_io_count;
1579c7b9fe0105 Martin Fuzzey      2015-05-12  345  	memcpy(suspend_info->io_state, soc_data->suspend_io_config,
1579c7b9fe0105 Martin Fuzzey      2015-05-12  346  	       sizeof(*suspend_info->io_state) * soc_data->suspend_io_count);
1579c7b9fe0105 Martin Fuzzey      2015-05-12  347  
1579c7b9fe0105 Martin Fuzzey      2015-05-12  348  	suspend_info->m4if_base = ioremap(soc_data->m4if_addr, SZ_16K);
1579c7b9fe0105 Martin Fuzzey      2015-05-12  349  	if (!suspend_info->m4if_base) {
1579c7b9fe0105 Martin Fuzzey      2015-05-12  350  		ret = -ENOMEM;
1579c7b9fe0105 Martin Fuzzey      2015-05-12  351  		goto failed_map_m4if;
1579c7b9fe0105 Martin Fuzzey      2015-05-12  352  	}
1579c7b9fe0105 Martin Fuzzey      2015-05-12  353  
1579c7b9fe0105 Martin Fuzzey      2015-05-12  354  	suspend_info->iomuxc_base = ioremap(soc_data->iomuxc_addr, SZ_16K);
1579c7b9fe0105 Martin Fuzzey      2015-05-12  355  	if (!suspend_info->iomuxc_base) {
1579c7b9fe0105 Martin Fuzzey      2015-05-12  356  		ret = -ENOMEM;
1579c7b9fe0105 Martin Fuzzey      2015-05-12  357  		goto failed_map_iomuxc;
1579c7b9fe0105 Martin Fuzzey      2015-05-12  358  	}
1579c7b9fe0105 Martin Fuzzey      2015-05-12  359  
1579c7b9fe0105 Martin Fuzzey      2015-05-12 @360  	imx5_suspend_in_ocram_fn = fncpy(
1579c7b9fe0105 Martin Fuzzey      2015-05-12  361  		suspend_ocram_base + sizeof(*suspend_info),
1579c7b9fe0105 Martin Fuzzey      2015-05-12  362  		suspend_asm,
1579c7b9fe0105 Martin Fuzzey      2015-05-12  363  		*soc_data->suspend_asm_sz);
1579c7b9fe0105 Martin Fuzzey      2015-05-12  364  
1579c7b9fe0105 Martin Fuzzey      2015-05-12  365  	return 0;
1579c7b9fe0105 Martin Fuzzey      2015-05-12  366  
1579c7b9fe0105 Martin Fuzzey      2015-05-12  367  failed_map_iomuxc:
1579c7b9fe0105 Martin Fuzzey      2015-05-12  368  	iounmap(suspend_info->m4if_base);
1579c7b9fe0105 Martin Fuzzey      2015-05-12  369  
1579c7b9fe0105 Martin Fuzzey      2015-05-12  370  failed_map_m4if:
1579c7b9fe0105 Martin Fuzzey      2015-05-12  371  	return ret;
1579c7b9fe0105 Martin Fuzzey      2015-05-12  372  }
1579c7b9fe0105 Martin Fuzzey      2015-05-12  373  

:::::: The code at line 244 was first introduced by commit
:::::: 784a90c0a7d8f5aa94b6c7d295ad44ae8e045aa3 ARM i.MX: Merge i.MX5 support into mach-imx

:::::: TO: Sascha Hauer <s.hauer@pengutronix.de>
:::::: CC: Sascha Hauer <s.hauer@pengutronix.de>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
