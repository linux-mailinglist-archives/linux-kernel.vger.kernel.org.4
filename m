Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C46DB6FED12
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 09:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237535AbjEKHne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 03:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237012AbjEKHnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 03:43:31 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E95411738
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 00:43:28 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f41dceb9d1so55468515e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 00:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1683791007; x=1686383007;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FBy3EahqDgphDTB3uA+fykF7pytc9B8smwJ6NU7vDwM=;
        b=eIFYwFSSuqxK+vIm0dZNSB3vYWqC2bicIX47XguJQcbEpYIOpBIuwGGz5TC1clRGKw
         Uv8hHegP08UctXWFl9cr8r5q+f0lTUaLufV4JdZHztCDzoulNw0xXyrxg24AZbzAIfxt
         HbXvQOKCG9VvZnfRkvwpoDxa7KBqSXMy525dNl8cvnMlqxnsYf65yoGqv85WoxTTAWx/
         aX1Y6z68ML4GH7QSnLaRD5t5NypJQ3XBG7n5jBlO4PcuUokgTs3ZTpeRwHWKln98C5B8
         bARq+DWdernt0rz9pgbNdLPrQCZYisYJRkIATfd1IdV8UVOWkbKg05clnffLInEL23st
         +RpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683791007; x=1686383007;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FBy3EahqDgphDTB3uA+fykF7pytc9B8smwJ6NU7vDwM=;
        b=jYjdro7WOTdg0ktssgtKx6wZyDYukfpLHjHk3xrFPWhtSUXMQkYfSF5ZSKhqdlAitp
         ESJHw2TWd/0qkNZGkFCtDOGfnLCZpRGK83UGeTtzQ0EvdeftDda8uBPSmxHT0YSGWtSb
         nv6D9oTgMktBdeNG/znWwmanogIhGcm5+msVjGacn+BmMyViWmpsMfBU00F8yH+T0uph
         UHWPB7q4rmxfPKpaalOP8THV2UQoYO7XZjY+M9C0U6bYhWjbLleuTXMOmWuRo0XgeBP/
         T9DmNs9ZYH9lK5LRV36JDsWefSA5puFM3grJZwkJpRTzI3Xf/1KyXXj4qpwDn+gdpGDp
         nQUA==
X-Gm-Message-State: AC+VfDxSjXX0zGdLenVCMS8bfl4xL7BhX8RHX2DatN+LjzRE9K/RDNX9
        /fhtQq3wl8ul0zdVn370e+D2JQ==
X-Google-Smtp-Source: ACHHUZ4kIz5XP3kUYA/hnVIW8pxjPDUWybVBvXw/YAkccZzNhDAHSIhtd4q7z1aQawGspLSzUk2Asg==
X-Received: by 2002:a1c:750a:0:b0:3f4:16bc:bd19 with SMTP id o10-20020a1c750a000000b003f416bcbd19mr12140830wmc.23.1683791007240;
        Thu, 11 May 2023 00:43:27 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id z10-20020a05600c220a00b003f171234a08sm24781981wml.20.2023.05.11.00.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 00:43:26 -0700 (PDT)
Date:   Thu, 11 May 2023 09:43:26 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     zhangfei <zhang_fei_0403@163.com>
Cc:     aou@eecs.berkeley.edu, conor.dooley@microchip.com,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        zhangfei@nj.iscas.ac.cn
Subject: Re: [PATCH v2 2/2] RISC-V: lib: Optimize memset performance
Message-ID: <20230511-0b91da227b91eee76f98c6b0@orel>
References: <20230511012604.3222-1-zhang_fei_0403@163.com>
 <20230511013453.3275-1-zhang_fei_0403@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230511013453.3275-1-zhang_fei_0403@163.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2023 at 09:34:53AM +0800, zhangfei wrote:
> From: zhangfei <zhangfei@nj.iscas.ac.cn>
> 
> Optimized performance when the data size is less than 16 bytes.
> Compared to byte by byte storage, significant performance improvement has been achieved.
> It allows storage instructions to be executed in parallel and reduces the number of jumps.

Please wrap commit message lines at 74 chars.

> Additional checks can avoid redundant stores.
> 
> Signed-off-by: Fei Zhang <zhangfei@nj.iscas.ac.cn>
> ---
>  arch/riscv/lib/memset.S | 40 +++++++++++++++++++++++++++++++++++++---
>  1 file changed, 37 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/riscv/lib/memset.S b/arch/riscv/lib/memset.S
> index e613c5c27998..452764bc9900 100644
> --- a/arch/riscv/lib/memset.S
> +++ b/arch/riscv/lib/memset.S
> @@ -106,9 +106,43 @@ WEAK(memset)
>  	beqz	a2, 6f
>  	add	a3, t0, a2
>  5:
> -	sb	a1, 0(t0)
> -	addi	t0, t0, 1
> -	bltu	t0, a3, 5b
> +       /* fill head and tail with minimal branching */
> +       sb      a1,  0(t0)
> +       sb      a1, -1(a3)
> +       li 	a4, 2
> +       bgeu 	a4, a2, 6f
> +
> +       sb 	a1,  1(t0)
> +       sb 	a1,  2(t0)
> +       sb 	a1, -2(a3)
> +       sb 	a1, -3(a3)
> +       li 	a4, 6
> +       bgeu 	a4, a2, 6f
> +
> +       /* 
> +        * Adding additional detection to avoid 
> +        * redundant stores can lead 
> +        * to better performance
> +        */
> +       sb 	a1,  3(t0)
> +       sb 	a1, -4(a3)
> +       li 	a4, 8
> +       bgeu 	a4, a2, 6f
> +
> +       sb 	a1,  4(t0)
> +       sb 	a1, -5(a3)
> +       li 	a4, 10
> +       bgeu 	a4, a2, 6f

These extra checks feel ad hoc to me. Naturally you'll get better results
for 8 byte memsets when there's a branch to the ret after 8 bytes. But
what about 9? I'd think you'd want benchmarks from 1 to 15 bytes to show
how it performs better or worse than byte by byte for each of those sizes.
Also, while 8 bytes might be worth special casing, I'm not sure why 10
would be. What makes 10 worth optimizing more than 11?

Finally, microbenchmarking is quite hardware-specific and energy
consumption should probably also be considered. What energy cost is
there from making redundant stores? Is it worth it?

Thanks for cleaning up the patch series, but I'm still not 100%
convinced we want it.

> +
> +       sb 	a1,  5(t0)
> +       sb 	a1,  6(t0)
> +       sb 	a1, -6(a3)
> +       sb 	a1, -7(a3)
> +       li 	a4, 14
> +       bgeu 	a4, a2, 6f
> +       
> +       /* store the last byte */
> +       sb 	a1,  7(t0)
>  6:
>  	ret
>  END(__memset)
> -- 
> 2.33.0
>

Thanks,
drew
