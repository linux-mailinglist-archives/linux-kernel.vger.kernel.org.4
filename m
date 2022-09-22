Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2559B5E598B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 05:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbiIVDV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 23:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbiIVDV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 23:21:26 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD15B2CE0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 20:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663816563; x=1695352563;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=WDQYd5NoPzJU06WFgr960N6AUT6WCRXurMT8EYj8CwQ=;
  b=D/qHnCqfdPwIVUMW85Ptj0gQns3N6IFTa+fQFOIShpIf5liD3i0iGpVT
   mMXdxrGcp9l/B4Rd+Kjr0vyNug4l0d2APBGI9ksXM0GokDUTphYmBH5Az
   v9iU6C5xo/28WQ/frRJdl1tUmz8USCQoKVAwwMqodSd7nVyvBL0N8AER8
   SIBE1gNC7ZsxmjjL8Odfb8tOOXWXhv0NF6B4BQnReAby6P7foho08jQxs
   SvaloQqU1Jkl2AW5WbLsXt5zf1aSqVvBhbYz8cthnW6QMLst1hrsQPH+X
   p1eaaHWiVqFzz4wO6HhMyz+IPrXcv8EDYQf6uNx+k/IbRUQvLhj6R0s1i
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="287262330"
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="287262330"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 20:15:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="597257824"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 21 Sep 2022 20:15:57 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1obCgv-0004FA-0D;
        Thu, 22 Sep 2022 03:15:57 +0000
Date:   Thu, 22 Sep 2022 11:15:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: arch/arm/mach-mmp/pm-pxa910.c:132:6: warning: no previous prototype
 for 'pxa910_pm_enter_lowpower_mode'
Message-ID: <202209221119.rhKR3xdI-lkp@intel.com>
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

Hi Arnd,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   dc164f4fb00a0abebdfff132f8bc7291a28f5401
commit: a3102fafdce6f150e5a46e1725bb1732f8953a01 ARM: iop32x: enable multiplatform support
date:   6 months ago
config: arm-randconfig-r036-20220921 (https://download.01.org/0day-ci/archive/20220922/202209221119.rhKR3xdI-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a3102fafdce6f150e5a46e1725bb1732f8953a01
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout a3102fafdce6f150e5a46e1725bb1732f8953a01
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/arm/mach-mmp/pm-pxa910.c:132:6: warning: no previous prototype for 'pxa910_pm_enter_lowpower_mode' [-Wmissing-prototypes]
     132 | void pxa910_pm_enter_lowpower_mode(int state)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/pxa910_pm_enter_lowpower_mode +132 arch/arm/mach-mmp/pm-pxa910.c

902ca2297180fe Chao Xie            2012-05-07  131  
902ca2297180fe Chao Xie            2012-05-07 @132  void pxa910_pm_enter_lowpower_mode(int state)
902ca2297180fe Chao Xie            2012-05-07  133  {
902ca2297180fe Chao Xie            2012-05-07  134  	uint32_t idle_cfg, apcr;
902ca2297180fe Chao Xie            2012-05-07  135  
902ca2297180fe Chao Xie            2012-05-07  136  	idle_cfg = __raw_readl(APMU_MOH_IDLE_CFG);
902ca2297180fe Chao Xie            2012-05-07  137  	apcr = __raw_readl(MPMU_APCR);
902ca2297180fe Chao Xie            2012-05-07  138  
902ca2297180fe Chao Xie            2012-05-07  139  	apcr &= ~(MPMU_APCR_DDRCORSD | MPMU_APCR_APBSD | MPMU_APCR_AXISD
902ca2297180fe Chao Xie            2012-05-07  140  		| MPMU_APCR_VCTCXOSD | MPMU_APCR_STBYEN);
902ca2297180fe Chao Xie            2012-05-07  141  	idle_cfg &= ~(APMU_MOH_IDLE_CFG_MOH_IDLE
902ca2297180fe Chao Xie            2012-05-07  142  		| APMU_MOH_IDLE_CFG_MOH_PWRDWN);
902ca2297180fe Chao Xie            2012-05-07  143  
902ca2297180fe Chao Xie            2012-05-07  144  	switch (state) {
902ca2297180fe Chao Xie            2012-05-07  145  	case POWER_MODE_UDR:
902ca2297180fe Chao Xie            2012-05-07  146  		/* only shutdown APB in UDR */
902ca2297180fe Chao Xie            2012-05-07  147  		apcr |= MPMU_APCR_STBYEN | MPMU_APCR_APBSD;
df561f6688fef7 Gustavo A. R. Silva 2020-08-23  148  		fallthrough;
902ca2297180fe Chao Xie            2012-05-07  149  	case POWER_MODE_SYS_SLEEP:
902ca2297180fe Chao Xie            2012-05-07  150  		apcr |= MPMU_APCR_SLPEN;		/* set the SLPEN bit */
902ca2297180fe Chao Xie            2012-05-07  151  		apcr |= MPMU_APCR_VCTCXOSD;		/* set VCTCXOSD */
df561f6688fef7 Gustavo A. R. Silva 2020-08-23  152  		fallthrough;
902ca2297180fe Chao Xie            2012-05-07  153  	case POWER_MODE_APPS_SLEEP:
902ca2297180fe Chao Xie            2012-05-07  154  		apcr |= MPMU_APCR_DDRCORSD;		/* set DDRCORSD */
df561f6688fef7 Gustavo A. R. Silva 2020-08-23  155  		fallthrough;
902ca2297180fe Chao Xie            2012-05-07  156  	case POWER_MODE_APPS_IDLE:
902ca2297180fe Chao Xie            2012-05-07  157  		apcr |= MPMU_APCR_AXISD;		/* set AXISDD bit */
df561f6688fef7 Gustavo A. R. Silva 2020-08-23  158  		fallthrough;
902ca2297180fe Chao Xie            2012-05-07  159  	case POWER_MODE_CORE_EXTIDLE:
902ca2297180fe Chao Xie            2012-05-07  160  		idle_cfg |= APMU_MOH_IDLE_CFG_MOH_IDLE;
902ca2297180fe Chao Xie            2012-05-07  161  		idle_cfg |= APMU_MOH_IDLE_CFG_MOH_PWRDWN;
902ca2297180fe Chao Xie            2012-05-07  162  		idle_cfg |= APMU_MOH_IDLE_CFG_MOH_PWR_SW(3)
902ca2297180fe Chao Xie            2012-05-07  163  			| APMU_MOH_IDLE_CFG_MOH_L2_PWR_SW(3);
df561f6688fef7 Gustavo A. R. Silva 2020-08-23  164  		fallthrough;
902ca2297180fe Chao Xie            2012-05-07  165  	case POWER_MODE_CORE_INTIDLE:
902ca2297180fe Chao Xie            2012-05-07  166  		break;
902ca2297180fe Chao Xie            2012-05-07  167  	}
902ca2297180fe Chao Xie            2012-05-07  168  
902ca2297180fe Chao Xie            2012-05-07  169  	/* program the memory controller hardware sleep type and auto wakeup */
902ca2297180fe Chao Xie            2012-05-07  170  	idle_cfg |= APMU_MOH_IDLE_CFG_MOH_DIS_MC_SW_REQ;
902ca2297180fe Chao Xie            2012-05-07  171  	idle_cfg |= APMU_MOH_IDLE_CFG_MOH_MC_WAKE_EN;
902ca2297180fe Chao Xie            2012-05-07  172  	__raw_writel(0x0, APMU_MC_HW_SLP_TYPE);		/* auto refresh */
902ca2297180fe Chao Xie            2012-05-07  173  
902ca2297180fe Chao Xie            2012-05-07  174  	/* set DSPSD, DTCMSD, BBSD, MSASLPEN */
902ca2297180fe Chao Xie            2012-05-07  175  	apcr |= MPMU_APCR_DSPSD | MPMU_APCR_DTCMSD | MPMU_APCR_BBSD
902ca2297180fe Chao Xie            2012-05-07  176  		| MPMU_APCR_MSASLPEN;
902ca2297180fe Chao Xie            2012-05-07  177  
902ca2297180fe Chao Xie            2012-05-07  178  	/*always set SLEPEN bit mainly for MSA*/
902ca2297180fe Chao Xie            2012-05-07  179  	apcr |= MPMU_APCR_SLPEN;
902ca2297180fe Chao Xie            2012-05-07  180  
902ca2297180fe Chao Xie            2012-05-07  181  	/* finally write the registers back */
902ca2297180fe Chao Xie            2012-05-07  182  	__raw_writel(idle_cfg, APMU_MOH_IDLE_CFG);
902ca2297180fe Chao Xie            2012-05-07  183  	__raw_writel(apcr, MPMU_APCR);
902ca2297180fe Chao Xie            2012-05-07  184  

:::::: The code at line 132 was first introduced by commit
:::::: 902ca2297180fe97f840427c114cc6dc7e77375e ARM: mmp: add pm support for pxa910

:::::: TO: Chao Xie <chao.xie@marvell.com>
:::::: CC: Haojian Zhuang <haojian.zhuang@gmail.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
