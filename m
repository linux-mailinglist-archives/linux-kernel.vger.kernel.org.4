Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F05C55E7239
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 04:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbiIWC4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 22:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiIWC4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 22:56:19 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79215FF3F1;
        Thu, 22 Sep 2022 19:56:11 -0700 (PDT)
X-UUID: 67f893869e604e499ede6021a9afb2c1-20220923
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=T8K9PTGFkzhxmwzN0pJSKV4qZa3siMOR5xBN4BjE1mk=;
        b=FyFJ7O47/jJtkA+5UAMOv2vS7sWn7uiFaDFfV41SSwgQLBiNO+auXsOEMOca607KkRhRKBrmZZpFl/ja+sawW3eZccf+urR+BTrC8wRvjzivUtDeB0J6b3EPpT76SsYa0eXK+NCvjfgw8Dv21MRJQYAZqv9zvnkqEjjvRY4RUPU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:b33f6f14-29f5-47c4-869f-2f25f8f6fe25,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:45
X-CID-INFO: VERSION:1.1.11,REQID:b33f6f14-29f5-47c4-869f-2f25f8f6fe25,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:45
X-CID-META: VersionHash:39a5ff1,CLOUDID:60a0f3e3-87f9-4bb0-97b6-34957dc0fbbe,B
        ulkID:220923091558LDD4WNGO,BulkQuantity:134,Recheck:0,SF:28|17|19|48|823|8
        24,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil,Bulk:40,QS:nil,BEC:nil,CO
        L:0
X-UUID: 67f893869e604e499ede6021a9afb2c1-20220923
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1298451655; Fri, 23 Sep 2022 10:55:47 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 23 Sep 2022 10:55:45 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 23 Sep 2022 10:55:45 +0800
Message-ID: <696bff4964fb14dfbb37e7d436cbc502bbdbf047.camel@mediatek.com>
Subject: Re: [PATCH] reset: mediatek: Move mediatek system clock reset to
 reset folder
From:   Bo-Chen Chen <rex-bc.chen@mediatek.com>
To:     kernel test robot <lkp@intel.com>, <sboyd@kernel.org>,
        <mturquette@baylibre.com>, <matthias.bgg@gmail.com>,
        <p.zabel@pengutronix.de>
CC:     <kbuild-all@lists.01.org>, <runyang.chen@mediatek.com>,
        <miles.chen@mediatek.com>, <wenst@chromium.org>,
        <angelogioacchino.delregno@collabora.com>,
        <nfraprado@collabora.com>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Fri, 23 Sep 2022 10:55:45 +0800
In-Reply-To: <202209230958.2rV4kEVM-lkp@intel.com>
References: <20220922141107.10203-1-rex-bc.chen@mediatek.com>
         <202209230958.2rV4kEVM-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_CSS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-09-23 at 09:15 +0800, kernel test robot wrote:
> Hi Bo-Chen,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on v6.0-rc6]
> [also build test ERROR on linus/master]
> [cannot apply to clk/clk-next pza/reset/next mbgg-mediatek/for-next
> next-20220921]
> [If your patch is applied to the wrong git tree, kindly drop us a
> note.
> And when submitting patch, we suggest to use '--base' as documented
> in
> 
https://urldefense.com/v3/__https://git-scm.com/docs/git-format-patch*_base_tree_information__;Iw!!CTRNKA9wMg0ARbw!3qsHi0O4Vg0e-tqzlUswcsK-ssSqQiv9heXJFcsj0Jo9fdBpwJPyE8Cm7pi8HlvqkXZ3$
>  ]
> 
> url:    
> https://urldefense.com/v3/__https://github.com/intel-lab-lkp/linux/commits/Bo-Chen-Chen/reset-mediatek-Move-mediatek-system-clock-reset-to-reset-folder/20220922-221303__;!!CTRNKA9wMg0ARbw!3qsHi0O4Vg0e-tqzlUswcsK-ssSqQiv9heXJFcsj0Jo9fdBpwJPyE8Cm7pi8HphCRXGt$
>  
> base:    521a547ced6477c54b4b0cc206000406c221b4d6
> config: sh-allmodconfig (
> https://urldefense.com/v3/__https://download.01.org/0day-ci/archive/20220923/202209230958.2rV4kEVM-lkp@intel.com/config__;!!CTRNKA9wMg0ARbw!3qsHi0O4Vg0e-tqzlUswcsK-ssSqQiv9heXJFcsj0Jo9fdBpwJPyE8Cm7pi8HgGJ4A5i$
>  )
> compiler: sh4-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>         wget 
> https://urldefense.com/v3/__https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross__;!!CTRNKA9wMg0ARbw!3qsHi0O4Vg0e-tqzlUswcsK-ssSqQiv9heXJFcsj0Jo9fdBpwJPyE8Cm7pi8HmjL7iLl$
>   -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # 
> https://urldefense.com/v3/__https://github.com/intel-lab-lkp/linux/commit/69ce72445492a02115b1e7c7527a8a107f48aab8__;!!CTRNKA9wMg0ARbw!3qsHi0O4Vg0e-tqzlUswcsK-ssSqQiv9heXJFcsj0Jo9fdBpwJPyE8Cm7pi8HmwVGCNt$
>  
>         git remote add linux-review 
> https://urldefense.com/v3/__https://github.com/intel-lab-lkp/linux__;!!CTRNKA9wMg0ARbw!3qsHi0O4Vg0e-tqzlUswcsK-ssSqQiv9heXJFcsj0Jo9fdBpwJPyE8Cm7pi8HnCYV8dW$
>  
>         git fetch --no-tags linux-review Bo-Chen-Chen/reset-mediatek-
> Move-mediatek-system-clock-reset-to-reset-folder/20220922-221303
>         git checkout 69ce72445492a02115b1e7c7527a8a107f48aab8
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0
> make.cross W=1 O=build_dir ARCH=sh SHELL=/bin/bash drivers/
> 
> If you fix the issue, kindly add following tag where applicable
> > Reported-by: kernel test robot <lkp@intel.com>
> 
> All error/warnings (new ones prefixed by >>):
> 
>    In file included from include/linux/device/driver.h:21,
>                     from include/linux/device.h:32,
>                     from include/linux/auxiliary_bus.h:11,
>                     from drivers/reset/reset-mediatek-sysclk.c:6:
> > > drivers/reset/reset-mediatek-sysclk.c:499:32: error:
> > > 'mtk_reset_ids' undeclared here (not in a function); did you mean
> > > 'mtk_reset_ops'?
> 
>      499 | MODULE_DEVICE_TABLE(auxiliary, mtk_reset_ids);
>          |                                ^~~~~~~~~~~~~
>    include/linux/module.h:244:15: note: in definition of macro
> 'MODULE_DEVICE_TABLE'
>      244 | extern typeof(name)
> __mod_##type##__##name##_device_table               \
>          |               ^~~~
> > > drivers/reset/reset-mediatek-sysclk.c:539:5: warning: no previous
> > > prototype for 'mtk_reset_init_with_node' [-Wmissing-prototypes]
> 
>      539 | int mtk_reset_init_with_node(struct device_node *np, const
> char *name)
>          |     ^~~~~~~~~~~~~~~~~~~~~~~~
> > > drivers/reset/reset-mediatek-sysclk.c:550:6: warning: no previous
> > > prototype for 'mtk_rst_remove_with_node' [-Wmissing-prototypes]
> 
>      550 | void mtk_rst_remove_with_node(struct device_node *np,
> const char *name)
>          |      ^~~~~~~~~~~~~~~~~~~~~~~~
> > > include/linux/module.h:244:21: error:
> > > '__mod_auxiliary__mtk_reset_ids_device_table' aliased to
> > > undefined symbol 'mtk_reset_ids'
> 
>      244 | extern typeof(name)
> __mod_##type##__##name##_device_table               \
>          |                     ^~~~~~
>    drivers/reset/reset-mediatek-sysclk.c:499:1: note: in expansion of
> macro 'MODULE_DEVICE_TABLE'
>      499 | MODULE_DEVICE_TABLE(auxiliary, mtk_reset_ids);
>          | ^~~~~~~~~~~~~~~~~~~
> 
> 
> vim +499 drivers/reset/reset-mediatek-sysclk.c
> 
>    402	
>    403	static struct auxiliary_device_id
> mtk_sysclk_reset_ids[] = {
>    404		{
>    405			.name = "clk_mt2701_eth.mt2701-eth-
> rst",
>    406			.driver_data = MTK_RST_ID_MT2701_ETH,
>    407		},
>    408		{
>    409			.name = "clk_mt2701_g3d.mt2701-g3d-
> rst",
>    410			.driver_data = MTK_RST_ID_MT2701_G3D,
>    411		},
>    412		{
>    413			.name = "clk_mt2701_hif.mt2701-hif-
> rst",
>    414			.driver_data = MTK_RST_ID_MT2701_HIF,
>    415		},
>    416		{
>    417			.name = "clk_mt2701.mt2701-infrasys-
> rst",
>    418			.driver_data =
> MTK_RST_ID_MT2701_INFRASYS,
>    419		},
>    420		{
>    421			.name = "clk_mt2701.mt2701-pericfg-
> rst",
>    422			.driver_data =
> MTK_RST_ID_MT2701_PERICFG,
>    423		},
>    424		{
>    425			.name = "clk_mt2712.mt2712-infra-rst",
>    426			.driver_data = MTK_RST_ID_MT2712_INFRA,
>    427		},
>    428		{
>    429			.name = "clk_mt2712.mt2712-peri-rst",
>    430			.driver_data = MTK_RST_ID_MT2712_PERI,
>    431		},
>    432		{
>    433			.name = "clk_mt7622_eth.mt7622-eth-
> rst",
>    434			.driver_data = MTK_RST_ID_MT7622_ETH,
>    435		},
>    436		{
>    437			.name = "clk_mt7622_hif.mt7622-usb-
> rst",
>    438			.driver_data =
> MTK_RST_ID_MT7622_SSUSBSYS,
>    439		},
>    440		{
>    441			.name = "clk_mt7622_hif.mt7622-pcie-
> rst",
>    442			.driver_data =
> MTK_RST_ID_MT7622_PCIESYS,
>    443		},
>    444		{
>    445			.name = "clk_mt7622.mt7622-infrasys-
> rst",
>    446			.driver_data =
> MTK_RST_ID_MT7622_INFRASYS,
>    447		},
>    448		{
>    449			.name = "clk_mt7622.mt7622-pericfg-
> rst",
>    450			.driver_data =
> MTK_RST_ID_MT7622_PERICFG,
>    451		},
>    452		{
>    453			.name = "clk_mt7629_eth.mt7629-ethsys-
> rst",
>    454			.driver_data =
> MTK_RST_ID_MT7629_ETHSYS,
>    455		},
>    456		{
>    457			.name = "clk_mt7629_hif.mt7629-usb-
> rst",
>    458			.driver_data =
> MTK_RST_ID_MT7629_SSUSBSYS,
>    459		},
>    460		{
>    461			.name = "clk_mt7629_hif.mt7629-pcie-
> rst",
>    462			.driver_data =
> MTK_RST_ID_MT7629_PCIESYS,
>    463		},
>    464		{
>    465			.name = "clk_mt8135.mt8135-infrasys-
> rst",
>    466			.driver_data =
> MTK_RST_ID_MT8135_INFRASYS,
>    467		},
>    468		{
>    469			.name = "clk_mt8135.mt8135-pericfg-
> rst",
>    470			.driver_data =
> MTK_RST_ID_MT8135_PERICFG,
>    471		},
>    472		{
>    473			.name = "clk_mt8173.mt8173-infracfg-
> rst",
>    474			.driver_data =
> MTK_RST_ID_MT8173_INFRACFG,
>    475		},
>    476		{
>    477			.name = "clk_mt8173.mt8173-pericfg-
> rst",
>    478			.driver_data =
> MTK_RST_ID_MT8173_PERICFG,
>    479		},
>    480		{
>    481			.name = "clk_mt8183.mt8183-infra-rst",
>    482			.driver_data = MTK_RST_ID_MT8183_INFRA,
>    483		},
>    484		{
>    485			.name = "clk_mtk.mt8186-infra-ao-rst",
>    486			.driver_data =
> MTK_RST_ID_MT8186_INFRA_AO,
>    487		},
>    488		{
>    489			.name = "clk_mt8192.mt8192-infra-rst",
>    490			.driver_data = MTK_RST_ID_MT8192_INFRA,
>    491		},
>    492		{
>    493			.name = "clk_mtk.mt8195-infra-ao-rst",
>    494			.driver_data =
> MTK_RST_ID_MT8195_INFRA_AO,
>    495		},
>    496		{
>    497		},
>    498	};
>  > 499	MODULE_DEVICE_TABLE(auxiliary, mtk_reset_ids);
>    500	
>    501	/* reset data */
>    502	static struct mtk_clk_rst_data clk_rst_data[] = {
>    503		[MTK_RST_ID_MT2701_ETH]		= { .desc =
> &mt2701_eth_rst_desc, },
>    504		[MTK_RST_ID_MT2701_G3D]		= { .desc =
> &mt2701_g3d_clk_rst_desc, },
>    505		[MTK_RST_ID_MT2701_HIF]		= { .desc =
> &mt2701_eth_rst_desc, },
>    506		[MTK_RST_ID_MT2701_INFRASYS]	= { .desc =
> &mt2701_infrasys_clk_rst_desc, },
>    507		[MTK_RST_ID_MT2701_PERICFG]	= { .desc =
> &mt2701_pericfg_clk_rst_desc, },
>    508		[MTK_RST_ID_MT2712_INFRA]	= { .desc =
> &mt2701_infrasys_clk_rst_desc, },
>    509		[MTK_RST_ID_MT2712_PERI]	= { .desc =
> &mt2701_pericfg_clk_rst_desc, },
>    510		[MTK_RST_ID_MT7622_ETH]		= { .desc =
> &mt2701_eth_rst_desc, },
>    511		[MTK_RST_ID_MT7622_SSUSBSYS]	= { .desc =
> &mt2701_eth_rst_desc, },
>    512		[MTK_RST_ID_MT7622_PCIESYS]	= { .desc =
> &mt2701_eth_rst_desc, },
>    513		[MTK_RST_ID_MT7622_INFRASYS]	= { .desc =
> &mt7622_infrasys_clk_rst_desc, },
>    514		[MTK_RST_ID_MT7622_PERICFG]	= { .desc =
> &mt2701_pericfg_clk_rst_desc, },
>    515		[MTK_RST_ID_MT7629_ETHSYS]	= { .desc =
> &mt2701_eth_rst_desc, },
>    516		[MTK_RST_ID_MT7629_SSUSBSYS]	= { .desc =
> &mt2701_eth_rst_desc, },
>    517		[MTK_RST_ID_MT7629_PCIESYS]	= { .desc =
> &mt2701_eth_rst_desc, },
>    518		[MTK_RST_ID_MT8135_INFRASYS]	= { .desc =
> &mt2701_infrasys_clk_rst_desc, },
>    519		[MTK_RST_ID_MT8135_PERICFG]	= { .desc =
> &mt2701_pericfg_clk_rst_desc, },
>    520		[MTK_RST_ID_MT8173_INFRACFG]	= { .desc =
> &mt2701_infrasys_clk_rst_desc, },
>    521		[MTK_RST_ID_MT8173_PERICFG]	= { .desc =
> &mt2701_pericfg_clk_rst_desc, },
>    522		[MTK_RST_ID_MT8183_INFRA]	= { .desc =
> &mt8183_rst_desc, },
>    523		[MTK_RST_ID_MT8186_INFRA_AO]	= { .desc =
> &mt8186_rst_desc, },
>    524		[MTK_RST_ID_MT8192_INFRA]	= { .desc =
> &mt8192_rst_desc, },
>    525		[MTK_RST_ID_MT8195_INFRA_AO]	= { .desc =
> &mt8195_rst_desc, },
>    526		{},
>    527	};
>    528	
>    529	static struct mtk_clk_rst_data *find_rst_data(const
> char *name)
>    530	{
>    531		int i;
>    532	
>    533		for (i = 0; i <
> ARRAY_SIZE(mtk_sysclk_reset_ids); i++)
>    534			if (mtk_sysclk_reset_ids[i].name ==
> name)
>    535				return
> &clk_rst_data[mtk_sysclk_reset_ids[i].driver_data];
>    536		return NULL;
>    537	}
>    538	
>  > 539	int mtk_reset_init_with_node(struct device_node *np,
> const char *name)
>    540	{
>    541		struct mtk_clk_rst_data *data =
> find_rst_data(name);
>    542	
>    543		if (!np || !data)
>    544			return -EINVAL;
>    545	
>    546		return register_rst_ctrl_with_node(np, data);
>    547	}
>    548	EXPORT_SYMBOL_GPL(mtk_reset_init_with_node);
>    549	
>  > 550	void mtk_rst_remove_with_node(struct device_node *np,
> const char *name)
>    551	{
>    552		struct mtk_clk_rst_data *data =
> find_rst_data(name);
>    553	
>    554		if (!np || !data)
>    555			return;
>    556	
>    557		reset_controller_unregister(&data->rcdev);
>    558	}
>    559	EXPORT_SYMBOL_GPL(mtk_rst_remove_with_node);
>    560	
> 

Hello,

Thanks for the feedback.
I will fix this error and add include/linux/reset/reset-mediatek-
sysclk.h to fix this warning.

Also, I will try to base on linux-next to resolve these apply conflict.

BRs,
Bo-Chen

