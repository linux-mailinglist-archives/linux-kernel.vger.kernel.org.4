Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9266A74E93E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 10:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbjGKIi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 04:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbjGKIiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 04:38:55 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE3ACA
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 01:38:53 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3159da54e95so1646157f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 01:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1689064732; x=1691656732;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wlgprI0JyP56APEsHhB8r5x7x5aPnleu5dukyGgRaIw=;
        b=ELZVM/RMZqGcLMCnJd6woEA+W6+CZ8oFFs/q4MGTbqlL46t7/ONJ6KRSIYvICaT0yc
         WFsbblZeo4WpgLdBoR3iYN0YmvXVT8pxk9ZaKtc0nUWanUCozQ3mgvW6tlbzhwiGVyEZ
         jbQHfYykumlfPPfYn+UlLENuldS4ldunwC2kHMKTJyrw0d9QGqsoekDkDWXTVQcE7cYy
         ZN4MqjupdVMAyYPyQcE6yRSUgGMPvHGS9V331CSzlaOl72DmGZfUV2jM+RL7Ou2uOAMl
         JVQbRMWTJYBHbGOFTHVEqip2r51EEED2XwDw2h3fRoMpuD5E54uQ/bR4b0SWzTjZiYJ+
         2s/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689064732; x=1691656732;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wlgprI0JyP56APEsHhB8r5x7x5aPnleu5dukyGgRaIw=;
        b=iFuIxqNsABomFayuVZpI9Oj0rilGNjsmn/ZDmf3MbG/f+icY81y6rOTXY3xSJcI2gY
         CJifIbV4UOBtEo1fGkqguVqpRdMFAkYybbrNKIDAH4UtsezxmnKrbbCsXM1gxR5JE4BJ
         Fr9Mq1i6hs5Thi+36E7T07IvnDk6V17eUCqA0U3HBj0uReRuJd8kZjIpKeW7zGtbzBzy
         R0ZfeNN4iRHNAfXOGWk3Rbn93V40YGsE5M80BNAELYYqehwFxF4kfh+EqTHkftO2RqR2
         mKhsEsr700/v5gLJN4VSkuRAkho8XrJJgBxuSv5nzotlCqNNw4VJByUF59K+FahPzWIg
         C+6g==
X-Gm-Message-State: ABy/qLaDGn6w7ZZKWxBYSvU1RqOXEiPJSHR6qAZf5ydBDZXr2riL/xdJ
        2XtxL0ClV+mt6AHLpnedBEvEXA==
X-Google-Smtp-Source: APBJJlHrYEg6YkvG3Eo4/aBAI5g7mqzkqBM/03YwAmExsZBveWNTNvGmYLZDkcJhQK7mr48DCYNSbw==
X-Received: by 2002:a5d:4284:0:b0:314:ac1:d12a with SMTP id k4-20020a5d4284000000b003140ac1d12amr15655301wrq.26.1689064732218;
        Tue, 11 Jul 2023 01:38:52 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id n8-20020a5d6b88000000b003141e9e2f81sm1641924wrx.4.2023.07.11.01.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 01:38:51 -0700 (PDT)
Date:   Tue, 11 Jul 2023 10:38:51 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Evan Green <evan@rivosinc.com>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <apatel@ventanamicro.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Jonathan Corbet <corbet@lwn.net>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3] RISC-V: Show accurate per-hart isa in /proc/cpuinfo
Message-ID: <20230711-d4ca408bba1621c56c3f166b@orel>
References: <20230710192413.2089085-1-evan@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710192413.2089085-1-evan@rivosinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 12:24:13PM -0700, Evan Green wrote:
> In /proc/cpuinfo, most of the information we show for each processor is
> specific to that hart: marchid, mvendorid, mimpid, processor, hart,
> compatible, and the mmu size. But the ISA string gets filtered through a
> lowest common denominator mask, so that if one CPU is missing an ISA
> extension, no CPUs will show it.
> 
> Now that we track the ISA extensions for each hart, let's report ISA
> extension info accurately per-hart in /proc/cpuinfo. We cannot change
> the "isa:" line, as usermode may be relying on that line to show only
> the common set of extensions supported across all harts. Add a new "hart
> isa" line instead, which reports the true set of extensions for that
> hart. This matches what is returned in riscv_hwprobe() when querying a
> given hart.
> 
> Signed-off-by: Evan Green <evan@rivosinc.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> 
> ---
> 
> Changes in v3:
>  - Add some documentation (Conor)
> 
> Changes in v2:
>  - Added new "hart isa" line rather than altering behavior of existing
>    "isa" line (Conor, Palmer)
> 
> 
> I based this series on top of Conor's riscv-extensions-strings branch
> from July 3rd, since otherwise this change gets hopelessly entangled
> with that series.
> 
> ---
>  Documentation/riscv/uabi.rst | 10 ++++++++++
>  arch/riscv/kernel/cpu.c      | 22 ++++++++++++++++++----
>  2 files changed, 28 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/riscv/uabi.rst b/Documentation/riscv/uabi.rst
> index 8960fac42c40..4f462f5b168c 100644
> --- a/Documentation/riscv/uabi.rst
> +++ b/Documentation/riscv/uabi.rst
> @@ -42,6 +42,16 @@ An example string following the order is::
>  
>     rv64imadc_zifoo_zigoo_zafoo_sbar_scar_zxmbaz_xqux_xrux
>  
> +"isa" vs "hart isa" lines in /proc/cpuinfo
> +-----------------------------------------
> +
> +The "isa" line in /proc/cpuinfo describes the lowest common denominator of
> +RISC-V ISA extensions understood by the kernel and implemented on all harts. The
> +"hart isa" line, in contrast, describes the set of extensions understood by the
> +kernel on the particular hart in question, even if those extensions may not be

Maybe

...understood by the kernel for the specific hart associated with the
"hart isa" line, even if...

That's much wordier than "in question", but "in question" didn't ring well
with me. Anyway, just food for thought, feel free to ignore.

Thanks,
drew


> +present on all harts in the system. The "hart isa" line is consistent with
> +what's returned by __riscv_hwprobe() when querying for that specific CPU.
> +
>  Misaligned accesses
>  -------------------
>  
> diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> index 1acf3679600d..6264b7b94945 100644
> --- a/arch/riscv/kernel/cpu.c
> +++ b/arch/riscv/kernel/cpu.c
> @@ -197,9 +197,8 @@ arch_initcall(riscv_cpuinfo_init);
>  
>  #ifdef CONFIG_PROC_FS
>  
> -static void print_isa(struct seq_file *f)
> +static void print_isa(struct seq_file *f, const unsigned long *isa_bitmap)
>  {
> -	seq_puts(f, "isa\t\t: ");
>  
>  	if (IS_ENABLED(CONFIG_32BIT))
>  		seq_write(f, "rv32", 4);
> @@ -207,7 +206,7 @@ static void print_isa(struct seq_file *f)
>  		seq_write(f, "rv64", 4);
>  
>  	for (int i = 0; i < riscv_isa_ext_count; i++) {
> -		if (!__riscv_isa_extension_available(NULL, riscv_isa_ext[i].id))
> +		if (!__riscv_isa_extension_available(isa_bitmap, riscv_isa_ext[i].id))
>  			continue;
>  
>  		/* Only multi-letter extensions are split by underscores */
> @@ -271,7 +270,15 @@ static int c_show(struct seq_file *m, void *v)
>  
>  	seq_printf(m, "processor\t: %lu\n", cpu_id);
>  	seq_printf(m, "hart\t\t: %lu\n", cpuid_to_hartid_map(cpu_id));
> -	print_isa(m);
> +
> +	/*
> +	 * For historical raisins, the isa: line is limited to the lowest common
> +	 * denominator of extensions supported across all harts. A true list of
> +	 * extensions supported on this hart is printed later in the hart_isa:
> +	 * line.
> +	 */
> +	seq_puts(m, "isa\t\t: ");
> +	print_isa(m, NULL);
>  	print_mmu(m);
>  
>  	if (acpi_disabled) {
> @@ -287,6 +294,13 @@ static int c_show(struct seq_file *m, void *v)
>  	seq_printf(m, "mvendorid\t: 0x%lx\n", ci->mvendorid);
>  	seq_printf(m, "marchid\t\t: 0x%lx\n", ci->marchid);
>  	seq_printf(m, "mimpid\t\t: 0x%lx\n", ci->mimpid);
> +
> +	/*
> +	 * Print the ISA extensions specific to this hart, which may show
> +	 * additional extensions not present across all harts.
> +	 */
> +	seq_puts(m, "hart isa\t: ");
> +	print_isa(m, hart_isa[cpu_id].isa);
>  	seq_puts(m, "\n");
>  
>  	return 0;
> -- 
> 2.34.1
> 
