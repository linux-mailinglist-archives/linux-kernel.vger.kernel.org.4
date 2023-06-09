Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5EB72A41C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 22:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjFIUJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 16:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjFIUJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 16:09:48 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 155A21B9
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 13:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686341387; x=1717877387;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ddi+tWw+RO5Vunrujbki4YcMhgJ/XzjlgAgXc0jyQjs=;
  b=l029vH3KHSDULIELzDED9g/ZiFicEo749JjmFe4JSZnWmeUMdlb29ujY
   gBUvtP4ha1VcbIX6wK2qK3MCWoCXR12RBql8pKKCE0iWe9kYJB3enl0Z+
   mlcLXJTGIRkB1wjY17hUPznW0t+YXYoIVUCg4yQ5JuNjhSDpySSuqqZcx
   9f8y74u6yOat1Fyv+oAp+2aYa+TlnS84Tse4nyXdBOwHD22j5dRshabbE
   a2D/DhWmhLJYE4H2dEWOzT2NIldwpYydJMFBIC93Bd29wSvrGuhAL3otk
   NRGZd5h3AMPHyWTNnQ/bkIbk+g9g1DoiSuCCC9k2rIJD3P+yJ6kG/iScs
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="355169055"
X-IronPort-AV: E=Sophos;i="6.00,230,1681196400"; 
   d="scan'208";a="355169055"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 13:09:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="704667797"
X-IronPort-AV: E=Sophos;i="6.00,230,1681196400"; 
   d="scan'208";a="704667797"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 09 Jun 2023 13:09:44 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q7iQZ-0009Lv-0h;
        Fri, 09 Jun 2023 20:09:43 +0000
Date:   Sat, 10 Jun 2023 04:09:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Stanley Yang <Stanley.Yang@amd.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Likun Gao <Likun.Gao@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c:511:12: warning: stack frame
 size (3904) exceeds limit (2048) in 'sdma_v6_0_gfx_resume'
Message-ID: <202306100454.5IAHFgxo-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   dbfa18c5d7695766f24c0c140204e1f8c921fb95
commit: 61a039d1757b148717b9e10ea0cd30e5da6cf919 drm/amdgpu: add initial support for sdma v6.0
date:   1 year, 1 month ago
config: riscv-randconfig-r012-20230608 (https://download.01.org/0day-ci/archive/20230610/202306100454.5IAHFgxo-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=61a039d1757b148717b9e10ea0cd30e5da6cf919
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 61a039d1757b148717b9e10ea0cd30e5da6cf919
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=riscv olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/gpu/drm/ lib/

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306100454.5IAHFgxo-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c:511:12: warning: stack frame size (3904) exceeds limit (2048) in 'sdma_v6_0_gfx_resume' [-Wframe-larger-than]
   static int sdma_v6_0_gfx_resume(struct amdgpu_device *adev)
              ^
   1 warning generated.


vim +/sdma_v6_0_gfx_resume +511 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c

   502	
   503	/**
   504	 * sdma_v6_0_gfx_resume - setup and start the async dma engines
   505	 *
   506	 * @adev: amdgpu_device pointer
   507	 *
   508	 * Set up the gfx DMA ring buffers and enable them.
   509	 * Returns 0 for success, error for failure.
   510	 */
 > 511	static int sdma_v6_0_gfx_resume(struct amdgpu_device *adev)
   512	{
   513		struct amdgpu_ring *ring;
   514		u32 rb_cntl, ib_cntl;
   515		u32 rb_bufsz;
   516		u32 doorbell;
   517		u32 doorbell_offset;
   518		u32 temp;
   519		u64 wptr_gpu_addr;
   520		int i, r;
   521	
   522		for (i = 0; i < adev->sdma.num_instances; i++) {
   523			ring = &adev->sdma.instance[i].ring;
   524	
   525			WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_SEM_WAIT_FAIL_TIMER_CNTL), 0);
   526	
   527			/* Set ring buffer size in dwords */
   528			rb_bufsz = order_base_2(ring->ring_size / 4);
   529			rb_cntl = RREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_CNTL));
   530			rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL, RB_SIZE, rb_bufsz);
   531	#ifdef __BIG_ENDIAN
   532			rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL, RB_SWAP_ENABLE, 1);
   533			rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL,
   534						RPTR_WRITEBACK_SWAP_ENABLE, 1);
   535	#endif
   536			rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL, RB_PRIV, 1);
   537			WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_CNTL), rb_cntl);
   538	
   539			/* Initialize the ring buffer's read and write pointers */
   540			WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_RPTR), 0);
   541			WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_RPTR_HI), 0);
   542			WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_WPTR), 0);
   543			WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_WPTR_HI), 0);
   544	
   545			/* setup the wptr shadow polling */
   546			wptr_gpu_addr = ring->wptr_gpu_addr;
   547			WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_WPTR_POLL_ADDR_LO),
   548			       lower_32_bits(wptr_gpu_addr));
   549			WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_WPTR_POLL_ADDR_HI),
   550			       upper_32_bits(wptr_gpu_addr));
   551	
   552			/* set the wb address whether it's enabled or not */
   553			WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_RPTR_ADDR_HI),
   554			       upper_32_bits(ring->rptr_gpu_addr) & 0xFFFFFFFF);
   555			WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_RPTR_ADDR_LO),
   556			       lower_32_bits(ring->rptr_gpu_addr) & 0xFFFFFFFC);
   557	
   558			rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL, RPTR_WRITEBACK_ENABLE, 1);
   559			rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL, WPTR_POLL_ENABLE, 1);
   560			rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL, F32_WPTR_POLL_ENABLE, 1);
   561	
   562			WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_BASE), ring->gpu_addr >> 8);
   563			WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_BASE_HI), ring->gpu_addr >> 40);
   564	
   565			ring->wptr = 0;
   566	
   567			/* before programing wptr to a less value, need set minor_ptr_update first */
   568			WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_MINOR_PTR_UPDATE), 1);
   569	
   570			if (!amdgpu_sriov_vf(adev)) { /* only bare-metal use register write for wptr */
   571				WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_WPTR), lower_32_bits(ring->wptr) << 2);
   572				WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_WPTR_HI), upper_32_bits(ring->wptr) << 2);
   573			}
   574	
   575			doorbell = RREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_DOORBELL));
   576			doorbell_offset = RREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_DOORBELL_OFFSET));
   577	
   578			if (ring->use_doorbell) {
   579				doorbell = REG_SET_FIELD(doorbell, SDMA0_QUEUE0_DOORBELL, ENABLE, 1);
   580				doorbell_offset = REG_SET_FIELD(doorbell_offset, SDMA0_QUEUE0_DOORBELL_OFFSET,
   581						OFFSET, ring->doorbell_index);
   582			} else {
   583				doorbell = REG_SET_FIELD(doorbell, SDMA0_QUEUE0_DOORBELL, ENABLE, 0);
   584			}
   585			WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_DOORBELL), doorbell);
   586			WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_DOORBELL_OFFSET), doorbell_offset);
   587	
   588			if (i == 0)
   589				adev->nbio.funcs->sdma_doorbell_range(adev, i, ring->use_doorbell,
   590							      ring->doorbell_index,
   591							      adev->doorbell_index.sdma_doorbell_range * adev->sdma.num_instances);
   592	
   593			if (amdgpu_sriov_vf(adev))
   594				sdma_v6_0_ring_set_wptr(ring);
   595	
   596			/* set minor_ptr_update to 0 after wptr programed */
   597			WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_MINOR_PTR_UPDATE), 0);
   598	
   599			/* Set up RESP_MODE to non-copy addresses */
   600			temp = RREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_UTCL1_CNTL));
   601			temp = REG_SET_FIELD(temp, SDMA0_UTCL1_CNTL, RESP_MODE, 3);
   602			temp = REG_SET_FIELD(temp, SDMA0_UTCL1_CNTL, REDO_DELAY, 9);
   603			WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_UTCL1_CNTL), temp);
   604	
   605			/* program default cache read and write policy */
   606			temp = RREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_UTCL1_PAGE));
   607			/* clean read policy and write policy bits */
   608			temp &= 0xFF0FFF;
   609			temp |= ((CACHE_READ_POLICY_L2__DEFAULT << 12) |
   610				 (CACHE_WRITE_POLICY_L2__DEFAULT << 14) |
   611				 SDMA0_UTCL1_PAGE__LLC_NOALLOC_MASK);
   612			WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_UTCL1_PAGE), temp);
   613	
   614			if (!amdgpu_sriov_vf(adev)) {
   615				/* unhalt engine */
   616				temp = RREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_F32_CNTL));
   617				temp = REG_SET_FIELD(temp, SDMA0_F32_CNTL, HALT, 0);
   618				temp = REG_SET_FIELD(temp, SDMA0_F32_CNTL, TH1_RESET, 0);
   619				WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_F32_CNTL), temp);
   620			}
   621	
   622			/* enable DMA RB */
   623			rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL, RB_ENABLE, 1);
   624			WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_CNTL), rb_cntl);
   625	
   626			ib_cntl = RREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_IB_CNTL));
   627			ib_cntl = REG_SET_FIELD(ib_cntl, SDMA0_QUEUE0_IB_CNTL, IB_ENABLE, 1);
   628	#ifdef __BIG_ENDIAN
   629			ib_cntl = REG_SET_FIELD(ib_cntl, SDMA0_QUEUE0_IB_CNTL, IB_SWAP_ENABLE, 1);
   630	#endif
   631			/* enable DMA IBs */
   632			WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_IB_CNTL), ib_cntl);
   633	
   634			ring->sched.ready = true;
   635	
   636			if (amdgpu_sriov_vf(adev)) { /* bare-metal sequence doesn't need below to lines */
   637				sdma_v6_0_ctx_switch_enable(adev, true);
   638				sdma_v6_0_enable(adev, true);
   639			}
   640	
   641			r = amdgpu_ring_test_helper(ring);
   642			if (r) {
   643				ring->sched.ready = false;
   644				return r;
   645			}
   646	
   647			if (adev->mman.buffer_funcs_ring == ring)
   648				amdgpu_ttm_set_buffer_funcs_status(adev, true);
   649		}
   650	
   651		return 0;
   652	}
   653	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
