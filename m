Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 464B86A200A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 17:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbjBXQun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 11:50:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbjBXQuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 11:50:40 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79796C185
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 08:50:27 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id y19so7975639pgk.5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 08:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GlirhmbI5oiUJoslwLZo1tlht30rF9y3H4Y3f7asFP4=;
        b=asGuSq0OBibU7wZq6pODvvrZfVEWYrTa6oDgxwaK/I9gANNJ3qvU/Nhh9hFlH2a3no
         NPMM+j+Xku5gGOW8l9AV2kYpc0ctNZzaiy0DgtUQ6lCkTX6xULxKav0/VQLEAQskfNe0
         4uB5fh7mjEbjNh4qNuV3KMBltsilkPf9zAaF8VjhLSe/pcYm1If+hHT75XLzQ8z907Hn
         q+Zh1qA/lLqZCXVBnkmu+15B9bQ66L/BuO2iQ6gDsJ+RQlcZiEfmjRY/ZjpqvzIU+J0R
         tt0v6D/NOZgq+3lPLGOWv8U/eDmKcA4c421nPV1dY3rlLdBV4Wsz47wgxZOYXOjNcfl/
         Ozpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GlirhmbI5oiUJoslwLZo1tlht30rF9y3H4Y3f7asFP4=;
        b=De11LHm5OOotzlYaMwU3upMMV1YxOZUQqG/UBC8tu/T0AGggVUzythgAg99Wh1OI7w
         bAvwVVHYWMcgczp7ultCgY1VrMd0xwog0w/Rmv3aLXNP8bVFgPCSWCHMplNciVtjwcaK
         zgMRS96kUiTG2BVKvL3UTfnfX9T+6J/R1O5kAvMSHQrGcfk5v179POzroPn+Mur5+gD5
         eckcf5rFKZQzth1eNmuAP3kZJSNKxSYy3MvkuhmDfGDXOXyOf4D/cuIaGK8cDofZf3ra
         wbAYCYXng8YRKTBhcQ0DKabY2vE1w8GLLRi3NAhX9QQTn3ogPo8QQxqIZEa1MKr633nG
         p5LQ==
X-Gm-Message-State: AO0yUKUGQkwRvE9zG2gZ2sZbZFuZ3xXTHgpmuU5EeVQTIdbYS5KGYAi3
        UF/iVYHe6VniHa1MsrE5dnn0AA==
X-Google-Smtp-Source: AK7set/2gvzAB/DiniWjw9Fyo5qXHnaKG7eu5pHf43D4jVCbfCH6f8c9fOkyPCPiySwoGdTRLtKDaw==
X-Received: by 2002:aa7:96ee:0:b0:5dc:6ddd:878f with SMTP id i14-20020aa796ee000000b005dc6ddd878fmr5376351pfq.2.1677257427001;
        Fri, 24 Feb 2023 08:50:27 -0800 (PST)
Received: from sunil-laptop ([49.206.14.226])
        by smtp.gmail.com with ESMTPSA id h3-20020aa786c3000000b005a84de344a6sm6456521pfo.14.2023.02.24.08.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 08:50:26 -0800 (PST)
Date:   Fri, 24 Feb 2023 22:20:17 +0530
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
Subject: Re: [PATCH V2 10/21] RISC-V: smpboot: Add ACPI support in smp_setup()
Message-ID: <Y/jqye85kKU8KfDU@sunil-laptop>
References: <20230216182043.1946553-1-sunilvl@ventanamicro.com>
 <20230216182043.1946553-11-sunilvl@ventanamicro.com>
 <20230220170843.2zkrqcnqcwbruea6@orel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230220170843.2zkrqcnqcwbruea6@orel>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2023 at 06:08:43PM +0100, Andrew Jones wrote:
> On Thu, Feb 16, 2023 at 11:50:32PM +0530, Sunil V L wrote:
> > Enable SMP boot on ACPI based platforms by using the RINTC
> > structures in the MADT table.
> > 
> > Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> > Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > ---
> >  arch/riscv/include/asm/acpi.h |  7 ++++
> >  arch/riscv/kernel/smpboot.c   | 70 ++++++++++++++++++++++++++++++++++-
> >  2 files changed, 76 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/riscv/include/asm/acpi.h b/arch/riscv/include/asm/acpi.h
> > index 7bc49f65c86b..3c3a8ac3b37a 100644
> > --- a/arch/riscv/include/asm/acpi.h
> > +++ b/arch/riscv/include/asm/acpi.h
> > @@ -60,6 +60,13 @@ static inline void arch_fix_phys_package_id(int num, u32 slot) { }
> >  
> >  int acpi_get_riscv_isa(struct acpi_table_header *table,
> >  		       unsigned int cpu, const char **isa);
> > +
> > +#ifdef CONFIG_ACPI_NUMA
> > +int acpi_numa_get_nid(unsigned int cpu);
> > +#else
> > +static inline int acpi_numa_get_nid(unsigned int cpu) { return NUMA_NO_NODE; }
> > +#endif /* CONFIG_ACPI_NUMA */
> 
> The #ifdef stuff seems premature since we're not providing an
> implementation for acpi_numa_get_nid() or selecting ACPI_NUMA, but OK.
> 
Yes, will remove it. We can add as part NUMA enablement.

> > +
> >  #else
> >  static inline int acpi_get_riscv_isa(struct acpi_table_header *table,
> >  				     unsigned int cpu, const char **isa)
> > diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
> > index 26214ddefaa4..77630f8ed12b 100644
> > --- a/arch/riscv/kernel/smpboot.c
> > +++ b/arch/riscv/kernel/smpboot.c
> > @@ -8,6 +8,7 @@
> >   * Copyright (C) 2017 SiFive
> >   */
> >  
> > +#include <linux/acpi.h>
> >  #include <linux/arch_topology.h>
> >  #include <linux/module.h>
> >  #include <linux/init.h>
> > @@ -70,6 +71,70 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
> >  	}
> >  }
> >  
> > +#ifdef CONFIG_ACPI
> > +static unsigned int cpu_count = 1;
> > +
> > +static int __init acpi_parse_rintc(union acpi_subtable_headers *header, const unsigned long end)
> > +{
> > +	unsigned long hart;
> > +	bool found_boot_cpu = false;
> 
> I guess found_boot_cpu should be static?
> 
Good catch!. Thanks!

> > +	struct acpi_madt_rintc *processor = (struct acpi_madt_rintc *)header;
> > +
> > +	/*
> > +	 * Each RINTC structure in MADT will have a flag. If ACPI_MADT_ENABLED
> > +	 * bit in the flag is not enabled, it means OS should not try to enable
> > +	 * the cpu to which RINTC belongs.
> > +	 */
> > +	if (!(processor->flags & ACPI_MADT_ENABLED))
> > +		return 0;
> > +
> > +	hart = processor->hart_id;
> > +	if (hart < 0)
> > +		return 0;
> 
> A valid hart ID is anything up to INVALID_HARTID, right? Shouldn't we only
> be checking for INVALID_HARTID here? And what does it mean to have an
> invalid hart ID here? It's not an issue to error/warn about?
> 
Yes, will check for INVALID_HARTID (though I am not really sure how it
can be invalid). Will add a warning.

> > +	if (hart == cpuid_to_hartid_map(0)) {
> > +		BUG_ON(found_boot_cpu);
> 
> Do we really want to BUG due to bad, but potentially bootable ACPI tables?
> I'd BUG for things that can only happen when we break the code, but broken
> ACPI tables might be something we want to complain loudly about and then
> attempt to limp along.
> 
Okay. I used same logic as in DT. It may be better to use BUG instead of
debugging weird symptoms later, right?

> > +		found_boot_cpu = true;
> > +		early_map_cpu_to_node(0, acpi_numa_get_nid(cpu_count));
> > +		return 0;
> > +	}
> > +
> > +	if (cpu_count >= NR_CPUS) {
> > +		pr_warn("Invalid cpuid [%d] for hartid [%lu]\n",
> > +			cpu_count, hart);
> 
> cpuid isn't invalid, NR_CPUS is too small for the number of ACPI tables.
> 
Okay.

> > +		return 0;
> > +	}
> > +
> > +	cpuid_to_hartid_map(cpu_count) = hart;
> > +	early_map_cpu_to_node(cpu_count, acpi_numa_get_nid(cpu_count));
> > +	cpu_count++;
> > +
> > +	return 0;
> > +}
> > +
> > +static void __init acpi_parse_and_init_cpus(void)
> > +{
> > +	int cpuid;
> > +
> > +	cpu_set_ops(0);
> > +
> > +	/*
> > +	 * do a walk of MADT to determine how many CPUs
> > +	 * we have including disabled CPUs, and get information
> > +	 * we need for SMP init.
> > +	 */
> 
> I know this comment comes verbatim from arm64, but not only does it
> have grammar issues, I'm not sure it's accurate. Where is the count
> of disabled CPUs for arm64 or riscv?
>
MADT will have multiple RINTC structures. Each RINTC structure will have
a flag to indicate whether enabled or disabled. So, we need to walk the
MADT to get all CPUs present. But I think this comment is not required
since comments are added in the parser function.
 
> > +	acpi_table_parse_madt(ACPI_MADT_TYPE_RINTC, acpi_parse_rintc, 0);
> > +
> > +	for (cpuid = 1; cpuid < nr_cpu_ids; cpuid++) {
> > +		if (cpuid_to_hartid_map(cpuid) != INVALID_HARTID) {
> > +			cpu_set_ops(cpuid);
> > +			set_cpu_possible(cpuid, true);
> > +		}
> > +	}
> > +}
> > +#else
> > +#define acpi_parse_and_init_cpus(...)	do { } while (0)
> > +#endif
> > +
> >  static void __init of_parse_and_init_cpus(void)
> >  {
> >  	struct device_node *dn;
> > @@ -118,7 +183,10 @@ static void __init of_parse_and_init_cpus(void)
> >  
> >  void __init setup_smp(void)
> >  {
> > -	of_parse_and_init_cpus();
> > +	if (acpi_disabled)
> > +		of_parse_and_init_cpus();
> > +	else
> > +		acpi_parse_and_init_cpus();
> >  }
> >  
> >  static int start_secondary_cpu(int cpu, struct task_struct *tidle)
> > -- 
> > 2.34.1
> >
> 
> Do we not want to add an entry to acpi_table_print_madt_entry() for RINTC?
> 
Yes. Will add a patch for this to help debugging.

Thanks,
Sunil
