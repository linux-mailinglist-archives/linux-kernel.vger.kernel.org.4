Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB51C694B08
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 16:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbjBMPZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 10:25:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbjBMPZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 10:25:16 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A578B13DF2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 07:25:15 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id b5so13837729plz.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 07:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FNfsb97cJzUdtaFYoYtlJPsp0WgsDGOiTJIw3fsXmGc=;
        b=UoHX4/xGzz6PNGpqbsGARaUG+1vmTyq7b2+J2eS1iM1qujXKo7t86A4bramcIv370T
         azfMZvqAYcpsg7RDNBs5hgrH4974iGQ47Vx1ageovgd4sWojolhsoXRrox+7F4gKFDLX
         G6LdmJyvv4q9EnvV6kVfWYE3Rl4y74hP3Hayoe5U5tliazCJBgnXIpcGtGu+edoz4KkJ
         1+7paXdmCzBdOukfaUrORpHezFhiw99q2n4WnJBtC1SnBMwndIhqRt0gF2hhE9eFE031
         9L95cv/aS5fzxkbZRLgr5L4P3tAtAvHMjwjPEqsZT1jU5h3N+GjNWCD2IMS2wCZ6jkDW
         PHxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FNfsb97cJzUdtaFYoYtlJPsp0WgsDGOiTJIw3fsXmGc=;
        b=qtsBKlm/CDtpb/7WL19K6+PrBoruBzDoaalQvZk2SQZ3jhNZqLxV3q8QVwJebZ3CUz
         eH8lNbSOzm58F7m8T0Ad/hzB19jq03PzVoP7S333Sq0YKgW3IfgkzilXbkbM79Y3/myV
         1niNYsCgWmswljZxeN/vYL78ifJJDJXYllx0AdGeohEnD9PEHbhC09aoYpfK3ojvy1nF
         zonndtXY/bIt8H+RKwpIyXTv39vQOxvaqb+rDymB4n01sXaqKzMK5cIwuM2Qy49rZ5kO
         25DQihtxV3HqwyhN3QeFZJvSVotkbu91yPO4PdcutpttxbRZnoR8ZNmqeN4F7xZyagOI
         y8zQ==
X-Gm-Message-State: AO0yUKVxXwTdBdsG+OVHd/5UWi4zOfFmwBAfXL2ogxEM8mXDyMnOT78T
        dVe55qkFUW8LCsht0BbKHB9SGEtN1Y10Oec9
X-Google-Smtp-Source: AK7set8tb53lJAdH640whwYNdv6aF5uGIiD0eDiAvysUdUDEt30iBZ5bxMC8Jsl6jKrogkmK8bbD/g==
X-Received: by 2002:a17:90b:1b04:b0:234:1d1d:6ae6 with SMTP id nu4-20020a17090b1b0400b002341d1d6ae6mr848123pjb.1.1676301915245;
        Mon, 13 Feb 2023 07:25:15 -0800 (PST)
Received: from sunil-laptop ([49.206.14.226])
        by smtp.gmail.com with ESMTPSA id w9-20020a637b09000000b004fbb48e3e5csm1549444pgc.77.2023.02.13.07.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 07:25:14 -0800 (PST)
Date:   Mon, 13 Feb 2023 20:55:07 +0530
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
Subject: Re: [PATCH 11/24] RISC-V: ACPI: irqchip/riscv-intc: Add ACPI support
Message-ID: <Y+pWU+799GSUsGDP@sunil-laptop>
References: <20230130182225.2471414-1-sunilvl@ventanamicro.com>
 <20230130182225.2471414-12-sunilvl@ventanamicro.com>
 <Y+QY9DCf6JPBNVS7@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+QY9DCf6JPBNVS7@spud>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 09:49:40PM +0000, Conor Dooley wrote:
> Hey Sunil,
> 
> On Mon, Jan 30, 2023 at 11:52:12PM +0530, Sunil V L wrote:
> > Add support for initializing the RISC-V INTC driver on ACPI based
> > platforms.
> > 
> > Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> 
> > +static int __init
> > +riscv_intc_acpi_init(union acpi_subtable_headers *header,
> > +		     const unsigned long end)
> > +{
> > +	int rc;
> > +	struct fwnode_handle *fn;
> > +	struct acpi_madt_rintc *rintc;
> > +
> > +	rintc = (struct acpi_madt_rintc *)header;
> > +
> > +	/*
> > +	 * The ACPI MADT will have one INTC for each CPU (or HART)
> > +	 * so riscv_intc_acpi_init() function will be called once
> > +	 * for each INTC. We only need to do INTC initialization
> > +	 * for the INTC belonging to the boot CPU (or boot HART).
> > +	 */
> > +	if (riscv_hartid_to_cpuid(rintc->hart_id) != smp_processor_id())
> > +		return 0;
> > +
> > +	fn = irq_domain_alloc_named_fwnode("RISCV-INTC");
> > +	WARN_ON(fn == NULL);
> 
> Is there a reason that you do not just check this as !fn?
> 
> > +	if (!fn) {
> 
> This is a repeated check from the WARN_ON(), no?
> 
> > +		pr_err("unable to allocate INTC FW node\n");
> 
> Why do you need a WARN_ON() & the pr_err() here?
> 
You are right. Will remove the WARN_ON.

> > +		return -1;
> 
> Why not an actual ERRNO?
>
Okay. 

Thanks,
Sunil
