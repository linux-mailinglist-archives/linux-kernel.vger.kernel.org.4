Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD0C66ABD5
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 15:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjANOAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 09:00:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjANOAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 09:00:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08FD37EE2;
        Sat, 14 Jan 2023 06:00:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B501DB801BC;
        Sat, 14 Jan 2023 14:00:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B00BAC433EF;
        Sat, 14 Jan 2023 14:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673704816;
        bh=j5g4HVHgfd9O2azlo9le3jP0JXaZdZG7oHalhx+Ujto=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=In2lUTFkDZVNPHeFajfgbloT2pb7KnLRAa+kAGeYMatnaemnbC2YsticOAmaUjC2B
         mzvh1IqPYvDKcuPDHa2BCqUteFVZE4o0OQWx0KbOGe0uVsrbyDgUCPGdF4NbOacIco
         G/UgBWwr7zpIR7O5fokR0aBxVHwKFH1jIHZsSv3GiXqLCTvVn7YNJIld1IkaqwxX7R
         2NKu5bXVvChFUXC5NVjnoc4AnCITr2/+wfEnGXdR/PjBVp6GYrycBCEjyPkOfup+VN
         YBd4SWK5kAH/lesXXd4yZ7L1FcYMgNf5WY09weSFJgwmpiPNCZS9MvnKq9lCZcUZuh
         WMWNdDqR653WA==
Date:   Sat, 14 Jan 2023 14:00:11 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Jessica Clarke <jrtc27@jrtc27.com>
Cc:     Nylon Chen <nylon.chen@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        nylon7717@gmail.com, zong.li@sifive.com, greentime.hu@sifive.com,
        vincent.chen@sifive.com, Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org
Subject: Re: [PATCH 0/2] Change PWM-controlled LED pin active mode and
 algorithm
Message-ID: <Y8K1a+xs6tbo7kV4@spud>
References: <20230113083115.2590-1-nylon.chen@sifive.com>
 <Y8GjySjm9OjoZvCF@spud>
 <95F1EAA0-D8D6-4F8A-8049-5E7BFDE4C06C@jrtc27.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="of/qOxrkjJckIcNO"
Content-Disposition: inline
In-Reply-To: <95F1EAA0-D8D6-4F8A-8049-5E7BFDE4C06C@jrtc27.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--of/qOxrkjJckIcNO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jess!

On Fri, Jan 13, 2023 at 07:24:56PM +0000, Jessica Clarke wrote:
> On 13 Jan 2023, at 18:32, Conor Dooley <conor@kernel.org> wrote:
> >=20

> > Please run scripts/get_maintainer.pl before sending patches, you missed
> > both me & the PWM maintainers unfortunately!
> > AFAIK, the PWM maintainers use patchwork, so you will probably have to
> > resend this patchset so that it is on their radar.
> > I've marked the series as "Changes Requested" on the RISC-V one.
> >=20
> > On Fri, Jan 13, 2023 at 04:31:13PM +0800, Nylon Chen wrote:
> >=20
> >> According to the circuit diagram of User LEDs - RGB described in the
> >> manual hifive-unmatched-schematics-v3.pdf[0].
> >> The behavior of PWM is acitve-high.
> >>=20
> >> According to the descriptionof PWM for pwmcmp in SiFive FU740-C000
> >> Manual[1].
> >> The pwm algorithm is (PW) pulse active time  =3D (D) duty * (T) period=
[2].
> >> The `frac` variable is pulse "inactive" time so we need to invert it.
> >>=20
> >> So this patchset removes active-low in DTS and adds reverse logic to
> >> the driver.
> >>=20
> >> [0]:https://sifive-china.oss-cn-zhangjiakou.aliyuncs.com/HiFIve%20Unma=
tched/hifive-unmatched-schematics-v3.pdf
> >> [1]:https://sifive-china.oss-cn-zhangjiakou.aliyuncs.com/HiFIve%20Unma=
tched/fu740-c000-manual-v1p2.pdf
> >> [2]:https://en.wikipedia.org/wiki/Duty_cycle
> >=20
> > Please delete link 2, convert the other two to standard Link: tags and
> > put this information in the dts patch. Possibly into the PWM patch too,
> > depending on what the PWM maintainers think.
> > This info should be in the commit history IMO and the commit message for
> > the dts patch says what's obvious from the diff without any explanation
> > as to why.
> >=20
> > I did a bit of looking around on lore, to see if I could figure out
> > why it was done like this in the first place, and I found:
> > https://lore.kernel.org/linux-pwm/CAJ2_jOG2M03aLBgUOgGjWH9CUxq2aTG97eSX=
70=3DUaSbGCMMF_g@mail.gmail.com/
>=20
> That DTS documentation makes no sense to me, why does what the LED is
> wired to matter?

```
      active-low:
        description:
          For PWMs where the LED is wired to supply rather than ground.
```

> Whether you have your transistor next to ground or
> next to Vdd doesn=E2=80=99t matter, what matters is whether the transisto=
r is
> on or off. Maybe what they mean is whether the *PWM's output* / *the
> transistor's input* is pulled to ground or Vdd? In which case the
> property would indeed not apply here.
>=20
> Unless that=E2=80=99s written assuming the LED is wired directly to the P=
WM, in
> which case it would make sense, but that=E2=80=99s a very narrow-minded v=
iew of
> what the PWM output is (directly) driving.

I would suspect that it was written with that assumption.
Probably was the case on the specific board this property was originally
added for.

Maybe it'd be a bit more foolproof written as "For LEDs that are
illuminated while the PWM output is low. For example, where an LED is
wired between supply and the PWM output."?


--of/qOxrkjJckIcNO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY8K1awAKCRB4tDGHoIJi
0lgxAP4hB+7DUE8j4BKkTPybh8vNvj8FYzyy6lynwdQzbIwx3AEAmc4f040KlMA6
xAIlIswmTGM3YxuxLp8Pi4DirdJ6Nwo=
=n/JS
-----END PGP SIGNATURE-----

--of/qOxrkjJckIcNO--
