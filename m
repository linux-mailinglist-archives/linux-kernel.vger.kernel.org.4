Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3875D5FB282
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 14:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbiJKMhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 08:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiJKMhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 08:37:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA247CB40;
        Tue, 11 Oct 2022 05:37:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 252E4B815A6;
        Tue, 11 Oct 2022 12:37:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B40EFC433D7;
        Tue, 11 Oct 2022 12:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665491849;
        bh=6CIknBN6DSmcDQHW95giaoBg1f++mvKDzGjR39nYXK8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=litudYE329apnqs2pGEJMIXKhAg0+WBta+eRLI04tmSwIDITaYYd3fM6+9wmznuHf
         JHkLJsp83st/zsdT1QnRSrzC5UdABkBHAg63uv0C0OcaOUYiuUqzDaP7Mp0RwGyuLb
         /x7izuqOk160JQNJRtLAYHs9h+B7BOgDf3Nu7MbVrI7fBjUfOkiKI4CltuLHJGd5Nx
         cKMm+dSCFvQT55LFFU/O9FTR2FOigWseqRT14ToRlexBkJRC8Mz2OszTKEFzhPWinA
         oNDN3nDAcBs7Fal6dfz0KJ7ZsEJisLTTKmPQfq6pfEGTl0cKkQhly3KRGKq/T8wqRQ
         HEP6Z04v6XOOg==
Received: by mercury (Postfix, from userid 1000)
        id BC5CE1064D61; Tue, 11 Oct 2022 14:37:26 +0200 (CEST)
Date:   Tue, 11 Oct 2022 14:37:26 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] ARM: dts: omap3-n900: fix LCD reset line polarity
Message-ID: <20221011123726.elsr53ue7nxzhvww@mercury.elektranox.org>
References: <20221004213503.848262-1-dmitry.torokhov@gmail.com>
 <Y0UDEtQlN5Y9h7BU@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="st6zuozv63braxzg"
Content-Disposition: inline
In-Reply-To: <Y0UDEtQlN5Y9h7BU@atomide.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--st6zuozv63braxzg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 11, 2022 at 08:45:54AM +0300, Tony Lindgren wrote:
> * Dmitry Torokhov <dmitry.torokhov@gmail.com> [221004 21:26]:
> > The LCD driver (panel-sony-acx565akm), when probing, starts with line
> > driven low, and then toggles it to high and keeps it there. Also, the
> > line is driven low when powering off the device, and ls released when
> > powering it back on. This means that the reset line should be described
> > as "active low" in DTS. This will be important when the driver is
> > converted to gpiod API which respects the polarity declared in DTS.
>=20
> We should ensure these patches get merged together with the driver
> change to avoid breaking LCD for booting. Probably no need to have
> the driver quirk handling for inverted polartity in this case.
>=20
> It's probably easiest to have an immutable branch for the driver
> changes I can base the dts changes on. Or I can ack the dts changes
> if they get merged with the driver.

Both drivers are already using gpiod API:

drivers/gpu/drm/panel/panel-sony-acx565akm.c
drivers/gpu/drm/panel/panel-dsi-cm.c

So this just breaks things.

-- Sebastian

--st6zuozv63braxzg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmNFY3gACgkQ2O7X88g7
+ppABg//U+RTuiDkx3hmsy4n39Pd+7oMisWb9D2dE4ILhkVJFHwuG66GIO8nBwMa
YBLWUuS/5y60Uz6TZWzGJ3eYQk9V7KLXs9TGThqy1luG/sbQA7PC1VoUDsaIaiF0
GgIlkW7/H8oEcoCnMTR2dzHWm5DtJ9ElcamJvZTYIVtLWx9eErVkfViD12imESc1
C3EhdFp3fdaBlj5R17BaBEBXDW8abHZ49S2erL9PopRd4WpKCBBgVPbFaoetAEuQ
hlDWiC1TrthF2aMr6EaXjSVtdK+dpi9lkYOAvQedFvAfzszC9LB0gfebMuD0dm0M
baNelPT/rHt/ppNbq7CEVyglQ3gJ0guKnLYPLs8CTuHYJa0FGFnB3qObVi7mA0cp
oQOkFdUxVuTDFspyjl2PqTDn94bLG8W4Pqh5jNcauKn0gRJqV2An8dnNMZoVGtq3
DTRZCTgcPKDjxjNVA5E1ClLiDuf+JvXUVvqU1IFmGZuPbuqRyi6P5zcInmoX+MJA
Uh0t+HmdzKmygU7EKvDDmVClazfGGOUfEIfBSalJ+5ul/nKBcMsvVH9yj8y2P91R
grHGqbtNHenjfniU1qEqVDWTeKdlMztQ6NTNBjMLn3pBao4WN4weE+Pc2r0kdxwF
8bKhFGxxvJdNg2kbjX1xoxQGyRy0yGAQW4GV38+9sS05U+yebLM=
=l0si
-----END PGP SIGNATURE-----

--st6zuozv63braxzg--
