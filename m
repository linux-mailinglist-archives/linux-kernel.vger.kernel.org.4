Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DEF16C094F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 04:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjCTDbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 23:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjCTDbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 23:31:37 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A0F7C144;
        Sun, 19 Mar 2023 20:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679283094; x=1710819094;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UYH7FKa5PiJUGfGfOGDIzEwS9lrRTqBT6sO5UdSidn0=;
  b=nLSjH+PoAVeqC/xXBrq8NaMiJ3Q1aJOa2vcZqUIZovGs2R9vBpjt9jEc
   pBDTfrNycNIpXBvz9lDkHjPZBn8pHu//JEUGc8qqI5zkOdnzFjqoQdn66
   c0tejXnEPar2Bmnv/PqWwemvWkPwW1euPNYrSzJyudPXyHfnV9Y+YX3Oc
   135xjB0YAM4rMT/bQC2KbXI1d733ZEp1sNWjDRqRsN5pkJnuqHJcXS6nw
   tntgkWofUZZktwCek5/xLe1uq/7Ee4LgymKbypqiFI/PjN7vm13fb7paP
   ttlZPlviw8+sTJdWSPWx0xhCgVclVcG96fiPPkalI5Dse0YkQS7zT/BNC
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="318967088"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="318967088"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2023 20:31:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="658195849"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="658195849"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 19 Mar 2023 20:31:29 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pe6F6-000Anq-1f;
        Mon, 20 Mar 2023 03:31:28 +0000
Date:   Mon, 20 Mar 2023 11:30:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Adam Ford <aford173@gmail.com>, linux-clk@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, aford@beaconembedded.com,
        Adam Ford <aford173@gmail.com>,
        Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] clk: imx8mm: Let IMX8MM_CLK_LCDIF_PIXEL set parent
 rate
Message-ID: <202303201144.sAdcZMmh-lkp@intel.com>
References: <20230319132120.6347-3-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230319132120.6347-3-aford173@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adam,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on abelvesa/clk/imx]
[also build test ERROR on clk/clk-next linus/master v6.3-rc3 next-20230317]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Adam-Ford/clk-imx-composite-8m-Add-support-to-determine_rate/20230319-212205
base:   https://git.kernel.org/pub/scm/linux/kernel/git/abelvesa/linux.git clk/imx
patch link:    https://lore.kernel.org/r/20230319132120.6347-3-aford173%40gmail.com
patch subject: [PATCH 2/3] clk: imx8mm: Let IMX8MM_CLK_LCDIF_PIXEL set parent rate
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20230320/202303201144.sAdcZMmh-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/adc46ba997e828887ca8f020c6694fcfb59268db
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Adam-Ford/clk-imx-composite-8m-Add-support-to-determine_rate/20230319-212205
        git checkout adc46ba997e828887ca8f020c6694fcfb59268db
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/clk/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303201144.sAdcZMmh-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   drivers/clk/imx/clk-imx8mm.c: In function 'imx8mm_clocks_probe':
>> drivers/clk/imx/clk-imx8mm.c:471:39: error: implicit declaration of function 'imx8m_clk_hw_composite_flags'; did you mean 'imx8m_clk_hw_composite_bus'? [-Werror=implicit-function-declaration]
     471 |         hws[IMX8MM_CLK_LCDIF_PIXEL] = imx8m_clk_hw_composite_flags("lcdif_pixel", imx8mm_lcdif_pixel_sels, base + 0xa500, CLK_SET_RATE_PARENT);
         |                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                       imx8m_clk_hw_composite_bus
>> drivers/clk/imx/clk-imx8mm.c:471:37: warning: assignment to 'struct clk_hw *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     471 |         hws[IMX8MM_CLK_LCDIF_PIXEL] = imx8m_clk_hw_composite_flags("lcdif_pixel", imx8mm_lcdif_pixel_sels, base + 0xa500, CLK_SET_RATE_PARENT);
         |                                     ^
   cc1: some warnings being treated as errors


vim +471 drivers/clk/imx/clk-imx8mm.c

   298	
   299	static int imx8mm_clocks_probe(struct platform_device *pdev)
   300	{
   301		struct device *dev = &pdev->dev;
   302		struct device_node *np = dev->of_node;
   303		void __iomem *base;
   304		int ret;
   305	
   306		clk_hw_data = kzalloc(struct_size(clk_hw_data, hws,
   307						  IMX8MM_CLK_END), GFP_KERNEL);
   308		if (WARN_ON(!clk_hw_data))
   309			return -ENOMEM;
   310	
   311		clk_hw_data->num = IMX8MM_CLK_END;
   312		hws = clk_hw_data->hws;
   313	
   314		hws[IMX8MM_CLK_DUMMY] = imx_clk_hw_fixed("dummy", 0);
   315		hws[IMX8MM_CLK_24M] = imx_get_clk_hw_by_name(np, "osc_24m");
   316		hws[IMX8MM_CLK_32K] = imx_get_clk_hw_by_name(np, "osc_32k");
   317		hws[IMX8MM_CLK_EXT1] = imx_get_clk_hw_by_name(np, "clk_ext1");
   318		hws[IMX8MM_CLK_EXT2] = imx_get_clk_hw_by_name(np, "clk_ext2");
   319		hws[IMX8MM_CLK_EXT3] = imx_get_clk_hw_by_name(np, "clk_ext3");
   320		hws[IMX8MM_CLK_EXT4] = imx_get_clk_hw_by_name(np, "clk_ext4");
   321	
   322		np = of_find_compatible_node(NULL, NULL, "fsl,imx8mm-anatop");
   323		base = of_iomap(np, 0);
   324		of_node_put(np);
   325		if (WARN_ON(!base))
   326			return -ENOMEM;
   327	
   328		hws[IMX8MM_AUDIO_PLL1_REF_SEL] = imx_clk_hw_mux("audio_pll1_ref_sel", base + 0x0, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
   329		hws[IMX8MM_AUDIO_PLL2_REF_SEL] = imx_clk_hw_mux("audio_pll2_ref_sel", base + 0x14, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
   330		hws[IMX8MM_VIDEO_PLL1_REF_SEL] = imx_clk_hw_mux("video_pll1_ref_sel", base + 0x28, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
   331		hws[IMX8MM_DRAM_PLL_REF_SEL] = imx_clk_hw_mux("dram_pll_ref_sel", base + 0x50, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
   332		hws[IMX8MM_GPU_PLL_REF_SEL] = imx_clk_hw_mux("gpu_pll_ref_sel", base + 0x64, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
   333		hws[IMX8MM_VPU_PLL_REF_SEL] = imx_clk_hw_mux("vpu_pll_ref_sel", base + 0x74, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
   334		hws[IMX8MM_ARM_PLL_REF_SEL] = imx_clk_hw_mux("arm_pll_ref_sel", base + 0x84, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
   335		hws[IMX8MM_SYS_PLL3_REF_SEL] = imx_clk_hw_mux("sys_pll3_ref_sel", base + 0x114, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
   336	
   337		hws[IMX8MM_AUDIO_PLL1] = imx_clk_hw_pll14xx("audio_pll1", "audio_pll1_ref_sel", base, &imx_1443x_pll);
   338		hws[IMX8MM_AUDIO_PLL2] = imx_clk_hw_pll14xx("audio_pll2", "audio_pll2_ref_sel", base + 0x14, &imx_1443x_pll);
   339		hws[IMX8MM_VIDEO_PLL1] = imx_clk_hw_pll14xx("video_pll1", "video_pll1_ref_sel", base + 0x28, &imx_1443x_pll);
   340		hws[IMX8MM_DRAM_PLL] = imx_clk_hw_pll14xx("dram_pll", "dram_pll_ref_sel", base + 0x50, &imx_1443x_dram_pll);
   341		hws[IMX8MM_GPU_PLL] = imx_clk_hw_pll14xx("gpu_pll", "gpu_pll_ref_sel", base + 0x64, &imx_1416x_pll);
   342		hws[IMX8MM_VPU_PLL] = imx_clk_hw_pll14xx("vpu_pll", "vpu_pll_ref_sel", base + 0x74, &imx_1416x_pll);
   343		hws[IMX8MM_ARM_PLL] = imx_clk_hw_pll14xx("arm_pll", "arm_pll_ref_sel", base + 0x84, &imx_1416x_pll);
   344		hws[IMX8MM_SYS_PLL1] = imx_clk_hw_fixed("sys_pll1", 800000000);
   345		hws[IMX8MM_SYS_PLL2] = imx_clk_hw_fixed("sys_pll2", 1000000000);
   346		hws[IMX8MM_SYS_PLL3] = imx_clk_hw_pll14xx("sys_pll3", "sys_pll3_ref_sel", base + 0x114, &imx_1416x_pll);
   347	
   348		/* PLL bypass out */
   349		hws[IMX8MM_AUDIO_PLL1_BYPASS] = imx_clk_hw_mux_flags("audio_pll1_bypass", base, 16, 1, audio_pll1_bypass_sels, ARRAY_SIZE(audio_pll1_bypass_sels), CLK_SET_RATE_PARENT);
   350		hws[IMX8MM_AUDIO_PLL2_BYPASS] = imx_clk_hw_mux_flags("audio_pll2_bypass", base + 0x14, 16, 1, audio_pll2_bypass_sels, ARRAY_SIZE(audio_pll2_bypass_sels), CLK_SET_RATE_PARENT);
   351		hws[IMX8MM_VIDEO_PLL1_BYPASS] = imx_clk_hw_mux_flags("video_pll1_bypass", base + 0x28, 16, 1, video_pll1_bypass_sels, ARRAY_SIZE(video_pll1_bypass_sels), CLK_SET_RATE_PARENT);
   352		hws[IMX8MM_DRAM_PLL_BYPASS] = imx_clk_hw_mux_flags("dram_pll_bypass", base + 0x50, 16, 1, dram_pll_bypass_sels, ARRAY_SIZE(dram_pll_bypass_sels), CLK_SET_RATE_PARENT);
   353		hws[IMX8MM_GPU_PLL_BYPASS] = imx_clk_hw_mux_flags("gpu_pll_bypass", base + 0x64, 28, 1, gpu_pll_bypass_sels, ARRAY_SIZE(gpu_pll_bypass_sels), CLK_SET_RATE_PARENT);
   354		hws[IMX8MM_VPU_PLL_BYPASS] = imx_clk_hw_mux_flags("vpu_pll_bypass", base + 0x74, 28, 1, vpu_pll_bypass_sels, ARRAY_SIZE(vpu_pll_bypass_sels), CLK_SET_RATE_PARENT);
   355		hws[IMX8MM_ARM_PLL_BYPASS] = imx_clk_hw_mux_flags("arm_pll_bypass", base + 0x84, 28, 1, arm_pll_bypass_sels, ARRAY_SIZE(arm_pll_bypass_sels), CLK_SET_RATE_PARENT);
   356		hws[IMX8MM_SYS_PLL3_BYPASS] = imx_clk_hw_mux_flags("sys_pll3_bypass", base + 0x114, 28, 1, sys_pll3_bypass_sels, ARRAY_SIZE(sys_pll3_bypass_sels), CLK_SET_RATE_PARENT);
   357	
   358		/* PLL out gate */
   359		hws[IMX8MM_AUDIO_PLL1_OUT] = imx_clk_hw_gate("audio_pll1_out", "audio_pll1_bypass", base, 13);
   360		hws[IMX8MM_AUDIO_PLL2_OUT] = imx_clk_hw_gate("audio_pll2_out", "audio_pll2_bypass", base + 0x14, 13);
   361		hws[IMX8MM_VIDEO_PLL1_OUT] = imx_clk_hw_gate("video_pll1_out", "video_pll1_bypass", base + 0x28, 13);
   362		hws[IMX8MM_DRAM_PLL_OUT] = imx_clk_hw_gate("dram_pll_out", "dram_pll_bypass", base + 0x50, 13);
   363		hws[IMX8MM_GPU_PLL_OUT] = imx_clk_hw_gate("gpu_pll_out", "gpu_pll_bypass", base + 0x64, 11);
   364		hws[IMX8MM_VPU_PLL_OUT] = imx_clk_hw_gate("vpu_pll_out", "vpu_pll_bypass", base + 0x74, 11);
   365		hws[IMX8MM_ARM_PLL_OUT] = imx_clk_hw_gate("arm_pll_out", "arm_pll_bypass", base + 0x84, 11);
   366		hws[IMX8MM_SYS_PLL3_OUT] = imx_clk_hw_gate("sys_pll3_out", "sys_pll3_bypass", base + 0x114, 11);
   367	
   368		/* SYS PLL1 fixed output */
   369		hws[IMX8MM_SYS_PLL1_OUT] = imx_clk_hw_gate("sys_pll1_out", "sys_pll1", base + 0x94, 11);
   370	
   371		hws[IMX8MM_SYS_PLL1_40M] = imx_clk_hw_fixed_factor("sys_pll1_40m", "sys_pll1_out", 1, 20);
   372		hws[IMX8MM_SYS_PLL1_80M] = imx_clk_hw_fixed_factor("sys_pll1_80m", "sys_pll1_out", 1, 10);
   373		hws[IMX8MM_SYS_PLL1_100M] = imx_clk_hw_fixed_factor("sys_pll1_100m", "sys_pll1_out", 1, 8);
   374		hws[IMX8MM_SYS_PLL1_133M] = imx_clk_hw_fixed_factor("sys_pll1_133m", "sys_pll1_out", 1, 6);
   375		hws[IMX8MM_SYS_PLL1_160M] = imx_clk_hw_fixed_factor("sys_pll1_160m", "sys_pll1_out", 1, 5);
   376		hws[IMX8MM_SYS_PLL1_200M] = imx_clk_hw_fixed_factor("sys_pll1_200m", "sys_pll1_out", 1, 4);
   377		hws[IMX8MM_SYS_PLL1_266M] = imx_clk_hw_fixed_factor("sys_pll1_266m", "sys_pll1_out", 1, 3);
   378		hws[IMX8MM_SYS_PLL1_400M] = imx_clk_hw_fixed_factor("sys_pll1_400m", "sys_pll1_out", 1, 2);
   379		hws[IMX8MM_SYS_PLL1_800M] = imx_clk_hw_fixed_factor("sys_pll1_800m", "sys_pll1_out", 1, 1);
   380	
   381		/* SYS PLL2 fixed output */
   382		hws[IMX8MM_SYS_PLL2_OUT] = imx_clk_hw_gate("sys_pll2_out", "sys_pll2", base + 0x104, 11);
   383		hws[IMX8MM_SYS_PLL2_50M] = imx_clk_hw_fixed_factor("sys_pll2_50m", "sys_pll2_out", 1, 20);
   384		hws[IMX8MM_SYS_PLL2_100M] = imx_clk_hw_fixed_factor("sys_pll2_100m", "sys_pll2_out", 1, 10);
   385		hws[IMX8MM_SYS_PLL2_125M] = imx_clk_hw_fixed_factor("sys_pll2_125m", "sys_pll2_out", 1, 8);
   386		hws[IMX8MM_SYS_PLL2_166M] = imx_clk_hw_fixed_factor("sys_pll2_166m", "sys_pll2_out", 1, 6);
   387		hws[IMX8MM_SYS_PLL2_200M] = imx_clk_hw_fixed_factor("sys_pll2_200m", "sys_pll2_out", 1, 5);
   388		hws[IMX8MM_SYS_PLL2_250M] = imx_clk_hw_fixed_factor("sys_pll2_250m", "sys_pll2_out", 1, 4);
   389		hws[IMX8MM_SYS_PLL2_333M] = imx_clk_hw_fixed_factor("sys_pll2_333m", "sys_pll2_out", 1, 3);
   390		hws[IMX8MM_SYS_PLL2_500M] = imx_clk_hw_fixed_factor("sys_pll2_500m", "sys_pll2_out", 1, 2);
   391		hws[IMX8MM_SYS_PLL2_1000M] = imx_clk_hw_fixed_factor("sys_pll2_1000m", "sys_pll2_out", 1, 1);
   392	
   393		hws[IMX8MM_CLK_CLKOUT1_SEL] = imx_clk_hw_mux2("clkout1_sel", base + 0x128, 4, 4, clkout_sels, ARRAY_SIZE(clkout_sels));
   394		hws[IMX8MM_CLK_CLKOUT1_DIV] = imx_clk_hw_divider("clkout1_div", "clkout1_sel", base + 0x128, 0, 4);
   395		hws[IMX8MM_CLK_CLKOUT1] = imx_clk_hw_gate("clkout1", "clkout1_div", base + 0x128, 8);
   396		hws[IMX8MM_CLK_CLKOUT2_SEL] = imx_clk_hw_mux2("clkout2_sel", base + 0x128, 20, 4, clkout_sels, ARRAY_SIZE(clkout_sels));
   397		hws[IMX8MM_CLK_CLKOUT2_DIV] = imx_clk_hw_divider("clkout2_div", "clkout2_sel", base + 0x128, 16, 4);
   398		hws[IMX8MM_CLK_CLKOUT2] = imx_clk_hw_gate("clkout2", "clkout2_div", base + 0x128, 24);
   399	
   400		np = dev->of_node;
   401		base = devm_platform_ioremap_resource(pdev, 0);
   402		if (WARN_ON(IS_ERR(base)))
   403			return PTR_ERR(base);
   404	
   405		/* Core Slice */
   406		hws[IMX8MM_CLK_A53_DIV] = imx8m_clk_hw_composite_core("arm_a53_div", imx8mm_a53_sels, base + 0x8000);
   407		hws[IMX8MM_CLK_A53_CG] = hws[IMX8MM_CLK_A53_DIV];
   408		hws[IMX8MM_CLK_A53_SRC] = hws[IMX8MM_CLK_A53_DIV];
   409	
   410		hws[IMX8MM_CLK_M4_CORE] = imx8m_clk_hw_composite_core("arm_m4_core", imx8mm_m4_sels, base + 0x8080);
   411		hws[IMX8MM_CLK_VPU_CORE] = imx8m_clk_hw_composite_core("vpu_core", imx8mm_vpu_sels, base + 0x8100);
   412		hws[IMX8MM_CLK_GPU3D_CORE] = imx8m_clk_hw_composite_core("gpu3d_core", imx8mm_gpu3d_sels, base + 0x8180);
   413		hws[IMX8MM_CLK_GPU2D_CORE] = imx8m_clk_hw_composite_core("gpu2d_core", imx8mm_gpu2d_sels, base + 0x8200);
   414	
   415		/* For backwards compatibility */
   416		hws[IMX8MM_CLK_M4_SRC] = hws[IMX8MM_CLK_M4_CORE];
   417		hws[IMX8MM_CLK_M4_CG] = hws[IMX8MM_CLK_M4_CORE];
   418		hws[IMX8MM_CLK_M4_DIV] = hws[IMX8MM_CLK_M4_CORE];
   419		hws[IMX8MM_CLK_VPU_SRC] = hws[IMX8MM_CLK_VPU_CORE];
   420		hws[IMX8MM_CLK_VPU_CG] = hws[IMX8MM_CLK_VPU_CORE];
   421		hws[IMX8MM_CLK_VPU_DIV] = hws[IMX8MM_CLK_VPU_CORE];
   422		hws[IMX8MM_CLK_GPU3D_SRC] = hws[IMX8MM_CLK_GPU3D_CORE];
   423		hws[IMX8MM_CLK_GPU3D_CG] = hws[IMX8MM_CLK_GPU3D_CORE];
   424		hws[IMX8MM_CLK_GPU3D_DIV] = hws[IMX8MM_CLK_GPU3D_CORE];
   425		hws[IMX8MM_CLK_GPU2D_SRC] = hws[IMX8MM_CLK_GPU2D_CORE];
   426		hws[IMX8MM_CLK_GPU2D_CG] = hws[IMX8MM_CLK_GPU2D_CORE];
   427		hws[IMX8MM_CLK_GPU2D_DIV] = hws[IMX8MM_CLK_GPU2D_CORE];
   428	
   429		/* CORE SEL */
   430		hws[IMX8MM_CLK_A53_CORE] = imx_clk_hw_mux2("arm_a53_core", base + 0x9880, 24, 1, imx8mm_a53_core_sels, ARRAY_SIZE(imx8mm_a53_core_sels));
   431	
   432		/* BUS */
   433		hws[IMX8MM_CLK_MAIN_AXI] = imx8m_clk_hw_composite_bus_critical("main_axi",  imx8mm_main_axi_sels, base + 0x8800);
   434		hws[IMX8MM_CLK_ENET_AXI] = imx8m_clk_hw_composite_bus("enet_axi", imx8mm_enet_axi_sels, base + 0x8880);
   435		hws[IMX8MM_CLK_NAND_USDHC_BUS] = imx8m_clk_hw_composite_bus_critical("nand_usdhc_bus", imx8mm_nand_usdhc_sels, base + 0x8900);
   436		hws[IMX8MM_CLK_VPU_BUS] = imx8m_clk_hw_composite_bus("vpu_bus", imx8mm_vpu_bus_sels, base + 0x8980);
   437		hws[IMX8MM_CLK_DISP_AXI] = imx8m_clk_hw_composite_bus("disp_axi", imx8mm_disp_axi_sels, base + 0x8a00);
   438		hws[IMX8MM_CLK_DISP_APB] = imx8m_clk_hw_composite_bus("disp_apb", imx8mm_disp_apb_sels, base + 0x8a80);
   439		hws[IMX8MM_CLK_DISP_RTRM] = imx8m_clk_hw_composite_bus("disp_rtrm", imx8mm_disp_rtrm_sels, base + 0x8b00);
   440		hws[IMX8MM_CLK_USB_BUS] = imx8m_clk_hw_composite_bus("usb_bus", imx8mm_usb_bus_sels, base + 0x8b80);
   441		hws[IMX8MM_CLK_GPU_AXI] = imx8m_clk_hw_composite_bus("gpu_axi", imx8mm_gpu_axi_sels, base + 0x8c00);
   442		hws[IMX8MM_CLK_GPU_AHB] = imx8m_clk_hw_composite_bus("gpu_ahb", imx8mm_gpu_ahb_sels, base + 0x8c80);
   443		hws[IMX8MM_CLK_NOC] = imx8m_clk_hw_composite_bus_critical("noc", imx8mm_noc_sels, base + 0x8d00);
   444		hws[IMX8MM_CLK_NOC_APB] = imx8m_clk_hw_composite_bus_critical("noc_apb", imx8mm_noc_apb_sels, base + 0x8d80);
   445	
   446		/* AHB */
   447		hws[IMX8MM_CLK_AHB] = imx8m_clk_hw_composite_bus_critical("ahb", imx8mm_ahb_sels, base + 0x9000);
   448		hws[IMX8MM_CLK_AUDIO_AHB] = imx8m_clk_hw_composite_bus("audio_ahb", imx8mm_audio_ahb_sels, base + 0x9100);
   449	
   450		/* IPG */
   451		hws[IMX8MM_CLK_IPG_ROOT] = imx_clk_hw_divider2("ipg_root", "ahb", base + 0x9080, 0, 1);
   452		hws[IMX8MM_CLK_IPG_AUDIO_ROOT] = imx_clk_hw_divider2("ipg_audio_root", "audio_ahb", base + 0x9180, 0, 1);
   453	
   454		/*
   455		 * DRAM clocks are manipulated from TF-A outside clock framework.
   456		 * The fw_managed helper sets GET_RATE_NOCACHE and clears SET_PARENT_GATE
   457		 * as div value should always be read from hardware
   458		 */
   459		hws[IMX8MM_CLK_DRAM_ALT] = imx8m_clk_hw_fw_managed_composite("dram_alt", imx8mm_dram_alt_sels, base + 0xa000);
   460		hws[IMX8MM_CLK_DRAM_APB] = imx8m_clk_hw_fw_managed_composite_critical("dram_apb", imx8mm_dram_apb_sels, base + 0xa080);
   461	
   462		/* IP */
   463		hws[IMX8MM_CLK_VPU_G1] = imx8m_clk_hw_composite("vpu_g1", imx8mm_vpu_g1_sels, base + 0xa100);
   464		hws[IMX8MM_CLK_VPU_G2] = imx8m_clk_hw_composite("vpu_g2", imx8mm_vpu_g2_sels, base + 0xa180);
   465		hws[IMX8MM_CLK_DISP_DTRC] = imx8m_clk_hw_composite("disp_dtrc", imx8mm_disp_dtrc_sels, base + 0xa200);
   466		hws[IMX8MM_CLK_DISP_DC8000] = imx8m_clk_hw_composite("disp_dc8000", imx8mm_disp_dc8000_sels, base + 0xa280);
   467		hws[IMX8MM_CLK_PCIE1_CTRL] = imx8m_clk_hw_composite("pcie1_ctrl", imx8mm_pcie1_ctrl_sels, base + 0xa300);
   468		hws[IMX8MM_CLK_PCIE1_PHY] = imx8m_clk_hw_composite("pcie1_phy", imx8mm_pcie1_phy_sels, base + 0xa380);
   469		hws[IMX8MM_CLK_PCIE1_AUX] = imx8m_clk_hw_composite("pcie1_aux", imx8mm_pcie1_aux_sels, base + 0xa400);
   470		hws[IMX8MM_CLK_DC_PIXEL] = imx8m_clk_hw_composite("dc_pixel", imx8mm_dc_pixel_sels, base + 0xa480);
 > 471		hws[IMX8MM_CLK_LCDIF_PIXEL] = imx8m_clk_hw_composite_flags("lcdif_pixel", imx8mm_lcdif_pixel_sels, base + 0xa500, CLK_SET_RATE_PARENT);
   472		hws[IMX8MM_CLK_SAI1] = imx8m_clk_hw_composite("sai1", imx8mm_sai1_sels, base + 0xa580);
   473		hws[IMX8MM_CLK_SAI2] = imx8m_clk_hw_composite("sai2", imx8mm_sai2_sels, base + 0xa600);
   474		hws[IMX8MM_CLK_SAI3] = imx8m_clk_hw_composite("sai3", imx8mm_sai3_sels, base + 0xa680);
   475		hws[IMX8MM_CLK_SAI4] = imx8m_clk_hw_composite("sai4", imx8mm_sai4_sels, base + 0xa700);
   476		hws[IMX8MM_CLK_SAI5] = imx8m_clk_hw_composite("sai5", imx8mm_sai5_sels, base + 0xa780);
   477		hws[IMX8MM_CLK_SAI6] = imx8m_clk_hw_composite("sai6", imx8mm_sai6_sels, base + 0xa800);
   478		hws[IMX8MM_CLK_SPDIF1] = imx8m_clk_hw_composite("spdif1", imx8mm_spdif1_sels, base + 0xa880);
   479		hws[IMX8MM_CLK_SPDIF2] = imx8m_clk_hw_composite("spdif2", imx8mm_spdif2_sels, base + 0xa900);
   480		hws[IMX8MM_CLK_ENET_REF] = imx8m_clk_hw_composite("enet_ref", imx8mm_enet_ref_sels, base + 0xa980);
   481		hws[IMX8MM_CLK_ENET_TIMER] = imx8m_clk_hw_composite("enet_timer", imx8mm_enet_timer_sels, base + 0xaa00);
   482		hws[IMX8MM_CLK_ENET_PHY_REF] = imx8m_clk_hw_composite("enet_phy", imx8mm_enet_phy_sels, base + 0xaa80);
   483		hws[IMX8MM_CLK_NAND] = imx8m_clk_hw_composite("nand", imx8mm_nand_sels, base + 0xab00);
   484		hws[IMX8MM_CLK_QSPI] = imx8m_clk_hw_composite("qspi", imx8mm_qspi_sels, base + 0xab80);
   485		hws[IMX8MM_CLK_USDHC1] = imx8m_clk_hw_composite("usdhc1", imx8mm_usdhc1_sels, base + 0xac00);
   486		hws[IMX8MM_CLK_USDHC2] = imx8m_clk_hw_composite("usdhc2", imx8mm_usdhc2_sels, base + 0xac80);
   487		hws[IMX8MM_CLK_I2C1] = imx8m_clk_hw_composite("i2c1", imx8mm_i2c1_sels, base + 0xad00);
   488		hws[IMX8MM_CLK_I2C2] = imx8m_clk_hw_composite("i2c2", imx8mm_i2c2_sels, base + 0xad80);
   489		hws[IMX8MM_CLK_I2C3] = imx8m_clk_hw_composite("i2c3", imx8mm_i2c3_sels, base + 0xae00);
   490		hws[IMX8MM_CLK_I2C4] = imx8m_clk_hw_composite("i2c4", imx8mm_i2c4_sels, base + 0xae80);
   491		hws[IMX8MM_CLK_UART1] = imx8m_clk_hw_composite("uart1", imx8mm_uart1_sels, base + 0xaf00);
   492		hws[IMX8MM_CLK_UART2] = imx8m_clk_hw_composite("uart2", imx8mm_uart2_sels, base + 0xaf80);
   493		hws[IMX8MM_CLK_UART3] = imx8m_clk_hw_composite("uart3", imx8mm_uart3_sels, base + 0xb000);
   494		hws[IMX8MM_CLK_UART4] = imx8m_clk_hw_composite("uart4", imx8mm_uart4_sels, base + 0xb080);
   495		hws[IMX8MM_CLK_USB_CORE_REF] = imx8m_clk_hw_composite("usb_core_ref", imx8mm_usb_core_sels, base + 0xb100);
   496		hws[IMX8MM_CLK_USB_PHY_REF] = imx8m_clk_hw_composite("usb_phy_ref", imx8mm_usb_phy_sels, base + 0xb180);
   497		hws[IMX8MM_CLK_GIC] = imx8m_clk_hw_composite_critical("gic", imx8mm_gic_sels, base + 0xb200);
   498		hws[IMX8MM_CLK_ECSPI1] = imx8m_clk_hw_composite("ecspi1", imx8mm_ecspi1_sels, base + 0xb280);
   499		hws[IMX8MM_CLK_ECSPI2] = imx8m_clk_hw_composite("ecspi2", imx8mm_ecspi2_sels, base + 0xb300);
   500		hws[IMX8MM_CLK_PWM1] = imx8m_clk_hw_composite("pwm1", imx8mm_pwm1_sels, base + 0xb380);
   501		hws[IMX8MM_CLK_PWM2] = imx8m_clk_hw_composite("pwm2", imx8mm_pwm2_sels, base + 0xb400);
   502		hws[IMX8MM_CLK_PWM3] = imx8m_clk_hw_composite("pwm3", imx8mm_pwm3_sels, base + 0xb480);
   503		hws[IMX8MM_CLK_PWM4] = imx8m_clk_hw_composite("pwm4", imx8mm_pwm4_sels, base + 0xb500);
   504		hws[IMX8MM_CLK_GPT1] = imx8m_clk_hw_composite("gpt1", imx8mm_gpt1_sels, base + 0xb580);
   505		hws[IMX8MM_CLK_WDOG] = imx8m_clk_hw_composite("wdog", imx8mm_wdog_sels, base + 0xb900);
   506		hws[IMX8MM_CLK_WRCLK] = imx8m_clk_hw_composite("wrclk", imx8mm_wrclk_sels, base + 0xb980);
   507		hws[IMX8MM_CLK_CLKO1] = imx8m_clk_hw_composite("clko1", imx8mm_clko1_sels, base + 0xba00);
   508		hws[IMX8MM_CLK_CLKO2] = imx8m_clk_hw_composite("clko2", imx8mm_clko2_sels, base + 0xba80);
   509		hws[IMX8MM_CLK_DSI_CORE] = imx8m_clk_hw_composite("dsi_core", imx8mm_dsi_core_sels, base + 0xbb00);
   510		hws[IMX8MM_CLK_DSI_PHY_REF] = imx8m_clk_hw_composite("dsi_phy_ref", imx8mm_dsi_phy_sels, base + 0xbb80);
   511		hws[IMX8MM_CLK_DSI_DBI] = imx8m_clk_hw_composite("dsi_dbi", imx8mm_dsi_dbi_sels, base + 0xbc00);
   512		hws[IMX8MM_CLK_USDHC3] = imx8m_clk_hw_composite("usdhc3", imx8mm_usdhc3_sels, base + 0xbc80);
   513		hws[IMX8MM_CLK_CSI1_CORE] = imx8m_clk_hw_composite("csi1_core", imx8mm_csi1_core_sels, base + 0xbd00);
   514		hws[IMX8MM_CLK_CSI1_PHY_REF] = imx8m_clk_hw_composite("csi1_phy_ref", imx8mm_csi1_phy_sels, base + 0xbd80);
   515		hws[IMX8MM_CLK_CSI1_ESC] = imx8m_clk_hw_composite("csi1_esc", imx8mm_csi1_esc_sels, base + 0xbe00);
   516		hws[IMX8MM_CLK_CSI2_CORE] = imx8m_clk_hw_composite("csi2_core", imx8mm_csi2_core_sels, base + 0xbe80);
   517		hws[IMX8MM_CLK_CSI2_PHY_REF] = imx8m_clk_hw_composite("csi2_phy_ref", imx8mm_csi2_phy_sels, base + 0xbf00);
   518		hws[IMX8MM_CLK_CSI2_ESC] = imx8m_clk_hw_composite("csi2_esc", imx8mm_csi2_esc_sels, base + 0xbf80);
   519		hws[IMX8MM_CLK_PCIE2_CTRL] = imx8m_clk_hw_composite("pcie2_ctrl", imx8mm_pcie2_ctrl_sels, base + 0xc000);
   520		hws[IMX8MM_CLK_PCIE2_PHY] = imx8m_clk_hw_composite("pcie2_phy", imx8mm_pcie2_phy_sels, base + 0xc080);
   521		hws[IMX8MM_CLK_PCIE2_AUX] = imx8m_clk_hw_composite("pcie2_aux", imx8mm_pcie2_aux_sels, base + 0xc100);
   522		hws[IMX8MM_CLK_ECSPI3] = imx8m_clk_hw_composite("ecspi3", imx8mm_ecspi3_sels, base + 0xc180);
   523		hws[IMX8MM_CLK_PDM] = imx8m_clk_hw_composite("pdm", imx8mm_pdm_sels, base + 0xc200);
   524		hws[IMX8MM_CLK_VPU_H1] = imx8m_clk_hw_composite("vpu_h1", imx8mm_vpu_h1_sels, base + 0xc280);
   525	
   526		/* CCGR */
   527		hws[IMX8MM_CLK_ECSPI1_ROOT] = imx_clk_hw_gate4("ecspi1_root_clk", "ecspi1", base + 0x4070, 0);
   528		hws[IMX8MM_CLK_ECSPI2_ROOT] = imx_clk_hw_gate4("ecspi2_root_clk", "ecspi2", base + 0x4080, 0);
   529		hws[IMX8MM_CLK_ECSPI3_ROOT] = imx_clk_hw_gate4("ecspi3_root_clk", "ecspi3", base + 0x4090, 0);
   530		hws[IMX8MM_CLK_ENET1_ROOT] = imx_clk_hw_gate4("enet1_root_clk", "enet_axi", base + 0x40a0, 0);
   531		hws[IMX8MM_CLK_GPIO1_ROOT] = imx_clk_hw_gate4("gpio1_root_clk", "ipg_root", base + 0x40b0, 0);
   532		hws[IMX8MM_CLK_GPIO2_ROOT] = imx_clk_hw_gate4("gpio2_root_clk", "ipg_root", base + 0x40c0, 0);
   533		hws[IMX8MM_CLK_GPIO3_ROOT] = imx_clk_hw_gate4("gpio3_root_clk", "ipg_root", base + 0x40d0, 0);
   534		hws[IMX8MM_CLK_GPIO4_ROOT] = imx_clk_hw_gate4("gpio4_root_clk", "ipg_root", base + 0x40e0, 0);
   535		hws[IMX8MM_CLK_GPIO5_ROOT] = imx_clk_hw_gate4("gpio5_root_clk", "ipg_root", base + 0x40f0, 0);
   536		hws[IMX8MM_CLK_GPT1_ROOT] = imx_clk_hw_gate4("gpt1_root_clk", "gpt1", base + 0x4100, 0);
   537		hws[IMX8MM_CLK_I2C1_ROOT] = imx_clk_hw_gate4("i2c1_root_clk", "i2c1", base + 0x4170, 0);
   538		hws[IMX8MM_CLK_I2C2_ROOT] = imx_clk_hw_gate4("i2c2_root_clk", "i2c2", base + 0x4180, 0);
   539		hws[IMX8MM_CLK_I2C3_ROOT] = imx_clk_hw_gate4("i2c3_root_clk", "i2c3", base + 0x4190, 0);
   540		hws[IMX8MM_CLK_I2C4_ROOT] = imx_clk_hw_gate4("i2c4_root_clk", "i2c4", base + 0x41a0, 0);
   541		hws[IMX8MM_CLK_MU_ROOT] = imx_clk_hw_gate4("mu_root_clk", "ipg_root", base + 0x4210, 0);
   542		hws[IMX8MM_CLK_OCOTP_ROOT] = imx_clk_hw_gate4("ocotp_root_clk", "ipg_root", base + 0x4220, 0);
   543		hws[IMX8MM_CLK_PCIE1_ROOT] = imx_clk_hw_gate4("pcie1_root_clk", "pcie1_ctrl", base + 0x4250, 0);
   544		hws[IMX8MM_CLK_PWM1_ROOT] = imx_clk_hw_gate4("pwm1_root_clk", "pwm1", base + 0x4280, 0);
   545		hws[IMX8MM_CLK_PWM2_ROOT] = imx_clk_hw_gate4("pwm2_root_clk", "pwm2", base + 0x4290, 0);
   546		hws[IMX8MM_CLK_PWM3_ROOT] = imx_clk_hw_gate4("pwm3_root_clk", "pwm3", base + 0x42a0, 0);
   547		hws[IMX8MM_CLK_PWM4_ROOT] = imx_clk_hw_gate4("pwm4_root_clk", "pwm4", base + 0x42b0, 0);
   548		hws[IMX8MM_CLK_QSPI_ROOT] = imx_clk_hw_gate4("qspi_root_clk", "qspi", base + 0x42f0, 0);
   549		hws[IMX8MM_CLK_NAND_ROOT] = imx_clk_hw_gate2_shared2("nand_root_clk", "nand", base + 0x4300, 0, &share_count_nand);
   550		hws[IMX8MM_CLK_NAND_USDHC_BUS_RAWNAND_CLK] = imx_clk_hw_gate2_shared2("nand_usdhc_rawnand_clk", "nand_usdhc_bus", base + 0x4300, 0, &share_count_nand);
   551		hws[IMX8MM_CLK_SAI1_ROOT] = imx_clk_hw_gate2_shared2("sai1_root_clk", "sai1", base + 0x4330, 0, &share_count_sai1);
   552		hws[IMX8MM_CLK_SAI1_IPG] = imx_clk_hw_gate2_shared2("sai1_ipg_clk", "ipg_audio_root", base + 0x4330, 0, &share_count_sai1);
   553		hws[IMX8MM_CLK_SAI2_ROOT] = imx_clk_hw_gate2_shared2("sai2_root_clk", "sai2", base + 0x4340, 0, &share_count_sai2);
   554		hws[IMX8MM_CLK_SAI2_IPG] = imx_clk_hw_gate2_shared2("sai2_ipg_clk", "ipg_audio_root", base + 0x4340, 0, &share_count_sai2);
   555		hws[IMX8MM_CLK_SAI3_ROOT] = imx_clk_hw_gate2_shared2("sai3_root_clk", "sai3", base + 0x4350, 0, &share_count_sai3);
   556		hws[IMX8MM_CLK_SAI3_IPG] = imx_clk_hw_gate2_shared2("sai3_ipg_clk", "ipg_audio_root", base + 0x4350, 0, &share_count_sai3);
   557		hws[IMX8MM_CLK_SAI4_ROOT] = imx_clk_hw_gate2_shared2("sai4_root_clk", "sai4", base + 0x4360, 0, &share_count_sai4);
   558		hws[IMX8MM_CLK_SAI4_IPG] = imx_clk_hw_gate2_shared2("sai4_ipg_clk", "ipg_audio_root", base + 0x4360, 0, &share_count_sai4);
   559		hws[IMX8MM_CLK_SAI5_ROOT] = imx_clk_hw_gate2_shared2("sai5_root_clk", "sai5", base + 0x4370, 0, &share_count_sai5);
   560		hws[IMX8MM_CLK_SAI5_IPG] = imx_clk_hw_gate2_shared2("sai5_ipg_clk", "ipg_audio_root", base + 0x4370, 0, &share_count_sai5);
   561		hws[IMX8MM_CLK_SAI6_ROOT] = imx_clk_hw_gate2_shared2("sai6_root_clk", "sai6", base + 0x4380, 0, &share_count_sai6);
   562		hws[IMX8MM_CLK_SAI6_IPG] = imx_clk_hw_gate2_shared2("sai6_ipg_clk", "ipg_audio_root", base + 0x4380, 0, &share_count_sai6);
   563		hws[IMX8MM_CLK_UART1_ROOT] = imx_clk_hw_gate4("uart1_root_clk", "uart1", base + 0x4490, 0);
   564		hws[IMX8MM_CLK_UART2_ROOT] = imx_clk_hw_gate4("uart2_root_clk", "uart2", base + 0x44a0, 0);
   565		hws[IMX8MM_CLK_UART3_ROOT] = imx_clk_hw_gate4("uart3_root_clk", "uart3", base + 0x44b0, 0);
   566		hws[IMX8MM_CLK_UART4_ROOT] = imx_clk_hw_gate4("uart4_root_clk", "uart4", base + 0x44c0, 0);
   567		hws[IMX8MM_CLK_USB1_CTRL_ROOT] = imx_clk_hw_gate4("usb1_ctrl_root_clk", "usb_bus", base + 0x44d0, 0);
   568		hws[IMX8MM_CLK_GPU3D_ROOT] = imx_clk_hw_gate4("gpu3d_root_clk", "gpu3d_core", base + 0x44f0, 0);
   569		hws[IMX8MM_CLK_USDHC1_ROOT] = imx_clk_hw_gate4("usdhc1_root_clk", "usdhc1", base + 0x4510, 0);
   570		hws[IMX8MM_CLK_USDHC2_ROOT] = imx_clk_hw_gate4("usdhc2_root_clk", "usdhc2", base + 0x4520, 0);
   571		hws[IMX8MM_CLK_WDOG1_ROOT] = imx_clk_hw_gate4("wdog1_root_clk", "wdog", base + 0x4530, 0);
   572		hws[IMX8MM_CLK_WDOG2_ROOT] = imx_clk_hw_gate4("wdog2_root_clk", "wdog", base + 0x4540, 0);
   573		hws[IMX8MM_CLK_WDOG3_ROOT] = imx_clk_hw_gate4("wdog3_root_clk", "wdog", base + 0x4550, 0);
   574		hws[IMX8MM_CLK_VPU_G1_ROOT] = imx_clk_hw_gate4("vpu_g1_root_clk", "vpu_g1", base + 0x4560, 0);
   575		hws[IMX8MM_CLK_GPU_BUS_ROOT] = imx_clk_hw_gate4("gpu_root_clk", "gpu_axi", base + 0x4570, 0);
   576		hws[IMX8MM_CLK_VPU_H1_ROOT] = imx_clk_hw_gate4("vpu_h1_root_clk", "vpu_h1", base + 0x4590, 0);
   577		hws[IMX8MM_CLK_VPU_G2_ROOT] = imx_clk_hw_gate4("vpu_g2_root_clk", "vpu_g2", base + 0x45a0, 0);
   578		hws[IMX8MM_CLK_PDM_ROOT] = imx_clk_hw_gate2_shared2("pdm_root_clk", "pdm", base + 0x45b0, 0, &share_count_pdm);
   579		hws[IMX8MM_CLK_PDM_IPG]  = imx_clk_hw_gate2_shared2("pdm_ipg_clk", "ipg_audio_root", base + 0x45b0, 0, &share_count_pdm);
   580		hws[IMX8MM_CLK_DISP_ROOT] = imx_clk_hw_gate2_shared2("disp_root_clk", "disp_dc8000", base + 0x45d0, 0, &share_count_disp);
   581		hws[IMX8MM_CLK_DISP_AXI_ROOT]  = imx_clk_hw_gate2_shared2("disp_axi_root_clk", "disp_axi", base + 0x45d0, 0, &share_count_disp);
   582		hws[IMX8MM_CLK_DISP_APB_ROOT]  = imx_clk_hw_gate2_shared2("disp_apb_root_clk", "disp_apb", base + 0x45d0, 0, &share_count_disp);
   583		hws[IMX8MM_CLK_DISP_RTRM_ROOT] = imx_clk_hw_gate2_shared2("disp_rtrm_root_clk", "disp_rtrm", base + 0x45d0, 0, &share_count_disp);
   584		hws[IMX8MM_CLK_USDHC3_ROOT] = imx_clk_hw_gate4("usdhc3_root_clk", "usdhc3", base + 0x45e0, 0);
   585		hws[IMX8MM_CLK_TMU_ROOT] = imx_clk_hw_gate4("tmu_root_clk", "ipg_root", base + 0x4620, 0);
   586		hws[IMX8MM_CLK_VPU_DEC_ROOT] = imx_clk_hw_gate4("vpu_dec_root_clk", "vpu_bus", base + 0x4630, 0);
   587		hws[IMX8MM_CLK_SDMA1_ROOT] = imx_clk_hw_gate4("sdma1_clk", "ipg_root", base + 0x43a0, 0);
   588		hws[IMX8MM_CLK_SDMA2_ROOT] = imx_clk_hw_gate4("sdma2_clk", "ipg_audio_root", base + 0x43b0, 0);
   589		hws[IMX8MM_CLK_SDMA3_ROOT] = imx_clk_hw_gate4("sdma3_clk", "ipg_audio_root", base + 0x45f0, 0);
   590		hws[IMX8MM_CLK_GPU2D_ROOT] = imx_clk_hw_gate4("gpu2d_root_clk", "gpu2d_core", base + 0x4660, 0);
   591		hws[IMX8MM_CLK_CSI1_ROOT] = imx_clk_hw_gate4("csi1_root_clk", "csi1_core", base + 0x4650, 0);
   592	
   593		hws[IMX8MM_CLK_GPT_3M] = imx_clk_hw_fixed_factor("gpt_3m", "osc_24m", 1, 8);
   594	
   595		hws[IMX8MM_CLK_DRAM_ALT_ROOT] = imx_clk_hw_fixed_factor("dram_alt_root", "dram_alt", 1, 4);
   596		hws[IMX8MM_CLK_DRAM_CORE] = imx_clk_hw_mux2_flags("dram_core_clk", base + 0x9800, 24, 1, imx8mm_dram_core_sels, ARRAY_SIZE(imx8mm_dram_core_sels), CLK_IS_CRITICAL);
   597	
   598		hws[IMX8MM_CLK_ARM] = imx_clk_hw_cpu("arm", "arm_a53_core",
   599						   hws[IMX8MM_CLK_A53_CORE]->clk,
   600						   hws[IMX8MM_CLK_A53_CORE]->clk,
   601						   hws[IMX8MM_ARM_PLL_OUT]->clk,
   602						   hws[IMX8MM_CLK_A53_DIV]->clk);
   603	
   604		imx_check_clk_hws(hws, IMX8MM_CLK_END);
   605	
   606		ret = of_clk_add_hw_provider(np, of_clk_hw_onecell_get, clk_hw_data);
   607		if (ret < 0) {
   608			dev_err(dev, "failed to register clks for i.MX8MM\n");
   609			goto unregister_hws;
   610		}
   611	
   612		imx_register_uart_clocks();
   613	
   614		return 0;
   615	
   616	unregister_hws:
   617		imx_unregister_hw_clocks(hws, IMX8MM_CLK_END);
   618	
   619		return ret;
   620	}
   621	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
