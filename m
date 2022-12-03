Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D936641356
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 03:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235135AbiLCC1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 21:27:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235098AbiLCC1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 21:27:38 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD27658D
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 18:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670034458; x=1701570458;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=2c3hf/HHfr577jmshikdBUjbXYPD2FvwfDeEvYKmb/M=;
  b=YC2zSspQuXE4MK+IsTRyhwPxcEpSb8G8frezMppALtZmKy6ctA9yudnN
   pRFQ+ou3aKR+fC1ygYXa9A/X494GEyLnDlMl7x5DQVXS6IYELsrXlcy0M
   ZF6/hNTbb116kAg/7sPG96oXjllewusq3NO5r8RtSWOEnk4nlL0bwGkQQ
   ngK/ZaZX+u6unHmoq0BeaZgpd8vD4YAEbdQqtbIP31OQY+2wjmzTULL6t
   26baFtYJ/eKL9dYpqgxgYkEA1kl2WhHqOZQ9Q6NW3QzpW3gHbuI0rPrOY
   8UYpyj0LfIkTezKnRg/oV/Ps4eoEwDpJuiVTsiXVCh4V2Dlm3DVN1nTol
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="314793921"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="314793921"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 18:27:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="645231545"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="645231545"
Received: from lkp-server01.sh.intel.com (HELO 64a2d449c951) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 02 Dec 2022 18:27:36 -0800
Received: from kbuild by 64a2d449c951 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p1IFb-000EDH-2L;
        Sat, 03 Dec 2022 02:27:35 +0000
Date:   Sat, 03 Dec 2022 10:27:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/apic] BUILD SUCCESS
 2833275568755eb937a52c358bf8bfa7125a463e
Message-ID: <638ab401.4D/DJxiD1+Z2BTry%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/apic
branch HEAD: 2833275568755eb937a52c358bf8bfa7125a463e  x86/of: Add support for boot time interrupt delivery mode configuration

elapsed time: 734m

configs tested: 60
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
powerpc                           allnoconfig
arc                                 defconfig
s390                             allmodconfig
alpha                            allyesconfig
alpha                               defconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
s390                                defconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
x86_64                              defconfig
s390                             allyesconfig
sh                               allmodconfig
x86_64                               rhel-8.3
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                        randconfig-a004
powerpc                          allmodconfig
x86_64                        randconfig-a002
mips                             allyesconfig
ia64                             allmodconfig
x86_64                           allyesconfig
x86_64                        randconfig-a006
i386                          randconfig-a001
i386                          randconfig-a003
arc                  randconfig-r043-20221201
i386                          randconfig-a005
riscv                randconfig-r042-20221201
s390                 randconfig-r044-20221201
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                                defconfig
i386                             allyesconfig
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
x86_64                            allnoconfig
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig

clang tested configs:
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a002
i386                          randconfig-a004
hexagon              randconfig-r045-20221201
hexagon              randconfig-r041-20221201
i386                          randconfig-a006
x86_64                        randconfig-a014
x86_64                        randconfig-a012
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
