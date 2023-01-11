Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30BED6650CF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 01:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235385AbjAKA7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 19:59:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231851AbjAKA7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 19:59:44 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D709250F67
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 16:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673398783; x=1704934783;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=zeadYg9N7LR/2v3VRmSRu4/7KMY6saCxXw7nFSK3U6w=;
  b=LlxxNdOA7vODLyFdfvbxaaBTtE0gJ3DGnpafKN6QeuAjN44IJcIjk8kB
   v2dqcQGNZCj+AQMznMmlkmg/12B4Dqnb8alsZXEgQCYnsPQiwT4jkzoGq
   u2CQfTmzsNkRfnsxmHi7hsXmNFMgDl+LGLvqIzetluYrYxjr9rpA4JeYh
   66AKQwTDFz4tEGllmfgvt2Bmrewmxmb17r5zAwW5SNO4c8//3EaucaZHU
   HZibvnnkD2rIuEq4JuB6ORP+eApzw/w9MFhfjFw/JsQtx4QGA5hiW4akN
   BE3KcDjQ/QjPUG9WNBakAiqbBbb+36M18PJ6G/RlRkCXTZcvvW3D5LpQ/
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="306815168"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="306815168"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2023 16:59:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="745982047"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="745982047"
Received: from lkp-server02.sh.intel.com (HELO f1920e93ebb5) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Jan 2023 16:59:31 -0800
Received: from kbuild by f1920e93ebb5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pFPSf-0008Xg-33;
        Wed, 11 Jan 2023 00:59:25 +0000
Date:   Wed, 11 Jan 2023 08:58:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/cpu] BUILD SUCCESS
 bb5525a50601f8be7d0ffb04740e1714506e60c4
Message-ID: <63be09c9.VaLTEcFSxPmblKqg%lkp@intel.com>
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
branch HEAD: bb5525a50601f8be7d0ffb04740e1714506e60c4  x86/cpu: Remove redundant extern x86_read_arch_cap_msr()

elapsed time: 723m

configs tested: 31
configs skipped: 73

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-bpf
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
ia64                             allmodconfig
i386                             allyesconfig
i386                                defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig

clang tested configs:
x86_64                          rhel-8.3-rust
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-k001
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
