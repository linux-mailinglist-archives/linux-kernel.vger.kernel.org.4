Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FFC2686645
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 13:52:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbjBAMwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 07:52:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232054AbjBAMwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 07:52:37 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B00C47096
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 04:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675255956; x=1706791956;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=hzkSKWrXwWr6jUg/DUKJfBtRjECZNSsVG/IXJMuYf5s=;
  b=U8nzfoCGdZq2EbPuV7IJrxd4p4aT/FaSEZrT2OWP4VLutZL06Eu0JOpL
   vbmok+ieMoYxJkQM6E0XzfaKCahwGLgdUiPYfCHP56VE4NKdSH8u/3C6C
   p1GOgds60UlY185IwRDC2VMmNyNj45I2JaZitVUK4XbgdUfOUQPOLQ8Hk
   yfLhKtC2s6B8To5FePjnQUCs+EDiXQL62F+RLQmxYE1xDekynMRJYv8O7
   PTF4s/vvVIQGbrvX1jKTkW6hw8AvVrzv9LWxrvts0E6KoOXRr/iw4DSrx
   XDnX9P9EFM41aKdNUbukZuAo7qFuvQbbftYynrNCP7exE61jl0cstZiv0
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="414340256"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; 
   d="scan'208";a="414340256"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 04:52:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="838770332"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; 
   d="scan'208";a="838770332"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 01 Feb 2023 04:52:27 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pNCbC-0005R4-0L;
        Wed, 01 Feb 2023 12:52:26 +0000
Date:   Wed, 01 Feb 2023 20:51:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/fam-memcpy] BUILD SUCCESS
 fdcf66694e87642136df93fb2bc2f56c77cd568f
Message-ID: <63da6055.9a5Rcl02Ha3ZjMh6%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/fam-memcpy
branch HEAD: fdcf66694e87642136df93fb2bc2f56c77cd568f  wifi: mwifiex: Replace one-element array with flexible-array member

elapsed time: 720m

configs tested: 68
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
m68k                             allyesconfig
arc                                 defconfig
m68k                             allmodconfig
s390                             allmodconfig
arc                              allyesconfig
x86_64                              defconfig
x86_64                          rhel-8.3-func
alpha                            allyesconfig
alpha                               defconfig
x86_64                               rhel-8.3
powerpc                           allnoconfig
x86_64                    rhel-8.3-kselftests
x86_64                           allyesconfig
s390                                defconfig
s390                             allyesconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64               randconfig-a001-20230130
x86_64               randconfig-a003-20230130
x86_64               randconfig-a004-20230130
x86_64               randconfig-a002-20230130
i386                                defconfig
x86_64                           rhel-8.3-syz
x86_64               randconfig-a006-20230130
x86_64                         rhel-8.3-kunit
x86_64               randconfig-a005-20230130
arc                  randconfig-r043-20230129
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-bpf
arm                  randconfig-r046-20230129
i386                 randconfig-a001-20230130
i386                             allyesconfig
i386                 randconfig-a005-20230130
sh                               allmodconfig
i386                 randconfig-a004-20230130
i386                 randconfig-a003-20230130
i386                 randconfig-a002-20230130
arm                  randconfig-r046-20230130
mips                             allyesconfig
arc                  randconfig-r043-20230130
i386                 randconfig-a006-20230130
powerpc                          allmodconfig
ia64                             allmodconfig
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
i386                 randconfig-a013-20230130
i386                 randconfig-a012-20230130
s390                 randconfig-r044-20230129
s390                 randconfig-r044-20230130
i386                 randconfig-a014-20230130
i386                 randconfig-a011-20230130
i386                 randconfig-a015-20230130
x86_64               randconfig-a012-20230130
x86_64               randconfig-a013-20230130
i386                 randconfig-a016-20230130
x86_64               randconfig-a011-20230130
x86_64               randconfig-a014-20230130
x86_64               randconfig-a015-20230130
x86_64               randconfig-a016-20230130

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
