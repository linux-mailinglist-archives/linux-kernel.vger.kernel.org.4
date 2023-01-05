Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDD6965F7F2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 01:00:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235942AbjAFAAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 19:00:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232449AbjAFAAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 19:00:01 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA8AC392C3
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 16:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672963200; x=1704499200;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=4+dfeziYsgvDulB276KwQutSbBlQJNSxzUmj6LOzsVU=;
  b=bVESVuw2KdEAUOb00qGM/HxfuAjOu+vMfMOpTTvLwg+jHgrZKEzoeSHb
   yJFZsFhKy0j2ireOj7n9Y4TLLPuQzDmyA+Q9Rh5C3FocUh77pPKHkfSMp
   LStWkWx6OTQIK9Lz6SzPOqgUoD1RZOazFZ47m63pmuGD7M4jfRBeIql6Q
   x7yGvYoA7TFJyNNu4R67RvmMSrKpXGI4J+z9XfjVwLj0GkFXGY34TShdi
   mNSByTHrKsL/TyIuTE3mMTyJqtIIFKAthf/nDUZs7MB7oKg5Vb8aa5PLh
   D0H216gW3zu/KCCYyn9Y9H/8X0war8IIIS0HESd5mcCB9L3vqo11KkQ+h
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="408610407"
X-IronPort-AV: E=Sophos;i="5.96,303,1665471600"; 
   d="scan'208";a="408610407"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 16:00:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="657715612"
X-IronPort-AV: E=Sophos;i="5.96,303,1665471600"; 
   d="scan'208";a="657715612"
Received: from lkp-server02.sh.intel.com (HELO f1920e93ebb5) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 05 Jan 2023 15:59:59 -0800
Received: from kbuild by f1920e93ebb5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pDa9O-0002j5-0g;
        Thu, 05 Jan 2023 23:59:58 +0000
Date:   Fri, 06 Jan 2023 07:59:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/alternatives] BUILD SUCCESS
 5d1dd961e74334a2178264193ea813d44ce5e725
Message-ID: <63b7644d.+aS8YKFfBAOFvlLO%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/alternatives
branch HEAD: 5d1dd961e74334a2178264193ea813d44ce5e725  x86/alternatives: Add alt_instr.flags

elapsed time: 721m

configs tested: 72
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
powerpc                           allnoconfig
um                             i386_defconfig
alpha                            allyesconfig
um                           x86_64_defconfig
x86_64                           rhel-8.3-bpf
arc                              allyesconfig
x86_64                           rhel-8.3-syz
sh                               allmodconfig
x86_64                         rhel-8.3-kunit
m68k                             allyesconfig
s390                                defconfig
m68k                             allmodconfig
x86_64                           rhel-8.3-kvm
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
s390                             allyesconfig
arm                                 defconfig
arc                  randconfig-r043-20230105
mips                             allyesconfig
s390                 randconfig-r044-20230105
ia64                             allmodconfig
i386                          randconfig-a001
i386                                defconfig
x86_64                              defconfig
riscv                randconfig-r042-20230105
arm                              allyesconfig
x86_64                        randconfig-a004
i386                          randconfig-a003
arm64                            allyesconfig
x86_64                        randconfig-a002
i386                          randconfig-a014
i386                          randconfig-a005
i386                          randconfig-a012
powerpc                          allmodconfig
x86_64                        randconfig-a006
i386                          randconfig-a016
x86_64                        randconfig-a013
x86_64                               rhel-8.3
x86_64                        randconfig-a011
x86_64                           allyesconfig
x86_64                        randconfig-a015
i386                             allyesconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3

clang tested configs:
x86_64                          rhel-8.3-rust
arm                  randconfig-r046-20230105
hexagon              randconfig-r041-20230105
hexagon              randconfig-r045-20230105
i386                          randconfig-a013
i386                          randconfig-a002
x86_64                        randconfig-a005
i386                          randconfig-a006
x86_64                        randconfig-a001
i386                          randconfig-a011
i386                          randconfig-a015
i386                          randconfig-a004
x86_64                        randconfig-a003
x86_64                        randconfig-a012
x86_64                        randconfig-a016
x86_64                        randconfig-a014
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
