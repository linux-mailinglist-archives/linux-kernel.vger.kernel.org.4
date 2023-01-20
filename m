Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEF0C6756FC
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 15:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbjATOXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 09:23:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbjATOXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 09:23:35 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92CE3C34
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 06:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674224588; x=1705760588;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=yyvap2m089nb/wIzUhfuywy7CrFdmLRORzbyv5c9zXQ=;
  b=FdNfcrqPS9UjD2nmACFi3345+QU30LLq0ukVfNw35OfXCKdPgdU4ia3X
   LgbsvfbPhKhb7owtXAL4PdbYeFchN4lOXbgBOSZogzZNdZ6cfTfRnumWb
   qkArOGu+x+i+WntNpGVxUWWgVkLKcYuZ54ojegJlSyFhqdwB+n5R9MadW
   WfPa1wxnciuNiDMtMIg9UlLrX+cixHAOwKvRwX2ERbVAlhO7zwz0Jiudl
   Vdt8Vph0vB9m4tUzPJaYFNK9X2tTuJ7u4SGGN3AI2/N/v5oYF0AU98DCs
   LM4wJGV2cP2yHfszUXyY7+RIZBY0OxhBPHAUVO5q2+p2XW0l19/e9Q9XT
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="324268956"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="324268956"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 06:21:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="905978499"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="905978499"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 20 Jan 2023 06:21:11 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pIsGP-0002cS-1E;
        Fri, 20 Jan 2023 14:21:05 +0000
Date:   Fri, 20 Jan 2023 22:20:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:glacialnmi.2023.01.19a] BUILD SUCCESS
 1fe673c8244052670796657542a8622313b88574
Message-ID: <63caa328.Yn9cvGjyYVetsETj%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git glacialnmi.2023.01.19a
branch HEAD: 1fe673c8244052670796657542a8622313b88574  x86/nmi: Test commit for severely delayed NMI handlers

elapsed time: 795m

configs tested: 65
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
arc                                 defconfig
x86_64                           rhel-8.3-syz
x86_64                           allyesconfig
alpha                               defconfig
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
ia64                             allmodconfig
x86_64                           rhel-8.3-bpf
i386                          randconfig-a001
i386                          randconfig-a003
m68k                             allmodconfig
powerpc                           allnoconfig
m68k                             allyesconfig
sh                               allmodconfig
mips                             allyesconfig
arc                              allyesconfig
i386                          randconfig-a005
i386                          randconfig-a014
alpha                            allyesconfig
powerpc                          allmodconfig
s390                                defconfig
arm                                 defconfig
i386                          randconfig-a012
s390                             allmodconfig
i386                          randconfig-a016
i386                                defconfig
i386                             allyesconfig
s390                             allyesconfig
x86_64                    rhel-8.3-kselftests
arm64                            allyesconfig
x86_64                          rhel-8.3-func
x86_64                        randconfig-a004
arm                              allyesconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
arm                  randconfig-r046-20230119
x86_64                        randconfig-a002
arc                  randconfig-r043-20230119
x86_64                        randconfig-a015
x86_64                        randconfig-a006
ia64                             alldefconfig
powerpc                        warp_defconfig

clang tested configs:
i386                          randconfig-a002
i386                          randconfig-a013
i386                          randconfig-a004
i386                          randconfig-a011
i386                          randconfig-a006
i386                          randconfig-a015
x86_64                          rhel-8.3-rust
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-a012
x86_64                        randconfig-a005
hexagon              randconfig-r045-20230119
x86_64                        randconfig-a001
hexagon              randconfig-r041-20230119
x86_64                        randconfig-a003
riscv                randconfig-r042-20230119
s390                 randconfig-r044-20230119
riscv                             allnoconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
