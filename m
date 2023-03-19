Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6406BFECE
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 02:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjCSBQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 21:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjCSBQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 21:16:02 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E05E233F0
        for <linux-kernel@vger.kernel.org>; Sat, 18 Mar 2023 18:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679188560; x=1710724560;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=IbvM9Er9tkWwchvy5FbS4aQrulJQtQdhzo+eGOwWUGs=;
  b=TnDQB3X7OGr7Yp19tfOzxx0+ZBmG4k0eWtGST3b5eX118Es/sPLNBaPq
   uBCwAqdBvDkGUyP0SnMXE/HBQ7FdTnePjoH1fEWpeFGKubUg7zsbc24Qy
   NuggXB+939pqCYS5tJZvEmnqX27qb9kwMLbv5gb0WHS1Zc4bhznD+a3xV
   7rnbJ341B2he5PZgL4GjpG4jTAkI1mKqSnGysOrIcq9KAMXwbwket0DkH
   oso09RNQVbzJEtr0ifU1NZo8pH4X1kwWQz0GOFTdc0dJmIANfKD5BhBFI
   o7DQASb7FZyuRbiXbbRzV5s5bb/+QlZpIL/KApARSEOAShx/nvoJGJxVR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10653"; a="340009079"
X-IronPort-AV: E=Sophos;i="5.98,272,1673942400"; 
   d="scan'208";a="340009079"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2023 18:15:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10653"; a="824068723"
X-IronPort-AV: E=Sophos;i="5.98,272,1673942400"; 
   d="scan'208";a="824068723"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 18 Mar 2023 18:15:58 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pdheP-000AK6-0f;
        Sun, 19 Mar 2023 01:15:57 +0000
Date:   Sun, 19 Mar 2023 09:15:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alistair Popple <apopple@nvidia.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Lyude Paul <lyude@redhat.com>
Subject: drivers/gpu/drm/nouveau/nouveau_dmem.c:205:13: sparse: sparse:
 incorrect type in assignment (different base types)
Message-ID: <202303190929.sOBSJIb5-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a3671bd86a9770e34969522d29bb30a1b66fd88a
commit: d9b719394a1147614351961ac454589111c76e76 nouveau/dmem: refactor nouveau_dmem_fault_copy_one()
date:   5 months ago
config: arm64-randconfig-s052-20230319 (https://download.01.org/0day-ci/archive/20230319/202303190929.sOBSJIb5-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d9b719394a1147614351961ac454589111c76e76
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout d9b719394a1147614351961ac454589111c76e76
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/bluetooth/ drivers/gpu/drm/ drivers/remoteproc/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303190929.sOBSJIb5-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/gpu/drm/nouveau/nouveau_dmem.c:205:13: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted vm_fault_t [usertype] ret @@     got int @@
   drivers/gpu/drm/nouveau/nouveau_dmem.c:205:13: sparse:     expected restricted vm_fault_t [usertype] ret
   drivers/gpu/drm/nouveau/nouveau_dmem.c:205:13: sparse:     got int
   drivers/gpu/drm/nouveau/nouveau_dmem.c:409:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpu/drm/nouveau/nouveau_dmem.c:409:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpu/drm/nouveau/nouveau_dmem.c:413:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpu/drm/nouveau/nouveau_dmem.c:413:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpu/drm/nouveau/nouveau_dmem.c:426:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpu/drm/nouveau/nouveau_dmem.c:426:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpu/drm/nouveau/nouveau_dmem.c:430:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpu/drm/nouveau/nouveau_dmem.c:430:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpu/drm/nouveau/nouveau_dmem.c:440:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpu/drm/nouveau/nouveau_dmem.c:440:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpu/drm/nouveau/nouveau_dmem.c:440:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpu/drm/nouveau/nouveau_dmem.c:440:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpu/drm/nouveau/nouveau_dmem.c:440:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpu/drm/nouveau/nouveau_dmem.c:440:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpu/drm/nouveau/nouveau_dmem.c:440:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpu/drm/nouveau/nouveau_dmem.c:440:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpu/drm/nouveau/nouveau_dmem.c:440:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpu/drm/nouveau/nouveau_dmem.c:454:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpu/drm/nouveau/nouveau_dmem.c:454:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpu/drm/nouveau/nouveau_dmem.c:481:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpu/drm/nouveau/nouveau_dmem.c:481:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpu/drm/nouveau/nouveau_dmem.c:485:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpu/drm/nouveau/nouveau_dmem.c:485:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpu/drm/nouveau/nouveau_dmem.c:494:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpu/drm/nouveau/nouveau_dmem.c:494:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpu/drm/nouveau/nouveau_dmem.c:494:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpu/drm/nouveau/nouveau_dmem.c:494:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpu/drm/nouveau/nouveau_dmem.c:503:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpu/drm/nouveau/nouveau_dmem.c:503:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpu/drm/nouveau/nouveau_dmem.c:503:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpu/drm/nouveau/nouveau_dmem.c:508:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpu/drm/nouveau/nouveau_dmem.c:508:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpu/drm/nouveau/nouveau_dmem.c:510:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpu/drm/nouveau/nouveau_dmem.c:510:9: sparse: sparse: cast removes address space '__iomem' of expression

vim +205 drivers/gpu/drm/nouveau/nouveau_dmem.c

   161	
   162	static vm_fault_t nouveau_dmem_migrate_to_ram(struct vm_fault *vmf)
   163	{
   164		struct nouveau_drm *drm = page_to_drm(vmf->page);
   165		struct nouveau_dmem *dmem = drm->dmem;
   166		struct nouveau_fence *fence;
   167		struct nouveau_svmm *svmm;
   168		struct page *spage, *dpage;
   169		unsigned long src = 0, dst = 0;
   170		dma_addr_t dma_addr = 0;
   171		vm_fault_t ret = 0;
   172		struct migrate_vma args = {
   173			.vma		= vmf->vma,
   174			.start		= vmf->address,
   175			.end		= vmf->address + PAGE_SIZE,
   176			.src		= &src,
   177			.dst		= &dst,
   178			.pgmap_owner	= drm->dev,
   179			.flags		= MIGRATE_VMA_SELECT_DEVICE_PRIVATE,
   180		};
   181	
   182		/*
   183		 * FIXME what we really want is to find some heuristic to migrate more
   184		 * than just one page on CPU fault. When such fault happens it is very
   185		 * likely that more surrounding page will CPU fault too.
   186		 */
   187		if (migrate_vma_setup(&args) < 0)
   188			return VM_FAULT_SIGBUS;
   189		if (!args.cpages)
   190			return 0;
   191	
   192		spage = migrate_pfn_to_page(src);
   193		if (!spage || !(src & MIGRATE_PFN_MIGRATE))
   194			goto done;
   195	
   196		dpage = alloc_page_vma(GFP_HIGHUSER, vmf->vma, vmf->address);
   197		if (!dpage)
   198			goto done;
   199	
   200		dst = migrate_pfn(page_to_pfn(dpage));
   201	
   202		svmm = spage->zone_device_data;
   203		mutex_lock(&svmm->mutex);
   204		nouveau_svmm_invalidate(svmm, args.start, args.end);
 > 205		ret = nouveau_dmem_copy_one(drm, spage, dpage, &dma_addr);
   206		mutex_unlock(&svmm->mutex);
   207		if (ret) {
   208			ret = VM_FAULT_SIGBUS;
   209			goto done;
   210		}
   211	
   212		nouveau_fence_new(dmem->migrate.chan, false, &fence);
   213		migrate_vma_pages(&args);
   214		nouveau_dmem_fence_done(&fence);
   215		dma_unmap_page(drm->dev->dev, dma_addr, PAGE_SIZE, DMA_BIDIRECTIONAL);
   216	done:
   217		migrate_vma_finalize(&args);
   218		return ret;
   219	}
   220	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
