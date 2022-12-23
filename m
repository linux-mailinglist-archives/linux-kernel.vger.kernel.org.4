Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3E0654C8A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 07:47:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235843AbiLWGrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 01:47:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235659AbiLWGrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 01:47:08 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583941DA52
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 22:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671778027; x=1703314027;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=wjol5HEPi4WtWXTCihvU0k/BW41Xk5WG9JzrJ+byYLM=;
  b=d1inBOocghAfXFfTjFD7ehMQ6/869SokT8Wg6/cB8eFaN0lNRACi6Brc
   /PTnSBFchtjc9ZQmbDmvq2VT3ysaHBdNXtIXFzyZJ8yZlFObBndDQZy6g
   tpij/ot3HmvnN9GPt+zNYDQCxf0k3ZertbU3mPM8VW9d2pVoVbxLvYZ6Q
   SX8N2fPw3YLsc+e5Oq75ACFG7YLG9DKzwegRQ2qJ5kQg7h+sU3pl3bSFV
   zYklAOcMp6JW5pNiPdPmQmPLph++5TVVDVeg0h0vENTCcgaf4X6ORuWrP
   tX8JWYTgF+qunyUlN8x/GOxUYzG4yWgileGwvqByOGx6ViSlqZ/bvf4q0
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10569"; a="347439555"
X-IronPort-AV: E=Sophos;i="5.96,267,1665471600"; 
   d="scan'208";a="347439555"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2022 22:47:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10569"; a="759265089"
X-IronPort-AV: E=Sophos;i="5.96,267,1665471600"; 
   d="scan'208";a="759265089"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 22 Dec 2022 22:47:04 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p8bpg-000CUs-0C;
        Fri, 23 Dec 2022 06:47:04 +0000
Date:   Fri, 23 Dec 2022 14:46:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:glacialnmi.2022.12.19a] BUILD SUCCESS
 5c0a404395f13150a2081b72a67ec9f6251aa580
Message-ID: <63a54ed3.KJGPMmjP+q95D744%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git glacialnmi.2022.12.19a
branch HEAD: 5c0a404395f13150a2081b72a67ec9f6251aa580  x86/nmi: Test commit for severely delayed NMI handlers

elapsed time: 727m

configs tested: 88
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                           x86_64_defconfig
um                             i386_defconfig
m68k                             allyesconfig
arc                                 defconfig
m68k                             allmodconfig
s390                             allmodconfig
arc                              allyesconfig
alpha                               defconfig
x86_64                              defconfig
s390                                defconfig
alpha                            allyesconfig
powerpc                           allnoconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
s390                             allyesconfig
x86_64                           allyesconfig
ia64                             allmodconfig
x86_64               randconfig-a003-20221219
x86_64               randconfig-a001-20221219
x86_64               randconfig-a004-20221219
i386                                defconfig
x86_64               randconfig-a002-20221219
arc                  randconfig-r043-20221221
x86_64               randconfig-a006-20221219
arm                  randconfig-r046-20221221
x86_64               randconfig-a005-20221219
x86_64                         rhel-8.3-kunit
arm                                 defconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-bpf
sh                               allmodconfig
x86_64                           rhel-8.3-syz
i386                 randconfig-a001-20221219
powerpc                          allmodconfig
i386                 randconfig-a003-20221219
i386                 randconfig-a002-20221219
mips                             allyesconfig
arm64                            allyesconfig
arm                              allyesconfig
i386                             allyesconfig
i386                 randconfig-a006-20221219
i386                 randconfig-a005-20221219
i386                 randconfig-a004-20221219
x86_64                            allnoconfig
i386                          randconfig-c001
arm                        trizeps4_defconfig
sh                            shmin_defconfig
um                               alldefconfig
powerpc                      makalu_defconfig
m68k                        mvme147_defconfig
powerpc                    amigaone_defconfig
m68k                         amcore_defconfig
m68k                        m5272c3_defconfig
s390                 randconfig-r044-20221222
arc                  randconfig-r043-20221222
riscv                randconfig-r042-20221222
sh                           se7724_defconfig
sh                          rsk7203_defconfig
arm                            xcep_defconfig
mips                           xway_defconfig
m68k                          multi_defconfig
powerpc                 mpc8540_ads_defconfig
mips                            ar7_defconfig
openrisc                    or1ksim_defconfig
sh                          lboxre2_defconfig
loongarch                           defconfig
loongarch                         allnoconfig
loongarch                        allmodconfig

clang tested configs:
x86_64                          rhel-8.3-rust
hexagon              randconfig-r045-20221221
hexagon              randconfig-r041-20221221
riscv                randconfig-r042-20221221
s390                 randconfig-r044-20221221
i386                 randconfig-a014-20221219
i386                 randconfig-a012-20221219
i386                 randconfig-a013-20221219
i386                 randconfig-a011-20221219
i386                 randconfig-a015-20221219
i386                 randconfig-a016-20221219
x86_64               randconfig-a015-20221219
x86_64               randconfig-a011-20221219
x86_64               randconfig-a012-20221219
x86_64               randconfig-a014-20221219
x86_64               randconfig-a013-20221219
x86_64               randconfig-a016-20221219
x86_64                        randconfig-k001
x86_64               randconfig-k001-20221219

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
