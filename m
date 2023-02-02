Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95068687339
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 03:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbjBBCGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 21:06:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjBBCGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 21:06:08 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 442E0568AD
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 18:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675303564; x=1706839564;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=KdVHalyKoI8tCX5phn3j7pB/qEvEvbic34wZlkgbWF4=;
  b=ny9LLipdyOePJ3BfeDq+NlcOxM6HEkl7zhOycheZUrrR0ILdLID6dSNv
   hpCqepffRwAvU9OBdOkJMkYWkogxM/pBADSgFIJQgUkvAuJKl5XwCtqD2
   bTs/d6dY5V9IBkfsW49gIk/LgNdGgPw0RLCzFVAdVIG78Z/yPnM90V50x
   QL21OCray7n6vZYgDrCFzfz9I52FNONk0P7ylifXmkL5hozplNsNwQw4h
   2Rezw0ApUL26je7t855kn8+2GvNWizRuE0MOse4ItOVcWO+mqf/aooEMk
   SBbpBvtJt633Dx6DOBSfiyRDHfC+UlD4Nr6X+NxSa8Wm1L6U4cxWzWQ0J
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="326028317"
X-IronPort-AV: E=Sophos;i="5.97,266,1669104000"; 
   d="scan'208";a="326028317"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 18:06:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="910538745"
X-IronPort-AV: E=Sophos;i="5.97,266,1669104000"; 
   d="scan'208";a="910538745"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 01 Feb 2023 18:06:03 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pNOzC-00061M-1I;
        Thu, 02 Feb 2023 02:06:02 +0000
Date:   Thu, 02 Feb 2023 10:05:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 b53f84708ba3de126e7be634b16dbdf18d7d23da
Message-ID: <63db1a79.3kYuPcH8MklEn09S%lkp@intel.com>
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
branch HEAD: b53f84708ba3de126e7be634b16dbdf18d7d23da  Merge branch into tip/master: 'x86/microcode'

elapsed time: 795m

configs tested: 37
configs skipped: 71

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
i386                 randconfig-a002-20230130
i386                 randconfig-a001-20230130
i386                 randconfig-a004-20230130
i386                 randconfig-a003-20230130
i386                 randconfig-a006-20230130
i386                 randconfig-a005-20230130
x86_64               randconfig-a001-20230130
x86_64               randconfig-a003-20230130
x86_64               randconfig-a004-20230130
x86_64               randconfig-a002-20230130
x86_64               randconfig-a006-20230130
x86_64               randconfig-a005-20230130
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-bpf
i386                                defconfig
i386                             allyesconfig

clang tested configs:
x86_64                          rhel-8.3-rust
x86_64               randconfig-a014-20230130
x86_64               randconfig-a012-20230130
x86_64               randconfig-a013-20230130
x86_64               randconfig-a011-20230130
x86_64               randconfig-a015-20230130
x86_64               randconfig-a016-20230130
i386                 randconfig-a013-20230130
i386                 randconfig-a011-20230130
i386                 randconfig-a012-20230130
i386                 randconfig-a014-20230130
i386                 randconfig-a015-20230130
i386                 randconfig-a016-20230130

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
