Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 774AA6A0418
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 09:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233624AbjBWIom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 03:44:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232942AbjBWIok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 03:44:40 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF2B4FAA2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 00:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677141846; x=1708677846;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=7xVhO2yO3QfJ66ItvApgh5GjbhT/E9SrVADst9CluXw=;
  b=hocnyyR4/1D0TKFh3mlQc1UtUq9Fttef/uKkI0mvAIvJ0y7CVnHzFPZu
   wt39szut0EGtLgY5WnaFt9RzUz0bMa43eL+4dmKQnUXr4PtTOZ/ujf9yu
   /a/jFrbHGkYmGKV+UIZgquee5ueyyqW02L5tXD+H98b+spbU+M3lEEJGg
   GkRKQ73Mp2lUh2d8ZQQHANlMxQ/ng317vGxv+oib7gg8S9R6xFx/UWTdK
   RNbFqlfjZYAdEJuQQ9+WeX7CbG1GaLMWe0gYMoSthg01WEQAiM/Qt74UL
   ECHMKGDdUtL5aCRcZfAPrLavVaboUTfB9zs1KRjX85nzqKxuYZ1gy+90h
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="334521253"
X-IronPort-AV: E=Sophos;i="5.97,320,1669104000"; 
   d="scan'208";a="334521253"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2023 00:44:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="815243388"
X-IronPort-AV: E=Sophos;i="5.97,320,1669104000"; 
   d="scan'208";a="815243388"
Received: from lkp-server01.sh.intel.com (HELO 3895f5c55ead) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 23 Feb 2023 00:43:53 -0800
Received: from kbuild by 3895f5c55ead with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pV7Cj-0001BT-0Z;
        Thu, 23 Feb 2023 08:43:53 +0000
Date:   Thu, 23 Feb 2023 16:43:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2023.02.16a] BUILD REGRESSION
 c7d439bec433cc8f263d3dd19085f0b23582a677
Message-ID: <63f7273e.7u0Bv2PNIhn/NS1f%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,LONGWORDS,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2023.02.16a
branch HEAD: c7d439bec433cc8f263d3dd19085f0b23582a677  objtool: Fix for unreachable instruction warning

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202302021723.ucm8d559-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

arch/ia64/kernel/process.c:231:1: warning: 'noreturn' function does return
net/netfilter/ipvs/ip_vs_est.c:552:15: error: too few arguments provided to function-like macro invocation
net/netfilter/ipvs/ip_vs_est.c:552:17: error: 'kfree_rcu' undeclared (first use in this function); did you mean 'kfree_skb'?
net/netfilter/ipvs/ip_vs_est.c:552:29: error: macro "kfree_rcu" requires 2 arguments, but only 1 given
net/netfilter/ipvs/ip_vs_est.c:552:3: error: use of undeclared identifier 'kfree_rcu'; did you mean 'kfree_skb'?

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- ia64-buildonly-randconfig-r005-20230222
|   `-- arch-ia64-kernel-process.c:warning:noreturn-function-does-return
|-- mips-allyesconfig
|   |-- net-netfilter-ipvs-ip_vs_est.c:error:kfree_rcu-undeclared-(first-use-in-this-function)
|   `-- net-netfilter-ipvs-ip_vs_est.c:error:macro-kfree_rcu-requires-arguments-but-only-given
|-- powerpc-allmodconfig
|   |-- net-netfilter-ipvs-ip_vs_est.c:error:kfree_rcu-undeclared-(first-use-in-this-function)
|   `-- net-netfilter-ipvs-ip_vs_est.c:error:macro-kfree_rcu-requires-arguments-but-only-given
|-- sh-allmodconfig
|   |-- net-netfilter-ipvs-ip_vs_est.c:error:kfree_rcu-undeclared-(first-use-in-this-function)
|   `-- net-netfilter-ipvs-ip_vs_est.c:error:macro-kfree_rcu-requires-arguments-but-only-given
|-- sparc-allyesconfig
|   |-- net-netfilter-ipvs-ip_vs_est.c:error:kfree_rcu-undeclared-(first-use-in-this-function)
|   `-- net-netfilter-ipvs-ip_vs_est.c:error:macro-kfree_rcu-requires-arguments-but-only-given
|-- x86_64-allyesconfig
|   |-- net-netfilter-ipvs-ip_vs_est.c:error:kfree_rcu-undeclared-(first-use-in-this-function)
|   `-- net-netfilter-ipvs-ip_vs_est.c:error:macro-kfree_rcu-requires-arguments-but-only-given
`-- x86_64-rhel-8.3
    |-- net-netfilter-ipvs-ip_vs_est.c:error:kfree_rcu-undeclared-(first-use-in-this-function)
    `-- net-netfilter-ipvs-ip_vs_est.c:error:macro-kfree_rcu-requires-arguments-but-only-given
clang_recent_errors
`-- i386-randconfig-a013
    |-- net-netfilter-ipvs-ip_vs_est.c:error:too-few-arguments-provided-to-function-like-macro-invocation
    `-- net-netfilter-ipvs-ip_vs_est.c:error:use-of-undeclared-identifier-kfree_rcu

elapsed time: 10409m

configs tested: 73
configs skipped: 3

gcc tested configs:
alpha                            allyesconfig
alpha                               defconfig
arc                              allyesconfig
arc                                 defconfig
arc                  randconfig-r043-20230222
arm                              allmodconfig
arm                              allyesconfig
arm                                 defconfig
arm                  randconfig-r046-20230222
arm64                            allyesconfig
arm64                               defconfig
csky                                defconfig
i386                             allyesconfig
i386                              debian-10.3
i386                                defconfig
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
ia64                             allmodconfig
ia64                                defconfig
loongarch                        allmodconfig
loongarch                         allnoconfig
loongarch                           defconfig
m68k                             allmodconfig
m68k                                defconfig
mips                             allmodconfig
mips                             allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
riscv                            allmodconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
s390                             allmodconfig
s390                             allyesconfig
s390                                defconfig
sh                               allmodconfig
sparc                               defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                            allnoconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                                  kexec
x86_64                        randconfig-a002
x86_64                        randconfig-a004
x86_64                        randconfig-a006
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
x86_64                               rhel-8.3

clang tested configs:
hexagon              randconfig-r041-20230222
hexagon              randconfig-r045-20230222
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
riscv                randconfig-r042-20230222
s390                 randconfig-r044-20230222
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
