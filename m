Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 511396A9D51
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 18:21:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbjCCRV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 12:21:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbjCCRV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 12:21:26 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68934743A
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 09:21:16 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id o15so12991715edr.13
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 09:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7+P2Jt1gem1+5/B5CcM4rTOyPV+AeTyxbIp+/3dNo5A=;
        b=WPye6mZe6O/Y3KmvZJOOqo9FbOHD+uSL2hAl7O6U/eRKKUFOvMUWsgvNScZIWVRC54
         DwpVvEGp/nxyrPtYQcd5glZaTKkBSkQFtbXf/jChUSn+pim62zgFQLnZwulS0dIbjBw8
         HY6B5/Nxg1WyR7suWAzlxnhqoFShCFqbjx/FFhgGonYtTHnB1TvkGc6fUnzH0W48NNs2
         ouktdj7fJnlxWqGLesJoO+KK/MrDq8wTly+giIiuIa3hYYUyta/Hj6GicCFXqohC5f64
         e1z/CtP9tEXuFnM1QXBcwvY01FdX3hZwn+oK6gh1JOuFYDKqkVoW2dSVbBZlaH+Un+9z
         FxNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7+P2Jt1gem1+5/B5CcM4rTOyPV+AeTyxbIp+/3dNo5A=;
        b=MX+Gzo4N+/GZJ1wWfRj0EivCUBsG3jJmGEJ/2iiY50QCCv6oCG5G1OJl2ymNDDUKcW
         IYPTUj4yKTEMcRKjWf4fLLW+iBbQTQiymHRk8AxMhgOiOzAJl72QtBZFGs1FkQbwZbhO
         qx9BGRNAaNOICmE8Sds/K8xUIJcFh72gGfQqi+9nJ/ZcmV3KgZsgFe7Ezx909y3rwvrM
         JC3oER3Abl/ScObKh/Hct4pE5B1sgFGxdscCt26X7WQUxEqRq9RaKFIjcs4+nyDJdjzL
         KvOB2ZctCqRwFGQtpS/Xh/hLBIda7ljif0jwwnXvb9YPV4kAZxVCVOq+UW88f6UjtSv9
         foIw==
X-Gm-Message-State: AO0yUKV4nY16eM1RZFq5uMqGRh+pvqPuUAy7s5R7TbYYbMkCMqkDFr9v
        M1AGdzu1dPOlsRM+wy7bVNhq1A==
X-Google-Smtp-Source: AK7set8ZD2J/CsfQlCGk7mFzIWQdBS1dzaQEQ6jA3tE1K1Vw8oYIqCClLWU5JnIns07/oFdwwCC5uQ==
X-Received: by 2002:a17:907:c60c:b0:7c0:e30a:d3e5 with SMTP id ud12-20020a170907c60c00b007c0e30ad3e5mr3030314ejc.18.1677864075213;
        Fri, 03 Mar 2023 09:21:15 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id t26-20020a1709060c5a00b008ec793ac3f4sm1146250ejf.192.2023.03.03.09.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 09:21:14 -0800 (PST)
Date:   Fri, 3 Mar 2023 18:21:13 +0100
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     Sunil V L <sunilvl@ventanamicro.com>,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
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
Message-ID: <20230303172113.jskripuyr3xx2z7k@orel>
References: <20230303133647.845095-1-sunilvl@ventanamicro.com>
 <20230303133647.845095-12-sunilvl@ventanamicro.com>
 <20230303160556.lezccmwa7ymymxws@orel>
 <fdb52973-0cbc-4d7e-88bc-534fe43eec9b@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fdb52973-0cbc-4d7e-88bc-534fe43eec9b@spud>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 03, 2023 at 04:58:53PM +0000, Conor Dooley wrote:
> On Fri, Mar 03, 2023 at 05:05:56PM +0100, Andrew Jones wrote:
> > On Fri, Mar 03, 2023 at 07:06:38PM +0530, Sunil V L wrote:
> > > RINTC structures in the MADT provide mapping between the hartid
> > > and the CPU. This is required many times even at run time like
> > > cpuinfo. So, instead of parsing the ACPI table every time, cache
> > > the RINTC structures and provide a function to get the correct
> > > RINTC structure for a given cpu.
> > > 
> > > Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> > > Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > ---
> > >  arch/riscv/include/asm/acpi.h |  9 ++++++
> > >  arch/riscv/kernel/acpi.c      | 56 +++++++++++++++++++++++++++++++++++
> > >  2 files changed, 65 insertions(+)
> 
> > > diff --git a/arch/riscv/include/asm/acpi.h b/arch/riscv/include/asm/acpi.h
> > > index 111a8ed10af1..8be16c1ef7da 100644
> > > --- a/arch/riscv/include/asm/acpi.h
> > > +++ b/arch/riscv/include/asm/acpi.h
> > > @@ -61,6 +61,10 @@ static inline void arch_fix_phys_package_id(int num, u32 slot) { }
> > >  
> > >  int acpi_get_riscv_isa(struct acpi_table_header *table,
> > >  		       unsigned int cpu, const char **isa);
> > > +
> > > +struct acpi_madt_rintc *acpi_cpu_get_madt_rintc(int cpu);
> > > +
> > > +u32 get_acpi_id_for_cpu(int cpu);
> > >  #else
> > >  static inline int acpi_get_riscv_isa(struct acpi_table_header *table,
> > >  				     unsigned int cpu, const char **isa)
> > > @@ -68,6 +72,11 @@ static inline int acpi_get_riscv_isa(struct acpi_table_header *table,
> > >  	return -EINVAL;
> > >  }
> > >  
> > > +static inline u32 get_acpi_id_for_cpu(int cpu)
> > > +{
> > > +	return -1;
> > > +}
> > 
> > Why do we need this stub? I wouldn't expect non-ACPI code to need an ACPI
> > ID.
> 
> I think I asked for this (or assumed it existed) in v1, when I requested
> the removal of #ifdef CONFIG_ACPI stuff in riscv_fill_hwcap().
> Personally, I'd rather have this stub than the ifdeffery :)
>

Yeah, avoiding #ifdefs with stubs is good if we need to call the function
from non-ACPI code. I'm wondering why we'd need to, though. In all the
cases introduced with this series, we could pass a 'cpu' to
acpi_get_riscv_isa() and then have acpi_get_riscv_isa() call
get_acpi_id_for_cpu() itself, for example.

We also need to be sure -1 truly means "no ACPI ID" in order to stub this.

Thanks,
drew
