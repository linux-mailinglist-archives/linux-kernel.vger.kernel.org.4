Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB910624D2F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 22:41:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbiKJVlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 16:41:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiKJVlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 16:41:42 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 206D611179
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 13:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668116502; x=1699652502;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=fJt00yicae8Wy5TzG+X0hOGm+03xv3Ca5AAmUnF3ew0=;
  b=AMhlwOhqwzzDVVcmzx7YNwFBsTEqAucE3T+IA70yYoIWrKTTHP24Owuc
   KIAGGCzVhA8McmwzRFrTx5xCpnjeSGKLuEj9UId7sqmpIagcuA8/JPhnB
   1n1Sd33c1zEaYaZJPnEMTG/663yx1iVCveCB/ZfRb8fhuZRV+Wu0HQSDU
   DzhpwsHMWq5okrT7TGFU+xk6nhaTGeAf/wmaMJ8hxzhbwtBGjWFZKyjVI
   NkqHk8wBOBbpnFazIQJfKpDdvGdkoT4oD1wj0Pl5JbWEJ9RtuCXifBY1E
   5sx7utu3kfr4gdnDZEs5i2H5p1scHyILRgEF+BAtg5A32XvtK3J2IQ5n6
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="312589268"
X-IronPort-AV: E=Sophos;i="5.96,154,1665471600"; 
   d="scan'208";a="312589268"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 13:41:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="812210548"
X-IronPort-AV: E=Sophos;i="5.96,154,1665471600"; 
   d="scan'208";a="812210548"
Received: from lkp-server01.sh.intel.com (HELO e783503266e8) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 10 Nov 2022 13:41:40 -0800
Received: from kbuild by e783503266e8 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1otFIp-0003Gv-34;
        Thu, 10 Nov 2022 21:41:39 +0000
Date:   Fri, 11 Nov 2022 05:41:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:perf/urgent] BUILD SUCCESS
 bdfe34597139cfcecd47a2eb97fea44d77157491
Message-ID: <636d700b.8TQ7n/rFYxw4iabP%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git perf/urgent
branch HEAD: bdfe34597139cfcecd47a2eb97fea44d77157491  perf/x86/amd/uncore: Fix memory leak for events array

elapsed time: 2003m

configs tested: 96
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
arc                                 defconfig
powerpc                           allnoconfig
arm                                 defconfig
x86_64                            allnoconfig
x86_64                              defconfig
s390                       zfcpdump_defconfig
powerpc                      arches_defconfig
powerpc                     sequoia_defconfig
mips                         cobalt_defconfig
arm                      footbridge_defconfig
xtensa                  cadence_csp_defconfig
mips                         db1xxx_defconfig
arm                        spear6xx_defconfig
powerpc                      pasemi_defconfig
i386                             allyesconfig
i386                                defconfig
ia64                             allmodconfig
sh                           se7722_defconfig
arm                         cm_x300_defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
powerpc              randconfig-c003-20221110
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
s390                                defconfig
s390                             allmodconfig
s390                             allyesconfig
alpha                               defconfig
sh                   secureedge5410_defconfig
powerpc                 mpc837x_rdb_defconfig
xtensa                    xip_kc705_defconfig
xtensa                          iss_defconfig
powerpc                 mpc834x_mds_defconfig
arm                         lpc18xx_defconfig
nios2                         10m50_defconfig
sh                      rts7751r2d1_defconfig
sh                           se7724_defconfig
microblaze                          defconfig
parisc                           alldefconfig
arm                          pxa910_defconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arm64                               defconfig
powerpc                 linkstation_defconfig
parisc                generic-64bit_defconfig
loongarch                           defconfig
arm64                            allyesconfig
arm                              allyesconfig
arm                             rpc_defconfig
m68k                          multi_defconfig
arc                         haps_hs_defconfig
powerpc                    amigaone_defconfig
arc                        nsimosci_defconfig
powerpc                       ppc64_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
i386                          randconfig-c001
xtensa                           alldefconfig
parisc                generic-32bit_defconfig

clang tested configs:
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a004
s390                 randconfig-r044-20221110
riscv                randconfig-r042-20221110
hexagon              randconfig-r041-20221110
hexagon              randconfig-r045-20221110
x86_64                        randconfig-a003
i386                          randconfig-a002
i386                          randconfig-a006
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a012
powerpc                        fsp2_defconfig
powerpc                    gamecube_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
