Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11E4873032D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 17:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343621AbjFNPOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 11:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343599AbjFNPN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 11:13:59 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B241FE3;
        Wed, 14 Jun 2023 08:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686755637; x=1718291637;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YX4y7lBqNFFJ0PedIid4kUnTJJmVgsFKsE3ZJAbPjMQ=;
  b=BryI6iYUlmpIaRG/PcPx/MlPS/APd8R/Gusli0ar1jTNgsQ4zPPq+U8e
   F274GKm93y69qgnFdGhfsHPq6OBbCmXuciPqbd/MhfqKcMcwXSoQtZY13
   n4iuvKibJn5sX+7F+02S/jJ2ttImLuJXx9UydB5v+Hi9LcRy1jpWhHY/P
   VO/6PPtUIWbA0nhabynZImS8tqZhdGJ7+f3YNCuAA6KJb8HwZQJBQQVJc
   9XyiKd9JYqX71OwlT/XVla8SBz9BQq0MWV7lGRMVRP6z754azAW3Vtf07
   /Z1fvfgXWhhlP2r4rSHMvwyzrON36Zq6PdPWguIrDTat0L5pWC76lFhq7
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="361117398"
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; 
   d="scan'208";a="361117398"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 08:13:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="745115832"
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; 
   d="scan'208";a="745115832"
Received: from lkp-server02.sh.intel.com (HELO d59cacf64e9e) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 14 Jun 2023 08:13:52 -0700
Received: from kbuild by d59cacf64e9e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q9SBz-0000n5-2J;
        Wed, 14 Jun 2023 15:13:51 +0000
Date:   Wed, 14 Jun 2023 23:10:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Stanley Chang <stanley_chang@realtek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     oe-kbuild-all@lists.linux.dev,
        Stanley Chang <stanley_chang@realtek.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Flavio Suligoi <f.suligoi@asem.it>,
        Douglas Anderson <dianders@chromium.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Ray Chi <raychi@google.com>, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v4 2/5] phy: realtek: usb: Add driver for the Realtek SoC
 USB 2.0 PHY
Message-ID: <202306142352.e4eBd3HX-lkp@intel.com>
References: <20230614092850.21460-2-stanley_chang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230614092850.21460-2-stanley_chang@realtek.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stanley,

kernel test robot noticed the following build warnings:

[auto build test WARNING on usb/usb-testing]
[also build test WARNING on usb/usb-next usb/usb-linus robh/for-next linus/master v6.4-rc6 next-20230614]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Stanley-Chang/phy-realtek-usb-Add-driver-for-the-Realtek-SoC-USB-2-0-PHY/20230614-173349
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
patch link:    https://lore.kernel.org/r/20230614092850.21460-2-stanley_chang%40realtek.com
patch subject: [PATCH v4 2/5] phy: realtek: usb: Add driver for the Realtek SoC USB 2.0 PHY
config: sparc-allyesconfig (https://download.01.org/0day-ci/archive/20230614/202306142352.e4eBd3HX-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 12.3.0
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add usb https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git
        git fetch usb usb-testing
        git checkout usb/usb-testing
        b4 shazam https://lore.kernel.org/r/20230614092850.21460-2-stanley_chang@realtek.com
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=sparc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=sparc SHELL=/bin/bash drivers/phy/realtek/

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306142352.e4eBd3HX-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/phy/realtek/phy-rtk-usb2.c: In function 'parse_phy_data':
>> drivers/phy/realtek/phy-rtk-usb2.c:1229:25: warning: variable 'phy_cfg' set but not used [-Wunused-but-set-variable]
    1229 |         struct phy_cfg *phy_cfg;
         |                         ^~~~~~~


vim +/phy_cfg +1229 drivers/phy/realtek/phy-rtk-usb2.c

  1224	
  1225	static int parse_phy_data(struct rtk_phy *rtk_phy)
  1226	{
  1227		struct device *dev = rtk_phy->dev;
  1228		struct device_node *node;
> 1229		struct phy_cfg *phy_cfg;
  1230		struct phy_parameter *phy_parameter;
  1231		int ret = 0;
  1232		int index;
  1233	
  1234		node = dev->of_node;
  1235		phy_cfg = rtk_phy->phy_cfg;
  1236	
  1237		rtk_phy->phy_parameter = devm_kzalloc(dev, sizeof(struct phy_parameter) *
  1238							rtk_phy->num_phy, GFP_KERNEL);
  1239		if (!rtk_phy->phy_parameter)
  1240			return -ENOMEM;
  1241	
  1242		for (index = 0; index < rtk_phy->num_phy; index++) {
  1243			phy_parameter = &((struct phy_parameter *)rtk_phy->phy_parameter)[index];
  1244	
  1245			phy_parameter->phy_reg.reg_wrap_vstatus = of_iomap(dev->of_node, 0);
  1246			phy_parameter->phy_reg.reg_gusb2phyacc0 = of_iomap(dev->of_node, 1) + index;
  1247			phy_parameter->phy_reg.vstatus_index = index;
  1248	
  1249			if (of_property_read_bool(node, "realtek,inverse-hstx-sync-clock"))
  1250				phy_parameter->inverse_hstx_sync_clock = true;
  1251			else
  1252				phy_parameter->inverse_hstx_sync_clock = false;
  1253	
  1254			if (of_property_read_u32_index(node, "realtek,driving-level",
  1255						       index, &phy_parameter->driving_level))
  1256				phy_parameter->driving_level = DEFAULT_DC_DRIVING_VALUE;
  1257	
  1258			if (of_property_read_u32_index(node, "realtek,driving-compensate",
  1259						       index, &phy_parameter->driving_compensate))
  1260				phy_parameter->driving_compensate = 0;
  1261	
  1262			if (of_property_read_u32_index(node, "realtek,disconnection-compensate",
  1263						       index, &phy_parameter->disconnection_compensate))
  1264				phy_parameter->disconnection_compensate = 0;
  1265	
  1266			get_phy_data_by_efuse(rtk_phy, phy_parameter, index);
  1267	
  1268			update_dc_driving_level(rtk_phy, phy_parameter);
  1269	
  1270			update_hs_clk_select(rtk_phy, phy_parameter);
  1271		}
  1272	
  1273		return ret;
  1274	}
  1275	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
