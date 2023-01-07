Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13EDF661297
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 00:35:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbjAGXf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 18:35:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjAGXfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 18:35:25 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 242012AC
        for <linux-kernel@vger.kernel.org>; Sat,  7 Jan 2023 15:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673134524; x=1704670524;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=DM4LkZ4iInr5Zts1Xz9iWbTRSimvO2Cht9tCt0TsZWA=;
  b=g1vxlen7PpKN/TmZ5Hc6q+EhiqCE9MvHGChTHaHunSUA0nOIwaZ0u1oA
   R4ArnoBmjwvDYQ1MWhmnHB63Rau6Vl11Z2366W+US1giEZjtZaLFMmknX
   I0BXJHhjzcQQV2mW4A5DdsZZnqNIIfkXTTjCE0ocAgcNhtuoPIP+SbBJH
   upovthlWEViETiZUp7iSPNMRdFP0c4dc75wAiT/WolI2uL7c8fD51jGXG
   YegTLMV8PNalliV8m7zwFVe/XAMA+URAKB7KO8C5WelN1Dq57a34E6CFS
   o33GR56aHraWwcophONhAe0GZZwUixva1DtkzdYUpKZ/EgT/sx+jPvVDH
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10583"; a="387131722"
X-IronPort-AV: E=Sophos;i="5.96,309,1665471600"; 
   d="scan'208";a="387131722"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2023 15:35:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10583"; a="606234252"
X-IronPort-AV: E=Sophos;i="5.96,309,1665471600"; 
   d="scan'208";a="606234252"
Received: from lkp-server02.sh.intel.com (HELO f1920e93ebb5) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 07 Jan 2023 15:35:22 -0800
Received: from kbuild by f1920e93ebb5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pEIif-0004wI-2K;
        Sat, 07 Jan 2023 23:35:21 +0000
Date:   Sun, 08 Jan 2023 07:35:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/platform] BUILD SUCCESS
 7ddf0050a21fdcc025c3cb1055fe3db60df1cd97
Message-ID: <63ba01b4.e8Ryg38tmrBQQYk7%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/platform
branch HEAD: 7ddf0050a21fdcc025c3cb1055fe3db60df1cd97  x86/mce/dev-mcelog: use strscpy() to instead of strncpy()

elapsed time: 721m

configs tested: 100
configs skipped: 61

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                              defconfig
x86_64                        randconfig-a015
x86_64                        randconfig-a004
x86_64                           rhel-8.3-bpf
x86_64                        randconfig-a002
x86_64                           rhel-8.3-syz
x86_64                               rhel-8.3
x86_64                         rhel-8.3-kunit
i386                          randconfig-a001
x86_64                           rhel-8.3-kvm
x86_64                        randconfig-a006
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                           allyesconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
i386                                defconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                             allyesconfig
sh                          rsk7264_defconfig
x86_64                           alldefconfig
powerpc                      ppc40x_defconfig
arc                              alldefconfig
mips                           ci20_defconfig
arm                        cerfcube_defconfig
m68k                        mvme147_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                          randconfig-c001
sh                             sh03_defconfig
ia64                         bigsur_defconfig
sh                           se7751_defconfig
mips                         cobalt_defconfig
arc                      axs103_smp_defconfig
powerpc                      cm5200_defconfig
arm                        trizeps4_defconfig
nios2                         3c120_defconfig
xtensa                  cadence_csp_defconfig
sh                           se7722_defconfig
mips                            gpr_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
mips                           jazz_defconfig
arm                           sama5_defconfig
powerpc                     asp8347_defconfig
s390                       zfcpdump_defconfig
m68k                             allyesconfig
arm                           imxrt_defconfig
arc                            hsdk_defconfig
sh                           sh2007_defconfig
powerpc                   currituck_defconfig
sh                            migor_defconfig
xtensa                          iss_defconfig
powerpc                         wii_defconfig
arm                          pxa3xx_defconfig
sh                        dreamcast_defconfig
arm                        mini2440_defconfig
mips                           ip32_defconfig
riscv                            allmodconfig
mips                       bmips_be_defconfig
sh                ecovec24-romimage_defconfig
sh                                  defconfig
sh                              ul2_defconfig
arm                       multi_v4t_defconfig
mips                           gcw0_defconfig

clang tested configs:
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a002
i386                          randconfig-a004
x86_64                        randconfig-a005
x86_64                          rhel-8.3-rust
i386                          randconfig-a013
i386                          randconfig-a006
i386                          randconfig-a011
i386                          randconfig-a015
arm                       aspeed_g4_defconfig
powerpc                     mpc5200_defconfig
arm                         palmz72_defconfig
arm                         orion5x_defconfig
arm                           spitz_defconfig
x86_64                        randconfig-k001
mips                          rm200_defconfig
arm                          collie_defconfig
arm                       imx_v4_v5_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
