Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5635C7289F5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 23:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236867AbjFHVI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 17:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237040AbjFHVIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 17:08:54 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 411EF30DF;
        Thu,  8 Jun 2023 14:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686258528; x=1717794528;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=feLhceN5MoyaEEcZHMZvB1mjorERrPsarNA+YfBuF0Q=;
  b=QQGZ0U+37sdjZ4y0QBUQFd6EwlixnWABbxh9gvyOOlLmx3+E56mnLGhl
   mJQtP9GD/oIZSBv2qWwHtnTR8WycxDa1RyFslJV2dHpBcV7LF0RmWR2zT
   Nfhoa56FFGhPfVZ08FGiQoqvEk0VUDGPygEHcpoXLtJK6FDXpXQXnKexM
   wTSiOpVQzTNhTm6Q+isfLoH/RrD5xC8JHcwDXn2B/za0UHdKcO9Fv5RWI
   OPaH1fyNj09Egop2DA6E+fwvoi6+z03+61HxyY5QEJRS2pEe/gNEncswx
   47O75csdCNge+Arzyzf1Qs9TgreCDzXtZPs0Mfm2LG5r3Ui8YDuXTBIag
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="423309336"
X-IronPort-AV: E=Sophos;i="6.00,227,1681196400"; 
   d="scan'208";a="423309336"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 14:08:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="660533664"
X-IronPort-AV: E=Sophos;i="6.00,227,1681196400"; 
   d="scan'208";a="660533664"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 08 Jun 2023 14:08:40 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q7Ms3-0008Ga-1K;
        Thu, 08 Jun 2023 21:08:39 +0000
Date:   Fri, 9 Jun 2023 05:08:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, jacopo.mondi@ideasonboard.com,
        laurent.pinchart@ideasonboard.com, martin.hecht@avnet.eu,
        michael.roeder@avnet.eu, linuxfancy@googlegroups.com,
        Tommaso Merciai <tomm.merciai@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Gerald Loacker <gerald.loacker@wolfvision.net>,
        Nicholas Roth <nicholas@rothemail.net>,
        Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        Mikhail Rudenko <mike.rudenko@gmail.com>,
        Shawn Tu <shawnx.tu@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/3] media: i2c: Add support for alvium camera
Message-ID: <202306090401.jEkSrYuJ-lkp@intel.com>
References: <20230608083127.545750-4-tomm.merciai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230608083127.545750-4-tomm.merciai@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tommaso,

kernel test robot noticed the following build warnings:

[auto build test WARNING on media-tree/master]
[also build test WARNING on robh/for-next linus/master v6.4-rc5 next-20230608]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Tommaso-Merciai/dt-bindings-vendor-prefixes-Add-prefix-alliedvision/20230608-163423
base:   git://linuxtv.org/media_tree.git master
patch link:    https://lore.kernel.org/r/20230608083127.545750-4-tomm.merciai%40gmail.com
patch subject: [PATCH v5 3/3] media: i2c: Add support for alvium camera
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20230609/202306090401.jEkSrYuJ-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 12.3.0
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add media-tree git://linuxtv.org/media_tree.git
        git fetch media-tree master
        git checkout media-tree/master
        b4 shazam https://lore.kernel.org/r/20230608083127.545750-4-tomm.merciai@gmail.com
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=alpha olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=alpha SHELL=/bin/bash drivers/media/i2c/

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306090401.jEkSrYuJ-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/media/i2c/alvium-csi2.c: In function 'alvium_get_dt_data':
>> drivers/media/i2c/alvium-csi2.c:3245:13: warning: variable 'ret' set but not used [-Wunused-but-set-variable]
    3245 |         int ret = 0;
         |             ^~~


vim +/ret +3245 drivers/media/i2c/alvium-csi2.c

  3239	
  3240	static int alvium_get_dt_data(struct alvium_dev *alvium)
  3241	{
  3242		struct device *dev = &alvium->i2c_client->dev;
  3243		struct device_node *node = dev->of_node;
  3244		struct fwnode_handle *endpoint;
> 3245		int ret = 0;
  3246	
  3247		if (!node)
  3248			return -EINVAL;
  3249	
  3250		ret = fwnode_property_read_u32(dev_fwnode(dev),
  3251				  "alliedvision,lp2hs-delay-us",
  3252				  &alvium->lp2hs_delay);
  3253	
  3254		endpoint = fwnode_graph_get_next_endpoint(dev_fwnode(dev), NULL);
  3255		if (!endpoint) {
  3256			dev_err(dev, "endpoint node not found\n");
  3257			return -EINVAL;
  3258		}
  3259	
  3260		if (v4l2_fwnode_endpoint_alloc_parse(endpoint, &alvium->ep)) {
  3261			dev_err(dev, "could not parse endpoint\n");
  3262			return 0;
  3263		}
  3264	
  3265		if (alvium->ep.bus_type != V4L2_MBUS_CSI2_DPHY) {
  3266			dev_err(dev, "unsupported bus type\n");
  3267			return -EINVAL;
  3268		}
  3269	
  3270		if (!alvium->ep.nr_of_link_frequencies) {
  3271			dev_err(dev, "no link frequencies defined");
  3272			return -EINVAL;
  3273		}
  3274	
  3275		dev_info(dev, "freq: %llu\n",
  3276					    alvium->ep.link_frequencies[0]);
  3277		dev_info(dev, "lanes: %d\n",
  3278					    alvium->ep.bus.mipi_csi2.num_data_lanes);
  3279	
  3280		return 0;
  3281	}
  3282	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
