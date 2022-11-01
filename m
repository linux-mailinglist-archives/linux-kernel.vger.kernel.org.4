Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBA436142D0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 02:42:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbiKABmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 21:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiKABmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 21:42:14 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8849E17064
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 18:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667266933; x=1698802933;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=LRzPwld48hCcJHFTt/Jv7ni/9JBk/odPZ5m7hdfwjTU=;
  b=LTa+uM9yrysFqPZSJvI+Zqe/y8B9KOMG5guBmLBWg4UQmgv1OtNS08Iy
   V0awDmcXYh35TUWFi1uLrqTwiaBUyEQrx5V4iq7SuUbC8rbXdswrq880w
   ZWaQDngjkFbX/fvBuTa2OiST9Bu2fo1+OOz8W0p9VDouJGi4+EhBMuPyS
   sNiOBmFo9LI69ZfuDG52AJ3PrpUwhcUuVkiDfcDVtWuDuSicTW24+oZdz
   xTYBJYNhk1CKlXEEsXVLIc44O8/LmKeqKJAkFeAV8CnxYe9cE+PfEoi+8
   aaQ5uvQ0J8AM1tzh0GWLv+0/qD6ImKFc7a/JV1Ep9xRGNnauqInD53yxb
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="395356574"
X-IronPort-AV: E=Sophos;i="5.95,229,1661842800"; 
   d="scan'208";a="395356574"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2022 18:42:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="584859623"
X-IronPort-AV: E=Sophos;i="5.95,229,1661842800"; 
   d="scan'208";a="584859623"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 31 Oct 2022 18:42:11 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1opgI7-000DAq-0M;
        Tue, 01 Nov 2022 01:42:11 +0000
Date:   Tue, 01 Nov 2022 09:42:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/cleanups] BUILD SUCCESS
 c9053e1c5a6fca221946f95d1fe6e47f69fb303a
Message-ID: <6360796d.d5vg/VGKic7N7N7e%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cleanups
branch HEAD: c9053e1c5a6fca221946f95d1fe6e47f69fb303a  x86/i8259: Make default_legacy_pic static

elapsed time: 972m

configs tested: 34
configs skipped: 81

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                              defconfig
i386                 randconfig-a011-20221031
i386                 randconfig-a012-20221031
i386                 randconfig-a013-20221031
i386                 randconfig-a016-20221031
i386                 randconfig-a015-20221031
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
i386                 randconfig-a014-20221031
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
i386                                defconfig
x86_64                               rhel-8.3
x86_64               randconfig-a012-20221031
x86_64                           allyesconfig
x86_64               randconfig-a011-20221031
x86_64               randconfig-a013-20221031
x86_64               randconfig-a014-20221031
x86_64               randconfig-a016-20221031
i386                             allyesconfig
x86_64               randconfig-a015-20221031

clang tested configs:
x86_64               randconfig-a004-20221031
x86_64               randconfig-a003-20221031
x86_64               randconfig-a002-20221031
x86_64               randconfig-a001-20221031
x86_64               randconfig-a006-20221031
x86_64               randconfig-a005-20221031
i386                 randconfig-a001-20221031
i386                 randconfig-a003-20221031
i386                 randconfig-a002-20221031
i386                 randconfig-a004-20221031
i386                 randconfig-a005-20221031
i386                 randconfig-a006-20221031

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
