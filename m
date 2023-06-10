Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4013072AE14
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 20:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbjFJSPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 14:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjFJSPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 14:15:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C241FFE;
        Sat, 10 Jun 2023 11:15:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 30F6960DE1;
        Sat, 10 Jun 2023 18:15:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 640AFC433EF;
        Sat, 10 Jun 2023 18:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686420900;
        bh=GKPQxfUo7uZW5Gd24x7KvPKVI05y3+NdpM2kKSoZnSE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XJE5DuwsZcTBlN19+6/DEwAd9aFw3/uwDKB1+Me4H8zquGcujmwnBVUXlna8UmG7o
         VdZugEjKVvh0AItKK8yDmgOlw56DHbMvCzerk6+vaqot5CjqwWFvr2geuOxlyqAR6I
         6r1MNabOvEgXbNMax2dHuiuBbKkarVelFLl3P+McWD1uygZKak+dTiCYF/2lbidhwp
         DAXbztcXHmm2A46MHSdYtKyRuZJyV0OpKXM/5U4G/hCYi0eUCmZ5kF9A+4rS1THnY1
         lHCvDHTqy2+eKgCXBpZW3hWdLIRFvR+mrjFTQPp2wD9F1nxKnjQYCdHm3hXl1dVc3R
         Q/QwKR9c2/UXg==
Date:   Sat, 10 Jun 2023 19:14:55 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 2/5] dt-bindings: display: ssd1307fb: Remove default
 width and height values
Message-ID: <20230610-unused-engaged-c1f4119cff08@spud>
References: <20230609170941.1150941-1-javierm@redhat.com>
 <20230609170941.1150941-3-javierm@redhat.com>
 <20230610-opposite-quality-81d4a1561c88@spud>
 <87r0qj19zs.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="HYo4J/ldqvkCxGP1"
Content-Disposition: inline
In-Reply-To: <87r0qj19zs.fsf@minerva.mail-host-address-is-not-set>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HYo4J/ldqvkCxGP1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 10, 2023 at 07:51:35PM +0200, Javier Martinez Canillas wrote:
> Conor Dooley <conor@kernel.org> writes:
>=20
> > On Fri, Jun 09, 2023 at 07:09:37PM +0200, Javier Martinez Canillas wrot=
e:
> >> A default resolution in the ssd130x driver isn't set to an arbitrary 9=
6x16
> >> anymore. Instead is set to a width and height that's controller depend=
ent.
> >
> > Did that change to the driver not break backwards compatibility with
> > existing devicetrees that relied on the default values to get 96x16?
> >
>=20
> It would but I don't think it is an issue in pratice. Most users of these
> panels use one of the multiple libraries on top of the spidev interface.
>=20
> For the small userbase that don't, I believe that they will use the rpif
> kernel and ssd1306-overlay.dtbo DTB overlay, which defaults to width=3D128
> and height=3D64 [1]. So those users will have to explicitly set a width a=
nd
> height for a 96x16 panel anyways.
>=20
> The intersection of users that have a 96x16 panel, assumed that default
> and consider the DTB a stable ABI, and only update their kernel but not
> the  DTB should be very small IMO.

It's the adding of new defaults that makes it a bit messier, since you
can't even revert without potentially breaking a newer user. I'd be more
inclined to require the properties, rather change their defaults in the
binding, lest there are people relying on them.
If you and the other knowledgeable folk in the area really do know such
users do not exist then I suppose it is fine to do.

--HYo4J/ldqvkCxGP1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZIS9nwAKCRB4tDGHoIJi
0pU2AQDHz7mE6EbWFDwiRPNS1B2cx98/2aHLPV+NCbNKIozcTQD/Z67czcjETZHa
LtdkpASNCb1wsRO4PqBs3OegWGbZIAM=
=daWN
-----END PGP SIGNATURE-----

--HYo4J/ldqvkCxGP1--
