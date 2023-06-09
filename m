Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 664E6729F3D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 17:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241948AbjFIPxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 11:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232265AbjFIPxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 11:53:30 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1383588
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 08:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686326008; x=1717862008;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=T3R8SvGNykkTqMMANysMd1NrtS1xDurZW0RoFNDUYac=;
  b=B3WhQ+s/u2hMQSU6fjwbDngeHx+yT8I7ZqaAqEPu5hG3r9jGao2l8Nme
   6DuIdL4sx9U1Xits5SWABKiMdeOUlH5kjrwqhVv3QLuFfRmQetgzkm0o7
   zlii8Bmy3Zy5If1QaHiOQu0pUFXpS/ROk3/SB3bqvZxH64iQEQvlA4bjg
   QYcv8C8SObr+/Vf6jbCmQuJ40B230Sf+QJfalCYLyziSLVOzAk1opCLPI
   N9QCiCKI4M13i8Tm1vo94zwj2ocJiqQrNZhUOMmjt+i2HEuJ846uO5JmB
   PXhTUo0N+RLu5hiTZwoPgHVug4zjPrDU1CbYIUeVZTXPwoj5YstjAqpn8
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="360985542"
X-IronPort-AV: E=Sophos;i="6.00,229,1681196400"; 
   d="scan'208";a="360985542"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 08:53:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="780358350"
X-IronPort-AV: E=Sophos;i="6.00,229,1681196400"; 
   d="scan'208";a="780358350"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 09 Jun 2023 08:53:25 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q7eQW-0009Bk-1A;
        Fri, 09 Jun 2023 15:53:24 +0000
Date:   Fri, 9 Jun 2023 23:53:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Boyuan Zhang <boyuan.zhang@amd.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c:118:12: warning: stack frame
 size (2064) exceeds limit (2048) in 'vcn_v3_0_sw_init'
Message-ID: <202306092342.fKgkmOE0-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   33f2b5785a2b6b0ed1948aafee60d3abb12f1e3a
commit: 945da79e6dd058be70bc47442dce319844e14daa drm/amdgpu/vcn3: send smu interface type
date:   1 year, 2 months ago
config: riscv-randconfig-r012-20230608 (https://download.01.org/0day-ci/archive/20230609/202306092342.fKgkmOE0-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=945da79e6dd058be70bc47442dce319844e14daa
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 945da79e6dd058be70bc47442dce319844e14daa
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=riscv olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/gpu/drm/ lib/

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306092342.fKgkmOE0-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c:118:12: warning: stack frame size (2064) exceeds limit (2048) in 'vcn_v3_0_sw_init' [-Wframe-larger-than]
   static int vcn_v3_0_sw_init(void *handle)
              ^
   drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c:1517:12: warning: stack frame size (3600) exceeds limit (2048) in 'vcn_v3_0_stop' [-Wframe-larger-than]
   static int vcn_v3_0_stop(struct amdgpu_device *adev)
              ^
   drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c:1089:12: warning: stack frame size (7664) exceeds limit (2048) in 'vcn_v3_0_start' [-Wframe-larger-than]
   static int vcn_v3_0_start(struct amdgpu_device *adev)
              ^
   3 warnings generated.


vim +/vcn_v3_0_sw_init +118 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c

cf14826cdfb5c9 Leo Liu         2019-11-15  110  
cf14826cdfb5c9 Leo Liu         2019-11-15  111  /**
cf14826cdfb5c9 Leo Liu         2019-11-15  112   * vcn_v3_0_sw_init - sw init for VCN block
cf14826cdfb5c9 Leo Liu         2019-11-15  113   *
cf14826cdfb5c9 Leo Liu         2019-11-15  114   * @handle: amdgpu_device pointer
cf14826cdfb5c9 Leo Liu         2019-11-15  115   *
cf14826cdfb5c9 Leo Liu         2019-11-15  116   * Load firmware and sw initialization
cf14826cdfb5c9 Leo Liu         2019-11-15  117   */
cf14826cdfb5c9 Leo Liu         2019-11-15 @118  static int vcn_v3_0_sw_init(void *handle)
cf14826cdfb5c9 Leo Liu         2019-11-15  119  {
cf14826cdfb5c9 Leo Liu         2019-11-15  120  	struct amdgpu_ring *ring;
cf14826cdfb5c9 Leo Liu         2019-11-15  121  	int i, j, r;
1f61a43fcec1dc Jack Zhang      2020-06-29  122  	int vcn_doorbell_index = 0;
cf14826cdfb5c9 Leo Liu         2019-11-15  123  	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
cf14826cdfb5c9 Leo Liu         2019-11-15  124  
cf14826cdfb5c9 Leo Liu         2019-11-15  125  	r = amdgpu_vcn_sw_init(adev);
cf14826cdfb5c9 Leo Liu         2019-11-15  126  	if (r)
cf14826cdfb5c9 Leo Liu         2019-11-15  127  		return r;
cf14826cdfb5c9 Leo Liu         2019-11-15  128  
c5dd5667f4196b Alex Deucher    2021-10-19  129  	amdgpu_vcn_setup_ucode(adev);
cf14826cdfb5c9 Leo Liu         2019-11-15  130  
cf14826cdfb5c9 Leo Liu         2019-11-15  131  	r = amdgpu_vcn_resume(adev);
cf14826cdfb5c9 Leo Liu         2019-11-15  132  	if (r)
cf14826cdfb5c9 Leo Liu         2019-11-15  133  		return r;
cf14826cdfb5c9 Leo Liu         2019-11-15  134  
25a35065c06649 Bokun Zhang     2020-11-09  135  	/*
25a35065c06649 Bokun Zhang     2020-11-09  136  	 * Note: doorbell assignment is fixed for SRIOV multiple VCN engines
25a35065c06649 Bokun Zhang     2020-11-09  137  	 * Formula:
25a35065c06649 Bokun Zhang     2020-11-09  138  	 *   vcn_db_base  = adev->doorbell_index.vcn.vcn_ring0_1 << 1;
25a35065c06649 Bokun Zhang     2020-11-09  139  	 *   dec_ring_i   = vcn_db_base + i * (adev->vcn.num_enc_rings + 1)
25a35065c06649 Bokun Zhang     2020-11-09  140  	 *   enc_ring_i,j = vcn_db_base + i * (adev->vcn.num_enc_rings + 1) + 1 + j
25a35065c06649 Bokun Zhang     2020-11-09  141  	 */
1f61a43fcec1dc Jack Zhang      2020-06-29  142  	if (amdgpu_sriov_vf(adev)) {
1f61a43fcec1dc Jack Zhang      2020-06-29  143  		vcn_doorbell_index = adev->doorbell_index.vcn.vcn_ring0_1;
1f61a43fcec1dc Jack Zhang      2020-06-29  144  		/* get DWORD offset */
1f61a43fcec1dc Jack Zhang      2020-06-29  145  		vcn_doorbell_index = vcn_doorbell_index << 1;
1f61a43fcec1dc Jack Zhang      2020-06-29  146  	}
1f61a43fcec1dc Jack Zhang      2020-06-29  147  
cf14826cdfb5c9 Leo Liu         2019-11-15  148  	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
a76087cf97afe4 James Zhu       2020-11-02  149  		volatile struct amdgpu_fw_shared *fw_shared;
c62dfdbbf71095 Christian König 2021-02-02  150  
cf14826cdfb5c9 Leo Liu         2019-11-15  151  		if (adev->vcn.harvest_config & (1 << i))
cf14826cdfb5c9 Leo Liu         2019-11-15  152  			continue;
cf14826cdfb5c9 Leo Liu         2019-11-15  153  
cf14826cdfb5c9 Leo Liu         2019-11-15  154  		adev->vcn.internal.context_id = mmUVD_CONTEXT_ID_INTERNAL_OFFSET;
cf14826cdfb5c9 Leo Liu         2019-11-15  155  		adev->vcn.internal.ib_vmid = mmUVD_LMI_RBC_IB_VMID_INTERNAL_OFFSET;
cf14826cdfb5c9 Leo Liu         2019-11-15  156  		adev->vcn.internal.ib_bar_low = mmUVD_LMI_RBC_IB_64BIT_BAR_LOW_INTERNAL_OFFSET;
cf14826cdfb5c9 Leo Liu         2019-11-15  157  		adev->vcn.internal.ib_bar_high = mmUVD_LMI_RBC_IB_64BIT_BAR_HIGH_INTERNAL_OFFSET;
cf14826cdfb5c9 Leo Liu         2019-11-15  158  		adev->vcn.internal.ib_size = mmUVD_RBC_IB_SIZE_INTERNAL_OFFSET;
cf14826cdfb5c9 Leo Liu         2019-11-15  159  		adev->vcn.internal.gp_scratch8 = mmUVD_GP_SCRATCH8_INTERNAL_OFFSET;
cf14826cdfb5c9 Leo Liu         2019-11-15  160  
cf14826cdfb5c9 Leo Liu         2019-11-15  161  		adev->vcn.internal.scratch9 = mmUVD_SCRATCH9_INTERNAL_OFFSET;
cf14826cdfb5c9 Leo Liu         2019-11-15  162  		adev->vcn.inst[i].external.scratch9 = SOC15_REG_OFFSET(VCN, i, mmUVD_SCRATCH9);
cf14826cdfb5c9 Leo Liu         2019-11-15  163  		adev->vcn.internal.data0 = mmUVD_GPCOM_VCPU_DATA0_INTERNAL_OFFSET;
cf14826cdfb5c9 Leo Liu         2019-11-15  164  		adev->vcn.inst[i].external.data0 = SOC15_REG_OFFSET(VCN, i, mmUVD_GPCOM_VCPU_DATA0);
cf14826cdfb5c9 Leo Liu         2019-11-15  165  		adev->vcn.internal.data1 = mmUVD_GPCOM_VCPU_DATA1_INTERNAL_OFFSET;
cf14826cdfb5c9 Leo Liu         2019-11-15  166  		adev->vcn.inst[i].external.data1 = SOC15_REG_OFFSET(VCN, i, mmUVD_GPCOM_VCPU_DATA1);
cf14826cdfb5c9 Leo Liu         2019-11-15  167  		adev->vcn.internal.cmd = mmUVD_GPCOM_VCPU_CMD_INTERNAL_OFFSET;
cf14826cdfb5c9 Leo Liu         2019-11-15  168  		adev->vcn.inst[i].external.cmd = SOC15_REG_OFFSET(VCN, i, mmUVD_GPCOM_VCPU_CMD);
cf14826cdfb5c9 Leo Liu         2019-11-15  169  		adev->vcn.internal.nop = mmUVD_NO_OP_INTERNAL_OFFSET;
cf14826cdfb5c9 Leo Liu         2019-11-15  170  		adev->vcn.inst[i].external.nop = SOC15_REG_OFFSET(VCN, i, mmUVD_NO_OP);
cf14826cdfb5c9 Leo Liu         2019-11-15  171  
cf14826cdfb5c9 Leo Liu         2019-11-15  172  		/* VCN DEC TRAP */
cf14826cdfb5c9 Leo Liu         2019-11-15  173  		r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[i],
cf14826cdfb5c9 Leo Liu         2019-11-15  174  				VCN_2_0__SRCID__UVD_SYSTEM_MESSAGE_INTERRUPT, &adev->vcn.inst[i].irq);
cf14826cdfb5c9 Leo Liu         2019-11-15  175  		if (r)
cf14826cdfb5c9 Leo Liu         2019-11-15  176  			return r;
cf14826cdfb5c9 Leo Liu         2019-11-15  177  
c62dfdbbf71095 Christian König 2021-02-02  178  		atomic_set(&adev->vcn.inst[i].sched_score, 0);
c62dfdbbf71095 Christian König 2021-02-02  179  
cf14826cdfb5c9 Leo Liu         2019-11-15  180  		ring = &adev->vcn.inst[i].ring_dec;
cf14826cdfb5c9 Leo Liu         2019-11-15  181  		ring->use_doorbell = true;
1f61a43fcec1dc Jack Zhang      2020-06-29  182  		if (amdgpu_sriov_vf(adev)) {
25a35065c06649 Bokun Zhang     2020-11-09  183  			ring->doorbell_index = vcn_doorbell_index + i * (adev->vcn.num_enc_rings + 1);
1f61a43fcec1dc Jack Zhang      2020-06-29  184  		} else {
cf14826cdfb5c9 Leo Liu         2019-11-15  185  			ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 8 * i;
1f61a43fcec1dc Jack Zhang      2020-06-29  186  		}
cf14826cdfb5c9 Leo Liu         2019-11-15  187  		sprintf(ring->name, "vcn_dec_%d", i);
cf14826cdfb5c9 Leo Liu         2019-11-15  188  		r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst[i].irq, 0,
c62dfdbbf71095 Christian König 2021-02-02  189  				     AMDGPU_RING_PRIO_DEFAULT,
c62dfdbbf71095 Christian König 2021-02-02  190  				     &adev->vcn.inst[i].sched_score);
cf14826cdfb5c9 Leo Liu         2019-11-15  191  		if (r)
cf14826cdfb5c9 Leo Liu         2019-11-15  192  			return r;
cf14826cdfb5c9 Leo Liu         2019-11-15  193  
cf14826cdfb5c9 Leo Liu         2019-11-15  194  		for (j = 0; j < adev->vcn.num_enc_rings; ++j) {
0ad29a4eb13577 Satyajit Sahu   2021-08-27  195  			enum amdgpu_ring_priority_level hw_prio = amdgpu_vcn_get_enc_ring_prio(j);
0ad29a4eb13577 Satyajit Sahu   2021-08-27  196  
cf14826cdfb5c9 Leo Liu         2019-11-15  197  			/* VCN ENC TRAP */
cf14826cdfb5c9 Leo Liu         2019-11-15  198  			r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[i],
cf14826cdfb5c9 Leo Liu         2019-11-15  199  				j + VCN_2_0__SRCID__UVD_ENC_GENERAL_PURPOSE, &adev->vcn.inst[i].irq);
cf14826cdfb5c9 Leo Liu         2019-11-15  200  			if (r)
cf14826cdfb5c9 Leo Liu         2019-11-15  201  				return r;
cf14826cdfb5c9 Leo Liu         2019-11-15  202  
cf14826cdfb5c9 Leo Liu         2019-11-15  203  			ring = &adev->vcn.inst[i].ring_enc[j];
cf14826cdfb5c9 Leo Liu         2019-11-15  204  			ring->use_doorbell = true;
1f61a43fcec1dc Jack Zhang      2020-06-29  205  			if (amdgpu_sriov_vf(adev)) {
25a35065c06649 Bokun Zhang     2020-11-09  206  				ring->doorbell_index = vcn_doorbell_index + i * (adev->vcn.num_enc_rings + 1) + 1 + j;
1f61a43fcec1dc Jack Zhang      2020-06-29  207  			} else {
cf14826cdfb5c9 Leo Liu         2019-11-15  208  				ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 2 + j + 8 * i;
1f61a43fcec1dc Jack Zhang      2020-06-29  209  			}
cf14826cdfb5c9 Leo Liu         2019-11-15  210  			sprintf(ring->name, "vcn_enc_%d.%d", i, j);
cf14826cdfb5c9 Leo Liu         2019-11-15  211  			r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst[i].irq, 0,
0ad29a4eb13577 Satyajit Sahu   2021-08-27  212  					     hw_prio, &adev->vcn.inst[i].sched_score);
cf14826cdfb5c9 Leo Liu         2019-11-15  213  			if (r)
cf14826cdfb5c9 Leo Liu         2019-11-15  214  				return r;
cf14826cdfb5c9 Leo Liu         2019-11-15  215  		}
a76087cf97afe4 James Zhu       2020-11-02  216  
b6065ebf55ff2f Ruijing Dong    2022-03-02  217  		fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
e42dd87e70e66a Sonny Jiang     2020-11-27  218  		fw_shared->present_flag_0 |= cpu_to_le32(AMDGPU_VCN_SW_RING_FLAG) |
b2576c3bf4ce9b Sonny Jiang     2021-01-31  219  					     cpu_to_le32(AMDGPU_VCN_MULTI_QUEUE_FLAG) |
b2576c3bf4ce9b Sonny Jiang     2021-01-31  220  					     cpu_to_le32(AMDGPU_VCN_FW_SHARED_FLAG_0_RB);
a76087cf97afe4 James Zhu       2020-11-02  221  		fw_shared->sw_ring.is_enabled = cpu_to_le32(DEC_SW_RING_ENABLED);
945da79e6dd058 Boyuan Zhang    2022-03-24  222  		fw_shared->present_flag_0 |= AMDGPU_VCN_SMU_VERSION_INFO_FLAG;
945da79e6dd058 Boyuan Zhang    2022-03-24  223  		if (adev->ip_versions[UVD_HWIP][0] == IP_VERSION(3, 1, 2))
945da79e6dd058 Boyuan Zhang    2022-03-24  224  			fw_shared->smu_interface_info.smu_interface_type = 2;
945da79e6dd058 Boyuan Zhang    2022-03-24  225  		else if (adev->ip_versions[UVD_HWIP][0] == IP_VERSION(3, 1, 1))
945da79e6dd058 Boyuan Zhang    2022-03-24  226  			fw_shared->smu_interface_info.smu_interface_type = 1;
11eb648d014eb9 Ruijing Dong    2022-03-02  227  
11eb648d014eb9 Ruijing Dong    2022-03-02  228  		if (amdgpu_vcnfw_log)
11eb648d014eb9 Ruijing Dong    2022-03-02  229  			amdgpu_vcn_fwlog_init(&adev->vcn.inst[i]);
cf14826cdfb5c9 Leo Liu         2019-11-15  230  	}
cf14826cdfb5c9 Leo Liu         2019-11-15  231  
1f61a43fcec1dc Jack Zhang      2020-06-29  232  	if (amdgpu_sriov_vf(adev)) {
1f61a43fcec1dc Jack Zhang      2020-06-29  233  		r = amdgpu_virt_alloc_mm_table(adev);
1f61a43fcec1dc Jack Zhang      2020-06-29  234  		if (r)
1f61a43fcec1dc Jack Zhang      2020-06-29  235  			return r;
1f61a43fcec1dc Jack Zhang      2020-06-29  236  	}
cfcc06cd15bf56 Boyuan Zhang    2020-03-27  237  	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
cfcc06cd15bf56 Boyuan Zhang    2020-03-27  238  		adev->vcn.pause_dpg_mode = vcn_v3_0_pause_dpg_mode;
cfcc06cd15bf56 Boyuan Zhang    2020-03-27  239  
cf14826cdfb5c9 Leo Liu         2019-11-15  240  	return 0;
cf14826cdfb5c9 Leo Liu         2019-11-15  241  }
cf14826cdfb5c9 Leo Liu         2019-11-15  242  

:::::: The code at line 118 was first introduced by commit
:::::: cf14826cdfb5c9fe10f98210d040b9d7486c381d drm/amdgpu: add VCN3.0 support for Sienna_Cichlid

:::::: TO: Leo Liu <leo.liu@amd.com>
:::::: CC: Alex Deucher <alexander.deucher@amd.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
