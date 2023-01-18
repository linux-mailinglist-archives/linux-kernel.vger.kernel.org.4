Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 102C6672CF6
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 00:51:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbjARXv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 18:51:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbjARXu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 18:50:58 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D6E47EF8
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 15:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674085775; x=1705621775;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=S9oHiX4dpWZrYyvGSNxn4B2Pra3pELf87+fixXUvMME=;
  b=ThBppDxtTIcOC5yVb1whrJK0ojIrCEcYYT7mppl1eZ/3XhrfrnFIHNA9
   0CzaSTqFbGvBU16bARRiMXvc5SaG9JimMJ2kzweQPGnhuUy6fFlUaxPom
   j4SHCvhPbm11n8lOIZb3coOCwaLAlktv01DPFbfYiCNeVj5h1QPeXRnLE
   6S0ZMIUhmYrvHJQ8UOLHUCqL2ZGvudI3losjw0wMC5tvGU9SK/CcQnOEX
   ErJSskIQEMbyH72OF65dhClbIxsgDnNgPdBsJBxIfO+1aHCGV3G2S6UN/
   D6F3TSdaQYXImu110BqiQlfMICWl6oWLWM0P8CwFzJn3i4EgvFFNkOyxT
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="411377363"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="411377363"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 15:48:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="802412936"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="802412936"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 18 Jan 2023 15:48:20 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pIIAF-0000pG-1k;
        Wed, 18 Jan 2023 23:48:19 +0000
Date:   Thu, 19 Jan 2023 07:47:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:perf/core] BUILD SUCCESS
 0eed28220598cd990d094b7b9f8c832c425080c0
Message-ID: <63c8850e.IftQZmJqZtUmV62f%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/core
branch HEAD: 0eed28220598cd990d094b7b9f8c832c425080c0  perf/core: Call perf_prepare_sample() before running BPF

elapsed time: 725m

configs tested: 62
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
alpha                               defconfig
s390                                defconfig
alpha                            allyesconfig
powerpc                           allnoconfig
arc                              allyesconfig
powerpc                          allmodconfig
mips                             allyesconfig
sh                               allmodconfig
m68k                             allmodconfig
i386                                defconfig
m68k                             allyesconfig
x86_64                              defconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-bpf
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
arm                                 defconfig
x86_64                               rhel-8.3
ia64                             allmodconfig
arc                  randconfig-r043-20230118
s390                 randconfig-r044-20230118
riscv                randconfig-r042-20230118
arm64                            allyesconfig
i386                             allyesconfig
arm                              allyesconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                           allyesconfig
x86_64                        randconfig-a015
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
i386                          randconfig-a014
i386                          randconfig-a012
s390                             allmodconfig
s390                             allyesconfig
i386                          randconfig-a016
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006

clang tested configs:
x86_64                          rhel-8.3-rust
hexagon              randconfig-r045-20230118
hexagon              randconfig-r041-20230118
arm                  randconfig-r046-20230118
x86_64                        randconfig-a014
x86_64                        randconfig-a012
x86_64                        randconfig-a016
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
