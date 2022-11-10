Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 669FC624A9F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 20:27:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbiKJT1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 14:27:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiKJT1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 14:27:40 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11322ED56
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 11:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668108459; x=1699644459;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=NV6JK5pt8YDrX6jR9g0yFYY4R5F2W6YDAk1jKu4bGo8=;
  b=cUiFvcuRDtohw0J9qJO7oI+iPiFxGinoUO7W+0B9j9gPPzRC9tB4/DU+
   6TMeMxm00BXC7s23gcSd3U59VhDmLzHOgpV7XQcCNvo4g2TJDsWF3LyL9
   5+S12fLvWU+1MfAiDpKl7h0MtQCSin4rQ4iERXnhdy7CUdngCc/Y0oCVn
   199SG1P/+8URPkXHF6cvcR7F/iuNF8kNYpcGOJa+e35eDzLO2P6uTgSzK
   WypbZi5kgbJuxGj2m9X+h5oTWs5wVHI9v9xR0QYaBLs515jcwciDzlGmQ
   HZYhHCjVtL6YvDd0PedbwKrUiccHo1AznO7o8pMovb27HtbQ+QQyB7Z9t
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="294774559"
X-IronPort-AV: E=Sophos;i="5.96,154,1665471600"; 
   d="scan'208";a="294774559"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 11:27:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="588300273"
X-IronPort-AV: E=Sophos;i="5.96,154,1665471600"; 
   d="scan'208";a="588300273"
Received: from lkp-server01.sh.intel.com (HELO e783503266e8) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 10 Nov 2022 11:27:36 -0800
Received: from kbuild by e783503266e8 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1otDD6-0003Ah-0r;
        Thu, 10 Nov 2022 19:27:36 +0000
Date:   Fri, 11 Nov 2022 03:27:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2022.11.08a] BUILD SUCCESS
 a7bcf55516657bc4350d161ad12569e93972d825
Message-ID: <636d5091./Dm97AkFj1YzBDKk%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2022.11.08a
branch HEAD: a7bcf55516657bc4350d161ad12569e93972d825  squash! refscale: Add tests using SLAB_TYPESAFE_BY_RCU

elapsed time: 1496m

configs tested: 59
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                           x86_64_defconfig
um                             i386_defconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
sh                               allmodconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
arc                                 defconfig
s390                             allmodconfig
x86_64                              defconfig
alpha                               defconfig
s390                                defconfig
s390                             allyesconfig
i386                                defconfig
arm                                 defconfig
x86_64                            allnoconfig
x86_64                           allyesconfig
s390                       zfcpdump_defconfig
powerpc                      arches_defconfig
powerpc                     sequoia_defconfig
mips                         cobalt_defconfig
arm                      footbridge_defconfig
xtensa                  cadence_csp_defconfig
mips                         db1xxx_defconfig
arm                        spear6xx_defconfig
powerpc                      pasemi_defconfig
i386                             allyesconfig
powerpc              randconfig-c003-20221110
ia64                             allmodconfig
arm                              allyesconfig
arm64                            allyesconfig
arc                              allyesconfig
sh                           se7722_defconfig
arm                         lpc18xx_defconfig
nios2                         10m50_defconfig
powerpc                 mpc837x_rdb_defconfig
sh                      rts7751r2d1_defconfig
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
alpha                            allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig

clang tested configs:
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a004
x86_64                        randconfig-a003
hexagon              randconfig-r041-20221110
hexagon              randconfig-r045-20221110
powerpc                        fsp2_defconfig
powerpc                    gamecube_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
