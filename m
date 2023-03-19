Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2386BFF6C
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 06:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbjCSFnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 01:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbjCSFnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 01:43:06 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F3BF1ADD0
        for <linux-kernel@vger.kernel.org>; Sat, 18 Mar 2023 22:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679204584; x=1710740584;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=bVMNwOIail6gL6U3z5BTgEu8Q/sW+JmX652l2neSVAM=;
  b=C/pLlL1bAMLzEYZ05uq7BwP7FGOpRs/zhdsw0pMVuOBuBMnGLLY7XRBL
   Go3jLt5pEsu2OtFW/LkFboPalTSOb/u6IHsPpwUYRyOpAzOGuFgdS19mz
   Sy5VqA2Y/4VBLw26/x5eZJRZ45LX0C4TTf6J5l2mSR7Yhm6Nz8ZUY/coV
   Q5XCt1FAJIEAtVzhGi6LldeQzPij8c2+S4s9vh7WAkqJVsj5O37F/1AnC
   UIDPFWL8da/XuC19XSrwxTtcgJcyScc+QR/66CK3dXQHTsDGJSNAYU5wA
   99ct+DNceOVKVHwu7DhmvssJTKFQADEgLlwR8+CC6OLsxkCBy0KWHQkd+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10653"; a="337194686"
X-IronPort-AV: E=Sophos;i="5.98,273,1673942400"; 
   d="scan'208";a="337194686"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2023 22:43:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10653"; a="769820730"
X-IronPort-AV: E=Sophos;i="5.98,273,1673942400"; 
   d="scan'208";a="769820730"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 18 Mar 2023 22:43:02 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pdlor-000APs-1z;
        Sun, 19 Mar 2023 05:43:01 +0000
Date:   Sun, 19 Mar 2023 13:42:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Matthias Brugger <mbrugger@suse.com>
Subject: arch/arm64/kernel/hibernate.c:202:44: sparse: sparse: cast from
 restricted gfp_t
Message-ID: <202303191326.S4gjDdQY-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a3671bd86a9770e34969522d29bb30a1b66fd88a
commit: 50f53fb721817a6efa541cca24f1b7caa84801c1 arm64: trans_pgd: make trans_pgd_map_page generic
date:   2 years, 2 months ago
config: arm64-randconfig-s042-20230319 (https://download.01.org/0day-ci/archive/20230319/202303191326.S4gjDdQY-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=50f53fb721817a6efa541cca24f1b7caa84801c1
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 50f53fb721817a6efa541cca24f1b7caa84801c1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/kernel/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303191326.S4gjDdQY-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   arch/arm64/kernel/hibernate.c:181:39: sparse: sparse: cast to restricted gfp_t
>> arch/arm64/kernel/hibernate.c:202:44: sparse: sparse: cast from restricted gfp_t

vim +202 arch/arm64/kernel/hibernate.c

   183	
   184	/*
   185	 * Copies length bytes, starting at src_start into an new page,
   186	 * perform cache maintenance, then maps it at the specified address low
   187	 * address as executable.
   188	 *
   189	 * This is used by hibernate to copy the code it needs to execute when
   190	 * overwriting the kernel text. This function generates a new set of page
   191	 * tables, which it loads into ttbr0.
   192	 *
   193	 * Length is provided as we probably only want 4K of data, even on a 64K
   194	 * page system.
   195	 */
   196	static int create_safe_exec_page(void *src_start, size_t length,
   197					 unsigned long dst_addr,
   198					 phys_addr_t *phys_dst_addr)
   199	{
   200		struct trans_pgd_info trans_info = {
   201			.trans_alloc_page	= hibernate_page_alloc,
 > 202			.trans_alloc_arg	= (void *)GFP_ATOMIC,
   203		};
   204	
   205		void *page = (void *)get_safe_page(GFP_ATOMIC);
   206		pgd_t *trans_pgd;
   207		int rc;
   208	
   209		if (!page)
   210			return -ENOMEM;
   211	
   212		memcpy(page, src_start, length);
   213		__flush_icache_range((unsigned long)page, (unsigned long)page + length);
   214	
   215		trans_pgd = (void *)get_safe_page(GFP_ATOMIC);
   216		if (!trans_pgd)
   217			return -ENOMEM;
   218	
   219		rc = trans_pgd_map_page(&trans_info, trans_pgd, page, dst_addr,
   220					PAGE_KERNEL_EXEC);
   221		if (rc)
   222			return rc;
   223	
   224		/*
   225		 * Load our new page tables. A strict BBM approach requires that we
   226		 * ensure that TLBs are free of any entries that may overlap with the
   227		 * global mappings we are about to install.
   228		 *
   229		 * For a real hibernate/resume cycle TTBR0 currently points to a zero
   230		 * page, but TLBs may contain stale ASID-tagged entries (e.g. for EFI
   231		 * runtime services), while for a userspace-driven test_resume cycle it
   232		 * points to userspace page tables (and we must point it at a zero page
   233		 * ourselves). Elsewhere we only (un)install the idmap with preemption
   234		 * disabled, so T0SZ should be as required regardless.
   235		 */
   236		cpu_set_reserved_ttbr0();
   237		local_flush_tlb_all();
   238		write_sysreg(phys_to_ttbr(virt_to_phys(trans_pgd)), ttbr0_el1);
   239		isb();
   240	
   241		*phys_dst_addr = virt_to_phys(page);
   242	
   243		return 0;
   244	}
   245	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
