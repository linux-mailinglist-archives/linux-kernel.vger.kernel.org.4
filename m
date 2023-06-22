Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A514B73952C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 04:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbjFVCFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 22:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjFVCFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 22:05:34 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 511E61FE0;
        Wed, 21 Jun 2023 19:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687399530; x=1718935530;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Tqwmf7UCG/Oox40h1Vsl9C4SJhX8muGiwDzjdWU/aV8=;
  b=BPV5JzH93YWBBi2EqQ8n72f+MJuPG58NlClaGUPHbaxk0Yu8k/LbeAi6
   EMikNTpkGDCWSFSUlk/OsWIpf+o/A6hf+bVjTLK99iGYlOWDXNn2YVML9
   8DAFJyUNo6wWdVmAD/wMRQXSclQ2+wVNWjNx5lJW7ONxlkBkNvaNW3T+M
   h7V1whTG5iWA+dR6PpguSEM6syAn/q1Ym0xBbIQxT8rwPMzU2sFhwD/zg
   MsrZBj+Ia5rk8SfBeM/EuOJoWBHgUXT1dsfl0t0Vsk+9YrPzZ8jRKTz+B
   1KL69fGaw78vSrlSGBmucjCAbypQsMUHftigp2T/foyQbFgMfyylo1zOq
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="424031078"
X-IronPort-AV: E=Sophos;i="6.00,262,1681196400"; 
   d="scan'208";a="424031078"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 19:05:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="714723808"
X-IronPort-AV: E=Sophos;i="6.00,262,1681196400"; 
   d="scan'208";a="714723808"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 21 Jun 2023 19:05:25 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qC9hM-0007FT-2g;
        Thu, 22 Jun 2023 02:05:24 +0000
Date:   Thu, 22 Jun 2023 10:05:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Markus Schneider-Pargmann <msp@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Fabien Parent <parent.f@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Markus Schneider-Pargmann <msp@baylibre.com>
Subject: Re: [PATCH v5 8/8] soc: mediatek: pm-domains: Add support for MT8365
Message-ID: <202306220952.WMdPoLzE-lkp@intel.com>
References: <20230619085344.2885311-9-msp@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230619085344.2885311-9-msp@baylibre.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Markus,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on krzk-dt/for-next linus/master v6.4-rc7 next-20230621]
[cannot apply to mbgg-mediatek/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Markus-Schneider-Pargmann/dt-bindings-power-Add-MT8365-power-domains/20230619-165759
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20230619085344.2885311-9-msp%40baylibre.com
patch subject: [PATCH v5 8/8] soc: mediatek: pm-domains: Add support for MT8365
config: arm64-randconfig-r011-20230621 (https://download.01.org/0day-ci/archive/20230622/202306220952.WMdPoLzE-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20230622/202306220952.WMdPoLzE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306220952.WMdPoLzE-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/soc/mediatek/mtk-pm-domains.c:27:
>> drivers/soc/mediatek/mt8365-pm-domains.h:69:42: warning: implicit conversion from 'unsigned long' to 'u8' (aka 'unsigned char') changes value from 384 to 128 [-Wconstant-conversion]
      69 |                 .caps = MTK_SCPD_STRICT_BUS_PROTECTION | MTK_SCPD_HAS_INFRA_NAO,
         |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~
   1 warning generated.


vim +69 drivers/soc/mediatek/mt8365-pm-domains.h

     8	
     9	/*
    10	 * MT8365 power domain support
    11	 */
    12	
    13	#define MT8365_BUS_PROT_INFRA_WR_TOPAXI(_mask)				\
    14			BUS_PROT_INFRA_WR(_mask,				\
    15					  MT8365_INFRA_TOPAXI_PROTECTEN_SET,	\
    16					  MT8365_INFRA_TOPAXI_PROTECTEN_CLR,	\
    17					  MT8365_INFRA_TOPAXI_PROTECTEN_STA1)
    18	
    19	#define MT8365_BUS_PROT_INFRA_WR_TOPAXI_1(_mask)			\
    20			BUS_PROT_INFRA_WR(_mask,				\
    21					  MT8365_INFRA_TOPAXI_PROTECTEN_1_SET,	\
    22					  MT8365_INFRA_TOPAXI_PROTECTEN_1_CLR,	\
    23					  MT8365_INFRA_TOPAXI_PROTECTEN_1_STA1)
    24	
    25	#define MT8365_BUS_PROT_SMI_WR_CLAMP_EN_PORT(port)			\
    26			BUS_PROT_SMI_WR(BIT(port),				\
    27					MT8365_SMI_COMMON_CLAMP_EN_SET,		\
    28					MT8365_SMI_COMMON_CLAMP_EN_CLR,		\
    29					MT8365_SMI_COMMON_CLAMP_EN)
    30	
    31	#define MT8365_BUS_PROT_WAY_EN(_set_mask, _set, _sta_mask, _sta)	\
    32			_BUS_PROT(_set_mask, _set, _set, _sta_mask, _sta,	\
    33				  BUS_PROT_COMPONENT_INFRA |			\
    34				  BUS_PROT_STA_COMPONENT_INFRA_NAO |		\
    35				  BUS_PROT_INVERTED |				\
    36				  BUS_PROT_REG_UPDATE)
    37	
    38	static const struct scpsys_domain_data scpsys_domain_data_mt8365[] = {
    39		[MT8365_POWER_DOMAIN_MM] = {
    40			.name = "mm",
    41			.sta_mask = PWR_STATUS_DISP,
    42			.ctl_offs = 0x30c,
    43			.pwr_sta_offs = 0x0180,
    44			.pwr_sta2nd_offs = 0x0184,
    45			.sram_pdn_bits = GENMASK(8, 8),
    46			.sram_pdn_ack_bits = GENMASK(12, 12),
    47			.bp_cfg = {
    48				MT8365_BUS_PROT_INFRA_WR_TOPAXI_1(
    49					MT8365_INFRA_TOPAXI_PROTECTEN_1_MM2INFRA_AXI_GALS_MST_0 |
    50					MT8365_INFRA_TOPAXI_PROTECTEN_1_MM2INFRA_AXI_GALS_MST_1),
    51				MT8365_BUS_PROT_INFRA_WR_TOPAXI(
    52					MT8365_INFRA_TOPAXI_PROTECTEN_MM_M0 |
    53					MT8365_INFRA_TOPAXI_PROTECTEN_MDMCU_M1 |
    54					MT8365_INFRA_TOPAXI_PROTECTEN_MM2INFRA_AXI_GALS_SLV_0 |
    55					MT8365_INFRA_TOPAXI_PROTECTEN_MM2INFRA_AXI_GALS_SLV_1),
    56				MT8365_BUS_PROT_WAY_EN(
    57					MT8365_INFRA_TOPAXI_SI0_WAY_EN_MMAPB_S,
    58					MT8365_INFRA_TOPAXI_SI0_CTL,
    59					MT8365_INFRA_NAO_TOPAXI_SI0_CTRL_UPDATED,
    60					MT8365_INFRA_NAO_TOPAXI_SI0_STA),
    61				MT8365_BUS_PROT_WAY_EN(
    62					MT8365_INFRA_TOPAXI_SI2_WAY_EN_PERI_M1,
    63					MT8365_INFRA_TOPAXI_SI2_CTL,
    64					MT8365_INFRA_NAO_TOPAXI_SI2_CTRL_UPDATED,
    65					MT8365_INFRA_NAO_TOPAXI_SI2_STA),
    66				MT8365_BUS_PROT_INFRA_WR_TOPAXI(
    67					MT8365_INFRA_TOPAXI_PROTECTEN_MMAPB_S),
    68			},
  > 69			.caps = MTK_SCPD_STRICT_BUS_PROTECTION | MTK_SCPD_HAS_INFRA_NAO,
    70		},
    71		[MT8365_POWER_DOMAIN_VENC] = {
    72			.name = "venc",
    73			.sta_mask = PWR_STATUS_VENC,
    74			.ctl_offs = 0x0304,
    75			.pwr_sta_offs = 0x0180,
    76			.pwr_sta2nd_offs = 0x0184,
    77			.sram_pdn_bits = GENMASK(8, 8),
    78			.sram_pdn_ack_bits = GENMASK(12, 12),
    79			.bp_cfg = {
    80				MT8365_BUS_PROT_SMI_WR_CLAMP_EN_PORT(1),
    81			},
    82		},
    83		[MT8365_POWER_DOMAIN_AUDIO] = {
    84			.name = "audio",
    85			.sta_mask = PWR_STATUS_AUDIO,
    86			.ctl_offs = 0x0314,
    87			.pwr_sta_offs = 0x0180,
    88			.pwr_sta2nd_offs = 0x0184,
    89			.sram_pdn_bits = GENMASK(12, 8),
    90			.sram_pdn_ack_bits = GENMASK(17, 13),
    91			.bp_cfg = {
    92				MT8365_BUS_PROT_INFRA_WR_TOPAXI_1(
    93					MT8365_INFRA_TOPAXI_PROTECTEN_1_PWRDNREQ_MP1_L2C_AFIFO |
    94					MT8365_INFRA_TOPAXI_PROTECTEN_1_AUDIO_BUS_AUDIO_M),
    95			},
    96			.caps = MTK_SCPD_ACTIVE_WAKEUP,
    97		},
    98		[MT8365_POWER_DOMAIN_CONN] = {
    99			.name = "conn",
   100			.sta_mask = PWR_STATUS_CONN,
   101			.ctl_offs = 0x032c,
   102			.pwr_sta_offs = 0x0180,
   103			.pwr_sta2nd_offs = 0x0184,
   104			.sram_pdn_bits = 0,
   105			.sram_pdn_ack_bits = 0,
   106			.bp_cfg = {
   107				MT8365_BUS_PROT_INFRA_WR_TOPAXI(
   108					MT8365_INFRA_TOPAXI_PROTECTEN_AP2CONN_AHB),
   109				MT8365_BUS_PROT_INFRA_WR_TOPAXI_1(
   110					MT8365_INFRA_TOPAXI_PROTECTEN_1_CONN2INFRA_AXI_GALS_MST),
   111				MT8365_BUS_PROT_INFRA_WR_TOPAXI(
   112					MT8365_INFRA_TOPAXI_PROTECTEN_CONN2INFRA_AHB),
   113				MT8365_BUS_PROT_INFRA_WR_TOPAXI_1(
   114					MT8365_INFRA_TOPAXI_PROTECTEN_1_INFRA2CONN_AHB_GALS_SLV),
   115			},
   116			.caps = MTK_SCPD_ACTIVE_WAKEUP | MTK_SCPD_KEEP_DEFAULT_OFF,
   117		},
   118		[MT8365_POWER_DOMAIN_MFG] = {
   119			.name = "mfg",
   120			.sta_mask = PWR_STATUS_MFG,
   121			.ctl_offs = 0x0338,
   122			.pwr_sta_offs = 0x0180,
   123			.pwr_sta2nd_offs = 0x0184,
   124			.sram_pdn_bits = GENMASK(9, 8),
   125			.sram_pdn_ack_bits = GENMASK(13, 12),
   126			.bp_cfg = {
   127				MT8365_BUS_PROT_INFRA_WR_TOPAXI(BIT(25)),
   128				MT8365_BUS_PROT_INFRA_WR_TOPAXI(
   129					MT8365_INFRA_TOPAXI_PROTECTEN_MFG_M0 |
   130					MT8365_INFRA_TOPAXI_PROTECTEN_INFRA2MFG),
   131			},
   132		},
   133		[MT8365_POWER_DOMAIN_CAM] = {
   134			.name = "cam",
   135			.sta_mask = BIT(25),
   136			.ctl_offs = 0x0344,
   137			.pwr_sta_offs = 0x0180,
   138			.pwr_sta2nd_offs = 0x0184,
   139			.sram_pdn_bits = GENMASK(9, 8),
   140			.sram_pdn_ack_bits = GENMASK(13, 12),
   141			.bp_cfg = {
   142				MT8365_BUS_PROT_INFRA_WR_TOPAXI_1(
   143					MT8365_INFRA_TOPAXI_PROTECTEN_1_CAM2MM_AXI_GALS_MST),
   144				MT8365_BUS_PROT_SMI_WR_CLAMP_EN_PORT(2),
   145			},
   146		},
   147		[MT8365_POWER_DOMAIN_VDEC] = {
   148			.name = "vdec",
   149			.sta_mask = BIT(31),
   150			.ctl_offs = 0x0370,
   151			.pwr_sta_offs = 0x0180,
   152			.pwr_sta2nd_offs = 0x0184,
   153			.sram_pdn_bits = GENMASK(8, 8),
   154			.sram_pdn_ack_bits = GENMASK(12, 12),
   155			.bp_cfg = {
   156				MT8365_BUS_PROT_SMI_WR_CLAMP_EN_PORT(3),
   157			},
   158		},
   159		[MT8365_POWER_DOMAIN_APU] = {
   160			.name = "apu",
   161			.sta_mask = BIT(16),
   162			.ctl_offs = 0x0378,
   163			.pwr_sta_offs = 0x0180,
   164			.pwr_sta2nd_offs = 0x0184,
   165			.sram_pdn_bits = GENMASK(14, 8),
   166			.sram_pdn_ack_bits = GENMASK(21, 15),
   167			.bp_cfg = {
   168				MT8365_BUS_PROT_INFRA_WR_TOPAXI_1(
   169					MT8365_INFRA_TOPAXI_PROTECTEN_1_APU2AP |
   170					MT8365_INFRA_TOPAXI_PROTECTEN_1_APU_CBIP_GALS_MST),
   171				MT8365_BUS_PROT_SMI_WR_CLAMP_EN_PORT(4),
   172			},
   173		},
   174		[MT8365_POWER_DOMAIN_DSP] = {
   175			.name = "dsp",
   176			.sta_mask = BIT(17),
   177			.ctl_offs = 0x037C,
   178			.pwr_sta_offs = 0x0180,
   179			.pwr_sta2nd_offs = 0x0184,
   180			.sram_pdn_bits = GENMASK(11, 8),
   181			.sram_pdn_ack_bits = GENMASK(15, 12),
   182			.bp_cfg = {
   183				MT8365_BUS_PROT_INFRA_WR_TOPAXI_1(
   184					MT8365_INFRA_TOPAXI_PROTECTEN_1_PWRDNREQ_INFRA_GALS_ADB |
   185					MT8365_INFRA_TOPAXI_PROTECTEN_1_AUDIO_BUS_DSP_M |
   186					MT8365_INFRA_TOPAXI_PROTECTEN_1_AUDIO_BUS_DSP_S),
   187			},
   188			.caps = MTK_SCPD_ACTIVE_WAKEUP,
   189		},
   190	};
   191	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
