Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E74C063D639
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 14:02:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235655AbiK3NCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 08:02:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234936AbiK3NBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 08:01:50 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B7C7BFBA
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 05:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669813273; x=1701349273;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=/TLr96K0CJ+5i96oXmuu3X8Uy115TElTUHbzwY1tjyo=;
  b=L9iUgKiRMM123VD2W9Ev0Kp8JzCJYJBRxJrJv+p70hcGoYn+DoMbdFyh
   vvOpGGOdB6sxXZwhudGUhaf299DvAop7T2GWmcddwa0nHxN66KfTnFHvX
   uzxmuxTTgRrT+YYvX94F2J3xpVFLdhAa+UIATlup4dYA+bqzHIl7cyAD0
   /PI5GdBO8lZhzaKKKuQ3xqgCxDqzy3D3/2gAXSRAe9UsyJyB9wzvjJq4G
   lWLu8Nji+WrOy2KcTNvftjT/c+/0utQNaVVEyNAqymjT04y6T9SDxC/SS
   EFAZS6T9jmgnuhNZaI59CVAYIXuXzQxulV4XWdFz4OjzbGOgXkt/O59q6
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="401668387"
X-IronPort-AV: E=Sophos;i="5.96,206,1665471600"; 
   d="scan'208";a="401668387"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 05:01:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="818620900"
X-IronPort-AV: E=Sophos;i="5.96,206,1665471600"; 
   d="scan'208";a="818620900"
Received: from lkp-server01.sh.intel.com (HELO 64a2d449c951) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 30 Nov 2022 05:01:11 -0800
Received: from kbuild by 64a2d449c951 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p0Mi6-000B9W-1P;
        Wed, 30 Nov 2022 13:01:10 +0000
Date:   Wed, 30 Nov 2022 21:00:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/boot] BUILD SUCCESS
 60253f100c5846029f1370e51be6ebaeb160dcec
Message-ID: <638753ed.iThbVPot9IMU9y24%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/boot
branch HEAD: 60253f100c5846029f1370e51be6ebaeb160dcec  x86/boot: Remove x86_32 PIC using %ebx workaround

elapsed time: 734m

configs tested: 74
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
i386                 randconfig-a002-20221128
i386                 randconfig-a003-20221128
i386                 randconfig-a001-20221128
x86_64                        randconfig-a013
i386                 randconfig-a004-20221128
x86_64                        randconfig-a011
i386                 randconfig-a005-20221128
x86_64                              defconfig
i386                 randconfig-a006-20221128
i386                                defconfig
x86_64                           rhel-8.3-syz
m68k                             allyesconfig
powerpc                           allnoconfig
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
arc                                 defconfig
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-kvm
x86_64                        randconfig-a015
powerpc                          allmodconfig
s390                             allmodconfig
m68k                             allmodconfig
alpha                               defconfig
sh                               allmodconfig
x86_64                               rhel-8.3
mips                             allyesconfig
arc                  randconfig-r043-20221128
s390                                defconfig
x86_64                           allyesconfig
arc                              allyesconfig
alpha                            allyesconfig
s390                             allyesconfig
i386                             allyesconfig
x86_64                        randconfig-a006
ia64                             allmodconfig
x86_64                            allnoconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
sh                        sh7763rdp_defconfig
powerpc                         ps3_defconfig
xtensa                  cadence_csp_defconfig
mips                      maltasmvp_defconfig
x86_64               randconfig-a002-20221128
x86_64               randconfig-a001-20221128
x86_64               randconfig-a004-20221128
x86_64               randconfig-a006-20221128
x86_64               randconfig-a005-20221128
x86_64               randconfig-a003-20221128

clang tested configs:
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
hexagon              randconfig-r045-20221128
hexagon              randconfig-r041-20221128
riscv                randconfig-r042-20221128
i386                 randconfig-a012-20221128
i386                 randconfig-a011-20221128
s390                 randconfig-r044-20221128
i386                 randconfig-a013-20221128
i386                 randconfig-a015-20221128
i386                 randconfig-a016-20221128
i386                 randconfig-a014-20221128
x86_64               randconfig-k001-20221128
x86_64               randconfig-a011-20221128
x86_64               randconfig-a014-20221128
x86_64               randconfig-a012-20221128
x86_64               randconfig-a013-20221128
x86_64               randconfig-a016-20221128
x86_64               randconfig-a015-20221128
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
