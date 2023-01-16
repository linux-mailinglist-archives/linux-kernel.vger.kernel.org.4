Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0502466D112
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 22:46:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233989AbjAPVqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 16:46:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234605AbjAPVqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 16:46:11 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 064A323314
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 13:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673905571; x=1705441571;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=REZ2R4vrlTI7VcqxtVBc5zqpx7WINbA7kDYok/ImK0U=;
  b=a82iPyoH8tWlCMNrj0a62U2SbVQLeemJE7OuwbSFE6gS/QQJPzF3sLU2
   zJgKR2fyM+o8A+fcsA2n6Ctn5SB9AmJSsjSGL6QFKAFSPf1g9g3OMBbzR
   ofnN/4lbJcUGaIPxtC+xcuMGVd+cIkHlRV1WmHajJSD67lquF/6Rpg6mO
   /nOjuwz2mcXk2sA1rwvCHT/Rwi0dHmhGEzlVJtLd5zTI510mdnAFGHB4e
   WoNDlbbMVGWAZCmpFO/qHJwb6KQkmmwFVOQuQrGsH8GTpy0sP7Boz5Jb/
   rgdF7cfNhmegX+U9JCtozoRbKIJVCCod5Ish1/IsdIegHfdNYGXoKmVV/
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="326624054"
X-IronPort-AV: E=Sophos;i="5.97,221,1669104000"; 
   d="scan'208";a="326624054"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2023 13:46:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="722444111"
X-IronPort-AV: E=Sophos;i="5.97,221,1669104000"; 
   d="scan'208";a="722444111"
Received: from lkp-server02.sh.intel.com (HELO f57cd993bc73) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 16 Jan 2023 13:46:06 -0800
Received: from kbuild by f57cd993bc73 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pHXIr-0000jl-2R;
        Mon, 16 Jan 2023 21:46:05 +0000
Date:   Tue, 17 Jan 2023 05:45:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 01171d0a8c93765ffda6fd92e9c0f9907385a8d2
Message-ID: <63c5c56a.SGpPSOoUZktj3zpO%lkp@intel.com>
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
branch HEAD: 01171d0a8c93765ffda6fd92e9c0f9907385a8d2  Merge branch into tip/master: 'x86/platform'

elapsed time: 722m

configs tested: 74
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                              defconfig
x86_64                           rhel-8.3-kvm
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                           rhel-8.3-bpf
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
i386                 randconfig-a014-20230116
i386                 randconfig-a013-20230116
x86_64                           allyesconfig
i386                 randconfig-a012-20230116
i386                 randconfig-a011-20230116
i386                 randconfig-a015-20230116
i386                 randconfig-a016-20230116
arc                  randconfig-r043-20230115
arm                                 defconfig
arc                                 defconfig
s390                             allmodconfig
ia64                             allmodconfig
alpha                               defconfig
arc                  randconfig-r043-20230116
s390                                defconfig
arm                  randconfig-r046-20230115
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
s390                             allyesconfig
alpha                            allyesconfig
s390                 randconfig-r044-20230116
riscv                randconfig-r042-20230116
arm64                            allyesconfig
arm                              allyesconfig
x86_64                        randconfig-a013
x86_64               randconfig-a011-20230116
x86_64               randconfig-a016-20230116
x86_64               randconfig-a014-20230116
x86_64               randconfig-a013-20230116
x86_64               randconfig-a015-20230116
x86_64               randconfig-a012-20230116
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                             allyesconfig
i386                                defconfig

clang tested configs:
x86_64                          rhel-8.3-rust
x86_64               randconfig-a001-20230116
x86_64               randconfig-a003-20230116
x86_64               randconfig-a002-20230116
x86_64               randconfig-a004-20230116
x86_64               randconfig-a005-20230116
x86_64               randconfig-a006-20230116
hexagon              randconfig-r041-20230116
i386                 randconfig-a002-20230116
hexagon              randconfig-r045-20230115
i386                 randconfig-a004-20230116
riscv                randconfig-r042-20230115
i386                 randconfig-a003-20230116
i386                 randconfig-a005-20230116
i386                 randconfig-a001-20230116
arm                  randconfig-r046-20230116
s390                 randconfig-r044-20230115
hexagon              randconfig-r045-20230116
i386                 randconfig-a006-20230116
hexagon              randconfig-r041-20230115
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
