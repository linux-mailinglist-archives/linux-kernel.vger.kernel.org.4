Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0A6B5B959F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 09:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbiIOHn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 03:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbiIOHny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 03:43:54 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D89EA95688;
        Thu, 15 Sep 2022 00:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663227828; x=1694763828;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Gmi1uupfeiTsM7Pv2XxhkH9gPpBSz3LGI2IQCHIwip0=;
  b=aB/IwcMDJtHDF7kgmO6Pqj8FFQCUrLLSkvfKD9D0CEElgOGQECnzWfG+
   jRD29/af5OFb5hZc+A643Tex0lL1x5DT6d5KifFwzqabDp8qI6LkEXLrG
   YHkD9qG6KQR64oocjomR6GozVtf6OpUYAnL8/n1ooeTsw2khO8ENCGkOn
   nhiuoJ5o0eP+EKfkaAXePQRP4n8Qe9j+8iJ6nXX06XlkfHBDfz/9HV3lh
   zn6P4qxvb19H+hpNkzKBqmmIaIkrADxildTqXLphje5ODgSv5yYqmOXaH
   yCgPMPsDmjoNlc5y7nLLUc0KcAbhmR+T/p6FAVbc5GD5XNjBkeMOnWLhP
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10470"; a="281672383"
X-IronPort-AV: E=Sophos;i="5.93,317,1654585200"; 
   d="scan'208";a="281672383"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2022 00:43:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,317,1654585200"; 
   d="scan'208";a="742837959"
Received: from lkp-server02.sh.intel.com (HELO 41300c7200ea) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 15 Sep 2022 00:43:43 -0700
Received: from kbuild by 41300c7200ea with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oYjXC-0000Be-2V;
        Thu, 15 Sep 2022 07:43:42 +0000
Date:   Thu, 15 Sep 2022 15:42:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Han Xu <han.xu@nxp.com>, Abel Vesa <abelvesa@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:NXP i.MX CLOCK DRIVERS" <linux-clk@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     kbuild-all@lists.01.org, miquel.raynal@bootlin.com,
        linux-mtd@lists.infradead.org, han.xu@nxp.com
Subject: Re: [PATCH] clk: imx: imx6sx: remove the SET_RATE_PARENT flag for
 QSPI clocks
Message-ID: <202209151545.eB4Mrylw-lkp@intel.com>
References: <20220914201049.3508104-2-han.xu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220914201049.3508104-2-han.xu@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Han,

I love your patch! Yet something to improve:

[auto build test ERROR on abelvesa/clk/imx]
[also build test ERROR on shawnguo/for-next linus/master v6.0-rc5 next-20220914]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Han-Xu/clk-imx-imx6sx-remove-the-SET_RATE_PARENT-flag-for-QSPI-clocks/20220915-041341
base:   https://git.kernel.org/pub/scm/linux/kernel/git/abelvesa/linux.git clk/imx
config: arm-defconfig (https://download.01.org/0day-ci/archive/20220915/202209151545.eB4Mrylw-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/d246f7033318f9fc1ef41666c450034ad8de6916
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Han-Xu/clk-imx-imx6sx-remove-the-SET_RATE_PARENT-flag-for-QSPI-clocks/20220915-041341
        git checkout d246f7033318f9fc1ef41666c450034ad8de6916
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/clk/imx/clk-imx6sx.c: In function 'imx6sx_clocks_init':
>> drivers/clk/imx/clk-imx6sx.c:553:62: error: unterminated argument list invoking macro "imx_clk_hw_mux"
     553 | CLK_OF_DECLARE(imx6sx, "fsl,imx6sx-ccm", imx6sx_clocks_init);
         |                                                              ^
>> drivers/clk/imx/clk-imx6sx.c:283:46: error: 'imx_clk_hw_mux' undeclared (first use in this function); did you mean 'imx_clk_hw_cpu'?
     283 |         hws[IMX6SX_CLK_QSPI1_SEL]          = imx_clk_hw_mux("qspi1_sel",        base + 0x1c,  7,      3,      qspi1_sels,        ARRAY_SIZE(qspi1_sels);
         |                                              ^~~~~~~~~~~~~~
         |                                              imx_clk_hw_cpu
   drivers/clk/imx/clk-imx6sx.c:283:46: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/clk/imx/clk-imx6sx.c:283:60: error: expected ';' at end of input
     283 |         hws[IMX6SX_CLK_QSPI1_SEL]          = imx_clk_hw_mux("qspi1_sel",        base + 0x1c,  7,      3,      qspi1_sels,        ARRAY_SIZE(qspi1_sels);
         |                                                            ^
         |                                                            ;
   ......
>> drivers/clk/imx/clk-imx6sx.c:283:9: error: expected declaration or statement at end of input
     283 |         hws[IMX6SX_CLK_QSPI1_SEL]          = imx_clk_hw_mux("qspi1_sel",        base + 0x1c,  7,      3,      qspi1_sels,        ARRAY_SIZE(qspi1_sels);
         |         ^~~
   drivers/clk/imx/clk-imx6sx.c: At top level:
   drivers/clk/imx/clk-imx6sx.c:120:20: warning: 'imx6sx_clocks_init' defined but not used [-Wunused-function]
     120 | static void __init imx6sx_clocks_init(struct device_node *ccm_node)
         |                    ^~~~~~~~~~~~~~~~~~
   drivers/clk/imx/clk-imx6sx.c:118:12: warning: 'share_count_sai2' defined but not used [-Wunused-variable]
     118 | static u32 share_count_sai2;
         |            ^~~~~~~~~~~~~~~~
   drivers/clk/imx/clk-imx6sx.c:117:12: warning: 'share_count_sai1' defined but not used [-Wunused-variable]
     117 | static u32 share_count_sai1;
         |            ^~~~~~~~~~~~~~~~
   drivers/clk/imx/clk-imx6sx.c:116:12: warning: 'share_count_ssi3' defined but not used [-Wunused-variable]
     116 | static u32 share_count_ssi3;
         |            ^~~~~~~~~~~~~~~~
   drivers/clk/imx/clk-imx6sx.c:115:12: warning: 'share_count_ssi2' defined but not used [-Wunused-variable]
     115 | static u32 share_count_ssi2;
         |            ^~~~~~~~~~~~~~~~
   drivers/clk/imx/clk-imx6sx.c:114:12: warning: 'share_count_ssi1' defined but not used [-Wunused-variable]
     114 | static u32 share_count_ssi1;
         |            ^~~~~~~~~~~~~~~~
   drivers/clk/imx/clk-imx6sx.c:113:12: warning: 'share_count_esai' defined but not used [-Wunused-variable]
     113 | static u32 share_count_esai;
         |            ^~~~~~~~~~~~~~~~
   drivers/clk/imx/clk-imx6sx.c:112:12: warning: 'share_count_audio' defined but not used [-Wunused-variable]
     112 | static u32 share_count_audio;
         |            ^~~~~~~~~~~~~~~~~
   drivers/clk/imx/clk-imx6sx.c:111:12: warning: 'share_count_asrc' defined but not used [-Wunused-variable]
     111 | static u32 share_count_asrc;
         |            ^~~~~~~~~~~~~~~~
   drivers/clk/imx/clk-imx6sx.c:71:20: warning: 'cko_sels' defined but not used [-Wunused-variable]
      71 | static const char *cko_sels[] = { "cko1", "cko2", };
         |                    ^~~~~~~~
   drivers/clk/imx/clk-imx6sx.c:63:20: warning: 'cko2_sels' defined but not used [-Wunused-variable]
      63 | static const char *cko2_sels[]          = {
         |                    ^~~~~~~~~
   drivers/clk/imx/clk-imx6sx.c:58:20: warning: 'cko1_sels' defined but not used [-Wunused-variable]
      58 | static const char *cko1_sels[]          = {
         |                    ^~~~~~~~~
   drivers/clk/imx/clk-imx6sx.c:57:20: warning: 'csi_sels' defined but not used [-Wunused-variable]
      57 | static const char *csi_sels[]           = { "osc", "pll2_pfd2_396m", "pll3_120m", "pll3_pfd1_540m", };
         |                    ^~~~~~~~
   drivers/clk/imx/clk-imx6sx.c:56:20: warning: 'display_sels' defined but not used [-Wunused-variable]
      56 | static const char *display_sels[]       = { "pll2_bus", "pll2_pfd2_396m", "pll3_usb_otg", "pll3_pfd1_540m", };
         |                    ^~~~~~~~~~~~
   drivers/clk/imx/clk-imx6sx.c:55:20: warning: 'lcdif2_sels' defined but not used [-Wunused-variable]
      55 | static const char *lcdif2_sels[]        = { "lcdif2_podf", "ipp_di0", "ipp_di1", "ldb_di0", "ldb_di1", };
         |                    ^~~~~~~~~~~
   drivers/clk/imx/clk-imx6sx.c:54:20: warning: 'lcdif2_pre_sels' defined but not used [-Wunused-variable]
      54 | static const char *lcdif2_pre_sels[]    = { "pll2_bus", "pll3_pfd3_454m", "pll5_video_div", "pll2_pfd0_352m", "pll2_pfd3_594m", "pll3_pfd1_540m", };
         |                    ^~~~~~~~~~~~~~~
   drivers/clk/imx/clk-imx6sx.c:53:20: warning: 'lcdif1_sels' defined but not used [-Wunused-variable]
      53 | static const char *lcdif1_sels[]        = { "lcdif1_podf", "ipp_di0", "ipp_di1", "ldb_di0", "ldb_di1", };
         |                    ^~~~~~~~~~~
   drivers/clk/imx/clk-imx6sx.c:52:20: warning: 'lcdif1_pre_sels' defined but not used [-Wunused-variable]
      52 | static const char *lcdif1_pre_sels[]    = { "pll2_bus", "pll3_pfd3_454m", "pll5_video_div", "pll2_pfd0_352m", "pll2_pfd1_594m", "pll3_pfd1_540m", };
         |                    ^~~~~~~~~~~~~~~
   drivers/clk/imx/clk-imx6sx.c:51:20: warning: 'ecspi_sels' defined but not used [-Wunused-variable]
      51 | static const char *ecspi_sels[]         = { "pll3_60m", "osc", };
         |                    ^~~~~~~~~~
   drivers/clk/imx/clk-imx6sx.c:49:20: warning: 'm4_sels' defined but not used [-Wunused-variable]
      49 | static const char *m4_sels[]            = { "m4_pre_sel", "ipp_di0", "ipp_di1", "ldb_di0", "ldb_di1", };
         |                    ^~~~~~~
   drivers/clk/imx/clk-imx6sx.c:48:20: warning: 'm4_pre_sels' defined but not used [-Wunused-variable]
      48 | static const char *m4_pre_sels[]        = { "pll2_bus", "pll3_usb_otg", "osc", "pll2_pfd0_352m", "pll2_pfd2_396m", "pll3_pfd3_454m", };
         |                    ^~~~~~~~~~~
   drivers/clk/imx/clk-imx6sx.c:47:20: warning: 'enet_sels' defined but not used [-Wunused-variable]
      47 | static const char *enet_sels[]          = { "enet_podf", "ipp_di0", "ipp_di1", "ldb_di0", "ldb_di1", };
         |                    ^~~~~~~~~
   drivers/clk/imx/clk-imx6sx.c:46:20: warning: 'enet_pre_sels' defined but not used [-Wunused-variable]
      46 | static const char *enet_pre_sels[]      = { "pll2_bus", "pll3_usb_otg", "pll5_video_div", "pll2_pfd0_352m", "pll2_pfd2_396m", "pll3_pfd2_508m", };
         |                    ^~~~~~~~~~~~~
   drivers/clk/imx/clk-imx6sx.c:45:20: warning: 'qspi2_sels' defined but not used [-Wunused-variable]
      45 | static const char *qspi2_sels[]         = { "pll2_pfd0_352m", "pll2_bus", "pll3_usb_otg", "pll2_pfd2_396m", "pll3_pfd3_454m", "dummy", "dummy", "dummy", };
         |                    ^~~~~~~~~~
   drivers/clk/imx/clk-imx6sx.c:44:20: warning: 'uart_sels' defined but not used [-Wunused-variable]
      44 | static const char *uart_sels[]          = { "pll3_80m", "osc", };
         |                    ^~~~~~~~~
   drivers/clk/imx/clk-imx6sx.c:43:20: warning: 'can_sels' defined but not used [-Wunused-variable]
      43 | static const char *can_sels[]           = { "pll3_60m", "osc", "pll3_80m", "dummy", };
         |                    ^~~~~~~~
   drivers/clk/imx/clk-imx6sx.c:42:20: warning: 'vid_sels' defined but not used [-Wunused-variable]
      42 | static const char *vid_sels[]           = { "pll3_pfd1_540m", "pll3_usb_otg", "pll3_pfd3_454m", "pll4_audio_div", "pll5_video_div", };
         |                    ^~~~~~~~
   drivers/clk/imx/clk-imx6sx.c:40:20: warning: 'perclk_sels' defined but not used [-Wunused-variable]
      40 | static const char *perclk_sels[]        = { "ipg", "osc", };
         |                    ^~~~~~~~~~~
   drivers/clk/imx/clk-imx6sx.c:39:20: warning: 'qspi1_sels' defined but not used [-Wunused-variable]
      39 | static const char *qspi1_sels[]         = { "pll3_usb_otg", "pll2_pfd0_352m", "pll2_pfd2_396m", "pll2_bus", "pll3_pfd3_454m", "pll3_pfd2_508m", };
         |                    ^~~~~~~~~~
   drivers/clk/imx/clk-imx6sx.c:36:20: warning: 'ldb_di1_sels' defined but not used [-Wunused-variable]
      36 | static const char *ldb_di1_sels[]       = { "pll3_usb_otg", "pll2_pfd0_352m", "pll2_pfd2_396m", "pll2_bus", "pll3_pfd3_454m", "pll3_pfd2_508m", };
         |                    ^~~~~~~~~~~~
   drivers/clk/imx/clk-imx6sx.c:35:20: warning: 'ldb_di0_sels' defined but not used [-Wunused-variable]
      35 | static const char *ldb_di0_sels[]       = { "pll5_video_div", "pll2_pfd0_352m", "pll2_pfd2_396m", "pll2_pfd3_594m", "pll2_pfd1_594m", "pll3_pfd3_454m", };
         |                    ^~~~~~~~~~~~
   drivers/clk/imx/clk-imx6sx.c:34:20: warning: 'ldb_di1_div_sels' defined but not used [-Wunused-variable]
      34 | static const char *ldb_di1_div_sels[]   = { "ldb_di1_div_3_5", "ldb_di1_div_7", };
         |                    ^~~~~~~~~~~~~~~~
   drivers/clk/imx/clk-imx6sx.c:33:20: warning: 'ldb_di0_div_sels' defined but not used [-Wunused-variable]


vim +/imx_clk_hw_mux +553 drivers/clk/imx/clk-imx6sx.c

d55135689019c3 arch/arm/mach-imx/clk-imx6sx.c Anson Huang  2014-05-11  119  
d55135689019c3 arch/arm/mach-imx/clk-imx6sx.c Anson Huang  2014-05-11  120  static void __init imx6sx_clocks_init(struct device_node *ccm_node)
d55135689019c3 arch/arm/mach-imx/clk-imx6sx.c Anson Huang  2014-05-11  121  {
d55135689019c3 arch/arm/mach-imx/clk-imx6sx.c Anson Huang  2014-05-11  122  	struct device_node *np;
d55135689019c3 arch/arm/mach-imx/clk-imx6sx.c Anson Huang  2014-05-11  123  	void __iomem *base;
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  124  
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  125  	clk_hw_data = kzalloc(struct_size(clk_hw_data, hws,
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  126  					  IMX6SX_CLK_CLK_END), GFP_KERNEL);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  127  	if (WARN_ON(!clk_hw_data))
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  128  		return;
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  129  
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  130  	clk_hw_data->num = IMX6SX_CLK_CLK_END;
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  131  	hws = clk_hw_data->hws;
d55135689019c3 arch/arm/mach-imx/clk-imx6sx.c Anson Huang  2014-05-11  132  
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  133  	hws[IMX6SX_CLK_DUMMY] = imx_clk_hw_fixed("dummy", 0);
d55135689019c3 arch/arm/mach-imx/clk-imx6sx.c Anson Huang  2014-05-11  134  
8e1de35d4cebea drivers/clk/imx/clk-imx6sx.c   Peng Fan     2019-10-24  135  	hws[IMX6SX_CLK_CKIL] = imx_obtain_fixed_clk_hw(ccm_node, "ckil");
8e1de35d4cebea drivers/clk/imx/clk-imx6sx.c   Peng Fan     2019-10-24  136  	hws[IMX6SX_CLK_OSC] = imx_obtain_fixed_clk_hw(ccm_node, "osc");
d55135689019c3 arch/arm/mach-imx/clk-imx6sx.c Anson Huang  2014-05-11  137  
d55135689019c3 arch/arm/mach-imx/clk-imx6sx.c Anson Huang  2014-05-11  138  	/* ipp_di clock is external input */
8e1de35d4cebea drivers/clk/imx/clk-imx6sx.c   Peng Fan     2019-10-24  139  	hws[IMX6SX_CLK_IPP_DI0] = imx_obtain_fixed_clk_hw(ccm_node, "ipp_di0");
8e1de35d4cebea drivers/clk/imx/clk-imx6sx.c   Peng Fan     2019-10-24  140  	hws[IMX6SX_CLK_IPP_DI1] = imx_obtain_fixed_clk_hw(ccm_node, "ipp_di1");
d55135689019c3 arch/arm/mach-imx/clk-imx6sx.c Anson Huang  2014-05-11  141  
5cc73ff7a3524d drivers/clk/imx/clk-imx6sx.c   Anson Huang  2018-04-20  142  	/* Clock source from external clock via CLK1/2 PAD */
8e1de35d4cebea drivers/clk/imx/clk-imx6sx.c   Peng Fan     2019-10-24  143  	hws[IMX6SX_CLK_ANACLK1] = imx_obtain_fixed_clk_hw(ccm_node, "anaclk1");
8e1de35d4cebea drivers/clk/imx/clk-imx6sx.c   Peng Fan     2019-10-24  144  	hws[IMX6SX_CLK_ANACLK2] = imx_obtain_fixed_clk_hw(ccm_node, "anaclk2");
db7c0659452c5f arch/arm/mach-imx/clk-imx6sx.c Shawn Guo    2014-09-01  145  
d55135689019c3 arch/arm/mach-imx/clk-imx6sx.c Anson Huang  2014-05-11  146  	np = of_find_compatible_node(NULL, NULL, "fsl,imx6sx-anatop");
d55135689019c3 arch/arm/mach-imx/clk-imx6sx.c Anson Huang  2014-05-11  147  	base = of_iomap(np, 0);
d55135689019c3 arch/arm/mach-imx/clk-imx6sx.c Anson Huang  2014-05-11  148  	WARN_ON(!base);
1731e14fb30212 drivers/clk/imx/clk-imx6sx.c   Yangtao Li   2018-12-26  149  	of_node_put(np);
d55135689019c3 arch/arm/mach-imx/clk-imx6sx.c Anson Huang  2014-05-11  150  
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  151  	hws[IMX6SX_PLL1_BYPASS_SRC] = imx_clk_hw_mux("pll1_bypass_src", base + 0x00, 14, 1, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  152  	hws[IMX6SX_PLL2_BYPASS_SRC] = imx_clk_hw_mux("pll2_bypass_src", base + 0x30, 14, 1, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  153  	hws[IMX6SX_PLL3_BYPASS_SRC] = imx_clk_hw_mux("pll3_bypass_src", base + 0x10, 14, 1, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  154  	hws[IMX6SX_PLL4_BYPASS_SRC] = imx_clk_hw_mux("pll4_bypass_src", base + 0x70, 14, 1, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  155  	hws[IMX6SX_PLL5_BYPASS_SRC] = imx_clk_hw_mux("pll5_bypass_src", base + 0xa0, 14, 1, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  156  	hws[IMX6SX_PLL6_BYPASS_SRC] = imx_clk_hw_mux("pll6_bypass_src", base + 0xe0, 14, 1, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  157  	hws[IMX6SX_PLL7_BYPASS_SRC] = imx_clk_hw_mux("pll7_bypass_src", base + 0x20, 14, 1, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
db7c0659452c5f arch/arm/mach-imx/clk-imx6sx.c Shawn Guo    2014-09-01  158  
d55135689019c3 arch/arm/mach-imx/clk-imx6sx.c Anson Huang  2014-05-11  159  	/*                                    type               name    parent_name        base         div_mask */
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  160  	hws[IMX6SX_CLK_PLL1] = imx_clk_hw_pllv3(IMX_PLLV3_SYS,     "pll1", "osc", base + 0x00, 0x7f);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  161  	hws[IMX6SX_CLK_PLL2] = imx_clk_hw_pllv3(IMX_PLLV3_GENERIC, "pll2", "osc", base + 0x30, 0x1);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  162  	hws[IMX6SX_CLK_PLL3] = imx_clk_hw_pllv3(IMX_PLLV3_USB,     "pll3", "osc", base + 0x10, 0x3);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  163  	hws[IMX6SX_CLK_PLL4] = imx_clk_hw_pllv3(IMX_PLLV3_AV,      "pll4", "osc", base + 0x70, 0x7f);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  164  	hws[IMX6SX_CLK_PLL5] = imx_clk_hw_pllv3(IMX_PLLV3_AV,      "pll5", "osc", base + 0xa0, 0x7f);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  165  	hws[IMX6SX_CLK_PLL6] = imx_clk_hw_pllv3(IMX_PLLV3_ENET,    "pll6", "osc", base + 0xe0, 0x3);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  166  	hws[IMX6SX_CLK_PLL7] = imx_clk_hw_pllv3(IMX_PLLV3_USB,     "pll7", "osc", base + 0x20, 0x3);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  167  
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  168  	hws[IMX6SX_PLL1_BYPASS] = imx_clk_hw_mux_flags("pll1_bypass", base + 0x00, 16, 1, pll1_bypass_sels, ARRAY_SIZE(pll1_bypass_sels), CLK_SET_RATE_PARENT);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  169  	hws[IMX6SX_PLL2_BYPASS] = imx_clk_hw_mux_flags("pll2_bypass", base + 0x30, 16, 1, pll2_bypass_sels, ARRAY_SIZE(pll2_bypass_sels), CLK_SET_RATE_PARENT);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  170  	hws[IMX6SX_PLL3_BYPASS] = imx_clk_hw_mux_flags("pll3_bypass", base + 0x10, 16, 1, pll3_bypass_sels, ARRAY_SIZE(pll3_bypass_sels), CLK_SET_RATE_PARENT);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  171  	hws[IMX6SX_PLL4_BYPASS] = imx_clk_hw_mux_flags("pll4_bypass", base + 0x70, 16, 1, pll4_bypass_sels, ARRAY_SIZE(pll4_bypass_sels), CLK_SET_RATE_PARENT);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  172  	hws[IMX6SX_PLL5_BYPASS] = imx_clk_hw_mux_flags("pll5_bypass", base + 0xa0, 16, 1, pll5_bypass_sels, ARRAY_SIZE(pll5_bypass_sels), CLK_SET_RATE_PARENT);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  173  	hws[IMX6SX_PLL6_BYPASS] = imx_clk_hw_mux_flags("pll6_bypass", base + 0xe0, 16, 1, pll6_bypass_sels, ARRAY_SIZE(pll6_bypass_sels), CLK_SET_RATE_PARENT);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  174  	hws[IMX6SX_PLL7_BYPASS] = imx_clk_hw_mux_flags("pll7_bypass", base + 0x20, 16, 1, pll7_bypass_sels, ARRAY_SIZE(pll7_bypass_sels), CLK_SET_RATE_PARENT);
db7c0659452c5f arch/arm/mach-imx/clk-imx6sx.c Shawn Guo    2014-09-01  175  
db7c0659452c5f arch/arm/mach-imx/clk-imx6sx.c Shawn Guo    2014-09-01  176  	/* Do not bypass PLLs initially */
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  177  	clk_set_parent(hws[IMX6SX_PLL1_BYPASS]->clk, hws[IMX6SX_CLK_PLL1]->clk);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  178  	clk_set_parent(hws[IMX6SX_PLL2_BYPASS]->clk, hws[IMX6SX_CLK_PLL2]->clk);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  179  	clk_set_parent(hws[IMX6SX_PLL3_BYPASS]->clk, hws[IMX6SX_CLK_PLL3]->clk);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  180  	clk_set_parent(hws[IMX6SX_PLL4_BYPASS]->clk, hws[IMX6SX_CLK_PLL4]->clk);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  181  	clk_set_parent(hws[IMX6SX_PLL5_BYPASS]->clk, hws[IMX6SX_CLK_PLL5]->clk);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  182  	clk_set_parent(hws[IMX6SX_PLL6_BYPASS]->clk, hws[IMX6SX_CLK_PLL6]->clk);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  183  	clk_set_parent(hws[IMX6SX_PLL7_BYPASS]->clk, hws[IMX6SX_CLK_PLL7]->clk);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  184  
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  185  	hws[IMX6SX_CLK_PLL1_SYS]      = imx_clk_hw_gate("pll1_sys",      "pll1_bypass", base + 0x00, 13);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  186  	hws[IMX6SX_CLK_PLL2_BUS]      = imx_clk_hw_gate("pll2_bus",      "pll2_bypass", base + 0x30, 13);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  187  	hws[IMX6SX_CLK_PLL3_USB_OTG]  = imx_clk_hw_gate("pll3_usb_otg",  "pll3_bypass", base + 0x10, 13);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  188  	hws[IMX6SX_CLK_PLL4_AUDIO]    = imx_clk_hw_gate("pll4_audio",    "pll4_bypass", base + 0x70, 13);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  189  	hws[IMX6SX_CLK_PLL5_VIDEO]    = imx_clk_hw_gate("pll5_video",    "pll5_bypass", base + 0xa0, 13);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  190  	hws[IMX6SX_CLK_PLL6_ENET]     = imx_clk_hw_gate("pll6_enet",     "pll6_bypass", base + 0xe0, 13);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  191  	hws[IMX6SX_CLK_PLL7_USB_HOST] = imx_clk_hw_gate("pll7_usb_host", "pll7_bypass", base + 0x20, 13);
d55135689019c3 arch/arm/mach-imx/clk-imx6sx.c Anson Huang  2014-05-11  192  
d55135689019c3 arch/arm/mach-imx/clk-imx6sx.c Anson Huang  2014-05-11  193  	/*
d55135689019c3 arch/arm/mach-imx/clk-imx6sx.c Anson Huang  2014-05-11  194  	 * Bit 20 is the reserved and read-only bit, we do this only for:
d55135689019c3 arch/arm/mach-imx/clk-imx6sx.c Anson Huang  2014-05-11  195  	 * - Do nothing for usbphy clk_enable/disable
d55135689019c3 arch/arm/mach-imx/clk-imx6sx.c Anson Huang  2014-05-11  196  	 * - Keep refcount when do usbphy clk_enable/disable, in that case,
d55135689019c3 arch/arm/mach-imx/clk-imx6sx.c Anson Huang  2014-05-11  197  	 * the clk framework may need to enable/disable usbphy's parent
d55135689019c3 arch/arm/mach-imx/clk-imx6sx.c Anson Huang  2014-05-11  198  	 */
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  199  	hws[IMX6SX_CLK_USBPHY1] = imx_clk_hw_gate("usbphy1", "pll3_usb_otg",  base + 0x10, 20);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  200  	hws[IMX6SX_CLK_USBPHY2] = imx_clk_hw_gate("usbphy2", "pll7_usb_host", base + 0x20, 20);
d55135689019c3 arch/arm/mach-imx/clk-imx6sx.c Anson Huang  2014-05-11  201  
d55135689019c3 arch/arm/mach-imx/clk-imx6sx.c Anson Huang  2014-05-11  202  	/*
d55135689019c3 arch/arm/mach-imx/clk-imx6sx.c Anson Huang  2014-05-11  203  	 * usbphy*_gate needs to be on after system boots up, and software
d55135689019c3 arch/arm/mach-imx/clk-imx6sx.c Anson Huang  2014-05-11  204  	 * never needs to control it anymore.
d55135689019c3 arch/arm/mach-imx/clk-imx6sx.c Anson Huang  2014-05-11  205  	 */
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  206  	hws[IMX6SX_CLK_USBPHY1_GATE] = imx_clk_hw_gate("usbphy1_gate", "dummy", base + 0x10, 6);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  207  	hws[IMX6SX_CLK_USBPHY2_GATE] = imx_clk_hw_gate("usbphy2_gate", "dummy", base + 0x20, 6);
d55135689019c3 arch/arm/mach-imx/clk-imx6sx.c Anson Huang  2014-05-11  208  
6a53bc750004fd arch/arm/mach-imx/clk-imx6sx.c Russell King 2015-05-14  209  	/* FIXME 100MHz is used for pcie ref for all imx6 pcie, excepted imx6q */
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  210  	hws[IMX6SX_CLK_PCIE_REF] = imx_clk_hw_fixed_factor("pcie_ref", "pll6_enet", 1, 5);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  211  	hws[IMX6SX_CLK_PCIE_REF_125M] = imx_clk_hw_gate("pcie_ref_125m", "pcie_ref", base + 0xe0, 19);
d55135689019c3 arch/arm/mach-imx/clk-imx6sx.c Anson Huang  2014-05-11  212  
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  213  	hws[IMX6SX_CLK_LVDS1_OUT] = imx_clk_hw_gate_exclusive("lvds1_out", "lvds1_sel", base + 0x160, 10, BIT(12));
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  214  	hws[IMX6SX_CLK_LVDS2_OUT] = imx_clk_hw_gate_exclusive("lvds2_out", "lvds2_sel", base + 0x160, 11, BIT(13));
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  215  	hws[IMX6SX_CLK_LVDS1_IN]  = imx_clk_hw_gate_exclusive("lvds1_in",  "anaclk1",   base + 0x160, 12, BIT(10));
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  216  	hws[IMX6SX_CLK_LVDS2_IN]  = imx_clk_hw_gate_exclusive("lvds2_in",  "anaclk2",   base + 0x160, 13, BIT(11));
d55135689019c3 arch/arm/mach-imx/clk-imx6sx.c Anson Huang  2014-05-11  217  
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  218  	hws[IMX6SX_CLK_ENET_REF] = clk_hw_register_divider_table(NULL, "enet_ref", "pll6_enet", 0,
d55135689019c3 arch/arm/mach-imx/clk-imx6sx.c Anson Huang  2014-05-11  219  			base + 0xe0, 0, 2, 0, clk_enet_ref_table,
d55135689019c3 arch/arm/mach-imx/clk-imx6sx.c Anson Huang  2014-05-11  220  			&imx_ccm_lock);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  221  	hws[IMX6SX_CLK_ENET2_REF] = clk_hw_register_divider_table(NULL, "enet2_ref", "pll6_enet", 0,
d55135689019c3 arch/arm/mach-imx/clk-imx6sx.c Anson Huang  2014-05-11  222  			base + 0xe0, 2, 2, 0, clk_enet_ref_table,
d55135689019c3 arch/arm/mach-imx/clk-imx6sx.c Anson Huang  2014-05-11  223  			&imx_ccm_lock);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  224  	hws[IMX6SX_CLK_ENET2_REF_125M] = imx_clk_hw_gate("enet2_ref_125m", "enet2_ref", base + 0xe0, 20);
d55135689019c3 arch/arm/mach-imx/clk-imx6sx.c Anson Huang  2014-05-11  225  
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  226  	hws[IMX6SX_CLK_ENET_PTP_REF] = imx_clk_hw_fixed_factor("enet_ptp_ref", "pll6_enet", 1, 20);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  227  	hws[IMX6SX_CLK_ENET_PTP] = imx_clk_hw_gate("enet_ptp_25m", "enet_ptp_ref", base + 0xe0, 21);
d55135689019c3 arch/arm/mach-imx/clk-imx6sx.c Anson Huang  2014-05-11  228  
d55135689019c3 arch/arm/mach-imx/clk-imx6sx.c Anson Huang  2014-05-11  229  	/*                                       name              parent_name     reg           idx */
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  230  	hws[IMX6SX_CLK_PLL2_PFD0] = imx_clk_hw_pfd("pll2_pfd0_352m", "pll2_bus",     base + 0x100, 0);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  231  	hws[IMX6SX_CLK_PLL2_PFD1] = imx_clk_hw_pfd("pll2_pfd1_594m", "pll2_bus",     base + 0x100, 1);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  232  	hws[IMX6SX_CLK_PLL2_PFD2] = imx_clk_hw_pfd("pll2_pfd2_396m", "pll2_bus",     base + 0x100, 2);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  233  	hws[IMX6SX_CLK_PLL2_PFD3] = imx_clk_hw_pfd("pll2_pfd3_594m", "pll2_bus",     base + 0x100, 3);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  234  	hws[IMX6SX_CLK_PLL3_PFD0] = imx_clk_hw_pfd("pll3_pfd0_720m", "pll3_usb_otg", base + 0xf0,  0);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  235  	hws[IMX6SX_CLK_PLL3_PFD1] = imx_clk_hw_pfd("pll3_pfd1_540m", "pll3_usb_otg", base + 0xf0,  1);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  236  	hws[IMX6SX_CLK_PLL3_PFD2] = imx_clk_hw_pfd("pll3_pfd2_508m", "pll3_usb_otg", base + 0xf0,  2);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  237  	hws[IMX6SX_CLK_PLL3_PFD3] = imx_clk_hw_pfd("pll3_pfd3_454m", "pll3_usb_otg", base + 0xf0,  3);
d55135689019c3 arch/arm/mach-imx/clk-imx6sx.c Anson Huang  2014-05-11  238  
d55135689019c3 arch/arm/mach-imx/clk-imx6sx.c Anson Huang  2014-05-11  239  	/*                                                name         parent_name       mult div */
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  240  	hws[IMX6SX_CLK_PLL2_198M] = imx_clk_hw_fixed_factor("pll2_198m", "pll2_pfd2_396m", 1,   2);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  241  	hws[IMX6SX_CLK_PLL3_120M] = imx_clk_hw_fixed_factor("pll3_120m", "pll3_usb_otg",   1,   4);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  242  	hws[IMX6SX_CLK_PLL3_80M]  = imx_clk_hw_fixed_factor("pll3_80m",  "pll3_usb_otg",   1,   6);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  243  	hws[IMX6SX_CLK_PLL3_60M]  = imx_clk_hw_fixed_factor("pll3_60m",  "pll3_usb_otg",   1,   8);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  244  	hws[IMX6SX_CLK_TWD]       = imx_clk_hw_fixed_factor("twd",       "arm",            1,   2);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  245  	hws[IMX6SX_CLK_GPT_3M]    = imx_clk_hw_fixed_factor("gpt_3m",    "osc",            1,   8);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  246  
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  247  	hws[IMX6SX_CLK_PLL4_POST_DIV]  = clk_hw_register_divider_table(NULL, "pll4_post_div", "pll4_audio",
d55135689019c3 arch/arm/mach-imx/clk-imx6sx.c Anson Huang  2014-05-11  248  				CLK_SET_RATE_PARENT, base + 0x70, 19, 2, 0, post_div_table, &imx_ccm_lock);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  249  	hws[IMX6SX_CLK_PLL4_AUDIO_DIV] = clk_hw_register_divider(NULL, "pll4_audio_div", "pll4_post_div",
d55135689019c3 arch/arm/mach-imx/clk-imx6sx.c Anson Huang  2014-05-11  250  				CLK_SET_RATE_PARENT, base + 0x170, 15, 1, 0, &imx_ccm_lock);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  251  	hws[IMX6SX_CLK_PLL5_POST_DIV]  = clk_hw_register_divider_table(NULL, "pll5_post_div", "pll5_video",
d55135689019c3 arch/arm/mach-imx/clk-imx6sx.c Anson Huang  2014-05-11  252  				CLK_SET_RATE_PARENT, base + 0xa0, 19, 2, 0, post_div_table, &imx_ccm_lock);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  253  	hws[IMX6SX_CLK_PLL5_VIDEO_DIV] = clk_hw_register_divider_table(NULL, "pll5_video_div", "pll5_post_div",
d55135689019c3 arch/arm/mach-imx/clk-imx6sx.c Anson Huang  2014-05-11  254  				CLK_SET_RATE_PARENT, base + 0x170, 30, 2, 0, video_div_table, &imx_ccm_lock);
d55135689019c3 arch/arm/mach-imx/clk-imx6sx.c Anson Huang  2014-05-11  255  
d55135689019c3 arch/arm/mach-imx/clk-imx6sx.c Anson Huang  2014-05-11  256  	/*                                                name                reg           shift   width   parent_names       num_parents */
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  257  	hws[IMX6SX_CLK_LVDS1_SEL]          = imx_clk_hw_mux("lvds1_sel",        base + 0x160, 0,      5,      lvds_sels,         ARRAY_SIZE(lvds_sels));
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  258  	hws[IMX6SX_CLK_LVDS2_SEL]          = imx_clk_hw_mux("lvds2_sel",        base + 0x160, 5,      5,      lvds_sels,         ARRAY_SIZE(lvds_sels));
d55135689019c3 arch/arm/mach-imx/clk-imx6sx.c Anson Huang  2014-05-11  259  
d55135689019c3 arch/arm/mach-imx/clk-imx6sx.c Anson Huang  2014-05-11  260  	np = ccm_node;
d55135689019c3 arch/arm/mach-imx/clk-imx6sx.c Anson Huang  2014-05-11  261  	base = of_iomap(np, 0);
d55135689019c3 arch/arm/mach-imx/clk-imx6sx.c Anson Huang  2014-05-11  262  	WARN_ON(!base);
d55135689019c3 arch/arm/mach-imx/clk-imx6sx.c Anson Huang  2014-05-11  263  
d55135689019c3 arch/arm/mach-imx/clk-imx6sx.c Anson Huang  2014-05-11  264  	/*                                                name                reg           shift   width   parent_names       num_parents */
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  265  	hws[IMX6SX_CLK_STEP]               = imx_clk_hw_mux("step",             base + 0xc,   8,      1,      step_sels,         ARRAY_SIZE(step_sels));
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  266  	hws[IMX6SX_CLK_PLL1_SW]            = imx_clk_hw_mux("pll1_sw",          base + 0xc,   2,      1,      pll1_sw_sels,      ARRAY_SIZE(pll1_sw_sels));
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  267  	hws[IMX6SX_CLK_OCRAM_SEL]          = imx_clk_hw_mux("ocram_sel",        base + 0x14,  6,      2,      ocram_sels,        ARRAY_SIZE(ocram_sels));
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  268  	hws[IMX6SX_CLK_PERIPH_PRE]         = imx_clk_hw_mux("periph_pre",       base + 0x18,  18,     2,      periph_pre_sels,   ARRAY_SIZE(periph_pre_sels));
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  269  	hws[IMX6SX_CLK_PERIPH2_PRE]        = imx_clk_hw_mux("periph2_pre",      base + 0x18,  21,     2,      periph2_pre_sels,   ARRAY_SIZE(periph2_pre_sels));
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  270  	hws[IMX6SX_CLK_PERIPH_CLK2_SEL]    = imx_clk_hw_mux("periph_clk2_sel",  base + 0x18,  12,     2,      periph_clk2_sels,  ARRAY_SIZE(periph_clk2_sels));
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  271  	hws[IMX6SX_CLK_PERIPH2_CLK2_SEL]   = imx_clk_hw_mux("periph2_clk2_sel", base + 0x18,  20,     1,      periph2_clk2_sels, ARRAY_SIZE(periph2_clk2_sels));
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  272  	hws[IMX6SX_CLK_PCIE_AXI_SEL]       = imx_clk_hw_mux("pcie_axi_sel",     base + 0x18,  10,     1,      pcie_axi_sels,     ARRAY_SIZE(pcie_axi_sels));
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  273  	hws[IMX6SX_CLK_GPU_AXI_SEL]        = imx_clk_hw_mux("gpu_axi_sel",      base + 0x18,  8,      2,      gpu_axi_sels,      ARRAY_SIZE(gpu_axi_sels));
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  274  	hws[IMX6SX_CLK_GPU_CORE_SEL]       = imx_clk_hw_mux("gpu_core_sel",     base + 0x18,  4,      2,      gpu_core_sels,     ARRAY_SIZE(gpu_core_sels));
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  275  	hws[IMX6SX_CLK_EIM_SLOW_SEL]       = imx_clk_hw_mux("eim_slow_sel",     base + 0x1c,  29,     2,      eim_slow_sels,     ARRAY_SIZE(eim_slow_sels));
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  276  	hws[IMX6SX_CLK_USDHC1_SEL]         = imx_clk_hw_mux("usdhc1_sel",       base + 0x1c,  16,     1,      usdhc_sels,        ARRAY_SIZE(usdhc_sels));
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  277  	hws[IMX6SX_CLK_USDHC2_SEL]         = imx_clk_hw_mux("usdhc2_sel",       base + 0x1c,  17,     1,      usdhc_sels,        ARRAY_SIZE(usdhc_sels));
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  278  	hws[IMX6SX_CLK_USDHC3_SEL]         = imx_clk_hw_mux("usdhc3_sel",       base + 0x1c,  18,     1,      usdhc_sels,        ARRAY_SIZE(usdhc_sels));
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  279  	hws[IMX6SX_CLK_USDHC4_SEL]         = imx_clk_hw_mux("usdhc4_sel",       base + 0x1c,  19,     1,      usdhc_sels,        ARRAY_SIZE(usdhc_sels));
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  280  	hws[IMX6SX_CLK_SSI3_SEL]           = imx_clk_hw_mux("ssi3_sel",         base + 0x1c,  14,     2,      ssi_sels,          ARRAY_SIZE(ssi_sels));
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  281  	hws[IMX6SX_CLK_SSI2_SEL]           = imx_clk_hw_mux("ssi2_sel",         base + 0x1c,  12,     2,      ssi_sels,          ARRAY_SIZE(ssi_sels));
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  282  	hws[IMX6SX_CLK_SSI1_SEL]           = imx_clk_hw_mux("ssi1_sel",         base + 0x1c,  10,     2,      ssi_sels,          ARRAY_SIZE(ssi_sels));
d246f7033318f9 drivers/clk/imx/clk-imx6sx.c   Han Xu       2022-09-14  283  	hws[IMX6SX_CLK_QSPI1_SEL]          = imx_clk_hw_mux("qspi1_sel",        base + 0x1c,  7,      3,      qspi1_sels,        ARRAY_SIZE(qspi1_sels);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  284  	hws[IMX6SX_CLK_PERCLK_SEL]         = imx_clk_hw_mux("perclk_sel",       base + 0x1c,  6,      1,      perclk_sels,       ARRAY_SIZE(perclk_sels));
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  285  	hws[IMX6SX_CLK_VID_SEL]            = imx_clk_hw_mux("vid_sel",          base + 0x20,  21,     3,      vid_sels,          ARRAY_SIZE(vid_sels));
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  286  	hws[IMX6SX_CLK_ESAI_SEL]           = imx_clk_hw_mux("esai_sel",         base + 0x20,  19,     2,      audio_sels,        ARRAY_SIZE(audio_sels));
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  287  	hws[IMX6SX_CLK_CAN_SEL]            = imx_clk_hw_mux("can_sel",          base + 0x20,  8,      2,      can_sels,          ARRAY_SIZE(can_sels));
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  288  	hws[IMX6SX_CLK_UART_SEL]           = imx_clk_hw_mux("uart_sel",         base + 0x24,  6,      1,      uart_sels,         ARRAY_SIZE(uart_sels));
d246f7033318f9 drivers/clk/imx/clk-imx6sx.c   Han Xu       2022-09-14  289  	hws[IMX6SX_CLK_QSPI2_SEL]          = imx_clk_hw_mux("qspi2_sel",        base + 0x2c,  15,     3,      qspi2_sels,        ARRAY_SIZE(qspi2_sels);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  290  	hws[IMX6SX_CLK_SPDIF_SEL]          = imx_clk_hw_mux("spdif_sel",        base + 0x30,  20,     2,      audio_sels,        ARRAY_SIZE(audio_sels));
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  291  	hws[IMX6SX_CLK_AUDIO_SEL]          = imx_clk_hw_mux("audio_sel",        base + 0x30,  7,      2,      audio_sels,        ARRAY_SIZE(audio_sels));
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  292  	hws[IMX6SX_CLK_ENET_PRE_SEL]       = imx_clk_hw_mux("enet_pre_sel",     base + 0x34,  15,     3,      enet_pre_sels,     ARRAY_SIZE(enet_pre_sels));
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  293  	hws[IMX6SX_CLK_ENET_SEL]           = imx_clk_hw_mux("enet_sel",         base + 0x34,  9,      3,      enet_sels,         ARRAY_SIZE(enet_sels));
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  294  	hws[IMX6SX_CLK_M4_PRE_SEL]         = imx_clk_hw_mux("m4_pre_sel",       base + 0x34,  6,      3,      m4_pre_sels,       ARRAY_SIZE(m4_pre_sels));
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  295  	hws[IMX6SX_CLK_M4_SEL]             = imx_clk_hw_mux("m4_sel",           base + 0x34,  0,      3,      m4_sels,           ARRAY_SIZE(m4_sels));
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  296  	hws[IMX6SX_CLK_ECSPI_SEL]          = imx_clk_hw_mux("ecspi_sel",        base + 0x38,  18,     1,      ecspi_sels,        ARRAY_SIZE(ecspi_sels));
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  297  	hws[IMX6SX_CLK_LCDIF2_PRE_SEL]     = imx_clk_hw_mux("lcdif2_pre_sel",   base + 0x38,  6,      3,      lcdif2_pre_sels,   ARRAY_SIZE(lcdif2_pre_sels));
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  298  	hws[IMX6SX_CLK_LCDIF2_SEL]         = imx_clk_hw_mux("lcdif2_sel",       base + 0x38,  0,      3,      lcdif2_sels,       ARRAY_SIZE(lcdif2_sels));
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  299  	hws[IMX6SX_CLK_DISPLAY_SEL]        = imx_clk_hw_mux("display_sel",      base + 0x3c,  14,     2,      display_sels,      ARRAY_SIZE(display_sels));
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  300  	hws[IMX6SX_CLK_CSI_SEL]            = imx_clk_hw_mux("csi_sel",          base + 0x3c,  9,      2,      csi_sels,          ARRAY_SIZE(csi_sels));
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  301  	hws[IMX6SX_CLK_CKO1_SEL]           = imx_clk_hw_mux("cko1_sel",         base + 0x60,  0,      4,      cko1_sels,         ARRAY_SIZE(cko1_sels));
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  302  	hws[IMX6SX_CLK_CKO2_SEL]           = imx_clk_hw_mux("cko2_sel",         base + 0x60,  16,     5,      cko2_sels,         ARRAY_SIZE(cko2_sels));
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  303  	hws[IMX6SX_CLK_CKO]                = imx_clk_hw_mux("cko",              base + 0x60,  8,      1,      cko_sels,          ARRAY_SIZE(cko_sels));
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  304  
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  305  	hws[IMX6SX_CLK_LDB_DI1_DIV_SEL]    = imx_clk_hw_mux_flags("ldb_di1_div_sel", base + 0x20, 11, 1, ldb_di1_div_sels, ARRAY_SIZE(ldb_di1_div_sels), CLK_SET_RATE_PARENT);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  306  	hws[IMX6SX_CLK_LDB_DI0_DIV_SEL]    = imx_clk_hw_mux_flags("ldb_di0_div_sel", base + 0x20, 10, 1, ldb_di0_div_sels, ARRAY_SIZE(ldb_di0_div_sels), CLK_SET_RATE_PARENT);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  307  	hws[IMX6SX_CLK_LDB_DI1_SEL]        = imx_clk_hw_mux_flags("ldb_di1_sel",     base + 0x2c, 12, 3, ldb_di1_sels,      ARRAY_SIZE(ldb_di1_sels),    CLK_SET_RATE_PARENT);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  308  	hws[IMX6SX_CLK_LDB_DI0_SEL]        = imx_clk_hw_mux_flags("ldb_di0_sel",     base + 0x2c, 9,  3, ldb_di0_sels,      ARRAY_SIZE(ldb_di0_sels),    CLK_SET_RATE_PARENT);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  309  	hws[IMX6SX_CLK_LCDIF1_PRE_SEL]     = imx_clk_hw_mux_flags("lcdif1_pre_sel",  base + 0x38, 15, 3, lcdif1_pre_sels,   ARRAY_SIZE(lcdif1_pre_sels), CLK_SET_RATE_PARENT);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  310  	hws[IMX6SX_CLK_LCDIF1_SEL]         = imx_clk_hw_mux_flags("lcdif1_sel",      base + 0x38, 9,  3, lcdif1_sels,       ARRAY_SIZE(lcdif1_sels),     CLK_SET_RATE_PARENT);
d55135689019c3 arch/arm/mach-imx/clk-imx6sx.c Anson Huang  2014-05-11  311  
d55135689019c3 arch/arm/mach-imx/clk-imx6sx.c Anson Huang  2014-05-11  312  	/*                                                    name              parent_name          reg          shift width */
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  313  	hws[IMX6SX_CLK_PERIPH_CLK2]        = imx_clk_hw_divider("periph_clk2",    "periph_clk2_sel",   base + 0x14, 27,   3);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  314  	hws[IMX6SX_CLK_PERIPH2_CLK2]       = imx_clk_hw_divider("periph2_clk2",   "periph2_clk2_sel",  base + 0x14, 0,    3);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  315  	hws[IMX6SX_CLK_IPG]                = imx_clk_hw_divider("ipg",            "ahb",               base + 0x14, 8,    2);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  316  	hws[IMX6SX_CLK_GPU_CORE_PODF]      = imx_clk_hw_divider("gpu_core_podf",  "gpu_core_sel",      base + 0x18, 29,   3);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  317  	hws[IMX6SX_CLK_GPU_AXI_PODF]       = imx_clk_hw_divider("gpu_axi_podf",   "gpu_axi_sel",       base + 0x18, 26,   3);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  318  	hws[IMX6SX_CLK_LCDIF1_PODF]        = imx_clk_hw_divider("lcdif1_podf",    "lcdif1_pred",       base + 0x18, 23,   3);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  319  	hws[IMX6SX_CLK_QSPI1_PODF]         = imx_clk_hw_divider("qspi1_podf",     "qspi1_sel",         base + 0x1c, 26,   3);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  320  	hws[IMX6SX_CLK_EIM_SLOW_PODF]      = imx_clk_hw_divider("eim_slow_podf",  "eim_slow_sel",      base + 0x1c, 23,   3);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  321  	hws[IMX6SX_CLK_LCDIF2_PODF]        = imx_clk_hw_divider("lcdif2_podf",    "lcdif2_pred",       base + 0x1c, 20,   3);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  322  	hws[IMX6SX_CLK_PERCLK]             = imx_clk_hw_divider_flags("perclk", "perclk_sel", base + 0x1c, 0, 6, CLK_IS_CRITICAL);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  323  	hws[IMX6SX_CLK_VID_PODF]           = imx_clk_hw_divider("vid_podf",       "vid_sel",           base + 0x20, 24,   2);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  324  	hws[IMX6SX_CLK_CAN_PODF]           = imx_clk_hw_divider("can_podf",       "can_sel",           base + 0x20, 2,    6);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  325  	hws[IMX6SX_CLK_USDHC4_PODF]        = imx_clk_hw_divider("usdhc4_podf",    "usdhc4_sel",        base + 0x24, 22,   3);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  326  	hws[IMX6SX_CLK_USDHC3_PODF]        = imx_clk_hw_divider("usdhc3_podf",    "usdhc3_sel",        base + 0x24, 19,   3);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  327  	hws[IMX6SX_CLK_USDHC2_PODF]        = imx_clk_hw_divider("usdhc2_podf",    "usdhc2_sel",        base + 0x24, 16,   3);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  328  	hws[IMX6SX_CLK_USDHC1_PODF]        = imx_clk_hw_divider("usdhc1_podf",    "usdhc1_sel",        base + 0x24, 11,   3);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  329  	hws[IMX6SX_CLK_UART_PODF]          = imx_clk_hw_divider("uart_podf",      "uart_sel",          base + 0x24, 0,    6);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  330  	hws[IMX6SX_CLK_ESAI_PRED]          = imx_clk_hw_divider("esai_pred",      "esai_sel",          base + 0x28, 9,    3);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  331  	hws[IMX6SX_CLK_ESAI_PODF]          = imx_clk_hw_divider("esai_podf",      "esai_pred",         base + 0x28, 25,   3);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  332  	hws[IMX6SX_CLK_SSI3_PRED]          = imx_clk_hw_divider("ssi3_pred",      "ssi3_sel",          base + 0x28, 22,   3);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  333  	hws[IMX6SX_CLK_SSI3_PODF]          = imx_clk_hw_divider("ssi3_podf",      "ssi3_pred",         base + 0x28, 16,   6);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  334  	hws[IMX6SX_CLK_SSI1_PRED]          = imx_clk_hw_divider("ssi1_pred",      "ssi1_sel",          base + 0x28, 6,    3);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  335  	hws[IMX6SX_CLK_SSI1_PODF]          = imx_clk_hw_divider("ssi1_podf",      "ssi1_pred",         base + 0x28, 0,    6);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  336  	hws[IMX6SX_CLK_QSPI2_PRED]         = imx_clk_hw_divider("qspi2_pred",     "qspi2_sel",         base + 0x2c, 18,   3);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  337  	hws[IMX6SX_CLK_QSPI2_PODF]         = imx_clk_hw_divider("qspi2_podf",     "qspi2_pred",        base + 0x2c, 21,   6);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  338  	hws[IMX6SX_CLK_SSI2_PRED]          = imx_clk_hw_divider("ssi2_pred",      "ssi2_sel",          base + 0x2c, 6,    3);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  339  	hws[IMX6SX_CLK_SSI2_PODF]          = imx_clk_hw_divider("ssi2_podf",      "ssi2_pred",         base + 0x2c, 0,    6);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  340  	hws[IMX6SX_CLK_SPDIF_PRED]         = imx_clk_hw_divider("spdif_pred",     "spdif_sel",         base + 0x30, 25,   3);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  341  	hws[IMX6SX_CLK_SPDIF_PODF]         = imx_clk_hw_divider("spdif_podf",     "spdif_pred",        base + 0x30, 22,   3);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  342  	hws[IMX6SX_CLK_AUDIO_PRED]         = imx_clk_hw_divider("audio_pred",     "audio_sel",         base + 0x30, 12,   3);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  343  	hws[IMX6SX_CLK_AUDIO_PODF]         = imx_clk_hw_divider("audio_podf",     "audio_pred",        base + 0x30, 9,    3);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  344  	hws[IMX6SX_CLK_ENET_PODF]          = imx_clk_hw_divider("enet_podf",      "enet_pre_sel",      base + 0x34, 12,   3);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  345  	hws[IMX6SX_CLK_M4_PODF]            = imx_clk_hw_divider("m4_podf",        "m4_sel",            base + 0x34, 3,    3);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  346  	hws[IMX6SX_CLK_ECSPI_PODF]         = imx_clk_hw_divider("ecspi_podf",     "ecspi_sel",         base + 0x38, 19,   6);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  347  	hws[IMX6SX_CLK_LCDIF1_PRED]        = imx_clk_hw_divider("lcdif1_pred",    "lcdif1_pre_sel",    base + 0x38, 12,   3);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  348  	hws[IMX6SX_CLK_LCDIF2_PRED]        = imx_clk_hw_divider("lcdif2_pred",    "lcdif2_pre_sel",    base + 0x38, 3,    3);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  349  	hws[IMX6SX_CLK_DISPLAY_PODF]       = imx_clk_hw_divider("display_podf",   "display_sel",       base + 0x3c, 16,   3);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  350  	hws[IMX6SX_CLK_CSI_PODF]           = imx_clk_hw_divider("csi_podf",       "csi_sel",           base + 0x3c, 11,   3);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  351  	hws[IMX6SX_CLK_CKO1_PODF]          = imx_clk_hw_divider("cko1_podf",      "cko1_sel",          base + 0x60, 4,    3);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  352  	hws[IMX6SX_CLK_CKO2_PODF]          = imx_clk_hw_divider("cko2_podf",      "cko2_sel",          base + 0x60, 21,   3);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  353  
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  354  	hws[IMX6SX_CLK_LDB_DI0_DIV_3_5]    = imx_clk_hw_fixed_factor("ldb_di0_div_3_5", "ldb_di0_sel", 2, 7);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  355  	hws[IMX6SX_CLK_LDB_DI0_DIV_7]      = imx_clk_hw_fixed_factor("ldb_di0_div_7",   "ldb_di0_sel", 1, 7);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  356  	hws[IMX6SX_CLK_LDB_DI1_DIV_3_5]    = imx_clk_hw_fixed_factor("ldb_di1_div_3_5", "ldb_di1_sel", 2, 7);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  357  	hws[IMX6SX_CLK_LDB_DI1_DIV_7]      = imx_clk_hw_fixed_factor("ldb_di1_div_7",   "ldb_di1_sel", 1, 7);
d55135689019c3 arch/arm/mach-imx/clk-imx6sx.c Anson Huang  2014-05-11  358  
d55135689019c3 arch/arm/mach-imx/clk-imx6sx.c Anson Huang  2014-05-11  359  	/*                                               name        reg          shift width busy: reg,   shift parent_names       num_parents */
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  360  	hws[IMX6SX_CLK_PERIPH]       = imx_clk_hw_busy_mux("periph",   base + 0x14, 25,   1,    base + 0x48, 5,    periph_sels,       ARRAY_SIZE(periph_sels));
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  361  	hws[IMX6SX_CLK_PERIPH2]      = imx_clk_hw_busy_mux("periph2",  base + 0x14, 26,   1,    base + 0x48, 3,    periph2_sels,      ARRAY_SIZE(periph2_sels));
d55135689019c3 arch/arm/mach-imx/clk-imx6sx.c Anson Huang  2014-05-11  362  	/*                                                   name             parent_name    reg          shift width busy: reg,   shift */
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  363  	hws[IMX6SX_CLK_OCRAM_PODF]   = imx_clk_hw_busy_divider("ocram_podf",    "ocram_sel",   base + 0x14, 16,   3,    base + 0x48, 0);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  364  	hws[IMX6SX_CLK_AHB]          = imx_clk_hw_busy_divider("ahb",           "periph",      base + 0x14, 10,   3,    base + 0x48, 1);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  365  	hws[IMX6SX_CLK_MMDC_PODF]    = imx_clk_hw_busy_divider("mmdc_podf",     "periph2",     base + 0x14, 3,    3,    base + 0x48, 2);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  366  	hws[IMX6SX_CLK_ARM]          = imx_clk_hw_busy_divider("arm",           "pll1_sw",     base + 0x10, 0,    3,    base + 0x48, 16);
d55135689019c3 arch/arm/mach-imx/clk-imx6sx.c Anson Huang  2014-05-11  367  
d55135689019c3 arch/arm/mach-imx/clk-imx6sx.c Anson Huang  2014-05-11  368  	/*                                            name             parent_name          reg         shift */
d55135689019c3 arch/arm/mach-imx/clk-imx6sx.c Anson Huang  2014-05-11  369  	/* CCGR0 */
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  370  	hws[IMX6SX_CLK_AIPS_TZ1]     = imx_clk_hw_gate2_flags("aips_tz1", "ahb", base + 0x68, 0, CLK_IS_CRITICAL);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  371  	hws[IMX6SX_CLK_AIPS_TZ2]     = imx_clk_hw_gate2_flags("aips_tz2", "ahb", base + 0x68, 2, CLK_IS_CRITICAL);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  372  	hws[IMX6SX_CLK_APBH_DMA]     = imx_clk_hw_gate2("apbh_dma",      "usdhc3",            base + 0x68, 4);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  373  	hws[IMX6SX_CLK_ASRC_MEM]     = imx_clk_hw_gate2_shared("asrc_mem", "ahb",             base + 0x68, 6, &share_count_asrc);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  374  	hws[IMX6SX_CLK_ASRC_IPG]     = imx_clk_hw_gate2_shared("asrc_ipg", "ahb",             base + 0x68, 6, &share_count_asrc);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  375  	hws[IMX6SX_CLK_CAAM_MEM]     = imx_clk_hw_gate2("caam_mem",      "ahb",               base + 0x68, 8);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  376  	hws[IMX6SX_CLK_CAAM_ACLK]    = imx_clk_hw_gate2("caam_aclk",     "ahb",               base + 0x68, 10);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  377  	hws[IMX6SX_CLK_CAAM_IPG]     = imx_clk_hw_gate2("caam_ipg",      "ipg",               base + 0x68, 12);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  378  	hws[IMX6SX_CLK_CAN1_IPG]     = imx_clk_hw_gate2("can1_ipg",      "ipg",               base + 0x68, 14);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  379  	hws[IMX6SX_CLK_CAN1_SERIAL]  = imx_clk_hw_gate2("can1_serial",   "can_podf",          base + 0x68, 16);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  380  	hws[IMX6SX_CLK_CAN2_IPG]     = imx_clk_hw_gate2("can2_ipg",      "ipg",               base + 0x68, 18);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  381  	hws[IMX6SX_CLK_CAN2_SERIAL]  = imx_clk_hw_gate2("can2_serial",   "can_podf",          base + 0x68, 20);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  382  	hws[IMX6SX_CLK_DCIC1]        = imx_clk_hw_gate2("dcic1",         "display_podf",      base + 0x68, 24);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  383  	hws[IMX6SX_CLK_DCIC2]        = imx_clk_hw_gate2("dcic2",         "display_podf",      base + 0x68, 26);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  384  	hws[IMX6SX_CLK_AIPS_TZ3]     = imx_clk_hw_gate2_flags("aips_tz3", "ahb", base + 0x68, 30, CLK_IS_CRITICAL);
d55135689019c3 arch/arm/mach-imx/clk-imx6sx.c Anson Huang  2014-05-11  385  
d55135689019c3 arch/arm/mach-imx/clk-imx6sx.c Anson Huang  2014-05-11  386  	/* CCGR1 */
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  387  	hws[IMX6SX_CLK_ECSPI1]       = imx_clk_hw_gate2("ecspi1",        "ecspi_podf",        base + 0x6c, 0);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  388  	hws[IMX6SX_CLK_ECSPI2]       = imx_clk_hw_gate2("ecspi2",        "ecspi_podf",        base + 0x6c, 2);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  389  	hws[IMX6SX_CLK_ECSPI3]       = imx_clk_hw_gate2("ecspi3",        "ecspi_podf",        base + 0x6c, 4);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  390  	hws[IMX6SX_CLK_ECSPI4]       = imx_clk_hw_gate2("ecspi4",        "ecspi_podf",        base + 0x6c, 6);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  391  	hws[IMX6SX_CLK_ECSPI5]       = imx_clk_hw_gate2("ecspi5",        "ecspi_podf",        base + 0x6c, 8);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  392  	hws[IMX6SX_CLK_EPIT1]        = imx_clk_hw_gate2("epit1",         "perclk",            base + 0x6c, 12);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  393  	hws[IMX6SX_CLK_EPIT2]        = imx_clk_hw_gate2("epit2",         "perclk",            base + 0x6c, 14);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  394  	hws[IMX6SX_CLK_ESAI_EXTAL]   = imx_clk_hw_gate2_shared("esai_extal", "esai_podf",     base + 0x6c, 16, &share_count_esai);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  395  	hws[IMX6SX_CLK_ESAI_IPG]     = imx_clk_hw_gate2_shared("esai_ipg",   "ahb",           base + 0x6c, 16, &share_count_esai);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  396  	hws[IMX6SX_CLK_ESAI_MEM]     = imx_clk_hw_gate2_shared("esai_mem",   "ahb",           base + 0x6c, 16, &share_count_esai);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  397  	hws[IMX6SX_CLK_WAKEUP]       = imx_clk_hw_gate2_flags("wakeup", "ipg", base + 0x6c, 18, CLK_IS_CRITICAL);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  398  	hws[IMX6SX_CLK_GPT_BUS]      = imx_clk_hw_gate2("gpt_bus",       "perclk",            base + 0x6c, 20);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  399  	hws[IMX6SX_CLK_GPT_SERIAL]   = imx_clk_hw_gate2("gpt_serial",    "perclk",            base + 0x6c, 22);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  400  	hws[IMX6SX_CLK_GPU]          = imx_clk_hw_gate2("gpu",           "gpu_core_podf",     base + 0x6c, 26);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  401  	hws[IMX6SX_CLK_OCRAM_S]      = imx_clk_hw_gate2("ocram_s",       "ahb",               base + 0x6c, 28);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  402  	hws[IMX6SX_CLK_CANFD]        = imx_clk_hw_gate2("canfd",         "can_podf",          base + 0x6c, 30);
d55135689019c3 arch/arm/mach-imx/clk-imx6sx.c Anson Huang  2014-05-11  403  
d55135689019c3 arch/arm/mach-imx/clk-imx6sx.c Anson Huang  2014-05-11  404  	/* CCGR2 */
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  405  	hws[IMX6SX_CLK_CSI]          = imx_clk_hw_gate2("csi",           "csi_podf",          base + 0x70, 2);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  406  	hws[IMX6SX_CLK_I2C1]         = imx_clk_hw_gate2("i2c1",          "perclk",            base + 0x70, 6);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  407  	hws[IMX6SX_CLK_I2C2]         = imx_clk_hw_gate2("i2c2",          "perclk",            base + 0x70, 8);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  408  	hws[IMX6SX_CLK_I2C3]         = imx_clk_hw_gate2("i2c3",          "perclk",            base + 0x70, 10);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  409  	hws[IMX6SX_CLK_OCOTP]        = imx_clk_hw_gate2("ocotp",         "ipg",               base + 0x70, 12);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  410  	hws[IMX6SX_CLK_IOMUXC]       = imx_clk_hw_gate2("iomuxc",        "lcdif1_podf",       base + 0x70, 14);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  411  	hws[IMX6SX_CLK_IPMUX1]       = imx_clk_hw_gate2_flags("ipmux1", "ahb", base + 0x70, 16, CLK_IS_CRITICAL);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  412  	hws[IMX6SX_CLK_IPMUX2]       = imx_clk_hw_gate2_flags("ipmux2", "ahb", base + 0x70, 18, CLK_IS_CRITICAL);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  413  	hws[IMX6SX_CLK_IPMUX3]       = imx_clk_hw_gate2_flags("ipmux3", "ahb", base + 0x70, 20, CLK_IS_CRITICAL);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  414  	hws[IMX6SX_CLK_TZASC1]       = imx_clk_hw_gate2_flags("tzasc1", "mmdc_podf", base + 0x70, 22, CLK_IS_CRITICAL);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  415  	hws[IMX6SX_CLK_LCDIF_APB]    = imx_clk_hw_gate2("lcdif_apb",     "display_podf",      base + 0x70, 28);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  416  	hws[IMX6SX_CLK_PXP_AXI]      = imx_clk_hw_gate2("pxp_axi",       "display_podf",      base + 0x70, 30);
d55135689019c3 arch/arm/mach-imx/clk-imx6sx.c Anson Huang  2014-05-11  417  
d55135689019c3 arch/arm/mach-imx/clk-imx6sx.c Anson Huang  2014-05-11  418  	/* CCGR3 */
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  419  	hws[IMX6SX_CLK_M4]           = imx_clk_hw_gate2("m4",            "m4_podf",           base + 0x74, 2);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  420  	hws[IMX6SX_CLK_ENET]         = imx_clk_hw_gate2("enet",          "ipg",               base + 0x74, 4);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  421  	hws[IMX6SX_CLK_ENET_AHB]     = imx_clk_hw_gate2("enet_ahb",      "enet_sel",          base + 0x74, 4);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  422  	hws[IMX6SX_CLK_DISPLAY_AXI]  = imx_clk_hw_gate2("display_axi",   "display_podf",      base + 0x74, 6);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  423  	hws[IMX6SX_CLK_LCDIF2_PIX]   = imx_clk_hw_gate2("lcdif2_pix",    "lcdif2_sel",        base + 0x74, 8);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  424  	hws[IMX6SX_CLK_LCDIF1_PIX]   = imx_clk_hw_gate2("lcdif1_pix",    "lcdif1_sel",        base + 0x74, 10);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  425  	hws[IMX6SX_CLK_LDB_DI0]      = imx_clk_hw_gate2("ldb_di0",       "ldb_di0_div_sel",   base + 0x74, 12);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  426  	hws[IMX6SX_CLK_QSPI1]        = imx_clk_hw_gate2("qspi1",         "qspi1_podf",        base + 0x74, 14);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  427  	hws[IMX6SX_CLK_MLB]          = imx_clk_hw_gate2("mlb",           "ahb",               base + 0x74, 18);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  428  	hws[IMX6SX_CLK_MMDC_P0_FAST] = imx_clk_hw_gate2_flags("mmdc_p0_fast", "mmdc_podf", base + 0x74, 20, CLK_IS_CRITICAL);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  429  	hws[IMX6SX_CLK_MMDC_P0_IPG]  = imx_clk_hw_gate2_flags("mmdc_p0_ipg", "ipg", base + 0x74, 24, CLK_IS_CRITICAL);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  430  	hws[IMX6SX_CLK_MMDC_P1_IPG]  = imx_clk_hw_gate2_flags("mmdc_p1_ipg", "ipg", base + 0x74, 26, CLK_IS_CRITICAL);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  431  	hws[IMX6SX_CLK_OCRAM]        = imx_clk_hw_gate2_flags("ocram", "ocram_podf", base + 0x74, 28, CLK_IS_CRITICAL);
d55135689019c3 arch/arm/mach-imx/clk-imx6sx.c Anson Huang  2014-05-11  432  
d55135689019c3 arch/arm/mach-imx/clk-imx6sx.c Anson Huang  2014-05-11  433  	/* CCGR4 */
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  434  	hws[IMX6SX_CLK_PCIE_AXI]     = imx_clk_hw_gate2("pcie_axi",      "display_podf",      base + 0x78, 0);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  435  	hws[IMX6SX_CLK_QSPI2]        = imx_clk_hw_gate2("qspi2",         "qspi2_podf",        base + 0x78, 10);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  436  	hws[IMX6SX_CLK_PER1_BCH]     = imx_clk_hw_gate2("per1_bch",      "usdhc3",            base + 0x78, 12);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  437  	hws[IMX6SX_CLK_PER2_MAIN]    = imx_clk_hw_gate2_flags("per2_main", "ahb", base + 0x78, 14, CLK_IS_CRITICAL);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  438  	hws[IMX6SX_CLK_PWM1]         = imx_clk_hw_gate2("pwm1",          "perclk",            base + 0x78, 16);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  439  	hws[IMX6SX_CLK_PWM2]         = imx_clk_hw_gate2("pwm2",          "perclk",            base + 0x78, 18);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  440  	hws[IMX6SX_CLK_PWM3]         = imx_clk_hw_gate2("pwm3",          "perclk",            base + 0x78, 20);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  441  	hws[IMX6SX_CLK_PWM4]         = imx_clk_hw_gate2("pwm4",          "perclk",            base + 0x78, 22);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  442  	hws[IMX6SX_CLK_GPMI_BCH_APB] = imx_clk_hw_gate2("gpmi_bch_apb",  "usdhc3",            base + 0x78, 24);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  443  	hws[IMX6SX_CLK_GPMI_BCH]     = imx_clk_hw_gate2("gpmi_bch",      "usdhc4",            base + 0x78, 26);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  444  	hws[IMX6SX_CLK_GPMI_IO]      = imx_clk_hw_gate2("gpmi_io",       "qspi2_podf",        base + 0x78, 28);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  445  	hws[IMX6SX_CLK_GPMI_APB]     = imx_clk_hw_gate2("gpmi_apb",      "usdhc3",            base + 0x78, 30);
d55135689019c3 arch/arm/mach-imx/clk-imx6sx.c Anson Huang  2014-05-11  446  
d55135689019c3 arch/arm/mach-imx/clk-imx6sx.c Anson Huang  2014-05-11  447  	/* CCGR5 */
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  448  	hws[IMX6SX_CLK_ROM]          = imx_clk_hw_gate2_flags("rom", "ahb", base + 0x7c, 0, CLK_IS_CRITICAL);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  449  	hws[IMX6SX_CLK_SDMA]         = imx_clk_hw_gate2("sdma",          "ahb",               base + 0x7c, 6);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  450  	hws[IMX6SX_CLK_SPBA]         = imx_clk_hw_gate2("spba",          "ipg",               base + 0x7c, 12);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  451  	hws[IMX6SX_CLK_AUDIO]        = imx_clk_hw_gate2_shared("audio",  "audio_podf",        base + 0x7c, 14, &share_count_audio);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  452  	hws[IMX6SX_CLK_SPDIF]        = imx_clk_hw_gate2_shared("spdif",  "spdif_podf",        base + 0x7c, 14, &share_count_audio);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  453  	hws[IMX6SX_CLK_SPDIF_GCLK]   = imx_clk_hw_gate2_shared("spdif_gclk",    "ipg",        base + 0x7c, 14, &share_count_audio);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  454  	hws[IMX6SX_CLK_SSI1_IPG]     = imx_clk_hw_gate2_shared("ssi1_ipg",      "ipg",        base + 0x7c, 18, &share_count_ssi1);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  455  	hws[IMX6SX_CLK_SSI2_IPG]     = imx_clk_hw_gate2_shared("ssi2_ipg",      "ipg",        base + 0x7c, 20, &share_count_ssi2);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  456  	hws[IMX6SX_CLK_SSI3_IPG]     = imx_clk_hw_gate2_shared("ssi3_ipg",      "ipg",        base + 0x7c, 22, &share_count_ssi3);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  457  	hws[IMX6SX_CLK_SSI1]         = imx_clk_hw_gate2_shared("ssi1",          "ssi1_podf",  base + 0x7c, 18, &share_count_ssi1);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  458  	hws[IMX6SX_CLK_SSI2]         = imx_clk_hw_gate2_shared("ssi2",          "ssi2_podf",  base + 0x7c, 20, &share_count_ssi2);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  459  	hws[IMX6SX_CLK_SSI3]         = imx_clk_hw_gate2_shared("ssi3",          "ssi3_podf",  base + 0x7c, 22, &share_count_ssi3);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  460  	hws[IMX6SX_CLK_UART_IPG]     = imx_clk_hw_gate2("uart_ipg",      "ipg",               base + 0x7c, 24);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  461  	hws[IMX6SX_CLK_UART_SERIAL]  = imx_clk_hw_gate2("uart_serial",   "uart_podf",         base + 0x7c, 26);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  462  	hws[IMX6SX_CLK_SAI1_IPG]     = imx_clk_hw_gate2_shared("sai1_ipg", "ipg",             base + 0x7c, 28, &share_count_sai1);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  463  	hws[IMX6SX_CLK_SAI2_IPG]     = imx_clk_hw_gate2_shared("sai2_ipg", "ipg",             base + 0x7c, 30, &share_count_sai2);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  464  	hws[IMX6SX_CLK_SAI1]         = imx_clk_hw_gate2_shared("sai1",	"ssi1_podf",        base + 0x7c, 28, &share_count_sai1);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  465  	hws[IMX6SX_CLK_SAI2]         = imx_clk_hw_gate2_shared("sai2",	"ssi2_podf",        base + 0x7c, 30, &share_count_sai2);
d55135689019c3 arch/arm/mach-imx/clk-imx6sx.c Anson Huang  2014-05-11  466  
d55135689019c3 arch/arm/mach-imx/clk-imx6sx.c Anson Huang  2014-05-11  467  	/* CCGR6 */
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  468  	hws[IMX6SX_CLK_USBOH3]       = imx_clk_hw_gate2("usboh3",        "ipg",               base + 0x80, 0);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  469  	hws[IMX6SX_CLK_USDHC1]       = imx_clk_hw_gate2("usdhc1",        "usdhc1_podf",       base + 0x80, 2);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  470  	hws[IMX6SX_CLK_USDHC2]       = imx_clk_hw_gate2("usdhc2",        "usdhc2_podf",       base + 0x80, 4);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  471  	hws[IMX6SX_CLK_USDHC3]       = imx_clk_hw_gate2("usdhc3",        "usdhc3_podf",       base + 0x80, 6);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  472  	hws[IMX6SX_CLK_USDHC4]       = imx_clk_hw_gate2("usdhc4",        "usdhc4_podf",       base + 0x80, 8);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  473  	hws[IMX6SX_CLK_EIM_SLOW]     = imx_clk_hw_gate2("eim_slow",      "eim_slow_podf",     base + 0x80, 10);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  474  	hws[IMX6SX_CLK_PWM8]         = imx_clk_hw_gate2("pwm8",          "perclk",            base + 0x80, 16);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  475  	hws[IMX6SX_CLK_VADC]         = imx_clk_hw_gate2("vadc",          "vid_podf",          base + 0x80, 20);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  476  	hws[IMX6SX_CLK_GIS]          = imx_clk_hw_gate2("gis",           "display_podf",      base + 0x80, 22);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  477  	hws[IMX6SX_CLK_I2C4]         = imx_clk_hw_gate2("i2c4",          "perclk",            base + 0x80, 24);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  478  	hws[IMX6SX_CLK_PWM5]         = imx_clk_hw_gate2("pwm5",          "perclk",            base + 0x80, 26);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  479  	hws[IMX6SX_CLK_PWM6]         = imx_clk_hw_gate2("pwm6",          "perclk",            base + 0x80, 28);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  480  	hws[IMX6SX_CLK_PWM7]         = imx_clk_hw_gate2("pwm7",          "perclk",            base + 0x80, 30);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  481  
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  482  	hws[IMX6SX_CLK_CKO1]         = imx_clk_hw_gate("cko1",           "cko1_podf",         base + 0x60, 7);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  483  	hws[IMX6SX_CLK_CKO2]         = imx_clk_hw_gate("cko2",           "cko2_podf",         base + 0x60, 24);
d55135689019c3 arch/arm/mach-imx/clk-imx6sx.c Anson Huang  2014-05-11  484  
d55135689019c3 arch/arm/mach-imx/clk-imx6sx.c Anson Huang  2014-05-11  485  	/* mask handshake of mmdc */
c129b6fe81cd96 drivers/clk/imx/clk-imx6sx.c   Anson Huang  2019-05-12  486  	imx_mmdc_mask_handshake(base, 0);
d55135689019c3 arch/arm/mach-imx/clk-imx6sx.c Anson Huang  2014-05-11  487  
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  488  	imx_check_clk_hws(hws, IMX6SX_CLK_CLK_END);
d55135689019c3 arch/arm/mach-imx/clk-imx6sx.c Anson Huang  2014-05-11  489  
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  490  	of_clk_add_hw_provider(np, of_clk_hw_onecell_get, clk_hw_data);
d55135689019c3 arch/arm/mach-imx/clk-imx6sx.c Anson Huang  2014-05-11  491  
d55135689019c3 arch/arm/mach-imx/clk-imx6sx.c Anson Huang  2014-05-11  492  	if (IS_ENABLED(CONFIG_USB_MXS_PHY)) {
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  493  		clk_prepare_enable(hws[IMX6SX_CLK_USBPHY1_GATE]->clk);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  494  		clk_prepare_enable(hws[IMX6SX_CLK_USBPHY2_GATE]->clk);
d55135689019c3 arch/arm/mach-imx/clk-imx6sx.c Anson Huang  2014-05-11  495  	}
d55135689019c3 arch/arm/mach-imx/clk-imx6sx.c Anson Huang  2014-05-11  496  
d55135689019c3 arch/arm/mach-imx/clk-imx6sx.c Anson Huang  2014-05-11  497  	/* Set the default 132MHz for EIM module */
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  498  	clk_set_parent(hws[IMX6SX_CLK_EIM_SLOW_SEL]->clk, hws[IMX6SX_CLK_PLL2_PFD2]->clk);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  499  	clk_set_rate(hws[IMX6SX_CLK_EIM_SLOW]->clk, 132000000);
d55135689019c3 arch/arm/mach-imx/clk-imx6sx.c Anson Huang  2014-05-11  500  
d55135689019c3 arch/arm/mach-imx/clk-imx6sx.c Anson Huang  2014-05-11  501  	/* set parent clock for LCDIF1 pixel clock */
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  502  	clk_set_parent(hws[IMX6SX_CLK_LCDIF1_PRE_SEL]->clk, hws[IMX6SX_CLK_PLL5_VIDEO_DIV]->clk);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  503  	clk_set_parent(hws[IMX6SX_CLK_LCDIF1_SEL]->clk, hws[IMX6SX_CLK_LCDIF1_PODF]->clk);
d55135689019c3 arch/arm/mach-imx/clk-imx6sx.c Anson Huang  2014-05-11  504  
d55135689019c3 arch/arm/mach-imx/clk-imx6sx.c Anson Huang  2014-05-11  505  	/* Set the parent clks of PCIe lvds1 and pcie_axi to be pcie ref, axi */
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  506  	if (clk_set_parent(hws[IMX6SX_CLK_LVDS1_SEL]->clk, hws[IMX6SX_CLK_PCIE_REF_125M]->clk))
d55135689019c3 arch/arm/mach-imx/clk-imx6sx.c Anson Huang  2014-05-11  507  		pr_err("Failed to set pcie bus parent clk.\n");
d55135689019c3 arch/arm/mach-imx/clk-imx6sx.c Anson Huang  2014-05-11  508  
d55135689019c3 arch/arm/mach-imx/clk-imx6sx.c Anson Huang  2014-05-11  509  	/*
6a53bc750004fd arch/arm/mach-imx/clk-imx6sx.c Russell King 2015-05-14  510  	 * Init enet system AHB clock, set to 200MHz
d55135689019c3 arch/arm/mach-imx/clk-imx6sx.c Anson Huang  2014-05-11  511  	 * pll2_pfd2_396m-> ENET_PODF-> ENET_AHB
d55135689019c3 arch/arm/mach-imx/clk-imx6sx.c Anson Huang  2014-05-11  512  	 */
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  513  	clk_set_parent(hws[IMX6SX_CLK_ENET_PRE_SEL]->clk, hws[IMX6SX_CLK_PLL2_PFD2]->clk);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  514  	clk_set_parent(hws[IMX6SX_CLK_ENET_SEL]->clk, hws[IMX6SX_CLK_ENET_PODF]->clk);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  515  	clk_set_rate(hws[IMX6SX_CLK_ENET_PODF]->clk, 200000000);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  516  	clk_set_rate(hws[IMX6SX_CLK_ENET_REF]->clk, 125000000);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  517  	clk_set_rate(hws[IMX6SX_CLK_ENET2_REF]->clk, 125000000);
d55135689019c3 arch/arm/mach-imx/clk-imx6sx.c Anson Huang  2014-05-11  518  
d55135689019c3 arch/arm/mach-imx/clk-imx6sx.c Anson Huang  2014-05-11  519  	/* Audio clocks */
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  520  	clk_set_rate(hws[IMX6SX_CLK_PLL4_AUDIO_DIV]->clk, 393216000);
d55135689019c3 arch/arm/mach-imx/clk-imx6sx.c Anson Huang  2014-05-11  521  
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  522  	clk_set_parent(hws[IMX6SX_CLK_SPDIF_SEL]->clk, hws[IMX6SX_CLK_PLL4_AUDIO_DIV]->clk);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  523  	clk_set_rate(hws[IMX6SX_CLK_SPDIF_PODF]->clk, 98304000);
d55135689019c3 arch/arm/mach-imx/clk-imx6sx.c Anson Huang  2014-05-11  524  
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  525  	clk_set_parent(hws[IMX6SX_CLK_AUDIO_SEL]->clk, hws[IMX6SX_CLK_PLL3_USB_OTG]->clk);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  526  	clk_set_rate(hws[IMX6SX_CLK_AUDIO_PODF]->clk, 24000000);
d55135689019c3 arch/arm/mach-imx/clk-imx6sx.c Anson Huang  2014-05-11  527  
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  528  	clk_set_parent(hws[IMX6SX_CLK_SSI1_SEL]->clk, hws[IMX6SX_CLK_PLL4_AUDIO_DIV]->clk);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  529  	clk_set_parent(hws[IMX6SX_CLK_SSI2_SEL]->clk, hws[IMX6SX_CLK_PLL4_AUDIO_DIV]->clk);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  530  	clk_set_parent(hws[IMX6SX_CLK_SSI3_SEL]->clk, hws[IMX6SX_CLK_PLL4_AUDIO_DIV]->clk);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  531  	clk_set_rate(hws[IMX6SX_CLK_SSI1_PODF]->clk, 24576000);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  532  	clk_set_rate(hws[IMX6SX_CLK_SSI2_PODF]->clk, 24576000);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  533  	clk_set_rate(hws[IMX6SX_CLK_SSI3_PODF]->clk, 24576000);
d55135689019c3 arch/arm/mach-imx/clk-imx6sx.c Anson Huang  2014-05-11  534  
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  535  	clk_set_parent(hws[IMX6SX_CLK_ESAI_SEL]->clk, hws[IMX6SX_CLK_PLL4_AUDIO_DIV]->clk);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  536  	clk_set_rate(hws[IMX6SX_CLK_ESAI_PODF]->clk, 24576000);
d55135689019c3 arch/arm/mach-imx/clk-imx6sx.c Anson Huang  2014-05-11  537  
d55135689019c3 arch/arm/mach-imx/clk-imx6sx.c Anson Huang  2014-05-11  538  	/* Set parent clock for vadc */
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  539  	clk_set_parent(hws[IMX6SX_CLK_VID_SEL]->clk, hws[IMX6SX_CLK_PLL3_USB_OTG]->clk);
d55135689019c3 arch/arm/mach-imx/clk-imx6sx.c Anson Huang  2014-05-11  540  
d55135689019c3 arch/arm/mach-imx/clk-imx6sx.c Anson Huang  2014-05-11  541  	/* default parent of can_sel clock is invalid, manually set it here */
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  542  	clk_set_parent(hws[IMX6SX_CLK_CAN_SEL]->clk, hws[IMX6SX_CLK_PLL3_60M]->clk);
d55135689019c3 arch/arm/mach-imx/clk-imx6sx.c Anson Huang  2014-05-11  543  
d55135689019c3 arch/arm/mach-imx/clk-imx6sx.c Anson Huang  2014-05-11  544  	/* Update gpu clock from default 528M to 720M */
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  545  	clk_set_parent(hws[IMX6SX_CLK_GPU_CORE_SEL]->clk, hws[IMX6SX_CLK_PLL3_PFD0]->clk);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  546  	clk_set_parent(hws[IMX6SX_CLK_GPU_AXI_SEL]->clk, hws[IMX6SX_CLK_PLL3_PFD0]->clk);
d55135689019c3 arch/arm/mach-imx/clk-imx6sx.c Anson Huang  2014-05-11  547  
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  548  	clk_set_parent(hws[IMX6SX_CLK_QSPI1_SEL]->clk, hws[IMX6SX_CLK_PLL2_BUS]->clk);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  549  	clk_set_parent(hws[IMX6SX_CLK_QSPI2_SEL]->clk, hws[IMX6SX_CLK_PLL2_BUS]->clk);
f1541e15e38ec3 drivers/clk/imx/clk-imx6sx.c   Abel Vesa    2019-05-29  550  
379c9a24cc2390 drivers/clk/imx/clk-imx6sx.c   Adam Ford    2021-03-13  551  	imx_register_uart_clocks(2);
d55135689019c3 arch/arm/mach-imx/clk-imx6sx.c Anson Huang  2014-05-11  552  }
d55135689019c3 arch/arm/mach-imx/clk-imx6sx.c Anson Huang  2014-05-11 @553  CLK_OF_DECLARE(imx6sx, "fsl,imx6sx-ccm", imx6sx_clocks_init);

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
