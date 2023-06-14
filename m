Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8387C73060F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 19:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235520AbjFNR1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 13:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjFNR1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 13:27:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A05B1CE;
        Wed, 14 Jun 2023 10:27:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C4C164519;
        Wed, 14 Jun 2023 17:27:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A045C433C8;
        Wed, 14 Jun 2023 17:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686763621;
        bh=tHs6KrXSqtk9yeuEJiqSNT/vtZdNW3ETcAB6guHg7WU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mYYtwnOitRVyLFNh5M+PzFRqn+W1WiWFify2Bm0q+klywjo1ZFBW6Rzv91a9b2xv9
         rlmQvj3DhWSHfcZq040Krh0vzIeY2uFb5jonCb3/UFdQvwC6dfOTkkbgRIT60snI8z
         SZ1p7+iSvoWiZRAyRwPhHi6kPtqcIQmbb413RZN2CE+lX04WLEW+nklEUiFtYyvuvR
         F2wHUo+9ikx0en4SqiYGrYL1ZcK/1L/x+WicI+1vMAwrR1q2Heck+KVYZW+na+My20
         8F1CzM+nV8RnYYGN5umL57RdQ1HUorbFVxXQdl2TWVWNjmqW3u6M3+Wp+H9I6y8H0B
         fFG9yoEAkLpPA==
Date:   Wed, 14 Jun 2023 18:26:56 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        Gaurav Jain <gaurav.jain@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: crypto: fsl,sec-v4.0-mon: Add
 "linux,keycodes" and deprecate "linux,keycode"
Message-ID: <20230614-glutton-crispy-0d9588a97a1c@spud>
References: <20230613201231.2826352-1-robh@kernel.org>
 <20230613201231.2826352-2-robh@kernel.org>
 <20230613-sculptor-prepaid-9dc5afcc2dcc@spud>
 <CAL_JsqJFT630XJ8xOrz47w5bMbGv12koCHc1NdhQQANdTrE4ow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="VXxm4yyUB67FoBNX"
Content-Disposition: inline
In-Reply-To: <CAL_JsqJFT630XJ8xOrz47w5bMbGv12koCHc1NdhQQANdTrE4ow@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VXxm4yyUB67FoBNX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 14, 2023 at 08:53:20AM -0600, Rob Herring wrote:
> On Tue, Jun 13, 2023 at 3:11=E2=80=AFPM Conor Dooley <conor@kernel.org> w=
rote:
> >
> > On Tue, Jun 13, 2023 at 02:12:30PM -0600, Rob Herring wrote:
> > > The "linux,keycode" property is non-standard. Add the common property
> > > "linux,keycodes" and mark "linux,keycode" deprecated so that the mist=
ake
> > > is not propagated.
> >
> > This is actually used in the driver for this device, should the driver
> > not also be updated to use the corrected property?
>=20
> Yes, but that doesn't have to be in sync with the binding change. I
> mainly want to add this so it doesn't get propagated to new users
> rather than move this case off of linux,keycode. Also, the input
> subsystem should probably have a common function to read
> linux,keycodes as right now every driver does it.

Perhaps one of the nxp folk in the audience should have a crack at that
so.
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--VXxm4yyUB67FoBNX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZIn4YAAKCRB4tDGHoIJi
0mYJAP9NnubJj0eeMfBXxo/XcEhHExe5uV2X4Jg0JhiJjuCw3QEAkatNfHZgwayd
i52+9Wk5qljnuBEjJBHurt08neXyqAk=
=Ke7L
-----END PGP SIGNATURE-----

--VXxm4yyUB67FoBNX--
