Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5572C6CCB92
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 22:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjC1Uka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 16:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjC1Uk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 16:40:28 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E42451FC3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 13:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680036024; x=1711572024;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1I+lgLkRuGkMqQh0iIvFxs6ISFB+fwJO3PwKosPcFWU=;
  b=P+SOL0DEm2VT0eJXt3EpSrdgma7RyEYCzZrqih1LB/dLRfdcK5OJkWHW
   1U1w/6ete/sa5uCVi/lFL3xTrmL+p5dDmjVtYAPcyRd1p3BlyJ2m+Lv1L
   9MNOGwo1WSRFFP5CkYnUfrW3uEP5x2jmrCfP3RoTFmWctlBak6L1aI2CZ
   fcaQWUCxLwQ2tb+X7ppc1ZhY9sBF0wrDWsR6u3/DIOsXuu2zemhgctIrg
   EKZylcHzjTZ2ld0ngiWaxknJV0fSBYDE5b6GIzOhu8v6V64C/CtXcH+vM
   sSeTFDyBvstaAxOnW4pzOWQynL61k9PXJYONCYKbvzMw2XzW2gkF0MVmz
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="426959635"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="426959635"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 13:40:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="748530841"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="748530841"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 28 Mar 2023 13:40:21 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1phG7A-000It7-2Y;
        Tue, 28 Mar 2023 20:40:20 +0000
Date:   Wed, 29 Mar 2023 04:40:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Li Zhengyu <lizhengyu3@huawei.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>
Subject: arch/riscv/kernel/elf_kexec.c:185:16: warning: variable
 'kernel_start' set but not used
Message-ID: <202303290418.XvYFwNe4-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Li,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3a93e40326c8f470e71d20b4c42d36767450f38f
commit: 838b3e28488f702e2b5477b393f009b2639d2b1a RISC-V: Load purgatory in kexec_file
date:   10 months ago
config: riscv-randconfig-r042-20230329 (https://download.01.org/0day-ci/archive/20230329/202303290418.XvYFwNe4-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 67409911353323ca5edf2049ef0df54132fa1ca7)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=838b3e28488f702e2b5477b393f009b2639d2b1a
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 838b3e28488f702e2b5477b393f009b2639d2b1a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/kernel/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303290418.XvYFwNe4-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/riscv/kernel/elf_kexec.c:185:16: warning: variable 'kernel_start' set but not used [-Wunused-but-set-variable]
           unsigned long kernel_start;
                         ^
   1 warning generated.


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
https://github.com/intel/lkp-tests
