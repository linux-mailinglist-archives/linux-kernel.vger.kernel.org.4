Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7687C6635D4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 00:49:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237807AbjAIXtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 18:49:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237913AbjAIXsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 18:48:12 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8693C41D54
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 15:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673308003; x=1704844003;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=eFBD1rGz3ApJF/kubsVPEadolV9sCkV50AxnPhA39rs=;
  b=BIgShkB/h9Q6wnpvdcdeGEyecOqKjkh9hnqOFawmimHinGcAzk5OBKNa
   QPLOHiYPLHx6PRF4E+6Li3y2kvpjhj2fZura6cl7mIVvjq3mM4PLrTEpv
   QAXPtgMDldj/CZiTVQ+VjVowKjXM9Zpo3UUbyewh46mNIDctHg1LCfpnw
   z3KkfTsbiN/QCnBqfoWseIm+lZTTa8MwwioQVhAyFrjNQZr+eAmesye35
   q0VktsOXVU8gciDzxG9WliAbD6DAziZjGAxeoUHLOiT93usrww3oGAQ4M
   wNpc5iBd6KfnAucF1Wb8vC1vKoKaYlOtd/DJ/p7nMPbvHSm9Zwy963CMm
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="306530329"
X-IronPort-AV: E=Sophos;i="5.96,313,1665471600"; 
   d="scan'208";a="306530329"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 15:46:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="745550048"
X-IronPort-AV: E=Sophos;i="5.96,313,1665471600"; 
   d="scan'208";a="745550048"
Received: from lkp-server02.sh.intel.com (HELO f1920e93ebb5) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 09 Jan 2023 15:46:41 -0800
Received: from kbuild by f1920e93ebb5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pF1qi-0007N7-2c;
        Mon, 09 Jan 2023 23:46:40 +0000
Date:   Tue, 10 Jan 2023 07:46:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:perf/urgent] BUILD SUCCESS
 5268a2842066c227e6ccd94bac562f1e1000244f
Message-ID: <63bca74f.mvJPA0Bp17f7hmJw%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/urgent
branch HEAD: 5268a2842066c227e6ccd94bac562f1e1000244f  perf/x86/intel/uncore: Add Emerald Rapids

elapsed time: 728m

configs tested: 97
configs skipped: 70

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                              defconfig
x86_64                            allnoconfig
x86_64                               rhel-8.3
i386                 randconfig-a011-20230109
i386                 randconfig-a013-20230109
i386                 randconfig-a012-20230109
x86_64               randconfig-a011-20230109
i386                 randconfig-a014-20230109
x86_64               randconfig-a013-20230109
x86_64               randconfig-a012-20230109
x86_64                           allyesconfig
i386                 randconfig-a016-20230109
x86_64               randconfig-a014-20230109
i386                 randconfig-a015-20230109
x86_64               randconfig-a016-20230109
x86_64               randconfig-a015-20230109
x86_64                           rhel-8.3-bpf
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
i386                                defconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
sh                         apsh4a3a_defconfig
powerpc                   motionpro_defconfig
arc                     haps_hs_smp_defconfig
i386                             allyesconfig
powerpc                      makalu_defconfig
powerpc                      mgcoge_defconfig
arm64                            alldefconfig
mips                         cobalt_defconfig
mips                  maltasmvp_eva_defconfig
ia64                             allmodconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
um                           x86_64_defconfig
um                             i386_defconfig
i386                          randconfig-c001
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
s390                             allyesconfig
m68k                          hp300_defconfig
riscv             nommu_k210_sdcard_defconfig
sh                         microdev_defconfig
m68k                        stmark2_defconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
arm                             pxa_defconfig
arc                           tb10x_defconfig
arm                              allmodconfig
arm                       multi_v4t_defconfig
arc                    vdk_hs38_smp_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig

clang tested configs:
i386                 randconfig-a004-20230109
x86_64               randconfig-a003-20230109
x86_64               randconfig-a002-20230109
i386                 randconfig-a002-20230109
x86_64               randconfig-a004-20230109
i386                 randconfig-a003-20230109
x86_64               randconfig-a001-20230109
i386                 randconfig-a001-20230109
x86_64                          rhel-8.3-rust
i386                 randconfig-a005-20230109
x86_64               randconfig-a005-20230109
i386                 randconfig-a006-20230109
x86_64               randconfig-a006-20230109
x86_64                        randconfig-k001
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
mips                     loongson1c_defconfig
mips                      maltaaprp_defconfig
s390                 randconfig-r044-20230108
hexagon              randconfig-r041-20230108
hexagon              randconfig-r041-20230109
hexagon              randconfig-r045-20230108
hexagon              randconfig-r045-20230109
arm                  randconfig-r046-20230109
riscv                randconfig-r042-20230108
powerpc               mpc834x_itxgp_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
