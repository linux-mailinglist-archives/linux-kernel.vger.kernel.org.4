Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B36665BA98
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 07:08:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232926AbjACGI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 01:08:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbjACGI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 01:08:27 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F5E6B4BD
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 22:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672726106; x=1704262106;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=PguATooUdI/myFRIH136evSbjRtn9H5zMiAKwOG0Ioo=;
  b=GD5cC9BtawLKailPNUamljJCm7jYn3a3SuXpN6Fkgr8sNad9Lm6uWCJ9
   /7HZTRm/gLiNbjnyXDx9xMCkAH/5RAD/PFfW8jOwYy8ugNNI80rBUkXKM
   Wa1TmTXlO7/uz+vqHscLleSTgtdj1GcQqN+AehaaSYHOxOjqtoGH9tANy
   Si+AoPd/4cxbntRycSurjuQXcSUeidqmBqWa6S+pis598ONtv0OXjeain
   6zhdcFuvIifS9QsIo3+1SOQdNdkca17E1AeGq+jDviVkBUm7zU8cMsvTy
   YIe0GICuixyPwmn+N3byLurMzrxumvO58GxWk5Uy5lPu+iF6COZ0WABz/
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="305098561"
X-IronPort-AV: E=Sophos;i="5.96,296,1665471600"; 
   d="scan'208";a="305098561"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2023 22:08:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="983465823"
X-IronPort-AV: E=Sophos;i="5.96,296,1665471600"; 
   d="scan'208";a="983465823"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 02 Jan 2023 22:08:24 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pCaTI-000Rpx-06;
        Tue, 03 Jan 2023 06:08:24 +0000
Date:   Tue, 03 Jan 2023 14:07:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 d00dd2f2645dca04cf399d8fc692f3f69b6dd996
Message-ID: <63b3c622.J6Rrl0ByF0IiwgZd%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: d00dd2f2645dca04cf399d8fc692f3f69b6dd996  x86/kexec: Fix double-free of elf header buffer

elapsed time: 723m

configs tested: 37
configs skipped: 74

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                           rhel-8.3-bpf
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
i386                 randconfig-a004-20230102
i386                 randconfig-a003-20230102
i386                 randconfig-a001-20230102
x86_64                              defconfig
i386                 randconfig-a002-20230102
i386                                defconfig
i386                 randconfig-a005-20230102
i386                 randconfig-a006-20230102
x86_64                               rhel-8.3
x86_64               randconfig-a001-20230102
x86_64               randconfig-a004-20230102
x86_64               randconfig-a002-20230102
x86_64               randconfig-a003-20230102
x86_64               randconfig-a005-20230102
x86_64               randconfig-a006-20230102
x86_64                           allyesconfig
i386                             allyesconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                            allnoconfig

clang tested configs:
x86_64                          rhel-8.3-rust
x86_64               randconfig-a011-20230102
x86_64               randconfig-a014-20230102
x86_64               randconfig-a012-20230102
x86_64               randconfig-a013-20230102
i386                 randconfig-a011-20230102
x86_64               randconfig-a015-20230102
x86_64               randconfig-a016-20230102
i386                 randconfig-a014-20230102
i386                 randconfig-a013-20230102
i386                 randconfig-a012-20230102
i386                 randconfig-a015-20230102
i386                 randconfig-a016-20230102

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
