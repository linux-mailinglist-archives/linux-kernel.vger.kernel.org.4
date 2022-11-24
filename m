Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E31E63768A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 11:33:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbiKXKdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 05:33:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiKXKdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 05:33:00 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B55F88F85
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 02:32:58 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id s5so1922330edc.12
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 02:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/Fwv0fBaAtUGyjSvz8Eubu4WI6tfxvAGSEBjrtHfM94=;
        b=R+veBmryJx4bjvNU4yQpLYI4xOGK5WSei4TFOGSsJ6CxLP27d+kxKBz3iUR9fA4IxX
         SMnZEu7CLp3KwyXQKgWs+zSP6Ch9iM8GB3nikg+wvH3zL8+5+RqnJaFIDM5q50FmmaWy
         WBi/got/nDXWVhECiF7GU3BYildUNLZmiZMQvsZmXcGs1F307/YNgKlHzUwMT7MwlsNa
         CIgjFYBTVRnp91Om5Kurv7dmm1BT1yENpGc100kF7xxVMpQ22cfQnt0FEqv/FssI/6mC
         Pz1lRORynIO5fCYwPKJ0BHL+uKSV/zZRLrShQdE7QZ05s+dJ1O/1uA7moSbqYz0jMZKx
         hPJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Fwv0fBaAtUGyjSvz8Eubu4WI6tfxvAGSEBjrtHfM94=;
        b=k5697yXGPuiziu7C7gDh5WJx3l2JUAcOCCrLks+NflC6ZF99SniGrYlzk+RJISqtJO
         WZRem0e5CA+UVi79ibu/Fx1gTsBtBYTOno+QzEACnOXZkQ68hOz2Xr0TdFMHAQc6//nD
         HOOV200Hg9dUD9Iq2OfiIi9rjjelyJ9Vb5N4egJpyFTfurSm62y8/DKtiYQlqO2rYn+G
         xOVssgrcU7PlK/PjTSNMK1Va9FF5gVl2s8Rj3R7VD0SSC5A0BbMdeV0/qnxxUJiWL1GJ
         DYCEGYBLJjNNAbe9HMQhj8ukY3BtW2pIvBgM7xxTIRq9iVGOKQBP1nsEncoOd0Wm1Nvs
         v0tw==
X-Gm-Message-State: ANoB5pmd1jnU592iiHZddEob4n9ffwK5EBarWyXgUnQlLZcOayfCbv1s
        YKuv2F25eRkOqBXSdrdoZdz9Bg==
X-Google-Smtp-Source: AA0mqf6l3YnM1QkmkvtGrkaGbUvKvN03fiMpWHkPotubU8vmj+xb1xgCJEkB80pFtKPXCbX1K3IyGA==
X-Received: by 2002:a05:6402:1f03:b0:468:7be6:55e7 with SMTP id b3-20020a0564021f0300b004687be655e7mr29511275edb.345.1669285976903;
        Thu, 24 Nov 2022 02:32:56 -0800 (PST)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id 18-20020a170906201200b0077f20a722dfsm266341ejo.165.2022.11.24.02.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 02:32:56 -0800 (PST)
Date:   Thu, 24 Nov 2022 11:32:55 +0100
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] riscv: vdso: remove hardcoded 0x800 .text section
 start addr
Message-ID: <20221124103255.33prhf3gf6xtwlsk@kamzik>
References: <20221123161805.1579-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221123161805.1579-1-jszhang@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 24, 2022 at 12:18:05AM +0800, Jisheng Zhang wrote:
> It seems the hardcoded 0x800 isn't necessary, but removing it brings a

s/, but/and/

> small vdso.so and aligns with other architectures.

This commit message didn't really satisfy my desire to understand why
the comment and '. = 0x800' were there in the first place and if its safe
to remove now, so I tried to do some of my own digging. I found

commit 5b9304933730 ("x86 vDSO: generate vdso-syms.lds")
commit f6b46ebf904f ("x86 vDSO: new layout")

which removes the comment and hard coding for x86 by changing the vdso
Makefile. Then looking at

commit 9031fefde6f2 ("arm64: VDSO support")

we see that it starts with the new Makefile approach and doesn't bother
with the hard coding from the start. As riscv also started with the new
Makefile approach it also could have dropped the hard coding from the
start (I guess).

> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  arch/riscv/kernel/vdso/vdso.lds.S | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/arch/riscv/kernel/vdso/vdso.lds.S b/arch/riscv/kernel/vdso/vdso.lds.S
> index 150b1a572e61..7be7e618d59c 100644
> --- a/arch/riscv/kernel/vdso/vdso.lds.S
> +++ b/arch/riscv/kernel/vdso/vdso.lds.S
> @@ -31,13 +31,7 @@ SECTIONS
>  
>  	.rodata		: { *(.rodata .rodata.* .gnu.linkonce.r.*) }
>  
> -	/*
> -	 * This linker script is used both with -r and with -shared.
> -	 * For the layouts to match, we need to skip more than enough
> -	 * space for the dynamic symbol table, etc. If this amount is
> -	 * insufficient, ld -shared will error; simply increase it here.
> -	 */
> -	. = 0x800;
> +	. = ALIGN(4);

I realize 4 is used here now because I questioned the 16, but after doing
my digging I think a larger alignment may be better. Loading the text may
be done with 8 byte or larger reads, so having the section aligned to a
larger size would be better reading it. We might as well use 16, like
arm64 does, and like you had before?

Also, having enough separation between data and text seems to be
important for cache reasons, based on the comment in
./arch/x86/entry/vdso/vdso-layout.lds.S and other vdso history.
Maybe we should move .note, .eh_frame_hdr, and .eh_frame below
.rodata like x86 has it?

Thanks,
drew

>  	.text		: { *(.text .text.*) }		:text
>  
>  	.data		: {
> -- 
> 2.37.2
> 
