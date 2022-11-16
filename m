Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E508E62CDA1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 23:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233407AbiKPW2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 17:28:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231734AbiKPW2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 17:28:23 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0CBE1E3CF
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 14:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668637702; x=1700173702;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=zYhWK6s+MA6ZW3EiOEX0ISJz6ny04P6Ge7eJtKRdsEU=;
  b=RSDitfn6vzxz9DrLtZQ7hsJXUlRPDc4xTSh1XIU7ABFmJVIyjHE1stm4
   qFbau8iXtT5ffdNJKkAkMsydl7TB+krUg/gkAnbkIG9rK76iCGRsI0AN2
   KCiKq0TO2VrCDOS65lodji8vMTz9cPPULPF4RlmkE8KI7Wq7Ycp/EK0GE
   OE2hLPM3RCz37JygZgucx+UpTHzJGX1elwv0sDW7USnUKSn1nEEX5Gy9z
   dXvqp+cX0wjukrty6Xxg/kdxXVvXsx2aXl+tVywjH/iunGB2zpFy1nQqw
   Hiy9TGXSsMhYAE8SAa6TsyfRHln6LIPBE41l8Wq5HX3Mj8HO0GsYZwJ/e
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="296050100"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="296050100"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 14:28:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="764504110"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="764504110"
Received: from lkp-server01.sh.intel.com (HELO ebd99836cbe0) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 16 Nov 2022 14:28:21 -0800
Received: from kbuild by ebd99836cbe0 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ovQtI-0002nJ-1P;
        Wed, 16 Nov 2022 22:28:20 +0000
Date:   Thu, 17 Nov 2022 06:27:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 b1206a1493aaa4863be125bff7ccc336f6fa238b
Message-ID: <637563e4.yGypm0jzfAAuLHh1%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: b1206a1493aaa4863be125bff7ccc336f6fa238b  Merge branch 'linus/master' into tip/master

elapsed time: 721m

configs tested: 58
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
um                             i386_defconfig
um                           x86_64_defconfig
s390                             allyesconfig
arm                                 defconfig
i386                                defconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
ia64                             allmodconfig
alpha                            allyesconfig
arc                              allyesconfig
i386                          randconfig-a014
i386                          randconfig-a012
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
m68k                             allyesconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
m68k                             allmodconfig
x86_64                           rhel-8.3-kvm
powerpc                           allnoconfig
i386                          randconfig-a016
powerpc                          allmodconfig
arm                              allyesconfig
mips                             allyesconfig
arm64                            allyesconfig
sh                               allmodconfig
i386                             allyesconfig
x86_64                              defconfig
arc                  randconfig-r043-20221116
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                               rhel-8.3
x86_64                        randconfig-a011
x86_64                           allyesconfig
x86_64                        randconfig-a015

clang tested configs:
i386                          randconfig-a013
i386                          randconfig-a011
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a015
hexagon              randconfig-r041-20221116
hexagon              randconfig-r045-20221116
riscv                randconfig-r042-20221116
s390                 randconfig-r044-20221116
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
