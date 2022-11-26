Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE188639900
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 00:50:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiKZXuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 18:50:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiKZXuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 18:50:18 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68BD013E0D
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 15:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669506617; x=1701042617;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=IF/O4yy28CbthxSzZjiQdq+ft6SJ4rqV3EqY8uH3ZSw=;
  b=mviX9ZME8+Jn+7Kgv9GkV8333qat1LCLcdNp1ASKbFyt2v82MWw0rNOr
   wRSYrfZ1WoZIk0fg1tIm+hikdGO875NycLbVwAUd8vtnCD93+RqbfMg8x
   A2GlzrORwevoyEXpvuDaqUcYxnWKezGqQIAFB15XgmU5bVq2NF9SuoqHc
   rNAU97A0iJKNsnP8gxePdTb6IJu0Mjt4X+WzbehRXyFpVKLWEm6kVLQsN
   5JJwqmSrAo5vxPKMWEcK11QKdQjR887zzXhh/EKapbDAegZfwZd4BkVle
   v8qh2sFLMXLtItHSmgvSBHB9FyCnkGZF87iR473id/p5KSZOn4Ki1Ae+K
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10543"; a="316456054"
X-IronPort-AV: E=Sophos;i="5.96,197,1665471600"; 
   d="scan'208";a="316456054"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2022 15:50:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10543"; a="785235508"
X-IronPort-AV: E=Sophos;i="5.96,197,1665471600"; 
   d="scan'208";a="785235508"
Received: from lkp-server01.sh.intel.com (HELO 64a2d449c951) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 26 Nov 2022 15:50:15 -0800
Received: from kbuild by 64a2d449c951 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oz4w3-0006eb-0l;
        Sat, 26 Nov 2022 23:50:15 +0000
Date:   Sun, 27 Nov 2022 07:49:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/boot] BUILD SUCCESS
 f1e525009493cbd569e7c8dd7d58157855f8658d
Message-ID: <6382a5fd.O1rlnIskUEGCxC48%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/boot
branch HEAD: f1e525009493cbd569e7c8dd7d58157855f8658d  x86/boot: Skip realmode init code when running as Xen PV guest

elapsed time: 2189m

configs tested: 58
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                  randconfig-r043-20221124
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
x86_64                           rhel-8.3-kvm
ia64                             allmodconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
s390                                defconfig
s390                             allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
mips                             allyesconfig
sh                               allmodconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allyesconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
x86_64                        randconfig-a002
x86_64                              defconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
i386                          randconfig-a001
i386                          randconfig-a003
x86_64                               rhel-8.3
i386                          randconfig-a005
x86_64                           allyesconfig
i386                                defconfig
i386                             allyesconfig
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
arm                                 defconfig
arm                              allyesconfig
arm64                            allyesconfig

clang tested configs:
riscv                randconfig-r042-20221124
hexagon              randconfig-r041-20221124
hexagon              randconfig-r045-20221124
s390                 randconfig-r044-20221124
x86_64                        randconfig-a014
x86_64                        randconfig-a012
x86_64                        randconfig-a016
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
