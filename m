Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5802D65932E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 00:32:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234239AbiL2Xcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 18:32:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiL2Xcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 18:32:45 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C53B15F00
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 15:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672356764; x=1703892764;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=/3hUUs3GoyJwjLhjjISNnLrxK2OEYxprekjNBKpDmSo=;
  b=LUPFJjKuEM5e2H6OvP8/fqKgHEeLwZ1OmvMytT5zC2gDoH6L12E3XtC8
   Up+0WY+DHYeXpl71X8BDqty/Awk9BMtaNDPwWJ+FhqxGQNOjvY89uB3f0
   Xe+sme6C+ySjIuTn/TfhoEwwRxX5uXLy4yml/ezCenmc0oCFalMvqb+Hl
   kHdYaORfxKttsSZfBIHDcUAuygRmVNX6h5MgymlGRqJ6/FeFWlnRW11un
   7KGvo8kM8Rlw0cHpAbqnFk03UuzlzV+mib0sq036liQ5ZYo8y7nrkUppw
   bZ84u/7SJQ1nP3jja5Una/84TbkSnwov0kIZ4vAc82fGnXzqxxsqhMIkd
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10575"; a="322364518"
X-IronPort-AV: E=Sophos;i="5.96,285,1665471600"; 
   d="scan'208";a="322364518"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2022 15:32:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10575"; a="777813055"
X-IronPort-AV: E=Sophos;i="5.96,285,1665471600"; 
   d="scan'208";a="777813055"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 29 Dec 2022 15:32:41 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pB2O8-000HC2-1C;
        Thu, 29 Dec 2022 23:32:40 +0000
Date:   Fri, 30 Dec 2022 07:32:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 e57afd2216b3825940e4a63bcfafb1e9d090ba24
Message-ID: <63ae238e.93QzSen1UXY/x8bC%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: e57afd2216b3825940e4a63bcfafb1e9d090ba24  Merge ras/core into tip/master

elapsed time: 726m

configs tested: 47
configs skipped: 75

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
i386                                defconfig
i386                          randconfig-a003
i386                          randconfig-a001
i386                          randconfig-a005
i386                 randconfig-a016-20221226
x86_64                              defconfig
x86_64                    rhel-8.3-kselftests
i386                 randconfig-a012-20221226
x86_64                          rhel-8.3-func
x86_64               randconfig-a016-20221226
i386                 randconfig-a011-20221226
x86_64                           rhel-8.3-bpf
i386                 randconfig-a013-20221226
x86_64                           rhel-8.3-syz
i386                 randconfig-a014-20221226
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3
x86_64               randconfig-a014-20221226
x86_64                           rhel-8.3-kvm
x86_64               randconfig-a013-20221226
i386                 randconfig-a015-20221226
x86_64               randconfig-a011-20221226
x86_64               randconfig-a012-20221226
x86_64                           allyesconfig
x86_64               randconfig-a015-20221226
i386                             allyesconfig
x86_64                            allnoconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20221225
i386                          randconfig-c001
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3

clang tested configs:
x86_64               randconfig-a002-20221226
x86_64               randconfig-a003-20221226
x86_64               randconfig-a006-20221226
i386                          randconfig-a002
x86_64               randconfig-a001-20221226
i386                          randconfig-a004
x86_64               randconfig-a004-20221226
x86_64               randconfig-a005-20221226
i386                          randconfig-a006
x86_64                          rhel-8.3-rust
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
