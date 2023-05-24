Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1526670FEDD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 21:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236227AbjEXT51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 15:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236188AbjEXT5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 15:57:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1DB718C;
        Wed, 24 May 2023 12:57:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5EF2E6406C;
        Wed, 24 May 2023 19:57:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEC29C433EF;
        Wed, 24 May 2023 19:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684958240;
        bh=1BuMrIt1WuFdXREwNQw5VsWAz4aiv/7I5+G1wxD2xqQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IXHhQcbz6MQkObzeSLJ9jQoSE53U1KKIYHq2Edye1XiGQjvQjqr/g9VwinWvhpqzr
         xLNZQR6tjrQ9SlGNwzrkwOX0VyHqWJh2eA3Wvys9gXfyA0iBsxj6RQ/5bIXxPAmdnv
         ot0ZHjpnwwwiuNDxieNKXKZn5sWMClWbQYc/cW6KE56JET2PZ3+/afWKKqy8klzW1i
         kfDpyflVCsrnafPaQSNnnsIZvzU3VPGylzjW8DSZw3eZ/38aVgLP4QvVsKtu+N/65o
         XyH3/HbTi54xGIPJ6BDETTcJIiRJKBRZZLGiPNbPRfoNB3Xa70fs4oSujmUTMjh91g
         0zKcgePfSgEHw==
Date:   Wed, 24 May 2023 20:57:16 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>, robh+dt@kernel.org,
        Lee Jones <lee@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        pascal Paillet <p.paillet@foss.st.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] dt-bindings: mfd: stpmic1: add fsl,pmic-poweroff
 property
Message-ID: <20230524-cider-unarmored-b1141db1030b@spud>
References: <20230516132225.3012541-1-sean@geanix.com>
 <20230516132225.3012541-3-sean@geanix.com>
 <20230516-footprint-handoff-bcd553ff6146@spud>
 <9B1EE405-77D3-4980-9A13-9D4F87C1A64F@geanix.com>
 <20230523-flaccid-fossil-c9d09838dc64@spud>
 <658510B5-702B-464A-BA55-01E2B315BE39@geanix.com>
 <20230524-ellipse-dagger-72f850253ea0@wendy>
 <24418459-DE19-4575-835B-8673F279993C@geanix.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tvTbO8tm4UlrjSgl"
Content-Disposition: inline
In-Reply-To: <24418459-DE19-4575-835B-8673F279993C@geanix.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tvTbO8tm4UlrjSgl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Sean, Lee,

On Wed, May 24, 2023 at 12:30:59PM +0200, Sean Nyekjaer wrote:
> > On 24 May 2023, at 12.08, Conor Dooley <conor.dooley@microchip.com> wro=
te:
> > On Wed, May 24, 2023 at 10:16:13AM +0200, Sean Nyekj=C3=A6r wrote:
> >>> On 23 May 2023, at 19.29, Conor Dooley <conor@kernel.org> wrote:
> >>> On Tue, May 23, 2023 at 11:55:50AM +0200, Sean Nyekj=C3=A6r wrote:
> >>>>> On 16 May 2023, at 20.06, Conor Dooley <conor@kernel.org> wrote:
> >>>>> On Tue, May 16, 2023 at 03:22:24PM +0200, Sean Nyekjaer wrote:

> >>>>>> +  st,pmic-poweroff:
> >>>>>> +    $ref: /schemas/types.yaml#/definitions/flag
> >>>>>> +    description: |
> >>>>>> +      if present, configure the PMIC to shutdown all power rails =
when
> >>>>>> +      power off sequence have finished.
> >>>>>> +      Use this option if the SoC should be powered off by externa=
l power management
> >>>>>> +      IC (PMIC).
> >>>>>=20
> >>>>> Just reading this description, this is sounding quite like a "softw=
are
> >>>>> behaviour" type of property, which are not permitted, rather than
> >>>>> describing some element of the hardware. Clearly you are trying to =
solve
> >>>>> an actual problem though, so try re-phrasing the description (and
> >>>>> property name) to focus on what exact hardware configuration it is =
that
> >>>>> you are trying to special-case.
> >>>>> Krzysztof suggested that the samsung,s2mps11-acokb-ground property =
in
> >>>>> samsung,s2mps11.yaml is addressing a similar problem, so that could=
 be
> >>>>> good to look at.

> >>> The description for the property that Krzysztof mentioned is
> >>> samsung,s2mps11-acokb-ground:
> >>>   description: |
> >>>     Indicates that ACOKB pin of S2MPS11 PMIC is connected to the grou=
nd so
> >>>     the PMIC must manually set PWRHOLD bit in CTRL1 register to turn =
off the
> >>>     power. Usually the ACOKB is pulled up to VBATT so when PWRHOLD pi=
n goes
> >>>     low, the rising ACOKB will trigger power off.
> >>>=20
> >>> In other words, I am asking what (abnormal?) scenario there is that m=
eans
> >>> you need the property, rather than what setting the property does.
> >>> Or am I totally off, and this is the only way this PMIC works?
> >>=20
> >> Indicates that the power management IC (PMIC) turn-off condition is met
> >> by setting the SWOFF bit in the main control register (MAIN_CR) regist=
er.
> >> Turn-off condition can still be reached by the PONKEY input.
> >>=20
> >> ?
> >>=20
> >> I must admit I=E2=80=99m somewhat lost here :)
> >=20
> > Sorry about that. I'm trying to understand what is different about your
> > hardware that it needs the property rather than what adding the property
> > does. If you look at the samsung one, it describes both the
> > configuration of the hardware ("ACOKB pin of S2MPS11 PMIC is connected =
to
> > the ground") and how that is different from normal ("Usually the ACOKB =
is
> > pulled up to VBATT so when PWRHOLD pin goes low, the rising ACOKB will
> > trigger power off.")
> >=20
> > Looking at your datasheet, you don't have such a pin though - just the
> > sw poweroff bit & the PONKEY stuff. My angle is just that I am trying
> > to figure out why you need this property when it has not been needed
> > before. Or why you would not always want to "shutdown all power rails
> > when power-off sequence have finished". I'm sorry if these are silly
> > questions.
> >=20
>=20
> No silly questions, maybe they trick me to come up with the correct answe=
r :D
>=20
> Basically without this, you won=E2=80=99t be able to power off the system
> other than hitting the PONKEY.
> So it=E2=80=99s a new feature that wasn=E2=80=99t supported before.
> Maybe this feature should not be optional?

Yeah, I suppose that is the rabbit-hole that the silly questions lead
down. I don't know the answer to that though. Maybe Lee does?

> If st,pmic-poweroff =3D=3D true:
> System will power off as the last step in the power off sequence.
> If st,pmic-powerof =3D=3D false:
> System will reboot in the last step in the power off sequence.
>=20
> I thought of this, as an always on system failsafe.
>=20
> /Sean

--tvTbO8tm4UlrjSgl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZG5sHAAKCRB4tDGHoIJi
0rWEAP4lWVE6G3byCCSQgC62atNFVXdqKVjP4XzjoT0ww7VJFAD9Fl9yiOYkQxHu
nrbVQIPYnPN+/L1UGV8+t49vUBeWUQ8=
=s+Wx
-----END PGP SIGNATURE-----

--tvTbO8tm4UlrjSgl--
