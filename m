Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B302B65F7B0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 00:38:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236068AbjAEXiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 18:38:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236012AbjAEXiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 18:38:02 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1012F792
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 15:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672961880; x=1704497880;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=3fzGv7zR9oJlSU/cZh3sD5w4OpikDxA/qRcWVmO5dNw=;
  b=FKdVQI3U4N2thr0eK83FWhWNpG+sTdcahWYJ3Ylo9LemZRyHTxRMAG91
   TwL3gs/eK64QXmKH4kdkl54SiQKsr4VQOp0lAKf6qVXjdqbO3yY2APVJY
   WDZUgoWDI1rUhd39/hz7up4bfYTJ0HClXBiMqaixNu534kpIIWVbEqQL0
   HXUdo+nH7T68tDpyg+CzA1CN3/0Lfi6/VCP+GllSvytwJoQp7LsdaWaYE
   LsboRl0UD4wbYiwkxv7S1RXgPU2oMvLpUmxw6SIaDLBvfhXbmwoStXliV
   G7MD2QgubEyFks4Ygshd1NccQydkftcgMobHm0yTV694rD6gShUj4PcEz
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="349566925"
X-IronPort-AV: E=Sophos;i="5.96,303,1665471600"; 
   d="scan'208";a="349566925"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 15:37:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="901106047"
X-IronPort-AV: E=Sophos;i="5.96,303,1665471600"; 
   d="scan'208";a="901106047"
Received: from lkp-server02.sh.intel.com (HELO f1920e93ebb5) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 05 Jan 2023 15:37:58 -0800
Received: from kbuild by f1920e93ebb5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pDZo5-0002hr-1W;
        Thu, 05 Jan 2023 23:37:57 +0000
Date:   Fri, 06 Jan 2023 07:37:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:sched/core] BUILD SUCCESS
 acbee592f1a0913e908b141570034b3fb2991db9
Message-ID: <63b75f1e.wHwMCLmQ9C2XvbhE%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
branch HEAD: acbee592f1a0913e908b141570034b3fb2991db9  sched/documentation: Document the util clamp feature

elapsed time: 727m

configs tested: 63
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
um                             i386_defconfig
um                           x86_64_defconfig
i386                                defconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
x86_64                           rhel-8.3-bpf
arc                  randconfig-r043-20230105
m68k                             allyesconfig
s390                 randconfig-r044-20230105
x86_64                           rhel-8.3-syz
m68k                             allmodconfig
x86_64                         rhel-8.3-kunit
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
s390                                defconfig
x86_64                           rhel-8.3-kvm
arc                              allyesconfig
x86_64                              defconfig
alpha                            allyesconfig
riscv                randconfig-r042-20230105
ia64                             allmodconfig
i386                          randconfig-a014
i386                          randconfig-a001
i386                          randconfig-a012
i386                          randconfig-a003
arm                                 defconfig
s390                             allyesconfig
i386                          randconfig-a016
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                               rhel-8.3
i386                             allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                           allyesconfig
mips                             allyesconfig
x86_64                        randconfig-a015
i386                          randconfig-a005
x86_64                        randconfig-a006
arm64                            allyesconfig
sh                               allmodconfig
arm                              allyesconfig

clang tested configs:
x86_64                          rhel-8.3-rust
arm                  randconfig-r046-20230105
hexagon              randconfig-r041-20230105
hexagon              randconfig-r045-20230105
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
i386                          randconfig-a002
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a001
i386                          randconfig-a006
x86_64                        randconfig-a003
x86_64                        randconfig-a016
i386                          randconfig-a004
x86_64                        randconfig-a005
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
