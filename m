Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBFE069C216
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 20:09:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbjBSTJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 14:09:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbjBSTJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 14:09:46 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EBF811168
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 11:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676833785; x=1708369785;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=RjNYzSm9YhsjWSAojgCBC77HpHJ8nAT7F6ZoOY5rBnQ=;
  b=P6L3c9W8j+Joemy+MJum9aKxmmL5qP/V7KNmS5pSGU1OJ587Ld+B+GY8
   X9Tf4hmgVjAnNM39BAafvgeAFYwriJHRV0A1/g39WTbvEj/aRwbAeXUcF
   U2fnbJT77Oyzk6z/n4cL2GXKbpXiq+wohKpRBXDSyVBStXYx3EcLb5lyM
   cPJJX7Dnu/EU+TVan8w1cByO7TPDF5c0JWoStMVEe7M1EpMUWJa3BXGcD
   SGJJoe5oOtbED+D5WWahNmoQ1hTsfJmelshRyBtlIHhN/2xJyWef/V6oI
   5AE8XKl3OvvQLScpMk6lImwUWjJSnEJUM0q6I4wIj04hBbhhQDB79ooZ5
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10626"; a="320395832"
X-IronPort-AV: E=Sophos;i="5.97,310,1669104000"; 
   d="scan'208";a="320395832"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2023 11:09:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10626"; a="739831007"
X-IronPort-AV: E=Sophos;i="5.97,310,1669104000"; 
   d="scan'208";a="739831007"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 19 Feb 2023 11:09:43 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pTp4A-000DQT-2g;
        Sun, 19 Feb 2023 19:09:42 +0000
Date:   Mon, 20 Feb 2023 03:08:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: drivers/gpu/drm/amd/amdgpu/amdgpu_rap.c:110:37: warning: unused
 variable 'amdgpu_rap_debugfs_ops'
Message-ID: <202302200339.Whql7Emr-lkp@intel.com>
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
head:   925cf0457d7e62ce08878ffb789189ac08ca8677
commit: df99e7bbbec3180693b3d932a9cbc88346e2a30e ARM: omap1: use pci_remap_iospace() for omap_cf
date:   10 months ago
config: arm-randconfig-r033-20230220 (https://download.01.org/0day-ci/archive/20230220/202302200339.Whql7Emr-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project db89896bbbd2251fff457699635acbbedeead27f)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=df99e7bbbec3180693b3d932a9cbc88346e2a30e
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout df99e7bbbec3180693b3d932a9cbc88346e2a30e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/gpu/drm/amd/amdgpu/ drivers/gpu/drm/amd/pm/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302200339.Whql7Emr-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/amd/amdgpu/amdgpu_rap.c:110:37: warning: unused variable 'amdgpu_rap_debugfs_ops' [-Wunused-const-variable]
   static const struct file_operations amdgpu_rap_debugfs_ops = {
                                       ^
   1 warning generated.
--
>> drivers/gpu/drm/amd/amdgpu/../pm/amdgpu_pm.c:38:34: warning: unused variable 'clocks' [-Wunused-const-variable]
   static const struct cg_flag_name clocks[] = {
                                    ^
   1 warning generated.


vim +/amdgpu_rap_debugfs_ops +110 drivers/gpu/drm/amd/amdgpu/amdgpu_rap.c

a4322e1881bed8 Wenhui Sheng 2020-08-11  109  
a4322e1881bed8 Wenhui Sheng 2020-08-11 @110  static const struct file_operations amdgpu_rap_debugfs_ops = {
a4322e1881bed8 Wenhui Sheng 2020-08-11  111  	.owner = THIS_MODULE,
a4322e1881bed8 Wenhui Sheng 2020-08-11  112  	.read = NULL,
a4322e1881bed8 Wenhui Sheng 2020-08-11  113  	.write = amdgpu_rap_debugfs_write,
a4322e1881bed8 Wenhui Sheng 2020-08-11  114  	.llseek = default_llseek
a4322e1881bed8 Wenhui Sheng 2020-08-11  115  };
a4322e1881bed8 Wenhui Sheng 2020-08-11  116  

:::::: The code at line 110 was first introduced by commit
:::::: a4322e1881bed80ddb904482f0b2e948fa7fd47e drm/amdgpu: add debugfs interface for RAP test

:::::: TO: Wenhui Sheng <Wenhui.Sheng@amd.com>
:::::: CC: Alex Deucher <alexander.deucher@amd.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
