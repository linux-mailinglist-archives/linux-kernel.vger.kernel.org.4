Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD27676AFC
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 04:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjAVDqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 22:46:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjAVDqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 22:46:14 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E68AE7ECB
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 19:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674359173; x=1705895173;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=ZRzdsDXt5528hop3ZvbdgJwSUJtq7mAZ+DZeag39qdo=;
  b=TEDsX88a6IgeBHAq73QBo5puNSa+0lqKdgMO4p+RawHRK75csctA8fU1
   DR7Xjjm30ZbPYaPf+hFSFh7teKj2tXfsubGHAU1y20uZNeDM8YMOl4A7B
   AdXAdPYi3u7yQkM8URH8UrXizp4ywXmTw/0m3/XidBdwNYxmZ9uBI6yoJ
   IfMZA81IsI9BsL0v7/XqiEE+PE5U3/f/XQYFM8R18iBuFCuJoV2zbFSsy
   t4t+yafRpdo6h0LCkJ7FveWwYrnxLbOs7fKvtZNR65ge0aiEvctX9MzS6
   QpqiP1LqAHewq43YSsqEULFp7clXBzqbQ6C+bQ9iI6gGO+si8Y3xLUlEV
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10597"; a="305528169"
X-IronPort-AV: E=Sophos;i="5.97,235,1669104000"; 
   d="scan'208";a="305528169"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2023 19:46:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10597"; a="749793838"
X-IronPort-AV: E=Sophos;i="5.97,235,1669104000"; 
   d="scan'208";a="749793838"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Jan 2023 19:46:12 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pJRJ5-0004jA-2g;
        Sun, 22 Jan 2023 03:46:11 +0000
Date:   Sun, 22 Jan 2023 11:46:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 8ec4235d291d13279acb52c0bf52fb628385474a
Message-ID: <63ccb178.iQ9wBxM4w+PpYtwp%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 8ec4235d291d13279acb52c0bf52fb628385474a  Merge x86/microcode into tip/master

elapsed time: 766m

configs tested: 62
configs skipped: 17

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                        randconfig-a006
arc                  randconfig-r043-20230121
x86_64                    rhel-8.3-kselftests
arm                  randconfig-r046-20230121
x86_64                          rhel-8.3-func
x86_64                              defconfig
arm                                 defconfig
i386                                defconfig
i386                          randconfig-a014
powerpc                           allnoconfig
i386                          randconfig-a012
x86_64                           rhel-8.3-syz
i386                          randconfig-a016
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                        randconfig-a004
x86_64                           rhel-8.3-bpf
x86_64                               rhel-8.3
mips                             allyesconfig
i386                          randconfig-a001
x86_64                        randconfig-a002
powerpc                          allmodconfig
arc                                 defconfig
arm64                            allyesconfig
x86_64                           allyesconfig
arm                              allyesconfig
ia64                             allmodconfig
s390                             allmodconfig
alpha                               defconfig
i386                          randconfig-a003
sh                               allmodconfig
i386                          randconfig-a005
s390                                defconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
s390                             allyesconfig
m68k                             allyesconfig
i386                             allyesconfig
alpha                            allyesconfig
arc                              allyesconfig
m68k                             allmodconfig

clang tested configs:
x86_64                          rhel-8.3-rust
s390                 randconfig-r044-20230121
hexagon              randconfig-r041-20230121
hexagon              randconfig-r045-20230121
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a006
riscv                randconfig-r042-20230121
i386                          randconfig-a015
x86_64                        randconfig-a005
x86_64                        randconfig-a001
i386                          randconfig-a002
x86_64                        randconfig-a003
i386                          randconfig-a004
x86_64                        randconfig-a014
x86_64                        randconfig-a012
x86_64                        randconfig-a016

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
