Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC1D5BF55D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 06:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbiIUEbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 00:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbiIUEbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 00:31:01 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 268855E567
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 21:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663734660; x=1695270660;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=XMMMwAkhf1dZ8/sBsEVsGbXNI27LaJzE5gd4io4VDzg=;
  b=Q/UYyqW8dKvE7SZUwwpM3tTQA0Oj5n6PMBR2lMDm5qvEwbNr0OhQmiFS
   yjV4VuJ+Z3rHLJRUkJ9roA9FKTbdEb7q70gOD8tf1a9AMVg5Si9E+oDQT
   Oe60XCoSHFT+ZJxPpFj6Xm67yQX/i3WAB0jtOpfSPQUj8O7zLjGxqkB/D
   Fl4sDoGwL8lYacIRjdRZNqew1mO7Js+6n774ajoczwLlUz1W+P5vOAw6L
   aQXF+ec8RGzNi8RBE5khq5RJ9xesffcmD4CZzIVSW0iCyTVws2mxtA5do
   wx8L2UyimHx8wK8ieM2yzpZZiP7Tg+gubXQwhHTDazQa9g7BPSAPGnrR7
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10476"; a="280269435"
X-IronPort-AV: E=Sophos;i="5.93,332,1654585200"; 
   d="scan'208";a="280269435"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 21:30:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,332,1654585200"; 
   d="scan'208";a="687713636"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 20 Sep 2022 21:30:58 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oarNx-0003E9-2i;
        Wed, 21 Sep 2022 04:30:57 +0000
Date:   Wed, 21 Sep 2022 12:30:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [ardb:for-kernelci 18/21] drivers/firmware/efi/efi.c:684:21: sparse:
 sparse: incorrect type in assignment (different address spaces)
Message-ID: <202209211234.71kJItJ3-lkp@intel.com>
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

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git for-kernelci
head:   937e76d1d0f60866865f2f8959184a5f69a0b6d0
commit: efbeb1d538fc8ad0dd623637bd114a5ca245db45 [18/21] efi: libstub: unify initrd loading between architectures
config: ia64-randconfig-s052-20220921 (https://download.01.org/0day-ci/archive/20220921/202209211234.71kJItJ3-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/commit/?id=efbeb1d538fc8ad0dd623637bd114a5ca245db45
        git remote add ardb git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git
        git fetch --no-tags ardb for-kernelci
        git checkout efbeb1d538fc8ad0dd623637bd114a5ca245db45
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=ia64 SHELL=/bin/bash drivers/firmware/efi/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
   drivers/firmware/efi/efi.c:610:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct linux_efi_random_seed *seed @@     got void [noderef] __iomem * @@
   drivers/firmware/efi/efi.c:610:22: sparse:     expected struct linux_efi_random_seed *seed
   drivers/firmware/efi/efi.c:610:22: sparse:     got void [noderef] __iomem *
   drivers/firmware/efi/efi.c:613:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got struct linux_efi_random_seed *seed @@
   drivers/firmware/efi/efi.c:613:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/firmware/efi/efi.c:613:25: sparse:     got struct linux_efi_random_seed *seed
   drivers/firmware/efi/efi.c:618:30: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct linux_efi_random_seed *seed @@     got void [noderef] __iomem * @@
   drivers/firmware/efi/efi.c:618:30: sparse:     expected struct linux_efi_random_seed *seed
   drivers/firmware/efi/efi.c:618:30: sparse:     got void [noderef] __iomem *
   drivers/firmware/efi/efi.c:623:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got struct linux_efi_random_seed *seed @@
   drivers/firmware/efi/efi.c:623:33: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/firmware/efi/efi.c:623:33: sparse:     got struct linux_efi_random_seed *seed
   drivers/firmware/efi/efi.c:647:27: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char [usertype] *p @@     got void [noderef] __iomem * @@
   drivers/firmware/efi/efi.c:647:27: sparse:     expected unsigned char [usertype] *p
   drivers/firmware/efi/efi.c:647:27: sparse:     got void [noderef] __iomem *
   drivers/firmware/efi/efi.c:666:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned char [usertype] *p @@
   drivers/firmware/efi/efi.c:666:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/firmware/efi/efi.c:666:25: sparse:     got unsigned char [usertype] *p
   drivers/firmware/efi/efi.c:673:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct efi_rt_properties_table_t [usertype] *tbl @@     got void [noderef] __iomem * @@
   drivers/firmware/efi/efi.c:673:21: sparse:     expected struct efi_rt_properties_table_t [usertype] *tbl
   drivers/firmware/efi/efi.c:673:21: sparse:     got void [noderef] __iomem *
   drivers/firmware/efi/efi.c:676:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got struct efi_rt_properties_table_t [usertype] *tbl @@
   drivers/firmware/efi/efi.c:676:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/firmware/efi/efi.c:676:25: sparse:     got struct efi_rt_properties_table_t [usertype] *tbl
>> drivers/firmware/efi/efi.c:684:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct linux_efi_initrd *tbl @@     got void [noderef] __iomem * @@
   drivers/firmware/efi/efi.c:684:21: sparse:     expected struct linux_efi_initrd *tbl
   drivers/firmware/efi/efi.c:684:21: sparse:     got void [noderef] __iomem *
>> drivers/firmware/efi/efi.c:688:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got struct linux_efi_initrd *tbl @@
   drivers/firmware/efi/efi.c:688:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/firmware/efi/efi.c:688:25: sparse:     got struct linux_efi_initrd *tbl

vim +684 drivers/firmware/efi/efi.c

   569	
   570	int __init efi_config_parse_tables(const efi_config_table_t *config_tables,
   571					   int count,
   572					   const efi_config_table_type_t *arch_tables)
   573	{
   574		const efi_config_table_64_t *tbl64 = (void *)config_tables;
   575		const efi_config_table_32_t *tbl32 = (void *)config_tables;
   576		const efi_guid_t *guid;
   577		unsigned long table;
   578		int i;
   579	
   580		pr_info("");
   581		for (i = 0; i < count; i++) {
   582			if (!IS_ENABLED(CONFIG_X86)) {
   583				guid = &config_tables[i].guid;
   584				table = (unsigned long)config_tables[i].table;
   585			} else if (efi_enabled(EFI_64BIT)) {
   586				guid = &tbl64[i].guid;
   587				table = tbl64[i].table;
   588	
   589				if (IS_ENABLED(CONFIG_X86_32) &&
   590				    tbl64[i].table > U32_MAX) {
   591					pr_cont("\n");
   592					pr_err("Table located above 4GB, disabling EFI.\n");
   593					return -EINVAL;
   594				}
   595			} else {
   596				guid = &tbl32[i].guid;
   597				table = tbl32[i].table;
   598			}
   599	
   600			if (!match_config_table(guid, table, common_tables) && arch_tables)
   601				match_config_table(guid, table, arch_tables);
   602		}
   603		pr_cont("\n");
   604		set_bit(EFI_CONFIG_TABLES, &efi.flags);
   605	
   606		if (efi_rng_seed != EFI_INVALID_TABLE_ADDR) {
   607			struct linux_efi_random_seed *seed;
   608			u32 size = 0;
   609	
   610			seed = early_memremap(efi_rng_seed, sizeof(*seed));
   611			if (seed != NULL) {
   612				size = READ_ONCE(seed->size);
   613				early_memunmap(seed, sizeof(*seed));
   614			} else {
   615				pr_err("Could not map UEFI random seed!\n");
   616			}
   617			if (size > 0) {
   618				seed = early_memremap(efi_rng_seed,
   619						      sizeof(*seed) + size);
   620				if (seed != NULL) {
   621					pr_notice("seeding entropy pool\n");
   622					add_bootloader_randomness(seed->bits, size);
   623					early_memunmap(seed, sizeof(*seed) + size);
   624				} else {
   625					pr_err("Could not map UEFI random seed!\n");
   626				}
   627			}
   628		}
   629	
   630		if (!IS_ENABLED(CONFIG_X86_32) && efi_enabled(EFI_MEMMAP))
   631			efi_memattr_init();
   632	
   633		efi_tpm_eventlog_init();
   634	
   635		if (mem_reserve != EFI_INVALID_TABLE_ADDR) {
   636			unsigned long prsv = mem_reserve;
   637	
   638			while (prsv) {
   639				struct linux_efi_memreserve *rsv;
   640				u8 *p;
   641	
   642				/*
   643				 * Just map a full page: that is what we will get
   644				 * anyway, and it permits us to map the entire entry
   645				 * before knowing its size.
   646				 */
   647				p = early_memremap(ALIGN_DOWN(prsv, PAGE_SIZE),
   648						   PAGE_SIZE);
   649				if (p == NULL) {
   650					pr_err("Could not map UEFI memreserve entry!\n");
   651					return -ENOMEM;
   652				}
   653	
   654				rsv = (void *)(p + prsv % PAGE_SIZE);
   655	
   656				/* reserve the entry itself */
   657				memblock_reserve(prsv,
   658						 struct_size(rsv, entry, rsv->size));
   659	
   660				for (i = 0; i < atomic_read(&rsv->count); i++) {
   661					memblock_reserve(rsv->entry[i].base,
   662							 rsv->entry[i].size);
   663				}
   664	
   665				prsv = rsv->next;
   666				early_memunmap(p, PAGE_SIZE);
   667			}
   668		}
   669	
   670		if (rt_prop != EFI_INVALID_TABLE_ADDR) {
   671			efi_rt_properties_table_t *tbl;
   672	
   673			tbl = early_memremap(rt_prop, sizeof(*tbl));
   674			if (tbl) {
   675				efi.runtime_supported_mask &= tbl->runtime_services_supported;
   676				early_memunmap(tbl, sizeof(*tbl));
   677			}
   678		}
   679	
   680		if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) &&
   681		    initrd != EFI_INVALID_TABLE_ADDR) {
   682			struct linux_efi_initrd *tbl;
   683	
 > 684			tbl = early_memremap(initrd, sizeof(*tbl));
   685			if (tbl) {
   686				phys_initrd_start = tbl->base;
   687				phys_initrd_size = tbl->size;
 > 688				early_memunmap(tbl, sizeof(*tbl));
   689			}
   690		}
   691	
   692		return 0;
   693	}
   694	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
