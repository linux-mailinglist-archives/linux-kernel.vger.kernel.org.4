Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD15867AD46
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 10:06:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234079AbjAYJF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 04:05:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjAYJFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 04:05:25 -0500
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20632359F
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 01:05:24 -0800 (PST)
Received: by mail-qt1-f169.google.com with SMTP id v19so2834505qtq.13
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 01:05:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WIjm+2b9784FIlk5/vMb5ebIJycD5NpJAeSWiCQNE0M=;
        b=Z7EIY/VD92vUhBH4xAu7MrM5r2gO85/XKm5Tk2oDBBsuu1OjPbQqgjtEue2R59vUXM
         4tdT+W7dFR4MkUoycVfYtDus2e4NHHeT/DJjhav62zGt8Xofvt22ImaDP1B6i/Ay8Er+
         UwXQnB99WrieWJYs/ei3D15pDkj/R7o18VEiiTyfRf4N11v1H+XFeK+W42xOgJtP1s2o
         0AfH+yZ9Bp2h7SVNkMpsab1A82Kgg6i9kwRk7t8u6esXkH06rkHFOhWLifgFEiPmqui2
         ac8zZ7EjC562ebWvDhbskLqowdtmnSJQdMP7M6bDSMfIV9XfKV3cB+xbzoXeGmrrXWR4
         RTfw==
X-Gm-Message-State: AFqh2kqWJKr58BQ9ZUHVPurBzJQvv6+GTQFeWwo0tvOsKYvpWt5igoNI
        +DI3OtCQzb/wzsGBPTBH2GW7gRHMfOQQ6g==
X-Google-Smtp-Source: AMrXdXvcfsCGlIrSME2grFHg6lQQvA7wYGM+MIqTyd4i+gnFZEyXrVvXwhWhKnxCcDv1HCR6lGKrLA==
X-Received: by 2002:a05:622a:190:b0:3b7:ec70:30af with SMTP id s16-20020a05622a019000b003b7ec7030afmr12871798qtw.46.1674637522855;
        Wed, 25 Jan 2023 01:05:22 -0800 (PST)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id 72-20020a370a4b000000b006fcc3858044sm3138046qkk.86.2023.01.25.01.05.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jan 2023 01:05:22 -0800 (PST)
Received: by mail-yb1-f179.google.com with SMTP id d132so633082ybb.5
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 01:05:22 -0800 (PST)
X-Received: by 2002:a25:9ac1:0:b0:7b4:6a33:d89f with SMTP id
 t1-20020a259ac1000000b007b46a33d89fmr2454247ybo.543.1674637521998; Wed, 25
 Jan 2023 01:05:21 -0800 (PST)
MIME-Version: 1.0
References: <20230125083248.1305270-1-victor.liu@nxp.com>
In-Reply-To: <20230125083248.1305270-1-victor.liu@nxp.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 25 Jan 2023 10:05:10 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU0KaRyP0qxJLwit1G=7zMr1k5wpCkG-wD31958mrKRWg@mail.gmail.com>
Message-ID: <CAMuHMdU0KaRyP0qxJLwit1G=7zMr1k5wpCkG-wD31958mrKRWg@mail.gmail.com>
Subject: Re: [PATCH] driver: bus: simple-pm-bus: Add Freescale i.MX8qm/qxp CSR
 compatible strings
To:     Liu Ying <victor.liu@nxp.com>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        linux-imx@nxp.com, Rob Herring <robh@kernel.org>,
        Lee Jones <lee@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Liu,

On Wed, Jan 25, 2023 at 9:31 AM Liu Ying <victor.liu@nxp.com> wrote:
> Freescale i.MX8qm/qxp CSR module matches with what the simple power
> managed bus driver does, considering it needs an IPG clock to be
> enabled before accessing it's child devices, the child devices need
> to be populated by the CSR module and the child devices' power
> management operations need to be propagated to their parent devices.
> Add the CSR module's compatible strings to simple_pm_bus_of_match[]
> table to support the CSR module.
>
> Suggested-by: Rob Herring <robh@kernel.org>
> Suggested-by: Lee Jones <lee@kernel.org>
> Signed-off-by: Liu Ying <victor.liu@nxp.com>

Thanks for your patch!

> ---
> The CSR module's dt-binding documentation can be found at
> Documentation/devicetree/bindings/mfd/fsl,imx8qxp-csr.yaml.
>
> Suggested by Rob and Lee in this thread:
> https://patchwork.kernel.org/project/linux-arm-kernel/patch/20221017075702.4182846-1-victor.liu@nxp.com/
>
>  drivers/bus/simple-pm-bus.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/bus/simple-pm-bus.c b/drivers/bus/simple-pm-bus.c
> index 7afe1947e1c0..4a7575afe6c6 100644
> --- a/drivers/bus/simple-pm-bus.c
> +++ b/drivers/bus/simple-pm-bus.c
> @@ -120,6 +120,8 @@ static const struct of_device_id simple_pm_bus_of_match[] = {
>         { .compatible = "simple-mfd",   .data = ONLY_BUS },
>         { .compatible = "isa",          .data = ONLY_BUS },
>         { .compatible = "arm,amba-bus", .data = ONLY_BUS },
> +       { .compatible = "fsl,imx8qm-lvds-csr", },
> +       { .compatible = "fsl,imx8qxp-mipi-lvds-csr", },

I did read the thread linked above, and I still think you should just
add "simple-pm-bus" to the compatible value in DTS, so no driver change
is needed, cfr. Documentation/devicetree/bindings/bus/renesas,bsc.yaml.

If that doesn't work due to DT binding constraints, the latter should
be fixed.

>         { /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, simple_pm_bus_of_match);

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
