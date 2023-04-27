Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0B56F0350
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 11:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243317AbjD0JXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 05:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243295AbjD0JXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 05:23:11 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A772D76
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 02:23:03 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-63b7b54642cso5870533b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 02:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1682587382; x=1685179382;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b4tmAtbJaHWfTAbFkdGyP1UUwCahMULqyPQK3zTjGzc=;
        b=YRR8+nwiwBRWdu+ISCLSUieKCxjJzKGl6+oqhEO/3BRqOIOSZ8Qko6ouC9u7p2HpTX
         gdnzmSG1RwEXmBdnDiO0OZMpDHopOb7UfbKa85eHey0TP0gQd3q1yv1tTPeaxeWx2qIu
         kY2Mj84whu79JeOW5KjI+dW1EjDkrG8S/u0DbgVxwLqXWdjQfebgAN//TuFJsvpHCzMe
         WdXHvCJQVo9P4UaFl9zY0C7wB0iXNSnzvnt4mHaUmyeayfGP7okRyh6CZxuwWIpMngbd
         bYPmen8R4y4/TyTosIADLMAPn3mwYVLIBKA0NA7bBzvfqscFUwnmsFtr4siJ+1x47S6b
         7PJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682587383; x=1685179383;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b4tmAtbJaHWfTAbFkdGyP1UUwCahMULqyPQK3zTjGzc=;
        b=XemcgRRscD1lh4TSxLYTZAm2/pkCDhHCq9xM768YOdCbQNiJt5KJ65Aolcr9H+Y5JQ
         tW0kS2U5o1FRnZGe5GZc70rQZkFUhyl+PUMBwKyEgfeu789rohht/3jeylOShSSb6Pqq
         5O3n2OausM7lWXGFeCBFxebTB9re9RPEa1iiN6HakncQ1PcdheXuP7xDtsDUZgFEft29
         AJ81sZAbPemrBdfh3v8OSlzmkU3Opkp+YF9zPiWoDGu2gcbfof8uUtffSGLJFQ4JdnyO
         nJajzHrC+reXNqevZQ9Zg/0KbTiiEVq9I8NOz9HWV9P2plKv9USeuQO2mG2XzEHfrjh9
         U9CQ==
X-Gm-Message-State: AC+VfDyaoT4nEcztFohk+O9pRVAJQ0/OGDW5zbaSEI6MSvzspEf8D9sP
        3jcyXq7Ye1MWS/GlqIHSDg1qsA==
X-Google-Smtp-Source: ACHHUZ7RWci9fHcfj1Kz5md3jazQZh7oA/8a9iSA8EEYdE24w8faCyvnC3O4ecPFfRxC69G0cl789g==
X-Received: by 2002:a05:6a00:22ca:b0:63b:5c82:e21a with SMTP id f10-20020a056a0022ca00b0063b5c82e21amr1814185pfj.1.1682587382560;
        Thu, 27 Apr 2023 02:23:02 -0700 (PDT)
Received: from sunil-laptop ([2409:4071:6e90:4e5:b276:2557:8da6:6c7e])
        by smtp.gmail.com with ESMTPSA id i66-20020a62c145000000b0063d318699f9sm12712205pfg.48.2023.04.27.02.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 02:23:02 -0700 (PDT)
Date:   Thu, 27 Apr 2023 14:52:50 +0530
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-crypto@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        llvm@lists.linux.dev, corbet@lwn.net,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, lenb@kernel.org, daniel.lezcano@linaro.org,
        tglx@linutronix.de, qianweili@huawei.com, wangzhou1@hisilicon.com,
        herbert@gondor.apana.org.au, Marc Zyngier <maz@kernel.org>,
        luzmaximilian@gmail.com, hdegoede@redhat.com, markgross@kernel.org,
        nathan@kernel.org, ndesaulniers@google.com, trix@redhat.com,
        rafael@kernel.org, davem@davemloft.net, rafael.j.wysocki@intel.com
Subject: Re: [PATCH V4 08/23] RISC-V: ACPI: Cache and retrieve the RINTC
 structure
Message-ID: <ZEo+6rwM+c6DvlMM@sunil-laptop>
References: <20230404182037.863533-9-sunilvl@ventanamicro.com>
 <mhng-fd6c3622-ce6c-4895-8dc9-7dbaa2ab14f4@palmer-ri-x1c9a>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-fd6c3622-ce6c-4895-8dc9-7dbaa2ab14f4@palmer-ri-x1c9a>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Palmer,

On Wed, Apr 26, 2023 at 11:45:00AM -0700, Palmer Dabbelt wrote:
> On Tue, 04 Apr 2023 11:20:22 PDT (-0700), sunilvl@ventanamicro.com wrote:
> > RINTC structures in the MADT provide mapping between the hartid
> > and the CPU. This is required many times even at run time like
> > cpuinfo. So, instead of parsing the ACPI table every time, cache
> > the RINTC structures and provide a function to get the correct
> > RINTC structure for a given cpu.
> > 
> > Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> > Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  arch/riscv/include/asm/acpi.h |  2 ++
> >  arch/riscv/kernel/acpi.c      | 60 +++++++++++++++++++++++++++++++++++
> >  2 files changed, 62 insertions(+)
> > 
> > diff --git a/arch/riscv/include/asm/acpi.h b/arch/riscv/include/asm/acpi.h
> > index 9be52b6ffae1..1606dce8992e 100644
> > --- a/arch/riscv/include/asm/acpi.h
> > +++ b/arch/riscv/include/asm/acpi.h
> > @@ -59,6 +59,8 @@ static inline bool acpi_has_cpu_in_madt(void)
> > 
> >  static inline void arch_fix_phys_package_id(int num, u32 slot) { }
> > 
> > +struct acpi_madt_rintc *acpi_cpu_get_madt_rintc(int cpu);
> > +u32 get_acpi_id_for_cpu(int cpu);
> >  #endif /* CONFIG_ACPI */
> > 
> >  #endif /*_ASM_ACPI_H*/
> > diff --git a/arch/riscv/kernel/acpi.c b/arch/riscv/kernel/acpi.c
> > index 81d448c41714..40ab55309c70 100644
> > --- a/arch/riscv/kernel/acpi.c
> > +++ b/arch/riscv/kernel/acpi.c
> > @@ -24,6 +24,66 @@ EXPORT_SYMBOL(acpi_disabled);
> >  int acpi_pci_disabled = 1;	/* skip ACPI PCI scan and IRQ initialization */
> >  EXPORT_SYMBOL(acpi_pci_disabled);
> > 
> > +static struct acpi_madt_rintc cpu_madt_rintc[NR_CPUS];
> > +
> > +static int acpi_parse_madt_rintc(union acpi_subtable_headers *header, const unsigned long end)
> > +{
> > +	struct acpi_madt_rintc *rintc = (struct acpi_madt_rintc *)header;
> > +	int cpuid;
> > +
> > +	if (!(rintc->flags & ACPI_MADT_ENABLED))
> > +		return 0;
> > +
> > +	cpuid = riscv_hartid_to_cpuid(rintc->hart_id);
> 
> Unless I'm missing something, this races with CPUs coming online.  Maybe
> that's a rare enough case we don't care, but I think we'd also just have
> simpler logic if we fixed it...
> 
This depend only on cpuid_to_hartid_map filled up. I wish I could
initialize this RINTC mapping in setup_smp() itself like ARM64. But in
RISC-V, this file smpboot.c gets built only when CONFIG_SMP is enabled.
Hence, we need to initialize this array outside of setup_smp().

I can update the code to initialize this from setup_arch() immediately
after setup_smp() if ACPI is enabled. That should avoid the global
variable check also. Let me know if you prefer this.

> > +	/*
> > +	 * When CONFIG_SMP is disabled, mapping won't be created for
> > +	 * all cpus.
> > +	 * CPUs more than NR_CPUS, will be ignored.
> > +	 */
> > +	if (cpuid >= 0 && cpuid < NR_CPUS)
> > +		cpu_madt_rintc[cpuid] = *rintc;
> > +
> > +	return 0;
> > +}
> > +
> > +static int acpi_init_rintc_array(void)
> > +{
> > +	if (acpi_table_parse_madt(ACPI_MADT_TYPE_RINTC, acpi_parse_madt_rintc, 0) > 0)
> > +		return 0;
> > +
> > +	return -ENODEV;
> > +}
> > +
> > +/*
> > + * Instead of parsing (and freeing) the ACPI table, cache
> > + * the RINTC structures since they are frequently used
> > + * like in  cpuinfo.
> > + */
> > +struct acpi_madt_rintc *acpi_cpu_get_madt_rintc(int cpu)
> > +{
> > +	static bool rintc_init_done;
> 
> ... basically just get rid of this global variable, and instead have a
> 
>    if (!&cpu_madt_rintc[cpu])
>        ... parse ...
>    return &cpu_madt_rintc[cpu];
> 
> that'd probably let us get rid of a handful of these helpers too, as now
> it's just a call to the parsing bits.
> 
I am afraid this (!&cpu_madt_rintc[cpu]) check won't work since we are
not caching the RINTC pointers but actual contents itself. So, the
address is always valid. However, as per Drew's earlier feedback I am
going to reduce one helper. I am planning to send the next version of
this patch once 6.4 rc1 is available since the ACPICA patches are merged
now.

> > +
> > +	if (!rintc_init_done) {
> > +		if (acpi_init_rintc_array()) {
> > +			pr_err("No valid RINTC entries exist\n");
> > +			return NULL;
> > +		}
> > +
> > +		rintc_init_done = true;
> > +	}
> > +
> > +	return &cpu_madt_rintc[cpu];
> > +}
> > +
> > +u32 get_acpi_id_for_cpu(int cpu)
> > +{
> > +	struct acpi_madt_rintc *rintc = acpi_cpu_get_madt_rintc(cpu);
> > +
> > +	BUG_ON(!rintc);
> 
> We should have some better error reporting here.  It looks like all the
> callerss of get_acpi_id_for_cpu() are tolerant of a nonsense ID being
> returned, so maybe we just pr_warn() something users can understand and then
> return -1 or something?
> 

RINTC is mandatory for ACPI systems. Also, all 32bit values are valid
for UID. So, there is no bogus value we can return. 

Actually, I just realized this check is redundant. It will never be NULL
since it is a static array. So, we can just get rid of the BUG.

Thanks!
Sunil
