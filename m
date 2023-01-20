Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3F8A6756F4
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 15:22:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbjATOWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 09:22:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbjATOWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 09:22:09 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0C3CC5FE
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 06:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674224496; x=1705760496;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=JThjR5dXYGW4+gQ6WVX42iVrJdqO7YwZWhVxiprg5iU=;
  b=iyh865DWKY/qivs9VFwySF/OouZ6KVj77asio+5pZ+2xMwI1lOdoBFaA
   xUMjxRG+orylLuGoCreBE7wUv6BsNSn/ve95JGa8p3fmid+sCWXJ1uZth
   l/08J00SKN3Plmcfc5h9Y9qOWSQtIOrGullxqtvK7Piia+T59lX9UW3uP
   dmarWN5chf8N472fRmtm0C0S//6e4EN5h7B3skEQ6U5jGfcRTNCWX/gGK
   0/MHgKiltKl7KijVlP36l1DVHxp+PfIv0WHNL5tdzS4QzP0fWUzOCrjxj
   liB2xZX5M526RczudiiTH0X1Ikdk/mGkLV9tUeXeWCAeuQu69eT5UcDIf
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="326864400"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="326864400"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 06:21:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="749349284"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="749349284"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Jan 2023 06:21:11 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pIsGP-0002cQ-1A;
        Fri, 20 Jan 2023 14:21:05 +0000
Date:   Fri, 20 Jan 2023 22:20:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:haltnmi2.2023.01.19a] BUILD SUCCESS
 0c20db06cbde4a1a9faa9738b22e477736b64489
Message-ID: <63caa32b.goIf482Wf6YT6CM9%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git haltnmi2.2023.01.19a
branch HEAD: 0c20db06cbde4a1a9faa9738b22e477736b64489  x86/nmi: Test commit for exc_nmi handler not being reached

elapsed time: 794m

configs tested: 65
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
alpha                            allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
x86_64                               rhel-8.3
m68k                             allyesconfig
ia64                             allmodconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
arm                                 defconfig
x86_64                           allyesconfig
arc                                 defconfig
s390                             allmodconfig
powerpc                           allnoconfig
sh                               allmodconfig
mips                             allyesconfig
alpha                               defconfig
i386                          randconfig-a001
i386                          randconfig-a003
arm                  randconfig-r046-20230119
s390                                defconfig
arc                  randconfig-r043-20230119
i386                          randconfig-a005
s390                             allyesconfig
i386                                defconfig
arm64                            allyesconfig
powerpc                          allmodconfig
arm                              allyesconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-bpf
i386                             allyesconfig
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
ia64                             alldefconfig
powerpc                        warp_defconfig

clang tested configs:
x86_64                          rhel-8.3-rust
i386                          randconfig-a002
i386                          randconfig-a004
hexagon              randconfig-r045-20230119
hexagon              randconfig-r041-20230119
riscv                randconfig-r042-20230119
s390                 randconfig-r044-20230119
i386                          randconfig-a006
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
riscv                             allnoconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
