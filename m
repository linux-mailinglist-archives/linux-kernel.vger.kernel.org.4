Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C979D65FD57
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 10:14:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232327AbjAFJO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 04:14:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232090AbjAFJOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 04:14:19 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F8E368CB2
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 01:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672996459; x=1704532459;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=lXX3kVtUdFGdQ+dt/tM7DbgPU2bn5vstIx45ed5LC+A=;
  b=ZPzoGBy94fMbB4xCB297ADPP5fUhyW/lk8a367rPSsNoFJDgpWrBYXPw
   2tgiMCfx4VJWy8TinaqxorQRnnu2KplH4R8Erxx5T9e+tuSheMKfcswGy
   NHKE8xCbX+gNwqoX+0ga6iiSfs2qbnpWLC0L4FwqCrmiiK4GUqCjxe3NZ
   fbqc6tEF2fz6xWGDToiDRDCbMNTqbV/+98VqS9q6oke1dabEjBtMF+n1m
   iZOXu/eRng4c2zzxJi4dgzZZ6uPPZmxPOseUZ/HPgJSsLmRM3jD6bVgUA
   5Oat5vvyy2hMTn4OBrPn+M1CdlTi1ph4vIv0aXXxWyLr79x0eynwtdy9t
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="302141048"
X-IronPort-AV: E=Sophos;i="5.96,304,1665471600"; 
   d="scan'208";a="302141048"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2023 01:14:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="763461839"
X-IronPort-AV: E=Sophos;i="5.96,304,1665471600"; 
   d="scan'208";a="763461839"
Received: from lkp-server02.sh.intel.com (HELO f1920e93ebb5) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 06 Jan 2023 01:14:17 -0800
Received: from kbuild by f1920e93ebb5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pDino-0003B8-2p;
        Fri, 06 Jan 2023 09:14:16 +0000
Date:   Fri, 06 Jan 2023 17:13:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2023.01.04a] BUILD SUCCESS
 837ec846852c2f8c8fa9f7f676319448df023410
Message-ID: <63b7e645.JT0KvxhRV99ZmAWf%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2023.01.04a
branch HEAD: 837ec846852c2f8c8fa9f7f676319448df023410  squash! x86/tsc: Add option to force frequency recalibration with HW timer

elapsed time: 727m

configs tested: 56
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
powerpc                           allnoconfig
x86_64                            allnoconfig
sh                               allmodconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                           rhel-8.3-bpf
mips                             allyesconfig
x86_64                           rhel-8.3-syz
powerpc                          allmodconfig
x86_64                         rhel-8.3-kunit
i386                          randconfig-a001
x86_64                           rhel-8.3-kvm
x86_64                              defconfig
i386                          randconfig-a003
x86_64                               rhel-8.3
arm                                 defconfig
alpha                            allyesconfig
i386                          randconfig-a005
i386                                defconfig
x86_64                           allyesconfig
arc                  randconfig-r043-20230105
m68k                             allyesconfig
m68k                             allmodconfig
ia64                             allmodconfig
arm64                            allyesconfig
arc                  randconfig-r043-20230106
arc                              allyesconfig
arm                              allyesconfig
i386                          randconfig-a014
x86_64                    rhel-8.3-kselftests
i386                          randconfig-a012
arc                                 defconfig
x86_64                          rhel-8.3-func
s390                             allmodconfig
i386                          randconfig-a016
alpha                               defconfig
s390                                defconfig
arm                  randconfig-r046-20230106
s390                             allyesconfig
s390                 randconfig-r044-20230105
i386                             allyesconfig
riscv                randconfig-r042-20230105

clang tested configs:
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
i386                          randconfig-a013
i386                          randconfig-a015
arm                  randconfig-r046-20230105
x86_64                          rhel-8.3-rust
i386                          randconfig-a011
hexagon              randconfig-r041-20230106
hexagon              randconfig-r041-20230105
hexagon              randconfig-r045-20230106
hexagon              randconfig-r045-20230105
riscv                randconfig-r042-20230106
s390                 randconfig-r044-20230106

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
