Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9BF45BF528
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 06:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbiIUEKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 00:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbiIUEKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 00:10:01 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6638C2252F;
        Tue, 20 Sep 2022 21:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663733400; x=1695269400;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=hT/xxJgmB78upBO2MMumcCqTjWDfGIVZECB7QjTj1Bg=;
  b=aSthVHx7FE2MqughZuUfBhnKpbSfAgQDAFBR9fgYISJ9LHAA3uxVCN0T
   ilVyFJKs2sTBimqjHdbcZ175PjYd9MUDpzvimWRc+f7VViDNtJPR1xTiN
   0V+FRHCkMkPxb/Nm9bdKJ2QitSQ88vZVhVR/or7sPd0fbZJ22oaPDyZNQ
   hvpEHasJ/B7RB95hVdbioukZlOsZrG7a6LmQP/GONQvFnofVXdOQR+VG1
   fMG1qCq0FkOrR2aBGtptbUxiEL9Xr/sWVd7QCKT2fgsSnF50TFi4qcGIn
   PAQNZu2YGkKYStugcJ3GoIyTBmxpbg5URpqdMQpN5Wc7s/GMbTO41hhRF
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10476"; a="299879250"
X-IronPort-AV: E=Sophos;i="5.93,332,1654585200"; 
   d="scan'208";a="299879250"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 21:10:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,332,1654585200"; 
   d="scan'208";a="687706181"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 20 Sep 2022 21:09:58 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oar3d-0003De-1Z;
        Wed, 21 Sep 2022 04:09:57 +0000
Date:   Wed, 21 Sep 2022 12:09:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     George Shen <george.shen@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Alvin Lee <alvin.lee2@amd.com>,
        Nevenko Stupar <Nevenko.Stupar@amd.com>,
        linux-doc@vger.kernel.org
Subject: [agd5f:drm-next 131/170]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/dcn32_fpu.c:247: warning:
 This comment starts with '/**', but isn't a kernel-doc comment. Refer
 Documentation/doc-guide/kernel-doc.rst
Message-ID: <202209211226.co3Q4sTH-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://gitlab.freedesktop.org/agd5f/linux.git drm-next
head:   48c35c428c7feb06761dbc398139eb7e697c6608
commit: f57da8c04f183f90cd450a5d5142109fba340417 [131/170] drm/amd/display: Update dummy P-state search to use DCN32 DML
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220921/202209211226.co3Q4sTH-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=1 build):
        git remote add agd5f https://gitlab.freedesktop.org/agd5f/linux.git
        git fetch --no-tags agd5f drm-next
        git checkout f57da8c04f183f90cd450a5d5142109fba340417
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/dcn32_fpu.c:247: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Finds dummy_latency_index when MCLK switching using firmware based
   drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/dcn32_fpu.c:334: warning: Cannot understand  * *******************************************************************************************
    on line 334 - I thought it was a doc line
   drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/dcn32_fpu.c:535: warning: Function parameter or member 'phantom_stream' not described in 'dcn32_set_phantom_stream_timing'
   drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/dcn32_fpu.c:652: warning: Function parameter or member 'dc' not described in 'dcn32_assign_subvp_pipe'
   drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/dcn32_fpu.c:652: warning: Function parameter or member 'context' not described in 'dcn32_assign_subvp_pipe'
   drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/dcn32_fpu.c:652: warning: Function parameter or member 'index' not described in 'dcn32_assign_subvp_pipe'
   drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/dcn32_fpu.c:2221: warning: Function parameter or member 'dc' not described in 'dcn32_update_bw_bounding_box_fpu'
   drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/dcn32_fpu.c:2221: warning: Function parameter or member 'bw_params' not described in 'dcn32_update_bw_bounding_box_fpu'
   drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/dcn32_fpu.c:2221: warning: expecting prototype for dcn32_update_bw_bounding_box(). Prototype was for dcn32_update_bw_bounding_box_fpu() instead


vim +247 drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/dcn32_fpu.c

   245	
   246	/**
 > 247	 * Finds dummy_latency_index when MCLK switching using firmware based
   248	 * vblank stretch is enabled. This function will iterate through the
   249	 * table of dummy pstate latencies until the lowest value that allows
   250	 * dm_allow_self_refresh_and_mclk_switch to happen is found
   251	 */
   252	int dcn32_find_dummy_latency_index_for_fw_based_mclk_switch(struct dc *dc,
   253								    struct dc_state *context,
   254								    display_e2e_pipe_params_st *pipes,
   255								    int pipe_cnt,
   256								    int vlevel)
   257	{
   258		const int max_latency_table_entries = 4;
   259		const struct vba_vars_st *vba = &context->bw_ctx.dml.vba;
   260		int dummy_latency_index = 0;
   261	
   262		dc_assert_fp_enabled();
   263	
   264		while (dummy_latency_index < max_latency_table_entries) {
   265			context->bw_ctx.dml.soc.dram_clock_change_latency_us =
   266					dc->clk_mgr->bw_params->dummy_pstate_table[dummy_latency_index].dummy_pstate_latency_us;
   267			dcn32_internal_validate_bw(dc, context, pipes, &pipe_cnt, &vlevel, false);
   268	
   269			if (vlevel < context->bw_ctx.dml.vba.soc.num_states &&
   270					vba->DRAMClockChangeSupport[vlevel][vba->maxMpcComb] != dm_dram_clock_change_unsupported)
   271				break;
   272	
   273			dummy_latency_index++;
   274		}
   275	
   276		if (dummy_latency_index == max_latency_table_entries) {
   277			ASSERT(dummy_latency_index != max_latency_table_entries);
   278			/* If the execution gets here, it means dummy p_states are
   279			 * not possible. This should never happen and would mean
   280			 * something is severely wrong.
   281			 * Here we reset dummy_latency_index to 3, because it is
   282			 * better to have underflows than system crashes.
   283			 */
   284			dummy_latency_index = max_latency_table_entries - 1;
   285		}
   286	
   287		return dummy_latency_index;
   288	}
   289	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
