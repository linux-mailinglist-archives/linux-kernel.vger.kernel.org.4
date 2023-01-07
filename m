Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1568B661298
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 00:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232773AbjAGXg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 18:36:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbjAGXg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 18:36:26 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9403862E1
        for <linux-kernel@vger.kernel.org>; Sat,  7 Jan 2023 15:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673134584; x=1704670584;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=JOJRizaGtDmWZTxbxlD6oL/WX7cTQQ54GS0R9qHSBTA=;
  b=ICdg719Ayn9siQ/I+uahbvLusCepYZFU9HIPE3HS9S2AHz5ovW+VR4qM
   RfR5Ba1pdCe0+sxMNMCeNAba5DOfwLqyRFmcUpDuVUaG2kPERwxNPFA78
   6fwdSPzOB+Q53HVe41t7wfgJDRk3k1ZuLBirSoRizchN1scqQbt7RXx8e
   WSPKuO4VqRU5F2Dq0Fu8yztwY3hpyIcNmOBepT20MXPDttZjOsEp3O7L5
   z3nutaYrqeNGYH4Pz1v0qNzDlzGWkal4cDY+/jHGzdvy2sA48eABp7NU7
   +nw1CT7t/0YBCOqPZZLGlB+GLCAnqgIV7Ux3XhXYGSZ8DOMxFPHG+LWd9
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10583"; a="349890472"
X-IronPort-AV: E=Sophos;i="5.96,309,1665471600"; 
   d="scan'208";a="349890472"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2023 15:36:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10583"; a="686820330"
X-IronPort-AV: E=Sophos;i="5.96,309,1665471600"; 
   d="scan'208";a="686820330"
Received: from lkp-server02.sh.intel.com (HELO f1920e93ebb5) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 07 Jan 2023 15:36:22 -0800
Received: from kbuild by f1920e93ebb5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pEIjd-0004wO-2Z;
        Sat, 07 Jan 2023 23:36:21 +0000
Date:   Sun, 08 Jan 2023 07:35:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 9c4fb147c3492fd4be1b89c22a4c333308f6f44a
Message-ID: <63ba01c1.hRJlyVuHKSNlV6fm%lkp@intel.com>
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
branch HEAD: 9c4fb147c3492fd4be1b89c22a4c333308f6f44a  Merge branch into tip/master: 'x86/platform'

elapsed time: 722m

configs tested: 72
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
alpha                               defconfig
x86_64                            allnoconfig
um                             i386_defconfig
x86_64                        randconfig-a013
um                           x86_64_defconfig
x86_64                        randconfig-a011
s390                                defconfig
x86_64                        randconfig-a015
s390                             allmodconfig
x86_64                              defconfig
ia64                             allmodconfig
x86_64                               rhel-8.3
powerpc                           allnoconfig
mips                             allyesconfig
x86_64                           allyesconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
powerpc                          allmodconfig
i386                          randconfig-a001
i386                          randconfig-a003
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
arm                                 defconfig
sh                               allmodconfig
x86_64                        randconfig-a004
s390                             allyesconfig
x86_64                        randconfig-a002
i386                          randconfig-a005
x86_64                           rhel-8.3-bpf
i386                                defconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                        randconfig-a006
arc                  randconfig-r043-20230107
arc                  randconfig-r043-20230106
arm                  randconfig-r046-20230106
s390                 randconfig-r044-20230107
arm64                            allyesconfig
riscv                randconfig-r042-20230107
arm                              allyesconfig
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
i386                             allyesconfig
sh                          landisk_defconfig
powerpc                      mgcoge_defconfig
xtensa                    smp_lx200_defconfig

clang tested configs:
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                          rhel-8.3-rust
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
arm                  randconfig-r046-20230107
hexagon              randconfig-r041-20230107
hexagon              randconfig-r045-20230107
hexagon              randconfig-r041-20230106
riscv                randconfig-r042-20230106
hexagon              randconfig-r045-20230106
s390                 randconfig-r044-20230106
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
riscv                          rv32_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
