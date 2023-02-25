Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E39E6A2BAD
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 21:37:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjBYUhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 15:37:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjBYUgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 15:36:47 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A0215573;
        Sat, 25 Feb 2023 12:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677357406; x=1708893406;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mqSM0I91U6IAY9Cj5vU5OR9snlGfnxVyIBIv1dpHmOw=;
  b=Bc8vDyffWPwoQvDr3+HaxLxEwgwvvp73oq1rKkNkPwR0ZJezF9FZWKYA
   rvOKLAEyppZeYd2PMK0hxsaDpEjGzyUSDZnLO64fRr83NRiM5B/c032U9
   C6feXIJNeJKGDAACjd1CWSUGxl4E6WZrvat/DVwADarGXiEnhD+8qg0kZ
   OyhtlPbiOUfDQgkhYjODzi6YSLnmEFdgJAYJXojaC8AtmKHGOM8UxVLs3
   WCCBXTRYk2Uuo9bcEKZLNtB1XJTg4ByYoBTOYfQVb+EMmldqsUkVRtpYs
   A6P4xpVMJYljnbOuU7JP+72IkQuzvL3Ua7lW514Nm7OHz2s/Qh3plA991
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10632"; a="419927863"
X-IronPort-AV: E=Sophos;i="5.97,328,1669104000"; 
   d="scan'208";a="419927863"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2023 12:36:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10632"; a="1002204939"
X-IronPort-AV: E=Sophos;i="5.97,328,1669104000"; 
   d="scan'208";a="1002204939"
Received: from lkp-server01.sh.intel.com (HELO 3895f5c55ead) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 25 Feb 2023 12:36:42 -0800
Received: from kbuild by 3895f5c55ead with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pW1He-0003Op-04;
        Sat, 25 Feb 2023 20:36:42 +0000
Date:   Sun, 26 Feb 2023 04:36:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Esteban Blanc <eblanc@baylibre.com>, linus.walleij@linaro.org,
        lgirdwood@gmail.com, broonie@kernel.org, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-rtc@vger.kernel.org, jpanis@baylibre.com,
        jneanne@baylibre.com
Subject: Re: [PATCH INTERNAL v1 2/3] pinctrl: tps6594: add for TPS6594 PMIC
Message-ID: <202302260423.CycoSTtT-lkp@intel.com>
References: <20230224133129.887203-3-eblanc@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230224133129.887203-3-eblanc@baylibre.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Esteban,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linusw-pinctrl/devel]
[also build test WARNING on linusw-pinctrl/for-next broonie-regulator/for-next abelloni/rtc-next linus/master v6.2 next-20230225]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Esteban-Blanc/rtc-tps6594-add-driver-for-TPS6594-PMIC-RTC/20230224-213323
base:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git devel
patch link:    https://lore.kernel.org/r/20230224133129.887203-3-eblanc%40baylibre.com
patch subject: [PATCH INTERNAL v1 2/3] pinctrl: tps6594: add for TPS6594 PMIC
config: x86_64-allmodconfig (https://download.01.org/0day-ci/archive/20230226/202302260423.CycoSTtT-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/5abddc736234d1cd3e28ef7e205bc0bfef263c15
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Esteban-Blanc/rtc-tps6594-add-driver-for-TPS6594-PMIC-RTC/20230224-213323
        git checkout 5abddc736234d1cd3e28ef7e205bc0bfef263c15
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/pinctrl/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302260423.CycoSTtT-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/pinctrl/pinctrl-tps6594.c:8:9: warning: 'DEBUG' macro redefined [-Wmacro-redefined]
   #define DEBUG
           ^
   <command line>:6:9: note: previous definition is here
   #define DEBUG 1
           ^
   1 warning generated.


vim +/DEBUG +8 drivers/pinctrl/pinctrl-tps6594.c

   > 8	#define DEBUG
     9	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
