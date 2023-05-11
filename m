Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 689BA6FF862
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 19:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238620AbjEKR1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 13:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbjEKR1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 13:27:45 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 582A940C1;
        Thu, 11 May 2023 10:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683826063; x=1715362063;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fx0F7VWVFJR9TKtE5LsUTJCThvMpQxKJrzNOZit9T2U=;
  b=lqKMcsrfO8Y8khdxLevwHB0t5UrPo95T+ie5BJWeY+EsTJprkaFcyLIZ
   AXhi+DW+AIEmKYzC8hW/b5zfPqVyEQRk9+FkaaexOJSW5xeuXkhVH3kau
   AvwNW3okpsS3W7iWKQMgCZ4YlHTuKJC1gdNIoo3TnitiiB6hTMHROSygF
   kmKnKi4wOuRTO9b7mqTyBpJSsPAt+jAyrfsl2KF/kpFUUSVJ6lEFjFJC8
   kK7Cykl7nS4BosDrZ+XQlWl4Ss5XFrJvfqZNb7IsZ9NY9SdQczccqMP5Z
   DJVxZcu3Q9Oy1y1gIDUFVmEzyxcohY5lsWUmIzFBzCCa3zlEitW3zjOTF
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="335082371"
X-IronPort-AV: E=Sophos;i="5.99,268,1677571200"; 
   d="scan'208";a="335082371"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 10:27:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="844065141"
X-IronPort-AV: E=Sophos;i="5.99,268,1677571200"; 
   d="scan'208";a="844065141"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 11 May 2023 10:27:38 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pxA4n-00049Y-2m;
        Thu, 11 May 2023 17:27:37 +0000
Date:   Fri, 12 May 2023 01:27:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     "larry.lai" <larry.lai@yunjingtech.com>, lee@kernel.org,
        andriy.shevchenko@linux.intel.com, linus.walleij@linaro.org,
        pavel@ucw.cz
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-leds@vger.kernel.org,
        GaryWang@aaeon.com.tw, musa.lin@yunjingtech.com,
        jack.chang@yunjingtech.com, noah.hung@yunjingtech.com,
        michael.wang@yunjingtech.com,
        "larry.lai" <larry.lai@yunjingtech.com>
Subject: Re: [PATCH V4 2/3] pinctrl: Add support pin control for UP board
 CPLD/FPGA
Message-ID: <202305120120.iVpl8euc-lkp@intel.com>
References: <20230511094934.4941-3-larry.lai@yunjingtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230511094934.4941-3-larry.lai@yunjingtech.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi larry.lai,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 4fe89d07dcc2804c8b562f6c7896a45643d34b2f]

url:    https://github.com/intel-lab-lkp/linux/commits/larry-lai/mfd-Add-support-for-UP-board-CPLD-FPGA/20230511-175210
base:   4fe89d07dcc2804c8b562f6c7896a45643d34b2f
patch link:    https://lore.kernel.org/r/20230511094934.4941-3-larry.lai%40yunjingtech.com
patch subject: [PATCH V4 2/3] pinctrl: Add support pin control for UP board CPLD/FPGA
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20230512/202305120120.iVpl8euc-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/c2073ac67e35aff192c5ee51f3a37e103c1f0233
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review larry-lai/mfd-Add-support-for-UP-board-CPLD-FPGA/20230511-175210
        git checkout c2073ac67e35aff192c5ee51f3a37e103c1f0233
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 olddefconfig
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/pinctrl/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305120120.iVpl8euc-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/pinctrl/pinctrl-upboard.c: In function 'upboard_alt_func_enable':
   drivers/pinctrl/pinctrl-upboard.c:779:17: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
     779 |                 bool input = false;
         |                 ^~~~
   drivers/pinctrl/pinctrl-upboard.c: In function 'upboard_pinctrl_probe':
>> drivers/pinctrl/pinctrl-upboard.c:1268:32: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
    1268 |                 pctrl->ident = (int) system_id->ident;
         |                                ^


vim +1268 drivers/pinctrl/pinctrl-upboard.c

  1140	
  1141	static int __init upboard_pinctrl_probe(struct platform_device *pdev)
  1142	{
  1143		struct upboard_fpga * const fpga = dev_get_drvdata(pdev->dev.parent);
  1144		struct acpi_device * const adev = ACPI_COMPANION(&pdev->dev);
  1145		struct pinctrl_desc *pctldesc;
  1146		struct upboard_pinctrl *pctrl;
  1147		struct upboard_pin *pins;
  1148		const struct dmi_system_id *system_id;
  1149		const char *hid;
  1150		const unsigned int *rpi_mapping;
  1151		unsigned int ngpio;
  1152		int ret;
  1153		int i;
  1154	
  1155		if (!fpga)
  1156			return -EINVAL;
  1157	
  1158		if (!adev)
  1159			return -ENODEV;
  1160	
  1161		/* set pin desc and rpi GPIO mapping table by HID */
  1162		hid = acpi_device_hid(adev);
  1163		if (!strcmp(hid, "AANT0F00") || !strcmp(hid, "AANT0F04") ||
  1164		    !strcmp(hid, "AANT0000")) {
  1165			pctldesc = &upboard_up_pinctrl_desc;
  1166			rpi_mapping = upboard_up_rpi_mapping;
  1167			ngpio = ARRAY_SIZE(upboard_up_rpi_mapping);
  1168		} else if (!strcmp(hid, "AANT0F01")) {
  1169			pctldesc = &upboard_up2_pinctrl_desc;
  1170			rpi_mapping = upboard_up2_rpi_mapping;
  1171			ngpio = ARRAY_SIZE(upboard_up2_rpi_mapping);
  1172		} else if (!strcmp(hid, "AANT0F02")) {
  1173			pctldesc = &upboard_upcore_crex_pinctrl_desc;
  1174			rpi_mapping = upboard_upcore_crex_rpi_mapping;
  1175			ngpio = ARRAY_SIZE(upboard_upcore_crex_rpi_mapping);
  1176		} else if (!strcmp(hid, "AANT0F03")) {
  1177			pctldesc = &upboard_upcore_crst02_pinctrl_desc;
  1178			rpi_mapping = upboard_upcore_crst02_rpi_mapping;
  1179			ngpio = ARRAY_SIZE(upboard_upcore_crst02_rpi_mapping);
  1180		} else
  1181			return -ENODEV;
  1182	
  1183		pctldesc->name = dev_name(&pdev->dev);
  1184	
  1185		pins = devm_kcalloc(&pdev->dev, pctldesc->npins, sizeof(*pins), GFP_KERNEL);
  1186		if (!pins)
  1187			return -ENOMEM;
  1188	
  1189		/* initialise pins */
  1190		for (i = 0; i < pctldesc->npins; i++) {
  1191			struct upboard_pin *pin = &pins[i];
  1192			struct pinctrl_pin_desc *pd = (struct pinctrl_pin_desc *) &pctldesc->pins[i];
  1193			struct reg_field fldconf = {0};
  1194			unsigned int regoff = (pd->number / UPFPGA_REGISTER_SIZE);
  1195			unsigned int lsb = pd->number % UPFPGA_REGISTER_SIZE;
  1196	
  1197			pin->funcbit = NULL;
  1198	
  1199			if (pd->drv_data) {
  1200				fldconf = *(struct reg_field *)pd->drv_data;
  1201	
  1202				pin->funcbit = devm_regmap_field_alloc(&pdev->dev,
  1203								       fpga->regmap,
  1204								       fldconf);
  1205				if (IS_ERR(pin->funcbit))
  1206					return PTR_ERR(pin->funcbit);
  1207			}
  1208	
  1209			pin->enbit = NULL;
  1210			fldconf.reg = UPFPGA_REG_GPIO_EN0 + regoff;
  1211			fldconf.lsb = lsb;
  1212			fldconf.msb = lsb;
  1213	
  1214			pin->enbit = devm_regmap_field_alloc(&pdev->dev,
  1215							     fpga->regmap,
  1216							     fldconf);
  1217			if (IS_ERR(pin->enbit))
  1218				return PTR_ERR(pin->enbit);
  1219	
  1220			fldconf.reg = UPFPGA_REG_GPIO_DIR0 + regoff;
  1221			fldconf.lsb = lsb;
  1222			fldconf.msb = lsb;
  1223	
  1224			pin->dirbit = devm_regmap_field_alloc(&pdev->dev,
  1225							      fpga->regmap,
  1226							      fldconf);
  1227			if (IS_ERR(pin->dirbit))
  1228				return PTR_ERR(pin->dirbit);
  1229	
  1230			pd->drv_data = pin;
  1231	
  1232			/* set output by default */
  1233			regmap_field_write(pin->dirbit, false);
  1234		}
  1235	
  1236		/* create a new pinctrl device and register it */
  1237		pctrl = devm_kzalloc(&pdev->dev, sizeof(*pctrl), GFP_KERNEL);
  1238		if (!pctrl)
  1239			return -ENOMEM;
  1240	
  1241		pctrl->regmap = fpga->regmap;
  1242		pctrl->rpi_mapping = rpi_mapping;
  1243		pctrl->chip = upboard_gpio_chip;
  1244		pctrl->pctldesc = pctldesc;
  1245		pctrl->chip.parent = &pdev->dev;
  1246		pctrl->chip.ngpio = ngpio;
  1247		pctrl->pins = pins;
  1248	
  1249		ret = devm_gpiochip_add_data(&pdev->dev, &pctrl->chip, pctrl);
  1250		if (ret)
  1251			return ret;
  1252	
  1253		pctrl->pctldev = devm_pinctrl_register(&pdev->dev, pctldesc, pctrl);
  1254		if (IS_ERR(pctrl->pctldev))
  1255			return PTR_ERR(pctrl->pctldev);
  1256	
  1257		/* add acpi pin mapping according to external-gpios key */
  1258		ret = upboard_acpi_node_pin_mapping(fpga, pctrl,
  1259						    "external",
  1260						    dev_name(&pdev->dev),
  1261						    0);
  1262		if (ret)
  1263			return ret;
  1264	
  1265		/* check for special board versions that require register patches */
  1266		system_id = dmi_first_match(upboard_dmi_table);
  1267		if (system_id)
> 1268			pctrl->ident = (int) system_id->ident;
  1269		else
  1270			pctrl->ident = BOARD_UP_APL03;
  1271	
  1272		upboard_alt_func_enable(&pctrl->chip, "I2C",    pctrl->ident);
  1273		upboard_alt_func_enable(&pctrl->chip, "SPI",    pctrl->ident);
  1274		upboard_alt_func_enable(&pctrl->chip, "SPI1",   pctrl->ident);
  1275		upboard_alt_func_enable(&pctrl->chip, "SPI2",   pctrl->ident);
  1276		upboard_alt_func_enable(&pctrl->chip, "UART",   pctrl->ident);
  1277		upboard_alt_func_enable(&pctrl->chip, "I2S",    pctrl->ident);
  1278		upboard_alt_func_enable(&pctrl->chip, "PWM",    pctrl->ident);
  1279		upboard_alt_func_enable(&pctrl->chip, "ADC",    pctrl->ident);
  1280		/* I2C pin mux by CPLD in UP2 */
  1281		upboard_alt_func_enable(&pctrl->chip, "NONAME", pctrl->ident);
  1282	
  1283		return ret;
  1284	}
  1285	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
