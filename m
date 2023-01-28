Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE0A967F98D
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 17:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232256AbjA1QZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 11:25:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbjA1QZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 11:25:43 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1BEB1E9D3
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 08:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674923142; x=1706459142;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=pxT4NSBW6qi/AgwWj3BHt1jMW0o5h/7hm3uUQy3avPA=;
  b=jX7jwnoAU+uFa6B8hgSEeqn7AmKNx4p9IF1Tnolwnan1yskTcSUAKoOI
   fuLA1h/bS92BeclRxvB1mZChYl9yy8c+owGlb64Ql3r7T1V4jCrSXxVLL
   IOEl+PaK5ER0QFHxH8VSl732BqOfrvwpG7mOrRip0u9A8E//QjKjteIds
   qTjISXzqeG2ouL4ajFpOwp3Otg+jkbZvW1OhkeK9dtXXZ9v8LDVixYgRw
   TcMNdQ3DOCzurZ6XTUP+ukvpb/zSoWYyqntewtApOpLy5id89UugbL9Pw
   8ruXeu5Jvhjzu2e60Dr5/h3m6lCQR2Dc0Gl2BKxSi9cpk2ABOpZ1ONQDr
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="391862259"
X-IronPort-AV: E=Sophos;i="5.97,254,1669104000"; 
   d="scan'208";a="391862259"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2023 08:25:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="909002340"
X-IronPort-AV: E=Sophos;i="5.97,254,1669104000"; 
   d="scan'208";a="909002340"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 28 Jan 2023 08:25:41 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pLo1M-0000tq-1n;
        Sat, 28 Jan 2023 16:25:40 +0000
Date:   Sun, 29 Jan 2023 00:25:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/tdx] BUILD SUCCESS
 8de62af018cc9262649d7688f7eb1409b2d8f594
Message-ID: <63d54c5f.hAo/P2bYrpHe9p6u%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/tdx
branch HEAD: 8de62af018cc9262649d7688f7eb1409b2d8f594  x86/tdx: Disable NOTIFY_ENABLES

elapsed time: 858m

configs tested: 20
configs skipped: 69

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
x86_64                            allnoconfig
i386                             allyesconfig
i386                                defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-bpf
i386                 randconfig-a004-20230123
i386                 randconfig-a006-20230123
i386                 randconfig-a005-20230123
i386                 randconfig-a002-20230123
i386                 randconfig-a003-20230123
i386                 randconfig-a001-20230123
ia64                             allmodconfig

clang tested configs:
x86_64                          rhel-8.3-rust

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
