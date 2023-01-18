Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C49D2672D38
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 00:59:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbjARX7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 18:59:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbjARX64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 18:58:56 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 742683EFC1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 15:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674086307; x=1705622307;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=hmAcHC4BHlzCS9i2mn8UCPq4MeeLlCDGtEx6FNABRo0=;
  b=VyV5LuFYmjLmEaXGfmntZc7qadlktW+AmJjz2dODNB1Li3HnDvRkI02V
   1p/iPAxwZlwXqqitor2XtHXYHldrIEPtTFSyjFx8PDng3SQAF7HXIFGO+
   PiJ138Cwja5+q5IsBPN+R8RI4rP72Z/SljAmOgv+7Z71Z4GgLZybOQPX3
   xExQ73XXFJiJ6od01rxcUfr+0kqqiI1AeBbsLy9TqDrmp4t5w398Z7zOo
   T5yN3UdPnQHNkEPzKf+snSV5ObGsV5kvMUYXVxKhFEfpbQkR1/qe6RMvm
   Hj7TrQUG0jZu4UvPvf3D8L5V4/kLQ3nxTCMsAgh+mamA6UtBvFBoJ7plW
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="323824330"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="323824330"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 15:58:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="659987691"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="659987691"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 18 Jan 2023 15:58:25 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pIIJv-0000pk-2M;
        Wed, 18 Jan 2023 23:58:19 +0000
Date:   Thu, 19 Jan 2023 07:57:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 b7a46a47bcea9214cb561132381c8f1e61854796
Message-ID: <63c8877e.3aWOp9oy7WeAErEr%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: b7a46a47bcea9214cb561132381c8f1e61854796  Merge branch into tip/master: 'perf/urgent'

elapsed time: 728m

configs tested: 62
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
x86_64                            allnoconfig
um                           x86_64_defconfig
arc                                 defconfig
alpha                               defconfig
s390                                defconfig
s390                             allmodconfig
arm                                 defconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-bpf
s390                             allyesconfig
x86_64                              defconfig
x86_64                         rhel-8.3-kunit
alpha                            allyesconfig
x86_64                           rhel-8.3-syz
arc                              allyesconfig
ia64                             allmodconfig
x86_64                               rhel-8.3
m68k                             allmodconfig
i386                                defconfig
m68k                             allyesconfig
arm64                            allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
mips                             allyesconfig
arm                              allyesconfig
x86_64                           allyesconfig
sh                               allmodconfig
arc                  randconfig-r043-20230118
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
s390                 randconfig-r044-20230118
riscv                randconfig-r042-20230118
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                             allyesconfig
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006

clang tested configs:
x86_64                          rhel-8.3-rust
hexagon              randconfig-r045-20230118
hexagon              randconfig-r041-20230118
arm                  randconfig-r046-20230118
x86_64                        randconfig-a014
x86_64                        randconfig-a012
x86_64                        randconfig-a016
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
