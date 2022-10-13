Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E61F65FE3AF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 23:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbiJMVEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 17:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiJMVEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 17:04:43 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F4E110D
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 14:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665695078; x=1697231078;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=nEaDIbtpn323lM9HVo/KfFsZeAJLXcYEKpOFdBR+UlU=;
  b=TBnEQKC8RvuU64wTt7Ikc40mABosWqCYXKJbWORVlEzgYQ9pfeEp7dVh
   Q9SyiOat0UUXE7xId7EwlfAC/jRgahtQOq6aZHqcuAnY8NHnsoPTvU38Q
   hjmUdHeM/tMQxjnAz4s8NSUBCtOYA02Zaoc/Yi8U9Y09NFp6jL6MDfdRY
   qaiodX3Kje7EvKRLRVenHF5H6olGI0l33Sj/xO67vhjPZlj2DzD9TSCJY
   3DRsdrV8NdhqZbzavmgTYDsP2sPdOnWQFKCFT58LxBtxEAZ07r10yKRjl
   RNZluQphNd9zso6shU2DQgfd+7kA/5qc2TY8+q9olnVxxEikgHA9X4RAF
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10499"; a="284929197"
X-IronPort-AV: E=Sophos;i="5.95,182,1661842800"; 
   d="scan'208";a="284929197"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2022 14:04:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10499"; a="658338821"
X-IronPort-AV: E=Sophos;i="5.95,182,1661842800"; 
   d="scan'208";a="658338821"
Received: from lkp-server01.sh.intel.com (HELO 2af0a69ca4e0) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 13 Oct 2022 14:04:24 -0700
Received: from kbuild by 2af0a69ca4e0 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oj5NQ-0005a7-04;
        Thu, 13 Oct 2022 21:04:24 +0000
Date:   Fri, 14 Oct 2022 05:03:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     kbuild-all@lists.01.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:palmer/linux/riscv-hwprobe-v1 4/5]
 arch/riscv/kernel/cpufeature.c:233:23: error: implicit declaration of
 function 'hartid_to_cpuid_map'
Message-ID: <202210140454.yGwpsw7B-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="FPtpqf2PaFV3SNyA"
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,UPPERCASE_50_75 autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FPtpqf2PaFV3SNyA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://github.com/ammarfaizi2/linux-block palmer/linux/riscv-hwprobe-v1
head:   ea6ba33fae4f9ca9d13f457ea2ccc8dd9f99d367
commit: 510c491cb9d87dcbdc91c63558dc704968723240 [4/5] RISC-V: hwprobe: Support probing of misaligned accesss performance
config: riscv-buildonly-randconfig-r006-20221012
compiler: riscv32-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/510c491cb9d87dcbdc91c63558dc704968723240
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block palmer/linux/riscv-hwprobe-v1
        git checkout 510c491cb9d87dcbdc91c63558dc704968723240
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/kernel/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

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

--FPtpqf2PaFV3SNyA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=config

#
# Automatically generated file; DO NOT EDIT.
# Linux/riscv 6.0.0-rc1 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="riscv32-linux-gcc (GCC) 12.1.0"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=120100
CONFIG_CLANG_VERSION=0
CONFIG_AS_IS_GNU=y
CONFIG_AS_VERSION=23800
CONFIG_LD_IS_BFD=y
CONFIG_LD_VERSION=23800
CONFIG_LLD_VERSION=0
CONFIG_CC_HAS_ASM_GOTO=y
CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_CC_HAS_NO_PROFILE_FN_ATTR=y
CONFIG_PAHOLE_VERSION=123
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_TABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_BROKEN_ON_SMP=y
CONFIG_INIT_ENV_ARG_LIMIT=32
CONFIG_COMPILE_TEST=y
# CONFIG_WERROR is not set
CONFIG_LOCALVERSION=""
CONFIG_BUILD_SALT=""
CONFIG_DEFAULT_INIT=""
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_WATCH_QUEUE=y
# CONFIG_CROSS_MEMORY_ATTACH is not set
CONFIG_USELIB=y
CONFIG_HAVE_ARCH_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_SHOW_LEVEL=y
CONFIG_GENERIC_IRQ_INJECTION=y
CONFIG_GENERIC_IRQ_CHIP=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_IRQ_FASTEOI_HIERARCHY_HANDLERS=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
CONFIG_GENERIC_IRQ_DEBUGFS=y
# end of IRQ subsystem

CONFIG_GENERIC_IRQ_MULTI_HANDLER=y
CONFIG_ARCH_CLOCKSOURCE_INIT=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_TIME_KUNIT_TEST=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
CONFIG_NO_HZ_IDLE=y
# CONFIG_NO_HZ is not set
# CONFIG_HIGH_RES_TIMERS is not set
# end of Timers subsystem

CONFIG_BPF=y
CONFIG_HAVE_EBPF_JIT=y

#
# BPF subsystem
#
CONFIG_BPF_SYSCALL=y
CONFIG_BPF_UNPRIV_DEFAULT_OFF=y
# end of BPF subsystem

CONFIG_PREEMPT_NONE_BUILD=y
CONFIG_PREEMPT_NONE=y
# CONFIG_PREEMPT_VOLUNTARY is not set
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
# CONFIG_IRQ_TIME_ACCOUNTING is not set
CONFIG_BSD_PROCESS_ACCT=y
# CONFIG_BSD_PROCESS_ACCT_V3 is not set
CONFIG_PSI=y
CONFIG_PSI_DEFAULT_DISABLED=y
# end of CPU/Task time and stats accounting

# CONFIG_CPU_ISOLATION is not set

#
# RCU Subsystem
#
CONFIG_TINY_RCU=y
CONFIG_RCU_EXPERT=y
CONFIG_SRCU=y
CONFIG_TINY_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
# CONFIG_FORCE_TASKS_RCU is not set
CONFIG_FORCE_TASKS_RUDE_RCU=y
CONFIG_TASKS_RUDE_RCU=y
CONFIG_FORCE_TASKS_TRACE_RCU=y
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_NEED_SEGCBLIST=y
# CONFIG_TASKS_TRACE_RCU_READ_MB is not set
# end of RCU Subsystem

CONFIG_IKCONFIG=y
# CONFIG_IKCONFIG_PROC is not set
CONFIG_IKHEADERS=y
CONFIG_GENERIC_SCHED_CLOCK=y

#
# Scheduler features
#
# end of Scheduler features

CONFIG_CC_IMPLICIT_FALLTHROUGH="-Wimplicit-fallthrough=5"
CONFIG_GCC12_NO_ARRAY_BOUNDS=y
CONFIG_CC_NO_ARRAY_BOUNDS=y
# CONFIG_CGROUPS is not set
# CONFIG_NAMESPACES is not set
CONFIG_CHECKPOINT_RESTORE=y
# CONFIG_SCHED_AUTOGROUP is not set
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
# CONFIG_RD_GZIP is not set
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
# CONFIG_RD_ZSTD is not set
CONFIG_BOOT_CONFIG=y
CONFIG_BOOT_CONFIG_EMBED=y
CONFIG_BOOT_CONFIG_EMBED_FILE=""
CONFIG_INITRAMFS_PRESERVE_MTIME=y
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SYSCTL=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_EXPERT=y
CONFIG_MULTIUSER=y
# CONFIG_SGETMASK_SYSCALL is not set
CONFIG_SYSFS_SYSCALL=y
# CONFIG_FHANDLE is not set
CONFIG_POSIX_TIMERS=y
# CONFIG_PRINTK is not set
CONFIG_BUG=y
CONFIG_BASE_FULL=y
# CONFIG_FUTEX is not set
CONFIG_EPOLL=y
# CONFIG_SIGNALFD is not set
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
# CONFIG_IO_URING is not set
# CONFIG_ADVISE_SYSCALLS is not set
# CONFIG_MEMBARRIER is not set
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_KCMP=y
# CONFIG_RSEQ is not set
CONFIG_EMBEDDED=y
CONFIG_HAVE_PERF_EVENTS=y
# CONFIG_PC104 is not set

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

CONFIG_SYSTEM_DATA_VERIFICATION=y
CONFIG_PROFILING=y
CONFIG_TRACEPOINTS=y
# end of General setup

CONFIG_32BIT=y
CONFIG_RISCV=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_BITS_MAX=17
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=17
CONFIG_RISCV_SBI=y
CONFIG_MMU=y
CONFIG_PAGE_OFFSET=0xC0000000
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_GENERIC_CSUM=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=2
CONFIG_LOCKDEP_SUPPORT=y

#
# SoC selection
#
CONFIG_SOC_MICROCHIP_POLARFIRE=y
CONFIG_SOC_SIFIVE=y
CONFIG_SOC_STARFIVE=y
CONFIG_SOC_VIRT=y
# end of SoC selection

#
# CPU errata selection
#
CONFIG_ERRATA_SIFIVE=y
# CONFIG_ERRATA_THEAD is not set
# end of CPU errata selection

#
# Platform type
#
CONFIG_NONPORTABLE=y
CONFIG_ARCH_RV32I=y
# CONFIG_ARCH_RV64I is not set
CONFIG_CMODEL_MEDLOW=y
# CONFIG_CMODEL_MEDANY is not set
# CONFIG_SMP is not set
CONFIG_TUNE_GENERIC=y
CONFIG_RISCV_ALTERNATIVE=y
CONFIG_RISCV_ISA_C=y
CONFIG_FPU=y
# end of Platform type

#
# Kernel features
#
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
CONFIG_HZ_300=y
# CONFIG_HZ_1000 is not set
CONFIG_HZ=300
CONFIG_RISCV_SBI_V01=y
CONFIG_KEXEC=y
# CONFIG_CRASH_DUMP is not set
# end of Kernel features

#
# Boot options
#
CONFIG_CMDLINE=""
CONFIG_EFI_STUB=y
CONFIG_EFI=y
CONFIG_CC_HAVE_STACKPROTECTOR_TLS=y
CONFIG_PHYS_RAM_BASE_FIXED=y
CONFIG_PHYS_RAM_BASE=0x80000000
# end of Boot options

#
# Power management options
#
# CONFIG_PM is not set
# end of Power management options

#
# CPU Power Management
#

#
# CPU Idle
#
# CONFIG_CPU_IDLE is not set
# end of CPU Idle
# end of CPU Power Management

CONFIG_VIRTUALIZATION=y
# CONFIG_KVM is not set

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
# CONFIG_JUMP_LABEL is not set
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_GENERIC_IDLE_POLL_SETUP=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_HAVE_ASM_MODVERSIONS=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
CONFIG_HAVE_ARCH_SECCOMP=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
# CONFIG_SECCOMP is not set
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR_STRONG=y
CONFIG_LTO_NONE=y
CONFIG_HAVE_CONTEXT_TRACKING_USER=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PUD=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_ARCH_MMAP_RND_BITS=8
CONFIG_PAGE_SIZE_LESS_THAN_64KB=y
CONFIG_PAGE_SIZE_LESS_THAN_256KB=y
CONFIG_ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT=y
CONFIG_ISA_BUS_API=y
CONFIG_CLONE_BACKWARDS=y
# CONFIG_COMPAT_32BIT_TIME is not set
CONFIG_ARCH_OPTIONAL_KERNEL_RWX=y
CONFIG_ARCH_OPTIONAL_KERNEL_RWX_DEFAULT=y
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_LOCK_EVENT_COUNTS=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_ARCH_SUPPORTS_PAGE_TABLE_CHECK=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_HAVE_GCC_PLUGINS=y
CONFIG_GCC_PLUGINS=y
# CONFIG_GCC_PLUGIN_LATENT_ENTROPY is not set
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
# CONFIG_MODULES is not set
CONFIG_BLOCK=y
# CONFIG_BLOCK_LEGACY_AUTOLOAD is not set
CONFIG_BLK_DEV_BSG_COMMON=y
CONFIG_BLK_ICQ=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_INTEGRITY_T10=y
CONFIG_BLK_DEV_ZONED=y
CONFIG_BLK_WBT=y
# CONFIG_BLK_WBT_MQ is not set
# CONFIG_BLK_DEBUG_FS is not set
CONFIG_BLK_SED_OPAL=y
# CONFIG_BLK_INLINE_ENCRYPTION is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
CONFIG_AIX_PARTITION=y
# CONFIG_OSF_PARTITION is not set
# CONFIG_AMIGA_PARTITION is not set
CONFIG_ATARI_PARTITION=y
# CONFIG_MAC_PARTITION is not set
# CONFIG_MSDOS_PARTITION is not set
CONFIG_LDM_PARTITION=y
CONFIG_LDM_DEBUG=y
# CONFIG_SGI_PARTITION is not set
CONFIG_ULTRIX_PARTITION=y
# CONFIG_SUN_PARTITION is not set
CONFIG_KARMA_PARTITION=y
# CONFIG_EFI_PARTITION is not set
CONFIG_SYSV68_PARTITION=y
# CONFIG_CMDLINE_PARTITION is not set
# end of Partition Types

CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLOCK_HOLDER_DEPRECATED=y
CONFIG_BLK_MQ_STACKING=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=y
CONFIG_IOSCHED_BFQ=y
# end of IO Schedulers

CONFIG_ASN1=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_MMIOWB=y

#
# Executable file formats
#
# CONFIG_BINFMT_ELF is not set
CONFIG_BINFMT_SCRIPT=y
CONFIG_ARCH_HAS_BINFMT_FLAT=y
CONFIG_BINFMT_FLAT=y
CONFIG_BINFMT_FLAT_OLD=y
# CONFIG_BINFMT_ZFLAT is not set
CONFIG_BINFMT_MISC=y
# CONFIG_COREDUMP is not set
# end of Executable file formats

#
# Memory Management options
#
# CONFIG_SWAP is not set

#
# SLAB allocator options
#
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB is not set
# CONFIG_SLAB_MERGE_DEFAULT is not set
# CONFIG_SLAB_FREELIST_RANDOM is not set
CONFIG_SLAB_FREELIST_HARDENED=y
CONFIG_SLUB_STATS=y
# end of SLAB allocator options

CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
CONFIG_COMPAT_BRK=y
CONFIG_SELECT_MEMORY_MODEL=y
# CONFIG_FLATMEM_MANUAL is not set
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_SPARSEMEM_STATIC=y
CONFIG_EXCLUSIVE_SYSTEM_RAM=y
CONFIG_SPLIT_PTLOCK_CPUS=4
# CONFIG_COMPACTION is not set
CONFIG_PAGE_REPORTING=y
# CONFIG_KSM is not set
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_NEED_PER_CPU_KM=y
# CONFIG_CMA is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_PAGE_IDLE_FLAG=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_CURRENT_STACK_POINTER=y
CONFIG_VM_EVENT_COUNTERS=y
CONFIG_PERCPU_STATS=y
# CONFIG_GUP_TEST is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_USERFAULTFD=y

#
# Data Access Monitoring
#
CONFIG_DAMON=y
CONFIG_DAMON_KUNIT_TEST=y
CONFIG_DAMON_VADDR=y
# CONFIG_DAMON_PADDR is not set
CONFIG_DAMON_VADDR_KUNIT_TEST=y
CONFIG_DAMON_SYSFS=y
# end of Data Access Monitoring
# end of Memory Management options

# CONFIG_NET is not set

#
# Device Drivers
#
CONFIG_HAVE_PCI=y
# CONFIG_PCI is not set
CONFIG_PCCARD=y
# CONFIG_PCMCIA is not set

#
# PC-card bridges
#

#
# Generic Driver Options
#
CONFIG_AUXILIARY_BUS=y
# CONFIG_UEVENT_HELPER is not set
CONFIG_DEVTMPFS=y
# CONFIG_DEVTMPFS_MOUNT is not set
CONFIG_DEVTMPFS_SAFE=y
# CONFIG_STANDALONE is not set
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_FW_LOADER_SYSFS=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
CONFIG_FW_LOADER_COMPRESS=y
# CONFIG_FW_LOADER_COMPRESS_XZ is not set
CONFIG_FW_LOADER_COMPRESS_ZSTD=y
CONFIG_FW_UPLOAD=y
# end of Firmware loader

CONFIG_WANT_DEV_COREDUMP=y
# CONFIG_ALLOW_DEV_COREDUMP is not set
# CONFIG_DEBUG_DRIVER is not set
CONFIG_DEBUG_DEVRES=y
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
CONFIG_PM_QOS_KUNIT_TEST=y
CONFIG_DRIVER_PE_KUNIT_TEST=y
CONFIG_SOC_BUS=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SPI=y
CONFIG_REGMAP_SPMI=y
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_REGMAP_SCCB=y
CONFIG_DMA_SHARED_BUFFER=y
CONFIG_DMA_FENCE_TRACE=y
# end of Generic Driver Options

#
# Bus devices
#
# CONFIG_ARM_INTEGRATOR_LM is not set
CONFIG_BT1_APB=y
CONFIG_BT1_AXI=y
CONFIG_MOXTET=y
# CONFIG_HISILICON_LPC is not set
# CONFIG_INTEL_IXP4XX_EB is not set
CONFIG_QCOM_EBI2=y
CONFIG_MHI_BUS=y
CONFIG_MHI_BUS_DEBUG=y
# CONFIG_MHI_BUS_EP is not set
# end of Bus devices

#
# Firmware Drivers
#

#
# ARM System Control and Management Interface Protocol
#
CONFIG_ARM_SCMI_PROTOCOL=y
CONFIG_ARM_SCMI_HAVE_TRANSPORT=y
CONFIG_ARM_SCMI_HAVE_SHMEM=y
CONFIG_ARM_SCMI_TRANSPORT_MAILBOX=y
# CONFIG_ARM_SCMI_TRANSPORT_VIRTIO is not set
# CONFIG_ARM_SCMI_POWER_DOMAIN is not set
CONFIG_ARM_SCMI_POWER_CONTROL=y
# end of ARM System Control and Management Interface Protocol

CONFIG_ARM_SCPI_PROTOCOL=y
CONFIG_ARM_SCPI_POWER_DOMAIN=y
CONFIG_FIRMWARE_MEMMAP=y
# CONFIG_MTK_ADSP_IPC is not set
CONFIG_QCOM_SCM=y
# CONFIG_QCOM_SCM_DOWNLOAD_MODE_DEFAULT is not set
# CONFIG_SYSFB_SIMPLEFB is not set
CONFIG_TURRIS_MOX_RWTM=y
# CONFIG_BCM47XX_NVRAM is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# EFI (Extensible Firmware Interface) Support
#
CONFIG_EFI_ESRT=y
CONFIG_EFI_VARS_PSTORE=y
# CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE is not set
CONFIG_EFI_PARAMS_FROM_FDT=y
CONFIG_EFI_RUNTIME_WRAPPERS=y
CONFIG_EFI_GENERIC_STUB=y
# CONFIG_EFI_BOOTLOADER_CONTROL is not set
CONFIG_EFI_CAPSULE_LOADER=y
CONFIG_EFI_TEST=y
CONFIG_RESET_ATTACK_MITIGATION=y
CONFIG_EFI_RCI2_TABLE=y
CONFIG_EFI_DISABLE_PCI_DMA=y
CONFIG_EFI_DISABLE_RUNTIME=y
# CONFIG_EFI_COCO_SECRET is not set
# end of EFI (Extensible Firmware Interface) Support

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

# CONFIG_GNSS is not set
# CONFIG_MTD is not set
# CONFIG_MTD_NAND_ECC_MXIC is not set
CONFIG_DTC=y
CONFIG_OF=y
# CONFIG_OF_UNITTEST is not set
# CONFIG_OF_ALL_DTBS is not set
CONFIG_OF_FLATTREE=y
CONFIG_OF_EARLY_FLATTREE=y
CONFIG_OF_KOBJ=y
CONFIG_OF_DYNAMIC=y
CONFIG_OF_ADDRESS=y
CONFIG_OF_IRQ=y
CONFIG_OF_RESERVED_MEM=y
CONFIG_OF_RESOLVE=y
CONFIG_OF_OVERLAY=y
CONFIG_OF_DMA_DEFAULT_COHERENT=y
# CONFIG_PARPORT is not set
# CONFIG_BLK_DEV is not set

#
# NVME Support
#
CONFIG_NVME_CORE=y
# CONFIG_NVME_MULTIPATH is not set
CONFIG_NVME_VERBOSE_ERRORS=y
# CONFIG_NVME_HWMON is not set
CONFIG_NVME_FABRICS=y
CONFIG_NVME_FC=y
# CONFIG_NVME_AUTH is not set
# CONFIG_NVME_APPLE is not set
CONFIG_NVME_TARGET=y
CONFIG_NVME_TARGET_PASSTHRU=y
# CONFIG_NVME_TARGET_LOOP is not set
# CONFIG_NVME_TARGET_FC is not set
# CONFIG_NVME_TARGET_AUTH is not set
# end of NVME Support

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=y
# CONFIG_AD525X_DPOT is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_ICS932S401 is not set
CONFIG_ATMEL_SSC=y
# CONFIG_ENCLOSURE_SERVICES is not set
CONFIG_GEHC_ACHC=y
CONFIG_HI6421V600_IRQ=y
# CONFIG_QCOM_COINCELL is not set
CONFIG_QCOM_FASTRPC=y
CONFIG_APDS9802ALS=y
CONFIG_ISL29003=y
CONFIG_ISL29020=y
CONFIG_SENSORS_TSL2550=y
# CONFIG_SENSORS_BH1770 is not set
CONFIG_SENSORS_APDS990X=y
CONFIG_HMC6352=y
# CONFIG_DS1682 is not set
# CONFIG_LATTICE_ECP3_CONFIG is not set
CONFIG_SRAM=y
# CONFIG_XILINX_SDFEC is not set
CONFIG_MISC_RTSX=y
CONFIG_HISI_HIKEY_USB=y
CONFIG_OPEN_DICE=y
CONFIG_VCPU_STALL_DETECTOR=y
CONFIG_C2PORT=y

#
# EEPROM support
#
# CONFIG_EEPROM_AT24 is not set
CONFIG_EEPROM_AT25=y
CONFIG_EEPROM_LEGACY=y
CONFIG_EEPROM_MAX6875=y
CONFIG_EEPROM_93CX6=y
CONFIG_EEPROM_93XX46=y
CONFIG_EEPROM_IDT_89HPESX=y
CONFIG_EEPROM_EE1004=y
# end of EEPROM support

#
# Texas Instruments shared transport line discipline
#
# end of Texas Instruments shared transport line discipline

# CONFIG_SENSORS_LIS3_SPI is not set
CONFIG_SENSORS_LIS3_I2C=y
# CONFIG_ALTERA_STAPL is not set
# CONFIG_ECHO is not set
CONFIG_MISC_RTSX_USB=y
CONFIG_UACCE=y
CONFIG_PVPANIC=y
# CONFIG_PVPANIC_MMIO is not set
# end of Misc devices

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=y
CONFIG_SCSI_COMMON=y
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
# CONFIG_BLK_DEV_SD is not set
CONFIG_CHR_DEV_ST=y
# CONFIG_CHR_DEV_SG is not set
CONFIG_BLK_DEV_BSG=y
CONFIG_CHR_DEV_SCH=y
CONFIG_SCSI_CONSTANTS=y
# CONFIG_SCSI_LOGGING is not set
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
# CONFIG_SCSI_SPI_ATTRS is not set
CONFIG_SCSI_SAS_ATTRS=y
# CONFIG_SCSI_SAS_LIBSAS is not set
CONFIG_SCSI_SRP_ATTRS=y
# end of SCSI Transports

CONFIG_SCSI_LOWLEVEL=y
# CONFIG_ISCSI_BOOT_SYSFS is not set
# CONFIG_SCSI_DEBUG is not set
# CONFIG_SCSI_VIRTIO is not set
# CONFIG_SCSI_DH is not set
# end of SCSI device support

# CONFIG_ATA is not set
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
# CONFIG_MD_AUTODETECT is not set
CONFIG_MD_LINEAR=y
CONFIG_MD_RAID0=y
CONFIG_MD_RAID1=y
CONFIG_MD_RAID10=y
CONFIG_MD_RAID456=y
CONFIG_MD_MULTIPATH=y
CONFIG_MD_FAULTY=y
CONFIG_BCACHE=y
CONFIG_BCACHE_DEBUG=y
# CONFIG_BCACHE_CLOSURES_DEBUG is not set
# CONFIG_BCACHE_ASYNC_REGISTRATION is not set
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_BLK_DEV_DM=y
# CONFIG_DM_DEBUG is not set
CONFIG_DM_BUFIO=y
# CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
CONFIG_DM_BIO_PRISON=y
CONFIG_DM_PERSISTENT_DATA=y
CONFIG_DM_UNSTRIPED=y
CONFIG_DM_CRYPT=y
# CONFIG_DM_SNAPSHOT is not set
CONFIG_DM_THIN_PROVISIONING=y
CONFIG_DM_CACHE=y
# CONFIG_DM_CACHE_SMQ is not set
CONFIG_DM_WRITECACHE=y
# CONFIG_DM_EBS is not set
CONFIG_DM_ERA=y
CONFIG_DM_CLONE=y
# CONFIG_DM_MIRROR is not set
CONFIG_DM_RAID=y
# CONFIG_DM_ZERO is not set
CONFIG_DM_MULTIPATH=y
CONFIG_DM_MULTIPATH_QL=y
CONFIG_DM_MULTIPATH_ST=y
# CONFIG_DM_MULTIPATH_HST is not set
CONFIG_DM_MULTIPATH_IOA=y
CONFIG_DM_DELAY=y
CONFIG_DM_DUST=y
# CONFIG_DM_INIT is not set
CONFIG_DM_UEVENT=y
CONFIG_DM_FLAKEY=y
CONFIG_DM_VERITY=y
CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG=y
# CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG_SECONDARY_KEYRING is not set
# CONFIG_DM_VERITY_FEC is not set
CONFIG_DM_SWITCH=y
CONFIG_DM_LOG_WRITES=y
CONFIG_DM_INTEGRITY=y
CONFIG_DM_ZONED=y
CONFIG_TARGET_CORE=y
# CONFIG_TCM_IBLOCK is not set
CONFIG_TCM_FILEIO=y
CONFIG_TCM_PSCSI=y
# CONFIG_LOOPBACK_TARGET is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_FIREWIRE is not set
# end of IEEE 1394 (FireWire) support

#
# Input device support
#
CONFIG_INPUT=y
# CONFIG_INPUT_LEDS is not set
CONFIG_INPUT_FF_MEMLESS=y
CONFIG_INPUT_SPARSEKMAP=y
CONFIG_INPUT_MATRIXKMAP=y
CONFIG_INPUT_VIVALDIFMAP=y

#
# Userland interfaces
#
# CONFIG_INPUT_MOUSEDEV is not set
CONFIG_INPUT_JOYDEV=y
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ADP5588=y
CONFIG_KEYBOARD_ADP5589=y
# CONFIG_KEYBOARD_ATKBD is not set
CONFIG_KEYBOARD_QT1050=y
CONFIG_KEYBOARD_QT1070=y
CONFIG_KEYBOARD_QT2160=y
# CONFIG_KEYBOARD_CLPS711X is not set
CONFIG_KEYBOARD_DLINK_DIR685=y
CONFIG_KEYBOARD_LKKBD=y
# CONFIG_KEYBOARD_EP93XX is not set
CONFIG_KEYBOARD_GPIO=y
# CONFIG_KEYBOARD_GPIO_POLLED is not set
CONFIG_KEYBOARD_TCA6416=y
CONFIG_KEYBOARD_TCA8418=y
# CONFIG_KEYBOARD_MATRIX is not set
CONFIG_KEYBOARD_LM8323=y
# CONFIG_KEYBOARD_LM8333 is not set
CONFIG_KEYBOARD_MAX7359=y
CONFIG_KEYBOARD_MCS=y
CONFIG_KEYBOARD_MPR121=y
# CONFIG_KEYBOARD_SNVS_PWRKEY is not set
# CONFIG_KEYBOARD_IMX is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_KEYBOARD_OPENCORES=y
# CONFIG_KEYBOARD_SAMSUNG is not set
CONFIG_KEYBOARD_GOLDFISH_EVENTS=y
# CONFIG_KEYBOARD_STOWAWAY is not set
CONFIG_KEYBOARD_ST_KEYSCAN=y
CONFIG_KEYBOARD_SUNKBD=y
# CONFIG_KEYBOARD_SH_KEYSC is not set
CONFIG_KEYBOARD_STMPE=y
CONFIG_KEYBOARD_OMAP4=y
CONFIG_KEYBOARD_TC3589X=y
CONFIG_KEYBOARD_TM2_TOUCHKEY=y
# CONFIG_KEYBOARD_XTKBD is not set
CONFIG_KEYBOARD_CROS_EC=y
CONFIG_KEYBOARD_CAP11XX=y
CONFIG_KEYBOARD_BCM=y
CONFIG_KEYBOARD_MT6779=y
CONFIG_KEYBOARD_MTK_PMIC=y
# CONFIG_KEYBOARD_CYPRESS_SF is not set
# CONFIG_INPUT_MOUSE is not set
# CONFIG_INPUT_JOYSTICK is not set
CONFIG_INPUT_TABLET=y
CONFIG_TABLET_USB_ACECAD=y
CONFIG_TABLET_USB_AIPTEK=y
CONFIG_TABLET_USB_HANWANG=y
# CONFIG_TABLET_USB_KBTAB is not set
CONFIG_TABLET_USB_PEGASUS=y
CONFIG_TABLET_SERIAL_WACOM4=y
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
CONFIG_INPUT_88PM80X_ONKEY=y
CONFIG_INPUT_AD714X=y
# CONFIG_INPUT_AD714X_I2C is not set
CONFIG_INPUT_AD714X_SPI=y
# CONFIG_INPUT_ARIEL_PWRBUTTON is not set
# CONFIG_INPUT_ATC260X_ONKEY is not set
CONFIG_INPUT_ATMEL_CAPTOUCH=y
CONFIG_INPUT_BMA150=y
CONFIG_INPUT_E3X0_BUTTON=y
CONFIG_INPUT_PM8941_PWRKEY=y
# CONFIG_INPUT_PM8XXX_VIBRATOR is not set
CONFIG_INPUT_MAX77650_ONKEY=y
CONFIG_INPUT_MAX77693_HAPTIC=y
# CONFIG_INPUT_MAX8925_ONKEY is not set
CONFIG_INPUT_MAX8997_HAPTIC=y
CONFIG_INPUT_MC13783_PWRBUTTON=y
# CONFIG_INPUT_MMA8450 is not set
CONFIG_INPUT_GPIO_BEEPER=y
CONFIG_INPUT_GPIO_DECODER=y
CONFIG_INPUT_GPIO_VIBRA=y
CONFIG_INPUT_CPCAP_PWRBUTTON=y
# CONFIG_INPUT_ATI_REMOTE2 is not set
CONFIG_INPUT_KEYSPAN_REMOTE=y
CONFIG_INPUT_KXTJ9=y
CONFIG_INPUT_POWERMATE=y
# CONFIG_INPUT_YEALINK is not set
# CONFIG_INPUT_CM109 is not set
# CONFIG_INPUT_REGULATOR_HAPTIC is not set
CONFIG_INPUT_RETU_PWRBUTTON=y
CONFIG_INPUT_TPS65218_PWRBUTTON=y
CONFIG_INPUT_AXP20X_PEK=y
CONFIG_INPUT_UINPUT=y
CONFIG_INPUT_PCF50633_PMU=y
CONFIG_INPUT_PCF8574=y
# CONFIG_INPUT_PWM_BEEPER is not set
CONFIG_INPUT_PWM_VIBRA=y
CONFIG_INPUT_GPIO_ROTARY_ENCODER=y
CONFIG_INPUT_DA7280_HAPTICS=y
# CONFIG_INPUT_DA9052_ONKEY is not set
# CONFIG_INPUT_DA9055_ONKEY is not set
# CONFIG_INPUT_DA9063_ONKEY is not set
CONFIG_INPUT_WM831X_ON=y
CONFIG_INPUT_ADXL34X=y
CONFIG_INPUT_ADXL34X_I2C=y
CONFIG_INPUT_ADXL34X_SPI=y
# CONFIG_INPUT_IMS_PCU is not set
# CONFIG_INPUT_IQS269A is not set
CONFIG_INPUT_IQS626A=y
# CONFIG_INPUT_IQS7222 is not set
CONFIG_INPUT_CMA3000=y
CONFIG_INPUT_CMA3000_I2C=y
CONFIG_INPUT_DRV260X_HAPTICS=y
CONFIG_INPUT_DRV2665_HAPTICS=y
CONFIG_INPUT_DRV2667_HAPTICS=y
# CONFIG_INPUT_HISI_POWERKEY is not set
CONFIG_INPUT_SC27XX_VIBRA=y
# CONFIG_INPUT_STPMIC1_ONKEY is not set
CONFIG_RMI4_CORE=y
# CONFIG_RMI4_I2C is not set
CONFIG_RMI4_SPI=y
CONFIG_RMI4_SMB=y
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=y
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
# CONFIG_RMI4_F34 is not set
# CONFIG_RMI4_F3A is not set
CONFIG_RMI4_F54=y
CONFIG_RMI4_F55=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=y
# CONFIG_SERIO_ALTERA_PS2 is not set
CONFIG_SERIO_PS2MULT=y
CONFIG_SERIO_ARC_PS2=y
# CONFIG_SERIO_APBPS2 is not set
CONFIG_SERIO_OLPC_APSP=y
CONFIG_SERIO_SUN4I_PS2=y
CONFIG_SERIO_GPIO_PS2=y
CONFIG_USERIO=y
# CONFIG_GAMEPORT is not set
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
# CONFIG_TTY is not set
# CONFIG_SERIAL_DEV_BUS is not set
# CONFIG_IPMI_HANDLER is not set
CONFIG_IPMI_KCS_BMC=y
CONFIG_ASPEED_KCS_IPMI_BMC=y
CONFIG_NPCM7XX_KCS_IPMI_BMC=y
CONFIG_IPMI_KCS_BMC_CDEV_IPMI=y
CONFIG_IPMI_KCS_BMC_SERIO=y
CONFIG_ASPEED_BT_IPMI_BMC=y
# CONFIG_IPMB_DEVICE_INTERFACE is not set
CONFIG_HW_RANDOM=y
# CONFIG_HW_RANDOM_TIMERIOMEM is not set
CONFIG_HW_RANDOM_ATMEL=y
CONFIG_HW_RANDOM_BA431=y
CONFIG_HW_RANDOM_BCM2835=y
CONFIG_HW_RANDOM_IPROC_RNG200=y
CONFIG_HW_RANDOM_IXP4XX=y
CONFIG_HW_RANDOM_OMAP=y
CONFIG_HW_RANDOM_OMAP3_ROM=y
CONFIG_HW_RANDOM_VIRTIO=y
# CONFIG_HW_RANDOM_IMX_RNGC is not set
# CONFIG_HW_RANDOM_NOMADIK is not set
CONFIG_HW_RANDOM_STM32=y
CONFIG_HW_RANDOM_MESON=y
CONFIG_HW_RANDOM_MTK=y
CONFIG_HW_RANDOM_EXYNOS=y
# CONFIG_HW_RANDOM_NPCM is not set
CONFIG_HW_RANDOM_KEYSTONE=y
CONFIG_HW_RANDOM_CCTRNG=y
# CONFIG_HW_RANDOM_XIPHERA is not set
# CONFIG_DEVMEM is not set
# CONFIG_TCG_TPM is not set
CONFIG_XILLYBUS_CLASS=y
# CONFIG_XILLYBUS is not set
CONFIG_XILLYUSB=y
CONFIG_RANDOM_TRUST_CPU=y
# CONFIG_RANDOM_TRUST_BOOTLOADER is not set
# end of Character devices

#
# I2C support
#
CONFIG_I2C=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=y
CONFIG_I2C_MUX=y

#
# Multiplexer I2C Chip support
#
CONFIG_I2C_ARB_GPIO_CHALLENGE=y
# CONFIG_I2C_MUX_GPIO is not set
CONFIG_I2C_MUX_GPMUX=y
CONFIG_I2C_MUX_LTC4306=y
CONFIG_I2C_MUX_PCA9541=y
CONFIG_I2C_MUX_PCA954x=y
# CONFIG_I2C_MUX_PINCTRL is not set
CONFIG_I2C_MUX_REG=y
CONFIG_I2C_DEMUX_PINCTRL=y
CONFIG_I2C_MUX_MLXCPLD=y
# end of Multiplexer I2C Chip support

CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=y
CONFIG_I2C_ALGOBIT=y

#
# I2C Hardware Bus support
#
CONFIG_I2C_HIX5HD2=y

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
CONFIG_I2C_ALTERA=y
CONFIG_I2C_ASPEED=y
# CONFIG_I2C_AT91 is not set
CONFIG_I2C_AXXIA=y
CONFIG_I2C_BCM2835=y
# CONFIG_I2C_BCM_IPROC is not set
CONFIG_I2C_BCM_KONA=y
CONFIG_I2C_BRCMSTB=y
CONFIG_I2C_CADENCE=y
# CONFIG_I2C_CBUS_GPIO is not set
# CONFIG_I2C_DAVINCI is not set
CONFIG_I2C_DESIGNWARE_CORE=y
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
CONFIG_I2C_DESIGNWARE_PLATFORM=y
CONFIG_I2C_DIGICOLOR=y
CONFIG_I2C_EMEV2=y
CONFIG_I2C_EXYNOS5=y
CONFIG_I2C_GPIO=y
CONFIG_I2C_GPIO_FAULT_INJECTOR=y
CONFIG_I2C_HIGHLANDER=y
# CONFIG_I2C_HISI is not set
# CONFIG_I2C_IMG is not set
# CONFIG_I2C_IMX is not set
CONFIG_I2C_IMX_LPI2C=y
CONFIG_I2C_IOP3XX=y
CONFIG_I2C_JZ4780=y
CONFIG_I2C_KEMPLD=y
CONFIG_I2C_LPC2K=y
CONFIG_I2C_MESON=y
# CONFIG_I2C_MICROCHIP_CORE is not set
# CONFIG_I2C_MT65XX is not set
CONFIG_I2C_MT7621=y
CONFIG_I2C_MV64XXX=y
CONFIG_I2C_MXS=y
CONFIG_I2C_NPCM=y
CONFIG_I2C_OCORES=y
CONFIG_I2C_OMAP=y
# CONFIG_I2C_OWL is not set
CONFIG_I2C_APPLE=y
# CONFIG_I2C_PCA_PLATFORM is not set
CONFIG_I2C_PNX=y
CONFIG_I2C_PXA=y
# CONFIG_I2C_PXA_SLAVE is not set
# CONFIG_I2C_QCOM_CCI is not set
CONFIG_I2C_QUP=y
CONFIG_I2C_RIIC=y
CONFIG_I2C_RK3X=y
CONFIG_I2C_RZV2M=y
# CONFIG_I2C_S3C2410 is not set
CONFIG_I2C_SH_MOBILE=y
# CONFIG_I2C_SIMTEC is not set
# CONFIG_I2C_SPRD is not set
CONFIG_I2C_ST=y
CONFIG_I2C_STM32F4=y
# CONFIG_I2C_STM32F7 is not set
# CONFIG_I2C_SUN6I_P2WI is not set
CONFIG_I2C_SYNQUACER=y
# CONFIG_I2C_TEGRA is not set
CONFIG_I2C_TEGRA_BPMP=y
# CONFIG_I2C_UNIPHIER is not set
CONFIG_I2C_UNIPHIER_F=y
CONFIG_I2C_VERSATILE=y
CONFIG_I2C_WMT=y
CONFIG_I2C_XILINX=y
CONFIG_I2C_XLP9XX=y
CONFIG_I2C_RCAR=y

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_DIOLAN_U2C=y
# CONFIG_I2C_DLN2 is not set
CONFIG_I2C_CP2615=y
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
CONFIG_I2C_TINY_USB=y
CONFIG_I2C_VIPERBOARD=y

#
# Other I2C/SMBus bus drivers
#
# CONFIG_I2C_MLXCPLD is not set
CONFIG_I2C_CROS_EC_TUNNEL=y
CONFIG_I2C_VIRTIO=y
# end of I2C Hardware Bus support

CONFIG_I2C_SLAVE=y
# CONFIG_I2C_SLAVE_EEPROM is not set
# CONFIG_I2C_SLAVE_TESTUNIT is not set
CONFIG_I2C_DEBUG_CORE=y
CONFIG_I2C_DEBUG_ALGO=y
CONFIG_I2C_DEBUG_BUS=y
# end of I2C support

# CONFIG_I3C is not set
CONFIG_SPI=y
CONFIG_SPI_DEBUG=y
CONFIG_SPI_MASTER=y
# CONFIG_SPI_MEM is not set

#
# SPI Master Controller Drivers
#
CONFIG_SPI_ALTERA=y
CONFIG_SPI_ALTERA_CORE=y
CONFIG_SPI_AR934X=y
# CONFIG_SPI_ATH79 is not set
# CONFIG_SPI_ARMADA_3700 is not set
CONFIG_SPI_ASPEED_SMC=y
CONFIG_SPI_ATMEL=y
CONFIG_SPI_AT91_USART=y
CONFIG_SPI_ATMEL_QUADSPI=y
CONFIG_SPI_AXI_SPI_ENGINE=y
# CONFIG_SPI_BCM2835 is not set
# CONFIG_SPI_BCM2835AUX is not set
CONFIG_SPI_BCM63XX=y
CONFIG_SPI_BCM63XX_HSSPI=y
CONFIG_SPI_BCM_QSPI=y
CONFIG_SPI_BITBANG=y
CONFIG_SPI_CADENCE=y
CONFIG_SPI_CADENCE_QUADSPI=y
CONFIG_SPI_CLPS711X=y
# CONFIG_SPI_DESIGNWARE is not set
CONFIG_SPI_DLN2=y
CONFIG_SPI_EP93XX=y
CONFIG_SPI_FSL_LPSPI=y
# CONFIG_SPI_FSL_QUADSPI is not set
CONFIG_SPI_GXP=y
# CONFIG_SPI_HISI_KUNPENG is not set
CONFIG_SPI_HISI_SFC_V3XX=y
# CONFIG_SPI_NXP_FLEXSPI is not set
# CONFIG_SPI_GPIO is not set
# CONFIG_SPI_IMG_SPFI is not set
CONFIG_SPI_IMX=y
CONFIG_SPI_INGENIC=y
# CONFIG_SPI_JCORE is not set
# CONFIG_SPI_LP8841_RTC is not set
CONFIG_SPI_FSL_LIB=y
CONFIG_SPI_FSL_SPI=y
CONFIG_SPI_FSL_DSPI=y
CONFIG_SPI_MESON_SPICC=y
# CONFIG_SPI_MESON_SPIFC is not set
# CONFIG_SPI_MICROCHIP_CORE is not set
# CONFIG_SPI_MT65XX is not set
# CONFIG_SPI_MT7621 is not set
# CONFIG_SPI_MTK_NOR is not set
# CONFIG_SPI_NPCM_FIU is not set
CONFIG_SPI_NPCM_PSPI=y
CONFIG_SPI_LANTIQ_SSC=y
# CONFIG_SPI_OC_TINY is not set
# CONFIG_SPI_OMAP24XX is not set
CONFIG_SPI_TI_QSPI=y
CONFIG_SPI_OMAP_100K=y
CONFIG_SPI_ORION=y
# CONFIG_SPI_PIC32 is not set
CONFIG_SPI_PIC32_SQI=y
CONFIG_SPI_PXA2XX=y
# CONFIG_SPI_ROCKCHIP is not set
CONFIG_SPI_ROCKCHIP_SFC=y
CONFIG_SPI_RSPI=y
# CONFIG_SPI_QUP is not set
CONFIG_SPI_S3C64XX=y
CONFIG_SPI_SC18IS602=y
CONFIG_SPI_SH_MSIOF=y
CONFIG_SPI_SH=y
CONFIG_SPI_SH_HSPI=y
# CONFIG_SPI_SIFIVE is not set
CONFIG_SPI_SPRD=y
# CONFIG_SPI_SPRD_ADI is not set
CONFIG_SPI_STM32=y
CONFIG_SPI_ST_SSC4=y
CONFIG_SPI_SUN4I=y
CONFIG_SPI_SUN6I=y
CONFIG_SPI_SUNPLUS_SP7021=y
# CONFIG_SPI_SYNQUACER is not set
CONFIG_SPI_MXIC=y
# CONFIG_SPI_TEGRA210_QUAD is not set
CONFIG_SPI_TEGRA114=y
CONFIG_SPI_TEGRA20_SFLASH=y
CONFIG_SPI_TEGRA20_SLINK=y
CONFIG_SPI_UNIPHIER=y
CONFIG_SPI_XCOMM=y
# CONFIG_SPI_XILINX is not set
CONFIG_SPI_XLP=y
CONFIG_SPI_XTENSA_XTFPGA=y
CONFIG_SPI_ZYNQ_QSPI=y
CONFIG_SPI_ZYNQMP_GQSPI=y
CONFIG_SPI_AMD=y

#
# SPI Multiplexer support
#
CONFIG_SPI_MUX=y

#
# SPI Protocol Masters
#
# CONFIG_SPI_SPIDEV is not set
CONFIG_SPI_TLE62X0=y
# CONFIG_SPI_SLAVE is not set
CONFIG_SPI_DYNAMIC=y
CONFIG_SPMI=y
CONFIG_SPMI_HISI3670=y
CONFIG_SPMI_MSM_PMIC_ARB=y
CONFIG_SPMI_MTK_PMIF=y
CONFIG_HSI=y
CONFIG_HSI_BOARDINFO=y

#
# HSI controllers
#

#
# HSI clients
#
# CONFIG_HSI_CHAR is not set
# CONFIG_PPS is not set

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK_OPTIONAL=y

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
# end of PTP clock support

CONFIG_PINCTRL=y
CONFIG_GENERIC_PINCTRL_GROUPS=y
CONFIG_PINMUX=y
CONFIG_GENERIC_PINMUX_FUNCTIONS=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
CONFIG_DEBUG_PINCTRL=y
# CONFIG_PINCTRL_AMD is not set
CONFIG_PINCTRL_AS3722=y
# CONFIG_PINCTRL_AT91PIO4 is not set
# CONFIG_PINCTRL_AXP209 is not set
CONFIG_PINCTRL_BM1880=y
CONFIG_PINCTRL_DA850_PUPD=y
# CONFIG_PINCTRL_DA9062 is not set
CONFIG_PINCTRL_EQUILIBRIUM=y
CONFIG_PINCTRL_INGENIC=y
# CONFIG_PINCTRL_LPC18XX is not set
CONFIG_PINCTRL_MCP23S08_I2C=y
CONFIG_PINCTRL_MCP23S08_SPI=y
CONFIG_PINCTRL_MCP23S08=y
# CONFIG_PINCTRL_MICROCHIP_SGPIO is not set
# CONFIG_PINCTRL_OCELOT is not set
# CONFIG_PINCTRL_PISTACHIO is not set
# CONFIG_PINCTRL_ROCKCHIP is not set
CONFIG_PINCTRL_SINGLE=y
CONFIG_PINCTRL_STARFIVE=y
CONFIG_PINCTRL_STMFX=y
# CONFIG_PINCTRL_SX150X is not set
CONFIG_PINCTRL_OWL=y
CONFIG_PINCTRL_S500=y
CONFIG_PINCTRL_S700=y
CONFIG_PINCTRL_S900=y
CONFIG_PINCTRL_ASPEED=y
# CONFIG_PINCTRL_ASPEED_G4 is not set
CONFIG_PINCTRL_ASPEED_G5=y
CONFIG_PINCTRL_ASPEED_G6=y
CONFIG_PINCTRL_BCM281XX=y
# CONFIG_PINCTRL_BCM2835 is not set
CONFIG_PINCTRL_BCM4908=y
CONFIG_PINCTRL_BCM63XX=y
CONFIG_PINCTRL_BCM6318=y
# CONFIG_PINCTRL_BCM6328 is not set
# CONFIG_PINCTRL_BCM6358 is not set
# CONFIG_PINCTRL_BCM6362 is not set
CONFIG_PINCTRL_BCM6368=y
CONFIG_PINCTRL_BCM63268=y
# CONFIG_PINCTRL_IPROC_GPIO is not set
CONFIG_PINCTRL_CYGNUS_MUX=y
CONFIG_PINCTRL_NS=y
CONFIG_PINCTRL_NSP_GPIO=y
# CONFIG_PINCTRL_NS2_MUX is not set
# CONFIG_PINCTRL_NSP_MUX is not set
CONFIG_PINCTRL_BERLIN=y
CONFIG_PINCTRL_AS370=y
CONFIG_PINCTRL_BERLIN_BG4CT=y
CONFIG_PINCTRL_LOCHNAGAR=y
CONFIG_PINCTRL_MADERA=y
CONFIG_PINCTRL_CS47L15=y
CONFIG_PINCTRL_CS47L85=y
CONFIG_PINCTRL_CS47L90=y

#
# Intel pinctrl drivers
#
# end of Intel pinctrl drivers

#
# MediaTek pinctrl drivers
#
CONFIG_EINT_MTK=y
CONFIG_PINCTRL_MTK=y
CONFIG_PINCTRL_MTK_V2=y
CONFIG_PINCTRL_MTK_MOORE=y
CONFIG_PINCTRL_MTK_PARIS=y
# CONFIG_PINCTRL_MT2701 is not set
# CONFIG_PINCTRL_MT7623 is not set
# CONFIG_PINCTRL_MT7629 is not set
# CONFIG_PINCTRL_MT8135 is not set
CONFIG_PINCTRL_MT8127=y
CONFIG_PINCTRL_MT2712=y
CONFIG_PINCTRL_MT6765=y
CONFIG_PINCTRL_MT6779=y
CONFIG_PINCTRL_MT6795=y
CONFIG_PINCTRL_MT6797=y
CONFIG_PINCTRL_MT7622=y
# CONFIG_PINCTRL_MT7986 is not set
# CONFIG_PINCTRL_MT8167 is not set
# CONFIG_PINCTRL_MT8173 is not set
# CONFIG_PINCTRL_MT8183 is not set
# CONFIG_PINCTRL_MT8186 is not set
# CONFIG_PINCTRL_MT8192 is not set
CONFIG_PINCTRL_MT8195=y
CONFIG_PINCTRL_MT8365=y
CONFIG_PINCTRL_MT8516=y
# CONFIG_PINCTRL_MT6397 is not set
# end of MediaTek pinctrl drivers

CONFIG_PINCTRL_MESON=y
CONFIG_PINCTRL_WPCM450=y
# CONFIG_PINCTRL_NPCM7XX is not set
# CONFIG_PINCTRL_PXA25X is not set
# CONFIG_PINCTRL_PXA27X is not set
CONFIG_PINCTRL_MSM=y
CONFIG_PINCTRL_APQ8064=y
CONFIG_PINCTRL_APQ8084=y
# CONFIG_PINCTRL_IPQ4019 is not set
CONFIG_PINCTRL_IPQ8064=y
# CONFIG_PINCTRL_IPQ8074 is not set
CONFIG_PINCTRL_IPQ6018=y
CONFIG_PINCTRL_MSM8226=y
CONFIG_PINCTRL_MSM8660=y
CONFIG_PINCTRL_MSM8960=y
CONFIG_PINCTRL_MDM9607=y
CONFIG_PINCTRL_MDM9615=y
# CONFIG_PINCTRL_MSM8X74 is not set
# CONFIG_PINCTRL_MSM8909 is not set
CONFIG_PINCTRL_MSM8916=y
# CONFIG_PINCTRL_MSM8953 is not set
CONFIG_PINCTRL_MSM8976=y
# CONFIG_PINCTRL_MSM8994 is not set
# CONFIG_PINCTRL_MSM8996 is not set
CONFIG_PINCTRL_MSM8998=y
CONFIG_PINCTRL_QCM2290=y
CONFIG_PINCTRL_QCS404=y
CONFIG_PINCTRL_QCOM_SPMI_PMIC=y
CONFIG_PINCTRL_QCOM_SSBI_PMIC=y
CONFIG_PINCTRL_SC7180=y
CONFIG_PINCTRL_SC7280=y
CONFIG_PINCTRL_SC7280_LPASS_LPI=y
# CONFIG_PINCTRL_SC8180X is not set
# CONFIG_PINCTRL_SC8280XP is not set
CONFIG_PINCTRL_SDM660=y
CONFIG_PINCTRL_SDM845=y
CONFIG_PINCTRL_SDX55=y
CONFIG_PINCTRL_SM6115=y
CONFIG_PINCTRL_SM6125=y
CONFIG_PINCTRL_SM6350=y
CONFIG_PINCTRL_SM6375=y
CONFIG_PINCTRL_SDX65=y
# CONFIG_PINCTRL_SM8150 is not set
CONFIG_PINCTRL_SM8250=y
CONFIG_PINCTRL_SM8250_LPASS_LPI=y
CONFIG_PINCTRL_SM8350=y
CONFIG_PINCTRL_SM8450=y
CONFIG_PINCTRL_LPASS_LPI=y

#
# Renesas pinctrl drivers
#
# CONFIG_PINCTRL_RENESAS is not set
CONFIG_PINCTRL_SH_PFC=y
CONFIG_PINCTRL_SH_PFC_GPIO=y
CONFIG_PINCTRL_SH_FUNC_GPIO=y
# CONFIG_PINCTRL_PFC_EMEV2 is not set
# CONFIG_PINCTRL_PFC_R8A77995 is not set
# CONFIG_PINCTRL_PFC_R8A7794 is not set
CONFIG_PINCTRL_PFC_R8A77990=y
# CONFIG_PINCTRL_PFC_R8A7779 is not set
CONFIG_PINCTRL_PFC_R8A7790=y
CONFIG_PINCTRL_PFC_R8A77950=y
CONFIG_PINCTRL_PFC_R8A77951=y
CONFIG_PINCTRL_PFC_R8A7778=y
CONFIG_PINCTRL_PFC_R8A7793=y
# CONFIG_PINCTRL_PFC_R8A7791 is not set
CONFIG_PINCTRL_PFC_R8A77965=y
CONFIG_PINCTRL_PFC_R8A77960=y
# CONFIG_PINCTRL_PFC_R8A77961 is not set
# CONFIG_PINCTRL_PFC_R8A779F0 is not set
CONFIG_PINCTRL_PFC_R8A7792=y
CONFIG_PINCTRL_PFC_R8A77980=y
CONFIG_PINCTRL_PFC_R8A77970=y
CONFIG_PINCTRL_PFC_R8A779A0=y
CONFIG_PINCTRL_PFC_R8A779G0=y
# CONFIG_PINCTRL_PFC_R8A7740 is not set
# CONFIG_PINCTRL_PFC_R8A73A4 is not set
# CONFIG_PINCTRL_RZA1 is not set
# CONFIG_PINCTRL_RZA2 is not set
CONFIG_PINCTRL_RZG2L=y
# CONFIG_PINCTRL_PFC_R8A77470 is not set
# CONFIG_PINCTRL_PFC_R8A7745 is not set
# CONFIG_PINCTRL_PFC_R8A7742 is not set
CONFIG_PINCTRL_PFC_R8A7743=y
# CONFIG_PINCTRL_PFC_R8A7744 is not set
CONFIG_PINCTRL_PFC_R8A774C0=y
CONFIG_PINCTRL_PFC_R8A774E1=y
# CONFIG_PINCTRL_PFC_R8A774A1 is not set
CONFIG_PINCTRL_PFC_R8A774B1=y
# CONFIG_PINCTRL_RZN1 is not set
# CONFIG_PINCTRL_RZV2M is not set
# CONFIG_PINCTRL_PFC_SH7203 is not set
# CONFIG_PINCTRL_PFC_SH7264 is not set
CONFIG_PINCTRL_PFC_SH7269=y
# CONFIG_PINCTRL_PFC_SH7720 is not set
CONFIG_PINCTRL_PFC_SH7722=y
CONFIG_PINCTRL_PFC_SH7734=y
CONFIG_PINCTRL_PFC_SH7757=y
# CONFIG_PINCTRL_PFC_SH7785 is not set
CONFIG_PINCTRL_PFC_SH7786=y
# CONFIG_PINCTRL_PFC_SH73A0 is not set
# CONFIG_PINCTRL_PFC_SH7723 is not set
# CONFIG_PINCTRL_PFC_SH7724 is not set
CONFIG_PINCTRL_PFC_SHX3=y
# end of Renesas pinctrl drivers

# CONFIG_PINCTRL_EXYNOS is not set
# CONFIG_PINCTRL_S3C24XX is not set
# CONFIG_PINCTRL_S3C64XX is not set
# CONFIG_PINCTRL_SPRD_SC9860 is not set
CONFIG_PINCTRL_STM32=y
CONFIG_PINCTRL_STM32F429=y
CONFIG_PINCTRL_STM32F469=y
CONFIG_PINCTRL_STM32F746=y
CONFIG_PINCTRL_STM32F769=y
CONFIG_PINCTRL_STM32H743=y
CONFIG_PINCTRL_STM32MP135=y
# CONFIG_PINCTRL_STM32MP157 is not set
CONFIG_PINCTRL_TI_IODELAY=y
CONFIG_PINCTRL_UNIPHIER=y
# CONFIG_PINCTRL_UNIPHIER_LD4 is not set
# CONFIG_PINCTRL_UNIPHIER_PRO4 is not set
CONFIG_PINCTRL_UNIPHIER_SLD8=y
CONFIG_PINCTRL_UNIPHIER_PRO5=y
# CONFIG_PINCTRL_UNIPHIER_PXS2 is not set
CONFIG_PINCTRL_UNIPHIER_LD6B=y
# CONFIG_PINCTRL_UNIPHIER_LD11 is not set
CONFIG_PINCTRL_UNIPHIER_LD20=y
# CONFIG_PINCTRL_UNIPHIER_PXS3 is not set
CONFIG_PINCTRL_UNIPHIER_NX1=y
CONFIG_PINCTRL_VISCONTI=y
CONFIG_PINCTRL_TMPV7700=y
CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_OF_GPIO=y
CONFIG_GPIOLIB_IRQCHIP=y
CONFIG_DEBUG_GPIO=y
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_CDEV=y
# CONFIG_GPIO_CDEV_V1 is not set
CONFIG_GPIO_GENERIC=y
CONFIG_GPIO_REGMAP=y
CONFIG_GPIO_MAX730X=y

#
# Memory mapped GPIO drivers
#
CONFIG_GPIO_74XX_MMIO=y
CONFIG_GPIO_ALTERA=y
CONFIG_GPIO_ASPEED=y
# CONFIG_GPIO_ASPEED_SGPIO is not set
CONFIG_GPIO_ATH79=y
CONFIG_GPIO_RASPBERRYPI_EXP=y
CONFIG_GPIO_BCM_KONA=y
CONFIG_GPIO_BCM_XGS_IPROC=y
# CONFIG_GPIO_BRCMSTB is not set
CONFIG_GPIO_CADENCE=y
# CONFIG_GPIO_CLPS711X is not set
CONFIG_GPIO_DWAPB=y
CONFIG_GPIO_EIC_SPRD=y
CONFIG_GPIO_EM=y
CONFIG_GPIO_FTGPIO010=y
# CONFIG_GPIO_GENERIC_PLATFORM is not set
CONFIG_GPIO_GRGPIO=y
CONFIG_GPIO_HISI=y
CONFIG_GPIO_HLWD=y
CONFIG_GPIO_IOP=y
CONFIG_GPIO_LOGICVC=y
# CONFIG_GPIO_LPC18XX is not set
CONFIG_GPIO_LPC32XX=y
CONFIG_GPIO_MB86S7X=y
# CONFIG_GPIO_MPC8XXX is not set
CONFIG_GPIO_MT7621=y
CONFIG_GPIO_MXC=y
CONFIG_GPIO_MXS=y
# CONFIG_GPIO_PMIC_EIC_SPRD is not set
CONFIG_GPIO_PXA=y
CONFIG_GPIO_RCAR=y
CONFIG_GPIO_RDA=y
CONFIG_GPIO_ROCKCHIP=y
CONFIG_GPIO_SAMA5D2_PIOBU=y
CONFIG_GPIO_SIFIVE=y
# CONFIG_GPIO_SIOX is not set
# CONFIG_GPIO_SNPS_CREG is not set
# CONFIG_GPIO_SPRD is not set
# CONFIG_GPIO_STP_XWAY is not set
CONFIG_GPIO_SYSCON=y
# CONFIG_GPIO_TEGRA is not set
CONFIG_GPIO_TEGRA186=y
# CONFIG_GPIO_TS4800 is not set
CONFIG_GPIO_UNIPHIER=y
# CONFIG_GPIO_VISCONTI is not set
CONFIG_GPIO_XGENE_SB=y
CONFIG_GPIO_XILINX=y
CONFIG_GPIO_XLP=y
CONFIG_GPIO_AMD_FCH=y
CONFIG_GPIO_IDT3243X=y
# end of Memory mapped GPIO drivers

#
# I2C GPIO expanders
#
# CONFIG_GPIO_ADP5588 is not set
CONFIG_GPIO_ADNP=y
CONFIG_GPIO_GW_PLD=y
CONFIG_GPIO_MAX7300=y
CONFIG_GPIO_MAX732X=y
# CONFIG_GPIO_MAX732X_IRQ is not set
CONFIG_GPIO_PCA953X=y
CONFIG_GPIO_PCA953X_IRQ=y
# CONFIG_GPIO_PCA9570 is not set
CONFIG_GPIO_PCF857X=y
CONFIG_GPIO_TPIC2810=y
CONFIG_GPIO_TS4900=y
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
CONFIG_GPIO_ARIZONA=y
CONFIG_GPIO_BD71815=y
# CONFIG_GPIO_BD71828 is not set
CONFIG_GPIO_BD9571MWV=y
CONFIG_GPIO_DA9052=y
CONFIG_GPIO_DA9055=y
CONFIG_GPIO_DLN2=y
CONFIG_GPIO_KEMPLD=y
CONFIG_GPIO_LP3943=y
# CONFIG_GPIO_LP87565 is not set
CONFIG_GPIO_MADERA=y
CONFIG_GPIO_MAX77650=y
CONFIG_GPIO_SL28CPLD=y
# CONFIG_GPIO_STMPE is not set
CONFIG_GPIO_TC3589X=y
# CONFIG_GPIO_TPS65218 is not set
# CONFIG_GPIO_TPS6586X is not set
CONFIG_GPIO_TPS65912=y
CONFIG_GPIO_TQMX86=y
CONFIG_GPIO_WM831X=y
# CONFIG_GPIO_WM8994 is not set
# end of MFD GPIO expanders

#
# SPI GPIO expanders
#
# CONFIG_GPIO_74X164 is not set
CONFIG_GPIO_MAX3191X=y
CONFIG_GPIO_MAX7301=y
# CONFIG_GPIO_MC33880 is not set
CONFIG_GPIO_PISOSR=y
CONFIG_GPIO_XRA1403=y
CONFIG_GPIO_MOXTET=y
# end of SPI GPIO expanders

#
# USB GPIO expanders
#
# CONFIG_GPIO_VIPERBOARD is not set
# end of USB GPIO expanders

#
# Virtual GPIO drivers
#
CONFIG_GPIO_AGGREGATOR=y
# CONFIG_GPIO_MOCKUP is not set
CONFIG_GPIO_VIRTIO=y
CONFIG_GPIO_SIM=y
# end of Virtual GPIO drivers

CONFIG_W1=y

#
# 1-wire Bus Masters
#
CONFIG_W1_MASTER_DS2490=y
CONFIG_W1_MASTER_DS2482=y
CONFIG_W1_MASTER_MXC=y
CONFIG_W1_MASTER_DS1WM=y
# CONFIG_W1_MASTER_GPIO is not set
# CONFIG_W1_MASTER_SGI is not set
# end of 1-wire Bus Masters

#
# 1-wire Slaves
#
CONFIG_W1_SLAVE_THERM=y
# CONFIG_W1_SLAVE_SMEM is not set
CONFIG_W1_SLAVE_DS2405=y
# CONFIG_W1_SLAVE_DS2408 is not set
CONFIG_W1_SLAVE_DS2413=y
CONFIG_W1_SLAVE_DS2406=y
CONFIG_W1_SLAVE_DS2423=y
CONFIG_W1_SLAVE_DS2805=y
CONFIG_W1_SLAVE_DS2430=y
# CONFIG_W1_SLAVE_DS2431 is not set
# CONFIG_W1_SLAVE_DS2433 is not set
CONFIG_W1_SLAVE_DS2438=y
CONFIG_W1_SLAVE_DS250X=y
CONFIG_W1_SLAVE_DS2780=y
CONFIG_W1_SLAVE_DS2781=y
# CONFIG_W1_SLAVE_DS28E04 is not set
CONFIG_W1_SLAVE_DS28E17=y
# end of 1-wire Slaves

CONFIG_POWER_RESET=y
CONFIG_POWER_RESET_AS3722=y
CONFIG_POWER_RESET_ATC260X=y
# CONFIG_POWER_RESET_BRCMKONA is not set
CONFIG_POWER_RESET_BRCMSTB=y
CONFIG_POWER_RESET_GEMINI_POWEROFF=y
CONFIG_POWER_RESET_GPIO=y
CONFIG_POWER_RESET_GPIO_RESTART=y
# CONFIG_POWER_RESET_OCELOT_RESET is not set
# CONFIG_POWER_RESET_LTC2952 is not set
# CONFIG_POWER_RESET_REGULATOR is not set
CONFIG_POWER_RESET_RESTART=y
CONFIG_POWER_RESET_KEYSTONE=y
CONFIG_POWER_RESET_SYSCON=y
CONFIG_POWER_RESET_SYSCON_POWEROFF=y
CONFIG_POWER_RESET_RMOBILE=y
# CONFIG_SYSCON_REBOOT_MODE is not set
CONFIG_POWER_RESET_SC27XX=y
# CONFIG_NVMEM_REBOOT_MODE is not set
CONFIG_POWER_SUPPLY=y
CONFIG_POWER_SUPPLY_DEBUG=y
CONFIG_POWER_SUPPLY_HWMON=y
# CONFIG_PDA_POWER is not set
# CONFIG_IP5XXX_POWER is not set
CONFIG_MAX8925_POWER=y
# CONFIG_WM831X_BACKUP is not set
CONFIG_WM831X_POWER=y
CONFIG_TEST_POWER=y
CONFIG_CHARGER_ADP5061=y
# CONFIG_BATTERY_ACT8945A is not set
CONFIG_BATTERY_CW2015=y
# CONFIG_BATTERY_DS2760 is not set
CONFIG_BATTERY_DS2780=y
# CONFIG_BATTERY_DS2781 is not set
CONFIG_BATTERY_DS2782=y
CONFIG_BATTERY_SAMSUNG_SDI=y
CONFIG_BATTERY_SBS=y
CONFIG_CHARGER_SBS=y
CONFIG_MANAGER_SBS=y
# CONFIG_BATTERY_BQ27XXX is not set
CONFIG_BATTERY_DA9052=y
CONFIG_BATTERY_DA9150=y
CONFIG_BATTERY_MAX17040=y
CONFIG_BATTERY_MAX17042=y
# CONFIG_BATTERY_MAX1721X is not set
CONFIG_CHARGER_PCF50633=y
# CONFIG_CHARGER_ISP1704 is not set
CONFIG_CHARGER_MAX8903=y
CONFIG_CHARGER_LP8727=y
CONFIG_CHARGER_GPIO=y
CONFIG_CHARGER_MANAGER=y
CONFIG_CHARGER_LT3651=y
# CONFIG_CHARGER_LTC4162L is not set
# CONFIG_CHARGER_MAX14577 is not set
CONFIG_CHARGER_DETECTOR_MAX14656=y
# CONFIG_CHARGER_MAX77650 is not set
CONFIG_CHARGER_MAX77693=y
CONFIG_CHARGER_MAX77976=y
CONFIG_CHARGER_MAX8997=y
CONFIG_CHARGER_MAX8998=y
# CONFIG_CHARGER_MT6360 is not set
# CONFIG_CHARGER_QCOM_SMBB is not set
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_CHARGER_BQ24190 is not set
CONFIG_CHARGER_BQ24257=y
# CONFIG_CHARGER_BQ24735 is not set
CONFIG_CHARGER_BQ2515X=y
CONFIG_CHARGER_BQ25890=y
CONFIG_CHARGER_BQ25980=y
CONFIG_CHARGER_BQ256XX=y
CONFIG_CHARGER_SMB347=y
CONFIG_CHARGER_TPS65217=y
CONFIG_BATTERY_GAUGE_LTC2941=y
CONFIG_BATTERY_GOLDFISH=y
CONFIG_BATTERY_RT5033=y
# CONFIG_CHARGER_RT9455 is not set
CONFIG_CHARGER_CROS_USBPD=y
CONFIG_CHARGER_CROS_PCHG=y
CONFIG_CHARGER_SC2731=y
CONFIG_CHARGER_UCS1002=y
CONFIG_CHARGER_BD99954=y
CONFIG_BATTERY_ACER_A500=y
# CONFIG_BATTERY_UG3105 is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_AD7314=y
CONFIG_SENSORS_AD7414=y
# CONFIG_SENSORS_AD7418 is not set
CONFIG_SENSORS_ADM1025=y
CONFIG_SENSORS_ADM1026=y
CONFIG_SENSORS_ADM1029=y
# CONFIG_SENSORS_ADM1031 is not set
CONFIG_SENSORS_ADM1177=y
CONFIG_SENSORS_ADM9240=y
CONFIG_SENSORS_ADT7X10=y
# CONFIG_SENSORS_ADT7310 is not set
CONFIG_SENSORS_ADT7410=y
# CONFIG_SENSORS_ADT7411 is not set
CONFIG_SENSORS_ADT7462=y
CONFIG_SENSORS_ADT7470=y
CONFIG_SENSORS_ADT7475=y
# CONFIG_SENSORS_AHT10 is not set
# CONFIG_SENSORS_AQUACOMPUTER_D5NEXT is not set
# CONFIG_SENSORS_AS370 is not set
# CONFIG_SENSORS_ASC7621 is not set
# CONFIG_SENSORS_AXI_FAN_CONTROL is not set
# CONFIG_SENSORS_ARM_SCMI is not set
CONFIG_SENSORS_ARM_SCPI=y
# CONFIG_SENSORS_ASB100 is not set
# CONFIG_SENSORS_ASPEED is not set
CONFIG_SENSORS_ATXP1=y
# CONFIG_SENSORS_BT1_PVT is not set
CONFIG_SENSORS_CORSAIR_CPRO=y
CONFIG_SENSORS_CORSAIR_PSU=y
# CONFIG_SENSORS_DS620 is not set
# CONFIG_SENSORS_DS1621 is not set
CONFIG_SENSORS_DA9052_ADC=y
CONFIG_SENSORS_DA9055=y
# CONFIG_SENSORS_SPARX5 is not set
CONFIG_SENSORS_F71805F=y
CONFIG_SENSORS_F71882FG=y
# CONFIG_SENSORS_F75375S is not set
CONFIG_SENSORS_MC13783_ADC=y
CONFIG_SENSORS_FSCHMD=y
CONFIG_SENSORS_GL518SM=y
# CONFIG_SENSORS_GL520SM is not set
# CONFIG_SENSORS_G760A is not set
# CONFIG_SENSORS_G762 is not set
# CONFIG_SENSORS_GPIO_FAN is not set
CONFIG_SENSORS_HIH6130=y
# CONFIG_SENSORS_IT87 is not set
CONFIG_SENSORS_JC42=y
CONFIG_SENSORS_POWR1220=y
# CONFIG_SENSORS_LAN966X is not set
CONFIG_SENSORS_LINEAGE=y
CONFIG_SENSORS_LOCHNAGAR=y
CONFIG_SENSORS_LTC2945=y
CONFIG_SENSORS_LTC2947=y
CONFIG_SENSORS_LTC2947_I2C=y
# CONFIG_SENSORS_LTC2947_SPI is not set
CONFIG_SENSORS_LTC2990=y
# CONFIG_SENSORS_LTC2992 is not set
CONFIG_SENSORS_LTC4151=y
# CONFIG_SENSORS_LTC4215 is not set
# CONFIG_SENSORS_LTC4222 is not set
CONFIG_SENSORS_LTC4245=y
CONFIG_SENSORS_LTC4260=y
CONFIG_SENSORS_LTC4261=y
CONFIG_SENSORS_MAX1111=y
CONFIG_SENSORS_MAX127=y
# CONFIG_SENSORS_MAX16065 is not set
CONFIG_SENSORS_MAX1619=y
CONFIG_SENSORS_MAX1668=y
# CONFIG_SENSORS_MAX197 is not set
# CONFIG_SENSORS_MAX31722 is not set
CONFIG_SENSORS_MAX31730=y
CONFIG_SENSORS_MAX6620=y
CONFIG_SENSORS_MAX6621=y
# CONFIG_SENSORS_MAX6639 is not set
CONFIG_SENSORS_MAX6650=y
# CONFIG_SENSORS_MAX6697 is not set
# CONFIG_SENSORS_MAX31790 is not set
CONFIG_SENSORS_MCP3021=y
# CONFIG_SENSORS_MLXREG_FAN is not set
CONFIG_SENSORS_TC654=y
CONFIG_SENSORS_TPS23861=y
# CONFIG_SENSORS_MENF21BMC_HWMON is not set
CONFIG_SENSORS_MR75203=y
CONFIG_SENSORS_ADCXX=y
CONFIG_SENSORS_LM63=y
CONFIG_SENSORS_LM70=y
CONFIG_SENSORS_LM73=y
CONFIG_SENSORS_LM75=y
CONFIG_SENSORS_LM77=y
CONFIG_SENSORS_LM78=y
# CONFIG_SENSORS_LM80 is not set
# CONFIG_SENSORS_LM83 is not set
CONFIG_SENSORS_LM85=y
CONFIG_SENSORS_LM87=y
CONFIG_SENSORS_LM90=y
CONFIG_SENSORS_LM92=y
CONFIG_SENSORS_LM93=y
# CONFIG_SENSORS_LM95234 is not set
CONFIG_SENSORS_LM95241=y
# CONFIG_SENSORS_LM95245 is not set
CONFIG_SENSORS_PC87360=y
CONFIG_SENSORS_PC87427=y
# CONFIG_SENSORS_NCT6683 is not set
CONFIG_SENSORS_NCT6775_CORE=y
CONFIG_SENSORS_NCT6775=y
# CONFIG_SENSORS_NCT6775_I2C is not set
# CONFIG_SENSORS_NCT7802 is not set
# CONFIG_SENSORS_NPCM7XX is not set
CONFIG_SENSORS_NSA320=y
CONFIG_SENSORS_NZXT_KRAKEN2=y
# CONFIG_SENSORS_NZXT_SMART2 is not set
CONFIG_SENSORS_OCC_P8_I2C=y
CONFIG_SENSORS_OCC=y
CONFIG_SENSORS_PCF8591=y
CONFIG_SENSORS_PECI_CPUTEMP=y
CONFIG_SENSORS_PECI_DIMMTEMP=y
CONFIG_SENSORS_PECI=y
CONFIG_PMBUS=y
# CONFIG_SENSORS_PMBUS is not set
# CONFIG_SENSORS_ADM1266 is not set
# CONFIG_SENSORS_ADM1275 is not set
# CONFIG_SENSORS_BEL_PFE is not set
# CONFIG_SENSORS_BPA_RS600 is not set
CONFIG_SENSORS_DELTA_AHE50DC_FAN=y
# CONFIG_SENSORS_FSP_3Y is not set
CONFIG_SENSORS_IBM_CFFPS=y
CONFIG_SENSORS_DPS920AB=y
# CONFIG_SENSORS_INSPUR_IPSPS is not set
CONFIG_SENSORS_IR35221=y
CONFIG_SENSORS_IR36021=y
CONFIG_SENSORS_IR38064=y
# CONFIG_SENSORS_IR38064_REGULATOR is not set
# CONFIG_SENSORS_IRPS5401 is not set
CONFIG_SENSORS_ISL68137=y
CONFIG_SENSORS_LM25066=y
# CONFIG_SENSORS_LM25066_REGULATOR is not set
# CONFIG_SENSORS_LT7182S is not set
CONFIG_SENSORS_LTC2978=y
# CONFIG_SENSORS_LTC2978_REGULATOR is not set
CONFIG_SENSORS_LTC3815=y
CONFIG_SENSORS_MAX15301=y
# CONFIG_SENSORS_MAX16064 is not set
CONFIG_SENSORS_MAX16601=y
# CONFIG_SENSORS_MAX20730 is not set
CONFIG_SENSORS_MAX20751=y
CONFIG_SENSORS_MAX31785=y
CONFIG_SENSORS_MAX34440=y
CONFIG_SENSORS_MAX8688=y
CONFIG_SENSORS_MP2888=y
CONFIG_SENSORS_MP2975=y
# CONFIG_SENSORS_MP5023 is not set
# CONFIG_SENSORS_PIM4328 is not set
CONFIG_SENSORS_PLI1209BC=y
CONFIG_SENSORS_PLI1209BC_REGULATOR=y
# CONFIG_SENSORS_PM6764TR is not set
# CONFIG_SENSORS_PXE1610 is not set
CONFIG_SENSORS_Q54SJ108A2=y
CONFIG_SENSORS_STPDDC60=y
CONFIG_SENSORS_TPS40422=y
CONFIG_SENSORS_TPS53679=y
CONFIG_SENSORS_UCD9000=y
CONFIG_SENSORS_UCD9200=y
# CONFIG_SENSORS_XDPE152 is not set
# CONFIG_SENSORS_XDPE122 is not set
CONFIG_SENSORS_ZL6100=y
# CONFIG_SENSORS_PWM_FAN is not set
# CONFIG_SENSORS_RASPBERRYPI_HWMON is not set
# CONFIG_SENSORS_SL28CPLD is not set
CONFIG_SENSORS_SBTSI=y
CONFIG_SENSORS_SBRMI=y
CONFIG_SENSORS_SHT15=y
CONFIG_SENSORS_SHT21=y
CONFIG_SENSORS_SHT3x=y
CONFIG_SENSORS_SHT4x=y
CONFIG_SENSORS_SHTC1=y
# CONFIG_SENSORS_SY7636A is not set
CONFIG_SENSORS_DME1737=y
CONFIG_SENSORS_EMC1403=y
# CONFIG_SENSORS_EMC2103 is not set
CONFIG_SENSORS_EMC6W201=y
CONFIG_SENSORS_SMSC47M1=y
CONFIG_SENSORS_SMSC47M192=y
CONFIG_SENSORS_SMSC47B397=y
CONFIG_SENSORS_STTS751=y
CONFIG_SENSORS_SMM665=y
# CONFIG_SENSORS_ADC128D818 is not set
# CONFIG_SENSORS_ADS7828 is not set
CONFIG_SENSORS_ADS7871=y
CONFIG_SENSORS_AMC6821=y
CONFIG_SENSORS_INA209=y
CONFIG_SENSORS_INA2XX=y
CONFIG_SENSORS_INA238=y
CONFIG_SENSORS_INA3221=y
CONFIG_SENSORS_TC74=y
CONFIG_SENSORS_THMC50=y
CONFIG_SENSORS_TMP102=y
# CONFIG_SENSORS_TMP103 is not set
CONFIG_SENSORS_TMP108=y
CONFIG_SENSORS_TMP401=y
CONFIG_SENSORS_TMP421=y
CONFIG_SENSORS_TMP464=y
CONFIG_SENSORS_TMP513=y
CONFIG_SENSORS_VT1211=y
CONFIG_SENSORS_W83773G=y
CONFIG_SENSORS_W83781D=y
CONFIG_SENSORS_W83791D=y
CONFIG_SENSORS_W83792D=y
CONFIG_SENSORS_W83793=y
CONFIG_SENSORS_W83795=y
CONFIG_SENSORS_W83795_FANCTRL=y
CONFIG_SENSORS_W83L785TS=y
CONFIG_SENSORS_W83L786NG=y
# CONFIG_SENSORS_W83627HF is not set
# CONFIG_SENSORS_W83627EHF is not set
CONFIG_SENSORS_WM831X=y
CONFIG_THERMAL=y
CONFIG_THERMAL_STATISTICS=y
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
# CONFIG_THERMAL_HWMON is not set
CONFIG_THERMAL_OF=y
# CONFIG_THERMAL_WRITABLE_TRIPS is not set
# CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE is not set
CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE=y
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_CPU_THERMAL is not set
CONFIG_DEVFREQ_THERMAL=y
# CONFIG_THERMAL_EMULATION is not set
# CONFIG_THERMAL_MMIO is not set
CONFIG_HISI_THERMAL=y
# CONFIG_IMX_THERMAL is not set
# CONFIG_IMX8MM_THERMAL is not set
# CONFIG_K3_THERMAL is not set
# CONFIG_QORIQ_THERMAL is not set
CONFIG_SPEAR_THERMAL=y
CONFIG_SUN8I_THERMAL=y
# CONFIG_ROCKCHIP_THERMAL is not set
CONFIG_RCAR_THERMAL=y
CONFIG_RCAR_GEN3_THERMAL=y
# CONFIG_RZG2L_THERMAL is not set
# CONFIG_KIRKWOOD_THERMAL is not set
CONFIG_DOVE_THERMAL=y
CONFIG_ARMADA_THERMAL=y
# CONFIG_DA9062_THERMAL is not set
# CONFIG_MTK_THERMAL is not set

#
# Intel thermal drivers
#

#
# ACPI INT340X thermal drivers
#
# end of ACPI INT340X thermal drivers
# end of Intel thermal drivers

#
# Broadcom thermal drivers
#
CONFIG_BCM2711_THERMAL=y
CONFIG_BCM2835_THERMAL=y
# CONFIG_BRCMSTB_THERMAL is not set
CONFIG_BCM_NS_THERMAL=y
CONFIG_BCM_SR_THERMAL=y
# end of Broadcom thermal drivers

#
# Texas Instruments thermal drivers
#
CONFIG_TI_SOC_THERMAL=y
# CONFIG_TI_THERMAL is not set
CONFIG_OMAP3_THERMAL=y
CONFIG_OMAP4_THERMAL=y
# CONFIG_OMAP5_THERMAL is not set
# CONFIG_DRA752_THERMAL is not set
# end of Texas Instruments thermal drivers

#
# Samsung thermal drivers
#
CONFIG_EXYNOS_THERMAL=y
# end of Samsung thermal drivers

#
# NVIDIA Tegra thermal drivers
#
CONFIG_TEGRA_SOCTHERM=y
CONFIG_TEGRA_BPMP_THERMAL=y
# CONFIG_TEGRA30_TSENSOR is not set
# end of NVIDIA Tegra thermal drivers

#
# Qualcomm thermal drivers
#
# end of Qualcomm thermal drivers

# CONFIG_UNIPHIER_THERMAL is not set
CONFIG_SPRD_THERMAL=y
CONFIG_KHADAS_MCU_FAN_THERMAL=y
# CONFIG_WATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=y
CONFIG_SSB_SDIOHOST_POSSIBLE=y
CONFIG_SSB_SDIOHOST=y
CONFIG_SSB_DRIVER_GPIO=y
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=y
# CONFIG_BCMA_HOST_SOC is not set
# CONFIG_BCMA_DRIVER_MIPS is not set
CONFIG_BCMA_DRIVER_GMAC_CMN=y
# CONFIG_BCMA_DRIVER_GPIO is not set
CONFIG_BCMA_DEBUG=y

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
CONFIG_MFD_ACT8945A=y
CONFIG_MFD_SUN4I_GPADC=y
CONFIG_MFD_AS3711=y
CONFIG_MFD_AS3722=y
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
CONFIG_MFD_AT91_USART=y
CONFIG_MFD_ATMEL_FLEXCOM=y
CONFIG_MFD_ATMEL_HLCDC=y
CONFIG_MFD_BCM590XX=y
CONFIG_MFD_BD9571MWV=y
CONFIG_MFD_AXP20X=y
CONFIG_MFD_AXP20X_I2C=y
CONFIG_MFD_CROS_EC_DEV=y
CONFIG_MFD_MADERA=y
# CONFIG_MFD_MADERA_I2C is not set
CONFIG_MFD_MADERA_SPI=y
CONFIG_MFD_CS47L15=y
# CONFIG_MFD_CS47L35 is not set
CONFIG_MFD_CS47L85=y
CONFIG_MFD_CS47L90=y
# CONFIG_MFD_CS47L92 is not set
# CONFIG_MFD_ASIC3 is not set
# CONFIG_PMIC_DA903X is not set
CONFIG_PMIC_DA9052=y
# CONFIG_MFD_DA9052_SPI is not set
CONFIG_MFD_DA9052_I2C=y
CONFIG_MFD_DA9055=y
CONFIG_MFD_DA9062=y
CONFIG_MFD_DA9063=y
CONFIG_MFD_DA9150=y
CONFIG_MFD_DLN2=y
# CONFIG_MFD_ENE_KB3930 is not set
# CONFIG_MFD_EXYNOS_LPASS is not set
# CONFIG_MFD_GATEWORKS_GSC is not set
CONFIG_MFD_MC13XXX=y
CONFIG_MFD_MC13XXX_SPI=y
CONFIG_MFD_MC13XXX_I2C=y
# CONFIG_MFD_MP2629 is not set
# CONFIG_MFD_MXS_LRADC is not set
CONFIG_MFD_MX25_TSADC=y
# CONFIG_MFD_HI6421_PMIC is not set
CONFIG_MFD_HI6421_SPMI=y
# CONFIG_MFD_HI655X_PMIC is not set
# CONFIG_HTC_PASIC3 is not set
# CONFIG_HTC_I2CPLD is not set
# CONFIG_MFD_IQS62X is not set
CONFIG_MFD_KEMPLD=y
CONFIG_MFD_88PM800=y
CONFIG_MFD_88PM805=y
# CONFIG_MFD_88PM860X is not set
CONFIG_MFD_MAX14577=y
# CONFIG_MFD_MAX77620 is not set
CONFIG_MFD_MAX77650=y
CONFIG_MFD_MAX77686=y
CONFIG_MFD_MAX77693=y
# CONFIG_MFD_MAX77714 is not set
# CONFIG_MFD_MAX77843 is not set
CONFIG_MFD_MAX8907=y
CONFIG_MFD_MAX8925=y
CONFIG_MFD_MAX8997=y
CONFIG_MFD_MAX8998=y
CONFIG_MFD_MT6360=y
# CONFIG_MFD_MT6397 is not set
CONFIG_MFD_MENF21BMC=y
# CONFIG_EZX_PCAP is not set
CONFIG_MFD_CPCAP=y
CONFIG_MFD_VIPERBOARD=y
# CONFIG_MFD_NTXEC is not set
CONFIG_MFD_RETU=y
CONFIG_MFD_PCF50633=y
CONFIG_PCF50633_ADC=y
CONFIG_PCF50633_GPIO=y
# CONFIG_MFD_PM8XXX is not set
CONFIG_MFD_SPMI_PMIC=y
CONFIG_MFD_RT4831=y
CONFIG_MFD_RT5033=y
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_RK808 is not set
CONFIG_MFD_RN5T618=y
CONFIG_MFD_SEC_CORE=y
CONFIG_MFD_SI476X_CORE=y
CONFIG_MFD_SIMPLE_MFD_I2C=y
CONFIG_MFD_SL28CPLD=y
CONFIG_MFD_SM501=y
# CONFIG_MFD_SM501_GPIO is not set
# CONFIG_MFD_SKY81452 is not set
CONFIG_MFD_SC27XX_PMIC=y
CONFIG_ABX500_CORE=y
CONFIG_MFD_STMPE=y

#
# STMicroelectronics STMPE Interface Drivers
#
CONFIG_STMPE_I2C=y
# CONFIG_STMPE_SPI is not set
# end of STMicroelectronics STMPE Interface Drivers

CONFIG_MFD_SUN6I_PRCM=y
CONFIG_MFD_SYSCON=y
CONFIG_MFD_TI_AM335X_TSCADC=y
CONFIG_MFD_LP3943=y
# CONFIG_MFD_LP8788 is not set
# CONFIG_MFD_TI_LMU is not set
# CONFIG_MFD_PALMAS is not set
# CONFIG_TPS6105X is not set
CONFIG_TPS65010=y
CONFIG_TPS6507X=y
# CONFIG_MFD_TPS65086 is not set
# CONFIG_MFD_TPS65090 is not set
CONFIG_MFD_TPS65217=y
# CONFIG_MFD_TI_LP873X is not set
CONFIG_MFD_TI_LP87565=y
CONFIG_MFD_TPS65218=y
CONFIG_MFD_TPS6586X=y
# CONFIG_MFD_TPS65910 is not set
CONFIG_MFD_TPS65912=y
# CONFIG_MFD_TPS65912_I2C is not set
CONFIG_MFD_TPS65912_SPI=y
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
CONFIG_MFD_WL1273_CORE=y
CONFIG_MFD_LM3533=y
CONFIG_MFD_TC3589X=y
# CONFIG_MFD_TQMX86 is not set
CONFIG_MFD_LOCHNAGAR=y
CONFIG_MFD_ARIZONA=y
CONFIG_MFD_ARIZONA_I2C=y
# CONFIG_MFD_ARIZONA_SPI is not set
CONFIG_MFD_CS47L24=y
# CONFIG_MFD_WM5102 is not set
# CONFIG_MFD_WM5110 is not set
# CONFIG_MFD_WM8997 is not set
CONFIG_MFD_WM8998=y
CONFIG_MFD_WM8400=y
CONFIG_MFD_WM831X=y
# CONFIG_MFD_WM831X_I2C is not set
CONFIG_MFD_WM831X_SPI=y
# CONFIG_MFD_WM8350_I2C is not set
CONFIG_MFD_WM8994=y
# CONFIG_MFD_STW481X is not set
# CONFIG_MFD_ROHM_BD718XX is not set
CONFIG_MFD_ROHM_BD71828=y
# CONFIG_MFD_ROHM_BD957XMUF is not set
CONFIG_MFD_STM32_LPTIMER=y
# CONFIG_MFD_STM32_TIMERS is not set
CONFIG_MFD_STPMIC1=y
CONFIG_MFD_STMFX=y
# CONFIG_MFD_WCD934X is not set
CONFIG_MFD_ATC260X=y
CONFIG_MFD_ATC260X_I2C=y
CONFIG_MFD_KHADAS_MCU=y
CONFIG_MFD_ACER_A500_EC=y
CONFIG_MFD_QCOM_PM8008=y
# CONFIG_MFD_INTEL_M10_BMC is not set
CONFIG_MFD_RSMU_I2C=y
CONFIG_MFD_RSMU_SPI=y
# end of Multifunction device drivers

CONFIG_REGULATOR=y
# CONFIG_REGULATOR_DEBUG is not set
CONFIG_REGULATOR_FIXED_VOLTAGE=y
# CONFIG_REGULATOR_VIRTUAL_CONSUMER is not set
CONFIG_REGULATOR_USERSPACE_CONSUMER=y
CONFIG_REGULATOR_88PG86X=y
CONFIG_REGULATOR_88PM800=y
# CONFIG_REGULATOR_ACT8865 is not set
CONFIG_REGULATOR_ACT8945A=y
# CONFIG_REGULATOR_AD5398 is not set
CONFIG_REGULATOR_ANATOP=y
# CONFIG_REGULATOR_ARM_SCMI is not set
CONFIG_REGULATOR_AS3711=y
# CONFIG_REGULATOR_AS3722 is not set
CONFIG_REGULATOR_ATC260X=y
CONFIG_REGULATOR_AXP20X=y
# CONFIG_REGULATOR_BCM590XX is not set
# CONFIG_REGULATOR_BD71815 is not set
# CONFIG_REGULATOR_BD71828 is not set
# CONFIG_REGULATOR_BD9571MWV is not set
# CONFIG_REGULATOR_CPCAP is not set
CONFIG_REGULATOR_CROS_EC=y
CONFIG_REGULATOR_DA9052=y
CONFIG_REGULATOR_DA9055=y
CONFIG_REGULATOR_DA9062=y
CONFIG_REGULATOR_DA9063=y
CONFIG_REGULATOR_DA9121=y
CONFIG_REGULATOR_DA9210=y
# CONFIG_REGULATOR_DA9211 is not set
CONFIG_REGULATOR_FAN53555=y
CONFIG_REGULATOR_FAN53880=y
CONFIG_REGULATOR_GPIO=y
# CONFIG_REGULATOR_HI6421V600 is not set
CONFIG_REGULATOR_ISL9305=y
# CONFIG_REGULATOR_ISL6271A is not set
CONFIG_REGULATOR_LOCHNAGAR=y
CONFIG_REGULATOR_LP3971=y
CONFIG_REGULATOR_LP3972=y
CONFIG_REGULATOR_LP872X=y
CONFIG_REGULATOR_LP8755=y
CONFIG_REGULATOR_LP87565=y
CONFIG_REGULATOR_LTC3589=y
CONFIG_REGULATOR_LTC3676=y
CONFIG_REGULATOR_MAX14577=y
CONFIG_REGULATOR_MAX1586=y
CONFIG_REGULATOR_MAX77620=y
CONFIG_REGULATOR_MAX77650=y
CONFIG_REGULATOR_MAX8649=y
CONFIG_REGULATOR_MAX8660=y
CONFIG_REGULATOR_MAX8893=y
# CONFIG_REGULATOR_MAX8907 is not set
CONFIG_REGULATOR_MAX8925=y
CONFIG_REGULATOR_MAX8952=y
CONFIG_REGULATOR_MAX8973=y
CONFIG_REGULATOR_MAX8997=y
CONFIG_REGULATOR_MAX8998=y
# CONFIG_REGULATOR_MAX20086 is not set
CONFIG_REGULATOR_MAX77686=y
CONFIG_REGULATOR_MAX77693=y
# CONFIG_REGULATOR_MAX77802 is not set
CONFIG_REGULATOR_MAX77826=y
# CONFIG_REGULATOR_MC13783 is not set
# CONFIG_REGULATOR_MC13892 is not set
CONFIG_REGULATOR_MCP16502=y
CONFIG_REGULATOR_MP5416=y
# CONFIG_REGULATOR_MP8859 is not set
CONFIG_REGULATOR_MP886X=y
# CONFIG_REGULATOR_MPQ7920 is not set
CONFIG_REGULATOR_MT6311=y
CONFIG_REGULATOR_MT6315=y
# CONFIG_REGULATOR_MT6360 is not set
CONFIG_REGULATOR_MT6380=y
CONFIG_REGULATOR_PBIAS=y
# CONFIG_REGULATOR_PCA9450 is not set
# CONFIG_REGULATOR_PCF50633 is not set
CONFIG_REGULATOR_PF8X00=y
CONFIG_REGULATOR_PFUZE100=y
# CONFIG_REGULATOR_PV88060 is not set
CONFIG_REGULATOR_PV88080=y
# CONFIG_REGULATOR_PV88090 is not set
# CONFIG_REGULATOR_PWM is not set
CONFIG_REGULATOR_QCOM_RPMH=y
CONFIG_REGULATOR_QCOM_SPMI=y
CONFIG_REGULATOR_QCOM_USB_VBUS=y
# CONFIG_REGULATOR_RASPBERRYPI_TOUCHSCREEN_ATTINY is not set
CONFIG_REGULATOR_RN5T618=y
CONFIG_REGULATOR_RT4801=y
CONFIG_REGULATOR_RT4831=y
# CONFIG_REGULATOR_RT5033 is not set
CONFIG_REGULATOR_RT5190A=y
# CONFIG_REGULATOR_RT5759 is not set
# CONFIG_REGULATOR_RT6160 is not set
# CONFIG_REGULATOR_RT6245 is not set
CONFIG_REGULATOR_RTQ2134=y
CONFIG_REGULATOR_RTMV20=y
CONFIG_REGULATOR_RTQ6752=y
CONFIG_REGULATOR_S2MPA01=y
CONFIG_REGULATOR_S2MPS11=y
CONFIG_REGULATOR_S5M8767=y
# CONFIG_REGULATOR_SC2731 is not set
# CONFIG_REGULATOR_SLG51000 is not set
# CONFIG_REGULATOR_STM32_BOOSTER is not set
# CONFIG_REGULATOR_STM32_VREFBUF is not set
CONFIG_REGULATOR_STM32_PWR=y
CONFIG_REGULATOR_STPMIC1=y
# CONFIG_REGULATOR_TI_ABB is not set
CONFIG_REGULATOR_STW481X_VMMC=y
# CONFIG_REGULATOR_SY7636A is not set
# CONFIG_REGULATOR_SY8106A is not set
# CONFIG_REGULATOR_SY8824X is not set
CONFIG_REGULATOR_SY8827N=y
CONFIG_REGULATOR_TPS51632=y
# CONFIG_REGULATOR_TPS62360 is not set
# CONFIG_REGULATOR_TPS6286X is not set
CONFIG_REGULATOR_TPS65023=y
CONFIG_REGULATOR_TPS6507X=y
CONFIG_REGULATOR_TPS65132=y
CONFIG_REGULATOR_TPS65217=y
CONFIG_REGULATOR_TPS65218=y
CONFIG_REGULATOR_TPS6524X=y
# CONFIG_REGULATOR_TPS6586X is not set
CONFIG_REGULATOR_TPS65912=y
CONFIG_REGULATOR_TPS68470=y
CONFIG_REGULATOR_UNIPHIER=y
CONFIG_REGULATOR_VCTRL=y
CONFIG_REGULATOR_WM831X=y
CONFIG_REGULATOR_WM8400=y
CONFIG_REGULATOR_WM8994=y
# CONFIG_REGULATOR_QCOM_LABIBB is not set
CONFIG_RC_CORE=y
CONFIG_BPF_LIRC_MODE2=y
CONFIG_LIRC=y
CONFIG_RC_MAP=y
CONFIG_RC_DECODERS=y
CONFIG_IR_IMON_DECODER=y
# CONFIG_IR_JVC_DECODER is not set
# CONFIG_IR_MCE_KBD_DECODER is not set
CONFIG_IR_NEC_DECODER=y
CONFIG_IR_RC5_DECODER=y
# CONFIG_IR_RC6_DECODER is not set
CONFIG_IR_RCMM_DECODER=y
CONFIG_IR_SANYO_DECODER=y
CONFIG_IR_SHARP_DECODER=y
CONFIG_IR_SONY_DECODER=y
CONFIG_IR_XMP_DECODER=y
# CONFIG_RC_DEVICES is not set
CONFIG_CEC_CORE=y
CONFIG_CEC_NOTIFIER=y
CONFIG_CEC_PIN=y

#
# CEC support
#
# CONFIG_MEDIA_CEC_RC is not set
# CONFIG_CEC_PIN_ERROR_INJ is not set
CONFIG_MEDIA_CEC_SUPPORT=y
# CONFIG_CEC_CH7322 is not set
# CONFIG_CEC_CROS_EC is not set
CONFIG_CEC_MESON_AO=y
CONFIG_CEC_MESON_G12A_AO=y
CONFIG_CEC_GPIO=y
# CONFIG_CEC_SAMSUNG_S5P is not set
# CONFIG_CEC_STI is not set
# CONFIG_CEC_STM32 is not set
CONFIG_CEC_TEGRA=y
# end of CEC support

CONFIG_MEDIA_SUPPORT=y
# CONFIG_MEDIA_SUPPORT_FILTER is not set
CONFIG_MEDIA_SUBDRV_AUTOSELECT=y

#
# Media device types
#
CONFIG_MEDIA_CAMERA_SUPPORT=y
CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
CONFIG_MEDIA_RADIO_SUPPORT=y
CONFIG_MEDIA_SDR_SUPPORT=y
CONFIG_MEDIA_PLATFORM_SUPPORT=y
CONFIG_MEDIA_TEST_SUPPORT=y
# end of Media device types

#
# Media core support
#
CONFIG_VIDEO_DEV=y
CONFIG_MEDIA_CONTROLLER=y
CONFIG_DVB_CORE=y
# end of Media core support

#
# Video4Linux options
#
CONFIG_VIDEO_V4L2_I2C=y
CONFIG_VIDEO_V4L2_SUBDEV_API=y
CONFIG_VIDEO_ADV_DEBUG=y
CONFIG_VIDEO_FIXED_MINOR_RANGES=y
CONFIG_V4L2_JPEG_HELPER=y
CONFIG_V4L2_H264=y
CONFIG_V4L2_VP9=y
CONFIG_V4L2_MEM2MEM_DEV=y
CONFIG_V4L2_FLASH_LED_CLASS=y
CONFIG_V4L2_FWNODE=y
CONFIG_V4L2_ASYNC=y
# end of Video4Linux options

#
# Media controller options
#
CONFIG_MEDIA_CONTROLLER_DVB=y
CONFIG_MEDIA_CONTROLLER_REQUEST_API=y
# end of Media controller options

#
# Digital TV options
#
# CONFIG_DVB_MMAP is not set
CONFIG_DVB_MAX_ADAPTERS=16
# CONFIG_DVB_DYNAMIC_MINORS is not set
CONFIG_DVB_DEMUX_SECTION_LOSS_LOG=y
# CONFIG_DVB_ULE_DEBUG is not set
# end of Digital TV options

#
# Media drivers
#

#
# Media drivers
#
# CONFIG_MEDIA_USB_SUPPORT is not set
CONFIG_RADIO_ADAPTERS=y
CONFIG_RADIO_SAA7706H=y
# CONFIG_RADIO_SHARK is not set
CONFIG_RADIO_SHARK2=y
CONFIG_RADIO_SI4713=y
CONFIG_RADIO_TEA575X=y
CONFIG_RADIO_TEA5764=y
# CONFIG_RADIO_TEA5764_XTAL is not set
CONFIG_RADIO_TEF6862=y
CONFIG_RADIO_WL1273=y
# CONFIG_USB_DSBR is not set
CONFIG_USB_KEENE=y
# CONFIG_USB_MA901 is not set
CONFIG_USB_MR800=y
CONFIG_USB_RAREMONO=y
# CONFIG_RADIO_SI470X is not set
# CONFIG_USB_SI4713 is not set
CONFIG_PLATFORM_SI4713=y
CONFIG_I2C_SI4713=y
CONFIG_V4L_RADIO_ISA_DRIVERS=y
# CONFIG_RADIO_AZTECH is not set
CONFIG_RADIO_CADET=y
CONFIG_RADIO_GEMTEK=y
CONFIG_RADIO_GEMTEK_PORT=34c
# CONFIG_RADIO_GEMTEK_PROBE is not set
CONFIG_RADIO_ISA=y
CONFIG_RADIO_RTRACK=y
# CONFIG_RADIO_RTRACK2 is not set
CONFIG_RADIO_RTRACK_PORT=30f
CONFIG_RADIO_SF16FMI=y
CONFIG_RADIO_SF16FMR2=y
CONFIG_RADIO_TERRATEC=y
CONFIG_RADIO_TRUST=y
CONFIG_RADIO_TRUST_PORT=350
CONFIG_RADIO_TYPHOON=y
CONFIG_RADIO_TYPHOON_MUTEFREQ=87500
CONFIG_RADIO_TYPHOON_PORT=316
CONFIG_RADIO_ZOLTRIX=y
CONFIG_RADIO_ZOLTRIX_PORT=20c
CONFIG_MEDIA_PLATFORM_DRIVERS=y
CONFIG_V4L_PLATFORM_DRIVERS=y
CONFIG_SDR_PLATFORM_DRIVERS=y
CONFIG_DVB_PLATFORM_DRIVERS=y
CONFIG_V4L_MEM2MEM_DRIVERS=y
CONFIG_VIDEO_MEM2MEM_DEINTERLACE=y
CONFIG_VIDEO_MUX=y

#
# Allegro DVT media platform drivers
#
CONFIG_VIDEO_ALLEGRO_DVT=y

#
# Amlogic media platform drivers
#
# CONFIG_VIDEO_MESON_GE2D is not set

#
# Amphion drivers
#
# CONFIG_VIDEO_AMPHION_VPU is not set

#
# Aspeed media platform drivers
#
# CONFIG_VIDEO_ASPEED is not set

#
# Atmel media platform drivers
#
CONFIG_VIDEO_ATMEL_ISC=y
CONFIG_VIDEO_ATMEL_XISC=y
CONFIG_VIDEO_ATMEL_ISC_BASE=y
CONFIG_VIDEO_ATMEL_ISI=y
CONFIG_VIDEO_MICROCHIP_CSI2DC=y

#
# Cadence media platform drivers
#
# CONFIG_VIDEO_CADENCE_CSI2RX is not set
CONFIG_VIDEO_CADENCE_CSI2TX=y

#
# Chips&Media media platform drivers
#
# CONFIG_VIDEO_CODA is not set

#
# Intel media platform drivers
#
# CONFIG_VIDEO_PXA27x is not set

#
# Marvell media platform drivers
#
CONFIG_VIDEO_MMP_CAMERA=y

#
# Mediatek media platform drivers
#
CONFIG_VIDEO_MEDIATEK_JPEG=y
# CONFIG_VIDEO_MEDIATEK_MDP is not set
CONFIG_VIDEO_MEDIATEK_VCODEC_VPU=y
CONFIG_VIDEO_MEDIATEK_VCODEC=y
CONFIG_VIDEO_MEDIATEK_VPU=y

#
# NVidia media platform drivers
#
CONFIG_VIDEO_TEGRA_VDE=y

#
# NXP media platform drivers
#
CONFIG_VIDEO_IMX_MIPI_CSIS=y
# CONFIG_VIDEO_VIU is not set
CONFIG_VIDEO_IMX_PXP=y
CONFIG_VIDEO_MX2_EMMAPRP=y
CONFIG_VIDEO_IMX8_JPEG=y

#
# Qualcomm media platform drivers
#
CONFIG_VIDEO_QCOM_CAMSS=y

#
# Renesas media platform drivers
#
# CONFIG_VIDEO_RENESAS_CEU is not set
CONFIG_VIDEO_RCAR_ISP=y
# CONFIG_VIDEO_SH_VOU is not set
CONFIG_VIDEO_RCAR_CSI2=y
CONFIG_VIDEO_RCAR_VIN=y
CONFIG_VIDEO_RENESAS_FCP=y
CONFIG_VIDEO_RENESAS_FDP1=y
CONFIG_VIDEO_RENESAS_JPU=y
CONFIG_VIDEO_RENESAS_VSP1=y
CONFIG_VIDEO_RCAR_DRIF=y

#
# Rockchip media platform drivers
#
CONFIG_VIDEO_ROCKCHIP_RGA=y
CONFIG_VIDEO_ROCKCHIP_ISP1=y

#
# Samsung media platform drivers
#
CONFIG_VIDEO_SAMSUNG_EXYNOS_GSC=y
CONFIG_VIDEO_SAMSUNG_EXYNOS4_IS=y
CONFIG_VIDEO_EXYNOS4_IS_COMMON=y
CONFIG_VIDEO_S5P_FIMC=y
CONFIG_VIDEO_S5P_MIPI_CSIS=y
CONFIG_VIDEO_EXYNOS_FIMC_LITE=y
# CONFIG_VIDEO_EXYNOS4_FIMC_IS is not set
CONFIG_VIDEO_SAMSUNG_S5P_G2D=y
CONFIG_VIDEO_SAMSUNG_S5P_JPEG=y
# CONFIG_VIDEO_SAMSUNG_S5P_MFC is not set

#
# STMicroelectronics media platform drivers
#
CONFIG_VIDEO_STI_BDISP=y
# CONFIG_DVB_C8SECTPFE is not set
CONFIG_VIDEO_STI_DELTA=y
# CONFIG_VIDEO_STI_DELTA_MJPEG is not set
CONFIG_VIDEO_STI_HVA=y
CONFIG_VIDEO_STI_HVA_DEBUGFS=y
CONFIG_VIDEO_STM32_DCMI=y
CONFIG_VIDEO_STM32_DMA2D=y

#
# Sunxi media platform drivers
#
# CONFIG_VIDEO_SUN4I_CSI is not set
CONFIG_VIDEO_SUN6I_CSI=y

#
# Texas Instruments drivers
#
CONFIG_VIDEO_TI_CAL=y
CONFIG_VIDEO_TI_CAL_MC=y
# CONFIG_VIDEO_TI_VPE is not set
# CONFIG_VIDEO_AM437X_VPFE is not set
# CONFIG_VIDEO_DAVINCI_VPIF_DISPLAY is not set
CONFIG_VIDEO_DAVINCI_VPIF_CAPTURE=y
# CONFIG_VIDEO_DM6446_CCDC is not set
# CONFIG_VIDEO_DM355_CCDC is not set
# CONFIG_VIDEO_DM365_ISIF is not set
CONFIG_VIDEO_DAVINCI_VPBE_DISPLAY=y
CONFIG_VIDEO_OMAP2_VOUT_VRFB=y
CONFIG_VIDEO_OMAP2_VOUT=y
CONFIG_VIDEO_OMAP3=y
CONFIG_VIDEO_OMAP3_DEBUG=y

#
# VIA media platform drivers
#

#
# Xilinx media platform drivers
#
# CONFIG_VIDEO_XILINX is not set

#
# MMC/SDIO DVB adapters
#
CONFIG_SMS_SDIO_DRV=y
# CONFIG_V4L_TEST_DRIVERS is not set
CONFIG_DVB_TEST_DRIVERS=y
CONFIG_DVB_VIDTV=y
CONFIG_MEDIA_COMMON_OPTIONS=y

#
# common driver options
#
CONFIG_SMS_SIANO_MDTV=y
CONFIG_SMS_SIANO_RC=y
CONFIG_VIDEOBUF2_CORE=y
CONFIG_VIDEOBUF2_V4L2=y
CONFIG_VIDEOBUF2_MEMOPS=y
CONFIG_VIDEOBUF2_DMA_CONTIG=y
CONFIG_VIDEOBUF2_VMALLOC=y
CONFIG_VIDEOBUF2_DMA_SG=y
# end of Media drivers

#
# Media ancillary drivers
#

#
# IR I2C driver auto-selected by 'Autoselect ancillary drivers'
#
# CONFIG_VIDEO_IR_I2C is not set

#
# Camera sensor devices
#
CONFIG_VIDEO_APTINA_PLL=y
CONFIG_VIDEO_CCS_PLL=y
CONFIG_VIDEO_AR0521=y
# CONFIG_VIDEO_HI556 is not set
# CONFIG_VIDEO_HI846 is not set
# CONFIG_VIDEO_HI847 is not set
CONFIG_VIDEO_IMX208=y
CONFIG_VIDEO_IMX214=y
CONFIG_VIDEO_IMX219=y
CONFIG_VIDEO_IMX258=y
CONFIG_VIDEO_IMX274=y
CONFIG_VIDEO_IMX290=y
CONFIG_VIDEO_IMX319=y
# CONFIG_VIDEO_IMX334 is not set
CONFIG_VIDEO_IMX335=y
CONFIG_VIDEO_IMX355=y
CONFIG_VIDEO_IMX412=y
CONFIG_VIDEO_MAX9271_LIB=y
CONFIG_VIDEO_MT9M001=y
CONFIG_VIDEO_MT9M032=y
# CONFIG_VIDEO_MT9M111 is not set
# CONFIG_VIDEO_MT9P031 is not set
CONFIG_VIDEO_MT9T001=y
# CONFIG_VIDEO_MT9T112 is not set
CONFIG_VIDEO_MT9V011=y
# CONFIG_VIDEO_MT9V032 is not set
# CONFIG_VIDEO_MT9V111 is not set
# CONFIG_VIDEO_NOON010PC30 is not set
# CONFIG_VIDEO_OG01A1B is not set
CONFIG_VIDEO_OV02A10=y
# CONFIG_VIDEO_OV08D10 is not set
# CONFIG_VIDEO_OV13858 is not set
# CONFIG_VIDEO_OV13B10 is not set
CONFIG_VIDEO_OV2640=y
CONFIG_VIDEO_OV2659=y
CONFIG_VIDEO_OV2680=y
CONFIG_VIDEO_OV2685=y
CONFIG_VIDEO_OV2740=y
CONFIG_VIDEO_OV5640=y
# CONFIG_VIDEO_OV5645 is not set
# CONFIG_VIDEO_OV5647 is not set
# CONFIG_VIDEO_OV5670 is not set
CONFIG_VIDEO_OV5675=y
CONFIG_VIDEO_OV5693=y
CONFIG_VIDEO_OV5695=y
# CONFIG_VIDEO_OV6650 is not set
CONFIG_VIDEO_OV7251=y
# CONFIG_VIDEO_OV7640 is not set
CONFIG_VIDEO_OV7670=y
CONFIG_VIDEO_OV772X=y
CONFIG_VIDEO_OV7740=y
# CONFIG_VIDEO_OV8856 is not set
# CONFIG_VIDEO_OV9282 is not set
CONFIG_VIDEO_OV9640=y
CONFIG_VIDEO_OV9650=y
# CONFIG_VIDEO_OV9734 is not set
# CONFIG_VIDEO_RDACM20 is not set
CONFIG_VIDEO_RDACM21=y
# CONFIG_VIDEO_RJ54N1 is not set
# CONFIG_VIDEO_S5C73M3 is not set
CONFIG_VIDEO_S5K4ECGX=y
CONFIG_VIDEO_S5K5BAF=y
CONFIG_VIDEO_S5K6A3=y
# CONFIG_VIDEO_S5K6AA is not set
CONFIG_VIDEO_SR030PC30=y
CONFIG_VIDEO_VS6624=y
CONFIG_VIDEO_CCS=y
CONFIG_VIDEO_ET8EK8=y
# CONFIG_VIDEO_M5MOLS is not set
# end of Camera sensor devices

#
# Lens drivers
#
CONFIG_VIDEO_AD5820=y
CONFIG_VIDEO_AK7375=y
CONFIG_VIDEO_DW9714=y
CONFIG_VIDEO_DW9768=y
# CONFIG_VIDEO_DW9807_VCM is not set
# end of Lens drivers

#
# Flash devices
#
CONFIG_VIDEO_ADP1653=y
CONFIG_VIDEO_LM3560=y
# CONFIG_VIDEO_LM3646 is not set
# end of Flash devices

#
# Audio decoders, processors and mixers
#
# CONFIG_VIDEO_CS3308 is not set
CONFIG_VIDEO_CS5345=y
# CONFIG_VIDEO_CS53L32A is not set
CONFIG_VIDEO_MSP3400=y
# CONFIG_VIDEO_SONY_BTF_MPX is not set
CONFIG_VIDEO_TDA7432=y
CONFIG_VIDEO_TDA9840=y
CONFIG_VIDEO_TEA6415C=y
# CONFIG_VIDEO_TEA6420 is not set
# CONFIG_VIDEO_TLV320AIC23B is not set
CONFIG_VIDEO_TVAUDIO=y
CONFIG_VIDEO_UDA1342=y
# CONFIG_VIDEO_VP27SMPX is not set
CONFIG_VIDEO_WM8739=y
# CONFIG_VIDEO_WM8775 is not set
# end of Audio decoders, processors and mixers

#
# RDS decoders
#
# CONFIG_VIDEO_SAA6588 is not set
# end of RDS decoders

#
# Video decoders
#
# CONFIG_VIDEO_ADV7180 is not set
# CONFIG_VIDEO_ADV7183 is not set
# CONFIG_VIDEO_ADV748X is not set
# CONFIG_VIDEO_ADV7604 is not set
CONFIG_VIDEO_ADV7842=y
CONFIG_VIDEO_ADV7842_CEC=y
# CONFIG_VIDEO_BT819 is not set
CONFIG_VIDEO_BT856=y
CONFIG_VIDEO_BT866=y
CONFIG_VIDEO_ISL7998X=y
CONFIG_VIDEO_KS0127=y
# CONFIG_VIDEO_MAX9286 is not set
CONFIG_VIDEO_ML86V7667=y
CONFIG_VIDEO_SAA7110=y
CONFIG_VIDEO_SAA711X=y
CONFIG_VIDEO_TC358743=y
# CONFIG_VIDEO_TC358743_CEC is not set
CONFIG_VIDEO_TVP514X=y
# CONFIG_VIDEO_TVP5150 is not set
# CONFIG_VIDEO_TVP7002 is not set
CONFIG_VIDEO_TW2804=y
CONFIG_VIDEO_TW9903=y
# CONFIG_VIDEO_TW9906 is not set
# CONFIG_VIDEO_TW9910 is not set
# CONFIG_VIDEO_VPX3220 is not set

#
# Video and audio decoders
#
CONFIG_VIDEO_SAA717X=y
# CONFIG_VIDEO_CX25840 is not set
# end of Video decoders

#
# Video encoders
#
# CONFIG_VIDEO_AD9389B is not set
# CONFIG_VIDEO_ADV7170 is not set
# CONFIG_VIDEO_ADV7175 is not set
# CONFIG_VIDEO_ADV7343 is not set
# CONFIG_VIDEO_ADV7393 is not set
CONFIG_VIDEO_ADV7511=y
# CONFIG_VIDEO_ADV7511_CEC is not set
# CONFIG_VIDEO_AK881X is not set
CONFIG_VIDEO_SAA7127=y
CONFIG_VIDEO_SAA7185=y
# CONFIG_VIDEO_THS8200 is not set
# end of Video encoders

#
# Video improvement chips
#
CONFIG_VIDEO_UPD64031A=y
# CONFIG_VIDEO_UPD64083 is not set
# end of Video improvement chips

#
# Audio/Video compression chips
#
# CONFIG_VIDEO_SAA6752HS is not set
# end of Audio/Video compression chips

#
# SDR tuner chips
#
CONFIG_SDR_MAX2175=y
# end of SDR tuner chips

#
# Miscellaneous helper chips
#
# CONFIG_VIDEO_I2C is not set
# CONFIG_VIDEO_M52790 is not set
CONFIG_VIDEO_ST_MIPID02=y
CONFIG_VIDEO_THS7303=y
# end of Miscellaneous helper chips

#
# Media SPI Adapters
#
CONFIG_CXD2880_SPI_DRV=y
CONFIG_VIDEO_GS1662=y
# end of Media SPI Adapters

CONFIG_MEDIA_TUNER=y

#
# Customize TV tuners
#
# CONFIG_MEDIA_TUNER_E4000 is not set
# CONFIG_MEDIA_TUNER_FC0011 is not set
# CONFIG_MEDIA_TUNER_FC0012 is not set
CONFIG_MEDIA_TUNER_FC0013=y
CONFIG_MEDIA_TUNER_FC2580=y
CONFIG_MEDIA_TUNER_IT913X=y
# CONFIG_MEDIA_TUNER_M88RS6000T is not set
CONFIG_MEDIA_TUNER_MAX2165=y
CONFIG_MEDIA_TUNER_MC44S803=y
CONFIG_MEDIA_TUNER_MSI001=y
CONFIG_MEDIA_TUNER_MT2060=y
# CONFIG_MEDIA_TUNER_MT2063 is not set
CONFIG_MEDIA_TUNER_MT20XX=y
# CONFIG_MEDIA_TUNER_MT2131 is not set
# CONFIG_MEDIA_TUNER_MT2266 is not set
CONFIG_MEDIA_TUNER_MXL301RF=y
CONFIG_MEDIA_TUNER_MXL5005S=y
# CONFIG_MEDIA_TUNER_MXL5007T is not set
CONFIG_MEDIA_TUNER_QM1D1B0004=y
# CONFIG_MEDIA_TUNER_QM1D1C0042 is not set
CONFIG_MEDIA_TUNER_QT1010=y
# CONFIG_MEDIA_TUNER_R820T is not set
CONFIG_MEDIA_TUNER_SI2157=y
CONFIG_MEDIA_TUNER_SIMPLE=y
CONFIG_MEDIA_TUNER_TDA18212=y
CONFIG_MEDIA_TUNER_TDA18218=y
CONFIG_MEDIA_TUNER_TDA18250=y
CONFIG_MEDIA_TUNER_TDA18271=y
CONFIG_MEDIA_TUNER_TDA827X=y
CONFIG_MEDIA_TUNER_TDA8290=y
CONFIG_MEDIA_TUNER_TDA9887=y
CONFIG_MEDIA_TUNER_TEA5761=y
CONFIG_MEDIA_TUNER_TEA5767=y
CONFIG_MEDIA_TUNER_TUA9001=y
CONFIG_MEDIA_TUNER_XC2028=y
CONFIG_MEDIA_TUNER_XC4000=y
CONFIG_MEDIA_TUNER_XC5000=y
# end of Customize TV tuners

#
# Customise DVB Frontends
#

#
# Multistandard (satellite) frontends
#
CONFIG_DVB_M88DS3103=y
CONFIG_DVB_MXL5XX=y
CONFIG_DVB_STB0899=y
CONFIG_DVB_STB6100=y
CONFIG_DVB_STV090x=y
# CONFIG_DVB_STV0910 is not set
CONFIG_DVB_STV6110x=y
# CONFIG_DVB_STV6111 is not set

#
# Multistandard (cable + terrestrial) frontends
#
CONFIG_DVB_DRXK=y
CONFIG_DVB_MN88472=y
CONFIG_DVB_MN88473=y
CONFIG_DVB_SI2165=y
# CONFIG_DVB_TDA18271C2DD is not set

#
# DVB-S (satellite) frontends
#
# CONFIG_DVB_CX24110 is not set
CONFIG_DVB_CX24116=y
# CONFIG_DVB_CX24117 is not set
CONFIG_DVB_CX24120=y
CONFIG_DVB_CX24123=y
CONFIG_DVB_DS3000=y
# CONFIG_DVB_MB86A16 is not set
CONFIG_DVB_MT312=y
CONFIG_DVB_S5H1420=y
# CONFIG_DVB_SI21XX is not set
CONFIG_DVB_STB6000=y
# CONFIG_DVB_STV0288 is not set
CONFIG_DVB_STV0299=y
# CONFIG_DVB_STV0900 is not set
# CONFIG_DVB_STV6110 is not set
# CONFIG_DVB_TDA10071 is not set
CONFIG_DVB_TDA10086=y
CONFIG_DVB_TDA8083=y
# CONFIG_DVB_TDA8261 is not set
# CONFIG_DVB_TDA826X is not set
# CONFIG_DVB_TS2020 is not set
CONFIG_DVB_TUA6100=y
CONFIG_DVB_TUNER_CX24113=y
CONFIG_DVB_TUNER_ITD1000=y
# CONFIG_DVB_VES1X93 is not set
# CONFIG_DVB_ZL10036 is not set
CONFIG_DVB_ZL10039=y

#
# DVB-T (terrestrial) frontends
#
CONFIG_DVB_AF9013=y
CONFIG_DVB_CX22700=y
# CONFIG_DVB_CX22702 is not set
CONFIG_DVB_CXD2820R=y
# CONFIG_DVB_CXD2841ER is not set
CONFIG_DVB_DIB3000MB=y
CONFIG_DVB_DIB3000MC=y
CONFIG_DVB_DIB7000M=y
CONFIG_DVB_DIB7000P=y
CONFIG_DVB_DIB9000=y
# CONFIG_DVB_DRXD is not set
# CONFIG_DVB_EC100 is not set
CONFIG_DVB_L64781=y
# CONFIG_DVB_MT352 is not set
CONFIG_DVB_NXT6000=y
# CONFIG_DVB_RTL2830 is not set
CONFIG_DVB_RTL2832=y
CONFIG_DVB_RTL2832_SDR=y
CONFIG_DVB_S5H1432=y
# CONFIG_DVB_SI2168 is not set
CONFIG_DVB_SP887X=y
# CONFIG_DVB_STV0367 is not set
# CONFIG_DVB_TDA10048 is not set
CONFIG_DVB_TDA1004X=y
CONFIG_DVB_ZD1301_DEMOD=y
CONFIG_DVB_ZL10353=y
CONFIG_DVB_CXD2880=y

#
# DVB-C (cable) frontends
#
CONFIG_DVB_STV0297=y
CONFIG_DVB_TDA10021=y
CONFIG_DVB_TDA10023=y
# CONFIG_DVB_VES1820 is not set

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#
CONFIG_DVB_AU8522=y
# CONFIG_DVB_AU8522_DTV is not set
CONFIG_DVB_AU8522_V4L=y
# CONFIG_DVB_BCM3510 is not set
CONFIG_DVB_LG2160=y
# CONFIG_DVB_LGDT3305 is not set
CONFIG_DVB_LGDT3306A=y
CONFIG_DVB_LGDT330X=y
CONFIG_DVB_MXL692=y
CONFIG_DVB_NXT200X=y
CONFIG_DVB_OR51132=y
CONFIG_DVB_OR51211=y
CONFIG_DVB_S5H1409=y
CONFIG_DVB_S5H1411=y

#
# ISDB-T (terrestrial) frontends
#
CONFIG_DVB_DIB8000=y
CONFIG_DVB_MB86A20S=y
CONFIG_DVB_S921=y

#
# ISDB-S (satellite) & ISDB-T (terrestrial) frontends
#
CONFIG_DVB_MN88443X=y
CONFIG_DVB_TC90522=y

#
# Digital terrestrial only tuners/PLL
#
# CONFIG_DVB_PLL is not set
CONFIG_DVB_TUNER_DIB0070=y
CONFIG_DVB_TUNER_DIB0090=y

#
# SEC control devices for DVB-S
#
CONFIG_DVB_A8293=y
CONFIG_DVB_AF9033=y
CONFIG_DVB_ASCOT2E=y
CONFIG_DVB_ATBM8830=y
# CONFIG_DVB_HELENE is not set
CONFIG_DVB_HORUS3A=y
# CONFIG_DVB_ISL6405 is not set
CONFIG_DVB_ISL6421=y
# CONFIG_DVB_ISL6423 is not set
# CONFIG_DVB_IX2505V is not set
CONFIG_DVB_LGS8GL5=y
# CONFIG_DVB_LGS8GXX is not set
CONFIG_DVB_LNBH25=y
CONFIG_DVB_LNBH29=y
CONFIG_DVB_LNBP21=y
CONFIG_DVB_LNBP22=y
CONFIG_DVB_M88RS2000=y
CONFIG_DVB_TDA665x=y
CONFIG_DVB_DRX39XYJ=y

#
# Common Interface (EN50221) controller drivers
#
CONFIG_DVB_CXD2099=y
CONFIG_DVB_SP2=y
# end of Customise DVB Frontends

#
# Tools to develop new frontends
#
# CONFIG_DVB_DUMMY_FE is not set
# end of Media ancillary drivers

#
# Graphics support
#
CONFIG_APERTURE_HELPERS=y
# CONFIG_IMX_IPUV3_CORE is not set
CONFIG_DRM=y
CONFIG_DRM_MIPI_DBI=y
CONFIG_DRM_MIPI_DSI=y
# CONFIG_DRM_DEBUG_MM is not set
# CONFIG_DRM_DEBUG_SELFTEST is not set
CONFIG_DRM_KUNIT_TEST=y
CONFIG_DRM_KMS_HELPER=y
CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS=y
# CONFIG_DRM_DEBUG_MODESET_LOCK is not set
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM=y
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
CONFIG_DRM_DP_AUX_BUS=y
CONFIG_DRM_DISPLAY_HELPER=y
CONFIG_DRM_DISPLAY_DP_HELPER=y
CONFIG_DRM_DISPLAY_HDMI_HELPER=y
# CONFIG_DRM_DP_AUX_CHARDEV is not set
CONFIG_DRM_DP_CEC=y
CONFIG_DRM_GEM_CMA_HELPER=y
CONFIG_DRM_GEM_SHMEM_HELPER=y
CONFIG_DRM_SCHED=y

#
# I2C encoder or helper chips
#
# CONFIG_DRM_I2C_CH7006 is not set
CONFIG_DRM_I2C_SIL164=y
CONFIG_DRM_I2C_NXP_TDA998X=y
# CONFIG_DRM_I2C_NXP_TDA9950 is not set
# end of I2C encoder or helper chips

#
# ARM devices
#
CONFIG_DRM_HDLCD=y
CONFIG_DRM_HDLCD_SHOW_UNDERRUN=y
# CONFIG_DRM_MALI_DISPLAY is not set
CONFIG_DRM_KOMEDA=y
# end of ARM devices

# CONFIG_DRM_KMB_DISPLAY is not set
# CONFIG_DRM_VGEM is not set
# CONFIG_DRM_VKMS is not set
CONFIG_DRM_EXYNOS=y

#
# CRTCs
#
CONFIG_DRM_EXYNOS_FIMD=y
# CONFIG_DRM_EXYNOS5433_DECON is not set
# CONFIG_DRM_EXYNOS7_DECON is not set
CONFIG_DRM_EXYNOS_MIXER=y
CONFIG_DRM_EXYNOS_VIDI=y

#
# Encoders and Bridges
#
CONFIG_DRM_EXYNOS_DPI=y
# CONFIG_DRM_EXYNOS_DSI is not set
# CONFIG_DRM_EXYNOS_DP is not set
# CONFIG_DRM_EXYNOS_HDMI is not set

#
# Sub-drivers
#
# CONFIG_DRM_EXYNOS_G2D is not set
CONFIG_DRM_EXYNOS_IPP=y
# CONFIG_DRM_EXYNOS_FIMC is not set
CONFIG_DRM_EXYNOS_ROTATOR=y
# CONFIG_DRM_EXYNOS_SCALER is not set
CONFIG_DRM_EXYNOS_GSC=y
# CONFIG_DRM_ROCKCHIP is not set
CONFIG_DRM_UDL=y
CONFIG_DRM_RCAR_DW_HDMI=y
CONFIG_DRM_RCAR_USE_LVDS=y
CONFIG_DRM_RCAR_MIPI_DSI=y
# CONFIG_DRM_SUN4I is not set
CONFIG_DRM_MSM=y
CONFIG_DRM_MSM_GPU_STATE=y
# CONFIG_DRM_MSM_GPU_SUDO is not set
CONFIG_DRM_MSM_MDSS=y
# CONFIG_DRM_MSM_MDP4 is not set
CONFIG_DRM_MSM_MDP5=y
# CONFIG_DRM_MSM_DPU is not set
CONFIG_DRM_MSM_DP=y
# CONFIG_DRM_MSM_DSI is not set
# CONFIG_DRM_MSM_HDMI is not set
CONFIG_DRM_PANEL=y

#
# Display Panels
#
CONFIG_DRM_PANEL_ABT_Y030XX067A=y
CONFIG_DRM_PANEL_ARM_VERSATILE=y
CONFIG_DRM_PANEL_ASUS_Z00T_TM5P5_NT35596=y
CONFIG_DRM_PANEL_BOE_BF060Y8M_AJ0=y
CONFIG_DRM_PANEL_BOE_HIMAX8279D=y
CONFIG_DRM_PANEL_BOE_TV101WUM_NL6=y
# CONFIG_DRM_PANEL_DSI_CM is not set
CONFIG_DRM_PANEL_LVDS=y
CONFIG_DRM_PANEL_EBBG_FT8719=y
# CONFIG_DRM_PANEL_ELIDA_KD35T133 is not set
# CONFIG_DRM_PANEL_FEIXIN_K101_IM2BA02 is not set
CONFIG_DRM_PANEL_FEIYANG_FY07024DI26A30D=y
CONFIG_DRM_PANEL_ILITEK_IL9322=y
CONFIG_DRM_PANEL_ILITEK_ILI9341=y
CONFIG_DRM_PANEL_ILITEK_ILI9881C=y
# CONFIG_DRM_PANEL_INNOLUX_EJ030NA is not set
# CONFIG_DRM_PANEL_INNOLUX_P079ZCA is not set
# CONFIG_DRM_PANEL_JDI_LT070ME05000 is not set
# CONFIG_DRM_PANEL_JDI_R63452 is not set
# CONFIG_DRM_PANEL_KHADAS_TS050 is not set
# CONFIG_DRM_PANEL_KINGDISPLAY_KD097D04 is not set
# CONFIG_DRM_PANEL_LEADTEK_LTK050H3146W is not set
CONFIG_DRM_PANEL_LEADTEK_LTK500HD1829=y
CONFIG_DRM_PANEL_SAMSUNG_LD9040=y
# CONFIG_DRM_PANEL_LG_LB035Q02 is not set
# CONFIG_DRM_PANEL_LG_LG4573 is not set
CONFIG_DRM_PANEL_NEC_NL8048HL11=y
CONFIG_DRM_PANEL_NEWVISION_NV3052C=y
# CONFIG_DRM_PANEL_NOVATEK_NT35510 is not set
CONFIG_DRM_PANEL_NOVATEK_NT35560=y
CONFIG_DRM_PANEL_NOVATEK_NT35950=y
CONFIG_DRM_PANEL_NOVATEK_NT36672A=y
# CONFIG_DRM_PANEL_NOVATEK_NT39016 is not set
CONFIG_DRM_PANEL_MANTIX_MLAF057WE51=y
CONFIG_DRM_PANEL_OLIMEX_LCD_OLINUXINO=y
# CONFIG_DRM_PANEL_ORISETECH_OTM8009A is not set
CONFIG_DRM_PANEL_OSD_OSD101T2587_53TS=y
CONFIG_DRM_PANEL_PANASONIC_VVX10F034N00=y
CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN=y
CONFIG_DRM_PANEL_RAYDIUM_RM67191=y
CONFIG_DRM_PANEL_RAYDIUM_RM68200=y
# CONFIG_DRM_PANEL_RONBO_RB070D30 is not set
# CONFIG_DRM_PANEL_SAMSUNG_DB7430 is not set
# CONFIG_DRM_PANEL_SAMSUNG_S6D16D0 is not set
CONFIG_DRM_PANEL_SAMSUNG_S6D27A1=y
CONFIG_DRM_PANEL_SAMSUNG_S6E3HA2=y
CONFIG_DRM_PANEL_SAMSUNG_S6E63J0X03=y
CONFIG_DRM_PANEL_SAMSUNG_S6E63M0=y
CONFIG_DRM_PANEL_SAMSUNG_S6E63M0_SPI=y
CONFIG_DRM_PANEL_SAMSUNG_S6E63M0_DSI=y
CONFIG_DRM_PANEL_SAMSUNG_S6E88A0_AMS452EF01=y
CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0=y
CONFIG_DRM_PANEL_SAMSUNG_SOFEF00=y
CONFIG_DRM_PANEL_SEIKO_43WVF1G=y
# CONFIG_DRM_PANEL_SHARP_LQ101R1SX01 is not set
CONFIG_DRM_PANEL_SHARP_LS037V7DW01=y
CONFIG_DRM_PANEL_SHARP_LS043T1LE01=y
# CONFIG_DRM_PANEL_SHARP_LS060T1SX01 is not set
# CONFIG_DRM_PANEL_SITRONIX_ST7701 is not set
# CONFIG_DRM_PANEL_SITRONIX_ST7703 is not set
# CONFIG_DRM_PANEL_SITRONIX_ST7789V is not set
CONFIG_DRM_PANEL_SONY_ACX565AKM=y
# CONFIG_DRM_PANEL_SONY_TULIP_TRULY_NT35521 is not set
CONFIG_DRM_PANEL_TDO_TL070WSH30=y
# CONFIG_DRM_PANEL_TPO_TD028TTEC1 is not set
CONFIG_DRM_PANEL_TPO_TD043MTEA1=y
CONFIG_DRM_PANEL_TPO_TPG110=y
CONFIG_DRM_PANEL_TRULY_NT35597_WQXGA=y
CONFIG_DRM_PANEL_VISIONOX_RM69299=y
# CONFIG_DRM_PANEL_WIDECHIPS_WS2401 is not set
# CONFIG_DRM_PANEL_XINPENG_XPP055C272 is not set
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
CONFIG_DRM_CDNS_DSI=y
CONFIG_DRM_CHIPONE_ICN6211=y
# CONFIG_DRM_CHRONTEL_CH7033 is not set
# CONFIG_DRM_CROS_EC_ANX7688 is not set
# CONFIG_DRM_DISPLAY_CONNECTOR is not set
CONFIG_DRM_FSL_LDB=y
# CONFIG_DRM_ITE_IT6505 is not set
CONFIG_DRM_LONTIUM_LT8912B=y
# CONFIG_DRM_LONTIUM_LT9211 is not set
CONFIG_DRM_LONTIUM_LT9611=y
CONFIG_DRM_LONTIUM_LT9611UXC=y
# CONFIG_DRM_ITE_IT66121 is not set
CONFIG_DRM_LVDS_CODEC=y
CONFIG_DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW=y
CONFIG_DRM_NWL_MIPI_DSI=y
CONFIG_DRM_NXP_PTN3460=y
CONFIG_DRM_PARADE_PS8622=y
CONFIG_DRM_PARADE_PS8640=y
CONFIG_DRM_SIL_SII8620=y
# CONFIG_DRM_SII902X is not set
CONFIG_DRM_SII9234=y
# CONFIG_DRM_SIMPLE_BRIDGE is not set
CONFIG_DRM_THINE_THC63LVD1024=y
CONFIG_DRM_TOSHIBA_TC358762=y
CONFIG_DRM_TOSHIBA_TC358764=y
CONFIG_DRM_TOSHIBA_TC358767=y
# CONFIG_DRM_TOSHIBA_TC358768 is not set
CONFIG_DRM_TOSHIBA_TC358775=y
# CONFIG_DRM_TI_DLPC3433 is not set
CONFIG_DRM_TI_TFP410=y
# CONFIG_DRM_TI_SN65DSI83 is not set
CONFIG_DRM_TI_SN65DSI86=y
CONFIG_DRM_TI_TPD12S015=y
CONFIG_DRM_ANALOGIX_ANX6345=y
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
CONFIG_DRM_ANALOGIX_DP=y
# CONFIG_DRM_ANALOGIX_ANX7625 is not set
CONFIG_DRM_I2C_ADV7511=y
# CONFIG_DRM_I2C_ADV7511_CEC is not set
# CONFIG_DRM_CDNS_MHDP8546 is not set
CONFIG_DRM_IMX8QM_LDB=y
CONFIG_DRM_IMX8QXP_LDB=y
CONFIG_DRM_IMX8QXP_PIXEL_COMBINER=y
CONFIG_DRM_IMX8QXP_PIXEL_LINK_TO_DPI=y
CONFIG_DRM_DW_HDMI=y
CONFIG_DRM_DW_HDMI_CEC=y
# end of Display Interface Bridges

CONFIG_DRM_V3D=y
# CONFIG_DRM_ETNAVIV is not set
# CONFIG_DRM_LOGICVC is not set
CONFIG_DRM_MXS=y
CONFIG_DRM_MXSFB=y
CONFIG_DRM_IMX_LCDIF=y
# CONFIG_DRM_ARCPGU is not set
# CONFIG_DRM_GM12U320 is not set
CONFIG_DRM_PANEL_MIPI_DBI=y
CONFIG_DRM_SIMPLEDRM=y
CONFIG_TINYDRM_HX8357D=y
CONFIG_TINYDRM_ILI9163=y
# CONFIG_TINYDRM_ILI9225 is not set
CONFIG_TINYDRM_ILI9341=y
CONFIG_TINYDRM_ILI9486=y
# CONFIG_TINYDRM_MI0283QT is not set
CONFIG_TINYDRM_REPAPER=y
# CONFIG_TINYDRM_ST7586 is not set
# CONFIG_TINYDRM_ST7735R is not set
# CONFIG_DRM_PL111 is not set
# CONFIG_DRM_LIMA is not set
# CONFIG_DRM_ASPEED_GFX is not set
CONFIG_DRM_TIDSS=y
# CONFIG_DRM_GUD is not set
# CONFIG_DRM_SSD130X is not set
CONFIG_DRM_SPRD=y
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
CONFIG_DRM_NOMODESET=y

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
CONFIG_FIRMWARE_EDID=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=y
CONFIG_FB_SYS_COPYAREA=y
CONFIG_FB_SYS_IMAGEBLIT=y
CONFIG_FB_FOREIGN_ENDIAN=y
# CONFIG_FB_BOTH_ENDIAN is not set
# CONFIG_FB_BIG_ENDIAN is not set
CONFIG_FB_LITTLE_ENDIAN=y
CONFIG_FB_SYS_FOPS=y
CONFIG_FB_DEFERRED_IO=y
CONFIG_FB_MACMODES=y
CONFIG_FB_BACKLIGHT=y
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
CONFIG_FB_CLPS711X=y
CONFIG_FB_IMX=y
# CONFIG_FB_ARC is not set
CONFIG_FB_CONTROL=y
# CONFIG_FB_EFI is not set
CONFIG_FB_GBE=y
CONFIG_FB_GBE_MEM=4
CONFIG_FB_PVR2=y
CONFIG_FB_OPENCORES=y
CONFIG_FB_S1D13XXX=y
CONFIG_FB_ATMEL=y
CONFIG_FB_WM8505=y
# CONFIG_FB_WMT_GE_ROPS is not set
CONFIG_FB_PXA168=y
# CONFIG_FB_W100 is not set
CONFIG_FB_SH_MOBILE_LCDC=y
CONFIG_FB_TMIO=y
CONFIG_FB_TMIO_ACCELL=y
# CONFIG_FB_S3C is not set
# CONFIG_FB_SM501 is not set
CONFIG_FB_SMSCUFX=y
CONFIG_FB_UDL=y
CONFIG_FB_IBM_GXT4500=y
# CONFIG_FB_GOLDFISH is not set
# CONFIG_FB_DA8XX is not set
CONFIG_FB_VIRTUAL=y
# CONFIG_FB_METRONOME is not set
CONFIG_FB_BROADSHEET=y
CONFIG_FB_SSD1307=y
# CONFIG_FB_OMAP_LCD_H3 is not set
CONFIG_FB_OMAP2=y
CONFIG_FB_OMAP2_DEBUG_SUPPORT=y
CONFIG_FB_OMAP2_NUM_FBS=3
CONFIG_FB_OMAP2_DSS_INIT=y
CONFIG_FB_OMAP2_DSS=y
# CONFIG_FB_OMAP2_DSS_DEBUG is not set
CONFIG_FB_OMAP2_DSS_DEBUGFS=y
# CONFIG_FB_OMAP2_DSS_COLLECT_IRQ_STATS is not set
CONFIG_FB_OMAP2_DSS_DPI=y
# CONFIG_FB_OMAP2_DSS_VENC is not set
# CONFIG_FB_OMAP4_DSS_HDMI is not set
# CONFIG_FB_OMAP5_DSS_HDMI is not set
# CONFIG_FB_OMAP2_DSS_SDI is not set
CONFIG_FB_OMAP2_DSS_DSI=y
CONFIG_FB_OMAP2_DSS_MIN_FCK_PER_PCK=0
# CONFIG_FB_OMAP2_DSS_SLEEP_AFTER_VENC_RESET is not set

#
# OMAPFB Panel and Encoder Drivers
#
CONFIG_FB_OMAP2_ENCODER_OPA362=y
CONFIG_FB_OMAP2_ENCODER_TFP410=y
CONFIG_FB_OMAP2_ENCODER_TPD12S015=y
CONFIG_FB_OMAP2_CONNECTOR_DVI=y
# CONFIG_FB_OMAP2_CONNECTOR_HDMI is not set
# CONFIG_FB_OMAP2_CONNECTOR_ANALOG_TV is not set
CONFIG_FB_OMAP2_PANEL_DPI=y
CONFIG_FB_OMAP2_PANEL_DSI_CM=y
# CONFIG_FB_OMAP2_PANEL_LGPHILIPS_LB035Q02 is not set
# CONFIG_FB_OMAP2_PANEL_TPO_TD028TTEC1 is not set
# end of OMAPFB Panel and Encoder Drivers

# CONFIG_MMP_DISP is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=y
# CONFIG_LCD_L4F00242T03 is not set
CONFIG_LCD_LMS283GF05=y
# CONFIG_LCD_LTV350QV is not set
CONFIG_LCD_ILI922X=y
CONFIG_LCD_ILI9320=y
CONFIG_LCD_TDO24M=y
CONFIG_LCD_VGG2432A4=y
CONFIG_LCD_PLATFORM=y
# CONFIG_LCD_AMS369FG06 is not set
CONFIG_LCD_LMS501KF03=y
# CONFIG_LCD_HX8357 is not set
CONFIG_LCD_OTM3225A=y
CONFIG_BACKLIGHT_CLASS_DEVICE=y
CONFIG_BACKLIGHT_ATMEL_LCDC=y
CONFIG_BACKLIGHT_KTD253=y
# CONFIG_BACKLIGHT_LM3533 is not set
CONFIG_BACKLIGHT_OMAP1=y
CONFIG_BACKLIGHT_PWM=y
# CONFIG_BACKLIGHT_DA9052 is not set
# CONFIG_BACKLIGHT_MAX8925 is not set
CONFIG_BACKLIGHT_QCOM_WLED=y
CONFIG_BACKLIGHT_RT4831=y
CONFIG_BACKLIGHT_WM831X=y
CONFIG_BACKLIGHT_ADP8860=y
# CONFIG_BACKLIGHT_ADP8870 is not set
CONFIG_BACKLIGHT_PCF50633=y
CONFIG_BACKLIGHT_LM3630A=y
# CONFIG_BACKLIGHT_LM3639 is not set
# CONFIG_BACKLIGHT_LP855X is not set
# CONFIG_BACKLIGHT_TPS65217 is not set
# CONFIG_BACKLIGHT_AS3711 is not set
CONFIG_BACKLIGHT_GPIO=y
CONFIG_BACKLIGHT_LV5207LP=y
CONFIG_BACKLIGHT_BD6107=y
# CONFIG_BACKLIGHT_ARCXCNN is not set
# CONFIG_BACKLIGHT_LED is not set
# end of Backlight & LCD device support

CONFIG_VIDEOMODE_HELPERS=y
CONFIG_HDMI=y
# CONFIG_LOGO is not set
# end of Graphics support

# CONFIG_SOUND is not set

#
# HID support
#
CONFIG_HID=y
# CONFIG_HID_BATTERY_STRENGTH is not set
# CONFIG_HIDRAW is not set
CONFIG_UHID=y
# CONFIG_HID_GENERIC is not set

#
# Special HID drivers
#
# CONFIG_HID_A4TECH is not set
CONFIG_HID_ACCUTOUCH=y
# CONFIG_HID_ACRUX is not set
CONFIG_HID_APPLE=y
CONFIG_HID_APPLEIR=y
# CONFIG_HID_ASUS is not set
CONFIG_HID_AUREAL=y
# CONFIG_HID_BELKIN is not set
# CONFIG_HID_BETOP_FF is not set
CONFIG_HID_BIGBEN_FF=y
CONFIG_HID_CHERRY=y
CONFIG_HID_CHICONY=y
# CONFIG_HID_CORSAIR is not set
CONFIG_HID_COUGAR=y
CONFIG_HID_MACALLY=y
CONFIG_HID_CMEDIA=y
CONFIG_HID_CREATIVE_SB0540=y
CONFIG_HID_CYPRESS=y
CONFIG_HID_DRAGONRISE=y
CONFIG_DRAGONRISE_FF=y
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELAN is not set
# CONFIG_HID_ELECOM is not set
CONFIG_HID_ELO=y
CONFIG_HID_EZKEY=y
# CONFIG_HID_GEMBIRD is not set
CONFIG_HID_GFRM=y
# CONFIG_HID_GLORIOUS is not set
CONFIG_HID_HOLTEK=y
# CONFIG_HOLTEK_FF is not set
CONFIG_HID_VIVALDI_COMMON=y
CONFIG_HID_GOOGLE_HAMMER=y
# CONFIG_HID_VIVALDI is not set
CONFIG_HID_GT683R=y
CONFIG_HID_KEYTOUCH=y
# CONFIG_HID_KYE is not set
CONFIG_HID_UCLOGIC=y
CONFIG_HID_WALTOP=y
CONFIG_HID_VIEWSONIC=y
# CONFIG_HID_XIAOMI is not set
CONFIG_HID_GYRATION=y
CONFIG_HID_ICADE=y
CONFIG_HID_ITE=y
CONFIG_HID_JABRA=y
# CONFIG_HID_TWINHAN is not set
CONFIG_HID_KENSINGTON=y
CONFIG_HID_LCPOWER=y
CONFIG_HID_LED=y
# CONFIG_HID_LENOVO is not set
CONFIG_HID_LETSKETCH=y
CONFIG_HID_LOGITECH=y
CONFIG_HID_LOGITECH_HIDPP=y
# CONFIG_LOGITECH_FF is not set
CONFIG_LOGIRUMBLEPAD2_FF=y
CONFIG_LOGIG940_FF=y
CONFIG_LOGIWHEELS_FF=y
# CONFIG_HID_MAGICMOUSE is not set
CONFIG_HID_MALTRON=y
CONFIG_HID_MAYFLASH=y
CONFIG_HID_MEGAWORLD_FF=y
CONFIG_HID_REDRAGON=y
# CONFIG_HID_MICROSOFT is not set
# CONFIG_HID_MONTEREY is not set
# CONFIG_HID_MULTITOUCH is not set
CONFIG_HID_NINTENDO=y
# CONFIG_NINTENDO_FF is not set
CONFIG_HID_NTI=y
CONFIG_HID_NTRIG=y
CONFIG_HID_ORTEK=y
# CONFIG_HID_PANTHERLORD is not set
# CONFIG_HID_PENMOUNT is not set
CONFIG_HID_PETALYNX=y
# CONFIG_HID_PICOLCD is not set
CONFIG_HID_PLANTRONICS=y
CONFIG_HID_PLAYSTATION=y
# CONFIG_PLAYSTATION_FF is not set
# CONFIG_HID_RAZER is not set
# CONFIG_HID_PRIMAX is not set
CONFIG_HID_RETRODE=y
# CONFIG_HID_ROCCAT is not set
CONFIG_HID_SAITEK=y
CONFIG_HID_SAMSUNG=y
CONFIG_HID_SEMITEK=y
CONFIG_HID_SIGMAMICRO=y
CONFIG_HID_SONY=y
# CONFIG_SONY_FF is not set
CONFIG_HID_SPEEDLINK=y
CONFIG_HID_STEAM=y
CONFIG_HID_STEELSERIES=y
CONFIG_HID_SUNPLUS=y
CONFIG_HID_RMI=y
# CONFIG_HID_GREENASIA is not set
# CONFIG_HID_SMARTJOYPLUS is not set
CONFIG_HID_TIVO=y
CONFIG_HID_TOPSEED=y
# CONFIG_HID_THINGM is not set
CONFIG_HID_THRUSTMASTER=y
# CONFIG_THRUSTMASTER_FF is not set
CONFIG_HID_UDRAW_PS3=y
# CONFIG_HID_U2FZERO is not set
CONFIG_HID_WACOM=y
CONFIG_HID_WIIMOTE=y
CONFIG_HID_XINMO=y
CONFIG_HID_ZEROPLUS=y
CONFIG_ZEROPLUS_FF=y
CONFIG_HID_ZYDACRON=y
CONFIG_HID_SENSOR_HUB=y
CONFIG_HID_SENSOR_CUSTOM_SENSOR=y
CONFIG_HID_ALPS=y
CONFIG_HID_MCP2221=y
CONFIG_HID_KUNIT_TEST=y
# end of Special HID drivers

#
# USB HID support
#
CONFIG_USB_HID=y
CONFIG_HID_PID=y
# CONFIG_USB_HIDDEV is not set
# end of USB HID support

#
# I2C HID support
#
# CONFIG_I2C_HID_OF is not set
CONFIG_I2C_HID_OF_ELAN=y
CONFIG_I2C_HID_OF_GOODIX=y
# end of I2C HID support

CONFIG_I2C_HID_CORE=y
# end of HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
# CONFIG_USB_LED_TRIG is not set
# CONFIG_USB_ULPI_BUS is not set
CONFIG_USB_CONN_GPIO=y
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
# CONFIG_USB_ANNOUNCE_NEW_DEVICES is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=y
# CONFIG_USB_FEW_INIT_RETRIES is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
CONFIG_USB_OTG_PRODUCTLIST=y
CONFIG_USB_OTG_DISABLE_EXTERNAL_HUB=y
# CONFIG_USB_LEDS_TRIGGER_USBPORT is not set
CONFIG_USB_AUTOSUSPEND_DELAY=2
CONFIG_USB_MON=y

#
# USB Host Controller Drivers
#
CONFIG_USB_C67X00_HCD=y
CONFIG_USB_XHCI_HCD=y
# CONFIG_USB_XHCI_PCI_RENESAS is not set
CONFIG_USB_XHCI_PLATFORM=y
# CONFIG_USB_XHCI_HISTB is not set
CONFIG_USB_XHCI_MTK=y
# CONFIG_USB_XHCI_MVEBU is not set
CONFIG_USB_XHCI_RCAR=y
CONFIG_USB_EHCI_BRCMSTB=y
CONFIG_USB_BRCMSTB=y
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_EHCI_FSL=y
CONFIG_USB_EHCI_HCD_NPCM7XX=y
CONFIG_USB_EHCI_HCD_ORION=y
CONFIG_USB_EHCI_HCD_SPEAR=y
CONFIG_USB_EHCI_HCD_STI=y
# CONFIG_USB_EHCI_HCD_AT91 is not set
# CONFIG_USB_EHCI_SH is not set
CONFIG_USB_EHCI_EXYNOS=y
CONFIG_USB_EHCI_MV=y
CONFIG_USB_CNS3XXX_EHCI=y
CONFIG_USB_EHCI_HCD_PLATFORM=y
CONFIG_USB_OXU210HP_HCD=y
# CONFIG_USB_ISP116X_HCD is not set
CONFIG_USB_ISP1362_HCD=y
CONFIG_USB_FOTG210_HCD=y
CONFIG_USB_MAX3421_HCD=y
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_HCD_SPEAR=y
CONFIG_USB_OHCI_HCD_STI=y
CONFIG_USB_OHCI_HCD_S3C2410=y
CONFIG_USB_OHCI_HCD_LPC32XX=y
CONFIG_USB_OHCI_HCD_AT91=y
# CONFIG_USB_OHCI_HCD_OMAP3 is not set
# CONFIG_USB_OHCI_HCD_DAVINCI is not set
# CONFIG_USB_OHCI_HCD_SSB is not set
CONFIG_USB_OHCI_SH=y
# CONFIG_USB_OHCI_EXYNOS is not set
# CONFIG_USB_CNS3XXX_OHCI is not set
CONFIG_USB_OHCI_HCD_PLATFORM=y
# CONFIG_USB_U132_HCD is not set
# CONFIG_USB_SL811_HCD is not set
CONFIG_USB_R8A66597_HCD=y
CONFIG_USB_RENESAS_USBHS_HCD=y
CONFIG_USB_HCD_BCMA=y
CONFIG_USB_HCD_SSB=y
# CONFIG_USB_HCD_TEST_MODE is not set
CONFIG_USB_RENESAS_USBHS=y

#
# USB Device Class drivers
#
CONFIG_USB_PRINTER=y
# CONFIG_USB_WDM is not set
CONFIG_USB_TMC=y

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=y
# CONFIG_USB_STORAGE_DEBUG is not set
CONFIG_USB_STORAGE_REALTEK=y
# CONFIG_USB_STORAGE_DATAFAB is not set
CONFIG_USB_STORAGE_FREECOM=y
CONFIG_USB_STORAGE_ISD200=y
CONFIG_USB_STORAGE_USBAT=y
# CONFIG_USB_STORAGE_SDDR09 is not set
CONFIG_USB_STORAGE_SDDR55=y
CONFIG_USB_STORAGE_JUMPSHOT=y
CONFIG_USB_STORAGE_ALAUDA=y
CONFIG_USB_STORAGE_ONETOUCH=y
# CONFIG_USB_STORAGE_KARMA is not set
# CONFIG_USB_STORAGE_CYPRESS_ATACB is not set
CONFIG_USB_STORAGE_ENE_UB6250=y
# CONFIG_USB_UAS is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
CONFIG_USB_MICROTEK=y
# CONFIG_USB_CDNS_SUPPORT is not set
CONFIG_USB_MTU3=y
CONFIG_USB_MTU3_HOST=y
# CONFIG_USB_MTU3_GADGET is not set
# CONFIG_USB_MTU3_DUAL_ROLE is not set
CONFIG_USB_MTU3_DEBUG=y
CONFIG_USB_MUSB_HDRC=y
# CONFIG_USB_MUSB_HOST is not set
# CONFIG_USB_MUSB_GADGET is not set
CONFIG_USB_MUSB_DUAL_ROLE=y

#
# Platform Glue Layer
#
CONFIG_USB_MUSB_DSPS=y
# CONFIG_USB_MUSB_UX500 is not set

#
# MUSB DMA mode
#
CONFIG_MUSB_PIO_ONLY=y
CONFIG_USB_DWC3=y
# CONFIG_USB_DWC3_HOST is not set
# CONFIG_USB_DWC3_GADGET is not set
CONFIG_USB_DWC3_DUAL_ROLE=y

#
# Platform Glue Driver Support
#
CONFIG_USB_DWC3_OMAP=y
# CONFIG_USB_DWC3_EXYNOS is not set
CONFIG_USB_DWC3_KEYSTONE=y
CONFIG_USB_DWC3_MESON_G12A=y
CONFIG_USB_DWC3_OF_SIMPLE=y
# CONFIG_USB_DWC3_ST is not set
CONFIG_USB_DWC3_QCOM=y
# CONFIG_USB_DWC3_IMX8MP is not set
# CONFIG_USB_DWC3_AM62 is not set
CONFIG_USB_DWC2=y
# CONFIG_USB_DWC2_HOST is not set

#
# Gadget/Dual-role mode requires USB Gadget support to be enabled
#
# CONFIG_USB_DWC2_PERIPHERAL is not set
CONFIG_USB_DWC2_DUAL_ROLE=y
# CONFIG_USB_DWC2_DEBUG is not set
# CONFIG_USB_DWC2_TRACK_MISSED_SOFS is not set
# CONFIG_USB_CHIPIDEA is not set
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_ADUTUX is not set
CONFIG_USB_SEVSEG=y
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_CYPRESS_CY7C63 is not set
CONFIG_USB_CYTHERM=y
CONFIG_USB_IDMOUSE=y
CONFIG_USB_FTDI_ELAN=y
# CONFIG_USB_APPLEDISPLAY is not set
# CONFIG_USB_QCOM_EUD is not set
CONFIG_APPLE_MFI_FASTCHARGE=y
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_LD is not set
CONFIG_USB_TRANCEVIBRATOR=y
# CONFIG_USB_IOWARRIOR is not set
CONFIG_USB_TEST=y
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
CONFIG_USB_ISIGHTFW=y
CONFIG_USB_YUREX=y
CONFIG_USB_EZUSB_FX2=y
# CONFIG_USB_HUB_USB251XB is not set
CONFIG_USB_HSIC_USB3503=y
CONFIG_USB_HSIC_USB4604=y
# CONFIG_USB_LINK_LAYER_TEST is not set
CONFIG_USB_CHAOSKEY=y
CONFIG_BRCM_USB_PINMAP=y
CONFIG_USB_ONBOARD_HUB=y

#
# USB Physical Layer drivers
#
CONFIG_USB_PHY=y
# CONFIG_NOP_USB_XCEIV is not set
CONFIG_USB_GPIO_VBUS=y
CONFIG_TAHVO_USB=y
CONFIG_TAHVO_USB_HOST_BY_DEFAULT=y
CONFIG_USB_ISP1301=y
# CONFIG_USB_TEGRA_PHY is not set
# CONFIG_USB_ULPI is not set
CONFIG_JZ4770_PHY=y
# end of USB Physical Layer drivers

CONFIG_USB_GADGET=y
# CONFIG_USB_GADGET_DEBUG is not set
CONFIG_USB_GADGET_DEBUG_FILES=y
# CONFIG_USB_GADGET_DEBUG_FS is not set
CONFIG_USB_GADGET_VBUS_DRAW=2
CONFIG_USB_GADGET_STORAGE_NUM_BUFFERS=2

#
# USB Peripheral Controller
#
CONFIG_USB_LPC32XX=y
CONFIG_USB_FUSB300=y
CONFIG_USB_FOTG210_UDC=y
CONFIG_USB_GR_UDC=y
CONFIG_USB_R8A66597=y
CONFIG_USB_RENESAS_USBHS_UDC=y
CONFIG_USB_RENESAS_USB3=y
CONFIG_USB_PXA27X=y
CONFIG_USB_MV_UDC=y
CONFIG_USB_MV_U3D=y
CONFIG_USB_SNP_CORE=y
CONFIG_USB_SNP_UDC_PLAT=y
CONFIG_USB_M66592=y
CONFIG_USB_BDC_UDC=y
CONFIG_USB_NET2272=y
# CONFIG_USB_NET2272_DMA is not set
# CONFIG_USB_GADGET_XILINX is not set
# CONFIG_USB_MAX3420_UDC is not set
CONFIG_USB_ASPEED_UDC=y
CONFIG_USB_ASPEED_VHUB=y
CONFIG_USB_DUMMY_HCD=y
# end of USB Peripheral Controller

CONFIG_USB_LIBCOMPOSITE=y
CONFIG_USB_F_SS_LB=y
CONFIG_USB_F_MASS_STORAGE=y
CONFIG_USB_F_FS=y
CONFIG_USB_F_UVC=y
CONFIG_USB_F_HID=y
CONFIG_USB_F_PRINTER=y
CONFIG_USB_CONFIGFS=y
CONFIG_USB_CONFIGFS_MASS_STORAGE=y
CONFIG_USB_CONFIGFS_F_LB_SS=y
# CONFIG_USB_CONFIGFS_F_FS is not set
# CONFIG_USB_CONFIGFS_F_HID is not set
CONFIG_USB_CONFIGFS_F_UVC=y
CONFIG_USB_CONFIGFS_F_PRINTER=y
# CONFIG_USB_CONFIGFS_F_TCM is not set

#
# USB Gadget precomposed configurations
#
CONFIG_USB_ZERO=y
# CONFIG_USB_GADGETFS is not set
CONFIG_USB_FUNCTIONFS=y
CONFIG_USB_FUNCTIONFS_GENERIC=y
CONFIG_USB_MASS_STORAGE=y
# CONFIG_USB_GADGET_TARGET is not set
CONFIG_USB_G_PRINTER=y
CONFIG_USB_G_HID=y
CONFIG_USB_G_WEBCAM=y
CONFIG_USB_RAW_GADGET=y
# end of USB Gadget precomposed configurations

CONFIG_TYPEC=y
CONFIG_TYPEC_TCPM=y
# CONFIG_TYPEC_TCPCI is not set
CONFIG_TYPEC_FUSB302=y
CONFIG_TYPEC_UCSI=y
CONFIG_UCSI_CCG=y
CONFIG_UCSI_STM32G0=y
CONFIG_TYPEC_TPS6598X=y
CONFIG_TYPEC_ANX7411=y
# CONFIG_TYPEC_RT1719 is not set
CONFIG_TYPEC_HD3SS3220=y
CONFIG_TYPEC_STUSB160X=y
CONFIG_TYPEC_QCOM_PMIC=y
# CONFIG_TYPEC_WUSB3801 is not set

#
# USB Type-C Multiplexer/DeMultiplexer Switch support
#
CONFIG_TYPEC_MUX_FSA4480=y
# CONFIG_TYPEC_MUX_PI3USB30532 is not set
# end of USB Type-C Multiplexer/DeMultiplexer Switch support

#
# USB Type-C Alternate Mode drivers
#
CONFIG_TYPEC_DP_ALTMODE=y
# CONFIG_TYPEC_NVIDIA_ALTMODE is not set
# end of USB Type-C Alternate Mode drivers

CONFIG_USB_ROLE_SWITCH=y
CONFIG_MMC=y
# CONFIG_PWRSEQ_EMMC is not set
CONFIG_PWRSEQ_SIMPLE=y
CONFIG_MMC_BLOCK=y
CONFIG_MMC_BLOCK_MINORS=8
CONFIG_MMC_TEST=y

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_SDHCI=y
CONFIG_MMC_SDHCI_IO_ACCESSORS=y
CONFIG_MMC_SDHCI_PLTFM=y
# CONFIG_MMC_SDHCI_OF_ARASAN is not set
CONFIG_MMC_SDHCI_OF_ASPEED=y
CONFIG_MMC_SDHCI_OF_ASPEED_TEST=y
CONFIG_MMC_SDHCI_OF_AT91=y
# CONFIG_MMC_SDHCI_OF_ESDHC is not set
CONFIG_MMC_SDHCI_OF_DWCMSHC=y
# CONFIG_MMC_SDHCI_OF_SPARX5 is not set
# CONFIG_MMC_SDHCI_CADENCE is not set
CONFIG_MMC_SDHCI_CNS3XXX=y
CONFIG_MMC_SDHCI_ESDHC_IMX=y
CONFIG_MMC_SDHCI_DOVE=y
CONFIG_MMC_SDHCI_TEGRA=y
CONFIG_MMC_SDHCI_S3C=y
CONFIG_MMC_SDHCI_PXAV3=y
CONFIG_MMC_SDHCI_PXAV2=y
CONFIG_MMC_SDHCI_SPEAR=y
# CONFIG_MMC_SDHCI_S3C_DMA is not set
CONFIG_MMC_SDHCI_BCM_KONA=y
# CONFIG_MMC_SDHCI_F_SDH30 is not set
# CONFIG_MMC_SDHCI_MILBEAUT is not set
CONFIG_MMC_SDHCI_IPROC=y
CONFIG_MMC_MESON_GX=y
CONFIG_MMC_MESON_MX_SDHC=y
CONFIG_MMC_MESON_MX_SDIO=y
CONFIG_MMC_MOXART=y
# CONFIG_MMC_SDHCI_ST is not set
# CONFIG_MMC_OMAP_HS is not set
CONFIG_MMC_SDHCI_MSM=y
CONFIG_MMC_DAVINCI=y
CONFIG_MMC_SPI=y
# CONFIG_MMC_S3C is not set
CONFIG_MMC_SDHCI_SPRD=y
CONFIG_MMC_TMIO_CORE=y
# CONFIG_MMC_TMIO is not set
# CONFIG_MMC_SDHI is not set
CONFIG_MMC_UNIPHIER=y
# CONFIG_MMC_DW is not set
# CONFIG_MMC_SH_MMCIF is not set
CONFIG_MMC_VUB300=y
CONFIG_MMC_USHC=y
# CONFIG_MMC_USDHI6ROL0 is not set
# CONFIG_MMC_REALTEK_USB is not set
# CONFIG_MMC_SUNXI is not set
CONFIG_MMC_CQHCI=y
CONFIG_MMC_HSQ=y
CONFIG_MMC_BCM2835=y
CONFIG_MMC_MTK=y
# CONFIG_MMC_SDHCI_XENON is not set
CONFIG_MMC_SDHCI_OMAP=y
# CONFIG_MMC_SDHCI_AM654 is not set
CONFIG_MMC_OWL=y
CONFIG_MMC_LITEX=y
CONFIG_SCSI_UFSHCD=y
# CONFIG_SCSI_UFS_BSG is not set
CONFIG_SCSI_UFS_HPB=y
CONFIG_SCSI_UFS_HWMON=y
# CONFIG_SCSI_UFSHCD_PLATFORM is not set
# CONFIG_SCSI_UFS_TI_J721E is not set
CONFIG_MEMSTICK=y
CONFIG_MEMSTICK_DEBUG=y

#
# MemoryStick drivers
#
# CONFIG_MEMSTICK_UNSAFE_RESUME is not set
CONFIG_MSPRO_BLOCK=y
CONFIG_MS_BLOCK=y

#
# MemoryStick Host Controller Drivers
#
CONFIG_MEMSTICK_REALTEK_USB=y
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_CLASS_FLASH=y
CONFIG_LEDS_CLASS_MULTICOLOR=y
CONFIG_LEDS_BRIGHTNESS_HW_CHANGED=y

#
# LED drivers
#
CONFIG_LEDS_AN30259A=y
CONFIG_LEDS_ARIEL=y
CONFIG_LEDS_AW2013=y
# CONFIG_LEDS_BCM6328 is not set
CONFIG_LEDS_BCM6358=y
# CONFIG_LEDS_CPCAP is not set
CONFIG_LEDS_CR0014114=y
CONFIG_LEDS_EL15203000=y
# CONFIG_LEDS_TURRIS_OMNIA is not set
CONFIG_LEDS_LM3530=y
CONFIG_LEDS_LM3532=y
CONFIG_LEDS_LM3533=y
CONFIG_LEDS_LM3642=y
CONFIG_LEDS_LM3692X=y
CONFIG_LEDS_S3C24XX=y
CONFIG_LEDS_COBALT_QUBE=y
CONFIG_LEDS_COBALT_RAQ=y
# CONFIG_LEDS_PCA9532 is not set
# CONFIG_LEDS_GPIO is not set
# CONFIG_LEDS_LP3944 is not set
CONFIG_LEDS_LP3952=y
# CONFIG_LEDS_LP50XX is not set
CONFIG_LEDS_LP55XX_COMMON=y
CONFIG_LEDS_LP5521=y
CONFIG_LEDS_LP5523=y
CONFIG_LEDS_LP5562=y
# CONFIG_LEDS_LP8501 is not set
CONFIG_LEDS_LP8860=y
CONFIG_LEDS_PCA955X=y
CONFIG_LEDS_PCA955X_GPIO=y
CONFIG_LEDS_PCA963X=y
CONFIG_LEDS_WM831X_STATUS=y
CONFIG_LEDS_DA9052=y
CONFIG_LEDS_DAC124S085=y
CONFIG_LEDS_PWM=y
CONFIG_LEDS_REGULATOR=y
CONFIG_LEDS_BD2802=y
# CONFIG_LEDS_LT3593 is not set
# CONFIG_LEDS_MC13783 is not set
# CONFIG_LEDS_NS2 is not set
CONFIG_LEDS_NETXBIG=y
CONFIG_LEDS_TCA6507=y
CONFIG_LEDS_TLC591XX=y
CONFIG_LEDS_MAX77650=y
CONFIG_LEDS_MAX8997=y
CONFIG_LEDS_LM355x=y
# CONFIG_LEDS_OT200 is not set
# CONFIG_LEDS_MENF21BMC is not set
CONFIG_LEDS_IS31FL319X=y
CONFIG_LEDS_IS31FL32XX=y
CONFIG_LEDS_SC27XX_BLTC=y

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=y
# CONFIG_LEDS_SYSCON is not set
CONFIG_LEDS_MLXREG=y
CONFIG_LEDS_USER=y
CONFIG_LEDS_SPI_BYTE=y
# CONFIG_LEDS_TI_LMU_COMMON is not set
# CONFIG_LEDS_IP30 is not set
# CONFIG_LEDS_ACER_A500 is not set
# CONFIG_LEDS_BCM63138 is not set
CONFIG_LEDS_LGM=y

#
# Flash and Torch LED drivers
#
CONFIG_LEDS_AAT1290=y
CONFIG_LEDS_AS3645A=y
CONFIG_LEDS_KTD2692=y
CONFIG_LEDS_LM3601X=y
# CONFIG_LEDS_MAX77693 is not set
CONFIG_LEDS_MT6360=y
CONFIG_LEDS_RT4505=y
# CONFIG_LEDS_RT8515 is not set
# CONFIG_LEDS_SGM3140 is not set

#
# RGB LED drivers
#
CONFIG_LEDS_PWM_MULTICOLOR=y
# CONFIG_LEDS_QCOM_LPG is not set

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=y
CONFIG_LEDS_TRIGGER_ONESHOT=y
# CONFIG_LEDS_TRIGGER_HEARTBEAT is not set
CONFIG_LEDS_TRIGGER_BACKLIGHT=y
CONFIG_LEDS_TRIGGER_CPU=y
CONFIG_LEDS_TRIGGER_ACTIVITY=y
CONFIG_LEDS_TRIGGER_GPIO=y
CONFIG_LEDS_TRIGGER_DEFAULT_ON=y

#
# iptables trigger is under Netfilter config (LED target)
#
# CONFIG_LEDS_TRIGGER_TRANSIENT is not set
# CONFIG_LEDS_TRIGGER_CAMERA is not set
CONFIG_LEDS_TRIGGER_PANIC=y
CONFIG_LEDS_TRIGGER_PATTERN=y
# CONFIG_LEDS_TRIGGER_AUDIO is not set

#
# Simple LED drivers
#
CONFIG_ACCESSIBILITY=y

#
# Speakup console speech
#
# end of Speakup console speech

CONFIG_EDAC_SUPPORT=y
CONFIG_RTC_LIB=y
CONFIG_RTC_CLASS=y
# CONFIG_RTC_HCTOSYS is not set
CONFIG_RTC_SYSTOHC=y
CONFIG_RTC_SYSTOHC_DEVICE="rtc0"
# CONFIG_RTC_DEBUG is not set
CONFIG_RTC_LIB_KUNIT_TEST=y
CONFIG_RTC_NVMEM=y

#
# RTC interfaces
#
# CONFIG_RTC_INTF_SYSFS is not set
CONFIG_RTC_INTF_PROC=y
# CONFIG_RTC_INTF_DEV is not set
CONFIG_RTC_DRV_TEST=y

#
# I2C RTC drivers
#
CONFIG_RTC_DRV_88PM80X=y
# CONFIG_RTC_DRV_ABB5ZES3 is not set
CONFIG_RTC_DRV_ABEOZ9=y
CONFIG_RTC_DRV_ABX80X=y
# CONFIG_RTC_DRV_BRCMSTB is not set
CONFIG_RTC_DRV_AS3722=y
CONFIG_RTC_DRV_DS1307=y
# CONFIG_RTC_DRV_DS1307_CENTURY is not set
# CONFIG_RTC_DRV_DS1374 is not set
# CONFIG_RTC_DRV_DS1672 is not set
CONFIG_RTC_DRV_HYM8563=y
# CONFIG_RTC_DRV_MAX6900 is not set
# CONFIG_RTC_DRV_MAX8907 is not set
# CONFIG_RTC_DRV_MAX8925 is not set
CONFIG_RTC_DRV_MAX8998=y
CONFIG_RTC_DRV_MAX8997=y
CONFIG_RTC_DRV_MAX77686=y
# CONFIG_RTC_DRV_NCT3018Y is not set
# CONFIG_RTC_DRV_RS5C372 is not set
CONFIG_RTC_DRV_ISL1208=y
CONFIG_RTC_DRV_ISL12022=y
CONFIG_RTC_DRV_ISL12026=y
# CONFIG_RTC_DRV_X1205 is not set
# CONFIG_RTC_DRV_PCF8523 is not set
CONFIG_RTC_DRV_PCF85063=y
CONFIG_RTC_DRV_PCF85363=y
CONFIG_RTC_DRV_PCF8563=y
CONFIG_RTC_DRV_PCF8583=y
# CONFIG_RTC_DRV_M41T80 is not set
CONFIG_RTC_DRV_BD70528=y
# CONFIG_RTC_DRV_BQ32K is not set
# CONFIG_RTC_DRV_TPS6586X is not set
CONFIG_RTC_DRV_RC5T619=y
CONFIG_RTC_DRV_S35390A=y
# CONFIG_RTC_DRV_FM3130 is not set
# CONFIG_RTC_DRV_RX8010 is not set
CONFIG_RTC_DRV_RX8581=y
CONFIG_RTC_DRV_RX8025=y
CONFIG_RTC_DRV_EM3027=y
CONFIG_RTC_DRV_RV3028=y
CONFIG_RTC_DRV_RV3032=y
CONFIG_RTC_DRV_RV8803=y
CONFIG_RTC_DRV_S5M=y
CONFIG_RTC_DRV_SD3078=y

#
# SPI RTC drivers
#
CONFIG_RTC_DRV_M41T93=y
# CONFIG_RTC_DRV_M41T94 is not set
CONFIG_RTC_DRV_DS1302=y
# CONFIG_RTC_DRV_DS1305 is not set
CONFIG_RTC_DRV_DS1343=y
# CONFIG_RTC_DRV_DS1347 is not set
CONFIG_RTC_DRV_DS1390=y
CONFIG_RTC_DRV_MAX6916=y
CONFIG_RTC_DRV_R9701=y
CONFIG_RTC_DRV_RX4581=y
CONFIG_RTC_DRV_RS5C348=y
CONFIG_RTC_DRV_MAX6902=y
CONFIG_RTC_DRV_PCF2123=y
# CONFIG_RTC_DRV_MCP795 is not set
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
# CONFIG_RTC_DRV_DS3232 is not set
# CONFIG_RTC_DRV_PCF2127 is not set
CONFIG_RTC_DRV_RV3029C2=y
# CONFIG_RTC_DRV_RV3029_HWMON is not set
CONFIG_RTC_DRV_RX6110=y

#
# Platform RTC drivers
#
# CONFIG_RTC_DRV_DS1286 is not set
# CONFIG_RTC_DRV_DS1511 is not set
CONFIG_RTC_DRV_DS1553=y
CONFIG_RTC_DRV_DS1685_FAMILY=y
# CONFIG_RTC_DRV_DS1685 is not set
# CONFIG_RTC_DRV_DS1689 is not set
# CONFIG_RTC_DRV_DS17285 is not set
CONFIG_RTC_DRV_DS17485=y
# CONFIG_RTC_DRV_DS17885 is not set
# CONFIG_RTC_DRV_DS1742 is not set
CONFIG_RTC_DRV_DS2404=y
CONFIG_RTC_DRV_DA9052=y
CONFIG_RTC_DRV_DA9055=y
CONFIG_RTC_DRV_DA9063=y
# CONFIG_RTC_DRV_EFI is not set
# CONFIG_RTC_DRV_STK17TA8 is not set
CONFIG_RTC_DRV_M48T86=y
CONFIG_RTC_DRV_M48T35=y
# CONFIG_RTC_DRV_M48T59 is not set
CONFIG_RTC_DRV_MSM6242=y
CONFIG_RTC_DRV_BQ4802=y
# CONFIG_RTC_DRV_RP5C01 is not set
CONFIG_RTC_DRV_V3020=y
CONFIG_RTC_DRV_GAMECUBE=y
CONFIG_RTC_DRV_WM831X=y
CONFIG_RTC_DRV_SC27XX=y
CONFIG_RTC_DRV_SPEAR=y
# CONFIG_RTC_DRV_PCF50633 is not set
CONFIG_RTC_DRV_ZYNQMP=y
# CONFIG_RTC_DRV_CROS_EC is not set

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_ASM9260 is not set
CONFIG_RTC_DRV_DAVINCI=y
# CONFIG_RTC_DRV_DIGICOLOR is not set
# CONFIG_RTC_DRV_FSL_FTM_ALARM is not set
CONFIG_RTC_DRV_MESON=y
# CONFIG_RTC_DRV_MESON_VRTC is not set
CONFIG_RTC_DRV_OMAP=y
CONFIG_RTC_DRV_S3C=y
CONFIG_RTC_DRV_EP93XX=y
# CONFIG_RTC_DRV_AT91RM9200 is not set
# CONFIG_RTC_DRV_AT91SAM9 is not set
# CONFIG_RTC_DRV_RZN1 is not set
CONFIG_RTC_DRV_GENERIC=y
CONFIG_RTC_DRV_VT8500=y
# CONFIG_RTC_DRV_SUN6I is not set
CONFIG_RTC_DRV_SUNXI=y
CONFIG_RTC_DRV_MV=y
# CONFIG_RTC_DRV_ARMADA38X is not set
CONFIG_RTC_DRV_CADENCE=y
CONFIG_RTC_DRV_FTRTC010=y
CONFIG_RTC_DRV_STMP=y
CONFIG_RTC_DRV_MC13XXX=y
CONFIG_RTC_DRV_JZ4740=y
CONFIG_RTC_DRV_LPC24XX=y
CONFIG_RTC_DRV_LPC32XX=y
CONFIG_RTC_DRV_PM8XXX=y
CONFIG_RTC_DRV_TEGRA=y
CONFIG_RTC_DRV_MXC=y
CONFIG_RTC_DRV_MXC_V2=y
CONFIG_RTC_DRV_SNVS=y
# CONFIG_RTC_DRV_MOXART is not set
# CONFIG_RTC_DRV_MT2712 is not set
CONFIG_RTC_DRV_MT6397=y
CONFIG_RTC_DRV_MT7622=y
# CONFIG_RTC_DRV_XGENE is not set
# CONFIG_RTC_DRV_R7301 is not set
CONFIG_RTC_DRV_STM32=y
CONFIG_RTC_DRV_CPCAP=y
CONFIG_RTC_DRV_RTD119X=y
CONFIG_RTC_DRV_ASPEED=y
CONFIG_RTC_DRV_TI_K3=y

#
# HID Sensor RTC drivers
#
CONFIG_RTC_DRV_GOLDFISH=y
CONFIG_RTC_DRV_MSC313=y
CONFIG_RTC_DRV_POLARFIRE_SOC=y
# CONFIG_DMADEVICES is not set

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
# CONFIG_SW_SYNC is not set
CONFIG_UDMABUF=y
CONFIG_DMABUF_MOVE_NOTIFY=y
CONFIG_DMABUF_DEBUG=y
# CONFIG_DMABUF_SELFTESTS is not set
# CONFIG_DMABUF_HEAPS is not set
CONFIG_DMABUF_SYSFS_STATS=y
# end of DMABUF options

# CONFIG_AUXDISPLAY is not set
CONFIG_UIO=y
CONFIG_UIO_PDRV_GENIRQ=y
# CONFIG_UIO_DMEM_GENIRQ is not set
# CONFIG_UIO_PRUSS is not set
CONFIG_VFIO=y
CONFIG_VFIO_VIRQFD=y
CONFIG_VFIO_NOIOMMU=y
CONFIG_VFIO_PLATFORM=y
CONFIG_VFIO_AMBA=y
CONFIG_VFIO_PLATFORM_CALXEDAXGMAC_RESET=y
CONFIG_VFIO_PLATFORM_AMDXGBE_RESET=y
# CONFIG_VFIO_PLATFORM_BCMFLEXRM_RESET is not set
CONFIG_VFIO_MDEV=y
CONFIG_VIRT_DRIVERS=y
CONFIG_VIRTIO_ANCHOR=y
CONFIG_VIRTIO=y
# CONFIG_VIRTIO_MENU is not set
CONFIG_VHOST_MENU=y
# CONFIG_VHOST_SCSI is not set
CONFIG_VHOST_CROSS_ENDIAN_LEGACY=y

#
# Microsoft Hyper-V guest support
#
# end of Microsoft Hyper-V guest support

CONFIG_GREYBUS=y
CONFIG_GREYBUS_ES2=y
CONFIG_COMEDI=y
# CONFIG_COMEDI_DEBUG is not set
CONFIG_COMEDI_DEFAULT_BUF_SIZE_KB=2048
CONFIG_COMEDI_DEFAULT_BUF_MAXSIZE_KB=20480
CONFIG_COMEDI_MISC_DRIVERS=y
CONFIG_COMEDI_BOND=y
CONFIG_COMEDI_TEST=y
# CONFIG_COMEDI_PARPORT is not set
# CONFIG_COMEDI_SSV_DNP is not set
CONFIG_COMEDI_ISA_DRIVERS=y
CONFIG_COMEDI_PCL711=y
CONFIG_COMEDI_PCL724=y
CONFIG_COMEDI_PCL726=y
CONFIG_COMEDI_PCL730=y
# CONFIG_COMEDI_PCL812 is not set
CONFIG_COMEDI_PCL816=y
CONFIG_COMEDI_PCL818=y
CONFIG_COMEDI_PCM3724=y
CONFIG_COMEDI_AMPLC_DIO200_ISA=y
CONFIG_COMEDI_AMPLC_PC236_ISA=y
CONFIG_COMEDI_AMPLC_PC263_ISA=y
CONFIG_COMEDI_RTI800=y
CONFIG_COMEDI_RTI802=y
CONFIG_COMEDI_DAC02=y
CONFIG_COMEDI_DAS16M1=y
CONFIG_COMEDI_DAS08_ISA=y
# CONFIG_COMEDI_DAS16 is not set
CONFIG_COMEDI_DAS800=y
CONFIG_COMEDI_DAS1800=y
# CONFIG_COMEDI_DAS6402 is not set
CONFIG_COMEDI_DT2801=y
# CONFIG_COMEDI_DT2811 is not set
CONFIG_COMEDI_DT2814=y
# CONFIG_COMEDI_DT2815 is not set
CONFIG_COMEDI_DT2817=y
# CONFIG_COMEDI_DT282X is not set
CONFIG_COMEDI_DMM32AT=y
CONFIG_COMEDI_FL512=y
CONFIG_COMEDI_AIO_AIO12_8=y
CONFIG_COMEDI_AIO_IIRO_16=y
CONFIG_COMEDI_II_PCI20KC=y
CONFIG_COMEDI_C6XDIGIO=y
CONFIG_COMEDI_MPC624=y
CONFIG_COMEDI_ADQ12B=y
CONFIG_COMEDI_NI_AT_A2150=y
CONFIG_COMEDI_NI_AT_AO=y
CONFIG_COMEDI_NI_ATMIO=y
# CONFIG_COMEDI_NI_ATMIO16D is not set
CONFIG_COMEDI_NI_LABPC_ISA=y
CONFIG_COMEDI_PCMAD=y
CONFIG_COMEDI_PCMDA12=y
CONFIG_COMEDI_PCMMIO=y
CONFIG_COMEDI_PCMUIO=y
# CONFIG_COMEDI_MULTIQ3 is not set
CONFIG_COMEDI_S526=y
CONFIG_COMEDI_USB_DRIVERS=y
CONFIG_COMEDI_DT9812=y
# CONFIG_COMEDI_NI_USB6501 is not set
CONFIG_COMEDI_USBDUX=y
# CONFIG_COMEDI_USBDUXFAST is not set
CONFIG_COMEDI_USBDUXSIGMA=y
# CONFIG_COMEDI_VMK80XX is not set
CONFIG_COMEDI_8254=y
CONFIG_COMEDI_8255=y
CONFIG_COMEDI_8255_SA=y
CONFIG_COMEDI_KCOMEDILIB=y
CONFIG_COMEDI_AMPLC_DIO200=y
CONFIG_COMEDI_AMPLC_PC236=y
CONFIG_COMEDI_DAS08=y
CONFIG_COMEDI_NI_LABPC=y
CONFIG_COMEDI_NI_TIO=y
CONFIG_COMEDI_NI_ROUTING=y
CONFIG_COMEDI_TESTS=y
CONFIG_COMEDI_TESTS_EXAMPLE=y
CONFIG_COMEDI_TESTS_NI_ROUTES=y
CONFIG_STAGING=y
CONFIG_USB_EMXX=y
CONFIG_STAGING_MEDIA=y
CONFIG_VIDEO_HANTRO=y
# CONFIG_VIDEO_HANTRO_IMX8M is not set
# CONFIG_VIDEO_HANTRO_SAMA5D4 is not set
# CONFIG_VIDEO_HANTRO_ROCKCHIP is not set
# CONFIG_VIDEO_HANTRO_SUNXI is not set
# CONFIG_VIDEO_IMX_MEDIA is not set
CONFIG_VIDEO_MAX96712=y
CONFIG_VIDEO_MESON_VDEC=y
CONFIG_VIDEO_OMAP4=y
# CONFIG_VIDEO_ROCKCHIP_VDEC is not set
# CONFIG_VIDEO_STKWEBCAM is not set
# CONFIG_VIDEO_SUNXI is not set
# CONFIG_STAGING_BOARD is not set
CONFIG_COMMON_CLK_XLNX_CLKWZRD=y
CONFIG_FB_TFT=y
CONFIG_FB_TFT_AGM1264K_FL=y
CONFIG_FB_TFT_BD663474=y
CONFIG_FB_TFT_HX8340BN=y
CONFIG_FB_TFT_HX8347D=y
CONFIG_FB_TFT_HX8353D=y
CONFIG_FB_TFT_HX8357D=y
CONFIG_FB_TFT_ILI9163=y
# CONFIG_FB_TFT_ILI9320 is not set
# CONFIG_FB_TFT_ILI9325 is not set
CONFIG_FB_TFT_ILI9340=y
CONFIG_FB_TFT_ILI9341=y
CONFIG_FB_TFT_ILI9481=y
CONFIG_FB_TFT_ILI9486=y
CONFIG_FB_TFT_PCD8544=y
CONFIG_FB_TFT_RA8875=y
CONFIG_FB_TFT_S6D02A1=y
# CONFIG_FB_TFT_S6D1121 is not set
CONFIG_FB_TFT_SEPS525=y
CONFIG_FB_TFT_SH1106=y
CONFIG_FB_TFT_SSD1289=y
# CONFIG_FB_TFT_SSD1305 is not set
CONFIG_FB_TFT_SSD1306=y
# CONFIG_FB_TFT_SSD1331 is not set
CONFIG_FB_TFT_SSD1351=y
CONFIG_FB_TFT_ST7735R=y
CONFIG_FB_TFT_ST7789V=y
CONFIG_FB_TFT_TINYLCD=y
CONFIG_FB_TFT_TLS8204=y
# CONFIG_FB_TFT_UC1611 is not set
CONFIG_FB_TFT_UC1701=y
CONFIG_FB_TFT_UPD161704=y
CONFIG_GREYBUS_BOOTROM=y
# CONFIG_GREYBUS_FIRMWARE is not set
# CONFIG_GREYBUS_HID is not set
CONFIG_GREYBUS_LIGHT=y
# CONFIG_GREYBUS_LOG is not set
# CONFIG_GREYBUS_LOOPBACK is not set
CONFIG_GREYBUS_POWER=y
CONFIG_GREYBUS_RAW=y
CONFIG_GREYBUS_VIBRATOR=y
# CONFIG_GREYBUS_BRIDGED_PHY is not set
CONFIG_GREYBUS_ARCHE=y
CONFIG_BCM_VIDEOCORE=y
CONFIG_BCM2835_VCHIQ=y
CONFIG_VCHIQ_CDEV=y
CONFIG_VIDEO_BCM2835=y
CONFIG_BCM2835_VCHIQ_MMAL=y
CONFIG_PI433=y
CONFIG_XIL_AXIS_FIFO=y
# CONFIG_FIELDBUS_DEV is not set
CONFIG_GOLDFISH=y
CONFIG_GOLDFISH_PIPE=y
CONFIG_CHROME_PLATFORMS=y
CONFIG_CROS_EC=y
CONFIG_CROS_EC_I2C=y
CONFIG_CROS_EC_RPMSG=y
# CONFIG_CROS_EC_SPI is not set
CONFIG_CROS_EC_PROTO=y
CONFIG_CROS_KBD_LED_BACKLIGHT=y
# CONFIG_CROS_EC_CHARDEV is not set
# CONFIG_CROS_EC_LIGHTBAR is not set
CONFIG_CROS_EC_VBC=y
CONFIG_CROS_EC_DEBUGFS=y
CONFIG_CROS_EC_SENSORHUB=y
# CONFIG_CROS_EC_SYSFS is not set
CONFIG_CROS_EC_TYPEC=y
CONFIG_CROS_USBPD_LOGGER=y
CONFIG_CROS_USBPD_NOTIFY=y
CONFIG_CROS_KUNIT=y
CONFIG_MELLANOX_PLATFORM=y
# CONFIG_MLXREG_HOTPLUG is not set
CONFIG_MLXREG_IO=y
# CONFIG_MLXREG_LC is not set
# CONFIG_NVSW_SN2201 is not set
CONFIG_OLPC_XO175=y
CONFIG_SURFACE_PLATFORMS=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
CONFIG_COMMON_CLK_WM831X=y

#
# Clock driver for ARM Reference designs
#
# CONFIG_CLK_ICST is not set
# CONFIG_CLK_SP810 is not set
# end of Clock driver for ARM Reference designs

# CONFIG_CLK_HSDK is not set
CONFIG_LMK04832=y
CONFIG_COMMON_CLK_APPLE_NCO=y
CONFIG_COMMON_CLK_MAX77686=y
CONFIG_COMMON_CLK_MAX9485=y
CONFIG_COMMON_CLK_HI655X=y
# CONFIG_COMMON_CLK_SCMI is not set
CONFIG_COMMON_CLK_SCPI=y
CONFIG_COMMON_CLK_SI5341=y
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI514 is not set
CONFIG_COMMON_CLK_SI544=y
CONFIG_COMMON_CLK_SI570=y
CONFIG_COMMON_CLK_BM1880=y
CONFIG_COMMON_CLK_CDCE706=y
CONFIG_COMMON_CLK_TPS68470=y
CONFIG_COMMON_CLK_CDCE925=y
CONFIG_COMMON_CLK_CS2000_CP=y
# CONFIG_COMMON_CLK_EN7523 is not set
# CONFIG_COMMON_CLK_FSL_FLEXSPI is not set
# CONFIG_COMMON_CLK_FSL_SAI is not set
CONFIG_COMMON_CLK_GEMINI=y
CONFIG_COMMON_CLK_LAN966X=y
# CONFIG_COMMON_CLK_ASPEED is not set
CONFIG_COMMON_CLK_S2MPS11=y
# CONFIG_COMMON_CLK_AXI_CLKGEN is not set
CONFIG_CLK_QORIQ=y
CONFIG_CLK_LS1028A_PLLDIG=y
# CONFIG_COMMON_CLK_XGENE is not set
# CONFIG_COMMON_CLK_LOCHNAGAR is not set
CONFIG_COMMON_CLK_PWM=y
CONFIG_COMMON_CLK_OXNAS=y
# CONFIG_COMMON_CLK_RS9_PCIE is not set
CONFIG_COMMON_CLK_VC5=y
CONFIG_COMMON_CLK_MMP2_AUDIO=y
CONFIG_COMMON_CLK_BD718XX=y
# CONFIG_COMMON_CLK_FIXED_MMIO is not set
CONFIG_CLK_ACTIONS=y
# CONFIG_CLK_OWL_S500 is not set
CONFIG_CLK_OWL_S700=y
CONFIG_CLK_OWL_S900=y
CONFIG_CLK_ANALOGBITS_WRPLL_CLN28HPC=y
CONFIG_CLK_BAIKAL_T1=y
CONFIG_CLK_BT1_CCU_PLL=y
CONFIG_CLK_BT1_CCU_DIV=y
CONFIG_CLK_BCM2711_DVP=y
CONFIG_CLK_BCM2835=y
# CONFIG_CLK_BCM_63XX is not set
# CONFIG_CLK_BCM_63XX_GATE is not set
CONFIG_CLK_BCM_KONA=y
CONFIG_COMMON_CLK_IPROC=y
# CONFIG_CLK_BCM_CYGNUS is not set
# CONFIG_CLK_BCM_HR2 is not set
CONFIG_CLK_BCM_NSP=y
CONFIG_CLK_BCM_NS2=y
CONFIG_CLK_BCM_SR=y
CONFIG_CLK_RASPBERRYPI=y
# CONFIG_COMMON_CLK_HI3516CV300 is not set
CONFIG_COMMON_CLK_HI3519=y
CONFIG_COMMON_CLK_HI3559A=y
# CONFIG_COMMON_CLK_HI3660 is not set
CONFIG_COMMON_CLK_HI3670=y
CONFIG_COMMON_CLK_HI3798CV200=y
CONFIG_COMMON_CLK_HI6220=y
CONFIG_RESET_HISI=y
# CONFIG_STUB_CLK_HI6220 is not set
# CONFIG_STUB_CLK_HI3660 is not set
# CONFIG_COMMON_CLK_BOSTON is not set
CONFIG_MXC_CLK=y
CONFIG_CLK_IMX8MM=y
CONFIG_CLK_IMX8MN=y
CONFIG_CLK_IMX8MP=y
# CONFIG_CLK_IMX8MQ is not set
CONFIG_CLK_IMX8ULP=y
CONFIG_CLK_IMX93=y

#
# Ingenic SoCs drivers
#
CONFIG_INGENIC_CGU_COMMON=y
# CONFIG_INGENIC_CGU_JZ4740 is not set
CONFIG_INGENIC_CGU_JZ4725B=y
# CONFIG_INGENIC_CGU_JZ4760 is not set
CONFIG_INGENIC_CGU_JZ4770=y
CONFIG_INGENIC_CGU_JZ4780=y
# CONFIG_INGENIC_CGU_X1000 is not set
CONFIG_INGENIC_CGU_X1830=y
CONFIG_INGENIC_TCU_CLK=y
# end of Ingenic SoCs drivers

CONFIG_COMMON_CLK_KEYSTONE=y
CONFIG_TI_SYSCON_CLK=y

#
# Clock driver for MediaTek SoC
#
CONFIG_COMMON_CLK_MEDIATEK=y
CONFIG_COMMON_CLK_MT2701=y
CONFIG_COMMON_CLK_MT2701_MMSYS=y
CONFIG_COMMON_CLK_MT2701_IMGSYS=y
CONFIG_COMMON_CLK_MT2701_VDECSYS=y
# CONFIG_COMMON_CLK_MT2701_HIFSYS is not set
CONFIG_COMMON_CLK_MT2701_ETHSYS=y
# CONFIG_COMMON_CLK_MT2701_BDPSYS is not set
# CONFIG_COMMON_CLK_MT2701_AUDSYS is not set
CONFIG_COMMON_CLK_MT2701_G3DSYS=y
# CONFIG_COMMON_CLK_MT2712 is not set
# CONFIG_COMMON_CLK_MT6765 is not set
CONFIG_COMMON_CLK_MT6779=y
CONFIG_COMMON_CLK_MT6779_MMSYS=y
# CONFIG_COMMON_CLK_MT6779_IMGSYS is not set
CONFIG_COMMON_CLK_MT6779_IPESYS=y
CONFIG_COMMON_CLK_MT6779_CAMSYS=y
# CONFIG_COMMON_CLK_MT6779_VDECSYS is not set
CONFIG_COMMON_CLK_MT6779_VENCSYS=y
CONFIG_COMMON_CLK_MT6779_MFGCFG=y
CONFIG_COMMON_CLK_MT6779_AUDSYS=y
# CONFIG_COMMON_CLK_MT6797 is not set
# CONFIG_COMMON_CLK_MT7622 is not set
# CONFIG_COMMON_CLK_MT7629 is not set
CONFIG_COMMON_CLK_MT7986=y
CONFIG_COMMON_CLK_MT7986_ETHSYS=y
# CONFIG_COMMON_CLK_MT8135 is not set
# CONFIG_COMMON_CLK_MT8167 is not set
# CONFIG_COMMON_CLK_MT8173 is not set
# CONFIG_COMMON_CLK_MT8183 is not set
# CONFIG_COMMON_CLK_MT8186 is not set
CONFIG_COMMON_CLK_MT8192=y
CONFIG_COMMON_CLK_MT8192_AUDSYS=y
# CONFIG_COMMON_CLK_MT8192_CAMSYS is not set
# CONFIG_COMMON_CLK_MT8192_IMGSYS is not set
CONFIG_COMMON_CLK_MT8192_IMP_IIC_WRAP=y
CONFIG_COMMON_CLK_MT8192_IPESYS=y
# CONFIG_COMMON_CLK_MT8192_MDPSYS is not set
CONFIG_COMMON_CLK_MT8192_MFGCFG=y
# CONFIG_COMMON_CLK_MT8192_MMSYS is not set
# CONFIG_COMMON_CLK_MT8192_MSDC is not set
CONFIG_COMMON_CLK_MT8192_SCP_ADSP=y
# CONFIG_COMMON_CLK_MT8192_VDECSYS is not set
CONFIG_COMMON_CLK_MT8192_VENCSYS=y
# CONFIG_COMMON_CLK_MT8195 is not set
# CONFIG_COMMON_CLK_MT8516 is not set
# end of Clock driver for MediaTek SoC

#
# Clock support for Amlogic platforms
#
# end of Clock support for Amlogic platforms

# CONFIG_MSTAR_MSC313_MPLL is not set
CONFIG_MCHP_CLK_MPFS=y
# CONFIG_COMMON_CLK_PISTACHIO is not set
CONFIG_QCOM_GDSC=y
CONFIG_COMMON_CLK_QCOM=y
CONFIG_QCOM_A53PLL=y
CONFIG_QCOM_A7PLL=y
CONFIG_QCOM_CLK_APCS_MSM8916=y
# CONFIG_QCOM_CLK_APCS_SDX55 is not set
CONFIG_QCOM_CLK_RPMH=y
CONFIG_APQ_GCC_8084=y
# CONFIG_APQ_MMCC_8084 is not set
CONFIG_IPQ_APSS_PLL=y
CONFIG_IPQ_APSS_6018=y
CONFIG_IPQ_GCC_4019=y
CONFIG_IPQ_GCC_6018=y
CONFIG_IPQ_GCC_806X=y
CONFIG_IPQ_LCC_806X=y
CONFIG_IPQ_GCC_8074=y
# CONFIG_MSM_GCC_8660 is not set
CONFIG_MSM_GCC_8916=y
# CONFIG_MSM_GCC_8939 is not set
CONFIG_MSM_GCC_8960=y
# CONFIG_MSM_LCC_8960 is not set
# CONFIG_MDM_GCC_9607 is not set
# CONFIG_MDM_GCC_9615 is not set
# CONFIG_MDM_LCC_9615 is not set
# CONFIG_MSM_MMCC_8960 is not set
# CONFIG_MSM_GCC_8953 is not set
CONFIG_MSM_GCC_8974=y
CONFIG_MSM_MMCC_8974=y
# CONFIG_MSM_GCC_8976 is not set
CONFIG_MSM_MMCC_8994=y
CONFIG_MSM_GCC_8994=y
CONFIG_MSM_GCC_8996=y
CONFIG_MSM_MMCC_8996=y
CONFIG_MSM_GCC_8998=y
CONFIG_MSM_GPUCC_8998=y
# CONFIG_MSM_MMCC_8998 is not set
CONFIG_QCM_GCC_2290=y
CONFIG_QCM_DISPCC_2290=y
CONFIG_QCS_GCC_404=y
CONFIG_SC_CAMCC_7180=y
CONFIG_SC_CAMCC_7280=y
CONFIG_SC_DISPCC_7180=y
CONFIG_SC_DISPCC_7280=y
CONFIG_SC_GCC_7180=y
CONFIG_SC_GCC_7280=y
CONFIG_SC_GCC_8180X=y
CONFIG_SC_GCC_8280XP=y
# CONFIG_SC_GPUCC_7180 is not set
CONFIG_SC_GPUCC_7280=y
CONFIG_SC_LPASSCC_7280=y
CONFIG_SC_LPASS_CORECC_7180=y
CONFIG_SC_LPASS_CORECC_7280=y
CONFIG_SC_MSS_7180=y
# CONFIG_SC_VIDEOCC_7180 is not set
CONFIG_SC_VIDEOCC_7280=y
CONFIG_SDM_CAMCC_845=y
CONFIG_SDM_GCC_660=y
CONFIG_SDM_MMCC_660=y
CONFIG_SDM_GPUCC_660=y
CONFIG_QCS_TURING_404=y
# CONFIG_QCS_Q6SSTOP_404 is not set
CONFIG_SDM_GCC_845=y
# CONFIG_SDM_GPUCC_845 is not set
CONFIG_SDM_VIDEOCC_845=y
CONFIG_SDM_DISPCC_845=y
CONFIG_SDM_LPASSCC_845=y
CONFIG_SDX_GCC_55=y
CONFIG_SDX_GCC_65=y
# CONFIG_SM_CAMCC_8250 is not set
# CONFIG_SM_CAMCC_8450 is not set
CONFIG_SM_DISPCC_8250=y
CONFIG_SM_DISPCC_6350=y
# CONFIG_SM_GCC_6115 is not set
# CONFIG_SM_GCC_6125 is not set
CONFIG_SM_GCC_6350=y
CONFIG_SM_GCC_8150=y
CONFIG_SM_GCC_8250=y
CONFIG_SM_GCC_8350=y
CONFIG_SM_GCC_8450=y
CONFIG_SM_GPUCC_6350=y
CONFIG_SM_GPUCC_8150=y
CONFIG_SM_GPUCC_8250=y
CONFIG_SM_GPUCC_8350=y
# CONFIG_SM_VIDEOCC_8150 is not set
# CONFIG_SM_VIDEOCC_8250 is not set
# CONFIG_SPMI_PMIC_CLKDIV is not set
# CONFIG_QCOM_HFPLL is not set
CONFIG_KPSS_XCC=y
CONFIG_CLK_GFM_LPASS_SM8250=y
CONFIG_CLK_MT7621=y
# CONFIG_CLK_RENESAS is not set
CONFIG_COMMON_CLK_SAMSUNG=y
CONFIG_S3C64XX_COMMON_CLK=y
# CONFIG_S5PV210_COMMON_CLK is not set
# CONFIG_EXYNOS_3250_COMMON_CLK is not set
# CONFIG_EXYNOS_4_COMMON_CLK is not set
# CONFIG_EXYNOS_5250_COMMON_CLK is not set
# CONFIG_EXYNOS_5260_COMMON_CLK is not set
CONFIG_EXYNOS_5410_COMMON_CLK=y
CONFIG_EXYNOS_5420_COMMON_CLK=y
CONFIG_EXYNOS_ARM64_COMMON_CLK=y
# CONFIG_EXYNOS_AUDSS_CLK_CON is not set
CONFIG_EXYNOS_CLKOUT=y
CONFIG_S3C2410_COMMON_CLK=y
CONFIG_S3C2412_COMMON_CLK=y
CONFIG_S3C2443_COMMON_CLK=y
CONFIG_TESLA_FSD_COMMON_CLK=y
CONFIG_CLK_SIFIVE=y
CONFIG_CLK_SIFIVE_PRCI=y
# CONFIG_CLK_INTEL_SOCFPGA is not set
CONFIG_SPRD_COMMON_CLK=y
CONFIG_SPRD_SC9860_CLK=y
CONFIG_SPRD_SC9863A_CLK=y
CONFIG_CLK_STARFIVE_JH7100=y
CONFIG_CLK_STARFIVE_JH7100_AUDIO=y
# CONFIG_CLK_SUNXI is not set
CONFIG_SUNXI_CCU=y
# CONFIG_SUNIV_F1C100S_CCU is not set
CONFIG_SUN20I_D1_CCU=y
# CONFIG_SUN20I_D1_R_CCU is not set
# CONFIG_SUN50I_A64_CCU is not set
CONFIG_SUN50I_A100_CCU=y
# CONFIG_SUN50I_A100_R_CCU is not set
CONFIG_SUN50I_H6_CCU=y
CONFIG_SUN50I_H616_CCU=y
# CONFIG_SUN50I_H6_R_CCU is not set
# CONFIG_SUN4I_A10_CCU is not set
# CONFIG_SUN5I_CCU is not set
CONFIG_SUN6I_A31_CCU=y
CONFIG_SUN6I_RTC_CCU=y
CONFIG_SUN8I_A23_CCU=y
CONFIG_SUN8I_A33_CCU=y
CONFIG_SUN8I_A83T_CCU=y
# CONFIG_SUN8I_H3_CCU is not set
CONFIG_SUN8I_V3S_CCU=y
# CONFIG_SUN8I_DE2_CCU is not set
CONFIG_SUN8I_R40_CCU=y
CONFIG_SUN9I_A80_CCU=y
# CONFIG_SUN8I_R_CCU is not set
# CONFIG_COMMON_CLK_TI_ADPLL is not set
CONFIG_CLK_UNIPHIER=y
CONFIG_COMMON_CLK_VISCONTI=y
CONFIG_CLK_LGM_CGU=y
CONFIG_XILINX_VCU=y
CONFIG_COMMON_CLK_ZYNQMP=y
CONFIG_CLK_KUNIT_TEST=y
CONFIG_CLK_GATE_KUNIT_TEST=y
# CONFIG_HWSPINLOCK is not set

#
# Clock Source drivers
#
CONFIG_TIMER_OF=y
CONFIG_TIMER_PROBE=y
CONFIG_CLKSRC_MMIO=y
CONFIG_BCM2835_TIMER=y
CONFIG_BCM_KONA_TIMER=y
CONFIG_DAVINCI_TIMER=y
CONFIG_DIGICOLOR_TIMER=y
CONFIG_OMAP_DM_TIMER=y
CONFIG_DW_APB_TIMER=y
# CONFIG_FTTMR010_TIMER is not set
# CONFIG_IXP4XX_TIMER is not set
CONFIG_MESON6_TIMER=y
# CONFIG_OWL_TIMER is not set
# CONFIG_RDA_TIMER is not set
# CONFIG_SUN4I_TIMER is not set
CONFIG_SUN5I_HSTIMER=y
# CONFIG_TEGRA_TIMER is not set
# CONFIG_VT8500_TIMER is not set
# CONFIG_NPCM7XX_TIMER is not set
CONFIG_CADENCE_TTC_TIMER=y
# CONFIG_ASM9260_TIMER is not set
CONFIG_CLKSRC_DBX500_PRCMU=y
CONFIG_CLPS711X_TIMER=y
# CONFIG_MXS_TIMER is not set
# CONFIG_NSPIRE_TIMER is not set
# CONFIG_INTEGRATOR_AP_TIMER is not set
CONFIG_CLKSRC_PISTACHIO=y
# CONFIG_CLKSRC_TI_32K is not set
CONFIG_CLKSRC_STM32_LP=y
# CONFIG_CLKSRC_MPS2 is not set
# CONFIG_ARC_TIMERS is not set
# CONFIG_ARM_TIMER_SP804 is not set
CONFIG_ARMV7M_SYSTICK=y
# CONFIG_ATMEL_PIT is not set
CONFIG_ATMEL_ST=y
# CONFIG_CLKSRC_SAMSUNG_PWM is not set
# CONFIG_FSL_FTM_TIMER is not set
# CONFIG_OXNAS_RPS_TIMER is not set
# CONFIG_MTK_TIMER is not set
CONFIG_SPRD_TIMER=y
CONFIG_CLKSRC_JCORE_PIT=y
CONFIG_SH_TIMER_CMT=y
CONFIG_SH_TIMER_MTU2=y
# CONFIG_RENESAS_OSTM is not set
# CONFIG_SH_TIMER_TMU is not set
# CONFIG_EM_TIMER_STI is not set
# CONFIG_CLKSRC_VERSATILE is not set
# CONFIG_CLKSRC_PXA is not set
# CONFIG_TIMER_IMX_SYS_CTR is not set
# CONFIG_CLKSRC_ST_LPC is not set
# CONFIG_GXP_TIMER is not set
CONFIG_RISCV_TIMER=y
CONFIG_CLINT_TIMER=y
# CONFIG_MSC313E_TIMER is not set
# CONFIG_INGENIC_TIMER is not set
# CONFIG_INGENIC_SYSOST is not set
# CONFIG_INGENIC_OST is not set
# CONFIG_MICROCHIP_PIT64B is not set
# CONFIG_GOLDFISH_TIMER is not set
# end of Clock Source drivers

CONFIG_MAILBOX=y
# CONFIG_IMX_MBOX is not set
CONFIG_PLATFORM_MHU=y
CONFIG_ARMADA_37XX_RWTM_MBOX=y
# CONFIG_ROCKCHIP_MBOX is not set
CONFIG_ALTERA_MBOX=y
# CONFIG_HI3660_MBOX is not set
# CONFIG_HI6220_MBOX is not set
CONFIG_MAILBOX_TEST=y
# CONFIG_POLARFIRE_SOC_MAILBOX is not set
CONFIG_QCOM_APCS_IPC=y
CONFIG_BCM_PDC_MBOX=y
CONFIG_STM32_IPCC=y
CONFIG_MTK_ADSP_MBOX=y
CONFIG_MTK_CMDQ_MBOX=y
CONFIG_SUN6I_MSGBOX=y
CONFIG_SPRD_MBOX=y
# CONFIG_QCOM_IPCC is not set
CONFIG_IOMMU_IOVA=y
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
CONFIG_IOMMU_IO_PGTABLE=y
CONFIG_IOMMU_IO_PGTABLE_ARMV7S=y
# CONFIG_IOMMU_IO_PGTABLE_ARMV7S_SELFTEST is not set
# end of Generic IOMMU Pagetable Support

CONFIG_IOMMU_DEBUGFS=y
# CONFIG_IOMMU_DEFAULT_DMA_STRICT is not set
# CONFIG_IOMMU_DEFAULT_DMA_LAZY is not set
CONFIG_IOMMU_DEFAULT_PASSTHROUGH=y
CONFIG_OF_IOMMU=y
# CONFIG_OMAP_IOMMU is not set
CONFIG_ROCKCHIP_IOMMU=y
CONFIG_SUN50I_IOMMU=y
# CONFIG_EXYNOS_IOMMU is not set
# CONFIG_S390_CCW_IOMMU is not set
# CONFIG_S390_AP_IOMMU is not set
# CONFIG_MTK_IOMMU is not set
CONFIG_SPRD_IOMMU=y

#
# Remoteproc drivers
#
CONFIG_REMOTEPROC=y
# CONFIG_REMOTEPROC_CDEV is not set
CONFIG_INGENIC_VPU_RPROC=y
# CONFIG_MTK_SCP is not set
CONFIG_MESON_MX_AO_ARC_REMOTEPROC=y
CONFIG_RCAR_REMOTEPROC=y
# end of Remoteproc drivers

#
# Rpmsg drivers
#
CONFIG_RPMSG=y
CONFIG_RPMSG_CTRL=y
CONFIG_RPMSG_NS=y
CONFIG_RPMSG_QCOM_GLINK=y
CONFIG_RPMSG_QCOM_GLINK_RPM=y
CONFIG_RPMSG_VIRTIO=y
# end of Rpmsg drivers

# CONFIG_SOUNDWIRE is not set

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#
CONFIG_MESON_CANVAS=y
CONFIG_MESON_CLK_MEASURE=y
# CONFIG_MESON_GX_SOCINFO is not set
CONFIG_MESON_MX_SOCINFO=y
# end of Amlogic SoC drivers

#
# Apple SoC drivers
#
CONFIG_APPLE_RTKIT=y
CONFIG_APPLE_SART=y
# end of Apple SoC drivers

#
# ASPEED SoC drivers
#
# CONFIG_ASPEED_LPC_CTRL is not set
CONFIG_ASPEED_LPC_SNOOP=y
# CONFIG_ASPEED_UART_ROUTING is not set
CONFIG_ASPEED_P2A_CTRL=y
# CONFIG_ASPEED_SOCINFO is not set
# end of ASPEED SoC drivers

CONFIG_AT91_SOC_ID=y
# CONFIG_AT91_SOC_SFR is not set

#
# Broadcom SoC drivers
#
CONFIG_BCM2835_POWER=y
# CONFIG_SOC_BCM63XX is not set
# CONFIG_SOC_BRCMSTB is not set
# CONFIG_BCM_PMB is not set
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
CONFIG_QUICC_ENGINE=y
CONFIG_DPAA2_CONSOLE=y
# end of NXP/Freescale QorIQ SoC drivers

#
# fujitsu SoC drivers
#
# end of fujitsu SoC drivers

#
# i.MX SoC drivers
#
# CONFIG_SOC_IMX8M is not set
# end of i.MX SoC drivers

#
# IXP4xx SoC drivers
#
CONFIG_IXP4XX_QMGR=y
# CONFIG_IXP4XX_NPE is not set
# end of IXP4xx SoC drivers

#
# Enable LiteX SoC Builder specific drivers
#
CONFIG_LITEX=y
CONFIG_LITEX_SOC_CONTROLLER=y
# end of Enable LiteX SoC Builder specific drivers

#
# MediaTek SoC drivers
#
CONFIG_MTK_CMDQ=y
CONFIG_MTK_DEVAPC=y
CONFIG_MTK_INFRACFG=y
CONFIG_MTK_PMIC_WRAP=y
# CONFIG_MTK_SCPSYS is not set
CONFIG_MTK_MMSYS=y
# end of MediaTek SoC drivers

#
# Qualcomm SoC drivers
#
# CONFIG_QCOM_COMMAND_DB is not set
# CONFIG_QCOM_GENI_SE is not set
# CONFIG_QCOM_GSBI is not set
CONFIG_QCOM_LLCC=y
CONFIG_QCOM_RPMH=y
# CONFIG_QCOM_SMD_RPM is not set
# CONFIG_QCOM_SPM is not set
CONFIG_QCOM_WCNSS_CTRL=y
CONFIG_QCOM_ICC_BWMON=y
# end of Qualcomm SoC drivers

# CONFIG_SOC_RENESAS is not set
# CONFIG_ROCKCHIP_GRF is not set
CONFIG_ROCKCHIP_IODOMAIN=y
# CONFIG_SOC_SAMSUNG is not set
CONFIG_SIFIVE_L2=y
CONFIG_SOC_TEGRA20_VOLTAGE_COUPLER=y
# CONFIG_SOC_TEGRA30_VOLTAGE_COUPLER is not set
CONFIG_SOC_TI=y
CONFIG_UX500_SOC_ID=y

#
# Xilinx SoC drivers
#
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=y
CONFIG_DEVFREQ_GOV_PERFORMANCE=y
CONFIG_DEVFREQ_GOV_POWERSAVE=y
CONFIG_DEVFREQ_GOV_USERSPACE=y
CONFIG_DEVFREQ_GOV_PASSIVE=y

#
# DEVFREQ Drivers
#
# CONFIG_ARM_EXYNOS_BUS_DEVFREQ is not set
# CONFIG_ARM_IMX_BUS_DEVFREQ is not set
CONFIG_ARM_TEGRA_DEVFREQ=y
# CONFIG_ARM_MEDIATEK_CCI_DEVFREQ is not set
CONFIG_ARM_SUN8I_A33_MBUS_DEVFREQ=y
# CONFIG_PM_DEVFREQ_EVENT is not set
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
CONFIG_EXTCON_FSA9480=y
CONFIG_EXTCON_GPIO=y
CONFIG_EXTCON_MAX14577=y
CONFIG_EXTCON_MAX3355=y
CONFIG_EXTCON_MAX77693=y
# CONFIG_EXTCON_MAX8997 is not set
CONFIG_EXTCON_PTN5150=y
CONFIG_EXTCON_QCOM_SPMI_MISC=y
CONFIG_EXTCON_RT8973A=y
CONFIG_EXTCON_SM5502=y
CONFIG_EXTCON_USB_GPIO=y
CONFIG_EXTCON_USBC_CROS_EC=y
# CONFIG_EXTCON_USBC_TUSB320 is not set
# CONFIG_MEMORY is not set
# CONFIG_IIO is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_DEBUG is not set
CONFIG_PWM_ATMEL=y
CONFIG_PWM_ATMEL_HLCDC_PWM=y
# CONFIG_PWM_ATMEL_TCB is not set
CONFIG_PWM_BCM_IPROC=y
# CONFIG_PWM_BCM_KONA is not set
CONFIG_PWM_BCM2835=y
CONFIG_PWM_BERLIN=y
CONFIG_PWM_BRCMSTB=y
CONFIG_PWM_CLK=y
# CONFIG_PWM_CLPS711X is not set
# CONFIG_PWM_CROS_EC is not set
CONFIG_PWM_EP93XX=y
# CONFIG_PWM_FSL_FTM is not set
CONFIG_PWM_HIBVT=y
CONFIG_PWM_IMG=y
CONFIG_PWM_IMX1=y
CONFIG_PWM_IMX27=y
# CONFIG_PWM_IMX_TPM is not set
CONFIG_PWM_INTEL_LGM=y
CONFIG_PWM_IQS620A=y
# CONFIG_PWM_JZ4740 is not set
# CONFIG_PWM_KEEMBAY is not set
CONFIG_PWM_LP3943=y
CONFIG_PWM_LPC18XX_SCT=y
CONFIG_PWM_LPC32XX=y
CONFIG_PWM_LPSS=y
CONFIG_PWM_LPSS_PLATFORM=y
CONFIG_PWM_MESON=y
# CONFIG_PWM_MTK_DISP is not set
CONFIG_PWM_MEDIATEK=y
CONFIG_PWM_MXS=y
# CONFIG_PWM_OMAP_DMTIMER is not set
# CONFIG_PWM_PCA9685 is not set
# CONFIG_PWM_PXA is not set
CONFIG_PWM_RASPBERRYPI_POE=y
CONFIG_PWM_RCAR=y
# CONFIG_PWM_RENESAS_TPU is not set
CONFIG_PWM_ROCKCHIP=y
# CONFIG_PWM_SAMSUNG is not set
CONFIG_PWM_SIFIVE=y
# CONFIG_PWM_SL28CPLD is not set
CONFIG_PWM_SPEAR=y
CONFIG_PWM_SPRD=y
# CONFIG_PWM_STI is not set
CONFIG_PWM_STM32=y
# CONFIG_PWM_STM32_LP is not set
CONFIG_PWM_STMPE=y
CONFIG_PWM_SUN4I=y
CONFIG_PWM_SUNPLUS=y
# CONFIG_PWM_TEGRA is not set
CONFIG_PWM_TIECAP=y
# CONFIG_PWM_TIEHRPWM is not set
# CONFIG_PWM_VISCONTI is not set
CONFIG_PWM_VT8500=y
CONFIG_PWM_XILINX=y

#
# IRQ chip support
#
CONFIG_IRQCHIP=y
# CONFIG_AL_FIC is not set
CONFIG_MADERA_IRQ=y
# CONFIG_JCORE_AIC is not set
# CONFIG_RENESAS_INTC_IRQPIN is not set
# CONFIG_RENESAS_IRQC is not set
CONFIG_RENESAS_RZA1_IRQC=y
CONFIG_RENESAS_RZG2L_IRQC=y
CONFIG_SL28CPLD_INTC=y
CONFIG_TS4800_IRQ=y
CONFIG_XILINX_INTC=y
CONFIG_INGENIC_TCU_IRQ=y
CONFIG_IRQ_UNIPHIER_AIDET=y
# CONFIG_MESON_IRQ_GPIO is not set
CONFIG_IMX_IRQSTEER=y
CONFIG_IMX_INTMUX=y
CONFIG_RISCV_INTC=y
CONFIG_SIFIVE_PLIC=y
CONFIG_EXYNOS_IRQ_COMBINER=y
# CONFIG_MST_IRQ is not set
CONFIG_MCHP_EIC=y
# CONFIG_SUNPLUS_SP7021_INTC is not set
# end of IRQ chip support

CONFIG_IPACK_BUS=y
CONFIG_RESET_CONTROLLER=y
CONFIG_RESET_A10SR=y
CONFIG_RESET_ATH79=y
CONFIG_RESET_AXS10X=y
CONFIG_RESET_BCM6345=y
CONFIG_RESET_BERLIN=y
CONFIG_RESET_BRCMSTB=y
CONFIG_RESET_BRCMSTB_RESCAL=y
# CONFIG_RESET_HSDK is not set
# CONFIG_RESET_IMX7 is not set
CONFIG_RESET_INTEL_GW=y
CONFIG_RESET_K210=y
# CONFIG_RESET_LANTIQ is not set
# CONFIG_RESET_LPC18XX is not set
# CONFIG_RESET_MCHP_SPARX5 is not set
CONFIG_RESET_MESON=y
# CONFIG_RESET_MESON_AUDIO_ARB is not set
# CONFIG_RESET_NPCM is not set
# CONFIG_RESET_PISTACHIO is not set
CONFIG_RESET_QCOM_AOSS=y
CONFIG_RESET_QCOM_PDC=y
# CONFIG_RESET_RASPBERRYPI is not set
CONFIG_RESET_RZG2L_USBPHY_CTRL=y
CONFIG_RESET_SCMI=y
CONFIG_RESET_SIMPLE=y
# CONFIG_RESET_SOCFPGA is not set
# CONFIG_RESET_STARFIVE_JH7100 is not set
CONFIG_RESET_SUNPLUS=y
# CONFIG_RESET_SUNXI is not set
# CONFIG_RESET_TI_SCI is not set
CONFIG_RESET_TI_SYSCON=y
CONFIG_RESET_TI_TPS380X=y
# CONFIG_RESET_TN48M_CPLD is not set
CONFIG_RESET_UNIPHIER=y
CONFIG_RESET_UNIPHIER_GLUE=y
# CONFIG_RESET_ZYNQ is not set
CONFIG_COMMON_RESET_HI3660=y
CONFIG_COMMON_RESET_HI6220=y

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
CONFIG_GENERIC_PHY_MIPI_DPHY=y
# CONFIG_PHY_LPC18XX_USB_OTG is not set
CONFIG_PHY_PISTACHIO_USB=y
# CONFIG_PHY_XGENE is not set
CONFIG_USB_LGM_PHY=y
# CONFIG_PHY_CAN_TRANSCEIVER is not set
# CONFIG_PHY_SUN4I_USB is not set
CONFIG_PHY_SUN6I_MIPI_DPHY=y
CONFIG_PHY_SUN9I_USB=y
CONFIG_PHY_SUN50I_USB3=y
# CONFIG_PHY_MESON8_HDMI_TX is not set
# CONFIG_PHY_MESON8B_USB2 is not set
CONFIG_PHY_MESON_GXL_USB2=y
CONFIG_PHY_MESON_G12A_MIPI_DPHY_ANALOG=y
CONFIG_PHY_MESON_G12A_USB2=y
# CONFIG_PHY_MESON_G12A_USB3_PCIE is not set
# CONFIG_PHY_MESON_AXG_PCIE is not set
CONFIG_PHY_MESON_AXG_MIPI_PCIE_ANALOG=y
CONFIG_PHY_MESON_AXG_MIPI_DPHY=y

#
# PHY drivers for Broadcom platforms
#
# CONFIG_PHY_BCM63XX_USBH is not set
CONFIG_PHY_CYGNUS_PCIE=y
# CONFIG_PHY_BCM_SR_USB is not set
# CONFIG_BCM_KONA_USB2_PHY is not set
CONFIG_PHY_BCM_NS_USB2=y
# CONFIG_PHY_NS2_USB_DRD is not set
# CONFIG_PHY_BRCM_SATA is not set
# CONFIG_PHY_BRCM_USB is not set
CONFIG_PHY_BCM_SR_PCIE=y
# end of PHY drivers for Broadcom platforms

# CONFIG_PHY_CADENCE_TORRENT is not set
CONFIG_PHY_CADENCE_DPHY=y
CONFIG_PHY_CADENCE_DPHY_RX=y
# CONFIG_PHY_CADENCE_SIERRA is not set
CONFIG_PHY_CADENCE_SALVO=y
CONFIG_PHY_FSL_IMX8MQ_USB=y
CONFIG_PHY_MIXEL_LVDS_PHY=y
# CONFIG_PHY_MIXEL_MIPI_DPHY is not set
# CONFIG_PHY_FSL_IMX8M_PCIE is not set
CONFIG_PHY_FSL_LYNX_28G=y
# CONFIG_PHY_HI6220_USB is not set
CONFIG_PHY_HI3660_USB=y
CONFIG_PHY_HI3670_USB=y
# CONFIG_PHY_HI3670_PCIE is not set
# CONFIG_PHY_HISTB_COMBPHY is not set
CONFIG_PHY_HISI_INNO_USB2=y
# CONFIG_PHY_INGENIC_USB is not set
CONFIG_PHY_LANTIQ_VRX200_PCIE=y
CONFIG_PHY_LANTIQ_RCU_USB2=y
CONFIG_ARMADA375_USBCLUSTER_PHY=y
CONFIG_PHY_BERLIN_SATA=y
# CONFIG_PHY_BERLIN_USB is not set
CONFIG_PHY_MVEBU_A3700_UTMI=y
CONFIG_PHY_MVEBU_A38X_COMPHY=y
CONFIG_PHY_MVEBU_CP110_UTMI=y
# CONFIG_PHY_PXA_28NM_HSIC is not set
CONFIG_PHY_PXA_28NM_USB2=y
# CONFIG_PHY_PXA_USB is not set
# CONFIG_PHY_MMP3_USB is not set
CONFIG_PHY_MMP3_HSIC=y
# CONFIG_PHY_MTK_PCIE is not set
# CONFIG_PHY_MTK_TPHY is not set
# CONFIG_PHY_MTK_UFS is not set
CONFIG_PHY_MTK_XSPHY=y
CONFIG_PHY_MTK_HDMI=y
CONFIG_PHY_MTK_MIPI_DSI=y
CONFIG_PHY_MTK_DP=y
# CONFIG_PHY_SPARX5_SERDES is not set
CONFIG_PHY_LAN966X_SERDES=y
CONFIG_PHY_MAPPHONE_MDM6600=y
CONFIG_PHY_OCELOT_SERDES=y
CONFIG_PHY_ATH79_USB=y
# CONFIG_PHY_QCOM_EDP is not set
# CONFIG_PHY_QCOM_IPQ4019_USB is not set
# CONFIG_PHY_QCOM_PCIE2 is not set
# CONFIG_PHY_QCOM_QMP is not set
# CONFIG_PHY_QCOM_QUSB2 is not set
CONFIG_PHY_QCOM_USB_SNPS_FEMTO_V2=y
# CONFIG_PHY_QCOM_USB_HS_28NM is not set
CONFIG_PHY_QCOM_USB_SS=y
CONFIG_PHY_QCOM_IPQ806X_USB=y
# CONFIG_PHY_MT7621_PCI is not set
# CONFIG_PHY_RALINK_USB is not set
CONFIG_PHY_RCAR_GEN3_USB3=y
CONFIG_PHY_ROCKCHIP_DPHY_RX0=y
# CONFIG_PHY_ROCKCHIP_INNO_HDMI is not set
CONFIG_PHY_ROCKCHIP_INNO_USB2=y
CONFIG_PHY_ROCKCHIP_INNO_CSIDPHY=y
CONFIG_PHY_ROCKCHIP_INNO_DSIDPHY=y
# CONFIG_PHY_ROCKCHIP_PCIE is not set
CONFIG_PHY_ROCKCHIP_TYPEC=y
CONFIG_PHY_EXYNOS_DP_VIDEO=y
CONFIG_PHY_EXYNOS_MIPI_VIDEO=y
# CONFIG_PHY_EXYNOS_PCIE is not set
# CONFIG_PHY_SAMSUNG_UFS is not set
# CONFIG_PHY_SAMSUNG_USB2 is not set
CONFIG_PHY_UNIPHIER_USB2=y
# CONFIG_PHY_UNIPHIER_USB3 is not set
CONFIG_PHY_UNIPHIER_PCIE=y
CONFIG_PHY_UNIPHIER_AHCI=y
CONFIG_PHY_ST_SPEAR1310_MIPHY=y
# CONFIG_PHY_ST_SPEAR1340_MIPHY is not set
CONFIG_PHY_STIH407_USB=y
CONFIG_PHY_STM32_USBPHYC=y
# CONFIG_PHY_TEGRA194_P2U is not set
# CONFIG_PHY_DA8XX_USB is not set
CONFIG_PHY_DM816X_USB=y
CONFIG_PHY_AM654_SERDES=y
# CONFIG_PHY_J721E_WIZ is not set
CONFIG_OMAP_CONTROL_PHY=y
# CONFIG_TI_PIPE3 is not set
# CONFIG_PHY_INTEL_KEEMBAY_EMMC is not set
# CONFIG_PHY_INTEL_KEEMBAY_USB is not set
# CONFIG_PHY_INTEL_LGM_COMBO is not set
CONFIG_PHY_INTEL_LGM_EMMC=y
CONFIG_PHY_INTEL_THUNDERBAY_EMMC=y
CONFIG_PHY_XILINX_ZYNQMP=y
# end of PHY Subsystem

# CONFIG_POWERCAP is not set
# CONFIG_MCB is not set

#
# Performance monitor support
#
# CONFIG_ARM_CCN is not set
CONFIG_ARM_CMN=y
# CONFIG_RISCV_PMU is not set
CONFIG_FSL_IMX8_DDR_PMU=y
# CONFIG_ARM_DMC620_PMU is not set
# end of Performance monitor support

# CONFIG_RAS is not set

#
# Android
#
# CONFIG_ANDROID_BINDER_IPC is not set
# end of Android

CONFIG_DAX=y
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y
# CONFIG_NVMEM_IMX_IIM is not set
CONFIG_NVMEM_IMX_OCOTP=y
# CONFIG_JZ4780_EFUSE is not set
CONFIG_NVMEM_LPC18XX_EEPROM=y
CONFIG_NVMEM_LPC18XX_OTP=y
CONFIG_NVMEM_MXS_OCOTP=y
# CONFIG_MTK_EFUSE is not set
# CONFIG_MICROCHIP_OTPC is not set
# CONFIG_NVMEM_NINTENDO_OTP is not set
# CONFIG_QCOM_QFPROM is not set
CONFIG_NVMEM_SPMI_SDAM=y
# CONFIG_ROCKCHIP_EFUSE is not set
# CONFIG_ROCKCHIP_OTP is not set
CONFIG_NVMEM_BCM_OCOTP=y
CONFIG_NVMEM_STM32_ROMEM=y
# CONFIG_UNIPHIER_EFUSE is not set
CONFIG_NVMEM_VF610_OCOTP=y
# CONFIG_MESON_MX_EFUSE is not set
# CONFIG_NVMEM_SNVS_LPGPR is not set
# CONFIG_SC27XX_EFUSE is not set
# CONFIG_SPRD_EFUSE is not set
# CONFIG_NVMEM_RMEM is not set
# CONFIG_NVMEM_BRCM_NVRAM is not set
CONFIG_NVMEM_LAYERSCAPE_SFP=y
CONFIG_NVMEM_SUNPLUS_OCOTP=y
CONFIG_NVMEM_APPLE_EFUSES=y

#
# HW tracing support
#
CONFIG_STM=y
# CONFIG_STM_PROTO_BASIC is not set
CONFIG_STM_PROTO_SYS_T=y
CONFIG_STM_DUMMY=y
CONFIG_STM_SOURCE_CONSOLE=y
# CONFIG_STM_SOURCE_HEARTBEAT is not set
# CONFIG_STM_SOURCE_FTRACE is not set
CONFIG_INTEL_TH=y
CONFIG_INTEL_TH_GTH=y
# CONFIG_INTEL_TH_STH is not set
CONFIG_INTEL_TH_MSU=y
# CONFIG_INTEL_TH_PTI is not set
CONFIG_INTEL_TH_DEBUG=y
# end of HW tracing support

# CONFIG_FPGA is not set
# CONFIG_FSI is not set
# CONFIG_TEE is not set
CONFIG_MULTIPLEXER=y

#
# Multiplexer drivers
#
CONFIG_MUX_ADG792A=y
CONFIG_MUX_ADGS1408=y
CONFIG_MUX_GPIO=y
CONFIG_MUX_MMIO=y
# end of Multiplexer drivers

CONFIG_PM_OPP=y
CONFIG_SIOX=y
CONFIG_SIOX_BUS_GPIO=y
CONFIG_SLIMBUS=y
# CONFIG_SLIM_QCOM_CTRL is not set
CONFIG_INTERCONNECT=y
CONFIG_INTERCONNECT_IMX=y
CONFIG_INTERCONNECT_IMX8MM=y
CONFIG_INTERCONNECT_IMX8MN=y
CONFIG_INTERCONNECT_IMX8MQ=y
CONFIG_INTERCONNECT_IMX8MP=y
CONFIG_INTERCONNECT_QCOM_OSM_L3=y
# CONFIG_INTERCONNECT_SAMSUNG is not set
CONFIG_COUNTER=y
CONFIG_104_QUAD_8=y
# CONFIG_INTERRUPT_CNT is not set
CONFIG_STM32_TIMER_CNT=y
CONFIG_STM32_LPTIMER_CNT=y
CONFIG_TI_EQEP=y
# CONFIG_FTM_QUADDEC is not set
# CONFIG_MICROCHIP_TCB_CAPTURE is not set
# CONFIG_MOST is not set
CONFIG_PECI=y
CONFIG_PECI_CPU=y
CONFIG_PECI_ASPEED=y
# CONFIG_HTE is not set
# end of Device Drivers

#
# File systems
#
CONFIG_VALIDATE_FS_PARSER=y
CONFIG_FS_IOMAP=y
CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
# CONFIG_EXT2_FS_POSIX_ACL is not set
# CONFIG_EXT2_FS_SECURITY is not set
CONFIG_EXT3_FS=y
# CONFIG_EXT3_FS_POSIX_ACL is not set
CONFIG_EXT3_FS_SECURITY=y
CONFIG_EXT4_FS=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
CONFIG_EXT4_DEBUG=y
CONFIG_EXT4_KUNIT_TESTS=y
CONFIG_JBD2=y
CONFIG_JBD2_DEBUG=y
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=y
# CONFIG_REISERFS_CHECK is not set
CONFIG_REISERFS_PROC_INFO=y
# CONFIG_REISERFS_FS_XATTR is not set
CONFIG_JFS_FS=y
# CONFIG_JFS_POSIX_ACL is not set
CONFIG_JFS_SECURITY=y
# CONFIG_JFS_DEBUG is not set
CONFIG_JFS_STATISTICS=y
CONFIG_XFS_FS=y
# CONFIG_XFS_SUPPORT_V4 is not set
# CONFIG_XFS_QUOTA is not set
CONFIG_XFS_POSIX_ACL=y
# CONFIG_XFS_RT is not set
CONFIG_XFS_ONLINE_SCRUB=y
# CONFIG_XFS_ONLINE_REPAIR is not set
# CONFIG_XFS_WARN is not set
# CONFIG_XFS_DEBUG is not set
CONFIG_GFS2_FS=y
CONFIG_BTRFS_FS=y
# CONFIG_BTRFS_FS_POSIX_ACL is not set
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
CONFIG_BTRFS_FS_RUN_SANITY_TESTS=y
CONFIG_BTRFS_DEBUG=y
# CONFIG_BTRFS_ASSERT is not set
CONFIG_BTRFS_FS_REF_VERIFY=y
# CONFIG_NILFS2_FS is not set
CONFIG_F2FS_FS=y
# CONFIG_F2FS_STAT_FS is not set
CONFIG_F2FS_FS_XATTR=y
CONFIG_F2FS_FS_POSIX_ACL=y
# CONFIG_F2FS_FS_SECURITY is not set
# CONFIG_F2FS_CHECK_FS is not set
# CONFIG_F2FS_FAULT_INJECTION is not set
# CONFIG_F2FS_FS_COMPRESSION is not set
# CONFIG_F2FS_IOSTAT is not set
CONFIG_ZONEFS_FS=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
# CONFIG_FILE_LOCKING is not set
# CONFIG_FS_ENCRYPTION is not set
CONFIG_FS_VERITY=y
# CONFIG_FS_VERITY_DEBUG is not set
# CONFIG_FS_VERITY_BUILTIN_SIGNATURES is not set
# CONFIG_DNOTIFY is not set
# CONFIG_INOTIFY_USER is not set
# CONFIG_FANOTIFY is not set
CONFIG_QUOTA=y
# CONFIG_PRINT_QUOTA_WARNING is not set
CONFIG_QUOTA_DEBUG=y
CONFIG_QFMT_V1=y
# CONFIG_QFMT_V2 is not set
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=y
CONFIG_CUSE=y
CONFIG_VIRTIO_FS=y
# CONFIG_OVERLAY_FS is not set

#
# Caches
#
CONFIG_NETFS_SUPPORT=y
CONFIG_NETFS_STATS=y
CONFIG_FSCACHE=y
# CONFIG_FSCACHE_STATS is not set
CONFIG_FSCACHE_DEBUG=y
# CONFIG_CACHEFILES is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
# CONFIG_ISO9660_FS is not set
# CONFIG_UDF_FS is not set
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/EXFAT/NT Filesystems
#
CONFIG_FAT_FS=y
# CONFIG_MSDOS_FS is not set
CONFIG_VFAT_FS=y
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
# CONFIG_FAT_DEFAULT_UTF8 is not set
CONFIG_FAT_KUNIT_TEST=y
# CONFIG_EXFAT_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_NTFS3_FS is not set
# end of DOS/FAT/EXFAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_TMPFS_POSIX_ACL is not set
# CONFIG_TMPFS_XATTR is not set
CONFIG_ARCH_SUPPORTS_HUGETLBFS=y
# CONFIG_HUGETLBFS is not set
CONFIG_MEMFD_CREATE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
CONFIG_EFIVAR_FS=y
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
CONFIG_ORANGEFS_FS=y
CONFIG_ADFS_FS=y
CONFIG_ADFS_FS_RW=y
CONFIG_AFFS_FS=y
CONFIG_ECRYPT_FS=y
CONFIG_ECRYPT_FS_MESSAGING=y
# CONFIG_HFS_FS is not set
CONFIG_HFSPLUS_FS=y
# CONFIG_BEFS_FS is not set
CONFIG_BFS_FS=y
CONFIG_EFS_FS=y
CONFIG_CRAMFS=y
# CONFIG_CRAMFS_BLOCKDEV is not set
CONFIG_SQUASHFS=y
# CONFIG_SQUASHFS_FILE_CACHE is not set
CONFIG_SQUASHFS_FILE_DIRECT=y
# CONFIG_SQUASHFS_DECOMP_SINGLE is not set
CONFIG_SQUASHFS_DECOMP_MULTI=y
# CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU is not set
CONFIG_SQUASHFS_XATTR=y
# CONFIG_SQUASHFS_ZLIB is not set
# CONFIG_SQUASHFS_LZ4 is not set
CONFIG_SQUASHFS_LZO=y
CONFIG_SQUASHFS_XZ=y
# CONFIG_SQUASHFS_ZSTD is not set
# CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
# CONFIG_SQUASHFS_EMBEDDED is not set
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
CONFIG_VXFS_FS=y
CONFIG_MINIX_FS=y
CONFIG_OMFS_FS=y
CONFIG_HPFS_FS=y
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX6FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFAULT_KMSG_BYTES=10240
# CONFIG_PSTORE_DEFLATE_COMPRESS is not set
CONFIG_PSTORE_LZO_COMPRESS=y
# CONFIG_PSTORE_LZ4_COMPRESS is not set
CONFIG_PSTORE_LZ4HC_COMPRESS=y
CONFIG_PSTORE_842_COMPRESS=y
CONFIG_PSTORE_ZSTD_COMPRESS=y
CONFIG_PSTORE_COMPRESS=y
CONFIG_PSTORE_LZO_COMPRESS_DEFAULT=y
# CONFIG_PSTORE_LZ4HC_COMPRESS_DEFAULT is not set
# CONFIG_PSTORE_842_COMPRESS_DEFAULT is not set
# CONFIG_PSTORE_ZSTD_COMPRESS_DEFAULT is not set
CONFIG_PSTORE_COMPRESS_DEFAULT="lzo"
CONFIG_PSTORE_CONSOLE=y
# CONFIG_PSTORE_PMSG is not set
CONFIG_PSTORE_RAM=y
CONFIG_PSTORE_ZONE=y
CONFIG_PSTORE_BLK=y
CONFIG_PSTORE_BLK_BLKDEV=""
CONFIG_PSTORE_BLK_KMSG_SIZE=64
CONFIG_PSTORE_BLK_MAX_REASON=2
CONFIG_PSTORE_BLK_CONSOLE_SIZE=64
# CONFIG_SYSV_FS is not set
CONFIG_UFS_FS=y
# CONFIG_UFS_FS_WRITE is not set
CONFIG_UFS_DEBUG=y
# CONFIG_EROFS_FS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=y
# CONFIG_NLS_CODEPAGE_775 is not set
CONFIG_NLS_CODEPAGE_850=y
CONFIG_NLS_CODEPAGE_852=y
# CONFIG_NLS_CODEPAGE_855 is not set
CONFIG_NLS_CODEPAGE_857=y
# CONFIG_NLS_CODEPAGE_860 is not set
CONFIG_NLS_CODEPAGE_861=y
CONFIG_NLS_CODEPAGE_862=y
CONFIG_NLS_CODEPAGE_863=y
CONFIG_NLS_CODEPAGE_864=y
CONFIG_NLS_CODEPAGE_865=y
CONFIG_NLS_CODEPAGE_866=y
# CONFIG_NLS_CODEPAGE_869 is not set
CONFIG_NLS_CODEPAGE_936=y
# CONFIG_NLS_CODEPAGE_950 is not set
CONFIG_NLS_CODEPAGE_932=y
CONFIG_NLS_CODEPAGE_949=y
CONFIG_NLS_CODEPAGE_874=y
CONFIG_NLS_ISO8859_8=y
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
# CONFIG_NLS_ASCII is not set
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_ISO8859_2=y
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
CONFIG_NLS_ISO8859_9=y
CONFIG_NLS_ISO8859_13=y
CONFIG_NLS_ISO8859_14=y
CONFIG_NLS_ISO8859_15=y
CONFIG_NLS_KOI8_R=y
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_MAC_ROMAN is not set
CONFIG_NLS_MAC_CELTIC=y
CONFIG_NLS_MAC_CENTEURO=y
# CONFIG_NLS_MAC_CROATIAN is not set
# CONFIG_NLS_MAC_CYRILLIC is not set
CONFIG_NLS_MAC_GAELIC=y
CONFIG_NLS_MAC_GREEK=y
# CONFIG_NLS_MAC_ICELAND is not set
CONFIG_NLS_MAC_INUIT=y
# CONFIG_NLS_MAC_ROMANIAN is not set
CONFIG_NLS_MAC_TURKISH=y
CONFIG_NLS_UTF8=y
# CONFIG_UNICODE is not set
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_KEYS_REQUEST_CACHE is not set
# CONFIG_PERSISTENT_KEYRINGS is not set
CONFIG_BIG_KEYS=y
# CONFIG_TRUSTED_KEYS is not set
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_USER_DECRYPTED_DATA is not set
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_KEY_NOTIFICATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
# CONFIG_SECURITY_NETWORK is not set
CONFIG_SECURITY_PATH=y
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
# CONFIG_HARDENED_USERCOPY is not set
# CONFIG_FORTIFY_SOURCE is not set
CONFIG_STATIC_USERMODEHELPER=y
CONFIG_STATIC_USERMODEHELPER_PATH="/sbin/usermode-helper"
# CONFIG_SECURITY_LOADPIN is not set
# CONFIG_SECURITY_YAMA is not set
CONFIG_SECURITY_SAFESETID=y
CONFIG_SECURITY_LOCKDOWN_LSM=y
CONFIG_SECURITY_LOCKDOWN_LSM_EARLY=y
# CONFIG_LOCK_DOWN_KERNEL_FORCE_NONE is not set
CONFIG_LOCK_DOWN_KERNEL_FORCE_INTEGRITY=y
# CONFIG_LOCK_DOWN_KERNEL_FORCE_CONFIDENTIALITY is not set
# CONFIG_SECURITY_LANDLOCK is not set
CONFIG_INTEGRITY=y
CONFIG_INTEGRITY_SIGNATURE=y
CONFIG_INTEGRITY_ASYMMETRIC_KEYS=y
CONFIG_INTEGRITY_TRUSTED_KEYRING=y
# CONFIG_INTEGRITY_PLATFORM_KEYRING is not set
# CONFIG_IMA is not set
CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY=y
CONFIG_EVM=y
CONFIG_EVM_ATTR_FSUUID=y
# CONFIG_EVM_ADD_XATTRS is not set
# CONFIG_EVM_LOAD_X509 is not set
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_LSM="landlock,lockdown,yama,loadpin,safesetid,integrity,bpf"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_CC_HAS_AUTO_VAR_INIT_PATTERN=y
CONFIG_CC_HAS_AUTO_VAR_INIT_ZERO=y
CONFIG_INIT_STACK_NONE=y
# CONFIG_INIT_STACK_ALL_PATTERN is not set
# CONFIG_INIT_STACK_ALL_ZERO is not set
CONFIG_INIT_ON_ALLOC_DEFAULT_ON=y
CONFIG_INIT_ON_FREE_DEFAULT_ON=y
CONFIG_CC_HAS_ZERO_CALL_USED_REGS=y
CONFIG_ZERO_CALL_USED_REGS=y
# end of Memory initialization

# CONFIG_RANDSTRUCT_NONE is not set
# CONFIG_RANDSTRUCT_FULL is not set
CONFIG_RANDSTRUCT_PERFORMANCE=y
CONFIG_RANDSTRUCT=y
CONFIG_GCC_PLUGIN_RANDSTRUCT=y
# end of Kernel hardening options
# end of Security options

CONFIG_XOR_BLOCKS=y
CONFIG_ASYNC_CORE=y
CONFIG_ASYNC_MEMCPY=y
CONFIG_ASYNC_XOR=y
CONFIG_ASYNC_PQ=y
CONFIG_ASYNC_RAID6_RECOV=y
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_FIPS=y
CONFIG_CRYPTO_FIPS_NAME="Linux Kernel Cryptographic API"
# CONFIG_CRYPTO_FIPS_CUSTOM_VERSION is not set
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_SKCIPHER=y
CONFIG_CRYPTO_SKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=y
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
# CONFIG_CRYPTO_MANAGER_DISABLE_TESTS is not set
CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
# CONFIG_CRYPTO_CRYPTD is not set
CONFIG_CRYPTO_AUTHENC=y
CONFIG_CRYPTO_TEST=y

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
# CONFIG_CRYPTO_DH is not set
CONFIG_CRYPTO_ECC=y
CONFIG_CRYPTO_ECDH=y
CONFIG_CRYPTO_ECDSA=y
CONFIG_CRYPTO_ECRDSA=y
CONFIG_CRYPTO_SM2=y
# CONFIG_CRYPTO_CURVE25519 is not set

#
# Authenticated Encryption with Associated Data
#
# CONFIG_CRYPTO_CCM is not set
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_CHACHA20POLY1305=y
# CONFIG_CRYPTO_AEGIS128 is not set
# CONFIG_CRYPTO_SEQIV is not set
# CONFIG_CRYPTO_ECHAINIV is not set

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CFB=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=y
CONFIG_CRYPTO_OFB=y
CONFIG_CRYPTO_PCBC=y
# CONFIG_CRYPTO_XTS is not set
CONFIG_CRYPTO_KEYWRAP=y
# CONFIG_CRYPTO_ADIANTUM is not set
# CONFIG_CRYPTO_HCTR2 is not set
CONFIG_CRYPTO_ESSIV=y

#
# Hash modes
#
# CONFIG_CRYPTO_CMAC is not set
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=y
CONFIG_CRYPTO_VMAC=y

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32=y
CONFIG_CRYPTO_XXHASH=y
CONFIG_CRYPTO_BLAKE2B=y
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRC64_ROCKSOFT=y
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_POLY1305=y
CONFIG_CRYPTO_MD4=y
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=y
# CONFIG_CRYPTO_RMD160 is not set
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
# CONFIG_CRYPTO_SHA3 is not set
CONFIG_CRYPTO_SM3=y
# CONFIG_CRYPTO_SM3_GENERIC is not set
CONFIG_CRYPTO_STREEBOG=y
CONFIG_CRYPTO_WP512=y

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_AES_TI=y
CONFIG_CRYPTO_BLOWFISH=y
CONFIG_CRYPTO_BLOWFISH_COMMON=y
# CONFIG_CRYPTO_CAMELLIA is not set
CONFIG_CRYPTO_CAST_COMMON=y
CONFIG_CRYPTO_CAST5=y
CONFIG_CRYPTO_CAST6=y
# CONFIG_CRYPTO_DES is not set
# CONFIG_CRYPTO_FCRYPT is not set
CONFIG_CRYPTO_CHACHA20=y
# CONFIG_CRYPTO_ARIA is not set
CONFIG_CRYPTO_SERPENT=y
CONFIG_CRYPTO_SM4=y
CONFIG_CRYPTO_SM4_GENERIC=y
CONFIG_CRYPTO_TWOFISH=y
CONFIG_CRYPTO_TWOFISH_COMMON=y

#
# Compression
#
# CONFIG_CRYPTO_DEFLATE is not set
CONFIG_CRYPTO_LZO=y
CONFIG_CRYPTO_842=y
# CONFIG_CRYPTO_LZ4 is not set
CONFIG_CRYPTO_LZ4HC=y
CONFIG_CRYPTO_ZSTD=y

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=y
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
# CONFIG_CRYPTO_DRBG_CTR is not set
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_HASH_INFO=y
# CONFIG_CRYPTO_HW is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
CONFIG_PKCS8_PRIVATE_KEY_PARSER=y
CONFIG_PKCS7_MESSAGE_PARSER=y
CONFIG_PKCS7_TEST_KEY=y
# CONFIG_SIGNED_PE_FILE_VERIFICATION is not set
CONFIG_FIPS_SIGNATURE_SELFTEST=y

#
# Certificates for signature checking
#
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
CONFIG_SYSTEM_EXTRA_CERTIFICATE=y
CONFIG_SYSTEM_EXTRA_CERTIFICATE_SIZE=4096
CONFIG_SECONDARY_TRUSTED_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
# CONFIG_SYSTEM_REVOCATION_LIST is not set
# CONFIG_SYSTEM_BLACKLIST_AUTH_UPDATE is not set
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=y
# CONFIG_RAID6_PQ_BENCHMARK is not set
CONFIG_LINEAR_RANGES=y
CONFIG_PACKING=y
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_CORDIC=y
CONFIG_PRIME_NUMBERS=y
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_STMP_DEVICE=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=y
CONFIG_CRYPTO_LIB_CHACHA=y
# CONFIG_CRYPTO_LIB_CURVE25519 is not set
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=1
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=y
CONFIG_CRYPTO_LIB_POLY1305=y
CONFIG_CRYPTO_LIB_CHACHA20POLY1305=y
CONFIG_CRYPTO_LIB_SHA1=y
CONFIG_CRYPTO_LIB_SHA256=y
# end of Crypto library routines

CONFIG_LIB_MEMNEQ=y
# CONFIG_CRC_CCITT is not set
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC64_ROCKSOFT=y
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
CONFIG_CRC32_SELFTEST=y
# CONFIG_CRC32_SLICEBY8 is not set
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
CONFIG_CRC32_BIT=y
CONFIG_CRC64=y
# CONFIG_CRC4 is not set
CONFIG_CRC7=y
CONFIG_LIBCRC32C=y
CONFIG_CRC8=y
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_842_COMPRESS=y
CONFIG_842_DECOMPRESS=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4HC_COMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=y
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
# CONFIG_XZ_DEC_IA64 is not set
# CONFIG_XZ_DEC_ARM is not set
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
CONFIG_XZ_DEC_MICROLZMA=y
CONFIG_XZ_DEC_BCJ=y
CONFIG_XZ_DEC_TEST=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=y
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_REED_SOLOMON_ENC16=y
CONFIG_REED_SOLOMON_DEC16=y
CONFIG_BTREE=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_DMA_DECLARE_COHERENT=y
# CONFIG_DMA_API_DEBUG is not set
CONFIG_DMA_MAP_BENCHMARK=y
CONFIG_SGL_ALLOC=y
CONFIG_GLOB=y
CONFIG_GLOB_SELFTEST=y
CONFIG_GENERIC_ATOMIC64=y
CONFIG_CLZ_TAB=y
# CONFIG_IRQ_POLL is not set
CONFIG_MPILIB=y
CONFIG_SIGNATURE=y
CONFIG_LIBFDT=y
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=y
CONFIG_SG_POOL=y
CONFIG_ARCH_STACKWALK=y
CONFIG_STACKDEPOT=y
CONFIG_REF_TRACKER=y
CONFIG_SBITMAP=y
CONFIG_PARMAN=y
CONFIG_OBJAGG=y
# end of Library routines

CONFIG_GENERIC_IOREMAP=y
CONFIG_GENERIC_LIB_ASHLDI3=y
CONFIG_GENERIC_LIB_ASHRDI3=y
CONFIG_GENERIC_LIB_LSHRDI3=y
CONFIG_GENERIC_LIB_UCMPDI2=y
CONFIG_GENERIC_LIB_DEVMEM_IS_ALLOWED=y

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
CONFIG_SYMBOLIC_ERRNAME=y
CONFIG_DEBUG_BUGVERBOSE=y
# end of printk and dmesg options

CONFIG_DEBUG_KERNEL=y
# CONFIG_DEBUG_MISC is not set

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
# CONFIG_DEBUG_INFO_NONE is not set
CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_DEBUG_INFO_DWARF5 is not set
CONFIG_DEBUG_INFO_REDUCED=y
CONFIG_DEBUG_INFO_COMPRESSED=y
CONFIG_DEBUG_INFO_SPLIT=y
CONFIG_PAHOLE_HAS_SPLIT_BTF=y
# CONFIG_GDB_SCRIPTS is not set
CONFIG_FRAME_WARN=1024
# CONFIG_STRIP_ASM_SYMS is not set
CONFIG_READABLE_ASM=y
# CONFIG_HEADERS_INSTALL is not set
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_ARCH_WANT_FRAME_POINTERS=y
CONFIG_FRAME_POINTER=y
CONFIG_VMLINUX_MAP=y
CONFIG_DEBUG_FORCE_WEAK_PER_CPU=y
# end of Compile-time checks and compiler options

#
# Generic Kernel Debugging Instruments
#
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
# CONFIG_MAGIC_SYSRQ_SERIAL is not set
CONFIG_DEBUG_FS=y
# CONFIG_DEBUG_FS_ALLOW_ALL is not set
CONFIG_DEBUG_FS_DISALLOW_MOUNT=y
# CONFIG_DEBUG_FS_ALLOW_NONE is not set
CONFIG_HAVE_ARCH_KGDB=y
CONFIG_HAVE_ARCH_KGDB_QXFER_PKT=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_UBSAN is not set
CONFIG_HAVE_KCSAN_COMPILER=y
# end of Generic Kernel Debugging Instruments

#
# Networking Debugging
#
# CONFIG_NET_DEV_REFCNT_TRACKER is not set
# CONFIG_NET_NS_REFCNT_TRACKER is not set
# end of Networking Debugging

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
CONFIG_DEBUG_PAGEALLOC=y
CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT=y
CONFIG_SLUB_DEBUG=y
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_PAGE_OWNER is not set
CONFIG_PAGE_TABLE_CHECK=y
CONFIG_PAGE_TABLE_CHECK_ENFORCED=y
# CONFIG_PAGE_POISONING is not set
CONFIG_DEBUG_PAGE_REF=y
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_ARCH_HAS_DEBUG_WX=y
# CONFIG_DEBUG_WX is not set
CONFIG_GENERIC_PTDUMP=y
# CONFIG_PTDUMP_DEBUGFS is not set
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SHRINKER_DEBUG is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
CONFIG_DEBUG_STACK_USAGE=y
CONFIG_SCHED_STACK_END_CHECK=y
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
CONFIG_DEBUG_VM=y
# CONFIG_DEBUG_VM_VMACACHE is not set
CONFIG_DEBUG_VM_RB=y
# CONFIG_DEBUG_VM_PGFLAGS is not set
# CONFIG_DEBUG_VM_PGTABLE is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
CONFIG_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_MEMORY_INIT is not set
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
# end of Memory Debugging

CONFIG_DEBUG_SHIRQ=y

#
# Debug Oops, Lockups and Hangs
#
# CONFIG_PANIC_ON_OOPS is not set
CONFIG_PANIC_ON_OOPS_VALUE=0
CONFIG_PANIC_TIMEOUT=0
# CONFIG_SOFTLOCKUP_DETECTOR is not set
# CONFIG_DETECT_HUNG_TASK is not set
CONFIG_WQ_WATCHDOG=y
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# end of Scheduler Debugging

# CONFIG_DEBUG_TIMEKEEPING is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
CONFIG_PROVE_LOCKING=y
# CONFIG_PROVE_RAW_LOCK_NESTING is not set
# CONFIG_LOCK_STAT is not set
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
CONFIG_DEBUG_RWSEMS=y
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_LOCKDEP=y
CONFIG_LOCKDEP_BITS=15
CONFIG_LOCKDEP_CHAINS_BITS=16
CONFIG_LOCKDEP_STACK_TRACE_BITS=19
CONFIG_LOCKDEP_STACK_TRACE_HASH_BITS=14
CONFIG_LOCKDEP_CIRCULAR_QUEUE_BITS=12
CONFIG_DEBUG_LOCKDEP=y
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_LOCK_TORTURE_TEST is not set
# CONFIG_WW_MUTEX_SELFTEST is not set
CONFIG_SCF_TORTURE_TEST=y
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_TRACE_IRQFLAGS=y
CONFIG_DEBUG_IRQFLAGS=y
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
CONFIG_DEBUG_KOBJECT=y

#
# Debug kernel data structures
#
CONFIG_DEBUG_LIST=y
# CONFIG_DEBUG_PLIST is not set
CONFIG_DEBUG_SG=y
# CONFIG_DEBUG_NOTIFIERS is not set
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
# end of Debug kernel data structures

# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_PROVE_RCU=y
CONFIG_PROVE_RCU_LIST=y
CONFIG_TORTURE_TEST=y
CONFIG_RCU_SCALE_TEST=y
CONFIG_RCU_TORTURE_TEST=y
# CONFIG_RCU_REF_SCALE_TEST is not set
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

CONFIG_DEBUG_WQ_FORCE_RR_CPU=y
CONFIG_LATENCYTOP=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_PREEMPTIRQ_TRACEPOINTS=y
CONFIG_TRACING=y
CONFIG_TRACING_SUPPORT=y
# CONFIG_FTRACE is not set
# CONFIG_SAMPLES is not set

#
# riscv Debugging
#
# end of riscv Debugging

#
# Kernel Testing and Coverage
#
CONFIG_KUNIT=y
CONFIG_KUNIT_DEBUGFS=y
CONFIG_KUNIT_TEST=y
CONFIG_KUNIT_EXAMPLE_TEST=y
CONFIG_KUNIT_ALL_TESTS=y
CONFIG_NOTIFIER_ERROR_INJECTION=y
CONFIG_OF_RECONFIG_NOTIFIER_ERROR_INJECT=y
# CONFIG_FAULT_INJECTION is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
CONFIG_KCOV=y
CONFIG_KCOV_ENABLE_COMPARISONS=y
# CONFIG_KCOV_INSTRUMENT_ALL is not set
CONFIG_KCOV_IRQ_AREA_SIZE=0x40000
CONFIG_RUNTIME_TESTING_MENU=y
CONFIG_LKDTM=y
CONFIG_TEST_CPUMASK=y
CONFIG_TEST_LIST_SORT=y
CONFIG_TEST_MIN_HEAP=y
CONFIG_TEST_SORT=y
CONFIG_TEST_DIV64=y
CONFIG_BACKTRACE_SELF_TEST=y
CONFIG_TEST_REF_TRACKER=y
# CONFIG_RBTREE_TEST is not set
CONFIG_REED_SOLOMON_TEST=y
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_ATOMIC64_SELFTEST is not set
# CONFIG_ASYNC_RAID6_TEST is not set
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_STRING_SELFTEST is not set
CONFIG_TEST_STRING_HELPERS=y
CONFIG_TEST_STRSCPY=y
CONFIG_TEST_KSTRTOX=y
# CONFIG_TEST_PRINTF is not set
CONFIG_TEST_SCANF=y
CONFIG_TEST_BITMAP=y
CONFIG_TEST_UUID=y
# CONFIG_TEST_XARRAY is not set
CONFIG_TEST_RHASHTABLE=y
CONFIG_TEST_SIPHASH=y
# CONFIG_TEST_IDA is not set
# CONFIG_TEST_PARMAN is not set
# CONFIG_FIND_BIT_BENCHMARK is not set
CONFIG_TEST_FIRMWARE=y
# CONFIG_TEST_SYSCTL is not set
CONFIG_BITFIELD_KUNIT=y
CONFIG_HASH_KUNIT_TEST=y
CONFIG_RESOURCE_KUNIT_TEST=y
CONFIG_SYSCTL_KUNIT_TEST=y
CONFIG_LIST_KUNIT_TEST=y
CONFIG_LINEAR_RANGES_TEST=y
CONFIG_CMDLINE_KUNIT_TEST=y
CONFIG_BITS_TEST=y
CONFIG_SLUB_KUNIT_TEST=y
CONFIG_RATIONAL_KUNIT_TEST=y
CONFIG_MEMCPY_KUNIT_TEST=y
CONFIG_OVERFLOW_KUNIT_TEST=y
CONFIG_STACKINIT_KUNIT_TEST=y
CONFIG_TEST_UDELAY=y
CONFIG_TEST_DEBUG_VIRTUAL=y
CONFIG_TEST_MEMCAT_P=y
CONFIG_TEST_OBJAGG=y
# CONFIG_TEST_MEMINIT is not set
# CONFIG_TEST_FREE_PAGES is not set
CONFIG_ARCH_USE_MEMTEST=y
# CONFIG_MEMTEST is not set
# end of Kernel Testing and Coverage

CONFIG_WARN_MISSING_DOCUMENTS=y
# CONFIG_WARN_ABI_ERRORS is not set
# end of Kernel hacking

--FPtpqf2PaFV3SNyA--
