Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D729A6C9804
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 23:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbjCZVZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 17:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjCZVZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 17:25:56 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175861701
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 14:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679865955; x=1711401955;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=klFg1rTB6lgpLYoVDipAOSZrfAGFtIkpayfXE0udZvs=;
  b=c5x0iV0N0Kkr8ynSmBm9G84wCl43VG4NN3x4HSsHfw+Jm++xhEzRMsvD
   rWuEt9FBOkEY5rWE00unabwHROHG/JSNQZLN80imuSfdt8MRO0wIeJg95
   OUxDWm35Jon8ARMjAtoWKwseMC18vBQ+E20bz8I4pxXQhGTjuXQVXHtzd
   3AyX7X7y7IxMRUIYkZlMayO55C6oXhQJc+MBJaZkMujzjmYai5mc1UXZZ
   Lur6HKyaf7yX21kItyJ/7nbTakELbpZlKLMIbKIW4WKrjVnqipy6JAjWe
   MQAx4mnMS6onlMmhgt8CjN3FvUG9347QQSjZF8sGchwl2IbOOSVEI4Cqb
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="340158542"
X-IronPort-AV: E=Sophos;i="5.98,293,1673942400"; 
   d="scan'208";a="340158542"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2023 14:25:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="676764241"
X-IronPort-AV: E=Sophos;i="5.98,293,1673942400"; 
   d="scan'208";a="676764241"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 26 Mar 2023 14:25:52 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pgXs8-000HN5-0L;
        Sun, 26 Mar 2023 21:25:52 +0000
Date:   Mon, 27 Mar 2023 05:25:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: drivers/media/i2c/tc358746.c:817:13: warning: 'p_best' is used
 uninitialized
Message-ID: <202303270506.UifKK4hb-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marco,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0ec57cfa721fbd36b4c4c0d9ccc5d78a78f7fa35
commit: 80a21da360516fa602f3a50eb9792f9dfbfb5fdb media: tc358746: add Toshiba TC358746 Parallel to CSI-2 bridge driver
date:   5 months ago
config: arc-randconfig-r021-20230327 (https://download.01.org/0day-ci/archive/20230327/202303270506.UifKK4hb-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=80a21da360516fa602f3a50eb9792f9dfbfb5fdb
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 80a21da360516fa602f3a50eb9792f9dfbfb5fdb
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash drivers/media/i2c/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303270506.UifKK4hb-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/media/i2c/tc358746.c: In function 'tc358746_find_pll_settings':
>> drivers/media/i2c/tc358746.c:817:13: warning: 'p_best' is used uninitialized [-Wuninitialized]
     817 |         u16 p_best, p;
         |             ^~~~~~
>> drivers/media/i2c/tc358746.c:816:13: warning: 'm_best' is used uninitialized [-Wuninitialized]
     816 |         u16 m_best, mul;
         |             ^~~~~~


vim +/p_best +817 drivers/media/i2c/tc358746.c

   805	
   806	static unsigned long tc358746_find_pll_settings(struct tc358746 *tc358746,
   807							unsigned long refclk,
   808							unsigned long fout)
   809	
   810	{
   811		struct device *dev = tc358746->sd.dev;
   812		unsigned long best_freq = 0;
   813		u32 min_delta = 0xffffffff;
   814		u16 prediv_max = 17;
   815		u16 prediv_min = 1;
 > 816		u16 m_best, mul;
 > 817		u16 p_best, p;
   818		u8 postdiv;
   819	
   820		if (fout > 1000 * HZ_PER_MHZ) {
   821			dev_err(dev, "HS-Clock above 1 Ghz are not supported\n");
   822			return 0;
   823		}
   824	
   825		if (fout >= 500 * HZ_PER_MHZ)
   826			postdiv = 1;
   827		else if (fout >= 250 * HZ_PER_MHZ)
   828			postdiv = 2;
   829		else if (fout >= 125 * HZ_PER_MHZ)
   830			postdiv = 4;
   831		else
   832			postdiv = 8;
   833	
   834		for (p = prediv_min; p <= prediv_max; p++) {
   835			unsigned long delta, fin;
   836			u64 tmp;
   837	
   838			fin = DIV_ROUND_CLOSEST(refclk, p);
   839			if (fin < 4 * HZ_PER_MHZ || fin > 40 * HZ_PER_MHZ)
   840				continue;
   841	
   842			tmp = fout * p * postdiv;
   843			do_div(tmp, fin);
   844			mul = tmp;
   845			if (mul > 511)
   846				continue;
   847	
   848			tmp = mul * fin;
   849			do_div(tmp, p * postdiv);
   850	
   851			delta = abs(fout - tmp);
   852			if (delta < min_delta) {
   853				p_best = p;
   854				m_best = mul;
   855				min_delta = delta;
   856				best_freq = tmp;
   857			};
   858	
   859			if (delta == 0)
   860				break;
   861		};
   862	
   863		if (!best_freq) {
   864			dev_err(dev, "Failed find PLL frequency\n");
   865			return 0;
   866		}
   867	
   868		tc358746->pll_post_div = postdiv;
   869		tc358746->pll_pre_div = p_best;
   870		tc358746->pll_mul = m_best;
   871	
   872		if (best_freq != fout)
   873			dev_warn(dev, "Request PLL freq:%lu, found PLL freq:%lu\n",
   874				 fout, best_freq);
   875	
   876		dev_dbg(dev, "Found PLL settings: freq:%lu prediv:%u multi:%u postdiv:%u\n",
   877			best_freq, p_best, m_best, postdiv);
   878	
   879		return best_freq;
   880	}
   881	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
