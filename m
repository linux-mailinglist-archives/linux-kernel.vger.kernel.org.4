Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 713F46A1C41
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 13:36:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbjBXMgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 07:36:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbjBXMgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 07:36:35 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499D567E2C
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 04:36:32 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id n2so2101648pfo.12
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 04:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KfyagpGRW/9/Pt1Cor8C9lDPittAPPL3x8xvQelObYk=;
        b=WDnW7zZV7szrkxKiYmqTiNLdRWPWyqb5ya2IwhPJtc5N2M6qnjGN4N5hbd1ooc2m+w
         Pzn3A6v+0fXCFyv+66f8QQxul7m3eXFUJipYOyX4NAS+P3Cva3QUiUBN9ecthagIBryd
         7+Qe3Yczk4zqM/okrE3aYzlmKpWcxkGlJQZ41R+pyV/8cCInpHlmAAc+ffUvRgaR/qgY
         8TxADp9NhJefL7jEe4ADrnny5pvKmyL+8jNB4ogKM0R6f9IUujum7xevzsQvb1Qj6rdO
         RU+N80RISkkO7YqSFcFC4zszulvJJLfDmpXyb4Y/Rt4R+3TYzjnQCbFZpDDXFKOCjo/M
         CGOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KfyagpGRW/9/Pt1Cor8C9lDPittAPPL3x8xvQelObYk=;
        b=g6GwEJ6mOycBD4wecRoO8Ek+XhcpXwTl7ujsde4Mtsf7blGr7NVqvxtvlQbEwAOvxt
         s3ZkTxtkf6VjBylZjb3ND3WAJ3XgESQTLxy1Y+aHqCeFXDVopL5uILOfurLZ5Rxv4ZYW
         cUnOkzpRs5GGa79EyU//NKz8DY0mJDpuLcnmIw54yfTxZaKhAwZUh7uRza+xWwn+j8Qv
         68/GqWbxb6kqhbJR/4bhAj4vhvx+ORHRJZYqhz3tW3WhjC10kvjBFmrZP7kJTsvmgviF
         Ii3aSknAKFLi3S0yXMLRVNFahLyXzPd0N7NG4678kuT55GTTJNRhedfBx4cFU07vi4w9
         Ud3Q==
X-Gm-Message-State: AO0yUKUl+SZtIRuMyUw2xERVWXV8QdRT/RGMConrFPfRYk6fkdb0272K
        kRq6WyexDtCm38GjBohFw0G6kA==
X-Google-Smtp-Source: AK7set9YDEorAc6q0qV8uM49uq87nlZeJAonHYsUbljtziownaS3QkK/V/EI0CwokRJ27PEOuyKdEw==
X-Received: by 2002:a62:52d0:0:b0:5a8:68c0:5607 with SMTP id g199-20020a6252d0000000b005a868c05607mr11895837pfb.21.1677242191551;
        Fri, 24 Feb 2023 04:36:31 -0800 (PST)
Received: from sunil-laptop ([49.206.14.226])
        by smtp.gmail.com with ESMTPSA id k7-20020aa792c7000000b0058d92d6e4ddsm8023796pfa.5.2023.02.24.04.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 04:36:31 -0800 (PST)
Date:   Fri, 24 Feb 2023 18:06:22 +0530
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     Andrew Jones <ajones@ventanamicro.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH V2 18/21] RISC-V: Add ACPI initialization in setup_arch()
Message-ID: <Y/ivRjQbIna7M4R2@sunil-laptop>
References: <20230216182043.1946553-1-sunilvl@ventanamicro.com>
 <20230216182043.1946553-19-sunilvl@ventanamicro.com>
 <20230220200743.rev3djzbaa2jcmg6@orel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230220200743.rev3djzbaa2jcmg6@orel>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2023 at 09:07:43PM +0100, Andrew Jones wrote:
> On Thu, Feb 16, 2023 at 11:50:40PM +0530, Sunil V L wrote:
> > Initialize the ACPI core for RISC-V during boot.
> > 
> > ACPI tables and interpreter are initialized based on
> > the information passed from the firmware and the value of
> > the kernel parameter 'acpi'.
> > 
> > Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> > Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  arch/riscv/kernel/acpi.c  | 113 ++++++++++++++++++++++++++++++++++++++
> >  arch/riscv/kernel/setup.c |  25 ++++++---
> >  2 files changed, 130 insertions(+), 8 deletions(-)
> > 
> > diff --git a/arch/riscv/kernel/acpi.c b/arch/riscv/kernel/acpi.c
> > index 13b26c87c136..35e7b24a30c8 100644
> > --- a/arch/riscv/kernel/acpi.c
> > +++ b/arch/riscv/kernel/acpi.c
> > @@ -16,6 +16,7 @@
> >  #include <linux/acpi.h>
> >  #include <linux/io.h>
> >  #include <linux/pci.h>
> > +#include <linux/efi.h>
> >  
> >  int acpi_noirq = 1;		/* skip ACPI IRQ initialization */
> >  int acpi_disabled = 1;
> > @@ -26,6 +27,118 @@ EXPORT_SYMBOL(acpi_pci_disabled);
> >  
> >  static unsigned int intc_count;
> >  static struct acpi_madt_rintc cpu_madt_rintc[NR_CPUS];
> > +static bool param_acpi_off __initdata;
> > +static bool param_acpi_on __initdata;
> > +static bool param_acpi_force __initdata;
> > +
> > +static int __init parse_acpi(char *arg)
> > +{
> > +	if (!arg)
> > +		return -EINVAL;
> > +
> > +	/* "acpi=off" disables both ACPI table parsing and interpreter */
> > +	if (strcmp(arg, "off") == 0)
> > +		param_acpi_off = true;
> > +	else if (strcmp(arg, "on") == 0) /* prefer ACPI over DT */
> > +		param_acpi_on = true;
> > +	else if (strcmp(arg, "force") == 0) /* force ACPI to be enabled */
> > +		param_acpi_force = true;
> > +	else
> > +		return -EINVAL;	/* Core will print when we return error */
> > +
> > +	return 0;
> > +}
> > +early_param("acpi", parse_acpi);
> > +
> > +/*
> > + * acpi_fadt_sanity_check() - Check FADT presence and carry out sanity
> > + *			      checks on it
> > + *
> > + * Return 0 on success,  <0 on failure
> > + */
> > +static int __init acpi_fadt_sanity_check(void)
> > +{
> > +	struct acpi_table_header *table;
> > +	struct acpi_table_fadt *fadt;
> > +	acpi_status status;
> > +	int ret = 0;
> > +
> > +	/*
> > +	 * FADT is required on riscv; retrieve it to check its presence
> > +	 * and carry out revision and ACPI HW reduced compliancy tests
> > +	 */
> > +	status = acpi_get_table(ACPI_SIG_FADT, 0, &table);
> > +	if (ACPI_FAILURE(status)) {
> > +		const char *msg = acpi_format_exception(status);
> > +
> > +		pr_err("Failed to get FADT table, %s\n", msg);
> > +		return -ENODEV;
> > +	}
> > +
> > +	fadt = (struct acpi_table_fadt *)table;
> > +
> > +	if (!(fadt->flags & ACPI_FADT_HW_REDUCED)) {
> 
> Do we also need to check for ACPI version 5.0+ when checking for HW
> reduced?
> 
We need to add version check of FADT once spec is released. Will
update it at that time.

> > +		pr_err("FADT not ACPI hardware reduced compliant\n");
> > +		ret = -EINVAL;
> > +	}
> > +
> > +	/*
> > +	 * acpi_get_table() creates FADT table mapping that
> > +	 * should be released after parsing and before resuming boot
> > +	 */
> > +	acpi_put_table(table);
> > +	return ret;
> > +}
> > +
> > +/*
> > + * acpi_boot_table_init() called from setup_arch(), always.
> > + *	1. find RSDP and get its address, and then find XSDT
> > + *	2. extract all tables and checksums them all
> > + *	3. check ACPI FADT HW reduced flag
> > + *
> > + * We can parse ACPI boot-time tables such as MADT after
> > + * this function is called.
> > + *
> > + * On return ACPI is enabled if either:
> > + *
> > + * - ACPI tables are initialized and sanity checks passed
> > + * - acpi=force was passed in the command line and ACPI was not disabled
> > + *   explicitly through acpi=off command line parameter
> > + *
> > + * ACPI is disabled on function return otherwise
> > + */
> > +void __init acpi_boot_table_init(void)
> > +{
> > +	/*
> > +	 * Enable ACPI instead of device tree unless
> > +	 * - ACPI has been disabled explicitly (acpi=off), or
> > +	 * - firmware has not populated ACPI ptr in EFI system table
> > +	 *   and ACPI has not been [force] enabled (acpi=on|force)
> > +	 */
> > +	if (param_acpi_off ||
> > +	    (!param_acpi_on && !param_acpi_force &&
> > +	     efi.acpi20 == EFI_INVALID_TABLE_ADDR))
> > +		return;
> > +
> > +	/*
> > +	 * ACPI is disabled at this point. Enable it in order to parse
> > +	 * the ACPI tables and carry out sanity checks
> > +	 */
> > +	enable_acpi();
> > +
> > +	/*
> > +	 * If ACPI tables are initialized and FADT sanity checks passed,
> > +	 * leave ACPI enabled and carry on booting; otherwise disable ACPI
> > +	 * on initialization error.
> > +	 * If acpi=force was passed on the command line it forces ACPI
> > +	 * to be enabled even if its initialization failed.
> > +	 */
> > +	if (acpi_table_init() || acpi_fadt_sanity_check()) {
> > +		pr_err("Failed to init ACPI tables\n");
> > +		if (!param_acpi_force)
> > +			disable_acpi();
> > +	}
> > +}
> 
> A lot of the above code is common with arm64. It'd be nice to share that,
> but maybe refactoring can be done on top of this.
>
Okay.
 
> >  
> >  static int acpi_parse_madt_rintc(union acpi_subtable_headers *header, const unsigned long end)
> >  {
> > diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> > index 4335f08ffaf2..c2ee7f4427a1 100644
> > --- a/arch/riscv/kernel/setup.c
> > +++ b/arch/riscv/kernel/setup.c
> > @@ -8,6 +8,7 @@
> >   *  Nick Kossifidis <mick@ics.forth.gr>
> >   */
> >  
> > +#include <linux/acpi.h>
> >  #include <linux/init.h>
> >  #include <linux/mm.h>
> >  #include <linux/memblock.h>
> > @@ -276,14 +277,22 @@ void __init setup_arch(char **cmdline_p)
> >  
> >  	efi_init();
> >  	paging_init();
> > -#if IS_ENABLED(CONFIG_BUILTIN_DTB)
> > -	unflatten_and_copy_device_tree();
> > -#else
> > -	if (early_init_dt_verify(__va(XIP_FIXUP(dtb_early_pa))))
> > -		unflatten_device_tree();
> > -	else
> > -		pr_err("No DTB found in kernel mappings\n");
> > -#endif
> > +
> > +	/* Parse the ACPI tables for possible boot-time configuration */
> > +	acpi_boot_table_init();
> > +	if (acpi_disabled) {
> > +		if (IS_ENABLED(CONFIG_BUILTIN_DTB)) {
> > +			unflatten_and_copy_device_tree();
> > +		} else {
> > +			if (early_init_dt_verify(__va(XIP_FIXUP(dtb_early_pa))))
> > +				unflatten_device_tree();
> > +			else
> > +				pr_err("No DTB found in kernel mappings\n");
> > +		}
> > +	} else {
> > +		early_init_dt_verify(__va(XIP_FIXUP(dtb_early_pa)));
> > +	}
> > +
> >  	early_init_fdt_scan_reserved_mem();
> >  	misc_mem_init();
> >  
> > -- 
> > 2.34.1
> >
> 
> Otherwise,
> 
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Thanks,
Sunil
