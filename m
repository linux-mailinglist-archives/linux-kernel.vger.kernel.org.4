Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77EBE6650CC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 01:59:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234783AbjAKA7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 19:59:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232449AbjAKA7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 19:59:33 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F145150141
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 16:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673398772; x=1704934772;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=QYcfGhewjHddFa5OicewDwX8l4LFyG94gNb2TrXczZs=;
  b=MPEYob6r/yVmUCRHS2BcWUJhxboe++56edrMqCrH6orTRaSvSVeuXxHK
   iH2KD/LN5nzsqMAmLbbsI2wA2OEEpwMLbZmpAqDqjQArmLJaxMWT5f9rr
   pW7a+He3SUydsAFDQYUkUJ8NiunyNKVIwXVPJXU4VED7Xy3xEtuy6TWR2
   GD8bA3e6wg4j7o9EejoO1QD6gWDsGbi0ngIugUxUdIg6nlSw5cyHQGAba
   XqPfetm6wN5vTcxTZdEGT47pXvhhv0z7FqjnCIxY3wbJoxrZM7pVMmKuA
   /+DKHRetTnP6Z/tRDfKUiDgJ9gsQspwXpLg5mgP/4fzEY7umvJCFfU2Vk
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="320988191"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="320988191"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2023 16:59:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="985957670"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="985957670"
Received: from lkp-server02.sh.intel.com (HELO f1920e93ebb5) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 10 Jan 2023 16:59:31 -0800
Received: from kbuild by f1920e93ebb5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pFPSf-0008Xk-3B;
        Wed, 11 Jan 2023 00:59:25 +0000
Date:   Wed, 11 Jan 2023 08:58:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:perf/core] BUILD SUCCESS
 9fcad995c6c52cc9791f7ee9f1386a5684055f9c
Message-ID: <63be09bf.3PX5UWg2KLAY76eU%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/core
branch HEAD: 9fcad995c6c52cc9791f7ee9f1386a5684055f9c  x86/kprobes: Use switch-case for 0xFF opcodes in prepare_emulation

elapsed time: 724m

configs tested: 67
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
s390                             allyesconfig
powerpc                           allnoconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allyesconfig
um                             i386_defconfig
um                           x86_64_defconfig
ia64                             allmodconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
i386                             allyesconfig
i386                                defconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                           rhel-8.3-bpf
x86_64                         rhel-8.3-kunit
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
riscv                randconfig-r042-20230110
s390                 randconfig-r044-20230110
arc                  randconfig-r043-20230110
m68k                          amiga_defconfig
riscv                            allmodconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20230110
i386                          randconfig-c001
loongarch                           defconfig
loongarch                         allnoconfig
loongarch                        allmodconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                        nsim_700_defconfig
sparc64                             defconfig
riscv                               defconfig
arm                            zeus_defconfig
powerpc                 mpc834x_mds_defconfig
m68k                       m5249evb_defconfig
openrisc                            defconfig

clang tested configs:
x86_64                          rhel-8.3-rust
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
mips                malta_qemu_32r6_defconfig
x86_64                        randconfig-k001
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
