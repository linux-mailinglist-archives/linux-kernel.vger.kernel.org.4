Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB1E4733E33
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 07:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232948AbjFQFRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 01:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbjFQFRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 01:17:20 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A8310D1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 22:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686979039; x=1718515039;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=V5xkK2rElWwrYcGj6hIZaRQE8ORUl+xbKEeQFpcOimk=;
  b=ESzppGJWj58GNloyimQ5M7W0v3TTgFY0+2nXyaVjFXsDnf+0YYNwxrvd
   4TQ20/Stjm1hlt8EZwAbJWShjbpWXS7toE2Ce7DVnKz9tpJCAZVQY5uIF
   Z+J1Fey/VrrkGeZKHPrHIwUitnCC7yUQxHYFGBx4ZurMYDv01OD0IH9E2
   DKi05dei9nhuZgJTBWu2GF8vgJUOKiv/hFvwlXATHDS3oqzGgQzBQ2Cou
   FQmpEHDjyE1SU52198RHY30Tf9W1cZJCllrwXbGdMmADyYyY/5fbTVAw3
   G7bFc0shyE+XjsrgiiWvfsq8xGmIlz1f7oTl3PA2rqOHyj6RGGIVlr5h3
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="425303234"
X-IronPort-AV: E=Sophos;i="6.00,249,1681196400"; 
   d="scan'208";a="425303234"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 22:17:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="707315736"
X-IronPort-AV: E=Sophos;i="6.00,249,1681196400"; 
   d="scan'208";a="707315736"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 16 Jun 2023 22:17:17 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qAOJI-0002Jw-0h;
        Sat, 17 Jun 2023 05:17:16 +0000
Date:   Sat, 17 Jun 2023 13:16:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>
Subject: mm/kasan/shadow.c:49: multiple definition of `memset';
 arch/x86/lib/memset_64.o:arch/x86/um/../lib/memset_64.S:29: first defined
 here
Message-ID: <202306171302.fa4CDGXG-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1639fae5132bc8a904af28d97cea0bedb3af802e
commit: 69d4c0d3218692ffa56b0e1b9c76c50c699d7044 entry, kasan, x86: Disallow overriding mem*() functions
date:   5 months ago
config: um-randconfig-r012-20230617 (https://download.01.org/0day-ci/archive/20230617/202306171302.fa4CDGXG-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=69d4c0d3218692ffa56b0e1b9c76c50c699d7044
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 69d4c0d3218692ffa56b0e1b9c76c50c699d7044
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=um olddefconfig
        make W=1 O=build_dir ARCH=um SHELL=/bin/bash

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306171302.fa4CDGXG-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: mm/kasan/shadow.o: in function `memset':
>> mm/kasan/shadow.c:49: multiple definition of `memset'; arch/x86/lib/memset_64.o:arch/x86/um/../lib/memset_64.S:29: first defined here
   ld: mm/kasan/shadow.o: in function `memmove':
>> mm/kasan/shadow.c:59: multiple definition of `memmove'; arch/x86/lib/memmove_64.o:arch/x86/um/../lib/memmove_64.S:31: first defined here
   ld: mm/kasan/shadow.o: in function `memcpy':
>> mm/kasan/shadow.c:70: multiple definition of `memcpy'; arch/x86/lib/memcpy_64.o:arch/x86/um/../lib/memcpy_64.S:32: first defined here


vim +49 mm/kasan/shadow.c

bb359dbcb70085 Andrey Konovalov 2020-12-22  40  
69d4c0d3218692 Peter Zijlstra   2023-01-12  41  #ifndef CONFIG_GENERIC_ENTRY
69d4c0d3218692 Peter Zijlstra   2023-01-12  42  /*
69d4c0d3218692 Peter Zijlstra   2023-01-12  43   * CONFIG_GENERIC_ENTRY relies on compiler emitted mem*() calls to not be
69d4c0d3218692 Peter Zijlstra   2023-01-12  44   * instrumented. KASAN enabled toolchains should emit __asan_mem*() functions
69d4c0d3218692 Peter Zijlstra   2023-01-12  45   * for the sites they want to instrument.
69d4c0d3218692 Peter Zijlstra   2023-01-12  46   */
bb359dbcb70085 Andrey Konovalov 2020-12-22  47  #undef memset
bb359dbcb70085 Andrey Konovalov 2020-12-22  48  void *memset(void *addr, int c, size_t len)
bb359dbcb70085 Andrey Konovalov 2020-12-22 @49  {
f00748bfa0246c Andrey Konovalov 2021-02-24  50  	if (!kasan_check_range((unsigned long)addr, len, true, _RET_IP_))
bb359dbcb70085 Andrey Konovalov 2020-12-22  51  		return NULL;
bb359dbcb70085 Andrey Konovalov 2020-12-22  52  
bb359dbcb70085 Andrey Konovalov 2020-12-22  53  	return __memset(addr, c, len);
bb359dbcb70085 Andrey Konovalov 2020-12-22  54  }
bb359dbcb70085 Andrey Konovalov 2020-12-22  55  
bb359dbcb70085 Andrey Konovalov 2020-12-22  56  #ifdef __HAVE_ARCH_MEMMOVE
bb359dbcb70085 Andrey Konovalov 2020-12-22  57  #undef memmove
bb359dbcb70085 Andrey Konovalov 2020-12-22  58  void *memmove(void *dest, const void *src, size_t len)
bb359dbcb70085 Andrey Konovalov 2020-12-22 @59  {
f00748bfa0246c Andrey Konovalov 2021-02-24  60  	if (!kasan_check_range((unsigned long)src, len, false, _RET_IP_) ||
f00748bfa0246c Andrey Konovalov 2021-02-24  61  	    !kasan_check_range((unsigned long)dest, len, true, _RET_IP_))
bb359dbcb70085 Andrey Konovalov 2020-12-22  62  		return NULL;
bb359dbcb70085 Andrey Konovalov 2020-12-22  63  
bb359dbcb70085 Andrey Konovalov 2020-12-22  64  	return __memmove(dest, src, len);
bb359dbcb70085 Andrey Konovalov 2020-12-22  65  }
bb359dbcb70085 Andrey Konovalov 2020-12-22  66  #endif
bb359dbcb70085 Andrey Konovalov 2020-12-22  67  
bb359dbcb70085 Andrey Konovalov 2020-12-22  68  #undef memcpy
bb359dbcb70085 Andrey Konovalov 2020-12-22  69  void *memcpy(void *dest, const void *src, size_t len)
bb359dbcb70085 Andrey Konovalov 2020-12-22 @70  {
f00748bfa0246c Andrey Konovalov 2021-02-24  71  	if (!kasan_check_range((unsigned long)src, len, false, _RET_IP_) ||
f00748bfa0246c Andrey Konovalov 2021-02-24  72  	    !kasan_check_range((unsigned long)dest, len, true, _RET_IP_))
bb359dbcb70085 Andrey Konovalov 2020-12-22  73  		return NULL;
bb359dbcb70085 Andrey Konovalov 2020-12-22  74  
bb359dbcb70085 Andrey Konovalov 2020-12-22  75  	return __memcpy(dest, src, len);
bb359dbcb70085 Andrey Konovalov 2020-12-22  76  }
69d4c0d3218692 Peter Zijlstra   2023-01-12  77  #endif
69d4c0d3218692 Peter Zijlstra   2023-01-12  78  

:::::: The code at line 49 was first introduced by commit
:::::: bb359dbcb70085a63e8bdbf14837a900750f0cf7 kasan: split out shadow.c from common.c

:::::: TO: Andrey Konovalov <andreyknvl@google.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
