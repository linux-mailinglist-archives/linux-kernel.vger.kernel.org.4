Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60FC867F393
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 02:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232260AbjA1BMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 20:12:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232455AbjA1BMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 20:12:51 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C8D1BC0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 17:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674868366; x=1706404366;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=l0bm41exO7gHjsY9lzGNtvoSM5WTwpvq/qqfwvMA+kc=;
  b=jyYU5JoQyXZ0aatHs3j6kn9Qw4mQtT+VSCA0AlKB2H/3RiWz74zxEAlo
   8q6ELVjkODwWEh1bvBSduPtGMXK2Umk+2yVXLNaW6B5w1UCVtt8UQxO4i
   x7pKgc3giBsKqMDXdUj3IE0UjnzG0TgY5UdhRih76iMYc3zXAwEyoeD/t
   lomHgObashI/SQkIqDIWErzC/Jpmulj2PGfj1WH8LsuInyRdV2uH4Gwtp
   iIu96JI/lD46iSzyv+G66yW17OKqbq8gQF42dPCHtXmFd/jPtcb/Ovfai
   P0VHxNO/pMpPdbWgJIp4m1H5ll8OxfjwM+KSfMDFqklydLymvfnPhP/uV
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="354546154"
X-IronPort-AV: E=Sophos;i="5.97,252,1669104000"; 
   d="scan'208";a="354546154"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 17:12:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="665445987"
X-IronPort-AV: E=Sophos;i="5.97,252,1669104000"; 
   d="scan'208";a="665445987"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 27 Jan 2023 17:12:43 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pLZlq-0000Ab-17;
        Sat, 28 Jan 2023 01:12:42 +0000
Date:   Sat, 28 Jan 2023 09:12:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/fpu] BUILD SUCCESS
 cb3ea4b7671b7cfbac3ee609976b790aebd0bbda
Message-ID: <63d4766e.1TsIAARmjBjW8eWC%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/fpu
branch HEAD: cb3ea4b7671b7cfbac3ee609976b790aebd0bbda  x86/fpu: Don't set TIF_NEED_FPU_LOAD for PF_IO_WORKER threads

elapsed time: 3693m

configs tested: 31
configs skipped: 42

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
i386                                defconfig
x86_64                              defconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-bpf
x86_64                               rhel-8.3
x86_64                           allyesconfig
i386                 randconfig-a004-20230123
i386                 randconfig-a003-20230123
x86_64               randconfig-a002-20230123
x86_64               randconfig-a001-20230123
i386                 randconfig-a002-20230123
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
i386                 randconfig-a001-20230123
x86_64               randconfig-a006-20230123
i386                 randconfig-a005-20230123
i386                 randconfig-a006-20230123
i386                             allyesconfig
x86_64               randconfig-a004-20230123
x86_64               randconfig-a003-20230123

clang tested configs:
x86_64                          rhel-8.3-rust
x86_64               randconfig-a013-20230123
x86_64               randconfig-a011-20230123
x86_64               randconfig-a012-20230123
x86_64               randconfig-a016-20230123
i386                 randconfig-a011-20230123
x86_64               randconfig-a015-20230123
x86_64               randconfig-a014-20230123

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
