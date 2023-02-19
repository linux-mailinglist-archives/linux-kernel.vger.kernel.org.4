Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DCF369C1AA
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 18:15:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbjBSRPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 12:15:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbjBSRPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 12:15:46 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A50A9126DD;
        Sun, 19 Feb 2023 09:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676826944; x=1708362944;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Mxup+H2pIaZG6RXHGUP7zKupNiYpigp1Qwch7Sph2WE=;
  b=IEMNbCyJwXbUfYDY7Pas46PxwF2bnBeKZJDT2ovEn15f9tR3GDTbocHj
   tAhynLNBZVsKNgW4ZBAvRvBFXVO2EWkGZBhQMQK6oa3e1djit5JgfwNmU
   tMUkabwmkmtXnECTARNNZxKXVYWLvssPKBwWJCIRsdesHkp9957fIe57Z
   RU4sY/X37/WsWHyCyVavNOjqFXrGZajYcJfeffCCkWNRTBF4fJ//8YmfX
   /eOrILG0ane5qDJWyo+RlFEBnIywNZubN5EQLo7jr79d3C1kwCjwmQlYD
   5LWG61O/ryzfRXD5TwW4yEP3jE4JgHQYL5mUO0wuMyxGAflrFxM5/Hxc5
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10626"; a="315979551"
X-IronPort-AV: E=Sophos;i="5.97,310,1669104000"; 
   d="scan'208";a="315979551"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2023 09:15:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10626"; a="620918327"
X-IronPort-AV: E=Sophos;i="5.97,310,1669104000"; 
   d="scan'208";a="620918327"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 19 Feb 2023 09:15:41 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pTnHo-000DO9-0v;
        Sun, 19 Feb 2023 17:15:40 +0000
Date:   Mon, 20 Feb 2023 01:15:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rafael@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v1 09/17] thermal: Add a thermal zone id accessor
Message-ID: <202302200137.srsrI6dW-lkp@intel.com>
References: <20230219143657.241542-10-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230219143657.241542-10-daniel.lezcano@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

I love your patch! Yet something to improve:

[auto build test ERROR on rafael-pm/thermal]
[also build test ERROR on next-20230217]
[cannot apply to groeck-staging/hwmon-next tegra/for-next linus/master v6.2-rc8]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Lezcano/thermal-core-Add-a-thermal-zone-devdata-accessor/20230219-224155
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal
patch link:    https://lore.kernel.org/r/20230219143657.241542-10-daniel.lezcano%40linaro.org
patch subject: [PATCH v1 09/17] thermal: Add a thermal zone id accessor
config: csky-randconfig-r005-20230219 (https://download.01.org/0day-ci/archive/20230220/202302200137.srsrI6dW-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/37b2cf4cee949fd910b54e281577cb71b2df8842
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Daniel-Lezcano/thermal-core-Add-a-thermal-zone-devdata-accessor/20230219-224155
        git checkout 37b2cf4cee949fd910b54e281577cb71b2df8842
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=csky olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=csky SHELL=/bin/bash drivers/hwmon/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302200137.srsrI6dW-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/hwmon/scmi-hwmon.c: In function 'scmi_hwmon_thermal_get_temp':
   drivers/hwmon/scmi-hwmon.c:144:49: error: implicit declaration of function 'thermal_zone_device_get_data'; did you mean 'thermal_zone_device_enable'? [-Werror=implicit-function-declaration]
     144 |         struct scmi_thermal_sensor *th_sensor = thermal_zone_device_get_data(tz);
         |                                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                                 thermal_zone_device_enable
   drivers/hwmon/scmi-hwmon.c:144:49: warning: initialization of 'struct scmi_thermal_sensor *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
   In file included from include/linux/device.h:15,
                    from include/linux/scmi_protocol.h:12,
                    from drivers/hwmon/scmi-hwmon.c:11:
   drivers/hwmon/scmi-hwmon.c: In function 'scmi_thermal_sensor_register':
>> drivers/hwmon/scmi-hwmon.c:223:39: error: implicit declaration of function 'thermal_zone_device_get_id'; did you mean 'thermal_zone_device_enable'? [-Werror=implicit-function-declaration]
     223 |                         sensor->name, thermal_zone_device_get_id(tzd));
         |                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:129:48: note: in definition of macro 'dev_printk'
     129 |                 _dev_printk(level, dev, fmt, ##__VA_ARGS__);            \
         |                                                ^~~~~~~~~~~
   drivers/hwmon/scmi-hwmon.c:222:17: note: in expansion of macro 'dev_dbg'
     222 |                 dev_dbg(dev, "Sensor '%s' attached to thermal zone ID:%d\n",
         |                 ^~~~~~~
   cc1: some warnings being treated as errors


vim +223 drivers/hwmon/scmi-hwmon.c

   138	
   139	static int scmi_hwmon_thermal_get_temp(struct thermal_zone_device *tz,
   140					       int *temp)
   141	{
   142		int ret;
   143		long value;
 > 144		struct scmi_thermal_sensor *th_sensor = thermal_zone_device_get_data(tz);
   145	
   146		ret = scmi_hwmon_read_scaled_value(th_sensor->ph, th_sensor->info,
   147						   &value);
   148		if (!ret)
   149			*temp = value;
   150	
   151		return ret;
   152	}
   153	
   154	static const struct thermal_zone_device_ops scmi_hwmon_thermal_ops = {
   155		.get_temp = scmi_hwmon_thermal_get_temp,
   156	};
   157	
   158	static int scmi_hwmon_add_chan_info(struct hwmon_channel_info *scmi_hwmon_chan,
   159					    struct device *dev, int num,
   160					    enum hwmon_sensor_types type, u32 config)
   161	{
   162		int i;
   163		u32 *cfg = devm_kcalloc(dev, num + 1, sizeof(*cfg), GFP_KERNEL);
   164	
   165		if (!cfg)
   166			return -ENOMEM;
   167	
   168		scmi_hwmon_chan->type = type;
   169		scmi_hwmon_chan->config = cfg;
   170		for (i = 0; i < num; i++, cfg++)
   171			*cfg = config;
   172	
   173		return 0;
   174	}
   175	
   176	static enum hwmon_sensor_types scmi_types[] = {
   177		[TEMPERATURE_C] = hwmon_temp,
   178		[VOLTAGE] = hwmon_in,
   179		[CURRENT] = hwmon_curr,
   180		[POWER] = hwmon_power,
   181		[ENERGY] = hwmon_energy,
   182	};
   183	
   184	static u32 hwmon_attributes[hwmon_max] = {
   185		[hwmon_temp] = HWMON_T_INPUT | HWMON_T_LABEL,
   186		[hwmon_in] = HWMON_I_INPUT | HWMON_I_LABEL,
   187		[hwmon_curr] = HWMON_C_INPUT | HWMON_C_LABEL,
   188		[hwmon_power] = HWMON_P_INPUT | HWMON_P_LABEL,
   189		[hwmon_energy] = HWMON_E_INPUT | HWMON_E_LABEL,
   190	};
   191	
   192	static int scmi_thermal_sensor_register(struct device *dev,
   193						const struct scmi_protocol_handle *ph,
   194						const struct scmi_sensor_info *sensor)
   195	{
   196		struct scmi_thermal_sensor *th_sensor;
   197		struct thermal_zone_device *tzd;
   198	
   199		th_sensor = devm_kzalloc(dev, sizeof(*th_sensor), GFP_KERNEL);
   200		if (!th_sensor)
   201			return -ENOMEM;
   202	
   203		th_sensor->ph = ph;
   204		th_sensor->info = sensor;
   205	
   206		/*
   207		 * Try to register a temperature sensor with the Thermal Framework:
   208		 * skip sensors not defined as part of any thermal zone (-ENODEV) but
   209		 * report any other errors related to misconfigured zones/sensors.
   210		 */
   211		tzd = devm_thermal_of_zone_register(dev, th_sensor->info->id, th_sensor,
   212						    &scmi_hwmon_thermal_ops);
   213		if (IS_ERR(tzd)) {
   214			devm_kfree(dev, th_sensor);
   215	
   216			if (PTR_ERR(tzd) != -ENODEV)
   217				return PTR_ERR(tzd);
   218	
   219			dev_dbg(dev, "Sensor '%s' not attached to any thermal zone.\n",
   220				sensor->name);
   221		} else {
   222			dev_dbg(dev, "Sensor '%s' attached to thermal zone ID:%d\n",
 > 223				sensor->name, thermal_zone_device_get_id(tzd));
   224		}
   225	
   226		return 0;
   227	}
   228	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
