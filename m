Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC3070BB22
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 13:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232955AbjEVLH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 07:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbjEVLH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 07:07:29 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A21A4223
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 04:02:31 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-2533ed4f1dcso3968952a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 04:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mechatrax-com.20221208.gappssmtp.com; s=20221208; t=1684753289; x=1687345289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1acKHPl2xEGCIQmSYv/dSXjlbW8r6VsWyy5shozqzsA=;
        b=ajWkTEgRIGP66N1n5mFffw2ngTLoqQ0DKXrr4VFqpBk3k77ddq1iPBOvnFkTFoL+gj
         SH77hXaevhAmNUk6/G3DXc35yBu9kMlSDLuiMBx8JWUkCaeuRA/BtPPeowTwQD3BYylR
         ksLPb7A9fgX3v1qWwHxaPnbBwd+2iPm4BtAz+eT/sRWsO+QZmrXLCECc5f4G8u1yMkpC
         LRcIqlRcgbshicvT5CxkO/BHnXHnua/S3put000l5+5aqjPU6aFrH4PJzURKmwDCDFem
         Umi7Li/G79WFclpn7K1Q/W0hMdj5rt0TNccJbw2VR+xOfyckjudC+HDhZ9x8nr8U0GF0
         QgGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684753289; x=1687345289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1acKHPl2xEGCIQmSYv/dSXjlbW8r6VsWyy5shozqzsA=;
        b=UhBMjxfhN5+aImL7I+ow82mS9C6a5D4og4efVg5NQ0FvSr7n1/Aj7Dhkq3o3zNOnx8
         XHXQoxUgaShcpgWQ4ug23VKt1EjlrD6k1/MV1b+i3HazOksF9fG9VZf+A15oycQm4KaT
         Cfy2i3ELqb+CYFXoTr2/KNm+gGBnBIHJz2ujfgVIufMai1xBeYkI0RqmjmLeMAbyDDtE
         svK1uNrPFfDrTlU1MiSm0t7DeZr+ZIeYD+c24BpWwgk/KL4CXWTbr4CiESBDhSUrmTLu
         TQEqS/WFUoDL0aj7QRS2j2FA8tgy/4ZW8eMPc+6lKglaL+/li5JkdnXmPcLtcEmFpA7H
         fNOA==
X-Gm-Message-State: AC+VfDzOeUMftw+x8TbM6NLs0JC39LWrh/BsERUfElB5aO5xNRPteEKA
        245M2p8/cpzIqgvfjBf8vKR9YlyglANZ/sKu2MGcWw==
X-Google-Smtp-Source: ACHHUZ5WyZI571DBBNHfhVQvlvBYb+9QbxiztOR4RHZ5GFLJp5WgroIhawbNmOYR/bpsyU4VH7LyZHKB8I2zqNPsB+U=
X-Received: by 2002:a17:90a:5792:b0:24d:f2f5:f571 with SMTP id
 g18-20020a17090a579200b0024df2f5f571mr10444785pji.36.1684753289496; Mon, 22
 May 2023 04:01:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230518110816.248-1-honda@mechatrax.com> <20230520163801.04552580@jic23-huawei>
In-Reply-To: <20230520163801.04552580@jic23-huawei>
From:   Masahiro Honda <honda@mechatrax.com>
Date:   Mon, 22 May 2023 20:00:53 +0900
Message-ID: <CA+Tz-SFjMJ0j5EbXSb+mmGusNuB8m5UdJ7V-3tFVH+xPtJi-8w@mail.gmail.com>
Subject: Re: [PATCH v5] iio: adc: ad_sigma_delta: Fix IRQ issue by setting
 IRQ_DISABLE_UNLAZY flag
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 21, 2023 at 12:21=E2=80=AFAM Jonathan Cameron <jic23@kernel.org=
> wrote:
>
> On Thu, 18 May 2023 20:08:16 +0900
> Masahiro Honda <honda@mechatrax.com> wrote:
>
> > The Sigma-Delta ADCs supported by this driver can use SDO as an interru=
pt
> > line to indicate the completion of a conversion. However, some devices
> > cannot properly detect the completion of a conversion by an interrupt.
> > This is for the reason mentioned in the following commit.
> >
> > commit e9849777d0e2 ("genirq: Add flag to force mask in
> >                       disable_irq[_nosync]()")
> >
> > A read operation is performed by an extra interrupt before the completi=
on
> > of a conversion. At this time, the value read from the ADC data registe=
r
> > is the same as the previous conversion result. This patch fixes the iss=
ue
> > by setting IRQ_DISABLE_UNLAZY flag.
> >
> > Fixes: 0c6ef985a1f ("iio: adc: ad7791: fix IRQ flags")
> > Fixes: 1a913270e57 ("iio: adc: ad7793: Fix IRQ flag")
> > Fixes: e081102f307 ("iio: adc: ad7780: Fix IRQ flag")
> > Fixes: 89a86da5cb8 ("iio: adc: ad7192: Add IRQ flag")
> > Fixes: 79ef91493f5 ("iio: adc: ad7124: Set IRQ type to falling")
> All the fixes tags have 11 chars of the hash, needs to be 12. I fixed tha=
t up whilst applying
Sorry. I made mistakes. Thanks for fixing them.

Regards,

Masahiro

> Applied to the fixes-togreg branch of iio.git and marked for stable.
>
> Thanks,
>
> Jonathan
>
> > Signed-off-by: Masahiro Honda <honda@mechatrax.com>
> > ---
> > v5:
> >  - Fix the patch title.
> >  - Add fixes tags.
> >  - Add information about behavior to the commit message.
> > v4: https://lore.kernel.org/linux-iio/20230502102930.773-1-honda@mechat=
rax.com/
> >  - Remove the callback.
> > v3: https://lore.kernel.org/linux-iio/20230420102316.757-1-honda@mechat=
rax.com/
> >  - Remove the Kconfig option.
> > v2: https://lore.kernel.org/linux-iio/20230414102744.150-1-honda@mechat=
rax.com/
> >  - Rework commit message.
> >  - Add a new entry in the Kconfig.
> >  - Call irq_clear_status_flags(irq, IRQ_DISABLE_UNLAZY) when freeing th=
e IRQ.
> > v1: https://lore.kernel.org/linux-iio/20230306044737.862-1-honda@mechat=
rax.com/
> >
> >  drivers/iio/adc/ad_sigma_delta.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigm=
a_delta.c
> > index d8570f62078..7e219287074 100644
> > --- a/drivers/iio/adc/ad_sigma_delta.c
> > +++ b/drivers/iio/adc/ad_sigma_delta.c
> > @@ -584,6 +584,10 @@ static int devm_ad_sd_probe_trigger(struct device =
*dev, struct iio_dev *indio_de
> >       init_completion(&sigma_delta->completion);
> >
> >       sigma_delta->irq_dis =3D true;
> > +
> > +     /* the IRQ core clears IRQ_DISABLE_UNLAZY flag when freeing an IR=
Q */
> > +     irq_set_status_flags(sigma_delta->spi->irq, IRQ_DISABLE_UNLAZY);
> > +
> >       ret =3D devm_request_irq(dev, sigma_delta->spi->irq,
> >                              ad_sd_data_rdy_trig_poll,
> >                              sigma_delta->info->irq_flags | IRQF_NO_AUT=
OEN,
>
