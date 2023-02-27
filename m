Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 356586A3602
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 01:53:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjB0AxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 19:53:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjB0AxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 19:53:17 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B58093E3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 16:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677459196; x=1708995196;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=MCRpJ/jOD1SQPSR2OLTjAWCgsEsN+9saXz+9z0DpZZw=;
  b=fxMuLZ8NF2Ftg8GCPWUNk7gO7kWCnQQhWl5lfoOcEnbIC35oiI56pT9N
   +EQgSR1ISZhGdsAvAGU4vA5XOSm6PmGPBmcFxwFi1THK5VRtO+i5O+GLg
   DtWYz1Q91YfZFy6jxt8R5zsbv5VDHbMLHjjTAqP+94MOB/0oHAq+z20xE
   15g3177VGvH9ezsXXJ6pPMsIhiEK0WWs7Y6/FUFLM91Q5x9lrEa10STl9
   cW02hsI+F77hY49fwchTyUMn6tTv+Jr8FJ3UkFszMuKFrXycWoNshnqB7
   6IvONG8N/yUTPbxzb+j7ukJTmW8DdmQPwQC47BstjlpOXsDQNiIoNCdtd
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10633"; a="332480969"
X-IronPort-AV: E=Sophos;i="5.97,330,1669104000"; 
   d="scan'208";a="332480969"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2023 16:53:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10633"; a="651014097"
X-IronPort-AV: E=Sophos;i="5.97,330,1669104000"; 
   d="scan'208";a="651014097"
Received: from lkp-server01.sh.intel.com (HELO 3895f5c55ead) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 26 Feb 2023 16:53:13 -0800
Received: from kbuild by 3895f5c55ead with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pWRlR-0003yB-0F;
        Mon, 27 Feb 2023 00:53:13 +0000
Date:   Mon, 27 Feb 2023 08:52:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christian =?iso-8859-1?Q?K=F6nig?= 
        <ckoenig.leichtzumerken@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Matthew Auld <matthew.auld@intel.com>
Subject: drivers/gpu/drm/i915/gem/i915_gem_ttm.c:1066:21: sparse: sparse:
 incorrect type in assignment (different base types)
Message-ID: <202302270807.R5fXE0cx-lkp@intel.com>
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
head:   f3a2439f20d918930cc4ae8f76fe1c1afd26958f
commit: 516198d317d81f33839ca850e83f6717b0d80e80 drm/i915: audit bo->resource usage v3
date:   5 weeks ago
config: i386-randconfig-s002 (https://download.01.org/0day-ci/archive/20230227/202302270807.R5fXE0cx-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=516198d317d81f33839ca850e83f6717b0d80e80
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 516198d317d81f33839ca850e83f6717b0d80e80
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 olddefconfig
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash drivers/gpu/drm/i915/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302270807.R5fXE0cx-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/gpu/drm/i915/gem/i915_gem_ttm.c:1066:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted vm_fault_t [assigned] [usertype] ret @@     got int @@
   drivers/gpu/drm/i915/gem/i915_gem_ttm.c:1066:21: sparse:     expected restricted vm_fault_t [assigned] [usertype] ret
   drivers/gpu/drm/i915/gem/i915_gem_ttm.c:1066:21: sparse:     got int

vim +1066 drivers/gpu/drm/i915/gem/i915_gem_ttm.c

  1027	
  1028	static vm_fault_t vm_fault_ttm(struct vm_fault *vmf)
  1029	{
  1030		struct vm_area_struct *area = vmf->vma;
  1031		struct ttm_buffer_object *bo = area->vm_private_data;
  1032		struct drm_device *dev = bo->base.dev;
  1033		struct drm_i915_gem_object *obj = i915_ttm_to_gem(bo);
  1034		intel_wakeref_t wakeref = 0;
  1035		vm_fault_t ret;
  1036		int idx;
  1037	
  1038		/* Sanity check that we allow writing into this object */
  1039		if (unlikely(i915_gem_object_is_readonly(obj) &&
  1040			     area->vm_flags & VM_WRITE))
  1041			return VM_FAULT_SIGBUS;
  1042	
  1043		ret = ttm_bo_vm_reserve(bo, vmf);
  1044		if (ret)
  1045			return ret;
  1046	
  1047		if (obj->mm.madv != I915_MADV_WILLNEED) {
  1048			dma_resv_unlock(bo->base.resv);
  1049			return VM_FAULT_SIGBUS;
  1050		}
  1051	
  1052		/*
  1053		 * This must be swapped out with shmem ttm_tt (pipeline-gutting).
  1054		 * Calling ttm_bo_validate() here with TTM_PL_SYSTEM should only go as
  1055		 * far as far doing a ttm_bo_move_null(), which should skip all the
  1056		 * other junk.
  1057		 */
  1058		if (!bo->resource) {
  1059			struct ttm_operation_ctx ctx = {
  1060				.interruptible = true,
  1061				.no_wait_gpu = true, /* should be idle already */
  1062			};
  1063	
  1064			GEM_BUG_ON(!bo->ttm || !(bo->ttm->page_flags & TTM_TT_FLAG_SWAPPED));
  1065	
> 1066			ret = ttm_bo_validate(bo, i915_ttm_sys_placement(), &ctx);
  1067			if (ret) {
  1068				dma_resv_unlock(bo->base.resv);
  1069				return VM_FAULT_SIGBUS;
  1070			}
  1071		} else if (!i915_ttm_resource_mappable(bo->resource)) {
  1072			int err = -ENODEV;
  1073			int i;
  1074	
  1075			for (i = 0; i < obj->mm.n_placements; i++) {
  1076				struct intel_memory_region *mr = obj->mm.placements[i];
  1077				unsigned int flags;
  1078	
  1079				if (!mr->io_size && mr->type != INTEL_MEMORY_SYSTEM)
  1080					continue;
  1081	
  1082				flags = obj->flags;
  1083				flags &= ~I915_BO_ALLOC_GPU_ONLY;
  1084				err = __i915_ttm_migrate(obj, mr, flags);
  1085				if (!err)
  1086					break;
  1087			}
  1088	
  1089			if (err) {
  1090				drm_dbg(dev, "Unable to make resource CPU accessible(err = %pe)\n",
  1091					ERR_PTR(err));
  1092				dma_resv_unlock(bo->base.resv);
  1093				ret = VM_FAULT_SIGBUS;
  1094				goto out_rpm;
  1095			}
  1096		}
  1097	
  1098		if (i915_ttm_cpu_maps_iomem(bo->resource))
  1099			wakeref = intel_runtime_pm_get(&to_i915(obj->base.dev)->runtime_pm);
  1100	
  1101		if (drm_dev_enter(dev, &idx)) {
  1102			ret = ttm_bo_vm_fault_reserved(vmf, vmf->vma->vm_page_prot,
  1103						       TTM_BO_VM_NUM_PREFAULT);
  1104			drm_dev_exit(idx);
  1105		} else {
  1106			ret = ttm_bo_vm_dummy_page(vmf, vmf->vma->vm_page_prot);
  1107		}
  1108	
  1109		if (ret == VM_FAULT_RETRY && !(vmf->flags & FAULT_FLAG_RETRY_NOWAIT))
  1110			goto out_rpm;
  1111	
  1112		/*
  1113		 * ttm_bo_vm_reserve() already has dma_resv_lock.
  1114		 * userfault_count is protected by dma_resv lock and rpm wakeref.
  1115		 */
  1116		if (ret == VM_FAULT_NOPAGE && wakeref && !obj->userfault_count) {
  1117			obj->userfault_count = 1;
  1118			spin_lock(&to_i915(obj->base.dev)->runtime_pm.lmem_userfault_lock);
  1119			list_add(&obj->userfault_link, &to_i915(obj->base.dev)->runtime_pm.lmem_userfault_list);
  1120			spin_unlock(&to_i915(obj->base.dev)->runtime_pm.lmem_userfault_lock);
  1121	
  1122			GEM_WARN_ON(!i915_ttm_cpu_maps_iomem(bo->resource));
  1123		}
  1124	
  1125		if (wakeref & CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND)
  1126			intel_wakeref_auto(&to_i915(obj->base.dev)->runtime_pm.userfault_wakeref,
  1127					   msecs_to_jiffies_timeout(CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND));
  1128	
  1129		i915_ttm_adjust_lru(obj);
  1130	
  1131		dma_resv_unlock(bo->base.resv);
  1132	
  1133	out_rpm:
  1134		if (wakeref)
  1135			intel_runtime_pm_put(&to_i915(obj->base.dev)->runtime_pm, wakeref);
  1136	
  1137		return ret;
  1138	}
  1139	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
