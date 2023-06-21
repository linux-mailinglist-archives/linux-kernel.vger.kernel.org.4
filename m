Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D776F738FB4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 21:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbjFUTMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 15:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjFUTMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 15:12:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25BCA1AC;
        Wed, 21 Jun 2023 12:12:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A735A6148F;
        Wed, 21 Jun 2023 19:12:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7BBCC433C0;
        Wed, 21 Jun 2023 19:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687374751;
        bh=pvCW0ClizpVygxK7cLsFvnijZg0ttHOEE9V2jUKQpgk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oHL9+XIgNaaOilNmMrifzgvsqMAt/28ocdOB2oS9N75pxCDkggkVGFVcp5CObbkkP
         NbwVU7rrIPvSYFWHFpuOKBGp56aOE30dPo7wGq+KLJzMXRq6R25Ra9UClqYyb+3KYr
         AwCzyup08Mpeo4vw0G/b2iZpv97eKWfZBarkjrOoJd72LjmGOJ5+4zbnY9lfWRwZUZ
         00SAkjcmvY++1Vi0cbSFj7GrVB40e6CnWKKDXT9TxnqGWNehXMH1OMsK8h0kM4wh5D
         w0DMeItYBJD68kX4TYgu6DUK4oxYrbdK61Rl+Ji2FRGAQMpEOE/qQH407qWB951RmN
         yh/lXrNNDJg/w==
Date:   Wed, 21 Jun 2023 20:12:24 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Lee Jones <lee@kernel.org>
Cc:     Manikandan Muralidharan <manikandan.m@microchip.com>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com,
        sam@ravnborg.org, bbrezillon@kernel.org, airlied@gmail.com,
        daniel@ffwll.ch, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Hari.PrasathGE@microchip.com,
        Balamanikandan.Gunasundar@microchip.com,
        Durai.ManickamKR@microchip.com, Nayabbasha.Sayed@microchip.com,
        Dharma.B@microchip.com, Varshini.Rajendran@microchip.com,
        Balakrishnan.S@microchip.com
Subject: Re: [PATCH 2/9] mfd: atmel-hlcdc: Add compatible for SAM9X7 HLCD
 controller
Message-ID: <20230621-pampers-dial-07b6c3e7602a@spud>
References: <20230613070426.467389-1-manikandan.m@microchip.com>
 <20230613070426.467389-3-manikandan.m@microchip.com>
 <20230621175645.GR10378@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zsZwVK0nRU6jEjva"
Content-Disposition: inline
In-Reply-To: <20230621175645.GR10378@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zsZwVK0nRU6jEjva
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 21, 2023 at 06:56:45PM +0100, Lee Jones wrote:
> On Tue, 13 Jun 2023, Manikandan Muralidharan wrote:
>=20
> > Add compatible for SAM9X7 HLCD controller.
> >=20
> > Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
> > ---
> >  drivers/mfd/atmel-hlcdc.c | 1 +
> >  1 file changed, 1 insertion(+)
>=20
> Applied, thanks

Hmm, Nicolas pointed out that this compatible is likely insufficient,
and it'll likely need to be sam9x70 & sam9x75 as there are differences
between what each of these SoCs support.
https://lore.kernel.org/all/ef09246c-9220-4c71-4ac2-2792d9ca519d@microchip.=
com/
I guess it doesn't really matter, since the binding didn't get applied
and what's in the driver can be arbitrarily changed?

Cheers,
Conor.

--zsZwVK0nRU6jEjva
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZJNLmAAKCRB4tDGHoIJi
0vYDAQCrn4A14yblpV2uYnp7eJiwUWDuCmKo5+fc3VkNOrvitQEA5QIV7hQdQCRR
lzZK9jhg9rQhq32EGUiTjXEFKLzAKQw=
=/8eC
-----END PGP SIGNATURE-----

--zsZwVK0nRU6jEjva--
