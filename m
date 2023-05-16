Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03E4C705B87
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 01:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbjEPX6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 19:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbjEPX6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 19:58:42 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED12059E2
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 16:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684281520; x=1715817520;
  h=date:from:to:cc:subject:message-id;
  bh=18fpGhNgeOpUPswBZ0ow54g9ZARbHo7Zv4wOE59lByQ=;
  b=UMq9ulGFRxVJdQksyLChl4KAvWu53zrVa0GyMsHcbXAXnV5kj9j02peY
   FPgTWrkDm9uej5s7wjsOjWG6kRDWDG4G/wktmZ+mR4yMFmGs+xL6zMaHs
   EuBEwRPNWyT/FFzu3NcOyjTZTzC/JZ6CLKUuP8jtqOOcg2FBmlWj1Vrrd
   RepQfULLGTCHh/InuL/0Ksp01L2jqxcUkTOJOATnbd+PUIeM6SvDTuuWj
   myhNLNN14exfQqbww0W1VjceppufrvCTbYfP70GkcsEl1bXz0MRAAZWJC
   NQnoGatwX7rA8jd+L96wagxHCByz6X3n/oeWHyBxMXxqD5VAsGJu0jQGy
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="349120380"
X-IronPort-AV: E=Sophos;i="5.99,280,1677571200"; 
   d="scan'208";a="349120380"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 16:58:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="791265029"
X-IronPort-AV: E=Sophos;i="5.99,280,1677571200"; 
   d="scan'208";a="791265029"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 16 May 2023 16:58:39 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pz4Yw-0007wu-34;
        Tue, 16 May 2023 23:58:38 +0000
Date:   Wed, 17 May 2023 07:58:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:rcu/next] BUILD SUCCESS
 d6e962af2fdd2d10b19d962039238f94d483354b
Message-ID: <20230516235827.2DNke%lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: INFO setup_repo_specs: /db/releases/20230516180935/lkp-src/repo/*/paulmck-rcu
https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: d6e962af2fdd2d10b19d962039238f94d483354b  Merge branch 'atomicdoc.2023.05.11a' into HEAD

elapsed time: 720m

configs tested: 367
configs skipped: 23

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r001-20230515   gcc  
alpha        buildonly-randconfig-r003-20230515   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r004-20230515   gcc  
alpha                randconfig-r011-20230515   gcc  
alpha                randconfig-r013-20230515   gcc  
alpha                randconfig-r025-20230515   gcc  
alpha                randconfig-r032-20230515   gcc  
alpha                randconfig-r033-20230516   gcc  
alpha                randconfig-r036-20230516   gcc  
arc                              allyesconfig   gcc  
arc                          axs103_defconfig   gcc  
arc          buildonly-randconfig-r006-20230515   gcc  
arc                                 defconfig   gcc  
arc                        nsimosci_defconfig   gcc  
arc                  randconfig-r001-20230515   gcc  
arc                  randconfig-r015-20230516   gcc  
arc                  randconfig-r022-20230516   gcc  
arc                  randconfig-r043-20230515   gcc  
arc                  randconfig-r043-20230516   gcc  
arm                              alldefconfig   clang
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                          collie_defconfig   clang
arm                     davinci_all_defconfig   clang
arm                                 defconfig   gcc  
arm                            dove_defconfig   clang
arm                          pxa3xx_defconfig   gcc  
arm                            qcom_defconfig   gcc  
arm                  randconfig-r002-20230515   gcc  
arm                  randconfig-r004-20230515   gcc  
arm                  randconfig-r032-20230515   gcc  
arm                  randconfig-r036-20230515   gcc  
arm                  randconfig-r046-20230515   clang
arm                  randconfig-r046-20230516   gcc  
arm                  randconfig-r046-20230517   clang
arm                         socfpga_defconfig   clang
arm                           spitz_defconfig   clang
arm                           sunxi_defconfig   gcc  
arm                       versatile_defconfig   clang
arm64                            alldefconfig   gcc  
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r005-20230515   clang
arm64                               defconfig   gcc  
csky         buildonly-randconfig-r003-20230515   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r006-20230515   gcc  
csky                 randconfig-r011-20230515   gcc  
csky                 randconfig-r012-20230516   gcc  
csky                 randconfig-r023-20230515   gcc  
csky                 randconfig-r026-20230517   gcc  
csky                 randconfig-r031-20230516   gcc  
csky                 randconfig-r036-20230515   gcc  
hexagon              randconfig-r006-20230515   clang
hexagon              randconfig-r024-20230516   clang
hexagon              randconfig-r025-20230516   clang
hexagon              randconfig-r041-20230515   clang
hexagon              randconfig-r041-20230516   clang
hexagon              randconfig-r041-20230517   clang
hexagon              randconfig-r045-20230515   clang
hexagon              randconfig-r045-20230516   clang
hexagon              randconfig-r045-20230517   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r001-20230515   clang
i386         buildonly-randconfig-r005-20230515   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230515   clang
i386                 randconfig-a002-20230515   clang
i386                          randconfig-a002   clang
i386                 randconfig-a003-20230515   clang
i386                 randconfig-a004-20230515   clang
i386                          randconfig-a004   clang
i386                 randconfig-a005-20230515   clang
i386                 randconfig-a006-20230515   clang
i386                          randconfig-a006   clang
i386                 randconfig-a011-20230515   gcc  
i386                 randconfig-a012-20230515   gcc  
i386                          randconfig-a012   gcc  
i386                 randconfig-a013-20230515   gcc  
i386                 randconfig-a014-20230515   gcc  
i386                          randconfig-a014   gcc  
i386                 randconfig-a015-20230515   gcc  
i386                 randconfig-a016-20230515   gcc  
i386                          randconfig-a016   gcc  
i386                 randconfig-i051-20230515   clang
i386                 randconfig-i052-20230515   clang
i386                          randconfig-i052   clang
i386                 randconfig-i053-20230515   clang
i386                 randconfig-i054-20230515   clang
i386                          randconfig-i054   clang
i386                 randconfig-i055-20230515   clang
i386                 randconfig-i056-20230515   clang
i386                          randconfig-i056   clang
i386                 randconfig-i061-20230515   clang
i386                 randconfig-i062-20230515   clang
i386                          randconfig-i062   clang
i386                 randconfig-i063-20230515   clang
i386                 randconfig-i064-20230515   clang
i386                          randconfig-i064   clang
i386                 randconfig-i065-20230515   clang
i386                 randconfig-i066-20230515   clang
i386                          randconfig-i066   clang
i386                 randconfig-i071-20230515   gcc  
i386                          randconfig-i071   clang
i386                 randconfig-i072-20230515   gcc  
i386                 randconfig-i073-20230515   gcc  
i386                          randconfig-i073   clang
i386                 randconfig-i074-20230515   gcc  
i386                 randconfig-i075-20230515   gcc  
i386                          randconfig-i075   clang
i386                 randconfig-i076-20230515   gcc  
i386                 randconfig-i081-20230515   gcc  
i386                 randconfig-i082-20230515   gcc  
i386                          randconfig-i082   clang
i386                 randconfig-i083-20230515   gcc  
i386                 randconfig-i084-20230515   gcc  
i386                          randconfig-i084   clang
i386                 randconfig-i085-20230515   gcc  
i386                 randconfig-i086-20230515   gcc  
i386                          randconfig-i086   clang
i386                 randconfig-i091-20230515   clang
i386                 randconfig-i092-20230515   clang
i386                 randconfig-i093-20230515   clang
i386                 randconfig-i094-20230515   clang
i386                 randconfig-i095-20230515   clang
i386                 randconfig-i096-20230515   clang
i386                 randconfig-r014-20230515   gcc  
i386                 randconfig-r016-20230515   gcc  
ia64                             allmodconfig   gcc  
ia64                         bigsur_defconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r005-20230515   gcc  
ia64                 randconfig-r024-20230516   gcc  
ia64                 randconfig-r032-20230516   gcc  
ia64                 randconfig-r033-20230515   gcc  
ia64                          tiger_defconfig   gcc  
ia64                            zx1_defconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r021-20230515   gcc  
loongarch            randconfig-r023-20230516   gcc  
loongarch            randconfig-r031-20230515   gcc  
loongarch            randconfig-r033-20230515   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r001-20230515   gcc  
m68k         buildonly-randconfig-r002-20230515   gcc  
m68k         buildonly-randconfig-r004-20230515   gcc  
m68k                                defconfig   gcc  
m68k                            mac_defconfig   gcc  
m68k                        mvme147_defconfig   gcc  
m68k                            q40_defconfig   gcc  
m68k                 randconfig-r002-20230516   gcc  
m68k                 randconfig-r005-20230515   gcc  
m68k                 randconfig-r022-20230515   gcc  
m68k                 randconfig-r033-20230515   gcc  
m68k                        stmark2_defconfig   gcc  
microblaze           randconfig-r012-20230515   gcc  
microblaze           randconfig-r013-20230515   gcc  
microblaze           randconfig-r015-20230515   gcc  
microblaze           randconfig-r021-20230515   gcc  
microblaze           randconfig-r036-20230516   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                        bcm47xx_defconfig   gcc  
mips                        bcm63xx_defconfig   clang
mips                         bigsur_defconfig   gcc  
mips                      bmips_stb_defconfig   clang
mips         buildonly-randconfig-r006-20230515   gcc  
mips                           ip28_defconfig   clang
mips                     loongson1c_defconfig   clang
mips                      maltaaprp_defconfig   clang
mips                      maltasmvp_defconfig   gcc  
mips                 randconfig-r002-20230515   gcc  
mips                 randconfig-r004-20230515   gcc  
mips                           rs90_defconfig   clang
nios2                         3c120_defconfig   gcc  
nios2        buildonly-randconfig-r005-20230515   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r005-20230515   gcc  
nios2                randconfig-r005-20230516   gcc  
nios2                randconfig-r011-20230515   gcc  
nios2                randconfig-r021-20230515   gcc  
nios2                randconfig-r022-20230515   gcc  
nios2                randconfig-r023-20230515   gcc  
nios2                randconfig-r024-20230515   gcc  
nios2                randconfig-r034-20230515   gcc  
openrisc     buildonly-randconfig-r006-20230515   gcc  
openrisc             randconfig-r014-20230515   gcc  
openrisc                       virt_defconfig   gcc  
parisc                           alldefconfig   gcc  
parisc       buildonly-randconfig-r001-20230515   gcc  
parisc       buildonly-randconfig-r004-20230515   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r003-20230515   gcc  
parisc               randconfig-r006-20230516   gcc  
parisc               randconfig-r013-20230515   gcc  
parisc               randconfig-r015-20230515   gcc  
parisc               randconfig-r026-20230515   gcc  
parisc               randconfig-r026-20230516   gcc  
parisc               randconfig-r031-20230515   gcc  
parisc               randconfig-r031-20230516   gcc  
parisc               randconfig-r032-20230516   gcc  
parisc               randconfig-r034-20230516   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                      arches_defconfig   gcc  
powerpc                        cell_defconfig   gcc  
powerpc                       ebony_defconfig   clang
powerpc                        fsp2_defconfig   clang
powerpc                        icon_defconfig   clang
powerpc                      makalu_defconfig   gcc  
powerpc                   microwatt_defconfig   clang
powerpc                 mpc832x_rdb_defconfig   clang
powerpc                 mpc834x_itx_defconfig   gcc  
powerpc                 mpc836x_rdk_defconfig   clang
powerpc                 mpc8560_ads_defconfig   clang
powerpc                      pmac32_defconfig   clang
powerpc                     ppa8548_defconfig   clang
powerpc              randconfig-r001-20230515   clang
powerpc              randconfig-r004-20230515   clang
powerpc              randconfig-r025-20230517   gcc  
powerpc                    sam440ep_defconfig   gcc  
powerpc                     skiroot_defconfig   clang
powerpc                    socrates_defconfig   clang
powerpc                     stx_gp3_defconfig   gcc  
powerpc                     tqm8560_defconfig   clang
powerpc                      tqm8xx_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r002-20230515   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r004-20230515   clang
riscv                randconfig-r004-20230516   gcc  
riscv                randconfig-r012-20230515   gcc  
riscv                randconfig-r022-20230517   gcc  
riscv                randconfig-r025-20230515   gcc  
riscv                randconfig-r042-20230515   gcc  
riscv                randconfig-r042-20230516   clang
riscv                          rv32_defconfig   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r002-20230515   gcc  
s390         buildonly-randconfig-r003-20230515   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r004-20230515   clang
s390                 randconfig-r012-20230515   gcc  
s390                 randconfig-r013-20230515   gcc  
s390                 randconfig-r022-20230516   clang
s390                 randconfig-r024-20230515   gcc  
s390                 randconfig-r026-20230516   clang
s390                 randconfig-r032-20230515   clang
s390                 randconfig-r033-20230515   clang
s390                 randconfig-r044-20230515   gcc  
s390                 randconfig-r044-20230516   clang
sh                               allmodconfig   gcc  
sh                        apsh4ad0a_defconfig   gcc  
sh           buildonly-randconfig-r005-20230515   gcc  
sh                        dreamcast_defconfig   gcc  
sh                          landisk_defconfig   gcc  
sh                          lboxre2_defconfig   gcc  
sh                            migor_defconfig   gcc  
sh                   randconfig-r001-20230515   gcc  
sh                   randconfig-r011-20230516   gcc  
sh                   randconfig-r013-20230516   gcc  
sh                   randconfig-r015-20230515   gcc  
sh                   randconfig-r024-20230515   gcc  
sh                   randconfig-r032-20230515   gcc  
sh                   randconfig-r034-20230515   gcc  
sh                   randconfig-r036-20230516   gcc  
sh                          sdk7786_defconfig   gcc  
sh                     sh7710voipgw_defconfig   gcc  
sh                   sh7770_generic_defconfig   gcc  
sh                            shmin_defconfig   gcc  
sh                             shx3_defconfig   gcc  
sparc                            alldefconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r015-20230515   gcc  
sparc64      buildonly-randconfig-r004-20230515   gcc  
sparc64      buildonly-randconfig-r006-20230515   gcc  
sparc64              randconfig-r011-20230515   gcc  
sparc64              randconfig-r012-20230515   gcc  
sparc64              randconfig-r033-20230516   gcc  
sparc64              randconfig-r035-20230516   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r002-20230515   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230515   clang
x86_64                        randconfig-a001   clang
x86_64               randconfig-a002-20230515   clang
x86_64               randconfig-a003-20230515   clang
x86_64                        randconfig-a003   clang
x86_64               randconfig-a004-20230515   clang
x86_64               randconfig-a005-20230515   clang
x86_64                        randconfig-a005   clang
x86_64               randconfig-a006-20230515   clang
x86_64               randconfig-a011-20230515   gcc  
x86_64               randconfig-a012-20230515   gcc  
x86_64                        randconfig-a012   clang
x86_64               randconfig-a013-20230515   gcc  
x86_64               randconfig-a014-20230515   gcc  
x86_64                        randconfig-a014   clang
x86_64               randconfig-a015-20230515   gcc  
x86_64               randconfig-a016-20230515   gcc  
x86_64                        randconfig-a016   clang
x86_64               randconfig-k001-20230515   gcc  
x86_64               randconfig-r011-20230515   gcc  
x86_64               randconfig-r014-20230515   gcc  
x86_64               randconfig-r016-20230515   gcc  
x86_64               randconfig-x051-20230515   gcc  
x86_64               randconfig-x052-20230515   gcc  
x86_64                        randconfig-x052   clang
x86_64               randconfig-x053-20230515   gcc  
x86_64               randconfig-x054-20230515   gcc  
x86_64                        randconfig-x054   clang
x86_64               randconfig-x055-20230515   gcc  
x86_64               randconfig-x056-20230515   gcc  
x86_64                        randconfig-x056   clang
x86_64               randconfig-x061-20230515   gcc  
x86_64                        randconfig-x061   gcc  
x86_64               randconfig-x062-20230515   gcc  
x86_64               randconfig-x063-20230515   gcc  
x86_64                        randconfig-x063   gcc  
x86_64               randconfig-x064-20230515   gcc  
x86_64               randconfig-x065-20230515   gcc  
x86_64                        randconfig-x065   gcc  
x86_64               randconfig-x066-20230515   gcc  
x86_64               randconfig-x071-20230515   clang
x86_64               randconfig-x072-20230515   clang
x86_64               randconfig-x073-20230515   clang
x86_64               randconfig-x074-20230515   clang
x86_64               randconfig-x075-20230515   clang
x86_64               randconfig-x076-20230515   clang
x86_64               randconfig-x081-20230515   clang
x86_64               randconfig-x082-20230515   clang
x86_64                        randconfig-x082   clang
x86_64               randconfig-x083-20230515   clang
x86_64               randconfig-x084-20230515   clang
x86_64                        randconfig-x084   clang
x86_64               randconfig-x085-20230515   clang
x86_64               randconfig-x086-20230515   clang
x86_64                        randconfig-x086   clang
x86_64               randconfig-x091-20230515   gcc  
x86_64               randconfig-x092-20230515   gcc  
x86_64                        randconfig-x092   gcc  
x86_64               randconfig-x093-20230515   gcc  
x86_64               randconfig-x094-20230515   gcc  
x86_64                        randconfig-x094   gcc  
x86_64               randconfig-x095-20230515   gcc  
x86_64               randconfig-x096-20230515   gcc  
x86_64                        randconfig-x096   gcc  
x86_64                          rhel-8.3-func   gcc  
x86_64                    rhel-8.3-kselftests   gcc  
x86_64                           rhel-8.3-ltp   gcc  
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r001-20230515   gcc  
xtensa               randconfig-r003-20230515   gcc  
xtensa               randconfig-r021-20230517   gcc  
xtensa               randconfig-r036-20230515   gcc  
xtensa                    smp_lx200_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
