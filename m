Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED6867F373
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 02:06:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233589AbjA1BGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 20:06:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjA1BGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 20:06:47 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7371820DB
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 17:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674868006; x=1706404006;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=lmr78v3uRJRxCXXbw8/mdVxKE44q1zgexfgOHKRlxv4=;
  b=dLtkZzoqWrXcpPsQpyFIM7Rxh8YgZLXWEYXpcJedM/dHonh7ciI7LMBZ
   4BPVABBleoyxt0RYVhp859meHWWPCfV3TA5/A0RvcZfzamKS8xE1A1rmz
   rkGm9yIgLwuvpILroA7YJ6S0y67PeP2Dhf4VkhBqnWS+zTADTRITFpyWi
   il2HeSzOyuHAogtdiRCLSuLoepPqfG9mIZetdS2jkpQulhJzBl3Q2KAmU
   nXf6f2YXz9JIqt0XW5Sl0n+n1KLN+aIGbpnnbsmK6WLHemPCuvVdezZ3w
   hoOuCNWy9FMjPDM2OEPE8lf7CZ7CmW5aiL4XtaovjxfqoqiLiBa5q4KEy
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="354543932"
X-IronPort-AV: E=Sophos;i="5.97,252,1669104000"; 
   d="scan'208";a="354543932"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 17:06:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="665443973"
X-IronPort-AV: E=Sophos;i="5.97,252,1669104000"; 
   d="scan'208";a="665443973"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 27 Jan 2023 17:06:45 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pLZg4-00006o-1K;
        Sat, 28 Jan 2023 01:06:44 +0000
Date:   Sat, 28 Jan 2023 09:05:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/mm] BUILD SUCCESS
 ebd3ad60a688131de7df1dd05fd2d7c57f542268
Message-ID: <63d474dd.LNEZ/id4gR0Go6WN%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/mm
branch HEAD: ebd3ad60a688131de7df1dd05fd2d7c57f542268  x86/cpu: Use cpu_feature_enabled() when checking global pages support

elapsed time: 3760m

configs tested: 37
configs skipped: 52

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
i386                                defconfig
x86_64                           rhel-8.3-syz
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-bpf
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
x86_64                              defconfig
i386                 randconfig-a003-20230123
i386                 randconfig-a002-20230123
x86_64               randconfig-a002-20230123
i386                 randconfig-a001-20230123
x86_64               randconfig-a001-20230123
i386                 randconfig-a004-20230123
x86_64               randconfig-a004-20230123
i386                 randconfig-a005-20230123
x86_64                               rhel-8.3
i386                 randconfig-a006-20230123
x86_64               randconfig-a003-20230123
i386                             allyesconfig
x86_64               randconfig-a006-20230123
x86_64               randconfig-a005-20230123
x86_64                           allyesconfig

clang tested configs:
x86_64                          rhel-8.3-rust
x86_64               randconfig-a013-20230123
x86_64               randconfig-a011-20230123
x86_64               randconfig-a012-20230123
x86_64               randconfig-a014-20230123
x86_64               randconfig-a016-20230123
x86_64               randconfig-a015-20230123
i386                 randconfig-a012-20230123
i386                 randconfig-a013-20230123
i386                 randconfig-a011-20230123
i386                 randconfig-a014-20230123
i386                 randconfig-a015-20230123
i386                 randconfig-a016-20230123

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
