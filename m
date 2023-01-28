Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2B5867F3AA
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 02:21:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233483AbjA1BVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 20:21:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjA1BVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 20:21:04 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60D112F09
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 17:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674868863; x=1706404863;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=W5nxS2vE+XroG/Js2HpFmUqNAWh94aKVZqJXjOXKt3U=;
  b=Qml5sySD93Nm0LJJxc1kA90Xw0+hOXEjwqESIbDf+z2J5k2uUv0eqEbz
   abNpN/IYqC7xR4C/AYwxE44qlK5nl/1mMzmRxVlTu7e+Hu+W6R/3qB37s
   Vy3onwLCKGdxyjXJUAo513XZpmQlvsqDc3GTStqoPMSQKdCDssBYuixsb
   aE5QwhXSpuuUaxSza5lPoE9maS/tMjp40mx/o3GoA62aiIq7ubgjWu7sv
   HrS805WESwiRHVs/mvcgKs/XCe2DmgMFeAJJ+fdDBuGWaQlT9JjFZuR47
   E5is0B220JHlQaYk8LqE3zyCFhT7w8aaNVcNdWtxYJ3i1VGQ4iUnSFDMa
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="307587317"
X-IronPort-AV: E=Sophos;i="5.97,252,1669104000"; 
   d="scan'208";a="307587317"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 17:21:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="695722635"
X-IronPort-AV: E=Sophos;i="5.97,252,1669104000"; 
   d="scan'208";a="695722635"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 27 Jan 2023 17:21:02 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pLZtt-0000Bv-1b;
        Sat, 28 Jan 2023 01:21:01 +0000
Date:   Sat, 28 Jan 2023 09:20:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/cleanups] BUILD SUCCESS
 54628de6792bfa86a8d73520b6fa0029971f9fc6
Message-ID: <63d4785d.X6PLBjvxvmfn+FxB%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cleanups
branch HEAD: 54628de6792bfa86a8d73520b6fa0029971f9fc6  x86/Kconfig: Fix spellos & punctuation

elapsed time: 3701m

configs tested: 19
configs skipped: 42

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
i386                                defconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
i386                 randconfig-a003-20230123
i386                 randconfig-a002-20230123
i386                 randconfig-a001-20230123
i386                 randconfig-a004-20230123
i386                 randconfig-a005-20230123
i386                 randconfig-a006-20230123
i386                             allyesconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-bpf

clang tested configs:
x86_64                          rhel-8.3-rust

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
