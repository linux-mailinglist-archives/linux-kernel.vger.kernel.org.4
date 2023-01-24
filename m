Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1018B67A041
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 18:35:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233780AbjAXRfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 12:35:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232437AbjAXRfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 12:35:13 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D9DB10AB0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 09:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674581712; x=1706117712;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=7r5ZpnZ5uUluW9VPhXKSqRskXeDpgnhQA3hkFO3z6Ms=;
  b=hNtSxji507W/RpFmjwVewzygyTktwSI+QNyCTPDi+xsKwJQMc+lcR6dF
   y5Fs2YA+27W2S6GXqJYAwNU6nxyHS2a7MJlrdyW2RSSZTxJ8JTQcOqKCo
   IodXI8H9YiVDAJbpbjAk1UbpF6sh+Nabj6uK7gIQ/6Hr/H6HnkxTja2AH
   BtUqbi6zXwDrJZHPRkQjpEw5yS7uLVaKD7/ULvNcYinr6pwz7refKyGbR
   zxEpnYrCowl71gt0yd/zoUY1g8IR+QXud54UbM2NFOD4YFTiDIwR3yNd8
   g6zCTAmUfIPm7j//J0kQibT59yHPqvlV/7JZANtg17rwgu4MQ/bVTHiB1
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="412587009"
X-IronPort-AV: E=Sophos;i="5.97,243,1669104000"; 
   d="scan'208";a="412587009"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2023 09:35:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="730758636"
X-IronPort-AV: E=Sophos;i="5.97,242,1669104000"; 
   d="scan'208";a="730758636"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 24 Jan 2023 09:35:10 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pKNCP-0006f9-2P;
        Tue, 24 Jan 2023 17:35:09 +0000
Date:   Wed, 25 Jan 2023 01:34:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:rcu/next] BUILD SUCCESS
 42020f3dda80d4d199cffc2618310be5d131ce47
Message-ID: <63d016ac.krXUTMHWrx6b/wUx%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: 42020f3dda80d4d199cffc2618310be5d131ce47  tools/nolibc: Add gitignore to avoid git complaints about sysroot

elapsed time: 722m

configs tested: 77
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
arc                                 defconfig
um                             i386_defconfig
s390                             allmodconfig
um                           x86_64_defconfig
alpha                               defconfig
s390                                defconfig
s390                             allyesconfig
arc                  randconfig-r043-20230123
i386                                defconfig
arm                  randconfig-r046-20230123
x86_64                              defconfig
x86_64                               rhel-8.3
arm                                 defconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
mips                             allyesconfig
x86_64                           rhel-8.3-syz
sh                               allmodconfig
x86_64                         rhel-8.3-kunit
x86_64               randconfig-a002-20230123
x86_64               randconfig-a005-20230123
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
x86_64                           allyesconfig
x86_64                           rhel-8.3-kvm
arm                              allyesconfig
x86_64               randconfig-a001-20230123
m68k                             allyesconfig
x86_64               randconfig-a006-20230123
m68k                             allmodconfig
x86_64                           rhel-8.3-bpf
arc                              allyesconfig
x86_64               randconfig-a004-20230123
arm64                            allyesconfig
i386                             allyesconfig
x86_64               randconfig-a003-20230123
alpha                            allyesconfig
i386                 randconfig-a004-20230123
i386                 randconfig-a003-20230123
i386                 randconfig-a002-20230123
i386                 randconfig-a001-20230123
i386                 randconfig-a005-20230123
i386                 randconfig-a006-20230123
ia64                             allmodconfig
m68k                        m5407c3_defconfig
arm                             rpc_defconfig
s390                          debug_defconfig
arc                    vdk_hs38_smp_defconfig
openrisc                       virt_defconfig
i386                 randconfig-c001-20230123
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3

clang tested configs:
x86_64               randconfig-a013-20230123
x86_64               randconfig-a011-20230123
x86_64               randconfig-a012-20230123
hexagon              randconfig-r041-20230123
x86_64               randconfig-a016-20230123
x86_64               randconfig-a015-20230123
hexagon              randconfig-r045-20230123
x86_64               randconfig-a014-20230123
s390                 randconfig-r044-20230123
riscv                randconfig-r042-20230123
i386                 randconfig-a012-20230123
x86_64                          rhel-8.3-rust
i386                 randconfig-a013-20230123
i386                 randconfig-a015-20230123
i386                 randconfig-a011-20230123
i386                 randconfig-a014-20230123
i386                 randconfig-a016-20230123
mips                          rb532_defconfig
arm                            qcom_defconfig
x86_64               randconfig-k001-20230123

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
