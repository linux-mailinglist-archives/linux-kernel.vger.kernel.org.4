Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0A776411A6
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 00:48:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234270AbiLBXsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 18:48:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiLBXsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 18:48:36 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C712DFD0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 15:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670024916; x=1701560916;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=og9WnZkvyARYlApB0bi0VbNSMYykjGgD9xMSZ3JjhDc=;
  b=FTROh0XAupQl9QQud2yJvvxGCCKjahViGfsrgD6mk8Z8ZDrsUMALO5TH
   bDJvdngDEPYrx8AFd+w8k9bG45yyUROB+ZaKkPFMQtWpWdy2CfMuAzt4T
   gxzwEu5vHZEieToK5ewm89d7c7eLJK3H2WGWbZ3+nmAk9VFgWQMCb4Q95
   jrE6oQkzLVP3b+KdDKLCk/K/fxijWrzcSKiCzg2n3ps3/2dWqzDCxMC3j
   9Je0pPMnsDoLKeU7JaM6nib+LFj/DB2BA/IK6bih7rgZWsxJ4xeqkhyWV
   od2GwgExlTbRE95gS4fOUzdHdOGskKAsU0/CoxdSP12oJue/eoio6tXtd
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="295762119"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="295762119"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 15:48:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="819601642"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="819601642"
Received: from lkp-server01.sh.intel.com (HELO 64a2d449c951) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 02 Dec 2022 15:48:33 -0800
Received: from kbuild by 64a2d449c951 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p1Flg-000E7n-13;
        Fri, 02 Dec 2022 23:48:32 +0000
Date:   Sat, 03 Dec 2022 07:47:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:core/debugobjects] BUILD SUCCESS
 c4db2d3b70e586c7c856c891f4f7052e8d789a06
Message-ID: <638a8e9e.1AHQ0ce6vGMzxy+x%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core/debugobjects
branch HEAD: c4db2d3b70e586c7c856c891f4f7052e8d789a06  debugobjects: Print object pointer in debug_print_object()

elapsed time: 723m

configs tested: 67
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
powerpc                           allnoconfig
x86_64                        randconfig-a002
x86_64                        randconfig-a004
x86_64                        randconfig-a006
sh                               allmodconfig
x86_64                           rhel-8.3-syz
arc                  randconfig-r043-20221201
x86_64                         rhel-8.3-kunit
s390                 randconfig-r044-20221201
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
mips                             allyesconfig
x86_64                           rhel-8.3-kvm
x86_64                           allyesconfig
x86_64                          rhel-8.3-func
arc                                 defconfig
x86_64                               rhel-8.3
alpha                               defconfig
ia64                             allmodconfig
powerpc                          allmodconfig
riscv                randconfig-r042-20221201
x86_64                        randconfig-a013
x86_64                        randconfig-a011
s390                             allmodconfig
x86_64                        randconfig-a015
s390                                defconfig
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
s390                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
alpha                            allyesconfig
arc                              allyesconfig
i386                                defconfig
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
i386                             allyesconfig
x86_64                            allnoconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
arc                        vdk_hs38_defconfig
arm                           stm32_defconfig
powerpc                 mpc834x_itx_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func

clang tested configs:
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
hexagon              randconfig-r045-20221201
hexagon              randconfig-r041-20221201
x86_64                        randconfig-a014
x86_64                        randconfig-a012
x86_64                        randconfig-a016
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
