Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B789368BBF3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 12:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbjBFLqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 06:46:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjBFLqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 06:46:08 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8D321A2F
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 03:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675683961; x=1707219961;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=icTvws4kIzU2UsXu1q43rVkUlEvrWS5DBP6uhS7pCEU=;
  b=eLw/dQwOm7RJpgXR2U3R3YLy/eUWNwlfMfZdW1U9MZnk6oEbxmvs4pBo
   0pVI9kHjJk2IRfnOBVOgvvgF54s+JxjnNnuQH5BbvwfHBQ+D6rJuvvQNw
   2KmXaVMhmYDNQuDia5of3a3Hwhqo0KEFmX24/lx5NaJNz2IYe16IPM3wj
   f/4PDXU08r1ICiHkyvAlPNKcAk5wlw4Jp352cCmNp+W58UPFKMVvH8FOp
   gUsoMX0Rp8Cq5M5/GyAX0DydSrVf3YN5qA4puRD6fT4n08QSZwxNalVSO
   bhmIpkURqvc9IuuEHuNhkjp2zjFnV+XH2fGyq34gkZW+C5wpYGzsduOIz
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10612"; a="327818615"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="327818615"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 03:45:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10612"; a="840328611"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="840328611"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 06 Feb 2023 03:45:55 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pOzwY-0002WS-2s;
        Mon, 06 Feb 2023 11:45:54 +0000
Date:   Mon, 6 Feb 2023 19:45:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Charlene Liu <Charlene.Liu@amd.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn31/display_mode_vba_31.c:881:16:
 warning: variable 'Tsw_oto' set but not used
Message-ID: <202302061945.Fnl3rRuk-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Charlene,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d2d11f342b179f1894a901f143ec7c008caba43e
commit: 27142312c8a44026815df721882468c63c4c96da drm/amd/display: fix dcn3.1x mode validation on high bandwidth config
date:   3 months ago
config: arm64-randconfig-r002-20230205 (https://download.01.org/0day-ci/archive/20230206/202302061945.Fnl3rRuk-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=27142312c8a44026815df721882468c63c4c96da
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 27142312c8a44026815df721882468c63c4c96da
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/gpu/drm/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn31/display_mode_vba_31.c: In function 'CalculatePrefetchSchedule':
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn31/display_mode_vba_31.c:881:16: warning: variable 'Tsw_oto' set but not used [-Wunused-but-set-variable]
     881 |         double Tsw_oto;
         |                ^~~~~~~
--
   drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn314/display_mode_vba_314.c: In function 'CalculatePrefetchSchedule':
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn314/display_mode_vba_314.c:903:16: warning: variable 'Tsw_oto' set but not used [-Wunused-but-set-variable]
     903 |         double Tsw_oto;
         |                ^~~~~~~


vim +/Tsw_oto +881 drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn31/display_mode_vba_31.c

74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  812  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  813  static bool CalculatePrefetchSchedule(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  814  		struct display_mode_lib *mode_lib,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  815  		double HostVMInefficiencyFactor,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  816  		Pipe *myPipe,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  817  		unsigned int DSCDelay,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  818  		double DPPCLKDelaySubtotalPlusCNVCFormater,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  819  		double DPPCLKDelaySCL,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  820  		double DPPCLKDelaySCLLBOnly,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  821  		double DPPCLKDelayCNVCCursor,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  822  		double DISPCLKDelaySubtotal,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  823  		unsigned int DPP_RECOUT_WIDTH,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  824  		enum output_format_class OutputFormat,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  825  		unsigned int MaxInterDCNTileRepeaters,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  826  		unsigned int VStartup,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  827  		unsigned int MaxVStartup,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  828  		unsigned int GPUVMPageTableLevels,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  829  		bool GPUVMEnable,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  830  		bool HostVMEnable,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  831  		unsigned int HostVMMaxNonCachedPageTableLevels,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  832  		double HostVMMinPageSize,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  833  		bool DynamicMetadataEnable,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  834  		bool DynamicMetadataVMEnabled,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  835  		int DynamicMetadataLinesBeforeActiveRequired,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  836  		unsigned int DynamicMetadataTransmittedBytes,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  837  		double UrgentLatency,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  838  		double UrgentExtraLatency,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  839  		double TCalc,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  840  		unsigned int PDEAndMetaPTEBytesFrame,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  841  		unsigned int MetaRowByte,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  842  		unsigned int PixelPTEBytesPerRow,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  843  		double PrefetchSourceLinesY,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  844  		unsigned int SwathWidthY,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  845  		double VInitPreFillY,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  846  		unsigned int MaxNumSwathY,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  847  		double PrefetchSourceLinesC,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  848  		unsigned int SwathWidthC,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  849  		double VInitPreFillC,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  850  		unsigned int MaxNumSwathC,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  851  		int swath_width_luma_ub,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  852  		int swath_width_chroma_ub,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  853  		unsigned int SwathHeightY,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  854  		unsigned int SwathHeightC,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  855  		double TWait,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  856  		double *DSTXAfterScaler,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  857  		double *DSTYAfterScaler,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  858  		double *DestinationLinesForPrefetch,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  859  		double *PrefetchBandwidth,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  860  		double *DestinationLinesToRequestVMInVBlank,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  861  		double *DestinationLinesToRequestRowInVBlank,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  862  		double *VRatioPrefetchY,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  863  		double *VRatioPrefetchC,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  864  		double *RequiredPrefetchPixDataBWLuma,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  865  		double *RequiredPrefetchPixDataBWChroma,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  866  		bool *NotEnoughTimeForDynamicMetadata,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  867  		double *Tno_bw,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  868  		double *prefetch_vmrow_bw,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  869  		double *Tdmdl_vm,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  870  		double *Tdmdl,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  871  		double *TSetup,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  872  		int *VUpdateOffsetPix,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  873  		double *VUpdateWidthPix,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  874  		double *VReadyOffsetPix)
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  875  {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  876  	bool MyError = false;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  877  	unsigned int DPPCycles, DISPCLKCycles;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  878  	double DSTTotalPixelsAfterScaler;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  879  	double LineTime;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  880  	double dst_y_prefetch_equ;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19 @881  	double Tsw_oto;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  882  	double prefetch_bw_oto;
9338cb719f0f0b Charlene Liu        2022-01-07  883  	double prefetch_bw_pr;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  884  	double Tvm_oto;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  885  	double Tr0_oto;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  886  	double Tvm_oto_lines;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  887  	double Tr0_oto_lines;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  888  	double dst_y_prefetch_oto;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  889  	double TimeForFetchingMetaPTE = 0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  890  	double TimeForFetchingRowInVBlank = 0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  891  	double LinesToRequestPrefetchPixelData = 0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  892  	unsigned int HostVMDynamicLevelsTrips;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  893  	double trip_to_mem;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  894  	double Tvm_trips;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  895  	double Tr0_trips;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  896  	double Tvm_trips_rounded;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  897  	double Tr0_trips_rounded;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  898  	double Lsw_oto;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  899  	double Tpre_rounded;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  900  	double prefetch_bw_equ;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  901  	double Tvm_equ;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  902  	double Tr0_equ;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  903  	double Tdmbf;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  904  	double Tdmec;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  905  	double Tdmsks;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  906  	double prefetch_sw_bytes;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  907  	double bytes_pp;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  908  	double dep_bytes;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  909  	int max_vratio_pre = 4;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  910  	double min_Lsw;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  911  	double Tsw_est1 = 0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  912  	double Tsw_est3 = 0;
9338cb719f0f0b Charlene Liu        2022-01-07  913  	double  max_Tsw = 0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  914  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  915  	if (GPUVMEnable == true && HostVMEnable == true) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  916  		HostVMDynamicLevelsTrips = HostVMMaxNonCachedPageTableLevels;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  917  	} else {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  918  		HostVMDynamicLevelsTrips = 0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  919  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  920  #ifdef __DML_VBA_DEBUG__
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  921  	dml_print("DML::%s: GPUVMEnable=%d HostVMEnable=%d HostVMInefficiencyFactor=%f\n", __func__, GPUVMEnable, HostVMEnable, HostVMInefficiencyFactor);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  922  #endif
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  923  	CalculateVupdateAndDynamicMetadataParameters(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  924  			MaxInterDCNTileRepeaters,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  925  			myPipe->DPPCLK,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  926  			myPipe->DISPCLK,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  927  			myPipe->DCFCLKDeepSleep,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  928  			myPipe->PixelClock,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  929  			myPipe->HTotal,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  930  			myPipe->VBlank,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  931  			DynamicMetadataTransmittedBytes,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  932  			DynamicMetadataLinesBeforeActiveRequired,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  933  			myPipe->InterlaceEnable,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  934  			myPipe->ProgressiveToInterlaceUnitInOPP,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  935  			TSetup,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  936  			&Tdmbf,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  937  			&Tdmec,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  938  			&Tdmsks,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  939  			VUpdateOffsetPix,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  940  			VUpdateWidthPix,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  941  			VReadyOffsetPix);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  942  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  943  	LineTime = myPipe->HTotal / myPipe->PixelClock;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  944  	trip_to_mem = UrgentLatency;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  945  	Tvm_trips = UrgentExtraLatency + trip_to_mem * (GPUVMPageTableLevels * (HostVMDynamicLevelsTrips + 1) - 1);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  946  

:::::: The code at line 881 was first introduced by commit
:::::: 74458c081fcfb0423877e630de2746daefdb16e4 drm/amd/display: Add DCN3.1 DML calculation support

:::::: TO: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
:::::: CC: Alex Deucher <alexander.deucher@amd.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
