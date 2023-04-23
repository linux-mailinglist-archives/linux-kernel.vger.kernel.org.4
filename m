Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 657196EBC39
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 03:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbjDWBXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 21:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbjDWBXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 21:23:04 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D2F2716;
        Sat, 22 Apr 2023 18:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682212983; x=1713748983;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=21ZdMsgTaqaMuZEjnj8xl4fKVeY/zGg601rc1nQhMrM=;
  b=igy2nDE1EnxwxSD9kw4Hr4BAjybmMweR1RizyIDWbFv6tEy/RclPTH+e
   BZX2hxnznPiAPLUR6teedljXtsjCmeiDtGVfu6hrVwaInXm5/c3dAV9mo
   ZceyEYKmyaEIQFuSExtHHQ4BQebIUfNQAszRnUNgt0Cd+RVyf227RRxzp
   mbCrXzwqxtmDvxDDu0/OzgO91bhElnQJ0+V4birI+gWr6kSYzELwYEKoC
   +OfTsXZgQ6Y/3HPmwTRPloyZ8txDnKp67BCcaqLzNXn8S1X6e+NvEnG+1
   GiFlhM+GpMEvC2jHxDom/6yfiJq4yZSVhB5yVseRi9hcHmRNXAIS+FXiJ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10688"; a="409158668"
X-IronPort-AV: E=Sophos;i="5.99,219,1677571200"; 
   d="scan'208";a="409158668"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2023 18:23:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10688"; a="867071661"
X-IronPort-AV: E=Sophos;i="5.99,219,1677571200"; 
   d="scan'208";a="867071661"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 22 Apr 2023 18:22:57 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pqORM-000hbe-2V;
        Sun, 23 Apr 2023 01:22:56 +0000
Date:   Sun, 23 Apr 2023 09:22:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jakob Hauser <jahau@rocketmail.com>,
        Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Beomho Seo <beomho.seo@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Raymond Hackley <raymondhackley@protonmail.com>,
        Pavel Machek <pavel@ucw.cz>, Axel Lin <axel.lin@ingics.com>,
        ChiYuan Huang <cy_huang@richtek.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Jakob Hauser <jahau@rocketmail.com>
Subject: Re: [PATCH v2 6/9] power: supply: rt5033_charger: Add RT5033 charger
 device driver
Message-ID: <202304230924.lqgvPwZ0-lkp@intel.com>
References: <665d8906ea7b84e0a248315e8395a80007b8bafb.1681646904.git.jahau@rocketmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <665d8906ea7b84e0a248315e8395a80007b8bafb.1681646904.git.jahau@rocketmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jakob,

kernel test robot noticed the following build warnings:

[auto build test WARNING on lee-mfd/for-mfd-next]
[also build test WARNING on next-20230421]
[cannot apply to sre-power-supply/for-next broonie-regulator/for-next linus/master lee-mfd/for-mfd-fixes v6.3-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jakob-Hauser/mfd-rt5033-Fix-chip-revision-readout/20230416-214502
base:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git for-mfd-next
patch link:    https://lore.kernel.org/r/665d8906ea7b84e0a248315e8395a80007b8bafb.1681646904.git.jahau%40rocketmail.com
patch subject: [PATCH v2 6/9] power: supply: rt5033_charger: Add RT5033 charger device driver
config: x86_64-allmodconfig (https://download.01.org/0day-ci/archive/20230423/202304230924.lqgvPwZ0-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/0fbd385f9a1acd55a8d943560428b9d783f8047f
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jakob-Hauser/mfd-rt5033-Fix-chip-revision-readout/20230416-214502
        git checkout 0fbd385f9a1acd55a8d943560428b9d783f8047f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/xen/ drivers/power/supply/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304230924.lqgvPwZ0-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/power/supply/rt5033_charger.c:26:10: warning: variable 'state' is uninitialized when used here [-Wuninitialized]
                   return state;
                          ^~~~~
   drivers/power/supply/rt5033_charger.c:23:11: note: initialize the variable 'state' to silence this warning
           int state;
                    ^
                     = 0
   1 warning generated.


vim +/state +26 drivers/power/supply/rt5033_charger.c

    18	
    19	static int rt5033_get_charger_state(struct rt5033_charger *charger)
    20	{
    21		struct regmap *regmap = charger->rt5033->regmap;
    22		unsigned int reg_data;
    23		int state;
    24	
    25		if (!regmap)
  > 26			return state;
    27	
    28		regmap_read(regmap, RT5033_REG_CHG_STAT, &reg_data);
    29	
    30		switch (reg_data & RT5033_CHG_STAT_MASK) {
    31		case RT5033_CHG_STAT_DISCHARGING:
    32			state = POWER_SUPPLY_STATUS_DISCHARGING;
    33			break;
    34		case RT5033_CHG_STAT_CHARGING:
    35			state = POWER_SUPPLY_STATUS_CHARGING;
    36			break;
    37		case RT5033_CHG_STAT_FULL:
    38			state = POWER_SUPPLY_STATUS_FULL;
    39			break;
    40		case RT5033_CHG_STAT_NOT_CHARGING:
    41			state = POWER_SUPPLY_STATUS_NOT_CHARGING;
    42			break;
    43		default:
    44			state = POWER_SUPPLY_STATUS_UNKNOWN;
    45		}
    46	
    47		return state;
    48	}
    49	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
