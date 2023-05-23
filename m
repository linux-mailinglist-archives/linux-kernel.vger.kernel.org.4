Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4C470E67D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 22:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237946AbjEWUbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 16:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233535AbjEWUbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 16:31:53 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2256BB;
        Tue, 23 May 2023 13:31:51 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-96f50e26b8bso5748966b.2;
        Tue, 23 May 2023 13:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684873910; x=1687465910;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gyIulyRW1hakaxkcxJ5p2tW7ghUvSVPa0n0AL3J553M=;
        b=bN1sBcW/GoLtdz1AW/dagSVOrYJ0CSaLrfBuAQ6hLK28+DW6UBqyG+OQ0sDwtC6gtK
         dXki79QofT3YpzNC7oK71qKF3WFPxyVLxdsyF4FY8dtb8G4lnJfIy706nbl+aog3Teon
         O6FFYwbNXbdDPH+HaINYaVKg7ogMEenkQt6tG60D1fsjUTbU/wBR6xcwYCBWkFiDnioq
         Wdiqv4XvRujFrMTHrFrxgamSuHpQvzZ4QVZrrdrwO7c0kqU+5y1B/7ziJxGY4+45SJuL
         oSZ+vjqlTyL6CQVIncOMruBS/AQvKb9LRDiYvDOdS5hxFS55sAQH7DMrtZT5PwtwkURd
         JHdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684873910; x=1687465910;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gyIulyRW1hakaxkcxJ5p2tW7ghUvSVPa0n0AL3J553M=;
        b=DAaRqaMaJZK4xKA9fc16oMh6SuMBVOvjdgiHCLvnp9X9WZ0/09ZKAAGRJTtgPE/JTF
         n3f7Do6QtTkDsDnR6B6WXZWg3+0JKLR/rhtJ9F1fw2suDUn6LOTsd2Wh9uCg1q26imxl
         CK25mDYyE2g7osr2PsZ9tifL9q+dynrfo+LrDgNlxGRUhljjb0F5d05dCdb4bPinaBFj
         XJMRLgyKc4k5aoAPFyTP/uj7abTXc54C1rwu6niOjRaSZC9UlKZ1FyS7Zt4DueihmjlH
         Q2F+uHlhkJKyZZ+loYTajvRHiC5OhCuwLQOGcgCcdgLjBegMc1bA46MagFhZ8ofru/zk
         kdZA==
X-Gm-Message-State: AC+VfDw5hpGQ1ipa6p5j9cZY6SVyKZPt+NoufMX1FbphhUDoYd3eveI6
        XfYtViH3BM2IVVRelyy0Uhs=
X-Google-Smtp-Source: ACHHUZ4VhXZISRRKrd47rr7Fq88SbTtOHjVxtBMPgU7IxqYa//M8lQMhMP8o6U0F5B8xVSM83AlOMg==
X-Received: by 2002:a17:907:25cd:b0:96f:45cd:6c21 with SMTP id ae13-20020a17090725cd00b0096f45cd6c21mr12894790ejc.30.1684873909972;
        Tue, 23 May 2023 13:31:49 -0700 (PDT)
Received: from orome (p200300e41f305300f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f30:5300:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id 16-20020a170906101000b00965ffb8407asm4745519ejm.87.2023.05.23.13.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 13:31:49 -0700 (PDT)
Date:   Tue, 23 May 2023 22:31:48 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Peter Rosin <peda@axentia.se>, LKML <linux-kernel@vger.kernel.org>,
        linux-pwm@vger.kernel.org,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Conor Dooley <conor.dooley@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: Re: PWM regression causing failures with the pwm-atmel driver
Message-ID: <ZG0itIIg48IGuC8R@orome>
References: <7e2cfb55-e39f-2e5c-7f43-e1d275428bb5@axentia.se>
 <20230522172358.bw677efyovbrfwjg@pengutronix.de>
 <abe0b7f7-19de-605b-e1b1-c62930052894@axentia.se>
 <20230522204346.krb37yyzylxokslx@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="WpjSotNzALEbIBBv"
Content-Disposition: inline
In-Reply-To: <20230522204346.krb37yyzylxokslx@pengutronix.de>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WpjSotNzALEbIBBv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 22, 2023 at 10:43:46PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> Hello Peter,
>=20
> On Mon, May 22, 2023 at 09:28:39PM +0200, Peter Rosin wrote:
> > 2023-05-22 at 19:23, Uwe Kleine-K=C3=B6nig wrote:
> > > On Mon, May 22, 2023 at 05:19:43PM +0200, Peter Rosin wrote:
> > >> I have a device with a "sound card" that has an amplifier that needs
> > >> an extra boost when high amplification is requested. This extra
> > >> boost is controlled with a pwm-regulator.
> > >>
> > >> As of commit c73a3107624d ("pwm: Handle .get_state() failures") this
> > >> device no longer works. I have tracked the problem to an unfortunate
> > >> interaction between the underlying PWM driver and the PWM core.
> > >>
> > >> The driver is drivers/pwm/pwm-atmel.c which has difficulties getting
> > >> the period and/or duty_cycle from the HW when the PWM is not enabled.
> > >> Because of this, I think, the driver does not fill in .period and
> > >> .duty_cycle at all in atmel_pwm_get_state() unless the PWM is enable=
d.
> > >>
> > >> However, the PWM core is not expecting these fields to be left as-is,
> > >> at least not in pwm_adjust_config(), and its local state variable on
> > >> the stack ends up with whatever crap was on the stack on entry for
> > >> these fields. That fails spectacularly when the function continues to
> > >> do math on these uninitialized values.
>=20
> After looking again, I don't understand that part. Note that
> pwm_get_state() doesn't call .get_state() at all. Also pwmchip_add()
> zero initializes .state, then pwm_get() calls .get_state() (via
> pwm_device_request() which is called in .xlate()) which (if the HW is
> disabled) doesn't touch .period, so it should continue to be zero?!
>=20
> So I wonder why your approach 2 works at all. Do you see what I'm
> missing?
>=20
> > >> In particular, I find this in the kernel log when a bad kernel runs:
> > >> pwm-regulator: probe of reg-ana failed with error -22
> > >>
> > >> Before commit c73a3107624d this was a silent failure, and the situat=
ion
> > >> "repaired itself" when the PWM was later reprogrammed, at least for =
my
> > >> case. After that commit, the failure is fatal and the "sound card"
> > >> fails to come up at all.
> > >>
> > >>
> > >> I see a couple of adjustments that could be made.
> > >>
> > >> 1. Zero out some fields in the driver:
> > >>
> > >> @@ -390,4 +390,6 @@ static int atmel_pwm_get_state(struct pwm_chip *=
chip, struct pwm_device *pwm,
> > >>  		state->enabled =3D true;
> > >>  	} else {
> > >> +		state->period =3D 0;
> > >> +		state->duty_cycle =3D 0;
> > >>  		state->enabled =3D false;
> > >>  	}
> > >=20
> > > I don't particularily like that. While state->period is an invalid
> > > value, IMHO enabled =3D false is enough information from the driver's=
 POV.
> >=20
> > This was the preferred approach of Thierry, and given the number of
> > call sites for pwm_get_state with a local variable, I can sympathize
> > with that view.
>=20
> I looked a bit more into the issue and think that pwm_get_state() isn't
> problematic. pwm_get_state() fully assigns *state.
>=20
> > At the same time, fixing drivers one by one is not
> > a fun game, so I can certainly see that approach 3 also has an appeal.
>=20
> What I don't like about it is that the output of a disabled PWM doesn't
> have a period. There might be one configured in hardware(, and the
> .get_state() callback might or might not return that), but the emitted
> signal has no well-defined period.

Well, this is a bit of a gray area, admittedly. .get_state() was not
designed with regards to drivers that are unable to read the hardware
state. Essentially if you can't read the full hardware state, the
assumption was that you just shouldn't provide a .get_state() callback
at all.

In retrospect that's perhaps not ideal, and as you pointed out this is
all a bit moot as of v6.3 because the initial state is now effectively
zeroed out already.

But just to address your point about enabled =3D false being enough: it's
not. The reason is that consumers should be able to do something along
these lines:

	pwm_get_state(pwm, &state);
	state.enabled =3D true;
	pwm_apply_state(pwm, &state);

And expect the device to do something reasonable. If the PWM isn't
properly configured, that pwm_apply_state() should return an error. If
->get_state() returned random values, that may not be guaranteed. With
v6.3, the above should return -EINVAL for pwm-atmel because period ends
up being 0 and we check for that explicitly. And that's really the only
sane behavior for drivers that can't read back the full hardware state.

Again, since we have this in the core that should be good enough. But it
is still something that drivers need to be aware about. If you can't
determine a real value from hardware readout, period and duty-cycle
should be zeroed out so that consumers don't end up applying garbage
values accidentally.

Thierry

--WpjSotNzALEbIBBv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmRtIrEACgkQ3SOs138+
s6EHsg/8DbLHBm0U+xDpCnDi9N/onI44zfGC5FH70Gglg1st9nNPxnx16EjwwvvZ
X7juPU/P8AwDf76byj2bxzPXZiTHdZjzfOqQVffGsYCK1FQttsllh/Vrj7wYoYrD
nOOZ/kBqDhrpwFNyOvv+iRZFty4MvD3JvLpdikoPm7UCraHRGImwyVmoUCN/Kd3p
/7CALd39C2T1vXfgSRQ2RwLBnQqAHo+8dD6DOyq3jakDzl/lj3QyTVltvjcYqtoq
V42HeAemocoi3JVK29/IK4Wq26GLKKW1r7VlNi0oB5V6fLRd5pYMVSIZc2hpRKqZ
4vMckGLH6dJH/sFdnwlr8PlKrIUwmIEabVk5+v83SbW4rYfzcawAsKkwodCCrJGj
87tl+tHl/fBxC0pvJzyVHNAcxLMAEZidJacDAdqU/Oypn8jOyqrHafyUquDHySh6
obd6Iofhi5eqIxyX8XC9IFarU4W0fy1mCqvyOVKAyPSogzyLQDWLx4OMt95guqT0
bqFXHgk4uT3VtBC83k4ShSDnxjcTvj3xtPEXWp+bwCX8UJ7+kZrvmZlt4jTZJIPq
PcoTSwGPSLsGl+8piPLEOFdOP0VsAV5yrPFtp9d4XYk8au1mysKZlUfOSMn+IJvk
82AraiL3WrxujBgLirVTzkLiDM/+ztu9/zktz0aA+ZxHGYdy/yM=
=u3i/
-----END PGP SIGNATURE-----

--WpjSotNzALEbIBBv--
