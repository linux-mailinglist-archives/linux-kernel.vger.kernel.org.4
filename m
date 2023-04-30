Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27EC66F27FD
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Apr 2023 09:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjD3H73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 03:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjD3H7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 03:59:25 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E323213E;
        Sun, 30 Apr 2023 00:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682841564; x=1714377564;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=nNt70c2qJyO2Xz2+WNYLYg3z+OyYyPnpmVTTu1vFnW0=;
  b=lRI3MWj8+DZA9YtNTbIO5c/xch/LZco9PIKLQaRhNUHuK1ohwbdzE+w8
   dcMmcsKxiPOEgotL4fqGr8WCp7UVEHNVEAvOVikt5of+b3+ZMfJTXBe5u
   1/ouuLuB4TXRg8IWceY8sh8VQi//mQtU25Ziua/ejkdASwaJOIN3lAS43
   E9V3Vw6mwlcBaPFJqTlZ+bU0hL/hfW9/PQfLSDfxUuA2SoArqUTHQC3fx
   4XeX4zIqWEF9wtsP5rZlMDF590WoLM5IDaVUvxkO2zIFG89p6b3s0dy9c
   d3maOawUmsZCIV+poI9v6ci719kX12daelYrL0zHzdiof7YkHsv0c/ZDH
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10695"; a="345470869"
X-IronPort-AV: E=Sophos;i="5.99,238,1677571200"; 
   d="scan'208";a="345470869"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2023 00:59:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10695"; a="784895272"
X-IronPort-AV: E=Sophos;i="5.99,238,1677571200"; 
   d="scan'208";a="784895272"
Received: from lkp-server01.sh.intel.com (HELO 5bad9d2b7fcb) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 30 Apr 2023 00:59:22 -0700
Received: from kbuild by 5bad9d2b7fcb with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pt1xp-0001Yp-1L;
        Sun, 30 Apr 2023 07:59:21 +0000
Date:   Sun, 30 Apr 2023 15:58:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Sebastian Reichel <sre@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Subject: Re: [PATCH] power: supply: remove unneeded include of linux/leds.h
Message-ID: <202304301551.baBXvI9d-lkp@intel.com>
References: <20230212-include-power_supply-leds-v1-1-7adbf7424002@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230212-include-power_supply-leds-v1-1-7adbf7424002@weissschuh.net>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

kernel test robot noticed the following build errors:

[auto build test ERROR on 825a0714d2b3883d4f8ff64f6933fb73ee3f1834]

url:    https://github.com/intel-lab-lkp/linux/commits/Thomas-Wei-schuh/power-supply-remove-unneeded-include-of-linux-leds-h/20230430-141232
base:   825a0714d2b3883d4f8ff64f6933fb73ee3f1834
patch link:    https://lore.kernel.org/r/20230212-include-power_supply-leds-v1-1-7adbf7424002%40weissschuh.net
patch subject: [PATCH] power: supply: remove unneeded include of linux/leds.h
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20230430/202304301551.baBXvI9d-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/b75095fc2fd15bc4d539656b12200b44a9705959
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Thomas-Wei-schuh/power-supply-remove-unneeded-include-of-linux-leds-h/20230430-141232
        git checkout b75095fc2fd15bc4d539656b12200b44a9705959
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 olddefconfig
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304301551.baBXvI9d-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/hid/hid-lg4ff.c:1121:30: warning: 'enum led_brightness' declared inside parameter list will not be visible outside of this definition or declaration
    1121 |                         enum led_brightness value)
         |                              ^~~~~~~~~~~~~~
>> drivers/hid/hid-lg4ff.c:1121:45: error: parameter 2 ('value') has incomplete type
    1121 |                         enum led_brightness value)
         |                         ~~~~~~~~~~~~~~~~~~~~^~~~~
>> drivers/hid/hid-lg4ff.c:1120:13: error: function declaration isn't a prototype [-Werror=strict-prototypes]
    1120 | static void lg4ff_led_set_brightness(struct led_classdev *led_cdev,
         |             ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/hid/hid-lg4ff.c: In function 'lg4ff_led_set_brightness':
>> drivers/hid/hid-lg4ff.c:1123:38: error: invalid use of undefined type 'struct led_classdev'
    1123 |         struct device *dev = led_cdev->dev->parent;
         |                                      ^~
>> drivers/hid/hid-lg4ff.c:1145:30: error: 'LED_OFF' undeclared (first use in this function)
    1145 |                 if (value == LED_OFF && state) {
         |                              ^~~~~~~
   drivers/hid/hid-lg4ff.c:1145:30: note: each undeclared identifier is reported only once for each function it appears in
   drivers/hid/hid-lg4ff.c: At top level:
>> drivers/hid/hid-lg4ff.c:1156:28: error: return type is an incomplete type
    1156 | static enum led_brightness lg4ff_led_get_brightness(struct led_classdev *led_cdev)
         |                            ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/hid/hid-lg4ff.c: In function 'lg4ff_led_get_brightness':
   drivers/hid/hid-lg4ff.c:1158:38: error: invalid use of undefined type 'struct led_classdev'
    1158 |         struct device *dev = led_cdev->dev->parent;
         |                                      ^~
   drivers/hid/hid-lg4ff.c:1166:24: error: 'LED_OFF' undeclared (first use in this function)
    1166 |                 return LED_OFF;
         |                        ^~~~~~~
   drivers/hid/hid-lg4ff.c:1166:24: error: 'return' with a value, in function returning void [-Werror=return-type]
   drivers/hid/hid-lg4ff.c:1156:28: note: declared here
    1156 | static enum led_brightness lg4ff_led_get_brightness(struct led_classdev *led_cdev)
         |                            ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/hid/hid-lg4ff.c:1173:24: error: 'return' with a value, in function returning void [-Werror=return-type]
    1173 |                 return LED_OFF;
         |                        ^~~~~~~
   drivers/hid/hid-lg4ff.c:1156:28: note: declared here
    1156 | static enum led_brightness lg4ff_led_get_brightness(struct led_classdev *led_cdev)
         |                            ^~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/hid/hid-lg4ff.c:1182:24: error: 'LED_FULL' undeclared (first use in this function); did you mean 'LED_NUML'?
    1182 |         return value ? LED_FULL : LED_OFF;
         |                        ^~~~~~~~
         |                        LED_NUML
   drivers/hid/hid-lg4ff.c:1182:16: error: 'return' with a value, in function returning void [-Werror=return-type]
    1182 |         return value ? LED_FULL : LED_OFF;
         |                ^~~~~
   drivers/hid/hid-lg4ff.c:1156:28: note: declared here
    1156 | static enum led_brightness lg4ff_led_get_brightness(struct led_classdev *led_cdev)
         |                            ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/hid/hid-lg4ff.c: In function 'lg4ff_init':
>> drivers/hid/hid-lg4ff.c:1410:46: error: invalid application of 'sizeof' to incomplete type 'struct led_classdev'
    1410 |                         led = kzalloc(sizeof(struct led_classdev)+name_sz, GFP_KERNEL);
         |                                              ^~~~~~
   drivers/hid/hid-lg4ff.c:1416:45: error: invalid use of undefined type 'struct led_classdev'
    1416 |                         name = (void *)(&led[1]);
         |                                             ^
   drivers/hid/hid-lg4ff.c:1418:28: error: invalid use of undefined type 'struct led_classdev'
    1418 |                         led->name = name;
         |                            ^~
   drivers/hid/hid-lg4ff.c:1419:28: error: invalid use of undefined type 'struct led_classdev'
    1419 |                         led->brightness = 0;
         |                            ^~
   drivers/hid/hid-lg4ff.c:1420:28: error: invalid use of undefined type 'struct led_classdev'
    1420 |                         led->max_brightness = 1;
         |                            ^~
   drivers/hid/hid-lg4ff.c:1421:28: error: invalid use of undefined type 'struct led_classdev'
    1421 |                         led->brightness_get = lg4ff_led_get_brightness;
         |                            ^~
   drivers/hid/hid-lg4ff.c:1422:28: error: invalid use of undefined type 'struct led_classdev'
    1422 |                         led->brightness_set = lg4ff_led_set_brightness;
         |                            ^~
>> drivers/hid/hid-lg4ff.c:1425:33: error: implicit declaration of function 'led_classdev_register'; did you mean 'class_register'? [-Werror=implicit-function-declaration]
    1425 |                         error = led_classdev_register(&hid->dev, led);
         |                                 ^~~~~~~~~~~~~~~~~~~~~
         |                                 class_register
>> drivers/hid/hid-lg4ff.c:1436:41: error: implicit declaration of function 'led_classdev_unregister'; did you mean 'class_unregister'? [-Werror=implicit-function-declaration]
    1436 |                                         led_classdev_unregister(led);
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~
         |                                         class_unregister
   cc1: some warnings being treated as errors


vim +1121 drivers/hid/hid-lg4ff.c

22bcefdc8838186 Simon Wood   2012-04-21  1119  
22bcefdc8838186 Simon Wood   2012-04-21 @1120  static void lg4ff_led_set_brightness(struct led_classdev *led_cdev,
22bcefdc8838186 Simon Wood   2012-04-21 @1121  			enum led_brightness value)
22bcefdc8838186 Simon Wood   2012-04-21  1122  {
22bcefdc8838186 Simon Wood   2012-04-21 @1123  	struct device *dev = led_cdev->dev->parent;
ee79a8f840a45d3 Geliang Tang 2015-12-27  1124  	struct hid_device *hid = to_hid_device(dev);
4629fd160f7da96 Axel Lin     2012-09-13  1125  	struct lg_drv_data *drv_data = hid_get_drvdata(hid);
22bcefdc8838186 Simon Wood   2012-04-21  1126  	struct lg4ff_device_entry *entry;
22bcefdc8838186 Simon Wood   2012-04-21  1127  	int i, state = 0;
22bcefdc8838186 Simon Wood   2012-04-21  1128  
22bcefdc8838186 Simon Wood   2012-04-21  1129  	if (!drv_data) {
22bcefdc8838186 Simon Wood   2012-04-21  1130  		hid_err(hid, "Device data not found.");
22bcefdc8838186 Simon Wood   2012-04-21  1131  		return;
22bcefdc8838186 Simon Wood   2012-04-21  1132  	}
22bcefdc8838186 Simon Wood   2012-04-21  1133  
371a1d9e1fed7dc Michal Malý  2015-04-08  1134  	entry = drv_data->device_props;
22bcefdc8838186 Simon Wood   2012-04-21  1135  
22bcefdc8838186 Simon Wood   2012-04-21  1136  	if (!entry) {
22bcefdc8838186 Simon Wood   2012-04-21  1137  		hid_err(hid, "Device properties not found.");
22bcefdc8838186 Simon Wood   2012-04-21  1138  		return;
22bcefdc8838186 Simon Wood   2012-04-21  1139  	}
22bcefdc8838186 Simon Wood   2012-04-21  1140  
22bcefdc8838186 Simon Wood   2012-04-21  1141  	for (i = 0; i < 5; i++) {
72529c65a5399be Michal Malý  2015-04-08  1142  		if (led_cdev != entry->wdata.led[i])
22bcefdc8838186 Simon Wood   2012-04-21  1143  			continue;
72529c65a5399be Michal Malý  2015-04-08  1144  		state = (entry->wdata.led_state >> i) & 1;
22bcefdc8838186 Simon Wood   2012-04-21 @1145  		if (value == LED_OFF && state) {
72529c65a5399be Michal Malý  2015-04-08  1146  			entry->wdata.led_state &= ~(1 << i);
72529c65a5399be Michal Malý  2015-04-08  1147  			lg4ff_set_leds(hid, entry->wdata.led_state);
22bcefdc8838186 Simon Wood   2012-04-21  1148  		} else if (value != LED_OFF && !state) {
72529c65a5399be Michal Malý  2015-04-08  1149  			entry->wdata.led_state |= 1 << i;
72529c65a5399be Michal Malý  2015-04-08  1150  			lg4ff_set_leds(hid, entry->wdata.led_state);
22bcefdc8838186 Simon Wood   2012-04-21  1151  		}
22bcefdc8838186 Simon Wood   2012-04-21  1152  		break;
22bcefdc8838186 Simon Wood   2012-04-21  1153  	}
22bcefdc8838186 Simon Wood   2012-04-21  1154  }
22bcefdc8838186 Simon Wood   2012-04-21  1155  
22bcefdc8838186 Simon Wood   2012-04-21 @1156  static enum led_brightness lg4ff_led_get_brightness(struct led_classdev *led_cdev)
22bcefdc8838186 Simon Wood   2012-04-21  1157  {
22bcefdc8838186 Simon Wood   2012-04-21  1158  	struct device *dev = led_cdev->dev->parent;
ee79a8f840a45d3 Geliang Tang 2015-12-27  1159  	struct hid_device *hid = to_hid_device(dev);
4629fd160f7da96 Axel Lin     2012-09-13  1160  	struct lg_drv_data *drv_data = hid_get_drvdata(hid);
22bcefdc8838186 Simon Wood   2012-04-21  1161  	struct lg4ff_device_entry *entry;
22bcefdc8838186 Simon Wood   2012-04-21  1162  	int i, value = 0;
22bcefdc8838186 Simon Wood   2012-04-21  1163  
22bcefdc8838186 Simon Wood   2012-04-21  1164  	if (!drv_data) {
22bcefdc8838186 Simon Wood   2012-04-21  1165  		hid_err(hid, "Device data not found.");
22bcefdc8838186 Simon Wood   2012-04-21  1166  		return LED_OFF;
22bcefdc8838186 Simon Wood   2012-04-21  1167  	}
22bcefdc8838186 Simon Wood   2012-04-21  1168  
371a1d9e1fed7dc Michal Malý  2015-04-08  1169  	entry = drv_data->device_props;
22bcefdc8838186 Simon Wood   2012-04-21  1170  
22bcefdc8838186 Simon Wood   2012-04-21  1171  	if (!entry) {
22bcefdc8838186 Simon Wood   2012-04-21  1172  		hid_err(hid, "Device properties not found.");
22bcefdc8838186 Simon Wood   2012-04-21  1173  		return LED_OFF;
22bcefdc8838186 Simon Wood   2012-04-21  1174  	}
22bcefdc8838186 Simon Wood   2012-04-21  1175  
22bcefdc8838186 Simon Wood   2012-04-21  1176  	for (i = 0; i < 5; i++)
72529c65a5399be Michal Malý  2015-04-08  1177  		if (led_cdev == entry->wdata.led[i]) {
72529c65a5399be Michal Malý  2015-04-08  1178  			value = (entry->wdata.led_state >> i) & 1;
22bcefdc8838186 Simon Wood   2012-04-21  1179  			break;
22bcefdc8838186 Simon Wood   2012-04-21  1180  		}
22bcefdc8838186 Simon Wood   2012-04-21  1181  
22bcefdc8838186 Simon Wood   2012-04-21 @1182  	return value ? LED_FULL : LED_OFF;
22bcefdc8838186 Simon Wood   2012-04-21  1183  }
22bcefdc8838186 Simon Wood   2012-04-21  1184  #endif
22bcefdc8838186 Simon Wood   2012-04-21  1185  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
