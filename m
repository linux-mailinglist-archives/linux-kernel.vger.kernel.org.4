Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD30E6F63FE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 06:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjEDEWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 00:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjEDEWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 00:22:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEDAB19BE;
        Wed,  3 May 2023 21:22:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4068363182;
        Thu,  4 May 2023 04:22:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 099C0C4339B;
        Thu,  4 May 2023 04:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683174158;
        bh=exMwIMNf2HDjkzVg/vgc5dShzanK1eETk2nuIq0YR4U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jgh8mT0T+ZMEbVlQoIlMMBE1QVmWnOJAFahVVZciUWMhNUg3ZRHkjjaSYRgY/XH9N
         ef5K4JrGKaf35pfRsGUJK8cETAbMXc6PwcEff+r2lBqrMXELs8UyS4Sn4jJMWdQLsu
         zX3tji7xrPc3zc975Ypo5p98mZ3cbFmffE0hZwvaWqnRgsoIkr3PUJPoMS1aqMEnRa
         2Hc2qS8eCJcic27uXj+zeBLGnMCQbubrC+EVF/oyJcRL+z+vqYOq7t2s0eQJgJdPsI
         WXMtcYuGz7Rz1SNiQXm+ft8wTKolVoelR0muPCY9093DcTsCwCakJyUxM11L9KQjBM
         op6Y33zA3Dp+Q==
Date:   Thu, 4 May 2023 13:22:35 +0900
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Herve Codina <herve.codina@bootlin.com>,
        Rob Herring <robh@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 1/4] dt-bindings: sound: Add simple-iio-aux
Message-ID: <ZFMzC7OBrcL9l5AH@finisterre.sirena.org.uk>
References: <20230421124122.324820-1-herve.codina@bootlin.com>
 <20230421124122.324820-2-herve.codina@bootlin.com>
 <20230425173029.GA1967523-robh@kernel.org>
 <20230426093621.3834e703@bootlin.com>
 <5bcb2741-9212-f1aa-335b-6bc4b6fad448@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gAqgDYGpNO6m8hZu"
Content-Disposition: inline
In-Reply-To: <5bcb2741-9212-f1aa-335b-6bc4b6fad448@linaro.org>
X-Cookie: Avoid contact with eyes.
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gAqgDYGpNO6m8hZu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 02, 2023 at 09:26:32AM +0200, Krzysztof Kozlowski wrote:
> On 26/04/2023 09:36, Herve Codina wrote:
> > Rob Herring <robh@kernel.org> wrote:
> >> On Fri, Apr 21, 2023 at 02:41:19PM +0200, Herve Codina wrote:

> >>> simple-iio-aux allows to consider these Industrial I/O devices as
> >>> auxliary audio devices. =20

> >> What makes it simple? Any binding called simple or generic is a trigge=
r=20
> >> for me. Best to avoid those terms. :)

> > I choose simple-iio-aux because some simple-* already exists.
> > For instance simple-audio-amplifier or simple-audio-mux.

> > Do you prefer audio-iio-aux ?
> > Let me know if I should change.

> It means that often what people call "simple" and "generic" works only
> for their specific case, because it is not really simple and generic.
> After some time the "simple" and "generic" becomes "complicated" and
> "huge". Conclusion: sometimes simple and generic bindings are bad idea
> and you should have something specific.

> Your description in the binding also does not help to match it to
> specific, real device. Provide the examples, as Rob asked.

I don't understand what you are looking for here.  IIO is a subsystem
which represents generic DACs and ADCs (along with other I/O things).
Audio devices also have DACs and ADCs, somewhat specialised for use in
audio but more limited by specs and interfaces than by anything
fundamental.  The goal here is to map DACs and ADCs described as IIO for
use in an audio context.

ADCs are devices that convert analog signals into digital values, DACs
are devices that convert digital values into analog signals.

> >> How do support multiple instances? Say you have 2 sound cards (or 1=20
> >> sound card with multiple audio paths) each with different sets of IIO=
=20
> >> channels associated with it. You'd need a link to each 'aux' node. Why=
=20
> >> not just add io-channels to the sound card nodes directly? That's=20
> >> already just a virtual, top-level container node grouping all the=20
> >> components. I don't see why we need another virtual node grouping a=20
> >> subset of them.

> > I don't see what you mean.
> > I use a simple-audio-card and here is a full example using several
> > instances:

> Just like Rob said: "You'd need a link to each 'aux' node"

> and you did it...

> So now the rest of Rob's answer:

> "Why not just add io-channels to the sound card nodes directly? That's
> already just a virtual, top-level container node grouping all the
> components. I don't see why we need another virtual node grouping a
> subset of them."

> Why do you need another node if it is not really representing a real,
> separate device?

If nothing else I would expect it to be useful from a comprehensibility
point of view to bundle multiple IIO devices into a single multi-channel
audio stream, an individual IIO device is likely to only present a
single channel of data but it is common to group multiple channels of
audio data.

--gAqgDYGpNO6m8hZu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRTMwkACgkQJNaLcl1U
h9CpIgf8DGHa33KFaEBu9orPEvy62t4yb0j+p3Xoar2zISlY832/jm9hk/8oYSdy
etd75hsgD7l1/K6l08YwHxuJX07geLoyEnyUakiEi+w4rZVBJ8z/Vj+XN2lV6eq8
VJwUq+kvpY63mjLQodrOLSH9ixNk24ab28aU5CWrw9qUPKfTSLIJLoh9ZkH081eL
nBl+himFtVaWSmQ4+6l9lDNy4VJianGJ6cQI/66k9H0/LMIvj/HGo4DFbCSGzIRu
ZXukxdcZCuH8mI9jHPglgmvaYkjyaAmEW3/89b8F/0lOtOpsoDWjAqWhMJhcphhH
XjquUq/o3sVr1uXMMKdl3fmfUnNhDQ==
=PI/4
-----END PGP SIGNATURE-----

--gAqgDYGpNO6m8hZu--
