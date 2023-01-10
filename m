Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0A3C66387E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 06:11:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbjAJFKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 00:10:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjAJFKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 00:10:48 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD181CB3D
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 21:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673327447; x=1704863447;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=HBEIW3gp8xDI4nJR7jNK8T9xNVAiFibXFAZsUJ5ebME=;
  b=IDrKuyIW6wfD7WKCEHBZCPcSqcVu5GBxa62X29i3iMdD9/d+HuT73g4b
   4O+fBlmOdqHcuJLyaptUHS1cvpZtLHBhrqAvsB/Ah7a2YvKn0fUIwFueJ
   5uFMmPKSn7e5pQXBruizg+FYSgVEGXqAnB/fphgDdGVuMbjk9cOQP+AZ3
   mn/++UhBuAjqGpUKvlEUQaRkznm3/BMH01oL5FyshmfLsNxpn+HUeQWbD
   y0hA9JIRoUkTiG8lOBd6D6eMBiN9OHQ1VFudiyo4V3YxXZG7Mmx5JPNBr
   s239jBC6TvWE7yVde7nVAvi4HxM1S8m0fZmON41iXa9dep1j9b2z2O1Ho
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="324304503"
X-IronPort-AV: E=Sophos;i="5.96,314,1665471600"; 
   d="scan'208";a="324304503"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 21:10:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="720195111"
X-IronPort-AV: E=Sophos;i="5.96,314,1665471600"; 
   d="scan'208";a="720195111"
Received: from lkp-server02.sh.intel.com (HELO f1920e93ebb5) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 09 Jan 2023 21:10:45 -0800
Received: from kbuild by f1920e93ebb5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pF6uK-0007bJ-31;
        Tue, 10 Jan 2023 05:10:44 +0000
Date:   Tue, 10 Jan 2023 13:10:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:core/urgent] BUILD SUCCESS
 cad90e5381d840cf2296aaac9b3eff71a30b7c5b
Message-ID: <63bcf32f.IxpGg7y56S+TOmDn%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core/urgent
branch HEAD: cad90e5381d840cf2296aaac9b3eff71a30b7c5b  objtool: Tolerate STT_NOTYPE symbols at end of section

elapsed time: 723m

configs tested: 82
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
s390                             allyesconfig
x86_64                            allnoconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
i386                                defconfig
x86_64                               rhel-8.3
i386                          randconfig-a014
arm                                 defconfig
i386                          randconfig-a012
x86_64                           rhel-8.3-bpf
x86_64                           rhel-8.3-syz
x86_64                           allyesconfig
x86_64                         rhel-8.3-kunit
ia64                             allmodconfig
x86_64                           rhel-8.3-kvm
i386                          randconfig-a016
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
x86_64               randconfig-a011-20230109
x86_64               randconfig-a013-20230109
sh                               allmodconfig
x86_64               randconfig-a012-20230109
x86_64                          rhel-8.3-func
x86_64               randconfig-a014-20230109
x86_64                    rhel-8.3-kselftests
x86_64               randconfig-a016-20230109
riscv                randconfig-r042-20230109
m68k                             allyesconfig
s390                 randconfig-r044-20230109
m68k                             allmodconfig
arm                  randconfig-r046-20230108
arc                  randconfig-r043-20230108
x86_64               randconfig-a015-20230109
arc                  randconfig-r043-20230109
i386                             allyesconfig
arm64                            allyesconfig
arc                              allyesconfig
arm                              allyesconfig
alpha                            allyesconfig
i386                          randconfig-c001
i386                 randconfig-a015-20230109
i386                 randconfig-a011-20230109
i386                 randconfig-a013-20230109
i386                 randconfig-a014-20230109
i386                 randconfig-a016-20230109
i386                 randconfig-a012-20230109
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3

clang tested configs:
i386                          randconfig-a013
x86_64               randconfig-a003-20230109
x86_64               randconfig-a002-20230109
i386                          randconfig-a011
x86_64               randconfig-a004-20230109
x86_64               randconfig-a001-20230109
x86_64               randconfig-a005-20230109
x86_64                          rhel-8.3-rust
i386                 randconfig-a004-20230109
i386                 randconfig-a002-20230109
x86_64               randconfig-a006-20230109
hexagon              randconfig-r045-20230109
i386                 randconfig-a003-20230109
arm                  randconfig-r046-20230109
riscv                randconfig-r042-20230108
i386                          randconfig-a015
i386                 randconfig-a001-20230109
hexagon              randconfig-r041-20230108
hexagon              randconfig-r041-20230109
i386                 randconfig-a005-20230109
hexagon              randconfig-r045-20230108
i386                 randconfig-a006-20230109
s390                 randconfig-r044-20230108
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
