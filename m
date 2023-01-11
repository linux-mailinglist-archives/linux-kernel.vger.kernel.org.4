Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 046596665CD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 22:46:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235566AbjAKVqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 16:46:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231803AbjAKVqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 16:46:53 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED52E13F69
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 13:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673473610; x=1705009610;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=D4/M42gkAs1Q2kEoWVjkeTqX6yoNR0yPBP0jHxdbCfE=;
  b=BIpPh1AiQrKcQSGNN6SvT/lBXTMwqkkOed2aDGBD5wYr2ZswjZ6PkVAK
   4TBJonSlFVcgirDagE5T/OzSs/99kQfs6EvThciK9dwb2cs3cw1oH3QlP
   7lQ8gy5GGM2BokYA3D+2hCM/dVG5VkCttkst0aqJWLvdR58LdeYSpwYg2
   zJG+r9gH9p+tZxq2Owa1rv55EJ4tsKe7EI8OKYLCmflU+UGyTNagpncv5
   eUA+mEEZd5rwUhKN3KUtXWFolxBMmYnmmeWC0P8PK0VlfPyCQB7qQ6BAf
   FkoBXIEY+c3XFdj2tTFaKJs8eCTNvcHUPIwwJHa3YSHuXeaL5fpCiu9t1
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="303239764"
X-IronPort-AV: E=Sophos;i="5.96,318,1665471600"; 
   d="scan'208";a="303239764"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 13:46:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="689904552"
X-IronPort-AV: E=Sophos;i="5.96,318,1665471600"; 
   d="scan'208";a="689904552"
Received: from lkp-server02.sh.intel.com (HELO f1920e93ebb5) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 11 Jan 2023 13:46:49 -0800
Received: from kbuild by f1920e93ebb5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pFivj-0009YU-1U;
        Wed, 11 Jan 2023 21:46:43 +0000
Date:   Thu, 12 Jan 2023 05:46:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 40055919c6fec60c40809e5d3480f406ba248379
Message-ID: <63bf2e1e.XXLZuU5HEuYmKyCC%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 40055919c6fec60c40809e5d3480f406ba248379  Merge branch into tip/master: 'x86/platform'

elapsed time: 724m

configs tested: 68
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                           rhel-8.3-bpf
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
arc                                 defconfig
x86_64                           rhel-8.3-kvm
s390                             allmodconfig
alpha                               defconfig
x86_64                            allnoconfig
s390                                defconfig
s390                             allyesconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
i386                                defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                              defconfig
x86_64                               rhel-8.3
arc                  randconfig-r043-20230110
ia64                             allmodconfig
alpha                            allyesconfig
x86_64                        randconfig-a015
m68k                             allyesconfig
s390                 randconfig-r044-20230110
m68k                             allmodconfig
x86_64                           allyesconfig
arc                              allyesconfig
riscv                randconfig-r042-20230110
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a014
i386                          randconfig-a012
arm                                 defconfig
i386                          randconfig-a005
i386                          randconfig-a016
i386                             allyesconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
arm64                            allyesconfig
arm                              allyesconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
microblaze                      mmu_defconfig
arm                           tegra_defconfig
loongarch                 loongson3_defconfig
parisc                           allyesconfig
powerpc                      pasemi_defconfig
mips                       bmips_be_defconfig

clang tested configs:
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
x86_64                        randconfig-a012
x86_64                        randconfig-a014
hexagon              randconfig-r041-20230110
arm                  randconfig-r046-20230110
x86_64                        randconfig-a016
hexagon              randconfig-r045-20230110
x86_64                          rhel-8.3-rust
i386                          randconfig-a002
i386                          randconfig-a013
i386                          randconfig-a004
i386                          randconfig-a011
i386                          randconfig-a015
i386                          randconfig-a006

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
