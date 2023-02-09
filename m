Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7C72691182
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 20:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbjBITpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 14:45:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjBITpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 14:45:00 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 329125AB38
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 11:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675971899; x=1707507899;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Rfi2aUQmazxGL163Vf4H2PXHnYFMjNmDK8WxON/Futs=;
  b=VG1TUHw4v3n4/ezoHGe5P/gDMV0jz0iV/8a0995Mi4XWVaqOEqH2+UGs
   nYglwqKoL9rECqd7AtbuB2JxsgdE65fvsghF76TbxHhzVvFdz2SBlChVd
   C8HVETa3cVbDGzXUrBHis00TXyHElj9wwyd0iqtUZyfvOcbKeqRr8Zu+u
   /z4YdfusJN++GBHXFW6qdUqzMoiksSSNIMSwJyDlmjr8CbpJF99A2XugP
   iKuTNBSo4zHHU1pUWHnXLKlNG4qJQnzwzuSmeCRlcuabLr1fcNrD5SELX
   3wTC02Yxni07/A50C1HJ3euUC67yaQd2AywBNXUI7ktjk5hX9bW4V0WK4
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="327917857"
X-IronPort-AV: E=Sophos;i="5.97,284,1669104000"; 
   d="scan'208";a="327917857"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 11:44:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="996667205"
X-IronPort-AV: E=Sophos;i="5.97,284,1669104000"; 
   d="scan'208";a="996667205"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 09 Feb 2023 11:44:57 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pQCqn-0005Gu-0T;
        Thu, 09 Feb 2023 19:44:57 +0000
Date:   Fri, 10 Feb 2023 03:44:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 82ba9196cce8f41617e1a3d0d39242df3f5f9773
Message-ID: <63e54d19.W9PJMaBYAoFgJY2E%lkp@intel.com>
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
branch HEAD: 82ba9196cce8f41617e1a3d0d39242df3f5f9773  Merge branch into tip/master: 'x86/urgent'

elapsed time: 726m

configs tested: 61
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
x86_64                              defconfig
arc                                 defconfig
x86_64                               rhel-8.3
s390                             allmodconfig
um                             i386_defconfig
alpha                               defconfig
um                           x86_64_defconfig
s390                                defconfig
x86_64                           allyesconfig
s390                             allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
i386                                defconfig
x86_64                           rhel-8.3-bpf
powerpc                           allnoconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
arc                  randconfig-r043-20230209
arm                  randconfig-r046-20230209
x86_64                        randconfig-a004
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
arm                                 defconfig
x86_64                        randconfig-a002
m68k                             allyesconfig
x86_64                        randconfig-a006
ia64                             allmodconfig
i386                          randconfig-a014
i386                             allyesconfig
i386                          randconfig-a012
i386                          randconfig-a016
sh                               allmodconfig
arm64                            allyesconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
arm                              allyesconfig
x86_64                        randconfig-a015
mips                             allyesconfig
powerpc                          allmodconfig
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005

clang tested configs:
x86_64                          rhel-8.3-rust
hexagon              randconfig-r041-20230209
hexagon              randconfig-r045-20230209
s390                 randconfig-r044-20230209
riscv                randconfig-r042-20230209
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
x86_64                        randconfig-a014
x86_64                        randconfig-a012
x86_64                        randconfig-a016
i386                          randconfig-a002
i386                          randconfig-a004

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
