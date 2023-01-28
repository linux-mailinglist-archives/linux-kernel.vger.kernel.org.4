Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 510F467FB1E
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 22:23:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbjA1VXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 16:23:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbjA1VXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 16:23:02 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D757A5256
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 13:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674940978; x=1706476978;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=hkE+wqip3OM04K9+TWA2rConXTSWzDYvuyNWJ4CVK5U=;
  b=EmymlU8ry8LfzifyBVish29cZ/AHQMVieuqgcVcTktGtmP/hh1LQxuH+
   23iMw44Wu0QC8tbaEgLkZzbFjjTW6majwRTluWk9On3hXnFPGw03oIcUz
   An9mJeSHMv+uPtqacxLWgqZkF07WNFwkVgURUB+9ay8VTOym2Viah5Hdw
   OIsnb4to+rOO9j16o5qbd4920gOP2EV6ZLDoikDfSFkJOnvOcbP4dZ48f
   nc9d9H4J1j+moZd2KP4rH178vXjlGAbuRDJn4h2gG9Q0Zq3vX3vQ4V63H
   z+i4jAxT3mO1WQ7ghLM/gI5xJuwSJMiNwLxea0qVyCZ2nAEWoowkkiE+n
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="354648407"
X-IronPort-AV: E=Sophos;i="5.97,254,1669104000"; 
   d="scan'208";a="354648407"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2023 13:22:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="909048118"
X-IronPort-AV: E=Sophos;i="5.97,254,1669104000"; 
   d="scan'208";a="909048118"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 28 Jan 2023 13:22:53 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pLsey-00017b-1V;
        Sat, 28 Jan 2023 21:22:52 +0000
Date:   Sun, 29 Jan 2023 05:22:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: arch/arm/mach-imx/pm-imx5.c:244:17: sparse: sparse: restricted
 suspend_state_t degrades to integer
Message-ID: <202301290550.R45YlIY4-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c96618275234ad03d44eafe9f8844305bb44fda4
commit: 09f6b27d5ddd9ad0ec096d1b0f8decdacc70f0f8 ARM: dove: multiplatform support
date:   10 months ago
config: arm-randconfig-s041-20230129 (https://download.01.org/0day-ci/archive/20230129/202301290550.R45YlIY4-lkp@intel.com/config)
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
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm SHELL=/bin/bash arch/arm/kernel/ arch/arm/mach-imx/ arch/arm/mach-s3c/ arch/arm/mach-socfpga/ drivers/irqchip/ drivers/video/fbdev/aty/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

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
>> arch/arm/mach-s3c/gpio-samsung.c:50:16: sparse: sparse: restricted samsung_gpio_pull_t degrades to integer
>> arch/arm/mach-s3c/gpio-samsung.c:74:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted samsung_gpio_pull_t [usertype] pull @@     got int @@
   arch/arm/mach-s3c/gpio-samsung.c:74:22: sparse:     expected restricted samsung_gpio_pull_t [usertype] pull
   arch/arm/mach-s3c/gpio-samsung.c:74:22: sparse:     got int
>> arch/arm/mach-s3c/gpio-samsung.c:80:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted samsung_gpio_pull_t [assigned] [usertype] pull @@     got int @@
   arch/arm/mach-s3c/gpio-samsung.c:80:22: sparse:     expected restricted samsung_gpio_pull_t [assigned] [usertype] pull
   arch/arm/mach-s3c/gpio-samsung.c:80:22: sparse:     got int
   arch/arm/mach-s3c/gpio-samsung.c:93:17: sparse: sparse: restricted samsung_gpio_pull_t degrades to integer
   arch/arm/mach-s3c/gpio-samsung.c:93:17: sparse: sparse: restricted samsung_gpio_pull_t degrades to integer
   arch/arm/mach-s3c/gpio-samsung.c:93:17: sparse: sparse: restricted samsung_gpio_pull_t degrades to integer
>> arch/arm/mach-s3c/gpio-samsung.c:1301:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] pup @@     got restricted samsung_gpio_pull_t @@
   arch/arm/mach-s3c/gpio-samsung.c:1301:21: sparse:     expected unsigned int [usertype] pup
   arch/arm/mach-s3c/gpio-samsung.c:1301:21: sparse:     got restricted samsung_gpio_pull_t
--
>> arch/arm/mach-socfpga/pm.c:75:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *[assigned] suspend_ocram_base @@
   arch/arm/mach-socfpga/pm.c:75:25: sparse:     expected void const *
   arch/arm/mach-socfpga/pm.c:75:25: sparse:     got void [noderef] __iomem *[assigned] suspend_ocram_base
>> arch/arm/mach-socfpga/pm.c:75:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *[assigned] suspend_ocram_base @@
   arch/arm/mach-socfpga/pm.c:75:25: sparse:     expected void const *
   arch/arm/mach-socfpga/pm.c:75:25: sparse:     got void [noderef] __iomem *[assigned] suspend_ocram_base
>> arch/arm/mach-socfpga/pm.c:75:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got void [noderef] __iomem *[assigned] suspend_ocram_base @@
   arch/arm/mach-socfpga/pm.c:75:25: sparse:     expected void *
   arch/arm/mach-socfpga/pm.c:75:25: sparse:     got void [noderef] __iomem *[assigned] suspend_ocram_base
--
>> drivers/irqchip/irq-rda-intc.c:96:51: sparse: sparse: incorrect type in argument 4 (different address spaces) @@     expected void *host_data @@     got void [noderef] __iomem *static [assigned] [toplevel] rda_intc_base @@
   drivers/irqchip/irq-rda-intc.c:96:51: sparse:     expected void *host_data
   drivers/irqchip/irq-rda-intc.c:96:51: sparse:     got void [noderef] __iomem *static [assigned] [toplevel] rda_intc_base
--
   drivers/irqchip/irq-gic-v3.c:891:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct raw_spinlock [usertype] *lock @@     got struct raw_spinlock [noderef] __percpu * @@
   drivers/irqchip/irq-gic-v3.c:891:17: sparse:     expected struct raw_spinlock [usertype] *lock
   drivers/irqchip/irq-gic-v3.c:891:17: sparse:     got struct raw_spinlock [noderef] __percpu *
   drivers/irqchip/irq-gic-v3.c:943:78: sparse: sparse: dubious: !x | y
   drivers/irqchip/irq-gic-v3.c:233:29: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3.c:256:17: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3.c:346:24: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3.c:363:24: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3.c:197:24: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3.c:594:24: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3.c:892:17: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3.c:893:17: sparse: sparse: dereference of noderef expression
   drivers/irqchip/irq-gic-v3.c: note: in included file (through include/linux/irqchip/arm-gic-v3.h):
>> arch/arm/include/asm/arch_gicv3.h:151:9: sparse: sparse: cast truncates bits from constant value (2000000000000000 becomes 0)
   drivers/irqchip/irq-gic-v3.c:1130:17: sparse: sparse: dereference of noderef expression
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
>> arch/arm/kernel/fiq.c:162:56: sparse: sparse: invalid access below 'vector_fiq_offset' (-65536 4)

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
