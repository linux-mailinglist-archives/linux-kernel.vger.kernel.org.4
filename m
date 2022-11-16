Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE7B562CC8E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 22:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234015AbiKPVTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 16:19:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233633AbiKPVTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 16:19:21 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 253DD5B842
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 13:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668633561; x=1700169561;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=YaDlsdgPoRzdqcmZPFKIfX+zfD5k9W8bD6d3Sh9LJTM=;
  b=mWOhbzsw06wkPDEeJ0NTUHMwEeVTcMlaXl2I547FltvB+uIKpQsGjiBF
   m/tD+QXDWllviCw3Yj+7il8kBe86+v0WYdXDgDzgBwiacgsc3MWgjWAuJ
   RymbFe5c4/0S80Z9sBCboXn13/pB7MS+uBEtAIFVuH4KnDgpYagzj0eAt
   Na/cwUYWW6pKCace4v7ktk/nq1iHgzgUxSJ4Xi/4LKHP/brsrQSRUBYiJ
   OVV0pfjPdcCH9J6fEG88LWH0bAsjUT81SxqInIMgcKDoJ/LtBRp8C6MP7
   nIC493PD1xuPrwbn5r1ApPnsEsjDTt0Bns7WWAfbsBZm5QNfwN3rF1lOp
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="339491336"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="339491336"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 13:19:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="670654280"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="670654280"
Received: from lkp-server01.sh.intel.com (HELO ebd99836cbe0) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 16 Nov 2022 13:19:19 -0800
Received: from kbuild by ebd99836cbe0 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ovPoU-0002kP-2p;
        Wed, 16 Nov 2022 21:19:18 +0000
Date:   Thu, 17 Nov 2022 05:18:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:perf/urgent] BUILD SUCCESS
 ce0d998be9274dd3a3d971cbeaa6fe28fd2c3062
Message-ID: <637553b7.tu7NRqEvqGX3Z1qj%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/urgent
branch HEAD: ce0d998be9274dd3a3d971cbeaa6fe28fd2c3062  perf/x86/intel/pt: Fix sampling using single range output

elapsed time: 722m

configs tested: 74
configs skipped: 101

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
i386                                defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a013
x86_64                        randconfig-a006
x86_64                        randconfig-a011
i386                             allyesconfig
x86_64                        randconfig-a015
x86_64                            allnoconfig
um                           x86_64_defconfig
um                             i386_defconfig
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
s390                             allyesconfig
sh                          r7785rp_defconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
ia64                             allmodconfig
arm                        realview_defconfig
powerpc                   currituck_defconfig
xtensa                    xip_kc705_defconfig
riscv                    nommu_k210_defconfig
openrisc                            defconfig
i386                          randconfig-c001
arm                             ezx_defconfig
arm                        oxnas_v6_defconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
sh                            titan_defconfig
powerpc                 mpc85xx_cds_defconfig
mips                            ar7_defconfig
arm                            zeus_defconfig
microblaze                          defconfig
sh                          rsk7203_defconfig
sparc64                          alldefconfig
powerpc                    amigaone_defconfig
arc                     haps_hs_smp_defconfig
sh                           se7705_defconfig
arm                            qcom_defconfig

clang tested configs:
i386                          randconfig-a013
i386                          randconfig-a015
i386                          randconfig-a011
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
powerpc                     pseries_defconfig
hexagon              randconfig-r041-20221117
hexagon              randconfig-r045-20221117

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
