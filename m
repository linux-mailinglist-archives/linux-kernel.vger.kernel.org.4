Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2761673F5F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 17:56:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbjASQ4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 11:56:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjASQ42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 11:56:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079F140BE4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 08:56:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9643E61CBF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 16:56:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86B59C433F0;
        Thu, 19 Jan 2023 16:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674147386;
        bh=vYB/POmz1JN7+fktKqVImJWhIUL+Tb69KLQ6YaDjnPo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=STm5w/bIDaPOIla+1JbIRkUG01rkOnnQfRQmlDaJN36z9WUskI+SvWwcHGdp8Syhf
         ygfE+HyZ6Ypfyy1R8RQZryRQVh8HpEnEaIeUre7jU4i3WOWJLm65A0m9wIhQAWvsIs
         upAHBSpdIb5dB/Dp3uXiyZ3V42XV/OOAEdl0srjz/CLGxFj76acbl0LagVtXiTFOYM
         fJ3AoRhQychLuW4/OxiPiVd3alks1nJvNWwk5ucGEzPJ8hXSAFqiiS1DFNu2j6OwdQ
         AgdsyYnKacD4gGyGp8LX5XU/I2kzXe4qwfbMnGpTbtEeASnJrKzcKcIAfoUsXLXy6t
         uJqQDgZpsPPGQ==
Date:   Thu, 19 Jan 2023 16:56:22 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Andreas Pape <apape@de.adit-jv.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] ASoC: pxa: remove
 snd_dmaengine_pcm_open_request_chan()
Message-ID: <Y8l2NgLJsXaPn8ma@sirena.org.uk>
References: <20230118161110.521504-1-arnd@kernel.org>
 <20230118161110.521504-2-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NKZYQGe6T7OEAaOl"
Content-Disposition: inline
In-Reply-To: <20230118161110.521504-2-arnd@kernel.org>
X-Cookie: What is the sound of one hand clapping?
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NKZYQGe6T7OEAaOl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 18, 2023 at 05:10:46PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> The last caller was removed, so there is no longer a need for
> this function.

Please remember to copy me on ASoC patches...

--NKZYQGe6T7OEAaOl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPJdjYACgkQJNaLcl1U
h9DHFgf/YGHiNN/UeGdlqcXqDoYWz91UtKDJMrvyRDgoPumSgpyJHjjnYFXpgTOf
N0q1QMlYAJxDhFBvIzYo+QynGZX77mxiowyC/Lv167/QEouS9QAitd5ggGMYBMrI
qIQIqpEBKwF+dMBih4VfLYjQWYGwrIPzf7/HC4UBTjZ2YmvqxBW9AWxOaS9ZSn3T
nPPdPL5qpdjQmrM4CI3XrK+YJgiuSI4rNnVSFGtnXmuHmqMcTWQy31CdTgt81y7F
TAclI4943noOjH41fR1jAUzuuTq0uEI8NFU/xz27IgJRhaxloi8eg5vAyaY/e+ip
fLMoM2q6WGAJEG9WKZptPrLUCmTIrA==
=O4Ci
-----END PGP SIGNATURE-----

--NKZYQGe6T7OEAaOl--
