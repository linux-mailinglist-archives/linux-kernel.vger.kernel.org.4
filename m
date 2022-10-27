Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64C3060EEED
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 06:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234436AbiJ0EIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 00:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233692AbiJ0EIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 00:08:35 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FE61153E39
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 21:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666843715; x=1698379715;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=4FyUw9z8KG6AnByUsWPuGoqEj6IT4K/cVJ+Vmdq6vds=;
  b=DQEX5+okXnaF3Rc7FS5aUTsixW7UxhSd9iczco2bLeCgbg7AHXEJJI0A
   9Re5HHLs/gnHSHyp3Oc0ZUI92De+QQ8WXyL0HxOCv+7XTu1c/hA6NeXz1
   CyUrzejkw+8nr+nnISG4H1GEGzBDYEfobpyNwzPYNe0628WkSTH0mi1Yq
   z7QlcnymNCzK/MuGRb8hKTJO/T/FRAHaSKh+R5PNZ6fU0Dx3vDp5j2v8c
   wmRZDEnKaHvfY41iIBQPumOTO30CMbYKC9/+Ml7jNp/qOaRUIkL8XC1no
   BN/KLRcYIw8p7twcBTrOxoX9Rw8KgplJbovT99rnwPGkCPatMw1fl7aur
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="291427320"
X-IronPort-AV: E=Sophos;i="5.95,215,1661842800"; 
   d="scan'208";a="291427320"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 21:08:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="627027335"
X-IronPort-AV: E=Sophos;i="5.95,215,1661842800"; 
   d="scan'208";a="627027335"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 26 Oct 2022 21:08:33 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1onuC1-0008FL-0L;
        Thu, 27 Oct 2022 04:08:33 +0000
Date:   Thu, 27 Oct 2022 12:08:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:6.1-rc1-Wcast-function-type-strict] BUILD SUCCESS
 34bf3ce1b1ca2da4c5ec8a6e26f31bbb9ca1c4f5
Message-ID: <635a0428.iz8fbjPkqeSJ2tAI%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git 6.1-rc1-Wcast-function-type-strict
branch HEAD: 34bf3ce1b1ca2da4c5ec8a6e26f31bbb9ca1c4f5  staging: ks7010: Avoid clashing function prototypes

elapsed time: 725m

configs tested: 58
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
s390                             allyesconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                              defconfig
ia64                             allmodconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
powerpc                           allnoconfig
powerpc                          allmodconfig
riscv                randconfig-r042-20221026
arc                  randconfig-r043-20221026
m68k                             allmodconfig
x86_64                        randconfig-a004
arc                              allyesconfig
s390                 randconfig-r044-20221026
mips                             allyesconfig
sh                               allmodconfig
alpha                            allyesconfig
i386                                defconfig
x86_64                        randconfig-a002
x86_64                        randconfig-a006
m68k                             allyesconfig
i386                          randconfig-a001
i386                          randconfig-a003
x86_64                        randconfig-a013
i386                          randconfig-a005
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                             allyesconfig
arm                                 defconfig
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
arm64                            allyesconfig
arm                              allyesconfig

clang tested configs:
hexagon              randconfig-r045-20221026
hexagon              randconfig-r041-20221026
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a002
i386                          randconfig-a004
x86_64                        randconfig-a012
i386                          randconfig-a006
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
