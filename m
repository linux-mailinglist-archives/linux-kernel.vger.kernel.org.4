Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF5665717C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 01:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbiL1At4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 19:49:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbiL1Atp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 19:49:45 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225E9E007
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 16:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672188585; x=1703724585;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=ifmctyargq/o8lPYPuYZzPiYv96s4nehdWLdBryvugs=;
  b=m57pev1DlO2osPURlw/cX5lNzNepH4+grNxYt8hyOZU2vt3h6cMwKmhY
   a80X4r/LXZmTAzAlTfrjkIYbnOq5Uv5LgNtIl2uQPQXn3/o+/rrvjGTfl
   gBq9/Wc06ncnnplbQ0hzLqdRbx1FLOFCwFE15AZsYznRPMlCTdTYpKz5p
   V1HImM+JYMaH//pY7X+OyK8y8NOEcvk7p2UrKEPWDthFHjD7oyDoymJDu
   XUzU0p43et7YSItezhGmfUkyREJIibd/lx6U1+jC2ibCXVncMTsXpAJt5
   Lx3/MXrgr+4/7nKo3m+T6OfHGq0zVLd5RJ0jf+cc2pXaNlmOi8js2zlyD
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10573"; a="407046287"
X-IronPort-AV: E=Sophos;i="5.96,279,1665471600"; 
   d="scan'208";a="407046287"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2022 16:49:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10573"; a="741876715"
X-IronPort-AV: E=Sophos;i="5.96,279,1665471600"; 
   d="scan'208";a="741876715"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Dec 2022 16:49:42 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pAKdZ-000FIA-34;
        Wed, 28 Dec 2022 00:49:41 +0000
Date:   Wed, 28 Dec 2022 08:49:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 63dc6325ff41ee9e570bde705ac34a39c5dbeb44
Message-ID: <63ab9281.cORROGZo8ObEKurC%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: 63dc6325ff41ee9e570bde705ac34a39c5dbeb44  x86/kprobes: Fix optprobe optimization check with CONFIG_RETHUNK

elapsed time: 729m

configs tested: 46
configs skipped: 81

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-bpf
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
i386                 randconfig-a012-20221226
i386                 randconfig-a011-20221226
i386                 randconfig-a013-20221226
i386                 randconfig-a014-20221226
i386                 randconfig-a016-20221226
x86_64                              defconfig
i386                 randconfig-a015-20221226
x86_64                               rhel-8.3
i386                                defconfig
x86_64                           allyesconfig
i386                             allyesconfig
x86_64               randconfig-a014-20221226
x86_64               randconfig-a013-20221226
x86_64               randconfig-a011-20221226
x86_64               randconfig-a012-20221226
x86_64               randconfig-a016-20221226
x86_64               randconfig-a015-20221226
x86_64                            allnoconfig
i386                          randconfig-c001
powerpc              randconfig-c003-20221225
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3

clang tested configs:
x86_64                          rhel-8.3-rust
x86_64               randconfig-a006-20221226
i386                 randconfig-a004-20221226
i386                 randconfig-a001-20221226
x86_64               randconfig-a002-20221226
i386                 randconfig-a003-20221226
x86_64               randconfig-a003-20221226
i386                 randconfig-a002-20221226
x86_64               randconfig-a001-20221226
x86_64               randconfig-a004-20221226
i386                 randconfig-a006-20221226
i386                 randconfig-a005-20221226
x86_64               randconfig-a005-20221226
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
