Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1E66F0430
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 12:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243522AbjD0KZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 06:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243512AbjD0KZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 06:25:52 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2808A4EC9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 03:25:51 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-2f833bda191so5080076f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 03:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1682591149; x=1685183149;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q9YirskzzfAT9ZG78j4XI4f+XaKvOs4fPB8pgDEIFrg=;
        b=dH+YgQI6dQjl1A5Sw11f3xx1ffIcrI4l/QBtnOO+H7Sqe5wuP+Es2b93LL4lwlO6IJ
         S9U//eRjfTQ5JhXMNJ9VFTRn4S6ziXjfRlALf3KG9SiWq33hh5pjwTda2tGZ5VjEVKuS
         /RRo8QBGK5SAxVNgR4pWs3MMek91fhyMNEXRq/MI1/EBrCbfzP/n/n13/VRQnRE/kvcR
         66tMMLGpNxK6QtSqZ/lJNKKtdDvJXVcBK6OspBszFNKXW5pkF+BJcMFd4odAfwzLu26M
         1PBxkeNIQzUnxSPkxWz1kR6xZxFbt9P6sZAq9fH5yN64HMIL+Lt/SsiFZud6kTiMI1Ls
         yvZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682591149; x=1685183149;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q9YirskzzfAT9ZG78j4XI4f+XaKvOs4fPB8pgDEIFrg=;
        b=ZDTVlnWeLbJT3HZGYao5exXOhsWFKZr32rGpXmr9pGVk1P+u+Es98nGaRF6jWcB6dq
         y4/oNt5/lgkIm8997KuW+MCi6v45imE5ut0OkVcte+d+idSjMARzh0CzWbtmWJspIuLe
         Cyb1f1qLjx1ASEcoNGGxZppyRkXI6pIPPllUaxTm4V/rz8ObUMgAietgahmijQikkqXt
         dSqKbUGuOKFKnc6wAohi5fdj9Tjqo9EWCD55fnIzcWW9jgHQJ5TsZu00cG5EnIvLojDK
         U/oOThjp8T8IzgNnlJR834TF6eZOHDdjulNXivjKFGQS1AOVAs2gLiQSZfjnxH2HbMfC
         CZFQ==
X-Gm-Message-State: AC+VfDyNZk4Qf/0h45HZPqdRTaDKc2j+91KIkMKBgBpYTng5MPniSPgU
        Q3rScrQy2NIt1Fhr4tXqpXHHAg==
X-Google-Smtp-Source: ACHHUZ6x1wuM4Jn0UPIukgsBYJpg+fMhoKy3/rvqcQ+kvfhVsS//cfS47JS5pbSjqqs83b2EuvSkvQ==
X-Received: by 2002:adf:f0ce:0:b0:2f0:69c4:3900 with SMTP id x14-20020adff0ce000000b002f069c43900mr927802wro.54.1682591149513;
        Thu, 27 Apr 2023 03:25:49 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id h3-20020a5d5043000000b002c70ce264bfsm18081249wrt.76.2023.04.27.03.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 03:25:48 -0700 (PDT)
Date:   Thu, 27 Apr 2023 12:25:42 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Sunil V L <sunilvl@ventanamicro.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-acpi@vger.kernel.org, linux-crypto@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, llvm@lists.linux.dev,
        corbet@lwn.net, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, lenb@kernel.org, daniel.lezcano@linaro.org,
        tglx@linutronix.de, qianweili@huawei.com, wangzhou1@hisilicon.com,
        herbert@gondor.apana.org.au, Marc Zyngier <maz@kernel.org>,
        luzmaximilian@gmail.com, hdegoede@redhat.com, markgross@kernel.org,
        nathan@kernel.org, ndesaulniers@google.com, trix@redhat.com,
        rafael@kernel.org, davem@davemloft.net, rafael.j.wysocki@intel.com
Subject: Re: [PATCH V4 08/23] RISC-V: ACPI: Cache and retrieve the RINTC
 structure
Message-ID: <qqukqrc45zqyjh5bwpjpuiweogwtapuw7qqjjpubjwvteum6ig@esjfwqdivhpa>
References: <20230404182037.863533-9-sunilvl@ventanamicro.com>
 <mhng-fd6c3622-ce6c-4895-8dc9-7dbaa2ab14f4@palmer-ri-x1c9a>
 <ZEo+6rwM+c6DvlMM@sunil-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZEo+6rwM+c6DvlMM@sunil-laptop>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 27, 2023 at 02:52:50PM +0530, Sunil V L wrote:
> Hi Palmer,
> 
> On Wed, Apr 26, 2023 at 11:45:00AM -0700, Palmer Dabbelt wrote:
> > On Tue, 04 Apr 2023 11:20:22 PDT (-0700), sunilvl@ventanamicro.com wrote:
> > > RINTC structures in the MADT provide mapping between the hartid
> > > and the CPU. This is required many times even at run time like
> > > cpuinfo. So, instead of parsing the ACPI table every time, cache
> > > the RINTC structures and provide a function to get the correct
> > > RINTC structure for a given cpu.
> > > 
> > > Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> > > Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > ---
> > >  arch/riscv/include/asm/acpi.h |  2 ++
> > >  arch/riscv/kernel/acpi.c      | 60 +++++++++++++++++++++++++++++++++++
> > >  2 files changed, 62 insertions(+)
> > > 
> > > diff --git a/arch/riscv/include/asm/acpi.h b/arch/riscv/include/asm/acpi.h
> > > index 9be52b6ffae1..1606dce8992e 100644
> > > --- a/arch/riscv/include/asm/acpi.h
> > > +++ b/arch/riscv/include/asm/acpi.h
> > > @@ -59,6 +59,8 @@ static inline bool acpi_has_cpu_in_madt(void)
> > > 
> > >  static inline void arch_fix_phys_package_id(int num, u32 slot) { }
> > > 
> > > +struct acpi_madt_rintc *acpi_cpu_get_madt_rintc(int cpu);
> > > +u32 get_acpi_id_for_cpu(int cpu);
> > >  #endif /* CONFIG_ACPI */
> > > 
> > >  #endif /*_ASM_ACPI_H*/
> > > diff --git a/arch/riscv/kernel/acpi.c b/arch/riscv/kernel/acpi.c
> > > index 81d448c41714..40ab55309c70 100644
> > > --- a/arch/riscv/kernel/acpi.c
> > > +++ b/arch/riscv/kernel/acpi.c
> > > @@ -24,6 +24,66 @@ EXPORT_SYMBOL(acpi_disabled);
> > >  int acpi_pci_disabled = 1;	/* skip ACPI PCI scan and IRQ initialization */
> > >  EXPORT_SYMBOL(acpi_pci_disabled);
> > > 
> > > +static struct acpi_madt_rintc cpu_madt_rintc[NR_CPUS];
> > > +
> > > +static int acpi_parse_madt_rintc(union acpi_subtable_headers *header, const unsigned long end)
> > > +{
> > > +	struct acpi_madt_rintc *rintc = (struct acpi_madt_rintc *)header;
> > > +	int cpuid;
> > > +
> > > +	if (!(rintc->flags & ACPI_MADT_ENABLED))
> > > +		return 0;
> > > +
> > > +	cpuid = riscv_hartid_to_cpuid(rintc->hart_id);
> > 
> > Unless I'm missing something, this races with CPUs coming online.  Maybe
> > that's a rare enough case we don't care, but I think we'd also just have
> > simpler logic if we fixed it...
> > 
> This depend only on cpuid_to_hartid_map filled up. I wish I could
> initialize this RINTC mapping in setup_smp() itself like ARM64. But in
> RISC-V, this file smpboot.c gets built only when CONFIG_SMP is enabled.
> Hence, we need to initialize this array outside of setup_smp().
> 
> I can update the code to initialize this from setup_arch() immediately
> after setup_smp() if ACPI is enabled. That should avoid the global
> variable check also. Let me know if you prefer this.
> 
> > > +	/*
> > > +	 * When CONFIG_SMP is disabled, mapping won't be created for
> > > +	 * all cpus.
> > > +	 * CPUs more than NR_CPUS, will be ignored.
> > > +	 */
> > > +	if (cpuid >= 0 && cpuid < NR_CPUS)
> > > +		cpu_madt_rintc[cpuid] = *rintc;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int acpi_init_rintc_array(void)
> > > +{
> > > +	if (acpi_table_parse_madt(ACPI_MADT_TYPE_RINTC, acpi_parse_madt_rintc, 0) > 0)
> > > +		return 0;
> > > +
> > > +	return -ENODEV;
> > > +}
> > > +
> > > +/*
> > > + * Instead of parsing (and freeing) the ACPI table, cache
> > > + * the RINTC structures since they are frequently used
> > > + * like in  cpuinfo.
> > > + */
> > > +struct acpi_madt_rintc *acpi_cpu_get_madt_rintc(int cpu)
> > > +{
> > > +	static bool rintc_init_done;
> > 
> > ... basically just get rid of this global variable, and instead have a
> > 
> >    if (!&cpu_madt_rintc[cpu])
> >        ... parse ...
> >    return &cpu_madt_rintc[cpu];
> > 
> > that'd probably let us get rid of a handful of these helpers too, as now
> > it's just a call to the parsing bits.
> > 
> I am afraid this (!&cpu_madt_rintc[cpu]) check won't work since we are
> not caching the RINTC pointers but actual contents itself. So, the
> address is always valid. However, as per Drew's earlier feedback I am
> going to reduce one helper. I am planning to send the next version of
> this patch once 6.4 rc1 is available since the ACPICA patches are merged
> now.
> 
> > > +
> > > +	if (!rintc_init_done) {
> > > +		if (acpi_init_rintc_array()) {
> > > +			pr_err("No valid RINTC entries exist\n");
> > > +			return NULL;
> > > +		}
> > > +
> > > +		rintc_init_done = true;
> > > +	}
> > > +
> > > +	return &cpu_madt_rintc[cpu];
> > > +}
> > > +
> > > +u32 get_acpi_id_for_cpu(int cpu)
> > > +{
> > > +	struct acpi_madt_rintc *rintc = acpi_cpu_get_madt_rintc(cpu);
> > > +
> > > +	BUG_ON(!rintc);
> > 
> > We should have some better error reporting here.  It looks like all the
> > callerss of get_acpi_id_for_cpu() are tolerant of a nonsense ID being
> > returned, so maybe we just pr_warn() something users can understand and then
> > return -1 or something?
> > 
> 
> RINTC is mandatory for ACPI systems. Also, all 32bit values are valid
> for UID. So, there is no bogus value we can return. 
> 
> Actually, I just realized this check is redundant. It will never be NULL
> since it is a static array. So, we can just get rid of the BUG.

It can be NULL on the first call of acpi_cpu_get_madt_rintc(), which is
a good time to BUG if there's isn't an RINTC.

Thanks,
drew
