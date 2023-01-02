Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E462A65B3D8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 16:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236273AbjABPIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 10:08:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236297AbjABPH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 10:07:58 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B759FF6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 07:07:50 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id o31-20020a17090a0a2200b00223fedffb30so28410767pjo.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 07:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=q4eiz17zYWFcsLU8LgZ3JmmwVszEJijgO0C7KmiFnMo=;
        b=Acy33xnC3xVDiC8hpliYuEApI7KuDFSSfMVLsLQY3yhw6ReV6ZP4EVhieSuOR31xpY
         8wj6SXn3tRtu2U7+UXNfmIzQa11PDycs8RruXRcao+LfG99oH+5nxm8ptn04ScatAPTs
         iwArRP4nTN0VOr6bo+q9Yhx/Y3Rp4qncW/5RLDX9UZ5n1W1lR309JPaAzHXaua97jvtw
         IxBYMvJ22tX0Yw8cKst1ZmhrF+htOk7+VrifcdRn2QWvGisk8sqHGKKPEutocNMU3/aP
         0BvPLr6GrK5VTgc7+npbA4yzLKdY4Z8i24qlUQXMILPvuCmdLnamqyNp4gelRgXRlOr/
         XVzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q4eiz17zYWFcsLU8LgZ3JmmwVszEJijgO0C7KmiFnMo=;
        b=0cwkQchUGBl00PlSC7qnaQDVFKgFid+3eGYeE91rDTfewjCTYfkV4ZiZLrhhMiDyxd
         HUNm6gxABxanpKYigwd2FJGF7vMOlDeC3TPTEmu17MVcGn9CVrhlLWQ5oUzn9BcQ21oF
         5o0w3pCiXqiInHhgoQncU10JcDfbMear22Pj+WtNEe6NVinMt5LU08GlqSOvWObmFQnE
         mQsa6iEOGN5V3Ro/WnQTsKYgdF+HdxS0Sy9dpmdXHQOhfpQWrFU0sPUOG7M+QlSIWRtu
         wIEjJ0We18ttA/WnjJPwjUPKcQ3htgk5PnybTz1kiXZ0h9BBUKTByFJYpmjYFTo6HxyN
         +CXQ==
X-Gm-Message-State: AFqh2kq0UykQY5uYArIBtdvuYeKDlZDcoSnRKmZcNvg7Y8glFtffpvQz
        hZCpsGRUvEwEZQSsqaGdco8MLFHq9dJFfZeazf9EVg==
X-Google-Smtp-Source: AMrXdXsy5of6YTLqzo6ernQeH/ddTrVBG9zhDdTuJuUotle+0oU6XymxbVMV7VMWDu0HvhEkTbLqiO0R8ZJyuVRYbWQ=
X-Received: by 2002:a17:90a:c083:b0:226:6c53:fc27 with SMTP id
 o3-20020a17090ac08300b002266c53fc27mr330858pjs.202.1672672069275; Mon, 02 Jan
 2023 07:07:49 -0800 (PST)
MIME-Version: 1.0
References: <20221228142354.28454-1-tom@tom-fitzhenry.me.uk>
In-Reply-To: <20221228142354.28454-1-tom@tom-fitzhenry.me.uk>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 2 Jan 2023 16:07:12 +0100
Message-ID: <CAPDyKFre7C1YrdJMQ10HtoVCSBm1pMT7_9xrkGAHR2jE8OHkoA@mail.gmail.com>
Subject: Re: [PATCH] mmc: pwrseq_simple: include deferred probe reasons
To:     Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Dec 2022 at 15:24, Tom Fitzhenry <tom@tom-fitzhenry.me.uk> wrote:
>
> This adds a reason to /sys/kernel/debug/devices_deferred, which makes
> it easier to debug deferred probes such as [0].
>
> 0. https://lore.kernel.org/all/20221228140708.26431-1-tom@tom-fitzhenry.me.uk/
>
> Signed-off-by: Tom Fitzhenry <tom@tom-fitzhenry.me.uk>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/pwrseq_simple.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/pwrseq_simple.c b/drivers/mmc/core/pwrseq_simple.c
> index 988467fbb621..3bac1e71411b 100644
> --- a/drivers/mmc/core/pwrseq_simple.c
> +++ b/drivers/mmc/core/pwrseq_simple.c
> @@ -119,14 +119,14 @@ static int mmc_pwrseq_simple_probe(struct platform_device *pdev)
>
>         pwrseq->ext_clk = devm_clk_get(dev, "ext_clock");
>         if (IS_ERR(pwrseq->ext_clk) && PTR_ERR(pwrseq->ext_clk) != -ENOENT)
> -               return PTR_ERR(pwrseq->ext_clk);
> +               return dev_err_probe(dev, PTR_ERR(pwrseq->ext_clk), "external clock not ready\n");
>
>         pwrseq->reset_gpios = devm_gpiod_get_array(dev, "reset",
>                                                         GPIOD_OUT_HIGH);
>         if (IS_ERR(pwrseq->reset_gpios) &&
>             PTR_ERR(pwrseq->reset_gpios) != -ENOENT &&
>             PTR_ERR(pwrseq->reset_gpios) != -ENOSYS) {
> -               return PTR_ERR(pwrseq->reset_gpios);
> +               return dev_err_probe(dev, PTR_ERR(pwrseq->reset_gpios), "reset GPIOs not ready\n");
>         }
>
>         device_property_read_u32(dev, "post-power-on-delay-ms",
>
> base-commit: c76083fac3bae1a87ae3d005b5cb1cbc761e31d5
> --
> 2.38.1
>
