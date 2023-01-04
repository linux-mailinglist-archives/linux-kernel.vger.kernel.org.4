Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CEC965CD53
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 07:47:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234018AbjADGqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 01:46:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233680AbjADGp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 01:45:59 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB42186D3
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 22:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672814746; x=1704350746;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=0OZy2kgdGArGHEtGLZumYB/77Yk70EGO6La4WXF7ERU=;
  b=MlytUHmocXdMYwQxSm3R0PshE2ntE589mCTv0l/+8jKjP/yliYalXMYV
   ldT3VHiZ6byPEIT5OmGF+uU9SCRCok/QmO9mm9Jk5GGRjPqml61UmFOdT
   B0+JucBcuXS6zuYjRotH5RnLG+uMS0Bmp9HeJWfCjPdCTyt4+bX8ux097
   oja+Kf4GU/DmFHU0qk7xZKWw2TGtEYyQG412KTUWALVsCTc93cHh9r/K2
   J07LH4wP0iPDxsd7uHds0+ftPtX0Y/Rb2wukFOiJAdyyGRNFmOYsXZ4JS
   sOwutprbV7yiUeLrSBB/OgmzUj0kCuuFmSDC0U6xk0hqjjEr0JrVXEfIg
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="320566106"
X-IronPort-AV: E=Sophos;i="5.96,299,1665471600"; 
   d="scan'208";a="320566106"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 22:45:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="779101651"
X-IronPort-AV: E=Sophos;i="5.96,299,1665471600"; 
   d="scan'208";a="779101651"
Received: from lkp-server02.sh.intel.com (HELO 5bfee921edb0) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 03 Jan 2023 22:45:42 -0800
Received: from kbuild by 5bfee921edb0 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pCxWv-00003c-0a;
        Wed, 04 Jan 2023 06:45:41 +0000
Date:   Wed, 04 Jan 2023 14:45:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 08d1485bcd896e9516da6585c6dbce18ff466694
Message-ID: <63b52077.+vrf/p/GOVUj0LCx%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 08d1485bcd896e9516da6585c6dbce18ff466694  Merge branch into tip/master: 'perf/urgent'

elapsed time: 750m

configs tested: 68
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
x86_64                              defconfig
powerpc                           allnoconfig
i386                 randconfig-a004-20230102
s390                                defconfig
i386                 randconfig-a003-20230102
x86_64                               rhel-8.3
i386                 randconfig-a001-20230102
i386                 randconfig-a002-20230102
ia64                             allmodconfig
i386                 randconfig-a005-20230102
x86_64                    rhel-8.3-kselftests
i386                 randconfig-a006-20230102
x86_64                           allyesconfig
x86_64                          rhel-8.3-func
s390                             allyesconfig
i386                                defconfig
m68k                             allyesconfig
arm                                 defconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
x86_64                           rhel-8.3-bpf
riscv                randconfig-r042-20230101
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
arc                  randconfig-r043-20230102
x86_64                           rhel-8.3-kvm
i386                             allyesconfig
arm                  randconfig-r046-20230102
arc                  randconfig-r043-20230101
x86_64               randconfig-a001-20230102
s390                 randconfig-r044-20230101
x86_64               randconfig-a004-20230102
x86_64               randconfig-a002-20230102
x86_64               randconfig-a003-20230102
x86_64               randconfig-a005-20230102
x86_64               randconfig-a006-20230102
arm64                            allyesconfig
arm                              allyesconfig
sh                               allmodconfig
mips                             allyesconfig
powerpc                          allmodconfig
x86_64                            allnoconfig

clang tested configs:
x86_64                          rhel-8.3-rust
hexagon              randconfig-r041-20230102
hexagon              randconfig-r045-20230101
hexagon              randconfig-r045-20230102
x86_64               randconfig-a011-20230102
arm                  randconfig-r046-20230101
x86_64               randconfig-a014-20230102
i386                 randconfig-a011-20230102
x86_64               randconfig-a012-20230102
x86_64               randconfig-a013-20230102
riscv                randconfig-r042-20230102
hexagon              randconfig-r041-20230101
x86_64               randconfig-a015-20230102
i386                 randconfig-a014-20230102
x86_64               randconfig-a016-20230102
i386                 randconfig-a013-20230102
s390                 randconfig-r044-20230102
i386                 randconfig-a012-20230102
i386                 randconfig-a016-20230102
i386                 randconfig-a015-20230102

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
