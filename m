Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF8C6609B2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 23:52:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235699AbjAFWwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 17:52:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjAFWwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 17:52:13 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D1C2809AE
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 14:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673045532; x=1704581532;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=mcmUCZl/VQyTc2tU/jnd9FUHboFKs2zBWBLo21xy6CI=;
  b=BeqVUSZr659EeKOtETvYtVgPZajlcdPPXUec8RBewE455zhc6VvgQPol
   +io+0IfYZvdzlXTLqsXJI7oMM09UysI/MGWMa5TBjVyeNplMTcBSa17iB
   C+ux7VQfwF3WRtqYQBkhkA2z3zyA8lplET0Qh+47LsY5OwgsZkgu4JXbu
   jFUZc8tbzMhDzk13rYiTiBMkT83W3KfB6aix50324SR66WiFAEd55ogTj
   ZUWBpG+rz5SWz/gxzbKkDSkuSkSY7Z664uyRcTB6NuSSw0yFSnUm1Mu1i
   TZoo0Hl0wan5qeaNRENLDhzXmjXXJndRo7/0Ab0GP0ujgTZHF9743tN+s
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10582"; a="302279777"
X-IronPort-AV: E=Sophos;i="5.96,306,1665471600"; 
   d="scan'208";a="302279777"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2023 14:52:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10582"; a="686614116"
X-IronPort-AV: E=Sophos;i="5.96,306,1665471600"; 
   d="scan'208";a="686614116"
Received: from lkp-server02.sh.intel.com (HELO f1920e93ebb5) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 06 Jan 2023 14:52:10 -0800
Received: from kbuild by f1920e93ebb5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pDvZJ-0003yW-14;
        Fri, 06 Jan 2023 22:52:09 +0000
Date:   Sat, 07 Jan 2023 06:52:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/core] BUILD SUCCESS
 6be9a8f18fb2ea88d37a69f076f7011fc012ae1a
Message-ID: <63b8a610.NbfRd2lGxLbRo0f0%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/core
branch HEAD: 6be9a8f18fb2ea88d37a69f076f7011fc012ae1a  x86/signal/compat: Move sigaction_compat_abi() to signal_64.c

elapsed time: 722m

configs tested: 100
configs skipped: 66

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                            allnoconfig
x86_64                        randconfig-a006
i386                             allyesconfig
i386                                defconfig
x86_64                           rhel-8.3-bpf
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
s390                             allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
ia64                             allmodconfig
sh                                  defconfig
x86_64                           alldefconfig
mips                         rt305x_defconfig
um                           x86_64_defconfig
um                             i386_defconfig
sh                ecovec24-romimage_defconfig
sh                        dreamcast_defconfig
sh                           se7619_defconfig
mips                            gpr_defconfig
sh                           se7724_defconfig
sh                     magicpanelr2_defconfig
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
arm                            lart_defconfig
arm                        cerfcube_defconfig
mips                         db1xxx_defconfig
powerpc                      ppc6xx_defconfig
mips                         cobalt_defconfig
sparc64                             defconfig
powerpc                       ppc64_defconfig
sh                            titan_defconfig
ia64                             alldefconfig
powerpc                     mpc83xx_defconfig
powerpc                      ppc40x_defconfig
arc                              alldefconfig
mips                           ci20_defconfig
m68k                        mvme147_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                          randconfig-c001

clang tested configs:
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
s390                 randconfig-r044-20230106
hexagon              randconfig-r041-20230106
hexagon              randconfig-r045-20230106
riscv                randconfig-r042-20230106
arm                      pxa255-idp_defconfig
powerpc                 mpc8560_ads_defconfig
powerpc                   bluestone_defconfig
mips                       rbtx49xx_defconfig
arm                              alldefconfig
hexagon                             defconfig
arm                       cns3420vb_defconfig
powerpc                 xes_mpc85xx_defconfig
powerpc                          g5_defconfig
arm                          ixp4xx_defconfig
x86_64                          rhel-8.3-rust
x86_64                        randconfig-k001
arm                          moxart_defconfig
arm                        neponset_defconfig
x86_64                           allyesconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
