Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A77A5E7C70
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 16:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231699AbiIWOAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 10:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbiIWN76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 09:59:58 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB824198D
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 06:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663941595; x=1695477595;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=QU81H+EP+nUij7Xcg5h5fO9mrWLCyG2C8Dcmr18aQUg=;
  b=aSsDlS2EvYkr4wzslUUa+TFqhhDqXJQafytrNVbneLp4zFGNm0eI9YeO
   9mwj9oLbGhkrHLopqlbhSYI/saiBOGO5cscRCCVgdCuJZUnqL13iRStng
   ZvXa31eTngUcqFHVh5WbDIzotNrcEE15JW05QyjXHFmdMIFPrrMUoVmMM
   XKE6io8qkT1Sl+lgPDBPxtPDVN0gWt2UNq+Tft0Y2MUxoM0XcSl2G91YA
   R3Co+Md2zFvpAYfhb3GP0luyvKgIwCr13S6ffdTU1rXPqzDfBORhHnvbo
   P+sjF9DznkeuGYTUk/XjtA3MYi5AGqB8F/yYvJ9iVYBiH0t2skAPb6Ihl
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10479"; a="287713029"
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="287713029"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 06:59:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="949024612"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 23 Sep 2022 06:59:53 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1objDc-0005ho-2t;
        Fri, 23 Sep 2022 13:59:52 +0000
Date:   Fri, 23 Sep 2022 21:59:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Isaku Yamahata <isaku.yamahata@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [intel-tdx:kvm-upstream-workaround 190/314]
 arch/x86/kvm/mmu/tdp_mmu.c:787:35: sparse: sparse: incorrect type in
 argument 1 (different address spaces)
Message-ID: <202209232127.lyZdv3ep-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git kvm-upstream-workaround
head:   552dd80c48f67ca01bcdd10667e0c11efd375177
commit: 7f8c8738e7b76f16e05a5e16a194e26237c1e5bc [190/314] KVM: x86/tdp_mmu: optimize remote tlb flush
config: x86_64-randconfig-s022-20220919 (https://download.01.org/0day-ci/archive/20220923/202209232127.lyZdv3ep-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel/tdx/commit/7f8c8738e7b76f16e05a5e16a194e26237c1e5bc
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx kvm-upstream-workaround
        git checkout 7f8c8738e7b76f16e05a5e16a194e26237c1e5bc
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/kvm/ block/ drivers/acpi/ drivers/ata/ drivers/auxdisplay/ drivers/block/ drivers/comedi/ drivers/hwmon/ drivers/infiniband/core/ drivers/infiniband/hw/qib/ drivers/net/ drivers/nvme/host/ drivers/platform/x86/ drivers/rapidio/ drivers/scsi/ drivers/staging/media/av7110/ drivers/thermal/intel/int340x_thermal/ drivers/tty/ drivers/vfio/ drivers/vhost/ drivers/watchdog/ drivers/xen/ fs/crypto/ fs/ext2/ fs/ext4/ fs/fat/ fs/quota/ fs/reiserfs/ ipc/ kernel/ net/appletalk/ net/ax25/ net/bluetooth/ net/can/ net/core/ net/dccp/ net/decnet/ net/ipv4/bpfilter/ net/llc/ net/mptcp/ net/netfilter/ net/netrom/ net/qrtr/ net/rfkill/ net/rose/ net/rxrpc/ net/sctp/ net/tls/ net/x25/ security/apparmor/ sound/core/ sound/pci/asihpi/ virt/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
   arch/x86/kvm/mmu/tdp_mmu.c:662:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [usertype] *sptep @@     got unsigned long long [noderef] [usertype] __rcu * @@
   arch/x86/kvm/mmu/tdp_mmu.c:662:17: sparse:     expected unsigned long long [usertype] *sptep
   arch/x86/kvm/mmu/tdp_mmu.c:662:17: sparse:     got unsigned long long [noderef] [usertype] __rcu *
>> arch/x86/kvm/mmu/tdp_mmu.c:787:35: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [usertype] *sptep @@     got unsigned long long [noderef] [usertype] __rcu *const [usertype] sptep @@
   arch/x86/kvm/mmu/tdp_mmu.c:787:35: sparse:     expected unsigned long long [usertype] *sptep
   arch/x86/kvm/mmu/tdp_mmu.c:787:35: sparse:     got unsigned long long [noderef] [usertype] __rcu *const [usertype] sptep
   arch/x86/kvm/mmu/tdp_mmu.c:863:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [usertype] *sptep @@     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep @@
   arch/x86/kvm/mmu/tdp_mmu.c:863:9: sparse:     expected unsigned long long [usertype] *sptep
   arch/x86/kvm/mmu/tdp_mmu.c:863:9: sparse:     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep
   arch/x86/kvm/mmu/tdp_mmu.c:877:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [usertype] *sptep @@     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep @@
   arch/x86/kvm/mmu/tdp_mmu.c:877:28: sparse:     expected unsigned long long [usertype] *sptep
   arch/x86/kvm/mmu/tdp_mmu.c:877:28: sparse:     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep
   arch/x86/kvm/mmu/tdp_mmu.c:1729:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [usertype] *sptep @@     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep @@
   arch/x86/kvm/mmu/tdp_mmu.c:1729:9: sparse:     expected unsigned long long [usertype] *sptep
   arch/x86/kvm/mmu/tdp_mmu.c:1729:9: sparse:     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep
   arch/x86/kvm/mmu/tdp_mmu.c:1408:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [usertype] *sptep @@     got unsigned long long [noderef] [usertype] __rcu *[addressable] [usertype] sptep @@
   arch/x86/kvm/mmu/tdp_mmu.c:1408:17: sparse:     expected unsigned long long [usertype] *sptep
   arch/x86/kvm/mmu/tdp_mmu.c:1408:17: sparse:     got unsigned long long [noderef] [usertype] __rcu *[addressable] [usertype] sptep
   arch/x86/kvm/mmu/tdp_mmu.c:406:9: sparse: sparse: context imbalance in 'tdp_mmu_unlink_sp' - different lock contexts for basic block
   arch/x86/kvm/mmu/tdp_mmu.c:749:49: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [usertype] *sptep @@     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep @@
   arch/x86/kvm/mmu/tdp_mmu.c:749:49: sparse:     expected unsigned long long [usertype] *sptep
   arch/x86/kvm/mmu/tdp_mmu.c:749:49: sparse:     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep
   arch/x86/kvm/mmu/tdp_mmu.c:777:42: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [noderef] [usertype] __rcu *[addressable] [usertype] sptep @@     got unsigned long long [usertype] *sptep @@
   arch/x86/kvm/mmu/tdp_mmu.c:777:42: sparse:     expected unsigned long long [noderef] [usertype] __rcu *[addressable] [usertype] sptep
   arch/x86/kvm/mmu/tdp_mmu.c:777:42: sparse:     got unsigned long long [usertype] *sptep
   arch/x86/kvm/mmu/tdp_mmu.c: note: in included file (through include/linux/rculist.h, include/linux/pid.h, include/linux/sched.h, ...):
   include/linux/rcupdate.h:737:9: sparse: sparse: context imbalance in '__tdp_mmu_zap_root' - unexpected unlock
   arch/x86/kvm/mmu/tdp_mmu.c:749:49: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [usertype] *sptep @@     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep @@
   arch/x86/kvm/mmu/tdp_mmu.c:749:49: sparse:     expected unsigned long long [usertype] *sptep
   arch/x86/kvm/mmu/tdp_mmu.c:749:49: sparse:     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep
   arch/x86/kvm/mmu/tdp_mmu.c:777:42: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [noderef] [usertype] __rcu *[addressable] [usertype] sptep @@     got unsigned long long [usertype] *sptep @@
   arch/x86/kvm/mmu/tdp_mmu.c:777:42: sparse:     expected unsigned long long [noderef] [usertype] __rcu *[addressable] [usertype] sptep
   arch/x86/kvm/mmu/tdp_mmu.c:777:42: sparse:     got unsigned long long [usertype] *sptep
   arch/x86/kvm/mmu/tdp_mmu.c:749:49: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [usertype] *sptep @@     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep @@
   arch/x86/kvm/mmu/tdp_mmu.c:749:49: sparse:     expected unsigned long long [usertype] *sptep
   arch/x86/kvm/mmu/tdp_mmu.c:749:49: sparse:     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep
   arch/x86/kvm/mmu/tdp_mmu.c:777:42: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [noderef] [usertype] __rcu *[addressable] [usertype] sptep @@     got unsigned long long [usertype] *sptep @@
   arch/x86/kvm/mmu/tdp_mmu.c:777:42: sparse:     expected unsigned long long [noderef] [usertype] __rcu *[addressable] [usertype] sptep
   arch/x86/kvm/mmu/tdp_mmu.c:777:42: sparse:     got unsigned long long [usertype] *sptep
   arch/x86/kvm/mmu/tdp_mmu.c:749:49: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [usertype] *sptep @@     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep @@
   arch/x86/kvm/mmu/tdp_mmu.c:749:49: sparse:     expected unsigned long long [usertype] *sptep
   arch/x86/kvm/mmu/tdp_mmu.c:749:49: sparse:     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep
   arch/x86/kvm/mmu/tdp_mmu.c:777:42: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [noderef] [usertype] __rcu *[addressable] [usertype] sptep @@     got unsigned long long [usertype] *sptep @@
   arch/x86/kvm/mmu/tdp_mmu.c:777:42: sparse:     expected unsigned long long [noderef] [usertype] __rcu *[addressable] [usertype] sptep
   arch/x86/kvm/mmu/tdp_mmu.c:777:42: sparse:     got unsigned long long [usertype] *sptep
   arch/x86/kvm/mmu/tdp_mmu.c:749:49: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [usertype] *sptep @@     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep @@
   arch/x86/kvm/mmu/tdp_mmu.c:749:49: sparse:     expected unsigned long long [usertype] *sptep
   arch/x86/kvm/mmu/tdp_mmu.c:749:49: sparse:     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep
   arch/x86/kvm/mmu/tdp_mmu.c:777:42: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [noderef] [usertype] __rcu *[addressable] [usertype] sptep @@     got unsigned long long [usertype] *sptep @@
   arch/x86/kvm/mmu/tdp_mmu.c:777:42: sparse:     expected unsigned long long [noderef] [usertype] __rcu *[addressable] [usertype] sptep
   arch/x86/kvm/mmu/tdp_mmu.c:777:42: sparse:     got unsigned long long [usertype] *sptep
   include/linux/rcupdate.h:737:9: sparse: sparse: context imbalance in 'tdp_mmu_alloc_sp_for_split' - unexpected unlock
   arch/x86/kvm/mmu/tdp_mmu.c:749:49: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [usertype] *sptep @@     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep @@
   arch/x86/kvm/mmu/tdp_mmu.c:749:49: sparse:     expected unsigned long long [usertype] *sptep
   arch/x86/kvm/mmu/tdp_mmu.c:749:49: sparse:     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep
   arch/x86/kvm/mmu/tdp_mmu.c:777:42: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [noderef] [usertype] __rcu *[addressable] [usertype] sptep @@     got unsigned long long [usertype] *sptep @@
   arch/x86/kvm/mmu/tdp_mmu.c:777:42: sparse:     expected unsigned long long [noderef] [usertype] __rcu *[addressable] [usertype] sptep
   arch/x86/kvm/mmu/tdp_mmu.c:777:42: sparse:     got unsigned long long [usertype] *sptep
   arch/x86/kvm/mmu/tdp_mmu.c:749:49: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [usertype] *sptep @@     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep @@
   arch/x86/kvm/mmu/tdp_mmu.c:749:49: sparse:     expected unsigned long long [usertype] *sptep
   arch/x86/kvm/mmu/tdp_mmu.c:749:49: sparse:     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep
   arch/x86/kvm/mmu/tdp_mmu.c:777:42: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [noderef] [usertype] __rcu *[addressable] [usertype] sptep @@     got unsigned long long [usertype] *sptep @@
   arch/x86/kvm/mmu/tdp_mmu.c:777:42: sparse:     expected unsigned long long [noderef] [usertype] __rcu *[addressable] [usertype] sptep
   arch/x86/kvm/mmu/tdp_mmu.c:777:42: sparse:     got unsigned long long [usertype] *sptep

vim +787 arch/x86/kvm/mmu/tdp_mmu.c

   527	
   528	/**
   529	 * __handle_changed_spte - handle bookkeeping associated with an SPTE change
   530	 * @kvm: kvm instance
   531	 * @as_id: the address space of the paging structure the SPTE was a part of
   532	 * @gfn: the base GFN that was mapped by the SPTE
   533	 * @old_spte: The value of the SPTE before the change
   534	 * @new_spte: The value of the SPTE after the change
   535	 * @role: the role of the PT the SPTE is part of in the paging structure
   536	 * @shared: This operation may not be running under the exclusive use of
   537	 *	    the MMU lock and the operation must synchronize with other
   538	 *	    threads that might be modifying SPTEs.
   539	 *
   540	 * Handle bookkeeping that might result from the modification of a SPTE.
   541	 * This function must be called for all TDP SPTE modifications.
   542	 */
   543	static void __handle_changed_spte(struct kvm *kvm, int as_id, gfn_t gfn,
   544					  u64 old_spte, u64 new_spte,
   545					  union kvm_mmu_page_role role, bool shared)
   546	{
   547		bool is_private = kvm_mmu_page_role_is_private(role);
   548		int level = role.level;
   549		bool was_present = is_shadow_present_pte(old_spte);
   550		bool is_present = is_shadow_present_pte(new_spte);
   551		bool was_last = is_last_spte(old_spte, level);
   552		bool is_last = is_last_spte(new_spte, level);
   553		bool was_leaf = was_present && was_last;
   554		bool is_leaf = is_present && is_last;
   555		kvm_pfn_t old_pfn = spte_to_pfn(old_spte);
   556		kvm_pfn_t new_pfn = spte_to_pfn(new_spte);
   557		bool pfn_changed = old_pfn != new_pfn;
   558		bool was_private_zapped = is_private_zapped_spte(old_spte);
   559		bool is_private_zapped = is_private_zapped_spte(new_spte);
   560		struct kvm_spte_change change = {
   561			.gfn = gfn,
   562			.level = level,
   563			.old = {
   564				.pfn = old_pfn,
   565				.is_present = was_present,
   566				.is_last = was_last,
   567				.is_private_zapped = was_private_zapped,
   568			},
   569			.new = {
   570				.pfn = new_pfn,
   571				.is_present = is_present,
   572				.is_last = is_last,
   573				.is_private_zapped = is_private_zapped,
   574			},
   575		};
   576	
   577		WARN_ON(level > PT64_ROOT_MAX_LEVEL);
   578		WARN_ON(level < PG_LEVEL_4K);
   579		WARN_ON(gfn & (KVM_PAGES_PER_HPAGE(level) - 1));
   580		KVM_BUG_ON(kvm_is_private_gpa(kvm, gfn_to_gpa(gfn)) != is_private, kvm);
   581		KVM_BUG_ON(was_private_zapped && !is_private, kvm);
   582	
   583		/*
   584		 * If this warning were to trigger it would indicate that there was a
   585		 * missing MMU notifier or a race with some notifier handler.
   586		 * A present, leaf SPTE should never be directly replaced with another
   587		 * present leaf SPTE pointing to a different PFN. A notifier handler
   588		 * should be zapping the SPTE before the main MM's page table is
   589		 * changed, or the SPTE should be zeroed, and the TLBs flushed by the
   590		 * thread before replacement.
   591		 */
   592		if (was_leaf && is_leaf && pfn_changed) {
   593			pr_err("Invalid SPTE change: cannot replace a present leaf\n"
   594			       "SPTE with another present leaf SPTE mapping a\n"
   595			       "different PFN!\n"
   596			       "as_id: %d gfn: %llx old_spte: %llx new_spte: %llx level: %d",
   597			       as_id, gfn, old_spte, new_spte, level);
   598	
   599			/*
   600			 * Crash the host to prevent error propagation and guest data
   601			 * corruption.
   602			 */
   603			BUG();
   604		}
   605	
   606		if (old_spte == new_spte)
   607			return;
   608	
   609		trace_kvm_tdp_mmu_spte_changed(as_id, gfn, level, old_spte, new_spte);
   610	
   611		if (is_leaf)
   612			check_spte_writable_invariants(new_spte);
   613	
   614		if (was_private_zapped) {
   615			KVM_BUG_ON(is_private_zapped, kvm);
   616			static_call(kvm_x86_handle_private_zapped_spte)(kvm, &change);
   617			/* Temporarily blocked private SPTE can only be leaf. */
   618			KVM_BUG_ON(!is_last_spte(old_spte, level), kvm);
   619			return;
   620		}
   621	
   622		/*
   623		 * The only times a SPTE should be changed from a non-present to
   624		 * non-present state is when an MMIO entry is installed/modified/
   625		 * removed. In that case, there is nothing to do here.
   626		 */
   627		if (!was_present && !is_present) {
   628			/*
   629			 * If this change does not involve a MMIO SPTE or removed SPTE,
   630			 * it is unexpected. Log the change, though it should not
   631			 * impact the guest since both the former and current SPTEs
   632			 * are nonpresent.
   633			 */
   634			if (WARN_ON(!is_mmio_spte(kvm, old_spte) &&
   635				    !is_mmio_spte(kvm, new_spte) &&
   636				    !is_removed_spte(new_spte)))
   637				pr_err("Unexpected SPTE change! Nonpresent SPTEs\n"
   638				       "should not be replaced with another,\n"
   639				       "different nonpresent SPTE, unless one or both\n"
   640				       "are MMIO SPTEs, or the new SPTE is\n"
   641				       "a temporary removed SPTE.\n"
   642				       "as_id: %d gfn: %llx old_spte: %llx new_spte: %llx level: %d",
   643				       as_id, gfn, old_spte, new_spte, level);
   644			return;
   645		}
   646	
   647		if (is_leaf != was_leaf)
   648			kvm_update_page_stats(kvm, level, is_leaf ? 1 : -1);
   649	
   650		if (was_leaf && is_dirty_spte(old_spte) &&
   651		    (!is_present || !is_dirty_spte(new_spte) || pfn_changed))
   652			kvm_set_pfn_dirty(old_pfn);
   653	
   654		/*
   655		 * Recursively handle child PTs if the change removed a subtree from
   656		 * the paging structure.  Note the WARN on the PFN changing without the
   657		 * SPTE being converted to a hugepage (leaf) or being zapped.  Shadow
   658		 * pages are kernel allocations and should never be migrated.
   659		 */
   660		if (was_present && !was_leaf &&
   661		    (is_leaf || !is_present || WARN_ON_ONCE(pfn_changed))) {
 > 662			KVM_BUG_ON(is_private != is_private_sptep(spte_to_child_pt(old_spte, level)),
   663				   kvm);
   664			handle_removed_pt(kvm, spte_to_child_pt(old_spte, level), shared);
   665		}
   666	
   667		/*
   668		 * Special handling for the private mapping.  We are either
   669		 * setting up new mapping at middle level page table, or leaf,
   670		 * or tearing down existing mapping.
   671		 *
   672		 * This is after handling lower page table by above
   673		 * handle_remove_tdp_mmu_page().  S-EPT requires to remove S-EPT tables
   674		 * after removing childrens.
   675		 */
   676		if (is_private &&
   677		    /* Ignore change of software only bits. e.g. host_writable */
   678		    (was_leaf != is_leaf || was_present != is_present || pfn_changed ||
   679		     was_private_zapped != is_private_zapped)) {
   680			void *private_spt = NULL;
   681	
   682			if (is_present && !is_leaf) {
   683				struct kvm_mmu_page *sp = to_shadow_page(pfn_to_hpa(new_pfn));
   684	
   685				private_spt = kvm_mmu_private_spt(sp);
   686				KVM_BUG_ON(!private_spt, kvm);
   687				KVM_BUG_ON(sp->role.level + 1 != level, kvm);
   688				KVM_BUG_ON(sp->gfn != gfn, kvm);
   689			}
   690			change.private_spt = private_spt;
   691	
   692			KVM_BUG_ON(was_private_zapped && is_private_zapped, kvm);
   693			/*
   694			 * When write lock is held, leaf pte should be zapping or
   695			 * prohibiting.  Not directly was_present=1 -> zero EPT entry.
   696			 */
   697			KVM_BUG_ON(!shared && is_leaf && !is_private_zapped, kvm);
   698			static_call(kvm_x86_handle_changed_private_spte)(kvm, &change);
   699		}
   700	}
   701	
   702	static void handle_changed_spte(struct kvm *kvm, int as_id, gfn_t gfn,
   703					u64 old_spte, u64 new_spte,
   704					union kvm_mmu_page_role role, bool shared)
   705	{
   706		__handle_changed_spte(kvm, as_id, gfn, old_spte, new_spte, role, shared);
   707		handle_changed_spte_acc_track(old_spte, new_spte, role.level);
   708		handle_changed_spte_dirty_log(kvm, as_id, gfn, old_spte,
   709					      new_spte, role.level);
   710	}
   711	
   712	/*
   713	 * tdp_mmu_set_spte_atomic - Set a TDP MMU SPTE atomically
   714	 * and handle the associated bookkeeping.  Do not mark the page dirty
   715	 * in KVM's dirty bitmaps.
   716	 *
   717	 * If setting the SPTE fails because it has changed, iter->old_spte will be
   718	 * refreshed to the current value of the spte.
   719	 *
   720	 * @kvm: kvm instance
   721	 * @iter: a tdp_iter instance currently on the SPTE that should be set
   722	 * @new_spte: The value the SPTE should be set to
   723	 * Return:
   724	 * * 0      - If the SPTE was set.
   725	 * * -EBUSY - If the SPTE cannot be set. In this case this function will have
   726	 *            no side-effects other than setting iter->old_spte to the last
   727	 *            known value of the spte.
   728	 */
   729	static inline int tdp_mmu_set_spte_atomic(struct kvm *kvm,
   730						  struct tdp_iter *iter,
   731						  u64 new_spte)
   732	{
   733		/*
   734		 * For conventional page table, the update flow is
   735		 * - update STPE with atomic operation
   736		 * - handle changed SPTE. __handle_changed_spte()
   737		 * NOTE: __handle_changed_spte() (and functions) must be safe against
   738		 * concurrent update.  It is an exception to zap SPTE.  See
   739		 * tdp_mmu_zap_spte_atomic().
   740		 *
   741		 * For private page table, callbacks are needed to propagate SPTE
   742		 * change into the protected page table.  In order to atomically update
   743		 * both the SPTE and the protected page tables with callbacks, utilize
   744		 * freezing SPTE.
   745		 * - Freeze the SPTE. Set entry to REMOVED_SPTE.
   746		 * - Trigger callbacks for protected page tables. __handle_changed_spte()
   747		 * - Unfreeze the SPTE.  Set the entry to new_spte.
   748		 */
   749		bool freeze_spte = is_private_sptep(iter->sptep) && !is_removed_spte(new_spte);
   750		u64 tmp_spte = freeze_spte ? REMOVED_SPTE : new_spte;
   751		u64 *sptep = rcu_dereference(iter->sptep);
   752	
   753		KVM_BUG_ON(iter->yielded, kvm);
   754	
   755		/*
   756		 * The caller is responsible for ensuring the old SPTE is not a REMOVED
   757		 * SPTE.  KVM should never attempt to zap or manipulate a REMOVED SPTE,
   758		 * and pre-checking before inserting a new SPTE is advantageous as it
   759		 * avoids unnecessary work.
   760		 */
   761		WARN_ON_ONCE(iter->yielded || is_removed_spte(iter->old_spte));
   762	
   763		lockdep_assert_held_read(&kvm->mmu_lock);
   764	
   765		/*
   766		 * Note, fast_pf_fix_direct_spte() can also modify TDP MMU SPTEs and
   767		 * does not hold the mmu_lock.
   768		 */
   769		if (!try_cmpxchg64(sptep, &iter->old_spte, tmp_spte))
   770			return -EBUSY;
   771	
   772		__handle_changed_spte(kvm, iter->as_id, iter->gfn, iter->old_spte,
   773				      new_spte, sptep_to_sp(sptep)->role, true);
   774		handle_changed_spte_acc_track(iter->old_spte, new_spte, iter->level);
   775	
   776		if (freeze_spte)
   777			__kvm_tdp_mmu_write_spte(sptep, new_spte);
   778	
   779		return 0;
   780	}
   781	
   782	static u64 private_zapped_spte(struct kvm *kvm, const struct tdp_iter *iter)
   783	{
   784		if (!kvm_gfn_shared_mask(kvm))
   785			return SHADOW_NONPRESENT_VALUE;
   786	
 > 787		if (!is_private_sptep(iter->sptep))
   788			return SHADOW_NONPRESENT_VALUE;
   789	
   790		return SHADOW_NONPRESENT_VALUE | SPTE_PRIVATE_ZAPPED |
   791			(spte_to_pfn(iter->old_spte) << PAGE_SHIFT) |
   792			(is_large_pte(iter->old_spte) ? PT_PAGE_SIZE_MASK : 0);
   793	}
   794	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
