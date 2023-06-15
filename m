Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D54C73103C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 09:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244699AbjFOHKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 03:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244552AbjFOHJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 03:09:46 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D8582962
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 00:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686812911; x=1718348911;
  h=date:from:to:cc:subject:message-id;
  bh=budWuW+rvZulEzVhDm3EKta8WIrORZbdaRudLr7OV0E=;
  b=bS54NLPxgy2uhsLDT1VeaD4q9gqxiHmpyFXSk1/IJljo4HADCvGxPGcb
   Ll0FQXBMBvEPpLvKU91YLkBPPjbSmLNmYRmZpWA7t0yWYH2ZMztfoWxsP
   waa98ALtsgOXEw+JKKMqM9bw26zNQEBmWCvld7rNB2zmm5qBS8nuBCeww
   qCu3pwLiC6vLfbswUHpq7MZ0h2u8xJ2nNeT+QbCLEFsvgHPZGFUIaXx1+
   d5JUerXt4muoANsChAOTu6gE1sIQu4MBGIFeQX81z/X+Pj41I9Bt6szWI
   Mbw1Q1GWqFNHTVf7ikNmByJC2WMnvJEu/H1pTULlR/nu/V7frUnL4Leu6
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="357715076"
X-IronPort-AV: E=Sophos;i="6.00,244,1681196400"; 
   d="scan'208";a="357715076"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 00:08:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="959083117"
X-IronPort-AV: E=Sophos;i="6.00,244,1681196400"; 
   d="scan'208";a="959083117"
Received: from lkp-server02.sh.intel.com (HELO d59cacf64e9e) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 15 Jun 2023 00:08:07 -0700
Received: from kbuild by d59cacf64e9e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q9h4c-0001Zx-0T;
        Thu, 15 Jun 2023 07:07:50 +0000
Date:   Thu, 15 Jun 2023 15:07:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 45af195ec1293aa726934b9311d94bde94e6309d
Message-ID: <202306151511.HCcddq2A-lkp@intel.com>
User-Agent: s-nail v14.9.24
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
branch HEAD: 45af195ec1293aa726934b9311d94bde94e6309d  Merge x86/build into tip/master

elapsed time: 726m

configs tested: 33
configs skipped: 90

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230614   clang
i386                 randconfig-i002-20230614   clang
i386                 randconfig-i003-20230614   clang
i386                 randconfig-i004-20230614   clang
i386                 randconfig-i005-20230614   clang
i386                 randconfig-i006-20230614   clang
i386                 randconfig-i011-20230612   gcc  
i386                 randconfig-i012-20230612   gcc  
i386                 randconfig-i013-20230612   gcc  
i386                 randconfig-i014-20230612   gcc  
i386                 randconfig-i015-20230612   gcc  
i386                 randconfig-i016-20230612   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r006-20230614   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230614   clang
x86_64               randconfig-a002-20230614   clang
x86_64               randconfig-a003-20230614   clang
x86_64               randconfig-a004-20230614   clang
x86_64               randconfig-a005-20230614   clang
x86_64               randconfig-a006-20230614   clang
x86_64               randconfig-a011-20230612   gcc  
x86_64               randconfig-a012-20230612   gcc  
x86_64               randconfig-a013-20230612   gcc  
x86_64               randconfig-a014-20230612   gcc  
x86_64               randconfig-a015-20230612   gcc  
x86_64               randconfig-a016-20230612   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
