Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB4B366A854
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 02:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbjANBcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 20:32:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjANBcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 20:32:00 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A20B149DF
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 17:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673659911; x=1705195911;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=C28McMQPFiiUpaa5bEwHGVYtV24tHnxPO/q2NWtGSuc=;
  b=ZS7mEIOndjhASdeSlMXxQuCVEauhRzsL7Ojmqr2owafa/1PyZ0EWQ8PG
   yobKZpJVaSL1WgP0OS0N8x9SAKogp1SqvZINl2MdrxxjMqpLpIvb6cA3+
   71OKd561lgK4oXyhi6HBUmwdeLBJuTzH+vDl9WwS6lguLTrSYFU4XyKMp
   a+cxLXbe2HYJHmI26YN4fUy1h9gcmlgSYnGS3W4IuokyZ2p96GeCVG8H3
   OB64+dXXATKXrZD0RGR4E2lpV+32Y3YPOn+cPlhD+JhVr/WjYTFRJXI/Z
   uk3zulPJyBwLEr0CKmbnFD2Spt7+7pEH09TJJ3to+crvuhUf4f6byoqDB
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="386492513"
X-IronPort-AV: E=Sophos;i="5.97,215,1669104000"; 
   d="scan'208";a="386492513"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 17:31:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="987197235"
X-IronPort-AV: E=Sophos;i="5.97,215,1669104000"; 
   d="scan'208";a="987197235"
Received: from lkp-server02.sh.intel.com (HELO f1920e93ebb5) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 13 Jan 2023 17:31:49 -0800
Received: from kbuild by f1920e93ebb5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pGVOe-000Bba-1B;
        Sat, 14 Jan 2023 01:31:48 +0000
Date:   Sat, 14 Jan 2023 09:31:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/cleanups] BUILD SUCCESS
 d55dcb7384b1234d3caf70c2f8199c4184502ff9
Message-ID: <63c205f4.zZ7gyXmLvniVHzUj%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cleanups
branch HEAD: d55dcb7384b1234d3caf70c2f8199c4184502ff9  x86/cpu: Remove misleading comment

elapsed time: 727m

configs tested: 88
configs skipped: 66

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-bpf
i386                                defconfig
i386                          randconfig-a003
i386                          randconfig-a001
i386                          randconfig-a014
i386                          randconfig-a012
x86_64                        randconfig-a013
x86_64                          rhel-8.3-func
x86_64                        randconfig-a011
x86_64                    rhel-8.3-kselftests
i386                          randconfig-a016
i386                          randconfig-a005
x86_64                        randconfig-a015
x86_64                              defconfig
i386                             allyesconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                               rhel-8.3
x86_64                        randconfig-a006
x86_64                           allyesconfig
ia64                             allmodconfig
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
arm64                               defconfig
mips                 decstation_r4k_defconfig
powerpc                       maple_defconfig
sh                          urquell_defconfig
openrisc                         alldefconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
arm                                 defconfig
arm                              allyesconfig
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
arm                        cerfcube_defconfig
microblaze                          defconfig
powerpc                      mgcoge_defconfig
parisc                generic-64bit_defconfig
arc                         haps_hs_defconfig
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
s390                             allyesconfig
mips                     loongson1b_defconfig
arm                           viper_defconfig
um                           x86_64_defconfig
um                             i386_defconfig
i386                          randconfig-c001
riscv                randconfig-r042-20230112
s390                 randconfig-r044-20230112
arc                  randconfig-r043-20230112
arm                       imx_v6_v7_defconfig
um                                  defconfig
arc                          axs101_defconfig

clang tested configs:
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a013
x86_64                          rhel-8.3-rust
x86_64                        randconfig-a012
i386                          randconfig-a011
x86_64                        randconfig-a014
i386                          randconfig-a015
x86_64                        randconfig-a016
i386                          randconfig-a006
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
x86_64                        randconfig-k001
riscv                randconfig-r042-20230113
arm                  randconfig-r046-20230112
s390                 randconfig-r044-20230113
hexagon              randconfig-r041-20230113
hexagon              randconfig-r041-20230112
hexagon              randconfig-r045-20230113
hexagon              randconfig-r045-20230112

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
