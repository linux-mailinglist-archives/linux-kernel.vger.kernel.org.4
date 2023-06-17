Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01B08733F1A
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 09:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345789AbjFQHT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 03:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjFQHTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 03:19:23 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6154E1BB
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 00:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686986362; x=1718522362;
  h=date:from:to:cc:subject:message-id;
  bh=osU3EIj44wX3CBW65mx2InBceShzOC+Hr6nbTqZ28iw=;
  b=WJpyaGQvunbmTlFVeHh3MFay1Olog8gEGDujMK5/A52EwyYKnH9lJAhJ
   nkADfiNFrr/AGgPjC3t0/mAq2Ik67Is9+QEDRIjInejVELwSu7C15sFH5
   yoCt9JazKKgGMaOZbrysIkmO33Lpbrh5wwI1gkfOcS0bl4XSLEXfnQzgH
   GVTMPpyEio/LjwRPflC+3K75UayN9jU/rJzJzOuLxQcY8YNTLwxYyy+/b
   lufOka0naWLUCPn28/NCTJvsbzhsJctZNN5BUGXbFXQpirrgW5qJSqBUT
   h7bs7f8oHgRcvAL9HfAdpYoyUQ/EPF4Jntq+7upvTHgeo/FWUqriG48+J
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="445749519"
X-IronPort-AV: E=Sophos;i="6.00,250,1681196400"; 
   d="scan'208";a="445749519"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2023 00:19:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="1043333251"
X-IronPort-AV: E=Sophos;i="6.00,250,1681196400"; 
   d="scan'208";a="1043333251"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 17 Jun 2023 00:19:21 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qAQDQ-0002R6-1q;
        Sat, 17 Jun 2023 07:19:20 +0000
Date:   Sat, 17 Jun 2023 15:18:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 d082d48737c75d2b3cc1f972b8c8674c25131534
Message-ID: <202306171528.pOi4XqR3-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: d082d48737c75d2b3cc1f972b8c8674c25131534  x86/mm: Avoid using set_pgd() outside of real PGD pages

elapsed time: 726m

configs tested: 26
configs skipped: 73

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230616   clang
i386                 randconfig-i002-20230616   clang
i386                 randconfig-i003-20230616   clang
i386                 randconfig-i004-20230616   clang
i386                 randconfig-i005-20230616   clang
i386                 randconfig-i006-20230616   clang
i386                 randconfig-i011-20230617   clang
i386                 randconfig-i012-20230617   clang
i386                 randconfig-i013-20230617   clang
i386                 randconfig-i014-20230617   clang
i386                 randconfig-i015-20230617   clang
i386                 randconfig-i016-20230617   clang
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a011-20230616   gcc  
x86_64               randconfig-a012-20230616   gcc  
x86_64               randconfig-a013-20230616   gcc  
x86_64               randconfig-a014-20230616   gcc  
x86_64               randconfig-a015-20230616   gcc  
x86_64               randconfig-a016-20230616   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
