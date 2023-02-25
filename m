Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA1DF6A2A4E
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 15:29:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjBYO3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 09:29:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBYO3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 09:29:36 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2069514E8C
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 06:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677335375; x=1708871375;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=yEkCgk0qdxam3842EPDUAaAEj9sbPPlM9MJlt5GSFu0=;
  b=LteHyYDru6wViPKrveTxNyTpE3KKluzmIxZeM7tRfeTKQMAj8fbcjrru
   xHfF7yQeD/0eEiBgej/qavoHNKocS4eGHEeNgswR7kVFrCDNUO0iKuhOD
   jO+Oqo+VQC2rds46Zkh7rpGEvmda40+zgPgGzeURybVEDS/IOTapLYzeG
   NDroO3v6E9aJcjw+CvTl5K6dmxuuHtQRVKRxZM+HieOTG9pZcOrzawDCj
   uL3GBwrm+YyDmC2QjOvGYU5Anw9mgTj88eB9qjGV33hM6k12tmmriM3BW
   7U24VU6oBU+oYK4IEPrick8GUQePlNLXgY4w0UuGYgRMuQbJJntW9W1vo
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10631"; a="335100416"
X-IronPort-AV: E=Sophos;i="5.97,327,1669104000"; 
   d="scan'208";a="335100416"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2023 06:29:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10631"; a="705602975"
X-IronPort-AV: E=Sophos;i="5.97,327,1669104000"; 
   d="scan'208";a="705602975"
Received: from lkp-server01.sh.intel.com (HELO 3895f5c55ead) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 25 Feb 2023 06:29:33 -0800
Received: from kbuild by 3895f5c55ead with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pVvYK-0003FR-0u;
        Sat, 25 Feb 2023 14:29:32 +0000
Date:   Sat, 25 Feb 2023 22:29:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: arch/arm/mm/copypage-xsc3.c:64:6: warning: no previous prototype for
 function 'xsc3_mc_copy_user_highpage'
Message-ID: <202302252213.uGXXs6Lo-lkp@intel.com>
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

Hi Arnd,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   489fa31ea873282b41046d412ec741f93946fc2d
commit: 250c1a694ff304e5d69e74ab32755eddcc2b8f65 ARM: pxa: convert to multiplatform
date:   10 months ago
config: arm-randconfig-r046-20230225 (https://download.01.org/0day-ci/archive/20230225/202302252213.uGXXs6Lo-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project db89896bbbd2251fff457699635acbbedeead27f)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=250c1a694ff304e5d69e74ab32755eddcc2b8f65
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 250c1a694ff304e5d69e74ab32755eddcc2b8f65
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash arch/arm/mm/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302252213.uGXXs6Lo-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/arm/mm/copypage-xsc3.c:64:6: warning: no previous prototype for function 'xsc3_mc_copy_user_highpage' [-Wmissing-prototypes]
   void xsc3_mc_copy_user_highpage(struct page *to, struct page *from,
        ^
   arch/arm/mm/copypage-xsc3.c:64:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void xsc3_mc_copy_user_highpage(struct page *to, struct page *from,
   ^
   static 
>> arch/arm/mm/copypage-xsc3.c:80:6: warning: no previous prototype for function 'xsc3_mc_clear_user_highpage' [-Wmissing-prototypes]
   void xsc3_mc_clear_user_highpage(struct page *page, unsigned long vaddr)
        ^
   arch/arm/mm/copypage-xsc3.c:80:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void xsc3_mc_clear_user_highpage(struct page *page, unsigned long vaddr)
   ^
   static 
   2 warnings generated.


vim +/xsc3_mc_copy_user_highpage +64 arch/arm/mm/copypage-xsc3.c

d73e60b7144a86 Russell King  2008-10-31   63  
063b0a4207e43a Russell King  2008-10-31  @64  void xsc3_mc_copy_user_highpage(struct page *to, struct page *from,
f00a75c094c340 Russell King  2009-10-05   65  	unsigned long vaddr, struct vm_area_struct *vma)
063b0a4207e43a Russell King  2008-10-31   66  {
063b0a4207e43a Russell King  2008-10-31   67  	void *kto, *kfrom;
063b0a4207e43a Russell King  2008-10-31   68  
5472e862de2bc4 Cong Wang     2011-11-25   69  	kto = kmap_atomic(to);
5472e862de2bc4 Cong Wang     2011-11-25   70  	kfrom = kmap_atomic(from);
2725898fc9bb21 Russell King  2009-10-05   71  	flush_cache_page(vma, vaddr, page_to_pfn(from));
063b0a4207e43a Russell King  2008-10-31   72  	xsc3_mc_copy_user_page(kto, kfrom);
5472e862de2bc4 Cong Wang     2011-11-25   73  	kunmap_atomic(kfrom);
5472e862de2bc4 Cong Wang     2011-11-25   74  	kunmap_atomic(kto);
063b0a4207e43a Russell King  2008-10-31   75  }
063b0a4207e43a Russell King  2008-10-31   76  
d73e60b7144a86 Russell King  2008-10-31   77  /*
d73e60b7144a86 Russell King  2008-10-31   78   * XScale optimised clear_user_page
d73e60b7144a86 Russell King  2008-10-31   79   */
303c6443659bc1 Russell King  2008-10-31  @80  void xsc3_mc_clear_user_highpage(struct page *page, unsigned long vaddr)
d73e60b7144a86 Russell King  2008-10-31   81  {
5472e862de2bc4 Cong Wang     2011-11-25   82  	void *ptr, *kaddr = kmap_atomic(page);
43ae286b7d4d8c Nicolas Pitre 2008-11-04   83  	asm volatile ("\
c8a91428941b91 Arnd Bergmann 2022-04-04   84  .arch xscale					\n\
43ae286b7d4d8c Nicolas Pitre 2008-11-04   85  	mov	r1, %2				\n\
d73e60b7144a86 Russell King  2008-10-31   86  	mov	r2, #0				\n\
d73e60b7144a86 Russell King  2008-10-31   87  	mov	r3, #0				\n\
303c6443659bc1 Russell King  2008-10-31   88  1:	mcr	p15, 0, %0, c7, c6, 1		@ invalidate line\n\
bc2eca9a682881 Nicolas Pitre 2018-11-09   89  	strd	r2, r3, [%0], #8		\n\
bc2eca9a682881 Nicolas Pitre 2018-11-09   90  	strd	r2, r3, [%0], #8		\n\
bc2eca9a682881 Nicolas Pitre 2018-11-09   91  	strd	r2, r3, [%0], #8		\n\
bc2eca9a682881 Nicolas Pitre 2018-11-09   92  	strd	r2, r3, [%0], #8		\n\
d73e60b7144a86 Russell King  2008-10-31   93  	subs	r1, r1, #1			\n\
303c6443659bc1 Russell King  2008-10-31   94  	bne	1b"
43ae286b7d4d8c Nicolas Pitre 2008-11-04   95  	: "=r" (ptr)
43ae286b7d4d8c Nicolas Pitre 2008-11-04   96  	: "0" (kaddr), "I" (PAGE_SIZE / 32)
303c6443659bc1 Russell King  2008-10-31   97  	: "r1", "r2", "r3");
5472e862de2bc4 Cong Wang     2011-11-25   98  	kunmap_atomic(kaddr);
d73e60b7144a86 Russell King  2008-10-31   99  }
d73e60b7144a86 Russell King  2008-10-31  100  

:::::: The code at line 64 was first introduced by commit
:::::: 063b0a4207e43acbeff3d4b09f43e750e0212b48 [ARM] copypage: provide our own copy_user_highpage()

:::::: TO: Russell King <rmk@dyn-67.arm.linux.org.uk>
:::::: CC: Russell King <rmk+kernel@arm.linux.org.uk>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
