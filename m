Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B26C64E721
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 06:53:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbiLPFx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 00:53:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbiLPFxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 00:53:25 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1501554458
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 21:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671170003; x=1702706003;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=WLWHglAhkqCifPwvRuVp0vusT4+KWLSJIOmFdoJ/uyE=;
  b=l12hjpCezzpEaYT+g02VwbjsVDC7/PkbIxW/dIm3cNNIlugs5jf3KmDE
   lvApqt8Fzq5tmDADRceql0PJrboiaANXS355WdKs6KXeFeaf6h8Ac8xLo
   5fe8Zlq9ab0JdK0Y5fJuJvvrONB+NvVra5nM4ZP2Ixy+rWMenK9J7dp4v
   47JoB45ksrA2Zas9EBnyWDYgZa0Xr8VtPo/Kivc9GFhV4wWFC+tDmRjsL
   Kw5CPXy/FK0AjEKXFPn3IkucNoE5BUTTVHVFlSnF7w+YOLsMpqaqfJbJ4
   wzwjdFmeDCPR4RfaZAAYLorOURBgSFrFv0/K2HokDpa5vKHyiYNKIVdg6
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="405152267"
X-IronPort-AV: E=Sophos;i="5.96,249,1665471600"; 
   d="scan'208";a="405152267"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2022 21:53:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="649692615"
X-IronPort-AV: E=Sophos;i="5.96,249,1665471600"; 
   d="scan'208";a="649692615"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 15 Dec 2022 21:53:21 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p63eq-0006xS-1X;
        Fri, 16 Dec 2022 05:53:20 +0000
Date:   Fri, 16 Dec 2022 13:52:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:rostedt.2022.12.15a] BUILD SUCCESS
 4624173b63aaaf7230b66fe6d080f7cbcff51597
Message-ID: <639c07af.Q654WTjf944b/8R5%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rostedt.2022.12.15a
branch HEAD: 4624173b63aaaf7230b66fe6d080f7cbcff51597  rcu: Dump rcu_init_invoked() in favor of rcu_scheduler_active

elapsed time: 733m

configs tested: 62
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
alpha                               defconfig
um                             i386_defconfig
um                           x86_64_defconfig
powerpc                           allnoconfig
s390                             allmodconfig
s390                                defconfig
ia64                             allmodconfig
sh                               allmodconfig
mips                             allyesconfig
powerpc                          allmodconfig
s390                             allyesconfig
m68k                             allmodconfig
x86_64                        randconfig-a004
arc                              allyesconfig
x86_64                        randconfig-a002
alpha                            allyesconfig
arc                  randconfig-r043-20221215
arm                  randconfig-r046-20221215
i386                          randconfig-a001
x86_64                        randconfig-a006
m68k                             allyesconfig
i386                          randconfig-a014
arm                                 defconfig
i386                          randconfig-a003
i386                          randconfig-a012
i386                          randconfig-a005
i386                          randconfig-a016
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
arm64                            allyesconfig
arm                              allyesconfig
x86_64                            allnoconfig
x86_64                               rhel-8.3
x86_64                           rhel-8.3-bpf
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
i386                                defconfig
x86_64                              defconfig
i386                             allyesconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                           allyesconfig

clang tested configs:
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a013
hexagon              randconfig-r041-20221215
i386                          randconfig-a011
hexagon              randconfig-r045-20221215
riscv                randconfig-r042-20221215
i386                          randconfig-a002
s390                 randconfig-r044-20221215
i386                          randconfig-a004
i386                          randconfig-a015
x86_64                        randconfig-a014
i386                          randconfig-a006
x86_64                        randconfig-a016
x86_64                        randconfig-a012
x86_64                          rhel-8.3-rust

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
