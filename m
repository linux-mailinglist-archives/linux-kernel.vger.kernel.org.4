Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F10436AB301
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 23:37:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbjCEWh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 17:37:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbjCEWhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 17:37:54 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7999BC650
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 14:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678055870; x=1709591870;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=aHYlr2pybBq1XIGhOFJMkbnqzF7ae4MttRVNwRmFFUE=;
  b=elVo9R1BA4S5swxYTL7OYApBe6fXrXEKk/kqnK5Td1eyGWlMAuc5tACq
   N9X8FEWOLhuJi7GjknX5njzDu5IvW4qkIQIaoQtEqsOjGJJfzGBtXp9kQ
   FZnrhvNX9O0sb37ke2HOQ8jl0embzdd3ygWTAXnk4l8tj2gVQTjiCIn4q
   hdtqoX0McSOrZLxvPiALhpbrX9oboTwYfEfa22kHZTCTwIjw/Lrp9r5oZ
   jmhOD27P8PNpSnn/i7IUOxKJGSE6x3EZYa/22W9Lq53ft0/Dv8558KXOx
   4wMhJL8kSEVgFn9cJMHWQbPwNb46KVjBgm4rhmoStdntjP/KEEKqQr5NM
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10640"; a="421708655"
X-IronPort-AV: E=Sophos;i="5.98,236,1673942400"; 
   d="scan'208";a="421708655"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2023 14:37:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10640"; a="708450815"
X-IronPort-AV: E=Sophos;i="5.98,236,1673942400"; 
   d="scan'208";a="708450815"
Received: from lkp-server01.sh.intel.com (HELO 776573491cc5) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 05 Mar 2023 14:37:47 -0800
Received: from kbuild by 776573491cc5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pYwzD-00037u-0A;
        Sun, 05 Mar 2023 22:37:47 +0000
Date:   Mon, 6 Mar 2023 06:37:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Wenjing Liu <wenjing.liu@amd.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        George Shen <George.Shen@amd.com>, Jun Lei <Jun.Lei@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_dp_training.c:1585:38:
 warning: variable 'result' set but not used
Message-ID: <202303060646.W0WedX9v-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wenjing,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f915322fe014c5c515119381e886faf07b3c9d31
commit: bc33f5e5f05ba44e48909e2cfc5a97475ec69a4d drm/amd/display: create accessories, hwss and protocols sub folders in link
date:   6 weeks ago
config: alpha-buildonly-randconfig-r003-20230305 (https://download.01.org/0day-ci/archive/20230306/202303060646.W0WedX9v-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=bc33f5e5f05ba44e48909e2cfc5a97475ec69a4d
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout bc33f5e5f05ba44e48909e2cfc5a97475ec69a4d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=alpha olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=alpha SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303060646.W0WedX9v-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_dp_training.c: In function 'perform_link_training_with_retries':
>> drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_dp_training.c:1585:38: warning: variable 'result' set but not used [-Wunused-but-set-variable]
    1585 |                                 bool result;
         |                                      ^~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/core_types.h:32,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/link.h:40,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_dp_training.h:29,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_dp_training.c:33:
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h: At top level:
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:142:22: warning: 'SYNAPTICS_DEVICE_ID' defined but not used [-Wunused-const-variable=]
     142 | static const uint8_t SYNAPTICS_DEVICE_ID[] = "SYNA";
         |                      ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:139:22: warning: 'DP_VGA_LVDS_CONVERTER_ID_3' defined but not used [-Wunused-const-variable=]
     139 | static const uint8_t DP_VGA_LVDS_CONVERTER_ID_3[] = "dnomlA";
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:137:22: warning: 'DP_VGA_LVDS_CONVERTER_ID_2' defined but not used [-Wunused-const-variable=]
     137 | static const uint8_t DP_VGA_LVDS_CONVERTER_ID_2[] = "sivarT";
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:134:17: warning: 'DP_SINK_BRANCH_DEV_NAME_7580' defined but not used [-Wunused-const-variable=]
     134 | static const u8 DP_SINK_BRANCH_DEV_NAME_7580[] = "7580\x80u";
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:132:22: warning: 'DP_SINK_DEVICE_STR_ID_2' defined but not used [-Wunused-const-variable=]
     132 | static const uint8_t DP_SINK_DEVICE_STR_ID_2[] = {7, 1, 8, 7, 5};
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:131:22: warning: 'DP_SINK_DEVICE_STR_ID_1' defined but not used [-Wunused-const-variable=]
     131 | static const uint8_t DP_SINK_DEVICE_STR_ID_1[] = {7, 1, 8, 7, 3};
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dc_types.h:36,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dc.h:29,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/core_types.h:29:
   drivers/gpu/drm/amd/amdgpu/../display/dc/dc_hdmi_types.h:53:22: warning: 'dp_hdmi_dongle_signature_str' defined but not used [-Wunused-const-variable=]
      53 | static const uint8_t dp_hdmi_dongle_signature_str[] = "DP-HDMI ADAPTOR";
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
   drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_dp_capability.c: In function 'dp_wa_power_up_0010FA':
   drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_dp_capability.c:278:42: warning: variable 'ds_port' set but not used [-Wunused-but-set-variable]
     278 |         union dp_downstream_port_present ds_port = { 0 };
         |                                          ^~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_dp_capability.c: In function 'dpcd_set_source_specific_data':
>> drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_dp_capability.c:1294:32: warning: variable 'result_write_min_hblank' set but not used [-Wunused-but-set-variable]
    1294 |                 enum dc_status result_write_min_hblank = DC_NOT_SUPPORTED;
         |                                ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/core_types.h:32,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/link.h:40,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_dp_capability.h:29,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_dp_capability.c:37:
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h: At top level:
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:142:22: warning: 'SYNAPTICS_DEVICE_ID' defined but not used [-Wunused-const-variable=]
     142 | static const uint8_t SYNAPTICS_DEVICE_ID[] = "SYNA";
         |                      ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:139:22: warning: 'DP_VGA_LVDS_CONVERTER_ID_3' defined but not used [-Wunused-const-variable=]
     139 | static const uint8_t DP_VGA_LVDS_CONVERTER_ID_3[] = "dnomlA";
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:137:22: warning: 'DP_VGA_LVDS_CONVERTER_ID_2' defined but not used [-Wunused-const-variable=]
     137 | static const uint8_t DP_VGA_LVDS_CONVERTER_ID_2[] = "sivarT";
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:134:17: warning: 'DP_SINK_BRANCH_DEV_NAME_7580' defined but not used [-Wunused-const-variable=]
     134 | static const u8 DP_SINK_BRANCH_DEV_NAME_7580[] = "7580\x80u";
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:132:22: warning: 'DP_SINK_DEVICE_STR_ID_2' defined but not used [-Wunused-const-variable=]
     132 | static const uint8_t DP_SINK_DEVICE_STR_ID_2[] = {7, 1, 8, 7, 5};
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:131:22: warning: 'DP_SINK_DEVICE_STR_ID_1' defined but not used [-Wunused-const-variable=]
     131 | static const uint8_t DP_SINK_DEVICE_STR_ID_1[] = {7, 1, 8, 7, 3};
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dc_types.h:36,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dc.h:29,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/core_types.h:29:
   drivers/gpu/drm/amd/amdgpu/../display/dc/dc_hdmi_types.h:53:22: warning: 'dp_hdmi_dongle_signature_str' defined but not used [-Wunused-const-variable=]
      53 | static const uint8_t dp_hdmi_dongle_signature_str[] = "DP-HDMI ADAPTOR";
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/result +1585 drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_dp_training.c

630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1521  
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1522  bool perform_link_training_with_retries(
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1523  	const struct dc_link_settings *link_setting,
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1524  	bool skip_video_pattern,
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1525  	int attempts,
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1526  	struct pipe_ctx *pipe_ctx,
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1527  	enum signal_type signal,
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1528  	bool do_fallback)
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1529  {
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1530  	int j;
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1531  	uint8_t delay_between_attempts = LINK_TRAINING_RETRY_DELAY;
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1532  	struct dc_stream_state *stream = pipe_ctx->stream;
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1533  	struct dc_link *link = stream->link;
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1534  	enum dp_panel_mode panel_mode = dp_get_panel_mode(link);
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1535  	enum link_training_result status = LINK_TRAINING_CR_FAIL_LANE0;
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1536  	struct dc_link_settings cur_link_settings = *link_setting;
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1537  	struct dc_link_settings max_link_settings = *link_setting;
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1538  	const struct link_hwss *link_hwss = get_link_hwss(link, &pipe_ctx->link_res);
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1539  	int fail_count = 0;
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1540  	bool is_link_bw_low = false; /* link bandwidth < stream bandwidth */
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1541  	bool is_link_bw_min = /* RBR x 1 */
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1542  		(cur_link_settings.link_rate <= LINK_RATE_LOW) &&
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1543  		(cur_link_settings.lane_count <= LANE_COUNT_ONE);
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1544  
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1545  	dp_trace_commit_lt_init(link);
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1546  
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1547  
d5a43956b73bd7 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-15  1548  	if (link_dp_get_encoding_format(&cur_link_settings) == DP_8b_10b_ENCODING)
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1549  		/* We need to do this before the link training to ensure the idle
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1550  		 * pattern in SST mode will be sent right after the link training
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1551  		 */
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1552  		link_hwss->setup_stream_encoder(pipe_ctx);
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1553  
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1554  	dp_trace_set_lt_start_timestamp(link, false);
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1555  	j = 0;
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1556  	while (j < attempts && fail_count < (attempts * 10)) {
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1557  
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1558  		DC_LOG_HW_LINK_TRAINING("%s: Beginning link(%d) training attempt %u of %d @ rate(%d) x lane(%d)\n",
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1559  			__func__, link->link_index, (unsigned int)j + 1, attempts, cur_link_settings.link_rate,
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1560  			cur_link_settings.lane_count);
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1561  
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1562  		dp_enable_link_phy(
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1563  			link,
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1564  			&pipe_ctx->link_res,
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1565  			signal,
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1566  			pipe_ctx->clock_source->id,
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1567  			&cur_link_settings);
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1568  
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1569  		if (stream->sink_patches.dppowerup_delay > 0) {
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1570  			int delay_dp_power_up_in_ms = stream->sink_patches.dppowerup_delay;
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1571  
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1572  			msleep(delay_dp_power_up_in_ms);
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1573  		}
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1574  
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1575  #ifdef CONFIG_DRM_AMD_DC_HDCP
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1576  		if (panel_mode == DP_PANEL_MODE_EDP) {
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1577  			struct cp_psp *cp_psp = &stream->ctx->cp_psp;
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1578  
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1579  			if (cp_psp && cp_psp->funcs.enable_assr) {
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1580  				/* ASSR is bound to fail with unsigned PSP
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1581  				 * verstage used during devlopment phase.
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1582  				 * Report and continue with eDP panel mode to
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1583  				 * perform eDP link training with right settings
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1584  				 */
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14 @1585  				bool result;
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1586  				result = cp_psp->funcs.enable_assr(cp_psp->handle, link);
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1587  			}
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1588  		}
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1589  #endif
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1590  
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1591  		dp_set_panel_mode(link, panel_mode);
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1592  
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1593  		if (link->aux_access_disabled) {
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1594  			dc_link_dp_perform_link_training_skip_aux(link, &pipe_ctx->link_res, &cur_link_settings);
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1595  			return true;
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1596  		} else {
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1597  			/** @todo Consolidate USB4 DP and DPx.x training. */
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1598  			if (link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA) {
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1599  				status = dc_link_dpia_perform_link_training(
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1600  						link,
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1601  						&pipe_ctx->link_res,
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1602  						&cur_link_settings,
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1603  						skip_video_pattern);
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1604  
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1605  				/* Transmit idle pattern once training successful. */
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1606  				if (status == LINK_TRAINING_SUCCESS && !is_link_bw_low) {
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1607  					dp_set_hw_test_pattern(link, &pipe_ctx->link_res, DP_TEST_PATTERN_VIDEO_MODE, NULL, 0);
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1608  					// Update verified link settings to current one
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1609  					// Because DPIA LT might fallback to lower link setting.
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1610  					if (stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST) {
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1611  						link->verified_link_cap.link_rate = link->cur_link_settings.link_rate;
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1612  						link->verified_link_cap.lane_count = link->cur_link_settings.lane_count;
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1613  						dm_helpers_dp_mst_update_branch_bandwidth(link->ctx, link);
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1614  					}
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1615  				}
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1616  			} else {
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1617  				status = dp_perform_link_training(
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1618  						link,
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1619  						&pipe_ctx->link_res,
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1620  						&cur_link_settings,
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1621  						skip_video_pattern);
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1622  			}
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1623  
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1624  			dp_trace_lt_total_count_increment(link, false);
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1625  			dp_trace_lt_result_update(link, status, false);
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1626  			dp_trace_set_lt_end_timestamp(link, false);
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1627  			if (status == LINK_TRAINING_SUCCESS && !is_link_bw_low)
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1628  				return true;
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1629  		}
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1630  
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1631  		fail_count++;
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1632  		dp_trace_lt_fail_count_update(link, fail_count, false);
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1633  		if (link->ep_type == DISPLAY_ENDPOINT_PHY) {
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1634  			/* latest link training still fail or link training is aborted
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1635  			 * skip delay and keep PHY on
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1636  			 */
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1637  			if (j == (attempts - 1) || (status == LINK_TRAINING_ABORT))
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1638  				break;
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1639  		}
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1640  
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1641  		DC_LOG_WARNING("%s: Link(%d) training attempt %u of %d failed @ rate(%d) x lane(%d) : fail reason:(%d)\n",
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1642  			__func__, link->link_index, (unsigned int)j + 1, attempts, cur_link_settings.link_rate,
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1643  			cur_link_settings.lane_count, status);
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1644  
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1645  		dp_disable_link_phy(link, &pipe_ctx->link_res, signal);
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1646  
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1647  		/* Abort link training if failure due to sink being unplugged. */
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1648  		if (status == LINK_TRAINING_ABORT) {
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1649  			enum dc_connection_type type = dc_connection_none;
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1650  
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1651  			dc_link_detect_sink(link, &type);
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1652  			if (type == dc_connection_none) {
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1653  				DC_LOG_HW_LINK_TRAINING("%s: Aborting training because sink unplugged\n", __func__);
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1654  				break;
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1655  			}
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1656  		}
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1657  
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1658  		/* Try to train again at original settings if:
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1659  		 * - not falling back between training attempts;
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1660  		 * - aborted previous attempt due to reasons other than sink unplug;
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1661  		 * - successfully trained but at a link rate lower than that required by stream;
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1662  		 * - reached minimum link bandwidth.
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1663  		 */
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1664  		if (!do_fallback || (status == LINK_TRAINING_ABORT) ||
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1665  				(status == LINK_TRAINING_SUCCESS && is_link_bw_low) ||
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1666  				is_link_bw_min) {
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1667  			j++;
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1668  			cur_link_settings = *link_setting;
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1669  			delay_between_attempts += LINK_TRAINING_RETRY_DELAY;
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1670  			is_link_bw_low = false;
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1671  			is_link_bw_min = (cur_link_settings.link_rate <= LINK_RATE_LOW) &&
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1672  				(cur_link_settings.lane_count <= LANE_COUNT_ONE);
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1673  
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1674  		} else if (do_fallback) { /* Try training at lower link bandwidth if doing fallback. */
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1675  			uint32_t req_bw;
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1676  			uint32_t link_bw;
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1677  
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1678  			decide_fallback_link_setting(link, &max_link_settings,
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1679  					&cur_link_settings, status);
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1680  			/* Flag if reduced link bandwidth no longer meets stream requirements or fallen back to
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1681  			 * minimum link bandwidth.
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1682  			 */
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1683  			req_bw = dc_bandwidth_in_kbps_from_timing(&stream->timing);
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1684  			link_bw = dc_link_bandwidth_kbps(link, &cur_link_settings);
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1685  			is_link_bw_low = (req_bw > link_bw);
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1686  			is_link_bw_min = ((cur_link_settings.link_rate <= LINK_RATE_LOW) &&
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1687  				(cur_link_settings.lane_count <= LANE_COUNT_ONE));
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1688  
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1689  			if (is_link_bw_low)
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1690  				DC_LOG_WARNING(
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1691  					"%s: Link(%d) bandwidth too low after fallback req_bw(%d) > link_bw(%d)\n",
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1692  					__func__, link->link_index, req_bw, link_bw);
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1693  		}
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1694  
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1695  		msleep(delay_between_attempts);
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1696  	}
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1697  
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1698  	return false;
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1699  }
630168a97314a8 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c Wenjing Liu 2022-12-14  1700  

:::::: The code at line 1585 was first introduced by commit
:::::: 630168a97314a8f6da9c09d73f5e78c3c1fe3eee drm/amd/display: move dp link training logic to link_dp_training

:::::: TO: Wenjing Liu <wenjing.liu@amd.com>
:::::: CC: Alex Deucher <alexander.deucher@amd.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
