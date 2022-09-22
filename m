Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B71085E5A64
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 07:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbiIVFDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 01:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiIVFDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 01:03:04 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60306A61D1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 22:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663822983; x=1695358983;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tUYp8Oolw1ORQ+MMKn5WUPxh5QfW1sHXIwWeamwzW+k=;
  b=P73Src2vAdIvqTjbQyGXLLpwgsMC25i5/uAtYF90Khwb0gAgURw2MWDV
   a9MJAL/eiSDLBx5yeXQrObCXSoZL5iXUmroLe1GliUj2mUfRdYzSC7zZ7
   voiijg8nuRN2BgZlquW/yLW2uQuLznk+X/6QL5oVnVTIUUVTk70uWtbpx
   ODBcqvBzwUbWKii+RgD1bk/hgFWS8QxZQBA4CecPK7KXvQrSlO80cY/6y
   0/+reL3Jg1UG+ATlqDu/tQfsDU0Ah6YJ5ru2kSx9949msbuHCZVyw5yHY
   xY4rK3HqxGwccLVgrfSlh5uPAEQh2KfywgQRUc+BsxAimT+/i2OWOKSYt
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="279920358"
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="279920358"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 22:03:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="688148679"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 21 Sep 2022 22:03:01 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1obEMX-0004KQ-0z;
        Thu, 22 Sep 2022 05:03:01 +0000
Date:   Thu, 22 Sep 2022 13:02:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Li Zhengyu <lizhengyu3@huawei.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: arch/riscv/kernel/elf_kexec.c:185:23: warning: variable
 'kernel_start' set but not used
Message-ID: <202209221201.YBE0WYnK-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   dc164f4fb00a0abebdfff132f8bc7291a28f5401
commit: 838b3e28488f702e2b5477b393f009b2639d2b1a RISC-V: Load purgatory in kexec_file
date:   4 months ago
config: riscv-randconfig-r032-20220922 (https://download.01.org/0day-ci/archive/20220922/202209221201.YBE0WYnK-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=838b3e28488f702e2b5477b393f009b2639d2b1a
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 838b3e28488f702e2b5477b393f009b2639d2b1a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/kernel/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   arch/riscv/kernel/elf_kexec.c: In function 'elf_kexec_load':
>> arch/riscv/kernel/elf_kexec.c:185:23: warning: variable 'kernel_start' set but not used [-Wunused-but-set-variable]
     185 |         unsigned long kernel_start;
         |                       ^~~~~~~~~~~~


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
https://01.org/lkp
