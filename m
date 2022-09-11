Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 328B65B50D1
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 21:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiIKTSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 15:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiIKTSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 15:18:07 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 943EBE082
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 12:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662923886; x=1694459886;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xQ6aw17yTEVxopys8Zx6lpGx1KD6LXlJcgFWJMO8HO0=;
  b=iKgxCnKh7HzzVRrGRZ3FeNOsHbxr21rrxglf4qf3M2vH18vd5SjXglQS
   xCShk6zVHpKP1ouMYl0ZKxpNe1TRB159/MwrdTIjHwDpbgsPoPQl+25Qt
   b3d+4z719ScnqZ3tfJ3z6M/KauyTRTDR4vZ+X9CFM2QkvArTlNrrCYgO5
   1zHCRrkwjw6poD6vZR6dXCPP0utNXd8k775+p6K28lkEsGjEo9xRJhTBS
   qvqA/dW/3GqSrDU22kqa63+l5SzBIekPeACCxURahY+s9LWbXHkNIcvaN
   q82OGPQaikXcUXmXnfSW5kKVE5n78eGiUTIV/MHbQirN9dII/bHSW6s4n
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10467"; a="296482568"
X-IronPort-AV: E=Sophos;i="5.93,307,1654585200"; 
   d="scan'208";a="296482568"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2022 12:18:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,307,1654585200"; 
   d="scan'208";a="593243053"
Received: from lkp-server02.sh.intel.com (HELO 4011df4f4fd3) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 11 Sep 2022 12:18:04 -0700
Received: from kbuild by 4011df4f4fd3 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oXSSy-0001iF-0p;
        Sun, 11 Sep 2022 19:18:04 +0000
Date:   Mon, 12 Sep 2022 03:17:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [arm-integrator:kernel-in-vmalloc-v6.0-rc1 22/30]
 include/linux/scatterlist.h:163: undefined reference to `virt_to_pfn'
Message-ID: <202209120346.sFuVQArY-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git kernel-in-vmalloc-v6.0-rc1
head:   5edde9c71a668fbd7f3c3990fde5b6b4a00dfc9b
commit: f87ff66fb349ec7d2840f4ebc552bfa0018cabb4 [22/30] riscv: Make virt_to_pfn() a real function
config: riscv-randconfig-c023-20220911 (https://download.01.org/0day-ci/archive/20220912/202209120346.sFuVQArY-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git/commit/?id=f87ff66fb349ec7d2840f4ebc552bfa0018cabb4
        git remote add arm-integrator https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
        git fetch --no-tags arm-integrator kernel-in-vmalloc-v6.0-rc1
        git checkout f87ff66fb349ec7d2840f4ebc552bfa0018cabb4
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   init/main.o: in function `.L0 ':
   include/trace/events/initcall.h:10:(.text+0x24): relocation truncated to fit: R_RISCV_HI20 against `.LANCHOR0'
   init/main.o: in function `.L0 ':
   init/main.c:187:(.init.text+0x24): relocation truncated to fit: R_RISCV_HI20 against symbol `reset_devices' defined in .sbss section in init/main.o
   init/main.o: in function `.L0 ':
   arch/riscv/include/asm/atomic.h:30:(.text.unlikely+0x10): relocation truncated to fit: R_RISCV_HI20 against `.LANCHOR0'
   init/main.o: in function `.L0 ':
   init/main.c:686:(.ref.text+0x28): relocation truncated to fit: R_RISCV_HI20 against `kernel_init'
   init/version.o: in function `.L0 ':
   include/linux/fortify-string.h:160:(.init.text+0x4c): relocation truncated to fit: R_RISCV_HI20 against `.LANCHOR0'
   init/do_mounts.o: in function `.L0 ':
   init/do_mounts.c:278:(.text+0x60): relocation truncated to fit: R_RISCV_HI20 against `.LC8'
   init/do_mounts.c:308:(.init.text+0xd8): relocation truncated to fit: R_RISCV_HI20 against `root_wait'
   init/do_mounts.o: in function `.L0 ':
   include/linux/mm.h:723:(.text.unlikely+0x2c): relocation truncated to fit: R_RISCV_HI20 against `.LC1'
   init/do_mounts_initrd.o: in function `.L0 ':
   init/do_mounts_initrd.c:45:(.init.text+0x24): relocation truncated to fit: R_RISCV_HI20 against `.LANCHOR0'
   init/initramfs.o: in function `.L0 ':
   init/initramfs.c:738:(.text+0x18): relocation truncated to fit: R_RISCV_HI20 against `initramfs_cookie'
   init/initramfs.c:58:(.init.text+0x24): additional relocation overflows omitted from the output
   riscv64-linux-ld: crypto/rsa-pkcs1pad.o: in function `.L0 ':
>> include/linux/scatterlist.h:163: undefined reference to `virt_to_pfn'
>> riscv64-linux-ld: include/linux/scatterlist.h:163: undefined reference to `virt_to_pfn'
   riscv64-linux-ld: lib/scatterlist.o: in function `.L0 ':
>> lib/scatterlist.c:140: undefined reference to `virt_to_pfn'
   riscv64-linux-ld: lib/scatterlist.o: in function `.L0 ':
>> include/linux/scatterlist.h:163: undefined reference to `virt_to_pfn'
   riscv64-linux-ld: drivers/i2c/busses/i2c-qup.o: in function `.L0 ':
>> include/linux/scatterlist.h:163: undefined reference to `virt_to_pfn'
   riscv64-linux-ld: drivers/i2c/busses/i2c-qup.o:include/linux/scatterlist.h:163: more undefined references to `virt_to_pfn' follow

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for DRM_TTM
   Depends on [n]: HAS_IOMEM [=y] && DRM [=y] && MMU [=n]
   Selected by [y]:
   - DRM_TTM_HELPER [=y] && HAS_IOMEM [=y] && DRM [=y]
   - DRM_HISI_HIBMC [=y] && HAS_IOMEM [=y] && DRM [=y] && PCI [=y] && (ARM64 || COMPILE_TEST [=y])


vim +163 include/linux/scatterlist.h

82f66fbef58de4 Jens Axboe    2007-10-22  151  
18dabf473e1585 Jens Axboe    2007-10-22  152  /**
18dabf473e1585 Jens Axboe    2007-10-22  153   * sg_set_buf - Set sg entry to point at given data
18dabf473e1585 Jens Axboe    2007-10-22  154   * @sg:		 SG entry
18dabf473e1585 Jens Axboe    2007-10-22  155   * @buf:	 Data
18dabf473e1585 Jens Axboe    2007-10-22  156   * @buflen:	 Data length
18dabf473e1585 Jens Axboe    2007-10-22  157   *
18dabf473e1585 Jens Axboe    2007-10-22  158   **/
82f66fbef58de4 Jens Axboe    2007-10-22  159  static inline void sg_set_buf(struct scatterlist *sg, const void *buf,
d32311fed70d12 Herbert Xu    2005-09-17  160  			      unsigned int buflen)
d32311fed70d12 Herbert Xu    2005-09-17  161  {
ac4e97abce9b80 Rusty Russell 2013-05-30  162  #ifdef CONFIG_DEBUG_SG
ac4e97abce9b80 Rusty Russell 2013-05-30 @163  	BUG_ON(!virt_addr_valid(buf));
ac4e97abce9b80 Rusty Russell 2013-05-30  164  #endif
642f149031d704 Jens Axboe    2007-10-24  165  	sg_set_page(sg, virt_to_page(buf), buflen, offset_in_page(buf));
d32311fed70d12 Herbert Xu    2005-09-17  166  }
d32311fed70d12 Herbert Xu    2005-09-17  167  

:::::: The code at line 163 was first introduced by commit
:::::: ac4e97abce9b80c020e7113325f49e58b7b15e3f scatterlist: sg_set_buf() argument must be in linear mapping

:::::: TO: Rusty Russell <rusty@rustcorp.com.au>
:::::: CC: Jens Axboe <axboe@kernel.dk>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
