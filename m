Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAF8468A646
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 23:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233060AbjBCWmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 17:42:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbjBCWmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 17:42:23 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9F120D00
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 14:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675464142; x=1707000142;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=vo0xXr01l1cx/ojigtQ7R/3TxE5UQfZlKkiyf7qJbGI=;
  b=A+NXm+L8wKTO8rb9SmYuLFN8IAds2MIPs3gaf2PfZKoFUOFWuKeAEjuw
   ppogEFtYuTVB7j0aJLLtsBfvB7O2HPC20aPfud8veyEAgvm3+qB5g0OlP
   iNvodLuIBllTwdC3Mb87PMbalU9TSP++mdOxUBLpGTIxnCB36yLzLuKnv
   7P7IjeBR9RiVzmLvvWsuqLBOCwJrPWWciZrNH5dZx70NDZiniDehRDbcc
   2GtGYuhmUbKMoutIP31VszxAU46yW7/b6B/RCmAhRWzxTg6lH19zxwtmc
   izdXFWMj+06RPFP8PlmX3qpb5rt3JpMbwys3q6Sm/oJ2p1I8HaJwImwFY
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10610"; a="356218504"
X-IronPort-AV: E=Sophos;i="5.97,271,1669104000"; 
   d="scan'208";a="356218504"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2023 14:42:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10610"; a="698225782"
X-IronPort-AV: E=Sophos;i="5.97,271,1669104000"; 
   d="scan'208";a="698225782"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 03 Feb 2023 14:42:20 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pO4l9-0000oj-0p;
        Fri, 03 Feb 2023 22:42:19 +0000
Date:   Sat, 4 Feb 2023 06:42:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ian Rogers <irogers@google.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        x86@kernel.org, Josh Poimboeuf <jpoimboe@kernel.org>
Subject: [tip:objtool/core 3/8] <stdin>:1:10: fatal error: libelf.h: No such
 file or directory
Message-ID: <202302040614.HtRK9IrP-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool/core
head:   391e6d2abd652b460d9017b2f8a8ded508c09558
commit: 93eacc15687a491a9cf829f94b6891bf544084f3 [3/8] objtool: Fix HOSTCC flag usage
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20230204/202302040614.HtRK9IrP-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=93eacc15687a491a9cf829f94b6891bf544084f3
        git remote add tip https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
        git fetch --no-tags tip objtool/core
        git checkout 93eacc15687a491a9cf829f94b6891bf544084f3
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc prepare

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> <stdin>:1:10: fatal error: libelf.h: No such file or directory
   compilation terminated.
   scripts/genksyms/parse.y: warning: 9 shift/reduce conflicts [-Wconflicts-sr]
   scripts/genksyms/parse.y: warning: 5 reduce/reduce conflicts [-Wconflicts-rr]
   scripts/genksyms/parse.y: note: rerun with option '-Wcounterexamples' to generate conflict counterexamples
   elf.c: In function 'read_sections':
   elf.c:273:9: error: 'elf_getshnum' is deprecated [-Werror=deprecated-declarations]
     273 |         if (elf_getshdrnum(elf->elf, &sections_nr)) {
         |         ^~
   In file included from /usr/include/gelf.h:32,
                    from tools/objtool/include/objtool/elf.h:10,
                    from elf.c:22:
   /usr/include/libelf.h:310:12: note: declared here
     310 | extern int elf_getshnum (Elf *__elf, size_t *__dst)
         |            ^~~~~~~~~~~~
   elf.c:278:9: error: 'elf_getshstrndx' is deprecated [-Werror=deprecated-declarations]
     278 |         if (elf_getshdrstrndx(elf->elf, &shstrndx)) {
         |         ^~
   /usr/include/libelf.h:322:12: note: declared here
     322 | extern int elf_getshstrndx (Elf *__elf, size_t *__dst)
         |            ^~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors
   make[4]: *** [tools/build/Makefile.build:96: tools/objtool/elf.o] Error 1
   make[4]: *** Waiting for unfinished jobs....
   make[3]: *** [Makefile:66: tools/objtool/objtool-in.o] Error 2
   make[2]: *** [Makefile:73: objtool] Error 2
   make[1]: *** [Makefile:1439: tools/objtool] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:242: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
