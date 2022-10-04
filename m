Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63C6F5F3C49
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 06:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbiJDEzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 00:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbiJDEzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 00:55:31 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C93522F035
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 21:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664859324; x=1696395324;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=lzEXkDoOU2qVEKtEWI4Zn1xLsPwOr62qzyiGmdW0a4I=;
  b=keSInel2d7ArW7F+oO9v5WOeKsf1bCBCJReD64RH+B4VkWa+O7z6EBWw
   j59YFXg64XBlBNhZqwdHc8hwU/Cz3jtmDUGKZXgLSJbPVzp28DA+iWUYm
   RP8UDtOckidMUR08p7hKR/XJWIRKp7V2SofUH58mgy4imoPsk0Z4kczdB
   tYBRMVhwDNa5srbnyaQvSM2H68/pE/U38H223zGnQG7eS3h/xN83wgL66
   rlQ8TFgpnTaLz6jAmzw3icG5oTmfKSJSiUTdyVO7CJNwBvBe8DUFU/69z
   K09RzAx513gy5S+9EXHOc5AvGW7asQJbgcA+5DIrmp/vyqgfSJkVfiHeo
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="301548233"
X-IronPort-AV: E=Sophos;i="5.93,367,1654585200"; 
   d="scan'208";a="301548233"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2022 21:55:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="692350384"
X-IronPort-AV: E=Sophos;i="5.93,367,1654585200"; 
   d="scan'208";a="692350384"
Received: from lkp-server01.sh.intel.com (HELO 14cc182da2d0) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 03 Oct 2022 21:55:23 -0700
Received: from kbuild by 14cc182da2d0 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ofZxi-0005Jx-2h;
        Tue, 04 Oct 2022 04:55:22 +0000
Date:   Tue, 04 Oct 2022 12:54:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:srcunmisafe.2022.10.03a] BUILD SUCCESS
 83ddb5e0e56d37f892b2b6ddd39b361dc91c758c
Message-ID: <633bbc8d.rGNrKc6fq5RpSH//%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git srcunmisafe.2022.10.03a
branch HEAD: 83ddb5e0e56d37f892b2b6ddd39b361dc91c758c  arch/s390: Add ARCH_HAS_NMI_SAFE_THIS_CPU_OPS Kconfig option

elapsed time: 726m

configs tested: 74
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
alpha                               defconfig
i386                                defconfig
s390                             allmodconfig
s390                                defconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
s390                             allyesconfig
x86_64                              defconfig
x86_64                          rhel-8.3-func
sh                               allmodconfig
x86_64                    rhel-8.3-kselftests
m68k                             allmodconfig
x86_64                               rhel-8.3
arc                              allyesconfig
i386                 randconfig-a015-20221003
arm                                 defconfig
i386                 randconfig-a014-20221003
x86_64                           allyesconfig
x86_64               randconfig-a011-20221003
alpha                            allyesconfig
x86_64               randconfig-a015-20221003
x86_64               randconfig-a014-20221003
i386                             allyesconfig
i386                 randconfig-a011-20221003
m68k                             allyesconfig
x86_64               randconfig-a012-20221003
riscv                randconfig-r042-20221003
i386                 randconfig-a012-20221003
x86_64               randconfig-a013-20221003
arc                  randconfig-r043-20221003
i386                 randconfig-a013-20221003
x86_64               randconfig-a016-20221003
i386                 randconfig-a016-20221003
powerpc                          allmodconfig
arm                              allyesconfig
mips                             allyesconfig
s390                 randconfig-r044-20221003
arm64                            allyesconfig
powerpc                           allnoconfig
ia64                             allmodconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
m68k                         apollo_defconfig
m68k                          atari_defconfig
sh                   sh7770_generic_defconfig
arc                    vdk_hs38_smp_defconfig
arm                             ezx_defconfig
arc                  randconfig-r043-20221002
powerpc                     redwood_defconfig
m68k                       bvme6000_defconfig

clang tested configs:
hexagon              randconfig-r041-20221003
i386                 randconfig-a004-20221003
i386                 randconfig-a005-20221003
i386                 randconfig-a003-20221003
i386                 randconfig-a002-20221003
i386                 randconfig-a001-20221003
x86_64               randconfig-a003-20221003
i386                 randconfig-a006-20221003
hexagon              randconfig-r045-20221003
x86_64               randconfig-a005-20221003
x86_64               randconfig-a002-20221003
x86_64               randconfig-a001-20221003
x86_64               randconfig-a004-20221003
x86_64               randconfig-a006-20221003
arm                         mv78xx0_defconfig
powerpc                       ebony_defconfig
arm                          collie_defconfig
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
