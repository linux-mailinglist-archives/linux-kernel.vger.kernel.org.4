Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 795426AF8FF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 23:38:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbjCGWig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 17:38:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231753AbjCGWiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 17:38:16 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44CD3AF69F
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 14:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678228652; x=1709764652;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rZ3c8+SfbUn5SnrzPXv/QMzk7aoCjx/eMAVVxoN89bM=;
  b=GmXb2GZLWNcPBhauV8MLNA4mxKCkwtaZu0m0KuaYEDHNubu77+G88VYf
   wDlmVDuRjM1EArmxGKMovxWa9DjQwYiPiufKB2W8B9uualYEfEuDc5qWp
   bF16iSInOvvFFVuQc18CrT4pFcoD+c9b0fEUAEOd9cNWBx+180aH8Q1q+
   KMNieV2JbOnUCDva1BJc63b/bncBncPf6L8Mec75be37w3DJdsyRkQLoM
   geqs9+IKspt7ZZ7LFzv9IWWOSm17xhGFnDy/lwNO/fd6Hc/ukdCi7hPZ/
   Q+hJ58Dibes26g/BXGaPLLArFXwEyERriULvrUrjxvDQf7xMXhnq8sl6P
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="338314784"
X-IronPort-AV: E=Sophos;i="5.98,242,1673942400"; 
   d="scan'208";a="338314784"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 14:36:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="1006057151"
X-IronPort-AV: E=Sophos;i="5.98,242,1673942400"; 
   d="scan'208";a="1006057151"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 07 Mar 2023 14:36:25 -0800
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pZfuy-0001f3-2o;
        Tue, 07 Mar 2023 22:36:24 +0000
Date:   Wed, 8 Mar 2023 06:35:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: drivers/cpufreq/davinci-cpufreq.c:151:12: warning: no previous
 prototype for function 'davinci_cpufreq_init'
Message-ID: <202303080649.fobTolG2-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   8ca09d5fa3549d142c2080a72a4c70ce389163cd
commit: 250c1a694ff304e5d69e74ab32755eddcc2b8f65 ARM: pxa: convert to multiplatform
date:   10 months ago
config: arm-randconfig-r046-20230307 (https://download.01.org/0day-ci/archive/20230308/202303080649.fobTolG2-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 67409911353323ca5edf2049ef0df54132fa1ca7)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=250c1a694ff304e5d69e74ab32755eddcc2b8f65
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 250c1a694ff304e5d69e74ab32755eddcc2b8f65
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/clk/ drivers/cpufreq/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303080649.fobTolG2-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/cpufreq/davinci-cpufreq.c:151:12: warning: no previous prototype for function 'davinci_cpufreq_init' [-Wmissing-prototypes]
   int __init davinci_cpufreq_init(void)
              ^
   drivers/cpufreq/davinci-cpufreq.c:151:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int __init davinci_cpufreq_init(void)
   ^
   static 
   1 warning generated.


vim +/davinci_cpufreq_init +151 drivers/cpufreq/davinci-cpufreq.c

6601b8030de3e9c arch/arm/mach-davinci/cpufreq.c Sekhar Nori 2009-09-22  150  
3aa3e8407ae9023 arch/arm/mach-davinci/cpufreq.c Shawn Guo   2012-04-26 @151  int __init davinci_cpufreq_init(void)
6601b8030de3e9c arch/arm/mach-davinci/cpufreq.c Sekhar Nori 2009-09-22  152  {
6601b8030de3e9c arch/arm/mach-davinci/cpufreq.c Sekhar Nori 2009-09-22  153  	return platform_driver_probe(&davinci_cpufreq_driver,
6601b8030de3e9c arch/arm/mach-davinci/cpufreq.c Sekhar Nori 2009-09-22  154  							davinci_cpufreq_probe);
6601b8030de3e9c arch/arm/mach-davinci/cpufreq.c Sekhar Nori 2009-09-22  155  }
6601b8030de3e9c arch/arm/mach-davinci/cpufreq.c Sekhar Nori 2009-09-22  156  

:::::: The code at line 151 was first introduced by commit
:::::: 3aa3e8407ae9023c5ff59bf5c81fc2553c31eb70 ARM: davinci: use machine specific hook for late init

:::::: TO: Shawn Guo <shawn.guo@linaro.org>
:::::: CC: Shawn Guo <shawn.guo@linaro.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
