Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0C7466C2CB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 15:54:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjAPOyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 09:54:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232499AbjAPOx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 09:53:29 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 925431D908
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 06:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673880091; x=1705416091;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=UtDiBXxXW3+0THoDy2F2T9tUj2BFVpMz3HtInOX1vhw=;
  b=C2Rri6TlZTinTt9FXNEBHSmF7O3Exa64ibsyeU01l1gP2/7T4n/zD3/W
   TnG2OqBdu1umKKl27DjcVOtvWqjvwG21DB8oietJRxZLFevKNVQTG9m/W
   eHsP08CLb16d0rgoka4vRl3BVX/Q9YbxKytccEB2Q/1gXjXrkOAhtfuUu
   7PinFQPglxvJ0pKfEuUrZE4k4QFsL1NouSUFfdZuPXGO3VCzIw+SlztCJ
   iZ9jqdK6fmhzy8F8sWifVWDIT/dtH7od7f1c40N5VuXKxROeRePhjq2oD
   QoQQ1fnhAoZxPVFDGQkqwhwrKHXbL596M082//eiru9iIHOJRfOuuhxRd
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="304173210"
X-IronPort-AV: E=Sophos;i="5.97,221,1669104000"; 
   d="scan'208";a="304173210"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2023 06:41:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="801400008"
X-IronPort-AV: E=Sophos;i="5.97,221,1669104000"; 
   d="scan'208";a="801400008"
Received: from lkp-server02.sh.intel.com (HELO f57cd993bc73) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 16 Jan 2023 06:41:30 -0800
Received: from kbuild by f57cd993bc73 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pHQfv-0000Vp-1x;
        Mon, 16 Jan 2023 14:41:27 +0000
Date:   Mon, 16 Jan 2023 22:40:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2023.01.14a] BUILD SUCCESS
 f65ed25f8e34d465b839a2f2fb6ceb67c40abe5b
Message-ID: <63c561ed.9CHl4Qascm9ohBkV%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2023.01.14a
branch HEAD: f65ed25f8e34d465b839a2f2fb6ceb67c40abe5b  fixup! memory-model: Prohibit nested SRCU read-side critical sections

elapsed time: 720m

configs tested: 68
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
powerpc                           allnoconfig
um                             i386_defconfig
um                           x86_64_defconfig
i386                                defconfig
x86_64                              defconfig
i386                 randconfig-a013-20230116
i386                 randconfig-a012-20230116
i386                 randconfig-a011-20230116
x86_64                               rhel-8.3
i386                 randconfig-a014-20230116
i386                 randconfig-a015-20230116
i386                 randconfig-a016-20230116
arm                                 defconfig
arc                                 defconfig
x86_64                           rhel-8.3-syz
s390                             allmodconfig
x86_64                         rhel-8.3-kunit
x86_64                           allyesconfig
x86_64                           rhel-8.3-kvm
alpha                               defconfig
x86_64                           rhel-8.3-bpf
sh                               allmodconfig
s390                                defconfig
arc                  randconfig-r043-20230115
powerpc                          allmodconfig
mips                             allyesconfig
x86_64               randconfig-a011-20230116
s390                             allyesconfig
x86_64               randconfig-a013-20230116
i386                             allyesconfig
riscv                randconfig-r042-20230116
x86_64               randconfig-a012-20230116
x86_64               randconfig-a015-20230116
x86_64               randconfig-a014-20230116
arc                  randconfig-r043-20230116
x86_64               randconfig-a016-20230116
arm64                            allyesconfig
arm                              allyesconfig
arm                  randconfig-r046-20230115
s390                 randconfig-r044-20230116
ia64                             allmodconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig

clang tested configs:
i386                 randconfig-a002-20230116
i386                 randconfig-a004-20230116
i386                 randconfig-a003-20230116
i386                 randconfig-a005-20230116
hexagon              randconfig-r041-20230116
i386                 randconfig-a001-20230116
hexagon              randconfig-r045-20230115
riscv                randconfig-r042-20230115
i386                 randconfig-a006-20230116
arm                  randconfig-r046-20230116
s390                 randconfig-r044-20230115
hexagon              randconfig-r045-20230116
hexagon              randconfig-r041-20230115
x86_64                          rhel-8.3-rust
x86_64               randconfig-a003-20230116
x86_64               randconfig-a004-20230116
x86_64               randconfig-a006-20230116
x86_64               randconfig-a005-20230116
x86_64               randconfig-a001-20230116
x86_64               randconfig-a002-20230116

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
