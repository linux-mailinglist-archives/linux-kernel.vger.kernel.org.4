Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 088D06756F2
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 15:21:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjATOVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 09:21:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjATOVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 09:21:50 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D31C3B0F5
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 06:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674224473; x=1705760473;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=ZyxyHvOCP8uXM+YYo39108D/Po0mCLTKmzgeRMQgj1g=;
  b=lLWf8yRr90rw2ZVfiIL46YFWHv27ZolvnAU2QzCyI4nAu5odCjWxLSD4
   xV8W4h2IY97jXESfJgvUnTIs6RvoQX1Sv6t+VFWFL7z+JICL1o3le0k63
   w2PSrjFMMqqVEABLiH6kOd9M4wgUqFNDSlpKoS5QT3qmVfs/d+wfiDNe+
   QBbWWHIhhKtHaNHTTcp/8yD0f33hen/9Q/MqM3hYAXLa/1r14d6Pr8v/2
   hSdr/YL9/EiDWX7xTGSS++VPsoLd7jR27tErNZhntQuScky/kwLxQqhKc
   Q9TwNp5ynaMR0hHs/CzoJrykgp8MxTrP5OM/a13yxhIddRyIB/GQ47bNn
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="326864384"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="326864384"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 06:21:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="749349274"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="749349274"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Jan 2023 06:21:06 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pIsGP-0002cE-0j;
        Fri, 20 Jan 2023 14:21:05 +0000
Date:   Fri, 20 Jan 2023 22:20:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:haltnmi3glacial.2023.01.19a] BUILD SUCCESS
 5d4159ff8295addf11917c989a18dfdce1c77686
Message-ID: <63caa331.5mVojXlqqr+p9+IT%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git haltnmi3glacial.2023.01.19a
branch HEAD: 5d4159ff8295addf11917c989a18dfdce1c77686  x86/nmi: Test commit for severely delayed NMI handlers

elapsed time: 794m

configs tested: 71
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
um                             i386_defconfig
s390                                defconfig
um                           x86_64_defconfig
x86_64                           rhel-8.3-syz
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-bpf
x86_64                              defconfig
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests
x86_64                               rhel-8.3
s390                             allyesconfig
x86_64                          rhel-8.3-func
powerpc                           allnoconfig
sh                               allmodconfig
mips                             allyesconfig
i386                                defconfig
i386                          randconfig-a001
x86_64                           allyesconfig
i386                          randconfig-a003
i386                          randconfig-a005
arm                  randconfig-r046-20230119
arc                  randconfig-r043-20230119
ia64                             allmodconfig
m68k                             allmodconfig
m68k                             allyesconfig
x86_64                        randconfig-a013
alpha                            allyesconfig
x86_64                        randconfig-a011
arm                                 defconfig
arc                              allyesconfig
x86_64                        randconfig-a015
x86_64                        randconfig-a004
i386                             allyesconfig
powerpc                          allmodconfig
x86_64                        randconfig-a002
i386                          randconfig-a014
i386                          randconfig-a012
x86_64                        randconfig-a006
i386                          randconfig-a016
arm64                            allyesconfig
arm                              allyesconfig
ia64                             alldefconfig
powerpc                        warp_defconfig
sh                ecovec24-romimage_defconfig
sh                          urquell_defconfig
xtensa                  audio_kc705_defconfig

clang tested configs:
x86_64                          rhel-8.3-rust
i386                          randconfig-a002
i386                          randconfig-a004
hexagon              randconfig-r045-20230119
i386                          randconfig-a006
hexagon              randconfig-r041-20230119
s390                 randconfig-r044-20230119
x86_64                        randconfig-a012
riscv                randconfig-r042-20230119
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a013
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a011
x86_64                        randconfig-a005
i386                          randconfig-a015
riscv                             allnoconfig
x86_64                        randconfig-k001
arm                  colibri_pxa270_defconfig
arm                        neponset_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
