Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED91E6C4494
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 09:04:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjCVIEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 04:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjCVIEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 04:04:31 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D1FF3FBBF;
        Wed, 22 Mar 2023 01:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679472270; x=1711008270;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ScpeIu0gj7yHHzZONaqbIAQWxM/t/3WXyGLP0R4bvJ0=;
  b=JYwI0xeqs5lXTHEILWKWYGB6WOOyOodqSg/6Z/H3PhO+IDrdyB01JaPj
   t7RLgy5MCPJWEDavsAGnG5WpzHzhmf6g50QCRvCnuCm/upYSLqVDQM+0E
   vQlSf4wLnxGh5hgFryVYV3OcdMzAuzg2NjC2SDzr22RZEHKQzw1R7Y5kX
   yZo5tEOW2Ol2g3SwxjM5n46XSxrT90g28UbyJ+0PORr7V3Iw9NXNPhU85
   UGQUdW0gbNbJe4kZAkhXoeD/kw/uP1v1TA0Ryeno22HxBBwoLUYocfLP6
   alaLC6TL8dotGkDwTcLprxrdZJOwhlt6016DQZXoKiD7o3600HVoMB3Tb
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="322993072"
X-IronPort-AV: E=Sophos;i="5.98,281,1673942400"; 
   d="scan'208";a="322993072"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 01:04:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="714328661"
X-IronPort-AV: E=Sophos;i="5.98,281,1673942400"; 
   d="scan'208";a="714328661"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 22 Mar 2023 01:04:27 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1petSN-000D4t-09;
        Wed, 22 Mar 2023 08:04:27 +0000
Date:   Wed, 22 Mar 2023 16:03:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Yang <mmyangfl@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, David Yang <mmyangfl@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 3/6] clk: hisilicon: Migrate devm APIs
Message-ID: <202303221528.x7zxcADU-lkp@intel.com>
References: <20230321200031.1812026-4-mmyangfl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230321200031.1812026-4-mmyangfl@gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on clk/clk-next]
[also build test ERROR on linus/master v6.3-rc3 next-20230322]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Yang/clk-hisilicon-Rename-Hi3798CV200-to-Hi3798/20230322-040342
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
patch link:    https://lore.kernel.org/r/20230321200031.1812026-4-mmyangfl%40gmail.com
patch subject: [PATCH v6 3/6] clk: hisilicon: Migrate devm APIs
config: arm-allmodconfig (https://download.01.org/0day-ci/archive/20230322/202303221528.x7zxcADU-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/a8c57104085ee7863dc5262bdd14e3fbcaa055b7
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review David-Yang/clk-hisilicon-Rename-Hi3798CV200-to-Hi3798/20230322-040342
        git checkout a8c57104085ee7863dc5262bdd14e3fbcaa055b7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/clk/hisilicon/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303221528.x7zxcADU-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   drivers/clk/hisilicon/clk-hix5hd2.c: In function 'hix5hd2_clk_register_complex':
>> drivers/clk/hisilicon/clk-hix5hd2.c:266:25: error: implicit declaration of function 'devm_kzalloc' [-Werror=implicit-function-declaration]
     266 |                 p_clk = devm_kzalloc(dev, sizeof(*p_clk), GFP_KERNEL);
         |                         ^~~~~~~~~~~~
>> drivers/clk/hisilicon/clk-hix5hd2.c:266:23: warning: assignment to 'struct hix5hd2_clk_complex *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     266 |                 p_clk = devm_kzalloc(dev, sizeof(*p_clk), GFP_KERNEL);
         |                       ^
   drivers/clk/hisilicon/clk-hix5hd2.c:263:32: warning: unused variable 'clk' [-Wunused-variable]
     263 |                 struct clk_hw *clk;
         |                                ^~~
   drivers/clk/hisilicon/clk-hix5hd2.c: In function 'hix5hd2_clk_init':
>> drivers/clk/hisilicon/clk-hix5hd2.c:304:40: error: implicit declaration of function 'of_find_device_by_node'; did you mean 'of_find_node_by_name'? [-Werror=implicit-function-declaration]
     304 |         struct platform_device *pdev = of_find_device_by_node(np);
         |                                        ^~~~~~~~~~~~~~~~~~~~~~
         |                                        of_find_node_by_name
>> drivers/clk/hisilicon/clk-hix5hd2.c:304:40: warning: initialization of 'struct platform_device *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
>> drivers/clk/hisilicon/clk-hix5hd2.c:305:35: error: invalid use of undefined type 'struct platform_device'
     305 |         struct device *dev = &pdev->dev;
         |                                   ^~
   cc1: some warnings being treated as errors


vim +/devm_kzalloc +266 drivers/clk/hisilicon/clk-hix5hd2.c

   251	
   252	static int __init
   253	hix5hd2_clk_register_complex(struct device *dev,
   254				     struct hix5hd2_complex_clock *clks, int nums,
   255				     struct hisi_clock_data *data)
   256	{
   257		void __iomem *base = data->base;
   258		int i;
   259		int ret;
   260	
   261		for (i = 0; i < nums; i++) {
   262			struct hix5hd2_clk_complex *p_clk;
   263			struct clk_hw *clk;
   264			struct clk_init_data init;
   265	
 > 266			p_clk = devm_kzalloc(dev, sizeof(*p_clk), GFP_KERNEL);
   267			if (!p_clk)
   268				return 0;
   269	
   270			init.name = clks[i].name;
   271			if (clks[i].type == TYPE_ETHER)
   272				init.ops = &clk_ether_ops;
   273			else
   274				init.ops = &clk_complex_ops;
   275	
   276			init.flags = 0;
   277			init.parent_names =
   278				(clks[i].parent_name ? &clks[i].parent_name : NULL);
   279			init.num_parents = (clks[i].parent_name ? 1 : 0);
   280	
   281			p_clk->ctrl_reg = base + clks[i].ctrl_reg;
   282			p_clk->ctrl_clk_mask = clks[i].ctrl_clk_mask;
   283			p_clk->ctrl_rst_mask = clks[i].ctrl_rst_mask;
   284			p_clk->phy_reg = base + clks[i].phy_reg;
   285			p_clk->phy_clk_mask = clks[i].phy_clk_mask;
   286			p_clk->phy_rst_mask = clks[i].phy_rst_mask;
   287			p_clk->hw.init = &init;
   288	
   289			ret = devm_clk_hw_register(dev, &p_clk->hw);
   290			if (ret) {
   291				pr_err("%s: failed to register clock %s\n",
   292				       __func__, clks[i].name);
   293				return ret;
   294			}
   295	
   296			data->clk_data->hws[clks[i].id] = &p_clk->hw;
   297		}
   298	
   299		return 0;
   300	}
   301	
   302	static void __init hix5hd2_clk_init(struct device_node *np)
   303	{
 > 304		struct platform_device *pdev = of_find_device_by_node(np);
 > 305		struct device *dev = &pdev->dev;
   306		struct hisi_clock_data *clk_data;
   307	
   308		clk_data = hisi_clk_init(np, HIX5HD2_NR_CLKS);
   309		if (!clk_data)
   310			return;
   311	
   312		hisi_clk_register_fixed_rate(dev, hix5hd2_fixed_rate_clks,
   313					     ARRAY_SIZE(hix5hd2_fixed_rate_clks),
   314					     clk_data);
   315		hisi_clk_register_mux(dev, hix5hd2_mux_clks, ARRAY_SIZE(hix5hd2_mux_clks),
   316						clk_data);
   317		hisi_clk_register_gate(dev, hix5hd2_gate_clks,
   318				ARRAY_SIZE(hix5hd2_gate_clks), clk_data);
   319		hix5hd2_clk_register_complex(dev, hix5hd2_complex_clks,
   320					     ARRAY_SIZE(hix5hd2_complex_clks),
   321					     clk_data);
   322	}
   323	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
