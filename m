Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1F47644FDE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 00:56:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiLFX4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 18:56:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiLFX4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 18:56:47 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B622230574
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 15:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670371006; x=1701907006;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=VpmrsjsXrBmfrmoUYzqMYl0mV3BCsh4W8CMZ4EGOjco=;
  b=HCa0ebkSDtXr45+n1mOajHeiWypP/T9uFCcsm9f5gzR7OWucwiYzQk26
   R3UnUOiRycbuXj0lS1eykKWmgt8F1QK18gOcrBi/rXUdAWIxNsU94d7sy
   2PR5bGj2nQsw8H1KYp01QFo+lMj8+V+gaEsr6DZOiMPn5MNdwI9v2MbL4
   mrPeaTSxR8fNgUSI6XsHHhLv3gZ6yk1qzby12JEMTuKD7Yc7UWVUhF5Da
   FEMsP+x1tvRBnd3zA+0T5k+BDMHIuQrLyFs/iJiHImrSMMNGUxOURMAYy
   pozYUfJT5zdUmfaUixrSyGnQCjMloGoU43nEmBc3Cavv14XzrxrvrdygX
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="315475628"
X-IronPort-AV: E=Sophos;i="5.96,223,1665471600"; 
   d="scan'208";a="315475628"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2022 15:56:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="891577025"
X-IronPort-AV: E=Sophos;i="5.96,223,1665471600"; 
   d="scan'208";a="891577025"
Received: from lkp-server01.sh.intel.com (HELO b3c45e08cbc1) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 06 Dec 2022 15:56:24 -0800
Received: from kbuild by b3c45e08cbc1 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p2hnT-0001LV-1s;
        Tue, 06 Dec 2022 23:56:23 +0000
Date:   Wed, 07 Dec 2022 07:55:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:irq/core] BUILD SUCCESS
 e6d22108621c837f81d041ec5d61b08d17b151df
Message-ID: <638fd676.nVrTrPWhWJNussGu%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
branch HEAD: e6d22108621c837f81d041ec5d61b08d17b151df  irqchip/ti-sci-inta: Fix kernel doc

elapsed time: 722m

configs tested: 60
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
i386                          randconfig-a001
i386                          randconfig-a003
sh                               allmodconfig
i386                          randconfig-a005
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a014
i386                          randconfig-a012
x86_64                        randconfig-a006
i386                          randconfig-a016
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
m68k                             allyesconfig
ia64                             allmodconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
i386                             allyesconfig
i386                                defconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-rust
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
arm                  randconfig-r046-20221206
alpha                               defconfig
arm                                 defconfig
s390                                defconfig
s390                             allmodconfig
s390                             allyesconfig
arm64                            allyesconfig
arm                              allyesconfig
x86_64                            allnoconfig

clang tested configs:
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a013
x86_64                        randconfig-a005
i386                          randconfig-a011
x86_64                        randconfig-a014
i386                          randconfig-a015
x86_64                        randconfig-a012
x86_64                        randconfig-a016
hexagon              randconfig-r041-20221206
riscv                randconfig-r042-20221206
hexagon              randconfig-r045-20221206
s390                 randconfig-r044-20221206

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
