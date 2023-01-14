Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8AF66A855
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 02:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbjANBcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 20:32:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbjANBcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 20:32:04 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84207149F4
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 17:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673659912; x=1705195912;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=+LkgyLk2NcFGTr4twqN9c1Tdl4a8LJpIeBXd2cZEHxM=;
  b=kwm2DFQTOzRHoLA7mri1YaUrl/ie5TDDehQpfeILRj6on4zyvpRe+vq+
   dKJHEE6fQga4HZOYKun4oijTL1MX+pu0f3g2mI3fFPODh87mWNn7wsgSG
   EAZmdWzR30V9fUXHGJs4ucBvgmfuyScD5EnkNLXIKtaOCkSU//r4eH0JV
   wa5l2ERry79+p4+gOizbU/ZEeP+PktnD/JLNcAiTe+OiZU6/6L3wiJR8A
   wmjbeVzapLTiNnrvuW8zz9alOeeue7DLdHIegQnBLT+D6EzTDVOSNg0y3
   lKQWVaTzZSK4Q2G2HAb8sen990Ns00RdLF8BsaFDQARWDiqi8YgTS6cEv
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="321847685"
X-IronPort-AV: E=Sophos;i="5.97,215,1669104000"; 
   d="scan'208";a="321847685"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 17:31:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="688931744"
X-IronPort-AV: E=Sophos;i="5.97,215,1669104000"; 
   d="scan'208";a="688931744"
Received: from lkp-server02.sh.intel.com (HELO f1920e93ebb5) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 13 Jan 2023 17:31:49 -0800
Received: from kbuild by f1920e93ebb5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pGVOe-000Bbc-1F;
        Sat, 14 Jan 2023 01:31:48 +0000
Date:   Sat, 14 Jan 2023 09:31:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 9cac42af6415932af223117416608ac487f92c3d
Message-ID: <63c205f8.oT+sbj60sPtouuFD%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 9cac42af6415932af223117416608ac487f92c3d  Merge branch into tip/master: 'x86/platform'

elapsed time: 727m

configs tested: 63
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
arc                  randconfig-r043-20230112
s390                             allmodconfig
alpha                               defconfig
s390                 randconfig-r044-20230112
riscv                randconfig-r042-20230112
s390                                defconfig
powerpc                           allnoconfig
s390                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
arc                              allyesconfig
alpha                            allyesconfig
i386                          randconfig-a001
i386                          randconfig-a003
x86_64                           rhel-8.3-syz
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-bpf
x86_64                         rhel-8.3-kunit
arm                                 defconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a005
x86_64                        randconfig-a006
ia64                             allmodconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
arm64                            allyesconfig
x86_64                        randconfig-a015
i386                                defconfig
arm                              allyesconfig
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
sh                               allmodconfig
x86_64                              defconfig
x86_64                               rhel-8.3
mips                             allyesconfig
powerpc                          allmodconfig
i386                             allyesconfig
x86_64                           allyesconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
i386                          randconfig-c001

clang tested configs:
arm                  randconfig-r046-20230112
hexagon              randconfig-r041-20230112
hexagon              randconfig-r045-20230112
i386                          randconfig-a002
i386                          randconfig-a004
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a006
x86_64                        randconfig-a005
x86_64                        randconfig-a012
x86_64                        randconfig-a014
i386                          randconfig-a013
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a015
x86_64                          rhel-8.3-rust

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
