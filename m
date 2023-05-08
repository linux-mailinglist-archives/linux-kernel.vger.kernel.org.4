Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79D996FA394
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 11:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232911AbjEHJqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 05:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232438AbjEHJqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 05:46:16 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAEB4449E
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 02:46:12 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6439bbc93b6so2589119b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 02:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mechatrax-com.20221208.gappssmtp.com; s=20221208; t=1683539172; x=1686131172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QxUucxl06d3SDkrNlmvPg0Cu2BkqPJXbpojhAwPIsG0=;
        b=oVUt+/viPbDdqiQjujyP5ym/hC7eic0mHWabtIY4phbJ5Bx7AoAamracJ8z56TnU1m
         lRh4qs8LyDXn1HqhwVYH35EjIr9HjG/bJ+YGA4awaFOkxWuzaR9CpY4gVCd7adVGwIcD
         7OWqIA2/nM6RX3mHyEGcQxnCO5Vvc6HGIeIP/a0qleYv9n1ZBT/1iOzRU2GSE6FbCWd8
         cSoqgED4qj0L7z5elVo2iYUWJJsagEv6lWZ19xr8ciigdfUu2/aYjfoAFJLS8wzyfm5y
         4mNK27Q/WujzSe1tq7OBToRxMUt1csUQAftIkdSYgOwzJje+Q5IITnFbyiJi9FIId6JC
         wymw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683539172; x=1686131172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QxUucxl06d3SDkrNlmvPg0Cu2BkqPJXbpojhAwPIsG0=;
        b=cnYoMaFLC0yxQ4uSmnLK11e545n+PGX0nscqJjMnxYOApNQS9cfiJ4UI+Umc8ctXX/
         /tnPbFtSGCkJ2zOu+mN8JFw3YUJ9FK5PKAkaHyISsYMRxQy7IVpFe/rim7M23bHuJrCp
         NeYdrwFbPaEkrx+drBC4GH38sB9fWYPFyGbyU8eELqmUI/V6ibxqcy8betgbbK9W/p56
         cv6LZI/6MIAHX0s86lBj9UDCuYDGyeNhxhgTRbpx84RdE+4I2Aat8dES3KHCrUi95YFf
         SxnCZ+2uWHaBYwmKn+/+9Bxttjd0+7w5a2CjM4Lu3prBjSh/Q0Wo8GgzrXY+ddjEJwun
         HX4A==
X-Gm-Message-State: AC+VfDynJKOAtzjQkoRf7KiJHzpUq6fGInBCqH6ZJJATHbrA8IXobNDC
        RqwOe2mSxz65fCrJzjxrOaunGhLqmMbzFsGB5Z967A==
X-Google-Smtp-Source: ACHHUZ7J5K6Yc2jTfIoxopiJql91/X6loV9lnS6am2IrpKzeVaEsucSSmKu+4eL/4qbcrmk3eFtQ/0Sk+CQk4sMYHZc=
X-Received: by 2002:a05:6a00:acc:b0:63b:435f:134a with SMTP id
 c12-20020a056a000acc00b0063b435f134amr12786940pfl.28.1683539172356; Mon, 08
 May 2023 02:46:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230502102930.773-1-honda@mechatrax.com> <f83adfd4df5cd23176721087a4fcd9a0225c3483.camel@gmail.com>
 <20230507160104.1d6e8bb8@jic23-huawei>
In-Reply-To: <20230507160104.1d6e8bb8@jic23-huawei>
From:   Masahiro Honda <honda@mechatrax.com>
Date:   Mon, 8 May 2023 18:45:36 +0900
Message-ID: <CA+Tz-SHF9+GxVD+U88tTxG4LYCC9BXSQKpVHL3E0eni+fRrgkQ@mail.gmail.com>
Subject: Re: [PATCH v4] Fix IRQ issue by setting IRQ_DISABLE_UNLAZY flag
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
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

Hi Jonathan,

Thank you for your advice.

On Sun, May 7, 2023 at 11:45=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Wed, 03 May 2023 10:09:28 +0200
> Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
>
> Patch title should be something like the following so it's easy to see wh=
at
> is affected when looking at a long list of patches.
>
> iio: adc: ad_sigma_delta: Fix IRQ issue by setting IRQ_DISABLE_UNLAZY fla=
g.
>

I'll fix the title.

>
> > On Tue, 2023-05-02 at 19:29 +0900, Masahiro Honda wrote:
> > > The Sigma-Delta ADCs supported by this driver can use SDO as an inter=
rupt
> > > line to indicate the completion of a conversion. However, some device=
s
> > > cannot properly detect the completion of a conversion by an interrupt=
.
> > > This is for the reason mentioned in the following commit.
> > >
> > > commit e9849777d0e2 ("genirq: Add flag to force mask in
> > >                       disable_irq[_nosync]()")
> > >
> > > A read operation is performed by an extra interrupt before the comple=
tion
> > > of a conversion. This patch fixes the issue by setting IRQ_DISABLE_UN=
LAZY
> > > flag.
> > >
> > > Signed-off-by: Masahiro Honda <honda@mechatrax.com>
> > > ---
> >
> > Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
>
> Fixes tag?  We'll want to know how far to backport this.  I assume it's
> limited by the above commit as these drivers are older than that.
>

I'll try to add a fixes tag.

> I'm also not totally sure what this 'looks like' for a user.  What happen=
s?
> Fail to read, wrong value, lock up or something else?  It would be helpfu=
l
> to include that information in case anyone else runs into this.
>

I'll add information to the commit message.

Regards,

Masahiro


> Actual change looks right to me.
>
> Thanks,
>
> Jonathan
>
>
> >
> > > v4:
> > >  - Remove the callback.
> > > v3:
> > > https://lore.kernel.org/linux-iio/20230420102316.757-1-honda@mechatra=
x.com/
> > >  - Remove the Kconfig option.
> > > v2:
> > > https://lore.kernel.org/linux-iio/20230414102744.150-1-honda@mechatra=
x.com/
> > >  - Rework commit message.
> > >  - Add a new entry in the Kconfig.
> > >  - Call irq_clear_status_flags(irq, IRQ_DISABLE_UNLAZY) when freeing =
the IRQ.
> > > v1:
> > > https://lore.kernel.org/linux-iio/20230306044737.862-1-honda@mechatra=
x.com/
> > >
> > >  drivers/iio/adc/ad_sigma_delta.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git a/drivers/iio/adc/ad_sigma_delta.c
> > > b/drivers/iio/adc/ad_sigma_delta.c
> > > index d8570f6207..7e21928707 100644
> > > --- a/drivers/iio/adc/ad_sigma_delta.c
> > > +++ b/drivers/iio/adc/ad_sigma_delta.c
> > > @@ -584,6 +584,10 @@ static int devm_ad_sd_probe_trigger(struct devic=
e *dev,
> > > struct iio_dev *indio_de
> > >         init_completion(&sigma_delta->completion);
> > >
> > >         sigma_delta->irq_dis =3D true;
> > > +
> > > +       /* the IRQ core clears IRQ_DISABLE_UNLAZY flag when freeing a=
n IRQ */
> > > +       irq_set_status_flags(sigma_delta->spi->irq, IRQ_DISABLE_UNLAZ=
Y);
> > > +
> > >         ret =3D devm_request_irq(dev, sigma_delta->spi->irq,
> > >                                ad_sd_data_rdy_trig_poll,
> > >                                sigma_delta->info->irq_flags | IRQF_NO=
_AUTOEN,
> >
>
