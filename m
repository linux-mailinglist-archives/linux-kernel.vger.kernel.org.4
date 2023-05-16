Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E370970594D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 23:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbjEPVKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 17:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbjEPVKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 17:10:38 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA0B72A0;
        Tue, 16 May 2023 14:10:32 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-965e4be7541so2568146866b.1;
        Tue, 16 May 2023 14:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1684271430; x=1686863430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n73A5ikyqINLnlDhqbTvCi+0kCGqHkJ94IeKapmahoE=;
        b=LhJ8iLFLtcCAuCR6l9IHP15t2tujl1me7wzUyl/h2h7LaxKrnYgA/fP7z/ZChEWxKV
         muDNAeYJLCcJUTWrEAdbD2N1cckJQYPGjbomLonDRrjLb6NM96Jete/RDYf9GTTuCHiS
         dsl/R57+DKVsFpO9vEyYvLuqOqg5yWG+dWO6zo6szGMQHCMtAKSadHIolidfi0tsnqym
         S1c0kRMJDMbTdc4FS0MnIM2kHgksv1XdXMQxFJKLo0h3zFGzbCChpkxYgMCNGtPwR4Sp
         ZF+NrCw7aD1zrsB7KJfpe+l4QcB1yZ1BfCIAQ/NSSU6T+1HG7dyzSVdf8jQvKGVWkN56
         dL1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684271430; x=1686863430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n73A5ikyqINLnlDhqbTvCi+0kCGqHkJ94IeKapmahoE=;
        b=JfkkL0dWxOC2Pw9pvlMP3JLa2Q860NB3i1mVL49WH1zflB1guRveKK2zgN1V54UmKh
         nM+d7QDbiZjhbZd6PtNqMDcj8QbtP3MJGdY1r2C1P7CY+ssDPTxH99vRxn9GwGpwd8uE
         tpBWvil4qOXXYojMz8VUjcwdNLxCQd6FQTjfJydsBKERMcAESegdvTOpfvMpdulGUL7K
         BPSJbhaq2sanvb/7/GrhIid8Z9EqkbdofUO/2tHy4fPr7lzF1wayc9f4Z+GChM5cmxBk
         Qr9ZjOhU8DD6ZOFoS8CxGffCTZeAoeOKJZw+EuQtuV5PXlb/3en+3qT/K1FfBn+IQC1i
         hV+w==
X-Gm-Message-State: AC+VfDxJxVWdT+6dhXiD4XuY9f/Z9vUTKLiRiR1XVYXcEVtPewc28bud
        4U0E7DCOnBdIPxwtI87pJVs9FYMe0fr5YMjMI8Q=
X-Google-Smtp-Source: ACHHUZ7VwJQ7m6uMhLM8YPBx9yE/to5sr9FgMcI7tXUUErTzps4roK4BFliZIW0ptbv7CVPU+2WGGuadwAU5jqQGePs=
X-Received: by 2002:a17:907:9694:b0:96a:1ec1:2c9f with SMTP id
 hd20-20020a170907969400b0096a1ec12c9fmr23981423ejc.12.1684271430372; Tue, 16
 May 2023 14:10:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230426095805.15338-1-ddrokosov@sberdevices.ru>
 <20230426095805.15338-7-ddrokosov@sberdevices.ru> <CAFBinCA2OhtVaCJDi8ZfAFLSE4oUgxYBDScaP_WW63curEK8Mg@mail.gmail.com>
 <20230512140630.qd33rwzaalmadpmk@CAB-WSD-L081021>
In-Reply-To: <20230512140630.qd33rwzaalmadpmk@CAB-WSD-L081021>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 16 May 2023 23:10:19 +0200
Message-ID: <CAFBinCA8e9evk+9hTEgoNOD_+3DBst6vYDcradmr2c996jdUmw@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dmitry,

On Fri, May 12, 2023 at 4:06=E2=80=AFPM Dmitry Rokosov <ddrokosov@sberdevic=
es.ru> wrote:
[...]
> > > +static struct clk_regmap pwm_a_sel =3D {
> > > +       .data =3D &(struct clk_regmap_mux_data){
> > > +               .offset =3D PWM_CLK_AB_CTRL,
> > > +               .mask =3D 0x1,
> > > +               .shift =3D 9,
> > > +       },
> > > +       .hw.init =3D &(struct clk_init_data){
> > > +               .name =3D "pwm_a_sel",
> > > +               .ops =3D &clk_regmap_mux_ops,
> > > +               .parent_data =3D pwm_abcd_parents,
> > > +               .num_parents =3D ARRAY_SIZE(pwm_abcd_parents),
> > > +               /* For more information, please refer to rtc clock */
> > > +               .flags =3D CLK_SET_RATE_NO_REPARENT,
> > Heiner is working on a series that adds common clock support to the
> > PWM driver [0].
> > I think his plans for a next step are adding support for SoCs where
> > the PWM clocks are part of the peripheral clock controller (instead of
> > being part of the PWM controller registers).
> >
>
> Yes, I'm keeping up with this review and staying informed. It's worth
> noting that the peripheral clock driver already includes PWM clocks,
> with an important remark about reparenting being switched off. It's
> described below.
Indeed, this is why this question came to my mind

> > Have you considered removing CLK_SET_RATE_PARENT from the &rtc clock
> > so downstream clocks won't change the rtc clock rate by accident?
> > Then we could drop the CLK_SET_RATE_NO_REPARENT flag from the PWM
> > clocks to allow them to pick the best available parent (whether that's
> > the rtc clock, xtal or sys_pll).
> > That said, it would require managing the CLKID_RTC_32K_SEL clock (or
> > it's parents) using assigned-clocks instead of doing so with the PWM
> > (and other) clocks. Whether this would cause problems: I'm not sure,
> > so I'm hoping that you can share some insights.
> >
> >
>
> Allow me to share my thoughts on this matter. From my understanding,
> Amlogic provides an RTC clock that is both accurate and power-effective
> in achieving a 32KHz signal from an internal xtal of 24MHz. However,
> this requires a complex RTC divider with four parameters (m1, m2, n1,
> n2), as it cannot be accomplished with a single divider. Our team has
> measured the RTC clock using an oscilloscope on the GEN CLK pin and
> found that it provides a stable 32KHz signal with acceptable jitter. On
> the other hand, other approaches, such as the PWM way, yield less stable
> and less accurate 32KHz signals with greater jitter.
This part is clear to me (we may have even chatted on IRC how to use
the GEN CLK output previously)

> Additionally, the CCF determines the best ancestor based on how close
> its rate is to the given one, based on arithmetic calculations. However,
> we have independent knowledge that a certain clock would be better, with
> less jitter and fewer intermediaries, which will likely improve energy
> efficiency. Sadly, the CCF cannot take this into account.
I agree that the implementation in CCF is fairly simple. There's ways
to trick it though: IIRC if there are multiple equally suitable clocks
it picks the first one. For me all of this has worked so far which is
what makes me curious in this case (not saying that anything is wrong
with your approach).

Do you have a (real world) example where the RTC clock should be
preferred over another clock?

I'm thinking about the following scenario.
PWM parents:
- XTAL: 24MHz
- sys: not sure - let's say 166.67MHz
- RTC: 32kHz

Then after that there's a divider and a gate.

Let's say the PWM controller needs a 1MHz clock: it can take that from
XTAL or sys. Since XTAL is evenly divisible to 1MHz CCF will pick that
and use the divider.
But let's say the PWM controller needs a 32kHz clock: CCF would
automatically pick the RTC clock.
So is your implementation there to cover let's say 1kHz where
mathematically 24MHz can be divided evenly to 1kHz (and thus should
not result in any jitter) but RTC gives better precision in the real
world (even though it's off by 24Hz)?

> Given the advantages of the RTC clock, we wish to be able to control the
> RTC as a parent for specific leaf clocks. This is achievable with the
> 'assigned-clocks' feature of CCF OF, but it poses a significant
> architectural problem. The 'assigned-clocks' node does not lock/pin the
> parent, and a simple clk_set_rate() call can change the parent during
> rate propagation.
Are you aware of clk_set_rate_exclusive() and clk_rate_exclusive_{get,put}(=
)?
It locks a clock and all of its parents to a certain rate. Other
consumers are unable to change the rate unless the lock is released
again.

> In my opinion, an ideal solution to this problem would
> be an additional patch to the CCF core that provides this locking
> capability.As a board DTS developer, I know which clock I want to use
> as the parent and have a strong reason for doing so, and I do not wish
> to open up my parent muxing to other drivers. But until the behavior of
> 'assigned-clocks' is not available, we will simply label all RTC
> children with the CLK_SET_RATE_NO_REPARENT flag.

PS: while writing this reply I found
drivers/clk/sunxi-ng/ccu-sun6i-rtc.c which implements
clk_ops.recalc_accuracy
I'm not sure I understand this correctly but it seems that CCF is not
using that information when making the decision which parent to use.


Best regards,
Martin
