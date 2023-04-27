Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB1C6F0E5B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 00:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344281AbjD0Wcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 18:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjD0Wcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 18:32:32 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE78835BD
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 15:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682634750; x=1714170750;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=SX0LMeESQ3daK4GlcopGJKPMiZ1v3rzUGUEru3UH5iI=;
  b=hJvC9UFdyEbbrEcpX8G/G9jbbU/Vc6+NFNC9sXl1FIa3o+HEudBEv0fA
   P8fNjXtYFTwVf5I+Fh/KOIfZaTs6lvRVJDhuQn1LaiZN/1Bh+dVSWPY4I
   Jg/vD3O/xU2i9Ok8mOdBNDbpwry3X2dXuiT+59NxSyrZUxfSk/o5a2xHA
   M16g5GMNk/zbY8qIcZY8xHEJJ7O+cH0HfbkYS6NvskfTIvqtmttVuRwek
   qHEYXCLEy8L/ngbc74pC8GqCUFm0oJC6TSUiXFyVz0Yc3iYzvaYAVpD6X
   xdm0wjj9c7wZm+O8si7UInlWawXgE8SoBOV3fjBNxci5HsoXVmPP32eUD
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="349577956"
X-IronPort-AV: E=Sophos;i="5.99,232,1677571200"; 
   d="scan'208";a="349577956"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2023 15:32:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="818738126"
X-IronPort-AV: E=Sophos;i="5.99,232,1677571200"; 
   d="scan'208";a="818738126"
Received: from lkp-server01.sh.intel.com (HELO b95e16499b55) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 27 Apr 2023 15:32:28 -0700
Received: from kbuild by b95e16499b55 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1psAA7-0000AD-2u;
        Thu, 27 Apr 2023 22:32:27 +0000
Date:   Fri, 28 Apr 2023 06:31:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Matthew Auld <matthew.auld@intel.com>
Subject: drivers/gpu/drm/radeon/radeon_ttm.c:201:27: warning: variable 'rbo'
 set but not used
Message-ID: <202304280626.8qfHQcED-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   cec24b8b6bb841a19b5c5555b600a511a8988100
commit: f87c1f0b7b79b7a4f165750d1884da1fd29ae93c drm/ttm: prevent moving of pinned BOs
date:   3 months ago
config: alpha-buildonly-randconfig-r002-20230427 (https://download.01.org/0day-ci/archive/20230428/202304280626.8qfHQcED-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f87c1f0b7b79b7a4f165750d1884da1fd29ae93c
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout f87c1f0b7b79b7a4f165750d1884da1fd29ae93c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=alpha olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=alpha SHELL=/bin/bash drivers/gpu/drm/radeon/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304280626.8qfHQcED-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/radeon/radeon_ttm.c: In function 'radeon_bo_move':
>> drivers/gpu/drm/radeon/radeon_ttm.c:201:27: warning: variable 'rbo' set but not used [-Wunused-but-set-variable]
     201 |         struct radeon_bo *rbo;
         |                           ^~~


vim +/rbo +201 drivers/gpu/drm/radeon/radeon_ttm.c

771fe6b912fca5 Jerome Glisse   2009-06-05  193  
2823f4f019d888 Christian König 2017-04-26  194  static int radeon_bo_move(struct ttm_buffer_object *bo, bool evict,
2823f4f019d888 Christian König 2017-04-26  195  			  struct ttm_operation_ctx *ctx,
ebdf565169af00 Dave Airlie     2020-10-29  196  			  struct ttm_resource *new_mem,
ebdf565169af00 Dave Airlie     2020-10-29  197  			  struct ttm_place *hop)
771fe6b912fca5 Jerome Glisse   2009-06-05  198  {
d3116756a710e3 Christian König 2021-04-12  199  	struct ttm_resource *old_mem = bo->resource;
771fe6b912fca5 Jerome Glisse   2009-06-05  200  	struct radeon_device *rdev;
e1a575ada8d2a3 Michel Dänzer   2016-03-28 @201  	struct radeon_bo *rbo;
a32ba6bdca21fd Christian König 2021-07-12  202  	int r;
771fe6b912fca5 Jerome Glisse   2009-06-05  203  
bfe5e585b44fb8 Dave Airlie     2020-10-20  204  	if (new_mem->mem_type == TTM_PL_TT) {
bfe5e585b44fb8 Dave Airlie     2020-10-20  205  		r = radeon_ttm_tt_bind(bo->bdev, bo->ttm, new_mem);
bfe5e585b44fb8 Dave Airlie     2020-10-20  206  		if (r)
bfe5e585b44fb8 Dave Airlie     2020-10-20  207  			return r;
bfe5e585b44fb8 Dave Airlie     2020-10-20  208  	}
6d820003295977 Dave Airlie     2020-10-20  209  
0ef1ed813e6b13 Dave Airlie     2020-09-23  210  	r = ttm_bo_wait_ctx(bo, ctx);
88932a7be27d89 Christian König 2016-06-06  211  	if (r)
9afdda82ee7f69 Christian König 2020-11-25  212  		return r;
88932a7be27d89 Christian König 2016-06-06  213  
e1a575ada8d2a3 Michel Dänzer   2016-03-28  214  	rbo = container_of(bo, struct radeon_bo, tbo);
771fe6b912fca5 Jerome Glisse   2009-06-05  215  	rdev = radeon_get_rdev(bo->bdev);
771fe6b912fca5 Jerome Glisse   2009-06-05  216  	if (old_mem->mem_type == TTM_PL_SYSTEM && bo->ttm == NULL) {
ecfe6953fa0011 Dave Airlie     2020-09-08  217  		ttm_bo_move_null(bo, new_mem);
9afdda82ee7f69 Christian König 2020-11-25  218  		goto out;
771fe6b912fca5 Jerome Glisse   2009-06-05  219  	}
51e50e54220432 Dave Airlie     2020-09-24  220  	if (old_mem->mem_type == TTM_PL_SYSTEM &&
51e50e54220432 Dave Airlie     2020-09-24  221  	    new_mem->mem_type == TTM_PL_TT) {
ecfe6953fa0011 Dave Airlie     2020-09-08  222  		ttm_bo_move_null(bo, new_mem);
9afdda82ee7f69 Christian König 2020-11-25  223  		goto out;
771fe6b912fca5 Jerome Glisse   2009-06-05  224  	}
51e50e54220432 Dave Airlie     2020-09-24  225  
51e50e54220432 Dave Airlie     2020-09-24  226  	if (old_mem->mem_type == TTM_PL_TT &&
c37d951cb42aa3 Dave Airlie     2020-10-19  227  	    new_mem->mem_type == TTM_PL_SYSTEM) {
29a1d482e4044a Dave Airlie     2020-10-20  228  		radeon_ttm_tt_unbind(bo->bdev, bo->ttm);
bfa3357ef9abc9 Christian König 2021-04-15  229  		ttm_resource_free(bo, &bo->resource);
c37d951cb42aa3 Dave Airlie     2020-10-19  230  		ttm_bo_assign_mem(bo, new_mem);
9afdda82ee7f69 Christian König 2020-11-25  231  		goto out;
c37d951cb42aa3 Dave Airlie     2020-10-19  232  	}
9afdda82ee7f69 Christian König 2020-11-25  233  	if (rdev->ring[radeon_copy_ring_index(rdev)].ready &&
9afdda82ee7f69 Christian König 2020-11-25  234  	    rdev->asic->copy.copy != NULL) {
9afdda82ee7f69 Christian König 2020-11-25  235  		if ((old_mem->mem_type == TTM_PL_SYSTEM &&
9afdda82ee7f69 Christian König 2020-11-25  236  		     new_mem->mem_type == TTM_PL_VRAM) ||
9afdda82ee7f69 Christian König 2020-11-25  237  		    (old_mem->mem_type == TTM_PL_VRAM &&
9afdda82ee7f69 Christian König 2020-11-25  238  		     new_mem->mem_type == TTM_PL_SYSTEM)) {
9afdda82ee7f69 Christian König 2020-11-25  239  			hop->fpfn = 0;
9afdda82ee7f69 Christian König 2020-11-25  240  			hop->lpfn = 0;
9afdda82ee7f69 Christian König 2020-11-25  241  			hop->mem_type = TTM_PL_TT;
9afdda82ee7f69 Christian König 2020-11-25  242  			hop->flags = 0;
9afdda82ee7f69 Christian König 2020-11-25  243  			return -EMULTIHOP;
771fe6b912fca5 Jerome Glisse   2009-06-05  244  		}
771fe6b912fca5 Jerome Glisse   2009-06-05  245  
28a68f82826675 Dave Airlie     2020-10-29  246  		r = radeon_move_blit(bo, evict, new_mem, old_mem);
9afdda82ee7f69 Christian König 2020-11-25  247  	} else {
9afdda82ee7f69 Christian König 2020-11-25  248  		r = -ENODEV;
9afdda82ee7f69 Christian König 2020-11-25  249  	}
9afdda82ee7f69 Christian König 2020-11-25  250  
1ab2e1059916b9 Michel Dänzer   2009-07-28  251  	if (r) {
3e98d829ad0a59 Roger He        2017-12-08  252  		r = ttm_bo_move_memcpy(bo, ctx, new_mem);
9afdda82ee7f69 Christian König 2020-11-25  253  		if (r)
9afdda82ee7f69 Christian König 2020-11-25  254  			return r;
67e8e3f970ad74 Marek Olšák     2014-03-02  255  	}
67e8e3f970ad74 Marek Olšák     2014-03-02  256  
9afdda82ee7f69 Christian König 2020-11-25  257  out:
67e8e3f970ad74 Marek Olšák     2014-03-02  258  	/* update statistics */
e11bfb99d6ece2 Christian König 2020-12-09  259  	atomic64_add(bo->base.size, &rdev->num_bytes_moved);
a32ba6bdca21fd Christian König 2021-07-12  260  	radeon_bo_move_notify(bo);
67e8e3f970ad74 Marek Olšák     2014-03-02  261  	return 0;
67e8e3f970ad74 Marek Olšák     2014-03-02  262  }
771fe6b912fca5 Jerome Glisse   2009-06-05  263  

:::::: The code at line 201 was first introduced by commit
:::::: e1a575ada8d2a3c3f107fdd12ac9215f983a7c80 drm/radeon: Don't move pinned BOs

:::::: TO: Michel Dänzer <michel.daenzer@amd.com>
:::::: CC: Alex Deucher <alexander.deucher@amd.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
