Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 991A9606F45
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 07:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbiJUFMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 01:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbiJUFMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 01:12:51 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09482265BE
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 22:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666329165; x=1697865165;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=6WpN2Lg3pMqfR9fmIK69ThAMCy8x3s4EoYHifHAmN8w=;
  b=KNL11P1JJVuCodeQQa2KbnNbprWsna/kmR5yqfUxseJyz43dNLHD9i3B
   BoXQgYDRMkVzwwy3HBNL7oBOx2gYoD9dZ7JJV5khikO1Llql3TNNvrj9q
   LugxtDqWA2yFE9x27l3NKZ/FyKbxiRRvBJd9U+ugY32cPcmMy5VFprlLw
   Bi+3Gh3a8G6ldT8nwHGqb9/NEK/vpke/L6+Jzo/MMHEi0ZoXEPLaIStUv
   h5Y6PWq7gfXaYfY11u68hp9cJpiUBaS9eDhK0LLnQ0FhA6UVmoP6lg/KU
   +RRwG9rs9PU2dh1YX4bLUx/Y7w6w0WZDGe9+zZyevGcPdlbuW9gAAvKV9
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="308011308"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="308011308"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 22:12:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="661385117"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="661385117"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 20 Oct 2022 22:12:27 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1olkKY-0002Cz-2V;
        Fri, 21 Oct 2022 05:12:26 +0000
Date:   Fri, 21 Oct 2022 13:12:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:6.1-rc1-Wcast-function-type-strict] BUILD SUCCESS
 f125e61a737480c6e11005ea08684baea11e1b97
Message-ID: <63522a28.Nf/wAePbS9g70xVe%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git 6.1-rc1-Wcast-function-type-strict
branch HEAD: f125e61a737480c6e11005ea08684baea11e1b97  airo: Avoid clashing function prototypes

elapsed time: 2888m

configs tested: 66
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                  randconfig-r043-20221019
arc                                 defconfig
alpha                               defconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
i386                                defconfig
s390                                defconfig
s390                             allmodconfig
s390                             allyesconfig
x86_64                              defconfig
i386                          randconfig-a014
i386                          randconfig-a012
x86_64                          rhel-8.3-func
i386                          randconfig-a016
x86_64                    rhel-8.3-kselftests
powerpc                           allnoconfig
x86_64                               rhel-8.3
powerpc                          allmodconfig
i386                          randconfig-a001
mips                             allyesconfig
i386                          randconfig-a003
sh                               allmodconfig
i386                             allyesconfig
x86_64                           allyesconfig
i386                          randconfig-a005
arm                                 defconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a015
x86_64                        randconfig-a006
arm                              allyesconfig
arm64                            allyesconfig
m68k                             allmodconfig
alpha                            allyesconfig
arc                              allyesconfig
m68k                             allyesconfig
arc                  randconfig-r043-20221018
s390                 randconfig-r044-20221018
riscv                randconfig-r042-20221018

clang tested configs:
riscv                randconfig-r042-20221019
hexagon              randconfig-r045-20221019
hexagon              randconfig-r041-20221019
s390                 randconfig-r044-20221019
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a012
x86_64                        randconfig-a005
x86_64                        randconfig-a014
x86_64                        randconfig-a001
x86_64                        randconfig-a016
x86_64                        randconfig-a003
i386                 randconfig-a013-20221017
i386                 randconfig-a015-20221017
i386                 randconfig-a016-20221017
i386                 randconfig-a011-20221017
i386                 randconfig-a014-20221017
i386                 randconfig-a012-20221017

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
