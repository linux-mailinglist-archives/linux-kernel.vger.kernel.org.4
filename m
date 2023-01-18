Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE626716BA
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 09:59:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjARI7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 03:59:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjARI5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 03:57:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D9815CE5A;
        Wed, 18 Jan 2023 00:13:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4BF83B81A3D;
        Wed, 18 Jan 2023 08:13:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63BA3C433F0;
        Wed, 18 Jan 2023 08:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674029634;
        bh=SYTtZk6ZSgVx/WFOeJ0MBaOx5z4XpMo/GMukzlopQ7k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RZ+gqP708YJcXRbNEKgEOJgh4FsiLreIMg4DIMMZcpCcXbV9MfVlW4027owp82HOb
         NtCFsnWqhVM5aJjqL47BJuPrd0dhRrYyVp2QFCPpdXqTO2yxwRqn78EB/T9pEIg1Mf
         EmkmS0dRr6bmxEQXgj42wtc7it3nMRorG92rH0MgD6lzskvR4btzfkSBxdR34hLwWq
         fS5QELQ98/PPMP0xynZvsvpQEW9oYyX1LTKbmyL4IHCoeZ8ZGq61Uv39SRUFNeCCAg
         Z+Nk/JLiDL+T0zstLgv9N45jbSeHtLnGA1fe9aUG6mox1Y16YjMZ1N3bQEmFqy3ODc
         G4wVd1BD+v/lg==
Date:   Wed, 18 Jan 2023 08:13:49 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Nylon Chen <nylon.chen@sifive.com>
Cc:     Jessica Clarke <jrtc27@jrtc27.com>,
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
Message-ID: <Y8eqPdifnWbMQI/T@spud>
References: <20230113083115.2590-1-nylon.chen@sifive.com>
 <Y8GjySjm9OjoZvCF@spud>
 <95F1EAA0-D8D6-4F8A-8049-5E7BFDE4C06C@jrtc27.com>
 <Y8K1a+xs6tbo7kV4@spud>
 <CAHh=Yk9jUFiwzw+RQDoyb7xDoHGXFzNprdXn8szmMZb5FB4jLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="KB0jfWFHyOhAHNFP"
Content-Disposition: inline
In-Reply-To: <CAHh=Yk9jUFiwzw+RQDoyb7xDoHGXFzNprdXn8szmMZb5FB4jLw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KB0jfWFHyOhAHNFP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Nylon,

On Wed, Jan 18, 2023 at 10:32:25AM +0800, Nylon Chen wrote:
> Conor Dooley <conor@kernel.org> =E6=96=BC 2023=E5=B9=B41=E6=9C=8814=E6=97=
=A5 =E9=80=B1=E5=85=AD =E4=B8=8B=E5=8D=8810:00=E5=AF=AB=E9=81=93=EF=BC=9A
> > On Fri, Jan 13, 2023 at 07:24:56PM +0000, Jessica Clarke wrote:
> > > On 13 Jan 2023, at 18:32, Conor Dooley <conor@kernel.org> wrote:

> > > > Please delete link 2, convert the other two to standard Link: tags =
and
> > > > put this information in the dts patch. Possibly into the PWM patch =
too,
> > > > depending on what the PWM maintainers think.
> > > > This info should be in the commit history IMO and the commit messag=
e for
> > > > the dts patch says what's obvious from the diff without any explana=
tion
> > > > as to why.
> > > >
> > > > I did a bit of looking around on lore, to see if I could figure out
> > > > why it was done like this in the first place, and I found:
> > > > https://lore.kernel.org/linux-pwm/CAJ2_jOG2M03aLBgUOgGjWH9CUxq2aTG9=
7eSX70=3DUaSbGCMMF_g@mail.gmail.com/
> > >
> > > That DTS documentation makes no sense to me, why does what the LED is
> > > wired to matter?
> >
> > ```
> >       active-low:
> >         description:
> >           For PWMs where the LED is wired to supply rather than ground.
> > ```
> >
> > > Whether you have your transistor next to ground or
> > > next to Vdd doesn=E2=80=99t matter, what matters is whether the trans=
istor is
> > > on or off. Maybe what they mean is whether the *PWM's output* / *the
> > > transistor's input* is pulled to ground or Vdd? In which case the
> > > property would indeed not apply here.
> > >
> > > Unless that=E2=80=99s written assuming the LED is wired directly to t=
he PWM, in
> > > which case it would make sense, but that=E2=80=99s a very narrow-mind=
ed view of
> > > what the PWM output is (directly) driving.
> >
> > I would suspect that it was written with that assumption.
> > Probably was the case on the specific board this property was originally
> > added for.

> As you can see, there is also the same description in U-Boot.
>=20
> But in U-Boot, the DTS of Unmatched/Unleashed has not been added active-l=
ow.
>=20
> This is because active-high should be correct if we look at the circuit d=
iagram.

I am loathe to speak for Jess, but I don't think either of us are
disagreeing with your patches. I was just trying to understand why it was
wrong in the first place to see if it was intentionally inverted, or if
there was something that could be improve to stop it happening again.
Apologies if that got lost in translation.

> > Maybe it'd be a bit more foolproof written as "For LEDs that are
> > illuminated while the PWM output is low. For example, where an LED is
> > wired between supply and the PWM output."?

Thanks,
Conor.


--KB0jfWFHyOhAHNFP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY8eqPQAKCRB4tDGHoIJi
0l1NAP4hoQtZQkitKUCK7iMO1hSdPTd/IA6bhrI7bWiQNAnlKQD+MVDCawwKnyHs
GVs7HhE/g6s3aK6sBM0Gi3kXEppZCwE=
=zYGs
-----END PGP SIGNATURE-----

--KB0jfWFHyOhAHNFP--
