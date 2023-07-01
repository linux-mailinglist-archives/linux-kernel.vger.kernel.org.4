Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 519C77445EA
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 03:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjGABmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 21:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjGABmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 21:42:54 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0026C4204
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 18:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688175772; x=1719711772;
  h=date:from:to:cc:subject:message-id;
  bh=d2EXU7De+ru/bnpIgCHFSAF02jYICcngRtIjx9JYQV8=;
  b=QeBFhdkpVmgMM0nUYH3i1juK8UEeHztJA2tJd9n2/TLTWp1NFWm8Bq1F
   wWnDUvWazEA3AN0v459ut0QttgCQHI49G6U3i1Sz/CNFU5mAFEt5YZ6RN
   fF02xd6qMA2FXF50CUUrke5aBvtM8tlbOvlajvq9G08LSYegCHD+jbLTE
   6qJzRZp5B/qnNGYbuHDjdGE+EFclBHzH1TDeJkouxeWbwbWPdVDvCaKY1
   gmNpLNMSXhZ1tTEVc3gpjAWUmYZlX/HjDeySx3W3X9AnjwAEBEziTsRCO
   M2BVnzCMeo0RnqOQUbUi1oe/4pGcdBS1zEHWCJJkhHAy/aBJzrR9Xc1gN
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10757"; a="428576912"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="428576912"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2023 18:42:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10757"; a="831143253"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="831143253"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 30 Jun 2023 18:42:50 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qFPdR-000FXf-1u;
        Sat, 01 Jul 2023 01:42:49 +0000
Date:   Sat, 01 Jul 2023 09:42:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 0303c9729afc4094ef53e552b7b8cff7436028d6
Message-ID: <202307010900.NAfKxOb9-lkp@intel.com>
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
branch HEAD: 0303c9729afc4094ef53e552b7b8cff7436028d6  x86/efi: Make efi_set_virtual_address_map IBT safe

elapsed time: 729m

configs tested: 39
configs skipped: 90

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230629   gcc  
i386         buildonly-randconfig-r005-20230629   gcc  
i386         buildonly-randconfig-r006-20230629   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230629   gcc  
i386                 randconfig-i002-20230629   gcc  
i386                 randconfig-i003-20230629   gcc  
i386                 randconfig-i004-20230629   gcc  
i386                 randconfig-i005-20230629   gcc  
i386                 randconfig-i006-20230629   gcc  
i386                 randconfig-i011-20230629   clang
i386                 randconfig-i012-20230629   clang
i386                 randconfig-i013-20230629   clang
i386                 randconfig-i014-20230629   clang
i386                 randconfig-i015-20230629   clang
i386                 randconfig-i016-20230629   clang
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230629   gcc  
x86_64       buildonly-randconfig-r002-20230629   gcc  
x86_64       buildonly-randconfig-r003-20230629   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r011-20230629   clang
x86_64               randconfig-x001-20230629   clang
x86_64               randconfig-x002-20230629   clang
x86_64               randconfig-x003-20230629   clang
x86_64               randconfig-x004-20230629   clang
x86_64               randconfig-x005-20230629   clang
x86_64               randconfig-x006-20230629   clang
x86_64               randconfig-x011-20230629   gcc  
x86_64               randconfig-x012-20230629   gcc  
x86_64               randconfig-x013-20230629   gcc  
x86_64               randconfig-x014-20230629   gcc  
x86_64               randconfig-x015-20230629   gcc  
x86_64               randconfig-x016-20230629   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
