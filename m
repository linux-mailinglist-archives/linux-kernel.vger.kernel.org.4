Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7800C68AC45
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 21:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbjBDUcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 15:32:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjBDUcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 15:32:06 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C572A9BA
        for <linux-kernel@vger.kernel.org>; Sat,  4 Feb 2023 12:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675542717; x=1707078717;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=N7LJDyCD36ZM7TtFzMQvFxbfiKdJEBPzT2JQdEqrxMo=;
  b=aJPn7lcjyn8EU4NYNEhHclxPcr+My2RGmJL8oRijvBL1sfETR+LN0DSj
   +Y6Us5F3+Q8frKplJH3ixkXoC5OGgwKBJXX2125hzpZWm8NE4/L8ulfmK
   gZBmUn1Yf6pmU6cpWAp+AHoSKNAcWoM0PKMPWwoAJiLU1iPt8AgOyFe/w
   9EZAQjRycoGU5OZ7rWn/DyOvRLe0DjjbqlcPy1M0LrIMFKS/auKFQ0UVs
   jsA2cMLPq/Eq/J/Mt5JJNRhYcvi4oM33UlwgeVHJajNBfxLZgMvhnhx3Y
   3gpNq3KFXZ1S+xv9oup6k8H5N/PwN00l+D0mYE2hGt4bHj1d2EGcRX/DJ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10611"; a="415199607"
X-IronPort-AV: E=Sophos;i="5.97,272,1669104000"; 
   d="scan'208";a="415199607"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2023 12:31:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10611"; a="994866761"
X-IronPort-AV: E=Sophos;i="5.97,272,1669104000"; 
   d="scan'208";a="994866761"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 04 Feb 2023 12:31:56 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pOPCV-0001WO-1j;
        Sat, 04 Feb 2023 20:31:55 +0000
Date:   Sun, 05 Feb 2023 04:31:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 d750b0cbd580d775ef69d9fda31a447ff0dad418
Message-ID: <63dec0b8.VcQj3x1Xd2Yx0X/w%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: d750b0cbd580d775ef69d9fda31a447ff0dad418  Merge branch 'x86/tdx'

elapsed time: 1772m

configs tested: 55
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
alpha                               defconfig
arc                                 defconfig
um                             i386_defconfig
powerpc                          allmodconfig
um                           x86_64_defconfig
powerpc                           allnoconfig
sh                               allmodconfig
s390                                defconfig
mips                             allyesconfig
x86_64                              defconfig
s390                             allmodconfig
x86_64                               rhel-8.3
ia64                             allmodconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
x86_64                           rhel-8.3-bpf
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
i386                          randconfig-a001
i386                          randconfig-a003
riscv                randconfig-r042-20230204
i386                          randconfig-a005
arc                  randconfig-r043-20230204
s390                 randconfig-r044-20230204
x86_64                           allyesconfig
s390                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allyesconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                                defconfig
i386                          randconfig-a016
i386                             allyesconfig
arm                                 defconfig

clang tested configs:
x86_64                          rhel-8.3-rust
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
hexagon              randconfig-r041-20230204
arm                  randconfig-r046-20230204
i386                          randconfig-a002
hexagon              randconfig-r045-20230204
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a012
x86_64                        randconfig-a014
i386                          randconfig-a015

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
