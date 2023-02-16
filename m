Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46E8169987E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 16:15:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjBPPPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 10:15:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjBPPPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 10:15:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1710F3A850
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 07:15:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BE359B824EE
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 15:15:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1602C433EF;
        Thu, 16 Feb 2023 15:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676560543;
        bh=ZsMqIuzb05Ne4ViqazRmOCH133Ieiya5wrDPPquG8/M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aHXcznFkbedVsxumyqDWvT20Y6thvMkFgR8xuI/CfmFCAWTZqXbJDquucbTqFHavj
         HC7A5aXXCUlR7VvU50fCHFvN4eVm0MeyxJjNULMNAQEWJBhAW8QQGNANymkkRNdpIP
         iy0+IMU+sWc4P++3DJ1v6U8gs55ibvgBpqd7+NlxAwctvyaUp4Dfr/0PI7X/IhMOee
         CkWl/MkbS1Y3eN4AVVBodxrOfW9h+swQu2QzDxUklOHMMK50jniWxAQjlIyRK4XomN
         rJ9YbyY/q2x2OiR9ZpM3mGJheuuRvU1w3fLSV9hyt23W3seNtdF+bQMKVi/UcHSJri
         P0tlhyiM+ArRA==
Date:   Thu, 16 Feb 2023 15:15:39 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Lucas Tanure <lucas.tanure@collabora.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH 2/9] ASoC: amd: vangogh: Update code indentation
Message-ID: <Y+5Im/6wsqNQ8FYo@sirena.org.uk>
References: <20230216103300.360016-1-lucas.tanure@collabora.com>
 <20230216103300.360016-3-lucas.tanure@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5riVcraAeE+0JMsT"
Content-Disposition: inline
In-Reply-To: <20230216103300.360016-3-lucas.tanure@collabora.com>
X-Cookie: Serving suggestion.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5riVcraAeE+0JMsT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 16, 2023 at 10:32:53AM +0000, Lucas Tanure wrote:
> Make use of 100 character limit and modify indentation so code is
> easier to read.

I'm having a hard time seeing this as a helpful=20

> While at it:
>  - sort includes in alphabetical order
>  - sort variables declarations by line length
>  - use smaller variables names
>  - remove unnecessary "struct snd_soc_card *card" lines
>  - insert blank lines before return
>  - align defines

This isn't helping make things easier to review :/

> -static int acp5x_8821_startup(struct snd_pcm_substream *substream)
> +static int acp5x_8821_startup(struct snd_pcm_substream *sub)

We do usually refer to substreams as such, I'm not sure this is
really helping.

> -	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
> -				   &constraints_channels);
> +	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS, &co=
nstraints_channels);

I'm having a *really* hard time seeing this as helping with
legibility, it just makes things worse when viewed at 80 columns
but it's hard to see what it helps.  The 100 column limit is
flexibility we can use to avoid contortions but this is fairly
natural.

--5riVcraAeE+0JMsT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPuSJsACgkQJNaLcl1U
h9Bkpgf9He+GgisvMXfHzovOeUmaexSlr7cC8udBT98h0ba00jKK6TKSwlhxQbC9
P42L20e/Zorz014nCe42Srv9gRCllVenYG0lQZbIJ567xRuW02yP5pPHIcxJunRE
3JNtDONZ5pxl/rJC1A/wGpPTQRVCYcudtimB3jYTTx29/8Brfv+HzWNOCHOgQvn5
9Zw6Xo1wXSOhC3qQBHs3N8iQfyL6RJ2KRZ18twgw3aWTNs1yu9rBA2/hQEfSDJk1
JEvlWx+q3uIta3UFMmLiaIYScpW1S7KkIOdQNN1x/0kMiVSvszC94L2eo+K/OS+c
Ka2Q4PN+/taP2AnLQSmn1FhyqZ7DjA==
=onrk
-----END PGP SIGNATURE-----

--5riVcraAeE+0JMsT--
