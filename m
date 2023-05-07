Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60F8D6F9A55
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 18:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbjEGQ6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 12:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjEGQ6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 12:58:39 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 513876A40
        for <linux-kernel@vger.kernel.org>; Sun,  7 May 2023 09:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683478718; x=1715014718;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0Qst2DzvBBbU5FzPI4kuEPLqkO/8kAHLFByV3AgoYIE=;
  b=kH7kp0ijy+luwKd7Efr2oDb3JywKsRH/sAhsyBaXeAeWsUn9UKNiu6ch
   8Z5CVNLVL/CoaKabkpH3RjiiP04ewnHeiW0AwxaF3CRhHt7V/L/SwVZnb
   J0AiqCE8UKlttUfN4p0elPfeUVxIl5PePM5ecebUQfyZvlb0GvTHapufO
   aIYXL8JfPzU4x5KmaPUkzHGN1np5Q1SiEQZGC3nkMJbJqNVG5znwx52GP
   9inCtsj4xEx9D5Ggicw2X40H92NW18Euh69MtDRloL9dnUZTkC3EtEwQ3
   dDyZRLbgQ9wf8dtk8T1T9JknrVUm7eIg0Pu8nTfmPS9V9QrRn7nSk9RQk
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="329857489"
X-IronPort-AV: E=Sophos;i="5.99,257,1677571200"; 
   d="scan'208";a="329857489"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2023 09:58:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="787842082"
X-IronPort-AV: E=Sophos;i="5.99,257,1677571200"; 
   d="scan'208";a="787842082"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 07 May 2023 09:58:36 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pvhiV-0000oL-1h;
        Sun, 07 May 2023 16:58:35 +0000
Date:   Mon, 8 May 2023 00:57:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Yang <mmyangfl@gmail.com>, linux-phy@lists.infradead.org
Cc:     oe-kbuild-all@lists.linux.dev, David Yang <mmyangfl@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] phy: hisilicon: Adopt phy-hisi-inno-usb2 to Hi3798MV100
Message-ID: <202305080013.kOt0Vzuc-lkp@intel.com>
References: <20230507154615.793942-1-mmyangfl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230507154615.793942-1-mmyangfl@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.3 next-20230505]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Yang/phy-hisilicon-Adopt-phy-hisi-inno-usb2-to-Hi3798MV100/20230507-234747
base:   linus/master
patch link:    https://lore.kernel.org/r/20230507154615.793942-1-mmyangfl%40gmail.com
patch subject: [PATCH] phy: hisilicon: Adopt phy-hisi-inno-usb2 to Hi3798MV100
config: arm64-buildonly-randconfig-r001-20230507 (https://download.01.org/0day-ci/archive/20230508/202305080013.kOt0Vzuc-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/fe830916b152e401719061112b0b4fb140502d08
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review David-Yang/phy-hisilicon-Adopt-phy-hisi-inno-usb2-to-Hi3798MV100/20230507-234747
        git checkout fe830916b152e401719061112b0b4fb140502d08
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/phy/hisilicon/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305080013.kOt0Vzuc-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/phy/hisilicon/phy-hisi-inno-usb2.c: In function 'hisi_inno_phy_probe':
>> drivers/phy/hisilicon/phy-hisi-inno-usb2.c:165:22: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
     165 |         priv->type = (unsigned int) of_device_get_match_data(dev);
         |                      ^


vim +165 drivers/phy/hisilicon/phy-hisi-inno-usb2.c

   136	
   137	static int hisi_inno_phy_probe(struct platform_device *pdev)
   138	{
   139		struct device *dev = &pdev->dev;
   140		struct device_node *np = dev->of_node;
   141		struct hisi_inno_phy_priv *priv;
   142		struct phy_provider *provider;
   143		struct device_node *child;
   144		int i = 0;
   145		int ret;
   146	
   147		priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
   148		if (!priv)
   149			return -ENOMEM;
   150	
   151		priv->mmio = devm_platform_ioremap_resource(pdev, 0);
   152		if (IS_ERR(priv->mmio)) {
   153			ret = PTR_ERR(priv->mmio);
   154			return ret;
   155		}
   156	
   157		priv->ref_clk = devm_clk_get(dev, NULL);
   158		if (IS_ERR(priv->ref_clk))
   159			return PTR_ERR(priv->ref_clk);
   160	
   161		priv->por_rst = devm_reset_control_get_exclusive(dev, NULL);
   162		if (IS_ERR(priv->por_rst))
   163			return PTR_ERR(priv->por_rst);
   164	
 > 165		priv->type = (unsigned int) of_device_get_match_data(dev);
   166	
   167		for_each_child_of_node(np, child) {
   168			struct reset_control *rst;
   169			struct phy *phy;
   170	
   171			rst = of_reset_control_get_exclusive(child, NULL);
   172			if (IS_ERR(rst)) {
   173				of_node_put(child);
   174				return PTR_ERR(rst);
   175			}
   176	
   177			priv->ports[i].utmi_rst = rst;
   178			priv->ports[i].priv = priv;
   179	
   180			phy = devm_phy_create(dev, child, &hisi_inno_phy_ops);
   181			if (IS_ERR(phy)) {
   182				of_node_put(child);
   183				return PTR_ERR(phy);
   184			}
   185	
   186			phy_set_bus_width(phy, 8);
   187			phy_set_drvdata(phy, &priv->ports[i]);
   188			i++;
   189	
   190			if (i > INNO_PHY_PORT_NUM) {
   191				dev_warn(dev, "Support %d ports in maximum\n", i);
   192				of_node_put(child);
   193				break;
   194			}
   195		}
   196	
   197		provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
   198		return PTR_ERR_OR_ZERO(provider);
   199	}
   200	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
