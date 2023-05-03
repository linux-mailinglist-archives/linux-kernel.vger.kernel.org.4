Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0416F5323
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 10:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjECIaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 04:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjECIaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 04:30:08 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8CD149F1;
        Wed,  3 May 2023 01:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683102606; x=1714638606;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5vVhdAGvX08FAYtCHmyekXa4m8V+FYhfBeX/G8j/1Vs=;
  b=fIUQPjS+6I/lIP5IuZ/8uMgTKn2/3+BOzKJf/0baGR+fLedFYPVCXoUU
   sEHfWkSCsBe5ow50DljZIIJ2YbtQprfGbLJ3fqGJis8/AO5aLafj38rJH
   V3wYP70Eas8m0G9v2hSS+0vYHID9oWH3KNDu4nafUjD1jvZhJClkONUkC
   EELUgE7k/zb+Z1GlLuwsa8iDDLdLSKevat3A786bbl5GvW+UHVjFwVIH4
   wCHc1Hnkb6GcB0t2lOLR3fvbHGBfYtQNAP5xCvpxrvpbmBsz1lr7YwoLd
   N7LBhtrqJgdfQr2EyXID+4uH02KNq0TYYjM8i7RJg/mIHBtM0y/bmmDWw
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10698"; a="328961974"
X-IronPort-AV: E=Sophos;i="5.99,246,1677571200"; 
   d="scan'208";a="328961974"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2023 01:30:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10698"; a="840613160"
X-IronPort-AV: E=Sophos;i="5.99,246,1677571200"; 
   d="scan'208";a="840613160"
Received: from lkp-server01.sh.intel.com (HELO e3434d64424d) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 03 May 2023 01:30:04 -0700
Received: from kbuild by e3434d64424d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pu7sB-0001iV-0R;
        Wed, 03 May 2023 08:30:03 +0000
Date:   Wed, 3 May 2023 16:29:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Naresh Solanki <naresh.solanki@9elements.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Naresh Solanki <Naresh.Solanki@9elements.com>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH] hwmon: (max597x) Add Maxim Max597x
Message-ID: <202305031640.SL6o9vFH-lkp@intel.com>
References: <20230426090356.745979-1-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230426090356.745979-1-Naresh.Solanki@9elements.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20230503/202305031640.SL6o9vFH-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/3d6f729d86a79adf0603717c79bc389a5dcc4444
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Naresh-Solanki/hwmon-max597x-Add-Maxim-Max597x/20230426-170556
        git checkout 3d6f729d86a79adf0603717c79bc389a5dcc4444
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/hwmon/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305031640.SL6o9vFH-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/hwmon/max597x.c:47:10: warning: 9 enumeration values not handled in switch: 'hwmon_chip', 'hwmon_temp', 'hwmon_power'... [-Wswitch]
           switch (type) {
                   ^~~~
   1 warning generated.


vim +47 drivers/hwmon/max597x.c

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
