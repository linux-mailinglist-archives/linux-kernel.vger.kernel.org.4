Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2E6738FE7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 21:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbjFUTR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 15:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbjFUTRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 15:17:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C5651BEA;
        Wed, 21 Jun 2023 12:17:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D2103616B4;
        Wed, 21 Jun 2023 19:17:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 351AEC433C8;
        Wed, 21 Jun 2023 19:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687375049;
        bh=/2NOJhy4wNMIffZt5ThNaY1odnd8bY7FynZL97TeVYg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yr61lD1yz7x1uA03DdQ4WCRPso+r+r/jJJYM1ywaDGOSjZlNJZd13EIUuNwKtxCG+
         9YAEHBO8ttvo9PF1dxddL0NIindBGnKoaHHbt8EIMgXKSJS0s9JaUKqVoOq3zDzRZd
         F8DNzn/jqGTRWXUbdDS6LhqpsJGADu8RC6rFUffuA4/Lgaqdr64lkZC8OtAvpbouo6
         VYSHcb2KFk4c4OV+WONKdmupd7Hw7XcZbv5q1z3qEel3Tuc6ZS4aHuMbxI0u1Cft6E
         ORvdIWnGvjFOsehPQjGbAfuqtt2q5VLrMeZ4avTWNkIbPQzVS8zdZ19xdvgq/YXQKm
         u2zWf1j2HPvRQ==
Date:   Wed, 21 Jun 2023 20:17:24 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Lee Jones <lee@kernel.org>
Cc:     Raymond Hackley <raymondhackley@protonmail.com>,
        linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Luca Weiss <luca@z3ntu.xyz>,
        "open list:LED SUBSYSTEM" <linux-leds@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, dev.mbornand@systemb.ch
Subject: Re: [PATCH 1/2] dt-bindings: leds: sgm3140: Document richtek,rt5033
 compatible
Message-ID: <20230621-conceded-groin-e72f91347b30@spud>
References: <20230602130644.259933-1-raymondhackley@protonmail.com>
 <20230602131009.260239-1-raymondhackley@protonmail.com>
 <20230621150141.GE10378@google.com>
 <20230621150302.GF10378@google.com>
 <20230621-stuffed-revolt-435d3d2dd4aa@spud>
 <20230621170524.GJ10378@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="noI01sei0q81ozDW"
Content-Disposition: inline
In-Reply-To: <20230621170524.GJ10378@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--noI01sei0q81ozDW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 21, 2023 at 06:05:24PM +0100, Lee Jones wrote:
> On Wed, 21 Jun 2023, Conor Dooley wrote:
> > On Wed, Jun 21, 2023 at 04:03:02PM +0100, Lee Jones wrote:
> > > On Wed, 21 Jun 2023, Lee Jones wrote:
> > > > On Fri, 02 Jun 2023, Raymond Hackley wrote:

> > > It's unusual for me to have to dump through a bunch of hoops just to
> > > read and then subsequently reply to mail.  Can you consider removing
> > > whatever encryption you have enabled please?
> >=20
> > https://www.kernel.org/doc/html/latest/process/email-clients.html#proto=
n-mail
>=20
> Thanks for the link.  This is perfect!

Ye, no worries chief. I got yelled at about it when I started out, so
figured I should at least document it after I noticed others getting
yelled at for the same reason, since it is a bit insidious.

> At least I know it's not just me being unreasonable.
>=20
> > I was under the impression that there was no way to disable this
> > behaviour, but I saw mention somewhere that they managed to patch the
> > open source version of the protonmail bridge to function. I cannot find
> > this on lore, because the person's domain was not a proton one and I
> > completely forget their name as it was several months ago.
> > I'll reply here if I find it.

It was Marc Bornand. Add to CC.

Thanks,
Conor.

--noI01sei0q81ozDW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZJNMxAAKCRB4tDGHoIJi
0sXDAP9p+ZxE11i6erxxrQaoM3IeQu5Q98EeFJj8gKEKimLKfwEA0cFTaMLifOoE
B9CUpUWpA5gJh80jy95lV3E/T+TTqQ8=
=ATO3
-----END PGP SIGNATURE-----

--noI01sei0q81ozDW--
