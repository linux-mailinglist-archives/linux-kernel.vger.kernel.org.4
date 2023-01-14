Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2BEA66A77E
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 01:29:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjANA32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 19:29:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjANA3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 19:29:25 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC3CA10F9
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 16:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673656164; x=1705192164;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=t3GwNhC7motvp+RSlnAdQh8JcZfScPJWmG1CM6duiQ0=;
  b=MygKYgB/MycqA7KSugXNpchChw6FPrAG0xjoeaPLt7T5M9iPAThHT0VK
   umk7phQsRFjaoCOYRw4SBKfbrJ02Vb3a6jrcw/Tsqv+XDcSBFSFDsnIXi
   w/nOi5jpFYGMgfMCbfMlAbIiP5hJXV6cKQErnBci4yMxWkIMNgvUIM0+y
   NIRK5SMxg9OlsHuuMf/mLvrOdjV81p7b7ed8trILJRDzM7lnwsUpKLzi0
   FQ6IL3lkqe9pEa5t9wvMINAgSiN1ZMhIS6tK3vAuqIslQNIcfbJKM166H
   8XwGdXqDt7b/Qrsk0QqJ7ynx7Y6ruxUL3HmnaeoRRWf32vSWiPN2mpiTH
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="351372452"
X-IronPort-AV: E=Sophos;i="5.97,215,1669104000"; 
   d="scan'208";a="351372452"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 16:29:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="782329186"
X-IronPort-AV: E=Sophos;i="5.97,215,1669104000"; 
   d="scan'208";a="782329186"
Received: from lkp-server02.sh.intel.com (HELO f1920e93ebb5) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 13 Jan 2023 16:29:21 -0800
Received: from kbuild by f1920e93ebb5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pGUQC-000BYq-2w;
        Sat, 14 Jan 2023 00:29:20 +0000
Date:   Sat, 14 Jan 2023 08:28:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:sched/urgent] BUILD SUCCESS
 da07d2f9c153e457e845d4dcfdd13568d71d18a4
Message-ID: <63c1f73a.2AJ5ii9IYFQcE1P9%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/urgent
branch HEAD: da07d2f9c153e457e845d4dcfdd13568d71d18a4  sched/fair: Fixes for capacity inversion detection

elapsed time: 726m

configs tested: 63
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                        randconfig-a013
ia64                             allmodconfig
x86_64                        randconfig-a011
x86_64                        randconfig-a015
x86_64                           allyesconfig
powerpc                           allnoconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
s390                             allyesconfig
x86_64                            allnoconfig
sh                               allmodconfig
mips                             allyesconfig
m68k                             allyesconfig
powerpc                          allmodconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
arc                  randconfig-r043-20230112
riscv                randconfig-r042-20230112
s390                 randconfig-r044-20230112
i386                          randconfig-a001
i386                          randconfig-a003
i386                                defconfig
arm                                 defconfig
x86_64                        randconfig-a004
i386                          randconfig-a005
x86_64                           rhel-8.3-syz
x86_64                        randconfig-a002
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                        randconfig-a006
x86_64                           rhel-8.3-bpf
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
i386                          randconfig-a014
i386                          randconfig-a012
arm64                            allyesconfig
arm                              allyesconfig
i386                          randconfig-a016
i386                             allyesconfig
i386                          randconfig-c001

clang tested configs:
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
arm                  randconfig-r046-20230112
hexagon              randconfig-r041-20230112
hexagon              randconfig-r045-20230112
i386                          randconfig-a002
i386                          randconfig-a004
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a006
x86_64                          rhel-8.3-rust
x86_64                        randconfig-a005
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
