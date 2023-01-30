Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4966C681F7B
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 00:18:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbjA3XS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 18:18:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbjA3XS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 18:18:27 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C9327D63
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 15:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675120706; x=1706656706;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=gsY99mYKP8Tg5ldc1baYQY3jQMrcS6zWQEVh/tUYbeA=;
  b=M7dlN4zq2kyPnwSp7zFxsIJplTdYVA53BziJxsKnN4PMpnRJj3Pgc0FB
   cztt9nXf8XBgDzx/xhB7AOHVxLILSsUrlenSTEUqAs4tUki1Xgi7UtlN6
   wGMOK8BXn2OYvovHilDwK2jXgihg3U9VEBx4g0iYbrV0yO22MxVNJhCYb
   H+hfFq/HkvlPHygC3LNH/t1KyQ1284DRG50xadP78NRo806Xb0Br9XM33
   C3/TVVv9q/phuAEr7xfLwp3imDdTHxucKL6z0fwe9AotT9Rm6qk7m3XeO
   /3WaLcIOGhrvdAnfeeIjDe8gSuTV+hMbpmk5zV3mlNrJwBYPV1wIvptCZ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="315661729"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="315661729"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 15:18:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="641740907"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="641740907"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 30 Jan 2023 15:18:23 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pMdPq-0003xu-2G;
        Mon, 30 Jan 2023 23:18:22 +0000
Date:   Tue, 31 Jan 2023 07:18:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 41028e73cb56f2183227e3c4bf9e9c9aef5cda15
Message-ID: <63d85032.l4/Aa+G3p6NTUcHB%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 41028e73cb56f2183227e3c4bf9e9c9aef5cda15  Merge branch into tip/master: 'x86/vdso'

elapsed time: 721m

configs tested: 68
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
alpha                               defconfig
s390                             allmodconfig
s390                                defconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
m68k                             allmodconfig
alpha                            allyesconfig
m68k                             allyesconfig
arc                              allyesconfig
s390                             allyesconfig
x86_64                            allnoconfig
um                             i386_defconfig
um                           x86_64_defconfig
i386                 randconfig-a002-20230130
i386                 randconfig-a001-20230130
i386                 randconfig-a004-20230130
i386                 randconfig-a003-20230130
powerpc                           allnoconfig
sh                               allmodconfig
i386                 randconfig-a005-20230130
i386                 randconfig-a006-20230130
x86_64               randconfig-a001-20230130
x86_64               randconfig-a003-20230130
x86_64               randconfig-a004-20230130
x86_64               randconfig-a002-20230130
mips                             allyesconfig
powerpc                          allmodconfig
x86_64               randconfig-a006-20230130
x86_64               randconfig-a005-20230130
x86_64                              defconfig
x86_64                               rhel-8.3
arm                                 defconfig
i386                                defconfig
x86_64                           allyesconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-bpf
arm64                            allyesconfig
ia64                             allmodconfig
arm                              allyesconfig
arc                  randconfig-r043-20230129
arm                  randconfig-r046-20230129
arm                  randconfig-r046-20230130
arc                  randconfig-r043-20230130
i386                             allyesconfig

clang tested configs:
x86_64                          rhel-8.3-rust
i386                 randconfig-a013-20230130
i386                 randconfig-a012-20230130
i386                 randconfig-a014-20230130
i386                 randconfig-a011-20230130
i386                 randconfig-a015-20230130
i386                 randconfig-a016-20230130
x86_64               randconfig-a012-20230130
x86_64               randconfig-a013-20230130
x86_64               randconfig-a011-20230130
x86_64               randconfig-a014-20230130
x86_64               randconfig-a015-20230130
x86_64               randconfig-a016-20230130
hexagon              randconfig-r041-20230129
hexagon              randconfig-r045-20230130
hexagon              randconfig-r041-20230130
hexagon              randconfig-r045-20230129
s390                 randconfig-r044-20230129
riscv                randconfig-r042-20230129
riscv                randconfig-r042-20230130
s390                 randconfig-r044-20230130

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
