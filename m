Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18E8160DC60
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 09:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233294AbiJZHmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 03:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233313AbiJZHmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 03:42:47 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A76C0982
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 00:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666770165; x=1698306165;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=tg0J1SHWrj2/aeL7dMpFKDW5ofVhbgswqgrHtxhYxxI=;
  b=Fnmi25yk+qPvmkS+CVBSNIE3I43Dlsb5lp7F/OidZcqBfvBAbqtdvca0
   yOI1sOU1scuwfyeuV9jXc9RxPpxyoccPx8sXiAkp9Z3KxT1uo5q+I7F3O
   ED2OEWm5plCuPLhZZwVUIKKQysGYk8kEQqZG+5M+YerpkBGuFFvBZuHK/
   IuCGA7SurJF7Fh3KK/z7h9U/S4c+qxsTjIgB2dH9fpzxQPqYEwMN6T8qc
   MD2mN0ye9PovxxL+1R7kbnM0gsKqoQwFZiXlbacK66TrIqO40AQjgtxqA
   av1xxXrf+AYQR6/DeZPIn9/GaWyie29l0rjZVUG8P/wPSKx6Pukume18l
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="308977170"
X-IronPort-AV: E=Sophos;i="5.95,214,1661842800"; 
   d="scan'208";a="308977170"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 00:42:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="665198174"
X-IronPort-AV: E=Sophos;i="5.95,214,1661842800"; 
   d="scan'208";a="665198174"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 26 Oct 2022 00:42:43 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1onb3j-00079c-0Z;
        Wed, 26 Oct 2022 07:42:43 +0000
Date:   Wed, 26 Oct 2022 15:42:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/core] BUILD SUCCESS
 ae25e00ba84073450c07d8ffd2d74f914a027230
Message-ID: <6358e4ed.IN2+On/X/kp2Km6c%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/core
branch HEAD: ae25e00ba84073450c07d8ffd2d74f914a027230  x86/retpoline: Fix crash printing warning

elapsed time: 720m

configs tested: 74
configs skipped: 79

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                           allyesconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a014
x86_64                        randconfig-a006
i386                          randconfig-a012
i386                          randconfig-a016
i386                                defconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
i386                             allyesconfig
x86_64                        randconfig-a015
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
ia64                             allmodconfig
i386                 randconfig-a011-20221024
i386                 randconfig-a014-20221024
i386                 randconfig-a015-20221024
i386                 randconfig-a016-20221024
i386                 randconfig-a012-20221024
i386                 randconfig-a013-20221024
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
s390                             allyesconfig
arc                  randconfig-r043-20221026
s390                 randconfig-r044-20221026
riscv                randconfig-r042-20221026
i386                             alldefconfig
arm                      integrator_defconfig
openrisc                 simple_smp_defconfig
mips                          rb532_defconfig
sh                        edosk7705_defconfig
i386                          randconfig-c001

clang tested configs:
i386                 randconfig-a002-20221024
x86_64                        randconfig-a001
i386                          randconfig-a013
i386                 randconfig-a003-20221024
x86_64                        randconfig-a003
i386                 randconfig-a001-20221024
i386                          randconfig-a011
x86_64                        randconfig-a005
i386                          randconfig-a015
i386                 randconfig-a005-20221024
i386                 randconfig-a004-20221024
i386                 randconfig-a006-20221024
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64               randconfig-a001-20221024
x86_64               randconfig-a003-20221024
x86_64               randconfig-a002-20221024
x86_64               randconfig-a004-20221024
x86_64               randconfig-a005-20221024
x86_64               randconfig-a006-20221024
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
