Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0574C5F5EBE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 04:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiJFCf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 22:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiJFCfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 22:35:54 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE5851A00
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 19:35:53 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id h10so501983plb.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 19:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8wvcyuPvcxrZx5D0Zm+5pCFbzfcierdnsA4uXezxQUo=;
        b=xbwA+ZMNj0MRBaIdl+o3hLiLz9BMrGHJbY9QMLSq5uXA68XqSkiDkfUnzW74GWIQvN
         /Pdzk6w8Ywd3Bg1EX8sA8fYDYoN0d+TRaTeWEG4/M1vc+imiyAXZn1fkP9EoRHEkt/Y/
         Uq4Vs38xoccCRb96IePVWeHiJdL5lnuo8BW3gzQ7LzaM78sxHxHEUaBdHZF8WEgZKUtU
         573Oc2jQjlp07qXhkolM09NM/DuGzrVlxRSmItwf0inFvjK84Ud9h2OWL7tpnbWkVjT+
         jyJs556xNrQyeGNBi39pmDGw6wn/ST3d1wmFhgnPDISRxL+226wXrBErsr1Df+tX9/vW
         OCxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8wvcyuPvcxrZx5D0Zm+5pCFbzfcierdnsA4uXezxQUo=;
        b=B3+tNGBHnfCp3IdppThvjOyiYKCXCwmAXVX/joQZLvihRm6+kkqqIFi8MzeUjTk5Wr
         bGidoYpGnFNnnS9jW35wEKQLNOk3CCHNTIe1aPXNvX6Afu9NEDgCXlNohWwsoEDe0rEE
         QHSy4pV85xLohRBJBW9OyMGZrpJ/8gEw15H+a1EnYyI1JszCW1Ir8CeHmAkKHuQJsN5h
         Jl0Wdoj+SaxJoMIzMNQit2OcrtzRB86OjjyuN/GEeI9GHCJCU/ciiJMeT7+qB7d5MFnL
         Y2tAf/D8Q9EdD7BnGLDt4LWMziF8GYZ/a2dnPUPtaWWKt/ypyylHSx9CG609SLMfB9em
         WNEw==
X-Gm-Message-State: ACrzQf0iAkdNiLteD/dYqyF7idWGE8JKlDeZMUw+DmYZFZJQjpVf1Rc3
        o4UDknSF9AokgRLh3nhjB7n3tQ==
X-Google-Smtp-Source: AMsMyM4P0BNCBo45KoqkaEoROX7DbTzwNozF5HONt9BFzlzag9dkVZKHnZOabat332ZAqJ/wrz4tNQ==
X-Received: by 2002:a17:902:8a97:b0:178:1939:c721 with SMTP id p23-20020a1709028a9700b001781939c721mr2439990plo.108.1665023752463;
        Wed, 05 Oct 2022 19:35:52 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id p30-20020aa79e9e000000b005623f96c24bsm1748979pfq.89.2022.10.05.19.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 19:35:51 -0700 (PDT)
Date:   Wed, 05 Oct 2022 19:35:51 -0700 (PDT)
X-Google-Original-Date: Wed, 05 Oct 2022 18:08:26 PDT (-0700)
Subject:     Re: [PATCH] riscv: compat: s/failed/unsupported if compat mode isn't supported
In-Reply-To: <20220821141819.3804-1-jszhang@kernel.org>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        guoren@kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     jszhang@kernel.org
Message-ID: <mhng-48fad324-fe89-4cb5-8898-15c2082c6cb7@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Aug 2022 07:18:19 PDT (-0700), jszhang@kernel.org wrote:
> When compat mode isn't supported(I believe this is the most case now),
> kernel will emit somthing as:
> [    0.050407] riscv: ELF compat mode failed
>
> This msg may make users think there's something wrong with the kernel
> itself, replace "failed" with "unsupported" to make it clear. In fact
> this is the real compat_mode_supported meaning. After the patch, the
> msg would be:
> [    0.050407] riscv: ELF compat mode unsupported
>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  arch/riscv/kernel/process.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
> index ceb9ebab6558..b0c63e8e867e 100644
> --- a/arch/riscv/kernel/process.c
> +++ b/arch/riscv/kernel/process.c
> @@ -105,7 +105,7 @@ static int __init compat_mode_detect(void)
>  	csr_write(CSR_STATUS, tmp);
>
>  	pr_info("riscv: ELF compat mode %s",
> -			compat_mode_supported ? "supported" : "failed");
> +			compat_mode_supported ? "supported" : "unsupported");
>
>  	return 0;
>  }

Thanks, this is on for-next.
