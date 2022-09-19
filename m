Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7531D5BCBE0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 14:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbiISMet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 08:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbiISMek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 08:34:40 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD522E10
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 05:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663590874; x=1695126874;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=F9INIWy87wSUk9mvJiGDb+wN8kyqI52ZTRCI+zIhdJo=;
  b=enIk4AGtLSinzHDC3Wkso2CeocJrsE1M5+iJSPw1wvDpkMg55kwAxUw6
   CqePQSycnDlrL9oxg9yba3rZFk4O2BboI4N6SG9x6vHOg9yKNm8y2SRez
   O52a7ji8W2JQJVwRid978RoepclqpF5cdXa+yGxoNRq+oTsUtUOPcNk1z
   GOvhOV1ZuFxF3ePAKt2izFqW8qCRPSZvbGFuCPxDNveDt3NYJuzfy9Qpm
   /wv6IFEzrhZHw1upEK5hKcOGDWLb+V69KzGoEd7QKy+O0PthARGPcq7wm
   0Q+ybBx38cDHOm99a59UiIBt9PMIeTUu1fjVCvUDZCRjLNKoeMdXeRh/H
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="325678265"
X-IronPort-AV: E=Sophos;i="5.93,327,1654585200"; 
   d="scan'208";a="325678265"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 05:34:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,327,1654585200"; 
   d="scan'208";a="947201760"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 19 Sep 2022 05:34:32 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oaFyp-0001yP-1v;
        Mon, 19 Sep 2022 12:34:31 +0000
Date:   Mon, 19 Sep 2022 20:33:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: arch/arm/mach-at91/pm.c:775:30: sparse: sparse: incorrect type in
 assignment (different address spaces)
Message-ID: <202209192029.bdUnF66D-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   521a547ced6477c54b4b0cc206000406c221b4d6
commit: 09f6b27d5ddd9ad0ec096d1b0f8decdacc70f0f8 ARM: dove: multiplatform support
date:   6 months ago
config: arm-randconfig-s042-20220919 (https://download.01.org/0day-ci/archive/20220919/202209192029.bdUnF66D-lkp@intel.com/config)
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
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm SHELL=/bin/bash arch/arm/mach-at91/ arch/arm/mach-omap2/ arch/arm/mach-rockchip/ arch/arm/mach-s3c/ drivers/clk/ drivers/irqchip/ drivers/scsi/ kernel/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> arch/arm/mach-at91/pm.c:775:30: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void ( *static [assigned] [toplevel] at91_suspend_sram_fn )( ... ) @@     got void [noderef] __iomem * @@
   arch/arm/mach-at91/pm.c:775:30: sparse:     expected void ( *static [assigned] [toplevel] at91_suspend_sram_fn )( ... )
   arch/arm/mach-at91/pm.c:775:30: sparse:     got void [noderef] __iomem *
--
>> arch/arm/mach-rockchip/pm.c:277:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got void [noderef] __iomem *static [assigned] [toplevel] rk3288_bootram_base @@
   arch/arm/mach-rockchip/pm.c:277:16: sparse:     expected void *
   arch/arm/mach-rockchip/pm.c:277:16: sparse:     got void [noderef] __iomem *static [assigned] [toplevel] rk3288_bootram_base
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
>> drivers/clk/clk-stm32mp1.c:158:30: sparse: sparse: symbol 'ethrx_src' was not declared. Should it be static?
--
   drivers/irqchip/irq-gic.c:1177:44: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __percpu *[noderef] __iomem *percpu_base @@     got void [noderef] __iomem *[noderef] __percpu * @@
   drivers/irqchip/irq-gic.c:1177:44: sparse:     expected void [noderef] __percpu *[noderef] __iomem *percpu_base
   drivers/irqchip/irq-gic.c:1177:44: sparse:     got void [noderef] __iomem *[noderef] __percpu *
   drivers/irqchip/irq-gic.c:1178:43: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __percpu *[noderef] __iomem *percpu_base @@     got void [noderef] __iomem *[noderef] __percpu * @@
   drivers/irqchip/irq-gic.c:1178:43: sparse:     expected void [noderef] __percpu *[noderef] __iomem *percpu_base
   drivers/irqchip/irq-gic.c:1178:43: sparse:     got void [noderef] __iomem *[noderef] __percpu *
   drivers/irqchip/irq-gic.c:1189:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:1189:26: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:1189:26: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:1189:71: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __percpu * @@     got void [noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:1189:71: sparse:     expected void [noderef] __percpu *
   drivers/irqchip/irq-gic.c:1189:71: sparse:     got void [noderef] __iomem *
   drivers/irqchip/irq-gic.c:1191:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:1191:26: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:1191:26: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:1191:70: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __percpu * @@     got void [noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:1191:70: sparse:     expected void [noderef] __percpu *
   drivers/irqchip/irq-gic.c:1191:70: sparse:     got void [noderef] __iomem *
   drivers/irqchip/irq-gic.c:1257:43: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __percpu *__pdata @@     got void [noderef] __percpu *[noderef] __iomem *percpu_base @@
   drivers/irqchip/irq-gic.c:1257:43: sparse:     expected void [noderef] __percpu *__pdata
   drivers/irqchip/irq-gic.c:1257:43: sparse:     got void [noderef] __percpu *[noderef] __iomem *percpu_base
   drivers/irqchip/irq-gic.c:1258:42: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __percpu *__pdata @@     got void [noderef] __percpu *[noderef] __iomem *percpu_base @@
   drivers/irqchip/irq-gic.c:1258:42: sparse:     expected void [noderef] __percpu *__pdata
   drivers/irqchip/irq-gic.c:1258:42: sparse:     got void [noderef] __percpu *[noderef] __iomem *percpu_base
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
>> drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] __iomem * @@     got void [noderef] __percpu *[assigned] pscr_ret__ @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void [noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[assigned] pscr_ret__
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
>> drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] __iomem * @@     got void [noderef] __percpu *[assigned] pscr_ret__ @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void [noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[assigned] pscr_ret__
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
>> drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] __iomem * @@     got void [noderef] __percpu *[assigned] pscr_ret__ @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void [noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[assigned] pscr_ret__
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
>> drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] __iomem * @@     got void [noderef] __percpu *[assigned] pscr_ret__ @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void [noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[assigned] pscr_ret__
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
>> drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] __iomem * @@     got void [noderef] __percpu *[assigned] pscr_ret__ @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void [noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[assigned] pscr_ret__
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
>> drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] __iomem * @@     got void [noderef] __percpu *[assigned] pscr_ret__ @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void [noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[assigned] pscr_ret__
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
>> drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] __iomem * @@     got void [noderef] __percpu *[assigned] pscr_ret__ @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void [noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[assigned] pscr_ret__
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
>> drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] __iomem * @@     got void [noderef] __percpu *[assigned] pscr_ret__ @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void [noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[assigned] pscr_ret__
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
>> drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] __iomem * @@     got void [noderef] __percpu *[assigned] pscr_ret__ @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void [noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[assigned] pscr_ret__
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
>> drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] __iomem * @@     got void [noderef] __percpu *[assigned] pscr_ret__ @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void [noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[assigned] pscr_ret__
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
>> drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] __iomem * @@     got void [noderef] __percpu *[assigned] pscr_ret__ @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void [noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[assigned] pscr_ret__
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
>> drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] __iomem * @@     got void [noderef] __percpu *[assigned] pscr_ret__ @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void [noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[assigned] pscr_ret__
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
>> drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] __iomem * @@     got void [noderef] __percpu *[assigned] pscr_ret__ @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void [noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[assigned] pscr_ret__
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
>> drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] __iomem * @@     got void [noderef] __percpu *[assigned] pscr_ret__ @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void [noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[assigned] pscr_ret__
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
>> drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] __iomem * @@     got void [noderef] __percpu *[assigned] pscr_ret__ @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void [noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[assigned] pscr_ret__
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void [noderef] __percpu *[noderef] __iomem * @@
   drivers/irqchip/irq-gic.c:139:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/irqchip/irq-gic.c:139:24: sparse:     got void [noderef] __percpu *[noderef] __iomem *
   drivers/irqchip/irq-gic.c:139:24: sparse: sparse: too many warnings

vim +775 arch/arm/mach-at91/pm.c

ab6778eee51b72 Ben Dooks          2016-06-17  726  static void at91rm9200_idle(void)
fbc7edca5a7dd4 Alexandre Belloni  2015-09-30  727  {
fbc7edca5a7dd4 Alexandre Belloni  2015-09-30  728  	/*
fbc7edca5a7dd4 Alexandre Belloni  2015-09-30  729  	 * Disable the processor clock.  The processor will be automatically
fbc7edca5a7dd4 Alexandre Belloni  2015-09-30  730  	 * re-enabled by an interrupt or by a reset.
fbc7edca5a7dd4 Alexandre Belloni  2015-09-30  731  	 */
c3f5b8fde71f6a Claudiu Beznea     2019-02-14  732  	writel(AT91_PMC_PCK, soc_pm.data.pmc + AT91_PMC_SCDR);
fbc7edca5a7dd4 Alexandre Belloni  2015-09-30  733  }
fbc7edca5a7dd4 Alexandre Belloni  2015-09-30  734  
ab6778eee51b72 Ben Dooks          2016-06-17  735  static void at91sam9_idle(void)
fbc7edca5a7dd4 Alexandre Belloni  2015-09-30  736  {
c3f5b8fde71f6a Claudiu Beznea     2019-02-14  737  	writel(AT91_PMC_PCK, soc_pm.data.pmc + AT91_PMC_SCDR);
fbc7edca5a7dd4 Alexandre Belloni  2015-09-30  738  	cpu_do_idle();
fbc7edca5a7dd4 Alexandre Belloni  2015-09-30  739  }
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

:::::: The code at line 775 was first introduced by commit
:::::: 5726a8b9686348e8d203f1bbf9d5fc1bb5899518 ARM: at91/pm: rename function name: at91_slow_clock() --> at91_pm_suspend_sram_fn()

:::::: TO: Wenyou Yang <wenyou.yang@atmel.com>
:::::: CC: Nicolas Ferre <nicolas.ferre@atmel.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
