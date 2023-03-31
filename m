Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C33096D22C3
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 16:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232754AbjCaOi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 10:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232401AbjCaOi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 10:38:56 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC8A1D91B;
        Fri, 31 Mar 2023 07:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680273535; x=1711809535;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=s4bXc6SA5sSnGSuRn29n954qgJk/hR6Pf1DFYwbffoE=;
  b=hwik/fcREj0ZGGwJSjextlR7JszmDnJ7gDrkfvBz5zxa5sZgRM6g8vgw
   dwheRx2VKUhYIHmfTN80jtVyWQl5ciuK1XjEdUnGmLsQbx3TX/RB29706
   E5iOsoBynpw1GU4nCk8ddpWZXsSKCKqMXuoASodmGHMCqp9MutMZtNX4r
   gvHY7bNxkFjAr6AIKT0j6zQgZ49S8pmGmYvNSx6dSqaSiEc0M7yiey3K7
   ADoULqNxgUkJFcu0NsSL1kglpYka7V6EMC7cLRRpoxSLzflzlHysUxwkS
   POqAlqktSA5/FIz1JtZMsh+rXXJX5vEkM9NyMYuhBD6MP5hETFuTyY+Tk
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="343128147"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="343128147"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2023 07:38:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="859349319"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="859349319"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 31 Mar 2023 07:38:47 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1piFtp-000Ls4-38;
        Fri, 31 Mar 2023 14:38:41 +0000
Date:   Fri, 31 Mar 2023 22:38:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jack Zhu <jack.zhu@starfivetech.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Eugen Hristev <eugen.hristev@collabora.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack.zhu@starfivetech.com, changhuang.liang@starfivetech.com
Subject: Re: [PATCH v3 9/9] media: starfive: Add Starfive Camera Subsystem
 driver
Message-ID: <202303312218.LXqt9wcT-lkp@intel.com>
References: <20230331121826.96973-10-jack.zhu@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230331121826.96973-10-jack.zhu@starfivetech.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jack,

I love your patch! Perhaps something to improve:

[auto build test WARNING on media-tree/master]
[also build test WARNING on robh/for-next linus/master v6.3-rc4 next-20230331]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jack-Zhu/media-dt-bindings-Add-bindings-for-JH7110-Camera-Subsystem/20230331-202001
base:   git://linuxtv.org/media_tree.git master
patch link:    https://lore.kernel.org/r/20230331121826.96973-10-jack.zhu%40starfivetech.com
patch subject: [PATCH v3 9/9] media: starfive: Add Starfive Camera Subsystem driver
config: sparc-allyesconfig (https://download.01.org/0day-ci/archive/20230331/202303312218.LXqt9wcT-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/421adbf9815b633e8bac5da7146c33aac01e283c
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jack-Zhu/media-dt-bindings-Add-bindings-for-JH7110-Camera-Subsystem/20230331-202001
        git checkout 421adbf9815b633e8bac5da7146c33aac01e283c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sparc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sparc SHELL=/bin/bash drivers/media/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303312218.LXqt9wcT-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/media/platform/starfive/stf_camss.c:41:5: warning: no previous prototype for 'stfcamss_get_mem_res' [-Wmissing-prototypes]
      41 | int stfcamss_get_mem_res(struct platform_device *pdev,
         |     ^~~~~~~~~~~~~~~~~~~~
--
>> drivers/media/platform/starfive/stf_isp.c:627:5: warning: no previous prototype for 'isp_close' [-Wmissing-prototypes]
     627 | int isp_close(struct v4l2_subdev *sd, struct v4l2_subdev_fh *fh)
         |     ^~~~~~~~~
--
   drivers/media/platform/starfive/stf_vin.c: In function 'stf_vin_map_isp_pad':
>> drivers/media/platform/starfive/stf_vin.c:99:24: warning: implicit conversion from 'enum isp_line_id' to 'enum isp_pad_id' [-Wenum-conversion]
      99 |                 pad_id = vin_map_isp_line(line);
         |                        ^
   drivers/media/platform/starfive/stf_vin.c: In function 'vin_output_init_addrs':
>> drivers/media/platform/starfive/stf_vin.c:683:20: warning: variable 'pong_addr' set but not used [-Wunused-but-set-variable]
     683 |         dma_addr_t pong_addr;
         |                    ^~~~~~~~~
   drivers/media/platform/starfive/stf_vin.c: At top level:
   drivers/media/platform/starfive/stf_vin.c:33:32: warning: 'vin_formats_raw' defined but not used [-Wunused-const-variable=]
      33 | static const struct vin_format vin_formats_raw[] = {
         |                                ^~~~~~~~~~~~~~~


vim +/stfcamss_get_mem_res +41 drivers/media/platform/starfive/stf_camss.c

    40	
  > 41	int stfcamss_get_mem_res(struct platform_device *pdev,
    42				 struct stfcamss *stfcamss)
    43	{
    44		stfcamss->syscon_base =
    45			devm_platform_ioremap_resource_byname(pdev, "syscon");
    46		if (IS_ERR(stfcamss->syscon_base))
    47			return PTR_ERR(stfcamss->syscon_base);
    48	
    49		stfcamss->isp_base =
    50			devm_platform_ioremap_resource_byname(pdev, "isp");
    51		if (IS_ERR(stfcamss->isp_base))
    52			return PTR_ERR(stfcamss->isp_base);
    53	
    54		return 0;
    55	}
    56	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
