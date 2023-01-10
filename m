Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C34466395D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 07:30:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235118AbjAJGaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 01:30:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjAJGaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 01:30:03 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD9C48804
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 22:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673332202; x=1704868202;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=M58EOfwFBsZlsrpbS9aTqiHVpdJheNA+x/NvTpyw8QA=;
  b=mYlm6FBPRDClLB3kd5mq69mo6ccNQTLZfF5v382XO7eI9UXHFzlNdxbV
   NU7vJ9uAjn5I0gHmKz89GznqUNtHKvziXRe43ZaOO6FXNGWgzHb7hY9Dy
   +l2egz4+pQRA5hLI6Sxpzh0QWTqPrXPInAUD549nHOpNJPQo3oVoq+/H5
   3L/Xj3EdrBVa3Mj0bHqzkXhjxGR+M0UDC5PHKKEjeM2SP8Ruimd+EaHlg
   L3+XBwMd3Ry7AqEMJJFdhQxTAooYxxGkeX1OZLdr56fmdeT4aIsYYJryN
   IKKFSK/Woi1jjl7o53VxreOxXc1a8Ow/OTmzONj/qBjky1fHsbgy4/ZEA
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="321773743"
X-IronPort-AV: E=Sophos;i="5.96,314,1665471600"; 
   d="scan'208";a="321773743"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 22:30:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="689314441"
X-IronPort-AV: E=Sophos;i="5.96,314,1665471600"; 
   d="scan'208";a="689314441"
Received: from lkp-server02.sh.intel.com (HELO f1920e93ebb5) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 09 Jan 2023 22:29:59 -0800
Received: from kbuild by f1920e93ebb5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pF890-0007gJ-21;
        Tue, 10 Jan 2023 06:29:58 +0000
Date:   Tue, 10 Jan 2023 14:29:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 b0bfb80ce4ab3b1907f4ebb30d798186396382aa
Message-ID: <63bd05cf.KIT87yAGCCM4Nt4J%lkp@intel.com>
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
branch HEAD: b0bfb80ce4ab3b1907f4ebb30d798186396382aa  Merge branch into tip/master: 'x86/platform'

elapsed time: 727m

configs tested: 56
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
um                             i386_defconfig
um                           x86_64_defconfig
i386                 randconfig-a011-20230109
i386                 randconfig-a013-20230109
i386                 randconfig-a012-20230109
i386                 randconfig-a014-20230109
i386                 randconfig-a016-20230109
i386                 randconfig-a015-20230109
arc                                 defconfig
alpha                               defconfig
powerpc                           allnoconfig
s390                             allmodconfig
s390                                defconfig
s390                             allyesconfig
sh                               allmodconfig
x86_64                              defconfig
mips                             allyesconfig
powerpc                          allmodconfig
m68k                             allyesconfig
x86_64                               rhel-8.3
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
x86_64                           allyesconfig
arm                                 defconfig
x86_64                           rhel-8.3-bpf
ia64                             allmodconfig
x86_64                           rhel-8.3-syz
x86_64               randconfig-a012-20230109
arm64                            allyesconfig
x86_64                         rhel-8.3-kunit
x86_64               randconfig-a014-20230109
x86_64                           rhel-8.3-kvm
x86_64               randconfig-a011-20230109
arm                              allyesconfig
x86_64                          rhel-8.3-func
x86_64               randconfig-a013-20230109
x86_64                    rhel-8.3-kselftests
x86_64               randconfig-a016-20230109
x86_64               randconfig-a015-20230109
i386                                defconfig
i386                             allyesconfig

clang tested configs:
x86_64                          rhel-8.3-rust
i386                 randconfig-a004-20230109
i386                 randconfig-a002-20230109
i386                 randconfig-a003-20230109
i386                 randconfig-a001-20230109
i386                 randconfig-a005-20230109
i386                 randconfig-a006-20230109
x86_64               randconfig-a003-20230109
x86_64               randconfig-a002-20230109
x86_64               randconfig-a004-20230109
x86_64               randconfig-a001-20230109
x86_64               randconfig-a005-20230109
x86_64               randconfig-a006-20230109

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
