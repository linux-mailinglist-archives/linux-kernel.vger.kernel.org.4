Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF816A9E53
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 19:18:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbjCCSSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 13:18:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231610AbjCCSSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 13:18:09 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D596E9D
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 10:18:07 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id y2so3443458pjg.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 10:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1677867486;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=668IMkJ9VCN0OF++MP5t7Oo0nXOWw+hWogxo8w+yeOg=;
        b=B+fQyvUELFfrROPXXypnqqlZ7q4HthF2DYdEUF8AJmC4q/lXWSA71vfbKbevTqz/Xg
         0pYJNzLo0KssTzVsdDWr+pXFVwghw/dIqLXto6MzGATWDFjs73CQIDkbnAiv9bEIndx0
         Fu2yhOEvzD80FFCllVb02RkSz0CUUbfF7YhPXie6dIgXEe9a6WXCZ+18pTwcIjRFqHNw
         nA4LNIejj5OECwV/Zk8nYpbQeqYRiiqWDuuXSTP3uWQIom5l1RfJlCV1Xg59xEjb+3ek
         ilCqivi1Uj3RcXgpPP2PD73O49jjRREZ+P1YJHDhx0Jfg/OtU6f4c5pAwixdfDSfVXlW
         x4Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677867486;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=668IMkJ9VCN0OF++MP5t7Oo0nXOWw+hWogxo8w+yeOg=;
        b=y6DPXMLUeHuoaOvEv6rk2mJutEC4VzGZn9r4Cwm96OCbK5YNOYh2byb3mjvJQnVL48
         GAqTu11vspVVdYdsbn1kRUb+oZQ+F0twhyeON09lxZh9RcDIdQx9hNT+YkXsUUEtSst0
         nLVEu/p4+Vvh0qE/jIXdL4HpFttANjm+lxYb0I2gGnzGUYea6ADrEVTysWnx7i2atSB9
         6yufsigUwYMrm1ldZ7fmF3hFBpBO4F7WFtx7D32TOCMG8uTy6OgY2fV1qvJ2k/mYgUUA
         WBEByj9wRDCO7v7kt4q9Lt7uFtMzH5mANqrP+B5N0c0v4FonTvjRtcucaIVxfl8eE0xz
         k2lQ==
X-Gm-Message-State: AO0yUKUeLg97WiqboTrwh0W9Ekz0J+Zkj9e5WMAOB6Cri1j9DTLb30Iu
        pIGRNmfE45dDj6FR4E5d4CyEx7I3GJvU7TrX
X-Google-Smtp-Source: AK7set8OIhn2IJsNuwMRF4I+CfpWQ8X8Z8hSi4/JoVY3kI6gbMnm5DimL4tTlump/mgU2EV0usM82A==
X-Received: by 2002:a17:902:c1cd:b0:19e:32da:e458 with SMTP id c13-20020a170902c1cd00b0019e32dae458mr2030337plc.63.1677867486583;
        Fri, 03 Mar 2023 10:18:06 -0800 (PST)
Received: from sunil-laptop ([49.206.8.117])
        by smtp.gmail.com with ESMTPSA id kl15-20020a170903074f00b0019945535973sm1820709plb.63.2023.03.03.10.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 10:18:06 -0800 (PST)
Date:   Fri, 3 Mar 2023 23:47:57 +0530
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     Andrew Jones <ajones@ventanamicro.com>
Cc:     linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        'Conor Dooley ' <conor.dooley@microchip.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH V3 11/20] RISC-V: ACPI: Cache and retrieve the RINTC
 structure
Message-ID: <ZAI51YC6N/p6hXkU@sunil-laptop>
References: <20230303133647.845095-1-sunilvl@ventanamicro.com>
 <20230303133647.845095-12-sunilvl@ventanamicro.com>
 <20230303160556.lezccmwa7ymymxws@orel>
 <ZAI1PbEfo1Gyco1n@sunil-laptop>
 <20230303180452.qzzjdwpgvqqxdqz5@orel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230303180452.qzzjdwpgvqqxdqz5@orel>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 03, 2023 at 07:04:52PM +0100, Andrew Jones wrote:
> On Fri, Mar 03, 2023 at 11:28:21PM +0530, Sunil V L wrote:
> > On Fri, Mar 03, 2023 at 05:05:56PM +0100, Andrew Jones wrote:
> > > On Fri, Mar 03, 2023 at 07:06:38PM +0530, Sunil V L wrote:
> > > > RINTC structures in the MADT provide mapping between the hartid
> > > > and the CPU. This is required many times even at run time like
> > > > cpuinfo. So, instead of parsing the ACPI table every time, cache
> > > > the RINTC structures and provide a function to get the correct
> > > > RINTC structure for a given cpu.
> > > > 
> > > > Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> > > > Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > ---
> > > >  arch/riscv/include/asm/acpi.h |  9 ++++++
> > > >  arch/riscv/kernel/acpi.c      | 56 +++++++++++++++++++++++++++++++++++
> > > >  2 files changed, 65 insertions(+)
> > > > 
> > > > diff --git a/arch/riscv/include/asm/acpi.h b/arch/riscv/include/asm/acpi.h
> > > > index 111a8ed10af1..8be16c1ef7da 100644
> > > > --- a/arch/riscv/include/asm/acpi.h
> > > > +++ b/arch/riscv/include/asm/acpi.h
> > > > @@ -61,6 +61,10 @@ static inline void arch_fix_phys_package_id(int num, u32 slot) { }
> > > >  
> > > >  int acpi_get_riscv_isa(struct acpi_table_header *table,
> > > >  		       unsigned int cpu, const char **isa);
> > > > +
> > > > +struct acpi_madt_rintc *acpi_cpu_get_madt_rintc(int cpu);
> > > > +
> > > > +u32 get_acpi_id_for_cpu(int cpu);
> > > >  #else
> > > >  static inline int acpi_get_riscv_isa(struct acpi_table_header *table,
> > > >  				     unsigned int cpu, const char **isa)
> > > > @@ -68,6 +72,11 @@ static inline int acpi_get_riscv_isa(struct acpi_table_header *table,
> > > >  	return -EINVAL;
> > > >  }
> > > >  
> > > > +static inline u32 get_acpi_id_for_cpu(int cpu)
> > > > +{
> > > > +	return -1;
> > > > +}
> > > 
> > > Why do we need this stub? I wouldn't expect non-ACPI code to need an ACPI
> > > ID.
> > > 
> > > > +
> > > >  #endif /* CONFIG_ACPI */
> > > >  
> > > >  #endif /*_ASM_ACPI_H*/
> > > > diff --git a/arch/riscv/kernel/acpi.c b/arch/riscv/kernel/acpi.c
> > > > index 81d448c41714..8b3d68d8225f 100644
> > > > --- a/arch/riscv/kernel/acpi.c
> > > > +++ b/arch/riscv/kernel/acpi.c
> > > > @@ -24,6 +24,62 @@ EXPORT_SYMBOL(acpi_disabled);
> > > >  int acpi_pci_disabled = 1;	/* skip ACPI PCI scan and IRQ initialization */
> > > >  EXPORT_SYMBOL(acpi_pci_disabled);
> > > >  
> > > > +static struct acpi_madt_rintc cpu_madt_rintc[NR_CPUS];
> > > > +
> > > > +static int acpi_parse_madt_rintc(union acpi_subtable_headers *header, const unsigned long end)
> > > > +{
> > > > +	struct acpi_madt_rintc *rintc = (struct acpi_madt_rintc *)header;
> > > > +	int cpuid;
> > > > +
> > > > +	if (!(rintc->flags & ACPI_MADT_ENABLED))
> > > > +		return 0;
> > > 
> > > Why not cache the data even when its disabled? We also cache the flags so
> > > we can always check later too.
> > > 
> > Okay, doesn't harm.
> > 
On second thought, I would like to keep this check. The reason is, it
is indexed using logical cpuid and OS will not enumerate disabled CPUs.

> > > > +
> > > > +	cpuid = riscv_hartid_to_cpuid(rintc->hart_id);
> > > > +	if (cpuid >= 0 && cpuid < NR_CPUS)
> > > 
> > > What does it mean for the above check to fail? Bad ACPI tables?
> > > 
> > This can happen when SMP is disabled but platform has more CPUs.
> 
> Ah yes, NR_CPUS can be too small for the platform. Maybe a comment
> explaining that we ignore all additional cpus in the ACPI tables that
> we can't manage with the kernel's limits would be helpful here.
> 
Sure.

Thanks,
Sunil
