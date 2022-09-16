Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9C35BA3C8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 03:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbiIPBQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 21:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiIPBQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 21:16:07 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4EA74F38D
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 18:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663290961; x=1694826961;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zqYfHz5svJs6pwIn6mzxWlv0cQKo4ZfZvTiyQztargk=;
  b=bKfO/uZDmV+JwJ8PlzYyy0smBIuY/0Yh/L4Qr6Ilse2vRymrY0KgdQmK
   BhQigRrr6hSY5kVb3i5/zPT8BtKPS9EddpLqL5uAc9DkvZVcsX3KySL++
   TP1xfkZlG8EZnR3BV3yp0aRcjUmTzsKxx/8LNCfwZ5k7lKW+O3U698T/S
   o/LW/MV+hv+woyUHZOtPyhtCf2nAe1P6Xv6M38cZu+/7GgYymmAD3k2sC
   HnYWmSLrujowcwYr4VOM0OHgn35i915WWXWUHqz7RX9IOmeYjbHQW8+Z0
   H7mdmVWMVGM61sEXOQ9PljmPbKad+ph/nOOtejh/3feaCPBvT9/HG7jL0
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10471"; a="297605442"
X-IronPort-AV: E=Sophos;i="5.93,319,1654585200"; 
   d="scan'208";a="297605442"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2022 18:16:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,319,1654585200"; 
   d="scan'208";a="706580178"
Received: from lkp-server02.sh.intel.com (HELO 41300c7200ea) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Sep 2022 18:16:00 -0700
Received: from kbuild by 41300c7200ea with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oYzxX-0001Gp-2E;
        Fri, 16 Sep 2022 01:15:59 +0000
Date:   Fri, 16 Sep 2022 09:15:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Jason A. Donenfeld" <zx2c4@kernel.org>
Cc:     kbuild-all@lists.01.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:crng/random/jd/vdso 3/3]
 arch/x86/entry/vdso/vgetrandom.c:10:9: warning: no previous prototype for
 '__vdso_getrandom'
Message-ID: <202209160915.5XAA9ILS-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block crng/random/jd/vdso
head:   a3cff810520ec7bb9afb9020a1cb7945e4bdb8b2
commit: a3cff810520ec7bb9afb9020a1cb7945e4bdb8b2 [3/3] random: implement getrandom() in vDSO
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20220916/202209160915.5XAA9ILS-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/a3cff810520ec7bb9afb9020a1cb7945e4bdb8b2
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block crng/random/jd/vdso
        git checkout a3cff810520ec7bb9afb9020a1cb7945e4bdb8b2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/entry/vdso/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/x86/entry/vdso/vgetrandom.c:10:9: warning: no previous prototype for '__vdso_getrandom' [-Wmissing-prototypes]
      10 | ssize_t __vdso_getrandom(void *buffer, size_t len, unsigned int flags, void *state)
         |         ^~~~~~~~~~~~~~~~


vim +/__vdso_getrandom +10 arch/x86/entry/vdso/vgetrandom.c

     9	
  > 10	ssize_t __vdso_getrandom(void *buffer, size_t len, unsigned int flags, void *state)
    11	{
    12		return __cvdso_getrandom(buffer, len, flags, state);
    13	}
    14	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
