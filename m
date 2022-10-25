Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8149060C7F6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 11:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbiJYJYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 05:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231661AbiJYJY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 05:24:27 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9EAC5F71
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 02:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666689606; x=1698225606;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=8esFY8sWq9ifWIhvNrnZbcj9d1d6Vm24QaKe38gg3gM=;
  b=L715n7yPrKhWF+DyEff7wBd+b3H59PlkR98PPekiyWiBRWQmP4IrzmpU
   JII7rvdN3QjQfEHbTw6uALAgCanME17/x19VFv2EAze2Xv6kteahD/reB
   BuF9d9s6EqrHQuve+8Ny1AuSunonRekliKPskHZRVJL3OsYGa7o3tkzbK
   pWPqGwwZ8HxtPiw7rvUFeEDopExmU9Q5Cx31nVyN3r0oMMUAOp90jS17u
   aPPl7LdD472TgwNgiOETvyMno6jI9HlPdNxvtQyD9s3ojmoe7K7kYI7kD
   2y7jGP/UVOaVQyrQYUqtuyJE6AR99YcjCSNm6H/JxerlytKHxuMbgvvhH
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="306360409"
X-IronPort-AV: E=Sophos;i="5.95,211,1661842800"; 
   d="scan'208";a="306360409"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2022 02:20:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="960746364"
X-IronPort-AV: E=Sophos;i="5.95,211,1661842800"; 
   d="scan'208";a="960746364"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 25 Oct 2022 02:20:05 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1onG6P-00067c-0L;
        Tue, 25 Oct 2022 09:20:05 +0000
Date:   Tue, 25 Oct 2022 17:19:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:rcu/next] BUILD SUCCESS
 2b0718d00af148c3cc4a392442d47785c0d7f2cc
Message-ID: <6357aa1d.SZJ6CarpvCuBSiNn%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: 2b0718d00af148c3cc4a392442d47785c0d7f2cc  selftests/nolibc: Add 7 tests for memcmp()

elapsed time: 723m

configs tested: 63
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
s390                             allyesconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                              defconfig
ia64                             allmodconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
m68k                             allmodconfig
i386                 randconfig-a011-20221024
arc                              allyesconfig
x86_64                               rhel-8.3
x86_64                           rhel-8.3-kvm
alpha                            allyesconfig
i386                 randconfig-a014-20221024
sh                               allmodconfig
x86_64                           allyesconfig
arc                  randconfig-r043-20221024
i386                 randconfig-a013-20221024
i386                 randconfig-a012-20221024
riscv                randconfig-r042-20221024
i386                 randconfig-a016-20221024
i386                 randconfig-a015-20221024
m68k                             allyesconfig
arm                                 defconfig
arc                  randconfig-r043-20221023
s390                 randconfig-r044-20221024
x86_64                        randconfig-a015
x86_64                        randconfig-a013
arm64                            allyesconfig
x86_64                        randconfig-a011
arm                              allyesconfig
i386                             allyesconfig
i386                                defconfig

clang tested configs:
hexagon              randconfig-r045-20221023
hexagon              randconfig-r041-20221024
riscv                randconfig-r042-20221023
i386                 randconfig-a001-20221024
hexagon              randconfig-r045-20221024
i386                 randconfig-a002-20221024
s390                 randconfig-r044-20221023
i386                 randconfig-a005-20221024
x86_64               randconfig-a001-20221024
i386                 randconfig-a003-20221024
x86_64               randconfig-a005-20221024
i386                 randconfig-a004-20221024
x86_64               randconfig-a003-20221024
x86_64               randconfig-a006-20221024
hexagon              randconfig-r041-20221023
i386                 randconfig-a006-20221024
x86_64               randconfig-a004-20221024
x86_64               randconfig-a002-20221024
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-a012

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
