Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC027135A2
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 18:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbjE0QNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 12:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbjE0QNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 12:13:12 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF30DE4;
        Sat, 27 May 2023 09:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685203989; x=1716739989;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EDxDfGbnxz7XwsTpPsRv+ZA+4CNV0OhPsz+82L11lMA=;
  b=Qp0Dcr4DVOvzZc58dD+6n+rE3l0RfpPm9Yug+woaDaTlob0Yzw7yif+D
   P3J6V9Nem1c2X1QjCfV06KQQdCZ9wp/vEI9bdSnGlgslLqyniYDL9ofQv
   Vet7Nvc+SictsiqzTiGnJYsRDTZEzuCPfKQvznJzhXibZu92aKX6TqZFi
   fKS9uoPMTtajsvTDrT0XEH0WEdw4cnginP7EDIgEHeDyBV78jXWMWfQMI
   /G2juzHJ0cNvS4lgscLCa3UZlISKpNodbAmukS1f/4tvh26OaQY8vzYza
   y0zdNTFjg9/2X2m4kghY5aoM3xo14kHIqbkNHip8rKafGkXYvetgcfc0z
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10723"; a="356796425"
X-IronPort-AV: E=Sophos;i="6.00,197,1681196400"; 
   d="scan'208";a="356796425"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2023 09:13:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10723"; a="1035682342"
X-IronPort-AV: E=Sophos;i="6.00,197,1681196400"; 
   d="scan'208";a="1035682342"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 27 May 2023 09:13:06 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q2wXS-000K3S-0o;
        Sat, 27 May 2023 16:13:06 +0000
Date:   Sun, 28 May 2023 00:12:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bharat Bhushan <bbhushan2@marvell.com>, wim@linux-watchdog.org,
        linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        sgoutham@marvell.com
Cc:     oe-kbuild-all@lists.linux.dev,
        Bharat Bhushan <bbhushan2@marvell.com>
Subject: Re: [PATCH 2/2 v8] Watchdog: Add marvell GTI watchdog driver
Message-ID: <202305280038.Fo8aOfsW-lkp@intel.com>
References: <20230526062626.1180-2-bbhushan2@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230526062626.1180-2-bbhushan2@marvell.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bharat,

kernel test robot noticed the following build errors:

[auto build test ERROR on robh/for-next]
[also build test ERROR on groeck-staging/hwmon-next linus/master v6.4-rc3 next-20230525]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Bharat-Bhushan/Watchdog-Add-marvell-GTI-watchdog-driver/20230526-142851
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20230526062626.1180-2-bbhushan2%40marvell.com
patch subject: [PATCH 2/2 v8] Watchdog: Add marvell GTI watchdog driver
config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20230528/202305280038.Fo8aOfsW-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/b5f326e7e3943850db45d2f06d737dc9ac37a575
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Bharat-Bhushan/Watchdog-Add-marvell-GTI-watchdog-driver/20230526-142851
        git checkout b5f326e7e3943850db45d2f06d737dc9ac37a575
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 ~/bin/make.cross W=1 O=build_dir ARCH=s390 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 ~/bin/make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202305280038.Fo8aOfsW-lkp@intel.com/

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
https://github.com/intel/lkp-tests/wiki
