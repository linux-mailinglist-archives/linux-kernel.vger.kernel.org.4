Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60CB961E66F
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 22:22:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbiKFVWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 16:22:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbiKFVWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 16:22:06 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D643311830
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 13:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667769725; x=1699305725;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=g/xUxw/GZuOUyXKrCXcEPXm3LLi1BdolxomJLDMcHyM=;
  b=R91Lgkhv5MFxTl41SjIXrdtudKaUjvVdHinL6VAU1TvmfV+eoSH3lnAH
   YdL4BdlZ5MqGrye6Nu1Wm6ShtS+tHj4/0CjjKbXZjLR8aRNNrWGWgo70v
   6B/WsHroYoiQEK4NTShGJQUKjBY3wV8aL3M/XkZ71MTz0EtCywjSC3uTh
   yIJXGCv/gvcbZqPcLDDsv8fMdIU4R32FshZOBzx62uTT+3gfX5e6MITD/
   Cb4I+D282ivN4+WrFWv150E8mxodkR0qpKq7w0GhU/hN1SDkmEEQT12Fz
   s+Taof6eSH/ESfgxWkKUT7PHVzvdGa68uqS0R7+KHi2bF2oqNetz5x0jM
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10523"; a="374534056"
X-IronPort-AV: E=Sophos;i="5.96,142,1665471600"; 
   d="scan'208";a="374534056"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2022 13:22:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10523"; a="778269083"
X-IronPort-AV: E=Sophos;i="5.96,142,1665471600"; 
   d="scan'208";a="778269083"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 06 Nov 2022 13:22:04 -0800
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1orn5f-000J3N-1U;
        Sun, 06 Nov 2022 21:22:03 +0000
Date:   Mon, 07 Nov 2022 05:20:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 01d2077d0e550dc47418d27870786bf0aed5c92c
Message-ID: <63682530.+z/rZ2jOAuRJois+%lkp@intel.com>
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
branch HEAD: 01d2077d0e550dc47418d27870786bf0aed5c92c  Merge branch into tip/master: 'x86/core'

elapsed time: 732m

configs tested: 58
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
arc                  randconfig-r043-20221106
um                           x86_64_defconfig
arc                                 defconfig
i386                                defconfig
s390                 randconfig-r044-20221106
riscv                randconfig-r042-20221106
arm                                 defconfig
x86_64                              defconfig
x86_64                        randconfig-a004
alpha                               defconfig
arc                              allyesconfig
x86_64                        randconfig-a002
alpha                            allyesconfig
x86_64                           rhel-8.3-syz
m68k                             allmodconfig
x86_64                        randconfig-a006
arm                              allyesconfig
s390                                defconfig
m68k                             allyesconfig
x86_64                         rhel-8.3-kunit
s390                             allmodconfig
arm64                            allyesconfig
i386                          randconfig-a001
x86_64                               rhel-8.3
x86_64                           rhel-8.3-kvm
i386                          randconfig-a003
x86_64                          rhel-8.3-func
x86_64                           allyesconfig
i386                          randconfig-a014
x86_64                    rhel-8.3-kselftests
s390                             allyesconfig
x86_64                        randconfig-a013
ia64                             allmodconfig
i386                          randconfig-a012
x86_64                        randconfig-a011
i386                          randconfig-a016
i386                             allyesconfig
x86_64                        randconfig-a015
i386                          randconfig-a005
powerpc                           allnoconfig
powerpc                          allmodconfig
mips                             allyesconfig
sh                               allmodconfig

clang tested configs:
hexagon              randconfig-r041-20221106
hexagon              randconfig-r045-20221106
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a014
x86_64                        randconfig-a003
i386                          randconfig-a013
i386                          randconfig-a015
i386                          randconfig-a011
i386                          randconfig-a002
x86_64                        randconfig-a016
x86_64                        randconfig-a012
i386                          randconfig-a004
i386                          randconfig-a006

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
