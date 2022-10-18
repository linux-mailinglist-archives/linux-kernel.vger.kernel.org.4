Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4510E602C89
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 15:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbiJRNLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 09:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiJRNLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 09:11:42 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33685D44
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 06:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666098702; x=1697634702;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=/zklfFYUogKemnxlvy3YB6ujD0rs5pRW6NCOqtE8a+U=;
  b=aM+c02NSq6JldrrG6cEeqnojhbucXtKzuZakEKJTp4k/aibLYw0DIRZA
   PnonfhAnXMCw8v0S+ir8wZ4aYIW64tD3U6c3h75jIYSef7XbFLOkmBeGC
   H+rTBKJqTv+Q7MNGW1O05zrx+Zm6TxAGib80QESEn0LIqH87ioNlsOzyh
   23blvCWbRCa0BMfTnTsjP3+1pAyb5wk9dTxbEH3ZpxYfX/YclPWV35pUF
   76Q0FV/AYIuwwB1jV9fmgBEAPCCXVRYQ5zro6+PRFhuGQ9qtxK3cW0Hlt
   2MqdvhluXkjxK/H67rRSn0WFtVv2kSWCAowf4aDkxlrOrXZMFnCSDW/v0
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="303712195"
X-IronPort-AV: E=Sophos;i="5.95,193,1661842800"; 
   d="scan'208";a="303712195"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 06:11:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="717924118"
X-IronPort-AV: E=Sophos;i="5.95,193,1661842800"; 
   d="scan'208";a="717924118"
Received: from lkp-server01.sh.intel.com (HELO 8381f64adc98) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 18 Oct 2022 06:11:40 -0700
Received: from kbuild by 8381f64adc98 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1okmNg-0001hp-0U;
        Tue, 18 Oct 2022 13:11:40 +0000
Date:   Tue, 18 Oct 2022 21:11:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:lazy.2022.10.14a] BUILD SUCCESS
 fcc8a2c1a54b12aade3de2b732c116470ad669f1
Message-ID: <634ea5f4.s596/1p7hGpTNr9Q%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git lazy.2022.10.14a
branch HEAD: fcc8a2c1a54b12aade3de2b732c116470ad669f1  rcu/debug: Add wake-up debugging for lazy callbacks

elapsed time: 2049m

configs tested: 29
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                           x86_64_defconfig
um                             i386_defconfig
arc                                 defconfig
alpha                               defconfig
powerpc                           allnoconfig
s390                                defconfig
s390                             allmodconfig
s390                             allyesconfig
i386                                defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
i386                             allyesconfig
sh                               allmodconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                           allyesconfig
powerpc                          allmodconfig
mips                             allyesconfig
m68k                             allmodconfig
alpha                            allyesconfig
arc                              allyesconfig
m68k                             allyesconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig
ia64                             allmodconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
