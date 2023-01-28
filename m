Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6A7F67FB28
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 22:33:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233816AbjA1VdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 16:33:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjA1Vc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 16:32:57 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D4611E96
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 13:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674941576; x=1706477576;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=moX3aJHFqT7weqqOWm95qdej9oD0kXh1xLogU2INK8w=;
  b=TjdnZ90f8TH/OqStGSFNJrCDnVBg6zY51tZJbQQHphpOgOCWj8z9IbdO
   6kw4lLf7JMpucE5ZCH1gG8xcFhbW4lRkao59zcUf42gmXm7SGr04v4ZSC
   /twmp4udTKRafJG9QxsmOlDv3fMoSld9g58jF9t4h9zSy2gGEvyPLdiwR
   wtPxisLh9lSEnGETkQ5thfz/qcCW87iNfSaydOlwxy41L1DtBpyNcweHQ
   AO7JRX09/B1HRnZHrwZ8yr9V5PsO69jnSqwJBEOHBvkyW3IXV4SWw+uwU
   Rs5kJdU3E2TXiRLWMEcjhOsZaWnZA99wvom7bBwnNrRtc6ZMGeQyCICEq
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="391894627"
X-IronPort-AV: E=Sophos;i="5.97,254,1669104000"; 
   d="scan'208";a="391894627"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2023 13:32:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="771986172"
X-IronPort-AV: E=Sophos;i="5.97,254,1669104000"; 
   d="scan'208";a="771986172"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 28 Jan 2023 13:32:53 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pLsoe-000184-2D;
        Sat, 28 Jan 2023 21:32:52 +0000
Date:   Sun, 29 Jan 2023 05:31:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:lkmm-srcu.2023.01.20a] BUILD SUCCESS
 814560bb2c4c7df117d237a94d475b639a04f7b3
Message-ID: <63d5944b.j1aCJJ1dfLvKFG//%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git lkmm-srcu.2023.01.20a
branch HEAD: 814560bb2c4c7df117d237a94d475b639a04f7b3  tools/memory-model Flag suspicious use of srcu cookies

elapsed time: 1165m

configs tested: 30
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
alpha                            allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
um                             i386_defconfig
um                           x86_64_defconfig
s390                             allyesconfig
powerpc                           allnoconfig
sh                               allmodconfig
mips                             allyesconfig
x86_64                         rhel-8.3-kunit
powerpc                          allmodconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-bpf
x86_64                           rhel-8.3-syz
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
i386                                defconfig
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig
i386                             allyesconfig

clang tested configs:
x86_64                          rhel-8.3-rust

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
