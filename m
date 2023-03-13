Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBD906B7F5C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 18:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbjCMRXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 13:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbjCMRXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 13:23:24 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D208237D;
        Mon, 13 Mar 2023 10:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678728148; x=1710264148;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=H8a0NPFButprvGfKHEKIO3C4dhu9pBc/xoZ4jmbbjrg=;
  b=BV4zKv2xoiTyaO9MT65OLWFXd6ZvjjZjhSG1np6VtBlM+rRGLuJtzOKF
   doRhJlYvQb1IerIX5f3ZI4oY/G5Nz9/Lf9QocWvjnDgEhOhGjuFHuh5b3
   wiBMe7ISoWjdbK2x35QWxpoGVFsBZ58iuliEdm8iQVKh92sWmfx6uwlvD
   QLC8UcPQKt8pKTV2RhROIlHyNEO+lRFBZRYTHDbvF/LzYXI9d4xIFGexE
   YqEr7eTh41WO995t6qw6Oaze6EOgqhxyWu4lQZswQ5RwYPCf/YKyNv24i
   99zQCZfvNVqCFhtwGCuSml5u3lYBTRN8fAMk8L6HcdPl1xb5rKuDnn3Om
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="325570858"
X-IronPort-AV: E=Sophos;i="5.98,257,1673942400"; 
   d="scan'208";a="325570858"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 10:17:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="789000428"
X-IronPort-AV: E=Sophos;i="5.98,257,1673942400"; 
   d="scan'208";a="789000428"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 13 Mar 2023 10:17:33 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pblng-0005vE-1L;
        Mon, 13 Mar 2023 17:17:32 +0000
Date:   Tue, 14 Mar 2023 01:16:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [rft, PATCH v1 1/1] gpio: Drop unused inclusions from of_gpio.h
Message-ID: <202303140125.kHh8NLma-lkp@intel.com>
References: <20230313144557.35856-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230313144557.35856-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

I love your patch! Yet something to improve:

[auto build test ERROR on brgl/gpio/for-next]
[also build test ERROR on linus/master v6.3-rc2 next-20230310]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/gpio-Drop-unused-inclusions-from-of_gpio-h/20230313-224656
base:   https://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git gpio/for-next
patch link:    https://lore.kernel.org/r/20230313144557.35856-1-andriy.shevchenko%40linux.intel.com
patch subject: [rft, PATCH v1 1/1] gpio: Drop unused inclusions from of_gpio.h
config: x86_64-randconfig-a012-20230313 (https://download.01.org/0day-ci/archive/20230314/202303140125.kHh8NLma-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/b108d11788b6db9e37a6c4b3110c09cecf30a46c
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Andy-Shevchenko/gpio-Drop-unused-inclusions-from-of_gpio-h/20230313-224656
        git checkout b108d11788b6db9e37a6c4b3110c09cecf30a46c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash sound/soc/codecs/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303140125.kHh8NLma-lkp@intel.com/

All errors (new ones prefixed by >>):

>> sound/soc/codecs/cs42l73.c:1316:9: error: implicit declaration of function 'devm_gpio_request_one' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                   ret = devm_gpio_request_one(&i2c_client->dev,
                         ^
>> sound/soc/codecs/cs42l73.c:1318:10: error: use of undeclared identifier 'GPIOF_OUT_INIT_HIGH'
                                               GPIOF_OUT_INIT_HIGH,
                                               ^
>> sound/soc/codecs/cs42l73.c:1325:3: error: implicit declaration of function 'gpio_set_value_cansleep' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                   gpio_set_value_cansleep(cs42l73->pdata.reset_gpio, 0);
                   ^
   sound/soc/codecs/cs42l73.c:1363:2: error: implicit declaration of function 'gpio_set_value_cansleep' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           gpio_set_value_cansleep(cs42l73->pdata.reset_gpio, 0);
           ^
   4 errors generated.
--
>> sound/soc/codecs/ak5386.c:114:6: error: implicit declaration of function 'gpio_is_valid' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           if (gpio_is_valid(priv->reset_gpio))
               ^
   sound/soc/codecs/ak5386.c:114:6: note: did you mean 'uuid_is_valid'?
   include/linux/uuid.h:102:19: note: 'uuid_is_valid' declared here
   bool __must_check uuid_is_valid(const char *uuid);
                     ^
>> sound/soc/codecs/ak5386.c:115:3: error: implicit declaration of function 'gpio_set_value' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                   gpio_set_value(priv->reset_gpio, 1);
                   ^
   sound/soc/codecs/ak5386.c:126:6: error: implicit declaration of function 'gpio_is_valid' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           if (gpio_is_valid(priv->reset_gpio))
               ^
   sound/soc/codecs/ak5386.c:127:3: error: implicit declaration of function 'gpio_set_value' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                   gpio_set_value(priv->reset_gpio, 0);
                   ^
   sound/soc/codecs/ak5386.c:186:6: error: implicit declaration of function 'gpio_is_valid' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           if (gpio_is_valid(priv->reset_gpio))
               ^
>> sound/soc/codecs/ak5386.c:187:7: error: implicit declaration of function 'devm_gpio_request_one' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                   if (devm_gpio_request_one(dev, priv->reset_gpio,
                       ^
>> sound/soc/codecs/ak5386.c:188:8: error: use of undeclared identifier 'GPIOF_OUT_INIT_LOW'
                                             GPIOF_OUT_INIT_LOW,
                                             ^
   7 errors generated.
--
>> sound/soc/codecs/aw88395/aw88395.c:458:3: error: implicit declaration of function 'gpiod_set_value_cansleep' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                   gpiod_set_value_cansleep(aw88395->reset_gpio, 0);
                   ^
>> sound/soc/codecs/aw88395/aw88395.c:527:24: error: implicit declaration of function 'devm_gpiod_get_optional' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           aw88395->reset_gpio = devm_gpiod_get_optional(&i2c->dev, "reset", GPIOD_OUT_LOW);
                                 ^
   sound/soc/codecs/aw88395/aw88395.c:527:24: note: did you mean 'devm_regulator_get_optional'?
   include/linux/regulator/consumer.h:208:32: note: 'devm_regulator_get_optional' declared here
   struct regulator *__must_check devm_regulator_get_optional(struct device *dev,
                                  ^
>> sound/soc/codecs/aw88395/aw88395.c:527:68: error: use of undeclared identifier 'GPIOD_OUT_LOW'
           aw88395->reset_gpio = devm_gpiod_get_optional(&i2c->dev, "reset", GPIOD_OUT_LOW);
                                                                             ^
   3 errors generated.
--
>> sound/soc/codecs/cs42l52.c:1143:9: error: implicit declaration of function 'devm_gpio_request_one' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                   ret = devm_gpio_request_one(&i2c_client->dev,
                         ^
>> sound/soc/codecs/cs42l52.c:1145:10: error: use of undeclared identifier 'GPIOF_OUT_INIT_HIGH'
                                               GPIOF_OUT_INIT_HIGH,
                                               ^
>> sound/soc/codecs/cs42l52.c:1152:3: error: implicit declaration of function 'gpio_set_value_cansleep' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                   gpio_set_value_cansleep(cs42l52->pdata.reset_gpio, 0);
                   ^
   3 errors generated.
--
>> sound/soc/codecs/cs42l56.c:1203:9: error: implicit declaration of function 'gpio_request_one' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                   ret = gpio_request_one(cs42l56->pdata.gpio_nreset,
                         ^
>> sound/soc/codecs/cs42l56.c:1204:12: error: use of undeclared identifier 'GPIOF_OUT_INIT_HIGH'
                                          GPIOF_OUT_INIT_HIGH, "CS42L56 /RST");
                                          ^
>> sound/soc/codecs/cs42l56.c:1211:3: error: implicit declaration of function 'gpio_set_value_cansleep' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                   gpio_set_value_cansleep(cs42l56->pdata.gpio_nreset, 0);
                   ^
   3 errors generated.
--
>> sound/soc/codecs/wcd9335.c:5091:2: error: implicit declaration of function 'gpio_direction_output' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           gpio_direction_output(wcd->reset_gpio, 0);
           ^
>> sound/soc/codecs/wcd9335.c:5093:2: error: implicit declaration of function 'gpio_set_value' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           gpio_set_value(wcd->reset_gpio, 1);
           ^
   2 errors generated.


vim +/devm_gpio_request_one +1316 sound/soc/codecs/cs42l73.c

6d10c91493a0b3 Brian Austin      2011-11-16  1275  
4a4043456cb82d Stephen Kitt      2022-03-25  1276  static int cs42l73_i2c_probe(struct i2c_client *i2c_client)
6d10c91493a0b3 Brian Austin      2011-11-16  1277  {
6d10c91493a0b3 Brian Austin      2011-11-16  1278  	struct cs42l73_private *cs42l73;
3d8c8bc0250f7c Brian Austin      2013-10-17  1279  	struct cs42l73_platform_data *pdata = dev_get_platdata(&i2c_client->dev);
26495252fe0d1e Charles Keepax    2021-05-10  1280  	int ret, devid;
6d10c91493a0b3 Brian Austin      2011-11-16  1281  	unsigned int reg;
7b09eea52939d2 Brian Austin      2013-10-18  1282  	u32 val32;
6d10c91493a0b3 Brian Austin      2011-11-16  1283  
68fa08c665e51b Markus Elfring    2017-11-22  1284  	cs42l73 = devm_kzalloc(&i2c_client->dev, sizeof(*cs42l73), GFP_KERNEL);
10d95ad48b4bf4 Sachin Kamat      2014-06-20  1285  	if (!cs42l73)
6d10c91493a0b3 Brian Austin      2011-11-16  1286  		return -ENOMEM;
6d10c91493a0b3 Brian Austin      2011-11-16  1287  
571f6a7f07e9dd Brian Austin      2012-06-04  1288  	cs42l73->regmap = devm_regmap_init_i2c(i2c_client, &cs42l73_regmap);
6d10c91493a0b3 Brian Austin      2011-11-16  1289  	if (IS_ERR(cs42l73->regmap)) {
6d10c91493a0b3 Brian Austin      2011-11-16  1290  		ret = PTR_ERR(cs42l73->regmap);
6d10c91493a0b3 Brian Austin      2011-11-16  1291  		dev_err(&i2c_client->dev, "regmap_init() failed: %d\n", ret);
571f6a7f07e9dd Brian Austin      2012-06-04  1292  		return ret;
6d10c91493a0b3 Brian Austin      2011-11-16  1293  	}
3d8c8bc0250f7c Brian Austin      2013-10-17  1294  
7b09eea52939d2 Brian Austin      2013-10-18  1295  	if (pdata) {
3d8c8bc0250f7c Brian Austin      2013-10-17  1296  		cs42l73->pdata = *pdata;
7b09eea52939d2 Brian Austin      2013-10-18  1297  	} else {
68fa08c665e51b Markus Elfring    2017-11-22  1298  		pdata = devm_kzalloc(&i2c_client->dev, sizeof(*pdata),
7b09eea52939d2 Brian Austin      2013-10-18  1299  				     GFP_KERNEL);
ddedd797943df2 Markus Elfring    2017-11-22  1300  		if (!pdata)
7b09eea52939d2 Brian Austin      2013-10-18  1301  			return -ENOMEM;
ddedd797943df2 Markus Elfring    2017-11-22  1302  
7b09eea52939d2 Brian Austin      2013-10-18  1303  		if (i2c_client->dev.of_node) {
7b09eea52939d2 Brian Austin      2013-10-18  1304  			if (of_property_read_u32(i2c_client->dev.of_node,
7b09eea52939d2 Brian Austin      2013-10-18  1305  				"chgfreq", &val32) >= 0)
7b09eea52939d2 Brian Austin      2013-10-18  1306  				pdata->chgfreq = val32;
7b09eea52939d2 Brian Austin      2013-10-18  1307  		}
7b09eea52939d2 Brian Austin      2013-10-18  1308  		pdata->reset_gpio = of_get_named_gpio(i2c_client->dev.of_node,
7b09eea52939d2 Brian Austin      2013-10-18  1309  						"reset-gpio", 0);
7b09eea52939d2 Brian Austin      2013-10-18  1310  		cs42l73->pdata = *pdata;
7b09eea52939d2 Brian Austin      2013-10-18  1311  	}
3d8c8bc0250f7c Brian Austin      2013-10-17  1312  
3d8c8bc0250f7c Brian Austin      2013-10-17  1313  	i2c_set_clientdata(i2c_client, cs42l73);
3d8c8bc0250f7c Brian Austin      2013-10-17  1314  
3d8c8bc0250f7c Brian Austin      2013-10-17  1315  	if (cs42l73->pdata.reset_gpio) {
2b21694f153a0d Axel Lin          2014-04-08 @1316  		ret = devm_gpio_request_one(&i2c_client->dev,
2b21694f153a0d Axel Lin          2014-04-08  1317  					    cs42l73->pdata.reset_gpio,
2b21694f153a0d Axel Lin          2014-04-08 @1318  					    GPIOF_OUT_INIT_HIGH,
2b21694f153a0d Axel Lin          2014-04-08  1319  					    "CS42L73 /RST");
3d8c8bc0250f7c Brian Austin      2013-10-17  1320  		if (ret < 0) {
3d8c8bc0250f7c Brian Austin      2013-10-17  1321  			dev_err(&i2c_client->dev, "Failed to request /RST %d: %d\n",
3d8c8bc0250f7c Brian Austin      2013-10-17  1322  				cs42l73->pdata.reset_gpio, ret);
3d8c8bc0250f7c Brian Austin      2013-10-17  1323  			return ret;
3d8c8bc0250f7c Brian Austin      2013-10-17  1324  		}
3d8c8bc0250f7c Brian Austin      2013-10-17 @1325  		gpio_set_value_cansleep(cs42l73->pdata.reset_gpio, 0);
3d8c8bc0250f7c Brian Austin      2013-10-17  1326  		gpio_set_value_cansleep(cs42l73->pdata.reset_gpio, 1);
3d8c8bc0250f7c Brian Austin      2013-10-17  1327  	}
3d8c8bc0250f7c Brian Austin      2013-10-17  1328  
6d10c91493a0b3 Brian Austin      2011-11-16  1329  	/* initialize codec */
26495252fe0d1e Charles Keepax    2021-05-10  1330  	devid = cirrus_read_device_id(cs42l73->regmap, CS42L73_DEVID_AB);
26495252fe0d1e Charles Keepax    2021-05-10  1331  	if (devid < 0) {
26495252fe0d1e Charles Keepax    2021-05-10  1332  		ret = devid;
26495252fe0d1e Charles Keepax    2021-05-10  1333  		dev_err(&i2c_client->dev, "Failed to read device ID: %d\n", ret);
26495252fe0d1e Charles Keepax    2021-05-10  1334  		goto err_reset;
26495252fe0d1e Charles Keepax    2021-05-10  1335  	}
6d10c91493a0b3 Brian Austin      2011-11-16  1336  
6d10c91493a0b3 Brian Austin      2011-11-16  1337  	if (devid != CS42L73_DEVID) {
ea0756158110fe Axel Lin          2011-11-19  1338  		ret = -ENODEV;
6d10c91493a0b3 Brian Austin      2011-11-16  1339  		dev_err(&i2c_client->dev,
6d10c91493a0b3 Brian Austin      2011-11-16  1340  			"CS42L73 Device ID (%X). Expected %X\n",
6d10c91493a0b3 Brian Austin      2011-11-16  1341  			devid, CS42L73_DEVID);
26495252fe0d1e Charles Keepax    2021-05-10  1342  		goto err_reset;
6d10c91493a0b3 Brian Austin      2011-11-16  1343  	}
6d10c91493a0b3 Brian Austin      2011-11-16  1344  
6d10c91493a0b3 Brian Austin      2011-11-16  1345  	ret = regmap_read(cs42l73->regmap, CS42L73_REVID, &reg);
6d10c91493a0b3 Brian Austin      2011-11-16  1346  	if (ret < 0) {
6d10c91493a0b3 Brian Austin      2011-11-16  1347  		dev_err(&i2c_client->dev, "Get Revision ID failed\n");
26495252fe0d1e Charles Keepax    2021-05-10  1348  		goto err_reset;
6d10c91493a0b3 Brian Austin      2011-11-16  1349  	}
6d10c91493a0b3 Brian Austin      2011-11-16  1350  
6d10c91493a0b3 Brian Austin      2011-11-16  1351  	dev_info(&i2c_client->dev,
8421f620da9717 Axel Lin          2011-11-19  1352  		 "Cirrus Logic CS42L73, Revision: %02X\n", reg & 0xFF);
6d10c91493a0b3 Brian Austin      2011-11-16  1353  
092631bf863d6c Kuninori Morimoto 2018-01-29  1354  	ret = devm_snd_soc_register_component(&i2c_client->dev,
092631bf863d6c Kuninori Morimoto 2018-01-29  1355  			&soc_component_dev_cs42l73, cs42l73_dai,
6d10c91493a0b3 Brian Austin      2011-11-16  1356  			ARRAY_SIZE(cs42l73_dai));
6d10c91493a0b3 Brian Austin      2011-11-16  1357  	if (ret < 0)
26495252fe0d1e Charles Keepax    2021-05-10  1358  		goto err_reset;
26495252fe0d1e Charles Keepax    2021-05-10  1359  
571f6a7f07e9dd Brian Austin      2012-06-04  1360  	return 0;
26495252fe0d1e Charles Keepax    2021-05-10  1361  
26495252fe0d1e Charles Keepax    2021-05-10  1362  err_reset:
26495252fe0d1e Charles Keepax    2021-05-10  1363  	gpio_set_value_cansleep(cs42l73->pdata.reset_gpio, 0);
26495252fe0d1e Charles Keepax    2021-05-10  1364  
26495252fe0d1e Charles Keepax    2021-05-10  1365  	return ret;
6d10c91493a0b3 Brian Austin      2011-11-16  1366  }
6d10c91493a0b3 Brian Austin      2011-11-16  1367  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
