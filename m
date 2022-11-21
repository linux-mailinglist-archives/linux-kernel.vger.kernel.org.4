Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5302D632418
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 14:42:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbiKUNmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 08:42:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbiKUNmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 08:42:23 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B431ACE9B
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 05:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669038143; x=1700574143;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=vW6UpyDIJ4lErImes9hQg9f4W5M1m5/Y7NR0Nm54Jb0=;
  b=bBig0DL5K/+cI8f2rLSuwZoAjhplqT00VNaub4W/EbGQbbmqdEPTPZ0U
   fw6JvGIYVqpd7ubpqVGRcIUX/1WE8yOmylzwRHrVT0XIW8/3E4AiYDNnH
   y37DOZqO3OYeiTVDwn2x6cVw2+mRUqFNxXSfI016e9RVzohP/z4orXbE7
   jX7TINlAc3YFedbtArgTRpytxwBrGauNFeTUmhHC26ktrgnB6L5hCSUqg
   LNwwTpiyJvohV5JTnmgisulX/JFhb14pXvY+pE76C3IpGTMLeZ4DI0g6X
   3dw9/owGpgIwyzgxMKhchypAwJQv0dLPU7g/dQK1rngWqy7KHqgcisOHT
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10537"; a="375702673"
X-IronPort-AV: E=Sophos;i="5.96,181,1665471600"; 
   d="scan'208";a="375702673"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2022 05:42:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10537"; a="746913669"
X-IronPort-AV: E=Sophos;i="5.96,181,1665471600"; 
   d="scan'208";a="746913669"
Received: from lkp-server01.sh.intel.com (HELO 64a2d449c951) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 21 Nov 2022 05:42:21 -0800
Received: from kbuild by 64a2d449c951 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ox740-0000T8-1t;
        Mon, 21 Nov 2022 13:42:20 +0000
Date:   Mon, 21 Nov 2022 21:41:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2022.11.16a] BUILD SUCCESS
 bc5b4c8070cc9f937197bc66d87e29dcbd5eabec
Message-ID: <637b8009.kwBmWhK8JBIzlwEv%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2022.11.16a
branch HEAD: bc5b4c8070cc9f937197bc66d87e29dcbd5eabec  tools: memory-model: Add rmw-sequences to the LKMM

elapsed time: 5236m

configs tested: 77
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
i386                                defconfig
i386                             allyesconfig
arm                                 defconfig
arm                              allyesconfig
arm64                            allyesconfig
arc                                 defconfig
alpha                               defconfig
s390                                defconfig
i386                 randconfig-a011-20221121
i386                 randconfig-a013-20221121
um                             i386_defconfig
i386                 randconfig-a012-20221121
ia64                             allmodconfig
um                           x86_64_defconfig
i386                 randconfig-a016-20221121
s390                             allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a015-20221121
i386                 randconfig-a014-20221121
x86_64               randconfig-a012-20221121
arc                  randconfig-r043-20221120
x86_64               randconfig-a011-20221121
x86_64               randconfig-a015-20221121
x86_64               randconfig-a013-20221121
mips                             allyesconfig
x86_64               randconfig-a014-20221121
s390                             allyesconfig
x86_64               randconfig-a016-20221121
powerpc                          allmodconfig
sh                               allmodconfig
arc                  randconfig-r043-20221121
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                            allnoconfig
s390                 randconfig-r044-20221121
x86_64                           rhel-8.3-syz
riscv                randconfig-r042-20221121
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
sh                            migor_defconfig
sh                          urquell_defconfig
arc                              allyesconfig
i386                          randconfig-c001
alpha                            allyesconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
m68k                             allmodconfig
mips                      loongson3_defconfig
csky                                defconfig
powerpc                      ppc6xx_defconfig
sh                             espt_defconfig
arm                              allmodconfig
arm                           corgi_defconfig
m68k                             allyesconfig

clang tested configs:
i386                 randconfig-a004-20221121
i386                 randconfig-a001-20221121
i386                 randconfig-a003-20221121
i386                 randconfig-a005-20221121
i386                 randconfig-a002-20221121
i386                 randconfig-a006-20221121
x86_64               randconfig-a001-20221121
x86_64               randconfig-a002-20221121
x86_64               randconfig-a004-20221121
x86_64               randconfig-a003-20221121
x86_64               randconfig-a005-20221121
x86_64               randconfig-a006-20221121
hexagon              randconfig-r041-20221120
hexagon              randconfig-r041-20221121
hexagon              randconfig-r045-20221120
hexagon              randconfig-r045-20221121
riscv                randconfig-r042-20221120
s390                 randconfig-r044-20221120
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
