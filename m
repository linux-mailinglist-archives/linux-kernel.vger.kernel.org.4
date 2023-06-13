Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD02B72DE8B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 11:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241807AbjFMJ6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 05:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241474AbjFMJ6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 05:58:17 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 791621BC3;
        Tue, 13 Jun 2023 02:57:45 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-62de508705dso6523726d6.1;
        Tue, 13 Jun 2023 02:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686650264; x=1689242264;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bmlGOY40bYj4Q6JN0GSpXxBgXovTb45ciPVmvgoVcYM=;
        b=TA1AVT7t9v+KXDeaQNzHi+xrxZyCvYLLjaGa9o1vF6BwHcT8+ls6mFpEQlp7byg86/
         JANTcTK8E4lDm6n+bnp27jLfO7XpSyIfZPUyeFH0phr4FDwSsfL3q7R2fIApMr9nPlE6
         foBoDIczxdMOx413LXTOh8PJFf9KfcxgFd5vsgLoEhPIrgIIRLM9wUy0M73iNhsuB6VP
         d1g+d+X1aekm2K+BVLqMSuAG2p43S4qfBhBX8viTlM4PC+Ehv8lCdPUOKRFcg9wmxhjV
         VzTejXAB0Oc85iTYfqNbEDabwKiJ9r4dFBUWNldDurSO75xlrwjKGIkbfTNlkL0JWy31
         tbQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686650264; x=1689242264;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bmlGOY40bYj4Q6JN0GSpXxBgXovTb45ciPVmvgoVcYM=;
        b=VZ0D7+ziego1sV1lPgmwJ+QPDEfNnruDxnAIKRQgNcwmmOMccPzpX4Knh2tMS2nq//
         i3zvu3qshVtHm9FNe3AWr+fwTq22IeHacB9+Z0Pz2MLVRWK9oi96FT4HlEx/MYCjS7kk
         F0b7zFnsBQf7CBEo6F0zCcCR5p3ASi7v2ViJcxfFKHv+ARRowz+ClZkPCKsMoy3JxjVU
         uTwJRAw0t1StRz5mBuGAUTCmLxT7Ls4mhJKLZzF2HMPuefpVGhRVpkHbAomzuu/vZhF9
         1kDYSMa9Dqyd6BFM2vKdsNxYYAm5lwx8vViWx/fvbnsIzkrz9glhzq1Pu7B+QxwiXcPB
         shxg==
X-Gm-Message-State: AC+VfDwkUKVUazw6fb8uWLeg1sKuwNSWBF/Tofq1zI4V9eO6USvtwePi
        MVRfS82CX1/MHsubwKZACTL5D7z7cL1xJjgkASE=
X-Google-Smtp-Source: ACHHUZ7pd1OTAq23LMZyzAc00XDkyvX0IoAjpT0KC/KeIKIEh9N6n2P8J92jcW6HA/8WKDqP9uBBk0G9XvZKmHX4/JU=
X-Received: by 2002:a05:6214:1c89:b0:62d:f598:dc23 with SMTP id
 ib9-20020a0562141c8900b0062df598dc23mr1347986qvb.43.1686650264396; Tue, 13
 Jun 2023 02:57:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230613054601.31566-1-kimseer.paller@analog.com> <20230613054601.31566-2-kimseer.paller@analog.com>
In-Reply-To: <20230613054601.31566-2-kimseer.paller@analog.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 13 Jun 2023 12:57:07 +0300
Message-ID: <CAHp75Vfk2=rYh7GO5XUV8cr3C+3nwu4-PfxxVDuG3Vj0a6b=XQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] iio: adc: max14001: New driver
To:     Kim Seer Paller <kimseer.paller@analog.com>
Cc:     jic23@kernel.org, lars@metafoo.de, lgirdwood@gmail.com,
        broonie@kernel.org, Michael.Hennerich@analog.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 8:46=E2=80=AFAM Kim Seer Paller
<kimseer.paller@analog.com> wrote:
>
> The MAX14001 is a configurable, isolated 10-bit ADC for multi-range
> binary inputs.

...

> +struct max14001_state {
> +       struct spi_device       *spi;
> +       /*
> +        * lock protect agains multiple concurrent accesses, RMW sequence=
, and

against

> +        * SPI transfer
> +        */
> +       struct mutex            lock;
> +       int                     vref_mv;
> +       /*
> +        * DMA (thus cache coherency maintenance) requires the
> +        * transfer buffers to live in their own cache lines.
> +        */
> +       __be16                  spi_tx_buffer __aligned(IIO_DMA_MINALIGN)=
;
> +       __be16                  spi_rx_buffer;
> +};
> +
> +static int max14001_read(void *context, unsigned int reg_addr, unsigned =
int *data)
> +{
> +       struct max14001_state *st =3D context;
> +       int ret;
> +
> +       struct spi_transfer xfers[] =3D {
> +               {
> +                       .tx_buf =3D &st->spi_tx_buffer,
> +                       .len =3D 2,

sizeof()

> +                       .cs_change =3D 1,
> +               }, {
> +                       .rx_buf =3D &st->spi_rx_buffer,
> +                       .len =3D 2,

sizeof()

> +               },
> +       };
> +
> +       st->spi_tx_buffer =3D bitrev16(cpu_to_be16(FIELD_PREP(MAX14001_AD=
DR_MASK,
> +                                                               reg_addr)=
));
> +
> +       ret =3D spi_sync_transfer(st->spi, xfers, ARRAY_SIZE(xfers));
> +       if (ret)
> +               return ret;
> +
> +       *data =3D bitrev16(be16_to_cpu(st->spi_rx_buffer)) & MAX14001_DAT=
A_MASK;
> +
> +       return 0;
> +}

...

> +static const struct iio_chan_spec max14001_channels[] =3D {
> +       {
> +               .type =3D IIO_VOLTAGE,
> +               .channel =3D 0,

Is it required?

> +               .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
> +                                     BIT(IIO_CHAN_INFO_SCALE),
> +       }
> +};

--=20
With Best Regards,
Andy Shevchenko
