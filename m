Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76DA16CF34E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 21:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbjC2Tky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 15:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjC2TkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 15:40:16 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 280425252
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 12:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680118812; x=1711654812;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=P1DmTNslo8gkHsYsg+1bShdtrm2fk5Kfm7ob24luDX0=;
  b=SdLCcH1VPj+uz71LCuSqwRhC36nVtC0fJoFraDkfkgWLdYp1wlbBuCcT
   +USq8eJXFdQBb015WyfP4Ctk4IDPXjq3d9F3PSmoYCbgUb9jf3DaxtDQ5
   JYeI1ICy0AdWQcXTwZSVFjvAjg0MXS3lNQ7MO+ob4Fu0Vv8PA3EK3B9hZ
   hy0r7LoagpApJGdcWEvC7ewP9M/CA5PqFyUNWVBCWCgT3RzCbBLMU3MgD
   KwEnIsw9b7Nyg7/RprpCr8OAgzbk8htc3FunbL61+KT2JoM6Ir1kv6z7X
   R5fx7goV3vi+0igqlcfTN7SSH117sltgJRIXOsevKKYeJvhzD1SR/OGdo
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="343430128"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="343430128"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 12:40:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="677905146"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="677905146"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 29 Mar 2023 12:40:10 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1phbeU-000Jsv-0j;
        Wed, 29 Mar 2023 19:40:10 +0000
Date:   Thu, 30 Mar 2023 03:39:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: arch/arm/mach-at91/pm.c:775:30: sparse: sparse: incorrect type in
 assignment (different address spaces)
Message-ID: <202303300305.M1gA53WC-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ffe78bbd512166e0ef1cc4858010b128c510ed7d
commit: 09f6b27d5ddd9ad0ec096d1b0f8decdacc70f0f8 ARM: dove: multiplatform support
date:   12 months ago
config: arm-randconfig-s043-20230329 (https://download.01.org/0day-ci/archive/20230330/202303300305.M1gA53WC-lkp@intel.com/config)
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
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm SHELL=/bin/bash arch/arm/mach-at91/ arch/arm/mach-sti/ drivers/dma/ drivers/gpu/drm/ drivers/irqchip/ drivers/mmc/host/ drivers/remoteproc/ kernel/futex/ sound/atmel/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303300305.M1gA53WC-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> arch/arm/mach-at91/pm.c:775:30: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void ( *static [assigned] [toplevel] at91_suspend_sram_fn )( ... ) @@     got void [noderef] __iomem * @@
   arch/arm/mach-at91/pm.c:775:30: sparse:     expected void ( *static [assigned] [toplevel] at91_suspend_sram_fn )( ... )
   arch/arm/mach-at91/pm.c:775:30: sparse:     got void [noderef] __iomem *
--
>> arch/arm/mach-sti/platsmp.c:44:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile *p @@     got unsigned int [noderef] [usertype] __iomem *static [toplevel] cpu_strt_ptr @@
   arch/arm/mach-sti/platsmp.c:44:9: sparse:     expected void volatile *p
   arch/arm/mach-sti/platsmp.c:44:9: sparse:     got unsigned int [noderef] [usertype] __iomem *static [toplevel] cpu_strt_ptr
--
   kernel/futex/waitwake.c: note: in included file (through kernel/futex/futex.h):
>> arch/arm/include/asm/futex.h:146:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const *ptr @@     got unsigned int [noderef] [usertype] __user *uaddr @@
   arch/arm/include/asm/futex.h:146:17: sparse:     expected void const *ptr
   arch/arm/include/asm/futex.h:146:17: sparse:     got unsigned int [noderef] [usertype] __user *uaddr
   arch/arm/include/asm/futex.h:149:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const *ptr @@     got unsigned int [noderef] [usertype] __user *uaddr @@
   arch/arm/include/asm/futex.h:149:17: sparse:     expected void const *ptr
   arch/arm/include/asm/futex.h:149:17: sparse:     got unsigned int [noderef] [usertype] __user *uaddr
   arch/arm/include/asm/futex.h:152:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const *ptr @@     got unsigned int [noderef] [usertype] __user *uaddr @@
   arch/arm/include/asm/futex.h:152:17: sparse:     expected void const *ptr
   arch/arm/include/asm/futex.h:152:17: sparse:     got unsigned int [noderef] [usertype] __user *uaddr
   arch/arm/include/asm/futex.h:155:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const *ptr @@     got unsigned int [noderef] [usertype] __user *uaddr @@
   arch/arm/include/asm/futex.h:155:17: sparse:     expected void const *ptr
   arch/arm/include/asm/futex.h:155:17: sparse:     got unsigned int [noderef] [usertype] __user *uaddr
   arch/arm/include/asm/futex.h:158:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const *ptr @@     got unsigned int [noderef] [usertype] __user *uaddr @@
   arch/arm/include/asm/futex.h:158:17: sparse:     expected void const *ptr
   arch/arm/include/asm/futex.h:158:17: sparse:     got unsigned int [noderef] [usertype] __user *uaddr
   kernel/futex/waitwake.c:262:33: sparse: sparse: context imbalance in 'futex_wake_op' - different lock contexts for basic block
   kernel/futex/waitwake.c:328:6: sparse: sparse: context imbalance in 'futex_wait_queue' - unexpected unlock
   kernel/futex/waitwake.c:449:36: sparse: sparse: context imbalance in 'futex_wait_multiple_setup' - unexpected unlock
--
>> drivers/dma/ste_dma40_ll.c:342:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ste_dma40_ll.c:342:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/dma/ste_dma40_ll.c:342:9: sparse:     got unsigned int *
   drivers/dma/ste_dma40_ll.c:343:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ste_dma40_ll.c:343:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/dma/ste_dma40_ll.c:343:9: sparse:     got unsigned int *
   drivers/dma/ste_dma40_ll.c:344:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ste_dma40_ll.c:344:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/dma/ste_dma40_ll.c:344:9: sparse:     got unsigned int *
   drivers/dma/ste_dma40_ll.c:345:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ste_dma40_ll.c:345:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/dma/ste_dma40_ll.c:345:9: sparse:     got unsigned int *
   drivers/dma/ste_dma40_ll.c:355:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ste_dma40_ll.c:355:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/dma/ste_dma40_ll.c:355:9: sparse:     got unsigned int *
   drivers/dma/ste_dma40_ll.c:356:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ste_dma40_ll.c:356:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/dma/ste_dma40_ll.c:356:9: sparse:     got unsigned int *
   drivers/dma/ste_dma40_ll.c:357:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ste_dma40_ll.c:357:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/dma/ste_dma40_ll.c:357:9: sparse:     got unsigned int *
   drivers/dma/ste_dma40_ll.c:358:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ste_dma40_ll.c:358:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/dma/ste_dma40_ll.c:358:9: sparse:     got unsigned int *
--
>> drivers/dma/ste_dma40.c:1389:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ste_dma40.c:1389:28: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/dma/ste_dma40.c:1389:28: sparse:     got unsigned int *
   drivers/dma/ste_dma40.c:1405:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ste_dma40.c:1405:27: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/dma/ste_dma40.c:1405:27: sparse:     got unsigned int *
>> drivers/dma/ste_dma40.c:3564:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *lcpa_base @@     got void [noderef] __iomem * @@
   drivers/dma/ste_dma40.c:3564:25: sparse:     expected void *lcpa_base
   drivers/dma/ste_dma40.c:3564:25: sparse:     got void [noderef] __iomem *
>> drivers/dma/ste_dma40.c:3580:38: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *base @@     got void [noderef] __iomem * @@
   drivers/dma/ste_dma40.c:3580:38: sparse:     expected void *base
   drivers/dma/ste_dma40.c:3580:38: sparse:     got void [noderef] __iomem *
   drivers/dma/ste_dma40.c:3663:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *iomem_cookie @@     got void *base @@
   drivers/dma/ste_dma40.c:3663:40: sparse:     expected void volatile [noderef] __iomem *iomem_cookie
   drivers/dma/ste_dma40.c:3663:40: sparse:     got void *base
   drivers/dma/ste_dma40.c:3679:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *iomem_cookie @@     got void *lcpa_base @@
   drivers/dma/ste_dma40.c:3679:29: sparse:     expected void volatile [noderef] __iomem *iomem_cookie
   drivers/dma/ste_dma40.c:3679:29: sparse:     got void *lcpa_base
--
>> drivers/irqchip/irq-rda-intc.c:96:51: sparse: sparse: incorrect type in argument 4 (different address spaces) @@     expected void *host_data @@     got void [noderef] __iomem *static [assigned] [toplevel] rda_intc_base @@
   drivers/irqchip/irq-rda-intc.c:96:51: sparse:     expected void *host_data
   drivers/irqchip/irq-rda-intc.c:96:51: sparse:     got void [noderef] __iomem *static [assigned] [toplevel] rda_intc_base
--
>> drivers/irqchip/irq-bcm7120-l2.c:193:38: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/irqchip/irq-bcm7120-l2.c:193:38: sparse: sparse: cast removes address space '__iomem' of expression
--
>> drivers/remoteproc/st_remoteproc.c:98:12: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *va @@     got void [noderef] __iomem * @@
   drivers/remoteproc/st_remoteproc.c:98:12: sparse:     expected void *va
   drivers/remoteproc/st_remoteproc.c:98:12: sparse:     got void [noderef] __iomem *
   drivers/remoteproc/st_remoteproc.c:114:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *iomem_cookie @@     got void *va @@
   drivers/remoteproc/st_remoteproc.c:114:20: sparse:     expected void volatile [noderef] __iomem *iomem_cookie
   drivers/remoteproc/st_remoteproc.c:114:20: sparse:     got void *va
--
>> drivers/remoteproc/omap_remoteproc.c:1338:47: sparse: sparse: Using plain integer as NULL pointer
--
>> drivers/mmc/host/wmt-sdmmc.c:242:39: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int @@     got restricted __be32 [usertype] @@
   drivers/mmc/host/wmt-sdmmc.c:242:39: sparse:     expected unsigned int
   drivers/mmc/host/wmt-sdmmc.c:242:39: sparse:     got restricted __be32 [usertype]
--
>> sound/atmel/ac97c.c:99:62: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted snd_pcm_format_t [usertype] pcm_format @@     got unsigned long long [usertype] cur_format @@
   sound/atmel/ac97c.c:99:62: sparse:     expected restricted snd_pcm_format_t [usertype] pcm_format
   sound/atmel/ac97c.c:99:62: sparse:     got unsigned long long [usertype] cur_format
   sound/atmel/ac97c.c:118:62: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted snd_pcm_format_t [usertype] pcm_format @@     got unsigned long long [usertype] cur_format @@
   sound/atmel/ac97c.c:118:62: sparse:     expected restricted snd_pcm_format_t [usertype] pcm_format
   sound/atmel/ac97c.c:118:62: sparse:     got unsigned long long [usertype] cur_format
>> sound/atmel/ac97c.c:166:26: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] cur_format @@     got restricted snd_pcm_format_t @@
   sound/atmel/ac97c.c:166:26: sparse:     expected unsigned long long [usertype] cur_format
   sound/atmel/ac97c.c:166:26: sparse:     got restricted snd_pcm_format_t
   sound/atmel/ac97c.c:180:26: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] cur_format @@     got restricted snd_pcm_format_t @@
   sound/atmel/ac97c.c:180:26: sparse:     expected unsigned long long [usertype] cur_format
   sound/atmel/ac97c.c:180:26: sparse:     got restricted snd_pcm_format_t

vim +775 arch/arm/mach-at91/pm.c

fbc7edca5a7dd4 Alexandre Belloni  2015-09-30  740  
d2e46790559676 Alexandre Belloni  2015-01-15  741  static void __init at91_pm_sram_init(void)
d2e46790559676 Alexandre Belloni  2015-01-15  742  {
d2e46790559676 Alexandre Belloni  2015-01-15  743  	struct gen_pool *sram_pool;
d2e46790559676 Alexandre Belloni  2015-01-15  744  	phys_addr_t sram_pbase;
d2e46790559676 Alexandre Belloni  2015-01-15  745  	unsigned long sram_base;
d2e46790559676 Alexandre Belloni  2015-01-15  746  	struct device_node *node;
4a031f7dbe497a Alexandre Belloni  2015-03-03  747  	struct platform_device *pdev = NULL;
d2e46790559676 Alexandre Belloni  2015-01-15  748  
4a031f7dbe497a Alexandre Belloni  2015-03-03  749  	for_each_compatible_node(node, NULL, "mmio-sram") {
4a031f7dbe497a Alexandre Belloni  2015-03-03  750  		pdev = of_find_device_by_node(node);
4a031f7dbe497a Alexandre Belloni  2015-03-03  751  		if (pdev) {
4a031f7dbe497a Alexandre Belloni  2015-03-03  752  			of_node_put(node);
4a031f7dbe497a Alexandre Belloni  2015-03-03  753  			break;
4a031f7dbe497a Alexandre Belloni  2015-03-03  754  		}
d2e46790559676 Alexandre Belloni  2015-01-15  755  	}
d2e46790559676 Alexandre Belloni  2015-01-15  756  
d2e46790559676 Alexandre Belloni  2015-01-15  757  	if (!pdev) {
d2e46790559676 Alexandre Belloni  2015-01-15  758  		pr_warn("%s: failed to find sram device!\n", __func__);
4a031f7dbe497a Alexandre Belloni  2015-03-03  759  		return;
d2e46790559676 Alexandre Belloni  2015-01-15  760  	}
d2e46790559676 Alexandre Belloni  2015-01-15  761  
73858173593c31 Vladimir Zapolskiy 2015-09-04  762  	sram_pool = gen_pool_get(&pdev->dev, NULL);
d2e46790559676 Alexandre Belloni  2015-01-15  763  	if (!sram_pool) {
d2e46790559676 Alexandre Belloni  2015-01-15  764  		pr_warn("%s: sram pool unavailable!\n", __func__);
f87a4f022c44e5 yu kuai            2020-06-04  765  		goto out_put_device;
d2e46790559676 Alexandre Belloni  2015-01-15  766  	}
d2e46790559676 Alexandre Belloni  2015-01-15  767  
5726a8b9686348 Wenyou Yang        2015-03-09  768  	sram_base = gen_pool_alloc(sram_pool, at91_pm_suspend_in_sram_sz);
d2e46790559676 Alexandre Belloni  2015-01-15  769  	if (!sram_base) {
5726a8b9686348 Wenyou Yang        2015-03-09  770  		pr_warn("%s: unable to alloc sram!\n", __func__);
f87a4f022c44e5 yu kuai            2020-06-04  771  		goto out_put_device;
d2e46790559676 Alexandre Belloni  2015-01-15  772  	}
d2e46790559676 Alexandre Belloni  2015-01-15  773  
d2e46790559676 Alexandre Belloni  2015-01-15  774  	sram_pbase = gen_pool_virt_to_phys(sram_pool, sram_base);
5726a8b9686348 Wenyou Yang        2015-03-09 @775  	at91_suspend_sram_fn = __arm_ioremap_exec(sram_pbase,
5726a8b9686348 Wenyou Yang        2015-03-09  776  					at91_pm_suspend_in_sram_sz, false);
5726a8b9686348 Wenyou Yang        2015-03-09  777  	if (!at91_suspend_sram_fn) {
d94e688cae5661 Wenyou Yang        2015-03-09  778  		pr_warn("SRAM: Could not map\n");
f87a4f022c44e5 yu kuai            2020-06-04  779  		goto out_put_device;
d94e688cae5661 Wenyou Yang        2015-03-09  780  	}
d94e688cae5661 Wenyou Yang        2015-03-09  781  
5726a8b9686348 Wenyou Yang        2015-03-09  782  	/* Copy the pm suspend handler to SRAM */
5726a8b9686348 Wenyou Yang        2015-03-09  783  	at91_suspend_sram_fn = fncpy(at91_suspend_sram_fn,
5726a8b9686348 Wenyou Yang        2015-03-09  784  			&at91_pm_suspend_in_sram, at91_pm_suspend_in_sram_sz);
f87a4f022c44e5 yu kuai            2020-06-04  785  	return;
f87a4f022c44e5 yu kuai            2020-06-04  786  
f87a4f022c44e5 yu kuai            2020-06-04  787  out_put_device:
f87a4f022c44e5 yu kuai            2020-06-04  788  	put_device(&pdev->dev);
f87a4f022c44e5 yu kuai            2020-06-04  789  	return;
d2e46790559676 Alexandre Belloni  2015-01-15  790  }
d2e46790559676 Alexandre Belloni  2015-01-15  791  

:::::: The code at line 775 was first introduced by commit
:::::: 5726a8b9686348e8d203f1bbf9d5fc1bb5899518 ARM: at91/pm: rename function name: at91_slow_clock() --> at91_pm_suspend_sram_fn()

:::::: TO: Wenyou Yang <wenyou.yang@atmel.com>
:::::: CC: Nicolas Ferre <nicolas.ferre@atmel.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
