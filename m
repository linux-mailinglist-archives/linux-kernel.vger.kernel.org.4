Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 650556D7D95
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 15:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238245AbjDENVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 09:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238110AbjDENVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 09:21:36 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A1534ECD
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 06:21:22 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id bl22so12607028oib.11
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 06:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680700881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TlUcOE1BWnhXxNvaAkG+YBndpq/Z21sxjqeG7esxmKQ=;
        b=OhZgGAwN9sViQISVkUgRT9P5e0BiRr6RXmMYLsxDYsBrHs2ap5JZRQER1K2IstxMZw
         jFFoO7PxzdW+oGB8uLDg3ZUQu0hpRK8g3KzalBC1/Eq/rQyhZFU5MOMgMGNSXKU/KBLb
         O9dHKMK7/4G2iU2gxGhe6S70/rqqMWqq727Vgrah8GroFrAULpm7VqeLzWfuUXlpjjEc
         moRBUckbg9vgLKh9U2CFzrkpzbD8jpuCSoYzpJ+hktuUcqjRlvDKgx1GqrriwJBzKtEB
         A5F+rWL86JzaOljLiZ0bSpZtKu7hmvEjrGFYQU1ESSgQqjcfLCVkq+s1ttNoiuTEnGtV
         48XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680700881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TlUcOE1BWnhXxNvaAkG+YBndpq/Z21sxjqeG7esxmKQ=;
        b=fgFE349n1COQmgRGCKKDgfyRzeEUCa71gdTo1nUGugZ1awxsGShYowcmdIosccrBvh
         By5tWkLNVNJW0R9o/pA8dfesxYMV4rBrKRUx+xCaafRwfM6nDH+S/lkl9DY9bopIuUBa
         tXore5NmrkPVSREPGpbBLkBexTsCQTiTwBZig7TW8ZO4qmjHlLFLUolftWN0IzMTbj72
         5ganrsM3iZR/fm5healEYTuiLzo5o69YPUxDRDUobFYGJqnh2lDpHFXTfz75sZDZRp/U
         HhuZpLQ02OUfXqKT3WGdZG1UPX35XE2mKUObFKXrOxW/66nOCBFF0ZPNu2ygeyDB5K39
         fpfA==
X-Gm-Message-State: AAQBX9fSGZQGcIbs+oAG8SqX44zelRvDIOspUO8cGqHBMYnFT6BZuqSo
        Sg3JVZ5QnLThrwur/D1v+N4F7fSsdVYRwGsK2ssIRMu466s=
X-Google-Smtp-Source: AKy350ZfcLWs74fVo0iWe4XUuKr5rQ9HzNpGJeqo4GtRCcVKjoYub/c3Np3+YDtnyGiY1GIbGNwJcimmCL66qHi9i4U=
X-Received: by 2002:a05:6808:2198:b0:389:8dad:7832 with SMTP id
 be24-20020a056808219800b003898dad7832mr1925703oib.8.1680700880011; Wed, 05
 Apr 2023 06:21:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAPJMGm4GaSjD6bdqMwCr2EVZGenWzT-nCCf3BMRaD1TSfAabpA@mail.gmail.com>
 <6d58a58cd7e8a7cbb91b2658e9a85b44b34b64dc.camel@gmail.com>
In-Reply-To: <6d58a58cd7e8a7cbb91b2658e9a85b44b34b64dc.camel@gmail.com>
From:   Fabrizio Lamarque <fl.scratchpad@gmail.com>
Date:   Wed, 5 Apr 2023 15:20:49 +0200
Message-ID: <CAPJMGm5WxnmtyW2DnZe4rSUFJ-KtKGmNsf7pStcaK=4suBHWuw@mail.gmail.com>
Subject: Re: iio: ad7192: Pending IRQ on SDO/RDY causing retrigger of
 interrupt handler and missing every sample
To:     =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>
Cc:     alexandru.tachici@analog.com, linux-kernel@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>
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

On Wed, Apr 5, 2023 at 12:30=E2=80=AFPM Nuno S=C3=A1 <noname.nuno@gmail.com=
> wrote:
> On Wed, 2023-04-05 at 11:53 +0200, Fabrizio Lamarque wrote:
> > Link:
> > https://lore.kernel.org/all/20210906065630.16325-3-alexandru.tachici@an=
alog.com/
> >
> > This commit broke the driver functionality, i.e. cat in_voltage1_raw
> > triggers a correct sampling sequence only the first time, then it
> > always returns the first sampled value.
> >
> > Following the sequence of ad_sigma_delta_single_conversion() within
> > ad_sigma_delta.c, this is due to:
> >
> > - IRQ resend mechanism is always enabled for ARM cores
> > (CONFIG_HARDIRQS_SW_RESEND)
> > - Edge IRQs are always made pending when a corresponding event
> > happens, even after disable_irq(). This is intentional and designed to
> > prevent missing signal edges.
> > - Level IRQs are not impacted by IRQ resend (i.e. IRQ_PENDING is
> > always cleared).
> > - SPI communication causes the IRQ to be set pending (even if
> > corresponding interrupt is disabled)
> > - The second time ad_sigma_delta_single_conversion() is called,
> > enable_irq() will trigger the interrupt immediately, even if RDY line
> > is high.
> > - In turn, this causes the call
> > wait_for_completion_interruptible_timeout() to exit immediately, with
> > RDY line still high.
> > - Right after the SPI register read, the MODE register is written with
> > AD_SD_MODE_IDLE, and pending conversion is stopped. Hence DATA
> > register is never updated.
> >
> > I would suggest to revert this commit or set the flag with
> > IRQF_TRIGGER_LOW instead of IRQF_TRIGGER_FALLING, but I am not sure
> > about the problem solved by this commit and how to replicate it.
> > Another option would be to keep IRQ flags within bindings only.
> >
>
> I'm starting to think that what's stated in that commit
>
> "Leaving IRQ on level instead of falling might trigger a sample read
> when the IRQ is enabled, as the SDO line is already low. "
>
> might actually be related with something else...

Hi Nuno S=C3=A1,
 thank you again for your replies and the time you are spending in checking
the reported issues.
I see what you mean...
I was asking for details on the actual issue that was solved to have a bett=
er
understanding of the change.

>
> > As a side note, AD7192 datasheet says that the falling edge on SDO
> > line _can_ be used as an interrupt to processor, but it also states
> > that the _level_ on SDO/RDY line indicates the sample is ready. What
> > happens on SDO/RDY interrupt line before the ADC conversion is
> > triggered should be ignored.
> >
>
> Well, from the datasheet (as you already know):
>
> "
> In addition, DOUT/RDY operates as a data ready pin, going low to indicate
> the completion of a conversion. If the data is not read after the convers=
ion,
> the pin goes high before the next
> update occurs. The DOUT/RDY falling edge can be used as an interrupt to a
> processor, indicating that valid
> data is available.
> "
>
> So I really read IRQF_TRIGGER_FALLING in the above and all the other sigm=
a
> delta devices have the same setting (I think). So the fact that it works =
with
> level IRQs might just be lucky instead of fixing the real problem. Can yo=
u try
> the below patch (I'm starting to think it might be related):
>

We have been using those ADC series for about a decade, the shared SDO/RDY
signal has its own quirks.
We also discussed several years ago in a support ticket with ADI, both
level and edge
sensing should be acceptable, provided that limitations are understood.

>
> https://lore.kernel.org/linux-iio/20230306044737.862-1-honda@mechatrax.co=
m/

I just tested the patch, but, at least on the platform I'm working on
(I.MX6), it does not
solve the issue.
Whereas the thread describes the very same issue I am experiencing, I
am not sure
IRQ_DISABLE_UNLAZY would have any impact. By reading CPU registers I see
the IRQ line disabled at the hardware level, but when the IRQ flag of
the processor
is set (and this happens even if the interrupt is masked in HW), the
interrupt is immediately
triggered anyway.
(I see GPIOx_IMR cleared, so interrupt is masked, but GPIOx_ISR set. As soo=
n as
enable_irq() is called the interrupt is triggered. Just by clearing
GPIOx_ISR before
enable_irq() solves the issue. I might share a few debug printk).

The "real issue" here is that we have a pending IRQ on the RDY line set
even if IRQ is disabled (masked) at the hardware level.
It does not happen for level sensing interrupts.

This link might further clarify why this should be intentional:
https://www.kernel.org/doc/html/latest/core-api/genericirq.html#delayed-int=
errupt-disable
(note that I see the IRQ masked at the hardware level anyway, but it
does not prevent
the described behavior to happen)

In case the interrupt flag has to be IRQF_TRIGGER_FALLING, it might be viab=
le to
enable the IRQ before the measurement is requested and eventually
ignore any spurious
interrupt until the measurement is started (SPI write completed).

Fabrizio Lamarque
