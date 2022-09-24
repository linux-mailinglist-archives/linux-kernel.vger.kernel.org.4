Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2FA5E8F10
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 19:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234002AbiIXRyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 13:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233999AbiIXRyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 13:54:50 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC2615FDC
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 10:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664042089; x=1695578089;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=vPMgKVYqTac2HGMz6Al4RtzE/aSAmAwmYml027N60gc=;
  b=Hveut+apL4ql4I9eLXzLeORppXT3VevfWEySPS56Wv3o44BFu/8UdP+N
   On6nfStFtquA0t02MNEHe88u1wWceGWckKEEgkV0fZNQTU9UqOMcnrd/n
   cRVjE3nwhinwNrwEQtA9Vai7WsYCdZklWfiROG4barshYmP1bOmvgoIDx
   JZgANWI9AP8J5W9y/lwaHC2dxKALEQCavK+ywkCRcm02z1cJ0MgiR7i4l
   WmIaziz+/Shd/tYU64e8jMTTaBkJUO9sgAif4Lj6nl+2Us9YWZSzcU21/
   b7sm+mlFRjoqCgpT3FekyntDUPS9YuGqyBgdtkbBUogUWCwEy5GhSYakG
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10480"; a="301693649"
X-IronPort-AV: E=Sophos;i="5.93,342,1654585200"; 
   d="scan'208";a="301693649"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2022 10:54:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,342,1654585200"; 
   d="scan'208";a="949387907"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 24 Sep 2022 10:54:47 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oc9MU-0006qW-2E;
        Sat, 24 Sep 2022 17:54:46 +0000
Date:   Sun, 25 Sep 2022 01:54:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:lazy.2022.09.23a] BUILD SUCCESS
 468dfaac6097bfc3ae0428189e85e7909a1685f3
Message-ID: <632f4447.7sXOVCTDsNaWJwaW%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git lazy.2022.09.23a
branch HEAD: 468dfaac6097bfc3ae0428189e85e7909a1685f3  percpu-refcount: Use call_rcu_flush() for atomic switch

elapsed time: 1182m

configs tested: 58
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                           x86_64_defconfig
um                             i386_defconfig
arc                                 defconfig
alpha                               defconfig
s390                                defconfig
s390                             allmodconfig
s390                             allyesconfig
arc                  randconfig-r043-20220923
powerpc                          allmodconfig
s390                 randconfig-r044-20220923
mips                             allyesconfig
powerpc                           allnoconfig
x86_64                          rhel-8.3-func
riscv                randconfig-r042-20220923
sh                               allmodconfig
x86_64                    rhel-8.3-kselftests
m68k                             allyesconfig
x86_64                              defconfig
x86_64                           allyesconfig
alpha                            allyesconfig
x86_64                               rhel-8.3
i386                                defconfig
m68k                             allmodconfig
arc                              allyesconfig
i386                          randconfig-a001
x86_64                        randconfig-a004
i386                          randconfig-a003
x86_64                        randconfig-a002
arm                                 defconfig
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                        randconfig-a011
i386                          randconfig-a014
x86_64                        randconfig-a015
x86_64                        randconfig-a006
arm64                            allyesconfig
i386                          randconfig-a012
arm                              allyesconfig
i386                          randconfig-a016
i386                             allyesconfig
ia64                             allmodconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit

clang tested configs:
hexagon              randconfig-r045-20220923
hexagon              randconfig-r041-20220923
i386                          randconfig-a002
x86_64                        randconfig-a005
i386                          randconfig-a006
x86_64                        randconfig-a001
x86_64                        randconfig-a012
i386                          randconfig-a004
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
x86_64                        randconfig-a003
i386                          randconfig-a013
i386                          randconfig-a015

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
