Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB995BDBCC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 06:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbiITEuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 00:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbiITEuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 00:50:08 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B178833A3D
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 21:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663649407; x=1695185407;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=fICPVqnDIG/Nsgrrcabwe5vtL8ddHgYP80Ca0tMyJhs=;
  b=C42TaeauduXqbcnbE+arqa3fI9gTLvA/e8QUrTDIWkv5xlP0mTYemlMz
   VAuDB2r+pNj0fdaudElmfP7f1N2dBcewuPX5/YDWHrKLYoaUH3u4QNxJ3
   WwvaHyCPydXg3qGvDJvOvmH0l0W1mP9uRwKk3ctTjc31bJ0jGs05EwC9m
   eOQUMmtMyLU72n5ZDQqq/U2lpxPSgd0r0Yl3wl4QchI+vg408FL84+qu2
   0i9KgjVKy4YfWa/AXZdJyzjDSGOgTG4Khtd9fPOwMUy2A82cE5F19IcaM
   5HY8HtmPRDGB3CfxwT//pglXjdrjpbmZEKDve2WQGr22pD+kPqMJvVB9a
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="300414490"
X-IronPort-AV: E=Sophos;i="5.93,329,1654585200"; 
   d="scan'208";a="300414490"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 21:50:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,329,1654585200"; 
   d="scan'208";a="947509879"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 19 Sep 2022 21:50:01 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oaVCr-0002Tl-0U;
        Tue, 20 Sep 2022 04:50:01 +0000
Date:   Tue, 20 Sep 2022 12:49:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Ben Widawsky <bwidawsk@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: kernel/resource.c:1795:23: sparse: sparse: cast truncates bits from
 constant value (fffffffff becomes ffffffff)
Message-ID: <202209201253.FRw5oo2x-lkp@intel.com>
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
head:   521a547ced6477c54b4b0cc206000406c221b4d6
commit: 23a22cd1c98be518774fe7f7e8a5203af050525a cxl/region: Allocate HPA capacity to regions
date:   8 weeks ago
config: arm-randconfig-s042-20220919 (https://download.01.org/0day-ci/archive/20220920/202209201253.FRw5oo2x-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=23a22cd1c98be518774fe7f7e8a5203af050525a
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 23a22cd1c98be518774fe7f7e8a5203af050525a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> kernel/resource.c:1795:23: sparse: sparse: cast truncates bits from constant value (fffffffff becomes ffffffff)
   kernel/resource.c:1813:24: sparse: sparse: cast truncates bits from constant value (fffffffff becomes ffffffff)

vim +1795 kernel/resource.c

14b80582c43e4f Dan Williams 2022-05-20  1788  
14b80582c43e4f Dan Williams 2022-05-20  1789  static resource_size_t gfr_start(struct resource *base, resource_size_t size,
14b80582c43e4f Dan Williams 2022-05-20  1790  				 resource_size_t align, unsigned long flags)
14b80582c43e4f Dan Williams 2022-05-20  1791  {
14b80582c43e4f Dan Williams 2022-05-20  1792  	if (flags & GFR_DESCENDING) {
14b80582c43e4f Dan Williams 2022-05-20  1793  		resource_size_t end;
14b80582c43e4f Dan Williams 2022-05-20  1794  
14b80582c43e4f Dan Williams 2022-05-20 @1795  		end = min_t(resource_size_t, base->end,
14b80582c43e4f Dan Williams 2022-05-20  1796  			    (1ULL << MAX_PHYSMEM_BITS) - 1);
14b80582c43e4f Dan Williams 2022-05-20  1797  		return end - size + 1;
14b80582c43e4f Dan Williams 2022-05-20  1798  	}
14b80582c43e4f Dan Williams 2022-05-20  1799  
14b80582c43e4f Dan Williams 2022-05-20  1800  	return ALIGN(base->start, align);
14b80582c43e4f Dan Williams 2022-05-20  1801  }
14b80582c43e4f Dan Williams 2022-05-20  1802  

:::::: The code at line 1795 was first introduced by commit
:::::: 14b80582c43e4f550acfd93c2b2cadbe36ea0874 resource: Introduce alloc_free_mem_region()

:::::: TO: Dan Williams <dan.j.williams@intel.com>
:::::: CC: Dan Williams <dan.j.williams@intel.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
