Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1055BA3C9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 03:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbiIPBQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 21:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiIPBQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 21:16:07 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F8650199
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 18:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663290962; x=1694826962;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=PLOk1/LbtgFS9T66SzvZm4wtOUjH8fZf5AH4OM+Qzsc=;
  b=VotfvBgnrYQV+IPtP3aykz5XQ4bSzBW51NSBVNNUD5t0sR9IY+Io+vXM
   4VVYytRrWYFxdGihhS3j0g81bXDm6+PZfe8EsN9Feti0DtPhoERIt+/hm
   69WJhZzQdubGfftxxyyQaZ/CuIQwmD8SW9dm4ze50gdkDENHlKF/vqnQg
   Y8QPmmX9qq8F7TXszdl5prn8oRVocBHkS9nN4dK4MiQ+pYHasVqrDTXv0
   NfLV1RKrgM1sZlXx51+3cnvNW51sTk1jmjjQvBwTdQGt9+gIZ1TdhGoVa
   ntpPNOt5DaaNx2JmifPGKgj+EA5e9TvJUIb1dznjaBZdg3oaoE/8FhMyl
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10471"; a="360624175"
X-IronPort-AV: E=Sophos;i="5.93,319,1654585200"; 
   d="scan'208";a="360624175"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2022 18:16:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,319,1654585200"; 
   d="scan'208";a="685949044"
Received: from lkp-server02.sh.intel.com (HELO 41300c7200ea) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 15 Sep 2022 18:16:00 -0700
Received: from kbuild by 41300c7200ea with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oYzxX-0001Gn-2C;
        Fri, 16 Sep 2022 01:15:59 +0000
Date:   Fri, 16 Sep 2022 09:15:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Jason A. Donenfeld" <zx2c4@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:crng/random/jd/vdso 3/3] <stdin>:1565:2: warning:
 syscall vgetrandom_alloc not implemented
Message-ID: <202209160907.jMubcK2i-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block crng/random/jd/vdso
head:   a3cff810520ec7bb9afb9020a1cb7945e4bdb8b2
commit: a3cff810520ec7bb9afb9020a1cb7945e4bdb8b2 [3/3] random: implement getrandom() in vDSO
config: arm-buildonly-randconfig-r006-20220915 (https://download.01.org/0day-ci/archive/20220916/202209160907.jMubcK2i-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 791a7ae1ba3efd6bca96338e10ffde557ba83920)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/ammarfaizi2/linux-block/commit/a3cff810520ec7bb9afb9020a1cb7945e4bdb8b2
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block crng/random/jd/vdso
        git checkout a3cff810520ec7bb9afb9020a1cb7945e4bdb8b2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm prepare

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> <stdin>:1565:2: warning: syscall vgetrandom_alloc not implemented [-W#warnings]
   #warning syscall vgetrandom_alloc not implemented
    ^
   1 warning generated.
--
>> <stdin>:1565:2: warning: syscall vgetrandom_alloc not implemented [-W#warnings]
   #warning syscall vgetrandom_alloc not implemented
    ^
   1 warning generated.
--
   scripts/genksyms/parse.y: warning: 9 shift/reduce conflicts [-Wconflicts-sr]
   scripts/genksyms/parse.y: warning: 5 reduce/reduce conflicts [-Wconflicts-rr]
   scripts/genksyms/parse.y: note: rerun with option '-Wcounterexamples' to generate conflict counterexamples
>> <stdin>:1565:2: warning: syscall vgetrandom_alloc not implemented [-W#warnings]
   #warning syscall vgetrandom_alloc not implemented
    ^
   1 warning generated.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
