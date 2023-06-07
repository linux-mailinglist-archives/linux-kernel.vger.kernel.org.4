Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2405725D13
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 13:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240031AbjFGL2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 07:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235232AbjFGL2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 07:28:50 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D590110DE;
        Wed,  7 Jun 2023 04:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686137328; x=1717673328;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=e7TMZ16KljFDcwznRpSLNhv1XRuSoLTaPVtloCJ3DK4=;
  b=QJ+fe8LblpBaulRLijdKVDLvuUsyLyFZcsbowmpyUAjjSBkYMuo+hZdd
   E41o2/hgOOc2OaR0D/hVu1z0nAYJP8uwtoZ5wKFrPNGyG6CnSNV1USqPn
   Cl8KsoIn96CLrYYPsSQBGp351KFFKOHJS8X+7irnfdEo/1YGA7mA6r6uv
   maha4kjOpuaeAv3gFBT/Py7068qEf/nmOjNQRMP8m+Iqt17z5cnfxFoNk
   uipZHyd2cSrbKgpGaGUWbhpvJ2KuhM5sjWG6I4afz9QgzTxmUNwv27rZY
   jKvAxavNzE5iHeQBmf3u2pnyZ1pTfqnoIoxZq7jS9uWE6z9UY/3MRp90y
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="337319816"
X-IronPort-AV: E=Sophos;i="6.00,223,1681196400"; 
   d="scan'208";a="337319816"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2023 04:27:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="739193982"
X-IronPort-AV: E=Sophos;i="6.00,223,1681196400"; 
   d="scan'208";a="739193982"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 07 Jun 2023 04:26:59 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q6rJa-0006VX-0m;
        Wed, 07 Jun 2023 11:26:58 +0000
Date:   Wed, 7 Jun 2023 19:26:48 +0800
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
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Ray Chi <raychi@google.com>,
        Flavio Suligoi <f.suligoi@asem.it>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v3 2/5] phy: realtek: usb: Add driver for the Realtek SoC
 USB 2.0 PHY
Message-ID: <202306071901.mhcH1Kcc-lkp@intel.com>
References: <20230607062500.24669-2-stanley_chang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230607062500.24669-2-stanley_chang@realtek.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stanley,

kernel test robot noticed the following build errors:

[auto build test ERROR on usb/usb-testing]
[also build test ERROR on usb/usb-next usb/usb-linus robh/for-next linus/master v6.4-rc5 next-20230607]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Stanley-Chang/phy-realtek-usb-Add-driver-for-the-Realtek-SoC-USB-2-0-PHY/20230607-142704
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
patch link:    https://lore.kernel.org/r/20230607062500.24669-2-stanley_chang%40realtek.com
patch subject: [PATCH v3 2/5] phy: realtek: usb: Add driver for the Realtek SoC USB 2.0 PHY
config: sh-randconfig-r033-20230607 (https://download.01.org/0day-ci/archive/20230607/202306071901.mhcH1Kcc-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 12.3.0
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add usb https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git
        git fetch usb usb-testing
        git checkout usb/usb-testing
        b4 shazam https://lore.kernel.org/r/20230607062500.24669-2-stanley_chang@realtek.com
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir --shuffle=2827500481 ARCH=sh olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir --shuffle=2827500481 ARCH=sh SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306071901.mhcH1Kcc-lkp@intel.com/

All errors (new ones prefixed by >>):

   sh4-linux-ld: drivers/phy/realtek/phy-rtk-usb2.o: in function `rtk_usb2phy_remove':
>> drivers/phy/realtek/phy-rtk-usb2.c:1891: undefined reference to `usb_remove_phy'
   sh4-linux-ld: drivers/phy/realtek/phy-rtk-usb2.o: in function `create_debug_files':
>> drivers/phy/realtek/phy-rtk-usb2.c:1378: undefined reference to `usb_debug_root'
   sh4-linux-ld: drivers/phy/realtek/phy-rtk-usb2.o: in function `rtk_usb2phy_probe':
>> drivers/phy/realtek/phy-rtk-usb2.c:1882: undefined reference to `usb_add_phy_dev'
   sh4-linux-ld: drivers/power/supply/wm831x_power.o: in function `wm831x_power_probe':
>> drivers/power/supply/wm831x_power.c:695: undefined reference to `devm_usb_get_phy_by_phandle'
   sh4-linux-ld: drivers/power/supply/rt9455_charger.o: in function `rt9455_probe':
>> drivers/power/supply/rt9455_charger.c:1682: undefined reference to `devm_usb_get_phy'
   sh4-linux-ld: drivers/power/supply/isp1704_charger.o: in function `isp1704_charger_probe':
>> drivers/power/supply/isp1704_charger.c:73: undefined reference to `devm_usb_get_phy_by_phandle'
>> sh4-linux-ld: drivers/power/supply/isp1704_charger.c:73: undefined reference to `devm_usb_get_phy'
   sh4-linux-ld: drivers/power/supply/bq25890_charger.o: in function `bq25890_probe':
>> drivers/power/supply/bq25890_charger.c:1511: undefined reference to `devm_usb_get_phy'
   sh4-linux-ld: drivers/power/supply/bq256xx_charger.o: in function `bq256xx_probe':
>> drivers/power/supply/bq256xx_charger.c:1743: undefined reference to `devm_usb_get_phy'

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for USB_PHY
   Depends on [n]: USB_SUPPORT [=n]
   Selected by [y]:
   - PHY_RTK_RTD_USB2PHY [=y]


vim +1891 drivers/phy/realtek/phy-rtk-usb2.c

  1802	
  1803	static int rtk_usb2phy_probe(struct platform_device *pdev)
  1804	{
  1805		struct rtk_usb_phy *rtk_phy;
  1806		struct device *dev = &pdev->dev;
  1807		struct device_node *node;
  1808		struct device_node *sub_node;
  1809		struct phy *generic_phy;
  1810		struct phy_provider *phy_provider;
  1811		int phyN, ret = 0;
  1812	
  1813		rtk_phy = devm_kzalloc(dev, sizeof(*rtk_phy), GFP_KERNEL);
  1814		if (!rtk_phy)
  1815			return -ENOMEM;
  1816	
  1817		rtk_phy->dev			= &pdev->dev;
  1818		rtk_phy->phy.dev		= rtk_phy->dev;
  1819		rtk_phy->phy.label		= "rtk-usb2phy";
  1820		rtk_phy->phy.notify_port_status = rtk_usb_phy_notify_port_status;
  1821	
  1822		if (!dev->of_node) {
  1823			dev_err(dev, "%s %d No device node\n", __func__, __LINE__);
  1824			goto err;
  1825		}
  1826	
  1827		node = dev->of_node;
  1828	
  1829		rtk_phy->usb_ctrl_regs = syscon_regmap_lookup_by_phandle(node, "realtek,usb-ctrl");
  1830		if (IS_ERR(rtk_phy->usb_ctrl_regs)) {
  1831			dev_info(dev, "%s: DTS no support usb_ctrl regs syscon\n", __func__);
  1832			rtk_phy->usb_ctrl_regs = NULL;
  1833		}
  1834	
  1835		phyN = of_get_child_count(node);
  1836		rtk_phy->phyN = phyN;
  1837		dev_dbg(dev, "%s phyN=%d\n", __func__, rtk_phy->phyN);
  1838	
  1839		rtk_phy->reg_addr = devm_kzalloc(dev,
  1840			    sizeof(struct reg_addr) * phyN, GFP_KERNEL);
  1841		if (!rtk_phy->reg_addr)
  1842			return -ENOMEM;
  1843	
  1844		rtk_phy->phy_data = devm_kzalloc(dev,
  1845			    sizeof(struct phy_data) * phyN, GFP_KERNEL);
  1846		if (!rtk_phy->phy_data)
  1847			return -ENOMEM;
  1848	
  1849		for (sub_node = of_get_next_child(node, NULL); sub_node != NULL;
  1850			    sub_node = of_get_next_child(node, sub_node)) {
  1851			ret = get_phy_parameter(rtk_phy, sub_node);
  1852			if (ret) {
  1853				dev_err(dev, "%s: get_phy_parameter fail ret=%d\n",
  1854					    __func__, ret);
  1855				goto err;
  1856			}
  1857		}
  1858	
  1859		platform_set_drvdata(pdev, rtk_phy);
  1860	
  1861		generic_phy = devm_phy_create(rtk_phy->dev, NULL, &ops);
  1862		if (IS_ERR(generic_phy))
  1863			return PTR_ERR(generic_phy);
  1864	
  1865		phy_set_drvdata(generic_phy, rtk_phy);
  1866	
  1867		phy_provider = devm_of_phy_provider_register(rtk_phy->dev,
  1868					    of_phy_simple_xlate);
  1869		if (IS_ERR(phy_provider))
  1870			return PTR_ERR(phy_provider);
  1871	
  1872		ret = usb_add_phy_dev(&rtk_phy->phy);
  1873		if (ret)
  1874			goto err;
  1875	
  1876		create_debug_files(rtk_phy);
  1877	
  1878	err:
  1879		dev_dbg(dev, "Probe RTK USB 2.0 PHY (ret=%d)\n", ret);
  1880	
  1881		return ret;
> 1882	}
  1883	
  1884	static void rtk_usb2phy_remove(struct platform_device *pdev)
  1885	{
  1886		struct rtk_usb_phy *rtk_phy = platform_get_drvdata(pdev);
  1887	
  1888		remove_debug_files(rtk_phy);
  1889	
  1890		usb_remove_phy(&rtk_phy->phy);
> 1891	}
  1892	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
