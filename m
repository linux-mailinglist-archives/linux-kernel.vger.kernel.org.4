Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CBA162BD45
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 13:11:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233881AbiKPMLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 07:11:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233170AbiKPMLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 07:11:10 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB485DFF6;
        Wed, 16 Nov 2022 04:04:41 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id 8so11438956qka.1;
        Wed, 16 Nov 2022 04:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7kQBKNV0cOa4OzouSvUwnWH9zCXJ/iuh5yp7bEft2hk=;
        b=oc/Ge4fbtvwtgjkWC0ADHF1tkt/ZYPk738jTFO2gGw4xhr8XkwCl8mhIePqDBiBfxd
         4XEx7jP8vozlXfWJpel8iXiBDeCeQRKJHeNE8O3Z/SESmoiUY1pyO0hMt0q4wQ3fTQrX
         KyEmdjIryWHZrlb5LX5qhtqKmhXAYZ/Hny2CN8vGQ1YIylm/ch0BSwHKNEXJMSrGnVRG
         eXhYmqposEuOQriAVGUrpPwze2CHl8zr/VZXNTZXdDxlXekJZSQopB8F9S719GuV9ROn
         G+zdVaA5GUfQp9VWTA7r0P4MIoqSz5O6aJp7rDfHmS4i+TBTnuynZ+ykKDCVLtFFbAPb
         jmoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7kQBKNV0cOa4OzouSvUwnWH9zCXJ/iuh5yp7bEft2hk=;
        b=ccOzNmxbevlcIPlOKs/Nfp0sLblCz4XtjyTixVCpR87g8MLGJJp31RaD/lkqyURu9T
         p6N+Kgi5kClxi3nF1hNauMfXBvMPsnytHP6syNtTE/OQxfdLqK5BD5Il8djO+GVhuErH
         FSyMajQZ79ljvWv45KTx7gY3lCSODyuL0ZqLSWGmLPWn2SF53gAYiQbzH9X3QaukltG2
         PCJbHb4QHRQKcILQ4YzVQ7d9XLRuuIlt/GUUe0Ioy6hdTmR8FOAdpBS8bmkyXbhbEaM2
         fxQX2fwwbXTw9cG0CudBhZTAmcR1r6NISYWj7JZ5+Xf7Kg4H0mvvMYbsNjPu6Ry3qfkq
         LxtA==
X-Gm-Message-State: ANoB5pkWdZO2Z8hfnda9oPasCxT/XqpphntTzKXO7zRIuHQLqHsOPvzn
        Oi0vCMlUJ7prS9qnH7V2PyE=
X-Google-Smtp-Source: AA0mqf4IsdMbE7wcCK5wXl+q4KwRfHLZFZgH/Qvo90TjYUIMQsunRTbStCyG6Vj2e7LdpByfDNsAjw==
X-Received: by 2002:a05:620a:a19:b0:6fa:189d:733b with SMTP id i25-20020a05620a0a1900b006fa189d733bmr18701467qka.20.1668600280979;
        Wed, 16 Nov 2022 04:04:40 -0800 (PST)
Received: from p200300f6ef036f005de6a4d0d791ed01.dip0.t-ipconnect.de (p200300f6ef036f005de6a4d0d791ed01.dip0.t-ipconnect.de. [2003:f6:ef03:6f00:5de6:a4d0:d791:ed01])
        by smtp.gmail.com with ESMTPSA id h2-20020ac85042000000b003a606428a59sm1235921qtm.91.2022.11.16.04.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 04:04:40 -0800 (PST)
Message-ID: <e8029fde1b6e5b7d93ffd298e2012a7a35402692.camel@gmail.com>
Subject: Re: [PATCH 5/5] iio: addac: ad74413r: add support for reset-gpio
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        "Tanislav, Cosmin" <Cosmin.Tanislav@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Wed, 16 Nov 2022 13:06:09 +0100
In-Reply-To: <20221116102200.00003d16@Huawei.com>
References: <20221111143921.742194-1-linux@rasmusvillemoes.dk>
         <20221111143921.742194-6-linux@rasmusvillemoes.dk>
         <20221112170705.7efe1673@jic23-huawei>
         <095a454b55cf497392a621649f24e067@analog.com>
         <20221114194447.2528f699@jic23-huawei>
         <0d6b3e4047df9f560079a562bc167bd7a0bf2d28.camel@gmail.com>
         <20221115161052.00002633@Huawei.com>
         <6d76cc6d-9db7-5b18-e4f1-dc220b3929a3@rasmusvillemoes.dk>
         <20221116102200.00003d16@Huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-11-16 at 10:22 +0000, Jonathan Cameron wrote:
> On Tue, 15 Nov 2022 20:10:53 +0100
> Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:
>=20
> > On 15/11/2022 17.10, Jonathan Cameron wrote:
> > > On Tue, 15 Nov 2022 15:49:46 +0100
> > > Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
> > > =C2=A0=20
> > > > On Mon, 2022-11-14 at 19:44 +0000, Jonathan Cameron wrote:=C2=A0=
=20
> > > > > On Mon, 14 Nov 2022 13:52:26 +0000
> > > > > "Tanislav, Cosmin" <Cosmin.Tanislav@analog.com> wrote:
> > > > > =C2=A0=C2=A0=C2=A0=20
> > > > > > >=20
> > > > > > > I'm a little confused on polarity here.=C2=A0 The pin is a
> > > > > > > !reset so
> > > > > > > we need to drive it low briefly to trigger a reset.
> > > > > > > I'm guessing for your board the pin is set to active low?
> > > > > > > (an
> > > > > > > example
> > > > > > > in the dt would have made that clearer) Hence the pulse
> > > > > > > in here to 1 is actually briefly driving it low before
> > > > > > > restoring
> > > > > > > to high?
> > > > > > >=20
> > > > > > > For a pin documented as !reset that seems backwards
> > > > > > > though you
> > > > > > > have
> > > > > > > called it reset so that is fine, but this description
> > > > > > > doesn't
> > > > > > > make that
> > > > > > > celar.=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
> > > > > >=20
> > > > > > My opinion is that the driver shouldn't exactly know the
> > > > > > polarity
> > > > > > of the reset,
> > > > > > and just assume that setting the reset GPIO to 1 means
> > > > > > putting it
> > > > > > in reset,
> > > > > > and setting it to 0 means bringing out of reset.=C2=A0=C2=A0=C2=
=A0=20
> > > > >=20
> > > > > Agreed. I'd just like a comment + example in the dt-binding
> > > > > to make
> > > > > the point
> > > > > that the pin is !reset.
> > > > >=20
> > > > > Preferably with an example in the dt binding of the common
> > > > > case of it
> > > > > being wired
> > > > > up to an active low pin.
> > > > >=20
> > > > > The main oddity here is the need to pulse it rather than
> > > > > request it
> > > > > directly as
> > > > > in the reset state and then just set that to off.
> > > > >=20
> > > > > =C2=A0=C2=A0=C2=A0=20
> > > >=20
> > > > Agreed... In theory we should be able to request the gpio with
> > > > GPIOD_OUT_HIGH and then just bring the device out of reset=C2=A0=
=20
> > >=20
> > > If I recall correctly the datasheet specifically calls out that a
> > > pulse
> > > should be used.=C2=A0 No idea if that's actually true, or if it was
> > > meant
> > > to be there just to say it needs to be set for X nsecs.=C2=A0=20
> >=20
> > So the data sheet says
> >=20
> > =C2=A0 The hardware reset is initiated by pulsing the RESET pin low. Th=
e
> > RESET pulse width must comply with the specifications in Table 11.
> >=20
> > and table 11 says that the pulse must be min 50us, max 1ms. We
> > don't
> > really have any way whatsoever to ensure that we're not rescheduled
> > right before pulling the gpio high again (deasserting the reset),
> > so the
> > pulse could effectively be much more than 1ms. But I have a hard
> > time
> > believing that that actually matters (i.e., what state would the
> > chip be
> > in if we happen to make a pulse 1234us wide?).
>=20
> Test it maybe?=C2=A0 Otherwise we'd have to play games to do it again if
> the
> timing was too long to ensure after a couple of goes we do get a
> suitable
> width pulse.
>=20
> > But what might be
> > relevant, and maybe where that 1ms figure really comes from, can
> > perhaps
> > be read in table 10, which lists a "device reset time" of 1ms, with
> > the
> > description
> >=20
> > =C2=A0 Time taken for device reset and calibration memory upload to
> > complete
> > hardware or software reset events after the device is powered up
> >=20
> > so perhaps we should ensure a 1ms delay after the reset (whether we
> > used
> > the software or gpio method). But that would be a separate fix IMO
> > (and
> > I'm not sure we actually need it).
> >=20
> > I don't mind requesting the gpio with GPIOD_OUT_HIGH, but I'd still
> > keep
> > the gpiod_set_value(, 1) in the reset function, otherwise it's a
> > bit too
> > magic for my taste.
>=20
> Without testing I'd worry that it really does need a pulse so
> probably better
> to leave it doing so.=20
>=20

Yeah, without testing maybe better to play safe. But, FWIW, what I read
from the datasheet is just another typical reset gpio usage with more
(fancy/confusing) description.

- Nuno S=C3=A1

