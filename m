Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12BC9635106
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 08:17:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236256AbiKWHRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 02:17:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235612AbiKWHRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 02:17:15 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A6CF801D
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 23:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669187834; x=1700723834;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Nrgye89etE0QGPMrXbvgq5tgpKQhySQZ5VS5MrNldis=;
  b=KYRdosrDUqxiRAMJ92/yCK29X1+B+Y+c4yma+uljZgFdZh6yd2ByrLal
   UJJdlPdYiXUqbYMa3FheV8Rm+AtaVeUg7GxPhAWRXlO03czIgN/kCkrQ/
   8Gp+NW30yxjV0sm0xaWA63gj9WHp61U0B3Fy/fu/Lp45/baKxy2QvT86r
   5ktQ/FWhi+ZL2HGrngIs0bDBnQKBkMYymsRC0g1WavUf//MJPtFDmS0W9
   WVIlCfJYXrBA4HjqFDE/OXTNeNadYk4jUZE1sKvFbu6WVaX+laa8M28qz
   kriLccgNcGsIOJoNBHlr2mWS9NuJLUlOAswX+ZOo6kBaXS8mBIU5BH757
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="400292396"
X-IronPort-AV: E=Sophos;i="5.96,186,1665471600"; 
   d="scan'208";a="400292396"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 23:17:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="641693602"
X-IronPort-AV: E=Sophos;i="5.96,186,1665471600"; 
   d="scan'208";a="641693602"
Received: from lkp-server01.sh.intel.com (HELO 64a2d449c951) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 22 Nov 2022 23:17:00 -0800
Received: from kbuild by 64a2d449c951 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oxk0A-0002QR-1c;
        Wed, 23 Nov 2022 07:16:58 +0000
Date:   Wed, 23 Nov 2022 15:16:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 1682b36ba3534371330805b73051d15acd41f744
Message-ID: <637dc8ba.8kwLOftdGhlxeugm%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 1682b36ba3534371330805b73051d15acd41f744  Merge x86/cpu into tip/master

elapsed time: 792m

configs tested: 28
configs skipped: 88

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
i386                                defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
i386                             allyesconfig

clang tested configs:
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
x86_64               randconfig-a004-20221121
x86_64               randconfig-a001-20221121
x86_64               randconfig-a003-20221121
x86_64               randconfig-a002-20221121
x86_64               randconfig-a006-20221121
x86_64               randconfig-a005-20221121
i386                 randconfig-a001-20221121
i386                 randconfig-a003-20221121
i386                 randconfig-a002-20221121
i386                 randconfig-a004-20221121
i386                 randconfig-a005-20221121
i386                 randconfig-a006-20221121

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
