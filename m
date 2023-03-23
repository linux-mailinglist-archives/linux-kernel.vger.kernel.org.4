Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 262236C5F84
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 07:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjCWGPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 02:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjCWGPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 02:15:16 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5A010A96;
        Wed, 22 Mar 2023 23:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679552115; x=1711088115;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=K+tsOStEKSUmWTrSxW8kyIQZ2eMLpgKoXdX9PkiVDnE=;
  b=fZiGnkMNZHTfuqQ6dTlJjSOm71yU2Hb75qE6UF2ZiCZxBoLnHJRsGbZX
   HezYzUkVwfj/A5wiry4XkI3srYgzqTK9KSps+yvmyrsoBc7moCJzvhCGY
   FjsI6S5MPgetq7avza2ivQxugdEg/JiEqUuG3U6OgjvCH2PLEHdMIUwXt
   yXXOJc7dWzcsLGq+qOm1j99sJiXIQnljp/AQ25+/LSl5WGDifsKQoq2Zd
   6fEyFCEaKNlrswZQAvLqooDC2XF0gmu+JQwRCl7+UHAQA4zNco9cKj1bM
   Cn+tbVU9PiTJ2ijsDaN2rq7y6+1q9v95HqA/E/d5DEsVmW5b+fWy5yrNF
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="327785202"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="327785202"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 23:15:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="746598086"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="746598086"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 22 Mar 2023 23:15:12 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pfEEC-000E2S-0C;
        Thu, 23 Mar 2023 06:15:12 +0000
Date:   Thu, 23 Mar 2023 14:14:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Yang <mmyangfl@gmail.com>, linux-clk@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, David Yang <mmyangfl@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 6/9] clk: hisilicon: Convert to platform_driver
Message-ID: <202303231426.GOJVQoEn-lkp@intel.com>
References: <20230322164201.2454771-7-mmyangfl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322164201.2454771-7-mmyangfl@gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on 6015b1aca1a233379625385feb01dd014aca60b5]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Yang/clk-hisilicon-Rename-Hi3798CV200-to-Hi3798/20230323-004453
base:   6015b1aca1a233379625385feb01dd014aca60b5
patch link:    https://lore.kernel.org/r/20230322164201.2454771-7-mmyangfl%40gmail.com
patch subject: [PATCH v7 6/9] clk: hisilicon: Convert to platform_driver
config: arm-allmodconfig (https://download.01.org/0day-ci/archive/20230323/202303231426.GOJVQoEn-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/f551034776d2c5eb0495634bd2f8bde5c4743f92
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review David-Yang/clk-hisilicon-Rename-Hi3798CV200-to-Hi3798/20230323-004453
        git checkout f551034776d2c5eb0495634bd2f8bde5c4743f92
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/clk/hisilicon/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303231426.GOJVQoEn-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/clk/hisilicon/clk-hix5hd2.c: In function 'hix5hd2_clk_register_complex':
>> drivers/clk/hisilicon/clk-hix5hd2.c:260:46: warning: initialization discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     260 |         struct hix5hd2_complex_clock *clks = clocks;
         |                                              ^~~~~~


vim +/const +260 drivers/clk/hisilicon/clk-hix5hd2.c

   255	
   256	static int
   257	hix5hd2_clk_register_complex(struct device *dev, const void *clocks, int nums,
   258				     struct hisi_clock_data *data)
   259	{
 > 260		struct hix5hd2_complex_clock *clks = clocks;
   261		void __iomem *base = data->base;
   262		int i;
   263	
   264		for (i = 0; i < nums; i++) {
   265			struct hix5hd2_clk_complex *p_clk;
   266			struct clk *clk;
   267			struct clk_init_data init;
   268	
   269			p_clk = kzalloc(sizeof(*p_clk), GFP_KERNEL);
   270			if (!p_clk)
   271				return -ENOMEM;
   272	
   273			init.name = clks[i].name;
   274			if (clks[i].type == TYPE_ETHER)
   275				init.ops = &clk_ether_ops;
   276			else
   277				init.ops = &clk_complex_ops;
   278	
   279			init.flags = 0;
   280			init.parent_names =
   281				(clks[i].parent_name ? &clks[i].parent_name : NULL);
   282			init.num_parents = (clks[i].parent_name ? 1 : 0);
   283	
   284			p_clk->ctrl_reg = base + clks[i].ctrl_reg;
   285			p_clk->ctrl_clk_mask = clks[i].ctrl_clk_mask;
   286			p_clk->ctrl_rst_mask = clks[i].ctrl_rst_mask;
   287			p_clk->phy_reg = base + clks[i].phy_reg;
   288			p_clk->phy_clk_mask = clks[i].phy_clk_mask;
   289			p_clk->phy_rst_mask = clks[i].phy_rst_mask;
   290			p_clk->hw.init = &init;
   291	
   292			clk = clk_register(NULL, &p_clk->hw);
   293			if (IS_ERR(clk)) {
   294				kfree(p_clk);
   295				pr_err("%s: failed to register clock %s\n",
   296				       __func__, clks[i].name);
   297				return PTR_ERR(p_clk);
   298			}
   299	
   300			data->clk_data.clks[clks[i].id] = clk;
   301		}
   302	
   303		return 0;
   304	}
   305	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
