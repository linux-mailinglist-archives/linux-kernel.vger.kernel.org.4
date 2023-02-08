Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 030E768E87F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 07:50:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjBHGt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 01:49:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjBHGt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 01:49:58 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 303DB3B679
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 22:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675838997; x=1707374997;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=jQ0Pzpr+hwWEO+0F2vpI8YRW24uO10v5HXKmbJCnmlE=;
  b=fFLuugBeL3YpIc6kDVoNraKvrUuRaiZXMAGvLwbzp5cPQ3TxVuyWnXh9
   w4jlIBoEp64Gr0VCmK0QUDAm0MApzCtpksHJ3em8BzvWIZ3zKgFskm46o
   9v+UMuqgIIZsyFEdB1nVhAcXfyL0Lo15wQSSBGO4Btcb5mmwL6n0yY6Al
   8mM1/+in1YQQdxLPHm9MR+DE7+zGmhlwPEDA4jMMKeOc2+ZYR1+D0wWB4
   2E5mXMhuyAy5HisSt9W9SNTqAU+S3x1U96khT2jrTWHl5CIT5WuVxBVjv
   dwNc+JwvH5UTsemnvazhI993aWPYGw7BhanVpAvavV4Nw4ru2I+lUz9wW
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="331018627"
X-IronPort-AV: E=Sophos;i="5.97,280,1669104000"; 
   d="scan'208";a="331018627"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2023 22:49:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="730752157"
X-IronPort-AV: E=Sophos;i="5.97,280,1669104000"; 
   d="scan'208";a="730752157"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 07 Feb 2023 22:49:54 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pPeHC-0004Fo-0A;
        Wed, 08 Feb 2023 06:49:54 +0000
Date:   Wed, 08 Feb 2023 14:49:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/vdso] BUILD SUCCESS WITH WARNING
 dac0da428f8dfb23666ab4ea54a7768c152b857a
Message-ID: <63e345e4.SOCHp44J2G4L2gZg%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/vdso
branch HEAD: dac0da428f8dfb23666ab4ea54a7768c152b857a  x86/vdso: Fix -Wmissing-prototypes warnings

Warning reports:

https://lore.kernel.org/oe-kbuild-all/202302070742.iYcnoJwk-lkp@intel.com

Warning: (recently discovered and may have been fixed)

arch/x86/entry/vdso/vdso32/../vgetcpu.c:13:1: warning: no previous prototype for '__vdso_getcpu' [-Wmissing-prototypes]
arch/x86/entry/vdso/vdso32/../vgetcpu.c:13:1: warning: no previous prototype for function '__vdso_getcpu' [-Wmissing-prototypes]

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- i386-allyesconfig
|   `-- arch-x86-entry-vdso-vdso32-..-vgetcpu.c:warning:no-previous-prototype-for-__vdso_getcpu
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
|-- x86_64-allyesconfig
|   `-- arch-x86-entry-vdso-vdso32-..-vgetcpu.c:warning:no-previous-prototype-for-__vdso_getcpu
|-- x86_64-defconfig
|   `-- arch-x86-entry-vdso-vdso32-..-vgetcpu.c:warning:no-previous-prototype-for-__vdso_getcpu
|-- x86_64-randconfig-a011
|   `-- arch-x86-entry-vdso-vdso32-..-vgetcpu.c:warning:no-previous-prototype-for-__vdso_getcpu
|-- x86_64-randconfig-a011-20230206
|   `-- arch-x86-entry-vdso-vdso32-..-vgetcpu.c:warning:no-previous-prototype-for-__vdso_getcpu
|-- x86_64-randconfig-a015-20230206
|   `-- arch-x86-entry-vdso-vdso32-..-vgetcpu.c:warning:no-previous-prototype-for-__vdso_getcpu
|-- x86_64-randconfig-a016-20230206
|   `-- arch-x86-entry-vdso-vdso32-..-vgetcpu.c:warning:no-previous-prototype-for-__vdso_getcpu
|-- x86_64-randconfig-r024-20230206
|   `-- arch-x86-entry-vdso-vdso32-..-vgetcpu.c:warning:no-previous-prototype-for-__vdso_getcpu
|-- x86_64-rhel-8.3
|   `-- arch-x86-entry-vdso-vdso32-..-vgetcpu.c:warning:no-previous-prototype-for-__vdso_getcpu
|-- x86_64-rhel-8.3-func
|   `-- arch-x86-entry-vdso-vdso32-..-vgetcpu.c:warning:no-previous-prototype-for-__vdso_getcpu
|-- x86_64-rhel-8.3-kselftests
|   `-- arch-x86-entry-vdso-vdso32-..-vgetcpu.c:warning:no-previous-prototype-for-__vdso_getcpu
|-- x86_64-rhel-8.3-kunit
|   `-- arch-x86-entry-vdso-vdso32-..-vgetcpu.c:warning:no-previous-prototype-for-__vdso_getcpu
|-- x86_64-rhel-8.3-kvm
|   `-- arch-x86-entry-vdso-vdso32-..-vgetcpu.c:warning:no-previous-prototype-for-__vdso_getcpu
`-- x86_64-rhel-8.3-syz
    `-- arch-x86-entry-vdso-vdso32-..-vgetcpu.c:warning:no-previous-prototype-for-__vdso_getcpu
clang_recent_errors
|-- i386-randconfig-a001-20230206
|   `-- arch-x86-entry-vdso-vdso32-..-vgetcpu.c:warning:no-previous-prototype-for-function-__vdso_getcpu
|-- i386-randconfig-a002-20230206
|   `-- arch-x86-entry-vdso-vdso32-..-vgetcpu.c:warning:no-previous-prototype-for-function-__vdso_getcpu
|-- i386-randconfig-a003-20230206
|   `-- arch-x86-entry-vdso-vdso32-..-vgetcpu.c:warning:no-previous-prototype-for-function-__vdso_getcpu
|-- i386-randconfig-a004-20230206
|   `-- arch-x86-entry-vdso-vdso32-..-vgetcpu.c:warning:no-previous-prototype-for-function-__vdso_getcpu
|-- i386-randconfig-a005-20230206
|   `-- arch-x86-entry-vdso-vdso32-..-vgetcpu.c:warning:no-previous-prototype-for-function-__vdso_getcpu
|-- i386-randconfig-a006-20230206
|   `-- arch-x86-entry-vdso-vdso32-..-vgetcpu.c:warning:no-previous-prototype-for-function-__vdso_getcpu
|-- i386-randconfig-a013
|   `-- arch-x86-entry-vdso-vdso32-..-vgetcpu.c:warning:no-previous-prototype-for-function-__vdso_getcpu
|-- x86_64-randconfig-a001-20230206
|   `-- arch-x86-entry-vdso-vdso32-..-vgetcpu.c:warning:no-previous-prototype-for-function-__vdso_getcpu
|-- x86_64-randconfig-a002-20230206
|   `-- arch-x86-entry-vdso-vdso32-..-vgetcpu.c:warning:no-previous-prototype-for-function-__vdso_getcpu
|-- x86_64-randconfig-a003-20230206
|   `-- arch-x86-entry-vdso-vdso32-..-vgetcpu.c:warning:no-previous-prototype-for-function-__vdso_getcpu
|-- x86_64-randconfig-a004-20230206
|   `-- arch-x86-entry-vdso-vdso32-..-vgetcpu.c:warning:no-previous-prototype-for-function-__vdso_getcpu
|-- x86_64-randconfig-a005-20230206
|   `-- arch-x86-entry-vdso-vdso32-..-vgetcpu.c:warning:no-previous-prototype-for-function-__vdso_getcpu
`-- x86_64-rhel-8.3-rust
    `-- arch-x86-entry-vdso-vdso32-..-vgetcpu.c:warning:no-previous-prototype-for-function-__vdso_getcpu

elapsed time: 722m

configs tested: 42
configs skipped: 81

gcc tested configs:
x86_64                            allnoconfig
x86_64                           rhel-8.3-bpf
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
x86_64                           allyesconfig
x86_64               randconfig-a013-20230206
x86_64               randconfig-a011-20230206
x86_64               randconfig-a012-20230206
x86_64               randconfig-a014-20230206
i386                                defconfig
x86_64               randconfig-a015-20230206
x86_64               randconfig-a016-20230206
i386                 randconfig-a011-20230206
i386                 randconfig-a014-20230206
i386                 randconfig-a012-20230206
i386                 randconfig-a013-20230206
i386                             allyesconfig
i386                 randconfig-a015-20230206
i386                 randconfig-a016-20230206
ia64                             allmodconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig

clang tested configs:
x86_64                          rhel-8.3-rust
i386                 randconfig-a002-20230206
i386                 randconfig-a004-20230206
i386                 randconfig-a003-20230206
i386                 randconfig-a001-20230206
i386                 randconfig-a005-20230206
i386                 randconfig-a006-20230206
x86_64               randconfig-a001-20230206
x86_64               randconfig-a002-20230206
x86_64               randconfig-a004-20230206
x86_64               randconfig-a003-20230206
x86_64               randconfig-a005-20230206
x86_64               randconfig-a006-20230206

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
