Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DFAC686D3D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 18:42:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbjBARmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 12:42:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbjBARmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 12:42:50 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A268B4EDB
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 09:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675273367; x=1706809367;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Fxzo7E5NsVX5rTNESd5c6ybs84PR2PXlE6rUs77dXDY=;
  b=ZbZzb3XmMFhAdF0AaKS5nC9EnUk2SeJ92JTQ1nRGeoicmw28AlbPthLj
   h/UmUlfVNTxSpsYXOfBAoHW2XwHC6P2uUyM3ycr74Dj38u6FqB9rLIF9l
   /X+z3UXV4uyHuNRtjhEKEwZglxEWP3gcckZSXD5tAzaJcGIZ/FT9OVmLb
   GC0qjVsBkcw0eCkSUisIbl/Ia8ZysIlymrtgEnGZg6O5XwRkAUELFoTNX
   mz1sS2Gfv6wKHUwh+VPHBRe2NnvPuKOF0U+WFryWpoAZOPd9VWfA5CLM1
   518Zv7Y38rrmQXT1sHi8gONaL997zC48HOsx1FsmPTBSFW805ajiuQeVU
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="355550452"
X-IronPort-AV: E=Sophos;i="5.97,265,1669104000"; 
   d="scan'208";a="355550452"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 09:42:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="695445439"
X-IronPort-AV: E=Sophos;i="5.97,265,1669104000"; 
   d="scan'208";a="695445439"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 01 Feb 2023 09:42:44 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pNH83-0005e2-0t;
        Wed, 01 Feb 2023 17:42:39 +0000
Date:   Thu, 2 Feb 2023 01:42:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: drivers/comedi/drivers/adl_pci9111.c:414:2: warning: performing
 pointer arithmetic on a null pointer has undefined behavior
Message-ID: <202302020103.JtDCLryg-lkp@intel.com>
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

Hi Maciej,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c0b67534c95c537f7a506a06b98e5e85d72e2b7d
commit: 9cc205e3c17d5716da7ebb7fa0c985555e95d009 RISC-V: Make port I/O string accessors actually work
date:   4 months ago
config: riscv-randconfig-r022-20230201 (https://download.01.org/0day-ci/archive/20230202/202302020103.JtDCLryg-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 4196ca3278f78c6e19246e54ab0ecb364e37d66a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9cc205e3c17d5716da7ebb7fa0c985555e95d009
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 9cc205e3c17d5716da7ebb7fa0c985555e95d009
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:743:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           insb(addr, buffer, count);
           ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/io.h:104:53: note: expanded from macro 'insb'
   #define insb(addr, buffer, count) __insb(PCI_IOBASE + (addr), buffer, count)
                                            ~~~~~~~~~~ ^
   In file included from drivers/comedi/drivers/adl_pci9111.c:44:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:751:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           insw(addr, buffer, count);
           ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/io.h:105:53: note: expanded from macro 'insw'
   #define insw(addr, buffer, count) __insw(PCI_IOBASE + (addr), buffer, count)
                                            ~~~~~~~~~~ ^
   In file included from drivers/comedi/drivers/adl_pci9111.c:44:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:759:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           insl(addr, buffer, count);
           ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/io.h:106:53: note: expanded from macro 'insl'
   #define insl(addr, buffer, count) __insl(PCI_IOBASE + (addr), buffer, count)
                                            ~~~~~~~~~~ ^
   In file included from drivers/comedi/drivers/adl_pci9111.c:44:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:768:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           outsb(addr, buffer, count);
           ^~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/io.h:118:55: note: expanded from macro 'outsb'
   #define outsb(addr, buffer, count) __outsb(PCI_IOBASE + (addr), buffer, count)
                                              ~~~~~~~~~~ ^
   In file included from drivers/comedi/drivers/adl_pci9111.c:44:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:777:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           outsw(addr, buffer, count);
           ^~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/io.h:119:55: note: expanded from macro 'outsw'
   #define outsw(addr, buffer, count) __outsw(PCI_IOBASE + (addr), buffer, count)
                                              ~~~~~~~~~~ ^
   In file included from drivers/comedi/drivers/adl_pci9111.c:44:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:786:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           outsl(addr, buffer, count);
           ^~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/io.h:120:55: note: expanded from macro 'outsl'
   #define outsl(addr, buffer, count) __outsl(PCI_IOBASE + (addr), buffer, count)
                                              ~~~~~~~~~~ ^
   In file included from drivers/comedi/drivers/adl_pci9111.c:44:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:1134:55: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           return (port > MMIO_UPPER_LIMIT) ? NULL : PCI_IOBASE + port;
                                                     ~~~~~~~~~~ ^
>> drivers/comedi/drivers/adl_pci9111.c:414:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           insw(dev->iobase + PCI9111_AI_FIFO_REG, buf, samples);
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/io.h:105:53: note: expanded from macro 'insw'
   #define insw(addr, buffer, count) __insw(PCI_IOBASE + (addr), buffer, count)
                                            ~~~~~~~~~~ ^
   14 warnings generated.
--
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:743:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           insb(addr, buffer, count);
           ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/io.h:104:53: note: expanded from macro 'insb'
   #define insb(addr, buffer, count) __insb(PCI_IOBASE + (addr), buffer, count)
                                            ~~~~~~~~~~ ^
   In file included from drivers/comedi/drivers/cb_pcidas.c:56:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:751:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           insw(addr, buffer, count);
           ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/io.h:105:53: note: expanded from macro 'insw'
   #define insw(addr, buffer, count) __insw(PCI_IOBASE + (addr), buffer, count)
                                            ~~~~~~~~~~ ^
   In file included from drivers/comedi/drivers/cb_pcidas.c:56:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:759:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           insl(addr, buffer, count);
           ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/io.h:106:53: note: expanded from macro 'insl'
   #define insl(addr, buffer, count) __insl(PCI_IOBASE + (addr), buffer, count)
                                            ~~~~~~~~~~ ^
   In file included from drivers/comedi/drivers/cb_pcidas.c:56:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:768:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           outsb(addr, buffer, count);
           ^~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/io.h:118:55: note: expanded from macro 'outsb'
   #define outsb(addr, buffer, count) __outsb(PCI_IOBASE + (addr), buffer, count)
                                              ~~~~~~~~~~ ^
   In file included from drivers/comedi/drivers/cb_pcidas.c:56:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:777:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           outsw(addr, buffer, count);
           ^~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/io.h:119:55: note: expanded from macro 'outsw'
   #define outsw(addr, buffer, count) __outsw(PCI_IOBASE + (addr), buffer, count)
                                              ~~~~~~~~~~ ^
   In file included from drivers/comedi/drivers/cb_pcidas.c:56:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:786:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           outsl(addr, buffer, count);
           ^~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/io.h:120:55: note: expanded from macro 'outsl'
   #define outsl(addr, buffer, count) __outsl(PCI_IOBASE + (addr), buffer, count)
                                              ~~~~~~~~~~ ^
   In file included from drivers/comedi/drivers/cb_pcidas.c:56:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:1134:55: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           return (port > MMIO_UPPER_LIMIT) ? NULL : PCI_IOBASE + port;
                                                     ~~~~~~~~~~ ^
>> drivers/comedi/drivers/cb_pcidas.c:991:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           outsw(devpriv->pcibar4 + PCIDAS_AO_FIFO_REG,
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/io.h:119:55: note: expanded from macro 'outsw'
   #define outsw(addr, buffer, count) __outsw(PCI_IOBASE + (addr), buffer, count)
                                              ~~~~~~~~~~ ^
   drivers/comedi/drivers/cb_pcidas.c:1153:3: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
                   insw(devpriv->pcibar2 + PCIDAS_AI_DATA_REG,
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/io.h:105:53: note: expanded from macro 'insw'
   #define insw(addr, buffer, count) __insw(PCI_IOBASE + (addr), buffer, count)
                                            ~~~~~~~~~~ ^
   15 warnings generated.


vim +414 drivers/comedi/drivers/adl_pci9111.c

8cb9b9fb975476 drivers/staging/comedi/drivers/adl_pci9111.c Emmanuel Pacaud   2009-02-12  404  
9a8805bb80cff9 drivers/staging/comedi/drivers/adl_pci9111.c H Hartley Sweeten 2014-05-27  405  static void pci9111_handle_fifo_half_full(struct comedi_device *dev,
9a8805bb80cff9 drivers/staging/comedi/drivers/adl_pci9111.c H Hartley Sweeten 2014-05-27  406  					  struct comedi_subdevice *s)
9a8805bb80cff9 drivers/staging/comedi/drivers/adl_pci9111.c H Hartley Sweeten 2014-05-27  407  {
9a8805bb80cff9 drivers/staging/comedi/drivers/adl_pci9111.c H Hartley Sweeten 2014-05-27  408  	struct pci9111_private_data *devpriv = dev->private;
9a8805bb80cff9 drivers/staging/comedi/drivers/adl_pci9111.c H Hartley Sweeten 2014-05-27  409  	struct comedi_cmd *cmd = &s->async->cmd;
64a4e72eabd419 drivers/staging/comedi/drivers/adl_pci9111.c H Hartley Sweeten 2015-10-12  410  	unsigned short *buf = devpriv->ai_bounce_buffer;
9a8805bb80cff9 drivers/staging/comedi/drivers/adl_pci9111.c H Hartley Sweeten 2014-05-27  411  	unsigned int samples;
9a8805bb80cff9 drivers/staging/comedi/drivers/adl_pci9111.c H Hartley Sweeten 2014-05-27  412  
b6bc224f33b2d2 drivers/staging/comedi/drivers/adl_pci9111.c H Hartley Sweeten 2014-11-10  413  	samples = comedi_nsamples_left(s, PCI9111_FIFO_HALF_SIZE);
64a4e72eabd419 drivers/staging/comedi/drivers/adl_pci9111.c H Hartley Sweeten 2015-10-12 @414  	insw(dev->iobase + PCI9111_AI_FIFO_REG, buf, samples);
9a8805bb80cff9 drivers/staging/comedi/drivers/adl_pci9111.c H Hartley Sweeten 2014-05-27  415  
9a8805bb80cff9 drivers/staging/comedi/drivers/adl_pci9111.c H Hartley Sweeten 2014-05-27  416  	if (devpriv->scan_delay < 1) {
64a4e72eabd419 drivers/staging/comedi/drivers/adl_pci9111.c H Hartley Sweeten 2015-10-12  417  		comedi_buf_write_samples(s, buf, samples);
9a8805bb80cff9 drivers/staging/comedi/drivers/adl_pci9111.c H Hartley Sweeten 2014-05-27  418  	} else {
9a8805bb80cff9 drivers/staging/comedi/drivers/adl_pci9111.c H Hartley Sweeten 2014-05-27  419  		unsigned int pos = 0;
9a8805bb80cff9 drivers/staging/comedi/drivers/adl_pci9111.c H Hartley Sweeten 2014-05-27  420  		unsigned int to_read;
9a8805bb80cff9 drivers/staging/comedi/drivers/adl_pci9111.c H Hartley Sweeten 2014-05-27  421  
9a8805bb80cff9 drivers/staging/comedi/drivers/adl_pci9111.c H Hartley Sweeten 2014-05-27  422  		while (pos < samples) {
9a8805bb80cff9 drivers/staging/comedi/drivers/adl_pci9111.c H Hartley Sweeten 2014-05-27  423  			if (devpriv->chunk_counter < cmd->chanlist_len) {
9a8805bb80cff9 drivers/staging/comedi/drivers/adl_pci9111.c H Hartley Sweeten 2014-05-27  424  				to_read = cmd->chanlist_len -
9a8805bb80cff9 drivers/staging/comedi/drivers/adl_pci9111.c H Hartley Sweeten 2014-05-27  425  					  devpriv->chunk_counter;
9a8805bb80cff9 drivers/staging/comedi/drivers/adl_pci9111.c H Hartley Sweeten 2014-05-27  426  
9a8805bb80cff9 drivers/staging/comedi/drivers/adl_pci9111.c H Hartley Sweeten 2014-05-27  427  				if (to_read > samples - pos)
9a8805bb80cff9 drivers/staging/comedi/drivers/adl_pci9111.c H Hartley Sweeten 2014-05-27  428  					to_read = samples - pos;
9a8805bb80cff9 drivers/staging/comedi/drivers/adl_pci9111.c H Hartley Sweeten 2014-05-27  429  
64a4e72eabd419 drivers/staging/comedi/drivers/adl_pci9111.c H Hartley Sweeten 2015-10-12  430  				comedi_buf_write_samples(s, buf + pos, to_read);
9a8805bb80cff9 drivers/staging/comedi/drivers/adl_pci9111.c H Hartley Sweeten 2014-05-27  431  			} else {
9a8805bb80cff9 drivers/staging/comedi/drivers/adl_pci9111.c H Hartley Sweeten 2014-05-27  432  				to_read = devpriv->chunk_num_samples -
9a8805bb80cff9 drivers/staging/comedi/drivers/adl_pci9111.c H Hartley Sweeten 2014-05-27  433  					  devpriv->chunk_counter;
9a8805bb80cff9 drivers/staging/comedi/drivers/adl_pci9111.c H Hartley Sweeten 2014-05-27  434  
9a8805bb80cff9 drivers/staging/comedi/drivers/adl_pci9111.c H Hartley Sweeten 2014-05-27  435  				if (to_read > samples - pos)
9a8805bb80cff9 drivers/staging/comedi/drivers/adl_pci9111.c H Hartley Sweeten 2014-05-27  436  					to_read = samples - pos;
9a8805bb80cff9 drivers/staging/comedi/drivers/adl_pci9111.c H Hartley Sweeten 2014-05-27  437  			}
9a8805bb80cff9 drivers/staging/comedi/drivers/adl_pci9111.c H Hartley Sweeten 2014-05-27  438  
9a8805bb80cff9 drivers/staging/comedi/drivers/adl_pci9111.c H Hartley Sweeten 2014-05-27  439  			pos += to_read;
9a8805bb80cff9 drivers/staging/comedi/drivers/adl_pci9111.c H Hartley Sweeten 2014-05-27  440  			devpriv->chunk_counter += to_read;
9a8805bb80cff9 drivers/staging/comedi/drivers/adl_pci9111.c H Hartley Sweeten 2014-05-27  441  
9a8805bb80cff9 drivers/staging/comedi/drivers/adl_pci9111.c H Hartley Sweeten 2014-05-27  442  			if (devpriv->chunk_counter >=
9a8805bb80cff9 drivers/staging/comedi/drivers/adl_pci9111.c H Hartley Sweeten 2014-05-27  443  			    devpriv->chunk_num_samples)
9a8805bb80cff9 drivers/staging/comedi/drivers/adl_pci9111.c H Hartley Sweeten 2014-05-27  444  				devpriv->chunk_counter = 0;
9a8805bb80cff9 drivers/staging/comedi/drivers/adl_pci9111.c H Hartley Sweeten 2014-05-27  445  		}
9a8805bb80cff9 drivers/staging/comedi/drivers/adl_pci9111.c H Hartley Sweeten 2014-05-27  446  	}
9a8805bb80cff9 drivers/staging/comedi/drivers/adl_pci9111.c H Hartley Sweeten 2014-05-27  447  }
9a8805bb80cff9 drivers/staging/comedi/drivers/adl_pci9111.c H Hartley Sweeten 2014-05-27  448  

:::::: The code at line 414 was first introduced by commit
:::::: 64a4e72eabd4199d6897f8b1366479b1b8152228 staging: comedi: adl_pci9111: fix alignment issue

:::::: TO: H Hartley Sweeten <hsweeten@visionengravers.com>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
