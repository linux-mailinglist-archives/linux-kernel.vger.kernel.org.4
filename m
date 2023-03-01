Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC7146A764B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 22:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjCAVnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 16:43:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjCAVnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 16:43:31 -0500
Received: from trent.utfs.org (trent.utfs.org [94.185.90.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A50414EB2;
        Wed,  1 Mar 2023 13:43:22 -0800 (PST)
Received: from localhost (localhost [IPv6:::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by trent.utfs.org (Postfix) with ESMTPS id B3E825F8CE;
        Wed,  1 Mar 2023 22:43:20 +0100 (CET)
Date:   Wed, 1 Mar 2023 22:43:20 +0100 (CET)
From:   Christian Kujau <lists@nerdbynature.de>
To:     linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] arch/alpha/kernel: Remove form feed characters
In-Reply-To: <aa78d250-d5ad-eda4-8d5b-118d6d8d222a@nerdbynature.de>
Message-ID: <444702af-2868-bf12-448d-414f4ca22c1f@nerdbynature.de>
References: <aa78d250-d5ad-eda4-8d5b-118d6d8d222a@nerdbynature.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CC lkml, as nobody from linux-alpha responded. Yes, I know, it's entirely 
cosmetic I assume, but these control characters in a source file are 
weirding me out...

Thanks,
C.

On Mon, 27 Feb 2023, Christian Kujau wrote:
> In a recent commit ("alpha: lazy FPU switching") I noticed some ^L ("form 
> feed") characters in the assembly file. There were 18 more occurences in 
> arch/alpha/kernel, and then a handful more across the whole tree. Unless 
> there's a good reason to have these control characters in the tree, let's 
> remove those. Compile-tested only.
> 
> Signed-off-by: Christian Kujau <lists@nerdbynature.de>
> ---
> diff --git a/arch/alpha/kernel/core_apecs.c b/arch/alpha/kernel/core_apecs.c
> index 6df765ff2b10..8a84347826aa 100644
> --- a/arch/alpha/kernel/core_apecs.c
> +++ b/arch/alpha/kernel/core_apecs.c
> @@ -312,7 +312,7 @@ struct pci_ops apecs_pci_ops =
>  	.read =		apecs_read_config,
>  	.write =	apecs_write_config,
>  };
> -
> +
>  void
>  apecs_pci_tbi(struct pci_controller *hose, dma_addr_t start, dma_addr_t end)
>  {
> @@ -320,7 +320,7 @@ apecs_pci_tbi(struct pci_controller *hose, dma_addr_t start, dma_addr_t end)
>  	*(vip)APECS_IOC_TBIA = 0;
>  	mb();
>  }
> -
> +
>  void __init
>  apecs_init_arch(void)
>  {
> diff --git a/arch/alpha/kernel/core_cia.c b/arch/alpha/kernel/core_cia.c
> index 12926e9538b8..d889f81a760b 100644
> --- a/arch/alpha/kernel/core_cia.c
> +++ b/arch/alpha/kernel/core_cia.c
> @@ -246,7 +246,7 @@ struct pci_ops cia_pci_ops =
>  	.read = 	cia_read_config,
>  	.write =	cia_write_config,
>  };
> -
> +
>  /*
>   * CIA Pass 1 and PYXIS Pass 1 and 2 have a broken scatter-gather tlb.
>   * It cannot be invalidated.  Rather than hard code the pass numbers,
> @@ -558,7 +558,7 @@ verify_tb_operation(void)
>  	alpha_mv.mv_pci_tbi = NULL;
>  	goto exit;
>  }
> -
> +
>  #if defined(ALPHA_RESTORE_SRM_SETUP)
>  /* Save CIA configuration data as the console had it set up.  */
>  struct 
> @@ -629,7 +629,6 @@ cia_restore_srm_settings(void)
>  #define cia_restore_srm_settings()	do {} while (0)
>  #endif /* ALPHA_RESTORE_SRM_SETUP */
>  
> -
>  static void __init
>  do_init_arch(int is_pyxis)
>  {
> diff --git a/arch/alpha/kernel/core_irongate.c b/arch/alpha/kernel/core_irongate.c
> index 6b8ed12936b6..eeeaab1e1191 100644
> --- a/arch/alpha/kernel/core_irongate.c
> +++ b/arch/alpha/kernel/core_irongate.c
> @@ -160,7 +160,7 @@ struct pci_ops irongate_pci_ops =
>  	.read =		irongate_read_config,
>  	.write =	irongate_write_config,
>  };
> -
> +
>  int
>  irongate_pci_clr_err(void)
>  {
> diff --git a/arch/alpha/kernel/core_lca.c b/arch/alpha/kernel/core_lca.c
> index 57e0750419f2..6a7c1cd3e33b 100644
> --- a/arch/alpha/kernel/core_lca.c
> +++ b/arch/alpha/kernel/core_lca.c
> @@ -237,7 +237,7 @@ struct pci_ops lca_pci_ops =
>  	.read =		lca_read_config,
>  	.write =	lca_write_config,
>  };
> -
> +
>  void
>  lca_pci_tbi(struct pci_controller *hose, dma_addr_t start, dma_addr_t end)
>  {
> @@ -245,7 +245,7 @@ lca_pci_tbi(struct pci_controller *hose, dma_addr_t start, dma_addr_t end)
>  	*(vulp)LCA_IOC_TBIA = 0;
>  	mb();
>  }
> -
> +
>  void __init
>  lca_init_arch(void)
>  {
> diff --git a/arch/alpha/kernel/core_marvel.c b/arch/alpha/kernel/core_marvel.c
> index e9348aec4649..cd1ced6cfcc1 100644
> --- a/arch/alpha/kernel/core_marvel.c
> +++ b/arch/alpha/kernel/core_marvel.c
> @@ -29,7 +29,6 @@
>  #include "proto.h"
>  #include "pci_impl.h"
>  
> -
>  /*
>   * Debug helpers
>   */
> @@ -41,13 +40,11 @@
>  # define DBG_CFG(args)
>  #endif
>  
> -
>  /*
>   * Private data
>   */
>  static struct io7 *io7_head = NULL;
>  
> -
>  /*
>   * Helper functions
>   */
> @@ -197,7 +194,6 @@ io7_clear_errors(struct io7 *io7)
>  	p7csrs->PO7_CRRCT_SYM.csr = -1UL;
>  }
>  
> -
>  /*
>   * IO7 PCI, PCI/X, AGP configuration.
>   */
> @@ -471,7 +467,6 @@ marvel_kill_arch(int mode)
>  {
>  }
>  
> -
>  /*
>   * PCI Configuration Space access functions
>   *
> @@ -599,7 +594,6 @@ struct pci_ops marvel_pci_ops =
>  	.write = 	marvel_write_config,
>  };
>  
> -
>  /*
>   * Other PCI helper functions.
>   */
> @@ -614,8 +608,6 @@ marvel_pci_tbi(struct pci_controller *hose, dma_addr_t start, dma_addr_t end)
>  	csrs->POx_SG_TBIA.csr;
>  }
>  
> -
> -
>  /*
>   * RTC Support
>   */
> @@ -676,7 +668,6 @@ __marvel_rtc_io(u8 b, unsigned long addr, int write)
>  	return ret;
>  }
>  
> -
>  /*
>   * IO map support.
>   */
> diff --git a/arch/alpha/kernel/core_mcpcia.c b/arch/alpha/kernel/core_mcpcia.c
> index 74b1d018124c..e7f5ecb31991 100644
> --- a/arch/alpha/kernel/core_mcpcia.c
> +++ b/arch/alpha/kernel/core_mcpcia.c
> @@ -241,7 +241,7 @@ struct pci_ops mcpcia_pci_ops =
>  	.read =		mcpcia_read_config,
>  	.write =	mcpcia_write_config,
>  };
> -
> +
>  void
>  mcpcia_pci_tbi(struct pci_controller *hose, dma_addr_t start, dma_addr_t end)
>  {
> @@ -249,7 +249,7 @@ mcpcia_pci_tbi(struct pci_controller *hose, dma_addr_t start, dma_addr_t end)
>  	*(vuip)MCPCIA_SG_TBIA(MCPCIA_HOSE2MID(hose->index)) = 0;
>  	mb();
>  }
> -
> +
>  static int __init
>  mcpcia_probe_hose(int h)
>  {
> diff --git a/arch/alpha/kernel/core_polaris.c b/arch/alpha/kernel/core_polaris.c
> index 75d622d96ff2..797b1bda0ec8 100644
> --- a/arch/alpha/kernel/core_polaris.c
> +++ b/arch/alpha/kernel/core_polaris.c
> @@ -142,7 +142,7 @@ struct pci_ops polaris_pci_ops =
>  	.read =		polaris_read_config,
>  	.write =	polaris_write_config,
>  };
> -
> +
>  void __init
>  polaris_init_arch(void)
>  {
> diff --git a/arch/alpha/kernel/core_t2.c b/arch/alpha/kernel/core_t2.c
> index 98d5b6ff8a76..471d08eb0a13 100644
> --- a/arch/alpha/kernel/core_t2.c
> +++ b/arch/alpha/kernel/core_t2.c
> @@ -321,7 +321,7 @@ struct pci_ops t2_pci_ops =
>  	.read =		t2_read_config,
>  	.write =	t2_write_config,
>  };
> -
> +
>  static void __init
>  t2_direct_map_window1(unsigned long base, unsigned long length)
>  {
> diff --git a/arch/alpha/kernel/core_titan.c b/arch/alpha/kernel/core_titan.c
> index 77f5d68ed04b..2d8933a53274 100644
> --- a/arch/alpha/kernel/core_titan.c
> +++ b/arch/alpha/kernel/core_titan.c
> @@ -52,7 +52,6 @@ static int titan_pchip1_present;
>  # define DBG_CFG(args)
>  #endif
>  
> -
>  /*
>   * Routines to access TIG registers.
>   */
> @@ -76,7 +75,6 @@ titan_write_tig(int offset, u8 value)
>  	*tig_addr = (unsigned long)value;
>  }
>  
> -
>  /*
>   * Given a bus, device, and function number, compute resulting
>   * configuration space address
> @@ -197,7 +195,6 @@ struct pci_ops titan_pci_ops =
>  	.write =	titan_write_config,
>  };
>  
> -
>  void
>  titan_pci_tbi(struct pci_controller *hose, dma_addr_t start, dma_addr_t end)
>  {
> @@ -438,7 +435,6 @@ titan_kill_arch(int mode)
>  	titan_kill_pachips(TITAN_pachip0, TITAN_pachip1);
>  }
>  
> -
>  /*
>   * IO map support.
>   */
> @@ -571,7 +567,7 @@ EXPORT_SYMBOL(titan_ioremap);
>  EXPORT_SYMBOL(titan_iounmap);
>  EXPORT_SYMBOL(titan_is_mmio);
>  #endif
> -
> +
>  /*
>   * AGP GART Support.
>   */
> diff --git a/arch/alpha/kernel/core_tsunami.c b/arch/alpha/kernel/core_tsunami.c
> index fc1ab73f23de..e3452b38e12a 100644
> --- a/arch/alpha/kernel/core_tsunami.c
> +++ b/arch/alpha/kernel/core_tsunami.c
> @@ -173,7 +173,7 @@ struct pci_ops tsunami_pci_ops =
>  	.read =		tsunami_read_config,
>  	.write = 	tsunami_write_config,
>  };
> -
> +
>  void
>  tsunami_pci_tbi(struct pci_controller *hose, dma_addr_t start, dma_addr_t end)
>  {
> @@ -195,7 +195,7 @@ tsunami_pci_tbi(struct pci_controller *hose, dma_addr_t start, dma_addr_t end)
>  	mb();
>  	*csr;
>  }
> -
> +
>  #ifdef NXM_MACHINE_CHECKS_ON_TSUNAMI
>  static long __init
>  tsunami_probe_read(volatile unsigned long *vaddr)
> diff --git a/arch/alpha/kernel/entry.S b/arch/alpha/kernel/entry.S
> index eb51f93a70c8..28efb455ff84 100644
> --- a/arch/alpha/kernel/entry.S
> +++ b/arch/alpha/kernel/entry.S
> @@ -429,7 +429,7 @@ CFI_START_OSF_FRAME entDbg
>  	mov	$sp, $16
>  	jsr	$31, do_entDbg
>  CFI_END_OSF_FRAME entDbg
> -
> +
>  /*
>   * The system call entry point is special.  Most importantly, it looks
>   * like a function call to userspace as far as clobbered registers.  We
> @@ -638,7 +638,7 @@ $strace_error:
>  	mov	$31, $26	/* tell "ret_from_sys_call" we can restart */
>  	br	ret_from_sys_call
>  CFI_END_OSF_FRAME entSys
> -
> +
>  /*
>   * Save and restore the switch stack -- aka the balance of the user context.
>   */
> @@ -724,7 +724,6 @@ restore_fpu:
>  	br restore_other
>  #undef V
>  
> -
>  /*
>   * The meat of the context switch code.
>   */
> @@ -780,7 +779,6 @@ ret_from_kernel_thread:
>  	br	$31, ret_to_user
>  .end ret_from_kernel_thread
>  
> -
>  /*
>   * Special system calls.  Most of these are special in that they either
>   * have to play switch_stack games.
> diff --git a/arch/alpha/kernel/err_common.c b/arch/alpha/kernel/err_common.c
> index 94e1b3dcf6d4..0b7f70154f34 100644
> --- a/arch/alpha/kernel/err_common.c
> +++ b/arch/alpha/kernel/err_common.c
> @@ -24,7 +24,6 @@
>   */
>  char *err_print_prefix = KERN_NOTICE;
>  
> -
>  /*
>   * Generic
>   */
> @@ -77,7 +76,6 @@ mchk_dump_logout_frame(struct el_common *mchk_header)
>  	printk("%s  -- End of Frame --\n", err_print_prefix);
>  }
>  
> -
>  /*
>   * Console Data Log
>   */
> diff --git a/arch/alpha/kernel/err_titan.c b/arch/alpha/kernel/err_titan.c
> index 0ffb2feea42a..aa0a97da527c 100644
> --- a/arch/alpha/kernel/err_titan.c
> +++ b/arch/alpha/kernel/err_titan.c
> @@ -581,7 +581,6 @@ titan_register_error_handlers(void)
>  	ev6_register_error_handlers();
>  }
>  
> -
>  /*
>   * Privateer
>   */
> diff --git a/arch/alpha/kernel/pci_iommu.c b/arch/alpha/kernel/pci_iommu.c
> index c81183935e97..259eaf563303 100644
> --- a/arch/alpha/kernel/pci_iommu.c
> +++ b/arch/alpha/kernel/pci_iommu.c
> @@ -54,7 +54,7 @@ size_for_memory(unsigned long max)
>  		max = roundup_pow_of_two(mem);
>  	return max;
>  }
> -
> +
>  struct pci_iommu_arena * __init
>  iommu_arena_new_node(int nid, struct pci_controller *hose, dma_addr_t base,
>  		     unsigned long window_size, unsigned long align)
> @@ -821,7 +821,6 @@ static int alpha_pci_supported(struct device *dev, u64 mask)
>  	return 0;
>  }
>  
> -
>  /*
>   * AGP GART extensions to the IOMMU
>   */
> diff --git a/arch/alpha/kernel/smc37c669.c b/arch/alpha/kernel/smc37c669.c
> index bbbd34586de0..f15fbc52fdfd 100644
> --- a/arch/alpha/kernel/smc37c669.c
> +++ b/arch/alpha/kernel/smc37c669.c
> @@ -1091,7 +1091,7 @@ static int SMC37c669_xlate_drq(
>  );
>  
>  static  __cacheline_aligned DEFINE_SPINLOCK(smc_lock);
> -
> +
>  /*
>  **++
>  **  FUNCTIONAL DESCRIPTION:
> @@ -1187,7 +1187,6 @@ SMC37c669_CONFIG_REGS * __init SMC37c669_detect( int index )
>      return SMC37c669;
>  }
>  
> -
>  /*
>  **++
>  **  FUNCTIONAL DESCRIPTION:
> @@ -1419,7 +1418,6 @@ unsigned int __init SMC37c669_enable_device ( unsigned int func )
>      return ret_val;
>  }
>  
> -
>  /*
>  **++
>  **  FUNCTIONAL DESCRIPTION:
> @@ -1623,7 +1621,6 @@ unsigned int __init SMC37c669_disable_device ( unsigned int func )
>      return ret_val;
>  }
>  
> -
>  /*
>  **++
>  **  FUNCTIONAL DESCRIPTION:
> @@ -1700,7 +1697,6 @@ unsigned int __init SMC37c669_configure_device (
>      return FALSE;
>  }
>  
> -
>  /*
>  **++
>  **  FUNCTIONAL DESCRIPTION:
> @@ -1787,7 +1783,6 @@ static unsigned int __init SMC37c669_is_device_enabled ( unsigned int func )
>      return ret_val;
>  }
>  
> -
>  #if 0
>  /*
>  **++
> @@ -1859,7 +1854,6 @@ static unsigned int __init SMC37c669_get_device_config (
>  }
>  #endif
>  
> -
>  /*
>  **++
>  **  FUNCTIONAL DESCRIPTION:
> @@ -1936,7 +1930,6 @@ void __init SMC37c669_display_device_info ( void )
>      }
>  }
>  
> -
>  /*
>  **++
>  **  FUNCTIONAL DESCRIPTION:
> @@ -1979,7 +1972,7 @@ static void __init SMC37c669_config_mode(
>      	wb( &SMC37c669->index_port, SMC37c669_CONFIG_OFF_KEY );
>      }
>  }
> -
> +
>  /*
>  **++
>  **  FUNCTIONAL DESCRIPTION:
> @@ -2009,7 +2002,7 @@ static unsigned char __init SMC37c669_read_config(
>  	wb(&SMC37c669->index_port, index);
>  	return rb(&SMC37c669->data_port);
>  }
> -
> +
>  /*
>  **++
>  **  FUNCTIONAL DESCRIPTION:
> @@ -2044,7 +2037,6 @@ static void __init SMC37c669_write_config(
>      wb( &SMC37c669->data_port, data );
>  }
>  
> -
>  /*
>  **++
>  **  FUNCTIONAL DESCRIPTION:
> @@ -2173,7 +2165,6 @@ static void __init SMC37c669_init_local_config ( void )
>      local_config[IDE_0].irq = 14;
>  }
>  
> -
>  /*
>  **++
>  **  FUNCTIONAL DESCRIPTION:
> @@ -2220,7 +2211,7 @@ static struct DEVICE_CONFIG * __init SMC37c669_get_config( unsigned int func )
>      }
>      return cp;
>  }
> -
> +
>  /*
>  **++
>  **  FUNCTIONAL DESCRIPTION:
> @@ -2272,7 +2263,6 @@ static int __init SMC37c669_xlate_irq ( int irq )
>      return translated_irq;
>  }
>  
> -
>  /*
>  **++
>  **  FUNCTIONAL DESCRIPTION:
> @@ -2323,7 +2313,7 @@ static int __init SMC37c669_xlate_drq ( int drq )
>      }
>      return translated_drq;
>  }
> -
> +
>  #if 0
>  int __init smcc669_init ( void )
>  {
> @@ -2338,7 +2328,7 @@ int __init smcc669_init ( void )
>  
>      return msg_success;
>  }
> -
> +
>  int __init smcc669_open( struct FILE *fp, char *info, char *next, char *mode )
>  {
>      struct INODE *ip;
> @@ -2363,7 +2353,7 @@ int __init smcc669_open( struct FILE *fp, char *info, char *next, char *mode )
>  
>      return msg_success;
>  }
> -
> +
>  int __init smcc669_close( struct FILE *fp )
>  {
>      struct INODE *ip;
> @@ -2376,7 +2366,7 @@ int __init smcc669_close( struct FILE *fp )
>      }
>      return msg_success;
>  }
> -
> +
>  int __init smcc669_read( struct FILE *fp, int size, int number, unsigned char *buf )
>  {
>      int i;
> @@ -2402,7 +2392,7 @@ int __init smcc669_read( struct FILE *fp, int size, int number, unsigned char *b
>      SMC37c669_config_mode( FALSE );
>      return nbytes;
>  }
> -
> +
>  int __init smcc669_write( struct FILE *fp, int size, int number, unsigned char *buf )
>  {
>      int i;
> diff --git a/arch/alpha/kernel/srmcons.c b/arch/alpha/kernel/srmcons.c
> index 6dc952b0df4a..72f3b7811b17 100644
> --- a/arch/alpha/kernel/srmcons.c
> +++ b/arch/alpha/kernel/srmcons.c
> @@ -232,7 +232,6 @@ srmcons_init(void)
>  }
>  device_initcall(srmcons_init);
>  
> -
>  /*
>   * The console driver
>   */
> diff --git a/arch/alpha/kernel/sys_marvel.c b/arch/alpha/kernel/sys_marvel.c
> index 1f99b03effc2..2cdf3dd8f43e 100644
> --- a/arch/alpha/kernel/sys_marvel.c
> +++ b/arch/alpha/kernel/sys_marvel.c
> @@ -33,7 +33,6 @@
>  # error NR_IRQS < MARVEL_NR_IRQS !!!
>  #endif
>  
> -
>  /*
>   * Interrupt handling.
>   */
> @@ -432,7 +431,7 @@ marvel_smp_callin(void)
>  	for (i = 0; i < 16; ++i)
>  		io7_redirect_one_msi(io7, i, cpuid);
>  }
> -
> +
>  /*
>   * System Vectors
>   */
> diff --git a/arch/alpha/kernel/sys_titan.c b/arch/alpha/kernel/sys_titan.c
> index b1f3b4fcf99b..ed7fb4660811 100644
> --- a/arch/alpha/kernel/sys_titan.c
> +++ b/arch/alpha/kernel/sys_titan.c
> @@ -36,7 +36,6 @@
>  #include "machvec_impl.h"
>  #include "err_impl.h"
>  
> -
>  /*
>   * Titan generic
>   */
> @@ -255,7 +254,6 @@ titan_dispatch_irqs(u64 mask)
>  	}
>  }
>    
> -
>  /*
>   * Titan Family
>   */
> @@ -337,7 +335,6 @@ titan_init_pci(void)
>  	locate_and_init_vga(NULL);
>  }
>  
> -
>  /*
>   * Privateer
>   */
> @@ -359,7 +356,6 @@ privateer_init_pci(void)
>  	return titan_init_pci();
>  }
>  
> -
>  /*
>   * The System Vectors.
>   */
> diff --git a/arch/alpha/kernel/time.c b/arch/alpha/kernel/time.c
> index 4d01c392ab14..cb2ed1388bf1 100644
> --- a/arch/alpha/kernel/time.c
> +++ b/arch/alpha/kernel/time.c
> @@ -80,7 +80,6 @@ static inline __u32 rpcc(void)
>  }
>  
>  
> -
>  /*
>   * The RTC as a clock_event_device primitive.
>   */
> @@ -129,7 +128,6 @@ init_rtc_clockevent(void)
>  	clockevents_config_and_register(ce, CONFIG_HZ, 0, 0);
>  }
>  
> -
>  /*
>   * The QEMU clock as a clocksource primitive.
>   */
> @@ -199,7 +197,6 @@ init_qemu_clockevent(void)
>  	clockevents_config_and_register(ce, NSEC_PER_SEC, 1000, LONG_MAX);
>  }
>  
> -
>  void __init
>  common_init_rtc(void)
>  {
> @@ -245,7 +242,6 @@ common_init_rtc(void)
>  	init_rtc_irq(NULL);
>  }
>  
> -
>  #ifndef CONFIG_ALPHA_WTINT
>  /*
>   * The RPCC as a clocksource primitive.
> @@ -275,7 +271,6 @@ static struct clocksource clocksource_rpcc = {
>  };
>  #endif /* ALPHA_WTINT */
>  
> -
>  /* Validate a computed cycle counter result against the known bounds for
>     the given processor core.  There's too much brokenness in the way of
>     timing hardware for any one method to work everywhere.  :-(
> 
> -- 
> BOFH excuse #28:
> 
> CPU radiator broken
> 

-- 
BOFH excuse #444:

overflow error in /dev/null
