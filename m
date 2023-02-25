Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D85F66A2971
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 13:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjBYMGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 07:06:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBYMGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 07:06:39 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3921F144AA;
        Sat, 25 Feb 2023 04:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677326797; x=1708862797;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kXlFv0VM1scl/3fVxb7GACNApgIxpmbqk/4Qeq95V9I=;
  b=eFbedvnJnPSMebuu54I7VwUkzKreAziYV+imuJVaja8L7hQqHdyScr21
   G2aGkwcUTuhHoYV6bmZI3Xyfq7lQussLVbOcH/wlXq8t8iohWdK8eQYmL
   hv7J+R+CbmQi4lLus3/DE1rf2z6hcDyaa+wE1BW3O8EOSyc8bBKRK2Mlw
   WbDLakHejzEFez0x6cUcn88RqxcADNMCunFnXLZubWLMtrPT1V27v6SU3
   vClkbaASR6biq26+SGcLn0/RT2AY0bnQ9EkDQ07Nwn1FJ3VvX/u0JB7LO
   MblkIzZjiSEoqi9AHRvssyXcvqeW05JQ8JV1720mVYjAEWwWB0pCNukDG
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10631"; a="335090444"
X-IronPort-AV: E=Sophos;i="5.97,327,1669104000"; 
   d="scan'208";a="335090444"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2023 04:06:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10631"; a="673187249"
X-IronPort-AV: E=Sophos;i="5.97,327,1669104000"; 
   d="scan'208";a="673187249"
Received: from lkp-server01.sh.intel.com (HELO 3895f5c55ead) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 25 Feb 2023 04:06:30 -0800
Received: from kbuild by 3895f5c55ead with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pVtJt-0003Ah-0u;
        Sat, 25 Feb 2023 12:06:29 +0000
Date:   Sat, 25 Feb 2023 20:05:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yassine Oudjana <yassine.oudjana@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Daniel Golle <daniel@makrotopia.org>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Edward-JW Yang <edward-jw.yang@mediatek.com>,
        Johnson Wang <johnson.wang@mediatek.com>,
        Fabien Parent <fparent@baylibre.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     oe-kbuild-all@lists.linux.dev,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 4/4] clk: mediatek: Add drivers for MediaTek MT6735
 main clock and reset drivers
Message-ID: <202302251958.hFATZOVS-lkp@intel.com>
References: <20230225094246.261697-5-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230225094246.261697-5-y.oudjana@protonmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yassine,

I love your patch! Perhaps something to improve:

[auto build test WARNING on clk/clk-next]
[also build test WARNING on robh/for-next krzk/for-next krzk-dt/for-next krzk-mem-ctrl/for-next linus/master pza/reset/next v6.2 next-20230225]
[cannot apply to pza/imx-drm/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yassine-Oudjana/dt-bindings-clock-Add-MediaTek-MT6735-clock-bindings/20230225-174603
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
patch link:    https://lore.kernel.org/r/20230225094246.261697-5-y.oudjana%40protonmail.com
patch subject: [PATCH v3 4/4] clk: mediatek: Add drivers for MediaTek MT6735 main clock and reset drivers
config: sparc-allyesconfig (https://download.01.org/0day-ci/archive/20230225/202302251958.hFATZOVS-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/de4ed4bf78e894ade5d21d52861ee9e647d645a5
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Yassine-Oudjana/dt-bindings-clock-Add-MediaTek-MT6735-clock-bindings/20230225-174603
        git checkout de4ed4bf78e894ade5d21d52861ee9e647d645a5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sparc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sparc SHELL=/bin/bash drivers/clk/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302251958.hFATZOVS-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/clk/mediatek/clk-mt6735-apmixedsys.c:80:5: warning: no previous prototype for 'clk_mt6735_apmixed_probe' [-Wmissing-prototypes]
      80 | int clk_mt6735_apmixed_probe(struct platform_device *pdev)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/clk/mediatek/clk-mt6735-apmixedsys.c:112:5: warning: no previous prototype for 'clk_mt6735_apmixed_remove' [-Wmissing-prototypes]
     112 | int clk_mt6735_apmixed_remove(struct platform_device *pdev)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~
--
>> drivers/clk/mediatek/clk-mt6735-topckgen.c:366:5: warning: no previous prototype for 'clk_mt6735_topckgen_probe' [-Wmissing-prototypes]
     366 | int clk_mt6735_topckgen_probe(struct platform_device *pdev)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/clk/mediatek/clk-mt6735-topckgen.c: In function 'clk_mt6735_topckgen_probe':
   drivers/clk/mediatek/clk-mt6735-topckgen.c:400:38: error: passing argument 1 of 'mtk_clk_register_muxes' from incompatible pointer type [-Werror=incompatible-pointer-types]
     400 |         ret = mtk_clk_register_muxes(topckgen_muxes, ARRAY_SIZE(topckgen_muxes),
         |                                      ^~~~~~~~~~~~~~
         |                                      |
         |                                      const struct mtk_mux *
   In file included from drivers/clk/mediatek/clk-mt6735-topckgen.c:10:
   drivers/clk/mediatek/clk-mux.h:86:43: note: expected 'struct device *' but argument is of type 'const struct mtk_mux *'
      86 | int mtk_clk_register_muxes(struct device *dev,
         |                            ~~~~~~~~~~~~~~~^~~
   In file included from include/linux/cpumask.h:10,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/mutex.h:17,
                    from include/linux/kernfs.h:11,
                    from include/linux/sysfs.h:16,
                    from include/linux/kobject.h:20,
                    from include/linux/of.h:17,
                    from include/linux/clk-provider.h:9,
                    from drivers/clk/mediatek/clk-mt6735-topckgen.c:6:
>> include/linux/kernel.h:55:25: warning: passing argument 2 of 'mtk_clk_register_muxes' makes pointer from integer without a cast [-Wint-conversion]
      55 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                         |
         |                         long unsigned int
   drivers/clk/mediatek/clk-mt6735-topckgen.c:400:54: note: in expansion of macro 'ARRAY_SIZE'
     400 |         ret = mtk_clk_register_muxes(topckgen_muxes, ARRAY_SIZE(topckgen_muxes),
         |                                                      ^~~~~~~~~~
   drivers/clk/mediatek/clk-mux.h:87:50: note: expected 'const struct mtk_mux *' but argument is of type 'long unsigned int'
      87 |                            const struct mtk_mux *muxes,
         |                            ~~~~~~~~~~~~~~~~~~~~~~^~~~~
>> drivers/clk/mediatek/clk-mt6735-topckgen.c:401:47: warning: passing argument 3 of 'mtk_clk_register_muxes' makes integer from pointer without a cast [-Wint-conversion]
     401 |                                      pdev->dev.of_node, &mt6735_topckgen_lock,
         |                                      ~~~~~~~~~^~~~~~~~
         |                                               |
         |                                               struct device_node *
   drivers/clk/mediatek/clk-mux.h:88:32: note: expected 'int' but argument is of type 'struct device_node *'
      88 |                            int num, struct device_node *node,
         |                            ~~~~^~~
   drivers/clk/mediatek/clk-mt6735-topckgen.c:401:57: error: passing argument 4 of 'mtk_clk_register_muxes' from incompatible pointer type [-Werror=incompatible-pointer-types]
     401 |                                      pdev->dev.of_node, &mt6735_topckgen_lock,
         |                                                         ^~~~~~~~~~~~~~~~~~~~~
         |                                                         |
         |                                                         spinlock_t * {aka struct spinlock *}
   drivers/clk/mediatek/clk-mux.h:88:57: note: expected 'struct device_node *' but argument is of type 'spinlock_t *' {aka 'struct spinlock *'}
      88 |                            int num, struct device_node *node,
         |                                     ~~~~~~~~~~~~~~~~~~~~^~~~
   drivers/clk/mediatek/clk-mt6735-topckgen.c:402:38: error: passing argument 5 of 'mtk_clk_register_muxes' from incompatible pointer type [-Werror=incompatible-pointer-types]
     402 |                                      clk_data);
         |                                      ^~~~~~~~
         |                                      |
         |                                      struct clk_hw_onecell_data *
   drivers/clk/mediatek/clk-mux.h:89:40: note: expected 'spinlock_t *' {aka 'struct spinlock *'} but argument is of type 'struct clk_hw_onecell_data *'
      89 |                            spinlock_t *lock,
         |                            ~~~~~~~~~~~~^~~~
   drivers/clk/mediatek/clk-mt6735-topckgen.c:400:15: error: too few arguments to function 'mtk_clk_register_muxes'
     400 |         ret = mtk_clk_register_muxes(topckgen_muxes, ARRAY_SIZE(topckgen_muxes),
         |               ^~~~~~~~~~~~~~~~~~~~~~
   drivers/clk/mediatek/clk-mux.h:86:5: note: declared here
      86 | int mtk_clk_register_muxes(struct device *dev,
         |     ^~~~~~~~~~~~~~~~~~~~~~
   drivers/clk/mediatek/clk-mt6735-topckgen.c: At top level:
>> drivers/clk/mediatek/clk-mt6735-topckgen.c:417:5: warning: no previous prototype for 'clk_mt6735_topckgen_remove' [-Wmissing-prototypes]
     417 | int clk_mt6735_topckgen_remove(struct platform_device *pdev)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/clk_mt6735_apmixed_probe +80 drivers/clk/mediatek/clk-mt6735-apmixedsys.c

    79	
  > 80	int clk_mt6735_apmixed_probe(struct platform_device *pdev)
    81	{
    82		void __iomem *base;
    83		struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
    84		struct clk_hw_onecell_data *clk_data;
    85		int ret;
    86	
    87		base = devm_ioremap_resource(&pdev->dev, res);
    88		if (IS_ERR(base))
    89			return PTR_ERR(base);
    90	
    91		clk_data = mtk_alloc_clk_data(ARRAY_SIZE(apmixedsys_plls));
    92		if (!clk_data)
    93			return -ENOMEM;
    94		platform_set_drvdata(pdev, clk_data);
    95	
    96		ret = mtk_clk_register_plls(pdev->dev.of_node, apmixedsys_plls,
    97					   ARRAY_SIZE(apmixedsys_plls), clk_data);
    98		if (ret) {
    99			dev_err(&pdev->dev, "Failed to register PLLs: %d\n", ret);
   100			return ret;
   101		}
   102	
   103		ret = devm_of_clk_add_hw_provider(&pdev->dev, of_clk_hw_onecell_get,
   104						  clk_data);
   105		if (ret)
   106			dev_err(&pdev->dev,
   107				"Failed to register clock provider: %d\n", ret);
   108	
   109		return ret;
   110	}
   111	
 > 112	int clk_mt6735_apmixed_remove(struct platform_device *pdev)
   113	{
   114		struct clk_hw_onecell_data *clk_data = platform_get_drvdata(pdev);
   115	
   116		mtk_clk_unregister_plls(apmixedsys_plls, ARRAY_SIZE(apmixedsys_plls), clk_data);
   117		mtk_free_clk_data(clk_data);
   118	
   119		return 0;
   120	}
   121	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
