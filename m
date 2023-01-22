Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F015676AF1
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 04:01:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjAVDBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 22:01:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjAVDBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 22:01:13 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E28D1EFEF
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 19:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674356472; x=1705892472;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=oO6psIhtGdFsIqJCaMn3BBf0KnZ8FJdS6hN5BHC2c50=;
  b=dVlsRqQXJKPSL8oUt+TSRtpG87txLB5DiFiIQiyXEFYm6l0tdkLcdway
   hDMxrMrk788E4q3/RPvlLduhQH15ZxuVWzBQUobgdXJIeuPBPatsiukcw
   Q2MgJgxrrWel23k9lflyH/mHsfLvYaiA4sLkuahioJPmLzbSdN9Eccwap
   ftDuIJukTDAIE5VFUC7No0a57JFQ9lcZ+PDJQSp4nzDg5KpXoDwOUzkxK
   nI/BpugurfLj/qucHK3k0Ts0sHNAAVu2GgW1rOX4cSllt5ergqhGa2P3r
   3UnfGh2lx89WFsdOgQg8WB5V9ZYS1DzlzTEBr86O/S2rSTttShl9aXZWE
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10597"; a="388220810"
X-IronPort-AV: E=Sophos;i="5.97,235,1669104000"; 
   d="scan'208";a="388220810"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2023 19:01:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10597"; a="906391986"
X-IronPort-AV: E=Sophos;i="5.97,235,1669104000"; 
   d="scan'208";a="906391986"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 21 Jan 2023 19:01:10 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pJQbV-0004hQ-2o;
        Sun, 22 Jan 2023 03:01:09 +0000
Date:   Sun, 22 Jan 2023 11:00:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/microcode] BUILD SUCCESS
 a9a5cac225b0830d1879640e25231a37e537f0da
Message-ID: <63cca6e6.XqtZQHYyIn0dhtEI%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/microcode
branch HEAD: a9a5cac225b0830d1879640e25231a37e537f0da  x86/microcode/intel: Print old and new revision during early boot

elapsed time: 721m

configs tested: 48
configs skipped: 64

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
x86_64                              defconfig
i386                          randconfig-a014
x86_64                               rhel-8.3
x86_64                           rhel-8.3-syz
i386                          randconfig-a012
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-kvm
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-bpf
i386                          randconfig-a016
i386                                defconfig
i386                          randconfig-a001
x86_64                           allyesconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a013
i386                          randconfig-a003
x86_64                        randconfig-a011
i386                          randconfig-a005
x86_64                        randconfig-a015
x86_64                        randconfig-a006
i386                             allyesconfig
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3

clang tested configs:
i386                          randconfig-a013
i386                          randconfig-a011
x86_64                          rhel-8.3-rust
i386                          randconfig-a015
x86_64                        randconfig-a014
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a002
x86_64                        randconfig-a016
i386                          randconfig-a004
x86_64                        randconfig-a012
i386                          randconfig-a006
x86_64                        randconfig-a005

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
