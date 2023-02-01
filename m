Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17A2D6860FC
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 08:52:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231714AbjBAHw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 02:52:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbjBAHw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 02:52:26 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3E63AB1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 23:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675237944; x=1706773944;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Iut0X4GitE8BLar4GhISGzl+hXCXWOXepZCcC8lksP0=;
  b=Ce60llX1SE2hGdGUDlA4lQOjQYsZXtlZh+MLlOvrK9KVVL7zsK+BtIRX
   jdEoiXxNUXKSgXZADNSebcHhpSdovSmvJvv2jvYV0xmNG5hyl82UBYLDV
   hEmMc5stkrEK6dc5me8hl2CmfjyiUEz1H+TWv/jYYNKz0QN7/Utv8icip
   Cma+0JQZTteIUgU2Ex2RUmoQNo91BVdcl7rm+lmT5vLVtQ+puTWTWIp3q
   jKaQTpBf8cAMTV0AbV40kl7aijhFb/UmIx4zovqqI+JVPSIP9F+38HGaE
   VtW2nhaWlFwRSgHLC85O7QHQgxhnZFT44om7oq75WwGXpGzR0k8Iacz1p
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="311722924"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; 
   d="scan'208";a="311722924"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 23:52:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="728291210"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; 
   d="scan'208";a="728291210"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 31 Jan 2023 23:52:13 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pN7uf-0005E2-04;
        Wed, 01 Feb 2023 07:52:13 +0000
Date:   Wed, 01 Feb 2023 15:51:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/cpu] BUILD SUCCESS
 7914695743d598b189d549f2f57af24aa5633705
Message-ID: <63da1a17.VRtmDA8GoyvOWxrC%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cpu
branch HEAD: 7914695743d598b189d549f2f57af24aa5633705  x86/amd: Cache debug register values in percpu variables

elapsed time: 724m

configs tested: 68
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
alpha                               defconfig
x86_64                            allnoconfig
s390                                defconfig
s390                             allmodconfig
s390                             allyesconfig
ia64                             allmodconfig
powerpc                           allnoconfig
um                             i386_defconfig
m68k                             allyesconfig
um                           x86_64_defconfig
m68k                             allmodconfig
x86_64                              defconfig
arc                              allyesconfig
x86_64                               rhel-8.3
alpha                            allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
x86_64                           allyesconfig
sh                               allmodconfig
mips                             allyesconfig
powerpc                          allmodconfig
i386                 randconfig-a001-20230130
i386                 randconfig-a004-20230130
i386                 randconfig-a003-20230130
i386                 randconfig-a002-20230130
arc                  randconfig-r043-20230129
i386                 randconfig-a005-20230130
i386                 randconfig-a006-20230130
arm                  randconfig-r046-20230129
arm                  randconfig-r046-20230130
arc                  randconfig-r043-20230130
x86_64               randconfig-a001-20230130
x86_64               randconfig-a003-20230130
x86_64               randconfig-a004-20230130
x86_64               randconfig-a002-20230130
i386                                defconfig
x86_64               randconfig-a006-20230130
x86_64               randconfig-a005-20230130
i386                             allyesconfig
x86_64                           rhel-8.3-syz
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-bpf
x86_64                         rhel-8.3-kunit
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig

clang tested configs:
x86_64                          rhel-8.3-rust
hexagon              randconfig-r041-20230129
riscv                randconfig-r042-20230129
riscv                randconfig-r042-20230130
hexagon              randconfig-r045-20230130
hexagon              randconfig-r041-20230130
hexagon              randconfig-r045-20230129
s390                 randconfig-r044-20230129
s390                 randconfig-r044-20230130
i386                 randconfig-a013-20230130
i386                 randconfig-a012-20230130
i386                 randconfig-a014-20230130
i386                 randconfig-a011-20230130
i386                 randconfig-a015-20230130
i386                 randconfig-a016-20230130
x86_64               randconfig-a014-20230130
x86_64               randconfig-a012-20230130
x86_64               randconfig-a013-20230130
x86_64               randconfig-a011-20230130
x86_64               randconfig-a015-20230130
x86_64               randconfig-a016-20230130

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
