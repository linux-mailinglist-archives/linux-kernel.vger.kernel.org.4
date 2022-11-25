Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83E43639048
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 20:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiKYTc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 14:32:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiKYTcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 14:32:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46D925E9B
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 11:32:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5E5F2B82BF6
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 19:32:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54959C433C1;
        Fri, 25 Nov 2022 19:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669404768;
        bh=Y1v9FWURYksz9fHen0arQZhYPgnLZQsNKuoyVGBXZq4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eUkFs1PyOK7NxweBivmv9oCAe3TneIQBDZJEGTiN3JoJR7ydosNdqZ2risWTsxqct
         SqyFIbHJpGSQaEQO1Wn6hmCAMwU/C/VFg5YJ59UxDXPhAGNCgO8BEDkj0cyOPNO5YM
         wP7gHKsvvzjN7Xt6OQ/rLrcPksHpHa3OiL529NGZyLEqR8Ac2m9DhCig0qdicj2nmr
         3/BMT9jWEvJCc/RmhZ3SQujeAfZ1RovrycD0Wl4vvXGmqbS97WFllAdblRqI/0MMRm
         08q6P2JwWCXUiGaCmGSV3d/lpQwSuzvMjNm+5BOnJHZV7SSuHW5LIStb7V52V5naJO
         /KSKcVaToLtTQ==
Date:   Fri, 25 Nov 2022 19:32:43 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Maarten Zanders <maarten.zanders@mind.be>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] ASoC: adau1372: add support for S24_LE mode
Message-ID: <Y4EYWwS/TSHtS6YY@sirena.org.uk>
References: <20221028152626.109603-1-maarten.zanders@mind.be>
 <20221028152626.109603-3-maarten.zanders@mind.be>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CTm34KFJgvYlATpl"
Content-Disposition: inline
In-Reply-To: <20221028152626.109603-3-maarten.zanders@mind.be>
X-Cookie: Dr. Jekyll had something to Hyde.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CTm34KFJgvYlATpl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 28, 2022 at 05:26:24PM +0200, Maarten Zanders wrote:
> The ADAU1372 contains 24bit ADCs and DACs. Allow the driver to use
> its native mode which uses the same settings as the current 32 bit
> mode.

Normally new features like this should come at the end of the series so
that they don't get in the way of merging fixes.  No need to resend for
this though.

--CTm34KFJgvYlATpl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmOBGFoACgkQJNaLcl1U
h9D3Mwf+KPSYbzaBMaX8a1l1Rw5piPOad6g17prchlI0G/6S31mIMHcY7jyePJC7
SEzaZEsa7A6UZEsCKLnhLRwvPm1322RIpscb3u/XOrKfgWtMEKItKnpz9vsK10DB
u/CPeSF8Rju7br3b2fVlfK6DfI+JV5SqMr9D/T2XaHmei7BGkHshaRObT2ehGJAI
VnXneT2lJm+XQ8dqjt1wNnwbnGINbxxZYq6tjzLsI3MbybVepH1c9yIDkNS3yGdX
dZPKQ1zHpXGH7JvH0ZuE9u8SjOPrzzS0qPOHZ0iCeKmb+d6ezsWCYKQw9T3MBdc3
G39JtZ4DX1IPV6I94BZeErpOFmiWEA==
=Isv5
-----END PGP SIGNATURE-----

--CTm34KFJgvYlATpl--
