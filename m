Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A60B68F2F1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 17:15:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbjBHQPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 11:15:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbjBHQPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 11:15:11 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64BBD4A1CA
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 08:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675872910; x=1707408910;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=NqilB87yz1sMokSOeDNwhb5+W/DTge3DtED1M8Ov8Xo=;
  b=k1QwgJA00D5SAtZDQbx9cKCIclFbUTQCRyKUhMtGo28mJLEWnA5SmHuW
   /wHR46ikDSgMJzQLGWP7PfMhLcf+xzFblN9Pd0dWkNZu+dxRl5vPb2p1k
   eIk0qCg5plDeCgXxYZK0kYTfUFkroijNqGglm78iqJT+2rpZ1Lbriei5Z
   0usNKIEmp7vbzF0VmrPtcAjp2544UES/EmBfTGpHHBTMgPd9ptkoTkqYU
   V5vrxoLP7pdx9ZOXT8dZzblWrQ1eDA+m7UKEKgf5lou0Y+X6pw+aM4yU0
   u2uUuNyYjm6P2cH5PNO8RytAfmFtRpakuCjW+Tfu6OSj6H568n5buJCJB
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="416065657"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="416065657"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 08:15:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="644910253"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="644910253"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 08 Feb 2023 08:15:08 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pPn6B-0004X5-2s;
        Wed, 08 Feb 2023 16:15:07 +0000
Date:   Thu, 09 Feb 2023 00:14:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:usama.2023.02.07a] BUILD SUCCESS
 18a37610b63240e98beb4bed7f42dd55f815fe9e
Message-ID: <63e3ca65.Ce+GwXtRblN8JQKP%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git usama.2023.02.07a
branch HEAD: 18a37610b63240e98beb4bed7f42dd55f815fe9e  x86/smpboot: Serialize topology updates for secondary bringup

elapsed time: 722m

configs tested: 68
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                           rhel-8.3-bpf
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
um                             i386_defconfig
x86_64                            allnoconfig
um                           x86_64_defconfig
i386                                defconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
i386                             allyesconfig
riscv                randconfig-r042-20230204
s390                                defconfig
s390                             allyesconfig
s390                 randconfig-r044-20230206
arc                  randconfig-r043-20230204
arc                  randconfig-r043-20230206
x86_64                              defconfig
x86_64                               rhel-8.3
s390                 randconfig-r044-20230204
riscv                randconfig-r042-20230206
x86_64                           allyesconfig
ia64                             allmodconfig
m68k                             allmodconfig
x86_64                    rhel-8.3-kselftests
arm                                 defconfig
powerpc                           allnoconfig
alpha                            allyesconfig
powerpc                          allmodconfig
x86_64                          rhel-8.3-func
sh                               allmodconfig
arm                              allyesconfig
m68k                             allyesconfig
arc                              allyesconfig
mips                             allyesconfig
arm64                            allyesconfig
i386                          randconfig-a001
x86_64               randconfig-a014-20230206
i386                          randconfig-a003
x86_64               randconfig-a013-20230206
x86_64               randconfig-a011-20230206
i386                          randconfig-a005
x86_64               randconfig-a015-20230206
x86_64               randconfig-a012-20230206
x86_64               randconfig-a016-20230206
i386                 randconfig-a011-20230206
i386                 randconfig-a014-20230206
i386                 randconfig-a012-20230206
i386                 randconfig-a013-20230206
i386                 randconfig-a015-20230206
i386                 randconfig-a016-20230206

clang tested configs:
hexagon              randconfig-r045-20230206
hexagon              randconfig-r041-20230206
hexagon              randconfig-r041-20230204
arm                  randconfig-r046-20230204
arm                  randconfig-r046-20230206
hexagon              randconfig-r045-20230204
x86_64                          rhel-8.3-rust
i386                          randconfig-a002
x86_64               randconfig-a001-20230206
x86_64               randconfig-a002-20230206
x86_64               randconfig-a004-20230206
i386                          randconfig-a006
i386                          randconfig-a004
x86_64               randconfig-a003-20230206
x86_64               randconfig-a005-20230206
x86_64               randconfig-a006-20230206

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
