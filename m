Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7628C6A9DF3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 18:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbjCCRtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 12:49:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbjCCRtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 12:49:39 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94599196A8
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 09:49:37 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id y11so3539759plg.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 09:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1677865777;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ci3RnlB0VZFKqzzAEnpOLkE36BOnr4VRjKen387ZgnE=;
        b=iz7Fbv/e7nazEjnOF1SV143FLcPMaNcE4smxk4E9MSI/T59GJkyBupMF1A4mRoR3BG
         +jwbF26UALINlRANG1ZIOk0fDrIsu5O6TEFRKSTUTjlqMAZHAunjuUit8tU3zO3h45Od
         asjPP2iJPLCjSZKoJhxXsNhbLhBv6vkx1+el6dKiDz8AjV6QiX7RT4G4Og/KvYCiiH7R
         EAnkKzLbyhoTNPq39S7jst7ZfOsILBEx7zl358FEK01RyqDe7KNPiSghDlETXMU308oc
         jNma8oumdTjwqg6hAthoKLmRxnnW7dUVBLsa0eegq1WdP5lL3eVO3cPc+mFzR+30AEFN
         rKew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677865777;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ci3RnlB0VZFKqzzAEnpOLkE36BOnr4VRjKen387ZgnE=;
        b=NWrzd9cnhdts0EjU612peFrtRTkf1lu9MoTmmlgk6fNrpUidNizudrjihzzDQZRHro
         z1tT39+E/R//qj21TsPlPS2cjmjM2iqO0kxqwtibzIzinYYHdWhxqnaZOwUG6NFTCrMh
         +DdbA0XM4tIONjCzcFjdIFf2VhhIp8Prc6Bh4/gnzlQ7UfjhmqU5J/TEqGDgOlIqRw2y
         /75Lji2vUcF7Uor+s2itoMGa7z/7ua9hcrP32i6vZq44Rpa2/5UuzHNXQNga87aOAmdI
         NblLEJFiXTaNDigxWDz6rADzBLOBfByGSWZJ18MYa5WF5o2AxOkmKAX71nF1cSR9Dn2f
         Utxg==
X-Gm-Message-State: AO0yUKVoT0umh50qmP19w8q3AkKKRPZ5LR6Vj3pqftFH9XRBFWPyemfH
        b3v/3bNKWda8mSeI/SBRDvn6tg==
X-Google-Smtp-Source: AK7set+Bf+zqq8sNm9WNWTp7EAHBGvsHuLhVhVk39cIGjEsd50L3ZxtSbFwAzHH6JTd/AxqyzAnIWg==
X-Received: by 2002:a05:6a20:160a:b0:cc:88af:12ab with SMTP id l10-20020a056a20160a00b000cc88af12abmr3571575pzj.28.1677865776948;
        Fri, 03 Mar 2023 09:49:36 -0800 (PST)
Received: from sunil-laptop ([49.206.8.117])
        by smtp.gmail.com with ESMTPSA id i23-20020aa787d7000000b005a8b882a239sm1905656pfo.109.2023.03.03.09.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 09:49:36 -0800 (PST)
Date:   Fri, 3 Mar 2023 23:19:28 +0530
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     Andrew Jones <ajones@ventanamicro.com>
Cc:     Conor Dooley <conor@kernel.org>, linux-riscv@lists.infradead.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>,
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
Message-ID: <ZAIzKLzKE7MpQ+Yr@sunil-laptop>
References: <20230303133647.845095-1-sunilvl@ventanamicro.com>
 <20230303133647.845095-12-sunilvl@ventanamicro.com>
 <20230303160556.lezccmwa7ymymxws@orel>
 <fdb52973-0cbc-4d7e-88bc-534fe43eec9b@spud>
 <20230303172113.jskripuyr3xx2z7k@orel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230303172113.jskripuyr3xx2z7k@orel>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 03, 2023 at 06:21:13PM +0100, Andrew Jones wrote:
> On Fri, Mar 03, 2023 at 04:58:53PM +0000, Conor Dooley wrote:
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
> > 
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
> > 
> > I think I asked for this (or assumed it existed) in v1, when I requested
> > the removal of #ifdef CONFIG_ACPI stuff in riscv_fill_hwcap().
> > Personally, I'd rather have this stub than the ifdeffery :)
> >
> 
> Yeah, avoiding #ifdefs with stubs is good if we need to call the function
> from non-ACPI code. I'm wondering why we'd need to, though. In all the
> cases introduced with this series, we could pass a 'cpu' to
> acpi_get_riscv_isa() and then have acpi_get_riscv_isa() call
> get_acpi_id_for_cpu() itself, for example.
> 
Yes, that's a good idea to avoid the stub. Will update. Thanks!

> We also need to be sure -1 truly means "no ACPI ID" in order to stub this.
> 
Yes, with your BUG suggestion I can remove this.

Thanks,
Sunil
