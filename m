Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 765E06565A9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 23:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232425AbiLZW5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 17:57:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbiLZW5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 17:57:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD701002
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 14:57:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0B1A3B80DB9
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 22:57:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EAA8C433D2;
        Mon, 26 Dec 2022 22:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672095438;
        bh=Wti5O+00kVoBmzkKswTPUDc+8JKLmMqF4b5CHt77e60=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mM5WMwZZSj4y5reqpjVqwaFFLgUdoLXqlSI/D9TJfClLz9ZQo5/wnnnqUVNc8Y25o
         M0gvOqg3oSboFXCnk7e5VnuFC+29uVViQ6cK/KBXc5BNirjRvcSu2SprbyRkqz4dll
         9x7B0LNEXFtTLfI16iX/MWQKFY8dDWViSrfCVSEfH9cQ5GYYFPn7FAL7YIwrAkVRpC
         N33F6qNE4NV8pjgHQmraElbqgI5P3uLRmqtj+J140r24NriBV8xWK4kHRbuPHOVI6X
         tntGhtlByw2YUl6rw2o7E8lIn3CdQwZF9oUMTi7hhrDGZTkOTk+QB7SshiT33tXtA5
         bu3bd2YHvDggA==
Date:   Mon, 26 Dec 2022 22:57:12 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
Cc:     alsa-devel@alsa-project.org, vsujithkumar.reddy@amd.com,
        Vijendar.Mukunda@amd.com, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, ssabakar@amd.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        Akihiko Odaki <akihiko.odaki@gmail.com>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/5] ASoC: amd: acp: Refactor dai format implementation
Message-ID: <Y6omyPeaZIaGL/EW@sirena.org.uk>
References: <20221220072705.1456908-1-venkataprasad.potturu@amd.com>
 <20221220072705.1456908-4-venkataprasad.potturu@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="h5fGREPqKqgMueed"
Content-Disposition: inline
In-Reply-To: <20221220072705.1456908-4-venkataprasad.potturu@amd.com>
X-Cookie: Noone ever built a statue to a critic.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--h5fGREPqKqgMueed
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 20, 2022 at 12:57:03PM +0530, Venkata Prasad Potturu wrote:
> Refactor dai format implementation in dai_link specific
> snd_soc_ops.

This breaks an x86 allmodconfig build:

/build/stage/linux/sound/soc/amd/acp/acp-mach-common.c: In function =E2=80=
=98acp_card_maxim_hw_params=E2=80=99:
/build/stage/linux/sound/soc/amd/acp/acp-mach-common.c:454:13: error: =E2=
=80=98drvdata=E2=80=99 undeclared (first use in this function)
  454 |         if (drvdata->soc_mclk)
      |             ^~~~~~~
/build/stage/linux/sound/soc/amd/acp/acp-mach-common.c:454:13: note: each u=
ndeclared identifier is reported only once for each function it appears in

--h5fGREPqKqgMueed
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmOqJscACgkQJNaLcl1U
h9A9WAf7BvZ7QNfzBCPPyXGxrXWwjIKX83E0fKopQpPw+AAwbjjH4TCk8gx1hTC6
GGmNtlgTGDgsSUE6+3/CdvcNBJUw0joK+mjaCZBC3oeAwr4Ku/KlQjRqW82S1Hxd
oRT0JlJ/dglR2WhZvgMUlPBbZNLlL0rHuM4ghe8AAfTLBhhigOBQpyFbiYhb2MH8
P2bHd+IQ9U1jVZ8Ejuw5a9XrSHCnbYkpuH9YdaF6HIDGlnTO2f5hT84kbyFBDmtp
/7kva/qQzRGLKOec5sF16sizwnNhK6rb7BY9ByiipGR4RHrWmsdi5Q5bDHyz3RTz
vZj0Wy8cDERGIrsQlX3hnGc5l77Eiw==
=3Fz1
-----END PGP SIGNATURE-----

--h5fGREPqKqgMueed--
