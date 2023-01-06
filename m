Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4B165F85B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 01:53:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236292AbjAFAxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 19:53:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235969AbjAFAxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 19:53:05 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13EF965C0
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 16:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672966385; x=1704502385;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=9vU/8Mth58yBtKnCrPWLcJMObbOOLQ5hZfZ+Oa/TQQY=;
  b=PPx+y+pgP/r0BKNFr3YAcZs6HcTQVVG/jxpVb5McMpI/PTQ7k6HDGUAR
   /tZdd3LX8IeI62Bw63yFeO2FBGv0R+/gLyKbcD3ATWOvG3EPgeoFHSKaO
   5bLeWsT69GhxXFqyiN3AmZbaAafPlTD2uzfS+dJlxgDu+AugWUNXqVvlm
   USYPUSTMEekUqWx5JTiwL9XXFbgrMqOSIdbobsH94Skt7EpH7/04k3b6k
   uobIZ3QGNpVNGNjdgU5kGelzU9ecR0Npk0slVHJakXxGpbp5f9wnu+8w2
   vl6qWhP6Qwo/KwcMwlWAm/bPX/pU9bREoGFjjDzBdGL07amxpgxTVgOLc
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="320071028"
X-IronPort-AV: E=Sophos;i="5.96,303,1665471600"; 
   d="scan'208";a="320071028"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 16:53:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="605743382"
X-IronPort-AV: E=Sophos;i="5.96,303,1665471600"; 
   d="scan'208";a="605743382"
Received: from lkp-server02.sh.intel.com (HELO f1920e93ebb5) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 05 Jan 2023 16:53:02 -0800
Received: from kbuild by f1920e93ebb5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pDayj-0002lr-38;
        Fri, 06 Jan 2023 00:53:01 +0000
Date:   Fri, 06 Jan 2023 08:52:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:locking/core] BUILD SUCCESS
 4282494a20cdcaf38d553f2c2ff6f252084f979c
Message-ID: <63b770c8.VD2uEtOL7jf3O5NW%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/core
branch HEAD: 4282494a20cdcaf38d553f2c2ff6f252084f979c  locking/qspinlock: Micro-optimize pending state waiting for unlock

elapsed time: 834m

configs tested: 72
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
um                             i386_defconfig
um                           x86_64_defconfig
ia64                             allmodconfig
arc                                 defconfig
s390                             allmodconfig
i386                          randconfig-a001
alpha                               defconfig
x86_64                              defconfig
arm                                 defconfig
s390                                defconfig
i386                                defconfig
i386                          randconfig-a003
x86_64                        randconfig-a004
x86_64                        randconfig-a002
arm64                            allyesconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
i386                          randconfig-a005
x86_64                        randconfig-a006
x86_64                        randconfig-a015
s390                             allyesconfig
x86_64                               rhel-8.3
arm                              allyesconfig
alpha                            allyesconfig
powerpc                           allnoconfig
m68k                             allyesconfig
x86_64                           rhel-8.3-bpf
mips                             allyesconfig
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
m68k                             allmodconfig
x86_64                           allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
i386                             allyesconfig
sh                               allmodconfig
arc                              allyesconfig
x86_64                    rhel-8.3-kselftests
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
arc                  randconfig-r043-20230105
s390                 randconfig-r044-20230105
riscv                randconfig-r042-20230105
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
powerpc                          allmodconfig

clang tested configs:
x86_64                        randconfig-a014
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a002
i386                          randconfig-a006
x86_64                        randconfig-a012
i386                          randconfig-a004
x86_64                        randconfig-a016
x86_64                        randconfig-a005
x86_64                          rhel-8.3-rust
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
arm                  randconfig-r046-20230105
hexagon              randconfig-r045-20230105
hexagon              randconfig-r041-20230105
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
