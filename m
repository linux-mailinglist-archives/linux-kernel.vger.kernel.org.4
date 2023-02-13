Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8238E694D8E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 18:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjBMRAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 12:00:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjBMRAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 12:00:44 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718BC193ED
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 09:00:42 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id mg23so5970920pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 09:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AOr10dVQbwIfzRH4wxSUN+tKAOUvGyW77RFxYDyWSw4=;
        b=Xk36lugwkefIX90CnHzFXRA2f1HXASTndOD4qPGSoj03JXeST2jZYc/msSMfare3wt
         62MADYzitn+/RB0O0f/LMln+42KaNpohSTwnAZzxcZhLRAzeFNRRls4nsVvP04A4NvPJ
         ejJTS9PLdybPtkMBCJOQ4mYKUFcsKl7ie7DTzI+P0Osa1txj1TU51lEVUKc/SyFzzCB3
         YJDFzOlLotAFvXr+Y7Vf3EslcJ7ir+IrynEkttlIxOMEkYLAAVMrDkJogT289hMVXwYp
         9GaZKvWd/kSdG9pRkPq7hwHYAN6UcpBbCG1rMehOKUfH90hqcZ+ZbuxvxljTgT6ysRu1
         7B1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AOr10dVQbwIfzRH4wxSUN+tKAOUvGyW77RFxYDyWSw4=;
        b=6as4jwyhMBMO3MMnfAwi0HjLAU7uPvD9GxE9N5d3bpEgL5yWroCQcSrCV9Ld3bIga3
         Bs2+FcZN/F8OeG8F1aEH5cSr07rnqoZQ5BqGc68dZHY9mg7LMueK9wiIcfc51m7H4xvp
         vxbXcyoHu8smEzkIH/anVcgpC/75TV8NLfDAA86eqxTODlq2xJGjNo7NE0ybkprEcA1C
         kXKhIaTd2h0VTsKD+7AJh2+gPVB2PaYkIP4OSDb8EyUWXa2Be7+EI2VfQrvqZbay/wDe
         ME/gBHhMAnEunhcYJDFYsbkeOElj7C6KTppgB8BBYH+nonNm5GyOGTCJYdW8ZPrOE6fc
         U+wA==
X-Gm-Message-State: AO0yUKUBUqzCLe3MkFUfMaBeb4AaRS8f/1/N20BKQF+XVO40XlakVvVW
        SNgrUtVc0QlHHwO2IXraAK9BxA==
X-Google-Smtp-Source: AK7set+tXR5i3JgVKgzvBSZ6MCb2c+hLPyLbC7HBzkafBheEhsQIPS/rB1Goy5hWggPnOhYK1EIjuQ==
X-Received: by 2002:a17:902:e313:b0:19a:a39b:a88b with SMTP id q19-20020a170902e31300b0019aa39ba88bmr2587418plc.37.1676307641914;
        Mon, 13 Feb 2023 09:00:41 -0800 (PST)
Received: from sunil-laptop ([49.206.14.226])
        by smtp.gmail.com with ESMTPSA id y13-20020a170902ed4d00b00198fc0a191bsm646134plb.160.2023.02.13.09.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 09:00:41 -0800 (PST)
Date:   Mon, 13 Feb 2023 22:30:33 +0530
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>
Subject: Re: [PATCH 14/24] RISC-V: ACPI: smpboot: Add function to retrieve
 the hartid
Message-ID: <Y+pssW1GCMW3oZjL@sunil-laptop>
References: <20230130182225.2471414-1-sunilvl@ventanamicro.com>
 <20230130182225.2471414-15-sunilvl@ventanamicro.com>
 <Y+VX8EclC1cE2fdI@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+VX8EclC1cE2fdI@spud>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 09, 2023 at 08:30:40PM +0000, Conor Dooley wrote:
> Hey Sunil, Drew,
> 
> @drew, a question below that I'm sorta aiming at you...
> 
> On Mon, Jan 30, 2023 at 11:52:15PM +0530, Sunil V L wrote:
> > hartid is in RINTC structuire in MADT table. Instead of parsing
> 
> Nit: missing articles before RINTC and MADT. Also typo "structure".
> 
> Perhaps you'd benefit from a spell checker in your git editor.
> 
Okay.

> > the ACPI table every time we need for a cpu, cache it and provide
> > a function to read it.
> > 
> > This is similar to acpi_get_madt_gicc() in arm64.
> 
> -ENOTFOUND, do you mean acpi_cpu_get_madt_gicc()?
>
Yes. Will update.

> > 
> > Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> > ---
> >  arch/riscv/include/asm/acpi.h | 14 +++++++++++++-
> >  arch/riscv/kernel/smpboot.c   | 21 +++++++++++++++++++++
> >  2 files changed, 34 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/riscv/include/asm/acpi.h b/arch/riscv/include/asm/acpi.h
> > index d1f1e53ec657..69a880b7257a 100644
> > --- a/arch/riscv/include/asm/acpi.h
> > +++ b/arch/riscv/include/asm/acpi.h
> > @@ -65,6 +65,18 @@ int acpi_numa_get_nid(unsigned int cpu);
> >  static inline int acpi_numa_get_nid(unsigned int cpu) { return NUMA_NO_NODE; }
> >  #endif /* CONFIG_ACPI_NUMA */
> >  
> > -#endif
> > +struct acpi_madt_rintc *acpi_get_madt_rintc(int cpu);
> > +struct acpi_madt_rintc *acpi_cpu_get_madt_rintc(int cpu);
> > +static inline u32 get_acpi_id_for_cpu(int cpu)
> > +{
> > +	return	acpi_cpu_get_madt_rintc(cpu)->uid;
> > +}
> > +#else
> > +static inline u32 get_acpi_id_for_cpu(int cpu)
> > +{
> > +	return -1;
> > +}
> > +
> > +#endif /* CONFIG_ACPI */
> >  
> >  #endif /*_ASM_ACPI_H*/
> > diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
> > index e48cf88d0bc1..3a8b7a9eb5ac 100644
> > --- a/arch/riscv/kernel/smpboot.c
> > +++ b/arch/riscv/kernel/smpboot.c
> > @@ -73,6 +73,25 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
> >  
> >  #ifdef CONFIG_ACPI
> >  static unsigned int cpu_count = 1;
> > +static unsigned int intc_count;
> > +static struct acpi_madt_rintc cpu_madt_rintc[NR_CPUS];
> > +
> > +struct acpi_madt_rintc *acpi_get_madt_rintc(int cpu)
> > +{
> > +	return &cpu_madt_rintc[cpu];
> > +}
> > +
> > +struct acpi_madt_rintc *acpi_cpu_get_madt_rintc(int cpu)
> > +{
> > +	int i;
> 
> Since we are C11 now, you don't even need to declare this outside of the
> loop, right?
>
Okay.
 
> > +
> > +	for (i = 0; i < NR_CPUS; i++) {
> 
> @drew, perhaps you know since you were fiddling not too long ago with
> cpumask stuff - at what point does for_each_possible_cpu() become
> usable?
> I had a bit of a poke & couldn't immediately tell if it'd be okay to use
> it here.
>
It should be possible. Thanks!
 
> > +		if (riscv_hartid_to_cpuid(cpu_madt_rintc[i].hart_id) == cpu)
> > +			return &cpu_madt_rintc[i];
> > +	}
> > +	return NULL;
> 
> Another nit: newline before return please :)
>
Sure.

Thanks,
Sunil 
