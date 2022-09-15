Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5629A5B91F2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 02:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbiIOA4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 20:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiIOA4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 20:56:18 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF0F17C75B
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 17:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663203377; x=1694739377;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=72PhN9JgoB4YcbNMnu1JZnOr4vQsl+lBbU038pQ0ITY=;
  b=ibseV88SOwpUJKcpkqjsCzDWAsuZ7pedOxrS4ISJbrajhVpIJ814rMag
   uNq+S9XqOWT4YXubOjIt18mycarmmTYF+WhAqB9OfYvxFekFiKMijJDQF
   /UPZKJG7mmSF0l9IW3Qrz1QR3ZOPQkMCwI5GMBhlP/Mkf3MOSPFeZbXQz
   /mf8tyzN+bF0yTXFMt1n899feKXSxNY0EyaXx/YBTo7oONqer97CNNEJn
   hMweVeCJveJnj1sB6vaDyoWBmQjIhdAu1EXAFKtAtmF6ickiKYV14vnlp
   IvFls+6WA5LU7QQwcLiwdGcBhzoItYC3vVSOFN9jvDpDR69rNxT60DV2F
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10470"; a="299938780"
X-IronPort-AV: E=Sophos;i="5.93,316,1654585200"; 
   d="scan'208";a="299938780"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 17:56:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,316,1654585200"; 
   d="scan'208";a="759426349"
Received: from lkp-server01.sh.intel.com (HELO d6e6b7c4e5a2) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 14 Sep 2022 17:56:04 -0700
Received: from kbuild by d6e6b7c4e5a2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oYdAh-0000k8-16;
        Thu, 15 Sep 2022 00:56:03 +0000
Date:   Thu, 15 Sep 2022 08:55:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     =?iso-8859-1?Q?Ma=EDra?= Canal <mairacanal@riseup.net>,
        Alex Deucher <alexander.deucher@amd.com>,
        christian.koenig@amd.com, Xinhui.Pan@amd.com,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Nicholas Choi <nicholas.choi@amd.com>,
        Daniel Latypov <dlatypov@google.com>,
        David Gow <davidgow@google.com>
Cc:     kbuild-all@lists.01.org, kunit-dev@googlegroups.com,
        magalilemes00@gmail.com, tales.aparecida@gmail.com,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        mwen@igalia.com,
        =?iso-8859-1?Q?Ma=EDra?= Canal <mairacanal@riseup.net>,
        dri-devel@lists.freedesktop.org,
        Isabella Basso <isabbasso@riseup.net>, andrealmeid@riseup.net
Subject: Re: [PATCH v3 7/8] drm/amd/display: Introduce KUnit tests to
 dc_dmub_srv library
Message-ID: <202209150834.M0BeSpLy-lkp@intel.com>
References: <20220912155919.39877-8-mairacanal@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220912155919.39877-8-mairacanal@riseup.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maíra,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on drm/drm-next]
[also build test ERROR on drm-intel/for-linux-next drm-tip/drm-tip linus/master v6.0-rc5 next-20220914]
[cannot apply to drm-misc/drm-misc-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ma-ra-Canal/drm-amd-display-Introduce-KUnit-to-Display-Mode-Library/20220913-000256
base:   git://anongit.freedesktop.org/drm/drm drm-next
config: loongarch-randconfig-r026-20220914 (https://download.01.org/0day-ci/archive/20220915/202209150834.M0BeSpLy-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/50e2391775a6552a521c783a6fcd36942b906e3f
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Ma-ra-Canal/drm-amd-display-Introduce-KUnit-to-Display-Mode-Library/20220913-000256
        git checkout 50e2391775a6552a521c783a6fcd36942b906e3f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=loongarch SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:863:
   drivers/gpu/drm/amd/amdgpu/../display/dc/../tests/dc/dc_dmub_srv_test.c: In function 'populate_subvp_cmd_drr_info_test':
>> drivers/gpu/drm/amd/amdgpu/../display/dc/../tests/dc/dc_dmub_srv_test.c:260:9: error: implicit declaration of function 'populate_subvp_cmd_drr_info'; did you mean 'populate_subvp_cmd_drr_info_test'? [-Werror=implicit-function-declaration]
     260 |         populate_subvp_cmd_drr_info(test_param->dc, test_param->subvp_pipe,
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
         |         populate_subvp_cmd_drr_info_test
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/core_types.h:32,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:31:
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h: At top level:
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:137:22: warning: 'SYNAPTICS_DEVICE_ID' defined but not used [-Wunused-const-variable=]
     137 | static const uint8_t SYNAPTICS_DEVICE_ID[] = "SYNA";
         |                      ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:134:17: warning: 'DP_SINK_BRANCH_DEV_NAME_7580' defined but not used [-Wunused-const-variable=]
     134 | static const u8 DP_SINK_BRANCH_DEV_NAME_7580[] = "7580\x80u";
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:132:22: warning: 'DP_SINK_DEVICE_STR_ID_2' defined but not used [-Wunused-const-variable=]
     132 | static const uint8_t DP_SINK_DEVICE_STR_ID_2[] = {7, 1, 8, 7, 5, 0};
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:131:22: warning: 'DP_SINK_DEVICE_STR_ID_1' defined but not used [-Wunused-const-variable=]
     131 | static const uint8_t DP_SINK_DEVICE_STR_ID_1[] = {7, 1, 8, 7, 3, 0};
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +260 drivers/gpu/drm/amd/amdgpu/../display/dc/../tests/dc/dc_dmub_srv_test.c

   246	
   247	KUNIT_ARRAY_PARAM(populate_subvp_cmd_drr_info, populate_subvp_cmd_drr_info_cases,
   248			  populate_subvp_cmd_drr_info_test_to_desc);
   249	
   250	static void populate_subvp_cmd_drr_info_test(struct kunit *test)
   251	{
   252		const struct populate_subvp_cmd_drr_info_test_case *test_param =
   253			test->param_value;
   254		struct dmub_cmd_fw_assisted_mclk_switch_pipe_data_v2 *pipe_data;
   255	
   256		pipe_data = kunit_kzalloc(test,
   257					  sizeof(struct dmub_cmd_fw_assisted_mclk_switch_pipe_data_v2),
   258					  GFP_KERNEL);
   259	
 > 260		populate_subvp_cmd_drr_info(test_param->dc, test_param->subvp_pipe,
   261					    test_param->vblank_pipe, pipe_data);
   262	
   263		KUNIT_EXPECT_EQ(test, test_param->drr_in_use,
   264				pipe_data->pipe_config.vblank_data.drr_info.drr_in_use);
   265		KUNIT_EXPECT_EQ(test, test_param->drr_window_size_ms,
   266				pipe_data->pipe_config.vblank_data.drr_info.drr_window_size_ms);
   267		KUNIT_EXPECT_EQ(test, test_param->use_ramping,
   268				pipe_data->pipe_config.vblank_data.drr_info.use_ramping);
   269		KUNIT_EXPECT_EQ(test, test_param->min_vtotal_supported,
   270				pipe_data->pipe_config.vblank_data.drr_info.min_vtotal_supported);
   271		KUNIT_EXPECT_EQ(test, test_param->max_vtotal_supported,
   272				pipe_data->pipe_config.vblank_data.drr_info.max_vtotal_supported);
   273	}
   274	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
