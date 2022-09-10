Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B111E5B4786
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 18:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbiIJQkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 12:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiIJQkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 12:40:15 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 143052CCB6
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 09:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662828014; x=1694364014;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zIp1/EtwLnaGlmoo6cFjWSi3ozzDqKKUwaTubdxavIs=;
  b=n1XEyHuK8Mh+vekQjex495jkAEFsBqBPjUlcd9nrgneMH7ofBTSBt47D
   j8X5D/UinyfrMhlYnrNmZY9b7SQRiq21jqNPuuT/KpJDOwv0LnxyQUn27
   PU75jCZUpWQA6GpL7FKrngp+MB8ZSaZOMEMPK7pIBmTkwVlAZYTAl3SK8
   /6zvnVITcBI20s/nYD8Hp2p5Te6or8KylCRPMcE3uxA6Dy/RU9Fw9GRz2
   w9LqTdT7hhLF8AdFg6BcBlTbRK0e0LYXqYCMl0ByQN9yuldrFDSjVcTIC
   7wCbvLvufzveojW282rilKiaK+AGRkC1kLgTaDIpMOBwSev9vNxH0GKu6
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10466"; a="284673944"
X-IronPort-AV: E=Sophos;i="5.93,306,1654585200"; 
   d="scan'208";a="284673944"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2022 09:40:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,306,1654585200"; 
   d="scan'208";a="757933888"
Received: from lkp-server02.sh.intel.com (HELO 4011df4f4fd3) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 10 Sep 2022 09:40:11 -0700
Received: from kbuild by 4011df4f4fd3 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oX3Wd-0000HY-1E;
        Sat, 10 Sep 2022 16:40:11 +0000
Date:   Sun, 11 Sep 2022 00:39:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [pinchartl-media:streams/v6.0/v11 34/49]
 drivers/media/v4l2-core/v4l2-subdev.c:931:9: error: implicit declaration of
 function 'for_each_active_route'; did you mean 'for_each_active_irq'?
Message-ID: <202209110000.usvZPbyp-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://linuxtv.org/pinchartl/media.git streams/v6.0/v11
head:   c8cf58f00bee6d4f43462b3e3f83ef516c594d61
commit: 9fc634e7ac71c145523c64f734836068ee14a4e8 [34/49] media: subdev: use for_each_active_route() in v4l2_subdev_init_stream_configs()
config: ia64-randconfig-r022-20220907 (https://download.01.org/0day-ci/archive/20220911/202209110000.usvZPbyp-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add pinchartl-media git://linuxtv.org/pinchartl/media.git
        git fetch --no-tags pinchartl-media streams/v6.0/v11
        git checkout 9fc634e7ac71c145523c64f734836068ee14a4e8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=ia64 SHELL=/bin/bash drivers/media/v4l2-core/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/media/v4l2-core/v4l2-subdev.c: In function 'check_state':
   drivers/media/v4l2-core/v4l2-subdev.c:157:22: error: implicit declaration of function 'v4l2_subdev_state_get_stream_format' [-Werror=implicit-function-declaration]
     157 |                 if (!v4l2_subdev_state_get_stream_format(state, pad, stream))
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/media/v4l2-core/v4l2-subdev.c: In function 'v4l2_subdev_init_stream_configs':
>> drivers/media/v4l2-core/v4l2-subdev.c:931:9: error: implicit declaration of function 'for_each_active_route'; did you mean 'for_each_active_irq'? [-Werror=implicit-function-declaration]
     931 |         for_each_active_route(routing, route) {
         |         ^~~~~~~~~~~~~~~~~~~~~
         |         for_each_active_irq
>> drivers/media/v4l2-core/v4l2-subdev.c:931:46: error: expected ';' before '{' token
     931 |         for_each_active_route(routing, route) {
         |                                              ^~
         |                                              ;
   drivers/media/v4l2-core/v4l2-subdev.c:955:46: error: expected ';' before '{' token
     955 |         for_each_active_route(routing, route) {
         |                                              ^~
         |                                              ;
   drivers/media/v4l2-core/v4l2-subdev.c:924:13: warning: unused variable 'format_idx' [-Wunused-variable]
     924 |         u32 format_idx = 0;
         |             ^~~~~~~~~~
   drivers/media/v4l2-core/v4l2-subdev.c: At top level:
   drivers/media/v4l2-core/v4l2-subdev.c:919:1: warning: 'v4l2_subdev_init_stream_configs' defined but not used [-Wunused-function]
     919 | v4l2_subdev_init_stream_configs(struct v4l2_subdev_stream_configs *stream_configs,
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +931 drivers/media/v4l2-core/v4l2-subdev.c

   917	
   918	static int
   919	v4l2_subdev_init_stream_configs(struct v4l2_subdev_stream_configs *stream_configs,
   920					const struct v4l2_subdev_krouting *routing)
   921	{
   922		struct v4l2_subdev_route *route;
   923		u32 num_configs = 0;
   924		u32 format_idx = 0;
   925	
   926		kvfree(stream_configs->configs);
   927		stream_configs->configs = NULL;
   928		stream_configs->num_configs = 0;
   929	
   930		/* Count number of formats needed */
 > 931		for_each_active_route(routing, route) {
   932			/*
   933			 * Each route needs a format on both ends of the route, except
   934			 * for source streams which only need one format.
   935			 */
   936			num_configs +=
   937				(route->flags & V4L2_SUBDEV_ROUTE_FL_SOURCE) ? 1 : 2;
   938		}
   939	
   940		if (!num_configs)
   941			return 0;
   942	
   943		stream_configs->configs = kvcalloc(num_configs,
   944			sizeof(*stream_configs->configs), GFP_KERNEL);
   945	
   946		if (!stream_configs->configs)
   947			return -ENOMEM;
   948	
   949		stream_configs->num_configs = num_configs;
   950	
   951		/*
   952		 * Fill in the 'pad' and stream' value for each item in the array from
   953		 * the routing table
   954		 */
   955		for_each_active_route(routing, route) {
   956			u32 idx;
   957	
   958			if (!(route->flags & V4L2_SUBDEV_ROUTE_FL_SOURCE)) {
   959				idx = format_idx++;
   960	
   961				stream_configs->configs[idx].pad = route->sink_pad;
   962				stream_configs->configs[idx].stream = route->sink_stream;
   963			}
   964	
   965			idx = format_idx++;
   966	
   967			stream_configs->configs[idx].pad = route->source_pad;
   968			stream_configs->configs[idx].stream = route->source_stream;
   969		}
   970	
   971		return 0;
   972	}
   973	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
