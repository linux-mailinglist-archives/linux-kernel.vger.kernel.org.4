Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D29B68B66E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 08:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjBFHbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 02:31:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjBFHbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 02:31:14 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 709731D914
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 23:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675668632; x=1707204632;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Ew9mQOD2SUdOWhU+QXqyGkLGgTopZBNTT6QXB8ioYRA=;
  b=PDp1Q5AQ60ZKm7naz2OtF1KFu/vj/kdQ+SbQRrxuLAZC6B7KDmiM99Wk
   RI/fr1VAOkVsx3S28VbL8D5OAi9ZrRgcKpYE2nuybN3O2yfMT7kGWiO3h
   coqYbTifF6+CxWjbTrpnhPqxCWb7fNoAnfn6sQ89hcZ0YTRpk2imCqw+X
   4IuhE8U0xEqmI14BeXQxxe/wfbZsJc2G7tf72YNjZI7jiheW1o6tshQxy
   OXlK+qUNqJgZz/h1fF2cyRlgvTul4BQqO6HkyD1YGCglXgnPPoo4cD/kC
   lGorZk8o+trPQwNR86OKVXFeFbyud4LDfPkIQmsRCBnEIJWXkbk4Gi6Ir
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10612"; a="391543781"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="391543781"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2023 23:29:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10612"; a="735020581"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="735020581"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 05 Feb 2023 23:29:51 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pOvwk-0002RA-38;
        Mon, 06 Feb 2023 07:29:50 +0000
Date:   Mon, 6 Feb 2023 15:29:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ao Zhong <hacc1225@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn20/display_mode_vba_20.c:3900:72:
 warning: implicit conversion from 'enum <anonymous>' to 'enum
 odm_combine_mode'
Message-ID: <202302061508.SaSd0vyR-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ao,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d2d11f342b179f1894a901f143ec7c008caba43e
commit: 79b72db63392d35a4dbcd4743b95cb668691f790 drm/amd/display: add DCN support for ARM64
date:   3 months ago
config: arm64-randconfig-r002-20230205 (https://download.01.org/0day-ci/archive/20230206/202302061508.SaSd0vyR-lkp@intel.com/config)
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
https://github.com/intel/lkp-tests
