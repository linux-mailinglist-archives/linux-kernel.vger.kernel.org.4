Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7ED56D7460
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 08:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237058AbjDEG0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 02:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbjDEG0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 02:26:04 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C32F2D50
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 23:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680675963; x=1712211963;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=t1RosdTg3HRvxEE40p8KNBUdCIX8QzrymSmEnjVG5+U=;
  b=j34uMPwoG67OwCG4tWpcag7KNC+MJ5++OanVhDSh9+IHQOX6Gy1DpgQo
   30cLj3amhzuKWuFXtqaVdAesUVSChAzNbGZTlvStnakKm8UNIsiYyQLOx
   1g3CK03ygTIv7EF0p2f1l1I55mA3PCUXrqp/zsSSz36CZ+uOMbthRP0AS
   2lifFktZhXzelhJSivEauk9RB+v0lRXlCXARBtI1bkwffDJOrvzBgiKnu
   VjdHmQpRH3AXJcY5Z48tkssXPKpW255YS2PFyx2mJE17lN6jwgFtGu0Kl
   8wEblXEgYq+Lw1OZNhx4In9ObWNi9mXUCvJo+gWpN59Vig2uWD2OShVRt
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="326416954"
X-IronPort-AV: E=Sophos;i="5.98,319,1673942400"; 
   d="scan'208";a="326416954"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2023 23:26:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="1016366265"
X-IronPort-AV: E=Sophos;i="5.98,319,1673942400"; 
   d="scan'208";a="1016366265"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 04 Apr 2023 23:26:01 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pjwam-000QMQ-0s;
        Wed, 05 Apr 2023 06:26:00 +0000
Date:   Wed, 5 Apr 2023 14:25:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Joey Gouly <joey.gouly@arm.com>
Subject: mdwe_test.c:166:19: warning: variable 'p2' set but not used
Message-ID: <202304051408.2PaUqA4m-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   76f598ba7d8e2bfb4855b5298caedd5af0c374a8
commit: 4cf1fe34fd18b752ae2403927277715d4444f331 kselftest: vm: add tests for memory-deny-write-execute
date:   9 weeks ago
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce:
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4cf1fe34fd18b752ae2403927277715d4444f331
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 4cf1fe34fd18b752ae2403927277715d4444f331
        make O=/tmp/kselftest headers
        make O=/tmp/kselftest -C tools/testing/selftests

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304051408.2PaUqA4m-lkp@intel.com/

All warnings (new ones prefixed by >>):

   mdwe_test.c: In function 'mdwe_mmap_FIXED':
>> mdwe_test.c:166:19: warning: variable 'p2' set but not used [-Wunused-but-set-variable]
     166 |         void *p, *p2;
         |                   ^~

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
