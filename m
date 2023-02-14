Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78A4E695AAF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 08:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbjBNHcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 02:32:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbjBNHcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 02:32:03 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E8A91C32D
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 23:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676359922; x=1707895922;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=txaZVWMXoiDpHf2Z8UBy4a7oKk104pNhtd5ynKn/S84=;
  b=U7pFO54RmWaEZrXGLdv2O2ySYzD3brhKwJg+B0MPj1KhktXfWY1wbFiX
   veAuK4roLbRhMVywUyNE3VgKrt9uTiS8vdOkJGPBBgIrei1Q4OobtlKT8
   niQi9QVuNbR2OETXoOV+xh5cBngU3hcSd0YCMrXKZUweDfbKyAf7kmVtS
   +7sPi9W+rJs+5djf5wKoy8/S1f10MPJEaQqV+luhZsyfokp08/PZ2Bk9s
   DiXd2a+XWSQYGlSB9+LKSa8fjqF7lZ1ECMqNuff0lzqBSG4HLFkxWabvf
   WFmaQLDVMOP/3XwTZX2xH/H0n1BpcLUvV2Jx/TdRsI4WnLofjIP5C+qDs
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="314743247"
X-IronPort-AV: E=Sophos;i="5.97,296,1669104000"; 
   d="scan'208";a="314743247"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 23:32:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="701569379"
X-IronPort-AV: E=Sophos;i="5.97,296,1669104000"; 
   d="scan'208";a="701569379"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 13 Feb 2023 23:31:59 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pRpnD-0008It-01;
        Tue, 14 Feb 2023 07:31:59 +0000
Date:   Tue, 14 Feb 2023 15:31:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:timers/core] BUILD SUCCESS
 ab407a1919d2676ddc5761ed459d4cc5c7be18ed
Message-ID: <63eb38b8.xlQyZjjHEAOmWBha%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,LONGWORDS,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core
branch HEAD: ab407a1919d2676ddc5761ed459d4cc5c7be18ed  Merge tag 'clocksource.2023.02.06b' of git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu into timers/core

elapsed time: 763m

configs tested: 42
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
alpha                            allyesconfig
alpha                               defconfig
arc                              allyesconfig
arc                                 defconfig
arm                              allmodconfig
arm                              allyesconfig
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
csky                                defconfig
i386                             allyesconfig
i386                              debian-10.3
i386                                defconfig
ia64                             allmodconfig
ia64                                defconfig
loongarch                        allmodconfig
loongarch                         allnoconfig
loongarch                           defconfig
m68k                             allmodconfig
m68k                                defconfig
mips                             allmodconfig
mips                             allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
riscv                            allmodconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
s390                             allmodconfig
s390                             allyesconfig
s390                                defconfig
sh                               allmodconfig
sparc                               defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                                  kexec
x86_64                               rhel-8.3

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
