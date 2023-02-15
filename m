Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45C0A6977B6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 08:59:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233783AbjBOH7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 02:59:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233500AbjBOH7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 02:59:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F364B30B09;
        Tue, 14 Feb 2023 23:59:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A1C42B82041;
        Wed, 15 Feb 2023 07:59:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4747C433D2;
        Wed, 15 Feb 2023 07:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676447973;
        bh=AlCe6D2Z5HBYC7NYZS/tW0FzZvw6nnZ59icnVKOLKFk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jhATrRqocqdcwNHySsDVAM4AJyFs9yiQMEbw5gRi0OLjrfbo7rGn0WM4F7C6BDEaY
         88FIpaZCHfsdHcN11pSI6TtSBfcrqPbIxuKukZooWrUCi+eXeA7PC25EPIX6olT+T2
         DuHwtXABCp2ui7Jny/a1Y+1mtz5pRO4X/T0EkdMUFou4v/pSWfEWce2cEt6q3vGOes
         /9sI7CpeRXKAbgTNSP7rM8yChLnkdEQYFFSppjo/AK9YHOIKgFTxYuOqqZf0xc6Wfm
         fz/AoRswpVXS0tsxu8Fezhh9KOsPURglgrpfmZLyIG7jvH1mc5Wj7JLi5Ti55GPR3r
         fOUfSyC3YvktA==
Date:   Wed, 15 Feb 2023 07:59:27 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Hal Feng <hal.feng@starfivetech.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ben Dooks <ben.dooks@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/7] riscv: dts: starfive: Add initial StarFive JH7110
 device tree
Message-ID: <Y+yQ3+0lyo5OQr2z@spud>
References: <20221220011247.35560-1-hal.feng@starfivetech.com>
 <20221220011247.35560-7-hal.feng@starfivetech.com>
 <Y6zHy9oL4xzl+6Rd@spud>
 <c507e0b2-5ca3-cffe-55d2-873ed8c24e3d@starfivetech.com>
 <Y9og8Q2UnJ452KH/@wendy>
 <df6755ed-a358-ea01-d89e-f3c004b9c297@starfivetech.com>
 <Y9wR7Up+iObw5qoE@spud>
 <8b35344f-0f78-b4e6-2b5e-e6ec6b101a75@starfivetech.com>
 <Y+yM6HgAbDoWlu1G@spud>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kQ9J72Cft2Lox+eu"
Content-Disposition: inline
In-Reply-To: <Y+yM6HgAbDoWlu1G@spud>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kQ9J72Cft2Lox+eu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 15, 2023 at 07:42:32AM +0000, Conor Dooley wrote:
> Hey Hal!
>=20
> On Wed, Feb 15, 2023 at 11:07:15AM +0800, Hal Feng wrote:
> > On Thu, 2 Feb 2023 19:41:33 +0000, Conor Dooley wrote:
> > > On Fri, Feb 03, 2023 at 02:56:41AM +0800, Hal Feng wrote:
> > >> On Wed, 1 Feb 2023 08:21:05 +0000, Conor Dooley wrote:
> > >> > On Wed, Feb 01, 2023 at 03:21:48PM +0800, Hal Feng wrote:
> > >> >> On Wed, 28 Dec 2022 22:48:43 +0000, Conor Dooley wrote:
> > >> >> > On Tue, Dec 20, 2022 at 09:12:46AM +0800, Hal Feng wrote:
> > >> >=20
> > >> >> >> +/ {
> > >> >> >> +	compatible =3D "starfive,jh7110";
> > >> >> >> +	#address-cells =3D <2>;
> > >> >> >> +	#size-cells =3D <2>;
> > >> >> >> +
> > >> >> >> +	cpus {
> > >> >> >> +		#address-cells =3D <1>;
> > >> >> >> +		#size-cells =3D <0>;
> > >> >> >> +
> > >> >> >> +		S76_0: cpu@0 {
> > >> >> >> +			compatible =3D "sifive,u74-mc", "riscv";
> > >> >> >=20
> > >> >> > The label here says S76 but the compatible says u74-mc.
> > >> >>=20
> > >> >> U74-MC has 5 cores including 1 * S7 core and 4 * U74 cores.
> > >> >>=20
> > >> >> > Which is correct? Your docs say S7 and S76, so I would imagine =
that it
> > >> >> > is actually an S76?
> > >> >>=20
> > >> >> I found SiFive website [1] call it S76, but call it S7 in other p=
laces.
> > >> >> So I misunderstood this. Considering the ISA difference you descr=
ibed
> > >> >> as below, I think it's proper to change the label to "S7_0".
> > >> >=20
> > >> > I'm less worried about the label & more interested in the compatib=
le.
> > >> > hart0 is, as you say, not a u74. Should we not be adding a "sifive=
,s7"
> > >> > compatible string to Documentation/devicetree/bindings/riscv/cpus.=
yaml
> > >> > and using that here instead?
> > >>=20
> > >> First of all, it's my fault that I didn't check the revision of U74-=
MC
> > >> manual, so most of my previous replies might not make sense.
> > >=20
> > > No that's fine. The manual stuff confused me too when I went looking
> > > initially, and I still get get mixed up by the fact that there are
> > > core-complex manuals but not core manuals.
> > >=20
> > >> If we add a new compatible string for S7, should we change the compa=
tibles
> > >> of hart1~3 to "sifive,u74" also? And then, there may be no point kee=
ping some
> > >> compatible strings of core complex like "sifive,u74-mc" and "sifive,=
u54-mc".
> > >> I'm not sure about this.
> > >=20
> > > [...]
> > >=20
> > >> >> Yes, "RV64IMAC" is correct. The monitor core in U74-MC is a
> > >> >> S7-series core, not S76.
> > >> >=20
> > >> > Cool, thanks.
> > >>=20
> > >> Now I think it might be another version of S76.
> > >=20
> > > The SiFive docs describe the u74-mc core complex, which AFAIU you hav=
e,
> > > as being 1x S7 & 4x U7.
> > >=20
> > > I'd be happy with new binding for "sifive,s7" & then we use that here.
> > > If you're sure it's S76, we can also use that. S76 is described, in w=
hat
> > > docs I can see, as a core complex containing an S7, so S7 seems likely
> > > to be correct?
> >=20
> > I will add a new binding for "sifive,s7" and modify the code as follows.
> >=20
> > 	S7_0: cpu@0 {
> > 		compatible =3D "sifive,s7", "riscv";
> > 		...
> > 		riscv,isa =3D "rv64imac_zicsr_zba_zbb";
>=20
> I'm not sure that I'd bother with the zicsr, it gets added automagically
> by the Makefile if needed:

Meh, I probably shouldn't have replied to this first thing in the
morning as this comment of mine doesn't really make sense.
I skipped the middle part of my point here...
What I meant was that you can avoid zicsr & zifencei because when the
binding was defined they were included in i. I meant to use the
following as a kinda explanation of it depending on the version of the
ISA spec & that we just assume that zicsr & zifencei are present.
I suppose you can add them to the isa string if you like, dtbs_check
shouldn't complain!

> | # Newer binutils versions default to ISA spec version 20191213 which mo=
ves some
> | # instructions from the I extension to the Zicsr and Zifencei extension=
s.
> | toolchain-need-zicsr-zifencei :=3D $(call cc-option-yn, -march=3D$(risc=
v-march-y)_zicsr_zifencei)
> | riscv-march-$(toolchain-need-zicsr-zifencei) :=3D $(riscv-march-y)_zics=
r_zifencei
>=20
> Otherwise, thanks for the actual confirmation of zba/zbb!
>=20
> Thanks,
> Conor.
>=20



--kQ9J72Cft2Lox+eu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY+yQ3wAKCRB4tDGHoIJi
0kxzAPwN73uyE4IsaZf4b1X4/Vmjb/o64MHCIZFKFohWkyQhBQEA4Rycf080nEpr
wuhi9sHdevKSoKg9OzsIer2j0qfAxwY=
=eXZM
-----END PGP SIGNATURE-----

--kQ9J72Cft2Lox+eu--
