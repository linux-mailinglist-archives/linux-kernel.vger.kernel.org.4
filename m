Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35C9B67F3AD
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 02:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232828AbjA1BVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 20:21:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233468AbjA1BVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 20:21:05 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E22E7C73C
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 17:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674868865; x=1706404865;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=g3Nv5PHpzob7WbSyaA3UmVukV18fDlH5HdnGlBuUieE=;
  b=VKEDTkNZL8iyuxZ2/cfesq0ds4hlpsslppq/jy/W7ZmWzjhNlNWEQOSP
   jCpPUsOrxn+pAE9Y8I7xLfpwes8E7J3kH0JoR3Xi7Jun7CSawzJ5gZlqH
   6mrKQQChsuBZ6BSSgzBHzpbC3yODvQ80MoCPoA8fjmyBSFWbeXzLm2D1s
   I2cIm5VkPHIquwkHaychBD4ZczuiAZm1prr9vLB9UkYrrvfP0jqG/XPdi
   qhW6BAM1HRPu6C6QlxMig79a+pbbOgta3820qeulj1mEKUDloKR7efkcf
   yV6A6jIrOS73BJJP7GSzRedjLgvYdjNMq/Qiu4rAt1QfH+OrJ1EkxI6mv
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="307587327"
X-IronPort-AV: E=Sophos;i="5.97,252,1669104000"; 
   d="scan'208";a="307587327"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 17:21:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="695722643"
X-IronPort-AV: E=Sophos;i="5.97,252,1669104000"; 
   d="scan'208";a="695722643"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 27 Jan 2023 17:21:03 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pLZtu-0000CD-27;
        Sat, 28 Jan 2023 01:21:02 +0000
Date:   Sat, 28 Jan 2023 09:20:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/vdso] BUILD SUCCESS
 4c382d723edce1b3c72b55b1b505cf5526a56afc
Message-ID: <63d47855.Mv4Io6smwVqDSk+l%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/vdso
branch HEAD: 4c382d723edce1b3c72b55b1b505cf5526a56afc  x86/vdso: Move VDSO image init to vdso2c generated code

elapsed time: 3700m

configs tested: 28
configs skipped: 42

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-bpf
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
i386                 randconfig-a003-20230123
i386                 randconfig-a002-20230123
i386                 randconfig-a001-20230123
i386                 randconfig-a005-20230123
i386                 randconfig-a006-20230123
i386                 randconfig-a004-20230123
i386                                defconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                             allyesconfig
x86_64                        randconfig-a006

clang tested configs:
x86_64                          rhel-8.3-rust
x86_64               randconfig-a013-20230123
x86_64               randconfig-a011-20230123
x86_64                        randconfig-a001
x86_64               randconfig-a012-20230123
x86_64               randconfig-a014-20230123
x86_64                        randconfig-a003

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
