Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4112663A90F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 14:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbiK1NMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 08:12:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231548AbiK1NMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 08:12:45 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D33140C3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 05:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669641163; x=1701177163;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=8MFUMnplA9ArJFEoVF7PaPaI1In7i7WSuPPlLjXPsyo=;
  b=QA9QwIeiEz81fMaQrOeNhAfWJbSOEa/ZewygIQfX9xmZo1G1n8dYe5X2
   t9S+H1mn65mPtVZQsHBfRhSOC7HAi7rCQ4HI06W/12jozRfL2hSCKTb61
   AGPJwwJkweRfZVauDqaqXDATvHEsteVS1pwd9Sy3heTAvyyarT3Z4AEtx
   g78vMp/HptoB+wTGVwZLndhUFJi/jKonKXW08gb74dT6yVa+sBcg5iVnk
   r5/5uSHcozDAPRy1CrMEHMAEBHfExAoslgxz6hZiXjxMzEo1hWfUwk2ic
   OvKH6qO/txhBGrbXFS7Nm3bOdowYLQu3hyMbl78Hmss4gIbebnC/aiPxM
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="302405527"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="302405527"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 05:12:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="817818510"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="817818510"
Received: from lkp-server01.sh.intel.com (HELO 64a2d449c951) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 28 Nov 2022 05:12:41 -0800
Received: from kbuild by 64a2d449c951 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ozdw8-00081r-3C;
        Mon, 28 Nov 2022 13:12:40 +0000
Date:   Mon, 28 Nov 2022 21:12:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/cache] BUILD SUCCESS
 97fa21f65c3eb5bbab9b4734bed37fd624cddd86
Message-ID: <6384b3a1.efhHTNklnfwx51fp%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cache
branch HEAD: 97fa21f65c3eb5bbab9b4734bed37fd624cddd86  x86/resctrl: Move MSR defines into msr-index.h

elapsed time: 886m

configs tested: 75
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
um                             i386_defconfig
arc                                 defconfig
um                           x86_64_defconfig
alpha                               defconfig
i386                                defconfig
arc                  randconfig-r043-20221127
x86_64                              defconfig
arc                  randconfig-r043-20221128
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
x86_64                               rhel-8.3
riscv                randconfig-r042-20221127
s390                 randconfig-r044-20221127
s390                                defconfig
s390                             allmodconfig
i386                             allyesconfig
alpha                            allyesconfig
ia64                             allmodconfig
m68k                             allmodconfig
s390                             allyesconfig
arc                              allyesconfig
x86_64                           allyesconfig
x86_64                        randconfig-a004
i386                 randconfig-a002-20221128
i386                          randconfig-a012
sh                               allmodconfig
powerpc                          allmodconfig
x86_64                        randconfig-a002
i386                 randconfig-a003-20221128
i386                          randconfig-a016
i386                 randconfig-a001-20221128
m68k                             allyesconfig
mips                             allyesconfig
i386                 randconfig-a005-20221128
x86_64                        randconfig-a006
i386                          randconfig-a014
powerpc                           allnoconfig
i386                 randconfig-a006-20221128
i386                 randconfig-a004-20221128
x86_64               randconfig-a002-20221128
x86_64               randconfig-a001-20221128
x86_64               randconfig-a003-20221128
x86_64               randconfig-a004-20221128
x86_64               randconfig-a005-20221128
x86_64               randconfig-a006-20221128
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig

clang tested configs:
hexagon              randconfig-r045-20221127
hexagon              randconfig-r041-20221128
riscv                randconfig-r042-20221128
s390                 randconfig-r044-20221128
hexagon              randconfig-r041-20221127
hexagon              randconfig-r045-20221128
x86_64               randconfig-a013-20221128
i386                          randconfig-a013
x86_64               randconfig-a012-20221128
x86_64               randconfig-a014-20221128
x86_64               randconfig-a011-20221128
i386                          randconfig-a011
x86_64               randconfig-a016-20221128
x86_64               randconfig-a015-20221128
x86_64                        randconfig-a005
i386                          randconfig-a015
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                 randconfig-a012-20221128
i386                 randconfig-a015-20221128
i386                 randconfig-a011-20221128
i386                 randconfig-a013-20221128
i386                 randconfig-a014-20221128
i386                 randconfig-a016-20221128

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
