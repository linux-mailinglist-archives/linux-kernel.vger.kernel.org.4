Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A80B3716F41
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 22:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbjE3U5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 16:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjE3U5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 16:57:52 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9EFAC9;
        Tue, 30 May 2023 13:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685480270; x=1717016270;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9bNOXk/HVApVPX4X1SAT6PoKY5ux32Fki/nfbA/DCTk=;
  b=LH4zwNsCEV/fApByIF5ByXYY4T7yuvpxPwQZFQ4+FGdiS5S+35BHf1gJ
   6A+ReJqMRHwgpvlCP8Nc7k00A5nfbdsjePzsW+QfYDO1s4MQP06cg1ZK6
   VcAJuo15OlFKQKMf2BvSkWxJm4yqUPPXyGLeGJmNtxzhzTclml46GVpAf
   rI9miFARwdmV7gus+RuEE9AXhZiGE18e2ZPcDnSgoL343qWGmxXH5RR3W
   sxxgzX99gcEAfCFX/uoyXovscmJ9smlZ3pmxbBZIyUAG3cRfIPmDU0rZV
   qSxj4bXsY5/sCceRGgw6p3RKppLCT2s4SDtrwouUvZMdzCjh91IuRMATc
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="383306545"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="383306545"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 13:57:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="706588497"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="706588497"
Received: from lkp-server01.sh.intel.com (HELO fb1ced2c09fb) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 30 May 2023 13:57:43 -0700
Received: from kbuild by fb1ced2c09fb with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q46PX-0000o3-2E;
        Tue, 30 May 2023 20:57:43 +0000
Date:   Wed, 31 May 2023 04:56:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        jacopo.mondi@ideasonboard.com, laurent.pinchart@ideasonboard.com,
        martin.hecht@avnet.eu, linuxfancy@googlegroups.com,
        Tommaso Merciai <tomm.merciai@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Gerald Loacker <gerald.loacker@wolfvision.net>,
        Nicholas Roth <nicholas@rothemail.net>,
        Shawn Tu <shawnx.tu@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] media: i2c: Add support for alvium camera
Message-ID: <202305310436.Hwvw8IB9-lkp@intel.com>
References: <20230526173955.797226-3-tomm.merciai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230526173955.797226-3-tomm.merciai@gmail.com>
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

Hi Tommaso,

kernel test robot noticed the following build warnings:

[auto build test WARNING on media-tree/master]
[also build test WARNING on linus/master v6.4-rc4 next-20230530]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Tommaso-Merciai/media-dt-bindings-alvium-add-document-YAML-binding/20230527-014222
base:   git://linuxtv.org/media_tree.git master
patch link:    https://lore.kernel.org/r/20230526173955.797226-3-tomm.merciai%40gmail.com
patch subject: [PATCH v2 2/2] media: i2c: Add support for alvium camera
config: x86_64-allmodconfig (https://download.01.org/0day-ci/archive/20230531/202305310436.Hwvw8IB9-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/0777ad1510dd41fdb7f183ade7607af6b2fe36a8
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Tommaso-Merciai/media-dt-bindings-alvium-add-document-YAML-binding/20230527-014222
        git checkout 0777ad1510dd41fdb7f183ade7607af6b2fe36a8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=x86_64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/media/i2c/ fs/xfs/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202305310436.Hwvw8IB9-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/media/i2c/alvium.c:559:6: warning: no previous prototype for function 'alvium_print_avail_mipi_fmt' [-Wmissing-prototypes]
   void alvium_print_avail_mipi_fmt(struct alvium_dev *alvium)
        ^
   drivers/media/i2c/alvium.c:559:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void alvium_print_avail_mipi_fmt(struct alvium_dev *alvium)
   ^
   static 
>> drivers/media/i2c/alvium.c:603:6: warning: no previous prototype for function 'alvium_print_avail_feat' [-Wmissing-prototypes]
   void alvium_print_avail_feat(struct alvium_dev *alvium)
        ^
   drivers/media/i2c/alvium.c:603:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void alvium_print_avail_feat(struct alvium_dev *alvium)
   ^
   static 
>> drivers/media/i2c/alvium.c:647:6: warning: no previous prototype for function 'alvium_print_avail_bayer' [-Wmissing-prototypes]
   void alvium_print_avail_bayer(struct alvium_dev *alvium)
        ^
   drivers/media/i2c/alvium.c:647:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void alvium_print_avail_bayer(struct alvium_dev *alvium)
   ^
   static 
>> drivers/media/i2c/alvium.c:1957:2: warning: switch condition has boolean value [-Wswitch-bool]
           switch (on) {
           ^       ~~
   drivers/media/i2c/alvium.c:2040:2: warning: switch condition has boolean value [-Wswitch-bool]
           switch (on) {
           ^       ~~
   drivers/media/i2c/alvium.c:2099:2: warning: switch condition has boolean value [-Wswitch-bool]
           switch (on) {
           ^       ~~
   drivers/media/i2c/alvium.c:2228:2: warning: switch condition has boolean value [-Wswitch-bool]
           switch (on) {
           ^       ~~
   drivers/media/i2c/alvium.c:2303:7: warning: variable 'red_max' set but not used [-Wunused-but-set-variable]
                   u64 red_max;
                       ^
   drivers/media/i2c/alvium.c:2304:7: warning: variable 'red_min' set but not used [-Wunused-but-set-variable]
                   u64 red_min;
                       ^
   drivers/media/i2c/alvium.c:2305:7: warning: variable 'blue_max' set but not used [-Wunused-but-set-variable]
                   u64 blue_max;
                       ^
   drivers/media/i2c/alvium.c:2306:7: warning: variable 'blue_min' set but not used [-Wunused-but-set-variable]
                   u64 blue_min;
                       ^
   drivers/media/i2c/alvium.c:2721:14: warning: variable 'min_fr' set but not used [-Wunused-but-set-variable]
           u64 req_fr, min_fr, max_fr;
                       ^
   drivers/media/i2c/alvium.c:2721:22: warning: variable 'max_fr' set but not used [-Wunused-but-set-variable]
           u64 req_fr, min_fr, max_fr;
                               ^
>> drivers/media/i2c/alvium.c:2788:6: warning: variable 'num_formats' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
           if (alvium_is_csi2(alvium)) {
               ^~~~~~~~~~~~~~~~~~~~~~
   drivers/media/i2c/alvium.c:2793:21: note: uninitialized use occurs here
           if (code->index >= num_formats)
                              ^~~~~~~~~~~
   drivers/media/i2c/alvium.c:2788:2: note: remove the 'if' if its condition is always true
           if (alvium_is_csi2(alvium)) {
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/media/i2c/alvium.c:2786:26: note: initialize the variable 'num_formats' to silence this warning
           unsigned int num_formats;
                                   ^
                                    = 0
   drivers/media/i2c/alvium.c:2943:26: warning: variable 'crop' set but not used [-Wunused-but-set-variable]
           const struct v4l2_rect *crop;
                                   ^
   15 warnings generated.


vim +/alvium_print_avail_mipi_fmt +559 drivers/media/i2c/alvium.c

   558	
 > 559	void alvium_print_avail_mipi_fmt(struct alvium_dev *alvium)
   560	{
   561		struct device *dev = &alvium->i2c_client->dev;
   562	
   563		dev_dbg(dev, "avail mipi_fmt yuv420_8_leg: %u\n",
   564			  alvium->is_mipi_fmt_avail[ALVIUM_BIT_YUV420_8_LEG]);
   565		dev_dbg(dev, "avail mipi_fmt yuv420_8: %u\n",
   566			   alvium->is_mipi_fmt_avail[ALVIUM_BIT_YUV420_8]);
   567		dev_dbg(dev, "avail mipi_fmt yuv420_10: %u\n",
   568			  alvium->is_mipi_fmt_avail[ALVIUM_BIT_YUV420_10]);
   569		dev_dbg(dev, "avail mipi_fmt yuv420_8_csps: %u\n",
   570			  alvium->is_mipi_fmt_avail[ALVIUM_BIT_YUV420_8_CSPS]);
   571		dev_dbg(dev, "avail mipi_fmt yuv420_10_csps: %u\n",
   572			  alvium->is_mipi_fmt_avail[ALVIUM_BIT_YUV420_10_CSPS]);
   573		dev_dbg(dev, "avail mipi_fmt yuv422_8: %u\n",
   574			  alvium->is_mipi_fmt_avail[ALVIUM_BIT_YUV422_8]);
   575		dev_dbg(dev, "avail mipi_fmt yuv422_10: %u\n",
   576			   alvium->is_mipi_fmt_avail[ALVIUM_BIT_YUV422_10]);
   577		dev_dbg(dev, "avail mipi_fmt rgb888: %u\n",
   578			   alvium->is_mipi_fmt_avail[ALVIUM_BIT_RGB888]);
   579		dev_dbg(dev, "avail mipi_fmt rgb666: %u\n",
   580			  alvium->is_mipi_fmt_avail[ALVIUM_BIT_RGB666]);
   581		dev_dbg(dev, "avail mipi_fmt rgb565: %u\n",
   582			  alvium->is_mipi_fmt_avail[ALVIUM_BIT_RGB565]);
   583		dev_dbg(dev, "avail mipi_fmt rgb555: %u\n",
   584			  alvium->is_mipi_fmt_avail[ALVIUM_BIT_RGB555]);
   585		dev_dbg(dev, "avail mipi_fmt rgb444: %u\n",
   586			  alvium->is_mipi_fmt_avail[ALVIUM_BIT_RGB444]);
   587		dev_dbg(dev, "avail mipi_fmt raw6: %u\n",
   588			  alvium->is_mipi_fmt_avail[ALVIUM_BIT_RAW6]);
   589		dev_dbg(dev, "avail mipi_fmt raw7: %u\n",
   590			  alvium->is_mipi_fmt_avail[ALVIUM_BIT_RAW7]);
   591		dev_dbg(dev, "avail mipi_fmt raw8: %u\n",
   592			  alvium->is_mipi_fmt_avail[ALVIUM_BIT_RAW8]);
   593		dev_dbg(dev, "avail mipi_fmt raw10: %u\n",
   594			  alvium->is_mipi_fmt_avail[ALVIUM_BIT_RAW10]);
   595		dev_dbg(dev, "avail mipi_fmt raw12: %u\n",
   596			  alvium->is_mipi_fmt_avail[ALVIUM_BIT_RAW12]);
   597		dev_dbg(dev, "avail mipi_fmt raw14: %u\n",
   598			  alvium->is_mipi_fmt_avail[ALVIUM_BIT_RAW14]);
   599		dev_dbg(dev, "avail mipi_fmt jpeg: %u\n",
   600			  alvium->is_mipi_fmt_avail[ALVIUM_BIT_JPEG]);
   601	}
   602	
 > 603	void alvium_print_avail_feat(struct alvium_dev *alvium)
   604	{
   605		struct device *dev = &alvium->i2c_client->dev;
   606	
   607		dev_dbg(dev, "feature rev_x: %u\n",
   608			  alvium->avail_ft.rev_x);
   609		dev_dbg(dev, "feature rev_y: %u\n",
   610			  alvium->avail_ft.rev_y);
   611		dev_dbg(dev, "feature int_autop: %u\n",
   612			  alvium->avail_ft.int_autop);
   613		dev_dbg(dev, "feature black_lvl: %u\n",
   614			  alvium->avail_ft.black_lvl);
   615		dev_dbg(dev, "feature gain: %u\n",
   616			  alvium->avail_ft.gain);
   617		dev_dbg(dev, "feature gamma: %u\n",
   618			  alvium->avail_ft.gamma);
   619		dev_dbg(dev, "feature contrast: %u\n",
   620			  alvium->avail_ft.contrast);
   621		dev_dbg(dev, "feature sat: %u\n",
   622			  alvium->avail_ft.sat);
   623		dev_dbg(dev, "feature hue: %u\n",
   624			  alvium->avail_ft.hue);
   625		dev_dbg(dev, "feature whiteb: %u\n",
   626			  alvium->avail_ft.whiteb);
   627		dev_dbg(dev, "feature sharp: %u\n",
   628			  alvium->avail_ft.sharp);
   629		dev_dbg(dev, "feature auto_exp: %u\n",
   630			  alvium->avail_ft.auto_exp);
   631		dev_dbg(dev, "feature auto_gain: %u\n",
   632			  alvium->avail_ft.auto_gain);
   633		dev_dbg(dev, "feature auto_whiteb: %u\n",
   634			  alvium->avail_ft.auto_whiteb);
   635		dev_dbg(dev, "feature dev_temp: %u\n",
   636			  alvium->avail_ft.dev_temp);
   637		dev_dbg(dev, "feature acq_abort: %u\n",
   638			  alvium->avail_ft.acq_abort);
   639		dev_dbg(dev, "feature acq_fr: %u\n",
   640			  alvium->avail_ft.acq_fr);
   641		dev_dbg(dev, "feature fr_trigger: %u\n",
   642			  alvium->avail_ft.fr_trigger);
   643		dev_dbg(dev, "feature exp_acq_line: %u\n",
   644			  alvium->avail_ft.exp_acq_line);
   645	}
   646	
 > 647	void alvium_print_avail_bayer(struct alvium_dev *alvium)
   648	{
   649		struct device *dev = &alvium->i2c_client->dev;
   650	
   651		dev_dbg(dev, "avail bayer mono: %u\n",
   652			  alvium->is_bay_avail[ALVIUM_BIT_BAY_MONO]);
   653		dev_dbg(dev, "avail bayer gr: %u\n",
   654			  alvium->is_bay_avail[ALVIUM_BIT_BAY_GR]);
   655		dev_dbg(dev, "avail bayer rg: %u\n",
   656			  alvium->is_bay_avail[ALVIUM_BIT_BAY_RG]);
   657		dev_dbg(dev, "avail bayer gb: %u\n",
   658			  alvium->is_bay_avail[ALVIUM_BIT_BAY_GB]);
   659		dev_dbg(dev, "avail bayer bg: %u\n",
   660			  alvium->is_bay_avail[ALVIUM_BIT_BAY_BG]);
   661	}
   662	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
