Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A69625FA16D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 17:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbiJJPxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 11:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbiJJPxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 11:53:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1F83207C;
        Mon, 10 Oct 2022 08:53:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A79960FA0;
        Mon, 10 Oct 2022 15:53:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF46BC433D6;
        Mon, 10 Oct 2022 15:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665417220;
        bh=LMeKhxfmAfdwjuQ3iXb8eIas5DAK6CL7U9L+xY2kA6k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eiOYrzJ5l++msOUwryKwXxVCMQwoWdUrtoRvCfAlYcxU1+thvwwJoWxRXzGz3pihQ
         xCgtc+AHvisvr/XI46QwOCJ9vXAqjlBKFwXTl7NYfe5xops+V78FBdliz4xY188BYN
         4j9Y/+pv6T6CYtRUy+81cy1lWuvGmlUBZ2OLYR/MUHXR/ODd4SgRzNBY7tWcVszzfB
         Lk+Z41U/nyjQAuZkXJy03/TLUchAJKa57Sw2GvHlJQFcJIiiOTBRYHoRob0GzBRKKz
         wfKt9ijgvJ4cf2z9ngaJ14pz6aLS5w1ZLTrCBxYiZi0BFwl581wfbegxZtVftBRJqH
         LQ9tLhX77+mUA==
Date:   Mon, 10 Oct 2022 16:53:35 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Siarhei Volkau <lis8215@gmail.com>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-mips@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: codecs: jz4725b: Various improvements and fixes
Message-ID: <Y0Q//+onKu16VQKH@sirena.org.uk>
References: <20221008181655.2747857-1-lis8215@gmail.com>
 <Y0P/u4pJT8rup8Za@sirena.org.uk>
 <CAKNVLfZhH3s=jBWAoSppXSotY9giRRJbub9MqxCtjdZKh4fprg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zP4tF1TsbOA9/jYj"
Content-Disposition: inline
In-Reply-To: <CAKNVLfZhH3s=jBWAoSppXSotY9giRRJbub9MqxCtjdZKh4fprg@mail.gmail.com>
X-Cookie: This sentence no verb.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zP4tF1TsbOA9/jYj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 10, 2022 at 06:20:24PM +0300, Siarhei Volkau wrote:
> =D0=BF=D0=BD, 10 =D0=BE=D0=BA=D1=82. 2022 =D0=B3. =D0=B2 14:19, Mark Brow=
n <broonie@kernel.org>:

> > and will presumably cause problems for any existing configurations...

> I'm curious why this didn't cause problems earlier, as the wrong
> control was used
> for the Master Capture Volume.

The issue is that if someone is relying on the current behaviour and the
control starts doing something completely different they might be
surprised, it at least needs a separate change.

--zP4tF1TsbOA9/jYj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNEP/4ACgkQJNaLcl1U
h9DKlQf/YSQIWB5gynvqXZHjvurY3pBrf82bZh2fiApXWPANyOMBHxVXG2wdg/GZ
+6nAX7UhTnJeSfTK0CoifZkwYXiOPs+qwIi76mcUirMGJU+uxG0G3mXfAu3asRTa
IG+B+uy8RInF2vcUzwamCRSQeMJA/DoiI874PAc4szy+adG1TnYQtX5AFtEjB12R
xt2lOLObkSeEpGIJgj8yMglpHR0+Tu186ojscpvs1JfQBwePULy14fOfOHgcwal0
Ym73bAbOh8HNigz7UXZmiQ8LKLWLnTER+Q7ZEDcjvfSl65jo96GhtnSvJoRMocwr
x7+RmH/x/kDNZa27gVnwfrUsNjH7Dw==
=EaAl
-----END PGP SIGNATURE-----

--zP4tF1TsbOA9/jYj--
