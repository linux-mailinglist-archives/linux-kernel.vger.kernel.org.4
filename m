Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1409D62CD54
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 23:05:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233702AbiKPWF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 17:05:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233023AbiKPWFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 17:05:24 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D478657D4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 14:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668636322; x=1700172322;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=X2P5eHrOokbks6iTg2cf77arVWmTTlzhVUDqxEa2euc=;
  b=SdeGqi8TVPgdFqR11i2T3V1u7niHXwEOh/pC5mNYooJkPuBcwI75dI2U
   J3znyjEF9CW1H98r7FzDOsh9WcKw4xp0W+zZP/WP70uTGcQewyarmbQTq
   4Q2/xn3Do0g+G2xCcjk1TSf66M5G4Mh5g56pUzeBKkTWF1no8RLRu9Auf
   Lp3vNMJ1kLr1yHwLdTDw0ke3jAz6fBvPuk/icQwQZXsaA3U3e56Q9j+6a
   C/PDUmyJkc9PRrjRGOVyByKd2337gFUEs776KkqbF7fRxOSGpO4SdqZS5
   3/McSWxyPCGF8qrVZkNWgeNeMFwHDj/BqmG00Xu43kh95pMcj2xcUVeWf
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="376949186"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="376949186"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 14:05:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="781944606"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="781944606"
Received: from lkp-server01.sh.intel.com (HELO ebd99836cbe0) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 16 Nov 2022 14:05:20 -0800
Received: from kbuild by ebd99836cbe0 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ovQX2-0002mZ-0L;
        Wed, 16 Nov 2022 22:05:20 +0000
Date:   Thu, 17 Nov 2022 06:04:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/core] BUILD SUCCESS
 2d08a893b87cf9b2f9dbb3afaff60ca4530d55a2
Message-ID: <63755e7c.mlIML59zZz/xMmWN%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/core
branch HEAD: 2d08a893b87cf9b2f9dbb3afaff60ca4530d55a2  x86/debug: Include percpu.h in debugreg.h to get DECLARE_PER_CPU() et al

elapsed time: 721m

configs tested: 34
configs skipped: 85

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
i386                                defconfig
i386                          randconfig-a016
i386                          randconfig-a001
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                           rhel-8.3-syz
i386                          randconfig-a003
x86_64                         rhel-8.3-kunit
x86_64                        randconfig-a011
i386                          randconfig-a012
x86_64                           rhel-8.3-kvm
i386                          randconfig-a014
x86_64                        randconfig-a015
i386                             allyesconfig
x86_64                        randconfig-a002
x86_64                        randconfig-a004
x86_64                        randconfig-a006

clang tested configs:
i386                          randconfig-a015
x86_64                        randconfig-a005
i386                          randconfig-a013
i386                          randconfig-a002
i386                          randconfig-a006
x86_64                        randconfig-a016
x86_64                        randconfig-a012
i386                          randconfig-a011
x86_64                        randconfig-a014
i386                          randconfig-a004
x86_64                        randconfig-a001
x86_64                        randconfig-a003

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
