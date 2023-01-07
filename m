Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 805E3661280
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 00:08:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232596AbjAGXIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 18:08:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjAGXIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 18:08:21 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD6E271A3
        for <linux-kernel@vger.kernel.org>; Sat,  7 Jan 2023 15:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673132900; x=1704668900;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=FEClc4IcVo/04qQZEiAdtvw6Ra+gP5pskufyMd6Nn+g=;
  b=gdET8uvK157WSCHQ2OiUE8ZEWwlwNSPMaZkd95CyZ3ofKECxnIL3TR8S
   pDSHKjRpYLvCkQzi61PvUl/PZc5Wm7jdurNsMdrvikepIvo92Sh3Wyyle
   kcnAyndCffxXyImuvV3zPTmERAhfvbqCFDOwhvJvJdPoI/sln+EJ0lWMX
   WqVy3HmvTbLuRWYts3YU5oIfNKfONtUmFYSbE8t8EWAPeuVVmQSwg9r27
   8QVj7FVcBFkOU7O5x1YWlKegKhykNkFPACy7UumzbtctV4BtoBmR5yKPw
   1dPYX1uOrg6XREtCF78TNEmaU/tNjdSugU7NlMfocT+LfZkEsW15lYj+Y
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10583"; a="321384228"
X-IronPort-AV: E=Sophos;i="5.96,309,1665471600"; 
   d="scan'208";a="321384228"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2023 15:08:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10583"; a="686815070"
X-IronPort-AV: E=Sophos;i="5.96,309,1665471600"; 
   d="scan'208";a="686815070"
Received: from lkp-server02.sh.intel.com (HELO f1920e93ebb5) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 07 Jan 2023 15:08:18 -0800
Received: from kbuild by f1920e93ebb5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pEIIU-0004vK-01;
        Sat, 07 Jan 2023 23:08:18 +0000
Date:   Sun, 08 Jan 2023 07:07:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:objtool/core] BUILD SUCCESS
 3da73f102309fe29150e5c35acd20dd82063ff67
Message-ID: <63b9fb2b.t9d8bUqsmWjmg+QL%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool/core
branch HEAD: 3da73f102309fe29150e5c35acd20dd82063ff67  objtool: Fix memory leak in create_static_call_sections()

elapsed time: 723m

configs tested: 103
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
powerpc                           allnoconfig
sh                               allmodconfig
mips                             allyesconfig
arc                                 defconfig
x86_64                        randconfig-a004
alpha                               defconfig
x86_64                        randconfig-a002
s390                             allmodconfig
x86_64                              defconfig
x86_64                           rhel-8.3-bpf
s390                                defconfig
arm                                 defconfig
arm64                            allyesconfig
powerpc                          allmodconfig
s390                             allyesconfig
i386                          randconfig-a014
i386                                defconfig
x86_64                    rhel-8.3-kselftests
i386                          randconfig-a012
um                             i386_defconfig
x86_64                           rhel-8.3-syz
i386                          randconfig-a016
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                        randconfig-a006
x86_64                           rhel-8.3-kvm
arm                              allyesconfig
um                           x86_64_defconfig
i386                          randconfig-a001
ia64                             allmodconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
i386                          randconfig-a003
x86_64                           allyesconfig
x86_64                        randconfig-a015
i386                          randconfig-a005
m68k                             allyesconfig
m68k                             allmodconfig
alpha                            allyesconfig
arc                              allyesconfig
arc                  randconfig-r043-20230107
arc                  randconfig-r043-20230106
i386                             allyesconfig
arm                  randconfig-r046-20230106
s390                 randconfig-r044-20230107
riscv                randconfig-r042-20230107
sh                          rsk7264_defconfig
x86_64                           alldefconfig
powerpc                      ppc40x_defconfig
arc                              alldefconfig
mips                           ci20_defconfig
arm                        cerfcube_defconfig
m68k                        mvme147_defconfig
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
xtensa                  cadence_csp_defconfig
sh                           se7722_defconfig
mips                            gpr_defconfig
arm                        trizeps4_defconfig
nios2                         3c120_defconfig
loongarch                           defconfig
loongarch                         allnoconfig
loongarch                        allmodconfig
s390                       zfcpdump_defconfig
arm                           imxrt_defconfig
arc                            hsdk_defconfig

clang tested configs:
i386                          randconfig-a013
x86_64                          rhel-8.3-rust
x86_64                        randconfig-a001
i386                          randconfig-a011
i386                          randconfig-a015
x86_64                        randconfig-a003
x86_64                        randconfig-a005
x86_64                        randconfig-a012
i386                          randconfig-a002
x86_64                        randconfig-a014
i386                          randconfig-a004
x86_64                        randconfig-a016
i386                          randconfig-a006
arm                  randconfig-r046-20230107
hexagon              randconfig-r041-20230107
hexagon              randconfig-r045-20230107
hexagon              randconfig-r041-20230106
riscv                randconfig-r042-20230106
hexagon              randconfig-r045-20230106
s390                 randconfig-r044-20230106
arm                       aspeed_g4_defconfig
powerpc                     mpc5200_defconfig
arm                         palmz72_defconfig
arm                         orion5x_defconfig
arm                           spitz_defconfig
x86_64                        randconfig-k001
arm                       imx_v4_v5_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
