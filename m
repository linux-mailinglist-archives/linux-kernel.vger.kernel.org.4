Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 685F67369F8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 12:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232375AbjFTKyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 06:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbjFTKyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 06:54:17 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 701F1EB;
        Tue, 20 Jun 2023 03:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687258456; x=1718794456;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HgZTP1ifqliGLcrDZAPslIVfdfmKgsYp1Imd3aU1icU=;
  b=IcHQvsxwSUeK1jhQ4XGC4RNssuP1cFpT90s08bho+9rjBi5Bkb1g12SD
   khsoYztA+EC4k4UH7UsLMz1h//0wOlhyXbOwY4yPsPdEyPj2qgzkRI2Zd
   2vYgEzbc+ZKsH70E+A+Jn7Fb5KEzj8/Skj4JmVN76YVkrGQaNuZlt/2MG
   hezQ5e8FcvSqYMPlayQdHE6ho5Nomgmx1ixBKvjKxNVc6LlNDNIPARhdj
   EOz4BL2rZOK3VDE7nfxRkSI5ZByyYfXE2DYLvq7Lvl+07MUesJMzNj3ub
   pg5N3eYyi2tGJse/6nt6JblR0Z39kuEVCQcZrPmKhAH01kAVsXv2tz6Df
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="339438046"
X-IronPort-AV: E=Sophos;i="6.00,256,1681196400"; 
   d="scan'208";a="339438046"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 03:54:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="784028380"
X-IronPort-AV: E=Sophos;i="6.00,256,1681196400"; 
   d="scan'208";a="784028380"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 20 Jun 2023 03:54:12 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qBYzz-0005pI-3D;
        Tue, 20 Jun 2023 10:54:11 +0000
Date:   Tue, 20 Jun 2023 18:53:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc:     oe-kbuild-all@lists.linux.dev, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/5] media: platform: visconti: Add Toshiba Visconti
 Video Input Interface driver
Message-ID: <202306201839.92EOK4H7-lkp@intel.com>
References: <20230620031111.3776-3-yuji2.ishikawa@toshiba.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620031111.3776-3-yuji2.ishikawa@toshiba.co.jp>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yuji,

kernel test robot noticed the following build warnings:

[auto build test WARNING on media-tree/master]
[also build test WARNING on linus/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yuji-Ishikawa/dt-bindings-media-platform-visconti-Add-Toshiba-Visconti-Video-Input-Interface-bindings/20230620-120839
base:   git://linuxtv.org/media_tree.git master
patch link:    https://lore.kernel.org/r/20230620031111.3776-3-yuji2.ishikawa%40toshiba.co.jp
patch subject: [PATCH v6 2/5] media: platform: visconti: Add Toshiba Visconti Video Input Interface driver
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20230620/202306201839.92EOK4H7-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230620/202306201839.92EOK4H7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306201839.92EOK4H7-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/media/platform/toshiba/visconti/viif.c:182:6: warning: no previous prototype for 'visconti_viif_hw_on' [-Wmissing-prototypes]
     182 | void visconti_viif_hw_on(struct viif_device *viif_dev)
         |      ^~~~~~~~~~~~~~~~~~~
>> drivers/media/platform/toshiba/visconti/viif.c:190:6: warning: no previous prototype for 'visconti_viif_hw_off' [-Wmissing-prototypes]
     190 | void visconti_viif_hw_off(struct viif_device *viif_dev)
         |      ^~~~~~~~~~~~~~~~~~~~
   drivers/media/platform/toshiba/visconti/viif.c: In function 'visconti_viif_probe':
>> drivers/media/platform/toshiba/visconti/viif.c:500:36: warning: variable 'of_id' set but not used [-Wunused-but-set-variable]
     500 |         const struct of_device_id *of_id;
         |                                    ^~~~~
--
>> drivers/media/platform/toshiba/visconti/viif_capture.c:604:6: warning: no previous prototype for 'visconti_viif_capture_switch_buffer' [-Wmissing-prototypes]
     604 | void visconti_viif_capture_switch_buffer(struct cap_dev *cap_dev, u32 status_err,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/media/platform/toshiba/visconti/viif_capture.c:1325:5: warning: no previous prototype for 'visconti_viif_capture_register_ctrl_handlers' [-Wmissing-prototypes]
    1325 | int visconti_viif_capture_register_ctrl_handlers(struct viif_device *viif_dev)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/media/platform/toshiba/visconti/viif_capture.c:1434:5: warning: no previous prototype for 'visconti_viif_capture_register' [-Wmissing-prototypes]
    1434 | int visconti_viif_capture_register(struct viif_device *viif_dev)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/media/platform/toshiba/visconti/viif_capture.c:1476:6: warning: no previous prototype for 'visconti_viif_capture_unregister' [-Wmissing-prototypes]
    1476 | void visconti_viif_capture_unregister(struct viif_device *viif_dev)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
>> drivers/media/platform/toshiba/visconti/viif_isp.c:243:6: warning: no previous prototype for 'visconti_viif_l2_set_roi_path' [-Wmissing-prototypes]
     243 | void visconti_viif_l2_set_roi_path(struct viif_device *viif_dev)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/media/platform/toshiba/visconti/viif_isp.c:254:6: warning: no previous prototype for 'visconti_viif_l2_set_roi' [-Wmissing-prototypes]
     254 | void visconti_viif_l2_set_roi(struct viif_device *viif_dev, const struct viif_l2_roi_config *param)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/media/platform/toshiba/visconti/viif_isp.c:699:5: warning: no previous prototype for 'visconti_viif_isp_main_set_unit' [-Wmissing-prototypes]
     699 | int visconti_viif_isp_main_set_unit(struct viif_device *viif_dev)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/media/platform/toshiba/visconti/viif_isp.c:773:5: warning: no previous prototype for 'visconti_viif_isp_sub_set_unit' [-Wmissing-prototypes]
     773 | int visconti_viif_isp_sub_set_unit(struct viif_device *viif_dev)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/media/platform/toshiba/visconti/viif_isp.c:1177:6: warning: no previous prototype for 'visconti_viif_isp_set_compose_rect' [-Wmissing-prototypes]
    1177 | void visconti_viif_isp_set_compose_rect(struct viif_device *viif_dev,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/media/platform/toshiba/visconti/viif_isp.c:1214:5: warning: no previous prototype for 'visconti_viif_isp_register' [-Wmissing-prototypes]
    1214 | int visconti_viif_isp_register(struct viif_device *viif_dev)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/media/platform/toshiba/visconti/viif_isp.c:1265:6: warning: no previous prototype for 'visconti_viif_isp_unregister' [-Wmissing-prototypes]
    1265 | void visconti_viif_isp_unregister(struct viif_device *viif_dev)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
   drivers/media/platform/toshiba/visconti/viif_isp.c:162: warning: Function parameter or member 'viif_dev' not described in 'viif_l2_set_roi_num_2'
   drivers/media/platform/toshiba/visconti/viif_isp.c:192: warning: Function parameter or member 'viif_dev' not described in 'viif_l2_set_roi_num_1'
   drivers/media/platform/toshiba/visconti/viif_isp.c:244: warning: Function parameter or member 'viif_dev' not described in 'visconti_viif_l2_set_roi_path'
   drivers/media/platform/toshiba/visconti/viif_isp.c:255: warning: Function parameter or member 'viif_dev' not described in 'visconti_viif_l2_set_roi'
   drivers/media/platform/toshiba/visconti/viif_isp.c:255: warning: Function parameter or member 'param' not described in 'visconti_viif_l2_set_roi'
>> drivers/media/platform/toshiba/visconti/viif_isp.c:255: warning: expecting prototype for viif_l2_set_roi(). Prototype was for visconti_viif_l2_set_roi() instead
   drivers/media/platform/toshiba/visconti/viif_isp.c:287: warning: duplicate section name 'Return'
   drivers/media/platform/toshiba/visconti/viif_isp.c:290: warning: Function parameter or member 'viif_dev' not described in 'viif_main_set_unit'
>> drivers/media/platform/toshiba/visconti/viif_isp.c:290: warning: expecting prototype for hwd_viif_main_set_unit(). Prototype was for viif_main_set_unit() instead
   drivers/media/platform/toshiba/visconti/viif_isp.c:482: warning: duplicate section name 'Return'
   drivers/media/platform/toshiba/visconti/viif_isp.c:485: warning: Function parameter or member 'viif_dev' not described in 'viif_sub_set_unit'
   drivers/media/platform/toshiba/visconti/viif_isp.c:538: warning: Function parameter or member 'viif_dev' not described in 'viif_mux_start'
   drivers/media/platform/toshiba/visconti/viif_isp.c:568: warning: duplicate section name 'Return'
   drivers/media/platform/toshiba/visconti/viif_isp.c:570: warning: Function parameter or member 'viif_dev' not described in 'viif_mux_stop'


vim +/visconti_viif_hw_on +182 drivers/media/platform/toshiba/visconti/viif.c

   178	
   179	/*=============================================*/
   180	/* handling V4L2 framework */
   181	/*=============================================*/
 > 182	void visconti_viif_hw_on(struct viif_device *viif_dev)
   183	{
   184		/* Disable MPU */
   185		viif_mpu_disable(viif_dev);
   186		/* Enable HWAIF */
   187		viif_hwaif_enable(viif_dev);
   188	}
   189	
 > 190	void visconti_viif_hw_off(struct viif_device *viif_dev)
   191	{
   192		/* Uninitialize HWD driver */
   193	}
   194	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
