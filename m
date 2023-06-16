Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEEFE732FCA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 13:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234657AbjFPLXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 07:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345635AbjFPLXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 07:23:32 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE5A2130;
        Fri, 16 Jun 2023 04:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686914610; x=1718450610;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mDlHBFyvTQFGzUvmEXVx2wFpXxheBWNoL0HLCWmLp7I=;
  b=BMXjfbekv3pj9+5F/lGMkvIN7hJRujEracUzosR0YNDzsLZQKC8mP7w2
   L03GG/Z11Vsi7cKJNndgaB+rInKQHHMA+53pvLlgtl/mkOL+Kwq0Sw4xV
   04JVfsvbPrZuBHZgDX8qqujsQ5xyMmteJwbKjNtqoNCygz5NxiNh3CBUj
   0csZS+zKopyaL4BUj3sWVOaItgW2d2ZAh44N4gV2s+69oozK5GVskVrKP
   cLdPV/VlUVXyyyGquvYYzl/gmvs+gt7RX5gCNeHiMJnCyrg3qbUWT6zWT
   NUeJC10eCjVFhmx0+Sj6YGtkrrstwer7a0tR/imOaTsGyDFtzMBI8sIvU
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="387899097"
X-IronPort-AV: E=Sophos;i="6.00,247,1681196400"; 
   d="scan'208";a="387899097"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 04:23:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="707064234"
X-IronPort-AV: E=Sophos;i="6.00,247,1681196400"; 
   d="scan'208";a="707064234"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 16 Jun 2023 04:23:23 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qA7Y3-0001Aj-1h;
        Fri, 16 Jun 2023 11:23:23 +0000
Date:   Fri, 16 Jun 2023 19:23:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lucas Tanure <tanure@linux.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     oe-kbuild-all@lists.linux.dev, Nick <nick@khadas.com>,
        Artem <art@khadas.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-serial@vger.kernel.org, Lucas Tanure <tanure@linux.com>
Subject: Re: [PATCH 3/6] clk: meson: t7: add peripheral clock controller
Message-ID: <202306161946.Kk7xeos8-lkp@intel.com>
References: <20230615182938.18487-4-tanure@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615182938.18487-4-tanure@linux.com>
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

Hi Lucas,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on clk/clk-next tty/tty-testing tty/tty-next tty/tty-linus krzk/for-next krzk-dt/for-next krzk-mem-ctrl/for-next linus/master v6.4-rc6 next-20230616]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Lucas-Tanure/dt-bindings-arm-amlogic-add-Amlogic-T7-based-Khadas-VIM4-bindings/20230616-023038
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20230615182938.18487-4-tanure%40linux.com
patch subject: [PATCH 3/6] clk: meson: t7: add peripheral clock controller
config: arm64-buildonly-randconfig-r004-20230615 (https://download.01.org/0day-ci/archive/20230616/202306161946.Kk7xeos8-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230616/202306161946.Kk7xeos8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306161946.Kk7xeos8-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/clk/meson/t7.c:7084:51: warning: initialized field overwritten [-Woverride-init]
    7084 |                 [CLKID_VID_PLL]                 = &t7_vid_pll.hw,
         |                                                   ^
   drivers/clk/meson/t7.c:7084:51: note: (near initialization for 't7_hw_onecell_data.hws[93]')
   drivers/clk/meson/t7.c: In function 'meson_t7_probe':
>> drivers/clk/meson/t7.c:7946:36: warning: variable 'mclk_data' set but not used [-Wunused-but-set-variable]
    7946 |         struct meson_clk_pll_data *mclk_data;
         |                                    ^~~~~~~~~
   drivers/clk/meson/t7.c: At top level:
   drivers/clk/meson/t7.c:689:37: warning: 't7_a73_dyn_clk_sel' defined but not used [-Wunused-const-variable=]
     689 | static const struct clk_parent_data t7_a73_dyn_clk_sel[] = {
         |                                     ^~~~~~~~~~~~~~~~~~
   drivers/clk/meson/t7.c:93:29: warning: 'meson_pll_clk_no_ops' defined but not used [-Wunused-const-variable=]
      93 | static const struct clk_ops meson_pll_clk_no_ops = {};
         |                             ^~~~~~~~~~~~~~~~~~~~


vim +/mclk_data +7946 drivers/clk/meson/t7.c

  7939	
  7940	static int __ref meson_t7_probe(struct platform_device *pdev)
  7941	{
  7942		struct device *dev = &pdev->dev;
  7943		struct regmap *basic_map;
  7944		struct regmap *pll_map;
  7945		struct regmap *cpu_clk_map;
> 7946		struct meson_clk_pll_data *mclk_data;
  7947		int ret, i;
  7948	
  7949		/* Get regmap for different clock area */
  7950		basic_map = t7_regmap_resource(dev, "basic");
  7951		if (IS_ERR(basic_map)) {
  7952			dev_err(dev, "basic clk registers not found\n");
  7953			return PTR_ERR(basic_map);
  7954		}
  7955	
  7956		pll_map = t7_regmap_resource(dev, "pll");
  7957		if (IS_ERR(pll_map)) {
  7958			dev_err(dev, "pll clk registers not found\n");
  7959			return PTR_ERR(pll_map);
  7960		}
  7961	
  7962		cpu_clk_map = t7_regmap_resource(dev, "cpu_clk");
  7963		if (IS_ERR(cpu_clk_map)) {
  7964			dev_err(dev, "cpu clk registers not found\n");
  7965			return PTR_ERR(cpu_clk_map);
  7966		}
  7967	
  7968		/* Populate regmap for the regmap backed clocks */
  7969		for (i = 0; i < ARRAY_SIZE(t7_clk_regmaps); i++)
  7970			t7_clk_regmaps[i]->map = basic_map;
  7971	
  7972		for (i = 0; i < ARRAY_SIZE(t7_cpu_clk_regmaps); i++)
  7973			t7_cpu_clk_regmaps[i]->map = cpu_clk_map;
  7974	
  7975		for (i = 0; i < ARRAY_SIZE(t7_pll_clk_regmaps); i++)
  7976			t7_pll_clk_regmaps[i]->map = pll_map;
  7977		regmap_write(pll_map, ANACTRL_MPLL_CTRL0, 0x00000543);
  7978	
  7979		mclk_data = t7_mclk_pll_dco.data;
  7980	
  7981		for (i = 0; i < t7_hw_onecell_data.num; i++) {
  7982			/* array might be sparse */
  7983			if (!t7_hw_onecell_data.hws[i])
  7984				continue;
  7985	
  7986			ret = devm_clk_hw_register(dev, t7_hw_onecell_data.hws[i]);
  7987			if (ret) {
  7988				dev_err(dev, "Clock registration failed\n");
  7989				return ret;
  7990			}
  7991		}
  7992		meson_t7_dvfs_setup(pdev);
  7993	
  7994	
  7995		return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get, &t7_hw_onecell_data);
  7996	}
  7997	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
