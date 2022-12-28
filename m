Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C61D5657633
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 13:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233048AbiL1MAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 07:00:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233087AbiL1L7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 06:59:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A23611814;
        Wed, 28 Dec 2022 03:59:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E3DBB614A5;
        Wed, 28 Dec 2022 11:59:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0766C433D2;
        Wed, 28 Dec 2022 11:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672228755;
        bh=uAssjzpnLfCwXvz1npPumuo6zQSx5QwSiVe04OHm4oM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EwiQ5i5gF8oEFgTKXuqWSLDD0dZrJ01l9eUUQXAUu9+KMJwXXeLH/nAJQhaUc4r8+
         W8BCm4ojCd19gQ7nfBOFQT0EpZzNRR017nQfJF1WYy/488dOKe2GaaIrckHjdaw5Bq
         GdqokXCQTdFtMbNBpUb8SQU+ZAsd3m67QuHcK7QfN9yf2yXOC/EOvabpUGuXgWROiN
         nMhWWmF/nppC2gzvOi+KIlcRv8B2S3xrULEC+5qNS7MuLNABvZOpgaAsxUJQ1N2b3c
         zq9nbl6kqYQG+qKORTkAAblvYAMp1Wbkb4vA+nQLJeDwUc/bhn+dKAgk2giIrAD/eo
         BcEijVNPOX4Mg==
Date:   Wed, 28 Dec 2022 11:59:09 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Conor Dooley <conor.dooley@microchip.com>,
        Anup Patel <apatel@ventanamicro.com>
Cc:     Samuel Holland <samuel@sholland.org>,
        Anup Patel <apatel@ventanamicro.com>,
        Rob Herring <robh@kernel.org>,
        "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Jones <ajones@ventanamicro.com>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: Re: [PATCH v5 3/3] clocksource: timer-riscv: Set
 CLOCK_EVT_FEAT_C3STOP based on DT
Message-ID: <Y6wvjaB4GE8s1W/g@spud>
References: <20221201123954.1111603-1-apatel@ventanamicro.com>
 <20221201123954.1111603-4-apatel@ventanamicro.com>
 <20221202000603.GA1720201-robh@kernel.org>
 <CAK9=C2VbM+CP0Y9Xx-SM9O4TFrQmOKvVWy-u5mxdPxrhacK4JQ@mail.gmail.com>
 <Y40ueQiTZK6hi7RS@spud>
 <0515dc20-2e82-bd16-301a-6ffff010af13@sholland.org>
 <Y42s8d+RSPMkrR6j@wendy>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="250qyPOy9rEbmPOI"
Content-Disposition: inline
In-Reply-To: <Y42s8d+RSPMkrR6j@wendy>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--250qyPOy9rEbmPOI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Anup (& Daniel++),

On Mon, Dec 05, 2022 at 08:33:53AM +0000, Conor Dooley wrote:
> On Mon, Dec 05, 2022 at 02:17:40AM -0600, Samuel Holland wrote:
> > On 12/4/22 17:34, Conor Dooley wrote:
> > > Hey Rob, Anup, Prabhakar,
> > >=20
> > > On Fri, Dec 02, 2022 at 12:03:05PM +0530, Anup Patel wrote:
> > >> On Fri, Dec 2, 2022 at 5:36 AM Rob Herring <robh@kernel.org> wrote:
> > >>>
> > >>> On Thu, Dec 01, 2022 at 06:09:54PM +0530, Anup Patel wrote:
> > >>>> We should set CLOCK_EVT_FEAT_C3STOP for a clock_event_device only
> > >>>> when riscv,timer-cannot-wake-cpu DT property is present in the RIS=
C-V
> > >>>> timer DT node.
> > >>>>
> > >>>> This way CLOCK_EVT_FEAT_C3STOP feature is set for clock_event_devi=
ce
> > >>>> based on RISC-V platform capabilities rather than having it set for
> > >>>> all RISC-V platforms.
> > >>>>
> > >>>> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > >>>> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > >>>> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
> > >>>> ---
> > >>>>  drivers/clocksource/timer-riscv.c | 12 +++++++++++-
> > >>>>  1 file changed, 11 insertions(+), 1 deletion(-)
> > >>>>
> > >>>> diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksour=
ce/timer-riscv.c
> > >>>> index 969a552da8d2..1b4b36df5484 100644
> > >>>> --- a/drivers/clocksource/timer-riscv.c
> > >>>> +++ b/drivers/clocksource/timer-riscv.c
> > >>>> @@ -28,6 +28,7 @@
> > >>>>  #include <asm/timex.h>
> > >>>>
> > >>>>  static DEFINE_STATIC_KEY_FALSE(riscv_sstc_available);
> > >>>> +static bool riscv_timer_cannot_wake_cpu;
> > >>>>
> > >>>>  static int riscv_clock_next_event(unsigned long delta,
> > >>>>               struct clock_event_device *ce)
> > >>>> @@ -51,7 +52,7 @@ static int riscv_clock_next_event(unsigned long =
delta,
> > >>>>  static unsigned int riscv_clock_event_irq;
> > >>>>  static DEFINE_PER_CPU(struct clock_event_device, riscv_clock_even=
t) =3D {
> > >>>>       .name                   =3D "riscv_timer_clockevent",
> > >>>> -     .features               =3D CLOCK_EVT_FEAT_ONESHOT | CLOCK_E=
VT_FEAT_C3STOP,
> > >>>> +     .features               =3D CLOCK_EVT_FEAT_ONESHOT,
> > >>>
> > >>> A platform that depended on CLOCK_EVT_FEAT_C3STOP being set will br=
eak
> > >>> with this change because its existing DT will not have the new prop=
erty.
> > >>>
> > >>> It needs to be the other way around which would effectively be the
> > >>> existing 'always-on' property.
> > >>
> > >> There are no RISC-V platforms using C3STOP. The patch which
> > >> added C3STOP has been reverted.
> > >> (Refer, https://lore.kernel.org/lkml/a218ebf8-0fba-168d-6598-c970bbf=
f5faf@sholland.org/T/)
> > >>
> > >> I just need to rebase this patch upon the C3STOP revert patch.
> > >=20
> > > I guess you could say that the C3STOP addition was done spec-ulativel=
y*,
> > > as the platform that actually exhibits that behaviour does not use the
> > > riscv-timer & its maintainer acked the revert (allwinner d1 family).
> >=20
> > For clarity: that doesn't mean the platform will _never_ use the SBI
> > timer facility, just that Linux happens to not use it right now.
>=20
> Yeah sorry - should have been a bit clearer there. There's a few other
> SoCs about that are using the thead cores, so I'd be "worried" that they
> share the timer behaviour but do not have an alternative like you do on
> the D1. That's part of what's kinda given me cold feet on the current
> approach.
>=20
> > > *The spec does not make any guarantees about whether events arrive
> > > during suspend, only the behaviour *if* they arrive.
> > >=20
> > > Switching the property to "always-on" would require retrofitting that
> > > property to every other existing platform (and therefore regressing s=
ome
> > > behaviour there, no?).
> > >=20
> > > Most of the existing platforms are "toys" or demo platforms though, so
> > > it would not, I guess, be the end of the world to do so. Doubly so si=
nce
> > > none of them actually implement any sleep states that making it an
> > > "always-on" property.
> >=20
> > Specifically, only sleep states with a "local-timer-stop" property would
> > be inhibited by the C3STOP flag, so there is only possibility of a
> > regression if some DT declaring such a sleep state exists anywhere.

What is the plan for this series? IIRC, a rebase was required on top of
the revert?
I'm not overly pushed either way at this point, I'd like to get this
C3STOP issue sorted out before more thead powered SoCs start showing up
with the same implementation issues.

I know it is the Christmas period so not expecting anything to actually
happen right away.

Thanks,
Conor.

> > > I've said since the start that defaulting to C3STOP is the "safer" th=
ing
> > > to do, and although we disagreed on this last time Anup, I think the
> > > better outcome of someone missing a DT property is inaccessible sleep
> > > states rather than going into sleep states they cannot get out of.
> > >=20
> > > For PolarFire SoC, which I guess is one of the few "commerical"
> > > platforms, I'd be willing to accept retrofitting, since we have not y=
et
> > > implemented such sleep states yet.
> > >=20
> > > Maybe Prabhakar knows whether the RZ/Five has either a) implemented
> > > sleep states and b) which side of the "timer events arrive in suspend"
> > > divide their platform lies on.
> > > I'm particular interested here since that is not a SiFive core comple=
x.
> > >=20
> > > I would like to get DT maintainer approval of an approach here soon-i=
sh
> > > so that we can something sorted for the jh7110 stuff and for the
> > > bouffalolabs SoC - the latter of which may very well be in the "no
> > > events in suspend" camp as it also uses thead stuff.
> > >=20
> > > Sorry for kinda rowing back on my previous acceptance of the approach,
> > > but I am really between two minds on this.


--250qyPOy9rEbmPOI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY6wviQAKCRB4tDGHoIJi
0m+XAP4iwz4yySGdb9pxurqrq+4vSoL8sb+IqzQUC6K13l+bCwEAqjwhLRQBidpk
JAJDC5mNSIouBHR53vXVlobx+xL55w8=
=E0sn
-----END PGP SIGNATURE-----

--250qyPOy9rEbmPOI--
