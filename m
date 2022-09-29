Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF4915EFF16
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 23:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbiI2VJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 17:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbiI2VJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 17:09:26 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B5801C4312
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 14:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664485743; x=1696021743;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=24rjSbCHah3Iyk7bbyfKsPd7YTjJlFZDXU0qv8m43hY=;
  b=DTugGL9exA5gcOyYnXnxiLVjABxMx03ufQVBx3lEaGzD3wnGYXMb7KX0
   JOJiDFHjNCQ99vmXiZ6r7NNUqb9kYyTESk1BsI6B8o3dz6aVjhwMcsMJE
   ijYXLCAWw4YfYZIe+w0tMiBPyeMtFkDy9VIVAY9udw3DO9aGOH5Mpw5Mq
   eo6y+1Bp9UqX7IKNW1EMv2q/AXKKefOHhone84LcgXdLjTANiDF0hTbN2
   aZz59yG+T/ZCb6OPGJOqOJy8pfD0fN28V9J1MqPcZb0r0+Yvzx9Twp44V
   inkyDwXesDOh8pZl1zYnG/Vk9VNMN3YHzaUhDVfdIvAYlIGTgIxhC4m3u
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="388302848"
X-IronPort-AV: E=Sophos;i="5.93,356,1654585200"; 
   d="scan'208";a="388302848"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 14:08:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="655712290"
X-IronPort-AV: E=Sophos;i="5.93,356,1654585200"; 
   d="scan'208";a="655712290"
Received: from lkp-server01.sh.intel.com (HELO 6126f2790925) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 29 Sep 2022 14:08:20 -0700
Received: from kbuild by 6126f2790925 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oe0lY-0001ec-0H;
        Thu, 29 Sep 2022 21:08:20 +0000
Date:   Fri, 30 Sep 2022 05:08:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 df5b035b5683d6a25f077af889fb88e09827f8bc
Message-ID: <63360930.YgT3Yp+H6RLpvUUs%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: df5b035b5683d6a25f077af889fb88e09827f8bc  x86/cacheinfo: Add a cpu_llc_shared_mask() UP variant

elapsed time: 722m

configs tested: 77
configs skipped: 97

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                          rhel-8.3-func
i386                                defconfig
x86_64                              defconfig
x86_64                    rhel-8.3-kselftests
x86_64                               rhel-8.3
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                           allyesconfig
i386                             allyesconfig
i386                 randconfig-a001-20220926
i386                 randconfig-a002-20220926
i386                 randconfig-a003-20220926
i386                 randconfig-a004-20220926
i386                 randconfig-a005-20220926
i386                 randconfig-a006-20220926
x86_64                        randconfig-a002
x86_64                        randconfig-a004
x86_64                        randconfig-a006
um                           x86_64_defconfig
um                             i386_defconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
arm                         s3c6400_defconfig
sh                 kfr2r09-romimage_defconfig
m68k                        m5307c3_defconfig
arm                       omap2plus_defconfig
powerpc                     ep8248e_defconfig
arm                             ezx_defconfig
powerpc                       maple_defconfig
mips                       bmips_be_defconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
i386                          randconfig-c001
sh                           se7722_defconfig
powerpc                 mpc837x_mds_defconfig
sh                            migor_defconfig
xtensa                          iss_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220925
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
sh                   secureedge5410_defconfig
mips                      loongson3_defconfig
arc                            hsdk_defconfig
sh                     sh7710voipgw_defconfig

clang tested configs:
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
x86_64               randconfig-a012-20220926
x86_64               randconfig-a013-20220926
x86_64               randconfig-a011-20220926
x86_64               randconfig-a016-20220926
x86_64               randconfig-a015-20220926
x86_64               randconfig-a014-20220926
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
i386                 randconfig-a011-20220926
i386                 randconfig-a015-20220926
i386                 randconfig-a014-20220926
i386                 randconfig-a012-20220926
i386                 randconfig-a013-20220926
i386                 randconfig-a016-20220926
hexagon              randconfig-r041-20220928
hexagon              randconfig-r045-20220928
riscv                randconfig-r042-20220928
s390                 randconfig-r044-20220928
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
