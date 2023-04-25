Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE456EE529
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 18:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234635AbjDYQAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 12:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234424AbjDYQAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 12:00:07 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11656CC1F
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 09:00:05 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-94a342f7c4cso1091789666b.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 09:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1682438403; x=1685030403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WW5w9nK23U/V6j0PQ9boJ4GotqhlTheLhPRyr44ceZ0=;
        b=ACrFG0mlKY8ai67MpmptwG7BxbOUWdzpuxNABQsdI2BDCrnJvFKrVEeDFCXntmZweH
         rSPZK2kbXftvUvAH7T/eKbLT7ZHfE98ahClF07TMys1W7L7RglUZ5LeywE5TxCEd50uP
         EkVuxhq7DIs586WPuVM/Y19BeAN/u2o+7jQN7ky83ja8tPhQEopfLNBNF7VSDy5l/kVJ
         7J7lzpViF5ropULfhpUgj4j9qavyto9KxOwFp7eBzAuKMLjc6MbaJ6kkzoj7gMJnelJT
         0mWU/+C9QoE/KOdMzuGEbeuHLU0EQ1tygGwOI/0H6bWKAdOl4OlkeLxin6QMf6Bcx29G
         R7sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682438403; x=1685030403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WW5w9nK23U/V6j0PQ9boJ4GotqhlTheLhPRyr44ceZ0=;
        b=Et0R7p1O9Y1ylzy+8+d7h6qR8JT7IVFRrVMhasd5baQDI6BBQoCCv7w34eOWIRXd1e
         PYz1D11+2wZuCmaGSIkzu0x9NjMYjXBmXdsMJtOPYnzdGbC9+1w5QfdpCb4/oM1s+KAl
         VIeNs0HYSrna32ofPjc0bCQVlQjg83wbowkp0r+QA454ZmOKzUtgETB4Fmr+h3wPQibD
         8H9mgUMKDibTCbOzH/QbQzGD2x2VDYb6JQwFjKepaGSL93+J7pcCIfSHJ0u7Ie+B0xz8
         yW51u72xPZtClDAbzeTcN0ObpcixiG6B2uS8MGi7fMFQvaUTO6DXECVaOL0YqRps6dfY
         +UWQ==
X-Gm-Message-State: AAQBX9fkbGQDK00qbcgNMqNKDUkVuBM59cn9x6Oyk2HVJLR8jvRFMLK6
        uQq+Fostr9O3tfvRhM5mbFKdgiB1MTvyw0dbfFJNnQ==
X-Google-Smtp-Source: AKy350bRMqreBk2BEw7LdRmTw8kY2PHkOlhrblZA47zUSJSl7M7YQwo036CjMlDB2cAO15HNV0bXA4XQxkPtwEebJow=
X-Received: by 2002:a17:907:90c4:b0:94e:ff23:992a with SMTP id
 gk4-20020a17090790c400b0094eff23992amr12659918ejb.59.1682438403555; Tue, 25
 Apr 2023 09:00:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230414140203.707729-1-pan@semihalf.com> <20230414140203.707729-2-pan@semihalf.com>
 <e64b438e-1205-4e54-b8c0-1b9a5d074752@sirena.org.uk>
In-Reply-To: <e64b438e-1205-4e54-b8c0-1b9a5d074752@sirena.org.uk>
From:   =?UTF-8?Q?Pawe=C5=82_Anikiel?= <pan@semihalf.com>
Date:   Tue, 25 Apr 2023 17:59:52 +0200
Message-ID: <CAF9_jYTyhJZaCk1zN93Rr5AXAmpk4nu6z0Z9+RQb4HxGQ=zZLQ@mail.gmail.com>
Subject: Re: [PATCH 1/9] ASoC: Add Chameleon v3 audio
To:     Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dinguyen@kernel.org,
        lars@metafoo.de, nuno.sa@analog.com, upstream@semihalf.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for all the comments, I'm sorry for taking long to respond.

On Fri, Apr 14, 2023 at 7:19=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Fri, Apr 14, 2023 at 04:01:55PM +0200, Pawe=C5=82 Anikiel wrote:
>
> > ---
> >  .../boot/dts/socfpga_arria10_chameleonv3.dts  |  28 ++
>
> Updates to the DT should be in a separate patch.

Ok, I'll fix in next patchset

>
> >  sound/soc/chameleonv3/chv3-audio.c            | 111 ++++++
> >  sound/soc/chameleonv3/chv3-i2s.c              | 347 ++++++++++++++++++
> >  sound/soc/chameleonv3/chv3-it68051.c          |  41 +++
>
> The machine driver and board drivers (if needed) should also be separate
> patches - one patch per driver.

Ok, I'll fix in next patchset

>
> > +config SND_SOC_CHV3
> > +       tristate "SoC Audio support for Chameleon v3"
> > +       select SND_SOC_SSM2602
> > +       select SND_SOC_SSM2602_I2C
> > +       help
> > +         Say Y if you want to add audio support for the Chameleon v3.
>
> It woudl be better to have a separate selectable symbol for each drier.

I'm not sure about this. If I disable just one driver, the entire card
fails to probe (even if some audio device doesn't need that driver).
Does it then make sense to be able to deselect some drivers? Please
correct me if I'm misunderstanding.

>
> > +static int chv3_ssm2603_hw_params(struct snd_pcm_substream *substream,
> > +                       struct snd_pcm_hw_params *params)
> > +{
> > +     struct snd_soc_pcm_runtime *rtd =3D asoc_substream_to_rtd(substre=
am);
> > +     struct snd_soc_dai *dai =3D asoc_rtd_to_codec(rtd, 0);
> > +
> > +     return snd_soc_dai_set_sysclk(dai, 0, 22579200, SND_SOC_CLOCK_IN)=
;
> > +}
>
> This could be done once at init, though in general I can't tell why this
> isn't audio-graph-card.

I will read up on audio-graph-card and see if it's possible to use here

>
> > + * Because of the two pointer design, the ring buffer can never be ful=
l. With
> > + * capture this isn't a problem, because the hardware being the produc=
er
> > + * will wait for the consumer index to move out of the way.  With play=
back,
> > + * however, this is problematic, because ALSA wants to fill up the buf=
fer
> > + * completely when waiting for hardware. In the .ack callback, the dri=
ver
> > + * would have to wait for the consumer index to move out of the way by
> > + * busy-waiting, which would keep stalling the kernel for quite a long=
 time.
> > + *
> > + * The workaround to this problem is to "lie" to ALSA that the hw_poin=
ter
> > + * is one period behind what it actually is (see chv3_dma_pointer). Th=
is
> > + * way, ALSA will not try to fill up the entire buffer, and all callba=
cks
> > + * are wait-free.
>
> Would it not be better to just lag by one (or some small number of)
> sample instead?

The benefit of lagging by an entire period is that we get an IRQ when
the first period is processed, which means we can drop the first call
to snd_pcm_period_elapsed() and have everything be coherent.

Having said that, I did try to remove that logic and simply delay
hw_pointer by one frame, and it appears to work (the playback seems
fine and without glitches). However, I'm worried about calling
snd_pcm_period_elapsed() and then reporting that the hw_pointer hasn't
actually reached the end of the period. Is that ok to do?

>
> > +static irqreturn_t chv3_i2s_isr(int irq, void *data)
> > +{
> > +     struct chv3_i2s_dev *i2s =3D data;
> > +     u32 reg;
> > +
> > +     reg =3D readl(i2s->iobase_irq + I2S_IRQ_CLR);
> > +     if (!reg)
> > +             return IRQ_NONE;
> > +
> > +     if (reg & I2S_IRQ_RX_BIT)
> > +             snd_pcm_period_elapsed(i2s->rx_substream);
> > +
> > +     if (reg & I2S_IRQ_TX_BIT) {
> > +             if (i2s->tx_ready)
> > +                     snd_pcm_period_elapsed(i2s->tx_substream);
> > +             i2s->tx_ready =3D 1;
> > +     }
> > +
> > +     writel(reg, i2s->iobase_irq + I2S_IRQ_CLR);
> > +
> > +     return IRQ_HANDLED;
> > +}
>
> Really we should only ack things that were handled here and report
> appropriately, that's defensive against bugs causing interrupts to
> scream and shared interrupts.

What do you mean by handled? Should I check the hardware pointer and
check if a period really has elapsed?

>
> > +     dev_info(&pdev->dev, "probed\n");
>
> This is just noise, remove it.

Ok

>
> > +++ b/sound/soc/chameleonv3/chv3-it68051.c
> > @@ -0,0 +1,41 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +#include <linux/module.h>
> > +#include <sound/soc.h>
> > +
> > +static struct snd_soc_dai_driver it68051_dai =3D {
> > +     .name =3D "it68051-hifi",
> > +     .capture =3D {
> > +             .stream_name =3D "Capture",
> > +             .channels_min =3D 8,
> > +             .channels_max =3D 8,
> > +             .rates =3D SNDRV_PCM_RATE_CONTINUOUS,
> > +             .formats =3D SNDRV_PCM_FMTBIT_S32_LE,
> > +     },
> > +};
> > +
> > +static const struct snd_soc_component_driver soc_component_dev_it68051=
 =3D {
> > +};
>
> This looks awfully like it's a generic CODEC driver for a device with no
> control available,

Yes, it's a dummy capture-only codec with fixed 8 channels, arbitrary
rate, and S32_LE format.

> why is it not being added as a CODEC?

Do you mean I should put it in sound/soc/codecs/?

Also, I used the name of the HDMI receiver chip (IT68051), but really
this goes through some extra processing in an FPGA, so the result has
little in common with the chip itself. Do you have any advice on how
it should be named?

Regards,
Pawe=C5=82
