Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4836C9986
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 04:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjC0CMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 22:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjC0CME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 22:12:04 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B35AD4EFF;
        Sun, 26 Mar 2023 19:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679883123; x=1711419123;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8S/SepVjMRx72JXxp5dop7Uh13vNqZ05re9q9sjARYo=;
  b=HoLh+POCGOJBS6K8f7YXgEiD5j10sZLGNIM+OZUvkmtwmLHovvsEd+Vk
   cOJQOSBcQY7xQVqqE01S/rzXfYwkk+0psc524OnQfJp5YIqX8seAaTvl3
   TBF0dfWBHovqt5VvYT4UifLaZCC9yA/21BPt0scrpsfNRNfQWbaEmGmmi
   0s0hjHoyCywzJrLt5xnWYR/z5PT5tnCawcR/zKxd758RVHeYijFEzhdVa
   1eYtOixEmK3FE0GfOGEDKNSs3mY3ovkRb368TrmP5EgZVw6vUSvchnn4P
   jUI4vK/RlQeafaEw+D7oVGDVdMsKeYlazmUc/8C9fTSUo5ymiXDBOFG14
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="367902105"
X-IronPort-AV: E=Sophos;i="5.98,293,1673942400"; 
   d="scan'208";a="367902105"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2023 19:12:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="857502189"
X-IronPort-AV: E=Sophos;i="5.98,293,1673942400"; 
   d="scan'208";a="857502189"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 26 Mar 2023 19:12:00 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pgcL2-000HTf-0C;
        Mon, 27 Mar 2023 02:12:00 +0000
Date:   Mon, 27 Mar 2023 10:11:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Yang <mmyangfl@gmail.com>, linux-clk@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        David Yang <mmyangfl@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        Nick Alcock <nick.alcock@oracle.com>
Subject: Re: [PATCH 4/4] clk: hisilicon: Migrate devm APIs
Message-ID: <202303271023.do1t8Cfa-lkp@intel.com>
References: <20230326052757.297551-5-mmyangfl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230326052757.297551-5-mmyangfl@gmail.com>
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

Thank you for the patch! Yet something to improve:

[auto build test ERROR on fff5a5e7f528b2ed2c335991399a766c2cf01103]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Yang/clk-hisilicon-Add-helper-functions-for-platform-driver/20230326-133108
base:   fff5a5e7f528b2ed2c335991399a766c2cf01103
patch link:    https://lore.kernel.org/r/20230326052757.297551-5-mmyangfl%40gmail.com
patch subject: [PATCH 4/4] clk: hisilicon: Migrate devm APIs
config: arm-defconfig (https://download.01.org/0day-ci/archive/20230327/202303271023.do1t8Cfa-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 67409911353323ca5edf2049ef0df54132fa1ca7)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/intel-lab-lkp/linux/commit/7fd49da57e4d2205c1f5842dc29fc79c0f89263e
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review David-Yang/clk-hisilicon-Add-helper-functions-for-platform-driver/20230326-133108
        git checkout 7fd49da57e4d2205c1f5842dc29fc79c0f89263e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/clk/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303271023.do1t8Cfa-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/clk/hisilicon/clk-hi3620.c:435:14: error: use of undeclared identifier 'clks'
                           __func__, clks[i].name);
                                     ^
>> drivers/clk/hisilicon/clk-hi3620.c:435:19: error: use of undeclared identifier 'i'
                           __func__, clks[i].name);
                                          ^
>> drivers/clk/hisilicon/clk-hi3620.c:436:10: error: incompatible integer to pointer conversion returning 'int' from a function with result type 'struct clk_hw *' [-Wint-conversion]
                   return ret;
                          ^~~
   3 errors generated.
--
>> drivers/clk/hisilicon/clk-hix5hd2.c:300:17: error: member reference type 'struct clk_hw_onecell_data *' is a pointer; did you mean to use '->'?
                   data->clk_data.clks[clks[i].id] = clk;
                   ~~~~~~~~~~~~~~^
                                 ->
>> drivers/clk/hisilicon/clk-hix5hd2.c:300:18: error: no member named 'clks' in 'struct clk_hw_onecell_data'
                   data->clk_data.clks[clks[i].id] = clk;
                   ~~~~~~~~~~~~~~ ^
   2 errors generated.


vim +/clks +435 drivers/clk/hisilicon/clk-hi3620.c

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
