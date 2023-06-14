Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0412725B8A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 12:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238831AbjFGKYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 06:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233837AbjFGKYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 06:24:39 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E7B71BD6
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 03:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686133476; x=1717669476;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=SuLoIPtXDcztVQAE9Lu/jKbZrBAvhda88a/mJ4rxW20=;
  b=KwVMCjdPIWEWrpzWrTLHZepak2wx/kMIwcdYsti+5sdh16J/oAD00N14
   m3b/0HOu5YYj8M11INOgJpE6aIKHHELnH0HoZtVrtbDIUwJHujwmgZThD
   brVWY02CGu7IS789LFW5DIEHjH+3jyzhhxAxhgw6GS7nFhdWXWVXEIX4i
   gjPClJDk44Jg8PT+Cpg18jm3KSkmD1kBtAFbQA1eDVB110bSm5p5mczJ7
   cae3m5TYaVFACBwk6xgPWnm1s12PC29ra0veFbSUJMsNbGNJPDEaqJ8VO
   h4Gs7WGcb3CCRtzPeOqD0jqnH6wE3iMCUgJkqLOE4Dec6PdaOHB2z5I7m
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="355801791"
X-IronPort-AV: E=Sophos;i="6.00,223,1681196400"; 
   d="scan'208";a="355801791"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2023 03:23:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="883687035"
X-IronPort-AV: E=Sophos;i="6.00,223,1681196400"; 
   d="scan'208";a="883687035"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 07 Jun 2023 03:23:56 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q6qKa-0006TH-0I;
        Wed, 07 Jun 2023 10:23:56 +0000
Date:   Wed, 7 Jun 2023 18:23:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: arch/alpha/include/asm/jensen.h:187:21: warning: no previous
 prototype for 'jensen_inq'
Message-ID: <202306071827.lP7b7QJa-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a4d7d701121981e3c3fe69ade376fe9f26324161
commit: e19d4ebc536dadb607fe305fdaf48218d3e32d7c alpha: add full ioread64/iowrite64 implementation
date:   8 months ago
config: alpha-alldefconfig (https://download.01.org/0day-ci/archive/20230607/202306071827.lP7b7QJa-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 12.3.0
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e19d4ebc536dadb607fe305fdaf48218d3e32d7c
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout e19d4ebc536dadb607fe305fdaf48218d3e32d7c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=alpha olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=alpha SHELL=/bin/bash arch/alpha/kernel/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306071827.lP7b7QJa-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from arch/alpha/kernel/sys_jensen.c:12:
   arch/alpha/include/asm/jensen.h:92:22: warning: no previous prototype for 'jensen_set_hae' [-Wmissing-prototypes]
      92 | __EXTERN_INLINE void jensen_set_hae(unsigned long addr)
         |                      ^~~~~~~~~~~~~~
   arch/alpha/include/asm/jensen.h:115:30: warning: no previous prototype for 'jensen_local_inb' [-Wmissing-prototypes]
     115 | __EXTERN_INLINE unsigned int jensen_local_inb(unsigned long addr)
         |                              ^~~~~~~~~~~~~~~~
   arch/alpha/include/asm/jensen.h:120:22: warning: no previous prototype for 'jensen_local_outb' [-Wmissing-prototypes]
     120 | __EXTERN_INLINE void jensen_local_outb(u8 b, unsigned long addr)
         |                      ^~~~~~~~~~~~~~~~~
   arch/alpha/include/asm/jensen.h:126:30: warning: no previous prototype for 'jensen_bus_inb' [-Wmissing-prototypes]
     126 | __EXTERN_INLINE unsigned int jensen_bus_inb(unsigned long addr)
         |                              ^~~~~~~~~~~~~~
   arch/alpha/include/asm/jensen.h:135:22: warning: no previous prototype for 'jensen_bus_outb' [-Wmissing-prototypes]
     135 | __EXTERN_INLINE void jensen_bus_outb(u8 b, unsigned long addr)
         |                      ^~~~~~~~~~~~~~~
   arch/alpha/include/asm/jensen.h:155:20: warning: no previous prototype for 'jensen_inb' [-Wmissing-prototypes]
     155 | __EXTERN_INLINE u8 jensen_inb(unsigned long addr)
         |                    ^~~~~~~~~~
   arch/alpha/include/asm/jensen.h:163:22: warning: no previous prototype for 'jensen_outb' [-Wmissing-prototypes]
     163 | __EXTERN_INLINE void jensen_outb(u8 b, unsigned long addr)
         |                      ^~~~~~~~~~~
   arch/alpha/include/asm/jensen.h:171:21: warning: no previous prototype for 'jensen_inw' [-Wmissing-prototypes]
     171 | __EXTERN_INLINE u16 jensen_inw(unsigned long addr)
         |                     ^~~~~~~~~~
   arch/alpha/include/asm/jensen.h:181:21: warning: no previous prototype for 'jensen_inl' [-Wmissing-prototypes]
     181 | __EXTERN_INLINE u32 jensen_inl(unsigned long addr)
         |                     ^~~~~~~~~~
>> arch/alpha/include/asm/jensen.h:187:21: warning: no previous prototype for 'jensen_inq' [-Wmissing-prototypes]
     187 | __EXTERN_INLINE u64 jensen_inq(unsigned long addr)
         |                     ^~~~~~~~~~
   arch/alpha/include/asm/jensen.h:193:22: warning: no previous prototype for 'jensen_outw' [-Wmissing-prototypes]
     193 | __EXTERN_INLINE void jensen_outw(u16 b, unsigned long addr)
         |                      ^~~~~~~~~~~
   arch/alpha/include/asm/jensen.h:200:22: warning: no previous prototype for 'jensen_outl' [-Wmissing-prototypes]
     200 | __EXTERN_INLINE void jensen_outl(u32 b, unsigned long addr)
         |                      ^~~~~~~~~~~
>> arch/alpha/include/asm/jensen.h:207:22: warning: no previous prototype for 'jensen_outq' [-Wmissing-prototypes]
     207 | __EXTERN_INLINE void jensen_outq(u64 b, unsigned long addr)
         |                      ^~~~~~~~~~~
   arch/alpha/include/asm/jensen.h:218:20: warning: no previous prototype for 'jensen_readb' [-Wmissing-prototypes]
     218 | __EXTERN_INLINE u8 jensen_readb(const volatile void __iomem *xaddr)
         |                    ^~~~~~~~~~~~
   arch/alpha/include/asm/jensen.h:230:21: warning: no previous prototype for 'jensen_readw' [-Wmissing-prototypes]
     230 | __EXTERN_INLINE u16 jensen_readw(const volatile void __iomem *xaddr)
         |                     ^~~~~~~~~~~~
   arch/alpha/include/asm/jensen.h:242:21: warning: no previous prototype for 'jensen_readl' [-Wmissing-prototypes]
     242 | __EXTERN_INLINE u32 jensen_readl(const volatile void __iomem *xaddr)
         |                     ^~~~~~~~~~~~
   arch/alpha/include/asm/jensen.h:250:21: warning: no previous prototype for 'jensen_readq' [-Wmissing-prototypes]
     250 | __EXTERN_INLINE u64 jensen_readq(const volatile void __iomem *xaddr)
         |                     ^~~~~~~~~~~~
   arch/alpha/include/asm/jensen.h:263:22: warning: no previous prototype for 'jensen_writeb' [-Wmissing-prototypes]
     263 | __EXTERN_INLINE void jensen_writeb(u8 b, volatile void __iomem *xaddr)
         |                      ^~~~~~~~~~~~~
   arch/alpha/include/asm/jensen.h:271:22: warning: no previous prototype for 'jensen_writew' [-Wmissing-prototypes]
     271 | __EXTERN_INLINE void jensen_writew(u16 b, volatile void __iomem *xaddr)
         |                      ^~~~~~~~~~~~~
   arch/alpha/include/asm/jensen.h:279:22: warning: no previous prototype for 'jensen_writel' [-Wmissing-prototypes]
     279 | __EXTERN_INLINE void jensen_writel(u32 b, volatile void __iomem *xaddr)
         |                      ^~~~~~~~~~~~~
   arch/alpha/include/asm/jensen.h:287:22: warning: no previous prototype for 'jensen_writeq' [-Wmissing-prototypes]
     287 | __EXTERN_INLINE void jensen_writeq(u64 b, volatile void __iomem *xaddr)
         |                      ^~~~~~~~~~~~~
   arch/alpha/include/asm/jensen.h:297:31: warning: no previous prototype for 'jensen_ioportmap' [-Wmissing-prototypes]
     297 | __EXTERN_INLINE void __iomem *jensen_ioportmap(unsigned long addr)
         |                               ^~~~~~~~~~~~~~~~
   arch/alpha/include/asm/jensen.h:302:31: warning: no previous prototype for 'jensen_ioremap' [-Wmissing-prototypes]
     302 | __EXTERN_INLINE void __iomem *jensen_ioremap(unsigned long addr,
         |                               ^~~~~~~~~~~~~~
   arch/alpha/include/asm/jensen.h:308:21: warning: no previous prototype for 'jensen_is_ioaddr' [-Wmissing-prototypes]
     308 | __EXTERN_INLINE int jensen_is_ioaddr(unsigned long addr)
         |                     ^~~~~~~~~~~~~~~~
   arch/alpha/include/asm/jensen.h:313:21: warning: no previous prototype for 'jensen_is_mmio' [-Wmissing-prototypes]
     313 | __EXTERN_INLINE int jensen_is_mmio(const volatile void __iomem *addr)
         |                     ^~~~~~~~~~~~~~
   arch/alpha/include/asm/jensen.h:322:23: warning: no previous prototype for 'jensen_ioread8' [-Wmissing-prototypes]
     322 | __EXTERN_INLINE u##NS jensen_ioread##NS(const void __iomem *xaddr)      \
         |                       ^~~~~~~~~~~~~
   arch/alpha/include/asm/jensen.h:337:1: note: in expansion of macro 'IOPORT'
     337 | IOPORT(b, 8)
         | ^~~~~~
   arch/alpha/include/asm/jensen.h:329:22: warning: no previous prototype for 'jensen_iowrite8' [-Wmissing-prototypes]
     329 | __EXTERN_INLINE void jensen_iowrite##NS(u##NS b, void __iomem *xaddr)   \
         |                      ^~~~~~~~~~~~~~
   arch/alpha/include/asm/jensen.h:337:1: note: in expansion of macro 'IOPORT'
     337 | IOPORT(b, 8)
         | ^~~~~~
   arch/alpha/include/asm/jensen.h:322:23: warning: no previous prototype for 'jensen_ioread16' [-Wmissing-prototypes]
     322 | __EXTERN_INLINE u##NS jensen_ioread##NS(const void __iomem *xaddr)      \
         |                       ^~~~~~~~~~~~~
   arch/alpha/include/asm/jensen.h:338:1: note: in expansion of macro 'IOPORT'
     338 | IOPORT(w, 16)
         | ^~~~~~
   arch/alpha/include/asm/jensen.h:329:22: warning: no previous prototype for 'jensen_iowrite16' [-Wmissing-prototypes]
     329 | __EXTERN_INLINE void jensen_iowrite##NS(u##NS b, void __iomem *xaddr)   \
         |                      ^~~~~~~~~~~~~~
   arch/alpha/include/asm/jensen.h:338:1: note: in expansion of macro 'IOPORT'
     338 | IOPORT(w, 16)
         | ^~~~~~
   arch/alpha/include/asm/jensen.h:322:23: warning: no previous prototype for 'jensen_ioread32' [-Wmissing-prototypes]
     322 | __EXTERN_INLINE u##NS jensen_ioread##NS(const void __iomem *xaddr)      \
         |                       ^~~~~~~~~~~~~
   arch/alpha/include/asm/jensen.h:339:1: note: in expansion of macro 'IOPORT'
     339 | IOPORT(l, 32)
         | ^~~~~~
   arch/alpha/include/asm/jensen.h:329:22: warning: no previous prototype for 'jensen_iowrite32' [-Wmissing-prototypes]
     329 | __EXTERN_INLINE void jensen_iowrite##NS(u##NS b, void __iomem *xaddr)   \
         |                      ^~~~~~~~~~~~~~
   arch/alpha/include/asm/jensen.h:339:1: note: in expansion of macro 'IOPORT'
     339 | IOPORT(l, 32)
         | ^~~~~~
>> arch/alpha/include/asm/jensen.h:322:23: warning: no previous prototype for 'jensen_ioread64' [-Wmissing-prototypes]
     322 | __EXTERN_INLINE u##NS jensen_ioread##NS(const void __iomem *xaddr)      \
         |                       ^~~~~~~~~~~~~
   arch/alpha/include/asm/jensen.h:340:1: note: in expansion of macro 'IOPORT'
     340 | IOPORT(q, 64)
         | ^~~~~~
>> arch/alpha/include/asm/jensen.h:329:22: warning: no previous prototype for 'jensen_iowrite64' [-Wmissing-prototypes]
     329 | __EXTERN_INLINE void jensen_iowrite##NS(u##NS b, void __iomem *xaddr)   \
         |                      ^~~~~~~~~~~~~~
   arch/alpha/include/asm/jensen.h:340:1: note: in expansion of macro 'IOPORT'
     340 | IOPORT(q, 64)
         | ^~~~~~
   In file included from arch/alpha/kernel/sys_jensen.c:11:
   arch/alpha/include/asm/jensen.h:348:33: warning: no previous prototype for 'jensen_iounmap' [-Wmissing-prototypes]
     348 | #define __IO_PREFIX             jensen
         |                                 ^~~~~~
   arch/alpha/include/asm/io.h:137:25: note: in definition of macro '_IO_CONCAT'
     137 | #define _IO_CONCAT(a,b) a ## _ ## b
         |                         ^
   arch/alpha/include/asm/io_trivial.h:141:22: note: in expansion of macro 'IO_CONCAT'
     141 | __EXTERN_INLINE void IO_CONCAT(__IO_PREFIX,iounmap)(volatile void __iomem *a)
         |                      ^~~~~~~~~
   arch/alpha/include/asm/io_trivial.h:141:32: note: in expansion of macro '__IO_PREFIX'
     141 | __EXTERN_INLINE void IO_CONCAT(__IO_PREFIX,iounmap)(volatile void __iomem *a)
         |                                ^~~~~~~~~~~


vim +/jensen_inq +187 arch/alpha/include/asm/jensen.h

   162	
 > 163	__EXTERN_INLINE void jensen_outb(u8 b, unsigned long addr)
   164	{
   165		if (jensen_is_local(addr))
   166			jensen_local_outb(b, addr);
   167		else
   168			jensen_bus_outb(b, addr);
   169	}
   170	
   171	__EXTERN_INLINE u16 jensen_inw(unsigned long addr)
   172	{
   173		long result;
   174	
   175		jensen_set_hae(0);
   176		result = *(volatile int *) ((addr << 7) + EISA_IO + 0x20);
   177		result >>= (addr & 3) * 8;
   178		return 0xffffUL & result;
   179	}
   180	
   181	__EXTERN_INLINE u32 jensen_inl(unsigned long addr)
   182	{
   183		jensen_set_hae(0);
   184		return *(vuip) ((addr << 7) + EISA_IO + 0x60);
   185	}
   186	
 > 187	__EXTERN_INLINE u64 jensen_inq(unsigned long addr)
   188	{
   189		jensen_set_hae(0);
   190		return *(vulp) ((addr << 7) + EISA_IO + 0x60);
   191	}
   192	
   193	__EXTERN_INLINE void jensen_outw(u16 b, unsigned long addr)
   194	{
   195		jensen_set_hae(0);
   196		*(vuip) ((addr << 7) + EISA_IO + 0x20) = b * 0x00010001;
   197		mb();
   198	}
   199	
   200	__EXTERN_INLINE void jensen_outl(u32 b, unsigned long addr)
   201	{
   202		jensen_set_hae(0);
   203		*(vuip) ((addr << 7) + EISA_IO + 0x60) = b;
   204		mb();
   205	}
   206	
 > 207	__EXTERN_INLINE void jensen_outq(u64 b, unsigned long addr)
   208	{
   209		jensen_set_hae(0);
   210		*(vulp) ((addr << 7) + EISA_IO + 0x60) = b;
   211		mb();
   212	}
   213	
   214	/*
   215	 * Memory functions.
   216	 */
   217	
   218	__EXTERN_INLINE u8 jensen_readb(const volatile void __iomem *xaddr)
   219	{
   220		unsigned long addr = (unsigned long) xaddr;
   221		long result;
   222	
   223		jensen_set_hae(addr);
   224		addr &= JENSEN_HAE_MASK;
   225		result = *(volatile int *) ((addr << 7) + EISA_MEM + 0x00);
   226		result >>= (addr & 3) * 8;
   227		return 0xffUL & result;
   228	}
   229	
   230	__EXTERN_INLINE u16 jensen_readw(const volatile void __iomem *xaddr)
   231	{
   232		unsigned long addr = (unsigned long) xaddr;
   233		long result;
   234	
   235		jensen_set_hae(addr);
   236		addr &= JENSEN_HAE_MASK;
   237		result = *(volatile int *) ((addr << 7) + EISA_MEM + 0x20);
   238		result >>= (addr & 3) * 8;
   239		return 0xffffUL & result;
   240	}
   241	
   242	__EXTERN_INLINE u32 jensen_readl(const volatile void __iomem *xaddr)
   243	{
   244		unsigned long addr = (unsigned long) xaddr;
   245		jensen_set_hae(addr);
   246		addr &= JENSEN_HAE_MASK;
   247		return *(vuip) ((addr << 7) + EISA_MEM + 0x60);
   248	}
   249	
   250	__EXTERN_INLINE u64 jensen_readq(const volatile void __iomem *xaddr)
   251	{
   252		unsigned long addr = (unsigned long) xaddr;
   253		unsigned long r0, r1;
   254	
   255		jensen_set_hae(addr);
   256		addr &= JENSEN_HAE_MASK;
   257		addr = (addr << 7) + EISA_MEM + 0x60;
   258		r0 = *(vuip) (addr);
   259		r1 = *(vuip) (addr + (4 << 7));
   260		return r1 << 32 | r0;
   261	}
   262	
   263	__EXTERN_INLINE void jensen_writeb(u8 b, volatile void __iomem *xaddr)
   264	{
   265		unsigned long addr = (unsigned long) xaddr;
   266		jensen_set_hae(addr);
   267		addr &= JENSEN_HAE_MASK;
   268		*(vuip) ((addr << 7) + EISA_MEM + 0x00) = b * 0x01010101;
   269	}
   270	
   271	__EXTERN_INLINE void jensen_writew(u16 b, volatile void __iomem *xaddr)
   272	{
   273		unsigned long addr = (unsigned long) xaddr;
   274		jensen_set_hae(addr);
   275		addr &= JENSEN_HAE_MASK;
   276		*(vuip) ((addr << 7) + EISA_MEM + 0x20) = b * 0x00010001;
   277	}
   278	
   279	__EXTERN_INLINE void jensen_writel(u32 b, volatile void __iomem *xaddr)
   280	{
   281		unsigned long addr = (unsigned long) xaddr;
   282		jensen_set_hae(addr);
   283		addr &= JENSEN_HAE_MASK;
   284		*(vuip) ((addr << 7) + EISA_MEM + 0x60) = b;
   285	}
   286	
   287	__EXTERN_INLINE void jensen_writeq(u64 b, volatile void __iomem *xaddr)
   288	{
   289		unsigned long addr = (unsigned long) xaddr;
   290		jensen_set_hae(addr);
   291		addr &= JENSEN_HAE_MASK;
   292		addr = (addr << 7) + EISA_MEM + 0x60;
   293		*(vuip) (addr) = b;
   294		*(vuip) (addr + (4 << 7)) = b >> 32;
   295	}
   296	
   297	__EXTERN_INLINE void __iomem *jensen_ioportmap(unsigned long addr)
   298	{
   299		return (void __iomem *)addr;
   300	}
   301	
   302	__EXTERN_INLINE void __iomem *jensen_ioremap(unsigned long addr,
   303						     unsigned long size)
   304	{
   305		return (void __iomem *)(addr + 0x100000000ul);
   306	}
   307	
   308	__EXTERN_INLINE int jensen_is_ioaddr(unsigned long addr)
   309	{
   310		return (long)addr >= 0;
   311	}
   312	
   313	__EXTERN_INLINE int jensen_is_mmio(const volatile void __iomem *addr)
   314	{
   315		return (unsigned long)addr >= 0x100000000ul;
   316	}
   317	
   318	/* New-style ioread interface.  All the routines are so ugly for Jensen
   319	   that it doesn't make sense to merge them.  */
   320	
   321	#define IOPORT(OS, NS)							\
 > 322	__EXTERN_INLINE u##NS jensen_ioread##NS(const void __iomem *xaddr)	\
   323	{									\
   324		if (jensen_is_mmio(xaddr))					\
   325			return jensen_read##OS(xaddr - 0x100000000ul);		\
   326		else								\
   327			return jensen_in##OS((unsigned long)xaddr);		\
   328	}									\
 > 329	__EXTERN_INLINE void jensen_iowrite##NS(u##NS b, void __iomem *xaddr)	\
   330	{									\
   331		if (jensen_is_mmio(xaddr))					\
   332			jensen_write##OS(b, xaddr - 0x100000000ul);		\
   333		else								\
   334			jensen_out##OS(b, (unsigned long)xaddr);		\
   335	}
   336	
   337	IOPORT(b, 8)
   338	IOPORT(w, 16)
 > 339	IOPORT(l, 32)
   340	IOPORT(q, 64)
   341	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
