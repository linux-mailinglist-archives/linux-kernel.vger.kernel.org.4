Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1BAB668923
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 02:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240516AbjAMB3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 20:29:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239995AbjAMB3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 20:29:23 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66BC15D8B2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 17:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673573362; x=1705109362;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=OHUcCdetloL8yXlR/LtCohMn3tBrcJwkpfwskBg2NPs=;
  b=Ela0oljRGNIsK24RchimI2JiczVLZ8tBc5i8I5rzS1k07vCcXM5/jYKq
   7dkvVejaLEdDr4ocyKkLRbInZ02C6Lt9/bijvRoXyY2jvqrVJ88zf9TAU
   ny4If8/3Dtwhkb+Sf4Mkam1dljcOVLf5VJZQcit0zhZGrLycXICxo+LF8
   64rfK/Nzg026PrmBUdcby1xojhKQE9qmAnEwnji9xkzTvvtx0V+I+dMvz
   +rTDq2qFwG+Qq64CXLWpmXcKksmkcvVxbUz05ILOD7YdSWaGy6Xq7Muxt
   NI6Idph2ewoh7wLfvuTe7sgIGb9ORaDdKVOfnq6dYPXjL7gU6O80otK7n
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="323943940"
X-IronPort-AV: E=Sophos;i="5.97,212,1669104000"; 
   d="scan'208";a="323943940"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 17:29:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="746763778"
X-IronPort-AV: E=Sophos;i="5.97,212,1669104000"; 
   d="scan'208";a="746763778"
Received: from lkp-server02.sh.intel.com (HELO f1920e93ebb5) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Jan 2023 17:29:20 -0800
Received: from kbuild by f1920e93ebb5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pG8sc-000AbA-33;
        Fri, 13 Jan 2023 01:29:14 +0000
Date:   Fri, 13 Jan 2023 09:28:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/cpu] BUILD SUCCESS
 ae53fa18703000f507107df43efd1168a0365361
Message-ID: <63c0b3cc.zrlIqc6RzglJDVNr%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cpu
branch HEAD: ae53fa18703000f507107df43efd1168a0365361  x86/gsseg: Move load_gs_index() to its own new header file

elapsed time: 723m

configs tested: 93
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
s390                             allyesconfig
arm                      integrator_defconfig
sh                           se7721_defconfig
m68k                          atari_defconfig
arc                          axs103_defconfig
m68k                       bvme6000_defconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                           rhel-8.3-bpf
x86_64                         rhel-8.3-kunit
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
riscv                randconfig-r042-20230112
s390                 randconfig-r044-20230112
arc                  randconfig-r043-20230112
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                             allyesconfig
i386                                defconfig
ia64                             allmodconfig
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
powerpc                      mgcoge_defconfig
sh                          urquell_defconfig
sh                           se7712_defconfig
arm                          pxa3xx_defconfig
sh                         ap325rxa_defconfig
sh                         microdev_defconfig
arm                           h3600_defconfig
arm                               allnoconfig
alpha                            alldefconfig
arc                              alldefconfig
sparc                       sparc64_defconfig
sh                        apsh4ad0a_defconfig
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
sh                        edosk7760_defconfig
arc                      axs103_smp_defconfig
mips                     decstation_defconfig
powerpc                        cell_defconfig
sh                           se7705_defconfig
powerpc                 mpc834x_mds_defconfig
arm                           viper_defconfig

clang tested configs:
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
powerpc                          g5_defconfig
mips                          malta_defconfig
powerpc                 mpc8272_ads_defconfig
powerpc               mpc834x_itxgp_defconfig
mips                      maltaaprp_defconfig
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                          rhel-8.3-rust
x86_64                        randconfig-k001
powerpc                      walnut_defconfig
s390                             alldefconfig
mips                       rbtx49xx_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
