Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CADA25B51A1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 00:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbiIKWw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 18:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiIKWwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 18:52:17 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031C01F634;
        Sun, 11 Sep 2022 15:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662936737; x=1694472737;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Kj7mYbX4yVVcAAOExUh5U30pQ5CvHnAmOFRbujPkmJA=;
  b=BmHnTcl6zIWOy9zk8+ksXpFjmQzlUrSius2yz3wHYy35MmSjG5w0y+14
   HUuMkC5aYvquEVVeU6WU1Whu1t16qxU4P8CQU3j1XbJ7ZBfRyyw6eQQ+T
   7UOSXAmV2NHeS02Boa64x8H0OuxVGjlItT/JfrHteJl2dEvwWA2ASPaWu
   yovp0+hLP1AC4sd35uT712ZyDGDblrBZmCapWbsHluO/8kGvQV5fAfW8g
   1QtXjur2mF3ebPLgUq6Une99mCA8/1+xct3gJPebqHsiFoNC4jLlyj1H+
   y4qli7UXml6UauqQ2oj5GcJgUFg+dnrNGeZ1Mtlujtu5xuCZQPcbIxhAV
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10467"; a="323984531"
X-IronPort-AV: E=Sophos;i="5.93,308,1654585200"; 
   d="scan'208";a="323984531"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2022 15:52:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,308,1654585200"; 
   d="scan'208";a="791367928"
Received: from lkp-server02.sh.intel.com (HELO 4011df4f4fd3) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 11 Sep 2022 15:52:12 -0700
Received: from kbuild by 4011df4f4fd3 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oXVoC-0001vb-0U;
        Sun, 11 Sep 2022 22:52:12 +0000
Date:   Mon, 12 Sep 2022 06:52:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mikhail Rudenko <mike.rudenko@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Shawn Tu <shawnx.tu@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Daniel Scally <djrscally@gmail.com>,
        Christian Hemp <c.hemp@phytec.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Marek Vasut <marex@denx.de>
Cc:     kbuild-all@lists.01.org, linux-media@vger.kernel.org,
        Mikhail Rudenko <mike.rudenko@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] media: i2c: add support for ov4689
Message-ID: <202209120637.Ypw3tniN-lkp@intel.com>
References: <20220911200147.375198-3-mike.rudenko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220911200147.375198-3-mike.rudenko@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mikhail,

I love your patch! Perhaps something to improve:

[auto build test WARNING on media-tree/master]
[also build test WARNING on robh/for-next krzk-dt/for-next linus/master v6.0-rc5 next-20220909]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mikhail-Rudenko/Add-Omnivision-OV4689-image-sensor-driver/20220912-040337
base:   git://linuxtv.org/media_tree.git master
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220912/202209120637.Ypw3tniN-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/7c4d2965802d2be20badfef953b1d6f0d13d718f
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Mikhail-Rudenko/Add-Omnivision-OV4689-image-sensor-driver/20220912-040337
        git checkout 7c4d2965802d2be20badfef953b1d6f0d13d718f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/media/i2c/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/media/i2c/ov4689.c:112:28: warning: 'ov4689_global_regs' defined but not used [-Wunused-const-variable=]
     112 | static const struct regval ov4689_global_regs[] = {
         |                            ^~~~~~~~~~~~~~~~~~


vim +/ov4689_global_regs +112 drivers/media/i2c/ov4689.c

   108	
   109	/*
   110	 * Xclk 24Mhz
   111	 */
 > 112	static const struct regval ov4689_global_regs[] = {
   113		{ REG_NULL, 0x00 },
   114	};
   115	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
