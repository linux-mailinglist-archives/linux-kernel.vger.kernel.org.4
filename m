Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEAE95E8E24
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 17:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233837AbiIXPqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 11:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233838AbiIXPqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 11:46:43 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ADDE83071
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 08:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664034402; x=1695570402;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=nI52OXEFcx36co4Nof9iUlNp/cbMWTn6Ymk+WGqLkso=;
  b=PX7vgNK8F1YeqbWe58wEr6SRc0rmQ1HQSOrPIy7tbi5U72ZfMge0ceGS
   Iptdje61S6TIZGdYUzreuOPep2hNKtx0tXnJrb8PGYrbdAt022dIcYWRN
   q5a/bQPmYF+pMqsqr/Sjz0AuMc1gerjffUR2PSNGkPiCNCxGVXPHm5WUH
   /P6alnJfhk20VL3ZNxXnHrhlzgElrw9+Bmsv5E1x4TujtKnqakYlJupHa
   00o4SGUZpWA36J5WqMB0AvYnZ/0ombo7hqsM0azzYnagixgAdSd7o07ap
   X2roKFLpz0Wg9cXwFqsXSjY4c78ASsdrOXMGePKJfAOeKDqjChBSDpbFd
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10480"; a="287915607"
X-IronPort-AV: E=Sophos;i="5.93,342,1654585200"; 
   d="scan'208";a="287915607"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2022 08:46:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,342,1654585200"; 
   d="scan'208";a="683008485"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 24 Sep 2022 08:46:40 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oc7MV-0006j6-1p;
        Sat, 24 Sep 2022 15:46:39 +0000
Date:   Sat, 24 Sep 2022 23:46:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/cache] BUILD SUCCESS
 f7b1843eca6fe295ba0c71fc02a3291954078f2b
Message-ID: <632f2639.93s1k0OAFpkdgrDR%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cache
branch HEAD: f7b1843eca6fe295ba0c71fc02a3291954078f2b  x86/resctrl: Make resctrl_arch_rmid_read() return values in bytes

elapsed time: 1291m

configs tested: 120
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
alpha                               defconfig
um                             i386_defconfig
um                           x86_64_defconfig
s390                                defconfig
s390                             allmodconfig
s390                             allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
alpha                            allyesconfig
arc                              allyesconfig
arc                  randconfig-r043-20220923
s390                 randconfig-r044-20220923
riscv                randconfig-r042-20220923
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
i386                             allyesconfig
i386                                defconfig
ia64                             allmodconfig
sh                               allmodconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
xtensa                              defconfig
powerpc                     tqm8555_defconfig
arc                      axs103_smp_defconfig
i386                          randconfig-c001
x86_64                        randconfig-c001
arm                  randconfig-c002-20220923
nios2                            allyesconfig
m68k                        stmark2_defconfig
um                               alldefconfig
arm                         axm55xx_defconfig
powerpc                 mpc8540_ads_defconfig
xtensa                       common_defconfig
ia64                            zx1_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                         ap325rxa_defconfig
nios2                         10m50_defconfig
sh                          sdk7780_defconfig
m68k                         apollo_defconfig
arm                            hisi_defconfig
sh                          rsk7201_defconfig
nios2                         3c120_defconfig
loongarch                           defconfig
loongarch                         allnoconfig
loongarch                        allmodconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
sh                        edosk7760_defconfig
sh                        sh7785lcr_defconfig
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
arm64                               defconfig
ia64                             allyesconfig
arm                              allmodconfig
m68k                                defconfig
ia64                                defconfig
mips                             allmodconfig
powerpc                          allyesconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                            allyesconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016

clang tested configs:
hexagon              randconfig-r041-20220923
hexagon              randconfig-r045-20220923
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
arm                           sama7_defconfig
powerpc                    gamecube_defconfig
arm                         s3c2410_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
mips                       lemote2f_defconfig
powerpc                     ppa8548_defconfig
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
x86_64                        randconfig-k001
x86_64                        randconfig-c007
arm                  randconfig-c002-20220923
i386                          randconfig-c001
s390                 randconfig-c005-20220923
riscv                randconfig-c006-20220923
mips                 randconfig-c004-20220923
powerpc              randconfig-c003-20220923
powerpc                 mpc836x_mds_defconfig
mips                     cu1830-neo_defconfig
arm                       netwinder_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
