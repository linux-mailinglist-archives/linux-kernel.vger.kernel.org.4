Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 041A667506E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 10:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjATJPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 04:15:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbjATJOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 04:14:55 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 882B68CE51
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 01:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674206075; x=1705742075;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=xvTomK/hbjH7NXy9omXHyjfcFvO+Y+rIhBj/IBSAx60=;
  b=LVWQoFTLrlpYvCfhvXC1Dcvb5Khwbd7WVp7ba/fsIaOj0J7TnQBnYebw
   2knqHU/phwTsws8S3R9qlsQadkEMPAyhq9rKCfZccygLbA5axb1CsDECq
   vb15SvQnFMVuLl3vcHxqLTcJxUmc6CXwOm4rGr4RAZCcqtMB5gBleVCFX
   ITFic04x0vSspKzOaSXTaFv+MRLLHzEDzQjGv1SR8808OuJ7b7Z0a80jQ
   /Lqr9OvsGSlcCXrqEXYxjHBAaKexZVpb2xRkWFlncm3B9JSQ+mPEc3y19
   PXpAB/4wM8/Fn0kT2aBuANsSb7LwNBuWFpiLPmQUwQgumCdpoV63gPPRV
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="326817739"
X-IronPort-AV: E=Sophos;i="5.97,231,1669104000"; 
   d="scan'208";a="326817739"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 01:13:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="905901336"
X-IronPort-AV: E=Sophos;i="5.97,231,1669104000"; 
   d="scan'208";a="905901336"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 20 Jan 2023 01:13:52 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pInT5-0002QA-2i;
        Fri, 20 Jan 2023 09:13:51 +0000
Date:   Fri, 20 Jan 2023 17:13:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/fpu] BUILD SUCCESS
 aa81cb9d9723694bb18359adbef7964030758dba
Message-ID: <63ca5b43.k6f5v0aOesDFRean%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/fpu
branch HEAD: aa81cb9d9723694bb18359adbef7964030758dba  x86/fpu: Replace zero-length array in struct xregs_state with flexible-array member

elapsed time: 722m

configs tested: 51
configs skipped: 61

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
x86_64                           rhel-8.3-syz
x86_64                           rhel-8.3-kvm
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-bpf
x86_64                              defconfig
i386                          randconfig-a001
i386                          randconfig-a003
x86_64                               rhel-8.3
i386                          randconfig-a005
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
um                           x86_64_defconfig
um                             i386_defconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
i386                             allyesconfig
i386                                defconfig
ia64                             allmodconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
s390                             allyesconfig
arm                              allyesconfig
alpha                               defconfig
sh                          rsk7269_defconfig
powerpc                       maple_defconfig
ia64                                defconfig
sh                        sh7757lcr_defconfig
openrisc                  or1klitex_defconfig

clang tested configs:
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                          rhel-8.3-rust
riscv                randconfig-r042-20230119
s390                 randconfig-r044-20230119
hexagon              randconfig-r041-20230119
hexagon              randconfig-r045-20230119
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
