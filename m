Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F15A964208F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 00:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbiLDXea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 18:34:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbiLDXe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 18:34:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F1A9101D7;
        Sun,  4 Dec 2022 15:34:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0B679B80B4E;
        Sun,  4 Dec 2022 23:34:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19EE3C433C1;
        Sun,  4 Dec 2022 23:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670196863;
        bh=0cK0lUJ9KkiCl80pkQTKTOocwELvWyVAqXmQVTnv1c0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lovS8maHB9ktQb+Ww5yw81rPcCZRXSE1XC/6VM5+f/JzRlywQpDbXevjsTf3XGvwo
         hscWSSHlMxx3ebYCbnH326mOeJsoC5YYQGGFW6Ht9lcNBlPL24prA8E9YlkLl0+iXS
         gT7b/JylxCuJNt1lrjulIfpbqQbDa8QczvHB3edaPIrjidCAFPcARr2CadVdz3r0S9
         gA6chTikmaPXADK1iQkCKLL6y6E5g3Csy8L2MmjmnSKtZKyAcXC6nAplTg1PCwNide
         61gS7CsPom3Y5PON4htb0C6MeaLRDxBTApvUrtVGdJQwIChLQAb1g1+of2ruMJFfSA
         5pm8SjNmeoAgg==
Date:   Sun, 4 Dec 2022 23:34:17 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Anup Patel <apatel@ventanamicro.com>,
        Rob Herring <robh@kernel.org>,
        "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Jones <ajones@ventanamicro.com>,
        Atish Patra <atishp@atishpatra.org>,
        Samuel Holland <samuel@sholland.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Anup Patel <anup@brainfault.org>, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: Re: [PATCH v5 3/3] clocksource: timer-riscv: Set
 CLOCK_EVT_FEAT_C3STOP based on DT
Message-ID: <Y40ueQiTZK6hi7RS@spud>
References: <20221201123954.1111603-1-apatel@ventanamicro.com>
 <20221201123954.1111603-4-apatel@ventanamicro.com>
 <20221202000603.GA1720201-robh@kernel.org>
 <CAK9=C2VbM+CP0Y9Xx-SM9O4TFrQmOKvVWy-u5mxdPxrhacK4JQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="HlfaDJpKZhs96dAp"
Content-Disposition: inline
In-Reply-To: <CAK9=C2VbM+CP0Y9Xx-SM9O4TFrQmOKvVWy-u5mxdPxrhacK4JQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HlfaDJpKZhs96dAp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Rob, Anup, Prabhakar,

On Fri, Dec 02, 2022 at 12:03:05PM +0530, Anup Patel wrote:
> On Fri, Dec 2, 2022 at 5:36 AM Rob Herring <robh@kernel.org> wrote:
> >
> > On Thu, Dec 01, 2022 at 06:09:54PM +0530, Anup Patel wrote:
> > > We should set CLOCK_EVT_FEAT_C3STOP for a clock_event_device only
> > > when riscv,timer-cannot-wake-cpu DT property is present in the RISC-V
> > > timer DT node.
> > >
> > > This way CLOCK_EVT_FEAT_C3STOP feature is set for clock_event_device
> > > based on RISC-V platform capabilities rather than having it set for
> > > all RISC-V platforms.
> > >
> > > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > > Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
> > > ---
> > >  drivers/clocksource/timer-riscv.c | 12 +++++++++++-
> > >  1 file changed, 11 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/=
timer-riscv.c
> > > index 969a552da8d2..1b4b36df5484 100644
> > > --- a/drivers/clocksource/timer-riscv.c
> > > +++ b/drivers/clocksource/timer-riscv.c
> > > @@ -28,6 +28,7 @@
> > >  #include <asm/timex.h>
> > >
> > >  static DEFINE_STATIC_KEY_FALSE(riscv_sstc_available);
> > > +static bool riscv_timer_cannot_wake_cpu;
> > >
> > >  static int riscv_clock_next_event(unsigned long delta,
> > >               struct clock_event_device *ce)
> > > @@ -51,7 +52,7 @@ static int riscv_clock_next_event(unsigned long del=
ta,
> > >  static unsigned int riscv_clock_event_irq;
> > >  static DEFINE_PER_CPU(struct clock_event_device, riscv_clock_event) =
=3D {
> > >       .name                   =3D "riscv_timer_clockevent",
> > > -     .features               =3D CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_=
FEAT_C3STOP,
> > > +     .features               =3D CLOCK_EVT_FEAT_ONESHOT,
> >
> > A platform that depended on CLOCK_EVT_FEAT_C3STOP being set will break
> > with this change because its existing DT will not have the new property.
> >
> > It needs to be the other way around which would effectively be the
> > existing 'always-on' property.
>=20
> There are no RISC-V platforms using C3STOP. The patch which
> added C3STOP has been reverted.
> (Refer, https://lore.kernel.org/lkml/a218ebf8-0fba-168d-6598-c970bbff5faf=
@sholland.org/T/)
>=20
> I just need to rebase this patch upon the C3STOP revert patch.

I guess you could say that the C3STOP addition was done spec-ulatively*,
as the platform that actually exhibits that behaviour does not use the
riscv-timer & its maintainer acked the revert (allwinner d1 family).

*The spec does not make any guarantees about whether events arrive
during suspend, only the behaviour *if* they arrive.

Switching the property to "always-on" would require retrofitting that
property to every other existing platform (and therefore regressing some
behaviour there, no?).

Most of the existing platforms are "toys" or demo platforms though, so
it would not, I guess, be the end of the world to do so. Doubly so since
none of them actually implement any sleep states that making it an
"always-on" property.

I've said since the start that defaulting to C3STOP is the "safer" thing
to do, and although we disagreed on this last time Anup, I think the
better outcome of someone missing a DT property is inaccessible sleep
states rather than going into sleep states they cannot get out of.

For PolarFire SoC, which I guess is one of the few "commerical"
platforms, I'd be willing to accept retrofitting, since we have not yet
implemented such sleep states yet.

Maybe Prabhakar knows whether the RZ/Five has either a) implemented
sleep states and b) which side of the "timer events arrive in suspend"
divide their platform lies on.
I'm particular interested here since that is not a SiFive core complex.

I would like to get DT maintainer approval of an approach here soon-ish
so that we can something sorted for the jh7110 stuff and for the
bouffalolabs SoC - the latter of which may very well be in the "no
events in suspend" camp as it also uses thead stuff.

Sorry for kinda rowing back on my previous acceptance of the approach,
but I am really between two minds on this.

Thanks,
Conor.


--HlfaDJpKZhs96dAp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY40uVQAKCRB4tDGHoIJi
0iXwAQDvaIbyKF4NJU9VaT5Lh4McyjHE+Y8vdOlJksMvF+Hc1AEA60gVnGIV8CWe
iMzMzE7jeqmjP23QMLt5HftoInManQg=
=ydQx
-----END PGP SIGNATURE-----

--HlfaDJpKZhs96dAp--
