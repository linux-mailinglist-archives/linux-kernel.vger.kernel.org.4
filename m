Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06E936C67E5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 13:15:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbjCWMPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 08:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbjCWMOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 08:14:35 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C4124C80
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 05:14:06 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id z83so24493048ybb.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 05:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679573641;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CBcr6rGUQpq73pjYT7vRUWqGDW5Dr38jLB7HJdT5cIo=;
        b=voEb/826RcZ3kwUnJrKKb5X0HAbeEHDo9gxIa7fYVS2TgYVRFp8uQLGPf5rqZHl+hL
         Q/TNwsas90BLJQRUYzSmNUUVS1mlzjMMyIrkLWAYkIFqrjIX5nNAqZzEX6SwnOjt4tiz
         Lt3fG2Sx0aV86xTqdDs4TZZsEveXVz9psGjGoSLn3Uo4f2v0FRGNfLff+FeaGmdlHkiN
         fgA8epD3GnmWQDOPB9sJtcPHg2XvO/2/LrRw/UY9Pn0KdQZikvonson8U2c4q4ZFEqRk
         hbgu+3nxxqgPSw7s/Ajwzp/0lb9xvCHwZKVkXItCgf1MMGU6p8GmU6//bqu4XYYJVixI
         Bgpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679573641;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CBcr6rGUQpq73pjYT7vRUWqGDW5Dr38jLB7HJdT5cIo=;
        b=NW3VjCNQYOmaEoaTUImS25dwP3O4wee7871tF37aCke6N1y9RjnDuh1j9dxxZDyLMK
         Le8R546YSVz5xPlhc2YmQJxDKlaXJbhwO5fygSe16wiEA/2EbEgQmvif0bYMlxjCUbVm
         JwJ32v6MsYRACg1z8kQM+k4B0Ud2PuA3tH1X1AXAxNjP4KSOMBoeu1MJG7ktPUa/fraK
         +U9vU3hf+F4xAslwOLm3V8LpP9ndTHWlBBh2c2EZ6afU1UrunAwOVs0xyabsU+UFHlp3
         5ejt2El82oq0mmIUzkSjMm7c+oR/H4iAFjX3lQ+CDGKbbsYmgNy/cv8r6J8Bl/zBLJsy
         rLLA==
X-Gm-Message-State: AAQBX9dSrqMxfeGSBgR+orKuai0a13nUrabL8zU+VO9/SNqJwzQdArVG
        nJqyD8u4p0IoZN5VcZFrIVzVV9v0YtyIFwTE7HjWYg==
X-Google-Smtp-Source: AKy350a5HqJ3Do5D8FQMtsU4FwpW2pRvPpCLBVv/YVEXdN/L2HtAIv5Arz6/7Km/jGditdZo9mvd1J5GFyhyQUTw4+I=
X-Received: by 2002:a05:6902:1689:b0:b75:8ac3:d5d9 with SMTP id
 bx9-20020a056902168900b00b758ac3d5d9mr948334ybb.3.1679573641152; Thu, 23 Mar
 2023 05:14:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230319164744.1707169-1-trix@redhat.com>
In-Reply-To: <20230319164744.1707169-1-trix@redhat.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 23 Mar 2023 13:13:25 +0100
Message-ID: <CAPDyKFqfdYKXwaCbT6_hBsX1ZxeVtNivZBQmh3gA8554F944hA@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdricoh_cs: remove unused sdricoh_readw function
To:     Tom Rix <trix@redhat.com>
Cc:     saschasommer@freenet.de, nathan@kernel.org,
        ndesaulniers@google.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Mar 2023 at 17:47, Tom Rix <trix@redhat.com> wrote:
>
> clang with W=1 reports
> drivers/mmc/host/sdricoh_cs.c:104:28: error: unused function
>   'sdricoh_readw' [-Werror,-Wunused-function]
> static inline unsigned int sdricoh_readw(struct sdricoh_host *host,
>                            ^
> This function is not used, so remove it.
>
> Signed-off-by: Tom Rix <trix@redhat.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdricoh_cs.c | 8 --------
>  1 file changed, 8 deletions(-)
>
> diff --git a/drivers/mmc/host/sdricoh_cs.c b/drivers/mmc/host/sdricoh_cs.c
> index 76a8cd3a186f..57b8c1a96756 100644
> --- a/drivers/mmc/host/sdricoh_cs.c
> +++ b/drivers/mmc/host/sdricoh_cs.c
> @@ -101,14 +101,6 @@ static inline void sdricoh_writel(struct sdricoh_host *host, unsigned int reg,
>
>  }
>
> -static inline unsigned int sdricoh_readw(struct sdricoh_host *host,
> -                                        unsigned int reg)
> -{
> -       unsigned int value = readw(host->iobase + reg);
> -       dev_vdbg(host->dev, "rb %x 0x%x\n", reg, value);
> -       return value;
> -}
> -
>  static inline void sdricoh_writew(struct sdricoh_host *host, unsigned int reg,
>                                          unsigned short value)
>  {
> --
> 2.27.0
>
