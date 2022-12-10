Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81568648C89
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 03:33:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbiLJCdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 21:33:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiLJCdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 21:33:41 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E0525E94
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 18:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670639620; x=1702175620;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=WxMm/W4M1XY6Gpa4o/4tgsQtU49bCd4HCCwi99eBTLs=;
  b=k7AEZVMUCbAZ9AcZmPVWAweU/rMLKLaVB2Zdab1MuixcpYyl1MPSBN1x
   1x6Pi3ZjvibaJ4ttF7s5untiwS0SFPfoYFJ5j31Z8bv2WkMmjTLL76XCo
   /oJAolG+wkZFTINtoYD+yfXpEj1OAepM/25D3SL805b60Df02VFoHSS/v
   3Pdg+9sXPsdb6Zc2dIJSJejmcGygy7af8SmdiRnvY3aLnuAJswbGA6vKI
   cLOq+WsjqAumMHubOFU5YU4mA1QLXdGDDfHMpJX85nC+kWqeqay/uPvMz
   mvdgpstFCMR7OXQpJFkKbcGoTZTThP3N0Oy71koEFLTifo2gUtxr+6AQI
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10556"; a="379798745"
X-IronPort-AV: E=Sophos;i="5.96,232,1665471600"; 
   d="scan'208";a="379798745"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2022 18:33:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10556"; a="647591379"
X-IronPort-AV: E=Sophos;i="5.96,232,1665471600"; 
   d="scan'208";a="647591379"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 09 Dec 2022 18:33:38 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p3pgH-0002Dv-37;
        Sat, 10 Dec 2022 02:33:37 +0000
Date:   Sat, 10 Dec 2022 10:33:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 45be2ad007a9c6bea70249c4cf3e4905afe4caeb
Message-ID: <6393effe.PC0syOktlilIde3z%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: 45be2ad007a9c6bea70249c4cf3e4905afe4caeb  x86/vdso: Conditionally export __vdso_sgx_enter_enclave()

elapsed time: 726m

configs tested: 59
configs skipped: 80

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                              defconfig
i386                          randconfig-a001
i386                          randconfig-a003
x86_64                          rhel-8.3-rust
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
i386                          randconfig-a005
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-bpf
x86_64                           rhel-8.3-syz
i386                                defconfig
x86_64                         rhel-8.3-kunit
x86_64                           allyesconfig
x86_64                           rhel-8.3-kvm
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
i386                          randconfig-a014
i386                          randconfig-a012
x86_64                        randconfig-a013
x86_64                        randconfig-a011
i386                          randconfig-a016
x86_64                        randconfig-a015
i386                             allyesconfig
x86_64                            allnoconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
arc                  randconfig-r043-20221209
riscv                randconfig-r042-20221209
s390                 randconfig-r044-20221209
um                           x86_64_defconfig
um                             i386_defconfig
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
s390                             allyesconfig

clang tested configs:
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a013
x86_64                        randconfig-a014
x86_64                        randconfig-a005
i386                          randconfig-a011
x86_64                        randconfig-a012
x86_64                        randconfig-a016
i386                          randconfig-a015
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
