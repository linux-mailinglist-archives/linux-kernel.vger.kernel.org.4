Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86440606F3E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 07:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbiJUFLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 01:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbiJUFKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 01:10:37 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC871D18CF
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 22:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666329027; x=1697865027;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Yvg5nPnQ4ohpgNJNRMPAR2mdTnp8YR9PHtkzzMrJYeQ=;
  b=iI1KKi4UbZLTrc7QtDZT2D7QkvBzRNWdm8p8rrc3X1qpivgqCJL3IEbs
   e7Qi03mLNPyETXH7qaQ6lzvkN8YlVi5dlJRbdWR2Ep5uMvDeJQd4R9Ctf
   IBy7UL1burS0ed6AjUoNhxgKS6wVDVOq27b5jtFavKdMYaWEdZ+62Q72j
   CCIEDdMaDhwIBTtv9VxEi0b8vFFo164t06n+WGGctwswGVjvha+M7+CWo
   ASKQBL/8oNzGC6pdpdv9csAlq8pM7yFk7HUL5ib06L7pHLFgeBd6otEbg
   2+30f40fueJSUxALxkN/bsFwa0Z+reM0x27L8faAwZzuDSgNDPioGHpj9
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="304526641"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="304526641"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 22:10:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="805350204"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="805350204"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 20 Oct 2022 22:10:25 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1olkIa-0002BY-34;
        Fri, 21 Oct 2022 05:10:24 +0000
Date:   Fri, 21 Oct 2022 13:09:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 b329f5ddc9ce4b622d9c7aaf5c6df4de52caf91a
Message-ID: <63522986.cTu9H29Jhje4lGXL%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: b329f5ddc9ce4b622d9c7aaf5c6df4de52caf91a  perf/x86/intel/lbr: Use setup_clear_cpu_cap() instead of clear_cpu_cap()

elapsed time: 821m

configs tested: 72
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
alpha                               defconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
s390                                defconfig
s390                             allmodconfig
x86_64                              defconfig
i386                                defconfig
x86_64                           allyesconfig
powerpc                           allnoconfig
x86_64                               rhel-8.3
mips                             allyesconfig
arc                  randconfig-r043-20221018
x86_64                        randconfig-a004
s390                             allyesconfig
i386                          randconfig-a001
powerpc                          allmodconfig
riscv                randconfig-r042-20221018
x86_64                        randconfig-a002
x86_64                        randconfig-a013
x86_64                           rhel-8.3-syz
sh                               allmodconfig
x86_64                        randconfig-a011
s390                 randconfig-r044-20221018
x86_64                        randconfig-a006
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a015
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
i386                             allyesconfig
arm                                 defconfig
x86_64                           rhel-8.3-kvm
x86_64                         rhel-8.3-kunit
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
arm64                            allyesconfig
arm                              allyesconfig
arm                        oxnas_v6_defconfig
i386                          randconfig-c001
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func

clang tested configs:
x86_64                        randconfig-a005
x86_64                        randconfig-a001
hexagon              randconfig-r045-20221018
x86_64                        randconfig-a003
hexagon              randconfig-r041-20221018
x86_64                        randconfig-a016
i386                          randconfig-a002
x86_64                        randconfig-a012
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a014
i386                          randconfig-a013
i386                          randconfig-a015
i386                          randconfig-a011
s390                 randconfig-r044-20221019
hexagon              randconfig-r045-20221019
riscv                randconfig-r042-20221019
hexagon              randconfig-r041-20221019
x86_64                        randconfig-k001
mips                       lemote2f_defconfig
powerpc                    socrates_defconfig
arm                         orion5x_defconfig
arm                        magician_defconfig
powerpc                    gamecube_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
