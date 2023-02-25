Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9E26A27D7
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 09:08:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbjBYII2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 03:08:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjBYIIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 03:08:25 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C17E3AC
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 00:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677312504; x=1708848504;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=HdPn0nUP9z2e8JaUXV/1MDAjdowwwNaPz5diSsNXVLw=;
  b=QdxHdK7a99u5amJiwW4vmZ1+cJDmKeDDCFQZLgWR3v56uJcotbmM0WeG
   ZSI0mSLY/fqp32dgutK1302KH09BrauB0IPjxw2wr3AlJBDg6J+/7yl/9
   3DFrcbpqq0ieVUHPr2K3oYojqm4lpHNYZolwEHkuxRADlCbXlZ0LdautB
   4Pc6aXo3YfXGotzjZBqVVQs+idxVu/if6s8w1is+TDU9bYrgXh/9OKfNT
   5uapx7JGyqzMN/LJ+NDs6iF4BHMcuAYlDcNZp1jKNiBAH+rSlBeqMLnuJ
   tpm+mEcO0Eq/08Ee97IK6TRtoBzj88VjJdSJPRa/lCsoXR0k4UcYegz7x
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10631"; a="419876511"
X-IronPort-AV: E=Sophos;i="5.97,327,1669104000"; 
   d="scan'208";a="419876511"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2023 00:08:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10631"; a="782646145"
X-IronPort-AV: E=Sophos;i="5.97,327,1669104000"; 
   d="scan'208";a="782646145"
Received: from lkp-server01.sh.intel.com (HELO 3895f5c55ead) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 25 Feb 2023 00:08:23 -0800
Received: from kbuild by 3895f5c55ead with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pVpbS-000333-1V;
        Sat, 25 Feb 2023 08:08:22 +0000
Date:   Sat, 25 Feb 2023 16:07:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2023.02.22a] BUILD REGRESSION
 edc9d419ee8c22821ffd664466a5cf19208c3f02
Message-ID: <63f9c1d8.kihz/MuydejKYsyt%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2023.02.22a
branch HEAD: edc9d419ee8c22821ffd664466a5cf19208c3f02  locktorture: Add raw_spinlock* torture tests for PREEMPT_RT kernels

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202302251550.OSl3zbgK-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

arch/mips/kernel/process.c:46:1: warning: function declared 'noreturn' should not return [-Winvalid-noreturn]
arch/powerpc/kernel/smp.c:1768:1: error: function declared 'noreturn' should not return [-Werror,-Winvalid-noreturn]
net/netfilter/ipvs/ip_vs_est.c:552:15: error: too few arguments provided to function-like macro invocation
net/netfilter/ipvs/ip_vs_est.c:552:17: error: 'kfree_rcu' undeclared (first use in this function); did you mean 'kfree_skb'?
net/netfilter/ipvs/ip_vs_est.c:552:29: error: macro "kfree_rcu" requires 2 arguments, but only 1 given
net/netfilter/ipvs/ip_vs_est.c:552:3: error: use of undeclared identifier 'kfree_rcu'; did you mean 'kfree_skb'?

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allyesconfig
|   |-- net-netfilter-ipvs-ip_vs_est.c:error:kfree_rcu-undeclared-(first-use-in-this-function)
|   `-- net-netfilter-ipvs-ip_vs_est.c:error:macro-kfree_rcu-requires-arguments-but-only-given
|-- arc-allyesconfig
|   |-- net-netfilter-ipvs-ip_vs_est.c:error:kfree_rcu-undeclared-(first-use-in-this-function)
|   `-- net-netfilter-ipvs-ip_vs_est.c:error:macro-kfree_rcu-requires-arguments-but-only-given
|-- arm-allmodconfig
|   |-- net-netfilter-ipvs-ip_vs_est.c:error:kfree_rcu-undeclared-(first-use-in-this-function)
|   `-- net-netfilter-ipvs-ip_vs_est.c:error:macro-kfree_rcu-requires-arguments-but-only-given
|-- arm-allyesconfig
|   |-- net-netfilter-ipvs-ip_vs_est.c:error:kfree_rcu-undeclared-(first-use-in-this-function)
|   `-- net-netfilter-ipvs-ip_vs_est.c:error:macro-kfree_rcu-requires-arguments-but-only-given
|-- arm64-allyesconfig
|   |-- net-netfilter-ipvs-ip_vs_est.c:error:kfree_rcu-undeclared-(first-use-in-this-function)
|   `-- net-netfilter-ipvs-ip_vs_est.c:error:macro-kfree_rcu-requires-arguments-but-only-given
|-- arm64-defconfig
|   |-- net-netfilter-ipvs-ip_vs_est.c:error:kfree_rcu-undeclared-(first-use-in-this-function)
|   `-- net-netfilter-ipvs-ip_vs_est.c:error:macro-kfree_rcu-requires-arguments-but-only-given
|-- m68k-allmodconfig
|   |-- net-netfilter-ipvs-ip_vs_est.c:error:kfree_rcu-undeclared-(first-use-in-this-function)
|   `-- net-netfilter-ipvs-ip_vs_est.c:error:macro-kfree_rcu-requires-arguments-but-only-given
|-- mips-allmodconfig
|   |-- net-netfilter-ipvs-ip_vs_est.c:error:kfree_rcu-undeclared-(first-use-in-this-function)
|   `-- net-netfilter-ipvs-ip_vs_est.c:error:macro-kfree_rcu-requires-arguments-but-only-given
|-- mips-allyesconfig
|   |-- net-netfilter-ipvs-ip_vs_est.c:error:kfree_rcu-undeclared-(first-use-in-this-function)
|   `-- net-netfilter-ipvs-ip_vs_est.c:error:macro-kfree_rcu-requires-arguments-but-only-given
|-- powerpc-allmodconfig
|   |-- net-netfilter-ipvs-ip_vs_est.c:error:kfree_rcu-undeclared-(first-use-in-this-function)
|   `-- net-netfilter-ipvs-ip_vs_est.c:error:macro-kfree_rcu-requires-arguments-but-only-given
|-- riscv-allmodconfig
|   |-- net-netfilter-ipvs-ip_vs_est.c:error:kfree_rcu-undeclared-(first-use-in-this-function)
|   `-- net-netfilter-ipvs-ip_vs_est.c:error:macro-kfree_rcu-requires-arguments-but-only-given
|-- riscv-defconfig
|   |-- net-netfilter-ipvs-ip_vs_est.c:error:kfree_rcu-undeclared-(first-use-in-this-function)
|   `-- net-netfilter-ipvs-ip_vs_est.c:error:macro-kfree_rcu-requires-arguments-but-only-given
|-- riscv-rv32_defconfig
|   |-- net-netfilter-ipvs-ip_vs_est.c:error:kfree_rcu-undeclared-(first-use-in-this-function)
|   `-- net-netfilter-ipvs-ip_vs_est.c:error:macro-kfree_rcu-requires-arguments-but-only-given
|-- s390-allmodconfig
|   |-- net-netfilter-ipvs-ip_vs_est.c:error:kfree_rcu-undeclared-(first-use-in-this-function)
|   `-- net-netfilter-ipvs-ip_vs_est.c:error:macro-kfree_rcu-requires-arguments-but-only-given
|-- s390-allyesconfig
|   |-- net-netfilter-ipvs-ip_vs_est.c:error:kfree_rcu-undeclared-(first-use-in-this-function)
|   `-- net-netfilter-ipvs-ip_vs_est.c:error:macro-kfree_rcu-requires-arguments-but-only-given
|-- s390-defconfig
|   |-- net-netfilter-ipvs-ip_vs_est.c:error:kfree_rcu-undeclared-(first-use-in-this-function)
|   `-- net-netfilter-ipvs-ip_vs_est.c:error:macro-kfree_rcu-requires-arguments-but-only-given
|-- sh-allmodconfig
|   |-- net-netfilter-ipvs-ip_vs_est.c:error:kfree_rcu-undeclared-(first-use-in-this-function)
clang_recent_errors
|-- i386-randconfig-a006
|   |-- net-netfilter-ipvs-ip_vs_est.c:error:too-few-arguments-provided-to-function-like-macro-invocation
|   `-- net-netfilter-ipvs-ip_vs_est.c:error:use-of-undeclared-identifier-kfree_rcu
|-- mips-buildonly-randconfig-r003-20230222
|   `-- arch-mips-kernel-process.c:warning:function-declared-noreturn-should-not-return
`-- powerpc-buildonly-randconfig-r004-20230222
    `-- arch-powerpc-kernel-smp.c:error:function-declared-noreturn-should-not-return-Werror-Winvalid-noreturn

elapsed time: 3322m

configs tested: 19
configs skipped: 3

tested configs:
clang                                   alpha   defconfig
gcc                                       arc   defconfig
gcc                                       arm   defconfig
gcc                                     arm64   defconfig
gcc                                      csky   defconfig
gcc                                      i386   defconfig
gcc                                      ia64   defconfig
gcc                                 loongarch   defconfig
gcc                                      m68k   defconfig
gcc                                     nios2   defconfig
gcc                                    parisc   defconfig
gcc                                  parisc64   defconfig
gcc                                     riscv   defconfig
gcc                                     riscv   rv32_defconfig
gcc                                      s390   defconfig
gcc                                     sparc   defconfig
gcc                                        um   i386_defconfig
gcc                                        um   x86_64_defconfig
gcc                                    x86_64   defconfig
gcc                                                  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
