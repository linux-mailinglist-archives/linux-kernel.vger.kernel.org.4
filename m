Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C672728F27
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 06:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237597AbjFIE53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 00:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237660AbjFIE5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 00:57:23 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E357199D
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 21:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686286641; x=1717822641;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/0QUbytPpIvltjPk6rTxYufcFkAI01auf3Su3VQ4YPM=;
  b=PPWTRQjcXArQ06GPZLhfFuzoM5T0csSIlWw7ENeCFmrYLI4pAP/LnGLh
   erdyH+EN1QOwHXPbMSKoB04Lnu2MRa6LnChZ546vIhtZXQa8KdM04N5mQ
   9+s3UeBA6ArvOOSYsga/8qlpYYH8mw+U0ztXaDRTHY53EoE6MdnzeDRS8
   aXdRBUNBv1gcU6hpkWLiikJlbR9wZuMLX7xbLV+LJtisJwP/fXzSJp8+C
   Csy5UojsLt0DDE/H6Ll/zG3fqC05UBXzzxL4KCdPjJER2/0uw8CEPWJqM
   P4CyQhr+xr0uTV3j8MEbZs9yKFZ65KQMcc2p+VHOQOAx1Fe2ezhe1z1CV
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="355006403"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; 
   d="scan'208";a="355006403"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 21:57:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="780153871"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; 
   d="scan'208";a="780153871"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 08 Jun 2023 21:57:17 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q7UBZ-0008ee-00;
        Fri, 09 Jun 2023 04:57:17 +0000
Date:   Fri, 9 Jun 2023 12:56:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hawking Zhang <Hawking.Zhang@amd.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        "Zhou, Peng Ju" <PengJu.Zhou@amd.com>,
        Lijo Lazar <lijo.lazar@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c:781:12: warning: stack frame
 size (2272) exceeds limit (2048) in 'uvd_v7_0_sriov_start'
Message-ID: <202306091209.4NbUGTmn-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hawking,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   33f2b5785a2b6b0ed1948aafee60d3abb12f1e3a
commit: 1b2dc99e2dc6f35f55f0487e12fc9166fbd023ed drm/amdgpu: switch to amdgpu_sriov_rreg/wreg
date:   1 year, 4 months ago
config: riscv-randconfig-r012-20230608 (https://download.01.org/0day-ci/archive/20230609/202306091209.4NbUGTmn-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1b2dc99e2dc6f35f55f0487e12fc9166fbd023ed
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 1b2dc99e2dc6f35f55f0487e12fc9166fbd023ed
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=riscv olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/gpu/drm/ drivers/hid/ lib/

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306091209.4NbUGTmn-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c:781:12: warning: stack frame size (2272) exceeds limit (2048) in 'uvd_v7_0_sriov_start' [-Wframe-larger-than]
   static int uvd_v7_0_sriov_start(struct amdgpu_device *adev)
              ^
   drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c:947:12: warning: stack frame size (6704) exceeds limit (2048) in 'uvd_v7_0_start' [-Wframe-larger-than]
   static int uvd_v7_0_start(struct amdgpu_device *adev)
              ^
   drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c:667:13: warning: stack frame size (4528) exceeds limit (2048) in 'uvd_v7_0_mc_resume' [-Wframe-larger-than]
   static void uvd_v7_0_mc_resume(struct amdgpu_device *adev)
               ^
   3 warnings generated.


vim +/uvd_v7_0_sriov_start +781 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c

247ac951417401 Frank Min     2017-04-17  780  
247ac951417401 Frank Min     2017-04-17 @781  static int uvd_v7_0_sriov_start(struct amdgpu_device *adev)
247ac951417401 Frank Min     2017-04-17  782  {
247ac951417401 Frank Min     2017-04-17  783  	struct amdgpu_ring *ring;
247ac951417401 Frank Min     2017-04-17  784  	uint32_t offset, size, tmp;
247ac951417401 Frank Min     2017-04-17  785  	uint32_t table_size = 0;
247ac951417401 Frank Min     2017-04-17  786  	struct mmsch_v1_0_cmd_direct_write direct_wt = { {0} };
247ac951417401 Frank Min     2017-04-17  787  	struct mmsch_v1_0_cmd_direct_read_modify_write direct_rd_mod_wt = { {0} };
247ac951417401 Frank Min     2017-04-17  788  	struct mmsch_v1_0_cmd_direct_polling direct_poll = { {0} };
247ac951417401 Frank Min     2017-04-17  789  	struct mmsch_v1_0_cmd_end end = { {0} };
247ac951417401 Frank Min     2017-04-17  790  	uint32_t *init_table = adev->virt.mm_table.cpu_addr;
247ac951417401 Frank Min     2017-04-17  791  	struct mmsch_v1_0_init_header *header = (struct mmsch_v1_0_init_header *)init_table;
10dd74eac4dba9 James Zhu     2018-05-15  792  	uint8_t i = 0;
247ac951417401 Frank Min     2017-04-17  793  
247ac951417401 Frank Min     2017-04-17  794  	direct_wt.cmd_header.command_type = MMSCH_COMMAND__DIRECT_REG_WRITE;
247ac951417401 Frank Min     2017-04-17  795  	direct_rd_mod_wt.cmd_header.command_type = MMSCH_COMMAND__DIRECT_REG_READ_MODIFY_WRITE;
247ac951417401 Frank Min     2017-04-17  796  	direct_poll.cmd_header.command_type = MMSCH_COMMAND__DIRECT_REG_POLLING;
247ac951417401 Frank Min     2017-04-17  797  	end.cmd_header.command_type = MMSCH_COMMAND__END;
247ac951417401 Frank Min     2017-04-17  798  
247ac951417401 Frank Min     2017-04-17  799  	if (header->uvd_table_offset == 0 && header->uvd_table_size == 0) {
247ac951417401 Frank Min     2017-04-17  800  		header->version = MMSCH_VERSION;
247ac951417401 Frank Min     2017-04-17  801  		header->header_size = sizeof(struct mmsch_v1_0_init_header) >> 2;
247ac951417401 Frank Min     2017-04-17  802  
247ac951417401 Frank Min     2017-04-17  803  		if (header->vce_table_offset == 0 && header->vce_table_size == 0)
247ac951417401 Frank Min     2017-04-17  804  			header->uvd_table_offset = header->header_size;
247ac951417401 Frank Min     2017-04-17  805  		else
247ac951417401 Frank Min     2017-04-17  806  			header->uvd_table_offset = header->vce_table_size + header->vce_table_offset;
247ac951417401 Frank Min     2017-04-17  807  
247ac951417401 Frank Min     2017-04-17  808  		init_table += header->uvd_table_offset;
247ac951417401 Frank Min     2017-04-17  809  
10dd74eac4dba9 James Zhu     2018-05-15  810  		for (i = 0; i < adev->uvd.num_uvd_inst; ++i) {
f1e582ebfd703e Alex Deucher  2018-07-25  811  			if (adev->uvd.harvest_config & (1 << i))
f1e582ebfd703e Alex Deucher  2018-07-25  812  				continue;
10dd74eac4dba9 James Zhu     2018-05-15  813  			ring = &adev->uvd.inst[i].ring;
81fe3f35ac91ce Frank Min     2017-06-12  814  			ring->wptr = 0;
247ac951417401 Frank Min     2017-04-17  815  			size = AMDGPU_GPU_PAGE_ALIGN(adev->uvd.fw->size + 4);
247ac951417401 Frank Min     2017-04-17  816  
10dd74eac4dba9 James Zhu     2018-05-15  817  			MMSCH_V1_0_INSERT_DIRECT_RD_MOD_WT(SOC15_REG_OFFSET(UVD, i, mmUVD_STATUS),
247ac951417401 Frank Min     2017-04-17  818  							   0xFFFFFFFF, 0x00000004);
247ac951417401 Frank Min     2017-04-17  819  			/* mc resume*/
247ac951417401 Frank Min     2017-04-17  820  			if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
992fbe8ce035d8 Trigger Huang 2019-02-25  821  				MMSCH_V1_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(UVD, i,
992fbe8ce035d8 Trigger Huang 2019-02-25  822  							mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW),
992fbe8ce035d8 Trigger Huang 2019-02-25  823  							adev->firmware.ucode[AMDGPU_UCODE_ID_UVD].tmr_mc_addr_lo);
992fbe8ce035d8 Trigger Huang 2019-02-25  824  				MMSCH_V1_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(UVD, i,
992fbe8ce035d8 Trigger Huang 2019-02-25  825  							mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH),
992fbe8ce035d8 Trigger Huang 2019-02-25  826  							adev->firmware.ucode[AMDGPU_UCODE_ID_UVD].tmr_mc_addr_hi);
992fbe8ce035d8 Trigger Huang 2019-02-25  827  				MMSCH_V1_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(UVD, 0, mmUVD_VCPU_CACHE_OFFSET0), 0);
247ac951417401 Frank Min     2017-04-17  828  				offset = 0;
247ac951417401 Frank Min     2017-04-17  829  			} else {
10dd74eac4dba9 James Zhu     2018-05-15  830  				MMSCH_V1_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(UVD, i, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW),
10dd74eac4dba9 James Zhu     2018-05-15  831  							    lower_32_bits(adev->uvd.inst[i].gpu_addr));
10dd74eac4dba9 James Zhu     2018-05-15  832  				MMSCH_V1_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(UVD, i, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH),
10dd74eac4dba9 James Zhu     2018-05-15  833  							    upper_32_bits(adev->uvd.inst[i].gpu_addr));
247ac951417401 Frank Min     2017-04-17  834  				offset = size;
992fbe8ce035d8 Trigger Huang 2019-02-25  835  				MMSCH_V1_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(UVD, 0, mmUVD_VCPU_CACHE_OFFSET0),
992fbe8ce035d8 Trigger Huang 2019-02-25  836  							AMDGPU_UVD_FIRMWARE_OFFSET >> 3);
992fbe8ce035d8 Trigger Huang 2019-02-25  837  
247ac951417401 Frank Min     2017-04-17  838  			}
247ac951417401 Frank Min     2017-04-17  839  
10dd74eac4dba9 James Zhu     2018-05-15  840  			MMSCH_V1_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(UVD, i, mmUVD_VCPU_CACHE_SIZE0), size);
10dd74eac4dba9 James Zhu     2018-05-15  841  
10dd74eac4dba9 James Zhu     2018-05-15  842  			MMSCH_V1_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(UVD, i, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_LOW),
10dd74eac4dba9 James Zhu     2018-05-15  843  						    lower_32_bits(adev->uvd.inst[i].gpu_addr + offset));
10dd74eac4dba9 James Zhu     2018-05-15  844  			MMSCH_V1_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(UVD, i, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_HIGH),
10dd74eac4dba9 James Zhu     2018-05-15  845  						    upper_32_bits(adev->uvd.inst[i].gpu_addr + offset));
10dd74eac4dba9 James Zhu     2018-05-15  846  			MMSCH_V1_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(UVD, i, mmUVD_VCPU_CACHE_OFFSET1), (1 << 21));
10dd74eac4dba9 James Zhu     2018-05-15  847  			MMSCH_V1_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(UVD, i, mmUVD_VCPU_CACHE_SIZE1), AMDGPU_UVD_HEAP_SIZE);
10dd74eac4dba9 James Zhu     2018-05-15  848  
10dd74eac4dba9 James Zhu     2018-05-15  849  			MMSCH_V1_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(UVD, i, mmUVD_LMI_VCPU_CACHE2_64BIT_BAR_LOW),
10dd74eac4dba9 James Zhu     2018-05-15  850  						    lower_32_bits(adev->uvd.inst[i].gpu_addr + offset + AMDGPU_UVD_HEAP_SIZE));
10dd74eac4dba9 James Zhu     2018-05-15  851  			MMSCH_V1_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(UVD, i, mmUVD_LMI_VCPU_CACHE2_64BIT_BAR_HIGH),
10dd74eac4dba9 James Zhu     2018-05-15  852  						    upper_32_bits(adev->uvd.inst[i].gpu_addr + offset + AMDGPU_UVD_HEAP_SIZE));
10dd74eac4dba9 James Zhu     2018-05-15  853  			MMSCH_V1_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(UVD, i, mmUVD_VCPU_CACHE_OFFSET2), (2 << 21));
10dd74eac4dba9 James Zhu     2018-05-15  854  			MMSCH_V1_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(UVD, i, mmUVD_VCPU_CACHE_SIZE2),
247ac951417401 Frank Min     2017-04-17  855  						    AMDGPU_UVD_STACK_SIZE + (AMDGPU_UVD_SESSION_SIZE * 40));
247ac951417401 Frank Min     2017-04-17  856  
10dd74eac4dba9 James Zhu     2018-05-15  857  			MMSCH_V1_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(UVD, i, mmUVD_GP_SCRATCH4), adev->uvd.max_handles);
247ac951417401 Frank Min     2017-04-17  858  			/* mc resume end*/
247ac951417401 Frank Min     2017-04-17  859  
247ac951417401 Frank Min     2017-04-17  860  			/* disable clock gating */
10dd74eac4dba9 James Zhu     2018-05-15  861  			MMSCH_V1_0_INSERT_DIRECT_RD_MOD_WT(SOC15_REG_OFFSET(UVD, i, mmUVD_CGC_CTRL),
247ac951417401 Frank Min     2017-04-17  862  							   ~UVD_CGC_CTRL__DYN_CLOCK_MODE_MASK, 0);
247ac951417401 Frank Min     2017-04-17  863  
247ac951417401 Frank Min     2017-04-17  864  			/* disable interupt */
10dd74eac4dba9 James Zhu     2018-05-15  865  			MMSCH_V1_0_INSERT_DIRECT_RD_MOD_WT(SOC15_REG_OFFSET(UVD, i, mmUVD_MASTINT_EN),
247ac951417401 Frank Min     2017-04-17  866  							   ~UVD_MASTINT_EN__VCPU_EN_MASK, 0);
247ac951417401 Frank Min     2017-04-17  867  
247ac951417401 Frank Min     2017-04-17  868  			/* stall UMC and register bus before resetting VCPU */
10dd74eac4dba9 James Zhu     2018-05-15  869  			MMSCH_V1_0_INSERT_DIRECT_RD_MOD_WT(SOC15_REG_OFFSET(UVD, i, mmUVD_LMI_CTRL2),
247ac951417401 Frank Min     2017-04-17  870  							   ~UVD_LMI_CTRL2__STALL_ARB_UMC_MASK,
247ac951417401 Frank Min     2017-04-17  871  							   UVD_LMI_CTRL2__STALL_ARB_UMC_MASK);
247ac951417401 Frank Min     2017-04-17  872  
247ac951417401 Frank Min     2017-04-17  873  			/* put LMI, VCPU, RBC etc... into reset */
10dd74eac4dba9 James Zhu     2018-05-15  874  			MMSCH_V1_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(UVD, i, mmUVD_SOFT_RESET),
247ac951417401 Frank Min     2017-04-17  875  						    (uint32_t)(UVD_SOFT_RESET__LMI_SOFT_RESET_MASK |
247ac951417401 Frank Min     2017-04-17  876  							       UVD_SOFT_RESET__VCPU_SOFT_RESET_MASK |
247ac951417401 Frank Min     2017-04-17  877  							       UVD_SOFT_RESET__LBSI_SOFT_RESET_MASK |
247ac951417401 Frank Min     2017-04-17  878  							       UVD_SOFT_RESET__RBC_SOFT_RESET_MASK |
247ac951417401 Frank Min     2017-04-17  879  							       UVD_SOFT_RESET__CSM_SOFT_RESET_MASK |
247ac951417401 Frank Min     2017-04-17  880  							       UVD_SOFT_RESET__CXW_SOFT_RESET_MASK |
247ac951417401 Frank Min     2017-04-17  881  							       UVD_SOFT_RESET__TAP_SOFT_RESET_MASK |
247ac951417401 Frank Min     2017-04-17  882  							       UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK));
247ac951417401 Frank Min     2017-04-17  883  
247ac951417401 Frank Min     2017-04-17  884  			/* initialize UVD memory controller */
10dd74eac4dba9 James Zhu     2018-05-15  885  			MMSCH_V1_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(UVD, i, mmUVD_LMI_CTRL),
247ac951417401 Frank Min     2017-04-17  886  						    (uint32_t)((0x40 << UVD_LMI_CTRL__WRITE_CLEAN_TIMER__SHIFT) |
247ac951417401 Frank Min     2017-04-17  887  							       UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MASK |
247ac951417401 Frank Min     2017-04-17  888  							       UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK |
247ac951417401 Frank Min     2017-04-17  889  							       UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK |
247ac951417401 Frank Min     2017-04-17  890  							       UVD_LMI_CTRL__REQ_MODE_MASK |
247ac951417401 Frank Min     2017-04-17  891  							       0x00100000L));
247ac951417401 Frank Min     2017-04-17  892  
247ac951417401 Frank Min     2017-04-17  893  			/* take all subblocks out of reset, except VCPU */
10dd74eac4dba9 James Zhu     2018-05-15  894  			MMSCH_V1_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(UVD, i, mmUVD_SOFT_RESET),
247ac951417401 Frank Min     2017-04-17  895  						    UVD_SOFT_RESET__VCPU_SOFT_RESET_MASK);
247ac951417401 Frank Min     2017-04-17  896  
247ac951417401 Frank Min     2017-04-17  897  			/* enable VCPU clock */
10dd74eac4dba9 James Zhu     2018-05-15  898  			MMSCH_V1_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(UVD, i, mmUVD_VCPU_CNTL),
247ac951417401 Frank Min     2017-04-17  899  						    UVD_VCPU_CNTL__CLK_EN_MASK);
247ac951417401 Frank Min     2017-04-17  900  
247ac951417401 Frank Min     2017-04-17  901  			/* enable master interrupt */
10dd74eac4dba9 James Zhu     2018-05-15  902  			MMSCH_V1_0_INSERT_DIRECT_RD_MOD_WT(SOC15_REG_OFFSET(UVD, i, mmUVD_MASTINT_EN),
247ac951417401 Frank Min     2017-04-17  903  							   ~(UVD_MASTINT_EN__VCPU_EN_MASK|UVD_MASTINT_EN__SYS_EN_MASK),
247ac951417401 Frank Min     2017-04-17  904  							   (UVD_MASTINT_EN__VCPU_EN_MASK|UVD_MASTINT_EN__SYS_EN_MASK));
247ac951417401 Frank Min     2017-04-17  905  
247ac951417401 Frank Min     2017-04-17  906  			/* clear the bit 4 of UVD_STATUS */
10dd74eac4dba9 James Zhu     2018-05-15  907  			MMSCH_V1_0_INSERT_DIRECT_RD_MOD_WT(SOC15_REG_OFFSET(UVD, i, mmUVD_STATUS),
247ac951417401 Frank Min     2017-04-17  908  							   ~(2 << UVD_STATUS__VCPU_REPORT__SHIFT), 0);
247ac951417401 Frank Min     2017-04-17  909  
247ac951417401 Frank Min     2017-04-17  910  			/* force RBC into idle state */
247ac951417401 Frank Min     2017-04-17  911  			size = order_base_2(ring->ring_size);
247ac951417401 Frank Min     2017-04-17  912  			tmp = REG_SET_FIELD(0, UVD_RBC_RB_CNTL, RB_BUFSZ, size);
247ac951417401 Frank Min     2017-04-17  913  			tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_FETCH, 1);
10dd74eac4dba9 James Zhu     2018-05-15  914  			MMSCH_V1_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(UVD, i, mmUVD_RBC_RB_CNTL), tmp);
247ac951417401 Frank Min     2017-04-17  915  
10dd74eac4dba9 James Zhu     2018-05-15  916  			ring = &adev->uvd.inst[i].ring_enc[0];
81fe3f35ac91ce Frank Min     2017-06-12  917  			ring->wptr = 0;
10dd74eac4dba9 James Zhu     2018-05-15  918  			MMSCH_V1_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(UVD, i, mmUVD_RB_BASE_LO), ring->gpu_addr);
10dd74eac4dba9 James Zhu     2018-05-15  919  			MMSCH_V1_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(UVD, i, mmUVD_RB_BASE_HI), upper_32_bits(ring->gpu_addr));
10dd74eac4dba9 James Zhu     2018-05-15  920  			MMSCH_V1_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(UVD, i, mmUVD_RB_SIZE), ring->ring_size / 4);
247ac951417401 Frank Min     2017-04-17  921  
81fe3f35ac91ce Frank Min     2017-06-12  922  			/* boot up the VCPU */
10dd74eac4dba9 James Zhu     2018-05-15  923  			MMSCH_V1_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(UVD, i, mmUVD_SOFT_RESET), 0);
81fe3f35ac91ce Frank Min     2017-06-12  924  
81fe3f35ac91ce Frank Min     2017-06-12  925  			/* enable UMC */
10dd74eac4dba9 James Zhu     2018-05-15  926  			MMSCH_V1_0_INSERT_DIRECT_RD_MOD_WT(SOC15_REG_OFFSET(UVD, i, mmUVD_LMI_CTRL2),
81fe3f35ac91ce Frank Min     2017-06-12  927  											   ~UVD_LMI_CTRL2__STALL_ARB_UMC_MASK, 0);
81fe3f35ac91ce Frank Min     2017-06-12  928  
10dd74eac4dba9 James Zhu     2018-05-15  929  			MMSCH_V1_0_INSERT_DIRECT_POLL(SOC15_REG_OFFSET(UVD, i, mmUVD_STATUS), 0x02, 0x02);
10dd74eac4dba9 James Zhu     2018-05-15  930  		}
247ac951417401 Frank Min     2017-04-17  931  		/* add end packet */
247ac951417401 Frank Min     2017-04-17  932  		memcpy((void *)init_table, &end, sizeof(struct mmsch_v1_0_cmd_end));
247ac951417401 Frank Min     2017-04-17  933  		table_size += sizeof(struct mmsch_v1_0_cmd_end) / 4;
247ac951417401 Frank Min     2017-04-17  934  		header->uvd_table_size = table_size;
247ac951417401 Frank Min     2017-04-17  935  
247ac951417401 Frank Min     2017-04-17  936  	}
257deb8cc654d3 Frank Min     2017-06-15  937  	return uvd_v7_0_mmsch_start(adev, &adev->virt.mm_table);
247ac951417401 Frank Min     2017-04-17  938  }
247ac951417401 Frank Min     2017-04-17  939  

:::::: The code at line 781 was first introduced by commit
:::::: 247ac95141740157bd86d29819ff46e7ab396113 drm/amdgpu/uvd7: add sriov uvd initialization sequences

:::::: TO: Frank Min <Frank.Min@amd.com>
:::::: CC: Alex Deucher <alexander.deucher@amd.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
