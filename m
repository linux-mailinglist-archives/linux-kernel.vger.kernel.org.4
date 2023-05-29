Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 313877150A1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 22:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjE2Uis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 16:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjE2Uir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 16:38:47 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF703C9;
        Mon, 29 May 2023 13:38:45 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-96f9cfa7eddso666030866b.2;
        Mon, 29 May 2023 13:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1685392724; x=1687984724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U1toJ4Ziiwkh6Uorqj0Y7CR8iggvNFOiNmMnjnIZtME=;
        b=jSTFRK90J4fjGPvkA2TKfJY2v4K96Gd0EFHgmeeisj5WF0B697V0YN8iDEI8dq8F2S
         BjddDb5lARn85ymxhNdSfn+wPq7QHypoBDjF/PNnq5T0OVqWPRusr3g+WMR7MSWBgJFZ
         ithPzxjE4liO2A6ntGlySxN3wZiLQlYUuAF4gnHRQOaQDq29zg9Ugjjjq9Ywcph+Eu0x
         b5t7d07GEsR9E24MlEPXWOwV/Knq1HXU3aMF+yhkSzDVdkzWWzxQz1gnTuXAp+VYFhwM
         uinEs07l7yXB7O4WcXQKa/4Obpp3VCIyclSTDBKV8oyIpcaHqiPwW8XvMRo86vBk/n67
         XR5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685392724; x=1687984724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U1toJ4Ziiwkh6Uorqj0Y7CR8iggvNFOiNmMnjnIZtME=;
        b=V2N/R9ojq/C/f8JRxNojrFsH3gQAFFYfoEuDDZ4Sqgz7M9coHAOloiyOZtHSW03lfK
         jXo5BYK1XGUqf3KZ3FFpbpxYCBx4fLEixKmp2iHWjTLnhoESzXRrUuEhOoiAvhk73FI9
         Et6U9waqC18icv7A5kQu3WJGkwUlgitC2egNx6wRqEg4b3W+2HmUNrNwkcf7ib8urWRY
         mzfW9bMcnUWsroaNyOZ1yxQKKpgZJo0m3wp7XKfQ8HUGceLkFGarGcVkxphfH03SRF0c
         NoctfvWFwJmo1k9fnf58hwziWmyWCzx3XA+bg5d3SrZrRGPDcP4Qc+Un2CaA6B0R1jXv
         ir4w==
X-Gm-Message-State: AC+VfDyeuExoZ0jK5cQDIJ9iQFJ1fFNu5o8FixES5x6+OfSpoGFP0HfQ
        KuoTP6y+Zjmaj86h4TJxfwZU+gDJ1rOEbvh2aRQ=
X-Google-Smtp-Source: ACHHUZ4UtXw5S6P31cGYC8SENa/qvkWQuSzFjsy13hgt+tpBjTHl3HQ3Xk+hjLn2wdue1VC2ihr2v8r1mi/Prs9uGvU=
X-Received: by 2002:a17:907:7fa7:b0:94f:59aa:8a7c with SMTP id
 qk39-20020a1709077fa700b0094f59aa8a7cmr409487ejc.20.1685392724055; Mon, 29
 May 2023 13:38:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230517133309.9874-1-ddrokosov@sberdevices.ru>
 <20230517133309.9874-6-ddrokosov@sberdevices.ru> <CAFBinCC3kQ9Nz3R2W-Qj9tbPJfS8JsB_4AkmPgS6xpQ96DBy2w@mail.gmail.com>
 <20230522130033.a47vlybocme66rev@CAB-WSD-L081021>
In-Reply-To: <20230522130033.a47vlybocme66rev@CAB-WSD-L081021>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 29 May 2023 22:38:33 +0200
Message-ID: <CAFBinCAk9+Km3BssA8d8nc_Z_GbhY87FD3qQRpZ2k7ChKt7TBg@mail.gmail.com>
Subject: Re: [PATCH v15 5/6] dt-bindings: clock: meson: add A1 Peripherals
 clock controller bindings
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>,
        Conor Dooley <conor.dooley@microchip.com>,
        krzysztof.kozlowski+dt@linaro.org
Cc:     neil.armstrong@linaro.org, jbrunet@baylibre.com,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        khilman@baylibre.com, jian.hu@amlogic.com, kernel@sberdevices.ru,
        rockosov@gmail.com, linux-amlogic@lists.infradead.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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

On Mon, May 22, 2023 at 3:00=E2=80=AFPM Dmitry Rokosov <ddrokosov@sberdevic=
es.ru> wrote:
[...]
> > This IP block has at least one additional input called "sys_pll_div16".
> > My understanding is that the "sys_pll_div16" clock is generated by the
> > CPU clock controller. Support for the CPU clock controller
> > (dt-bindings and a driver) will be added at a later time by Dmitry.
> > How can we manage incrementally implementing the clock controllers?
> > From a hardware perspective the "sys_pll_div16" input is mandatory.
> > How to manage this in the .dts patches then (for example: does this
> > mean that Dmitry can only add the clock controller to the .dts when
> > all clock controller bindings have been implemented - or is there
> > another way)?
>
> You're absolutely right: currently, not all inputs are supported because
> the CPU clock controller isn't ready yet =E2=80=93 I'm working on it at t=
he
> moment.
>
> I understand your concerns about bindings and schema description, but
> there is an issue to be considered. I'm developing the entire clock
> controller A1 subsystem incrementally in three stages: peripherals and
> PLL, CPU, and Audio. This is because the CPU can operate at a static
> frequency and voltage, and the board boots normally without the CPU
> clock controller, thermal sensor, and OPP table. Audio is also
> important, but it's optional. On the other hand, without setting up the
> peripherals and PLL controllers, the board won't function because
> they're fundamental.
I understand your approach and I like it (without that incremental
approach you would probably be looking at a series with 15-20
patches).

Maybe the dt-binding maintainers have a suggestion for us here?
Let me try to summarize the issue in a few bullet points:
- There's (at least) four clock controllers on the Amlogic A1 SoC
- Some of these clock controllers take the outputs of another clock
controller as inputs
- In this series patch the peripheral clock controller has an input
called "sys_pll_div16"
- The clock controller which provides the "sys_pll_div16" clock is not
implemented yet (my understanding is that implementing it and adding
it to this series is not easy: it would add even more patches that
need to be reviewed and in general it's a tricky clock controller to
implement as it manages the CPU clocks)

> Right now, we're in the first stage of the plan. Unfortunately, I can't
> disclose the exact names and number of clock bindings for the CPU and
> Audio, as they're still in development and only exist in my head or
> draft versions.
>
> If possible, I'd prefer to provide the new bindings and connections once
> all the appropriate drivers are finalized.
Question to Conor and Krzysztof (assuming you read my summary above):
Is it fine that Dmitry adds additional inputs to the peripheral clock
controller binding in later patches?
If not: how can we proceed in case we need to add them now (the
dt-binding example is the easy part for me as we can just make up a
phandle like &sys_pll_div16_clk and use that - but this can't work
when Dmitry tries to add the clock controller to meson-a1.dtsi)

PS: Dmitry is trying to get this series into Linux 6.5. As far as I
remember the common clock maintainers don't take pull requests with
new features after -rc6 (which is in less than two weeks).
So time is getting a bit short and for me this is the very last
outstanding question. If you say that it's fine to add clocks later on
this will immediately get my Reviewed-by.


Best regards,
Martin
