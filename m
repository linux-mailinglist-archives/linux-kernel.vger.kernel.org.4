Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C05B68A213
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 19:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233573AbjBCSgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 13:36:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232601AbjBCSga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 13:36:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D19ADB9E;
        Fri,  3 Feb 2023 10:36:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A698761FA7;
        Fri,  3 Feb 2023 18:36:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4562CC433EF;
        Fri,  3 Feb 2023 18:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675449384;
        bh=ePl6R2Z+U5EHaRXvuobFDAMBenFfo2gdDC6EXMOostQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ieOio1op3VDdUsLP8MuNow5b11ORT9/xaHY6V2pBjy6+ROxIUaws1B70echyk+Btw
         aT/D6Aa3RfvxIAyq8/Uu/5STfZc98vNfGwImVYLalD5I3/+qmfCAUAFczkl54hilVZ
         uPY/fiVu1Nl5wuU0vKXNAEahixuv1Iy5Sy4F2kAweiTeVQoLS9qwWEMrbxurmByl52
         cQ3gabMg2Q0umYDZqGAm9NmbwIXkWub8MlhTAP2TBug1ReW6tq0FXt42uKwBjA3aE1
         VKwI8DIregMT0a6OWVghtr0B6ylUDpiTGlpEIeEEQGMn9LqnbAnfwWllKg6UqEcV80
         vDG9GI8F/nxCQ==
Date:   Fri, 3 Feb 2023 18:36:18 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] ASoC: uapi: Replace zero-length arrays with
 __DECLARE_FLEX_ARRAY() helper
Message-ID: <Y91UIilZDWpivkWL@sirena.org.uk>
References: <YzIzUjUuJKf0mkKg@work>
 <fcd83e77-a3fb-9061-771a-8509ea6f5950@embeddedor.com>
 <Y9wmnfTi/p4FuRmd@sirena.org.uk>
 <bb43c410-bd8c-66fe-19a1-0f41442838eb@embeddedor.com>
 <Y90ExljX2qCsowhu@sirena.org.uk>
 <652684af-bd10-99da-1ed8-104407493428@embeddedor.com>
 <Y90P3kik6ONZg3U4@sirena.org.uk>
 <63dd3676.170a0220.1f1b2.3244@mx.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Ujqo4SKGI187lzYk"
Content-Disposition: inline
In-Reply-To: <63dd3676.170a0220.1f1b2.3244@mx.google.com>
X-Cookie: No animals were injured.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Ujqo4SKGI187lzYk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 03, 2023 at 04:29:41PM +0000, Kees Cook wrote:
> On Fri, Feb 03, 2023 at 01:45:02PM +0000, Mark Brown wrote:

> > Sure, feel free to send an update...

> Is this accurate?

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7f86d02cb427..e21a3412a546 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19564,6 +19564,8 @@ F:	Documentation/devicetree/bindings/sound/
>  F:	Documentation/sound/soc/
>  F:	include/dt-bindings/sound/
>  F:	include/sound/soc*
> +F:	include/sound/sof/
> +F:	include/uapi/sound/asoc.h
>  F:	sound/soc/

Might be missing stuff but those are both good additions.  Looks like
the SOF directory also wants adding to the SOF section in MAINTAINERS.

--Ujqo4SKGI187lzYk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPdVCEACgkQJNaLcl1U
h9DNJAf/bOYTwqW5lCeVbfFOqegYJX6nmDSYygowWljR5/yeojsBy3C913YfFDa6
5nkc+BgEfXYvBqtbSZkFbdc3KAiPOqnJAS26hlMXEWTlBdXVemgtMTNcMQWD7Fd8
dUe55m51zv5vky5OWQlNyROBKL5a3IQbhmg33QYidg+1KPJlCyk7ETZmRUt5AI99
W9ZM9JHoZDRAoWRF0dXHez76XFHJ2qjpEZpaOHy0BbjO2ppI4+v7/H2ysESBDMLD
Q2y8ExyBAQMUl2TNvmPGMASMvfWK2cf9EZLT2q5QCDEML9mtAAY8AWuVy1xLfyad
swhz49NJ4271bdmiCnsLenkwEcwzEQ==
=cmyM
-----END PGP SIGNATURE-----

--Ujqo4SKGI187lzYk--
