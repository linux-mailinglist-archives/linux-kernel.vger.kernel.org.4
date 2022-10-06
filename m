Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1895F5FBF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 05:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbiJFDqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 23:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbiJFDpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 23:45:53 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E68641519
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 20:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665027947; x=1696563947;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9uYSZQVV0eMYBm5dsyRb4mXk7g6yxrlOaG005yXHFek=;
  b=LfVofurUUBTqpMtSNLjoiiz+96w/pFedyFL2lTOWFto/F/2pyt69LHdP
   TPmuUOemrvZgRAX/0czID5jGYALqI+VoEB2VIx826dYI1wNdsGjPuXlaV
   mIpCp223jBWhKbhskOBqKxBsuppQZGQVdPShZRB0vwpM8Mwh6kPezJeAV
   Nkwim2ctD0uPtEmHKzicgJ2ZOlK9fIqGwuJYfn1JQXUkqxHsKoBzIOi8w
   YGq/1kSAhumNl2EXHc+VTrowQyPO7O2qNlR4o5FQiIkxatEHsf832WbEi
   4gEdymi5KTRuKwGAUg20I1YIfZ1SNnOL2oHl9FYboY/NZS0X+X1qlCwLF
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="300935323"
X-IronPort-AV: E=Sophos;i="5.95,162,1661842800"; 
   d="scan'208";a="300935323"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2022 20:45:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="713680299"
X-IronPort-AV: E=Sophos;i="5.95,162,1661842800"; 
   d="scan'208";a="713680299"
Received: from lkp-server01.sh.intel.com (HELO d4f44333118a) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 05 Oct 2022 20:45:43 -0700
Received: from kbuild by d4f44333118a with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ogHpP-0001rf-0A;
        Thu, 06 Oct 2022 03:45:43 +0000
Date:   Thu, 6 Oct 2022 11:45:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn314/display_rq_dlg_calc_314.c:1004:15:
 warning: variable 'dppclk_delay_subtotal' set but not used
Message-ID: <202210061101.qhJWmyqG-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="lfMMhuJdLSP5mfuz"
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lfMMhuJdLSP5mfuz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   833477fce7a14d43ae4c07f8ddc32fa5119471a2
commit: af2f2a256e048f1b83605eaae49948e4a6811ac1 drm/amd/display: Enable dlg and vba compilation for dcn314
date:   3 weeks ago
config: x86_64-buildonly-randconfig-r005-20221003
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=af2f2a256e048f1b83605eaae49948e4a6811ac1
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout af2f2a256e048f1b83605eaae49948e4a6811ac1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn314/display_rq_dlg_calc_314.c:1004:15: warning: variable 'dppclk_delay_subtotal' set but not used [-Wunused-but-set-variable]
           unsigned int dppclk_delay_subtotal;
                        ^
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn314/display_rq_dlg_calc_314.c:1005:15: warning: variable 'dispclk_delay_subtotal' set but not used [-Wunused-but-set-variable]
           unsigned int dispclk_delay_subtotal;
                        ^
   2 warnings generated.


vim +/dppclk_delay_subtotal +1004 drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn314/display_rq_dlg_calc_314.c

41529d79ce1655 Roman Li 2022-06-28   934  
41529d79ce1655 Roman Li 2022-06-28   935  // Note: currently taken in as is.
41529d79ce1655 Roman Li 2022-06-28   936  // Nice to decouple code from hw register implement and extract code that are repeated for luma and chroma.
41529d79ce1655 Roman Li 2022-06-28   937  static void dml_rq_dlg_get_dlg_params(
41529d79ce1655 Roman Li 2022-06-28   938  		struct display_mode_lib *mode_lib,
41529d79ce1655 Roman Li 2022-06-28   939  		const display_e2e_pipe_params_st *e2e_pipe_param,
41529d79ce1655 Roman Li 2022-06-28   940  		const unsigned int num_pipes,
41529d79ce1655 Roman Li 2022-06-28   941  		const unsigned int pipe_idx,
41529d79ce1655 Roman Li 2022-06-28   942  		display_dlg_regs_st *disp_dlg_regs,
41529d79ce1655 Roman Li 2022-06-28   943  		display_ttu_regs_st *disp_ttu_regs,
41529d79ce1655 Roman Li 2022-06-28   944  		const display_rq_dlg_params_st *rq_dlg_param,
41529d79ce1655 Roman Li 2022-06-28   945  		const display_dlg_sys_params_st *dlg_sys_param,
41529d79ce1655 Roman Li 2022-06-28   946  		const bool cstate_en,
41529d79ce1655 Roman Li 2022-06-28   947  		const bool pstate_en,
41529d79ce1655 Roman Li 2022-06-28   948  		const bool vm_en,
41529d79ce1655 Roman Li 2022-06-28   949  		const bool ignore_viewport_pos,
41529d79ce1655 Roman Li 2022-06-28   950  		const bool immediate_flip_support)
41529d79ce1655 Roman Li 2022-06-28   951  {
41529d79ce1655 Roman Li 2022-06-28   952  	const display_pipe_source_params_st *src = &e2e_pipe_param[pipe_idx].pipe.src;
41529d79ce1655 Roman Li 2022-06-28   953  	const display_pipe_dest_params_st *dst = &e2e_pipe_param[pipe_idx].pipe.dest;
41529d79ce1655 Roman Li 2022-06-28   954  	const display_output_params_st *dout = &e2e_pipe_param[pipe_idx].dout;
41529d79ce1655 Roman Li 2022-06-28   955  	const display_clocks_and_cfg_st *clks = &e2e_pipe_param[pipe_idx].clks_cfg;
41529d79ce1655 Roman Li 2022-06-28   956  	const scaler_ratio_depth_st *scl = &e2e_pipe_param[pipe_idx].pipe.scale_ratio_depth;
41529d79ce1655 Roman Li 2022-06-28   957  	const scaler_taps_st *taps = &e2e_pipe_param[pipe_idx].pipe.scale_taps;
41529d79ce1655 Roman Li 2022-06-28   958  	unsigned int pipe_index_in_combine[DC__NUM_PIPES__MAX];
41529d79ce1655 Roman Li 2022-06-28   959  
41529d79ce1655 Roman Li 2022-06-28   960  	// -------------------------
41529d79ce1655 Roman Li 2022-06-28   961  	// Section 1.15.2.1: OTG dependent Params
41529d79ce1655 Roman Li 2022-06-28   962  	// -------------------------
41529d79ce1655 Roman Li 2022-06-28   963  	// Timing
41529d79ce1655 Roman Li 2022-06-28   964  	unsigned int htotal = dst->htotal;
41529d79ce1655 Roman Li 2022-06-28   965  	unsigned int hblank_end = dst->hblank_end;
41529d79ce1655 Roman Li 2022-06-28   966  	unsigned int vblank_start = dst->vblank_start;
41529d79ce1655 Roman Li 2022-06-28   967  	unsigned int vblank_end = dst->vblank_end;
41529d79ce1655 Roman Li 2022-06-28   968  
41529d79ce1655 Roman Li 2022-06-28   969  	double dppclk_freq_in_mhz = clks->dppclk_mhz;
41529d79ce1655 Roman Li 2022-06-28   970  	double refclk_freq_in_mhz = clks->refclk_mhz;
41529d79ce1655 Roman Li 2022-06-28   971  	double pclk_freq_in_mhz = dst->pixel_rate_mhz;
41529d79ce1655 Roman Li 2022-06-28   972  	bool interlaced = dst->interlaced;
41529d79ce1655 Roman Li 2022-06-28   973  	double ref_freq_to_pix_freq = refclk_freq_in_mhz / pclk_freq_in_mhz;
41529d79ce1655 Roman Li 2022-06-28   974  	double min_ttu_vblank;
41529d79ce1655 Roman Li 2022-06-28   975  	unsigned int dlg_vblank_start;
41529d79ce1655 Roman Li 2022-06-28   976  	bool dual_plane;
41529d79ce1655 Roman Li 2022-06-28   977  	bool mode_422;
41529d79ce1655 Roman Li 2022-06-28   978  	unsigned int access_dir;
41529d79ce1655 Roman Li 2022-06-28   979  	unsigned int vp_height_l;
41529d79ce1655 Roman Li 2022-06-28   980  	unsigned int vp_width_l;
41529d79ce1655 Roman Li 2022-06-28   981  	unsigned int vp_height_c;
41529d79ce1655 Roman Li 2022-06-28   982  	unsigned int vp_width_c;
41529d79ce1655 Roman Li 2022-06-28   983  
41529d79ce1655 Roman Li 2022-06-28   984  	// Scaling
41529d79ce1655 Roman Li 2022-06-28   985  	unsigned int htaps_l;
41529d79ce1655 Roman Li 2022-06-28   986  	unsigned int htaps_c;
41529d79ce1655 Roman Li 2022-06-28   987  	double hratio_l;
41529d79ce1655 Roman Li 2022-06-28   988  	double hratio_c;
41529d79ce1655 Roman Li 2022-06-28   989  	double vratio_l;
41529d79ce1655 Roman Li 2022-06-28   990  	double vratio_c;
41529d79ce1655 Roman Li 2022-06-28   991  	bool scl_enable;
41529d79ce1655 Roman Li 2022-06-28   992  
41529d79ce1655 Roman Li 2022-06-28   993  	unsigned int swath_width_ub_l;
41529d79ce1655 Roman Li 2022-06-28   994  	unsigned int dpte_groups_per_row_ub_l;
41529d79ce1655 Roman Li 2022-06-28   995  	unsigned int swath_width_ub_c;
41529d79ce1655 Roman Li 2022-06-28   996  	unsigned int dpte_groups_per_row_ub_c;
41529d79ce1655 Roman Li 2022-06-28   997  
41529d79ce1655 Roman Li 2022-06-28   998  	unsigned int meta_chunks_per_row_ub_l;
41529d79ce1655 Roman Li 2022-06-28   999  	unsigned int meta_chunks_per_row_ub_c;
41529d79ce1655 Roman Li 2022-06-28  1000  	unsigned int vupdate_offset;
41529d79ce1655 Roman Li 2022-06-28  1001  	unsigned int vupdate_width;
41529d79ce1655 Roman Li 2022-06-28  1002  	unsigned int vready_offset;
41529d79ce1655 Roman Li 2022-06-28  1003  
41529d79ce1655 Roman Li 2022-06-28 @1004  	unsigned int dppclk_delay_subtotal;
41529d79ce1655 Roman Li 2022-06-28 @1005  	unsigned int dispclk_delay_subtotal;
41529d79ce1655 Roman Li 2022-06-28  1006  
41529d79ce1655 Roman Li 2022-06-28  1007  	unsigned int vstartup_start;
41529d79ce1655 Roman Li 2022-06-28  1008  	unsigned int dst_x_after_scaler;
41529d79ce1655 Roman Li 2022-06-28  1009  	unsigned int dst_y_after_scaler;
41529d79ce1655 Roman Li 2022-06-28  1010  	double dst_y_prefetch;
41529d79ce1655 Roman Li 2022-06-28  1011  	double dst_y_per_vm_vblank;
41529d79ce1655 Roman Li 2022-06-28  1012  	double dst_y_per_row_vblank;
41529d79ce1655 Roman Li 2022-06-28  1013  	double dst_y_per_vm_flip;
41529d79ce1655 Roman Li 2022-06-28  1014  	double dst_y_per_row_flip;
41529d79ce1655 Roman Li 2022-06-28  1015  	double max_dst_y_per_vm_vblank;
41529d79ce1655 Roman Li 2022-06-28  1016  	double max_dst_y_per_row_vblank;
41529d79ce1655 Roman Li 2022-06-28  1017  	double vratio_pre_l;
41529d79ce1655 Roman Li 2022-06-28  1018  	double vratio_pre_c;
41529d79ce1655 Roman Li 2022-06-28  1019  	unsigned int req_per_swath_ub_l;
41529d79ce1655 Roman Li 2022-06-28  1020  	unsigned int req_per_swath_ub_c;
41529d79ce1655 Roman Li 2022-06-28  1021  	unsigned int meta_row_height_l;
41529d79ce1655 Roman Li 2022-06-28  1022  	unsigned int meta_row_height_c;
41529d79ce1655 Roman Li 2022-06-28  1023  	unsigned int swath_width_pixels_ub_l;
41529d79ce1655 Roman Li 2022-06-28  1024  	unsigned int swath_width_pixels_ub_c;
41529d79ce1655 Roman Li 2022-06-28  1025  	unsigned int scaler_rec_in_width_l;
41529d79ce1655 Roman Li 2022-06-28  1026  	unsigned int scaler_rec_in_width_c;
41529d79ce1655 Roman Li 2022-06-28  1027  	unsigned int dpte_row_height_l;
41529d79ce1655 Roman Li 2022-06-28  1028  	unsigned int dpte_row_height_c;
41529d79ce1655 Roman Li 2022-06-28  1029  	double hscale_pixel_rate_l;
41529d79ce1655 Roman Li 2022-06-28  1030  	double hscale_pixel_rate_c;
41529d79ce1655 Roman Li 2022-06-28  1031  	double min_hratio_fact_l;
41529d79ce1655 Roman Li 2022-06-28  1032  	double min_hratio_fact_c;
41529d79ce1655 Roman Li 2022-06-28  1033  	double refcyc_per_line_delivery_pre_l;
41529d79ce1655 Roman Li 2022-06-28  1034  	double refcyc_per_line_delivery_pre_c;
41529d79ce1655 Roman Li 2022-06-28  1035  	double refcyc_per_line_delivery_l;
41529d79ce1655 Roman Li 2022-06-28  1036  	double refcyc_per_line_delivery_c;
41529d79ce1655 Roman Li 2022-06-28  1037  
41529d79ce1655 Roman Li 2022-06-28  1038  	double refcyc_per_req_delivery_pre_l;
41529d79ce1655 Roman Li 2022-06-28  1039  	double refcyc_per_req_delivery_pre_c;
41529d79ce1655 Roman Li 2022-06-28  1040  	double refcyc_per_req_delivery_l;
41529d79ce1655 Roman Li 2022-06-28  1041  	double refcyc_per_req_delivery_c;
41529d79ce1655 Roman Li 2022-06-28  1042  
41529d79ce1655 Roman Li 2022-06-28  1043  	unsigned int full_recout_width;
41529d79ce1655 Roman Li 2022-06-28  1044  	double refcyc_per_req_delivery_pre_cur0;
41529d79ce1655 Roman Li 2022-06-28  1045  	double refcyc_per_req_delivery_cur0;
41529d79ce1655 Roman Li 2022-06-28  1046  	double refcyc_per_req_delivery_pre_cur1;
41529d79ce1655 Roman Li 2022-06-28  1047  	double refcyc_per_req_delivery_cur1;
41529d79ce1655 Roman Li 2022-06-28  1048  	unsigned int vba__min_dst_y_next_start = get_min_dst_y_next_start(mode_lib, e2e_pipe_param, num_pipes, pipe_idx); // FROM VBA
41529d79ce1655 Roman Li 2022-06-28  1049  	unsigned int vba__vready_after_vcount0 = get_vready_at_or_after_vsync(mode_lib, e2e_pipe_param, num_pipes, pipe_idx); // From VBA
41529d79ce1655 Roman Li 2022-06-28  1050  
41529d79ce1655 Roman Li 2022-06-28  1051  	float vba__refcyc_per_line_delivery_pre_l = get_refcyc_per_line_delivery_pre_l_in_us(mode_lib, e2e_pipe_param, num_pipes, pipe_idx) * refclk_freq_in_mhz; // From VBA
41529d79ce1655 Roman Li 2022-06-28  1052  	float vba__refcyc_per_line_delivery_l = get_refcyc_per_line_delivery_l_in_us(mode_lib, e2e_pipe_param, num_pipes, pipe_idx) * refclk_freq_in_mhz; // From VBA
41529d79ce1655 Roman Li 2022-06-28  1053  
41529d79ce1655 Roman Li 2022-06-28  1054  	float vba__refcyc_per_req_delivery_pre_l = get_refcyc_per_req_delivery_pre_l_in_us(mode_lib, e2e_pipe_param, num_pipes, pipe_idx) * refclk_freq_in_mhz;  // From VBA
41529d79ce1655 Roman Li 2022-06-28  1055  	float vba__refcyc_per_req_delivery_l = get_refcyc_per_req_delivery_l_in_us(mode_lib, e2e_pipe_param, num_pipes, pipe_idx) * refclk_freq_in_mhz;  // From VBA
41529d79ce1655 Roman Li 2022-06-28  1056  	int blank_lines = 0;
41529d79ce1655 Roman Li 2022-06-28  1057  
41529d79ce1655 Roman Li 2022-06-28  1058  	memset(disp_dlg_regs, 0, sizeof(*disp_dlg_regs));
41529d79ce1655 Roman Li 2022-06-28  1059  	memset(disp_ttu_regs, 0, sizeof(*disp_ttu_regs));
41529d79ce1655 Roman Li 2022-06-28  1060  
41529d79ce1655 Roman Li 2022-06-28  1061  	dml_print("DML_DLG: %s: cstate_en = %d\n", __func__, cstate_en);
41529d79ce1655 Roman Li 2022-06-28  1062  	dml_print("DML_DLG: %s: pstate_en = %d\n", __func__, pstate_en);
41529d79ce1655 Roman Li 2022-06-28  1063  	dml_print("DML_DLG: %s: vm_en     = %d\n", __func__, vm_en);
41529d79ce1655 Roman Li 2022-06-28  1064  	dml_print("DML_DLG: %s: ignore_viewport_pos  = %d\n", __func__, ignore_viewport_pos);
41529d79ce1655 Roman Li 2022-06-28  1065  	dml_print("DML_DLG: %s: immediate_flip_support  = %d\n", __func__, immediate_flip_support);
41529d79ce1655 Roman Li 2022-06-28  1066  
41529d79ce1655 Roman Li 2022-06-28  1067  	dml_print("DML_DLG: %s: dppclk_freq_in_mhz     = %3.2f\n", __func__, dppclk_freq_in_mhz);
41529d79ce1655 Roman Li 2022-06-28  1068  	dml_print("DML_DLG: %s: refclk_freq_in_mhz     = %3.2f\n", __func__, refclk_freq_in_mhz);
41529d79ce1655 Roman Li 2022-06-28  1069  	dml_print("DML_DLG: %s: pclk_freq_in_mhz       = %3.2f\n", __func__, pclk_freq_in_mhz);
41529d79ce1655 Roman Li 2022-06-28  1070  	dml_print("DML_DLG: %s: interlaced             = %d\n", __func__, interlaced); ASSERT(ref_freq_to_pix_freq < 4.0);
41529d79ce1655 Roman Li 2022-06-28  1071  
41529d79ce1655 Roman Li 2022-06-28  1072  	disp_dlg_regs->ref_freq_to_pix_freq = (unsigned int) (ref_freq_to_pix_freq * dml_pow(2, 19));
41529d79ce1655 Roman Li 2022-06-28  1073  	disp_dlg_regs->refcyc_per_htotal = (unsigned int) (ref_freq_to_pix_freq * (double) htotal * dml_pow(2, 8));
41529d79ce1655 Roman Li 2022-06-28  1074  	disp_dlg_regs->dlg_vblank_end = interlaced ? (vblank_end / 2) : vblank_end;	// 15 bits
41529d79ce1655 Roman Li 2022-06-28  1075  
41529d79ce1655 Roman Li 2022-06-28  1076  	//set_prefetch_mode(mode_lib, cstate_en, pstate_en, ignore_viewport_pos, immediate_flip_support);
41529d79ce1655 Roman Li 2022-06-28  1077  	min_ttu_vblank = get_min_ttu_vblank_in_us(mode_lib, e2e_pipe_param, num_pipes, pipe_idx);	// From VBA
41529d79ce1655 Roman Li 2022-06-28  1078  
41529d79ce1655 Roman Li 2022-06-28  1079  	dlg_vblank_start = interlaced ? (vblank_start / 2) : vblank_start;
41529d79ce1655 Roman Li 2022-06-28  1080  	disp_dlg_regs->optimized_min_dst_y_next_start = disp_dlg_regs->min_dst_y_next_start;
41529d79ce1655 Roman Li 2022-06-28  1081  	disp_dlg_regs->optimized_min_dst_y_next_start_us = 0;
41529d79ce1655 Roman Li 2022-06-28  1082  	disp_dlg_regs->min_dst_y_next_start = (unsigned int) (((double) dlg_vblank_start) * dml_pow(2, 2));
41529d79ce1655 Roman Li 2022-06-28  1083  	blank_lines = (dst->vblank_end + dst->vtotal_min - dst->vblank_start - dst->vstartup_start - 1);
41529d79ce1655 Roman Li 2022-06-28  1084  	if (blank_lines < 0)
41529d79ce1655 Roman Li 2022-06-28  1085  		blank_lines = 0;
41529d79ce1655 Roman Li 2022-06-28  1086  	if (blank_lines != 0) {
41529d79ce1655 Roman Li 2022-06-28  1087  		disp_dlg_regs->optimized_min_dst_y_next_start = vba__min_dst_y_next_start;
41529d79ce1655 Roman Li 2022-06-28  1088  		disp_dlg_regs->optimized_min_dst_y_next_start_us = (disp_dlg_regs->optimized_min_dst_y_next_start * dst->hactive) / (unsigned int) dst->pixel_rate_mhz;
41529d79ce1655 Roman Li 2022-06-28  1089  		disp_dlg_regs->min_dst_y_next_start = disp_dlg_regs->optimized_min_dst_y_next_start;
41529d79ce1655 Roman Li 2022-06-28  1090  	}
41529d79ce1655 Roman Li 2022-06-28  1091  	ASSERT(disp_dlg_regs->min_dst_y_next_start < (unsigned int)dml_pow(2, 18));
41529d79ce1655 Roman Li 2022-06-28  1092  
41529d79ce1655 Roman Li 2022-06-28  1093  	dml_print("DML_DLG: %s: min_ttu_vblank (us)         = %3.2f\n", __func__, min_ttu_vblank);
41529d79ce1655 Roman Li 2022-06-28  1094  	dml_print("DML_DLG: %s: min_dst_y_next_start        = 0x%0x\n", __func__, disp_dlg_regs->min_dst_y_next_start);
41529d79ce1655 Roman Li 2022-06-28  1095  	dml_print("DML_DLG: %s: dlg_vblank_start            = 0x%0x\n", __func__, dlg_vblank_start);
41529d79ce1655 Roman Li 2022-06-28  1096  	dml_print("DML_DLG: %s: ref_freq_to_pix_freq        = %3.2f\n", __func__, ref_freq_to_pix_freq);
41529d79ce1655 Roman Li 2022-06-28  1097  	dml_print("DML_DLG: %s: vba__min_dst_y_next_start   = 0x%0x\n", __func__, vba__min_dst_y_next_start);
41529d79ce1655 Roman Li 2022-06-28  1098  
41529d79ce1655 Roman Li 2022-06-28  1099  	//old_impl_vs_vba_impl("min_dst_y_next_start", dlg_vblank_start, vba__min_dst_y_next_start);
41529d79ce1655 Roman Li 2022-06-28  1100  
41529d79ce1655 Roman Li 2022-06-28  1101  	// -------------------------
41529d79ce1655 Roman Li 2022-06-28  1102  	// Section 1.15.2.2: Prefetch, Active and TTU
41529d79ce1655 Roman Li 2022-06-28  1103  	// -------------------------
41529d79ce1655 Roman Li 2022-06-28  1104  	// Prefetch Calc
41529d79ce1655 Roman Li 2022-06-28  1105  	// Source
41529d79ce1655 Roman Li 2022-06-28  1106  	dual_plane = is_dual_plane((enum source_format_class) (src->source_format));
41529d79ce1655 Roman Li 2022-06-28  1107  	mode_422 = 0;
41529d79ce1655 Roman Li 2022-06-28  1108  	access_dir = (src->source_scan == dm_vert);	// vp access direction: horizontal or vertical accessed
41529d79ce1655 Roman Li 2022-06-28  1109  	vp_height_l = src->viewport_height;
41529d79ce1655 Roman Li 2022-06-28  1110  	vp_width_l = src->viewport_width;
41529d79ce1655 Roman Li 2022-06-28  1111  	vp_height_c = src->viewport_height_c;
41529d79ce1655 Roman Li 2022-06-28  1112  	vp_width_c = src->viewport_width_c;
41529d79ce1655 Roman Li 2022-06-28  1113  
41529d79ce1655 Roman Li 2022-06-28  1114  	// Scaling
41529d79ce1655 Roman Li 2022-06-28  1115  	htaps_l = taps->htaps;
41529d79ce1655 Roman Li 2022-06-28  1116  	htaps_c = taps->htaps_c;
41529d79ce1655 Roman Li 2022-06-28  1117  	hratio_l = scl->hscl_ratio;
41529d79ce1655 Roman Li 2022-06-28  1118  	hratio_c = scl->hscl_ratio_c;
41529d79ce1655 Roman Li 2022-06-28  1119  	vratio_l = scl->vscl_ratio;
41529d79ce1655 Roman Li 2022-06-28  1120  	vratio_c = scl->vscl_ratio_c;
41529d79ce1655 Roman Li 2022-06-28  1121  	scl_enable = scl->scl_enable;
41529d79ce1655 Roman Li 2022-06-28  1122  
41529d79ce1655 Roman Li 2022-06-28  1123  	swath_width_ub_l = rq_dlg_param->rq_l.swath_width_ub;
41529d79ce1655 Roman Li 2022-06-28  1124  	dpte_groups_per_row_ub_l = rq_dlg_param->rq_l.dpte_groups_per_row_ub;
41529d79ce1655 Roman Li 2022-06-28  1125  	swath_width_ub_c = rq_dlg_param->rq_c.swath_width_ub;
41529d79ce1655 Roman Li 2022-06-28  1126  	dpte_groups_per_row_ub_c = rq_dlg_param->rq_c.dpte_groups_per_row_ub;
41529d79ce1655 Roman Li 2022-06-28  1127  
41529d79ce1655 Roman Li 2022-06-28  1128  	meta_chunks_per_row_ub_l = rq_dlg_param->rq_l.meta_chunks_per_row_ub;
41529d79ce1655 Roman Li 2022-06-28  1129  	meta_chunks_per_row_ub_c = rq_dlg_param->rq_c.meta_chunks_per_row_ub;
41529d79ce1655 Roman Li 2022-06-28  1130  	vupdate_offset = dst->vupdate_offset;
41529d79ce1655 Roman Li 2022-06-28  1131  	vupdate_width = dst->vupdate_width;
41529d79ce1655 Roman Li 2022-06-28  1132  	vready_offset = dst->vready_offset;
41529d79ce1655 Roman Li 2022-06-28  1133  
41529d79ce1655 Roman Li 2022-06-28  1134  	dppclk_delay_subtotal = mode_lib->ip.dppclk_delay_subtotal;
41529d79ce1655 Roman Li 2022-06-28  1135  	dispclk_delay_subtotal = mode_lib->ip.dispclk_delay_subtotal;
41529d79ce1655 Roman Li 2022-06-28  1136  
41529d79ce1655 Roman Li 2022-06-28  1137  	if (scl_enable)
41529d79ce1655 Roman Li 2022-06-28  1138  		dppclk_delay_subtotal += mode_lib->ip.dppclk_delay_scl;
41529d79ce1655 Roman Li 2022-06-28  1139  	else
41529d79ce1655 Roman Li 2022-06-28  1140  		dppclk_delay_subtotal += mode_lib->ip.dppclk_delay_scl_lb_only;
41529d79ce1655 Roman Li 2022-06-28  1141  
41529d79ce1655 Roman Li 2022-06-28  1142  	dppclk_delay_subtotal += mode_lib->ip.dppclk_delay_cnvc_formatter + src->num_cursors * mode_lib->ip.dppclk_delay_cnvc_cursor;
41529d79ce1655 Roman Li 2022-06-28  1143  
41529d79ce1655 Roman Li 2022-06-28  1144  	if (dout->dsc_enable) {
41529d79ce1655 Roman Li 2022-06-28  1145  		double dsc_delay = get_dsc_delay(mode_lib, e2e_pipe_param, num_pipes, pipe_idx); // FROM VBA
41529d79ce1655 Roman Li 2022-06-28  1146  
41529d79ce1655 Roman Li 2022-06-28  1147  		dispclk_delay_subtotal += dsc_delay;
41529d79ce1655 Roman Li 2022-06-28  1148  	}
41529d79ce1655 Roman Li 2022-06-28  1149  
41529d79ce1655 Roman Li 2022-06-28  1150  	vstartup_start = dst->vstartup_start;
41529d79ce1655 Roman Li 2022-06-28  1151  	if (interlaced) {
41529d79ce1655 Roman Li 2022-06-28  1152  		if (vstartup_start / 2.0 - (double) (vready_offset + vupdate_width + vupdate_offset) / htotal <= vblank_end / 2.0)
41529d79ce1655 Roman Li 2022-06-28  1153  			disp_dlg_regs->vready_after_vcount0 = 1;
41529d79ce1655 Roman Li 2022-06-28  1154  		else
41529d79ce1655 Roman Li 2022-06-28  1155  			disp_dlg_regs->vready_after_vcount0 = 0;
41529d79ce1655 Roman Li 2022-06-28  1156  	} else {
41529d79ce1655 Roman Li 2022-06-28  1157  		if (vstartup_start - (double) (vready_offset + vupdate_width + vupdate_offset) / htotal <= vblank_end)
41529d79ce1655 Roman Li 2022-06-28  1158  			disp_dlg_regs->vready_after_vcount0 = 1;
41529d79ce1655 Roman Li 2022-06-28  1159  		else
41529d79ce1655 Roman Li 2022-06-28  1160  			disp_dlg_regs->vready_after_vcount0 = 0;
41529d79ce1655 Roman Li 2022-06-28  1161  	}
41529d79ce1655 Roman Li 2022-06-28  1162  
41529d79ce1655 Roman Li 2022-06-28  1163  	dml_print("DML_DLG: %s: vready_after_vcount0 = %d\n", __func__, disp_dlg_regs->vready_after_vcount0);
41529d79ce1655 Roman Li 2022-06-28  1164  	dml_print("DML_DLG: %s: vba__vready_after_vcount0 = %d\n", __func__, vba__vready_after_vcount0);
41529d79ce1655 Roman Li 2022-06-28  1165  	//old_impl_vs_vba_impl("vready_after_vcount0", disp_dlg_regs->vready_after_vcount0, vba__vready_after_vcount0);
41529d79ce1655 Roman Li 2022-06-28  1166  
41529d79ce1655 Roman Li 2022-06-28  1167  	if (interlaced)
41529d79ce1655 Roman Li 2022-06-28  1168  		vstartup_start = vstartup_start / 2;
41529d79ce1655 Roman Li 2022-06-28  1169  
41529d79ce1655 Roman Li 2022-06-28  1170  	dst_x_after_scaler = get_dst_x_after_scaler(mode_lib, e2e_pipe_param, num_pipes, pipe_idx); // From VBA
41529d79ce1655 Roman Li 2022-06-28  1171  	dst_y_after_scaler = get_dst_y_after_scaler(mode_lib, e2e_pipe_param, num_pipes, pipe_idx); // From VBA
41529d79ce1655 Roman Li 2022-06-28  1172  
41529d79ce1655 Roman Li 2022-06-28  1173  	// do some adjustment on the dst_after scaler to account for odm combine mode
41529d79ce1655 Roman Li 2022-06-28  1174  	dml_print("DML_DLG: %s: input dst_x_after_scaler   = %d\n", __func__, dst_x_after_scaler);
41529d79ce1655 Roman Li 2022-06-28  1175  	dml_print("DML_DLG: %s: input dst_y_after_scaler   = %d\n", __func__, dst_y_after_scaler);
41529d79ce1655 Roman Li 2022-06-28  1176  
41529d79ce1655 Roman Li 2022-06-28  1177  	// need to figure out which side of odm combine we're in
41529d79ce1655 Roman Li 2022-06-28  1178  	if (dst->odm_combine) {
41529d79ce1655 Roman Li 2022-06-28  1179  		// figure out which pipes go together
41529d79ce1655 Roman Li 2022-06-28  1180  		bool visited[DC__NUM_PIPES__MAX];
41529d79ce1655 Roman Li 2022-06-28  1181  		unsigned int i, j, k;
41529d79ce1655 Roman Li 2022-06-28  1182  
41529d79ce1655 Roman Li 2022-06-28  1183  		for (k = 0; k < num_pipes; ++k) {
41529d79ce1655 Roman Li 2022-06-28  1184  			visited[k] = false;
41529d79ce1655 Roman Li 2022-06-28  1185  			pipe_index_in_combine[k] = 0;
41529d79ce1655 Roman Li 2022-06-28  1186  		}
41529d79ce1655 Roman Li 2022-06-28  1187  
41529d79ce1655 Roman Li 2022-06-28  1188  		for (i = 0; i < num_pipes; i++) {
41529d79ce1655 Roman Li 2022-06-28  1189  			if (e2e_pipe_param[i].pipe.src.is_hsplit && !visited[i]) {
41529d79ce1655 Roman Li 2022-06-28  1190  
41529d79ce1655 Roman Li 2022-06-28  1191  				unsigned int grp = e2e_pipe_param[i].pipe.src.hsplit_grp;
41529d79ce1655 Roman Li 2022-06-28  1192  				unsigned int grp_idx = 0;
41529d79ce1655 Roman Li 2022-06-28  1193  
41529d79ce1655 Roman Li 2022-06-28  1194  				for (j = i; j < num_pipes; j++) {
41529d79ce1655 Roman Li 2022-06-28  1195  					if (e2e_pipe_param[j].pipe.src.hsplit_grp == grp && e2e_pipe_param[j].pipe.src.is_hsplit && !visited[j]) {
41529d79ce1655 Roman Li 2022-06-28  1196  						pipe_index_in_combine[j] = grp_idx;
41529d79ce1655 Roman Li 2022-06-28  1197  						dml_print("DML_DLG: %s: pipe[%d] is in grp %d idx %d\n", __func__, j, grp, grp_idx);
41529d79ce1655 Roman Li 2022-06-28  1198  						grp_idx++;
41529d79ce1655 Roman Li 2022-06-28  1199  						visited[j] = true;
41529d79ce1655 Roman Li 2022-06-28  1200  					}
41529d79ce1655 Roman Li 2022-06-28  1201  				}
41529d79ce1655 Roman Li 2022-06-28  1202  			}
41529d79ce1655 Roman Li 2022-06-28  1203  		}
41529d79ce1655 Roman Li 2022-06-28  1204  
41529d79ce1655 Roman Li 2022-06-28  1205  	}
41529d79ce1655 Roman Li 2022-06-28  1206  
41529d79ce1655 Roman Li 2022-06-28  1207  	if (dst->odm_combine == dm_odm_combine_mode_disabled) {
41529d79ce1655 Roman Li 2022-06-28  1208  		disp_dlg_regs->refcyc_h_blank_end = (unsigned int) ((double) hblank_end * ref_freq_to_pix_freq);
41529d79ce1655 Roman Li 2022-06-28  1209  	} else {
41529d79ce1655 Roman Li 2022-06-28  1210  		unsigned int odm_combine_factor = (dst->odm_combine == dm_odm_combine_mode_2to1 ? 2 : 4); // TODO: We should really check that 4to1 is supported before setting it to 4
41529d79ce1655 Roman Li 2022-06-28  1211  		unsigned int odm_pipe_index = pipe_index_in_combine[pipe_idx];
41529d79ce1655 Roman Li 2022-06-28  1212  
41529d79ce1655 Roman Li 2022-06-28  1213  		disp_dlg_regs->refcyc_h_blank_end = (unsigned int) (((double) hblank_end + odm_pipe_index * (double) dst->hactive / odm_combine_factor) * ref_freq_to_pix_freq);
41529d79ce1655 Roman Li 2022-06-28  1214  	} ASSERT(disp_dlg_regs->refcyc_h_blank_end < (unsigned int)dml_pow(2, 13));
41529d79ce1655 Roman Li 2022-06-28  1215  
41529d79ce1655 Roman Li 2022-06-28  1216  	dml_print("DML_DLG: %s: htotal                     = %d\n", __func__, htotal);
41529d79ce1655 Roman Li 2022-06-28  1217  	dml_print("DML_DLG: %s: dst_x_after_scaler[%d]     = %d\n", __func__, pipe_idx, dst_x_after_scaler);
41529d79ce1655 Roman Li 2022-06-28  1218  	dml_print("DML_DLG: %s: dst_y_after_scaler[%d]     = %d\n", __func__, pipe_idx, dst_y_after_scaler);
41529d79ce1655 Roman Li 2022-06-28  1219  
41529d79ce1655 Roman Li 2022-06-28  1220  	dst_y_prefetch = get_dst_y_prefetch(mode_lib, e2e_pipe_param, num_pipes, pipe_idx);        // From VBA
41529d79ce1655 Roman Li 2022-06-28  1221  	dst_y_per_vm_vblank = get_dst_y_per_vm_vblank(mode_lib, e2e_pipe_param, num_pipes, pipe_idx);        // From VBA
41529d79ce1655 Roman Li 2022-06-28  1222  	dst_y_per_row_vblank = get_dst_y_per_row_vblank(mode_lib, e2e_pipe_param, num_pipes, pipe_idx);        // From VBA
41529d79ce1655 Roman Li 2022-06-28  1223  	dst_y_per_vm_flip = get_dst_y_per_vm_flip(mode_lib, e2e_pipe_param, num_pipes, pipe_idx);        // From VBA
41529d79ce1655 Roman Li 2022-06-28  1224  	dst_y_per_row_flip = get_dst_y_per_row_flip(mode_lib, e2e_pipe_param, num_pipes, pipe_idx);        // From VBA
41529d79ce1655 Roman Li 2022-06-28  1225  
41529d79ce1655 Roman Li 2022-06-28  1226  	max_dst_y_per_vm_vblank = 32.0;        //U5.2
41529d79ce1655 Roman Li 2022-06-28  1227  	max_dst_y_per_row_vblank = 16.0;        //U4.2
41529d79ce1655 Roman Li 2022-06-28  1228  
41529d79ce1655 Roman Li 2022-06-28  1229  	// magic!
41529d79ce1655 Roman Li 2022-06-28  1230  	if (htotal <= 75) {
41529d79ce1655 Roman Li 2022-06-28  1231  		max_dst_y_per_vm_vblank = 100.0;
41529d79ce1655 Roman Li 2022-06-28  1232  		max_dst_y_per_row_vblank = 100.0;
41529d79ce1655 Roman Li 2022-06-28  1233  	}
41529d79ce1655 Roman Li 2022-06-28  1234  
41529d79ce1655 Roman Li 2022-06-28  1235  	dml_print("DML_DLG: %s: dst_y_prefetch (after rnd) = %3.2f\n", __func__, dst_y_prefetch);
41529d79ce1655 Roman Li 2022-06-28  1236  	dml_print("DML_DLG: %s: dst_y_per_vm_flip    = %3.2f\n", __func__, dst_y_per_vm_flip);
41529d79ce1655 Roman Li 2022-06-28  1237  	dml_print("DML_DLG: %s: dst_y_per_row_flip   = %3.2f\n", __func__, dst_y_per_row_flip);
41529d79ce1655 Roman Li 2022-06-28  1238  	dml_print("DML_DLG: %s: dst_y_per_vm_vblank  = %3.2f\n", __func__, dst_y_per_vm_vblank);
41529d79ce1655 Roman Li 2022-06-28  1239  	dml_print("DML_DLG: %s: dst_y_per_row_vblank = %3.2f\n", __func__, dst_y_per_row_vblank);
41529d79ce1655 Roman Li 2022-06-28  1240  
41529d79ce1655 Roman Li 2022-06-28  1241  	ASSERT(dst_y_per_vm_vblank < max_dst_y_per_vm_vblank); ASSERT(dst_y_per_row_vblank < max_dst_y_per_row_vblank);
41529d79ce1655 Roman Li 2022-06-28  1242  
41529d79ce1655 Roman Li 2022-06-28  1243  	ASSERT(dst_y_prefetch > (dst_y_per_vm_vblank + dst_y_per_row_vblank));
41529d79ce1655 Roman Li 2022-06-28  1244  
41529d79ce1655 Roman Li 2022-06-28  1245  	vratio_pre_l = get_vratio_prefetch_l(mode_lib, e2e_pipe_param, num_pipes, pipe_idx);    // From VBA
41529d79ce1655 Roman Li 2022-06-28  1246  	vratio_pre_c = get_vratio_prefetch_c(mode_lib, e2e_pipe_param, num_pipes, pipe_idx);    // From VBA
41529d79ce1655 Roman Li 2022-06-28  1247  
41529d79ce1655 Roman Li 2022-06-28  1248  	dml_print("DML_DLG: %s: vratio_pre_l = %3.2f\n", __func__, vratio_pre_l);
41529d79ce1655 Roman Li 2022-06-28  1249  	dml_print("DML_DLG: %s: vratio_pre_c = %3.2f\n", __func__, vratio_pre_c);
41529d79ce1655 Roman Li 2022-06-28  1250  
41529d79ce1655 Roman Li 2022-06-28  1251  	// Active
41529d79ce1655 Roman Li 2022-06-28  1252  	req_per_swath_ub_l = rq_dlg_param->rq_l.req_per_swath_ub;
41529d79ce1655 Roman Li 2022-06-28  1253  	req_per_swath_ub_c = rq_dlg_param->rq_c.req_per_swath_ub;
41529d79ce1655 Roman Li 2022-06-28  1254  	meta_row_height_l = rq_dlg_param->rq_l.meta_row_height;
41529d79ce1655 Roman Li 2022-06-28  1255  	meta_row_height_c = rq_dlg_param->rq_c.meta_row_height;
41529d79ce1655 Roman Li 2022-06-28  1256  	swath_width_pixels_ub_l = 0;
41529d79ce1655 Roman Li 2022-06-28  1257  	swath_width_pixels_ub_c = 0;
41529d79ce1655 Roman Li 2022-06-28  1258  	scaler_rec_in_width_l = 0;
41529d79ce1655 Roman Li 2022-06-28  1259  	scaler_rec_in_width_c = 0;
41529d79ce1655 Roman Li 2022-06-28  1260  	dpte_row_height_l = rq_dlg_param->rq_l.dpte_row_height;
41529d79ce1655 Roman Li 2022-06-28  1261  	dpte_row_height_c = rq_dlg_param->rq_c.dpte_row_height;
41529d79ce1655 Roman Li 2022-06-28  1262  
41529d79ce1655 Roman Li 2022-06-28  1263  	if (mode_422) {
41529d79ce1655 Roman Li 2022-06-28  1264  		swath_width_pixels_ub_l = swath_width_ub_l * 2;  // *2 for 2 pixel per element
41529d79ce1655 Roman Li 2022-06-28  1265  		swath_width_pixels_ub_c = swath_width_ub_c * 2;
41529d79ce1655 Roman Li 2022-06-28  1266  	} else {
41529d79ce1655 Roman Li 2022-06-28  1267  		swath_width_pixels_ub_l = swath_width_ub_l * 1;
41529d79ce1655 Roman Li 2022-06-28  1268  		swath_width_pixels_ub_c = swath_width_ub_c * 1;
41529d79ce1655 Roman Li 2022-06-28  1269  	}
41529d79ce1655 Roman Li 2022-06-28  1270  
41529d79ce1655 Roman Li 2022-06-28  1271  	hscale_pixel_rate_l = 0.;
41529d79ce1655 Roman Li 2022-06-28  1272  	hscale_pixel_rate_c = 0.;
41529d79ce1655 Roman Li 2022-06-28  1273  	min_hratio_fact_l = 1.0;
41529d79ce1655 Roman Li 2022-06-28  1274  	min_hratio_fact_c = 1.0;
41529d79ce1655 Roman Li 2022-06-28  1275  
41529d79ce1655 Roman Li 2022-06-28  1276  	if (hratio_l <= 1)
41529d79ce1655 Roman Li 2022-06-28  1277  		min_hratio_fact_l = 2.0;
41529d79ce1655 Roman Li 2022-06-28  1278  	else if (htaps_l <= 6) {
41529d79ce1655 Roman Li 2022-06-28  1279  		if ((hratio_l * 2.0) > 4.0)
41529d79ce1655 Roman Li 2022-06-28  1280  			min_hratio_fact_l = 4.0;
41529d79ce1655 Roman Li 2022-06-28  1281  		else
41529d79ce1655 Roman Li 2022-06-28  1282  			min_hratio_fact_l = hratio_l * 2.0;
41529d79ce1655 Roman Li 2022-06-28  1283  	} else {
41529d79ce1655 Roman Li 2022-06-28  1284  		if (hratio_l > 4.0)
41529d79ce1655 Roman Li 2022-06-28  1285  			min_hratio_fact_l = 4.0;
41529d79ce1655 Roman Li 2022-06-28  1286  		else
41529d79ce1655 Roman Li 2022-06-28  1287  			min_hratio_fact_l = hratio_l;
41529d79ce1655 Roman Li 2022-06-28  1288  	}
41529d79ce1655 Roman Li 2022-06-28  1289  
41529d79ce1655 Roman Li 2022-06-28  1290  	hscale_pixel_rate_l = min_hratio_fact_l * dppclk_freq_in_mhz;
41529d79ce1655 Roman Li 2022-06-28  1291  
41529d79ce1655 Roman Li 2022-06-28  1292  	dml_print("DML_DLG: %s: hratio_l = %3.2f\n", __func__, hratio_l);
41529d79ce1655 Roman Li 2022-06-28  1293  	dml_print("DML_DLG: %s: min_hratio_fact_l = %3.2f\n", __func__, min_hratio_fact_l);
41529d79ce1655 Roman Li 2022-06-28  1294  	dml_print("DML_DLG: %s: hscale_pixel_rate_l = %3.2f\n", __func__, hscale_pixel_rate_l);
41529d79ce1655 Roman Li 2022-06-28  1295  
41529d79ce1655 Roman Li 2022-06-28  1296  	if (hratio_c <= 1)
41529d79ce1655 Roman Li 2022-06-28  1297  		min_hratio_fact_c = 2.0;
41529d79ce1655 Roman Li 2022-06-28  1298  	else if (htaps_c <= 6) {
41529d79ce1655 Roman Li 2022-06-28  1299  		if ((hratio_c * 2.0) > 4.0)
41529d79ce1655 Roman Li 2022-06-28  1300  			min_hratio_fact_c = 4.0;
41529d79ce1655 Roman Li 2022-06-28  1301  		else
41529d79ce1655 Roman Li 2022-06-28  1302  			min_hratio_fact_c = hratio_c * 2.0;
41529d79ce1655 Roman Li 2022-06-28  1303  	} else {
41529d79ce1655 Roman Li 2022-06-28  1304  		if (hratio_c > 4.0)
41529d79ce1655 Roman Li 2022-06-28  1305  			min_hratio_fact_c = 4.0;
41529d79ce1655 Roman Li 2022-06-28  1306  		else
41529d79ce1655 Roman Li 2022-06-28  1307  			min_hratio_fact_c = hratio_c;
41529d79ce1655 Roman Li 2022-06-28  1308  	}
41529d79ce1655 Roman Li 2022-06-28  1309  
41529d79ce1655 Roman Li 2022-06-28  1310  	hscale_pixel_rate_c = min_hratio_fact_c * dppclk_freq_in_mhz;
41529d79ce1655 Roman Li 2022-06-28  1311  
41529d79ce1655 Roman Li 2022-06-28  1312  	refcyc_per_line_delivery_pre_l = 0.;
41529d79ce1655 Roman Li 2022-06-28  1313  	refcyc_per_line_delivery_pre_c = 0.;
41529d79ce1655 Roman Li 2022-06-28  1314  	refcyc_per_line_delivery_l = 0.;
41529d79ce1655 Roman Li 2022-06-28  1315  	refcyc_per_line_delivery_c = 0.;
41529d79ce1655 Roman Li 2022-06-28  1316  
41529d79ce1655 Roman Li 2022-06-28  1317  	refcyc_per_req_delivery_pre_l = 0.;
41529d79ce1655 Roman Li 2022-06-28  1318  	refcyc_per_req_delivery_pre_c = 0.;
41529d79ce1655 Roman Li 2022-06-28  1319  	refcyc_per_req_delivery_l = 0.;
41529d79ce1655 Roman Li 2022-06-28  1320  	refcyc_per_req_delivery_c = 0.;
41529d79ce1655 Roman Li 2022-06-28  1321  
41529d79ce1655 Roman Li 2022-06-28  1322  	full_recout_width = 0;
41529d79ce1655 Roman Li 2022-06-28  1323  	// In ODM
41529d79ce1655 Roman Li 2022-06-28  1324  	if (src->is_hsplit) {
41529d79ce1655 Roman Li 2022-06-28  1325  		// This "hack"  is only allowed (and valid) for MPC combine. In ODM
41529d79ce1655 Roman Li 2022-06-28  1326  		// combine, you MUST specify the full_recout_width...according to Oswin
41529d79ce1655 Roman Li 2022-06-28  1327  		if (dst->full_recout_width == 0 && !dst->odm_combine) {
41529d79ce1655 Roman Li 2022-06-28  1328  			dml_print("DML_DLG: %s: Warning: full_recout_width not set in hsplit mode\n", __func__);
41529d79ce1655 Roman Li 2022-06-28  1329  			full_recout_width = dst->recout_width * 2; // assume half split for dcn1
41529d79ce1655 Roman Li 2022-06-28  1330  		} else
41529d79ce1655 Roman Li 2022-06-28  1331  			full_recout_width = dst->full_recout_width;
41529d79ce1655 Roman Li 2022-06-28  1332  	} else
41529d79ce1655 Roman Li 2022-06-28  1333  		full_recout_width = dst->recout_width;
41529d79ce1655 Roman Li 2022-06-28  1334  
41529d79ce1655 Roman Li 2022-06-28  1335  	// As of DCN2, mpc_combine and odm_combine are mutually exclusive
41529d79ce1655 Roman Li 2022-06-28  1336  	refcyc_per_line_delivery_pre_l = get_refcyc_per_delivery(
41529d79ce1655 Roman Li 2022-06-28  1337  			mode_lib,
41529d79ce1655 Roman Li 2022-06-28  1338  			refclk_freq_in_mhz,
41529d79ce1655 Roman Li 2022-06-28  1339  			pclk_freq_in_mhz,
41529d79ce1655 Roman Li 2022-06-28  1340  			dst->odm_combine,
41529d79ce1655 Roman Li 2022-06-28  1341  			full_recout_width,
41529d79ce1655 Roman Li 2022-06-28  1342  			dst->hactive,
41529d79ce1655 Roman Li 2022-06-28  1343  			vratio_pre_l,
41529d79ce1655 Roman Li 2022-06-28  1344  			hscale_pixel_rate_l,
41529d79ce1655 Roman Li 2022-06-28  1345  			swath_width_pixels_ub_l,
41529d79ce1655 Roman Li 2022-06-28  1346  			1); // per line
41529d79ce1655 Roman Li 2022-06-28  1347  
41529d79ce1655 Roman Li 2022-06-28  1348  	refcyc_per_line_delivery_l = get_refcyc_per_delivery(
41529d79ce1655 Roman Li 2022-06-28  1349  			mode_lib,
41529d79ce1655 Roman Li 2022-06-28  1350  			refclk_freq_in_mhz,
41529d79ce1655 Roman Li 2022-06-28  1351  			pclk_freq_in_mhz,
41529d79ce1655 Roman Li 2022-06-28  1352  			dst->odm_combine,
41529d79ce1655 Roman Li 2022-06-28  1353  			full_recout_width,
41529d79ce1655 Roman Li 2022-06-28  1354  			dst->hactive,
41529d79ce1655 Roman Li 2022-06-28  1355  			vratio_l,
41529d79ce1655 Roman Li 2022-06-28  1356  			hscale_pixel_rate_l,
41529d79ce1655 Roman Li 2022-06-28  1357  			swath_width_pixels_ub_l,
41529d79ce1655 Roman Li 2022-06-28  1358  			1); // per line
41529d79ce1655 Roman Li 2022-06-28  1359  
41529d79ce1655 Roman Li 2022-06-28  1360  	dml_print("DML_DLG: %s: full_recout_width              = %d\n", __func__, full_recout_width);
41529d79ce1655 Roman Li 2022-06-28  1361  	dml_print("DML_DLG: %s: hscale_pixel_rate_l            = %3.2f\n", __func__, hscale_pixel_rate_l);
41529d79ce1655 Roman Li 2022-06-28  1362  	dml_print("DML_DLG: %s: refcyc_per_line_delivery_pre_l = %3.2f\n", __func__, refcyc_per_line_delivery_pre_l);
41529d79ce1655 Roman Li 2022-06-28  1363  	dml_print("DML_DLG: %s: refcyc_per_line_delivery_l     = %3.2f\n", __func__, refcyc_per_line_delivery_l);
41529d79ce1655 Roman Li 2022-06-28  1364  	dml_print("DML_DLG: %s: vba__refcyc_per_line_delivery_pre_l = %3.2f\n", __func__, vba__refcyc_per_line_delivery_pre_l);
41529d79ce1655 Roman Li 2022-06-28  1365  	dml_print("DML_DLG: %s: vba__refcyc_per_line_delivery_l     = %3.2f\n", __func__, vba__refcyc_per_line_delivery_l);
41529d79ce1655 Roman Li 2022-06-28  1366  
41529d79ce1655 Roman Li 2022-06-28  1367  	//old_impl_vs_vba_impl("refcyc_per_line_delivery_pre_l", refcyc_per_line_delivery_pre_l, vba__refcyc_per_line_delivery_pre_l);
41529d79ce1655 Roman Li 2022-06-28  1368  	//old_impl_vs_vba_impl("refcyc_per_line_delivery_l", refcyc_per_line_delivery_l, vba__refcyc_per_line_delivery_l);
41529d79ce1655 Roman Li 2022-06-28  1369  
41529d79ce1655 Roman Li 2022-06-28  1370  	if (dual_plane) {
41529d79ce1655 Roman Li 2022-06-28  1371  		float vba__refcyc_per_line_delivery_pre_c = get_refcyc_per_line_delivery_pre_c_in_us(mode_lib, e2e_pipe_param, num_pipes, pipe_idx) * refclk_freq_in_mhz; // From VBA
41529d79ce1655 Roman Li 2022-06-28  1372  		float vba__refcyc_per_line_delivery_c = get_refcyc_per_line_delivery_c_in_us(mode_lib, e2e_pipe_param, num_pipes, pipe_idx) * refclk_freq_in_mhz; // From VBA
41529d79ce1655 Roman Li 2022-06-28  1373  
41529d79ce1655 Roman Li 2022-06-28  1374  		refcyc_per_line_delivery_pre_c = get_refcyc_per_delivery(
41529d79ce1655 Roman Li 2022-06-28  1375  				mode_lib,
41529d79ce1655 Roman Li 2022-06-28  1376  				refclk_freq_in_mhz,
41529d79ce1655 Roman Li 2022-06-28  1377  				pclk_freq_in_mhz,
41529d79ce1655 Roman Li 2022-06-28  1378  				dst->odm_combine,
41529d79ce1655 Roman Li 2022-06-28  1379  				full_recout_width,
41529d79ce1655 Roman Li 2022-06-28  1380  				dst->hactive,
41529d79ce1655 Roman Li 2022-06-28  1381  				vratio_pre_c,
41529d79ce1655 Roman Li 2022-06-28  1382  				hscale_pixel_rate_c,
41529d79ce1655 Roman Li 2022-06-28  1383  				swath_width_pixels_ub_c,
41529d79ce1655 Roman Li 2022-06-28  1384  				1); // per line
41529d79ce1655 Roman Li 2022-06-28  1385  
41529d79ce1655 Roman Li 2022-06-28  1386  		refcyc_per_line_delivery_c = get_refcyc_per_delivery(
41529d79ce1655 Roman Li 2022-06-28  1387  				mode_lib,
41529d79ce1655 Roman Li 2022-06-28  1388  				refclk_freq_in_mhz,
41529d79ce1655 Roman Li 2022-06-28  1389  				pclk_freq_in_mhz,
41529d79ce1655 Roman Li 2022-06-28  1390  				dst->odm_combine,
41529d79ce1655 Roman Li 2022-06-28  1391  				full_recout_width,
41529d79ce1655 Roman Li 2022-06-28  1392  				dst->hactive,
41529d79ce1655 Roman Li 2022-06-28  1393  				vratio_c,
41529d79ce1655 Roman Li 2022-06-28  1394  				hscale_pixel_rate_c,
41529d79ce1655 Roman Li 2022-06-28  1395  				swath_width_pixels_ub_c,
41529d79ce1655 Roman Li 2022-06-28  1396  				1); // per line
41529d79ce1655 Roman Li 2022-06-28  1397  
41529d79ce1655 Roman Li 2022-06-28  1398  		dml_print("DML_DLG: %s: refcyc_per_line_delivery_pre_c = %3.2f\n", __func__, refcyc_per_line_delivery_pre_c);
41529d79ce1655 Roman Li 2022-06-28  1399  		dml_print("DML_DLG: %s: refcyc_per_line_delivery_c     = %3.2f\n", __func__, refcyc_per_line_delivery_c);
41529d79ce1655 Roman Li 2022-06-28  1400  		dml_print("DML_DLG: %s: vba__refcyc_per_line_delivery_pre_c = %3.2f\n", __func__, vba__refcyc_per_line_delivery_pre_c);
41529d79ce1655 Roman Li 2022-06-28  1401  		dml_print("DML_DLG: %s: vba__refcyc_per_line_delivery_c     = %3.2f\n", __func__, vba__refcyc_per_line_delivery_c);
41529d79ce1655 Roman Li 2022-06-28  1402  
41529d79ce1655 Roman Li 2022-06-28  1403  		//old_impl_vs_vba_impl("refcyc_per_line_delivery_pre_c", refcyc_per_line_delivery_pre_c, vba__refcyc_per_line_delivery_pre_c);
41529d79ce1655 Roman Li 2022-06-28  1404  		//old_impl_vs_vba_impl("refcyc_per_line_delivery_c", refcyc_per_line_delivery_c, vba__refcyc_per_line_delivery_c);
41529d79ce1655 Roman Li 2022-06-28  1405  	}
41529d79ce1655 Roman Li 2022-06-28  1406  
41529d79ce1655 Roman Li 2022-06-28  1407  	if (src->dynamic_metadata_enable && src->gpuvm)
41529d79ce1655 Roman Li 2022-06-28  1408  		disp_dlg_regs->refcyc_per_vm_dmdata = get_refcyc_per_vm_dmdata_in_us(mode_lib, e2e_pipe_param, num_pipes, pipe_idx) * refclk_freq_in_mhz; // From VBA
41529d79ce1655 Roman Li 2022-06-28  1409  
41529d79ce1655 Roman Li 2022-06-28  1410  	disp_dlg_regs->dmdata_dl_delta = get_dmdata_dl_delta_in_us(mode_lib, e2e_pipe_param, num_pipes, pipe_idx) * refclk_freq_in_mhz; // From VBA
41529d79ce1655 Roman Li 2022-06-28  1411  
41529d79ce1655 Roman Li 2022-06-28  1412  	// TTU - Luma / Chroma
41529d79ce1655 Roman Li 2022-06-28  1413  	if (access_dir) {  // vertical access
41529d79ce1655 Roman Li 2022-06-28  1414  		scaler_rec_in_width_l = vp_height_l;
41529d79ce1655 Roman Li 2022-06-28  1415  		scaler_rec_in_width_c = vp_height_c;
41529d79ce1655 Roman Li 2022-06-28  1416  	} else {
41529d79ce1655 Roman Li 2022-06-28  1417  		scaler_rec_in_width_l = vp_width_l;
41529d79ce1655 Roman Li 2022-06-28  1418  		scaler_rec_in_width_c = vp_width_c;
41529d79ce1655 Roman Li 2022-06-28  1419  	}
41529d79ce1655 Roman Li 2022-06-28  1420  
41529d79ce1655 Roman Li 2022-06-28  1421  	refcyc_per_req_delivery_pre_l = get_refcyc_per_delivery(
41529d79ce1655 Roman Li 2022-06-28  1422  			mode_lib,
41529d79ce1655 Roman Li 2022-06-28  1423  			refclk_freq_in_mhz,
41529d79ce1655 Roman Li 2022-06-28  1424  			pclk_freq_in_mhz,
41529d79ce1655 Roman Li 2022-06-28  1425  			dst->odm_combine,
41529d79ce1655 Roman Li 2022-06-28  1426  			full_recout_width,
41529d79ce1655 Roman Li 2022-06-28  1427  			dst->hactive,
41529d79ce1655 Roman Li 2022-06-28  1428  			vratio_pre_l,
41529d79ce1655 Roman Li 2022-06-28  1429  			hscale_pixel_rate_l,
41529d79ce1655 Roman Li 2022-06-28  1430  			scaler_rec_in_width_l,
41529d79ce1655 Roman Li 2022-06-28  1431  			req_per_swath_ub_l);  // per req
41529d79ce1655 Roman Li 2022-06-28  1432  
41529d79ce1655 Roman Li 2022-06-28  1433  	refcyc_per_req_delivery_l = get_refcyc_per_delivery(
41529d79ce1655 Roman Li 2022-06-28  1434  			mode_lib,
41529d79ce1655 Roman Li 2022-06-28  1435  			refclk_freq_in_mhz,
41529d79ce1655 Roman Li 2022-06-28  1436  			pclk_freq_in_mhz,
41529d79ce1655 Roman Li 2022-06-28  1437  			dst->odm_combine,
41529d79ce1655 Roman Li 2022-06-28  1438  			full_recout_width,
41529d79ce1655 Roman Li 2022-06-28  1439  			dst->hactive,
41529d79ce1655 Roman Li 2022-06-28  1440  			vratio_l,
41529d79ce1655 Roman Li 2022-06-28  1441  			hscale_pixel_rate_l,
41529d79ce1655 Roman Li 2022-06-28  1442  			scaler_rec_in_width_l,
41529d79ce1655 Roman Li 2022-06-28  1443  			req_per_swath_ub_l);  // per req
41529d79ce1655 Roman Li 2022-06-28  1444  
41529d79ce1655 Roman Li 2022-06-28  1445  	dml_print("DML_DLG: %s: refcyc_per_req_delivery_pre_l = %3.2f\n", __func__, refcyc_per_req_delivery_pre_l);
41529d79ce1655 Roman Li 2022-06-28  1446  	dml_print("DML_DLG: %s: refcyc_per_req_delivery_l     = %3.2f\n", __func__, refcyc_per_req_delivery_l);
41529d79ce1655 Roman Li 2022-06-28  1447  	dml_print("DML_DLG: %s: vba__refcyc_per_req_delivery_pre_l = %3.2f\n", __func__, vba__refcyc_per_req_delivery_pre_l);
41529d79ce1655 Roman Li 2022-06-28  1448  	dml_print("DML_DLG: %s: vba__refcyc_per_req_delivery_l     = %3.2f\n", __func__, vba__refcyc_per_req_delivery_l);
41529d79ce1655 Roman Li 2022-06-28  1449  
41529d79ce1655 Roman Li 2022-06-28  1450  	//old_impl_vs_vba_impl("refcyc_per_req_delivery_pre_l", refcyc_per_req_delivery_pre_l, vba__refcyc_per_req_delivery_pre_l);
41529d79ce1655 Roman Li 2022-06-28  1451  	//old_impl_vs_vba_impl("refcyc_per_req_delivery_l", refcyc_per_req_delivery_l, vba__refcyc_per_req_delivery_l);
41529d79ce1655 Roman Li 2022-06-28  1452  
41529d79ce1655 Roman Li 2022-06-28  1453  	ASSERT(refcyc_per_req_delivery_pre_l < dml_pow(2, 13)); ASSERT(refcyc_per_req_delivery_l < dml_pow(2, 13));
41529d79ce1655 Roman Li 2022-06-28  1454  
41529d79ce1655 Roman Li 2022-06-28  1455  	if (dual_plane) {
41529d79ce1655 Roman Li 2022-06-28  1456  		float vba__refcyc_per_req_delivery_pre_c = get_refcyc_per_req_delivery_pre_c_in_us(mode_lib, e2e_pipe_param, num_pipes, pipe_idx) * refclk_freq_in_mhz;  // From VBA
41529d79ce1655 Roman Li 2022-06-28  1457  		float vba__refcyc_per_req_delivery_c = get_refcyc_per_req_delivery_c_in_us(mode_lib, e2e_pipe_param, num_pipes, pipe_idx) * refclk_freq_in_mhz;  // From VBA
41529d79ce1655 Roman Li 2022-06-28  1458  
41529d79ce1655 Roman Li 2022-06-28  1459  		refcyc_per_req_delivery_pre_c = get_refcyc_per_delivery(
41529d79ce1655 Roman Li 2022-06-28  1460  				mode_lib,
41529d79ce1655 Roman Li 2022-06-28  1461  				refclk_freq_in_mhz,
41529d79ce1655 Roman Li 2022-06-28  1462  				pclk_freq_in_mhz,
41529d79ce1655 Roman Li 2022-06-28  1463  				dst->odm_combine,
41529d79ce1655 Roman Li 2022-06-28  1464  				full_recout_width,
41529d79ce1655 Roman Li 2022-06-28  1465  				dst->hactive,
41529d79ce1655 Roman Li 2022-06-28  1466  				vratio_pre_c,
41529d79ce1655 Roman Li 2022-06-28  1467  				hscale_pixel_rate_c,
41529d79ce1655 Roman Li 2022-06-28  1468  				scaler_rec_in_width_c,
41529d79ce1655 Roman Li 2022-06-28  1469  				req_per_swath_ub_c);  // per req
41529d79ce1655 Roman Li 2022-06-28  1470  		refcyc_per_req_delivery_c = get_refcyc_per_delivery(
41529d79ce1655 Roman Li 2022-06-28  1471  				mode_lib,
41529d79ce1655 Roman Li 2022-06-28  1472  				refclk_freq_in_mhz,
41529d79ce1655 Roman Li 2022-06-28  1473  				pclk_freq_in_mhz,
41529d79ce1655 Roman Li 2022-06-28  1474  				dst->odm_combine,
41529d79ce1655 Roman Li 2022-06-28  1475  				full_recout_width,
41529d79ce1655 Roman Li 2022-06-28  1476  				dst->hactive,
41529d79ce1655 Roman Li 2022-06-28  1477  				vratio_c,
41529d79ce1655 Roman Li 2022-06-28  1478  				hscale_pixel_rate_c,
41529d79ce1655 Roman Li 2022-06-28  1479  				scaler_rec_in_width_c,
41529d79ce1655 Roman Li 2022-06-28  1480  				req_per_swath_ub_c);  // per req
41529d79ce1655 Roman Li 2022-06-28  1481  
41529d79ce1655 Roman Li 2022-06-28  1482  		dml_print("DML_DLG: %s: refcyc_per_req_delivery_pre_c = %3.2f\n", __func__, refcyc_per_req_delivery_pre_c);
41529d79ce1655 Roman Li 2022-06-28  1483  		dml_print("DML_DLG: %s: refcyc_per_req_delivery_c     = %3.2f\n", __func__, refcyc_per_req_delivery_c);
41529d79ce1655 Roman Li 2022-06-28  1484  		dml_print("DML_DLG: %s: vba__refcyc_per_req_delivery_pre_c = %3.2f\n", __func__, vba__refcyc_per_req_delivery_pre_c);
41529d79ce1655 Roman Li 2022-06-28  1485  		dml_print("DML_DLG: %s: vba__refcyc_per_req_delivery_c     = %3.2f\n", __func__, vba__refcyc_per_req_delivery_c);
41529d79ce1655 Roman Li 2022-06-28  1486  
41529d79ce1655 Roman Li 2022-06-28  1487  		//old_impl_vs_vba_impl("refcyc_per_req_delivery_pre_c", refcyc_per_req_delivery_pre_c, vba__refcyc_per_req_delivery_pre_c);
41529d79ce1655 Roman Li 2022-06-28  1488  		//old_impl_vs_vba_impl("refcyc_per_req_delivery_c", refcyc_per_req_delivery_c, vba__refcyc_per_req_delivery_c);
41529d79ce1655 Roman Li 2022-06-28  1489  
41529d79ce1655 Roman Li 2022-06-28  1490  		ASSERT(refcyc_per_req_delivery_pre_c < dml_pow(2, 13)); ASSERT(refcyc_per_req_delivery_c < dml_pow(2, 13));
41529d79ce1655 Roman Li 2022-06-28  1491  	}
41529d79ce1655 Roman Li 2022-06-28  1492  
41529d79ce1655 Roman Li 2022-06-28  1493  	// TTU - Cursor
41529d79ce1655 Roman Li 2022-06-28  1494  	refcyc_per_req_delivery_pre_cur0 = 0.0;
41529d79ce1655 Roman Li 2022-06-28  1495  	refcyc_per_req_delivery_cur0 = 0.0;
41529d79ce1655 Roman Li 2022-06-28  1496  
41529d79ce1655 Roman Li 2022-06-28  1497  	ASSERT(src->num_cursors <= 1);
41529d79ce1655 Roman Li 2022-06-28  1498  
41529d79ce1655 Roman Li 2022-06-28  1499  	if (src->num_cursors > 0) {
41529d79ce1655 Roman Li 2022-06-28  1500  		float vba__refcyc_per_req_delivery_pre_cur0;
41529d79ce1655 Roman Li 2022-06-28  1501  		float vba__refcyc_per_req_delivery_cur0;
41529d79ce1655 Roman Li 2022-06-28  1502  
41529d79ce1655 Roman Li 2022-06-28  1503  		calculate_ttu_cursor(
41529d79ce1655 Roman Li 2022-06-28  1504  				mode_lib,
41529d79ce1655 Roman Li 2022-06-28  1505  				&refcyc_per_req_delivery_pre_cur0,
41529d79ce1655 Roman Li 2022-06-28  1506  				&refcyc_per_req_delivery_cur0,
41529d79ce1655 Roman Li 2022-06-28  1507  				refclk_freq_in_mhz,
41529d79ce1655 Roman Li 2022-06-28  1508  				ref_freq_to_pix_freq,
41529d79ce1655 Roman Li 2022-06-28  1509  				hscale_pixel_rate_l,
41529d79ce1655 Roman Li 2022-06-28  1510  				scl->hscl_ratio,
41529d79ce1655 Roman Li 2022-06-28  1511  				vratio_pre_l,
41529d79ce1655 Roman Li 2022-06-28  1512  				vratio_l,
41529d79ce1655 Roman Li 2022-06-28  1513  				src->cur0_src_width,
41529d79ce1655 Roman Li 2022-06-28  1514  				(enum cursor_bpp) (src->cur0_bpp));
41529d79ce1655 Roman Li 2022-06-28  1515  
41529d79ce1655 Roman Li 2022-06-28  1516  		vba__refcyc_per_req_delivery_pre_cur0 = get_refcyc_per_cursor_req_delivery_pre_in_us(mode_lib, e2e_pipe_param, num_pipes, pipe_idx) * refclk_freq_in_mhz; // From VBA
41529d79ce1655 Roman Li 2022-06-28  1517  		vba__refcyc_per_req_delivery_cur0 = get_refcyc_per_cursor_req_delivery_in_us(mode_lib, e2e_pipe_param, num_pipes, pipe_idx) * refclk_freq_in_mhz; // From VBA
41529d79ce1655 Roman Li 2022-06-28  1518  
41529d79ce1655 Roman Li 2022-06-28  1519  		dml_print("DML_DLG: %s: refcyc_per_req_delivery_pre_cur0 = %3.2f\n", __func__, refcyc_per_req_delivery_pre_cur0);
41529d79ce1655 Roman Li 2022-06-28  1520  		dml_print("DML_DLG: %s: refcyc_per_req_delivery_cur0     = %3.2f\n", __func__, refcyc_per_req_delivery_cur0);
41529d79ce1655 Roman Li 2022-06-28  1521  		dml_print("DML_DLG: %s: vba__refcyc_per_req_delivery_pre_cur0 = %3.2f\n", __func__, vba__refcyc_per_req_delivery_pre_cur0);
41529d79ce1655 Roman Li 2022-06-28  1522  		dml_print("DML_DLG: %s: vba__refcyc_per_req_delivery_cur0     = %3.2f\n", __func__, vba__refcyc_per_req_delivery_cur0);
41529d79ce1655 Roman Li 2022-06-28  1523  
41529d79ce1655 Roman Li 2022-06-28  1524  		//old_impl_vs_vba_impl("refcyc_per_req_delivery_pre_cur0", refcyc_per_req_delivery_pre_cur0, vba__refcyc_per_req_delivery_pre_cur0);
41529d79ce1655 Roman Li 2022-06-28  1525  		//old_impl_vs_vba_impl("refcyc_per_req_delivery_cur0", refcyc_per_req_delivery_cur0, vba__refcyc_per_req_delivery_cur0);
41529d79ce1655 Roman Li 2022-06-28  1526  	}
41529d79ce1655 Roman Li 2022-06-28  1527  
41529d79ce1655 Roman Li 2022-06-28  1528  	refcyc_per_req_delivery_pre_cur1 = 0.0;
41529d79ce1655 Roman Li 2022-06-28  1529  	refcyc_per_req_delivery_cur1 = 0.0;
41529d79ce1655 Roman Li 2022-06-28  1530  
41529d79ce1655 Roman Li 2022-06-28  1531  	// TTU - Misc
41529d79ce1655 Roman Li 2022-06-28  1532  	// all hard-coded
41529d79ce1655 Roman Li 2022-06-28  1533  
41529d79ce1655 Roman Li 2022-06-28  1534  	// Assignment to register structures
41529d79ce1655 Roman Li 2022-06-28  1535  	disp_dlg_regs->dst_y_after_scaler = dst_y_after_scaler;	// in terms of line
41529d79ce1655 Roman Li 2022-06-28  1536  	ASSERT(disp_dlg_regs->dst_y_after_scaler < 8);
41529d79ce1655 Roman Li 2022-06-28  1537  	disp_dlg_regs->refcyc_x_after_scaler = dst_x_after_scaler * ref_freq_to_pix_freq;	// in terms of refclk
41529d79ce1655 Roman Li 2022-06-28  1538  	ASSERT(disp_dlg_regs->refcyc_x_after_scaler < (unsigned int)dml_pow(2, 13));
41529d79ce1655 Roman Li 2022-06-28  1539  	disp_dlg_regs->dst_y_prefetch = (unsigned int) (dst_y_prefetch * dml_pow(2, 2));
41529d79ce1655 Roman Li 2022-06-28  1540  	disp_dlg_regs->dst_y_per_vm_vblank = (unsigned int) (dst_y_per_vm_vblank * dml_pow(2, 2));
41529d79ce1655 Roman Li 2022-06-28  1541  	disp_dlg_regs->dst_y_per_row_vblank = (unsigned int) (dst_y_per_row_vblank * dml_pow(2, 2));
41529d79ce1655 Roman Li 2022-06-28  1542  	disp_dlg_regs->dst_y_per_vm_flip = (unsigned int) (dst_y_per_vm_flip * dml_pow(2, 2));
41529d79ce1655 Roman Li 2022-06-28  1543  	disp_dlg_regs->dst_y_per_row_flip = (unsigned int) (dst_y_per_row_flip * dml_pow(2, 2));
41529d79ce1655 Roman Li 2022-06-28  1544  
41529d79ce1655 Roman Li 2022-06-28  1545  	disp_dlg_regs->vratio_prefetch = (unsigned int) (vratio_pre_l * dml_pow(2, 19));
41529d79ce1655 Roman Li 2022-06-28  1546  	disp_dlg_regs->vratio_prefetch_c = (unsigned int) (vratio_pre_c * dml_pow(2, 19));
41529d79ce1655 Roman Li 2022-06-28  1547  
41529d79ce1655 Roman Li 2022-06-28  1548  	dml_print("DML_DLG: %s: disp_dlg_regs->dst_y_per_vm_vblank  = 0x%x\n", __func__, disp_dlg_regs->dst_y_per_vm_vblank);
41529d79ce1655 Roman Li 2022-06-28  1549  	dml_print("DML_DLG: %s: disp_dlg_regs->dst_y_per_row_vblank = 0x%x\n", __func__, disp_dlg_regs->dst_y_per_row_vblank);
41529d79ce1655 Roman Li 2022-06-28  1550  	dml_print("DML_DLG: %s: disp_dlg_regs->dst_y_per_vm_flip    = 0x%x\n", __func__, disp_dlg_regs->dst_y_per_vm_flip);
41529d79ce1655 Roman Li 2022-06-28  1551  	dml_print("DML_DLG: %s: disp_dlg_regs->dst_y_per_row_flip   = 0x%x\n", __func__, disp_dlg_regs->dst_y_per_row_flip);
41529d79ce1655 Roman Li 2022-06-28  1552  
41529d79ce1655 Roman Li 2022-06-28  1553  	// hack for FPGA
41529d79ce1655 Roman Li 2022-06-28  1554  	if (mode_lib->project == DML_PROJECT_DCN31_FPGA) {
41529d79ce1655 Roman Li 2022-06-28  1555  		if (disp_dlg_regs->vratio_prefetch >= (unsigned int) dml_pow(2, 22)) {
41529d79ce1655 Roman Li 2022-06-28  1556  			disp_dlg_regs->vratio_prefetch = (unsigned int) dml_pow(2, 22) - 1;
41529d79ce1655 Roman Li 2022-06-28  1557  			dml_print("vratio_prefetch exceed the max value, the register field is [21:0]\n");
41529d79ce1655 Roman Li 2022-06-28  1558  		}
41529d79ce1655 Roman Li 2022-06-28  1559  	}
41529d79ce1655 Roman Li 2022-06-28  1560  
41529d79ce1655 Roman Li 2022-06-28  1561  	disp_dlg_regs->refcyc_per_pte_group_vblank_l = (unsigned int) (dst_y_per_row_vblank * (double) htotal * ref_freq_to_pix_freq / (double) dpte_groups_per_row_ub_l);
41529d79ce1655 Roman Li 2022-06-28  1562  	ASSERT(disp_dlg_regs->refcyc_per_pte_group_vblank_l < (unsigned int)dml_pow(2, 13));
41529d79ce1655 Roman Li 2022-06-28  1563  
41529d79ce1655 Roman Li 2022-06-28  1564  	if (dual_plane) {
41529d79ce1655 Roman Li 2022-06-28  1565  		disp_dlg_regs->refcyc_per_pte_group_vblank_c = (unsigned int) (dst_y_per_row_vblank * (double) htotal * ref_freq_to_pix_freq / (double) dpte_groups_per_row_ub_c);
41529d79ce1655 Roman Li 2022-06-28  1566  		ASSERT(disp_dlg_regs->refcyc_per_pte_group_vblank_c < (unsigned int)dml_pow(2, 13));
41529d79ce1655 Roman Li 2022-06-28  1567  	}
41529d79ce1655 Roman Li 2022-06-28  1568  
41529d79ce1655 Roman Li 2022-06-28  1569  	disp_dlg_regs->refcyc_per_meta_chunk_vblank_l = (unsigned int) (dst_y_per_row_vblank * (double) htotal * ref_freq_to_pix_freq / (double) meta_chunks_per_row_ub_l);
41529d79ce1655 Roman Li 2022-06-28  1570  	ASSERT(disp_dlg_regs->refcyc_per_meta_chunk_vblank_l < (unsigned int)dml_pow(2, 13));
41529d79ce1655 Roman Li 2022-06-28  1571  
41529d79ce1655 Roman Li 2022-06-28  1572  	disp_dlg_regs->refcyc_per_meta_chunk_vblank_c = disp_dlg_regs->refcyc_per_meta_chunk_vblank_l; // dcc for 4:2:0 is not supported in dcn1.0.  assigned to be the same as _l for now
41529d79ce1655 Roman Li 2022-06-28  1573  
41529d79ce1655 Roman Li 2022-06-28  1574  	disp_dlg_regs->refcyc_per_pte_group_flip_l = (unsigned int) (dst_y_per_row_flip * htotal * ref_freq_to_pix_freq) / dpte_groups_per_row_ub_l;
41529d79ce1655 Roman Li 2022-06-28  1575  	disp_dlg_regs->refcyc_per_meta_chunk_flip_l = (unsigned int) (dst_y_per_row_flip * htotal * ref_freq_to_pix_freq) / meta_chunks_per_row_ub_l;
41529d79ce1655 Roman Li 2022-06-28  1576  
41529d79ce1655 Roman Li 2022-06-28  1577  	if (dual_plane) {
41529d79ce1655 Roman Li 2022-06-28  1578  		disp_dlg_regs->refcyc_per_pte_group_flip_c = (unsigned int) (dst_y_per_row_flip * htotal * ref_freq_to_pix_freq) / dpte_groups_per_row_ub_c;
41529d79ce1655 Roman Li 2022-06-28  1579  		disp_dlg_regs->refcyc_per_meta_chunk_flip_c = (unsigned int) (dst_y_per_row_flip * htotal * ref_freq_to_pix_freq) / meta_chunks_per_row_ub_c;
41529d79ce1655 Roman Li 2022-06-28  1580  	}
41529d79ce1655 Roman Li 2022-06-28  1581  
41529d79ce1655 Roman Li 2022-06-28  1582  	disp_dlg_regs->refcyc_per_vm_group_vblank = get_refcyc_per_vm_group_vblank_in_us(mode_lib, e2e_pipe_param, num_pipes, pipe_idx) * refclk_freq_in_mhz;            // From VBA
41529d79ce1655 Roman Li 2022-06-28  1583  	disp_dlg_regs->refcyc_per_vm_group_flip = get_refcyc_per_vm_group_flip_in_us(mode_lib, e2e_pipe_param, num_pipes, pipe_idx) * refclk_freq_in_mhz;            // From VBA
41529d79ce1655 Roman Li 2022-06-28  1584  	disp_dlg_regs->refcyc_per_vm_req_vblank = get_refcyc_per_vm_req_vblank_in_us(mode_lib, e2e_pipe_param, num_pipes, pipe_idx) * refclk_freq_in_mhz * dml_pow(2, 10); // From VBA
41529d79ce1655 Roman Li 2022-06-28  1585  	disp_dlg_regs->refcyc_per_vm_req_flip = get_refcyc_per_vm_req_flip_in_us(mode_lib, e2e_pipe_param, num_pipes, pipe_idx) * refclk_freq_in_mhz * dml_pow(2, 10);   // From VBA
41529d79ce1655 Roman Li 2022-06-28  1586  
41529d79ce1655 Roman Li 2022-06-28  1587  	// Clamp to max for now
41529d79ce1655 Roman Li 2022-06-28  1588  	if (disp_dlg_regs->refcyc_per_vm_group_vblank >= (unsigned int) dml_pow(2, 23))
41529d79ce1655 Roman Li 2022-06-28  1589  		disp_dlg_regs->refcyc_per_vm_group_vblank = dml_pow(2, 23) - 1;
41529d79ce1655 Roman Li 2022-06-28  1590  
41529d79ce1655 Roman Li 2022-06-28  1591  	if (disp_dlg_regs->refcyc_per_vm_group_flip >= (unsigned int) dml_pow(2, 23))
41529d79ce1655 Roman Li 2022-06-28  1592  		disp_dlg_regs->refcyc_per_vm_group_flip = dml_pow(2, 23) - 1;
41529d79ce1655 Roman Li 2022-06-28  1593  
41529d79ce1655 Roman Li 2022-06-28  1594  	if (disp_dlg_regs->refcyc_per_vm_req_vblank >= (unsigned int) dml_pow(2, 23))
41529d79ce1655 Roman Li 2022-06-28  1595  		disp_dlg_regs->refcyc_per_vm_req_vblank = dml_pow(2, 23) - 1;
41529d79ce1655 Roman Li 2022-06-28  1596  
41529d79ce1655 Roman Li 2022-06-28  1597  	if (disp_dlg_regs->refcyc_per_vm_req_flip >= (unsigned int) dml_pow(2, 23))
41529d79ce1655 Roman Li 2022-06-28  1598  		disp_dlg_regs->refcyc_per_vm_req_flip = dml_pow(2, 23) - 1;
41529d79ce1655 Roman Li 2022-06-28  1599  
41529d79ce1655 Roman Li 2022-06-28  1600  	disp_dlg_regs->dst_y_per_pte_row_nom_l = (unsigned int) ((double) dpte_row_height_l / (double) vratio_l * dml_pow(2, 2));
41529d79ce1655 Roman Li 2022-06-28  1601  	ASSERT(disp_dlg_regs->dst_y_per_pte_row_nom_l < (unsigned int)dml_pow(2, 17));
41529d79ce1655 Roman Li 2022-06-28  1602  	if (dual_plane) {
41529d79ce1655 Roman Li 2022-06-28  1603  		disp_dlg_regs->dst_y_per_pte_row_nom_c = (unsigned int) ((double) dpte_row_height_c / (double) vratio_c * dml_pow(2, 2));
41529d79ce1655 Roman Li 2022-06-28  1604  		if (disp_dlg_regs->dst_y_per_pte_row_nom_c >= (unsigned int) dml_pow(2, 17)) {
41529d79ce1655 Roman Li 2022-06-28  1605  			dml_print(
41529d79ce1655 Roman Li 2022-06-28  1606  					"DML_DLG: %s: Warning dst_y_per_pte_row_nom_c %u larger than supported by register format U15.2 %u\n",
41529d79ce1655 Roman Li 2022-06-28  1607  					__func__,
41529d79ce1655 Roman Li 2022-06-28  1608  					disp_dlg_regs->dst_y_per_pte_row_nom_c,
41529d79ce1655 Roman Li 2022-06-28  1609  					(unsigned int) dml_pow(2, 17) - 1);
41529d79ce1655 Roman Li 2022-06-28  1610  		}
41529d79ce1655 Roman Li 2022-06-28  1611  	}
41529d79ce1655 Roman Li 2022-06-28  1612  
41529d79ce1655 Roman Li 2022-06-28  1613  	disp_dlg_regs->dst_y_per_meta_row_nom_l = (unsigned int) ((double) meta_row_height_l / (double) vratio_l * dml_pow(2, 2));
41529d79ce1655 Roman Li 2022-06-28  1614  	ASSERT(disp_dlg_regs->dst_y_per_meta_row_nom_l < (unsigned int)dml_pow(2, 17));
41529d79ce1655 Roman Li 2022-06-28  1615  
41529d79ce1655 Roman Li 2022-06-28  1616  	disp_dlg_regs->dst_y_per_meta_row_nom_c = (unsigned int) ((double) meta_row_height_c / (double) vratio_c * dml_pow(2, 2));
41529d79ce1655 Roman Li 2022-06-28  1617  	ASSERT(disp_dlg_regs->dst_y_per_meta_row_nom_c < (unsigned int)dml_pow(2, 17));
41529d79ce1655 Roman Li 2022-06-28  1618  
41529d79ce1655 Roman Li 2022-06-28  1619  	disp_dlg_regs->refcyc_per_pte_group_nom_l = (unsigned int) ((double) dpte_row_height_l / (double) vratio_l * (double) htotal * ref_freq_to_pix_freq
41529d79ce1655 Roman Li 2022-06-28  1620  			/ (double) dpte_groups_per_row_ub_l);
41529d79ce1655 Roman Li 2022-06-28  1621  	if (disp_dlg_regs->refcyc_per_pte_group_nom_l >= (unsigned int) dml_pow(2, 23))
41529d79ce1655 Roman Li 2022-06-28  1622  		disp_dlg_regs->refcyc_per_pte_group_nom_l = dml_pow(2, 23) - 1;
41529d79ce1655 Roman Li 2022-06-28  1623  	disp_dlg_regs->refcyc_per_meta_chunk_nom_l = (unsigned int) ((double) meta_row_height_l / (double) vratio_l * (double) htotal * ref_freq_to_pix_freq
41529d79ce1655 Roman Li 2022-06-28  1624  			/ (double) meta_chunks_per_row_ub_l);
41529d79ce1655 Roman Li 2022-06-28  1625  	if (disp_dlg_regs->refcyc_per_meta_chunk_nom_l >= (unsigned int) dml_pow(2, 23))
41529d79ce1655 Roman Li 2022-06-28  1626  		disp_dlg_regs->refcyc_per_meta_chunk_nom_l = dml_pow(2, 23) - 1;
41529d79ce1655 Roman Li 2022-06-28  1627  
41529d79ce1655 Roman Li 2022-06-28  1628  	if (dual_plane) {
41529d79ce1655 Roman Li 2022-06-28  1629  		disp_dlg_regs->refcyc_per_pte_group_nom_c = (unsigned int) ((double) dpte_row_height_c / (double) vratio_c * (double) htotal * ref_freq_to_pix_freq
41529d79ce1655 Roman Li 2022-06-28  1630  				/ (double) dpte_groups_per_row_ub_c);
41529d79ce1655 Roman Li 2022-06-28  1631  		if (disp_dlg_regs->refcyc_per_pte_group_nom_c >= (unsigned int) dml_pow(2, 23))
41529d79ce1655 Roman Li 2022-06-28  1632  			disp_dlg_regs->refcyc_per_pte_group_nom_c = dml_pow(2, 23) - 1;
41529d79ce1655 Roman Li 2022-06-28  1633  
41529d79ce1655 Roman Li 2022-06-28  1634  		// TODO: Is this the right calculation? Does htotal need to be halved?
41529d79ce1655 Roman Li 2022-06-28  1635  		disp_dlg_regs->refcyc_per_meta_chunk_nom_c = (unsigned int) ((double) meta_row_height_c / (double) vratio_c * (double) htotal * ref_freq_to_pix_freq
41529d79ce1655 Roman Li 2022-06-28  1636  				/ (double) meta_chunks_per_row_ub_c);
41529d79ce1655 Roman Li 2022-06-28  1637  		if (disp_dlg_regs->refcyc_per_meta_chunk_nom_c >= (unsigned int) dml_pow(2, 23))
41529d79ce1655 Roman Li 2022-06-28  1638  			disp_dlg_regs->refcyc_per_meta_chunk_nom_c = dml_pow(2, 23) - 1;
41529d79ce1655 Roman Li 2022-06-28  1639  	}
41529d79ce1655 Roman Li 2022-06-28  1640  
41529d79ce1655 Roman Li 2022-06-28  1641  	disp_dlg_regs->refcyc_per_line_delivery_pre_l = (unsigned int) dml_floor(refcyc_per_line_delivery_pre_l, 1);
41529d79ce1655 Roman Li 2022-06-28  1642  	disp_dlg_regs->refcyc_per_line_delivery_l = (unsigned int) dml_floor(refcyc_per_line_delivery_l, 1);
41529d79ce1655 Roman Li 2022-06-28  1643  	ASSERT(disp_dlg_regs->refcyc_per_line_delivery_pre_l < (unsigned int)dml_pow(2, 13)); ASSERT(disp_dlg_regs->refcyc_per_line_delivery_l < (unsigned int)dml_pow(2, 13));
41529d79ce1655 Roman Li 2022-06-28  1644  
41529d79ce1655 Roman Li 2022-06-28  1645  	disp_dlg_regs->refcyc_per_line_delivery_pre_c = (unsigned int) dml_floor(refcyc_per_line_delivery_pre_c, 1);
41529d79ce1655 Roman Li 2022-06-28  1646  	disp_dlg_regs->refcyc_per_line_delivery_c = (unsigned int) dml_floor(refcyc_per_line_delivery_c, 1);
41529d79ce1655 Roman Li 2022-06-28  1647  	ASSERT(disp_dlg_regs->refcyc_per_line_delivery_pre_c < (unsigned int)dml_pow(2, 13)); ASSERT(disp_dlg_regs->refcyc_per_line_delivery_c < (unsigned int)dml_pow(2, 13));
41529d79ce1655 Roman Li 2022-06-28  1648  
41529d79ce1655 Roman Li 2022-06-28  1649  	disp_dlg_regs->chunk_hdl_adjust_cur0 = 3;
41529d79ce1655 Roman Li 2022-06-28  1650  	disp_dlg_regs->dst_y_offset_cur0 = 0;
41529d79ce1655 Roman Li 2022-06-28  1651  	disp_dlg_regs->chunk_hdl_adjust_cur1 = 3;
41529d79ce1655 Roman Li 2022-06-28  1652  	disp_dlg_regs->dst_y_offset_cur1 = 0;
41529d79ce1655 Roman Li 2022-06-28  1653  
41529d79ce1655 Roman Li 2022-06-28  1654  	disp_dlg_regs->dst_y_delta_drq_limit = 0x7fff; // off
41529d79ce1655 Roman Li 2022-06-28  1655  
41529d79ce1655 Roman Li 2022-06-28  1656  	disp_ttu_regs->refcyc_per_req_delivery_pre_l = (unsigned int) (refcyc_per_req_delivery_pre_l * dml_pow(2, 10));
41529d79ce1655 Roman Li 2022-06-28  1657  	disp_ttu_regs->refcyc_per_req_delivery_l = (unsigned int) (refcyc_per_req_delivery_l * dml_pow(2, 10));
41529d79ce1655 Roman Li 2022-06-28  1658  	disp_ttu_regs->refcyc_per_req_delivery_pre_c = (unsigned int) (refcyc_per_req_delivery_pre_c * dml_pow(2, 10));
41529d79ce1655 Roman Li 2022-06-28  1659  	disp_ttu_regs->refcyc_per_req_delivery_c = (unsigned int) (refcyc_per_req_delivery_c * dml_pow(2, 10));
41529d79ce1655 Roman Li 2022-06-28  1660  	disp_ttu_regs->refcyc_per_req_delivery_pre_cur0 = (unsigned int) (refcyc_per_req_delivery_pre_cur0 * dml_pow(2, 10));
41529d79ce1655 Roman Li 2022-06-28  1661  	disp_ttu_regs->refcyc_per_req_delivery_cur0 = (unsigned int) (refcyc_per_req_delivery_cur0 * dml_pow(2, 10));
41529d79ce1655 Roman Li 2022-06-28  1662  	disp_ttu_regs->refcyc_per_req_delivery_pre_cur1 = (unsigned int) (refcyc_per_req_delivery_pre_cur1 * dml_pow(2, 10));
41529d79ce1655 Roman Li 2022-06-28  1663  	disp_ttu_regs->refcyc_per_req_delivery_cur1 = (unsigned int) (refcyc_per_req_delivery_cur1 * dml_pow(2, 10));
41529d79ce1655 Roman Li 2022-06-28  1664  
41529d79ce1655 Roman Li 2022-06-28  1665  	disp_ttu_regs->qos_level_low_wm = 0;
41529d79ce1655 Roman Li 2022-06-28  1666  	ASSERT(disp_ttu_regs->qos_level_low_wm < dml_pow(2, 14));
41529d79ce1655 Roman Li 2022-06-28  1667  
41529d79ce1655 Roman Li 2022-06-28  1668  	disp_ttu_regs->qos_level_high_wm = (unsigned int) (4.0 * (double) htotal * ref_freq_to_pix_freq);
41529d79ce1655 Roman Li 2022-06-28  1669  	ASSERT(disp_ttu_regs->qos_level_high_wm < dml_pow(2, 14));
41529d79ce1655 Roman Li 2022-06-28  1670  
41529d79ce1655 Roman Li 2022-06-28  1671  	disp_ttu_regs->qos_level_flip = 14;
41529d79ce1655 Roman Li 2022-06-28  1672  	disp_ttu_regs->qos_level_fixed_l = 8;
41529d79ce1655 Roman Li 2022-06-28  1673  	disp_ttu_regs->qos_level_fixed_c = 8;
41529d79ce1655 Roman Li 2022-06-28  1674  	disp_ttu_regs->qos_level_fixed_cur0 = 8;
41529d79ce1655 Roman Li 2022-06-28  1675  	disp_ttu_regs->qos_ramp_disable_l = 0;
41529d79ce1655 Roman Li 2022-06-28  1676  	disp_ttu_regs->qos_ramp_disable_c = 0;
41529d79ce1655 Roman Li 2022-06-28  1677  	disp_ttu_regs->qos_ramp_disable_cur0 = 0;
41529d79ce1655 Roman Li 2022-06-28  1678  
41529d79ce1655 Roman Li 2022-06-28  1679  	disp_ttu_regs->min_ttu_vblank = min_ttu_vblank * refclk_freq_in_mhz;
41529d79ce1655 Roman Li 2022-06-28  1680  	ASSERT(disp_ttu_regs->min_ttu_vblank < dml_pow(2, 24));
41529d79ce1655 Roman Li 2022-06-28  1681  
41529d79ce1655 Roman Li 2022-06-28  1682  	print__ttu_regs_st(mode_lib, disp_ttu_regs);
41529d79ce1655 Roman Li 2022-06-28  1683  	print__dlg_regs_st(mode_lib, disp_dlg_regs);
41529d79ce1655 Roman Li 2022-06-28  1684  }
41529d79ce1655 Roman Li 2022-06-28  1685  

:::::: The code at line 1004 was first introduced by commit
:::::: 41529d79ce1655bd7463c01d9813d0abb6fb08a4 drm/amd/display: Add DCN314 DML calculation support

:::::: TO: Roman Li <roman.li@amd.com>
:::::: CC: Alex Deucher <alexander.deucher@amd.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

--lfMMhuJdLSP5mfuz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=config

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 6.0.0-rc4 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="clang version 14.0.6 (git://gitmirror/llvm_project f28c006a5895fc0e329fe15fead81e37457cb1d1)"
CONFIG_GCC_VERSION=0
CONFIG_CC_IS_CLANG=y
CONFIG_CLANG_VERSION=140006
CONFIG_AS_IS_LLVM=y
CONFIG_AS_VERSION=140006
CONFIG_LD_VERSION=0
CONFIG_LD_IS_LLD=y
CONFIG_LLD_VERSION=140006
CONFIG_CC_CAN_LINK=y
CONFIG_CC_CAN_LINK_STATIC=y
CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y
CONFIG_TOOLS_SUPPORT_RELR=y
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
CONFIG_BROKEN_ON_SMP=y
CONFIG_INIT_ENV_ARG_LIMIT=32
CONFIG_COMPILE_TEST=y
# CONFIG_WERROR is not set
CONFIG_LOCALVERSION=""
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
CONFIG_HAVE_KERNEL_ZSTD=y
CONFIG_KERNEL_GZIP=y
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
# CONFIG_KERNEL_ZSTD is not set
CONFIG_DEFAULT_INIT=""
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_COMPAT=y
CONFIG_POSIX_MQUEUE=y
CONFIG_WATCH_QUEUE=y
CONFIG_CROSS_MEMORY_ATTACH=y
CONFIG_USELIB=y
CONFIG_AUDIT=y
CONFIG_HAVE_ARCH_AUDITSYSCALL=y
CONFIG_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_INJECTION=y
CONFIG_HARDIRQS_SW_RESEND=y
CONFIG_GENERIC_IRQ_CHIP=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_IRQ_FASTEOI_HIERARCHY_HANDLERS=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
CONFIG_GENERIC_IRQ_DEBUGFS=y
# end of IRQ subsystem

CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_INIT=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y
CONFIG_HAVE_POSIX_CPU_TIMERS_TASK_WORK=y
CONFIG_TIME_KUNIT_TEST=y
CONFIG_CONTEXT_TRACKING=y
CONFIG_CONTEXT_TRACKING_IDLE=y

#
# Timers subsystem
#
CONFIG_HZ_PERIODIC=y
# CONFIG_NO_HZ_IDLE is not set
CONFIG_CONTEXT_TRACKING_USER=y
CONFIG_CONTEXT_TRACKING_USER_FORCE=y
# CONFIG_NO_HZ is not set
# CONFIG_HIGH_RES_TIMERS is not set
CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US=100
# end of Timers subsystem

CONFIG_BPF=y
CONFIG_HAVE_EBPF_JIT=y
CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y

#
# BPF subsystem
#
CONFIG_BPF_SYSCALL=y
CONFIG_BPF_UNPRIV_DEFAULT_OFF=y
CONFIG_USERMODE_DRIVER=y
# end of BPF subsystem

CONFIG_PREEMPT_BUILD=y
# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
CONFIG_PREEMPT=y
CONFIG_PREEMPT_COUNT=y
CONFIG_PREEMPTION=y
# CONFIG_PREEMPT_DYNAMIC is not set

#
# CPU/Task time and stats accounting
#
CONFIG_VIRT_CPU_ACCOUNTING=y
# CONFIG_TICK_CPU_ACCOUNTING is not set
CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
# CONFIG_IRQ_TIME_ACCOUNTING is not set
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_TASKSTATS=y
# CONFIG_TASK_DELAY_ACCT is not set
CONFIG_TASK_XACCT=y
CONFIG_TASK_IO_ACCOUNTING=y
CONFIG_PSI=y
CONFIG_PSI_DEFAULT_DISABLED=y
# end of CPU/Task time and stats accounting

CONFIG_CPU_ISOLATION=y

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
CONFIG_PREEMPT_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_TASKS_RCU=y
CONFIG_TASKS_RUDE_RCU=y
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
# end of RCU Subsystem

# CONFIG_IKCONFIG is not set
# CONFIG_IKHEADERS is not set
CONFIG_LOG_BUF_SHIFT=17
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
# CONFIG_PRINTK_INDEX is not set
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y

#
# Scheduler features
#
# end of Scheduler features

CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CC_HAS_INT128=y
CONFIG_CC_IMPLICIT_FALLTHROUGH="-Wimplicit-fallthrough"
CONFIG_GCC12_NO_ARRAY_BOUNDS=y
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
# CONFIG_CGROUP_FAVOR_DYNMODS is not set
# CONFIG_MEMCG is not set
CONFIG_BLK_CGROUP=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
# CONFIG_CFS_BANDWIDTH is not set
# CONFIG_RT_GROUP_SCHED is not set
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
# CONFIG_CGROUP_FREEZER is not set
CONFIG_CGROUP_HUGETLB=y
# CONFIG_CGROUP_DEVICE is not set
CONFIG_CGROUP_CPUACCT=y
# CONFIG_CGROUP_PERF is not set
# CONFIG_CGROUP_BPF is not set
CONFIG_CGROUP_MISC=y
CONFIG_CGROUP_DEBUG=y
CONFIG_SOCK_CGROUP_DATA=y
# CONFIG_NAMESPACES is not set
# CONFIG_CHECKPOINT_RESTORE is not set
CONFIG_SCHED_AUTOGROUP=y
CONFIG_SYSFS_DEPRECATED=y
CONFIG_SYSFS_DEPRECATED_V2=y
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
# CONFIG_RD_GZIP is not set
# CONFIG_RD_BZIP2 is not set
# CONFIG_RD_LZMA is not set
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
# CONFIG_RD_ZSTD is not set
CONFIG_BOOT_CONFIG=y
CONFIG_BOOT_CONFIG_EMBED=y
CONFIG_BOOT_CONFIG_EMBED_FILE=""
CONFIG_INITRAMFS_PRESERVE_MTIME=y
# CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE is not set
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
CONFIG_LD_ORPHAN_WARN=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_EXPERT=y
# CONFIG_UID16 is not set
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
# CONFIG_SYSFS_SYSCALL is not set
CONFIG_FHANDLE=y
# CONFIG_POSIX_TIMERS is not set
CONFIG_PRINTK=y
CONFIG_BUG=y
# CONFIG_PCSPKR_PLATFORM is not set
CONFIG_BASE_FULL=y
# CONFIG_FUTEX is not set
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
# CONFIG_AIO is not set
CONFIG_IO_URING=y
# CONFIG_ADVISE_SYSCALLS is not set
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_KCMP=y
CONFIG_RSEQ=y
CONFIG_DEBUG_RSEQ=y
# CONFIG_EMBEDDED is not set
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

CONFIG_64BIT=y
CONFIG_X86_64=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf64-x86-64"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=28
CONFIG_ARCH_MMAP_RND_BITS_MAX=32
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_NR_GPIO=1024
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_AUDIT_ARCH=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_DYNAMIC_PHYSICAL_MASK=y
CONFIG_PGTABLE_LEVELS=4
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
# CONFIG_SMP is not set
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_MPPARSE=y
CONFIG_GOLDFISH=y
CONFIG_X86_CPU_RESCTRL=y
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_GOLDFISH is not set
CONFIG_IOSF_MBI=y
CONFIG_IOSF_MBI_DEBUG=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
# CONFIG_HYPERVISOR_GUEST is not set
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_GENERIC_CPU=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=64
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_PROCESSOR_SELECT=y
# CONFIG_CPU_SUP_INTEL is not set
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_HYGON=y
# CONFIG_CPU_SUP_CENTAUR is not set
# CONFIG_CPU_SUP_ZHAOXIN is not set
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
# CONFIG_GART_IOMMU is not set
CONFIG_BOOT_VESA_SUPPORT=y
CONFIG_NR_CPUS_RANGE_BEGIN=1
CONFIG_NR_CPUS_RANGE_END=1
CONFIG_NR_CPUS_DEFAULT=1
CONFIG_NR_CPUS=1
CONFIG_UP_LATE_INIT=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
# CONFIG_X86_MCE is not set

#
# Performance monitoring
#
# CONFIG_PERF_EVENTS_INTEL_RAPL is not set
# CONFIG_PERF_EVENTS_AMD_POWER is not set
CONFIG_PERF_EVENTS_AMD_UNCORE=y
CONFIG_PERF_EVENTS_AMD_BRS=y
# end of Performance monitoring

# CONFIG_X86_VSYSCALL_EMULATION is not set
CONFIG_X86_IOPL_IOPERM=y
CONFIG_MICROCODE=y
# CONFIG_MICROCODE_AMD is not set
CONFIG_MICROCODE_LATE_LOADING=y
# CONFIG_X86_MSR is not set
CONFIG_X86_CPUID=y
# CONFIG_X86_5LEVEL is not set
CONFIG_X86_DIRECT_GBPAGES=y
# CONFIG_X86_CPA_STATISTICS is not set
CONFIG_X86_MEM_ENCRYPT=y
CONFIG_AMD_MEM_ENCRYPT=y
CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
CONFIG_ARCH_MEMORY_PROBE=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
# CONFIG_X86_CHECK_BIOS_CORRUPTION is not set
# CONFIG_MTRR is not set
# CONFIG_X86_UMIP is not set
CONFIG_CC_HAS_IBT=y
# CONFIG_X86_KERNEL_IBT is not set
# CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS is not set
CONFIG_HZ_100=y
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=100
# CONFIG_KEXEC is not set
CONFIG_KEXEC_FILE=y
CONFIG_ARCH_HAS_KEXEC_PURGATORY=y
CONFIG_KEXEC_SIG=y
# CONFIG_KEXEC_SIG_FORCE is not set
CONFIG_CRASH_DUMP=y
CONFIG_PHYSICAL_START=0x1000000
# CONFIG_RELOCATABLE is not set
CONFIG_PHYSICAL_ALIGN=0x200000
# CONFIG_COMPAT_VDSO is not set
# CONFIG_LEGACY_VSYSCALL_XONLY is not set
CONFIG_LEGACY_VSYSCALL_NONE=y
CONFIG_CMDLINE_BOOL=y
CONFIG_CMDLINE=""
# CONFIG_MODIFY_LDT_SYSCALL is not set
# CONFIG_STRICT_SIGALTSTACK_SIZE is not set
CONFIG_HAVE_LIVEPATCH=y
# end of Processor type and features

CONFIG_SPECULATION_MITIGATIONS=y
# CONFIG_PAGE_TABLE_ISOLATION is not set
CONFIG_RETPOLINE=y
# CONFIG_CPU_IBPB_ENTRY is not set
CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE=y

#
# Power management and ACPI options
#
CONFIG_ARCH_HIBERNATION_HEADER=y
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
CONFIG_SUSPEND_SKIP_SYNC=y
CONFIG_HIBERNATE_CALLBACKS=y
CONFIG_HIBERNATION=y
# CONFIG_HIBERNATION_SNAPSHOT_DEV is not set
CONFIG_PM_STD_PARTITION=""
CONFIG_PM_SLEEP=y
CONFIG_PM_AUTOSLEEP=y
# CONFIG_PM_USERSPACE_AUTOSLEEP is not set
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM=y
# CONFIG_PM_DEBUG is not set
CONFIG_PM_CLK=y
CONFIG_PM_GENERIC_DOMAINS=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
CONFIG_PM_GENERIC_DOMAINS_SLEEP=y
CONFIG_ARCH_SUPPORTS_ACPI=y
# CONFIG_ACPI is not set

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
CONFIG_CPU_FREQ_STAT=y
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
# CONFIG_CPU_FREQ_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y

#
# CPU frequency scaling drivers
#
# CONFIG_X86_INTEL_PSTATE is not set
CONFIG_X86_P4_CLOCKMOD=y

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=y
# end of CPU Frequency scaling

#
# CPU Idle
#
# CONFIG_CPU_IDLE is not set
# end of CPU Idle
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
CONFIG_PCI_DIRECT=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
CONFIG_ISA_BUS=y
CONFIG_ISA_DMA_API=y
CONFIG_AMD_NB=y
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
CONFIG_IA32_EMULATION=y
CONFIG_COMPAT_32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
# end of Binary Emulations

CONFIG_HAVE_KVM=y
# CONFIG_VIRTUALIZATION is not set
CONFIG_AS_AVX512=y
CONFIG_AS_SHA1_NI=y
CONFIG_AS_SHA256_NI=y
CONFIG_AS_TPAUSE=y

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_GENERIC_ENTRY=y
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
CONFIG_STATIC_CALL_SELFTEST=y
CONFIG_UPROBES=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_ARCH_CORRECT_STACKTRACE_ON_KRETPROBE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_TRACE_IRQFLAGS_NMI_SUPPORT=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_ARCH_WANTS_NO_INSTR=y
CONFIG_HAVE_ASM_MODVERSIONS=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
CONFIG_MMU_GATHER_MERGE_VMAS=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
CONFIG_HAVE_ARCH_SECCOMP=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP=y
CONFIG_SECCOMP_FILTER=y
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR_STRONG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG_THIN=y
CONFIG_LTO_NONE=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING_USER=y
CONFIG_HAVE_CONTEXT_TRACKING_USER_OFFSTACK=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PUD=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_HAVE_ARCH_HUGE_VMALLOC=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=28
CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
CONFIG_PAGE_SIZE_LESS_THAN_64KB=y
CONFIG_PAGE_SIZE_LESS_THAN_256KB=y
CONFIG_HAVE_OBJTOOL=y
CONFIG_HAVE_JUMP_LABEL_HACK=y
CONFIG_HAVE_NOINSTR_HACK=y
CONFIG_HAVE_NOINSTR_VALIDATION=y
CONFIG_HAVE_UACCESS_VALIDATION=y
CONFIG_HAVE_STACK_VALIDATION=y
CONFIG_HAVE_RELIABLE_STACKTRACE=y
CONFIG_ISA_BUS_API=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_COMPAT_OLD_SIGACTION=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_VMAP_STACK=y
CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET=y
CONFIG_RANDOMIZE_KSTACK_OFFSET=y
# CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT is not set
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
CONFIG_ARCH_USE_MEMREMAP_PROT=y
CONFIG_LOCK_EVENT_COUNTS=y
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_ARCH_HAS_CC_PLATFORM=y
CONFIG_HAVE_STATIC_CALL=y
CONFIG_HAVE_STATIC_CALL_INLINE=y
CONFIG_HAVE_PREEMPT_DYNAMIC=y
CONFIG_HAVE_PREEMPT_DYNAMIC_CALL=y
CONFIG_ARCH_WANT_LD_ORPHAN_WARN=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_ARCH_SUPPORTS_PAGE_TABLE_CHECK=y
CONFIG_ARCH_HAS_ELFCORE_COMPAT=y
CONFIG_ARCH_HAS_PARANOID_L1D_FLUSH=y
CONFIG_DYNAMIC_SIGFRAME=y

#
# GCOV-based kernel profiling
#
CONFIG_GCOV_KERNEL=y
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_HAVE_GCC_PLUGINS=y
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
# CONFIG_MODULES is not set
CONFIG_BLOCK=y
# CONFIG_BLOCK_LEGACY_AUTOLOAD is not set
CONFIG_BLK_DEV_BSG_COMMON=y
CONFIG_BLK_ICQ=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_INTEGRITY_T10=y
CONFIG_BLK_DEV_ZONED=y
# CONFIG_BLK_DEV_THROTTLING is not set
# CONFIG_BLK_WBT is not set
# CONFIG_BLK_CGROUP_IOLATENCY is not set
# CONFIG_BLK_CGROUP_IOCOST is not set
CONFIG_BLK_CGROUP_IOPRIO=y
CONFIG_BLK_DEBUG_FS=y
CONFIG_BLK_DEBUG_FS_ZONED=y
# CONFIG_BLK_SED_OPAL is not set
# CONFIG_BLK_INLINE_ENCRYPTION is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
CONFIG_ACORN_PARTITION=y
# CONFIG_ACORN_PARTITION_CUMANA is not set
CONFIG_ACORN_PARTITION_EESOX=y
CONFIG_ACORN_PARTITION_ICS=y
CONFIG_ACORN_PARTITION_ADFS=y
# CONFIG_ACORN_PARTITION_POWERTEC is not set
# CONFIG_ACORN_PARTITION_RISCIX is not set
# CONFIG_AIX_PARTITION is not set
# CONFIG_OSF_PARTITION is not set
# CONFIG_AMIGA_PARTITION is not set
CONFIG_ATARI_PARTITION=y
CONFIG_MAC_PARTITION=y
# CONFIG_MSDOS_PARTITION is not set
CONFIG_LDM_PARTITION=y
CONFIG_LDM_DEBUG=y
# CONFIG_SGI_PARTITION is not set
CONFIG_ULTRIX_PARTITION=y
# CONFIG_SUN_PARTITION is not set
CONFIG_KARMA_PARTITION=y
# CONFIG_EFI_PARTITION is not set
CONFIG_SYSV68_PARTITION=y
# CONFIG_CMDLINE_PARTITION is not set
# end of Partition Types

CONFIG_BLOCK_COMPAT=y
CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_PM=y
CONFIG_BLOCK_HOLDER_DEPRECATED=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=y
CONFIG_IOSCHED_BFQ=y
# CONFIG_BFQ_GROUP_IOSCHED is not set
# end of IO Schedulers

CONFIG_ASN1=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_ELF_KUNIT_TEST=y
CONFIG_COMPAT_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=y
# CONFIG_COREDUMP is not set
# end of Executable file formats

#
# Memory Management options
#
CONFIG_SWAP=y
# CONFIG_ZSWAP is not set

#
# SLAB allocator options
#
# CONFIG_SLAB is not set
# CONFIG_SLUB is not set
CONFIG_SLOB=y
# end of SLAB allocator options

CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
CONFIG_COMPAT_BRK=y
CONFIG_SPARSEMEM=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_EXCLUSIVE_SYSTEM_RAM=y
CONFIG_HAVE_BOOTMEM_INFO_NODE=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_MEMORY_HOTPLUG=y
CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE=y
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_MHP_MEMMAP_ON_MEMORY=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_COMPACTION=y
CONFIG_PAGE_REPORTING=y
CONFIG_MIGRATION=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_MMU_NOTIFIER=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ARCH_WANTS_THP_SWAP=y
# CONFIG_TRANSPARENT_HUGEPAGE is not set
CONFIG_NEED_PER_CPU_KM=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_CMA=y
# CONFIG_CMA_DEBUG is not set
CONFIG_CMA_DEBUGFS=y
CONFIG_CMA_SYSFS=y
CONFIG_CMA_AREAS=7
CONFIG_GENERIC_EARLY_IOREMAP=y
# CONFIG_IDLE_PAGE_TRACKING is not set
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_CURRENT_STACK_POINTER=y
CONFIG_ARCH_HAS_PTE_DEVMAP=y
CONFIG_ARCH_HAS_ZONE_DMA_SET=y
# CONFIG_ZONE_DMA is not set
CONFIG_ZONE_DMA32=y
# CONFIG_ZONE_DEVICE is not set
CONFIG_HMM_MIRROR=y
CONFIG_VMAP_PFN=y
CONFIG_VM_EVENT_COUNTERS=y
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_TEST is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_MAPPING_DIRTY_HELPERS=y
CONFIG_SECRETMEM=y
CONFIG_USERFAULTFD=y
CONFIG_HAVE_ARCH_USERFAULTFD_WP=y
CONFIG_HAVE_ARCH_USERFAULTFD_MINOR=y
CONFIG_PTE_MARKER=y
CONFIG_PTE_MARKER_UFFD_WP=y

#
# Data Access Monitoring
#
# CONFIG_DAMON is not set
# end of Data Access Monitoring
# end of Memory Management options

CONFIG_NET=y
CONFIG_WANT_COMPAT_NETLINK_MESSAGES=y
CONFIG_COMPAT_NETLINK_MESSAGES=y
CONFIG_NET_INGRESS=y
CONFIG_NET_EGRESS=y
CONFIG_SKB_EXTENSIONS=y

#
# Networking options
#
# CONFIG_PACKET is not set
# CONFIG_UNIX is not set
CONFIG_TLS=y
# CONFIG_TLS_DEVICE is not set
# CONFIG_TLS_TOE is not set
CONFIG_XFRM=y
CONFIG_XFRM_OFFLOAD=y
CONFIG_XFRM_ALGO=y
CONFIG_XFRM_USER=y
CONFIG_XFRM_USER_COMPAT=y
CONFIG_XFRM_INTERFACE=y
# CONFIG_XFRM_SUB_POLICY is not set
# CONFIG_XFRM_MIGRATE is not set
CONFIG_XFRM_AH=y
CONFIG_XFRM_ESP=y
CONFIG_XFRM_IPCOMP=y
# CONFIG_NET_KEY is not set
CONFIG_XFRM_ESPINTCP=y
# CONFIG_XDP_SOCKETS is not set
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
CONFIG_NET_IPGRE_DEMUX=y
CONFIG_NET_IP_TUNNEL=y
CONFIG_NET_IPGRE=y
CONFIG_IP_MROUTE_COMMON=y
# CONFIG_SYN_COOKIES is not set
# CONFIG_NET_IPVTI is not set
CONFIG_NET_UDP_TUNNEL=y
CONFIG_NET_FOU=y
# CONFIG_NET_FOU_IP_TUNNELS is not set
# CONFIG_INET_AH is not set
CONFIG_INET_ESP=y
# CONFIG_INET_ESP_OFFLOAD is not set
# CONFIG_INET_ESPINTCP is not set
# CONFIG_INET_IPCOMP is not set
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
# CONFIG_INET_UDP_DIAG is not set
CONFIG_INET_RAW_DIAG=y
# CONFIG_INET_DIAG_DESTROY is not set
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_CUBIC=y
CONFIG_DEFAULT_TCP_CONG="cubic"
# CONFIG_TCP_MD5SIG is not set
CONFIG_IPV6=y
# CONFIG_IPV6_ROUTER_PREF is not set
# CONFIG_IPV6_OPTIMISTIC_DAD is not set
CONFIG_INET6_AH=y
CONFIG_INET6_ESP=y
CONFIG_INET6_ESP_OFFLOAD=y
CONFIG_INET6_ESPINTCP=y
CONFIG_INET6_IPCOMP=y
CONFIG_IPV6_MIP6=y
CONFIG_IPV6_ILA=y
CONFIG_INET6_XFRM_TUNNEL=y
CONFIG_INET6_TUNNEL=y
CONFIG_IPV6_VTI=y
# CONFIG_IPV6_SIT is not set
CONFIG_IPV6_TUNNEL=y
CONFIG_IPV6_GRE=y
CONFIG_IPV6_FOU=y
CONFIG_IPV6_MULTIPLE_TABLES=y
CONFIG_IPV6_SUBTREES=y
CONFIG_IPV6_MROUTE=y
# CONFIG_IPV6_MROUTE_MULTIPLE_TABLES is not set
# CONFIG_IPV6_PIMSM_V2 is not set
# CONFIG_IPV6_SEG6_LWTUNNEL is not set
CONFIG_IPV6_SEG6_HMAC=y
# CONFIG_IPV6_RPL_LWTUNNEL is not set
CONFIG_IPV6_IOAM6_LWTUNNEL=y
# CONFIG_NETLABEL is not set
# CONFIG_MPTCP is not set
CONFIG_NETWORK_SECMARK=y
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_ADVANCED is not set

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_INGRESS=y
CONFIG_NETFILTER_EGRESS=y
CONFIG_NETFILTER_NETLINK=y
CONFIG_NETFILTER_NETLINK_LOG=y
CONFIG_NF_CONNTRACK=y
CONFIG_NF_LOG_SYSLOG=y
CONFIG_NF_CONNTRACK_SECMARK=y
CONFIG_NF_CONNTRACK_LABELS=y
CONFIG_NF_CONNTRACK_FTP=y
CONFIG_NF_CONNTRACK_IRC=y
# CONFIG_NF_CONNTRACK_NETBIOS_NS is not set
CONFIG_NF_CONNTRACK_SIP=y
CONFIG_NF_CT_NETLINK=y
# CONFIG_NETFILTER_NETLINK_GLUE_CT is not set
CONFIG_NF_NAT=y
CONFIG_NF_NAT_FTP=y
CONFIG_NF_NAT_IRC=y
CONFIG_NF_NAT_SIP=y
CONFIG_NF_NAT_REDIRECT=y
CONFIG_NF_NAT_MASQUERADE=y
# CONFIG_NF_TABLES is not set
CONFIG_NETFILTER_XTABLES=y
# CONFIG_NETFILTER_XTABLES_COMPAT is not set

#
# Xtables combined modules
#
CONFIG_NETFILTER_XT_MARK=y

#
# Xtables targets
#
CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=y
CONFIG_NETFILTER_XT_TARGET_LOG=y
CONFIG_NETFILTER_XT_NAT=y
# CONFIG_NETFILTER_XT_TARGET_NETMAP is not set
CONFIG_NETFILTER_XT_TARGET_NFLOG=y
CONFIG_NETFILTER_XT_TARGET_REDIRECT=y
CONFIG_NETFILTER_XT_TARGET_MASQUERADE=y
# CONFIG_NETFILTER_XT_TARGET_SECMARK is not set
CONFIG_NETFILTER_XT_TARGET_TCPMSS=y

#
# Xtables matches
#
# CONFIG_NETFILTER_XT_MATCH_ADDRTYPE is not set
# CONFIG_NETFILTER_XT_MATCH_CONNTRACK is not set
CONFIG_NETFILTER_XT_MATCH_POLICY=y
CONFIG_NETFILTER_XT_MATCH_STATE=y
# end of Core Netfilter Configuration

CONFIG_IP_SET=y
CONFIG_IP_SET_MAX=256
# CONFIG_IP_SET_BITMAP_IP is not set
CONFIG_IP_SET_BITMAP_IPMAC=y
# CONFIG_IP_SET_BITMAP_PORT is not set
CONFIG_IP_SET_HASH_IP=y
# CONFIG_IP_SET_HASH_IPMARK is not set
# CONFIG_IP_SET_HASH_IPPORT is not set
CONFIG_IP_SET_HASH_IPPORTIP=y
# CONFIG_IP_SET_HASH_IPPORTNET is not set
CONFIG_IP_SET_HASH_IPMAC=y
CONFIG_IP_SET_HASH_MAC=y
CONFIG_IP_SET_HASH_NETPORTNET=y
CONFIG_IP_SET_HASH_NET=y
CONFIG_IP_SET_HASH_NETNET=y
CONFIG_IP_SET_HASH_NETPORT=y
CONFIG_IP_SET_HASH_NETIFACE=y
# CONFIG_IP_SET_LIST_SET is not set
# CONFIG_IP_VS is not set

#
# IP: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV4=y
CONFIG_NF_SOCKET_IPV4=y
CONFIG_NF_TPROXY_IPV4=y
CONFIG_NF_DUP_IPV4=y
CONFIG_NF_LOG_ARP=y
CONFIG_NF_LOG_IPV4=y
CONFIG_NF_REJECT_IPV4=y
CONFIG_IP_NF_IPTABLES=y
# CONFIG_IP_NF_FILTER is not set
CONFIG_IP_NF_NAT=y
CONFIG_IP_NF_TARGET_MASQUERADE=y
CONFIG_IP_NF_MANGLE=y
CONFIG_IP_NF_RAW=y
# end of IP: Netfilter Configuration

#
# IPv6: Netfilter Configuration
#
# CONFIG_NF_SOCKET_IPV6 is not set
CONFIG_NF_TPROXY_IPV6=y
CONFIG_NF_DUP_IPV6=y
CONFIG_NF_REJECT_IPV6=y
CONFIG_NF_LOG_IPV6=y
CONFIG_IP6_NF_IPTABLES=y
CONFIG_IP6_NF_MATCH_IPV6HEADER=y
# CONFIG_IP6_NF_FILTER is not set
CONFIG_IP6_NF_MANGLE=y
# CONFIG_IP6_NF_RAW is not set
# end of IPv6: Netfilter Configuration

CONFIG_NF_DEFRAG_IPV6=y
CONFIG_NF_CONNTRACK_BRIDGE=y
CONFIG_BPFILTER=y
CONFIG_BPFILTER_UMH=y
# CONFIG_IP_DCCP is not set
CONFIG_IP_SCTP=y
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5 is not set
CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1=y
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
CONFIG_SCTP_COOKIE_HMAC_MD5=y
CONFIG_SCTP_COOKIE_HMAC_SHA1=y
CONFIG_INET_SCTP_DIAG=y
CONFIG_RDS=y
CONFIG_RDS_TCP=y
CONFIG_RDS_DEBUG=y
CONFIG_TIPC=y
CONFIG_TIPC_MEDIA_UDP=y
# CONFIG_TIPC_CRYPTO is not set
CONFIG_TIPC_DIAG=y
# CONFIG_ATM is not set
CONFIG_L2TP=y
CONFIG_L2TP_DEBUGFS=y
CONFIG_L2TP_V3=y
CONFIG_L2TP_IP=y
CONFIG_L2TP_ETH=y
# CONFIG_BRIDGE is not set
CONFIG_NET_DSA=y
CONFIG_NET_DSA_TAG_AR9331=y
CONFIG_NET_DSA_TAG_BRCM_COMMON=y
CONFIG_NET_DSA_TAG_BRCM=y
CONFIG_NET_DSA_TAG_BRCM_LEGACY=y
CONFIG_NET_DSA_TAG_BRCM_PREPEND=y
CONFIG_NET_DSA_TAG_HELLCREEK=y
CONFIG_NET_DSA_TAG_GSWIP=y
# CONFIG_NET_DSA_TAG_DSA is not set
# CONFIG_NET_DSA_TAG_EDSA is not set
CONFIG_NET_DSA_TAG_MTK=y
CONFIG_NET_DSA_TAG_KSZ=y
CONFIG_NET_DSA_TAG_OCELOT=y
# CONFIG_NET_DSA_TAG_OCELOT_8021Q is not set
CONFIG_NET_DSA_TAG_QCA=y
CONFIG_NET_DSA_TAG_RTL4_A=y
CONFIG_NET_DSA_TAG_RTL8_4=y
# CONFIG_NET_DSA_TAG_RZN1_A5PSW is not set
CONFIG_NET_DSA_TAG_LAN9303=y
CONFIG_NET_DSA_TAG_SJA1105=y
CONFIG_NET_DSA_TAG_TRAILER=y
CONFIG_NET_DSA_TAG_XRS700X=y
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
CONFIG_LLC=y
# CONFIG_LLC2 is not set
CONFIG_ATALK=y
CONFIG_DEV_APPLETALK=y
CONFIG_IPDDP=y
CONFIG_IPDDP_ENCAP=y
CONFIG_X25=y
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
# CONFIG_6LOWPAN is not set
# CONFIG_IEEE802154 is not set
# CONFIG_NET_SCHED is not set
# CONFIG_DCB is not set
# CONFIG_DNS_RESOLVER is not set
# CONFIG_BATMAN_ADV is not set
# CONFIG_OPENVSWITCH is not set
CONFIG_VSOCKETS=y
CONFIG_VSOCKETS_DIAG=y
CONFIG_VSOCKETS_LOOPBACK=y
# CONFIG_VMWARE_VMCI_VSOCKETS is not set
CONFIG_VIRTIO_VSOCKETS=y
CONFIG_VIRTIO_VSOCKETS_COMMON=y
# CONFIG_NETLINK_DIAG is not set
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=y
CONFIG_NET_NSH=y
# CONFIG_HSR is not set
CONFIG_NET_SWITCHDEV=y
CONFIG_NET_L3_MASTER_DEV=y
CONFIG_QRTR=y
CONFIG_QRTR_SMD=y
# CONFIG_QRTR_TUN is not set
# CONFIG_QRTR_MHI is not set
# CONFIG_NET_NCSI is not set
CONFIG_CGROUP_NET_PRIO=y
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y

#
# Network testing
#
# CONFIG_NET_DROP_MONITOR is not set
# end of Network testing
# end of Networking options

CONFIG_HAMRADIO=y

#
# Packet Radio protocols
#
CONFIG_AX25=y
# CONFIG_AX25_DAMA_SLAVE is not set
# CONFIG_NETROM is not set
CONFIG_ROSE=y

#
# AX.25 network device drivers
#
CONFIG_BPQETHER=y
CONFIG_BAYCOM_SER_FDX=y
CONFIG_BAYCOM_SER_HDX=y
CONFIG_BAYCOM_PAR=y
# CONFIG_YAM is not set
# end of AX.25 network device drivers

CONFIG_CAN=y
# CONFIG_CAN_RAW is not set
CONFIG_CAN_BCM=y
CONFIG_CAN_GW=y
# CONFIG_CAN_J1939 is not set
# CONFIG_CAN_ISOTP is not set
CONFIG_BT=y
# CONFIG_BT_BREDR is not set
CONFIG_BT_LE=y
CONFIG_BT_LEDS=y
CONFIG_BT_MSFTEXT=y
# CONFIG_BT_AOSPEXT is not set
# CONFIG_BT_DEBUGFS is not set
CONFIG_BT_SELFTEST=y
# CONFIG_BT_SELFTEST_ECDH is not set
# CONFIG_BT_SELFTEST_SMP is not set
CONFIG_BT_FEATURE_DEBUG=y

#
# Bluetooth device drivers
#
CONFIG_BT_INTEL=y
CONFIG_BT_QCA=y
CONFIG_BT_MTK=y
CONFIG_BT_HCIBTUSB=y
# CONFIG_BT_HCIBTUSB_AUTOSUSPEND is not set
# CONFIG_BT_HCIBTUSB_BCM is not set
CONFIG_BT_HCIBTUSB_MTK=y
# CONFIG_BT_HCIBTUSB_RTL is not set
# CONFIG_BT_HCIBCM203X is not set
# CONFIG_BT_HCIBPA10X is not set
CONFIG_BT_HCIBFUSB=y
CONFIG_BT_HCIVHCI=y
CONFIG_BT_MRVL=y
CONFIG_BT_ATH3K=y
# CONFIG_BT_MTKUART is not set
CONFIG_BT_QCOMSMD=y
CONFIG_BT_VIRTIO=y
# end of Bluetooth device drivers

CONFIG_AF_RXRPC=y
CONFIG_AF_RXRPC_IPV6=y
CONFIG_AF_RXRPC_INJECT_LOSS=y
CONFIG_AF_RXRPC_DEBUG=y
# CONFIG_RXKAD is not set
CONFIG_AF_KCM=y
CONFIG_STREAM_PARSER=y
# CONFIG_MCTP is not set
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
# CONFIG_CFG80211 is not set

#
# CFG80211 needs to be enabled for MAC80211
#
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
CONFIG_RFKILL=y
CONFIG_RFKILL_LEDS=y
CONFIG_RFKILL_GPIO=y
CONFIG_NET_9P=y
CONFIG_NET_9P_FD=y
CONFIG_NET_9P_VIRTIO=y
# CONFIG_NET_9P_DEBUG is not set
CONFIG_CAIF=y
CONFIG_CAIF_DEBUG=y
CONFIG_CAIF_NETDEV=y
# CONFIG_CAIF_USB is not set
# CONFIG_CEPH_LIB is not set
CONFIG_NFC=y
CONFIG_NFC_DIGITAL=y
CONFIG_NFC_NCI=y
CONFIG_NFC_NCI_SPI=y
CONFIG_NFC_HCI=y
CONFIG_NFC_SHDLC=y

#
# Near Field Communication (NFC) devices
#
CONFIG_NFC_TRF7970A=y
CONFIG_NFC_MEI_PHY=y
# CONFIG_NFC_SIM is not set
# CONFIG_NFC_PORT100 is not set
# CONFIG_NFC_VIRTUAL_NCI is not set
CONFIG_NFC_FDP=y
# CONFIG_NFC_FDP_I2C is not set
CONFIG_NFC_PN544=y
# CONFIG_NFC_PN544_I2C is not set
CONFIG_NFC_PN544_MEI=y
CONFIG_NFC_PN533=y
CONFIG_NFC_PN533_USB=y
CONFIG_NFC_PN533_I2C=y
CONFIG_NFC_PN532_UART=y
CONFIG_NFC_MICROREAD=y
CONFIG_NFC_MICROREAD_I2C=y
# CONFIG_NFC_MICROREAD_MEI is not set
CONFIG_NFC_MRVL=y
CONFIG_NFC_MRVL_USB=y
CONFIG_NFC_MRVL_I2C=y
CONFIG_NFC_MRVL_SPI=y
# CONFIG_NFC_ST21NFCA_I2C is not set
CONFIG_NFC_ST_NCI=y
CONFIG_NFC_ST_NCI_I2C=y
# CONFIG_NFC_ST_NCI_SPI is not set
CONFIG_NFC_NXP_NCI=y
CONFIG_NFC_NXP_NCI_I2C=y
CONFIG_NFC_S3FWRN5=y
CONFIG_NFC_S3FWRN5_I2C=y
# CONFIG_NFC_S3FWRN82_UART is not set
CONFIG_NFC_ST95HF=y
# end of Near Field Communication (NFC) devices

CONFIG_PSAMPLE=y
# CONFIG_NET_IFE is not set
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_NET_SELFTESTS=y
CONFIG_NET_SOCK_MSG=y
CONFIG_NET_DEVLINK=y
CONFIG_PAGE_POOL=y
# CONFIG_PAGE_POOL_STATS is not set
CONFIG_FAILOVER=y
CONFIG_ETHTOOL_NETLINK=y
CONFIG_NETDEV_ADDR_LIST_TEST=y

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
# CONFIG_EISA is not set
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCIEPORTBUS=y
# CONFIG_HOTPLUG_PCI_PCIE is not set
# CONFIG_PCIEAER is not set
CONFIG_PCIEASPM=y
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
CONFIG_PCIE_PME=y
CONFIG_PCIE_PTM=y
CONFIG_PCI_MSI=y
CONFIG_PCI_MSI_IRQ_DOMAIN=y
# CONFIG_PCI_QUIRKS is not set
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
CONFIG_PCI_STUB=y
CONFIG_PCI_PF_STUB=y
CONFIG_PCI_ATS=y
CONFIG_PCI_ECAM=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
CONFIG_PCI_PRI=y
CONFIG_PCI_PASID=y
CONFIG_PCI_LABEL=y
# CONFIG_PCIE_BUS_TUNE_OFF is not set
# CONFIG_PCIE_BUS_DEFAULT is not set
# CONFIG_PCIE_BUS_SAFE is not set
CONFIG_PCIE_BUS_PERFORMANCE=y
# CONFIG_PCIE_BUS_PEER2PEER is not set
# CONFIG_VGA_ARB is not set
CONFIG_HOTPLUG_PCI=y
CONFIG_HOTPLUG_PCI_CPCI=y
# CONFIG_HOTPLUG_PCI_CPCI_ZT5550 is not set
CONFIG_HOTPLUG_PCI_CPCI_GENERIC=y
# CONFIG_HOTPLUG_PCI_SHPC is not set

#
# PCI controller drivers
#
CONFIG_PCIE_XILINX_NWL=y
CONFIG_PCI_TEGRA=y
CONFIG_PCIE_RCAR_HOST=y
CONFIG_PCI_HOST_COMMON=y
CONFIG_PCIE_XILINX=y
CONFIG_PCIE_XILINX_CPM=y
# CONFIG_PCI_VERSATILE is not set
CONFIG_PCIE_ALTERA=y
CONFIG_PCIE_ALTERA_MSI=y
CONFIG_PCIE_MEDIATEK_GEN3=y
# CONFIG_VMD is not set
CONFIG_PCIE_MT7621=y

#
# DesignWare PCI Core Support
#
CONFIG_PCIE_DW=y
CONFIG_PCIE_DW_HOST=y
# CONFIG_PCIE_DW_PLAT_HOST is not set
CONFIG_PCI_EXYNOS=y
# CONFIG_PCI_IMX6 is not set
# CONFIG_PCIE_SPEAR13XX is not set
# CONFIG_PCI_KEYSTONE_HOST is not set
# CONFIG_PCIE_ARMADA_8K is not set
# CONFIG_PCIE_ARTPEC6_HOST is not set
CONFIG_PCIE_KEEMBAY=y
CONFIG_PCIE_KEEMBAY_HOST=y
CONFIG_PCIE_HISI_STB=y
CONFIG_PCI_MESON=y
CONFIG_PCIE_TEGRA194=y
CONFIG_PCIE_TEGRA194_HOST=y
# CONFIG_PCIE_VISCONTI_HOST is not set
CONFIG_PCIE_FU740=y
# end of DesignWare PCI Core Support

#
# Mobiveil PCIe Core Support
#
CONFIG_PCIE_MOBIVEIL=y
CONFIG_PCIE_MOBIVEIL_HOST=y
CONFIG_PCIE_LAYERSCAPE_GEN4=y
# end of Mobiveil PCIe Core Support

#
# Cadence PCIe controllers support
#
# end of Cadence PCIe controllers support
# end of PCI controller drivers

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set
# end of PCI Endpoint

#
# PCI switch controller drivers
#
CONFIG_PCI_SW_SWITCHTEC=y
# end of PCI switch controller drivers

# CONFIG_CXL_BUS is not set
CONFIG_PCCARD=y
# CONFIG_PCMCIA is not set
CONFIG_CARDBUS=y

#
# PC-card bridges
#
CONFIG_YENTA=y
# CONFIG_YENTA_O2 is not set
CONFIG_YENTA_RICOH=y
CONFIG_YENTA_TI=y
CONFIG_YENTA_ENE_TUNE=y
CONFIG_YENTA_TOSHIBA=y
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
CONFIG_AUXILIARY_BUS=y
CONFIG_UEVENT_HELPER=y
CONFIG_UEVENT_HELPER_PATH=""
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
CONFIG_DEVTMPFS_SAFE=y
CONFIG_STANDALONE=y
# CONFIG_PREVENT_FIRMWARE_BUILD is not set

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_FW_LOADER_SYSFS=y
CONFIG_EXTRA_FIRMWARE=""
# CONFIG_FW_LOADER_USER_HELPER is not set
# CONFIG_FW_LOADER_COMPRESS is not set
CONFIG_FW_CACHE=y
CONFIG_FW_UPLOAD=y
# end of Firmware loader

CONFIG_WANT_DEV_COREDUMP=y
CONFIG_ALLOW_DEV_COREDUMP=y
CONFIG_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
CONFIG_DEBUG_DEVRES=y
CONFIG_DEBUG_TEST_DRIVER_REMOVE=y
CONFIG_PM_QOS_KUNIT_TEST=y
CONFIG_DRIVER_PE_KUNIT_TEST=y
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_SOC_BUS=y
CONFIG_REGMAP=y
CONFIG_REGMAP_AC97=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SPI=y
CONFIG_REGMAP_SPMI=y
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_REGMAP_SCCB=y
CONFIG_REGMAP_I3C=y
CONFIG_REGMAP_SPI_AVMM=y
CONFIG_DMA_SHARED_BUFFER=y
CONFIG_DMA_FENCE_TRACE=y
# end of Generic Driver Options

#
# Bus devices
#
# CONFIG_ARM_INTEGRATOR_LM is not set
CONFIG_BT1_APB=y
# CONFIG_BT1_AXI is not set
CONFIG_HISILICON_LPC=y
CONFIG_INTEL_IXP4XX_EB=y
# CONFIG_QCOM_EBI2 is not set
CONFIG_MHI_BUS=y
CONFIG_MHI_BUS_DEBUG=y
CONFIG_MHI_BUS_PCI_GENERIC=y
# CONFIG_MHI_BUS_EP is not set
# end of Bus devices

CONFIG_CONNECTOR=y
CONFIG_PROC_EVENTS=y

#
# Firmware Drivers
#

#
# ARM System Control and Management Interface Protocol
#
CONFIG_ARM_SCMI_PROTOCOL=y
CONFIG_ARM_SCMI_HAVE_TRANSPORT=y
CONFIG_ARM_SCMI_HAVE_MSG=y
# CONFIG_ARM_SCMI_TRANSPORT_MAILBOX is not set
CONFIG_ARM_SCMI_TRANSPORT_VIRTIO=y
CONFIG_ARM_SCMI_TRANSPORT_VIRTIO_VERSION1_COMPLIANCE=y
# CONFIG_ARM_SCMI_TRANSPORT_VIRTIO_ATOMIC_ENABLE is not set
CONFIG_ARM_SCMI_POWER_DOMAIN=y
# CONFIG_ARM_SCMI_POWER_CONTROL is not set
# end of ARM System Control and Management Interface Protocol

# CONFIG_ARM_SCPI_PROTOCOL is not set
CONFIG_EDD=y
# CONFIG_EDD_OFF is not set
# CONFIG_FIRMWARE_MEMMAP is not set
CONFIG_DMIID=y
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
CONFIG_FW_CFG_SYSFS=y
CONFIG_FW_CFG_SYSFS_CMDLINE=y
CONFIG_MTK_ADSP_IPC=y
CONFIG_QCOM_SCM=y
# CONFIG_QCOM_SCM_DOWNLOAD_MODE_DEFAULT is not set
CONFIG_SYSFB=y
# CONFIG_SYSFB_SIMPLEFB is not set
CONFIG_BCM47XX_NVRAM=y
# CONFIG_BCM47XX_SPROM is not set
# CONFIG_TEE_BNXT_FW is not set
CONFIG_CS_DSP=y
# CONFIG_GOOGLE_FIRMWARE is not set

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

# CONFIG_GNSS is not set
CONFIG_MTD=y

#
# Partition parsers
#
# CONFIG_MTD_AR7_PARTS is not set
CONFIG_MTD_BCM63XX_PARTS=y
CONFIG_MTD_CMDLINE_PARTS=y
CONFIG_MTD_PARSER_IMAGETAG=y
CONFIG_MTD_PARSER_TRX=y
CONFIG_MTD_SHARPSL_PARTS=y
CONFIG_MTD_REDBOOT_PARTS=y
CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=-1
# CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED is not set
# CONFIG_MTD_REDBOOT_PARTS_READONLY is not set
CONFIG_MTD_QCOMSMEM_PARTS=y
# end of Partition parsers

#
# User Modules And Translation Layers
#
CONFIG_MTD_BLKDEVS=y
# CONFIG_MTD_BLOCK is not set
# CONFIG_MTD_BLOCK_RO is not set
CONFIG_FTL=y
CONFIG_NFTL=y
# CONFIG_NFTL_RW is not set
CONFIG_INFTL=y
# CONFIG_RFD_FTL is not set
CONFIG_SSFDC=y
CONFIG_SM_FTL=y
CONFIG_MTD_OOPS=y
CONFIG_MTD_SWAP=y
# CONFIG_MTD_PARTITIONED_MASTER is not set

#
# RAM/ROM/Flash chip drivers
#
CONFIG_MTD_CFI=y
CONFIG_MTD_JEDECPROBE=y
CONFIG_MTD_GEN_PROBE=y
# CONFIG_MTD_CFI_ADV_OPTIONS is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
CONFIG_MTD_CFI_INTELEXT=y
CONFIG_MTD_CFI_AMDSTD=y
CONFIG_MTD_CFI_STAA=y
CONFIG_MTD_CFI_UTIL=y
CONFIG_MTD_RAM=y
# CONFIG_MTD_ROM is not set
CONFIG_MTD_ABSENT=y
# end of RAM/ROM/Flash chip drivers

#
# Mapping drivers for chip access
#
CONFIG_MTD_COMPLEX_MAPPINGS=y
CONFIG_MTD_PHYSMAP=y
CONFIG_MTD_PHYSMAP_COMPAT=y
CONFIG_MTD_PHYSMAP_START=0x8000000
CONFIG_MTD_PHYSMAP_LEN=0
CONFIG_MTD_PHYSMAP_BANKWIDTH=2
CONFIG_MTD_PHYSMAP_GPIO_ADDR=y
# CONFIG_MTD_SC520CDP is not set
CONFIG_MTD_NETSC520=y
CONFIG_MTD_TS5500=y
CONFIG_MTD_SBC_GXX=y
CONFIG_MTD_AMD76XROM=y
CONFIG_MTD_ICHXROM=y
# CONFIG_MTD_ESB2ROM is not set
CONFIG_MTD_CK804XROM=y
CONFIG_MTD_SCB2_FLASH=y
CONFIG_MTD_NETtel=y
CONFIG_MTD_L440GX=y
CONFIG_MTD_PCI=y
# CONFIG_MTD_INTEL_VR_NOR is not set
CONFIG_MTD_PLATRAM=y
# end of Mapping drivers for chip access

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_PMC551 is not set
# CONFIG_MTD_DATAFLASH is not set
# CONFIG_MTD_MCHP23K256 is not set
CONFIG_MTD_MCHP48L640=y
CONFIG_MTD_SPEAR_SMI=y
CONFIG_MTD_SST25L=y
CONFIG_MTD_SLRAM=y
# CONFIG_MTD_PHRAM is not set
CONFIG_MTD_MTDRAM=y
CONFIG_MTDRAM_TOTAL_SIZE=4096
CONFIG_MTDRAM_ERASE_SIZE=128
# CONFIG_MTD_BLOCK2MTD is not set

#
# Disk-On-Chip Device Drivers
#
# CONFIG_MTD_DOCG3 is not set
# end of Self-contained MTD device drivers

#
# NAND
#
CONFIG_MTD_NAND_CORE=y
# CONFIG_MTD_ONENAND is not set
# CONFIG_MTD_RAW_NAND is not set
# CONFIG_MTD_SPI_NAND is not set

#
# ECC engine support
#
CONFIG_MTD_NAND_ECC=y
CONFIG_MTD_NAND_ECC_SW_HAMMING=y
CONFIG_MTD_NAND_ECC_SW_HAMMING_SMC=y
# CONFIG_MTD_NAND_ECC_SW_BCH is not set
# CONFIG_MTD_NAND_ECC_MXIC is not set
CONFIG_MTD_NAND_ECC_MEDIATEK=y
# end of ECC engine support
# end of NAND

#
# LPDDR & LPDDR2 PCM memory drivers
#
# CONFIG_MTD_LPDDR is not set
# end of LPDDR & LPDDR2 PCM memory drivers

# CONFIG_MTD_SPI_NOR is not set
# CONFIG_MTD_UBI is not set
# CONFIG_MTD_HYPERBUS is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
CONFIG_PARPORT_PC_FIFO=y
# CONFIG_PARPORT_PC_SUPERIO is not set
CONFIG_PARPORT_AX88796=y
# CONFIG_PARPORT_1284 is not set
CONFIG_PARPORT_NOT_PC=y
# CONFIG_BLK_DEV is not set

#
# NVME Support
#
CONFIG_NVME_CORE=y
# CONFIG_BLK_DEV_NVME is not set
CONFIG_NVME_MULTIPATH=y
CONFIG_NVME_VERBOSE_ERRORS=y
CONFIG_NVME_HWMON=y
CONFIG_NVME_FABRICS=y
# CONFIG_NVME_FC is not set
CONFIG_NVME_TCP=y
# CONFIG_NVME_AUTH is not set
CONFIG_NVME_TARGET=y
CONFIG_NVME_TARGET_PASSTHRU=y
# CONFIG_NVME_TARGET_LOOP is not set
CONFIG_NVME_TARGET_FC=y
CONFIG_NVME_TARGET_TCP=y
# CONFIG_NVME_TARGET_AUTH is not set
# end of NVME Support

#
# Misc devices
#
# CONFIG_AD525X_DPOT is not set
# CONFIG_DUMMY_IRQ is not set
CONFIG_PHANTOM=y
# CONFIG_TIFM_CORE is not set
CONFIG_ICS932S401=y
CONFIG_ATMEL_SSC=y
CONFIG_ENCLOSURE_SERVICES=y
# CONFIG_CS5535_MFGPT is not set
# CONFIG_GEHC_ACHC is not set
CONFIG_HP_ILO=y
# CONFIG_QCOM_COINCELL is not set
# CONFIG_QCOM_FASTRPC is not set
# CONFIG_APDS9802ALS is not set
CONFIG_ISL29003=y
CONFIG_ISL29020=y
CONFIG_SENSORS_TSL2550=y
CONFIG_SENSORS_BH1770=y
# CONFIG_SENSORS_APDS990X is not set
CONFIG_HMC6352=y
CONFIG_DS1682=y
CONFIG_PCH_PHUB=y
CONFIG_LATTICE_ECP3_CONFIG=y
# CONFIG_SRAM is not set
# CONFIG_DW_XDATA_PCIE is not set
CONFIG_PCI_ENDPOINT_TEST=y
CONFIG_XILINX_SDFEC=y
CONFIG_MISC_RTSX=y
CONFIG_HISI_HIKEY_USB=y
CONFIG_C2PORT=y
# CONFIG_C2PORT_DURAMAR_2150 is not set

#
# EEPROM support
#
CONFIG_EEPROM_AT24=y
CONFIG_EEPROM_AT25=y
# CONFIG_EEPROM_LEGACY is not set
CONFIG_EEPROM_MAX6875=y
CONFIG_EEPROM_93CX6=y
CONFIG_EEPROM_93XX46=y
# CONFIG_EEPROM_IDT_89HPESX is not set
CONFIG_EEPROM_EE1004=y
# end of EEPROM support

CONFIG_CB710_CORE=y
# CONFIG_CB710_DEBUG is not set
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
# end of Texas Instruments shared transport line discipline

CONFIG_ALTERA_STAPL=y
CONFIG_INTEL_MEI=y
CONFIG_INTEL_MEI_ME=y
CONFIG_INTEL_MEI_TXE=y
CONFIG_INTEL_MEI_GSC=y
CONFIG_INTEL_MEI_HDCP=y
CONFIG_INTEL_MEI_PXP=y
CONFIG_VMWARE_VMCI=y
CONFIG_GENWQE=y
CONFIG_GENWQE_PLATFORM_ERROR_RECOVERY=0
CONFIG_ECHO=y
# CONFIG_BCM_VK is not set
# CONFIG_MISC_ALCOR_PCI is not set
CONFIG_MISC_RTSX_PCI=y
# CONFIG_MISC_RTSX_USB is not set
CONFIG_HABANA_AI=y
# CONFIG_UACCE is not set
CONFIG_PVPANIC=y
CONFIG_PVPANIC_PCI=y
# end of Misc devices

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=y
CONFIG_SCSI_COMMON=y
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_NETLINK=y

#
# SCSI support type (disk, tape, CD-ROM)
#
# CONFIG_BLK_DEV_SD is not set
CONFIG_CHR_DEV_ST=y
CONFIG_CHR_DEV_SG=y
# CONFIG_BLK_DEV_BSG is not set
# CONFIG_CHR_DEV_SCH is not set
CONFIG_SCSI_ENCLOSURE=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=y
CONFIG_SCSI_FC_ATTRS=y
CONFIG_SCSI_ISCSI_ATTRS=y
CONFIG_SCSI_SAS_ATTRS=y
CONFIG_SCSI_SAS_LIBSAS=y
# CONFIG_SCSI_SAS_HOST_SMP is not set
CONFIG_SCSI_SRP_ATTRS=y
# end of SCSI Transports

CONFIG_SCSI_LOWLEVEL=y
CONFIG_ISCSI_TCP=y
CONFIG_ISCSI_BOOT_SYSFS=y
CONFIG_SCSI_CXGB3_ISCSI=y
CONFIG_SCSI_CXGB4_ISCSI=y
# CONFIG_SCSI_BNX2_ISCSI is not set
# CONFIG_BE2ISCSI is not set
CONFIG_BLK_DEV_3W_XXXX_RAID=y
# CONFIG_SCSI_HPSA is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_3W_SAS is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
CONFIG_SCSI_AIC7XXX=y
CONFIG_AIC7XXX_CMDS_PER_DEVICE=32
CONFIG_AIC7XXX_RESET_DELAY_MS=5000
# CONFIG_AIC7XXX_BUILD_FIRMWARE is not set
# CONFIG_AIC7XXX_DEBUG_ENABLE is not set
CONFIG_AIC7XXX_DEBUG_MASK=0
# CONFIG_AIC7XXX_REG_PRETTY_PRINT is not set
CONFIG_SCSI_AIC79XX=y
CONFIG_AIC79XX_CMDS_PER_DEVICE=32
CONFIG_AIC79XX_RESET_DELAY_MS=5000
# CONFIG_AIC79XX_BUILD_FIRMWARE is not set
CONFIG_AIC79XX_DEBUG_ENABLE=y
CONFIG_AIC79XX_DEBUG_MASK=0
# CONFIG_AIC79XX_REG_PRETTY_PRINT is not set
CONFIG_SCSI_AIC94XX=y
# CONFIG_AIC94XX_DEBUG is not set
# CONFIG_SCSI_MVSAS is not set
CONFIG_SCSI_MVUMI=y
CONFIG_SCSI_ADVANSYS=y
CONFIG_SCSI_ARCMSR=y
CONFIG_SCSI_ESAS2R=y
# CONFIG_MEGARAID_NEWGEN is not set
CONFIG_MEGARAID_LEGACY=y
CONFIG_MEGARAID_SAS=y
CONFIG_SCSI_MPT3SAS=y
CONFIG_SCSI_MPT2SAS_MAX_SGE=128
CONFIG_SCSI_MPT3SAS_MAX_SGE=128
CONFIG_SCSI_MPT2SAS=y
CONFIG_SCSI_MPI3MR=y
CONFIG_SCSI_SMARTPQI=y
CONFIG_SCSI_HPTIOP=y
# CONFIG_SCSI_BUSLOGIC is not set
CONFIG_SCSI_MYRB=y
CONFIG_SCSI_MYRS=y
# CONFIG_VMWARE_PVSCSI is not set
# CONFIG_LIBFC is not set
# CONFIG_SCSI_SNIC is not set
CONFIG_SCSI_DMX3191D=y
# CONFIG_SCSI_FDOMAIN_PCI is not set
# CONFIG_SCSI_ISCI is not set
CONFIG_SCSI_IPS=y
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
CONFIG_SCSI_PPA=y
CONFIG_SCSI_IMM=y
# CONFIG_SCSI_IZIP_EPP16 is not set
# CONFIG_SCSI_IZIP_SLOW_CTR is not set
# CONFIG_SCSI_STEX is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
CONFIG_SCSI_QLOGIC_1280=y
CONFIG_SCSI_QLA_FC=y
CONFIG_SCSI_QLA_ISCSI=y
CONFIG_SCSI_LPFC=y
CONFIG_SCSI_LPFC_DEBUG_FS=y
# CONFIG_SCSI_EFCT is not set
# CONFIG_SCSI_DC395x is not set
CONFIG_SCSI_AM53C974=y
CONFIG_SCSI_WD719X=y
CONFIG_SCSI_DEBUG=y
# CONFIG_SCSI_PMCRAID is not set
CONFIG_SCSI_PM8001=y
CONFIG_SCSI_BFA_FC=y
CONFIG_SCSI_VIRTIO=y
CONFIG_SCSI_CHELSIO_FCOE=y
# CONFIG_SCSI_DH is not set
# end of SCSI device support

# CONFIG_ATA is not set
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
# CONFIG_MD_AUTODETECT is not set
# CONFIG_MD_LINEAR is not set
CONFIG_MD_RAID0=y
CONFIG_MD_RAID1=y
CONFIG_MD_RAID10=y
# CONFIG_MD_RAID456 is not set
# CONFIG_MD_MULTIPATH is not set
CONFIG_MD_FAULTY=y
# CONFIG_MD_CLUSTER is not set
# CONFIG_BCACHE is not set
# CONFIG_BLK_DEV_DM is not set
CONFIG_DM_AUDIT=y
CONFIG_TARGET_CORE=y
CONFIG_TCM_IBLOCK=y
# CONFIG_TCM_FILEIO is not set
# CONFIG_TCM_PSCSI is not set
# CONFIG_LOOPBACK_TARGET is not set
CONFIG_ISCSI_TARGET=y
# CONFIG_ISCSI_TARGET_CXGB4 is not set
CONFIG_SBP_TARGET=y
CONFIG_FUSION=y
# CONFIG_FUSION_SPI is not set
# CONFIG_FUSION_FC is not set
CONFIG_FUSION_SAS=y
CONFIG_FUSION_MAX_SGE=128
CONFIG_FUSION_CTL=y
CONFIG_FUSION_LOGGING=y

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=y
CONFIG_FIREWIRE_OHCI=y
# CONFIG_FIREWIRE_SBP2 is not set
CONFIG_FIREWIRE_NET=y
CONFIG_FIREWIRE_NOSY=y
# end of IEEE 1394 (FireWire) support

# CONFIG_MACINTOSH_DRIVERS is not set
CONFIG_NETDEVICES=y
CONFIG_MII=y
# CONFIG_NET_CORE is not set
# CONFIG_ARCNET is not set
# CONFIG_CAIF_DRIVERS is not set

#
# Distributed Switch Architecture drivers
#
CONFIG_B53=y
CONFIG_B53_SPI_DRIVER=y
# CONFIG_B53_MDIO_DRIVER is not set
CONFIG_B53_MMAP_DRIVER=y
CONFIG_B53_SRAB_DRIVER=y
# CONFIG_B53_SERDES is not set
CONFIG_NET_DSA_BCM_SF2=y
CONFIG_NET_DSA_LOOP=y
CONFIG_NET_DSA_LANTIQ_GSWIP=y
CONFIG_NET_DSA_MT7530=y
CONFIG_NET_DSA_MV88E6060=y
CONFIG_NET_DSA_MICROCHIP_KSZ_COMMON=y
CONFIG_NET_DSA_MICROCHIP_KSZ9477_I2C=y
# CONFIG_NET_DSA_MICROCHIP_KSZ_SPI is not set
CONFIG_NET_DSA_MICROCHIP_KSZ8863_SMI=y
# CONFIG_NET_DSA_MV88E6XXX is not set
CONFIG_NET_DSA_AR9331=y
CONFIG_NET_DSA_QCA8K=y
# CONFIG_NET_DSA_SJA1105 is not set
CONFIG_NET_DSA_XRS700X=y
CONFIG_NET_DSA_XRS700X_I2C=y
# CONFIG_NET_DSA_XRS700X_MDIO is not set
CONFIG_NET_DSA_REALTEK=y
# CONFIG_NET_DSA_REALTEK_MDIO is not set
# CONFIG_NET_DSA_REALTEK_SMI is not set
CONFIG_NET_DSA_REALTEK_RTL8365MB=y
CONFIG_NET_DSA_REALTEK_RTL8366RB=y
CONFIG_NET_DSA_SMSC_LAN9303=y
CONFIG_NET_DSA_SMSC_LAN9303_I2C=y
CONFIG_NET_DSA_SMSC_LAN9303_MDIO=y
CONFIG_NET_DSA_VITESSE_VSC73XX=y
CONFIG_NET_DSA_VITESSE_VSC73XX_SPI=y
CONFIG_NET_DSA_VITESSE_VSC73XX_PLATFORM=y
# end of Distributed Switch Architecture drivers

CONFIG_ETHERNET=y
CONFIG_MDIO=y
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_NET_VENDOR_ACTIONS is not set
# CONFIG_NET_VENDOR_ADAPTEC is not set
# CONFIG_NET_VENDOR_AGERE is not set
# CONFIG_NET_VENDOR_ALACRITECH is not set
CONFIG_NET_VENDOR_ALTEON=y
CONFIG_ACENIC=y
CONFIG_ACENIC_OMIT_TIGON_I=y
# CONFIG_ALTERA_TSE is not set
CONFIG_NET_VENDOR_AMAZON=y
# CONFIG_ENA_ETHERNET is not set
# CONFIG_NET_VENDOR_AMD is not set
CONFIG_NET_XGENE=y
CONFIG_NET_XGENE_V2=y
# CONFIG_NET_VENDOR_AQUANTIA is not set
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ASIX=y
# CONFIG_SPI_AX88796C is not set
CONFIG_NET_VENDOR_ATHEROS=y
CONFIG_ATL2=y
CONFIG_ATL1=y
CONFIG_ATL1E=y
CONFIG_ATL1C=y
CONFIG_ALX=y
# CONFIG_CX_ECAT is not set
# CONFIG_NET_VENDOR_BROADCOM is not set
CONFIG_NET_VENDOR_CADENCE=y
CONFIG_MACB=y
CONFIG_MACB_PCI=y
CONFIG_NET_CALXEDA_XGMAC=y
# CONFIG_NET_VENDOR_CAVIUM is not set
CONFIG_NET_VENDOR_CHELSIO=y
CONFIG_CHELSIO_T1=y
# CONFIG_CHELSIO_T1_1G is not set
CONFIG_CHELSIO_T3=y
CONFIG_CHELSIO_T4=y
CONFIG_CHELSIO_T4VF=y
CONFIG_CHELSIO_LIB=y
# CONFIG_CHELSIO_INLINE_CRYPTO is not set
# CONFIG_NET_VENDOR_CIRRUS is not set
CONFIG_NET_VENDOR_CISCO=y
CONFIG_ENIC=y
# CONFIG_NET_VENDOR_CORTINA is not set
CONFIG_NET_VENDOR_DAVICOM=y
CONFIG_DM9000=y
# CONFIG_DM9000_FORCE_SIMPLE_PHY_POLL is not set
CONFIG_DM9051=y
CONFIG_DNET=y
CONFIG_NET_VENDOR_DEC=y
CONFIG_NET_TULIP=y
CONFIG_DE2104X=y
CONFIG_DE2104X_DSL=0
CONFIG_TULIP=y
# CONFIG_TULIP_MWI is not set
# CONFIG_TULIP_MMIO is not set
# CONFIG_TULIP_NAPI is not set
# CONFIG_WINBOND_840 is not set
# CONFIG_DM9102 is not set
CONFIG_ULI526X=y
CONFIG_PCMCIA_XIRCOM=y
# CONFIG_NET_VENDOR_DLINK is not set
# CONFIG_NET_VENDOR_EMULEX is not set
CONFIG_NET_VENDOR_ENGLEDER=y
CONFIG_TSNEP=y
CONFIG_TSNEP_SELFTESTS=y
CONFIG_NET_VENDOR_EZCHIP=y
CONFIG_NET_VENDOR_FARADAY=y
# CONFIG_NET_VENDOR_FREESCALE is not set
CONFIG_NET_VENDOR_FUNGIBLE=y
# CONFIG_FUN_ETH is not set
CONFIG_NET_VENDOR_GOOGLE=y
CONFIG_GVE=y
CONFIG_NET_VENDOR_HUAWEI=y
CONFIG_HINIC=y
# CONFIG_NET_VENDOR_INTEL is not set
CONFIG_NET_VENDOR_WANGXUN=y
# CONFIG_TXGBE is not set
CONFIG_JME=y
CONFIG_KORINA=y
CONFIG_NET_VENDOR_LITEX=y
CONFIG_NET_VENDOR_MARVELL=y
CONFIG_MV643XX_ETH=y
CONFIG_MVMDIO=y
# CONFIG_MVNETA is not set
# CONFIG_MVPP2 is not set
# CONFIG_PXA168_ETH is not set
CONFIG_SKGE=y
# CONFIG_SKGE_DEBUG is not set
CONFIG_SKGE_GENESIS=y
CONFIG_SKY2=y
# CONFIG_SKY2_DEBUG is not set
CONFIG_OCTEONTX2_MBOX=y
CONFIG_OCTEONTX2_AF=y
# CONFIG_NDC_DIS_DYNAMIC_CACHING is not set
# CONFIG_OCTEONTX2_PF is not set
# CONFIG_OCTEON_EP is not set
# CONFIG_NET_VENDOR_MEDIATEK is not set
CONFIG_NET_VENDOR_MELLANOX=y
# CONFIG_MLX4_EN is not set
CONFIG_MLX5_CORE=y
CONFIG_MLX5_FPGA=y
CONFIG_MLX5_CORE_EN=y
# CONFIG_MLX5_EN_RXNFC is not set
# CONFIG_MLX5_MPFS is not set
CONFIG_MLX5_ESWITCH=y
# CONFIG_MLX5_CORE_IPOIB is not set
CONFIG_MLX5_EN_IPSEC=y
# CONFIG_MLX5_SW_STEERING is not set
CONFIG_MLX5_SF=y
CONFIG_MLX5_SF_MANAGER=y
CONFIG_MLXSW_CORE=y
CONFIG_MLXSW_CORE_HWMON=y
# CONFIG_MLXSW_PCI is not set
# CONFIG_MLXSW_I2C is not set
CONFIG_MLXFW=y
# CONFIG_MLXBF_GIGE is not set
# CONFIG_NET_VENDOR_MICREL is not set
# CONFIG_NET_VENDOR_MICROCHIP is not set
# CONFIG_NET_VENDOR_MICROSEMI is not set
# CONFIG_NET_VENDOR_MICROSOFT is not set
CONFIG_NET_VENDOR_MYRI=y
CONFIG_MYRI10GE=y
CONFIG_FEALNX=y
CONFIG_NET_VENDOR_NI=y
# CONFIG_NI_XGE_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_NATSEMI=y
# CONFIG_NATSEMI is not set
CONFIG_NS83820=y
# CONFIG_NET_VENDOR_NETERION is not set
CONFIG_NET_VENDOR_NETRONOME=y
# CONFIG_NFP is not set
CONFIG_NET_VENDOR_8390=y
CONFIG_AX88796=y
# CONFIG_AX88796_93CX6 is not set
CONFIG_NE2K_PCI=y
CONFIG_NET_VENDOR_NVIDIA=y
CONFIG_FORCEDETH=y
# CONFIG_LPC_ENET is not set
# CONFIG_NET_VENDOR_OKI is not set
# CONFIG_ETHOC is not set
# CONFIG_NET_VENDOR_PACKET_ENGINES is not set
# CONFIG_NET_VENDOR_PENSANDO is not set
CONFIG_NET_VENDOR_QLOGIC=y
# CONFIG_QLA3XXX is not set
# CONFIG_QLCNIC is not set
# CONFIG_NETXEN_NIC is not set
# CONFIG_QED is not set
# CONFIG_NET_VENDOR_BROCADE is not set
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCOM_EMAC is not set
CONFIG_RMNET=y
# CONFIG_NET_VENDOR_RDC is not set
CONFIG_NET_VENDOR_REALTEK=y
CONFIG_ATP=y
CONFIG_8139CP=y
CONFIG_8139TOO=y
# CONFIG_8139TOO_PIO is not set
CONFIG_8139TOO_TUNE_TWISTER=y
CONFIG_8139TOO_8129=y
CONFIG_8139_OLD_RX_RESET=y
CONFIG_R8169=y
# CONFIG_NET_VENDOR_RENESAS is not set
# CONFIG_NET_VENDOR_ROCKER is not set
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
CONFIG_NET_VENDOR_SEEQ=y
CONFIG_NET_VENDOR_SILAN=y
CONFIG_SC92031=y
# CONFIG_NET_VENDOR_SIS is not set
# CONFIG_NET_VENDOR_SOLARFLARE is not set
CONFIG_NET_VENDOR_SMSC=y
# CONFIG_SMC91X is not set
# CONFIG_EPIC100 is not set
# CONFIG_SMC911X is not set
# CONFIG_SMSC911X is not set
# CONFIG_SMSC9420 is not set
CONFIG_NET_VENDOR_SOCIONEXT=y
# CONFIG_NET_VENDOR_STMICRO is not set
# CONFIG_NET_VENDOR_SUN is not set
CONFIG_NET_VENDOR_SUNPLUS=y
CONFIG_SP7021_EMAC=y
# CONFIG_NET_VENDOR_SYNOPSYS is not set
# CONFIG_NET_VENDOR_TEHUTI is not set
# CONFIG_NET_VENDOR_TI is not set
# CONFIG_NET_VENDOR_VERTEXCOM is not set
CONFIG_NET_VENDOR_VIA=y
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_VELOCITY is not set
CONFIG_NET_VENDOR_WIZNET=y
CONFIG_WIZNET_W5100=y
CONFIG_WIZNET_W5300=y
# CONFIG_WIZNET_BUS_DIRECT is not set
CONFIG_WIZNET_BUS_INDIRECT=y
# CONFIG_WIZNET_BUS_ANY is not set
# CONFIG_NET_VENDOR_XILINX is not set
CONFIG_FDDI=y
# CONFIG_DEFXX is not set
CONFIG_SKFP=y
# CONFIG_HIPPI is not set
CONFIG_PHYLINK=y
CONFIG_PHYLIB=y
CONFIG_SWPHY=y
# CONFIG_LED_TRIGGER_PHY is not set
CONFIG_FIXED_PHY=y
# CONFIG_SFP is not set

#
# MII PHY device drivers
#
CONFIG_AMD_PHY=y
CONFIG_MESON_GXL_PHY=y
CONFIG_ADIN_PHY=y
CONFIG_ADIN1100_PHY=y
# CONFIG_AQUANTIA_PHY is not set
CONFIG_AX88796B_PHY=y
# CONFIG_BROADCOM_PHY is not set
# CONFIG_BCM54140_PHY is not set
CONFIG_BCM63XX_PHY=y
CONFIG_BCM7XXX_PHY=y
# CONFIG_BCM84881_PHY is not set
CONFIG_BCM87XX_PHY=y
CONFIG_BCM_NET_PHYLIB=y
CONFIG_CICADA_PHY=y
CONFIG_CORTINA_PHY=y
# CONFIG_DAVICOM_PHY is not set
# CONFIG_ICPLUS_PHY is not set
CONFIG_LXT_PHY=y
# CONFIG_INTEL_XWAY_PHY is not set
CONFIG_LSI_ET1011C_PHY=y
CONFIG_MARVELL_PHY=y
# CONFIG_MARVELL_10G_PHY is not set
# CONFIG_MARVELL_88X2222_PHY is not set
# CONFIG_MAXLINEAR_GPHY is not set
CONFIG_MEDIATEK_GE_PHY=y
# CONFIG_MICREL_PHY is not set
CONFIG_MICROCHIP_PHY=y
# CONFIG_MICROCHIP_T1_PHY is not set
CONFIG_MICROSEMI_PHY=y
CONFIG_MOTORCOMM_PHY=y
# CONFIG_NATIONAL_PHY is not set
CONFIG_NXP_C45_TJA11XX_PHY=y
CONFIG_NXP_TJA11XX_PHY=y
# CONFIG_AT803X_PHY is not set
# CONFIG_QSEMI_PHY is not set
CONFIG_REALTEK_PHY=y
CONFIG_RENESAS_PHY=y
CONFIG_ROCKCHIP_PHY=y
CONFIG_SMSC_PHY=y
CONFIG_STE10XP=y
CONFIG_TERANETICS_PHY=y
CONFIG_DP83822_PHY=y
# CONFIG_DP83TC811_PHY is not set
CONFIG_DP83848_PHY=y
CONFIG_DP83867_PHY=y
CONFIG_DP83869_PHY=y
CONFIG_DP83TD510_PHY=y
CONFIG_VITESSE_PHY=y
CONFIG_XILINX_GMII2RGMII=y
CONFIG_MICREL_KS8995MA=y
CONFIG_CAN_DEV=y
# CONFIG_CAN_VCAN is not set
# CONFIG_CAN_VXCAN is not set
CONFIG_CAN_NETLINK=y
# CONFIG_CAN_CALC_BITTIMING is not set
CONFIG_CAN_RX_OFFLOAD=y
# CONFIG_CAN_AT91 is not set
CONFIG_CAN_FLEXCAN=y
# CONFIG_CAN_JANZ_ICAN3 is not set
CONFIG_CAN_KVASER_PCIEFD=y
# CONFIG_CAN_SUN4I is not set
CONFIG_CAN_XILINXCAN=y
# CONFIG_PCH_CAN is not set
# CONFIG_CAN_C_CAN is not set
CONFIG_CAN_CC770=y
CONFIG_CAN_CC770_ISA=y
# CONFIG_CAN_CC770_PLATFORM is not set
CONFIG_CAN_CTUCANFD=y
# CONFIG_CAN_CTUCANFD_PCI is not set
# CONFIG_CAN_CTUCANFD_PLATFORM is not set
# CONFIG_CAN_IFI_CANFD is not set
CONFIG_CAN_M_CAN=y
CONFIG_CAN_M_CAN_PCI=y
CONFIG_CAN_M_CAN_PLATFORM=y
# CONFIG_CAN_M_CAN_TCAN4X5X is not set
CONFIG_CAN_PEAK_PCIEFD=y
CONFIG_CAN_RCAR=y
# CONFIG_CAN_RCAR_CANFD is not set
# CONFIG_CAN_SJA1000 is not set
# CONFIG_CAN_SOFTING is not set

#
# CAN SPI interfaces
#
CONFIG_CAN_HI311X=y
CONFIG_CAN_MCP251X=y
# CONFIG_CAN_MCP251XFD is not set
# end of CAN SPI interfaces

#
# CAN USB interfaces
#
CONFIG_CAN_8DEV_USB=y
# CONFIG_CAN_EMS_USB is not set
# CONFIG_CAN_ESD_USB is not set
# CONFIG_CAN_ETAS_ES58X is not set
CONFIG_CAN_GS_USB=y
CONFIG_CAN_KVASER_USB=y
CONFIG_CAN_MCBA_USB=y
CONFIG_CAN_PEAK_USB=y
CONFIG_CAN_UCAN=y
# end of CAN USB interfaces

CONFIG_CAN_DEBUG_DEVICES=y
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
CONFIG_FWNODE_MDIO=y
CONFIG_MDIO_DEVRES=y
CONFIG_MDIO_SUN4I=y
CONFIG_MDIO_XGENE=y
CONFIG_MDIO_BITBANG=y
CONFIG_MDIO_BCM_UNIMAC=y
CONFIG_MDIO_CAVIUM=y
CONFIG_MDIO_GPIO=y
CONFIG_MDIO_MVUSB=y
# CONFIG_MDIO_MSCC_MIIM is not set
CONFIG_MDIO_MOXART=y
CONFIG_MDIO_OCTEON=y
CONFIG_MDIO_THUNDER=y

#
# MDIO Multiplexers
#

#
# PCS device drivers
#
# end of PCS device drivers

CONFIG_PLIP=y
CONFIG_PPP=y
# CONFIG_PPP_BSDCOMP is not set
CONFIG_PPP_DEFLATE=y
CONFIG_PPP_FILTER=y
CONFIG_PPP_MPPE=y
# CONFIG_PPP_MULTILINK is not set
CONFIG_PPPOE=y
CONFIG_PPTP=y
# CONFIG_PPPOL2TP is not set
CONFIG_SLHC=y
CONFIG_USB_NET_DRIVERS=y
CONFIG_USB_CATC=y
# CONFIG_USB_KAWETH is not set
CONFIG_USB_PEGASUS=y
# CONFIG_USB_RTL8150 is not set
CONFIG_USB_RTL8152=y
# CONFIG_USB_LAN78XX is not set
CONFIG_USB_USBNET=y
CONFIG_USB_NET_AX8817X=y
CONFIG_USB_NET_AX88179_178A=y
CONFIG_USB_NET_CDCETHER=y
CONFIG_USB_NET_CDC_EEM=y
CONFIG_USB_NET_CDC_NCM=y
CONFIG_USB_NET_HUAWEI_CDC_NCM=y
CONFIG_USB_NET_CDC_MBIM=y
# CONFIG_USB_NET_DM9601 is not set
CONFIG_USB_NET_SR9700=y
CONFIG_USB_NET_SR9800=y
CONFIG_USB_NET_SMSC75XX=y
CONFIG_USB_NET_SMSC95XX=y
CONFIG_USB_NET_GL620A=y
CONFIG_USB_NET_NET1080=y
CONFIG_USB_NET_PLUSB=y
CONFIG_USB_NET_MCS7830=y
CONFIG_USB_NET_RNDIS_HOST=y
# CONFIG_USB_NET_CDC_SUBSET is not set
CONFIG_USB_NET_ZAURUS=y
CONFIG_USB_NET_CX82310_ETH=y
CONFIG_USB_NET_KALMIA=y
# CONFIG_USB_NET_QMI_WWAN is not set
# CONFIG_USB_NET_INT51X1 is not set
CONFIG_USB_IPHETH=y
CONFIG_USB_SIERRA_NET=y
CONFIG_USB_NET_CH9200=y
CONFIG_USB_NET_AQC111=y
CONFIG_USB_RTL8153_ECM=y
CONFIG_WLAN=y
# CONFIG_WLAN_VENDOR_ADMTEK is not set
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K_PCI is not set
CONFIG_WLAN_VENDOR_ATMEL=y
# CONFIG_WLAN_VENDOR_BROADCOM is not set
# CONFIG_WLAN_VENDOR_CISCO is not set
# CONFIG_WLAN_VENDOR_INTEL is not set
# CONFIG_WLAN_VENDOR_INTERSIL is not set
# CONFIG_WLAN_VENDOR_MARVELL is not set
# CONFIG_WLAN_VENDOR_MEDIATEK is not set
# CONFIG_WLAN_VENDOR_MICROCHIP is not set
# CONFIG_WLAN_VENDOR_PURELIFI is not set
CONFIG_WLAN_VENDOR_RALINK=y
CONFIG_WLAN_VENDOR_REALTEK=y
# CONFIG_WLAN_VENDOR_RSI is not set
# CONFIG_WLAN_VENDOR_SILABS is not set
# CONFIG_WLAN_VENDOR_ST is not set
CONFIG_WLAN_VENDOR_TI=y
CONFIG_WLAN_VENDOR_ZYDAS=y
# CONFIG_WLAN_VENDOR_QUANTENNA is not set
# CONFIG_WAN is not set

#
# Wireless WAN
#
CONFIG_WWAN=y
CONFIG_WWAN_DEBUGFS=y
CONFIG_WWAN_HWSIM=y
CONFIG_MHI_WWAN_CTRL=y
# CONFIG_MHI_WWAN_MBIM is not set
CONFIG_QCOM_BAM_DMUX=y
# CONFIG_RPMSG_WWAN_CTRL is not set
CONFIG_MTK_T7XX=y
# end of Wireless WAN

CONFIG_VMXNET3=y
CONFIG_USB4_NET=y
CONFIG_NETDEVSIM=y
CONFIG_NET_FAILOVER=y
# CONFIG_ISDN is not set

#
# Input device support
#
# CONFIG_INPUT is not set

#
# Hardware I/O ports
#
# CONFIG_SERIO is not set
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
# CONFIG_GAMEPORT is not set
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
# CONFIG_TTY is not set
CONFIG_SERIAL_DEV_BUS=y
CONFIG_PRINTER=y
CONFIG_LP_CONSOLE=y
# CONFIG_PPDEV is not set
CONFIG_IPMI_HANDLER=y
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PLAT_DATA=y
# CONFIG_IPMI_PANIC_EVENT is not set
CONFIG_IPMI_DEVICE_INTERFACE=y
CONFIG_IPMI_SI=y
CONFIG_IPMI_SSIF=y
CONFIG_IPMI_IPMB=y
# CONFIG_IPMI_WATCHDOG is not set
CONFIG_IPMI_POWEROFF=y
# CONFIG_ASPEED_KCS_IPMI_BMC is not set
# CONFIG_NPCM7XX_KCS_IPMI_BMC is not set
CONFIG_ASPEED_BT_IPMI_BMC=y
CONFIG_IPMB_DEVICE_INTERFACE=y
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=y
CONFIG_HW_RANDOM_INTEL=y
# CONFIG_HW_RANDOM_AMD is not set
CONFIG_HW_RANDOM_BA431=y
CONFIG_HW_RANDOM_BCM2835=y
# CONFIG_HW_RANDOM_IPROC_RNG200 is not set
CONFIG_HW_RANDOM_VIA=y
CONFIG_HW_RANDOM_IXP4XX=y
# CONFIG_HW_RANDOM_OMAP is not set
# CONFIG_HW_RANDOM_OMAP3_ROM is not set
CONFIG_HW_RANDOM_VIRTIO=y
CONFIG_HW_RANDOM_IMX_RNGC=y
CONFIG_HW_RANDOM_NOMADIK=y
CONFIG_HW_RANDOM_STM32=y
CONFIG_HW_RANDOM_POLARFIRE_SOC=y
CONFIG_HW_RANDOM_MESON=y
CONFIG_HW_RANDOM_MTK=y
CONFIG_HW_RANDOM_EXYNOS=y
CONFIG_HW_RANDOM_NPCM=y
CONFIG_HW_RANDOM_XIPHERA=y
# CONFIG_HW_RANDOM_CN10K is not set
CONFIG_APPLICOM=y
# CONFIG_DEVMEM is not set
CONFIG_NVRAM=y
# CONFIG_DEVPORT is not set
CONFIG_HANGCHECK_TIMER=y
# CONFIG_TCG_TPM is not set
CONFIG_TELCLOCK=y
CONFIG_XILLYBUS_CLASS=y
CONFIG_XILLYBUS=y
CONFIG_XILLYBUS_PCIE=y
# CONFIG_XILLYUSB is not set
CONFIG_RANDOM_TRUST_CPU=y
CONFIG_RANDOM_TRUST_BOOTLOADER=y
# end of Character devices

#
# I2C support
#
CONFIG_I2C=y
CONFIG_I2C_BOARDINFO=y
# CONFIG_I2C_COMPAT is not set
# CONFIG_I2C_CHARDEV is not set
CONFIG_I2C_MUX=y

#
# Multiplexer I2C Chip support
#
CONFIG_I2C_ARB_GPIO_CHALLENGE=y
CONFIG_I2C_MUX_GPIO=y
CONFIG_I2C_MUX_GPMUX=y
# CONFIG_I2C_MUX_LTC4306 is not set
CONFIG_I2C_MUX_PCA9541=y
CONFIG_I2C_MUX_PCA954x=y
CONFIG_I2C_MUX_PINCTRL=y
# CONFIG_I2C_MUX_REG is not set
# CONFIG_I2C_MUX_MLXCPLD is not set
# end of Multiplexer I2C Chip support

# CONFIG_I2C_HELPER_AUTO is not set
CONFIG_I2C_SMBUS=y

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=y
# CONFIG_I2C_ALGOPCF is not set
CONFIG_I2C_ALGOPCA=y
# end of I2C Algorithms

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
CONFIG_I2C_CCGX_UCSI=y
CONFIG_I2C_ALI1535=y
# CONFIG_I2C_ALI1563 is not set
CONFIG_I2C_ALI15X3=y
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
CONFIG_I2C_HIX5HD2=y
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_ISCH is not set
# CONFIG_I2C_ISMT is not set
CONFIG_I2C_PIIX4=y
CONFIG_I2C_NFORCE2=y
# CONFIG_I2C_NFORCE2_S4985 is not set
CONFIG_I2C_NVIDIA_GPU=y
# CONFIG_I2C_SIS5595 is not set
CONFIG_I2C_SIS630=y
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_VIA is not set
CONFIG_I2C_VIAPRO=y

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
CONFIG_I2C_ASPEED=y
CONFIG_I2C_AT91=y
# CONFIG_I2C_AT91_SLAVE_EXPERIMENTAL is not set
# CONFIG_I2C_AXXIA is not set
CONFIG_I2C_BCM2835=y
CONFIG_I2C_BCM_IPROC=y
# CONFIG_I2C_BCM_KONA is not set
CONFIG_I2C_BRCMSTB=y
# CONFIG_I2C_CADENCE is not set
CONFIG_I2C_CBUS_GPIO=y
CONFIG_I2C_DAVINCI=y
# CONFIG_I2C_DESIGNWARE_PLATFORM is not set
# CONFIG_I2C_DESIGNWARE_PCI is not set
CONFIG_I2C_DIGICOLOR=y
CONFIG_I2C_EG20T=y
CONFIG_I2C_EMEV2=y
CONFIG_I2C_GPIO=y
CONFIG_I2C_GPIO_FAULT_INJECTOR=y
CONFIG_I2C_HIGHLANDER=y
CONFIG_I2C_HISI=y
CONFIG_I2C_IMG=y
# CONFIG_I2C_IMX is not set
CONFIG_I2C_IMX_LPI2C=y
# CONFIG_I2C_IOP3XX is not set
# CONFIG_I2C_JZ4780 is not set
# CONFIG_I2C_KEMPLD is not set
CONFIG_I2C_MESON=y
CONFIG_I2C_MT65XX=y
CONFIG_I2C_MT7621=y
CONFIG_I2C_MV64XXX=y
CONFIG_I2C_MXS=y
# CONFIG_I2C_NPCM is not set
CONFIG_I2C_OCORES=y
# CONFIG_I2C_OMAP is not set
# CONFIG_I2C_OWL is not set
CONFIG_I2C_APPLE=y
CONFIG_I2C_PCA_PLATFORM=y
CONFIG_I2C_PNX=y
# CONFIG_I2C_PXA is not set
CONFIG_I2C_QCOM_CCI=y
CONFIG_I2C_QCOM_GENI=y
# CONFIG_I2C_QUP is not set
CONFIG_I2C_RIIC=y
# CONFIG_I2C_RZV2M is not set
# CONFIG_I2C_S3C2410 is not set
CONFIG_I2C_SH_MOBILE=y
CONFIG_I2C_SIMTEC=y
CONFIG_I2C_SPRD=y
CONFIG_I2C_ST=y
CONFIG_I2C_STM32F4=y
# CONFIG_I2C_STM32F7 is not set
CONFIG_I2C_SUN6I_P2WI=y
CONFIG_I2C_SYNQUACER=y
# CONFIG_I2C_TEGRA_BPMP is not set
CONFIG_I2C_UNIPHIER=y
CONFIG_I2C_UNIPHIER_F=y
# CONFIG_I2C_VERSATILE is not set
# CONFIG_I2C_WMT is not set
# CONFIG_I2C_THUNDERX is not set
CONFIG_I2C_XILINX=y
# CONFIG_I2C_XLP9XX is not set
CONFIG_I2C_RCAR=y

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_DIOLAN_U2C=y
# CONFIG_I2C_CP2615 is not set
# CONFIG_I2C_PARPORT is not set
CONFIG_I2C_ROBOTFUZZ_OSIF=y
CONFIG_I2C_TINY_USB=y

#
# Other I2C/SMBus bus drivers
#
# CONFIG_I2C_MLXCPLD is not set
CONFIG_I2C_VIRTIO=y
# end of I2C Hardware Bus support

CONFIG_I2C_SLAVE=y
CONFIG_I2C_SLAVE_EEPROM=y
# CONFIG_I2C_SLAVE_TESTUNIT is not set
# CONFIG_I2C_DEBUG_CORE is not set
CONFIG_I2C_DEBUG_ALGO=y
CONFIG_I2C_DEBUG_BUS=y
# end of I2C support

CONFIG_I3C=y
CONFIG_CDNS_I3C_MASTER=y
# CONFIG_DW_I3C_MASTER is not set
CONFIG_SVC_I3C_MASTER=y
CONFIG_MIPI_I3C_HCI=y
CONFIG_SPI=y
CONFIG_SPI_DEBUG=y
CONFIG_SPI_MASTER=y
# CONFIG_SPI_MEM is not set

#
# SPI Master Controller Drivers
#
CONFIG_SPI_ALTERA=y
CONFIG_SPI_ALTERA_CORE=y
CONFIG_SPI_ALTERA_DFL=y
# CONFIG_SPI_AR934X is not set
# CONFIG_SPI_ATH79 is not set
CONFIG_SPI_ARMADA_3700=y
# CONFIG_SPI_AXI_SPI_ENGINE is not set
# CONFIG_SPI_BCM2835 is not set
CONFIG_SPI_BCM2835AUX=y
# CONFIG_SPI_BCM63XX is not set
CONFIG_SPI_BCM63XX_HSSPI=y
# CONFIG_SPI_BCM_QSPI is not set
CONFIG_SPI_BITBANG=y
CONFIG_SPI_BUTTERFLY=y
CONFIG_SPI_CADENCE=y
CONFIG_SPI_CLPS711X=y
CONFIG_SPI_DESIGNWARE=y
# CONFIG_SPI_DW_DMA is not set
# CONFIG_SPI_DW_PCI is not set
CONFIG_SPI_DW_MMIO=y
CONFIG_SPI_DW_BT1=y
CONFIG_SPI_DW_BT1_DIRMAP=y
CONFIG_SPI_EP93XX=y
CONFIG_SPI_FSL_LPSPI=y
CONFIG_SPI_FSL_QUADSPI=y
# CONFIG_SPI_GXP is not set
CONFIG_SPI_HISI_KUNPENG=y
CONFIG_SPI_HISI_SFC_V3XX=y
CONFIG_SPI_NXP_FLEXSPI=y
CONFIG_SPI_GPIO=y
CONFIG_SPI_IMG_SPFI=y
CONFIG_SPI_IMX=y
CONFIG_SPI_INGENIC=y
CONFIG_SPI_LM70_LLP=y
CONFIG_SPI_LP8841_RTC=y
CONFIG_SPI_FSL_DSPI=y
CONFIG_SPI_MESON_SPICC=y
CONFIG_SPI_MESON_SPIFC=y
# CONFIG_SPI_MICROCHIP_CORE is not set
CONFIG_SPI_MT65XX=y
CONFIG_SPI_MT7621=y
CONFIG_SPI_MTK_NOR=y
CONFIG_SPI_MTK_SNFI=y
CONFIG_SPI_NPCM_PSPI=y
CONFIG_SPI_LANTIQ_SSC=y
CONFIG_SPI_OC_TINY=y
CONFIG_SPI_OMAP24XX=y
# CONFIG_SPI_TI_QSPI is not set
CONFIG_SPI_OMAP_100K=y
# CONFIG_SPI_ORION is not set
CONFIG_SPI_PIC32=y
CONFIG_SPI_PIC32_SQI=y
CONFIG_SPI_PXA2XX=y
CONFIG_SPI_PXA2XX_PCI=y
CONFIG_SPI_ROCKCHIP=y
CONFIG_SPI_ROCKCHIP_SFC=y
CONFIG_SPI_RSPI=y
CONFIG_SPI_QUP=y
CONFIG_SPI_QCOM_GENI=y
CONFIG_SPI_S3C64XX=y
CONFIG_SPI_SC18IS602=y
CONFIG_SPI_SH_MSIOF=y
CONFIG_SPI_SH=y
CONFIG_SPI_SH_HSPI=y
CONFIG_SPI_SIFIVE=y
# CONFIG_SPI_SLAVE_MT27XX is not set
CONFIG_SPI_SPRD=y
CONFIG_SPI_SPRD_ADI=y
CONFIG_SPI_STM32=y
CONFIG_SPI_ST_SSC4=y
CONFIG_SPI_SUN4I=y
CONFIG_SPI_SUN6I=y
# CONFIG_SPI_SUNPLUS_SP7021 is not set
CONFIG_SPI_SYNQUACER=y
CONFIG_SPI_MXIC=y
CONFIG_SPI_TEGRA210_QUAD=y
CONFIG_SPI_TEGRA114=y
# CONFIG_SPI_TEGRA20_SFLASH is not set
# CONFIG_SPI_TEGRA20_SLINK is not set
CONFIG_SPI_THUNDERX=y
# CONFIG_SPI_TOPCLIFF_PCH is not set
CONFIG_SPI_XCOMM=y
CONFIG_SPI_XILINX=y
CONFIG_SPI_XLP=y
# CONFIG_SPI_XTENSA_XTFPGA is not set
CONFIG_SPI_ZYNQ_QSPI=y
# CONFIG_SPI_ZYNQMP_GQSPI is not set
# CONFIG_SPI_AMD is not set

#
# SPI Multiplexer support
#
CONFIG_SPI_MUX=y

#
# SPI Protocol Masters
#
CONFIG_SPI_SPIDEV=y
CONFIG_SPI_TLE62X0=y
CONFIG_SPI_SLAVE=y
# CONFIG_SPI_SLAVE_TIME is not set
CONFIG_SPI_SLAVE_SYSTEM_CONTROL=y
CONFIG_SPI_DYNAMIC=y
CONFIG_SPMI=y
# CONFIG_SPMI_HISI3670 is not set
# CONFIG_SPMI_MSM_PMIC_ARB is not set
# CONFIG_SPMI_MTK_PMIF is not set
CONFIG_HSI=y
CONFIG_HSI_BOARDINFO=y

#
# HSI controllers
#

#
# HSI clients
#
CONFIG_HSI_CHAR=y
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set
CONFIG_NTP_PPS=y

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
# CONFIG_PPS_CLIENT_PARPORT is not set
# CONFIG_PPS_CLIENT_GPIO is not set

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK_OPTIONAL=y

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
# end of PTP clock support

CONFIG_PINCTRL=y
CONFIG_GENERIC_PINCTRL_GROUPS=y
CONFIG_PINMUX=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
CONFIG_DEBUG_PINCTRL=y
CONFIG_PINCTRL_AMD=y
# CONFIG_PINCTRL_DA9062 is not set
CONFIG_PINCTRL_MCP23S08_I2C=y
CONFIG_PINCTRL_MCP23S08_SPI=y
CONFIG_PINCTRL_MCP23S08=y
# CONFIG_PINCTRL_SX150X is not set

#
# Intel pinctrl drivers
#
# end of Intel pinctrl drivers

#
# MediaTek pinctrl drivers
#
CONFIG_EINT_MTK=y
# end of MediaTek pinctrl drivers

CONFIG_PINCTRL_PXA=y
CONFIG_PINCTRL_PXA25X=y
CONFIG_PINCTRL_PXA27X=y
CONFIG_PINCTRL_MSM=y
CONFIG_PINCTRL_SC7280_LPASS_LPI=y
CONFIG_PINCTRL_SM8250_LPASS_LPI=y
CONFIG_PINCTRL_SM8350=y
CONFIG_PINCTRL_LPASS_LPI=y

#
# Renesas pinctrl drivers
#
# CONFIG_PINCTRL_RENESAS is not set
CONFIG_PINCTRL_SH_PFC=y
CONFIG_PINCTRL_SH_PFC_GPIO=y
CONFIG_PINCTRL_SH_FUNC_GPIO=y
# CONFIG_PINCTRL_PFC_EMEV2 is not set
CONFIG_PINCTRL_PFC_R8A77995=y
CONFIG_PINCTRL_PFC_R8A7794=y
# CONFIG_PINCTRL_PFC_R8A77990 is not set
CONFIG_PINCTRL_PFC_R8A7779=y
CONFIG_PINCTRL_PFC_R8A7790=y
CONFIG_PINCTRL_PFC_R8A77950=y
# CONFIG_PINCTRL_PFC_R8A77951 is not set
# CONFIG_PINCTRL_PFC_R8A7778 is not set
CONFIG_PINCTRL_PFC_R8A7793=y
# CONFIG_PINCTRL_PFC_R8A7791 is not set
CONFIG_PINCTRL_PFC_R8A77965=y
CONFIG_PINCTRL_PFC_R8A77960=y
CONFIG_PINCTRL_PFC_R8A77961=y
# CONFIG_PINCTRL_PFC_R8A779F0 is not set
# CONFIG_PINCTRL_PFC_R8A7792 is not set
# CONFIG_PINCTRL_PFC_R8A77980 is not set
# CONFIG_PINCTRL_PFC_R8A77970 is not set
CONFIG_PINCTRL_PFC_R8A779A0=y
# CONFIG_PINCTRL_PFC_R8A779G0 is not set
CONFIG_PINCTRL_PFC_R8A7740=y
# CONFIG_PINCTRL_PFC_R8A73A4 is not set
CONFIG_PINCTRL_PFC_R8A77470=y
# CONFIG_PINCTRL_PFC_R8A7745 is not set
# CONFIG_PINCTRL_PFC_R8A7742 is not set
# CONFIG_PINCTRL_PFC_R8A7743 is not set
# CONFIG_PINCTRL_PFC_R8A7744 is not set
# CONFIG_PINCTRL_PFC_R8A774C0 is not set
CONFIG_PINCTRL_PFC_R8A774E1=y
CONFIG_PINCTRL_PFC_R8A774A1=y
CONFIG_PINCTRL_PFC_R8A774B1=y
# CONFIG_PINCTRL_PFC_SH7203 is not set
CONFIG_PINCTRL_PFC_SH7264=y
# CONFIG_PINCTRL_PFC_SH7269 is not set
CONFIG_PINCTRL_PFC_SH7720=y
# CONFIG_PINCTRL_PFC_SH7722 is not set
CONFIG_PINCTRL_PFC_SH7734=y
# CONFIG_PINCTRL_PFC_SH7757 is not set
CONFIG_PINCTRL_PFC_SH7785=y
CONFIG_PINCTRL_PFC_SH7786=y
CONFIG_PINCTRL_PFC_SH73A0=y
CONFIG_PINCTRL_PFC_SH7723=y
# CONFIG_PINCTRL_PFC_SH7724 is not set
# CONFIG_PINCTRL_PFC_SHX3 is not set
# end of Renesas pinctrl drivers

CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_CDEV=y
# CONFIG_GPIO_CDEV_V1 is not set
CONFIG_GPIO_GENERIC=y
CONFIG_GPIO_REGMAP=y

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_ATH79 is not set
CONFIG_GPIO_CLPS711X=y
CONFIG_GPIO_DWAPB=y
# CONFIG_GPIO_GENERIC_PLATFORM is not set
CONFIG_GPIO_HISI=y
CONFIG_GPIO_ICH=y
CONFIG_GPIO_IOP=y
CONFIG_GPIO_MB86S7X=y
CONFIG_GPIO_MENZ127=y
CONFIG_GPIO_MPC8XXX=y
# CONFIG_GPIO_MXC is not set
CONFIG_GPIO_MXS=y
# CONFIG_GPIO_PXA is not set
CONFIG_GPIO_RCAR=y
CONFIG_GPIO_ROCKCHIP=y
CONFIG_GPIO_SIOX=y
CONFIG_GPIO_THUNDERX=y
# CONFIG_GPIO_VX855 is not set
CONFIG_GPIO_XGENE_SB=y
CONFIG_GPIO_XLP=y
CONFIG_GPIO_AMD_FCH=y
# CONFIG_GPIO_IDT3243X is not set
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
CONFIG_GPIO_F7188X=y
CONFIG_GPIO_IT87=y
# CONFIG_GPIO_SCH311X is not set
CONFIG_GPIO_TS5500=y
CONFIG_GPIO_WINBOND=y
CONFIG_GPIO_WS16C48=y
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
# CONFIG_GPIO_ADP5588 is not set
# CONFIG_GPIO_MAX7300 is not set
# CONFIG_GPIO_MAX732X is not set
CONFIG_GPIO_PCA953X=y
CONFIG_GPIO_PCA953X_IRQ=y
CONFIG_GPIO_PCA9570=y
CONFIG_GPIO_PCF857X=y
CONFIG_GPIO_TPIC2810=y
CONFIG_GPIO_TS4900=y
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
# CONFIG_GPIO_BD9571MWV is not set
CONFIG_GPIO_CS5535=y
CONFIG_GPIO_DA9052=y
# CONFIG_GPIO_DA9055 is not set
CONFIG_GPIO_JANZ_TTL=y
# CONFIG_GPIO_KEMPLD is not set
# CONFIG_GPIO_LP3943 is not set
CONFIG_GPIO_LP873X=y
CONFIG_GPIO_SL28CPLD=y
CONFIG_GPIO_TIMBERDALE=y
# CONFIG_GPIO_TPS65086 is not set
CONFIG_GPIO_TPS6586X=y
CONFIG_GPIO_TPS65912=y
# CONFIG_GPIO_TQMX86 is not set
# CONFIG_GPIO_UCB1400 is not set
CONFIG_GPIO_WM831X=y
# CONFIG_GPIO_WM8994 is not set
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
CONFIG_GPIO_AMD8111=y
CONFIG_GPIO_BT8XX=y
# CONFIG_GPIO_MLXBF is not set
# CONFIG_GPIO_MLXBF2 is not set
# CONFIG_GPIO_ML_IOH is not set
CONFIG_GPIO_PCH=y
CONFIG_GPIO_PCI_IDIO_16=y
CONFIG_GPIO_PCIE_IDIO_24=y
CONFIG_GPIO_RDC321X=y
# end of PCI GPIO expanders

#
# SPI GPIO expanders
#
CONFIG_GPIO_MAX3191X=y
# CONFIG_GPIO_MAX7301 is not set
CONFIG_GPIO_MC33880=y
CONFIG_GPIO_PISOSR=y
CONFIG_GPIO_XRA1403=y
# end of SPI GPIO expanders

#
# USB GPIO expanders
#
# end of USB GPIO expanders

#
# Virtual GPIO drivers
#
CONFIG_GPIO_AGGREGATOR=y
CONFIG_GPIO_MOCKUP=y
CONFIG_GPIO_VIRTIO=y
CONFIG_GPIO_SIM=y
# end of Virtual GPIO drivers

CONFIG_W1=y
# CONFIG_W1_CON is not set

#
# 1-wire Bus Masters
#
CONFIG_W1_MASTER_MATROX=y
CONFIG_W1_MASTER_DS2490=y
CONFIG_W1_MASTER_DS2482=y
# CONFIG_W1_MASTER_MXC is not set
CONFIG_W1_MASTER_DS1WM=y
# CONFIG_W1_MASTER_GPIO is not set
CONFIG_W1_MASTER_SGI=y
# end of 1-wire Bus Masters

#
# 1-wire Slaves
#
# CONFIG_W1_SLAVE_THERM is not set
# CONFIG_W1_SLAVE_SMEM is not set
CONFIG_W1_SLAVE_DS2405=y
CONFIG_W1_SLAVE_DS2408=y
CONFIG_W1_SLAVE_DS2408_READBACK=y
# CONFIG_W1_SLAVE_DS2413 is not set
# CONFIG_W1_SLAVE_DS2406 is not set
CONFIG_W1_SLAVE_DS2423=y
# CONFIG_W1_SLAVE_DS2805 is not set
CONFIG_W1_SLAVE_DS2430=y
CONFIG_W1_SLAVE_DS2431=y
# CONFIG_W1_SLAVE_DS2433 is not set
CONFIG_W1_SLAVE_DS2438=y
# CONFIG_W1_SLAVE_DS250X is not set
CONFIG_W1_SLAVE_DS2780=y
CONFIG_W1_SLAVE_DS2781=y
# CONFIG_W1_SLAVE_DS28E04 is not set
CONFIG_W1_SLAVE_DS28E17=y
# end of 1-wire Slaves

# CONFIG_POWER_RESET is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_POWER_SUPPLY_HWMON=y
CONFIG_PDA_POWER=y
CONFIG_GENERIC_ADC_BATTERY=y
CONFIG_IP5XXX_POWER=y
CONFIG_WM831X_BACKUP=y
# CONFIG_WM831X_POWER is not set
# CONFIG_TEST_POWER is not set
CONFIG_BATTERY_88PM860X=y
CONFIG_CHARGER_ADP5061=y
CONFIG_BATTERY_ACT8945A=y
# CONFIG_BATTERY_CW2015 is not set
# CONFIG_BATTERY_DS2760 is not set
CONFIG_BATTERY_DS2780=y
CONFIG_BATTERY_DS2781=y
# CONFIG_BATTERY_DS2782 is not set
# CONFIG_BATTERY_SAMSUNG_SDI is not set
CONFIG_BATTERY_INGENIC=y
# CONFIG_BATTERY_SBS is not set
CONFIG_CHARGER_SBS=y
# CONFIG_MANAGER_SBS is not set
CONFIG_BATTERY_BQ27XXX=y
# CONFIG_BATTERY_BQ27XXX_I2C is not set
CONFIG_BATTERY_BQ27XXX_HDQ=y
CONFIG_BATTERY_DA9030=y
# CONFIG_BATTERY_DA9052 is not set
# CONFIG_CHARGER_DA9150 is not set
CONFIG_BATTERY_DA9150=y
CONFIG_AXP20X_POWER=y
CONFIG_BATTERY_MAX17040=y
CONFIG_BATTERY_MAX17042=y
# CONFIG_BATTERY_MAX1721X is not set
CONFIG_CHARGER_88PM860X=y
CONFIG_CHARGER_PCF50633=y
CONFIG_CHARGER_ISP1704=y
CONFIG_CHARGER_MAX8903=y
CONFIG_CHARGER_LP8727=y
CONFIG_CHARGER_GPIO=y
# CONFIG_CHARGER_MANAGER is not set
CONFIG_CHARGER_LT3651=y
# CONFIG_CHARGER_LTC4162L is not set
CONFIG_CHARGER_MAX77693=y
CONFIG_CHARGER_MAX77976=y
CONFIG_CHARGER_MT6360=y
CONFIG_CHARGER_BQ2415X=y
# CONFIG_CHARGER_BQ24190 is not set
CONFIG_CHARGER_BQ24257=y
CONFIG_CHARGER_BQ24735=y
# CONFIG_CHARGER_BQ2515X is not set
# CONFIG_CHARGER_BQ25890 is not set
CONFIG_CHARGER_BQ25980=y
CONFIG_CHARGER_BQ256XX=y
CONFIG_CHARGER_SMB347=y
CONFIG_BATTERY_GAUGE_LTC2941=y
# CONFIG_BATTERY_GOLDFISH is not set
CONFIG_BATTERY_RT5033=y
# CONFIG_CHARGER_RT9455 is not set
# CONFIG_CHARGER_SC2731 is not set
# CONFIG_FUEL_GAUGE_SC27XX is not set
CONFIG_CHARGER_BD99954=y
CONFIG_BATTERY_ACER_A500=y
CONFIG_BATTERY_UG3105=y
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
CONFIG_HWMON_DEBUG_CHIP=y

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=y
CONFIG_SENSORS_ABITUGURU3=y
CONFIG_SENSORS_AD7314=y
# CONFIG_SENSORS_AD7414 is not set
CONFIG_SENSORS_AD7418=y
CONFIG_SENSORS_ADM1021=y
CONFIG_SENSORS_ADM1025=y
# CONFIG_SENSORS_ADM1026 is not set
# CONFIG_SENSORS_ADM1029 is not set
CONFIG_SENSORS_ADM1031=y
CONFIG_SENSORS_ADM1177=y
CONFIG_SENSORS_ADM9240=y
CONFIG_SENSORS_ADT7X10=y
CONFIG_SENSORS_ADT7310=y
# CONFIG_SENSORS_ADT7410 is not set
# CONFIG_SENSORS_ADT7411 is not set
CONFIG_SENSORS_ADT7462=y
CONFIG_SENSORS_ADT7470=y
CONFIG_SENSORS_ADT7475=y
CONFIG_SENSORS_AHT10=y
CONFIG_SENSORS_AS370=y
CONFIG_SENSORS_ASC7621=y
CONFIG_SENSORS_AXI_FAN_CONTROL=y
CONFIG_SENSORS_K8TEMP=y
CONFIG_SENSORS_K10TEMP=y
CONFIG_SENSORS_FAM15H_POWER=y
# CONFIG_SENSORS_ARM_SCMI is not set
CONFIG_SENSORS_ASB100=y
CONFIG_SENSORS_ASPEED=y
CONFIG_SENSORS_ATXP1=y
# CONFIG_SENSORS_BT1_PVT is not set
# CONFIG_SENSORS_DS620 is not set
# CONFIG_SENSORS_DS1621 is not set
# CONFIG_SENSORS_DELL_SMM is not set
# CONFIG_SENSORS_DA9052_ADC is not set
CONFIG_SENSORS_DA9055=y
# CONFIG_SENSORS_I5K_AMB is not set
CONFIG_SENSORS_SPARX5=y
CONFIG_SENSORS_F71805F=y
CONFIG_SENSORS_F71882FG=y
# CONFIG_SENSORS_F75375S is not set
# CONFIG_SENSORS_MC13783_ADC is not set
# CONFIG_SENSORS_FSCHMD is not set
CONFIG_SENSORS_FTSTEUTATES=y
CONFIG_SENSORS_GL518SM=y
CONFIG_SENSORS_GL520SM=y
CONFIG_SENSORS_G760A=y
CONFIG_SENSORS_G762=y
CONFIG_SENSORS_HIH6130=y
CONFIG_SENSORS_IBMAEM=y
CONFIG_SENSORS_IBMPEX=y
CONFIG_SENSORS_IIO_HWMON=y
# CONFIG_SENSORS_I5500 is not set
CONFIG_SENSORS_CORETEMP=y
# CONFIG_SENSORS_IT87 is not set
# CONFIG_SENSORS_JC42 is not set
CONFIG_SENSORS_POWR1220=y
CONFIG_SENSORS_LAN966X=y
CONFIG_SENSORS_LINEAGE=y
# CONFIG_SENSORS_LTC2945 is not set
CONFIG_SENSORS_LTC2947=y
# CONFIG_SENSORS_LTC2947_I2C is not set
CONFIG_SENSORS_LTC2947_SPI=y
CONFIG_SENSORS_LTC2990=y
CONFIG_SENSORS_LTC2992=y
# CONFIG_SENSORS_LTC4151 is not set
# CONFIG_SENSORS_LTC4215 is not set
CONFIG_SENSORS_LTC4222=y
CONFIG_SENSORS_LTC4245=y
# CONFIG_SENSORS_LTC4260 is not set
# CONFIG_SENSORS_LTC4261 is not set
# CONFIG_SENSORS_MAX1111 is not set
CONFIG_SENSORS_MAX127=y
CONFIG_SENSORS_MAX16065=y
CONFIG_SENSORS_MAX1619=y
CONFIG_SENSORS_MAX1668=y
CONFIG_SENSORS_MAX197=y
# CONFIG_SENSORS_MAX31722 is not set
CONFIG_SENSORS_MAX31730=y
# CONFIG_SENSORS_MAX6620 is not set
# CONFIG_SENSORS_MAX6621 is not set
CONFIG_SENSORS_MAX6639=y
CONFIG_SENSORS_MAX6642=y
CONFIG_SENSORS_MAX6650=y
CONFIG_SENSORS_MAX6697=y
CONFIG_SENSORS_MAX31790=y
CONFIG_SENSORS_MCP3021=y
CONFIG_SENSORS_MLXREG_FAN=y
CONFIG_SENSORS_TC654=y
CONFIG_SENSORS_TPS23861=y
CONFIG_SENSORS_MENF21BMC_HWMON=y
CONFIG_SENSORS_MR75203=y
CONFIG_SENSORS_ADCXX=y
# CONFIG_SENSORS_LM63 is not set
CONFIG_SENSORS_LM70=y
# CONFIG_SENSORS_LM73 is not set
CONFIG_SENSORS_LM75=y
CONFIG_SENSORS_LM77=y
# CONFIG_SENSORS_LM78 is not set
CONFIG_SENSORS_LM80=y
CONFIG_SENSORS_LM83=y
CONFIG_SENSORS_LM85=y
CONFIG_SENSORS_LM87=y
# CONFIG_SENSORS_LM90 is not set
CONFIG_SENSORS_LM92=y
# CONFIG_SENSORS_LM93 is not set
# CONFIG_SENSORS_LM95234 is not set
CONFIG_SENSORS_LM95241=y
CONFIG_SENSORS_LM95245=y
CONFIG_SENSORS_PC87360=y
CONFIG_SENSORS_PC87427=y
CONFIG_SENSORS_NTC_THERMISTOR=y
# CONFIG_SENSORS_NCT6683 is not set
CONFIG_SENSORS_NCT6775_CORE=y
# CONFIG_SENSORS_NCT6775 is not set
CONFIG_SENSORS_NCT6775_I2C=y
CONFIG_SENSORS_NCT7802=y
# CONFIG_SENSORS_NCT7904 is not set
# CONFIG_SENSORS_NPCM7XX is not set
# CONFIG_SENSORS_OCC_P8_I2C is not set
CONFIG_SENSORS_PCF8591=y
# CONFIG_SENSORS_PECI_CPUTEMP is not set
CONFIG_SENSORS_PECI_DIMMTEMP=y
CONFIG_SENSORS_PECI=y
# CONFIG_PMBUS is not set
# CONFIG_SENSORS_PWM_FAN is not set
# CONFIG_SENSORS_RASPBERRYPI_HWMON is not set
# CONFIG_SENSORS_SL28CPLD is not set
# CONFIG_SENSORS_SBTSI is not set
CONFIG_SENSORS_SBRMI=y
# CONFIG_SENSORS_SHT15 is not set
# CONFIG_SENSORS_SHT21 is not set
# CONFIG_SENSORS_SHT3x is not set
CONFIG_SENSORS_SHT4x=y
CONFIG_SENSORS_SHTC1=y
CONFIG_SENSORS_SIS5595=y
CONFIG_SENSORS_SY7636A=y
CONFIG_SENSORS_DME1737=y
# CONFIG_SENSORS_EMC1403 is not set
CONFIG_SENSORS_EMC2103=y
# CONFIG_SENSORS_EMC6W201 is not set
CONFIG_SENSORS_SMSC47M1=y
CONFIG_SENSORS_SMSC47M192=y
CONFIG_SENSORS_SMSC47B397=y
CONFIG_SENSORS_SCH56XX_COMMON=y
CONFIG_SENSORS_SCH5627=y
# CONFIG_SENSORS_SCH5636 is not set
CONFIG_SENSORS_STTS751=y
CONFIG_SENSORS_SMM665=y
# CONFIG_SENSORS_ADC128D818 is not set
CONFIG_SENSORS_ADS7828=y
# CONFIG_SENSORS_ADS7871 is not set
# CONFIG_SENSORS_AMC6821 is not set
CONFIG_SENSORS_INA209=y
CONFIG_SENSORS_INA2XX=y
CONFIG_SENSORS_INA238=y
CONFIG_SENSORS_INA3221=y
CONFIG_SENSORS_TC74=y
CONFIG_SENSORS_THMC50=y
CONFIG_SENSORS_TMP102=y
CONFIG_SENSORS_TMP103=y
# CONFIG_SENSORS_TMP108 is not set
CONFIG_SENSORS_TMP401=y
CONFIG_SENSORS_TMP421=y
CONFIG_SENSORS_TMP464=y
CONFIG_SENSORS_TMP513=y
CONFIG_SENSORS_VIA_CPUTEMP=y
# CONFIG_SENSORS_VIA686A is not set
CONFIG_SENSORS_VT1211=y
# CONFIG_SENSORS_VT8231 is not set
# CONFIG_SENSORS_W83773G is not set
CONFIG_SENSORS_W83781D=y
CONFIG_SENSORS_W83791D=y
# CONFIG_SENSORS_W83792D is not set
CONFIG_SENSORS_W83793=y
CONFIG_SENSORS_W83795=y
# CONFIG_SENSORS_W83795_FANCTRL is not set
CONFIG_SENSORS_W83L785TS=y
CONFIG_SENSORS_W83L786NG=y
CONFIG_SENSORS_W83627HF=y
# CONFIG_SENSORS_W83627EHF is not set
CONFIG_SENSORS_WM831X=y
CONFIG_SENSORS_INTEL_M10_BMC_HWMON=y
# CONFIG_THERMAL is not set
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
# CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED is not set
CONFIG_WATCHDOG_OPEN_TIMEOUT=0
# CONFIG_WATCHDOG_SYSFS is not set
CONFIG_WATCHDOG_HRTIMER_PRETIMEOUT=y

#
# Watchdog Pretimeout Governors
#
CONFIG_WATCHDOG_PRETIMEOUT_GOV=y
CONFIG_WATCHDOG_PRETIMEOUT_GOV_SEL=y
# CONFIG_WATCHDOG_PRETIMEOUT_GOV_NOOP is not set
CONFIG_WATCHDOG_PRETIMEOUT_GOV_PANIC=y
CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_PANIC=y

#
# Watchdog Device Drivers
#
# CONFIG_SOFT_WATCHDOG is not set
CONFIG_DA9052_WATCHDOG=y
CONFIG_DA9055_WATCHDOG=y
CONFIG_DA9063_WATCHDOG=y
CONFIG_DA9062_WATCHDOG=y
CONFIG_MENF21BMC_WATCHDOG=y
CONFIG_MENZ069_WATCHDOG=y
# CONFIG_WM831X_WATCHDOG is not set
CONFIG_XILINX_WATCHDOG=y
CONFIG_ZIIRAVE_WATCHDOG=y
CONFIG_RAVE_SP_WATCHDOG=y
CONFIG_MLX_WDT=y
CONFIG_SL28CPLD_WATCHDOG=y
# CONFIG_ARMADA_37XX_WATCHDOG is not set
# CONFIG_AT91RM9200_WATCHDOG is not set
CONFIG_AT91SAM9X_WATCHDOG=y
CONFIG_SAMA5D4_WATCHDOG=y
# CONFIG_CADENCE_WATCHDOG is not set
# CONFIG_FTWDT010_WATCHDOG is not set
CONFIG_S3C2410_WATCHDOG=y
CONFIG_DW_WATCHDOG=y
# CONFIG_EP93XX_WATCHDOG is not set
CONFIG_OMAP_WATCHDOG=y
# CONFIG_PNX4008_WATCHDOG is not set
CONFIG_DAVINCI_WATCHDOG=y
# CONFIG_K3_RTI_WATCHDOG is not set
CONFIG_RN5T618_WATCHDOG=y
CONFIG_SUNXI_WATCHDOG=y
CONFIG_NPCM7XX_WATCHDOG=y
CONFIG_STMP3XXX_RTC_WATCHDOG=y
CONFIG_TS72XX_WATCHDOG=y
# CONFIG_MAX63XX_WATCHDOG is not set
CONFIG_MAX77620_WATCHDOG=y
CONFIG_IMX2_WDT=y
# CONFIG_IMX7ULP_WDT is not set
# CONFIG_RETU_WATCHDOG is not set
CONFIG_MOXART_WDT=y
CONFIG_TEGRA_WATCHDOG=y
CONFIG_QCOM_WDT=y
CONFIG_MESON_GXBB_WATCHDOG=y
CONFIG_MESON_WATCHDOG=y
CONFIG_MEDIATEK_WATCHDOG=y
CONFIG_DIGICOLOR_WATCHDOG=y
CONFIG_LPC18XX_WATCHDOG=y
CONFIG_RENESAS_WDT=y
CONFIG_RENESAS_RZAWDT=y
# CONFIG_RENESAS_RZN1WDT is not set
CONFIG_RENESAS_RZG2LWDT=y
CONFIG_ASPEED_WATCHDOG=y
# CONFIG_REALTEK_OTTO_WDT is not set
CONFIG_SPRD_WATCHDOG=y
CONFIG_VISCONTI_WATCHDOG=y
CONFIG_MSC313E_WATCHDOG=y
CONFIG_APPLE_WATCHDOG=y
CONFIG_SUNPLUS_WATCHDOG=y
# CONFIG_ACQUIRE_WDT is not set
CONFIG_ADVANTECH_WDT=y
# CONFIG_ALIM1535_WDT is not set
# CONFIG_ALIM7101_WDT is not set
CONFIG_EBC_C384_WDT=y
CONFIG_F71808E_WDT=y
CONFIG_SP5100_TCO=y
# CONFIG_SC520_WDT is not set
# CONFIG_SBC_FITPC2_WATCHDOG is not set
CONFIG_EUROTECH_WDT=y
CONFIG_IB700_WDT=y
CONFIG_IBMASR=y
# CONFIG_WAFER_WDT is not set
CONFIG_I6300ESB_WDT=y
# CONFIG_IE6XX_WDT is not set
CONFIG_ITCO_WDT=y
# CONFIG_ITCO_VENDOR_SUPPORT is not set
CONFIG_IT8712F_WDT=y
CONFIG_IT87_WDT=y
CONFIG_HP_WATCHDOG=y
# CONFIG_HPWDT_NMI_DECODING is not set
# CONFIG_KEMPLD_WDT is not set
# CONFIG_SC1200_WDT is not set
CONFIG_PC87413_WDT=y
CONFIG_NV_TCO=y
CONFIG_RDC321X_WDT=y
CONFIG_60XX_WDT=y
# CONFIG_CPU5_WDT is not set
CONFIG_SMSC_SCH311X_WDT=y
CONFIG_SMSC37B787_WDT=y
CONFIG_TQMX86_WDT=y
CONFIG_VIA_WDT=y
CONFIG_W83627HF_WDT=y
CONFIG_W83877F_WDT=y
# CONFIG_W83977F_WDT is not set
CONFIG_MACHZ_WDT=y
CONFIG_SBC_EPX_C3_WATCHDOG=y
# CONFIG_INTEL_MEI_WDT is not set
CONFIG_BCM47XX_WDT=y
# CONFIG_BCM_KONA_WDT is not set
# CONFIG_BCM7038_WDT is not set
# CONFIG_IMGPDC_WDT is not set
CONFIG_MPC5200_WDT=y
# CONFIG_MEN_A21_WDT is not set
CONFIG_UML_WATCHDOG=y

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=y
CONFIG_WDTPCI=y

#
# USB-based Watchdog Cards
#
CONFIG_USBPCWATCHDOG=y
CONFIG_SSB_POSSIBLE=y
# CONFIG_SSB is not set
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=y
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
# CONFIG_BCMA_HOST_SOC is not set
CONFIG_BCMA_DRIVER_PCI=y
CONFIG_BCMA_DRIVER_MIPS=y
CONFIG_BCMA_PFLASH=y
CONFIG_BCMA_NFLASH=y
# CONFIG_BCMA_DRIVER_GMAC_CMN is not set
# CONFIG_BCMA_DRIVER_GPIO is not set
# CONFIG_BCMA_DEBUG is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
CONFIG_MFD_CS5535=y
CONFIG_MFD_SUN4I_GPADC=y
CONFIG_MFD_AS3711=y
# CONFIG_PMIC_ADP5520 is not set
CONFIG_MFD_AAT2870_CORE=y
# CONFIG_MFD_AT91_USART is not set
# CONFIG_MFD_BCM590XX is not set
CONFIG_MFD_BD9571MWV=y
CONFIG_MFD_AXP20X=y
CONFIG_MFD_AXP20X_I2C=y
# CONFIG_MFD_MADERA is not set
# CONFIG_MFD_ASIC3 is not set
CONFIG_PMIC_DA903X=y
CONFIG_PMIC_DA9052=y
CONFIG_MFD_DA9052_SPI=y
# CONFIG_MFD_DA9052_I2C is not set
CONFIG_MFD_DA9055=y
CONFIG_MFD_DA9062=y
CONFIG_MFD_DA9063=y
CONFIG_MFD_DA9150=y
# CONFIG_MFD_DLN2 is not set
CONFIG_MFD_ENE_KB3930=y
# CONFIG_MFD_EXYNOS_LPASS is not set
CONFIG_MFD_MC13XXX=y
CONFIG_MFD_MC13XXX_SPI=y
CONFIG_MFD_MC13XXX_I2C=y
CONFIG_MFD_MP2629=y
CONFIG_MFD_MXS_LRADC=y
CONFIG_MFD_MX25_TSADC=y
CONFIG_HTC_PASIC3=y
CONFIG_HTC_I2CPLD=y
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
CONFIG_LPC_ICH=y
# CONFIG_LPC_SCH is not set
CONFIG_MFD_INTEL_LPSS=y
CONFIG_MFD_INTEL_LPSS_PCI=y
CONFIG_MFD_IQS62X=y
CONFIG_MFD_JANZ_CMODIO=y
CONFIG_MFD_KEMPLD=y
CONFIG_MFD_88PM800=y
# CONFIG_MFD_88PM805 is not set
CONFIG_MFD_88PM860X=y
# CONFIG_MFD_MAX14577 is not set
# CONFIG_MFD_MAX77620 is not set
# CONFIG_MFD_MAX77650 is not set
CONFIG_MFD_MAX77686=y
CONFIG_MFD_MAX77693=y
# CONFIG_MFD_MAX77714 is not set
# CONFIG_MFD_MAX77843 is not set
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
CONFIG_MFD_MAX8998=y
CONFIG_MFD_MT6360=y
CONFIG_MFD_MT6397=y
CONFIG_MFD_MENF21BMC=y
CONFIG_EZX_PCAP=y
# CONFIG_MFD_CPCAP is not set
# CONFIG_MFD_VIPERBOARD is not set
# CONFIG_MFD_NTXEC is not set
CONFIG_MFD_RETU=y
CONFIG_MFD_PCF50633=y
CONFIG_PCF50633_ADC=y
# CONFIG_PCF50633_GPIO is not set
CONFIG_UCB1400_CORE=y
CONFIG_MFD_PM8XXX=y
CONFIG_MFD_RDC321X=y
CONFIG_MFD_RT4831=y
CONFIG_MFD_RT5033=y
# CONFIG_MFD_RC5T583 is not set
CONFIG_MFD_SEC_CORE=y
CONFIG_MFD_SI476X_CORE=y
CONFIG_MFD_SIMPLE_MFD_I2C=y
CONFIG_MFD_SL28CPLD=y
CONFIG_MFD_SM501=y
# CONFIG_MFD_SM501_GPIO is not set
# CONFIG_MFD_SKY81452 is not set
CONFIG_MFD_SC27XX_PMIC=y
CONFIG_ABX500_CORE=y
CONFIG_MFD_SUN6I_PRCM=y
CONFIG_MFD_SYSCON=y
# CONFIG_MFD_TI_AM335X_TSCADC is not set
CONFIG_MFD_LP3943=y
# CONFIG_MFD_LP8788 is not set
CONFIG_MFD_TI_LMU=y
# CONFIG_MFD_OMAP_USB_HOST is not set
# CONFIG_MFD_PALMAS is not set
CONFIG_TPS6105X=y
# CONFIG_TPS65010 is not set
CONFIG_TPS6507X=y
CONFIG_MFD_TPS65086=y
# CONFIG_MFD_TPS65090 is not set
CONFIG_MFD_TI_LP873X=y
CONFIG_MFD_TPS6586X=y
# CONFIG_MFD_TPS65910 is not set
CONFIG_MFD_TPS65912=y
CONFIG_MFD_TPS65912_I2C=y
CONFIG_MFD_TPS65912_SPI=y
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
# CONFIG_MFD_WL1273_CORE is not set
CONFIG_MFD_LM3533=y
CONFIG_MFD_TIMBERDALE=y
CONFIG_MFD_TQMX86=y
# CONFIG_MFD_VX855 is not set
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_ARIZONA_SPI is not set
CONFIG_MFD_WM8400=y
CONFIG_MFD_WM831X=y
CONFIG_MFD_WM831X_I2C=y
# CONFIG_MFD_WM831X_SPI is not set
# CONFIG_MFD_WM8350_I2C is not set
CONFIG_MFD_WM8994=y
# CONFIG_MFD_STW481X is not set
CONFIG_MFD_STM32_LPTIMER=y
CONFIG_MFD_STM32_TIMERS=y
CONFIG_MFD_STMFX=y
CONFIG_MFD_ATC260X=y
CONFIG_MFD_ATC260X_I2C=y
# CONFIG_MFD_KHADAS_MCU is not set
CONFIG_MFD_ACER_A500_EC=y
CONFIG_RAVE_SP_CORE=y
CONFIG_MFD_INTEL_M10_BMC=y
# end of Multifunction device drivers

CONFIG_REGULATOR=y
# CONFIG_REGULATOR_DEBUG is not set
CONFIG_REGULATOR_FIXED_VOLTAGE=y
CONFIG_REGULATOR_VIRTUAL_CONSUMER=y
# CONFIG_REGULATOR_USERSPACE_CONSUMER is not set
CONFIG_REGULATOR_88PG86X=y
CONFIG_REGULATOR_88PM800=y
# CONFIG_REGULATOR_88PM8607 is not set
CONFIG_REGULATOR_ACT8865=y
CONFIG_REGULATOR_AD5398=y
# CONFIG_REGULATOR_ANATOP is not set
CONFIG_REGULATOR_AAT2870=y
CONFIG_REGULATOR_AS3711=y
CONFIG_REGULATOR_ATC260X=y
CONFIG_REGULATOR_AXP20X=y
CONFIG_REGULATOR_BD9571MWV=y
CONFIG_REGULATOR_DA9052=y
# CONFIG_REGULATOR_DA9055 is not set
CONFIG_REGULATOR_DA9062=y
CONFIG_REGULATOR_DA9210=y
CONFIG_REGULATOR_DA9211=y
# CONFIG_REGULATOR_FAN53555 is not set
CONFIG_REGULATOR_FAN53880=y
CONFIG_REGULATOR_GPIO=y
CONFIG_REGULATOR_ISL9305=y
# CONFIG_REGULATOR_ISL6271A is not set
CONFIG_REGULATOR_LM363X=y
# CONFIG_REGULATOR_LP3971 is not set
# CONFIG_REGULATOR_LP3972 is not set
CONFIG_REGULATOR_LP872X=y
# CONFIG_REGULATOR_LP8755 is not set
# CONFIG_REGULATOR_LTC3589 is not set
CONFIG_REGULATOR_LTC3676=y
# CONFIG_REGULATOR_MAX1586 is not set
CONFIG_REGULATOR_MAX77620=y
# CONFIG_REGULATOR_MAX77650 is not set
CONFIG_REGULATOR_MAX8649=y
CONFIG_REGULATOR_MAX8660=y
CONFIG_REGULATOR_MAX8893=y
# CONFIG_REGULATOR_MAX8907 is not set
# CONFIG_REGULATOR_MAX8952 is not set
# CONFIG_REGULATOR_MAX8998 is not set
CONFIG_REGULATOR_MAX20086=y
# CONFIG_REGULATOR_MAX77686 is not set
# CONFIG_REGULATOR_MAX77693 is not set
CONFIG_REGULATOR_MAX77802=y
CONFIG_REGULATOR_MAX77826=y
CONFIG_REGULATOR_MC13XXX_CORE=y
# CONFIG_REGULATOR_MC13783 is not set
CONFIG_REGULATOR_MC13892=y
CONFIG_REGULATOR_MP8859=y
CONFIG_REGULATOR_MP886X=y
# CONFIG_REGULATOR_MT6311 is not set
CONFIG_REGULATOR_MT6315=y
# CONFIG_REGULATOR_MT6323 is not set
CONFIG_REGULATOR_MT6358=y
CONFIG_REGULATOR_MT6359=y
# CONFIG_REGULATOR_MT6360 is not set
CONFIG_REGULATOR_MT6380=y
CONFIG_REGULATOR_MT6397=y
CONFIG_REGULATOR_PBIAS=y
CONFIG_REGULATOR_PCA9450=y
# CONFIG_REGULATOR_PCAP is not set
CONFIG_REGULATOR_PCF50633=y
CONFIG_REGULATOR_PV88060=y
CONFIG_REGULATOR_PV88080=y
# CONFIG_REGULATOR_PV88090 is not set
# CONFIG_REGULATOR_PWM is not set
# CONFIG_REGULATOR_QCOM_RPMH is not set
CONFIG_REGULATOR_QCOM_SMD_RPM=y
# CONFIG_REGULATOR_QCOM_SPMI is not set
CONFIG_REGULATOR_QCOM_USB_VBUS=y
CONFIG_REGULATOR_RT4801=y
CONFIG_REGULATOR_RT4831=y
CONFIG_REGULATOR_RT5033=y
CONFIG_REGULATOR_RT5190A=y
CONFIG_REGULATOR_RT5759=y
CONFIG_REGULATOR_RT6160=y
CONFIG_REGULATOR_RT6245=y
CONFIG_REGULATOR_RTQ2134=y
# CONFIG_REGULATOR_RTMV20 is not set
CONFIG_REGULATOR_RTQ6752=y
# CONFIG_REGULATOR_S2MPA01 is not set
CONFIG_REGULATOR_S2MPS11=y
CONFIG_REGULATOR_S5M8767=y
CONFIG_REGULATOR_SC2731=y
CONFIG_REGULATOR_SLG51000=y
CONFIG_REGULATOR_STM32_BOOSTER=y
CONFIG_REGULATOR_STM32_VREFBUF=y
CONFIG_REGULATOR_STM32_PWR=y
CONFIG_REGULATOR_TI_ABB=y
# CONFIG_REGULATOR_STW481X_VMMC is not set
CONFIG_REGULATOR_SY7636A=y
CONFIG_REGULATOR_SY8106A=y
CONFIG_REGULATOR_SY8824X=y
CONFIG_REGULATOR_SY8827N=y
CONFIG_REGULATOR_TPS51632=y
# CONFIG_REGULATOR_TPS6105X is not set
CONFIG_REGULATOR_TPS62360=y
CONFIG_REGULATOR_TPS65023=y
CONFIG_REGULATOR_TPS6507X=y
CONFIG_REGULATOR_TPS65086=y
CONFIG_REGULATOR_TPS65132=y
# CONFIG_REGULATOR_TPS6524X is not set
CONFIG_REGULATOR_TPS6586X=y
# CONFIG_REGULATOR_TPS65912 is not set
# CONFIG_REGULATOR_TPS68470 is not set
# CONFIG_REGULATOR_WM831X is not set
# CONFIG_REGULATOR_WM8400 is not set
CONFIG_REGULATOR_WM8994=y
# CONFIG_REGULATOR_QCOM_LABIBB is not set
CONFIG_CEC_CORE=y
CONFIG_CEC_NOTIFIER=y

#
# CEC support
#
CONFIG_MEDIA_CEC_SUPPORT=y
CONFIG_CEC_CH7322=y
CONFIG_CEC_MESON_AO=y
# CONFIG_CEC_GPIO is not set
# CONFIG_CEC_SAMSUNG_S5P is not set
# CONFIG_CEC_STI is not set
# CONFIG_CEC_STM32 is not set
CONFIG_CEC_TEGRA=y
CONFIG_CEC_SECO=y
# end of CEC support

CONFIG_MEDIA_SUPPORT=y
# CONFIG_MEDIA_SUPPORT_FILTER is not set
CONFIG_MEDIA_SUBDRV_AUTOSELECT=y

#
# Media device types
#
CONFIG_MEDIA_CAMERA_SUPPORT=y
CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
CONFIG_MEDIA_RADIO_SUPPORT=y
CONFIG_MEDIA_SDR_SUPPORT=y
CONFIG_MEDIA_PLATFORM_SUPPORT=y
CONFIG_MEDIA_TEST_SUPPORT=y
# end of Media device types

#
# Media core support
#
CONFIG_VIDEO_DEV=y
CONFIG_MEDIA_CONTROLLER=y
CONFIG_DVB_CORE=y
# end of Media core support

#
# Video4Linux options
#
CONFIG_VIDEO_V4L2_I2C=y
CONFIG_VIDEO_V4L2_SUBDEV_API=y
# CONFIG_VIDEO_ADV_DEBUG is not set
# CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
CONFIG_VIDEO_TUNER=y
CONFIG_V4L2_FLASH_LED_CLASS=y
CONFIG_V4L2_FWNODE=y
CONFIG_V4L2_ASYNC=y
CONFIG_VIDEOBUF_GEN=y
CONFIG_VIDEOBUF_DMA_SG=y
# end of Video4Linux options

#
# Media controller options
#
# CONFIG_MEDIA_CONTROLLER_DVB is not set
# end of Media controller options

#
# Digital TV options
#
CONFIG_DVB_MMAP=y
CONFIG_DVB_NET=y
CONFIG_DVB_MAX_ADAPTERS=16
# CONFIG_DVB_DYNAMIC_MINORS is not set
CONFIG_DVB_DEMUX_SECTION_LOSS_LOG=y
CONFIG_DVB_ULE_DEBUG=y
# end of Digital TV options

#
# Media drivers
#

#
# Media drivers
#
# CONFIG_MEDIA_USB_SUPPORT is not set
CONFIG_MEDIA_PCI_SUPPORT=y

#
# Media capture support
#
CONFIG_VIDEO_SOLO6X10=y
# CONFIG_STA2X11_VIP is not set
CONFIG_VIDEO_TW5864=y
# CONFIG_VIDEO_TW68 is not set
CONFIG_VIDEO_TW686X=y

#
# Media capture/analog TV support
#
CONFIG_VIDEO_DT3155=y
# CONFIG_VIDEO_HEXIUM_GEMINI is not set
# CONFIG_VIDEO_HEXIUM_ORION is not set
CONFIG_VIDEO_MXB=y

#
# Media capture/analog/hybrid TV support
#
# CONFIG_VIDEO_COBALT is not set
# CONFIG_VIDEO_CX25821 is not set
CONFIG_VIDEO_SAA7134=y
# CONFIG_VIDEO_SAA7134_ALSA is not set
# CONFIG_VIDEO_SAA7134_DVB is not set
CONFIG_VIDEO_SAA7164=y

#
# Media digital TV PCI Adapters
#
CONFIG_DVB_B2C2_FLEXCOP_PCI=y
CONFIG_DVB_B2C2_FLEXCOP_PCI_DEBUG=y
# CONFIG_DVB_DDBRIDGE is not set
# CONFIG_DVB_NETUP_UNIDVB is not set
# CONFIG_DVB_NGENE is not set
CONFIG_DVB_PLUTO2=y
# CONFIG_DVB_PT1 is not set
CONFIG_DVB_PT3=y
# CONFIG_DVB_BUDGET_CORE is not set
# CONFIG_VIDEO_IPU3_CIO2 is not set
# CONFIG_RADIO_ADAPTERS is not set
# CONFIG_MEDIA_PLATFORM_DRIVERS is not set
# CONFIG_V4L_TEST_DRIVERS is not set
CONFIG_DVB_TEST_DRIVERS=y
CONFIG_DVB_VIDTV=y

#
# FireWire (IEEE 1394) Adapters
#
CONFIG_DVB_FIREDTV=y
CONFIG_VIDEO_TVEEPROM=y
CONFIG_DVB_B2C2_FLEXCOP=y
CONFIG_DVB_B2C2_FLEXCOP_DEBUG=y
CONFIG_VIDEO_SAA7146=y
CONFIG_VIDEO_SAA7146_VV=y
CONFIG_VIDEOBUF2_CORE=y
CONFIG_VIDEOBUF2_V4L2=y
CONFIG_VIDEOBUF2_MEMOPS=y
CONFIG_VIDEOBUF2_DMA_CONTIG=y
CONFIG_VIDEOBUF2_VMALLOC=y
CONFIG_VIDEOBUF2_DMA_SG=y
# end of Media drivers

#
# Media ancillary drivers
#

#
# Camera sensor devices
#
CONFIG_VIDEO_APTINA_PLL=y
CONFIG_VIDEO_CCS_PLL=y
# CONFIG_VIDEO_AR0521 is not set
CONFIG_VIDEO_HI556=y
# CONFIG_VIDEO_HI846 is not set
# CONFIG_VIDEO_HI847 is not set
CONFIG_VIDEO_IMX208=y
CONFIG_VIDEO_IMX214=y
# CONFIG_VIDEO_IMX219 is not set
CONFIG_VIDEO_IMX258=y
CONFIG_VIDEO_IMX274=y
CONFIG_VIDEO_IMX290=y
CONFIG_VIDEO_IMX319=y
CONFIG_VIDEO_IMX355=y
CONFIG_VIDEO_MAX9271_LIB=y
CONFIG_VIDEO_MT9M001=y
CONFIG_VIDEO_MT9M032=y
CONFIG_VIDEO_MT9M111=y
CONFIG_VIDEO_MT9P031=y
CONFIG_VIDEO_MT9T001=y
CONFIG_VIDEO_MT9T112=y
CONFIG_VIDEO_MT9V011=y
CONFIG_VIDEO_MT9V032=y
CONFIG_VIDEO_MT9V111=y
# CONFIG_VIDEO_NOON010PC30 is not set
# CONFIG_VIDEO_OG01A1B is not set
CONFIG_VIDEO_OV02A10=y
# CONFIG_VIDEO_OV08D10 is not set
CONFIG_VIDEO_OV13858=y
# CONFIG_VIDEO_OV13B10 is not set
CONFIG_VIDEO_OV2640=y
CONFIG_VIDEO_OV2659=y
# CONFIG_VIDEO_OV2680 is not set
# CONFIG_VIDEO_OV2685 is not set
CONFIG_VIDEO_OV2740=y
CONFIG_VIDEO_OV5647=y
# CONFIG_VIDEO_OV5648 is not set
CONFIG_VIDEO_OV5670=y
CONFIG_VIDEO_OV5675=y
CONFIG_VIDEO_OV5693=y
CONFIG_VIDEO_OV5695=y
CONFIG_VIDEO_OV6650=y
CONFIG_VIDEO_OV7251=y
# CONFIG_VIDEO_OV7640 is not set
CONFIG_VIDEO_OV7670=y
CONFIG_VIDEO_OV772X=y
# CONFIG_VIDEO_OV7740 is not set
CONFIG_VIDEO_OV8856=y
CONFIG_VIDEO_OV8865=y
# CONFIG_VIDEO_OV9640 is not set
CONFIG_VIDEO_OV9650=y
CONFIG_VIDEO_OV9734=y
CONFIG_VIDEO_RDACM20=y
# CONFIG_VIDEO_RDACM21 is not set
CONFIG_VIDEO_RJ54N1=y
# CONFIG_VIDEO_S5C73M3 is not set
# CONFIG_VIDEO_S5K4ECGX is not set
# CONFIG_VIDEO_S5K5BAF is not set
# CONFIG_VIDEO_S5K6A3 is not set
CONFIG_VIDEO_S5K6AA=y
CONFIG_VIDEO_SR030PC30=y
CONFIG_VIDEO_VS6624=y
CONFIG_VIDEO_CCS=y
CONFIG_VIDEO_ET8EK8=y
CONFIG_VIDEO_M5MOLS=y
# end of Camera sensor devices

#
# Lens drivers
#
CONFIG_VIDEO_AD5820=y
CONFIG_VIDEO_AK7375=y
CONFIG_VIDEO_DW9714=y
CONFIG_VIDEO_DW9768=y
# CONFIG_VIDEO_DW9807_VCM is not set
# end of Lens drivers

#
# Flash devices
#
CONFIG_VIDEO_ADP1653=y
CONFIG_VIDEO_LM3560=y
CONFIG_VIDEO_LM3646=y
# end of Flash devices

#
# Audio decoders, processors and mixers
#
CONFIG_VIDEO_CS3308=y
# CONFIG_VIDEO_CS5345 is not set
CONFIG_VIDEO_CS53L32A=y
CONFIG_VIDEO_MSP3400=y
# CONFIG_VIDEO_SONY_BTF_MPX is not set
CONFIG_VIDEO_TDA1997X=y
# CONFIG_VIDEO_TDA7432 is not set
CONFIG_VIDEO_TDA9840=y
CONFIG_VIDEO_TEA6415C=y
CONFIG_VIDEO_TEA6420=y
CONFIG_VIDEO_TLV320AIC23B=y
# CONFIG_VIDEO_TVAUDIO is not set
CONFIG_VIDEO_UDA1342=y
# CONFIG_VIDEO_VP27SMPX is not set
CONFIG_VIDEO_WM8739=y
CONFIG_VIDEO_WM8775=y
# end of Audio decoders, processors and mixers

#
# RDS decoders
#
CONFIG_VIDEO_SAA6588=y
# end of RDS decoders

#
# Video decoders
#
CONFIG_VIDEO_ADV7180=y
# CONFIG_VIDEO_ADV7183 is not set
CONFIG_VIDEO_ADV7604=y
CONFIG_VIDEO_ADV7604_CEC=y
# CONFIG_VIDEO_ADV7842 is not set
CONFIG_VIDEO_BT819=y
# CONFIG_VIDEO_BT856 is not set
CONFIG_VIDEO_BT866=y
CONFIG_VIDEO_KS0127=y
CONFIG_VIDEO_ML86V7667=y
CONFIG_VIDEO_SAA7110=y
CONFIG_VIDEO_SAA711X=y
# CONFIG_VIDEO_TC358743 is not set
# CONFIG_VIDEO_TVP514X is not set
# CONFIG_VIDEO_TVP5150 is not set
CONFIG_VIDEO_TVP7002=y
CONFIG_VIDEO_TW2804=y
# CONFIG_VIDEO_TW9903 is not set
# CONFIG_VIDEO_TW9906 is not set
CONFIG_VIDEO_TW9910=y
# CONFIG_VIDEO_VPX3220 is not set

#
# Video and audio decoders
#
CONFIG_VIDEO_SAA717X=y
CONFIG_VIDEO_CX25840=y
# end of Video decoders

#
# Video encoders
#
CONFIG_VIDEO_AD9389B=y
CONFIG_VIDEO_ADV7170=y
CONFIG_VIDEO_ADV7175=y
CONFIG_VIDEO_ADV7343=y
CONFIG_VIDEO_ADV7393=y
# CONFIG_VIDEO_ADV7511 is not set
CONFIG_VIDEO_AK881X=y
CONFIG_VIDEO_SAA7127=y
CONFIG_VIDEO_SAA7185=y
# CONFIG_VIDEO_THS8200 is not set
# end of Video encoders

#
# Video improvement chips
#
# CONFIG_VIDEO_UPD64031A is not set
CONFIG_VIDEO_UPD64083=y
# end of Video improvement chips

#
# Audio/Video compression chips
#
CONFIG_VIDEO_SAA6752HS=y
# end of Audio/Video compression chips

#
# SDR tuner chips
#
CONFIG_SDR_MAX2175=y
# end of SDR tuner chips

#
# Miscellaneous helper chips
#
CONFIG_VIDEO_I2C=y
CONFIG_VIDEO_M52790=y
CONFIG_VIDEO_ST_MIPID02=y
CONFIG_VIDEO_THS7303=y
# end of Miscellaneous helper chips

#
# Media SPI Adapters
#
CONFIG_CXD2880_SPI_DRV=y
CONFIG_VIDEO_GS1662=y
# end of Media SPI Adapters

CONFIG_MEDIA_TUNER=y

#
# Customize TV tuners
#
CONFIG_MEDIA_TUNER_E4000=y
CONFIG_MEDIA_TUNER_FC0011=y
# CONFIG_MEDIA_TUNER_FC0012 is not set
# CONFIG_MEDIA_TUNER_FC0013 is not set
CONFIG_MEDIA_TUNER_FC2580=y
# CONFIG_MEDIA_TUNER_IT913X is not set
CONFIG_MEDIA_TUNER_M88RS6000T=y
CONFIG_MEDIA_TUNER_MAX2165=y
CONFIG_MEDIA_TUNER_MC44S803=y
# CONFIG_MEDIA_TUNER_MSI001 is not set
# CONFIG_MEDIA_TUNER_MT2060 is not set
CONFIG_MEDIA_TUNER_MT2063=y
CONFIG_MEDIA_TUNER_MT20XX=y
CONFIG_MEDIA_TUNER_MT2131=y
CONFIG_MEDIA_TUNER_MT2266=y
CONFIG_MEDIA_TUNER_MXL301RF=y
CONFIG_MEDIA_TUNER_MXL5005S=y
CONFIG_MEDIA_TUNER_MXL5007T=y
CONFIG_MEDIA_TUNER_QM1D1B0004=y
CONFIG_MEDIA_TUNER_QM1D1C0042=y
CONFIG_MEDIA_TUNER_QT1010=y
# CONFIG_MEDIA_TUNER_R820T is not set
CONFIG_MEDIA_TUNER_SI2157=y
CONFIG_MEDIA_TUNER_SIMPLE=y
CONFIG_MEDIA_TUNER_TDA18212=y
# CONFIG_MEDIA_TUNER_TDA18218 is not set
CONFIG_MEDIA_TUNER_TDA18250=y
CONFIG_MEDIA_TUNER_TDA18271=y
CONFIG_MEDIA_TUNER_TDA827X=y
CONFIG_MEDIA_TUNER_TDA8290=y
CONFIG_MEDIA_TUNER_TDA9887=y
CONFIG_MEDIA_TUNER_TEA5761=y
CONFIG_MEDIA_TUNER_TEA5767=y
# CONFIG_MEDIA_TUNER_TUA9001 is not set
CONFIG_MEDIA_TUNER_XC2028=y
CONFIG_MEDIA_TUNER_XC4000=y
CONFIG_MEDIA_TUNER_XC5000=y
# end of Customize TV tuners

#
# Customise DVB Frontends
#

#
# Multistandard (satellite) frontends
#
# CONFIG_DVB_M88DS3103 is not set
CONFIG_DVB_MXL5XX=y
CONFIG_DVB_STB0899=y
CONFIG_DVB_STB6100=y
CONFIG_DVB_STV090x=y
CONFIG_DVB_STV0910=y
CONFIG_DVB_STV6110x=y
CONFIG_DVB_STV6111=y

#
# Multistandard (cable + terrestrial) frontends
#
# CONFIG_DVB_DRXK is not set
CONFIG_DVB_MN88472=y
CONFIG_DVB_MN88473=y
CONFIG_DVB_SI2165=y
# CONFIG_DVB_TDA18271C2DD is not set

#
# DVB-S (satellite) frontends
#
CONFIG_DVB_CX24110=y
CONFIG_DVB_CX24116=y
CONFIG_DVB_CX24117=y
CONFIG_DVB_CX24120=y
CONFIG_DVB_CX24123=y
CONFIG_DVB_DS3000=y
# CONFIG_DVB_MB86A16 is not set
CONFIG_DVB_MT312=y
CONFIG_DVB_S5H1420=y
# CONFIG_DVB_SI21XX is not set
CONFIG_DVB_STB6000=y
CONFIG_DVB_STV0288=y
CONFIG_DVB_STV0299=y
CONFIG_DVB_STV0900=y
CONFIG_DVB_STV6110=y
# CONFIG_DVB_TDA10071 is not set
# CONFIG_DVB_TDA10086 is not set
# CONFIG_DVB_TDA8083 is not set
CONFIG_DVB_TDA8261=y
# CONFIG_DVB_TDA826X is not set
CONFIG_DVB_TS2020=y
CONFIG_DVB_TUA6100=y
CONFIG_DVB_TUNER_CX24113=y
CONFIG_DVB_TUNER_ITD1000=y
CONFIG_DVB_VES1X93=y
CONFIG_DVB_ZL10036=y
CONFIG_DVB_ZL10039=y

#
# DVB-T (terrestrial) frontends
#
CONFIG_DVB_AF9013=y
CONFIG_DVB_CX22700=y
CONFIG_DVB_CX22702=y
CONFIG_DVB_CXD2820R=y
# CONFIG_DVB_CXD2841ER is not set
CONFIG_DVB_DIB3000MB=y
CONFIG_DVB_DIB3000MC=y
# CONFIG_DVB_DIB7000M is not set
# CONFIG_DVB_DIB7000P is not set
# CONFIG_DVB_DIB9000 is not set
CONFIG_DVB_DRXD=y
CONFIG_DVB_EC100=y
CONFIG_DVB_L64781=y
CONFIG_DVB_MT352=y
CONFIG_DVB_NXT6000=y
# CONFIG_DVB_RTL2830 is not set
CONFIG_DVB_RTL2832=y
# CONFIG_DVB_RTL2832_SDR is not set
CONFIG_DVB_S5H1432=y
CONFIG_DVB_SI2168=y
# CONFIG_DVB_SP887X is not set
# CONFIG_DVB_STV0367 is not set
CONFIG_DVB_TDA10048=y
CONFIG_DVB_TDA1004X=y
CONFIG_DVB_ZD1301_DEMOD=y
CONFIG_DVB_ZL10353=y
CONFIG_DVB_CXD2880=y

#
# DVB-C (cable) frontends
#
CONFIG_DVB_STV0297=y
CONFIG_DVB_TDA10021=y
CONFIG_DVB_TDA10023=y
CONFIG_DVB_VES1820=y

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#
CONFIG_DVB_AU8522=y
CONFIG_DVB_AU8522_DTV=y
# CONFIG_DVB_AU8522_V4L is not set
CONFIG_DVB_BCM3510=y
CONFIG_DVB_LG2160=y
CONFIG_DVB_LGDT3305=y
# CONFIG_DVB_LGDT3306A is not set
CONFIG_DVB_LGDT330X=y
CONFIG_DVB_MXL692=y
CONFIG_DVB_NXT200X=y
CONFIG_DVB_OR51132=y
CONFIG_DVB_OR51211=y
# CONFIG_DVB_S5H1409 is not set
CONFIG_DVB_S5H1411=y

#
# ISDB-T (terrestrial) frontends
#
# CONFIG_DVB_DIB8000 is not set
# CONFIG_DVB_MB86A20S is not set
CONFIG_DVB_S921=y

#
# ISDB-S (satellite) & ISDB-T (terrestrial) frontends
#
# CONFIG_DVB_MN88443X is not set
CONFIG_DVB_TC90522=y

#
# Digital terrestrial only tuners/PLL
#
CONFIG_DVB_PLL=y
# CONFIG_DVB_TUNER_DIB0070 is not set
CONFIG_DVB_TUNER_DIB0090=y

#
# SEC control devices for DVB-S
#
CONFIG_DVB_A8293=y
CONFIG_DVB_AF9033=y
# CONFIG_DVB_ASCOT2E is not set
CONFIG_DVB_ATBM8830=y
# CONFIG_DVB_HELENE is not set
# CONFIG_DVB_HORUS3A is not set
CONFIG_DVB_ISL6405=y
CONFIG_DVB_ISL6421=y
CONFIG_DVB_ISL6423=y
CONFIG_DVB_IX2505V=y
CONFIG_DVB_LGS8GL5=y
CONFIG_DVB_LGS8GXX=y
# CONFIG_DVB_LNBH25 is not set
CONFIG_DVB_LNBH29=y
CONFIG_DVB_LNBP21=y
CONFIG_DVB_LNBP22=y
CONFIG_DVB_M88RS2000=y
# CONFIG_DVB_TDA665x is not set
CONFIG_DVB_DRX39XYJ=y

#
# Common Interface (EN50221) controller drivers
#
# CONFIG_DVB_CXD2099 is not set
CONFIG_DVB_SP2=y
# end of Customise DVB Frontends

#
# Tools to develop new frontends
#
CONFIG_DVB_DUMMY_FE=y
# end of Media ancillary drivers

#
# Graphics support
#
CONFIG_APERTURE_HELPERS=y
CONFIG_AGP=y
# CONFIG_AGP_AMD64 is not set
# CONFIG_AGP_INTEL is not set
CONFIG_AGP_SIS=y
CONFIG_AGP_VIA=y
CONFIG_INTEL_GTT=y
CONFIG_IMX_IPUV3_CORE=y
CONFIG_DRM=y
CONFIG_DRM_MIPI_DBI=y
CONFIG_DRM_MIPI_DSI=y
# CONFIG_DRM_DEBUG_MM is not set
CONFIG_DRM_DEBUG_SELFTEST=y
CONFIG_DRM_KUNIT_TEST=y
CONFIG_DRM_KMS_HELPER=y
# CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS is not set
CONFIG_DRM_DEBUG_MODESET_LOCK=y
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM=y
# CONFIG_DRM_LOAD_EDID_FIRMWARE is not set
CONFIG_DRM_DISPLAY_HELPER=y
CONFIG_DRM_DISPLAY_DP_HELPER=y
CONFIG_DRM_DISPLAY_HDCP_HELPER=y
CONFIG_DRM_DISPLAY_HDMI_HELPER=y
CONFIG_DRM_DP_AUX_CHARDEV=y
# CONFIG_DRM_DP_CEC is not set
CONFIG_DRM_TTM=y
CONFIG_DRM_BUDDY=y
CONFIG_DRM_VRAM_HELPER=y
CONFIG_DRM_TTM_HELPER=y
CONFIG_DRM_GEM_CMA_HELPER=y
CONFIG_DRM_GEM_SHMEM_HELPER=y
CONFIG_DRM_SCHED=y

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=y
CONFIG_DRM_I2C_SIL164=y
CONFIG_DRM_I2C_NXP_TDA998X=y
CONFIG_DRM_I2C_NXP_TDA9950=y
# end of I2C encoder or helper chips

#
# ARM devices
#
# end of ARM devices

CONFIG_DRM_RADEON=y
# CONFIG_DRM_RADEON_USERPTR is not set
CONFIG_DRM_AMDGPU=y
# CONFIG_DRM_AMDGPU_SI is not set
CONFIG_DRM_AMDGPU_CIK=y
CONFIG_DRM_AMDGPU_USERPTR=y

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
CONFIG_DRM_AMD_DC_HDCP=y
CONFIG_DEBUG_KERNEL_DC=y
CONFIG_DRM_AMD_SECURE_DISPLAY=y
# end of Display Engine Configuration

# CONFIG_HSA_AMD is not set
CONFIG_DRM_NOUVEAU=y
CONFIG_NOUVEAU_LEGACY_CTX_SUPPORT=y
CONFIG_NOUVEAU_DEBUG=5
CONFIG_NOUVEAU_DEBUG_DEFAULT=3
# CONFIG_NOUVEAU_DEBUG_MMU is not set
# CONFIG_NOUVEAU_DEBUG_PUSH is not set
# CONFIG_DRM_NOUVEAU_BACKLIGHT is not set
CONFIG_DRM_I915=y
CONFIG_DRM_I915_FORCE_PROBE=""
CONFIG_DRM_I915_CAPTURE_ERROR=y
# CONFIG_DRM_I915_COMPRESS_ERROR is not set
# CONFIG_DRM_I915_USERPTR is not set
CONFIG_DRM_I915_PXP=y

#
# drm/i915 Debugging
#
CONFIG_DRM_I915_DEBUG_MMIO=y
# CONFIG_DRM_I915_SW_FENCE_DEBUG_OBJECTS is not set
CONFIG_DRM_I915_SW_FENCE_CHECK_DAG=y
CONFIG_DRM_I915_DEBUG_GUC=y
CONFIG_DRM_I915_SELFTEST=y
# CONFIG_DRM_I915_LOW_LEVEL_TRACEPOINTS is not set
CONFIG_DRM_I915_DEBUG_VBLANK_EVADE=y
CONFIG_DRM_I915_DEBUG_RUNTIME_PM=y
# end of drm/i915 Debugging

#
# drm/i915 Profile Guided Optimisation
#
CONFIG_DRM_I915_REQUEST_TIMEOUT=20000
CONFIG_DRM_I915_FENCE_TIMEOUT=10000
CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND=250
CONFIG_DRM_I915_HEARTBEAT_INTERVAL=2500
CONFIG_DRM_I915_PREEMPT_TIMEOUT=640
CONFIG_DRM_I915_MAX_REQUEST_BUSYWAIT=8000
CONFIG_DRM_I915_STOP_TIMEOUT=100
CONFIG_DRM_I915_TIMESLICE_DURATION=1
# end of drm/i915 Profile Guided Optimisation

CONFIG_DRM_KMB_DISPLAY=y
CONFIG_DRM_VGEM=y
# CONFIG_DRM_VKMS is not set
CONFIG_DRM_VMWGFX=y
CONFIG_DRM_VMWGFX_FBCON=y
CONFIG_DRM_VMWGFX_MKSSTATS=y
CONFIG_DRM_GMA500=y
CONFIG_DRM_UDL=y
CONFIG_DRM_AST=y
CONFIG_DRM_MGAG200=y
# CONFIG_DRM_SUN4I is not set
# CONFIG_DRM_QXL is not set
# CONFIG_DRM_MSM is not set
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN is not set
# CONFIG_DRM_PANEL_WIDECHIPS_WS2401 is not set
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
# end of Display Interface Bridges

# CONFIG_DRM_IMX is not set
# CONFIG_DRM_V3D is not set
CONFIG_DRM_VC4=y
# CONFIG_DRM_VC4_HDMI_CEC is not set
# CONFIG_DRM_ETNAVIV is not set
CONFIG_DRM_HISI_HIBMC=y
# CONFIG_DRM_LOGICVC is not set
# CONFIG_DRM_BOCHS is not set
# CONFIG_DRM_CIRRUS_QEMU is not set
CONFIG_DRM_GM12U320=y
# CONFIG_DRM_PANEL_MIPI_DBI is not set
CONFIG_DRM_SIMPLEDRM=y
CONFIG_TINYDRM_HX8357D=y
# CONFIG_TINYDRM_ILI9163 is not set
# CONFIG_TINYDRM_ILI9225 is not set
CONFIG_TINYDRM_ILI9341=y
CONFIG_TINYDRM_ILI9486=y
CONFIG_TINYDRM_MI0283QT=y
# CONFIG_TINYDRM_REPAPER is not set
CONFIG_TINYDRM_ST7586=y
CONFIG_TINYDRM_ST7735R=y
CONFIG_DRM_PL111=y
# CONFIG_DRM_VBOXVIDEO is not set
CONFIG_DRM_PANFROST=y
CONFIG_DRM_GUD=y
CONFIG_DRM_SSD130X=y
CONFIG_DRM_SSD130X_I2C=y
CONFIG_DRM_SSD130X_SPI=y
CONFIG_DRM_LEGACY=y
CONFIG_DRM_TDFX=y
# CONFIG_DRM_R128 is not set
CONFIG_DRM_MGA=y
CONFIG_DRM_SIS=y
CONFIG_DRM_VIA=y
CONFIG_DRM_SAVAGE=y
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
CONFIG_DRM_NOMODESET=y
CONFIG_DRM_LIB_RANDOM=y

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_DDC=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_CFB_REV_PIXELS_IN_BYTE=y
CONFIG_FB_SYS_FILLRECT=y
CONFIG_FB_SYS_COPYAREA=y
CONFIG_FB_SYS_IMAGEBLIT=y
CONFIG_FB_FOREIGN_ENDIAN=y
# CONFIG_FB_BOTH_ENDIAN is not set
CONFIG_FB_BIG_ENDIAN=y
# CONFIG_FB_LITTLE_ENDIAN is not set
CONFIG_FB_SYS_FOPS=y
CONFIG_FB_DEFERRED_IO=y
CONFIG_FB_HECUBA=y
CONFIG_FB_SVGALIB=y
CONFIG_FB_MACMODES=y
CONFIG_FB_BACKLIGHT=y
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
CONFIG_FB_PM2=y
# CONFIG_FB_PM2_FIFO_DISCONNECT is not set
CONFIG_FB_CLPS711X=y
CONFIG_FB_IMX=y
CONFIG_FB_CYBER2000=y
# CONFIG_FB_CYBER2000_DDC is not set
CONFIG_FB_ARC=y
CONFIG_FB_CONTROL=y
CONFIG_FB_ASILIANT=y
# CONFIG_FB_IMSTT is not set
CONFIG_FB_VGA16=y
CONFIG_FB_UVESA=y
CONFIG_FB_VESA=y
CONFIG_FB_N411=y
CONFIG_FB_HGA=y
# CONFIG_FB_GBE is not set
# CONFIG_FB_PVR2 is not set
CONFIG_FB_OPENCORES=y
CONFIG_FB_S1D13XXX=y
CONFIG_FB_NVIDIA=y
CONFIG_FB_NVIDIA_I2C=y
CONFIG_FB_NVIDIA_DEBUG=y
CONFIG_FB_NVIDIA_BACKLIGHT=y
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I740 is not set
CONFIG_FB_LE80578=y
# CONFIG_FB_CARILLO_RANCH is not set
# CONFIG_FB_MATROX is not set
CONFIG_FB_RADEON=y
# CONFIG_FB_RADEON_I2C is not set
CONFIG_FB_RADEON_BACKLIGHT=y
CONFIG_FB_RADEON_DEBUG=y
CONFIG_FB_ATY128=y
# CONFIG_FB_ATY128_BACKLIGHT is not set
CONFIG_FB_ATY=y
CONFIG_FB_ATY_CT=y
# CONFIG_FB_ATY_GENERIC_LCD is not set
CONFIG_FB_ATY_GX=y
# CONFIG_FB_ATY_BACKLIGHT is not set
CONFIG_FB_S3=y
CONFIG_FB_S3_DDC=y
# CONFIG_FB_SAVAGE is not set
CONFIG_FB_SIS=y
CONFIG_FB_SIS_300=y
CONFIG_FB_SIS_315=y
CONFIG_FB_VIA=y
CONFIG_FB_VIA_DIRECT_PROCFS=y
# CONFIG_FB_VIA_X_COMPATIBILITY is not set
CONFIG_FB_NEOMAGIC=y
CONFIG_FB_KYRO=y
CONFIG_FB_3DFX=y
# CONFIG_FB_3DFX_ACCEL is not set
# CONFIG_FB_3DFX_I2C is not set
CONFIG_FB_VOODOO1=y
CONFIG_FB_VT8623=y
CONFIG_FB_TRIDENT=y
CONFIG_FB_ARK=y
CONFIG_FB_PM3=y
CONFIG_FB_CARMINE=y
CONFIG_FB_CARMINE_DRAM_EVAL=y
# CONFIG_CARMINE_DRAM_CUSTOM is not set
CONFIG_FB_WM8505=y
# CONFIG_FB_WMT_GE_ROPS is not set
CONFIG_FB_GEODE=y
# CONFIG_FB_GEODE_LX is not set
# CONFIG_FB_GEODE_GX is not set
CONFIG_FB_GEODE_GX1=y
# CONFIG_FB_PXA168 is not set
CONFIG_FB_W100=y
CONFIG_FB_SH_MOBILE_LCDC=y
CONFIG_FB_TMIO=y
CONFIG_FB_TMIO_ACCELL=y
# CONFIG_FB_S3C is not set
CONFIG_FB_SM501=y
# CONFIG_FB_SMSCUFX is not set
CONFIG_FB_UDL=y
CONFIG_FB_IBM_GXT4500=y
# CONFIG_FB_GOLDFISH is not set
CONFIG_FB_DA8XX=y
CONFIG_FB_VIRTUAL=y
# CONFIG_FB_METRONOME is not set
CONFIG_FB_MB862XX=y
CONFIG_FB_MB862XX_PCI_GDC=y
CONFIG_FB_MB862XX_I2C=y
CONFIG_FB_BROADSHEET=y
# CONFIG_FB_SSD1307 is not set
# CONFIG_FB_SM712 is not set
# CONFIG_MMP_DISP is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=y
# CONFIG_LCD_L4F00242T03 is not set
CONFIG_LCD_LMS283GF05=y
CONFIG_LCD_LTV350QV=y
# CONFIG_LCD_ILI922X is not set
CONFIG_LCD_ILI9320=y
# CONFIG_LCD_TDO24M is not set
# CONFIG_LCD_VGG2432A4 is not set
CONFIG_LCD_PLATFORM=y
CONFIG_LCD_AMS369FG06=y
# CONFIG_LCD_LMS501KF03 is not set
# CONFIG_LCD_HX8357 is not set
CONFIG_LCD_OTM3225A=y
CONFIG_BACKLIGHT_CLASS_DEVICE=y
CONFIG_BACKLIGHT_KTD253=y
CONFIG_BACKLIGHT_LM3533=y
# CONFIG_BACKLIGHT_OMAP1 is not set
CONFIG_BACKLIGHT_CARILLO_RANCH=y
CONFIG_BACKLIGHT_PWM=y
CONFIG_BACKLIGHT_DA903X=y
# CONFIG_BACKLIGHT_DA9052 is not set
# CONFIG_BACKLIGHT_QCOM_WLED is not set
# CONFIG_BACKLIGHT_RT4831 is not set
CONFIG_BACKLIGHT_SAHARA=y
CONFIG_BACKLIGHT_WM831X=y
# CONFIG_BACKLIGHT_ADP8860 is not set
CONFIG_BACKLIGHT_ADP8870=y
CONFIG_BACKLIGHT_88PM860X=y
# CONFIG_BACKLIGHT_PCF50633 is not set
# CONFIG_BACKLIGHT_AAT2870 is not set
CONFIG_BACKLIGHT_LM3630A=y
# CONFIG_BACKLIGHT_LM3639 is not set
CONFIG_BACKLIGHT_LP855X=y
CONFIG_BACKLIGHT_AS3711=y
# CONFIG_BACKLIGHT_GPIO is not set
CONFIG_BACKLIGHT_LV5207LP=y
CONFIG_BACKLIGHT_BD6107=y
CONFIG_BACKLIGHT_ARCXCNN=y
CONFIG_BACKLIGHT_RAVE_SP=y
# end of Backlight & LCD device support

CONFIG_VGASTATE=y
CONFIG_VIDEOMODE_HELPERS=y
CONFIG_HDMI=y
# CONFIG_LOGO is not set
# end of Graphics support

CONFIG_SOUND=y
CONFIG_SOUND_OSS_CORE=y
CONFIG_SOUND_OSS_CORE_PRECLAIM=y
CONFIG_SND=y
CONFIG_SND_PCM=y
CONFIG_SND_PCM_ELD=y
CONFIG_SND_PCM_IEC958=y
CONFIG_SND_DMAENGINE_PCM=y
CONFIG_SND_HWDEP=y
CONFIG_SND_RAWMIDI=y
CONFIG_SND_COMPRESS_OFFLOAD=y
CONFIG_SND_JACK=y
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=y
CONFIG_SND_PCM_OSS=y
# CONFIG_SND_PCM_OSS_PLUGINS is not set
# CONFIG_SND_PCM_TIMER is not set
CONFIG_SND_DYNAMIC_MINORS=y
CONFIG_SND_MAX_CARDS=32
CONFIG_SND_SUPPORT_OLD_API=y
# CONFIG_SND_VERBOSE_PRINTK is not set
CONFIG_SND_CTL_FAST_LOOKUP=y
# CONFIG_SND_DEBUG is not set
# CONFIG_SND_CTL_INPUT_VALIDATION is not set
CONFIG_SND_VMASTER=y
CONFIG_SND_DMA_SGBUF=y
CONFIG_SND_CTL_LED=y
# CONFIG_SND_SEQUENCER is not set
CONFIG_SND_MPU401_UART=y
CONFIG_SND_AC97_CODEC=y
CONFIG_SND_DRIVERS=y
CONFIG_SND_DUMMY=y
# CONFIG_SND_ALOOP is not set
# CONFIG_SND_MTPAV is not set
CONFIG_SND_MTS64=y
# CONFIG_SND_SERIAL_U16550 is not set
CONFIG_SND_MPU401=y
CONFIG_SND_PORTMAN2X4=y
CONFIG_SND_AC97_POWER_SAVE=y
CONFIG_SND_AC97_POWER_SAVE_DEFAULT=0
# CONFIG_SND_ISA is not set
# CONFIG_SND_PCI is not set

#
# HD-Audio
#
CONFIG_SND_HDA=y
CONFIG_SND_HDA_GENERIC_LEDS=y
CONFIG_SND_HDA_HWDEP=y
# CONFIG_SND_HDA_RECONFIG is not set
# CONFIG_SND_HDA_PATCH_LOADER is not set
CONFIG_SND_HDA_CODEC_REALTEK=y
CONFIG_SND_HDA_CODEC_ANALOG=y
CONFIG_SND_HDA_CODEC_SIGMATEL=y
CONFIG_SND_HDA_CODEC_VIA=y
CONFIG_SND_HDA_CODEC_HDMI=y
CONFIG_SND_HDA_CODEC_CIRRUS=y
# CONFIG_SND_HDA_CODEC_CS8409 is not set
CONFIG_SND_HDA_CODEC_CONEXANT=y
CONFIG_SND_HDA_CODEC_CA0110=y
CONFIG_SND_HDA_CODEC_CA0132=y
# CONFIG_SND_HDA_CODEC_CA0132_DSP is not set
CONFIG_SND_HDA_CODEC_CMEDIA=y
CONFIG_SND_HDA_CODEC_SI3054=y
CONFIG_SND_HDA_GENERIC=y
CONFIG_SND_HDA_POWER_SAVE_DEFAULT=0
# end of HD-Audio

CONFIG_SND_HDA_CORE=y
CONFIG_SND_HDA_DSP_LOADER=y
CONFIG_SND_HDA_COMPONENT=y
CONFIG_SND_HDA_I915=y
CONFIG_SND_HDA_EXT_CORE=y
CONFIG_SND_HDA_PREALLOC_SIZE=0
CONFIG_SND_INTEL_DSP_CONFIG=y
CONFIG_SND_PXA2XX_LIB=y
# CONFIG_SND_SPI is not set
CONFIG_SND_USB=y
CONFIG_SND_USB_AUDIO=y
CONFIG_SND_USB_AUDIO_USE_MEDIA_CONTROLLER=y
# CONFIG_SND_USB_UA101 is not set
CONFIG_SND_USB_USX2Y=y
CONFIG_SND_USB_CAIAQ=y
CONFIG_SND_USB_US122L=y
CONFIG_SND_USB_6FIRE=y
CONFIG_SND_USB_HIFACE=y
# CONFIG_SND_BCD2000 is not set
CONFIG_SND_USB_LINE6=y
# CONFIG_SND_USB_POD is not set
CONFIG_SND_USB_PODHD=y
CONFIG_SND_USB_TONEPORT=y
# CONFIG_SND_USB_VARIAX is not set
# CONFIG_SND_FIREWIRE is not set
CONFIG_SND_SOC=y
CONFIG_SND_SOC_AC97_BUS=y
CONFIG_SND_SOC_GENERIC_DMAENGINE_PCM=y
CONFIG_SND_SOC_COMPRESS=y
CONFIG_SND_SOC_TOPOLOGY=y
CONFIG_SND_SOC_TOPOLOGY_KUNIT_TEST=y
# CONFIG_SND_SOC_UTILS_KUNIT_TEST is not set
CONFIG_SND_SOC_ADI=y
CONFIG_SND_SOC_ADI_AXI_I2S=y
# CONFIG_SND_SOC_ADI_AXI_SPDIF is not set
# CONFIG_SND_SOC_AMD_ACP is not set
# CONFIG_SND_SOC_AMD_ACP3x is not set
CONFIG_SND_SOC_AMD_RENOIR=y
CONFIG_SND_SOC_AMD_RENOIR_MACH=y
CONFIG_SND_SOC_AMD_ACP5x=y
CONFIG_SND_SOC_AMD_VANGOGH_MACH=y
CONFIG_SND_SOC_AMD_ACP6x=y
CONFIG_SND_SOC_AMD_YC_MACH=y
CONFIG_SND_AMD_ACP_CONFIG=y
# CONFIG_SND_SOC_AMD_ACP_COMMON is not set
# CONFIG_SND_SOC_AMD_RPL_ACP6x is not set
CONFIG_SND_ATMEL_SOC=y
CONFIG_SND_ATMEL_SOC_PDC=y
CONFIG_SND_ATMEL_SOC_DMA=y
CONFIG_SND_ATMEL_SOC_SSC=y
CONFIG_SND_ATMEL_SOC_SSC_PDC=y
CONFIG_SND_ATMEL_SOC_SSC_DMA=y
# CONFIG_SND_AT91_SOC_SAM9G20_WM8731 is not set
CONFIG_SND_ATMEL_SOC_WM8904=y
# CONFIG_SND_AT91_SOC_SAM9X5_WM8731 is not set
CONFIG_SND_ATMEL_SOC_CLASSD=y
CONFIG_SND_BCM2835_SOC_I2S=y
# CONFIG_SND_SOC_CYGNUS is not set
CONFIG_SND_BCM63XX_I2S_WHISTLER=y
# CONFIG_SND_EP93XX_SOC is not set
CONFIG_SND_DESIGNWARE_I2S=y
# CONFIG_SND_DESIGNWARE_PCM is not set

#
# SoC Audio for Freescale CPUs
#

#
# Common SoC Audio options for Freescale CPUs:
#
CONFIG_SND_SOC_FSL_ASRC=y
CONFIG_SND_SOC_FSL_SAI=y
CONFIG_SND_SOC_FSL_MQS=y
CONFIG_SND_SOC_FSL_AUDMIX=y
CONFIG_SND_SOC_FSL_SSI=y
CONFIG_SND_SOC_FSL_SPDIF=y
CONFIG_SND_SOC_FSL_ESAI=y
CONFIG_SND_SOC_FSL_MICFIL=y
CONFIG_SND_SOC_FSL_EASRC=y
CONFIG_SND_SOC_FSL_XCVR=y
CONFIG_SND_SOC_FSL_AUD2HTX=y
CONFIG_SND_SOC_FSL_UTILS=y
CONFIG_SND_SOC_FSL_RPMSG=y
CONFIG_SND_SOC_IMX_PCM_DMA=y
CONFIG_SND_SOC_IMX_AUDIO_RPMSG=y
CONFIG_SND_SOC_IMX_PCM_RPMSG=y
CONFIG_SND_SOC_IMX_AUDMUX=y
CONFIG_SND_IMX_SOC=y

#
# SoC Audio support for Freescale i.MX boards:
#
CONFIG_SND_SOC_IMX_SPDIF=y
CONFIG_SND_SOC_IMX_AUDMIX=y
CONFIG_SND_SOC_IMX_HDMI=y
CONFIG_SND_SOC_IMX_RPMSG=y
# end of SoC Audio for Freescale CPUs

CONFIG_SND_I2S_HI6210_I2S=y
# CONFIG_SND_JZ4740_SOC_I2S is not set
# CONFIG_SND_KIRKWOOD_SOC is not set
CONFIG_SND_SOC_IMG=y
CONFIG_SND_SOC_IMG_I2S_IN=y
# CONFIG_SND_SOC_IMG_I2S_OUT is not set
CONFIG_SND_SOC_IMG_PARALLEL_OUT=y
CONFIG_SND_SOC_IMG_SPDIF_IN=y
# CONFIG_SND_SOC_IMG_SPDIF_OUT is not set
# CONFIG_SND_SOC_IMG_PISTACHIO_INTERNAL_DAC is not set
CONFIG_SND_SOC_INTEL_SST_TOPLEVEL=y
CONFIG_SND_SST_ATOM_HIFI2_PLATFORM=y
CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_PCI=y
CONFIG_SND_SOC_INTEL_KEEMBAY=y
CONFIG_SND_SOC_INTEL_AVS=y

#
# Intel AVS Machine drivers
#

#
# Available DSP configurations
#
# CONFIG_SND_SOC_INTEL_AVS_MACH_DA7219 is not set
# CONFIG_SND_SOC_INTEL_AVS_MACH_DMIC is not set
# CONFIG_SND_SOC_INTEL_AVS_MACH_HDAUDIO is not set
# CONFIG_SND_SOC_INTEL_AVS_MACH_I2S_TEST is not set
# CONFIG_SND_SOC_INTEL_AVS_MACH_MAX98357A is not set
# CONFIG_SND_SOC_INTEL_AVS_MACH_MAX98373 is not set
# CONFIG_SND_SOC_INTEL_AVS_MACH_NAU8825 is not set
# CONFIG_SND_SOC_INTEL_AVS_MACH_RT274 is not set
# CONFIG_SND_SOC_INTEL_AVS_MACH_RT286 is not set
# CONFIG_SND_SOC_INTEL_AVS_MACH_RT298 is not set
# CONFIG_SND_SOC_INTEL_AVS_MACH_RT5682 is not set
# CONFIG_SND_SOC_INTEL_AVS_MACH_SSM4567 is not set
# end of Intel AVS Machine drivers

CONFIG_SND_SOC_INTEL_MACH=y
CONFIG_SND_SOC_INTEL_USER_FRIENDLY_LONG_NAMES=y
# CONFIG_SND_SOC_MT8186 is not set
CONFIG_SND_SOC_MTK_BTCVSD=y
# CONFIG_SND_SOC_MT8195 is not set

#
# ASoC support for Amlogic platforms
#
CONFIG_SND_MESON_AIU=y
CONFIG_SND_MESON_AXG_FIFO=y
CONFIG_SND_MESON_AXG_FRDDR=y
# CONFIG_SND_MESON_AXG_TODDR is not set
CONFIG_SND_MESON_AXG_TDM_FORMATTER=y
CONFIG_SND_MESON_AXG_TDM_INTERFACE=y
# CONFIG_SND_MESON_AXG_TDMIN is not set
# CONFIG_SND_MESON_AXG_TDMOUT is not set
CONFIG_SND_MESON_AXG_SOUND_CARD=y
CONFIG_SND_MESON_AXG_SPDIFOUT=y
CONFIG_SND_MESON_AXG_SPDIFIN=y
# CONFIG_SND_MESON_AXG_PDM is not set
CONFIG_SND_MESON_CARD_UTILS=y
CONFIG_SND_MESON_CODEC_GLUE=y
# CONFIG_SND_MESON_GX_SOUND_CARD is not set
CONFIG_SND_MESON_G12A_TOACODEC=y
CONFIG_SND_MESON_G12A_TOHDMITX=y
CONFIG_SND_SOC_MESON_T9015=y
# end of ASoC support for Amlogic platforms

# CONFIG_SND_MXS_SOC is not set
CONFIG_SND_PXA2XX_SOC=y
CONFIG_SND_SOC_QCOM=y
CONFIG_SND_SOC_LPASS_CPU=y
CONFIG_SND_SOC_LPASS_HDMI=y
CONFIG_SND_SOC_LPASS_PLATFORM=y
CONFIG_SND_SOC_LPASS_APQ8016=y
CONFIG_SND_SOC_LPASS_SC7180=y
# CONFIG_SND_SOC_STORM is not set
CONFIG_SND_SOC_APQ8016_SBC=y
CONFIG_SND_SOC_QCOM_COMMON=y
CONFIG_SND_SOC_QDSP6_COMMON=y
CONFIG_SND_SOC_QDSP6_CORE=y
CONFIG_SND_SOC_QDSP6_AFE=y
CONFIG_SND_SOC_QDSP6_AFE_DAI=y
CONFIG_SND_SOC_QDSP6_AFE_CLOCKS=y
CONFIG_SND_SOC_QDSP6_ADM=y
CONFIG_SND_SOC_QDSP6_ROUTING=y
CONFIG_SND_SOC_QDSP6_ASM=y
CONFIG_SND_SOC_QDSP6_ASM_DAI=y
CONFIG_SND_SOC_QDSP6_APM_DAI=y
CONFIG_SND_SOC_QDSP6_APM_LPASS_DAI=y
CONFIG_SND_SOC_QDSP6_APM=y
CONFIG_SND_SOC_QDSP6_PRM_LPASS_CLOCKS=y
CONFIG_SND_SOC_QDSP6_PRM=y
CONFIG_SND_SOC_QDSP6=y
# CONFIG_SND_SOC_MSM8996 is not set
CONFIG_SND_SOC_SC7180=y
# CONFIG_SND_SOC_ROCKCHIP is not set
# CONFIG_SND_SOC_SAMSUNG is not set

#
# SoC Audio support for Renesas SoCs
#
# CONFIG_SND_SOC_SH4_FSI is not set
# CONFIG_SND_SOC_RCAR is not set
CONFIG_SND_SOC_RZ=y
# end of SoC Audio support for Renesas SoCs

CONFIG_SND_SOC_SOF_TOPLEVEL=y
# CONFIG_SND_SOC_SOF_PCI is not set
# CONFIG_SND_SOC_SOF_ACPI is not set
CONFIG_SND_SOC_SOF_OF=y
CONFIG_SND_SOC_SOF_AMD_TOPLEVEL=y
# CONFIG_SND_SOC_SOF_IMX_TOPLEVEL is not set
# CONFIG_SND_SOC_SOF_INTEL_TOPLEVEL is not set
# CONFIG_SND_SOC_SOF_MTK_TOPLEVEL is not set
CONFIG_SND_SOC_SPRD=y
CONFIG_SND_SOC_SPRD_MCDT=y
# CONFIG_SND_SOC_STI is not set

#
# STMicroelectronics STM32 SOC audio support
#
# CONFIG_SND_SOC_STM32_SAI is not set
CONFIG_SND_SOC_STM32_I2S=y
# CONFIG_SND_SOC_STM32_SPDIFRX is not set
# end of STMicroelectronics STM32 SOC audio support

#
# Allwinner SoC Audio support
#
CONFIG_SND_SUN4I_CODEC=y
# CONFIG_SND_SUN8I_CODEC_ANALOG is not set
CONFIG_SND_SUN50I_CODEC_ANALOG=y
CONFIG_SND_SUN4I_I2S=y
CONFIG_SND_SUN8I_ADDA_PR_REGMAP=y
# end of Allwinner SoC Audio support

CONFIG_SND_SOC_TEGRA=y
CONFIG_SND_SOC_TEGRA20_AC97=y
CONFIG_SND_SOC_TEGRA20_DAS=y
# CONFIG_SND_SOC_TEGRA20_I2S is not set
CONFIG_SND_SOC_TEGRA20_SPDIF=y
CONFIG_SND_SOC_TEGRA30_AHUB=y
# CONFIG_SND_SOC_TEGRA30_I2S is not set
# CONFIG_SND_SOC_TEGRA210_AHUB is not set
# CONFIG_SND_SOC_TEGRA210_DMIC is not set
# CONFIG_SND_SOC_TEGRA210_I2S is not set
# CONFIG_SND_SOC_TEGRA210_OPE is not set
# CONFIG_SND_SOC_TEGRA186_ASRC is not set
CONFIG_SND_SOC_TEGRA186_DSPK=y
CONFIG_SND_SOC_TEGRA210_ADMAIF=y
CONFIG_SND_SOC_TEGRA210_MVC=y
CONFIG_SND_SOC_TEGRA210_SFC=y
# CONFIG_SND_SOC_TEGRA210_AMX is not set
CONFIG_SND_SOC_TEGRA210_ADX=y
CONFIG_SND_SOC_TEGRA210_MIXER=y
CONFIG_SND_SOC_TEGRA_MACHINE_DRV=y
# CONFIG_SND_SOC_TEGRA_RT5640 is not set
# CONFIG_SND_SOC_TEGRA_WM8753 is not set
# CONFIG_SND_SOC_TEGRA_WM8903 is not set
CONFIG_SND_SOC_TEGRA_WM9712=y
CONFIG_SND_SOC_TEGRA_TRIMSLICE=y
# CONFIG_SND_SOC_TEGRA_ALC5632 is not set
# CONFIG_SND_SOC_TEGRA_MAX98090 is not set
CONFIG_SND_SOC_TEGRA_RT5677=y
CONFIG_SND_SOC_TEGRA_SGTL5000=y

#
# Audio support for Texas Instruments SoCs
#
CONFIG_SND_SOC_TI_EDMA_PCM=y
CONFIG_SND_SOC_TI_SDMA_PCM=y
CONFIG_SND_SOC_TI_UDMA_PCM=y

#
# Texas Instruments DAI support for:
#
# CONFIG_SND_SOC_DAVINCI_ASP is not set
CONFIG_SND_SOC_DAVINCI_MCASP=y
CONFIG_SND_SOC_DAVINCI_VCIF=y
# CONFIG_SND_SOC_OMAP_DMIC is not set
CONFIG_SND_SOC_OMAP_MCBSP=y
# CONFIG_SND_SOC_OMAP_MCPDM is not set

#
# Audio support for boards with Texas Instruments SoCs
#
CONFIG_SND_SOC_OMAP_HDMI=y
CONFIG_SND_SOC_J721E_EVM=y
# end of Audio support for Texas Instruments SoCs

CONFIG_SND_SOC_UNIPHIER=y
CONFIG_SND_SOC_UNIPHIER_AIO=y
# CONFIG_SND_SOC_UNIPHIER_LD11 is not set
CONFIG_SND_SOC_UNIPHIER_PXS2=y
CONFIG_SND_SOC_UNIPHIER_EVEA_CODEC=y
# CONFIG_SND_SOC_XILINX_I2S is not set
CONFIG_SND_SOC_XILINX_AUDIO_FORMATTER=y
# CONFIG_SND_SOC_XILINX_SPDIF is not set
CONFIG_SND_SOC_XTFPGA_I2S=y
CONFIG_SND_SOC_I2C_AND_SPI=y

#
# CODEC drivers
#
CONFIG_SND_SOC_ALL_CODECS=y
CONFIG_SND_SOC_88PM860X=y
CONFIG_SND_SOC_WM_HUBS=y
CONFIG_SND_SOC_WM_ADSP=y
CONFIG_SND_SOC_AB8500_CODEC=y
CONFIG_SND_SOC_AC97_CODEC=y
CONFIG_SND_SOC_AD1836=y
CONFIG_SND_SOC_AD193X=y
CONFIG_SND_SOC_AD193X_SPI=y
CONFIG_SND_SOC_AD193X_I2C=y
CONFIG_SND_SOC_AD1980=y
CONFIG_SND_SOC_AD73311=y
CONFIG_SND_SOC_ADAU_UTILS=y
CONFIG_SND_SOC_ADAU1372=y
# CONFIG_SND_SOC_ADAU1372_I2C is not set
CONFIG_SND_SOC_ADAU1372_SPI=y
CONFIG_SND_SOC_ADAU1373=y
CONFIG_SND_SOC_ADAU1701=y
CONFIG_SND_SOC_ADAU17X1=y
# CONFIG_SND_SOC_ADAU1761_I2C is not set
# CONFIG_SND_SOC_ADAU1761_SPI is not set
CONFIG_SND_SOC_ADAU1781=y
CONFIG_SND_SOC_ADAU1781_I2C=y
CONFIG_SND_SOC_ADAU1781_SPI=y
CONFIG_SND_SOC_ADAU1977=y
CONFIG_SND_SOC_ADAU1977_SPI=y
CONFIG_SND_SOC_ADAU1977_I2C=y
CONFIG_SND_SOC_ADAU7002=y
CONFIG_SND_SOC_ADAU7118=y
CONFIG_SND_SOC_ADAU7118_HW=y
CONFIG_SND_SOC_ADAU7118_I2C=y
CONFIG_SND_SOC_ADAV80X=y
CONFIG_SND_SOC_ADAV801=y
CONFIG_SND_SOC_ADAV803=y
CONFIG_SND_SOC_ADS117X=y
CONFIG_SND_SOC_AK4104=y
CONFIG_SND_SOC_AK4118=y
# CONFIG_SND_SOC_AK4375 is not set
CONFIG_SND_SOC_AK4458=y
CONFIG_SND_SOC_AK4535=y
CONFIG_SND_SOC_AK4554=y
# CONFIG_SND_SOC_AK4613 is not set
CONFIG_SND_SOC_AK4641=y
CONFIG_SND_SOC_AK4642=y
CONFIG_SND_SOC_AK4671=y
CONFIG_SND_SOC_AK5386=y
CONFIG_SND_SOC_AK5558=y
# CONFIG_SND_SOC_ALC5623 is not set
CONFIG_SND_SOC_ALC5632=y
CONFIG_SND_SOC_AW8738=y
CONFIG_SND_SOC_BD28623=y
CONFIG_SND_SOC_BT_SCO=y
CONFIG_SND_SOC_CQ0093VC=y
# CONFIG_SND_SOC_CROS_EC_CODEC is not set
CONFIG_SND_SOC_CS35L32=y
CONFIG_SND_SOC_CS35L33=y
CONFIG_SND_SOC_CS35L34=y
CONFIG_SND_SOC_CS35L35=y
# CONFIG_SND_SOC_CS35L36 is not set
CONFIG_SND_SOC_CS35L41_LIB=y
CONFIG_SND_SOC_CS35L41=y
CONFIG_SND_SOC_CS35L41_SPI=y
# CONFIG_SND_SOC_CS35L41_I2C is not set
CONFIG_SND_SOC_CS35L45_TABLES=y
CONFIG_SND_SOC_CS35L45=y
CONFIG_SND_SOC_CS35L45_SPI=y
# CONFIG_SND_SOC_CS35L45_I2C is not set
# CONFIG_SND_SOC_CS42L42 is not set
# CONFIG_SND_SOC_CS42L51_I2C is not set
# CONFIG_SND_SOC_CS42L52 is not set
# CONFIG_SND_SOC_CS42L56 is not set
CONFIG_SND_SOC_CS42L73=y
CONFIG_SND_SOC_CS4234=y
# CONFIG_SND_SOC_CS4265 is not set
CONFIG_SND_SOC_CS4270=y
CONFIG_SND_SOC_CS4271=y
# CONFIG_SND_SOC_CS4271_I2C is not set
CONFIG_SND_SOC_CS4271_SPI=y
CONFIG_SND_SOC_CS42XX8=y
CONFIG_SND_SOC_CS42XX8_I2C=y
CONFIG_SND_SOC_CS43130=y
CONFIG_SND_SOC_CS4341=y
CONFIG_SND_SOC_CS4349=y
# CONFIG_SND_SOC_CS47L15 is not set
# CONFIG_SND_SOC_CS47L24 is not set
# CONFIG_SND_SOC_CS47L35 is not set
# CONFIG_SND_SOC_CS47L85 is not set
# CONFIG_SND_SOC_CS47L90 is not set
# CONFIG_SND_SOC_CS47L92 is not set
CONFIG_SND_SOC_CS53L30=y
# CONFIG_SND_SOC_CX20442 is not set
# CONFIG_SND_SOC_CX2072X is not set
# CONFIG_SND_SOC_JZ4740_CODEC is not set
# CONFIG_SND_SOC_JZ4725B_CODEC is not set
# CONFIG_SND_SOC_JZ4760_CODEC is not set
# CONFIG_SND_SOC_JZ4770_CODEC is not set
CONFIG_SND_SOC_L3=y
CONFIG_SND_SOC_DA7210=y
# CONFIG_SND_SOC_DA7213 is not set
CONFIG_SND_SOC_DA7218=y
CONFIG_SND_SOC_DA7219=y
CONFIG_SND_SOC_DA732X=y
CONFIG_SND_SOC_DA9055=y
CONFIG_SND_SOC_DMIC=y
CONFIG_SND_SOC_HDMI_CODEC=y
CONFIG_SND_SOC_ES7134=y
CONFIG_SND_SOC_ES7241=y
CONFIG_SND_SOC_ES8316=y
CONFIG_SND_SOC_ES8328=y
CONFIG_SND_SOC_ES8328_I2C=y
# CONFIG_SND_SOC_ES8328_SPI is not set
CONFIG_SND_SOC_GTM601=y
CONFIG_SND_SOC_HDAC_HDMI=y
CONFIG_SND_SOC_HDAC_HDA=y
CONFIG_SND_SOC_HDA=y
CONFIG_SND_SOC_ICS43432=y
CONFIG_SND_SOC_INNO_RK3036=y
CONFIG_SND_SOC_ISABELLE=y
CONFIG_SND_SOC_LM49453=y
# CONFIG_SND_SOC_LOCHNAGAR_SC is not set
CONFIG_SND_SOC_MAX98088=y
CONFIG_SND_SOC_MAX98090=y
CONFIG_SND_SOC_MAX98095=y
CONFIG_SND_SOC_MAX98357A=y
CONFIG_SND_SOC_MAX98371=y
CONFIG_SND_SOC_MAX98504=y
CONFIG_SND_SOC_MAX9867=y
CONFIG_SND_SOC_MAX98925=y
CONFIG_SND_SOC_MAX98926=y
# CONFIG_SND_SOC_MAX98927 is not set
# CONFIG_SND_SOC_MAX98520 is not set
# CONFIG_SND_SOC_MAX98373_I2C is not set
# CONFIG_SND_SOC_MAX98373_SDW is not set
# CONFIG_SND_SOC_MAX98390 is not set
CONFIG_SND_SOC_MAX98396=y
CONFIG_SND_SOC_MAX9850=y
CONFIG_SND_SOC_MAX9860=y
CONFIG_SND_SOC_MSM8916_WCD_ANALOG=y
CONFIG_SND_SOC_MSM8916_WCD_DIGITAL=y
CONFIG_SND_SOC_PCM1681=y
# CONFIG_SND_SOC_PCM1789_I2C is not set
CONFIG_SND_SOC_PCM179X=y
CONFIG_SND_SOC_PCM179X_I2C=y
CONFIG_SND_SOC_PCM179X_SPI=y
CONFIG_SND_SOC_PCM186X=y
# CONFIG_SND_SOC_PCM186X_I2C is not set
CONFIG_SND_SOC_PCM186X_SPI=y
CONFIG_SND_SOC_PCM3008=y
CONFIG_SND_SOC_PCM3060=y
# CONFIG_SND_SOC_PCM3060_I2C is not set
CONFIG_SND_SOC_PCM3060_SPI=y
CONFIG_SND_SOC_PCM3168A=y
CONFIG_SND_SOC_PCM3168A_I2C=y
CONFIG_SND_SOC_PCM3168A_SPI=y
CONFIG_SND_SOC_PCM5102A=y
CONFIG_SND_SOC_PCM512x=y
CONFIG_SND_SOC_PCM512x_I2C=y
CONFIG_SND_SOC_PCM512x_SPI=y
# CONFIG_SND_SOC_RK3328 is not set
# CONFIG_SND_SOC_RK817 is not set
CONFIG_SND_SOC_RL6231=y
CONFIG_SND_SOC_RL6347A=y
CONFIG_SND_SOC_RT274=y
CONFIG_SND_SOC_RT286=y
CONFIG_SND_SOC_RT298=y
CONFIG_SND_SOC_RT1011=y
CONFIG_SND_SOC_RT1015=y
CONFIG_SND_SOC_RT1015P=y
CONFIG_SND_SOC_RT1016=y
CONFIG_SND_SOC_RT1019=y
CONFIG_SND_SOC_RT1305=y
CONFIG_SND_SOC_RT1308=y
# CONFIG_SND_SOC_RT1308_SDW is not set
# CONFIG_SND_SOC_RT1316_SDW is not set
CONFIG_SND_SOC_RT5514=y
CONFIG_SND_SOC_RT5616=y
CONFIG_SND_SOC_RT5631=y
CONFIG_SND_SOC_RT5640=y
CONFIG_SND_SOC_RT5645=y
CONFIG_SND_SOC_RT5651=y
CONFIG_SND_SOC_RT5659=y
CONFIG_SND_SOC_RT5660=y
CONFIG_SND_SOC_RT5663=y
CONFIG_SND_SOC_RT5665=y
CONFIG_SND_SOC_RT5668=y
CONFIG_SND_SOC_RT5670=y
CONFIG_SND_SOC_RT5677=y
CONFIG_SND_SOC_RT5677_SPI=y
CONFIG_SND_SOC_RT5682=y
CONFIG_SND_SOC_RT5682_I2C=y
# CONFIG_SND_SOC_RT5682_SDW is not set
CONFIG_SND_SOC_RT5682S=y
# CONFIG_SND_SOC_RT700_SDW is not set
# CONFIG_SND_SOC_RT711_SDW is not set
# CONFIG_SND_SOC_RT711_SDCA_SDW is not set
# CONFIG_SND_SOC_RT715_SDW is not set
# CONFIG_SND_SOC_RT715_SDCA_SDW is not set
CONFIG_SND_SOC_RT9120=y
# CONFIG_SND_SOC_SDW_MOCKUP is not set
CONFIG_SND_SOC_SGTL5000=y
CONFIG_SND_SOC_SI476X=y
CONFIG_SND_SOC_SIGMADSP=y
CONFIG_SND_SOC_SIGMADSP_I2C=y
CONFIG_SND_SOC_SIGMADSP_REGMAP=y
CONFIG_SND_SOC_SIMPLE_AMPLIFIER=y
# CONFIG_SND_SOC_SIMPLE_MUX is not set
# CONFIG_SND_SOC_SPDIF is not set
CONFIG_SND_SOC_SSM2305=y
CONFIG_SND_SOC_SSM2518=y
CONFIG_SND_SOC_SSM2602=y
CONFIG_SND_SOC_SSM2602_SPI=y
CONFIG_SND_SOC_SSM2602_I2C=y
# CONFIG_SND_SOC_SSM4567 is not set
# CONFIG_SND_SOC_STA32X is not set
# CONFIG_SND_SOC_STA350 is not set
CONFIG_SND_SOC_STA529=y
CONFIG_SND_SOC_STAC9766=y
# CONFIG_SND_SOC_STI_SAS is not set
CONFIG_SND_SOC_TAS2552=y
CONFIG_SND_SOC_TAS2562=y
# CONFIG_SND_SOC_TAS2764 is not set
# CONFIG_SND_SOC_TAS2770 is not set
CONFIG_SND_SOC_TAS2780=y
# CONFIG_SND_SOC_TAS5086 is not set
CONFIG_SND_SOC_TAS571X=y
# CONFIG_SND_SOC_TAS5720 is not set
CONFIG_SND_SOC_TAS5805M=y
CONFIG_SND_SOC_TAS6424=y
CONFIG_SND_SOC_TDA7419=y
# CONFIG_SND_SOC_TFA9879 is not set
CONFIG_SND_SOC_TFA989X=y
CONFIG_SND_SOC_TLV320ADC3XXX=y
CONFIG_SND_SOC_TLV320AIC23=y
CONFIG_SND_SOC_TLV320AIC23_I2C=y
CONFIG_SND_SOC_TLV320AIC23_SPI=y
CONFIG_SND_SOC_TLV320AIC26=y
CONFIG_SND_SOC_TLV320AIC31XX=y
CONFIG_SND_SOC_TLV320AIC32X4=y
CONFIG_SND_SOC_TLV320AIC32X4_I2C=y
CONFIG_SND_SOC_TLV320AIC32X4_SPI=y
CONFIG_SND_SOC_TLV320AIC3X=y
CONFIG_SND_SOC_TLV320AIC3X_I2C=y
CONFIG_SND_SOC_TLV320AIC3X_SPI=y
CONFIG_SND_SOC_TLV320DAC33=y
CONFIG_SND_SOC_TLV320ADCX140=y
CONFIG_SND_SOC_TS3A227E=y
# CONFIG_SND_SOC_TSCS42XX is not set
CONFIG_SND_SOC_TSCS454=y
# CONFIG_SND_SOC_TWL4030 is not set
# CONFIG_SND_SOC_TWL6040 is not set
CONFIG_SND_SOC_UDA1334=y
CONFIG_SND_SOC_UDA134X=y
CONFIG_SND_SOC_UDA1380=y
# CONFIG_SND_SOC_WCD9335 is not set
# CONFIG_SND_SOC_WCD934X is not set
# CONFIG_SND_SOC_WCD938X_SDW is not set
CONFIG_SND_SOC_WL1273=y
CONFIG_SND_SOC_WM0010=y
CONFIG_SND_SOC_WM1250_EV1=y
CONFIG_SND_SOC_WM2000=y
CONFIG_SND_SOC_WM2200=y
CONFIG_SND_SOC_WM5100=y
# CONFIG_SND_SOC_WM5102 is not set
# CONFIG_SND_SOC_WM5110 is not set
# CONFIG_SND_SOC_WM8350 is not set
CONFIG_SND_SOC_WM8400=y
# CONFIG_SND_SOC_WM8510 is not set
# CONFIG_SND_SOC_WM8523 is not set
CONFIG_SND_SOC_WM8524=y
CONFIG_SND_SOC_WM8580=y
# CONFIG_SND_SOC_WM8711 is not set
CONFIG_SND_SOC_WM8727=y
CONFIG_SND_SOC_WM8728=y
CONFIG_SND_SOC_WM8731=y
CONFIG_SND_SOC_WM8731_I2C=y
CONFIG_SND_SOC_WM8731_SPI=y
CONFIG_SND_SOC_WM8737=y
# CONFIG_SND_SOC_WM8741 is not set
CONFIG_SND_SOC_WM8750=y
CONFIG_SND_SOC_WM8753=y
CONFIG_SND_SOC_WM8770=y
# CONFIG_SND_SOC_WM8776 is not set
# CONFIG_SND_SOC_WM8782 is not set
CONFIG_SND_SOC_WM8804=y
CONFIG_SND_SOC_WM8804_I2C=y
CONFIG_SND_SOC_WM8804_SPI=y
CONFIG_SND_SOC_WM8900=y
CONFIG_SND_SOC_WM8903=y
CONFIG_SND_SOC_WM8904=y
CONFIG_SND_SOC_WM8940=y
CONFIG_SND_SOC_WM8955=y
CONFIG_SND_SOC_WM8960=y
CONFIG_SND_SOC_WM8961=y
# CONFIG_SND_SOC_WM8962 is not set
CONFIG_SND_SOC_WM8971=y
CONFIG_SND_SOC_WM8974=y
CONFIG_SND_SOC_WM8978=y
CONFIG_SND_SOC_WM8983=y
# CONFIG_SND_SOC_WM8985 is not set
CONFIG_SND_SOC_WM8988=y
CONFIG_SND_SOC_WM8990=y
CONFIG_SND_SOC_WM8991=y
CONFIG_SND_SOC_WM8993=y
CONFIG_SND_SOC_WM8994=y
CONFIG_SND_SOC_WM8995=y
CONFIG_SND_SOC_WM8996=y
# CONFIG_SND_SOC_WM8997 is not set
# CONFIG_SND_SOC_WM8998 is not set
CONFIG_SND_SOC_WM9081=y
CONFIG_SND_SOC_WM9090=y
CONFIG_SND_SOC_WM9705=y
CONFIG_SND_SOC_WM9712=y
CONFIG_SND_SOC_WM9713=y
# CONFIG_SND_SOC_WSA881X is not set
# CONFIG_SND_SOC_WSA883X is not set
CONFIG_SND_SOC_ZL38060=y
CONFIG_SND_SOC_LM4857=y
CONFIG_SND_SOC_MAX9759=y
CONFIG_SND_SOC_MAX9768=y
CONFIG_SND_SOC_MAX9877=y
CONFIG_SND_SOC_MC13783=y
CONFIG_SND_SOC_ML26124=y
# CONFIG_SND_SOC_MT6351 is not set
CONFIG_SND_SOC_MT6358=y
# CONFIG_SND_SOC_MT6359 is not set
CONFIG_SND_SOC_MT6359_ACCDET=y
CONFIG_SND_SOC_MT6660=y
CONFIG_SND_SOC_NAU8315=y
CONFIG_SND_SOC_NAU8540=y
CONFIG_SND_SOC_NAU8810=y
CONFIG_SND_SOC_NAU8821=y
# CONFIG_SND_SOC_NAU8822 is not set
# CONFIG_SND_SOC_NAU8824 is not set
CONFIG_SND_SOC_NAU8825=y
CONFIG_SND_SOC_TPA6130A2=y
CONFIG_SND_SOC_LPASS_MACRO_COMMON=y
CONFIG_SND_SOC_LPASS_WSA_MACRO=y
CONFIG_SND_SOC_LPASS_VA_MACRO=y
CONFIG_SND_SOC_LPASS_RX_MACRO=y
CONFIG_SND_SOC_LPASS_TX_MACRO=y
# end of CODEC drivers

# CONFIG_SND_SIMPLE_CARD is not set
# CONFIG_SND_X86 is not set
CONFIG_SND_VIRTIO=y
CONFIG_AC97_BUS=y
CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
CONFIG_USB_LED_TRIG=y
# CONFIG_USB_ULPI_BUS is not set
CONFIG_USB_CONN_GPIO=y
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_PCI=y
# CONFIG_USB_ANNOUNCE_NEW_DEVICES is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=y
# CONFIG_USB_FEW_INIT_RETRIES is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
CONFIG_USB_OTG=y
CONFIG_USB_OTG_PRODUCTLIST=y
# CONFIG_USB_OTG_DISABLE_EXTERNAL_HUB is not set
CONFIG_USB_OTG_FSM=y
CONFIG_USB_LEDS_TRIGGER_USBPORT=y
CONFIG_USB_AUTOSUSPEND_DELAY=2
CONFIG_USB_MON=y

#
# USB Host Controller Drivers
#
CONFIG_USB_C67X00_HCD=y
CONFIG_USB_XHCI_HCD=y
CONFIG_USB_XHCI_PCI=y
CONFIG_USB_XHCI_PCI_RENESAS=y
CONFIG_USB_XHCI_PLATFORM=y
CONFIG_USB_XHCI_HISTB=y
CONFIG_USB_XHCI_MTK=y
CONFIG_USB_XHCI_MVEBU=y
CONFIG_USB_XHCI_RCAR=y
CONFIG_USB_BRCMSTB=y
# CONFIG_USB_EHCI_HCD is not set
CONFIG_USB_OXU210HP_HCD=y
# CONFIG_USB_ISP116X_HCD is not set
CONFIG_USB_ISP1362_HCD=y
CONFIG_USB_FOTG210_HCD=y
CONFIG_USB_MAX3421_HCD=y
CONFIG_USB_OHCI_HCD=y
# CONFIG_USB_OHCI_HCD_SPEAR is not set
# CONFIG_USB_OHCI_HCD_S3C2410 is not set
# CONFIG_USB_OHCI_HCD_LPC32XX is not set
CONFIG_USB_OHCI_HCD_OMAP3=y
CONFIG_USB_OHCI_HCD_DAVINCI=y
CONFIG_USB_OHCI_HCD_PCI=y
# CONFIG_USB_OHCI_SH is not set
CONFIG_USB_OHCI_EXYNOS=y
CONFIG_USB_CNS3XXX_OHCI=y
CONFIG_USB_OHCI_HCD_PLATFORM=y
# CONFIG_USB_UHCI_HCD is not set
CONFIG_USB_U132_HCD=y
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
CONFIG_USB_HCD_BCMA=y
CONFIG_USB_HCD_TEST_MODE=y

#
# USB Device Class drivers
#
CONFIG_USB_PRINTER=y
CONFIG_USB_WDM=y
# CONFIG_USB_TMC is not set

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
# CONFIG_USB_STORAGE is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USBIP_CORE is not set
CONFIG_USB_CDNS_SUPPORT=y
CONFIG_USB_CDNS3=y
# CONFIG_USB_CDNS3_HOST is not set
CONFIG_USB_CDNS3_TI=y
# CONFIG_USB_CDNS3_IMX is not set
# CONFIG_USB_MTU3 is not set
CONFIG_USB_MUSB_HDRC=y
CONFIG_USB_MUSB_HOST=y

#
# Platform Glue Layer
#
# CONFIG_USB_MUSB_TUSB6010 is not set
# CONFIG_USB_MUSB_UX500 is not set
# CONFIG_USB_MUSB_MEDIATEK is not set
# CONFIG_USB_MUSB_POLARFIRE_SOC is not set

#
# MUSB DMA mode
#
# CONFIG_MUSB_PIO_ONLY is not set
CONFIG_USB_DWC3=y
CONFIG_USB_DWC3_HOST=y

#
# Platform Glue Driver Support
#
CONFIG_USB_DWC3_HAPS=y
CONFIG_USB_DWC3_KEYSTONE=y
CONFIG_USB_DWC3_AM62=y
# CONFIG_USB_DWC2 is not set
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
CONFIG_USB_EMI26=y
CONFIG_USB_ADUTUX=y
CONFIG_USB_SEVSEG=y
# CONFIG_USB_LEGOTOWER is not set
CONFIG_USB_LCD=y
CONFIG_USB_CYPRESS_CY7C63=y
CONFIG_USB_CYTHERM=y
CONFIG_USB_IDMOUSE=y
CONFIG_USB_FTDI_ELAN=y
CONFIG_USB_APPLEDISPLAY=y
CONFIG_USB_QCOM_EUD=y
CONFIG_APPLE_MFI_FASTCHARGE=y
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_LD is not set
CONFIG_USB_TRANCEVIBRATOR=y
CONFIG_USB_IOWARRIOR=y
CONFIG_USB_TEST=y
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
# CONFIG_USB_ISIGHTFW is not set
CONFIG_USB_YUREX=y
# CONFIG_USB_EZUSB_FX2 is not set
CONFIG_USB_HUB_USB251XB=y
CONFIG_USB_HSIC_USB3503=y
# CONFIG_USB_HSIC_USB4604 is not set
CONFIG_USB_LINK_LAYER_TEST=y
CONFIG_USB_CHAOSKEY=y
# CONFIG_BRCM_USB_PINMAP is not set
# CONFIG_USB_ONBOARD_HUB is not set

#
# USB Physical Layer drivers
#
CONFIG_USB_PHY=y
CONFIG_KEYSTONE_USB_PHY=y
CONFIG_NOP_USB_XCEIV=y
CONFIG_AM335X_CONTROL_USB=y
CONFIG_AM335X_PHY_USB=y
CONFIG_USB_GPIO_VBUS=y
CONFIG_TAHVO_USB=y
# CONFIG_TAHVO_USB_HOST_BY_DEFAULT is not set
CONFIG_USB_ISP1301=y
CONFIG_USB_TEGRA_PHY=y
CONFIG_USB_ULPI=y
CONFIG_USB_ULPI_VIEWPORT=y
CONFIG_JZ4770_PHY=y
# end of USB Physical Layer drivers

# CONFIG_USB_GADGET is not set
CONFIG_TYPEC=y
CONFIG_TYPEC_TCPM=y
CONFIG_TYPEC_TCPCI=y
CONFIG_TYPEC_RT1711H=y
CONFIG_TYPEC_MT6360=y
# CONFIG_TYPEC_TCPCI_MAXIM is not set
# CONFIG_TYPEC_FUSB302 is not set
# CONFIG_TYPEC_UCSI is not set
# CONFIG_TYPEC_TPS6598X is not set
# CONFIG_TYPEC_ANX7411 is not set
CONFIG_TYPEC_RT1719=y
CONFIG_TYPEC_HD3SS3220=y
# CONFIG_TYPEC_STUSB160X is not set
# CONFIG_TYPEC_QCOM_PMIC is not set
CONFIG_TYPEC_WUSB3801=y

#
# USB Type-C Multiplexer/DeMultiplexer Switch support
#
CONFIG_TYPEC_MUX_FSA4480=y
CONFIG_TYPEC_MUX_PI3USB30532=y
# end of USB Type-C Multiplexer/DeMultiplexer Switch support

#
# USB Type-C Alternate Mode drivers
#
CONFIG_TYPEC_DP_ALTMODE=y
CONFIG_TYPEC_NVIDIA_ALTMODE=y
# end of USB Type-C Alternate Mode drivers

CONFIG_USB_ROLE_SWITCH=y
# CONFIG_MMC is not set
# CONFIG_SCSI_UFSHCD is not set
# CONFIG_MEMSTICK is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_CLASS_FLASH=y
# CONFIG_LEDS_CLASS_MULTICOLOR is not set
CONFIG_LEDS_BRIGHTNESS_HW_CHANGED=y

#
# LED drivers
#
CONFIG_LEDS_88PM860X=y
CONFIG_LEDS_APU=y
# CONFIG_LEDS_ARIEL is not set
CONFIG_LEDS_LM3530=y
CONFIG_LEDS_LM3532=y
# CONFIG_LEDS_LM3533 is not set
CONFIG_LEDS_LM3642=y
# CONFIG_LEDS_MT6323 is not set
CONFIG_LEDS_S3C24XX=y
CONFIG_LEDS_COBALT_QUBE=y
# CONFIG_LEDS_COBALT_RAQ is not set
CONFIG_LEDS_GPIO=y
# CONFIG_LEDS_LP3944 is not set
# CONFIG_LEDS_LP3952 is not set
CONFIG_LEDS_LP50XX=y
CONFIG_LEDS_PCA955X=y
CONFIG_LEDS_PCA955X_GPIO=y
CONFIG_LEDS_PCA963X=y
# CONFIG_LEDS_WM831X_STATUS is not set
# CONFIG_LEDS_DA903X is not set
# CONFIG_LEDS_DA9052 is not set
CONFIG_LEDS_DAC124S085=y
CONFIG_LEDS_PWM=y
# CONFIG_LEDS_REGULATOR is not set
CONFIG_LEDS_BD2802=y
CONFIG_LEDS_INTEL_SS4200=y
# CONFIG_LEDS_LT3593 is not set
CONFIG_LEDS_MC13783=y
CONFIG_LEDS_NS2=y
CONFIG_LEDS_TCA6507=y
CONFIG_LEDS_TLC591XX=y
CONFIG_LEDS_LM355x=y
# CONFIG_LEDS_OT200 is not set
CONFIG_LEDS_MENF21BMC=y
# CONFIG_LEDS_IS31FL319X is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=y
# CONFIG_LEDS_PM8058 is not set
CONFIG_LEDS_MLXCPLD=y
CONFIG_LEDS_MLXREG=y
CONFIG_LEDS_USER=y
CONFIG_LEDS_TI_LMU_COMMON=y
CONFIG_LEDS_LM36274=y
CONFIG_LEDS_TPS6105X=y
# CONFIG_LEDS_IP30 is not set
CONFIG_LEDS_ACER_A500=y

#
# Flash and Torch LED drivers
#
CONFIG_LEDS_AS3645A=y
CONFIG_LEDS_LM3601X=y
CONFIG_LEDS_RT8515=y
# CONFIG_LEDS_SGM3140 is not set

#
# RGB LED drivers
#

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=y
CONFIG_LEDS_TRIGGER_ONESHOT=y
CONFIG_LEDS_TRIGGER_MTD=y
CONFIG_LEDS_TRIGGER_HEARTBEAT=y
CONFIG_LEDS_TRIGGER_BACKLIGHT=y
CONFIG_LEDS_TRIGGER_CPU=y
CONFIG_LEDS_TRIGGER_ACTIVITY=y
# CONFIG_LEDS_TRIGGER_GPIO is not set
CONFIG_LEDS_TRIGGER_DEFAULT_ON=y

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=y
CONFIG_LEDS_TRIGGER_CAMERA=y
CONFIG_LEDS_TRIGGER_PANIC=y
# CONFIG_LEDS_TRIGGER_NETDEV is not set
CONFIG_LEDS_TRIGGER_PATTERN=y
CONFIG_LEDS_TRIGGER_AUDIO=y

#
# Simple LED drivers
#
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
# CONFIG_EDAC is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
# CONFIG_RTC_HCTOSYS is not set
CONFIG_RTC_SYSTOHC=y
CONFIG_RTC_SYSTOHC_DEVICE="rtc0"
CONFIG_RTC_DEBUG=y
CONFIG_RTC_LIB_KUNIT_TEST=y
CONFIG_RTC_NVMEM=y

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_DEV=y
CONFIG_RTC_INTF_DEV_UIE_EMUL=y
CONFIG_RTC_DRV_TEST=y

#
# I2C RTC drivers
#
# CONFIG_RTC_DRV_88PM860X is not set
CONFIG_RTC_DRV_88PM80X=y
CONFIG_RTC_DRV_ABB5ZES3=y
# CONFIG_RTC_DRV_ABEOZ9 is not set
CONFIG_RTC_DRV_ABX80X=y
CONFIG_RTC_DRV_BRCMSTB=y
CONFIG_RTC_DRV_DS1307=y
CONFIG_RTC_DRV_DS1307_CENTURY=y
CONFIG_RTC_DRV_DS1374=y
CONFIG_RTC_DRV_DS1374_WDT=y
CONFIG_RTC_DRV_DS1672=y
CONFIG_RTC_DRV_MAX6900=y
CONFIG_RTC_DRV_MAX8907=y
CONFIG_RTC_DRV_MAX8998=y
CONFIG_RTC_DRV_MAX77686=y
CONFIG_RTC_DRV_RS5C372=y
CONFIG_RTC_DRV_ISL1208=y
CONFIG_RTC_DRV_ISL12022=y
CONFIG_RTC_DRV_ISL12026=y
# CONFIG_RTC_DRV_X1205 is not set
CONFIG_RTC_DRV_PCF8523=y
CONFIG_RTC_DRV_PCF85063=y
CONFIG_RTC_DRV_PCF85363=y
CONFIG_RTC_DRV_PCF8563=y
CONFIG_RTC_DRV_PCF8583=y
CONFIG_RTC_DRV_M41T80=y
CONFIG_RTC_DRV_M41T80_WDT=y
CONFIG_RTC_DRV_BQ32K=y
CONFIG_RTC_DRV_TPS6586X=y
CONFIG_RTC_DRV_S35390A=y
CONFIG_RTC_DRV_FM3130=y
# CONFIG_RTC_DRV_RX8010 is not set
CONFIG_RTC_DRV_RX8581=y
# CONFIG_RTC_DRV_RX8025 is not set
# CONFIG_RTC_DRV_EM3027 is not set
# CONFIG_RTC_DRV_RV3028 is not set
CONFIG_RTC_DRV_RV3032=y
CONFIG_RTC_DRV_RV8803=y
CONFIG_RTC_DRV_S5M=y
CONFIG_RTC_DRV_SD3078=y

#
# SPI RTC drivers
#
# CONFIG_RTC_DRV_M41T93 is not set
CONFIG_RTC_DRV_M41T94=y
CONFIG_RTC_DRV_DS1302=y
CONFIG_RTC_DRV_DS1305=y
# CONFIG_RTC_DRV_DS1343 is not set
CONFIG_RTC_DRV_DS1347=y
CONFIG_RTC_DRV_DS1390=y
# CONFIG_RTC_DRV_MAX6916 is not set
# CONFIG_RTC_DRV_R9701 is not set
# CONFIG_RTC_DRV_RX4581 is not set
# CONFIG_RTC_DRV_RS5C348 is not set
CONFIG_RTC_DRV_MAX6902=y
CONFIG_RTC_DRV_PCF2123=y
# CONFIG_RTC_DRV_MCP795 is not set
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
# CONFIG_RTC_DRV_DS3232 is not set
CONFIG_RTC_DRV_PCF2127=y
# CONFIG_RTC_DRV_RV3029C2 is not set
CONFIG_RTC_DRV_RX6110=y

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
CONFIG_RTC_DRV_DS1286=y
# CONFIG_RTC_DRV_DS1511 is not set
CONFIG_RTC_DRV_DS1553=y
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
# CONFIG_RTC_DRV_DS1742 is not set
# CONFIG_RTC_DRV_DS2404 is not set
CONFIG_RTC_DRV_DA9052=y
CONFIG_RTC_DRV_DA9055=y
# CONFIG_RTC_DRV_DA9063 is not set
CONFIG_RTC_DRV_STK17TA8=y
# CONFIG_RTC_DRV_M48T86 is not set
CONFIG_RTC_DRV_M48T35=y
CONFIG_RTC_DRV_M48T59=y
# CONFIG_RTC_DRV_MSM6242 is not set
CONFIG_RTC_DRV_BQ4802=y
CONFIG_RTC_DRV_RP5C01=y
# CONFIG_RTC_DRV_V3020 is not set
# CONFIG_RTC_DRV_GAMECUBE is not set
# CONFIG_RTC_DRV_WM831X is not set
# CONFIG_RTC_DRV_SC27XX is not set
CONFIG_RTC_DRV_SPEAR=y
# CONFIG_RTC_DRV_PCF50633 is not set

#
# on-CPU RTC drivers
#
CONFIG_RTC_DRV_ASM9260=y
# CONFIG_RTC_DRV_DAVINCI is not set
# CONFIG_RTC_DRV_DIGICOLOR is not set
CONFIG_RTC_DRV_FSL_FTM_ALARM=y
CONFIG_RTC_DRV_MESON=y
CONFIG_RTC_DRV_MESON_VRTC=y
CONFIG_RTC_DRV_S3C=y
CONFIG_RTC_DRV_EP93XX=y
CONFIG_RTC_DRV_GENERIC=y
CONFIG_RTC_DRV_VT8500=y
CONFIG_RTC_DRV_SUN6I=y
CONFIG_RTC_DRV_SUNXI=y
CONFIG_RTC_DRV_MV=y
CONFIG_RTC_DRV_FTRTC010=y
CONFIG_RTC_DRV_STMP=y
# CONFIG_RTC_DRV_PCAP is not set
# CONFIG_RTC_DRV_MC13XXX is not set
# CONFIG_RTC_DRV_LPC32XX is not set
CONFIG_RTC_DRV_PM8XXX=y
CONFIG_RTC_DRV_TEGRA=y
CONFIG_RTC_DRV_MOXART=y
# CONFIG_RTC_DRV_MT2712 is not set
CONFIG_RTC_DRV_MT6397=y
CONFIG_RTC_DRV_MT7622=y
CONFIG_RTC_DRV_XGENE=y
CONFIG_RTC_DRV_STM32=y
CONFIG_RTC_DRV_RTD119X=y
# CONFIG_RTC_DRV_TI_K3 is not set

#
# HID Sensor RTC drivers
#
# CONFIG_RTC_DRV_GOLDFISH is not set
CONFIG_RTC_DRV_MSC313=y
# CONFIG_DMADEVICES is not set

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
CONFIG_SW_SYNC=y
CONFIG_UDMABUF=y
# CONFIG_DMABUF_MOVE_NOTIFY is not set
CONFIG_DMABUF_DEBUG=y
CONFIG_DMABUF_SELFTESTS=y
CONFIG_DMABUF_HEAPS=y
CONFIG_DMABUF_SYSFS_STATS=y
CONFIG_DMABUF_HEAPS_SYSTEM=y
# CONFIG_DMABUF_HEAPS_CMA is not set
# end of DMABUF options

# CONFIG_AUXDISPLAY is not set
# CONFIG_PANEL is not set
# CONFIG_UIO is not set
CONFIG_VFIO=y
CONFIG_VFIO_IOMMU_TYPE1=y
CONFIG_VFIO_VIRQFD=y
CONFIG_VFIO_NOIOMMU=y
CONFIG_VFIO_PCI_MMAP=y
CONFIG_VFIO_PCI_INTX=y
# CONFIG_VFIO_PCI is not set
CONFIG_VFIO_PLATFORM=y
# CONFIG_VFIO_AMBA is not set
CONFIG_VFIO_PLATFORM_CALXEDAXGMAC_RESET=y
# CONFIG_VFIO_PLATFORM_AMDXGBE_RESET is not set
CONFIG_VFIO_PLATFORM_BCMFLEXRM_RESET=y
CONFIG_VFIO_MDEV=y
CONFIG_VIRT_DRIVERS=y
CONFIG_SEV_GUEST=y
CONFIG_VIRTIO_ANCHOR=y
CONFIG_VIRTIO=y
# CONFIG_VIRTIO_MENU is not set
# CONFIG_VDPA is not set
# CONFIG_VHOST_MENU is not set

#
# Microsoft Hyper-V guest support
#
# end of Microsoft Hyper-V guest support

CONFIG_GREYBUS=y
CONFIG_GREYBUS_ES2=y
CONFIG_COMEDI=y
CONFIG_COMEDI_DEBUG=y
CONFIG_COMEDI_DEFAULT_BUF_SIZE_KB=2048
CONFIG_COMEDI_DEFAULT_BUF_MAXSIZE_KB=20480
CONFIG_COMEDI_MISC_DRIVERS=y
CONFIG_COMEDI_BOND=y
# CONFIG_COMEDI_TEST is not set
CONFIG_COMEDI_PARPORT=y
# CONFIG_COMEDI_SSV_DNP is not set
# CONFIG_COMEDI_ISA_DRIVERS is not set
# CONFIG_COMEDI_PCI_DRIVERS is not set
# CONFIG_COMEDI_USB_DRIVERS is not set
# CONFIG_COMEDI_8255_SA is not set
CONFIG_COMEDI_KCOMEDILIB=y
CONFIG_COMEDI_NI_ROUTING=y
CONFIG_COMEDI_TESTS=y
CONFIG_COMEDI_TESTS_EXAMPLE=y
CONFIG_COMEDI_TESTS_NI_ROUTES=y
CONFIG_STAGING=y
CONFIG_RTS5208=y
CONFIG_OCTEON_ETHERNET=y

#
# IIO staging drivers
#

#
# Accelerometers
#
# CONFIG_ADIS16203 is not set
CONFIG_ADIS16240=y
# end of Accelerometers

#
# Analog to digital converters
#
CONFIG_AD7816=y
# end of Analog to digital converters

#
# Analog digital bi-direction converters
#
CONFIG_ADT7316=y
CONFIG_ADT7316_SPI=y
# CONFIG_ADT7316_I2C is not set
# end of Analog digital bi-direction converters

#
# Capacitance to digital converters
#
# CONFIG_AD7746 is not set
# end of Capacitance to digital converters

#
# Direct Digital Synthesis
#
CONFIG_AD9832=y
# CONFIG_AD9834 is not set
# end of Direct Digital Synthesis

#
# Network Analyzer, Impedance Converters
#
# CONFIG_AD5933 is not set
# end of Network Analyzer, Impedance Converters

#
# Active energy metering IC
#
CONFIG_ADE7854=y
# CONFIG_ADE7854_I2C is not set
CONFIG_ADE7854_SPI=y
# end of Active energy metering IC

#
# Resolver to digital converters
#
# CONFIG_AD2S1210 is not set
# end of Resolver to digital converters
# end of IIO staging drivers

CONFIG_FB_SM750=y
# CONFIG_STAGING_MEDIA is not set
# CONFIG_FB_TFT is not set
CONFIG_GREYBUS_AUDIO=y
CONFIG_GREYBUS_AUDIO_APB_CODEC=y
CONFIG_GREYBUS_BOOTROM=y
CONFIG_GREYBUS_FIRMWARE=y
CONFIG_GREYBUS_LIGHT=y
# CONFIG_GREYBUS_LOG is not set
# CONFIG_GREYBUS_LOOPBACK is not set
CONFIG_GREYBUS_POWER=y
CONFIG_GREYBUS_RAW=y
CONFIG_GREYBUS_VIBRATOR=y
CONFIG_GREYBUS_BRIDGED_PHY=y
CONFIG_GREYBUS_GPIO=y
CONFIG_GREYBUS_I2C=y
CONFIG_GREYBUS_PWM=y
CONFIG_GREYBUS_SPI=y
# CONFIG_GREYBUS_USB is not set
# CONFIG_GREYBUS_ARCHE is not set
CONFIG_PI433=y
CONFIG_FIELDBUS_DEV=y
CONFIG_QLGE=y
CONFIG_VME_BUS=y

#
# VME Bridge Drivers
#
# CONFIG_VME_TSI148 is not set
CONFIG_VME_FAKE=y

#
# VME Device Drivers
#
CONFIG_VME_USER=y
# CONFIG_GOLDFISH_PIPE is not set
# CONFIG_CHROME_PLATFORMS is not set
CONFIG_MELLANOX_PLATFORM=y
CONFIG_MLXREG_HOTPLUG=y
CONFIG_MLXREG_IO=y
CONFIG_MLXREG_LC=y
CONFIG_NVSW_SN2201=y
# CONFIG_OLPC_XO175 is not set
CONFIG_SURFACE_PLATFORMS=y
# CONFIG_X86_PLATFORM_DEVICES is not set
CONFIG_P2SB=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
CONFIG_COMMON_CLK_WM831X=y

#
# Clock driver for ARM Reference designs
#
CONFIG_CLK_ICST=y
# CONFIG_CLK_SP810 is not set
# end of Clock driver for ARM Reference designs

# CONFIG_CLK_HSDK is not set
# CONFIG_LMK04832 is not set
CONFIG_COMMON_CLK_APPLE_NCO=y
CONFIG_COMMON_CLK_MAX77686=y
CONFIG_COMMON_CLK_MAX9485=y
CONFIG_COMMON_CLK_HI655X=y
CONFIG_COMMON_CLK_SCMI=y
# CONFIG_COMMON_CLK_SCPI is not set
CONFIG_COMMON_CLK_SI5341=y
CONFIG_COMMON_CLK_SI5351=y
# CONFIG_COMMON_CLK_SI544 is not set
# CONFIG_COMMON_CLK_BM1880 is not set
CONFIG_COMMON_CLK_CDCE706=y
# CONFIG_COMMON_CLK_TPS68470 is not set
CONFIG_COMMON_CLK_CS2000_CP=y
# CONFIG_COMMON_CLK_FSL_FLEXSPI is not set
CONFIG_COMMON_CLK_FSL_SAI=y
CONFIG_COMMON_CLK_GEMINI=y
CONFIG_COMMON_CLK_ASPEED=y
CONFIG_COMMON_CLK_S2MPS11=y
CONFIG_CLK_LS1028A_PLLDIG=y
CONFIG_COMMON_CLK_XGENE=y
CONFIG_COMMON_CLK_PWM=y
# CONFIG_COMMON_CLK_OXNAS is not set
# CONFIG_COMMON_CLK_MMP2_AUDIO is not set
CONFIG_CLK_ACTIONS=y
# CONFIG_CLK_OWL_S500 is not set
# CONFIG_CLK_OWL_S700 is not set
# CONFIG_CLK_OWL_S900 is not set
CONFIG_CLK_BAIKAL_T1=y
# CONFIG_CLK_BT1_CCU_PLL is not set
# CONFIG_CLK_BT1_CCU_DIV is not set
CONFIG_CLK_BCM2711_DVP=y
# CONFIG_CLK_BCM2835 is not set
# CONFIG_CLK_BCM_63XX is not set
CONFIG_CLK_BCM_63XX_GATE=y
# CONFIG_CLK_BCM_KONA is not set
CONFIG_COMMON_CLK_IPROC=y
# CONFIG_CLK_BCM_CYGNUS is not set
CONFIG_CLK_BCM_HR2=y
# CONFIG_CLK_BCM_NSP is not set
CONFIG_CLK_BCM_NS2=y
# CONFIG_CLK_BCM_SR is not set
CONFIG_CLK_RASPBERRYPI=y
CONFIG_COMMON_CLK_HI3516CV300=y
CONFIG_COMMON_CLK_HI3519=y
CONFIG_COMMON_CLK_HI3559A=y
CONFIG_COMMON_CLK_HI3660=y
CONFIG_COMMON_CLK_HI3670=y
CONFIG_COMMON_CLK_HI3798CV200=y
# CONFIG_COMMON_CLK_HI6220 is not set
CONFIG_RESET_HISI=y
# CONFIG_STUB_CLK_HI6220 is not set
# CONFIG_STUB_CLK_HI3660 is not set
# CONFIG_COMMON_CLK_BOSTON is not set
CONFIG_MXC_CLK=y
# CONFIG_CLK_IMX8MM is not set
# CONFIG_CLK_IMX8MN is not set
CONFIG_CLK_IMX8MP=y
# CONFIG_CLK_IMX8MQ is not set
# CONFIG_CLK_IMX8ULP is not set
CONFIG_CLK_IMX93=y

#
# Ingenic SoCs drivers
#
CONFIG_INGENIC_CGU_COMMON=y
CONFIG_INGENIC_CGU_JZ4740=y
CONFIG_INGENIC_CGU_JZ4725B=y
# CONFIG_INGENIC_CGU_JZ4760 is not set
CONFIG_INGENIC_CGU_JZ4770=y
# CONFIG_INGENIC_CGU_JZ4780 is not set
# CONFIG_INGENIC_CGU_X1000 is not set
# CONFIG_INGENIC_CGU_X1830 is not set
CONFIG_INGENIC_TCU_CLK=y
# end of Ingenic SoCs drivers

CONFIG_TI_SYSCON_CLK=y

#
# Clock driver for MediaTek SoC
#
CONFIG_COMMON_CLK_MEDIATEK=y
# CONFIG_COMMON_CLK_MT2701 is not set
CONFIG_COMMON_CLK_MT2712=y
CONFIG_COMMON_CLK_MT2712_BDPSYS=y
# CONFIG_COMMON_CLK_MT2712_IMGSYS is not set
# CONFIG_COMMON_CLK_MT2712_JPGDECSYS is not set
# CONFIG_COMMON_CLK_MT2712_MFGCFG is not set
# CONFIG_COMMON_CLK_MT2712_MMSYS is not set
CONFIG_COMMON_CLK_MT2712_VDECSYS=y
# CONFIG_COMMON_CLK_MT2712_VENCSYS is not set
# CONFIG_COMMON_CLK_MT6765 is not set
# CONFIG_COMMON_CLK_MT6779 is not set
CONFIG_COMMON_CLK_MT6797=y
# CONFIG_COMMON_CLK_MT6797_MMSYS is not set
# CONFIG_COMMON_CLK_MT6797_IMGSYS is not set
CONFIG_COMMON_CLK_MT6797_VDECSYS=y
# CONFIG_COMMON_CLK_MT6797_VENCSYS is not set
CONFIG_COMMON_CLK_MT7622=y
# CONFIG_COMMON_CLK_MT7622_ETHSYS is not set
# CONFIG_COMMON_CLK_MT7622_HIFSYS is not set
CONFIG_COMMON_CLK_MT7622_AUDSYS=y
CONFIG_COMMON_CLK_MT7629=y
CONFIG_COMMON_CLK_MT7629_ETHSYS=y
CONFIG_COMMON_CLK_MT7629_HIFSYS=y
CONFIG_COMMON_CLK_MT7986=y
CONFIG_COMMON_CLK_MT7986_ETHSYS=y
# CONFIG_COMMON_CLK_MT8135 is not set
CONFIG_COMMON_CLK_MT8167=y
# CONFIG_COMMON_CLK_MT8167_AUDSYS is not set
CONFIG_COMMON_CLK_MT8167_IMGSYS=y
CONFIG_COMMON_CLK_MT8167_MFGCFG=y
CONFIG_COMMON_CLK_MT8167_MMSYS=y
CONFIG_COMMON_CLK_MT8167_VDECSYS=y
CONFIG_COMMON_CLK_MT8173=y
# CONFIG_COMMON_CLK_MT8173_MMSYS is not set
CONFIG_COMMON_CLK_MT8183=y
CONFIG_COMMON_CLK_MT8183_AUDIOSYS=y
# CONFIG_COMMON_CLK_MT8183_CAMSYS is not set
CONFIG_COMMON_CLK_MT8183_IMGSYS=y
CONFIG_COMMON_CLK_MT8183_IPU_CORE0=y
CONFIG_COMMON_CLK_MT8183_IPU_CORE1=y
# CONFIG_COMMON_CLK_MT8183_IPU_ADL is not set
CONFIG_COMMON_CLK_MT8183_IPU_CONN=y
CONFIG_COMMON_CLK_MT8183_MFGCFG=y
# CONFIG_COMMON_CLK_MT8183_MMSYS is not set
# CONFIG_COMMON_CLK_MT8183_VDECSYS is not set
# CONFIG_COMMON_CLK_MT8183_VENCSYS is not set
CONFIG_COMMON_CLK_MT8186=y
CONFIG_COMMON_CLK_MT8192=y
CONFIG_COMMON_CLK_MT8192_AUDSYS=y
CONFIG_COMMON_CLK_MT8192_CAMSYS=y
# CONFIG_COMMON_CLK_MT8192_IMGSYS is not set
# CONFIG_COMMON_CLK_MT8192_IMP_IIC_WRAP is not set
# CONFIG_COMMON_CLK_MT8192_IPESYS is not set
# CONFIG_COMMON_CLK_MT8192_MDPSYS is not set
# CONFIG_COMMON_CLK_MT8192_MFGCFG is not set
# CONFIG_COMMON_CLK_MT8192_MMSYS is not set
# CONFIG_COMMON_CLK_MT8192_MSDC is not set
CONFIG_COMMON_CLK_MT8192_SCP_ADSP=y
CONFIG_COMMON_CLK_MT8192_VDECSYS=y
CONFIG_COMMON_CLK_MT8192_VENCSYS=y
# CONFIG_COMMON_CLK_MT8195 is not set
CONFIG_COMMON_CLK_MT8516=y
# CONFIG_COMMON_CLK_MT8516_AUDSYS is not set
# end of Clock driver for MediaTek SoC

#
# Clock support for Amlogic platforms
#
# CONFIG_COMMON_CLK_AXG_AUDIO is not set
# end of Clock support for Amlogic platforms

# CONFIG_MSTAR_MSC313_MPLL is not set
# CONFIG_MCHP_CLK_MPFS is not set
CONFIG_COMMON_CLK_PISTACHIO=y
# CONFIG_CLK_MT7621 is not set
CONFIG_CLK_RENESAS=y
CONFIG_CLK_EMEV2=y
# CONFIG_CLK_RZA1 is not set
CONFIG_CLK_R7S9210=y
# CONFIG_CLK_R8A73A4 is not set
CONFIG_CLK_R8A7740=y
CONFIG_CLK_R8A7742=y
# CONFIG_CLK_R8A7743 is not set
# CONFIG_CLK_R8A7745 is not set
# CONFIG_CLK_R8A77470 is not set
# CONFIG_CLK_R8A774A1 is not set
CONFIG_CLK_R8A774B1=y
# CONFIG_CLK_R8A774C0 is not set
CONFIG_CLK_R8A774E1=y
# CONFIG_CLK_R8A7778 is not set
CONFIG_CLK_R8A7779=y
# CONFIG_CLK_R8A7790 is not set
# CONFIG_CLK_R8A7791 is not set
CONFIG_CLK_R8A7792=y
CONFIG_CLK_R8A7794=y
CONFIG_CLK_R8A7795=y
# CONFIG_CLK_R8A77960 is not set
# CONFIG_CLK_R8A77961 is not set
# CONFIG_CLK_R8A77965 is not set
# CONFIG_CLK_R8A77970 is not set
# CONFIG_CLK_R8A77980 is not set
CONFIG_CLK_R8A77990=y
# CONFIG_CLK_R8A77995 is not set
CONFIG_CLK_R8A779A0=y
CONFIG_CLK_R8A779F0=y
CONFIG_CLK_R8A779G0=y
CONFIG_CLK_R9A06G032=y
# CONFIG_CLK_R9A07G043 is not set
CONFIG_CLK_R9A07G044=y
CONFIG_CLK_R9A07G054=y
# CONFIG_CLK_R9A09G011 is not set
# CONFIG_CLK_SH73A0 is not set
CONFIG_CLK_RCAR_CPG_LIB=y
CONFIG_CLK_RCAR_GEN2_CPG=y
CONFIG_CLK_RCAR_GEN3_CPG=y
CONFIG_CLK_RCAR_GEN4_CPG=y
# CONFIG_CLK_RCAR_USB2_CLOCK_SEL is not set
CONFIG_CLK_RZG2L=y
CONFIG_CLK_RENESAS_CPG_MSSR=y
CONFIG_CLK_RENESAS_CPG_MSTP=y
CONFIG_CLK_RENESAS_DIV6=y
CONFIG_COMMON_CLK_SAMSUNG=y
CONFIG_S3C64XX_COMMON_CLK=y
# CONFIG_S5PV210_COMMON_CLK is not set
# CONFIG_EXYNOS_3250_COMMON_CLK is not set
# CONFIG_EXYNOS_4_COMMON_CLK is not set
# CONFIG_EXYNOS_5250_COMMON_CLK is not set
CONFIG_EXYNOS_5260_COMMON_CLK=y
# CONFIG_EXYNOS_5410_COMMON_CLK is not set
CONFIG_EXYNOS_5420_COMMON_CLK=y
# CONFIG_EXYNOS_ARM64_COMMON_CLK is not set
CONFIG_EXYNOS_AUDSS_CLK_CON=y
CONFIG_EXYNOS_CLKOUT=y
CONFIG_S3C2410_COMMON_CLK=y
# CONFIG_S3C2412_COMMON_CLK is not set
CONFIG_S3C2443_COMMON_CLK=y
# CONFIG_CLK_SIFIVE is not set
CONFIG_CLK_INTEL_SOCFPGA=y
# CONFIG_CLK_INTEL_SOCFPGA32 is not set
# CONFIG_CLK_INTEL_SOCFPGA64 is not set
# CONFIG_SPRD_COMMON_CLK is not set
CONFIG_CLK_STARFIVE_JH7100=y
# CONFIG_CLK_STARFIVE_JH7100_AUDIO is not set
CONFIG_CLK_SUNXI=y
CONFIG_CLK_SUNXI_CLOCKS=y
CONFIG_CLK_SUNXI_PRCM_SUN6I=y
CONFIG_CLK_SUNXI_PRCM_SUN8I=y
# CONFIG_CLK_SUNXI_PRCM_SUN9I is not set
# CONFIG_SUNXI_CCU is not set
# CONFIG_COMMON_CLK_TI_ADPLL is not set
CONFIG_COMMON_CLK_VISCONTI=y
CONFIG_XILINX_VCU=y
# CONFIG_COMMON_CLK_ZYNQMP is not set
CONFIG_CLK_KUNIT_TEST=y
CONFIG_CLK_GATE_KUNIT_TEST=y
CONFIG_HWSPINLOCK=y
CONFIG_HWSPINLOCK_OMAP=y
CONFIG_HWSPINLOCK_QCOM=y
CONFIG_HWSPINLOCK_SPRD=y
CONFIG_HWSPINLOCK_STM32=y
# CONFIG_HWSPINLOCK_SUN6I is not set
CONFIG_HSEM_U8500=y

#
# Clock Source drivers
#
CONFIG_TIMER_OF=y
CONFIG_TIMER_PROBE=y
CONFIG_CLKEVT_I8253=y
CONFIG_CLKBLD_I8253=y
CONFIG_CLKSRC_MMIO=y
# CONFIG_BCM2835_TIMER is not set
CONFIG_BCM_KONA_TIMER=y
CONFIG_DAVINCI_TIMER=y
# CONFIG_DIGICOLOR_TIMER is not set
# CONFIG_OMAP_DM_TIMER is not set
# CONFIG_DW_APB_TIMER is not set
# CONFIG_FTTMR010_TIMER is not set
# CONFIG_IXP4XX_TIMER is not set
CONFIG_MESON6_TIMER=y
# CONFIG_OWL_TIMER is not set
CONFIG_RDA_TIMER=y
CONFIG_SUN4I_TIMER=y
# CONFIG_SUN5I_HSTIMER is not set
# CONFIG_TEGRA_TIMER is not set
# CONFIG_TEGRA186_TIMER is not set
CONFIG_VT8500_TIMER=y
CONFIG_NPCM7XX_TIMER=y
# CONFIG_CADENCE_TTC_TIMER is not set
# CONFIG_ASM9260_TIMER is not set
# CONFIG_CLKSRC_DBX500_PRCMU is not set
# CONFIG_CLPS711X_TIMER is not set
CONFIG_MXS_TIMER=y
CONFIG_NSPIRE_TIMER=y
# CONFIG_INTEGRATOR_AP_TIMER is not set
CONFIG_CLKSRC_PISTACHIO=y
CONFIG_CLKSRC_STM32_LP=y
# CONFIG_ARMV7M_SYSTICK is not set
# CONFIG_ATMEL_PIT is not set
CONFIG_ATMEL_ST=y
CONFIG_CLKSRC_SAMSUNG_PWM=y
# CONFIG_FSL_FTM_TIMER is not set
# CONFIG_OXNAS_RPS_TIMER is not set
# CONFIG_MTK_TIMER is not set
# CONFIG_SPRD_TIMER is not set
CONFIG_SH_TIMER_CMT=y
CONFIG_SH_TIMER_MTU2=y
CONFIG_RENESAS_OSTM=y
CONFIG_SH_TIMER_TMU=y
CONFIG_EM_TIMER_STI=y
CONFIG_CLKSRC_PXA=y
CONFIG_TIMER_IMX_SYS_CTR=y
# CONFIG_CLKSRC_ST_LPC is not set
CONFIG_GXP_TIMER=y
CONFIG_MSC313E_TIMER=y
CONFIG_INGENIC_TIMER=y
# CONFIG_INGENIC_SYSOST is not set
CONFIG_INGENIC_OST=y
CONFIG_MICROCHIP_PIT64B=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
# CONFIG_IMX_MBOX is not set
# CONFIG_ROCKCHIP_MBOX is not set
CONFIG_ALTERA_MBOX=y
CONFIG_POLARFIRE_SOC_MAILBOX=y
CONFIG_QCOM_APCS_IPC=y
CONFIG_BCM_PDC_MBOX=y
CONFIG_STM32_IPCC=y
CONFIG_MTK_ADSP_MBOX=y
CONFIG_MTK_CMDQ_MBOX=y
CONFIG_SUN6I_MSGBOX=y
CONFIG_SPRD_MBOX=y
CONFIG_QCOM_IPCC=y
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
CONFIG_IOMMU_IO_PGTABLE=y
CONFIG_IOMMU_IO_PGTABLE_LPAE=y
CONFIG_IOMMU_IO_PGTABLE_LPAE_SELFTEST=y
CONFIG_IOMMU_IO_PGTABLE_ARMV7S=y
# CONFIG_IOMMU_IO_PGTABLE_ARMV7S_SELFTEST is not set
# end of Generic IOMMU Pagetable Support

# CONFIG_IOMMU_DEBUGFS is not set
# CONFIG_IOMMU_DEFAULT_DMA_STRICT is not set
CONFIG_IOMMU_DEFAULT_DMA_LAZY=y
# CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
CONFIG_OMAP_IOMMU=y
CONFIG_OMAP_IOMMU_DEBUG=y
# CONFIG_ROCKCHIP_IOMMU is not set
CONFIG_SUN50I_IOMMU=y
# CONFIG_EXYNOS_IOMMU is not set
CONFIG_IPMMU_VMSA=y
CONFIG_APPLE_DART=y
CONFIG_ARM_SMMU=y
# CONFIG_ARM_SMMU_DISABLE_BYPASS_BY_DEFAULT is not set
# CONFIG_S390_CCW_IOMMU is not set
CONFIG_S390_AP_IOMMU=y
CONFIG_MTK_IOMMU=y
CONFIG_QCOM_IOMMU=y
# CONFIG_VIRTIO_IOMMU is not set
CONFIG_SPRD_IOMMU=y

#
# Remoteproc drivers
#
CONFIG_REMOTEPROC=y
# CONFIG_REMOTEPROC_CDEV is not set
# CONFIG_INGENIC_VPU_RPROC is not set
CONFIG_MTK_SCP=y
CONFIG_MESON_MX_AO_ARC_REMOTEPROC=y
CONFIG_RCAR_REMOTEPROC=y
# end of Remoteproc drivers

#
# Rpmsg drivers
#
CONFIG_RPMSG=y
CONFIG_RPMSG_CHAR=y
CONFIG_RPMSG_CTRL=y
CONFIG_RPMSG_NS=y
CONFIG_RPMSG_MTK_SCP=y
CONFIG_RPMSG_QCOM_GLINK=y
CONFIG_RPMSG_QCOM_GLINK_RPM=y
# CONFIG_RPMSG_QCOM_GLINK_SMEM is not set
CONFIG_RPMSG_QCOM_SMD=y
CONFIG_RPMSG_VIRTIO=y
# end of Rpmsg drivers

#
# SOC (System On Chip) specific Drivers
#
# CONFIG_OWL_PM_DOMAINS is not set

#
# Amlogic SoC drivers
#
CONFIG_MESON_CANVAS=y
CONFIG_MESON_CLK_MEASURE=y
CONFIG_MESON_GX_SOCINFO=y
# CONFIG_MESON_MX_SOCINFO is not set
# end of Amlogic SoC drivers

#
# Apple SoC drivers
#
# CONFIG_APPLE_PMGR_PWRSTATE is not set
# CONFIG_APPLE_RTKIT is not set
CONFIG_APPLE_SART=y
# end of Apple SoC drivers

#
# ASPEED SoC drivers
#
CONFIG_ASPEED_LPC_CTRL=y
CONFIG_ASPEED_LPC_SNOOP=y
CONFIG_ASPEED_UART_ROUTING=y
CONFIG_ASPEED_P2A_CTRL=y
# CONFIG_ASPEED_SOCINFO is not set
# end of ASPEED SoC drivers

# CONFIG_AT91_SOC_ID is not set
# CONFIG_AT91_SOC_SFR is not set

#
# Broadcom SoC drivers
#
CONFIG_SOC_BCM63XX=y
CONFIG_SOC_BRCMSTB=y
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# end of NXP/Freescale QorIQ SoC drivers

#
# fujitsu SoC drivers
#
# end of fujitsu SoC drivers

#
# i.MX SoC drivers
#
CONFIG_SOC_IMX8M=y
# end of i.MX SoC drivers

#
# IXP4xx SoC drivers
#
CONFIG_IXP4XX_QMGR=y
CONFIG_IXP4XX_NPE=y
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
CONFIG_MTK_CMDQ=y
CONFIG_MTK_DEVAPC=y
CONFIG_MTK_INFRACFG=y
CONFIG_MTK_PMIC_WRAP=y
CONFIG_MTK_SCPSYS=y
# CONFIG_MTK_SCPSYS_PM_DOMAINS is not set
# CONFIG_MTK_MMSYS is not set
# CONFIG_MTK_SVS is not set
# end of MediaTek SoC drivers

CONFIG_POLARFIRE_SOC_SYS_CTRL=y

#
# Qualcomm SoC drivers
#
# CONFIG_QCOM_AOSS_QMP is not set
CONFIG_QCOM_GENI_SE=y
# CONFIG_QCOM_GSBI is not set
# CONFIG_QCOM_LLCC is not set
CONFIG_QCOM_PDR_HELPERS=y
CONFIG_QCOM_QMI_HELPERS=y
CONFIG_QCOM_RPMH=y
# CONFIG_QCOM_RPMPD is not set
CONFIG_QCOM_SMEM=y
CONFIG_QCOM_SMD_RPM=y
CONFIG_QCOM_SMEM_STATE=y
CONFIG_QCOM_SMP2P=y
# CONFIG_QCOM_SMSM is not set
CONFIG_QCOM_SOCINFO=y
CONFIG_QCOM_SPM=y
# CONFIG_QCOM_STATS is not set
# CONFIG_QCOM_WCNSS_CTRL is not set
CONFIG_QCOM_APR=y
# CONFIG_QCOM_ICC_BWMON is not set
# end of Qualcomm SoC drivers

# CONFIG_SOC_RENESAS is not set
CONFIG_ROCKCHIP_GRF=y
CONFIG_ROCKCHIP_PM_DOMAINS=y
CONFIG_SOC_SAMSUNG=y
# CONFIG_EXYNOS_CHIPID is not set
CONFIG_EXYNOS_USI=y
# CONFIG_EXYNOS_PM_DOMAINS is not set
# CONFIG_EXYNOS_REGULATOR_COUPLER is not set
CONFIG_SOC_TEGRA20_VOLTAGE_COUPLER=y
# CONFIG_SOC_TEGRA30_VOLTAGE_COUPLER is not set
# CONFIG_SOC_TI is not set
# CONFIG_UX500_SOC_ID is not set

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
# CONFIG_DEVFREQ_GOV_PERFORMANCE is not set
CONFIG_DEVFREQ_GOV_POWERSAVE=y
# CONFIG_DEVFREQ_GOV_USERSPACE is not set
# CONFIG_DEVFREQ_GOV_PASSIVE is not set

#
# DEVFREQ Drivers
#
# CONFIG_ARM_EXYNOS_BUS_DEVFREQ is not set
# CONFIG_ARM_IMX_BUS_DEVFREQ is not set
# CONFIG_ARM_TEGRA_DEVFREQ is not set
# CONFIG_ARM_MEDIATEK_CCI_DEVFREQ is not set
# CONFIG_ARM_SUN8I_A33_MBUS_DEVFREQ is not set
CONFIG_PM_DEVFREQ_EVENT=y
# CONFIG_DEVFREQ_EVENT_EXYNOS_NOCP is not set
CONFIG_DEVFREQ_EVENT_EXYNOS_PPMU=y
CONFIG_DEVFREQ_EVENT_ROCKCHIP_DFI=y
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
# CONFIG_EXTCON_ADC_JACK is not set
CONFIG_EXTCON_GPIO=y
# CONFIG_EXTCON_MAX3355 is not set
CONFIG_EXTCON_PTN5150=y
CONFIG_EXTCON_QCOM_SPMI_MISC=y
# CONFIG_EXTCON_RT8973A is not set
CONFIG_EXTCON_SM5502=y
# CONFIG_EXTCON_USB_GPIO is not set
# CONFIG_EXTCON_USBC_TUSB320 is not set
CONFIG_MEMORY=y
CONFIG_DDR=y
# CONFIG_BRCMSTB_DPFE is not set
CONFIG_BT1_L2_CTL=y
CONFIG_TI_EMIF=y
CONFIG_FPGA_DFL_EMIF=y
# CONFIG_FSL_CORENET_CF is not set
CONFIG_FSL_IFC=y
CONFIG_MTK_SMI=y
# CONFIG_DA8XX_DDRCTL is not set
# CONFIG_RENESAS_RPCIF is not set
CONFIG_STM32_FMC2_EBI=y
# CONFIG_SAMSUNG_MC is not set
# CONFIG_TEGRA_MC is not set
CONFIG_IIO=y
CONFIG_IIO_BUFFER=y
CONFIG_IIO_BUFFER_CB=y
CONFIG_IIO_BUFFER_DMA=y
CONFIG_IIO_BUFFER_DMAENGINE=y
# CONFIG_IIO_BUFFER_HW_CONSUMER is not set
CONFIG_IIO_KFIFO_BUF=y
CONFIG_IIO_TRIGGERED_BUFFER=y
CONFIG_IIO_CONFIGFS=y
CONFIG_IIO_TRIGGER=y
CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
CONFIG_IIO_SW_DEVICE=y
# CONFIG_IIO_SW_TRIGGER is not set
CONFIG_IIO_TRIGGERED_EVENT=y

#
# Accelerometers
#
# CONFIG_ADIS16201 is not set
CONFIG_ADIS16209=y
# CONFIG_ADXL313_I2C is not set
# CONFIG_ADXL313_SPI is not set
CONFIG_ADXL345=y
CONFIG_ADXL345_I2C=y
CONFIG_ADXL345_SPI=y
# CONFIG_ADXL355_I2C is not set
# CONFIG_ADXL355_SPI is not set
CONFIG_ADXL367=y
CONFIG_ADXL367_SPI=y
CONFIG_ADXL367_I2C=y
CONFIG_ADXL372=y
CONFIG_ADXL372_SPI=y
CONFIG_ADXL372_I2C=y
# CONFIG_BMA180 is not set
CONFIG_BMA220=y
# CONFIG_BMA400 is not set
# CONFIG_BMC150_ACCEL is not set
CONFIG_BMI088_ACCEL=y
CONFIG_BMI088_ACCEL_SPI=y
CONFIG_DA280=y
# CONFIG_DA311 is not set
CONFIG_DMARD06=y
CONFIG_DMARD09=y
CONFIG_DMARD10=y
CONFIG_FXLS8962AF=y
# CONFIG_FXLS8962AF_I2C is not set
CONFIG_FXLS8962AF_SPI=y
CONFIG_IIO_ST_ACCEL_3AXIS=y
CONFIG_IIO_ST_ACCEL_I2C_3AXIS=y
CONFIG_IIO_ST_ACCEL_SPI_3AXIS=y
# CONFIG_KXSD9 is not set
# CONFIG_KXCJK1013 is not set
CONFIG_MC3230=y
CONFIG_MMA7455=y
CONFIG_MMA7455_I2C=y
CONFIG_MMA7455_SPI=y
CONFIG_MMA7660=y
CONFIG_MMA8452=y
CONFIG_MMA9551_CORE=y
CONFIG_MMA9551=y
# CONFIG_MMA9553 is not set
# CONFIG_MXC4005 is not set
CONFIG_MXC6255=y
# CONFIG_SCA3000 is not set
# CONFIG_SCA3300 is not set
CONFIG_STK8312=y
CONFIG_STK8BA50=y
# end of Accelerometers

#
# Analog to digital converters
#
CONFIG_AD_SIGMA_DELTA=y
# CONFIG_AD7091R5 is not set
# CONFIG_AD7124 is not set
# CONFIG_AD7192 is not set
CONFIG_AD7266=y
# CONFIG_AD7280 is not set
CONFIG_AD7291=y
CONFIG_AD7292=y
# CONFIG_AD7298 is not set
# CONFIG_AD7476 is not set
CONFIG_AD7606=y
CONFIG_AD7606_IFACE_PARALLEL=y
CONFIG_AD7606_IFACE_SPI=y
CONFIG_AD7766=y
CONFIG_AD7768_1=y
CONFIG_AD7780=y
# CONFIG_AD7791 is not set
# CONFIG_AD7793 is not set
CONFIG_AD7887=y
# CONFIG_AD7923 is not set
CONFIG_AD7949=y
CONFIG_AD799X=y
CONFIG_ASPEED_ADC=y
CONFIG_AT91_SAMA5D2_ADC=y
# CONFIG_AXP20X_ADC is not set
CONFIG_AXP288_ADC=y
# CONFIG_BCM_IPROC_ADC is not set
# CONFIG_BERLIN2_ADC is not set
# CONFIG_CC10001_ADC is not set
CONFIG_DA9150_GPADC=y
# CONFIG_ENVELOPE_DETECTOR is not set
CONFIG_MXS_LRADC_ADC=y
CONFIG_FSL_MX25_ADC=y
CONFIG_HI8435=y
# CONFIG_HX711 is not set
CONFIG_INGENIC_ADC=y
CONFIG_IMX7D_ADC=y
CONFIG_IMX8QXP_ADC=y
# CONFIG_LPC18XX_ADC is not set
CONFIG_LPC32XX_ADC=y
# CONFIG_LTC2471 is not set
CONFIG_LTC2485=y
CONFIG_LTC2496=y
CONFIG_LTC2497=y
CONFIG_MAX1027=y
CONFIG_MAX11100=y
CONFIG_MAX1118=y
CONFIG_MAX1241=y
CONFIG_MAX1363=y
# CONFIG_MAX9611 is not set
CONFIG_MCP320X=y
CONFIG_MCP3422=y
# CONFIG_MCP3911 is not set
CONFIG_MEDIATEK_MT6360_ADC=y
# CONFIG_MEDIATEK_MT6577_AUXADC is not set
CONFIG_MEN_Z188_ADC=y
# CONFIG_MP2629_ADC is not set
CONFIG_NAU7802=y
CONFIG_NPCM_ADC=y
CONFIG_QCOM_VADC_COMMON=y
CONFIG_QCOM_PM8XXX_XOADC=y
CONFIG_QCOM_SPMI_IADC=y
CONFIG_QCOM_SPMI_VADC=y
# CONFIG_QCOM_SPMI_ADC5 is not set
# CONFIG_RCAR_GYRO_ADC is not set
# CONFIG_ROCKCHIP_SARADC is not set
# CONFIG_RZG2L_ADC is not set
CONFIG_SC27XX_ADC=y
CONFIG_SPEAR_ADC=y
# CONFIG_SD_ADC_MODULATOR is not set
CONFIG_STM32_DFSDM_CORE=y
# CONFIG_STM32_DFSDM_ADC is not set
CONFIG_SUN4I_GPADC=y
CONFIG_TI_ADC081C=y
CONFIG_TI_ADC0832=y
# CONFIG_TI_ADC084S021 is not set
# CONFIG_TI_ADC12138 is not set
CONFIG_TI_ADC108S102=y
CONFIG_TI_ADC128S052=y
# CONFIG_TI_ADC161S626 is not set
# CONFIG_TI_ADS1015 is not set
CONFIG_TI_ADS7950=y
# CONFIG_TI_ADS8344 is not set
# CONFIG_TI_ADS8688 is not set
CONFIG_TI_ADS124S08=y
# CONFIG_TI_ADS131E08 is not set
# CONFIG_TI_TLC4541 is not set
# CONFIG_TI_TSC2046 is not set
# CONFIG_VF610_ADC is not set
CONFIG_XILINX_XADC=y
CONFIG_XILINX_AMS=y
# end of Analog to digital converters

#
# Analog to digital and digital to analog converters
#
CONFIG_AD74413R=y
# end of Analog to digital and digital to analog converters

#
# Analog Front Ends
#
# CONFIG_IIO_RESCALE is not set
# end of Analog Front Ends

#
# Amplifiers
#
CONFIG_AD8366=y
CONFIG_ADA4250=y
# CONFIG_HMC425 is not set
# end of Amplifiers

#
# Capacitance to digital converters
#
CONFIG_AD7150=y
# end of Capacitance to digital converters

#
# Chemical Sensors
#
# CONFIG_ATLAS_PH_SENSOR is not set
CONFIG_ATLAS_EZO_SENSOR=y
CONFIG_BME680=y
CONFIG_BME680_I2C=y
CONFIG_BME680_SPI=y
CONFIG_CCS811=y
CONFIG_IAQCORE=y
# CONFIG_PMS7003 is not set
CONFIG_SCD30_CORE=y
CONFIG_SCD30_I2C=y
# CONFIG_SCD30_SERIAL is not set
CONFIG_SCD4X=y
CONFIG_SENSIRION_SGP30=y
CONFIG_SENSIRION_SGP40=y
CONFIG_SPS30=y
CONFIG_SPS30_I2C=y
CONFIG_SPS30_SERIAL=y
CONFIG_SENSEAIR_SUNRISE_CO2=y
CONFIG_VZ89X=y
# end of Chemical Sensors

#
# Hid Sensor IIO Common
#
# end of Hid Sensor IIO Common

CONFIG_IIO_MS_SENSORS_I2C=y

#
# IIO SCMI Sensors
#
# CONFIG_IIO_SCMI is not set
# end of IIO SCMI Sensors

#
# SSP Sensor Common
#
CONFIG_IIO_SSP_SENSORS_COMMONS=y
CONFIG_IIO_SSP_SENSORHUB=y
# end of SSP Sensor Common

CONFIG_IIO_ST_SENSORS_I2C=y
CONFIG_IIO_ST_SENSORS_SPI=y
CONFIG_IIO_ST_SENSORS_CORE=y

#
# Digital to analog converters
#
# CONFIG_AD3552R is not set
CONFIG_AD5064=y
CONFIG_AD5360=y
CONFIG_AD5380=y
# CONFIG_AD5421 is not set
# CONFIG_AD5446 is not set
CONFIG_AD5449=y
CONFIG_AD5592R_BASE=y
CONFIG_AD5592R=y
CONFIG_AD5593R=y
CONFIG_AD5504=y
CONFIG_AD5624R_SPI=y
CONFIG_LTC2688=y
CONFIG_AD5686=y
CONFIG_AD5686_SPI=y
CONFIG_AD5696_I2C=y
CONFIG_AD5755=y
CONFIG_AD5758=y
CONFIG_AD5761=y
CONFIG_AD5764=y
CONFIG_AD5766=y
CONFIG_AD5770R=y
CONFIG_AD5791=y
CONFIG_AD7293=y
CONFIG_AD7303=y
# CONFIG_AD8801 is not set
# CONFIG_CIO_DAC is not set
CONFIG_DPOT_DAC=y
# CONFIG_DS4424 is not set
CONFIG_LPC18XX_DAC=y
CONFIG_LTC1660=y
CONFIG_LTC2632=y
# CONFIG_M62332 is not set
CONFIG_MAX517=y
# CONFIG_MAX5821 is not set
CONFIG_MCP4725=y
# CONFIG_MCP4922 is not set
# CONFIG_STM32_DAC is not set
CONFIG_TI_DAC082S085=y
CONFIG_TI_DAC5571=y
# CONFIG_TI_DAC7311 is not set
# CONFIG_TI_DAC7612 is not set
CONFIG_VF610_DAC=y
# end of Digital to analog converters

#
# IIO dummy driver
#
# CONFIG_IIO_SIMPLE_DUMMY is not set
# end of IIO dummy driver

#
# Filters
#
CONFIG_ADMV8818=y
# end of Filters

#
# Frequency Synthesizers DDS/PLL
#

#
# Clock Generator/Distribution
#
CONFIG_AD9523=y
# end of Clock Generator/Distribution

#
# Phase-Locked Loop (PLL) frequency synthesizers
#
CONFIG_ADF4350=y
# CONFIG_ADF4371 is not set
CONFIG_ADMV1013=y
CONFIG_ADMV1014=y
CONFIG_ADMV4420=y
CONFIG_ADRF6780=y
# end of Phase-Locked Loop (PLL) frequency synthesizers
# end of Frequency Synthesizers DDS/PLL

#
# Digital gyroscope sensors
#
CONFIG_ADIS16080=y
CONFIG_ADIS16130=y
# CONFIG_ADIS16136 is not set
CONFIG_ADIS16260=y
CONFIG_ADXRS290=y
CONFIG_ADXRS450=y
# CONFIG_BMG160 is not set
CONFIG_FXAS21002C=y
CONFIG_FXAS21002C_I2C=y
CONFIG_FXAS21002C_SPI=y
# CONFIG_MPU3050_I2C is not set
CONFIG_IIO_ST_GYRO_3AXIS=y
# CONFIG_IIO_ST_GYRO_I2C_3AXIS is not set
CONFIG_IIO_ST_GYRO_SPI_3AXIS=y
CONFIG_ITG3200=y
# end of Digital gyroscope sensors

#
# Health Sensors
#

#
# Heart Rate Monitors
#
# CONFIG_AFE4403 is not set
CONFIG_AFE4404=y
CONFIG_MAX30100=y
CONFIG_MAX30102=y
# end of Heart Rate Monitors
# end of Health Sensors

#
# Humidity sensors
#
# CONFIG_AM2315 is not set
CONFIG_DHT11=y
CONFIG_HDC100X=y
# CONFIG_HDC2010 is not set
# CONFIG_HTS221 is not set
CONFIG_HTU21=y
CONFIG_SI7005=y
CONFIG_SI7020=y
# end of Humidity sensors

#
# Inertial measurement units
#
CONFIG_ADIS16400=y
CONFIG_ADIS16460=y
# CONFIG_ADIS16475 is not set
CONFIG_ADIS16480=y
CONFIG_BMI160=y
CONFIG_BMI160_I2C=y
CONFIG_BMI160_SPI=y
CONFIG_FXOS8700=y
CONFIG_FXOS8700_I2C=y
# CONFIG_FXOS8700_SPI is not set
CONFIG_KMX61=y
CONFIG_INV_ICM42600=y
CONFIG_INV_ICM42600_I2C=y
CONFIG_INV_ICM42600_SPI=y
CONFIG_INV_MPU6050_IIO=y
CONFIG_INV_MPU6050_I2C=y
CONFIG_INV_MPU6050_SPI=y
CONFIG_IIO_ST_LSM6DSX=y
CONFIG_IIO_ST_LSM6DSX_I2C=y
CONFIG_IIO_ST_LSM6DSX_SPI=y
CONFIG_IIO_ST_LSM6DSX_I3C=y
CONFIG_IIO_ST_LSM9DS0=y
CONFIG_IIO_ST_LSM9DS0_I2C=y
# CONFIG_IIO_ST_LSM9DS0_SPI is not set
# end of Inertial measurement units

CONFIG_IIO_ADIS_LIB=y
CONFIG_IIO_ADIS_LIB_BUFFER=y

#
# Light sensors
#
CONFIG_ADJD_S311=y
CONFIG_ADUX1020=y
# CONFIG_AL3010 is not set
CONFIG_AL3320A=y
# CONFIG_APDS9300 is not set
# CONFIG_APDS9960 is not set
CONFIG_AS73211=y
# CONFIG_BH1750 is not set
CONFIG_BH1780=y
# CONFIG_CM32181 is not set
# CONFIG_CM3232 is not set
# CONFIG_CM3323 is not set
CONFIG_CM3605=y
# CONFIG_CM36651 is not set
CONFIG_GP2AP002=y
CONFIG_GP2AP020A00F=y
# CONFIG_IQS621_ALS is not set
CONFIG_SENSORS_ISL29018=y
CONFIG_SENSORS_ISL29028=y
# CONFIG_ISL29125 is not set
CONFIG_JSA1212=y
# CONFIG_RPR0521 is not set
# CONFIG_SENSORS_LM3533 is not set
CONFIG_LTR501=y
CONFIG_LV0104CS=y
CONFIG_MAX44000=y
# CONFIG_MAX44009 is not set
CONFIG_NOA1305=y
CONFIG_OPT3001=y
CONFIG_PA12203001=y
# CONFIG_SI1133 is not set
CONFIG_SI1145=y
# CONFIG_STK3310 is not set
CONFIG_ST_UVIS25=y
CONFIG_ST_UVIS25_I2C=y
CONFIG_ST_UVIS25_SPI=y
CONFIG_TCS3414=y
CONFIG_TCS3472=y
# CONFIG_SENSORS_TSL2563 is not set
CONFIG_TSL2583=y
CONFIG_TSL2591=y
# CONFIG_TSL2772 is not set
CONFIG_TSL4531=y
# CONFIG_US5182D is not set
# CONFIG_VCNL4000 is not set
CONFIG_VCNL4035=y
# CONFIG_VEML6030 is not set
CONFIG_VEML6070=y
# CONFIG_VL6180 is not set
CONFIG_ZOPT2201=y
# end of Light sensors

#
# Magnetometer sensors
#
CONFIG_AK8974=y
CONFIG_AK8975=y
CONFIG_AK09911=y
CONFIG_BMC150_MAGN=y
# CONFIG_BMC150_MAGN_I2C is not set
CONFIG_BMC150_MAGN_SPI=y
# CONFIG_MAG3110 is not set
CONFIG_MMC35240=y
CONFIG_IIO_ST_MAGN_3AXIS=y
CONFIG_IIO_ST_MAGN_I2C_3AXIS=y
# CONFIG_IIO_ST_MAGN_SPI_3AXIS is not set
CONFIG_SENSORS_HMC5843=y
CONFIG_SENSORS_HMC5843_I2C=y
# CONFIG_SENSORS_HMC5843_SPI is not set
CONFIG_SENSORS_RM3100=y
CONFIG_SENSORS_RM3100_I2C=y
# CONFIG_SENSORS_RM3100_SPI is not set
CONFIG_YAMAHA_YAS530=y
# end of Magnetometer sensors

#
# Multiplexers
#
# CONFIG_IIO_MUX is not set
# end of Multiplexers

#
# Inclinometer sensors
#
# end of Inclinometer sensors

CONFIG_IIO_FORMAT_KUNIT_TEST=y

#
# Triggers - standalone
#
CONFIG_IIO_INTERRUPT_TRIGGER=y
# CONFIG_IIO_STM32_LPTIMER_TRIGGER is not set
CONFIG_IIO_STM32_TIMER_TRIGGER=y
# CONFIG_IIO_SYSFS_TRIGGER is not set
# end of Triggers - standalone

#
# Linear and angular position sensors
#
CONFIG_IQS624_POS=y
# end of Linear and angular position sensors

#
# Digital potentiometers
#
CONFIG_AD5110=y
# CONFIG_AD5272 is not set
CONFIG_DS1803=y
CONFIG_MAX5432=y
CONFIG_MAX5481=y
CONFIG_MAX5487=y
CONFIG_MCP4018=y
# CONFIG_MCP4131 is not set
CONFIG_MCP4531=y
# CONFIG_MCP41010 is not set
# CONFIG_TPL0102 is not set
# end of Digital potentiometers

#
# Digital potentiostats
#
CONFIG_LMP91000=y
# end of Digital potentiostats

#
# Pressure sensors
#
CONFIG_ABP060MG=y
CONFIG_BMP280=y
CONFIG_BMP280_I2C=y
CONFIG_BMP280_SPI=y
CONFIG_DLHL60D=y
# CONFIG_DPS310 is not set
# CONFIG_HP03 is not set
CONFIG_ICP10100=y
CONFIG_MPL115=y
CONFIG_MPL115_I2C=y
# CONFIG_MPL115_SPI is not set
# CONFIG_MPL3115 is not set
CONFIG_MS5611=y
CONFIG_MS5611_I2C=y
CONFIG_MS5611_SPI=y
# CONFIG_MS5637 is not set
# CONFIG_IIO_ST_PRESS is not set
CONFIG_T5403=y
CONFIG_HP206C=y
CONFIG_ZPA2326=y
CONFIG_ZPA2326_I2C=y
CONFIG_ZPA2326_SPI=y
# end of Pressure sensors

#
# Lightning sensors
#
CONFIG_AS3935=y
# end of Lightning sensors

#
# Proximity and distance sensors
#
CONFIG_ISL29501=y
# CONFIG_LIDAR_LITE_V2 is not set
CONFIG_MB1232=y
CONFIG_PING=y
CONFIG_RFD77402=y
CONFIG_SRF04=y
CONFIG_SX_COMMON=y
CONFIG_SX9310=y
CONFIG_SX9324=y
CONFIG_SX9360=y
CONFIG_SX9500=y
# CONFIG_SRF08 is not set
CONFIG_VCNL3020=y
CONFIG_VL53L0X_I2C=y
# end of Proximity and distance sensors

#
# Resolver to digital converters
#
CONFIG_AD2S90=y
CONFIG_AD2S1200=y
# end of Resolver to digital converters

#
# Temperature sensors
#
CONFIG_IQS620AT_TEMP=y
CONFIG_LTC2983=y
# CONFIG_MAXIM_THERMOCOUPLE is not set
CONFIG_MLX90614=y
CONFIG_MLX90632=y
CONFIG_TMP006=y
CONFIG_TMP007=y
# CONFIG_TMP117 is not set
# CONFIG_TSYS01 is not set
CONFIG_TSYS02D=y
CONFIG_MAX31856=y
CONFIG_MAX31865=y
# end of Temperature sensors

CONFIG_NTB=y
# CONFIG_NTB_MSI is not set
CONFIG_NTB_AMD=y
# CONFIG_NTB_IDT is not set
CONFIG_NTB_INTEL=y
CONFIG_NTB_SWITCHTEC=y
CONFIG_NTB_PINGPONG=y
CONFIG_NTB_TOOL=y
# CONFIG_NTB_PERF is not set
CONFIG_NTB_TRANSPORT=y
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
CONFIG_PWM_DEBUG=y
CONFIG_PWM_BCM_IPROC=y
# CONFIG_PWM_BCM_KONA is not set
CONFIG_PWM_BCM2835=y
CONFIG_PWM_BERLIN=y
CONFIG_PWM_BRCMSTB=y
# CONFIG_PWM_CLK is not set
CONFIG_PWM_CLPS711X=y
# CONFIG_PWM_DWC is not set
CONFIG_PWM_EP93XX=y
CONFIG_PWM_HIBVT=y
CONFIG_PWM_IMG=y
CONFIG_PWM_IMX1=y
CONFIG_PWM_IMX27=y
CONFIG_PWM_IMX_TPM=y
CONFIG_PWM_INTEL_LGM=y
CONFIG_PWM_IQS620A=y
# CONFIG_PWM_JZ4740 is not set
# CONFIG_PWM_KEEMBAY is not set
# CONFIG_PWM_LP3943 is not set
CONFIG_PWM_LPC18XX_SCT=y
CONFIG_PWM_LPC32XX=y
# CONFIG_PWM_LPSS_PCI is not set
# CONFIG_PWM_LPSS_PLATFORM is not set
CONFIG_PWM_MESON=y
CONFIG_PWM_MTK_DISP=y
# CONFIG_PWM_MEDIATEK is not set
CONFIG_PWM_PCA9685=y
CONFIG_PWM_PXA=y
CONFIG_PWM_RASPBERRYPI_POE=y
CONFIG_PWM_RCAR=y
CONFIG_PWM_RENESAS_TPU=y
# CONFIG_PWM_ROCKCHIP is not set
CONFIG_PWM_SAMSUNG=y
# CONFIG_PWM_SL28CPLD is not set
# CONFIG_PWM_SPRD is not set
CONFIG_PWM_STM32=y
CONFIG_PWM_STM32_LP=y
CONFIG_PWM_SUN4I=y
CONFIG_PWM_TEGRA=y
CONFIG_PWM_TIECAP=y
CONFIG_PWM_TIEHRPWM=y
CONFIG_PWM_VISCONTI=y
# CONFIG_PWM_VT8500 is not set

#
# IRQ chip support
#
CONFIG_AL_FIC=y
CONFIG_RENESAS_INTC_IRQPIN=y
CONFIG_RENESAS_IRQC=y
CONFIG_RENESAS_RZA1_IRQC=y
# CONFIG_RENESAS_RZG2L_IRQC is not set
# CONFIG_SL28CPLD_INTC is not set
# CONFIG_TS4800_IRQ is not set
# CONFIG_INGENIC_TCU_IRQ is not set
# CONFIG_IRQ_UNIPHIER_AIDET is not set
# CONFIG_MESON_IRQ_GPIO is not set
CONFIG_IMX_IRQSTEER=y
# CONFIG_IMX_INTMUX is not set
# CONFIG_EXYNOS_IRQ_COMBINER is not set
# CONFIG_MST_IRQ is not set
CONFIG_MCHP_EIC=y
# CONFIG_SUNPLUS_SP7021_INTC is not set
# end of IRQ chip support

CONFIG_IPACK_BUS=y
CONFIG_BOARD_TPCI200=y
CONFIG_RESET_CONTROLLER=y
# CONFIG_RESET_A10SR is not set
CONFIG_RESET_ATH79=y
# CONFIG_RESET_AXS10X is not set
CONFIG_RESET_BCM6345=y
CONFIG_RESET_BERLIN=y
# CONFIG_RESET_BRCMSTB is not set
# CONFIG_RESET_BRCMSTB_RESCAL is not set
CONFIG_RESET_HSDK=y
CONFIG_RESET_IMX7=y
# CONFIG_RESET_LANTIQ is not set
CONFIG_RESET_LPC18XX=y
# CONFIG_RESET_MCHP_SPARX5 is not set
CONFIG_RESET_MESON=y
CONFIG_RESET_MESON_AUDIO_ARB=y
CONFIG_RESET_NPCM=y
# CONFIG_RESET_PISTACHIO is not set
# CONFIG_RESET_QCOM_AOSS is not set
CONFIG_RESET_QCOM_PDC=y
CONFIG_RESET_RASPBERRYPI=y
# CONFIG_RESET_RZG2L_USBPHY_CTRL is not set
# CONFIG_RESET_SCMI is not set
CONFIG_RESET_SIMPLE=y
# CONFIG_RESET_SOCFPGA is not set
# CONFIG_RESET_STARFIVE_JH7100 is not set
# CONFIG_RESET_SUNPLUS is not set
# CONFIG_RESET_SUNXI is not set
CONFIG_RESET_TI_SCI=y
CONFIG_RESET_TI_SYSCON=y
# CONFIG_RESET_TI_TPS380X is not set
CONFIG_RESET_TN48M_CPLD=y
CONFIG_RESET_ZYNQ=y
CONFIG_COMMON_RESET_HI3660=y
CONFIG_COMMON_RESET_HI6220=y

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
# CONFIG_PHY_PISTACHIO_USB is not set
# CONFIG_USB_LGM_PHY is not set
CONFIG_PHY_CAN_TRANSCEIVER=y
# CONFIG_PHY_SUN4I_USB is not set
# CONFIG_PHY_SUN6I_MIPI_DPHY is not set
# CONFIG_PHY_SUN9I_USB is not set

#
# PHY drivers for Broadcom platforms
#
# CONFIG_PHY_BCM63XX_USBH is not set
# CONFIG_BCM_KONA_USB2_PHY is not set
CONFIG_PHY_NS2_PCIE=y
# end of PHY drivers for Broadcom platforms

CONFIG_PHY_HI6220_USB=y
CONFIG_PHY_HI3660_USB=y
CONFIG_PHY_HI3670_USB=y
CONFIG_PHY_HI3670_PCIE=y
CONFIG_PHY_HISTB_COMBPHY=y
CONFIG_PHY_HISI_INNO_USB2=y
CONFIG_PHY_INGENIC_USB=y
# CONFIG_PHY_PXA_28NM_HSIC is not set
CONFIG_PHY_PXA_28NM_USB2=y
# CONFIG_PHY_PXA_USB is not set
CONFIG_PHY_MMP3_USB=y
# CONFIG_PHY_MMP3_HSIC is not set
CONFIG_PHY_CPCAP_USB=y
CONFIG_PHY_MT7621_PCI=y
CONFIG_PHY_RALINK_USB=y
CONFIG_PHY_RCAR_GEN3_USB3=y
# CONFIG_PHY_ROCKCHIP_DPHY_RX0 is not set
CONFIG_PHY_ROCKCHIP_PCIE=y
CONFIG_PHY_EXYNOS_MIPI_VIDEO=y
CONFIG_PHY_SAMSUNG_USB2=y
CONFIG_PHY_S5PV210_USB2=y
CONFIG_PHY_ST_SPEAR1310_MIPHY=y
CONFIG_PHY_ST_SPEAR1340_MIPHY=y
CONFIG_PHY_STIH407_USB=y
CONFIG_PHY_STM32_USBPHYC=y
CONFIG_PHY_TEGRA194_P2U=y
CONFIG_PHY_DA8XX_USB=y
# CONFIG_PHY_DM816X_USB is not set
CONFIG_PHY_AM654_SERDES=y
CONFIG_OMAP_CONTROL_PHY=y
CONFIG_TI_PIPE3=y
CONFIG_PHY_INTEL_KEEMBAY_EMMC=y
CONFIG_PHY_INTEL_KEEMBAY_USB=y
# CONFIG_PHY_INTEL_LGM_EMMC is not set
# CONFIG_PHY_XILINX_ZYNQMP is not set
# end of PHY Subsystem

# CONFIG_POWERCAP is not set
CONFIG_MCB=y
CONFIG_MCB_PCI=y
CONFIG_MCB_LPC=y

#
# Performance monitor support
#
# CONFIG_ARM_CCN is not set
# CONFIG_ARM_CMN is not set
CONFIG_ARM_SMMU_V3_PMU=y
# CONFIG_FSL_IMX8_DDR_PMU is not set
# CONFIG_XGENE_PMU is not set
CONFIG_ARM_DMC620_PMU=y
# CONFIG_MARVELL_CN10K_TAD_PMU is not set
# CONFIG_HNS3_PMU is not set
CONFIG_MARVELL_CN10K_DDR_PMU=y
# end of Performance monitor support

CONFIG_RAS=y
CONFIG_USB4=y
CONFIG_USB4_DEBUGFS_WRITE=y
CONFIG_USB4_KUNIT_TEST=y
# CONFIG_USB4_DMA_TEST is not set

#
# Android
#
# CONFIG_ANDROID_BINDER_IPC is not set
# end of Android

CONFIG_DAX=y
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y
CONFIG_NVMEM_IMX_IIM=y
# CONFIG_NVMEM_IMX_OCOTP is not set
# CONFIG_NVMEM_LPC18XX_EEPROM is not set
CONFIG_NVMEM_LPC18XX_OTP=y
CONFIG_NVMEM_MXS_OCOTP=y
CONFIG_MTK_EFUSE=y
# CONFIG_MICROCHIP_OTPC is not set
CONFIG_NVMEM_NINTENDO_OTP=y
# CONFIG_QCOM_QFPROM is not set
CONFIG_NVMEM_SPMI_SDAM=y
# CONFIG_ROCKCHIP_EFUSE is not set
CONFIG_ROCKCHIP_OTP=y
CONFIG_NVMEM_BCM_OCOTP=y
CONFIG_NVMEM_STM32_ROMEM=y
CONFIG_UNIPHIER_EFUSE=y
CONFIG_NVMEM_VF610_OCOTP=y
CONFIG_MESON_MX_EFUSE=y
# CONFIG_NVMEM_SNVS_LPGPR is not set
CONFIG_RAVE_SP_EEPROM=y
# CONFIG_SC27XX_EFUSE is not set
CONFIG_SPRD_EFUSE=y
CONFIG_NVMEM_RMEM=y
# CONFIG_NVMEM_BRCM_NVRAM is not set
# CONFIG_NVMEM_LAYERSCAPE_SFP is not set
# CONFIG_NVMEM_SUNPLUS_OCOTP is not set
# CONFIG_NVMEM_APPLE_EFUSES is not set

#
# HW tracing support
#
CONFIG_STM=y
CONFIG_STM_PROTO_BASIC=y
CONFIG_STM_PROTO_SYS_T=y
CONFIG_STM_DUMMY=y
# CONFIG_STM_SOURCE_CONSOLE is not set
CONFIG_STM_SOURCE_HEARTBEAT=y
CONFIG_STM_SOURCE_FTRACE=y
CONFIG_INTEL_TH=y
CONFIG_INTEL_TH_PCI=y
CONFIG_INTEL_TH_GTH=y
CONFIG_INTEL_TH_STH=y
# CONFIG_INTEL_TH_MSU is not set
CONFIG_INTEL_TH_PTI=y
# CONFIG_INTEL_TH_DEBUG is not set
# end of HW tracing support

CONFIG_FPGA=y
CONFIG_FPGA_MGR_SOCFPGA=y
CONFIG_FPGA_MGR_SOCFPGA_A10=y
CONFIG_ALTERA_PR_IP_CORE=y
CONFIG_FPGA_MGR_ALTERA_PS_SPI=y
CONFIG_FPGA_MGR_ALTERA_CVP=y
CONFIG_FPGA_MGR_ZYNQ_FPGA=y
# CONFIG_FPGA_MGR_XILINX_SPI is not set
# CONFIG_FPGA_MGR_MACHXO2_SPI is not set
CONFIG_FPGA_BRIDGE=y
CONFIG_ALTERA_FREEZE_BRIDGE=y
# CONFIG_XILINX_PR_DECOUPLER is not set
CONFIG_FPGA_REGION=y
CONFIG_FPGA_DFL=y
CONFIG_FPGA_DFL_FME=y
# CONFIG_FPGA_DFL_FME_MGR is not set
CONFIG_FPGA_DFL_FME_BRIDGE=y
CONFIG_FPGA_DFL_FME_REGION=y
CONFIG_FPGA_DFL_AFU=y
CONFIG_FPGA_DFL_NIOS_INTEL_PAC_N3000=y
# CONFIG_FPGA_DFL_PCI is not set
CONFIG_FPGA_MGR_ZYNQMP_FPGA=y
CONFIG_FPGA_MGR_VERSAL_FPGA=y
# CONFIG_FPGA_M10_BMC_SEC_UPDATE is not set
# CONFIG_FPGA_MGR_MICROCHIP_SPI is not set
CONFIG_TEE=y
CONFIG_MULTIPLEXER=y

#
# Multiplexer drivers
#
# CONFIG_MUX_ADG792A is not set
CONFIG_MUX_ADGS1408=y
CONFIG_MUX_GPIO=y
CONFIG_MUX_MMIO=y
# end of Multiplexer drivers

CONFIG_PM_OPP=y
CONFIG_SIOX=y
CONFIG_SIOX_BUS_GPIO=y
# CONFIG_SLIMBUS is not set
# CONFIG_INTERCONNECT is not set
CONFIG_COUNTER=y
# CONFIG_104_QUAD_8 is not set
CONFIG_INTERRUPT_CNT=y
CONFIG_STM32_TIMER_CNT=y
CONFIG_STM32_LPTIMER_CNT=y
CONFIG_TI_EQEP=y
CONFIG_INTEL_QEP=y
# CONFIG_MOST is not set
CONFIG_PECI=y
CONFIG_PECI_CPU=y
CONFIG_HTE=y
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
CONFIG_VALIDATE_FS_PARSER=y
CONFIG_FS_IOMAP=y
# CONFIG_EXT2_FS is not set
CONFIG_EXT3_FS=y
# CONFIG_EXT3_FS_POSIX_ACL is not set
CONFIG_EXT3_FS_SECURITY=y
CONFIG_EXT4_FS=y
CONFIG_EXT4_USE_FOR_EXT2=y
# CONFIG_EXT4_FS_POSIX_ACL is not set
CONFIG_EXT4_FS_SECURITY=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_EXT4_KUNIT_TESTS=y
CONFIG_JBD2=y
CONFIG_JBD2_DEBUG=y
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=y
# CONFIG_REISERFS_CHECK is not set
CONFIG_REISERFS_FS_XATTR=y
CONFIG_REISERFS_FS_POSIX_ACL=y
CONFIG_REISERFS_FS_SECURITY=y
CONFIG_JFS_FS=y
# CONFIG_JFS_POSIX_ACL is not set
CONFIG_JFS_SECURITY=y
# CONFIG_JFS_DEBUG is not set
CONFIG_JFS_STATISTICS=y
CONFIG_XFS_FS=y
# CONFIG_XFS_SUPPORT_V4 is not set
# CONFIG_XFS_QUOTA is not set
CONFIG_XFS_POSIX_ACL=y
CONFIG_XFS_RT=y
# CONFIG_XFS_ONLINE_SCRUB is not set
CONFIG_XFS_DEBUG=y
# CONFIG_XFS_ASSERT_FATAL is not set
# CONFIG_GFS2_FS is not set
# CONFIG_OCFS2_FS is not set
CONFIG_BTRFS_FS=y
# CONFIG_BTRFS_FS_POSIX_ACL is not set
CONFIG_BTRFS_FS_CHECK_INTEGRITY=y
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
# CONFIG_BTRFS_ASSERT is not set
# CONFIG_BTRFS_FS_REF_VERIFY is not set
CONFIG_NILFS2_FS=y
CONFIG_F2FS_FS=y
CONFIG_F2FS_STAT_FS=y
CONFIG_F2FS_FS_XATTR=y
# CONFIG_F2FS_FS_POSIX_ACL is not set
# CONFIG_F2FS_FS_SECURITY is not set
CONFIG_F2FS_CHECK_FS=y
# CONFIG_F2FS_FAULT_INJECTION is not set
CONFIG_F2FS_FS_COMPRESSION=y
CONFIG_F2FS_FS_LZO=y
CONFIG_F2FS_FS_LZORLE=y
# CONFIG_F2FS_FS_LZ4 is not set
CONFIG_F2FS_FS_ZSTD=y
CONFIG_F2FS_IOSTAT=y
# CONFIG_F2FS_UNFAIR_RWSEM is not set
CONFIG_ZONEFS_FS=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
# CONFIG_EXPORTFS_BLOCK_OPS is not set
# CONFIG_FILE_LOCKING is not set
CONFIG_FS_ENCRYPTION=y
CONFIG_FS_ENCRYPTION_ALGS=y
CONFIG_FS_VERITY=y
# CONFIG_FS_VERITY_DEBUG is not set
CONFIG_FS_VERITY_BUILTIN_SIGNATURES=y
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
# CONFIG_INOTIFY_USER is not set
CONFIG_FANOTIFY=y
# CONFIG_FANOTIFY_ACCESS_PERMISSIONS is not set
# CONFIG_QUOTA is not set
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=y
# CONFIG_CUSE is not set
# CONFIG_VIRTIO_FS is not set
# CONFIG_OVERLAY_FS is not set

#
# Caches
#
CONFIG_NETFS_SUPPORT=y
CONFIG_FSCACHE=y
# CONFIG_FSCACHE_DEBUG is not set
CONFIG_CACHEFILES=y
CONFIG_CACHEFILES_DEBUG=y
# CONFIG_CACHEFILES_ONDEMAND is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
# CONFIG_ISO9660_FS is not set
CONFIG_UDF_FS=y
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/EXFAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
CONFIG_FAT_DEFAULT_UTF8=y
CONFIG_FAT_KUNIT_TEST=y
CONFIG_EXFAT_FS=y
CONFIG_EXFAT_DEFAULT_IOCHARSET="utf8"
CONFIG_NTFS_FS=y
# CONFIG_NTFS_DEBUG is not set
CONFIG_NTFS_RW=y
CONFIG_NTFS3_FS=y
CONFIG_NTFS3_64BIT_CLUSTER=y
# CONFIG_NTFS3_LZX_XPRESS is not set
# CONFIG_NTFS3_FS_POSIX_ACL is not set
# end of DOS/FAT/EXFAT/NT Filesystems

#
# Pseudo filesystems
#
# CONFIG_PROC_FS is not set
# CONFIG_PROC_CHILDREN is not set
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_TMPFS_POSIX_ACL is not set
CONFIG_TMPFS_XATTR=y
# CONFIG_TMPFS_INODE64 is not set
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP=y
CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP=y
# CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON is not set
CONFIG_MEMFD_CREATE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
# end of Pseudo filesystems

# CONFIG_MISC_FILESYSTEMS is not set
# CONFIG_NETWORK_FILESYSTEMS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
# CONFIG_NLS_CODEPAGE_437 is not set
# CONFIG_NLS_CODEPAGE_737 is not set
CONFIG_NLS_CODEPAGE_775=y
CONFIG_NLS_CODEPAGE_850=y
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
CONFIG_NLS_CODEPAGE_857=y
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
CONFIG_NLS_CODEPAGE_864=y
# CONFIG_NLS_CODEPAGE_865 is not set
CONFIG_NLS_CODEPAGE_866=y
# CONFIG_NLS_CODEPAGE_869 is not set
CONFIG_NLS_CODEPAGE_936=y
CONFIG_NLS_CODEPAGE_950=y
CONFIG_NLS_CODEPAGE_932=y
CONFIG_NLS_CODEPAGE_949=y
CONFIG_NLS_CODEPAGE_874=y
CONFIG_NLS_ISO8859_8=y
CONFIG_NLS_CODEPAGE_1250=y
CONFIG_NLS_CODEPAGE_1251=y
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_ISO8859_2=y
CONFIG_NLS_ISO8859_3=y
# CONFIG_NLS_ISO8859_4 is not set
CONFIG_NLS_ISO8859_5=y
CONFIG_NLS_ISO8859_6=y
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
CONFIG_NLS_ISO8859_13=y
# CONFIG_NLS_ISO8859_14 is not set
CONFIG_NLS_ISO8859_15=y
CONFIG_NLS_KOI8_R=y
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_MAC_ROMAN is not set
CONFIG_NLS_MAC_CELTIC=y
CONFIG_NLS_MAC_CENTEURO=y
# CONFIG_NLS_MAC_CROATIAN is not set
CONFIG_NLS_MAC_CYRILLIC=y
# CONFIG_NLS_MAC_GAELIC is not set
CONFIG_NLS_MAC_GREEK=y
CONFIG_NLS_MAC_ICELAND=y
# CONFIG_NLS_MAC_INUIT is not set
# CONFIG_NLS_MAC_ROMANIAN is not set
CONFIG_NLS_MAC_TURKISH=y
CONFIG_NLS_UTF8=y
CONFIG_DLM=y
# CONFIG_DLM_DEPRECATED_API is not set
CONFIG_DLM_DEBUG=y
# CONFIG_UNICODE is not set
CONFIG_IO_WQ=y
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
CONFIG_KEYS_REQUEST_CACHE=y
CONFIG_PERSISTENT_KEYRINGS=y
CONFIG_BIG_KEYS=y
CONFIG_TRUSTED_KEYS=y
CONFIG_TRUSTED_KEYS_TEE=y
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_USER_DECRYPTED_DATA is not set
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_KEY_NOTIFICATIONS is not set
CONFIG_SECURITY_DMESG_RESTRICT=y
CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
CONFIG_SECURITY_NETWORK_XFRM=y
CONFIG_SECURITY_PATH=y
CONFIG_FORTIFY_SOURCE=y
CONFIG_STATIC_USERMODEHELPER=y
CONFIG_STATIC_USERMODEHELPER_PATH="/sbin/usermode-helper"
# CONFIG_SECURITY_SELINUX is not set
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
# CONFIG_SECURITY_APPARMOR is not set
CONFIG_SECURITY_LOADPIN=y
CONFIG_SECURITY_LOADPIN_ENFORCE=y
CONFIG_SECURITY_YAMA=y
# CONFIG_SECURITY_SAFESETID is not set
# CONFIG_SECURITY_LOCKDOWN_LSM is not set
# CONFIG_SECURITY_LANDLOCK is not set
# CONFIG_INTEGRITY is not set
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_LSM="landlock,lockdown,yama,loadpin,safesetid,integrity,bpf"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_CC_HAS_AUTO_VAR_INIT_PATTERN=y
CONFIG_CC_HAS_AUTO_VAR_INIT_ZERO=y
# CONFIG_INIT_STACK_NONE is not set
# CONFIG_INIT_STACK_ALL_PATTERN is not set
CONFIG_INIT_STACK_ALL_ZERO=y
CONFIG_INIT_ON_ALLOC_DEFAULT_ON=y
CONFIG_INIT_ON_FREE_DEFAULT_ON=y
# end of Memory initialization

CONFIG_RANDSTRUCT_NONE=y
# end of Kernel hardening options
# end of Security options

CONFIG_XOR_BLOCKS=y
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
# CONFIG_CRYPTO_FIPS is not set
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
CONFIG_CRYPTO_USER=y
# CONFIG_CRYPTO_MANAGER_DISABLE_TESTS is not set
# CONFIG_CRYPTO_MANAGER_EXTRA_TESTS is not set
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=y
CONFIG_CRYPTO_TEST=y
CONFIG_CRYPTO_SIMD=y
CONFIG_CRYPTO_ENGINE=y

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=y
CONFIG_CRYPTO_DH_RFC7919_GROUPS=y
CONFIG_CRYPTO_ECC=y
CONFIG_CRYPTO_ECDH=y
CONFIG_CRYPTO_ECDSA=y
CONFIG_CRYPTO_ECRDSA=y
CONFIG_CRYPTO_SM2=y
CONFIG_CRYPTO_CURVE25519=y
# CONFIG_CRYPTO_CURVE25519_X86 is not set

#
# Authenticated Encryption with Associated Data
#
# CONFIG_CRYPTO_CCM is not set
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_CHACHA20POLY1305=y
CONFIG_CRYPTO_AEGIS128=y
# CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=y

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CFB=y
CONFIG_CRYPTO_CTR=y
# CONFIG_CRYPTO_CTS is not set
CONFIG_CRYPTO_ECB=y
# CONFIG_CRYPTO_LRW is not set
CONFIG_CRYPTO_OFB=y
CONFIG_CRYPTO_PCBC=y
CONFIG_CRYPTO_XTS=y
CONFIG_CRYPTO_KEYWRAP=y
CONFIG_CRYPTO_NHPOLY1305=y
CONFIG_CRYPTO_NHPOLY1305_SSE2=y
CONFIG_CRYPTO_NHPOLY1305_AVX2=y
# CONFIG_CRYPTO_ADIANTUM is not set
# CONFIG_CRYPTO_HCTR2 is not set
# CONFIG_CRYPTO_ESSIV is not set

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=y
CONFIG_CRYPTO_HMAC=y
# CONFIG_CRYPTO_XCBC is not set
# CONFIG_CRYPTO_VMAC is not set

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=y
CONFIG_CRYPTO_CRC32=y
CONFIG_CRYPTO_CRC32_PCLMUL=y
CONFIG_CRYPTO_XXHASH=y
CONFIG_CRYPTO_BLAKE2B=y
CONFIG_CRYPTO_BLAKE2S_X86=y
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=y
CONFIG_CRYPTO_CRC64_ROCKSOFT=y
CONFIG_CRYPTO_GHASH=y
# CONFIG_CRYPTO_POLYVAL_CLMUL_NI is not set
CONFIG_CRYPTO_POLY1305=y
CONFIG_CRYPTO_POLY1305_X86_64=y
# CONFIG_CRYPTO_MD4 is not set
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=y
# CONFIG_CRYPTO_RMD160 is not set
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA1_SSSE3=y
# CONFIG_CRYPTO_SHA256_SSSE3 is not set
CONFIG_CRYPTO_SHA512_SSSE3=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=y
CONFIG_CRYPTO_SM3=y
CONFIG_CRYPTO_SM3_GENERIC=y
# CONFIG_CRYPTO_SM3_AVX_X86_64 is not set
CONFIG_CRYPTO_STREEBOG=y
CONFIG_CRYPTO_WP512=y
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=y

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_AES_NI_INTEL=y
CONFIG_CRYPTO_ANUBIS=y
# CONFIG_CRYPTO_ARC4 is not set
# CONFIG_CRYPTO_BLOWFISH is not set
# CONFIG_CRYPTO_BLOWFISH_X86_64 is not set
# CONFIG_CRYPTO_CAMELLIA is not set
CONFIG_CRYPTO_CAMELLIA_X86_64=y
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=y
# CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64 is not set
CONFIG_CRYPTO_CAST_COMMON=y
CONFIG_CRYPTO_CAST5=y
CONFIG_CRYPTO_CAST5_AVX_X86_64=y
CONFIG_CRYPTO_CAST6=y
# CONFIG_CRYPTO_CAST6_AVX_X86_64 is not set
CONFIG_CRYPTO_DES=y
CONFIG_CRYPTO_DES3_EDE_X86_64=y
CONFIG_CRYPTO_FCRYPT=y
# CONFIG_CRYPTO_KHAZAD is not set
CONFIG_CRYPTO_CHACHA20=y
CONFIG_CRYPTO_CHACHA20_X86_64=y
CONFIG_CRYPTO_SEED=y
# CONFIG_CRYPTO_ARIA is not set
CONFIG_CRYPTO_SERPENT=y
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=y
CONFIG_CRYPTO_SERPENT_AVX_X86_64=y
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=y
CONFIG_CRYPTO_SM4=y
# CONFIG_CRYPTO_SM4_GENERIC is not set
CONFIG_CRYPTO_SM4_AESNI_AVX_X86_64=y
CONFIG_CRYPTO_SM4_AESNI_AVX2_X86_64=y
CONFIG_CRYPTO_TEA=y
CONFIG_CRYPTO_TWOFISH=y
CONFIG_CRYPTO_TWOFISH_COMMON=y
CONFIG_CRYPTO_TWOFISH_X86_64=y
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=y
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=y

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
# CONFIG_CRYPTO_LZO is not set
# CONFIG_CRYPTO_842 is not set
CONFIG_CRYPTO_LZ4=y
# CONFIG_CRYPTO_LZ4HC is not set
CONFIG_CRYPTO_ZSTD=y

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=y
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_USER_API=y
CONFIG_CRYPTO_USER_API_HASH=y
CONFIG_CRYPTO_USER_API_SKCIPHER=y
CONFIG_CRYPTO_USER_API_RNG=y
# CONFIG_CRYPTO_USER_API_RNG_CAVP is not set
CONFIG_CRYPTO_USER_API_AEAD=y
CONFIG_CRYPTO_USER_API_ENABLE_OBSOLETE=y
# CONFIG_CRYPTO_STATS is not set
CONFIG_CRYPTO_HASH_INFO=y
CONFIG_CRYPTO_HW=y
# CONFIG_CRYPTO_DEV_ALLWINNER is not set
CONFIG_CRYPTO_DEV_PADLOCK=y
# CONFIG_CRYPTO_DEV_PADLOCK_AES is not set
CONFIG_CRYPTO_DEV_PADLOCK_SHA=y
CONFIG_CRYPTO_DEV_SL3516=y
# CONFIG_CRYPTO_DEV_SL3516_DEBUG is not set
CONFIG_CRYPTO_DEV_EXYNOS_RNG=y
CONFIG_CRYPTO_DEV_S5P=y
# CONFIG_CRYPTO_DEV_ATMEL_AES is not set
CONFIG_CRYPTO_DEV_ATMEL_TDES=y
# CONFIG_CRYPTO_DEV_ATMEL_SHA is not set
CONFIG_CRYPTO_DEV_ATMEL_I2C=y
CONFIG_CRYPTO_DEV_ATMEL_ECC=y
CONFIG_CRYPTO_DEV_ATMEL_SHA204A=y
# CONFIG_CRYPTO_DEV_CCP is not set
CONFIG_CRYPTO_DEV_QAT=y
# CONFIG_CRYPTO_DEV_QAT_DH895xCC is not set
# CONFIG_CRYPTO_DEV_QAT_C3XXX is not set
CONFIG_CRYPTO_DEV_QAT_C62X=y
# CONFIG_CRYPTO_DEV_QAT_4XXX is not set
CONFIG_CRYPTO_DEV_QAT_DH895xCCVF=y
CONFIG_CRYPTO_DEV_QAT_C3XXXVF=y
CONFIG_CRYPTO_DEV_QAT_C62XVF=y
CONFIG_CRYPTO_DEV_CPT=y
CONFIG_CAVIUM_CPT=y
CONFIG_CRYPTO_DEV_NITROX=y
CONFIG_CRYPTO_DEV_NITROX_CNN55XX=y
CONFIG_CRYPTO_DEV_MARVELL=y
CONFIG_CRYPTO_DEV_OCTEONTX_CPT=y
# CONFIG_CRYPTO_DEV_OCTEONTX2_CPT is not set
CONFIG_CRYPTO_DEV_CAVIUM_ZIP=y
CONFIG_CRYPTO_DEV_QCE=y
CONFIG_CRYPTO_DEV_QCE_SKCIPHER=y
CONFIG_CRYPTO_DEV_QCE_SHA=y
CONFIG_CRYPTO_DEV_QCE_AEAD=y
CONFIG_CRYPTO_DEV_QCE_ENABLE_ALL=y
# CONFIG_CRYPTO_DEV_QCE_ENABLE_SKCIPHER is not set
# CONFIG_CRYPTO_DEV_QCE_ENABLE_SHA is not set
# CONFIG_CRYPTO_DEV_QCE_ENABLE_AEAD is not set
CONFIG_CRYPTO_DEV_QCE_SW_MAX_LEN=512
CONFIG_CRYPTO_DEV_QCOM_RNG=y
CONFIG_CRYPTO_DEV_IMGTEC_HASH=y
CONFIG_CRYPTO_DEV_ZYNQMP_AES=y
CONFIG_CRYPTO_DEV_ZYNQMP_SHA3=y
CONFIG_CRYPTO_DEV_CHELSIO=y
CONFIG_CRYPTO_DEV_VIRTIO=y
CONFIG_CRYPTO_DEV_SAFEXCEL=y
CONFIG_CRYPTO_DEV_HISI_SEC=y
CONFIG_CRYPTO_DEV_AMLOGIC_GXL=y
# CONFIG_CRYPTO_DEV_AMLOGIC_GXL_DEBUG is not set
CONFIG_CRYPTO_DEV_SA2UL=y
CONFIG_CRYPTO_DEV_KEEMBAY_OCS_AES_SM4=y
# CONFIG_CRYPTO_DEV_KEEMBAY_OCS_AES_SM4_ECB is not set
CONFIG_CRYPTO_DEV_KEEMBAY_OCS_AES_SM4_CTS=y
CONFIG_CRYPTO_DEV_KEEMBAY_OCS_ECC=y
CONFIG_CRYPTO_DEV_KEEMBAY_OCS_HCU=y
CONFIG_CRYPTO_DEV_KEEMBAY_OCS_HCU_HMAC_SHA224=y
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
# CONFIG_PKCS8_PRIVATE_KEY_PARSER is not set
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_PKCS7_TEST_KEY is not set
# CONFIG_SIGNED_PE_FILE_VERIFICATION is not set
CONFIG_FIPS_SIGNATURE_SELFTEST=y

#
# Certificates for signature checking
#
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
CONFIG_SECONDARY_TRUSTED_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
# CONFIG_SYSTEM_REVOCATION_LIST is not set
# CONFIG_SYSTEM_BLACKLIST_AUTH_UPDATE is not set
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=y
# CONFIG_RAID6_PQ_BENCHMARK is not set
CONFIG_LINEAR_RANGES=y
CONFIG_PACKING=y
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_CORDIC=y
CONFIG_PRIME_NUMBERS=y
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_STMP_DEVICE=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_ARCH_USE_SYM_ANNOTATIONS=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_ARC4=y
CONFIG_CRYPTO_ARCH_HAVE_LIB_BLAKE2S=y
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
CONFIG_CRYPTO_ARCH_HAVE_LIB_CHACHA=y
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=y
CONFIG_CRYPTO_LIB_CHACHA=y
CONFIG_CRYPTO_LIB_CURVE25519_GENERIC=y
# CONFIG_CRYPTO_LIB_CURVE25519 is not set
CONFIG_CRYPTO_LIB_DES=y
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=11
CONFIG_CRYPTO_ARCH_HAVE_LIB_POLY1305=y
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=y
CONFIG_CRYPTO_LIB_POLY1305=y
CONFIG_CRYPTO_LIB_CHACHA20POLY1305=y
CONFIG_CRYPTO_LIB_SHA1=y
CONFIG_CRYPTO_LIB_SHA256=y
# end of Crypto library routines

CONFIG_LIB_MEMNEQ=y
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC64_ROCKSOFT=y
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
CONFIG_CRC32_SELFTEST=y
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
CONFIG_CRC64=y
# CONFIG_CRC4 is not set
CONFIG_CRC7=y
CONFIG_LIBCRC32C=y
CONFIG_CRC8=y
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_COMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=y
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
# CONFIG_XZ_DEC_X86 is not set
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
# CONFIG_XZ_DEC_SPARC is not set
# CONFIG_XZ_DEC_MICROLZMA is not set
CONFIG_XZ_DEC_BCJ=y
CONFIG_XZ_DEC_TEST=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_BTREE=y
CONFIG_INTERVAL_TREE=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_ARCH_HAS_FORCE_DMA_UNENCRYPTED=y
CONFIG_SWIOTLB=y
CONFIG_DMA_COHERENT_POOL=y
CONFIG_DMA_CMA=y
CONFIG_DMA_PERNUMA_CMA=y

#
# Default contiguous memory area size:
#
CONFIG_CMA_SIZE_MBYTES=0
CONFIG_CMA_SIZE_PERCENTAGE=0
# CONFIG_CMA_SIZE_SEL_MBYTES is not set
# CONFIG_CMA_SIZE_SEL_PERCENTAGE is not set
# CONFIG_CMA_SIZE_SEL_MIN is not set
CONFIG_CMA_SIZE_SEL_MAX=y
CONFIG_CMA_ALIGNMENT=8
# CONFIG_DMA_API_DEBUG is not set
CONFIG_DMA_MAP_BENCHMARK=y
CONFIG_SGL_ALLOC=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_DIMLIB=y
CONFIG_OID_REGISTRY=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_FONT_SUPPORT=y
CONFIG_FONT_8x16=y
CONFIG_FONT_AUTOSELECT=y
CONFIG_SG_SPLIT=y
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_ARCH_HAS_COPY_MC=y
CONFIG_ARCH_STACKWALK=y
CONFIG_STACKDEPOT=y
CONFIG_SBITMAP=y
CONFIG_PARMAN=y
CONFIG_OBJAGG=y
# end of Library routines

CONFIG_POLYNOMIAL=y

#
# Kernel hacking
#

#
# printk and dmesg options
#
# CONFIG_PRINTK_TIME is not set
CONFIG_PRINTK_CALLER=y
# CONFIG_STACKTRACE_BUILD_ID is not set
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
# CONFIG_BOOT_PRINTK_DELAY is not set
# CONFIG_DYNAMIC_DEBUG is not set
CONFIG_DYNAMIC_DEBUG_CORE=y
CONFIG_SYMBOLIC_ERRNAME=y
CONFIG_DEBUG_BUGVERBOSE=y
# end of printk and dmesg options

CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_MISC=y

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
# CONFIG_DEBUG_INFO_NONE is not set
# CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is not set
# CONFIG_DEBUG_INFO_DWARF4 is not set
CONFIG_DEBUG_INFO_DWARF5=y
# CONFIG_DEBUG_INFO_REDUCED is not set
# CONFIG_DEBUG_INFO_SPLIT is not set
CONFIG_DEBUG_INFO_BTF=y
CONFIG_PAHOLE_HAS_SPLIT_BTF=y
CONFIG_PAHOLE_HAS_BTF_TAG=y
CONFIG_GDB_SCRIPTS=y
CONFIG_FRAME_WARN=2048
# CONFIG_STRIP_ASM_SYMS is not set
# CONFIG_HEADERS_INSTALL is not set
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_64B=y
CONFIG_OBJTOOL=y
# CONFIG_VMLINUX_MAP is not set
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
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
CONFIG_DEBUG_FS_DISALLOW_MOUNT=y
# CONFIG_DEBUG_FS_ALLOW_NONE is not set
CONFIG_HAVE_ARCH_KGDB=y
CONFIG_KGDB=y
# CONFIG_KGDB_TESTS is not set
# CONFIG_KGDB_LOW_LEVEL_TRAP is not set
# CONFIG_KGDB_KDB is not set
CONFIG_ARCH_HAS_EARLY_DEBUG=y
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_UBSAN is not set
CONFIG_HAVE_ARCH_KCSAN=y
CONFIG_HAVE_KCSAN_COMPILER=y
CONFIG_KCSAN=y
CONFIG_CC_HAS_TSAN_COMPOUND_READ_BEFORE_WRITE=y
CONFIG_KCSAN_VERBOSE=y
# CONFIG_KCSAN_SELFTEST is not set
CONFIG_KCSAN_KUNIT_TEST=y
# CONFIG_KCSAN_EARLY_ENABLE is not set
CONFIG_KCSAN_NUM_WATCHPOINTS=64
CONFIG_KCSAN_UDELAY_TASK=80
CONFIG_KCSAN_UDELAY_INTERRUPT=20
# CONFIG_KCSAN_DELAY_RANDOMIZE is not set
CONFIG_KCSAN_SKIP_WATCH=4000
# CONFIG_KCSAN_SKIP_WATCH_RANDOMIZE is not set
CONFIG_KCSAN_INTERRUPT_WATCHER=y
CONFIG_KCSAN_REPORT_ONCE_IN_MS=3000
# CONFIG_KCSAN_REPORT_RACE_UNKNOWN_ORIGIN is not set
CONFIG_KCSAN_STRICT=y
CONFIG_KCSAN_WEAK_MEMORY=y
# end of Generic Kernel Debugging Instruments

#
# Networking Debugging
#
# CONFIG_NET_DEV_REFCNT_TRACKER is not set
# CONFIG_NET_NS_REFCNT_TRACKER is not set
CONFIG_DEBUG_NET=y
# end of Networking Debugging

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
CONFIG_DEBUG_PAGEALLOC=y
CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT=y
# CONFIG_PAGE_OWNER is not set
# CONFIG_PAGE_TABLE_CHECK is not set
CONFIG_PAGE_POISONING=y
# CONFIG_DEBUG_PAGE_REF is not set
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_ARCH_HAS_DEBUG_WX=y
# CONFIG_DEBUG_WX is not set
CONFIG_GENERIC_PTDUMP=y
# CONFIG_PTDUMP_DEBUGFS is not set
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SHRINKER_DEBUG is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
CONFIG_DEBUG_STACK_USAGE=y
CONFIG_SCHED_STACK_END_CHECK=y
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
CONFIG_DEBUG_VM=y
CONFIG_DEBUG_VM_VMACACHE=y
CONFIG_DEBUG_VM_RB=y
CONFIG_DEBUG_VM_PGFLAGS=y
CONFIG_DEBUG_VM_PGTABLE=y
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
CONFIG_MEMORY_NOTIFIER_ERROR_INJECT=y
CONFIG_ARCH_SUPPORTS_KMAP_LOCAL_FORCE_MAP=y
# CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP is not set
CONFIG_HAVE_ARCH_KASAN=y
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
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
CONFIG_HARDLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=120
# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
CONFIG_WQ_WATCHDOG=y
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
# end of Scheduler Debugging

CONFIG_DEBUG_TIMEKEEPING=y
CONFIG_DEBUG_PREEMPT=y

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
CONFIG_PROVE_LOCKING=y
CONFIG_PROVE_RAW_LOCK_NESTING=y
CONFIG_LOCK_STAT=y
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
CONFIG_DEBUG_LOCKING_API_SELFTESTS=y
CONFIG_LOCK_TORTURE_TEST=y
CONFIG_WW_MUTEX_SELFTEST=y
CONFIG_SCF_TORTURE_TEST=y
CONFIG_CSD_LOCK_WAIT_DEBUG=y
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_TRACE_IRQFLAGS=y
CONFIG_TRACE_IRQFLAGS_NMI=y
CONFIG_DEBUG_IRQFLAGS=y
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
CONFIG_DEBUG_KOBJECT=y

#
# Debug kernel data structures
#
CONFIG_DEBUG_LIST=y
CONFIG_DEBUG_PLIST=y
CONFIG_DEBUG_SG=y
# CONFIG_DEBUG_NOTIFIERS is not set
CONFIG_BUG_ON_DATA_CORRUPTION=y
# end of Debug kernel data structures

CONFIG_DEBUG_CREDENTIALS=y

#
# RCU Debugging
#
CONFIG_PROVE_RCU=y
CONFIG_TORTURE_TEST=y
# CONFIG_RCU_SCALE_TEST is not set
CONFIG_RCU_TORTURE_TEST=y
CONFIG_RCU_REF_SCALE_TEST=y
CONFIG_RCU_CPU_STALL_TIMEOUT=21
CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=0
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

CONFIG_DEBUG_WQ_FORCE_RR_CPU=y
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_RETHOOK=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_OBJTOOL_MCOUNT=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_HAVE_BUILDTIME_MCOUNT_SORT=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_RING_BUFFER_ALLOW_SWAP=y
CONFIG_PREEMPTIRQ_TRACEPOINTS=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
CONFIG_BOOTTIME_TRACING=y
CONFIG_FUNCTION_TRACER=y
# CONFIG_DYNAMIC_FTRACE is not set
CONFIG_FUNCTION_PROFILER=y
CONFIG_STACK_TRACER=y
# CONFIG_IRQSOFF_TRACER is not set
# CONFIG_PREEMPT_TRACER is not set
CONFIG_SCHED_TRACER=y
CONFIG_HWLAT_TRACER=y
CONFIG_OSNOISE_TRACER=y
CONFIG_TIMERLAT_TRACER=y
CONFIG_MMIOTRACE=y
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP=y
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
CONFIG_BLK_DEV_IO_TRACE=y
CONFIG_UPROBE_EVENTS=y
CONFIG_BPF_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
CONFIG_TRACING_MAP=y
CONFIG_SYNTH_EVENTS=y
CONFIG_USER_EVENTS=y
CONFIG_HIST_TRIGGERS=y
CONFIG_TRACE_EVENT_INJECT=y
CONFIG_TRACEPOINT_BENCHMARK=y
CONFIG_RING_BUFFER_BENCHMARK=y
# CONFIG_TRACE_EVAL_MAP_FILE is not set
# CONFIG_FTRACE_RECORD_RECURSION is not set
# CONFIG_GCOV_PROFILE_FTRACE is not set
# CONFIG_FTRACE_STARTUP_TEST is not set
CONFIG_RING_BUFFER_STARTUP_TEST=y
# CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS is not set
# CONFIG_SYNTH_EVENT_GEN_TEST is not set
# CONFIG_HIST_TRIGGERS_DEBUG is not set
# CONFIG_RV is not set
# CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
# CONFIG_SAMPLES is not set
CONFIG_HAVE_SAMPLE_FTRACE_DIRECT=y
CONFIG_HAVE_SAMPLE_FTRACE_DIRECT_MULTI=y
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y

#
# x86 Debugging
#
CONFIG_X86_VERBOSE_BOOTUP=y
# CONFIG_EARLY_PRINTK is not set
CONFIG_DEBUG_TLBFLUSH=y
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
# CONFIG_IO_DELAY_0X80 is not set
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
CONFIG_IO_DELAY_NONE=y
# CONFIG_DEBUG_BOOT_PARAMS is not set
CONFIG_CPA_DEBUG=y
# CONFIG_DEBUG_ENTRY is not set
CONFIG_DEBUG_NMI_SELFTEST=y
CONFIG_X86_DEBUG_FPU=y
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_ORC=y
# CONFIG_UNWINDER_FRAME_POINTER is not set
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
CONFIG_KUNIT=y
CONFIG_KUNIT_DEBUGFS=y
CONFIG_KUNIT_TEST=y
CONFIG_KUNIT_EXAMPLE_TEST=y
CONFIG_KUNIT_ALL_TESTS=y
CONFIG_NOTIFIER_ERROR_INJECTION=y
CONFIG_PM_NOTIFIER_ERROR_INJECT=y
# CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
CONFIG_FAULT_INJECTION=y
CONFIG_FAIL_PAGE_ALLOC=y
# CONFIG_FAULT_INJECTION_USERCOPY is not set
CONFIG_FAIL_MAKE_REQUEST=y
# CONFIG_FAIL_IO_TIMEOUT is not set
# CONFIG_FAULT_INJECTION_DEBUG_FS is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_KCOV is not set
# CONFIG_RUNTIME_TESTING_MENU is not set
CONFIG_ARCH_USE_MEMTEST=y
# CONFIG_MEMTEST is not set
# end of Kernel Testing and Coverage

# CONFIG_WARN_MISSING_DOCUMENTS is not set
# CONFIG_WARN_ABI_ERRORS is not set
# end of Kernel hacking

--lfMMhuJdLSP5mfuz--
