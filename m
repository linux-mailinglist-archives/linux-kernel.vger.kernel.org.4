Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 948D36C5FE6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 07:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjCWGpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 02:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbjCWGpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 02:45:22 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7B82E0F4;
        Wed, 22 Mar 2023 23:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679553916; x=1711089916;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=A6mO3eZa9srZD0TwB6Z9CiOjfI3r19eFRufP6HLE7HM=;
  b=HUzhp1t1FBraVoM1KMG5rR+3p+VTyTEB+nsJFXuwAPFodqVYV37yjIiy
   KfzZOThYsZgC77zFY9/8cZRosJRWWE8InxUV1cmvwDNxmuTOnFZimhJOS
   kTk+QtzYKogcajQ9/ZvV1LXdhuMmx2/XQ1e+FEdkXTjKlHNI8QfvOG6yi
   8hx+p86ZbxS6JsduPlWQ1MmfIK6wAn1mZpjPMO6bPdTGymmluGIlfk+Jf
   rbP/3XPBto15IibhPsGQ/gooVYMMFBpyTTMNIb4dQTXiI4EcIWJXrLnI6
   Omfsi/CEhjdd5PA+x6qxIh819s1rOg+KQXek9av24FI93GkakkLAOt+5r
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="319800782"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="319800782"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 23:45:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="632275854"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="632275854"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 22 Mar 2023 23:45:14 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pfEhF-000E5A-19;
        Thu, 23 Mar 2023 06:45:13 +0000
Date:   Thu, 23 Mar 2023 14:44:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Yang <mmyangfl@gmail.com>, linux-clk@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, David Yang <mmyangfl@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 7/9] clk: hisilicon: Migrate devm APIs
Message-ID: <202303231400.ccfrqXUI-lkp@intel.com>
References: <20230322164201.2454771-8-mmyangfl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322164201.2454771-8-mmyangfl@gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on 6015b1aca1a233379625385feb01dd014aca60b5]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Yang/clk-hisilicon-Rename-Hi3798CV200-to-Hi3798/20230323-004453
base:   6015b1aca1a233379625385feb01dd014aca60b5
patch link:    https://lore.kernel.org/r/20230322164201.2454771-8-mmyangfl%40gmail.com
patch subject: [PATCH v7 7/9] clk: hisilicon: Migrate devm APIs
config: arm-allmodconfig (https://download.01.org/0day-ci/archive/20230323/202303231400.ccfrqXUI-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/8d88e46ef325130e4dd516ce36e3e0484bc52230
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review David-Yang/clk-hisilicon-Rename-Hi3798CV200-to-Hi3798/20230323-004453
        git checkout 8d88e46ef325130e4dd516ce36e3e0484bc52230
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/clk/hisilicon/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303231400.ccfrqXUI-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/device.h:15,
                    from drivers/clk/hisilicon/clk-hi3620.c:14:
   drivers/clk/hisilicon/clk-hi3620.c: In function 'clk_register_hisi_mmc':
>> drivers/clk/hisilicon/clk-hi3620.c:435:35: error: 'clks' undeclared (first use in this function); did you mean 'clk'?
     435 |                         __func__, clks[i].name);
         |                                   ^~~~
   include/linux/dev_printk.h:110:37: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                                     ^~~~~~~~~~~
   drivers/clk/hisilicon/clk-hi3620.c:434:17: note: in expansion of macro 'dev_err'
     434 |                 dev_err(dev, "%s: failed to register clock %s\n",
         |                 ^~~~~~~
   drivers/clk/hisilicon/clk-hi3620.c:435:35: note: each undeclared identifier is reported only once for each function it appears in
     435 |                         __func__, clks[i].name);
         |                                   ^~~~
   include/linux/dev_printk.h:110:37: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                                     ^~~~~~~~~~~
   drivers/clk/hisilicon/clk-hi3620.c:434:17: note: in expansion of macro 'dev_err'
     434 |                 dev_err(dev, "%s: failed to register clock %s\n",
         |                 ^~~~~~~
>> drivers/clk/hisilicon/clk-hi3620.c:435:40: error: 'i' undeclared (first use in this function)
     435 |                         __func__, clks[i].name);
         |                                        ^
   include/linux/dev_printk.h:110:37: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                                     ^~~~~~~~~~~
   drivers/clk/hisilicon/clk-hi3620.c:434:17: note: in expansion of macro 'dev_err'
     434 |                 dev_err(dev, "%s: failed to register clock %s\n",
         |                 ^~~~~~~
>> drivers/clk/hisilicon/clk-hi3620.c:436:24: warning: returning 'int' from a function with return type 'struct clk_hw *' makes pointer from integer without a cast [-Wint-conversion]
     436 |                 return ret;
         |                        ^~~
--
   drivers/clk/hisilicon/clk-hix5hd2.c: In function 'hix5hd2_clk_register_complex':
   drivers/clk/hisilicon/clk-hix5hd2.c:260:46: warning: initialization discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     260 |         struct hix5hd2_complex_clock *clks = clocks;
         |                                              ^~~~~~
>> drivers/clk/hisilicon/clk-hix5hd2.c:300:31: error: 'data->clk_data' is a pointer; did you mean to use '->'?
     300 |                 data->clk_data.clks[clks[i].id] = clk;
         |                               ^
         |                               ->


vim +435 drivers/clk/hisilicon/clk-hi3620.c

   399	
   400	static struct clk_hw *
   401	clk_register_hisi_mmc(struct device *dev, const struct hisi_mmc_clock *mmc_clk,
   402			      void __iomem *base)
   403	{
   404		struct clk_mmc *mclk;
   405		struct clk_init_data init;
   406		int ret;
   407	
   408		mclk = devm_kzalloc(dev, sizeof(*mclk), GFP_KERNEL);
   409		if (!mclk)
   410			return ERR_PTR(-ENOMEM);
   411	
   412		init.name = mmc_clk->name;
   413		init.ops = &clk_mmc_ops;
   414		init.flags = mmc_clk->flags;
   415		init.parent_names = (mmc_clk->parent_name ? &mmc_clk->parent_name : NULL);
   416		init.num_parents = (mmc_clk->parent_name ? 1 : 0);
   417		mclk->hw.init = &init;
   418	
   419		mclk->id = mmc_clk->id;
   420		mclk->clken_reg = base + mmc_clk->clken_reg;
   421		mclk->clken_bit = mmc_clk->clken_bit;
   422		mclk->div_reg = base + mmc_clk->div_reg;
   423		mclk->div_off = mmc_clk->div_off;
   424		mclk->div_bits = mmc_clk->div_bits;
   425		mclk->drv_reg = base + mmc_clk->drv_reg;
   426		mclk->drv_off = mmc_clk->drv_off;
   427		mclk->drv_bits = mmc_clk->drv_bits;
   428		mclk->sam_reg = base + mmc_clk->sam_reg;
   429		mclk->sam_off = mmc_clk->sam_off;
   430		mclk->sam_bits = mmc_clk->sam_bits;
   431	
   432		ret = devm_clk_hw_register(dev, &mclk->hw);
   433		if (ret) {
   434			dev_err(dev, "%s: failed to register clock %s\n",
 > 435				__func__, clks[i].name);
 > 436			return ret;
   437		}
   438	
   439		return &mclk->hw;
   440	}
   441	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
