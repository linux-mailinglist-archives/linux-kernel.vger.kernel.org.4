Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1124B5F4FC3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 08:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbiJEG1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 02:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiJEG1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 02:27:01 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83269733D1
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 23:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664951220; x=1696487220;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=VYsJnp2qjDs1FOMo8qmaFoLw1IYXzkvnOLJme2FqdAU=;
  b=hlol3XsTZkH8lv+/SCmpx2jqm1DufLp0Ip5lSFFTVTRjD7jruFzahUr3
   341ccRNxaSCpqGepNPhiWlEI9VKYUmLa1Gm/sc2Td2EEsurrmMs0i89na
   S7G5K69//0B7MjJGpxzSeD2c2tG/M/2Bh2Z6PSzoI4Cyx9QCBtf1HNSEq
   bl2xAVqkG4Vu7yH1gdwlPsD7SqQeHKBr3R0MdS1/5ThtMvHycoCWghwwp
   1qVa25RASB8/yBPF2COvxhkBEThpA6F+DO+xeO0/Co136ayKdKpwLiRzn
   CCyyQ2JNCencUEmi0IumR4uZ3ehA3aqkczdpbRPooPVBid3yRmkbRMhjD
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="304662650"
X-IronPort-AV: E=Sophos;i="5.95,159,1661842800"; 
   d="scan'208";a="304662650"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2022 23:27:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="749658649"
X-IronPort-AV: E=Sophos;i="5.95,159,1661842800"; 
   d="scan'208";a="749658649"
Received: from lkp-server01.sh.intel.com (HELO d4f44333118a) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 04 Oct 2022 23:26:58 -0700
Received: from kbuild by d4f44333118a with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ofxru-0000zZ-0g;
        Wed, 05 Oct 2022 06:26:58 +0000
Date:   Wed, 05 Oct 2022 14:26:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/mm] BUILD SUCCESS
 e9935b87c46236e8d7dd0acb847a31952db25228
Message-ID: <633d238a.p4jWYle92prD2+jF%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/mm
branch HEAD: e9935b87c46236e8d7dd0acb847a31952db25228  x86/mm: Ease W^X enforcement back to just a warning

elapsed time: 727m

configs tested: 99
configs skipped: 77

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                    rhel-8.3-kselftests
i386                 randconfig-a015-20221003
i386                 randconfig-a014-20221003
x86_64               randconfig-a011-20221003
i386                 randconfig-a011-20221003
x86_64               randconfig-a012-20221003
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
i386                 randconfig-a012-20221003
x86_64               randconfig-a013-20221003
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
i386                 randconfig-a013-20221003
i386                 randconfig-a016-20221003
x86_64               randconfig-a015-20221003
x86_64               randconfig-a014-20221003
x86_64               randconfig-a016-20221003
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
s390                             allyesconfig
i386                                defconfig
i386                          randconfig-c001
i386                             allyesconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
sh                        sh7763rdp_defconfig
loongarch                 loongson3_defconfig
arm                         cm_x300_defconfig
nios2                            alldefconfig
mips                            gpr_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
riscv                            allyesconfig
mips                        vocore2_defconfig
riscv                randconfig-r042-20221003
arc                  randconfig-r043-20221003
arc                  randconfig-r043-20221002
s390                 randconfig-r044-20221003
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
sparc64                             defconfig
arc                          axs101_defconfig
sh                   sh7770_generic_defconfig
powerpc                 linkstation_defconfig
arm                            pleb_defconfig
powerpc                          allyesconfig
riscv                               defconfig
riscv                            allmodconfig
powerpc                    adder875_defconfig
powerpc                     taishan_defconfig
powerpc                     stx_gp3_defconfig
ia64                      gensparse_defconfig
arm                  randconfig-c002-20221002
x86_64                        randconfig-c001
s390                          debug_defconfig
sh                           se7705_defconfig
arc                     nsimosci_hs_defconfig

clang tested configs:
i386                 randconfig-a003-20221003
i386                 randconfig-a002-20221003
i386                 randconfig-a001-20221003
i386                 randconfig-a004-20221003
i386                 randconfig-a005-20221003
i386                 randconfig-a006-20221003
x86_64               randconfig-a002-20221003
x86_64               randconfig-a001-20221003
x86_64               randconfig-a004-20221003
x86_64               randconfig-a003-20221003
x86_64               randconfig-a005-20221003
x86_64               randconfig-a006-20221003
x86_64                        randconfig-k001
mips                malta_qemu_32r6_defconfig
powerpc                 mpc836x_mds_defconfig
hexagon              randconfig-r041-20221003
hexagon              randconfig-r045-20221003
powerpc                     powernv_defconfig
riscv                             allnoconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
