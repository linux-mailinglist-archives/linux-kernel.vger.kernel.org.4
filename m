Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6F5B6D7E06
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 15:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237974AbjDENrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 09:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237221AbjDENrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 09:47:53 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF174C17
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 06:47:50 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id eg48so141125380edb.13
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 06:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680702469;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GuBc2rPen6ylZPpt+wuUfxI61otblpotXwWwZDmixBA=;
        b=q6upT29a4JQLBMIxgFmKYVXHPZxKsY/lFGiCLgEqCD9PD7dogANSnHM8oHeX92e308
         pW7VBNxhsM0na+Bez//0Vlm4qBu4bKPXTYMtJb31KdsqS7u7lg7pGX8dlZTWJdCmTXnI
         q5f6PNmxsSYtFu4YSyX3WLkYS4/F8H9x4C40KjndfBV91AeM9VjvgjbCUwknjIJBl/kN
         S6OwD1Gxo4ZAmBQAioMGtcoM4EdBhqZkiFouDBdjkcUzmhfS+NYTUlNwdw5+7DzrTxDJ
         kPpb3lV8JSvv8s79f3C8vUTiUNIxh3jte//gUKgDTOK6huOqPJd8xjuXW45LGjehcKnV
         +fLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680702469;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GuBc2rPen6ylZPpt+wuUfxI61otblpotXwWwZDmixBA=;
        b=MCg+oR8DIw/BSvY9SVC5fNVJk8pks0bsZ9LeKayZhH4NiATLfWWWp9tVAfgokCG4mD
         vQ85o04Jqmt0oGytxp132Mkli7GeRXfzg7MlmlYHhVh3WSvXF6SJ1UW/2SgqjgqYriZ1
         6pKAc+jo/2bQwoLh6b8V8BEOaF9xpxHaLTnkn6BW2vpFtmRVMqPepR69Jz7PX4sNQezA
         /q/mys62xe2Fm6vTG/Qmhdfm0VYXe7JJdbpJQnbGtfYBDDqekDRK4fGyfPBYhvYLcEXB
         l9ru0Flg1pTQ2Yi8DGB4PAeoOpj8C9gSRH4LlkgBypGBDjGgkqn2WTGiAvZOe0XP/Ptq
         bsSg==
X-Gm-Message-State: AAQBX9eP+xv83RtZ4Buzn6TiuX93YchZ7j2iD/SKetEBKD7FWxgfmJVD
        3q5liIk6zRzjacLuZw6C2pRQvNLgGst8bTyw
X-Google-Smtp-Source: AKy350ZgSAjnmMPbXSowxlZobENqBOiU99r4zCQNLw92AwduSPEDiATSwdkmD1rClmvVud7y/nuG9w==
X-Received: by 2002:a17:906:8503:b0:947:71cf:7c97 with SMTP id i3-20020a170906850300b0094771cf7c97mr2089825ejx.36.1680702468539;
        Wed, 05 Apr 2023 06:47:48 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef05:8700:853c:3ba5:d710:3c1d? (p200300f6ef058700853c3ba5d7103c1d.dip0.t-ipconnect.de. [2003:f6:ef05:8700:853c:3ba5:d710:3c1d])
        by smtp.gmail.com with ESMTPSA id i12-20020a170906a28c00b00946e6dd887csm7311725ejz.126.2023.04.05.06.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 06:47:48 -0700 (PDT)
Message-ID: <3c5f31cf533ef26ea586e2d18b31995541a95411.camel@gmail.com>
Subject: Re: iio: ad7192: Pending IRQ on SDO/RDY causing retrigger of
 interrupt handler and missing every sample
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Fabrizio Lamarque <fl.scratchpad@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Date:   Wed, 05 Apr 2023 15:49:54 +0200
In-Reply-To: <CAPJMGm5WxnmtyW2DnZe4rSUFJ-KtKGmNsf7pStcaK=4suBHWuw@mail.gmail.com>
References: <CAPJMGm4GaSjD6bdqMwCr2EVZGenWzT-nCCf3BMRaD1TSfAabpA@mail.gmail.com>
         <6d58a58cd7e8a7cbb91b2658e9a85b44b34b64dc.camel@gmail.com>
         <CAPJMGm5WxnmtyW2DnZe4rSUFJ-KtKGmNsf7pStcaK=4suBHWuw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-04-05 at 15:20 +0200, Fabrizio Lamarque wrote:
> On Wed, Apr 5, 2023 at 12:30=E2=80=AFPM Nuno S=C3=A1 <noname.nuno@gmail.c=
om> wrote:
> > On Wed, 2023-04-05 at 11:53 +0200, Fabrizio Lamarque wrote:
> > > Link:
> > > https://lore.kernel.org/all/20210906065630.16325-3-alexandru.tachici@=
analog.com/
> > >=20
> > > This commit broke the driver functionality, i.e. cat in_voltage1_raw
> > > triggers a correct sampling sequence only the first time, then it
> > > always returns the first sampled value.
> > >=20
> > > Following the sequence of ad_sigma_delta_single_conversion() within
> > > ad_sigma_delta.c, this is due to:
> > >=20
> > > - IRQ resend mechanism is always enabled for ARM cores
> > > (CONFIG_HARDIRQS_SW_RESEND)
> > > - Edge IRQs are always made pending when a corresponding event
> > > happens, even after disable_irq(). This is intentional and designed t=
o
> > > prevent missing signal edges.
> > > - Level IRQs are not impacted by IRQ resend (i.e. IRQ_PENDING is
> > > always cleared).
> > > - SPI communication causes the IRQ to be set pending (even if
> > > corresponding interrupt is disabled)
> > > - The second time ad_sigma_delta_single_conversion() is called,
> > > enable_irq() will trigger the interrupt immediately, even if RDY line
> > > is high.
> > > - In turn, this causes the call
> > > wait_for_completion_interruptible_timeout() to exit immediately, with
> > > RDY line still high.
> > > - Right after the SPI register read, the MODE register is written wit=
h
> > > AD_SD_MODE_IDLE, and pending conversion is stopped. Hence DATA
> > > register is never updated.
> > >=20
> > > I would suggest to revert this commit or set the flag with
> > > IRQF_TRIGGER_LOW instead of IRQF_TRIGGER_FALLING, but I am not sure
> > > about the problem solved by this commit and how to replicate it.
> > > Another option would be to keep IRQ flags within bindings only.
> > >=20
> >=20
> > I'm starting to think that what's stated in that commit
> >=20
> > "Leaving IRQ on level instead of falling might trigger a sample read
> > when the IRQ is enabled, as the SDO line is already low. "
> >=20
> > might actually be related with something else...
>=20
> Hi Nuno S=C3=A1,
> =C2=A0thank you again for your replies and the time you are spending in c=
hecking
> the reported issues.
> I see what you mean...
> I was asking for details on the actual issue that was solved to have a be=
tter
> understanding of the change.
>=20

Yeah, Alex is no longer in ADI so I cannot really say.=20

> >=20
> > > As a side note, AD7192 datasheet says that the falling edge on SDO
> > > line _can_ be used as an interrupt to processor, but it also states
> > > that the _level_ on SDO/RDY line indicates the sample is ready. What
> > > happens on SDO/RDY interrupt line before the ADC conversion is
> > > triggered should be ignored.
> > >=20
> >=20
> > Well, from the datasheet (as you already know):
> >=20
> > "
> > In addition, DOUT/RDY operates as a data ready pin, going low to indica=
te
> > the completion of a conversion. If the data is not read after the
> > conversion,
> > the pin goes high before the next
> > update occurs. The DOUT/RDY falling edge can be used as an interrupt to=
 a
> > processor, indicating that valid
> > data is available.
> > "
> >=20
> > So I really read IRQF_TRIGGER_FALLING in the above and all the other si=
gma
> > delta devices have the same setting (I think). So the fact that it work=
s
> > with
> > level IRQs might just be lucky instead of fixing the real problem. Can =
you
> > try
> > the below patch (I'm starting to think it might be related):
> >=20
>=20
> We have been using those ADC series for about a decade, the shared SDO/RD=
Y
> signal has its own quirks.
> We also discussed several years ago in a support ticket with ADI, both
> level and edge
> sensing should be acceptable, provided that limitations are understood.

> >=20
> > https://lore.kernel.org/linux-iio/20230306044737.862-1-honda@mechatrax.=
com/
>=20
> I just tested the patch, but, at least on the platform I'm working on
> (I.MX6), it does not
> solve the issue.
> Whereas the thread describes the very same issue I am experiencing, I
> am not sure
> IRQ_DISABLE_UNLAZY would have any impact. By reading CPU registers I see

I was expecting to have. AFAIU, the lazy approach would be the responsible =
for
this behavior because when you call disable_irq() it does not really mask t=
he
IRQ in HW. Just marks it as disabled and if another IRQ event comes set's i=
t to
PENDING and only then masks at HW level... If we "unlazy" the IRQ, we shoul=
d
mask the IRQ right away so I would expect not to have any pending IRQ...

> the IRQ line disabled at the hardware level, but when the IRQ flag of
> the processor
> is set (and this happens even if the interrupt is masked in HW), the
> interrupt is immediately
> triggered anyway.
> (I see GPIOx_IMR cleared, so interrupt is masked, but GPIOx_ISR set. As s=
oon
> as
> enable_irq() is called the interrupt is triggered. Just by clearing
> GPIOx_ISR before
> enable_irq() solves the issue. I might share a few debug printk).
>=20

Might be that the problem is actually in the behavior of the above controll=
er?
As said, I would expect a masked IRQ not to be handled and set to PENDING.

> The "real issue" here is that we have a pending IRQ on the RDY line set
> even if IRQ is disabled (masked) at the hardware level.
> It does not happen for level sensing interrupts.
>=20
> This link might further clarify why this should be intentional:
> https://www.kernel.org/doc/html/latest/core-api/genericirq.html#delayed-i=
nterrupt-disable
> (note that I see the IRQ masked at the hardware level anyway, but it
> does not prevent
> the described behavior to happen)
>=20
> In case the interrupt flag has to be IRQF_TRIGGER_FALLING, it might be vi=
able
> to
> enable the IRQ before the measurement is requested and eventually
> ignore any spurious
> interrupt until the measurement is started (SPI write completed).
>=20

Oh no, that looks like just going around the real problem. It would be
interesting to test this in some other platforms to see if the behavior is =
the
same... I guess now is the time to fully understand this. IIRC, originally
everything was set as LEVEL but since the datasheet states EDGE should be u=
sed,
Alex moved the flags to EDGE.

Maybe you're also right and we should just remove the flags and let users d=
ecide
in the bindings whatever works best for their platforms given the fact that=
 it
appears that both LEVEL vs EDGE can be used.

Anyways,

+cc Lars since he was the original developer on the sigma delta stuff and m=
aybe
he remembers something about this level vs edge mess.

Lars, can you shed some light :)?

- Nuno S=C3=A1

