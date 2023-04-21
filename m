Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB8BB6EB54D
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 00:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233247AbjDUW7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 18:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbjDUW7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 18:59:30 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79A61984
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 15:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682117968; x=1713653968;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=BNH4RXrQEbbk+XIrvoTOK8UwfUDRDleaNE5QY9JbK2o=;
  b=FMzn8fJTviDcRedXEzNj9SF2OscbzEWVGh7ZyfjKjBTQSG70bR99DIZ/
   JNdyOcuMDH0nwMwMmFiUOqBhYavq0+U404okfbrrv+XVrBjSN3f8sFcAq
   QMmtJGEmKl1DvdKetM/nOnu2egJ7gRxL6hIioIynFh8IXCWYG3xZCFMBC
   35/H3NxuK4i+IczmgHXFSUkW+ClkgTT2qYKrXDeyAkxqzGyoCjx79b+c8
   dlJr65KScXoy3e0QKXSZ+AOUDOHJEMo2OoVQgKV0qo6fNk5jfyGbrI39c
   e8rZ4lQexo+WmGrZqZU1c0ECKpLVUdqSaTHFnW3th8BK0bKIHFb326Or5
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="343585371"
X-IronPort-AV: E=Sophos;i="5.99,216,1677571200"; 
   d="scan'208";a="343585371"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2023 15:59:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="866838297"
X-IronPort-AV: E=Sophos;i="5.99,216,1677571200"; 
   d="scan'208";a="866838297"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 21 Apr 2023 15:59:27 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ppziw-000gu4-10;
        Fri, 21 Apr 2023 22:59:26 +0000
Date:   Sat, 22 Apr 2023 06:59:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: arch/arm/mach-lpc32xx/serial.c:63:6: warning: no previous prototype
 for 'lpc32xx_loopback_set'
Message-ID: <202304220650.KSVbcJ8z-lkp@intel.com>
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

Hi Arnd,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   8e41e0a575664d26bb87e012c39435c4c3914ed9
commit: 250c1a694ff304e5d69e74ab32755eddcc2b8f65 ARM: pxa: convert to multiplatform
date:   12 months ago
config: arm-buildonly-randconfig-r004-20230421 (https://download.01.org/0day-ci/archive/20230422/202304220650.KSVbcJ8z-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=250c1a694ff304e5d69e74ab32755eddcc2b8f65
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 250c1a694ff304e5d69e74ab32755eddcc2b8f65
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304220650.KSVbcJ8z-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/arm/mach-lpc32xx/serial.c:63:6: warning: no previous prototype for 'lpc32xx_loopback_set' [-Wmissing-prototypes]
      63 | void lpc32xx_loopback_set(resource_size_t mapbase, int state)
         |      ^~~~~~~~~~~~~~~~~~~~


vim +/lpc32xx_loopback_set +63 arch/arm/mach-lpc32xx/serial.c

e6e912c4964ce5 Kevin Wells   2010-07-27  61  
ffba29c9ebd097 Arnd Bergmann 2019-08-09  62  /* LPC3250 Errata HSUART.1: Hang workaround via loopback mode on inactivity */
ffba29c9ebd097 Arnd Bergmann 2019-08-09 @63  void lpc32xx_loopback_set(resource_size_t mapbase, int state)
ffba29c9ebd097 Arnd Bergmann 2019-08-09  64  {
ffba29c9ebd097 Arnd Bergmann 2019-08-09  65  	int bit;
ffba29c9ebd097 Arnd Bergmann 2019-08-09  66  	u32 tmp;
ffba29c9ebd097 Arnd Bergmann 2019-08-09  67  
ffba29c9ebd097 Arnd Bergmann 2019-08-09  68  	switch (mapbase) {
ffba29c9ebd097 Arnd Bergmann 2019-08-09  69  	case LPC32XX_HS_UART1_BASE:
ffba29c9ebd097 Arnd Bergmann 2019-08-09  70  		bit = 0;
ffba29c9ebd097 Arnd Bergmann 2019-08-09  71  		break;
ffba29c9ebd097 Arnd Bergmann 2019-08-09  72  	case LPC32XX_HS_UART2_BASE:
ffba29c9ebd097 Arnd Bergmann 2019-08-09  73  		bit = 1;
ffba29c9ebd097 Arnd Bergmann 2019-08-09  74  		break;
ffba29c9ebd097 Arnd Bergmann 2019-08-09  75  	case LPC32XX_HS_UART7_BASE:
ffba29c9ebd097 Arnd Bergmann 2019-08-09  76  		bit = 6;
ffba29c9ebd097 Arnd Bergmann 2019-08-09  77  		break;
ffba29c9ebd097 Arnd Bergmann 2019-08-09  78  	default:
ffba29c9ebd097 Arnd Bergmann 2019-08-09  79  		WARN(1, "lpc32xx_hs: Warning: Unknown port at %08x\n", mapbase);
ffba29c9ebd097 Arnd Bergmann 2019-08-09  80  		return;
ffba29c9ebd097 Arnd Bergmann 2019-08-09  81  	}
ffba29c9ebd097 Arnd Bergmann 2019-08-09  82  
ffba29c9ebd097 Arnd Bergmann 2019-08-09  83  	tmp = readl(LPC32XX_UARTCTL_CLOOP);
ffba29c9ebd097 Arnd Bergmann 2019-08-09  84  	if (state)
ffba29c9ebd097 Arnd Bergmann 2019-08-09  85  		tmp |= (1 << bit);
ffba29c9ebd097 Arnd Bergmann 2019-08-09  86  	else
ffba29c9ebd097 Arnd Bergmann 2019-08-09  87  		tmp &= ~(1 << bit);
ffba29c9ebd097 Arnd Bergmann 2019-08-09  88  	writel(tmp, LPC32XX_UARTCTL_CLOOP);
ffba29c9ebd097 Arnd Bergmann 2019-08-09  89  }
ffba29c9ebd097 Arnd Bergmann 2019-08-09  90  EXPORT_SYMBOL_GPL(lpc32xx_loopback_set);
ffba29c9ebd097 Arnd Bergmann 2019-08-09  91  

:::::: The code at line 63 was first introduced by commit
:::::: ffba29c9ebd0977dbf77bf6064776716a51b8ae5 serial: lpc32xx: allow compile testing

:::::: TO: Arnd Bergmann <arnd@arndb.de>
:::::: CC: Arnd Bergmann <arnd@arndb.de>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
