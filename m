Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3236265E227
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 02:04:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjAEBEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 20:04:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjAEBEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 20:04:46 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 887A813CDF
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 17:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672880685; x=1704416685;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=XH9Iocdf/yv20JH1Wz1z1JklRpFBzY3AGlvfQG4efsI=;
  b=WkQynZmBLURRWY1bk64t2Aj+UZFEDeSuq3TLopOyIZr/+yBEqddVoIG0
   u64Ej5U1F/sTuP6uw/kzuXlepbdQL5hdVU22mGIw5454bRweaskf708ne
   tM2efqUFLABfuONQNVujAuSlgGqHpRnx/neNOMKmnG4epMyGg3IUZfcd2
   NVRoabtdp25GHINfcFKXRovlnr/CcR7y7xnsf5aLLnYHEkddM89biBpLN
   eoK9CyJ+QTE1BtEc+6WNqsyQtWxDQMMabpUbwZWRlkb9NOOwCdbhLvEqu
   RilIzzkrusID1rb8xgGcBvuyLXeLpRdKy3T+7qRs786buU85b+sMVEPZm
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="322156891"
X-IronPort-AV: E=Sophos;i="5.96,301,1665471600"; 
   d="scan'208";a="322156891"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 17:04:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="779392222"
X-IronPort-AV: E=Sophos;i="5.96,301,1665471600"; 
   d="scan'208";a="779392222"
Received: from lkp-server02.sh.intel.com (HELO f1920e93ebb5) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 04 Jan 2023 17:04:43 -0800
Received: from kbuild by f1920e93ebb5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pDEgP-0000xl-37;
        Thu, 05 Jan 2023 01:04:37 +0000
Date:   Thu, 05 Jan 2023 09:04:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 a664ec9158eeddd75121d39c9a0758016097fa96
Message-ID: <63b62215.y4wPMQ9/f8elYoQq%lkp@intel.com>
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
branch HEAD: a664ec9158eeddd75121d39c9a0758016097fa96  x86/bugs: Flush IBP in ib_prctl_set()

elapsed time: 728m

configs tested: 45
configs skipped: 77

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
x86_64                           rhel-8.3-bpf
x86_64                           rhel-8.3-syz
x86_64                           rhel-8.3-kvm
x86_64                         rhel-8.3-kunit
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
i386                                defconfig
x86_64                              defconfig
i386                 randconfig-a004-20230102
i386                 randconfig-a003-20230102
i386                 randconfig-a001-20230102
i386                 randconfig-a002-20230102
x86_64                               rhel-8.3
i386                 randconfig-a005-20230102
i386                 randconfig-a006-20230102
x86_64                           allyesconfig
x86_64               randconfig-a003-20230102
x86_64               randconfig-a001-20230102
x86_64               randconfig-a002-20230102
x86_64               randconfig-a004-20230102
x86_64               randconfig-a006-20230102
x86_64               randconfig-a005-20230102
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                             allyesconfig
s390                 randconfig-r044-20230103
arc                  randconfig-r043-20230103
riscv                randconfig-r042-20230103
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
ia64                             allmodconfig

clang tested configs:
x86_64                          rhel-8.3-rust
i386                 randconfig-a011-20230102
i386                 randconfig-a014-20230102
i386                 randconfig-a013-20230102
i386                 randconfig-a012-20230102
i386                 randconfig-a015-20230102
i386                 randconfig-a016-20230102
x86_64                        randconfig-a014
x86_64                        randconfig-a012
x86_64                        randconfig-a016

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
