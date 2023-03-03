Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0557C6A9A04
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 15:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbjCCO6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 09:58:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbjCCO6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 09:58:40 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A32E252BD
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 06:58:38 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id cy23so11277618edb.12
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 06:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wmxUOkBdjSGKx6uxMbgOTNlH+FMAT+rPeMxFUSXuT+8=;
        b=nRY/zefoyq61orF3bLInswWjd5Pa5mWbq/6LTZ8QyyJkYWsVOJPtpVmc/liy2y9Ouk
         YmRW8zbsXUyOS1k/IE9XVToSzSc8AlpxYVQaVHjBECwcE/6Dpc+SPh3rVORZVWKpCs8Q
         BPIbOyWtcJH4fftUVTXF+t5UDB7Oij/M8lTFxyxUzBHcMSujpqKvOh6o4Kf6wfv009+V
         XvN1LP7bu9Q+RN/SrCVGMFPb9mhrWGrM3toKcAICGgMCPeuIlb5uXDYJYiM+UyB2ftYM
         Ci4x58BExvzMxculUTNthl75drE1ddnelLjU6yIziUk/NATl4q6XaPwjjLB6c5C5zIit
         6Itg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wmxUOkBdjSGKx6uxMbgOTNlH+FMAT+rPeMxFUSXuT+8=;
        b=LFd/SdJUzCEwnwhZwA13dmcgptv5OJ++HYRvHarQH7B5kX/6kcLSE2YFK8CzjeWJw8
         rgUOhzgwVaFQM7S8vnyYdDCyPvDjwMmhbP2l7dFqIyeNF7kX3Z/FNoYiG+a3jYTBqZ3K
         nVC9DkXmJQPl7Viinucg1bWYwlwHlWZSEv4oEM780IbDM7fS2m3ITg6f7dGDsqKMj7EO
         lMRynP+YDMTuf9ciyoyuKPPxZssCbS4p3EToGi4+zYP83+CyS5d2/omMRvZX96FbPjpt
         ZhOvzcsIGa53Z88qbWuW477o72oV6pT3lGCmGLBgJ0wWpHL1C0l5NpCJ8gX2S1TCVhoP
         bKiQ==
X-Gm-Message-State: AO0yUKWA0wqTeI/6dUQZNorIOuUBMSVQX9ZF7V0E4mAnnppX8Rlpzadl
        JhL3NOJAlNf6R57ylkk0S+v7fI+kUA6jG0XB
X-Google-Smtp-Source: AK7set+k2+XbMi6jzaNLWQgQ8mW+LymZKLxYqe98qIeJsqKhuU1m5u+oeRUzHlffalIDj4CywZ/zUw==
X-Received: by 2002:a05:6402:64c:b0:4a2:4a89:2331 with SMTP id u12-20020a056402064c00b004a24a892331mr1950653edx.29.1677855517128;
        Fri, 03 Mar 2023 06:58:37 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id z13-20020a50eb4d000000b004c0b58f088esm1232273edp.10.2023.03.03.06.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 06:58:36 -0800 (PST)
Date:   Fri, 3 Mar 2023 15:58:35 +0100
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
Subject: Re: [PATCH V3 04/20] ACPI: tables: Print RINTC information when MADT
 is parsed
Message-ID: <20230303145835.hpep2zxyknimfyd7@orel>
References: <20230303133647.845095-1-sunilvl@ventanamicro.com>
 <20230303133647.845095-5-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230303133647.845095-5-sunilvl@ventanamicro.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 03, 2023 at 07:06:31PM +0530, Sunil V L wrote:
> When MADT is parsed, print RINTC information as below:
> 
> ACPI: RISC-V INTC (acpi_uid[0x0000] hart_id[0x0] enabled)
> ACPI: RISC-V INTC (acpi_uid[0x0001] hart_id[0x1] enabled)
> ...
> ACPI: RISC-V INTC (acpi_uid[0x000f] hart_id[0xf] enabled)
> 
> This debug information will be very helpful during bring up.
> 
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/acpi/tables.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> index 7b4680da57d7..8ab0a82b4da4 100644
> --- a/drivers/acpi/tables.c
> +++ b/drivers/acpi/tables.c
> @@ -220,6 +220,16 @@ void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
>  		}
>  		break;
>  
> +	case ACPI_MADT_TYPE_RINTC:
> +		{
> +			struct acpi_madt_rintc *p = (struct acpi_madt_rintc *)header;
> +
> +			pr_debug("RISC-V INTC (acpi_uid[0x%04x] hart_id[0x%llx] %s)\n",
> +				 p->uid, p->hart_id,
> +				 (p->flags & ACPI_MADT_ENABLED) ? "enabled" : "disabled");
> +		}
> +		break;
> +
>  	default:
>  		pr_warn("Found unsupported MADT entry (type = 0x%x)\n",
>  			header->type);
> -- 
> 2.34.1
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
