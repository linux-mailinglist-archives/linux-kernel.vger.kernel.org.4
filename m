Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97BD96C9321
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 10:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbjCZIkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 04:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbjCZIkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 04:40:39 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD036A4B;
        Sun, 26 Mar 2023 01:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679820037; x=1711356037;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=N6dUsrWNh5ZG+2Cl6547/PoM1DWg7zz+R8iUxF6D7Yk=;
  b=bfdWM2ExxTDgtdl1mp3KwEJ2DvljK4TmyFGWOtGPyoRskmMnVxHGORcS
   xpgvBxlXulT89dPXguxO6ChhZ+efT5yDIoT3Q02qLrFKEMOoPEl0Qj7C+
   KC9e0cTHChLG31H2sARGS8xWkmmr1YcHc2bV5C0GTy0DZklPfk1mox11D
   HzHu1AbuvZNWXLY4lI3+XQGt/X5R/LcMu20eFWP7O/PxT10SYJUT0fJRA
   F6ZbcO6Pay6Wz6bW2OiXFJurDgfeyk40l0uOJi+G9Br+E8s4JTUplXhxt
   EXMLxLEcRYnbagtAU7xfQ5dIJFz48gVw4ze60Aboj0RyxLyaM0rNSlpjb
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10660"; a="337568704"
X-IronPort-AV: E=Sophos;i="5.98,292,1673942400"; 
   d="scan'208";a="337568704"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2023 01:40:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10660"; a="676640343"
X-IronPort-AV: E=Sophos;i="5.98,292,1673942400"; 
   d="scan'208";a="676640343"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 26 Mar 2023 01:40:34 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pgLvV-000Gyz-1P;
        Sun, 26 Mar 2023 08:40:33 +0000
Date:   Sun, 26 Mar 2023 16:40:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bharat Bhushan <bbhushan2@marvell.com>, wim@linux-watchdog.org,
        linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Bharat Bhushan <bbhushan2@marvell.com>
Subject: Re: [PATCH 2/2] Watchdog: octeontx2: Add Pseudo-NMI GTI watchdog
 driver
Message-ID: <202303261656.JoHKPpgU-lkp@intel.com>
References: <20230324145652.19221-2-bbhushan2@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230324145652.19221-2-bbhushan2@marvell.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bharat,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on robh/for-next]
[also build test WARNING on groeck-staging/hwmon-next linus/master v6.3-rc3 next-20230324]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Bharat-Bhushan/Watchdog-octeontx2-Add-Pseudo-NMI-GTI-watchdog-driver/20230324-225820
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20230324145652.19221-2-bbhushan2%40marvell.com
patch subject: [PATCH 2/2] Watchdog: octeontx2: Add Pseudo-NMI GTI watchdog driver
config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20230326/202303261656.JoHKPpgU-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 67409911353323ca5edf2049ef0df54132fa1ca7)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/b703845ae954bff5a3ae14669043889a8989adde
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Bharat-Bhushan/Watchdog-octeontx2-Add-Pseudo-NMI-GTI-watchdog-driver/20230324-225820
        git checkout b703845ae954bff5a3ae14669043889a8989adde
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/infiniband/hw/bnxt_re/ drivers/watchdog/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303261656.JoHKPpgU-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/watchdog/octeontx2_gti_watchdog.c:67:6: warning: no previous prototype for function 'octeontx2_gti_wdt_callback_other_cpus' [-Wmissing-prototypes]
   void octeontx2_gti_wdt_callback_other_cpus(void *unused)
        ^
   drivers/watchdog/octeontx2_gti_watchdog.c:67:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void octeontx2_gti_wdt_callback_other_cpus(void *unused)
   ^
   static 
   1 warning generated.


vim +/octeontx2_gti_wdt_callback_other_cpus +67 drivers/watchdog/octeontx2_gti_watchdog.c

    66	
  > 67	void octeontx2_gti_wdt_callback_other_cpus(void *unused)
    68	{
    69		struct pt_regs *regs = get_irq_regs();
    70	
    71		pr_emerg("GTI Watchdog CPU:%d\n", raw_smp_processor_id());
    72	
    73		if (regs)
    74			show_regs(regs);
    75		else
    76			dump_stack();
    77	}
    78	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
