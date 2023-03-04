Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 490EB6AAA78
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 15:38:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbjCDOif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 09:38:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjCDOid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 09:38:33 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 655F611E9F
        for <linux-kernel@vger.kernel.org>; Sat,  4 Mar 2023 06:38:30 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id x3so21178934edb.10
        for <linux-kernel@vger.kernel.org>; Sat, 04 Mar 2023 06:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eUAgGXgRJv+laJqNVXMEReHwclDFkLvFtLnzR72uPrw=;
        b=dIVQYAwN0oY6GneEdKUwezanImjswih8kPJ1Hk7y+unDqTtkY8DJ56+T7nzP/leXQS
         bh1YNEuYIDW8d01I+YbSNf/D7NRvv6cKg3KSzMNIjQMhrMd/XwG+YXh063tMMl1gJtS/
         jWUwmPcnIg6hLyQy/yBBnYyG29z7elYzz3FQvDmYnBANKll8Rake9Px1391rCXfcy+l4
         QuvQ3jU025f6JnPVol8kPSrtRrDzpsdxwbTKxWx+Fyvb1wCOdG5UPR75wnE0OxViPhPr
         MS6Tg5ONjHalcocp7UciaHZ17zRJ+T2HloS7ugVdM2+HIToQigNv4z/5bxXOJLAHrm6G
         1SCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eUAgGXgRJv+laJqNVXMEReHwclDFkLvFtLnzR72uPrw=;
        b=W0qus+v30OLN2Lh2SL+UL/1+X4WGhhlD6KxpIH84HOge0aGJRfD4yfuGcMYcEd87VI
         q8oAj3d7A2EWx1rMyeTjBLA6+02nbk5Ka+OQWE1oCuPSw+o0hD3xch2c+C2BJQ5yKT+H
         roroIrxKlGPEmHwfsfGgEavqopPoXGuNCKjn8ztWZTtNdT1KIvgmyuE2b4dSoV4muBoU
         O8krpKNRlcw2F0dIfEg1eTpOvhI0Lca/LpXmdd3aUzEoDhHo5tWv/kwQB3vE2e2liX/R
         8R/bD3z1KAWp7lo3AZhLqiLVkmtZ+72EgexZK9oSTohtBkB/srOyclK3PtODC4TD6Eku
         MWNA==
X-Gm-Message-State: AO0yUKWFIad21eQimTfNlKz5O1lKuWRueX/hk4/Ythzp72gSNNAsVrTa
        bASl/vbjmZtAnnczhXk36T6j5g==
X-Google-Smtp-Source: AK7set8ioNcJPp/YawVWhmtAJLjQLjVLhXcs+aVHAAieiYpxHxPO/0j30k2MStzTMMBS7PIbvmXdjg==
X-Received: by 2002:aa7:c551:0:b0:4a3:43c1:8430 with SMTP id s17-20020aa7c551000000b004a343c18430mr8483606edr.4.1677940708917;
        Sat, 04 Mar 2023 06:38:28 -0800 (PST)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id r29-20020a50d69d000000b004af70c546dasm2470291edi.87.2023.03.04.06.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Mar 2023 06:38:28 -0800 (PST)
Date:   Sat, 4 Mar 2023 15:38:27 +0100
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Sunil V L <sunilvl@ventanamicro.com>
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
Subject: Re: [PATCH V3 06/20] RISC-V: Add support to build the ACPI core
Message-ID: <20230304143827.mcampnt3ehkgwu26@orel>
References: <20230303133647.845095-1-sunilvl@ventanamicro.com>
 <20230303133647.845095-7-sunilvl@ventanamicro.com>
 <20230303153617.ko4duynxjvixy3bf@orel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230303153617.ko4duynxjvixy3bf@orel>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 03, 2023 at 04:36:17PM +0100, Andrew Jones wrote:
> On Fri, Mar 03, 2023 at 07:06:33PM +0530, Sunil V L wrote:
> > Enable ACPI core for RISC-V after adding architecture-specific
> > interfaces and header files required to build the ACPI core.
> > 
> > 1) Couple of header files are required unconditionally by the ACPI
> > core. Add empty acenv.h and cpu.h header files.
> > 
> > 2) If CONFIG_PCI is enabled, a few PCI related interfaces need to
> > be provided by the architecture. Define dummy interfaces for now
> > so that build succeeds. Actual implementation will be added when
> > PCI support is added for ACPI along with external interrupt
> > controller support.
> > 
> > 3) A few globals and memory mapping related functions specific
> > to the architecture need to be provided.
> > 
> > Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> > Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> > ---
> >  arch/riscv/Kconfig             |  5 +++
> >  arch/riscv/include/asm/acenv.h | 11 +++++
> >  arch/riscv/include/asm/acpi.h  | 61 ++++++++++++++++++++++++++
> >  arch/riscv/include/asm/cpu.h   |  8 ++++
> >  arch/riscv/kernel/Makefile     |  2 +
> >  arch/riscv/kernel/acpi.c       | 80 ++++++++++++++++++++++++++++++++++
> >  6 files changed, 167 insertions(+)
> >  create mode 100644 arch/riscv/include/asm/acenv.h
> >  create mode 100644 arch/riscv/include/asm/acpi.h
> >  create mode 100644 arch/riscv/include/asm/cpu.h
> >  create mode 100644 arch/riscv/kernel/acpi.c
> > 
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index 71754eb32ee6..f3108c7e19d8 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -12,6 +12,8 @@ config 32BIT
> >  
> >  config RISCV
> >  	def_bool y
> > +	select ACPI_GENERIC_GSI if ACPI
> > +	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
> >  	select ARCH_ENABLE_HUGEPAGE_MIGRATION if HUGETLB_PAGE && MIGRATION
> >  	select ARCH_ENABLE_SPLIT_PMD_PTLOCK if PGTABLE_LEVELS > 2
> >  	select ARCH_ENABLE_THP_MIGRATION if TRANSPARENT_HUGEPAGE
> > @@ -617,6 +619,7 @@ config EFI
> >  	depends on OF && !XIP_KERNEL
> >  	depends on MMU
> >  	default y
> > +	select ARCH_SUPPORTS_ACPI if 64BIT
> >  	select EFI_GENERIC_STUB
> >  	select EFI_PARAMS_FROM_FDT
> >  	select EFI_RUNTIME_WRAPPERS
> > @@ -720,3 +723,5 @@ source "drivers/cpufreq/Kconfig"
> >  endmenu # "CPU Power Management"
> >  
> >  source "arch/riscv/kvm/Kconfig"
> > +
> > +source "drivers/acpi/Kconfig"
> 
> The above Kconfig hunks don't apply on the IPI improvement base. The
> second hunk also looks weird with the select under the default.
> 

Just following up here; as Sunil pointed out in chat, the base is
latest master with the IPI improvement rebased. I was using the
last IPI improvement branch. So that explains the problem I had
applying this and the weirdness I was seeing with the Kconfig
lines (select/default) as compared to v2.

Thanks,
drew
