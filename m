Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEFE767F89B
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 15:22:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234768AbjA1OWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 09:22:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232105AbjA1OWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 09:22:37 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF1F274B1
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 06:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674915756; x=1706451756;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=V5lLXgVPhyaLx/70bTYPv2aMCJ+mkSFYc6tuC8COTA8=;
  b=MrgjGAc3vWx/c5NJrXCqnNpPU30jxecRH888FZUm6FHEjpXi5wkhxcEu
   WdZjr1oMjsTKBVxYOhHcfgH1bXT/OUFTV/N8TRk8ceiSO8vj/ssEDQvrN
   ZsuHxDN7hrrNVhoXm541tK4AbNTmonFiyqaWObGV4rV5f38r7ch92MBZC
   /6XkTPChdiklabM+kgW9ujMc0cHNsGeeJqNhbyyMy11CkYogb2/E4L9+a
   qPtUvvU3ojymQAxcNUkX39K+Q9yJpxlqsKqoGdlUAn0r+yNM6DanqTEad
   /NW2aoGr29ChkFUpHudMjol4l77yOmYndQx3DC1Pcpsd00VLwlOYtf67l
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="389672814"
X-IronPort-AV: E=Sophos;i="5.97,254,1669104000"; 
   d="scan'208";a="389672814"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2023 06:22:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="641037423"
X-IronPort-AV: E=Sophos;i="5.97,254,1669104000"; 
   d="scan'208";a="641037423"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 28 Jan 2023 06:22:33 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pLm6C-0000ju-1U;
        Sat, 28 Jan 2023 14:22:32 +0000
Date:   Sat, 28 Jan 2023 22:22:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/core] BUILD SUCCESS
 ce3ba2af9695e4bd64d797e0026321e5dca29dd3
Message-ID: <63d52f96.1+TnCHkY1GQV4c+G%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/core
branch HEAD: ce3ba2af9695e4bd64d797e0026321e5dca29dd3  x86: Suppress KMSAN reports in arch_within_stack_frames()

elapsed time: 734m

configs tested: 82
configs skipped: 58

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                             allyesconfig
i386                                defconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64               randconfig-a002-20230123
x86_64               randconfig-a005-20230123
x86_64               randconfig-a001-20230123
x86_64               randconfig-a006-20230123
x86_64               randconfig-a003-20230123
x86_64               randconfig-a004-20230123
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                           rhel-8.3-bpf
x86_64                         rhel-8.3-kunit
i386                 randconfig-a004-20230123
i386                 randconfig-a006-20230123
i386                 randconfig-a005-20230123
i386                 randconfig-a002-20230123
i386                 randconfig-a003-20230123
i386                 randconfig-a001-20230123
um                           x86_64_defconfig
um                             i386_defconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
ia64                             allmodconfig
i386                 randconfig-c001-20230123
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
s390                             allyesconfig
m68k                         amcore_defconfig
powerpc                      makalu_defconfig
m68k                        mvme147_defconfig
m68k                          amiga_defconfig
mips                          rb532_defconfig

clang tested configs:
x86_64               randconfig-a013-20230123
x86_64               randconfig-a011-20230123
x86_64               randconfig-a016-20230123
x86_64               randconfig-a012-20230123
x86_64               randconfig-a015-20230123
x86_64               randconfig-a014-20230123
riscv                randconfig-r042-20230123
hexagon              randconfig-r041-20230123
hexagon              randconfig-r045-20230123
s390                 randconfig-r044-20230123
i386                 randconfig-a013-20230123
i386                 randconfig-a016-20230123
i386                 randconfig-a012-20230123
i386                 randconfig-a015-20230123
i386                 randconfig-a011-20230123
i386                 randconfig-a014-20230123
powerpc                 mpc832x_mds_defconfig
powerpc                      walnut_defconfig
arm                        mvebu_v5_defconfig
arm                           sama7_defconfig
x86_64                          rhel-8.3-rust
hexagon              randconfig-r041-20230124
hexagon              randconfig-r045-20230124
arm                  randconfig-r046-20230124

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
