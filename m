Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81E726388E5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 12:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbiKYLiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 06:38:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiKYLiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 06:38:21 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE6DE13F71
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 03:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669376300; x=1700912300;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=PZa8n6wuqbAxogj6x08qx/l18Gehpyf/GDqNhEvFH40=;
  b=AtPIkv9OXHf+tLMWNKlEFkxN1yjzkjqnfvX/u8+/ikFBeWhvsS1Bk58F
   sODjU/5CSGKxsk8KgFXBB+ZHNEFJa9m3HFXCiXDo1+Fc3KDojfZTt/f1N
   FT4uNygstPTFZ/RrrD5POmyfqWYsveTWPt62Ld9bgpBLTT9RDBVoMntK3
   S2GTzaD8ECm4bIlbjSNpLNfHYm1HO6bnB9yyQzQ0Bjgn/wtjiIF6Ybdnv
   UldA8kS9t7OAOVOZMnxCIocL0c/GGto53LLtc1W6GkV28n7JSMbwxBsQY
   FcepgIM5tm0xhGOzsxlMB8O7NEwI3q21JjvCDvUOnWQBFmBnn2EXDiYcr
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10541"; a="294169250"
X-IronPort-AV: E=Sophos;i="5.96,193,1665471600"; 
   d="scan'208";a="294169250"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2022 03:38:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10541"; a="817118437"
X-IronPort-AV: E=Sophos;i="5.96,193,1665471600"; 
   d="scan'208";a="817118437"
Received: from lkp-server01.sh.intel.com (HELO 64a2d449c951) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 25 Nov 2022 03:38:19 -0800
Received: from kbuild by 64a2d449c951 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oyX2A-000557-27;
        Fri, 25 Nov 2022 11:38:18 +0000
Date:   Fri, 25 Nov 2022 19:37:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2022.11.23a] BUILD SUCCESS
 470a9dfff0c42688cc81b7b2226baaa5bd4354ce
Message-ID: <6380a8fa.Zzp06W/Ujpjzkmx7%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2022.11.23a
branch HEAD: 470a9dfff0c42688cc81b7b2226baaa5bd4354ce  squash! rcu: Make SRCU mandatory

elapsed time: 2223m

configs tested: 56
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
powerpc                           allnoconfig
powerpc                          allmodconfig
mips                             allyesconfig
sh                               allmodconfig
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
alpha                               defconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
m68k                             allyesconfig
s390                                defconfig
s390                             allmodconfig
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
ia64                             allmodconfig
s390                             allyesconfig
alpha                            allyesconfig
arc                              allyesconfig
m68k                             allmodconfig
arc                  randconfig-r043-20221124
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                               rhel-8.3
x86_64                              defconfig
x86_64                           allyesconfig
i386                                defconfig
i386                             allyesconfig
arm                                 defconfig
arm64                            allyesconfig

clang tested configs:
hexagon              randconfig-r041-20221124
hexagon              randconfig-r045-20221124
s390                 randconfig-r044-20221124
riscv                randconfig-r042-20221124
i386                          randconfig-a013
i386                          randconfig-a011
x86_64                        randconfig-a016
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
