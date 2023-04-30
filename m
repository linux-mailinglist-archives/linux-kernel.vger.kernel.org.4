Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 223256F27E8
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Apr 2023 09:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbjD3HH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 03:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjD3HHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 03:07:25 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 842D7E7E;
        Sun, 30 Apr 2023 00:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682838443; x=1714374443;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=rWUtBQP7hQlUECvWZgQSZz1AgPZTENUeXOB+7QICipU=;
  b=ny2uWrzjLY1XJQqsVuGG7mUU0rEbRfdmjJnWpJ4+HRQv9MoZm3x1nk5z
   xpAb+wuqYedrkqAB4znBXsSUyLi7Uit+uiP+LJjMoDOKam8KxX2ACr9g0
   A7azzNrO0gy4oWUqLSPQsV2KszJluDdjxL4asOB2WZzqUuSK9jDg+8v4K
   HKUScAQs9ck23SCc0IcQsSEjFU3MLn24Epj7AXcn9KVS+Omc40C83oQgp
   xmdkH1qsDT/Wwsk/mgRj72bt/spuL2v4cbfacrGyEU8Es10+RcU1cwJkN
   MdeB97E2yGKm2M66oezATcYZcZ7CrgPfKcnuXv4CGE+w7H9j9VLBv35c5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10695"; a="350943729"
X-IronPort-AV: E=Sophos;i="5.99,238,1677571200"; 
   d="scan'208";a="350943729"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2023 00:07:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10695"; a="672811939"
X-IronPort-AV: E=Sophos;i="5.99,238,1677571200"; 
   d="scan'208";a="672811939"
Received: from lkp-server01.sh.intel.com (HELO 5bad9d2b7fcb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 30 Apr 2023 00:07:21 -0700
Received: from kbuild by 5bad9d2b7fcb with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pt19U-0001XV-28;
        Sun, 30 Apr 2023 07:07:20 +0000
Date:   Sun, 30 Apr 2023 15:06:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Sebastian Reichel <sre@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Subject: Re: [PATCH] power: supply: remove unneeded include of linux/leds.h
Message-ID: <202304301500.Ep5XviHQ-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on 825a0714d2b3883d4f8ff64f6933fb73ee3f1834]

url:    https://github.com/intel-lab-lkp/linux/commits/Thomas-Wei-schuh/power-supply-remove-unneeded-include-of-linux-leds-h/20230430-141232
base:   825a0714d2b3883d4f8ff64f6933fb73ee3f1834
patch link:    https://lore.kernel.org/r/20230212-include-power_supply-leds-v1-1-7adbf7424002%40weissschuh.net
patch subject: [PATCH] power: supply: remove unneeded include of linux/leds.h
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20230430/202304301500.Ep5XviHQ-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/b75095fc2fd15bc4d539656b12200b44a9705959
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Thomas-Wei-schuh/power-supply-remove-unneeded-include-of-linux-leds-h/20230430-141232
        git checkout b75095fc2fd15bc4d539656b12200b44a9705959
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 olddefconfig
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/hid/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304301500.Ep5XviHQ-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/hid/hid-lg4ff.c:1121:30: warning: 'enum led_brightness' declared inside parameter list will not be visible outside of this definition or declaration
    1121 |                         enum led_brightness value)
         |                              ^~~~~~~~~~~~~~
   drivers/hid/hid-lg4ff.c:1121:45: error: parameter 2 ('value') has incomplete type
    1121 |                         enum led_brightness value)
         |                         ~~~~~~~~~~~~~~~~~~~~^~~~~
   drivers/hid/hid-lg4ff.c:1120:13: error: function declaration isn't a prototype [-Werror=strict-prototypes]
    1120 | static void lg4ff_led_set_brightness(struct led_classdev *led_cdev,
         |             ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/hid/hid-lg4ff.c: In function 'lg4ff_led_set_brightness':
   drivers/hid/hid-lg4ff.c:1123:38: error: invalid use of undefined type 'struct led_classdev'
    1123 |         struct device *dev = led_cdev->dev->parent;
         |                                      ^~
   drivers/hid/hid-lg4ff.c:1145:30: error: 'LED_OFF' undeclared (first use in this function)
    1145 |                 if (value == LED_OFF && state) {
         |                              ^~~~~~~
   drivers/hid/hid-lg4ff.c:1145:30: note: each undeclared identifier is reported only once for each function it appears in
   drivers/hid/hid-lg4ff.c: At top level:
   drivers/hid/hid-lg4ff.c:1156:28: error: return type is an incomplete type
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
   drivers/hid/hid-lg4ff.c:1182:24: error: 'LED_FULL' undeclared (first use in this function); did you mean 'LED_NUML'?
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
   drivers/hid/hid-lg4ff.c:1410:46: error: invalid application of 'sizeof' to incomplete type 'struct led_classdev'
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
   drivers/hid/hid-lg4ff.c:1425:33: error: implicit declaration of function 'led_classdev_register'; did you mean 'class_register'? [-Werror=implicit-function-declaration]
    1425 |                         error = led_classdev_register(&hid->dev, led);
         |                                 ^~~~~~~~~~~~~~~~~~~~~
         |                                 class_register
   drivers/hid/hid-lg4ff.c:1436:41: error: implicit declaration of function 'led_classdev_unregister'; did you mean 'class_unregister'? [-Werror=implicit-function-declaration]
    1436 |                                         led_classdev_unregister(led);
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~
         |                                         class_unregister
   cc1: some warnings being treated as errors


vim +1121 drivers/hid/hid-lg4ff.c

22bcefdc883818 Simon Wood   2012-04-21  1119  
22bcefdc883818 Simon Wood   2012-04-21  1120  static void lg4ff_led_set_brightness(struct led_classdev *led_cdev,
22bcefdc883818 Simon Wood   2012-04-21 @1121  			enum led_brightness value)
22bcefdc883818 Simon Wood   2012-04-21  1122  {
22bcefdc883818 Simon Wood   2012-04-21  1123  	struct device *dev = led_cdev->dev->parent;
ee79a8f840a45d Geliang Tang 2015-12-27  1124  	struct hid_device *hid = to_hid_device(dev);
4629fd160f7da9 Axel Lin     2012-09-13  1125  	struct lg_drv_data *drv_data = hid_get_drvdata(hid);
22bcefdc883818 Simon Wood   2012-04-21  1126  	struct lg4ff_device_entry *entry;
22bcefdc883818 Simon Wood   2012-04-21  1127  	int i, state = 0;
22bcefdc883818 Simon Wood   2012-04-21  1128  
22bcefdc883818 Simon Wood   2012-04-21  1129  	if (!drv_data) {
22bcefdc883818 Simon Wood   2012-04-21  1130  		hid_err(hid, "Device data not found.");
22bcefdc883818 Simon Wood   2012-04-21  1131  		return;
22bcefdc883818 Simon Wood   2012-04-21  1132  	}
22bcefdc883818 Simon Wood   2012-04-21  1133  
371a1d9e1fed7d Michal Malý  2015-04-08  1134  	entry = drv_data->device_props;
22bcefdc883818 Simon Wood   2012-04-21  1135  
22bcefdc883818 Simon Wood   2012-04-21  1136  	if (!entry) {
22bcefdc883818 Simon Wood   2012-04-21  1137  		hid_err(hid, "Device properties not found.");
22bcefdc883818 Simon Wood   2012-04-21  1138  		return;
22bcefdc883818 Simon Wood   2012-04-21  1139  	}
22bcefdc883818 Simon Wood   2012-04-21  1140  
22bcefdc883818 Simon Wood   2012-04-21  1141  	for (i = 0; i < 5; i++) {
72529c65a5399b Michal Malý  2015-04-08  1142  		if (led_cdev != entry->wdata.led[i])
22bcefdc883818 Simon Wood   2012-04-21  1143  			continue;
72529c65a5399b Michal Malý  2015-04-08  1144  		state = (entry->wdata.led_state >> i) & 1;
22bcefdc883818 Simon Wood   2012-04-21  1145  		if (value == LED_OFF && state) {
72529c65a5399b Michal Malý  2015-04-08  1146  			entry->wdata.led_state &= ~(1 << i);
72529c65a5399b Michal Malý  2015-04-08  1147  			lg4ff_set_leds(hid, entry->wdata.led_state);
22bcefdc883818 Simon Wood   2012-04-21  1148  		} else if (value != LED_OFF && !state) {
72529c65a5399b Michal Malý  2015-04-08  1149  			entry->wdata.led_state |= 1 << i;
72529c65a5399b Michal Malý  2015-04-08  1150  			lg4ff_set_leds(hid, entry->wdata.led_state);
22bcefdc883818 Simon Wood   2012-04-21  1151  		}
22bcefdc883818 Simon Wood   2012-04-21  1152  		break;
22bcefdc883818 Simon Wood   2012-04-21  1153  	}
22bcefdc883818 Simon Wood   2012-04-21  1154  }
22bcefdc883818 Simon Wood   2012-04-21  1155  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
