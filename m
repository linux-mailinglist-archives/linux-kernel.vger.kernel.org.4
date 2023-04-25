Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 720DD6EE98F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 23:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236370AbjDYVYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 17:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236369AbjDYVYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 17:24:04 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF2D017A23
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 14:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682457843; x=1713993843;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=MT1iV8CFEJe4SxnoL8XxQKKdfab1gHYX4nK6vr9DknQ=;
  b=Mn7oG9inv3YC8QtRRJbdwAHQM12sGIWsl13X0DyJZTEeaPVvPMNv9eSi
   C27OeyVEf7yznkJmiUd5TFCmO7K/4popat6Pc4JnltYK4CzpKY01Aw3E9
   MMjkpQutvnqX0Kbe0rHcKzy7vJELK+DR8nY4Iua7tcUjbI6LMwTkE45Sh
   6wuoesPvwyZMrfYuLPMwrZyXDC9yLK7W9105hhXmrFyUhreF+MrOg5lBw
   oO/RLFxco/UJIhPoRb+SITYSZakc8gh1Z3tgiZ3ayvWO308DB39OMNpvt
   2HVXaPxgg/R9PQFOO0vTmKqlVi01SICLOHgjY/ZomCnIOIA6FdNDsunZw
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10691"; a="409870923"
X-IronPort-AV: E=Sophos;i="5.99,226,1677571200"; 
   d="scan'208";a="409870923"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2023 14:24:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10691"; a="687629573"
X-IronPort-AV: E=Sophos;i="5.99,226,1677571200"; 
   d="scan'208";a="687629573"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 25 Apr 2023 14:24:01 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1prQ8m-000jma-0o;
        Tue, 25 Apr 2023 21:24:00 +0000
Date:   Wed, 26 Apr 2023 05:23:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/fsfa3-next-20230425 1/1]
 include/linux/fortify-string.h:57:33: warning: '__builtin_memcpy' specified
 bound between 2147483648 and 4294967295 exceeds maximum object size
 2147483647
Message-ID: <202304260540.8xVWxKhO-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/fsfa3-next-20230425
head:   b82a35ff486df1d6737f532e08e060c466f9e652
commit: b82a35ff486df1d6737f532e08e060c466f9e652 [1/1] Makefile: Enable -Wstringop-overflow and -Warray-bounds
config: i386-randconfig-a014-20230424 (https://download.01.org/0day-ci/archive/20230426/202304260540.8xVWxKhO-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git/commit/?id=b82a35ff486df1d6737f532e08e060c466f9e652
        git remote add gustavoars https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git
        git fetch --no-tags gustavoars testing/fsfa3-next-20230425
        git checkout b82a35ff486df1d6737f532e08e060c466f9e652
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 olddefconfig
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash fs/udf/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304260540.8xVWxKhO-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/string.h:254,
                    from arch/x86/include/asm/page_32.h:18,
                    from arch/x86/include/asm/page.h:14,
                    from arch/x86/include/asm/thread_info.h:12,
                    from include/linux/thread_info.h:60,
                    from arch/x86/include/asm/preempt.h:9,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:56,
                    from include/linux/wait.h:9,
                    from include/linux/wait_bit.h:8,
                    from include/linux/fs.h:6,
                    from fs/udf/udfdecl.h:10,
                    from fs/udf/directory.c:14:
   fs/udf/directory.c: In function 'udf_copy_fi':
>> include/linux/fortify-string.h:57:33: warning: '__builtin_memcpy' specified bound between 2147483648 and 4294967295 exceeds maximum object size 2147483647 [-Wstringop-overflow=]
      57 | #define __underlying_memcpy     __builtin_memcpy
         |                                 ^
   include/linux/fortify-string.h:585:9: note: in expansion of macro '__underlying_memcpy'
     585 |         __underlying_##op(p, q, __fortify_size);                        \
         |         ^~~~~~~~~~~~~
   include/linux/fortify-string.h:630:26: note: in expansion of macro '__fortify_memcpy_chk'
     630 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
         |                          ^~~~~~~~~~~~~~~~~~~~
   fs/udf/directory.c:103:9: note: in expansion of macro 'memcpy'
     103 |         memcpy(&iter->fi, iter->bh[0]->b_data + off, len);
         |         ^~~~~~


vim +/__builtin_memcpy +57 include/linux/fortify-string.h

78a498c3a227f2a Alexander Potapenko 2022-10-24  46  
78a498c3a227f2a Alexander Potapenko 2022-10-24  47  #if defined(__SANITIZE_MEMORY__)
78a498c3a227f2a Alexander Potapenko 2022-10-24  48  /*
78a498c3a227f2a Alexander Potapenko 2022-10-24  49   * For KMSAN builds all memcpy/memset/memmove calls should be replaced by the
78a498c3a227f2a Alexander Potapenko 2022-10-24  50   * corresponding __msan_XXX functions.
78a498c3a227f2a Alexander Potapenko 2022-10-24  51   */
78a498c3a227f2a Alexander Potapenko 2022-10-24  52  #include <linux/kmsan_string.h>
78a498c3a227f2a Alexander Potapenko 2022-10-24  53  #define __underlying_memcpy	__msan_memcpy
78a498c3a227f2a Alexander Potapenko 2022-10-24  54  #define __underlying_memmove	__msan_memmove
78a498c3a227f2a Alexander Potapenko 2022-10-24  55  #define __underlying_memset	__msan_memset
78a498c3a227f2a Alexander Potapenko 2022-10-24  56  #else
a28a6e860c6cf23 Francis Laniel      2021-02-25 @57  #define __underlying_memcpy	__builtin_memcpy
a28a6e860c6cf23 Francis Laniel      2021-02-25  58  #define __underlying_memmove	__builtin_memmove
a28a6e860c6cf23 Francis Laniel      2021-02-25  59  #define __underlying_memset	__builtin_memset
78a498c3a227f2a Alexander Potapenko 2022-10-24  60  #endif
78a498c3a227f2a Alexander Potapenko 2022-10-24  61  

:::::: The code at line 57 was first introduced by commit
:::::: a28a6e860c6cf231cf3c5171c75c342adcd00406 string.h: move fortified functions definitions in a dedicated header.

:::::: TO: Francis Laniel <laniel_francis@privacyrequired.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
