Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80BE76A1C33
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 13:33:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbjBXMdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 07:33:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjBXMdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 07:33:31 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E72611145
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 04:33:30 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id u10so16322415pjc.5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 04:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=33SPJrepXDYssJSSelUFbYD0nTs1piiuF+fmKofYKbQ=;
        b=HZjYKspC5Lg+X2Vc9+J+jE4cCFYNqipGB40OShgGw1NkXykEcvmXTg3EkUMMJ0Krvq
         GirqMJEO2TtJ9E3eYI8I6jWMOAqAeSJuiQT4psC4ab29hORjztAwkbW3JR8govjoCuZX
         kq+dIR0feWtHrGqS5CIxTm+uAdbbY94+z1t/F7ehxZ4bSnq9O6hyqHht8cm/ZSXec9w/
         hN7Hxvf33LQJF9T6ZiavpINS3coNhyiK68zbYhbTpEeJAesWNHBSTRkFkCcqq3JuQaHX
         9SnFSd188NFbKPg0sqNBf11jT074nHgWyuurp4rkBXTfn84I6WJI9Ymsbiwl9RinrKej
         ZQ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=33SPJrepXDYssJSSelUFbYD0nTs1piiuF+fmKofYKbQ=;
        b=dQJk9fpYqTKtuVGyFakcj7JfpY1wFh0syctafqJxdh1iT94EQzfMv9OoUv8RvqtTi/
         lCN4yt5uCS3CxeSNpJu43ICrtqRyx/8bmE+YQo0wmnxElIAecg1ogJInqUFLwKnGso4v
         5FPh3CButFixmJsUscWCeV5xfRVXyDo+QNIek1nYC20/rCJTd7iVv5CvMUh4pGHWcikp
         QVvcv+LmOP74oBsAAxO4ENasVV4RvMuyXfeWC9CNOvB+3hNbxoDpIWVn6+7BSqX42h5V
         OBn5Gw1NVl0SvD8+yLJlbQLjc43dZj1PDcfXditWFDa6OvL9kSW6cu5xb+cZTZT3K0xe
         dJ0Q==
X-Gm-Message-State: AO0yUKUmMxfEbfe5Q0B3HiGrD2A7BkhAZxSx6OHPjXrpVQyDwXb1C/Om
        uCPcNwwBJjwImAEpmgz0NyQjlQ==
X-Google-Smtp-Source: AK7set8lh4oq9Ny2jUvEaopudjtRsPWRkWSe2qv0BwYCD1GzQdlvIN5SMUosnRA8cejuyeAa/JHwWg==
X-Received: by 2002:a05:6a20:a020:b0:cb:db9d:f78d with SMTP id p32-20020a056a20a02000b000cbdb9df78dmr9506579pzj.47.1677242009581;
        Fri, 24 Feb 2023 04:33:29 -0800 (PST)
Received: from sunil-laptop ([49.206.14.226])
        by smtp.gmail.com with ESMTPSA id u2-20020a62ed02000000b005e0699464e3sm1835833pfh.206.2023.02.24.04.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 04:33:29 -0800 (PST)
Date:   Fri, 24 Feb 2023 18:03:20 +0530
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
Subject: Re: [PATCH V2 17/21] RISC-V: time.c: Add ACPI support for time_init()
Message-ID: <Y/iukIjBKO0wRm/X@sunil-laptop>
References: <20230216182043.1946553-1-sunilvl@ventanamicro.com>
 <20230216182043.1946553-18-sunilvl@ventanamicro.com>
 <20230220195808.reyuclvefujucpsq@orel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230220195808.reyuclvefujucpsq@orel>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2023 at 08:58:08PM +0100, Andrew Jones wrote:
> On Thu, Feb 16, 2023 at 11:50:39PM +0530, Sunil V L wrote:
> > On ACPI based platforms, timer related information is
> > available in RHCT. Add ACPI based probe support to the
> > timer initialization.
> > 
> > Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> > Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  arch/riscv/kernel/time.c | 25 +++++++++++++++++++------
> >  1 file changed, 19 insertions(+), 6 deletions(-)
> > 
> > diff --git a/arch/riscv/kernel/time.c b/arch/riscv/kernel/time.c
> > index 1cf21db4fcc7..e49b897fc657 100644
> > --- a/arch/riscv/kernel/time.c
> > +++ b/arch/riscv/kernel/time.c
> > @@ -4,6 +4,7 @@
> >   * Copyright (C) 2017 SiFive
> >   */
> >  
> > +#include <linux/acpi.h>
> >  #include <linux/of_clk.h>
> >  #include <linux/clockchips.h>
> >  #include <linux/clocksource.h>
> > @@ -18,17 +19,29 @@ EXPORT_SYMBOL_GPL(riscv_timebase);
> >  void __init time_init(void)
> >  {
> >  	struct device_node *cpu;
> > +	struct acpi_table_rhct *rhct;
> > +	acpi_status status;
> >  	u32 prop;
> >  
> > -	cpu = of_find_node_by_path("/cpus");
> > -	if (!cpu || of_property_read_u32(cpu, "timebase-frequency", &prop))
> > -		panic(KERN_WARNING "RISC-V system with no 'timebase-frequency' in DTS\n");
> > -	of_node_put(cpu);
> > -	riscv_timebase = prop;
> > +	if (acpi_disabled) {
> > +		cpu = of_find_node_by_path("/cpus");
> > +		if (!cpu || of_property_read_u32(cpu, "timebase-frequency", &prop))
> > +			panic("RISC-V system with no 'timebase-frequency' in DTS\n");
> > +		of_node_put(cpu);
> > +		riscv_timebase = prop;
> > +	} else {
> > +		status = acpi_get_table(ACPI_SIG_RHCT, 0, (struct acpi_table_header **)&rhct);
> > +		if (ACPI_FAILURE(status))
> > +			panic("RISC-V ACPI system with no RHCT table\n");
> > +		riscv_timebase = rhct->time_base_freq;
> > +		acpi_put_table((struct acpi_table_header *)rhct);
> > +	}
> >  
> >  	lpj_fine = riscv_timebase / HZ;
> >  
> > -	of_clk_init(NULL);
> > +	if (acpi_disabled)
> > +		of_clk_init(NULL);
> 
> I think we should be able to move of_clk_init() up into the acpi_disabled
> arm rather than add another if here.

Yes, will update.

Thanks,
Sunil
