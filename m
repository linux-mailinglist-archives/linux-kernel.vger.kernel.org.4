Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65C885B6C10
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 12:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231806AbiIMK5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 06:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231795AbiIMK5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 06:57:04 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 890305F106
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 03:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663066623; x=1694602623;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=4/5yU65PNToNKBZpi7K7o11Xt1HGqwoLvIgK+IKEV1Y=;
  b=EcnCZagDxNhpQERPmfP660ZDBW52JBBnR464Folj+GBvUNMgl0d8Sk0y
   6n3+hZjWc3Jf3WHpwby5WKZDgWOr1E+v+2fEKzQMVBqjDqaEAgFWX+1i8
   psxpsHHazh04S+w5mgZjn6GwDJddWc77KjU6LRgrE5l8s0GCL5jveDAVM
   PLAi/lrJnbryCLoC6hfkC8qV3h/sI1/GznMDnTRBEAzUnRM2AwL9xh5fO
   Y34DfI0beskHJeqE/0eDUM5EhSthgN2PVZbOTjgTJooDPVXiFzj8av4dd
   33YKyHmMnC95ZNz4xZzO2zMwidS/vesWQLbmmWHkd0uf1xV805gyK76EJ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10468"; a="299445686"
X-IronPort-AV: E=Sophos;i="5.93,312,1654585200"; 
   d="scan'208";a="299445686"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2022 03:57:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,312,1654585200"; 
   d="scan'208";a="678517514"
Received: from lkp-server02.sh.intel.com (HELO 4011df4f4fd3) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 13 Sep 2022 03:57:01 -0700
Received: from kbuild by 4011df4f4fd3 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oY3bB-0003WO-0c;
        Tue, 13 Sep 2022 10:57:01 +0000
Date:   Tue, 13 Sep 2022 18:56:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Matteo Croce <mcroce@microsoft.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Emil Renner Berthing <kernel@esmil.dk>
Subject: [esmil:visionfive 1/42] string.c:undefined reference to `_mcount'
Message-ID: <202209131806.Fx9g1fDl-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/esmil/linux visionfive
head:   044c1f5e968de7d30940431fbb90da599074ea1c
commit: c247f6e6c7ba6abb92177ba2a742f60a3244d6d2 [1/42] riscv: optimized memcpy
config: riscv-randconfig-c023-20220911 (https://download.01.org/0day-ci/archive/20220913/202209131806.Fx9g1fDl-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/esmil/linux/commit/c247f6e6c7ba6abb92177ba2a742f60a3244d6d2
        git remote add esmil https://github.com/esmil/linux
        git fetch --no-tags esmil visionfive
        git checkout c247f6e6c7ba6abb92177ba2a742f60a3244d6d2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   riscv64-linux-ld: arch/riscv/purgatory/purgatory.ro: in function `.L247':
>> string.c:(.text+0x2240): undefined reference to `_mcount'

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for DRM_TTM
   Depends on [n]: HAS_IOMEM [=y] && DRM [=y] && MMU [=n]
   Selected by [y]:
   - DRM_TTM_HELPER [=y] && HAS_IOMEM [=y] && DRM [=y]
   - DRM_HISI_HIBMC [=y] && HAS_IOMEM [=y] && DRM [=y] && PCI [=y] && (ARM64 || COMPILE_TEST [=y])

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
