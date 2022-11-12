Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D786626785
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 07:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234795AbiKLGjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 01:39:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234773AbiKLGji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 01:39:38 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA881A83F
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 22:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668235177; x=1699771177;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=zvBNiVHpix9IH1a0+QttFAOvQ8BsI8GiHUZchYeuqeE=;
  b=KWT21EiZ2ZCSuX6+3bBk8+9JGhMRnCpx1SirAiZQbhpCiVD6d+DENvDw
   5jBOLxLVIVVQM6sgSGhztDEF+8ckuugV/olLYwinNufdMGB65adKqlm7i
   ZVnTfPow6JZq7wxp9/eMOERvNEUXYdTHJ9ZaJilJFY0C+SzLizdTOuawN
   uBDBfpYLuY+kCYKyKU3yhxGI2lWcr1X2/mfXUG3e4Nkj9FGYn5NPEY7U+
   cikQrRvbzo4GPb08ounHFPV2kl8194qZOx85XFH5P3BiPEBx3+GGZO6uo
   9FXjq30rkh4amkghuD5pKkunXpeMXIjfoQUc3xAaHtE5fYvxZUVd7ROZl
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="398001377"
X-IronPort-AV: E=Sophos;i="5.96,158,1665471600"; 
   d="scan'208";a="398001377"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 22:39:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="615680412"
X-IronPort-AV: E=Sophos;i="5.96,158,1665471600"; 
   d="scan'208";a="615680412"
Received: from lkp-server01.sh.intel.com (HELO e783503266e8) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 11 Nov 2022 22:39:35 -0800
Received: from kbuild by e783503266e8 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1otkAx-0004em-0s;
        Sat, 12 Nov 2022 06:39:35 +0000
Date:   Sat, 12 Nov 2022 14:39:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 151297128990b4b44be8d70b983053831fa857f6
Message-ID: <636f3f91.Bu8zu1dzVyLNXAQF%lkp@intel.com>
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
branch HEAD: 151297128990b4b44be8d70b983053831fa857f6  Merge x86/cpu into tip/master

elapsed time: 728m

configs tested: 58
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
powerpc                           allnoconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
alpha                               defconfig
sh                               allmodconfig
arc                  randconfig-r043-20221111
i386                          randconfig-a001
i386                          randconfig-a005
i386                          randconfig-a003
mips                             allyesconfig
riscv                randconfig-r042-20221111
powerpc                          allmodconfig
s390                 randconfig-r044-20221111
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
s390                                defconfig
s390                             allmodconfig
arm                                 defconfig
i386                                defconfig
s390                             allyesconfig
ia64                             allmodconfig
x86_64                               rhel-8.3
m68k                             allmodconfig
x86_64                        randconfig-a013
x86_64                              defconfig
arm64                            allyesconfig
arc                              allyesconfig
x86_64                        randconfig-a011
arm                              allyesconfig
i386                             allyesconfig
alpha                            allyesconfig
m68k                             allyesconfig
x86_64                        randconfig-a015
x86_64                           allyesconfig
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
x86_64                        randconfig-a002
x86_64                        randconfig-a004
x86_64                        randconfig-a006

clang tested configs:
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
hexagon              randconfig-r041-20221111
hexagon              randconfig-r045-20221111
x86_64                        randconfig-a012
x86_64                        randconfig-a016
x86_64                        randconfig-a014
i386                          randconfig-a013
i386                          randconfig-a011
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a015

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
