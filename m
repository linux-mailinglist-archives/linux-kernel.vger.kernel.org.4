Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3F3E6A9112
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 07:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjCCGg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 01:36:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjCCGg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 01:36:56 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 890C0166F4
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 22:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677825414; x=1709361414;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=yBbEulseJrexPnRdW5vWgUoM0mlJ+PXGrASH8nKuNaQ=;
  b=XExiEXv84J/oJJBKlPmbhcvql0TJkKWvEGVFDWJCR97vQxEAPQfMs0/8
   /6rrSoMpIqFKIMMRRSgXVH030qi4TOY5Kt6VZ2GiR0oPA7FxwXWStWWMn
   H4heNJ8gTt2n90qm+KC+j2aYv21480Q6d/j8Qzr2T07K4hQ1RXKA1aIoX
   vZtm06br9jCPXPaCYPJrnxW+j1UOGPlNMWVyAtwBd3Phu7Br5GZ/pG/eU
   FNQhX9RRrLv9INyLE28J/Hn08/R7X/8ywAXRIi/1Qwpy8KoHpZBE4DvcY
   hNw62oD21A659jXw1EjkhmJmzAYMgrtMz60ZF5Goig4EEpVXCm3DZiE9f
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="399778631"
X-IronPort-AV: E=Sophos;i="5.98,229,1673942400"; 
   d="scan'208";a="399778631"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 22:36:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="707723105"
X-IronPort-AV: E=Sophos;i="5.98,229,1673942400"; 
   d="scan'208";a="707723105"
Received: from lkp-server01.sh.intel.com (HELO 776573491cc5) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 02 Mar 2023 22:36:52 -0800
Received: from kbuild by 776573491cc5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pXz2B-0001GA-1V;
        Fri, 03 Mar 2023 06:36:51 +0000
Date:   Fri, 3 Mar 2023 14:36:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Matthew Wilcox <mawilcox@microsoft.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: arch/mips/include/asm/vga.h:46:21: sparse: sparse: incorrect type in
 argument 2 (different base types)
Message-ID: <202303031413.o8quncp8-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2eb29d59ddf02e39774abfb60b2030b0b7e27c1f
commit: ac036f9570a2d318b7d8dbbdbf0e269d7cc68cef vga: optimise console scrolling
date:   5 years ago
config: mips-randconfig-s033-20230302 (https://download.01.org/0day-ci/archive/20230303/202303031413.o8quncp8-lkp@intel.com/config)
compiler: mipsel-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ac036f9570a2d318b7d8dbbdbf0e269d7cc68cef
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout ac036f9570a2d318b7d8dbbdbf0e269d7cc68cef
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=mips olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=mips SHELL=/bin/bash drivers/tty/vt/ kernel/trace/ mm/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303031413.o8quncp8-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/tty/vt/vt.c: note: in included file (through include/linux/vt_buffer.h, include/linux/selection.h):
>> arch/mips/include/asm/vga.h:46:21: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected unsigned short [usertype] @@     got restricted __le16 [usertype] @@
   arch/mips/include/asm/vga.h:46:21: sparse:     expected unsigned short [usertype]
   arch/mips/include/asm/vga.h:46:21: sparse:     got restricted __le16 [usertype]
   arch/mips/include/asm/vga.h:41:16: sparse: sparse: cast to restricted __le16
   arch/mips/include/asm/vga.h:41:16: sparse: sparse: cast to restricted __le16
   arch/mips/include/asm/vga.h:41:16: sparse: sparse: cast to restricted __le16
   arch/mips/include/asm/vga.h:41:16: sparse: sparse: cast to restricted __le16
   arch/mips/include/asm/vga.h:36:15: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short volatile [usertype] @@     got restricted __le16 [usertype] @@
   arch/mips/include/asm/vga.h:36:15: sparse:     expected unsigned short volatile [usertype]
   arch/mips/include/asm/vga.h:36:15: sparse:     got restricted __le16 [usertype]
   arch/mips/include/asm/vga.h:41:16: sparse: sparse: cast to restricted __le16
   arch/mips/include/asm/vga.h:36:15: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short volatile [usertype] @@     got restricted __le16 [usertype] @@
   arch/mips/include/asm/vga.h:36:15: sparse:     expected unsigned short volatile [usertype]
   arch/mips/include/asm/vga.h:36:15: sparse:     got restricted __le16 [usertype]
   arch/mips/include/asm/vga.h:41:16: sparse: sparse: cast to restricted __le16
   arch/mips/include/asm/vga.h:36:15: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short volatile [usertype] @@     got restricted __le16 [usertype] @@
   arch/mips/include/asm/vga.h:36:15: sparse:     expected unsigned short volatile [usertype]
   arch/mips/include/asm/vga.h:36:15: sparse:     got restricted __le16 [usertype]
   arch/mips/include/asm/vga.h:36:15: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short volatile [usertype] @@     got restricted __le16 [usertype] @@
   arch/mips/include/asm/vga.h:36:15: sparse:     expected unsigned short volatile [usertype]
   arch/mips/include/asm/vga.h:36:15: sparse:     got restricted __le16 [usertype]
   arch/mips/include/asm/vga.h:41:16: sparse: sparse: cast to restricted __le16
   arch/mips/include/asm/vga.h:36:15: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short volatile [usertype] @@     got restricted __le16 [usertype] @@
   arch/mips/include/asm/vga.h:36:15: sparse:     expected unsigned short volatile [usertype]
   arch/mips/include/asm/vga.h:36:15: sparse:     got restricted __le16 [usertype]
>> arch/mips/include/asm/vga.h:46:21: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected unsigned short [usertype] @@     got restricted __le16 [usertype] @@
   arch/mips/include/asm/vga.h:46:21: sparse:     expected unsigned short [usertype]
   arch/mips/include/asm/vga.h:46:21: sparse:     got restricted __le16 [usertype]
>> arch/mips/include/asm/vga.h:46:21: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected unsigned short [usertype] @@     got restricted __le16 [usertype] @@
   arch/mips/include/asm/vga.h:46:21: sparse:     expected unsigned short [usertype]
   arch/mips/include/asm/vga.h:46:21: sparse:     got restricted __le16 [usertype]
   arch/mips/include/asm/vga.h:41:16: sparse: sparse: cast to restricted __le16
   arch/mips/include/asm/vga.h:36:15: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short volatile [usertype] @@     got restricted __le16 [usertype] @@
   arch/mips/include/asm/vga.h:36:15: sparse:     expected unsigned short volatile [usertype]
   arch/mips/include/asm/vga.h:36:15: sparse:     got restricted __le16 [usertype]
   arch/mips/include/asm/vga.h:36:15: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short volatile [usertype] @@     got restricted __le16 [usertype] @@
   arch/mips/include/asm/vga.h:36:15: sparse:     expected unsigned short volatile [usertype]
   arch/mips/include/asm/vga.h:36:15: sparse:     got restricted __le16 [usertype]
   arch/mips/include/asm/vga.h:41:16: sparse: sparse: cast to restricted __le16
   arch/mips/include/asm/vga.h:36:15: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short volatile [usertype] @@     got restricted __le16 [usertype] @@
   arch/mips/include/asm/vga.h:36:15: sparse:     expected unsigned short volatile [usertype]
   arch/mips/include/asm/vga.h:36:15: sparse:     got restricted __le16 [usertype]
>> arch/mips/include/asm/vga.h:46:21: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected unsigned short [usertype] @@     got restricted __le16 [usertype] @@
   arch/mips/include/asm/vga.h:46:21: sparse:     expected unsigned short [usertype]
   arch/mips/include/asm/vga.h:46:21: sparse:     got restricted __le16 [usertype]
>> arch/mips/include/asm/vga.h:46:21: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected unsigned short [usertype] @@     got restricted __le16 [usertype] @@
   arch/mips/include/asm/vga.h:46:21: sparse:     expected unsigned short [usertype]
   arch/mips/include/asm/vga.h:46:21: sparse:     got restricted __le16 [usertype]
>> arch/mips/include/asm/vga.h:46:21: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected unsigned short [usertype] @@     got restricted __le16 [usertype] @@
   arch/mips/include/asm/vga.h:46:21: sparse:     expected unsigned short [usertype]
   arch/mips/include/asm/vga.h:46:21: sparse:     got restricted __le16 [usertype]
>> arch/mips/include/asm/vga.h:46:21: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected unsigned short [usertype] @@     got restricted __le16 [usertype] @@
   arch/mips/include/asm/vga.h:46:21: sparse:     expected unsigned short [usertype]
   arch/mips/include/asm/vga.h:46:21: sparse:     got restricted __le16 [usertype]
>> arch/mips/include/asm/vga.h:46:21: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected unsigned short [usertype] @@     got restricted __le16 [usertype] @@
   arch/mips/include/asm/vga.h:46:21: sparse:     expected unsigned short [usertype]
   arch/mips/include/asm/vga.h:46:21: sparse:     got restricted __le16 [usertype]
>> arch/mips/include/asm/vga.h:46:21: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected unsigned short [usertype] @@     got restricted __le16 [usertype] @@
   arch/mips/include/asm/vga.h:46:21: sparse:     expected unsigned short [usertype]
   arch/mips/include/asm/vga.h:46:21: sparse:     got restricted __le16 [usertype]
   arch/mips/include/asm/vga.h:36:15: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short volatile [usertype] @@     got restricted __le16 [usertype] @@
   arch/mips/include/asm/vga.h:36:15: sparse:     expected unsigned short volatile [usertype]
   arch/mips/include/asm/vga.h:36:15: sparse:     got restricted __le16 [usertype]
   arch/mips/include/asm/vga.h:41:16: sparse: sparse: cast to restricted __le16
   arch/mips/include/asm/vga.h:41:16: sparse: sparse: cast to restricted __le16
   arch/mips/include/asm/vga.h:36:15: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short volatile [usertype] @@     got restricted __le16 [usertype] @@
   arch/mips/include/asm/vga.h:36:15: sparse:     expected unsigned short volatile [usertype]
   arch/mips/include/asm/vga.h:36:15: sparse:     got restricted __le16 [usertype]
   drivers/tty/vt/vt.c: In function 'do_con_trol':
   drivers/tty/vt/vt.c:1780:20: warning: this statement may fall through [-Wimplicit-fallthrough=]
    1780 |                 if (!is_kbd(vc, lnm))
         |                    ^
   drivers/tty/vt/vt.c:1782:9: note: here
    1782 |         case 13:
         |         ^~~~
   drivers/tty/vt/vt.c:1905:20: warning: this statement may fall through [-Wimplicit-fallthrough=]
    1905 |                 if (vc->vc_ques)
         |                    ^
   drivers/tty/vt/vt.c:1907:9: note: here
    1907 |         case ESgetpars:
         |         ^~~~

vim +46 arch/mips/include/asm/vga.h

    43	
    44	static inline void scr_memsetw(u16 *s, u16 v, unsigned int count)
    45	{
  > 46		memset16(s, cpu_to_le16(v), count / 2);
    47	}
    48	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
