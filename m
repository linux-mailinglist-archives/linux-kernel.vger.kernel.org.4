Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1052D5B412E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 23:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbiIIVBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 17:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiIIVBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 17:01:11 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DBB26DFAE
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 14:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662757270; x=1694293270;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=bbD5zvYSpISH9p7+g/SvEt8osP5NXoGmQ9XTl5XHB/Q=;
  b=NCUAzgZue4PcVzW+55yJOypUfyGIGpRej+s66t4Qq4eI4Zex9CnqFlZg
   kbosACNz96KKD7x1tutDGdPGW9pma6FUsbvKxnXIoFhXLAVKjFZ68QGRs
   cKq/d68puzLyybjaJzv0U7LngrdWBBlYCxn2jfl8oCShVg1tNyvMetWqg
   GnoRL1wE52TdrjRSOZCK4bITyedVa7L3Q7bx1Y1KH/Ka598q/fIhfEp7i
   pExN0D7MvKsFDmhoalToPN3G1B4HLYjHfGBNfTk1RwwyLEkya98jzVLew
   bLXcj3pLk/fyesi9hsWdDWZF/kzu4lNvHslaFkN+BidAqOjwBt8A0uZ8p
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10465"; a="298369924"
X-IronPort-AV: E=Sophos;i="5.93,304,1654585200"; 
   d="scan'208";a="298369924"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 14:01:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,304,1654585200"; 
   d="scan'208";a="719090900"
Received: from lkp-server02.sh.intel.com (HELO b2938d2e5c5a) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 09 Sep 2022 14:01:07 -0700
Received: from kbuild by b2938d2e5c5a with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oWl7b-0001jG-0B;
        Fri, 09 Sep 2022 21:01:07 +0000
Date:   Sat, 10 Sep 2022 05:00:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 132bde89b5234d0ca8909775b354c48b214e1abc
Message-ID: <631ba960.87qgimegQJxjVyyo%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 132bde89b5234d0ca8909775b354c48b214e1abc  Merge branch into tip/master: 'x86/timers'

elapsed time: 732m

configs tested: 78
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arm                                 defconfig
powerpc                           allnoconfig
arm                              allyesconfig
x86_64                              defconfig
arm64                            allyesconfig
sh                               allmodconfig
mips                             allyesconfig
powerpc                          allmodconfig
x86_64                               rhel-8.3
x86_64                        randconfig-a004
i386                          randconfig-a014
x86_64                        randconfig-a002
x86_64                        randconfig-a013
x86_64                        randconfig-a011
i386                          randconfig-a012
x86_64                        randconfig-a006
x86_64                        randconfig-a015
i386                          randconfig-a016
x86_64                           allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
i386                                defconfig
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
i386                          randconfig-a001
i386                          randconfig-a003
x86_64                    rhel-8.3-kselftests
arc                  randconfig-r043-20220907
x86_64                           rhel-8.3-syz
i386                          randconfig-a005
i386                             allyesconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
arc                    vdk_hs38_smp_defconfig
sh                         microdev_defconfig
mips                           xway_defconfig
i386                          randconfig-c001
sh                             shx3_defconfig
xtensa                              defconfig
mips                    maltaup_xpa_defconfig
mips                  maltasmvp_eva_defconfig
sh                        edosk7705_defconfig
arc                  randconfig-r043-20220908
s390                 randconfig-r044-20220908
riscv                randconfig-r042-20220908
ia64                             allmodconfig
loongarch                           defconfig
loongarch                         allnoconfig

clang tested configs:
i386                          randconfig-a013
i386                          randconfig-a011
x86_64                        randconfig-a001
x86_64                        randconfig-a012
x86_64                        randconfig-a003
x86_64                        randconfig-a014
i386                          randconfig-a015
x86_64                        randconfig-a016
x86_64                        randconfig-a005
hexagon              randconfig-r041-20220907
i386                          randconfig-a002
hexagon              randconfig-r045-20220907
i386                          randconfig-a004
s390                 randconfig-r044-20220907
riscv                randconfig-r042-20220907
i386                          randconfig-a006
powerpc                        fsp2_defconfig
powerpc                 mpc8272_ads_defconfig
mips                        qi_lb60_defconfig
arm                          pcm027_defconfig
hexagon              randconfig-r041-20220908
hexagon              randconfig-r045-20220908
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
