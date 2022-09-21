Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C07DD5E5680
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 01:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbiIUXD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 19:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbiIUXDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 19:03:48 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6BF47CAB6
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 16:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663801427; x=1695337427;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=KaGy2JRnMUpWrOPK29tmlsRUXEm7ZfLtX6JAe9fCkYQ=;
  b=GfXRK4KdB87XhM2CzRCaTkBkWYnlgIlBazR/7n9bywWr8oX0bRw+34Bu
   gqPG9O0JaTsK1tvlAd8cEumr7eKkYW3LoueAT2ond56tmxxWXU8HUqvTq
   T4ZtthUZ6HuD4cX+3GizRDZpmjtefW5Ugt5sELcggqq97KbdSbIMCNd+N
   pXguJS9C7kcu6fAcyuAqRmSBf7qstp7BoubvGyfRiBD9CH6GcTOuT3Zc/
   zqVcbWQwk73msEndpNnCSwaaoX2w2o6q0b5HH6Iso46ahroRGPvLoU93i
   /rMvyjVi2EJltqelbrLP1/546GRKJAakLYofA4hdZPQKUO5Z/emIGipQk
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="283196061"
X-IronPort-AV: E=Sophos;i="5.93,334,1654585200"; 
   d="scan'208";a="283196061"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 16:03:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,334,1654585200"; 
   d="scan'208";a="597193662"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 21 Sep 2022 16:03:46 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ob8kr-00043g-26;
        Wed, 21 Sep 2022 23:03:45 +0000
Date:   Thu, 22 Sep 2022 07:03:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 08ed00508bc1fa0a0bc6dd2420f982b55051de23
Message-ID: <632b9839.Cre9RNZTqu53EicW%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 08ed00508bc1fa0a0bc6dd2420f982b55051de23  Merge branch into tip/master: 'x86/mm'

elapsed time: 723m

configs tested: 58
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                              allyesconfig
alpha                            allyesconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
i386                                defconfig
m68k                             allyesconfig
x86_64                              defconfig
s390                                defconfig
m68k                             allmodconfig
x86_64                           allyesconfig
arc                  randconfig-r043-20220921
s390                             allyesconfig
riscv                randconfig-r042-20220921
powerpc                          allmodconfig
mips                             allyesconfig
i386                          randconfig-a001
x86_64                               rhel-8.3
powerpc                           allnoconfig
i386                          randconfig-a003
sh                               allmodconfig
i386                             allyesconfig
s390                 randconfig-r044-20220921
arm                                 defconfig
i386                          randconfig-a005
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
x86_64                        randconfig-a006
arm                              allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                        randconfig-a013
x86_64                           rhel-8.3-kvm
arm64                            allyesconfig
x86_64                           rhel-8.3-syz
x86_64                        randconfig-a011
ia64                             allmodconfig
x86_64                        randconfig-a015
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016

clang tested configs:
hexagon              randconfig-r041-20220921
hexagon              randconfig-r045-20220921
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
x86_64                        randconfig-a012
x86_64                        randconfig-a016
x86_64                        randconfig-a014
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
