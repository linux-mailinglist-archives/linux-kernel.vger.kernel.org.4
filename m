Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78DB96A21BD
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 19:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbjBXSuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 13:50:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjBXSuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 13:50:07 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9196A7AE;
        Fri, 24 Feb 2023 10:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677264606; x=1708800606;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Med8FP749QQT3U1NIMdqmYtl7dVRycVXAPaFZGh995w=;
  b=kUSokPvzYHN+KpXkk6Vgp/sWYaHOS+tXSNZ1PiCLAjqOdREmgUnPzkl1
   BxMaeQgS4cp2Hde2NsRcXTt18RbOStO4qO9s+bzB4+NtaPgMVI49R+NDi
   5G144sKtmCUtQ0EzDk2hVKHb5xi7fYor0tMDBTOsOy0d/nV/15E3oERKl
   qTZPenOMM8c9jQlk+9VqkzFzjCzzwYEwYFiHdPEMBJ3s0ecz4bhMqHDr1
   ec85bSc3K5mnxLED9YIXj2B+VE7FwASDkDkvzVeGBFs/Wd3FR4QVf05Pq
   sPSR6Lj+ZWVE43AgaFD15IOQDEAV6xtK3/41rYRkrgNYJ1CQz/EV9fRi8
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10631"; a="321754308"
X-IronPort-AV: E=Sophos;i="5.97,325,1669104000"; 
   d="scan'208";a="321754308"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2023 10:50:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10631"; a="918528349"
X-IronPort-AV: E=Sophos;i="5.97,325,1669104000"; 
   d="scan'208";a="918528349"
Received: from lkp-server01.sh.intel.com (HELO 3895f5c55ead) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 24 Feb 2023 10:50:02 -0800
Received: from kbuild by 3895f5c55ead with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pVd8s-0002dD-0R;
        Fri, 24 Feb 2023 18:50:02 +0000
Date:   Sat, 25 Feb 2023 02:49:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Esteban Blanc <eblanc@baylibre.com>, linus.walleij@linaro.org,
        lgirdwood@gmail.com, broonie@kernel.org, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-rtc@vger.kernel.org,
        jpanis@baylibre.com, jneanne@baylibre.com
Subject: Re: [PATCH INTERNAL v1 2/3] pinctrl: tps6594: add for TPS6594 PMIC
Message-ID: <202302250208.XGrlUK3B-lkp@intel.com>
References: <20230224133129.887203-3-eblanc@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230224133129.887203-3-eblanc@baylibre.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Esteban,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linusw-pinctrl/devel]
[also build test WARNING on linusw-pinctrl/for-next broonie-regulator/for-next abelloni/rtc-next linus/master v6.2 next-20230224]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Esteban-Blanc/rtc-tps6594-add-driver-for-TPS6594-PMIC-RTC/20230224-213323
base:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git devel
patch link:    https://lore.kernel.org/r/20230224133129.887203-3-eblanc%40baylibre.com
patch subject: [PATCH INTERNAL v1 2/3] pinctrl: tps6594: add for TPS6594 PMIC
config: sparc-allyesconfig (https://download.01.org/0day-ci/archive/20230225/202302250208.XGrlUK3B-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/5abddc736234d1cd3e28ef7e205bc0bfef263c15
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Esteban-Blanc/rtc-tps6594-add-driver-for-TPS6594-PMIC-RTC/20230224-213323
        git checkout 5abddc736234d1cd3e28ef7e205bc0bfef263c15
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sparc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sparc SHELL=/bin/bash drivers/pinctrl/ drivers/regulator/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302250208.XGrlUK3B-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/pinctrl/pinctrl-tps6594.c:8: warning: "DEBUG" redefined
       8 | #define DEBUG
         | 
   <command-line>: note: this is the location of the previous definition


vim +/DEBUG +8 drivers/pinctrl/pinctrl-tps6594.c

   > 8	#define DEBUG
     9	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
