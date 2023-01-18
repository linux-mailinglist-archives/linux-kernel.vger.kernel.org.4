Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7BBE672CF5
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 00:51:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbjARXvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 18:51:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbjARXu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 18:50:58 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C76474E3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 15:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674085775; x=1705621775;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=29da6H8sjbAnbl9ZczN2Qzf1yt4HZkNXXjnqMsOnqoY=;
  b=RTDDy20aEwPGeWcGrvnc2K3wGmZYSvHaYERxM1Bu25QnqbdEct54fodU
   H7LkMCk0Y2A//2+WHZpiuTx+pUJolxbKbSfsA1w5jucU8XE/pWDwhcM2o
   NjITE8+ChE5gLTYcxMkQl797BkmDo3Bu5imw8mZVHToR5YgQ5F1+IsjX8
   jaAs59p36Er+gqma4nNQI82C/+uHk/iU/0vqLBBB0nnV7/trNUnpb8zYj
   pk8LpiM1RxFHqnDiY44FdOLDVqnFaOuR+bfzhU0lroE3mBmht9cbx6V9h
   6QeX8HU50PAscNySHzPftWEYuIwNNi12WdMp7VLM9y3z1e4ipWUbNwQUw
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="411377365"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="411377365"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 15:48:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="802412935"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="802412935"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 18 Jan 2023 15:48:20 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pIIAF-0000p8-1W;
        Wed, 18 Jan 2023 23:48:19 +0000
Date:   Thu, 19 Jan 2023 07:47:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:sched/core] BUILD SUCCESS
 19235e47279894b033a3ec5cf2732de634862b3a
Message-ID: <63c88513.XqNc/emGrjYKTRNF%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
branch HEAD: 19235e47279894b033a3ec5cf2732de634862b3a  cpuidle, arm64: Fix the ARM64 cpuidle logic

elapsed time: 725m

configs tested: 62
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                            allnoconfig
arc                                 defconfig
alpha                               defconfig
arc                              allyesconfig
alpha                            allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
mips                             allyesconfig
x86_64                           rhel-8.3-bpf
m68k                             allmodconfig
x86_64                         rhel-8.3-kunit
m68k                             allyesconfig
x86_64                              defconfig
i386                                defconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
arm                                 defconfig
sh                               allmodconfig
x86_64                               rhel-8.3
s390                                defconfig
s390                             allmodconfig
ia64                             allmodconfig
x86_64                           allyesconfig
arm64                            allyesconfig
arm                              allyesconfig
x86_64                        randconfig-a013
arc                  randconfig-r043-20230118
x86_64                        randconfig-a011
s390                 randconfig-r044-20230118
riscv                randconfig-r042-20230118
s390                             allyesconfig
x86_64                        randconfig-a015
i386                             allyesconfig
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a014
i386                          randconfig-a012
x86_64                    rhel-8.3-kselftests
i386                          randconfig-a005
x86_64                          rhel-8.3-func
i386                          randconfig-a016
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006

clang tested configs:
hexagon              randconfig-r045-20230118
hexagon              randconfig-r041-20230118
x86_64                        randconfig-a012
arm                  randconfig-r046-20230118
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a002
i386                          randconfig-a011
i386                          randconfig-a004
i386                          randconfig-a013
x86_64                          rhel-8.3-rust
i386                          randconfig-a015
i386                          randconfig-a006
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
