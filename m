Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9669E6F8252
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 13:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbjEELzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 07:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbjEELy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 07:54:59 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3DE31387D
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 04:54:58 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-50bcb229adaso3181034a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 04:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1683287697; x=1685879697;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zM/VTk0nCWAdXB8YnvYclgcFXMLvHHH3s1VUR5VWYms=;
        b=kpzLVpWiLNgD8K0vDvOI0wChk8sYz6Jg5YOpkRdakeQnYl5uTUIpadC5h+rG3oOs46
         tuglgrTwcc+qYMWj0zdVSonEvt2SI8DSYsNo+xlNJsyb0//hTNTFrhrRc7ySOpnmaTFd
         tsFOh5KN9ZijtVV8RX7CSalDLYJyt55vQ7TEq6DQMKFqD6/Tl2pd3ConxCYMH8/1Igri
         erF+eCejob5ZwxkO+TTk2vfSSTBRKBdIWl95t5Ey3rh9joqCgoZk4Bvxf7GcFVHlX8MV
         rE0k7eoJoTkXI+7VTjh/87dbvsngLoxdO+QiNXBelqz3kRrmHu7L8oM6wemxHnfDmgMG
         6d+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683287697; x=1685879697;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zM/VTk0nCWAdXB8YnvYclgcFXMLvHHH3s1VUR5VWYms=;
        b=ZY+4g9I5iMMK+wteXgAFv4wxLMNPvYMA/Uwa6fxJKN0Y3sUwi1NrjrNKgdqk0Qm++K
         2+UXtKL0WNziyjN55vmbI4ypcFTWQjsD452mKbccsNgroztq7Pp5vcWlrVpI942a6NP+
         sXITOXVghnMMI2yLXKUCn2D6sXnfrqYDgHjVd+Lk+kVT9p5bwDAAGJaJu1HFRAG+6tgb
         S+LbJWaS6gXNr5SOwSVppFooHMZYhz4941h/pjs9mLPuAJI903bi1Ddu6P4nUSjRAovO
         Aj1mdowGzN9tO80NcpPcT3fdD2wFl1Kfev0qHu5K+kmrxDX0Fx/u4N9vlWhrg10a7vYH
         SCDg==
X-Gm-Message-State: AC+VfDwt9bIED7RTaBQZ8VgHDNtIZ/motM4+G7SZbnzajfcxEnFuIO8E
        QsoxfGTfah0M6YCQn76gPw8xVQ==
X-Google-Smtp-Source: ACHHUZ7K1jQWPOENUU6Pnw2mq5kQVjdt+RFVfMhzxebmNSaWGppR+0kyH8oGgVJn58qEyTXeNW7Y3Q==
X-Received: by 2002:aa7:ccc8:0:b0:508:3f06:8fd1 with SMTP id y8-20020aa7ccc8000000b005083f068fd1mr1120300edt.29.1683287697284;
        Fri, 05 May 2023 04:54:57 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id r5-20020aa7d585000000b0050696c2d2f6sm2888969edq.88.2023.05.05.04.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 04:54:56 -0700 (PDT)
Date:   Fri, 5 May 2023 13:54:56 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     =?utf-8?B?5byg6aOe?= <zhangfei@nj.iscas.ac.cn>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: Optimize memset
Message-ID: <20230505-9ec599a36801972451e8b17f@orel>
References: <6d1cbe2e.3c31d.187eb14d990.Coremail.zhangfei@nj.iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6d1cbe2e.3c31d.187eb14d990.Coremail.zhangfei@nj.iscas.ac.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Please don't post patches as attachments.

> From: zhangfei <zhangfei@nj.iscas.ac.cn>
> Date: Fri, 5 May 2023 14:58:35 +0800
> Subject: [PATCH] riscv: Optimize memset
> 
> This patch has been optimized for memset data sizes less than 16 bytes.
> Compared to byte by byte storage, significant performance improvement has been achieved.
> 
> Signed-off-by: Fei Zhang <zhangfei@nj.iscas.ac.cn>
> ---
>  arch/riscv/lib/memset.S | 33 ++++++++++++++++++++++++++++++---
>  1 file changed, 30 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/riscv/lib/memset.S b/arch/riscv/lib/memset.S
> index 34c5360c6705..0967bdf86bd6 100644
> --- a/arch/riscv/lib/memset.S
> +++ b/arch/riscv/lib/memset.S
> @@ -105,9 +105,36 @@ WEAK(memset)
>         beqz a2, 6f
>         add a3, t0, a2
>  5:
> -	sb a1, 0(t0)
> -	addi t0, t0, 1
> -	bltu t0, a3, 5b
> +        sb a1, 0(t0)
> +        sb a1, -1(a3)
> +        li a4, 2
> +        bgeu a4, a2, 6f
> +
> +        sb a1, 1(t0)
> +        sb a1, 2(t0)
> +        sb a1, -2(a3)
> +        sb a1, -3(a3)
> +        li a4, 6
> +        bgeu a4, a2, 6f
> +
> +        sb a1, 3(t0)
> +        sb a1, -4(a3)
> +        li a4, 8
> +        bgeu a4, a2, 6f

Why is this check here?

> +
> +        sb a1, 4(t0)
> +        sb a1, -5(a3)
> +        li a4, 10
> +        bgeu a4, a2, 6f

And this one?

After the check of a2 against 6 above we know that offsets 6(t0)
and -7(a3) are safe. Are we trying to avoid too may redundant
stores with these additional checks?

> +
> +        sb a1, 5(t0)
> +        sb a1, 6(t0)
> +        sb a1, -6(a3)
> +        sb a1, -7(a3)
> +        li a4, 14
> +        bgeu a4, a2, 6f
> +
> +        sb a1, 7(t0)
>  6:
>    	ret
>  END(__memset)
> --
> 2.33.0

The indent of the new code doesn't match the old. I'd prefer we cleanup
the old first, though. Please repost [1] as a first patch of a two-patch
patch series, where yours is the second and matches the new formatting
that [1] uses.

[1] https://lore.kernel.org/all/20221027130247.31634-8-ajones@ventanamicro.com/

Thanks,
Drew

On Fri, May 05, 2023 at 04:43:44PM +0800, 张飞 wrote:
> 


> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

