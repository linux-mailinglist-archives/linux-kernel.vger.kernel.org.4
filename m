Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 665C65BA690
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 08:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbiIPF75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 01:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiIPF7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 01:59:45 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8161C1C92F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 22:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663307982; x=1694843982;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=w0qqJosfPVrIgxuOR6YYYTKrfFKZQ4iaFYo5f9yH9hc=;
  b=f8XiQEynyAIQR3Ink2+EaxkYC7WYhJ7pPk50DRQ0uYtw5lpbdmRgvr64
   nVhYn6HM1ALLYHryan3cPkZv4tAMiKDEnJXrKuDcIJoCQqZ8ylvtT880y
   DMzyDe/PEL7qXglim0smMCvwkodbg+4wkRUK/Z+Z4D028lRWzR2YzSVIl
   ecIvV6N+wvsovudMnx0QdSBz/bdqS2Qoigvcel0KePFXGk87ee4i/FOn4
   vW4tn8Ix6kq22ZULnp5IrWTN+uyRfTnxd6+Y+u6d80BgSHdy7MmeThLSS
   4kcvxfumkXWADGN1dDPWuqJdYfLYtAdZtz2+yRKVySZuFCc8+3LSenDn4
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10471"; a="298912549"
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="298912549"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2022 22:59:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="706637186"
Received: from lkp-server02.sh.intel.com (HELO 41300c7200ea) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Sep 2022 22:59:39 -0700
Received: from kbuild by 41300c7200ea with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oZ4O2-0001Uu-1E;
        Fri, 16 Sep 2022 05:59:38 +0000
Date:   Fri, 16 Sep 2022 13:59:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Jianmin Lv <lvjianmin@loongson.cn>
Subject: drivers/irqchip/irq-loongson-pch-lpc.c:151:13: warning: declaration
 of 'struct acpi_madt_lpc_pic' will not be visible outside of this function
Message-ID: <202209161317.b47Av73d-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3245cb65fd91cd514801bf91f5a3066d562f0ac4
commit: ee73f14ee9eb7e1a04051b303b56130c4dd6e048 irqchip: Add Loongson PCH LPC controller support
date:   8 weeks ago
config: mips-randconfig-r023-20220915 (https://download.01.org/0day-ci/archive/20220916/202209161317.b47Av73d-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 791a7ae1ba3efd6bca96338e10ffde557ba83920)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips64el-linux-gnuabi64
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ee73f14ee9eb7e1a04051b303b56130c4dd6e048
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout ee73f14ee9eb7e1a04051b303b56130c4dd6e048
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/irqchip/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/irqchip/irq-loongson-pch-lpc.c:151:13: warning: declaration of 'struct acpi_madt_lpc_pic' will not be visible outside of this function [-Wvisibility]
                                           struct acpi_madt_lpc_pic *acpi_pchlpc)
                                                  ^
   drivers/irqchip/irq-loongson-pch-lpc.c:164:34: error: incomplete definition of type 'struct acpi_madt_lpc_pic'
           priv->base = ioremap(acpi_pchlpc->address, acpi_pchlpc->size);
                                ~~~~~~~~~~~^
   arch/mips/include/asm/io.h:180:16: note: expanded from macro 'ioremap'
           ioremap_prot((offset), (size), _CACHE_UNCACHED)
                         ^~~~~~
   drivers/irqchip/irq-loongson-pch-lpc.c:151:13: note: forward declaration of 'struct acpi_madt_lpc_pic'
                                           struct acpi_madt_lpc_pic *acpi_pchlpc)
                                                  ^
   drivers/irqchip/irq-loongson-pch-lpc.c:164:56: error: incomplete definition of type 'struct acpi_madt_lpc_pic'
           priv->base = ioremap(acpi_pchlpc->address, acpi_pchlpc->size);
                                                      ~~~~~~~~~~~^
   arch/mips/include/asm/io.h:180:26: note: expanded from macro 'ioremap'
           ioremap_prot((offset), (size), _CACHE_UNCACHED)
                                   ^~~~
   drivers/irqchip/irq-loongson-pch-lpc.c:151:13: note: forward declaration of 'struct acpi_madt_lpc_pic'
                                           struct acpi_madt_lpc_pic *acpi_pchlpc)
                                                  ^
   drivers/irqchip/irq-loongson-pch-lpc.c:188:31: error: incomplete definition of type 'struct acpi_madt_lpc_pic'
           fwspec.param[0] = acpi_pchlpc->cascade + GSI_MIN_PCH_IRQ;
                             ~~~~~~~~~~~^
   drivers/irqchip/irq-loongson-pch-lpc.c:151:13: note: forward declaration of 'struct acpi_madt_lpc_pic'
                                           struct acpi_madt_lpc_pic *acpi_pchlpc)
                                                  ^
   drivers/irqchip/irq-loongson-pch-lpc.c:188:43: error: use of undeclared identifier 'GSI_MIN_PCH_IRQ'
           fwspec.param[0] = acpi_pchlpc->cascade + GSI_MIN_PCH_IRQ;
                                                    ^
>> drivers/irqchip/irq-loongson-pch-lpc.c:150:12: warning: no previous prototype for function 'pch_lpc_acpi_init' [-Wmissing-prototypes]
   int __init pch_lpc_acpi_init(struct irq_domain *parent,
              ^
   drivers/irqchip/irq-loongson-pch-lpc.c:150:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int __init pch_lpc_acpi_init(struct irq_domain *parent,
   ^
   static 
   2 warnings and 4 errors generated.


vim +151 drivers/irqchip/irq-loongson-pch-lpc.c

   149	
 > 150	int __init pch_lpc_acpi_init(struct irq_domain *parent,
 > 151						struct acpi_madt_lpc_pic *acpi_pchlpc)

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
