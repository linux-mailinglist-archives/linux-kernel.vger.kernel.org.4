Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49F175BB651
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 06:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbiIQEhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 00:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiIQEhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 00:37:01 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47909A59BF
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 21:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663389418; x=1694925418;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=wlmneH16zva8f+wcqTURyZ1jhWSu43E8W/p+j3fZlsw=;
  b=Wi81w2olqXxNgzYh574Wcx57cdjXivmAZmTroJvI/bY/qW3DVbCko+nN
   sxGxfvLxi+7mLqi60KQ0PdNV9Q3YcHcLk03ms4IBZ9F0qnfEPb1xLXEhr
   t3qFZ5/3aieGBXt2MmMMzIUG3IAq0gU/0nBjlWNNZKAaGjjFURVIaGFzs
   sgQMoDPrZ5oEuGCqct+t6CXlwYSX08Lc/IrCUcfO9HTlu0cKzJ4S6KDlH
   wQwD2dhJuv1/ULBuj7p8RJbFu7sKdGBOfy+r+pOOEmXML2A5VBzA+rPdt
   KSs3odRQPhdN4JwYbKbnLab3TajEBvAR4sKDSvTGnKHZ+I1S0zaq7y3oh
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10472"; a="300493387"
X-IronPort-AV: E=Sophos;i="5.93,322,1654585200"; 
   d="scan'208";a="300493387"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 21:36:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,322,1654585200"; 
   d="scan'208";a="595478654"
Received: from lkp-server02.sh.intel.com (HELO 41300c7200ea) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 16 Sep 2022 21:36:56 -0700
Received: from kbuild by 41300c7200ea with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oZPZX-0002UQ-1S;
        Sat, 17 Sep 2022 04:36:55 +0000
Date:   Sat, 17 Sep 2022 12:36:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/gpu/drm/omapdrm/omap_dmm_tiler.c:121:16: sparse: sparse:
 incorrect type in argument 1 (different address spaces)
Message-ID: <202209171202.y4LK0Bog-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a335366bad1364a07f49df9da1fdfa6d411a5f39
commit: 09f6b27d5ddd9ad0ec096d1b0f8decdacc70f0f8 ARM: dove: multiplatform support
date:   6 months ago
config: arm-randconfig-s033-20220916 (https://download.01.org/0day-ci/archive/20220917/202209171202.y4LK0Bog-lkp@intel.com/config)
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
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> drivers/gpu/drm/omapdrm/omap_dmm_tiler.c:121:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int [usertype] *wa_dma_data @@
   drivers/gpu/drm/omapdrm/omap_dmm_tiler.c:121:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/omapdrm/omap_dmm_tiler.c:121:16: sparse:     got unsigned int [usertype] *wa_dma_data
>> drivers/gpu/drm/omapdrm/omap_dmm_tiler.c:129:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int [usertype] *wa_dma_data @@
   drivers/gpu/drm/omapdrm/omap_dmm_tiler.c:129:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/omapdrm/omap_dmm_tiler.c:129:9: sparse:     got unsigned int [usertype] *wa_dma_data
>> drivers/gpu/drm/omapdrm/omap_dmm_tiler.c:413:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/gpu/drm/omapdrm/omap_dmm_tiler.c:413:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/omapdrm/omap_dmm_tiler.c:413:9: sparse:     got unsigned int *
--
>> drivers/soc/ti/knav_qmss_queue.c:70:12: sparse: sparse: symbol 'knav_acc_firmwares' was not declared. Should it be static?
>> drivers/soc/ti/knav_qmss_queue.c:1381:31: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] __iomem * @@     got void * @@
   drivers/soc/ti/knav_qmss_queue.c:1381:31: sparse:     expected void [noderef] __iomem *
   drivers/soc/ti/knav_qmss_queue.c:1381:31: sparse:     got void *
>> drivers/soc/ti/knav_qmss_queue.c:1553:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned int [usertype] *[noderef] __iomem addr @@     got unsigned int [noderef] __iomem * @@
   drivers/soc/ti/knav_qmss_queue.c:1553:41: sparse:     expected unsigned int [usertype] *[noderef] __iomem addr
   drivers/soc/ti/knav_qmss_queue.c:1553:41: sparse:     got unsigned int [noderef] __iomem *
>> drivers/soc/ti/knav_qmss_queue.c:1597:17: sparse: sparse: cast to restricted __be32
>> drivers/soc/ti/knav_qmss_queue.c:1624:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned int [usertype] *[noderef] __iomem addr @@     got void [noderef] __iomem *command @@
   drivers/soc/ti/knav_qmss_queue.c:1624:40: sparse:     expected unsigned int [usertype] *[noderef] __iomem addr
   drivers/soc/ti/knav_qmss_queue.c:1624:40: sparse:     got void [noderef] __iomem *command
>> drivers/soc/ti/knav_qmss_queue.c:491:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int [usertype] *[noderef] __iomem addr @@
   drivers/soc/ti/knav_qmss_queue.c:491:23: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/soc/ti/knav_qmss_queue.c:491:23: sparse:     got unsigned int [usertype] *[noderef] __iomem addr
>> drivers/soc/ti/knav_qmss_queue.c:491:23: sparse: sparse: dereference of noderef expression
>> drivers/soc/ti/knav_qmss_queue.c:491:23: sparse: sparse: dereference of noderef expression
>> drivers/soc/ti/knav_qmss_queue.c:491:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int [usertype] *[noderef] __iomem addr @@
   drivers/soc/ti/knav_qmss_queue.c:491:23: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/soc/ti/knav_qmss_queue.c:491:23: sparse:     got unsigned int [usertype] *[noderef] __iomem addr
>> drivers/soc/ti/knav_qmss_queue.c:491:23: sparse: sparse: dereference of noderef expression
>> drivers/soc/ti/knav_qmss_queue.c:491:23: sparse: sparse: dereference of noderef expression
--
>> drivers/soc/ti/knav_dma.c:539:31: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] __iomem * @@     got void * @@
   drivers/soc/ti/knav_dma.c:539:31: sparse:     expected void [noderef] __iomem *
   drivers/soc/ti/knav_dma.c:539:31: sparse:     got void *
--
>> drivers/w1/masters/omap_hdq.c:226:15: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] rn_le @@     got restricted __le64 [usertype] @@
   drivers/w1/masters/omap_hdq.c:226:15: sparse:     expected unsigned long long [usertype] rn_le
   drivers/w1/masters/omap_hdq.c:226:15: sparse:     got restricted __le64 [usertype]
--
>> arch/arm/mach-axxia/platsmp.c:25:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int [usertype] *virt @@
   arch/arm/mach-axxia/platsmp.c:25:9: sparse:     expected void volatile [noderef] __iomem *addr
   arch/arm/mach-axxia/platsmp.c:25:9: sparse:     got unsigned int [usertype] *virt
--
>> arch/arm/mach-hisi/platsmp.c:143:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem *virt @@     got void * @@
   arch/arm/mach-hisi/platsmp.c:143:14: sparse:     expected void [noderef] __iomem *virt
   arch/arm/mach-hisi/platsmp.c:143:14: sparse:     got void *
--
>> arch/arm/mach-mvebu/pm-board.c:46:15: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] srcmd @@     got restricted __le32 [usertype] @@
   arch/arm/mach-mvebu/pm-board.c:46:15: sparse:     expected unsigned int [usertype] srcmd
   arch/arm/mach-mvebu/pm-board.c:46:15: sparse:     got restricted __le32 [usertype]
>> arch/arm/mach-mvebu/pm-board.c:47:16: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [assigned] [usertype] ackcmd @@     got restricted __le32 [usertype] @@
   arch/arm/mach-mvebu/pm-board.c:47:16: sparse:     expected unsigned int [assigned] [usertype] ackcmd
   arch/arm/mach-mvebu/pm-board.c:47:16: sparse:     got restricted __le32 [usertype]
--
>> arch/arm/mach-mvebu/pmsu.c:145:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *[assigned] sram_virt_base @@
   arch/arm/mach-mvebu/pmsu.c:145:9: sparse:     expected void const *
   arch/arm/mach-mvebu/pmsu.c:145:9: sparse:     got void [noderef] __iomem *[assigned] sram_virt_base
>> arch/arm/mach-mvebu/pmsu.c:145:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *[assigned] sram_virt_base @@
   arch/arm/mach-mvebu/pmsu.c:145:9: sparse:     expected void const *
   arch/arm/mach-mvebu/pmsu.c:145:9: sparse:     got void [noderef] __iomem *[assigned] sram_virt_base
>> arch/arm/mach-mvebu/pmsu.c:145:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got void [noderef] __iomem *[assigned] sram_virt_base @@
   arch/arm/mach-mvebu/pmsu.c:145:9: sparse:     expected void *
   arch/arm/mach-mvebu/pmsu.c:145:9: sparse:     got void [noderef] __iomem *[assigned] sram_virt_base
--
>> arch/arm/mach-mvebu/pm.c:124:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int [usertype] * @@
   arch/arm/mach-mvebu/pm.c:124:9: sparse:     expected void volatile [noderef] __iomem *addr
   arch/arm/mach-mvebu/pm.c:124:9: sparse:     got unsigned int [usertype] *
   arch/arm/mach-mvebu/pm.c:125:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int [usertype] * @@
   arch/arm/mach-mvebu/pm.c:125:9: sparse:     expected void volatile [noderef] __iomem *addr
   arch/arm/mach-mvebu/pm.c:125:9: sparse:     got unsigned int [usertype] *
   arch/arm/mach-mvebu/pm.c:133:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int [usertype] * @@
   arch/arm/mach-mvebu/pm.c:133:9: sparse:     expected void volatile [noderef] __iomem *addr
   arch/arm/mach-mvebu/pm.c:133:9: sparse:     got unsigned int [usertype] *
   arch/arm/mach-mvebu/pm.c:134:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int [usertype] * @@
   arch/arm/mach-mvebu/pm.c:134:9: sparse:     expected void volatile [noderef] __iomem *addr
   arch/arm/mach-mvebu/pm.c:134:9: sparse:     got unsigned int [usertype] *
   arch/arm/mach-mvebu/pm.c:140:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int [usertype] * @@
   arch/arm/mach-mvebu/pm.c:140:9: sparse:     expected void volatile [noderef] __iomem *addr
   arch/arm/mach-mvebu/pm.c:140:9: sparse:     got unsigned int [usertype] *
   arch/arm/mach-mvebu/pm.c:141:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int [usertype] * @@
   arch/arm/mach-mvebu/pm.c:141:9: sparse:     expected void volatile [noderef] __iomem *addr
   arch/arm/mach-mvebu/pm.c:141:9: sparse:     got unsigned int [usertype] *
>> arch/arm/mach-mvebu/pm.c:148:50: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned int [noderef] [usertype] __iomem *store_addr @@     got unsigned int [usertype] *[assigned] store_addr @@
   arch/arm/mach-mvebu/pm.c:148:50: sparse:     expected unsigned int [noderef] [usertype] __iomem *store_addr
   arch/arm/mach-mvebu/pm.c:148:50: sparse:     got unsigned int [usertype] *[assigned] store_addr
>> arch/arm/mach-mvebu/pm.c:150:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int [usertype] *[assigned] store_addr @@
   arch/arm/mach-mvebu/pm.c:150:9: sparse:     expected void volatile [noderef] __iomem *addr
   arch/arm/mach-mvebu/pm.c:150:9: sparse:     got unsigned int [usertype] *[assigned] store_addr
--
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
>> arch/arm/mach-imx/platsmp.c:142:9: sparse: sparse: cast from restricted __be32
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
>> arch/arm/mach-sti/platsmp.c:44:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile *p @@     got unsigned int [noderef] [usertype] __iomem *static [toplevel] cpu_strt_ptr @@
   arch/arm/mach-sti/platsmp.c:44:9: sparse:     expected void volatile *p
   arch/arm/mach-sti/platsmp.c:44:9: sparse:     got unsigned int [noderef] [usertype] __iomem *static [toplevel] cpu_strt_ptr
--
   drivers/irqchip/irq-gic-v3.c:943:78: sparse: sparse: dubious: !x | y
   drivers/irqchip/irq-gic-v3.c:233:29: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3.c:256:17: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3.c:346:24: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3.c:363:24: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3.c:197:24: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3.c:594:24: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3.c:891:17: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3.c:892:17: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3.c:893:17: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3.c: note: in included file (through include/linux/irqchip/arm-gic-v3.h):
>> arch/arm/include/asm/arch_gicv3.h:151:9: sparse: sparse: cast truncates bits from constant value (2000000000000000 becomes 0)
   drivers/irqchip/irq-gic-v3.c:1130:17: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3.c:197:24: sparse: sparse: dereference of noderef expression
--
   drivers/irqchip/irq-gic-v3-its.c:1456:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct raw_spinlock [usertype] *lock @@     got struct raw_spinlock [noderef] __percpu * @@
   drivers/irqchip/irq-gic-v3-its.c:1456:9: sparse:     expected struct raw_spinlock [usertype] *lock
   drivers/irqchip/irq-gic-v3-its.c:1456:9: sparse:     got struct raw_spinlock [noderef] __percpu *
   drivers/irqchip/irq-gic-v3-its.c:1461:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct raw_spinlock [usertype] *lock @@     got struct raw_spinlock [noderef] __percpu * @@
   drivers/irqchip/irq-gic-v3-its.c:1461:9: sparse:     expected struct raw_spinlock [usertype] *lock
   drivers/irqchip/irq-gic-v3-its.c:1461:9: sparse:     got struct raw_spinlock [noderef] __percpu *
   drivers/irqchip/irq-gic-v3-its.c:2827:45: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct cpumask [usertype] **mask @@     got struct cpumask [usertype] *[noderef] __percpu * @@
   drivers/irqchip/irq-gic-v3-its.c:2827:45: sparse:     expected struct cpumask [usertype] **mask
   drivers/irqchip/irq-gic-v3-its.c:2827:45: sparse:     got struct cpumask [usertype] *[noderef] __percpu *
   drivers/irqchip/irq-gic-v3-its.c:3936:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct raw_spinlock [usertype] *lock @@     got struct raw_spinlock [noderef] __percpu * @@
   drivers/irqchip/irq-gic-v3-its.c:3936:17: sparse:     expected struct raw_spinlock [usertype] *lock
   drivers/irqchip/irq-gic-v3-its.c:3936:17: sparse:     got struct raw_spinlock [noderef] __percpu *
   drivers/irqchip/irq-gic-v3-its.c:3940:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct raw_spinlock [usertype] *lock @@     got struct raw_spinlock [noderef] __percpu * @@
   drivers/irqchip/irq-gic-v3-its.c:3940:17: sparse:     expected struct raw_spinlock [usertype] *lock
   drivers/irqchip/irq-gic-v3-its.c:3940:17: sparse:     got struct raw_spinlock [noderef] __percpu *
   drivers/irqchip/irq-gic-v3-its.c:4118:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct raw_spinlock [usertype] *lock @@     got struct raw_spinlock [noderef] __percpu * @@
   drivers/irqchip/irq-gic-v3-its.c:4118:9: sparse:     expected struct raw_spinlock [usertype] *lock
   drivers/irqchip/irq-gic-v3-its.c:4118:9: sparse:     got struct raw_spinlock [noderef] __percpu *
   drivers/irqchip/irq-gic-v3-its.c:4123:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct raw_spinlock [usertype] *lock @@     got struct raw_spinlock [noderef] __percpu * @@
   drivers/irqchip/irq-gic-v3-its.c:4123:9: sparse:     expected struct raw_spinlock [usertype] *lock
   drivers/irqchip/irq-gic-v3-its.c:4123:9: sparse:     got struct raw_spinlock [noderef] __percpu *
   drivers/irqchip/irq-gic-v3-its.c:4258:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct raw_spinlock [usertype] *lock @@     got struct raw_spinlock [noderef] __percpu * @@
   drivers/irqchip/irq-gic-v3-its.c:4258:9: sparse:     expected struct raw_spinlock [usertype] *lock
   drivers/irqchip/irq-gic-v3-its.c:4258:9: sparse:     got struct raw_spinlock [noderef] __percpu *
   drivers/irqchip/irq-gic-v3-its.c:4276:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct raw_spinlock [usertype] *lock @@     got struct raw_spinlock [noderef] __percpu * @@
   drivers/irqchip/irq-gic-v3-its.c:4276:9: sparse:     expected struct raw_spinlock [usertype] *lock
   drivers/irqchip/irq-gic-v3-its.c:4276:9: sparse:     got struct raw_spinlock [noderef] __percpu *
   drivers/irqchip/irq-gic-v3-its.c:263:12: sparse: sparse: context imbalance in 'vpe_to_cpuid_lock' - wrong count at exit
   drivers/irqchip/irq-gic-v3-its.c:269:13: sparse: sparse: context imbalance in 'vpe_to_cpuid_unlock' - unexpected unlock
   drivers/irqchip/irq-gic-v3-its.c:1457:18: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3-its.c:2234:23: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3-its.c:2234:23: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3-its.c:2644:15: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3-its.c:2644:15: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3-its.c:2665:17: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3-its.c:2699:15: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3-its.c:2699:15: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3-its.c:2703:38: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3-its.c:2721:17: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3-its.c:2721:49: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3-its.c:2722:25: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3-its.c:2732:30: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3-its.c:2775:17: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3-its.c:2802:35: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3-its.c: note: in included file (through include/linux/irqchip/arm-gic-v3.h):
>> arch/arm/include/asm/arch_gicv3.h:151:9: sparse: sparse: cast truncates bits from constant value (2000000000000000 becomes 0)
   drivers/irqchip/irq-gic-v3-its.c:2831:9: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3-its.c:2832:14: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3-its.c:2902:9: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3-its.c:2914:45: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3-its.c:2914:45: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3-its.c:2916:9: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3-its.c:2968:15: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3-its.c:2968:15: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3-its.c:2983:15: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3-its.c:2983:15: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3-its.c:3008:17: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3-its.c:3046:31: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3-its.c:3051:13: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3-its.c:3070:17: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3-its.c:3075:21: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3-its.c:3128:43: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3-its.c:3163:9: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3-its.c:3164:9: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3-its.c:3195:26: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3-its.c:3198:26: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3-its.c:3198:26: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3-its.c:3748:26: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3-its.c:3797:13: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3-its.c:3798:36: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3-its.c:3798:36: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3-its.c:3813:35: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3-its.c:3827:35: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3-its.c:3859:35: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3-its.c:3937:26: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3-its.c:3977:26: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3-its.c:4057:35: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3-its.c:4072:35: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3-its.c:4119:18: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3-its.c:4259:16: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3-its.c:5136:19: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3-its.c:5136:19: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3-its.c:5141:31: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3-its.c:5161:14: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3-its.c:5238:13: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3-its.c:5241:21: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3-its.c:5251:13: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3-its.c:5253:17: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3-its.c:5265:9: sparse: sparse: dereference of noderef expression
--
>> drivers/irqchip/irq-rda-intc.c:96:51: sparse: sparse: incorrect type in argument 4 (different address spaces) @@     expected void *host_data @@     got void [noderef] __iomem *static [assigned] [toplevel] rda_intc_base @@
   drivers/irqchip/irq-rda-intc.c:96:51: sparse:     expected void *host_data
   drivers/irqchip/irq-rda-intc.c:96:51: sparse:     got void [noderef] __iomem *static [assigned] [toplevel] rda_intc_base
--
>> drivers/remoteproc/omap_remoteproc.c:1338:47: sparse: sparse: Using plain integer as NULL pointer
--
   kernel/futex/core.c: note: in included file (through kernel/futex/futex.h):
>> arch/arm/include/asm/futex.h:58:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const *ptr @@     got unsigned int [noderef] [usertype] __user *uaddr @@
   arch/arm/include/asm/futex.h:58:19: sparse:     expected void const *ptr
   arch/arm/include/asm/futex.h:58:19: sparse:     got unsigned int [noderef] [usertype] __user *uaddr
--
>> drivers/net/ethernet/smsc/smc911x.c:491:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/net/ethernet/smsc/smc911x.c:491:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got int * @@
   drivers/net/ethernet/smsc/smc911x.c:491:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/smsc/smc911x.c:491:9: sparse:     got int *
   drivers/net/ethernet/smsc/smc911x.c:430:17: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/net/ethernet/smsc/smc911x.c:430:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got int * @@
   drivers/net/ethernet/smsc/smc911x.c:430:17: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/smsc/smc911x.c:430:17: sparse:     got int *
--
>> drivers/gpu/drm/sti/sti_mixer.c:145:47: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/sti/sti_mixer.c:145:47: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/sti/sti_mixer.c:145:47: sparse:     got void *
>> drivers/gpu/drm/sti/sti_mixer.c:168:38: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void *addr @@     got void [noderef] __iomem * @@
   drivers/gpu/drm/sti/sti_mixer.c:168:38: sparse:     expected void *addr
   drivers/gpu/drm/sti/sti_mixer.c:168:38: sparse:     got void [noderef] __iomem *

vim +121 drivers/gpu/drm/omapdrm/omap_dmm_tiler.c

f5b9930b85dc63 Tomi Valkeinen 2018-09-26  101  static u32 dmm_read_wa(struct dmm *dmm, u32 reg)
f5b9930b85dc63 Tomi Valkeinen 2018-09-26  102  {
f5b9930b85dc63 Tomi Valkeinen 2018-09-26  103  	dma_addr_t src, dst;
f5b9930b85dc63 Tomi Valkeinen 2018-09-26  104  	int r;
f5b9930b85dc63 Tomi Valkeinen 2018-09-26  105  
f5b9930b85dc63 Tomi Valkeinen 2018-09-26  106  	src = dmm->phys_base + reg;
f5b9930b85dc63 Tomi Valkeinen 2018-09-26  107  	dst = dmm->wa_dma_handle;
f5b9930b85dc63 Tomi Valkeinen 2018-09-26  108  
f5b9930b85dc63 Tomi Valkeinen 2018-09-26  109  	r = dmm_dma_copy(dmm, src, dst);
f5b9930b85dc63 Tomi Valkeinen 2018-09-26  110  	if (r) {
f5b9930b85dc63 Tomi Valkeinen 2018-09-26  111  		dev_err(dmm->dev, "sDMA read transfer timeout\n");
f5b9930b85dc63 Tomi Valkeinen 2018-09-26  112  		return readl(dmm->base + reg);
f5b9930b85dc63 Tomi Valkeinen 2018-09-26  113  	}
f5b9930b85dc63 Tomi Valkeinen 2018-09-26  114  
f5b9930b85dc63 Tomi Valkeinen 2018-09-26  115  	/*
f5b9930b85dc63 Tomi Valkeinen 2018-09-26  116  	 * As per i878 workaround, the DMA is used to access the DMM registers.
f5b9930b85dc63 Tomi Valkeinen 2018-09-26  117  	 * Make sure that the readl is not moved by the compiler or the CPU
f5b9930b85dc63 Tomi Valkeinen 2018-09-26  118  	 * earlier than the DMA finished writing the value to memory.
f5b9930b85dc63 Tomi Valkeinen 2018-09-26  119  	 */
f5b9930b85dc63 Tomi Valkeinen 2018-09-26  120  	rmb();
f5b9930b85dc63 Tomi Valkeinen 2018-09-26 @121  	return readl(dmm->wa_dma_data);
f5b9930b85dc63 Tomi Valkeinen 2018-09-26  122  }
f5b9930b85dc63 Tomi Valkeinen 2018-09-26  123  
f5b9930b85dc63 Tomi Valkeinen 2018-09-26  124  static void dmm_write_wa(struct dmm *dmm, u32 val, u32 reg)
f5b9930b85dc63 Tomi Valkeinen 2018-09-26  125  {
f5b9930b85dc63 Tomi Valkeinen 2018-09-26  126  	dma_addr_t src, dst;
f5b9930b85dc63 Tomi Valkeinen 2018-09-26  127  	int r;
f5b9930b85dc63 Tomi Valkeinen 2018-09-26  128  
f5b9930b85dc63 Tomi Valkeinen 2018-09-26 @129  	writel(val, dmm->wa_dma_data);
f5b9930b85dc63 Tomi Valkeinen 2018-09-26  130  	/*
f5b9930b85dc63 Tomi Valkeinen 2018-09-26  131  	 * As per i878 workaround, the DMA is used to access the DMM registers.
f5b9930b85dc63 Tomi Valkeinen 2018-09-26  132  	 * Make sure that the writel is not moved by the compiler or the CPU, so
f5b9930b85dc63 Tomi Valkeinen 2018-09-26  133  	 * the data will be in place before we start the DMA to do the actual
f5b9930b85dc63 Tomi Valkeinen 2018-09-26  134  	 * register write.
f5b9930b85dc63 Tomi Valkeinen 2018-09-26  135  	 */
f5b9930b85dc63 Tomi Valkeinen 2018-09-26  136  	wmb();
f5b9930b85dc63 Tomi Valkeinen 2018-09-26  137  
f5b9930b85dc63 Tomi Valkeinen 2018-09-26  138  	src = dmm->wa_dma_handle;
f5b9930b85dc63 Tomi Valkeinen 2018-09-26  139  	dst = dmm->phys_base + reg;
f5b9930b85dc63 Tomi Valkeinen 2018-09-26  140  
f5b9930b85dc63 Tomi Valkeinen 2018-09-26  141  	r = dmm_dma_copy(dmm, src, dst);
f5b9930b85dc63 Tomi Valkeinen 2018-09-26  142  	if (r) {
f5b9930b85dc63 Tomi Valkeinen 2018-09-26  143  		dev_err(dmm->dev, "sDMA write transfer timeout\n");
f5b9930b85dc63 Tomi Valkeinen 2018-09-26  144  		writel(val, dmm->base + reg);
f5b9930b85dc63 Tomi Valkeinen 2018-09-26  145  	}
f5b9930b85dc63 Tomi Valkeinen 2018-09-26  146  }
f5b9930b85dc63 Tomi Valkeinen 2018-09-26  147  
8e54adfd9ccda8 Tomi Valkeinen 2015-08-07  148  static u32 dmm_read(struct dmm *dmm, u32 reg)

:::::: The code at line 121 was first introduced by commit
:::::: f5b9930b85dc6319fd6bcc259e447eff62fc691c drm/omap: partial workaround for DRA7xx DMM errata i878

:::::: TO: Tomi Valkeinen <tomi.valkeinen@ti.com>
:::::: CC: Tomi Valkeinen <tomi.valkeinen@ti.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
