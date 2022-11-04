Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64DCF61912D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 07:41:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbiKDGlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 02:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiKDGlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 02:41:03 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7289813E29
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 23:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667544062; x=1699080062;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=UWi97ZcsPKqpwN9cG6STGFEGXjlNFyMihk6oWWzQ/LQ=;
  b=Oy5tnfQr2/G3JEp3fkm42Hp5LegFCXQ0l/8XDyrdsC8mLof8d5avm5Pk
   Z1skqpve2cD5frMMCqZOVVWACB3GE8F3nli58M2AiIR2LvXul9LzXhTqu
   XUGp93yt6yxjlu9C7w1jaTh63J6ZNcXoo42xF4DVkGVJgxJ8yFs6MlJ9e
   U3+UoJ63+TLCWxlMUCoTuteC1RC2cEw59B/xQhwTFw0o8n/85W4K7jxxl
   POjikfxIm07NJYbtUX2+FTk5/fZga8G65t8LQ2Sw9uLO2DQm5NlrTDFj8
   UZHTCBqmkIBvkI+lrn5VrbRNKPw/59p9zdfzfqnhxFp+XRU2klKfwGL6o
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="297360619"
X-IronPort-AV: E=Sophos;i="5.96,136,1665471600"; 
   d="scan'208";a="297360619"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 23:41:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="668255989"
X-IronPort-AV: E=Sophos;i="5.96,136,1665471600"; 
   d="scan'208";a="668255989"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 03 Nov 2022 23:41:00 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oqqNr-000Ggx-0V;
        Fri, 04 Nov 2022 06:40:55 +0000
Date:   Fri, 04 Nov 2022 14:40:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/cpu] BUILD SUCCESS
 7420ae3bb977b46eab082f4964641f3ddc98ebaf
Message-ID: <6364b3c9.BeJ3x09kI5869V6Z%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cpu
branch HEAD: 7420ae3bb977b46eab082f4964641f3ddc98ebaf  x86/intel_epb: Set Alder Lake N and Raptor Lake P normal EPB

elapsed time: 720m

configs tested: 85
configs skipped: 87

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                        randconfig-a004
x86_64                              defconfig
x86_64                        randconfig-a002
x86_64                        randconfig-a006
x86_64                               rhel-8.3
i386                                defconfig
x86_64                           allyesconfig
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
i386                             allyesconfig
um                           x86_64_defconfig
um                             i386_defconfig
ia64                             allmodconfig
i386                          randconfig-c001
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
arm                       imx_v6_v7_defconfig
arm                        multi_v7_defconfig
sh                          r7785rp_defconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
s390                             allyesconfig
sh                        sh7763rdp_defconfig
riscv                randconfig-r042-20221102
arc                  randconfig-r043-20221102
s390                 randconfig-r044-20221102
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
arm                           u8500_defconfig
nios2                         10m50_defconfig
powerpc                   currituck_defconfig
mips                         cobalt_defconfig
parisc                           allyesconfig
riscv                randconfig-r042-20221104
arc                  randconfig-r043-20221104
s390                 randconfig-r044-20221104
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
powerpc                     taishan_defconfig
xtensa                  cadence_csp_defconfig
m68k                        m5307c3_defconfig

clang tested configs:
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a002
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a006
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
riscv                          rv32_defconfig
arm                         bcm2835_defconfig
arm                         s3c2410_defconfig
hexagon              randconfig-r041-20221102
hexagon              randconfig-r045-20221102
mips                       rbtx49xx_defconfig
arm                       cns3420vb_defconfig
arm                     am200epdkit_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
