Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97A0A641194
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 00:39:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234775AbiLBXjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 18:39:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233745AbiLBXjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 18:39:41 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D20FE8DBE7
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 15:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670024380; x=1701560380;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=gwWdlpukwKlTb29GFb6JJ0dOqdTV1HiKuEqM/6TYQRc=;
  b=QZH8J56uJqLO8hVTvb7PIQ71Q0md7IxIzMH7eolnM4jwJ+8d9tIopAqK
   PZZZVzmj9Ie4khu6GZzzlvxQkCIwtqE6EPSHASylXOVb8n1KCNFby1dIs
   1DBfU9kC5AJJ1rd7RLZECV9dDNxoB1Rhh++mes5IQK72p/0UzNBENWVcF
   UXv6U4jLUePWtK2c/q2wtwCtYR6pht1zBBkOcu0GJDSmK6P+El8jAgRBX
   MEMu/Wj7Kd5G212hkAs6Vo5kLpHwcR1OfJJYIZrUNZpq0GwCNwU8njORT
   3dgPWAWRFX+Y2Io4HxKuOtEzwB3FoUW128ytSAcKC26rLhG4g5A5ww74F
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="303679769"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="303679769"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 15:39:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="819599820"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="819599820"
Received: from lkp-server01.sh.intel.com (HELO 64a2d449c951) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 02 Dec 2022 15:39:33 -0800
Received: from kbuild by 64a2d449c951 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p1Fcy-000E7W-0X;
        Fri, 02 Dec 2022 23:39:32 +0000
Date:   Sat, 03 Dec 2022 07:39:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:locking/core] BUILD SUCCESS
 90d758896787048fa3d4209309d4800f3920e66f
Message-ID: <638a8c94.ga87H+I+2/cm8cAl%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/core
branch HEAD: 90d758896787048fa3d4209309d4800f3920e66f  futex: Resend potentially swallowed owner death notification

elapsed time: 722m

configs tested: 67
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
x86_64                           rhel-8.3-syz
um                             i386_defconfig
x86_64                         rhel-8.3-kunit
um                           x86_64_defconfig
x86_64                           rhel-8.3-kvm
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
powerpc                           allnoconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
m68k                             allmodconfig
arc                              allyesconfig
arc                                 defconfig
alpha                            allyesconfig
s390                             allmodconfig
sh                               allmodconfig
alpha                               defconfig
x86_64                               rhel-8.3
s390                                defconfig
x86_64                              defconfig
mips                             allyesconfig
i386                          randconfig-a001
m68k                             allyesconfig
i386                          randconfig-a003
s390                             allyesconfig
powerpc                          allmodconfig
i386                          randconfig-a005
x86_64                           allyesconfig
arc                  randconfig-r043-20221201
s390                 randconfig-r044-20221201
riscv                randconfig-r042-20221201
ia64                             allmodconfig
i386                                defconfig
i386                             allyesconfig
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
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
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-a012
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
hexagon              randconfig-r045-20221201
hexagon              randconfig-r041-20221201
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
