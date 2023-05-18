Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3F77088FE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 22:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbjERUFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 16:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjERUFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 16:05:16 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64BB31995;
        Thu, 18 May 2023 13:04:54 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-96f5d651170so12177266b.1;
        Thu, 18 May 2023 13:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1684440293; x=1687032293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dz/8MS7Lj7KmoyyTrLm++CyIRlPD4x/waiNz5/meCus=;
        b=NjGtnN1Mekg/KnyMcY5xayEbV0Y4bnlTPJhsEXA6VcI6P1h2dUq5mFbFxefAdSmz9c
         caEhSKdDftvK2RWaQDpqdQTFAiPGq/QLm5zOlJRFTm1webNMRCKbCUAenPBxlONPShHy
         iomEz7YWfFklxSutSM2/3llf6xWuUglUNsSMj1uMYfZg3N/N7BdDOsnbBBASeQOj57pD
         iTLgABWiJ+S/cfvIrPvTwPCbEfPNC0/AMGHTu1B8P2E88NHkSTjVOzUbQrvGvTrllBTV
         9u8VVLx+IgiK8uQZepaIs5+Cu0hr5Ctu5A0pVJhvpae8XiFBx488/OCWC8QHsyQLXpEr
         qEGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684440293; x=1687032293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dz/8MS7Lj7KmoyyTrLm++CyIRlPD4x/waiNz5/meCus=;
        b=laSlJNQyOmnZptBJvUBlc4axLZCKjcmAHKxWAG08GgmK9gwPPAoeiyTA8bD94U6hKi
         ZZHc7lmsbbqVVPkMn5KsNXo7VJCHfCJgh2xAGNTGOY+q5x/Y8my/KkOk0hUt7hslFn6e
         lciGuwl5pVkuetmhFQ6wClbkHYjm88paR9VAbRKhRts28e1zGYTGRuqV5l3gAIjoNB8m
         S4UTp05SemnfSyyXM1g9gzHSkZn3VpQMF3oN1OifTFuUZfhdNmQhiShxex5p49Y8jnOz
         71mnr/iIlqUFs7nYP7aRzDRMjBi0MyZ7eTNUGbrh4c1JLiL+Tml5jyoBHmuYC7j+0E+Y
         6JKA==
X-Gm-Message-State: AC+VfDz7exBOPY6y+PmH0v3A+ihpOS3WSKKYq4KZ8Wsh7NA9uhSxi8x5
        X3PpCVFTvUnSFgKs9BDypG2EVz2fc6fjT5DZaZk=
X-Google-Smtp-Source: ACHHUZ4EBOtGVUrAip758uCZF+1h1aLN/sSTVQIUSACMMRvnCSHys6SxptJuy+0OrMe//0KPdz+gDV+lTDKBFqM4vWU=
X-Received: by 2002:a17:907:3f17:b0:94f:1d54:95d2 with SMTP id
 hq23-20020a1709073f1700b0094f1d5495d2mr7161796ejc.15.1684440292615; Thu, 18
 May 2023 13:04:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230426095805.15338-1-ddrokosov@sberdevices.ru>
 <20230426095805.15338-7-ddrokosov@sberdevices.ru> <CAFBinCA2OhtVaCJDi8ZfAFLSE4oUgxYBDScaP_WW63curEK8Mg@mail.gmail.com>
 <20230512140630.qd33rwzaalmadpmk@CAB-WSD-L081021> <CAFBinCA8e9evk+9hTEgoNOD_+3DBst6vYDcradmr2c996jdUmw@mail.gmail.com>
 <20230517103456.p3sjxzbepvg7cr2r@CAB-WSD-L081021>
In-Reply-To: <20230517103456.p3sjxzbepvg7cr2r@CAB-WSD-L081021>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 18 May 2023 22:04:41 +0200
Message-ID: <CAFBinCCPf+asVakAxeBqV-jhsZp=i2zbShByTCXfYYAQ6cCnHg@mail.gmail.com>
Subject: Re: [PATCH v14 6/6] clk: meson: a1: add Amlogic A1 Peripherals clock
 controller driver
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>
Cc:     neil.armstrong@linaro.org, jbrunet@baylibre.com,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, khilman@baylibre.com,
        jian.hu@amlogic.com, kernel@sberdevices.ru, rockosov@gmail.com,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Heiner Kallweit <hkallweit1@gmail.com>
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

Hi Dmitry,

On Wed, May 17, 2023 at 12:34=E2=80=AFPM Dmitry Rokosov
<ddrokosov@sberdevices.ru> wrote:
[...]
> > > Additionally, the CCF determines the best ancestor based on how close
> > > its rate is to the given one, based on arithmetic calculations. Howev=
er,
> > > we have independent knowledge that a certain clock would be better, w=
ith
> > > less jitter and fewer intermediaries, which will likely improve energ=
y
> > > efficiency. Sadly, the CCF cannot take this into account.
> > I agree that the implementation in CCF is fairly simple. There's ways
> > to trick it though: IIRC if there are multiple equally suitable clocks
> > it picks the first one. For me all of this has worked so far which is
> > what makes me curious in this case (not saying that anything is wrong
> > with your approach).
> >
> > Do you have a (real world) example where the RTC clock should be
> > preferred over another clock?
> >
>
> Yes, a real-life example is the need for a 32Khz clock for an external
> wifi chip. There is one option to provide this clock with high
> precision, which is RTC + GENCLK.
>
> > I'm thinking about the following scenario.
> > PWM parents:
> > - XTAL: 24MHz
> > - sys: not sure - let's say 166.67MHz
> > - RTC: 32kHz
> >
> > Then after that there's a divider and a gate.
> >
> > Let's say the PWM controller needs a 1MHz clock: it can take that from
> > XTAL or sys. Since XTAL is evenly divisible to 1MHz CCF will pick that
> > and use the divider.
> > But let's say the PWM controller needs a 32kHz clock: CCF would
> > automatically pick the RTC clock.
> > So is your implementation there to cover let's say 1kHz where
> > mathematically 24MHz can be divided evenly to 1kHz (and thus should
> > not result in any jitter) but RTC gives better precision in the real
> > world (even though it's off by 24Hz)?
> >
>
> I don't think so. The highest precision that RTC can provide is from a
> 32KHz rate only. However, I believe that a 1kHz frequency can also be
> achieved by using xtal 24MHz with a divider, which can provide high
> precision as well.
Thank you again for the great discussion on IRC today.
Here's my short summary so I don't forget before you'll follow up on this.

In general there's two known cases where the RTC clock needs to be used:
a) When using the GENCLK output of the SoC to output the 32kHz RTC
clock and connect that to an SDIO WiFi chip clock input (this seems
useful in my understanding because the RTC clock provides high
precision)
b) When using the PWM controller to output a 32kHz clock signal. In
this case my understanding is that using the RTC clock as input to the
PWM controller results in the best possible signal

The second case won't be supported with Heiner's patches [0] that use
CCF (common clock framework) in the PWM controller driver.
In this series the parent clock is calculated using:
  freq =3D div64_u64(NSEC_PER_SEC * (u64)0xffff, period);

A 32kHz clock means a PWM period of 30518ns. So with the above
calculation the PWM driver is asking for a clock rate of >=3D2GHz.
We concluded that letting the common clock framework choose the best
possible parent (meaning: removing CLK_SET_RATE_NO_REPARENT here) can
be a way forward.
But this means that the PWM controller driver must try to find the
best possible parent somehow. The easiest way we came up with
(pseudo-code):
  freq =3D NSEC_PER_SEC / period;
  fin_freq =3D clk_round_rate(channel->clk, freq);
  if (fin_freq !=3D freq) {
    freq =3D div64_u64(NSEC_PER_SEC * (u64)0xffff, period);
    fin_freq =3D clk_round_rate(channel->clk, freq);
  }

The idea is: for a requested 32kHz signal the PWM period is 30518ns.
The updated logic would find that there's a matching clock input and
use that directly. If not: use the original logic as suggested by
Heiner.


Best regards,
Martin


[0] https://lore.kernel.org/linux-amlogic/9faca2e6-b7a1-4748-7eb0-48f8064e3=
23e@gmail.com/
