Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37DF0631ED0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 11:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbiKUKxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 05:53:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiKUKxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 05:53:36 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F52C756
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 02:53:35 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id i10so27549839ejg.6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 02:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dIXltM9CwIEJBW31n6qcOnoQuAF0SYx/10yh0pflqpw=;
        b=A54emkiJ8d6mOzX4CHxA7liwacxc6I+kXhc8muuDfztTsk5k1uMLeT9qmRHKHj7sAS
         68Z9FCGJJnhe4rKCXyw4A3k9UegtNH0fo6wV4/aZDoKa+PnwIzU9gXuwmryHp5I9+OPm
         0v6yDSf82LOR5TncBiHERECtXv5zjVEMnqoNRkM9TXaHpE3MVOqo1O2cSHqjkXyCWXQw
         JtpH+AcHcP0rv1HdeWHHaaXzzHIIr9oVjxoAENs086nIwSA8823hsjlPG1OHCVO5cPXV
         cJ/6KQezs19JNBcUSBL7fn9xb3IdEetBQm1zZwA+Sdyxu+2grADwX/Px4Kc6AlNgo58N
         Gqug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dIXltM9CwIEJBW31n6qcOnoQuAF0SYx/10yh0pflqpw=;
        b=qBHOT9Jg0j4tK1LF7KwNgWkZHwxahBl5E2mH921+04QblxQ59NXvk2SU2q4RyW9duv
         KaICakAVUUc+JFDNuSlayVXHqfwvMLg3xLl2K+gbQU3MhDE7aDxd1hRsz9s/6zGFwZP1
         hDxP61XzEewc22f0MQTNo96qqAGfxmsRNNALfiqG5cCj1JVJpilk3gD2TW9827YQYOYD
         wQ4NDTItBvJB7SoE50DFDpM2YJIcSbq2yBw9ej+DwnqHGB+g/UBMt8qc/p9g5/koA7jb
         cGODQDLG1Uv0JVFa50w4ew4nxsZtXkKql/ZQZu0PC84dxX4TlwxkYKN3eT6pqwpMpHb1
         vJqw==
X-Gm-Message-State: ANoB5pkBxswyCb07JzOJMxV3TQAzpIoZgfZ3nsnLKTtc12oAibtISUWQ
        owPe7SWitm6tfow7y2OJ8lViiQ==
X-Google-Smtp-Source: AA0mqf6dWp3Wpc0Ov+iHZfb7e76FT+vzBR/MkIgZsC+2m3i5woHAUQ20TzzBrzWK50sy5/WbjwaUjw==
X-Received: by 2002:a17:906:1495:b0:7ad:d250:b904 with SMTP id x21-20020a170906149500b007add250b904mr14898663ejc.633.1669028014848;
        Mon, 21 Nov 2022 02:53:34 -0800 (PST)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id u9-20020a1709061da900b0074136cac2e7sm1716343ejh.81.2022.11.21.02.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 02:53:34 -0800 (PST)
Date:   Mon, 21 Nov 2022 11:53:33 +0100
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Chen Lifu <chenlifu@huawei.com>
Cc:     anup@brainfault.org, atishp@atishpatra.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] RISC-V: KVM: optimize kvm_arch_hardware_enable()
Message-ID: <20221121105333.rap67cpmst3odiid@kamzik>
References: <20221121003915.2817102-1-chenlifu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221121003915.2817102-1-chenlifu@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 08:39:15AM +0800, Chen Lifu wrote:
> The values of CSR_HEDELEG and CSR_HIDELEG registers are constants,
> so change them from variables to macros.
> 
> Signed-off-by: Chen Lifu <chenlifu@huawei.com>
> ---
>  arch/riscv/kvm/main.c | 31 +++++++++++++------------------
>  1 file changed, 13 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/riscv/kvm/main.c b/arch/riscv/kvm/main.c
> index df2d8716851f..70196b03b6f9 100644
> --- a/arch/riscv/kvm/main.c
> +++ b/arch/riscv/kvm/main.c
> @@ -12,10 +12,21 @@
>  #include <linux/kvm_host.h>
>  #include <asm/csr.h>
>  #include <asm/hwcap.h>
>  #include <asm/sbi.h>
>  
> +#define EXC_HEDELEG ((1UL << EXC_INST_MISALIGNED) | \
> +		     (1UL << EXC_BREAKPOINT)      | \
> +		     (1UL << EXC_SYSCALL)         | \
> +		     (1UL << EXC_INST_PAGE_FAULT) | \
> +		     (1UL << EXC_LOAD_PAGE_FAULT) | \
> +		     (1UL << EXC_STORE_PAGE_FAULT))
> +
> +#define IRQ_HIDELEG ((1UL << IRQ_VS_SOFT)  | \
> +		     (1UL << IRQ_VS_TIMER) | \
> +		     (1UL << IRQ_VS_EXT))
> +
>  long kvm_arch_dev_ioctl(struct file *filp,
>  			unsigned int ioctl, unsigned long arg)
>  {
>  	return -EINVAL;
>  }
> @@ -30,29 +41,13 @@ int kvm_arch_hardware_setup(void *opaque)
>  	return 0;
>  }
>  
>  int kvm_arch_hardware_enable(void)
>  {
> -	unsigned long hideleg, hedeleg;
> -
> -	hedeleg = 0;
> -	hedeleg |= (1UL << EXC_INST_MISALIGNED);
> -	hedeleg |= (1UL << EXC_BREAKPOINT);
> -	hedeleg |= (1UL << EXC_SYSCALL);
> -	hedeleg |= (1UL << EXC_INST_PAGE_FAULT);
> -	hedeleg |= (1UL << EXC_LOAD_PAGE_FAULT);
> -	hedeleg |= (1UL << EXC_STORE_PAGE_FAULT);
> -	csr_write(CSR_HEDELEG, hedeleg);
> -
> -	hideleg = 0;
> -	hideleg |= (1UL << IRQ_VS_SOFT);
> -	hideleg |= (1UL << IRQ_VS_TIMER);
> -	hideleg |= (1UL << IRQ_VS_EXT);
> -	csr_write(CSR_HIDELEG, hideleg);
> -
> +	csr_write(CSR_HEDELEG, EXC_HEDELEG);
> +	csr_write(CSR_HIDELEG, IRQ_HIDELEG);
>  	csr_write(CSR_HCOUNTEREN, -1UL);
> -
>  	csr_write(CSR_HVIP, 0);
>  
>  	return 0;
>  }
>  
> -- 
> 2.37.1
>

I don't think this optimizes anything. I'm pretty sure the compiler will
load the input to csr_write() in the most efficient way it can, regardless
of using a constant or building the input out of constants. This could
maybe be considered a code cleanup, but, in this case, it's really in the
eye of the beholder.

Thanks,
drew
