Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36AAE5B6205
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 22:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbiILUKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 16:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiILUKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 16:10:07 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 230D51276F
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 13:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663013407; x=1694549407;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=B6s96K8z+fWO2rbhrLJmkVFZUBykELAdAHUi7Bj0D2A=;
  b=kiIg3XBdYAD8WnANKUmb+6aZFCa4lCkoJXTZHSWNxJK2MdLB87i1VKuJ
   IVhNqNE8EMsr19L/wZAbUsBQiXPPgMPJL9Bc45NIn+qaBajdNsQxGhpkC
   OlUK7pY/XdcSi5xrai0nsNlXTI59sBLowrRwi7+TCdsJ7egwSiMontQO8
   RT2bJA99pjz+hdHUf/9AlBmv6hzzJO7l26Iwv0SJ16+VWwfab3ZNgIW5S
   a2n+pxk09iLBi4JbR/QO7mMO9DzonUw6Ky16YtZ7Kd4uAv0vDNoGamci9
   l9EmzhXIADyspJ16XxEpYM1rrcjPNpnpDGhRG7ySO8HvKy633cpCzZaaG
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10468"; a="296694947"
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="296694947"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 13:09:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="646617406"
Received: from lkp-server02.sh.intel.com (HELO 4011df4f4fd3) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 12 Sep 2022 13:09:29 -0700
Received: from kbuild by 4011df4f4fd3 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oXpkG-0002p9-2z;
        Mon, 12 Sep 2022 20:09:28 +0000
Date:   Tue, 13 Sep 2022 04:09:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 c896e0dec971fc34644779e195c64fd99cdda3a1
Message-ID: <631f91dc.w9YGNQYI42++LFQ0%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: c896e0dec971fc34644779e195c64fd99cdda3a1  Merge branch 'linus'

elapsed time: 725m

configs tested: 58
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
powerpc                           allnoconfig
i386                 randconfig-a001-20220912
x86_64                              defconfig
um                           x86_64_defconfig
i386                                defconfig
i386                 randconfig-a002-20220912
powerpc                          allmodconfig
x86_64                               rhel-8.3
sh                               allmodconfig
m68k                             allmodconfig
arc                              allyesconfig
x86_64                           allyesconfig
i386                 randconfig-a003-20220912
x86_64               randconfig-a001-20220912
riscv                randconfig-r042-20220911
arm                                 defconfig
mips                             allyesconfig
i386                 randconfig-a006-20220912
alpha                            allyesconfig
i386                 randconfig-a005-20220912
x86_64               randconfig-a004-20220912
arc                  randconfig-r043-20220912
x86_64               randconfig-a002-20220912
x86_64                          rhel-8.3-func
i386                             allyesconfig
x86_64               randconfig-a005-20220912
x86_64               randconfig-a003-20220912
ia64                             allmodconfig
i386                 randconfig-a004-20220912
x86_64                         rhel-8.3-kunit
m68k                             allyesconfig
arm                              allyesconfig
x86_64                           rhel-8.3-kvm
x86_64               randconfig-a006-20220912
arm64                            allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-syz
arc                  randconfig-r043-20220911
s390                 randconfig-r044-20220911

clang tested configs:
x86_64               randconfig-a011-20220912
x86_64               randconfig-a012-20220912
x86_64               randconfig-a015-20220912
x86_64               randconfig-a016-20220912
i386                 randconfig-a014-20220912
x86_64               randconfig-a013-20220912
riscv                randconfig-r042-20220912
i386                 randconfig-a013-20220912
x86_64               randconfig-a014-20220912
i386                 randconfig-a011-20220912
hexagon              randconfig-r041-20220912
i386                 randconfig-a012-20220912
i386                 randconfig-a015-20220912
hexagon              randconfig-r045-20220911
i386                 randconfig-a016-20220912
hexagon              randconfig-r041-20220911
hexagon              randconfig-r045-20220912
s390                 randconfig-r044-20220912

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
