Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63FDF72AB3C
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 13:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234473AbjFJLpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 07:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjFJLpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 07:45:36 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B00B1988
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 04:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686397535; x=1717933535;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=apyVGZglbhvHSI5NBgNcgQZasgi8FVe+iEk2aeRA8zM=;
  b=Gl2SpMv86H7fux17/CdqTlJiNrGlLgRs6ORlJ5EV/RJHpdHTqjlqPdPl
   Q+UyHDmmJcTr84TzWDMsXVKK0mRjiidKKzGaVTdrzAr+RdHeB0nFcaaSb
   Lr3uU9MODqtZ0i8e2F/nwula8WW785zF3SyVdkkN0c/1l3bb0q9Ma903d
   pvY2ydNnrNsTzFevOjvynQdDEr6GZkep3C5pYUY9QltAZNG4XiJoO5xRz
   PaeUDnK9axfKne3EOzl4SsutuD+evW+O/JMZPEU/6Om+kuAZOEWr1MASX
   z5nvBw6/V0byeud9Ob4yU9+3BosPZ6G5uokILv/dqWY7ijgg2cYIPCGEv
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="338117205"
X-IronPort-AV: E=Sophos;i="6.00,232,1681196400"; 
   d="scan'208";a="338117205"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2023 04:45:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="800492369"
X-IronPort-AV: E=Sophos;i="6.00,232,1681196400"; 
   d="scan'208";a="800492369"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Jun 2023 04:45:33 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q7x2D-000A3k-0P;
        Sat, 10 Jun 2023 11:45:33 +0000
Date:   Sat, 10 Jun 2023 19:44:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Li Zhengyu <lizhengyu3@huawei.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: arch/riscv/kernel/elf_kexec.c:185:23: warning: variable
 'kernel_start' set but not used
Message-ID: <202306101945.6IFhByu9-lkp@intel.com>
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

Hi Li,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   64569520920a3ca5d456ddd9f4f95fc6ea9b8b45
commit: 838b3e28488f702e2b5477b393f009b2639d2b1a RISC-V: Load purgatory in kexec_file
date:   1 year, 1 month ago
config: riscv-randconfig-r026-20230610 (https://download.01.org/0day-ci/archive/20230610/202306101945.6IFhByu9-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 12.3.0
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=838b3e28488f702e2b5477b393f009b2639d2b1a
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 838b3e28488f702e2b5477b393f009b2639d2b1a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=riscv olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/kernel/

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306101945.6IFhByu9-lkp@intel.com/

All warnings (new ones prefixed by >>):

   arch/riscv/kernel/elf_kexec.c: In function 'elf_kexec_load':
>> arch/riscv/kernel/elf_kexec.c:185:23: warning: variable 'kernel_start' set but not used [-Wunused-but-set-variable]
     185 |         unsigned long kernel_start;
         |                       ^~~~~~~~~~~~
   arch/riscv/kernel/elf_kexec.c: In function 'arch_kexec_apply_relocations_add':
   arch/riscv/kernel/elf_kexec.c:352:9: error: unknown type name 'Elf_Rela'; did you mean 'Elf64_Rela'?
     352 |         Elf_Rela *relas;
         |         ^~~~~~~~
         |         Elf64_Rela
   In file included from include/linux/elf.h:7,
                    from arch/riscv/kernel/elf_kexec.c:15:
   arch/riscv/kernel/elf_kexec.c:370:44: error: request for member 'r_info' in something not a structure or union
     370 |                 sym += ELF64_R_SYM(relas[i].r_info);
         |                                            ^
   include/uapi/linux/elf.h:163:43: note: in definition of macro 'ELF64_R_SYM'
     163 | #define ELF64_R_SYM(i)                  ((i) >> 32)
         |                                           ^
   arch/riscv/kernel/elf_kexec.c:379:32: error: request for member 'r_offset' in something not a structure or union
     379 |                 loc += relas[i].r_offset;
         |                                ^
   arch/riscv/kernel/elf_kexec.c:392:32: error: request for member 'r_addend' in something not a structure or union
     392 |                 val += relas[i].r_addend;
         |                                ^
   arch/riscv/kernel/elf_kexec.c:394:51: error: request for member 'r_offset' in something not a structure or union
     394 |                 addr = section->sh_addr + relas[i].r_offset;
         |                                                   ^
   arch/riscv/kernel/elf_kexec.c:396:47: error: request for member 'r_info' in something not a structure or union
     396 |                 r_type = ELF64_R_TYPE(relas[i].r_info);
         |                                               ^
   include/uapi/linux/elf.h:164:43: note: in definition of macro 'ELF64_R_TYPE'
     164 | #define ELF64_R_TYPE(i)                 ((i) & 0xffffffff)
         |                                           ^


vim +/kernel_start +185 arch/riscv/kernel/elf_kexec.c

   174	
   175	static void *elf_kexec_load(struct kimage *image, char *kernel_buf,
   176				    unsigned long kernel_len, char *initrd,
   177				    unsigned long initrd_len, char *cmdline,
   178				    unsigned long cmdline_len)
   179	{
   180		int ret;
   181		unsigned long old_kernel_pbase = ULONG_MAX;
   182		unsigned long new_kernel_pbase = 0UL;
   183		unsigned long initrd_pbase = 0UL;
   184		unsigned long headers_sz;
 > 185		unsigned long kernel_start;
   186		void *fdt, *headers;
   187		struct elfhdr ehdr;
   188		struct kexec_buf kbuf;
   189		struct kexec_elf_info elf_info;
   190		char *modified_cmdline = NULL;
   191	
   192		ret = kexec_build_elf_info(kernel_buf, kernel_len, &ehdr, &elf_info);
   193		if (ret)
   194			return ERR_PTR(ret);
   195	
   196		ret = elf_find_pbase(image, kernel_len, &ehdr, &elf_info,
   197				     &old_kernel_pbase, &new_kernel_pbase);
   198		if (ret)
   199			goto out;
   200		kernel_start = image->start;
   201		pr_notice("The entry point of kernel at 0x%lx\n", image->start);
   202	
   203		/* Add the kernel binary to the image */
   204		ret = riscv_kexec_elf_load(image, &ehdr, &elf_info,
   205					   old_kernel_pbase, new_kernel_pbase);
   206		if (ret)
   207			goto out;
   208	
   209		kbuf.image = image;
   210		kbuf.buf_min = new_kernel_pbase + kernel_len;
   211		kbuf.buf_max = ULONG_MAX;
   212	
   213		/* Add elfcorehdr */
   214		if (image->type == KEXEC_TYPE_CRASH) {
   215			ret = prepare_elf_headers(&headers, &headers_sz);
   216			if (ret) {
   217				pr_err("Preparing elf core header failed\n");
   218				goto out;
   219			}
   220	
   221			kbuf.buffer = headers;
   222			kbuf.bufsz = headers_sz;
   223			kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
   224			kbuf.memsz = headers_sz;
   225			kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
   226			kbuf.top_down = true;
   227	
   228			ret = kexec_add_buffer(&kbuf);
   229			if (ret) {
   230				vfree(headers);
   231				goto out;
   232			}
   233			image->elf_headers = headers;
   234			image->elf_load_addr = kbuf.mem;
   235			image->elf_headers_sz = headers_sz;
   236	
   237			pr_debug("Loaded elf core header at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
   238				 image->elf_load_addr, kbuf.bufsz, kbuf.memsz);
   239	
   240			/* Setup cmdline for kdump kernel case */
   241			modified_cmdline = setup_kdump_cmdline(image, cmdline,
   242							       cmdline_len);
   243			if (!modified_cmdline) {
   244				pr_err("Setting up cmdline for kdump kernel failed\n");
   245				ret = -EINVAL;
   246				goto out;
   247			}
   248			cmdline = modified_cmdline;
   249		}
   250	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
