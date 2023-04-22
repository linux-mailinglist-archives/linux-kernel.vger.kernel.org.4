Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A95206EB856
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 11:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjDVJ5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 05:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDVJ5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 05:57:48 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D48B1BDC;
        Sat, 22 Apr 2023 02:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682157466; x=1713693466;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cG7+KgDAr4AYUlsLPJRfqGCBuV8Fdm49l4MwT8XOd+c=;
  b=k5DsePEZ5gWV/SIhDs9PCnmSz/8o8iZ3cCbfAVoMl9Wp6Xyk1n4rsj2X
   TeklKk66jpF/KQOa7O6CUa86EagQ/5bD9givAoAEHQPBuyNi3NWUOT+a3
   06OdB6/hxo8cEuMZH0KAqrFLh7q4G+s1jfxbIfhnx+UE6BpqjzWGyy/1i
   rm986LzhrHQh2x5f4mKXY/hZDhW69veet5I6S0IMWca9ZicnSm8/4m3Or
   0k8PdaUGutcSIl0rlfpnxWP30uZzXJGyOrD7CGzpPwTnx8PIjQJmoidh0
   N+duFra4MJRWOdfU9Zt1ij5A/8GX6R+HkpC/TLILF8LMElIS7uf8HFp7e
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="326472827"
X-IronPort-AV: E=Sophos;i="5.99,218,1677571200"; 
   d="scan'208";a="326472827"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2023 02:57:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="642775237"
X-IronPort-AV: E=Sophos;i="5.99,218,1677571200"; 
   d="scan'208";a="642775237"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 22 Apr 2023 02:57:42 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pq9zx-000hEW-0j;
        Sat, 22 Apr 2023 09:57:41 +0000
Date:   Sat, 22 Apr 2023 17:56:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, bfoster@redhat.com,
        willy@infradead.org, linux-api@vger.kernel.org,
        kernel-team@meta.com
Subject: Re: [PATCH v12 2/3] cachestat: implement cachestat syscall
Message-ID: <202304221702.Ye705xoC-lkp@intel.com>
References: <20230421231421.2401346-3-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230421231421.2401346-3-nphamcs@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nhat,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]
[cannot apply to shuah-kselftest/next shuah-kselftest/fixes linus/master tip/x86/asm v6.3-rc7 next-20230421]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Nhat-Pham/workingset-refactor-LRU-refault-to-expose-refault-recency-check/20230422-071625
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20230421231421.2401346-3-nphamcs%40gmail.com
patch subject: [PATCH v12 2/3] cachestat: implement cachestat syscall
config: x86_64-randconfig-a016 (https://download.01.org/0day-ci/archive/20230422/202304221702.Ye705xoC-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/9691e4430fbb59890619289b45ee0ce9ec3e97ee
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Nhat-Pham/workingset-refactor-LRU-refault-to-expose-refault-recency-check/20230422-071625
        git checkout 9691e4430fbb59890619289b45ee0ce9ec3e97ee
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304221702.Ye705xoC-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

>> mm/filemap.c:4293:35: error: expected identifier
   COMPAT_SYSCALL_DEFINE6(cachestat, unsigned int, fd, size_t, len,
                                     ^
>> mm/filemap.c:4293:1: error: type specifier missing, defaults to 'int' [-Werror,-Wimplicit-int]
   COMPAT_SYSCALL_DEFINE6(cachestat, unsigned int, fd, size_t, len,
   ^
>> mm/filemap.c:4297:33: error: implicit declaration of function 'compat_arg_u64_glue' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           return ksys_cachestat(fd, len, compat_arg_u64_glue(off), cstat, flags);
                                          ^
>> mm/filemap.c:4297:24: error: use of undeclared identifier 'fd'
           return ksys_cachestat(fd, len, compat_arg_u64_glue(off), cstat, flags);
                                 ^
>> mm/filemap.c:4297:28: error: use of undeclared identifier 'len'
           return ksys_cachestat(fd, len, compat_arg_u64_glue(off), cstat, flags);
                                     ^
>> mm/filemap.c:4297:53: error: use of undeclared identifier 'off'
           return ksys_cachestat(fd, len, compat_arg_u64_glue(off), cstat, flags);
                                                              ^
>> mm/filemap.c:4297:59: error: use of undeclared identifier 'cstat'
           return ksys_cachestat(fd, len, compat_arg_u64_glue(off), cstat, flags);
                                                                    ^
>> mm/filemap.c:4297:66: error: use of undeclared identifier 'flags'
           return ksys_cachestat(fd, len, compat_arg_u64_glue(off), cstat, flags);
                                                                           ^
>> mm/filemap.c:4293:1: warning: no previous prototype for function 'COMPAT_SYSCALL_DEFINE6' [-Wmissing-prototypes]
   COMPAT_SYSCALL_DEFINE6(cachestat, unsigned int, fd, size_t, len,
   ^
   mm/filemap.c:4293:23: note: declare 'static' if the function is not intended to be used outside of this translation unit
   COMPAT_SYSCALL_DEFINE6(cachestat, unsigned int, fd, size_t, len,
                         ^
                         static 
>> mm/filemap.c:4293:23: error: this old-style function definition is not preceded by a prototype [-Werror,-Wstrict-prototypes]
   COMPAT_SYSCALL_DEFINE6(cachestat, unsigned int, fd, size_t, len,
                         ^
   1 warning and 9 errors generated.


vim +4293 mm/filemap.c

  4291	
  4292	#ifdef CONFIG_COMPAT
> 4293	COMPAT_SYSCALL_DEFINE6(cachestat, unsigned int, fd, size_t, len,
  4294			compat_arg_u64_dual(off), struct cachestat __user *, cstat,
  4295			unsigned int, flags)
  4296	{
> 4297		return ksys_cachestat(fd, len, compat_arg_u64_glue(off), cstat, flags);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
