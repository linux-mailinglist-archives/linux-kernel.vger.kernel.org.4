Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A75A05F019A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 01:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbiI2X7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 19:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiI2X7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 19:59:31 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21EAF118B26
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 16:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664495969; x=1696031969;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=G/p4X+4pvS7fX4SZKuO25mW33MpqEWllIR3O8dFyh4A=;
  b=e1b3hjGLxfcjjOyp406pTWlnOvs4aR7jtFeuJAV6tHl+ir1yGFgA9abu
   jUJ0AoWKMvQ/f4GwGD9V0CL0j2kraf7h/cWzNORVogj9+PbdbbZRlF51u
   E/hOpvlZ4KBZPl/hPXgcGRr8pPi8SfNLLcssd2ofDLV6rAONc2OizZQy+
   YwVbyGC2p+e8bEbJvt3RnV0BjA97vDnEbBJZnCJHDkCV10/5w4t1vnL10
   0/CinsttQN4jJgARPS2QBPANr036MZnKuxsOnEyguOpnjVJ1c0spQRWVq
   sCY+R4isPAvo/Kwxzn/AtMNvCgMSdK19rndWN+rLGpSe/JM1EqCRCYsbu
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="328437184"
X-IronPort-AV: E=Sophos;i="5.93,356,1654585200"; 
   d="scan'208";a="328437184"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 16:59:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="573664969"
X-IronPort-AV: E=Sophos;i="5.93,356,1654585200"; 
   d="scan'208";a="573664969"
Received: from lkp-server01.sh.intel.com (HELO 6126f2790925) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 29 Sep 2022 16:59:26 -0700
Received: from kbuild by 6126f2790925 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oe3R7-0001mo-2y;
        Thu, 29 Sep 2022 23:59:25 +0000
Date:   Fri, 30 Sep 2022 07:58:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:lazy.2022.09.23a] BUILD SUCCESS
 cf0fad926042a48185321f412f2542dfc3352b54
Message-ID: <63363139.q9uFZHZPz2nD+nZv%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git lazy.2022.09.23a
branch HEAD: cf0fad926042a48185321f412f2542dfc3352b54  rcutorture: Convert call_rcu() to call_rcu_flush()

elapsed time: 1142m

configs tested: 58
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
powerpc                           allnoconfig
arc                                 defconfig
alpha                               defconfig
um                             i386_defconfig
um                           x86_64_defconfig
s390                                defconfig
s390                             allmodconfig
sh                               allmodconfig
x86_64                          rhel-8.3-func
s390                             allyesconfig
x86_64                    rhel-8.3-kselftests
i386                                defconfig
powerpc                          allmodconfig
mips                             allyesconfig
x86_64                              defconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                               rhel-8.3
m68k                             allmodconfig
i386                             allyesconfig
arc                              allyesconfig
x86_64                           allyesconfig
alpha                            allyesconfig
x86_64               randconfig-a004-20220926
m68k                             allyesconfig
x86_64               randconfig-a001-20220926
x86_64               randconfig-a003-20220926
arc                  randconfig-r043-20220928
x86_64               randconfig-a002-20220926
x86_64               randconfig-a005-20220926
x86_64               randconfig-a006-20220926
i386                 randconfig-a001-20220926
i386                 randconfig-a004-20220926
i386                 randconfig-a005-20220926
i386                 randconfig-a002-20220926
i386                 randconfig-a003-20220926
i386                 randconfig-a006-20220926
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
ia64                             allmodconfig

clang tested configs:
hexagon              randconfig-r045-20220928
s390                 randconfig-r044-20220928
hexagon              randconfig-r041-20220928
riscv                randconfig-r042-20220928
x86_64               randconfig-a012-20220926
x86_64               randconfig-a014-20220926
x86_64               randconfig-a016-20220926
x86_64               randconfig-a013-20220926
i386                          randconfig-a013
x86_64               randconfig-a011-20220926
x86_64               randconfig-a015-20220926
i386                          randconfig-a015
i386                          randconfig-a011

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
