Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53F7A68CCB7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 03:48:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbjBGCsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 21:48:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjBGCsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 21:48:31 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13A3223C7A
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 18:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675738111; x=1707274111;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=hTiEo5eVFlvrDI+LYXaeOufHNCR8TbtlbuHn81YISzo=;
  b=brP82eyFvrCfQLUap4l5bk6dhte85/x7QzBBZO0gGM5xmCfnrr/LqVEx
   mjm2LsgHcUmtnPokJUIRV46JmlcGQlhZcP58cBJ9BYtC38gaVPavQ/+tZ
   3jCEQcSYWloEt2M0IWa7SbknVqtYjXX9/35fd6yqmSYTZY/La0oOwwJSn
   97sbqbBZHhRyJk1gzVdLIusJtUlJTHepXGRiVzhy7RaApbMfXFLgfj38o
   orIbi1PHwphT/8QhekN/fMLUHRmGEmyfyDNu7lZq79QEXgBbW8aidrSGc
   bsw448PIKll6H8cEFzigWGLWJgsI00xR9Dsy0nkTdvX6N992sBWzM+hq7
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="330677145"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="330677145"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 18:48:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="755470718"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="755470718"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 06 Feb 2023 18:48:28 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pPE1z-0002yU-2T;
        Tue, 07 Feb 2023 02:48:27 +0000
Date:   Tue, 07 Feb 2023 10:47:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:locking/urgent] BUILD SUCCESS
 db370a8b9f67ae5f17e3d5482493294467784504
Message-ID: <63e1bbdf.Ix0jI1YjhnKICOwI%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/urgent
branch HEAD: db370a8b9f67ae5f17e3d5482493294467784504  rtmutex: Ensure that the top waiter is always woken up

elapsed time: 727m

configs tested: 34
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
ia64                             allmodconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
i386                             allyesconfig
i386                                defconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                           rhel-8.3-bpf
x86_64                         rhel-8.3-kunit
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
powerpc                           allnoconfig
alpha                               defconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
s390                             allmodconfig
s390                                defconfig
i386                          randconfig-c001
powerpc              randconfig-c003-20230205
s390                             allyesconfig

clang tested configs:
x86_64                        randconfig-k001
x86_64                          rhel-8.3-rust

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
