Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD6F685C1D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 01:21:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbjBAAVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 19:21:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjBAAVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 19:21:33 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 095244488
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 16:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675210893; x=1706746893;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=8wwyK+ecYqoaZv2DPwdlHVFXcliDZ62hvSGRpKhqMiQ=;
  b=GITyJ8OlTz4q35vYgup4M5cyMwzUEdXjRK5EG9S2HBQjerqz66KcJM5i
   moR9m0rihetXLRif8Kn7XRKkxLeIIuREx/oRyZbmeptc1GJPPbjgcraR7
   tbamaqE9D3f9z/BgCKLB7wwZNnQKjXufYeAaTqnDtqsqzp1xvokDJNENY
   Hi+rNIq/VlfSLJWEViEiiizEChtQCu6n7Ea6k5cHjaDCm0jo0Lhizj4b+
   O9TKELijIFG5UDR2LQu2eAlyXFhvmHmQgBjkCTKSRnLST6HW9L2mVpmhv
   el3q3c9bB+1OKElgVYvuEFuWSHgqy3HHBVn8RWDY1ZFOFshL4xdzZ6jn2
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="307658369"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="307658369"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 16:21:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="733339231"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="733339231"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 31 Jan 2023 16:21:31 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pN0sV-0004pe-0E;
        Wed, 01 Feb 2023 00:21:31 +0000
Date:   Wed, 01 Feb 2023 08:21:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 9d2c7203ffdb846399b82b0660563c89e918c751
Message-ID: <63d9b07b.75BbkO2lTvPhEORT%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: 9d2c7203ffdb846399b82b0660563c89e918c751  x86/debug: Fix stack recursion caused by wrongly ordered DR7 accesses

elapsed time: 725m

configs tested: 79
configs skipped: 77

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
i386                 randconfig-a004-20230130
i386                 randconfig-a003-20230130
i386                 randconfig-a002-20230130
i386                 randconfig-a001-20230130
x86_64                          rhel-8.3-func
x86_64               randconfig-a001-20230130
x86_64               randconfig-a003-20230130
x86_64               randconfig-a004-20230130
x86_64                    rhel-8.3-kselftests
i386                 randconfig-a005-20230130
x86_64               randconfig-a002-20230130
i386                 randconfig-a006-20230130
x86_64               randconfig-a006-20230130
x86_64               randconfig-a005-20230130
x86_64                              defconfig
i386                                defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-bpf
i386                             allyesconfig
arc                              allyesconfig
um                           x86_64_defconfig
um                             i386_defconfig
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
ia64                             allmodconfig
i386                          randconfig-c001
powerpc                           allnoconfig
powerpc                          allmodconfig
sh                               allmodconfig
arm                           h5000_defconfig
arm                         lpc18xx_defconfig
m68k                          multi_defconfig
sh                     magicpanelr2_defconfig
arc                            hsdk_defconfig
arm                                 defconfig
arm                              allyesconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
m68k                         amcore_defconfig
mips                        bcm47xx_defconfig
mips                           ci20_defconfig
sh                            titan_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func

clang tested configs:
x86_64                          rhel-8.3-rust
i386                 randconfig-a013-20230130
i386                 randconfig-a012-20230130
i386                 randconfig-a014-20230130
i386                 randconfig-a011-20230130
i386                 randconfig-a015-20230130
i386                 randconfig-a016-20230130
x86_64               randconfig-a014-20230130
x86_64               randconfig-a012-20230130
x86_64               randconfig-a013-20230130
x86_64               randconfig-a011-20230130
x86_64               randconfig-a015-20230130
x86_64               randconfig-a016-20230130
x86_64                        randconfig-k001
hexagon              randconfig-r045-20230130
s390                 randconfig-r044-20230130
riscv                randconfig-r042-20230129
hexagon              randconfig-r041-20230129
hexagon              randconfig-r045-20230129
hexagon              randconfig-r041-20230130
riscv                randconfig-r042-20230130
s390                 randconfig-r044-20230129
hexagon                          alldefconfig

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
