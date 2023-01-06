Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF8D65F825
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 01:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235915AbjAFAcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 19:32:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235518AbjAFAcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 19:32:02 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD81E4F12E
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 16:32:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672965121; x=1704501121;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=TTYKcngzKNS+sKXqSXjoM5hEd7+3G1xoYYBm41cQAi0=;
  b=NSAej1eLtcdm6o8FjJ3OrXZEVw0va4GJnensqRX9Yv9eycJyVxtMvHrY
   SLZSR+pQqDpI+olC17xolNZPswNb2/NIW0EXzWVDmWNwms2o/8RhCmXQ9
   B3b+CogTZxK6KSY80mrMi2/1cPbaX0Vdr2SPZ+Me5qIpvltY2V/zqHYaK
   zaXZgULIhGOazd1ZFltLHh3mif2X0RcsC/RIapwY/bcELbDm568sv6vkS
   DjwC2NYwrw4tLLhUiuZ2HO2S8eCXHoiq3HaDTsoFouUC0/ETJW06AThye
   wCQ4sqTxo6sN534K+4T6KQEv4bAVrDVZYrRVt3OuoQVTFd/ZbLT6CtPd3
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="324380052"
X-IronPort-AV: E=Sophos;i="5.96,303,1665471600"; 
   d="scan'208";a="324380052"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 16:32:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="829730962"
X-IronPort-AV: E=Sophos;i="5.96,303,1665471600"; 
   d="scan'208";a="829730962"
Received: from lkp-server02.sh.intel.com (HELO f1920e93ebb5) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 05 Jan 2023 16:31:59 -0800
Received: from kbuild by f1920e93ebb5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pDaeN-0002kp-0W;
        Fri, 06 Jan 2023 00:31:59 +0000
Date:   Fri, 06 Jan 2023 08:31:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 5bd63bb2060dbf9927ff6d0792160a540be5d0ab
Message-ID: <63b76bf3.fTl/2CyYCpqsHPkl%lkp@intel.com>
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
branch HEAD: 5bd63bb2060dbf9927ff6d0792160a540be5d0ab  Merge branch into tip/master: 'x86/alternatives'

elapsed time: 723m

configs tested: 62
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
powerpc                           allnoconfig
sh                               allmodconfig
arc                                 defconfig
mips                             allyesconfig
powerpc                          allmodconfig
alpha                               defconfig
um                             i386_defconfig
um                           x86_64_defconfig
s390                             allmodconfig
s390                                defconfig
x86_64                           rhel-8.3-bpf
x86_64                        randconfig-a013
x86_64                           rhel-8.3-kvm
x86_64                        randconfig-a011
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
s390                             allyesconfig
x86_64                        randconfig-a015
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
x86_64                              defconfig
i386                                defconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
x86_64                               rhel-8.3
arc                  randconfig-r043-20230105
i386                          randconfig-a001
x86_64                          rhel-8.3-func
s390                 randconfig-r044-20230105
i386                          randconfig-a003
x86_64                    rhel-8.3-kselftests
x86_64                           allyesconfig
i386                          randconfig-a014
i386                          randconfig-a005
i386                          randconfig-a012
i386                          randconfig-a016
riscv                randconfig-r042-20230105
i386                             allyesconfig
ia64                             allmodconfig
arm                                 defconfig
arm                              allyesconfig
arm64                            allyesconfig

clang tested configs:
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                          rhel-8.3-rust
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
arm                  randconfig-r046-20230105
hexagon              randconfig-r045-20230105
hexagon              randconfig-r041-20230105
i386                          randconfig-a002
i386                          randconfig-a013
i386                          randconfig-a004
i386                          randconfig-a011
i386                          randconfig-a015
i386                          randconfig-a006

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
