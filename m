Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B107563C5C4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 17:56:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236490AbiK2Q4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 11:56:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235760AbiK2Qzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 11:55:44 -0500
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D996B74CD1;
        Tue, 29 Nov 2022 08:50:23 -0800 (PST)
Received: by mail-qk1-f173.google.com with SMTP id p18so10215475qkg.2;
        Tue, 29 Nov 2022 08:50:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Reczz2TeQI8YuLHOogtUntCHfa5rl0jqbOQAUswYaAw=;
        b=gwNSAY492mdgn/QcdSWVFhbR/sIWqH5No4zYXCumnscMUayR6wPiKUDXPi/eGeUvV1
         zqe2m6N4YCycoJNLv8uoaiZx1dZcVySZsIXsuQ3XNOcheeLitiHgU40xFZYpej3wJzHu
         0BAHRh+TsFSTdDOxkxqr54/0thmkaVwqTmUxEITP7XRIE/qKWPOHW2sRqzN4uFs6YKjV
         eIOKQpjEn2kbjvbPDMWGnw5hNAEVcjRfrGXkWtvxaZj2Pwq9ZG1/tvCsX6GpljYyhjCE
         s43p/eXNGDvwANYGEU1p8Qr/AJLsGHnJBLWqLMwOoTmPxneLhUrsve19dHrc1gwr/hIe
         QCQw==
X-Gm-Message-State: ANoB5pm3JQLW9DbaT2citVrjPNd9k9+xHKm9eTT7hrTJ6DW2ZtJ1Ouin
        kZ19NNbattrunNWv8gDUgXugdTmhKRD32Q==
X-Google-Smtp-Source: AA0mqf7tqY/EJW8ZBHGvh7C+dpJayMVwS5DUANPOMGlBtuA/MtDKehgJJChIlcOpYx90qk6AYl5b6Q==
X-Received: by 2002:a37:af07:0:b0:6ee:ee7c:aad8 with SMTP id y7-20020a37af07000000b006eeee7caad8mr33567345qke.470.1669740578423;
        Tue, 29 Nov 2022 08:49:38 -0800 (PST)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id v12-20020a05620a440c00b006fc2b672950sm11052234qkp.37.2022.11.29.08.49.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Nov 2022 08:49:38 -0800 (PST)
Received: by mail-yb1-f171.google.com with SMTP id o127so2733160yba.5;
        Tue, 29 Nov 2022 08:49:37 -0800 (PST)
X-Received: by 2002:a25:9e84:0:b0:6de:6183:c5c3 with SMTP id
 p4-20020a259e84000000b006de6183c5c3mr37056563ybq.89.1669740577632; Tue, 29
 Nov 2022 08:49:37 -0800 (PST)
MIME-Version: 1.0
References: <20221124003351.7792-1-hayashi.kunihiko@socionext.com> <20221124003351.7792-3-hayashi.kunihiko@socionext.com>
In-Reply-To: <20221124003351.7792-3-hayashi.kunihiko@socionext.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 29 Nov 2022 17:49:26 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVH+amC83uMBpsCebaHd2EWp1EO59JNcgRTncbNGNNRsQ@mail.gmail.com>
Message-ID: <CAMuHMdVH+amC83uMBpsCebaHd2EWp1EO59JNcgRTncbNGNNRsQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] spi: Add Socionext F_OSPI SPI flash controller driver
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hayashi-san,

On Thu, Nov 24, 2022 at 1:36 AM Kunihiko Hayashi
<hayashi.kunihiko@socionext.com> wrote:
> Introduce Socionext F_OSPI controller driver. This controller is used to
> communicate with slave devices such as SPI Flash memories. It supports
> 4 slave devices and up to 8-bit wide bus, but supports master mode only.
>
> This driver uses spi-mem framework for SPI flash memory access, and
> can only operate indirect access mode and single data rate mode.
>
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

Thanks for your patch, which is now commit 1b74dd64c8612619
("spi: Add Socionext F_OSPI SPI flash controller driver") in
spi/for-next.

> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -906,6 +906,15 @@ config SPI_SLAVE_MT27XX
>           say Y or M here.If you are not sure, say N.
>           SPI slave drivers for Mediatek MT27XX series ARM SoCs.
>
> +config SPI_SN_F_OSPI
> +       tristate "Socionext F_OSPI SPI flash controller"
> +       depends on OF && HAS_IOMEM
> +       depends on SPI_MEM

On which systems is this hardware block found?
Perhaps this should depend on ARCH_UNIPHIER || COMPILE_TEST?

> +       help
> +         This enables support for the Socionext F_OSPI controller
> +         for connecting an SPI Flash memory over up to 8-bit wide bus.
> +         It supports indirect access mode only.
> +
>  config SPI_SPRD
>         tristate "Spreadtrum SPI controller"
>         depends on ARCH_SPRD || COMPILE_TEST

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
