Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23BEC6FC2F8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 11:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234716AbjEIJie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 05:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234621AbjEIJiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 05:38:21 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D4F34225;
        Tue,  9 May 2023 02:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683625099; x=1715161099;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=U1tu/Ou4injYrbKydLUxfBy7dyxZrBMFc9DZnhXqJmY=;
  b=iE7+6ttEOB9f0f0h5J1sjbc0YwG7lff7OEwScAgNXk43X5W0HpFLsP2Z
   DAkCLKTJ4Zy8IRU98c11F05Wxv8zwIJc46d85FaEyhlm9fsTMQNXYktjn
   8aRTgLsVAj44rqi6Srz1kyR7wpX8BnPvusCKNXalbfM3P5TX23mf4XxTl
   bbqmK04VCDS+KtkCzl8cLgPCgXf1vd2U15k5IAqn4W6mznl5EwWaMh0Jf
   gtyokcGkSxGDNDzypu1RDjRthZSoZLNMaA0OrZGQw1aa9Gws0l5OHuqs5
   a0j4hJlTTtzR09Jo15XfJQ9HZ+FQXN6O1X5b6Se8an6OTXsNOWqSKtZeR
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="436192420"
X-IronPort-AV: E=Sophos;i="5.99,261,1677571200"; 
   d="scan'208";a="436192420"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2023 02:38:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="768432339"
X-IronPort-AV: E=Sophos;i="5.99,261,1677571200"; 
   d="scan'208";a="768432339"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 09 May 2023 02:36:51 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pwJm7-00021I-0F;
        Tue, 09 May 2023 09:36:51 +0000
Date:   Tue, 9 May 2023 17:36:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bharat Bhushan <bbhushan2@marvell.com>, wim@linux-watchdog.org,
        linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        sgoutham@marvell.com
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Bharat Bhushan <bbhushan2@marvell.com>
Subject: Re: [PATCH 2/2 v7] Watchdog: Add marvell GTI watchdog driver
Message-ID: <202305091728.1XZ6IePZ-lkp@intel.com>
References: <20230508131515.19403-2-bbhushan2@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230508131515.19403-2-bbhushan2@marvell.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bharat,

kernel test robot noticed the following build errors:

[auto build test ERROR on robh/for-next]
[also build test ERROR on groeck-staging/hwmon-next linus/master v6.4-rc1 next-20230509]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Bharat-Bhushan/Watchdog-Add-marvell-GTI-watchdog-driver/20230508-211645
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20230508131515.19403-2-bbhushan2%40marvell.com
patch subject: [PATCH 2/2 v7] Watchdog: Add marvell GTI watchdog driver
config: hexagon-randconfig-r015-20230508 (https://download.01.org/0day-ci/archive/20230509/202305091728.1XZ6IePZ-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project b0fb98227c90adf2536c9ad644a74d5e92961111)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/0b1fbcf987da442c837b205256c6400adf6d298e
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Bharat-Bhushan/Watchdog-Add-marvell-GTI-watchdog-driver/20230508-211645
        git checkout 0b1fbcf987da442c837b205256c6400adf6d298e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/watchdog/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305091728.1XZ6IePZ-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/watchdog/marvell_gti_wdt.c:8:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
                                                     ^
   In file included from drivers/watchdog/marvell_gti_wdt.c:8:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
                                                     ^
   In file included from drivers/watchdog/marvell_gti_wdt.c:8:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
>> drivers/watchdog/marvell_gti_wdt.c:89:2: error: call to undeclared function 'writeq'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           writeq(GTI_CWD_INT_PENDING_STATUS(priv->wdt_timer_idx),
           ^
   drivers/watchdog/marvell_gti_wdt.c:101:2: error: call to undeclared function 'writeq'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           writeq(GTI_CWD_POKE_VAL,
           ^
   drivers/watchdog/marvell_gti_wdt.c:118:2: error: call to undeclared function 'writeq'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           writeq(GTI_CWD_INT_PENDING_STATUS(priv->wdt_timer_idx),
           ^
>> drivers/watchdog/marvell_gti_wdt.c:126:11: error: call to undeclared function 'readq'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           regval = readq(priv->base + GTI_CWD_WDOG(priv->wdt_timer_idx));
                    ^
   drivers/watchdog/marvell_gti_wdt.c:139:2: error: call to undeclared function 'writeq'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           writeq(GTI_CWD_INT_ENA_CLR_VAL(priv->wdt_timer_idx),
           ^
   drivers/watchdog/marvell_gti_wdt.c:143:11: error: call to undeclared function 'readq'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           regval = readq(priv->base + GTI_CWD_WDOG(priv->wdt_timer_idx));
                    ^
   drivers/watchdog/marvell_gti_wdt.c:177:11: error: call to undeclared function 'readq'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           regval = readq(priv->base + GTI_CWD_WDOG(priv->wdt_timer_idx));
                    ^
   drivers/watchdog/marvell_gti_wdt.c:181:2: error: call to undeclared function 'writeq'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           writeq(regval, priv->base + GTI_CWD_WDOG(priv->wdt_timer_idx));
           ^
   6 warnings and 8 errors generated.


vim +/writeq +89 drivers/watchdog/marvell_gti_wdt.c

    82	
    83	static irqreturn_t gti_wdt_interrupt(int irq, void *data)
    84	{
    85		struct watchdog_device *wdev = data;
    86		struct gti_wdt_priv *priv = watchdog_get_drvdata(wdev);
    87	
    88		/* Clear Interrupt Pending Status */
  > 89		writeq(GTI_CWD_INT_PENDING_STATUS(priv->wdt_timer_idx),
    90		       priv->base + GTI_CWD_INT);
    91	
    92		watchdog_notify_pretimeout(wdev);
    93	
    94		return IRQ_HANDLED;
    95	}
    96	
    97	static int gti_wdt_ping(struct watchdog_device *wdev)
    98	{
    99		struct gti_wdt_priv *priv = watchdog_get_drvdata(wdev);
   100	
   101		writeq(GTI_CWD_POKE_VAL,
   102		       priv->base + GTI_CWD_POKE(priv->wdt_timer_idx));
   103	
   104		return 0;
   105	}
   106	
   107	static int gti_wdt_start(struct watchdog_device *wdev)
   108	{
   109		struct gti_wdt_priv *priv = watchdog_get_drvdata(wdev);
   110		u64 regval;
   111	
   112		if (!wdev->pretimeout)
   113			return -EINVAL;
   114	
   115		set_bit(WDOG_HW_RUNNING, &wdev->status);
   116	
   117		/* Clear any pending interrupt */
   118		writeq(GTI_CWD_INT_PENDING_STATUS(priv->wdt_timer_idx),
   119		       priv->base + GTI_CWD_INT);
   120	
   121		/* Enable Interrupt */
   122		writeq(GTI_CWD_INT_ENA_SET_VAL(priv->wdt_timer_idx),
   123		       priv->base + GTI_CWD_INT_ENA_SET);
   124	
   125		/* Set (Interrupt + SCP interrupt (DEL3T) + core domain reset) Mode */
 > 126		regval = readq(priv->base + GTI_CWD_WDOG(priv->wdt_timer_idx));
   127		regval |= GTI_CWD_WDOG_MODE_INT_DEL3T_RST;
   128		writeq(regval, priv->base + GTI_CWD_WDOG(priv->wdt_timer_idx));
   129	
   130		return 0;
   131	}
   132	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
