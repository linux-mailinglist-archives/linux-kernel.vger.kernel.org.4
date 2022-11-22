Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 014F6633F22
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 15:41:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232384AbiKVOlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 09:41:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231465AbiKVOlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 09:41:20 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857262B1AD
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 06:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669128079; x=1700664079;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=bK6gdeOX6vdZom/X/FOQf0HjnPrZORGDVtA/PeDw1uY=;
  b=TMEcw7m4kzB8Q07QQWGli2PmNDdkUeVDcsH+hz8asw4pfF+a6AcLp7RO
   VHr8KsNnm/zaYgksNgDHvzZ14mAvastoXPXxFwTqcsC97DbQY/k6YQ5Ip
   VYL0kix4aScZduKFVeoOodjUloXXsoEum86Qw8ZOQExCtWay7lSLIXudi
   a6OYS4gJnvgTxUV0Wajn6B4dc1yMgijWHkiDdlfflZOPW4X3ouJ7IV8bp
   sxfVqs7s91fkeYj7kQUfbYYNcybJI/sIdytgscT/5MUVYpSa7WZAJsrT+
   NyOC16UYiXVSljIBT5VXJNwkIOkSO3Za1ElXqBflqM8AGllS/X4bYoMju
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="400117952"
X-IronPort-AV: E=Sophos;i="5.96,184,1665471600"; 
   d="scan'208";a="400117952"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 06:41:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="747376851"
X-IronPort-AV: E=Sophos;i="5.96,184,1665471600"; 
   d="scan'208";a="747376851"
Received: from lkp-server01.sh.intel.com (HELO 64a2d449c951) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 22 Nov 2022 06:41:18 -0800
Received: from kbuild by 64a2d449c951 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oxUSb-0001Zh-1a;
        Tue, 22 Nov 2022 14:41:17 +0000
Date:   Tue, 22 Nov 2022 22:41:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:irq/core] BUILD SUCCESS
 d474d92d70250d43e7ce0c7cb8623f31ee7c40f6
Message-ID: <637cdf89.RUTHvJuFN6m84Ale%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git irq/core
branch HEAD: d474d92d70250d43e7ce0c7cb8623f31ee7c40f6  x86/apic: Remove X86_IRQ_ALLOC_CONTIGUOUS_VECTORS

elapsed time: 7160m

configs tested: 56
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
s390                             allyesconfig
um                           x86_64_defconfig
um                             i386_defconfig
powerpc                           allnoconfig
sh                               allmodconfig
mips                             allyesconfig
powerpc                          allmodconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
i386                 randconfig-a011-20221121
i386                 randconfig-a013-20221121
i386                 randconfig-a012-20221121
ia64                             allmodconfig
i386                 randconfig-a016-20221121
i386                 randconfig-a014-20221121
i386                 randconfig-a015-20221121
arc                  randconfig-r043-20221121
riscv                randconfig-r042-20221121
s390                 randconfig-r044-20221121
x86_64                           rhel-8.3-syz
x86_64                           rhel-8.3-kvm
x86_64                         rhel-8.3-kunit
i386                                defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
i386                             allyesconfig
x86_64               randconfig-a012-20221121
x86_64                           allyesconfig
x86_64               randconfig-a011-20221121
x86_64               randconfig-a013-20221121
x86_64               randconfig-a014-20221121
x86_64               randconfig-a015-20221121
x86_64               randconfig-a016-20221121
arm                                 defconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allyesconfig

clang tested configs:
hexagon              randconfig-r041-20221121
hexagon              randconfig-r045-20221121
x86_64               randconfig-a004-20221121
x86_64               randconfig-a001-20221121
x86_64               randconfig-a003-20221121
x86_64               randconfig-a002-20221121
x86_64               randconfig-a005-20221121
x86_64               randconfig-a006-20221121
i386                 randconfig-a004-20221121
i386                 randconfig-a001-20221121
i386                 randconfig-a003-20221121
i386                 randconfig-a005-20221121
i386                 randconfig-a002-20221121
i386                 randconfig-a006-20221121

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
