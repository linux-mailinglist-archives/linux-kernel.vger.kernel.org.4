Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1A1572C858
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 16:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjFLO0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 10:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240165AbjFLOZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 10:25:49 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 099444681;
        Mon, 12 Jun 2023 07:24:15 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-75d4b85b3ccso468272885a.2;
        Mon, 12 Jun 2023 07:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686579853; x=1689171853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0VEkBjys1JNVdNZfskXkYECCvShc9qH26Dgn/H0N3vs=;
        b=BMR7SfhOazLnf9RuLEkEdI2+xKFFzdvL8Z6jJZ1l0EekxpsO7EPMyOC4UAL4+DyJyZ
         eKmpoU9alhxmuBishJSdURhgGNy1M06tIyWeazdDuxheebOuVEvVZ5IfllVGGVgYkRG7
         +nhpIZo7ZccIKsFXKsVA0Z4EjsEoxkbNoROOp69SGGDPGUJV3mWBXzZS8D9CFAy3XC5b
         O4qQ8uyOXfBy/bjT43ZD43EMbDWwMBZdSOPMaUPpeLT/3rCQh9gIVsGP7InSOIdtmaiK
         8CeRMsacdg5XIu+b3MRBGavbScs6YUeO4BJ2kjQvQtAYW+z+Ou8ZE5ANamjY1w/p+6bp
         Pvbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686579853; x=1689171853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0VEkBjys1JNVdNZfskXkYECCvShc9qH26Dgn/H0N3vs=;
        b=kuxvrjozIxBOICP2ivl+OOK7OXWfNNN8151ftW+31XM4y49LGvmjd7qXv31sWlzJct
         xMQHfRPV4cEWlS+5eqZ7Y2vzb6YMwmMSvN2BkaK//xzi8cDR/5RMUO+OoYCCopjcBaJL
         QEBzVAmEpfzTZMDXuTMRLFUCHh3OPIiLJYjfeBqj8xdit2MGZbkWbZbWUfHU2AeB5Ipg
         c8Nk0ELRu2uXHvRePrqErTlZ1+SKa2uRHhmFBFdnMKHOYxIx/3hRL9SLuzG5nlPaTwAM
         7Tr1YVAemkWlAzM4mnjp4XLEgnv4nR0IUFaWaOYWFPd71K0m8vsZxzbSGLB9+cKKOD+l
         8S9g==
X-Gm-Message-State: AC+VfDzCKoPZQI1lxaSkCLOegpN7saRu0ZRx7OttazuJG3JhvQrLmRdp
        QrdgGfVqYbCHO153IgIIWGXl6KpGQNyz++s9yLerniaLqi1DZMvG
X-Google-Smtp-Source: ACHHUZ7tnRv1PT2hgZe9Ed4LlXXelujAAz16F3OmF4PLIVGBz2ZDarjhCzlaeEmxKrQhkfRrnE2Fyj2E03bmcW8JeNE=
X-Received: by 2002:a05:6808:b32:b0:396:3b9d:7ee0 with SMTP id
 t18-20020a0568080b3200b003963b9d7ee0mr4445651oij.41.1686579398638; Mon, 12
 Jun 2023 07:16:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230612122926.107333-1-herve.codina@bootlin.com> <20230612122926.107333-5-herve.codina@bootlin.com>
In-Reply-To: <20230612122926.107333-5-herve.codina@bootlin.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 12 Jun 2023 17:16:02 +0300
Message-ID: <CAHp75Vcwaouw0VZp1-5YTso6wPBqn0AQk7UcK1XcHMR7PYCVng@mail.gmail.com>
Subject: Re: [PATCH v3 04/12] iio: consumer.h: Fix raw values documentation notes
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
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

On Mon, Jun 12, 2023 at 3:30=E2=80=AFPM Herve Codina <herve.codina@bootlin.=
com> wrote:
>
> The raw values notes mention 'ADC counts' and are not fully accurate.
>
> Reword the notes in order to remove the 'ADC counts' and describe the
> conversion needed between a raw value and a value in the standard units.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  include/linux/iio/consumer.h | 25 +++++++++++++++----------
>  1 file changed, 15 insertions(+), 10 deletions(-)
>
> diff --git a/include/linux/iio/consumer.h b/include/linux/iio/consumer.h
> index 6802596b017c..f536820b9cf2 100644
> --- a/include/linux/iio/consumer.h
> +++ b/include/linux/iio/consumer.h
> @@ -201,8 +201,9 @@ struct iio_dev
>   * @chan:              The channel being queried.
>   * @val:               Value read back.
>   *
> - * Note raw reads from iio channels are in adc counts and hence
> - * scale will need to be applied if standard units required.
> + * Note, if standard units are required, raw reads from iio channels
> + * need the offset (default 0) and scale (default 1) to be applied
> + * as (raw + offset) * scale.
>   */
>  int iio_read_channel_raw(struct iio_channel *chan,
>                          int *val);
> @@ -212,8 +213,9 @@ int iio_read_channel_raw(struct iio_channel *chan,
>   * @chan:              The channel being queried.
>   * @val:               Value read back.
>   *
> - * Note raw reads from iio channels are in adc counts and hence
> - * scale will need to be applied if standard units required.
> + * Note, if standard units are required, raw reads from iio channels
> + * need the offset (default 0) and scale (default 1) to be applied
> + * as (raw + offset) * scale.
>   *
>   * In opposit to the normal iio_read_channel_raw this function
>   * returns the average of multiple reads.
> @@ -281,8 +283,9 @@ int iio_read_channel_attribute(struct iio_channel *ch=
an, int *val,
>   * @chan:              The channel being queried.
>   * @val:               Value being written.
>   *
> - * Note raw writes to iio channels are in dac counts and hence
> - * scale will need to be applied if standard units required.
> + * Note that for raw writes to iio channels, if the value provided is
> + * in standard units, the affect of the scale and offset must be removed
> + * as (value / scale) - offset.
>   */
>  int iio_write_channel_raw(struct iio_channel *chan, int val);
>
> @@ -292,8 +295,9 @@ int iio_write_channel_raw(struct iio_channel *chan, i=
nt val);
>   * @chan:              The channel being queried.
>   * @val:               Value read back.
>   *
> - * Note raw reads from iio channels are in adc counts and hence
> - * scale will need to be applied if standard units are required.
> + * Note, if standard units are required, raw reads from iio channels
> + * need the offset (default 0) and scale (default 1) to be applied
> + * as (raw + offset) * scale.
>   */
>  int iio_read_max_channel_raw(struct iio_channel *chan, int *val);
>
> @@ -308,8 +312,9 @@ int iio_read_max_channel_raw(struct iio_channel *chan=
, int *val);
>   * For ranges, three vals are always returned; min, step and max.
>   * For lists, all the possible values are enumerated.
>   *
> - * Note raw available values from iio channels are in adc counts and
> - * hence scale will need to be applied if standard units are required.
> + * Note, if standard units are required, raw available values from iio
> + * channels need the offset (default 0) and scale (default 1) to be appl=
ied
> + * as (raw + offset) * scale.
>   */
>  int iio_read_avail_channel_raw(struct iio_channel *chan,
>                                const int **vals, int *length);
> --
> 2.40.1
>


--=20
With Best Regards,
Andy Shevchenko
