Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 895C15BB557
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 03:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiIQBaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 21:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiIQB37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 21:29:59 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B65022B31;
        Fri, 16 Sep 2022 18:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663378195; x=1694914195;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=kG74+KSsX0ddZ8yiGjH0vTpDXWEeAKITz9bGB2Kmv30=;
  b=TlM/SOwkFWtAyhCpJ5b0lTwMsx0m6L4AcX4HdDSpy9ZJdQqV8qjjzvH6
   mO9jA26juC9kaYiU3P2XxEnfINM8VpfgbPaDfD7ZJ8XhKcX/idv6oMI26
   jh8Xq+UNN07h7iRMgAEnH6Y2X6IQm4m1a+bt2+s1sHKqHFUL8mxPt5vl2
   neWOOHj5DmrmUKlCbJ0ZZB4Bk480jdR00M1gYcQzhvhwuVTqsKNd+T+/d
   q2VHFPfSBV3a3Cg3qP3X7Hrn48fwg3cq7ecxNgAK9TA5CYq9vdK+h8yOd
   IYyy50cyaxijsQukUHeJj3aTPrRGgv8EjPpi5RtrktU704o2EEFPF0zcZ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10472"; a="282137757"
X-IronPort-AV: E=Sophos;i="5.93,321,1654585200"; 
   d="scan'208";a="282137757"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 18:29:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,321,1654585200"; 
   d="scan'208";a="743528382"
Received: from lkp-server02.sh.intel.com (HELO 41300c7200ea) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 16 Sep 2022 18:29:49 -0700
Received: from kbuild by 41300c7200ea with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oZMeT-0002Ks-0a;
        Sat, 17 Sep 2022 01:29:49 +0000
Date:   Sat, 17 Sep 2022 09:28:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marco Felsch <m.felsch@pengutronix.de>, mchehab@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        kishon@ti.com, vkoul@kernel.org, sakari.ailus@linux.intel.com,
        hverkuil@xs4all.nl, jacopo@jmondi.org,
        laurent.pinchart+renesas@ideasonboard.com
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        kieran.bingham+renesas@ideasonboard.com,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        kernel@pengutronix.de
Subject: Re: [PATCH v2 4/4] media: tc358746: add Toshiba TC358746 Parallel to
 CSI-2 bridge driver
Message-ID: <202209170957.eHfxERTT-lkp@intel.com>
References: <20220916134535.128131-5-m.felsch@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220916134535.128131-5-m.felsch@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marco,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on media-tree/master]
[also build test WARNING on robh/for-next linus/master v6.0-rc5 next-20220916]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Marco-Felsch/Add-support-for-Toshiba-TC358746/20220916-214808
base:   git://linuxtv.org/media_tree.git master
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220917/202209170957.eHfxERTT-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/8ce1bdf646dd24a8117ed47f47e086ef7011c385
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Marco-Felsch/Add-support-for-Toshiba-TC358746/20220916-214808
        git checkout 8ce1bdf646dd24a8117ed47f47e086ef7011c385
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/media/i2c/ drivers/net/wireless/ath/ath11k/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/media/i2c/tc358746.c:986:1: warning: no previous prototype for function 'tc358746_g_register' [-Wmissing-prototypes]
   tc358746_g_register(struct v4l2_subdev *sd, struct v4l2_dbg_register *reg)
   ^
   drivers/media/i2c/tc358746.c:985:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int __maybe_unused
   ^
   static 
>> drivers/media/i2c/tc358746.c:1007:1: warning: no previous prototype for function 'tc358746_s_register' [-Wmissing-prototypes]
   tc358746_s_register(struct v4l2_subdev *sd, const struct v4l2_dbg_register *reg)
   ^
   drivers/media/i2c/tc358746.c:1006:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int __maybe_unused
   ^
   static 
>> drivers/media/i2c/tc358746.c:1178:15: warning: no previous prototype for function 'tc358746_recalc_rate' [-Wmissing-prototypes]
   unsigned long tc358746_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
                 ^
   drivers/media/i2c/tc358746.c:1178:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   unsigned long tc358746_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
   ^
   static 
   3 warnings generated.


vim +/tc358746_g_register +986 drivers/media/i2c/tc358746.c

   984	
   985	int __maybe_unused
 > 986	tc358746_g_register(struct v4l2_subdev *sd, struct v4l2_dbg_register *reg)
   987	{
   988		struct tc358746 *tc358746 = to_tc358746(sd);
   989	
   990		/* 32-bit registers starting from CLW_DPHYCONTTX */
   991		reg->size = reg->reg < CLW_DPHYCONTTX_REG ? 2 : 4;
   992	
   993		if (pm_runtime_resume_and_get(sd->dev)) {
   994			dev_err(sd->dev, "Failed to resume the device\n");
   995			return 0;
   996		}
   997	
   998		tc358746_read(tc358746, reg->reg, (u32 *)&reg->val);
   999	
  1000		pm_runtime_mark_last_busy(sd->dev);
  1001		pm_runtime_put_sync_autosuspend(sd->dev);
  1002	
  1003		return 0;
  1004	}
  1005	
  1006	int __maybe_unused
> 1007	tc358746_s_register(struct v4l2_subdev *sd, const struct v4l2_dbg_register *reg)
  1008	{
  1009		struct tc358746 *tc358746 = to_tc358746(sd);
  1010	
  1011		if (pm_runtime_resume_and_get(sd->dev)) {
  1012			dev_err(sd->dev, "Failed to resume the device\n");
  1013			return 0;
  1014		}
  1015	
  1016		tc358746_write(tc358746, (u32)reg->reg, (u32)reg->val);
  1017	
  1018		pm_runtime_mark_last_busy(sd->dev);
  1019		pm_runtime_put_sync_autosuspend(sd->dev);
  1020	
  1021		return 0;
  1022	}
  1023	
  1024	static const struct v4l2_subdev_core_ops tc358746_core_ops = {
  1025	#ifdef CONFIG_VIDEO_ADV_DEBUG
  1026		.g_register = tc358746_g_register,
  1027		.s_register = tc358746_s_register,
  1028	#endif
  1029	};
  1030	
  1031	static const struct v4l2_subdev_video_ops tc358746_video_ops = {
  1032		.s_stream = tc358746_s_stream,
  1033	};
  1034	
  1035	static const struct v4l2_subdev_pad_ops tc358746_pad_ops = {
  1036		.init_cfg = tc358746_init_cfg,
  1037		.enum_mbus_code = tc358746_enum_mbus_code,
  1038		.set_fmt = tc358746_set_fmt,
  1039		.get_fmt = v4l2_subdev_get_fmt,
  1040		.link_validate = tc358746_link_validate,
  1041		.get_mbus_config = tc358746_get_mbus_config,
  1042	};
  1043	
  1044	static const struct v4l2_subdev_ops tc358746_ops = {
  1045		.core = &tc358746_core_ops,
  1046		.video = &tc358746_video_ops,
  1047		.pad = &tc358746_pad_ops,
  1048	};
  1049	
  1050	static const struct media_entity_operations tc358746_entity_ops = {
  1051		.get_fwnode_pad = v4l2_subdev_get_fwnode_pad_1_to_1,
  1052		.link_validate = v4l2_subdev_link_validate,
  1053	};
  1054	
  1055	static int tc358746_mclk_enable(struct clk_hw *hw)
  1056	{
  1057		struct tc358746 *tc358746 = clk_hw_to_tc358746(hw);
  1058		unsigned int div;
  1059		u32 val;
  1060		int err;
  1061	
  1062		div = tc358746->mclk_postdiv / 2;
  1063		val = MCLK_HIGH(div - 1) | MCLK_LOW(div - 1);
  1064		dev_dbg(tc358746->sd.dev, "MCLKCTL: %u (0x%x)\n", val, val);
  1065		err = tc358746_write(tc358746, MCLKCTL_REG, val);
  1066		if (err)
  1067			return err;
  1068	
  1069		if (tc358746->mclk_prediv == 8)
  1070			val = MCLKDIV(MCLKDIV_8);
  1071		else if (tc358746->mclk_prediv == 4)
  1072			val = MCLKDIV(MCLKDIV_4);
  1073		else
  1074			val = MCLKDIV(MCLKDIV_2);
  1075	
  1076		dev_dbg(tc358746->sd.dev, "CLKCTL[MCLKDIV]: %u (0x%x)\n", val, val);
  1077		return tc358746_update_bits(tc358746, CLKCTL_REG, MCLKDIV_MASK, val);
  1078	}
  1079	
  1080	static void tc358746_mclk_disable(struct clk_hw *hw)
  1081	{
  1082		struct tc358746 *tc358746 = clk_hw_to_tc358746(hw);
  1083	
  1084		tc358746_write(tc358746, MCLKCTL_REG, 0);
  1085	}
  1086	
  1087	static long
  1088	tc358746_find_mclk_settings(struct tc358746 *tc358746, unsigned long mclk_rate)
  1089	{
  1090		unsigned long pll_rate = tc358746->pll_rate;
  1091		const unsigned char prediv[] = { 2, 4, 8 };
  1092		unsigned int mclk_prediv, mclk_postdiv;
  1093		struct device *dev = tc358746->sd.dev;
  1094		unsigned int postdiv, mclkdiv;
  1095		unsigned long best_mclk_rate;
  1096		unsigned int i;
  1097	
  1098		/*
  1099		 *                          MCLK-Div
  1100		 *           -------------------´`---------------------
  1101		 *          ´                                          `
  1102		 *         +-------------+     +------------------------+
  1103		 *         | MCLK-PreDiv |     |       MCLK-PostDiv     |
  1104		 * PLL --> |   (2/4/8)   | --> | (mclk_low + mclk_high) | --> MCLK
  1105		 *         +-------------+     +------------------------+
  1106		 *
  1107		 * The register value of mclk_low/high is mclk_low/high+1, i.e.:
  1108		 *   mclk_low/high = 1   --> 2 MCLK-Ref Counts
  1109		 *   mclk_low/high = 255 --> 256 MCLK-Ref Counts == max.
  1110		 * If mclk_low and mclk_high are 0 then MCLK is disabled.
  1111		 *
  1112		 * Keep it simple and support 50/50 duty cycles only for now,
  1113		 * so the calc will be:
  1114		 *
  1115		 *   MCLK = PLL / (MCLK-PreDiv * 2 * MCLK-PostDiv)
  1116		 */
  1117	
  1118		if (mclk_rate == tc358746->mclk_rate)
  1119			return mclk_rate;
  1120	
  1121		/* Highest possible rate */
  1122		mclkdiv = pll_rate / mclk_rate;
  1123		if (mclkdiv <= 8) {
  1124			mclk_prediv = 2;
  1125			mclk_postdiv = 4;
  1126			best_mclk_rate = pll_rate / (2 * 4);
  1127			goto out;
  1128		}
  1129	
  1130		/* First check the prediv */
  1131		for (i = 0; i < ARRAY_SIZE(prediv); i++) {
  1132			postdiv = mclkdiv / prediv[i];
  1133	
  1134			if (postdiv % 2)
  1135				continue;
  1136	
  1137			if (postdiv >= 4 && postdiv <= 512) {
  1138				mclk_prediv = prediv[i];
  1139				mclk_postdiv = postdiv;
  1140				best_mclk_rate = pll_rate / (prediv[i] * postdiv);
  1141				goto out;
  1142			}
  1143		}
  1144	
  1145		/* No suitable prediv found, so try to adjust the postdiv */
  1146		for (postdiv = 4; postdiv <= 512; postdiv += 2) {
  1147			unsigned int pre;
  1148	
  1149			pre = mclkdiv / postdiv;
  1150			if (pre == 2 || pre == 4 || pre == 8) {
  1151				mclk_prediv = pre;
  1152				mclk_postdiv = postdiv;
  1153				best_mclk_rate = pll_rate / (pre * postdiv);
  1154				goto out;
  1155			}
  1156		}
  1157	
  1158		/* The MCLK <-> PLL gap is to high -> use largest possible div */
  1159		mclk_prediv = 8;
  1160		mclk_postdiv = 512;
  1161		best_mclk_rate = pll_rate / (8 * 512);
  1162	
  1163	out:
  1164		tc358746->mclk_prediv = mclk_prediv;
  1165		tc358746->mclk_postdiv = mclk_postdiv;
  1166		tc358746->mclk_rate = best_mclk_rate;
  1167	
  1168		if (best_mclk_rate != mclk_rate)
  1169			dev_warn(dev, "Request MCLK freq:%lu, found MCLK freq:%lu\n",
  1170				 mclk_rate, best_mclk_rate);
  1171	
  1172		dev_dbg(dev, "Found MCLK settings: freq:%lu prediv:%u postdiv:%u\n",
  1173			best_mclk_rate, mclk_prediv, mclk_postdiv);
  1174	
  1175		return best_mclk_rate;
  1176	}
  1177	
> 1178	unsigned long tc358746_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
  1179	{
  1180		struct tc358746 *tc358746 = clk_hw_to_tc358746(hw);
  1181		unsigned int prediv, postdiv;
  1182		u32 val;
  1183		int err;
  1184	
  1185		err = tc358746_read(tc358746, MCLKCTL_REG, &val);
  1186		if (err)
  1187			return 0;
  1188	
  1189		postdiv = FIELD_GET(MCLK_LOW_MASK, val) + 1;
  1190		postdiv += FIELD_GET(MCLK_HIGH_MASK, val) + 1;
  1191	
  1192		err = tc358746_read(tc358746, CLKCTL_REG, &val);
  1193		if (err)
  1194			return 0;
  1195	
  1196		prediv = FIELD_GET(MCLKDIV_MASK, val);
  1197		if (prediv == MCLKDIV_8)
  1198			prediv = 8;
  1199		else if (prediv == MCLKDIV_4)
  1200			prediv = 4;
  1201		else
  1202			prediv = 2;
  1203	
  1204		return tc358746->pll_rate / (prediv * postdiv);
  1205	}
  1206	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
