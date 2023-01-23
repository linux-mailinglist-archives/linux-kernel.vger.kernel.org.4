Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B241B67744A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 04:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbjAWDS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 22:18:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjAWDSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 22:18:55 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D757E12073
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 19:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674443933; x=1705979933;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=vS2vki05YYtQrjL+IwoUF3kWDeptVpEZbaufJ3cw82s=;
  b=bkcEH2alVf9JAzizKw9eWds3dnEPmcoa+JMyDofyxRu8BU2MHg3oiwz+
   mqrNZHCaqNd+VTOayCaugBmKZ+3TSktiuUHnCQ/6hgHP6xwlOAAfgf8JW
   dX1xauShiWa6a96u73H14ItVsDVdY8WezkEi7InHqBRhhdy38IH1AR7GU
   RBgd/gXMJDkuskVEmo5ngt/rIdkFCagYW/xCSvCN7y+/ILbXKqJE0lMKL
   5hP7mF3DPKr9IgYhsD4jLfnkFSIv/i/L9CZgIt87VTg48cR3zl7HG0KrP
   SP00yTu9diFbmc+iFrM/BJFpni0fJzwiKnBdTPTe5e0GmPyrtzY637l1n
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10598"; a="353227129"
X-IronPort-AV: E=Sophos;i="5.97,238,1669104000"; 
   d="scan'208";a="353227129"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2023 19:18:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10598"; a="750176535"
X-IronPort-AV: E=Sophos;i="5.97,238,1669104000"; 
   d="scan'208";a="750176535"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Jan 2023 19:18:52 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pJnMB-0005Nw-0z;
        Mon, 23 Jan 2023 03:18:51 +0000
Date:   Mon, 23 Jan 2023 11:18:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>
Subject: include/linux/gpio/driver.h:31:33: error: field 'msiinfo' has
 incomplete type
Message-ID: <202301231157.7KGwNdDX-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2475bf0250dee99b477e0c56d7dc9d7ac3f04117
commit: 70afdab904d2d1e68bffe75fe08e7e48e0b0ff8e irqchip: Add IMX MU MSI controller driver
date:   4 months ago
config: i386-buildonly-randconfig-r002-20230123 (https://download.01.org/0day-ci/archive/20230123/202301231157.7KGwNdDX-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=70afdab904d2d1e68bffe75fe08e7e48e0b0ff8e
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 70afdab904d2d1e68bffe75fe08e7e48e0b0ff8e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 olddefconfig
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/asm-generic/gpio.h:11,
                    from include/linux/gpio.h:62,
                    from include/linux/mfd/lp8788.h:13,
                    from drivers/regulator/lp8788-buck.c:15:
>> include/linux/gpio/driver.h:31:33: error: field 'msiinfo' has incomplete type
      31 |         msi_alloc_info_t        msiinfo;
         |                                 ^~~~~~~
--
   arch/x86/kernel/hpet.c: In function 'hpet_msi_init':
>> arch/x86/kernel/hpet.c:520:46: error: invalid use of incomplete typedef 'msi_alloc_info_t' {aka 'struct irq_alloc_info'}
     520 |         irq_domain_set_info(domain, virq, arg->hwirq, info->chip, NULL,
         |                                              ^~
   arch/x86/kernel/hpet.c:521:49: error: invalid use of incomplete typedef 'msi_alloc_info_t' {aka 'struct irq_alloc_info'}
     521 |                             handle_edge_irq, arg->data, "edge");
         |                                                 ^~
   arch/x86/kernel/hpet.c: In function 'hpet_create_irq_domain':
>> arch/x86/kernel/hpet.c:550:13: error: 'x86_vector_domain' undeclared (first use in this function)
     550 |         if (x86_vector_domain == NULL)
         |             ^~~~~~~~~~~~~~~~~
   arch/x86/kernel/hpet.c:550:13: note: each undeclared identifier is reported only once for each function it appears in
   arch/x86/kernel/hpet.c: In function 'hpet_assign_irq':
>> arch/x86/kernel/hpet.c:598:31: error: storage size of 'info' isn't known
     598 |         struct irq_alloc_info info;
         |                               ^~~~
>> arch/x86/kernel/hpet.c:600:9: error: implicit declaration of function 'init_irq_alloc_info' [-Werror=implicit-function-declaration]
     600 |         init_irq_alloc_info(&info, NULL);
         |         ^~~~~~~~~~~~~~~~~~~
>> arch/x86/kernel/hpet.c:601:21: error: 'X86_IRQ_ALLOC_TYPE_HPET' undeclared (first use in this function)
     601 |         info.type = X86_IRQ_ALLOC_TYPE_HPET;
         |                     ^~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/kernel/hpet.c:598:31: warning: unused variable 'info' [-Wunused-variable]
     598 |         struct irq_alloc_info info;
         |                               ^~~~
   arch/x86/kernel/hpet.c:607:1: error: control reaches end of non-void function [-Werror=return-type]
     607 | }
         | ^
   cc1: some warnings being treated as errors
--
   kernel/irq/msi.c: In function 'msi_domain_ops_get_hwirq':
>> kernel/irq/msi.c:585:19: error: invalid use of incomplete typedef 'msi_alloc_info_t' {aka 'struct irq_alloc_info'}
     585 |         return arg->hwirq;
         |                   ^~
   In file included from include/linux/string.h:253,
                    from arch/x86/include/asm/page_32.h:22,
                    from arch/x86/include/asm/page.h:14,
                    from arch/x86/include/asm/thread_info.h:12,
                    from include/linux/thread_info.h:60,
                    from arch/x86/include/asm/preempt.h:7,
                    from include/linux/preempt.h:78,
                    from include/linux/rcupdate.h:27,
                    from include/linux/rculist.h:11,
                    from include/linux/pid.h:5,
                    from include/linux/sched.h:14,
                    from include/linux/ratelimit.h:6,
                    from include/linux/dev_printk.h:16,
                    from include/linux/device.h:15,
                    from kernel/irq/msi.c:12:
   kernel/irq/msi.c: In function 'msi_domain_ops_prepare':
>> kernel/irq/msi.c:591:30: error: invalid application of 'sizeof' to incomplete type 'msi_alloc_info_t' {aka 'struct irq_alloc_info'}
     591 |         memset(arg, 0, sizeof(*arg));
         |                              ^
   include/linux/fortify-string.h:279:42: note: in definition of macro '__fortify_memset_chk'
     279 |         size_t __fortify_size = (size_t)(size);                         \
         |                                          ^~~~
   kernel/irq/msi.c:591:9: note: in expansion of macro 'memset'
     591 |         memset(arg, 0, sizeof(*arg));
         |         ^~~~~~
   kernel/irq/msi.c: In function 'msi_domain_ops_set_desc':
   kernel/irq/msi.c:598:12: error: invalid use of incomplete typedef 'msi_alloc_info_t' {aka 'struct irq_alloc_info'}
     598 |         arg->desc = desc;
         |            ^~
   kernel/irq/msi.c: In function '__msi_domain_alloc_irqs':
>> kernel/irq/msi.c:858:9: error: variable 'arg' has initializer but incomplete type
     858 |         msi_alloc_info_t arg = { };
         |         ^~~~~~~~~~~~~~~~
>> kernel/irq/msi.c:858:26: error: storage size of 'arg' isn't known
     858 |         msi_alloc_info_t arg = { };
         |                          ^~~
   kernel/irq/msi.c:858:26: warning: unused variable 'arg' [-Wunused-variable]
   kernel/irq/msi.c: In function 'msi_domain_ops_get_hwirq':
   kernel/irq/msi.c:586:1: error: control reaches end of non-void function [-Werror=return-type]
     586 | }
         | ^
   cc1: some warnings being treated as errors
--
>> drivers/base/platform-msi.c:26:41: error: field 'arg' has incomplete type
      26 |         msi_alloc_info_t                arg;
         |                                         ^~~
   drivers/base/platform-msi.c: In function 'platform_msi_device_domain_alloc':
   drivers/base/platform-msi.c:351:1: error: control reaches end of non-void function [-Werror=return-type]
     351 | }
         | ^
   cc1: some warnings being treated as errors


vim +/msiinfo +31 include/linux/gpio/driver.h

fdd61a013a24f2 Linus Walleij 2019-08-08  27  
91a29af413def6 Marc Zyngier  2022-07-07  28  union gpio_irq_fwspec {
91a29af413def6 Marc Zyngier  2022-07-07  29  	struct irq_fwspec	fwspec;
91a29af413def6 Marc Zyngier  2022-07-07  30  #ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
91a29af413def6 Marc Zyngier  2022-07-07 @31  	msi_alloc_info_t	msiinfo;
91a29af413def6 Marc Zyngier  2022-07-07  32  #endif
91a29af413def6 Marc Zyngier  2022-07-07  33  };
91a29af413def6 Marc Zyngier  2022-07-07  34  

:::::: The code at line 31 was first introduced by commit
:::::: 91a29af413def677495e447fb9a06957ebc8bed5 gpio: Remove dynamic allocation from populate_parent_alloc_arg()

:::::: TO: Marc Zyngier <maz@kernel.org>
:::::: CC: Marc Zyngier <maz@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
