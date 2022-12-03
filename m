Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45746641536
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 10:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbiLCJVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 04:21:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbiLCJVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 04:21:47 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A96195A6C0
        for <linux-kernel@vger.kernel.org>; Sat,  3 Dec 2022 01:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670059306; x=1701595306;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=rtlCrZEnKVZN9COBpHEYIQcCM7QH1RMMGwpU/Ltmnm0=;
  b=K+xCKW4LKgytnJ/q17nkUAqOx81QXYiqDvUj/rP4r6JGHcmA/fRaQjX3
   IU5ElL8CVEmMII37CW4NfZLmwUTWJ2rzlvJFJYzVHj6foPMHuuKX+R7pk
   GmN+hbcTXMyehrntWKOLVorGuNUC3Odt8/RhuBQCvn9tmkTvGtfyhmXDn
   lLSyy/f9pS8fiYjiNz1kvtjNAg2xRECbXerVssGizrTmxmiAUA+mt5aiP
   ZINicOlg+mvi9jxFWkssqDzAWzoQDa3B2sfiHxW4pIjNw+Wcm2T8sepTr
   jDb7CDmy5QnGBOwwcy02wFAx0zqPqjBp9Pg7cM7JUc3K2mLGvsFiU8AER
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="296464627"
X-IronPort-AV: E=Sophos;i="5.96,214,1665471600"; 
   d="scan'208";a="296464627"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2022 01:21:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="751571988"
X-IronPort-AV: E=Sophos;i="5.96,214,1665471600"; 
   d="scan'208";a="751571988"
Received: from lkp-server01.sh.intel.com (HELO 64a2d449c951) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 03 Dec 2022 01:21:45 -0800
Received: from kbuild by 64a2d449c951 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p1OiO-000ER9-24;
        Sat, 03 Dec 2022 09:21:44 +0000
Date:   Sat, 03 Dec 2022 17:21:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 3170a767052ac5432547a2d8c9d4753d82b45f38
Message-ID: <638b150b.eHMsockB9kIG0KJi%lkp@intel.com>
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
branch HEAD: 3170a767052ac5432547a2d8c9d4753d82b45f38  Merge x86/sgx into tip/master

elapsed time: 725m

configs tested: 58
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
um                             i386_defconfig
alpha                               defconfig
powerpc                           allnoconfig
um                           x86_64_defconfig
m68k                             allmodconfig
m68k                             allyesconfig
s390                                defconfig
alpha                            allyesconfig
sh                               allmodconfig
s390                             allmodconfig
arc                              allyesconfig
mips                             allyesconfig
x86_64                              defconfig
powerpc                          allmodconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
ia64                             allmodconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
s390                             allyesconfig
x86_64                        randconfig-a015
x86_64                               rhel-8.3
x86_64                           rhel-8.3-syz
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                           rhel-8.3-kvm
arc                  randconfig-r043-20221201
x86_64                           allyesconfig
x86_64                         rhel-8.3-kunit
riscv                randconfig-r042-20221201
x86_64                        randconfig-a006
s390                 randconfig-r044-20221201
i386                                defconfig
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
i386                             allyesconfig
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig

clang tested configs:
x86_64                        randconfig-a014
x86_64                        randconfig-a012
x86_64                        randconfig-a016
hexagon              randconfig-r045-20221201
x86_64                        randconfig-a001
hexagon              randconfig-r041-20221201
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
