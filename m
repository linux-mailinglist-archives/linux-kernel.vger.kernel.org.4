Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B478E66395C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 07:30:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjAJGaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 01:30:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjAJGaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 01:30:03 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679574880A
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 22:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673332202; x=1704868202;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=nxNyDn/ocWSQ4l54vBaUeygOiVVpa8M1ztaQWTjKu08=;
  b=jElgi6suo0+jX3XQxeXCBmgskz+UkW3uWg/Vn8e1tFjckdhabrLhBdP2
   s9n0QaXUjy4e7I5dpP+L6GM6xakScuLG8UrWwU2zydgvDeVHbajqI/45o
   lK1vLAndrqYi+avtvJmW57p4HGhsGkuoB7aiDwuz8GcntIMEG/ZZ3rKsS
   CGxQ90ZelbZI4d/Lsk6wBvHgDQ3etORypOXSgiqFUOxhRqzYFwx0Zw2KF
   5Oy2BO4qwATKpjQwUi/pcuSBRhV4lgu+U4S5jh1Kg+DD0q8N6g1mXMFFC
   DJPB41isVVKfYIe1KT/wHV/vFlBt0ix+lM44XZUEKyuqw0vD5mqDH18jf
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="321773737"
X-IronPort-AV: E=Sophos;i="5.96,314,1665471600"; 
   d="scan'208";a="321773737"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 22:30:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="689314443"
X-IronPort-AV: E=Sophos;i="5.96,314,1665471600"; 
   d="scan'208";a="689314443"
Received: from lkp-server02.sh.intel.com (HELO f1920e93ebb5) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 09 Jan 2023 22:29:59 -0800
Received: from kbuild by f1920e93ebb5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pF890-0007gM-26;
        Tue, 10 Jan 2023 06:29:58 +0000
Date:   Tue, 10 Jan 2023 14:29:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/boot] BUILD SUCCESS
 5353fff29e42d0efc844dcaf764336d20a7f6b44
Message-ID: <63bd05c8.y6IkjuCqcEdkKKQr%lkp@intel.com>
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
branch HEAD: 5353fff29e42d0efc844dcaf764336d20a7f6b44  scripts/head-object-list: Remove x86 from the list

elapsed time: 726m

configs tested: 60
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
s390                             allyesconfig
powerpc                           allnoconfig
um                             i386_defconfig
sh                               allmodconfig
um                           x86_64_defconfig
x86_64                              defconfig
mips                             allyesconfig
i386                                defconfig
x86_64                           allyesconfig
x86_64               randconfig-a011-20230109
x86_64               randconfig-a013-20230109
x86_64                               rhel-8.3
x86_64               randconfig-a012-20230109
x86_64               randconfig-a014-20230109
i386                 randconfig-a011-20230109
x86_64               randconfig-a016-20230109
i386                 randconfig-a013-20230109
i386                 randconfig-a012-20230109
x86_64               randconfig-a015-20230109
i386                 randconfig-a014-20230109
x86_64                           rhel-8.3-bpf
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
i386                 randconfig-a016-20230109
x86_64                         rhel-8.3-kunit
i386                 randconfig-a015-20230109
ia64                             allmodconfig
arm                                 defconfig
powerpc                          allmodconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
m68k                             allyesconfig
m68k                             allmodconfig
alpha                            allyesconfig
arc                              allyesconfig
i386                             allyesconfig
arm64                            allyesconfig
arm                              allyesconfig

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
arm                          pcm027_defconfig
powerpc                       ebony_defconfig
mips                     loongson1c_defconfig
mips                      maltaaprp_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
