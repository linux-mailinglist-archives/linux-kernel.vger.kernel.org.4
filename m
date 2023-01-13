Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD2F7669185
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 09:47:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240774AbjAMIrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 03:47:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240882AbjAMIqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 03:46:33 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26CBB736F8
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 00:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673599578; x=1705135578;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=G7Gg2dMCdN1TFLKy8srtqfr9mpV4XoLzFx2QYlMtJuY=;
  b=lk748ael+QxdlYPF1gvd5iNPZ47ubC43UTnCFsyaLOIFWeLL0TSmMIiF
   nic4OM6sWu2569wKS9pX1x2kyH/kz5cCqYpqL5nRgosn+tdHi/WIxWgKS
   mEgx6zqfuj6lYPjR9FoLzgZ/WBuHpcS26Sm+94rAZkOVrOve/nC7rWtoN
   dyS4pnDCwFz2M7QhKvot7mXu595dWIp6uLYlADiDV1vZQnTLfGjhNJtt2
   grKQE1H6LjR6qgAjsfOKpLlLnS93QCo9lWnmItiOe7hN98gW5svIhYlsl
   aWbmr+5qdBaM2Tc3fTL65Hvnjjx9QKFUp0yyhW3N1dy8IalmKf6Qsw2XD
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="410185077"
X-IronPort-AV: E=Sophos;i="5.97,213,1669104000"; 
   d="scan'208";a="410185077"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 00:46:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="782083643"
X-IronPort-AV: E=Sophos;i="5.97,213,1669104000"; 
   d="scan'208";a="782083643"
Received: from lkp-server02.sh.intel.com (HELO f1920e93ebb5) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 13 Jan 2023 00:46:16 -0800
Received: from kbuild by f1920e93ebb5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pGFhX-000Ava-2b;
        Fri, 13 Jan 2023 08:46:15 +0000
Date:   Fri, 13 Jan 2023 16:46:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2023.01.10a] BUILD SUCCESS
 dff9f76ed376bc3fd70a7fcd6b7005d4fcc3019d
Message-ID: <63c11a54.xUzdtmds432Qr6oK%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2023.01.10a
branch HEAD: dff9f76ed376bc3fd70a7fcd6b7005d4fcc3019d  rcu: Disable laziness if lazy-tracking says so

elapsed time: 750m

configs tested: 62
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                            allnoconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-bpf
x86_64                           rhel-8.3-syz
arc                  randconfig-r043-20230112
x86_64                         rhel-8.3-kunit
s390                 randconfig-r044-20230112
riscv                randconfig-r042-20230112
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a004
ia64                             allmodconfig
x86_64                        randconfig-a002
i386                          randconfig-a001
m68k                             allyesconfig
i386                          randconfig-a003
x86_64                        randconfig-a015
m68k                             allmodconfig
arc                              allyesconfig
x86_64                        randconfig-a006
alpha                            allyesconfig
i386                          randconfig-a005
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
x86_64                              defconfig
i386                                defconfig
x86_64                               rhel-8.3
arm                                 defconfig
powerpc                           allnoconfig
arc                                 defconfig
s390                             allmodconfig
x86_64                           allyesconfig
mips                             allyesconfig
alpha                               defconfig
powerpc                          allmodconfig
sh                               allmodconfig
s390                                defconfig
s390                             allyesconfig
arm64                            allyesconfig
arm                              allyesconfig
i386                             allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func

clang tested configs:
arm                  randconfig-r046-20230112
hexagon              randconfig-r041-20230112
hexagon              randconfig-r045-20230112
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a016
i386                          randconfig-a002
x86_64                        randconfig-a005
i386                          randconfig-a006
i386                          randconfig-a004
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
x86_64                          rhel-8.3-rust

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
