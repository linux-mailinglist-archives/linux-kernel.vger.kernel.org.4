Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF23719EFB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 16:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233407AbjFAOAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 10:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233230AbjFAOAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 10:00:52 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A028A184
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 07:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685628051; x=1717164051;
  h=date:from:to:cc:subject:message-id;
  bh=XUUUJPoQa54lLvmM2ZbFm/BBZ52XyPsYMIT+o9MmLUI=;
  b=emJHbGJSY+ylWMtgC9EbBxhJvKsZfJZkCQOaNQfW+WYYL+wsUirh9W2n
   4o1WYrV2ZWGtRXF9/z2RxMD5PNaGc2fZe+74yzvf5XxiZ2T/Z768qAjT+
   vzSXi9LygzOWLq85ieTr1pohi30hubig9JMGYjhOTcbDTS45lYq35wzoZ
   nkNdtJYY9ZA+8MLLvS+zm5lyWFSb8zURcrhMCAL5nF7kMV8FkN86KHQGY
   IojJJKy0LFsUkCyHapOh0qBnPpCdqcfa7XlCnk0i8ubklYnA4unSRQK8H
   sjQWK0H+9eA9nWI/eSw66YvQ3DLksouJQh9TTnFg3MpafIjHvs15gkzU3
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="345112576"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="345112576"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 06:33:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="710499845"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="710499845"
Received: from lkp-server01.sh.intel.com (HELO fb1ced2c09fb) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 01 Jun 2023 06:33:19 -0700
Received: from kbuild by fb1ced2c09fb with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q4iQY-0002Is-27;
        Thu, 01 Jun 2023 13:33:18 +0000
Date:   Thu, 01 Jun 2023 21:32:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/platform] BUILD SUCCESS
 73b3108dfd9d53ea565c0777a27007c1c621467d
Message-ID: <20230601133248.NIqZ6%lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/platform
branch HEAD: 73b3108dfd9d53ea565c0777a27007c1c621467d  x86/platform/uv: Update UV[23] platform code for SNC

elapsed time: 1252m

configs tested: 55
configs skipped: 120

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230531   gcc  
i386                 randconfig-i002-20230531   gcc  
i386                 randconfig-i003-20230531   gcc  
i386                 randconfig-i004-20230531   gcc  
i386                 randconfig-i005-20230531   gcc  
i386                 randconfig-i006-20230531   gcc  
i386                 randconfig-i011-20230531   clang
i386                 randconfig-i012-20230531   clang
i386                 randconfig-i013-20230531   clang
i386                 randconfig-i014-20230531   clang
i386                 randconfig-i015-20230531   clang
i386                 randconfig-i016-20230531   clang
i386                 randconfig-i051-20230531   gcc  
i386                 randconfig-i052-20230531   gcc  
i386                 randconfig-i053-20230531   gcc  
i386                 randconfig-i054-20230531   gcc  
i386                 randconfig-i055-20230531   gcc  
i386                 randconfig-i056-20230531   gcc  
i386                 randconfig-i061-20230531   gcc  
i386                 randconfig-i062-20230531   gcc  
i386                 randconfig-i063-20230531   gcc  
i386                 randconfig-i064-20230531   gcc  
i386                 randconfig-i065-20230531   gcc  
i386                 randconfig-i066-20230531   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230531   gcc  
x86_64               randconfig-a002-20230531   gcc  
x86_64               randconfig-a003-20230531   gcc  
x86_64               randconfig-a004-20230531   gcc  
x86_64               randconfig-a005-20230531   gcc  
x86_64               randconfig-a006-20230531   gcc  
x86_64               randconfig-a011-20230531   clang
x86_64               randconfig-a012-20230531   clang
x86_64               randconfig-a013-20230531   clang
x86_64               randconfig-a014-20230531   clang
x86_64               randconfig-a015-20230531   clang
x86_64               randconfig-a016-20230531   clang
x86_64               randconfig-x051-20230531   clang
x86_64               randconfig-x052-20230531   clang
x86_64               randconfig-x053-20230531   clang
x86_64               randconfig-x054-20230531   clang
x86_64               randconfig-x055-20230531   clang
x86_64               randconfig-x056-20230531   clang
x86_64               randconfig-x061-20230531   clang
x86_64               randconfig-x062-20230531   clang
x86_64               randconfig-x063-20230531   clang
x86_64               randconfig-x064-20230531   clang
x86_64               randconfig-x065-20230531   clang
x86_64               randconfig-x066-20230531   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
