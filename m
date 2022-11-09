Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 505786224F1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 08:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbiKIHy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 02:54:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiKIHy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 02:54:27 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B9601929B
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 23:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667980466; x=1699516466;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Zi0MsWI44u3Xzk8xu5/j+S1VFNp4x9b5xHvoA2Wefn8=;
  b=n/nANf0yJDdZrpD/3m7Nhck6X6OiH8yQ5OaQ2RM1r99CzIrbzMPLzIAo
   lKmY9lnysK8PuD9OtipVWtLp1o6p0CT9FQe9XREChVqRLgsTh6+L+/tzc
   oP3A4GLYIkHzZyrVMXxWAb9E2U3D2I/Q6cBn1HyiCj0G41X3VjMT3VWb9
   OMEScyIhz48DuE8TZCMdqgCIQxT8Onf+foFhRLzQSvJMl0nCo1xZDD79n
   2WU9TyJq5JS5uC6ccDLCsGb1fKzrkywRur+vfuL92TnzZrEiulpUGdNyf
   zjiozlHopHlaf7CpesyaSmKxBc8f79s//p5OjzB+0Q3T05Y+hFLoyTp24
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="291304587"
X-IronPort-AV: E=Sophos;i="5.96,149,1665471600"; 
   d="scan'208";a="291304587"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 23:54:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="965899962"
X-IronPort-AV: E=Sophos;i="5.96,149,1665471600"; 
   d="scan'208";a="965899962"
Received: from lkp-server01.sh.intel.com (HELO e783503266e8) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 08 Nov 2022 23:54:24 -0800
Received: from kbuild by e783503266e8 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1osfui-0001Ew-0l;
        Wed, 09 Nov 2022 07:54:24 +0000
Date:   Wed, 09 Nov 2022 15:54:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:Wcast-function-type-strict-v3] BUILD SUCCESS
 8d2ceee1248b5a76e9b6c379f578e65482c91168
Message-ID: <636b5c9a.Ymjq3PSFwAH2ahcb%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git Wcast-function-type-strict-v3
branch HEAD: 8d2ceee1248b5a76e9b6c379f578e65482c91168  staging: ks7010: Avoid clashing function prototypes

elapsed time: 723m

configs tested: 58
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                  randconfig-r043-20221108
riscv                randconfig-r042-20221108
s390                 randconfig-r044-20221108
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
s390                                defconfig
s390                             allyesconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
i386                                defconfig
x86_64                              defconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
m68k                             allmodconfig
ia64                             allmodconfig
arc                              allyesconfig
mips                             allyesconfig
i386                          randconfig-a001
x86_64                               rhel-8.3
alpha                            allyesconfig
i386                          randconfig-a003
x86_64                           allyesconfig
sh                               allmodconfig
i386                             allyesconfig
i386                          randconfig-a005
m68k                             allyesconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
arm                                 defconfig
i386                          randconfig-a012
arm                              allyesconfig
i386                          randconfig-a014
x86_64                        randconfig-a004
i386                          randconfig-a016
arm64                            allyesconfig
x86_64                        randconfig-a002
x86_64                        randconfig-a006
x86_64                        randconfig-a015

clang tested configs:
hexagon              randconfig-r045-20221108
hexagon              randconfig-r041-20221108
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a016
x86_64                        randconfig-a014
x86_64                        randconfig-a005

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
