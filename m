Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 069DF61F3CF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 13:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232045AbiKGM5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 07:57:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbiKGM5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 07:57:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA991C408
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 04:57:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A82B60FC9
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 12:57:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2421EC433C1;
        Mon,  7 Nov 2022 12:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667825832;
        bh=oP+JPXoslvHNR0TTVU1Dte4Ism/jYEesbm6/BE1mmT8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gewiH/8+x2rGTKI0lQrYNA2/19tuJyxggTIJ/tNzPW9Nhn2JcZJhXrLyWM4aBoRsC
         zHWrDffZwmhuIZV5VukfJUNSgf4RYlPlof9tCdoHn0uFZWQlaO2bCmbQBe7mB6xcah
         u1gCXcMeO6fgYnMOv1zVIWaQMkvrvztBH0iC1r7IjjBKni/KZ0Z8/OnkyOiZFlWu5T
         aoo1Ri/DrycnHMKljlNBbX+oK0Qd1PHuSk6sYl63FMdk/n6RcKgnAI1WMudNJW43Io
         //crGdIgpQRdbJbt3QIb79zT6qZmPt3xzdjcP8JnVaOxuziPgpSSBkzP4wRlYpQwIm
         hP108ZCUT/isQ==
Date:   Mon, 7 Nov 2022 12:57:05 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH] ASoC: dapm: Don't use prefix for regulator name
Message-ID: <Y2kAoV8gCEZZgHhk@sirena.org.uk>
References: <20221025150149.113129-1-paul@crapouillou.net>
 <166680764848.867857.6473365992161385316.b4-ty@kernel.org>
 <C32ZKR.QZWY19EUAOMQ3@crapouillou.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9pqHOd81BkRAIKBK"
Content-Disposition: inline
In-Reply-To: <C32ZKR.QZWY19EUAOMQ3@crapouillou.net>
X-Cookie: Minimum charge for booths.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9pqHOd81BkRAIKBK
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 07, 2022 at 09:52:24AM +0000, Paul Cercueil wrote:
> Le mer. 26 oct. 2022 =E0 19:07:28 +0100, Mark Brown <broonie@kernel.org> a

> > Applied to
> >=20
> >    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git
> > for-next

> Small reminder that this is a fix for a bug introduced in -rc1, so it sho=
uld
> be queued for the next RC.

This is already queued as a fix.

--9pqHOd81BkRAIKBK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNpAKAACgkQJNaLcl1U
h9Cv3wf+KPQHMGjS4/PjmYrHL2ocPHd0llgWsbyhCly7rMc+yx9BF5rOn6gSD/kS
+0JVk2FBoXw3GS3dEyW1hlMTwCp5Xp9W24oa641HM6lZK1xApYx5Kyg1xGleHUze
Tz0H8FcMOaWZeOlQH7t0iDQ5krvkXkRv0syiKCvvJbsGfNMJQaowXmqK64zP6/Dv
a+tqPspU0uNFGnNeA3G3rr8o2uzluFzMWSUuVG27qOEEzM3o+JsomgsdCQyNAL7R
uT6mB70x/rlazWllX2+NtZkVPi88TH21TLiB1zUW0vrxJiNTFFAGZVdQCuWzzgBk
ApO+L4p5lvjLPngfYitQah6sH/C/0Q==
=UOGo
-----END PGP SIGNATURE-----

--9pqHOd81BkRAIKBK--
