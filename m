Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 387396CC1A7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 16:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233007AbjC1OBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 10:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233074AbjC1OBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 10:01:19 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3178CA26;
        Tue, 28 Mar 2023 07:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680012008; x=1711548008;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jilw46ig3h4nFW0taBT9/fQ4a+6HEJTG4UBUL1RGGfk=;
  b=FNk7Efo1s1/kGT4ieuUPDZtRGqP8PyYw07+F97iPL8wI0q8q0HlSVJcM
   BUHZ/s00rypXoe0z9eLSNV5IWm81Fg2xOgW5LkxKEL8RpX/k+JNZestA2
   q9xUdj3kyh2M0fE2BlcxkCtisfM7iPAbs1P/gvBLMozGYg5mlUL8Keysx
   AgfXDlsR/L2Y+/Mc5HJmNddfax3KyvQhW/OCtrMNgOIRJQxbK8tXPgseo
   S49sCqw0rzQRYWFowmwOWz6QAmpA1Oib1KpqXRL1cBaHsvvfGcs8R45Bi
   nuHEjStP8zzxh/4cjkGQkjFDuQVB9ODoNpbuN8iDa6U6VxlUmanvz1ziu
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="405505971"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="405505971"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 07:00:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="929892745"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="929892745"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 28 Mar 2023 07:00:06 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ph9rp-000IaN-21;
        Tue, 28 Mar 2023 14:00:05 +0000
Date:   Tue, 28 Mar 2023 21:59:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Naresh Solanki <naresh.solanki@9elements.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>
Cc:     oe-kbuild-all@lists.linux.dev,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Naresh Solanki <Naresh.Solanki@9elements.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] hwmon: (pmbus/core): Add regulator event support
Message-ID: <202303282129.T1h4aFZp-lkp@intel.com>
References: <20230328121712.4057359-2-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328121712.4057359-2-Naresh.Solanki@9elements.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Naresh,

I love your patch! Yet something to improve:

[auto build test ERROR on 8a863eb1b1162653d133856702e13560f3596b85]

url:    https://github.com/intel-lab-lkp/linux/commits/Naresh-Solanki/hwmon-pmbus-core-Add-regulator-event-support/20230328-201831
base:   8a863eb1b1162653d133856702e13560f3596b85
patch link:    https://lore.kernel.org/r/20230328121712.4057359-2-Naresh.Solanki%409elements.com
patch subject: [PATCH 2/3] hwmon: (pmbus/core): Add regulator event support
config: riscv-allmodconfig (https://download.01.org/0day-ci/archive/20230328/202303282129.T1h4aFZp-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/bc5ab0ded8947e49f5292c04bf381274a0272f3f
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Naresh-Solanki/hwmon-pmbus-core-Add-regulator-event-support/20230328-201831
        git checkout bc5ab0ded8947e49f5292c04bf381274a0272f3f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=riscv olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/hwmon/pmbus/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303282129.T1h4aFZp-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   drivers/hwmon/pmbus/pmbus_core.c: In function 'pmbus_regulator_get_error_flags':
>> drivers/hwmon/pmbus/pmbus_core.c:2938:9: warning: the address of 'event' will always evaluate as 'true' [-Waddress]
    2938 |         return pmbus_get_flags(data, rdev_get_id(rdev), flags, &event, false);
         |         ^~~~~~
>> drivers/hwmon/pmbus/pmbus_core.c:2938:16: error: too many arguments to function 'pmbus_get_flags'
    2938 |         return pmbus_get_flags(data, rdev_get_id(rdev), flags, &event, false);
         |                ^~~~~~~~~~~~~~~
   drivers/hwmon/pmbus/pmbus_core.c:2886:27: note: declared here
    2886 | static int __maybe_unused pmbus_get_flags(struct pmbus_data *data, u8 page, unsigned int *flags,
         |                           ^~~~~~~~~~~~~~~


vim +/pmbus_get_flags +2938 drivers/hwmon/pmbus/pmbus_core.c

  2930	
  2931	static int pmbus_regulator_get_error_flags(struct regulator_dev *rdev, unsigned int *flags)
  2932	{
  2933		struct device *dev = rdev_get_dev(rdev);
  2934		struct i2c_client *client = to_i2c_client(dev->parent);
  2935		struct pmbus_data *data = i2c_get_clientdata(client);
  2936		int event;
  2937	
> 2938		return pmbus_get_flags(data, rdev_get_id(rdev), flags, &event, false);
  2939	}
  2940	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
