Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F267762B981
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 11:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233806AbiKPKma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 05:42:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233397AbiKPKlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 05:41:45 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A99B44046C
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 02:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668594599; x=1700130599;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=qHaY1k9/440h7Ozk3wkx+/ThLOKlts/6OCB+AvN1sSk=;
  b=iz0Ezs1VKdgvGB4dZfhAoOaNSkVcnd0x09RvcRQata5yWVPSRqGYNeCh
   070kizeiQvm3Jg2ZVzlOvCCsytxqn+KRh6XuikHOm5k0UQZgz6LmWc/55
   BHZIZGFWBHv+TscrfelAyUoUq8G7XzBAkqTgxFTiBRO2Y/vy47sRd8iEg
   wk2TrQ2ia7MZKE9ZP/jluqmyopYvtHqiHuzoaGvGmqFdgHWCVAPcJfAin
   040dAAh+s+gu7zQ4WrqECRxt4lHW1R/+r7cjUYiQOTuz7DdTc3ihBxbfs
   DKzC/blCPZHdsSdvMeQw+mMg13sc/9aeRVLlbBjRp4lfNPEPD5IkRG1/f
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="398798092"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="398798092"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 02:29:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="884347401"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="884347401"
Received: from lkp-server01.sh.intel.com (HELO ebd99836cbe0) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 16 Nov 2022 02:29:58 -0800
Received: from kbuild by ebd99836cbe0 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ovFg5-0002Fn-2R;
        Wed, 16 Nov 2022 10:29:57 +0000
Date:   Wed, 16 Nov 2022 18:29:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/mm] BUILD SUCCESS
 f2089aa0cd8e52564240a93ea1e4bb643c0ed34c
Message-ID: <6374bb9f.ZDXNCo/BqA/ZQK2A%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/mm
branch HEAD: f2089aa0cd8e52564240a93ea1e4bb643c0ed34c  x86/kasan: Populate shadow for shared chunk of the CPU entry area

elapsed time: 721m

configs tested: 38
configs skipped: 74

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a001
x86_64                           rhel-8.3-syz
i386                          randconfig-a003
x86_64                        randconfig-a004
x86_64                           rhel-8.3-kvm
x86_64                        randconfig-a002
x86_64                         rhel-8.3-kunit
x86_64                        randconfig-a006
x86_64                          rhel-8.3-func
x86_64                               rhel-8.3
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
i386                          randconfig-a005
x86_64                           allyesconfig
i386                                defconfig
i386                             allyesconfig
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig

clang tested configs:
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
