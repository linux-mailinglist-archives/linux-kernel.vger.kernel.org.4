Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADC946BE385
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 09:28:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbjCQI2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 04:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231555AbjCQI2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 04:28:31 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 133B2B777
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 01:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679041630; x=1710577630;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MrFAS0yYvOs3Y1PSpOqxQmHP2lixjN2PEGTt9R4HyBs=;
  b=Q/vFJnWiAEOohN4b7AFAs8Uy8WSmRdghOmIjoUytDKIjHhBKKYTBrTZv
   DqMJ+f/fpoSlgeUrDPeEumEpW0SAoyrIQVWDo/gFMJlTSlbdnMNo80vzx
   gjkWcb4szGIf7cWWqUIUWcEFum6kGMzkkjLpO7amZrMu3GuSBCmmUhCWb
   M9wuIXC/1rIdojb2Ds56YKXmb9oCBuF2IS6jUQUEkN5oG43x2nkHmHxIf
   5a1IVETFjjsRtKmdlDMfVGbuXXSyu104qUICzjcJSNJXcobd20zE3EEL/
   P1t4jhAmQ0WONAwW3Gigf7QJLa00eG8P5LXEejSdc5nMNjhq2vmAvBkK4
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="322059325"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="322059325"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2023 01:25:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="804034911"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="804034911"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 17 Mar 2023 01:25:02 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pd5OX-0009De-1S;
        Fri, 17 Mar 2023 08:25:01 +0000
Date:   Fri, 17 Mar 2023 16:24:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Siddharth Vadapalli <s-vadapalli@ti.com>, vkoul@kernel.org,
        kishon@kernel.org, rogerq@kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, srk@ti.com,
        s-vadapalli@ti.com
Subject: Re: [PATCH 1/3] phy: ti: phy-gmii-sel: Add support for SGMII mode
Message-ID: <202303171628.DXDnyhVe-lkp@intel.com>
References: <20230309062237.389444-2-s-vadapalli@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230309062237.389444-2-s-vadapalli@ti.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Siddharth,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on clk/clk-next]
[also build test WARNING on soc/for-next linus/master v6.3-rc2 next-20230317]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Siddharth-Vadapalli/phy-ti-phy-gmii-sel-Add-support-for-SGMII-mode/20230309-142358
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
patch link:    https://lore.kernel.org/r/20230309062237.389444-2-s-vadapalli%40ti.com
patch subject: [PATCH 1/3] phy: ti: phy-gmii-sel: Add support for SGMII mode
config: arm-defconfig (https://download.01.org/0day-ci/archive/20230317/202303171628.DXDnyhVe-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 67409911353323ca5edf2049ef0df54132fa1ca7)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/intel-lab-lkp/linux/commit/bb7e3cb5c0a501b5e7285e01037de8f020bbc0e9
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Siddharth-Vadapalli/phy-ti-phy-gmii-sel-Add-support-for-SGMII-mode/20230309-142358
        git checkout bb7e3cb5c0a501b5e7285e01037de8f020bbc0e9
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/phy/ti/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303171628.DXDnyhVe-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/phy/ti/phy-gmii-sel.c:115:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
           default:
           ^
   drivers/phy/ti/phy-gmii-sel.c:115:2: note: insert '__attribute__((fallthrough));' to silence this warning
           default:
           ^
           __attribute__((fallthrough)); 
   drivers/phy/ti/phy-gmii-sel.c:115:2: note: insert 'break;' to avoid fall-through
           default:
           ^
           break; 
   1 warning generated.


vim +115 drivers/phy/ti/phy-gmii-sel.c

92b58b34741ff5 Grygorii Strashko   2018-11-25   67  
92b58b34741ff5 Grygorii Strashko   2018-11-25   68  static int phy_gmii_sel_mode(struct phy *phy, enum phy_mode mode, int submode)
92b58b34741ff5 Grygorii Strashko   2018-11-25   69  {
92b58b34741ff5 Grygorii Strashko   2018-11-25   70  	struct phy_gmii_sel_phy_priv *if_phy = phy_get_drvdata(phy);
92b58b34741ff5 Grygorii Strashko   2018-11-25   71  	const struct phy_gmii_sel_soc_data *soc_data = if_phy->priv->soc_data;
92b58b34741ff5 Grygorii Strashko   2018-11-25   72  	struct device *dev = if_phy->priv->dev;
92b58b34741ff5 Grygorii Strashko   2018-11-25   73  	struct regmap_field *regfield;
92b58b34741ff5 Grygorii Strashko   2018-11-25   74  	int ret, rgmii_id = 0;
92b58b34741ff5 Grygorii Strashko   2018-11-25   75  	u32 gmii_sel_mode = 0;
92b58b34741ff5 Grygorii Strashko   2018-11-25   76  
92b58b34741ff5 Grygorii Strashko   2018-11-25   77  	if (mode != PHY_MODE_ETHERNET)
92b58b34741ff5 Grygorii Strashko   2018-11-25   78  		return -EINVAL;
92b58b34741ff5 Grygorii Strashko   2018-11-25   79  
92b58b34741ff5 Grygorii Strashko   2018-11-25   80  	switch (submode) {
92b58b34741ff5 Grygorii Strashko   2018-11-25   81  	case PHY_INTERFACE_MODE_RMII:
92b58b34741ff5 Grygorii Strashko   2018-11-25   82  		gmii_sel_mode = AM33XX_GMII_SEL_MODE_RMII;
92b58b34741ff5 Grygorii Strashko   2018-11-25   83  		break;
92b58b34741ff5 Grygorii Strashko   2018-11-25   84  
92b58b34741ff5 Grygorii Strashko   2018-11-25   85  	case PHY_INTERFACE_MODE_RGMII:
316b4294590662 Grygorii Strashko   2019-10-23   86  	case PHY_INTERFACE_MODE_RGMII_RXID:
92b58b34741ff5 Grygorii Strashko   2018-11-25   87  		gmii_sel_mode = AM33XX_GMII_SEL_MODE_RGMII;
92b58b34741ff5 Grygorii Strashko   2018-11-25   88  		break;
92b58b34741ff5 Grygorii Strashko   2018-11-25   89  
92b58b34741ff5 Grygorii Strashko   2018-11-25   90  	case PHY_INTERFACE_MODE_RGMII_ID:
92b58b34741ff5 Grygorii Strashko   2018-11-25   91  	case PHY_INTERFACE_MODE_RGMII_TXID:
92b58b34741ff5 Grygorii Strashko   2018-11-25   92  		gmii_sel_mode = AM33XX_GMII_SEL_MODE_RGMII;
92b58b34741ff5 Grygorii Strashko   2018-11-25   93  		rgmii_id = 1;
92b58b34741ff5 Grygorii Strashko   2018-11-25   94  		break;
92b58b34741ff5 Grygorii Strashko   2018-11-25   95  
92b58b34741ff5 Grygorii Strashko   2018-11-25   96  	case PHY_INTERFACE_MODE_MII:
58aa7729310db0 Grygorii Strashko   2020-02-14   97  	case PHY_INTERFACE_MODE_GMII:
eefed634eb61e4 Grygorii Strashko   2020-02-14   98  		gmii_sel_mode = AM33XX_GMII_SEL_MODE_MII;
92b58b34741ff5 Grygorii Strashko   2018-11-25   99  		break;
92b58b34741ff5 Grygorii Strashko   2018-11-25  100  
af96579dc31761 Siddharth Vadapalli 2022-09-12  101  	case PHY_INTERFACE_MODE_QSGMII:
af96579dc31761 Siddharth Vadapalli 2022-09-12  102  		if (!(soc_data->extra_modes & BIT(PHY_INTERFACE_MODE_QSGMII)))
af96579dc31761 Siddharth Vadapalli 2022-09-12  103  			goto unsupported;
af96579dc31761 Siddharth Vadapalli 2022-09-12  104  		if (if_phy->priv->qsgmii_main_ports & BIT(if_phy->id - 1))
af96579dc31761 Siddharth Vadapalli 2022-09-12  105  			gmii_sel_mode = J72XX_GMII_SEL_MODE_QSGMII;
af96579dc31761 Siddharth Vadapalli 2022-09-12  106  		else
af96579dc31761 Siddharth Vadapalli 2022-09-12  107  			gmii_sel_mode = J72XX_GMII_SEL_MODE_QSGMII_SUB;
af96579dc31761 Siddharth Vadapalli 2022-09-12  108  		break;
af96579dc31761 Siddharth Vadapalli 2022-09-12  109  
bb7e3cb5c0a501 Siddharth Vadapalli 2023-03-09  110  	case PHY_INTERFACE_MODE_SGMII:
bb7e3cb5c0a501 Siddharth Vadapalli 2023-03-09  111  		if (!(soc_data->extra_modes & BIT(PHY_INTERFACE_MODE_SGMII)))
bb7e3cb5c0a501 Siddharth Vadapalli 2023-03-09  112  			goto unsupported;
bb7e3cb5c0a501 Siddharth Vadapalli 2023-03-09  113  		else
bb7e3cb5c0a501 Siddharth Vadapalli 2023-03-09  114  			gmii_sel_mode = J72XX_GMII_SEL_MODE_SGMII;
92b58b34741ff5 Grygorii Strashko   2018-11-25 @115  	default:
af96579dc31761 Siddharth Vadapalli 2022-09-12  116  		goto unsupported;
1a3a09270668d9 kbuild test robot   2018-12-09  117  	}
92b58b34741ff5 Grygorii Strashko   2018-11-25  118  
92b58b34741ff5 Grygorii Strashko   2018-11-25  119  	if_phy->phy_if_mode = submode;
92b58b34741ff5 Grygorii Strashko   2018-11-25  120  
92b58b34741ff5 Grygorii Strashko   2018-11-25  121  	dev_dbg(dev, "%s id:%u mode:%u rgmii_id:%d rmii_clk_ext:%d\n",
eefed634eb61e4 Grygorii Strashko   2020-02-14  122  		__func__, if_phy->id, submode, rgmii_id,
92b58b34741ff5 Grygorii Strashko   2018-11-25  123  		if_phy->rmii_clock_external);
92b58b34741ff5 Grygorii Strashko   2018-11-25  124  
92b58b34741ff5 Grygorii Strashko   2018-11-25  125  	regfield = if_phy->fields[PHY_GMII_SEL_PORT_MODE];
92b58b34741ff5 Grygorii Strashko   2018-11-25  126  	ret = regmap_field_write(regfield, gmii_sel_mode);
92b58b34741ff5 Grygorii Strashko   2018-11-25  127  	if (ret) {
92b58b34741ff5 Grygorii Strashko   2018-11-25  128  		dev_err(dev, "port%u: set mode fail %d", if_phy->id, ret);
92b58b34741ff5 Grygorii Strashko   2018-11-25  129  		return ret;
92b58b34741ff5 Grygorii Strashko   2018-11-25  130  	}
92b58b34741ff5 Grygorii Strashko   2018-11-25  131  
92b58b34741ff5 Grygorii Strashko   2018-11-25  132  	if (soc_data->features & BIT(PHY_GMII_SEL_RGMII_ID_MODE) &&
92b58b34741ff5 Grygorii Strashko   2018-11-25  133  	    if_phy->fields[PHY_GMII_SEL_RGMII_ID_MODE]) {
92b58b34741ff5 Grygorii Strashko   2018-11-25  134  		regfield = if_phy->fields[PHY_GMII_SEL_RGMII_ID_MODE];
92b58b34741ff5 Grygorii Strashko   2018-11-25  135  		ret = regmap_field_write(regfield, rgmii_id);
92b58b34741ff5 Grygorii Strashko   2018-11-25  136  		if (ret)
92b58b34741ff5 Grygorii Strashko   2018-11-25  137  			return ret;
92b58b34741ff5 Grygorii Strashko   2018-11-25  138  	}
92b58b34741ff5 Grygorii Strashko   2018-11-25  139  
92b58b34741ff5 Grygorii Strashko   2018-11-25  140  	if (soc_data->features & BIT(PHY_GMII_SEL_RMII_IO_CLK_EN) &&
92b58b34741ff5 Grygorii Strashko   2018-11-25  141  	    if_phy->fields[PHY_GMII_SEL_RMII_IO_CLK_EN]) {
92b58b34741ff5 Grygorii Strashko   2018-11-25  142  		regfield = if_phy->fields[PHY_GMII_SEL_RMII_IO_CLK_EN];
92b58b34741ff5 Grygorii Strashko   2018-11-25  143  		ret = regmap_field_write(regfield,
92b58b34741ff5 Grygorii Strashko   2018-11-25  144  					 if_phy->rmii_clock_external);
92b58b34741ff5 Grygorii Strashko   2018-11-25  145  	}
92b58b34741ff5 Grygorii Strashko   2018-11-25  146  
92b58b34741ff5 Grygorii Strashko   2018-11-25  147  	return 0;
af96579dc31761 Siddharth Vadapalli 2022-09-12  148  
af96579dc31761 Siddharth Vadapalli 2022-09-12  149  unsupported:
af96579dc31761 Siddharth Vadapalli 2022-09-12  150  	dev_warn(dev, "port%u: unsupported mode: \"%s\"\n",
af96579dc31761 Siddharth Vadapalli 2022-09-12  151  		 if_phy->id, phy_modes(submode));
af96579dc31761 Siddharth Vadapalli 2022-09-12  152  	return -EINVAL;
92b58b34741ff5 Grygorii Strashko   2018-11-25  153  }
92b58b34741ff5 Grygorii Strashko   2018-11-25  154  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
