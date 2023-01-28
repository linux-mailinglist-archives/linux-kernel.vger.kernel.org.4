Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6068367F3AC
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 02:21:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233437AbjA1BVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 20:21:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233379AbjA1BVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 20:21:05 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 602B17B435
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 17:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674868864; x=1706404864;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=6rkGR9/S3y4lcDbLhlkrjWgaA5JiYAJMU8fPB0XHdyQ=;
  b=SpD4aF+Tu63Uxy3PZYm/0NFe8bEhOfcN7WW/FlSi1XuHzWIVeslT7OkT
   tz/hWzAfPYx4hjijjvJuXxMi50Bdv6e5yjf52CoqidCBZkGB5j0xFyVEk
   4mnooy+kOFbDqxWLc7+TWgSgAV3zzxE0pbY9t+IhX3/DCCkLyjMyXeD+x
   LBIoZCuBDGK5R+OetgqKFZ9dqHp9GeZPmOkp+ysSeXfNnr4cUNuurKWrH
   R/SHxQwYOTBnfXBxPAoeYSnuXe5DJsQHjOhCGVXB8/hlvjFmCVqH4oj1w
   9UPmhyIZpojTk/xOkiweIYYClx6aqh/a0ciiVVZZWTjUlYg2wCAFeL+05
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="307587323"
X-IronPort-AV: E=Sophos;i="5.97,252,1669104000"; 
   d="scan'208";a="307587323"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 17:21:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="695722637"
X-IronPort-AV: E=Sophos;i="5.97,252,1669104000"; 
   d="scan'208";a="695722637"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 27 Jan 2023 17:21:02 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pLZtt-0000C1-2e;
        Sat, 28 Jan 2023 01:21:01 +0000
Date:   Sat, 28 Jan 2023 09:20:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 fd7cdf8b808dead4a8ee63e7fc81307f815bfd58
Message-ID: <63d47866.+vqfwYooYRMRyLqH%lkp@intel.com>
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
branch HEAD: fd7cdf8b808dead4a8ee63e7fc81307f815bfd58  Merge branch into tip/master: 'x86/fpu'

elapsed time: 3668m

configs tested: 50
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
powerpc                           allnoconfig
um                           x86_64_defconfig
um                             i386_defconfig
arc                                 defconfig
alpha                               defconfig
arm                                 defconfig
s390                             allmodconfig
sh                               allmodconfig
s390                                defconfig
arc                  randconfig-r043-20230123
mips                             allyesconfig
x86_64                    rhel-8.3-kselftests
arm                  randconfig-r046-20230123
x86_64                          rhel-8.3-func
powerpc                          allmodconfig
s390                             allyesconfig
i386                                defconfig
x86_64               randconfig-a002-20230123
m68k                             allmodconfig
x86_64                              defconfig
x86_64               randconfig-a005-20230123
ia64                             allmodconfig
x86_64               randconfig-a001-20230123
x86_64                           rhel-8.3-syz
arm64                            allyesconfig
i386                             allyesconfig
x86_64               randconfig-a006-20230123
x86_64                         rhel-8.3-kunit
arc                              allyesconfig
x86_64                           allyesconfig
x86_64               randconfig-a004-20230123
arm                              allyesconfig
x86_64               randconfig-a003-20230123
x86_64                           rhel-8.3-kvm
x86_64                               rhel-8.3
x86_64                           rhel-8.3-bpf
alpha                            allyesconfig
m68k                             allyesconfig

clang tested configs:
x86_64                          rhel-8.3-rust
hexagon              randconfig-r045-20230123
riscv                randconfig-r042-20230123
hexagon              randconfig-r041-20230123
s390                 randconfig-r044-20230123
x86_64               randconfig-a013-20230123
x86_64               randconfig-a011-20230123
x86_64               randconfig-a012-20230123
x86_64               randconfig-a016-20230123
x86_64               randconfig-a015-20230123
x86_64               randconfig-a014-20230123

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
