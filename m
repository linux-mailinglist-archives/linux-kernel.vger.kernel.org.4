Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B07C5F58D0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 19:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbiJERHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 13:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiJERHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 13:07:06 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E28863F01
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 10:07:05 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id w10so10977300edd.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 10:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=h8FHBoVsbaxbLl/+Sb8V0zp1dy58bBaAUxOIDo7PJTM=;
        b=DvFebTmJb8iAlZ3noYHSzoKIniXMa0t30LHlrIoPdYfrTEbtlVWDx9FXsfnrIOsLpB
         8wiIFs/aQNFsuMndfNKJEF1uQ7BPiAMg3tXhZgxrOuDEK4RNRgcFkK+wXLApJK9N+S/U
         aznhGd/GmUk9j+EEzGcjoj8bwbJToT2mm0PEOJfR8wVyUoUcpnjsMv6nhXqfxocXYMu+
         Uyanwp5Rhzk9zV8Lr+Gv8aEFE4liHWxLDc2PrIpEYKF+f4AKLGNvU5Si+k7om8Xl2OoE
         0Rp6nabt4D2Hu16xgTzLryyPb/wNdPAN916xkAzpdBRQXv/tQ2mPl+E3DR0tljA1YBl7
         d09A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=h8FHBoVsbaxbLl/+Sb8V0zp1dy58bBaAUxOIDo7PJTM=;
        b=3LTULK8HxKukgj/uRgprGVeGAMj3+/we8dAEI7lFpCWVodRr2yTtCzeM4LttDvwZ3W
         Lp4R+kETK1B+1xx7tTgfxG4aUJCq3ccN8J3AjYWF1+N+bv2uuRYMu1HCsG7TCt3chhxh
         lEUx+scaeBH2bUrtF0MXc571yMEY+SZVA3xmNAyqK1Shk0wKpLqfS4X8baYgT6IDXrq4
         RqRtby2uqLK8w6Bw7KGZVyo1gKbMGAhhNu+FKLJdxfcz3nGI6Owfn2+yQo7CmXhaX7VF
         l+cAfXbutgSSOmJn3gLU/FzaNZKNYigTZf6sIilwvwMyshE153FKRviGrb89hCG7grbP
         kWyQ==
X-Gm-Message-State: ACrzQf2qJf/LQ2O6cfODTjQDH4QdohhsZbGQhBXNu4S/TLG7FL6S7mDa
        7OzS6lhpLcn9njAiAL1HGXP5Vg==
X-Google-Smtp-Source: AMsMyM76Ph31LFWOjl2u+0iEWUe9sg37rv6FveiR8m6uaXcdYZJ7IJNyKG+ftg+wKQ6QY5MDaUExCQ==
X-Received: by 2002:a05:6402:1e96:b0:459:68bb:867 with SMTP id f22-20020a0564021e9600b0045968bb0867mr683282edf.45.1664989624046;
        Wed, 05 Oct 2022 10:07:04 -0700 (PDT)
Received: from localhost (cst2-173-61.cust.vodafone.cz. [31.30.173.61])
        by smtp.gmail.com with ESMTPSA id lb9-20020a170907784900b007815c3e95f6sm9072173ejc.146.2022.10.05.10.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 10:07:03 -0700 (PDT)
Date:   Wed, 5 Oct 2022 19:07:02 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     atishp@atishpatra.org, anup@brainfault.org, will@kernel.org,
        mark.rutland@arm.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Conor.Dooley@microchip.com,
        cmuellner@linux.com, samuel@sholland.org
Subject: Re: [PATCH 1/2] RISC-V: Cache SBI vendor values
Message-ID: <20221005170702.bsvjssvau6yv47ku@kamzik>
References: <20221004203724.1459763-1-heiko@sntech.de>
 <20221004203724.1459763-2-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221004203724.1459763-2-heiko@sntech.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 04, 2022 at 10:37:23PM +0200, Heiko Stuebner wrote:
> sbi_get_mvendorid(), sbi_get_marchid() and sbi_get_mimpid() might get
> called multiple times, though the values of these CSRs should not change
> during the runtime of a specific machine.
> 
> So cache the values in the functions and prevent multiple ecalls
> to read these values.
> 
> Suggested-by: Atish Patra <atishp@atishpatra.org>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  arch/riscv/kernel/sbi.c | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
> index 775d3322b422..5be8f90f325e 100644
> --- a/arch/riscv/kernel/sbi.c
> +++ b/arch/riscv/kernel/sbi.c
> @@ -625,17 +625,32 @@ static inline long sbi_get_firmware_version(void)
>  
>  long sbi_get_mvendorid(void)
>  {
> -	return __sbi_base_ecall(SBI_EXT_BASE_GET_MVENDORID);
> +	static long id = -1;
> +
> +	if (id < 0)
> +		id = __sbi_base_ecall(SBI_EXT_BASE_GET_MVENDORID);
> +
> +	return id;
>  }
>  
>  long sbi_get_marchid(void)
>  {
> -	return __sbi_base_ecall(SBI_EXT_BASE_GET_MARCHID);
> +	static long id = -1;
> +
> +	if (id < 0)
> +		id = __sbi_base_ecall(SBI_EXT_BASE_GET_MARCHID);

The marchid register will be negative for commercial architecture ids
because the MSB must be set.

> +
> +	return id;
>  }
>  
>  long sbi_get_mimpid(void)
>  {
> -	return __sbi_base_ecall(SBI_EXT_BASE_GET_MIMPID);
> +	static long id = -1;
> +
> +	if (id < 0)
> +		id = __sbi_base_ecall(SBI_EXT_BASE_GET_MIMPID);

The spec says this register is "left to the provider" and may be
left-justified. I don't think we can be sure the MSB will not be set.

For both cases I guess we need an extra bit to determine if we've cached
or not

  static bool cached;
  static long id;

  if (!cached) {
     id = ecall();
     cached = true;
  }

  return id;

> +
> +	return id;
>  }
>  
>  static void sbi_send_cpumask_ipi(const struct cpumask *target)
> -- 
> 2.35.1
> 

Thanks,
drew
