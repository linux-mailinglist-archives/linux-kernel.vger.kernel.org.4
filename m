Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB576609B1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 23:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbjAFWwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 17:52:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbjAFWwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 17:52:13 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E227DE30
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 14:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673045532; x=1704581532;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=0Zl7mBROYl2CpyNWx//+R7xYObnzhz5Vdx4Cy7QeZX8=;
  b=Sv84FMg7LyCsWxEYWs2pXDUC0nzGhUkHk0XcJ/43yL5lpTMjvcAxHueR
   01w3x0Z1V0w+l4i/7z2L/gyyRgsEIv/APgxgssiDfRa6RxsUtqUUsNxUk
   AZA2LLjqSTisqDnlNTb8UMt6HxqiAFcQ2P+WgOk7fuESbhU1N0g6d1TZs
   73/yCYqWvHkyKNGdG4mgzKLZT3tjctHx7Wpza+DYpaiakt5tswOr4+zWT
   NZvLIq4Hv20egTYd3uYPFX7eLtUaPNaRNb2Zc7LmRZP+573QKPhjhprmg
   tzby2XZfzIE41mfwA9xrRFA37aDQtHD//yE9qPfnVYbJP2g3PncNHs2y5
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10582"; a="323829730"
X-IronPort-AV: E=Sophos;i="5.96,306,1665471600"; 
   d="scan'208";a="323829730"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2023 14:52:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10582"; a="901425368"
X-IronPort-AV: E=Sophos;i="5.96,306,1665471600"; 
   d="scan'208";a="901425368"
Received: from lkp-server02.sh.intel.com (HELO f1920e93ebb5) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 06 Jan 2023 14:52:10 -0800
Received: from kbuild by f1920e93ebb5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pDvZJ-0003yZ-1P;
        Fri, 06 Jan 2023 22:52:09 +0000
Date:   Sat, 07 Jan 2023 06:51:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/platform] BUILD SUCCESS
 bd4edba2653aeef0119b7a945f07e58711343bf9
Message-ID: <63b8a60b.4TUZSdlriZ0EJ95M%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/platform
branch HEAD: bd4edba2653aeef0119b7a945f07e58711343bf9  x86/rtc: Simplify PNP ids check

elapsed time: 722m

configs tested: 100
configs skipped: 66

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                           rhel-8.3-bpf
x86_64                            allnoconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
i386                             allyesconfig
i386                                defconfig
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
x86_64                        randconfig-a004
x86_64                        randconfig-a006
x86_64                        randconfig-a002

clang tested configs:
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
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
x86_64                        randconfig-k001
x86_64                          rhel-8.3-rust
arm                          moxart_defconfig
arm                        neponset_defconfig
x86_64                           allyesconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
