Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 182806560D6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 08:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbiLZHkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 02:40:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231750AbiLZHjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 02:39:54 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F0FDD2
        for <linux-kernel@vger.kernel.org>; Sun, 25 Dec 2022 23:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672040388; x=1703576388;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=lssf8JMrADo8LQ2xA2W1/KK7kokJfDGVdKqGcWVsHOE=;
  b=aJazPrIN3rsCe2EYKhkh0YLWflMfWf39w+hdEiKOYhQWR6iKicSEa7FS
   nf8BAmBxy+kUpkbtXgn++mSUTYDwO9UplymdOxaj9/sRhJHFolQeioPX/
   HCqzXQx2YdASrx06VM6WuF42xwNTd5sdDt4aRPKHOX9FuiKion5c0VPPv
   /ZFJCQpYg/9fFdZyQBVoGGFOI7ZaMBIWYT9FWqE3Bm44rdvTcNLYsy1tN
   VGGdxEmBAXxCBmkPU+4yTTcwyToSSdcv5ehfNrk/v68ig7p/Osn7oBplB
   bERV07EkNW/bWT4BT3NbPBUaU4NUxButrYYldOEe5k1vpkTpOS+WAoOTA
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10571"; a="300229410"
X-IronPort-AV: E=Sophos;i="5.96,274,1665471600"; 
   d="scan'208";a="300229410"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2022 23:39:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10571"; a="685106749"
X-IronPort-AV: E=Sophos;i="5.96,274,1665471600"; 
   d="scan'208";a="685106749"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 25 Dec 2022 23:39:43 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p9i5G-000EKX-0b;
        Mon, 26 Dec 2022 07:39:42 +0000
Date:   Mon, 26 Dec 2022 15:39:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ao Zhong <hacc1225@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn20/display_mode_vba_20.c:3900:72:
 warning: implicit conversion from 'enum <anonymous>' to 'enum
 odm_combine_mode'
Message-ID: <202212261546.wsJBbPj3-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="P8tatnxojuL4V9YI"
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--P8tatnxojuL4V9YI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1b929c02afd37871d5afb9d498426f83432e71c2
commit: 79b72db63392d35a4dbcd4743b95cb668691f790 drm/amd/display: add DCN support for ARM64
date:   7 weeks ago
config: arm64-randconfig-r036-20221225
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=79b72db63392d35a4dbcd4743b95cb668691f790
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 79b72db63392d35a4dbcd4743b95cb668691f790
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/gpu/drm/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn20/display_mode_vba_20.c: In function 'dml20_ModeSupportAndSystemConfigurationFull':
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn20/display_mode_vba_20.c:3900:72: warning: implicit conversion from 'enum <anonymous>' to 'enum odm_combine_mode' [-Wenum-conversion]
    3900 |                                 locals->ODMCombineEnablePerState[i][k] = false;
         |                                                                        ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn20/display_mode_vba_20.c:3904:88: warning: implicit conversion from 'enum <anonymous>' to 'enum odm_combine_mode' [-Wenum-conversion]
    3904 |                                                 locals->ODMCombineEnablePerState[i][k] = true;
         |                                                                                        ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn20/display_mode_vba_20.c:3907:88: warning: implicit conversion from 'enum <anonymous>' to 'enum odm_combine_mode' [-Wenum-conversion]
    3907 |                                                 locals->ODMCombineEnablePerState[i][k] = true;
         |                                                                                        ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn20/display_mode_vba_20.c:3960:80: warning: implicit conversion from 'enum <anonymous>' to 'enum odm_combine_mode' [-Wenum-conversion]
    3960 |                                         locals->ODMCombineEnablePerState[i][k] = false;
         |                                                                                ^
--
   drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn20/display_mode_vba_20v2.c: In function 'dml20v2_ModeSupportAndSystemConfigurationFull':
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn20/display_mode_vba_20v2.c:4011:72: warning: implicit conversion from 'enum <anonymous>' to 'enum odm_combine_mode' [-Wenum-conversion]
    4011 |                                 locals->ODMCombineEnablePerState[i][k] = false;
         |                                                                        ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn20/display_mode_vba_20v2.c:4015:88: warning: implicit conversion from 'enum <anonymous>' to 'enum odm_combine_mode' [-Wenum-conversion]
    4015 |                                                 locals->ODMCombineEnablePerState[i][k] = true;
         |                                                                                        ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn20/display_mode_vba_20v2.c:4018:88: warning: implicit conversion from 'enum <anonymous>' to 'enum odm_combine_mode' [-Wenum-conversion]
    4018 |                                                 locals->ODMCombineEnablePerState[i][k] = true;
         |                                                                                        ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn20/display_mode_vba_20v2.c:4021:88: warning: implicit conversion from 'enum <anonymous>' to 'enum odm_combine_mode' [-Wenum-conversion]
    4021 |                                                 locals->ODMCombineEnablePerState[i][k] = true;
         |                                                                                        ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn20/display_mode_vba_20v2.c:4074:80: warning: implicit conversion from 'enum <anonymous>' to 'enum odm_combine_mode' [-Wenum-conversion]
    4074 |                                         locals->ODMCombineEnablePerState[i][k] = false;
         |                                                                                ^
--
   drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn21/display_mode_vba_21.c: In function 'dml21_ModeSupportAndSystemConfigurationFull':
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn21/display_mode_vba_21.c:4105:72: warning: implicit conversion from 'enum <anonymous>' to 'enum odm_combine_mode' [-Wenum-conversion]
    4105 |                                 locals->ODMCombineEnablePerState[i][k] = false;
         |                                                                        ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn21/display_mode_vba_21.c:4109:88: warning: implicit conversion from 'enum <anonymous>' to 'enum odm_combine_mode' [-Wenum-conversion]
    4109 |                                                 locals->ODMCombineEnablePerState[i][k] = true;
         |                                                                                        ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn21/display_mode_vba_21.c:4112:88: warning: implicit conversion from 'enum <anonymous>' to 'enum odm_combine_mode' [-Wenum-conversion]
    4112 |                                                 locals->ODMCombineEnablePerState[i][k] = true;
         |                                                                                        ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn21/display_mode_vba_21.c:4115:88: warning: implicit conversion from 'enum <anonymous>' to 'enum odm_combine_mode' [-Wenum-conversion]
    4115 |                                                 locals->ODMCombineEnablePerState[i][k] = true;
         |                                                                                        ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn21/display_mode_vba_21.c:4168:80: warning: implicit conversion from 'enum <anonymous>' to 'enum odm_combine_mode' [-Wenum-conversion]
    4168 |                                         locals->ODMCombineEnablePerState[i][k] = false;
         |                                                                                ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn21/display_mode_vba_21.c:5233:60: warning: implicit conversion from 'enum <anonymous>' to 'enum odm_combine_mode' [-Wenum-conversion]
    5233 |                         mode_lib->vba.ODMCombineEnabled[k] = false;
         |                                                            ^
--
   drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn31/display_rq_dlg_calc_31.c: In function 'dml_rq_dlg_get_dlg_params':
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn31/display_rq_dlg_calc_31.c:905:14: warning: variable 'scl_enable' set but not used [-Wunused-but-set-variable]
     905 |         bool scl_enable;
         |              ^~~~~~~~~~
--
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/dcn30_fpu.c:618: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Finds dummy_latency_index when MCLK switching using firmware based
--
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_optc.c:41: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Enable CRTC
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_optc.c:76: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    *For the below, I'm not sure how your GSL parameters are stored in your env,
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_optc.c:85: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * There are (MAX_OPTC+1)/2 gsl groups available for use.
--
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_link_encoder.c: In function 'dcn10_link_encoder_update_mst_stream_allocation_table':
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_link_encoder.c:1223:18: warning: variable 'value0' set but not used [-Wunused-but-set-variable]
    1223 |         uint32_t value0 = 0;
         |                  ^~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/core_types.h:32,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_link_encoder.c:28:
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h: At top level:
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:137:22: warning: 'SYNAPTICS_DEVICE_ID' defined but not used [-Wunused-const-variable=]
     137 | static const uint8_t SYNAPTICS_DEVICE_ID[] = "SYNA";
         |                      ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:134:17: warning: 'DP_SINK_BRANCH_DEV_NAME_7580' defined but not used [-Wunused-const-variable=]
     134 | static const u8 DP_SINK_BRANCH_DEV_NAME_7580[] = "7580\x80u";
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:132:22: warning: 'DP_SINK_DEVICE_STR_ID_2' defined but not used [-Wunused-const-variable=]
     132 | static const uint8_t DP_SINK_DEVICE_STR_ID_2[] = {7, 1, 8, 7, 5};
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:131:22: warning: 'DP_SINK_DEVICE_STR_ID_1' defined but not used [-Wunused-const-variable=]
     131 | static const uint8_t DP_SINK_DEVICE_STR_ID_1[] = {7, 1, 8, 7, 3};
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
--
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_opp.c:52: warning: Function parameter or member 'oppn10' not described in 'opp1_set_truncation'
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_opp.c:52: warning: Function parameter or member 'params' not described in 'opp1_set_truncation'
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_opp.c:52: warning: expecting prototype for set_truncation(). Prototype was for opp1_set_truncation() instead
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_opp.c:161: warning: Function parameter or member 'oppn10' not described in 'opp1_set_pixel_encoding'
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_opp.c:161: warning: Function parameter or member 'params' not described in 'opp1_set_pixel_encoding'
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_opp.c:161: warning: expecting prototype for set_pixel_encoding(). Prototype was for opp1_set_pixel_encoding() instead
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_opp.c:183: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    *      Set Clamping
--
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_optc.c:45: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
   * apply_front_porch_workaround  TODO FPGA still need?
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_optc.c:136: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * program_timing_generator   used by mode timing set
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_optc.c:391: warning: Function parameter or member 'optc' not described in 'optc1_set_timing_double_buffer'
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_optc.c:391: warning: Function parameter or member 'enable' not described in 'optc1_set_timing_double_buffer'
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_optc.c:404: warning: Function parameter or member 'optc' not described in 'optc1_unblank_crtc'
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_optc.c:404: warning: expecting prototype for unblank_crtc(). Prototype was for optc1_unblank_crtc() instead
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_optc.c:427: warning: Function parameter or member 'optc' not described in 'optc1_blank_crtc'
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_optc.c:427: warning: expecting prototype for blank_crtc(). Prototype was for optc1_blank_crtc() instead
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_optc.c:496: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Enable CRTC
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_optc.c:897: warning: Cannot understand  *****************************************************************************
    on line 897 - I thought it was a doc line
--
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_hwseq.c: In function 'dcn201_pipe_control_lock':
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_hwseq.c:544:22: warning: variable 'hubp' set but not used [-Wunused-but-set-variable]
     544 |         struct hubp *hubp = NULL;
         |                      ^~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/core_types.h:32,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/basics/dc_common.h:29,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_hwseq.c:27:
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h: At top level:
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:137:22: warning: 'SYNAPTICS_DEVICE_ID' defined but not used [-Wunused-const-variable=]
     137 | static const uint8_t SYNAPTICS_DEVICE_ID[] = "SYNA";
         |                      ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:134:17: warning: 'DP_SINK_BRANCH_DEV_NAME_7580' defined but not used [-Wunused-const-variable=]
     134 | static const u8 DP_SINK_BRANCH_DEV_NAME_7580[] = "7580\x80u";
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:132:22: warning: 'DP_SINK_DEVICE_STR_ID_2' defined but not used [-Wunused-const-variable=]
     132 | static const uint8_t DP_SINK_DEVICE_STR_ID_2[] = {7, 1, 8, 7, 5};
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:131:22: warning: 'DP_SINK_DEVICE_STR_ID_1' defined but not used [-Wunused-const-variable=]
     131 | static const uint8_t DP_SINK_DEVICE_STR_ID_1[] = {7, 1, 8, 7, 3};
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
--
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_dpp.c: In function 'dpp201_get_optimal_number_of_taps':
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_dpp.c:188:18: warning: variable 'pixel_width' set but not used [-Wunused-but-set-variable]
     188 |         uint32_t pixel_width;
         |                  ^~~~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/core_types.h:32,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_dpp.c:28:
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h: At top level:
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:137:22: warning: 'SYNAPTICS_DEVICE_ID' defined but not used [-Wunused-const-variable=]
     137 | static const uint8_t SYNAPTICS_DEVICE_ID[] = "SYNA";
         |                      ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:134:17: warning: 'DP_SINK_BRANCH_DEV_NAME_7580' defined but not used [-Wunused-const-variable=]
     134 | static const u8 DP_SINK_BRANCH_DEV_NAME_7580[] = "7580\x80u";
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:132:22: warning: 'DP_SINK_DEVICE_STR_ID_2' defined but not used [-Wunused-const-variable=]
     132 | static const uint8_t DP_SINK_DEVICE_STR_ID_2[] = {7, 1, 8, 7, 5};
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:131:22: warning: 'DP_SINK_DEVICE_STR_ID_1' defined but not used [-Wunused-const-variable=]
     131 | static const uint8_t DP_SINK_DEVICE_STR_ID_1[] = {7, 1, 8, 7, 3};
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
..


vim +3900 drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn20/display_mode_vba_20.c

728c06986a4f38 Harry Wentland     2019-02-22  3285  
728c06986a4f38 Harry Wentland     2019-02-22  3286  void dml20_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_lib)
728c06986a4f38 Harry Wentland     2019-02-22  3287  {
728c06986a4f38 Harry Wentland     2019-02-22  3288  	struct vba_vars_st *locals = &mode_lib->vba;
728c06986a4f38 Harry Wentland     2019-02-22  3289  
728c06986a4f38 Harry Wentland     2019-02-22  3290  	int i;
728c06986a4f38 Harry Wentland     2019-02-22  3291  	unsigned int j, k, m;
728c06986a4f38 Harry Wentland     2019-02-22  3292  
728c06986a4f38 Harry Wentland     2019-02-22  3293  	/*MODE SUPPORT, VOLTAGE STATE AND SOC CONFIGURATION*/
728c06986a4f38 Harry Wentland     2019-02-22  3294  
728c06986a4f38 Harry Wentland     2019-02-22  3295  	/*Scale Ratio, taps Support Check*/
728c06986a4f38 Harry Wentland     2019-02-22  3296  
728c06986a4f38 Harry Wentland     2019-02-22  3297  	mode_lib->vba.ScaleRatioAndTapsSupport = true;
728c06986a4f38 Harry Wentland     2019-02-22  3298  	for (k = 0; k <= mode_lib->vba.NumberOfActivePlanes - 1; k++) {
728c06986a4f38 Harry Wentland     2019-02-22  3299  		if (mode_lib->vba.ScalerEnabled[k] == false
728c06986a4f38 Harry Wentland     2019-02-22  3300  				&& ((mode_lib->vba.SourcePixelFormat[k] != dm_444_64
728c06986a4f38 Harry Wentland     2019-02-22  3301  						&& mode_lib->vba.SourcePixelFormat[k] != dm_444_32
728c06986a4f38 Harry Wentland     2019-02-22  3302  						&& mode_lib->vba.SourcePixelFormat[k] != dm_444_16
728c06986a4f38 Harry Wentland     2019-02-22  3303  						&& mode_lib->vba.SourcePixelFormat[k] != dm_mono_16
728c06986a4f38 Harry Wentland     2019-02-22  3304  						&& mode_lib->vba.SourcePixelFormat[k] != dm_mono_8)
728c06986a4f38 Harry Wentland     2019-02-22  3305  						|| mode_lib->vba.HRatio[k] != 1.0
728c06986a4f38 Harry Wentland     2019-02-22  3306  						|| mode_lib->vba.htaps[k] != 1.0
728c06986a4f38 Harry Wentland     2019-02-22  3307  						|| mode_lib->vba.VRatio[k] != 1.0
728c06986a4f38 Harry Wentland     2019-02-22  3308  						|| mode_lib->vba.vtaps[k] != 1.0)) {
728c06986a4f38 Harry Wentland     2019-02-22  3309  			mode_lib->vba.ScaleRatioAndTapsSupport = false;
728c06986a4f38 Harry Wentland     2019-02-22  3310  		} else if (mode_lib->vba.vtaps[k] < 1.0 || mode_lib->vba.vtaps[k] > 8.0
728c06986a4f38 Harry Wentland     2019-02-22  3311  				|| mode_lib->vba.htaps[k] < 1.0 || mode_lib->vba.htaps[k] > 8.0
728c06986a4f38 Harry Wentland     2019-02-22  3312  				|| (mode_lib->vba.htaps[k] > 1.0
728c06986a4f38 Harry Wentland     2019-02-22  3313  						&& (mode_lib->vba.htaps[k] % 2) == 1)
728c06986a4f38 Harry Wentland     2019-02-22  3314  				|| mode_lib->vba.HRatio[k] > mode_lib->vba.MaxHSCLRatio
728c06986a4f38 Harry Wentland     2019-02-22  3315  				|| mode_lib->vba.VRatio[k] > mode_lib->vba.MaxVSCLRatio
728c06986a4f38 Harry Wentland     2019-02-22  3316  				|| mode_lib->vba.HRatio[k] > mode_lib->vba.htaps[k]
728c06986a4f38 Harry Wentland     2019-02-22  3317  				|| mode_lib->vba.VRatio[k] > mode_lib->vba.vtaps[k]
728c06986a4f38 Harry Wentland     2019-02-22  3318  				|| (mode_lib->vba.SourcePixelFormat[k] != dm_444_64
728c06986a4f38 Harry Wentland     2019-02-22  3319  						&& mode_lib->vba.SourcePixelFormat[k] != dm_444_32
728c06986a4f38 Harry Wentland     2019-02-22  3320  						&& mode_lib->vba.SourcePixelFormat[k] != dm_444_16
728c06986a4f38 Harry Wentland     2019-02-22  3321  						&& mode_lib->vba.SourcePixelFormat[k] != dm_mono_16
728c06986a4f38 Harry Wentland     2019-02-22  3322  						&& mode_lib->vba.SourcePixelFormat[k] != dm_mono_8
728c06986a4f38 Harry Wentland     2019-02-22  3323  						&& (mode_lib->vba.HRatio[k] / 2.0
728c06986a4f38 Harry Wentland     2019-02-22  3324  								> mode_lib->vba.HTAPsChroma[k]
728c06986a4f38 Harry Wentland     2019-02-22  3325  								|| mode_lib->vba.VRatio[k] / 2.0
728c06986a4f38 Harry Wentland     2019-02-22  3326  										> mode_lib->vba.VTAPsChroma[k]))) {
728c06986a4f38 Harry Wentland     2019-02-22  3327  			mode_lib->vba.ScaleRatioAndTapsSupport = false;
728c06986a4f38 Harry Wentland     2019-02-22  3328  		}
728c06986a4f38 Harry Wentland     2019-02-22  3329  	}
728c06986a4f38 Harry Wentland     2019-02-22  3330  	/*Source Format, Pixel Format and Scan Support Check*/
728c06986a4f38 Harry Wentland     2019-02-22  3331  
728c06986a4f38 Harry Wentland     2019-02-22  3332  	mode_lib->vba.SourceFormatPixelAndScanSupport = true;
728c06986a4f38 Harry Wentland     2019-02-22  3333  	for (k = 0; k <= mode_lib->vba.NumberOfActivePlanes - 1; k++) {
728c06986a4f38 Harry Wentland     2019-02-22  3334  		if ((mode_lib->vba.SurfaceTiling[k] == dm_sw_linear
728c06986a4f38 Harry Wentland     2019-02-22  3335  				&& mode_lib->vba.SourceScan[k] != dm_horz)
728c06986a4f38 Harry Wentland     2019-02-22  3336  				|| ((mode_lib->vba.SurfaceTiling[k] == dm_sw_4kb_d
728c06986a4f38 Harry Wentland     2019-02-22  3337  						|| mode_lib->vba.SurfaceTiling[k] == dm_sw_4kb_d_x
728c06986a4f38 Harry Wentland     2019-02-22  3338  						|| mode_lib->vba.SurfaceTiling[k] == dm_sw_64kb_d
728c06986a4f38 Harry Wentland     2019-02-22  3339  						|| mode_lib->vba.SurfaceTiling[k] == dm_sw_64kb_d_t
728c06986a4f38 Harry Wentland     2019-02-22  3340  						|| mode_lib->vba.SurfaceTiling[k] == dm_sw_64kb_d_x
728c06986a4f38 Harry Wentland     2019-02-22  3341  						|| mode_lib->vba.SurfaceTiling[k] == dm_sw_var_d
728c06986a4f38 Harry Wentland     2019-02-22  3342  						|| mode_lib->vba.SurfaceTiling[k] == dm_sw_var_d_x)
728c06986a4f38 Harry Wentland     2019-02-22  3343  						&& mode_lib->vba.SourcePixelFormat[k] != dm_444_64)
728c06986a4f38 Harry Wentland     2019-02-22  3344  				|| (mode_lib->vba.SurfaceTiling[k] == dm_sw_64kb_r_x
728c06986a4f38 Harry Wentland     2019-02-22  3345  						&& (mode_lib->vba.SourcePixelFormat[k] == dm_mono_8
728c06986a4f38 Harry Wentland     2019-02-22  3346  								|| mode_lib->vba.SourcePixelFormat[k]
728c06986a4f38 Harry Wentland     2019-02-22  3347  										== dm_420_8
728c06986a4f38 Harry Wentland     2019-02-22  3348  								|| mode_lib->vba.SourcePixelFormat[k]
728c06986a4f38 Harry Wentland     2019-02-22  3349  										== dm_420_10))
728c06986a4f38 Harry Wentland     2019-02-22  3350  				|| (((mode_lib->vba.SurfaceTiling[k] == dm_sw_gfx7_2d_thin_gl
728c06986a4f38 Harry Wentland     2019-02-22  3351  						|| mode_lib->vba.SurfaceTiling[k]
51f2af1d839e95 Charlene Liu       2019-12-16  3352  								== dm_sw_gfx7_2d_thin_l_vp)
728c06986a4f38 Harry Wentland     2019-02-22  3353  						&& !((mode_lib->vba.SourcePixelFormat[k]
728c06986a4f38 Harry Wentland     2019-02-22  3354  								== dm_444_64
728c06986a4f38 Harry Wentland     2019-02-22  3355  								|| mode_lib->vba.SourcePixelFormat[k]
728c06986a4f38 Harry Wentland     2019-02-22  3356  										== dm_444_32)
728c06986a4f38 Harry Wentland     2019-02-22  3357  								&& mode_lib->vba.SourceScan[k]
728c06986a4f38 Harry Wentland     2019-02-22  3358  										== dm_horz
728c06986a4f38 Harry Wentland     2019-02-22  3359  								&& mode_lib->vba.SupportGFX7CompatibleTilingIn32bppAnd64bpp
728c06986a4f38 Harry Wentland     2019-02-22  3360  										== true
728c06986a4f38 Harry Wentland     2019-02-22  3361  								&& mode_lib->vba.DCCEnable[k]
728c06986a4f38 Harry Wentland     2019-02-22  3362  										== false))
728c06986a4f38 Harry Wentland     2019-02-22  3363  						|| (mode_lib->vba.DCCEnable[k] == true
728c06986a4f38 Harry Wentland     2019-02-22  3364  								&& (mode_lib->vba.SurfaceTiling[k]
728c06986a4f38 Harry Wentland     2019-02-22  3365  										== dm_sw_linear
728c06986a4f38 Harry Wentland     2019-02-22  3366  										|| mode_lib->vba.SourcePixelFormat[k]
728c06986a4f38 Harry Wentland     2019-02-22  3367  												== dm_420_8
728c06986a4f38 Harry Wentland     2019-02-22  3368  										|| mode_lib->vba.SourcePixelFormat[k]
728c06986a4f38 Harry Wentland     2019-02-22  3369  												== dm_420_10)))) {
728c06986a4f38 Harry Wentland     2019-02-22  3370  			mode_lib->vba.SourceFormatPixelAndScanSupport = false;
728c06986a4f38 Harry Wentland     2019-02-22  3371  		}
728c06986a4f38 Harry Wentland     2019-02-22  3372  	}
728c06986a4f38 Harry Wentland     2019-02-22  3373  	/*Bandwidth Support Check*/
728c06986a4f38 Harry Wentland     2019-02-22  3374  
728c06986a4f38 Harry Wentland     2019-02-22  3375  	for (k = 0; k <= mode_lib->vba.NumberOfActivePlanes - 1; k++) {
728c06986a4f38 Harry Wentland     2019-02-22  3376  		if (mode_lib->vba.SourcePixelFormat[k] == dm_444_64) {
728c06986a4f38 Harry Wentland     2019-02-22  3377  			locals->BytePerPixelInDETY[k] = 8.0;
728c06986a4f38 Harry Wentland     2019-02-22  3378  			locals->BytePerPixelInDETC[k] = 0.0;
728c06986a4f38 Harry Wentland     2019-02-22  3379  		} else if (mode_lib->vba.SourcePixelFormat[k] == dm_444_32) {
728c06986a4f38 Harry Wentland     2019-02-22  3380  			locals->BytePerPixelInDETY[k] = 4.0;
728c06986a4f38 Harry Wentland     2019-02-22  3381  			locals->BytePerPixelInDETC[k] = 0.0;
728c06986a4f38 Harry Wentland     2019-02-22  3382  		} else if (mode_lib->vba.SourcePixelFormat[k] == dm_444_16
728c06986a4f38 Harry Wentland     2019-02-22  3383  				|| mode_lib->vba.SourcePixelFormat[k] == dm_mono_16) {
728c06986a4f38 Harry Wentland     2019-02-22  3384  			locals->BytePerPixelInDETY[k] = 2.0;
728c06986a4f38 Harry Wentland     2019-02-22  3385  			locals->BytePerPixelInDETC[k] = 0.0;
728c06986a4f38 Harry Wentland     2019-02-22  3386  		} else if (mode_lib->vba.SourcePixelFormat[k] == dm_mono_8) {
728c06986a4f38 Harry Wentland     2019-02-22  3387  			locals->BytePerPixelInDETY[k] = 1.0;
728c06986a4f38 Harry Wentland     2019-02-22  3388  			locals->BytePerPixelInDETC[k] = 0.0;
728c06986a4f38 Harry Wentland     2019-02-22  3389  		} else if (mode_lib->vba.SourcePixelFormat[k] == dm_420_8) {
728c06986a4f38 Harry Wentland     2019-02-22  3390  			locals->BytePerPixelInDETY[k] = 1.0;
728c06986a4f38 Harry Wentland     2019-02-22  3391  			locals->BytePerPixelInDETC[k] = 2.0;
728c06986a4f38 Harry Wentland     2019-02-22  3392  		} else {
728c06986a4f38 Harry Wentland     2019-02-22  3393  			locals->BytePerPixelInDETY[k] = 4.0 / 3;
728c06986a4f38 Harry Wentland     2019-02-22  3394  			locals->BytePerPixelInDETC[k] = 8.0 / 3;
728c06986a4f38 Harry Wentland     2019-02-22  3395  		}
728c06986a4f38 Harry Wentland     2019-02-22  3396  		if (mode_lib->vba.SourceScan[k] == dm_horz) {
728c06986a4f38 Harry Wentland     2019-02-22  3397  			locals->SwathWidthYSingleDPP[k] = mode_lib->vba.ViewportWidth[k];
728c06986a4f38 Harry Wentland     2019-02-22  3398  		} else {
728c06986a4f38 Harry Wentland     2019-02-22  3399  			locals->SwathWidthYSingleDPP[k] = mode_lib->vba.ViewportHeight[k];
728c06986a4f38 Harry Wentland     2019-02-22  3400  		}
728c06986a4f38 Harry Wentland     2019-02-22  3401  	}
728c06986a4f38 Harry Wentland     2019-02-22  3402  	for (k = 0; k <= mode_lib->vba.NumberOfActivePlanes - 1; k++) {
728c06986a4f38 Harry Wentland     2019-02-22  3403  		locals->ReadBandwidthLuma[k] = locals->SwathWidthYSingleDPP[k] * dml_ceil(locals->BytePerPixelInDETY[k], 1.0)
728c06986a4f38 Harry Wentland     2019-02-22  3404  				/ (mode_lib->vba.HTotal[k] / mode_lib->vba.PixelClock[k]) * mode_lib->vba.VRatio[k];
728c06986a4f38 Harry Wentland     2019-02-22  3405  		locals->ReadBandwidthChroma[k] = locals->SwathWidthYSingleDPP[k] / 2 * dml_ceil(locals->BytePerPixelInDETC[k], 2.0)
728c06986a4f38 Harry Wentland     2019-02-22  3406  				/ (mode_lib->vba.HTotal[k] / mode_lib->vba.PixelClock[k]) * mode_lib->vba.VRatio[k] / 2.0;
728c06986a4f38 Harry Wentland     2019-02-22  3407  		locals->ReadBandwidth[k] = locals->ReadBandwidthLuma[k] + locals->ReadBandwidthChroma[k];
728c06986a4f38 Harry Wentland     2019-02-22  3408  	}
728c06986a4f38 Harry Wentland     2019-02-22  3409  	for (k = 0; k <= mode_lib->vba.NumberOfActivePlanes - 1; k++) {
728c06986a4f38 Harry Wentland     2019-02-22  3410  		if (mode_lib->vba.WritebackEnable[k] == true
728c06986a4f38 Harry Wentland     2019-02-22  3411  				&& mode_lib->vba.WritebackPixelFormat[k] == dm_444_32) {
728c06986a4f38 Harry Wentland     2019-02-22  3412  			locals->WriteBandwidth[k] = mode_lib->vba.WritebackDestinationWidth[k]
728c06986a4f38 Harry Wentland     2019-02-22  3413  					* mode_lib->vba.WritebackDestinationHeight[k]
728c06986a4f38 Harry Wentland     2019-02-22  3414  					/ (mode_lib->vba.WritebackSourceHeight[k]
728c06986a4f38 Harry Wentland     2019-02-22  3415  							* mode_lib->vba.HTotal[k]
728c06986a4f38 Harry Wentland     2019-02-22  3416  							/ mode_lib->vba.PixelClock[k]) * 4.0;
728c06986a4f38 Harry Wentland     2019-02-22  3417  		} else if (mode_lib->vba.WritebackEnable[k] == true
728c06986a4f38 Harry Wentland     2019-02-22  3418  				&& mode_lib->vba.WritebackPixelFormat[k] == dm_420_10) {
728c06986a4f38 Harry Wentland     2019-02-22  3419  			locals->WriteBandwidth[k] = mode_lib->vba.WritebackDestinationWidth[k]
728c06986a4f38 Harry Wentland     2019-02-22  3420  					* mode_lib->vba.WritebackDestinationHeight[k]
728c06986a4f38 Harry Wentland     2019-02-22  3421  					/ (mode_lib->vba.WritebackSourceHeight[k]
728c06986a4f38 Harry Wentland     2019-02-22  3422  							* mode_lib->vba.HTotal[k]
728c06986a4f38 Harry Wentland     2019-02-22  3423  							/ mode_lib->vba.PixelClock[k]) * 3.0;
728c06986a4f38 Harry Wentland     2019-02-22  3424  		} else if (mode_lib->vba.WritebackEnable[k] == true) {
728c06986a4f38 Harry Wentland     2019-02-22  3425  			locals->WriteBandwidth[k] = mode_lib->vba.WritebackDestinationWidth[k]
728c06986a4f38 Harry Wentland     2019-02-22  3426  					* mode_lib->vba.WritebackDestinationHeight[k]
728c06986a4f38 Harry Wentland     2019-02-22  3427  					/ (mode_lib->vba.WritebackSourceHeight[k]
728c06986a4f38 Harry Wentland     2019-02-22  3428  							* mode_lib->vba.HTotal[k]
728c06986a4f38 Harry Wentland     2019-02-22  3429  							/ mode_lib->vba.PixelClock[k]) * 1.5;
728c06986a4f38 Harry Wentland     2019-02-22  3430  		} else {
728c06986a4f38 Harry Wentland     2019-02-22  3431  			locals->WriteBandwidth[k] = 0.0;
728c06986a4f38 Harry Wentland     2019-02-22  3432  		}
728c06986a4f38 Harry Wentland     2019-02-22  3433  	}
728c06986a4f38 Harry Wentland     2019-02-22  3434  	mode_lib->vba.DCCEnabledInAnyPlane = false;
728c06986a4f38 Harry Wentland     2019-02-22  3435  	for (k = 0; k <= mode_lib->vba.NumberOfActivePlanes - 1; k++) {
728c06986a4f38 Harry Wentland     2019-02-22  3436  		if (mode_lib->vba.DCCEnable[k] == true) {
728c06986a4f38 Harry Wentland     2019-02-22  3437  			mode_lib->vba.DCCEnabledInAnyPlane = true;
728c06986a4f38 Harry Wentland     2019-02-22  3438  		}
728c06986a4f38 Harry Wentland     2019-02-22  3439  	}
8ee0fea4baf90e Dmytro Laktyushkin 2021-03-04  3440  	mode_lib->vba.UrgentLatency = mode_lib->vba.UrgentLatencyPixelDataOnly;
728c06986a4f38 Harry Wentland     2019-02-22  3441  	for (i = 0; i <= mode_lib->vba.soc.num_states; i++) {
728c06986a4f38 Harry Wentland     2019-02-22  3442  		locals->FabricAndDRAMBandwidthPerState[i] = dml_min(
728c06986a4f38 Harry Wentland     2019-02-22  3443  				mode_lib->vba.DRAMSpeedPerState[i] * mode_lib->vba.NumberOfChannels
728c06986a4f38 Harry Wentland     2019-02-22  3444  						* mode_lib->vba.DRAMChannelWidth,
728c06986a4f38 Harry Wentland     2019-02-22  3445  				mode_lib->vba.FabricClockPerState[i]
728c06986a4f38 Harry Wentland     2019-02-22  3446  						* mode_lib->vba.FabricDatapathToDCNDataReturn) / 1000;
728c06986a4f38 Harry Wentland     2019-02-22  3447  		locals->ReturnBWToDCNPerState = dml_min(locals->ReturnBusWidth * locals->DCFCLKPerState[i],
728c06986a4f38 Harry Wentland     2019-02-22  3448  				locals->FabricAndDRAMBandwidthPerState[i] * 1000)
728c06986a4f38 Harry Wentland     2019-02-22  3449  				* locals->PercentOfIdealDRAMFabricAndSDPPortBWReceivedAfterUrgLatencyPixelDataOnly / 100;
728c06986a4f38 Harry Wentland     2019-02-22  3450  
5fc11598166db9 Dmytro Laktyushkin 2019-10-30  3451  		locals->ReturnBWPerState[i][0] = locals->ReturnBWToDCNPerState;
728c06986a4f38 Harry Wentland     2019-02-22  3452  
728c06986a4f38 Harry Wentland     2019-02-22  3453  		if (locals->DCCEnabledInAnyPlane == true && locals->ReturnBWToDCNPerState > locals->DCFCLKPerState[i] * locals->ReturnBusWidth / 4) {
5fc11598166db9 Dmytro Laktyushkin 2019-10-30  3454  			locals->ReturnBWPerState[i][0] = dml_min(locals->ReturnBWPerState[i][0],
728c06986a4f38 Harry Wentland     2019-02-22  3455  					locals->ReturnBWToDCNPerState * 4 * (1 - locals->UrgentLatency /
728c06986a4f38 Harry Wentland     2019-02-22  3456  					((locals->ROBBufferSizeInKByte - locals->PixelChunkSizeInKByte) * 1024
728c06986a4f38 Harry Wentland     2019-02-22  3457  					/ (locals->ReturnBWToDCNPerState - locals->DCFCLKPerState[i]
728c06986a4f38 Harry Wentland     2019-02-22  3458  					* locals->ReturnBusWidth / 4) + locals->UrgentLatency)));
728c06986a4f38 Harry Wentland     2019-02-22  3459  		}
728c06986a4f38 Harry Wentland     2019-02-22  3460  		locals->CriticalPoint = 2 * locals->ReturnBusWidth * locals->DCFCLKPerState[i] *
728c06986a4f38 Harry Wentland     2019-02-22  3461  				locals->UrgentLatency / (locals->ReturnBWToDCNPerState * locals->UrgentLatency
728c06986a4f38 Harry Wentland     2019-02-22  3462  				+ (locals->ROBBufferSizeInKByte - locals->PixelChunkSizeInKByte) * 1024);
728c06986a4f38 Harry Wentland     2019-02-22  3463  
728c06986a4f38 Harry Wentland     2019-02-22  3464  		if (locals->DCCEnabledInAnyPlane && locals->CriticalPoint > 1 && locals->CriticalPoint < 4) {
5fc11598166db9 Dmytro Laktyushkin 2019-10-30  3465  			locals->ReturnBWPerState[i][0] = dml_min(locals->ReturnBWPerState[i][0],
728c06986a4f38 Harry Wentland     2019-02-22  3466  				4 * locals->ReturnBWToDCNPerState *
728c06986a4f38 Harry Wentland     2019-02-22  3467  				(locals->ROBBufferSizeInKByte - locals->PixelChunkSizeInKByte) * 1024
728c06986a4f38 Harry Wentland     2019-02-22  3468  				* locals->ReturnBusWidth * locals->DCFCLKPerState[i] * locals->UrgentLatency /
728c06986a4f38 Harry Wentland     2019-02-22  3469  				dml_pow((locals->ReturnBWToDCNPerState * locals->UrgentLatency
728c06986a4f38 Harry Wentland     2019-02-22  3470  				+ (locals->ROBBufferSizeInKByte - locals->PixelChunkSizeInKByte) * 1024), 2));
728c06986a4f38 Harry Wentland     2019-02-22  3471  		}
728c06986a4f38 Harry Wentland     2019-02-22  3472  
728c06986a4f38 Harry Wentland     2019-02-22  3473  		locals->ReturnBWToDCNPerState = dml_min(locals->ReturnBusWidth *
728c06986a4f38 Harry Wentland     2019-02-22  3474  				locals->DCFCLKPerState[i], locals->FabricAndDRAMBandwidthPerState[i] * 1000);
728c06986a4f38 Harry Wentland     2019-02-22  3475  
728c06986a4f38 Harry Wentland     2019-02-22  3476  		if (locals->DCCEnabledInAnyPlane == true && locals->ReturnBWToDCNPerState > locals->DCFCLKPerState[i] * locals->ReturnBusWidth / 4) {
5fc11598166db9 Dmytro Laktyushkin 2019-10-30  3477  			locals->ReturnBWPerState[i][0] = dml_min(locals->ReturnBWPerState[i][0],
728c06986a4f38 Harry Wentland     2019-02-22  3478  					locals->ReturnBWToDCNPerState * 4 * (1 - locals->UrgentLatency /
728c06986a4f38 Harry Wentland     2019-02-22  3479  					((locals->ROBBufferSizeInKByte - locals->PixelChunkSizeInKByte) * 1024
728c06986a4f38 Harry Wentland     2019-02-22  3480  					/ (locals->ReturnBWToDCNPerState - locals->DCFCLKPerState[i]
728c06986a4f38 Harry Wentland     2019-02-22  3481  					* locals->ReturnBusWidth / 4) + locals->UrgentLatency)));
728c06986a4f38 Harry Wentland     2019-02-22  3482  		}
728c06986a4f38 Harry Wentland     2019-02-22  3483  		locals->CriticalPoint = 2 * locals->ReturnBusWidth * locals->DCFCLKPerState[i] *
728c06986a4f38 Harry Wentland     2019-02-22  3484  				locals->UrgentLatency / (locals->ReturnBWToDCNPerState * locals->UrgentLatency
728c06986a4f38 Harry Wentland     2019-02-22  3485  				+ (locals->ROBBufferSizeInKByte - locals->PixelChunkSizeInKByte) * 1024);
728c06986a4f38 Harry Wentland     2019-02-22  3486  
728c06986a4f38 Harry Wentland     2019-02-22  3487  		if (locals->DCCEnabledInAnyPlane && locals->CriticalPoint > 1 && locals->CriticalPoint < 4) {
5fc11598166db9 Dmytro Laktyushkin 2019-10-30  3488  			locals->ReturnBWPerState[i][0] = dml_min(locals->ReturnBWPerState[i][0],
728c06986a4f38 Harry Wentland     2019-02-22  3489  				4 * locals->ReturnBWToDCNPerState *
728c06986a4f38 Harry Wentland     2019-02-22  3490  				(locals->ROBBufferSizeInKByte - locals->PixelChunkSizeInKByte) * 1024
728c06986a4f38 Harry Wentland     2019-02-22  3491  				* locals->ReturnBusWidth * locals->DCFCLKPerState[i] * locals->UrgentLatency /
728c06986a4f38 Harry Wentland     2019-02-22  3492  				dml_pow((locals->ReturnBWToDCNPerState * locals->UrgentLatency
728c06986a4f38 Harry Wentland     2019-02-22  3493  				+ (locals->ROBBufferSizeInKByte - locals->PixelChunkSizeInKByte) * 1024), 2));
728c06986a4f38 Harry Wentland     2019-02-22  3494  		}
728c06986a4f38 Harry Wentland     2019-02-22  3495  	}
728c06986a4f38 Harry Wentland     2019-02-22  3496  	/*Writeback Latency support check*/
728c06986a4f38 Harry Wentland     2019-02-22  3497  
728c06986a4f38 Harry Wentland     2019-02-22  3498  	mode_lib->vba.WritebackLatencySupport = true;
728c06986a4f38 Harry Wentland     2019-02-22  3499  	for (k = 0; k <= mode_lib->vba.NumberOfActivePlanes - 1; k++) {
728c06986a4f38 Harry Wentland     2019-02-22  3500  		if (mode_lib->vba.WritebackEnable[k] == true) {
728c06986a4f38 Harry Wentland     2019-02-22  3501  			if (mode_lib->vba.WritebackPixelFormat[k] == dm_444_32) {
728c06986a4f38 Harry Wentland     2019-02-22  3502  				if (locals->WriteBandwidth[k]
728c06986a4f38 Harry Wentland     2019-02-22  3503  						> (mode_lib->vba.WritebackInterfaceLumaBufferSize
728c06986a4f38 Harry Wentland     2019-02-22  3504  								+ mode_lib->vba.WritebackInterfaceChromaBufferSize)
728c06986a4f38 Harry Wentland     2019-02-22  3505  								/ mode_lib->vba.WritebackLatency) {
728c06986a4f38 Harry Wentland     2019-02-22  3506  					mode_lib->vba.WritebackLatencySupport = false;
728c06986a4f38 Harry Wentland     2019-02-22  3507  				}
728c06986a4f38 Harry Wentland     2019-02-22  3508  			} else {
728c06986a4f38 Harry Wentland     2019-02-22  3509  				if (locals->WriteBandwidth[k]
728c06986a4f38 Harry Wentland     2019-02-22  3510  						> 1.5
728c06986a4f38 Harry Wentland     2019-02-22  3511  								* dml_min(
728c06986a4f38 Harry Wentland     2019-02-22  3512  										mode_lib->vba.WritebackInterfaceLumaBufferSize,
728c06986a4f38 Harry Wentland     2019-02-22  3513  										2.0
728c06986a4f38 Harry Wentland     2019-02-22  3514  												* mode_lib->vba.WritebackInterfaceChromaBufferSize)
728c06986a4f38 Harry Wentland     2019-02-22  3515  								/ mode_lib->vba.WritebackLatency) {
728c06986a4f38 Harry Wentland     2019-02-22  3516  					mode_lib->vba.WritebackLatencySupport = false;
728c06986a4f38 Harry Wentland     2019-02-22  3517  				}
728c06986a4f38 Harry Wentland     2019-02-22  3518  			}
728c06986a4f38 Harry Wentland     2019-02-22  3519  		}
728c06986a4f38 Harry Wentland     2019-02-22  3520  	}
728c06986a4f38 Harry Wentland     2019-02-22  3521  	/*Re-ordering Buffer Support Check*/
728c06986a4f38 Harry Wentland     2019-02-22  3522  
728c06986a4f38 Harry Wentland     2019-02-22  3523  	for (i = 0; i <= mode_lib->vba.soc.num_states; i++) {
728c06986a4f38 Harry Wentland     2019-02-22  3524  		locals->UrgentRoundTripAndOutOfOrderLatencyPerState[i] =
728c06986a4f38 Harry Wentland     2019-02-22  3525  				(mode_lib->vba.RoundTripPingLatencyCycles + 32.0) / mode_lib->vba.DCFCLKPerState[i]
5fc11598166db9 Dmytro Laktyushkin 2019-10-30  3526  				+ locals->UrgentOutOfOrderReturnPerChannel * mode_lib->vba.NumberOfChannels / locals->ReturnBWPerState[i][0];
5fc11598166db9 Dmytro Laktyushkin 2019-10-30  3527  		if ((mode_lib->vba.ROBBufferSizeInKByte - mode_lib->vba.PixelChunkSizeInKByte) * 1024.0 / locals->ReturnBWPerState[i][0]
728c06986a4f38 Harry Wentland     2019-02-22  3528  				> locals->UrgentRoundTripAndOutOfOrderLatencyPerState[i]) {
5fc11598166db9 Dmytro Laktyushkin 2019-10-30  3529  			locals->ROBSupport[i][0] = true;
728c06986a4f38 Harry Wentland     2019-02-22  3530  		} else {
5fc11598166db9 Dmytro Laktyushkin 2019-10-30  3531  			locals->ROBSupport[i][0] = false;
728c06986a4f38 Harry Wentland     2019-02-22  3532  		}
728c06986a4f38 Harry Wentland     2019-02-22  3533  	}
728c06986a4f38 Harry Wentland     2019-02-22  3534  	/*Writeback Mode Support Check*/
728c06986a4f38 Harry Wentland     2019-02-22  3535  
728c06986a4f38 Harry Wentland     2019-02-22  3536  	mode_lib->vba.TotalNumberOfActiveWriteback = 0;
728c06986a4f38 Harry Wentland     2019-02-22  3537  	for (k = 0; k <= mode_lib->vba.NumberOfActivePlanes - 1; k++) {
728c06986a4f38 Harry Wentland     2019-02-22  3538  		if (mode_lib->vba.WritebackEnable[k] == true) {
728c06986a4f38 Harry Wentland     2019-02-22  3539  			if (mode_lib->vba.ActiveWritebacksPerPlane[k] == 0)
728c06986a4f38 Harry Wentland     2019-02-22  3540  				mode_lib->vba.ActiveWritebacksPerPlane[k] = 1;
728c06986a4f38 Harry Wentland     2019-02-22  3541  			mode_lib->vba.TotalNumberOfActiveWriteback =
728c06986a4f38 Harry Wentland     2019-02-22  3542  					mode_lib->vba.TotalNumberOfActiveWriteback
728c06986a4f38 Harry Wentland     2019-02-22  3543  							+ mode_lib->vba.ActiveWritebacksPerPlane[k];
728c06986a4f38 Harry Wentland     2019-02-22  3544  		}
728c06986a4f38 Harry Wentland     2019-02-22  3545  	}
728c06986a4f38 Harry Wentland     2019-02-22  3546  	mode_lib->vba.WritebackModeSupport = true;
728c06986a4f38 Harry Wentland     2019-02-22  3547  	if (mode_lib->vba.TotalNumberOfActiveWriteback > mode_lib->vba.MaxNumWriteback) {
728c06986a4f38 Harry Wentland     2019-02-22  3548  		mode_lib->vba.WritebackModeSupport = false;
728c06986a4f38 Harry Wentland     2019-02-22  3549  	}
728c06986a4f38 Harry Wentland     2019-02-22  3550  	for (k = 0; k <= mode_lib->vba.NumberOfActivePlanes - 1; k++) {
728c06986a4f38 Harry Wentland     2019-02-22  3551  		if (mode_lib->vba.WritebackEnable[k] == true
728c06986a4f38 Harry Wentland     2019-02-22  3552  				&& mode_lib->vba.Writeback10bpc420Supported != true
728c06986a4f38 Harry Wentland     2019-02-22  3553  				&& mode_lib->vba.WritebackPixelFormat[k] == dm_420_10) {
728c06986a4f38 Harry Wentland     2019-02-22  3554  			mode_lib->vba.WritebackModeSupport = false;
728c06986a4f38 Harry Wentland     2019-02-22  3555  		}
728c06986a4f38 Harry Wentland     2019-02-22  3556  	}
728c06986a4f38 Harry Wentland     2019-02-22  3557  	/*Writeback Scale Ratio and Taps Support Check*/
728c06986a4f38 Harry Wentland     2019-02-22  3558  
728c06986a4f38 Harry Wentland     2019-02-22  3559  	mode_lib->vba.WritebackScaleRatioAndTapsSupport = true;
728c06986a4f38 Harry Wentland     2019-02-22  3560  	for (k = 0; k <= mode_lib->vba.NumberOfActivePlanes - 1; k++) {
728c06986a4f38 Harry Wentland     2019-02-22  3561  		if (mode_lib->vba.WritebackEnable[k] == true) {
728c06986a4f38 Harry Wentland     2019-02-22  3562  			if (mode_lib->vba.WritebackLumaAndChromaScalingSupported == false
728c06986a4f38 Harry Wentland     2019-02-22  3563  					&& (mode_lib->vba.WritebackHRatio[k] != 1.0
728c06986a4f38 Harry Wentland     2019-02-22  3564  							|| mode_lib->vba.WritebackVRatio[k] != 1.0)) {
728c06986a4f38 Harry Wentland     2019-02-22  3565  				mode_lib->vba.WritebackScaleRatioAndTapsSupport = false;
728c06986a4f38 Harry Wentland     2019-02-22  3566  			}
728c06986a4f38 Harry Wentland     2019-02-22  3567  			if (mode_lib->vba.WritebackHRatio[k] > mode_lib->vba.WritebackMaxHSCLRatio
728c06986a4f38 Harry Wentland     2019-02-22  3568  					|| mode_lib->vba.WritebackVRatio[k]
728c06986a4f38 Harry Wentland     2019-02-22  3569  							> mode_lib->vba.WritebackMaxVSCLRatio
728c06986a4f38 Harry Wentland     2019-02-22  3570  					|| mode_lib->vba.WritebackHRatio[k]
728c06986a4f38 Harry Wentland     2019-02-22  3571  							< mode_lib->vba.WritebackMinHSCLRatio
728c06986a4f38 Harry Wentland     2019-02-22  3572  					|| mode_lib->vba.WritebackVRatio[k]
728c06986a4f38 Harry Wentland     2019-02-22  3573  							< mode_lib->vba.WritebackMinVSCLRatio
728c06986a4f38 Harry Wentland     2019-02-22  3574  					|| mode_lib->vba.WritebackLumaHTaps[k]
728c06986a4f38 Harry Wentland     2019-02-22  3575  							> mode_lib->vba.WritebackMaxHSCLTaps
728c06986a4f38 Harry Wentland     2019-02-22  3576  					|| mode_lib->vba.WritebackLumaVTaps[k]
728c06986a4f38 Harry Wentland     2019-02-22  3577  							> mode_lib->vba.WritebackMaxVSCLTaps
728c06986a4f38 Harry Wentland     2019-02-22  3578  					|| mode_lib->vba.WritebackHRatio[k]
728c06986a4f38 Harry Wentland     2019-02-22  3579  							> mode_lib->vba.WritebackLumaHTaps[k]
728c06986a4f38 Harry Wentland     2019-02-22  3580  					|| mode_lib->vba.WritebackVRatio[k]
728c06986a4f38 Harry Wentland     2019-02-22  3581  							> mode_lib->vba.WritebackLumaVTaps[k]
728c06986a4f38 Harry Wentland     2019-02-22  3582  					|| (mode_lib->vba.WritebackLumaHTaps[k] > 2.0
728c06986a4f38 Harry Wentland     2019-02-22  3583  							&& ((mode_lib->vba.WritebackLumaHTaps[k] % 2)
728c06986a4f38 Harry Wentland     2019-02-22  3584  									== 1))
728c06986a4f38 Harry Wentland     2019-02-22  3585  					|| (mode_lib->vba.WritebackPixelFormat[k] != dm_444_32
728c06986a4f38 Harry Wentland     2019-02-22  3586  							&& (mode_lib->vba.WritebackChromaHTaps[k]
728c06986a4f38 Harry Wentland     2019-02-22  3587  									> mode_lib->vba.WritebackMaxHSCLTaps
728c06986a4f38 Harry Wentland     2019-02-22  3588  									|| mode_lib->vba.WritebackChromaVTaps[k]
728c06986a4f38 Harry Wentland     2019-02-22  3589  											> mode_lib->vba.WritebackMaxVSCLTaps
728c06986a4f38 Harry Wentland     2019-02-22  3590  									|| 2.0
728c06986a4f38 Harry Wentland     2019-02-22  3591  											* mode_lib->vba.WritebackHRatio[k]
728c06986a4f38 Harry Wentland     2019-02-22  3592  											> mode_lib->vba.WritebackChromaHTaps[k]
728c06986a4f38 Harry Wentland     2019-02-22  3593  									|| 2.0
728c06986a4f38 Harry Wentland     2019-02-22  3594  											* mode_lib->vba.WritebackVRatio[k]
728c06986a4f38 Harry Wentland     2019-02-22  3595  											> mode_lib->vba.WritebackChromaVTaps[k]
728c06986a4f38 Harry Wentland     2019-02-22  3596  									|| (mode_lib->vba.WritebackChromaHTaps[k] > 2.0
728c06986a4f38 Harry Wentland     2019-02-22  3597  										&& ((mode_lib->vba.WritebackChromaHTaps[k] % 2) == 1))))) {
728c06986a4f38 Harry Wentland     2019-02-22  3598  				mode_lib->vba.WritebackScaleRatioAndTapsSupport = false;
728c06986a4f38 Harry Wentland     2019-02-22  3599  			}
728c06986a4f38 Harry Wentland     2019-02-22  3600  			if (mode_lib->vba.WritebackVRatio[k] < 1.0) {
728c06986a4f38 Harry Wentland     2019-02-22  3601  				mode_lib->vba.WritebackLumaVExtra =
728c06986a4f38 Harry Wentland     2019-02-22  3602  						dml_max(1.0 - 2.0 / dml_ceil(1.0 / mode_lib->vba.WritebackVRatio[k], 1.0), 0.0);
728c06986a4f38 Harry Wentland     2019-02-22  3603  			} else {
728c06986a4f38 Harry Wentland     2019-02-22  3604  				mode_lib->vba.WritebackLumaVExtra = -1;
728c06986a4f38 Harry Wentland     2019-02-22  3605  			}
728c06986a4f38 Harry Wentland     2019-02-22  3606  			if ((mode_lib->vba.WritebackPixelFormat[k] == dm_444_32
728c06986a4f38 Harry Wentland     2019-02-22  3607  					&& mode_lib->vba.WritebackLumaVTaps[k]
728c06986a4f38 Harry Wentland     2019-02-22  3608  							> (mode_lib->vba.WritebackLineBufferLumaBufferSize
728c06986a4f38 Harry Wentland     2019-02-22  3609  									+ mode_lib->vba.WritebackLineBufferChromaBufferSize)
728c06986a4f38 Harry Wentland     2019-02-22  3610  									/ 3.0
728c06986a4f38 Harry Wentland     2019-02-22  3611  									/ mode_lib->vba.WritebackDestinationWidth[k]
728c06986a4f38 Harry Wentland     2019-02-22  3612  									- mode_lib->vba.WritebackLumaVExtra)
728c06986a4f38 Harry Wentland     2019-02-22  3613  					|| (mode_lib->vba.WritebackPixelFormat[k] == dm_420_8
728c06986a4f38 Harry Wentland     2019-02-22  3614  							&& mode_lib->vba.WritebackLumaVTaps[k]
728c06986a4f38 Harry Wentland     2019-02-22  3615  									> mode_lib->vba.WritebackLineBufferLumaBufferSize
728c06986a4f38 Harry Wentland     2019-02-22  3616  											* 8.0 / 10.0 / mode_lib->vba.WritebackDestinationWidth[k]
728c06986a4f38 Harry Wentland     2019-02-22  3617  											- mode_lib->vba.WritebackLumaVExtra)
728c06986a4f38 Harry Wentland     2019-02-22  3618  					|| (mode_lib->vba.WritebackPixelFormat[k] == dm_420_10
728c06986a4f38 Harry Wentland     2019-02-22  3619  							&& mode_lib->vba.WritebackLumaVTaps[k]
728c06986a4f38 Harry Wentland     2019-02-22  3620  									> mode_lib->vba.WritebackLineBufferLumaBufferSize
728c06986a4f38 Harry Wentland     2019-02-22  3621  											* 8.0 / 10.0
728c06986a4f38 Harry Wentland     2019-02-22  3622  											/ mode_lib->vba.WritebackDestinationWidth[k]
728c06986a4f38 Harry Wentland     2019-02-22  3623  											- mode_lib->vba.WritebackLumaVExtra)) {
728c06986a4f38 Harry Wentland     2019-02-22  3624  				mode_lib->vba.WritebackScaleRatioAndTapsSupport = false;
728c06986a4f38 Harry Wentland     2019-02-22  3625  			}
728c06986a4f38 Harry Wentland     2019-02-22  3626  			if (2.0 * mode_lib->vba.WritebackVRatio[k] < 1) {
728c06986a4f38 Harry Wentland     2019-02-22  3627  				mode_lib->vba.WritebackChromaVExtra = 0.0;
728c06986a4f38 Harry Wentland     2019-02-22  3628  			} else {
728c06986a4f38 Harry Wentland     2019-02-22  3629  				mode_lib->vba.WritebackChromaVExtra = -1;
728c06986a4f38 Harry Wentland     2019-02-22  3630  			}
728c06986a4f38 Harry Wentland     2019-02-22  3631  			if ((mode_lib->vba.WritebackPixelFormat[k] == dm_420_8
728c06986a4f38 Harry Wentland     2019-02-22  3632  					&& mode_lib->vba.WritebackChromaVTaps[k]
728c06986a4f38 Harry Wentland     2019-02-22  3633  							> mode_lib->vba.WritebackLineBufferChromaBufferSize
728c06986a4f38 Harry Wentland     2019-02-22  3634  									* 8.0 / 10.0 / mode_lib->vba.WritebackDestinationWidth[k]
728c06986a4f38 Harry Wentland     2019-02-22  3635  									- mode_lib->vba.WritebackChromaVExtra)
728c06986a4f38 Harry Wentland     2019-02-22  3636  					|| (mode_lib->vba.WritebackPixelFormat[k] == dm_420_10
728c06986a4f38 Harry Wentland     2019-02-22  3637  							&& mode_lib->vba.WritebackChromaVTaps[k]
728c06986a4f38 Harry Wentland     2019-02-22  3638  									> mode_lib->vba.WritebackLineBufferChromaBufferSize
728c06986a4f38 Harry Wentland     2019-02-22  3639  											* 8.0 / 10.0
728c06986a4f38 Harry Wentland     2019-02-22  3640  											/ mode_lib->vba.WritebackDestinationWidth[k]
728c06986a4f38 Harry Wentland     2019-02-22  3641  											- mode_lib->vba.WritebackChromaVExtra)) {
728c06986a4f38 Harry Wentland     2019-02-22  3642  				mode_lib->vba.WritebackScaleRatioAndTapsSupport = false;
728c06986a4f38 Harry Wentland     2019-02-22  3643  			}
728c06986a4f38 Harry Wentland     2019-02-22  3644  		}
728c06986a4f38 Harry Wentland     2019-02-22  3645  	}
728c06986a4f38 Harry Wentland     2019-02-22  3646  	/*Maximum DISPCLK/DPPCLK Support check*/
728c06986a4f38 Harry Wentland     2019-02-22  3647  
728c06986a4f38 Harry Wentland     2019-02-22  3648  	mode_lib->vba.WritebackRequiredDISPCLK = 0.0;
728c06986a4f38 Harry Wentland     2019-02-22  3649  	for (k = 0; k <= mode_lib->vba.NumberOfActivePlanes - 1; k++) {
728c06986a4f38 Harry Wentland     2019-02-22  3650  		if (mode_lib->vba.WritebackEnable[k] == true) {
728c06986a4f38 Harry Wentland     2019-02-22  3651  			mode_lib->vba.WritebackRequiredDISPCLK =
728c06986a4f38 Harry Wentland     2019-02-22  3652  					dml_max(
728c06986a4f38 Harry Wentland     2019-02-22  3653  							mode_lib->vba.WritebackRequiredDISPCLK,
728c06986a4f38 Harry Wentland     2019-02-22  3654  							CalculateWriteBackDISPCLK(
728c06986a4f38 Harry Wentland     2019-02-22  3655  									mode_lib->vba.WritebackPixelFormat[k],
728c06986a4f38 Harry Wentland     2019-02-22  3656  									mode_lib->vba.PixelClock[k],
728c06986a4f38 Harry Wentland     2019-02-22  3657  									mode_lib->vba.WritebackHRatio[k],
728c06986a4f38 Harry Wentland     2019-02-22  3658  									mode_lib->vba.WritebackVRatio[k],
728c06986a4f38 Harry Wentland     2019-02-22  3659  									mode_lib->vba.WritebackLumaHTaps[k],
728c06986a4f38 Harry Wentland     2019-02-22  3660  									mode_lib->vba.WritebackLumaVTaps[k],
728c06986a4f38 Harry Wentland     2019-02-22  3661  									mode_lib->vba.WritebackChromaHTaps[k],
728c06986a4f38 Harry Wentland     2019-02-22  3662  									mode_lib->vba.WritebackChromaVTaps[k],
728c06986a4f38 Harry Wentland     2019-02-22  3663  									mode_lib->vba.WritebackDestinationWidth[k],
728c06986a4f38 Harry Wentland     2019-02-22  3664  									mode_lib->vba.HTotal[k],
728c06986a4f38 Harry Wentland     2019-02-22  3665  									mode_lib->vba.WritebackChromaLineBufferWidth));
728c06986a4f38 Harry Wentland     2019-02-22  3666  		}
728c06986a4f38 Harry Wentland     2019-02-22  3667  	}
728c06986a4f38 Harry Wentland     2019-02-22  3668  	for (k = 0; k <= mode_lib->vba.NumberOfActivePlanes - 1; k++) {
728c06986a4f38 Harry Wentland     2019-02-22  3669  		if (mode_lib->vba.HRatio[k] > 1.0) {
728c06986a4f38 Harry Wentland     2019-02-22  3670  			locals->PSCL_FACTOR[k] = dml_min(
728c06986a4f38 Harry Wentland     2019-02-22  3671  					mode_lib->vba.MaxDCHUBToPSCLThroughput,
728c06986a4f38 Harry Wentland     2019-02-22  3672  					mode_lib->vba.MaxPSCLToLBThroughput
728c06986a4f38 Harry Wentland     2019-02-22  3673  							* mode_lib->vba.HRatio[k]
728c06986a4f38 Harry Wentland     2019-02-22  3674  							/ dml_ceil(
728c06986a4f38 Harry Wentland     2019-02-22  3675  									mode_lib->vba.htaps[k]
728c06986a4f38 Harry Wentland     2019-02-22  3676  											/ 6.0,
728c06986a4f38 Harry Wentland     2019-02-22  3677  									1.0));
728c06986a4f38 Harry Wentland     2019-02-22  3678  		} else {
728c06986a4f38 Harry Wentland     2019-02-22  3679  			locals->PSCL_FACTOR[k] = dml_min(
728c06986a4f38 Harry Wentland     2019-02-22  3680  					mode_lib->vba.MaxDCHUBToPSCLThroughput,
728c06986a4f38 Harry Wentland     2019-02-22  3681  					mode_lib->vba.MaxPSCLToLBThroughput);
728c06986a4f38 Harry Wentland     2019-02-22  3682  		}
728c06986a4f38 Harry Wentland     2019-02-22  3683  		if (locals->BytePerPixelInDETC[k] == 0.0) {
728c06986a4f38 Harry Wentland     2019-02-22  3684  			locals->PSCL_FACTOR_CHROMA[k] = 0.0;
728c06986a4f38 Harry Wentland     2019-02-22  3685  			locals->MinDPPCLKUsingSingleDPP[k] =
728c06986a4f38 Harry Wentland     2019-02-22  3686  					mode_lib->vba.PixelClock[k]
728c06986a4f38 Harry Wentland     2019-02-22  3687  							* dml_max3(
728c06986a4f38 Harry Wentland     2019-02-22  3688  									mode_lib->vba.vtaps[k] / 6.0
728c06986a4f38 Harry Wentland     2019-02-22  3689  											* dml_min(
728c06986a4f38 Harry Wentland     2019-02-22  3690  													1.0,
728c06986a4f38 Harry Wentland     2019-02-22  3691  													mode_lib->vba.HRatio[k]),
728c06986a4f38 Harry Wentland     2019-02-22  3692  									mode_lib->vba.HRatio[k]
728c06986a4f38 Harry Wentland     2019-02-22  3693  											* mode_lib->vba.VRatio[k]
728c06986a4f38 Harry Wentland     2019-02-22  3694  											/ locals->PSCL_FACTOR[k],
728c06986a4f38 Harry Wentland     2019-02-22  3695  									1.0);
728c06986a4f38 Harry Wentland     2019-02-22  3696  			if ((mode_lib->vba.htaps[k] > 6.0 || mode_lib->vba.vtaps[k] > 6.0)
728c06986a4f38 Harry Wentland     2019-02-22  3697  					&& locals->MinDPPCLKUsingSingleDPP[k]
728c06986a4f38 Harry Wentland     2019-02-22  3698  							< 2.0 * mode_lib->vba.PixelClock[k]) {
728c06986a4f38 Harry Wentland     2019-02-22  3699  				locals->MinDPPCLKUsingSingleDPP[k] = 2.0
728c06986a4f38 Harry Wentland     2019-02-22  3700  						* mode_lib->vba.PixelClock[k];
728c06986a4f38 Harry Wentland     2019-02-22  3701  			}
728c06986a4f38 Harry Wentland     2019-02-22  3702  		} else {
728c06986a4f38 Harry Wentland     2019-02-22  3703  			if (mode_lib->vba.HRatio[k] / 2.0 > 1.0) {
728c06986a4f38 Harry Wentland     2019-02-22  3704  				locals->PSCL_FACTOR_CHROMA[k] =
728c06986a4f38 Harry Wentland     2019-02-22  3705  						dml_min(
728c06986a4f38 Harry Wentland     2019-02-22  3706  								mode_lib->vba.MaxDCHUBToPSCLThroughput,
728c06986a4f38 Harry Wentland     2019-02-22  3707  								mode_lib->vba.MaxPSCLToLBThroughput
728c06986a4f38 Harry Wentland     2019-02-22  3708  										* mode_lib->vba.HRatio[k]
728c06986a4f38 Harry Wentland     2019-02-22  3709  										/ 2.0
728c06986a4f38 Harry Wentland     2019-02-22  3710  										/ dml_ceil(
728c06986a4f38 Harry Wentland     2019-02-22  3711  												mode_lib->vba.HTAPsChroma[k]
728c06986a4f38 Harry Wentland     2019-02-22  3712  														/ 6.0,
728c06986a4f38 Harry Wentland     2019-02-22  3713  												1.0));
728c06986a4f38 Harry Wentland     2019-02-22  3714  			} else {
728c06986a4f38 Harry Wentland     2019-02-22  3715  				locals->PSCL_FACTOR_CHROMA[k] = dml_min(
728c06986a4f38 Harry Wentland     2019-02-22  3716  						mode_lib->vba.MaxDCHUBToPSCLThroughput,
728c06986a4f38 Harry Wentland     2019-02-22  3717  						mode_lib->vba.MaxPSCLToLBThroughput);
728c06986a4f38 Harry Wentland     2019-02-22  3718  			}
728c06986a4f38 Harry Wentland     2019-02-22  3719  			locals->MinDPPCLKUsingSingleDPP[k] =
728c06986a4f38 Harry Wentland     2019-02-22  3720  					mode_lib->vba.PixelClock[k]
728c06986a4f38 Harry Wentland     2019-02-22  3721  							* dml_max5(
728c06986a4f38 Harry Wentland     2019-02-22  3722  									mode_lib->vba.vtaps[k] / 6.0
728c06986a4f38 Harry Wentland     2019-02-22  3723  											* dml_min(
728c06986a4f38 Harry Wentland     2019-02-22  3724  													1.0,
728c06986a4f38 Harry Wentland     2019-02-22  3725  													mode_lib->vba.HRatio[k]),
728c06986a4f38 Harry Wentland     2019-02-22  3726  									mode_lib->vba.HRatio[k]
728c06986a4f38 Harry Wentland     2019-02-22  3727  											* mode_lib->vba.VRatio[k]
728c06986a4f38 Harry Wentland     2019-02-22  3728  											/ locals->PSCL_FACTOR[k],
728c06986a4f38 Harry Wentland     2019-02-22  3729  									mode_lib->vba.VTAPsChroma[k]
728c06986a4f38 Harry Wentland     2019-02-22  3730  											/ 6.0
728c06986a4f38 Harry Wentland     2019-02-22  3731  											* dml_min(
728c06986a4f38 Harry Wentland     2019-02-22  3732  													1.0,
728c06986a4f38 Harry Wentland     2019-02-22  3733  													mode_lib->vba.HRatio[k]
728c06986a4f38 Harry Wentland     2019-02-22  3734  															/ 2.0),
728c06986a4f38 Harry Wentland     2019-02-22  3735  									mode_lib->vba.HRatio[k]
728c06986a4f38 Harry Wentland     2019-02-22  3736  											* mode_lib->vba.VRatio[k]
728c06986a4f38 Harry Wentland     2019-02-22  3737  											/ 4.0
728c06986a4f38 Harry Wentland     2019-02-22  3738  											/ locals->PSCL_FACTOR_CHROMA[k],
728c06986a4f38 Harry Wentland     2019-02-22  3739  									1.0);
728c06986a4f38 Harry Wentland     2019-02-22  3740  			if ((mode_lib->vba.htaps[k] > 6.0 || mode_lib->vba.vtaps[k] > 6.0
728c06986a4f38 Harry Wentland     2019-02-22  3741  					|| mode_lib->vba.HTAPsChroma[k] > 6.0
728c06986a4f38 Harry Wentland     2019-02-22  3742  					|| mode_lib->vba.VTAPsChroma[k] > 6.0)
728c06986a4f38 Harry Wentland     2019-02-22  3743  					&& locals->MinDPPCLKUsingSingleDPP[k]
728c06986a4f38 Harry Wentland     2019-02-22  3744  							< 2.0 * mode_lib->vba.PixelClock[k]) {
728c06986a4f38 Harry Wentland     2019-02-22  3745  				locals->MinDPPCLKUsingSingleDPP[k] = 2.0
728c06986a4f38 Harry Wentland     2019-02-22  3746  						* mode_lib->vba.PixelClock[k];
728c06986a4f38 Harry Wentland     2019-02-22  3747  			}
728c06986a4f38 Harry Wentland     2019-02-22  3748  		}
728c06986a4f38 Harry Wentland     2019-02-22  3749  	}
728c06986a4f38 Harry Wentland     2019-02-22  3750  	for (k = 0; k <= mode_lib->vba.NumberOfActivePlanes - 1; k++) {
728c06986a4f38 Harry Wentland     2019-02-22  3751  		Calculate256BBlockSizes(
728c06986a4f38 Harry Wentland     2019-02-22  3752  				mode_lib->vba.SourcePixelFormat[k],
728c06986a4f38 Harry Wentland     2019-02-22  3753  				mode_lib->vba.SurfaceTiling[k],
728c06986a4f38 Harry Wentland     2019-02-22  3754  				dml_ceil(locals->BytePerPixelInDETY[k], 1.0),
728c06986a4f38 Harry Wentland     2019-02-22  3755  				dml_ceil(locals->BytePerPixelInDETC[k], 2.0),
728c06986a4f38 Harry Wentland     2019-02-22  3756  				&locals->Read256BlockHeightY[k],
728c06986a4f38 Harry Wentland     2019-02-22  3757  				&locals->Read256BlockHeightC[k],
728c06986a4f38 Harry Wentland     2019-02-22  3758  				&locals->Read256BlockWidthY[k],
728c06986a4f38 Harry Wentland     2019-02-22  3759  				&locals->Read256BlockWidthC[k]);
728c06986a4f38 Harry Wentland     2019-02-22  3760  		if (mode_lib->vba.SourceScan[k] == dm_horz) {
728c06986a4f38 Harry Wentland     2019-02-22  3761  			locals->MaxSwathHeightY[k] = locals->Read256BlockHeightY[k];
728c06986a4f38 Harry Wentland     2019-02-22  3762  			locals->MaxSwathHeightC[k] = locals->Read256BlockHeightC[k];
728c06986a4f38 Harry Wentland     2019-02-22  3763  		} else {
728c06986a4f38 Harry Wentland     2019-02-22  3764  			locals->MaxSwathHeightY[k] = locals->Read256BlockWidthY[k];
728c06986a4f38 Harry Wentland     2019-02-22  3765  			locals->MaxSwathHeightC[k] = locals->Read256BlockWidthC[k];
728c06986a4f38 Harry Wentland     2019-02-22  3766  		}
728c06986a4f38 Harry Wentland     2019-02-22  3767  		if ((mode_lib->vba.SourcePixelFormat[k] == dm_444_64
728c06986a4f38 Harry Wentland     2019-02-22  3768  				|| mode_lib->vba.SourcePixelFormat[k] == dm_444_32
728c06986a4f38 Harry Wentland     2019-02-22  3769  				|| mode_lib->vba.SourcePixelFormat[k] == dm_444_16
728c06986a4f38 Harry Wentland     2019-02-22  3770  				|| mode_lib->vba.SourcePixelFormat[k] == dm_mono_16
728c06986a4f38 Harry Wentland     2019-02-22  3771  				|| mode_lib->vba.SourcePixelFormat[k] == dm_mono_8)) {
728c06986a4f38 Harry Wentland     2019-02-22  3772  			if (mode_lib->vba.SurfaceTiling[k] == dm_sw_linear
728c06986a4f38 Harry Wentland     2019-02-22  3773  					|| (mode_lib->vba.SourcePixelFormat[k] == dm_444_64
728c06986a4f38 Harry Wentland     2019-02-22  3774  							&& (mode_lib->vba.SurfaceTiling[k]
728c06986a4f38 Harry Wentland     2019-02-22  3775  									== dm_sw_4kb_s
728c06986a4f38 Harry Wentland     2019-02-22  3776  									|| mode_lib->vba.SurfaceTiling[k]
728c06986a4f38 Harry Wentland     2019-02-22  3777  											== dm_sw_4kb_s_x
728c06986a4f38 Harry Wentland     2019-02-22  3778  									|| mode_lib->vba.SurfaceTiling[k]
728c06986a4f38 Harry Wentland     2019-02-22  3779  											== dm_sw_64kb_s
728c06986a4f38 Harry Wentland     2019-02-22  3780  									|| mode_lib->vba.SurfaceTiling[k]
728c06986a4f38 Harry Wentland     2019-02-22  3781  											== dm_sw_64kb_s_t
728c06986a4f38 Harry Wentland     2019-02-22  3782  									|| mode_lib->vba.SurfaceTiling[k]
728c06986a4f38 Harry Wentland     2019-02-22  3783  											== dm_sw_64kb_s_x
728c06986a4f38 Harry Wentland     2019-02-22  3784  									|| mode_lib->vba.SurfaceTiling[k]
728c06986a4f38 Harry Wentland     2019-02-22  3785  											== dm_sw_var_s
728c06986a4f38 Harry Wentland     2019-02-22  3786  									|| mode_lib->vba.SurfaceTiling[k]
728c06986a4f38 Harry Wentland     2019-02-22  3787  											== dm_sw_var_s_x)
728c06986a4f38 Harry Wentland     2019-02-22  3788  							&& mode_lib->vba.SourceScan[k] == dm_horz)) {
728c06986a4f38 Harry Wentland     2019-02-22  3789  				locals->MinSwathHeightY[k] = locals->MaxSwathHeightY[k];
728c06986a4f38 Harry Wentland     2019-02-22  3790  			} else {
728c06986a4f38 Harry Wentland     2019-02-22  3791  				locals->MinSwathHeightY[k] = locals->MaxSwathHeightY[k]
728c06986a4f38 Harry Wentland     2019-02-22  3792  						/ 2.0;
728c06986a4f38 Harry Wentland     2019-02-22  3793  			}
728c06986a4f38 Harry Wentland     2019-02-22  3794  			locals->MinSwathHeightC[k] = locals->MaxSwathHeightC[k];
728c06986a4f38 Harry Wentland     2019-02-22  3795  		} else {
728c06986a4f38 Harry Wentland     2019-02-22  3796  			if (mode_lib->vba.SurfaceTiling[k] == dm_sw_linear) {
728c06986a4f38 Harry Wentland     2019-02-22  3797  				locals->MinSwathHeightY[k] = locals->MaxSwathHeightY[k];
728c06986a4f38 Harry Wentland     2019-02-22  3798  				locals->MinSwathHeightC[k] = locals->MaxSwathHeightC[k];
728c06986a4f38 Harry Wentland     2019-02-22  3799  			} else if (mode_lib->vba.SourcePixelFormat[k] == dm_420_8
728c06986a4f38 Harry Wentland     2019-02-22  3800  					&& mode_lib->vba.SourceScan[k] == dm_horz) {
728c06986a4f38 Harry Wentland     2019-02-22  3801  				locals->MinSwathHeightY[k] = locals->MaxSwathHeightY[k]
728c06986a4f38 Harry Wentland     2019-02-22  3802  						/ 2.0;
728c06986a4f38 Harry Wentland     2019-02-22  3803  				locals->MinSwathHeightC[k] = locals->MaxSwathHeightC[k];
728c06986a4f38 Harry Wentland     2019-02-22  3804  			} else if (mode_lib->vba.SourcePixelFormat[k] == dm_420_10
728c06986a4f38 Harry Wentland     2019-02-22  3805  					&& mode_lib->vba.SourceScan[k] == dm_horz) {
728c06986a4f38 Harry Wentland     2019-02-22  3806  				locals->MinSwathHeightC[k] = locals->MaxSwathHeightC[k]
728c06986a4f38 Harry Wentland     2019-02-22  3807  						/ 2.0;
728c06986a4f38 Harry Wentland     2019-02-22  3808  				locals->MinSwathHeightY[k] = locals->MaxSwathHeightY[k];
728c06986a4f38 Harry Wentland     2019-02-22  3809  			} else {
728c06986a4f38 Harry Wentland     2019-02-22  3810  				locals->MinSwathHeightY[k] = locals->MaxSwathHeightY[k];
728c06986a4f38 Harry Wentland     2019-02-22  3811  				locals->MinSwathHeightC[k] = locals->MaxSwathHeightC[k];
728c06986a4f38 Harry Wentland     2019-02-22  3812  			}
728c06986a4f38 Harry Wentland     2019-02-22  3813  		}
728c06986a4f38 Harry Wentland     2019-02-22  3814  		if (mode_lib->vba.SurfaceTiling[k] == dm_sw_linear) {
728c06986a4f38 Harry Wentland     2019-02-22  3815  			mode_lib->vba.MaximumSwathWidthSupport = 8192.0;
728c06986a4f38 Harry Wentland     2019-02-22  3816  		} else {
728c06986a4f38 Harry Wentland     2019-02-22  3817  			mode_lib->vba.MaximumSwathWidthSupport = 5120.0;
728c06986a4f38 Harry Wentland     2019-02-22  3818  		}
728c06986a4f38 Harry Wentland     2019-02-22  3819  		mode_lib->vba.MaximumSwathWidthInDETBuffer =
728c06986a4f38 Harry Wentland     2019-02-22  3820  				dml_min(
728c06986a4f38 Harry Wentland     2019-02-22  3821  						mode_lib->vba.MaximumSwathWidthSupport,
4469201b19354a Chaitanya Dhere    2021-04-20  3822  						mode_lib->vba.DETBufferSizeInKByte[0] * 1024.0 / 2.0
728c06986a4f38 Harry Wentland     2019-02-22  3823  								/ (locals->BytePerPixelInDETY[k]
728c06986a4f38 Harry Wentland     2019-02-22  3824  										* locals->MinSwathHeightY[k]
728c06986a4f38 Harry Wentland     2019-02-22  3825  										+ locals->BytePerPixelInDETC[k]
728c06986a4f38 Harry Wentland     2019-02-22  3826  												/ 2.0
728c06986a4f38 Harry Wentland     2019-02-22  3827  												* locals->MinSwathHeightC[k]));
728c06986a4f38 Harry Wentland     2019-02-22  3828  		if (locals->BytePerPixelInDETC[k] == 0.0) {
728c06986a4f38 Harry Wentland     2019-02-22  3829  			mode_lib->vba.MaximumSwathWidthInLineBuffer =
728c06986a4f38 Harry Wentland     2019-02-22  3830  					mode_lib->vba.LineBufferSize
728c06986a4f38 Harry Wentland     2019-02-22  3831  							* dml_max(mode_lib->vba.HRatio[k], 1.0)
728c06986a4f38 Harry Wentland     2019-02-22  3832  							/ mode_lib->vba.LBBitPerPixel[k]
728c06986a4f38 Harry Wentland     2019-02-22  3833  							/ (mode_lib->vba.vtaps[k]
728c06986a4f38 Harry Wentland     2019-02-22  3834  									+ dml_max(
728c06986a4f38 Harry Wentland     2019-02-22  3835  											dml_ceil(
728c06986a4f38 Harry Wentland     2019-02-22  3836  													mode_lib->vba.VRatio[k],
728c06986a4f38 Harry Wentland     2019-02-22  3837  													1.0)
728c06986a4f38 Harry Wentland     2019-02-22  3838  													- 2,
728c06986a4f38 Harry Wentland     2019-02-22  3839  											0.0));
728c06986a4f38 Harry Wentland     2019-02-22  3840  		} else {
728c06986a4f38 Harry Wentland     2019-02-22  3841  			mode_lib->vba.MaximumSwathWidthInLineBuffer =
728c06986a4f38 Harry Wentland     2019-02-22  3842  					dml_min(
728c06986a4f38 Harry Wentland     2019-02-22  3843  							mode_lib->vba.LineBufferSize
728c06986a4f38 Harry Wentland     2019-02-22  3844  									* dml_max(
728c06986a4f38 Harry Wentland     2019-02-22  3845  											mode_lib->vba.HRatio[k],
728c06986a4f38 Harry Wentland     2019-02-22  3846  											1.0)
728c06986a4f38 Harry Wentland     2019-02-22  3847  									/ mode_lib->vba.LBBitPerPixel[k]
728c06986a4f38 Harry Wentland     2019-02-22  3848  									/ (mode_lib->vba.vtaps[k]
728c06986a4f38 Harry Wentland     2019-02-22  3849  											+ dml_max(
728c06986a4f38 Harry Wentland     2019-02-22  3850  													dml_ceil(
728c06986a4f38 Harry Wentland     2019-02-22  3851  															mode_lib->vba.VRatio[k],
728c06986a4f38 Harry Wentland     2019-02-22  3852  															1.0)
728c06986a4f38 Harry Wentland     2019-02-22  3853  															- 2,
728c06986a4f38 Harry Wentland     2019-02-22  3854  													0.0)),
728c06986a4f38 Harry Wentland     2019-02-22  3855  							2.0 * mode_lib->vba.LineBufferSize
728c06986a4f38 Harry Wentland     2019-02-22  3856  									* dml_max(
728c06986a4f38 Harry Wentland     2019-02-22  3857  											mode_lib->vba.HRatio[k]
728c06986a4f38 Harry Wentland     2019-02-22  3858  													/ 2.0,
728c06986a4f38 Harry Wentland     2019-02-22  3859  											1.0)
728c06986a4f38 Harry Wentland     2019-02-22  3860  									/ mode_lib->vba.LBBitPerPixel[k]
728c06986a4f38 Harry Wentland     2019-02-22  3861  									/ (mode_lib->vba.VTAPsChroma[k]
728c06986a4f38 Harry Wentland     2019-02-22  3862  											+ dml_max(
728c06986a4f38 Harry Wentland     2019-02-22  3863  													dml_ceil(
728c06986a4f38 Harry Wentland     2019-02-22  3864  															mode_lib->vba.VRatio[k]
728c06986a4f38 Harry Wentland     2019-02-22  3865  																	/ 2.0,
728c06986a4f38 Harry Wentland     2019-02-22  3866  															1.0)
728c06986a4f38 Harry Wentland     2019-02-22  3867  															- 2,
728c06986a4f38 Harry Wentland     2019-02-22  3868  													0.0)));
728c06986a4f38 Harry Wentland     2019-02-22  3869  		}
728c06986a4f38 Harry Wentland     2019-02-22  3870  		locals->MaximumSwathWidth[k] = dml_min(
728c06986a4f38 Harry Wentland     2019-02-22  3871  				mode_lib->vba.MaximumSwathWidthInDETBuffer,
728c06986a4f38 Harry Wentland     2019-02-22  3872  				mode_lib->vba.MaximumSwathWidthInLineBuffer);
728c06986a4f38 Harry Wentland     2019-02-22  3873  	}
728c06986a4f38 Harry Wentland     2019-02-22  3874  	for (i = 0; i <= mode_lib->vba.soc.num_states; i++) {
728c06986a4f38 Harry Wentland     2019-02-22  3875  		for (j = 0; j < 2; j++) {
728c06986a4f38 Harry Wentland     2019-02-22  3876  			mode_lib->vba.MaxDispclkRoundedDownToDFSGranularity = RoundToDFSGranularityDown(
728c06986a4f38 Harry Wentland     2019-02-22  3877  				mode_lib->vba.MaxDispclk[i],
728c06986a4f38 Harry Wentland     2019-02-22  3878  				mode_lib->vba.DISPCLKDPPCLKVCOSpeed);
728c06986a4f38 Harry Wentland     2019-02-22  3879  			mode_lib->vba.MaxDppclkRoundedDownToDFSGranularity = RoundToDFSGranularityDown(
728c06986a4f38 Harry Wentland     2019-02-22  3880  				mode_lib->vba.MaxDppclk[i],
728c06986a4f38 Harry Wentland     2019-02-22  3881  				mode_lib->vba.DISPCLKDPPCLKVCOSpeed);
728c06986a4f38 Harry Wentland     2019-02-22  3882  			locals->RequiredDISPCLK[i][j] = 0.0;
728c06986a4f38 Harry Wentland     2019-02-22  3883  			locals->DISPCLK_DPPCLK_Support[i][j] = true;
728c06986a4f38 Harry Wentland     2019-02-22  3884  			for (k = 0; k <= mode_lib->vba.NumberOfActivePlanes - 1; k++) {
728c06986a4f38 Harry Wentland     2019-02-22  3885  				mode_lib->vba.PlaneRequiredDISPCLKWithoutODMCombine =
728c06986a4f38 Harry Wentland     2019-02-22  3886  						mode_lib->vba.PixelClock[k] * (1.0 + mode_lib->vba.DISPCLKDPPCLKDSCCLKDownSpreading / 100.0)
728c06986a4f38 Harry Wentland     2019-02-22  3887  								* (1.0 + mode_lib->vba.DISPCLKRampingMargin / 100.0);
728c06986a4f38 Harry Wentland     2019-02-22  3888  				if (mode_lib->vba.PlaneRequiredDISPCLKWithoutODMCombine >= mode_lib->vba.MaxDispclk[i]
728c06986a4f38 Harry Wentland     2019-02-22  3889  						&& i == mode_lib->vba.soc.num_states)
728c06986a4f38 Harry Wentland     2019-02-22  3890  					mode_lib->vba.PlaneRequiredDISPCLKWithoutODMCombine = mode_lib->vba.PixelClock[k]
728c06986a4f38 Harry Wentland     2019-02-22  3891  							* (1 + mode_lib->vba.DISPCLKDPPCLKDSCCLKDownSpreading / 100.0);
728c06986a4f38 Harry Wentland     2019-02-22  3892  
728c06986a4f38 Harry Wentland     2019-02-22  3893  				mode_lib->vba.PlaneRequiredDISPCLKWithODMCombine = mode_lib->vba.PixelClock[k] / 2
728c06986a4f38 Harry Wentland     2019-02-22  3894  					* (1 + mode_lib->vba.DISPCLKDPPCLKDSCCLKDownSpreading / 100.0) * (1 + mode_lib->vba.DISPCLKRampingMargin / 100.0);
728c06986a4f38 Harry Wentland     2019-02-22  3895  				if (mode_lib->vba.PlaneRequiredDISPCLKWithODMCombine >= mode_lib->vba.MaxDispclk[i]
728c06986a4f38 Harry Wentland     2019-02-22  3896  						&& i == mode_lib->vba.soc.num_states)
728c06986a4f38 Harry Wentland     2019-02-22  3897  					mode_lib->vba.PlaneRequiredDISPCLKWithODMCombine = mode_lib->vba.PixelClock[k] / 2
728c06986a4f38 Harry Wentland     2019-02-22  3898  							* (1 + mode_lib->vba.DISPCLKDPPCLKDSCCLKDownSpreading / 100.0);
d478667253f988 Wenjing Liu        2020-01-13  3899  
728c06986a4f38 Harry Wentland     2019-02-22 @3900  				locals->ODMCombineEnablePerState[i][k] = false;

:::::: The code at line 3900 was first introduced by commit
:::::: 728c06986a4f386c7ec5e5170716e30b610c6d32 drm/amd/display: Add DCN2 changes to DML

:::::: TO: Harry Wentland <harry.wentland@amd.com>
:::::: CC: Alex Deucher <alexander.deucher@amd.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

--P8tatnxojuL4V9YI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=config

#
# Automatically generated file; DO NOT EDIT.
# Linux/arm64 6.1.0-rc1 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="aarch64-linux-gcc (GCC) 12.1.0"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=120100
CONFIG_CLANG_VERSION=0
CONFIG_AS_IS_GNU=y
CONFIG_AS_VERSION=23800
CONFIG_LD_IS_BFD=y
CONFIG_LD_VERSION=23800
CONFIG_LLD_VERSION=0
CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_CC_HAS_NO_PROFILE_FN_ATTR=y
CONFIG_PAHOLE_VERSION=123
CONFIG_CONSTRUCTORS=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_TABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
CONFIG_COMPILE_TEST=y
# CONFIG_WERROR is not set
CONFIG_LOCALVERSION=""
CONFIG_BUILD_SALT=""
CONFIG_DEFAULT_INIT=""
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_SYSVIPC_COMPAT=y
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
# CONFIG_WATCH_QUEUE is not set
# CONFIG_CROSS_MEMORY_ATTACH is not set
# CONFIG_USELIB is not set
CONFIG_AUDIT=y
CONFIG_HAVE_ARCH_AUDITSYSCALL=y
CONFIG_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_SHOW_LEVEL=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_GENERIC_IRQ_INJECTION=y
CONFIG_HARDIRQS_SW_RESEND=y
CONFIG_GENERIC_IRQ_CHIP=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_IRQ_FASTEOI_HIERARCHY_HANDLERS=y
CONFIG_GENERIC_IRQ_IPI=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
CONFIG_IRQ_MSI_IOMMU=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
CONFIG_GENERIC_IRQ_DEBUGFS=y
# end of IRQ subsystem

CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_ARCH_HAS_TICK_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_HAVE_POSIX_CPU_TIMERS_TASK_WORK=y
CONFIG_POSIX_CPU_TIMERS_TASK_WORK=y
CONFIG_TIME_KUNIT_TEST=y
CONFIG_CONTEXT_TRACKING=y
CONFIG_CONTEXT_TRACKING_IDLE=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
CONFIG_NO_HZ_IDLE=y
# CONFIG_NO_HZ_FULL is not set
# CONFIG_NO_HZ is not set
# CONFIG_HIGH_RES_TIMERS is not set
# end of Timers subsystem

CONFIG_BPF=y
CONFIG_HAVE_EBPF_JIT=y
CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y

#
# BPF subsystem
#
CONFIG_BPF_SYSCALL=y
# CONFIG_BPF_JIT is not set
CONFIG_BPF_UNPRIV_DEFAULT_OFF=y
# end of BPF subsystem

CONFIG_PREEMPT_NONE_BUILD=y
CONFIG_PREEMPT_NONE=y
# CONFIG_PREEMPT_VOLUNTARY is not set
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y
# CONFIG_PREEMPT_DYNAMIC is not set

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
# CONFIG_VIRT_CPU_ACCOUNTING_GEN is not set
CONFIG_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_SCHED_AVG_IRQ=y
# CONFIG_BSD_PROCESS_ACCT is not set
# CONFIG_TASKSTATS is not set
CONFIG_PSI=y
CONFIG_PSI_DEFAULT_DISABLED=y
# end of CPU/Task time and stats accounting

# CONFIG_CPU_ISOLATION is not set

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
CONFIG_RCU_EXPERT=y
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
# CONFIG_FORCE_TASKS_RCU is not set
CONFIG_FORCE_TASKS_RUDE_RCU=y
CONFIG_TASKS_RUDE_RCU=y
# CONFIG_FORCE_TASKS_TRACE_RCU is not set
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_FANOUT=64
CONFIG_RCU_FANOUT_LEAF=16
# CONFIG_RCU_NOCB_CPU is not set
CONFIG_TASKS_TRACE_RCU_READ_MB=y
# end of RCU Subsystem

CONFIG_IKCONFIG=m
# CONFIG_IKCONFIG_PROC is not set
CONFIG_IKHEADERS=m
CONFIG_GENERIC_SCHED_CLOCK=y

#
# Scheduler features
#
# end of Scheduler features

CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_CC_HAS_INT128=y
CONFIG_CC_IMPLICIT_FALLTHROUGH="-Wimplicit-fallthrough=5"
CONFIG_GCC12_NO_ARRAY_BOUNDS=y
CONFIG_CC_NO_ARRAY_BOUNDS=y
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_NUMA_BALANCING=y
CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
# CONFIG_CGROUP_FAVOR_DYNMODS is not set
CONFIG_MEMCG=y
# CONFIG_CGROUP_SCHED is not set
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
CONFIG_CGROUP_FREEZER=y
# CONFIG_CPUSETS is not set
# CONFIG_CGROUP_DEVICE is not set
CONFIG_CGROUP_CPUACCT=y
# CONFIG_CGROUP_PERF is not set
# CONFIG_CGROUP_BPF is not set
# CONFIG_CGROUP_MISC is not set
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
# CONFIG_TIME_NS is not set
CONFIG_IPC_NS=y
CONFIG_USER_NS=y
CONFIG_PID_NS=y
# CONFIG_NET_NS is not set
CONFIG_CHECKPOINT_RESTORE=y
# CONFIG_SCHED_AUTOGROUP is not set
# CONFIG_SYSFS_DEPRECATED is not set
# CONFIG_RELAY is not set
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
# CONFIG_RD_GZIP is not set
# CONFIG_RD_BZIP2 is not set
# CONFIG_RD_LZMA is not set
# CONFIG_RD_XZ is not set
CONFIG_RD_LZO=y
# CONFIG_RD_LZ4 is not set
CONFIG_RD_ZSTD=y
# CONFIG_BOOT_CONFIG is not set
# CONFIG_INITRAMFS_PRESERVE_MTIME is not set
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_LD_ORPHAN_WARN=y
CONFIG_SYSCTL=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_EXPERT=y
# CONFIG_UID16 is not set
CONFIG_MULTIUSER=y
# CONFIG_SGETMASK_SYSCALL is not set
# CONFIG_SYSFS_SYSCALL is not set
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
# CONFIG_PRINTK is not set
# CONFIG_BUG is not set
# CONFIG_ELF_CORE is not set
# CONFIG_BASE_FULL is not set
# CONFIG_FUTEX is not set
# CONFIG_EPOLL is not set
# CONFIG_SIGNALFD is not set
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_IO_URING=y
# CONFIG_ADVISE_SYSCALLS is not set
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_KCMP=y
# CONFIG_RSEQ is not set
CONFIG_EMBEDDED=y
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_PERF_USE_VMALLOC=y
# CONFIG_PC104 is not set

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
CONFIG_DEBUG_PERF_USE_VMALLOC=y
# end of Kernel Performance Events And Counters

CONFIG_SYSTEM_DATA_VERIFICATION=y
# CONFIG_PROFILING is not set
CONFIG_TRACEPOINTS=y
# end of General setup

CONFIG_ARM64=y
CONFIG_GCC_SUPPORTS_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_64BIT=y
CONFIG_MMU=y
CONFIG_ARM64_PAGE_SHIFT=12
CONFIG_ARM64_CONT_PTE_SHIFT=4
CONFIG_ARM64_CONT_PMD_SHIFT=4
CONFIG_ARCH_MMAP_RND_BITS_MIN=18
CONFIG_ARCH_MMAP_RND_BITS_MAX=24
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=11
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_GENERIC_CSUM=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE=y
CONFIG_SMP=y
CONFIG_KERNEL_MODE_NEON=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=3
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_ARCH_PROC_KCORE_TEXT=y

#
# Platform selection
#
# CONFIG_ARCH_ACTIONS is not set
# CONFIG_ARCH_SUNXI is not set
CONFIG_ARCH_ALPINE=y
# CONFIG_ARCH_APPLE is not set
# CONFIG_ARCH_BCM is not set
CONFIG_ARCH_BERLIN=y
CONFIG_ARCH_BITMAIN=y
CONFIG_ARCH_EXYNOS=y
CONFIG_ARCH_SPARX5=y
# CONFIG_ARCH_K3 is not set
CONFIG_ARCH_LG1K=y
# CONFIG_ARCH_HISI is not set
# CONFIG_ARCH_KEEMBAY is not set
# CONFIG_ARCH_MEDIATEK is not set
# CONFIG_ARCH_MESON is not set
CONFIG_ARCH_MVEBU=y
CONFIG_ARCH_NXP=y
# CONFIG_ARCH_LAYERSCAPE is not set
# CONFIG_ARCH_MXC is not set
CONFIG_ARCH_S32=y
CONFIG_ARCH_NPCM=y
CONFIG_ARCH_QCOM=y
CONFIG_ARCH_REALTEK=y
# CONFIG_ARCH_RENESAS is not set
# CONFIG_ARCH_ROCKCHIP is not set
# CONFIG_ARCH_SEATTLE is not set
# CONFIG_ARCH_INTEL_SOCFPGA is not set
# CONFIG_ARCH_SYNQUACER is not set
CONFIG_ARCH_TEGRA=y
CONFIG_ARCH_TESLA_FSD=y
# CONFIG_ARCH_SPRD is not set
CONFIG_ARCH_THUNDER=y
# CONFIG_ARCH_THUNDER2 is not set
# CONFIG_ARCH_UNIPHIER is not set
CONFIG_ARCH_VEXPRESS=y
CONFIG_ARCH_VISCONTI=y
CONFIG_ARCH_XGENE=y
# CONFIG_ARCH_ZYNQMP is not set
# end of Platform selection

#
# Kernel Features
#

#
# ARM errata workarounds via the alternatives framework
#
CONFIG_ARM64_WORKAROUND_CLEAN_CACHE=y
# CONFIG_ARM64_ERRATUM_826319 is not set
# CONFIG_ARM64_ERRATUM_827319 is not set
# CONFIG_ARM64_ERRATUM_824069 is not set
CONFIG_ARM64_ERRATUM_819472=y
# CONFIG_ARM64_ERRATUM_832075 is not set
CONFIG_ARM64_ERRATUM_1742098=y
# CONFIG_ARM64_ERRATUM_845719 is not set
# CONFIG_ARM64_ERRATUM_843419 is not set
CONFIG_ARM64_LD_HAS_FIX_ERRATUM_843419=y
CONFIG_ARM64_ERRATUM_1024718=y
# CONFIG_ARM64_ERRATUM_1418040 is not set
# CONFIG_ARM64_ERRATUM_1165522 is not set
# CONFIG_ARM64_ERRATUM_1319367 is not set
# CONFIG_ARM64_ERRATUM_1530923 is not set
CONFIG_ARM64_WORKAROUND_REPEAT_TLBI=y
# CONFIG_ARM64_ERRATUM_2441007 is not set
# CONFIG_ARM64_ERRATUM_1286807 is not set
# CONFIG_ARM64_ERRATUM_1463225 is not set
# CONFIG_ARM64_ERRATUM_1542419 is not set
CONFIG_ARM64_ERRATUM_1508412=y
# CONFIG_ARM64_ERRATUM_2051678 is not set
CONFIG_ARM64_ERRATUM_2077057=y
CONFIG_ARM64_ERRATUM_2658417=y
CONFIG_ARM64_WORKAROUND_TSB_FLUSH_FAILURE=y
CONFIG_ARM64_ERRATUM_2054223=y
# CONFIG_ARM64_ERRATUM_2067961 is not set
CONFIG_ARM64_ERRATUM_2441009=y
CONFIG_ARM64_ERRATUM_2457168=y
CONFIG_CAVIUM_ERRATUM_22375=y
# CONFIG_CAVIUM_ERRATUM_23144 is not set
# CONFIG_CAVIUM_ERRATUM_23154 is not set
# CONFIG_CAVIUM_ERRATUM_27456 is not set
# CONFIG_CAVIUM_ERRATUM_30115 is not set
CONFIG_CAVIUM_TX2_ERRATUM_219=y
# CONFIG_FUJITSU_ERRATUM_010001 is not set
CONFIG_HISILICON_ERRATUM_161600802=y
CONFIG_QCOM_FALKOR_ERRATUM_1003=y
CONFIG_QCOM_FALKOR_ERRATUM_1009=y
# CONFIG_QCOM_QDF2400_ERRATUM_0065 is not set
CONFIG_QCOM_FALKOR_ERRATUM_E1041=y
# CONFIG_NVIDIA_CARMEL_CNP_ERRATUM is not set
# CONFIG_SOCIONEXT_SYNQUACER_PREITS is not set
# end of ARM errata workarounds via the alternatives framework

CONFIG_ARM64_4K_PAGES=y
# CONFIG_ARM64_16K_PAGES is not set
# CONFIG_ARM64_64K_PAGES is not set
CONFIG_ARM64_VA_BITS_39=y
# CONFIG_ARM64_VA_BITS_48 is not set
CONFIG_ARM64_VA_BITS=39
CONFIG_ARM64_PA_BITS_48=y
CONFIG_ARM64_PA_BITS=48
CONFIG_CPU_BIG_ENDIAN=y
# CONFIG_CPU_LITTLE_ENDIAN is not set
CONFIG_SCHED_MC=y
# CONFIG_SCHED_CLUSTER is not set
# CONFIG_SCHED_SMT is not set
CONFIG_NR_CPUS=256
CONFIG_HOTPLUG_CPU=y
CONFIG_NUMA=y
CONFIG_NODES_SHIFT=4
# CONFIG_HZ_100 is not set
CONFIG_HZ_250=y
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=250
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_CC_HAVE_SHADOW_CALL_STACK=y
CONFIG_PARAVIRT=y
CONFIG_PARAVIRT_TIME_ACCOUNTING=y
# CONFIG_KEXEC_FILE is not set
CONFIG_CRASH_DUMP=y
CONFIG_XEN_DOM0=y
CONFIG_XEN=y
CONFIG_ARCH_FORCE_MAX_ORDER=11
# CONFIG_UNMAP_KERNEL_AT_EL0 is not set
# CONFIG_MITIGATE_SPECTRE_BRANCH_HISTORY is not set
CONFIG_RODATA_FULL_DEFAULT_ENABLED=y
# CONFIG_ARM64_SW_TTBR0_PAN is not set
CONFIG_ARM64_TAGGED_ADDR_ABI=y
CONFIG_COMPAT=y
# CONFIG_KUSER_HELPERS is not set
# CONFIG_COMPAT_ALIGNMENT_FIXUPS is not set
CONFIG_ARMV8_DEPRECATED=y
# CONFIG_SWP_EMULATION is not set
# CONFIG_CP15_BARRIER_EMULATION is not set
CONFIG_SETEND_EMULATION=y

#
# ARMv8.1 architectural features
#
# CONFIG_ARM64_HW_AFDBM is not set
CONFIG_ARM64_PAN=y
CONFIG_AS_HAS_LDAPR=y
CONFIG_AS_HAS_LSE_ATOMICS=y
# CONFIG_ARM64_USE_LSE_ATOMICS is not set
# end of ARMv8.1 architectural features

#
# ARMv8.2 architectural features
#
CONFIG_AS_HAS_ARMV8_2=y
CONFIG_AS_HAS_SHA3=y
CONFIG_ARM64_PMEM=y
# CONFIG_ARM64_RAS_EXTN is not set
# CONFIG_ARM64_CNP is not set
# end of ARMv8.2 architectural features

#
# ARMv8.3 architectural features
#
CONFIG_ARM64_PTR_AUTH=y
# CONFIG_ARM64_PTR_AUTH_KERNEL is not set
CONFIG_CC_HAS_BRANCH_PROT_PAC_RET=y
CONFIG_CC_HAS_SIGN_RETURN_ADDRESS=y
CONFIG_AS_HAS_PAC=y
CONFIG_AS_HAS_CFI_NEGATE_RA_STATE=y
# end of ARMv8.3 architectural features

#
# ARMv8.4 architectural features
#
CONFIG_ARM64_AMU_EXTN=y
CONFIG_AS_HAS_ARMV8_4=y
# CONFIG_ARM64_TLB_RANGE is not set
# end of ARMv8.4 architectural features

#
# ARMv8.5 architectural features
#
CONFIG_AS_HAS_ARMV8_5=y
# CONFIG_ARM64_BTI is not set
CONFIG_CC_HAS_BRANCH_PROT_PAC_RET_BTI=y
# CONFIG_ARM64_E0PD is not set
CONFIG_ARM64_AS_HAS_MTE=y
# CONFIG_ARM64_MTE is not set
# end of ARMv8.5 architectural features

#
# ARMv8.7 architectural features
#
# CONFIG_ARM64_EPAN is not set
# end of ARMv8.7 architectural features

# CONFIG_ARM64_SVE is not set
# CONFIG_ARM64_MODULE_PLTS is not set
CONFIG_ARM64_PSEUDO_NMI=y
CONFIG_ARM64_DEBUG_PRIORITY_MASKING=y
CONFIG_RELOCATABLE=y
# CONFIG_RANDOMIZE_BASE is not set
CONFIG_CC_HAVE_STACKPROTECTOR_SYSREG=y
CONFIG_ARCH_NR_GPIO=0
# end of Kernel Features

#
# Boot options
#
CONFIG_CMDLINE=""
# end of Boot options

#
# Power management options
#
# CONFIG_SUSPEND is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
CONFIG_PM_ADVANCED_DEBUG=y
# CONFIG_DPM_WATCHDOG is not set
CONFIG_PM_CLK=y
CONFIG_PM_GENERIC_DOMAINS=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
CONFIG_PM_GENERIC_DOMAINS_OF=y
# CONFIG_ENERGY_MODEL is not set
CONFIG_ARCH_SUSPEND_POSSIBLE=y
# end of Power management options

#
# CPU Power Management
#

#
# CPU Idle
#
# CONFIG_CPU_IDLE is not set
# end of CPU Idle

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
CONFIG_CPU_FREQ_STAT=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=m
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
# CONFIG_CPU_FREQ_GOV_CONSERVATIVE is not set
# CONFIG_CPU_FREQ_GOV_SCHEDUTIL is not set

#
# CPU frequency scaling drivers
#
CONFIG_CPUFREQ_DT=m
CONFIG_CPUFREQ_DT_PLATDEV=y
# CONFIG_ARM_ARMADA_37XX_CPUFREQ is not set
CONFIG_ARM_ARMADA_8K_CPUFREQ=m
CONFIG_ARM_BRCMSTB_AVS_CPUFREQ=y
CONFIG_ARM_MEDIATEK_CPUFREQ_HW=m
CONFIG_ARM_QCOM_CPUFREQ_NVMEM=m
CONFIG_ARM_QCOM_CPUFREQ_HW=m
CONFIG_ARM_RASPBERRYPI_CPUFREQ=m
CONFIG_ARM_SCMI_CPUFREQ=y
CONFIG_ARM_TEGRA20_CPUFREQ=m
CONFIG_ARM_TEGRA124_CPUFREQ=y
CONFIG_QORIQ_CPUFREQ=m
# end of CPU Frequency scaling
# end of CPU Power Management

CONFIG_HAVE_KVM=y
CONFIG_VIRTUALIZATION=y
# CONFIG_KVM is not set

#
# General architecture-dependent options
#
CONFIG_KPROBES=y
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_KRETPROBES=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_ARCH_CORRECT_STACKTRACE_ON_KRETPROBE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_TRACE_IRQFLAGS_NMI_SUPPORT=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_GENERIC_IDLE_POLL_SETUP=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_KEEPINITRD=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_NO_INSTR=y
CONFIG_HAVE_ASM_MODVERSIONS=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
CONFIG_MMU_GATHER_TABLE_FREE=y
CONFIG_MMU_GATHER_RCU_TABLE_FREE=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
CONFIG_HAVE_ARCH_SECCOMP=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP=y
CONFIG_SECCOMP_FILTER=y
# CONFIG_SECCOMP_CACHE_DEBUG is not set
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
# CONFIG_STACKPROTECTOR is not set
CONFIG_ARCH_SUPPORTS_SHADOW_CALL_STACK=y
CONFIG_SHADOW_CALL_STACK=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG_THIN=y
CONFIG_LTO_NONE=y
CONFIG_ARCH_SUPPORTS_CFI_CLANG=y
CONFIG_HAVE_CONTEXT_TRACKING_USER=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PUD=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_HAVE_ARCH_HUGE_VMALLOC=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK=y
CONFIG_SOFTIRQ_ON_OWN_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_ARCH_MMAP_RND_BITS=18
CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
CONFIG_ARCH_MMAP_RND_COMPAT_BITS=11
CONFIG_PAGE_SIZE_LESS_THAN_64KB=y
CONFIG_PAGE_SIZE_LESS_THAN_256KB=y
CONFIG_ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT=y
CONFIG_ISA_BUS_API=y
CONFIG_CLONE_BACKWARDS=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_COMPAT_OLD_SIGACTION=y
# CONFIG_COMPAT_32BIT_TIME is not set
CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_VMAP_STACK=y
CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET=y
# CONFIG_RANDOMIZE_KSTACK_OFFSET is not set
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_HAVE_ARCH_COMPILER_H=y
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
CONFIG_LOCK_EVENT_COUNTS=y
CONFIG_ARCH_HAS_RELR=y
CONFIG_HAVE_PREEMPT_DYNAMIC=y
CONFIG_HAVE_PREEMPT_DYNAMIC_KEY=y
CONFIG_ARCH_WANT_LD_ORPHAN_WARN=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_ARCH_SUPPORTS_PAGE_TABLE_CHECK=y
CONFIG_ARCH_HAVE_TRACE_MMIO_ACCESS=y

#
# GCOV-based kernel profiling
#
CONFIG_GCOV_KERNEL=y
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_HAVE_GCC_PLUGINS=y
CONFIG_GCC_PLUGINS=y
# CONFIG_GCC_PLUGIN_LATENT_ENTROPY is not set
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=1
CONFIG_MODULE_SIG_FORMAT=y
CONFIG_MODULES=y
CONFIG_MODULE_FORCE_LOAD=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODULE_UNLOAD_TAINT_TRACKING is not set
# CONFIG_MODVERSIONS is not set
CONFIG_MODULE_SRCVERSION_ALL=y
CONFIG_MODULE_SIG=y
CONFIG_MODULE_SIG_FORCE=y
# CONFIG_MODULE_SIG_ALL is not set

#
# Do not forget to sign required modules with scripts/sign-file
#
# CONFIG_MODULE_SIG_SHA1 is not set
# CONFIG_MODULE_SIG_SHA224 is not set
# CONFIG_MODULE_SIG_SHA256 is not set
CONFIG_MODULE_SIG_SHA384=y
# CONFIG_MODULE_SIG_SHA512 is not set
CONFIG_MODULE_SIG_HASH="sha384"
# CONFIG_MODULE_COMPRESS_NONE is not set
# CONFIG_MODULE_COMPRESS_GZIP is not set
CONFIG_MODULE_COMPRESS_XZ=y
# CONFIG_MODULE_COMPRESS_ZSTD is not set
CONFIG_MODULE_DECOMPRESS=y
# CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
CONFIG_MODPROBE_PATH="/sbin/modprobe"
CONFIG_MODULES_TREE_LOOKUP=y
# CONFIG_BLOCK is not set
CONFIG_PADATA=y
CONFIG_ASN1=y
CONFIG_ARCH_INLINE_SPIN_TRYLOCK=y
CONFIG_ARCH_INLINE_SPIN_TRYLOCK_BH=y
CONFIG_ARCH_INLINE_SPIN_LOCK=y
CONFIG_ARCH_INLINE_SPIN_LOCK_BH=y
CONFIG_ARCH_INLINE_SPIN_LOCK_IRQ=y
CONFIG_ARCH_INLINE_SPIN_LOCK_IRQSAVE=y
CONFIG_ARCH_INLINE_SPIN_UNLOCK=y
CONFIG_ARCH_INLINE_SPIN_UNLOCK_BH=y
CONFIG_ARCH_INLINE_SPIN_UNLOCK_IRQ=y
CONFIG_ARCH_INLINE_SPIN_UNLOCK_IRQRESTORE=y
CONFIG_ARCH_INLINE_READ_LOCK=y
CONFIG_ARCH_INLINE_READ_LOCK_BH=y
CONFIG_ARCH_INLINE_READ_LOCK_IRQ=y
CONFIG_ARCH_INLINE_READ_LOCK_IRQSAVE=y
CONFIG_ARCH_INLINE_READ_UNLOCK=y
CONFIG_ARCH_INLINE_READ_UNLOCK_BH=y
CONFIG_ARCH_INLINE_READ_UNLOCK_IRQ=y
CONFIG_ARCH_INLINE_READ_UNLOCK_IRQRESTORE=y
CONFIG_ARCH_INLINE_WRITE_LOCK=y
CONFIG_ARCH_INLINE_WRITE_LOCK_BH=y
CONFIG_ARCH_INLINE_WRITE_LOCK_IRQ=y
CONFIG_ARCH_INLINE_WRITE_LOCK_IRQSAVE=y
CONFIG_ARCH_INLINE_WRITE_UNLOCK=y
CONFIG_ARCH_INLINE_WRITE_UNLOCK_BH=y
CONFIG_ARCH_INLINE_WRITE_UNLOCK_IRQ=y
CONFIG_ARCH_INLINE_WRITE_UNLOCK_IRQRESTORE=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=y
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_ELF_KUNIT_TEST=y
CONFIG_COMPAT_BINFMT_ELF=y
CONFIG_ARCH_BINFMT_ELF_STATE=y
CONFIG_ARCH_BINFMT_ELF_EXTRA_PHDRS=y
CONFIG_ARCH_HAVE_ELF_PROT=y
CONFIG_ARCH_USE_GNU_PROPERTY=y
CONFIG_ELFCORE=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=m
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#

#
# SLAB allocator options
#
# CONFIG_SLAB is not set
# CONFIG_SLUB is not set
CONFIG_SLOB=y
# end of SLAB allocator options

CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
# CONFIG_COMPAT_BRK is not set
CONFIG_SPARSEMEM=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_ARCH_KEEP_MEMBLOCK=y
CONFIG_NUMA_KEEP_MEMINFO=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_EXCLUSIVE_SYSTEM_RAM=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_MEMORY_HOTPLUG=y
CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE=y
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_MHP_MEMMAP_ON_MEMORY=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_COMPACTION=y
CONFIG_COMPACT_UNEVICTABLE_DEFAULT=1
# CONFIG_PAGE_REPORTING is not set
CONFIG_MIGRATION=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_MMU_NOTIFIER=y
# CONFIG_KSM is not set
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_MEMORY_FAILURE is not set
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_TRANSPARENT_HUGEPAGE=y
# CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS is not set
CONFIG_TRANSPARENT_HUGEPAGE_MADVISE=y
CONFIG_READ_ONLY_THP_FOR_FS=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_CMA=y
CONFIG_CMA_DEBUG=y
# CONFIG_CMA_DEBUGFS is not set
# CONFIG_CMA_SYSFS is not set
CONFIG_CMA_AREAS=19
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
CONFIG_PAGE_IDLE_FLAG=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_CURRENT_STACK_POINTER=y
CONFIG_ARCH_HAS_PTE_DEVMAP=y
CONFIG_ARCH_HAS_ZONE_DMA_SET=y
# CONFIG_ZONE_DMA is not set
# CONFIG_ZONE_DMA32 is not set
# CONFIG_ZONE_DEVICE is not set
CONFIG_HMM_MIRROR=y
CONFIG_GET_FREE_REGION=y
# CONFIG_VM_EVENT_COUNTERS is not set
# CONFIG_PERCPU_STATS is not set
CONFIG_GUP_TEST=y
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_USERFAULTFD=y
CONFIG_HAVE_ARCH_USERFAULTFD_MINOR=y
CONFIG_LRU_GEN=y
# CONFIG_LRU_GEN_ENABLED is not set
CONFIG_LRU_GEN_STATS=y

#
# Data Access Monitoring
#
# CONFIG_DAMON is not set
# end of Data Access Monitoring
# end of Memory Management options

CONFIG_NET=y
CONFIG_NET_INGRESS=y
CONFIG_NET_EGRESS=y
CONFIG_SKB_EXTENSIONS=y

#
# Networking options
#
CONFIG_PACKET=m
# CONFIG_PACKET_DIAG is not set
CONFIG_UNIX=m
CONFIG_UNIX_SCM=y
CONFIG_AF_UNIX_OOB=y
CONFIG_UNIX_DIAG=m
CONFIG_TLS=m
# CONFIG_TLS_DEVICE is not set
# CONFIG_TLS_TOE is not set
CONFIG_XFRM=y
CONFIG_XFRM_OFFLOAD=y
CONFIG_XFRM_ALGO=y
# CONFIG_XFRM_USER is not set
# CONFIG_XFRM_SUB_POLICY is not set
CONFIG_XFRM_MIGRATE=y
CONFIG_XFRM_STATISTICS=y
CONFIG_XFRM_AH=y
CONFIG_XFRM_ESP=y
CONFIG_XFRM_IPCOMP=y
CONFIG_NET_KEY=y
CONFIG_NET_KEY_MIGRATE=y
# CONFIG_SMC is not set
# CONFIG_XDP_SOCKETS is not set
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_ROUTE_CLASSID=y
# CONFIG_IP_PNP is not set
CONFIG_NET_IPIP=y
CONFIG_NET_IPGRE_DEMUX=y
CONFIG_NET_IP_TUNNEL=y
CONFIG_NET_IPGRE=y
CONFIG_SYN_COOKIES=y
CONFIG_NET_IPVTI=m
CONFIG_NET_UDP_TUNNEL=y
CONFIG_NET_FOU=y
CONFIG_NET_FOU_IP_TUNNELS=y
CONFIG_INET_AH=y
CONFIG_INET_ESP=y
CONFIG_INET_ESP_OFFLOAD=m
# CONFIG_INET_ESPINTCP is not set
CONFIG_INET_IPCOMP=y
CONFIG_INET_XFRM_TUNNEL=y
CONFIG_INET_TUNNEL=y
# CONFIG_INET_DIAG is not set
CONFIG_TCP_CONG_ADVANCED=y
CONFIG_TCP_CONG_BIC=y
# CONFIG_TCP_CONG_CUBIC is not set
CONFIG_TCP_CONG_WESTWOOD=y
CONFIG_TCP_CONG_HTCP=y
# CONFIG_TCP_CONG_HSTCP is not set
CONFIG_TCP_CONG_HYBLA=y
CONFIG_TCP_CONG_VEGAS=m
CONFIG_TCP_CONG_NV=y
CONFIG_TCP_CONG_SCALABLE=m
CONFIG_TCP_CONG_LP=m
CONFIG_TCP_CONG_VENO=y
CONFIG_TCP_CONG_YEAH=m
# CONFIG_TCP_CONG_ILLINOIS is not set
CONFIG_TCP_CONG_DCTCP=y
# CONFIG_TCP_CONG_CDG is not set
CONFIG_TCP_CONG_BBR=m
CONFIG_DEFAULT_BIC=y
# CONFIG_DEFAULT_HTCP is not set
# CONFIG_DEFAULT_HYBLA is not set
# CONFIG_DEFAULT_VENO is not set
# CONFIG_DEFAULT_WESTWOOD is not set
# CONFIG_DEFAULT_DCTCP is not set
# CONFIG_DEFAULT_RENO is not set
CONFIG_DEFAULT_TCP_CONG="bic"
# CONFIG_TCP_MD5SIG is not set
# CONFIG_IPV6 is not set
# CONFIG_MPTCP is not set
# CONFIG_NETWORK_SECMARK is not set
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
# CONFIG_NETFILTER is not set
# CONFIG_BPFILTER is not set
CONFIG_IP_DCCP=m

#
# DCCP CCIDs Configuration
#
# CONFIG_IP_DCCP_CCID2_DEBUG is not set
CONFIG_IP_DCCP_CCID3=y
# CONFIG_IP_DCCP_CCID3_DEBUG is not set
CONFIG_IP_DCCP_TFRC_LIB=y
# end of DCCP CCIDs Configuration

#
# DCCP Kernel Hacking
#
CONFIG_IP_DCCP_DEBUG=y
# end of DCCP Kernel Hacking

CONFIG_IP_SCTP=y
CONFIG_SCTP_DBG_OBJCNT=y
CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5=y
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1 is not set
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
CONFIG_SCTP_COOKIE_HMAC_MD5=y
CONFIG_SCTP_COOKIE_HMAC_SHA1=y
CONFIG_RDS=m
# CONFIG_RDS_TCP is not set
# CONFIG_RDS_DEBUG is not set
CONFIG_TIPC=m
# CONFIG_TIPC_MEDIA_UDP is not set
CONFIG_TIPC_CRYPTO=y
CONFIG_TIPC_DIAG=m
# CONFIG_ATM is not set
CONFIG_L2TP=m
CONFIG_L2TP_DEBUGFS=m
CONFIG_L2TP_V3=y
CONFIG_L2TP_IP=y
CONFIG_L2TP_ETH=m
CONFIG_STP=y
CONFIG_GARP=y
CONFIG_MRP=y
CONFIG_BRIDGE=m
# CONFIG_BRIDGE_IGMP_SNOOPING is not set
# CONFIG_BRIDGE_VLAN_FILTERING is not set
CONFIG_BRIDGE_MRP=y
CONFIG_BRIDGE_CFM=y
CONFIG_VLAN_8021Q=y
CONFIG_VLAN_8021Q_GVRP=y
CONFIG_VLAN_8021Q_MVRP=y
CONFIG_LLC=y
CONFIG_LLC2=y
CONFIG_ATALK=y
# CONFIG_DEV_APPLETALK is not set
CONFIG_X25=m
CONFIG_LAPB=y
CONFIG_PHONET=m
# CONFIG_IEEE802154 is not set
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_CBQ=y
# CONFIG_NET_SCH_HTB is not set
# CONFIG_NET_SCH_HFSC is not set
CONFIG_NET_SCH_PRIO=m
# CONFIG_NET_SCH_MULTIQ is not set
# CONFIG_NET_SCH_RED is not set
CONFIG_NET_SCH_SFB=y
# CONFIG_NET_SCH_SFQ is not set
CONFIG_NET_SCH_TEQL=y
# CONFIG_NET_SCH_TBF is not set
CONFIG_NET_SCH_CBS=m
# CONFIG_NET_SCH_ETF is not set
CONFIG_NET_SCH_TAPRIO=m
CONFIG_NET_SCH_GRED=y
# CONFIG_NET_SCH_DSMARK is not set
CONFIG_NET_SCH_NETEM=y
CONFIG_NET_SCH_DRR=y
CONFIG_NET_SCH_MQPRIO=m
CONFIG_NET_SCH_SKBPRIO=m
CONFIG_NET_SCH_CHOKE=m
# CONFIG_NET_SCH_QFQ is not set
CONFIG_NET_SCH_CODEL=m
CONFIG_NET_SCH_FQ_CODEL=y
# CONFIG_NET_SCH_CAKE is not set
# CONFIG_NET_SCH_FQ is not set
CONFIG_NET_SCH_HHF=y
CONFIG_NET_SCH_PIE=y
CONFIG_NET_SCH_FQ_PIE=m
CONFIG_NET_SCH_INGRESS=m
CONFIG_NET_SCH_PLUG=y
CONFIG_NET_SCH_ETS=y
# CONFIG_NET_SCH_DEFAULT is not set

#
# Classification
#
CONFIG_NET_CLS=y
CONFIG_NET_CLS_BASIC=m
CONFIG_NET_CLS_TCINDEX=y
CONFIG_NET_CLS_ROUTE4=y
# CONFIG_NET_CLS_FW is not set
CONFIG_NET_CLS_U32=y
# CONFIG_CLS_U32_PERF is not set
# CONFIG_CLS_U32_MARK is not set
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_RSVP6=m
# CONFIG_NET_CLS_FLOW is not set
CONFIG_NET_CLS_CGROUP=y
# CONFIG_NET_CLS_BPF is not set
# CONFIG_NET_CLS_FLOWER is not set
# CONFIG_NET_CLS_MATCHALL is not set
# CONFIG_NET_EMATCH is not set
CONFIG_NET_CLS_ACT=y
CONFIG_NET_ACT_POLICE=y
CONFIG_NET_ACT_GACT=m
# CONFIG_GACT_PROB is not set
CONFIG_NET_ACT_MIRRED=y
CONFIG_NET_ACT_SAMPLE=y
# CONFIG_NET_ACT_NAT is not set
CONFIG_NET_ACT_PEDIT=m
CONFIG_NET_ACT_SIMP=y
# CONFIG_NET_ACT_SKBEDIT is not set
CONFIG_NET_ACT_CSUM=y
CONFIG_NET_ACT_MPLS=y
CONFIG_NET_ACT_VLAN=y
CONFIG_NET_ACT_BPF=m
CONFIG_NET_ACT_SKBMOD=y
CONFIG_NET_ACT_IFE=m
CONFIG_NET_ACT_TUNNEL_KEY=m
CONFIG_NET_ACT_GATE=y
CONFIG_NET_IFE_SKBMARK=m
CONFIG_NET_IFE_SKBPRIO=m
CONFIG_NET_IFE_SKBTCINDEX=m
CONFIG_NET_TC_SKB_EXT=y
CONFIG_NET_SCH_FIFO=y
CONFIG_DCB=y
CONFIG_DNS_RESOLVER=m
CONFIG_BATMAN_ADV=m
# CONFIG_BATMAN_ADV_BATMAN_V is not set
# CONFIG_BATMAN_ADV_BLA is not set
CONFIG_BATMAN_ADV_DAT=y
# CONFIG_BATMAN_ADV_NC is not set
CONFIG_BATMAN_ADV_MCAST=y
CONFIG_BATMAN_ADV_DEBUG=y
# CONFIG_BATMAN_ADV_TRACING is not set
# CONFIG_OPENVSWITCH is not set
# CONFIG_VSOCKETS is not set
CONFIG_NETLINK_DIAG=m
# CONFIG_MPLS is not set
# CONFIG_NET_NSH is not set
CONFIG_HSR=m
CONFIG_NET_SWITCHDEV=y
CONFIG_NET_L3_MASTER_DEV=y
CONFIG_QRTR=m
CONFIG_QRTR_SMD=m
CONFIG_QRTR_TUN=m
CONFIG_QRTR_MHI=m
CONFIG_NET_NCSI=y
# CONFIG_NCSI_OEM_CMD_GET_MAC is not set
CONFIG_NCSI_OEM_CMD_KEEP_PHY=y
CONFIG_PCPU_DEV_REFCNT=y
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_SOCK_RX_QUEUE_MAPPING=y
CONFIG_XPS=y
# CONFIG_CGROUP_NET_PRIO is not set
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
CONFIG_NET_PKTGEN=y
CONFIG_NET_DROP_MONITOR=y
# end of Network testing
# end of Networking options

CONFIG_HAMRADIO=y

#
# Packet Radio protocols
#
CONFIG_AX25=y
CONFIG_AX25_DAMA_SLAVE=y
# CONFIG_NETROM is not set
# CONFIG_ROSE is not set

#
# AX.25 network device drivers
#
CONFIG_BPQETHER=y
CONFIG_BAYCOM_SER_FDX=m
CONFIG_BAYCOM_SER_HDX=m
CONFIG_BAYCOM_PAR=m
# CONFIG_YAM is not set
# end of AX.25 network device drivers

CONFIG_CAN=y
# CONFIG_CAN_RAW is not set
CONFIG_CAN_BCM=m
# CONFIG_CAN_GW is not set
# CONFIG_CAN_J1939 is not set
# CONFIG_CAN_ISOTP is not set
# CONFIG_BT is not set
CONFIG_AF_RXRPC=m
# CONFIG_AF_RXRPC_INJECT_LOSS is not set
# CONFIG_AF_RXRPC_DEBUG is not set
CONFIG_RXKAD=y
CONFIG_AF_KCM=m
CONFIG_STREAM_PARSER=y
# CONFIG_MCTP is not set
# CONFIG_WIRELESS is not set
CONFIG_RFKILL=m
CONFIG_RFKILL_LEDS=y
# CONFIG_RFKILL_GPIO is not set
CONFIG_NET_9P=y
# CONFIG_NET_9P_FD is not set
CONFIG_NET_9P_VIRTIO=m
CONFIG_NET_9P_XEN=m
CONFIG_NET_9P_DEBUG=y
CONFIG_CAIF=m
# CONFIG_CAIF_DEBUG is not set
# CONFIG_CAIF_NETDEV is not set
# CONFIG_CAIF_USB is not set
CONFIG_CEPH_LIB=m
CONFIG_CEPH_LIB_PRETTYDEBUG=y
CONFIG_CEPH_LIB_USE_DNS_RESOLVER=y
# CONFIG_NFC is not set
CONFIG_PSAMPLE=y
CONFIG_NET_IFE=y
# CONFIG_LWTUNNEL is not set
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_NET_SOCK_MSG=y
CONFIG_PAGE_POOL=y
CONFIG_PAGE_POOL_STATS=y
# CONFIG_FAILOVER is not set
# CONFIG_ETHTOOL_NETLINK is not set
CONFIG_NETDEV_ADDR_LIST_TEST=y

#
# Device Drivers
#
CONFIG_ARM_AMBA=y
CONFIG_TEGRA_AHB=y
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCI_DOMAINS_GENERIC=y
CONFIG_PCI_SYSCALL=y
# CONFIG_PCIEPORTBUS is not set
CONFIG_PCIEASPM=y
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
CONFIG_PCIE_PTM=y
CONFIG_PCI_MSI=y
CONFIG_PCI_MSI_IRQ_DOMAIN=y
# CONFIG_PCI_QUIRKS is not set
CONFIG_PCI_DEBUG=y
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
CONFIG_PCI_STUB=y
CONFIG_PCI_PF_STUB=m
CONFIG_PCI_ATS=y
CONFIG_PCI_DOE=y
CONFIG_PCI_ECAM=y
CONFIG_PCI_IOV=y
CONFIG_PCI_PRI=y
# CONFIG_PCI_PASID is not set
# CONFIG_PCIE_BUS_TUNE_OFF is not set
# CONFIG_PCIE_BUS_DEFAULT is not set
# CONFIG_PCIE_BUS_SAFE is not set
# CONFIG_PCIE_BUS_PERFORMANCE is not set
CONFIG_PCIE_BUS_PEER2PEER=y
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
CONFIG_HOTPLUG_PCI=y
CONFIG_HOTPLUG_PCI_CPCI=y
CONFIG_HOTPLUG_PCI_SHPC=y

#
# PCI controller drivers
#
# CONFIG_PCI_AARDVARK is not set
CONFIG_PCIE_XILINX_NWL=y
# CONFIG_PCI_FTPCI100 is not set
# CONFIG_PCI_TEGRA is not set
# CONFIG_PCIE_RCAR_HOST is not set
# CONFIG_PCIE_RCAR_EP is not set
CONFIG_PCI_HOST_COMMON=y
# CONFIG_PCI_HOST_GENERIC is not set
CONFIG_PCIE_XILINX=y
# CONFIG_PCIE_XILINX_CPM is not set
CONFIG_PCI_XGENE=y
# CONFIG_PCI_XGENE_MSI is not set
CONFIG_PCI_V3_SEMI=y
# CONFIG_PCI_VERSATILE is not set
CONFIG_PCIE_ALTERA=y
CONFIG_PCIE_ALTERA_MSI=m
# CONFIG_PCI_HOST_THUNDER_PEM is not set
CONFIG_PCI_HOST_THUNDER_ECAM=y
CONFIG_PCIE_ROCKCHIP=y
CONFIG_PCIE_ROCKCHIP_HOST=y
# CONFIG_PCIE_ROCKCHIP_EP is not set
CONFIG_PCIE_MEDIATEK=m
# CONFIG_PCIE_MEDIATEK_GEN3 is not set
# CONFIG_PCIE_BRCMSTB is not set
# CONFIG_PCIE_MICROCHIP_HOST is not set
CONFIG_PCIE_APPLE_MSI_DOORBELL_ADDR=0xfffff000
CONFIG_PCIE_APPLE=m
CONFIG_PCIE_MT7621=m

#
# DesignWare PCI Core Support
#
CONFIG_PCIE_DW=y
CONFIG_PCIE_DW_HOST=y
CONFIG_PCIE_DW_EP=y
CONFIG_PCIE_DW_PLAT=y
CONFIG_PCIE_DW_PLAT_HOST=y
CONFIG_PCIE_DW_PLAT_EP=y
CONFIG_PCI_EXYNOS=y
CONFIG_PCI_IMX6=y
CONFIG_PCIE_SPEAR13XX=y
CONFIG_PCI_KEYSTONE=y
CONFIG_PCI_KEYSTONE_HOST=y
# CONFIG_PCI_KEYSTONE_EP is not set
CONFIG_PCI_LAYERSCAPE=y
# CONFIG_PCI_LAYERSCAPE_EP is not set
CONFIG_PCI_HISI=y
# CONFIG_PCIE_QCOM is not set
CONFIG_PCIE_QCOM_EP=m
# CONFIG_PCIE_ARMADA_8K is not set
CONFIG_PCIE_ARTPEC6=y
CONFIG_PCIE_ARTPEC6_HOST=y
# CONFIG_PCIE_ARTPEC6_EP is not set
# CONFIG_PCIE_ROCKCHIP_DW_HOST is not set
CONFIG_PCIE_INTEL_GW=y
CONFIG_PCIE_KEEMBAY=y
# CONFIG_PCIE_KEEMBAY_HOST is not set
CONFIG_PCIE_KEEMBAY_EP=y
# CONFIG_PCIE_KIRIN is not set
# CONFIG_PCIE_HISI_STB is not set
CONFIG_PCI_MESON=m
CONFIG_PCIE_TEGRA194=m
# CONFIG_PCIE_TEGRA194_HOST is not set
CONFIG_PCIE_TEGRA194_EP=m
CONFIG_PCIE_VISCONTI_HOST=y
CONFIG_PCIE_UNIPHIER=y
# CONFIG_PCIE_UNIPHIER_EP is not set
# CONFIG_PCIE_AL is not set
# CONFIG_PCIE_FU740 is not set
# end of DesignWare PCI Core Support

#
# Mobiveil PCIe Core Support
#
CONFIG_PCIE_MOBIVEIL=y
CONFIG_PCIE_MOBIVEIL_HOST=y
CONFIG_PCIE_MOBIVEIL_PLAT=y
# CONFIG_PCIE_LAYERSCAPE_GEN4 is not set
# end of Mobiveil PCIe Core Support

#
# Cadence PCIe controllers support
#
CONFIG_PCIE_CADENCE=y
CONFIG_PCIE_CADENCE_HOST=y
CONFIG_PCIE_CADENCE_PLAT=y
CONFIG_PCIE_CADENCE_PLAT_HOST=y
# CONFIG_PCIE_CADENCE_PLAT_EP is not set
CONFIG_PCI_J721E=y
CONFIG_PCI_J721E_HOST=y
# CONFIG_PCI_J721E_EP is not set
# end of Cadence PCIe controllers support
# end of PCI controller drivers

#
# PCI Endpoint
#
CONFIG_PCI_ENDPOINT=y
CONFIG_PCI_ENDPOINT_CONFIGFS=y
CONFIG_PCI_EPF_TEST=m
CONFIG_PCI_EPF_NTB=y
# end of PCI Endpoint

#
# PCI switch controller drivers
#
CONFIG_PCI_SW_SWITCHTEC=y
# end of PCI switch controller drivers

CONFIG_CXL_BUS=m
# CONFIG_CXL_PCI is not set
CONFIG_CXL_PORT=m
CONFIG_CXL_REGION=y
# CONFIG_PCCARD is not set
CONFIG_RAPIDIO=m
CONFIG_RAPIDIO_DISC_TIMEOUT=30
CONFIG_RAPIDIO_ENABLE_RX_TX_PORTS=y
CONFIG_RAPIDIO_DEBUG=y
# CONFIG_RAPIDIO_ENUM_BASIC is not set
CONFIG_RAPIDIO_CHMAN=m
CONFIG_RAPIDIO_MPORT_CDEV=m

#
# RapidIO Switch drivers
#
CONFIG_RAPIDIO_CPS_XX=m
# CONFIG_RAPIDIO_CPS_GEN2 is not set
CONFIG_RAPIDIO_RXS_GEN3=m
# end of RapidIO Switch drivers

#
# Generic Driver Options
#
CONFIG_AUXILIARY_BUS=y
CONFIG_UEVENT_HELPER=y
CONFIG_UEVENT_HELPER_PATH=""
CONFIG_DEVTMPFS=y
# CONFIG_DEVTMPFS_MOUNT is not set
CONFIG_DEVTMPFS_SAFE=y
# CONFIG_STANDALONE is not set
# CONFIG_PREVENT_FIRMWARE_BUILD is not set

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_FW_LOADER_SYSFS=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
# CONFIG_FW_LOADER_COMPRESS is not set
CONFIG_FW_UPLOAD=y
# end of Firmware loader

CONFIG_WANT_DEV_COREDUMP=y
CONFIG_ALLOW_DEV_COREDUMP=y
CONFIG_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
CONFIG_DEBUG_TEST_DRIVER_REMOVE=y
CONFIG_PM_QOS_KUNIT_TEST=y
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_DRIVER_PE_KUNIT_TEST=y
CONFIG_SYS_HYPERVISOR=y
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_SOC_BUS=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_DMA_SHARED_BUFFER=y
CONFIG_DMA_FENCE_TRACE=y
CONFIG_GENERIC_ARCH_TOPOLOGY=y
CONFIG_GENERIC_ARCH_NUMA=y
# end of Generic Driver Options

#
# Bus devices
#
CONFIG_ARM_CCI=y
# CONFIG_ARM_INTEGRATOR_LM is not set
# CONFIG_BRCMSTB_GISB_ARB is not set
# CONFIG_BT1_APB is not set
CONFIG_BT1_AXI=y
# CONFIG_HISILICON_LPC is not set
CONFIG_INTEL_IXP4XX_EB=y
CONFIG_QCOM_EBI2=y
CONFIG_QCOM_SSC_BLOCK_BUS=y
# CONFIG_TEGRA_GMI is not set
CONFIG_VEXPRESS_CONFIG=y
CONFIG_FSL_MC_BUS=y
# CONFIG_FSL_MC_UAPI_SUPPORT is not set
CONFIG_MHI_BUS=y
CONFIG_MHI_BUS_DEBUG=y
# CONFIG_MHI_BUS_PCI_GENERIC is not set
CONFIG_MHI_BUS_EP=m
# end of Bus devices

CONFIG_CONNECTOR=y
CONFIG_PROC_EVENTS=y

#
# Firmware Drivers
#

#
# ARM System Control and Management Interface Protocol
#
# CONFIG_ARM_SCMI_PROTOCOL is not set
CONFIG_ARM_SCMI_POWER_DOMAIN=m
# CONFIG_ARM_SCMI_POWER_CONTROL is not set
# end of ARM System Control and Management Interface Protocol

CONFIG_ARM_SCPI_POWER_DOMAIN=y
# CONFIG_FIRMWARE_MEMMAP is not set
CONFIG_FW_CFG_SYSFS=y
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
CONFIG_QCOM_SCM=y
CONFIG_QCOM_SCM_DOWNLOAD_MODE_DEFAULT=y
CONFIG_ARM_FFA_TRANSPORT=m
CONFIG_ARM_FFA_SMCCC=y
# CONFIG_BCM47XX_NVRAM is not set
CONFIG_TEE_BNXT_FW=m
# CONFIG_GOOGLE_FIRMWARE is not set
# CONFIG_MESON_SM is not set
CONFIG_ARM_PSCI_FW=y
CONFIG_HAVE_ARM_SMCCC=y
CONFIG_HAVE_ARM_SMCCC_DISCOVERY=y
CONFIG_ARM_SMCCC_SOC_ID=y

#
# Tegra firmware driver
#
CONFIG_TEGRA_IVC=y
# end of Tegra firmware driver
# end of Firmware Drivers

CONFIG_GNSS=m
# CONFIG_GNSS_MTK_SERIAL is not set
CONFIG_GNSS_SIRF_SERIAL=m
# CONFIG_GNSS_UBX_SERIAL is not set
# CONFIG_MTD is not set
CONFIG_DTC=y
CONFIG_OF=y
# CONFIG_OF_UNITTEST is not set
CONFIG_OF_ALL_DTBS=y
CONFIG_OF_FLATTREE=y
CONFIG_OF_EARLY_FLATTREE=y
CONFIG_OF_KOBJ=y
CONFIG_OF_DYNAMIC=y
CONFIG_OF_ADDRESS=y
CONFIG_OF_IRQ=y
CONFIG_OF_RESERVED_MEM=y
# CONFIG_OF_OVERLAY is not set
CONFIG_OF_NUMA=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PARPORT_AX88796=m
# CONFIG_PARPORT_1284 is not set
CONFIG_PARPORT_NOT_PC=y

#
# NVME Support
#
# end of NVME Support

#
# Misc devices
#
CONFIG_AD525X_DPOT=m
CONFIG_AD525X_DPOT_I2C=m
CONFIG_DUMMY_IRQ=y
CONFIG_PHANTOM=m
CONFIG_TIFM_CORE=m
# CONFIG_TIFM_7XX1 is not set
# CONFIG_ICS932S401 is not set
CONFIG_ATMEL_SSC=m
CONFIG_ENCLOSURE_SERVICES=m
# CONFIG_HP_ILO is not set
CONFIG_QCOM_COINCELL=m
CONFIG_QCOM_FASTRPC=m
# CONFIG_APDS9802ALS is not set
CONFIG_ISL29003=m
CONFIG_ISL29020=y
CONFIG_SENSORS_TSL2550=y
CONFIG_SENSORS_BH1770=m
# CONFIG_SENSORS_APDS990X is not set
CONFIG_HMC6352=y
CONFIG_DS1682=y
CONFIG_PCH_PHUB=m
# CONFIG_SRAM is not set
# CONFIG_DW_XDATA_PCIE is not set
CONFIG_PCI_ENDPOINT_TEST=y
# CONFIG_XILINX_SDFEC is not set
# CONFIG_OPEN_DICE is not set
# CONFIG_VCPU_STALL_DETECTOR is not set
CONFIG_C2PORT=y

#
# EEPROM support
#
CONFIG_EEPROM_AT24=y
CONFIG_EEPROM_LEGACY=m
# CONFIG_EEPROM_MAX6875 is not set
# CONFIG_EEPROM_93CX6 is not set
CONFIG_EEPROM_IDT_89HPESX=y
CONFIG_EEPROM_EE1004=y
# end of EEPROM support

CONFIG_CB710_CORE=y
CONFIG_CB710_DEBUG=y
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
# end of Texas Instruments shared transport line discipline

CONFIG_ALTERA_STAPL=y
# CONFIG_GENWQE is not set
CONFIG_ECHO=y
CONFIG_BCM_VK=m
CONFIG_MISC_ALCOR_PCI=m
# CONFIG_MISC_RTSX_PCI is not set
# CONFIG_HABANA_AI is not set
CONFIG_UACCE=y
CONFIG_PVPANIC=y
CONFIG_PVPANIC_MMIO=y
CONFIG_PVPANIC_PCI=m
# CONFIG_GP_PCI1XXXX is not set
# end of Misc devices

#
# SCSI device support
#
# end of SCSI device support

# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=m
# CONFIG_FIREWIRE_OHCI is not set
CONFIG_FIREWIRE_NET=m
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

# CONFIG_NETDEVICES is not set

#
# Input device support
#
# CONFIG_INPUT is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
# CONFIG_SERIO_PARKBD is not set
CONFIG_SERIO_AMBAKMI=y
CONFIG_SERIO_PCIPS2=m
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=m
CONFIG_SERIO_ALTERA_PS2=y
CONFIG_SERIO_PS2MULT=y
CONFIG_SERIO_ARC_PS2=y
CONFIG_SERIO_APBPS2=m
CONFIG_SERIO_OLPC_APSP=m
CONFIG_SERIO_SUN4I_PS2=m
# CONFIG_SERIO_GPIO_PS2 is not set
CONFIG_USERIO=m
# CONFIG_GAMEPORT is not set
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
# CONFIG_TTY is not set
CONFIG_SERIAL_DEV_BUS=y
# CONFIG_PRINTER is not set
# CONFIG_PPDEV is not set
CONFIG_IPMI_HANDLER=y
CONFIG_IPMI_PLAT_DATA=y
# CONFIG_IPMI_PANIC_EVENT is not set
CONFIG_IPMI_DEVICE_INTERFACE=y
CONFIG_IPMI_SI=m
CONFIG_IPMI_SSIF=y
CONFIG_IPMI_IPMB=y
# CONFIG_IPMI_WATCHDOG is not set
# CONFIG_IPMI_POWEROFF is not set
CONFIG_IPMI_KCS_BMC=y
# CONFIG_ASPEED_KCS_IPMI_BMC is not set
CONFIG_NPCM7XX_KCS_IPMI_BMC=y
# CONFIG_IPMI_KCS_BMC_CDEV_IPMI is not set
CONFIG_IPMI_KCS_BMC_SERIO=m
# CONFIG_ASPEED_BT_IPMI_BMC is not set
CONFIG_IPMB_DEVICE_INTERFACE=m
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=m
CONFIG_HW_RANDOM_ATMEL=m
CONFIG_HW_RANDOM_BA431=m
CONFIG_HW_RANDOM_BCM2835=y
CONFIG_HW_RANDOM_IPROC_RNG200=m
# CONFIG_HW_RANDOM_IXP4XX is not set
# CONFIG_HW_RANDOM_OMAP is not set
CONFIG_HW_RANDOM_OMAP3_ROM=m
CONFIG_HW_RANDOM_VIRTIO=m
CONFIG_HW_RANDOM_IMX_RNGC=y
CONFIG_HW_RANDOM_NOMADIK=y
CONFIG_HW_RANDOM_XGENE=m
# CONFIG_HW_RANDOM_STM32 is not set
CONFIG_HW_RANDOM_MESON=m
CONFIG_HW_RANDOM_CAVIUM=m
CONFIG_HW_RANDOM_MTK=y
# CONFIG_HW_RANDOM_EXYNOS is not set
CONFIG_HW_RANDOM_OPTEE=m
CONFIG_HW_RANDOM_NPCM=m
CONFIG_HW_RANDOM_KEYSTONE=m
CONFIG_HW_RANDOM_CCTRNG=y
CONFIG_HW_RANDOM_XIPHERA=m
# CONFIG_HW_RANDOM_ARM_SMCCC_TRNG is not set
CONFIG_HW_RANDOM_CN10K=y
CONFIG_APPLICOM=y
# CONFIG_DEVMEM is not set
# CONFIG_DEVPORT is not set
CONFIG_TCG_TPM=m
CONFIG_HW_RANDOM_TPM=y
CONFIG_TCG_TIS_CORE=m
CONFIG_TCG_TIS=m
CONFIG_TCG_TIS_I2C=m
# CONFIG_TCG_TIS_SYNQUACER is not set
# CONFIG_TCG_TIS_I2C_CR50 is not set
CONFIG_TCG_TIS_I2C_ATMEL=m
CONFIG_TCG_TIS_I2C_INFINEON=m
CONFIG_TCG_TIS_I2C_NUVOTON=m
CONFIG_TCG_ATMEL=m
CONFIG_TCG_XEN=m
CONFIG_TCG_VTPM_PROXY=m
CONFIG_TCG_FTPM_TEE=m
# CONFIG_TCG_TIS_ST33ZP24_I2C is not set
CONFIG_XILLYBUS_CLASS=m
CONFIG_XILLYBUS=m
CONFIG_XILLYBUS_PCIE=m
CONFIG_XILLYBUS_OF=m
CONFIG_RANDOM_TRUST_CPU=y
CONFIG_RANDOM_TRUST_BOOTLOADER=y
# end of Character devices

#
# I2C support
#
CONFIG_I2C=y
CONFIG_I2C_BOARDINFO=y
# CONFIG_I2C_COMPAT is not set
CONFIG_I2C_CHARDEV=y
CONFIG_I2C_MUX=m

#
# Multiplexer I2C Chip support
#
CONFIG_I2C_ARB_GPIO_CHALLENGE=m
CONFIG_I2C_MUX_GPIO=m
CONFIG_I2C_MUX_GPMUX=m
CONFIG_I2C_MUX_LTC4306=m
CONFIG_I2C_MUX_PCA9541=m
CONFIG_I2C_MUX_PCA954x=m
CONFIG_I2C_MUX_PINCTRL=m
CONFIG_I2C_MUX_REG=m
CONFIG_I2C_DEMUX_PINCTRL=m
# CONFIG_I2C_MUX_MLXCPLD is not set
# end of Multiplexer I2C Chip support

CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=y
CONFIG_I2C_ALGOBIT=y

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
CONFIG_I2C_CCGX_UCSI=m
CONFIG_I2C_ALI1535=m
# CONFIG_I2C_ALI1563 is not set
CONFIG_I2C_ALI15X3=y
CONFIG_I2C_AMD756=y
CONFIG_I2C_AMD8111=m
CONFIG_I2C_HIX5HD2=y
CONFIG_I2C_I801=y
CONFIG_I2C_ISCH=y
CONFIG_I2C_PIIX4=y
CONFIG_I2C_NFORCE2=m
CONFIG_I2C_NVIDIA_GPU=m
# CONFIG_I2C_SIS5595 is not set
CONFIG_I2C_SIS630=m
CONFIG_I2C_SIS96X=m
CONFIG_I2C_VIA=y
CONFIG_I2C_VIAPRO=y

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_ALTERA is not set
CONFIG_I2C_ASPEED=m
CONFIG_I2C_AT91=m
CONFIG_I2C_AT91_SLAVE_EXPERIMENTAL=m
CONFIG_I2C_AXXIA=y
CONFIG_I2C_BCM2835=y
CONFIG_I2C_BCM_IPROC=m
CONFIG_I2C_BCM_KONA=y
# CONFIG_I2C_BRCMSTB is not set
CONFIG_I2C_CADENCE=y
CONFIG_I2C_CBUS_GPIO=y
CONFIG_I2C_DAVINCI=m
CONFIG_I2C_DESIGNWARE_CORE=m
CONFIG_I2C_DESIGNWARE_SLAVE=y
CONFIG_I2C_DESIGNWARE_PLATFORM=m
# CONFIG_I2C_DESIGNWARE_PCI is not set
CONFIG_I2C_DIGICOLOR=m
CONFIG_I2C_EG20T=y
CONFIG_I2C_EMEV2=y
# CONFIG_I2C_EXYNOS5 is not set
CONFIG_I2C_GPIO=m
# CONFIG_I2C_GPIO_FAULT_INJECTOR is not set
CONFIG_I2C_HIGHLANDER=y
# CONFIG_I2C_HISI is not set
CONFIG_I2C_IMG=m
# CONFIG_I2C_IMX is not set
CONFIG_I2C_IMX_LPI2C=m
CONFIG_I2C_IOP3XX=y
CONFIG_I2C_JZ4780=y
CONFIG_I2C_LPC2K=m
# CONFIG_I2C_MLXBF is not set
CONFIG_I2C_MESON=m
CONFIG_I2C_MICROCHIP_CORE=m
CONFIG_I2C_MT65XX=m
CONFIG_I2C_MT7621=m
CONFIG_I2C_MV64XXX=m
CONFIG_I2C_MXS=y
CONFIG_I2C_NOMADIK=y
CONFIG_I2C_NPCM=m
CONFIG_I2C_OCORES=y
CONFIG_I2C_OMAP=m
CONFIG_I2C_OWL=m
CONFIG_I2C_APPLE=y
# CONFIG_I2C_PCA_PLATFORM is not set
CONFIG_I2C_PNX=y
# CONFIG_I2C_PXA is not set
CONFIG_I2C_QCOM_CCI=y
# CONFIG_I2C_QUP is not set
# CONFIG_I2C_RIIC is not set
CONFIG_I2C_RK3X=y
CONFIG_I2C_RZV2M=y
CONFIG_I2C_S3C2410=y
CONFIG_I2C_SH_MOBILE=m
CONFIG_I2C_SIMTEC=y
CONFIG_I2C_SPRD=m
# CONFIG_I2C_ST is not set
CONFIG_I2C_STM32F4=m
CONFIG_I2C_STM32F7=y
CONFIG_I2C_SUN6I_P2WI=m
CONFIG_I2C_SYNQUACER=y
CONFIG_I2C_TEGRA=y
# CONFIG_I2C_TEGRA_BPMP is not set
CONFIG_I2C_UNIPHIER=m
# CONFIG_I2C_UNIPHIER_F is not set
CONFIG_I2C_VERSATILE=m
CONFIG_I2C_WMT=m
CONFIG_I2C_THUNDERX=y
CONFIG_I2C_XILINX=y
CONFIG_I2C_XLP9XX=y
# CONFIG_I2C_RCAR is not set

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_PARPORT=m
CONFIG_I2C_PCI1XXXX=m

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_MLXCPLD=m
CONFIG_I2C_CROS_EC_TUNNEL=y
CONFIG_I2C_FSI=m
CONFIG_I2C_VIRTIO=m
# end of I2C Hardware Bus support

# CONFIG_I2C_STUB is not set
CONFIG_I2C_SLAVE=y
CONFIG_I2C_SLAVE_EEPROM=y
CONFIG_I2C_SLAVE_TESTUNIT=y
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

CONFIG_I3C=y
CONFIG_CDNS_I3C_MASTER=m
# CONFIG_DW_I3C_MASTER is not set
# CONFIG_SVC_I3C_MASTER is not set
CONFIG_MIPI_I3C_HCI=m
# CONFIG_SPI is not set
# CONFIG_SPMI is not set
CONFIG_HSI=m
CONFIG_HSI_BOARDINFO=y

#
# HSI controllers
#

#
# HSI clients
#
# CONFIG_HSI_CHAR is not set
CONFIG_PPS=y
CONFIG_PPS_DEBUG=y

#
# PPS clients support
#
CONFIG_PPS_CLIENT_KTIMER=y
# CONFIG_PPS_CLIENT_PARPORT is not set
CONFIG_PPS_CLIENT_GPIO=m

#
# PPS generators support
#

#
# PTP clock support
#
# CONFIG_PTP_1588_CLOCK is not set
CONFIG_PTP_1588_CLOCK_OPTIONAL=y

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
# end of PTP clock support

CONFIG_PINCTRL=y
CONFIG_GENERIC_PINCTRL_GROUPS=y
CONFIG_PINMUX=y
CONFIG_GENERIC_PINMUX_FUNCTIONS=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
CONFIG_PINCTRL_AMD=y
CONFIG_PINCTRL_AS3722=m
# CONFIG_PINCTRL_AT91PIO4 is not set
CONFIG_PINCTRL_AXP209=m
CONFIG_PINCTRL_BM1880=y
CONFIG_PINCTRL_CY8C95X0=m
# CONFIG_PINCTRL_DA850_PUPD is not set
# CONFIG_PINCTRL_DA9062 is not set
CONFIG_PINCTRL_EQUILIBRIUM=m
CONFIG_PINCTRL_INGENIC=y
# CONFIG_PINCTRL_KEEMBAY is not set
# CONFIG_PINCTRL_LPC18XX is not set
CONFIG_PINCTRL_MCP23S08_I2C=y
CONFIG_PINCTRL_MCP23S08=y
# CONFIG_PINCTRL_MICROCHIP_SGPIO is not set
# CONFIG_PINCTRL_OCELOT is not set
# CONFIG_PINCTRL_PISTACHIO is not set
CONFIG_PINCTRL_RK805=y
CONFIG_PINCTRL_ROCKCHIP=m
CONFIG_PINCTRL_SINGLE=y
# CONFIG_PINCTRL_STMFX is not set
CONFIG_PINCTRL_SX150X=y
CONFIG_PINCTRL_THUNDERBAY=y
# CONFIG_PINCTRL_OWL is not set
# CONFIG_PINCTRL_ASPEED_G4 is not set
# CONFIG_PINCTRL_ASPEED_G5 is not set
# CONFIG_PINCTRL_ASPEED_G6 is not set
CONFIG_PINCTRL_BCM281XX=y
# CONFIG_PINCTRL_BCM2835 is not set
# CONFIG_PINCTRL_BCM4908 is not set
CONFIG_PINCTRL_BCM63XX=y
# CONFIG_PINCTRL_BCM6318 is not set
CONFIG_PINCTRL_BCM6328=y
# CONFIG_PINCTRL_BCM6358 is not set
CONFIG_PINCTRL_BCM6362=y
CONFIG_PINCTRL_BCM6368=y
CONFIG_PINCTRL_BCM63268=y
# CONFIG_PINCTRL_IPROC_GPIO is not set
CONFIG_PINCTRL_CYGNUS_MUX=y
# CONFIG_PINCTRL_NS is not set
# CONFIG_PINCTRL_NSP_GPIO is not set
# CONFIG_PINCTRL_NS2_MUX is not set
# CONFIG_PINCTRL_NSP_MUX is not set
CONFIG_PINCTRL_BERLIN=y
CONFIG_PINCTRL_AS370=y
CONFIG_PINCTRL_BERLIN_BG4CT=y
# CONFIG_PINCTRL_LOCHNAGAR is not set
CONFIG_PINCTRL_MADERA=m
CONFIG_PINCTRL_CS47L15=y
CONFIG_PINCTRL_IMX=y
CONFIG_PINCTRL_IMX8MM=y
CONFIG_PINCTRL_IMX8MN=y
CONFIG_PINCTRL_IMX8MP=m
CONFIG_PINCTRL_IMX8MQ=y

#
# Intel pinctrl drivers
#
# end of Intel pinctrl drivers

#
# MediaTek pinctrl drivers
#
CONFIG_EINT_MTK=y
CONFIG_PINCTRL_MTK=y
CONFIG_PINCTRL_MTK_V2=y
CONFIG_PINCTRL_MTK_MOORE=y
CONFIG_PINCTRL_MTK_PARIS=y
# CONFIG_PINCTRL_MT2701 is not set
CONFIG_PINCTRL_MT7623=y
# CONFIG_PINCTRL_MT7629 is not set
CONFIG_PINCTRL_MT8135=y
CONFIG_PINCTRL_MT8127=y
CONFIG_PINCTRL_MT2712=y
# CONFIG_PINCTRL_MT6765 is not set
# CONFIG_PINCTRL_MT6779 is not set
# CONFIG_PINCTRL_MT6795 is not set
CONFIG_PINCTRL_MT6797=y
CONFIG_PINCTRL_MT7622=y
CONFIG_PINCTRL_MT7986=y
# CONFIG_PINCTRL_MT8167 is not set
# CONFIG_PINCTRL_MT8173 is not set
# CONFIG_PINCTRL_MT8183 is not set
CONFIG_PINCTRL_MT8186=y
# CONFIG_PINCTRL_MT8188 is not set
CONFIG_PINCTRL_MT8192=y
CONFIG_PINCTRL_MT8195=y
CONFIG_PINCTRL_MT8365=y
CONFIG_PINCTRL_MT8516=y
# CONFIG_PINCTRL_MT6397 is not set
# end of MediaTek pinctrl drivers

CONFIG_PINCTRL_MESON=m
# CONFIG_PINCTRL_MESON_GXBB is not set
CONFIG_PINCTRL_MESON_GXL=m
CONFIG_PINCTRL_MESON8_PMX=m
CONFIG_PINCTRL_MESON_AXG=m
CONFIG_PINCTRL_MESON_AXG_PMX=m
CONFIG_PINCTRL_MESON_G12A=m
CONFIG_PINCTRL_MESON_A1=m
CONFIG_PINCTRL_MESON_S4=m
CONFIG_PINCTRL_MVEBU=y
CONFIG_PINCTRL_ARMADA_AP806=y
CONFIG_PINCTRL_ARMADA_CP110=y
CONFIG_PINCTRL_AC5=y
CONFIG_PINCTRL_ARMADA_37XX=y
CONFIG_PINCTRL_WPCM450=y
CONFIG_PINCTRL_NPCM7XX=y
CONFIG_PINCTRL_PXA=y
CONFIG_PINCTRL_PXA25X=y
CONFIG_PINCTRL_PXA27X=y
CONFIG_PINCTRL_MSM=y
CONFIG_PINCTRL_APQ8064=m
CONFIG_PINCTRL_APQ8084=m
CONFIG_PINCTRL_IPQ4019=m
CONFIG_PINCTRL_IPQ8064=y
CONFIG_PINCTRL_IPQ8074=y
# CONFIG_PINCTRL_IPQ6018 is not set
CONFIG_PINCTRL_MSM8226=y
CONFIG_PINCTRL_MSM8660=m
CONFIG_PINCTRL_MSM8960=m
# CONFIG_PINCTRL_MDM9607 is not set
CONFIG_PINCTRL_MDM9615=m
# CONFIG_PINCTRL_MSM8X74 is not set
CONFIG_PINCTRL_MSM8909=m
# CONFIG_PINCTRL_MSM8916 is not set
# CONFIG_PINCTRL_MSM8953 is not set
# CONFIG_PINCTRL_MSM8976 is not set
CONFIG_PINCTRL_MSM8994=y
CONFIG_PINCTRL_MSM8996=y
CONFIG_PINCTRL_MSM8998=y
CONFIG_PINCTRL_QCM2290=y
# CONFIG_PINCTRL_QCS404 is not set
# CONFIG_PINCTRL_QCOM_SSBI_PMIC is not set
# CONFIG_PINCTRL_SC7180 is not set
# CONFIG_PINCTRL_SC7280 is not set
CONFIG_PINCTRL_SC7280_LPASS_LPI=m
CONFIG_PINCTRL_SC8180X=y
CONFIG_PINCTRL_SC8280XP=y
CONFIG_PINCTRL_SDM660=y
CONFIG_PINCTRL_SDM845=y
CONFIG_PINCTRL_SDX55=m
CONFIG_PINCTRL_SM6115=m
# CONFIG_PINCTRL_SM6125 is not set
# CONFIG_PINCTRL_SM6350 is not set
# CONFIG_PINCTRL_SM6375 is not set
CONFIG_PINCTRL_SDX65=m
CONFIG_PINCTRL_SM8150=m
CONFIG_PINCTRL_SM8250=m
CONFIG_PINCTRL_SM8250_LPASS_LPI=y
# CONFIG_PINCTRL_SM8350 is not set
CONFIG_PINCTRL_SM8450=m
# CONFIG_PINCTRL_SM8450_LPASS_LPI is not set
CONFIG_PINCTRL_SC8280XP_LPASS_LPI=m
CONFIG_PINCTRL_LPASS_LPI=y

#
# Renesas pinctrl drivers
#
# CONFIG_PINCTRL_RENESAS is not set
CONFIG_PINCTRL_SH_PFC=y
CONFIG_PINCTRL_SH_PFC_GPIO=y
CONFIG_PINCTRL_SH_FUNC_GPIO=y
# CONFIG_PINCTRL_PFC_EMEV2 is not set
# CONFIG_PINCTRL_PFC_R8A77995 is not set
CONFIG_PINCTRL_PFC_R8A7794=y
# CONFIG_PINCTRL_PFC_R8A77990 is not set
# CONFIG_PINCTRL_PFC_R8A7779 is not set
CONFIG_PINCTRL_PFC_R8A7790=y
# CONFIG_PINCTRL_PFC_R8A77950 is not set
# CONFIG_PINCTRL_PFC_R8A77951 is not set
# CONFIG_PINCTRL_PFC_R8A7778 is not set
# CONFIG_PINCTRL_PFC_R8A7793 is not set
CONFIG_PINCTRL_PFC_R8A7791=y
# CONFIG_PINCTRL_PFC_R8A77965 is not set
CONFIG_PINCTRL_PFC_R8A77960=y
CONFIG_PINCTRL_PFC_R8A77961=y
# CONFIG_PINCTRL_PFC_R8A779F0 is not set
# CONFIG_PINCTRL_PFC_R8A7792 is not set
# CONFIG_PINCTRL_PFC_R8A77980 is not set
CONFIG_PINCTRL_PFC_R8A77970=y
# CONFIG_PINCTRL_PFC_R8A779A0 is not set
CONFIG_PINCTRL_PFC_R8A779G0=y
# CONFIG_PINCTRL_PFC_R8A7740 is not set
# CONFIG_PINCTRL_PFC_R8A73A4 is not set
# CONFIG_PINCTRL_RZA1 is not set
CONFIG_PINCTRL_RZA2=y
# CONFIG_PINCTRL_RZG2L is not set
# CONFIG_PINCTRL_PFC_R8A77470 is not set
CONFIG_PINCTRL_PFC_R8A7745=y
# CONFIG_PINCTRL_PFC_R8A7742 is not set
CONFIG_PINCTRL_PFC_R8A7743=y
CONFIG_PINCTRL_PFC_R8A7744=y
CONFIG_PINCTRL_PFC_R8A774C0=y
# CONFIG_PINCTRL_PFC_R8A774E1 is not set
CONFIG_PINCTRL_PFC_R8A774A1=y
CONFIG_PINCTRL_PFC_R8A774B1=y
CONFIG_PINCTRL_RZN1=y
CONFIG_PINCTRL_RZV2M=y
# CONFIG_PINCTRL_PFC_SH7203 is not set
CONFIG_PINCTRL_PFC_SH7264=y
# CONFIG_PINCTRL_PFC_SH7269 is not set
# CONFIG_PINCTRL_PFC_SH7720 is not set
# CONFIG_PINCTRL_PFC_SH7722 is not set
# CONFIG_PINCTRL_PFC_SH7734 is not set
# CONFIG_PINCTRL_PFC_SH7757 is not set
# CONFIG_PINCTRL_PFC_SH7785 is not set
# CONFIG_PINCTRL_PFC_SH7786 is not set
# CONFIG_PINCTRL_PFC_SH73A0 is not set
# CONFIG_PINCTRL_PFC_SH7723 is not set
# CONFIG_PINCTRL_PFC_SH7724 is not set
CONFIG_PINCTRL_PFC_SHX3=y
# end of Renesas pinctrl drivers

CONFIG_PINCTRL_SAMSUNG=y
CONFIG_PINCTRL_EXYNOS=y
CONFIG_PINCTRL_EXYNOS_ARM=y
CONFIG_PINCTRL_EXYNOS_ARM64=y
CONFIG_PINCTRL_S3C24XX=y
CONFIG_PINCTRL_S3C64XX=y
CONFIG_PINCTRL_SPRD=m
CONFIG_PINCTRL_SPRD_SC9860=m
CONFIG_PINCTRL_STARFIVE_JH7100=m
CONFIG_PINCTRL_STM32=y
CONFIG_PINCTRL_STM32F429=y
# CONFIG_PINCTRL_STM32F469 is not set
# CONFIG_PINCTRL_STM32F746 is not set
# CONFIG_PINCTRL_STM32F769 is not set
CONFIG_PINCTRL_STM32H743=y
CONFIG_PINCTRL_STM32MP135=y
# CONFIG_PINCTRL_STM32MP157 is not set
CONFIG_PINCTRL_TEGRA=y
CONFIG_PINCTRL_TEGRA124=y
CONFIG_PINCTRL_TEGRA_XUSB=y
CONFIG_PINCTRL_TI_IODELAY=y
# CONFIG_PINCTRL_UNIPHIER is not set
CONFIG_PINCTRL_VISCONTI=y
CONFIG_PINCTRL_TMPV7700=y
CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_OF_GPIO=y
CONFIG_GPIOLIB_IRQCHIP=y
CONFIG_DEBUG_GPIO=y
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_CDEV=y
# CONFIG_GPIO_CDEV_V1 is not set
CONFIG_GPIO_GENERIC=y
CONFIG_GPIO_REGMAP=y
CONFIG_GPIO_MAX730X=y

#
# Memory mapped GPIO drivers
#
CONFIG_GPIO_74XX_MMIO=y
CONFIG_GPIO_ALTERA=y
CONFIG_GPIO_ASPEED=m
CONFIG_GPIO_ASPEED_SGPIO=y
CONFIG_GPIO_ATH79=y
CONFIG_GPIO_RASPBERRYPI_EXP=m
# CONFIG_GPIO_BCM_KONA is not set
CONFIG_GPIO_BCM_XGS_IPROC=y
CONFIG_GPIO_BRCMSTB=y
# CONFIG_GPIO_CADENCE is not set
# CONFIG_GPIO_CLPS711X is not set
CONFIG_GPIO_DWAPB=y
# CONFIG_GPIO_EIC_SPRD is not set
CONFIG_GPIO_EM=m
CONFIG_GPIO_FTGPIO010=y
CONFIG_GPIO_GENERIC_PLATFORM=y
CONFIG_GPIO_GRGPIO=m
CONFIG_GPIO_HISI=m
CONFIG_GPIO_HLWD=y
CONFIG_GPIO_IOP=m
CONFIG_GPIO_LOGICVC=y
CONFIG_GPIO_LPC18XX=y
CONFIG_GPIO_LPC32XX=y
CONFIG_GPIO_MB86S7X=y
# CONFIG_GPIO_MENZ127 is not set
# CONFIG_GPIO_MPC8XXX is not set
# CONFIG_GPIO_MT7621 is not set
CONFIG_GPIO_MVEBU=y
# CONFIG_GPIO_MXC is not set
CONFIG_GPIO_MXS=y
# CONFIG_GPIO_PL061 is not set
CONFIG_GPIO_PMIC_EIC_SPRD=y
# CONFIG_GPIO_PXA is not set
CONFIG_GPIO_RCAR=y
# CONFIG_GPIO_RDA is not set
# CONFIG_GPIO_ROCKCHIP is not set
# CONFIG_GPIO_SAMA5D2_PIOBU is not set
# CONFIG_GPIO_SIFIVE is not set
CONFIG_GPIO_SNPS_CREG=y
CONFIG_GPIO_SPRD=m
CONFIG_GPIO_STP_XWAY=y
CONFIG_GPIO_SYSCON=y
# CONFIG_GPIO_TEGRA is not set
# CONFIG_GPIO_TEGRA186 is not set
# CONFIG_GPIO_TS4800 is not set
# CONFIG_GPIO_THUNDERX is not set
CONFIG_GPIO_UNIPHIER=m
CONFIG_GPIO_VISCONTI=m
CONFIG_GPIO_VX855=m
# CONFIG_GPIO_XGENE is not set
# CONFIG_GPIO_XGENE_SB is not set
# CONFIG_GPIO_XILINX is not set
CONFIG_GPIO_XLP=m
# CONFIG_GPIO_AMD_FCH is not set
# CONFIG_GPIO_IDT3243X is not set
# end of Memory mapped GPIO drivers

#
# I2C GPIO expanders
#
CONFIG_GPIO_ADNP=y
# CONFIG_GPIO_GW_PLD is not set
CONFIG_GPIO_MAX7300=y
# CONFIG_GPIO_MAX732X is not set
CONFIG_GPIO_PCA953X=y
# CONFIG_GPIO_PCA953X_IRQ is not set
CONFIG_GPIO_PCA9570=m
CONFIG_GPIO_PCF857X=y
CONFIG_GPIO_TPIC2810=m
CONFIG_GPIO_TS4900=m
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
# CONFIG_GPIO_ADP5520 is not set
CONFIG_GPIO_ARIZONA=m
CONFIG_GPIO_BD71815=y
CONFIG_GPIO_BD71828=m
CONFIG_GPIO_BD9571MWV=m
CONFIG_GPIO_DA9052=m
CONFIG_GPIO_JANZ_TTL=m
CONFIG_GPIO_LP3943=m
CONFIG_GPIO_LP87565=m
CONFIG_GPIO_MADERA=m
CONFIG_GPIO_SL28CPLD=y
# CONFIG_GPIO_STMPE is not set
CONFIG_GPIO_TC3589X=y
# CONFIG_GPIO_TIMBERDALE is not set
CONFIG_GPIO_TPS65086=m
# CONFIG_GPIO_TPS65912 is not set
CONFIG_GPIO_TQMX86=y
CONFIG_GPIO_WM831X=y
CONFIG_GPIO_WM8350=y
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
CONFIG_GPIO_AMD8111=y
CONFIG_GPIO_BT8XX=y
CONFIG_GPIO_MLXBF=y
CONFIG_GPIO_MLXBF2=m
# CONFIG_GPIO_ML_IOH is not set
CONFIG_GPIO_PCH=y
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set
# end of PCI GPIO expanders

#
# Virtual GPIO drivers
#
CONFIG_GPIO_AGGREGATOR=m
CONFIG_GPIO_MOCKUP=m
# CONFIG_GPIO_VIRTIO is not set
CONFIG_GPIO_SIM=m
# end of Virtual GPIO drivers

CONFIG_W1=y
# CONFIG_W1_CON is not set

#
# 1-wire Bus Masters
#
# CONFIG_W1_MASTER_MATROX is not set
# CONFIG_W1_MASTER_DS2482 is not set
# CONFIG_W1_MASTER_MXC is not set
# CONFIG_W1_MASTER_DS1WM is not set
# CONFIG_W1_MASTER_GPIO is not set
CONFIG_W1_MASTER_SGI=y
# end of 1-wire Bus Masters

#
# 1-wire Slaves
#
CONFIG_W1_SLAVE_THERM=y
CONFIG_W1_SLAVE_SMEM=m
# CONFIG_W1_SLAVE_DS2405 is not set
# CONFIG_W1_SLAVE_DS2408 is not set
CONFIG_W1_SLAVE_DS2413=m
CONFIG_W1_SLAVE_DS2406=y
CONFIG_W1_SLAVE_DS2423=y
CONFIG_W1_SLAVE_DS2805=y
# CONFIG_W1_SLAVE_DS2430 is not set
CONFIG_W1_SLAVE_DS2431=y
CONFIG_W1_SLAVE_DS2433=m
CONFIG_W1_SLAVE_DS2433_CRC=y
CONFIG_W1_SLAVE_DS2438=y
# CONFIG_W1_SLAVE_DS250X is not set
CONFIG_W1_SLAVE_DS2780=y
CONFIG_W1_SLAVE_DS2781=m
CONFIG_W1_SLAVE_DS28E04=y
# CONFIG_W1_SLAVE_DS28E17 is not set
# end of 1-wire Slaves

CONFIG_POWER_RESET=y
# CONFIG_POWER_RESET_AS3722 is not set
CONFIG_POWER_RESET_ATC260X=m
CONFIG_POWER_RESET_BRCMKONA=y
CONFIG_POWER_RESET_BRCMSTB=y
CONFIG_POWER_RESET_GEMINI_POWEROFF=y
CONFIG_POWER_RESET_GPIO=y
# CONFIG_POWER_RESET_GPIO_RESTART is not set
CONFIG_POWER_RESET_MSM=y
# CONFIG_POWER_RESET_OCELOT_RESET is not set
CONFIG_POWER_RESET_PIIX4_POWEROFF=y
CONFIG_POWER_RESET_LTC2952=y
# CONFIG_POWER_RESET_MT6323 is not set
# CONFIG_POWER_RESET_REGULATOR is not set
# CONFIG_POWER_RESET_RESTART is not set
CONFIG_POWER_RESET_TPS65086=y
# CONFIG_POWER_RESET_VEXPRESS is not set
CONFIG_POWER_RESET_XGENE=y
# CONFIG_POWER_RESET_KEYSTONE is not set
CONFIG_POWER_RESET_SYSCON=y
CONFIG_POWER_RESET_SYSCON_POWEROFF=y
CONFIG_POWER_RESET_RMOBILE=m
CONFIG_REBOOT_MODE=y
CONFIG_SYSCON_REBOOT_MODE=y
# CONFIG_POWER_RESET_SC27XX is not set
CONFIG_NVMEM_REBOOT_MODE=y
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_PDA_POWER=m
CONFIG_IP5XXX_POWER=y
CONFIG_WM831X_BACKUP=m
CONFIG_WM831X_POWER=m
CONFIG_WM8350_POWER=y
CONFIG_TEST_POWER=m
CONFIG_CHARGER_ADP5061=y
CONFIG_BATTERY_ACT8945A=m
CONFIG_BATTERY_CW2015=y
# CONFIG_BATTERY_DS2760 is not set
CONFIG_BATTERY_DS2780=y
CONFIG_BATTERY_DS2781=m
CONFIG_BATTERY_DS2782=y
# CONFIG_BATTERY_SAMSUNG_SDI is not set
# CONFIG_BATTERY_SBS is not set
CONFIG_CHARGER_SBS=y
# CONFIG_MANAGER_SBS is not set
CONFIG_BATTERY_BQ27XXX=m
CONFIG_BATTERY_BQ27XXX_I2C=m
CONFIG_BATTERY_BQ27XXX_HDQ=m
# CONFIG_BATTERY_BQ27XXX_DT_UPDATES_NVM is not set
CONFIG_BATTERY_DA9030=y
CONFIG_BATTERY_DA9052=y
CONFIG_BATTERY_DA9150=m
CONFIG_BATTERY_MAX17040=m
# CONFIG_BATTERY_MAX17042 is not set
# CONFIG_BATTERY_MAX1721X is not set
CONFIG_CHARGER_PCF50633=m
CONFIG_CHARGER_MAX8903=m
CONFIG_CHARGER_LP8727=y
CONFIG_CHARGER_GPIO=m
# CONFIG_CHARGER_MANAGER is not set
# CONFIG_CHARGER_LT3651 is not set
# CONFIG_CHARGER_LTC4162L is not set
CONFIG_CHARGER_DETECTOR_MAX14656=m
CONFIG_CHARGER_MAX77976=y
CONFIG_CHARGER_MT6360=m
CONFIG_CHARGER_QCOM_SMBB=m
CONFIG_CHARGER_BQ2415X=y
# CONFIG_CHARGER_BQ24190 is not set
# CONFIG_CHARGER_BQ24257 is not set
# CONFIG_CHARGER_BQ24735 is not set
CONFIG_CHARGER_BQ2515X=m
# CONFIG_CHARGER_BQ25890 is not set
CONFIG_CHARGER_BQ25980=y
CONFIG_CHARGER_BQ256XX=m
# CONFIG_CHARGER_RK817 is not set
CONFIG_CHARGER_SMB347=y
# CONFIG_CHARGER_TPS65090 is not set
CONFIG_BATTERY_GAUGE_LTC2941=y
# CONFIG_BATTERY_GOLDFISH is not set
CONFIG_BATTERY_RT5033=y
CONFIG_CHARGER_RT9455=y
# CONFIG_CHARGER_SC2731 is not set
CONFIG_CHARGER_UCS1002=y
CONFIG_CHARGER_BD99954=m
CONFIG_BATTERY_ACER_A500=m
CONFIG_BATTERY_UG3105=y
CONFIG_HWMON=m
CONFIG_HWMON_VID=m
CONFIG_HWMON_DEBUG_CHIP=y

#
# Native drivers
#
CONFIG_SENSORS_AD7414=m
# CONFIG_SENSORS_AD7418 is not set
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM1026=m
CONFIG_SENSORS_ADM1029=m
CONFIG_SENSORS_ADM1031=m
# CONFIG_SENSORS_ADM1177 is not set
# CONFIG_SENSORS_ADM9240 is not set
CONFIG_SENSORS_ADT7X10=m
CONFIG_SENSORS_ADT7410=m
CONFIG_SENSORS_ADT7411=m
# CONFIG_SENSORS_ADT7462 is not set
# CONFIG_SENSORS_ADT7470 is not set
CONFIG_SENSORS_ADT7475=m
# CONFIG_SENSORS_AHT10 is not set
CONFIG_SENSORS_AS370=m
# CONFIG_SENSORS_ASC7621 is not set
CONFIG_SENSORS_AXI_FAN_CONTROL=m
CONFIG_SENSORS_ASB100=m
CONFIG_SENSORS_ASPEED=m
# CONFIG_SENSORS_ATXP1 is not set
CONFIG_SENSORS_BT1_PVT=m
# CONFIG_SENSORS_BT1_PVT_ALARMS is not set
# CONFIG_SENSORS_DS620 is not set
CONFIG_SENSORS_DS1621=m
CONFIG_SENSORS_DA9052_ADC=m
# CONFIG_SENSORS_I5K_AMB is not set
CONFIG_SENSORS_SPARX5=m
# CONFIG_SENSORS_F71805F is not set
# CONFIG_SENSORS_F71882FG is not set
# CONFIG_SENSORS_F75375S is not set
# CONFIG_SENSORS_MC13783_ADC is not set
# CONFIG_SENSORS_FSCHMD is not set
CONFIG_SENSORS_GL518SM=m
# CONFIG_SENSORS_GL520SM is not set
CONFIG_SENSORS_G760A=m
CONFIG_SENSORS_G762=m
CONFIG_SENSORS_GPIO_FAN=m
CONFIG_SENSORS_HIH6130=m
# CONFIG_SENSORS_IBMAEM is not set
CONFIG_SENSORS_IBMPEX=m
CONFIG_SENSORS_IT87=m
# CONFIG_SENSORS_JC42 is not set
CONFIG_SENSORS_POWR1220=m
CONFIG_SENSORS_LAN966X=m
# CONFIG_SENSORS_LINEAGE is not set
CONFIG_SENSORS_LOCHNAGAR=m
# CONFIG_SENSORS_LTC2945 is not set
CONFIG_SENSORS_LTC2947=m
CONFIG_SENSORS_LTC2947_I2C=m
CONFIG_SENSORS_LTC2990=m
CONFIG_SENSORS_LTC2992=m
# CONFIG_SENSORS_LTC4151 is not set
CONFIG_SENSORS_LTC4215=m
CONFIG_SENSORS_LTC4222=m
CONFIG_SENSORS_LTC4245=m
CONFIG_SENSORS_LTC4260=m
# CONFIG_SENSORS_LTC4261 is not set
CONFIG_SENSORS_MAX127=m
CONFIG_SENSORS_MAX16065=m
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_MAX1668=m
# CONFIG_SENSORS_MAX197 is not set
CONFIG_SENSORS_MAX31730=m
# CONFIG_SENSORS_MAX31760 is not set
CONFIG_SENSORS_MAX6620=m
# CONFIG_SENSORS_MAX6621 is not set
CONFIG_SENSORS_MAX6639=m
# CONFIG_SENSORS_MAX6650 is not set
# CONFIG_SENSORS_MAX6697 is not set
CONFIG_SENSORS_MAX31790=m
CONFIG_SENSORS_MCP3021=m
CONFIG_SENSORS_MLXREG_FAN=m
# CONFIG_SENSORS_TC654 is not set
# CONFIG_SENSORS_TPS23861 is not set
CONFIG_SENSORS_MR75203=m
CONFIG_SENSORS_LM63=m
CONFIG_SENSORS_LM73=m
# CONFIG_SENSORS_LM75 is not set
CONFIG_SENSORS_LM77=m
CONFIG_SENSORS_LM78=m
# CONFIG_SENSORS_LM80 is not set
CONFIG_SENSORS_LM83=m
# CONFIG_SENSORS_LM85 is not set
# CONFIG_SENSORS_LM87 is not set
CONFIG_SENSORS_LM90=m
CONFIG_SENSORS_LM92=m
CONFIG_SENSORS_LM93=m
# CONFIG_SENSORS_LM95234 is not set
# CONFIG_SENSORS_LM95241 is not set
# CONFIG_SENSORS_LM95245 is not set
CONFIG_SENSORS_PC87360=m
CONFIG_SENSORS_PC87427=m
CONFIG_SENSORS_NCT6683=m
CONFIG_SENSORS_NCT6775_CORE=m
# CONFIG_SENSORS_NCT6775 is not set
CONFIG_SENSORS_NCT6775_I2C=m
CONFIG_SENSORS_NCT7802=m
CONFIG_SENSORS_NPCM7XX=m
CONFIG_SENSORS_NSA320=m
# CONFIG_SENSORS_OCC_P8_I2C is not set
# CONFIG_SENSORS_OCC_P9_SBE is not set
CONFIG_SENSORS_PCF8591=m
CONFIG_PMBUS=m
CONFIG_SENSORS_PMBUS=m
CONFIG_SENSORS_ADM1266=m
CONFIG_SENSORS_ADM1275=m
# CONFIG_SENSORS_BEL_PFE is not set
CONFIG_SENSORS_BPA_RS600=m
CONFIG_SENSORS_DELTA_AHE50DC_FAN=m
CONFIG_SENSORS_FSP_3Y=m
# CONFIG_SENSORS_IBM_CFFPS is not set
CONFIG_SENSORS_DPS920AB=m
CONFIG_SENSORS_INSPUR_IPSPS=m
CONFIG_SENSORS_IR35221=m
CONFIG_SENSORS_IR36021=m
CONFIG_SENSORS_IR38064=m
CONFIG_SENSORS_IR38064_REGULATOR=y
CONFIG_SENSORS_IRPS5401=m
CONFIG_SENSORS_ISL68137=m
CONFIG_SENSORS_LM25066=m
CONFIG_SENSORS_LM25066_REGULATOR=y
# CONFIG_SENSORS_LT7182S is not set
# CONFIG_SENSORS_LTC2978 is not set
CONFIG_SENSORS_LTC3815=m
CONFIG_SENSORS_MAX15301=m
CONFIG_SENSORS_MAX16064=m
CONFIG_SENSORS_MAX16601=m
CONFIG_SENSORS_MAX20730=m
CONFIG_SENSORS_MAX20751=m
CONFIG_SENSORS_MAX31785=m
CONFIG_SENSORS_MAX34440=m
CONFIG_SENSORS_MAX8688=m
CONFIG_SENSORS_MP2888=m
CONFIG_SENSORS_MP2975=m
CONFIG_SENSORS_MP5023=m
# CONFIG_SENSORS_PIM4328 is not set
# CONFIG_SENSORS_PLI1209BC is not set
CONFIG_SENSORS_PM6764TR=m
CONFIG_SENSORS_PXE1610=m
# CONFIG_SENSORS_Q54SJ108A2 is not set
CONFIG_SENSORS_STPDDC60=m
# CONFIG_SENSORS_TPS40422 is not set
CONFIG_SENSORS_TPS53679=m
CONFIG_SENSORS_TPS546D24=m
CONFIG_SENSORS_UCD9000=m
# CONFIG_SENSORS_UCD9200 is not set
CONFIG_SENSORS_XDPE152=m
CONFIG_SENSORS_XDPE122=m
CONFIG_SENSORS_XDPE122_REGULATOR=y
# CONFIG_SENSORS_ZL6100 is not set
CONFIG_SENSORS_PWM_FAN=m
CONFIG_SENSORS_RASPBERRYPI_HWMON=m
CONFIG_SENSORS_SL28CPLD=m
# CONFIG_SENSORS_SBTSI is not set
CONFIG_SENSORS_SBRMI=m
# CONFIG_SENSORS_SHT15 is not set
CONFIG_SENSORS_SHT21=m
CONFIG_SENSORS_SHT3x=m
CONFIG_SENSORS_SHT4x=m
CONFIG_SENSORS_SHTC1=m
CONFIG_SENSORS_SIS5595=m
CONFIG_SENSORS_DME1737=m
CONFIG_SENSORS_EMC1403=m
CONFIG_SENSORS_EMC2103=m
CONFIG_SENSORS_EMC2305=m
CONFIG_SENSORS_EMC6W201=m
# CONFIG_SENSORS_SMSC47M1 is not set
CONFIG_SENSORS_SMSC47M192=m
# CONFIG_SENSORS_SMSC47B397 is not set
CONFIG_SENSORS_STTS751=m
CONFIG_SENSORS_SMM665=m
CONFIG_SENSORS_ADC128D818=m
CONFIG_SENSORS_ADS7828=m
# CONFIG_SENSORS_AMC6821 is not set
CONFIG_SENSORS_INA209=m
CONFIG_SENSORS_INA2XX=m
# CONFIG_SENSORS_INA238 is not set
# CONFIG_SENSORS_INA3221 is not set
CONFIG_SENSORS_TC74=m
# CONFIG_SENSORS_THMC50 is not set
# CONFIG_SENSORS_TMP102 is not set
CONFIG_SENSORS_TMP103=m
CONFIG_SENSORS_TMP108=m
CONFIG_SENSORS_TMP401=m
CONFIG_SENSORS_TMP421=m
CONFIG_SENSORS_TMP464=m
CONFIG_SENSORS_TMP513=m
CONFIG_SENSORS_VEXPRESS=m
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_VT1211=m
CONFIG_SENSORS_VT8231=m
CONFIG_SENSORS_W83773G=m
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83791D=m
CONFIG_SENSORS_W83792D=m
# CONFIG_SENSORS_W83793 is not set
CONFIG_SENSORS_W83795=m
# CONFIG_SENSORS_W83795_FANCTRL is not set
CONFIG_SENSORS_W83L785TS=m
CONFIG_SENSORS_W83L786NG=m
# CONFIG_SENSORS_W83627HF is not set
CONFIG_SENSORS_W83627EHF=m
# CONFIG_SENSORS_WM831X is not set
CONFIG_SENSORS_WM8350=m
CONFIG_THERMAL=y
# CONFIG_THERMAL_NETLINK is not set
CONFIG_THERMAL_STATISTICS=y
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
# CONFIG_THERMAL_OF is not set
CONFIG_THERMAL_WRITABLE_TRIPS=y
# CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE is not set
CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE=y
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
# CONFIG_THERMAL_GOV_STEP_WISE is not set
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_DEVFREQ_THERMAL is not set
CONFIG_THERMAL_EMULATION=y
CONFIG_THERMAL_MMIO=m
CONFIG_HISI_THERMAL=y
CONFIG_IMX_THERMAL=m
CONFIG_IMX8MM_THERMAL=m
CONFIG_K3_THERMAL=m
CONFIG_SPEAR_THERMAL=y
# CONFIG_SUN8I_THERMAL is not set
CONFIG_ROCKCHIP_THERMAL=y
# CONFIG_RCAR_THERMAL is not set
# CONFIG_RCAR_GEN3_THERMAL is not set
CONFIG_RZG2L_THERMAL=m
CONFIG_KIRKWOOD_THERMAL=y
CONFIG_DOVE_THERMAL=y
# CONFIG_ARMADA_THERMAL is not set
CONFIG_DA9062_THERMAL=m
CONFIG_MTK_THERMAL=m

#
# Intel thermal drivers
#

#
# ACPI INT340X thermal drivers
#
# end of ACPI INT340X thermal drivers
# end of Intel thermal drivers

#
# Broadcom thermal drivers
#
# CONFIG_BRCMSTB_THERMAL is not set
CONFIG_BCM_NS_THERMAL=y
CONFIG_BCM_SR_THERMAL=m
# end of Broadcom thermal drivers

#
# Texas Instruments thermal drivers
#
# CONFIG_TI_SOC_THERMAL is not set
# end of Texas Instruments thermal drivers

#
# Samsung thermal drivers
#
# end of Samsung thermal drivers

#
# NVIDIA Tegra thermal drivers
#
# CONFIG_TEGRA_SOCTHERM is not set
CONFIG_TEGRA_BPMP_THERMAL=m
CONFIG_TEGRA30_TSENSOR=m
# end of NVIDIA Tegra thermal drivers

#
# Qualcomm thermal drivers
#
CONFIG_QCOM_TSENS=m
# CONFIG_QCOM_LMH is not set
# end of Qualcomm thermal drivers

CONFIG_SPRD_THERMAL=y
# CONFIG_WATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=m
CONFIG_SSB_PCIHOST_POSSIBLE=y
# CONFIG_SSB_PCIHOST is not set
CONFIG_SSB_DRIVER_GPIO=y
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=m
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
# CONFIG_BCMA_HOST_PCI is not set
# CONFIG_BCMA_HOST_SOC is not set
CONFIG_BCMA_DRIVER_PCI=y
# CONFIG_BCMA_DRIVER_MIPS is not set
# CONFIG_BCMA_DRIVER_GMAC_CMN is not set
CONFIG_BCMA_DRIVER_GPIO=y
CONFIG_BCMA_DEBUG=y

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
CONFIG_MFD_ACT8945A=m
CONFIG_MFD_SUN4I_GPADC=y
# CONFIG_MFD_AS3711 is not set
CONFIG_MFD_AS3722=y
CONFIG_PMIC_ADP5520=y
CONFIG_MFD_AAT2870_CORE=y
CONFIG_MFD_AT91_USART=y
# CONFIG_MFD_ATMEL_FLEXCOM is not set
# CONFIG_MFD_ATMEL_HLCDC is not set
CONFIG_MFD_BCM590XX=m
CONFIG_MFD_BD9571MWV=y
CONFIG_MFD_AXP20X=m
CONFIG_MFD_AXP20X_I2C=m
# CONFIG_MFD_CROS_EC_DEV is not set
CONFIG_MFD_MADERA=m
CONFIG_MFD_MADERA_I2C=m
CONFIG_MFD_CS47L15=y
# CONFIG_MFD_CS47L35 is not set
# CONFIG_MFD_CS47L85 is not set
# CONFIG_MFD_CS47L90 is not set
# CONFIG_MFD_CS47L92 is not set
# CONFIG_MFD_ASIC3 is not set
CONFIG_PMIC_DA903X=y
CONFIG_PMIC_DA9052=y
CONFIG_MFD_DA9052_I2C=y
# CONFIG_MFD_DA9055 is not set
CONFIG_MFD_DA9062=m
# CONFIG_MFD_DA9063 is not set
CONFIG_MFD_DA9150=m
CONFIG_MFD_ENE_KB3930=y
CONFIG_MFD_EXYNOS_LPASS=m
# CONFIG_MFD_GATEWORKS_GSC is not set
CONFIG_MFD_MC13XXX=y
CONFIG_MFD_MC13XXX_I2C=y
# CONFIG_MFD_MP2629 is not set
CONFIG_MFD_MXS_LRADC=y
CONFIG_MFD_MX25_TSADC=y
# CONFIG_MFD_HI6421_PMIC is not set
CONFIG_MFD_HI655X_PMIC=y
# CONFIG_HTC_PASIC3 is not set
# CONFIG_HTC_I2CPLD is not set
CONFIG_LPC_ICH=y
CONFIG_LPC_SCH=y
CONFIG_MFD_IQS62X=y
CONFIG_MFD_JANZ_CMODIO=m
# CONFIG_MFD_KEMPLD is not set
# CONFIG_MFD_88PM800 is not set
CONFIG_MFD_88PM805=y
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_MAX14577 is not set
# CONFIG_MFD_MAX77620 is not set
# CONFIG_MFD_MAX77650 is not set
# CONFIG_MFD_MAX77686 is not set
# CONFIG_MFD_MAX77693 is not set
CONFIG_MFD_MAX77714=y
CONFIG_MFD_MAX77843=y
CONFIG_MFD_MAX8907=m
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
CONFIG_MFD_MAX8998=y
CONFIG_MFD_MT6360=m
CONFIG_MFD_MT6370=m
CONFIG_MFD_MT6397=m
# CONFIG_MFD_MENF21BMC is not set
CONFIG_MFD_NTXEC=y
CONFIG_MFD_RETU=y
CONFIG_MFD_PCF50633=m
# CONFIG_PCF50633_ADC is not set
CONFIG_PCF50633_GPIO=m
CONFIG_MFD_PM8XXX=y
CONFIG_MFD_QCOM_RPM=y
# CONFIG_MFD_SY7636A is not set
CONFIG_MFD_RDC321X=y
# CONFIG_MFD_RT4831 is not set
CONFIG_MFD_RT5033=y
CONFIG_MFD_RT5120=y
# CONFIG_MFD_RC5T583 is not set
CONFIG_MFD_RK808=y
CONFIG_MFD_RN5T618=m
CONFIG_MFD_SEC_CORE=y
# CONFIG_MFD_SI476X_CORE is not set
CONFIG_MFD_SIMPLE_MFD_I2C=y
CONFIG_MFD_SL28CPLD=y
# CONFIG_MFD_SM501 is not set
CONFIG_MFD_SKY81452=m
CONFIG_ABX500_CORE=y
CONFIG_MFD_STMPE=y

#
# STMicroelectronics STMPE Interface Drivers
#
CONFIG_STMPE_I2C=y
# end of STMicroelectronics STMPE Interface Drivers

# CONFIG_MFD_SUN6I_PRCM is not set
CONFIG_MFD_SYSCON=y
CONFIG_MFD_TI_AM335X_TSCADC=y
CONFIG_MFD_LP3943=m
# CONFIG_MFD_LP8788 is not set
# CONFIG_MFD_TI_LMU is not set
# CONFIG_MFD_PALMAS is not set
CONFIG_TPS6105X=m
CONFIG_TPS65010=y
# CONFIG_TPS6507X is not set
CONFIG_MFD_TPS65086=y
CONFIG_MFD_TPS65090=y
# CONFIG_MFD_TPS65217 is not set
# CONFIG_MFD_TI_LP873X is not set
CONFIG_MFD_TI_LP87565=m
# CONFIG_MFD_TPS65218 is not set
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
CONFIG_MFD_TPS65912=m
CONFIG_MFD_TPS65912_I2C=m
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
CONFIG_MFD_WL1273_CORE=y
CONFIG_MFD_LM3533=y
CONFIG_MFD_TIMBERDALE=m
CONFIG_MFD_TC3589X=y
# CONFIG_MFD_TQMX86 is not set
CONFIG_MFD_VX855=m
CONFIG_MFD_LOCHNAGAR=y
CONFIG_MFD_ARIZONA=m
CONFIG_MFD_ARIZONA_I2C=m
CONFIG_MFD_CS47L24=y
# CONFIG_MFD_WM5102 is not set
CONFIG_MFD_WM5110=y
CONFIG_MFD_WM8997=y
# CONFIG_MFD_WM8998 is not set
CONFIG_MFD_WM8400=y
CONFIG_MFD_WM831X=y
CONFIG_MFD_WM831X_I2C=y
CONFIG_MFD_WM8350=y
CONFIG_MFD_WM8350_I2C=y
# CONFIG_MFD_WM8994 is not set
CONFIG_MFD_STW481X=y
CONFIG_MFD_ROHM_BD718XX=m
CONFIG_MFD_ROHM_BD71828=y
# CONFIG_MFD_ROHM_BD957XMUF is not set
CONFIG_MFD_STM32_LPTIMER=m
CONFIG_MFD_STM32_TIMERS=m
# CONFIG_MFD_STPMIC1 is not set
# CONFIG_MFD_STMFX is not set
# CONFIG_MFD_WCD934X is not set
CONFIG_MFD_ATC260X=y
CONFIG_MFD_ATC260X_I2C=y
# CONFIG_MFD_KHADAS_MCU is not set
CONFIG_MFD_ACER_A500_EC=y
# CONFIG_MFD_QCOM_PM8008 is not set
CONFIG_MFD_VEXPRESS_SYSREG=y
# CONFIG_RAVE_SP_CORE is not set
CONFIG_MFD_RSMU_I2C=y
# end of Multifunction device drivers

CONFIG_REGULATOR=y
# CONFIG_REGULATOR_DEBUG is not set
CONFIG_REGULATOR_FIXED_VOLTAGE=m
CONFIG_REGULATOR_VIRTUAL_CONSUMER=y
CONFIG_REGULATOR_USERSPACE_CONSUMER=m
CONFIG_REGULATOR_88PG86X=y
# CONFIG_REGULATOR_ACT8865 is not set
CONFIG_REGULATOR_ACT8945A=m
# CONFIG_REGULATOR_AD5398 is not set
CONFIG_REGULATOR_ANATOP=m
CONFIG_REGULATOR_AAT2870=y
CONFIG_REGULATOR_AS3722=y
# CONFIG_REGULATOR_ATC260X is not set
CONFIG_REGULATOR_AXP20X=m
CONFIG_REGULATOR_BCM590XX=m
CONFIG_REGULATOR_BD71815=y
CONFIG_REGULATOR_BD71828=y
CONFIG_REGULATOR_BD718XX=m
# CONFIG_REGULATOR_BD9571MWV is not set
CONFIG_REGULATOR_CROS_EC=y
CONFIG_REGULATOR_DA903X=m
# CONFIG_REGULATOR_DA9052 is not set
# CONFIG_REGULATOR_DA9062 is not set
CONFIG_REGULATOR_DA9121=y
# CONFIG_REGULATOR_DA9210 is not set
CONFIG_REGULATOR_DA9211=m
CONFIG_REGULATOR_FAN53555=y
# CONFIG_REGULATOR_FAN53880 is not set
# CONFIG_REGULATOR_GPIO is not set
CONFIG_REGULATOR_HI655X=y
CONFIG_REGULATOR_ISL9305=m
CONFIG_REGULATOR_ISL6271A=m
# CONFIG_REGULATOR_LOCHNAGAR is not set
CONFIG_REGULATOR_LP3971=m
CONFIG_REGULATOR_LP3972=m
CONFIG_REGULATOR_LP872X=y
# CONFIG_REGULATOR_LP8755 is not set
CONFIG_REGULATOR_LP87565=m
# CONFIG_REGULATOR_LTC3589 is not set
CONFIG_REGULATOR_LTC3676=m
CONFIG_REGULATOR_MAX1586=m
CONFIG_REGULATOR_MAX77620=y
CONFIG_REGULATOR_MAX77650=m
CONFIG_REGULATOR_MAX8649=m
CONFIG_REGULATOR_MAX8660=y
CONFIG_REGULATOR_MAX8893=y
# CONFIG_REGULATOR_MAX8907 is not set
# CONFIG_REGULATOR_MAX8952 is not set
# CONFIG_REGULATOR_MAX8998 is not set
CONFIG_REGULATOR_MAX20086=y
CONFIG_REGULATOR_MAX77686=m
# CONFIG_REGULATOR_MAX77693 is not set
CONFIG_REGULATOR_MAX77802=m
CONFIG_REGULATOR_MAX77826=m
CONFIG_REGULATOR_MC13XXX_CORE=y
CONFIG_REGULATOR_MC13783=y
# CONFIG_REGULATOR_MC13892 is not set
CONFIG_REGULATOR_MCP16502=y
CONFIG_REGULATOR_MP5416=m
CONFIG_REGULATOR_MP8859=y
CONFIG_REGULATOR_MP886X=y
CONFIG_REGULATOR_MPQ7920=m
CONFIG_REGULATOR_MT6311=y
# CONFIG_REGULATOR_MT6323 is not set
# CONFIG_REGULATOR_MT6331 is not set
CONFIG_REGULATOR_MT6332=m
# CONFIG_REGULATOR_MT6358 is not set
CONFIG_REGULATOR_MT6359=m
# CONFIG_REGULATOR_MT6360 is not set
# CONFIG_REGULATOR_MT6370 is not set
CONFIG_REGULATOR_MT6397=m
CONFIG_REGULATOR_PBIAS=m
CONFIG_REGULATOR_PCA9450=y
CONFIG_REGULATOR_PCF50633=m
CONFIG_REGULATOR_PF8X00=y
CONFIG_REGULATOR_PFUZE100=m
CONFIG_REGULATOR_PV88060=m
# CONFIG_REGULATOR_PV88080 is not set
CONFIG_REGULATOR_PV88090=m
# CONFIG_REGULATOR_PWM is not set
CONFIG_REGULATOR_QCOM_RPM=y
# CONFIG_REGULATOR_QCOM_RPMH is not set
CONFIG_REGULATOR_QCOM_SMD_RPM=m
CONFIG_REGULATOR_QCOM_SPMI=y
CONFIG_REGULATOR_QCOM_USB_VBUS=y
# CONFIG_REGULATOR_RASPBERRYPI_TOUCHSCREEN_ATTINY is not set
# CONFIG_REGULATOR_RK808 is not set
CONFIG_REGULATOR_RN5T618=m
CONFIG_REGULATOR_ROHM=y
# CONFIG_REGULATOR_RT4801 is not set
CONFIG_REGULATOR_RT5033=m
CONFIG_REGULATOR_RT5120=m
# CONFIG_REGULATOR_RT5190A is not set
CONFIG_REGULATOR_RT5759=y
# CONFIG_REGULATOR_RT6160 is not set
# CONFIG_REGULATOR_RT6245 is not set
# CONFIG_REGULATOR_RTQ2134 is not set
CONFIG_REGULATOR_RTMV20=y
CONFIG_REGULATOR_RTQ6752=m
CONFIG_REGULATOR_S2MPA01=m
CONFIG_REGULATOR_S2MPS11=y
CONFIG_REGULATOR_S5M8767=m
CONFIG_REGULATOR_SC2731=y
CONFIG_REGULATOR_SKY81452=m
# CONFIG_REGULATOR_SLG51000 is not set
CONFIG_REGULATOR_STM32_BOOSTER=m
# CONFIG_REGULATOR_STM32_VREFBUF is not set
# CONFIG_REGULATOR_STM32_PWR is not set
CONFIG_REGULATOR_TI_ABB=m
CONFIG_REGULATOR_STW481X_VMMC=y
CONFIG_REGULATOR_SY8106A=m
CONFIG_REGULATOR_SY8824X=y
CONFIG_REGULATOR_SY8827N=y
CONFIG_REGULATOR_TPS51632=m
# CONFIG_REGULATOR_TPS6105X is not set
CONFIG_REGULATOR_TPS62360=m
CONFIG_REGULATOR_TPS6286X=y
CONFIG_REGULATOR_TPS65023=y
CONFIG_REGULATOR_TPS6507X=m
CONFIG_REGULATOR_TPS65086=y
CONFIG_REGULATOR_TPS65090=y
# CONFIG_REGULATOR_TPS65132 is not set
# CONFIG_REGULATOR_TPS65912 is not set
CONFIG_REGULATOR_TPS68470=y
# CONFIG_REGULATOR_UNIPHIER is not set
CONFIG_REGULATOR_VCTRL=m
CONFIG_REGULATOR_VEXPRESS=m
CONFIG_REGULATOR_VQMMC_IPQ4019=m
CONFIG_REGULATOR_WM831X=y
CONFIG_REGULATOR_WM8350=m
CONFIG_REGULATOR_WM8400=y
CONFIG_REGULATOR_QCOM_LABIBB=y
CONFIG_CEC_CORE=y
CONFIG_CEC_NOTIFIER=y
CONFIG_CEC_PIN=y

#
# CEC support
#
# CONFIG_CEC_PIN_ERROR_INJ is not set
CONFIG_MEDIA_CEC_SUPPORT=y
CONFIG_CEC_CH7322=m
CONFIG_CEC_CROS_EC=y
CONFIG_CEC_MESON_AO=m
CONFIG_CEC_MESON_G12A_AO=m
CONFIG_CEC_GPIO=y
# CONFIG_CEC_SAMSUNG_S5P is not set
CONFIG_CEC_STI=y
CONFIG_CEC_STM32=m
# CONFIG_CEC_TEGRA is not set
# end of CEC support

# CONFIG_MEDIA_SUPPORT is not set

#
# Graphics support
#
CONFIG_APERTURE_HELPERS=y
CONFIG_TEGRA_HOST1X_CONTEXT_BUS=y
CONFIG_TEGRA_HOST1X=y
# CONFIG_TEGRA_HOST1X_FIREWALL is not set
CONFIG_IMX_IPUV3_CORE=m
CONFIG_DRM=m
CONFIG_DRM_MIPI_DSI=y
CONFIG_DRM_KUNIT_TEST=m
CONFIG_DRM_KMS_HELPER=m
# CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS is not set
# CONFIG_DRM_DEBUG_MODESET_LOCK is not set
# CONFIG_DRM_FBDEV_EMULATION is not set
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
CONFIG_DRM_DP_AUX_BUS=m
CONFIG_DRM_DISPLAY_HELPER=m
CONFIG_DRM_DISPLAY_DP_HELPER=y
CONFIG_DRM_DISPLAY_HDCP_HELPER=y
CONFIG_DRM_DISPLAY_HDMI_HELPER=y
# CONFIG_DRM_DP_AUX_CHARDEV is not set
# CONFIG_DRM_DP_CEC is not set
CONFIG_DRM_TTM=m
CONFIG_DRM_BUDDY=m
CONFIG_DRM_VRAM_HELPER=m
CONFIG_DRM_TTM_HELPER=m
CONFIG_DRM_GEM_DMA_HELPER=m
CONFIG_DRM_GEM_SHMEM_HELPER=m
CONFIG_DRM_SCHED=m

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=m
# CONFIG_DRM_I2C_SIL164 is not set
CONFIG_DRM_I2C_NXP_TDA998X=m
CONFIG_DRM_I2C_NXP_TDA9950=m
# end of I2C encoder or helper chips

#
# ARM devices
#
CONFIG_DRM_HDLCD=m
# CONFIG_DRM_HDLCD_SHOW_UNDERRUN is not set
CONFIG_DRM_MALI_DISPLAY=m
# CONFIG_DRM_KOMEDA is not set
# end of ARM devices

CONFIG_DRM_RADEON=m
# CONFIG_DRM_RADEON_USERPTR is not set
CONFIG_DRM_AMDGPU=m
# CONFIG_DRM_AMDGPU_SI is not set
# CONFIG_DRM_AMDGPU_CIK is not set
# CONFIG_DRM_AMDGPU_USERPTR is not set

#
# ACP (Audio CoProcessor) Configuration
#
# CONFIG_DRM_AMD_ACP is not set
# end of ACP (Audio CoProcessor) Configuration

#
# Display Engine Configuration
#
CONFIG_DRM_AMD_DC=y
CONFIG_DRM_AMD_DC_DCN=y
# CONFIG_DRM_AMD_DC_HDCP is not set
# CONFIG_DRM_AMD_SECURE_DISPLAY is not set
# end of Display Engine Configuration

# CONFIG_HSA_AMD is not set
CONFIG_DRM_NOUVEAU=m
# CONFIG_NOUVEAU_LEGACY_CTX_SUPPORT is not set
# CONFIG_NOUVEAU_PLATFORM_DRIVER is not set
CONFIG_NOUVEAU_DEBUG=5
CONFIG_NOUVEAU_DEBUG_DEFAULT=3
CONFIG_NOUVEAU_DEBUG_MMU=y
CONFIG_NOUVEAU_DEBUG_PUSH=y
# CONFIG_DRM_NOUVEAU_BACKLIGHT is not set
CONFIG_DRM_KMB_DISPLAY=m
CONFIG_DRM_VGEM=m
CONFIG_DRM_VKMS=m
CONFIG_DRM_EXYNOS=m

#
# CRTCs
#
# CONFIG_DRM_EXYNOS_FIMD is not set
CONFIG_DRM_EXYNOS5433_DECON=y
CONFIG_DRM_EXYNOS7_DECON=y
CONFIG_DRM_EXYNOS_MIXER=y
CONFIG_DRM_EXYNOS_VIDI=y

#
# Encoders and Bridges
#
# CONFIG_DRM_EXYNOS_DSI is not set
CONFIG_DRM_EXYNOS_DP=y
CONFIG_DRM_EXYNOS_HDMI=y
# CONFIG_DRM_EXYNOS_MIC is not set

#
# Sub-drivers
#
# CONFIG_DRM_EXYNOS_G2D is not set
CONFIG_DRM_EXYNOS_IPP=y
CONFIG_DRM_EXYNOS_FIMC=y
# CONFIG_DRM_EXYNOS_ROTATOR is not set
# CONFIG_DRM_EXYNOS_SCALER is not set
# CONFIG_DRM_EXYNOS_GSC is not set
# CONFIG_DRM_VMWGFX is not set
CONFIG_DRM_AST=m
# CONFIG_DRM_MGAG200 is not set
CONFIG_DRM_RCAR_DU=m
CONFIG_DRM_RCAR_USE_CMM=y
CONFIG_DRM_RCAR_CMM=m
CONFIG_DRM_RCAR_DW_HDMI=m
# CONFIG_DRM_RCAR_USE_LVDS is not set
# CONFIG_DRM_RCAR_MIPI_DSI is not set
CONFIG_DRM_RCAR_WRITEBACK=y
CONFIG_DRM_SUN4I=m
CONFIG_DRM_SUN4I_HDMI=m
CONFIG_DRM_SUN4I_HDMI_CEC=y
CONFIG_DRM_SUN4I_BACKEND=m
CONFIG_DRM_SUN6I_DSI=m
# CONFIG_DRM_SUN8I_DW_HDMI is not set
# CONFIG_DRM_SUN8I_MIXER is not set
CONFIG_DRM_QXL=m
CONFIG_DRM_MSM=m
CONFIG_DRM_MSM_GPU_STATE=y
CONFIG_DRM_MSM_GPU_SUDO=y
CONFIG_DRM_MSM_MDSS=y
CONFIG_DRM_MSM_MDP4=y
CONFIG_DRM_MSM_MDP5=y
CONFIG_DRM_MSM_DPU=y
# CONFIG_DRM_MSM_DP is not set
# CONFIG_DRM_MSM_DSI is not set
CONFIG_DRM_MSM_HDMI=y
# CONFIG_DRM_MSM_HDMI_HDCP is not set
CONFIG_DRM_TEGRA=m
# CONFIG_DRM_TEGRA_DEBUG is not set
# CONFIG_DRM_TEGRA_STAGING is not set
CONFIG_DRM_PANEL=y

#
# Display Panels
#
CONFIG_DRM_PANEL_ARM_VERSATILE=m
CONFIG_DRM_PANEL_ASUS_Z00T_TM5P5_NT35596=m
CONFIG_DRM_PANEL_BOE_BF060Y8M_AJ0=m
CONFIG_DRM_PANEL_BOE_HIMAX8279D=m
# CONFIG_DRM_PANEL_BOE_TV101WUM_NL6 is not set
CONFIG_DRM_PANEL_DSI_CM=m
CONFIG_DRM_PANEL_LVDS=m
CONFIG_DRM_PANEL_SIMPLE=m
# CONFIG_DRM_PANEL_EDP is not set
CONFIG_DRM_PANEL_EBBG_FT8719=m
# CONFIG_DRM_PANEL_ELIDA_KD35T133 is not set
# CONFIG_DRM_PANEL_FEIXIN_K101_IM2BA02 is not set
CONFIG_DRM_PANEL_FEIYANG_FY07024DI26A30D=m
CONFIG_DRM_PANEL_ILITEK_ILI9881C=m
CONFIG_DRM_PANEL_INNOLUX_P079ZCA=m
CONFIG_DRM_PANEL_JDI_LT070ME05000=m
# CONFIG_DRM_PANEL_JDI_R63452 is not set
CONFIG_DRM_PANEL_KHADAS_TS050=m
CONFIG_DRM_PANEL_KINGDISPLAY_KD097D04=m
# CONFIG_DRM_PANEL_LEADTEK_LTK050H3146W is not set
CONFIG_DRM_PANEL_LEADTEK_LTK500HD1829=m
CONFIG_DRM_PANEL_NOVATEK_NT35510=m
CONFIG_DRM_PANEL_NOVATEK_NT35560=m
CONFIG_DRM_PANEL_NOVATEK_NT35950=m
# CONFIG_DRM_PANEL_NOVATEK_NT36672A is not set
CONFIG_DRM_PANEL_MANTIX_MLAF057WE51=m
# CONFIG_DRM_PANEL_OLIMEX_LCD_OLINUXINO is not set
CONFIG_DRM_PANEL_ORISETECH_OTM8009A=m
CONFIG_DRM_PANEL_OSD_OSD101T2587_53TS=m
CONFIG_DRM_PANEL_PANASONIC_VVX10F034N00=m
# CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN is not set
# CONFIG_DRM_PANEL_RAYDIUM_RM67191 is not set
# CONFIG_DRM_PANEL_RAYDIUM_RM68200 is not set
# CONFIG_DRM_PANEL_RONBO_RB070D30 is not set
# CONFIG_DRM_PANEL_SAMSUNG_ATNA33XC20 is not set
CONFIG_DRM_PANEL_SAMSUNG_S6D16D0=m
CONFIG_DRM_PANEL_SAMSUNG_S6E3HA2=m
CONFIG_DRM_PANEL_SAMSUNG_S6E63J0X03=m
# CONFIG_DRM_PANEL_SAMSUNG_S6E63M0 is not set
# CONFIG_DRM_PANEL_SAMSUNG_S6E88A0_AMS452EF01 is not set
CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0=m
# CONFIG_DRM_PANEL_SAMSUNG_SOFEF00 is not set
CONFIG_DRM_PANEL_SEIKO_43WVF1G=m
# CONFIG_DRM_PANEL_SHARP_LQ101R1SX01 is not set
# CONFIG_DRM_PANEL_SHARP_LS037V7DW01 is not set
CONFIG_DRM_PANEL_SHARP_LS043T1LE01=m
CONFIG_DRM_PANEL_SHARP_LS060T1SX01=m
CONFIG_DRM_PANEL_SITRONIX_ST7701=m
# CONFIG_DRM_PANEL_SITRONIX_ST7703 is not set
CONFIG_DRM_PANEL_SONY_TULIP_TRULY_NT35521=m
# CONFIG_DRM_PANEL_TDO_TL070WSH30 is not set
CONFIG_DRM_PANEL_TRULY_NT35597_WQXGA=m
CONFIG_DRM_PANEL_VISIONOX_RM69299=m
# CONFIG_DRM_PANEL_XINPENG_XPP055C272 is not set
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_CDNS_DSI is not set
CONFIG_DRM_CHIPONE_ICN6211=m
# CONFIG_DRM_CHRONTEL_CH7033 is not set
CONFIG_DRM_CROS_EC_ANX7688=m
CONFIG_DRM_DISPLAY_CONNECTOR=m
# CONFIG_DRM_FSL_LDB is not set
CONFIG_DRM_ITE_IT6505=m
# CONFIG_DRM_LONTIUM_LT8912B is not set
# CONFIG_DRM_LONTIUM_LT9211 is not set
CONFIG_DRM_LONTIUM_LT9611=m
# CONFIG_DRM_LONTIUM_LT9611UXC is not set
# CONFIG_DRM_ITE_IT66121 is not set
CONFIG_DRM_LVDS_CODEC=m
CONFIG_DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW=m
# CONFIG_DRM_NWL_MIPI_DSI is not set
CONFIG_DRM_NXP_PTN3460=m
CONFIG_DRM_PARADE_PS8622=m
CONFIG_DRM_PARADE_PS8640=m
CONFIG_DRM_SIL_SII8620=m
CONFIG_DRM_SII902X=m
# CONFIG_DRM_SII9234 is not set
# CONFIG_DRM_SIMPLE_BRIDGE is not set
CONFIG_DRM_THINE_THC63LVD1024=m
CONFIG_DRM_TOSHIBA_TC358762=m
CONFIG_DRM_TOSHIBA_TC358764=m
# CONFIG_DRM_TOSHIBA_TC358767 is not set
# CONFIG_DRM_TOSHIBA_TC358768 is not set
CONFIG_DRM_TOSHIBA_TC358775=m
CONFIG_DRM_TI_DLPC3433=m
# CONFIG_DRM_TI_TFP410 is not set
# CONFIG_DRM_TI_SN65DSI83 is not set
CONFIG_DRM_TI_SN65DSI86=m
CONFIG_DRM_TI_TPD12S015=m
# CONFIG_DRM_ANALOGIX_ANX6345 is not set
CONFIG_DRM_ANALOGIX_ANX78XX=m
CONFIG_DRM_ANALOGIX_DP=m
# CONFIG_DRM_ANALOGIX_ANX7625 is not set
# CONFIG_DRM_I2C_ADV7511 is not set
CONFIG_DRM_CDNS_MHDP8546=m
CONFIG_DRM_CDNS_MHDP8546_J721E=y
# CONFIG_DRM_IMX8QM_LDB is not set
CONFIG_DRM_IMX8QXP_LDB=m
CONFIG_DRM_IMX8QXP_PIXEL_COMBINER=m
# CONFIG_DRM_IMX8QXP_PIXEL_LINK_TO_DPI is not set
CONFIG_DRM_DW_HDMI=m
# CONFIG_DRM_DW_HDMI_I2S_AUDIO is not set
CONFIG_DRM_DW_HDMI_CEC=m
# end of Display Interface Bridges

CONFIG_DRM_IMX=m
CONFIG_DRM_IMX_PARALLEL_DISPLAY=m
CONFIG_DRM_IMX_TVE=m
# CONFIG_DRM_IMX_LDB is not set
CONFIG_DRM_IMX_HDMI=m
CONFIG_DRM_INGENIC=m
# CONFIG_DRM_INGENIC_IPU is not set
CONFIG_DRM_V3D=m
# CONFIG_DRM_ETNAVIV is not set
CONFIG_DRM_HISI_HIBMC=m
CONFIG_DRM_HISI_KIRIN=m
CONFIG_DRM_LOGICVC=m
CONFIG_DRM_MXS=y
CONFIG_DRM_MXSFB=m
CONFIG_DRM_IMX_LCDIF=m
CONFIG_DRM_MESON=m
CONFIG_DRM_MESON_DW_HDMI=m
# CONFIG_DRM_ARCPGU is not set
# CONFIG_DRM_BOCHS is not set
# CONFIG_DRM_CIRRUS_QEMU is not set
CONFIG_DRM_SIMPLEDRM=m
CONFIG_DRM_PL111=m
# CONFIG_DRM_TVE200 is not set
CONFIG_DRM_XEN=y
CONFIG_DRM_XEN_FRONTEND=m
CONFIG_DRM_LIMA=m
CONFIG_DRM_PANFROST=m
CONFIG_DRM_ASPEED_GFX=m
# CONFIG_DRM_MCDE is not set
CONFIG_DRM_TIDSS=m
CONFIG_DRM_SSD130X=m
# CONFIG_DRM_SSD130X_I2C is not set
CONFIG_DRM_SPRD=m
CONFIG_DRM_LEGACY=y
# CONFIG_DRM_TDFX is not set
CONFIG_DRM_R128=m
CONFIG_DRM_MGA=m
CONFIG_DRM_VIA=m
CONFIG_DRM_SAVAGE=m
CONFIG_DRM_EXPORT_FOR_TESTS=y
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=m
CONFIG_DRM_NOMODESET=y
CONFIG_DRM_LIB_RANDOM=y

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=m
CONFIG_FIRMWARE_EDID=y
CONFIG_FB_DDC=m
CONFIG_FB_CFB_FILLRECT=m
CONFIG_FB_CFB_COPYAREA=m
CONFIG_FB_CFB_IMAGEBLIT=m
CONFIG_FB_CFB_REV_PIXELS_IN_BYTE=y
CONFIG_FB_SYS_FILLRECT=m
CONFIG_FB_SYS_COPYAREA=m
CONFIG_FB_SYS_IMAGEBLIT=m
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=m
CONFIG_FB_DEFERRED_IO=y
CONFIG_FB_SVGALIB=m
CONFIG_FB_BACKLIGHT=m
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_ARMCLCD is not set
CONFIG_FB_CLPS711X=m
CONFIG_FB_IMX=m
CONFIG_FB_CYBER2000=m
CONFIG_FB_CYBER2000_DDC=y
# CONFIG_FB_ARC is not set
CONFIG_FB_UVESA=m
CONFIG_FB_PVR2=m
CONFIG_FB_OPENCORES=m
CONFIG_FB_S1D13XXX=m
# CONFIG_FB_ATMEL is not set
CONFIG_FB_NVIDIA=m
# CONFIG_FB_NVIDIA_I2C is not set
# CONFIG_FB_NVIDIA_DEBUG is not set
# CONFIG_FB_NVIDIA_BACKLIGHT is not set
# CONFIG_FB_RIVA is not set
CONFIG_FB_I740=m
# CONFIG_FB_MATROX is not set
CONFIG_FB_RADEON=m
CONFIG_FB_RADEON_I2C=y
# CONFIG_FB_RADEON_BACKLIGHT is not set
CONFIG_FB_RADEON_DEBUG=y
CONFIG_FB_ATY128=m
# CONFIG_FB_ATY128_BACKLIGHT is not set
# CONFIG_FB_ATY is not set
CONFIG_FB_S3=m
# CONFIG_FB_S3_DDC is not set
CONFIG_FB_SAVAGE=m
CONFIG_FB_SAVAGE_I2C=y
CONFIG_FB_SAVAGE_ACCEL=y
CONFIG_FB_SIS=m
CONFIG_FB_SIS_300=y
# CONFIG_FB_SIS_315 is not set
CONFIG_FB_VIA=m
# CONFIG_FB_VIA_DIRECT_PROCFS is not set
CONFIG_FB_VIA_X_COMPATIBILITY=y
CONFIG_FB_NEOMAGIC=m
CONFIG_FB_KYRO=m
CONFIG_FB_3DFX=m
# CONFIG_FB_3DFX_ACCEL is not set
CONFIG_FB_3DFX_I2C=y
CONFIG_FB_VOODOO1=m
CONFIG_FB_VT8623=m
CONFIG_FB_TRIDENT=m
CONFIG_FB_ARK=m
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
CONFIG_FB_PXA168=m
CONFIG_FB_W100=m
# CONFIG_FB_SH_MOBILE_LCDC is not set
CONFIG_FB_TMIO=m
CONFIG_FB_TMIO_ACCELL=y
# CONFIG_FB_S3C is not set
# CONFIG_FB_IBM_GXT4500 is not set
# CONFIG_FB_GOLDFISH is not set
CONFIG_FB_DA8XX=m
CONFIG_FB_VIRTUAL=m
CONFIG_XEN_FBDEV_FRONTEND=m
CONFIG_FB_METRONOME=m
# CONFIG_FB_MB862XX is not set
CONFIG_FB_BROADSHEET=m
CONFIG_FB_SIMPLE=m
CONFIG_FB_SSD1307=m
CONFIG_FB_SM712=m
CONFIG_FB_OMAP_LCD_H3=y
CONFIG_FB_OMAP2=m
# CONFIG_FB_OMAP2_DEBUG_SUPPORT is not set
CONFIG_FB_OMAP2_NUM_FBS=3
CONFIG_FB_OMAP2_DSS_INIT=y
CONFIG_FB_OMAP2_DSS=m
CONFIG_FB_OMAP2_DSS_DEBUG=y
CONFIG_FB_OMAP2_DSS_DEBUGFS=y
# CONFIG_FB_OMAP2_DSS_COLLECT_IRQ_STATS is not set
# CONFIG_FB_OMAP2_DSS_DPI is not set
CONFIG_FB_OMAP2_DSS_VENC=y
CONFIG_FB_OMAP2_DSS_HDMI_COMMON=y
CONFIG_FB_OMAP4_DSS_HDMI=y
# CONFIG_FB_OMAP5_DSS_HDMI is not set
CONFIG_FB_OMAP2_DSS_SDI=y
# CONFIG_FB_OMAP2_DSS_DSI is not set
CONFIG_FB_OMAP2_DSS_MIN_FCK_PER_PCK=0
CONFIG_FB_OMAP2_DSS_SLEEP_AFTER_VENC_RESET=y

#
# OMAPFB Panel and Encoder Drivers
#
CONFIG_FB_OMAP2_ENCODER_OPA362=m
# CONFIG_FB_OMAP2_ENCODER_TFP410 is not set
CONFIG_FB_OMAP2_ENCODER_TPD12S015=m
# CONFIG_FB_OMAP2_CONNECTOR_DVI is not set
# CONFIG_FB_OMAP2_CONNECTOR_HDMI is not set
CONFIG_FB_OMAP2_CONNECTOR_ANALOG_TV=m
CONFIG_FB_OMAP2_PANEL_DPI=m
# CONFIG_FB_OMAP2_PANEL_SHARP_LS037V7DW01 is not set
# end of OMAPFB Panel and Encoder Drivers

CONFIG_MMP_DISP=m
CONFIG_MMP_DISP_CONTROLLER=y
# CONFIG_MMP_FB is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=y
CONFIG_LCD_PLATFORM=m
CONFIG_BACKLIGHT_CLASS_DEVICE=m
CONFIG_BACKLIGHT_KTD253=m
CONFIG_BACKLIGHT_LM3533=m
# CONFIG_BACKLIGHT_OMAP1 is not set
# CONFIG_BACKLIGHT_PWM is not set
CONFIG_BACKLIGHT_DA903X=m
CONFIG_BACKLIGHT_DA9052=m
CONFIG_BACKLIGHT_MT6370=m
# CONFIG_BACKLIGHT_QCOM_WLED is not set
CONFIG_BACKLIGHT_WM831X=m
# CONFIG_BACKLIGHT_ADP5520 is not set
# CONFIG_BACKLIGHT_ADP8860 is not set
CONFIG_BACKLIGHT_ADP8870=m
# CONFIG_BACKLIGHT_PCF50633 is not set
# CONFIG_BACKLIGHT_AAT2870 is not set
# CONFIG_BACKLIGHT_LM3630A is not set
# CONFIG_BACKLIGHT_LM3639 is not set
# CONFIG_BACKLIGHT_LP855X is not set
# CONFIG_BACKLIGHT_SKY81452 is not set
CONFIG_BACKLIGHT_GPIO=m
CONFIG_BACKLIGHT_LV5207LP=m
# CONFIG_BACKLIGHT_BD6107 is not set
CONFIG_BACKLIGHT_ARCXCNN=m
CONFIG_BACKLIGHT_LED=m
# end of Backlight & LCD device support

CONFIG_VGASTATE=m
CONFIG_VIDEOMODE_HELPERS=y
CONFIG_HDMI=y
# CONFIG_LOGO is not set
# end of Graphics support

# CONFIG_SOUND is not set
CONFIG_USB_OHCI_LITTLE_ENDIAN=y
# CONFIG_USB_SUPPORT is not set
# CONFIG_MMC is not set
CONFIG_MEMSTICK=m
CONFIG_MEMSTICK_DEBUG=y

#
# MemoryStick drivers
#
CONFIG_MEMSTICK_UNSAFE_RESUME=y

#
# MemoryStick Host Controller Drivers
#
CONFIG_MEMSTICK_TIFM_MS=m
CONFIG_MEMSTICK_JMICRON_38X=m
CONFIG_MEMSTICK_R592=m
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_CLASS_FLASH=m
CONFIG_LEDS_CLASS_MULTICOLOR=m
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
CONFIG_LEDS_AN30259A=y
# CONFIG_LEDS_ARIEL is not set
# CONFIG_LEDS_AW2013 is not set
# CONFIG_LEDS_BCM6328 is not set
CONFIG_LEDS_BCM6358=m
CONFIG_LEDS_TURRIS_OMNIA=m
CONFIG_LEDS_LM3530=m
CONFIG_LEDS_LM3532=m
# CONFIG_LEDS_LM3533 is not set
# CONFIG_LEDS_LM3642 is not set
# CONFIG_LEDS_LM3692X is not set
# CONFIG_LEDS_MT6323 is not set
CONFIG_LEDS_S3C24XX=y
# CONFIG_LEDS_COBALT_QUBE is not set
CONFIG_LEDS_COBALT_RAQ=y
# CONFIG_LEDS_GPIO is not set
# CONFIG_LEDS_LP3944 is not set
CONFIG_LEDS_LP3952=m
CONFIG_LEDS_LP50XX=m
CONFIG_LEDS_LP55XX_COMMON=m
CONFIG_LEDS_LP5521=m
CONFIG_LEDS_LP5523=m
CONFIG_LEDS_LP5562=m
# CONFIG_LEDS_LP8501 is not set
CONFIG_LEDS_LP8860=m
CONFIG_LEDS_PCA955X=y
CONFIG_LEDS_PCA955X_GPIO=y
CONFIG_LEDS_PCA963X=y
CONFIG_LEDS_WM831X_STATUS=m
CONFIG_LEDS_WM8350=y
CONFIG_LEDS_DA903X=y
CONFIG_LEDS_DA9052=y
# CONFIG_LEDS_PWM is not set
CONFIG_LEDS_REGULATOR=y
CONFIG_LEDS_BD2802=m
CONFIG_LEDS_LT3593=y
CONFIG_LEDS_ADP5520=y
CONFIG_LEDS_MC13783=m
# CONFIG_LEDS_NS2 is not set
CONFIG_LEDS_NETXBIG=y
CONFIG_LEDS_TCA6507=m
CONFIG_LEDS_TLC591XX=y
# CONFIG_LEDS_LM355x is not set
CONFIG_LEDS_OT200=m
CONFIG_LEDS_IS31FL319X=y
# CONFIG_LEDS_IS31FL32XX is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
# CONFIG_LEDS_BLINKM is not set
# CONFIG_LEDS_SYSCON is not set
CONFIG_LEDS_PM8058=y
# CONFIG_LEDS_MLXREG is not set
# CONFIG_LEDS_USER is not set
CONFIG_LEDS_TI_LMU_COMMON=m
CONFIG_LEDS_LM3697=m
CONFIG_LEDS_TPS6105X=m
CONFIG_LEDS_IP30=m
CONFIG_LEDS_ACER_A500=y
# CONFIG_LEDS_BCM63138 is not set
CONFIG_LEDS_LGM=y

#
# Flash and Torch LED drivers
#
CONFIG_LEDS_AAT1290=m
CONFIG_LEDS_AS3645A=m
CONFIG_LEDS_KTD2692=m
CONFIG_LEDS_LM3601X=m
CONFIG_LEDS_MT6360=m
CONFIG_LEDS_RT4505=m
# CONFIG_LEDS_RT8515 is not set
# CONFIG_LEDS_SGM3140 is not set

#
# RGB LED drivers
#
# CONFIG_LEDS_PWM_MULTICOLOR is not set

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
# CONFIG_LEDS_TRIGGER_TIMER is not set
CONFIG_LEDS_TRIGGER_ONESHOT=m
# CONFIG_LEDS_TRIGGER_HEARTBEAT is not set
# CONFIG_LEDS_TRIGGER_BACKLIGHT is not set
CONFIG_LEDS_TRIGGER_CPU=y
CONFIG_LEDS_TRIGGER_ACTIVITY=y
CONFIG_LEDS_TRIGGER_GPIO=m
# CONFIG_LEDS_TRIGGER_DEFAULT_ON is not set

#
# iptables trigger is under Netfilter config (LED target)
#
# CONFIG_LEDS_TRIGGER_TRANSIENT is not set
CONFIG_LEDS_TRIGGER_CAMERA=m
CONFIG_LEDS_TRIGGER_PANIC=y
# CONFIG_LEDS_TRIGGER_NETDEV is not set
CONFIG_LEDS_TRIGGER_PATTERN=y
# CONFIG_LEDS_TRIGGER_AUDIO is not set

#
# Simple LED drivers
#
CONFIG_ACCESSIBILITY=y

#
# Speakup console speech
#
# end of Speakup console speech

CONFIG_INFINIBAND=y
CONFIG_INFINIBAND_USER_MAD=y
CONFIG_INFINIBAND_USER_ACCESS=m
CONFIG_INFINIBAND_USER_MEM=y
CONFIG_INFINIBAND_ON_DEMAND_PAGING=y
# CONFIG_INFINIBAND_ADDR_TRANS is not set
CONFIG_INFINIBAND_VIRT_DMA=y
CONFIG_INFINIBAND_MTHCA=m
# CONFIG_INFINIBAND_MTHCA_DEBUG is not set
# CONFIG_RDMA_RXE is not set
CONFIG_RDMA_SIW=m
CONFIG_EDAC_SUPPORT=y
# CONFIG_RTC_CLASS is not set
# CONFIG_DMADEVICES is not set

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
CONFIG_SW_SYNC=y
CONFIG_UDMABUF=y
# CONFIG_DMABUF_MOVE_NOTIFY is not set
# CONFIG_DMABUF_DEBUG is not set
CONFIG_DMABUF_SELFTESTS=y
CONFIG_DMABUF_HEAPS=y
CONFIG_DMABUF_SYSFS_STATS=y
# CONFIG_DMABUF_HEAPS_SYSTEM is not set
CONFIG_DMABUF_HEAPS_CMA=y
# end of DMABUF options

CONFIG_AUXDISPLAY=y
CONFIG_CHARLCD=y
CONFIG_LINEDISP=y
CONFIG_HD44780_COMMON=y
CONFIG_HD44780=y
CONFIG_KS0108=m
CONFIG_KS0108_PORT=0x378
CONFIG_KS0108_DELAY=2
CONFIG_IMG_ASCII_LCD=y
# CONFIG_LCD2S is not set
CONFIG_PARPORT_PANEL=m
CONFIG_PANEL_PARPORT=0
CONFIG_PANEL_PROFILE=5
CONFIG_PANEL_CHANGE_MESSAGE=y
CONFIG_PANEL_BOOT_MESSAGE=""
# CONFIG_CHARLCD_BL_OFF is not set
CONFIG_CHARLCD_BL_ON=y
# CONFIG_CHARLCD_BL_FLASH is not set
# CONFIG_PANEL is not set
CONFIG_UIO=y
CONFIG_UIO_CIF=y
CONFIG_UIO_PDRV_GENIRQ=y
CONFIG_UIO_DMEM_GENIRQ=m
CONFIG_UIO_AEC=y
CONFIG_UIO_SERCOS3=m
# CONFIG_UIO_PCI_GENERIC is not set
# CONFIG_UIO_NETX is not set
# CONFIG_UIO_PRUSS is not set
# CONFIG_UIO_MF624 is not set
# CONFIG_VFIO is not set
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO_ANCHOR=y
CONFIG_VIRTIO=m
# CONFIG_VIRTIO_MENU is not set
CONFIG_VDPA=m
CONFIG_VDPA_SIM=m
# CONFIG_VDPA_SIM_NET is not set
CONFIG_VDPA_SIM_BLOCK=m
CONFIG_VDPA_USER=m
# CONFIG_IFCVF is not set
# CONFIG_VP_VDPA is not set
CONFIG_VHOST_IOTLB=m
CONFIG_VHOST_RING=m
CONFIG_VHOST=m
CONFIG_VHOST_MENU=y
CONFIG_VHOST_NET=m
# CONFIG_VHOST_VDPA is not set
CONFIG_VHOST_CROSS_ENDIAN_LEGACY=y

#
# Microsoft Hyper-V guest support
#
# end of Microsoft Hyper-V guest support

#
# Xen driver support
#
CONFIG_XEN_BALLOON=y
CONFIG_XEN_BALLOON_MEMORY_HOTPLUG=y
CONFIG_XEN_SCRUB_PAGES_DEFAULT=y
CONFIG_XEN_DEV_EVTCHN=y
CONFIG_XEN_BACKEND=y
# CONFIG_XENFS is not set
CONFIG_XEN_SYS_HYPERVISOR=y
CONFIG_XEN_XENBUS_FRONTEND=m
CONFIG_XEN_GNTDEV=y
CONFIG_XEN_GNTDEV_DMABUF=y
CONFIG_XEN_GRANT_DEV_ALLOC=y
CONFIG_XEN_GRANT_DMA_ALLOC=y
CONFIG_SWIOTLB_XEN=y
CONFIG_XEN_PCI_STUB=y
CONFIG_XEN_PCIDEV_STUB=y
# CONFIG_XEN_PVCALLS_FRONTEND is not set
CONFIG_XEN_PVCALLS_BACKEND=y
CONFIG_XEN_PRIVCMD=m
CONFIG_XEN_AUTO_XLATE=y
CONFIG_XEN_FRONT_PGDIR_SHBUF=m
# CONFIG_XEN_VIRTIO is not set
# end of Xen driver support

CONFIG_GREYBUS=y
CONFIG_COMEDI=y
# CONFIG_COMEDI_DEBUG is not set
CONFIG_COMEDI_DEFAULT_BUF_SIZE_KB=2048
CONFIG_COMEDI_DEFAULT_BUF_MAXSIZE_KB=20480
CONFIG_COMEDI_MISC_DRIVERS=y
CONFIG_COMEDI_BOND=m
CONFIG_COMEDI_TEST=m
CONFIG_COMEDI_PARPORT=y
# CONFIG_COMEDI_SSV_DNP is not set
# CONFIG_COMEDI_ISA_DRIVERS is not set
CONFIG_COMEDI_PCI_DRIVERS=m
CONFIG_COMEDI_8255_PCI=m
CONFIG_COMEDI_ADDI_WATCHDOG=m
CONFIG_COMEDI_ADDI_APCI_1032=m
# CONFIG_COMEDI_ADDI_APCI_1500 is not set
CONFIG_COMEDI_ADDI_APCI_1516=m
CONFIG_COMEDI_ADDI_APCI_1564=m
CONFIG_COMEDI_ADDI_APCI_16XX=m
CONFIG_COMEDI_ADDI_APCI_2032=m
CONFIG_COMEDI_ADDI_APCI_2200=m
CONFIG_COMEDI_ADDI_APCI_3120=m
CONFIG_COMEDI_ADDI_APCI_3501=m
CONFIG_COMEDI_ADDI_APCI_3XXX=m
CONFIG_COMEDI_ADL_PCI6208=m
CONFIG_COMEDI_ADL_PCI7X3X=m
CONFIG_COMEDI_ADL_PCI8164=m
CONFIG_COMEDI_ADL_PCI9111=m
CONFIG_COMEDI_ADL_PCI9118=m
CONFIG_COMEDI_ADV_PCI1710=m
CONFIG_COMEDI_ADV_PCI1720=m
CONFIG_COMEDI_ADV_PCI1723=m
CONFIG_COMEDI_ADV_PCI1724=m
CONFIG_COMEDI_ADV_PCI1760=m
CONFIG_COMEDI_ADV_PCI_DIO=m
# CONFIG_COMEDI_AMPLC_DIO200_PCI is not set
CONFIG_COMEDI_AMPLC_PC236_PCI=m
CONFIG_COMEDI_AMPLC_PC263_PCI=m
CONFIG_COMEDI_AMPLC_PCI224=m
# CONFIG_COMEDI_AMPLC_PCI230 is not set
CONFIG_COMEDI_CONTEC_PCI_DIO=m
CONFIG_COMEDI_DAS08_PCI=m
CONFIG_COMEDI_DT3000=m
CONFIG_COMEDI_DYNA_PCI10XX=m
CONFIG_COMEDI_GSC_HPDI=m
CONFIG_COMEDI_MF6X4=m
CONFIG_COMEDI_ICP_MULTI=m
# CONFIG_COMEDI_DAQBOARD2000 is not set
CONFIG_COMEDI_JR3_PCI=m
CONFIG_COMEDI_KE_COUNTER=m
CONFIG_COMEDI_CB_PCIDAS64=m
CONFIG_COMEDI_CB_PCIDAS=m
CONFIG_COMEDI_CB_PCIDDA=m
CONFIG_COMEDI_CB_PCIMDAS=m
CONFIG_COMEDI_CB_PCIMDDA=m
CONFIG_COMEDI_ME4000=m
CONFIG_COMEDI_ME_DAQ=m
CONFIG_COMEDI_NI_6527=m
CONFIG_COMEDI_NI_65XX=m
CONFIG_COMEDI_NI_660X=m
# CONFIG_COMEDI_NI_670X is not set
CONFIG_COMEDI_NI_LABPC_PCI=m
# CONFIG_COMEDI_NI_PCIDIO is not set
CONFIG_COMEDI_NI_PCIMIO=m
# CONFIG_COMEDI_RTD520 is not set
CONFIG_COMEDI_S626=m
CONFIG_COMEDI_MITE=m
CONFIG_COMEDI_NI_TIOCMD=m
CONFIG_COMEDI_8254=m
CONFIG_COMEDI_8255=m
# CONFIG_COMEDI_8255_SA is not set
CONFIG_COMEDI_KCOMEDILIB=y
CONFIG_COMEDI_AMPLC_PC236=m
CONFIG_COMEDI_DAS08=m
CONFIG_COMEDI_NI_LABPC=m
CONFIG_COMEDI_NI_TIO=m
CONFIG_COMEDI_NI_ROUTING=m
CONFIG_COMEDI_TESTS=m
# CONFIG_COMEDI_TESTS_EXAMPLE is not set
CONFIG_COMEDI_TESTS_NI_ROUTES=m
CONFIG_STAGING=y
# CONFIG_FB_SM750 is not set
CONFIG_MFD_NVEC=y
CONFIG_SERIO_NVEC_PS2=y
CONFIG_NVEC_POWER=m
CONFIG_NVEC_PAZ00=y
# CONFIG_STAGING_MEDIA is not set
# CONFIG_STAGING_BOARD is not set
CONFIG_MOST_COMPONENTS=m
CONFIG_MOST_NET=m
CONFIG_MOST_DIM2=m
CONFIG_MOST_I2C=m
CONFIG_GREYBUS_BOOTROM=m
# CONFIG_GREYBUS_LIGHT is not set
# CONFIG_GREYBUS_LOG is not set
CONFIG_GREYBUS_LOOPBACK=m
# CONFIG_GREYBUS_POWER is not set
CONFIG_GREYBUS_RAW=y
CONFIG_GREYBUS_VIBRATOR=m
# CONFIG_GREYBUS_BRIDGED_PHY is not set
CONFIG_GREYBUS_ARCHE=m
# CONFIG_BCM_VIDEOCORE is not set
# CONFIG_XIL_AXIS_FIFO is not set
CONFIG_FIELDBUS_DEV=m
# CONFIG_HMS_ANYBUSS_BUS is not set
# CONFIG_VME_BUS is not set
CONFIG_GOLDFISH=y
# CONFIG_GOLDFISH_PIPE is not set
CONFIG_CHROME_PLATFORMS=y
CONFIG_CROS_EC=y
CONFIG_CROS_EC_I2C=m
# CONFIG_CROS_EC_RPMSG is not set
CONFIG_CROS_EC_PROTO=y
# CONFIG_CROS_KBD_LED_BACKLIGHT is not set
CONFIG_CROS_KUNIT=y
CONFIG_MELLANOX_PLATFORM=y
# CONFIG_MLXREG_HOTPLUG is not set
CONFIG_MLXREG_IO=m
CONFIG_MLXREG_LC=m
CONFIG_NVSW_SN2201=m
CONFIG_OLPC_XO175=y
CONFIG_SURFACE_PLATFORMS=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
# CONFIG_COMMON_CLK_WM831X is not set

#
# Clock driver for ARM Reference designs
#
CONFIG_CLK_ICST=y
# CONFIG_CLK_SP810 is not set
# CONFIG_CLK_VEXPRESS_OSC is not set
# end of Clock driver for ARM Reference designs

# CONFIG_CLK_HSDK is not set
# CONFIG_COMMON_CLK_APPLE_NCO is not set
CONFIG_COMMON_CLK_MAX77686=m
CONFIG_COMMON_CLK_MAX9485=y
# CONFIG_COMMON_CLK_RK808 is not set
# CONFIG_COMMON_CLK_HI655X is not set
CONFIG_COMMON_CLK_SCMI=m
CONFIG_COMMON_CLK_SCPI=y
# CONFIG_COMMON_CLK_SI5341 is not set
CONFIG_COMMON_CLK_SI5351=y
CONFIG_COMMON_CLK_SI514=m
# CONFIG_COMMON_CLK_SI544 is not set
CONFIG_COMMON_CLK_SI570=m
# CONFIG_COMMON_CLK_BM1880 is not set
CONFIG_COMMON_CLK_CDCE706=y
CONFIG_COMMON_CLK_TPS68470=y
# CONFIG_COMMON_CLK_CDCE925 is not set
CONFIG_COMMON_CLK_CS2000_CP=m
# CONFIG_COMMON_CLK_EN7523 is not set
CONFIG_COMMON_CLK_FSL_FLEXSPI=y
# CONFIG_COMMON_CLK_FSL_SAI is not set
# CONFIG_COMMON_CLK_GEMINI is not set
# CONFIG_COMMON_CLK_LAN966X is not set
CONFIG_COMMON_CLK_ASPEED=y
CONFIG_COMMON_CLK_S2MPS11=m
# CONFIG_COMMON_CLK_AXI_CLKGEN is not set
CONFIG_CLK_QORIQ=y
CONFIG_CLK_LS1028A_PLLDIG=m
CONFIG_COMMON_CLK_XGENE=y
CONFIG_COMMON_CLK_LOCHNAGAR=m
# CONFIG_COMMON_CLK_PWM is not set
# CONFIG_COMMON_CLK_OXNAS is not set
# CONFIG_COMMON_CLK_RS9_PCIE is not set
CONFIG_COMMON_CLK_VC5=m
CONFIG_COMMON_CLK_VC7=y
CONFIG_COMMON_CLK_MMP2_AUDIO=m
CONFIG_COMMON_CLK_BD718XX=y
# CONFIG_COMMON_CLK_FIXED_MMIO is not set
CONFIG_CLK_ACTIONS=y
CONFIG_CLK_OWL_S500=y
# CONFIG_CLK_OWL_S700 is not set
CONFIG_CLK_OWL_S900=y
CONFIG_CLK_BAIKAL_T1=y
# CONFIG_CLK_BT1_CCU_PLL is not set
CONFIG_CLK_BT1_CCU_DIV=y
CONFIG_CLK_BT1_CCU_RST=y
CONFIG_CLK_BCM2711_DVP=y
# CONFIG_CLK_BCM2835 is not set
CONFIG_CLK_BCM_63XX=y
CONFIG_CLK_BCM_63XX_GATE=y
# CONFIG_CLK_BCM_KONA is not set
CONFIG_COMMON_CLK_IPROC=y
CONFIG_CLK_BCM_CYGNUS=y
CONFIG_CLK_BCM_HR2=y
# CONFIG_CLK_BCM_NSP is not set
CONFIG_CLK_BCM_NS2=y
CONFIG_CLK_BCM_SR=y
CONFIG_CLK_RASPBERRYPI=m
CONFIG_COMMON_CLK_HI3516CV300=m
# CONFIG_COMMON_CLK_HI3519 is not set
# CONFIG_COMMON_CLK_HI3559A is not set
CONFIG_COMMON_CLK_HI3660=y
CONFIG_COMMON_CLK_HI3670=y
CONFIG_COMMON_CLK_HI3798CV200=m
CONFIG_COMMON_CLK_HI6220=y
CONFIG_RESET_HISI=y
CONFIG_COMMON_CLK_BOSTON=y
CONFIG_MXC_CLK=y
CONFIG_CLK_IMX8MM=y
CONFIG_CLK_IMX8MN=y
# CONFIG_CLK_IMX8MP is not set
CONFIG_CLK_IMX8MQ=m
CONFIG_CLK_IMX8ULP=y
CONFIG_CLK_IMX93=y

#
# Ingenic SoCs drivers
#
CONFIG_INGENIC_CGU_COMMON=y
# CONFIG_INGENIC_CGU_JZ4740 is not set
# CONFIG_INGENIC_CGU_JZ4725B is not set
# CONFIG_INGENIC_CGU_JZ4760 is not set
CONFIG_INGENIC_CGU_JZ4770=y
CONFIG_INGENIC_CGU_JZ4780=y
CONFIG_INGENIC_CGU_X1000=y
# CONFIG_INGENIC_CGU_X1830 is not set
CONFIG_INGENIC_TCU_CLK=y
# end of Ingenic SoCs drivers

# CONFIG_COMMON_CLK_KEYSTONE is not set
CONFIG_TI_SYSCON_CLK=y

#
# Clock driver for MediaTek SoC
#
CONFIG_COMMON_CLK_MEDIATEK=y
# CONFIG_COMMON_CLK_MT2701 is not set
CONFIG_COMMON_CLK_MT2712=y
# CONFIG_COMMON_CLK_MT2712_BDPSYS is not set
CONFIG_COMMON_CLK_MT2712_IMGSYS=y
CONFIG_COMMON_CLK_MT2712_JPGDECSYS=y
# CONFIG_COMMON_CLK_MT2712_MFGCFG is not set
# CONFIG_COMMON_CLK_MT2712_MMSYS is not set
# CONFIG_COMMON_CLK_MT2712_VDECSYS is not set
CONFIG_COMMON_CLK_MT2712_VENCSYS=y
CONFIG_COMMON_CLK_MT6765=y
# CONFIG_COMMON_CLK_MT6765_AUDIOSYS is not set
# CONFIG_COMMON_CLK_MT6765_CAMSYS is not set
CONFIG_COMMON_CLK_MT6765_GCESYS=y
CONFIG_COMMON_CLK_MT6765_MMSYS=y
# CONFIG_COMMON_CLK_MT6765_IMGSYS is not set
CONFIG_COMMON_CLK_MT6765_VCODECSYS=y
CONFIG_COMMON_CLK_MT6765_MFGSYS=y
# CONFIG_COMMON_CLK_MT6765_MIPI0ASYS is not set
# CONFIG_COMMON_CLK_MT6765_MIPI0BSYS is not set
# CONFIG_COMMON_CLK_MT6765_MIPI1ASYS is not set
CONFIG_COMMON_CLK_MT6765_MIPI1BSYS=y
CONFIG_COMMON_CLK_MT6765_MIPI2ASYS=y
CONFIG_COMMON_CLK_MT6765_MIPI2BSYS=y
CONFIG_COMMON_CLK_MT6779=y
CONFIG_COMMON_CLK_MT6779_MMSYS=m
# CONFIG_COMMON_CLK_MT6779_IMGSYS is not set
# CONFIG_COMMON_CLK_MT6779_IPESYS is not set
CONFIG_COMMON_CLK_MT6779_CAMSYS=y
# CONFIG_COMMON_CLK_MT6779_VDECSYS is not set
CONFIG_COMMON_CLK_MT6779_VENCSYS=m
# CONFIG_COMMON_CLK_MT6779_MFGCFG is not set
CONFIG_COMMON_CLK_MT6779_AUDSYS=y
CONFIG_COMMON_CLK_MT6795=y
CONFIG_COMMON_CLK_MT6795_MFGCFG=y
CONFIG_COMMON_CLK_MT6795_MMSYS=y
# CONFIG_COMMON_CLK_MT6795_VDECSYS is not set
# CONFIG_COMMON_CLK_MT6795_VENCSYS is not set
CONFIG_COMMON_CLK_MT6797=y
# CONFIG_COMMON_CLK_MT6797_MMSYS is not set
# CONFIG_COMMON_CLK_MT6797_IMGSYS is not set
CONFIG_COMMON_CLK_MT6797_VDECSYS=y
CONFIG_COMMON_CLK_MT6797_VENCSYS=y
CONFIG_COMMON_CLK_MT7622=y
CONFIG_COMMON_CLK_MT7622_ETHSYS=y
# CONFIG_COMMON_CLK_MT7622_HIFSYS is not set
# CONFIG_COMMON_CLK_MT7622_AUDSYS is not set
# CONFIG_COMMON_CLK_MT7629 is not set
CONFIG_COMMON_CLK_MT7986=y
# CONFIG_COMMON_CLK_MT7986_ETHSYS is not set
# CONFIG_COMMON_CLK_MT8135 is not set
# CONFIG_COMMON_CLK_MT8167 is not set
# CONFIG_COMMON_CLK_MT8173 is not set
CONFIG_COMMON_CLK_MT8183=y
# CONFIG_COMMON_CLK_MT8183_AUDIOSYS is not set
# CONFIG_COMMON_CLK_MT8183_CAMSYS is not set
# CONFIG_COMMON_CLK_MT8183_IMGSYS is not set
# CONFIG_COMMON_CLK_MT8183_IPU_CORE0 is not set
# CONFIG_COMMON_CLK_MT8183_IPU_CORE1 is not set
CONFIG_COMMON_CLK_MT8183_IPU_ADL=y
CONFIG_COMMON_CLK_MT8183_IPU_CONN=y
CONFIG_COMMON_CLK_MT8183_MFGCFG=y
CONFIG_COMMON_CLK_MT8183_MMSYS=y
# CONFIG_COMMON_CLK_MT8183_VDECSYS is not set
CONFIG_COMMON_CLK_MT8183_VENCSYS=y
CONFIG_COMMON_CLK_MT8186=y
CONFIG_COMMON_CLK_MT8192=y
CONFIG_COMMON_CLK_MT8192_AUDSYS=y
CONFIG_COMMON_CLK_MT8192_CAMSYS=y
CONFIG_COMMON_CLK_MT8192_IMGSYS=y
CONFIG_COMMON_CLK_MT8192_IMP_IIC_WRAP=y
# CONFIG_COMMON_CLK_MT8192_IPESYS is not set
# CONFIG_COMMON_CLK_MT8192_MDPSYS is not set
# CONFIG_COMMON_CLK_MT8192_MFGCFG is not set
# CONFIG_COMMON_CLK_MT8192_MMSYS is not set
# CONFIG_COMMON_CLK_MT8192_MSDC is not set
# CONFIG_COMMON_CLK_MT8192_SCP_ADSP is not set
CONFIG_COMMON_CLK_MT8192_VDECSYS=y
# CONFIG_COMMON_CLK_MT8192_VENCSYS is not set
# CONFIG_COMMON_CLK_MT8195 is not set
# CONFIG_COMMON_CLK_MT8365 is not set
CONFIG_COMMON_CLK_MT8516=y
CONFIG_COMMON_CLK_MT8516_AUDSYS=y
# end of Clock driver for MediaTek SoC

#
# Clock support for Amlogic platforms
#
CONFIG_COMMON_CLK_MESON_REGMAP=y
CONFIG_COMMON_CLK_MESON_DUALDIV=m
CONFIG_COMMON_CLK_MESON_MPLL=m
CONFIG_COMMON_CLK_MESON_PHASE=y
CONFIG_COMMON_CLK_MESON_PLL=m
CONFIG_COMMON_CLK_MESON_SCLK_DIV=y
CONFIG_COMMON_CLK_MESON_AO_CLKC=m
CONFIG_COMMON_CLK_MESON_EE_CLKC=m
# CONFIG_COMMON_CLK_GXBB is not set
CONFIG_COMMON_CLK_AXG=m
CONFIG_COMMON_CLK_AXG_AUDIO=y
# CONFIG_COMMON_CLK_G12A is not set
# end of Clock support for Amlogic platforms

CONFIG_MSTAR_MSC313_MPLL=y
# CONFIG_MCHP_CLK_MPFS is not set
CONFIG_ARMADA_AP_CP_HELPER=y
CONFIG_ARMADA_37XX_CLK=y
CONFIG_ARMADA_AP806_SYSCON=y
CONFIG_ARMADA_AP_CPU_CLK=y
CONFIG_ARMADA_CP110_SYSCON=y
# CONFIG_COMMON_CLK_PISTACHIO is not set
CONFIG_QCOM_GDSC=y
CONFIG_QCOM_RPMCC=y
CONFIG_COMMON_CLK_QCOM=y
CONFIG_QCOM_A53PLL=m
# CONFIG_QCOM_A7PLL is not set
CONFIG_QCOM_CLK_APCS_MSM8916=y
CONFIG_QCOM_CLK_APCC_MSM8996=y
# CONFIG_QCOM_CLK_APCS_SDX55 is not set
CONFIG_QCOM_CLK_RPM=m
# CONFIG_QCOM_CLK_SMD_RPM is not set
CONFIG_APQ_GCC_8084=y
CONFIG_APQ_MMCC_8084=y
CONFIG_IPQ_APSS_PLL=y
CONFIG_IPQ_APSS_6018=y
# CONFIG_IPQ_GCC_4019 is not set
# CONFIG_IPQ_GCC_6018 is not set
CONFIG_IPQ_GCC_806X=y
# CONFIG_IPQ_LCC_806X is not set
CONFIG_IPQ_GCC_8074=m
CONFIG_MSM_GCC_8660=m
# CONFIG_MSM_GCC_8909 is not set
# CONFIG_MSM_GCC_8916 is not set
CONFIG_MSM_GCC_8939=y
CONFIG_MSM_GCC_8960=m
# CONFIG_MSM_LCC_8960 is not set
CONFIG_MDM_GCC_9607=m
CONFIG_MDM_GCC_9615=y
CONFIG_MDM_LCC_9615=y
# CONFIG_MSM_MMCC_8960 is not set
# CONFIG_MSM_GCC_8953 is not set
# CONFIG_MSM_GCC_8974 is not set
# CONFIG_MSM_MMCC_8974 is not set
CONFIG_MSM_GCC_8976=m
CONFIG_MSM_MMCC_8994=y
CONFIG_MSM_GCC_8994=y
CONFIG_MSM_GCC_8996=y
# CONFIG_MSM_MMCC_8996 is not set
CONFIG_MSM_GCC_8998=y
CONFIG_MSM_GPUCC_8998=m
CONFIG_MSM_MMCC_8998=y
CONFIG_QCM_GCC_2290=y
CONFIG_QCM_DISPCC_2290=y
CONFIG_QCS_GCC_404=y
CONFIG_SC_CAMCC_7180=m
CONFIG_SC_CAMCC_7280=m
CONFIG_SC_DISPCC_7180=y
CONFIG_SC_DISPCC_7280=m
CONFIG_SC_GCC_7180=y
CONFIG_SC_GCC_7280=m
CONFIG_SC_GCC_8180X=y
CONFIG_SC_GCC_8280XP=y
# CONFIG_SC_GPUCC_7180 is not set
CONFIG_SC_GPUCC_7280=m
# CONFIG_SC_GPUCC_8280XP is not set
# CONFIG_SC_LPASSCC_7280 is not set
# CONFIG_SC_LPASS_CORECC_7180 is not set
# CONFIG_SC_LPASS_CORECC_7280 is not set
CONFIG_SC_MSS_7180=y
CONFIG_SC_VIDEOCC_7180=y
CONFIG_SC_VIDEOCC_7280=m
# CONFIG_SDM_CAMCC_845 is not set
CONFIG_SDM_GCC_660=y
CONFIG_SDM_MMCC_660=y
CONFIG_SDM_GPUCC_660=y
# CONFIG_QCS_TURING_404 is not set
CONFIG_QCS_Q6SSTOP_404=m
CONFIG_SDM_GCC_845=y
CONFIG_SDM_GPUCC_845=m
CONFIG_SDM_VIDEOCC_845=y
# CONFIG_SDM_DISPCC_845 is not set
# CONFIG_SDM_LPASSCC_845 is not set
# CONFIG_SDX_GCC_55 is not set
CONFIG_SDX_GCC_65=m
CONFIG_SM_CAMCC_8250=m
# CONFIG_SM_CAMCC_8450 is not set
# CONFIG_SM_DISPCC_6115 is not set
CONFIG_SM_DISPCC_8250=y
CONFIG_SM_DISPCC_6350=m
CONFIG_SM_GCC_6115=m
# CONFIG_SM_GCC_6125 is not set
CONFIG_SM_GCC_6350=y
CONFIG_SM_GCC_6375=y
CONFIG_SM_GCC_8150=y
CONFIG_SM_GCC_8250=m
CONFIG_SM_GCC_8350=m
# CONFIG_SM_GCC_8450 is not set
CONFIG_SM_GPUCC_6350=m
CONFIG_SM_GPUCC_8150=y
CONFIG_SM_GPUCC_8250=m
CONFIG_SM_GPUCC_8350=m
# CONFIG_SM_VIDEOCC_8150 is not set
# CONFIG_SM_VIDEOCC_8250 is not set
CONFIG_SPMI_PMIC_CLKDIV=m
CONFIG_QCOM_HFPLL=y
CONFIG_KPSS_XCC=y
CONFIG_CLK_GFM_LPASS_SM8250=y
# CONFIG_CLK_MT7621 is not set
# CONFIG_CLK_RENESAS is not set
CONFIG_COMMON_CLK_SAMSUNG=y
CONFIG_S3C64XX_COMMON_CLK=y
CONFIG_S5PV210_COMMON_CLK=y
CONFIG_EXYNOS_3250_COMMON_CLK=y
# CONFIG_EXYNOS_4_COMMON_CLK is not set
# CONFIG_EXYNOS_5250_COMMON_CLK is not set
# CONFIG_EXYNOS_5260_COMMON_CLK is not set
CONFIG_EXYNOS_5410_COMMON_CLK=y
CONFIG_EXYNOS_5420_COMMON_CLK=y
CONFIG_EXYNOS_ARM64_COMMON_CLK=y
# CONFIG_EXYNOS_AUDSS_CLK_CON is not set
# CONFIG_EXYNOS_CLKOUT is not set
# CONFIG_S3C2410_COMMON_CLK is not set
CONFIG_S3C2412_COMMON_CLK=y
# CONFIG_S3C2443_COMMON_CLK is not set
CONFIG_TESLA_FSD_COMMON_CLK=y
# CONFIG_CLK_SIFIVE is not set
CONFIG_CLK_INTEL_SOCFPGA=y
CONFIG_CLK_INTEL_SOCFPGA32=y
CONFIG_CLK_INTEL_SOCFPGA64=y
CONFIG_SPRD_COMMON_CLK=m
# CONFIG_SPRD_SC9860_CLK is not set
CONFIG_SPRD_SC9863A_CLK=m
CONFIG_SPRD_UMS512_CLK=m
CONFIG_CLK_STARFIVE_JH7100=y
CONFIG_CLK_STARFIVE_JH7100_AUDIO=y
# CONFIG_CLK_SUNXI is not set
CONFIG_SUNXI_CCU=m
# CONFIG_SUNIV_F1C100S_CCU is not set
CONFIG_SUN20I_D1_CCU=m
CONFIG_SUN20I_D1_R_CCU=m
CONFIG_SUN50I_A64_CCU=m
CONFIG_SUN50I_A100_CCU=m
CONFIG_SUN50I_A100_R_CCU=m
CONFIG_SUN50I_H6_CCU=m
# CONFIG_SUN50I_H616_CCU is not set
CONFIG_SUN50I_H6_R_CCU=m
CONFIG_SUN4I_A10_CCU=m
CONFIG_SUN6I_A31_CCU=m
CONFIG_SUN6I_RTC_CCU=m
CONFIG_SUN8I_A23_CCU=m
# CONFIG_SUN8I_A33_CCU is not set
# CONFIG_SUN8I_A83T_CCU is not set
CONFIG_SUN8I_H3_CCU=m
CONFIG_SUN8I_V3S_CCU=m
CONFIG_SUN8I_DE2_CCU=m
CONFIG_SUN8I_R40_CCU=m
CONFIG_SUN9I_A80_CCU=m
CONFIG_SUN8I_R_CCU=m
CONFIG_TEGRA124_CLK_EMC=y
CONFIG_COMMON_CLK_TI_ADPLL=y
# CONFIG_CLK_UNIPHIER is not set
# CONFIG_COMMON_CLK_VISCONTI is not set
# CONFIG_CLK_LGM_CGU is not set
# CONFIG_XILINX_VCU is not set
# CONFIG_COMMON_CLK_XLNX_CLKWZRD is not set
# CONFIG_COMMON_CLK_ZYNQMP is not set
CONFIG_CLK_KUNIT_TEST=y
CONFIG_CLK_GATE_KUNIT_TEST=y
CONFIG_HWSPINLOCK=y
CONFIG_HWSPINLOCK_OMAP=m
CONFIG_HWSPINLOCK_QCOM=y
# CONFIG_HWSPINLOCK_SPRD is not set
CONFIG_HWSPINLOCK_STM32=y
CONFIG_HWSPINLOCK_SUN6I=m
# CONFIG_HSEM_U8500 is not set

#
# Clock Source drivers
#
CONFIG_TIMER_OF=y
CONFIG_TIMER_PROBE=y
CONFIG_CLKSRC_MMIO=y
# CONFIG_BCM2835_TIMER is not set
CONFIG_BCM_KONA_TIMER=y
# CONFIG_DAVINCI_TIMER is not set
CONFIG_DIGICOLOR_TIMER=y
# CONFIG_OMAP_DM_TIMER is not set
CONFIG_DW_APB_TIMER=y
CONFIG_DW_APB_TIMER_OF=y
CONFIG_FTTMR010_TIMER=y
CONFIG_IXP4XX_TIMER=y
CONFIG_ROCKCHIP_TIMER=y
CONFIG_MESON6_TIMER=y
CONFIG_OWL_TIMER=y
# CONFIG_RDA_TIMER is not set
# CONFIG_SUN4I_TIMER is not set
CONFIG_SUN5I_HSTIMER=y
CONFIG_TEGRA_TIMER=y
CONFIG_VT8500_TIMER=y
CONFIG_NPCM7XX_TIMER=y
# CONFIG_CADENCE_TTC_TIMER is not set
# CONFIG_ASM9260_TIMER is not set
CONFIG_CLKSRC_DBX500_PRCMU=y
# CONFIG_CLPS711X_TIMER is not set
CONFIG_MXS_TIMER=y
CONFIG_NSPIRE_TIMER=y
CONFIG_KEYSTONE_TIMER=y
# CONFIG_INTEGRATOR_AP_TIMER is not set
# CONFIG_CLKSRC_PISTACHIO is not set
CONFIG_CLKSRC_TI_32K=y
CONFIG_CLKSRC_STM32_LP=y
CONFIG_CLKSRC_MPS2=y
CONFIG_ARC_TIMERS=y
# CONFIG_ARC_TIMERS_64BIT is not set
CONFIG_ARM_ARCH_TIMER=y
CONFIG_ARM_ARCH_TIMER_EVTSTREAM=y
CONFIG_ARM_ARCH_TIMER_OOL_WORKAROUND=y
# CONFIG_FSL_ERRATUM_A008585 is not set
CONFIG_HISILICON_ERRATUM_161010101=y
# CONFIG_ARM64_ERRATUM_858921 is not set
# CONFIG_ARM_TIMER_SP804 is not set
CONFIG_ARMV7M_SYSTICK=y
# CONFIG_ATMEL_PIT is not set
CONFIG_ATMEL_ST=y
CONFIG_CLKSRC_EXYNOS_MCT=y
CONFIG_CLKSRC_SAMSUNG_PWM=y
CONFIG_FSL_FTM_TIMER=y
CONFIG_OXNAS_RPS_TIMER=y
# CONFIG_MTK_TIMER is not set
CONFIG_SPRD_TIMER=y
CONFIG_CLKSRC_JCORE_PIT=y
# CONFIG_SH_TIMER_CMT is not set
# CONFIG_SH_TIMER_MTU2 is not set
CONFIG_RENESAS_OSTM=y
CONFIG_SH_TIMER_TMU=y
CONFIG_EM_TIMER_STI=y
CONFIG_CLKSRC_VERSATILE=y
CONFIG_CLKSRC_PXA=y
# CONFIG_CLKSRC_IMX_GPT is not set
CONFIG_CLKSRC_IMX_TPM=y
CONFIG_TIMER_IMX_SYS_CTR=y
CONFIG_CLKSRC_ST_LPC=y
CONFIG_GXP_TIMER=y
CONFIG_MSC313E_TIMER=y
CONFIG_INGENIC_TIMER=y
# CONFIG_INGENIC_SYSOST is not set
# CONFIG_INGENIC_OST is not set
CONFIG_MICROCHIP_PIT64B=y
# end of Clock Source drivers

# CONFIG_MAILBOX is not set
CONFIG_IOMMU_IOVA=y
CONFIG_IOASID=y
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
CONFIG_IOMMU_IO_PGTABLE=y
CONFIG_IOMMU_IO_PGTABLE_LPAE=y
# CONFIG_IOMMU_IO_PGTABLE_LPAE_SELFTEST is not set
CONFIG_IOMMU_IO_PGTABLE_ARMV7S=y
# CONFIG_IOMMU_IO_PGTABLE_ARMV7S_SELFTEST is not set
# CONFIG_IOMMU_IO_PGTABLE_DART is not set
# end of Generic IOMMU Pagetable Support

CONFIG_IOMMU_DEBUGFS=y
# CONFIG_IOMMU_DEFAULT_DMA_STRICT is not set
CONFIG_IOMMU_DEFAULT_DMA_LAZY=y
# CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
CONFIG_OF_IOMMU=y
CONFIG_IOMMU_DMA=y
CONFIG_IOMMU_SVA=y
# CONFIG_OMAP_IOMMU is not set
# CONFIG_ROCKCHIP_IOMMU is not set
CONFIG_SUN50I_IOMMU=y
CONFIG_TEGRA_IOMMU_SMMU=y
CONFIG_IPMMU_VMSA=y
# CONFIG_APPLE_DART is not set
# CONFIG_ARM_SMMU is not set
CONFIG_ARM_SMMU_V3=m
CONFIG_ARM_SMMU_V3_SVA=y
CONFIG_S390_CCW_IOMMU=y
# CONFIG_S390_AP_IOMMU is not set
CONFIG_MTK_IOMMU=m
CONFIG_QCOM_IOMMU=y
CONFIG_VIRTIO_IOMMU=m
CONFIG_SPRD_IOMMU=y

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
CONFIG_RPMSG=m
# CONFIG_RPMSG_CHAR is not set
CONFIG_RPMSG_CTRL=m
CONFIG_RPMSG_NS=m
CONFIG_RPMSG_VIRTIO=m
# end of Rpmsg drivers

CONFIG_SOUNDWIRE=y

#
# SoundWire Devices
#

#
# SOC (System On Chip) specific Drivers
#
CONFIG_OWL_PM_DOMAINS_HELPER=y
CONFIG_OWL_PM_DOMAINS=y

#
# Amlogic SoC drivers
#
CONFIG_MESON_CANVAS=y
CONFIG_MESON_CLK_MEASURE=y
CONFIG_MESON_GX_SOCINFO=y
# CONFIG_MESON_GX_PM_DOMAINS is not set
# CONFIG_MESON_EE_PM_DOMAINS is not set
CONFIG_MESON_MX_SOCINFO=y
# end of Amlogic SoC drivers

#
# Apple SoC drivers
#
CONFIG_APPLE_PMGR_PWRSTATE=y
CONFIG_APPLE_SART=m
# end of Apple SoC drivers

#
# ASPEED SoC drivers
#
CONFIG_ASPEED_LPC_CTRL=y
CONFIG_ASPEED_LPC_SNOOP=m
# CONFIG_ASPEED_UART_ROUTING is not set
CONFIG_ASPEED_P2A_CTRL=m
CONFIG_ASPEED_SOCINFO=y
# end of ASPEED SoC drivers

CONFIG_AT91_SOC_ID=y
# CONFIG_AT91_SOC_SFR is not set

#
# Broadcom SoC drivers
#
CONFIG_BCM2835_POWER=y
CONFIG_SOC_BCM63XX=y
CONFIG_SOC_BRCMSTB=y
# CONFIG_BCM63XX_POWER is not set
CONFIG_BCM_PMB=y
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
CONFIG_QUICC_ENGINE=y
# CONFIG_FSL_MC_DPIO is not set
CONFIG_DPAA2_CONSOLE=m
# end of NXP/Freescale QorIQ SoC drivers

#
# fujitsu SoC drivers
#
# end of fujitsu SoC drivers

#
# i.MX SoC drivers
#
CONFIG_IMX_GPCV2_PM_DOMAINS=y
CONFIG_SOC_IMX8M=y
CONFIG_SOC_IMX9=m
# end of i.MX SoC drivers

#
# IXP4xx SoC drivers
#
CONFIG_IXP4XX_QMGR=y
# CONFIG_IXP4XX_NPE is not set
# end of IXP4xx SoC drivers

#
# Enable LiteX SoC Builder specific drivers
#
CONFIG_LITEX=y
CONFIG_LITEX_SOC_CONTROLLER=y
# end of Enable LiteX SoC Builder specific drivers

#
# MediaTek SoC drivers
#
# CONFIG_MTK_CMDQ is not set
CONFIG_MTK_DEVAPC=m
CONFIG_MTK_INFRACFG=y
# CONFIG_MTK_PMIC_WRAP is not set
# CONFIG_MTK_SCPSYS is not set
# CONFIG_MTK_SCPSYS_PM_DOMAINS is not set
CONFIG_MTK_MMSYS=y
CONFIG_MTK_SVS=m
# end of MediaTek SoC drivers

#
# Qualcomm SoC drivers
#
CONFIG_QCOM_COMMAND_DB=m
# CONFIG_QCOM_CPR is not set
# CONFIG_QCOM_GENI_SE is not set
CONFIG_QCOM_GSBI=y
CONFIG_QCOM_LLCC=m
CONFIG_QCOM_KRYO_L2_ACCESSORS=y
CONFIG_QCOM_MDT_LOADER=m
# CONFIG_QCOM_OCMEM is not set
# CONFIG_QCOM_RMTFS_MEM is not set
# CONFIG_QCOM_RPMH is not set
CONFIG_QCOM_RPMPD=m
CONFIG_QCOM_SMEM=m
CONFIG_QCOM_SMD_RPM=m
CONFIG_QCOM_SMEM_STATE=y
CONFIG_QCOM_SMSM=m
# CONFIG_QCOM_SOCINFO is not set
CONFIG_QCOM_SPM=m
# CONFIG_QCOM_STATS is not set
# CONFIG_QCOM_WCNSS_CTRL is not set
# CONFIG_QCOM_APR is not set
CONFIG_QCOM_ICC_BWMON=y
# end of Qualcomm SoC drivers

# CONFIG_SOC_RENESAS is not set
# CONFIG_ROCKCHIP_GRF is not set
CONFIG_ROCKCHIP_IODOMAIN=y
CONFIG_ROCKCHIP_PM_DOMAINS=y
CONFIG_SOC_SAMSUNG=y
# CONFIG_EXYNOS_ASV_ARM is not set
CONFIG_EXYNOS_CHIPID=y
CONFIG_EXYNOS_USI=y
CONFIG_EXYNOS_PMU=y
CONFIG_EXYNOS_PMU_ARM_DRIVERS=y
CONFIG_EXYNOS_PM_DOMAINS=y
CONFIG_EXYNOS_REGULATOR_COUPLER=y
CONFIG_ARCH_TEGRA_132_SOC=y
# CONFIG_ARCH_TEGRA_210_SOC is not set
# CONFIG_ARCH_TEGRA_186_SOC is not set
# CONFIG_ARCH_TEGRA_194_SOC is not set
# CONFIG_ARCH_TEGRA_234_SOC is not set
CONFIG_SOC_TEGRA_FUSE=y
CONFIG_SOC_TEGRA_FLOWCTRL=y
CONFIG_SOC_TEGRA_PMC=y
# CONFIG_SOC_TEGRA20_VOLTAGE_COUPLER is not set
CONFIG_SOC_TEGRA30_VOLTAGE_COUPLER=y
# CONFIG_SOC_TI is not set
CONFIG_UX500_SOC_ID=y

#
# Xilinx SoC drivers
#
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=y
CONFIG_DEVFREQ_GOV_PERFORMANCE=m
# CONFIG_DEVFREQ_GOV_POWERSAVE is not set
CONFIG_DEVFREQ_GOV_USERSPACE=m
CONFIG_DEVFREQ_GOV_PASSIVE=y

#
# DEVFREQ Drivers
#
# CONFIG_ARM_EXYNOS_BUS_DEVFREQ is not set
# CONFIG_ARM_IMX_BUS_DEVFREQ is not set
CONFIG_ARM_IMX8M_DDRC_DEVFREQ=m
CONFIG_ARM_TEGRA_DEVFREQ=m
CONFIG_ARM_MEDIATEK_CCI_DEVFREQ=y
# CONFIG_ARM_RK3399_DMC_DEVFREQ is not set
# CONFIG_ARM_SUN8I_A33_MBUS_DEVFREQ is not set
# CONFIG_PM_DEVFREQ_EVENT is not set
CONFIG_EXTCON=m

#
# Extcon Device Drivers
#
CONFIG_EXTCON_GPIO=m
CONFIG_EXTCON_MAX3355=m
CONFIG_EXTCON_MAX77843=m
CONFIG_EXTCON_PTN5150=m
# CONFIG_EXTCON_QCOM_SPMI_MISC is not set
# CONFIG_EXTCON_RT8973A is not set
CONFIG_EXTCON_SM5502=m
CONFIG_EXTCON_USB_GPIO=m
CONFIG_EXTCON_USBC_CROS_EC=m
CONFIG_MEMORY=y
CONFIG_DDR=y
CONFIG_ARM_PL172_MPMC=m
# CONFIG_ATMEL_SDRAMC is not set
# CONFIG_ATMEL_EBI is not set
CONFIG_BRCMSTB_DPFE=y
# CONFIG_BRCMSTB_MEMC is not set
CONFIG_BT1_L2_CTL=y
CONFIG_TI_AEMIF=y
# CONFIG_TI_EMIF is not set
CONFIG_OMAP_GPMC=m
# CONFIG_OMAP_GPMC_DEBUG is not set
CONFIG_MVEBU_DEVBUS=y
CONFIG_FSL_CORENET_CF=m
# CONFIG_FSL_IFC is not set
# CONFIG_JZ4780_NEMC is not set
CONFIG_MTK_SMI=y
CONFIG_DA8XX_DDRCTL=y
# CONFIG_PL353_SMC is not set
# CONFIG_RENESAS_RPCIF is not set
CONFIG_STM32_FMC2_EBI=m
CONFIG_SAMSUNG_MC=y
# CONFIG_EXYNOS_SROM is not set
CONFIG_TEGRA_MC=y
CONFIG_TEGRA20_EMC=y
CONFIG_TEGRA30_EMC=m
CONFIG_TEGRA124_EMC=y
CONFIG_TEGRA210_EMC_TABLE=y
CONFIG_TEGRA210_EMC=m
# CONFIG_IIO is not set
# CONFIG_NTB is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_DEBUG is not set
# CONFIG_PWM_ATMEL is not set
# CONFIG_PWM_ATMEL_TCB is not set
# CONFIG_PWM_BCM_IPROC is not set
# CONFIG_PWM_BCM_KONA is not set
# CONFIG_PWM_BCM2835 is not set
# CONFIG_PWM_BERLIN is not set
# CONFIG_PWM_BRCMSTB is not set
# CONFIG_PWM_CLK is not set
# CONFIG_PWM_CLPS711X is not set
# CONFIG_PWM_CROS_EC is not set
# CONFIG_PWM_DWC is not set
# CONFIG_PWM_EP93XX is not set
# CONFIG_PWM_FSL_FTM is not set
# CONFIG_PWM_HIBVT is not set
# CONFIG_PWM_IMG is not set
# CONFIG_PWM_IMX1 is not set
# CONFIG_PWM_IMX27 is not set
# CONFIG_PWM_IMX_TPM is not set
# CONFIG_PWM_INTEL_LGM is not set
# CONFIG_PWM_IQS620A is not set
# CONFIG_PWM_JZ4740 is not set
# CONFIG_PWM_KEEMBAY is not set
# CONFIG_PWM_LP3943 is not set
# CONFIG_PWM_LPC18XX_SCT is not set
# CONFIG_PWM_LPC32XX is not set
# CONFIG_PWM_LPSS_PCI is not set
# CONFIG_PWM_LPSS_PLATFORM is not set
# CONFIG_PWM_MESON is not set
# CONFIG_PWM_MTK_DISP is not set
# CONFIG_PWM_MEDIATEK is not set
# CONFIG_PWM_MXS is not set
# CONFIG_PWM_NTXEC is not set
# CONFIG_PWM_OMAP_DMTIMER is not set
# CONFIG_PWM_PCA9685 is not set
# CONFIG_PWM_PXA is not set
# CONFIG_PWM_RASPBERRYPI_POE is not set
# CONFIG_PWM_RCAR is not set
# CONFIG_PWM_RENESAS_TPU is not set
# CONFIG_PWM_ROCKCHIP is not set
# CONFIG_PWM_SAMSUNG is not set
# CONFIG_PWM_SIFIVE is not set
# CONFIG_PWM_SL28CPLD is not set
# CONFIG_PWM_SPEAR is not set
# CONFIG_PWM_SPRD is not set
# CONFIG_PWM_STI is not set
# CONFIG_PWM_STM32 is not set
# CONFIG_PWM_STM32_LP is not set
# CONFIG_PWM_STMPE is not set
# CONFIG_PWM_SUN4I is not set
# CONFIG_PWM_SUNPLUS is not set
# CONFIG_PWM_TEGRA is not set
# CONFIG_PWM_TIECAP is not set
# CONFIG_PWM_TIEHRPWM is not set
# CONFIG_PWM_VISCONTI is not set
# CONFIG_PWM_VT8500 is not set
# CONFIG_PWM_XILINX is not set

#
# IRQ chip support
#
CONFIG_IRQCHIP=y
CONFIG_ARM_GIC=y
CONFIG_ARM_GIC_PM=y
CONFIG_ARM_GIC_MAX_NR=1
CONFIG_ARM_GIC_V2M=y
CONFIG_ARM_GIC_V3=y
CONFIG_ARM_GIC_V3_ITS=y
CONFIG_ARM_GIC_V3_ITS_PCI=y
CONFIG_ARM_GIC_V3_ITS_FSL_MC=y
CONFIG_ALPINE_MSI=y
CONFIG_AL_FIC=y
CONFIG_DW_APB_ICTL=y
CONFIG_MADERA_IRQ=m
# CONFIG_JCORE_AIC is not set
CONFIG_RENESAS_INTC_IRQPIN=y
# CONFIG_RENESAS_IRQC is not set
CONFIG_RENESAS_RZA1_IRQC=y
CONFIG_RENESAS_RZG2L_IRQC=y
CONFIG_SL28CPLD_INTC=y
# CONFIG_TS4800_IRQ is not set
CONFIG_XILINX_INTC=y
# CONFIG_INGENIC_TCU_IRQ is not set
CONFIG_MVEBU_GICP=y
CONFIG_MVEBU_ICU=y
CONFIG_MVEBU_ODMI=y
CONFIG_MVEBU_PIC=y
CONFIG_MVEBU_SEI=y
CONFIG_PARTITION_PERCPU=y
# CONFIG_IRQ_UNIPHIER_AIDET is not set
CONFIG_MESON_IRQ_GPIO=y
# CONFIG_QCOM_PDC is not set
CONFIG_IMX_IRQSTEER=y
# CONFIG_IMX_INTMUX is not set
CONFIG_IMX_MU_MSI=m
CONFIG_EXYNOS_IRQ_COMBINER=y
CONFIG_MST_IRQ=y
CONFIG_APPLE_AIC=y
# CONFIG_MCHP_EIC is not set
CONFIG_SUNPLUS_SP7021_INTC=y
# end of IRQ chip support

# CONFIG_IPACK_BUS is not set
CONFIG_ARCH_HAS_RESET_CONTROLLER=y
CONFIG_RESET_CONTROLLER=y
# CONFIG_RESET_A10SR is not set
# CONFIG_RESET_ATH79 is not set
# CONFIG_RESET_AXS10X is not set
# CONFIG_RESET_BCM6345 is not set
CONFIG_RESET_BERLIN=y
CONFIG_RESET_BRCMSTB=m
CONFIG_RESET_BRCMSTB_RESCAL=y
# CONFIG_RESET_HSDK is not set
CONFIG_RESET_IMX7=m
CONFIG_RESET_INTEL_GW=y
# CONFIG_RESET_K210 is not set
CONFIG_RESET_LANTIQ=y
# CONFIG_RESET_LPC18XX is not set
# CONFIG_RESET_MCHP_SPARX5 is not set
CONFIG_RESET_MESON=y
CONFIG_RESET_MESON_AUDIO_ARB=y
# CONFIG_RESET_NPCM is not set
CONFIG_RESET_PISTACHIO=y
# CONFIG_RESET_QCOM_AOSS is not set
CONFIG_RESET_QCOM_PDC=y
# CONFIG_RESET_RASPBERRYPI is not set
# CONFIG_RESET_RZG2L_USBPHY_CTRL is not set
CONFIG_RESET_SCMI=y
CONFIG_RESET_SIMPLE=y
CONFIG_RESET_SOCFPGA=y
CONFIG_RESET_STARFIVE_JH7100=y
CONFIG_RESET_SUNPLUS=y
# CONFIG_RESET_SUNXI is not set
# CONFIG_RESET_TI_SCI is not set
# CONFIG_RESET_TI_SYSCON is not set
CONFIG_RESET_TI_TPS380X=y
CONFIG_RESET_TN48M_CPLD=y
CONFIG_RESET_UNIPHIER=y
CONFIG_RESET_UNIPHIER_GLUE=m
# CONFIG_RESET_ZYNQ is not set
CONFIG_COMMON_RESET_HI3660=y
# CONFIG_COMMON_RESET_HI6220 is not set

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
CONFIG_GENERIC_PHY_MIPI_DPHY=y
CONFIG_PHY_LPC18XX_USB_OTG=m
CONFIG_PHY_PISTACHIO_USB=y
# CONFIG_PHY_XGENE is not set
CONFIG_PHY_CAN_TRANSCEIVER=m
CONFIG_PHY_SUN6I_MIPI_DPHY=m
CONFIG_PHY_SUN50I_USB3=m
CONFIG_PHY_MESON8_HDMI_TX=m
# CONFIG_PHY_MESON_G12A_MIPI_DPHY_ANALOG is not set
# CONFIG_PHY_MESON_G12A_USB2 is not set
CONFIG_PHY_MESON_G12A_USB3_PCIE=y
# CONFIG_PHY_MESON_AXG_PCIE is not set
CONFIG_PHY_MESON_AXG_MIPI_PCIE_ANALOG=m
CONFIG_PHY_MESON_AXG_MIPI_DPHY=y

#
# PHY drivers for Broadcom platforms
#
CONFIG_PHY_BCM63XX_USBH=m
# CONFIG_PHY_CYGNUS_PCIE is not set
CONFIG_PHY_BCM_SR_USB=y
# CONFIG_BCM_KONA_USB2_PHY is not set
CONFIG_PHY_BCM_NS_USB2=y
CONFIG_PHY_NS2_USB_DRD=m
# CONFIG_PHY_BRCM_SATA is not set
CONFIG_PHY_BRCM_USB=m
CONFIG_PHY_BCM_SR_PCIE=y
# end of PHY drivers for Broadcom platforms

CONFIG_PHY_CADENCE_TORRENT=y
CONFIG_PHY_CADENCE_DPHY=y
CONFIG_PHY_CADENCE_DPHY_RX=m
# CONFIG_PHY_CADENCE_SIERRA is not set
CONFIG_PHY_CADENCE_SALVO=m
CONFIG_PHY_FSL_IMX8MQ_USB=y
CONFIG_PHY_MIXEL_LVDS_PHY=m
CONFIG_PHY_MIXEL_MIPI_DPHY=y
CONFIG_PHY_FSL_IMX8M_PCIE=m
CONFIG_PHY_FSL_LYNX_28G=m
CONFIG_PHY_HI6220_USB=y
CONFIG_PHY_HI3660_USB=m
CONFIG_PHY_HI3670_USB=m
CONFIG_PHY_HI3670_PCIE=m
CONFIG_PHY_HISTB_COMBPHY=m
CONFIG_PHY_HISI_INNO_USB2=m
# CONFIG_PHY_LANTIQ_VRX200_PCIE is not set
# CONFIG_PHY_LANTIQ_RCU_USB2 is not set
CONFIG_ARMADA375_USBCLUSTER_PHY=y
# CONFIG_PHY_BERLIN_SATA is not set
CONFIG_PHY_BERLIN_USB=y
CONFIG_PHY_MVEBU_A3700_COMPHY=m
# CONFIG_PHY_MVEBU_A3700_UTMI is not set
CONFIG_PHY_MVEBU_A38X_COMPHY=m
# CONFIG_PHY_MVEBU_CP110_COMPHY is not set
# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
CONFIG_PHY_PXA_USB=m
CONFIG_PHY_MMP3_USB=m
CONFIG_PHY_MMP3_HSIC=y
CONFIG_PHY_MTK_PCIE=y
CONFIG_PHY_MTK_TPHY=y
CONFIG_PHY_MTK_UFS=y
CONFIG_PHY_MTK_XSPHY=y
# CONFIG_PHY_MTK_HDMI is not set
CONFIG_PHY_MTK_MIPI_DSI=y
CONFIG_PHY_MTK_DP=y
# CONFIG_PHY_SPARX5_SERDES is not set
# CONFIG_PHY_LAN966X_SERDES is not set
CONFIG_PHY_OCELOT_SERDES=m
# CONFIG_PHY_ATH79_USB is not set
CONFIG_PHY_QCOM_APQ8064_SATA=m
CONFIG_PHY_QCOM_EDP=y
CONFIG_PHY_QCOM_IPQ4019_USB=m
CONFIG_PHY_QCOM_IPQ806X_SATA=m
CONFIG_PHY_QCOM_PCIE2=y
# CONFIG_PHY_QCOM_QMP is not set
# CONFIG_PHY_QCOM_QUSB2 is not set
CONFIG_PHY_QCOM_USB_SNPS_FEMTO_V2=m
# CONFIG_PHY_QCOM_USB_HS_28NM is not set
CONFIG_PHY_QCOM_USB_SS=m
CONFIG_PHY_QCOM_IPQ806X_USB=m
CONFIG_PHY_MT7621_PCI=m
# CONFIG_PHY_RALINK_USB is not set
CONFIG_PHY_RCAR_GEN3_USB3=m
CONFIG_PHY_ROCKCHIP_DPHY_RX0=m
# CONFIG_PHY_ROCKCHIP_INNO_HDMI is not set
# CONFIG_PHY_ROCKCHIP_INNO_CSIDPHY is not set
# CONFIG_PHY_ROCKCHIP_INNO_DSIDPHY is not set
# CONFIG_PHY_ROCKCHIP_PCIE is not set
# CONFIG_PHY_ROCKCHIP_SNPS_PCIE3 is not set
CONFIG_PHY_ROCKCHIP_TYPEC=m
CONFIG_PHY_EXYNOS_DP_VIDEO=m
CONFIG_PHY_EXYNOS_MIPI_VIDEO=y
CONFIG_PHY_EXYNOS_PCIE=y
CONFIG_PHY_SAMSUNG_UFS=y
CONFIG_PHY_SAMSUNG_USB2=y
CONFIG_PHY_S5PV210_USB2=y
CONFIG_PHY_UNIPHIER_USB2=m
# CONFIG_PHY_UNIPHIER_USB3 is not set
CONFIG_PHY_UNIPHIER_PCIE=m
CONFIG_PHY_UNIPHIER_AHCI=m
CONFIG_PHY_ST_SPEAR1310_MIPHY=y
CONFIG_PHY_ST_SPEAR1340_MIPHY=m
CONFIG_PHY_STIH407_USB=y
# CONFIG_PHY_STM32_USBPHYC is not set
CONFIG_PHY_SUNPLUS_USB=m
CONFIG_PHY_TEGRA194_P2U=m
CONFIG_PHY_DA8XX_USB=m
CONFIG_PHY_AM654_SERDES=y
# CONFIG_PHY_J721E_WIZ is not set
CONFIG_OMAP_CONTROL_PHY=y
# CONFIG_TI_PIPE3 is not set
CONFIG_PHY_INTEL_KEEMBAY_EMMC=m
CONFIG_PHY_INTEL_KEEMBAY_USB=y
CONFIG_PHY_INTEL_LGM_COMBO=y
# CONFIG_PHY_INTEL_LGM_EMMC is not set
CONFIG_PHY_INTEL_THUNDERBAY_EMMC=y
# CONFIG_PHY_XILINX_ZYNQMP is not set
# end of PHY Subsystem

# CONFIG_POWERCAP is not set
CONFIG_MCB=y
CONFIG_MCB_PCI=y
# CONFIG_MCB_LPC is not set

#
# Performance monitor support
#
CONFIG_ARM_CCI_PMU=m
# CONFIG_ARM_CCI400_PMU is not set
# CONFIG_ARM_CCI5xx_PMU is not set
CONFIG_ARM_CCN=y
CONFIG_ARM_CMN=m
# CONFIG_ARM_PMU is not set
CONFIG_ARM_SMMU_V3_PMU=y
# CONFIG_ARM_DSU_PMU is not set
CONFIG_FSL_IMX8_DDR_PMU=y
# CONFIG_XGENE_PMU is not set
# CONFIG_ARM_SPE_PMU is not set
CONFIG_ARM_DMC620_PMU=y
# CONFIG_MARVELL_CN10K_TAD_PMU is not set
# CONFIG_ALIBABA_UNCORE_DRW_PMU is not set
CONFIG_HISI_PCIE_PMU=y
CONFIG_HNS3_PMU=m
# CONFIG_MARVELL_CN10K_DDR_PMU is not set
# end of Performance monitor support

# CONFIG_RAS is not set
# CONFIG_USB4 is not set

#
# Android
#
CONFIG_ANDROID_BINDER_IPC=y
# CONFIG_ANDROID_BINDERFS is not set
CONFIG_ANDROID_BINDER_DEVICES="binder,hwbinder,vndbinder"
CONFIG_ANDROID_BINDER_IPC_SELFTEST=y
# end of Android

# CONFIG_DAX is not set
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y
CONFIG_NVMEM_APPLE_EFUSES=y
CONFIG_NVMEM_BCM_OCOTP=m
# CONFIG_NVMEM_BRCM_NVRAM is not set
CONFIG_NVMEM_IMX_IIM=m
# CONFIG_NVMEM_IMX_OCOTP is not set
# CONFIG_NVMEM_JZ4780_EFUSE is not set
CONFIG_NVMEM_LAN9662_OTPC=y
# CONFIG_NVMEM_LAYERSCAPE_SFP is not set
CONFIG_NVMEM_LPC18XX_EEPROM=y
CONFIG_NVMEM_LPC18XX_OTP=y
# CONFIG_NVMEM_MESON_MX_EFUSE is not set
# CONFIG_NVMEM_MICROCHIP_OTPC is not set
CONFIG_NVMEM_MTK_EFUSE=m
CONFIG_NVMEM_MXS_OCOTP=m
# CONFIG_NVMEM_NINTENDO_OTP is not set
CONFIG_NVMEM_QCOM_QFPROM=m
# CONFIG_NVMEM_RMEM is not set
CONFIG_NVMEM_ROCKCHIP_EFUSE=m
CONFIG_NVMEM_ROCKCHIP_OTP=y
# CONFIG_NVMEM_SC27XX_EFUSE is not set
CONFIG_NVMEM_SNVS_LPGPR=y
# CONFIG_NVMEM_SPRD_EFUSE is not set
CONFIG_NVMEM_STM32_ROMEM=m
# CONFIG_NVMEM_SUNPLUS_OCOTP is not set
CONFIG_NVMEM_UNIPHIER_EFUSE=y
CONFIG_NVMEM_VF610_OCOTP=m

#
# HW tracing support
#
# CONFIG_STM is not set
# CONFIG_INTEL_TH is not set
CONFIG_HISI_PTT=m
# end of HW tracing support

# CONFIG_FPGA is not set
CONFIG_FSI=m
CONFIG_FSI_NEW_DEV_NODE=y
# CONFIG_FSI_MASTER_GPIO is not set
CONFIG_FSI_MASTER_HUB=m
CONFIG_FSI_MASTER_AST_CF=m
CONFIG_FSI_MASTER_ASPEED=m
CONFIG_FSI_SCOM=m
CONFIG_FSI_SBEFIFO=m
CONFIG_FSI_OCC=m
CONFIG_TEE=m
CONFIG_OPTEE=m
CONFIG_MULTIPLEXER=y

#
# Multiplexer drivers
#
# CONFIG_MUX_ADG792A is not set
CONFIG_MUX_GPIO=m
CONFIG_MUX_MMIO=y
# end of Multiplexer drivers

CONFIG_PM_OPP=y
# CONFIG_SIOX is not set
CONFIG_SLIMBUS=y
# CONFIG_SLIM_QCOM_CTRL is not set
CONFIG_INTERCONNECT=y
CONFIG_INTERCONNECT_IMX=m
CONFIG_INTERCONNECT_IMX8MM=m
# CONFIG_INTERCONNECT_IMX8MN is not set
CONFIG_INTERCONNECT_IMX8MQ=m
CONFIG_INTERCONNECT_IMX8MP=m
CONFIG_INTERCONNECT_QCOM=y
CONFIG_INTERCONNECT_QCOM_BCM_VOTER=m
# CONFIG_INTERCONNECT_QCOM_MSM8916 is not set
# CONFIG_INTERCONNECT_QCOM_MSM8939 is not set
# CONFIG_INTERCONNECT_QCOM_MSM8974 is not set
CONFIG_INTERCONNECT_QCOM_MSM8996=m
# CONFIG_INTERCONNECT_QCOM_OSM_L3 is not set
CONFIG_INTERCONNECT_QCOM_QCM2290=m
CONFIG_INTERCONNECT_QCOM_QCS404=m
CONFIG_INTERCONNECT_QCOM_RPMH_POSSIBLE=m
CONFIG_INTERCONNECT_QCOM_RPMH=m
# CONFIG_INTERCONNECT_QCOM_SC7180 is not set
CONFIG_INTERCONNECT_QCOM_SC7280=m
CONFIG_INTERCONNECT_QCOM_SC8180X=m
CONFIG_INTERCONNECT_QCOM_SC8280XP=m
CONFIG_INTERCONNECT_QCOM_SDM660=m
CONFIG_INTERCONNECT_QCOM_SDM845=m
CONFIG_INTERCONNECT_QCOM_SDX55=m
CONFIG_INTERCONNECT_QCOM_SDX65=m
CONFIG_INTERCONNECT_QCOM_SM6350=m
# CONFIG_INTERCONNECT_QCOM_SM8150 is not set
CONFIG_INTERCONNECT_QCOM_SM8250=m
CONFIG_INTERCONNECT_QCOM_SM8350=m
CONFIG_INTERCONNECT_QCOM_SM8450=m
CONFIG_INTERCONNECT_QCOM_SMD_RPM=m
# CONFIG_INTERCONNECT_SAMSUNG is not set
CONFIG_COUNTER=y
CONFIG_104_QUAD_8=y
CONFIG_INTERRUPT_CNT=m
CONFIG_STM32_TIMER_CNT=m
# CONFIG_STM32_LPTIMER_CNT is not set
CONFIG_TI_EQEP=m
CONFIG_FTM_QUADDEC=m
CONFIG_MICROCHIP_TCB_CAPTURE=m
# CONFIG_INTEL_QEP is not set
CONFIG_TI_ECAP_CAPTURE=y
CONFIG_MOST=m
# CONFIG_MOST_CDEV is not set
# CONFIG_PECI is not set
CONFIG_HTE=y
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
# CONFIG_VALIDATE_FS_PARSER is not set
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
# CONFIG_EXPORTFS_BLOCK_OPS is not set
# CONFIG_FILE_LOCKING is not set
# CONFIG_FS_ENCRYPTION is not set
CONFIG_FS_VERITY=y
# CONFIG_FS_VERITY_DEBUG is not set
# CONFIG_FS_VERITY_BUILTIN_SIGNATURES is not set
CONFIG_FSNOTIFY=y
# CONFIG_DNOTIFY is not set
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
# CONFIG_QUOTA is not set
CONFIG_AUTOFS4_FS=m
CONFIG_AUTOFS_FS=m
CONFIG_FUSE_FS=y
# CONFIG_CUSE is not set
# CONFIG_VIRTIO_FS is not set
CONFIG_OVERLAY_FS=y
# CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW=y
CONFIG_OVERLAY_FS_INDEX=y
CONFIG_OVERLAY_FS_NFS_EXPORT=y
# CONFIG_OVERLAY_FS_XINO_AUTO is not set
# CONFIG_OVERLAY_FS_METACOPY is not set

#
# Caches
#
CONFIG_NETFS_SUPPORT=y
CONFIG_NETFS_STATS=y
CONFIG_FSCACHE=y
# CONFIG_FSCACHE_STATS is not set
# CONFIG_FSCACHE_DEBUG is not set
# end of Caches

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_PROC_KCORE is not set
# CONFIG_PROC_VMCORE is not set
CONFIG_PROC_SYSCTL=y
# CONFIG_PROC_PAGE_MONITOR is not set
CONFIG_PROC_CHILDREN=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
CONFIG_TMPFS_INODE64=y
CONFIG_ARCH_SUPPORTS_HUGETLBFS=y
# CONFIG_HUGETLBFS is not set
CONFIG_ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP=y
CONFIG_MEMFD_CREATE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
CONFIG_ECRYPT_FS=y
CONFIG_ECRYPT_FS_MESSAGING=y
# CONFIG_CRAMFS is not set
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFAULT_KMSG_BYTES=10240
# CONFIG_PSTORE_DEFLATE_COMPRESS is not set
CONFIG_PSTORE_LZO_COMPRESS=m
CONFIG_PSTORE_LZ4_COMPRESS=m
# CONFIG_PSTORE_LZ4HC_COMPRESS is not set
CONFIG_PSTORE_842_COMPRESS=y
# CONFIG_PSTORE_ZSTD_COMPRESS is not set
CONFIG_PSTORE_COMPRESS=y
# CONFIG_PSTORE_LZO_COMPRESS_DEFAULT is not set
# CONFIG_PSTORE_LZ4_COMPRESS_DEFAULT is not set
CONFIG_PSTORE_842_COMPRESS_DEFAULT=y
CONFIG_PSTORE_COMPRESS_DEFAULT="842"
# CONFIG_PSTORE_CONSOLE is not set
CONFIG_PSTORE_PMSG=y
# CONFIG_PSTORE_RAM is not set
# CONFIG_NETWORK_FILESYSTEMS is not set
CONFIG_NLS=m
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=m
CONFIG_NLS_CODEPAGE_737=m
# CONFIG_NLS_CODEPAGE_775 is not set
CONFIG_NLS_CODEPAGE_850=m
# CONFIG_NLS_CODEPAGE_852 is not set
CONFIG_NLS_CODEPAGE_855=m
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
# CONFIG_NLS_CODEPAGE_874 is not set
CONFIG_NLS_ISO8859_8=m
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
# CONFIG_NLS_ASCII is not set
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
# CONFIG_NLS_MAC_ROMAN is not set
CONFIG_NLS_MAC_CELTIC=m
CONFIG_NLS_MAC_CENTEURO=m
CONFIG_NLS_MAC_CROATIAN=m
CONFIG_NLS_MAC_CYRILLIC=m
CONFIG_NLS_MAC_GAELIC=m
CONFIG_NLS_MAC_GREEK=m
# CONFIG_NLS_MAC_ICELAND is not set
CONFIG_NLS_MAC_INUIT=m
CONFIG_NLS_MAC_ROMANIAN=m
CONFIG_NLS_MAC_TURKISH=m
CONFIG_NLS_UTF8=m
# CONFIG_DLM is not set
CONFIG_UNICODE=y
CONFIG_UNICODE_NORMALIZATION_SELFTEST=m
CONFIG_IO_WQ=y
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
CONFIG_KEYS_REQUEST_CACHE=y
CONFIG_PERSISTENT_KEYRINGS=y
CONFIG_BIG_KEYS=y
CONFIG_TRUSTED_KEYS=m
# CONFIG_TRUSTED_KEYS_TPM is not set
# CONFIG_TRUSTED_KEYS_TEE is not set

#
# No trust source selected!
#
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_USER_DECRYPTED_DATA is not set
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
# CONFIG_SECURITY is not set
# CONFIG_SECURITYFS is not set
# CONFIG_FORTIFY_SOURCE is not set
CONFIG_STATIC_USERMODEHELPER=y
CONFIG_STATIC_USERMODEHELPER_PATH="/sbin/usermode-helper"
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_LSM="landlock,lockdown,yama,loadpin,safesetid,integrity,bpf"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_CC_HAS_AUTO_VAR_INIT_PATTERN=y
CONFIG_CC_HAS_AUTO_VAR_INIT_ZERO_BARE=y
CONFIG_CC_HAS_AUTO_VAR_INIT_ZERO=y
CONFIG_INIT_STACK_NONE=y
# CONFIG_INIT_STACK_ALL_PATTERN is not set
# CONFIG_INIT_STACK_ALL_ZERO is not set
CONFIG_GCC_PLUGIN_STACKLEAK=y
CONFIG_STACKLEAK_TRACK_MIN_SIZE=100
# CONFIG_STACKLEAK_METRICS is not set
CONFIG_STACKLEAK_RUNTIME_DISABLE=y
# CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
CONFIG_CC_HAS_ZERO_CALL_USED_REGS=y
# CONFIG_ZERO_CALL_USED_REGS is not set
# end of Memory initialization

CONFIG_RANDSTRUCT_NONE=y
# CONFIG_RANDSTRUCT_FULL is not set
# CONFIG_RANDSTRUCT_PERFORMANCE is not set
# end of Kernel hardening options
# end of Security options

CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_SKCIPHER=y
CONFIG_CRYPTO_SKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=y
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_USER=m
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=m
CONFIG_CRYPTO_CRYPTD=m
CONFIG_CRYPTO_AUTHENC=y
CONFIG_CRYPTO_TEST=m
CONFIG_CRYPTO_ENGINE=y
# end of Crypto core or helper

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=y
CONFIG_CRYPTO_DH_RFC7919_GROUPS=y
CONFIG_CRYPTO_ECC=y
CONFIG_CRYPTO_ECDH=y
CONFIG_CRYPTO_ECDSA=m
CONFIG_CRYPTO_ECRDSA=y
CONFIG_CRYPTO_SM2=m
CONFIG_CRYPTO_CURVE25519=y
# end of Public-key cryptography

#
# Block ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
# CONFIG_CRYPTO_ARIA is not set
CONFIG_CRYPTO_BLOWFISH=y
CONFIG_CRYPTO_BLOWFISH_COMMON=y
CONFIG_CRYPTO_CAMELLIA=y
CONFIG_CRYPTO_CAST_COMMON=y
# CONFIG_CRYPTO_CAST5 is not set
CONFIG_CRYPTO_CAST6=y
CONFIG_CRYPTO_DES=y
CONFIG_CRYPTO_FCRYPT=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_SM4=y
# CONFIG_CRYPTO_SM4_GENERIC is not set
CONFIG_CRYPTO_TWOFISH=y
CONFIG_CRYPTO_TWOFISH_COMMON=y
# end of Block ciphers

#
# Length-preserving ciphers and modes
#
CONFIG_CRYPTO_ADIANTUM=y
CONFIG_CRYPTO_CHACHA20=y
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CFB=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=m
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_HCTR2=y
CONFIG_CRYPTO_KEYWRAP=y
CONFIG_CRYPTO_LRW=y
CONFIG_CRYPTO_OFB=y
CONFIG_CRYPTO_PCBC=y
CONFIG_CRYPTO_XCTR=y
CONFIG_CRYPTO_XTS=y
CONFIG_CRYPTO_NHPOLY1305=y
# end of Length-preserving ciphers and modes

#
# AEAD (authenticated encryption with associated data) ciphers
#
CONFIG_CRYPTO_AEGIS128=y
CONFIG_CRYPTO_AEGIS128_SIMD=y
CONFIG_CRYPTO_CHACHA20POLY1305=y
# CONFIG_CRYPTO_CCM is not set
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=y
CONFIG_CRYPTO_ESSIV=y
# end of AEAD (authenticated encryption with associated data) ciphers

#
# Hashes, digests, and MACs
#
# CONFIG_CRYPTO_BLAKE2B is not set
CONFIG_CRYPTO_CMAC=y
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_POLYVAL=y
CONFIG_CRYPTO_POLY1305=y
CONFIG_CRYPTO_RMD160=y
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=y
CONFIG_CRYPTO_SM3=m
CONFIG_CRYPTO_SM3_GENERIC=m
CONFIG_CRYPTO_STREEBOG=y
CONFIG_CRYPTO_VMAC=m
# CONFIG_CRYPTO_WP512 is not set
CONFIG_CRYPTO_XCBC=y
CONFIG_CRYPTO_XXHASH=y
# end of Hashes, digests, and MACs

#
# CRCs (cyclic redundancy checks)
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32=y
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRC64_ROCKSOFT=y
# end of CRCs (cyclic redundancy checks)

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
CONFIG_CRYPTO_842=y
CONFIG_CRYPTO_LZ4=m
CONFIG_CRYPTO_LZ4HC=y
# CONFIG_CRYPTO_ZSTD is not set
# end of Compression

#
# Random number generation
#
# CONFIG_CRYPTO_ANSI_CPRNG is not set
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
# CONFIG_CRYPTO_DRBG_HASH is not set
# CONFIG_CRYPTO_DRBG_CTR is not set
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
# end of Random number generation

#
# Userspace interface
#
CONFIG_CRYPTO_USER_API=y
CONFIG_CRYPTO_USER_API_HASH=m
# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
CONFIG_CRYPTO_USER_API_RNG=m
# CONFIG_CRYPTO_USER_API_RNG_CAVP is not set
CONFIG_CRYPTO_USER_API_AEAD=y
# CONFIG_CRYPTO_USER_API_ENABLE_OBSOLETE is not set
# CONFIG_CRYPTO_STATS is not set
# end of Userspace interface

CONFIG_CRYPTO_HASH_INFO=y
CONFIG_CRYPTO_NHPOLY1305_NEON=y
CONFIG_CRYPTO_CHACHA20_NEON=y

#
# Accelerated Cryptographic Algorithms for CPU (arm64)
#
# CONFIG_CRYPTO_GHASH_ARM64_CE is not set
# CONFIG_CRYPTO_POLY1305_NEON is not set
CONFIG_CRYPTO_SHA1_ARM64_CE=y
CONFIG_CRYPTO_SHA256_ARM64=y
CONFIG_CRYPTO_SHA2_ARM64_CE=y
CONFIG_CRYPTO_SHA512_ARM64=y
CONFIG_CRYPTO_SHA512_ARM64_CE=y
# CONFIG_CRYPTO_SHA3_ARM64 is not set
# CONFIG_CRYPTO_SM3_ARM64_CE is not set
# CONFIG_CRYPTO_POLYVAL_ARM64_CE is not set
# CONFIG_CRYPTO_AES_ARM64 is not set
CONFIG_CRYPTO_AES_ARM64_CE=m
# CONFIG_CRYPTO_AES_ARM64_CE_BLK is not set
CONFIG_CRYPTO_AES_ARM64_NEON_BLK=m
CONFIG_CRYPTO_AES_ARM64_BS=m
# CONFIG_CRYPTO_SM4_ARM64_CE is not set
CONFIG_CRYPTO_SM4_ARM64_CE_BLK=y
CONFIG_CRYPTO_SM4_ARM64_NEON_BLK=m
CONFIG_CRYPTO_AES_ARM64_CE_CCM=m
CONFIG_CRYPTO_CRCT10DIF_ARM64_CE=m
# end of Accelerated Cryptographic Algorithms for CPU (arm64)

CONFIG_CRYPTO_HW=y
CONFIG_CRYPTO_DEV_ALLWINNER=y
CONFIG_CRYPTO_DEV_SUN8I_CE=m
# CONFIG_CRYPTO_DEV_SUN8I_CE_DEBUG is not set
CONFIG_CRYPTO_DEV_SUN8I_CE_HASH=y
CONFIG_CRYPTO_DEV_SUN8I_CE_PRNG=y
# CONFIG_CRYPTO_DEV_SUN8I_CE_TRNG is not set
CONFIG_CRYPTO_DEV_SUN8I_SS=y
CONFIG_CRYPTO_DEV_SUN8I_SS_DEBUG=y
CONFIG_CRYPTO_DEV_SUN8I_SS_PRNG=y
CONFIG_CRYPTO_DEV_SUN8I_SS_HASH=y
CONFIG_CRYPTO_DEV_SL3516=y
CONFIG_CRYPTO_DEV_SL3516_DEBUG=y
CONFIG_CRYPTO_DEV_EXYNOS_RNG=y
CONFIG_CRYPTO_DEV_S5P=m
# CONFIG_CRYPTO_DEV_ATMEL_AES is not set
CONFIG_CRYPTO_DEV_ATMEL_TDES=y
CONFIG_CRYPTO_DEV_ATMEL_SHA=m
CONFIG_CRYPTO_DEV_ATMEL_I2C=y
CONFIG_CRYPTO_DEV_ATMEL_ECC=y
# CONFIG_CRYPTO_DEV_ATMEL_SHA204A is not set
# CONFIG_CRYPTO_DEV_CCP is not set
CONFIG_CRYPTO_DEV_QAT=y
CONFIG_CRYPTO_DEV_QAT_DH895xCC=y
CONFIG_CRYPTO_DEV_QAT_C3XXX=m
# CONFIG_CRYPTO_DEV_QAT_C62X is not set
CONFIG_CRYPTO_DEV_QAT_4XXX=y
# CONFIG_CRYPTO_DEV_QAT_DH895xCCVF is not set
# CONFIG_CRYPTO_DEV_QAT_C3XXXVF is not set
CONFIG_CRYPTO_DEV_QAT_C62XVF=m
CONFIG_CRYPTO_DEV_CPT=m
CONFIG_CAVIUM_CPT=m
# CONFIG_CRYPTO_DEV_NITROX_CNN55XX is not set
# CONFIG_CRYPTO_DEV_MARVELL_CESA is not set
# CONFIG_CRYPTO_DEV_OCTEONTX_CPT is not set
CONFIG_CRYPTO_DEV_CAVIUM_ZIP=m
# CONFIG_CRYPTO_DEV_QCE is not set
CONFIG_CRYPTO_DEV_QCOM_RNG=m
CONFIG_CRYPTO_DEV_IMGTEC_HASH=y
# CONFIG_CRYPTO_DEV_ZYNQMP_AES is not set
CONFIG_CRYPTO_DEV_ZYNQMP_SHA3=y
# CONFIG_CRYPTO_DEV_VIRTIO is not set
CONFIG_CRYPTO_DEV_SAFEXCEL=y
# CONFIG_CRYPTO_DEV_CCREE is not set
# CONFIG_CRYPTO_DEV_HISI_SEC is not set
# CONFIG_CRYPTO_DEV_AMLOGIC_GXL is not set
CONFIG_CRYPTO_DEV_SA2UL=y
# CONFIG_CRYPTO_DEV_KEEMBAY_OCS_AES_SM4 is not set
# CONFIG_CRYPTO_DEV_KEEMBAY_OCS_ECC is not set
CONFIG_CRYPTO_DEV_KEEMBAY_OCS_HCU=y
CONFIG_CRYPTO_DEV_KEEMBAY_OCS_HCU_HMAC_SHA224=y
CONFIG_CRYPTO_DEV_ASPEED=m
# CONFIG_CRYPTO_DEV_ASPEED_DEBUG is not set
# CONFIG_CRYPTO_DEV_ASPEED_HACE_HASH is not set
CONFIG_CRYPTO_DEV_ASPEED_HACE_CRYPTO=y
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
CONFIG_PKCS8_PRIVATE_KEY_PARSER=m
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_PKCS7_TEST_KEY is not set
# CONFIG_SIGNED_PE_FILE_VERIFICATION is not set
CONFIG_FIPS_SIGNATURE_SELFTEST=y

#
# Certificates for signature checking
#
CONFIG_MODULE_SIG_KEY="certs/signing_key.pem"
CONFIG_MODULE_SIG_KEY_TYPE_RSA=y
# CONFIG_MODULE_SIG_KEY_TYPE_ECDSA is not set
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
# CONFIG_SECONDARY_TRUSTED_KEYRING is not set
# CONFIG_SYSTEM_BLACKLIST_KEYRING is not set
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_LINEAR_RANGES=y
# CONFIG_PACKING is not set
CONFIG_BITREVERSE=y
CONFIG_HAVE_ARCH_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_CORDIC=m
CONFIG_PRIME_NUMBERS=y
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_STMP_DEVICE=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_ARCH_USE_SYM_ANNOTATIONS=y
CONFIG_INDIRECT_PIO=y
# CONFIG_TRACE_MMIO_ACCESS is not set

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_UTILS=y
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
CONFIG_CRYPTO_ARCH_HAVE_LIB_CHACHA=y
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=y
CONFIG_CRYPTO_LIB_CHACHA=y
CONFIG_CRYPTO_LIB_CURVE25519_GENERIC=y
CONFIG_CRYPTO_LIB_CURVE25519=m
CONFIG_CRYPTO_LIB_DES=y
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=9
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=y
CONFIG_CRYPTO_LIB_POLY1305=y
CONFIG_CRYPTO_LIB_CHACHA20POLY1305=y
CONFIG_CRYPTO_LIB_SHA1=y
CONFIG_CRYPTO_LIB_SHA256=y
# end of Crypto library routines

CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC64_ROCKSOFT=y
CONFIG_CRC_ITU_T=m
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
CONFIG_CRC64=y
CONFIG_CRC4=y
CONFIG_CRC7=m
CONFIG_LIBCRC32C=y
CONFIG_CRC8=y
CONFIG_XXHASH=y
CONFIG_AUDIT_GENERIC=y
CONFIG_AUDIT_ARCH_COMPAT_GENERIC=y
CONFIG_AUDIT_COMPAT_GENERIC=y
CONFIG_RANDOM32_SELFTEST=y
CONFIG_842_COMPRESS=y
CONFIG_842_DECOMPRESS=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_COMPRESS=m
CONFIG_LZ4HC_COMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMMON=y
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
# CONFIG_XZ_DEC_MICROLZMA is not set
CONFIG_XZ_DEC_BCJ=y
CONFIG_XZ_DEC_TEST=m
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_ZSTD=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_INTERVAL_TREE=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_DMA_OPS=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_DMA_DECLARE_COHERENT=y
CONFIG_ARCH_HAS_SETUP_DMA_OPS=y
CONFIG_ARCH_HAS_TEARDOWN_DMA_OPS=y
CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE=y
CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU=y
CONFIG_ARCH_HAS_DMA_PREP_COHERENT=y
CONFIG_SWIOTLB=y
CONFIG_DMA_RESTRICTED_POOL=y
CONFIG_DMA_NONCOHERENT_MMAP=y
CONFIG_DMA_COHERENT_POOL=y
CONFIG_DMA_DIRECT_REMAP=y
CONFIG_DMA_CMA=y
# CONFIG_DMA_PERNUMA_CMA is not set

#
# Default contiguous memory area size:
#
CONFIG_CMA_SIZE_PERCENTAGE=10
# CONFIG_CMA_SIZE_SEL_MBYTES is not set
CONFIG_CMA_SIZE_SEL_PERCENTAGE=y
# CONFIG_CMA_SIZE_SEL_MIN is not set
# CONFIG_CMA_SIZE_SEL_MAX is not set
CONFIG_CMA_ALIGNMENT=8
CONFIG_DMA_API_DEBUG=y
# CONFIG_DMA_API_DEBUG_SG is not set
CONFIG_DMA_MAP_BENCHMARK=y
CONFIG_SGL_ALLOC=y
# CONFIG_FORCE_NR_CPUS is not set
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
CONFIG_GLOB_SELFTEST=m
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_DIMLIB=y
CONFIG_LIBFDT=y
CONFIG_OID_REGISTRY=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_SG_SPLIT=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_MEMREGION=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_ARCH_STACKWALK=y
CONFIG_STACKDEPOT=y
CONFIG_REF_TRACKER=y
CONFIG_PARMAN=m
# CONFIG_OBJAGG is not set
# end of Library routines

CONFIG_GENERIC_IOREMAP=y
CONFIG_GENERIC_LIB_DEVMEM_IS_ALLOWED=y
CONFIG_POLYNOMIAL=m

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
CONFIG_SYMBOLIC_ERRNAME=y
# end of printk and dmesg options

CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_MISC=y

#
# Compile-time checks and compiler options
#
CONFIG_AS_HAS_NON_CONST_LEB128=y
CONFIG_DEBUG_INFO_NONE=y
# CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is not set
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_DEBUG_INFO_DWARF5 is not set
CONFIG_FRAME_WARN=2048
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
CONFIG_HEADERS_INSTALL=y
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
# CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_64B is not set
CONFIG_ARCH_WANT_FRAME_POINTERS=y
CONFIG_FRAME_POINTER=y
CONFIG_VMLINUX_MAP=y
CONFIG_DEBUG_FORCE_WEAK_PER_CPU=y
# end of Compile-time checks and compiler options

#
# Generic Kernel Debugging Instruments
#
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE=""
CONFIG_DEBUG_FS=y
# CONFIG_DEBUG_FS_ALLOW_ALL is not set
# CONFIG_DEBUG_FS_DISALLOW_MOUNT is not set
CONFIG_DEBUG_FS_ALLOW_NONE=y
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_UBSAN is not set
CONFIG_HAVE_ARCH_KCSAN=y
CONFIG_HAVE_KCSAN_COMPILER=y
# CONFIG_KCSAN is not set
# end of Generic Kernel Debugging Instruments

#
# Networking Debugging
#
CONFIG_NET_DEV_REFCNT_TRACKER=y
CONFIG_NET_NS_REFCNT_TRACKER=y
CONFIG_DEBUG_NET=y
# end of Networking Debugging

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
CONFIG_DEBUG_PAGEALLOC=y
CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT=y
CONFIG_PAGE_OWNER=y
CONFIG_PAGE_TABLE_CHECK=y
CONFIG_PAGE_TABLE_CHECK_ENFORCED=y
# CONFIG_PAGE_POISONING is not set
CONFIG_DEBUG_PAGE_REF=y
CONFIG_DEBUG_RODATA_TEST=y
CONFIG_ARCH_HAS_DEBUG_WX=y
# CONFIG_DEBUG_WX is not set
CONFIG_GENERIC_PTDUMP=y
CONFIG_PTDUMP_CORE=y
CONFIG_PTDUMP_DEBUGFS=y
# CONFIG_DEBUG_OBJECTS is not set
CONFIG_SHRINKER_DEBUG=y
CONFIG_HAVE_DEBUG_KMEMLEAK=y
CONFIG_DEBUG_KMEMLEAK=y
CONFIG_DEBUG_KMEMLEAK_MEM_POOL_SIZE=16000
CONFIG_DEBUG_KMEMLEAK_TEST=m
# CONFIG_DEBUG_KMEMLEAK_DEFAULT_OFF is not set
CONFIG_DEBUG_KMEMLEAK_AUTO_SCAN=y
# CONFIG_DEBUG_STACK_USAGE is not set
CONFIG_SCHED_STACK_END_CHECK=y
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
# CONFIG_DEBUG_VM is not set
CONFIG_DEBUG_VM_PGTABLE=y
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
CONFIG_DEBUG_VIRTUAL=y
CONFIG_DEBUG_MEMORY_INIT=y
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_HAVE_ARCH_KASAN_SW_TAGS=y
CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_KASAN_SW_TAGS=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
CONFIG_HAVE_ARCH_KFENCE=y
# end of Memory Debugging

CONFIG_DEBUG_SHIRQ=y

#
# Debug Oops, Lockups and Hangs
#
# CONFIG_PANIC_ON_OOPS is not set
CONFIG_PANIC_ON_OOPS_VALUE=0
CONFIG_PANIC_TIMEOUT=0
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=y
# CONFIG_DETECT_HUNG_TASK is not set
# CONFIG_WQ_WATCHDOG is not set
CONFIG_TEST_LOCKUP=m
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
# CONFIG_SCHED_DEBUG is not set
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# end of Scheduler Debugging

# CONFIG_DEBUG_TIMEKEEPING is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
CONFIG_PROVE_LOCKING=y
# CONFIG_PROVE_RAW_LOCK_NESTING is not set
# CONFIG_LOCK_STAT is not set
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
CONFIG_DEBUG_RWSEMS=y
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_LOCKDEP=y
CONFIG_LOCKDEP_BITS=15
CONFIG_LOCKDEP_CHAINS_BITS=16
CONFIG_LOCKDEP_STACK_TRACE_BITS=19
CONFIG_LOCKDEP_STACK_TRACE_HASH_BITS=14
CONFIG_LOCKDEP_CIRCULAR_QUEUE_BITS=12
# CONFIG_DEBUG_LOCKDEP is not set
# CONFIG_DEBUG_ATOMIC_SLEEP is not set
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_LOCK_TORTURE_TEST is not set
CONFIG_WW_MUTEX_SELFTEST=y
# CONFIG_SCF_TORTURE_TEST is not set
# CONFIG_CSD_LOCK_WAIT_DEBUG is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_TRACE_IRQFLAGS=y
CONFIG_TRACE_IRQFLAGS_NMI=y
CONFIG_DEBUG_IRQFLAGS=y
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set

#
# Debug kernel data structures
#
# CONFIG_DEBUG_LIST is not set
# CONFIG_DEBUG_PLIST is not set
# CONFIG_DEBUG_SG is not set
CONFIG_DEBUG_NOTIFIERS=y
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
CONFIG_DEBUG_MAPLE_TREE=y
# end of Debug kernel data structures

# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_PROVE_RCU=y
# CONFIG_PROVE_RCU_LIST is not set
CONFIG_TORTURE_TEST=y
CONFIG_RCU_SCALE_TEST=y
# CONFIG_RCU_TORTURE_TEST is not set
CONFIG_RCU_REF_SCALE_TEST=m
CONFIG_RCU_CPU_STALL_TIMEOUT=21
CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=0
CONFIG_RCU_TRACE=y
CONFIG_RCU_EQS_DEBUG=y
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
# CONFIG_LATENCYTOP is not set
CONFIG_NOP_TRACER=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_PREEMPTIRQ_TRACEPOINTS=y
CONFIG_TRACING=y
CONFIG_TRACING_SUPPORT=y
# CONFIG_FTRACE is not set
# CONFIG_SAMPLES is not set

#
# arm64 Debugging
#
CONFIG_PID_IN_CONTEXTIDR=y
CONFIG_ARM64_RELOC_TEST=m
CONFIG_CORESIGHT=y
CONFIG_CORESIGHT_LINKS_AND_SINKS=m
CONFIG_CORESIGHT_LINK_AND_SINK_TMC=m
# CONFIG_CORESIGHT_CATU is not set
# CONFIG_CORESIGHT_SINK_TPIU is not set
CONFIG_CORESIGHT_SINK_ETBV10=m
# CONFIG_CORESIGHT_SOURCE_ETM4X is not set
# CONFIG_CORESIGHT_STM is not set
CONFIG_CORESIGHT_CPU_DEBUG=y
# CONFIG_CORESIGHT_CPU_DEBUG_DEFAULT_ON is not set
CONFIG_CORESIGHT_CTI=m
# CONFIG_CORESIGHT_CTI_INTEGRATION_REGS is not set
# end of arm64 Debugging

#
# Kernel Testing and Coverage
#
CONFIG_KUNIT=y
CONFIG_KUNIT_DEBUGFS=y
CONFIG_KUNIT_TEST=y
CONFIG_KUNIT_EXAMPLE_TEST=y
CONFIG_KUNIT_ALL_TESTS=y
# CONFIG_KUNIT_DEFAULT_ENABLED is not set
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
CONFIG_FAULT_INJECTION=y
CONFIG_FAIL_PAGE_ALLOC=y
CONFIG_FAULT_INJECTION_USERCOPY=y
# CONFIG_FAULT_INJECTION_DEBUG_FS is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_KCOV is not set
CONFIG_RUNTIME_TESTING_MENU=y
# CONFIG_LKDTM is not set
CONFIG_CPUMASK_KUNIT_TEST=y
CONFIG_TEST_LIST_SORT=y
CONFIG_TEST_MIN_HEAP=y
CONFIG_TEST_SORT=y
# CONFIG_TEST_DIV64 is not set
CONFIG_KPROBES_SANITY_TEST=y
CONFIG_BACKTRACE_SELF_TEST=y
CONFIG_TEST_REF_TRACKER=y
CONFIG_RBTREE_TEST=m
# CONFIG_REED_SOLOMON_TEST is not set
CONFIG_INTERVAL_TREE_TEST=y
# CONFIG_PERCPU_TEST is not set
CONFIG_ATOMIC64_SELFTEST=y
CONFIG_TEST_HEXDUMP=y
# CONFIG_STRING_SELFTEST is not set
CONFIG_TEST_STRING_HELPERS=y
# CONFIG_TEST_STRSCPY is not set
# CONFIG_TEST_KSTRTOX is not set
# CONFIG_TEST_PRINTF is not set
# CONFIG_TEST_SCANF is not set
CONFIG_TEST_BITMAP=m
CONFIG_TEST_UUID=m
# CONFIG_TEST_XARRAY is not set
CONFIG_TEST_RHASHTABLE=y
# CONFIG_TEST_SIPHASH is not set
CONFIG_TEST_IDA=y
CONFIG_TEST_PARMAN=m
CONFIG_TEST_LKM=m
# CONFIG_TEST_BITOPS is not set
# CONFIG_TEST_VMALLOC is not set
CONFIG_TEST_USER_COPY=m
CONFIG_TEST_BPF=m
CONFIG_TEST_BLACKHOLE_DEV=m
# CONFIG_FIND_BIT_BENCHMARK is not set
# CONFIG_TEST_FIRMWARE is not set
CONFIG_TEST_SYSCTL=m
CONFIG_BITFIELD_KUNIT=y
CONFIG_HASH_KUNIT_TEST=y
CONFIG_RESOURCE_KUNIT_TEST=y
CONFIG_SYSCTL_KUNIT_TEST=y
CONFIG_LIST_KUNIT_TEST=y
# CONFIG_LINEAR_RANGES_TEST is not set
CONFIG_CMDLINE_KUNIT_TEST=y
CONFIG_BITS_TEST=y
CONFIG_RATIONAL_KUNIT_TEST=y
CONFIG_MEMCPY_KUNIT_TEST=y
CONFIG_IS_SIGNED_TYPE_KUNIT_TEST=y
CONFIG_OVERFLOW_KUNIT_TEST=y
CONFIG_STACKINIT_KUNIT_TEST=y
CONFIG_HW_BREAKPOINT_KUNIT_TEST=y
CONFIG_TEST_UDELAY=m
CONFIG_TEST_STATIC_KEYS=m
CONFIG_TEST_DEBUG_VIRTUAL=m
# CONFIG_TEST_MEMCAT_P is not set
CONFIG_TEST_MEMINIT=y
# CONFIG_TEST_FREE_PAGES is not set
CONFIG_ARCH_USE_MEMTEST=y
CONFIG_MEMTEST=y
# end of Kernel Testing and Coverage

#
# Rust hacking
#
# end of Rust hacking

# CONFIG_WARN_MISSING_DOCUMENTS is not set
CONFIG_WARN_ABI_ERRORS=y
# end of Kernel hacking

--P8tatnxojuL4V9YI--
