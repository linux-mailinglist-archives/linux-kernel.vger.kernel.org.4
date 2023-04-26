Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 247276EFA9B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 21:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236937AbjDZTGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 15:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235174AbjDZTGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 15:06:16 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B15C420C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 12:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682535974; x=1714071974;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/DEbNytP5whQIg5LK9nS0ouwQmakwvh+/9v9k2B3g/0=;
  b=CVZR0bec6zcK+s2aiBwf6h18EoZTvE4fhQcdhBcmw41N5sFidaySf38u
   svQFh6lA2XR4Vvl72UdRX3VGem98mVBuEFfiQXHrUaDcFpL7PPx2CV4Ur
   jm+PVoNhlPd4bZfS2oRUR5OD+xWS/33rHAK1C9hKHYQXK/+Wgzl0XFFgg
   WNE/gWSFpPPdOeq2Ev/x7Upp3xd2FY1Gcz+Mu15N7VgB5Zg3u5+rCy8qb
   9m21ryn3ZmkqqO6pul8NDj5ru0hWAUtppbsKwOma1L+vy8YM8yuUfZQhk
   6PNt3iMStZujXDFMw1Fmuc47Qv2SdFCBFQMVfndYgrs2cXm+DrYUc+VcB
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="433498980"
X-IronPort-AV: E=Sophos;i="5.99,229,1677571200"; 
   d="scan'208";a="433498980"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2023 12:06:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="726682191"
X-IronPort-AV: E=Sophos;i="5.99,229,1677571200"; 
   d="scan'208";a="726682191"
Received: from lkp-server01.sh.intel.com (HELO 041f065c1b1b) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 26 Apr 2023 12:05:51 -0700
Received: from kbuild by 041f065c1b1b with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1prkSc-0000TC-1c;
        Wed, 26 Apr 2023 19:05:50 +0000
Date:   Thu, 27 Apr 2023 03:05:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: arch/arm/mm/copypage-feroceon.c:65:6: warning: no previous prototype
 for 'feroceon_copy_user_highpage'
Message-ID: <202304270251.EhO6uTLH-lkp@intel.com>
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

Hi Arnd,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5c7ecada25d2086aee607ff7deb69e77faa4aa92
commit: 8c1fb11b8a77dc489a8ef6d96c38c1297b629d06 ARM: s3c: enable s3c24xx multiplatform support
date:   1 year, 1 month ago
config: arm-randconfig-r031-20230426 (https://download.01.org/0day-ci/archive/20230427/202304270251.EhO6uTLH-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8c1fb11b8a77dc489a8ef6d96c38c1297b629d06
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 8c1fb11b8a77dc489a8ef6d96c38c1297b629d06
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash arch/arm/mm/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304270251.EhO6uTLH-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/gfp.h:6,
                    from include/linux/xarray.h:15,
                    from include/linux/list_lru.h:14,
                    from include/linux/fs.h:13,
                    from include/linux/highmem.h:5,
                    from arch/arm/mm/copypage-feroceon.c:11:
   include/linux/mmzone.h: In function '__nr_to_section':
   include/linux/mmzone.h:1404:13: warning: the comparison will always evaluate as 'true' for the address of 'mem_section' will never be NULL [-Waddress]
    1404 |         if (!mem_section[SECTION_NR_TO_ROOT(nr)])
         |             ^
   include/linux/mmzone.h:1390:27: note: 'mem_section' declared here
    1390 | extern struct mem_section mem_section[NR_SECTION_ROOTS][SECTIONS_PER_ROOT];
         |                           ^~~~~~~~~~~
   arch/arm/mm/copypage-feroceon.c: At top level:
>> arch/arm/mm/copypage-feroceon.c:65:6: warning: no previous prototype for 'feroceon_copy_user_highpage' [-Wmissing-prototypes]
      65 | void feroceon_copy_user_highpage(struct page *to, struct page *from,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>> arch/arm/mm/copypage-feroceon.c:78:6: warning: no previous prototype for 'feroceon_clear_user_highpage' [-Wmissing-prototypes]
      78 | void feroceon_clear_user_highpage(struct page *page, unsigned long vaddr)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/feroceon_copy_user_highpage +65 arch/arm/mm/copypage-feroceon.c

063b0a4207e43a Russell King  2008-10-31  @11  #include <linux/highmem.h>
d73e60b7144a86 Russell King  2008-10-31   12  
b99afae1390140 Nicolas Pitre 2018-11-07   13  static void feroceon_copy_user_page(void *kto, const void *kfrom)
d73e60b7144a86 Russell King  2008-10-31   14  {
b99afae1390140 Nicolas Pitre 2018-11-07   15  	int tmp;
b99afae1390140 Nicolas Pitre 2018-11-07   16  
b99afae1390140 Nicolas Pitre 2018-11-07   17  	asm volatile ("\
b99afae1390140 Nicolas Pitre 2018-11-07   18  1:	ldmia	%1!, {r2 - r7, ip, lr}		\n\
b99afae1390140 Nicolas Pitre 2018-11-07   19  	pld	[%1, #0]			\n\
b99afae1390140 Nicolas Pitre 2018-11-07   20  	pld	[%1, #32]			\n\
b99afae1390140 Nicolas Pitre 2018-11-07   21  	pld	[%1, #64]			\n\
b99afae1390140 Nicolas Pitre 2018-11-07   22  	pld	[%1, #96]			\n\
b99afae1390140 Nicolas Pitre 2018-11-07   23  	pld	[%1, #128]			\n\
b99afae1390140 Nicolas Pitre 2018-11-07   24  	pld	[%1, #160]			\n\
b99afae1390140 Nicolas Pitre 2018-11-07   25  	pld	[%1, #192]			\n\
b99afae1390140 Nicolas Pitre 2018-11-07   26  	stmia	%0, {r2 - r7, ip, lr}		\n\
b99afae1390140 Nicolas Pitre 2018-11-07   27  	ldmia	%1!, {r2 - r7, ip, lr}		\n\
b99afae1390140 Nicolas Pitre 2018-11-07   28  	mcr	p15, 0, %0, c7, c14, 1		@ clean and invalidate D line\n\
b99afae1390140 Nicolas Pitre 2018-11-07   29  	add	%0, %0, #32			\n\
b99afae1390140 Nicolas Pitre 2018-11-07   30  	stmia	%0, {r2 - r7, ip, lr}		\n\
b99afae1390140 Nicolas Pitre 2018-11-07   31  	ldmia	%1!, {r2 - r7, ip, lr}		\n\
b99afae1390140 Nicolas Pitre 2018-11-07   32  	mcr	p15, 0, %0, c7, c14, 1		@ clean and invalidate D line\n\
b99afae1390140 Nicolas Pitre 2018-11-07   33  	add	%0, %0, #32			\n\
b99afae1390140 Nicolas Pitre 2018-11-07   34  	stmia	%0, {r2 - r7, ip, lr}		\n\
b99afae1390140 Nicolas Pitre 2018-11-07   35  	ldmia	%1!, {r2 - r7, ip, lr}		\n\
b99afae1390140 Nicolas Pitre 2018-11-07   36  	mcr	p15, 0, %0, c7, c14, 1		@ clean and invalidate D line\n\
b99afae1390140 Nicolas Pitre 2018-11-07   37  	add	%0, %0, #32			\n\
b99afae1390140 Nicolas Pitre 2018-11-07   38  	stmia	%0, {r2 - r7, ip, lr}		\n\
b99afae1390140 Nicolas Pitre 2018-11-07   39  	ldmia	%1!, {r2 - r7, ip, lr}		\n\
b99afae1390140 Nicolas Pitre 2018-11-07   40  	mcr	p15, 0, %0, c7, c14, 1		@ clean and invalidate D line\n\
b99afae1390140 Nicolas Pitre 2018-11-07   41  	add	%0, %0, #32			\n\
b99afae1390140 Nicolas Pitre 2018-11-07   42  	stmia	%0, {r2 - r7, ip, lr}		\n\
b99afae1390140 Nicolas Pitre 2018-11-07   43  	ldmia	%1!, {r2 - r7, ip, lr}		\n\
b99afae1390140 Nicolas Pitre 2018-11-07   44  	mcr	p15, 0, %0, c7, c14, 1		@ clean and invalidate D line\n\
b99afae1390140 Nicolas Pitre 2018-11-07   45  	add	%0, %0, #32			\n\
b99afae1390140 Nicolas Pitre 2018-11-07   46  	stmia	%0, {r2 - r7, ip, lr}		\n\
b99afae1390140 Nicolas Pitre 2018-11-07   47  	ldmia	%1!, {r2 - r7, ip, lr}		\n\
b99afae1390140 Nicolas Pitre 2018-11-07   48  	mcr	p15, 0, %0, c7, c14, 1		@ clean and invalidate D line\n\
b99afae1390140 Nicolas Pitre 2018-11-07   49  	add	%0, %0, #32			\n\
b99afae1390140 Nicolas Pitre 2018-11-07   50  	stmia	%0, {r2 - r7, ip, lr}		\n\
b99afae1390140 Nicolas Pitre 2018-11-07   51  	ldmia	%1!, {r2 - r7, ip, lr}		\n\
b99afae1390140 Nicolas Pitre 2018-11-07   52  	mcr	p15, 0, %0, c7, c14, 1		@ clean and invalidate D line\n\
b99afae1390140 Nicolas Pitre 2018-11-07   53  	add	%0, %0, #32			\n\
b99afae1390140 Nicolas Pitre 2018-11-07   54  	stmia	%0, {r2 - r7, ip, lr}		\n\
b99afae1390140 Nicolas Pitre 2018-11-07   55  	subs	%2, %2, #(32 * 8)		\n\
b99afae1390140 Nicolas Pitre 2018-11-07   56  	mcr	p15, 0, %0, c7, c14, 1		@ clean and invalidate D line\n\
b99afae1390140 Nicolas Pitre 2018-11-07   57  	add	%0, %0, #32			\n\
d73e60b7144a86 Russell King  2008-10-31   58  	bne	1b				\n\
b99afae1390140 Nicolas Pitre 2018-11-07   59  	mcr	p15, 0, %2, c7, c10, 4		@ drain WB"
b99afae1390140 Nicolas Pitre 2018-11-07   60  	: "+&r" (kto), "+&r" (kfrom), "=&r" (tmp)
b99afae1390140 Nicolas Pitre 2018-11-07   61  	: "2" (PAGE_SIZE)
b99afae1390140 Nicolas Pitre 2018-11-07   62  	: "r2", "r3", "r4", "r5", "r6", "r7", "ip", "lr");
d73e60b7144a86 Russell King  2008-10-31   63  }
d73e60b7144a86 Russell King  2008-10-31   64  
063b0a4207e43a Russell King  2008-10-31  @65  void feroceon_copy_user_highpage(struct page *to, struct page *from,
f00a75c094c340 Russell King  2009-10-05   66  	unsigned long vaddr, struct vm_area_struct *vma)
063b0a4207e43a Russell King  2008-10-31   67  {
063b0a4207e43a Russell King  2008-10-31   68  	void *kto, *kfrom;
063b0a4207e43a Russell King  2008-10-31   69  
5472e862de2bc4 Cong Wang     2011-11-25   70  	kto = kmap_atomic(to);
5472e862de2bc4 Cong Wang     2011-11-25   71  	kfrom = kmap_atomic(from);
2725898fc9bb21 Russell King  2009-10-05   72  	flush_cache_page(vma, vaddr, page_to_pfn(from));
063b0a4207e43a Russell King  2008-10-31   73  	feroceon_copy_user_page(kto, kfrom);
5472e862de2bc4 Cong Wang     2011-11-25   74  	kunmap_atomic(kfrom);
5472e862de2bc4 Cong Wang     2011-11-25   75  	kunmap_atomic(kto);
063b0a4207e43a Russell King  2008-10-31   76  }
063b0a4207e43a Russell King  2008-10-31   77  
303c6443659bc1 Russell King  2008-10-31  @78  void feroceon_clear_user_highpage(struct page *page, unsigned long vaddr)
d73e60b7144a86 Russell King  2008-10-31   79  {
5472e862de2bc4 Cong Wang     2011-11-25   80  	void *ptr, *kaddr = kmap_atomic(page);
43ae286b7d4d8c Nicolas Pitre 2008-11-04   81  	asm volatile ("\
43ae286b7d4d8c Nicolas Pitre 2008-11-04   82  	mov	r1, %2				\n\
d73e60b7144a86 Russell King  2008-10-31   83  	mov	r2, #0				\n\
d73e60b7144a86 Russell King  2008-10-31   84  	mov	r3, #0				\n\
d73e60b7144a86 Russell King  2008-10-31   85  	mov	r4, #0				\n\
d73e60b7144a86 Russell King  2008-10-31   86  	mov	r5, #0				\n\
d73e60b7144a86 Russell King  2008-10-31   87  	mov	r6, #0				\n\
d73e60b7144a86 Russell King  2008-10-31   88  	mov	r7, #0				\n\
d73e60b7144a86 Russell King  2008-10-31   89  	mov	ip, #0				\n\
d73e60b7144a86 Russell King  2008-10-31   90  	mov	lr, #0				\n\
303c6443659bc1 Russell King  2008-10-31   91  1:	stmia	%0, {r2-r7, ip, lr}		\n\
d73e60b7144a86 Russell King  2008-10-31   92  	subs	r1, r1, #1			\n\
303c6443659bc1 Russell King  2008-10-31   93  	mcr	p15, 0, %0, c7, c14, 1		@ clean and invalidate D line\n\
43ae286b7d4d8c Nicolas Pitre 2008-11-04   94  	add	%0, %0, #32			\n\
d73e60b7144a86 Russell King  2008-10-31   95  	bne	1b				\n\
303c6443659bc1 Russell King  2008-10-31   96  	mcr	p15, 0, r1, c7, c10, 4		@ drain WB"
43ae286b7d4d8c Nicolas Pitre 2008-11-04   97  	: "=r" (ptr)
43ae286b7d4d8c Nicolas Pitre 2008-11-04   98  	: "0" (kaddr), "I" (PAGE_SIZE / 32)
303c6443659bc1 Russell King  2008-10-31   99  	: "r1", "r2", "r3", "r4", "r5", "r6", "r7", "ip", "lr");
5472e862de2bc4 Cong Wang     2011-11-25  100  	kunmap_atomic(kaddr);
d73e60b7144a86 Russell King  2008-10-31  101  }
d73e60b7144a86 Russell King  2008-10-31  102  

:::::: The code at line 65 was first introduced by commit
:::::: 063b0a4207e43acbeff3d4b09f43e750e0212b48 [ARM] copypage: provide our own copy_user_highpage()

:::::: TO: Russell King <rmk@dyn-67.arm.linux.org.uk>
:::::: CC: Russell King <rmk+kernel@arm.linux.org.uk>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
