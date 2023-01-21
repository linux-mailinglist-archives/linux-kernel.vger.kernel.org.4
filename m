Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2BA3676400
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 06:33:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjAUFdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 00:33:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjAUFc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 00:32:59 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE058695
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 21:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674279177; x=1705815177;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=X6e48vkqBKMdXlPSYbRcUNKXJKmO1q5g9aGGKyK9fUo=;
  b=dve9u13LjDmguO5ItJuPDiTmYGTCGU7pd5bF3P4lTmFBk7RYR/Nh0mMF
   vBCn4nSePBSVos2V+l2IFadsubWx5acFAVMQsau+vRRucC4NxOFFhATBx
   ZwoxQpakudcLlUfESxC/LmBM0it1hx0b836h6xh5ldor0dU8tyn5PMWbX
   XvvBojSSDuLbRIAmqZjly8cxnJJrTLLH605CdpzyfX7ii8hGBknt0ITal
   rhhLGTAjNQhfRVV/LTcIgpJmMadLvYVm25YXnpXtBqYRgBDGlDC5v6kOA
   2JR0Lme+hhhcP6RS/Qzq/TJkt6FxIAezB/CCPa48Haxq7pzqW6StvK2V5
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="313650531"
X-IronPort-AV: E=Sophos;i="5.97,234,1669104000"; 
   d="scan'208";a="313650531"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 21:32:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="654017565"
X-IronPort-AV: E=Sophos;i="5.97,234,1669104000"; 
   d="scan'208";a="654017565"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 20 Jan 2023 21:32:55 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pJ6Uo-0003Z9-1q;
        Sat, 21 Jan 2023 05:32:54 +0000
Date:   Sat, 21 Jan 2023 13:32:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 1642cea9d9ab82b596857eea14bf6e04806a6c5a
Message-ID: <63cb7901.7tFX5sGQPpUrSCCw%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git master
branch HEAD: 1642cea9d9ab82b596857eea14bf6e04806a6c5a  Merge x86/fpu into tip/master

elapsed time: 906m

configs tested: 62
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
arc                                 defconfig
powerpc                           allnoconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
x86_64                              defconfig
arm                  randconfig-r046-20230119
arc                  randconfig-r043-20230119
s390                             allyesconfig
x86_64                        randconfig-a004
x86_64                               rhel-8.3
x86_64                        randconfig-a006
x86_64                        randconfig-a002
arm                                 defconfig
i386                          randconfig-a001
i386                          randconfig-a003
ia64                             allmodconfig
x86_64                           rhel-8.3-syz
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-bpf
x86_64                        randconfig-a013
x86_64                         rhel-8.3-kunit
x86_64                        randconfig-a011
i386                          randconfig-a005
x86_64                           allyesconfig
arm64                            allyesconfig
arm                              allyesconfig
x86_64                        randconfig-a015
sh                               allmodconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
mips                             allyesconfig
i386                          randconfig-a014
i386                          randconfig-a012
i386                                defconfig
i386                          randconfig-a016
i386                             allyesconfig
powerpc                          allmodconfig

clang tested configs:
x86_64                          rhel-8.3-rust
hexagon              randconfig-r045-20230119
hexagon              randconfig-r041-20230119
s390                 randconfig-r044-20230119
riscv                randconfig-r042-20230119
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a002
i386                          randconfig-a004
x86_64                        randconfig-a005
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a006
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
