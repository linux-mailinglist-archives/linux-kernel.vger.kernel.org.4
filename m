Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A59BB6860FD
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 08:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbjBAHw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 02:52:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231673AbjBAHw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 02:52:27 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 136685244
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 23:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675237946; x=1706773946;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=UftT0es0p7C8C1f+ayrijKzdaPsIbazkX0gT4btA5CA=;
  b=DsbsVCIQxCyBUVnNdQ5xf4NgCsK1/Mj2O306Dw9eCGCDB93m+8ER2kFP
   oQH9eFywBk4bkx/WDjU4N7cNmLk5O94NItD3XhrmxXb89QarlRHFAl79O
   NY5A6CS+fSUHAPuUEKr6y+bP/0a2s4Y1fOP9bqrTkbA70pi8VnAC5gMLh
   N5cni57VhIGUq5Ut9PjmFdFX5n52CYW4J7drlEZw2zxtrc9isXSbYJ8AE
   g2t8oTTvsmzxhsO+hPegZuoMrTTtCQN1LE69xlQkniBl5DGCl1qX7SSmB
   91zkLcJIPV1oMO5/QfmumwMd69iOIzeCdJSQY1fWxoKR/8MvMBge2KYve
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="311722922"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; 
   d="scan'208";a="311722922"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 23:52:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="728291211"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; 
   d="scan'208";a="728291211"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 31 Jan 2023 23:52:13 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pN7uf-0005E5-0E;
        Wed, 01 Feb 2023 07:52:13 +0000
Date:   Wed, 01 Feb 2023 15:51:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 99f9b95e30d3f667ecf99ada91ea965cfd95c0dd
Message-ID: <63da1a18.hUnb0KjGfeFKLwNR%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 99f9b95e30d3f667ecf99ada91ea965cfd95c0dd  Merge x86/cpu into tip/master

elapsed time: 724m

configs tested: 37
configs skipped: 81

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
x86_64                              defconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
i386                 randconfig-a002-20230130
i386                 randconfig-a001-20230130
i386                 randconfig-a004-20230130
x86_64               randconfig-a001-20230130
i386                 randconfig-a003-20230130
x86_64               randconfig-a003-20230130
x86_64               randconfig-a002-20230130
x86_64               randconfig-a004-20230130
i386                 randconfig-a005-20230130
i386                 randconfig-a006-20230130
i386                                defconfig
x86_64               randconfig-a006-20230130
x86_64               randconfig-a005-20230130
x86_64                               rhel-8.3
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-bpf
i386                             allyesconfig
x86_64                           allyesconfig

clang tested configs:
x86_64                          rhel-8.3-rust
i386                 randconfig-a013-20230130
i386                 randconfig-a012-20230130
i386                 randconfig-a014-20230130
x86_64               randconfig-a012-20230130
x86_64               randconfig-a013-20230130
x86_64               randconfig-a011-20230130
x86_64               randconfig-a014-20230130
i386                 randconfig-a011-20230130
i386                 randconfig-a015-20230130
i386                 randconfig-a016-20230130
x86_64               randconfig-a015-20230130
x86_64               randconfig-a016-20230130

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
