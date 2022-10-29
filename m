Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4BEF612210
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 11:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiJ2J4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 05:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiJ2J4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 05:56:13 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E0115A948
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 02:56:12 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id j15so9487407wrq.3
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 02:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hYbKJy82Ni1WaoAt3JW0zUHd/xH1wOyaSoMpg/ZR0OY=;
        b=bLhX/kZFyXVpmYfpxWl6HQgmppZ702qNue6v4l5Y0OSDVLLwaJRwSQp+xPzw8IzQAM
         sv88mhhgp6tWBB8xWomwR5TA4OBUf95xlP9libLLWsTDb3vFXqmWpb4Fj85Y60odWe/G
         beT1Q31mX2+S+nh7GniEbhwtR5C/Cfu3O04Pb8bjRMd32IZCzS9H3mkRtuMgxOfA0/Hg
         pPmnXcoYHtvF6740mQNwGW39Enk3PoEulh5+66sKHY26CvFNdMyeMB2p8khjZQxG9AJ2
         1ZVrSqq1RB25zGYB8eHskOqRVN4KYKyoVhUxulY0x50w9oihx7/7oawb9g2Xw+eW3y1R
         3ifg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hYbKJy82Ni1WaoAt3JW0zUHd/xH1wOyaSoMpg/ZR0OY=;
        b=xPxhFG9vUGjV//HyA2DF1caXyOacb02pW5r87JhVJFx50ZubnsC/KOTnl79mw7YdQS
         rVr9D/WXc6UCA70LI6KPfNh9gY0plOulKcYtJy9qWYZF4WWIimZMA24fnE6DH1nMCZnL
         P2JjcCnzbCprPattF0dC9VgxXbG/qa1k38XlGv/mohRLCPxDAeyOQM0zpnUoPC2lsIWz
         5yy+J82Z+Hy/pZO1cOMCcn+q9hb1tNeznD0gOV9R1e3ALFvgZYkD9q5zLlsH0MQLvXt0
         wLLcoLikyEF163x6yflCW+Y3SDBgO6PysQTSnck7Z1FYtY66FbgoVgROBkan2uUuWlp8
         l8rg==
X-Gm-Message-State: ACrzQf0k/RdopevZb9OYDnMgbP/i5w3o8+CRebrYmKv6WWzj58IC/AND
        TyBju3pd/vR8it4Qwh9bMc3jnA==
X-Google-Smtp-Source: AMsMyM5Ccre1kyxGZ+/+2ktSKgdZW715lhzzsFNX3RK0O1Aj3vYKinBl9M+grR87oRML0yCye+l3yA==
X-Received: by 2002:adf:a31c:0:b0:236:ba0d:246b with SMTP id c28-20020adfa31c000000b00236ba0d246bmr98769wrb.448.1667037371161;
        Sat, 29 Oct 2022 02:56:11 -0700 (PDT)
Received: from localhost (cst2-173-61.cust.vodafone.cz. [31.30.173.61])
        by smtp.gmail.com with ESMTPSA id i19-20020a05600c2d9300b003cf5e445f5dsm1145974wmg.25.2022.10.29.02.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Oct 2022 02:56:10 -0700 (PDT)
Date:   Sat, 29 Oct 2022 11:56:09 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] riscv: improve boot time isa extensions handling
Message-ID: <20221029095609.e4ymkbnk2hl3kxzc@kamzik>
References: <20221006070818.3616-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006070818.3616-1-jszhang@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2022 at 03:08:10PM +0800, Jisheng Zhang wrote:
> Generally, riscv ISA extensions are fixed for any specific hardware
> platform, that's to say, the hart features won't change any more
> after booting, this chacteristic make it straightforward to use
> static branch to check one specific ISA extension is supported or not
> to optimize performance.
> 
> However, some ISA extensions such as SVPBMT and ZICBOM are handled
> via. the alternative sequences.
> 
> Basically, for ease of maintenance, we prefer to use static branches
> in C code, but recently, Samuel found that the static branch usage in
> cpu_relax() breaks building with CONFIG_CC_OPTIMIZE_FOR_SIZE[1]. As
> Samuel pointed out, "Having a static branch in cpu_relax() is
> problematic because that function is widely inlined, including in some
> quite complex functions like in the VDSO. A quick measurement shows
> this static branch is responsible by itself for around 40% of the jump
> table."
> 
> Samuel's findings pointed out one of a few downsides of static branches
> usage in C code to handle ISA extensions detected at boot time:
> static branch's metadata in the __jump_table section, which is not
> discarded after ISA extensions are finalized, wastes some space.
> 
> I want to try to solve the issue for all possible dynamic handling of
> ISA extensions at boot time. Inspired by Mark[2], this patch introduces
> riscv_has_extension_*() helpers, which work like static branches but
> are patched using alternatives, thus the metadata can be freed after
> patching.
> 
> [1]https://lore.kernel.org/linux-riscv/20220922060958.44203-1-samuel@sholland.org/
> [2]https://lore.kernel.org/linux-arm-kernel/20220912162210.3626215-8-mark.rutland@arm.com/
> 
> 
> Jisheng Zhang (8):
>   riscv: move riscv_noncoherent_supported() out of ZICBOM probe
>   riscv: cpufeature: detect RISCV_ALTERNATIVES_EARLY_BOOT earlier
>   riscv: hwcap: make ISA extension ids can be used in asm
>   riscv: cpufeature: extend riscv_cpufeature_patch_func to all ISA
>     extensions
>   riscv: introduce riscv_has_extension_[un]likely()
>   riscv: fpu: switch has_fpu() to riscv_has_extension_likely()
>   riscv: cpu_relax: switch to riscv_has_extension_likely()
>   riscv: remove riscv_isa_ext_keys[] array and related usage
> 
>  arch/riscv/include/asm/errata_list.h    |  9 +--
>  arch/riscv/include/asm/hwcap.h          | 94 ++++++++++++++-----------
>  arch/riscv/include/asm/switch_to.h      |  3 +-
>  arch/riscv/include/asm/vdso/processor.h |  2 +-
>  arch/riscv/kernel/cpufeature.c          | 78 +++-----------------
>  arch/riscv/kernel/setup.c               |  4 ++
>  6 files changed, 71 insertions(+), 119 deletions(-)
> 
> -- 
> 2.37.2
>

Hi Jisheng,

I just tried building this with LLVM=1 and fails to compile with messages
like

 ld.lld: error: relocation R_RISCV_64 cannot be used against symbol '.Ltmp1'; recompile with -fPIC
 >>> defined in arch/riscv/kernel/vdso/vgettimeofday.o
 >>> referenced by vgettimeofday.c
 >>>               arch/riscv/kernel/vdso/vgettimeofday.o:(.alternative+0x0)

It does compile and boot with CC=clang and binutils 2.39, where my clang
version is 14.0.5 (Fedora 14.0.5-1.fc36).

Thanks,
drew
