Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF766685CCD
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 02:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjBABrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 20:47:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjBABri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 20:47:38 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C3C5264
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 17:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675216057; x=1706752057;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=dPmf5TQp2UYw82GbuaSilQZAkNrXZ4eOmKlNSAd4A9o=;
  b=X9wpHphDEM7YrHYFuy1Hl4/Z7MepxMRkYVxOpOTr3K5tVsk+PbysgezS
   DLN3P4YoOcAqHGe7/ZJDAC5+TMRXX0vtWyn7hOrNN5NRJSBOovpIUwmHG
   W0gcQA9DC4IdOSnRxDVSqpJf9pqAqgMP1QA8s1O3JzQQv0cOCjniyyAim
   dZiq6mE8ZJzLzgg3FrtQKr7uwSzpK656NYibtBLMy3tbieaH1W7PKDGgN
   o0OPk4ib2DresVJ+8Ui9YMcgN03x6t3wBAnD/FRdOWdR9e820UbEHTD/U
   iquV2bwXZ3NtsJp0vgVUoCMydAIMKAbUZ5INhsFE+5qp2X+7TuJvYDyFl
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="390381865"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; 
   d="scan'208";a="390381865"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 17:47:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="695157227"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; 
   d="scan'208";a="695157227"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 31 Jan 2023 17:47:36 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pN2Dn-0004tk-1V;
        Wed, 01 Feb 2023 01:47:35 +0000
Date:   Wed, 01 Feb 2023 09:46:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:timers/core] BUILD SUCCESS
 cbdb1f163af2bb90d01be1f0263df1d8d5c9d9d3
Message-ID: <63d9c47c.Ec4h2uT+V3Y7R1aT%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core
branch HEAD: cbdb1f163af2bb90d01be1f0263df1d8d5c9d9d3  vdso/bits.h: Add BIT_ULL() for the sake of consistency

elapsed time: 721m

configs tested: 79
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
i386                                defconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
x86_64                            allnoconfig
s390                                defconfig
s390                             allyesconfig
i386                             allyesconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
powerpc                           allnoconfig
ia64                             allmodconfig
x86_64                               rhel-8.3
x86_64               randconfig-a001-20230130
x86_64               randconfig-a003-20230130
x86_64               randconfig-a002-20230130
x86_64               randconfig-a004-20230130
x86_64                           allyesconfig
x86_64               randconfig-a006-20230130
i386                 randconfig-a001-20230130
x86_64               randconfig-a005-20230130
i386                 randconfig-a004-20230130
x86_64                           rhel-8.3-syz
sh                               allmodconfig
x86_64                         rhel-8.3-kunit
i386                 randconfig-a003-20230130
x86_64                           rhel-8.3-kvm
i386                 randconfig-a002-20230130
x86_64                           rhel-8.3-bpf
i386                 randconfig-a006-20230130
i386                 randconfig-a005-20230130
mips                             allyesconfig
powerpc                          allmodconfig
m68k                             allyesconfig
arc                  randconfig-r043-20230129
m68k                             allmodconfig
alpha                            allyesconfig
arc                              allyesconfig
arm                  randconfig-r046-20230129
arm                  randconfig-r046-20230130
arc                  randconfig-r043-20230130
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig
i386                          randconfig-c001
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func

clang tested configs:
x86_64                          rhel-8.3-rust
hexagon              randconfig-r041-20230129
riscv                randconfig-r042-20230129
x86_64               randconfig-a014-20230130
hexagon              randconfig-r045-20230130
x86_64               randconfig-a012-20230130
hexagon              randconfig-r041-20230130
x86_64               randconfig-a013-20230130
hexagon              randconfig-r045-20230129
x86_64               randconfig-a011-20230130
s390                 randconfig-r044-20230129
s390                 randconfig-r044-20230130
riscv                randconfig-r042-20230130
x86_64               randconfig-a016-20230130
x86_64               randconfig-a015-20230130
i386                 randconfig-a013-20230130
i386                 randconfig-a012-20230130
i386                 randconfig-a014-20230130
i386                 randconfig-a011-20230130
i386                 randconfig-a015-20230130
i386                 randconfig-a016-20230130
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
