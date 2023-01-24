Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 024C267962F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 12:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232620AbjAXLHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 06:07:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231828AbjAXLHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 06:07:31 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4594193EB
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 03:07:30 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id s67so11058148pgs.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 03:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MhkW1FpMKSBw2LEIkWml12Y6AIM7FamikDRt0i3hkOQ=;
        b=dn5Fz8Pc+eFnZnOhew1XCQJ2tUBOFpj2KCib49g+FwpH2PFCVZD+IYfQ1XLa8gTTnJ
         EhKMTXz3KJFnsYxH5P7f1mjz6DM1bt5q9ce4wLzCToBTWO/gydGEwcTopJ/3x9rsgZ4l
         2rrRMVFrsvo/uIEEidDUldoybOfb6moS5xlmfTQfp6UdhG4eV5mqKSeBWE5Zlb3xoDUI
         IYrpopUVip3QqSk0ha42xrBOcE/LcFqmnQ+nspZyC7MtM2bH3AExosGaJ7w3+BIM4mzx
         TuD9Sssq/RVS3rjRG5fIqcSclVkgDKKESfkt6Z8CX5PyfEJFNU6aepJcl+7CE0XJx6mY
         Wh/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MhkW1FpMKSBw2LEIkWml12Y6AIM7FamikDRt0i3hkOQ=;
        b=BExcDgImkMDl6jm+p5g4XR5IZHjeRdHCSIoMEC0yerUUOJ3Fq3GASyqvUMpFLv3MAx
         RuHy+VHydN0vOFOQeXipXa9XfwrRsKmDAON/HeLAvUuzARNPVi2LR8+iJDNgsZyBDQX0
         J1CVlvv5TBId76vwexhdzbzveLNQtK+g5XnDK8hU3Tr2w/Qfs1qg+yLIqrkomb11sUrg
         8rz8ar4YzIocfiIcdDcLF/hD9Wy8ix5rMLCOeSTME3qG0Iu9zqefonf9HeJ9g7v5mXrV
         Wng+ny55KCnqDJuFG+w2VkrQT4UpfpqOMmsdqxGmO0/6tQutrJH1vpGfHx+Jg9C6EOPD
         LH4g==
X-Gm-Message-State: AFqh2kqQBP2kDFDCAJcleoa9yt3KGJNcCUe1ydfcVavh32zLJoevJ0Qv
        HT1C5hL1iKwxEUBsk/rQEptWOmVO7pltaczZ+Otvdg==
X-Google-Smtp-Source: AMrXdXtOWDOmHbkDr/4rC1Lhpj2j2CSC6rKV/xVHz07rP6WvxnUEy1UeMPI4/tzJj38SUMMz9tafOXcPRTgbuxD7oek=
X-Received: by 2002:a05:6a00:2c7:b0:577:139e:1ec8 with SMTP id
 b7-20020a056a0002c700b00577139e1ec8mr3399448pft.40.1674558449616; Tue, 24 Jan
 2023 03:07:29 -0800 (PST)
MIME-Version: 1.0
References: <20230118045749.3913296-1-chenhuiz@axis.com>
In-Reply-To: <20230118045749.3913296-1-chenhuiz@axis.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 24 Jan 2023 12:06:53 +0100
Message-ID: <CAPDyKFqUnp_rDcckBSW386webSgjAhfdONN_AKYCS-kY3XwKPg@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: expose MMC_CAP_AGGRESSIVE_PM to DT
To:     Hermes Zhang <chenhuiz@axis.com>
Cc:     kernel@axis.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Jan 2023 at 05:57, Hermes Zhang <chenhuiz@axis.com> wrote:
>
> This patch expose the MMC_CAP_AGGRESSIVE_PM flag to DT which
> allows the host to enable it from DT.
>
> Signed-off-by: Hermes Zhang <chenhuiz@axis.com>
> ---
>  drivers/mmc/core/host.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index d17eda753b7e..1d98a301515d 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -376,6 +376,8 @@ int mmc_of_parse(struct mmc_host *host)
>                 host->caps |= MMC_CAP_HW_RESET;
>         if (device_property_read_bool(dev, "cap-sdio-irq"))
>                 host->caps |= MMC_CAP_SDIO_IRQ;
> +       if (device_property_read_bool(dev, "cap-aggressive-pm"))
> +               host->caps |= MMC_CAP_AGGRESSIVE_PM;

I think this can be debated whether this is a description of some
characteristics of the HW.

That said, please add the DT list and maintainers and resend, to let
them share their view too.

>         if (device_property_read_bool(dev, "full-pwr-cycle"))
>                 host->caps2 |= MMC_CAP2_FULL_PWR_CYCLE;
>         if (device_property_read_bool(dev, "full-pwr-cycle-in-suspend"))
> --

Kind regards
Uffe
