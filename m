Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB78D676505
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 08:48:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjAUHsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 02:48:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjAUHsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 02:48:10 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 257C64FAED
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 23:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674287289; x=1705823289;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=G+V6+MdVOdpKxRtT1bcJfqVC2gy0rMQG+34twkV78RQ=;
  b=mlP77P4lyDvis/F5Ik1/kbg1+WhVZEhlkwN2kxFq4/Lbja9DtRCuVDqj
   fq05jYaYGLnoJnVuDVG3epLaBPrnwYd7iWnqUC8lYivCYo6oe0eoTIKdk
   V3t5FGFV2hpgYemMEPKiX3qApmP1kXsdUxeJivSLsY4HnYdbphUAw+c9X
   XNpZGgOT9s+sn3V3ouCdQ7AER3viUkutN9Hq7aXV3bQifQ5Do7h6iW81p
   dMa1dFrEuceC2sls9l2xi6PBPnAlHUWuu/dmOwmD88yF3tAKsPiH1gnPQ
   y72EBDlWCqQEVdvvKsxQX7hf6Q7ODYgZJerr/YMOtc2piSFnILgdTuqkm
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="327039537"
X-IronPort-AV: E=Sophos;i="5.97,234,1669104000"; 
   d="scan'208";a="327039537"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 23:48:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="768968414"
X-IronPort-AV: E=Sophos;i="5.97,234,1669104000"; 
   d="scan'208";a="768968414"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 20 Jan 2023 23:48:07 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pJ8be-0003nq-1N;
        Sat, 21 Jan 2023 07:48:06 +0000
Date:   Sat, 21 Jan 2023 15:47:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:lkmm-srcu.2023.01.20a] BUILD SUCCESS
 f0d4b328e12cdc7f34c11f7c82b28a16e097f769
Message-ID: <63cb9883.nehUVdSKUWtUK6Yq%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git lkmm-srcu.2023.01.20a
branch HEAD: f0d4b328e12cdc7f34c11f7c82b28a16e097f769  tools/memory-model: Provide exact SRCU semantics

elapsed time: 727m

configs tested: 80
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
s390                             allyesconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-bpf
x86_64                            allnoconfig
arm                  randconfig-r046-20230119
arc                  randconfig-r043-20230119
um                             i386_defconfig
um                           x86_64_defconfig
powerpc                           allnoconfig
i386                          randconfig-a001
i386                          randconfig-a003
sh                               allmodconfig
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                        randconfig-a011
mips                             allyesconfig
powerpc                          allmodconfig
x86_64                        randconfig-a015
x86_64                              defconfig
arm                                 defconfig
x86_64                        randconfig-a004
x86_64                    rhel-8.3-kselftests
x86_64                        randconfig-a002
x86_64                          rhel-8.3-func
x86_64                        randconfig-a006
x86_64                               rhel-8.3
arm64                            allyesconfig
m68k                             allyesconfig
arm                              allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
x86_64                           allyesconfig
ia64                             allmodconfig
i386                                defconfig
i386                             allyesconfig
m68k                        m5407c3_defconfig
arc                              alldefconfig
powerpc                       eiger_defconfig
sh                             espt_defconfig
i386                          randconfig-c001
arm                            hisi_defconfig
arm                      footbridge_defconfig
mips                           ci20_defconfig
sh                           se7724_defconfig
powerpc                      ppc6xx_defconfig
loongarch                        alldefconfig
sh                   sh7770_generic_defconfig
nios2                               defconfig
powerpc                   currituck_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func

clang tested configs:
hexagon              randconfig-r045-20230119
hexagon              randconfig-r041-20230119
s390                 randconfig-r044-20230119
riscv                randconfig-r042-20230119
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                          rhel-8.3-rust
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
