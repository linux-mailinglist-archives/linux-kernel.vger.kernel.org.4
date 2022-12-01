Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D097963ED60
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 11:14:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiLAKOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 05:14:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbiLAKO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 05:14:26 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C94E92098
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 02:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669889665; x=1701425665;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=wA2Uz06XL5tnvE6M7e3+7dWUYC+5nwFKRKZMZcnoMPQ=;
  b=lVGnKeE6Use0nS7yrHgRk00NZQPalcMigmRsbW+leEWTGb9MkMtD3/03
   E4gqS+QCX2pZdVshu3rdLjH+aP/+3gfeZS+8bJAsLGnKj2bOmYT9ELogZ
   s6VCC6g4rzJHxy62j+ut52Y9Hy1xEaAzB71GOBvEbHH9//EbZEUsc9FT2
   krDPSXPhju7mcH7QAQ5uAXh17WpxZECHJmeqCx4/U7+WgSYtigVJhf/Oq
   rxeWQSpj80asf3YNr2Io8tbCeiiuYx6J66qm34i55B04ikXZJ1UwVUIvB
   CglvNURjkRL1OzI2hYgr7fusLqCU1x/kuQyWhUjEtrK6MoJHX1BtQXTtK
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="299014939"
X-IronPort-AV: E=Sophos;i="5.96,209,1665471600"; 
   d="scan'208";a="299014939"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 02:14:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="675382114"
X-IronPort-AV: E=Sophos;i="5.96,209,1665471600"; 
   d="scan'208";a="675382114"
Received: from lkp-server01.sh.intel.com (HELO 64a2d449c951) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 01 Dec 2022 02:14:21 -0800
Received: from kbuild by 64a2d449c951 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p0gaC-000CRs-11;
        Thu, 01 Dec 2022 10:14:20 +0000
Date:   Thu, 01 Dec 2022 18:13:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:lazy-obsolete.2022.11.30a] BUILD SUCCESS
 45b1f52e5e9772ee4aa7e83af8f98328ead684fa
Message-ID: <63887e50.GlkCZ503e8qqSyZi%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git lazy-obsolete.2022.11.30a
branch HEAD: 45b1f52e5e9772ee4aa7e83af8f98328ead684fa  rxrpc: Use call_rcu_hurry() instead of call_rcu()

elapsed time: 730m

configs tested: 47
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                            allnoconfig
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
s390                             allyesconfig
x86_64                               rhel-8.3
um                             i386_defconfig
powerpc                           allnoconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
x86_64                           allyesconfig
ia64                             allmodconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
sh                               allmodconfig
mips                             allyesconfig
powerpc                          allmodconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                             allyesconfig
i386                                defconfig

clang tested configs:
s390                 randconfig-r044-20221128
hexagon              randconfig-r041-20221128
riscv                randconfig-r042-20221128
hexagon              randconfig-r045-20221128
x86_64               randconfig-k001-20221128
x86_64               randconfig-a011-20221128
x86_64               randconfig-a014-20221128
x86_64               randconfig-a012-20221128
x86_64               randconfig-a013-20221128
x86_64               randconfig-a016-20221128
x86_64               randconfig-a015-20221128
i386                 randconfig-a014-20221128
i386                 randconfig-a011-20221128
i386                 randconfig-a013-20221128
i386                 randconfig-a016-20221128
i386                 randconfig-a012-20221128
i386                 randconfig-a015-20221128

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
