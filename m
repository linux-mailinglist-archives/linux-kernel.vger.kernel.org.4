Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FAC46D818B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 17:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238968AbjDEPSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 11:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238941AbjDEPSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 11:18:24 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A036476B0
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 08:17:51 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id j18-20020a05600c1c1200b003ee5157346cso23961885wms.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 08:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1680707870;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sWW2wHNkorlWl7f1lW5XfddvHk1ze5o7vXdVcEMXG2g=;
        b=fvLLT0TKm80nLpradZWDrOdneNGgfIOpZX+TQzvpBIusENmya0I/V5nt+WjUABWW2l
         mbre3ur0k5ApQtARUVrDy3VbtXfvBG2b7NMfG6XJ8EPQRdy0yGlt/iHDjYNYaPJKAxwS
         nrObDnZzuvvkNUHI8TqpDe3ysxRKjhCor5+ZP/jbtWgiQYJffTIsupTet7RzDwP4cgwG
         1yF2Dnn1g8d3PHLErOvpIrgNydSF7neE+RkSkyTxU8r3sEyXnNZD0c4MSO0JFlMsPFFq
         3TWf4LI5HL942nnh7CC19GskHTaB8TpfkIBM2/amfHSQmVa7FEiXeAqQ30llEJ4N00Ph
         +z2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680707870;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sWW2wHNkorlWl7f1lW5XfddvHk1ze5o7vXdVcEMXG2g=;
        b=aDIqCQoAHuIJUPz5/z6+6Uh3/bsudxpTla66ycsrdgVHXn+oJalccoeGO80LWlTr6C
         WMKYkyI06kXC/NpjeSxdK2nFtM/RSYYHiiPEx13cwEQZyGNsGrwwjS9Q09r6VHdkEXWj
         hh+13d5V1D/kPSJRrS+QWrcjUPqo6Z3z6QMagLi1D+rNCcuewGvzzJ/cuEkEJVpg3v4q
         eEHNzYKEkoBmPWX7VGyn2/4zFufqvC2QXEjMCPjdcuMegJyz9DQMD1TtLPBVrCo3L2bl
         CsbdjvDZC2Ij+YIwRjxe+ENhdM6s1ef0TWHI5xHVIZBjTfYAKS3YpxQm+hLOkNTsWGEl
         evvQ==
X-Gm-Message-State: AAQBX9cjPu83Dhm2Y164RZS6xxt8TobBcrAGqdSYqEiVHVBKfjDOvo3J
        I0ZGs8IGO75I0Ap5MErtiNIqtA==
X-Google-Smtp-Source: AKy350YQ1cUUvA1lbwvmYdodZoWCEOfWJdxBblHqZiOrZN3zwRgs3uGIhPappIdTQFzIU/BI6H3nRA==
X-Received: by 2002:a05:600c:b42:b0:3ed:66e0:b6de with SMTP id k2-20020a05600c0b4200b003ed66e0b6demr5272095wmr.22.1680707869916;
        Wed, 05 Apr 2023 08:17:49 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id h18-20020a05600c315200b003ef6708bc1esm2573765wmo.43.2023.04.05.08.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 08:17:49 -0700 (PDT)
Date:   Wed, 5 Apr 2023 17:17:48 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Sunil V L <sunilvl@ventanamicro.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-crypto@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        llvm@lists.linux.dev, Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Len Brown <lenb@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Weili Qian <qianweili@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Marc Zyngier <maz@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH V4 08/23] RISC-V: ACPI: Cache and retrieve the RINTC
 structure
Message-ID: <h4wgl5pc4bptxsmlmf7ggohq2y2uwk6ecaoytyywbwhf2ubnzj@ojanwytq5lrk>
References: <20230404182037.863533-1-sunilvl@ventanamicro.com>
 <20230404182037.863533-9-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404182037.863533-9-sunilvl@ventanamicro.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2023 at 11:50:22PM +0530, Sunil V L wrote:
> RINTC structures in the MADT provide mapping between the hartid
> and the CPU. This is required many times even at run time like
> cpuinfo. So, instead of parsing the ACPI table every time, cache
> the RINTC structures and provide a function to get the correct
> RINTC structure for a given cpu.
> 
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  arch/riscv/include/asm/acpi.h |  2 ++
>  arch/riscv/kernel/acpi.c      | 60 +++++++++++++++++++++++++++++++++++
>  2 files changed, 62 insertions(+)
> 
> diff --git a/arch/riscv/include/asm/acpi.h b/arch/riscv/include/asm/acpi.h
> index 9be52b6ffae1..1606dce8992e 100644
> --- a/arch/riscv/include/asm/acpi.h
> +++ b/arch/riscv/include/asm/acpi.h
> @@ -59,6 +59,8 @@ static inline bool acpi_has_cpu_in_madt(void)
>  
>  static inline void arch_fix_phys_package_id(int num, u32 slot) { }
>  
> +struct acpi_madt_rintc *acpi_cpu_get_madt_rintc(int cpu);
> +u32 get_acpi_id_for_cpu(int cpu);
>  #endif /* CONFIG_ACPI */
>  
>  #endif /*_ASM_ACPI_H*/
> diff --git a/arch/riscv/kernel/acpi.c b/arch/riscv/kernel/acpi.c
> index 81d448c41714..40ab55309c70 100644
> --- a/arch/riscv/kernel/acpi.c
> +++ b/arch/riscv/kernel/acpi.c
> @@ -24,6 +24,66 @@ EXPORT_SYMBOL(acpi_disabled);
>  int acpi_pci_disabled = 1;	/* skip ACPI PCI scan and IRQ initialization */
>  EXPORT_SYMBOL(acpi_pci_disabled);
>  
> +static struct acpi_madt_rintc cpu_madt_rintc[NR_CPUS];
> +
> +static int acpi_parse_madt_rintc(union acpi_subtable_headers *header, const unsigned long end)
> +{
> +	struct acpi_madt_rintc *rintc = (struct acpi_madt_rintc *)header;
> +	int cpuid;
> +
> +	if (!(rintc->flags & ACPI_MADT_ENABLED))
> +		return 0;
> +
> +	cpuid = riscv_hartid_to_cpuid(rintc->hart_id);
> +	/*
> +	 * When CONFIG_SMP is disabled, mapping won't be created for
> +	 * all cpus.
> +	 * CPUs more than NR_CPUS, will be ignored.
> +	 */
> +	if (cpuid >= 0 && cpuid < NR_CPUS)
> +		cpu_madt_rintc[cpuid] = *rintc;
> +
> +	return 0;
> +}
> +
> +static int acpi_init_rintc_array(void)
> +{
> +	if (acpi_table_parse_madt(ACPI_MADT_TYPE_RINTC, acpi_parse_madt_rintc, 0) > 0)
> +		return 0;
> +
> +	return -ENODEV;

As Conor pointed out, the errors could be propagated from
acpi_table_parse_madt(), which could reduce this function to

 return acpi_table_parse_madt(ACPI_MADT_TYPE_RINTC, acpi_parse_madt_rintc, 0);

where the '< 0' check would be in the caller below. That sounds good to
me, but then I'd take that a step further and just drop this helper
altogether.

> +}
> +
> +/*
> + * Instead of parsing (and freeing) the ACPI table, cache
> + * the RINTC structures since they are frequently used
> + * like in  cpuinfo.
             ^ extra space

> + */
> +struct acpi_madt_rintc *acpi_cpu_get_madt_rintc(int cpu)
> +{
> +	static bool rintc_init_done;
> +
> +	if (!rintc_init_done) {
> +		if (acpi_init_rintc_array()) {
> +			pr_err("No valid RINTC entries exist\n");
> +			return NULL;
> +		}
> +
> +		rintc_init_done = true;
> +	}
> +
> +	return &cpu_madt_rintc[cpu];
> +}
> +
> +u32 get_acpi_id_for_cpu(int cpu)
> +{
> +	struct acpi_madt_rintc *rintc = acpi_cpu_get_madt_rintc(cpu);
> +
> +	BUG_ON(!rintc);
> +
> +	return rintc->uid;
> +}
> +
>  /*
>   * __acpi_map_table() will be called before paging_init(), so early_ioremap()
>   * or early_memremap() should be called here to for ACPI table mapping.
> -- 
> 2.34.1
>

Otherwise,

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Thanks,
drew
