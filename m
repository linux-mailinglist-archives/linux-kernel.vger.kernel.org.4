Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 663616142D2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 02:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbiKABmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 21:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbiKABmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 21:42:18 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7D713E1C
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 18:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667266937; x=1698802937;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=bpY/Eg5VHmTAVN6DxotNbyg9dvhEc2FmsPGe3qkMQ00=;
  b=BxYTGn9PMif2+jBdWVDH5OavjSuNWwsATtNhyaiy23CK5df73JesPACC
   7ZTA1n9+1a17cx9cBQWxw/srhmovAovFgcWy0bBwrUMhaLWNZmC4uRi57
   RLoAE+7z9frxPz3K1Fk/qah3k0W+h0Xjs1qXUWVAtrprG7lK+UMuLoYXk
   fxcFqjtmpBW/qaYFKNd2dZ3P4a1aQZU5xuLwS9Pm1SWbGul/7iitRBc8K
   gPgUC9boXeNiqRRgTlxyi4yhFBOXMN3sylwYqh8jRg0EeFu3+j8iiSQHv
   QQfgRX3HLKqO1ahoe3Gb83zuWnKuNUuVQUtuW9tGo/dBG0uR0W6tEnv0Y
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="309041809"
X-IronPort-AV: E=Sophos;i="5.95,229,1661842800"; 
   d="scan'208";a="309041809"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2022 18:42:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="723011214"
X-IronPort-AV: E=Sophos;i="5.95,229,1661842800"; 
   d="scan'208";a="723011214"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 31 Oct 2022 18:42:16 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1opgIB-000DB6-1L;
        Tue, 01 Nov 2022 01:42:15 +0000
Date:   Tue, 01 Nov 2022 09:42:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:sched/core] BUILD SUCCESS
 52b33d87b9197c51e8ffdc61873739d90dd0a16f
Message-ID: <63607970.+OCuCRa8wfViJm1P%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
branch HEAD: 52b33d87b9197c51e8ffdc61873739d90dd0a16f  sched/psi: Use task->psi_flags to clear in CPU migration

elapsed time: 889m

configs tested: 63
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
powerpc                           allnoconfig
x86_64                               rhel-8.3
x86_64                           rhel-8.3-syz
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
x86_64                           allyesconfig
i386                                defconfig
s390                                defconfig
ia64                             allmodconfig
i386                 randconfig-a011-20221031
s390                             allyesconfig
sh                               allmodconfig
mips                             allyesconfig
arm                                 defconfig
arc                              allyesconfig
i386                 randconfig-a012-20221031
i386                          randconfig-a001
arc                  randconfig-r043-20221031
alpha                            allyesconfig
powerpc                          allmodconfig
i386                 randconfig-a013-20221031
x86_64                           rhel-8.3-kvm
i386                          randconfig-a003
i386                 randconfig-a015-20221031
riscv                randconfig-r042-20221031
x86_64                         rhel-8.3-kunit
i386                          randconfig-a005
i386                 randconfig-a014-20221031
x86_64               randconfig-a014-20221031
arc                  randconfig-r043-20221030
m68k                             allyesconfig
i386                 randconfig-a016-20221031
x86_64               randconfig-a012-20221031
arm                              allyesconfig
m68k                             allmodconfig
i386                             allyesconfig
x86_64               randconfig-a015-20221031
arm64                            allyesconfig
x86_64               randconfig-a011-20221031
x86_64               randconfig-a013-20221031
x86_64               randconfig-a016-20221031
s390                 randconfig-r044-20221031

clang tested configs:
hexagon              randconfig-r045-20221031
hexagon              randconfig-r041-20221030
riscv                randconfig-r042-20221030
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
s390                 randconfig-r044-20221030
hexagon              randconfig-r041-20221031
hexagon              randconfig-r045-20221030
x86_64               randconfig-a002-20221031
x86_64               randconfig-a004-20221031
x86_64               randconfig-a003-20221031
x86_64               randconfig-a001-20221031
x86_64               randconfig-a006-20221031
x86_64               randconfig-a005-20221031

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
