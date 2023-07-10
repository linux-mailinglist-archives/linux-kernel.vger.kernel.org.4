Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8CC274CE9A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 09:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjGJHhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 03:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbjGJHhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 03:37:33 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C73F4;
        Mon, 10 Jul 2023 00:37:31 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9922d6f003cso558534766b.0;
        Mon, 10 Jul 2023 00:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688974650; x=1691566650;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A9Nv8hdTpZ1xMx5bIOtGrgeBtJ+A2/F1n9QKY2k4cjc=;
        b=DIGPvNdQbuCxmYr1UuwZUbnpXGTwEcorKe9uJej5q4F/8hRF3tTZKBMKmx2DZiXP65
         iR1qQ041sjabLXrHjVP/ROE9uYbcYP3CKAudwkBOebvx0itO1TjFsF9s6mepr2cqf2W5
         beSisnzMVSEQnbIgPJCep+pswhO4q4uqy8WKMdln3NSP0jLa9FwzCRqiVjv+vNO5XjXb
         3rcFILsF2hs/zHVnQsv1Z5JCbEkOkP7cnLqsatotfHg0z38FXZ/MNNtuaMFaypDRFN72
         0Rg+zWB3bWsN9ePGMoc2Qpiz2+mIgyGdaTv/sgOL7Z9VvqTUqb8luHkzyn05XjPqI1Es
         FPEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688974650; x=1691566650;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A9Nv8hdTpZ1xMx5bIOtGrgeBtJ+A2/F1n9QKY2k4cjc=;
        b=UDdrvXqDxhgcPgcaQ1uDFqCVviqItcyyawFf3SqxhZj/Fu4XwnM9rZ0TfdYml9p09g
         qDDfI2b2loitmLNlCGlE1zeQv46psem6geBKAh/fPTrw9/oHbNt86MqjhIX6Ck6mcLgL
         pcdZe6cxDEHFdljKOE0Lo27n7sK5hGalX8Vl5f6y35SDhYHLBkL7GT2mM/vDLML3rPtL
         AalHESTl9NrpNwPfVTwngxaYBZsefmMMosfD199YZ6PZuZm3yyLLCOMtnbdPq+LgT4Z8
         qNiqwdGAyu9HeifwSycUw/G0JPXg3aYfLdCAnf5Jt+AmGSvrK5sZtm6Hb8Vce2H+X1b3
         3wjw==
X-Gm-Message-State: ABy/qLbc3weblLXLGR5EgfDrBOLrDOzsseWtgGG4kpypYhrTjE1eZqwr
        KZY/hOgsY1BztBnAXjcwuFCOuqeLZmtM4WTXM1Y99VUype8=
X-Google-Smtp-Source: APBJJlEYDii09SUQ0/5P40+Ef9zzKD5WQUWMHKt/i36QroSYc/+2MxbjXI0rc7Av5zVBurjfkmSC3LsEWPjP0OfGiG4=
X-Received: by 2002:a17:907:a704:b0:992:630f:98b6 with SMTP id
 vw4-20020a170907a70400b00992630f98b6mr12131090ejc.37.1688974649649; Mon, 10
 Jul 2023 00:37:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230710042723.46084-1-kimseer.paller@analog.com> <20230710042723.46084-2-kimseer.paller@analog.com>
In-Reply-To: <20230710042723.46084-2-kimseer.paller@analog.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 10 Jul 2023 10:36:53 +0300
Message-ID: <CAHp75Vd386P9xM_+wLahp6B_XwYVq1AZxaFQeWvZ2pnk-tFGHA@mail.gmail.com>
Subject: Re: [PATCH v9 2/2] iio: adc: max14001: New driver
To:     Kim Seer Paller <kimseer.paller@analog.com>
Cc:     jic23@kernel.org, lars@metafoo.de, lgirdwood@gmail.com,
        broonie@kernel.org, Michael.Hennerich@analog.com, robh@kernel.org,
        krzysztof.kozlowski@linaro.org, conor+dt@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 7:27=E2=80=AFAM Kim Seer Paller
<kimseer.paller@analog.com> wrote:
>
> The MAX14001 is configurable, isolated 10-bit ADCs for multi-range
> binary inputs.

...

> V8 -> V9: Changed SPI buffer data types to __le16,

Why?

...

> +       __le16                  spi_tx_buffer __aligned(IIO_DMA_MINALIGN)=
;
> +       __le16                  spi_rx_buffer;

...

> +       /*
> +        * Prepare SPI transmit buffer 16 bit-value to big-endian format =
and
> +        * reverses bit order to align with the LSB-first input on SDI po=
rt.

reverse

> +        */
> +       st->spi_tx_buffer =3D bitrev16(cpu_to_be16(FIELD_PREP(MAX14001_AD=
DR_MASK,
> +                                    reg_addr)));

...

> +       /*
> +        * Convert received 16-bit value from big-endian to little-endian=
 format
> +        * and reverses bit order.

reverse

> +        */
> +       *data =3D bitrev16(be16_to_cpu(st->spi_rx_buffer));

...

> +       /*
> +        * Prepare SPI transmit buffer 16 bit-value to big-endian format =
and
> +        * reverses bit order to align with the LSB-first input on SDI po=
rt.

reverse

> +        */
> +       st->spi_tx_buffer =3D bitrev16(cpu_to_be16(
> +                                    FIELD_PREP(MAX14001_ADDR_MASK, reg_a=
ddr) |
> +                                    FIELD_PREP(MAX14001_SET_WRITE_BIT, 1=
) |
> +                                    FIELD_PREP(MAX14001_DATA_MASK, data)=
));

Obviously it's incorrect now even more than before.
The types are defined as __le, while ops are against __be.

--=20
With Best Regards,
Andy Shevchenko
