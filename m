Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADA6F5B412B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 23:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbiIIVAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 17:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbiIIVAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 17:00:21 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72AEF54CB3
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 14:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662757220; x=1694293220;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=6/qEbL6nGy8XCAlo7vmGPdOyMLtwdayCXu+VwzMFfB4=;
  b=gwBg/l4QwMvBItCByGfoifdiHoLO+oVGb+ylw7X2XHLj0zxsA61YObL/
   cydAEiSBcBs0B3FpYFCq1bvxtvCuJOuPtsfTlXRo8Xff/FISwG+5ao6X7
   6LF9SqdyWL9EB/d2uYP0I9sGo/5drbWKIGP3U5/jCgS+TBCOlf4rulazJ
   98N2p6gMviyMnMI/d1PGUArQ3FU+G11NdGZZYN7u17yUnmlhkWspr+2j9
   vrLO6OYLH74mwXLhwuR1/1jnzYOyDhRMeDytFDAMjH7fMocPGldf19Knc
   phHM/RCTf1RT/YJt0CN+bgCCZX30qLL7IS6XIt8oqafmXkOqBOWcdaptk
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10465"; a="297570054"
X-IronPort-AV: E=Sophos;i="5.93,304,1654585200"; 
   d="scan'208";a="297570054"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 14:00:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,304,1654585200"; 
   d="scan'208";a="615403287"
Received: from lkp-server02.sh.intel.com (HELO b2938d2e5c5a) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 09 Sep 2022 14:00:07 -0700
Received: from kbuild by b2938d2e5c5a with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oWl6d-0001j4-01;
        Fri, 09 Sep 2022 21:00:07 +0000
Date:   Sat, 10 Sep 2022 04:59:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:perf/core] BUILD SUCCESS
 fae9ebde9696385fa2e993e752cf68d9781f3ea0
Message-ID: <631ba948.qhmgVIAlTlGJ3PDH%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/core
branch HEAD: fae9ebde9696385fa2e993e752cf68d9781f3ea0  perf/x86/intel: Optimize FIXED_CTR_CTRL access

elapsed time: 731m

configs tested: 114
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
m68k                             allmodconfig
x86_64                           allyesconfig
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allyesconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
arm                                 defconfig
x86_64                        randconfig-a006
i386                                defconfig
i386                          randconfig-a001
i386                          randconfig-a014
i386                          randconfig-a003
arm                              allyesconfig
i386                          randconfig-a012
mips                             allyesconfig
i386                          randconfig-a016
powerpc                           allnoconfig
i386                          randconfig-a005
powerpc                          allmodconfig
x86_64                        randconfig-a011
i386                             allyesconfig
sh                               allmodconfig
arm64                            allyesconfig
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                    rhel-8.3-kselftests
x86_64                        randconfig-a013
x86_64                        randconfig-a015
mips                            ar7_defconfig
mips                         rt305x_defconfig
arc                      axs103_smp_defconfig
openrisc                    or1ksim_defconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
arc                    vdk_hs38_smp_defconfig
sh                         microdev_defconfig
mips                           xway_defconfig
loongarch                           defconfig
loongarch                         allnoconfig
i386                          randconfig-c001
sh                             shx3_defconfig
xtensa                              defconfig
mips                    maltaup_xpa_defconfig
mips                  maltasmvp_eva_defconfig
sh                        edosk7705_defconfig
arm                             pxa_defconfig
arc                              alldefconfig
arm                           u8500_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
m68k                       m5475evb_defconfig
powerpc                 mpc834x_itx_defconfig
powerpc                     tqm8548_defconfig
nios2                            allyesconfig
sh                             espt_defconfig
sh                     magicpanelr2_defconfig
s390                       zfcpdump_defconfig
mips                        bcm47xx_defconfig
riscv                               defconfig
nios2                         10m50_defconfig
powerpc                 mpc837x_rdb_defconfig
ia64                             allmodconfig
arm                           sunxi_defconfig
sh                        dreamcast_defconfig
arm                            zeus_defconfig
riscv                randconfig-r042-20220908
arc                  randconfig-r043-20220907
arc                  randconfig-r043-20220908
s390                 randconfig-r044-20220908
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func

clang tested configs:
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a013
i386                          randconfig-a015
i386                          randconfig-a011
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a016
x86_64                        randconfig-a014
x86_64                        randconfig-k001
powerpc                        fsp2_defconfig
powerpc                 mpc8272_ads_defconfig
mips                        qi_lb60_defconfig
arm                          pcm027_defconfig
mips                           mtx1_defconfig
riscv                randconfig-r042-20220907
hexagon              randconfig-r041-20220907
hexagon              randconfig-r041-20220908
hexagon              randconfig-r045-20220908
hexagon              randconfig-r045-20220907
s390                 randconfig-r044-20220907
riscv                randconfig-r042-20220909
hexagon              randconfig-r041-20220909
hexagon              randconfig-r045-20220909
s390                 randconfig-r044-20220909
powerpc                          allmodconfig
powerpc                     tqm8540_defconfig
powerpc                      ppc44x_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
