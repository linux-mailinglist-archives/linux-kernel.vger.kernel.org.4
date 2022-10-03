Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D34B5F2E70
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 11:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiJCJtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 05:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbiJCJs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 05:48:58 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0C6237D1
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 02:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664790495; x=1696326495;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=v0/CSTqTBmDg9sHo4TttT5CwF/0+IbZXTZqK5IewPn4=;
  b=nmXnUjNaGCliMDvq3eq91u4yfkKLJ8dYCsXN763UkTfd1CNGH59IIhru
   7nPD6RiWmxdQTMEzmdDWToa1tNBONIBpsbmmZONgEz62zmmNxUpzrU2i/
   ULkkfwriWFf1qlQvPRC6DrTLwKzTFfCjLJfPjxZVPo+RvO0OlhYpifXgv
   hV+KNIqxuVtw82CsMnL03MKg4hZzvhudLdK1c3Psj1obWxSW8gwD7fDAF
   EOM/z6VqS898OuSFn+IeJfM06C5LZV4ULuYS4ZsLjJXP3Xs45T5FZVTuI
   bvPMBJsJfH4hlhRwwq3yuW7AhtcclwNlPv5RBFdSmgyKHRTfISO2L55w0
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10488"; a="302570505"
X-IronPort-AV: E=Sophos;i="5.93,365,1654585200"; 
   d="scan'208";a="302570505"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2022 02:48:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10488"; a="727694008"
X-IronPort-AV: E=Sophos;i="5.93,365,1654585200"; 
   d="scan'208";a="727694008"
Received: from lkp-server01.sh.intel.com (HELO 14cc182da2d0) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 03 Oct 2022 02:48:13 -0700
Received: from kbuild by 14cc182da2d0 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ofI3Y-0004US-2S;
        Mon, 03 Oct 2022 09:48:12 +0000
Date:   Mon, 03 Oct 2022 17:47:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 03c739a21613a1a85f730dd972ff928e573f7235
Message-ID: <633aafca.efx6uwX/6rOoxJ1G%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 03c739a21613a1a85f730dd972ff928e573f7235  Merge branch into tip/master: 'x86/timers'

elapsed time: 724m

configs tested: 63
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
arm                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
riscv                randconfig-r042-20221003
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                              defconfig
m68k                             allmodconfig
arc                  randconfig-r043-20221003
powerpc                           allnoconfig
i386                 randconfig-a011-20221003
arm                              allyesconfig
x86_64                           allyesconfig
s390                             allyesconfig
i386                 randconfig-a012-20221003
arc                              allyesconfig
arm64                            allyesconfig
x86_64               randconfig-a011-20221003
x86_64                         rhel-8.3-kunit
powerpc                          allmodconfig
i386                                defconfig
sh                               allmodconfig
i386                 randconfig-a013-20221003
x86_64                           rhel-8.3-kvm
x86_64                    rhel-8.3-kselftests
mips                             allyesconfig
i386                 randconfig-a015-20221003
alpha                            allyesconfig
arc                  randconfig-r043-20221002
x86_64                               rhel-8.3
i386                 randconfig-a016-20221003
x86_64               randconfig-a014-20221003
s390                 randconfig-r044-20221003
i386                 randconfig-a014-20221003
x86_64               randconfig-a012-20221003
m68k                             allyesconfig
x86_64               randconfig-a013-20221003
x86_64               randconfig-a016-20221003
ia64                             allmodconfig
x86_64               randconfig-a015-20221003
i386                             allyesconfig

clang tested configs:
hexagon              randconfig-r041-20221003
riscv                randconfig-r042-20221002
hexagon              randconfig-r041-20221002
s390                 randconfig-r044-20221002
i386                 randconfig-a003-20221003
i386                 randconfig-a002-20221003
i386                 randconfig-a001-20221003
i386                 randconfig-a004-20221003
hexagon              randconfig-r045-20221002
i386                 randconfig-a005-20221003
hexagon              randconfig-r045-20221003
i386                 randconfig-a006-20221003
x86_64               randconfig-a003-20221003
x86_64               randconfig-a005-20221003
x86_64               randconfig-a002-20221003
x86_64               randconfig-a001-20221003
x86_64               randconfig-a004-20221003
x86_64               randconfig-a006-20221003

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
