Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59111612CF8
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 22:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbiJ3VWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 17:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ3VWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 17:22:47 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B166DA181
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 14:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667164965; x=1698700965;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=cXDGfxQdxYC3Gcjn+Tvw93B3HB8q2w/1ISgZO0jd8wk=;
  b=ZZTuDTAX9t74ThcgIcTeSptlv5GqdmTfDcWAoshd6P1L0n9eRD5eGIqT
   oZnrnED5S4Y/rv3D70Xtpaq/yfgM4tNmU2ZIoRJf5GvDibqt0H6YZQMi6
   M/6gfJ/6fC+Nhzw4N7YRDgjehW+zYkgJXjflwx5iQvCiNRnaWxOia7hlb
   sqyIVVU2l2hRvYxryJuoyT6vXpuEoEPxyH1QMJ++hvIn/kMYbaBe161VY
   UPqYnC93jKUoezItFIQ6TilK19P1sDWrxpYKXAbOgPQOCPIl6LGg99A4l
   bmDlIkkrfReXP9uzaYcczubYl8FhSmpaP783XGnnyZ2n1vqMphYdspKKT
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10516"; a="310472859"
X-IronPort-AV: E=Sophos;i="5.95,226,1661842800"; 
   d="scan'208";a="310472859"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2022 14:22:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10516"; a="584463310"
X-IronPort-AV: E=Sophos;i="5.95,226,1661842800"; 
   d="scan'208";a="584463310"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 30 Oct 2022 14:22:44 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1opFlT-000CP7-1O;
        Sun, 30 Oct 2022 21:22:43 +0000
Date:   Mon, 31 Oct 2022 05:22:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 b8cc3fc136191e47d864916609865a4fdbbbecf6
Message-ID: <635eeb15.za59cB8wrPmcwxQl%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: b8cc3fc136191e47d864916609865a4fdbbbecf6  Merge branch into tip/master: 'x86/sev'

elapsed time: 721m

configs tested: 65
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
i386                                defconfig
x86_64                              defconfig
arc                  randconfig-r043-20221030
um                           x86_64_defconfig
alpha                               defconfig
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
x86_64                        randconfig-a013
x86_64                           rhel-8.3-kvm
arm                                 defconfig
i386                          randconfig-a001
x86_64                        randconfig-a004
ia64                             allmodconfig
arc                                 defconfig
x86_64                           rhel-8.3-syz
x86_64                               rhel-8.3
arc                              allyesconfig
x86_64                          rhel-8.3-func
x86_64                           allyesconfig
i386                          randconfig-a014
s390                             allmodconfig
i386                          randconfig-a003
x86_64                        randconfig-a002
x86_64                        randconfig-a011
s390                             allyesconfig
alpha                            allyesconfig
i386                             allyesconfig
powerpc                           allnoconfig
m68k                             allyesconfig
i386                          randconfig-a012
i386                          randconfig-a016
s390                                defconfig
powerpc                          allmodconfig
i386                          randconfig-a005
m68k                             allmodconfig
sh                               allmodconfig
mips                             allyesconfig
x86_64                        randconfig-a015
arm                              allyesconfig
x86_64                        randconfig-a006
arm64                            allyesconfig
x86_64               randconfig-k001-20221031
i386                          randconfig-c001
arc                        nsimosci_defconfig
powerpc                  storcenter_defconfig
riscv             nommu_k210_sdcard_defconfig
mips                         rt305x_defconfig

clang tested configs:
hexagon              randconfig-r041-20221030
hexagon              randconfig-r045-20221030
s390                 randconfig-r044-20221030
riscv                randconfig-r042-20221030
i386                          randconfig-a013
i386                          randconfig-a015
i386                          randconfig-a011
x86_64                        randconfig-a016
i386                          randconfig-a002
x86_64                        randconfig-a012
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a001
x86_64                        randconfig-a014
x86_64                        randconfig-a003
x86_64                        randconfig-a005
powerpc                    socrates_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
