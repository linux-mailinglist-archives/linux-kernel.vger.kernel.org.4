Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8359602126
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 04:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbiJRC1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 22:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiJRC1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 22:27:12 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C3D7969D
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 19:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666060032; x=1697596032;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=SUwwHVNINInB6Dqkg8IYoYQ92Sm8qXNiQK9dnDHxwRU=;
  b=Ee2j8+C7i0TDsSLkTK+bcNxah9vDMCXiEVv8V322CHvNotzv18J77ZJP
   NWC1uGFIAxZQ/gcV7fULi69Bp6YCXpToMcGePcmQDKldh84r3aohNRF2H
   MJck6x5v1MDTowAtBcVRxU5BzsWrXVDejZZZpoL4Jqy7I+Aa0ZLNu21o4
   qHSKZeGLVqYqv2GkOt/TUCS5A8XKM1QpcLvF2mZRy7LxqAlCQNNLjj3hd
   BYRfENrquuf1UuFpr9yvrJTX2OHJRd8LH2ZhYoydn4oCy0l8dMeXblqaY
   1G+w2rvHcST4XSafwbwvvCpVa882PGPgdhqPCnZ0ZrdCkGJ42g/tAH2pn
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="392279290"
X-IronPort-AV: E=Sophos;i="5.95,192,1661842800"; 
   d="scan'208";a="392279290"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2022 19:27:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="957576298"
X-IronPort-AV: E=Sophos;i="5.95,192,1661842800"; 
   d="scan'208";a="957576298"
Received: from lkp-server01.sh.intel.com (HELO 8381f64adc98) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 17 Oct 2022 19:27:10 -0700
Received: from kbuild by 8381f64adc98 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1okcJx-0001Be-2b;
        Tue, 18 Oct 2022 02:27:09 +0000
Date:   Tue, 18 Oct 2022 10:26:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/paravirt] BUILD SUCCESS
 00e8f7153bcdecc5c31e307c7c17fecf42308fc4
Message-ID: <634e0ed9.eKT4migUDZghGuVB%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/paravirt
branch HEAD: 00e8f7153bcdecc5c31e307c7c17fecf42308fc4  x86/paravirt: Remove clobber bitmask from .parainstructions

elapsed time: 945m

configs tested: 34
configs skipped: 91

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
i386                 randconfig-a001-20221017
i386                 randconfig-a002-20221017
i386                 randconfig-a003-20221017
i386                 randconfig-a005-20221017
i386                 randconfig-a004-20221017
i386                 randconfig-a006-20221017
x86_64               randconfig-a002-20221017
x86_64               randconfig-a003-20221017
x86_64               randconfig-a004-20221017
x86_64               randconfig-a001-20221017
x86_64               randconfig-a006-20221017
x86_64               randconfig-a005-20221017
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
i386                                defconfig
i386                             allyesconfig

clang tested configs:
x86_64               randconfig-a013-20221017
x86_64               randconfig-a014-20221017
x86_64               randconfig-a012-20221017
x86_64               randconfig-a011-20221017
x86_64               randconfig-a015-20221017
x86_64               randconfig-a016-20221017
i386                 randconfig-a011-20221017
i386                 randconfig-a013-20221017
i386                 randconfig-a012-20221017
i386                 randconfig-a014-20221017
i386                 randconfig-a016-20221017
i386                 randconfig-a015-20221017

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
