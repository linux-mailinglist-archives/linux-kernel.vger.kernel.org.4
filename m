Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3682E70722F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 21:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjEQT3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 15:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjEQT3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 15:29:43 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F987421D;
        Wed, 17 May 2023 12:29:12 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9659f452148so216438566b.1;
        Wed, 17 May 2023 12:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1684351749; x=1686943749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BRvTHYRcDQyfQao8yhTDxI1vIuhT47cfD0S0poHYIPw=;
        b=aaKUs+xVh6IPcai+II1QsDcFy7QmEuOBcL8lfvM2ZMJEzNacB2IHQkuwQFo0QCGlHK
         QW00Px+ItZCbV8KBn8bsHD8EPliVquZk9QbRVdqqMJD9ce45kFzugkAEkMSQDFIAr8Hq
         TTY5SIJakMLDXXvGHdu4Iu7JH4BkyRdy0NHOEA8x2GnnrMJQNcosNLJKMOnPNX2VR/M4
         upQn+bTCJMOIWcv+NjWnjoTmJi+/oPmVaC3f6fHg5t7Byq0f9TQBLMc1nDDkWYidVMRr
         Ogw9dW4cDiXa87LpOYvcYiXqHBmF2rWYCnUWB8K9viijTT0kf6KO4xuapFVmvWQdvYJL
         SKEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684351749; x=1686943749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BRvTHYRcDQyfQao8yhTDxI1vIuhT47cfD0S0poHYIPw=;
        b=dFbqDAmUcZTEszCSsniOgEceAdlmNcylUaakvK719Iv65EoXKRnHLKKVK/5w3rhw9D
         pI2MnlrTPwUSCOqGFZ699jnDpn7WC1tinoUbjf/DeMQAnQrBSF9K0JwNy2Q/6r/ga6aI
         vjNjOYQEBCL7noaw5agsouvTadKxiWdrPxUdAmXc2u3j15aYij0WbRiACYahX08hOy/S
         k/KlA3yrXx/DWyewQUNk347Q7OlR2I8SyDnyVhYFEGWR5Lv9RFhJG/59pj/zxBBm7Dua
         UyHf0UP95p7bX/lYq42XzdnA6II9MRUnnz5UCstEU3ycKBN9uarZvAxbJXk9ENXNY8cl
         gJcw==
X-Gm-Message-State: AC+VfDwGDYUez/QbmvvDdSfcX5GTMftILYSnRKH8p0ljpBeYP7Ds7v0y
        tRDtHUSSj0ddjhBfmxw64flnaj0De3Gw5csllbI=
X-Google-Smtp-Source: ACHHUZ42t7hg/BEUtpkEgle0rnmPxfNnZs3n8dHtxo3Ki6XyM3FRyzHQfUDlRC2lBpdTLCbiNHhpift3oLFUAhYhqy4=
X-Received: by 2002:a17:907:5c5:b0:959:af74:4cf7 with SMTP id
 wg5-20020a17090705c500b00959af744cf7mr37444132ejb.70.1684351749366; Wed, 17
 May 2023 12:29:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230515210545.2100161-1-gnstark@sberdevices.ru>
 <CAFBinCCc+t7Ks6fqz38cVrufPRFdxFgC9Qp+JhcM1KfD6pupTg@mail.gmail.com> <a52335ea-6545-8ca6-d318-38b7ffc64368@lexina.in>
In-Reply-To: <a52335ea-6545-8ca6-d318-38b7ffc64368@lexina.in>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Wed, 17 May 2023 21:28:58 +0200
Message-ID: <CAFBinCDmkGnD5o_rV6K73De2XmHDxRYveDwNAy3iA+Kwr5sdqg@mail.gmail.com>
Subject: Re: [PATCH v1] meson saradc: fix clock divider mask length
To:     Vyacheslav <adeep@lexina.in>,
        Dmitry Rokosov <ddrokosov@sberdevices.ru>
Cc:     George Stark <gnstark@sberdevices.ru>, jic23@kernel.org,
        lars@metafoo.de, neil.armstrong@linaro.org, khilman@baylibre.com,
        jbrunet@baylibre.com, andy.shevchenko@gmail.com,
        nuno.sa@analog.com, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@sberdevices.ru
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

Hello Vyacheslav, George and Dmitry,

On Wed, May 17, 2023 at 1:37=E2=80=AFPM Vyacheslav <adeep@lexina.in> wrote:
>
> Hi, Martin,
>
> On 16.05.2023 22:08, Martin Blumenstingl wrote:
> > Hi George,
> >
> > thank you for this patch!
> >
> > On Mon, May 15, 2023 at 11:06=E2=80=AFPM George Stark <gnstark@sberdevi=
ces.ru> wrote:
> >>
> >> From: George Stark <GNStark@sberdevices.ru>
> >>
> >> According to datasheets of supported meson SOCs
> >> length of ADC_CLK_DIV field is 6 bits long
> > I have a question about this sentence which doesn't affect this patch
> > - it's only about managing expectations:
> > Which SoC are you referring to?
>
> I checked the 905x, 905x3, a113x datasheets - there is the same register
> with 6 bits for  ADC_CLK_DIV
This highlights a common issue I have seen with Amlogic datasheets:
parts of the datasheet are outdated (or incorrect in one way or
another).
For my following explanation I will refer to the public S905X3
datasheet from [0].

The documentation for SAR_ADC_REG3 on page 1065 states that this
register contains:
- bit 30: SAR ADC_CLK_EN: 1 =3D enable the SAR ADC clock
- bits 10-15: ADC_CLK_DIV: The ADC clock is derived by dividing the
27Mhz crystal by N+1. This value divides the 27Mhz clock to generate
an ADC clock. A value of 20 for example divides the 27Mhz clock by 21
to generate an equivalent 1.28Mhz clock

The first problem with this part of the documentation is that there's
no 27MHz crystal on the Amlogic SoCs listed (S905X, S905X3), only a
24MHz one.
I'm also human, I'm not perfect so typos and mistakes happen. If you
look at the S805 datasheet (from year 2015) on page 116/117 you'll see
that even back then it said 27MHz - and even that SoC generation
(Meson8b) had a 24MHz crystal, not a 27MHz one. In over five years
that typo has not been fixed.

Let's focus on the S905X3 datasheet again, this time page 101 where it
has "Figure 7-8 AO Clock Sources".
Note that the register offsets listed in that section need to be
multiplied by 4 to get the actual offset in IO memory.
It describes the "sar_adc_clk" with:
- first mux at register 0x90 (=3D 0x24 * 4) bits [10:9] (inputs are: 0 =3D
XTAL, 1 =3D clk81, 2 and 3 are grounded)
- gate at register 0x90 (=3D 0x24 * 4) bit 8
- divider at register 0x90 (=3D 0x24 * 4) bits [7:0]
- second mux at register 0x90 (=3D 0x24 * 4) bit 0 (inputs are: 0 =3D
divider from above, 1 =3D XTAL)

Looking at drivers/clk/meson/g12a-aoclk.c this is what we implement
(apart form the second mux, which seems to be missing).
But this now gets confusing: why are there now two dividers and two
gates (one the SAR ADC registers and another on in the AO clock
controller registers)?

Looking at my board (G12A X96 Max in this case, but it's uses the same
clock controller drivers as SM1/S905X3) where &saradc is not enabled
(meaning: it uses SoC defaults or values initialized by the vendor
u-boot/TF-A):
$ grep adc /sys/kernel/debug/clk/clk_summary
   g12a_ao_saradc_mux                0        0        0    24000000
      g12a_ao_saradc_div             0        0        0     1142858
         g12a_ao_saradc_gate         0        0        0     1142858
                        g12a_ao_saradc       0        0        0   16666666=
4
                        g12a_adc       0        0        0   166666664
(output is shortened to make it easier to read)

1142858Hz is 24MHz divided by 21 (as described in the SAR ADC register
space - but these values are from the AO clock controller registers).
So my thought is: if the clock has been programmed in the AO clock
register space then the divider and gate from the SAR ADC register
space are not used (anymore) on this SoC generation.

My understanding so far (matching experiments I made long time ago) is:
- the gate and divider within the SAR ADC register space are only
relevant for SoCs that predate the GXBB generation
- SoCs starting from the GXBB SoC generation (that includes GXL, SM1,
...) use a dedicated SAR ADC clock provided by some clock controller
(see the output of $ git grep -E "sar[_]?adc" drivers/clk/meson/ |
grep name | grep -v _div | grep -v _mux | grep -v _sel)
-- I think this even applies to the A1 SoC, looking at "clk: meson:
a1: add Amlogic A1 Peripherals clock controller driver" [2] from
Dmitry the peripheral clock controller has a "saradc" clock tree (with
mux, divider, gate)

As result of my understanding meson_saradc.c will only register the
divider and gate (using meson_sar_adc_clk_init()) if no ADC clock is
provided via the .dtb.
On GXBB and newer SoCs meson_sar_adc_clk_init() is not called and the
divider and gate from the SAR ADC registers are not used.

Amlogic has debug tool IP block in these SoCs called "clock  measurer"
which can measure various clocks.
We provide a debugfs interface in
/sys/kernel/debug/meson-clk-msr/measure_summary
My suggestion is to play around with the SAR ADC clock (both, the one
from the peripheral clock controller on your SoC and the one inside
the SAR ADC registers) and see which clock has an impact on the
measured clock rate.

PS: I apologize for this long mail. I want to make clear that it's not
a rant towards you.
My thought is to share some of the experiences I made in the past.
I'm always hoping that the quality of the datasheets improves over
time. In some regards they do (a lot more IPs are documented compared
to older generations).
Missing details in the datasheet or incorrect descriptions have cost
me a lot of time previously.
My ultimate suggestion is to double check (for example with the clock
measurer, a scope, ...) what's written in the datasheet so you're not
wasting time like I did.


Best regards,
Martin


[0] https://dn.odroid.com/S905X3/ODROID-C4/Docs/S905X3_Public_Datasheet_Har=
dkernel.pdf
[1] https://dn.odroid.com/S805/Datasheet/S805_Datasheet%20V0.8%2020150126.p=
df
[2] https://lore.kernel.org/linux-amlogic/20230517133309.9874-7-ddrokosov@s=
berdevices.ru/T/#u
