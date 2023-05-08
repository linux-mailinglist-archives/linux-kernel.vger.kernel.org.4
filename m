Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A816B6FB600
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 19:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233792AbjEHRgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 13:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233491AbjEHRgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 13:36:00 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C6F5FC3;
        Mon,  8 May 2023 10:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683567359; x=1715103359;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=e1JmpXn99KX4PvxeQe9Giaqhj7Jo074wNTWAfE5wjzc=;
  b=G88Q3z86GauvSEPV3rOLc1+5jx2dejyFsiWD2w9c6Z63kRHq9rYeGr1h
   KkoXMhtCJnb6bPf4JCJy/+AGlIsUfOSDnttSyzwFnS6y7fZXW+7t/1oan
   2SlGIJWAm1cbo8eN/hiGjkezmhdQdVxKstOPwDCxmxNUO+34kN11ldAn2
   hsDPW0dMUhalKjB4IHKcEQaOdDZEhTByEV46Nvt+tkPSAYpdCTGnY4FBA
   u2VWbrWRlTtLM8WY2cVL8aOBiFxSkUJSzVFDIwK9mGgLP9m8IDWPRw9mG
   jhAJO0Zfp5fxoTJaNBDUDdW1YiQL7ZM1rkYCWvXnkNlb+xYn6NzKwCB45
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="334156694"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="334156694"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 10:35:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="768159934"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="768159934"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 08 May 2023 10:35:38 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pw4lt-0001LV-1z;
        Mon, 08 May 2023 17:35:37 +0000
Date:   Tue, 9 May 2023 01:35:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bharat Bhushan <bbhushan2@marvell.com>, wim@linux-watchdog.org,
        linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        sgoutham@marvell.com
Cc:     oe-kbuild-all@lists.linux.dev,
        Bharat Bhushan <bbhushan2@marvell.com>
Subject: Re: [PATCH 2/2 v7] Watchdog: Add marvell GTI watchdog driver
Message-ID: <202305090120.Ji2xbrTK-lkp@intel.com>
References: <20230508131515.19403-2-bbhushan2@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230508131515.19403-2-bbhushan2@marvell.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bharat,

kernel test robot noticed the following build errors:

[auto build test ERROR on robh/for-next]
[also build test ERROR on groeck-staging/hwmon-next linus/master v6.4-rc1 next-20230508]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Bharat-Bhushan/Watchdog-Add-marvell-GTI-watchdog-driver/20230508-211645
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20230508131515.19403-2-bbhushan2%40marvell.com
patch subject: [PATCH 2/2 v7] Watchdog: Add marvell GTI watchdog driver
config: sparc-allyesconfig (https://download.01.org/0day-ci/archive/20230509/202305090120.Ji2xbrTK-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/0b1fbcf987da442c837b205256c6400adf6d298e
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Bharat-Bhushan/Watchdog-Add-marvell-GTI-watchdog-driver/20230508-211645
        git checkout 0b1fbcf987da442c837b205256c6400adf6d298e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sparc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sparc SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305090120.Ji2xbrTK-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/watchdog/marvell_gti_wdt.c: In function 'gti_wdt_interrupt':
>> drivers/watchdog/marvell_gti_wdt.c:89:9: error: implicit declaration of function 'writeq' [-Werror=implicit-function-declaration]
      89 |         writeq(GTI_CWD_INT_PENDING_STATUS(priv->wdt_timer_idx),
         |         ^~~~~~
   drivers/watchdog/marvell_gti_wdt.c: In function 'gti_wdt_start':
>> drivers/watchdog/marvell_gti_wdt.c:126:18: error: implicit declaration of function 'readq' [-Werror=implicit-function-declaration]
     126 |         regval = readq(priv->base + GTI_CWD_WDOG(priv->wdt_timer_idx));
         |                  ^~~~~
   cc1: some warnings being treated as errors


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
