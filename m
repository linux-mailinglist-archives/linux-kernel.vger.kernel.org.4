Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14C1B632D8D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 20:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbiKUT75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 14:59:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbiKUT74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 14:59:56 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D6A4385A
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 11:59:54 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id a29so20383953lfj.9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 11:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GSLg3lnlnQB1hP6JwVcBXUauPug+4FyuOo+oBexYadI=;
        b=Kk3GxXmPIvdzM6UsD2FitntVNHVBbwxpLrNVpPWxak/p00HCqWN+Lt4/xZ3Ztihhei
         UyO1MG2KuzYDgBBi/lBG8VjFOQW88dQbKu+QF/7mBmXvuovQk+dROY1mc2X9Oh12/JD9
         XU/gqQWmZXdsFf9UbZP3Yt5TmD99KyaDJRg178vIebxQAnAxLpd5tXIyrUTcV5qODl8o
         ndjpcGChExJKvne+P9T0Sx5p75qw+QJyvYWEXkRRZTR4MjcgmgCAw0GogABcKJ5bo+B0
         GnVozVDbWeph/Xvh5SIHFJxji2+prAXDUmPsMvHKpzx8H02rRriNAvIAiKLpnjxocyuR
         yWKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GSLg3lnlnQB1hP6JwVcBXUauPug+4FyuOo+oBexYadI=;
        b=lWB9SjkoJrZGFqWxY1QgmL9F9cAcFWAXe/uMpNAca5J0VWV0UGwEyh9WzKOiRRcIuH
         zAt/HfM2Oq32DFEyppGeTfPqLEtoacI0NL2YCghvPmcAiEzo0Ty8PFc/yhlop1rX2L2w
         zTY2DW1b0HK/RGcolXIM9HO/EUFn86BPmThZAV0bO2Qg8aOeNbrkfNRZ+OhNvL7MPkW4
         2ZhgFFdbTYJuuUtuLnfhbVBg8B5lHjt8GoyJfIJm4aoDHur2a/7/E81HRKl1UIOviKFM
         Zqw46sPI+MNT5BC51S3VMwk3P4stIiSCOP/angTKZ06x8lLchpZwRNKiftiTaa5tdej4
         1Pdw==
X-Gm-Message-State: ANoB5pm6LcuvRyQpd5OVOpWB5/+zTeNZG2l7ms5UdF2mYWo1dwn68oE5
        g5jNhuoo1HGot6j27yMrF98=
X-Google-Smtp-Source: AA0mqf614JoCXiwhlXfpZPATW4kb+3f4M4d4pYgxugmAgR7pbvKpon7OmkDr+g3KCOiv15Z1E2ZrEw==
X-Received: by 2002:ac2:52b6:0:b0:4a8:df88:f4d2 with SMTP id r22-20020ac252b6000000b004a8df88f4d2mr6282701lfm.463.1669060792940;
        Mon, 21 Nov 2022 11:59:52 -0800 (PST)
Received: from curiosity ([5.188.167.245])
        by smtp.gmail.com with ESMTPSA id be40-20020a056512252800b00497a61453a9sm2162437lfb.243.2022.11.21.11.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 11:59:51 -0800 (PST)
Date:   Mon, 21 Nov 2022 22:59:50 +0300
From:   Sergey Matyukevich <geomatsi@gmail.com>
To:     guoren@kernel.org
Cc:     anup@brainfault.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        conor.dooley@microchip.com, heiko@sntech.de,
        philipp.tomsich@vrull.eu, alex@ghiti.fr, hch@lst.de,
        ajones@ventanamicro.com, gary@garyguo.net, jszhang@kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: Re: [PATCH V3] riscv: asid: Fixup stale TLB entry cause application
 crash
Message-ID: <Y3vYtobn72sqA2Tq@curiosity>
References: <20221111075902.798571-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111075902.798571-1-guoren@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> After use_asid_allocator is enabled, the userspace application will
> crash by stale TLB entries. Because only using cpumask_clear_cpu without
> local_flush_tlb_all couldn't guarantee CPU's TLB entries were fresh.
> Then set_mm_asid would cause the user space application to get a stale
> value by stale TLB entry, but set_mm_noasid is okay.
> 
> Here is the symptom of the bug:
> unhandled signal 11 code 0x1 (coredump)
>    0x0000003fd6d22524 <+4>:     auipc   s0,0x70
>    0x0000003fd6d22528 <+8>:     ld      s0,-148(s0) # 0x3fd6d92490
> => 0x0000003fd6d2252c <+12>:    ld      a5,0(s0)
> (gdb) i r s0
> s0          0x8082ed1cc3198b21       0x8082ed1cc3198b21
> (gdb) x /2x 0x3fd6d92490
> 0x3fd6d92490:   0xd80ac8a8      0x0000003f
> The core dump file shows that register s0 is wrong, but the value in
> memory is correct. Because 'ld s0, -148(s0)' used a stale mapping entry
> in TLB and got a wrong result from an incorrect physical address.
> 
> When the task ran on CPU0, which loaded/speculative-loaded the value of
> address(0x3fd6d92490), then the first version of the mapping entry was
> PTWed into CPU0's TLB.
> When the task switched from CPU0 to CPU1 (No local_tlb_flush_all here by
> asid), it happened to write a value on the address (0x3fd6d92490). It
> caused do_page_fault -> wp_page_copy -> ptep_clear_flush ->
> ptep_get_and_clear & flush_tlb_page.
> The flush_tlb_page used mm_cpumask(mm) to determine which CPUs need TLB
> flush, but CPU0 had cleared the CPU0's mm_cpumask in the previous
> switch_mm. So we only flushed the CPU1 TLB and set the second version
> mapping of the PTE. When the task switched from CPU1 to CPU0 again, CPU0
> still used a stale TLB mapping entry which contained a wrong target
> physical address. It raised a bug when the task happened to read that
> value.
> 
>    CPU0                               CPU1
>    - switch 'task' in
>    - read addr (Fill stale mapping
>      entry into TLB)
>    - switch 'task' out (no tlb_flush)
>                                       - switch 'task' in (no tlb_flush)
>                                       - write addr cause pagefault
>                                         do_page_fault() (change to
>                                         new addr mapping)
>                                           wp_page_copy()
>                                             ptep_clear_flush()
>                                               ptep_get_and_clear()
>                                               & flush_tlb_page()
>                                         write new value into addr
>                                       - switch 'task' out (no tlb_flush)
>    - switch 'task' in (no tlb_flush)
>    - read addr again (Use stale
>      mapping entry in TLB)
>      get wrong value from old phyical
>      addr, BUG!
> 
> The solution is to keep all CPUs' footmarks of cpumask(mm) in switch_mm,
> which could guarantee to invalidate all stale TLB entries during TLB
> flush.
> 
> Fixes: 65d4b9c53017 ("RISC-V: Implement ASID allocator")
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> Cc: Anup Patel <apatel@ventanamicro.com>
> Cc: Palmer Dabbelt <palmer@rivosinc.com>
> ---
> Changes in v3:
>  - Move set/clear cpumask(mm) into set_mm (Make code more pretty
>    with Andrew's advice)
>  - Optimize comment description
> 
> Changes in v2:
>  - Fixup nommu compile problem (Thx Conor, Also Reported-by: kernel
>    test robot <lkp@intel.com>)
>  - Keep cpumask_clear_cpu for noasid
> ---
>  arch/riscv/mm/context.c | 30 ++++++++++++++++++++----------
>  1 file changed, 20 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
> index 7acbfbd14557..0f784e3d307b 100644
> --- a/arch/riscv/mm/context.c
> +++ b/arch/riscv/mm/context.c
> @@ -205,12 +205,24 @@ static void set_mm_noasid(struct mm_struct *mm)
>  	local_flush_tlb_all();
>  }
>  
> -static inline void set_mm(struct mm_struct *mm, unsigned int cpu)
> +static inline void set_mm(struct mm_struct *prev,
> +			  struct mm_struct *next, unsigned int cpu)
>  {
> -	if (static_branch_unlikely(&use_asid_allocator))
> -		set_mm_asid(mm, cpu);
> -	else
> -		set_mm_noasid(mm);
> +	/*
> +	 * The mm_cpumask indicates which harts' TLBs contain the virtual
> +	 * address mapping of the mm. Compared to noasid, using asid
> +	 * can't guarantee that stale TLB entries are invalidated because
> +	 * the asid mechanism wouldn't flush TLB for every switch_mm for
> +	 * performance. So when using asid, keep all CPUs footmarks in
> +	 * cpumask() until mm reset.
> +	 */
> +	cpumask_set_cpu(cpu, mm_cpumask(next));
> +	if (static_branch_unlikely(&use_asid_allocator)) {
> +		set_mm_asid(next, cpu);
> +	} else {
> +		cpumask_clear_cpu(cpu, mm_cpumask(prev));
> +		set_mm_noasid(next);
> +	}
>  }
>  
>  static int __init asids_init(void)
> @@ -264,7 +276,8 @@ static int __init asids_init(void)
>  }
>  early_initcall(asids_init);
>  #else
> -static inline void set_mm(struct mm_struct *mm, unsigned int cpu)
> +static inline void set_mm(struct mm_struct *prev,
> +			  struct mm_struct *next, unsigned int cpu)
>  {
>  	/* Nothing to do here when there is no MMU */
>  }
> @@ -317,10 +330,7 @@ void switch_mm(struct mm_struct *prev, struct mm_struct *next,
>  	 */
>  	cpu = smp_processor_id();
>  
> -	cpumask_clear_cpu(cpu, mm_cpumask(prev));
> -	cpumask_set_cpu(cpu, mm_cpumask(next));
> -
> -	set_mm(next, cpu);
> +	set_mm(prev, next, cpu);
>  
>  	flush_icache_deferred(next, cpu);
>  }

Tested-by: Sergey Matyukevich <sergey.matyukevich@syntacore.com>

Thanks,
Sergey
