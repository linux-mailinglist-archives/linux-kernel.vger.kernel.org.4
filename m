Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 340D9628C65
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 23:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237315AbiKNW4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 17:56:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbiKNW4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 17:56:31 -0500
Received: from m-r1.th.seeweb.it (m-r1.th.seeweb.it [5.144.164.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E02461AD91
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 14:56:29 -0800 (PST)
Received: from [192.168.2.144] (bband-dyn193.178-41-216.t-com.sk [178.41.216.193])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 2E5A01F917;
        Mon, 14 Nov 2022 23:56:27 +0100 (CET)
Date:   Mon, 14 Nov 2022 23:56:21 +0100
From:   Martin Botka <martin.botka@somainline.org>
Subject: Re: [PATCH 1/1] regulator: axp20x: Add support for AXP1530 variant
To:     kernel test robot <lkp@intel.com>
Cc:     martin.botka1@gmail.com, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev,
        ~postmarketos/upstreaming@lists.sr.ht,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Jami Kettunen <jamipkettunen@somainline.org>,
        Paul Bouchara <paul.bouchara@somainline.org>,
        Yenda <jtrmal@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-kernel@vger.kernel.org
Message-Id: <X11DLR.YBCMARW947UJ2@somainline.org>
In-Reply-To: <202211150623.9oWDx9Ec-lkp@intel.com>
References: <20221114162459.1802174-1-martin.botka@somainline.org>
        <202211150623.9oWDx9Ec-lkp@intel.com>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch depends on the MFD driver which introduces also the regulator 
definitions.

On Tue, Nov 15 2022 at 06:52:24 AM +08:00:00, kernel test robot 
<lkp@intel.com> wrote:
> Hi Martin,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on broonie-regulator/for-next]
> [also build test ERROR on linus/master v6.1-rc5 next-20221114]
> [If your patch is applied to the wrong git tree, kindly drop us a 
> note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    
> https://github.com/intel-lab-lkp/linux/commits/Martin-Botka/regulator-axp20x-Add-support-for-AXP1530-variant/20221115-002644
> base:   
> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 
> for-next
> patch link:    
> https://lore.kernel.org/r/20221114162459.1802174-1-martin.botka%40somainline.org
> patch subject: [PATCH 1/1] regulator: axp20x: Add support for AXP1530 
> variant
> config: x86_64-randconfig-k001-20221114
> compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project 
> f28c006a5895fc0e329fe15fead81e37457cb1d1)
> reproduce (this is a W=1 build):
>         wget 
> https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross 
> -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # 
> https://github.com/intel-lab-lkp/linux/commit/7f0eb274b33943549c38a0eb160748d3754ad1e7
>         git remote add linux-review 
> https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review 
> Martin-Botka/regulator-axp20x-Add-support-for-AXP1530-variant/20221115-002644
>         git checkout 7f0eb274b33943549c38a0eb160748d3754ad1e7
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross 
> W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/regulator/
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>>>  drivers/regulator/axp20x-regulator.c:1021:2: error: use of 
>>> undeclared identifier 'AXP1530_DCDC1'
>            AXP_DESC_RANGES(AXP1530, DCDC1, "dcdc1", "vin1", 
> axp1530_dcdc1_ranges,
>            ^
>    drivers/regulator/axp20x-regulator.c:351:10: note: expanded from 
> macro 'AXP_DESC_RANGES'
>                    .id             = _family##_##_id,                 
>              \
>                                      ^
>    <scratch space>:53:1: note: expanded from here
>    AXP1530_DCDC1
>    ^
>>>  drivers/regulator/axp20x-regulator.c:1022:12: error: use of 
>>> undeclared identifier 'AXP1530_DCDC1_CONRTOL'
>                                            0x6B, 
> AXP1530_DCDC1_CONRTOL, 0x7f, AXP1530_OUTPUT_CONTROL,
>                                                  ^
>>>  drivers/regulator/axp20x-regulator.c:1022:41: error: use of 
>>> undeclared identifier 'AXP1530_OUTPUT_CONTROL'
>                                            0x6B, 
> AXP1530_DCDC1_CONRTOL, 0x7f, AXP1530_OUTPUT_CONTROL,
>                                                                       
>         ^
>>>  drivers/regulator/axp20x-regulator.c:1024:2: error: use of 
>>> undeclared identifier 'AXP1530_DCDC2'
>            AXP_DESC_RANGES(AXP1530, DCDC2, "dcdc2", "vin2", 
> axp1530_dcdc2_ranges,
>            ^
>    drivers/regulator/axp20x-regulator.c:351:10: note: expanded from 
> macro 'AXP_DESC_RANGES'
>                    .id             = _family##_##_id,                 
>              \
>                                      ^
>    <scratch space>:58:1: note: expanded from here
>    AXP1530_DCDC2
>    ^
>>>  drivers/regulator/axp20x-regulator.c:1025:12: error: use of 
>>> undeclared identifier 'AXP1530_DCDC2_CONRTOL'
>                                            0x58, 
> AXP1530_DCDC2_CONRTOL, 0x7f, AXP1530_OUTPUT_CONTROL,
>                                                  ^
>    drivers/regulator/axp20x-regulator.c:1025:41: error: use of 
> undeclared identifier 'AXP1530_OUTPUT_CONTROL'
>                                            0x58, 
> AXP1530_DCDC2_CONRTOL, 0x7f, AXP1530_OUTPUT_CONTROL,
>                                                                       
>         ^
>>>  drivers/regulator/axp20x-regulator.c:1027:2: error: use of 
>>> undeclared identifier 'AXP1530_DCDC3'
>            AXP_DESC_RANGES(AXP1530, DCDC3, "dcdc3", "vin3", 
> axp1530_dcdc3_ranges,
>            ^
>    drivers/regulator/axp20x-regulator.c:351:10: note: expanded from 
> macro 'AXP_DESC_RANGES'
>                    .id             = _family##_##_id,                 
>              \
>                                      ^
>    <scratch space>:63:1: note: expanded from here
>    AXP1530_DCDC3
>    ^
>>>  drivers/regulator/axp20x-regulator.c:1028:12: error: use of 
>>> undeclared identifier 'AXP1530_DCDC3_CONRTOL'
>                                            0x58, 
> AXP1530_DCDC3_CONRTOL, 0x7f, AXP1530_OUTPUT_CONTROL,
>                                                  ^
>    drivers/regulator/axp20x-regulator.c:1028:41: error: use of 
> undeclared identifier 'AXP1530_OUTPUT_CONTROL'
>                                            0x58, 
> AXP1530_DCDC3_CONRTOL, 0x7f, AXP1530_OUTPUT_CONTROL,
>                                                                       
>         ^
>>>  drivers/regulator/axp20x-regulator.c:1030:2: error: use of 
>>> undeclared identifier 'AXP1530_LDO1'
>            AXP_DESC(AXP1530, LDO1, "ldo1", "ldo1in", 500, 3500, 100,
>            ^
>    drivers/regulator/axp20x-regulator.c:303:10: note: expanded from 
> macro 'AXP_DESC'
>                    .id             = _family##_##_id,                 
>              \
>                                      ^
>    <scratch space>:68:1: note: expanded from here
>    AXP1530_LDO1
>    ^
>>>  drivers/regulator/axp20x-regulator.c:1031:6: error: use of 
>>> undeclared identifier 'AXP1530_ALDO1_CONRTOL'
>                                            AXP1530_ALDO1_CONRTOL, 
> 0x1f, AXP1530_OUTPUT_CONTROL,
>                                            ^
>    drivers/regulator/axp20x-regulator.c:1031:35: error: use of 
> undeclared identifier 'AXP1530_OUTPUT_CONTROL'
>                                            AXP1530_ALDO1_CONRTOL, 
> 0x1f, AXP1530_OUTPUT_CONTROL,
>                                                                       
>   ^
>>>  drivers/regulator/axp20x-regulator.c:1033:2: error: use of 
>>> undeclared identifier 'AXP1530_LDO2'
>            AXP_DESC(AXP1530, LDO2, "ldo2", "ldo2in", 500, 3500, 100,
>            ^
>    drivers/regulator/axp20x-regulator.c:303:10: note: expanded from 
> macro 'AXP_DESC'
>                    .id             = _family##_##_id,                 
>              \
>                                      ^
>    <scratch space>:73:1: note: expanded from here
>    AXP1530_LDO2
>    ^
>>>  drivers/regulator/axp20x-regulator.c:1034:6: error: use of 
>>> undeclared identifier 'AXP1530_DLDO1_CONRTOL'
>                                            AXP1530_DLDO1_CONRTOL, 
> 0x1f, AXP1530_OUTPUT_CONTROL,
>                                            ^
>    drivers/regulator/axp20x-regulator.c:1034:35: error: use of 
> undeclared identifier 'AXP1530_OUTPUT_CONTROL'
>                                            AXP1530_DLDO1_CONRTOL, 
> 0x1f, AXP1530_OUTPUT_CONTROL,
>                                                                       
>   ^
>>>  drivers/regulator/axp20x-regulator.c:1077:7: error: use of 
>>> undeclared identifier 'AXP1530_ID'; did you mean 'AXP152_ID'?
>            case AXP1530_ID:
>                 ^~~~~~~~~~
>                 AXP152_ID
>    include/linux/mfd/axp20x.h:14:2: note: 'AXP152_ID' declared here
>            AXP152_ID = 0,
>            ^
>    drivers/regulator/axp20x-regulator.c:1295:8: error: use of 
> undeclared identifier 'AXP1530_ID'; did you mean 'AXP152_ID'?
>                    case AXP1530_ID:
>                         ^~~~~~~~~~
>                         AXP152_ID
>    include/linux/mfd/axp20x.h:14:2: note: 'AXP152_ID' declared here
>            AXP152_ID = 0,
>            ^
>>>  drivers/regulator/axp20x-regulator.c:1297:17: error: use of 
>>> undeclared identifier 'AXP1530_REG_ID_MAX'
>                    nregulators = AXP1530_REG_ID_MAX;
>                                  ^
>>>  drivers/regulator/axp20x-regulator.c:1021:2: error: use of 
>>> undeclared identifier 'AXP1530_DCDC1'
>            AXP_DESC_RANGES(AXP1530, DCDC1, "dcdc1", "vin1", 
> axp1530_dcdc1_ranges,
>            ^
>    drivers/regulator/axp20x-regulator.c:345:3: note: expanded from 
> macro 'AXP_DESC_RANGES'
>            [_family##_##_id] = {                                      
>              \
>             ^
>    <scratch space>:51:1: note: expanded from here
>    AXP1530_DCDC1
>    ^
>    fatal error: too many errors emitted, stopping now [-ferror-limit=]
>    20 errors generated.
> 
> 
> vim +/AXP1530_DCDC1 +1021 drivers/regulator/axp20x-regulator.c
> 
>   1019
>   1020	static const struct regulator_desc axp1530_regulators[] = {
>>  1021		AXP_DESC_RANGES(AXP1530, DCDC1, "dcdc1", "vin1", 
>> axp1530_dcdc1_ranges,
>>  1022						0x6B, AXP1530_DCDC1_CONRTOL, 0x7f, AXP1530_OUTPUT_CONTROL,
>   1023						BIT(0)),
>>  1024		AXP_DESC_RANGES(AXP1530, DCDC2, "dcdc2", "vin2", 
>> axp1530_dcdc2_ranges,
>>  1025						0x58, AXP1530_DCDC2_CONRTOL, 0x7f, AXP1530_OUTPUT_CONTROL,
>   1026						BIT(1)),
>>  1027		AXP_DESC_RANGES(AXP1530, DCDC3, "dcdc3", "vin3", 
>> axp1530_dcdc3_ranges,
>>  1028						0x58, AXP1530_DCDC3_CONRTOL, 0x7f, AXP1530_OUTPUT_CONTROL,
>   1029						BIT(2)),
>>  1030		AXP_DESC(AXP1530, LDO1, "ldo1", "ldo1in", 500, 3500, 100,
>>  1031						AXP1530_ALDO1_CONRTOL, 0x1f, AXP1530_OUTPUT_CONTROL,
>   1032						BIT(3)),
>>  1033		AXP_DESC(AXP1530, LDO2, "ldo2", "ldo2in", 500, 3500, 100,
>>  1034						AXP1530_DLDO1_CONRTOL, 0x1f, AXP1530_OUTPUT_CONTROL,
>   1035						BIT(4)),
>   1036	};
>   1037
>   1038	static int axp20x_set_dcdc_freq(struct platform_device *pdev, 
> u32 dcdcfreq)
>   1039	{
>   1040		struct axp20x_dev *axp20x = dev_get_drvdata(pdev->dev.parent);
>   1041		unsigned int reg = AXP20X_DCDC_FREQ;
>   1042		u32 min, max, def, step;
>   1043
>   1044		switch (axp20x->variant) {
>   1045		case AXP202_ID:
>   1046		case AXP209_ID:
>   1047			min = 750;
>   1048			max = 1875;
>   1049			def = 1500;
>   1050			step = 75;
>   1051			break;
>   1052		case AXP803_ID:
>   1053		case AXP813_ID:
>   1054			/*
>   1055			 * AXP803/AXP813 DCDC work frequency setting has the same
>   1056			 * range and step as AXP22X, but at a different register.
>   1057			 * (See include/linux/mfd/axp20x.h)
>   1058			 */
>   1059			reg = AXP803_DCDC_FREQ_CTRL;
>   1060			fallthrough;	/* to the check below */
>   1061		case AXP806_ID:
>   1062			/*
>   1063			 * AXP806 also have DCDC work frequency setting register at a
>   1064			 * different position.
>   1065			 */
>   1066			if (axp20x->variant == AXP806_ID)
>   1067				reg = AXP806_DCDC_FREQ_CTRL;
>   1068			fallthrough;
>   1069		case AXP221_ID:
>   1070		case AXP223_ID:
>   1071		case AXP809_ID:
>   1072			min = 1800;
>   1073			max = 4050;
>   1074			def = 3000;
>   1075			step = 150;
>   1076			break;
>>  1077		case AXP1530_ID:
>   1078			/*
>   1079			 * Do not set the DCDC frequency on AXP1530
>   1080			 */
>   1081			return 0;
>   1082			break;
>   1083		default:
>   1084			dev_err(&pdev->dev,
>   1085				"Setting DCDC frequency for unsupported AXP variant\n");
>   1086			return -EINVAL;
>   1087		}
>   1088
>   1089		if (dcdcfreq == 0)
>   1090			dcdcfreq = def;
>   1091
>   1092		if (dcdcfreq < min) {
>   1093			dcdcfreq = min;
>   1094			dev_warn(&pdev->dev, "DCDC frequency too low. Set to 
> %ukHz\n",
>   1095				 min);
>   1096		}
>   1097
>   1098		if (dcdcfreq > max) {
>   1099			dcdcfreq = max;
>   1100			dev_warn(&pdev->dev, "DCDC frequency too high. Set to 
> %ukHz\n",
>   1101				 max);
>   1102		}
>   1103
>   1104		dcdcfreq = (dcdcfreq - min) / step;
>   1105
>   1106		return regmap_update_bits(axp20x->regmap, reg,
>   1107					  AXP20X_FREQ_DCDC_MASK, dcdcfreq);
>   1108	}
>   1109
> 
> --
> 0-DAY CI Kernel Test Service
> https://01.org/lkp


