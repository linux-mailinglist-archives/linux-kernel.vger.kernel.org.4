Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF695B7E01
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 02:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiINAxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 20:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbiINAxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 20:53:02 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288B0371AF
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 17:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663116781; x=1694652781;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=GZsboB/cmJ6HEuykGInXryBXTWwZdW9Ea7Z/o3r1/5I=;
  b=a8ihswEt4Zrnj5DIvxk+iTNuVOs10JKgFGTMNYGroGtsBaZHaMLh4DAI
   5WLqmHQAl06VaxAQM6mXFx2PYRNz+4UF8Thw1l7eoTNXvTx/1PGpXg8Cg
   WexwAGv6SZi61EgnXyxYBv0Fcp9U7T+xGEsTtSww/aevIqIDU8V8JI0Qz
   j6TVOMRkqj8eYh0orysW9ELsBDc8u2QcxVjGqsaL0hTBGryP/VBgkN+02
   P/EGeLtzUvcSQWZD3vz7THTYJ2/GgyvcPZ/32fKsoclh1bhOwgpmjUs8n
   lIWN0qNixUO8/nrLF2X1i7SBzGfu6gkJ2ZIwokiXESJMHRuPbcmKUL8ZO
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10469"; a="324545442"
X-IronPort-AV: E=Sophos;i="5.93,313,1654585200"; 
   d="scan'208";a="324545442"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2022 17:53:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,313,1654585200"; 
   d="scan'208";a="742368516"
Received: from lkp-server02.sh.intel.com (HELO 4011df4f4fd3) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 13 Sep 2022 17:52:59 -0700
Received: from kbuild by 4011df4f4fd3 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oYGeA-0004Az-16;
        Wed, 14 Sep 2022 00:52:58 +0000
Date:   Wed, 14 Sep 2022 08:52:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     kbuild-all@lists.01.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:palmer/linux/riscv-hwprobe 4/4]
 arch/riscv/kernel/cpufeature.c:233:23: error: implicit declaration of
 function 'hartid_to_cpuid_map'
Message-ID: <202209140832.Pk9wZRZU-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block palmer/linux/riscv-hwprobe
head:   9be297f7ed349945cccc85f8df9d90e5ab68c1d9
commit: 9be297f7ed349945cccc85f8df9d90e5ab68c1d9 [4/4] (WIP) RISC-V: hwprobe: Support probing of misaligned accesss performance
config: riscv-randconfig-r042-20220911 (https://download.01.org/0day-ci/archive/20220914/202209140832.Pk9wZRZU-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/9be297f7ed349945cccc85f8df9d90e5ab68c1d9
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block palmer/linux/riscv-hwprobe
        git checkout 9be297f7ed349945cccc85f8df9d90e5ab68c1d9
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/kernel/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/riscv/kernel/cpufeature.c: In function 'riscv_fill_hwcap':
>> arch/riscv/kernel/cpufeature.c:233:23: error: implicit declaration of function 'hartid_to_cpuid_map' [-Werror=implicit-function-declaration]
     233 |                 cpu = hartid_to_cpuid_map(hartid);
         |                       ^~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/hartid_to_cpuid_map +233 arch/riscv/kernel/cpufeature.c

    74	
    75	void __init riscv_fill_hwcap(void)
    76	{
    77		struct device_node *node;
    78		const char *isa, *misaligned;
    79		char print_str[NUM_ALPHA_EXTS + 1];
    80		int i, j, rc;
    81		static unsigned long isa2hwcap[256] = {0};
    82		unsigned long hartid, cpu;
    83	
    84		isa2hwcap['i'] = isa2hwcap['I'] = COMPAT_HWCAP_ISA_I;
    85		isa2hwcap['m'] = isa2hwcap['M'] = COMPAT_HWCAP_ISA_M;
    86		isa2hwcap['a'] = isa2hwcap['A'] = COMPAT_HWCAP_ISA_A;
    87		isa2hwcap['f'] = isa2hwcap['F'] = COMPAT_HWCAP_ISA_F;
    88		isa2hwcap['d'] = isa2hwcap['D'] = COMPAT_HWCAP_ISA_D;
    89		isa2hwcap['c'] = isa2hwcap['C'] = COMPAT_HWCAP_ISA_C;
    90	
    91		elf_hwcap = 0;
    92	
    93		bitmap_zero(riscv_isa, RISCV_ISA_EXT_MAX);
    94	
    95		for_each_of_cpu_node(node) {
    96			unsigned long this_hwcap = 0;
    97			DECLARE_BITMAP(this_isa, RISCV_ISA_EXT_MAX);
    98			const char *temp;
    99	
   100			rc = riscv_of_processor_hartid(node, &hartid);
   101			if (rc < 0)
   102				continue;
   103	
   104			if (of_property_read_string(node, "riscv,isa", &isa)) {
   105				pr_warn("Unable to find \"riscv,isa\" devicetree entry\n");
   106				continue;
   107			}
   108	
   109			temp = isa;
   110	#if IS_ENABLED(CONFIG_32BIT)
   111			if (!strncmp(isa, "rv32", 4))
   112				isa += 4;
   113	#elif IS_ENABLED(CONFIG_64BIT)
   114			if (!strncmp(isa, "rv64", 4))
   115				isa += 4;
   116	#endif
   117			/* The riscv,isa DT property must start with rv64 or rv32 */
   118			if (temp == isa)
   119				continue;
   120			bitmap_zero(this_isa, RISCV_ISA_EXT_MAX);
   121			for (; *isa; ++isa) {
   122				const char *ext = isa++;
   123				const char *ext_end = isa;
   124				bool ext_long = false, ext_err = false;
   125	
   126				switch (*ext) {
   127				case 's':
   128					/**
   129					 * Workaround for invalid single-letter 's' & 'u'(QEMU).
   130					 * No need to set the bit in riscv_isa as 's' & 'u' are
   131					 * not valid ISA extensions. It works until multi-letter
   132					 * extension starting with "Su" appears.
   133					 */
   134					if (ext[-1] != '_' && ext[1] == 'u') {
   135						++isa;
   136						ext_err = true;
   137						break;
   138					}
   139					fallthrough;
   140				case 'x':
   141				case 'z':
   142					ext_long = true;
   143					/* Multi-letter extension must be delimited */
   144					for (; *isa && *isa != '_'; ++isa)
   145						if (unlikely(!islower(*isa)
   146							     && !isdigit(*isa)))
   147							ext_err = true;
   148					/* Parse backwards */
   149					ext_end = isa;
   150					if (unlikely(ext_err))
   151						break;
   152					if (!isdigit(ext_end[-1]))
   153						break;
   154					/* Skip the minor version */
   155					while (isdigit(*--ext_end))
   156						;
   157					if (ext_end[0] != 'p'
   158					    || !isdigit(ext_end[-1])) {
   159						/* Advance it to offset the pre-decrement */
   160						++ext_end;
   161						break;
   162					}
   163					/* Skip the major version */
   164					while (isdigit(*--ext_end))
   165						;
   166					++ext_end;
   167					break;
   168				default:
   169					if (unlikely(!islower(*ext))) {
   170						ext_err = true;
   171						break;
   172					}
   173					/* Find next extension */
   174					if (!isdigit(*isa))
   175						break;
   176					/* Skip the minor version */
   177					while (isdigit(*++isa))
   178						;
   179					if (*isa != 'p')
   180						break;
   181					if (!isdigit(*++isa)) {
   182						--isa;
   183						break;
   184					}
   185					/* Skip the major version */
   186					while (isdigit(*++isa))
   187						;
   188					break;
   189				}
   190				if (*isa != '_')
   191					--isa;
   192	
   193	#define SET_ISA_EXT_MAP(name, bit)						\
   194				do {							\
   195					if ((ext_end - ext == sizeof(name) - 1) &&	\
   196					     !memcmp(ext, name, sizeof(name) - 1))	\
   197						set_bit(bit, this_isa);			\
   198				} while (false)						\
   199	
   200				if (unlikely(ext_err))
   201					continue;
   202				if (!ext_long) {
   203					this_hwcap |= isa2hwcap[(unsigned char)(*ext)];
   204					set_bit(*ext - 'a', this_isa);
   205				} else {
   206					SET_ISA_EXT_MAP("sscofpmf", RISCV_ISA_EXT_SSCOFPMF);
   207					SET_ISA_EXT_MAP("svpbmt", RISCV_ISA_EXT_SVPBMT);
   208					SET_ISA_EXT_MAP("zicbom", RISCV_ISA_EXT_ZICBOM);
   209					SET_ISA_EXT_MAP("zihintpause", RISCV_ISA_EXT_ZIHINTPAUSE);
   210					SET_ISA_EXT_MAP("sstc", RISCV_ISA_EXT_SSTC);
   211				}
   212	#undef SET_ISA_EXT_MAP
   213			}
   214	
   215			/*
   216			 * All "okay" hart should have same isa. Set HWCAP based on
   217			 * common capabilities of every "okay" hart, in case they don't
   218			 * have.
   219			 */
   220			if (elf_hwcap)
   221				elf_hwcap &= this_hwcap;
   222			else
   223				elf_hwcap = this_hwcap;
   224	
   225			if (bitmap_empty(riscv_isa, RISCV_ISA_EXT_MAX))
   226				bitmap_copy(riscv_isa, this_isa, RISCV_ISA_EXT_MAX);
   227			else
   228				bitmap_and(riscv_isa, riscv_isa, this_isa, RISCV_ISA_EXT_MAX);
   229	
   230			/*
   231			 * Check for the performance of misaligned accesses.
   232			 */
 > 233			cpu = hartid_to_cpuid_map(hartid);
   234			if (cpu < 0)
   235				continue;
   236	
   237			if (of_property_read_string(node, "riscv,misaligned-access-performance", &misaligned)) {
   238				if (strcmp(misaligned, "emulated") == 0)
   239					per_cpu(misaligned_access_speed, cpu) = RISCV_HWPROBE_MISALIGNED_EMULATED;
   240				if (strcmp(misaligned, "slow") == 0)
   241					per_cpu(misaligned_access_speed, cpu) = RISCV_HWPROBE_MISALIGNED_SLOW;
   242				if (strcmp(misaligned, "fast") == 0)
   243					per_cpu(misaligned_access_speed, cpu) = RISCV_HWPROBE_MISALIGNED_FAST;
   244			}
   245		}
   246	
   247		/* We don't support systems with F but without D, so mask those out
   248		 * here. */
   249		if ((elf_hwcap & COMPAT_HWCAP_ISA_F) && !(elf_hwcap & COMPAT_HWCAP_ISA_D)) {
   250			pr_info("This kernel does not support systems with F but not D\n");
   251			elf_hwcap &= ~COMPAT_HWCAP_ISA_F;
   252		}
   253	
   254		memset(print_str, 0, sizeof(print_str));
   255		for (i = 0, j = 0; i < NUM_ALPHA_EXTS; i++)
   256			if (riscv_isa[0] & BIT_MASK(i))
   257				print_str[j++] = (char)('a' + i);
   258		pr_info("riscv: base ISA extensions %s\n", print_str);
   259	
   260		memset(print_str, 0, sizeof(print_str));
   261		for (i = 0, j = 0; i < NUM_ALPHA_EXTS; i++)
   262			if (elf_hwcap & BIT_MASK(i))
   263				print_str[j++] = (char)('a' + i);
   264		pr_info("riscv: ELF capabilities %s\n", print_str);
   265	
   266		for_each_set_bit(i, riscv_isa, RISCV_ISA_EXT_MAX) {
   267			j = riscv_isa_ext2key(i);
   268			if (j >= 0)
   269				static_branch_enable(&riscv_isa_ext_keys[j]);
   270		}
   271	}
   272	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
