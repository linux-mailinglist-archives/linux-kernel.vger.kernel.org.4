Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10ED5634F27
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 05:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235522AbiKWEo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 23:44:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235457AbiKWEox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 23:44:53 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45CE8CFBB2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 20:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669178693; x=1700714693;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=X1k8Vff9p0L1oC81svUoRtjTwPYNLLcpyMPsWnMknPA=;
  b=drfhnQWZRaL3elfq+Qs/nbVl16mhCPVbmycZL/RmNKZUw5e6zLnd4YCJ
   hmHp4YfNyJgJkj5JTrhj63bpSRRv87k1s3W2YHLiDwBDiQOHJmbHZF45d
   9f3KR8Uj2wXZ3/7qZaBqh4iLKwTo0J3P7nJFJzyAEbDdWM7/+AgdAbq4A
   tG8ZIEYH2DLy5hQa9G8RtoLs3kCYynW0OtwgUR2IxuBO7NUBTFJlWmElo
   QW9J6cSKefIr5I3gBdH97K8lm3XQADZxJ1zYnecc7zXXeAMUuTJFuS23X
   yfvxPonX4IplF3rJQyvEXqrhje6TtU+ak22caa7MejbFU6kIRFjllJUf2
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="297338009"
X-IronPort-AV: E=Sophos;i="5.96,186,1665471600"; 
   d="scan'208";a="297338009"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 20:44:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="641657617"
X-IronPort-AV: E=Sophos;i="5.96,186,1665471600"; 
   d="scan'208";a="641657617"
Received: from lkp-server01.sh.intel.com (HELO 64a2d449c951) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 22 Nov 2022 20:44:51 -0800
Received: from kbuild by 64a2d449c951 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oxhcw-0002Ft-2l;
        Wed, 23 Nov 2022 04:44:50 +0000
Date:   Wed, 23 Nov 2022 12:43:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/fpu] BUILD SUCCESS
 55228db2697c09abddcb9487c3d9fa5854a932cd
Message-ID: <637da507.kAujvVz3h9tcDqym%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/fpu
branch HEAD: 55228db2697c09abddcb9487c3d9fa5854a932cd  x86/fpu: Use _Alignof to avoid undefined behavior in TYPE_ALIGN

elapsed time: 723m

configs tested: 62
configs skipped: 66

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-syz
x86_64                           rhel-8.3-kvm
x86_64                         rhel-8.3-kunit
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                            allnoconfig
i386                             allyesconfig
i386                                defconfig
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
x86_64                              defconfig
ia64                             allmodconfig
s390                             allyesconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
x86_64               randconfig-a011-20221121
x86_64               randconfig-a014-20221121
x86_64               randconfig-a012-20221121
x86_64               randconfig-a013-20221121
x86_64               randconfig-a016-20221121
x86_64               randconfig-a015-20221121
x86_64                               rhel-8.3
x86_64                           allyesconfig
i386                 randconfig-a014-20221121
i386                 randconfig-a011-20221121
i386                 randconfig-a013-20221121
i386                 randconfig-a016-20221121
i386                 randconfig-a012-20221121
i386                 randconfig-a015-20221121
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
s390                 randconfig-r044-20221121
riscv                randconfig-r042-20221121
arc                  randconfig-r043-20221120
arc                  randconfig-r043-20221121
i386                          randconfig-c001
arm                                 defconfig
arm                              allyesconfig

clang tested configs:
x86_64                        randconfig-k001
powerpc                    gamecube_defconfig
x86_64               randconfig-a002-20221121
x86_64               randconfig-a001-20221121
x86_64               randconfig-a004-20221121
x86_64               randconfig-a006-20221121
x86_64               randconfig-a005-20221121
x86_64               randconfig-a003-20221121
powerpc                 mpc832x_rdb_defconfig
mips                     cu1000-neo_defconfig
i386                 randconfig-a001-20221121
i386                 randconfig-a005-20221121
i386                 randconfig-a006-20221121
i386                 randconfig-a004-20221121
i386                 randconfig-a003-20221121
i386                 randconfig-a002-20221121

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
