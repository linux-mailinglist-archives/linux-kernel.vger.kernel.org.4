Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C70E96D8E0F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 05:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235327AbjDFDqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 23:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235323AbjDFDqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 23:46:46 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7724E975A
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 20:46:44 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id w133so28209296oib.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 20:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1680752803; x=1683344803;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e2HC8P/hmf80QzMRLst56jAGHCnOy19Nb1SfXkyKnng=;
        b=OdCYn4+VByG1SRoySM17nK1AXgMbZVRXlJ5uIqR+tfwGuKggZw222F7duYA9Vb89YK
         27pnFjed1vkAWjIH3w9kqNNxzyvrRs3I40xpJc8gABvfqFbm84Ah6fCAVV+EpDcHKNEM
         T6LqevGxh7v6QeMq8lX+Fn0O2uSvDEMaPjduq6COs02ZgwWQq7TWFyzEWjpUoxp8g7/W
         HeDHWwDs5YlngSYn9Y4eEcJFWPL1d9LCI5B4h6ljv4T9xfXx5ZEmdJDMYKPLEVyc5Sh4
         e44ljucW2T/N/BZX5bfGqLHRrTCgxLP8TCM5oFflHLmQC3TPZL8Zpd5lDO1iSTWcWsjf
         DH2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680752803; x=1683344803;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e2HC8P/hmf80QzMRLst56jAGHCnOy19Nb1SfXkyKnng=;
        b=gnyXeY4KeiTzZQUmIoKgPpRzMxaJqudbTVzl8eqP5QxoEIKdB519ZKJ+DvgNd7fx5t
         hh0DkrF9ltyrU7kWHwnajg61DddEhk8bBP0gJtauvryh4aeDXEJqoxNvl6sO4QNssHYj
         5zq7EUjNAgEwhrUkWr6sQjic2sbbQazDTxuHjnRn4TTtE30C5GKg3bVR/TFIQf1hSNgN
         QmjB6ulzpWWO2dkD3FeRIglU90VkgkcntLS5qMZNsZyFbYuNa0gsggREZ/nickDnyxwd
         HojSY3gmJCSG3aeptQ5xjxBdNU3v52i0Nl4wf6mLvLw/+cYrTt8CrFbuisJ5uE86j2qa
         HRbA==
X-Gm-Message-State: AAQBX9fH/birTEnDROLGHcAREEFSOxBuQlReQS9NehPWrLM8sq2YrG3r
        WQA/MpfkT3O02NdIPjiDeYrxKA==
X-Google-Smtp-Source: AKy350aAm5JE1r76kf6Lxl9p5V+N5sZaj6KFuUrSbX6DgQQJMad992E4+fIEGKxtn2iiwPmCcOOrnA==
X-Received: by 2002:aca:d17:0:b0:388:f4de:1ed7 with SMTP id 23-20020aca0d17000000b00388f4de1ed7mr3555483oin.1.1680752803481;
        Wed, 05 Apr 2023 20:46:43 -0700 (PDT)
Received: from sunil-laptop ([106.51.83.242])
        by smtp.gmail.com with ESMTPSA id en12-20020a056808394c00b003898ebb8be0sm215967oib.48.2023.04.05.20.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 20:46:43 -0700 (PDT)
Date:   Thu, 6 Apr 2023 09:16:31 +0530
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     Andrew Jones <ajones@ventanamicro.com>
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
Message-ID: <ZC5Al3swBGK1WP0g@sunil-laptop>
References: <20230404182037.863533-1-sunilvl@ventanamicro.com>
 <20230404182037.863533-9-sunilvl@ventanamicro.com>
 <h4wgl5pc4bptxsmlmf7ggohq2y2uwk6ecaoytyywbwhf2ubnzj@ojanwytq5lrk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <h4wgl5pc4bptxsmlmf7ggohq2y2uwk6ecaoytyywbwhf2ubnzj@ojanwytq5lrk>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 05, 2023 at 05:17:48PM +0200, Andrew Jones wrote:
> On Tue, Apr 04, 2023 at 11:50:22PM +0530, Sunil V L wrote:
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
> 
> As Conor pointed out, the errors could be propagated from
> acpi_table_parse_madt(), which could reduce this function to
> 
>  return acpi_table_parse_madt(ACPI_MADT_TYPE_RINTC, acpi_parse_madt_rintc, 0);
> 
> where the '< 0' check would be in the caller below. That sounds good to
> me, but then I'd take that a step further and just drop this helper
> altogether.
> 
Thanks, Conor, Drew. I used similar to how others have used
acpi_table_parse_madt(). But your suggestion makes sense. Will remove
the wrapper function also.

Thanks,
Sunil
