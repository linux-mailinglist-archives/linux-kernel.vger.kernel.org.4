Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4566E6CF8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 21:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232100AbjDRTeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 15:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232385AbjDRTeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 15:34:10 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F447A94;
        Tue, 18 Apr 2023 12:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681846448; x=1713382448;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=R0lX7KXSIGZeRWlUbbQwoFAWMx1W4y2vJ5k94Ji5BBE=;
  b=U8DEWkQ1bxiULp9coTdpBEeIOnaKdPmcA9gTdu5rPoVJntFevLWtCsP9
   LVgy4J7Dz9JU6ayXS/RzMIjOeUBxuB+R84q+DlEQe5AdYBxM35M/TR+n0
   E0cvpegn8EPrGaebyXyi4B2QxoVtYQUytx0fPPPzNQawTfmjp5EJka0CS
   p70FazOFMM7oZTtwcdMUcqVfqQhKAoFHfG7Sb9XROPry9mq9ShicQDgC/
   ZyIL7lr3x0Ny1TcFz58h3zi7h2VFe56X01dWsY6/9ax/9U9MwXINmJvFP
   TNoGALFXRTInKwBZ92j/poxBuv620bHYUDavB20hIcuj4BFD/3T5k5U/p
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="431551437"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="431551437"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 12:34:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="780601955"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="780601955"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 18 Apr 2023 12:34:05 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1por5Y-000dxX-0V;
        Tue, 18 Apr 2023 19:34:04 +0000
Date:   Wed, 19 Apr 2023 03:33:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     nick.hawkins@hpe.com, verdun@hpe.com, linus.walleij@linaro.org,
        brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jdelvare@suse.com,
        linux@roeck-us.net, linux@armlinux.org.uk,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v1 3/9] hwmon: (gxp-psu) Add driver to read HPE PSUs
Message-ID: <202304190301.9jtv8uzG-lkp@intel.com>
References: <20230418152824.110823-4-nick.hawkins@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230418152824.110823-4-nick.hawkins@hpe.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on groeck-staging/hwmon-next]
[also build test WARNING on robh/for-next linus/master v6.3-rc7]
[cannot apply to brgl/gpio/for-next next-20230417]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/nick-hawkins-hpe-com/gpio-gxp-Add-HPE-GXP-GPIO/20230418-233513
base:   https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-next
patch link:    https://lore.kernel.org/r/20230418152824.110823-4-nick.hawkins%40hpe.com
patch subject: [PATCH v1 3/9] hwmon: (gxp-psu) Add driver to read HPE PSUs
config: sparc-allyesconfig (https://download.01.org/0day-ci/archive/20230419/202304190301.9jtv8uzG-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/4006e868883aedc37a54480167f6f9dc377db1cc
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review nick-hawkins-hpe-com/gpio-gxp-Add-HPE-GXP-GPIO/20230418-233513
        git checkout 4006e868883aedc37a54480167f6f9dc377db1cc
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sparc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sparc SHELL=/bin/bash drivers/hwmon/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304190301.9jtv8uzG-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/hwmon/gxp-psu.c:62:4: warning: no previous prototype for 'get_psu_inst' [-Wmissing-prototypes]
      62 | u8 get_psu_inst(void)
         |    ^~~~~~~~~~~~
>> drivers/hwmon/gxp-psu.c:71:4: warning: no previous prototype for 'get_psu_ac' [-Wmissing-prototypes]
      71 | u8 get_psu_ac(void)
         |    ^~~~~~~~~~
>> drivers/hwmon/gxp-psu.c:80:4: warning: no previous prototype for 'get_psu_dc' [-Wmissing-prototypes]
      80 | u8 get_psu_dc(void)
         |    ^~~~~~~~~~
>> drivers/hwmon/gxp-psu.c:89:6: warning: no previous prototype for 'update_presence' [-Wmissing-prototypes]
      89 | void update_presence(u8 id)
         |      ^~~~~~~~~~~~~~~
>> drivers/hwmon/gxp-psu.c:376:6: warning: no previous prototype for 'swapbytes' [-Wmissing-prototypes]
     376 | void swapbytes(void *input, size_t len)
         |      ^~~~~~~~~
   drivers/hwmon/gxp-psu.c: In function 'gxp_psu_read_string':
>> drivers/hwmon/gxp-psu.c:528:17: warning: this statement may fall through [-Wimplicit-fallthrough=]
     528 |                 switch (attr) {
         |                 ^~~~~~
   drivers/hwmon/gxp-psu.c:535:9: note: here
     535 |         case hwmon_in:
         |         ^~~~
   drivers/hwmon/gxp-psu.c:536:17: warning: this statement may fall through [-Wimplicit-fallthrough=]
     536 |                 switch (attr) {
         |                 ^~~~~~
   drivers/hwmon/gxp-psu.c:543:9: note: here
     543 |         case hwmon_fan:
         |         ^~~~
   drivers/hwmon/gxp-psu.c:544:17: warning: this statement may fall through [-Wimplicit-fallthrough=]
     544 |                 switch (attr) {
         |                 ^~~~~~
   drivers/hwmon/gxp-psu.c:551:9: note: here
     551 |         case hwmon_curr:
         |         ^~~~
   drivers/hwmon/gxp-psu.c:552:17: warning: this statement may fall through [-Wimplicit-fallthrough=]
     552 |                 switch (attr) {
         |                 ^~~~~~
   drivers/hwmon/gxp-psu.c:559:9: note: here
     559 |         case hwmon_temp:
         |         ^~~~


vim +/get_psu_inst +62 drivers/hwmon/gxp-psu.c

    61	
  > 62	u8 get_psu_inst(void)
    63	{
    64		if (!pl_psu)
    65			return 0;
    66	
    67		return readb(pl_psu);
    68	}
    69	EXPORT_SYMBOL(get_psu_inst);
    70	
  > 71	u8 get_psu_ac(void)
    72	{
    73		if (!pl_psu)
    74			return 0;
    75	
    76		return readb(pl_psu + 0x02);
    77	}
    78	EXPORT_SYMBOL(get_psu_ac);
    79	
  > 80	u8 get_psu_dc(void)
    81	{
    82		if (!pl_psu)
    83			return 0;
    84	
    85		return readb(pl_psu + 0x03);
    86	}
    87	EXPORT_SYMBOL(get_psu_dc);
    88	
  > 89	void update_presence(u8 id)
    90	{
    91		unsigned int i;
    92		unsigned long temp = (unsigned long)readb(pl_psu);
    93	
    94		for_each_set_bit(i, &temp, 8) {
    95			if (i == id)
    96				psus[id]->present = true;
    97		}
    98	
    99		temp = ~temp;
   100		for_each_set_bit(i, &temp, 8) {
   101			if (i == id)
   102				psus[id]->present = false;
   103		}
   104	}
   105	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
