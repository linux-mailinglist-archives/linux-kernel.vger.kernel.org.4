Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECAE4674680
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 23:59:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbjASW7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 17:59:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbjASW6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 17:58:33 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD37D8BAA3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 14:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674168213; x=1705704213;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=k8T5j4/D07RKjhjXqfCtk8K1XandVeRAAUuZzqFSGG4=;
  b=HTQfD5unqJvRwDUPhsi3uArcqAcOYYf4SU5R7INr53Y2Nqm5v+mAek0C
   GV4qVzm622z9rpR80hTdw8MajkrU6GG7dIhutvT3aGS+dBDhCn/5L4RVp
   L192SyBMowd80VbYMvUNI6+XmZn+d+eaucJBT67P6ladyxCIx9fLqDSql
   2pKd14jKXTkEmuayrRXERYJP6SVAyT1nZEib2szsVr3G35zOjBv8CDvR8
   fGtn2yH1weWUrlOL5fLrlINKaaJqlw8EBmWFYK9ylN6CFdqX7VrkRFV8Q
   o8gnBmNVGc0thWiRcieoMi6f0mKURzhM1NmoKEGIshc6mEvJsXc6B/2n8
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="389967338"
X-IronPort-AV: E=Sophos;i="5.97,230,1669104000"; 
   d="scan'208";a="389967338"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 14:43:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="768413033"
X-IronPort-AV: E=Sophos;i="5.97,230,1669104000"; 
   d="scan'208";a="768413033"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 19 Jan 2023 14:43:27 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pIdd0-0001vW-0w;
        Thu, 19 Jan 2023 22:43:26 +0000
Date:   Fri, 20 Jan 2023 06:43:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 195df42eb64dcb82172248002e78456f67310b8e
Message-ID: <63c9c77f.0H9pTPJcMdcdQq5O%lkp@intel.com>
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
branch HEAD: 195df42eb64dcb82172248002e78456f67310b8e  Merge branch into tip/master: 'x86/platform'

elapsed time: 726m

configs tested: 62
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
i386                                defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
arc                                 defconfig
x86_64                    rhel-8.3-kselftests
s390                             allmodconfig
x86_64                          rhel-8.3-func
alpha                               defconfig
x86_64                        randconfig-a013
s390                                defconfig
i386                          randconfig-a001
um                             i386_defconfig
i386                          randconfig-a003
um                           x86_64_defconfig
x86_64                        randconfig-a011
x86_64                           allyesconfig
i386                          randconfig-a005
x86_64                        randconfig-a004
s390                             allyesconfig
x86_64                        randconfig-a002
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64                        randconfig-a015
x86_64                        randconfig-a006
mips                             allyesconfig
x86_64                           rhel-8.3-syz
sh                               allmodconfig
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-bpf
arm                  randconfig-r046-20230119
arc                  randconfig-r043-20230119
m68k                             allyesconfig
ia64                             allmodconfig
m68k                             allmodconfig
arm                                 defconfig
arc                              allyesconfig
alpha                            allyesconfig
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
i386                             allyesconfig
arm64                            allyesconfig
arm                              allyesconfig

clang tested configs:
x86_64                          rhel-8.3-rust
i386                          randconfig-a002
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a001
i386                          randconfig-a006
x86_64                        randconfig-a003
x86_64                        randconfig-a016
x86_64                        randconfig-a005
hexagon              randconfig-r045-20230119
hexagon              randconfig-r041-20230119
riscv                randconfig-r042-20230119
i386                          randconfig-a013
s390                 randconfig-r044-20230119
i386                          randconfig-a011
i386                          randconfig-a015

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
