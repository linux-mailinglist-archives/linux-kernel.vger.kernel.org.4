Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A48262406D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 11:54:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbiKJKyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 05:54:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiKJKyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 05:54:11 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1CE96A6BE
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 02:54:08 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id h193so1431826pgc.10
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 02:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ObGRZiTarAaIfHsRhBfUd1xOV/SNv5tyh9Apxerny3Q=;
        b=oexMQrRmLSjFekPJRi6je/FUBbkM4YeFmxxhcBhON0pu37ThWo+IPdNuzvTjg6y0YP
         7zNjBx+cRDKTUI/JFWB4/vsMAaV/kfKzt3mDunyPvqPCM+iwHTb++jnS265Uq5H6uFis
         7gsPWDFrYR8BfNvBkyGMDzxIJ+U0wE7heXNnxO2bMWAUQk8CCB4iaPHBhcRXKTtdXBeS
         +3GNnwyIADU6nN3VV2dZup9a4PfxPTGQXMHjN4RD5xmUqA9Qwf1JYh/tr4wMhMPE3e4z
         bb3JU1BilItUy2ymys5b4Y9J0scuLHOfzwa+BQr83cyPOLJbJ6CkBG2Fw1Yc6oYBOjKM
         yp7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ObGRZiTarAaIfHsRhBfUd1xOV/SNv5tyh9Apxerny3Q=;
        b=1dxfUOp/nNBdgSEhfi3W4G/lKZDpPDPWOfwJX0sjcszt34RnVh9JX8m8igWcKpxwdF
         FVRMNV72Fh8QwFJymDy+tys53KwIN/e5jDYdRYCMtCj3G7owv5bLSyQEbaB8UCewRE+x
         EXSluqsYRqU0MOOLgnlKToG2+seTGVzp/1bv1hyDZz/WiPMMWD32vE9GdRA4nVCzSG5s
         +x7ws9bpetQlzEpRZDZOUVtH+Nj/Q8HMxNh6gxv1URYkVNflR7UxCtRat6K4hQDt+Xf3
         Kd2hytqrFgxlvMucCTg/lTVuxitFqYKeOoPeBMjYQ5UJHt7TFpbMg49+sp3Cask5lN39
         odyQ==
X-Gm-Message-State: ACrzQf2hBXbvmTO7JfJedUmWRS4vRrN2v0tSwSj8zPHDwLS44xABqBkq
        3kfXUpu8fivse5IGRaBWlEUKs3i0Y54tVR73wVigfg==
X-Google-Smtp-Source: AMsMyM7dI9gA54nUfjMIk9YqHDBjDby6Fo9nOihS0OQy2U1EPNcMQZK54oWsFgEw9bVfo8w2vMsm6Hhgfm1xNX5+Zcg=
X-Received: by 2002:a05:6a00:2489:b0:56d:2d20:d01e with SMTP id
 c9-20020a056a00248900b0056d2d20d01emr62023982pfv.65.1668077648303; Thu, 10
 Nov 2022 02:54:08 -0800 (PST)
MIME-Version: 1.0
References: <20221109160708.507481-1-ludvig.parsson@axis.com>
In-Reply-To: <20221109160708.507481-1-ludvig.parsson@axis.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Thu, 10 Nov 2022 16:23:56 +0530
Message-ID: <CAFA6WYPxTET4mUQ4YHosbPN1o0UthP6PU=t8bAp91GZL+5rjRA@mail.gmail.com>
Subject: Re: [PATCH] tee: optee: Populate child nodes in probe function
To:     =?UTF-8?Q?Ludvig_P=C3=A4rsson?= <ludvig.parsson@axis.com>
Cc:     Jens Wiklander <jens.wiklander@linaro.org>, kernel@axis.com,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Nov 2022 at 21:37, Ludvig P=C3=A4rsson <ludvig.parsson@axis.com> =
wrote:
>
> Currently there is no dependency between the "linaro,scmi-optee" driver
> and the tee_core. If the scmi-optee driver gets probed before the
> tee_bus_type is initialized, then we will get an unwanted error print.
>

What error print do you observe? I suppose this case is already
handled by scmi optee driver via -EPROBE_DEFER.

-Sumit

> This patch enables putting scmi-optee nodes as children to the optee
> node in devicetree, which indirectly creates the missing dependency.
>
> Signed-off-by: Ludvig P=C3=A4rsson <ludvig.parsson@axis.com>
> ---
>  drivers/tee/optee/smc_abi.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
> index a1c1fa1a9c28..be6f02fd5a7f 100644
> --- a/drivers/tee/optee/smc_abi.c
> +++ b/drivers/tee/optee/smc_abi.c
> @@ -1533,6 +1533,11 @@ static int optee_probe(struct platform_device *pde=
v)
>         if (rc)
>                 goto err_disable_shm_cache;
>
> +       /* Populate any dependent child node (if any) */
> +       rc =3D devm_of_platform_populate(&pdev->dev);
> +       if (rc)
> +               goto err_disable_shm_cache;
> +
>         pr_info("initialized driver\n");
>         return 0;
>
> --
> 2.30.2
>
