Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18DEB72409A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 13:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232411AbjFFLOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 07:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjFFLOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 07:14:22 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD20CE49
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 04:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686050060; x=1717586060;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=EaVTgfPjM1qo0C2Az+g6tqM7rH7+KpZVZmHsnU0I1P8=;
  b=QvRV7nZj4Q8KaFC9CSZ33r1vcwy9j4iP8oDY9a8+zWHBiHLxV8VQbOZ+
   skVP3ou6hbseihnXnZAr5f4sRiODFDRS+YtWP/4iWPRws9FVm7qQ/coLH
   K5fSiQ5iZegvGtBglgu7WkGwF0BxHdp/FuceOLx60UPRJmqPqcuTis9Vr
   rKo2UOWdlkbH2qmJl0DWdMYgSyyv79M2MO7i6+lK5hFXD7dz6F6oq7+5o
   mAZebMB9fHl3Dy7fUreM0CQE5YRUEGSsdQpbZXNG7fZltGOthIjSmok/U
   /UcZxWkRwO1k2uewgB1+qG340w/w+HvgDCN7YYFm183BFpKivnsNC+Brw
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="355491922"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="355491922"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 04:14:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="1039139116"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="1039139116"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 06 Jun 2023 04:14:19 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q6Udm-0005AJ-1m;
        Tue, 06 Jun 2023 11:14:18 +0000
Date:   Tue, 6 Jun 2023 19:13:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>
Subject: kernel/irq/msi.c:585:19: error: invalid use of incomplete typedef
 'msi_alloc_info_t' {aka 'struct irq_alloc_info'}
Message-ID: <202306061930.E9RPdG8J-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frank,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f8dba31b0a826e691949cd4fdfa5c30defaac8c5
commit: 70afdab904d2d1e68bffe75fe08e7e48e0b0ff8e irqchip: Add IMX MU MSI controller driver
date:   8 months ago
config: i386-buildonly-randconfig-r002-20230606 (https://download.01.org/0day-ci/archive/20230606/202306061930.E9RPdG8J-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=70afdab904d2d1e68bffe75fe08e7e48e0b0ff8e
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 70afdab904d2d1e68bffe75fe08e7e48e0b0ff8e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 olddefconfig
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/base/ drivers/input/touchscreen/ kernel/irq/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306061930.E9RPdG8J-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   kernel/irq/msi.c: In function 'msi_domain_ops_get_hwirq':
>> kernel/irq/msi.c:585:19: error: invalid use of incomplete typedef 'msi_alloc_info_t' {aka 'struct irq_alloc_info'}
     585 |         return arg->hwirq;
         |                   ^~
   In file included from arch/x86/include/asm/string.h:3,
                    from include/linux/string.h:20,
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
   arch/x86/include/asm/string_32.h:195:52: note: in definition of macro 'memset'
     195 | #define memset(s, c, count) __builtin_memset(s, c, count)
         |                                                    ^~~~~
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
>> kernel/irq/msi.c:858:26: warning: unused variable 'arg' [-Wunused-variable]
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
--
   In file included from include/asm-generic/gpio.h:11,
                    from include/linux/gpio.h:62,
                    from drivers/input/touchscreen/auo-pixcir-ts.c:22:
>> include/linux/gpio/driver.h:31:33: error: field 'msiinfo' has incomplete type
      31 |         msi_alloc_info_t        msiinfo;
         |                                 ^~~~~~~


vim +585 kernel/irq/msi.c

f3cf8bb0d6c3c1 Jiang Liu 2014-11-12  581  
aeeb59657c35da Jiang Liu 2014-11-15  582  static irq_hw_number_t msi_domain_ops_get_hwirq(struct msi_domain_info *info,
aeeb59657c35da Jiang Liu 2014-11-15  583  						msi_alloc_info_t *arg)
aeeb59657c35da Jiang Liu 2014-11-15  584  {
aeeb59657c35da Jiang Liu 2014-11-15 @585  	return arg->hwirq;
aeeb59657c35da Jiang Liu 2014-11-15  586  }
aeeb59657c35da Jiang Liu 2014-11-15  587  
aeeb59657c35da Jiang Liu 2014-11-15  588  static int msi_domain_ops_prepare(struct irq_domain *domain, struct device *dev,
aeeb59657c35da Jiang Liu 2014-11-15  589  				  int nvec, msi_alloc_info_t *arg)
aeeb59657c35da Jiang Liu 2014-11-15  590  {
aeeb59657c35da Jiang Liu 2014-11-15 @591  	memset(arg, 0, sizeof(*arg));
aeeb59657c35da Jiang Liu 2014-11-15  592  	return 0;
aeeb59657c35da Jiang Liu 2014-11-15  593  }
aeeb59657c35da Jiang Liu 2014-11-15  594  

:::::: The code at line 585 was first introduced by commit
:::::: aeeb59657c35da64068336c20068da237f41ab76 genirq: Provide default callbacks for msi_domain_ops

:::::: TO: Jiang Liu <jiang.liu@linux.intel.com>
:::::: CC: Thomas Gleixner <tglx@linutronix.de>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
