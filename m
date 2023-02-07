Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5956368CDEB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 05:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbjBGEGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 23:06:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjBGEGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 23:06:38 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A204CC08
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 20:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675742797; x=1707278797;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=xib0Cpw7yHgdonLY/iWzBJqUZAC6ixAp+WcxP2chy38=;
  b=FWtHiETlleGE0aSsh8tlntKkZERL+5oHzcKXbvdxPwsYi8SbBcbu1io9
   6W1eZs9DqjPu5mhV24q6L6/gJCmj747sdDmye0Q5DAd3lnOAE4moFRR/l
   7gqF+GZuZQx4EIIQvkrDZ7uEFIu546rgOQOMeFI0oUESCz9jOLfXut4cg
   A7EqwsI0Q0Kuf8zQAGywz6fSnQ07Z2n33fc5j3bfwUU/BNoSFEHbRhK3o
   XJH77NI0ca27OvKzBPp4i/hxX/dh2IktrjV51ZOmCnXrMTiQ0+6E/jG9p
   D7zEhXll+5sl0ZzIu4Tn+TW2xrELSwP+cPw07olkWbe7MyQFouY7b1WA0
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="313051121"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="313051121"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 20:06:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="775380335"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="775380335"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 06 Feb 2023 20:06:33 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pPFFY-00033D-1v;
        Tue, 07 Feb 2023 04:06:32 +0000
Date:   Tue, 07 Feb 2023 12:05:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/vdso] BUILD SUCCESS WITH WARNING
 5646bbd6684acf5c9b9dedb863b7d2f6f5a330fb
Message-ID: <63e1ce1f.3OB575/3GBSihMjh%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/vdso
branch HEAD: 5646bbd6684acf5c9b9dedb863b7d2f6f5a330fb  selftests: Emit a warning if getcpu() is missing on 32bit

Warning reports:

https://lore.kernel.org/oe-kbuild-all/202302070742.iYcnoJwk-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202302070751.uhpE2V7R-lkp@intel.com

Warning: (recently discovered and may have been fixed)

arch/x86/entry/vdso/vdso32/../vgetcpu.c:13:1: warning: no previous prototype for '__vdso_getcpu' [-Wmissing-prototypes]
arch/x86/entry/vdso/vdso32/../vgetcpu.c:13:1: warning: no previous prototype for function '__vdso_getcpu' [-Wmissing-prototypes]

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- i386-defconfig
|   `-- arch-x86-entry-vdso-vdso32-..-vgetcpu.c:warning:no-previous-prototype-for-__vdso_getcpu
|-- i386-randconfig-a011-20230206
|   `-- arch-x86-entry-vdso-vdso32-..-vgetcpu.c:warning:no-previous-prototype-for-__vdso_getcpu
|-- i386-randconfig-a012-20230206
|   `-- arch-x86-entry-vdso-vdso32-..-vgetcpu.c:warning:no-previous-prototype-for-__vdso_getcpu
|-- i386-randconfig-a013-20230206
|   `-- arch-x86-entry-vdso-vdso32-..-vgetcpu.c:warning:no-previous-prototype-for-__vdso_getcpu
|-- i386-randconfig-a014-20230206
|   `-- arch-x86-entry-vdso-vdso32-..-vgetcpu.c:warning:no-previous-prototype-for-__vdso_getcpu
|-- i386-randconfig-a015-20230206
|   `-- arch-x86-entry-vdso-vdso32-..-vgetcpu.c:warning:no-previous-prototype-for-__vdso_getcpu
|-- i386-randconfig-a016-20230206
|   `-- arch-x86-entry-vdso-vdso32-..-vgetcpu.c:warning:no-previous-prototype-for-__vdso_getcpu
|-- i386-randconfig-m021
|   `-- arch-x86-entry-vdso-vdso32-..-vgetcpu.c:warning:no-previous-prototype-for-__vdso_getcpu
|-- x86_64-defconfig
|   `-- arch-x86-entry-vdso-vdso32-..-vgetcpu.c:warning:no-previous-prototype-for-__vdso_getcpu
|-- x86_64-randconfig-a011-20230206
|   `-- arch-x86-entry-vdso-vdso32-..-vgetcpu.c:warning:no-previous-prototype-for-__vdso_getcpu
|-- x86_64-randconfig-a015-20230206
|   `-- arch-x86-entry-vdso-vdso32-..-vgetcpu.c:warning:no-previous-prototype-for-__vdso_getcpu
|-- x86_64-randconfig-a016-20230206
|   `-- arch-x86-entry-vdso-vdso32-..-vgetcpu.c:warning:no-previous-prototype-for-__vdso_getcpu
|-- x86_64-rhel-8.3-bpf
|   `-- arch-x86-entry-vdso-vdso32-..-vgetcpu.c:warning:no-previous-prototype-for-__vdso_getcpu
`-- x86_64-rhel-8.3-kselftests
    `-- arch-x86-entry-vdso-vdso32-..-vgetcpu.c:warning:no-previous-prototype-for-__vdso_getcpu
clang_recent_errors
|-- i386-randconfig-a002-20230206
|   `-- arch-x86-entry-vdso-vdso32-..-vgetcpu.c:warning:no-previous-prototype-for-function-__vdso_getcpu
|-- i386-randconfig-a005-20230206
|   `-- arch-x86-entry-vdso-vdso32-..-vgetcpu.c:warning:no-previous-prototype-for-function-__vdso_getcpu
|-- x86_64-randconfig-a001-20230206
|   `-- arch-x86-entry-vdso-vdso32-..-vgetcpu.c:warning:no-previous-prototype-for-function-__vdso_getcpu
|-- x86_64-randconfig-r031-20230206
|   `-- arch-x86-entry-vdso-vdso32-..-vgetcpu.c:warning:no-previous-prototype-for-function-__vdso_getcpu
`-- x86_64-rhel-8.3-rust
    `-- arch-x86-entry-vdso-vdso32-..-vgetcpu.c:warning:no-previous-prototype-for-function-__vdso_getcpu

elapsed time: 780m

configs tested: 42
configs skipped: 2

gcc tested configs:
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
ia64                             allmodconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
i386                             allyesconfig
i386                                defconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                           rhel-8.3-bpf
x86_64                         rhel-8.3-kunit
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
i386                          randconfig-c001
powerpc              randconfig-c003-20230205
alpha                            allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
s390                             allyesconfig
x86_64                            allnoconfig
i386                 randconfig-a015-20230206
i386                 randconfig-a011-20230206
i386                 randconfig-a014-20230206
i386                 randconfig-a013-20230206
i386                 randconfig-a016-20230206
i386                 randconfig-a012-20230206

clang tested configs:
x86_64                        randconfig-k001
arm                         mv78xx0_defconfig
x86_64                          rhel-8.3-rust

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
