Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E87369AB98
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 13:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbjBQMeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 07:34:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjBQMeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 07:34:03 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66EF44BE8E;
        Fri, 17 Feb 2023 04:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676637241; x=1708173241;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QDyuOP+tZvIeH79l24+NLcv2/d9Vib5IAkK6RXeGeNg=;
  b=cwRdtDt02HxcMr/oy6wNvpz9/9ZVR6RzxI9FekIbaZchlNpGIORQT+na
   D2OwcGsC+ES15+VwGFoY9ygbkkXwpYPGaoupYu/F5O7rgIS+z/PKi2hTT
   Iuov2cdVM9sbNV002A8eVVJ07SVDP6NLACdDEzb4ekK+5GYNG9nYG729u
   rAj9PjAaZFup5fj38xSvR3X2FjnvHtfsMQBlN9tyeHk0Wjz0rdEuBHAPH
   cdhzuJolZtWpESUFiYWKmsuzhLzCqOvR1fccHbvLpYZxBA5XwOweCYAQf
   BQLfHFBFAQqlanORTIYfS/Gz61c1npkyXU71U59ggI5/QBb2SDZar6FyS
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="312342589"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="312342589"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2023 04:33:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="844563676"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="844563676"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 17 Feb 2023 04:33:12 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pSzvL-000BS5-1X;
        Fri, 17 Feb 2023 12:33:11 +0000
Date:   Fri, 17 Feb 2023 20:32:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>,
        gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, ilpo.jarvinen@linux.intel.com,
        l.sanfilippo@kunbus.com, andy.shevchenko@gmail.com,
        peter_hong@fintek.com.tw, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
Subject: Re: [PATCH] serial: 8250_fintek: Add using BIOS IRQ default setting
Message-ID: <202302172031.t1Y23hRe-lkp@intel.com>
References: <20230217084953.2580-1-hpeter+linux_kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230217084953.2580-1-hpeter+linux_kernel@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ji-Ze,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on tty/tty-testing]
[also build test ERROR on tty/tty-next tty/tty-linus usb/usb-testing usb/usb-next usb/usb-linus linus/master v6.2-rc8]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ji-Ze-Hong-Peter-Hong/serial-8250_fintek-Add-using-BIOS-IRQ-default-setting/20230217-165155
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
patch link:    https://lore.kernel.org/r/20230217084953.2580-1-hpeter%2Blinux_kernel%40gmail.com
patch subject: [PATCH] serial: 8250_fintek: Add using BIOS IRQ default setting
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20230217/202302172031.t1Y23hRe-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/fd786fba8247c675fb90d00d076235cbd85842e6
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Ji-Ze-Hong-Peter-Hong/serial-8250_fintek-Add-using-BIOS-IRQ-default-setting/20230217-165155
        git checkout fd786fba8247c675fb90d00d076235cbd85842e6
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/tty/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302172031.t1Y23hRe-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/tty/serial/8250/8250_fintek.c:121:13: error: expected declaration specifiers or '...' before string constant
     121 | early_param("fintek_uart_irq_mode_override", parse_uart_irq_mode_override);
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/tty/serial/8250/8250_fintek.c:121:46: error: expected declaration specifiers or '...' before 'parse_uart_irq_mode_override'
     121 | early_param("fintek_uart_irq_mode_override", parse_uart_irq_mode_override);
         |                                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/tty/serial/8250/8250_fintek.c:107:19: warning: 'parse_uart_irq_mode_override' defined but not used [-Wunused-function]
     107 | static int __init parse_uart_irq_mode_override(char *arg)
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +121 drivers/tty/serial/8250/8250_fintek.c

   106	
   107	static int __init parse_uart_irq_mode_override(char *arg)
   108	{
   109		if (!arg)
   110			return -EINVAL;
   111	
   112		if (strcmp(arg, "bios") == 0)
   113			not_override_irq_mode = FINTEK_IRQ_MODE_BY_BIOS;
   114		else if (strcmp(arg, "default") == 0)
   115			not_override_irq_mode = FINTEK_IRQ_MODE_BY_DETECT;
   116		else
   117			return -EINVAL;
   118	
   119		return 0;
   120	}
 > 121	early_param("fintek_uart_irq_mode_override", parse_uart_irq_mode_override);
   122	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
