Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 480EA70F830
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 16:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235707AbjEXOB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 10:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235696AbjEXOBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 10:01:55 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0395B18B
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 07:01:53 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-96fe88cd2fcso179289566b.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 07:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1684936911; x=1687528911;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GcnYDNNJKRDTvBz4U4x4piA3wZfgWR11rBlHqZISUZw=;
        b=cBRG8OIciHgkJG5NeGpDKgXBLwB/ZRieicor/6NiIG3NMQ1B/bIFDyoHjCsFWSj6Dh
         NYPSkHxVPzMFS6zrRvk8Vu4wSKDXgHIdsXNG7HnJKoV5jngMjC6m4+4Ejb8cwJUNzh+K
         h0sFoTKIuc9638A6aDq/12b39F8dap8vN6cb6grcVRU2GiUnjeB0guaTZmwOq50n7yOh
         J0q9yFNPRJi9f0Wa6yREWvws/Fx+13BXqhhFWliMovEX8xKUGyVmNEXP1E2hfNKuamPq
         7gEAJqSSubtg7vrG8Pbj6UFiCAAl6bxS9menFiATiRgE+bcmLH7U+40V3RlZcSfKzzU7
         QJ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684936911; x=1687528911;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GcnYDNNJKRDTvBz4U4x4piA3wZfgWR11rBlHqZISUZw=;
        b=CpSy4o9JmzN/lb4JoudAofcVkqk5RCzHeIoPM6SixcWNhnnW9cTnNBMTU6mABFyeCZ
         7BHyjdtyDhpciH4U9i8mOX6Y0jJH0s63dl3SGswKE/dWkh3vBv6MFUNGAI23MV7pfE/V
         8HdXOVka9ksBz2h2UjBlRImP/x0eZ8NUWzST2YYyfsmuyd7NTDIFMnW2M+Ytn8iSKm/t
         EmU6geLls1GPrrAmqjgGC7vcsQVYFPmKU64oMqEDGw7od/nqzLGuuB/yWXVGZQ93QLPi
         NdFtNyeztPAO1yFufQmdueIJk+PzrdTOr8RYGJMNFCwyBFP+HkGqwOuR45TgslyHuElt
         wHRA==
X-Gm-Message-State: AC+VfDz8p6hq1LzEeoPdB2M4bidte/d7KHCzvGFgYbICmbyFoIJBZIvz
        Qrt9cV4HOOqUCuZ7FTeE/g6ngkpfq+skFfKoQLU=
X-Google-Smtp-Source: ACHHUZ5LJ1RLFW3yyptH2uNq3JrXu9MBzFBIvQQGDf110Gc3zDntoLPKWCyt9dTiL0jQ3+akZGR55w==
X-Received: by 2002:a17:907:1686:b0:973:91a5:bfdf with SMTP id hc6-20020a170907168600b0097391a5bfdfmr1347603ejc.4.1684936911458;
        Wed, 24 May 2023 07:01:51 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id p25-20020a1709060dd900b0096f67b55b0csm5860748eji.115.2023.05.24.07.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 07:01:51 -0700 (PDT)
Date:   Wed, 24 May 2023 16:01:50 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, linux-kernel@vger.kernel.org,
        christoph.muellner@vrull.eu, David.Laight@aculab.com,
        Heiko Stuebner <heiko.stuebner@vrull.eu>
Subject: Re: [PATCH v3 1/2] riscv: don't include kernel.h into alternative.h
Message-ID: <20230524-1ae0ba16b93b71a150320a6d@orel>
References: <20230521114715.955823-1-heiko.stuebner@vrull.eu>
 <20230521114715.955823-2-heiko.stuebner@vrull.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230521114715.955823-2-heiko.stuebner@vrull.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 21, 2023 at 01:47:14PM +0200, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@vrull.eu>
> 
> This include is not currently needed for alternatives and creates
> possible issues when we want to add alternatives to deeper kernel
> infrastructure.
> 
> The issue in question came from trying to introduce Zawrs alternatives,
> which resulted in a somewhat circular dependency like:
> 
> In file included from ../include/linux/bitops.h:34,
>                  from ../include/linux/kernel.h:22,
>                  from ../arch/riscv/include/asm/alternative.h:16,
>                  from ../arch/riscv/include/asm/errata_list.h:8,
>                  from ../arch/riscv/include/asm/barrier.h:15,
>                  from ../include/linux/list.h:11,
>                  from ../include/linux/preempt.h:11,
>                  from ../include/linux/spinlock.h:56,
>                  from ../include/linux/mmzone.h:8,
>                  from ../include/linux/gfp.h:7,
>                  from ../include/linux/mm.h:7,
>                  from ../arch/riscv/kernel/asm-offsets.c:10:
> ../include/asm-generic/bitops/generic-non-atomic.h: In function ‘generic_test_bit_acquire’:
> ../include/asm-generic/bitops/generic-non-atomic.h:140:23: error: implicit declaration of function ‘smp_load_acquire’ [-Werror=implicit-function-declaration]
>   140 |         return 1UL & (smp_load_acquire(p) >> (nr & (BITS_PER_LONG-1)));
>       |                       ^~~~~~~~~~~~~~~~
> 
> Signed-off-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
> ---
>  arch/riscv/include/asm/alternative.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/riscv/include/asm/alternative.h b/arch/riscv/include/asm/alternative.h
> index 6a41537826a7..05885de6048c 100644
> --- a/arch/riscv/include/asm/alternative.h
> +++ b/arch/riscv/include/asm/alternative.h
> @@ -13,7 +13,6 @@
>  #ifdef CONFIG_RISCV_ALTERNATIVE
>  
>  #include <linux/init.h>
> -#include <linux/kernel.h>
>  #include <linux/types.h>
>  #include <linux/stddef.h>
>  #include <asm/hwcap.h>
> -- 
> 2.39.0
>

Removing this include doesn't break compilation because the only callers
of PATCH_ID_CPUFEATURE_ID() and PATCH_ID_CPUFEATURE_VALUE(), which are
defined with lower/upper_16_bits(), are in arch/riscv/kernel/cpufeature.c,
which includes at least one thing which eventually includes linux/kernel.h
(the first path I found was linux/module.h -> linux/moduleparam.h ->
linux/kernel.h). Ideally we wouldn't rely on that luck. We can open
code the PATCH_ID_* macros to drop the lower/upper_16_bits() dependencies
or move the macros elsewhere, maybe, for now, just to
arch/riscv/kernel/cpufeature.c

Thanks,
drew
