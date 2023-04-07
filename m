Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5B6A6DAA74
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 10:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232968AbjDGIwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 04:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbjDGIwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 04:52:12 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC69F1B3
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 01:52:10 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id j4-20020a4adf44000000b0053e8b5524abso3784954oou.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 01:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680857530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kJZxot62JOSej969q6PSfFmebw+oo/Xio/wW4Igq0lg=;
        b=O7d0Afbgr8PwSY2GbsUnGBsZh4ojdWZqoeWCwargbaLuWccPDDryDkKPfFBIg4CEUF
         Fn/mx1qANcDroKlF2TP4Cl45dxdJnMjcImLn/goiYD3GY+GG2PQ0ttWoYOaPA2NGTPW8
         c6NBSRHfDH9DbQConpLh6aqmP3xsgST3qW2FRrllFfimBb5PkJkvYx3aaUUEWkDM4gCV
         BDwtXrbdNeTkQbJhYV/tGx5yfgRL6MswPlw4ld8rAlOfsReuWNn1UzA23ALeAInt60/7
         lFlVKp2Kwb11YFPSOJ0GAVZuKt2wYbNEFdMN7wpL5am3beC97c6//P4wW1fDc4y2p0DU
         xzUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680857530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kJZxot62JOSej969q6PSfFmebw+oo/Xio/wW4Igq0lg=;
        b=eD5aFmEY9gq3a6yDwxv3IVCxJobL45WOVD9Z00OuA1Zhqfbu4xz2jT+UbBgLGJCo6X
         CeqOd09oMasQ74t5BM1TQobf4nvezpUb+oQNfhtHtPe6/tzu4nbQao+932428w6U3H4j
         1oVVf+Pwj7DTKVBCGWWaaMXdSnOkozBAvVKMoSzfBiyIl8ay8PdRb4pAiGlAk3M6M0aY
         x5MiVDISF731e6djBGEYg3kZIuCCiKZiREcK14CaRaMTd20MVtzBZ/adqXpFF82B0KnR
         kAiIFMwi8lInZvaxOyQfQEAwJ7bsZTwTVmXE++bY/8uy8SSPUXE4myL/Yn7qO2pwyaSe
         L1tg==
X-Gm-Message-State: AAQBX9c+9qxRqulcttNycR0v6PJD41Wr1kpz3FZLqF8oZGPquQWRgd9X
        SArV0ZwLh5C/yRzvINAsQuTVElxqTpYXoMJr4vf4P9SX9LE=
X-Google-Smtp-Source: AKy350axlo447k4ExaqTaR0Kt5a8d3WB5M1eeg7f9A98fAsq0B7qhPx9jemkc76PSu45caWsJPzcdYqAcN/OvkF2l00=
X-Received: by 2002:a4a:e2d6:0:b0:53b:4e0a:6714 with SMTP id
 l22-20020a4ae2d6000000b0053b4e0a6714mr342782oot.0.1680857530066; Fri, 07 Apr
 2023 01:52:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAPJMGm4GaSjD6bdqMwCr2EVZGenWzT-nCCf3BMRaD1TSfAabpA@mail.gmail.com>
 <6d58a58cd7e8a7cbb91b2658e9a85b44b34b64dc.camel@gmail.com>
 <CAPJMGm5WxnmtyW2DnZe4rSUFJ-KtKGmNsf7pStcaK=4suBHWuw@mail.gmail.com>
 <3c5f31cf533ef26ea586e2d18b31995541a95411.camel@gmail.com> <f57b8e3d-4382-015e-743b-8663c55d9f84@metafoo.de>
In-Reply-To: <f57b8e3d-4382-015e-743b-8663c55d9f84@metafoo.de>
From:   Fabrizio Lamarque <fl.scratchpad@gmail.com>
Date:   Fri, 7 Apr 2023 10:51:59 +0200
Message-ID: <CAPJMGm6qcPG1DpuAunz8vGz_LHfpMZmr=i06qcXJRJuAyc84GQ@mail.gmail.com>
Subject: Re: iio: ad7192: Pending IRQ on SDO/RDY causing retrigger of
 interrupt handler and missing every sample
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>,
        linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 5, 2023 at 4:35=E2=80=AFPM Lars-Peter Clausen <lars@metafoo.de>=
 wrote:
>
> On 4/5/23 06:49, Nuno S=C3=A1 wrote:
> > [...]
> > I just tested the patch, but, at least on the platform I'm working on
> > (I.MX6), it does not
> > solve the issue.
> > Whereas the thread describes the very same issue I am experiencing, I
> > am not sure
> > IRQ_DISABLE_UNLAZY would have any impact. By reading CPU registers I se=
e
> > I was expecting to have. AFAIU, the lazy approach would be the responsi=
ble for
> > this behavior because when you call disable_irq() it does not really ma=
sk the
> > IRQ in HW. Just marks it as disabled and if another IRQ event comes set=
's it to
> > PENDING and only then masks at HW level... If we "unlazy" the IRQ, we s=
hould
> > mask the IRQ right away so I would expect not to have any pending IRQ..=
.
> >
> >> the IRQ line disabled at the hardware level, but when the IRQ flag of
> >> the processor
> >> is set (and this happens even if the interrupt is masked in HW), the
> >> interrupt is immediately
> >> triggered anyway.
> >> (I see GPIOx_IMR cleared, so interrupt is masked, but GPIOx_ISR set. A=
s soon
> >> as
> >> enable_irq() is called the interrupt is triggered. Just by clearing
> >> GPIOx_ISR before
> >> enable_irq() solves the issue. I might share a few debug printk).
>
> This sounds to me that the GPIO driver should implement an
> `irq_enable()` callback where it clears the pending bits before
> unmasking. This is consistent with what other GPIO IRQ drivers do.
>

Hello Lars,
 thank you for your comments and for having a look at this.

I am not really confident in dissecting how ARM interrupt management
and NXP specific features. However, he "Delayed Interrupt" feature in
kernel documentation (specific to ARM interrupt implementation),
"prevents losing edge interrupts on hardware which does not store an
edge interrupt event while the interrupt is disabled at the hardware
level". This feature is always enabled for any ARM core.
Indeed, NXP hardware _stores_ the GPIO edge interrupt when the IRQ is
disabled. While not explicitly written in kernel docs, to my limited
understanding enable_irq() should not clear the pending edge IRQ
(eventually occurred when interrupt was disabled).
I do not see anything that clearly does not conform to documentation
in how IRQs are being managed.

> the driver was written with the assumption that
> irq_disable() will stop recording of IRQ events. If that does not hold
> we might have to switch from irq_enable/irq_disable to
> request_irq/free_irq, which will come with a slight overhead.

request_irq/free_irq should clear the interrupt flags.
However, since this change might have side effects on other ADI ADC
drivers and trigger functionality, I'd be unable to provide a valid
and verified patch (but I could test a proposed patch on my platform).

In order to give you a better understanding of the issue, I am
providing a simple log here.

Here are the GPIO registers involved (only relevant bits are masked):

ICR =3D Edge sensitivity (3 =3D FALLING)
ISR =3D Interrupt status register (1 =3D DETECTED) independent of IMR
IMR =3D Interrupt mask register, 1 =3D ENABLED, 0 =3D MASKED
STATUS =3D IRQ status/config register, IRQ_DISABLE_UNLAZY (20th bit) is set
STATE =3D internal interrupt state, IRQS_PENDING (10th bit) is never set
COMPLETION =3D done flag of completion

Here is what happens within ad_sigma_delta_single_conversion() function:

# cat in_voltage1_raw <-- First conversion
[ 1001.540803] ad_sigma_delta_single_conversion() entry
[ 1001.540837] ICR =3D 3, IMR =3D 0, ISR =3D 0, STATUS =3D 80402h, STATE =
=3D
4000h, COMPLETION =3D 0
[ 1001.545849] ad_sigma_delta_set_channel() before ad_sigma_delta_set_chann=
el()
[ 1001.569456] ICR =3D 3, IMR =3D 0, ISR =3D 0, STATUS =3D 80402h, STATE =
=3D
4000h, COMPLETION =3D 0
[ 1001.569700] ad_sigma_delta_set_channel() before ad_sigma_delta_set_mode(=
)
[ 1001.586455] ICR =3D 3, IMR =3D 0, ISR =3D 0, STATUS =3D 80402h, STATE =
=3D
4000h, COMPLETION =3D 0
[ 1001.595279] ad_sigma_delta_set_channel() before enable_irq()
[ 1001.604869] ICR =3D 3, IMR =3D 0, ISR =3D 0, STATUS =3D 80402h, STATE =
=3D
4000h, COMPLETION =3D 0
[ 1001.612409] ad_sigma_delta_set_channel() before
wait_for_completion_interruptible_timeout()
[ 1001.621859] ICR =3D 3, IMR =3D 1, ISR =3D 0, STATUS =3D 80402h, STATE =
=3D
4000h, COMPLETION =3D 0
[ 1001.997637] ad_sd_data_rdy_trig_poll() entry
[ 1002.005523] ad_sd_data_rdy_trig_poll() before disable_irq_nosync()
[ 1002.009805] ad_sd_data_rdy_trig_poll() before iio_trigger_poll()
[ 1002.015994] ad_sd_data_rdy_trig_poll() exit
[ 1002.026725] ad_sigma_delta_set_channel() before ad_sd_read_reg()
[ 1002.031136] ICR =3D 3, IMR =3D 0, ISR =3D 0, STATUS =3D 80402h, STATE =
=3D
4000h, COMPLETION =3D 0
[ 1002.037382] ad_sigma_delta_set_channel() before ad_sigma_delta_set_mode(=
)
[ 1002.048902] ICR =3D 3, IMR =3D 0, ISR =3D 1, STATUS =3D 80402h, STATE =
=3D
4000h, COMPLETION =3D 0
[ 1002.057685] ad_sigma_delta_set_channel() exit
[ 1002.067249] ICR =3D 3, IMR =3D 0, ISR =3D 1, STATUS =3D 80402h, STATE =
=3D
4000h, COMPLETION =3D 0
8304626

# cat in_voltage1_raw <-- Any following conversion
[ 1003.968784] ad_sigma_delta_single_conversion() entry
[ 1003.971193] ICR =3D 3, IMR =3D 0, ISR =3D 1, STATUS =3D 80402h, STATE =
=3D
4000h, COMPLETION =3D 0
[ 1003.976224] ad_sigma_delta_set_channel() before ad_sigma_delta_set_chann=
el()
[ 1003.989727] ICR =3D 3, IMR =3D 0, ISR =3D 1, STATUS =3D 80402h, STATE =
=3D
4000h, COMPLETION =3D 0
[ 1003.998723] ad_sigma_delta_set_channel() before ad_sigma_delta_set_mode(=
)
[ 1004.008524] ICR =3D 3, IMR =3D 0, ISR =3D 1, STATUS =3D 80402h, STATE =
=3D
4000h, COMPLETION =3D 0
[ 1004.017512] ad_sigma_delta_set_channel() before enable_irq()
[ 1004.027031] ICR =3D 3, IMR =3D 0, ISR =3D 1, STATUS =3D 80402h, STATE =
=3D
4000h, COMPLETION =3D 0
[ 1004.034409] ad_sd_data_rdy_trig_poll() entry
[ 1004.042280] ad_sd_data_rdy_trig_poll() before disable_irq_nosync()
[ 1004.046560] ad_sd_data_rdy_trig_poll() before iio_trigger_poll()
[ 1004.052747] ad_sd_data_rdy_trig_poll() exit
[ 1004.063603] ad_sigma_delta_set_channel() before
wait_for_completion_interruptible_timeout()
[ 1004.067981] ICR =3D 3, IMR =3D 0, ISR =3D 0, STATUS =3D 80402h, STATE =
=3D
4000h, COMPLETION =3D 1
[ 1004.079159] ad_sigma_delta_set_channel() before ad_sd_read_reg()
[ 1004.088709] ICR =3D 3, IMR =3D 0, ISR =3D 0, STATUS =3D 80402h, STATE =
=3D
4000h, COMPLETION =3D 0
[ 1004.096793] ad_sigma_delta_set_channel() before ad_sigma_delta_set_mode(=
)
[ 1004.106339] ICR =3D 3, IMR =3D 0, ISR =3D 1, STATUS =3D 80402h, STATE =
=3D
4000h, COMPLETION =3D 0
[ 1004.115121] ad_sigma_delta_set_channel() exit
[ 1004.124737] ICR =3D 3, IMR =3D 0, ISR =3D 1, STATUS =3D 80402h, STATE =
=3D
4000h, COMPLETION =3D 0
8304626

The first time there is a delay on wait_for_completion_interruptible_timeou=
t().
In the second throw the interrupt function is called as soon as
enable_irq() is executed, completion is already set before entering
the wait state.
You may see the ISR register gets set again after ad_sd_read_reg(),
and this is the only relevant difference between the two sequences.

Unless you have any other suggestions, I will send three simpler
patches relevant to this driver, and leave to you the changes required
to overcome the issue described here.
In any case, I am available to test it on my side.


Fabrizio
