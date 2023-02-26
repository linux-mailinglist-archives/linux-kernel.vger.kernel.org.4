Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8236A34CE
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 23:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjBZWuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 17:50:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBZWuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 17:50:18 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B201EC66
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 14:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677451817; x=1708987817;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=b7/7ll+6fXDbtYJnvQOzYp9/l9Eir6KTCW7YVnt+DdI=;
  b=PSYzQUGHJml8ivSjSh3iWPt3+hT4NRNwt6hsmV0Sjua/P7PFeB5f3db2
   GOIBLAnEQpw12+Ah+OnJH55YnheI+UGTGJUgGVZTyQtcFanaGusLeFzKE
   vsxjxA2+fdnl75Tn50/1LvvogJMoLyJn0utAO1OY1a7+cVmoRdYKoWhu5
   xNJLuFjBWuM3d5Ju7BnLqXZ6UD8Gxz6L1QXXO30KDUBugrQ7XNUgV+U5e
   4Pe3BkhZKWvBNCUZ/xWsoMcO3WfRFrl/eJZcRBVmrmxY55BF/HsvBKCXx
   2q9+duhFEhlglrymqCp1Xn3kEj2/GP/b5qDiuW9nu2JRhSKq7mMzqOEEh
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10633"; a="335223077"
X-IronPort-AV: E=Sophos;i="5.97,330,1669104000"; 
   d="scan'208";a="335223077"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2023 14:50:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10633"; a="1002495359"
X-IronPort-AV: E=Sophos;i="5.97,330,1669104000"; 
   d="scan'208";a="1002495359"
Received: from lkp-server01.sh.intel.com (HELO 3895f5c55ead) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 26 Feb 2023 14:50:09 -0800
Received: from kbuild by 3895f5c55ead with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pWPqK-0003wF-2E;
        Sun, 26 Feb 2023 22:50:08 +0000
Date:   Mon, 27 Feb 2023 06:49:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>
Subject: include/linux/gpio/driver.h:31:19: error: field has incomplete type
 'msi_alloc_info_t' (aka 'struct irq_alloc_info')
Message-ID: <202302270633.RKhl0Tlx-lkp@intel.com>
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
head:   f3a2439f20d918930cc4ae8f76fe1c1afd26958f
commit: 70afdab904d2d1e68bffe75fe08e7e48e0b0ff8e irqchip: Add IMX MU MSI controller driver
date:   5 months ago
config: i386-buildonly-randconfig-r006-20230227 (https://download.01.org/0day-ci/archive/20230227/202302270633.RKhl0Tlx-lkp@intel.com/config)
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
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302270633.RKhl0Tlx-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/misc/hi6421v600-irq.c:14:
   In file included from include/linux/of_gpio.h:14:
>> include/linux/gpio/driver.h:31:19: error: field has incomplete type 'msi_alloc_info_t' (aka 'struct irq_alloc_info')
           msi_alloc_info_t        msiinfo;
                                   ^
   arch/x86/include/asm/msi.h:7:16: note: forward declaration of 'struct irq_alloc_info'
   typedef struct irq_alloc_info msi_alloc_info_t;
                  ^
   1 error generated.
--
>> arch/x86/kernel/hpet.c:520:39: error: incomplete definition of type 'struct irq_alloc_info'
           irq_domain_set_info(domain, virq, arg->hwirq, info->chip, NULL,
                                             ~~~^
   arch/x86/include/asm/io_apic.h:90:8: note: forward declaration of 'struct irq_alloc_info'
   struct irq_alloc_info;
          ^
   arch/x86/kernel/hpet.c:521:28: error: incomplete definition of type 'struct irq_alloc_info'
                               handle_edge_irq, arg->data, "edge");
                                                ~~~^
   arch/x86/include/asm/io_apic.h:90:8: note: forward declaration of 'struct irq_alloc_info'
   struct irq_alloc_info;
          ^
>> arch/x86/kernel/hpet.c:550:6: error: use of undeclared identifier 'x86_vector_domain'
           if (x86_vector_domain == NULL)
               ^
   arch/x86/kernel/hpet.c:577:16: error: use of undeclared identifier 'x86_vector_domain'
           if (parent != x86_vector_domain)
                         ^
>> arch/x86/kernel/hpet.c:598:24: error: variable has incomplete type 'struct irq_alloc_info'
           struct irq_alloc_info info;
                                 ^
   arch/x86/include/asm/io_apic.h:90:8: note: forward declaration of 'struct irq_alloc_info'
   struct irq_alloc_info;
          ^
>> arch/x86/kernel/hpet.c:600:2: error: implicit declaration of function 'init_irq_alloc_info' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           init_irq_alloc_info(&info, NULL);
           ^
>> arch/x86/kernel/hpet.c:601:14: error: use of undeclared identifier 'X86_IRQ_ALLOC_TYPE_HPET'
           info.type = X86_IRQ_ALLOC_TYPE_HPET;
                       ^
   7 errors generated.
--
>> kernel/irq/msi.c:585:12: error: incomplete definition of type 'struct irq_alloc_info'
           return arg->hwirq;
                  ~~~^
   arch/x86/include/asm/msi.h:7:16: note: forward declaration of 'struct irq_alloc_info'
   typedef struct irq_alloc_info msi_alloc_info_t;
                  ^
>> kernel/irq/msi.c:591:23: error: invalid application of 'sizeof' to an incomplete type 'msi_alloc_info_t' (aka 'struct irq_alloc_info')
           memset(arg, 0, sizeof(*arg));
                                ^~~~~~
   arch/x86/include/asm/string_32.h:195:52: note: expanded from macro 'memset'
   #define memset(s, c, count) __builtin_memset(s, c, count)
                                                      ^~~~~
   arch/x86/include/asm/msi.h:7:16: note: forward declaration of 'struct irq_alloc_info'
   typedef struct irq_alloc_info msi_alloc_info_t;
                  ^
   kernel/irq/msi.c:598:5: error: incomplete definition of type 'struct irq_alloc_info'
           arg->desc = desc;
           ~~~^
   arch/x86/include/asm/msi.h:7:16: note: forward declaration of 'struct irq_alloc_info'
   typedef struct irq_alloc_info msi_alloc_info_t;
                  ^
>> kernel/irq/msi.c:858:19: error: variable has incomplete type 'msi_alloc_info_t' (aka 'struct irq_alloc_info')
           msi_alloc_info_t arg = { };
                            ^
   arch/x86/include/asm/msi.h:7:16: note: forward declaration of 'struct irq_alloc_info'
   typedef struct irq_alloc_info msi_alloc_info_t;
                  ^
   4 errors generated.
--
>> drivers/base/platform-msi.c:26:20: error: field has incomplete type 'msi_alloc_info_t' (aka 'struct irq_alloc_info')
           msi_alloc_info_t                arg;
                                           ^
   arch/x86/include/asm/msi.h:7:16: note: forward declaration of 'struct irq_alloc_info'
   typedef struct irq_alloc_info msi_alloc_info_t;
                  ^
   1 error generated.
--
   In file included from drivers/mmc/host/dw_mmc.c:38:
   In file included from include/linux/of_gpio.h:14:
>> include/linux/gpio/driver.h:31:19: error: field has incomplete type 'msi_alloc_info_t' (aka 'struct irq_alloc_info')
           msi_alloc_info_t        msiinfo;
                                   ^
   arch/x86/include/asm/msi.h:7:16: note: forward declaration of 'struct irq_alloc_info'
   typedef struct irq_alloc_info msi_alloc_info_t;
                  ^
   drivers/mmc/host/dw_mmc.c:3040:33: warning: shift count >= width of type [-Wshift-count-overflow]
                           if (!dma_set_mask(host->dev, DMA_BIT_MASK(64)))
                                                        ^~~~~~~~~~~~~~~~
   include/linux/dma-mapping.h:76:54: note: expanded from macro 'DMA_BIT_MASK'
   #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
                                                        ^ ~~~
   drivers/mmc/host/dw_mmc.c:3042:13: warning: shift count >= width of type [-Wshift-count-overflow]
                                                         DMA_BIT_MASK(64));
                                                         ^~~~~~~~~~~~~~~~
   include/linux/dma-mapping.h:76:54: note: expanded from macro 'DMA_BIT_MASK'
   #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
                                                        ^ ~~~
   2 warnings and 1 error generated.
--
   In file included from drivers/char/tpm/st33zp24/st33zp24.c:15:
   In file included from include/linux/gpio.h:62:
   In file included from include/asm-generic/gpio.h:11:
>> include/linux/gpio/driver.h:31:19: error: field has incomplete type 'msi_alloc_info_t' (aka 'struct irq_alloc_info')
           msi_alloc_info_t        msiinfo;
                                   ^
   arch/x86/include/asm/msi.h:7:16: note: forward declaration of 'struct irq_alloc_info'
   typedef struct irq_alloc_info msi_alloc_info_t;
                  ^
   In file included from drivers/char/tpm/st33zp24/st33zp24.c:21:
   In file included from drivers/char/tpm/st33zp24/../tpm.h:28:
   include/linux/tpm_eventlog.h:167:6: warning: variable 'mapping_size' set but not used [-Wunused-but-set-variable]
           int mapping_size;
               ^
   1 warning and 1 error generated.
--
   In file included from drivers/gpio/gpio-mxc.c:22:
>> include/linux/gpio/driver.h:31:19: error: field has incomplete type 'msi_alloc_info_t' (aka 'struct irq_alloc_info')
           msi_alloc_info_t        msiinfo;
                                   ^
   arch/x86/include/asm/msi.h:7:16: note: forward declaration of 'struct irq_alloc_info'
   typedef struct irq_alloc_info msi_alloc_info_t;
                  ^
   drivers/gpio/gpio-mxc.c:341:50: warning: shift count >= width of type [-Wshift-count-overflow]
           rv = devm_irq_setup_generic_chip(port->dev, gc, IRQ_MSK(32),
                                                           ^~~~~~~~~~~
   include/linux/irq.h:1193:41: note: expanded from macro 'IRQ_MSK'
   #define IRQ_MSK(n) (u32)((n) < 32 ? ((1 << (n)) - 1) : UINT_MAX)
                                           ^  ~~~
   1 warning and 1 error generated.


vim +31 include/linux/gpio/driver.h

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
