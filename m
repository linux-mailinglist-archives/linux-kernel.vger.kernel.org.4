Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC54A744EAE
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 18:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjGBQvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 12:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjGBQvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 12:51:49 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30199E55
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jul 2023 09:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688316707; x=1719852707;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=V12x7NTZ/flFdp7UzRsu6hXAL+WmLfM4kk6JDQLCYk8=;
  b=IWExDzpWA0GrBtPCP6mGHYWlhLbjBnI8KzLKkKGtyWO69ELf5PP3P6yc
   ByxaFtCC1qYyriGExyQ5YyTF06fPBl4hrkqiXCBye9LenZEgyyvnR8GhW
   /q4rSiZIPkNc4RJRmP6nr2qpNlQY+IG1Gl9EncIFmscTf+NZp3HbNpxZi
   5/X8wVVyKoCXTB+Fz7BIMWGRWmKgIFX0gIDiLi+t8AXMJHXvg9R8wYsaT
   JvMwc5clQGtXAUr4fL/8GYFW84n7XYw60gQz6/c8hpO9S6ak2+zYgwtZN
   mdxkPaIWynKGp69Z+PohSFfbwJNKl1ppq5vDHh4gSrFF5OXs+zsrcRqnA
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="449094913"
X-IronPort-AV: E=Sophos;i="6.01,176,1684825200"; 
   d="scan'208";a="449094913"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2023 09:51:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="695563738"
X-IronPort-AV: E=Sophos;i="6.01,176,1684825200"; 
   d="scan'208";a="695563738"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 02 Jul 2023 09:51:43 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qG0IZ-000Gm7-0E;
        Sun, 02 Jul 2023 16:51:43 +0000
Date:   Mon, 3 Jul 2023 00:51:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hamza Mahfooz <hamza.mahfooz@amd.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Kenny Ho <Kenny.Ho@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:1348:18: error: result of
 comparison of constant 4294967296 with expression of type 'resource_size_t'
 (aka 'unsigned int') is always false
Message-ID: <202307030049.yGsrirGh-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   995b406c7e972fab181a4bb57f3b95e59b8e5bf3
commit: 1b320ad3f5a88602aef2f207bc211539a5496702 drm/amd/amdgpu: introduce DRM_AMDGPU_WERROR
date:   3 weeks ago
config: i386-buildonly-randconfig-r004-20230702 (https://download.01.org/0day-ci/archive/20230703/202307030049.yGsrirGh-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.git 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce: (https://download.01.org/0day-ci/archive/20230703/202307030049.yGsrirGh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307030049.yGsrirGh-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:1348:18: error: result of comparison of constant 4294967296 with expression of type 'resource_size_t' (aka 'unsigned int') is always false [-Werror,-Wtautological-constant-out-of-range-compare]
                       res->start > 0x100000000ull)
                       ~~~~~~~~~~ ^ ~~~~~~~~~~~~~~
   1 error generated.


vim +1348 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c

d38ceaf99ed015 Alex Deucher    2015-04-20  1313  
d6895ad39f3b39 Christian König 2017-02-28  1314  /**
d6895ad39f3b39 Christian König 2017-02-28  1315   * amdgpu_device_resize_fb_bar - try to resize FB BAR
d6895ad39f3b39 Christian König 2017-02-28  1316   *
d6895ad39f3b39 Christian König 2017-02-28  1317   * @adev: amdgpu_device pointer
d6895ad39f3b39 Christian König 2017-02-28  1318   *
d6895ad39f3b39 Christian König 2017-02-28  1319   * Try to resize FB BAR to make all VRAM CPU accessible. We try very hard not
d6895ad39f3b39 Christian König 2017-02-28  1320   * to fail, but if any of the BARs is not accessible after the size we abort
d6895ad39f3b39 Christian König 2017-02-28  1321   * driver loading by returning -ENODEV.
d6895ad39f3b39 Christian König 2017-02-28  1322   */
d6895ad39f3b39 Christian König 2017-02-28  1323  int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
d6895ad39f3b39 Christian König 2017-02-28  1324  {
453f617a30aa12 Nirmoy Das      2021-01-07  1325  	int rbar_size = pci_rebar_bytes_to_size(adev->gmc.real_vram_size);
31b8adab3247ea Christian König 2017-11-15  1326  	struct pci_bus *root;
31b8adab3247ea Christian König 2017-11-15  1327  	struct resource *res;
31b8adab3247ea Christian König 2017-11-15  1328  	unsigned i;
d6895ad39f3b39 Christian König 2017-02-28  1329  	u16 cmd;
d6895ad39f3b39 Christian König 2017-02-28  1330  	int r;
d6895ad39f3b39 Christian König 2017-02-28  1331  
0c03b912d7f846 pding           2017-11-07  1332  	/* Bypass for VF */
0c03b912d7f846 pding           2017-11-07  1333  	if (amdgpu_sriov_vf(adev))
0c03b912d7f846 pding           2017-11-07  1334  		return 0;
0c03b912d7f846 pding           2017-11-07  1335  
b7221f2b4655bb Alex Deucher    2020-06-08  1336  	/* skip if the bios has already enabled large BAR */
b7221f2b4655bb Alex Deucher    2020-06-08  1337  	if (adev->gmc.real_vram_size &&
b7221f2b4655bb Alex Deucher    2020-06-08  1338  	    (pci_resource_len(adev->pdev, 0) >= adev->gmc.real_vram_size))
b7221f2b4655bb Alex Deucher    2020-06-08  1339  		return 0;
b7221f2b4655bb Alex Deucher    2020-06-08  1340  
31b8adab3247ea Christian König 2017-11-15  1341  	/* Check if the root BUS has 64bit memory resources */
31b8adab3247ea Christian König 2017-11-15  1342  	root = adev->pdev->bus;
31b8adab3247ea Christian König 2017-11-15  1343  	while (root->parent)
31b8adab3247ea Christian König 2017-11-15  1344  		root = root->parent;
31b8adab3247ea Christian König 2017-11-15  1345  
31b8adab3247ea Christian König 2017-11-15  1346  	pci_bus_for_each_resource(root, res, i) {
0ebb7c5405941b Christian König 2018-01-07  1347  		if (res && res->flags & (IORESOURCE_MEM | IORESOURCE_MEM_64) &&
31b8adab3247ea Christian König 2017-11-15 @1348  		    res->start > 0x100000000ull)
31b8adab3247ea Christian König 2017-11-15  1349  			break;
31b8adab3247ea Christian König 2017-11-15  1350  	}
31b8adab3247ea Christian König 2017-11-15  1351  
31b8adab3247ea Christian König 2017-11-15  1352  	/* Trying to resize is pointless without a root hub window above 4GB */
31b8adab3247ea Christian König 2017-11-15  1353  	if (!res)
31b8adab3247ea Christian König 2017-11-15  1354  		return 0;
31b8adab3247ea Christian König 2017-11-15  1355  
453f617a30aa12 Nirmoy Das      2021-01-07  1356  	/* Limit the BAR size to what is available */
453f617a30aa12 Nirmoy Das      2021-01-07  1357  	rbar_size = min(fls(pci_rebar_get_possible_sizes(adev->pdev, 0)) - 1,
453f617a30aa12 Nirmoy Das      2021-01-07  1358  			rbar_size);
453f617a30aa12 Nirmoy Das      2021-01-07  1359  
d6895ad39f3b39 Christian König 2017-02-28  1360  	/* Disable memory decoding while we change the BAR addresses and size */
d6895ad39f3b39 Christian König 2017-02-28  1361  	pci_read_config_word(adev->pdev, PCI_COMMAND, &cmd);
d6895ad39f3b39 Christian König 2017-02-28  1362  	pci_write_config_word(adev->pdev, PCI_COMMAND,
d6895ad39f3b39 Christian König 2017-02-28  1363  			      cmd & ~PCI_COMMAND_MEMORY);
d6895ad39f3b39 Christian König 2017-02-28  1364  
d6895ad39f3b39 Christian König 2017-02-28  1365  	/* Free the VRAM and doorbell BAR, we most likely need to move both. */
06ec907054c5a4 Alex Deucher    2017-12-14  1366  	amdgpu_device_doorbell_fini(adev);
d6895ad39f3b39 Christian König 2017-02-28  1367  	if (adev->asic_type >= CHIP_BONAIRE)
d6895ad39f3b39 Christian König 2017-02-28  1368  		pci_release_resource(adev->pdev, 2);
d6895ad39f3b39 Christian König 2017-02-28  1369  
d6895ad39f3b39 Christian König 2017-02-28  1370  	pci_release_resource(adev->pdev, 0);
d6895ad39f3b39 Christian König 2017-02-28  1371  
d6895ad39f3b39 Christian König 2017-02-28  1372  	r = pci_resize_resource(adev->pdev, 0, rbar_size);
d6895ad39f3b39 Christian König 2017-02-28  1373  	if (r == -ENOSPC)
d6895ad39f3b39 Christian König 2017-02-28  1374  		DRM_INFO("Not enough PCI address space for a large BAR.");
d6895ad39f3b39 Christian König 2017-02-28  1375  	else if (r && r != -ENOTSUPP)
d6895ad39f3b39 Christian König 2017-02-28  1376  		DRM_ERROR("Problem resizing BAR0 (%d).", r);
d6895ad39f3b39 Christian König 2017-02-28  1377  
d6895ad39f3b39 Christian König 2017-02-28  1378  	pci_assign_unassigned_bus_resources(adev->pdev->bus);
d6895ad39f3b39 Christian König 2017-02-28  1379  
d6895ad39f3b39 Christian König 2017-02-28  1380  	/* When the doorbell or fb BAR isn't available we have no chance of
d6895ad39f3b39 Christian König 2017-02-28  1381  	 * using the device.
d6895ad39f3b39 Christian König 2017-02-28  1382  	 */
06ec907054c5a4 Alex Deucher    2017-12-14  1383  	r = amdgpu_device_doorbell_init(adev);
d6895ad39f3b39 Christian König 2017-02-28  1384  	if (r || (pci_resource_flags(adev->pdev, 0) & IORESOURCE_UNSET))
d6895ad39f3b39 Christian König 2017-02-28  1385  		return -ENODEV;
d6895ad39f3b39 Christian König 2017-02-28  1386  
d6895ad39f3b39 Christian König 2017-02-28  1387  	pci_write_config_word(adev->pdev, PCI_COMMAND, cmd);
d6895ad39f3b39 Christian König 2017-02-28  1388  
d6895ad39f3b39 Christian König 2017-02-28  1389  	return 0;
d6895ad39f3b39 Christian König 2017-02-28  1390  }
a05502e5cfa9ab Horace Chen     2017-09-29  1391  

:::::: The code at line 1348 was first introduced by commit
:::::: 31b8adab3247eaa6cffbaa59276456b694718cc8 drm/amdgpu: require a root bus window above 4GB for BAR resize

:::::: TO: Christian König <christian.koenig@amd.com>
:::::: CC: Alex Deucher <alexander.deucher@amd.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
