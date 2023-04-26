Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DCD16EF463
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 14:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240829AbjDZMfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 08:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240494AbjDZMfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 08:35:36 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A1AE3C39;
        Wed, 26 Apr 2023 05:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682512535; x=1714048535;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DVAQ2H9eYhFnYmY1Vo/YzInzguOJas3HkypWUdYady0=;
  b=YbPAdJQKXQbzR43LuRiPLKowSmoRTLCowqJ73z4TTaIPekue3j+j+Nfu
   Ht+1gGfQ7yoNJCI3q8KxJ5Vf+g6LUiMffBX7/3Hurd1bCZ/rCcTzsXo9E
   TokIikitfe/SkNeBrE0GjjH2395uYE8WqLvMuuPWj0SoEM9AJPMHBlZkc
   dWea1TsuvkHcFQuQ0tw17hZRAkf6hEAInkV5tRw2Rk+33dDYi9B/ZRVzk
   zMTidBdu50I/6fr/kMYbTREL/BLXWYMcjeLoe0wo8IOe9KOeI+/22fwud
   DhP+Trl2BqpWdJEHAnbd6VSu/T7dIPReRKOtzfDSG1GQvIMmEn6WXpWYC
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10691"; a="375045837"
X-IronPort-AV: E=Sophos;i="5.99,228,1677571200"; 
   d="scan'208";a="375045837"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2023 05:35:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10691"; a="1023600017"
X-IronPort-AV: E=Sophos;i="5.99,228,1677571200"; 
   d="scan'208";a="1023600017"
Received: from lkp-server01.sh.intel.com (HELO 041f065c1b1b) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 26 Apr 2023 05:35:32 -0700
Received: from kbuild by 041f065c1b1b with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1preMt-00008Y-1w;
        Wed, 26 Apr 2023 12:35:31 +0000
Date:   Wed, 26 Apr 2023 20:35:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Naresh Solanki <naresh.solanki@9elements.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     oe-kbuild-all@lists.linux.dev,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Naresh Solanki <Naresh.Solanki@9elements.com>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH] hwmon: (max597x) Add Maxim Max597x
Message-ID: <202304262021.nGJgsK76-lkp@intel.com>
References: <20230426090356.745979-1-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230426090356.745979-1-Naresh.Solanki@9elements.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Naresh,

kernel test robot noticed the following build warnings:

[auto build test WARNING on b4c288cfd2f84c44994330c408e14645d45dee5b]

url:    https://github.com/intel-lab-lkp/linux/commits/Naresh-Solanki/hwmon-max597x-Add-Maxim-Max597x/20230426-170556
base:   b4c288cfd2f84c44994330c408e14645d45dee5b
patch link:    https://lore.kernel.org/r/20230426090356.745979-1-Naresh.Solanki%409elements.com
patch subject: [PATCH] hwmon: (max597x) Add Maxim Max597x
config: sparc-allyesconfig (https://download.01.org/0day-ci/archive/20230426/202304262021.nGJgsK76-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/3d6f729d86a79adf0603717c79bc389a5dcc4444
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Naresh-Solanki/hwmon-max597x-Add-Maxim-Max597x/20230426-170556
        git checkout 3d6f729d86a79adf0603717c79bc389a5dcc4444
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sparc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sparc SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304262021.nGJgsK76-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/hwmon/max597x.c: In function 'max597x_read':
>> drivers/hwmon/max597x.c:47:9: warning: enumeration value 'hwmon_chip' not handled in switch [-Wswitch]
      47 |         switch (type) {
         |         ^~~~~~
>> drivers/hwmon/max597x.c:47:9: warning: enumeration value 'hwmon_temp' not handled in switch [-Wswitch]
>> drivers/hwmon/max597x.c:47:9: warning: enumeration value 'hwmon_power' not handled in switch [-Wswitch]
>> drivers/hwmon/max597x.c:47:9: warning: enumeration value 'hwmon_energy' not handled in switch [-Wswitch]
>> drivers/hwmon/max597x.c:47:9: warning: enumeration value 'hwmon_humidity' not handled in switch [-Wswitch]
>> drivers/hwmon/max597x.c:47:9: warning: enumeration value 'hwmon_fan' not handled in switch [-Wswitch]
>> drivers/hwmon/max597x.c:47:9: warning: enumeration value 'hwmon_pwm' not handled in switch [-Wswitch]
>> drivers/hwmon/max597x.c:47:9: warning: enumeration value 'hwmon_intrusion' not handled in switch [-Wswitch]
>> drivers/hwmon/max597x.c:47:9: warning: enumeration value 'hwmon_max' not handled in switch [-Wswitch]


vim +/hwmon_chip +47 drivers/hwmon/max597x.c

    40	
    41	static int max597x_read(struct device *dev, enum hwmon_sensor_types type,
    42				u32 attr, int channel, long *val)
    43	{
    44		struct max597x_hwmon *ddata = dev_get_drvdata(dev);
    45		int ret;
    46	
  > 47		switch (type) {
    48		case hwmon_curr:
    49			switch (attr) {
    50			case hwmon_curr_input:
    51				ret = max597x_read_reg(ddata, MAX5970_REG_CURRENT_H(channel),
    52						       ddata->irng[channel], val);
    53				if (ret < 0)
    54					return ret;
    55	
    56				return 0;
    57			default:
    58				return -EOPNOTSUPP;
    59			}
    60	
    61		case hwmon_in:
    62			switch (attr) {
    63			case hwmon_in_input:
    64				ret = max597x_read_reg(ddata, MAX5970_REG_VOLTAGE_H(channel),
    65						       ddata->mon_rng[channel], val);
    66				if (ret < 0)
    67					return ret;
    68				return 0;
    69			default:
    70				return -EOPNOTSUPP;
    71			}
    72		}
    73		return -EOPNOTSUPP;
    74	}
    75	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
