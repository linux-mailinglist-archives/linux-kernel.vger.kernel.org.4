Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5315F5E7219
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 04:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbiIWCs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 22:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231761AbiIWCsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 22:48:38 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A20BF11ADD1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 19:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663901316; x=1695437316;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=bB1cciStgnMHR693ECVb6gPvsL68t0ZcDo3tzvnoxF4=;
  b=BHSKTn+kQpjOS9fwRkSzBYElAG6exc4oro72ph42Nlh4+Di8Z5pruHvV
   GxAY27NPDPDrjoN0tSUuYb9NLmnKYybkOG5wd17Lqx8Vz0tYKT7oOrQeT
   pO/RMrZCpeWTfa14PLw4wJVuGPkITRjZxy3+1fgVDSAPKjawvav+MV/k3
   guJpsxoRr/fJGUTpziHNo+Wd0fwfcxXheq3NaHgeu79uhszC3FFaun6nT
   sGk5/Q8ejUPWGM40mg6aRJ6kKM5WK0MaCT1pQ8jw5rLxJwFqjqKaEUUwQ
   8BGcg+rTZjSsvqPvdNlw8KEKqCKOjQsN6gqcijf4s4XWHUusQKW8giUnk
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="326822280"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="326822280"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 19:48:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="620055051"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 22 Sep 2022 19:48:28 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1obYjr-0005F3-22;
        Fri, 23 Sep 2022 02:48:27 +0000
Date:   Fri, 23 Sep 2022 10:48:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Isaku Yamahata <isaku.yamahata@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Kai Huang <kai.huang@intel.com>
Subject: [intel-tdx:kvm-upstream-workaround 72/314]
 arch/x86/kvm/mmu/tdp_mmu.c:641:17: sparse: sparse: incorrect type in
 argument 1 (different address spaces)
Message-ID: <202209231020.JqNL1bVY-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git kvm-upstream-workaround
head:   552dd80c48f67ca01bcdd10667e0c11efd375177
commit: e31d260a88d02b51769ca56edd75a84f2d2cbf97 [72/314] KVM: x86/tdp_mmu: Support TDX private mapping for TDP MMU
config: x86_64-randconfig-s022-20220919 (https://download.01.org/0day-ci/archive/20220923/202209231020.JqNL1bVY-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel/tdx/commit/e31d260a88d02b51769ca56edd75a84f2d2cbf97
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx kvm-upstream-workaround
        git checkout e31d260a88d02b51769ca56edd75a84f2d2cbf97
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/kvm/ block/ drivers/acpi/ drivers/ata/ drivers/auxdisplay/ drivers/block/ drivers/comedi/ drivers/hwmon/ drivers/infiniband/core/ drivers/infiniband/hw/qib/ drivers/net/ drivers/nvme/host/ drivers/platform/x86/ drivers/rapidio/ drivers/scsi/ drivers/staging/media/av7110/ drivers/thermal/intel/int340x_thermal/ drivers/tty/ drivers/vfio/ drivers/vhost/ drivers/watchdog/ drivers/xen/ fs/crypto/ fs/ext2/ fs/ext4/ fs/fat/ fs/quota/ fs/reiserfs/ ipc/ kernel/ net/appletalk/ net/ax25/ net/bluetooth/ net/can/ net/core/ net/dccp/ net/decnet/ net/ipv4/bpfilter/ net/llc/ net/mptcp/ net/netfilter/ net/netrom/ net/qrtr/ net/rfkill/ net/rose/ net/rxrpc/ net/sctp/ net/tls/ net/x25/ security/apparmor/ sound/core/ sound/pci/asihpi/ virt/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> arch/x86/kvm/mmu/tdp_mmu.c:641:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [usertype] *sptep @@     got unsigned long long [noderef] [usertype] __rcu * @@
   arch/x86/kvm/mmu/tdp_mmu.c:641:17: sparse:     expected unsigned long long [usertype] *sptep
   arch/x86/kvm/mmu/tdp_mmu.c:641:17: sparse:     got unsigned long long [noderef] [usertype] __rcu *
>> arch/x86/kvm/mmu/tdp_mmu.c:833:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [usertype] *sptep @@     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep @@
   arch/x86/kvm/mmu/tdp_mmu.c:833:28: sparse:     expected unsigned long long [usertype] *sptep
   arch/x86/kvm/mmu/tdp_mmu.c:833:28: sparse:     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep
>> arch/x86/kvm/mmu/tdp_mmu.c:1341:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [usertype] *sptep @@     got unsigned long long [noderef] [usertype] __rcu *[addressable] [usertype] sptep @@
   arch/x86/kvm/mmu/tdp_mmu.c:1341:25: sparse:     expected unsigned long long [usertype] *sptep
   arch/x86/kvm/mmu/tdp_mmu.c:1341:25: sparse:     got unsigned long long [noderef] [usertype] __rcu *[addressable] [usertype] sptep
   arch/x86/kvm/mmu/tdp_mmu.c:1606:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [usertype] *sptep @@     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep @@
   arch/x86/kvm/mmu/tdp_mmu.c:1606:9: sparse:     expected unsigned long long [usertype] *sptep
   arch/x86/kvm/mmu/tdp_mmu.c:1606:9: sparse:     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep
   arch/x86/kvm/mmu/tdp_mmu.c:406:9: sparse: sparse: context imbalance in 'tdp_mmu_unlink_sp' - different lock contexts for basic block
   arch/x86/kvm/mmu/tdp_mmu.c:721:49: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [usertype] *sptep @@     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep @@
   arch/x86/kvm/mmu/tdp_mmu.c:721:49: sparse:     expected unsigned long long [usertype] *sptep
   arch/x86/kvm/mmu/tdp_mmu.c:721:49: sparse:     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep
>> arch/x86/kvm/mmu/tdp_mmu.c:747:42: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [noderef] [usertype] __rcu *[addressable] [usertype] sptep @@     got unsigned long long [usertype] *sptep @@
   arch/x86/kvm/mmu/tdp_mmu.c:747:42: sparse:     expected unsigned long long [noderef] [usertype] __rcu *[addressable] [usertype] sptep
   arch/x86/kvm/mmu/tdp_mmu.c:747:42: sparse:     got unsigned long long [usertype] *sptep
   arch/x86/kvm/mmu/tdp_mmu.c: note: in included file (through include/linux/rculist.h, include/linux/pid.h, include/linux/sched.h, ...):
   include/linux/rcupdate.h:737:9: sparse: sparse: context imbalance in '__tdp_mmu_zap_root' - unexpected unlock
   arch/x86/kvm/mmu/tdp_mmu.c:721:49: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [usertype] *sptep @@     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep @@
   arch/x86/kvm/mmu/tdp_mmu.c:721:49: sparse:     expected unsigned long long [usertype] *sptep
   arch/x86/kvm/mmu/tdp_mmu.c:721:49: sparse:     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep
>> arch/x86/kvm/mmu/tdp_mmu.c:747:42: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [noderef] [usertype] __rcu *[addressable] [usertype] sptep @@     got unsigned long long [usertype] *sptep @@
   arch/x86/kvm/mmu/tdp_mmu.c:747:42: sparse:     expected unsigned long long [noderef] [usertype] __rcu *[addressable] [usertype] sptep
   arch/x86/kvm/mmu/tdp_mmu.c:747:42: sparse:     got unsigned long long [usertype] *sptep
   arch/x86/kvm/mmu/tdp_mmu.c:721:49: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [usertype] *sptep @@     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep @@
   arch/x86/kvm/mmu/tdp_mmu.c:721:49: sparse:     expected unsigned long long [usertype] *sptep
   arch/x86/kvm/mmu/tdp_mmu.c:721:49: sparse:     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep
>> arch/x86/kvm/mmu/tdp_mmu.c:747:42: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [noderef] [usertype] __rcu *[addressable] [usertype] sptep @@     got unsigned long long [usertype] *sptep @@
   arch/x86/kvm/mmu/tdp_mmu.c:747:42: sparse:     expected unsigned long long [noderef] [usertype] __rcu *[addressable] [usertype] sptep
   arch/x86/kvm/mmu/tdp_mmu.c:747:42: sparse:     got unsigned long long [usertype] *sptep
   arch/x86/kvm/mmu/tdp_mmu.c:721:49: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [usertype] *sptep @@     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep @@
   arch/x86/kvm/mmu/tdp_mmu.c:721:49: sparse:     expected unsigned long long [usertype] *sptep
   arch/x86/kvm/mmu/tdp_mmu.c:721:49: sparse:     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep
>> arch/x86/kvm/mmu/tdp_mmu.c:747:42: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [noderef] [usertype] __rcu *[addressable] [usertype] sptep @@     got unsigned long long [usertype] *sptep @@
   arch/x86/kvm/mmu/tdp_mmu.c:747:42: sparse:     expected unsigned long long [noderef] [usertype] __rcu *[addressable] [usertype] sptep
   arch/x86/kvm/mmu/tdp_mmu.c:747:42: sparse:     got unsigned long long [usertype] *sptep
   arch/x86/kvm/mmu/tdp_mmu.c:721:49: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [usertype] *sptep @@     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep @@
   arch/x86/kvm/mmu/tdp_mmu.c:721:49: sparse:     expected unsigned long long [usertype] *sptep
   arch/x86/kvm/mmu/tdp_mmu.c:721:49: sparse:     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep
>> arch/x86/kvm/mmu/tdp_mmu.c:747:42: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [noderef] [usertype] __rcu *[addressable] [usertype] sptep @@     got unsigned long long [usertype] *sptep @@
   arch/x86/kvm/mmu/tdp_mmu.c:747:42: sparse:     expected unsigned long long [noderef] [usertype] __rcu *[addressable] [usertype] sptep
   arch/x86/kvm/mmu/tdp_mmu.c:747:42: sparse:     got unsigned long long [usertype] *sptep
   include/linux/rcupdate.h:737:9: sparse: sparse: context imbalance in 'tdp_mmu_alloc_sp_for_split' - unexpected unlock
   arch/x86/kvm/mmu/tdp_mmu.c:721:49: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [usertype] *sptep @@     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep @@
   arch/x86/kvm/mmu/tdp_mmu.c:721:49: sparse:     expected unsigned long long [usertype] *sptep
   arch/x86/kvm/mmu/tdp_mmu.c:721:49: sparse:     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep
>> arch/x86/kvm/mmu/tdp_mmu.c:747:42: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [noderef] [usertype] __rcu *[addressable] [usertype] sptep @@     got unsigned long long [usertype] *sptep @@
   arch/x86/kvm/mmu/tdp_mmu.c:747:42: sparse:     expected unsigned long long [noderef] [usertype] __rcu *[addressable] [usertype] sptep
   arch/x86/kvm/mmu/tdp_mmu.c:747:42: sparse:     got unsigned long long [usertype] *sptep
   arch/x86/kvm/mmu/tdp_mmu.c:721:49: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [usertype] *sptep @@     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep @@
   arch/x86/kvm/mmu/tdp_mmu.c:721:49: sparse:     expected unsigned long long [usertype] *sptep
   arch/x86/kvm/mmu/tdp_mmu.c:721:49: sparse:     got unsigned long long [noderef] [usertype] __rcu *[usertype] sptep
>> arch/x86/kvm/mmu/tdp_mmu.c:747:42: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long [noderef] [usertype] __rcu *[addressable] [usertype] sptep @@     got unsigned long long [usertype] *sptep @@
   arch/x86/kvm/mmu/tdp_mmu.c:747:42: sparse:     expected unsigned long long [noderef] [usertype] __rcu *[addressable] [usertype] sptep
   arch/x86/kvm/mmu/tdp_mmu.c:747:42: sparse:     got unsigned long long [usertype] *sptep

vim +641 arch/x86/kvm/mmu/tdp_mmu.c

   520	
   521	/**
   522	 * __handle_changed_spte - handle bookkeeping associated with an SPTE change
   523	 * @kvm: kvm instance
   524	 * @as_id: the address space of the paging structure the SPTE was a part of
   525	 * @gfn: the base GFN that was mapped by the SPTE
   526	 * @old_spte: The value of the SPTE before the change
   527	 * @new_spte: The value of the SPTE after the change
   528	 * @role: the role of the PT the SPTE is part of in the paging structure
   529	 * @shared: This operation may not be running under the exclusive use of
   530	 *	    the MMU lock and the operation must synchronize with other
   531	 *	    threads that might be modifying SPTEs.
   532	 *
   533	 * Handle bookkeeping that might result from the modification of a SPTE.
   534	 * This function must be called for all TDP SPTE modifications.
   535	 */
   536	static void __handle_changed_spte(struct kvm *kvm, int as_id, gfn_t gfn,
   537					  u64 old_spte, u64 new_spte,
   538					  union kvm_mmu_page_role role, bool shared)
   539	{
   540		bool is_private = kvm_mmu_page_role_is_private(role);
   541		int level = role.level;
   542		bool was_present = is_shadow_present_pte(old_spte);
   543		bool is_present = is_shadow_present_pte(new_spte);
   544		bool was_last = is_last_spte(old_spte, level);
   545		bool is_last = is_last_spte(new_spte, level);
   546		bool was_leaf = was_present && was_last;
   547		bool is_leaf = is_present && is_last;
   548		kvm_pfn_t old_pfn = spte_to_pfn(old_spte);
   549		kvm_pfn_t new_pfn = spte_to_pfn(new_spte);
   550		bool pfn_changed = old_pfn != new_pfn;
   551		struct kvm_spte_change change = {
   552			.gfn = gfn,
   553			.level = level,
   554			.old = {
   555				.pfn = old_pfn,
   556				.is_present = was_present,
   557				.is_last = was_last,
   558			},
   559			.new = {
   560				.pfn = new_pfn,
   561				.is_present = is_present,
   562				.is_last = is_last,
   563			},
   564		};
   565	
   566		WARN_ON(level > PT64_ROOT_MAX_LEVEL);
   567		WARN_ON(level < PG_LEVEL_4K);
   568		WARN_ON(gfn & (KVM_PAGES_PER_HPAGE(level) - 1));
   569	
   570		/*
   571		 * If this warning were to trigger it would indicate that there was a
   572		 * missing MMU notifier or a race with some notifier handler.
   573		 * A present, leaf SPTE should never be directly replaced with another
   574		 * present leaf SPTE pointing to a different PFN. A notifier handler
   575		 * should be zapping the SPTE before the main MM's page table is
   576		 * changed, or the SPTE should be zeroed, and the TLBs flushed by the
   577		 * thread before replacement.
   578		 */
   579		if (was_leaf && is_leaf && pfn_changed) {
   580			pr_err("Invalid SPTE change: cannot replace a present leaf\n"
   581			       "SPTE with another present leaf SPTE mapping a\n"
   582			       "different PFN!\n"
   583			       "as_id: %d gfn: %llx old_spte: %llx new_spte: %llx level: %d",
   584			       as_id, gfn, old_spte, new_spte, level);
   585	
   586			/*
   587			 * Crash the host to prevent error propagation and guest data
   588			 * corruption.
   589			 */
   590			BUG();
   591		}
   592	
   593		if (old_spte == new_spte)
   594			return;
   595	
   596		trace_kvm_tdp_mmu_spte_changed(as_id, gfn, level, old_spte, new_spte);
   597	
   598		if (is_leaf)
   599			check_spte_writable_invariants(new_spte);
   600	
   601		/*
   602		 * The only times a SPTE should be changed from a non-present to
   603		 * non-present state is when an MMIO entry is installed/modified/
   604		 * removed. In that case, there is nothing to do here.
   605		 */
   606		if (!was_present && !is_present) {
   607			/*
   608			 * If this change does not involve a MMIO SPTE or removed SPTE,
   609			 * it is unexpected. Log the change, though it should not
   610			 * impact the guest since both the former and current SPTEs
   611			 * are nonpresent.
   612			 */
   613			if (WARN_ON(!is_mmio_spte(kvm, old_spte) &&
   614				    !is_mmio_spte(kvm, new_spte) &&
   615				    !is_removed_spte(new_spte)))
   616				pr_err("Unexpected SPTE change! Nonpresent SPTEs\n"
   617				       "should not be replaced with another,\n"
   618				       "different nonpresent SPTE, unless one or both\n"
   619				       "are MMIO SPTEs, or the new SPTE is\n"
   620				       "a temporary removed SPTE.\n"
   621				       "as_id: %d gfn: %llx old_spte: %llx new_spte: %llx level: %d",
   622				       as_id, gfn, old_spte, new_spte, level);
   623			return;
   624		}
   625	
   626		if (is_leaf != was_leaf)
   627			kvm_update_page_stats(kvm, level, is_leaf ? 1 : -1);
   628	
   629		if (was_leaf && is_dirty_spte(old_spte) &&
   630		    (!is_present || !is_dirty_spte(new_spte) || pfn_changed))
   631			kvm_set_pfn_dirty(old_pfn);
   632	
   633		/*
   634		 * Recursively handle child PTs if the change removed a subtree from
   635		 * the paging structure.  Note the WARN on the PFN changing without the
   636		 * SPTE being converted to a hugepage (leaf) or being zapped.  Shadow
   637		 * pages are kernel allocations and should never be migrated.
   638		 */
   639		if (was_present && !was_leaf &&
   640		    (is_leaf || !is_present || WARN_ON_ONCE(pfn_changed))) {
 > 641			KVM_BUG_ON(is_private != is_private_sptep(spte_to_child_pt(old_spte, level)),
   642				   kvm);
   643			handle_removed_pt(kvm, spte_to_child_pt(old_spte, level), shared);
   644		}
   645	
   646		/*
   647		 * Special handling for the private mapping.  We are either
   648		 * setting up new mapping at middle level page table, or leaf,
   649		 * or tearing down existing mapping.
   650		 *
   651		 * This is after handling lower page table by above
   652		 * handle_remove_tdp_mmu_page().  S-EPT requires to remove S-EPT tables
   653		 * after removing childrens.
   654		 */
   655		if (is_private &&
   656		    /* Ignore change of software only bits. e.g. host_writable */
   657		    (was_leaf != is_leaf || was_present != is_present || pfn_changed)) {
   658			void *private_spt = NULL;
   659	
   660			if (is_present && !is_leaf) {
   661				struct kvm_mmu_page *sp = to_shadow_page(pfn_to_hpa(new_pfn));
   662	
   663				private_spt = kvm_mmu_private_spt(sp);
   664				KVM_BUG_ON(!private_spt, kvm);
   665				KVM_BUG_ON(sp->role.level + 1 != level, kvm);
   666				KVM_BUG_ON(sp->gfn != gfn, kvm);
   667			}
   668			change.private_spt = private_spt;
   669	
   670			static_call(kvm_x86_handle_changed_private_spte)(kvm, &change);
   671		}
   672	}
   673	
   674	static void handle_changed_spte(struct kvm *kvm, int as_id, gfn_t gfn,
   675					u64 old_spte, u64 new_spte,
   676					union kvm_mmu_page_role role, bool shared)
   677	{
   678		__handle_changed_spte(kvm, as_id, gfn, old_spte, new_spte, role, shared);
   679		handle_changed_spte_acc_track(old_spte, new_spte, role.level);
   680		handle_changed_spte_dirty_log(kvm, as_id, gfn, old_spte,
   681					      new_spte, role.level);
   682	}
   683	
   684	/*
   685	 * tdp_mmu_set_spte_atomic - Set a TDP MMU SPTE atomically
   686	 * and handle the associated bookkeeping.  Do not mark the page dirty
   687	 * in KVM's dirty bitmaps.
   688	 *
   689	 * If setting the SPTE fails because it has changed, iter->old_spte will be
   690	 * refreshed to the current value of the spte.
   691	 *
   692	 * @kvm: kvm instance
   693	 * @iter: a tdp_iter instance currently on the SPTE that should be set
   694	 * @new_spte: The value the SPTE should be set to
   695	 * Return:
   696	 * * 0      - If the SPTE was set.
   697	 * * -EBUSY - If the SPTE cannot be set. In this case this function will have
   698	 *            no side-effects other than setting iter->old_spte to the last
   699	 *            known value of the spte.
   700	 */
   701	static inline int tdp_mmu_set_spte_atomic(struct kvm *kvm,
   702						  struct tdp_iter *iter,
   703						  u64 new_spte)
   704	{
   705		/*
   706		 * For conventional page table, the update flow is
   707		 * - update STPE with atomic operation
   708		 * - handle changed SPTE. __handle_changed_spte()
   709		 * NOTE: __handle_changed_spte() (and functions) must be safe against
   710		 * concurrent update.  It is an exception to zap SPTE.  See
   711		 * tdp_mmu_zap_spte_atomic().
   712		 *
   713		 * For private page table, callbacks are needed to propagate SPTE
   714		 * change into the protected page table.  In order to atomically update
   715		 * both the SPTE and the protected page tables with callbacks, utilize
   716		 * freezing SPTE.
   717		 * - Freeze the SPTE. Set entry to REMOVED_SPTE.
   718		 * - Trigger callbacks for protected page tables. __handle_changed_spte()
   719		 * - Unfreeze the SPTE.  Set the entry to new_spte.
   720		 */
   721		bool freeze_spte = is_private_sptep(iter->sptep) && !is_removed_spte(new_spte);
   722		u64 tmp_spte = freeze_spte ? REMOVED_SPTE : new_spte;
   723		u64 *sptep = rcu_dereference(iter->sptep);
   724	
   725		/*
   726		 * The caller is responsible for ensuring the old SPTE is not a REMOVED
   727		 * SPTE.  KVM should never attempt to zap or manipulate a REMOVED SPTE,
   728		 * and pre-checking before inserting a new SPTE is advantageous as it
   729		 * avoids unnecessary work.
   730		 */
   731		WARN_ON_ONCE(iter->yielded || is_removed_spte(iter->old_spte));
   732	
   733		lockdep_assert_held_read(&kvm->mmu_lock);
   734	
   735		/*
   736		 * Note, fast_pf_fix_direct_spte() can also modify TDP MMU SPTEs and
   737		 * does not hold the mmu_lock.
   738		 */
   739		if (!try_cmpxchg64(sptep, &iter->old_spte, tmp_spte))
   740			return -EBUSY;
   741	
   742		__handle_changed_spte(kvm, iter->as_id, iter->gfn, iter->old_spte,
   743				      new_spte, sptep_to_sp(sptep)->role, true);
   744		handle_changed_spte_acc_track(iter->old_spte, new_spte, iter->level);
   745	
   746		if (freeze_spte)
 > 747			__kvm_tdp_mmu_write_spte(sptep, new_spte);
   748	
   749		return 0;
   750	}
   751	
   752	static inline int tdp_mmu_zap_spte_atomic(struct kvm *kvm,
   753						  struct tdp_iter *iter)
   754	{
   755		int ret;
   756	
   757		/*
   758		 * Freeze the SPTE by setting it to a special,
   759		 * non-present value. This will stop other threads from
   760		 * immediately installing a present entry in its place
   761		 * before the TLBs are flushed.
   762		 */
   763		ret = tdp_mmu_set_spte_atomic(kvm, iter, REMOVED_SPTE);
   764		if (ret)
   765			return ret;
   766	
   767		kvm_flush_remote_tlbs_with_address(kvm, iter->gfn,
   768						   KVM_PAGES_PER_HPAGE(iter->level));
   769	
   770		/*
   771		 * No other thread can overwrite the removed SPTE as they must either
   772		 * wait on the MMU lock or use tdp_mmu_set_spte_atomic() which will not
   773		 * overwrite the special removed SPTE value. No bookkeeping is needed
   774		 * here since the SPTE is going from non-present to non-present.  Use
   775		 * the raw write helper to avoid an unnecessary check on volatile bits.
   776		 *
   777		 * Set non-present value to SHADOW_NONPRESENT_VALUE, rather than 0.
   778		 * It is because when TDX is enabled, TDX module always
   779		 * enables "EPT-violation #VE", so KVM needs to set
   780		 * "suppress #VE" bit in EPT table entries, in order to get
   781		 * real EPT violation, rather than TDVMCALL.  KVM sets
   782		 * SHADOW_NONPRESENT_VALUE (which sets "suppress #VE" bit) so it
   783		 * can be set when EPT table entries are zapped.
   784		 */
   785		__kvm_tdp_mmu_write_spte(iter->sptep, SHADOW_NONPRESENT_VALUE);
   786	
   787		return 0;
   788	}
   789	
   790	
   791	/*
   792	 * __tdp_mmu_set_spte - Set a TDP MMU SPTE and handle the associated bookkeeping
   793	 * @kvm:	      KVM instance
   794	 * @as_id:	      Address space ID, i.e. regular vs. SMM
   795	 * @sptep:	      Pointer to the SPTE
   796	 * @old_spte:	      The current value of the SPTE
   797	 * @new_spte:	      The new value that will be set for the SPTE
   798	 * @gfn:	      The base GFN that was (or will be) mapped by the SPTE
   799	 * @level:	      The level _containing_ the SPTE (its parent PT's level)
   800	 * @record_acc_track: Notify the MM subsystem of changes to the accessed state
   801	 *		      of the page. Should be set unless handling an MMU
   802	 *		      notifier for access tracking. Leaving record_acc_track
   803	 *		      unset in that case prevents page accesses from being
   804	 *		      double counted.
   805	 * @record_dirty_log: Record the page as dirty in the dirty bitmap if
   806	 *		      appropriate for the change being made. Should be set
   807	 *		      unless performing certain dirty logging operations.
   808	 *		      Leaving record_dirty_log unset in that case prevents page
   809	 *		      writes from being double counted.
   810	 *
   811	 * Returns the old SPTE value, which _may_ be different than @old_spte if the
   812	 * SPTE had voldatile bits.
   813	 */
   814	static u64 __tdp_mmu_set_spte(struct kvm *kvm, int as_id, tdp_ptep_t sptep,
   815				       u64 old_spte, u64 new_spte, gfn_t gfn, int level,
   816				       bool record_acc_track, bool record_dirty_log)
   817	{
   818		union kvm_mmu_page_role role;
   819	
   820		lockdep_assert_held_write(&kvm->mmu_lock);
   821	
   822		/*
   823		 * No thread should be using this function to set SPTEs to or from the
   824		 * temporary removed SPTE value.
   825		 * If operating under the MMU lock in read mode, tdp_mmu_set_spte_atomic
   826		 * should be used. If operating under the MMU lock in write mode, the
   827		 * use of the removed SPTE should not be necessary.
   828		 */
   829		WARN_ON(is_removed_spte(old_spte) || is_removed_spte(new_spte));
   830	
   831		old_spte = kvm_tdp_mmu_write_spte(sptep, old_spte, new_spte, level);
   832	
 > 833		role = sptep_to_sp(sptep)->role;
   834		role.level = level;
   835		__handle_changed_spte(kvm, as_id, gfn, old_spte, new_spte, role, false);
   836	
   837		if (record_acc_track)
   838			handle_changed_spte_acc_track(old_spte, new_spte, level);
   839		if (record_dirty_log)
   840			handle_changed_spte_dirty_log(kvm, as_id, gfn, old_spte,
   841						      new_spte, level);
   842		return old_spte;
   843	}
   844	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
