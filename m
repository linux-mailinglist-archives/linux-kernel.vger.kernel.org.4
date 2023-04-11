Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 398236DE66C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 23:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjDKV2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 17:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjDKV2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 17:28:46 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C9D10E7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 14:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681248523; x=1712784523;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=OkRr9n7IN5+gCLzREGqrv5EnTWHGCQySCekSUKKWj9g=;
  b=VQG6SNAEDcG6kGi9RwbOoFvNSGLpspj8u8xsl5LIB9jTWCU0VuWA8LNS
   /0lATwarcA/zTJDA492NjPYjknobLzyaLvCOWgVdZVWfF4A8hyNeacpD+
   73DzctLr3rJy+3/aQdTtykbsOxgN+jREgYTLMwLqVqr8YUwuIR0W9bDhm
   Dl06ud6qdF+FN9sqHv+OIm/SQjUEHs61pj53Tb56UiQhpIwZLdtvjwrJM
   bwUBnB5F3SctXNwE/SaQv9t1FyZWJjvMEb+E4IDxUMznEYr9IAbKYPMYp
   ro79Iljgc7GHPc9zivZh2e3i9pSufqoPxQj6Frj8TCHfWS3YqK7GJMZWN
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="327843447"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="327843447"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 14:28:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="832481841"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="832481841"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 11 Apr 2023 14:28:29 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pmLXQ-000Win-1d;
        Tue, 11 Apr 2023 21:28:28 +0000
Date:   Wed, 12 Apr 2023 05:27:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Graham Sider <Graham.Sider@amd.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_int_process_v11.c:282:38:
 warning: variable 'sq_int_priv' set but not used
Message-ID: <202304120540.sOOb5SKi-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Graham,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0d3eb744aed40ffce820cded61d7eac515199165
commit: 664883ddde67971d59764f2dda855183ecf8bc46 drm/amdkfd: fix dropped interrupt in kfd_int_process_v11
date:   7 months ago
config: arm64-randconfig-r003-20230409 (https://download.01.org/0day-ci/archive/20230412/202304120540.sOOb5SKi-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 2c57868e2e877f73c339796c3374ae660bb77f0d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=664883ddde67971d59764f2dda855183ecf8bc46
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 664883ddde67971d59764f2dda855183ecf8bc46
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/gpu/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304120540.sOOb5SKi-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_int_process_v11.c:282:38: warning: variable 'sq_int_priv' set but not used [-Wunused-but-set-variable]
           uint8_t sq_int_enc, sq_int_errtype, sq_int_priv;
                                               ^
   1 warning generated.


vim +/sq_int_priv +282 drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_int_process_v11.c

cc009e613de656 Mukul Joshi  2022-04-26  276  
cc009e613de656 Mukul Joshi  2022-04-26  277  static void event_interrupt_wq_v11(struct kfd_dev *dev,
cc009e613de656 Mukul Joshi  2022-04-26  278  					const uint32_t *ih_ring_entry)
cc009e613de656 Mukul Joshi  2022-04-26  279  {
cc009e613de656 Mukul Joshi  2022-04-26  280  	uint16_t source_id, client_id, ring_id, pasid, vmid;
cc009e613de656 Mukul Joshi  2022-04-26  281  	uint32_t context_id0, context_id1;
cc009e613de656 Mukul Joshi  2022-04-26 @282  	uint8_t sq_int_enc, sq_int_errtype, sq_int_priv;
cc009e613de656 Mukul Joshi  2022-04-26  283  	struct kfd_vm_fault_info info = {0};
cc009e613de656 Mukul Joshi  2022-04-26  284  	struct kfd_hsa_memory_exception_data exception_data;
cc009e613de656 Mukul Joshi  2022-04-26  285  
cc009e613de656 Mukul Joshi  2022-04-26  286  	source_id = SOC15_SOURCE_ID_FROM_IH_ENTRY(ih_ring_entry);
cc009e613de656 Mukul Joshi  2022-04-26  287  	client_id = SOC15_CLIENT_ID_FROM_IH_ENTRY(ih_ring_entry);
cc009e613de656 Mukul Joshi  2022-04-26  288  	ring_id = SOC15_RING_ID_FROM_IH_ENTRY(ih_ring_entry);
cc009e613de656 Mukul Joshi  2022-04-26  289  	pasid = SOC15_PASID_FROM_IH_ENTRY(ih_ring_entry);
cc009e613de656 Mukul Joshi  2022-04-26  290  	vmid = SOC15_VMID_FROM_IH_ENTRY(ih_ring_entry);
cc009e613de656 Mukul Joshi  2022-04-26  291  	context_id0 = SOC15_CONTEXT_ID0_FROM_IH_ENTRY(ih_ring_entry);
cc009e613de656 Mukul Joshi  2022-04-26  292  	context_id1 = SOC15_CONTEXT_ID1_FROM_IH_ENTRY(ih_ring_entry);
cc009e613de656 Mukul Joshi  2022-04-26  293  
cc009e613de656 Mukul Joshi  2022-04-26  294  	/* VMC, UTCL2 */
cc009e613de656 Mukul Joshi  2022-04-26  295  	if (client_id == SOC21_IH_CLIENTID_VMC ||
cc009e613de656 Mukul Joshi  2022-04-26  296  	     ((client_id == SOC21_IH_CLIENTID_GFX) &&
cc009e613de656 Mukul Joshi  2022-04-26  297  	     (source_id == UTCL2_1_0__SRCID__FAULT))) {
cc009e613de656 Mukul Joshi  2022-04-26  298  
cc009e613de656 Mukul Joshi  2022-04-26  299  		info.vmid = vmid;
cc009e613de656 Mukul Joshi  2022-04-26  300  		info.mc_id = client_id;
cc009e613de656 Mukul Joshi  2022-04-26  301  		info.page_addr = ih_ring_entry[4] |
cc009e613de656 Mukul Joshi  2022-04-26  302  			(uint64_t)(ih_ring_entry[5] & 0xf) << 32;
cc009e613de656 Mukul Joshi  2022-04-26  303  		info.prot_valid = ring_id & 0x08;
cc009e613de656 Mukul Joshi  2022-04-26  304  		info.prot_read  = ring_id & 0x10;
cc009e613de656 Mukul Joshi  2022-04-26  305  		info.prot_write = ring_id & 0x20;
cc009e613de656 Mukul Joshi  2022-04-26  306  
cc009e613de656 Mukul Joshi  2022-04-26  307  		memset(&exception_data, 0, sizeof(exception_data));
cc009e613de656 Mukul Joshi  2022-04-26  308  		exception_data.gpu_id = dev->id;
cc009e613de656 Mukul Joshi  2022-04-26  309  		exception_data.va = (info.page_addr) << PAGE_SHIFT;
cc009e613de656 Mukul Joshi  2022-04-26  310  		exception_data.failure.NotPresent = info.prot_valid ? 1 : 0;
cc009e613de656 Mukul Joshi  2022-04-26  311  		exception_data.failure.NoExecute = info.prot_exec ? 1 : 0;
cc009e613de656 Mukul Joshi  2022-04-26  312  		exception_data.failure.ReadOnly = info.prot_write ? 1 : 0;
cc009e613de656 Mukul Joshi  2022-04-26  313  		exception_data.failure.imprecise = 0;
cc009e613de656 Mukul Joshi  2022-04-26  314  
cc009e613de656 Mukul Joshi  2022-04-26  315  		/*kfd_set_dbg_ev_from_interrupt(dev, pasid, -1,
cc009e613de656 Mukul Joshi  2022-04-26  316  					      KFD_EC_MASK(EC_DEVICE_MEMORY_VIOLATION),
cc009e613de656 Mukul Joshi  2022-04-26  317  					      &exception_data, sizeof(exception_data));*/
cc009e613de656 Mukul Joshi  2022-04-26  318  		kfd_smi_event_update_vmfault(dev, pasid);
cc009e613de656 Mukul Joshi  2022-04-26  319  
cc009e613de656 Mukul Joshi  2022-04-26  320  	/* GRBM, SDMA, SE, PMM */
cc009e613de656 Mukul Joshi  2022-04-26  321  	} else if (client_id == SOC21_IH_CLIENTID_GRBM_CP ||
cc009e613de656 Mukul Joshi  2022-04-26  322  		   client_id == SOC21_IH_CLIENTID_GFX) {
cc009e613de656 Mukul Joshi  2022-04-26  323  
cc009e613de656 Mukul Joshi  2022-04-26  324  		/* CP */
cc009e613de656 Mukul Joshi  2022-04-26  325  		if (source_id == SOC15_INTSRC_CP_END_OF_PIPE)
cc009e613de656 Mukul Joshi  2022-04-26  326  			kfd_signal_event_interrupt(pasid, context_id0, 32);
cc009e613de656 Mukul Joshi  2022-04-26  327  		/*else if (source_id == SOC15_INTSRC_CP_BAD_OPCODE)
cc009e613de656 Mukul Joshi  2022-04-26  328  			kfd_set_dbg_ev_from_interrupt(dev, pasid,
cc009e613de656 Mukul Joshi  2022-04-26  329  				KFD_CTXID0_DOORBELL_ID(context_id0),
cc009e613de656 Mukul Joshi  2022-04-26  330  				KFD_EC_MASK(KFD_CTXID0_CP_BAD_OP_ECODE(context_id0)),
cc009e613de656 Mukul Joshi  2022-04-26  331  				NULL, 0);*/
cc009e613de656 Mukul Joshi  2022-04-26  332  
cc009e613de656 Mukul Joshi  2022-04-26  333  		/* SDMA */
cc009e613de656 Mukul Joshi  2022-04-26  334  		else if (source_id == SOC21_INTSRC_SDMA_TRAP)
cc009e613de656 Mukul Joshi  2022-04-26  335  			kfd_signal_event_interrupt(pasid, context_id0 & 0xfffffff, 28);
cc009e613de656 Mukul Joshi  2022-04-26  336  		else if (source_id == SOC21_INTSRC_SDMA_ECC) {
cc009e613de656 Mukul Joshi  2022-04-26  337  			event_interrupt_poison_consumption_v11(dev, pasid, source_id);
cc009e613de656 Mukul Joshi  2022-04-26  338  			return;
cc009e613de656 Mukul Joshi  2022-04-26  339  		}
cc009e613de656 Mukul Joshi  2022-04-26  340  
cc009e613de656 Mukul Joshi  2022-04-26  341  		/* SQ */
cc009e613de656 Mukul Joshi  2022-04-26  342  		else if (source_id == SOC15_INTSRC_SQ_INTERRUPT_MSG) {
cc009e613de656 Mukul Joshi  2022-04-26  343  			sq_int_enc = REG_GET_FIELD(context_id1,
cc009e613de656 Mukul Joshi  2022-04-26  344  					SQ_INTERRUPT_WORD_WAVE_CTXID1, ENCODING);
cc009e613de656 Mukul Joshi  2022-04-26  345  			switch (sq_int_enc) {
cc009e613de656 Mukul Joshi  2022-04-26  346  			case SQ_INTERRUPT_WORD_ENCODING_AUTO:
cc009e613de656 Mukul Joshi  2022-04-26  347  				print_sq_intr_info_auto(context_id0, context_id1);
cc009e613de656 Mukul Joshi  2022-04-26  348  				break;
cc009e613de656 Mukul Joshi  2022-04-26  349  			case SQ_INTERRUPT_WORD_ENCODING_INST:
cc009e613de656 Mukul Joshi  2022-04-26  350  				print_sq_intr_info_inst(context_id0, context_id1);
cc009e613de656 Mukul Joshi  2022-04-26  351  				sq_int_priv = REG_GET_FIELD(context_id0,
cc009e613de656 Mukul Joshi  2022-04-26  352  						SQ_INTERRUPT_WORD_WAVE_CTXID0, PRIV);
664883ddde6797 Graham Sider 2022-09-23  353  				/*if (sq_int_priv && (kfd_set_dbg_ev_from_interrupt(dev, pasid,
cc009e613de656 Mukul Joshi  2022-04-26  354  						KFD_CTXID0_DOORBELL_ID(context_id0),
cc009e613de656 Mukul Joshi  2022-04-26  355  						KFD_CTXID0_TRAP_CODE(context_id0),
664883ddde6797 Graham Sider 2022-09-23  356  						NULL, 0)))
664883ddde6797 Graham Sider 2022-09-23  357  					return;*/
cc009e613de656 Mukul Joshi  2022-04-26  358  				break;
cc009e613de656 Mukul Joshi  2022-04-26  359  			case SQ_INTERRUPT_WORD_ENCODING_ERROR:
cc009e613de656 Mukul Joshi  2022-04-26  360  				print_sq_intr_info_error(context_id0, context_id1);
cc009e613de656 Mukul Joshi  2022-04-26  361  				sq_int_errtype = REG_GET_FIELD(context_id0,
cc009e613de656 Mukul Joshi  2022-04-26  362  						SQ_INTERRUPT_WORD_ERROR_CTXID0, TYPE);
cc009e613de656 Mukul Joshi  2022-04-26  363  				if (sq_int_errtype != SQ_INTERRUPT_ERROR_TYPE_ILLEGAL_INST &&
cc009e613de656 Mukul Joshi  2022-04-26  364  				    sq_int_errtype != SQ_INTERRUPT_ERROR_TYPE_MEMVIOL) {
cc009e613de656 Mukul Joshi  2022-04-26  365  					event_interrupt_poison_consumption_v11(
cc009e613de656 Mukul Joshi  2022-04-26  366  							dev, pasid, source_id);
cc009e613de656 Mukul Joshi  2022-04-26  367  					return;
cc009e613de656 Mukul Joshi  2022-04-26  368  				}
cc009e613de656 Mukul Joshi  2022-04-26  369  				break;
cc009e613de656 Mukul Joshi  2022-04-26  370  			default:
cc009e613de656 Mukul Joshi  2022-04-26  371  				break;
cc009e613de656 Mukul Joshi  2022-04-26  372  			}
cc009e613de656 Mukul Joshi  2022-04-26  373  			kfd_signal_event_interrupt(pasid, context_id0 & 0xffffff, 24);
cc009e613de656 Mukul Joshi  2022-04-26  374  		}
cc009e613de656 Mukul Joshi  2022-04-26  375  
cc009e613de656 Mukul Joshi  2022-04-26  376  	/*} else if (KFD_IRQ_IS_FENCE(client_id, source_id)) {
cc009e613de656 Mukul Joshi  2022-04-26  377  		kfd_process_close_interrupt_drain(pasid);*/
cc009e613de656 Mukul Joshi  2022-04-26  378  	}
cc009e613de656 Mukul Joshi  2022-04-26  379  }
cc009e613de656 Mukul Joshi  2022-04-26  380  

:::::: The code at line 282 was first introduced by commit
:::::: cc009e613de6560eb499f8bc92c80a737752cb30 drm/amdkfd: Add KFD support for soc21 v3

:::::: TO: Mukul Joshi <mukul.joshi@amd.com>
:::::: CC: Alex Deucher <alexander.deucher@amd.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
