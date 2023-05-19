Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5340709F10
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 20:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjESS3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 14:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjESS3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 14:29:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3336A139;
        Fri, 19 May 2023 11:29:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B0E9665A57;
        Fri, 19 May 2023 18:29:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 236E5C433D2;
        Fri, 19 May 2023 18:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684520960;
        bh=VbswIOQ3rtIAguwfMIDLkhK3SAdNBiRLTGE9PLqBpxs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SBl7lTyiVZ/MrUMp2wnKof1LP0ZBJFnIPTfmQinAMwWFL+Qba3q7Xlm5483Paz6W/
         qPba9Aj8SndGmDK5pwnBZ8nmTjsHMvJAALu4GKlr1QJHoo3/Fp3y89OLwAn5fws+q3
         5Vv25dDt+P0195GkSOvdyWajhueQSNrjSQ2TjepIrLg6wc5JAZdnRTMvqUMEjQCU33
         PdeTtPWjOE6XeF8FrjxH8w7UpdU6PO2t4OWMjyBwzORAvZMO+r+7buu6fP/t45hS0M
         ZPqNGebT+w3geR4+8jk9EoyA+I1PHRuqP0K06u1emlyJKRQcrAQJHNTW9RZiUl3uXQ
         VizuQeQW1rJrA==
Date:   Fri, 19 May 2023 19:29:15 +0100
From:   Conor Dooley <conor@kernel.org>
To:     marius.cristea@microchip.com
Cc:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: adding MCP3564 ADC
Message-ID: <20230519-variably-direction-cfa9a034e844@spud>
References: <20230519160145.44208-1-marius.cristea@microchip.com>
 <20230519160145.44208-2-marius.cristea@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="DejDAUkNXgqO8feK"
Content-Disposition: inline
In-Reply-To: <20230519160145.44208-2-marius.cristea@microchip.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DejDAUkNXgqO8feK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Marius,

On Fri, May 19, 2023 at 07:01:44PM +0300, marius.cristea@microchip.com wrot=
e:
> From: Marius Cristea <marius.cristea@microchip.com>
>=20
> This is the device tree schema for iio driver for
> Microchip family of 153.6 ksps, Low-Noise 16/24-Bit
> Delta-Sigma ADCs with an SPI interface.

Just one quick process bit, please try to CC all of the maintainers
listed by get_maintainer.pl - you unfortunately managed to miss 2 of the
3 dt-binding maintainers :/ Perhaps you ran get_maintainer.pl using our
vendor tree?

> Signed-off-by: Marius Cristea <marius.cristea@microchip.com>
> ---

> +  vref-supply:
> +    description:
> +      Some devices have a specific reference voltage supplied on a diffe=
rent
> +      pin to the other supplies. Needed to be able to establish channel =
scaling
> +      unless there is also an internal reference available (e.g. mcp3564=
r)

Should this be marked as a required property for the non-r devices that
do not have an internal reference?

> +  microchip,hw-device-address:

Hopefully Rob or Jonathan etc can chime in as to whether a common
property exists for this type of thing...

> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0
> +    maximum: 3
> +    description:
> +      The address is set on a per-device basis by fuses in the factory,
> +      configured on request. If not requested, the fuses are set for 0x1.
> +      The device address is part of the device markings to avoid
> +      potential confusion. This address is coded on two bits, so four po=
ssible
> +      addresses are available when multiple devices are present on the s=
ame
> +      SPI bus with only one Chip Select line for all devices.

=2E.although if it doesn't, it'd be good, I think, to add here where the
property crops up in spi transfers. And if not in the description, in
the commit message instead?

Thanks,
Conor.


--DejDAUkNXgqO8feK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGe/+wAKCRB4tDGHoIJi
0iBxAQD8eWexJAxdcKmL9CavbD0A6xzVonbGarfwkIDy7JlDjAD+MWkzon01DZkl
zn0K0jxeA7gcoP8ruCzeoIBgvADWUwQ=
=h34s
-----END PGP SIGNATURE-----

--DejDAUkNXgqO8feK--
