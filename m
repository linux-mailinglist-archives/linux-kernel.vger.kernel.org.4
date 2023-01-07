Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB0E5661281
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 00:08:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232748AbjAGXIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 18:08:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbjAGXIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 18:08:22 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679CF37510
        for <linux-kernel@vger.kernel.org>; Sat,  7 Jan 2023 15:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673132901; x=1704668901;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=cz41W3GXeCjs4/odG5IOUtXa+fbn3N3xDxaxntmso/M=;
  b=g92qMB6LhFjrI7/Nov3Qkeo9B8mq1T5z0WnjDVsqmIKIL90qUFVO2yok
   HowFq8OdOwRq4xZ6uT5e5dj5+VS34ccP2WlQVwPfvweKbmRrvXIZu5NoR
   DHP7tFOs+DtvgzaUZZMaUaXacc8fDHvb3yqamRv62twzL1G/NOxmROYtm
   EYmLidPyq/wF2TXssWaCVb/6vIa7WxDWggcXHHsRoDW+wI5wrgC8ZKNUP
   VUEEp6X7sdytzAXb6j1xwF5MgcjSkeuZv25SCNzHMOlOHvs6MBD9dzCh2
   5YIgpB9UYbs1v57qZrLSqHEe/mLIiVOphNLegau7yUA0mZq+98VeVlyyx
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10583"; a="321384230"
X-IronPort-AV: E=Sophos;i="5.96,309,1665471600"; 
   d="scan'208";a="321384230"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2023 15:08:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10583"; a="686815071"
X-IronPort-AV: E=Sophos;i="5.96,309,1665471600"; 
   d="scan'208";a="686815071"
Received: from lkp-server02.sh.intel.com (HELO f1920e93ebb5) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 07 Jan 2023 15:08:18 -0800
Received: from kbuild by f1920e93ebb5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pEIIU-0004vM-05;
        Sat, 07 Jan 2023 23:08:18 +0000
Date:   Sun, 08 Jan 2023 07:07:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:sched/core] BUILD SUCCESS
 d74f87f37672e71457bfcc14eca5eeb1d61b6438
Message-ID: <63b9fb28.sL/8EXpyqacO4Ge6%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
branch HEAD: d74f87f37672e71457bfcc14eca5eeb1d61b6438  selftests/membarrier: Test MEMBARRIER_CMD_GET_REGISTRATIONS

elapsed time: 723m

configs tested: 81
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
arc                                 defconfig
s390                             allmodconfig
x86_64                           rhel-8.3-bpf
alpha                               defconfig
x86_64                           rhel-8.3-syz
ia64                             allmodconfig
x86_64                         rhel-8.3-kunit
i386                          randconfig-a001
x86_64                           rhel-8.3-kvm
i386                          randconfig-a003
um                             i386_defconfig
x86_64                              defconfig
s390                                defconfig
um                           x86_64_defconfig
i386                          randconfig-a005
m68k                             allyesconfig
i386                                defconfig
m68k                             allmodconfig
x86_64                        randconfig-a004
arc                              allyesconfig
x86_64                        randconfig-a002
s390                             allyesconfig
x86_64                               rhel-8.3
alpha                            allyesconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a006
x86_64                        randconfig-a011
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
arc                  randconfig-r043-20230107
arm                                 defconfig
i386                          randconfig-a014
x86_64                           allyesconfig
arm64                            allyesconfig
i386                          randconfig-a012
arm                              allyesconfig
i386                          randconfig-a016
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64                        randconfig-a015
mips                             allyesconfig
arc                  randconfig-r043-20230106
riscv                randconfig-r042-20230107
i386                             allyesconfig
sh                               allmodconfig
arm                  randconfig-r046-20230106
s390                 randconfig-r044-20230107
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
xtensa                  cadence_csp_defconfig
sh                           se7722_defconfig
mips                            gpr_defconfig
arm                        trizeps4_defconfig
nios2                         3c120_defconfig
s390                       zfcpdump_defconfig
arm                           imxrt_defconfig
arc                            hsdk_defconfig

clang tested configs:
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a001
x86_64                          rhel-8.3-rust
i386                          randconfig-a013
x86_64                        randconfig-a014
x86_64                        randconfig-a003
arm                  randconfig-r046-20230107
i386                          randconfig-a011
x86_64                        randconfig-a005
x86_64                        randconfig-a012
i386                          randconfig-a015
hexagon              randconfig-r041-20230107
x86_64                        randconfig-a016
hexagon              randconfig-r045-20230107
hexagon              randconfig-r041-20230106
s390                 randconfig-r044-20230106
riscv                randconfig-r042-20230106
hexagon              randconfig-r045-20230106
x86_64                        randconfig-k001
arm                       imx_v4_v5_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
