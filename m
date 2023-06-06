Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3764A725086
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 01:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240195AbjFFXN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 19:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234333AbjFFXN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 19:13:26 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E1F10C3;
        Tue,  6 Jun 2023 16:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686093205; x=1717629205;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nOLTJSibPiFMfr8fOq4c8i0FSHh1V58oiSrkFHPtWLI=;
  b=iLR+ridN9UTiu4C3YV021jdMQ1d6CuojAykf9zk4byzVhZtN0a0Aczdv
   pi+PJYLdvFO5MMac3boomigkldt8KsApo2QLawJ7Hoo2G5iQ3J9zMxy8Z
   GUUxOn6ecOKLI+z9uOyL2IHVqjVkfWOV/5/kA9z4+9C2WKwIYlRQkCXf/
   laCiHH6bx0YF+JqfjsOxAhiNPWmyAvmiTIPH16BmiBDk7oVRVAvG4XsYF
   3OJnEfMuoUiP/3p4V7LxpsuGOXeeRUA7FBH1CROdsNxYKK4ozaT93UBk0
   OHgbDxfat1LujvVIS0lY9JSACXNevtMAwfnk40vYVcWAM8/wAd5aY4ZC0
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="346430673"
X-IronPort-AV: E=Sophos;i="6.00,222,1681196400"; 
   d="scan'208";a="346430673"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 16:13:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="799063751"
X-IronPort-AV: E=Sophos;i="6.00,222,1681196400"; 
   d="scan'208";a="799063751"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 06 Jun 2023 16:13:19 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q6fra-0005qU-25;
        Tue, 06 Jun 2023 23:13:18 +0000
Date:   Wed, 7 Jun 2023 07:12:58 +0800
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
        Shawn Tu <shawnx.tu@intel.com>,
        Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mikhail Rudenko <mike.rudenko@gmail.com>,
        Nicholas Roth <nicholas@rothemail.net>,
        Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] media: i2c: Add support for alvium camera
Message-ID: <202306070716.28K0H9Jd-lkp@intel.com>
References: <20230606155416.260941-4-tomm.merciai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606155416.260941-4-tomm.merciai@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tommaso,

kernel test robot noticed the following build warnings:

[auto build test WARNING on media-tree/master]
[also build test WARNING on robh/for-next linus/master v6.4-rc5 next-20230606]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Tommaso-Merciai/dt-bindings-vendor-prefixes-Add-prefix-alliedvision/20230606-235632
base:   git://linuxtv.org/media_tree.git master
patch link:    https://lore.kernel.org/r/20230606155416.260941-4-tomm.merciai%40gmail.com
patch subject: [PATCH v3 3/3] media: i2c: Add support for alvium camera
config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20230607/202306070716.28K0H9Jd-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 12.3.0
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add media-tree git://linuxtv.org/media_tree.git
        git fetch media-tree master
        git checkout media-tree/master
        b4 shazam https://lore.kernel.org/r/20230606155416.260941-4-tomm.merciai@gmail.com
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=mips olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/media/i2c/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306070716.28K0H9Jd-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/media/i2c/alvium-csi2.c: In function 'alvium_set_ctrl_white_balance':
>> drivers/media/i2c/alvium-csi2.c:2205:21: warning: variable 'blue_min' set but not used [-Wunused-but-set-variable]
    2205 |                 u64 blue_min;
         |                     ^~~~~~~~
>> drivers/media/i2c/alvium-csi2.c:2204:21: warning: variable 'blue_max' set but not used [-Wunused-but-set-variable]
    2204 |                 u64 blue_max;
         |                     ^~~~~~~~
>> drivers/media/i2c/alvium-csi2.c:2203:21: warning: variable 'red_min' set but not used [-Wunused-but-set-variable]
    2203 |                 u64 red_min;
         |                     ^~~~~~~
>> drivers/media/i2c/alvium-csi2.c:2202:21: warning: variable 'red_max' set but not used [-Wunused-but-set-variable]
    2202 |                 u64 red_max;
         |                     ^~~~~~~
   drivers/media/i2c/alvium-csi2.c: In function 'alvium_set_frame_interval':
>> drivers/media/i2c/alvium-csi2.c:2574:29: warning: variable 'max_fr' set but not used [-Wunused-but-set-variable]
    2574 |         u64 req_fr, min_fr, max_fr;
         |                             ^~~~~~
>> drivers/media/i2c/alvium-csi2.c:2574:21: warning: variable 'min_fr' set but not used [-Wunused-but-set-variable]
    2574 |         u64 req_fr, min_fr, max_fr;
         |                     ^~~~~~
   drivers/media/i2c/alvium-csi2.c: In function 'alvium_subdev_init':
>> drivers/media/i2c/alvium-csi2.c:3172:27: warning: variable 'crop' set but not used [-Wunused-but-set-variable]
    3172 |         struct v4l2_rect *crop;
         |                           ^~~~
>> drivers/media/i2c/alvium-csi2.c:3171:36: warning: variable 'fmt' set but not used [-Wunused-but-set-variable]
    3171 |         struct v4l2_mbus_framefmt *fmt;
         |                                    ^~~


vim +/blue_min +2205 drivers/media/i2c/alvium-csi2.c

  2186	
  2187	static int alvium_set_ctrl_white_balance(struct alvium_dev *alvium,
  2188					    bool awb)
  2189	{
  2190		struct alvium_ctrls *ctrls = &alvium->ctrls;
  2191		int ret = 0;
  2192	
  2193		if (ctrls->auto_wb->is_new) {
  2194			ret = alvium_set_awb(alvium, awb);
  2195			if (ret)
  2196				return ret;
  2197		}
  2198	
  2199		if (!awb && ctrls->auto_wb->is_new) {
  2200			u64 red = (u64)ctrls->red_balance->val;
  2201			u64 blue = (u64)ctrls->blue_balance->val;
> 2202			u64 red_max;
> 2203			u64 red_min;
> 2204			u64 blue_max;
> 2205			u64 blue_min;
  2206	
  2207			ret = alvium_get_red_balance_ratio_params(alvium);
  2208			if (ret)
  2209				return ret;
  2210	
  2211			ret = alvium_get_blue_balance_ratio_params(alvium);
  2212			if (ret)
  2213				return ret;
  2214	
  2215			red_max = alvium->max_rbalance;
  2216			red_min = alvium->min_rbalance;
  2217			blue_max = alvium->max_bbalance;
  2218			blue_min = alvium->min_rbalance;
  2219	
  2220			ret = alvium_set_red_balance_ratio(alvium, red);
  2221			if (ret)
  2222				return ret;
  2223	
  2224			ret = alvium_set_blue_balance_ratio(alvium, blue);
  2225			if (ret)
  2226				return ret;
  2227		}
  2228	
  2229		return ret;
  2230	}
  2231	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
