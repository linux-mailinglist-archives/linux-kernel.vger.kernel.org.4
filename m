Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5041A6170FD
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 23:54:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbiKBWx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 18:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231642AbiKBWxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 18:53:31 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C6712760;
        Wed,  2 Nov 2022 15:53:04 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id v1so282186wrt.11;
        Wed, 02 Nov 2022 15:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wYjfK5FOedPZzZL0Ub/6um1uebzEToZ9Ap0WYh1PvkU=;
        b=XXO6/RnVDaOgdXMMw6bjMCe0AcUwcVsszTCWYpgtc4R7rx3XCbJ7uBmtzNBqcTUXER
         eudVm8TopPSyHYtHk8Ml2oD4xY6Cu7dZHnEdoc7h5jzsip5Q3eXArCvuZLzZkSvxPmIG
         BXBBTdyU+TwEuDRwPTZrOQDBxXFGEltg/bRy4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wYjfK5FOedPZzZL0Ub/6um1uebzEToZ9Ap0WYh1PvkU=;
        b=ssIag6vmlzuPScc66TwEvBKNTv6RSMZY39/pyOxj/Y/u+sMpfjzYAQIgYaELBn/Ghg
         s4hCwVMwXalRmIx11gXNo89/BMTAjOtzZpss8JmGx6lFmmSsfUMAYREUQovpVrmA7aGt
         yQhWZgZd88qJyzoTFtOpUqW1XGlprsi4WLMJPPKV90x+xU6VWOOOfx6xCwZO6SAHBkZS
         4MBXNci3W7fDEF0KuPDhGW6v+QQCdLHcE2wtSQup0aFwSEY9Q0szn2gJFLQSc1F+zuyK
         yvIm/DBNZTNGbL7ef6a1UgovY5pPtkcrclEsgrI8KNNtI610JKQT+H8of1QUEDVYsDfF
         9S0w==
X-Gm-Message-State: ACrzQf1SZ36tunSQMLLY7sQiMPPagsN3oTFmbeP0s3BqaYraoL4qguqt
        u3MVqL6j5rlUPSxwN7Yych44gHQynTD9O29SybA=
X-Google-Smtp-Source: AMsMyM5s9k4J4wfeYI3ptgLk6UhFb+JYibRh3dUJjQIeNtG/3RQfQ5SJeWPsKvXSkAQoSqH/O6b8W9Rp1gIyx4z5Lik=
X-Received: by 2002:a5d:6288:0:b0:236:dc84:1f70 with SMTP id
 k8-20020a5d6288000000b00236dc841f70mr9403016wru.549.1667429582702; Wed, 02
 Nov 2022 15:53:02 -0700 (PDT)
MIME-Version: 1.0
References: <20221101102916.440526-1-j.neuschaefer@gmx.net>
In-Reply-To: <20221101102916.440526-1-j.neuschaefer@gmx.net>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 2 Nov 2022 22:52:50 +0000
Message-ID: <CACPK8XcmDuFta++nfr-Ub+fierfD_GVmXdZKxWTX6AewELUGSQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: nuvoton,wpcm450-supermicro-x9sci-ln4f: Add GPIO
 line names
To:     =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     openbmc@lists.ozlabs.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Nov 2022 at 10:29, Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.ne=
t> wrote:
>
> To make gpioinfo output more useful and enable gpiofind usage, add line
> names for GPIOs where the function is known.
>
> This patch follows the naming convention defined for OpenBMC, as much as
> possible:
>
>   https://github.com/openbmc/docs/blob/master/designs/device-tree-gpio-na=
ming.md
>
> Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>  .../nuvoton-wpcm450-supermicro-x9sci-ln4f.dts  | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/arch/arm/boot/dts/nuvoton-wpcm450-supermicro-x9sci-ln4f.dts =
b/arch/arm/boot/dts/nuvoton-wpcm450-supermicro-x9sci-ln4f.dts
> index 26fed97f8ff4a..d4472ffdac928 100644
> --- a/arch/arm/boot/dts/nuvoton-wpcm450-supermicro-x9sci-ln4f.dts
> +++ b/arch/arm/boot/dts/nuvoton-wpcm450-supermicro-x9sci-ln4f.dts
> @@ -58,6 +58,24 @@ heartbeat {
>         };
>  };
>
> +&gpio0 {
> +       gpio-line-names =3D
> +               /* 0 */ "", "host-reset-control-n", "", "", "", "", "", "=
",
> +               /* 8 */ "", "", "", "", "power-chassis-control-n", "", "u=
id-button", "";
> +};
> +
> +&gpio1 {
> +       gpio-line-names =3D
> +               /* 0 */ "", "", "", "", "led-heartbeat", "", "", "led-uid=
",
> +               /* 8 */ "", "", "", "", "", "", "", "";
> +};
> +
> +&gpio4 {
> +       gpio-line-names =3D
> +               /* 0 */ "", "", "", "", "", "", "", "",
> +               /* 8 */ "", "", "", "", "", "", "", "power-chassis-good";
> +};
> +
>  &pinctrl {
>         key_pins: mux-keys {
>                 groups =3D "gspi", "sspi";
> --
> 2.35.1
>
