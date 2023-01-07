Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7792F660B96
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 02:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbjAGBqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 20:46:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjAGBqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 20:46:22 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D488792E
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 17:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673055981; x=1704591981;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=/3zMA+aJr2tLWYuCVx3gDRRYZq3MGOF790YxbXWq4OM=;
  b=Z+SAbPr0bXE1F4Fe6cZM616APYDdbg3R5P754iSB8YOhTRwkafxCJxu7
   AamKUdN7zUW1I8Z5r2rEIJsxzFQU/3rqLQvNetwpcvEeRRsfbQ2KUPOq/
   JOMWgtBPzFC21XuTNaLRcfbHp9K+HP1jfhGFDjRClXF74ikMT2L8PteXn
   cKNYgqZYLSQxym7U/Q7nX4eE2kP6Lm9pRee+sxFls77pmDAtX2ytg4RE7
   B9GF7bkr0CxdghJHbQY4rELfXyckouO1hMnuFWGARJn5bX8HeXpu9HOjD
   DWqGiNEz+4gMz+n0nN2YgiEMFfxtYWeUyxNXcRDIh2xUyt5V3OYvjKbTi
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10582"; a="387057996"
X-IronPort-AV: E=Sophos;i="5.96,307,1665471600"; 
   d="scan'208";a="387057996"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2023 17:46:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10582"; a="633655522"
X-IronPort-AV: E=Sophos;i="5.96,307,1665471600"; 
   d="scan'208";a="633655522"
Received: from lkp-server02.sh.intel.com (HELO f1920e93ebb5) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 06 Jan 2023 17:46:19 -0800
Received: from kbuild by f1920e93ebb5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pDyHq-00045n-20;
        Sat, 07 Jan 2023 01:46:18 +0000
Date:   Sat, 07 Jan 2023 09:45:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 c0c137cf5937f4c4b4ab5422be01530820ca78c3
Message-ID: <63b8ceb4.9bzMY1c12RB7Bj2A%lkp@intel.com>
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
branch HEAD: c0c137cf5937f4c4b4ab5422be01530820ca78c3  Merge branch into tip/master: 'x86/cleanups'

elapsed time: 794m

configs tested: 65
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                            allnoconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
s390                             allyesconfig
i386                          randconfig-a001
arm                                 defconfig
arc                  randconfig-r043-20230106
i386                          randconfig-a003
m68k                             allmodconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a013
arc                              allyesconfig
x86_64                        randconfig-a002
i386                          randconfig-a014
alpha                            allyesconfig
i386                          randconfig-a012
arm                  randconfig-r046-20230106
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                           rhel-8.3-bpf
x86_64                         rhel-8.3-kunit
arm64                            allyesconfig
i386                          randconfig-a016
m68k                             allyesconfig
i386                          randconfig-a005
x86_64                        randconfig-a011
i386                                defconfig
arm                              allyesconfig
x86_64                        randconfig-a006
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                        randconfig-a015
i386                             allyesconfig
ia64                             allmodconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig

clang tested configs:
hexagon              randconfig-r041-20230106
i386                          randconfig-a013
s390                 randconfig-r044-20230106
i386                          randconfig-a002
x86_64                          rhel-8.3-rust
riscv                randconfig-r042-20230106
hexagon              randconfig-r045-20230106
i386                          randconfig-a015
i386                          randconfig-a006
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a004
x86_64                        randconfig-a003
x86_64                        randconfig-a012
x86_64                        randconfig-a014
hexagon              randconfig-r041-20230107
hexagon              randconfig-r045-20230107
arm                  randconfig-r046-20230107

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
