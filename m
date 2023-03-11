Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9A9E6B5DA7
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 17:09:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjCKQJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 11:09:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjCKQJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 11:09:45 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 559AEF6927
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 08:09:43 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id y144so8023456yby.12
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 08:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678550982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fzWZK/2DOJOXsvG+XJAqxVL+3bPwefI5Iyt8l7pygUU=;
        b=NEU+nw8LaiuwdyVp2yAz91CWBZNF3qBVdmKv6heVA54lqDYYTkQrItkE9diE+ifQvu
         JvEPZtVIR0BDGlJwIrgrBc7d2s6maquNDE8jtzghRqbxKRpUVOdpMfOby2LbDLTkQM9I
         nhAsUBIxRZ1zNOu529mfMDU1amVxwVhKh3u8EvhIS2FqswVJB4uYyDfQGcMUoTguAgj6
         fwP5UaRMUCK8TTDU1bS0mmVSCxZVRjVXI9NBr51EZ6g+91OBMQZshXNjyXxCbmVTQWBG
         jAhwLRB5tfqbjvCqVcvBLfPwrkizvdEYZcD/7Lw/+NG4spsuOWY2d9moj1xd8BzIAC+E
         bxCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678550982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fzWZK/2DOJOXsvG+XJAqxVL+3bPwefI5Iyt8l7pygUU=;
        b=DEB8gwG/Wqds12GBgcEM7Z38U7g94f0eFXvNgF7vVb+DT1+Fbc7mAHjDtAGGB0texE
         Bs4wnVaHJhV9GGWwQJ4c6nqCcjs2xiGGLfjPhYualBNhel+KcvH+JzWk4URloszCLAHL
         PdYD71nohkK+lyQlQNszPsXwsJ2DFnlR1ISGKJQ7SprvYemEU/vLgeCHDLTh5aCxp6ut
         QqlGg/OUecGA1TcSzDlLD+fh/4cFm9mjEOn4LvMbgRMtph31ocWmOpyBlSqNvEQt9ccY
         1EFk42Nude8BP2hM/0/jQrYvRlvHejyQRBj+MHrqTYOcXHlYxJhToo0M6A02h2ZxG+Z4
         yOOA==
X-Gm-Message-State: AO0yUKW1H6p9dmPpQC0B0HNvREJ61ygOsOkDruwdl3i/w2EONosjQjZr
        vMKvmX/y4M/AUD6aS0TEWMU6M29y+DcvsPKRq1Z+nA==
X-Google-Smtp-Source: AK7set/M/rmOrpL0L838CFr6LBaCI08Xy5jWKITiGoAakJxe2vY4+K5X0NVyMqq5eu3mW3qdOhSXtUFtnmiWfHsmpwQ=
X-Received: by 2002:a25:8d8e:0:b0:b30:2539:a2b0 with SMTP id
 o14-20020a258d8e000000b00b302539a2b0mr3437066ybl.9.1678550982435; Sat, 11 Mar
 2023 08:09:42 -0800 (PST)
MIME-Version: 1.0
References: <20230311111658.251951-1-krzysztof.kozlowski@linaro.org> <20230311111658.251951-4-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230311111658.251951-4-krzysztof.kozlowski@linaro.org>
From:   Guenter Roeck <groeck@google.com>
Date:   Sat, 11 Mar 2023 08:09:31 -0800
Message-ID: <CABXOdTero=NcfJRmyOCWrt8aOVWsyEUWy0h1Y1msTmDL0VS6ew@mail.gmail.com>
Subject: Re: [PATCH 4/5] i2c: cros-ec-tunnel: Mark ACPI and OF related data as
 maybe unused
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Qii Wang <qii.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-i2c@vger.kernel.org, chrome-platform@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-actions@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 11, 2023 at 3:17=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> The driver can be compile tested with !CONFIG_OF or !CONFIG_ACPI making
> certain data unused:
>
>   drivers/i2c/busses/i2c-cros-ec-tunnel.c:295:34: error: =E2=80=98cros_ec=
_i2c_of_match=E2=80=99 defined but not used [-Werror=3Dunused-const-variabl=
e=3D]
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
>  drivers/i2c/busses/i2c-cros-ec-tunnel.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-cros-ec-tunnel.c b/drivers/i2c/busses=
/i2c-cros-ec-tunnel.c
> index 4e787dc709f9..8b3ff5bb14d8 100644
> --- a/drivers/i2c/busses/i2c-cros-ec-tunnel.c
> +++ b/drivers/i2c/busses/i2c-cros-ec-tunnel.c
> @@ -292,13 +292,13 @@ static int ec_i2c_remove(struct platform_device *de=
v)
>         return 0;
>  }
>
> -static const struct of_device_id cros_ec_i2c_of_match[] =3D {
> +static const struct of_device_id cros_ec_i2c_of_match[] __maybe_unused =
=3D {
>         { .compatible =3D "google,cros-ec-i2c-tunnel" },
>         {},
>  };
>  MODULE_DEVICE_TABLE(of, cros_ec_i2c_of_match);
>
> -static const struct acpi_device_id cros_ec_i2c_tunnel_acpi_id[] =3D {
> +static const struct acpi_device_id cros_ec_i2c_tunnel_acpi_id[] __maybe_=
unused =3D {
>         { "GOOG0012", 0 },
>         { }
>  };
> --
> 2.34.1
>
