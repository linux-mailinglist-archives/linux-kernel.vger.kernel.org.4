Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA3246B5F6E
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 18:54:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbjCKRyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 12:54:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbjCKRyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 12:54:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF45959D6;
        Sat, 11 Mar 2023 09:54:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7E43FB80066;
        Sat, 11 Mar 2023 17:54:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08725C433D2;
        Sat, 11 Mar 2023 17:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678557272;
        bh=z2cWlGV1bcM9jzPNtM9QNL0pjVBEAIJSORCobXsuCfU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t93fSk76dMiXMENVkaQV4v/sl1rw0NGyqPBmFtGMMo6YHGkqTRxwKXSvANmMN+Stp
         E+5OZ1ct8iqicuM4/5oWyw+6QEWR/Rju8GRLFQWVHYQjXqdpSUbANCV/7qVqP6oUCm
         HCht02ze2o2l60LRqXm9vomuxlOG68waE7A3uihF4J10ccu6kNBmWOmy8UmnxOZZtr
         GGHAA+IFP5Y7e3pYBLpZDJlqwH4GmCFG6gm9lvauTRplJFd+rWGe29e2nfLGWutRoC
         2iwAb0zu+86q7tXq3PpgSYcF90AP07EF14vsvhandIsI7ox0HIR4FLWk8i60JfoMe7
         0AUBThzKpxKIg==
Received: by mercury (Postfix, from userid 1000)
        id 579B1106095F; Sat, 11 Mar 2023 18:54:29 +0100 (CET)
Date:   Sat, 11 Mar 2023 18:54:29 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCHv1 01/11] dt-bindings: power: supply: adc-battery: add
 binding
Message-ID: <1fdf00a0-4830-465a-801c-147472fdcd22@mercury.local>
References: <20230309225041.477440-1-sre@kernel.org>
 <20230309225041.477440-2-sre@kernel.org>
 <CACRpkdYWP7Fc3yho5nDB3qU6rt5o4p2Zcz_RxOvOfsAwjXgqXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="r33a6f5pdav5vdbc"
Content-Disposition: inline
In-Reply-To: <CACRpkdYWP7Fc3yho5nDB3qU6rt5o4p2Zcz_RxOvOfsAwjXgqXw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--r33a6f5pdav5vdbc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

On Fri, Mar 10, 2023 at 09:14:39AM +0100, Linus Walleij wrote:
> Hi Sebastian,
>=20
> thanks for your patches!
>=20
> On Thu, Mar 9, 2023 at 11:50=E2=80=AFPM Sebastian Reichel <sre@kernel.org=
> wrote:
>=20
> > Add binding for a battery that is only monitored via ADC
> > channels and simple status GPIOs.
> >
> > Signed-off-by: Sebastian Reichel <sre@kernel.org>
>=20
> This does look very useful.

:)

> > +title: ADC battery
> > +
> > +maintainers:
> > +  - Sebastian Reichel <sre@kernel.org>
> > +
> > +description: |
> > +  Basic Battery, which only reports (in circuit) voltage and optionally
> > +  current via an ADC channel.
>=20
> I would over-specify: "voltage over the terminals" and
> "current out of the battery" so this cannot be misunderstood.
>=20
> + this text:
>=20
> It can also optionally indicate that the battery is full by pulling a GPIO
> line.

Ack.

>=20
> > +  charged-gpios:
> > +    description:
> > +      GPIO which signals that the battery is fully charged.
>=20
> It doesn't say how, I guess either this is an analog circuit (!) or
> a charger IC? If it doesn't matter, no big deal, but if something is
> implicit here, then spell it out please.

In my case the GPIO is provided by a charger chip, that is not
software controllable (just reports charge-done & charger-connected
via GPIOs). I've seen something similar in a customer device some
years ago. I will add a sentence:

The GPIO is often provided by charger ICs, that are not software
controllable.

> > +    fuel-gauge {
>=20
> This techno-lingo/slang term is a bit unfortunate, but if there are
> precedents then stick with it.
>=20
> The correct term could be something like battery-capacity-meter
> I suppose.

Right now in DT we have

 - specific node name (e.g. chip names) that should be changed :)
 - smart-battery
 - battery
 - fuel-gauge

I think fuel-gauge is the most sensible of that list, considering
hardware vendors usually call their chips battery fuel gauge.

-- Sebastian

--r33a6f5pdav5vdbc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmQMwFEACgkQ2O7X88g7
+pr7kBAAmyDSM90DC1hkH6XIxMuE1dgd9pZvygODosBhLZzRDgo+eCiRmmpUHky4
5SpD/AK2vuptrYpv+p3yGrUorWUUE0kvNU0PMS5ID0CO7+6HOwALVhov1Mvk4oO5
a+WKYx4jV0t7FMvHe8GJ9r+ni4ywgCvRrAfVYIzHU67G+3pfURIc5SMh7UreQg+x
+Iies0ihL86aijszMhfsaX/0+zudlRa+dSwRZ9w72dqgvO0ksUNZl3bp2Z2/W6MR
OwbSUQmIBBxVVPs/1re18+F+GgxOkaghomxkLHLTF9shNtB5SRIqLDRi2Mszi6H2
Rmp8sQH4IDtKFC3EtJ1qCqRceTH/6tf+kNXSQ/8fw3pLZsLRy49DGsRshW5qaLm8
qRTZ8GU3XsbFGQgx1+GHSpzdCbTdH9Nbq+QsmETm2dl8HMFFGmMYSMWVUeixRWAx
tU2js6NhXJMEtl2MnjMeYUWWzKBLpDUN8AqPeMe/XvfG7RHmLjUHh8nwNqXxrZCk
7ttaRH4e8lJJNGkcbXDWQsMAaGNCBBl22GPwYNdVnE963p4BlpaPf85VzJbGmSR8
QmW2FuPueIv74B5HPzWUlfG2G4NN85NEmeUpXxfmr92iHbVr1DLLHKMjCxkbnecq
tPLCWhkdyD//zknvWI0+6nNuGNxx+XEhgJBLQR09jrTQtABciWc=
=MH4X
-----END PGP SIGNATURE-----

--r33a6f5pdav5vdbc--
