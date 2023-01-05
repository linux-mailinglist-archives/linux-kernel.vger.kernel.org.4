Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C38F65E6E4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 09:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbjAEIgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 03:36:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231466AbjAEIgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 03:36:41 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C174C717
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 00:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672907800; x=1704443800;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=lndyAo6fiRi07Wrs873/8v61FYUR6mSsD0mujJB68Ug=;
  b=N3vd+QkrnHZjIwHlvPMCq1TY2IgkDR0NGSUNYMc6BLFWpcArRbniWSJC
   nOVn5ah004KgP7UVkN76/mtcWQbuj0YnMirtfGJ3tzDcpB68DkKltS29w
   dZVrFTPU4a0sZP/O9wqRztwlSrfo67G+5XF4xFKB6oSUqjQydM15KKehC
   QRtpAuF9KxWW1/8x6CUOnkxoAxxrzjkKF/ZKj6zztNCpTLweWe/BjBVsV
   8xhmDqqHmltEHLWXsIaued6fklwCbJr3i0hkMwYJrufSPZpRKQVQNJ8wk
   SgsLTM7ZVQAJO8V0BVoSSW9NnmFMlDyvNRGkSdPG2gAy1+YWgTqg/lyB3
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="319856841"
X-IronPort-AV: E=Sophos;i="5.96,302,1665471600"; 
   d="scan'208";a="319856841"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 00:36:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="655489601"
X-IronPort-AV: E=Sophos;i="5.96,302,1665471600"; 
   d="scan'208";a="655489601"
Received: from lkp-server02.sh.intel.com (HELO f1920e93ebb5) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 05 Jan 2023 00:36:35 -0800
Received: from kbuild by f1920e93ebb5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pDLjm-0001ME-37;
        Thu, 05 Jan 2023 08:36:34 +0000
Date:   Thu, 05 Jan 2023 16:36:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 bdc9f60d2a62815fd1400dba270e693c32698c04
Message-ID: <63b68bff.2sJKnbwAPhvrNaYJ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: bdc9f60d2a62815fd1400dba270e693c32698c04  Merge branch into tip/master: 'perf/urgent'

elapsed time: 721m

configs tested: 68
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
alpha                               defconfig
x86_64                            allnoconfig
powerpc                           allnoconfig
m68k                             allmodconfig
alpha                            allyesconfig
m68k                             allyesconfig
arc                              allyesconfig
s390                                defconfig
s390                             allmodconfig
um                             i386_defconfig
um                           x86_64_defconfig
sh                               allmodconfig
ia64                             allmodconfig
mips                             allyesconfig
powerpc                          allmodconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
x86_64                           rhel-8.3-bpf
x86_64                           rhel-8.3-syz
s390                             allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                              defconfig
i386                 randconfig-a004-20230102
i386                 randconfig-a003-20230102
i386                 randconfig-a001-20230102
arm                                 defconfig
i386                 randconfig-a002-20230102
i386                 randconfig-a005-20230102
i386                                defconfig
i386                 randconfig-a006-20230102
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
arm64                            allyesconfig
x86_64                           allyesconfig
riscv                randconfig-r042-20230101
arm                              allyesconfig
s390                 randconfig-r044-20230101
arc                  randconfig-r043-20230102
i386                             allyesconfig
arm                  randconfig-r046-20230102
arc                  randconfig-r043-20230101
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015

clang tested configs:
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                 randconfig-a012-20230102
i386                 randconfig-a011-20230102
x86_64                          rhel-8.3-rust
i386                 randconfig-a014-20230102
i386                 randconfig-a013-20230102
i386                 randconfig-a015-20230102
i386                 randconfig-a016-20230102
hexagon              randconfig-r041-20230102
s390                 randconfig-r044-20230102
hexagon              randconfig-r045-20230101
hexagon              randconfig-r045-20230102
arm                  randconfig-r046-20230101
riscv                randconfig-r042-20230102
hexagon              randconfig-r041-20230101
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
